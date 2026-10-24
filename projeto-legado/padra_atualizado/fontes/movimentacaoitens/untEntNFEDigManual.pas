unit untEntNFEDigManual;

interface

Uses
  Uni, SysUtils,
  DB, UniClientDataSet, UniDataSetProvider, DBEditFocus,
  Controls,
  Classes,
  Math,
  frxClass, frxDBset,
  cxProgressBar,
  StrUtils,
  untZClient,
  untTypesSistema;

Type
  TopcEdits = (opcLimpar, opcEditar, opcGravar);

  TNFEDigManual = Class(TComponent)
  Private
    FfinalidadeXML: tpefinalidadeXML;

    qryCadFor: TUniQuery;

    FProMat: String;
    FCodFor: String;

    FListaPedido: String;

    Procedure pSetFornecedor(Value: String);

    Function fSQLDetEle(strMatRev: String): String;

    Procedure pCriaGerEle;
    Procedure pCriaDetEle(Var zclDetEle: TZClient);
    Procedure pAbreGerEle;
    Procedure pAbreDetEle(zclDetEle: TZClient; strSeqGer: String);
    Procedure pInsertGerEle;
    Procedure pCopiaDetIns;
    Procedure pSalvaGerEle;
    Procedure pInsertDetEle;
    Procedure pAbreNFE;

    Procedure pCarregaCamposFornecedor;

    Procedure pInsereCadMco(strCodFor, strCodBar, strDesIte: String;
      fltPreCom: Double; Var strCodMco: String);

    Procedure pUpdateCadMco(strDesIte, strCodMco: String; fltPreCom: Double);

    Function fSQLProdutosDoPedido(strNumPed, strCodEmp: String): String;
    function fSQLProdutosDosPedidos: String;
    function fCarregaProdutosPedidosPrg(cxProgesso: TcxProgressBar): Boolean;

  Public

    cdsPedImp: TZClient;

    FPedidoCompra: TUniQuery;

    intDEQTEM: Integer;
    intDECNFE: Integer;

    zclGerEle, zclDetIns, zclDetEle: TZClient;

    fltAliPis, fltAliCof: Double;

    strMatRev, strAutInc: String;

    dtsEdits: TDataSource;

    constructor Create(Owner: TComponent; finalidadeXML: tpefinalidadeXML);
      reintroduce;

    Destructor Destroy; override;

    function fAdicionaPedidoImportacao(strNumPed, strCodEmp: String): Boolean;
    function fCarregaProdutosPedidos: Boolean;
    function fSQLPedidosImportacao: String;


    Procedure pRemovePedido;

    Function fAlteraNota(strAutInc: String = ''; strCodFor: String = ''): Boolean;

    Function fDescontoItem(fltValIte, fltDescon, fltTotNot: Double): Double;
    Function fFreteItem(fltValIte, fltValFre, fltTotNot: Double): Double;
    Function fDespesasAcessoriasItem(fltValIte, fltDesAce,
      fltTotNot: Double): Double;

    Function fValorLiquidoItem(fltValIte, fltDesEsp, fltValFre, fltDesAce,
      fltTotIpi, fltTotSub: Double): Double;

    Function fValidaTotaisNota(fltBasIcm, fltTotIcm, fltBasSub, fltTotSub,
      fltTotIpi, fltTotPro: Double): Boolean;

    Procedure pCancelaEdicaoItem(opcEdits: TopcEdits = opcLimpar);
    Procedure pCancelaEdicaoNota;
    Procedure pSalvaItem;
    Procedure pEditaItem;
    Procedure pExcluiItem;
    Procedure pSalvaDetEle;
    Procedure pRecalculaDescontoItens(fltDesEsp, fltValFre, fltDesAce,
      fltTotIte: Double);

    Class Function fValidaProdutoConsumo: Boolean;

    function fValidaDocumentoUnico(strNumDoc, strSerie,
      strCodFor: String): boolean;

    property strCodFor: String Read FCodFor Write pSetFornecedor;
    property strListaPedido: String Read FListaPedido Write FListaPedido;
  End;

implementation

Uses
  Forms,
  untfuncoesSimples,
  untGravando,
  untEntNFEDigManualEdit;

constructor TNFEDigManual.Create(Owner: TComponent;
  finalidadeXML: tpefinalidadeXML);
Begin
  Inherited Create(Owner);

  pCriaGerEle;
  pCriaDetEle(zclDetEle);
  pCriaDetEle(zclDetIns);

  FListaPedido:= '';

  FProMat := fCfgSis('PROMAT');

  intDEQTEM := fCfgSis('DEQTEM', varInteger);
  intDECNFE := fCfgSis('DECNFE', varInteger);

  fltAliPis := fCfgSis('ALPISP');
  fltAliCof := fCfgSis('ALCOFP');
  FfinalidadeXML := finalidadeXML;

  qryCadFor := fCriaQuery(Self);

  FPedidoCompra := fCriaQuery(Self);
  FPedidoCompra.SQL.Text := fSQLPedidosImportacao;

  cdsPedImp := TZClient.Create(Self, fSQLPedidosImportacao);
  cdsPedImp.IndexFieldNames := 'NUMPED;CODEMP';
