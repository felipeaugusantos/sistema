unit untMotEntregas;

interface

uses Classes, frxClass, Uni, DB,  UniClientDataSet, DBClient, untTypesSistema, untConstantes;

type
  TEntregas = class
    private
      FQryMotoristas: TUniQuery;

      procedure pCriaClientMotorista(AExisteClient: Boolean = False; ACodMot: String = '');
      procedure pGravaLogEntrega(ACodMot, ASitAnt, ASitAtu: String);

      function fCarregarDocumentosSemEntregaVinculada(AEspeciesPermitidas: String = ''): String;
      function fCarregarDocumentosVinculadosPendentesEntrega(ACodMot: String = ''; AEspeciesPermitidas: String = ''): String;
    public
      FCdsMotoristas: TUniClientDataSet;
      FQryDocumentos: TUniQuery;

      procedure pCarregaDocumentos(AOpcaoDoc: TDocEntrega = DocTodos; ACodMot: String = ''; AEspeciesPermitidas: String = '');
      procedure pCarregaMotoristas(AExisteClient: Boolean = False; ACodMot: String = '');
      procedure pAlteraSituacaoMotorista(ACodMot, ASitAnt, ASitAtu: String);

      function fRegistraPartida(ADocumentos, ACodMot: String): Boolean;
      function fRegistraChegada(ADocumentos, AEntregas, ACodMot: String; var ABaixouTodosDocumentos: Boolean): Boolean;
      function fRemoveDocumentos(ADocumentos, ACodMot: String; AEntregas: TStringList; var ARemoveuTodosDocumentos: Boolean): Boolean;
      function fDocumentoTemEntregaVinculada(AAutInc: String): Boolean;

      constructor Create;
      destructor Destroy; Override;
  end;

implementation

uses SysUtils, Variants, untFuncoesSimples, StrUtils;


{ TEntregas }

constructor TEntregas.Create;
begin
  FQryMotoristas := fCriaQuery(Nil);
  FQryDocumentos := fCriaQuery(Nil);

  FCdsMotoristas := TUniClientDataSet.Create(Nil);
end;

destructor TEntregas.Destroy;
begin
  FreeAndNil(FCdsMotoristas);
  FreeAndNil(FQryMotoristas);
  FreeAndNil(FQryDocumentos);

  inherited;
end;

function TEntregas.fCarregarDocumentosSemEntregaVinculada(AEspeciesPermitidas: String = ''): String;
var
  LstlDocumento: TStringList;
