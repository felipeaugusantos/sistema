unit untAltPrecoGlobalItens;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Grids, DBGridCitel, DBGrids, ComCtrls,
  Buttons, ExtCtrls, untfuncoesSimples, DB, StrUtils, Menus, Uni, AppEvnts,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, cxProgressBar,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, untMsgLiberacao, untILiberacao, untLiberacaoFactory,
  untGravando, cxGridTableView, cxGridDBTableView, cxGrid, cxCheckBox, Messages, untTCalculaVariacaoPreco,
  untZClient, Datasnap.DBClient,
  untPreAlt_Trigger, untTAvisoAlteracaoPreco;

const
  WM_MESSAGESELECIONAITEM = WM_USER + 8839;


type
  TfrmAltPrecoGlobalItens = class(TfrmPaiSimples)
    pnlBotoesEnt: TPanel;
    pgbProgresso: TProgressBar;
    dtsItens: TDataSource;
    btnConfirma: TBitBtnLocked;
    btnMarTod: TBitBtnLocked;
    btnDesTod: TBitBtnLocked;
    btnVoltar: TBitBtnLocked;
    cxgItens: TcxGrid;
    cxvItens: TcxGridDBTableView;
    cxgItensLevel1: TcxGridLevel;
    cxStyleRepository1: TcxStyleRepository;
    cxsMoney: TcxStyle;
    Panel1: TPanel;
    lblLegendaAzul: TLabel;
    lblMarBrNegativa: TLabel;
    lblAvisoAtivo: TLabel;
    cxsBlue: TcxStyle;
    cxStyle1: TcxStyle;
    cxvItensMarcado: TcxGridDBColumn;
    lblPreVenNegativo: TLabel;
    cxBlackBold: TcxStyle;
    procedure FormShow(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxvItensCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxvItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxvItensCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure btnMarTodClick(Sender: TObject);
    procedure btnDesTodClick(Sender: TObject);
    procedure cxvItensCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure cxvItensStylesGetContentStyle(Sender: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
      var AStyle: TcxStyle);
    procedure cxvItensDataControllerSortingChanged(Sender: TObject);
    procedure cxvItensDataControllerFilterChanged(Sender: TObject);
  private
    { Private declarations }
    lstProdutosAux: TStringList;
    qryGenExt: TDataSet;
    strTIPABF: String;
    dtaDtaAlt: TDate;
    blnPorDta: Boolean;
    qryGenIte,
    qryPreAlt: TUniQuery;
    strNomTab: String;
    strCodTabDin: String;
    intSitPro: Integer;

    frmGravando: TfrmGravando;

    cdsEmpresasUsamPrecoMatriz: TZClient;

    objAvisoAlteracaoPreco: TAvisoAlteracaoPreco;

    blnMarcar: Boolean;
    qryIteCom: TUniQuery;

    objLiberacao : ILiberacao;
    blnValidaCustoReal: Boolean;
    blnValidaPrevenMargem: Boolean;


    Function fTemItemParaAlterar: Boolean;
    Function fTemItemParaAlterarPrg(cxProgressBar: TcxProgressBar): Boolean;

    Function fGetEmpresasUsamPrecoMatriz(strCodEmp: String): String;

    Function fAtualizaTabela(cxProgressBar: TcxProgressBar): Boolean;
    procedure pAtualizaTabela;
    procedure pMarcaItem(blnMarcar: Boolean);
    procedure pSelecionaItem;
    procedure pAdicionaColuna(strTitulo, strCampo: String; blnVisible: Boolean = True; blnGroupBy: Boolean = False);

    function fConfirmaItens: Boolean;
    function fConfirmaItensAux(pgbProgresso2: TcxProgressBar): Boolean;
    Function fConfirmaData: Boolean;
    Function fTemCampoPreco: Boolean;
    procedure pWMMessageSelecionaItem(var Message: TMessage); Message WM_MESSAGESELECIONAITEM;

    procedure pDeletaAtualizaTabPre(blnDeleta : Boolean);

    Function fMarcaTodos(cxProgresso: TcxProgressBar): Boolean;
    procedure pGravarLogCpr(const DataSetGrid: TDataSet; qryLogCpr: TUniQuery);
    procedure pGravaIteCom(strCodIte, strTabPre, strNomCam: String;
      fltPerCom: Double);
    function fPedeLiberacaoPrecoCustoReal: boolean;
    procedure pCampoDescricao(Sender: TField; var Text: string;
      DisplayText: Boolean);
    function fIndiceCampo(strCampo: String): Integer;
    procedure pSetaTexto;
    function fRetDesAbfPisCofIpi(strTabela, strCod: String): String;
    Function fValidaPrecoCustoRealAux(cxProgressBar: TcxProgressBar): Boolean;

    function fRetSQLUpdateCampoDetCus(AFieldName: String; strFiledNameNovo: String): String;
    procedure pGravaMontadoras(strCodIte, strListaMontadoras: String; qryComand: TUniQuery);

    function fValidaPrecoCustoRealPrg(pgbProgresso: TcxProgressBar): boolean;

    function fExistePrecoPautaFiscal: Boolean;
    procedure pDeletaPrecoPautaFiscal(strCodIte: String);
    procedure pCadastraPrecoPautaFiscal(strCodIte: String);
  public
    { Public declarations }
    cdsPrecoPautaFiscal: TClientDataSet;
    arrCamposGrid: TArrCampoGlobal;

    blnGeral: Boolean;
    blnConfirma: Boolean;
    blnExiSal  : Boolean;
    blnAltFornecedor: Boolean;
    blnTemMargemBrutaNegativa: Boolean;
    blnTemPrecoVendaNegativo: Boolean;
    blnTabPrd : Boolean;
    strCodTab  : String;
    blnTrataTPO: Boolean;
    blnMostrarColunaPRECUS: Boolean;
  end;

var
  frmAltPrecoGlobalItens: TfrmAltPrecoGlobalItens;

implementation

uses  untAltPrecoDigData, untPreAlt, untProdMargemNegativa,
      UniClientDataSet, dxCore,
      untAltEst, untFuncoesAuxiliares, untAltDes, untTPontoExposicao;

{$R *.dfm}

{ TfrmAltPrecoGlobalItens }

Const
  STRCAMNOV = 'ITE_PRECUS_' +
              'ITE_PREVE1_ITE_PREVE2_ITE_PREVE3_ITE_PREVE4_ITE_PREVE5_ITE_PREVE6_ITE_PREVE7_' +
              'ITE_MARBR1_ITE_MARBR2_ITE_MARBR3_ITE_MARBR4_ITE_MARBR5_ITE_MARBR6_ITE_MARBR7_';

procedure TfrmAltPrecoGlobalItens.pAdicionaColuna(strTitulo, strCampo: String; blnVisible: Boolean = True; blnGroupBy: Boolean = False);
  Var
    cxItem: TcxCustomGridTableItem;
Begin
  cxItem := cxvItens.FindItemByName(strCampo);

  If Not Assigned(cxItem) Then
  Begin
    cxItem := cxvItens.DataController.CreateItemByField(TUniClientDataSet(dtsItens.DataSet).FieldByName(strCampo));
    cxItem.Name    := strCampo;
    cxItem.Caption := strTitulo;


    If SameText('ITE_DESITE', strCampo) Then
      TcxGridDBColumn(cxItem).SortOrder := soAscending;
  End;

  cxItem.Visible := blnVisible;
  If (Pos('ITE_PRECUS',  strCampo) > 0) And cxItem.Visible Then
    blnValidaCustoReal := True;

  If ((Pos('ITE_PREVE',  strCampo) > 0) Or
      (Pos('ITE_MARBR',  strCampo) > 0)) And cxItem.Visible Then
    blnValidaPrevenMargem := True;

  If blnGroupBy Then
  Begin
    TcxGridDBColumn(cxItem).GroupIndex := 0;
    cxItem.Visible := False;
  End;

End;

procedure TfrmAltPrecoGlobalItens.pAtualizaTabela;
Begin
  TfrmGravando.fExecuta(fAtualizaTabela, frmGravando, 'Carregando dados, aguarde...', True, True);
End;

Function TfrmAltPrecoGlobalItens.fAtualizaTabela(cxProgressBar: TcxProgressBar): Boolean;
  Var
    intContador: Integer;
    intTamMat: Integer;
    fldCampo: TField;
    fldCampoNovo: TField;
begin

     { Ao adicionar uma coluna aqui,                                                                                                        }
     { Verificar se não irá gerar erro pela rotina 'Alteração Geral de Preços de Produtos Para Lojas (mnuAlteracaoGeraldePrecosdeProdutos)' }
     {  untAlteracaoGeraldePrecosdeProdutos                                                                                                 }

  dtsItens.DataSet.DisableControls;
  If blnGeral Then
    pAdicionaColuna('Empresa', 'ITE_CODEMP');

  pAdicionaColuna('Grupo',  'ITE_CODGRU');

  If (Not blnGeral)And (Not blnTrataTPO) Then
    pAdicionaColuna('Embalagem?',  'ITE_POSEMB');

  pAdicionaColuna('Código', 'ITE_CODITE', True, blnGeral);
  pAdicionaColuna('Descrição', 'ITE_DESITE');

  If blnTrataTPO Then
    pAdicionaColuna('Preço de custo', 'ITE_PRECUS', blnMostrarColunaPRECUS);

  If Not(blnGeral) And (Not blnTrataTPO) Then
    pAdicionaColuna('Cod. Fabrica', 'ITE_CODFAB');


  If Not(blnGeral)And (Not blnTrataTPO) Then
  Begin
    pAdicionaColuna('Unid. Med.', 'SIGUNI');
    pAdicionaColuna('Cod. Marca', 'ITE_CODMAR');
  End;

  pAdicionaColuna('', 'ITE_MARDES', False);

  If blnExiSal Then
    pAdicionaColuna('Saldo', 'ITE_SALDOS');

  intTamMat := Length(arrCamposGrid);

  cxProgressBar.Properties.Max := intTamMat * 2;

  For intContador := 0 To intTamMat -1 Do
  Begin
    If (Not fEmptyStr(arrCamposGrid[intContador].strNomCam)) And
       (Not (
       ((Pos('ITE_PREVE', arrCamposGrid[intContador].strNomCam) > 0) Or
        (Pos('ITE_COMTB', arrCamposGrid[intContador].strNomCam) > 0) Or
        (Pos('ITE_MARBR', arrCamposGrid[intContador].strNomCam) > 0)) And
       (VS_strTabPrc[StrToIntDef(RightStr(arrCamposGrid[intContador].strNomCam, 1), 0)] <> 'S'))) Then
    Begin
      pAdicionaColuna(arrCamposGrid[intContador].strDesAbr, arrCamposGrid[intContador].strNomCam);
      pAdicionaColuna(arrCamposGrid[intContador].strDesAbr + '(NOVO)', arrCamposGrid[intContador].strNomCam + '_NOV');
    End;

    cxProgressBar.Position := cxProgressBar.Position + 1;
    Application.ProcessMessages;
  End;

  With dtsItens.DataSet Do
  Begin

    First;

    For intContador := 0 To intTamMat-1 Do
    Begin

      If not fEmptyStr(arrCamposGrid[intContador].strDesAbr) Then
      Begin

        fldCampo     := FieldByName(arrCamposGrid[intContador].strNomCam);
        fldCampoNovo := FieldByName(arrCamposGrid[intContador].strNomCam + '_NOV');

        If (Not (fldCampo.DataType In [ftString, ftMemo])) And
           (fldCampo.DataType <> ftDate)   Then
        Begin

          If (Not fEmptyStr(arrCamposGrid[intContador].strMasCam)) Then
          Begin
            If (fldCampo.DataType = ftFloat) Then
            Begin
              (fldCampo As TFloatField).DisplayFormat     := arrCamposGrid[intContador].strMasCam;
              (fldCampoNovo As TFloatField).DisplayFormat := arrCamposGrid[intContador].strMasCam;
            End;
          End;

        End;

      End;

      cxProgressBar.Position := cxProgressBar.Position + 1;
      Application.ProcessMessages;
    End;
  End;

  If (blnTrataTPO) And (Assigned(dtsItens.DataSet.FindField('ITE_PRECUS'))) Then
    TFloatField(dtsItens.DataSet.FieldByName('ITE_PRECUS')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));

  pSetaTexto;
  frmGravando.lblGravando.Caption := 'Ajustando grid, aguarde...';
  Application.ProcessMessages;
  dtsItens.DataSet.EnableControls;
  cxvItens.ApplyBestFit;
  Result := True;
end;

procedure TfrmAltPrecoGlobalItens.pDeletaAtualizaTabPre(blnDeleta : Boolean);
  Var
    qryDelete : TUniQuery;
begin
  If fEmptyStr(strCodTab) Then
    Exit;

  Try
    qryDelete := fCriaQuery(Self);
    With qryDelete, SQL Do
    Begin
      if blnDeleta Then
      Begin
        Clear;
        Add(' SELECT * FROM TABPRE WHERE TAB_CODTAB = :CODTAB ');
        ParamByName('CODTAB').AsString := strCodTab;
        Open;
        fVerificaIntegridade(Self.Name, 'TABPRE', qryDelete);

        Clear;
        Add(' DELETE FROM TABPRE WHERE TAB_CODTAB = :CODTAB ');
        ParamByName('CODTAB').AsString := strCodTab;
        ExecSQL;
      End
      Else
      Begin
        Clear;
        Add(' UPDATE TABPRE SET TAB_ATICMP = "N" WHERE TAB_CODTAB = :CODTAB ');
        ParamByName('CODTAB').AsString := strCodTab;
        ExecSQL;

      End;


    End;
  Finally
    FreeAndNil(qryDelete);
  End;

end;

procedure TfrmAltPrecoGlobalItens.pGravaIteCom(strCodIte, strTabPre,
  strNomCam: String; fltPerCom: Double);
begin
  qryIteCom.Close;
  qryIteCom.ParamByName('CODITE').AsString := strCodIte;
  qryIteCom.ParamByName('TABPRE').AsString := strTabPre;
  qryIteCom.Open;

  If qryIteCom.IsEmpty Then
  Begin
    qryIteCom.Insert;
    qryIteCom.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('COMITE', vs_strCodEmp);
    qryIteCom.FieldByName('COM_CODITE').AsString := strCodIte;
    qryIteCom.FieldByName('COM_TABPRE').AsString := strTabPre;
  End
  Else
    qryIteCom.Edit;

  qryIteCom.FieldByName(strNomCam).AsFloat  := fltPerCom;

  qryIteCom.Post;
end;

procedure TfrmAltPrecoGlobalItens.pGravarLogCpr(const DataSetGrid: TDataSet;
  qryLogCpr: TUniQuery);
var
  intContador: Integer;
  intTamMat: Integer;
  fldCampo: TField;
  fldCampoNovo: TField;