End;

Function TNFEDigManual.fSQLPedidosImportacao: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT                  ';
  strSQL := strSQL + '   PCG_BAIXAD AS BAIXAD, ';
  strSQL := strSQL + '   PCG_NUMPED AS NUMPED, ';
  strSQL := strSQL + '   PCG_CODEMP AS CODEMP, ';
  strSQL := strSQL + '   PCG_PEDMLJ AS PEDMLJ, ';
  strSQL := strSQL + '   IFNULL(PCG_EMPDES, PCG_CODEMP) AS EMPDES, ';
  strSQL := strSQL + '   PCG_CODFOR AS CODFOR, ';
  strSQL := strSQL + '   FOR_NOMFOR AS NOMFOR, ';
  strSQL := strSQL + '   PCG_DTAPED AS DTAPED, ';
  strSQL := strSQL + '   PCG_DTAENT AS DTAENT  ';
  strSQL := strSQL + ' FROM          ';
  strSQL := strSQL + '   PCMGER      ';
  strSQL := strSQL + ' INNER JOIN CADFOR ON FOR_CODFOR = PCG_CODFOR  ';
  strSQL := strSQL + ' WHERE     ';

  If Not(fEmptyStr(FListaPedido)) Then
    strSQL := strSQL + ' PCMGER.AUTOINCREM IN ('+FListaPedido+ ')'
  Else
    strSQL := strSQL + '       PCG_NUMPED = :NUMPED ';

  strSQL := strSQL + '   AND PCG_CODEMP = :CODEMP ';

  Result := strSQL;
End;

Class Function TNFEDigManual.fValidaProdutoConsumo: Boolean;
Begin
  Result := Not fEmptyStr(fRetNomProduto(fCfgSis('PROMAT')));

  If Not Result Then
    pMensagemOk('Informe a configuração (CFG_PROMAT) "Produto material de consumo"!');
  End;

Procedure TNFEDigManual.pCriaGerEle;
Begin
  zclGerEle := TZClient.Create(Self);

  With zclGerEle.qryQuery.SQL Do
  Begin
    Clear;
    Add('SELECT * FROM GERELE   ');
    Add('WHERE                  ');
    Add('  AUTOINCREM = :AUTINC ');
  End;

End;

Function TNFEDigManual.fSQLDetEle(strMatRev: String): String;
Var
  strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + ' * ';

//  strSQL := strSQL + ' (I11_VPROD - I10_QCOM + I15_VFRETE + I17A_VOUTRO) AS DET_VALLIQ ';

  strSQL := strSQL + ' FROM DETELE ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   DET_SEQGER = :SEQGER ';

  Result := strSQL;
End;

Procedure TNFEDigManual.pCriaDetEle(Var zclDetEle: TZClient);
Begin
  zclDetEle := TZClient.Create(Self);

  With zclDetEle, qryQuery.SQL Do
  Begin
    Clear;

    Text := fSQLDetEle('');

    pCriaSoma('O14_VIPI', 'SUM_VALIPI');

    pCriaSoma('N15_VBC', 'SUM_BASICM');
    pCriaSoma('N17_VICMS', 'SUM_VALICM');

    pCriaSoma('N21_VBCST', 'SUM_BASSUB');
    pCriaSoma('N23_VICMSST', 'SUM_VALSUB');

    pCriaSoma('I11_VPROD', 'SUM_TOTPRO');
  End;

End;

Destructor TNFEDigManual.Destroy;
Begin
  Inherited;

End;

Procedure TNFEDigManual.pAbreGerEle;
Begin
  zclGerEle.Close;

  With zclGerEle.qryQuery Do
  Begin
    Close;
    ParamByName('AUTINC').AsString := strAutInc;

    Open;

    pSetaClient(zclGerEle.qryQuery);

    zclGerEle.pSetProvider;
  End;

  With zclGerEle Do
  Begin
    Open;

    TFloatField(FieldByName('W10_VDESC')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('W03_VBC')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('W04_VICMS')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('W05_VBCST')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('W06_VST')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('W07_VPROD')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('W08_VFRETE')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('W15_VOUTRO')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('W12_VIPI')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('W16_VNF')).DisplayFormat := '#,##0.00';

    TDateField(FieldByName('B09_DEMI')).EditMask := '99/99/9999';
    TDateField(FieldByName('GER_DTAALT')).EditMask := '99/99/9999';
  End;

End;

Procedure TNFEDigManual.pAbreDetEle(zclDetEle: TZClient; strSeqGer: String);
Begin

  With zclDetEle, qryQuery Do
  Begin
    SQL.Text := fSQLDetEle(strMatRev);

    If zclGerEle.IsEmpty Then
      ParamByName('SEQGER').AsString := ''
    Else
      ParamByName('SEQGER').AsString := strSeqGer;

    fAbreClient(True, 'TNFEDigManual.pAbreDetEle');

    pAlinhaCampoCentro('DET_CODITE');
  End;

  With zclDetEle Do
  Begin
