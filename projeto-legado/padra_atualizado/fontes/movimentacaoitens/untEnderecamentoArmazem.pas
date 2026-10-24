unit untEnderecamentoArmazem;

interface

uses StrUtils, SysUtils, Classes, Forms, DB, untTypesSistema, untZClient,
     Uni, Controls, EditFocus, UniClientDataSet, cxProgressBar,
     Math, ComCtrls, untCadLote, Variants, untTransferenciaArmazens, untEnderecamentoProduto,
     untFuncoes, untValidaCapacidadeMaximaLote;

Type
  TEnderecamentoArmazem = Class (TCadLot)
  Private
    FblnValidar: Boolean;
    FEhProdutoGarantia : Boolean;
    FQtdEnd: Double; // QUANTIDADE DE UM ITEM A SER ENDEREÇADA PARA OS ARMAZENS
    FArmaze: TUniClientDataSet;
    FTransf: TTransferenciaArmazens;
    FProgre: TProgressBar;

    blnUsaWMS: Boolean;
    intDecQtd: Integer;

    FTotalTransfLotes: TZClient;

    FendDocumento: TEndDocumento;

    FstrSQLLoteItens: String;

    Function fLeArmazem(Var strNumLot: String): Boolean;

    Procedure pCriaArmazensItens(Var cdsArmaze: TUniClientDataSet);

    (*****************************************************************************)
    (* INSERE/ATUALIZA UM ARMAZEM NO CLIENT DE ARMAZENS                          *)
    (**************************************************************************LA*)
    Procedure pInsereArmazem(qryLotIte: TUniQuery; strAutDet, strAmzOri: String; fltQtdOri: Double; blnInserir: Boolean; blnCrosDoc: Boolean = False);

    (*****************************************************************************)
    (* ATUALIZA NO CADLOT A CAPACIDADE DOS ARAMAZENS DE UM ARMAZEM ITEM          *)
    (**************************************************************************LA*)
    Procedure pSalvaCapacidadeArmazens;

    (*****************************************************************************)
    (* ATUALIZA O TOTAL JA TRANSFERIDO PARA CADA ARMAZEM                         *)
    (* EM TODO O DOCUMENTO DE ENDERECAMENTO                                      *)
    (**************************************************************************LA*)
//    Procedure pAtualizaTotalTransferido(strCodIte: String);

    Procedure pAtualizaTotalTransferido(strCodIte, strNumLot: String; fltQtdIte: Double);

    Function fGetTotalTransferido(strCodIte, strNumLot: String): Double;

//    Function fRetOldValue(strAutInc, strCodIte, strNumLot: String): Double;

    (*****************************************************************************)
    (* ATUALIZA NO CADLOT A CAPACIDADE DE UM ARMAZEM                             *)
    (**************************************************************************LA*)
    Procedure pAlteraCapacidadeArmazem(strCodIte, strNumLot: String; fltCapaci: Double);

    Procedure pAtualizaSaldosArmazens;

    Procedure pSetaLoteUnico(dataSet: TDataSet; strSetaLote: String; fltQtdIte: Double; Var strArmazem, strLocali, strDesAmz: String);

    (*****************************************************************************)
    (* RETORNA O SALDO E A CAPACIDADE DE UM ARMAZEM                              *)
    (**************************************************************************LA*)
    Procedure pRetCapacidadeSaldoArmazem(strCodIte, strNumLot: String;
                      Var fltCapaci, fltSaldos: Double);

    (*****************************************************************************)
    (* ATUALIZA O CLIENT DE ARMAZENS COM AS ALTERACOES DO USUARIO                *)
    (**************************************************************************LA*)
    Procedure pSalvaAlteracaoArmazens(cdsItens: TUniClientDataSet);

    Function fAtualizaArmazemTodosItem(strSQLLoteItens: String): Boolean;

    Function fAtualizaArmazemTodosItemPrg(prgProgresso: TcxProgressBar): Boolean;

{
    (*****************************************************************************)
    (* RETORNA A QUANTIDADE TRANSFERIDA DE UM ARMAZEM                            *)
    (* EM TODO O DOCUMENTO DE ENDERECAMENTO                                      *)
    (**************************************************************************LA*)
    Function fRetQuantidadeTransferida(cdsArmaze: TUniClientDataSet;
                                       strCodIte, strNumLot, strAutDet: String): Double; }

    Function fSQLTotalTransfLotes: String;
    procedure pSetaAutEntCdsItens(ACdsItens: TUniClientDataSet; AStrAutEnt: String);


  Public
    stlMesagemErros: TStringList;

    function fExisteItemEnderecado(cdsItens: TUniClientDataSet): Boolean;
    function fExistemItensEnderecado(cdsItens: TUniClientDataSet): Boolean;
    Function fExistemTodosProdutoAcabadosComLocFis(cdsItens: TUniClientDataSet): Boolean;

    Procedure pInformaArmazemUnico(cdsConsulta: TUniClientDataSet);

    Procedure pImprimeTransfArmazens;

    (*****************************************************************************)
    (* VALIDA AS QUANTIDADES TRANSFERIDAS EM                                     *)
    (* EM TODO O DOCUMENTO DE ENDERECAMENTO                                      *)
    (**************************************************************************LA*)
    Function fValidaEnderecamentos(cdsItens: TUniClientDataSet): Boolean;

    Procedure pAtualizaScrollArmazens(cdsItens: TUniClientDataSet; strArmazem, strLocFis, strAmzDes: String);

    (*****************************************************************************)
    (* GRAVA UM DOCUMENTO TRANSFERINDO ESTOQUE ENTRE OS ARMAZENS                 *)
    (* NO ENDERECAMENTO DE PRODUTO                                               *)
    (**************************************************************************LA*)
    Function fGeraDocumentoTransfArmazens(Var strNumDoc, strEspDoc, strCodCli : String; strSeqDocOri: String;
                                          endDocumento: TEndDocumento; AEnderecamentoProduto: TEnderecamentoProduto = nil):Boolean; overload;


    (*****************************************************************************)
    (* CARREGA NO CLIENT DE ARMAZENS TODOS OS ARMAZENS DOS ITENS DE UM DOCUMENTO *)
    (* DE ENDEREÇAMENTO                                                          *)
    (**************************************************************************LA*)
    Procedure pAtualizaArmazens(cdsItens: TUniClientDataSet; blnReiniciar: Boolean; strSQLLoteItens: String);

    (*****************************************************************************)
    (* ATUALIZA NO CLIENT DE ARMAZENS TODOS OS ARMAZENS DE UM ITEM               *)
    (**************************************************************************LA*)
    Procedure pAtualizaArmazemItem(strCodIte, strAutDet, strAmzOri: String; fltQtdOri: Double);

    (*****************************************************************************)
    (* ABRE A TELA COM OS ARMAZENS DO ITEM PARA A TRANSFERENCIA DE SALDO         *)
    (* NO ENDERECAMENTO DE PRODUTO                                               *)
    (**************************************************************************LA*)
    Function fEnderecaArmazens(strCodIte, strDescri, strAutInc, strArmOri: String; fltQtdIte: Double; blnEhProdutoGarantia : Boolean;
                                    Var strArmazem, strLocali, strDesAmz: String; strSetaLote: String = ''; strAutEnt: String = ''): Boolean;


    Procedure pCarregaArmazensEnderecados(strCodIte, strAutInc : String; Var cdsDados : TUniClientDataSet);

    Function fQuantidadeTransferidaArmazens(AAutoIncrem: String = ''): Double;

    Function fGravaOperadorConferente(strOperador, strConferente: string; EndDocumento: TEndDocumento; strObservacao: String): boolean;

    Procedure pCopiarItens(cdsDestino: TUniClientDataSet; strCodIte: string = ''; strAutInc: string = ''; strLotCad: String = '');

    (*****************************************************************************)
    (* VALIDA AS INFORMACOES ANTES DA GRAVACAO DA TRANSFERENCIA PARA UM ARMAZEM  *)
    (**************************************************************************LA*)
    Procedure pArmazemBeforePost(DataSet: TDataSet);

    Function fValidaArmazem(DataSet: TDataSet; blnDarMsgErro: Boolean; fltQtdIte: Double): Boolean;

    Constructor Create(Owner: TComponent; prgProgresso: TProgressBar); Reintroduce;

    Destructor Destroy; Reintroduce;

    Property endDocEnderecamento: TEndDocumento Read FendDocumento;
    function fValidar(blnValidar: Boolean): TEnderecamentoArmazem;
  end;

