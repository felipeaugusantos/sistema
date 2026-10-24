unit untEditorFastImpressao;

interface

uses Classes, frxClass, frxDBSet, DB, Uni, Forms, untLeDocumento, untModuloFr3, frxDMPExport,
  untTypesSistema, TypesRel, untConstantes, untOrdenacao, untFuncoesEditorFast, untCfgRel,
  UniClientDataSet, untZClient, untDocPDOR_Excel, Winapi.Windows, System.SysUtils, untModImpFast,
  Winapi.ActiveX;

Type
  TEditorFastImpressao = Class(TComponent)
  FCdsMovGer  : TZClient;
  FCdsMovDet  : TZClient;

  Private

    FImprimePDF: Boolean;

    FViasPag: Integer;
    FDBIEti: TfrxDBDataset;
    FReport: TfrxReport;

    FCodEti: TTipoEtiqueta;
    FObjOrd: TOrdenacao;

    qryLayEti: TUniQuery;

    FMatricial: Boolean;

    FNomeImpressora: String;

    frxMasterData: TfrxMasterData;

    objLeDocumento: TLeDocumento;

    qryCfgRel: TUniQuery;

    FPrtMod: integer;

    FNomLay: String;
    FNomArq: String;
    FPath: String;

    FExecuteBreak: Boolean;
    FViaDoc: Integer;

    FModImpFast: TfrmModImpFast;

    procedure pCarregaConfImpr(Var qryCfgRel: TUniQuery; Const strNomeForm: String; strCodEmp: String = ''; strNomeFila: String = '');

    Function fCarregaRegistro(blnPadrao: Boolean; strCodLay: String; tpaTipArq: TTipoArquivo): Boolean;
    Function fCarregaFr3: Boolean;

    procedure pAjustaFr3;

    procedure pCriarObjetos;

    procedure pCaseTpaNormal;
    procedure pCaseTpaPdf;
    procedure pCaseTpaExcel;

    Function fRetfrxMasterData: TfrxMasterData;
    Function fConfiguraFilaMIFF: Boolean;
    Function fConfiguraFilaPDOR: Boolean;
    Function fConfiguraFilaSeparacao: Boolean;
    Function fLeDadosImpressao: Boolean;
    Function fConfiguraFilaImpressao(intContador: Integer): Boolean;
    function fRetornaQuantidadeItens: Integer;
    function fImpSepAvulsaTintaAutomotivaWMS: Boolean;
  Public
    recDocume: TRecDocumento;

    class var strEmpresaLayout: String;

    strArqPDF: String;
    strArqExcel: String;

    property tpeTipoEtiqueta : TTipoEtiqueta read FCodEti write FCodEti default tpeNenhum;

    constructor Create(Owner: TComponent); reintroduce;

    Destructor Destroy; override;

    function fImprimeDocumento(tpaTipArq: TTipoArquivo = tpaNormal;
                               strPath: String = '';
                               strNomArq: String = ''): Boolean;

  End;

implementation

uses Printers,
     Messages,
     DateUtils,
     untFuncoesSimples,
     StrUtils,
     ShellApi,
     untDocGarantias;

constructor TEditorFastImpressao.Create(Owner: TComponent);
begin
  Inherited Create(Owner);
  pCriarObjetos;
end;

procedure TEditorFastImpressao.pCriarObjetos;
Begin
  Inherited Create(Owner);

  FImprimePDF    := False;
  FObjOrd        := Nil;
  qryLayEti      := Nil;
  objLeDocumento := Nil;

  strArqPDF      := '';
  strArqExcel    := '';
  FMatricial     := False;

  FModImpFast := TfrmModImpFast.Create(Self);

  FDBIEti       := TfrxDBDataSet.Create(Self);
  FDBIEti.Name  := 'frxDBImpEti';

  FNomeImpressora := '';

  qryCfgRel := fCriaQuery(Self);
  qryLayEti := fCriaQuery(Self);
End;

Destructor TEditorFastImpressao.Destroy;
Begin
  If Assigned(objLeDocumento) Then
    FreeAndNil(objLeDocumento);

  FreeAndNil(FReport);

  Inherited Destroy;
End;

Function TEditorFastImpressao.fRetfrxMasterData: TfrxMasterData;
  Var
    intIndice: Integer;
Begin
  Result := Nil;

  For intIndice := 0 To FReport.ComponentCount - 1 Do
  Begin
    If (FReport.Components[intIndice] Is TfrxMasterData) And
       (Not SameText((FReport.Components[intIndice] As TfrxMasterData).Name, 'masterVias')) Then
    Begin
      Result := (FReport.Components[intIndice] As TfrxMasterData);
      Break;
    End;
  End;
End;

procedure TEditorFastImpressao.pCarregaConfImpr(var qryCfgRel: TUniQuery;
  const strNomeForm: String; strCodEmp, strNomeFila: String);
var
  LDocumento: String;