//    FieldByName('DET_VALLIQ').ProviderFlags := [];

    TFloatField(FieldByName('I10_QCOM')).DisplayFormat := fMskDigitos(intDEQTEM);
    TFloatField(FieldByName('I10A_VUNCOM')).DisplayFormat := fMskDigitos(intDECNFE);

    TFloatField(FieldByName('O10_VBC')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('N15_VBC')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('N21_VBCST')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('Q07_VBC')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('S07_VBC')).DisplayFormat := '#,##0.00';

    TFloatField(FieldByName('O13_PIPI')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('N16_PICMS')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('Q08_PPIS')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('S08_PCOFINS')).DisplayFormat := '#,##0.00';

    TFloatField(FieldByName('I11_VPROD')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('O14_VIPI')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('N17_VICMS')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('N23_VICMSST')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('Q09_VPIS')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('S11_VCOFINS')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('I17_VDESC')).DisplayFormat := '#,##0.00';

//    TFloatField(FieldByName('DET_VALLIQ')).DisplayFormat := '#,##0.00';
  End;

End;

Procedure TNFEDigManual.pAbreNFE;
Begin
  pAbreGerEle;
  pAbreDetEle(zclDetEle, zclGerEle.FieldByName('AUTOINCREM').AsString);
  pAbreDetEle(zclDetIns, '');
End;

Procedure TNFEDigManual.pCancelaEdicaoItem(opcEdits: TopcEdits = opcLimpar);
Begin
  zclDetEle.pCancela(False);
  zclDetIns.pCancela(False);

  Case opcEdits Of
    opcEditar:
      dtsEdits.DataSet := zclDetEle;
    opcLimpar:
      pInsertDetEle;
  End;
End;

Procedure TNFEDigManual.pInsertGerEle;
Begin
  With zclGerEle Do
  Begin
    If fEmptyStr(strAutInc) Then
    Begin
      Insert;

      FieldByName('GER_CODDIG').AsString := strLoginUsuarioLogado;
      FieldByName('GER_DTAALT').AsDateTime := Date;
      FieldByName('GER_DTAIMP').AsDateTime := Date;
      FieldByName('GER_HORIMP').AsDateTime := fTime();
      FieldByName('W10_VDESC').AsFloat := 0;
      FieldByName('W03_VBC').AsFloat := 0;
      FieldByName('W04_VICMS').AsFloat := 0;
      FieldByName('W05_VBCST').AsFloat := 0;
      FieldByName('W06_VST').AsFloat := 0;
      FieldByName('W07_VPROD').AsFloat := 0;
      FieldByName('W08_VFRETE').AsFloat := 0;
      FieldByName('W15_VOUTRO').AsFloat := 0;
      FieldByName('W12_VIPI').AsFloat := 0;
      FieldByName('W16_VNF').AsFloat := 0;

    End
    Else
    Begin
      Edit;
    End;
  End;
End;

Procedure TNFEDigManual.pInsertDetEle;
Begin
  zclDetIns.pCancela;

  With zclDetIns Do
  Begin
    Insert;

    If strMatRev = 'M' Then
      FieldByName('DET_CODITE').AsString := FProMat;

    FieldByName('I10_QCOM').AsFloat := 0;
    FieldByName('I10A_VUNCOM').AsFloat := 0;

    FieldByName('O10_VBC').AsFloat := 0;
    FieldByName('N15_VBC').AsFloat := 0;
    FieldByName('N21_VBCST').AsFloat := 0;
    FieldByName('Q07_VBC').AsFloat := 0;
    FieldByName('S07_VBC').AsFloat := 0;

    FieldByName('O13_PIPI').AsFloat := 0;
    FieldByName('N16_PICMS').AsFloat := 0;
    FieldByName('Q08_PPIS').AsFloat := 0;
    FieldByName('S08_PCOFINS').AsFloat := 0;

    FieldByName('I11_VPROD').AsFloat := 0;
    FieldByName('O14_VIPI').AsFloat := 0;
    FieldByName('N17_VICMS').AsFloat := 0;
    FieldByName('N23_VICMSST').AsFloat := 0;
    FieldByName('Q09_VPIS').AsFloat := 0;
    FieldByName('S11_VCOFINS').AsFloat := 0;

//    FieldByName('DET_VALLIQ').AsFloat := 0;
    FieldByName('I17_VDESC').AsFloat := 0;

  End;

  dtsEdits.DataSet := zclDetIns;
End;

Procedure TNFEDigManual.pCopiaDetIns;
Var
  intContador: Integer;
Begin
  With zclDetIns Do
  Begin
    zclDetEle.Append;

    For intContador := 0 To Fields.Count - 1 Do
      zclDetEle.Fields[intContador].Value := Fields[intContador].Value;

    zclDetEle.Post;

    EmptyDataSet;
  End;

End;

Procedure TNFEDigManual.pSalvaItem;
Begin
  If zclDetEle.State = dsEdit Then
  Begin
    zclDetEle.Post;
  End
  Else
  Begin
    pCopiaDetIns;
  End;

  pInsertDetEle;
End;

Procedure TNFEDigManual.pCancelaEdicaoNota;
Begin
  zclGerEle.pCancela;
  zclDetEle.pCancela;
