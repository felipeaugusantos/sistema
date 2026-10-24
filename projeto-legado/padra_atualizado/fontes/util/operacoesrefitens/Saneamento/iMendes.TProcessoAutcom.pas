unit iMendes.TProcessoAutcom;

interface

uses untZClient, Uni,untFuncoesSimples,iMendes.Types, System.StrUtils, Math,
     System.SysUtils, System.Classes, untImendesProcessos, Data.DB, iMendes.Functions,
     cxProgressBar, Forms;

Type
  TProcessaImendesRetorno = class
    FQryDados: TUniQuery;
    FQryComand: TUniQuery;
    FQryConsulta: TUniQuery;
    FAutoincremImendes: string;
    FPageAtual : integer;


  protected
    FdtsDados:TDataSource;
    FdtsInfGe:TDataSource;
    FConjFiltroDivergencia: TConjFiltroDivergencia;
    blnGerandoAbreviacao: Boolean;
    FQryImemdes_Resultado: TUniQuery;

    procedure pMontaSQLDados(ADados: TUniQuery; blnContador: Boolean = False; ConjFiltroDivergencia: TConjFiltroDivergencia = []; Pagina: integer = 1);

    procedure pCriaTabelaPaginada;

    procedure pMontaSQL(ConjFiltroDivergencia: TConjFiltroDivergencia = []; Pagina: integer = 1);
    procedure pMontaSQLInfGerais;
    procedure QryDadosAfterScroll(DataSet: TDataSet);

    function fGeraAbreviacoesAux(pgbProgresso: TcxProgressBar): Boolean;
    function fCriaTabelaPaginadaAux(pgbProgresso: TcxProgressBar): Boolean;
    function fSelecionaItensParaGerarAbreviacao: Boolean;



    function fAbreConsulta(pgbProgresso: TcxProgressBar): Boolean;
    procedure pAbreConsulta;


    function fPodeAtualizarAbfItem(blnTrocouItem, blnFinalizouProcesso: Boolean): Boolean;
    procedure pAtualizaAbrevicaoItem(strClaIpi, strCdCest, strCodLub, strExcIPI, strCodIte, strTipAbf: String; strCodEmp: String; strCodAbf: String; strImendesItensSeq: integer);
    procedure pDefineFiltroDivergencia(ADados: TUniQuery;ConjFiltroDivergencia: TConjFiltroDivergencia);
  public
    intQtdRegistros: integer;
    constructor Create;
    destructor Destroy; override;
    function fTrataCampoString(strCampo: string; blnQuoted: Boolean; blnLastField: Boolean = False): String;
    procedure pAbrirParametros(blnCriaTemporaria: Boolean;strAutoincrem: String; ADtsRetorno: TDataSource; ConjFiltroDivergencia: TConjFiltroDivergencia = []; pagina: Integer =1);
    procedure pVisualizaProcessosOperador(AOperador: String);
    procedure pMarcaParaNaoVisualizar(id: integer);
    function  fGerarAbreviacoes: Boolean;
    function fTemDifIcms: Boolean;
    function fLocalizaPaginaDoItem(ACodIte: String): Integer;
    CLASS function fEstadoEmpresa(ACodEmp: STring): String;

    class procedure pRefazResultadoApiSaneamento(strCodAbf: String = '');
    class procedure pGravaAgendamento(RecFiltrosApiSaneamento: TRecFiltrosApiSaneamento; var ListaAutoincrem: string);
    property strAutIncSelec: String read FAutoincremImendes write FAutoincremImendes;

    const cTemporaryName = 'TMP_IMENDES_RESULTADO';

end;

implementation

uses
  iMendes.Constantes, untGravando;

{ TProcessaImendesRetorno }

constructor TProcessaImendesRetorno.Create();
begin
  inherited;
  FQryDados := fCriaQuery();
  FQryConsulta := fCriaQuery();
  FQryComand := fCriaQuery();
  FQryImemdes_Resultado := fCriaQuery();
end;

destructor TProcessaImendesRetorno.Destroy;
begin
  FreeAndNil(FQryDados);
  FreeAndNil(FQryConsulta);
  FreeAndNil(FQryComand);
  FreeAndNil(FQryImemdes_Resultado);
  inherited;
end;

function TProcessaImendesRetorno.fTrataCampoString(strCampo: string; blnQuoted: Boolean; blnLastField: Boolean = False): String;
Begin
   Result := QuotedStr('"') + ',' + IIf(blnQuoted, QuotedStr(strCampo), strCampo)               +  ',' +  QuotedStr('"') + IIf(blnLastField, '', ',' + QuotedStr(',') + ',');
End;

function TProcessaImendesRetorno.fGeraAbreviacoesAux(pgbProgresso: TcxProgressBar): Boolean;
  var qryAbfIcm: TUniQuery;
      intCodAbfIcm: integer;
      strCodIteEmp: String;
      blnErro: boolean;
      FQryInsertScript: TUniQuery;
      ConjPerfis: TConjPerfis;
      APerfil: TPerfil;
      strPerfil: string;
      strAutInc: String;
      strDesIte: String;
      strCst: string;
      strApenasPerfil: String;