begin
  untFuncoesSimples.pCarregaConfImpr(qryCfgRel, strNomeForm, strCodEmp, strNomeFila);

  recDocume.strNomPro := strNomeForm;
  recDocume.strDesPro := qryCfgRel.FieldByName('REL_DESPRO').AsString;

  If recDocume.strDesPro.IsEmpty Then
    recDocume.strDesPro := FNomLay;

  If Not recDocume.strNumDoc.IsEmpty Then
    LDocumento := Format('%s-%s-%s',[recDocume.strNumDoc, recDocume.strEspDoc, recDocume.strCodEmp]);

  If Not LDocumento.IsEmpty Then
    recDocume.strDesPro := recDocume.strDesPro + ' (' + LDocumento + ')';
end;

procedure TEditorFastImpressao.pCaseTpaExcel;
var
  objDocPDOR_Excel: TDocPDOR_Excel;
  strDir_PD_OR    : String;
  strPathCompleto : String;
begin
  objDocPDOR_Excel := TDocPDOR_Excel.Create(Self);
  objDocPDOR_Excel.ObjExcel.FblnShowOnTerminate := False;
  Try

    If (objDocPDOR_Excel.fUtilizaLayOutExcel) Then
    Begin

      {Nome do Arquivo}
      FNomArq := recDocume.strEspDoc + '_' + recDocume.strNumDoc + '_' + recDocume.strCodEmp;
      FNomArq := FNomArq + '.xls';

      strDir_PD_OR := ExtractFilePath(Application.ExeName) + 'PedidoOrcamento\';

      If Not DirectoryExists(strDir_PD_OR) Then
        fCriaDiretorio(strDir_PD_OR);

      strPathCompleto := (strDir_PD_OR + FNomArq);

      {Copia Lay-Out padrão}
      If FileExists(strPathCompleto) Then
        DeleteFile(strPathCompleto);

      CopyFile(PChar(ExtractFilePath(Application.ExeName) + objDocPDOR_Excel.strArq_LayOut),
               PChar(strPathCompleto),
               False);

      {Abre arquivo com o padrão}
      If objDocPDOR_Excel.objExcel.AbrirArquivo(strPathCompleto) Then
      Begin

        {Dados}
        objDocPDOR_Excel.pSetDados(objLeDocumento.arrClients);

        objDocPDOR_Excel.pMontarPlanilha;;

        objDocPDOR_Excel.objExcel.SalvarArquivo(False, False);
        strArqExcel := strPathCompleto;

      End;

    End;

  Finally
    objDocPDOR_Excel.ObjExcel.FecharArquivo;
    FreeAndNil(objDocPDOR_Excel);
  End;
end;

procedure TEditorFastImpressao.pCaseTpaNormal;
begin
  try
    FReport.EngineOptions.UseFileCache := False;

    If fPrepareReport(FReport, True) Then
    Begin
      If (recDocume.intQtdImp > 0) And (FPrtMod=2) Then
        FReport.PrintOptions.Copies := recDocume.intQtdImp;

      If fEmptyStr(recDocume.strNomImp) Or (recDocume.strSaida = 'V') Then
      Begin
        FReport.Script.Variables['VIADOC'] := IntToStr(1);

        If (Not (recDocume.strSaida = 'V')) And (Not VS_SpoolImpressaoCitel) Then
          FReport.SelectPrinter;

        If fPrepareReport(FReport, True) Then//Para renderizar as imagens é necessário chamar novamente PrepareReport
          pPreviewReport(recDocume.strNomPro, recDocume.strDesPro, FReport);

        FExecuteBreak := True;
      End
      Else
      Begin
       FReport.Script.Variables['VIADOC'] := IntToStr(FViaDoc);
       If fPrepareReport(FReport, True) Then//Para renderizar as imagens é necessário chamar novamente PrepareReport
         pPrintReport(recDocume.strNomPro, recDocume.strDesPro, recDocume.strNomImp, FReport);
      End;
    End;

    FReport.EngineOptions.UseFileCache := True;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pCaseTpaNormal]');
      FReport.EngineOptions.UseFileCache := True;
    End;
  End;

end;

procedure TEditorFastImpressao.pCaseTpaPdf;
begin
  try
    FReport.EngineOptions.UseFileCache := False;


    If FReport.PrepareReport Then
    Begin
      If fEmptyStr(FNomArq) Then
        FNomArq := recDocume.strEspDoc + '_' + recDocume.strNumDoc + '_' + recDocume.strCodEmp;

      FNomArq := FNomArq + '.pdf';

      If (recDocume.strSaida = 'I') And FImprimePDF Then
        FPath := ExtractFilePath(Application.ExeName) + PASTA_PDF_IMPRESSAO_DIRETA + '\';

      If fEmptyStr(FPath) Then
      Begin
        If (fEmptyStr(recDocume.strPasPdf)) Then
          FPath := ExtractFilePath(Application.ExeName) + 'Docs_Env_Reimp\'
        Else
          FPath := ExtractFilePath(Application.ExeName) + recDocume.strPasPdf + '\';
      End;

      FModImpFast.frxPDFExport.PrintOptimized := fCfgSis('IOTPDF', varBoolean);
      FModImpFast.frxPDFExport.Background := True;
      FModImpFast.frxPDFExport.ShowDialog  := Not fCriaDiretorio(FPath);

      Try
        FModImpFast.frxPDFExport.DefaultPath := FPath;
      Except
        // do nothing
      End;

      If Not VS_ExibirMensagemAoUsuario Then
        FModImpFast.frxPDFExport.ShowProgress := False;

      FModImpFast.frxPDFExport.FileName := FNomArq;

      If FReport.PrepareReport Then//Para renderizar as imagens é necessário chamar novamente PrepareReport
        FReport.Export(FModImpFast.frxPDFExport);

      strArqPDF := FPath + FNomArq;

      If (recDocume.strSaida = 'V') Then
      Begin
        pExecArquivo(strArqPDF, 0);
      End
      Else If (recDocume.strSaida = 'I') And FImprimePDF Then
      Begin
        TCfgRel.pPrintPDF(recDocume.strNomPro, recDocume.strDesPro, recDocume.strNomImp, strArqPDF);
      End;

    End;

    FReport.EngineOptions.UseFileCache := True;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pCaseTpaNormal]');
      FReport.EngineOptions.UseFileCache := True;
    End;
  End;