End;

Procedure TNFEDigManual.pSetFornecedor(Value: String);
Begin
  If FCodFor <> Value Then
  Begin
    FCodFor := Value;
    pCarregaCamposFornecedor;
  End;
End;

Procedure TNFEDigManual.pCarregaCamposFornecedor;
Var
  strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   FOR_MATREV, ';
  strSQL := strSQL + '   FOR_NOMFOR, ';
  strSQL := strSQL + '   FOR_C_G_C_  ';
  strSQL := strSQL + ' FROM          ';
  strSQL := strSQL + '   CADFOR      ';
  strSQL := strSQL + ' WHERE';
  strSQL := strSQL + '   FOR_CODFOR = :CODFOR ';

  With qryCadFor Do
  Begin
    Close;
    SQL.Text := strSQL;
    ParamByName('CODFOR').AsString := FCodFor;
    Open;

    strMatRev := FieldByName('FOR_MATREV').AsString;
  End;
End;

Procedure TNFEDigManual.pSalvaGerEle;
Begin
  With zclGerEle Do
    If State In [dsEdit, dsInsert] Then
    Begin
      FieldByName('GER_TIPENT').AsString := 'M'; // DIGITADA MANUALMENTE
      FieldByName('GER_TIPXML').AsInteger := Ord(FfinalidadeXML);

      If fEmptyStr(FieldByName('AUTOINCREM').AsString) Then
      Begin
        FieldByName('GER_CODEMP').AsString := VS_strCodEmp;
        FieldByName('AUTOINCREM').AsString :=
          fRetAutoIncrem('GERELE', VS_strCodEmp);
      End;

      If Modified Or (zclDetEle.ChangeCount > 0) Then
      Begin
        FieldByName('GER_CODDIG').AsString := strLoginUsuarioLogado;
        FieldByName('GER_DTAALT').AsDateTime := VS_Date;
      End;

      if FfinalidadeXML in [xmlCFG_IMPXGRGarantiaRetFornecedor] then
      begin
        FieldByName('GER_ENTDIR').AsString := 'S';
        FieldByName('GER_DTALIB').Value := VS_Date;
        FieldByName('GER_HORLIB').Value := Time;
        FieldByName('GER_OPELIB').Value := strLoginUsuarioLogado;
        FieldByName('GER_UNICOM').Value := 'N';
        FieldByName('GER_CONDIR').AsString := 'S';
      end
      else If strMatRev = 'M' Then
      Begin
        FieldByName('GER_ENTDIR').AsString := 'S';
        FieldByName('GER_HORLIB').Value := fTime();
        FieldByName('GER_OPELIB').Value := strLoginUsuarioLogado;
        FieldByName('GER_UNICOM').Value := 'N';

        if (fCfgSis('FLUPDC', varBoolean)) then
        begin
          FieldByName('GER_ENTDIR').AsString := 'N';
          FieldByName('GER_DTACON').AsDateTime := VS_Date;
        end
        else
        begin
          FieldByName('GER_ENTDIR').AsString := 'S';
          FieldByName('GER_DTALIB').Value := VS_Date;
        end;

        FieldByName('C03_XNOME').AsString :=
          qryCadFor.FieldByName('FOR_NOMFOR').AsString;
        FieldByName('E02_CNPJ').AsString :=
          qryCadFor.FieldByName('FOR_C_G_C_').AsString;
      End;

      Post;
    End;

  pSalvaDetEle;
End;

Procedure TNFEDigManual.pInsereCadMco(strCodFor, strCodBar, strDesIte: String;
  fltPreCom: Double; Var strCodMco: String);
Var
  qryCadMco: TUniQuery;
Begin
  qryCadMco := fCriaQuery;
  With qryCadMco Do
  Begin
    SQL.Text := 'SELECT * FROM CADMCO WHERE FALSE';
    Open;

    Insert;
    FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CADMCO',
      VS_strCodEmp);
    FieldByName('MCO_CODEMP').AsString := VS_strCodEmp;
    FieldByName('MCO_CODMCO').AsString := fAtualizaProCod('CADMCO', 'MCO_CODMCO');
    FieldByName('MCO_DESCRI').AsString := strDesIte;
    FieldByName('MCO_MCOATI').AsString := 'S';
    FieldByName('MCO_PRECOM').AsFloat := fltPreCom;
    FieldByName('MCO_CODFOR').AsString := strCodFor;
    FieldByName('MCO_CODBAR').AsString := strCodBar;

    If fEmptyStr(FieldByName('MCO_CODBAR').AsString) Then
      FieldByName('MCO_CODBAR').Clear;

    Post;

    strCodMco := FieldByName('MCO_CODMCO').AsString;
  End;

  FreeAndNil(qryCadMco);
End;

Procedure TNFEDigManual.pUpdateCadMco(strDesIte, strCodMco: String;
  fltPreCom: Double);
Var
  qryCadMco: TUniQuery;
