{************************************************************}
{* APOS O EVENTO "OnCreate" DEVE SER ATRIBUIDO OS DADOS DO  *}
{* "ClientDataSet" COM AS DUPLICATAS NA VARIAVEL "oleDados" *}
{*********************************************************AN*}
unit untConsDuplicSelec;

interface

uses
  Windows, Classes, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids,
  Uni, DB, UniClientDataSet, DBCtrls, AppEvnts, BitBtnLockedIncrem, Controls,
  Datasnap.DBClient, frxClass, frxExportCSVTestabilidade, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid,System.Variants, cxProgressBar, untGravando, untRcxRecbBaixDocs, untReciboCtr, untReciboCtrMeiaFolha, untFastPrintEditor, dxCore,
  untLiberacao, untMsgLiberacao, untConstantes;//MF: 286456 - 07/06/2023;

type
  TfrmConsDuplicSelec = class(TfrmPai)
    pnlFundo: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    lblValorTotal: TLabel;
    lblQtdeTotal: TLabel;
    lblJurosTotal: TLabel;
    lblDescontoTotal: TLabel;
    dtsConsulta: TDataSource;
    cdsConsulta: TUniClientDataSet;
    lblVendorTotal: TLabel;
    dbgDuplicatas: TcxGrid;
    dbgDuplicatasDBTableView1: TcxGridDBTableView;
    dbgDuplicatasLevel1: TcxGridLevel;
    btnImprimir: TBitBtnLocked;
    procedure FormActivate(Sender: TObject);
    procedure dbgDuplicatasDBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure dbgDuplicatasDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    strTab: String;
    cdsClone: TUniClientDataSet;

    editorFast: TFastPrintFileEditor;
    reciboCtr : TReciboCtr;
    reciboCtrMeiaFolha : TReciboCtrMeiaFolha;

    cdsImpRec : TUniClientDataSet;

    blntemRegLDSelecionado : Boolean;

    objLiberacao : TLiberacao;//MF: 286456 - 07/06/2023

    procedure pCriarColunasGrid;

    function fImprimindoCPTitulos(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fImprimindoRegistrosLD(pgbStatus: TcxProgressBar =  Nil): Boolean;
    Function pVerificaRegistrosEspDiferentesSelecionados(): Boolean;
    function fGetSQlLancLD: String;

    function fImprimeReciboLayout(vltCreditoTroco: Double;
                                  vltTotalRecebido: Double;
                                  strNomFil: String = '';
                                  strTipImp : String = ''): Boolean;

    procedure ImprimeLD(strNumDup, strSeqCon, strCodEmp: String);
    procedure pImprimeReciboLD(strSeqCon, strCodEmp, strNumDup : String);
    procedure IndexaCds;
    function fVerificaReimpressaoCP(cdsTmp: TUniClientDataSet): Boolean;

  public
    { Public declarations }
    blnVisLC : Boolean;
    procedure pMostraDuplicatasSelecionadas(strTabela: String; cdsDuplic: TUniClientDataSet); overload;
    procedure pMostraDuplicatasSelecionadas(strTabela: String; qryDuplic: TUniQuery); overload;
  end;

var
  frmConsDuplicSelec: TfrmConsDuplicSelec;

implementation

uses SysUtils, Graphics, Forms, untFuncoesSimples, untCadPag,
  untImpressaoCPList, untFuncoes;

{$R *.dfm}

procedure TfrmConsDuplicSelec.pCriarColunasGrid;
begin
  With dbgDuplicatas Do
  Begin
    If SameText(strTab, 'CADREC') Then
    Begin
      dbgDuplicatasDBTableView1.CreateColumn;
      dbgDuplicatasDBTableView1.Columns[0].Width := 130;
      dbgDuplicatasDBTableView1.Columns[0].DataBinding.FieldName := 'CTR_NUMDUP';
      dbgDuplicatasDBTableView1.Columns[0].Caption := 'Duplicata';

      dbgDuplicatasDBTableView1.CreateColumn;
      dbgDuplicatasDBTableView1.Columns[1].Width := 51;
      dbgDuplicatasDBTableView1.Columns[1].DataBinding.FieldName := 'CTR_ESPDOC';
      dbgDuplicatasDBTableView1.Columns[1].Caption := 'Espécie';

      dbgDuplicatasDBTableView1.CreateColumn;
      dbgDuplicatasDBTableView1.Columns[2].Width := 250;
      dbgDuplicatasDBTableView1.Columns[2].DataBinding.FieldName := 'CTR_NOMCLI';
      dbgDuplicatasDBTableView1.Columns[2].Caption := 'Cliente';

      dbgDuplicatasDBTableView1.CreateColumn;
      dbgDuplicatasDBTableView1.Columns[3].Width := 55;
      dbgDuplicatasDBTableView1.Columns[3].DataBinding.FieldName := 'CTR_CODEMP';
      dbgDuplicatasDBTableView1.Columns[3].Caption := 'Empresa';

      dbgDuplicatasDBTableView1.CreateColumn;
      dbgDuplicatasDBTableView1.Columns[4].Width := 65;
      dbgDuplicatasDBTableView1.Columns[4].DataBinding.FieldName := 'CTR_DTACAD';
      dbgDuplicatasDBTableView1.Columns[4].Caption := 'Cadastro';

      dbgDuplicatasDBTableView1.CreateColumn;
      dbgDuplicatasDBTableView1.Columns[5].Width := 65;
      dbgDuplicatasDBTableView1.Columns[5].DataBinding.FieldName := 'CTR_DTAVEN';
      dbgDuplicatasDBTableView1.Columns[5].Caption := 'Vencimento';

      dbgDuplicatasDBTableView1.CreateColumn;
      dbgDuplicatasDBTableView1.Columns[6].Width := 70;
      dbgDuplicatasDBTableView1.Columns[6].DataBinding.FieldName := 'CTR_VALDUP';
      dbgDuplicatasDBTableView1.Columns[6].Caption := 'Vr. Original';
      dbgDuplicatasDBTableView1.Columns[6].HeaderAlignmentHorz := taRightJustify;

      dbgDuplicatasDBTableView1.CreateColumn;
      dbgDuplicatasDBTableView1.Columns[7].Width :=80;
      dbgDuplicatasDBTableView1.Columns[7].DataBinding.FieldName := 'CTR_VALCAL';
      dbgDuplicatasDBTableView1.Columns[7].Caption := 'Vr. Corrigido';
      dbgDuplicatasDBTableView1.Columns[7].HeaderAlignmentHorz := taRightJustify;

    End
    Else
    Begin
      dbgDuplicatasDBTableView1.CreateColumn;
      dbgDuplicatasDBTableView1.Columns[0].Width := 110;
      dbgDuplicatasDBTableView1.Columns[0].DataBinding.FieldName := 'NRODUP';
      dbgDuplicatasDBTableView1.Columns[0].Caption := 'Duplicata';

      dbgDuplicatasDBTableView1.CreateColumn;
      dbgDuplicatasDBTableView1.Columns[1].Width := 30;
      dbgDuplicatasDBTableView1.Columns[1].DataBinding.FieldName := 'CTP_CODEMP';
      dbgDuplicatasDBTableView1.Columns[1].Caption := 'Emp';

      dbgDuplicatasDBTableView1.CreateColumn;
      dbgDuplicatasDBTableView1.Columns[2].Width := 180;
      dbgDuplicatasDBTableView1.Columns[2].DataBinding.FieldName := 'FOR_NOMFOR';
      dbgDuplicatasDBTableView1.Columns[2].Caption := 'Fornecedor';

      dbgDuplicatasDBTableView1.CreateColumn;
      dbgDuplicatasDBTableView1.Columns[3].Width := 90;
      dbgDuplicatasDBTableView1.Columns[3].DataBinding.FieldName := 'CTP_DTAVEN';
      dbgDuplicatasDBTableView1.Columns[3].Caption := 'Vencimento';

      dbgDuplicatasDBTableView1.CreateColumn;
      dbgDuplicatasDBTableView1.Columns[4].Width := 59;
      dbgDuplicatasDBTableView1.Columns[4].DataBinding.FieldName := 'CTP_USACHQ';
      dbgDuplicatasDBTableView1.Columns[4].Caption := 'Cheque?';

      dbgDuplicatasDBTableView1.CreateColumn;
      dbgDuplicatasDBTableView1.Columns[5].Width := 65;
      dbgDuplicatasDBTableView1.Columns[5].DataBinding.FieldName := 'CTP_DESSUJ';
      dbgDuplicatasDBTableView1.Columns[5].Caption := 'Desconto';
      dbgDuplicatasDBTableView1.Columns[5].HeaderAlignmentHorz := taRightJustify;

      dbgDuplicatasDBTableView1.CreateColumn;
      dbgDuplicatasDBTableView1.Columns[6].Width := 64;
      dbgDuplicatasDBTableView1.Columns[6].DataBinding.FieldName := 'CTP_JURSUJ';
      dbgDuplicatasDBTableView1.Columns[6].Caption := 'Juros';
      dbgDuplicatasDBTableView1.Columns[6].HeaderAlignmentHorz := taRightJustify;


      If fCfgSis('CTPVND', varBoolean) Then
      Begin
        dbgDuplicatasDBTableView1.CreateColumn;
        dbgDuplicatasDBTableView1.Columns[7].Width := 64;
        dbgDuplicatasDBTableView1.Columns[7].DataBinding.FieldName := 'CTP_VENDOR';
        dbgDuplicatasDBTableView1.Columns[7].Caption := 'Vendor';
        dbgDuplicatasDBTableView1.Columns[7].HeaderAlignmentHorz := taRightJustify;

        dbgDuplicatasDBTableView1.CreateColumn;
        dbgDuplicatasDBTableView1.Columns[8].Width := 95;
        dbgDuplicatasDBTableView1.Columns[8].DataBinding.FieldName := 'TOTDUP';
        dbgDuplicatasDBTableView1.Columns[8].Caption := 'Valor Corrigido';
        dbgDuplicatasDBTableView1.Columns[8].HeaderAlignmentHorz := taRightJustify;
      End
      Else
      Begin
        dbgDuplicatasDBTableView1.CreateColumn;
        dbgDuplicatasDBTableView1.Columns[7].Width := 95;
        dbgDuplicatasDBTableView1.Columns[7].DataBinding.FieldName := 'TOTDUP';
        dbgDuplicatasDBTableView1.Columns[7].Caption := 'Valor Corrigido';
        dbgDuplicatasDBTableView1.Columns[7].HeaderAlignmentHorz := taRightJustify;
      End;
    End;
  End;
end;

procedure TfrmConsDuplicSelec.pMostraDuplicatasSelecionadas(strTabela: String;
  qryDuplic: TUniQuery);
  Var
    cdsTmp: TUniClientDataSet;
begin
  cdsTmp := fCriaClientDatset(qryDuplic, False, Self);
  pMostraDuplicatasSelecionadas(strTabela, cdsTmp);
  FreeAndNil(cdsTmp);
end;

procedure TfrmConsDuplicSelec.pMostraDuplicatasSelecionadas(strTabela: String; cdsDuplic: TUniClientDataSet);
  Var
    fld001: TAggregateField;
    fld002: TAggregateField;
    fld003: TAggregateField;
    fld004: TAggregateField;
begin
  pCriarFormularios(TfrmConsDuplicSelec, frmConsDuplicSelec);
  With frmConsDuplicSelec Do
  Begin
    strTab := strTabela;

    {*************************************}
    {* CRIANDO OS CAMPOS AGGREGATE FIELD *}
    {**********************************AN*}
    fld004 := nil;
    fld003 := nil;
    fld001 := fCriaAggregateField(cdsConsulta, 'FLD001', 'SUM(' + IIF(strTabela = 'CADREC', 'CTR_VALCAL', 'TOTDUP') + ')', '#,##0.00');
    fld002 := fCriaAggregateField(cdsConsulta, 'FLD002', 'SUM(' + IIF(strTabela = 'CADREC', 'CTR_VALDUP', 'CTP_DESSUJ') + ')', '#,##0.00');

    If (strTabela = 'CADPAG') Then
    Begin
      fld003 := fCriaAggregateField(cdsConsulta, 'FLD003', 'SUM(CTP_JURSUJ)', '#,##0.00');
      fld004 := fCriaAggregateField(cdsConsulta, 'FLD004', 'SUM(CTP_VENDOR)', '#,##0.00');
    End;

    With cdsConsulta Do
    Begin
      Try
        {******************************************************}
        {* CARREGANDO OS DADOS DO "ClientDataSet" E FILTRANDO *}
        {* SOMENTE AS DUPLICATAS SELECIONADAS                 *}
        {***************************************************AN*}
        Data := cdsDuplic.Data;

        Filtered := False;
        Filter := 'CT' + Copy(strTabela, 4, 1) + '_MARDES = ''M''';
        Filtered := True;

        If IsEmpty Then
          fMensagem('Informação', 'Não existem duplicatas selecionadas!', ['&OK'])
        Else
        Begin

          If strTabela = 'CADREC' Then
          Begin
            (FieldByName('CTR_VALDUP') As TFloatField).DisplayFormat  := '###,##0.00';
            (FieldByName('CTR_VALCAL') As TFloatField).DisplayFormat := '###,##0.00';
            IndexFieldNames := 'CTR_NUMDUP';
          End
          Else
          Begin
            (FieldByName('CTP_DESSUJ') As TFloatField).DisplayFormat := '###,##0.00';
            (FieldByName('CTP_JURSUJ') As TFloatField).DisplayFormat := '###,##0.00';
            (FieldByName('CTP_VENDOR') As TFloatField).DisplayFormat := '###,##0.00';
            (FieldByName('TOTDUP') As TFloatField).DisplayFormat := '###,##0.00';
            IndexFieldNames := 'NRODUP';
          End;

          AggregatesActive := True;

          {******************************************************}
          {* CARREGANDO OS LABELS COM OS VALORES DOS AGGREGATES *}
          {***************************************************AN*}
          If strTabela = 'CADREC' Then
          Begin
            lblValorTotal.Width := 85;
            lblValorTotal.Left := 680;
            lblValorTotal.Caption := FormatFloat('#,##0.00', fld001.Value);

            lblDescontoTotal.Width := 65;
            lblDescontoTotal.Left := 612;
            lblDescontoTotal.Caption := FormatFloat('#,##0.00', fld002.Value);

            lblJurosTotal.Visible  := False;
            lblVendorTotal.Visible := False;
          End Else
          Begin
            If fCfgSis('CTPVND', varBoolean) Then
            Begin
              lblValorTotal.Width := 95;
              lblValorTotal.Left := 668;
              lblValorTotal.Caption := FormatFloat('#,##0.00', fld001.Value);

              lblDescontoTotal.Width := 64;
              lblDescontoTotal.Left := 481;
              lblDescontoTotal.Caption := FormatFloat('#,##0.00', fld002.Value);

              lblVendorTotal.Width := 65;
              lblVendorTotal.Left := 609;
              lblVendorTotal.Caption := FormatFloat('#,##0.00', fld004.Value);

              lblJurosTotal.Width := 85;
              lblJurosTotal.Left  := 522;
              lblJurosTotal.Caption := FormatFloat('#,##0.00', fld003.Value);
            End
            Else
            Begin
              lblValorTotal.Width := 98;
              lblValorTotal.Left := 602;
              lblValorTotal.Caption := FormatFloat('#,##0.00', fld001.Value);

              lblDescontoTotal.Width := 80;
              lblDescontoTotal.Left := 464;
              lblDescontoTotal.Caption := FormatFloat('#,##0.00', fld002.Value);

              lblJurosTotal.Width := 95;
              lblJurosTotal.Left := 512;
              lblJurosTotal.Caption := FormatFloat('#,##0.00', fld003.Value);

              lblVendorTotal.Visible := False;
             End;

          End;
          lblQtdeTotal.Caption := IntToStr(cdsConsulta.RecordCount);

          If strTab = 'CADPAG' Then
          Begin
             btnImprimir.visible := True;

             cdsClone := TUniClientDataSet.Create(Self);
             pCloneDataSet(cdsClone, cdsDuplic);
          End;

          AggregatesActive := False;
          pCriarColunasGrid;
          frmConsDuplicSelec.ShowModal;

        End;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[TfrmConsDuplicSelec.pMostraDuplicatasSelecionadas]');
      End;
    End;
  End;

  FreeAndNil(frmConsDuplicSelec);
end;

Procedure TfrmConsDuplicSelec.IndexaCds();
  Var
    strIndex: String;
    intCount: Integer;
    strOrdem : String;
    coluna : String;
begin
  inherited;
  {**********************************}
  {* PEGA OS DADOS DA ORDEM DO GRID *}
  {**********************************}
  strIndex := '';
  strOrdem := '';
  For intCount := 0 To dbgDuplicatasDBTableView1.SortedItemCount -1 Do
  Begin
    strIndex := strIndex + dbgDuplicatasDBTableView1.SortedItems[intCount].DataBinding.FilterFieldName;

    coluna := dbgDuplicatasDBTableView1.SortedItems[intCount].DataBinding.FilterFieldName;

    if dbgDuplicatasDBTableView1.SortedItems[intCount].SortOrder = soDescending then
       strOrdem := 'DESC'
    else
       strOrdem := 'ASC';

    If dbgDuplicatasDBTableView1.SortedItemCount -1 > intCount Then
       strIndex := strIndex + ';';
  End;

  If strOrdem = 'DESC' Then
  Begin
     With cdsClone.IndexDefs.AddIndexDef Do
     Begin
        Name    := 'idx_'+strIndex;
        Fields  := coluna;
        Options := [ixDescending];
     End;
  End;

  If strOrdem = 'DESC' Then
     cdsClone.IndexName := 'idx_'+strIndex
  Else
     cdsClone.IndexFieldNames := strIndex;

end;


procedure TfrmConsDuplicSelec.btnImprimirClick(Sender: TObject);
  Var
    frmAguarde: TfrmGravando;
    blnUsaimpLD : Boolean;
begin
  Try
    blnUsaImpLD := false;

    IndexaCds;

    If Assigned(frmImpressaoCPList) Then
    Begin
       If frmImpressaoCPList.blnVisLC Then
       Begin
          blnUsaImpLD := true;
          If pVerificaRegistrosEspDiferentesSelecionados Then
          Begin
             fMensagem('ATENÇÃO!', 'Existem registros selecionados que possuem layouts diferentes para impressão!', ['&O k']);
             Exit;
          End;
       End;
    End;

    pCriarFormularios(TfrmGravando, frmAguarde);
    If (blnUsaImpLD And blntemRegLDSelecionado) Then
       frmAguarde.fExecutarAcao := fImprimindoRegistrosLD
    Else
       frmAguarde.fExecutarAcao := fImprimindoCPTitulos;
    frmAguarde.ShowModal;
    pFreeAndNil(frmAguarde);
  Except
    On E : Exception Do
      pMensagensErro(E.Message, '[TfrmImpressaoCPList.btnConfirmaClick]');
  End;

end;

procedure TfrmConsDuplicSelec.dbgDuplicatasDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
 If (strTab = 'CADPAG') Then
  Begin
   If AViewInfo.Item.Caption = 'Cheque?' Then
    Begin
      If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,dbgDuplicatasDBTableView1.Columns[4].Index]) = 'NÃO' Then
        ACanvas.Font.Color := clRed
      Else
      If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,dbgDuplicatasDBTableView1.Columns[4].Index]) = 'SIM' Then
      Begin
        If AViewInfo.Selected Then
          ACanvas.Font.Color := 13703910
        Else
          ACanvas.Font.Color := 5966692;
      End;
    End;
  End;