begin
  LstlDocumento := TStringList.Create;

  try
    LstlDocumento.Clear;
    LstlDocumento.Add('SELECT MOVGER.GER_NUMDOC, MOVGER.GER_ESPDOC, MOVGER.GER_CODEMP, CADCLI.CLI_CODCLI, CADCLI.CLI_NOMCLI, CADOPE.OPE_CODOPE,');
    LstlDocumento.Add('       CONCAT(IF(IFNULL(CADCLI.CLI_FONE01, "") = "", "", ' + fFormataFoneSQL('CADCLI.CLI_FONE01', '', False) + '), ');
    LstlDocumento.Add('              IF(IFNULL(CADCLI.CLI_FONE02, "") = "", "", CONCAT(" / ", ' + fFormataFoneSQL('CADCLI.CLI_FONE02', '', False) + ')), ');
    LstlDocumento.Add('              IF(IFNULL(CADCLI.CLI_CELULA, "") = "", "", CONCAT(" / ", ' + fFormataFoneSQL('CADCLI.CLI_CELULA', '', False) + '))) AS TELEFONES, ');
    LstlDocumento.Add('       CADOPE.OPE_NOMOPE, MOVGER.GER_VLRCON, MOVGER.GER_DTAENT, MOVGER.GER_HORENT, MOVGER.GER_ENDCON, MOVGER.GER_BAICON, CADREG.REG_DESREG,');
    LstlDocumento.Add('       MOVGER.GER_DTLBEX, MOVGER.GER_HRLBEX, CADMOT.MOT_CODMOT, CADMOT.MOT_NOMMOT, COMENG.ENG_DTACAD, COMENG.ENG_HRACAD,');
    LstlDocumento.Add('       MOVGER.GER_MENEXP, MOVGER.GER_MENEX2, MOVGER.GER_MENEX3, MOVGER.GER_MENEX4, COMENG.ENG_OBSERV, MOVGER.AUTOINCREM,');
    LstlDocumento.Add('       COMEND.AUTOINCREM AS INCREMCOMEND, END_SEQENG,');
    LstlDocumento.Add('CONCAT(MOVGER.GER_NUMDOC,"-",MOVGER.GER_ESPDOC,"-",MOVGER.GER_CODEMP) AS DOCUMENTO,');
    LstlDocumento.Add('CONCAT(CADCLI.CLI_CODCLI,"-",CADCLI.CLI_NOMCLI) AS CLIENTE,');
    LstlDocumento.Add('CONCAT(CADOPE.OPE_CODOPE,"-",CADOPE.OPE_NOMOPE) AS VENDEDOR,');
    LstlDocumento.Add('CONCAT(CADMOT.MOT_CODMOT,"-",CADMOT.MOT_NOMMOT) AS ENTREGADOR,');
    LstlDocumento.Add('CAST(CONCAT(DATE_FORMAT(MOVGER.GER_DTAENT, "%d/%m/%Y")," - ",DATE_FORMAT(MOVGER.GER_HORENT, "%H:%i:%s")) AS CHAR(21)) AS DATAHORADOC,');
    LstlDocumento.Add('CAST(CONCAT(DATE_FORMAT(MOVGER.GER_DTLBEX, "%d/%m/%Y")," - ",DATE_FORMAT(MOVGER.GER_HRLBEX, "%H:%i:%s")) AS CHAR(21)) AS SEPARACAO,');
    LstlDocumento.Add('CAST(CONCAT(DATE_FORMAT(COMENG.ENG_DTACAD, "%d/%m/%Y")," - ",DATE_FORMAT(COMENG.ENG_HRACAD, "%H:%i:%s")) AS CHAR(21)) AS SAIDA,');
    LstlDocumento.Add('CAST(0 AS SIGNED) AS MARDES,');
    LstlDocumento.Add('CADCLI.CLI_FANSOB AS FANSOB,');
    LstlDocumento.Add('CADCND.CND_DESCRI AS CONPAG');
    LstlDocumento.Add('FROM MOVGER');
    LstlDocumento.Add('LEFT JOIN COMEND');
    LstlDocumento.Add('ON(MOVGER.GER_NUMDOC = COMEND.END_NUMDOC AND MOVGER.GER_ESPDOC = COMEND.END_ESPDOC AND MOVGER.GER_CODEMP = COMEND.END_EMPDOC ');
    LstlDocumento.Add('AND MOVGER.GER_CODCLI = COMEND.END_CODCLI)');
    LstlDocumento.Add('LEFT JOIN COMENG');
    LstlDocumento.Add('ON(COMEND.END_SEQENG = COMENG.AUTOINCREM)');
    LstlDocumento.Add('LEFT JOIN CADMOT');
    LstlDocumento.Add('ON(COMENG.ENG_CODENT = CADMOT.MOT_CODMOT)');
    LstlDocumento.Add('LEFT JOIN CADCLI');
    LstlDocumento.Add('ON(MOVGER.GER_CODCLI = CADCLI.CLI_CODCLI) ');
    LstlDocumento.Add('LEFT JOIN CADOPE');
    LstlDocumento.Add('ON(MOVGER.GER_CODVEN = CADOPE.OPE_CODOPE)');
    LstlDocumento.Add('LEFT JOIN AUXMOV');
    LstlDocumento.Add('ON (AUXMOV.AUX_SEQGER = MOVGER.AUTOINCREM)');
    LstlDocumento.Add('LEFT JOIN ENTCLI');
    LstlDocumento.Add('ON (ENTCLI.AUTOINCREM  = AUXMOV.AUX_ENTGER)');
    LstlDocumento.Add('LEFT JOIN CADREG');
    LstlDocumento.Add('ON (CADREG.REG_CODREG = IF(ENTCLI.ETC_CODREG IS NULL, CADCLI.CLI_CODREG, ENTCLI.ETC_CODREG))');
    LstlDocumento.Add('LEFT JOIN CADCND');
    LstlDocumento.Add('ON(CADCND.CND_CODIGO = MOVGER.GER_CODCND)');
    LstlDocumento.Add('WHERE MOVGER.GER_TIP_FC = "C"');
    LstlDocumento.Add('AND MOVGER.GER_ORIDOC = "V"');
    LstlDocumento.Add('AND MOVGER.GER_CLAFIS > "5000"');
    LstlDocumento.Add('AND MOVGER.GER_ENTFAT = "S"');
    LstlDocumento.Add('AND MOVGER.GER_NUMROM IS NULL');
    LstlDocumento.Add('AND MOVGER.GER_CODEMP = :CODEMP');
    LstlDocumento.Add('AND NOT EXISTS                                   ');
    LstlDocumento.Add('(SELECT                                          ');
    LstlDocumento.Add('  *                                              ');
    LstlDocumento.Add(' FROM                                            ');
    LstlDocumento.Add('   COMEND                                        ');
    LstlDocumento.Add(' WHERE MOVGER.GER_NUMDOC = COMEND.END_NUMDOC     ');
    LstlDocumento.Add('       AND MOVGER.GER_ESPDOC = COMEND.END_ESPDOC ');
    LstlDocumento.Add('       AND MOVGER.GER_CODEMP = COMEND.END_EMPDOC ');
    LstlDocumento.Add('       AND MOVGER.GER_CODCLI = COMEND.END_CODCLI)');

    If not fEmptyStr(AEspeciesPermitidas) Then
      LstlDocumento.Add('AND LOCATE(MOVGER.GER_ESPDOC, '+QuotedStr(AEspeciesPermitidas)+') > 0');

    Result := LstlDocumento.Text;
  finally
    FreeAndNil(LstlDocumento);
  end;