Begin
  qryCadMco := fCriaQuery;
  With qryCadMco Do
  Begin
    SQL.Text := 'SELECT * FROM CADMCO WHERE MCO_CODMCO = :CODMCO';

    ParamByName('CODMCO').AsString := strCodMco;

    Open;

    If Not IsEmpty Then
    Begin
      Edit;
      FieldByName('MCO_DESCRI').AsString := strDesIte;
      FieldByName('MCO_PRECOM').AsFloat := fltPreCom;
      Post;
  End;

  pInsertDetEle;

End;

  FreeAndNil(qryCadMco);
End;

Procedure TNFEDigManual.pSalvaDetEle;
Var
  fltDescon: Double;
  intRecNo: Integer;
  strCodMco: String;
Begin
  With zclDetEle Do
  Begin
    fltDescon := zclGerEle.FieldByName('W10_VDESC').AsFloat;

    Last;
    intRecNo := RecNo;

    First;

    While Not Eof Do
    Begin
      If RecNo <> intRecNo Then
        fltDescon := fltDescon - FieldByName('I17_VDESC').AsFloat;

      If fEmptyStr(FieldByName('DET_SEQGER').AsString) Then
      Begin
        Edit;

        FieldByName('AUTOINCREM').AsString :=
          fRetAutoIncrem('DETELE', VS_strCodEmp);
        FieldByName('DET_SEQGER').AsString :=
          zclGerEle.FieldByName('AUTOINCREM').AsString;

        Post;
      End;

      If strMatRev = 'M' Then
      Begin
        Edit;

        If fEmptyStr(FieldByName('DET_CODMCO').AsString) Then
        Begin
          pInsereCadMco(zclGerEle.FieldByName('GER_CODFOR').AsString,
            FieldByName('I03_CEAN').AsString, FieldByName('I04_XPROD').AsString,
            FieldByName('I10A_VUNCOM').AsFloat, strCodMco);

          FieldByName('DET_CODMCO').AsString := strCodMco;
        End
        Else
        Begin

          pUpdateCadMco(FieldByName('I04_XPROD').AsString,
            FieldByName('DET_CODMCO').AsString,
            FieldByName('I10A_VUNCOM').AsFloat);

        End;

        Post;
      End; { If strMatRev = 'M' Then }

      Next;
    End;

    (* ********************************** *)
    (* ACERTA ARREDONDAMENTO DESCONTOS *)
    (* ********************************LA *)
    If fltDescon >= 0 Then
    Begin
      Edit;
      FieldByName('I17_VDESC').AsFloat := fltDescon;
      Post;
    End;

  End;
End;

Function TNFEDigManual.fAlteraNota(strAutInc: String = ''; strCodFor: String = ''): Boolean;
Begin
  Result := False;
  Self.strAutInc := strAutInc;
  Self.strCodFor := strCodFor;

  pAbreNFE;
  pCriarFormularios(TfrmEntNFEDigManualEdit, frmEntNFEDigManualEdit);

  With frmEntNFEDigManualEdit Do
  Begin

    objNFEDig := Self;

    pInsertGerEle;

    If frmEntNFEDigManualEdit.ShowModal = mrOk Then
    Begin

      Try
        pSalvaGerEle;

        fStartTransaction;

        If zclGerEle.fSalva And zclDetEle.fSalva Then
          fCommit
        Else
          fRollBack;

        strAutInc := zclGerEle.FieldByName('AUTOINCREM').AsString;

        Result := True;

        pMensagemOk('Dados salvos com sucesso!');

      Except

        On E: Exception Do
        Begin
          Result := False;
          fRollBack;
          pMensagensErro(E.Message, '[TNFEDigManual.pAlteraNota]');
        End;

      End;

    End
    Else
    Begin
      pCancelaEdicaoNota;
    End;
  End;

  FreeAndNil(frmEntNFEDigManualEdit);
End;

Procedure TNFEDigManual.pEditaItem;
Begin
  If dtsEdits.DataSet = zclDetIns Then
  Begin
    pInsertDetEle;
  End
  Else
  Begin
    zclDetEle.Edit;
  End;

End;

Procedure TNFEDigManual.pExcluiItem;
Begin
  With zclDetEle Do
  Begin
    If IsEmpty Then
      Exit;

    If fPergunta('Confirma a exclusão do item?') Then
      Delete;
  End;

End;

Function TNFEDigManual.fDescontoItem(fltValIte, fltDescon,
  fltTotNot: Double): Double;
Begin
  If fltTotNot <> 0 Then
    Result := RoundTo((fltValIte / fltTotNot) * fltDescon, -2)
  Else
    Result := 0;
End;

Function TNFEDigManual.fFreteItem(fltValIte, fltValFre,
  fltTotNot: Double): Double;
Begin
  If fltTotNot <> 0 Then
    Result := RoundTo((fltValIte / fltTotNot) * fltValFre, -2)
  Else
    Result := 0;
End;

Function TNFEDigManual.fDespesasAcessoriasItem(fltValIte, fltDesAce,
  fltTotNot: Double): Double;
Begin
  If fltTotNot <> 0 Then
    Result := RoundTo((fltValIte / fltTotNot) * fltDesAce, -2)
  Else
    Result := 0;
End;

