unit untMapaDeControleContagemBalancoEstoque;

interface

uses sysUtils, classes, untZClient, untFuncoesSimples, Uni, strUtils, Data.DB;

Type
  TTipoFiltroConBal = (tcbTodos, tcpComContagem, tcpSemContagem);
  TMapaDeControleContagemBalancoEstoque = class
  private
    FQuantidadeContagem: Integer;
    qryComand: TUniQuery;
    MarcaDesmacaGeral: Boolean;
    procedure pAbreConsulta(strLocFisIni, strLocFisFim: String; blnCreate: Boolean = False);
    function fGetFiltroLocFis(strLocFisIni, strLocFisFim: String): String;
    procedure pMontaSQLComparativoDetalhe(IntPosicao: Integer);
    procedure pRemoveBaldet(AAutinc: String; AIncGer: string);
    procedure pRemoveBalger(AAutInc: String);
    procedure OncdsContagemBeforePost(DataSet: TDataSet);


    procedure pMontaSQLComparativo;

  public
    cdsContagem: TZClient;
    constructor create;
    Destructor  Destroy; override;
    procedure pSetFiltro(TipoFiltroConBal: TTipoFiltroConBal; strLocFisIni: String; strLocFisFim: String; blnForcaAbertura: Boolean = False);
    property intQuantidadeContagem: integer read FQuantidadeContagem;
    procedure pMarcarDesmarcaAbertos(blnMarcar: Boolean);
    procedure ExcluirContagensAberta;

End;

implementation

{ TMapaDeControleContagemBalancoEstoque }

constructor TMapaDeControleContagemBalancoEstoque.Create;
begin
  cdsContagem := TZClient.Create(nil);
  FQuantidadeContagem := fCfgSis('QCRBEA', varInteger);
  pAbreConsulta('', '', True);
  qryComand := fCriaQuery;
  MarcaDesmacaGeral := False;
end;

destructor TMapaDeControleContagemBalancoEstoque.destroy;
begin
  FreeAndNil(cdsContagem);
  FreeAndNil(qryComand);
end;

procedure TMapaDeControleContagemBalancoEstoque.ExcluirContagensAberta;
var i: integer;
begin
  cdsContagem.First;
  fStartTransaction;
  Try
    while not cdsContagem.Eof do
    begin
      If cdsContagem.FieldByName('MARCADO').AsString = 'S' Then
      Begin
        For i := 1 To FQuantidadeContagem do
        begin
          If (cdsContagem.FieldByName('INCDET' + i.ToString).AsString <> '') Then
           pRemoveBaldet(cdsContagem.FieldByName('INCDET' + i.ToString).AsString, cdsContagem.FieldByName('AUTOINCREM').AsString);
        End;
        pRemoveBalger(cdsContagem.FieldByName('AUTOINCREM').AsString);
      End;
      cdsContagem.Next;
    End;
    fCommit;
  Except
    on e: Exception do
    begin
      fRollback;
      pMensagensErro(e.message, '[TMapaDeControleContagemBalancoEstoque.ExcluirContagensAberta]');
    End;
  End;

end;