end;

function TEntregas.fCarregarDocumentosVinculadosPendentesEntrega(ACodMot: String = ''; AEspeciesPermitidas: String = ''): String;
var
  LstlDocumento: TStringList;
begin
  LstlDocumento := TStringList.Create;

  try
    LstlDocumento.Clear;
    LstlDocumento.Add('SELECT MOVGER.GER_NUMDOC, MOVGER.GER_ESPDOC, MOVGER.GER_CODEMP, CADCLI.CLI_CODCLI, CADCLI.CLI_NOMCLI, CADOPE.OPE_CODOPE,');
    LstlDocumento.Add('       CONCAT(IF(IFNULL(CADCLI.CLI_FONE01, "") = "", "", ' + fFormataFoneSQL('CADCLI.CLI_FONE01', '', False) + '), ');
    LstlDocumento.Add('              IF(IFNULL(CADCLI.CLI_FONE02, "") = "", "", CONCAT(" / ", ' + fFormataFoneSQL('CADCLI.CLI_FONE02', '', False) + ')), ');
    LstlDocumento.Add('              IF(IFNULL(CADCLI.CLI_CELULA, "") = "", "", CONCAT(" / ", ' + fFormataFoneSQL('CADCLI.CLI_CELULA', '', False) + '))) AS TELEFONES, ');
    LstlDocumento.Add('       CADOPE.OPE_NOMOPE, MOVGER.GER_VLRCON, MOVGER.GER_DTAENT, MOVGER.GER_HORENT, MOVGER.GER_ENDCON, MOVGER.GER_BAICON, CADREG.REG_DESREG,');
    LstlDocumento.Add('       MOVGER.GER_DTLBEX, MOVGER.GER_HRLBEX, CADMOT.MOT_CODMOT, CADMOT.MOT_NOMMOT, COMENG.ENG_DTACAD, COMENG.ENG_HRACAD,');
    LstlDocumento.Add('       MOVGER.GER_MENEXP, MOVGER.GER_MENEX2, MOVGER.GER_MENEX3, MOVGER.GER_MENEX4, COMENG.ENG_OBSERV, MOVGER.AUTOINCREM,');
    LstlDocumento.Add('       COMEND.AUTOINCREM AS INCREMCOMEND, END_SEQENG,');
    LstlDocumento.Add('CONCAT(MOVGER.GER_NUMDOC,"-",MOVGER.GER_ESPDOC,"-",MOVGER.GER_CODEMP) AS DOCUMENTO,');
    LstlDocumento.Add('CONCAT(CADCLI.CLI_CODCLI,"-",CADCLI.CLI_NOMCLI) AS CLIENTE,');
    LstlDocumento.Add('CONCAT(CADOPE.OPE_CODOPE,"-",CADOPE.OPE_NOMOPE) AS VENDEDOR,');
    LstlDocumento.Add('CONCAT(CADMOT.MOT_CODMOT,"-",CADMOT.MOT_NOMMOT) AS ENTREGADOR,');
    LstlDocumento.Add('CAST(CONCAT(DATE_FORMAT(MOVGER.GER_DTAENT, "%d/%m/%Y")," - ",DATE_FORMAT(MOVGER.GER_HORENT, "%H:%i:%s")) AS CHAR(21)) AS DATAHORADOC,');
    LstlDocumento.Add('CAST(CONCAT(DATE_FORMAT(MOVGER.GER_DTLBEX, "%d/%m/%Y")," - ",DATE_FORMAT(MOVGER.GER_HRLBEX, "%H:%i:%s")) AS CHAR(21)) AS SEPARACAO,');
    LstlDocumento.Add('CAST(CONCAT(DATE_FORMAT(COMENG.ENG_DTACAD, "%d/%m/%Y")," - ",DATE_FORMAT(COMENG.ENG_HRACAD, "%H:%i:%s")) AS CHAR(21)) AS SAIDA,');
    LstlDocumento.Add('CAST(0 AS SIGNED) AS MARDES,');
    LstlDocumento.Add('CADCLI.CLI_FANSOB AS FANSOB,');
    LstlDocumento.Add('CADCND.CND_DESCRI AS CONPAG');
    LstlDocumento.Add('FROM MOVGER');
    LstlDocumento.Add('INNER JOIN COMEND');
    LstlDocumento.Add('ON(MOVGER.GER_NUMDOC = COMEND.END_NUMDOC AND MOVGER.GER_ESPDOC = COMEND.END_ESPDOC AND MOVGER.GER_CODEMP = COMEND.END_EMPDOC ');
    LstlDocumento.Add('AND MOVGER.GER_CODCLI = COMEND.END_CODCLI)');
    LstlDocumento.Add('INNER JOIN COMENG');
    LstlDocumento.Add('ON(COMEND.END_SEQENG = COMENG.AUTOINCREM)');
    LstlDocumento.Add('INNER JOIN CADMOT');
    LstlDocumento.Add('ON(COMENG.ENG_CODENT = CADMOT.MOT_CODMOT)');
    LstlDocumento.Add('LEFT JOIN CADCLI');
    LstlDocumento.Add('ON(MOVGER.GER_CODCLI = CADCLI.CLI_CODCLI) ');
    LstlDocumento.Add('LEFT JOIN CADOPE');
    LstlDocumento.Add('ON(MOVGER.GER_CODVEN = CADOPE.OPE_CODOPE)');
    LstlDocumento.Add('LEFT JOIN AUXMOV');
    LstlDocumento.Add('ON (AUXMOV.AUX_SEQGER = MOVGER.AUTOINCREM)');
    LstlDocumento.Add('LEFT JOIN ENTCLI');
    LstlDocumento.Add('ON (ENTCLI.AUTOINCREM  = AUXMOV.AUX_ENTGER)');
    LstlDocumento.Add('LEFT JOIN CADREG');
    LstlDocumento.Add('ON (CADREG.REG_CODREG = IF(ENTCLI.ETC_CODREG IS NULL, CADCLI.CLI_CODREG, ENTCLI.ETC_CODREG))');
    LstlDocumento.Add('LEFT JOIN CADCND');
    LstlDocumento.Add('ON(CADCND.CND_CODIGO = MOVGER.GER_CODCND)');
    LstlDocumento.Add('WHERE MOVGER.GER_TIP_FC = "C"');
    LstlDocumento.Add('AND MOVGER.GER_ORIDOC = "V"');
    LstlDocumento.Add('AND MOVGER.GER_CLAFIS > "5000"');
    LstlDocumento.Add('AND MOVGER.GER_ENTFAT = "S"');
    LstlDocumento.Add('AND MOVGER.GER_NUMROM IS NULL');
    LstlDocumento.Add('AND COMEND.END_DTABAI IS NULL');
    LstlDocumento.Add('AND COMEND.END_HRABAI IS NULL');
    LstlDocumento.Add('AND CADMOT.MOT_STATUS = "A"');
    LstlDocumento.Add('AND MOVGER.GER_CODEMP = :CODEMP');

    If not fEmptyStr(AEspeciesPermitidas) Then
      LstlDocumento.Add('AND LOCATE(MOVGER.GER_ESPDOC, '+QuotedStr(AEspeciesPermitidas)+') > 0');

    if not fEmptyStr(ACodMot) then
    begin
      LstlDocumento.Add('AND CADMOT.MOT_CODMOT = :CODMOT');
    end;

    Result := LstlDocumento.Text;
  finally
    FreeAndNil(LstlDocumento);
  end;