Function TNFEDigManual.fValorLiquidoItem(fltValIte, fltDesEsp, fltValFre,
  fltDesAce, fltTotIpi, fltTotSub: Double): Double;
Begin
  If fltValIte - fltDesEsp + fltValFre + fltDesAce + fltTotIpi +
    fltTotSub > 0 Then
    Result := fltValIte - fltDesEsp + fltValFre + fltDesAce + fltTotIpi +
      fltTotSub
  Else
    Result := 0;
End;

Procedure TNFEDigManual.pRecalculaDescontoItens(fltDesEsp, fltValFre, fltDesAce,
  fltTotIte: Double);
Var
  fltDesEspRes, fltValFreRes, fltDesAceRes: Double;
  intContador: Integer;
Begin
  With zclDetEle Do
  Begin
    fltDesEspRes := fltDesEsp;
    fltValFreRes := fltValFre;
    fltDesAceRes := fltDesAce;

    intContador := 0;

    DisableControls;
    First;

    While Not Eof Do
    Begin
      Inc(intContador);

      Edit;

      If (fDescontoItem(FieldByName('I11_VPROD').AsFloat, fltDesEsp, fltTotIte)
        > fltDesEspRes) Or (intContador = RecordCount) Then
        FieldByName('I17_VDESC').AsFloat := fltDesEspRes
      Else
        FieldByName('I17_VDESC').AsFloat :=
          fDescontoItem(FieldByName('I11_VPROD').AsFloat, fltDesEsp, fltTotIte);

      If (fFreteItem(FieldByName('I11_VPROD').AsFloat, fltValFre, fltTotIte) >
        fltValFreRes) Or (intContador = RecordCount) Then
        FieldByName('I15_VFRETE').AsFloat := fltValFreRes
      Else
        FieldByName('I15_VFRETE').AsFloat :=
          fFreteItem(FieldByName('I11_VPROD').AsFloat, fltValFre, fltTotIte);

      If (fDespesasAcessoriasItem(FieldByName('I11_VPROD').AsFloat, fltDesAce,
        fltTotIte) > fltDesAceRes) Or (intContador = RecordCount) Then
        FieldByName('I17A_VOUTRO').AsFloat := fltDesAceRes
      Else
        FieldByName('I17A_VOUTRO').AsFloat :=
          fDespesasAcessoriasItem(FieldByName('I11_VPROD').AsFloat, fltDesAce,
          fltTotIte);

    (*
      FieldByName('DET_VALLIQ').AsFloat :=
        fValorLiquidoItem(FieldByName('I11_VPROD').AsFloat,
        FieldByName('I17_VDESC').AsFloat, FieldByName('I15_VFRETE').AsFloat,
        FieldByName('I17A_VOUTRO').AsFloat, FieldByName('O14_VIPI').AsFloat,
        FieldByName('N23_VICMSST').AsFloat); *)

      Post;

      fltDesEspRes := fltDesEspRes - FieldByName('I17_VDESC').AsFloat;
      fltValFreRes := fltValFreRes - FieldByName('I15_VFRETE').AsFloat;
      fltDesAceRes := fltDesAceRes - FieldByName('I17A_VOUTRO').AsFloat;

      Next;
    End;
    EnableControls;
  End;
End;

Function TNFEDigManual.fValidaTotaisNota(fltBasIcm, fltTotIcm, fltBasSub,
  fltTotSub, fltTotIpi, fltTotPro: Double): Boolean;
Begin
  Result := False;
  With zclDetEle Do
  Begin

    If RoundTo(fltBasIcm - fRetSoma('SUM_BASICM'), -2) <> 0 Then
    Begin
      pMensagemOk('Base de ICMS da Nota (' + FormatFloat('#,##0.00', fltBasIcm)
        + ') difere da soma das bases dos itens (' + FormatFloat('#,##0.00',
        fRetSoma('SUM_BASICM')) + ')!');
      Exit;
    End;

    If RoundTo(fltTotIcm - fRetSoma('SUM_VALICM'), -2) <> 0 Then
    Begin
      pMensagemOk('Valor do ICMS da Nota (' + FormatFloat('#,##0.00', fltTotIcm)
        + ') difere da soma dos ICMS dos itens (' + FormatFloat('#,##0.00',
        fRetSoma('SUM_VALICM')) + ')!');
      Exit;
    End;

    If RoundTo(fltBasSub - fRetSoma('SUM_BASSUB'), -2) <> 0 Then
    Begin
      pMensagemOk('Base de ICMS Substituição da Nota (' +
        FormatFloat('#,##0.00', fltBasSub) +
        ') difere da soma das bases dos itens (' + FormatFloat('#,##0.00',
        fRetSoma('SUM_BASSUB')) + ')!');
      Exit;
    End;

    If RoundTo(fltTotSub - fRetSoma('SUM_VALSUB'), -2) <> 0 Then
    Begin
      pMensagemOk('Valor do ICMS Substituição da Nota (' +
        FormatFloat('#,##0.00', fltTotSub) +
        ') difere da soma dos ICMS Substituição dos itens (' +
        FormatFloat('#,##0.00', fRetSoma('SUM_VALSUB')) + ')!');
      Exit;
    End;

    If RoundTo(fltTotIpi - fRetSoma('SUM_VALIPI'), -2) <> 0 Then
    Begin
      pMensagemOk('Total do IPI informado no cabeçalho da Nota(' +
        FormatFloat('#,##0.00', fltTotIpi) +
        ') difere da soma dos IPI dos itens (' + FormatFloat('#,##0.00',
        fRetSoma('SUM_VALIPI')) + ')!');
      Exit;
    End;

    If RoundTo(fltTotPro - fRetSoma('SUM_TOTPRO'), -2) <> 0 Then
    Begin
      pMensagemOk('Total dos produtos informados no cabeçalho da Nota(' +
        FormatFloat('#,##0.00', fltTotPro) +
        ') difere da soma dos itens informados (' + FormatFloat('#,##0.00',
        fRetSoma('SUM_TOTPRO')) + ')!');
      Exit;
    End;

  End;

  Result := True;