begin
  qryLogCpr.Close;
  qryLogCpr.SQL.Clear;
  qryLogCpr.SQL.Add(fSQLLogCpr);

  intTamMat := Length(arrCamposGrid);

  For intContador := 0 To intTamMat-1 Do
  Begin
    If (arrCamposGrid[intContador].strNomArq <> 'CADITE') Then
      Continue;

    If fEmptyStr(arrCamposGrid[intContador].strNomCam) Then
      Continue;

    fldCampo     := DataSetGrid.FieldByName(arrCamposGrid[intContador].strNomCam);
    fldCampoNovo := DataSetGrid.FieldByName(arrCamposGrid[intContador].strNomCam + '_NOV');

    If fldCampo.Value <> fldCampoNovo.Value Then
    Begin
      qryLogCpr.ParamByName('AUTOIN').AsString := fRetAutoIncrem('LOGCPR', VS_strCodEmp);
      qryLogCpr.ParamByName('CODITE').AsString := DataSetGrid.FieldByName('ITE_CODITE').AsString;
      qryLogCpr.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
      qryLogCpr.ParamByName('DTAALT').AsDateTime := VS_Date;
      qryLogCpr.ParamByName('HORALT').AsDateTime := fTime();
      qryLogCpr.ParamByName('NOMCAM').AsString := fUpper(arrCamposGrid[intContador].strDesCam);

      qryLogCpr.ParamByName('EMPLOG').AsString := VS_strCodEmp;
      qryLogCpr.ParamByName('EMPFIS').AsString := fRetEmpresaFisica;

      Case fldCampoNovo.DataType of
        ftFloat :  Begin
                    If fldCampo.Value <> Null Then
                      qryLogCpr.ParamByName('VALANT').AsString := FormatFloat('#,##0.00', fldCampo.AsVariant);

                    If Not fldCampoNovo.IsNull Then
                      qryLogCpr.ParamByName('VALPOS').AsString := FormatFloat('#,##0.00', fldCampoNovo.AsFloat);
                  End;

        ftTime :  Begin
                    If fldCampo.Value <> Null Then
                      qryLogCpr.ParamByName('VALANT').AsString := FormatDateTime('HH:NN', fldCampo.AsVariant);

                    If Not fldCampoNovo.IsNull Then
                      qryLogCpr.ParamByName('VALPOS').AsString := FormatDateTime('HH:NN', fldCampoNovo.AsDateTime);
                  End;

        ftDate :  Begin
                    If fldCampo.Value <> Null Then
                      qryLogCpr.ParamByName('VALANT').AsString := FormatDateTime('DD/MM/YYYY', fldCampo.AsVariant);

                    If Not fldCampoNovo.IsNull Then
                      qryLogCpr.ParamByName('VALPOS').AsString := FormatDateTime('DD/MM/YYYY', fldCampoNovo.AsDateTime);
                  End;

        ftDateTime :Begin
                      If fldCampo.Value <> Null Then
                        qryLogCpr.ParamByName('VALANT').AsString := FormatDateTime('DD/MM/YYYY HH:NN', fldCampo.AsVariant);

                      If Not fldCampoNovo.IsNull Then
                        qryLogCpr.ParamByName('VALPOS').AsString := FormatDateTime('DD/MM/YYYY HH:NN', fldCampoNovo.AsDateTime);
                    End;

        ftWord,
        ftInteger,
        ftMemo,
        ftString: Begin
                    If fldCampo.Value <> Null Then
                      qryLogCpr.ParamByName('VALANT').AsString := fldCampo.AsVariant;

                    If Not fldCampoNovo.IsNull Then
                      qryLogCpr.ParamByName('VALPOS').AsString := fldCampoNovo.AsString;
                  End;
      End;

      qryLogCpr.ExecSQL;
    End;

  End;
end;

procedure TfrmAltPrecoGlobalItens.FormShow(Sender: TObject);
begin
  inherited;
  pAtualizaTabela;
  blnTemMargemBrutaNegativa := False;
  blnTemPrecoVendaNegativo := False;

  cxvItens.NavigatorButtons.First.Click;
end;

Function TfrmAltPrecoGlobalItens.fMarcaTodos(cxProgresso: TcxProgressBar): Boolean;
begin
  Result := True;

  If dtsItens.DataSet.IsEmpty Then
    Exit;

  dtsItens.DataSet.DisableControls;

  Try
    cxProgresso.Properties.Max := dtsItens.DataSet.RecordCount;

    dtsItens.DataSet.First;
    While Not dtsItens.DataSet.Eof Do
    Begin
      pMarcaItem(blnMarcar);
      dtsItens.Dataset.Next;

      cxProgresso.Position := cxProgresso.Position + 1;
      Application.ProcessMessages;
    End;

  Finally
    dtsItens.DataSet.EnableControls;
  End;

  cxvItens.NavigatorButtons.First.Click;
end;

procedure TfrmAltPrecoGlobalItens.btnDesTodClick(Sender: TObject);
begin
  inherited;

  blnMarcar := False;
  TfrmGravando.fExecuta(fMarcaTodos, frmGravando, 'Desmarcando itens...', True, True);
end;

procedure TfrmAltPrecoGlobalItens.btnMarTodClick(Sender: TObject);
begin
  inherited;

  blnMarcar := True;
  TfrmGravando.fExecuta(fMarcaTodos, frmGravando, 'Marcando itens...', True, True);
end;

procedure TfrmAltPrecoGlobalItens.btnVoltarClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmAltPrecoGlobalItens.cxvItensCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  If cxvItensMarcado.Focused Then
     PostMessage(Handle, WM_MESSAGESELECIONAITEM, 0, 0);
    
end;

procedure TfrmAltPrecoGlobalItens.cxvItensCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
  Var
    Key: Word;
    State: TShiftState;
begin
  inherited;
  Key := VK_Return;
  cxvItensKeyDown(Sender, Key, State);
end;

procedure TfrmAltPrecoGlobalItens.cxvItensCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);

  Function fTemMargemNegativa: Boolean;
  Begin
    Result := ((VS_strTabPrc[1] = 'S') And Assigned(Sender.FindItemByName('ITE_MARBR1_NOV')) And (fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, Sender.FindItemByName('ITE_MARBR1_NOV').Index])) < 0)) Or
              ((VS_strTabPrc[2] = 'S') And Assigned(Sender.FindItemByName('ITE_MARBR2_NOV')) And (fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, Sender.FindItemByName('ITE_MARBR2_NOV').Index])) < 0)) Or
              ((VS_strTabPrc[3] = 'S') And Assigned(Sender.FindItemByName('ITE_MARBR3_NOV')) And (fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, Sender.FindItemByName('ITE_MARBR3_NOV').Index])) < 0)) Or
              ((VS_strTabPrc[4] = 'S') And Assigned(Sender.FindItemByName('ITE_MARBR4_NOV')) And (fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, Sender.FindItemByName('ITE_MARBR4_NOV').Index])) < 0)) Or
              ((VS_strTabPrc[5] = 'S') And Assigned(Sender.FindItemByName('ITE_MARBR5_NOV')) And (fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, Sender.FindItemByName('ITE_MARBR5_NOV').Index])) < 0)) Or
              ((VS_strTabPrc[6] = 'S') And Assigned(Sender.FindItemByName('ITE_MARBR6_NOV')) And (fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, Sender.FindItemByName('ITE_MARBR6_NOV').Index])) < 0)) Or
              ((VS_strTabPrc[7] = 'S') And Assigned(Sender.FindItemByName('ITE_MARBR7_NOV')) And (fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, Sender.FindItemByName('ITE_MARBR7_NOV').Index])) < 0));
  End;

  Function fTemPreVendaNegativo: Boolean;
  Begin
    Result := ((VS_strTabPrc[1] = 'S') And Assigned(Sender.FindItemByName('ITE_PREVE1_NOV')) And (fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, Sender.FindItemByName('ITE_PREVE1_NOV').Index])) < 0)) Or
              ((VS_strTabPrc[2] = 'S') And Assigned(Sender.FindItemByName('ITE_PREVE2_NOV')) And (fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, Sender.FindItemByName('ITE_PREVE2_NOV').Index])) < 0)) Or
              ((VS_strTabPrc[3] = 'S') And Assigned(Sender.FindItemByName('ITE_PREVE3_NOV')) And (fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, Sender.FindItemByName('ITE_PREVE3_NOV').Index])) < 0)) Or
              ((VS_strTabPrc[4] = 'S') And Assigned(Sender.FindItemByName('ITE_PREVE4_NOV')) And (fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, Sender.FindItemByName('ITE_PREVE4_NOV').Index])) < 0)) Or
              ((VS_strTabPrc[5] = 'S') And Assigned(Sender.FindItemByName('ITE_PREVE5_NOV')) And (fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, Sender.FindItemByName('ITE_PREVE5_NOV').Index])) < 0)) Or
              ((VS_strTabPrc[6] = 'S') And Assigned(Sender.FindItemByName('ITE_PREVE6_NOV')) And (fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, Sender.FindItemByName('ITE_PREVE6_NOV').Index])) < 0)) Or
              ((VS_strTabPrc[7] = 'S') And Assigned(Sender.FindItemByName('ITE_PREVE7_NOV')) And (fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, Sender.FindItemByName('ITE_PREVE7_NOV').Index])) < 0));
  End;

begin
  inherited;

  If dtsItens.DataSet.IsEmpty Then
    Exit;

  blnTemMargemBrutaNegativa := fTemMargemNegativa;
  blnTemPrecoVendaNegativo  := fTemPreVendaNegativo;
  lblMarBrNegativa.Visible  := blnTemMargemBrutaNegativa;
  lblPreVenNegativo.Visible := blnTemPrecoVendaNegativo;

  lblLegendaAzul.Visible    := True;

  If (blnTemMargemBrutaNegativa) And
     ((Assigned(Sender.FindItemByName('ITE_CODITE'))     And (AViewInfo.Item.Index = Sender.FindItemByName('ITE_CODITE').Index)) Or
      (Assigned(Sender.FindItemByName('ITE_MARBR1_NOV')) And (AViewInfo.Item.Index = Sender.FindItemByName('ITE_MARBR1_NOV').Index)) Or
      (Assigned(Sender.FindItemByName('ITE_MARBR2_NOV')) And (AViewInfo.Item.Index = Sender.FindItemByName('ITE_MARBR2_NOV').Index)) Or
      (Assigned(Sender.FindItemByName('ITE_MARBR3_NOV')) And (AViewInfo.Item.Index = Sender.FindItemByName('ITE_MARBR3_NOV').Index)) Or
      (Assigned(Sender.FindItemByName('ITE_MARBR4_NOV')) And (AViewInfo.Item.Index = Sender.FindItemByName('ITE_MARBR4_NOV').Index)) Or
      (Assigned(Sender.FindItemByName('ITE_MARBR5_NOV')) And (AViewInfo.Item.Index = Sender.FindItemByName('ITE_MARBR5_NOV').Index)) Or
      (Assigned(Sender.FindItemByName('ITE_MARBR6_NOV')) And (AViewInfo.Item.Index = Sender.FindItemByName('ITE_MARBR6_NOV').Index)) Or
      (Assigned(Sender.FindItemByName('ITE_MARBR7_NOV')) And (AViewInfo.Item.Index = Sender.FindItemByName('ITE_MARBR7_NOV').Index))) Then
      ACanvas.Font.Color := clRed
  Else If (blnTemPrecoVendaNegativo) And
     ((Assigned(Sender.FindItemByName('ITE_CODITE'))     And (AViewInfo.Item.Index = Sender.FindItemByName('ITE_CODITE').Index)) Or
      (Assigned(Sender.FindItemByName('ITE_PREVE1_NOV')) And (AViewInfo.Item.Index = Sender.FindItemByName('ITE_PREVE1_NOV').Index)) Or
      (Assigned(Sender.FindItemByName('ITE_PREVE2_NOV')) And (AViewInfo.Item.Index = Sender.FindItemByName('ITE_PREVE2_NOV').Index)) Or
      (Assigned(Sender.FindItemByName('ITE_PREVE3_NOV')) And (AViewInfo.Item.Index = Sender.FindItemByName('ITE_PREVE3_NOV').Index)) Or
      (Assigned(Sender.FindItemByName('ITE_PREVE4_NOV')) And (AViewInfo.Item.Index = Sender.FindItemByName('ITE_PREVE4_NOV').Index)) Or
      (Assigned(Sender.FindItemByName('ITE_PREVE5_NOV')) And (AViewInfo.Item.Index = Sender.FindItemByName('ITE_PREVE5_NOV').Index)) Or
      (Assigned(Sender.FindItemByName('ITE_PREVE6_NOV')) And (AViewInfo.Item.Index = Sender.FindItemByName('ITE_PREVE6_NOV').Index)) Or
      (Assigned(Sender.FindItemByName('ITE_PREVE7_NOV')) And (AViewInfo.Item.Index = Sender.FindItemByName('ITE_PREVE7_NOV').Index))) Then
      ACanvas.Font.Color := clRed
  Else If (lblAvisoAtivo.Visible) And
         (Assigned(Sender.FindItemByName('ITE_ITEATI_NOV')) And
         (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, Sender.FindItemByName('ITE_ITEATI_NOV').Index]) = 'S')) Then
  Begin
    ACanvas.Font.Color := clRed;
  End

  Else If Assigned(Sender.FindItemByName('ITE_MARDES')) And
          (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, Sender.FindItemByName('ITE_MARDES').Index]) = 'M') Then
      ACanvas.Font.Color := clBlue;

  If Not AViewInfo.Selected Then
  Begin
    If Pos('_NOV', AViewInfo.Item.Name) > 0 Then
      ACanvas.Brush.Color := clSilver
    Else
      ACanvas.Brush.Color := clWhite;
  End;
end;

procedure TfrmAltPrecoGlobalItens.cxvItensDataControllerFilterChanged(
  Sender: TObject);
begin
  inherited;
  dtsItens.DataSet.DisableControls;
  Try
    dtsItens.DataSet.Filtered := False;
    If Not fEmptyStr(cxvItens.DataController.Filter.FilterText) Then
    Begin
      dtsItens.DataSet.Filter := UPPERCASE(cxvItens.DataController.Filter.FilterText);
      dtsItens.DataSet.Filtered := True;
    End;

  Finally
    dtsItens.DataSet.EnableControls;
  End;
end;

procedure TfrmAltPrecoGlobalItens.cxvItensDataControllerSortingChanged(
  Sender: TObject);
var
  intCont: Integer;
  strFieldName: String;
  objField: TField;
  DataSet : TUniClientDataSet;
begin
  inherited;
  DataSet :=  TUniClientDataSet(dtsItens.DataSet);

  If cxvItens.SortedItemCount > 0 Then
  begin
    For intCont := 0 To cxvItens.SortedItemCount - 1 Do
    Begin
      strFieldName := cxvItens.SortedItems[intCont].DataBinding.FilterFieldName.Trim.Replace(' ','');
      objField := dtsItens.DataSet.FindField(strFieldName);
      If objField <> nil Then
        If objField.FieldKind = fkData then
          pOrdenaDataSet(DataSet,
            strFieldName,
            IfThen(cxvItens.SortedItems[intCont].SortOrder = soDescending, 'DESC'));
    End;
  End;
end;

procedure TfrmAltPrecoGlobalItens.cxvItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_Return) Then
  Begin
    pSelecionaItem;
    cxvItens.Controller.FocusNextRecord(cxvItens.Controller.FocusedRecordIndex, not (ssShift in Shift), true, false, false);
  End
  Else If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
  End
  Else If (Key = VK_F3) Then
  Begin
    btnMarTod.Click;
  End
  Else If (Key = VK_F4) Then
  Begin
    btnDesTod.Click;
  End
  Else If (Key = VK_Escape) Then
  Begin
    btnVoltar.Click;
  End;

end;

procedure TfrmAltPrecoGlobalItens.cxvItensStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
var
  clmColuna: TcxGridDBColumn;