begin
  blnGerandoAbreviacao := True;
  Try
    pAbrirParametros(False, strAutIncSelec, FdtsDados);

    Result := True;

    If FQryImemdes_Resultado.IsEmpty Then
    begin
      pMensagemOk('Sem itens para gerar abreviação!');
      Exit;
    End;

    pgbProgresso.Properties.Max := FQryImemdes_Resultado.RecordCount -1;
    qryAbfIcm := fCriaQuery;
    FQryInsertScript := fCriaQuery;
    Try
      qryAbfIcm.SQl.Clear;
      qryAbfIcm.SQL.Text := 'SELECT MAX(LPAD(ABF_CODABF, 7, "0")) + 0 AS CODABF FROM ABFICM WHERE ABF_CODABF <> "9999999"';
      qryAbfIcm.Open;
      intCodAbfIcm := qryAbfIcm.FieldByName('CODABF').AsInteger + 1;

      qryAbfIcm.SQl.Clear;

      FQryImemdes_Resultado.First;
      strCodIteEmp := '';
      blnErro := True;
      ConjPerfis := [cjpPEF, cjpPEJ, cjpPER, cjpPES, cjpPSI, cjpPII, cjpNCO, cjpCCO, cjpCNC, cjpSNA, cjpCTA, cjpPRU ,cjpIND, cjpTRS];

      While not FQryImemdes_Resultado.Eof do
      Begin
        FQryInsertScript.SQL.Clear;
        blnErro := False;
        fStartTransaction;
        Try
          FQryComand.SQL.Clear;
          FQryComand.SQL.Add('INSERT INTO ABFICM(');
          FQryComand.SQL.Add('AUTOINCREM,');
          FQryComand.SQL.Add('ABF_CODEMP,');
          FQryComand.SQL.Add('ABF_CODABF,');
          FQryComand.SQL.Add('ABF_DESABF,');
          FQryComand.SQL.Add('ABF_ESTADO,');
          For APerfil in ConjPerfis do
          Begin
            strPerfil := fConvertConfPerfilToAliasFieldString(APerfil);
            FQryComand.SQL.Add('ABF_CODSIT' + strPerfil +',');
            FQryComand.SQL.Add('ABF_CODBEN' + strPerfil +',');
            If  fPerfilSaida(APerfil) Then
              FQryComand.SQL.Add('ABF_MENS01' + strPerfil +',');
            FQryComand.SQL.Add('ABF_BASICM' + strPerfil +',');
            FQryComand.SQL.Add('ABF_ALQICM' + strPerfil +',');
            FQryComand.SQL.Add('ABF_BASRET' + strPerfil +',');
            FQryComand.SQL.Add('ABF_ALQRET' + strPerfil +',');
            FQryComand.SQL.Add('ABF_IVA_ST' + strPerfil +',');
            FQryComand.SQL.Add('ABF_ALQFCP' + strPerfil +',');
            FQryComand.SQL.Add('ABF_ALQEFO' + strPerfil +',');
            FQryComand.SQL.Add('ABF_ALQIED' + strPerfil +',');
            FQryComand.SQL.Add('ABF_ALQRED' + strPerfil +',');
            FQryComand.SQL.Add('ABF_BASDDS' + strPerfil +',');
          End;
          FQryComand.SQL.Add('ABF_CODITE) VALUES ' );

          FQryInsertScript.SQL.Add('SET @PROINC = (SELECT PRO_AUTINC FROM PROINC WHERE PRO_NOMARQ = "ABFICM");');
          FQryInsertScript.SQL.Add('SET @AUTINC = CONCAT("'+fRetEmpresaFisica(FQryInsertScript.Connection)+'", LPAD(@PROINC, 14, "0"), "'+VS_StrCodEmp+'");');

          strAutInc := 'CONCAT("'+fRetEmpresaFisica(FQryComand.Connection)+'", LPAD(@PROINC := (@PROINC + 1), 14, "0"), "'+VS_StrCodEmp+'")';
          strDesIte :=  FQryImemdes_Resultado.FieldByName('ITE_CLAIPI').AsString + '-' + AnsiReplaceStr(FQryImemdes_Resultado.FieldByName('ITE_DESITE').AsString, '"', '');

          FQryInsertScript.SQL.Add('SELECT ');
          FQryInsertScript.SQL.Add('CONCAT(');

          FQryInsertScript.SQL.Add(fTrataCampoString(strAutInc, False));
          FQryInsertScript.SQL.Add(fTrataCampoString(VS_StrCodEmp, True));
          FQryInsertScript.SQL.Add(fTrataCampoString(fStrZero(intCodAbfIcm, 7), True));
          FQryInsertScript.SQL.Add(fTrataCampoString(strDesIte, True));
          FQryInsertScript.SQL.Add(fTrataCampoString('ABF_ESTADO', False));

          For APerfil in ConjPerfis do
          Begin
            strPerfil := fConvertConfPerfilToAliasFieldString(APerfil);
            strApenasPerfil := fConvertConfPerfilToString(APerfil);
            strCst := 'CONCAT(ITE_CSTORI, ABF_CODSIT'+strPerfil +')';
            FQryInsertScript.SQL.Add(fTrataCampoString(strCst, False));
            FQryInsertScript.SQL.Add(fTrataCampoString('IFNULL(ABF_CODBEN' + strPerfil + ',"")', False));
            If  fPerfilSaida(APerfil) Then
              FQryInsertScript.SQL.Add(fTrataCampoString('IFNULL(ABF_IME_AMPLEG_' + strApenasPerfil + ',"")', False));
            FQryInsertScript.SQL.Add('IFNULL(ABF_BASICM' + strPerfil + ', NULL),' + QuotedStr(',') + ',');
            FQryInsertScript.SQL.Add('IFNULL(ABF_ALQICM' + strPerfil + ', NULL),' + QuotedStr(',') + ',');
            FQryInsertScript.SQL.Add('IFNULL(ABF_BASRET' + strPerfil + ', NULL),' + QuotedStr(',') + ',');
            FQryInsertScript.SQL.Add('IFNULL(ABF_ALQRET' + strPerfil + ', NULL),' + QuotedStr(',') + ',');
            FQryInsertScript.SQL.Add('IFNULL(ABF_IVA_ST' + strPerfil + ', NULL),' + QuotedStr(',') + ',');
            FQryInsertScript.SQL.Add('IFNULL(ABF_ALQFCP' + strPerfil + ', NULL),' + QuotedStr(',') + ',');
            FQryInsertScript.SQL.Add('IFNULL(ABF_ALQEFO' + strPerfil + ', NULL),' + QuotedStr(',') + ',');
            FQryInsertScript.SQL.Add('IFNULL(ABF_ALQIED' + strPerfil + ', NULL),' + QuotedStr(',') + ',');
            FQryInsertScript.SQL.Add('IFNULL(ABF_ALQRED' + strPerfil + ', NULL),' + QuotedStr(',') + ',');
            FQryInsertScript.SQL.Add('IFNULL(ABF_BASDDS' + strPerfil + ', NULL),' + QuotedStr(',') + ',');
          End;
          FQryInsertScript.SQL.Add(fTrataCampoString('IME_CODITE', False, True));

          FQryInsertScript.SQL.Add(') AS COMAND ');
          FQryInsertScript.SQL.Add(' FROM IMENDES_RESULTADO');
          FQryInsertScript.SQL.Add(' INNER JOIN CADITE ON ITE_CODITE = IME_CODITE ');
          FQryInsertScript.SQL.Add('   WHERE ABF_ESTADO <> "" ');
          FQryInsertScript.SQL.Add('     AND ABF_ESTADO <> "EX" ');
          FQryInsertScript.SQL.Add('     AND IME_SEQCON = "' + FAutoincremImendes + '"');
          FQryInsertScript.SQL.Add('     AND EXCLUIDO <> "S"');
          FQryInsertScript.SQL.Add('     AND LOCAL = "iMendes"');
          FQryInsertScript.SQL.Add('     AND IME_SEMIME = 0');
          FQryInsertScript.SQL.Add('     AND IME_RETPAR = 0');
          FQryInsertScript.SQL.Add('     AND IME_GERABF <> 1');
          FQryInsertScript.SQL.Add('     AND IME_CODITE = "'+FQryImemdes_Resultado.FieldByName('IME_CODITE').AsString+'"');


          //Exterior
          FQryInsertScript.SQL.Add(' UNION ALL ');

          FQryInsertScript.SQL.Add('SELECT ');
          FQryInsertScript.SQL.Add('CONCAT(');

          FQryInsertScript.SQL.Add(fTrataCampoString(strAutInc, False));
          FQryInsertScript.SQL.Add(fTrataCampoString(VS_StrCodEmp, True));
          FQryInsertScript.SQL.Add(fTrataCampoString(fStrZero(intCodAbfIcm, 7), True));
          FQryInsertScript.SQL.Add(fTrataCampoString(strDesIte, True));
          FQryInsertScript.SQL.Add(fTrataCampoString('EX', True));

          For APerfil in ConjPerfis do
          Begin
            strPerfil := fConvertConfPerfilToAliasFieldString(APerfil);
            FQryInsertScript.SQL.Add(fTrataCampoString('100', True));
            FQryInsertScript.SQL.Add(fTrataCampoString('IFNULL(ABF_CODBEN' + strPerfil + ',"")', False));
            If  fPerfilSaida(APerfil) Then
              FQryInsertScript.SQL.Add(fTrataCampoString('IFNULL(ABF_IME_AMPLEG_' + strApenasPerfil + ',"")', False));
            FQryInsertScript.SQL.Add('IFNULL(ABF_BASICM' + strPerfil + ', NULL),' + QuotedStr(',') + ',');
            FQryInsertScript.SQL.Add('IFNULL(ABF_ALQICM' + strPerfil + ', NULL),' + QuotedStr(',') + ',');
            FQryInsertScript.SQL.Add('IFNULL(ABF_BASRET' + strPerfil + ', NULL),' + QuotedStr(',') + ',');
            FQryInsertScript.SQL.Add('IFNULL(ABF_ALQRET' + strPerfil + ', NULL),' + QuotedStr(',') + ',');
            FQryInsertScript.SQL.Add('IFNULL(ABF_IVA_ST' + strPerfil + ', NULL),' + QuotedStr(',') + ',');
            FQryInsertScript.SQL.Add('IFNULL(ABF_ALQFCP' + strPerfil + ', NULL),' + QuotedStr(',') + ',');
            FQryInsertScript.SQL.Add('IFNULL(ABF_ALQEFO' + strPerfil + ', NULL),' + QuotedStr(',') + ',');
            FQryInsertScript.SQL.Add('IFNULL(ABF_ALQIED' + strPerfil + ', NULL),' + QuotedStr(',') + ',');
            FQryInsertScript.SQL.Add('IFNULL(ABF_ALQRED' + strPerfil + ', NULL),' + QuotedStr(',') + ',');
            FQryInsertScript.SQL.Add('IFNULL(ABF_BASDDS' + strPerfil + ', NULL),' + QuotedStr(',') + ',');
          End;
          FQryInsertScript.SQL.Add(fTrataCampoString('IME_CODITE', False, True));

          FQryInsertScript.SQL.Add(') AS COMAND ');
          FQryInsertScript.SQL.Add(' FROM IMENDES_RESULTADO');
          FQryInsertScript.SQL.Add(' INNER JOIN CADITE ON ITE_CODITE = IME_CODITE ');
          FQryInsertScript.SQL.Add('   WHERE ABF_ESTADO <> "" ');
          FQryInsertScript.SQL.Add('     AND IME_SEQCON = "' + FAutoincremImendes + '"');
          FQryInsertScript.SQL.Add('     AND EXCLUIDO <> "S"');
          FQryInsertScript.SQL.Add('     AND LOCAL = "iMendes"');
          FQryInsertScript.SQL.Add('     AND IME_SEMIME = 0');
          FQryInsertScript.SQL.Add('     AND IME_RETPAR = 0');
          FQryInsertScript.SQL.Add('     AND IME_GERABF <> 1');
          FQryInsertScript.SQL.Add('     AND ABF_ESTADO = "'+fEstadoEmpresa(FQryImemdes_Resultado.FieldByName('IME_CODEMP').AsString)+'"');
          FQryInsertScript.SQL.Add('     AND IME_CODITE = "'+FQryImemdes_Resultado.FieldByName('IME_CODITE').AsString+'";');

          FQryInsertScript.Open;
          while not FQryInsertScript.Eof do
          Begin
            FQryComand.SQL.Add('(' + FQryInsertScript.FieldByName('COMAND').AsString+ ')' + IIf(FQryInsertScript.RecNO = FQryInsertScript.RecordCount, '', ','));
            FQryInsertScript.Next;
          End;


          FQryComand.ExecSQL;
          FQryComand.SQL.Clear;
          FQryComand.SQL.Add('UPDATE PROINC SET PRO_AUTINC = (@PROINC + 1) WHERE  PRO_NOMARQ = "ABFICM";');
          FQryComand.ExecSQL;


          pAtualizaAbrevicaoItem(FQryImemdes_Resultado.FieldByName('IME_CODNCM').AsString,
                                 FQryImemdes_Resultado.FieldByName('IME_CDCEST').AsString,
                                 FQryImemdes_Resultado.FieldByName('IME_CODLUB').AsString,
                                 FQryImemdes_Resultado.FieldByName('IME_EXCIPI').AsString,
                                 FQryImemdes_Resultado.FieldByName('IME_CODITE').AsString,
                                 FQryImemdes_Resultado.FieldByName('TIPABF').AsString,
                                 FQryImemdes_Resultado.FieldByName('IME_CODEMP').AsString,
                                 fStrZero(intCodAbfIcm, 7),
                                 FQryImemdes_Resultado.FieldByName('IME_SEQUEN').AsInteger);

          inc(intCodAbfIcm);

          FQryComand.SQL.Clear;
          fCommit;

          FQryImemdes_Resultado.Next;
          pgbProgresso.Position := FQryImemdes_Resultado.RecNo;

          Application.ProcessMessages;
        Except
          on E:  Exception do
          Begin
            blnErro := True;
            fRollBack;
            pMensagensErro(e.Message, '[TProcessaImendesRetorno.fGeraAbreviacoesAux]');
          End;
        End;
      End;
      If not blnErro Then
      Begin
        FQryComand.SQL.Text := 'UPDATE IMENDES_PARAM SET MAQUINA_ESTADO_ANT = MAQUINA_ESTADO, IME_GERABF = 1, STATUS = "P", ' +
                               '                         MAQUINA_ESTADO = "'+IntToStr(fEstadoProcessamentoToInteger(epRecriaTabelaResultado))+'" ' +
                               '                   WHERE AUTOINCREM = "'+FAutoincremImendes+'"';
        FQryComand.ExecSQL;
      End;


    Finally
      FreeAndNil(qryAbfIcm);
      FreeAndNil(FQryInsertScript);
    End;
  Finally
    blnGerandoAbreviacao := False;
  End;