procedure TMapaDeControleContagemBalancoEstoque.pAbreConsulta(strLocFisIni, strLocFisFim: String; blnCreate: Boolean = False);
var i: integer;
begin
  FreeAndNil(cdsContagem);
  cdsContagem := TZClient.Create(nil);
  cdsContagem.qryQuery.SQL.Clear;
  cdsContagem.qryQuery.SQL.Add('SELECT BALGER.AUTOINCREM,');
  cdsContagem.qryQuery.SQL.Add('       ITE_DESITE,');
  cdsContagem.qryQuery.SQL.Add('       BLG_STATUS,');
  cdsContagem.qryQuery.SQL.Add('       CON1.BLD_CODITE,');
  cdsContagem.qryQuery.SQL.Add('       BLG_LOCFIS,');
  cdsContagem.qryQuery.SQL.Add('       CAST("N" AS CHAR(1)) AS MARCADO,');
  For i := 1 to FQuantidadeContagem  do
  Begin
    cdsContagem.qryQuery.SQL.Add('       IFNULL(CON' + IntToStr(i) + '.BLD_QTDITE, -1) AS CONTAGEM_' + IntToStr(i) + ',' );
    cdsContagem.qryQuery.SQL.Add('       CAST(CONCAT(OPE' + IntToStr(i) + '.OPE_CODOPE, "-", OPE' + IntToStr(i) + '.OPE_NOMOPE) AS CHAR(60)) AS OPE_' + IntToStr(i) + ',' );
    cdsContagem.qryQuery.SQL.Add('       CON' + IntToStr(i) + '.BLD_STATUS AS BLD_STATUS' + IntToStr(i) + ', ');

  End;

  For i := 1 to FQuantidadeContagem  do
    cdsContagem.qryQuery.SQL.Add('CON'+i.ToString+'.AUTOINCREM AS INCDET' + i.ToString + ',');

  cdsContagem.qryQuery.SQL.Add('  IF(CON1.BLD_EFECON  > 0, 1, 0) AS FINALIZADA, ');
  cdsContagem.qryQuery.SQL.Add('    IF(BLG_STATUS = "A", CON1.BLD_STATUS = "A"');

  For i := 2 to FQuantidadeContagem  do
  Begin
    cdsContagem.qryQuery.SQL.Add(' OR CON' + IntToStr(i) + '.BLD_STATUS = "A"')
  End;
  cdsContagem.qryQuery.SQL.Add('    , FALSE) EM_CONTAGEM, ');

  pMontaSQLComparativo;

  cdsContagem.qryQuery.SQL.Add('       CON1.BLD_EFECON ');
  cdsContagem.qryQuery.SQL.Add('  FROM BALGER');
  cdsContagem.qryQuery.SQL.Add(' LEFT JOIN BALDET CON1 ON CON1.BLD_SEQGER = BALGER.AUTOINCREM AND CON1.BLD_NUMCON = 1');
  cdsContagem.qryQuery.SQL.Add(' LEFT JOIN CADOPE OPE1 ON OPE1.OPE_CODOPE = CON1.BLD_CODOPE');
  For i := 2 to FQuantidadeContagem  do
  Begin
    cdsContagem.qryQuery.SQL.Add('  LEFT JOIN BALDET CON' + IntToStr(i) + ' ON CON' + IntToStr(i) + '.BLD_SEQGER = BALGER.AUTOINCREM ');
    cdsContagem.qryQuery.SQL.Add('                                         AND CON' + IntToStr(i) + '.BLD_NUMCON = ' + IntToStr(i));
    cdsContagem.qryQuery.SQL.Add('                                         AND CON' + IntToStr(i) + '.BLD_CODITE = CON1.BLD_CODITE');

    cdsContagem.qryQuery.SQL.Add(' LEFT JOIN CADOPE OPE' + IntToStr(i) + ' ON OPE' + IntToStr(i) + '.OPE_CODOPE = CON' + IntToStr(i) + '.BLD_CODOPE');

  End;
  cdsContagem.qryQuery.SQL.Add(' LEFT JOIN CADITE ON ITE_CODITE  = CON1.BLD_CODITE');
  cdsContagem.qryQuery.SQL.Add(' WHERE BLG_STATUS <> "C"');
  cdsContagem.qryQuery.SQL.Add('   AND BLG_CODEMP = "' + VS_StrCodEmp + '"');
  If blnCreate Then
    cdsContagem.qryQuery.SQL.Add('   AND FALSE ')
  Else
    cdsContagem.qryQuery.SQL.Add('   ' + fGetFiltroLocFis(strLocFisIni, strLocFisFim) );

  cdsContagem.qryQuery.SQL.Add(' GROUP BY BALGER.AUTOINCREM, CON1.BLD_SEQGER, CON1.BLD_NUMCON, CON1.BLD_CODITE');


  cdsContagem.fAbreClient(True, '[TMapaDeControleContagemBalancoEstoque.pAbreConsulta]');


  cdsContagem.BeforePost := OncdsContagemBeforePost;
end;

function TMapaDeControleContagemBalancoEstoque.fGetFiltroLocFis(strLocFisIni, strLocFisFim: String): String;
var strMaior: String;
begin
  If fEmptyStr(strLocFisIni +  strLocFisFim) Then
    Exit('');

  If Length(strLocFisIni) > Length(strLocFisFim) Then
    strMaior :=  strLocFisIni
  Else
    strMaior :=  strLocFisFim;

  If (Not fEmptyStr(strLocFisFim)) Then
    Result :=  ' AND LEFT(BLG_LOCFIS, LENGTH("'+strMaior+'")) BETWEEN "' + strLocFisIni + '" AND "'+strLocFisFim+'" '
  Else
    Result := '  AND BLG_LOCFIS LIKE "'+strLocFisIni+'" ';
End;


procedure TMapaDeControleContagemBalancoEstoque.OncdsContagemBeforePost(DataSet: TDataSet);
begin

  If ((DataSet.FieldByName('FINALIZADA').AsInteger <> 0) or
     (DataSet.FieldByName('EM_CONTAGEM').AsInteger = 1)) and
     (DataSet.FieldByName('MARCADO').AsString = 'S') Then
  Begin
    DataSet.FieldByName('MARCADO').AsString := 'N';
    If not MarcaDesmacaGeral Then
    begin
      If DataSet.FieldByName('FINALIZADA').AsInteger = 1 Then
        pMensagemOk('O Registro esta com a contagem finalizada, utilizar a rotina limpar contagem!')
      Else
        pMensagemOk('O Registro esta em contagem, não pode ser marcada!');
    End;
  End