end;

procedure TEditorFastImpressao.pAjustaFr3;
Var
  LIndice: Integer;
  LComponent: TfrxComponent;
Begin
  For LIndice := 0 To FReport.ComponentCount - 1 Do
  Begin
    If Not (FReport.Components[LIndice] Is TfrxComponent) Then
      Continue;

    LComponent := (FReport.Components[LIndice] As TfrxComponent);

    If LComponent.Name <> EmptyStr Then
      Continue;

    LComponent.Name := LComponent.ClassName.Replace('Tfrx', EmptyStr) + LIndice.ToString;
  End;
end;

Function TEditorFastImpressao.fCarregaFr3: Boolean;
 Var
   mmsLoad: TStream;
Begin
  With qryLayEti Do
  Begin
    If FieldByName('LAY_TIPIMP').AsString = 'M' Then
    Begin
      FReport := FModImpFast.frxReportM;

      If (FieldByName('LAY_ESCMOD').AsInteger < 4) And (FieldByName('LAY_ESCMOD').AsInteger >= 0) Then
        FModImpFast.frxMatricial.EscModel := FieldByName('LAY_ESCMOD').AsInteger;

      If (FieldByName('LAY_AVNPAG').AsString='N') Then
         FModImpFast.frxMatricial.PageBreaks:=False
      Else
         FModImpFast.frxMatricial.PageBreaks:=True;

    End Else
    Begin
      FReport := FModImpFast.frxReportJ;
    End;

    FObjOrd := TOrdenacao.Create(Self, FieldByName('LAY_ORDENA').AsString, ARR_CODIGO_ETIQUETA[FCodEti]);

    FImprimePDF := SameText(FieldByName('LAY_IMPPDF').AsString, 'S');

    Edit;

    // layout do pedido de compra ainda nao salvo no editor depois da reforma: CBS / IBS / IS so na memoria
    If (FCodEti = tpePedidoCompra) And (FieldByName('LAY_TIPIMP').AsString <> 'M') And
       (Not fLayoutComReformaPedidoCompra(qryLayEti)) And fSomarNovosImpostosDaReformaAoValorContabil Then
      FieldByName('LAY_RELFR3').AsBytes := fInjetaReformaPedidoCompra(FieldByName('LAY_RELFR3').AsBytes);

    mmsLoad := CreateBlobStream(FieldByName('LAY_RELFR3'), bmReadWrite);

    FReport.LoadFromStream(mmsLoad);

    If fTemParametro(FReport, 'INFADI') Then
      FReport.Script.Variables['INFADI'] := fInformacaoAdicionalEtiquetaItens(recDocume.strCodIte);

    pAjustaFr3;

    Cancel;

    FreeAndNil(mmsLoad);

    frxMasterData := fRetfrxMasterData;

    Result := True;
  End
End;

Function TEditorFastImpressao.fCarregaRegistro(blnPadrao: Boolean; strCodLay: String; tpaTipArq: TTipoArquivo): Boolean;
const
  intCFG_TIPO_LAYOUT_ATIVAR_PDF = 2;
var
  blnAtivouRegra: Boolean;