end;


procedure TProcessaImendesRetorno.pAbrirParametros(blnCriaTemporaria: Boolean;strAutoincrem: String;
  ADtsRetorno: TDataSource; ConjFiltroDivergencia: TConjFiltroDivergencia = []; pagina: Integer =1);
begin
  FConjFiltroDivergencia := ConjFiltroDivergencia;
  FQryDados.AfterScroll := nil;

  FdtsDados := ADtsRetorno;
  FAutoincremImendes := strAutoincrem;

  FQryConsulta.SQL.Clear;

  ADtsRetorno.DataSet := NIL;
  If (pagina - 1) < 1 Then
    pagina := 1;
  If blnGerandoAbreviacao Then
  Begin
    fSelecionaItensParaGerarAbreviacao;
    Exit;
  End
  Else If blnCriaTemporaria Then
  Begin
    pCriaTabelaPaginada;
    pMontaSQL(ConjFiltroDivergencia, pagina);
  End
  Else
    pMontaSQL(ConjFiltroDivergencia, pagina);

  ADtsRetorno.DataSet := FQryDados;

  pMontaSQLInfGerais;
  FQryDados.AfterScroll := QryDadosAfterScroll;
  QryDadosAfterScroll(FQryDados);
  pMontaSQLDados(FQryConsulta, True,ConjFiltroDivergencia, pagina);
  FQryConsulta.Open;
  intQtdRegistros := FQryConsulta.FieldByName('QTD').AsInteger;
  If blnCriaTemporaria Then
    FPageAtual := 1
  Else
    FPageAtual := pagina;

end;

procedure TProcessaImendesRetorno.pAtualizaAbrevicaoItem(strClaIpi, strCdCest, strCodLub, strExcIPI, strCodIte, strTipAbf: String; strCodEmp: String; strCodAbf: String; strImendesItensSeq: integer);
  var strTabela: String;