end;

function TEntregas.fDocumentoTemEntregaVinculada(AAutInc: String): Boolean;
var
  LQryEntrega: TUniQuery;
begin
  LQryEntrega := fCriaQuery;

  try
    LQryEntrega.Close;
    LQryEntrega.SQL.Clear;
    LQryEntrega.SQL.Add('SELECT MOVGER.AUTOINCREM');
    LQryEntrega.SQL.Add('FROM MOVGER');
    LQryEntrega.SQL.Add('INNER JOIN COMEND');
    LQryEntrega.SQL.Add('ON(GER_NUMDOC = END_NUMDOC AND GER_ESPDOC = END_ESPDOC AND GER_CODEMP = END_EMPDOC AND GER_CODCLI = END_CODCLI)');
    LQryEntrega.SQL.Add('WHERE MOVGER.AUTOINCREM = :AUTINC');
    LQryEntrega.ParamByName('AUTINC').AsString := AAutInc;
    LQryEntrega.Open;

    Result := Not LQryEntrega.IsEmpty;
  finally
    FreeAndNil(LQryEntrega);
  end;
end;

function TEntregas.fRegistraChegada(ADocumentos, AEntregas, ACodMot: String; var ABaixouTodosDocumentos: Boolean): Boolean;
var
  LQryDocumentos: TUniQuery;
  LQryEntregas: TUniQuery;
  LQryRegistra: TUniQuery;
  LQryBaixados: TUniQuery;