end;

procedure TfrmConsDuplicSelec.dbgDuplicatasDBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
 If (Key = VK_Escape) Then
    btnSair.Click;
end;

procedure TfrmConsDuplicSelec.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(dbgDuplicatas);
end;

procedure TfrmConsDuplicSelec.FormCreate(Sender: TObject);
begin
  inherited;
  objLiberacao := TLiberacao.Create; //MF: 286456 - 05/06/2023
end;

procedure TfrmConsDuplicSelec.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
    Case Key Of
      VK_F10 : btnImprimir.Click;
  End;
end;

procedure TfrmConsDuplicSelec.FormShow(Sender: TObject);
begin
  inherited;
  If Assigned(frmImpressaoCPList) Then
     Btnimprimir.visible := True
  Else
     Btnimprimir.visible := False;
end;

//MF: 286456 - 07/06/2023
function TfrmConsDuplicSelec.fVerificaReimpressaoCP(cdsTmp: TUniClientDataSet): Boolean;
Var
  objTabela : TRegistroMsgLiberaTabela;
  objLinha: TLinhaMsgLibera;
  blnReimpressao: Boolean;
begin
  Result := True;

  cdsTmp.First;
  cdsTmp.Filter := 'CTP_MARDES = ' + QuotedStr('M');
  cdsTmp.Filtered := True;

  blnReimpressao := False;

  While not cdsTmp.Eof Do
  Begin
    blnReimpressao := fCPJaImpresso(cdsTmp.FieldByName('NRODUP').AsString,
                                      cdsTmp.FieldByName('CTP_PARCEL').AsString,
                                      cdsTmp.FieldByName('CTP_SERIE_').AsString,
                                      cdsTmp.FieldByName('CTP_CODEMP').AsString,
                                      cdsTmp.FieldByName('CTP_CODFOR').AsString);

    If (blnReimpressao) Then
    Begin
      Break;
    End;

    cdsTmp.Next;
  End;

  if (blnReimpressao) Then
  Begin
    If (Not fVerificaAcessoSistema('RMPCPG', strLoginUsuarioLogado)) Then
    Begin
      objLiberacao.Clear;

      objTabela := TRegistroMsgLiberaTabela.Create;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna(''  , 'DOCUMENTO'       , 17 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'EMP'             , 4  , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'FORNECEDOR'      , 42 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'DT.VENC.'        , 8  , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'DT.CAD.'         , 8  , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'VR.DUPLICATA'    , 13 , alDireita  , teAutcom);
      objTabela.lstLinhas.Add(objLinha);

      cdsTmp.First;
      While not cdsTmp.Eof Do
      Begin
        blnReimpressao := fCPJaImpresso(cdsTmp.FieldByName('NRODUP').AsString,
                                        cdsTmp.FieldByName('CTP_PARCEL').AsString,
                                        cdsTmp.FieldByName('CTP_SERIE_').AsString,
                                        cdsTmp.FieldByName('CTP_CODEMP').AsString,
                                        cdsTmp.FieldByName('CTP_CODFOR').AsString);

        if (blnReimpressao) Then
        Begin
          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlValor;
          objLinha.pAddColuna('DOCUMENTO'       ,  fPadR(cdsTmp.FieldByName('NRODUP').AsString,12)
                                                 + cdsTmp.FieldByName('CTP_PARCEL').AsString + '-'
                                                 + cdsTmp.FieldByName('CTP_SERIE_').AsString                              , 17 , alEsquerda );
          objLinha.pAddColuna('EMP'             ,  cdsTmp.FieldByName('CTP_CODEMP').AsString                              , 4  , alCentro   );
          objLinha.pAddColuna('FORNECEDOR'      ,  cdsTmp.FieldByName('NOMFOR').AsString                                  , 42 , alEsquerda );
          objLinha.pAddColuna('DT.VENC.'        ,  FormatDateTime('dd/mm/yy',cdsTmp.FieldByName('CTP_DTAVEN').AsDateTime) , 8  , alCentro   );
          objLinha.pAddColuna('DT.CAD.'         ,  FormatDateTime('dd/mm/yy',cdsTmp.FieldByName('DTACAD').AsDateTime)     , 8  , alCentro   );
          objLinha.pAddColuna('VR.DUPLICATA'    ,  FloatToStrF(cdsTmp.FieldByName('TOTDUP').AsFloat, ffNumber, 9, 2)      , 13 , alDireita  );
          objTabela.lstLinhas.Add(objLinha);
        End;

        cdsTmp.Next;
      End;

      objLiberacao.objMsgLibera.pAddTexto('Não é permitido reimprimir Comprovante de Pagamento');
      objLiberacao.objMsgLibera.pAddQuebra;
      objLiberacao.objMsgLibera.pAddSeparador(140);
      objLiberacao.objMsgLibera.pAddTexto('TÍTULOS SELECIONADOS JÁ IMPRESSOS:', alCentro, teAmbos, '',140);
      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

      Result := False;

      While (True) Do
      Begin
        objLiberacao.strDirAce              := 'RMPCPG';
        objLiberacao.strMsgSen              := 'Reimprimir Comprovante de Pagamento';
        objLiberacao.strSenLib              := fCfgSis('SENFVU');
        objLiberacao.tipCliFor              := cfFornecedor;
        objLiberacao.blnMosMen              := True;
        objLiberacao.strCodOpe              := strLoginUsuarioLogado;
        objLiberacao.strCodDig              := strLoginUsuarioLogado;
        objLiberacao.objMsgLibera.strTitulo := 'Não é permitido reimprimir Comprovante de Pagamento';

        If (objLiberacao.fLibera) Then
        Begin
          Result := True;
          Break;
        End;

        If (fMensagem('', 'Senha Incorreta!', ['&Novamente', '&Desistir']) = 2) Then
          Break;
      End;
      pRemoveLiberacao('RMPCPG','');
    End;

  End;