begin
  FQryComand.sql.Clear;
  FQryComand.SQL.Add('SET @IGNORA_MENDES = 1;');
  strTabela := 'ITEGER';
  If strTipAbf = '1' Then
   strTabela := 'CADITE';
  FQryComand.sql.Add('UPDATE ' + strTabela + ' SET ITE_CODABF = "'+strCodAbf+'" WHERE ITE_CODITE = "'+strCodIte+'"');
  if strTipAbf = '2' Then
    FQryComand.sql.Add(' AND ITE_CODEMP = "'+strCodEmp+'"');
  FQryComand.SQL.Add(';SET @IGNORA_MENDES = 1;');
  FQryComand.SQL.Add(' UPDATE IMENDES_ITENS  ');
  FQryComand.SQL.Add('     SET IME_GERABF = 1,  ');
  FQryComand.SQL.Add('         IME_CODABF = "'+strCodAbf+'"');
  FQryComand.SQL.Add('   WHERE IME_SEQCON = "'+FAutoincremImendes+'" ');
  FQryComand.SQL.Add('     AND IME_CODITE = "'+strCodIte+'" ');
  FQryComand.SQL.Add('     AND IME_CODEMP = "'+strCodEmp+'";');

  FQryComand.SQL.Add('SET @IGNORA_MENDES = 0;');
  FQryComand.ExecSQL;

  Try
    FQryComand.SQl.Clear;
    FQryComand.SQL.Add('UPDATE CADITE SET ITE_CLAIPI = "'+strClaIpi+'", ITE_CDCEST = "'+strCdCest+'",ITE_CODLUB = "'+strCodLub+'"');
    If fCfgSis('TPABPC') = '1' Then
       FQryComand.SQL.Add(', ITE_EXCIPI = "'+strExcIPI+'"');
    FQryComand.SQL.Add('     WHERE ITE_CODITE = "'+strCodIte+'";');
    FQryComand.ExecSQL;
  Except
  End;

  Try
    If fCfgSis('TPABPC') <> '1' Then
    Begin
      FQryComand.SQL.Clear;
      FQryComand.SQL.Add('UPDATE ITEGER SET ITE_EXCIPI = "'+strExcIPI+'" WHERE ITE_CODITE = "'+strCodIte+'" AND ITE_CODEMP = "'+strCodEmp+'";');
      FQryComand.ExecSQL;
    End;
  Except
  End;
end;

procedure TProcessaImendesRetorno.pDefineFiltroDivergencia(ADados: TUniQuery;ConjFiltroDivergencia: TConjFiltroDivergencia);
var strWhere: String;
begin
  strWhere := '  ';
  ADados.sql.Add('AND (');
  If fdPISCOfins in ConjFiltroDivergencia then
  begin
    ADados.SQL.Add( strWhere + ' (DIF_PISCOF = 1) ');
    strWhere := ' OR ';
  End;

  If fdIPI in ConjFiltroDivergencia then
  Begin
    ADados.SQL.Add( strWhere + ' (DIF_IPI = 1) ');
    strWhere := ' OR ';
  End;

  If fdInfGerais in ConjFiltroDivergencia then
  Begin
    ADados.SQL.Add( strWhere + ' (DIF_INF_GERAIS = 1 AND IME_SEMIME = 0 AND IME_RETPAR = 0 AND IME_SEMEAN = 0)');
    strWhere := ' OR ';
  End;

  If fdSemImendes in ConjFiltroDivergencia then
  Begin
    ADados.SQL.Add( strWhere + '(IME_SEMIME = 1 AND IME_SEMEAN = 0) ');
    strWhere := ' OR ';
  End;

  If fdSemCst in ConjFiltroDivergencia then
  Begin
    ADados.SQL.Add( strWhere + '(IME_SEMEAN = 2) ');
    strWhere := ' OR ';
  End;

  If fdCodbarrInvalido in ConjFiltroDivergencia then
  Begin
    ADados.SQL.Add( strWhere + '(IME_SEMEAN = 1) ');
    strWhere := ' OR ';
  End;

  If fdRetornoParcialImendes in ConjFiltroDivergencia then
  Begin
    ADados.SQL.Add( strWhere + '(IME_RETPAR = 1) ');
    strWhere := ' OR ';
  End;

  If fdICMS in ConjFiltroDivergencia then
  Begin
    ADados.SQL.Add( strWhere + '(DIF_ICMS = 1) ');
  End;

  ADados.sql.Add(' )');

end;


class procedure TProcessaImendesRetorno.pGravaAgendamento(RecFiltrosApiSaneamento: TRecFiltrosApiSaneamento; var ListaAutoincrem: string);
var
    qryGravaAgendamento: TUniQuery;
    strDescricao: String;
    qryEmpresas: TUniQuery;
    strAutoincremLocal: String;
    strCodEmpLocal: String;
    RecParametrosApiSaneamento: TRecParametrosApiSaneamento;
begin
  strAutoincremLocal := '';
  ListaAutoincrem := '';
  qryEmpresas := fCriaQuery;
  Try
    qryEmpresas.SQL.Add('SELECT EMP_CODEMP FROM CADEMP');
    qryEmpresas.SQL.Add(' INNER JOIN CFGSIS ON SIS_CODCFG = "CFG_TIPABF" AND SIS_CODEMP =  EMP_CODEMP');
    qryEmpresas.SQL.Add(iMendes.Functions.fStrLocate(RecFiltrosApiSaneamento.FilterCodEmpresa, RecFiltrosApiSaneamento.FilterArrEmpresa, 'EMP_CODEMP', 'CODEMP'));
    qryEmpresas.SQL.Add('  AND SIS_VALCFG = "1"');
    qryEmpresas.SQL.Add('  GROUP BY SIS_VALCFG');
    qryEmpresas.SQL.Add('UNION ALL');
    qryEmpresas.SQL.Add('SELECT EMP_CODEMP FROM CADEMP');
    qryEmpresas.SQL.Add(' INNER JOIN CFGSIS ON SIS_CODCFG = "CFG_TIPABF" AND SIS_CODEMP =  EMP_CODEMP');
    qryEmpresas.SQL.Add(' WHERE TRUE');
    qryEmpresas.SQL.Add(iMendes.Functions.fStrLocate(RecFiltrosApiSaneamento.FilterCodEmpresa, RecFiltrosApiSaneamento.FilterArrEmpresa, 'EMP_CODEMP', 'CODEMP'));
    qryEmpresas.SQL.Add('  AND SIS_VALCFG = "2"');
    pSetaParam(RecFiltrosApiSaneamento.FilterCodEmpresa, RecFiltrosApiSaneamento.FilterArrEmpresa, strCodEmpLocal, 'CODEMP' , qryEmpresas);
    qryEmpresas.Open;
    strDescricao := 'CAD. PRODUTOS EAN: ' + RecFiltrosApiSaneamento.strCodEan;
    qryGravaAgendamento := fCriaQuery;
    qryGravaAgendamento.SQL.Add('INSERT INTO IMENDES_PARAM(');
    qryGravaAgendamento.SQL.Add('IME_VISPRO,');
    qryGravaAgendamento.SQL.Add('PARAMETROS,');
    qryGravaAgendamento.SQL.Add('DATA,');
    qryGravaAgendamento.SQL.Add('STATUS,');
    qryGravaAgendamento.SQL.Add('PROCESSADOS,');
    qryGravaAgendamento.SQL.Add('TOTAL_PARA_PROCESSAR,');
    qryGravaAgendamento.SQL.Add('ACAO_ATUAL,');
    qryGravaAgendamento.SQL.Add('AUTOINCREM,');
    qryGravaAgendamento.SQL.Add('PAR_CODOPE,');
    qryGravaAgendamento.SQL.Add('IME_AGRUPADOR,');
    qryGravaAgendamento.SQL.Add('DESCRICAO,');
    qryGravaAgendamento.SQL.Add('EMPRESA)');
    qryGravaAgendamento.SQL.Add('VALUES(');
    qryGravaAgendamento.SQL.Add('"1",');
    qryGravaAgendamento.SQL.Add(':PARAMETROS,');
    qryGravaAgendamento.SQL.Add(':DATA,');
    qryGravaAgendamento.SQL.Add(':STATUS,');
    qryGravaAgendamento.SQL.Add(':PROCESSADOS,');
    qryGravaAgendamento.SQL.Add(':TOTAL_PARA_PROCESSAR,');
    qryGravaAgendamento.SQL.Add(':ACAO_ATUAL,');
    qryGravaAgendamento.SQL.Add(':AUTOINCREM,');
    qryGravaAgendamento.SQL.Add(':PAR_CODOPE,');
    qryGravaAgendamento.SQL.Add(':AGRUPADOR,');
    qryGravaAgendamento.SQL.Add(':DESCRICAO,');
    qryGravaAgendamento.SQL.Add(':EMPRESA);');

    while not qryEmpresas.Eof Do
    Begin
      strCodEmpLocal := qryEmpresas.FieldByName('EMP_CODEMP').AsString;
      SetLength(RecFiltrosApiSaneamento.FilterArrEmpresa, 1);
      RecFiltrosApiSaneamento.FilterArrEmpresa[0].strCodigo := qryEmpresas.FieldByName('EMP_CODEMP').AsString;
      RecFiltrosApiSaneamento.FilterArrEmpresa[0].strDescri := '';
      RecFiltrosApiSaneamento.FilterCodEmpresa := qryEmpresas.FieldByName('EMP_CODEMP').AsString;
      RecParametrosApiSaneamento.Filtros := RecFiltrosApiSaneamento;

      qryGravaAgendamento.ParamByName('PARAMETROS').ASString := RecParametrosApiSaneamento.fConvertToString;
      strAutoincremLocal := fRetAutoIncrem('IMENDES_PARAM', VS_strCodEmp);
      If ListaAutoincrem = '' Then
        ListaAutoincrem := strAutoincremLocal;


      qryGravaAgendamento.ParamByName('PARAMETROS').AsString := RecParametrosApiSaneamento.fConvertToString;
      qryGravaAgendamento.ParamByName('DESCRICAO').AsString := strDescricao;
      qryGravaAgendamento.ParamByName('DATA').AsDateTime := fNow;
      qryGravaAgendamento.ParamByName('STATUS').AsString := 'P';
      qryGravaAgendamento.ParamByName('PROCESSADOS').AsInteger := 0;
      qryGravaAgendamento.ParamByName('AGRUPADOR').AsString := ListaAutoincrem;
      qryGravaAgendamento.ParamByName('TOTAL_PARA_PROCESSAR').AsInteger := 0;
      qryGravaAgendamento.ParamByName('ACAO_ATUAL').AsString := 'Aguardando processamento';
      qryGravaAgendamento.ParamByName('AUTOINCREM').AsString := strAutoincremLocal;
      qryGravaAgendamento.ParamByName('PAR_CODOPE').AsString := strLoginUsuarioLogado;
      qryGravaAgendamento.ParamByName('EMPRESA').AsString := qryEmpresas.FieldByName('EMP_CODEMP').AsString;
      qryGravaAgendamento.ExecSQL;
      qryEmpresas.Next;
    End;
  finally