Begin
  Try
    qryLayEti.Close;
    qryLayEti.SQL.Clear;
    qryLayEti.SQL.Add('SELECT * ');
    qryLayEti.SQL.Add('  FROM LAYETI');
    qryLayEti.SQL.Add(' WHERE LAY_TIPLAY = :TIPLAY');

    blnAtivouRegra := False;

    if (TCfgRel.AtivarCfgLayoutRegraCancelamento) and
       (fEmptyStr(strCodLay)) and
       (fCfgSis('LAYATV',varString) = intCFG_TIPO_LAYOUT_ATIVAR_PDF) then
    begin
      TCfgRel.AtivarCfgLayoutRegraCancelamento := False;
      blnAtivouRegra := True;
      qryLayEti.SQL.Add('   AND LAY_GERPDF = "S"');
    end
    else If blnPadrao Then
    Begin
      If tpaTipArq = tpaPDF Then
      Begin
        If (Not fEmptyStr(strCodLay)) Then
          qryLayEti.SQL.Add(' AND LAY_CODLAY = ' + QuotedStr(strCodLay))
        Else
          qryLayEti.SQL.Add(' AND LAY_GERPDF = "S"  ')
      End
      Else
      Begin
        If (Not fEmptyStr(strCodLay)) Then
          qryLayEti.SQL.Add(' AND LAY_CODLAY = ' + QuotedStr(strCodLay))
        Else
          qryLayEti.SQL.Add(' AND LAY_PADRAO = "S"  ');
      End;
    End
    Else
      qryLayEti.SQL.Add(' AND LAY_CODLAY = ' + QuotedStr(strCodLay));

    if fEmptyStr(strEmpresaLayout) then
    begin
      If (fUsaLayOrigReimpDocs()) Then
        qryLayEti.SQL.Add(' AND LAY_CODEMP = ' + QuotedStr(recDocume.strCodEmp))
      Else
        qryLayEti.SQL.Add(' AND LAY_CODEMP = ' + QuotedStr(VS_strCodEmp));
    end
    else
      qryLayEti.SQL.Add(' AND LAY_CODEMP = ' + QuotedStr(strEmpresaLayout));

    qryLayEti.ParamByName('TIPLAY').AsInteger := ARR_TIPO_LAYOUT[FCodEti];

    qryLayEti.Open;

    if qryLayEti.IsEmpty and blnAtivouRegra then
    begin
      Result := fCarregaRegistro(blnPadrao, strCodLay, tpaTipArq);
      Exit;
    end;

    Result := Not qryLayEti.IsEmpty;

    If Result Then
    Begin
      FMatricial := qryLayEti.FieldByName('LAY_TIPIMP').AsString = 'M';
      FViasPag   := qryLayEti.FieldByName('LAY_VIAPAG').AsInteger;
      FPrtMod    := qryLayEti.FieldByName('LAY_PRTMOD').AsInteger;
      FNomLay    := qryLayEti.FieldByName('LAY_NOMLAY').AsString;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fCarregaRegistro]');
    End;
  End;

End;

Function TEditorFastImpressao.fLeDadosImpressao: Boolean;
Begin
  Result := False;

  With recDocume Do
    objLeDocumento := fEspecieToClassDocumento(strNumDoc, strEspDoc, strCodEmp, strTipFc, blnDocSep, blnRequisicao, opcAgrupaPor = opcPedido,  FCodEti).Create(Nil);


  if objLeDocumento is TLeDocumentoGA then
    TLeDocumentoGA(objLeDocumento).blnReimpressaoGR := True;


  objLeDocumento.tpeTipEtq := Self.FCodEti;
  If Not Assigned(objLeDocumento) Then
    Exit;

  objLeDocumento.strEmpLay    := strEmpresaLayout ;
  objLeDocumento.recDocume    := recDocume;
  objLeDocumento.objOrdena    := FObjOrd;
  objLeDocumento.frxReport    := FReport;
  objLeDocumento.fdbImpEti    := FDBIEti;
  objLeDocumento.blnMatricial := FMatricial;

  Result := objLeDocumento.fMontaClients(FCdsMovGer, FCdsMovDet);

  objLeDocumento.pAjustarSequencia;

  if not Assigned(objLeDocumento.fdbImpEti) then
    Exit(False);

  If Result Then
   frxMasterData.DataSet := objLeDocumento.fdbImpEti;

  recDocume.strEntFut := objLeDocumento.recDocume.strEntFut;

  If fImpSepAvulsaTintaAutomotivaWMS Then
    recDocume.intQtdIte := recDocume.intQtdIte + fRetornaQuantidadeItens
  Else
    recDocume.intQtdIte := fRetornaQuantidadeItens;
End;

function TEditorFastImpressao.fImprimeDocumento(tpaTipArq : TTipoArquivo = tpaNormal;
                                                strPath   : String = '';
                                                strNomArq : String = ''): boolean;
Var
  intContador       : Integer;
  blnPadrao         : Boolean;
  strLayTmp         : String;
  blnImpSepRomaneio : Boolean;
  intQtdVias        : Integer;
  intVias           : Integer;
  objMasterVias     : TfrxComponent;
  lstrEspDoc: String;