end;

function TfrmConsDuplicSelec.fImprimindoCPTitulos(
  pgbStatus: TcxProgressBar): Boolean;
begin
  Result := True;

  pInformacao('Aguarde... Imprimindo CPs dos Títulos.', pgbStatus);

  cdsClone.Filtered := False;
  cdsClone.Filter   := 'CTP_MARDES = ' + QuotedStr('M');
  cdsClone.Filtered := True;

  If Not cdsClone.IsEmpty Then
  Begin
    //MF: 286456 - 07/06/2023 - INI
    if (Not fVerificaReimpressaoCP(cdsClone)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é permitido reimprimir Comprovante de Pagamento!', ['&Ok']);
      Exit;
    End;
    //MF: 286456 - 07/06/2023 - FIM

    pProgresso(0, cdsClone.RecordCount, pgbStatus);

    With cdsClone Do
    Begin
      First;

      While Not Eof Do
      Begin
        ImprimeCP(FieldByName('NRODUP').AsString,
                  FieldByName('CTP_PARCEL').AsString,
                  FieldByName('CTP_CODEMP').AsString,
                  FieldByName('CTP_CODFOR').AsString,
                  FieldByName('CTP_SERIE_').AsString,
                  'frmConsDuplicSelec',//MF: 286456 - 07/06/2023
                  True,
                  False);

        pProgresso(RecNo, RecordCount, pgbStatus);
        Next;
      End;
    End;

    pEfetuaImpressao(True, '', True);
    FreeAndNil(cdsClone);

    fMensagem('ATENÇÃO!', 'CPs dos títulos impressos com sucesso!', ['&O k']);
    Close;
  End
  Else
    fMensagem('ATENÇÃO!', 'Marque pelo menos um título para realizar a impressão do CP!', ['&O k']);
end;

function TfrmConsDuplicSelec.fImprimindoRegistrosLD(pgbStatus: TcxProgressBar): Boolean;
begin
  Result := True;

  pInformacao('Aguarde... Imprimindo Registros.', pgbStatus);

  cdsClone.Filtered := False;
  cdsClone.Filter   := 'CTP_MARDES = ' + QuotedStr('M');
  cdsClone.Filtered := True;

  If Not cdsClone.IsEmpty Then
  Begin
    pProgresso(0, cdsClone.RecordCount, pgbStatus);

    With cdsClone Do
    Begin
      First;

      While Not Eof Do
      Begin
        ImprimeLD(FieldByName('CTP_NUMDUP').AsString,
                  FieldByName('SEQCON').AsString,
                  FieldByName('CTP_CODEMP').AsString);

        pProgresso(RecNo, RecordCount, pgbStatus);
        Next;
      End;
    End;

    FreeAndNil(cdsClone);

    fMensagem('ATENÇÃO!', 'Registros impressos com sucesso!', ['&O k']);
    Close;
  End
  Else
    fMensagem('ATENÇÃO!', 'Marque pelo menos um título para realizar a impressão!', ['&O k']);
end;

procedure TfrmConsDuplicSelec.ImprimeLD(strNumDup, strSeqCon, strCodEmp: String);
begin
  Try
    pImprimeReciboLD(strSeqCon,
                     strCodEmp,
                     strNumDup);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'Erro ao gerar impressão de LD !','[ImprimeLD]');
    End;
  End;