//    pMonitoraProcesso;
  End;
end;

function TProcessaImendesRetorno.fGerarAbreviacoes: Boolean;
var intOpcAtivos: integer;
begin
  intOpcAtivos := fMensagem('','Esta operação irá criar nova Abreviação Fiscal de ICMS  para cada produto listado nesta tela, marcado em vermelho como "Item com divergência".' + #$A#$D + 'Confirma?', ['&Sim', '&Não'], 2);


  If intOpcAtivos = 2 Then
    Exit(False);
  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    Try
      FQryDados.AfterScroll := nil;
      frmGravando.fExecutarAcao := fGeraAbreviacoesAux;
      frmGravando.lblGravando.Caption := 'Gerando abreviação dos itens...';
      frmGravando.ShowModal;

      Result := frmGravando.blnConfirma;
      If Result Then
        pMensagemOk('Abreviações geradas com sucesso!');
      FQryDados.AfterScroll := QryDadosAfterScroll;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TProcessaImendesRetorno.pGerarAbreviacoes]');
        Result := False;
      End;
    End;
  Finally
    FreeAndNil(frmGravando);
  End;
end;



function TProcessaImendesRetorno.fLocalizaPaginaDoItem(
  ACodIte: String): Integer;
begin
  Result := -1;
  If  ACodIte <> '' Then
  begin
    ACodIte := fStrZero(ACodIte, fTamCodIte);
    FQryConsulta.SQL.Clear;
    FQryConsulta.SQL.Add('SELECT PAGINA FROM ' + cTemporaryName + ' WHERE IME_CODITE = "' + ACodIte + '"');
    FQryConsulta.Open;
    If not FQryConsulta.IsEmpty Then
      Result := FQryConsulta.FieldByName('PAGINA').AsInteger;
  End;

end;

function TProcessaImendesRetorno.fPodeAtualizarAbfItem(blnTrocouItem,
  blnFinalizouProcesso: Boolean): Boolean;
begin
  Result := False;
  If  blnTrocouItem Then
    Exit(True);
  If blnFinalizouProcesso Then
    Exit(True);

end;

procedure TProcessaImendesRetorno.pMarcaParaNaoVisualizar(id: integer);
begin
  FQryConsulta.SQL.Clear;

  FQryConsulta.SQL.Add('UPDATE IMENDES_RESULTADO SET EXCLUIDO = "S" WHERE IME_SEQCON = "'+FAutoincremImendes+'" AND IME_SEQUEN = ' + id.ToString + ';') ;
  FQryConsulta.SQL.Add('UPDATE IMENDES_ITENS SET EXCLUIDO = "S" WHERE IME_SEQCON = "'+FAutoincremImendes+'" AND IME_SEQUEN = ' + id.ToString + ';') ;
  FQryConsulta.SQL.Add('UPDATE ' + cTemporaryName + ' SET EXCLUIDO = "S" WHERE IME_SEQCON = "'+FAutoincremImendes+'" AND IME_SEQUEN = ' + id.ToString + ';') ;
  FQryConsulta.ExecSQL;

  pCriaTabelaPaginada;
  pMontaSQLDados(FQryDados, False, FConjFiltroDivergencia, FPageAtual);

  pMontaSQLDados(FQryConsulta, True);

  pAbreConsulta;
  intQtdRegistros := FQryConsulta.FieldByName('QTD').AsInteger;
end;

procedure TProcessaImendesRetorno.pMontaSQL(ConjFiltroDivergencia: TConjFiltroDivergencia = []; Pagina: integer = 1);

begin
  pMontaSQLDados(FQryDados, False, ConjFiltroDivergencia, Pagina);


  pMontaSQLDados(FQryConsulta, True);

  pAbreConsulta;

  intQtdRegistros := FQryConsulta.FieldByName('QTD').AsInteger;
  
end;


procedure TProcessaImendesRetorno.pAbreConsulta;
begin
  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    Try
      FQryDados.AfterScroll := nil;
      frmGravando.fExecutarAcao := fAbreConsulta;
      frmGravando.lblGravando.Caption := 'Carregando informações...';
      frmGravando.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TProcessaImendesRetorno.pAbreConsulta]');
      End;
    End;
  Finally
    FreeAndNil(frmGravando)
  End;

End;

function TProcessaImendesRetorno.fAbreConsulta(pgbProgresso: TcxProgressBar): Boolean;
Begin
  Result := True;
  FQryDados.Open;
  FQryConsulta.Open;
End;