implementation

Uses
  untEntEnderecamentoArmazens, untGravando,
  untLeArmazem, untFuncoesSimples;

constructor TEnderecamentoArmazem.Create(Owner: TComponent; prgProgresso: TProgressBar);
begin
  inherited Create(Owner);
  FblnValidar := False;
  intDecQtd := fCfgSis('DEQTEM', varInteger);

  blnUsaWMS := fUsaRotinaWMS;

  FEhProdutoGarantia := False;
  FProgre := prgProgresso;
  FArmaze := Nil;
  stlMesagemErros := TStringList.Create;

  FillChar(FendDocumento, Sizeof(FendDocumento), #0);

  FTotalTransfLotes := TZClient.Create(Self, fSQLTotalTransfLotes);
end;

Function TEnderecamentoArmazem.fSQLTotalTransfLotes: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   LOT_CODITE AS CODITE, ';
  strSQL := strSQL + '   LOT_NUMLOT AS NUMLOT, ';
  strSQL := strSQL + '   0.0000     AS QTDITE  ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADLOT ';
  strSQL := strSQL + ' WHERE FALSE ';

  Result := strSQL;
End;

Procedure TEnderecamentoArmazem.pAtualizaTotalTransferido(strCodIte, strNumLot: String; fltQtdIte: Double);
Begin
  With FTotalTransfLotes Do
  Begin

    If FindKey([strCodIte , strNumLot]) Then
    Begin
      Edit;
      FieldByName('QTDITE').AsFloat  := FieldByName('QTDITE').AsFloat + fltQtdIte;
    End Else
    Begin
      Insert;
      FieldByName('CODITE').AsString := strCodIte;
      FieldByName('NUMLOT').AsString := strNumLot;
      FieldByName('QTDITE').AsFloat  := fltQtdIte;
    End;

    Post;
  End;
End;

Function TEnderecamentoArmazem.fGetTotalTransferido(strCodIte, strNumLot: String): Double;
Begin
  With FTotalTransfLotes Do
  Begin
    If Not Active Then
    Begin
      Result := 0;
      Exit;
    End;

    If FindKey([strCodIte , strNumLot]) Then
      Result := FieldByName('QTDITE').AsFloat
    Else
      Result := 0;

  End;
End;

{Function TEnderecamentoArmazem.fRetOldValue(strAutInc, strCodIte, strNumLot: String): Double;
Begin
  With FArmaze Do
  Begin
    If Not Active Then
    Begin
      Result := 0;
      Exit;
    End;

   If Locate('AUTINC;CODITE;NUMLOT',
              VarArrayOf([strAutInc, strCodIte, strNumLot]), []) Then
      Result := FieldByName('QTDITE').AsFloat
    Else
      Result := 0;

  End;
End;}

function TEnderecamentoArmazem.fValidar(
  blnValidar: Boolean): TEnderecamentoArmazem;
begin
  Result := Self;
  FblnValidar := blnValidar;
end;

Destructor TEnderecamentoArmazem.Destroy;
Begin
  If Assigned(FArmaze) Then
  Begin
    FArmaze.EmptyDataSet;
    FreeAndNil(FArmaze);
  End;

  If Assigned(stlMesagemErros) Then
    FreeAndNil(stlMesagemErros);

  inherited;
End;

Procedure TEnderecamentoArmazem.pCriaArmazensItens(Var cdsArmaze: TUniClientDataSet);
Begin
  cdsArmaze := TUniClientDataSet.Create(Self);

  With cdsArmaze, FieldDefs Do
  Begin
    AggregatesActive := True;

    With AddFieldDef Do Begin Name := 'AUTINC'; DataType := ftString; Required := False; End;
    With AddFieldDef Do Begin Name := 'CODITE'; DataType := ftString; Required := False; End;
    With AddFieldDef Do Begin Name := 'NUMLOT'; DataType := ftString; Required := False; Size := VS_Size_NumLot; End;
    With AddFieldDef Do Begin Name := 'ARMORI'; DataType := ftString; Required := False; Size := VS_Size_NumLot; End;
    With AddFieldDef Do Begin Name := 'ARMDES'; DataType := ftString; Required := False; Size := VS_Size_NumLot; End;
    With AddFieldDef Do Begin Name := 'LOCFIS'; DataType := ftString; Required := False; End;
    With AddFieldDef Do Begin Name := 'DTAVAL'; DataType := ftDate;   Required := False; End;
    With AddFieldDef Do Begin Name := 'CAPANT'; DataType := ftFloat;  Required := False; End;
    With AddFieldDef Do Begin Name := 'CAPACI'; DataType := ftFloat;  Required := False; End;
    With AddFieldDef Do Begin Name := 'SALDOS'; DataType := ftFloat;  Required := False; End;
    With AddFieldDef Do Begin Name := 'QTDITE'; DataType := ftFloat;  Required := False; End;
    With AddFieldDef Do Begin Name := 'QTDTOT'; DataType := ftFloat;  Required := False; End;
    With AddFieldDef Do Begin Name := 'AMZDES'; DataType := ftString; Size := 30; Required := False; End;
    With AddFieldDef Do Begin Name := 'DTAFAB'; DataType := ftDateTime; Required := False; End;
    With AddFieldDef Do Begin Name := 'AUTENT'; DataType := ftString; Size := 20; Required := False; End;

    With TAggregateField.Create(cdsArmaze) Do
    Begin
      FieldName := 'TOTDIG';
      DataSet := cdsArmaze;
      Expression := 'SUM(QTDITE)';
      Active := True;
    End;

    CreateDataSet;
    Open;

    TFloatField(FieldByName('QTDITE')).DisplayFormat := fMskDigitos(intDecQtd);
    TFloatField(FieldByName('SALDOS')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
    TFloatField(FieldByName('CAPACI')).DisplayFormat := fMskDigitos(intDecQtd);
    TFloatField(FieldByName('QTDTOT')).DisplayFormat := fMskDigitos(intDecQtd);

    IndexFieldNames := 'AUTINC;CODITE;NUMLOT';

  End;

End;

(*****************************************************************************)
(* INSERE/ATUALIZA UM ARMAZEM NO CLIENT DE ARMAZENS                          *)
(**************************************************************************LA*)
Procedure TEnderecamentoArmazem.pInsereArmazem(qryLotIte: TUniQuery; strAutDet, strAmzOri: String; fltQtdOri: Double; blnInserir: Boolean; blnCrosDoc: Boolean = False);
var
  qryGenTemp: TUniQuery;

  Procedure pSetaQuantidade;
  Begin
    With FArmaze Do
    Begin
      FieldByName('QTDITE').AsFloat  := fltQtdOri;
      FieldByName('QTDTOT').AsFloat  := fltQtdOri;

      pAtualizaTotalTransferido(qryLotIte.FieldByName('LOT_CODITE').AsString,
                                qryLotIte.FieldByName('LOT_NUMLOT').AsString,
                                fltQtdOri);
    End;
  End;

Begin
  With FArmaze Do
  Begin

    If blnInserir Then
    Begin
      Insert;
      FieldByName('QTDITE').AsFloat  := 0;
      FieldByName('QTDTOT').AsFloat  := 0;
      FieldByName('AUTENT').AsString  := '';
      If fEmptyStr(strAmzOri) Then
        FieldByName('ARMORI').AsString := 'A DEFINIR'
      Else
      Begin
        FieldByName('ARMORI').AsString := strAmzOri;

        If blnCrosDoc Then
        Begin

          If (qryLotIte.FieldByName('LOT_CRODOC').AsString = 'S') Then
            pSetaQuantidade;

        End

        Else If (qryLotIte.FieldByName('LOT_NUMLOT').AsString = strAmzOri) Then
          pSetaQuantidade;

      End;

    End

    Else

    Begin
      Edit;
    End;

    {Select utilizada para buscar os campos atuais da tabela}
    if (Not(blnInserir)) then
    Begin
      Try
        qryGenTemp:= fCriaQuery(Self);

        qryGenTemp.Close;
        qryGenTemp.SQL.Clear;
        qryGenTemp.SQL.Add('SELECT LOT_NUMLOT, LOT_LOCFIS FROM CADLOT WHERE LOT_CODITE = :LOT_CODITE AND LOT_CODEMP = :LOT_CODEMP');
        qryGenTemp.ParamByName('LOT_CODITE').AsString:= qryLotIte.FieldByName('LOT_CODITE').AsString;
        qryGenTemp.ParamByName('LOT_CODEMP').AsString:= qryLotIte.FieldByName('LOT_NUMLOT').AsString;
        qryGenTemp.Open;

      Finally

        if AsSigned(qryGenTemp) then
          FreeAndNil(qryGenTemp);

      End;

    End;


    FieldByName('AUTINC').AsString := strAutDet;
    FieldByName('CODITE').AsString := qryLotIte.FieldByName('LOT_CODITE').AsString;
    FieldByName('NUMLOT').AsString := qryLotIte.FieldByName('LOT_NUMLOT').AsString;
    FieldByName('ARMDES').AsString := qryLotIte.FieldByName('LOT_NUMLOT').AsString;
    FieldByName('LOCFIS').AsString := qryLotIte.FieldByName('LOT_LOCFIS').AsString;
    FieldByName('DTAVAL').Value    := qryLotIte.FieldByName('LOT_DTAVAL').Value;
    FieldByName('CAPANT').AsFloat  := qryLotIte.FieldByName('LOT_CAPACI').AsFloat;
    FieldByName('CAPACI').AsFloat  := qryLotIte.FieldByName('LOT_CAPACI').AsFloat;
    FieldByName('SALDOS').AsFloat  := qryLotIte.FieldByName('LOT_SALDOS').AsFloat;
    FieldByName('AMZDES').AsString := qryLotIte.FieldByName('AMZDES').AsString;
    FieldByName('DTAFAB').AsDateTime := qryLotIte.FieldByName('LOT_DTAFAB').AsDateTime;
    Post;

  End;
End;

(*****************************************************************************)
(* ATUALIZA NO CLIENT DE ARMAZENS TODOS OS ARMAZENS DE UM ITEM               *)
(**************************************************************************LA*)
Procedure TEnderecamentoArmazem.pAtualizaArmazemItem(strCodIte, strAutDet, strAmzOri: String; fltQtdOri: Double);
  Var
    qryLotIte: TUniQuery;
Begin
  qryLotIte := fCriaQuery;
  With qryLotIte, SQL Do
  Begin
    Clear;
    Add('SELECT CADLOT.*, AMZ_DESCRI AS AMZDES FROM CADLOT');
    Add('LEFT JOIN CADAMZ A ON LOT_NUMLOT = AMZ_CODAMZ AND AMZ_CODEMP = LOT_CODEMP ');

    Add('WHERE');
    Add('  LOT_NUMLOT <> "A DEFINIR" AND ');
    Add('  LOT_CODITE = :CODITE      AND ');
    Add('  LOT_CODEMP = :CODEMP      AND ');
    Add('  LOT_STATUS = "S"              ');

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;

    While Not Eof Do
    Begin

      If Not FArmaze.Locate('AUTINC;CODITE;NUMLOT', VarArrayOf([strAutDet, strCodIte, FieldByName('LOT_NUMLOT').AsString]), []) Then
      Begin
        pInsereArmazem(qryLotIte, strAutDet, strAmzOri, fltQtdOri, True);
      End Else
      Begin
        pInsereArmazem(qryLotIte, strAutDet, strAmzOri, fltQtdOri, False);
      End;

      Next;
    End;
  End;

  FreeAndNil(qryLotIte);
End;

(*****************************************************************************)
(* CARREGA NO CLIENT DE ARMAZENS TODOS OS ARMAZENS DOS ITENS DE UM DOCUMENTO *)
(* DE ENDEREÇAMENTO                                                          *)
(**************************************************************************LA*)
Procedure TEnderecamentoArmazem.pAtualizaArmazens(cdsItens: TUniClientDataSet; blnReiniciar: Boolean; strSQLLoteItens: String);
  Var
    intRecNo: Integer;
Begin
  With cdsItens Do
  Begin
    If (IsEmpty) And (Not Active) Then
      Exit;

    DisableConstraints;
    intRecNo := RecNo;
    If State = dsEdit Then
      Cancel;

    If Not Assigned(FArmaze) Then
    Begin
      pCriaArmazensItens(FArmaze);
      FTransf := TTransferenciaArmazens.Create(Self, FArmaze, Nil, FProgre);
    End;

    If blnReiniciar Then
      FArmaze.EmptyDataSet;

    fAtualizaArmazemTodosItem(strSQLLoteItens);

    If Not cdsItens.isEmpty Then
    Begin
      If (intRecNo > 0) And (Not cdsItens.Eof) Then
        RecNo := intRecNo
      Else
        RecNo := 1;
    End;

    EnableControls;
  End;

End;

Function TEnderecamentoArmazem.fAtualizaArmazemTodosItem(strSQLLoteItens: String): Boolean;
Begin
  FstrSQLLoteItens := strSQLLoteItens;

  pCriarFormularios(TfrmGravando, frmGravando);
  With frmGravando Do
  Begin
    lblGravando.Caption := 'Carregando dados...';
    fExecutarAcao       := fAtualizaArmazemTodosItemPrg;

    ShowModal;

    Result := blnConfirma;
  End;
  pFreeAndNil(frmGravando);
End;

Function TEnderecamentoArmazem.fAtualizaArmazemTodosItemPrg(prgProgresso: TcxProgressBar): Boolean;
  Var
    qryLote: TUniQuery;
    blnCroDoc: Boolean;
Begin
  qryLote := fCriaQuery;

  blnCroDoc := fCfgSis('LOTCRO', VarBoolean);

  FTotalTransfLotes.fAbreClient(True, '[TEnderecamentoArmazem.fAtualizaArmazemTodosItemPrg]');
  FTotalTransfLotes.IndexFieldNames := 'CODITE;NUMLOT';

  With qryLote Do
  Begin
    prgProgresso.Properties.Max := RecordCount;
    Application.ProcessMessages;

    SQL.Text := FstrSQLLoteItens;
    Open;

    prgProgresso.Properties.Max := RecordCount;
    Application.ProcessMessages;

    First;
    While Not Eof Do
    Begin

      If Not FArmaze.FindKey([FieldByName('SEQDET').AsString, FieldByName('FDO_CODITE').AsString, FieldByName('LOT_NUMLOT').AsString]) Then
      Begin
        pInsereArmazem(qryLote, FieldByName('SEQDET').AsString, FieldByName('FDO_NUMLOT').AsString, FieldByName('FDO_QTDITE').AsFloat, True, blnCroDoc);
      End Else
      Begin
        pInsereArmazem(qryLote, FieldByName('SEQDET').AsString, FieldByName('FDO_NUMLOT').AsString, FieldByName('FDO_QTDITE').AsFloat, False, blnCroDoc);
      End;

      Next;

      prgProgresso.Position := prgProgresso.Position + 1;
      Application.ProcessMessages;
    End;
  End;

  FreeAndNil(qryLote);

  Result := True;
End;

(*****************************************************************************)
(* ATUALIZA NO CADLOT A CAPACIDADE DE UM ARMAZEM                             *)
(**************************************************************************LA*)
Procedure TEnderecamentoArmazem.pAlteraCapacidadeArmazem(strCodIte, strNumLot: String; fltCapaci: Double);
  Var
    qryCadArm: TUniQuery;
Begin
  qryCadArm := fCriaQuery;

  With qryCadArm, SQL Do
  Begin
    Clear;
    Add('UPDATE CADLOT');
    Add('SET');
    Add('  LOT_CAPACI = :CAPACI');
    Add('WHERE');
    Add('  LOT_CODITE = :CODITE AND');
    Add('  LOT_CODEMP = :CODEMP AND');
    Add('  LOT_NUMLOT = :NUMLOT    ');

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('NUMLOT').AsString := strNumLot;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    ParamByName('CAPACI').AsFloat  := fltCapaci;

    ExecSQL;
  End;

  FreeAndNil(qryCadArm);
End;

(*****************************************************************************)
(* ATUALIZA NO CADLOT A CAPACIDADE DOS ARAMAZENS DE UM ARMAZEM ITEM          *)
(**************************************************************************LA*)
Procedure TEnderecamentoArmazem.pSalvaCapacidadeArmazens;
Begin
  With FArmaze Do
  Begin

    First;
    While Not Eof Do
    Begin
      If fFormataFloat(FieldByName('CAPACI').AsFloat, intDecQtd) <>
         fFormataFloat(FieldByName('CAPANT').AsFloat, intDecQtd) Then
        pAlteraCapacidadeArmazem(FieldByName('CODITE').AsString,
                                 FieldByName('NUMLOT').AsString,
                                 FieldByName('CAPACI').AsFloat);

      Next;
    End;

  End;
End;

{
(*****************************************************************************)
(* RETORNA A QUANTIDADE TRANSFERIDA DE UM ARMAZEM                            *)
(* EM TODO O DOCUMENTO DE ENDERECAMENTO                                      *)
(**************************************************************************LA*)
Function TEnderecamentoArmazem.fRetQuantidadeTransferida(cdsArmaze: TUniClientDataSet;
                                           strCodIte, strNumLot,
                                           strAutDet: String): Double;
Begin
  Result := 0;

  With cdsArmaze Do
  Begin
    Filter := 'CODITE = ' + QuotedStr(strCodIte) + ' AND NUMLOT = ' + QuotedStr(strNumLot);
    If Not fEmptyStr(strAutDet) Then
      Filter := Filter + ' AND AUTINC <> ' + QuotedStr(strAutDet);

    Filtered         := True;

    First;
    While Not Eof Do
    Begin
      Result := Result + FieldByName('QTDITE').AsFloat;
      Next;
    End;

    Filtered := False;
  End;
End;
}

{
(*****************************************************************************)
(* ATUALIZA O TOTAL JA TRANSFERIDO PARA CADA ARMAZEM                         *)
(* EM TODO O DOCUMENTO DE ENDERECAMENTO                                      *)
(**************************************************************************LA*)
Procedure TEnderecamentoArmazem.pAtualizaTotalTransferido(strCodIte: String);
  Var
    cdsArmaze: TUniClientDataSet;
Begin

  With FArmaze Do
  Begin
    cdsArmaze      := TUniClientDataSet.Create(Self);

    Filtered       := False;
    cdsArmaze.Data := Data;

    Filter         := 'CODITE = ' + QuotedStr(strCodIte);
    Filtered       := True;

    First;
    While Not Eof Do
    Begin
      Edit;
      FieldbyName('QTDTOT').AsFloat := fRetQuantidadeTransferida(cdsArmaze,
                                         FieldByName('CODITE').AsString,
                                         FieldByName('NUMLOT').AsString,
                                         FieldByName('AUTINC').AsString);
      Post;

      Next;
    End;

    Filtered       := False;
  End;

  FreeAndNil(cdsArmaze);
End;
}

(*****************************************************************************)
(* RETORNA O SALDO E A CAPACIDADE DE UM ARMAZEM                              *)
(**************************************************************************LA*)
Procedure TEnderecamentoArmazem.pRetCapacidadeSaldoArmazem(strCodIte, strNumLot: String;
                       Var fltCapaci, fltSaldos: Double);
  Var
    qryCadArm: TUniQuery;
Begin
  qryCadArm := fCriaQuery;
  With qryCadArm, SQL Do
  Begin
    Add('SELECT * FROM CADLOT');
    Add('WHERE');
    Add('  LOT_CODITE = :CODITE AND ');
    Add('  LOT_NUMLOT = :NUMLOT AND ');
    Add('  LOT_CODEMP = :CODEMP     ');

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('NUMLOT').AsString := strNumLot;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;

    If IsEmpty Then
    Begin
      fltCapaci := 0;
      fltSaldos := 0;
    End Else
    Begin
      fltCapaci := FieldByName('LOT_CAPACI').AsFloat;
      fltSaldos := FieldByName('LOT_SALDOS').AsFloat;
    End;

  End;

  FreeAndNil(qryCadArm);
End;

(*****************************************************************************)
(* RECARREGA O SALDO E A CAPACIDADE DO ARMAZEM NO CLIENT DE ARMAZENS         *)
(* PARA QUE O USUARIO TENHA O VALORES ATUALIZADOS ANTES DE INFORMAR A        *)
(* QUANTIDADE A SER TRANSFERIDA                                              *)
(**************************************************************************LA*)
Procedure TEnderecamentoArmazem.pAtualizaSaldosArmazens;
  Var
    fltCapaci, fltSaldos: Double;
Begin
  With FArmaze Do
  Begin
    First;

    While Not Eof Do
    Begin
      pRetCapacidadeSaldoArmazem(FieldByName('CODITE').AsString,
                                 FieldByName('NUMLOT').AsString,
                                 fltCapaci, fltSaldos);
      Edit;
      FieldByName('CAPACI').AsFloat := fltCapaci;
      FieldByName('SALDOS').AsFloat := fltSaldos;
      Post;

      Next;
    End;

  End;
End;

(*****************************************************************************)
(* VALIDA AS INFORMACOES ANTES DA GRAVACAO DA TRANSFERENCIA PARA UM ARMAZEM  *)
(**************************************************************************LA*)
Procedure TEnderecamentoArmazem.pArmazemBeforePost(DataSet: TDataSet);
Begin
  If Not fValidaArmazem(DataSet, True, DataSet.FieldByName('QTDITE').AsFloat) Then
    Abort;
End;

Function TEnderecamentoArmazem.fValidaArmazem(DataSet: TDataSet; blnDarMsgErro: Boolean; fltQtdIte: Double): Boolean;
Var
  cdsData: TUniClientDataSet;
  strErro: String;
  blnArmazem: Boolean;
Begin
  Result := True;
  cdsData:= Nil;

  blnArmazem := fCfgSis('CTLEST', varString) = '2';

  If Not Assigned(stlMesagemErros) Then
    stlMesagemErros := TStringList.Create;

  With DataSet Do
  Begin
    If (FEhProdutoGarantia) And (fltQtdIte > 0) And
       (not SameText(FieldByName('NUMLOT').AsString, fRetArmazemPrincipalGarantia(FieldByName('CODITE').AsString))) Then
    Begin
      If blnDarMsgErro Then
        pMensagemOk('Produto de origem REFUGO só pode ser endereçado no lote principal de garantia!');

      Result := False;
    End
    Else

    If fltQtdIte > FQtdEnd Then
    Begin
      If blnDarMsgErro Then
        pMensagemOk('A quantidade digitada excede a quantidade total do item a ser transferida!');

      Result := False;
    End

    Else If fltQtdIte < 0 Then
    Begin
      If blnDarMsgErro Then
        pMensagemOk('A quantidade dever ser maior ou igual a zero!');

      Result := False;
    End

    Else If FieldByName('CAPACI').AsFloat < 0 Then
    Begin
      If blnDarMsgErro Then
        pMensagemOk('A Capacidade dever ser maior ou igual a zero!');

      Result := False;
    End

    Else If ((fCfgSis('CAMXUT',varString) = 'A') Or (fCfgSis('CAMXUT',varString) = 'T')) And Not(fUsaRotinaWMS) Then
    Begin

      cdsData     := fCriaDataCapaMaxima(cdsData);
      cdsData     := fInsereItemCapacidadeMaxima(FieldByName('CODITE').AsString, FieldByName('NUMLOT').AsString, fltQtdIte, cdsData);
      If Not(fValidaCapacidadeMaximaLote(FieldByName('NUMLOT').AsString, cdsData)) Then
      Begin
        Result := False;
        Exit;
      End;

    End

    Else If (fltQtdIte > 0) And fEmptyStr(FieldByName('LOCFIS').AsString) Then
    Begin
      If blnDarMsgErro Then
        pMensagemOk('Lote sem localização física!')
      Else
      Begin
        strErro := 'Item: ' + FieldByName('CODITE').AsString + ' '+IIF(blnArmazem,'Armazém','Lote')+': '+ FieldByName('NUMLOT').AsString + ' Erro: '+IIF(blnArmazem,'Armazém','Lote')+' sem localização física ' ;
        stlMesagemErros.Add(strErro);
      End;

      Result := False;
    End

    {COMENTANDO, POIS O TRECHO DO IF 'CAMXUT' SUPERIOR JÁ REALIZA ESSA VALIDAÇÃO. }
    {Else If (FieldByName('CAPACI').AsFloat <> 0) And (Not blnUsaWMS) Then
    Begin

      If (fFormataFloat(FieldByName('CAPACI').AsFloat, intDecQtd) <>
          fFormataFloat(FieldByName('CAPANT').AsFloat, intDecQtd)) And
         (fFormataFloat(FieldByName('CAPACI').AsFloat, intDecQtd) <
          fFormataFloat(FieldByName('SALDOS').AsFloat, intDecQtd)) Then
      Begin
        If blnDarMsgErro Then
          pMensagemOk('A capacidade deve ser maior ou igual ao saldo!');

        Result := False;
      End

      Else If fFormataFloat(FieldByName('CAPACI').AsFloat, intDecQtd) <
              fFormataFloat(fltQtdIte, intDecQtd) Then
      Begin
        If blnDarMsgErro Then
          pMensagemOk('A quantidade deve ser menor ou igual a capacidade!');

        Result := False;
      End

      Else If (fFormataFloat(fltQtdIte, intDecQtd) > 0) And
              (fFormataFloat(FieldByName('CAPACI').AsFloat, intDecQtd) <
               fFormataFloat(fltQtdIte, intDecQtd) - fRetOldValue(FieldByName('AUTINC').AsString,
                                                                  FieldByName('CODITE').AsString,
                                                                  FieldByName('NUMLOT').AsString) +
               fFormataFloat(fGetTotalTransferido(FieldByName('CODITE').AsString,
                                                  FieldByName('NUMLOT').AsString), intDecQtd)) Then
      Begin
        If blnDarMsgErro Then
          pMensagemOk('A quantidade total transferida no documento deve ser menor ou igual a capacidade!');

        Result := False;
      End

    End;}

  End;
End;

(*****************************************************************************)
(* ATUALIZA O CLIENT DE ARMAZENS COM AS ALTERACOES DO USUARIO                *)
(**************************************************************************LA*)
Procedure TEnderecamentoArmazem.pSalvaAlteracaoArmazens(cdsItens: TUniClientDataSet);
Begin
  With cdsItens Do
  Begin
    First;

    While Not Eof Do
    Begin
      If FArmaze.Locate('AUTINC;CODITE;NUMLOT',
                         VarArrayOf([FieldByName('AUTINC').AsString,
                                     FieldByName('CODITE').AsString,
                                     FieldByName('NUMLOT').AsString]), []) Then
      Begin
        pAtualizaTotalTransferido(FArmaze.FieldByName('CODITE').AsString,
                                  FArmaze.FieldByName('NUMLOT').AsString,
                                  FieldByName('QTDITE').AsFloat - FArmaze.FieldByName('QTDITE').AsFloat);

        FArmaze.Edit;
        FArmaze.FieldByName('CAPACI').AsFloat := FieldByName('CAPACI').AsFloat;
        FArmaze.FieldByName('QTDITE').AsFloat := FieldByName('QTDITE').AsFloat;
        FArmaze.FieldByName('AUTENT').AsString := FieldByName('AUTENT').AsString;
        FArmaze.Post;
      End;

      Next;
    End;
  End;
End;

procedure TEnderecamentoArmazem.pCarregaArmazensEnderecados(strCodIte,
  strAutInc: String; var cdsDados: TUniClientDataSet);
  Var
    intCorre : Integer;
begin
  if not Assigned(FArmaze) Then
    Exit;

  If Assigned(cdsDados) Then
    FreeAndNil(cdsDados);

  pCriaArmazensItens(cdsDados);

  With FArmaze Do
  Begin
    try
      Filter   := 'CODITE = ' + QuotedStr(strCodIte) + ' AND AUTINC = ' + QuotedStr(strAutInc);
      Filtered := True;

      First;
      While Not Eof Do
      Begin

        If FieldByName('QTDITE').AsFloat > 0 Then
        Begin
          cdsDados.Insert;

          For intCorre := 0 To cdsDados.FieldCount -1 Do
            cdsDados.Fields[intCorre].Value := Fields[intCorre].Value;

          cdsDados.Post;
        End;

        Next;
      End;
      cdsDados.First;
      
    Finally
      Filtered := False;
      Filter   := '';
    End;

  End;

end;

Procedure TEnderecamentoArmazem.pCopiarItens(cdsDestino: TUniClientDataSet; strCodIte: string = ''; strAutInc: string = ''; strLotCad: String = '');
  Var
    intContador: Integer;
Begin
  With FArmaze Do
  Begin
    If (strCodIte <> '') And (strAutInc <> '') And (strLotCad <> '') Then
    Begin
      If (FArmaze.Locate('CODITE;NUMLOT;AUTINC',
                         VarArrayOf([strCodIte,
                                     strLotCad,
                                     strAutInc]), [])) And (Not cdsDestino.Locate('CODITE;NUMLOT;AUTINC',
                                                                VarArrayOf([strCodIte,
                                                                            strLotCad,
                                                                            strAutInc]), [])) Then
      Begin
        cdsDestino.Insert;

        For intContador := 0 To Fields.Count - 1 Do
          cdsDestino.Fields[intContador].Value := Fields[intContador].Value;

        cdsDestino.Post;
      End;
    End
    Else
    Begin


      First;
      While Not Eof Do
      Begin
        If Not cdsDestino.Locate('CODITE;NUMLOT;AUTINC',
                                 VarArrayOf([FieldByName('CODITE').AsString,
                                             FieldByName('NUMLOT').AsString,
                                             FieldByName('AUTINC').AsString]), []) Then
        Begin
          cdsDestino.Insert;

          For intContador := 0 To Fields.Count - 1 Do
            cdsDestino.Fields[intContador].Value := Fields[intContador].Value;

          cdsDestino.Post;
        End;
        Next;
      End;
    End;
  End;
  cdsDestino.First;
End;

Procedure TEnderecamentoArmazem.pSetaLoteUnico(dataSet: TDataSet; strSetaLote: String; fltQtdIte: Double; Var strArmazem, strLocali, strDesAmz: String);
Begin
  With dataSet Do
  Begin
    First;

    While Not Eof Do
    Begin

      Edit;

      If SameText(FieldByName('NUMLOT').AsString, strSetaLote) And
         fValidaArmazem(dataSet, FblnValidar, fltQtdIte) Then
      Begin
        FieldByName('QTDITE').AsFloat := fltQtdIte;

        strArmazem := FieldByName('ARMDES').AsString;
        strLocali  := FieldByName('LOCFIS').AsString;
        strDesAmz  := FieldByName('AMZDES').AsString;

      End Else
        FieldByName('QTDITE').AsFloat := 0;

      Post;

      Next;
    End;
    FblnValidar := False;

  End;

End;

(*****************************************************************************)
(* ABRE A TELA COM OS ARMAZENS DO ITEM PARA A TRANSFERENCIA DE SALDO         *)
(* NO ENDERECAMENTO DE PRODUTO                                               *)
(**************************************************************************LA*)
Function TEnderecamentoArmazem.fEnderecaArmazens(strCodIte, strDescri, strAutInc, strArmOri: String; fltQtdIte: Double; blnEhProdutoGarantia : Boolean;
                                    Var strArmazem, strLocali, strDesAmz: String; strSetaLote: String = ''; strAutEnt: String = ''): Boolean;
Begin
  Result := False;

  Try
    frmEntEnderecamentoArmazens := Nil;

    FArmaze.Filter   := 'CODITE = ' + QuotedStr(strCodIte) + ' AND AUTINC = ' + QuotedStr(strAutInc);
    FArmaze.Filtered := True;

    // Testar tbm a capacidade
    If (Not strSetaLote.IsEmpty) And (Not FArmaze.Locate('NUMLOT', strSetaLote, [])) Then
      Exit;

    pCriarFormularios(TfrmEntEnderecamentoArmazens, frmEntEnderecamentoArmazens);

    Try
      frmEntEnderecamentoArmazens.strCodIte := strCodIte;
      frmEntEnderecamentoArmazens.strAutInc := strAutInc;
      frmEntEnderecamentoArmazens.strArmOri := strArmOri;
      frmEntEnderecamentoArmazens.fltQtdIte := fltQtdIte;
      frmEntEnderecamentoArmazens.objEndArm := Self;
      frmEntEnderecamentoArmazens.strAutEnt := strAutEnt;
      FEhProdutoGarantia := blnEhProdutoGarantia;

      With frmEntEnderecamentoArmazens, FArmaze Do
      Begin
        FQtdEnd  := RoundTo(fltQtdIte, - intDecQtd);

        (*****************************************************************************)
        (* RECARREGA O SALDO E A CAPACIDADE DO ARMAZEM NO CLIENT DE ARMAZENS         *)
        (* PARA QUE O USUARIO TENHA O VALORES ATUALIZADOS ANTES DE INFORMAR A        *)
        (* QUANTIDADE A SER TRANSFERIDA                                              *)
        (**************************************************************************LA*)
        pAtualizaSaldosArmazens;

        edtCodIte.Text := strCodIte + ' - ' + strDescri;
        edtQtdIte.Text := FormatFloat(fMskDigitos(intDecQtd), fltQtdIte);

        pCriaArmazensItens(cdsItens);

        pCopiarItens(cdsItens);

        pSetaAutEntCdsItens(cdsItens, strAutEnt);

        If strSetaLote.IsEmpty Then
          cdsItens.BeforePost := pArmazemBeforePost;

        If (Not strSetaLote.IsEmpty) Or (ShowModal = mrOk) Then
        Begin
          If (Not strSetaLote.IsEmpty) Then
            pSetaLoteUnico(cdsItens, strSetaLote, fltQtdIte, strArmazem, strLocali, strDesAmz);

          (*****************************************************************************)
          (* ATUALIZA O CLIENT DE ARMAZENS COM AS ALTERACOES DO USUARIO                *)
          (**************************************************************************LA*)
          pSalvaAlteracaoArmazens(cdsItens);

          (*****************************************************************************)
          (* ATUALIZA NO CADLOT A CAPACIDADE DOS ARAMAZENS DE UM ARMAZEM ITEM          *)
          (**************************************************************************LA*)
          pSalvaCapacidadeArmazens;

          If strSetaLote.IsEmpty Then
          Begin
            strArmazem := strNumLot;
            strDesAmz  := strAmzDes;
            strLocali  := strLocFis;
          End;

          Result := True;
        End;

        cdsItens.EmptyDataSet;
        FreeAndNil(cdsItens);

        Filtered  := False;
      End;

    Except
      On E : Exception Do
      Begin
        If Not( E is EAbort ) Then
          pMensagensErro(E.Message, 'TEnderecamentoArmazem.fEnderecaArmazens');
      End;
    End;

  Finally
    If Assigned(frmEntEnderecamentoArmazens) Then
      FreeAndNil(frmEntEnderecamentoArmazens);

    FArmaze.Filtered := False;
  End;

End;

Procedure TEnderecamentoArmazem.pAtualizaScrollArmazens(cdsItens: TUniClientDataSet; strArmazem, strLocFis, strAmzDes: String);
Begin
  With cdsItens Do
  Begin
    Edit;
    FieldByName('ARMAZE').AsString     := strArmazem;
    FieldByName('ITE_LOCFIS').AsString := strLocFis;
    FieldByName('AMZDES').AsString     := strAmzDes;
    FieldByName('ITE_QTDENR').AsCurrency := fQuantidadeTransferidaArmazens(cdsItens.FieldByName('AUTOINCREM').AsString);
    Post;
  End;
End;


Function TEnderecamentoArmazem.fQuantidadeTransferidaArmazens(AAutoIncrem: String = ''): Double;
Var
  LstrFilter: String;
  LblnFiltered: Boolean;
Begin
  Result := 0;
  LblnFiltered := False;
  LstrFilter := '';

  If Not fEmptyStr(AAutoIncrem) Then
  Begin
    LstrFilter := FArmaze.Filter;
    LblnFiltered := FArmaze.Filtered;
    FArmaze.Filter := 'AUTINC = ' + QuotedStr(AAutoIncrem);
    FArmaze.Filtered := True ;
  End;

  With FArmaze Do
  Begin
    First;
    While Not Eof Do
    Begin
      Result := Result + FieldByName('QTDITE').AsFloat;
      Next;
    End;
  End;

  If Not fEmptyStr(AAutoIncrem) Then
  Begin
    FArmaze.Filter := LstrFilter;
    FArmaze.Filtered := LblnFiltered;
  End;
End;

(*****************************************************************************)
(* VALIDA AS QUANTIDADES TRANSFERIDAS EM                                     *)
(* EM TODO O DOCUMENTO DE ENDERECAMENTO                                      *)
(**************************************************************************LA*)
Function TEnderecamentoArmazem.fValidaEnderecamentos(cdsItens: TUniClientDataSet): Boolean;
  Var
    strNumLot,
    strLocFis,
    strDesAmz: String;
    intRecNo: Integer;
Begin
  Result := True;

  With cdsItens Do
  Begin
    DisableControls;
    intRecNo := recNo;
    First;
    Try
      While Not Eof Do
      Begin
        FArmaze.Filter   := 'AUTINC = ' + QuotedStr(FieldByName('AUTOINCREM').AsString);
        FArmaze.Filtered := True;
        If Not (cdsItens.FieldByName('FDO_PROACA').AsString = 'S') Then
        Begin
          If (FieldByName('TEMLOT').AsString = '1') And (fQuantidadeTransferidaArmazens > 0) And
             (fFormataFloat(FieldByName('FDO_QTDITE').AsFloat, intDecQtd) <> fFormataFloat(fQuantidadeTransferidaArmazens, intDecQtd)) Then
          Begin
            Result := False;
            pMensagemOk('A quantidade do item difere da quantidade a transferir informada!');
            Break;
          End;
        End;
        Next;
      End;
    Finally
      FArmaze.Filtered := False;
      RecNo := intRecNo;
      EnableControls;
    End;

    If Not Result Then
      If fEnderecaArmazens(FieldByName('FDO_CODITE').AsString,
                           FieldByName('FDO_DESCRI').AsString,
                           FieldByName('AUTOINCREM').AsString,
                           FieldByName('FDO_NUMLOT').AsString,
                           FieldByName('FDO_QTDITE').AsFloat,
                           False,
                           strNumLot,
                           strLocFis,
                           strDesAmz) Then
       pAtualizaScrollArmazens(cdsItens, strNumLot, strLocFis, strDesAmz);
  End;

End;

Function TEnderecamentoArmazem.fExistemItensEnderecado(cdsItens: TUniClientDataSet): Boolean;
Begin
  Result := False;
  cdsItens.DisableControls;
  cdsItens.First;
  While Not cdsItens.Eof Do
  Begin
    Result := (cdsItens.FieldByName('FDO_PROACA').AsString = 'S');
    If Not Result Then
      Result := fExisteItemEnderecado(cdsItens);
    If Result Then
      Break;
    cdsItens.Next;
  End;
  cdsItens.EnableControls;
End;


Function TEnderecamentoArmazem.fExistemTodosProdutoAcabadosComLocFis(cdsItens: TUniClientDataSet): Boolean;
Begin
  Result := True;
  cdsItens.DisableControls;
  cdsItens.First;
  While Not cdsItens.Eof Do
  Begin
    If (cdsItens.FieldByName('FDO_PROACA').AsString = 'S') Then
    Begin
      If cdsItens.FieldByName('ITE_LOCFIS').AsString = '' Then
      Begin
        Result := False;
        pMensagemOk('Para o produto acabado deve ser informado a localização fisica.');
        Break;
      End;
    End;
    cdsItens.Next;
  End;
  cdsItens.EnableControls;
End;

Function TEnderecamentoArmazem.fExisteItemEnderecado(cdsItens: TUniClientDataSet): Boolean;
var strBackupFilter: String;
Begin
  strBackupFilter := '';
  If FArmaze.Filtered then
    strBackupFilter := FArmaze.Filter;
  Try
    FArmaze.Filter   := 'AUTINC = ' + QuotedStr(cdsItens.FieldByName('AUTOINCREM').AsString);
    FArmaze.Filtered := True;

    Result := cdsItens.FieldByName('TEMLOT').AsString = '0';
    if Not Result then
      Result := (cdsItens.FieldByName('TEMLOT').AsString = '1') And
        (fFormataFloat(cdsItens.FieldByName('FDO_QTDITE').AsFloat, intDecQtd) =
        fFormataFloat(fQuantidadeTransferidaArmazens, intDecQtd));
    FArmaze.Filtered := False;
  Finally
    If strBackupFilter <> '' Then
    begin
      FArmaze.Filter := strBackupFilter;
      FArmaze.Filtered := True;
    End;
  End;
End;

Function TEnderecamentoArmazem.fGeraDocumentoTransfArmazens(Var strNumDoc, strEspDoc, strCodCli: String;
   strSeqDocOri: String; endDocumento: TEndDocumento; AEnderecamentoProduto: TEnderecamentoProduto = nil): Boolean;
Begin
  {If fCfgSis('CTLEST') = 1 Then
    FArmaze.Filter   := 'QTDITE > 0'
  Else
    FArmaze.Filter   := 'QTDITE > 0 AND ARMORI <> ARMDES';}

  FArmaze.Filter   := 'QTDITE > 0';
  FArmaze.Filtered := True;

  FendDocumento := endDocumento;

  If FArmaze.RecordCount > 0 Then
  Begin
    FTransf.strCodOpe := strLoginUsuarioLogado;
    FTransf.strSeqOri := strSeqDocOri;
    FTransf.endDocumento := endDocumento;
    FTransf.objEnderecamentoProduto := AEnderecamentoProduto;
    Result := FTransf.fGeraTransferencia(False, False);

    strNumDoc := FTransf.strNumDoc;
    strEspDoc := FTransf.strEspDoc;
    strCodCli := FTransf.strCodCli;

  End

  Else Result := True;

  FArmaze.Filtered := False;
End;

function TEnderecamentoArmazem.fGravaOperadorConferente(strOperador,
  strConferente: string; EndDocumento: TEndDocumento; strObservacao: String): boolean;
  var
    qryAtualiza: TUniQuery;
begin
  Result := False;
  qryAtualiza := fCriaQuery;
  Try
    Try
      qryAtualiza.SQL.Add('UPDATE AUXMOV SET');

      qryAtualiza.SQL.Add('AUX_DTAEND = :DTAEND,');
      qryAtualiza.SQL.Add('AUX_CODSEP = :CODSEP,');
      qryAtualiza.SQL.Add('AUX_CODCON = :CODCON,');
      qryAtualiza.SQL.Add('AUX_OBSESC = :OBSESC,');
      qryAtualiza.SQL.Add('AUX_HRAEND = :HRAEND');
      qryAtualiza.SQL.Add(' WHERE AUX_SEQGER = ( SELECT AUTOINCREM');
      qryAtualiza.SQL.Add('                      FROM MOVGER ');
      qryAtualiza.SQL.Add('                      WHERE GER_NUMDOC = :NUMDOC');
      qryAtualiza.SQL.Add('                        AND GER_ESPDOC = :ESPDOC');
      qryAtualiza.SQL.Add('                        AND GER_SERIE_ = :SERIE_');
      qryAtualiza.SQL.Add('                        AND GER_CODEMP = :CODEMP');
      qryAtualiza.SQL.Add('                        AND GER_TIP_FC = :TIP_FC');
      qryAtualiza.SQL.Add('                        AND IF(GER_TIP_FC = "F", GER_CODFOR, GER_CODCLI) = :CODFOR)');

      qryAtualiza.ParamByName('DTAEND').Value := VS_date;
      qryAtualiza.ParamByName('HRAEND').AsDateTime := fNow;
      qryAtualiza.ParamByName('CODSEP').Value := strOperador;
      qryAtualiza.ParamByName('CODCON').Value := strConferente;
      qryAtualiza.ParamByName('NUMDOC').Value := EndDocumento.strNumDoc;
      qryAtualiza.ParamByName('ESPDOC').Value := EndDocumento.strEspDoc;
      qryAtualiza.ParamByName('SERIE_').Value := EndDocumento.strSerie_;
      qryAtualiza.ParamByName('CODEMP').Value := EndDocumento.strCodEmp;
      qryAtualiza.ParamByName('CODFOR').Value := EndDocumento.strCliFor;
      qryAtualiza.ParamByName('TIP_FC').Value := EndDocumento.strTip_FC;
      qryAtualiza.ParamByName('OBSESC').Value := strObservacao;

      qryAtualiza.ExecSQL;
      Result := True;
    Except
      on E: Exception Do
        pMensagensErro(E.Message, '[TEnderecamentoArmazem.fGravaOperadorConferente]');
    End;
  Finally
    FreeAndNil(qryAtualiza);
  End;
end;


Procedure TEnderecamentoArmazem.pImprimeTransfArmazens;
Begin
  FArmaze.Filter   := 'QTDITE > 0';
  FArmaze.Filtered := True;

  If (FArmaze.RecordCount > 0) And
     fPergunta('Deseja imprimir o documento de transferência entre ' + IIF(blnUsaWMS, 'Lotes', 'Armazéns') + '?') Then
    FTransf.pImprimeTranferencia;

  FArmaze.Filtered := False;
End;

Function TEnderecamentoArmazem.fLeArmazem(Var strNumLot: String): Boolean;
Begin
  pCriarFormularios(TfrmLeArmazem, frmLeArmazem);

  Result := frmLeArmazem.ShowModal = mrOk;

  strNumLot := frmLeArmazem.edtCodAmz.Text;

  pFreeAndNil(frmLeArmazem)
End;

Procedure TEnderecamentoArmazem.pInformaArmazemUnico(cdsConsulta: TUniClientDataSet);
  Var
    strNumLot  : String;
    blnAtualiza: Boolean;
    strDesAmz: string;

Begin
  Try
    If cdsConsulta.IsEmpty Then
      Exit;

    If Not fLeArmazem(strNumLot) Then
      Exit;

    strDesAmz := fRetNomeArmazem(strNumLot);

    (*****************************************************************************)
    (* RECARREGA O SALDO E A CAPACIDADE DO ARMAZEM NO CLIENT DE ARMAZENS         *)
    (* PARA QUE O USUARIO TENHA O VALORES ATUALIZADOS ANTES DE INFORMAR A        *)
    (* QUANTIDADE A SER TRANSFERIDA                                              *)
    (**************************************************************************LA*)
    FArmaze.Filtered := False;
    pAtualizaSaldosArmazens;

    cdsConsulta.DisableControls;
    cdsConsulta.First;

    While Not cdsConsulta.Eof Do
    Begin

      FArmaze.Filter   := 'CODITE = ' + QuotedStr(cdsConsulta.FieldByName('FDO_CODITE').AsString) + ' AND AUTINC = ' +
                                        QuotedStr(cdsConsulta.FieldByName('AUTOINCREM').AsString);
      FArmaze.Filtered := True;

      If FArmaze.Locate('AUTINC;CODITE;NUMLOT',
                         VarArrayOf([cdsConsulta.FieldByName('AUTOINCREM').AsString,
                                     cdsConsulta.FieldByName('FDO_CODITE').AsString,
                                     strNumLot]), []) And
         (Not fEmptyStr(FArmaze.FieldByName('LOCFIS').AsString)) Then
      Begin
        blnAtualiza := True;

        If (FArmaze.FieldByName('CAPACI').AsFloat <> 0) Then
        Begin

          If fFormataFloat(FArmaze.FieldByName('CAPACI').AsFloat, intDecQtd) <
             fFormataFloat(FArmaze.FieldByName('QTDITE').AsFloat, intDecQtd) Then
          Begin
            blnAtualiza := False;
          End

         (* Else If fFormataFloat(FArmaze.FieldByName('CAPACI').AsFloat, intDecQtd) <
                  fFormataFloat(FArmaze.FieldByName('QTDITE').AsFloat, intDecQtd) +
                  fFormataFloat(FArmaze.FieldByName('QTDTOT').AsFloat, intDecQtd) Then
          Begin
            blnAtualiza := False;
          End *)

          Else If (fFormataFloat(FArmaze.FieldByName('QTDITE').AsFloat, intDecQtd) > 0) And
                  (fFormataFloat(FArmaze.FieldByName('CAPACI').AsFloat, intDecQtd) <
                   fFormataFloat(FArmaze.FieldByName('QTDITE').AsFloat, intDecQtd) +
                   fFormataFloat(fGetTotalTransferido(FArmaze.FieldByName('CODITE').AsString,
                                                      FArmaze.FieldByName('NUMLOT').AsString), intDecQtd)) Then
          Begin
            blnAtualiza := False;
          End

        End;

        If blnAtualiza Then
        Begin

          FArmaze.Edit;

          pAtualizaTotalTransferido(FArmaze.FieldByName('CODITE').AsString,
                                    FArmaze.FieldByName('NUMLOT').AsString,
                                    cdsConsulta.FieldByName('FDO_QTDITE').AsFloat - FArmaze.FieldByName('QTDITE').AsFloat);

          FArmaze.FieldByName('QTDITE').AsFloat := cdsConsulta.FieldByName('FDO_QTDITE').AsFloat;


          FArmaze.Post;

          pAtualizaScrollArmazens(cdsConsulta, strNumLot, FArmaze.FieldByName('LOCFIS').AsString, strDesAmz);

          FArmaze.First;
          While Not FArmaze.Eof Do
          Begin
            If FArmaze.FieldByName('NUMLOT').AsString <> strNumLot Then
            Begin
              FArmaze.Edit;

              pAtualizaTotalTransferido(FArmaze.FieldByName('CODITE').AsString,
                                        FArmaze.FieldByName('NUMLOT').AsString,
                                        0 - FArmaze.FieldByName('QTDITE').AsFloat);

              FArmaze.FieldByName('QTDITE').AsFloat := 0;


              FArmaze.Post;
            End;

            FArmaze.Next;
          End;

        End;

      End; {If FArmaze.Locate...}

      (*****************************************************************************)
      (* ATUALIZA O TOTAL JA TRANSFERIDO PARA CADA ARMAZEM                         *)
      (* EM TODO O DOCUMENTO DE ENDERECAMENTO                                      *)
      (**************************************************************************LA*)
  //    pAtualizaTotalTransferido(cdsConsulta.FieldByName('FDO_CODITE').AsString);

      cdsConsulta.Next;
    End; {While Not cdsConsulta.Eof Do...}

  Except
    on E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TEnderecamentoArmazem.pInformaArmazemUnico]');
    End;
  End;

  FArmaze.Filtered := False;
  cdsConsulta.EnableControls;
End;

Procedure TEnderecamentoArmazem.pSetaAutEntCdsItens(ACdsItens: TUniClientDataSet; AStrAutEnt: String);
Begin
  ACdsItens.First;
  While Not ACdsItens.Eof Do
  Begin
    ACdsItens.Edit;
    ACdsItens.FieldByName('AUTENT').AsString := AStrAutEnt;
    ACdsItens.Post;
    ACdsItens.Next;
  End;
End;

end.