Begin
  Try
    Result := True;

    FNomArq := strNomArq;
    FPath := strPath;

    With recDocume Do
    Begin
      blnImprimiu := True;
      blnImpSepRomaneio := (opcAgrupaPor = opcPedido) And blnDocSep;

      If (blnImpSepRomaneio) Then
      Begin
        blnPadrao := False;
        If (fUsaLayOrigReimpDocs()) Then
          strLayTmp := fCfgSis('SEEXLA',varString, recDocume.strCodEmp)
        Else
          strLayTmp := fCfgSis('SEEXLA',varString);
      End
      Else
      Begin
        blnPadrao := True;

        If (Not fEmptyStr(recDocume.strCodLay)) Then
          strLayTmp := recDocume.strCodLay
        Else
          strLayTmp := '';
      End;

      if Not(fEmptyStr(strNumRem)) then
        FCodEti := tpeRemessaDevolucao;

      If blnDocumentoCreditoFF Then
        FCodEti := tpeFFDocumentosCR;

      If blnTicketNF Then
        FCodEti := tpeTicketNF;

      If blnTicketDV Then
        FCodEti := tpeTicketDV;

      If blnCarnePagamento Then
        FCodEti := tpeCarnePagamento;

      If blnDuplicata Then
        FCodEti := tpeDuplicata;


      if blnComprovanteGeracaoCredito then
        FCodEti := tpeComprovanteGeracaoCredito;


      If blnInspecaoEnt Then
        FCodEti := tpeInspecaoEnt;

      If blnInspecaoSai Then
        FCodEti := tpeInspecaoSai;

      If blnOrdProImo Then
        FCodEti := tpeOrdProImobiliaria;

      If blnOrdProAut Then
        FCodEti := tpeOrdProAutomotiva;

      If blnLiberacaoArmazenagem Then
        FCodEti := tpeLiberacaoArmazenagem;

      If blnProcessoDeExtrusao Then
        FCodEti := tpeProcessoDeExtrusao;

      If blnEnderecamentoDeProduto Then
        FCodEti := tpeEnderecamentoDeProduto;

      If blnPDExterior Then
        FCodEti := tpePDExterior;

      If blnORExterior Then
        FCodEti := tpeORExterior;

      If blnCupomPromocao Then
        FCodEti := tpeCupomPromocao;

      lstrEspDoc := strEspDoc;

      if recDocume.blnReimpressaoGR then
        lstrEspDoc := 'GR';

      If fEspecieEtqToTipoDocumentos(strNumDoc, lstrEspDoc, strCodEmp, strTipFC, blnDocSep, blnRequisicao, recDocume.blnVidro, blnImpSepRomaneio, FCodEti) Then
      Begin
        blnTemLay := fCarregaRegistro(blnPadrao, strLayTmp, tpaTipArq);

        If (blnTemLay) Then
        Begin

          If (recDocume.blnReimpr) And (FViasPag > 1) Then
          Begin
            intQtdVias := FViasPag;
          End
          Else
          Begin

            If recDocume.intQtdImp <= 0 Then
              recDocume.intQtdImp := 1;

            If (tpaTipArq = tpaNormal) And (strSaida <> 'V') Then
              intQtdVias := recDocume.intQtdImp
            Else If (tpaTipArq = tpaPDF) Then
              intQtdVias := FViasPag
            Else
              intQtdVias := 1;

          End;

          intVias := 1;

          If (intQtdVias > 1) And (FViasPag > 1) Then
          Begin
            intVias := intQtdVias;
            intQtdVias := 1;
            intQtdImp  := 0;
          End;

          If (FPrtMod=2) Then
            intQtdVias := intVias;

          If (intVias > 1) And (FViasPag > 1) Then
            intVias := iif(intVias > FViasPag, intVias, FViasPag);

          If (intVias = 3) then
            intQtdVias := 2;

          for intContador := 1 to intQtdVias do
          Begin
            If fCarregaFr3 And fLeDadosImpressao And ( (fConfiguraFilaImpressao(intContador)) Or (strSaida = 'V') ) Then
            Begin
              FViaDoc := intContador;

              If (intVias > 1) Then
              Begin
                objMasterVias := FReport.FindObject('masterVias');
                If Assigned(objMasterVias) Then
                  TfrxMasterData(objMasterVias).RowCount := intVias;

                If (intVias = 4) then
                begin
                  If Assigned(objMasterVias) Then
                  begin
                    TfrxMasterData(objMasterVias).RowCount := 2;
                    FReport.PrintOptions.Copies := 2;
                  end;
                end;

                If (intVias = 3) then
                begin
                  If Assigned(objMasterVias) Then
                  begin
                    if (intContador=1) then
                      TfrxMasterData(objMasterVias).RowCount := 2
                    else
                      TfrxMasterData(objMasterVias).RowCount := 1;
                    FReport.PrintOptions.Copies := 1;
                  end;
                end;

              End;

              Case FPrtMod of
                0: FReport.PrintOptions.PrintMode := pmDefault;
                1: FReport.PrintOptions.PrintMode := pmSplit;
                2: FReport.PrintOptions.PrintMode := pmJoin;
                3: FReport.PrintOptions.PrintMode := pmScale;
              end;

              FReport.PrintOptions.Printer    := IIF(fEmptyStr(strNomImp),TCfgRel.fGetImpressoraSelecionada, strNomImp);
              FReport.PrintOptions.ShowDialog := fEmptyStr(strNomImp);
              FReport.PreviewOptions.Buttons  := [pbPrint, pbZoom,pbFind,pbOutline,pbPageSetup,pbNavigator];

              If recDocume.blnSemProgesso Then
              Begin
                FReport.PrintOptions.ShowDialog := False;
                FReport.ShowProgress := False;
              End;

              {$IFDEF TESTABILIDADE_AUTCOM}
                FReport.PreviewOptions.Buttons  := [pbPrint, pbZoom,pbFind,pbOutline,pbPageSetup,pbNavigator, pbExport, pbSave];
              {$ENDIF}

              //FORÇA A GERAÇÃO DO PDF
              If (blnGerPdf) Then
              Begin
                tpaTipArq := tpaPDF;

                //FORÇA VISUALIZAR O PDF
                If (blnVisPdf) Then
                  strSaida := 'V'
                Else
                  strSaida := 'I';
              End
              Else
              Begin
                //FORÇA VISUALIZAR O PDF
                If (blnVisPdf) Then
                  strSaida := 'V';
              End;

              If (strSaida = 'I') And FImprimePDF  Then
                tpaTipArq := tpaPDF;

              if recDocume.strNomPro.IsEmpty then
                recDocume.strNomPro := Self.ClassName;

              if recDocume.strDesPro.IsEmpty then
                recDocume.strDesPro := FNomLay +  Format(' (%s-%s-%s) ',
                  [recDocume.strNumDoc, recDocume.strEspDoc, recDocume.strCodEmp]);

              If blnImpressaoColetor Then
                Break;

              FExecuteBreak := False;

              Case tpaTipArq Of
                tpaNormal: pCaseTpaNormal;
                tpaPDF   : pCaseTpaPdf;
                tpaExcel : pCaseTpaExcel;
              End;

              If FExecuteBreak Then
                Break;
            End
            Else
            begin
              blnImprimiu := False;
            End;

            objLeDocumento.pLiberaArrClients;

            If Assigned(objLeDocumento) Then
              FreeAndNil(objLeDocumento);
          End;

          If (Not blnTinAut) And fImpSepAvulsaTintaAutomotivaWMS Then
          Begin
            blnTinAut := True;
            Result := fImprimeDocumento(tpaTipArq, strPath, FNomArq);
          End;
        End
        Else
        Begin
          blnImprimiu := False;
          Result := False;
        End;
      End Else
      Begin
        blnImprimiu := False;
        Result := False;
      End
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TEditorFastImpressao.fImprimeDocumento]');
    End;
  End;