procedure TProcessaImendesRetorno.pMontaSQLDados(ADados: TUniQuery; blnContador: Boolean = False; ConjFiltroDivergencia: TConjFiltroDivergencia = []; Pagina: integer = 1);
begin
  ADados.SQL.Clear;
  If blnContador Then
  Begin
    ADados.SQL.Add('SELECT @PAGINA QTD ');
    Exit;
  End;

  ADados.SQL.Add('SELECT ITENS.IME_DIFICM, RES.*, C.ITE_CODBAR,');

    ADados.SQL.Add('  IF(RES.LOCAL = "iMendes", IME_CODNCM, C.ITE_CLAIPI) AS ITE_CLAIPI_, ');
    ADados.SQL.Add('  IF(RES.LOCAL = "iMendes", IME_CDCEST, C.ITE_CDCEST) AS ITE_CDCEST_, ');
    ADados.SQL.Add('  IF(RES.LOCAL = "iMendes", IME_CODLUB, C.ITE_CODLUB) AS ITE_CODLUB_, ');
    ADados.SQL.Add('  IF(RES.LOCAL = "iMendes", IME_EXCIPI, IF(TPABPC.SIS_VALCFG = "1", C.ITE_EXCIPI, ITEGER.ITE_EXCIPI)) AS IME_EXCIPI_, ');

    ADados.SQL.Add('       CAST(CONCAT(RES.ABF_ESTADO, IF(ABF_IME_AMPLEG_PEF <> "" OR ');
    ADados.SQL.Add('          ABF_IME_PTCNOM_PEF <> "" OR ');
    ADados.SQL.Add('          ABF_IME_CONNOM_PEF <> "", "1", "0")) AS CHAR(3)) TEM_MENSAGEM_PEF,');

    ADados.SQL.Add('       CAST(CONCAT(RES.ABF_ESTADO,IF(ABF_IME_AMPLEG_PEJ <> "" OR ');
    ADados.SQL.Add('          ABF_IME_PTCNOM_PEJ <> "" OR ');
    ADados.SQL.Add('          ABF_IME_CONNOM_PEJ <> "", 1, 0)) AS CHAR(3)) TEM_MENSAGEM_PEJ,');

    ADados.SQL.Add('       CAST(CONCAT(RES.ABF_ESTADO,IF(ABF_IME_AMPLEG_PER <> "" OR');
    ADados.SQL.Add('          ABF_IME_PTCNOM_PER <> "" OR');
    ADados.SQL.Add('          ABF_IME_CONNOM_PER <> "", 1, 0)) AS CHAR(3)) TEM_MENSAGEM_PER,');

    ADados.SQL.Add('       CAST(CONCAT(RES.ABF_ESTADO,IF(ABF_IME_AMPLEG_PES <> "" OR ');
    ADados.SQL.Add('          ABF_IME_PTCNOM_PES <> "" OR ');
    ADados.SQL.Add('          ABF_IME_CONNOM_PES <> "", 1, 0)) AS CHAR(3)) TEM_MENSAGEM_PES,');

    ADados.SQL.Add('       CAST(CONCAT(RES.ABF_ESTADO,IF(ABF_IME_AMPLEG_PSI <> "" OR ');
    ADados.SQL.Add('          ABF_IME_PTCNOM_PSI <> "" OR ');
    ADados.SQL.Add('          ABF_IME_CONNOM_PSI <> "", 1, 0)) AS CHAR(3)) TEM_MENSAGEM_PSI,');

    ADados.SQL.Add('       CAST(CONCAT(RES.ABF_ESTADO,IF(ABF_IME_AMPLEG_PII <> "" OR ');
    ADados.SQL.Add('          ABF_IME_PTCNOM_PII <> "" OR ');
    ADados.SQL.Add('          ABF_IME_CONNOM_PII <> "", 1, 0)) AS CHAR(3)) TEM_MENSAGEM_PII,');

    ADados.SQL.Add('       CAST(CONCAT(RES.ABF_ESTADO,IF(ABF_IME_AMPLEG_NCO <> "" OR ');
    ADados.SQL.Add('          ABF_IME_PTCNOM_NCO <> "" OR ');
    ADados.SQL.Add('          ABF_IME_CONNOM_NCO <> "", 1, 0)) AS CHAR(3)) TEM_MENSAGEM_NCO,');

    ADados.SQL.Add('       CAST(CONCAT(RES.ABF_ESTADO,IF(ABF_IME_AMPLEG_CCO <> "" OR ');
    ADados.SQL.Add('          ABF_IME_PTCNOM_CCO <> "" OR ');
    ADados.SQL.Add('          ABF_IME_CONNOM_CCO <> "", 1, 0)) AS CHAR(3)) TEM_MENSAGEM_CCO,');

    ADados.SQL.Add('       CAST(CONCAT(RES.ABF_ESTADO,IF(ABF_IME_AMPLEG_CNC <> "" OR ');
    ADados.SQL.Add('          ABF_IME_PTCNOM_CNC <> "" OR ');
    ADados.SQL.Add('          ABF_IME_CONNOM_CNC <> "", 1, 0)) AS CHAR(3)) TEM_MENSAGEM_CNC,');

    ADados.SQL.Add('       CAST(CONCAT(RES.ABF_ESTADO,IF(ABF_IME_AMPLEG_SNA <> "" OR ');
    ADados.SQL.Add('          ABF_IME_PTCNOM_SNA <> "" OR ');
    ADados.SQL.Add('          ABF_IME_CONNOM_SNA <> "", 1, 0)) AS CHAR(3)) TEM_MENSAGEM_SNA,');

    ADados.SQL.Add('       CAST(CONCAT(RES.ABF_ESTADO,IF(ABF_IME_AMPLEG_CTA <> "" OR ');
    ADados.SQL.Add('          ABF_IME_PTCNOM_CTA <> "" OR ');
    ADados.SQL.Add('          ABF_IME_CONNOM_CTA <> "", 1, 0)) AS CHAR(3)) TEM_MENSAGEM_CTA,');

    ADados.SQL.Add('       CAST(CONCAT(RES.ABF_ESTADO,IF(ABF_IME_AMPLEG_PRU <> "" OR ');
    ADados.SQL.Add('          ABF_IME_PTCNOM_PRU <> "" OR ');
    ADados.SQL.Add('          ABF_IME_CONNOM_PRU <> "", 1, 0)) AS CHAR(3)) TEM_MENSAGEM_PRU,');

    ADados.SQL.Add('       CAST(CONCAT(RES.ABF_ESTADO,IF(ABF_IME_AMPLEG_IND <> "" OR ');
    ADados.SQL.Add('          ABF_IME_PTCNOM_IND <> "" OR ');
    ADados.SQL.Add('          ABF_IME_CONNOM_IND <> "", 1, 0)) AS CHAR(3)) TEM_MENSAGEM_IND,');

    ADados.SQL.Add('       CAST(CONCAT(RES.ABF_ESTADO,IF(ABF_IME_AMPLEG_TRS <> "" OR ');
    ADados.SQL.Add('          ABF_IME_PTCNOM_TRS <> "" OR ');
    ADados.SQL.Add('          ABF_IME_CONNOM_TRS <> "", 1, 0)) AS CHAR(3)) TEM_MENSAGEM_TRS ');


  ADados.SQL.Add('  FROM ' + cTemporaryName + ' TMP');
  ADados.SQL.Add('INNER JOIN IMENDES_RESULTADO RES ON RES.IME_SEQCON = TMP.IME_SEQCON AND RES.IME_CODITE = TMP.IME_CODITE AND RES.IME_CODEMP = TMP.IME_CODEMP AND RES.ABF_ESTADO = TMP.ABF_ESTADO');

  ADados.SQL.Add('INNER JOIN CADITE C ON C.ITE_CODITE = TMP.IME_CODITE ');

  ADados.SQL.Add('INNER JOIN IMENDES_ITENS ITENS ON ITENS.IME_SEQCON = RES.IME_SEQCON AND ITENS.IME_CODITE = RES.IME_CODITE AND ITENS.IME_CODEMP = RES.IME_CODEMP ');
  ADados.SQL.Add('INNER JOIN ITEGER ON ITEGER.ITE_CODITE = RES.IME_CODITE AND ITEGER.ITE_CODEMP =  RES.IME_CODEMP ');
  ADados.SQL.Add('INNER JOIN CFGSIS TPABPC ON TPABPC.SIS_CODCFG = "CFG_TPABPC" AND TPABPC.SIS_CODEMP =ITEGER.ITE_CODEMP ');



  ADados.SQL.Add('WHERE PAGINA = '+ Pagina.ToString());
  ADados.SQL.Add('ORDER BY RES.IME_SEQUEN, RES.IME_CODEMP, RES.ABF_ESTADO, RES.LOCAL');