begin
  inherited;
  clmColuna := TcxGridDBColumn(AItem);

  If Not Assigned(clmColuna) Then
    Exit;

  If (clmColuna.DataBinding.FieldName = 'ITE_PRECUS') And (blnTrataTPO)  Then
    AStyle := cxBlackBold;
end;

procedure TfrmAltPrecoGlobalItens.pSelecionaItem;
begin
  pMarcaItem(dtsItens.DataSet.FieldByName('ITE_MARDES').AsString <> 'M');
end;

procedure TfrmAltPrecoGlobalItens.pWMMessageSelecionaItem(
  var Message: TMessage);
begin
  If cxvItensMarcado.Focused Then
    pMarcaItem(dtsItens.DataSet.FieldByName('ITE_MARDES').AsString <> 'M');
end;

procedure TfrmAltPrecoGlobalItens.pMarcaItem(blnMarcar: Boolean);
begin

  cxvItens.DataController.BeginUpdate;
  Try
    With dtsItens.DataSet Do
    Begin
      Edit;
      FieldByName('ITE_MARDES').AsString := IIF(blnMarcar, 'M', 'D');
      Post;
    End;
  Finally
    cxvItens.DataController.EndUpdate;
  End;
end;

Function TfrmAltPrecoGlobalItens.fValidaPrecoCustoRealAux(cxProgressBar: TcxProgressBar): Boolean;
var  strConfig : String;
Begin
  Try

    strConfig := fCfgSis('TABPRC');
    cxProgressBar.Properties.Max := qryGenExt.RecordCount;
    While not qryGenExt.Eof do
      Begin
        If ((strConfig[1] = 'S') AND (qryGenExt.FieldByName('ITE_PREVE1_NOV').AsFloat > 0) And (qryGenExt.FieldByName('ITE_PREVE1_NOV').AsFloat <> qryGenExt.FieldByName('ITE_PREVE1').AsFloat) And (qryGenExt.FieldByName('ITE_PREVE1_NOV').AsFloat < qryGenExt.FieldByName('ITE_PRECUS').AsFloat)) Or
           ((strConfig[2] = 'S') AND (qryGenExt.FieldByName('ITE_PREVE2_NOV').AsFloat > 0) And (qryGenExt.FieldByName('ITE_PREVE2_NOV').AsFloat <> qryGenExt.FieldByName('ITE_PREVE2').AsFloat) And (qryGenExt.FieldByName('ITE_PREVE2_NOV').AsFloat < qryGenExt.FieldByName('ITE_PRECUS').AsFloat)) Or
           ((strConfig[3] = 'S') AND (qryGenExt.FieldByName('ITE_PREVE3_NOV').AsFloat > 0) And (qryGenExt.FieldByName('ITE_PREVE3_NOV').AsFloat <> qryGenExt.FieldByName('ITE_PREVE3').AsFloat) And (qryGenExt.FieldByName('ITE_PREVE3_NOV').AsFloat < qryGenExt.FieldByName('ITE_PRECUS').AsFloat)) Or
           ((strConfig[4] = 'S') AND (qryGenExt.FieldByName('ITE_PREVE4_NOV').AsFloat > 0) And (qryGenExt.FieldByName('ITE_PREVE4_NOV').AsFloat <> qryGenExt.FieldByName('ITE_PREVE4').AsFloat) And (qryGenExt.FieldByName('ITE_PREVE4_NOV').AsFloat < qryGenExt.FieldByName('ITE_PRECUS').AsFloat)) Or
           ((strConfig[5] = 'S') AND (qryGenExt.FieldByName('ITE_PREVE5_NOV').AsFloat > 0) And (qryGenExt.FieldByName('ITE_PREVE5_NOV').AsFloat <> qryGenExt.FieldByName('ITE_PREVE5').AsFloat) And (qryGenExt.FieldByName('ITE_PREVE5_NOV').AsFloat < qryGenExt.FieldByName('ITE_PRECUS').AsFloat)) Or
           ((strConfig[6] = 'S') AND (qryGenExt.FieldByName('ITE_PREVE6_NOV').AsFloat > 0) And (qryGenExt.FieldByName('ITE_PREVE6_NOV').AsFloat <> qryGenExt.FieldByName('ITE_PREVE6').AsFloat) And (qryGenExt.FieldByName('ITE_PREVE6_NOV').AsFloat < qryGenExt.FieldByName('ITE_PRECUS').AsFloat)) Or
           ((strConfig[7] = 'S') AND (qryGenExt.FieldByName('ITE_PREVE7_NOV').AsFloat > 0) And (qryGenExt.FieldByName('ITE_PREVE7_NOV').AsFloat <> qryGenExt.FieldByName('ITE_PREVE7').AsFloat) And (qryGenExt.FieldByName('ITE_PREVE7_NOV').AsFloat < qryGenExt.FieldByName('ITE_PRECUS').AsFloat)) Then

           lstProdutosAux.Add(qryGenExt.FieldByName('ITE_CODITE').AsString);

       cxProgressBar.Position := cxProgressBar.Position + 1;
       frmGravando.pAtualizaTempoRestante;
       Application.ProcessMessages;

       qryGenExt. Next;
      End;
      Result := True;
  finally
    qryGenExt.First;
  End;

End;

function TfrmAltPrecoGlobalItens.fPedeLiberacaoPrecoCustoReal: boolean;
Begin
  qryGenExt := dtsItens.DataSet;
  If Not blnValidaCustoReal Then
    Exit(False);
  Result := TfrmGravando.fExecuta(fValidaPrecoCustoRealPrg, frmGravando, 'Validando Preço de Custo Real dos itens...', True, True);
End;

function TfrmAltPrecoGlobalItens.fValidaPrecoCustoRealPrg(pgbProgresso: TcxProgressBar): boolean;
var
  objLinha  : TLinhaMsgLibera;
  objTabela : TRegistroMsgLiberaTabela;
  I, X : Integer;
  lstProdutos : TStringList;
  strSalva,
  strConfig: String;
begin
  frmGravando.blnTempoRestante := True;

  qryGenExt.DisableControls;

  Try
    strConfig := fCfgSis('TABPRC');

    lstProdutos := TStringList.Create;

    lstProdutosAux := lstProdutos;
    With dtsItens.DataSet Do
    Begin
      Filter := '(ITE_MARDES = ''M'')';
      Filtered := True;
      First;

      Result := fValidaPrecoCustoRealAux(pgbProgresso);
      If Not Result Then
        Exit;

      If lstProdutos.Count = 0 Then
        Result := False
      Else
      Begin
        objLiberacao := TLiberacaoFactory.fGetLiberacao;
        objLiberacao.Clear;

        With objLiberacao.objMsgLibera do
        Begin
          pAddTexto('LIBERAÇÃO DE PREÇO DE VENDA ABAIXO DO CUSTO REAL');
          pAddQuebra();
          pAddTexto('Os produtos abaixo ficarão com o preço de venda menor que o preço de custo real.');
          pAddTexto('Esta mensagem tem por objetivo evitar erros operacionais.');
          pAddTexto('Será permitido liberação com senha para finalizar o procedimento mesmo assim, para casos onde realmente é');
          pAddTexto('o objetivo manter desta forma.');
        End;

        objTabela := TRegistroMsgLiberaTabela.Create;

        objLinha  := TLinhaMsgLibera.Create;
        With objLinha Do
        Begin
          enuTipoLinha := tlCabecalho;
          pAddColuna(''  , 'CÓD.'          , 7  , alCentro   , teAutcom);
          pAddColuna(''  , 'DESCRIÇÃO'     , 55 , alEsquerda , teAutcom);
          pAddColuna(''  , 'UN'            , 4  , alCentro   , teAutcom);
          pAddColuna(''  , 'PR.CUSTO '     , 15 , alDireita  , teAutcom);
          pAddColuna(''  , 'PR.CUSTO REAL ', 15 , alDireita  , teAutcom);
        For I := 1 to Length(strConfig) Do
          Begin
            If strConfig[I] = 'S' Then
              pAddColuna(''  , 'PR. VENDA '+ IntToStr(I) , 15 , alDireita  , teAutcom);
          End;
        End;

        objTabela.lstLinhas.Add(objLinha);

        strSalva := TUniClientDataSet(dtsItens.DataSet).IndexFieldNames;

        TUniClientDataSet(dtsItens.DataSet).IndexFieldNames := 'ITE_CODITE';

        frmGravando.tmrEstimado.Enabled := False;
        frmGravando.recTempoEstimado.intPosicao := 0;
        pgbProgresso.Position := 0;
        pgbProgresso.Properties.Max := lstProdutos.Count;
        frmGravando.recTempoEstimado.HorInicio := fTime();
        frmGravando.tmrEstimado.Enabled := True;
        Application.ProcessMessages;

        For I := 0 to lstProdutos.Count-1 Do
        Begin
          If TUniClientDataSet(dtsItens.DataSet).FindKey([lstProdutos[I]]) Then
          Begin
            objLinha  := TLinhaMsgLibera.Create;
            With objLinha do
            Begin
              enuTipoLinha := tlValor;
              pAddColuna('CÓD.'          , FieldByName('ITE_CODITE').AsString , 7  , alCentro);
              pAddColuna('DESCRIÇÃO'     , FieldByName('ITE_DESITE').AsString , 55 , alEsquerda);
              pAddColuna('UN'            , FieldByName('ITE_UNICOM').AsString , 4  , alCentro  );
              pAddColuna('PR.CUSTO '     , FormatFloat('#,##0.00', FieldByName('ITE_PRECUS').AsFloat) , 15 , alDireita );
              pAddColuna('PR.CUSTO REAL ', FormatFloat('#,##0.00', FieldByName('ITE_PRECUS').AsFloat) , 15 , alDireita );

              For X := 1 to Length(strConfig) Do
              Begin
                If strConfig[X] = 'S' Then
                   pAddColuna('PR. VENDA '+ IntToStr(X) , FormatFloat('#,##0.00', FieldByName('ITE_PREVE'+IntToStr(X)+'_NOV').AsFloat) , 15 , alDireita );
              End;

            End;

            objTabela.lstLinhas.Add(objLinha);
          End;

          pgbProgresso.Position := pgbProgresso.Position + 1;
          frmGravando.pAtualizaTempoRestante;
          Application.ProcessMessages;
        End;

        TUniClientDataSet(dtsItens.DataSet).IndexFieldNames := strSalva;

        With objLiberacao Do
        Begin
          objMsgLibera.lstRegistros.Add(objTabela);

          strDirAce  := 'VMENCU';
          strMsgSen  := 'Liberação de preço de venda abaixo do custo real';
          strCodOpe  := strLoginUsuarioLogado;
          intLargura := 1900;
        End;

        Result := True;
      End;
    End;

  Finally
    dtsItens.DataSet.EnableControls;
    Application.ProcessMessages;
  End;
end;

function TfrmAltPrecoGlobalItens.fConfirmaItens: Boolean;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    With frmGravando Do
    Begin
      blnTempoRestante := True;
      fExecutarAcao := fConfirmaItensAux;
      lblGravando.Caption := 'Aguarde, atualizando itens...';
      ShowModal;
      Result := blnConfirma;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmAltPrecoIndividual.fConfirmaItens]');
      Result := False;
    End;
  End;

  FreeAndNil(frmGravando);
End;