End;

function TNFEDigManual.fValidaDocumentoUnico(strNumDoc, strSerie,
  strCodFor: String): boolean;
var
  qryQuery : TUniQuery;
begin
  qryQuery := fCriaQuery(nil);
  try
    qryQuery.SQL.Add('SELECT                     ');
    qryQuery.SQL.Add('  COUNT(*) AS QTD          ');
    qryQuery.SQL.Add('FROM                       ');
    qryQuery.SQL.Add('  GERELE                   ');
    qryQuery.SQL.Add('WHERE                      ');
    qryQuery.SQL.Add('      B08_NNF    =  :NUMDOC ');
    qryQuery.SQL.Add('  AND B07_SERIE  =  :SERIE_ ');
    qryQuery.SQL.Add('  AND GER_CODFOR =  :CODFOR ');
    qryQuery.SQL.Add('  AND GER_CODEMP =  :CODEMP ');
    qryQuery.SQL.Add('  AND AUTOINCREM <> :AUTINC ');

    qryQuery.ParamByName('NUMDOC').AsString := strNumDoc;
    qryQuery.ParamByName('SERIE_').AsString := strSerie;
    qryQuery.ParamByName('CODFOR').AsString := strCodFor;
    qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryQuery.ParamByName('AUTINC').AsString := strAutInc;

    qryQuery.Open;

    Result := qryQuery.FieldByName('QTD').AsInteger = 0;

    qryQuery.Close;

    if not Result then
      pMensagemOk('Já existe um documento com o mesmo número de documento, série e código do fornecedor!');
  finally
    FreeAndNil(qryQuery);
  end;
end;

function TNFEDigManual.fAdicionaPedidoImportacao(strNumPed, strCodEmp: String): Boolean;
  Var
    intContador: Integer;
Begin
  Result := True;

  FPedidoCompra.Close;

  If fEmptyStr(FListaPedido) Then
    FPedidoCompra.ParamByName('NUMPED').AsString := strNumPed;

  FPedidoCompra.ParamByName('CODEMP').AsString := strCodEmp;
  FPedidoCompra.Open;

  If Not FPedidoCompra.IsEmpty Then
  Begin

    FPedidoCompra.First;

    While Not(FPedidoCompra.Eof) Do
    Begin

      If FPedidoCompra.FieldByName('BAIXAD').AsInteger = 1 Then
      Begin
        Result := False;
        pMensagemOk('Esse Pedido de Compra está baixado!');
      End Else
      Begin

        strNumPed:= FPedidoCompra.FieldByName('NUMPED').AsString;

        If cdsPedImp.FindKey([strNumPed, strCodEmp]) Then
        Begin
          Result := False;
          pMensagemOk('Pedido já adicionado!');
        End

        Else If (Not cdsPedImp.IsEmpty) And
                (cdsPedImp.FieldByName('CODFOR').AsString <> FPedidoCompra.FieldByName('CODFOR').AsString) Then
        Begin
          Result := False;
          pMensagemOk('Os pedidos precisam ser do mesmo fornecedor!');
        End

        Else If FPedidoCompra.FieldByName('EMPDES').AsString <> VS_strCodEmp Then
        Begin
          Result := False;
          pMensagemOk('Somente pedidos com destino a empresa logada podem ser importados!');
        End

        Else If FPedidoCompra.FieldByName('PEDMLJ').AsString = 'S' Then
        Begin
          Result := False;
          pMensagemOk('Pedidos multi-lojas devem ser desmembrados antes da importação!');
        End

        Else
        Begin
          cdsPedImp.Append;

          For intContador := 0 To cdsPedImp.Fields.Count - 1 Do
            cdsPedImp.Fields[intContador].Value := FPedidoCompra.Fields[intContador].Value;

          cdsPedImp.Post;

          Result := True;
        End;

      End;

      FPedidoCompra.Next;

    End
  End Else
  Begin
    Result := False;
    pMensagemOk('Pedido de Compra não encontrado!');
  End;
End;