end;

function TProcessaImendesRetorno.fCriaTabelaPaginadaAux(pgbProgresso: TcxProgressBar): Boolean;
begin
  FQryDados.SQL.Clear;
  Try
    FQryDados.SQL.Add('DROP TABLE ' + cTemporaryName );
    FQryDados.ExecSQL;
  Except
  End;
  FQryDados.SQL.Clear;

  FQryDados.SQL.Add('SET @SEQUEN := -1;');
  FQryDados.SQL.Add('SET @CODITE := ""; ');
  FQryDados.SQL.Add('SET @PAGINA := 0;');
  FQryDados.SQL.Add('CREATE TEMPORARY TABLE ' + cTemporaryName + '');
  
  FQryDados.SQL.Add('          SELECT  @SEQUEN := IF(@CODITE <> IME_CODITE, @SEQUEN + 1,  @SEQUEN) AS SEQUEN, ');
  FQryDados.SQL.Add('                  @CODITE := IF(@CODITE <> IME_CODITE, IME_CODITE,  @CODITE) AS ITE_SEQUEN, ');
  FQryDados.SQL.Add('          @PAGINA := (@SEQUEN DIV '+ IntToStr(cQtdItensPagina) + ') + 1  AS PAGINA,');
  FQryDados.SQL.Add('                  TMP.* ');
  FQryDados.SQL.Add('           FROM ( SELECT IME_SEQCON, IME_CODITE, ITEM , LOCAL, IME_CODEMP, ABF_ESTADO FROM IMENDES_RESULTADO ');
  FQryDados.SQL.Add('                   WHERE FALSE');
  If FConjFiltroDivergencia <> [] Then
    pDefineFiltroDivergencia(FQryDados, FConjFiltroDivergencia);
  FQryDados.SQL.Add('            ORDER BY IME_SEQUEN');
  FQryDados.SQL.Add('             ');
  FQryDados.SQL.Add('            )TMP');
  FQryDados.SQL.Add('             ORDER BY PAGINA, ITEM, LOCAL ;');
  FQryDados.SQL.Add('    ALTER TABLE `' + cTemporaryName + '` ADD INDEX `idx_tmp_resultado_pagina` (`PAGINA`);');
  FQryDados.SQL.Add('    ALTER TABLE `' + cTemporaryName + '` ADD INDEX `idx_tmp_resultado_filter` (`PAGINA`, `IME_SEQCON`, `IME_CODITE`,  `IME_CODEMP`, `ABF_ESTADO`);');
  FQryDados.ExecSQL;
  FQryDados.SQL.Clear;
  FQryDados.SQL.Add('INSERT INTO ' + cTemporaryName + ' (');
  FQryDados.SQL.Add('SELECT  @SEQUEN := IF(@CODITE <> IME_CODITE, @SEQUEN + 1,  @SEQUEN) AS SEQUEN, ');
  FQryDados.SQL.Add('                  @CODITE := IF(@CODITE <> IME_CODITE, IME_CODITE,  @CODITE) AS ITE_SEQUEN, ');
  FQryDados.SQL.Add('          @PAGINA := (@SEQUEN DIV '+ IntToStr(cQtdItensPagina) + ') + 1  AS PAGINA,');
  FQryDados.SQL.Add('                  TMP.* ');
  FQryDados.SQL.Add('           FROM ( SELECT IME_SEQCON, IME_CODITE, ITEM , LOCAL, IME_CODEMP, ABF_ESTADO FROM IMENDES_RESULTADO ');
  FQryDados.SQL.Add('                   WHERE TRUE ');
  FQryDados.SQL.Add('                     AND ABF_ESTADO <> "" ');
  FQryDados.SQL.Add('                     AND ABF_ESTADO <> "EX" ');
  FQryDados.SQL.Add('             AND IME_SEQCON = "'+FAutoincremImendes+'" AND EXCLUIDO <> "S"');
  FQryDados.SQL.Add('             AND LOCAL = "iMendes"');
  If FConjFiltroDivergencia <> [] Then
    pDefineFiltroDivergencia(FQryDados, FConjFiltroDivergencia);
  FQryDados.SQL.Add('            ORDER BY IME_SEQUEN');
  FQryDados.SQL.Add('             ');
  FQryDados.SQL.Add('            )TMP');
  FQryDados.SQL.Add('             ORDER BY PAGINA, ITEM, LOCAL) ;');

  FQryDados.ExecSQL;

  Result := True;

End;


CLASS function TProcessaImendesRetorno.fEstadoEmpresa(ACodEmp: STring): String;
var QryConsultaInterna: TUniQuery;
begin
  QryConsultaInterna := fCriaQuery;
  Try
    QryConsultaInterna.SQL.Clear;
    QryConsultaInterna.SQL.Add('SELECT CID_ESTADO FROM CADEMP');
    QryConsultaInterna.SQL.Add(' INNER JOIN CADCID ON CID_CODCID = EMP_CODCID');
    QryConsultaInterna.SQL.Add(' WHERE EMP_CODEMP = "'+ACodEmp+'"');
    QryConsultaInterna.Open;

    Result :=  QryConsultaInterna.FieldByName('CID_ESTADO').AsString;
  Finally
    FreeAndNil(QryConsultaInterna)
  End;
end;

function TProcessaImendesRetorno.fSelecionaItensParaGerarAbreviacao: Boolean;
begin
  FQryImemdes_Resultado.SQL.Clear;
  FQryImemdes_Resultado.SQL.Add('SELECT R.*, ');

  FQryImemdes_Resultado.SQL.Add('I.IME_CODNCM,');
  FQryImemdes_Resultado.SQL.Add('I.IME_CDCEST,');
  FQryImemdes_Resultado.SQL.Add('I.IME_CODLUB,');
  FQryImemdes_Resultado.SQL.Add('I.IME_EXCIPI');

  FQryImemdes_Resultado.SQL.Add(' FROM IMENDES_RESULTADO R ');
  FQryImemdes_Resultado.SQL.Add('INNER JOIN IMENDES_ITENS I ON R.IME_SEQCON = I.IME_SEQCON ');
  FQryImemdes_Resultado.SQL.Add('                          AND R.IME_CODITE = I.IME_CODITE ');
  FQryImemdes_Resultado.SQL.Add('                          AND R.IME_CODEMP = I.IME_CODEMP ');

  FQryImemdes_Resultado.SQL.Add(' WHERE R.ABF_ESTADO <> "" ');
  FQryImemdes_Resultado.SQL.Add('   AND R.ABF_ESTADO <> "EX" ');
  FQryImemdes_Resultado.SQL.Add('   AND R.IME_SEQCON = "'+FAutoincremImendes+'" AND R.EXCLUIDO <> "S"');
  FQryImemdes_Resultado.SQL.Add('   AND R.LOCAL = ' + QuotedStr('iMendes'));
  FQryImemdes_Resultado.SQL.Add('   AND R.IME_SEMIME = 0');
  FQryImemdes_Resultado.SQL.Add('   AND R.IME_RETPAR = 0');
  FQryImemdes_Resultado.SQL.Add('   AND I.IME_GERABF <> 1');
  FQryImemdes_Resultado.SQL.Add('   AND IME_DIFICM = 1');

  FQryImemdes_Resultado.SQL.Add(' GROUP BY R.IME_CODITE');
  FQryImemdes_Resultado.SQL.Add(' ORDER BY R.IME_CODITE, R.ABF_ESTADO');

  FQryImemdes_Resultado.Open;
  Result := True;