End;

function TEditorFastImpressao.fImpSepAvulsaTintaAutomotivaWMS: Boolean;
begin
  Result := False;

  If (Not recDocume.blnDocSep) Then
    Exit;

  If (Pos(recDocume.strEspDoc, 'OR_PD_') = 0) Then
    Exit;

  If (Not fUsaSepAvulsaTintaAutomotivaWMS) Then
    Exit;

  Result := True;
end;

Function TEditorFastImpressao.fConfiguraFilaSeparacao: Boolean;
  Var
    strSetorSep: String;
Begin
  Try

    With recDocume Do
    Begin
      If (strEspDoc = 'OR') And (blnImpFil) Then
      Begin
        pCarregaConfImpr(qryCfgRel, 'frmFatVendas_OR_FILIAL');
      End
      Else If (blnDocSep) And (blnSepFut) Then
      Begin
        pCarregaConfImpr(qryCfgRel, 'frmFatVendas_sepfut');
      End
      Else If (strEspDoc = 'PD') And (blnDocSep) And (blnEnt_CD) And fFilaExiste('frmFatVendas_sepcd') Then
      Begin
        pCarregaConfImpr(qryCfgRel, 'frmFatVendas_sepcd');
      End
      Else If (strEspDoc = 'IT') Then
      Begin
        pCarregaConfImpr(qryCfgRel, 'frmCadProdutos_SepItem');
      End
      Else If (strSaida <> 'P') And (fEmptyStr(strNomImp)) then
      Begin

        If (blnDocSep) Or (blnRequisicao) Then
        Begin
          strSetorSep := '';
          If blnDocSep And (Not fEmptyStr(Trim(strSetor))) Then
            strSetorSep := '_' + strSetor;

          If (blnDocSep) And
             (Not fEmptyStr(Trim(strSetor))) And
             (Not fEmptyStr(strSepPedEntregaOuRetira)) And
             (fCfgSis('GRUSEP', VarString) = 'S') And
             (strEspDoc = 'PD') And
             (fFilaExiste('frmFatVendas_SEP_' + strSetor + '_' + IfThen(strSepPedEntregaOuRetira = 'R', NOME_FILA_RETIRA, IfThen(strSepPedEntregaOuRetira = 'E', NOME_FILA_ENTREGA, '')))) Then
               strSetorSep := '_' + strSetor + '_' + IfThen(strSepPedEntregaOuRetira = 'R', NOME_FILA_RETIRA, IfThen(strSepPedEntregaOuRetira = 'E', NOME_FILA_ENTREGA, ''));

          If (Not blnSempreEntr) Then
          Begin
            If (Not fEmptyStr(strGerRom)) And (SameText(strGerRom, 'S')) Then
            Begin
              If Not blnImpExpedicao Then
                pCarregaConfImpr(qryCfgRel, 'frmFatVendas_SEP' + strSetorSep, IfThen(blnFilEmp, strCodEmp, VS_strCodEmp))
              Else
                pCarregaConfImpr(qryCfgRel, 'frmFatVendas_SEPEXP' + strSetorSep, IfThen(blnFilEmp, strCodEmp, VS_strCodEmp))
            End
            Else
            Begin
              If Not blnImpExpedicao Then
                pCarregaConfImpr(qryCfgRel, 'frmFatVendas_SEP_RET' + strSetorSep, IfThen(blnFilEmp, strCodEmp, VS_strCodEmp))
              Else
                pCarregaConfImpr(qryCfgRel, 'frmFatVendas_SEPEXP_RET' + strSetorSep, IfThen(blnFilEmp, strCodEmp, VS_strCodEmp));

              If (qryCfgRel.IsEmpty) Or (blnRequisicao) Or
                 (fEmptyStr(qryCfgRel.FieldByName('REL_NOMFIL').AsString)) Then
              Begin
                If Not blnImpExpedicao Then
                  pCarregaConfImpr(qryCfgRel, 'frmFatVendas_SEP' + strSetorSep, IfThen(blnFilEmp, strCodEmp, VS_strCodEmp))
                Else
                  pCarregaConfImpr(qryCfgRel, 'frmFatVendas_SEPEXP' + strSetorSep, IfThen(blnFilEmp, strCodEmp, VS_strCodEmp));
              End;
            End;
          End
          Else
          Begin
            If Not blnImpExpedicao Then
              pCarregaConfImpr(qryCfgRel, 'frmFatVendas_SEP' + strSetorSep, IfThen(blnFilEmp, strCodEmp, VS_strCodEmp))
            Else
              pCarregaConfImpr(qryCfgRel, 'frmFatVendas_SEPEXP' + strSetorSep, IfThen(blnFilEmp, strCodEmp, VS_strCodEmp));
          End;

          If (Not blnRequisicao) And blnDocSep And (opcAbastecimento In [opcSolicitado]) Then
            pCarregaConfImpr(qryCfgRel, 'frmFatVendas_SEP_SOL', IfThen(blnFilEmp, strCodEmp, VS_strCodEmp));

        End;

      End;

      Result := True;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TEditorFastImpressao.fConfiguraFilaSeparacao]');
      Result := False;
    End;

  End;