end;

function TfrmConsDuplicSelec.fGetSQlLancLD: String;
  Var
    strSQL: String;
begin
    strSQL := '';
    strSQL := strSQL + ' SELECT SQL_NO_CACHE           ';
    strSQL := strSQL + '  RCX_NUMDOC AS NUMDOC,        ';
    strSQL := strSQL + '  RCX_ESPDOC AS ESPDOC,        ';
    strSQL := strSQL + '  RCX_PARCEL AS PARCEL,        ';
    strSQL := strSQL + '  RCX_CODEMP AS CODEMP,        ';
    strSQL := strSQL + '  RCX_DESCRI AS HIST01,        ';
    strSQL := strSQL + '  NULL AS HIST02,              ';
    strSQL := strSQL + '  RCX_DTACAD AS DTACAD,        ';
    strSQL := strSQL + '  RCX_DTACAD AS DTAVEN,        ';
    strSQL := strSQL + '  RCX_DTACAD AS DTAREC,        ';
    strSQL := strSQL + '  CURRENT_TIME AS HORREC,      ';
    strSQL := strSQL + '  RCX_DESCRI AS DESCRI,        ';
    strSQL := strSQL + '  NULL AS CODCTA,              ';
    strSQL := strSQL + '  NULL AS DESCTA,              ';
    strSQL := strSQL + '  (                            ';
    strSQL := strSQL + '    IFNULL(RCX_VALDOC, 0)      ';
    strSQL := strSQL + '  ) * (-1) AS VALDOC,          ';
    strSQL := strSQL + '  RCX_VALDOC * (-1) AS VALORI, ';
    strSQL := strSQL + '  RCX_VALDOC * (-1) AS VALREC, ';
    strSQL := strSQL + '  0.00 AS VALDES,              ';
    strSQL := strSQL + '  0.00 AS VALJUR,              ';
    strSQL := strSQL + '  0.00 AS VALCOB,              ';
    strSQL := strSQL + '  0.00 AS DESCOB,              ';
    strSQL := strSQL + '  NULL AS CODCLI,              ';
    strSQL := strSQL + '  NULL AS NOSNUM,              ';
    strSQL := strSQL + '  RCX_SEQCON AS SEQCON,        ';
    strSQL := strSQL + '  RCX_CODOPE AS CODVEN,        ';
    strSQL := strSQL + '  NULL AS NOMCLI,              ';
    strSQL := strSQL + '  NULL AS ENDERE,              ';
    strSQL := strSQL + '  NULL AS BAIRRO,              ';
    strSQL := strSQL + '  NULL AS CIDADE,              ';
    strSQL := strSQL + '  NULL AS ESTADO,              ';
    strSQL := strSQL + '  NULL AS C_E_P_,              ';
    strSQL := strSQL + '  NULL AS C_G_C_,              ';
    strSQL := strSQL + '  NULL AS FONE01,              ';
    strSQL := strSQL + '  NULL AS F_A_X_,              ';
    strSQL := strSQL + '  NULL AS ENDNUM,              ';
    strSQL := strSQL + '  1 AS RESCAI,                 ';
    strSQL := strSQL + '  RCX_SEQCON AS CTR_SEQBAI,    ';
    strSQL := strSQL + '  RCX_CODEMP AS CTR_EMPBAI,    ';
    strSQL := strSQL + '  RCX_NUMDOC AS CTR_NUMDUP,    ';
    strSQL := strSQL + '  RCX_DESCRI AS CTR_HIST01,    ';
    strSQL := strSQL + '  NULL AS CTR_HIST02,          ';
    strSQL := strSQL + '  RCX_PARCEL AS CTR_PARCEL,    ';
    strSQL := strSQL + '  RCX_DTACAD AS CTR_DTAVEN,    ';
    strSQL := strSQL + '  RCX_VALDOC *(-1) AS CTR_VALDUP, ';
    strSQL := strSQL + '  RCX_DTACAD AS CTR_DTACAD,    ';
    strSQL := strSQL + '  RCX_ESPDOC AS CTR_ESPDOC,    ';
    strSQL := strSQL + '  RCX_CODEMP AS CTR_CODEMP,    ';
    strSQL := strSQL + '  RCX_VALDOC *(-1) AS CTR_VALREC, ';
    strSQL := strSQL + '  0.00 AS CTR_VALDES,          ';
    strSQL := strSQL + '  0.00 AS CTR_VALJUR,          ';
    strSQL := strSQL + '  NULL AS CTR_CODCLI,          ';
    strSQL := strSQL + '  NULL AS CTR_NOSNUM,          ';
    strSQL := strSQL + '  NULL AS CLI_NOMCLI,          ';
    strSQL := strSQL + '  NULL AS CLI_FONE01,          ';
    strSQL := strSQL + '  NULL AS CLI_F_A_X_,          ';
    strSQL := strSQL + '  RCX_SEQCON AS CTR_SEQCON,    ';
    strSQL := strSQL + '  RCX_DINREC *(-1) AS CTR_DINHEI, ';
    strSQL := strSQL + '  RCX_CHQAVI *(-1) AS CTR_CHQAVI, ';
    strSQL := strSQL + '  RCX_CHQPRE *(-1) AS CTR_CHQPRE, ';
    strSQL := strSQL + '  RCX_CARREC *(-1) AS CTR_CARTAO, ';
    strSQL := strSQL + '  RCX_ORDREC *(-1) AS CTR_ORDPAG, ';
    strSQL := strSQL + '  RCX_VALCRE AS CTR_CREDITO,   ';
    strSQL := strSQL + '  "D" AS CTR_MARDES,           ';
    strSQL := strSQL + '  0.00 AS CTR_JURSUJ,          ';
    strSQL := strSQL + '  0.00 AS CTR_DESSUJ,          ';
    strSQL := strSQL + '  RCX_CODOPE AS OPEBAI,        ';
    strSQL := strSQL + '  NULL AS CTR_PORBAI,          ';
    strSQL := strSQL + '  NULL AS RCX_CAIXA,           ';
    strSQL := strSQL + '  1 AS RESCAI,                 ';
    strSQL := strSQL + '  RCX_RECPIX AS RECPIX         ';
    strSQL := strSQL + 'FROM CADRCXX                   ';
    strSQL := strSQL + '  WHERE                        ';
    strSQL := strSQL + '     RCX_ESPDOC = "LD"         ';
    strSQL := strSQL + ' AND RCX_SEQCON = :SEQCON      ';
    strSQL := strSQL + ' AND RCX_CODEMP = :SEQEMP      ';
    strSQL := strSQL + ' AND RCX_NUMDOC = :NUMDOC      ';

    Result := strSQL;