function TfrmAltPrecoGlobalItens.fConfirmaItensAux(pgbProgresso2: TcxProgressBar): Boolean;
  Const
    STR_CAMPOS_CUSTOS_INFMAT = 'ITE_PRECOM_ITE_IPIENT_ITE_FREENT_ITE_VALFRE_ITE_PRECUS_' +
                               'ITE_DESF01_ITE_DESF02_ITE_DESF03_ITE_DESF04_ITE_DESF05_ITE_DESF06_' +
                               'ITE_ACRFIN_ITE_ICMENT_ITE_SUBFED_ITE_SUBSTI_ITE_DESADB_';

  Var
    blnCprInd: Boolean;

    strSQL: String;
    strUpdCadIte: String;

    strUpdIteGer: String;
    strUpdDetCus: String;

    strUpdIteGerCustos: String;

    strUpdDessit: String;

    intContador: Integer;
    intTamMat: Integer;

    blnAltCadIte: Boolean;
    blnAltIteGer: Boolean;
    blnAltIteGerCustos: Boolean;
    blnAltDessit: Boolean;
    blnValidouRegistroNaTabelaDESSIT: Boolean;

    fldCampo: TField;
    fldCampoNovo: TField;

    strEmpresas: String;

    strUpdDtaAltera: String;

    fltComAnt: Double;
    fltComAtu: Double;
    fltCusAnt: Double;
    fltCusAtu: Double;
    fltVe1Ant: Double;
    fltVe1Atu: Double;
    fltVe2Ant: Double;
    fltVe2Atu: Double;
    fltVe3Ant: Double;
    fltVe3Atu: Double;
    fltVe4Ant: Double;
    fltVe4Atu: Double;
    fltVe5Ant: Double;
    fltVe5Atu: Double;
    fltVe6Ant: Double;
    fltVe6Atu: Double;
    fltVe7Ant: Double;
    fltVe7Atu: Double;
    fltMa1Ant: Double;
    fltMa1Atu: Double;
    fltMa2Ant: Double;
    fltMa2Atu: Double;
    fltMa3Ant: Double;
    fltMa3Atu: Double;
    fltMa4Ant: Double;
    fltMa4Atu: Double;
    fltMa5Ant: Double;
    fltMa5Atu: Double;
    fltMa6Ant: Double;
    fltMa6Atu: Double;
    fltMa7Ant: Double;
    fltMa7Atu: Double;

    blnInfMat: Boolean;

    intInfFed,
    intInfOpe,
    intInfSai: Integer;

    qryGenEmp: TUniQuery;
    qryGenTmp: TUniQuery;
    qryLogCpr: TUniQuery;

    strProPri,
    strImpLis,
    strApeRet,
    strApeEnt: String;
    strUpdIpiSai: String;
    strUpdLocFis: String;
    strUpdCodAbf: String;
    strUpdObrNfe: string;
    strUpdAbfPis: String;
    strUpdAbfCof: String;
    strUpdAbfIpi: String;
    strUpdTipPro: String;
    strUpdSitPro: String;
    strUpdIteGerEstMAX,
    strUpdIteGerEstMIN: String;
    strRefere   : String;
    strCodUni   : String;
    blnPonExp,
    blnEstMin,
    blnEstMax,
    blnEsmIlj : Boolean;

    fltEstMin,
    fltEstMax : Double;
    strAutoPreAlt,
    strEmpAux : String;
    strTbpAux : String;
    intTbpAux : Integer;
    stlEmpFilial : TStringList;
    strCodEmpCalc,
    strEmpFilial : String;
    ObjCalculaVariacaoPreco : TCalculaVariacaoPreco;
    strAgrupadorPreAlt: String;

    blnEncontrouESMIDG: Boolean;
    intEncontrouESMIDG: Integer;

    blnEncontrouTPESTM: Boolean;
    intEncontrouTPESTM: Integer;

    intAtualiza: Integer;

    blnExistePrecoPautaFiscal: Boolean;
  Const
    strInsTbp : String = 'INSERT  INTO ITETBP (ITE_CODITE, ITE_CODEMP, ITE_TABPRE,  XXX) ' +
                                      'VALUES (   :CODITE,    :CODEMP,    :TABPRE, :MAX);';

    strUptTbp : String = 'UPDATE ITETBP SET XXX = :MAX ' +
                         'WHERE ITE_CODITE = :CODITE   ' +
                         '  AND ITE_CODEMP = :CODEMP   ' +
                         '  AND ITE_TABPRE = :TABPRE;  ' ;

  Procedure pSetParametrosIteTbp(strCodEmp:String);
  Begin
    With qryGenTmp Do
    Begin
      ParamByName('CODITE').AsString := dtsItens.DataSet.FieldByName('ITE_CODITE').AsString;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('TABPRE').AsString := fRetSomenteNumeros(arrCamposGrid[intContador].strNomCam);
      if Params.FindParam('MAX') <> NIl Then
        ParamByName('MAX').AsFloat     := fldCampoNovo.AsFloat;
    End;
  End;

  Procedure pValidaRegistroNaTabelaDESSIT(strCodIte: String);
    Var
    qryAuxDesSit: TUniQuery;
  Begin
    qryAuxDesSit := fCriaQuery;
    Try
      Try
        qryAuxDesSit.Close;
        qryAuxDesSit.SQL.Clear;
        qryAuxDesSit.SQL.Add(' SELECT *                    ');
        qryAuxDesSit.SQL.Add('   FROM DESSIT               ');
        qryAuxDesSit.SQL.Add('  WHERE ITE_CODITE = :CODITE ');

        qryAuxDesSit.ParamByName('CODITE').AsString := strCodIte;
        qryAuxDesSit.Open;

        If qryAuxDesSit.IsEmpty Then
        Begin
          qryAuxDesSit.Insert;
          qryAuxDesSit.FieldByName('ITE_CODITE').AsString := strCodIte;
          qryAuxDesSit.Post;
        End;
      Finally
        FreeAndNil(qryAuxDesSit);
        blnValidouRegistroNaTabelaDESSIT := True;
      End;
    Except
      On E: Exception Do
        Raise Exception.Create('Erro ao atualizar a tabela DESSIT '+ #13#10 + E.Message);
    End;
  End;

begin
  VS_blnGravaLogTransacao := False;
  VS_GravaUsuRep := 'N';

  qryGenEmp := fCriaQuery;
  qryGenTmp := fCriaQuery;
  qryLogCpr := fCriaQuery;
  stlEmpFilial := TStringList.Create;
  fRetEmpresasUsamPrecoMatriz(stlEmpFilial, ''{strCodEmp}, ''{strEmpPar}, True{blnSomenteAtivas});
  strEmpFilial := '';
  strAutoPreAlt := '';

  blnPonExp := fCfgSis('PONEXP', varBoolean);

  blnCprInd := fCfgSis('CPRIND', varBoolean);
  blnInfMat := fCfgSis('INFMAT', varBoolean);

  intInfFed := fCfgSis('INFFED', varInteger);
  intInfOpe := fCfgSis('INFOPE', varInteger);
  intInfSai := fCfgSis('INFSAI', varInteger);
  intSitPro := fCfgSis('SITEMP', varInteger);
  blnEsmIlj := fCfgSis('ESMILJ', varBoolean);

  Result    := True;
  pPreAltDefineVariaveisAltPre(fNow, iif(blnGeral, 'ALTERAÇÃO GERAL DE PREÇOS', 'ALTERACAO GLOBAL DE PRECOS'), strLoginUsuarioLogado, VS_StrCodEmp, strAgrupadorPreAlt);

  If fCfgSis('TABDIN', varBoolean) And Not blnPorDta Then
    strCodTabDin := fAtualizaProCod('ITETAB', 'PRE_CODTAB');

  If Not fCfgSis('TABDIN', varBoolean) Or blnPorDta Then
    strProPri := fRetSequencial('PROPRI', VS_strCodEmp)
  Else
    strProPri := '';

  blnExistePrecoPautaFiscal := fExistePrecoPautaFiscal;

  {*****************************************}
  {* SELECIONA SOMENTE ITENS MARCADOS      *}
  {**************************************MV*}
  With dtsItens.DataSet Do
  Begin
    DisableControls;
    Filter := '(ITE_MARDES = ''M'')';
    Filtered := True;

    If (dtaDtaAlt = Date) Then
    Begin
      ObjCalculaVariacaoPreco := TCalculaVariacaoPreco.Create;

      If not ObjCalculaVariacaoPreco.fTravaPrecosForaPermitido(dtsItens.DataSet) Then
        Exit(False);
      FreeAndNil(ObjCalculaVariacaoPreco);
    End;

    First;
  //  pgbProgresso.Visible := True;
  //  pgbProgresso.Max := RecordCount;

    strRefere := EmptyStr;
    strCodUni := EmptyStr;

    If RecordCount > 1000 Then
      intAtualiza := RecordCount Div 100
    Else
      intAtualiza := 0;

    Try
      pgbProgresso2.Position       := 0;
      pgbProgresso2.Properties.Max := RecordCount;
      Application.ProcessMessages;

      While Not Eof Do
      Begin

        If blnGeral Then
          strEmpresas := fGetEmpresasUsamPrecoMatriz(FieldByName('ITE_CODEMP').AsString)
        Else
          strEmpresas := fGetEmpresasUsamPrecoMatriz('');

        If blnGeral And (Not strAgrupadorPreAlt.IsEmpty )Then
          pPreAltAtualizaEmpresa(FieldByName('ITE_CODEMP').AsString, strAgrupadorPreAlt);

        If ((VS_strTabPrc[1] = 'S') And (dtsItens.DataSet.FieldByName('ITE_PREVE1_NOV').AsFloat < 0)) Or
           ((VS_strTabPrc[2] = 'S') And (dtsItens.DataSet.FieldByName('ITE_PREVE2_NOV').AsFloat < 0)) or
           ((VS_strTabPrc[3] = 'S') And (dtsItens.DataSet.FieldByName('ITE_PREVE3_NOV').AsFloat < 0)) or
           ((VS_strTabPrc[4] = 'S') And (dtsItens.DataSet.FieldByName('ITE_PREVE4_NOV').AsFloat < 0)) or
           ((VS_strTabPrc[5] = 'S') And (dtsItens.DataSet.FieldByName('ITE_PREVE5_NOV').AsFloat < 0)) or
           ((VS_strTabPrc[6] = 'S') And (dtsItens.DataSet.FieldByName('ITE_PREVE6_NOV').AsFloat < 0)) or
           ((VS_strTabPrc[7] = 'S') And (dtsItens.DataSet.FieldByName('ITE_PREVE7_NOV').AsFloat < 0)) Then
         Begin
           If (RecordCount = 1) Then
           Begin
              fMensagem('', 'Não há itens para atualizar!', ['&O k']);
              Result := False;
              break;
           End
           Else
           Begin
              Next;
              If Eof then
                 break;
           End;
         End;

        strImpLis := '';
        strApeRet := '';
        strApeEnt := '';
        fltEstMax := 0;
        fltEstMin := 0;
        blnEstMax := False;
        blnEstMin := False;

        blnAltCadIte := False;
        blnAltIteGer := False;
        blnAltIteGerCustos := False;
        blnAltDessit := False;
        blnValidouRegistroNaTabelaDESSIT := False;

        intTamMat := Length(arrCamposGrid);
        fStartTransaction;

        strUpdCadIte := '';
        strUpdCadIte := strUpdCadIte + 'UPDATE   ';
        strUpdCadIte := strUpdCadIte + '  CADITE ';
        strUpdCadIte := strUpdCadIte + 'SET ';

        strUpdIteGer := '';
        strUpdIteGer := strUpdIteGer + 'UPDATE   ';
        strUpdIteGer := strUpdIteGer + '  ITEGER ';
        strUpdIteGer := strUpdIteGer + 'SET ';
        strUpdIteGer := strUpdIteGer + ' ITE_PREALT = "'+strAgrupadorPreAlt+'", ';

        strUpdDetCus := '';

        strUpdDessit := '';
        strUpdDessit := strUpdDessit + 'UPDATE   ';
        strUpdDessit := strUpdDessit + '  DESSIT ';
        //strUpdDessit := strUpdDessit + '  INNER JOIN CADITE I ON (D.ITE_CODITE = I.ITE_CODITE AND I.ITE_EXPSIT = "S") ';
        strUpdDessit := strUpdDessit + 'SET ';

        strUpdIteGerCustos := strUpdIteGer;

        strUpdIteGerCustos := strUpdIteGerCustos + ' ITE_PREALT = "'+strAgrupadorPreAlt+'", ';

        strUpdLocFis := '';
        strUpdIpiSai := '';

        {*****************************************}
        {* ATRIBUI VALORES PARA VARIAVEIS USADAS *}
        {* NA GRAVAÇÃO DO PREALT                 *}
        {**************************************MV*}
        fltComAnt := FieldByName('ITE_PRECOM').AsFloat;
        fltComAtu := FieldByName('ITE_PRECOM_NOV').AsFloat;
        fltCusAnt := FieldByName('ITE_PRECUS').AsFloat;
        fltCusAtu := FieldByName('ITE_PRECUS_NOV').AsFloat;
        fltVe1Ant := FieldByName('ITE_PREVE1').AsFloat;
        fltVe1Atu := FieldByName('ITE_PREVE1_NOV').AsFloat;
        fltVe2Ant := FieldByName('ITE_PREVE2').AsFloat;
        fltVe2Atu := FieldByName('ITE_PREVE2_NOV').AsFloat;
        fltVe3Ant := FieldByName('ITE_PREVE3').AsFloat;
        fltVe3Atu := FieldByName('ITE_PREVE3_NOV').AsFloat;
        fltVe4Ant := FieldByName('ITE_PREVE4').AsFloat;
        fltVe4Atu := FieldByName('ITE_PREVE4_NOV').AsFloat;
        fltVe5Ant := FieldByName('ITE_PREVE5').AsFloat;
        fltVe5Atu := FieldByName('ITE_PREVE5_NOV').AsFloat;
        fltVe6Ant := FieldByName('ITE_PREVE6').AsFloat;
        fltVe6Atu := FieldByName('ITE_PREVE6_NOV').AsFloat;
        fltVe7Ant := FieldByName('ITE_PREVE7').AsFloat;
        fltVe7Atu := FieldByName('ITE_PREVE7_NOV').AsFloat;
        fltMa1Ant := FieldByName('ITE_MARBR1').AsFloat;
        fltMa1Atu := FieldByName('ITE_MARBR1_NOV').AsFloat;
        fltMa2Ant := FieldByName('ITE_MARBR2').AsFloat;
        fltMa2Atu := FieldByName('ITE_MARBR2_NOV').AsFloat;
        fltMa3Ant := FieldByName('ITE_MARBR3').AsFloat;
        fltMa3Atu := FieldByName('ITE_MARBR3_NOV').AsFloat;
        fltMa4Ant := FieldByName('ITE_MARBR4').AsFloat;
        fltMa4Atu := FieldByName('ITE_MARBR4_NOV').AsFloat;
        fltMa5Ant := FieldByName('ITE_MARBR5').AsFloat;
        fltMa5Atu := FieldByName('ITE_MARBR5_NOV').AsFloat;
        fltMa6Ant := FieldByName('ITE_MARBR6').AsFloat;
        fltMa6Atu := FieldByName('ITE_MARBR6_NOV').AsFloat;
        fltMa7Ant := FieldByName('ITE_MARBR7').AsFloat;
        fltMa7Atu := FieldByName('ITE_MARBR7_NOV').AsFloat;

        For intContador := 0 To intTamMat -1 Do
        Begin

          If Not fEmptyStr(arrCamposGrid[intContador].strNomCam) Then
          Begin

            fldCampo     := FieldByName(arrCamposGrid[intContador].strNomCam);
            fldCampoNovo := FieldByName(arrCamposGrid[intContador].strNomCam + '_NOV');

            If arrCamposGrid[intContador].strNomArq = 'ITETBP' Then
            Begin
              For strEmpFilial in stlEmpFilial Do
              Begin
                qryGenTmp.Close;
                qryGenTmp.SQL.Clear;
                qryGenTmp.SQL.Add( 'SELECT COUNT(0) AS QTDREG   ' );
                qryGenTmp.SQL.Add( 'FROM ITETBP                 ' );
                qryGenTmp.SQL.Add( 'WHERE ITE_CODITE = :CODITE  ' );
                qryGenTmp.SQL.Add( '  AND ITE_CODEMP = :CODEMP  ' );
                qryGenTmp.SQL.Add( '  AND ITE_TABPRE = :TABPRE  ' );
                pSetParametrosIteTbp(strEmpFilial);
                qryGenTmp.Open;

                intTbpAux := qryGenTmp.FieldByName('QTDREG').AsInteger;

                qryGenTmp.Close;
                qryGenTmp.SQL.Clear;
                qryGenTmp.SQL.Add( IIF(intTbpAux > 0, strUptTbp, strInsTbp) );

                strTbpAux := Copy(arrCamposGrid[intContador].strNomCam,1, 9 );

                Case AnsiIndexStr(strTbpAux, ['ITE_DESMA','ITE_DESVM','ITE_DESMS', 'ITE_DESSM','ITE_DESMG','ITE_DESGM']) of
                  0: strTbpAux := 'ITE_DESMAX'; {Desc. Máx. Vendedor - Júnior}
                  1: strTbpAux := 'ITE_DESVMM'; {Desc. Máx. Vendedor - Master}
                  2: strTbpAux := 'ITE_DESMSU'; {Desc. Máx. Sub-Gerente - Júnior}
                  3: strTbpAux := 'ITE_DESSMM'; {Desc. Máx. Sub-Gerente - Master}
                  4: strTbpAux := 'ITE_DESMGE'; {Desc. Máx. Gerente - Júnior}
                  5: strTbpAux := 'ITE_DESGMM'; {Desc. Máx. Gerente - Master}
                End;

                qryGenTmp.SQL.Text := ReplaceStr(qryGenTmp.SQL.Text, 'XXX', strTbpAux );

                pSetParametrosIteTbp(strEmpFilial);

                qryGenTmp.ExecSQL;
                qryGenTmp.Close;
              End;

            End
            Else
            If arrCamposGrid[intContador].strNomCam = 'ITE_IMPLIS' Then
            Begin
              strImpLis := fldCampoNovo.AsString;
            End
            Else
            If arrCamposGrid[intContador].strNomCam = 'ITE_APERET' Then
            Begin
              strApeRet := fldCampoNovo.AsString;
            End
            Else
            If arrCamposGrid[intContador].strNomCam = 'ITE_APEENT' Then
            Begin
              strApeEnt := fldCampoNovo.AsString;
            End
            Else If arrCamposGrid[intContador].strNomCam = 'ITE_LOCFIS' Then
            Begin
              strUpdLocFis := '';
              strUpdLocFis := strUpdLocFis + 'UPDATE ';
              strUpdLocFis := strUpdLocFis + '  ITEGER ';
              strUpdLocFis := strUpdLocFis + 'SET ';
              strUpdLocFis := strUpdLocFis + '  ITE_LOCFIS = ' + QuotedStr(fldCampoNovo.AsString) + ' ';
              strUpdLocFis := strUpdLocFis + 'WHERE ';
              strUpdLocFis := strUpdLocFis + '  ITE_CODITE = ' + QuotedStr(FieldByName('ITE_CODITE').AsString) + ' AND ';
              strUpdLocFis := strUpdLocFis + '  ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';
            End
            Else If arrCamposGrid[intContador].strNomCam = 'ITE_CODABF' Then
            Begin
              strUpdCodAbf := '';
              If strTIPABF = '2' Then
              begin
                strUpdCodAbf := strUpdCodAbf + 'UPDATE ';
                strUpdCodAbf := strUpdCodAbf + '  ITEGER ';
                strUpdCodAbf := strUpdCodAbf + 'SET ';
                strUpdCodAbf := strUpdCodAbf + '  ITE_CODABF = ' + QuotedStr(fldCampoNovo.AsString) + ' ';
                strUpdCodAbf := strUpdCodAbf + 'WHERE ';
                strUpdCodAbf := strUpdCodAbf + '  ITE_CODITE = ' + QuotedStr(FieldByName('ITE_CODITE').AsString) + ' AND ';
                strUpdCodAbf := strUpdCodAbf + '  ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';
              End
              Else
              begin
                strUpdCodAbf := strUpdCodAbf + 'UPDATE ';
                strUpdCodAbf := strUpdCodAbf + '  CADITE ';
                strUpdCodAbf := strUpdCodAbf + 'SET ';
                strUpdCodAbf := strUpdCodAbf + '  ITE_CODABF = ' + QuotedStr(fldCampoNovo.AsString) + ' ';
                strUpdCodAbf := strUpdCodAbf + 'WHERE ';
                strUpdCodAbf := strUpdCodAbf + '  ITE_CODITE = ' + QuotedStr(FieldByName('ITE_CODITE').AsString);
              End;


            End
            Else If (arrCamposGrid[intContador].strNomCam = 'ITE_OBRNFE') and (fCfgSis('NFEPEP', varBoolean)) Then
            Begin
              strUpdObrNfe := '';
              strUpdObrNfe := strUpdObrNfe + 'UPDATE ';
              strUpdObrNfe := strUpdObrNfe + '  ITEGER ';
              strUpdObrNfe := strUpdObrNfe + 'SET ';
              strUpdObrNfe := strUpdObrNfe + '  ITE_OBRNFE = ' + QuotedStr(fldCampoNovo.AsString) + ' ';
              strUpdObrNfe := strUpdObrNfe + 'WHERE ';
              strUpdObrNfe := strUpdObrNfe + '  ITE_CODITE = ' + QuotedStr(FieldByName('ITE_CODITE').AsString) + ' AND ';
              strUpdObrNfe := strUpdObrNfe + '  ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';
            End
            Else If arrCamposGrid[intContador].strNomCam = 'ITE_SITPRO' Then
            Begin
              strUpdSitPro := '';
              strUpdSitPro := strUpdSitPro + 'UPDATE ';
              strUpdSitPro := strUpdSitPro + '  ITEGER ';
              strUpdSitPro := strUpdSitPro + 'SET ';
              If fEmptyStr(fldCampoNovo.AsString) Then
                strUpdSitPro := strUpdSitPro + '  ITE_SITPRO = NULL '
              Else
                strUpdSitPro := strUpdSitPro + '  ITE_SITPRO = ' + QuotedStr(fldCampoNovo.AsString) + ' ';
              strUpdSitPro := strUpdSitPro + 'WHERE ';
              strUpdSitPro := strUpdSitPro + '  ITE_CODITE = ' + QuotedStr(FieldByName('ITE_CODITE').AsString) + ' ';
              if (intSitPro = 2) then
                strUpdSitPro := strUpdSitPro + ' AND  ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';
            End
            Else If arrCamposGrid[intContador].strNomCam = 'ITE_TIPPRO' Then
            Begin
              strUpdTipPro := '';
              strUpdTipPro := strUpdTipPro + 'UPDATE ';
              strUpdTipPro := strUpdTipPro + '  ITEGER ';
              strUpdTipPro := strUpdTipPro + 'SET ';
              strUpdTipPro := strUpdTipPro + '  ITE_TIPPRO = ' + QuotedStr(fldCampoNovo.AsString) + ' ';
              strUpdTipPro := strUpdTipPro + 'WHERE ';
              strUpdTipPro := strUpdTipPro + '  ITE_CODITE = ' + QuotedStr(FieldByName('ITE_CODITE').AsString) + ' AND ';
              strUpdTipPro := strUpdTipPro + '  ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';
            End
            Else If (arrCamposGrid[intContador].strNomCam = 'ITE_IPISAI') And (fCfgSis('IPI_IG') = '2') Then
            Begin
              strUpdIpiSai := '';
              strUpdIpiSai := strUpdIpiSai + 'UPDATE ';
              strUpdIpiSai := strUpdIpiSai + '  ITEGER ';
              strUpdIpiSai := strUpdIpiSai + 'SET ';
              strUpdIpiSai := strUpdIpiSai + '  ITE_IPISAI = ' + AnsiReplaceStr(AnsiReplaceStr(fldCampoNovo.AsString, '.', ''), ',','.') + ' ';
              strUpdIpiSai := strUpdIpiSai + 'WHERE ';
              strUpdIpiSai := strUpdIpiSai + '  ITE_CODITE = ' + QuotedStr(FieldByName('ITE_CODITE').AsString) + ' AND ';
              strUpdIpiSai := strUpdIpiSai + '  ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';
            End

            Else If arrCamposGrid[intContador].strNomCam = 'ITE_ABFPIS' Then
            Begin
              strUpdAbfPis := '';
              strUpdAbfPis := strUpdAbfPis + 'UPDATE ';
              strUpdAbfPis := strUpdAbfPis + '  ITEGER ';
              strUpdAbfPis := strUpdAbfPis + 'SET ';
              strUpdAbfPis := strUpdAbfPis + '  ITE_ABFPIS = ' + QuotedStr(fldCampoNovo.AsString) + ' ';
              strUpdAbfPis := strUpdAbfPis + 'WHERE ';
              strUpdAbfPis := strUpdAbfPis + '  ITE_CODITE = ' + QuotedStr(FieldByName('ITE_CODITE').AsString) + ' AND ';
              strUpdAbfPis := strUpdAbfPis + '  ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';
            End
            Else If arrCamposGrid[intContador].strNomCam = 'ITE_ABFCOF' Then
            Begin
              strUpdAbfCof := '';
              strUpdAbfCof := strUpdAbfCof + 'UPDATE ';
              strUpdAbfCof := strUpdAbfCof + '  ITEGER ';
              strUpdAbfCof := strUpdAbfCof + 'SET ';
              strUpdAbfCof := strUpdAbfCof + '  ITE_ABFCOF = ' + QuotedStr(fldCampoNovo.AsString) + ' ';
              strUpdAbfCof := strUpdAbfCof + 'WHERE ';
              strUpdAbfCof := strUpdAbfCof + '  ITE_CODITE = ' + QuotedStr(FieldByName('ITE_CODITE').AsString) + ' AND ';
              strUpdAbfCof := strUpdAbfCof + '  ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';
            End
            Else If arrCamposGrid[intContador].strNomCam = 'ITE_ABFIPI' Then
            Begin
              strUpdAbfIpi := '';
              strUpdAbfIpi := strUpdAbfIpi + 'UPDATE ';
              strUpdAbfIpi := strUpdAbfIpi + '  ITEGER ';
              strUpdAbfIpi := strUpdAbfIpi + 'SET ';
              strUpdAbfIpi := strUpdAbfIpi + '  ITE_ABFIPI = ' + QuotedStr(fldCampoNovo.AsString) + ' ';
              strUpdAbfIpi := strUpdAbfIpi + 'WHERE ';
              strUpdAbfIpi := strUpdAbfIpi + '  ITE_CODITE = ' + QuotedStr(FieldByName('ITE_CODITE').AsString) + ' AND ';
              strUpdAbfIpi := strUpdAbfIpi + '  ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';
            End
            Else If (arrCamposGrid[intContador].strNomCam = 'ITE_ESMIDG') Then
            Begin
                blnEncontrouTPESTM := False;
                For intEncontrouTPESTM := 0 to Length(arrCamposGrid) -1 Do
                Begin
                  If arrCamposGrid[intEncontrouTPESTM].strNomCam = 'ITE_TPESTM' Then
                  Begin
                    blnEncontrouTPESTM := True;
                    Break;
                  End;
                End;
                If not blnEncontrouTPESTM Then
                Begin
                  qryGenTmp.Close;
                  qryGenTmp.SQL.Clear;
                  qryGenTmp.SQL.Add( ' UPDATE ITEGER  ' );
                  qryGenTmp.SQL.Add( '   SET ITE_ESMIDG = :ESMIDG_NEW  ' );
                  qryGenTmp.SQL.Add( ' WHERE ITE_CODITE = :CODITE  ' );

                  If Not blnEsmIlj Then
                    qryGenTmp.SQL.Add( ' AND ITE_CODEMP = :CODEMP  ' );

                  qryGenTmp.ParamByName('ESMIDG_NEW').AsString := fldCampoNovo.AsString;
                  qryGenTmp.ParamByName('CODITE').AsString := FieldByName('ITE_CODITE').AsString;

                  If Not blnEsmIlj Then
                    qryGenTmp.ParamByName('CODEMP').AsString := VS_strCodEmp;

                  qryGenTmp.ExecSQL;
                  qryGenTmp.Close;

                  qryGenTmp.Close;
                  qryGenTmp.SQL.Clear;
                  qryGenTmp.SQL.Add( ' UPDATE ITEGER  ' );
                  qryGenTmp.SQL.Add( '   SET ITE_TPESTM = IF(ITE_ESMIDG = "G", "", IF(ITE_ESMIDG = "D", "D", "")) ' );
                  qryGenTmp.SQL.Add( ' WHERE ITE_CODITE = :CODITE  ' );

                  If Not blnEsmIlj Then
                    qryGenTmp.SQL.Add( ' AND ITE_CODEMP = :CODEMP  ' );

                  qryGenTmp.ParamByName('CODITE').AsString := FieldByName('ITE_CODITE').AsString;

                  If Not blnEsmIlj Then
                    qryGenTmp.ParamByName('CODEMP').AsString := VS_strCodEmp;

                  qryGenTmp.ExecSQL;
                  qryGenTmp.Close;
                End;
            End
            Else If (arrCamposGrid[intContador].strNomCam = 'ITE_TPESTM') Then
            Begin
                blnEncontrouESMIDG := False;
                For intEncontrouESMIDG := 0 to Length(arrCamposGrid) -1 Do
                Begin
                  If arrCamposGrid[intEncontrouESMIDG].strNomCam = 'ITE_ESMIDG' Then
                  Begin
                    blnEncontrouESMIDG := True;
                    Break;
                  End;
                End;
                If blnEncontrouESMIDG Then
                Begin
                  qryGenTmp.SQL.Clear;
                  qryGenTmp.SQL.Add( ' UPDATE ITEGER  ' );
                  qryGenTmp.SQL.Add( '   SET ITE_ESMIDG = :ESMIDG_NEW  ' );
                  qryGenTmp.SQL.Add( ' WHERE ITE_CODITE = :CODITE  ' );

                  If Not blnEsmIlj Then
                    qryGenTmp.SQL.Add( ' AND ITE_CODEMP = :CODEMP  ' );

                  qryGenTmp.ParamByName('ESMIDG_NEW').AsString := IfThen(Trim(fldCampoNovo.AsString) = '', 'G', FieldByName('ITE_ESMIDG_NOV').AsString);
                  qryGenTmp.ParamByName('CODITE').AsString := FieldByName('ITE_CODITE').AsString;

                  If Not blnEsmIlj Then
                    qryGenTmp.ParamByName('CODEMP').AsString := VS_strCodEmp;

                  qryGenTmp.ExecSQL;
                  qryGenTmp.Close;
                End Else
                Begin
                  If Trim(fldCampoNovo.AsString) = '' Then
                  Begin
                    qryGenTmp.SQL.Clear;
                    qryGenTmp.SQL.Add( ' UPDATE ITEGER  ' );
                    qryGenTmp.SQL.Add( '   SET ITE_ESMIDG = :ESMIDG_NEW  ' );
                    qryGenTmp.SQL.Add( ' WHERE ITE_CODITE = :CODITE  ' );

                    If Not blnEsmIlj Then
                      qryGenTmp.SQL.Add( ' AND ITE_CODEMP = :CODEMP  ' );

                    qryGenTmp.ParamByName('ESMIDG_NEW').AsString := 'G';
                    qryGenTmp.ParamByName('CODITE').AsString := FieldByName('ITE_CODITE').AsString;

                    If Not blnEsmIlj Then
                      qryGenTmp.ParamByName('CODEMP').AsString := VS_strCodEmp;

                    qryGenTmp.ExecSQL;
                    qryGenTmp.Close;
                  End;
                End;

                qryGenTmp.Close;
                qryGenTmp.SQL.Clear;
                qryGenTmp.SQL.Add( ' UPDATE ITEGER  ' );
                qryGenTmp.SQL.Add( '   SET ITE_TPESTM = IF(ITE_ESMIDG = "G", "", IF(ITE_ESMIDG = "D", :TPESTM_NEW, "")) ' );
                qryGenTmp.SQL.Add( ' WHERE ITE_CODITE = :CODITE  ' );

                If Not blnEsmIlj Then
                  qryGenTmp.SQL.Add( ' AND ITE_CODEMP = :CODEMP  ' );

                qryGenTmp.ParamByName('TPESTM_NEW').AsString := fldCampoNovo.AsString;
                qryGenTmp.ParamByName('CODITE').AsString := FieldByName('ITE_CODITE').AsString;

                If Not blnEsmIlj Then
                  qryGenTmp.ParamByName('CODEMP').AsString := VS_strCodEmp;

                qryGenTmp.ExecSQL;
                qryGenTmp.Close;
            End
            Else If (arrCamposGrid[intContador].strNomCam = 'ITE_ESTMAX') Then
            Begin
              blnEstMax := fldCampo.Value <> fldCampoNovo.Value;
              fltEstMax := fldCampoNovo.Value;

              strUpdIteGerEstMAX := '';
              strUpdIteGerEstMAX := strUpdIteGerEstMAX + 'UPDATE ';
              strUpdIteGerEstMAX := strUpdIteGerEstMAX + '  ITEGER ';
              strUpdIteGerEstMAX := strUpdIteGerEstMAX + 'SET ';
              strUpdIteGerEstMAX := strUpdIteGerEstMAX + '  ITE_ESTMAX = ' + QuotedStr(fldCampoNovo.AsString) + ' ';
              strUpdIteGerEstMAX := strUpdIteGerEstMAX + 'WHERE ';
              strUpdIteGerEstMAX := strUpdIteGerEstMAX + '  ITE_CODITE = ' + QuotedStr(FieldByName('ITE_CODITE').AsString) + ' AND ';
              strUpdIteGerEstMAX := strUpdIteGerEstMAX + '  ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';

            End
            Else If (arrCamposGrid[intContador].strNomCam = 'ITE_ESTMIN') Then
            Begin
              blnEstMin := fldCampo.Value <> fldCampoNovo.Value;
              fltEstMin := fldCampoNovo.Value;

              strUpdIteGerEstMIN := '';
              strUpdIteGerEstMIN := strUpdIteGerEstMIN + 'UPDATE ';
              strUpdIteGerEstMIN := strUpdIteGerEstMIN + '  ITEGER ';
              strUpdIteGerEstMIN := strUpdIteGerEstMIN + 'SET ';
              strUpdIteGerEstMIN := strUpdIteGerEstMIN + '  ITE_ESTMIN = ' + QuotedStr(fldCampoNovo.AsString) + ' ';
              strUpdIteGerEstMIN := strUpdIteGerEstMIN + 'WHERE ';
              strUpdIteGerEstMIN := strUpdIteGerEstMIN + '  ITE_CODITE = ' + QuotedStr(FieldByName('ITE_CODITE').AsString) + ' AND ';
              strUpdIteGerEstMIN := strUpdIteGerEstMIN + '  ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';
            End;

            If (arrCamposGrid[intContador].strNomArq = 'CADITE') Or ((arrCamposGrid[intContador].strNomCam = 'ITE_SITPRO') And (intSitPro = 1)) Then
            Begin

              if (arrCamposGrid[intContador].strNomCam = 'ITE_REFERE') Then
                strRefere := fldCampo.AsString;

              if (arrCamposGrid[intContador].strNomCam = 'ITE_CODUNI') Then
                strCodUni := fldCampo.AsString;

              blnAltCadIte := True;

              strUpdCadIte := strUpdCadIte + ' ' + fldCampo.FieldName + ' = ';

              If (Pos(fldCampo.FieldName,
                  'ITE_CODMON_ITE_CODABF_ITE_ABFPIS_ITE_ABFCOF_ITE_ABFIPI_ITE_GRUCMP_ITE_CODDIC_ITE_CDCEST_ITE_SITPRO') > 0) And
                 fEmptyStr(fldCampoNovo.AsString) Then
                strUpdCadIte := strUpdCadIte + ' NULL '

              Else If fldCampo.FieldName = 'ITE_APLICA' Then
                strUpdCadIte := strUpdCadIte + QuotedStr(AnsiReplaceStr(fldCampoNovo.AsString, #13#10, '<<csq>>'))

              Else If fldCampo.DataType In [ftString, ftMemo] Then
                strUpdCadIte := strUpdCadIte + QuotedStr(fldCampoNovo.AsString)

              Else
                strUpdCadIte := strUpdCadIte + AnsiReplaceStr(fldCampoNovo.AsString, ',', '.');

              If intContador < intTamMat -1 Then
                strUpdCadIte := strUpdCadIte + ',';

            End
            Else If arrCamposGrid[intContador].strNomArq = 'ITEMON' Then
            Begin
              pGravaMontadoras(FieldByName('ITE_CODITE').AsString,
                               FieldByName('ITE_CODMON_NOV').AsString,
                               qryGenTmp);
            End

            Else If (arrCamposGrid[intContador].strNomArq = 'ITEGER') And
                    (arrCamposGrid[intContador].strNomCam <> 'ITE_LOCFIS') And
                    (arrCamposGrid[intContador].strNomCam <> 'ITE_IMPLIS') And
                    (arrCamposGrid[intContador].strNomCam <> 'ITE_APERET') And
                    (arrCamposGrid[intContador].strNomCam <> 'ITE_APEENT') And
                    (arrCamposGrid[intContador].strNomCam <> 'ITE_PONEXP') And
                    (arrCamposGrid[intContador].strNomCam <> 'ITE_ESMIDG') And
                    (arrCamposGrid[intContador].strNomCam <> 'ITE_TPESTM') And
                    (arrCamposGrid[intContador].strNomCam <> 'ITE_ESTMIN') And
                    (arrCamposGrid[intContador].strNomCam <> 'ITE_ESTMAX') And
                    IIF(fCfgSis('IPI_IG') = '2', arrCamposGrid[intContador].strNomCam <> 'ITE_IPISAI', True) And
                    IIF(fCfgSis('SITEMP') = '1', arrCamposGrid[intContador].strNomCam <> 'ITE_SITPRO', True) And
                    IIF(fCfgSis('TPSPED') = '2', arrCamposGrid[intContador].strNomCam <> 'ITE_TIPPRO', True) And
                    IIF(fCfgSIs('TIPABF') = '2', arrCamposGrid[intContador].strNomCam <> 'ITE_CODABF', True) And
                    IIF(fCfgSIs('TPABPC') = '2', arrCamposGrid[intContador].strNomCam <> 'ITE_ABFPIS', True) And
                    IIF(fCfgSIs('TPABPC') = '2', arrCamposGrid[intContador].strNomCam <> 'ITE_ABFCOF', True) And
                    IIF(fCfgSIs('TPABPC') = '2', arrCamposGrid[intContador].strNomCam <> 'ITE_ABFIPI', True) Then
            Begin
              blnAltIteGer := True;

              if (fldCampo.FieldName = 'ITE_PERVDA') then
                strUpdIteGer := strUpdIteGer + ' ITE_PEVNDA = '
              else
                strUpdIteGer := strUpdIteGer + ' ' + fldCampo.FieldName + ' = ';

              strUpdDetCus := strUpdDetCus + fRetSQLUpdateCampoDetCus(fldCampo.FieldName, fldCampoNovo.FieldName);

              If (blnCprInd) And SameText(fldCampo.FieldName, 'ITE_CPRCEN') Then
                strUpdIteGer := strUpdIteGer + ' IF(ITE_CODEMP = :EMPLOG, ' + QuotedStr(fldCampoNovo.AsString) + ', ITE_CPRCEN) '

              Else If fldCampo.DataType in [ftString, ftMemo] Then
              Begin
                If SameText(fldCampo.FieldName, 'ITE_MLTRCA') Then
                  strUpdIteGer := strUpdIteGer + QuotedStr(Copy(fldCampoNovo.AsString,1,1))
                Else
                  strUpdIteGer := strUpdIteGer + QuotedStr(fldCampoNovo.AsString)
              End

              Else If blnInfMat And (intInfSai = 1) And (fldCampo.FieldName = 'ITE_ICMSAI') Then
                strUpdIteGer := strUpdIteGer + ' IF(ITE_CODEMP = :EMPLOG, ' + AnsiReplaceStr(fldCampoNovo.AsString, ',', '.') + ', ' + fldCampo.FieldName + ') '

              Else If blnInfMat And (intInfFed = 1)  And (fldCampo.FieldName = 'ITE_IMPFED') Then
                strUpdIteGer := strUpdIteGer + ' IF(ITE_CODEMP = :EMPLOG, ' + AnsiReplaceStr(fldCampoNovo.AsString, ',', '.') + ', ' + fldCampo.FieldName + ') '

              Else If blnInfMat And (intInfOpe = 1) And (fldCampo.FieldName = 'ITE_DESOPE') Then
                strUpdIteGer := strUpdIteGer + ' IF(ITE_CODEMP = :EMPLOG, ' + AnsiReplaceStr(fldCampoNovo.AsString, ',', '.') + ', ' + fldCampo.FieldName + ') '

              Else If (Pos(fldCampo.FieldName, 'ITE_DTAVAL') > 0) Then
              Begin
                If Not fEmptyStr(fldCampoNovo.AsString) Then
                  strUpdIteGer := strUpdIteGer + '"' + FormatDateTime('yyyy-mm-dd', fldCampoNovo.AsDateTime)+ '"'
                Else
                  strUpdIteGer := strUpdIteGer + ' NULL ';
              End
              Else
              Begin
                If (fldCampoNovo.DataType = ftFloat) And (fldCampoNovo.AsString = '') Then
                  strUpdIteGer := strUpdIteGer + '0'
                Else
                  strUpdIteGer := strUpdIteGer + AnsiReplaceStr(fldCampoNovo.AsString, ',', '.');
              End;

              If intContador < intTamMat -1 Then
                strUpdIteGer := strUpdIteGer + ',';

             // strUpdIteGerCustos
              If Pos(fldCampo.FieldName, STR_CAMPOS_CUSTOS_INFMAT) > 0 Then
              Begin
                blnAltIteGerCustos := True;

                strUpdIteGerCustos := strUpdIteGerCustos + ' ' + fldCampo.FieldName + ' = ';

                If fldCampo.DataType in [ftString, ftMemo] Then
                  strUpdIteGerCustos := strUpdIteGerCustos + QuotedStr(fldCampoNovo.AsString)

                // NUNCA VAI ENTRAR AQUI POIS ESSES CAMPOS NÃO ESTÃO NO STR_CAMPOS_CUSTOS_INFMAT
                Else If blnInfMat And (intInfSai = 1) And (fldCampo.FieldName =  'ITE_ICMSAI') Then
                  strUpdIteGerCustos := strUpdIteGerCustos + ' IF(ITE_CODEMP = :EMPLOG, ' + AnsiReplaceStr(fldCampoNovo.AsString, ',', '.') + ', ' + fldCampo.FieldName + ') '

                Else If blnInfMat And (intInfFed = 1) And (fldCampo.FieldName = 'ITE_IMPFED') Then
                  strUpdIteGerCustos := strUpdIteGerCustos + ' IF(ITE_CODEMP = :EMPLOG, ' + AnsiReplaceStr(fldCampoNovo.AsString, ',', '.') + ', ' + fldCampo.FieldName + ') '

                Else If blnInfMat And (intInfOpe = 1) And (fldCampo.FieldName = 'ITE_DESOPE') Then
                  strUpdIteGerCustos := strUpdIteGerCustos + ' IF(ITE_CODEMP = :EMPLOG, ' + AnsiReplaceStr(fldCampoNovo.AsString, ',', '.') + ', ' + fldCampo.FieldName + ') '
                ////////

                Else
                  strUpdIteGerCustos := strUpdIteGerCustos + AnsiReplaceStr(fldCampoNovo.AsString, ',', '.');

                If intContador < intTamMat -1 Then
                  strUpdIteGerCustos := strUpdIteGerCustos + ',';

              End;

            End
            Else If arrCamposGrid[intContador].strNomArq = 'DESSIT' tHEN
            Begin

              If Not blnValidouRegistroNaTabelaDESSIT Then
                pValidaRegistroNaTabelaDESSIT(FieldByName('ITE_CODITE').AsString);

              blnAltDessit := True;

              IF fldCampo.FieldName =  'EC_ITE_DESITE' Then
                 strUpdDessit := strUpdDessit + ' ITE_DESITE = '
              Else
              strUpdDessit := strUpdDessit + ' ' + fldCampo.FieldName + ' = ';

              If fldCampo.DataType In [ftString, ftMemo] Then
                strUpdDessit := strUpdDessit + QuotedStr(fldCampoNovo.AsString)

              Else
                strUpdDessit := strUpdDessit + AnsiReplaceStr(fldCampoNovo.AsString, ',', '.');

              If intContador < intTamMat -1 Then
                strUpdDessit := strUpdDessit + ',';

            End;

            If (arrCamposGrid[intContador].strNomArq = 'COMITE') And
               (fldCampo.Value <> fldCampoNovo.Value) Then
            Begin
              pGravaIteCom(FieldByName('ITE_CODITE').AsString,
                          RightStr(arrCamposGrid[intContador].strNomCam, 1),
                          LeftStr(arrCamposGrid[intContador].strNomCam, 10),
                          fldCampoNovo.Value);
            End;

          End;

        End;

        If RightStr(strUpdCadIte, 1) = ',' Then
          strUpdCadIte := Copy(strUpdCadIte, 1, Length(strUpdCadIte)-1);

        If RightStr(strUpdIteGer, 1) = ',' Then
          strUpdIteGer := Copy(strUpdIteGer, 1, Length(strUpdIteGer)-1);

        If RightStr(strUpdIteGerCustos, 1) = ',' Then
          strUpdIteGerCustos := Copy(strUpdIteGerCustos, 1, Length(strUpdIteGerCustos)-1);

        If RightStr(strUpdDessit, 1) = ',' Then
          strUpdDessit := Copy(strUpdDessit, 1, Length(strUpdDessit)-1);

        strUpdCadIte := strUpdCadIte + ' WHERE ';
        strUpdCadIte := strUpdCadIte + '  ITE_CODITE = :CODITE ';

        strUpdIteGer := strUpdIteGer + ' WHERE ';
        strUpdIteGer := strUpdIteGer + '  ITE_CODITE = :CODITE AND ';
        strUpdIteGer := strUpdIteGer + '  LOCATE(ITE_CODEMP, :CODEMP) > 0';

        strUpdIteGerCustos := strUpdIteGerCustos + ' WHERE ';
        strUpdIteGerCustos := strUpdIteGerCustos + '  ITE_CODITE = :CODITE AND ';
        strUpdIteGerCustos := strUpdIteGerCustos + '  LOCATE(ITE_CODEMP, :CODEMP) = 0';

        strUpdDessit := strUpdDessit + ' WHERE ';
        strUpdDessit := strUpdDessit + '  ITE_CODITE = :CODITE ';

        {*****************************************}
        {* ATUALIZA CADITE                       *}
        {**************************************MV*}
        If blnAltCadIte Then
        Begin

          qryGenTmp.Close;
          qryGenTmp.SQL.Clear;
          qryGenTmp.SQL.Add(strUpdCadIte);
          qryGenTmp.ParamByName('CODITE').AsString := FieldByName('ITE_CODITE').AsString;
          qryGenTmp.ExecSQL;
          qryGenTmp.Close;

          fAtualizaBarFabIte(FieldByName('ITE_CODITE').AsString);

          pGravarLogCpr(dtsItens.DataSet, qryLogCpr);

          if Not fEmptyStr(strRefere) or
             Not fEmptyStr(strCodUni) Then
            TAltDes.pSalvaLog(FieldByName('ITE_CODITE').AsString,
                              strLoginUsuarioLogado,
                              '',
                              strRefere,
                              strCodUni);
        End;

        {*****************************************}
        {* ATUALIZA ITEGER                       *}
        {**************************************MV*}
        If blnAltIteGer Then
        Begin

          If (dtaDtaAlt = VS_Date) Then
          Begin

            qryGenTmp.Close;
            qryGenTmp.SQL.Clear;
            qryGenTmp.SQL.Add(strUpdIteGer);
            qryGenTmp.ParamByName('CODITE').AsString := FieldByName('ITE_CODITE').AsString;
            qryGenTmp.ParamByName('CODEMP').AsString := strEmpresas;

            If qryGenTmp.Params.FindParam('EMPLOG') <> Nil Then
              qryGenTmp.ParamByName('EMPLOG').AsString := VS_strCodEmp;

            qryGenTmp.ExecSQL;


            If Not fEmptyStr(strUpdDetCus) Then
            begin
              qryGenTmp.SQL.Clear;
              qryGenTmp.SQL.Add(strUpdDetCus);
              qryGenTmp.ExecSQL;
            End;

            qryGenTmp.Close;

          End
          Else
          Begin
            If Not fCfgSis('TABDIN', varBoolean) Or blnPorDta Then
              pIncluiPreIte(qryGenIte, dtsItens.DataSet, dtaDtaAlt, 'ALTERACAO GLOBAL DE PRECOS', strProPri, blnAltFornecedor)
            Else
              pIncluiIteTab(qryGenIte, dtsItens.DataSet, 'ALTERACAO GLOBAL DE PRECOS', strNomTab, strCodTabDin);
          End;

        End;

        If blnAltIteGerCustos And (dtaDtaAlt = VS_Date) And blnInfMat Then
        Begin

          If fEhEmpresaResponsavelFornecedor(FieldByName('ITE_CODFOR').AsString) Then
          Begin
            qryGenTmp.Close;
            qryGenTmp.SQL.Clear;
            qryGenTmp.SQL.Add(strUpdIteGerCustos);
            qryGenTmp.ParamByName('CODITE').AsString := FieldByName('ITE_CODITE').AsString;
            qryGenTmp.ParamByName('CODEMP').AsString := strEmpresas;
            qryGenTmp.ExecSQL;
            qryGenTmp.Close;


            pRecalculaItensResponsavelFornecedor(strEmpresas, FieldByName('ITE_CODITE').AsString, True);
          End;

          pRecalculaItensResponsavelFornecedor(strEmpresas, FieldByName('ITE_CODITE').AsString, False);
        End;

        {*****************************************}
        {* ATUALIZA DESSIT                       *}
        {**************************************LS*}
        If blnAltDessit Then
        Begin

          qryGenTmp.Close;
          qryGenTmp.SQL.Clear;
          qryGenTmp.SQL.Add(strUpdDessit);
          qryGenTmp.ParamByName('CODITE').AsString := FieldByName('ITE_CODITE').AsString;
          qryGenTmp.ExecSQL;
          qryGenTmp.Close;

        End;

        If (Not fEmptyStr(strImpLis)) Then
        Begin
          pAtualizaImpLisLojas(strImpLis, FieldByName('ITE_CODITE').AsString);
        End;

        If (Not fEmptyStr(strApeRet)) Then
        Begin
          pAtualizaApeRetLojas(strApeRet, FieldByName('ITE_CODITE').AsString);
        End;

        If (Not fEmptyStr(strApeEnt)) Then
        Begin
          pAtualizaApeEntLojas(strApeEnt, FieldByName('ITE_CODITE').AsString);
        End;

        {*****************************************}
        {* ATUALIZA LOCALIZAÇÃO FÍSICA           *}
        {**************************************MV*}
        If Not fEmptyStr(strUpdLocFis) Then
        Begin
          qryGenTmp.Close;
          qryGenTmp.SQL.Clear;
          qryGenTmp.SQL.Add(strUpdLocFis);
          qryGenTmp.ExecSQL;
          qryGenTmp.Close;

          If (FindField('ITE_LOCFIS') <> Nil) And fGeraLogLocFis(FieldByName('ITE_LOCFIS').AsString, FieldByName('ITE_LOCFIS_NOV').AsString) Then
          Begin
            If (Not fGravaLogLocFisica(FieldByName('ITE_CODITE').AsString,
                                       FieldByName('ITE_LOCFIS').AsString,
                                       FieldByName('ITE_LOCFIS_NOV').AsString, 1, '')) Then
            Begin
              Result := False;
              Exit;
            End;
          End;

        End;

        If blnPonExp And ((FindField('ITE_PONEXP') <> Nil) And (FieldByName('ITE_PONEXP').AsFloat <> FieldByName('ITE_PONEXP_NOV').AsFloat)) Then
        Begin
          pAtualizaPontoExposicao(nil,
                                  FieldByName('ITE_CODITE').AsString,
                                  strLoginUsuarioLogado,
                                  VS_StrCodEmp,
                                  FieldByName('ITE_PONEXP').AsFloat,
                                  FieldByName('ITE_PONEXP_NOV').AsFloat);
        End;

        If (FindField('ITE_LOCSUP') <> Nil) And fGeraLogLocFis(FieldByName('ITE_LOCSUP').AsString, FieldByName('ITE_LOCSUP_NOV').AsString) Then
        Begin
          If (Not fGravaLogLocFisica(FieldByName('ITE_CODITE').AsString,
                                     FieldByName('ITE_LOCSUP').AsString,
                                     FieldByName('ITE_LOCSUP_NOV').AsString, 2, '')) Then
          Begin
            Result := False;
            Exit;
          End;
        End;

        {*****************************************}
        {* ATUALIZA CODABF SE FOR POR EMPRESA    *}
        {**************************************AF*}
        If (Not fEmptyStr(strUpdCodAbf)) Then
        Begin
          qryGenTmp.Close;
          qryGenTmp.SQL.Clear;
          qryGenTmp.SQL.Add(strUpdCodAbf);
          qryGenTmp.ExecSQL;
          qryGenTmp.Close;
        End;

        If (Not fEmptyStr(strUpdCodAbf)) Then
        Begin
          pBloquearLiberarProdutoParaVendaEmTodasEmpresasQueUsamEssePreco(FieldByName('ITE_CODITE').AsString, 'N');
        End;

        If (Not fEmptyStr(strUpdObrNfe)) And (fCfgSis('NFEPEP', varBoolean)) Then
        Begin
          qryGenTmp.Close;
          qryGenTmp.SQL.Clear;
          qryGenTmp.SQL.Add(strUpdObrNfe);
          qryGenTmp.ExecSQL;
          qryGenTmp.Close;
        End;

        If (Not fEmptyStr(strUpdTipPro)) And (fCfgSis('TPSPED') = '2') Then
        Begin
          qryGenTmp.Close;
          qryGenTmp.SQL.Clear;
          qryGenTmp.SQL.Add(strUpdTipPro);
          qryGenTmp.ExecSQL;
          qryGenTmp.Close;
        End;

        If (Not fEmptyStr(strUpdIpiSai)) And (fCfgSis('IPI_IG') = '2') Then
        Begin
          qryGenTmp.Close;
          qryGenTmp.SQL.Clear;
          qryGenTmp.SQL.Add(strUpdIpiSai);
          qryGenTmp.ExecSQL;
          qryGenTmp.Close;
        End;


        If (Not fEmptyStr(strUpdSitPro)) Then
        Begin
          qryGenTmp.Close;
          qryGenTmp.SQL.Clear;
          qryGenTmp.SQL.Add(strUpdSitPro);
          qryGenTmp.ExecSQL;
          qryGenTmp.Close;
        End;

        If (Not fEmptyStr(strUpdAbfPis)) And (fCfgSis('TPABPC') = '2') Then
        Begin
          qryGenTmp.Close;
          qryGenTmp.SQL.Clear;
          qryGenTmp.SQL.Add(strUpdAbfPis);
          qryGenTmp.ExecSQL;
          qryGenTmp.Close;
        End;

        If (Not fEmptyStr(strUpdAbfCof)) And (fCfgSis('TPABPC') = '2') Then
        Begin
          qryGenTmp.Close;
          qryGenTmp.SQL.Clear;
          qryGenTmp.SQL.Add(strUpdAbfCof);
          qryGenTmp.ExecSQL;
          qryGenTmp.Close;
        End;

        If (Not fEmptyStr(strUpdAbfIpi)) And (fCfgSis('TPABPC') = '2') Then
        Begin
          qryGenTmp.Close;
          qryGenTmp.SQL.Clear;
          qryGenTmp.SQL.Add(strUpdAbfIpi);
          qryGenTmp.ExecSQL;
          qryGenTmp.Close;
        End;


        {********************************************}
        {* GRAVA LOG EST. MIN. E MAX QUANDO ALTERADO*}
        {*****************************************GB*}
        If (blnEstMin or blnEstMax) Then
        Begin
          TAltEst.fGravaLog(Self,
                            FieldByName('ITE_CODITE').AsString,
                            VS_strCodEmp,
                            fltEstMin,
                            fltEstMax,
                            blnEstMin,
                            blnEstMax
                            );
        End;

        If (Not fEmptyStr(strUpdIteGerEstMAX)) Then
        Begin
          qryGenTmp.Close;
          qryGenTmp.SQL.Clear;
          qryGenTmp.SQL.Add(strUpdIteGerEstMAX);
          qryGenTmp.ExecSQL;
          qryGenTmp.Close;
        End;

        If (Not fEmptyStr(strUpdIteGerEstMIN)) Then
        Begin
          qryGenTmp.Close;
          qryGenTmp.SQL.Clear;
          qryGenTmp.SQL.Add(strUpdIteGerEstMIN);
          qryGenTmp.ExecSQL;
          qryGenTmp.Close;
        End;

        {*****************************************}
        {* GRAVA PREALT                          *}
        {**************************************MV*}
        If dtaDtaAlt = VS_Date Then
        Begin
          If (fTemCampoPreco) Then
            pBloquearLiberarProdutoParaVendaEmTodasEmpresasQueUsamEssePreco(FieldByName('ITE_CODITE').AsString, 'S');
          If blnGeral Then
            strCodEmpCalc := FieldByName('ITE_CODEMP').AsString;
          If (Not VS_blnPreAltViaTrigger) Then
          Begin
            If strAutoPreAlt.IsEmpty Then
              strAutoPreAlt := fRetAutoIncrem('PREALT', VS_strCodEmp, dtsItens.DataSet.RecordCount);

            fGravaPreAlt(FieldByName('ITE_CODITE').AsString,
                       fltCusAnt, fltCusAtu,
                       fltVe1Ant, fltVe1Atu,
                       fltMa1Ant, fltMa1Atu,
                       fltVe2Ant, fltVe2Atu,
                       fltMa2Ant, fltMa2Atu,
                       fltVe3Ant, fltVe3Atu,
                       fltMa3Ant, fltMa3Atu,
                       fltVe4Ant, fltVe4Atu,
                       fltMa4Ant, fltMa4Atu,
                       fltVe5Ant, fltVe5Atu,
                       fltMa5Ant, fltMa5Atu,
                       fltVe6Ant, fltVe6Atu,
                       fltMa6Ant, fltMa6Atu,
                       fltVe7Ant, fltVe7Atu,
                       fltMa7Ant, fltMa7Atu,
                       fltComAnt, fltComAtu,
                       iif(blnGeral, 'ALTERAÇÃO GERAL DE PREÇOS', 'ALTERACAO GLOBAL DE PRECOS'),
                       Nil,
                       strCodEmpCalc,
                       strLoginUsuarioLogado,
                       strAutoPreAlt);

            strAutoPreAlt := fNextAutoIncrem(strAutoPreAlt);
          End;

          pAtualizaItensGrupoPrecos(FieldByName('ITE_CODITE').AsString,
                       iif(blnGeral, 'ALTERAÇÃO GERAL DE PREÇOS', 'ALTERACAO GLOBAL DE PRECOS'), strAgrupadorPreAlt, dtaDtaAlt);
        End;

        {*****************************************}
        {* ATUALIZA ULTIMA ATUALIZAÇÃO DO CADITE *}
        {**************************************PE*}
        pAtualizaUltimaAlteracaoItem(qryGenTmp, FieldByName('ITE_CODITE').AsString, dtaDtaAlt);

        If blnExistePrecoPautaFiscal Then
        Begin
          pDeletaPrecoPautaFiscal(FieldByName('ITE_CODITE').AsString);
          pCadastraPrecoPautaFiscal(FieldByName('ITE_CODITE').AsString);
        End;

        //pgbProgresso.StepBy(1);
        //Application.ProcessMessages;
        fCommit;
        Next;

        pgbProgresso2.Position := pgbProgresso2.Position + 1;

        If (intAtualiza = 0) Or (Trunc(pgbProgresso2.Position) Mod intAtualiza = 0) Then
          Application.ProcessMessages;
      End;

      pDeletaAtualizaTabPre((fCfgSis('PRF_AE', varString) = 'E') And fCfgSis('PRFEFE', varBoolean));

     // pgbProgresso.Position := 0;
     // pgbProgresso.Visible := False;
      Filtered := False;
      EnableControls;

    Except
      On E: Exception Do
      Begin
        fRollBack;
        Filtered := False;
        EnableControls;
        Result := False;
        VS_blnGravaLogTransacao := True;
        VS_GravaUsuRep := 'S';

        pMensagensErro(E.Message, '[fConfirmaItens]');
      End;

    End;
  End;
  strAgrupadorPreAlt := '';

  VS_blnGravaLogTransacao := True;
  VS_GravaUsuRep := 'S';

  FreeAndNil(qryGenEmp);
  FreeAndNil(qryGenTmp);
  FreeAndNil(qryLogCpr);
  FreeAndNil(stlEmpFilial);
end;

Function TfrmAltPrecoGlobalItens.fTemCampoPreco: Boolean;
  Var
    intContador,
    intTamMat: Integer;
Begin
  Result := False;

  intTamMat := Length(arrCamposGrid);

  For intContador := 0 To intTamMat -1 Do
  Begin

    If (Not fEmptyStr(arrCamposGrid[intContador].strNomCam)) And
       (Pos(arrCamposGrid[intContador].strNomCam, STRCAMNOV) > 0) Then
    Begin
      Result := True;
      Exit;
    End;
    
  End;
  
End;

Function TfrmAltPrecoGlobalItens.fConfirmaData: Boolean;
  Var
    strMensagem: String;
Begin
  If Not fTemCampoPreco Then
  Begin
    dtaDtaAlt := VS_Date;
    blnPorDta := False;
    Result    := True;
    Exit;
  End;

  Result := False;
  
  pCriarFormularios(TfrmAltPrecoDigData, frmAltPrecoDigData);

  frmAltPrecoDigData.ShowModal;

  If frmAltPrecoDigData.blnConfirma Then
  Begin
    If fCfgSis('TABDIN', varBoolean) Then
    Begin
      If frmAltPrecoDigData.rdbDtaPre.Checked Then
      Begin
        If (frmAltPrecoDigData.dtaData = VS_Date) Then
          strMensagem := 'Os preços serão alterados imediatamente. Confirma?'
        Else
          strMensagem := 'Os preços serão alterados no dia '+ DateToStr(frmAltPrecoDigData.dtaData) + '. Confirma?';
      End
      Else
      Begin
        strNomTab   := frmAltPrecoDigData.edtDescri.Text;
        strMensagem := 'Confirma a criação da Tabela "' + strNomTab + '"?';
      End;
    End
    Else
    Begin
      If (frmAltPrecoDigData.dtaData = VS_Date) Then
        strMensagem := 'Os preços serão alterados imediatamente. Confirma?'
      Else
        strMensagem := 'Os preços serão alterados no dia '+ DateToStr(frmAltPrecoDigData.dtaData) + '. Confirma?';
    End;
    Result := fMensagem('Confirmação' ,strMensagem, ['&Sim','&Não']) = 1;
  End;

  dtaDtaAlt := frmAltPrecoDigData.dtaData;
  blnPorDta := frmAltPrecoDigData.blnPorDta;

  FreeAndNil(frmAltPrecoDigData);
End;

Function TfrmAltPrecoGlobalItens.fTemItemParaAlterar: Boolean;
Begin
  Result := TfrmGravando.fExecuta(fTemItemParaAlterarPrg, frmGravando, 'Verificando itens marcados, aguarde...', False);
End;

Function TfrmAltPrecoGlobalItens.fTemItemParaAlterarPrg(cxProgressBar: TcxProgressBar): Boolean;
Begin
  Result := False;
  dtsItens.DataSet.DisableControls;
  dtsItens.DataSet.First;
  While Not dtsItens.DataSet.Eof Do
  Begin
    If dtsItens.DataSet.FieldByName('ITE_MARDES').AsString = 'M' Then
    Begin
      Result := True;
      Break;
    End;
    dtsItens.Dataset.Next;
  End;
  dtsItens.DataSet.EnableControls;
End;

{ Ao adicionar função/rotinas aqui,                                                                                                    }
{ Verificar se não irá gerar erro pela rotina 'Alteração Geral de Preços de Produtos Para Lojas (mnuAlteracaoGeraldePrecosdeProdutos)' }
{ untAlteracaoGeraldePrecosdeProdutos ALTGLO = S                                                                                      }
procedure TfrmAltPrecoGlobalItens.btnConfirmaClick(Sender: TObject);

  Function fConfirmar: boolean;
  Begin
    If (blnTemMargemBrutaNegativa) Then
      Result := (fMensagem('Confirmação' ,'Existe Margem Bruta Negativa, Confirma alteração?', ['&Sim','&Não']) = 1)
    Else If blnTemPrecoVendaNegativo Then
      Result := (fMensagem('Confirmação' ,'Existem um ou mais itens com o preço de venda negativo, estes não serão atualizados. Confirma alteração?', ['&Sim','&Não']) = 1)
    Else
      Result := fMensagem('', 'Confirma Itens?', ['&Sim', '&Não']) = 1;
  End;

begin
  inherited;

  If Trim(strLoginUsuarioLogado) = '997' Then
  Begin
    fMensagem('', 'Operador 997 não possui autorização para realizar este tipo de alteração.', ['&O k']);
    Exit;
  End;

  If Not fTemItemParaAlterar Then
  Begin
    fMensagem('', 'Não há itens marcados para serem alterados!', ['&O k']);
    Exit;
  End;

  If (Not btnConfirma.Enabled) Then
    Exit;
  If blnValidaPrevenMargem Then
  If fCfgSis('MARNEG', varBoolean) Then
  Begin
    If  Not TProdMargemNegativa.fLiberaMargemNegativa(dtsItens.DataSet, dtsItens.DataSet, rotAltPrecoGlobal) Then
      Exit;
  End;

  If (Not fConfirmar) Then
  Begin
    pSetFocus(Self);
    Exit;
  End;

  If fPedeLiberacaoPrecoCustoReal Then
    If Not objLiberacao.fLibera Then
       Exit;

  If blnGeral or fCfgSis('TABPRD', varBoolean) Then
  Begin
    dtaDtaAlt := VS_Date;
    blnPorDta := False;
  End
  Else If Not fConfirmaData Then
  Begin
    pSetFocus(Self);
    Exit;
  End;

  If fCfgSis('MONPRC', varBoolean) And (Not blnGeral) Then
  Begin
    objAvisoAlteracaoPreco.FcdsDados := cxvItens.DataController.DataSource.DataSet;
    If Not objAvisoAlteracaoPreco.fVerificaOscilacao(tpAltGlb) Then
      Exit;
  End;

  btnConfirma.Enabled := False;
  btnVoltar.Enabled   := False;

  Screen.Cursor := crHourGlass;

  If fConfirmaItens Then
  Begin
    blnConfirma := True;
    Screen.Cursor := crDefault;
    fMensagem('', 'Alteração dos Itens concluída com sucesso!', ['&O k']);
    Close;
  End;

  btnConfirma.Enabled := True;
  btnVoltar.Enabled   := True;
  Screen.Cursor := crDefault;

end;

procedure TfrmAltPrecoGlobalItens.FormCreate(Sender: TObject);
begin
  inherited;
  blnValidaCustoReal := False;
  blnValidaPrevenMargem := False;
  blnConfirma := False;
  blnTabPrd := False;
  blnTrataTPO := False;

  objAvisoAlteracaoPreco := TAvisoAlteracaoPreco.Create;
  strTIPABF := fCfgSis('TIPABF');
  qryGenIte := fCriaQuery(Self);

  qryPreAlt := fCriarQuery('SELECT * FROM PREALT WHERE FALSE', Self);
  fAbrirTabela(qryPreAlt);

  qryIteCom := fCriarQuery('SELECT * FROM COMITE WHERE COM_CODITE = :CODITE AND COM_TABPRE = :TABPRE', Self);

  cdsEmpresasUsamPrecoMatriz := TZClient.Create(Self, 'SELECT EMP_CODEMP AS CODEMP, CAST(NULL AS CHAR(2000)) AS LISEMP FROM CADEMP WHERE FALSE');
  cdsEmpresasUsamPrecoMatriz.fLeDados('TfrmAltPrecoGlobalItens.FormCreate');
  cdsEmpresasUsamPrecoMatriz.IndexFieldNames := 'CODEMP';
end;

Function TfrmAltPrecoGlobalItens.fGetEmpresasUsamPrecoMatriz(strCodEmp: String): String;
Begin
  If cdsEmpresasUsamPrecoMatriz.FindKey([strCodEmp]) Then
  Begin
    Result := cdsEmpresasUsamPrecoMatriz.FieldByName('LISEMP').AsString
  End Else
  Begin
    Result := fRetEmpresasUsamPrecoMatriz(nil, strCodEmp, ''{strEmpPar}, True{blnSomenteAtivas});

    cdsEmpresasUsamPrecoMatriz.Append;
    cdsEmpresasUsamPrecoMatriz.FieldByName('CODEMP').AsString := strCodEmp;
    cdsEmpresasUsamPrecoMatriz.FieldByName('LISEMP').AsString := Result;
    cdsEmpresasUsamPrecoMatriz.Post;
  End;
End;

procedure TfrmAltPrecoGlobalItens.FormDestroy(Sender: TObject);
begin
  inherited;
  If Assigned(objAvisoAlteracaoPreco) Then
    FreeAndNil(objAvisoAlteracaoPreco);
end;

procedure TfrmAltPrecoGlobalItens.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  fFecharTabela(qryPreAlt);
  FreeAndNil(qryIteCom);
end;

procedure TfrmAltPrecoGlobalItens.pSetaTexto;
Var
  objCampo: TField;
Begin
  For objCampo In dtsItens.DataSet.Fields Do
  Begin
    If fIndiceCampo(objCampo.FieldName.Replace('_NOV','')) >= 0 Then
      objCampo.OnGetText := pCampoDescricao;
  End;
End;

function TfrmAltPrecoGlobalItens.fIndiceCampo(strCampo: String): Integer;
Var
  arrCampos: TArray<String>;
Begin
  SetLength(arrCampos,23);
  arrCampos[00] := 'ITE_CODFOR';
  arrCampos[01] := 'ITE_CODGPR';
  arrCampos[02] := 'ITE_PRDGRU';
  arrCampos[03] := 'ITE_CODABF';
  arrCampos[04] := 'ITE_ABFPIS';
  arrCampos[05] := 'ITE_ABFCOF';
  arrCampos[06] := 'ITE_ABFIPI';
  arrCampos[07] := 'ITE_CODMAR';
  arrCampos[08] := 'ITE_CODMON';
  arrCampos[09] := 'ITE_CODUNI';
  arrCampos[10] := 'ITE_CODCOM';
  arrCampos[11] := 'ITE_UNICOM';
  arrCampos[12] := 'ITE_UNITRI';
  arrCampos[13] := 'ITE_CODGRU';
  arrCampos[14] := 'ITE_CODDEP';
  arrCampos[15] := 'ITE_GRUCMP';
  arrCampos[16] := 'ITE_CODONU';
  arrCampos[17] := 'ITE_CODLSE';
  arrCampos[18] := 'ITE_CDCEST';
  arrCampos[19] := 'ITE_SITPRO';
  arrCampos[20] := 'ITE_CODGPC';
  arrCampos[21] := 'ITE_EMPCAR';
  arrCampos[22] := 'ITE_EMPSUG';
  Result := AnsiIndexStr(strCampo, arrCampos);
End;


procedure TfrmAltPrecoGlobalItens.pCampoDescricao(Sender: TField; var Text: string;
    DisplayText: Boolean);
Var
  strCodCad: String;
  intIndice: Integer;
Begin
  DisplayText := Not fEmptyStr(Sender.AsString);
  strCodCad := Sender.AsString;
  Text := strCodCad;
  intIndice := fIndiceCampo(Sender.FieldName.Replace('_NOV',''));
  case  intIndice Of
    00: Text := fRetNomFornecedor(strCodCad);
    01: Text := fRetNomeGrupoPrecos(strCodCad);
    02: Text := fRetNomeGrupoProduto(strCodCad);
    03: Text := fRetDesAbfIcm(strCodCad);
    04: Text := fRetDesAbfPisCofIpi('PISSAI', strCodCad);
    05: Text := fRetDesAbfPisCofIpi('COFSAI', strCodCad);
    06: Text := fRetDesAbfPisCofIpi('IPISAI', strCodCad);
    07: Text := fRetNomMarca(strCodCad);
    08: Text := fRetNomMontadora(strCodCad);
    09: Text := fRetNomUnidade(strCodCad);
    10: Text := fRetDescricaoComposicao(strCodCad);
    11: Text := fRetNomUnidade(strCodCad);
    12: Text := fRetNomUnidade(strCodCad);
    13: Text := fRetNomeSoGrupo(strCodCad);
    14: Text := fCampoTabela('DEP_DESCRI','CADDEP',['DEP_CODIGO'], [strCodCad]);
    15: Text := fRetDescGrupoCompra(strCodCad);
    16: Text := fRetDescClassificacaoOnu(strCodCad);
    17: Text := fRetLocSep(strCodCad);
    18: Text := fCampoTabela('CES_DESCRI','CDCEST',['CES_CDCEST'], [strCodCad]);
    19: Text := fRetNomSituacaoProduto(strCodCad);
    20: Text := fCampoTabela('GPC_DESGPC','CADGPC',['GPC_CODGPC'], [strCodCad]);
    21: Text := fRetNomeEmpresaSelec(strCodCad);
    22: Text := fRetNomeEmpresaSelec(strCodCad);
  End;
  If (DisplayText) And
     (intIndice >= 0) Then
    Text := strCodCad + ' - ' + Text;
End;

function TfrmAltPrecoGlobalItens.fRetDesAbfPisCofIpi(strTabela, strCod: String): String;
Var
  qryAbf: TUniQuery;
begin
  qryAbf := fCriaQuery(Self);
  Try
    qryAbf.SQL.Add('SELECT APC_DESCRI FROM ' + strTabela +  ' WHERE APC_CODAPC = :CODAPC');
    qryAbf.ParamByName('CODAPC').AsString := strCod;
    qryAbf.Open;

    Result := qryAbf.FieldByName('APC_DESCRI').AsString;
  Finally
    FreeAndNil(qryAbf);
  End
end;


procedure TfrmAltPrecoGlobalItens.pGravaMontadoras(strCodIte,
  strListaMontadoras: String; qryComand: TUniQuery);

  var Lista: TStringList;
  i: integer;
begin
  qryComand.SQL.Clear;
  If strListaMontadoras <> '' Then
  Begin
    qryComand.SQL.Text := 'DELETE FROM ITEMON WHERE ITM_CODITE = "'+strCodIte+'";';
    If (strListaMontadoras <> 'Limpar') Then
    Begin
      Lista := TStringList.Create;
      Try
        Lista.Delimiter := ',';
        Lista.Commatext :=strListaMontadoras;
        for i := 0 To Lista.Count -1 do
        Begin
          qryComand.SQL.Add('INSERT INTO ITEMON(AUTOINCREM, ITM_CODMON, ITM_CODITE)VALUES(' +
                                                '"' + fRetAutoincrem('ITEMON', VS_StrCodemp) + '",' +
                                                '"' + Lista[i] + '",' +
                                                '"' + strCodIte + '");');
        End;
      Finally
        FreeAndNil(Lista);
      End;
    End;

    qryComand.ExecSQL;
    qryComand.SQL.Clear;
  End;
end;

function TfrmAltPrecoGlobalItens.fExistePrecoPautaFiscal: Boolean;
begin
  Result := False;
  If not Assigned(cdsPrecoPautaFiscal) then
    Exit;

  If cdsPrecoPautaFiscal.IsEmpty Then
    Exit;

  Try
    cdsPrecoPautaFiscal.Filtered := False;
    cdsPrecoPautaFiscal.Filter := 'PPF_VLRPPF > 0';
    cdsPrecoPautaFiscal.Filtered := True;

    Result := (cdsPrecoPautaFiscal.RecordCount > 0);

  Finally
    cdsPrecoPautaFiscal.Filtered := False;
  End;
end;

procedure TfrmAltPrecoGlobalItens.pDeletaPrecoPautaFiscal(strCodIte: String);
var
  qryDelete: TUniQuery;
begin
  qryDelete := fCriaQuery(Nil);

  Try
    qryDelete.Close;
    qryDelete.SQL.Clear;
    qryDelete.SQL.Add(' DELETE FROM CADPPF ');
    qryDelete.SQL.Add(' WHERE PPF_CODITE = :CODITE ');
    qryDelete.ParamByName('CODITE').AsString := strCodIte;
    qryDelete.ExecSQL;
  Finally
    FreeAndNil(qryDelete);
  End;
end;

procedure TfrmAltPrecoGlobalItens.pCadastraPrecoPautaFiscal(strCodIte: String);
var
  qryInsert: TUniQuery;
begin
  qryInsert := fCriaQuery(Nil);

  Try
    qryInsert.Sql.Text := 'SELECT * FROM CADPPF WHERE FALSE ';
    qryInsert.Open;

    cdsPrecoPautaFiscal.DisableControls;
    cdsPrecoPautaFiscal.First;
    While not cdsPrecoPautaFiscal.eof Do
    Begin
      qryInsert.Insert;
      qryInsert.FieldByName('PPF_CODITE').AsString   := strCodIte;
      qryInsert.FieldByName('PPF_ESTADO').AsString   := cdsPrecoPautaFiscal.FieldByName('PPF_ESTADO').AsString;
      qryInsert.FieldByName('PPF_VLRPPF').AsFloat    := cdsPrecoPautaFiscal.FieldByName('PPF_VLRPPF').AsFloat;

      If not (cdsPrecoPautaFiscal.FieldByName('PPF_DTAINI').AsDateTime = 0) Then
        qryInsert.FieldByName('PPF_DTAINI').AsDateTime := cdsPrecoPautaFiscal.FieldByName('PPF_DTAINI').AsDateTime;

      If not (cdsPrecoPautaFiscal.FieldByName('PPF_DTAFIN').AsDateTime = 0) Then
        qryInsert.FieldByName('PPF_DTAFIN').AsDateTime := cdsPrecoPautaFiscal.FieldByName('PPF_DTAFIN').AsDateTime;

      qryInsert.Post;

      cdsPrecoPautaFiscal.Next;
    End;

  Finally
    FreeAndNil(qryInsert);
    cdsPrecoPautaFiscal.EnableControls;
  End;
end;

function TfrmAltPrecoGlobalItens.fRetSQLUpdateCampoDetCus(AFieldName: String; strFiledNameNovo: String): String;
var
  blnCampoVenda, blnCampoMargem :Boolean;
  strTabPre: string;
  intTabPre: integer;
  fltValor: Double;

begin

  Result := '';

  blnCampoVenda := False;

  If Not blnTABPRD Then
    Exit;

  blnCampoMargem := Pos('ITE_MARBR', AFieldName) > 0;
  If not blnCampoMargem Then
    blnCampoVenda := Pos('ITE_PREVE', AFieldName) > 0;

  If blnCampoVenda or blnCampoMargem then
  Begin
    strTabPre := AnsiReplaceStr(AnsiReplaceStr(AFieldName, 'ITE_MARBR', ''), 'ITE_PREVE', '');
    intTabPre := -1;
    If TryStrToInt(strTabPre, intTabPre) Then
    Begin
      If fEmptyStr(dtsItens.DataSet.FieldByName('DETCUS_AUTOINCREM_'+ IntToStr(intTabPre)).AsString) Then
        Exit;
      fltValor := dtsItens.DataSet.FieldByName(strFiledNameNovo).AsFloat;
      If blnCampoVenda then
        fltValor := fltValor * dtsItens.DataSet.FieldByName('ITE_CNVCUS'+ IntToStr(intTabPre)).AsFloat;


      Result := 'UPDATE DETCUS SET ' + IIF(blnCampoVenda,'DET_PREVEN', 'DET_MARBRU') + '=' + AnsiReplaceStr(FloatToStr(fltValor), ',', '.') +

                ' WHERE DET_SEQDET = "' + dtsItens.DataSet.FieldByName('DETCUS_AUTOINCREM_'+ IntToStr(intTabPre)).AsString + '"' +
                '   AND DET_TABELA = "'+strTabPre+'";';
    End;

  End;


end;

end.