End;

Function TEditorFastImpressao.fConfiguraFilaPDOR: Boolean;
  Var
    strNomForm: String;
Begin
  Try

    With recDocume Do
    Begin

      If (strEspDoc = 'OR') And (blnImpFil) Then
      Begin
        pCarregaConfImpr(qryCfgRel, 'frmFatVendas_OR_FILIAL');
      End

      Else If blnSimples Then
        pCarregaConfImpr(qryCfgRel, 'frmFatVendas_NFSIMP', IfThen(blnFilEmp, strCodEmp, VS_strCodEmp))

      Else
      Begin
        strNomForm := 'frmFatVendas_' + IfThen(SameText(strEspDoc, 'ML'), 'AJ', strEspDoc);

        If (Pos(strEspDoc, 'MI_FF_') > 0) And blnImpExpedicao Then
          strNomForm := strNomForm + 'EXP';

        if FCodEti in [tpeOrdProImobiliaria, tpeOrdProAutomotiva] then
          strNomForm := 'frmFatVendas_OP';

        If (strEntFut = 'S') Then
        Begin
          pCarregaConfImpr(qryCfgRel, strNomForm + 'FUT', IfThen(blnFilEmp, strCodEmp, VS_strCodEmp));
          If qryCfgRel.IsEmpty Then
            pCarregaConfImpr(qryCfgRel, strNomForm, IfThen(blnFilEmp, strCodEmp, VS_strCodEmp));
        End
        Else
          pCarregaConfImpr(qryCfgRel, strNomForm, IfThen(blnFilEmp, strCodEmp, VS_strCodEmp));
      End;

      Result := True;

    End;

  Except
    On E: Exception Do
    Begin
      If E.Message = 'System Error.  Code: 1722.'#$D#$A'O servidor RPC não está disponível' Then
      begin
        fMensagem('','Spooler de Impressão do Windows não está iniciado ou está com erro. É necessário reiniciá-lo em Serviços do Windows.' ,['&OK']);
      end;
      Result := False;
    End;

  End;
End;

Function TEditorFastImpressao.fConfiguraFilaMIFF: Boolean;
  Var
    strNomForm: String;
Begin
  Try

    With recDocume Do
    Begin
      strNomImp := '';
      strTipImp := '';

      If (fCfgSis('IMPAUT') <> '1') And blnConfir And (Not blnDocSep) Then
      Begin

        pCarregaConfImpr(qryCfgRel, 'frmFatVendas_AUT', IfThen(blnFilEmp, strCodEmp, VS_strCodEmp))

      End Else
      Begin
        strNomForm := 'frmFatVendas_' + IfThen(SameText(strEspDoc, 'ML'), 'AJ', strEspDoc);

        If (Pos(strEspDoc, 'MI_FF_') > 0) And blnImpExpedicao Then
          strNomForm := strNomForm + 'EXP';

        If (strEntFut = 'S') Then
        Begin

          pCarregaConfImpr(qryCfgRel, strNomForm + 'FUT', IfThen(blnFilEmp, strCodEmp, VS_strCodEmp));

          If qryCfgRel.IsEmpty Then
            pCarregaConfImpr(qryCfgRel, strNomForm, IfThen(blnFilEmp, strCodEmp, VS_strCodEmp));

        End Else
        Begin

          pCarregaConfImpr(qryCfgRel, strNomForm, IfThen(blnFilEmp, strCodEmp, VS_strCodEmp));

        End;
      End;

    End;

    Result := True;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TEditorFastImpressao.fConfiguraFilaMIFF]');
      Result := False;
    End;

  End;