end;

procedure TMapaDeControleContagemBalancoEstoque.pMontaSQLComparativoDetalhe(IntPosicao: Integer);
var strSQL, strSQLIni: String;
    strField: String;
    strOtherField: String;
    i: integer;
Begin
  If IntPosicao = FQuantidadeContagem Then
    Exit;
  strSQLIni := 'IF(CON' + IntToStr(IntPosicao) + '.BLD_QTDITE > -1, ';
  strField := 'CON' + IntToStr(IntPosicao) + '.BLD_QTDITE';
  strSQL := '';
  For i := 1 To FQuantidadeContagem -1 do
  begin
    strOtherField := ' CON' + IntToStr(i) + '.BLD_QTDITE';
    If i <> IntPosicao then
    Begin
      If strSQL <> '' Then
        strSQL := strSQL + ' OR ';
      strSQL := strSQL + strField + ' = ' + strOtherField
    End
  End;
  If strSQL <> '' Then
    cdsContagem.qryQuery.SQL.Add(strSQLIni + strSQL + ' , -1) AS CONEFE' + IntToStr(IntPosicao) + ', ');


End;

procedure TMapaDeControleContagemBalancoEstoque.pRemoveBaldet(AAutinc: String; AIncGer: string);
begin
  qryComand.SQL.Clear;
  qryComand.SQL.Add('DELETE FROM BALDET WHERE AUTOINCREM IN ("'+AAutinc+'")');
  qryComand.ExecSQL;
  qryComand.sql.Clear;
  qryComand.SQL.Add('UPDATE BALGER SET BLG_STATUS = "F" ');
  qryComand.SQL.Add(' WHERE BALGER.AUTOINCREM =  "'+AIncGer+'"');
  qryComand.SQL.Add('   AND BLG_STATUS = "A"');
  qryComand.SQL.Add('   AND (SELECT COUNT(1)');
  qryComand.SQL.Add('          FROM BALDET');
  qryComand.SQL.Add('         WHERE BALDET.BLD_SEQGER = "A"');
  qryComand.SQL.Add('           AND BALGER.AUTOINCREM = "'+AIncGer+'") = 0');
  qryComand.ExecSQL;
end;

procedure TMapaDeControleContagemBalancoEstoque.pRemoveBalger(AAutInc: String);
begin
  qryComand.SQL.Clear;
  qryComand.SQL.Add('DELETE FROM BALGER WHERE AUTOINCREM IN ("'+AAutinc+'")');
  qryComand.SQL.Add('   AND (SELECT COUNT(1) FROM BALDET WHERE BALDET.BLD_SEQGER = BALGER.AUTOINCREM) = 0');
  qryComand.ExecSQL;

end;

procedure TMapaDeControleContagemBalancoEstoque.pMarcarDesmarcaAbertos(
  blnMarcar: Boolean);
begin
  cdsContagem.First;
  MarcaDesmacaGeral := True;
  Try

    while not cdsContagem.Eof do
    begin
      If cdsContagem.FieldByName('FINALIZADA').AsInteger = 0 Then
      Begin
        cdsContagem.Edit;
        cdsContagem.FieldByName('MARCADO').AsString  := IIf(blnMarcar, 'S', 'N');
        cdsContagem.Post;

      End;
      cdsContagem.Next;
    End;
  Finally
    MarcaDesmacaGeral := False;
  End;
  {}
end;

procedure TMapaDeControleContagemBalancoEstoque.pMontaSQLComparativo;
var i: integer;
begin
  For i := 1 to FQuantidadeContagem do
    pMontaSQLComparativoDetalhe(i)
end;

procedure TMapaDeControleContagemBalancoEstoque.pSetFiltro(TipoFiltroConBal: TTipoFiltroConBal; strLocFisIni: String; strLocFisFim: String; blnForcaAbertura: Boolean = False);
begin
  If blnForcaAbertura Then
     pAbreConsulta(strLocFisIni, strLocFisFim);

  cdsContagem.Filtered := False;
  case TipoFiltroConBal of
    tcpComContagem    :  cdsContagem.Filter := 'BLD_EFECON <> 0';
    tcpSemContagem :  cdsContagem.Filter := 'BLD_EFECON = NULL ';
  End;

  If TipoFiltroConBal <> tcbTodos Then
    cdsContagem.Filtered := True;

end;

end.