begin
  Result := False;
  ABaixouTodosDocumentos := False;

  if fEmptyStr(ADocumentos) then
    Exit;

  if fEmptyStr(AEntregas) then
    Exit;

  if fEmptyStr(ACodMot) then
    Exit;

  LQryDocumentos := fCriaQuery;
  LQryEntregas := fCriaQuery;
  LQryRegistra := fCriaQuery;
  LQryBaixados := fCriaQuery;

  try
    try
      fStartTransaction;

      LQryDocumentos.Close;
      LQryDocumentos.SQL.Clear;
      LQryDocumentos.SQL.Add('SELECT END_SEQENG, COUNT(END_SEQENG) AS TOTAL');
      LQryDocumentos.SQL.Add('FROM COMEND');
      LQryDocumentos.SQL.Add('WHERE AUTOINCREM IN('+ADocumentos+')');
      LQryDocumentos.SQL.Add('GROUP BY END_SEQENG');
      LQryDocumentos.Open;
      LQryDocumentos.First;

      LQryEntregas.Close;
      LQryEntregas.SQL.Clear;
      LQryEntregas.SQL.Add('SELECT END_SEQENG, COUNT(END_SEQENG) AS TOTAL');
      LQryEntregas.SQL.Add('FROM COMEND');
      LQryEntregas.SQL.Add('WHERE END_SEQENG IN('+AEntregas+')');
      LQryEntregas.SQL.Add('AND END_DTABAI IS NULL');
      LQryEntregas.SQL.Add('AND END_HRABAI IS NULL');
      LQryEntregas.SQL.Add('GROUP BY END_SEQENG');
      LQryEntregas.Open;
      LQryEntregas.First;

      LQryRegistra.Close;
      LQryRegistra.SQL.Clear;
      LQryRegistra.SQL.Add('UPDATE COMENG');
      LQryRegistra.SQL.Add('SET ENG_DTABAI = :DTABAI,');
      LQryRegistra.SQL.Add('    ENG_HRABAI = :HRABAI');
      LQryRegistra.SQL.Add('WHERE AUTOINCREM = :AUTINC');

      while not LQryDocumentos.Eof do
      begin
        if LQryEntregas.Locate('END_SEQENG', LQryDocumentos.FieldByName('END_SEQENG').AsString, []) then
        begin
          if LQryEntregas.FieldByName('TOTAL').AsInteger = LQryDocumentos.FieldByName('TOTAL').AsInteger then
          begin
            LQryRegistra.Close;
            LQryRegistra.ParamByName('DTABAI').AsDate := fRetDataServidor;
            LQryRegistra.ParamByName('HRABAI').AsTime := fRetHoraServidor;
            LQryRegistra.ParamByName('AUTINC').AsString := LQryDocumentos.FieldByName('END_SEQENG').AsString;
            LQryRegistra.ExecSQL;
          end;
        end;

        LQryDocumentos.Next;
      end;

      LQryRegistra.Close;
      LQryRegistra.SQL.Clear;
      LQryRegistra.SQL.Add('UPDATE COMEND');
      LQryRegistra.SQL.Add('SET END_DTABAI = :DTABAI,');
      LQryRegistra.SQL.Add('    END_HRABAI = :HRABAI');
      LQryRegistra.SQL.Add('WHERE AUTOINCREM IN ('+ADocumentos+')');
      LQryRegistra.ParamByName('DTABAI').AsDate := fRetDataServidor;
      LQryRegistra.ParamByName('HRABAI').AsTime := fRetHoraServidor;
      LQryRegistra.ExecSQL;

      LQryBaixados.Close;
      LQryBaixados.SQL.Clear;
      LQryBaixados.SQL.Add('SELECT ENG_PROENT');
      LQryBaixados.SQL.Add('FROM COMENG');
      LQryBaixados.SQL.Add('WHERE ENG_CODEMP = :CODEMP');
      LQryBaixados.SQL.Add('AND ENG_CODENT = :CODMOT');
      LQryBaixados.SQL.Add('AND ENG_DTABAI IS NULL');
      LQryBaixados.SQL.Add('AND ENG_HRABAI IS NULL');
      LQryBaixados.ParamByName('CODEMP').AsString := VS_strCodEmp;
      LQryBaixados.ParamByName('CODMOT').AsString := ACodMot;
      LQryBaixados.Open;

      ABaixouTodosDocumentos := LQryBaixados.IsEmpty;

      fCommit;

      Result := True;
    except
      On E: Exception Do
      begin
        fRollBack;
        Result := False;
        pMensagensErro('Erro ao registrar chegada!' + E.Message,'[Registrar chegada]');
      end;
    end;
  finally
    FreeAndNil(LQryDocumentos);
    FreeAndNil(LQryEntregas);
    FreeAndNil(LQryRegistra);
    FreeAndNil(LQryBaixados);
  end;
end;

function TEntregas.fRegistraPartida(ADocumentos, ACodMot: String): Boolean;
var
  LQryEntrega: TUniQuery;
  LQryDocumentos: TUniQuery;
  LAutInc: String;