Procedure TNFEDigManual.pRemovePedido;
Begin
  If Not Assigned(cdsPedImp) Then
    Exit;

  If Not cdsPedImp.IsEmpty Then
    If fPergunta(Concat('Confirma remoção do pedido ',
                        cdsPedImp.FieldByName('NUMPED').AsString,
                        '?')) Then
    cdsPedImp.Delete;
End;

function TNFEDigManual.fSQLProdutosDoPedido(strNumPed, strCodEmp: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '     PCD_CODITE AS CODITE, ';
  strSQL := strSQL + '   C.ITE_DESITE AS DESITE, ';

  strSQL := strSQL + '     (PCD_QTDITE - PCD_QTDBAI) * IF(PCD_EMBALA = 0 OR PCD_EMBALA IS NULL, 1, PCD_EMBALA) AS QTDITE, ';

  strSQL := strSQL + '  (ROUND(PCD_UNITAR * ';
  strSQL := strSQL + '      (  (1 - IFNULL(PCD_DESUNI, 0) / 100) ';
  strSQL := strSQL + '       * (1 - IFNULL(PCD_DESUN2, 0) / 100) ';
  strSQL := strSQL + '       * (1 - IFNULL(PCD_DESUN3, 0) / 100) ';
  strSQL := strSQL + '       * (1 - IFNULL(PCD_DESUN4, 0) / 100) ';
  strSQL := strSQL + '       * (1 - IFNULL(PCD_DESUN5, 0) / 100) ';
  strSQL := strSQL + '       * (1 - IFNULL(PCD_DESUN6, 0) / 100) ';
  strSQL := strSQL + '       ) / IF(PCD_EMBALA = 0 OR PCD_EMBALA IS NULL, 1, PCD_EMBALA), :DECUNI)) AS UNITAR ';

  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   PCMDET ';
  strSQL := strSQL + ' INNER JOIN CADITE C ON C.ITE_CODITE = PCD_CODITE ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '       PCD_BAIXAD = 0       ';
  strSQL := strSQL + '   AND (PCD_QTDITE - PCD_QTDBAI) > 0       ';
  strSQL := strSQL + '   AND PCD_NUMPED = ' + QuotedStr(strNumPed);
  strSQL := strSQL + '   AND PCD_CODEMP = ' + QuotedStr(strCodEmp);

  Result := strSQL;
End;

function TNFEDigManual.fSQLProdutosDosPedidos: String;
Begin
  Result := '';
  cdsPedImp.First;

  While Not cdsPedImp.Eof Do
  Begin
    If Not fEmptyStr(Result) Then
      Result := Result + ' UNION ALL ';

    Result := Result + fSQLProdutosDoPedido(cdsPedImp.FieldByName('NUMPED').AsString,
                                            cdsPedImp.FieldByName('CODEMP').AsString);

    cdsPedImp.Next;
  End;
End;

function TNFEDigManual.fCarregaProdutosPedidos: Boolean;
  Var
    frmGravando: TfrmGravando;
Begin
  Result := TfrmGravando.fExecuta(fCarregaProdutosPedidosPrg, frmGravando, 'Carregando produtos...');
End;

function TNFEDigManual.fCarregaProdutosPedidosPrg(cxProgesso: TcxProgressBar): Boolean;
  Var
    qryProdutos: TUniQuery;
Begin
  Try
    zclDetEle.EmptyDataSet;

    qryProdutos := fCriaQuery;
    qryProdutos.SQL.Text := fSQLProdutosDosPedidos;
    qryProdutos.ParamByName('DECUNI').AsString := fCfgSis('DECUNI', varInteger);
    qryProdutos.Open;

    cxProgesso.Properties.Max := qryProdutos.RecordCount;

    While Not qryProdutos.Eof Do
    Begin

      If zclDetEle.Locate('DET_CODITE', qryProdutos.FieldByName('CODITE').Value, []) Then
      Begin
        zclDetEle.Edit;
        zclDetEle.FieldByName('I10_QCOM').AsLongWord := zclDetEle.FieldByName('I10_QCOM').AsLongWord + qryProdutos.FieldByName('QTDITE').Value;
      End Else
      Begin
        zclDetEle.Append;
        zclDetEle.FieldByName('DET_CODITE').Value  := qryProdutos.FieldByName('CODITE').Value;
        zclDetEle.FieldByName('I04_XPROD').Value   := qryProdutos.FieldByName('DESITE').Value;
        zclDetEle.FieldByName('I10A_VUNCOM').Value := qryProdutos.FieldByName('UNITAR').Value;
        zclDetEle.FieldByName('I10_QCOM').Value    := qryProdutos.FieldByName('QTDITE').Value;
      End;

      zclDetEle.FieldByName('I11_VPROD').AsFloat := RoundTo(zclDetEle.FieldByName('I10_QCOM').AsFloat * zclDetEle.FieldByName('I10A_VUNCOM').AsFloat, -2);

      zclDetEle.Post;

      cxProgesso.Position := cxProgesso.Position + 1;
      Application.ProcessMessages;

      qryProdutos.Next;
    End;

    FreeAndNil(qryProdutos);

    Result := True;

  Except

    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TNFEDigManual.fCarregaProdutosPedidosPrg]');
    End;

  End;

End;

end.