End;

procedure TfrmConsDuplicSelec.pImprimeReciboLD(strSeqCon, strCodEmp, strNumDup : String);
Var
    strSQL      : String;
    strRecRcx   : String;
    strDescri   : String;
    strNomPro   : String;
    strNomFil   : String;
    strTipImp   : String;
    blnImprimiu : Boolean;
    recValRec   : TRcxValoresReceb;
    arrCodCli   : Array Of TRcxDadosCliente;
    cdsChqVis   : TUniClientDataSet;
    cdsChqPre   : TUniClientDataSet;
    qryAuxImp   : TUniQuery;
    dblDinRec,
    dblCarRec,
    dblChqPre,
    dblChqVis,
    dblOrdRec,
    dblCreRec   : Double;
Begin

  Try
    //If intOpcao = 1 Then
    //   strRecRcx := 'L';
    //Else
    //   strRecRcx := fCfgSis('RECRCX');

    strRecRcx := 'L'; //Considerando a forma como está as impressoes de recibos no caixa;

    cdsChqVis := fCriaCdsCheques(Self);
    cdsChqPre := fCriaCdsCheques(Self);
    cdsImpRec := fCriaClientDatasetReciboCTR;

    If Not cdsImpRec.Active Then
       cdsImpRec.Open;

    cdsImpRec.EmptyDataSet;
    cdsImpRec.Filter   := '';
    cdsImpRec.Filtered := False;

    SetLength(arrCodCli, 0);

    dblDinRec := 0;
    dblCarRec := 0;
    dblChqPre := 0;
    dblChqVis := 0;
    dblOrdRec := 0;
    dblCreRec := 0;

    qryAuxImp := fCriaQuery(Nil);

    With cdsImpRec Do
    Begin

        strSQL := '';
        strSQL := fGetSQlLancLD();

        With qryAuxImp Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('SEQCON').AsString := strSeqCon;
          ParamByName('SEQEMP').AsString := strCodEmp;
          ParamByName('NUMDOC').AsString := strNumDup;
          Open;
        End;

        Insert;

        FieldByName('CODCLI').AsString     := qryAuxImp.FieldByName('CODCLI').AsString;
        FieldByName('ESTADO').AsString     := qryAuxImp.FieldByName('ESTADO').AsString;
        FieldByName('DESCRI').AsString     := qryAuxImp.FieldByName('DESCRI').AsString;
        FieldByName('NOMCLI').AsString     := qryAuxImp.FieldByName('NOMCLI').AsString;
        FieldByName('FANSOB').AsString     := '';
        FieldByName('ENDERE').AsString     := qryAuxImp.FieldByName('ENDERE').AsString;
        FieldByName('ENDNUM').AsString     := qryAuxImp.FieldByName('ENDNUM').AsString;
        FieldByName('ENDCMP').AsString     := '';
        FieldByName('BAIRRO').AsString     := qryAuxImp.FieldByName('BAIRRO').AsString;
        FieldByName('C_E_P_').AsString     := qryAuxImp.FieldByName('C_E_P_').AsString;
        FieldByName('CIDADE').AsString     := qryAuxImp.FieldByName('CIDADE').AsString;
        FieldByName('C_G_C_').AsString     := qryAuxImp.FieldByName('C_G_C_').AsString;
        FieldByName('FONE01').AsString     := qryAuxImp.FieldByName('FONE01').AsString;
        FieldByName('SEQCON').AsString     := qryAuxImp.FieldByName('SEQCON').AsString;
        FieldByName('NUMDOC').AsString     := qryAuxImp.FieldByName('NUMDOC').AsString;
        FieldByName('ESPDOC').AsString     := qryAuxImp.FieldByName('ESPDOC').AsString;
        FieldByName('PARCEL').AsString     := qryAuxImp.FieldByName('PARCEL').AsString;
        FieldByName('CODEMP').AsString     := qryAuxImp.FieldByName('CODEMP').AsString;
        FieldByName('DTACAD').AsDateTime   := qryAuxImp.FieldByName('DTACAD').AsDateTime;
        FieldByName('DTAVEN').AsDateTime   := qryAuxImp.FieldByName('DTAVEN').AsDateTime;
        FieldByName('DTAREC').AsDateTime   := qryAuxImp.FieldByName('DTAREC').AsDateTime;
        FieldByName('HORREC').AsDateTime   := qryAuxImp.FieldByName('HORREC').AsDateTime;
        FieldByName('CODVEN').AsString     := qryAuxImp.FieldByName('CODVEN').AsString;
        FieldByName('VALJUR').AsFloat      := qryAuxImp.FieldByName('VALJUR').AsFloat;
        FieldByName('VALDES').AsFloat      := qryAuxImp.FieldByName('VALDES').AsFloat;
        FieldByName('VALDOC').AsFloat      := qryAuxImp.FieldByName('VALDOC').AsFloat;
        FieldByName('VALREC').AsFloat      := qryAuxImp.FieldByName('VALREC').AsFloat;
        FieldByName('VALORI').AsFloat      := qryAuxImp.FieldByName('VALORI').AsFloat;
        FieldByName('CODCTA').AsString     := qryAuxImp.FieldByName('CODCTA').AsString;
        FieldByName('DESCTA').AsString     := qryAuxImp.FieldByName('DESCTA').AsString;
        FieldByName('RCX_DESCRI').AsString := qryAuxImp.FieldByName('DESCRI').AsString;
        FieldByName('RCX_CAIXA').AsString  := qryAuxImp.FieldByName('RCX_CAIXA').AsString;
        FieldByName('RESCAI').AsString     := qryAuxImp.FieldByName('RESCAI').AsString;
        FieldByName('NOMCTA').AsString     := '';//strCta_Pg + ' - ' + fRetDescCentroCusto(strCta_Pg);
        FieldByName('NOMEVE').AsString     := '';//strCodEve + ' - ' + fRetNomEvento(strCodEve);
        FieldByName('OPEBAI').AsString     := qryAuxImp.FieldByName('OPEBAI').AsString;
        FieldByName('RECPIX').AsString     := qryAuxImp.FieldByName('RECPIX').AsString;

        dblDinRec := dblDinRec + qryAuxImp.FieldByName('CTR_DINHEI').AsFloat;
        dblCarRec := dblCarRec + qryAuxImp.FieldByName('CTR_CARTAO').AsFloat;
        dblChqPre := dblChqPre + qryAuxImp.FieldByName('CTR_CHQPRE').AsFloat;
        dblChqVis := dblChqVis + qryAuxImp.FieldByName('CTR_CHQAVI').AsFloat;
        dblOrdRec := dblOrdRec + qryAuxImp.FieldByName('CTR_ORDPAG').AsFloat;
        dblCreRec := dblCreRec + IIF(qryAuxImp.FieldByName('CTR_CREDITO').AsFloat < 0, qryAuxImp.FieldByName('CTR_CREDITO').AsFloat, 0);
        Post;

    End;

    With cdsImpRec Do
    Begin

      If Not IsEmpty Then
      Begin

        pCarregaConfImpr(qryCfgRel, 'frmRcxResumoCaixa_LC');
        If qryCfgRel.IsEmpty Then
          pCarregaConfImpr(qryCfgRel, 'frmRcxResumoCaixa');

        fPreImpressao(qryCfgRel, strNomFil, strTipImp, False);

        strNomPro := qryCfgRel.FieldByName('REL_NOMPRO').AsString;

        If fEmptyStr(strNomPro) Then
           strNomPro := 'frmRcxResumoCaixa';

        {**************************************************}
        {* IMPRESSAO DO RECIBO CUSTOMIZADO DO FAST REPORT *}
        {***********************************************JU*}
        blnImprimiu := fImprimeReciboLayout(0,
                                            0,
                                            strNomFil,
                                            strTipImp);

        If Not blnImprimiu Then
        Begin
            Edit;
            FieldByName('DESCRI').AsString := strDescri;
            Post;

            recValRec.strDinRec := FloatToStrF(dblDinRec, ffFixed, 12, 2);
            recValRec.strCarRec := FloatToStrF(dblCarRec, ffFixed, 12, 2);
            recValRec.strChqPre := FloatToStrF(dblChqPre, ffFixed, 12, 2);
            recValRec.strChqVis := FloatToStrF(dblChqVis, ffFixed, 12, 2);
            recValRec.strOrdRec := FloatToStrF(dblOrdRec, ffFixed, 12, 2);
            recValRec.strCreRec := FloatToStrF(dblCreRec, ffFixed, 12, 2);

            blnCalculaTotais := False;  //mudar isso na refatoração dos recibos

            pImpRecBaiDoc(cdsImpRec,
                          strRecRcx,
                          FieldByName('SEQCON').AsInteger,
                          FieldByName('OPEBAI').AsString,
                          arrCodCli,
                          recValRec,
                          cdsChqPre,
                          cdsChqVis,
                          strNomPro,
                          strNomFil,
                          strTipImp,
                          (fCfgSis('RECRCX') = 'B'),
                          FieldByName('ESPDOC').AsString,
                          FieldByName('CODCTA').AsString,
                          '',
                          (FieldByName('RESCAI').AsInteger = 1));

        End;
      End;

    End;

    cdsImpRec.EmptyDataSet;
  Except
    On E: Exception Do
       pMensagensErro(E.Message, '[FrmImpressaoCPList.pImprimeReciboLD]');
  End;