begin
  Result := False;

  if fEmptyStr(ADocumentos) then
    Exit;

  if fEmptyStr(ACodMot) then
    Exit;

  LQryEntrega := fCriaQuery;
  LQryDocumentos := fCriaQuery;

  try
    try
      fStartTransaction;

      LAutInc := fRetAutoIncrem('COMENG', VS_strCodEmp);

      LQryEntrega.Close;
      LQryEntrega.SQL.Clear;
      LQryEntrega.SQL.Add('INSERT INTO COMENG(AUTOINCREM, ENG_PROENT, ENG_CODEMP, ENG_CODENT, ENG_PLAVEI, ENG_DTACAD, ENG_HRACAD)');
      LQryEntrega.SQL.Add('VALUES(:AUTINC, :PROENT, :CODEMP, :CODENT, :PLAVEI, :DTACAD, :HRACAD)');
      LQryEntrega.ParamByName('AUTINC').AsString := LAutInc;
      LQryEntrega.ParamByName('PROENT').AsString := fAtualizaProCod('COMENG', 'ENG_PROENT');
      LQryEntrega.ParamByName('CODEMP').AsString := VS_strCodEmp;
      LQryEntrega.ParamByName('CODENT').AsString := ACodMot;
      LQryEntrega.ParamByName('PLAVEI').AsString := fCampoTabela('MOT_PLAVEI', 'CADMOT', ['MOT_CODMOT'], [ACodMot], False);
      LQryEntrega.ParamByName('DTACAD').AsDate := fRetDataServidor;
      LQryEntrega.ParamByName('HRACAD').AsTime := fRetHoraServidor;
      LQryEntrega.ExecSQL;

      LQryDocumentos.Close;
      LQryDocumentos.SQL.Clear;
      LQryDocumentos.SQL.Add('SELECT GER_NUMDOC, GER_ESPDOC, GER_CODEMP, GER_CODCLI');
      LQryDocumentos.SQL.Add('FROM MOVGER');
      LQryDocumentos.SQL.Add('WHERE AUTOINCREM IN('+ADocumentos+')');
      LQryDocumentos.Open;
      LQryDocumentos.First;

      LQryEntrega.Close;
      LQryEntrega.SQL.Clear;
      LQryEntrega.SQL.Add('INSERT INTO COMEND(AUTOINCREM, END_SEQENG, END_CODEMP, END_NUMDOC, END_ESPDOC, END_EMPDOC, END_CODCLI)');
      LQryEntrega.SQL.Add('VALUES(:AUTINC, :SEQENG, :CODEMP, :NUMDOC, :ESPDOC, :EMPDOC, :CODCLI)');

      while not LQryDocumentos.Eof do
      begin
        LQryEntrega.Close;
        LQryEntrega.ParamByName('AUTINC').AsString := fRetAutoIncrem('COMEND', VS_strCodEmp);
        LQryEntrega.ParamByName('SEQENG').AsString := LAutInc;
        LQryEntrega.ParamByName('CODEMP').AsString := VS_strCodEmp;
        LQryEntrega.ParamByName('NUMDOC').AsString := LQryDocumentos.FieldByName('GER_NUMDOC').AsString;
        LQryEntrega.ParamByName('ESPDOC').AsString := LQryDocumentos.FieldByName('GER_ESPDOC').AsString;
        LQryEntrega.ParamByName('EMPDOC').AsString := LQryDocumentos.FieldByName('GER_CODEMP').AsString;
        LQryEntrega.ParamByName('CODCLI').AsString := LQryDocumentos.FieldByName('GER_CODCLI').AsString;
        LQryEntrega.ExecSQL;

        LQryDocumentos.Next;
      end;

      if (not fValidaGravacaoCOMEND(LAutInc)) then
      begin
        fRollback;
        fMensagem('ATENÇÃO', 'Houve uma inconsistência na gravação dos dados (COMENG sem COMEND). por favor, entre em contato com a Citel!', ['&OK']);
        Exit(False);
      end;

      fCommit;
      Result := True;
    except
      On E: Exception Do
      begin
        fRollBack;
        Result := False;
        pMensagensErro('Erro ao registrar partida!' + E.Message,'[Registrar partida]');
      end;
    end;
  finally
    FreeAndNil(LQryEntrega);
    FreeAndNil(LQryDocumentos);
  end;
end;

function TEntregas.fRemoveDocumentos(ADocumentos, ACodMot: String;
  AEntregas: TStringList; var ARemoveuTodosDocumentos: Boolean): Boolean;
var
  LQryRemove: TUniQuery;
  LQryEntregas: TUniQuery;
  LQryRemovidos: TUniQuery;
  LQryBaixadas: TUniQuery;
  LQryBaixaDocumento: TUniQuery;
  LIndice: integer;