End;

Function TEditorFastImpressao.fConfiguraFilaImpressao(intContador: Integer): Boolean;
Begin
  If intContador > 1 Then
  Begin
    Result := True;
    recDocume.strNomImp := FNomeImpressora;
    Exit;
  End;

  If (Not fEmptyStr(recDocume.strNomImp)) Then
  Begin
    Result := True;
    FNomeImpressora := recDocume.strNomImp;
    Exit;
  End;

  If (recDocume.blnNaoSelImp) Then Begin
    Result := True;
    Exit;
  End;

  Result := False;

  With recDocume Do
  Begin

    Case fEspecieToTipoDocumeto(strNumDoc, strEspDoc, strCodEmp, strTipFC, blnDocSep, blnRequisicao, opcAgrupaPor = opcPedido, blnVidro, FCodEti) Of
      docNF,
      docNS,
      docSF,
      docMI,
      docFF,
      docTR,
      docDV,
      docBR,
      docAJ,
      docTA,
      docEP,
      docBE,
      docUS,
      docCS,
      docCR,
      docTE,
      docPI,
      docGA,
      docGF,
      docContGF,
      docContGR,
      docContGC,
      docContGRBaixa,
      docSolicitacaoManutencaoEquipamentos,
      docPedidocompra,

      docOrdPro,
      docLocacaoEquipamento,
      docDevolucaoLocacao,
      docInspecaoEnt,
      docInspecaoSai,
      docProcessoDeExtrusao,
      docIF,
      docTicketNF,
      docTicketDV,
      docD1,
      docOrdemServico,
      docOrdemServicoTermoResp,
      docOrdemServicoTermoDev,
      docOrdemServicoOrdExecucao,
      docOrdemServicoImagem,
      docPA,
      docROTin,
      docRequisicao,
      docReqMaterialConsumo,
      docReqMaterialConsumoVidro,
      docOrdProImobiliaria,
      docOrdProAutomotiva,
      docRL,
      docFaturaLocacao,
      docCarnePagamento,
      docDuplicata,
      docRB : Result := fConfiguraFilaMIFF;
      docCupomServico,

      docSeparacaoGondola: fConfiguraFilaSeparacao;
      docPD,
      docPR,
      docOR,
      docORExterior,
      docPDExterior : Result := fConfiguraFilaPDOR;

      docSepNota,
      docSepNotaObs,
      docSepSF,
      docSepRomaneio,
      docSepPedido,
      docSepItem: Result := fConfiguraFilaSeparacao;
    End;

    If Result Then
    Begin

      If (strSaida <> 'P') Then
      Begin
        Result := fPreImpressao(qryCfgRel, recDocume.strNomImp, recDocume.strTipImp, False, strSaida);

        {******************************************************************************}
        {* Caso tenha informado a fila de impressao porém a mesma nao foi encontrada  *}
        {* entao nao deve imprimir o documento. Hoje esta imprimindo na impressora    *}
        {* padrao. Existem casos em que uma impressora ficticia foi criada justamente *}
        {* para nao imprimir determinados documentos em algumas filas de impressao    *}
        {* Por exemplo: separacao por setor na Hidromar                               *}
        {**************************************************************************JC**}
        If (Not fEmptyStr(recDocume.strNomImp)) And TCfgRel.VS_blnDlgPri And (strSaida = 'I') And (Not fImpressoraExiste(recDocume.strNomImp)) Then
           Result := False;
      End;

    End;

  End;

  FNomeImpressora := recDocume.strNomImp;
End;

function TEditorFastImpressao.fRetornaQuantidadeItens: Integer;
begin
  Result := 0;

  If (Not Assigned(objLeDocumento)) Then
    Exit;

  If (Not Assigned(objLeDocumento.arrClients)) Then
    Exit;

  If (Length(objLeDocumento.arrClients) <= 0) Then
    Exit;

  If (Not Assigned(objLeDocumento.arrClients[0].cdsDados)) Then
    Exit;

  If (Not objLeDocumento.arrClients[0].cdsDados.Active) Then
    Exit;

  Result := objLeDocumento.arrClients[0].cdsDados.RecordCount;
end;

procedure OnGetTempFileNameDMPExport(Sender: TObject; var AFile: string);
var
  LPath: String;
begin
  LPath := ExtractFilePath(Application.ExeName) + 'temp\';

  if not DirectoryExists(LPath) then
    Exit;

  repeat
    AFile := LPath + Random(100000).ToString() + '.tmp';
  until not FileExists(AFile);
end;

initialization
  frxDMPExport.OnGetTempFileNameDMPExport := OnGetTempFileNameDMPExport;

end.