End;


function TProcessaImendesRetorno.fTemDifIcms: Boolean;
begin
  IF fEmptyStr(FAutoincremImendes) Then
    Exit(False);
  FQryConsulta.SQL.Clear;
  FQryConsulta.SQL.Add('SELECT');
  FQryConsulta.SQL.Add('  IME_SEQCON');
  FQryConsulta.SQL.Add('FROM');
  FQryConsulta.SQL.Add(' IMENDES_ITENS');
  FQryConsulta.SQL.Add('WHERE IME_SEQCON = "'+FAutoincremImendes+'"');
  FQryConsulta.SQL.Add('  AND IME_DIFICM = 1');
  FQryConsulta.SQL.Add('  AND IME_RETPAR = 0');
  FQryConsulta.SQL.Add('  AND IME_SEMIME = 0');
  FQryConsulta.SQL.Add('  LIMIT 1');

  FQryConsulta.Open;

  Result := Not FQryConsulta.IsEmpty
end;

procedure TProcessaImendesRetorno.pCriaTabelaPaginada;
begin
  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    Try
      FQryDados.AfterScroll := nil;
      frmGravando.fExecutarAcao := fCriaTabelaPaginadaAux;
      frmGravando.lblGravando.Caption := 'Gerando tabela paginada dos itens...';
      frmGravando.ShowModal;
      FQryDados.AfterScroll := QryDadosAfterScroll;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TProcessaImendesRetorno.fCriaTabelaTmp]');
      End;
    End;
  Finally
    FreeAndNil(frmGravando);
  End;

end;

procedure TProcessaImendesRetorno.pMontaSQLInfGerais;
begin

end;

class procedure TProcessaImendesRetorno.pRefazResultadoApiSaneamento(strCodAbf: String = '');
  var qryUpdate: TUniQuery;
begin
  qryUpdate := fCriaQuery;
  Try
    If strCodAbf <> '' Then
    Begin
      qryUpdate.SQL.Add('UPDATE IMENDES_PARAM');
      qryUpdate.SQL.Add('       SET STATUS = "P",');
      qryUpdate.SQL.Add('       MAQUINA_ESTADO =12'); //Recria tabela resultado
      qryUpdate.SQL.Add('WHERE IMENDES_PARAM.STATUS = "C" AND IMENDES_PARAM.AUTOINCREM IN (SELECT DISTINCT IME_SEQCON FROM IMENDES_ITENS WHERE IME_CODABF = "'+strCodAbf+'");');
      qryUpdate.SQL.Add('UPDATE IMENDES_ITENS SET IME_REPROS = 1 WHERE IME_CODABF = "'+strCodAbf+'"');

      qryUpdate.ExecSQL;
    End;


  Finally
    FreeAndNil(qryUpdate);
  End;
end;

procedure TProcessaImendesRetorno.pVisualizaProcessosOperador(AOperador: String);
begin
  FQryConsulta.SQL.Clear;
  FQryConsulta.SQl.Add('SELECT IMENDES_PARAM.AUTOINCREM,');
  FQryConsulta.SQl.Add('       CAST(CONCAT(EMP_CODEMP, "-", EMP_NOMEMP) AS CHAR(100)) AS EMPRESA,');
  FQryConsulta.SQl.Add('       DATA ,');
  FQryConsulta.SQl.Add('       IFNULL(MAQUINA_ESTADO, 0) AS MAQUINA_ESTADO ,');
  FQryConsulta.SQl.Add('       DESCRICAO,');
  FQryConsulta.SQl.Add('       CAST(CASE');
  FQryConsulta.SQl.Add('              WHEN IFNULL(MAQUINA_ESTADO, 0) = 0 THEN "Pendente"');
  FQryConsulta.SQl.Add('              WHEN MAQUINA_ESTADO = 1 THEN "Iniciando Processo"');
  FQryConsulta.SQl.Add('              WHEN MAQUINA_ESTADO = 2 THEN "Criando Estrutura"');
  FQryConsulta.SQl.Add('              WHEN MAQUINA_ESTADO = 3 THEN "Processando"');
  FQryConsulta.SQl.Add('              WHEN MAQUINA_ESTADO = 4 THEN "Finalizado"');
  FQryConsulta.SQl.Add('              WHEN MAQUINA_ESTADO = 5 THEN "Finalizado Sem Item"');
  FQryConsulta.SQl.Add('              WHEN MAQUINA_ESTADO = 6 THEN "Finalizado com Erro"');
  FQryConsulta.SQl.Add('              WHEN MAQUINA_ESTADO = 7 THEN "Finalizado Pelo Autcom"');
  FQryConsulta.SQl.Add('              WHEN MAQUINA_ESTADO = 8 THEN "Finalizado por falha de Autenticação"');
  FQryConsulta.SQl.Add('            END AS CHAR(40)) AS STATUS,');
  FQryConsulta.SQl.Add('       (SELECT COUNT(1)   ');
  FQryConsulta.SQl.Add('          FROM IMENDES_LOGTHREAD   ');
  FQryConsulta.SQl.Add('         WHERE IMENDES_LOGTHREAD.IME_SEQCON = IMENDES_PARAM.AUTOINCREM) QTD_ERROS,  ');
  FQryConsulta.SQl.Add('       CONCAT(PROCESSADOS, "/",TOTAL_PARA_PROCESSAR) AS PROGRESSO');
  FQryConsulta.SQl.Add('  FROM IMENDES_PARAM');
  FQryConsulta.SQl.Add('  INNER JOIN CADEMP ON EMP_CODEMP =  IMENDES_PARAM.EMPRESA');



  FQryConsulta.SQl.Add(' WHERE IME_VISPRO = 1');
  FQryConsulta.SQl.Add(' ORDER BY DATA DESC');

  FQryConsulta.Open;

  If FQryConsulta.IsEmpty Then
  Begin
    pMensagemOk('Não existe processos agendados para este operador!');
    Exit;

  End;

  pCriarFormularios(TfrmImendesProcessos, frmImendesProcessos);
  Try
    FAutoincremImendes := '';
    frmImendesProcessos.strAutIncSel := '';
    frmImendesProcessos.dtsDados.DataSet := FQryConsulta;
    frmImendesProcessos.strAutIncSel := FAutoincremImendes;
    frmImendesProcessos.ShowModal;
    FAutoincremImendes := frmImendesProcessos.strAutIncSel;

  Finally
    FreeAndNil(frmImendesProcessos);
  End;
end;

procedure TProcessaImendesRetorno.QryDadosAfterScroll(DataSet: TDataSet);
begin

end;

end.