begin
  Result := False;
  ARemoveuTodosDocumentos := False;

  if fEmptyStr(ADocumentos) then
    Exit;

  if fEmptyStr(ACodMot) then
    Exit;

  if AEntregas.Count = 0 then
    Exit;

  LQryRemove := fCriaQuery;
  LQryEntregas := fCriaQuery;
  LQryRemovidos := fCriaQuery;
  LQryBaixadas := fCriaQuery;
  LQryBaixaDocumento := fCriaQuery;


  try
    try
      fStartTransaction;

      LQryRemove.Close;
      LQryRemove.SQL.Clear;
      LQryRemove.SQL.Add('DELETE FROM COMEND');
      LQryRemove.SQL.Add('WHERE AUTOINCREM IN('+ADocumentos+')');
      LQryRemove.ExecSQL;

      LQryRemove.Close;
      LQryRemove.SQL.Clear;
      LQryRemove.SQL.Add('DELETE FROM COMENG');
      LQryRemove.SQL.Add('WHERE AUTOINCREM = :AUTINC');

      LQryEntregas.Close;
      LQryEntregas.SQL.Clear;
      LQryEntregas.SQL.Add('SELECT END_SEQENG');
      LQryEntregas.SQL.Add('FROM COMEND');
      LQryEntregas.SQL.Add('WHERE END_SEQENG = :SEQENG');

      for LIndice := 0 to AEntregas.Count - 1 do
      begin
        LQryEntregas.Close;
        LQryEntregas.ParamByName('SEQENG').AsString := AEntregas[LIndice];
        LQryEntregas.Open;

        if LQryEntregas.IsEmpty then
        begin
          LQryRemove.Close;
          LQryRemove.ParamByName('AUTINC').AsString := AEntregas[LIndice];
          LQryRemove.ExecSQL;
        end;

        LQryBaixadas.Close;
        LQryBaixadas.SQL.Clear;
        LQryBaixadas.SQL.Add('SELECT END_SEQENG');
        LQryBaixadas.SQL.Add('FROM COMEND');
        LQryBaixadas.SQL.Add('WHERE END_SEQENG = :SEQENG');
        LQryBaixadas.SQL.Add('AND END_DTABAI IS NULL');
        LQryBaixadas.SQL.Add('AND END_HRABAI IS NULL');
        LQryBaixadas.ParamByName('SEQENG').AsString := AEntregas[LIndice];
        LQryBaixadas.Open;

        if LQryBaixadas.IsEmpty then
        begin
          LQryBaixaDocumento.Close;
          LQryBaixaDocumento.SQL.Clear;
          LQryBaixaDocumento.SQL.Add('UPDATE COMENG');
          LQryBaixaDocumento.SQL.Add('SET ENG_DTABAI = :DTABAI,');
          LQryBaixaDocumento.SQL.Add('    ENG_HRABAI = :HRABAI');
          LQryBaixaDocumento.SQL.Add('WHERE AUTOINCREM = :AUTINC');
          LQryBaixaDocumento.ParamByName('DTABAI').AsDate := fRetDataServidor;
          LQryBaixaDocumento.ParamByName('HRABAI').AsTime := fRetHoraServidor;
          LQryBaixaDocumento.ParamByName('AUTINC').AsString := AEntregas[LIndice];
          LQryBaixaDocumento.ExecSQL;
        end;
      end;

      LQryRemovidos.Close;
      LQryRemovidos.SQL.Clear;
      LQryRemovidos.SQL.Add('SELECT ENG_PROENT');
      LQryRemovidos.SQL.Add('FROM COMENG');
      LQryRemovidos.SQL.Add('WHERE ENG_CODEMP = :CODEMP');
      LQryRemovidos.SQL.Add('AND ENG_CODENT = :CODMOT');
      LQryRemovidos.SQL.Add('AND ENG_DTABAI IS NULL');
      LQryRemovidos.SQL.Add('AND ENG_HRABAI IS NULL');
      LQryRemovidos.ParamByName('CODEMP').AsString := VS_strCodEmp;
      LQryRemovidos.ParamByName('CODMOT').AsString := ACodMot;
      LQryRemovidos.Open;

      ARemoveuTodosDocumentos := LQryRemovidos.IsEmpty;

      fCommit;

      Result := True;

    except
      On E: Exception Do
      begin
        fRollBack;
        Result := False;
        pMensagensErro('Erro ao remover documento(s)!' + E.Message,'[Remover documento(s)]');
      end;
    end;
  finally
    FreeAndNil(LQryRemove);
    FreeAndNil(LQryEntregas);
    FreeAndNil(LQryBaixadas);
    FreeAndNil(LQryBaixaDocumento);
  end;
end;

procedure TEntregas.pCriaClientMotorista(AExisteClient: Boolean = False; ACodMot: String = '');
var
  LField: TFieldDef;
  LIndice: Integer;
  LFieldName: String;
begin
  if AExisteClient then
  begin
    FCdsMotoristas.EmptyDataSet;
  end
  else
  begin
    for LIndice := 0 to FQryMotoristas.Fields.Count - 1 do
    begin
      LField := FCdsMotoristas.FieldDefs.AddFieldDef;
      LField.Name := FQryMotoristas.Fields.Fields[LIndice].FieldName;
      LField.DataType := FQryMotoristas.Fields.Fields[LIndice].DataType;

      if FQryMotoristas.Fields.Fields[LIndice].DataType = ftString then
        LField.Size := FQryMotoristas.Fields.Fields[LIndice].Size;
    end;

    FCdsMotoristas.CreateDataSet;
    FCdsMotoristas.Open;
  end;

  if FQryMotoristas.IsEmpty then
    Exit;

  FQryMotoristas.First;

  while not FQryMotoristas.Eof do
  begin
    FCdsMotoristas.Append;

    for LIndice := 0 to FQryMotoristas.Fields.Count - 1 do
    begin
      LFieldName := FQryMotoristas.Fields.Fields[LIndice].FieldName;
      FCdsMotoristas.FieldByName(LFieldName).Value := FQryMotoristas.FieldByName(LFieldName).Value;
    end;

    if (not fEmptyStr(ACodMot)) and (FQryMotoristas.FieldByName('MOT_CODMOT').AsString = ACodMot) then
      FCdsMotoristas.FieldByName('MARDES').AsInteger := 1;

    FCdsMotoristas.Post;

    FQryMotoristas.Next;
  end;

  FCdsMotoristas.First;
end;