End;

Function TfrmConsDuplicSelec.pVerificaRegistrosEspDiferentesSelecionados(): Boolean;
  Var
    cdsVer: TUniClientDataSet;
    blnTemLD,
    blnTemOutras : Boolean;
begin
  blnTemLD     := False;
  blnTemOutras := False;

  blntemRegLDSelecionado := False;

  Try
    cdsVer := TUniClientDataSet.Create(Self);
    pCloneDataSet(cdsVer, cdsClone);

    cdsVer.Filtered := False;
    cdsVer.Filter   := 'CTP_MARDES = ' + QuotedStr('M') + ' AND ESPDOC = ' + QuotedStr('LD');
    cdsVer.Filtered := True;

    If Not cdsVer.IsEmpty Then
    Begin
       blnTemLD := True;
       blntemRegLDSelecionado := True;
    End;

    cdsVer.Filtered := False;
    cdsVer.Filter   := 'CTP_MARDES = ' + QuotedStr('M') + ' AND ESPDOC <> ' + QuotedStr('LD');
    cdsVer.Filtered := True;

    If Not cdsVer.IsEmpty Then
       blnTemOutras := True;

    Result := (blnTemLD And blnTemOutras);
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'Erro ao verificar registros selecionados !','[pVerificaRegistrosEspDiferentesSelecionados]');
    End;
  End;

End;

{**************************************************}
{* IMPRESSAO DO RECIBO CUSTOMIZADO DO FAST REPORT *}
{**************************************************}
function TfrmConsDuplicSelec.fImprimeReciboLayout(vltCreditoTroco: Double;
                                                  vltTotalRecebido: Double;
                                                  strNomFil : String = '';
                                                  strTipImp : String = ''): Boolean;
begin

  editorFast := TFastPrintFileEditor.Create(Nil);

  If fCfgSis('RECCTR') = 'N' Then
  begin
    reciboCtr  := TReciboCtr.CreateInstance(cdsImpRec, vltCreditoTroco, vltTotalRecebido,Nil, True);
    editorFast.pSetFastPrintFile(reciboCtr);
    reciboCtr.pSetFastType(strTipImp);
  end
  else
  begin
    reciboCtrMeiaFolha  := TReciboCtrMeiaFolha.CreateInstance(cdsImpRec);
    editorFast.pSetFastPrintFile(reciboCtrMeiaFolha);
  end;

  //Abrindo impressora selecionada no autcom
  if strNomFil <> '' Then
     editorFast.pSelectFil(Self.Name, strNomFil, fRetNomeRede);

  Result := False;

  editorFast.intNumeroVias := fCfgSis('VIASLD', varInteger);

  If editorFast.fLoadReport Then
  Begin
     Result := True;

     If Not cdsImpRec.IsEmpty Then
        editorFast.pPrint;

  End;

  FreeAndNil(editorFast);
end;

end.