procedure TEntregas.pGravaLogEntrega(ACodMot, ASitAnt, ASitAtu: String);
var
  LQryLog: TUniQuery;
begin
  LQryLog := fCriaQuery;

  try
    LQryLog.Close;
    LQryLog.SQL.Clear;
    LQryLog.SQL.Add('INSERT INTO LOGENT(AUTOINCREM, ENT_CODEMP, ENT_CODOPE, ENT_CODMOT, ENT_SITANT, ENT_SITATU, ENT_DTALOG, ENT_HORLOG)');
    LQryLog.SQL.Add('VALUES(:AUTINC, :CODEMP, :CODOPE, :CODMOT, :SITANT, :SITATU, :DTALOG, :HORLOG)');
    LQryLog.ParamByName('AUTINC').AsString := fRetAutoIncrem('LOGENT', VS_strCodEmp);
    LQryLog.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LQryLog.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
    LQryLog.ParamByName('CODMOT').AsString := ACodMot;
    LQryLog.ParamByName('SITANT').AsString := ASitAnt;
    LQryLog.ParamByName('SITATU').AsString := ASitAtu;
    LQryLog.ParamByName('DTALOG').AsDate := fRetDataServidor;
    LQryLog.ParamByName('HORLOG').AsTime := fRetHoraServidor;
    LQryLog.ExecSQL;
  finally
    FreeAndNil(LQryLog);
  end;
end;

procedure TEntregas.pAlteraSituacaoMotorista(ACodMot, ASitAnt, ASitAtu: String);
var
  LQryMotorita: TUniQuery;
begin
  LQryMotorita := fCriaQuery;

  try
    LQryMotorita.Close;
    LQryMotorita.SQL.Clear;
    LQryMotorita.SQL.Add('UPDATE CADMOT');
    LQryMotorita.SQL.Add('SET MOT_SITUAC = :SITUAC');
    LQryMotorita.SQL.Add('WHERE MOT_CODMOT = :CODMOT');
    LQryMotorita.ParamByName('SITUAC').AsString := ASitAtu;
    LQryMotorita.ParamByName('CODMOT').AsString := ACodMot;
    LQryMotorita.ExecSQL;

    pGravaLogEntrega(ACodMot, ASitAnt, ASitAtu);
    pCarregaMotoristas(True, ACodMot);
  finally
    FreeAndNil(LQryMotorita);
  end;
end;

procedure TEntregas.pCarregaDocumentos(AOpcaoDoc: TDocEntrega = DocTodos; ACodMot: String = ''; AEspeciesPermitidas: String = '');
begin
  FQryDocumentos.CachedUpdates := True;
  FQryDocumentos.Options.SetFieldsReadOnly := False;
  FQryDocumentos.Close;
  FQryDocumentos.SQL.Clear;

  if AOpcaoDoc = DocVinculado then
  begin
    FQryDocumentos.SQL.Add(fCarregarDocumentosVinculadosPendentesEntrega(ACodMot, AEspeciesPermitidas));
  end
  else if AOpcaoDoc = DocNaoVinculado then
  begin
    FQryDocumentos.SQL.Add(fCarregarDocumentosSemEntregaVinculada(AEspeciesPermitidas));
  end
  else if AOpcaoDoc = DocTodos then
  begin
    FQryDocumentos.SQL.Add(fCarregarDocumentosVinculadosPendentesEntrega(ACodMot, AEspeciesPermitidas));
    FQryDocumentos.SQL.Add('UNION');
    FQryDocumentos.SQL.Add(fCarregarDocumentosSemEntregaVinculada(AEspeciesPermitidas));
  end;

  if FQryDocumentos.Params.FindParam('CODEMP') <> Nil then
    FQryDocumentos.ParamByName('CODEMP').AsString := VS_strCodEmp;

  if (FQryDocumentos.Params.FindParam('CODMOT') <> Nil) then
    FQryDocumentos.ParamByName('CODMOT').AsString := ACodMot;

  FQryDocumentos.Open;
  pSetaClient(FQryDocumentos);
  TFloatField(FQryDocumentos.FieldByName('GER_VLRCON')).DisplayFormat := '#,##0.00';
end;

procedure TEntregas.pCarregaMotoristas(AExisteClient: Boolean = False; ACodMot: String = '');
begin
  FQryMotoristas.Close;
  FQryMotoristas.SQL.Clear;
  FQryMotoristas.SQL.Add('SELECT MOT_CODMOT, MOT_NOMMOT, MOT_SITUAC,');
  FQryMotoristas.SQL.Add('       CAST(0 AS SIGNED) AS MARDES,');
  FQryMotoristas.SQL.Add('       CONCAT(MOT_CODMOT, "-", MOT_NOMMOT) AS MOTORISTA');
  FQryMotoristas.SQL.Add('FROM CADMOT');
  FQryMotoristas.SQL.Add('WHERE MOT_STATUS = "A"');
  FQryMotoristas.SQL.Add('ORDER BY MOT_NOMMOT');
  FQryMotoristas.Open;

  pCriaClientMotorista(AExisteClient, ACodMot);
end;

end.
