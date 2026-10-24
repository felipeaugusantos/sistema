unit untControleQualidadeProducao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.Mask, Vcl.DBCtrls, DBEditFocus, EditFocus, untZClient,
  Vcl.ComCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, Uni, cxProgressBar, UniClientDataSet, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid, cxDropDownEdit, cxGridBandedTableView,
  cxGridDBBandedTableView, strUtils, DBMemoFocus, frxDBSet,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmControleQualidadeProducao = class(TfrmPaiConfirma)
    pnlProdutos: TPanel;
    Label1: TLabel;
    Label5: TLabel;
    edtDesIte: TEditFocus;
    dbeCodIte: TDBEditFocus;
    edtRefere: TEditFocus;
    Label3: TLabel;
    edtOrdPro: TEditFocus;
    Label2: TLabel;
    dbeCodCli: TDBEditFocus;
    edtDesCli: TEditFocus;
    lbl1: TLabel;
    dbeIteRes: TDBEditFocus;
    edtDesRes: TEditFocus;
    Bevel1: TBevel;
    Label6: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    dbePerRes: TDBEditFocus;
    Label7: TLabel;
    dbeDtaIni: TDBEditFocus;
    Label8: TLabel;
    dbeHraIni: TDBEditFocus;
    Label9: TLabel;
    PageControl: TPageControl;
    tbsAnalise: TTabSheet;
    tbsEspTecnicas: TTabSheet;
    tbsObserv: TTabSheet;
    pnlAnalise: TPanel;
    pnlEspTecnicas: TPanel;
    pnlObserv: TPanel;
    cxgTanProLevel: TcxGridLevel;
    cxgTanProTableView: TcxGridDBTableViewCitel;
    cxgTanPro: TcxGridCitel;
    pnlAnaliseLeg: TPanel;
    cxgTanProTableViewCODIGO: TcxGridDBColumn;
    cxgTanProTableViewDESCRI: TcxGridDBColumn;
    cxgTanProTableViewSTA_01: TcxGridDBColumn;
    cxgTanProTableViewSTA_02: TcxGridDBColumn;
    cxgTanProTableViewSTA_03: TcxGridDBColumn;
    Label11: TLabel;
    pnlTopEteMat: TPanel;
    lbl23: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    edtValSt2: TEditFocus;
    btnAdicionaEtePro: TBitBtnLocked;
    btnCancelaEtePro: TBitBtnLocked;
    edtValSt1: TEditFocus;
    edtCodEte: TEditFocus;
    edtDesEte: TEditFocus;
    edtValSt3: TEditFocus;
    Label14: TLabel;
    cxgEteProLevel: TcxGridLevel;
    cxgEtePro: TcxGridCitel;
    cxgEteProTableView: TcxGridDBBandedTableViewCitel;
    cxgEteProTableViewCODETE: TcxGridDBBandedColumn;
    cxgEteProTableViewDESCRI: TcxGridDBBandedColumn;
    cxgEteProTableViewVALMIN: TcxGridDBBandedColumn;
    cxgEteProTableViewVALMAX: TcxGridDBBandedColumn;
    cxgEteProTableViewVALOR1: TcxGridDBBandedColumn;
    cxgEteProTableViewSTA_03: TcxGridDBBandedColumn;
    cxgEteProTableViewSTA_01: TcxGridDBBandedColumn;
    cxgEteProTableViewVALOR2: TcxGridDBBandedColumn;
    cxgEteProTableViewSTA_02: TcxGridDBBandedColumn;
    cxgEteProTableViewVALOR3: TcxGridDBBandedColumn;
    Panel1: TPanel;
    Label15: TLabel;
    mmoObsQua: TDBMemoFocus;
    cxgResumo: TcxGridCitel;
    cxgResumoTableView: TcxGridDBBandedTableViewCitel;
    cxgResumoTableViewCODETE: TcxGridDBBandedColumn;
    cxgResumoTableViewDESCRI: TcxGridDBBandedColumn;
    cxgResumoTableViewVALMIN: TcxGridDBBandedColumn;
    cxgResumoTableViewVALMAX: TcxGridDBBandedColumn;
    cxgResumoTableViewVALOR1: TcxGridDBBandedColumn;
    cxgResumoTableViewSTA_01: TcxGridDBBandedColumn;
    cxgResumoTableViewVALOR2: TcxGridDBBandedColumn;
    cxgResumoTableViewSTA_02: TcxGridDBBandedColumn;
    cxgResumoTableViewVALOR3: TcxGridDBBandedColumn;
    cxgResumoTableViewSTA_03: TcxGridDBBandedColumn;
    cxgResumoLevel: TcxGridLevel;
    Panel2: TPanel;
    Label16: TLabel;
    Splitter1: TSplitter;
    cxgResumoTableViewVALORT: TcxGridDBBandedColumn;
    cxgResumoTableViewSTA_TT: TcxGridDBBandedColumn;
    btnImprimirLaudo: TBitBtnLocked;
    frxReport: TfrxReport;
    frxDBMovPro: TfrxDBDataset;
    frxDBTanPro: TfrxDBDataset;
    frxDBResumo: TfrxDBDataset;
    frxDBEmpres: TfrxDBDataset;
    Label17: TLabel;
    Panel3: TPanel;
    Label4: TLabel;
    dbeSopro: TDBEditFocus;
    dbeQtdFar: TDBEditFocus;
    Label18: TLabel;
    dbeValida: TDBEditFocus;
    Label19: TLabel;
    Label10: TLabel;
    dbeRespon: TDBEditFocus;
    dbeEmiLau: TDBEditFocus;
    Label20: TLabel;
    dbcCmpOri: TDBCheckBox;
    Label21: TLabel;
    dbeItePig: TDBEditFocus;
    edtDesPig: TEditFocus;
    Label22: TLabel;
    edtForPig: TEditFocus;
    edtNomForPig: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAdicionaEteProClick(Sender: TObject);
    procedure btnCancelaEteProClick(Sender: TObject);
    procedure edtCodEteKeyPress(Sender: TObject; var Key: Char);
    procedure edtOrdProKeyPress(Sender: TObject; var Key: Char);
    procedure pnlTopEteMatExit(Sender: TObject);
    procedure cxgEteProTableViewDblClick(Sender: TObject);
    procedure cxgEteProTableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure mmoObsQuaKeyPress(Sender: TObject; var Key: Char);
    procedure PageControlChange(Sender: TObject);
    procedure cxgEteProTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnImprimirLaudoClick(Sender: TObject);
    procedure Label17Click(Sender: TObject);
    procedure dbeIteResKeyPress(Sender: TObject; var Key: Char);
    procedure dbeItePigKeyPress(Sender: TObject; var Key: Char);
  private
    cdsMovPro : TZClient;
    cdsTanPro : TZClient;
    cdsEtePro : TZClient;
    cdsResumo : TUniClientDataSet;
    dtsResumo : TDataSource;

    blnSoGravar : Boolean;
    blnAprovado : Boolean;

    fltVlrMin,
    fltVlrMax : Double;

    strStatus,
    strValor : String;

    function fCarregaMovPro : Boolean;
    function fGetSQLMovPro  : String;
    function fGetSQLTanPro  : String;
    function fGetSQLEtePro  : String;
    function fGravaProgresso(cxProgress: TcxProgressBar): Boolean;
    function fGeraResumo(cxProgress: TcxProgressBar): Boolean;

    procedure pCarregaEteProEdicao;
    procedure pGravar;
    procedure pImprimirLaudo;
  public
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave :Boolean):Boolean; override;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untGravando, untTypesSistema, untConsultas;

procedure TfrmControleQualidadeProducao.btnAdicionaEteProClick(Sender: TObject);

  Function fStatus(fltValor : Double):String;
  Begin
    Result := IfThen((fltValor >= fltVlrMin) And (fltValor <= fltVlrMax), 'AP', 'RP');
  End;

begin
  inherited;
  If not fValidaPanel(pnlTopEteMat, True) Then
    Exit;


  If (not ((fStrToFloat(edtValSt1.Text) > 0) Or
           (fStrToFloat(edtValSt2.Text) > 0) Or
           (fStrToFloat(edtValSt3.Text) > 0))) Then
  Begin
    fMensagem('','É Obrigatório Informar Valor em Pelo Menos 1 Turno!', ['&Ok']);
    Exit;
  End;

  if btnAdicionaEtePro.Tag = 0 Then
    cdsEtePro.Append
  Else
    cdsEtePro.Edit;

  cdsEtePro.FieldByName('SEQPRO').AsString := cdsMovPro.FieldByName('AUTOINCREM').AsString;
  cdsEtePro.FieldByName('CODETE').AsString := edtCodEte.Text;
  cdsEtePro.FieldByName('DESCRI').AsString := edtDesEte.Text;

  cdsEtePro.FieldByName('VALMIN').AsFloat  := fltVlrMin;
  cdsEtePro.FieldByName('VALMAX').AsFloat  := fltVlrMax;

  cdsEtePro.FieldByName('VALOR1').Value    := IIF(fStrToFloat(edtValSt1.Text) > 0, fStrToFloat(edtValSt1.Text), Null);
  cdsEtePro.FieldByName('VALOR2').Value    := IIF(fStrToFloat(edtValSt2.Text) > 0, fStrToFloat(edtValSt2.Text), Null);
  cdsEtePro.FieldByName('VALOR3').Value    := IIF(fStrToFloat(edtValSt3.Text) > 0, fStrToFloat(edtValSt3.Text), Null);

  If not cdsEtePro.FieldByName('VALOR1').IsNull Then
    cdsEtePro.FieldByName('STA_01').AsString := fStatus(cdsEtePro.FieldByName('VALOR1').AsFloat)
  Else
    cdsEtePro.FieldByName('STA_01').Clear;

  If not cdsEtePro.FieldByName('VALOR2').IsNull Then
    cdsEtePro.FieldByName('STA_02').AsString := fStatus(cdsEtePro.FieldByName('VALOR2').AsFloat)
  Else
    cdsEtePro.FieldByName('STA_02').Clear;

  If not cdsEtePro.FieldByName('VALOR3').IsNull Then
    cdsEtePro.FieldByName('STA_03').AsString := fStatus(cdsEtePro.FieldByName('VALOR3').AsFloat)
  Else
    cdsEtePro.FieldByName('STA_03').Clear;

  cdsEtePro.Post;

  btnCancelaEtePro.Click;

end;

procedure TfrmControleQualidadeProducao.btnCancelaEteProClick(Sender: TObject);
begin
  inherited;
  edtCodEte.Clear;
  edtDesEte.Clear;
  edtValSt1.Clear;
  edtValSt2.Clear;
  edtValSt3.Clear;
  pSetFocus(edtCodEte);

  cxgEtePro.Enabled := True;
  btnAdicionaEtePro.Tag := 0;

end;

procedure TfrmControleQualidadeProducao.pGravar;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fGravaProgresso;
    frmGravando.lblGravando.Caption := 'Aguarde, Gravando...';
    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando);
  End;
End;

procedure TfrmControleQualidadeProducao.btnConfirmaClick(Sender: TObject);
begin
  If not ((cdsEtePro.Active) And (cdsEtePro.RecordCount > 0)) Then
  Begin
    fMensagem('','Não Existe Nenhum Registro Para Gravar!', ['&Ok']);
    Exit;
  End;
  //inherited;
  pGravar;
end;

procedure TfrmControleQualidadeProducao.btnImprimirLaudoClick(Sender: TObject);
begin
  inherited;
  Try
    blnSoGravar := True;
    pGravar;
    pImprimirLaudo;
  Finally
    blnSoGravar := False;
  End;
end;

procedure TfrmControleQualidadeProducao.cxgEteProTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    intColIdx : Integer;
begin
  inherited;

  If Pos('_' + IntToStr(AViewInfo.Item.Index)+ '_', strStatus + strValor) > 0 Then
  Begin
    intColIdx := AViewInfo.Item.Index;
    If Pos('_' + IntToStr(AViewInfo.Item.Index) + '_', strValor) > 0 Then
      Inc(intColIdx);

    If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,  intColIdx]) <> '' Then
    Begin
      ACanvas.Font.Style := [fsBold];
      If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,  intColIdx]) = 'AP' Then
        ACanvas.Font.Color := clGreen
      Else
      If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,  intColIdx]) = 'RP' Then
        ACanvas.Font.Color := clRed;
    End;
  End;
end;

procedure TfrmControleQualidadeProducao.cxgEteProTableViewDblClick(
  Sender: TObject);
begin
  inherited;
  pCarregaEteProEdicao;
end;

procedure TfrmControleQualidadeProducao.cxgEteProTableViewKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_DELETE Then
  Begin
    If (cdsEtePro.Active) And (cdsEtePro.RecordCount > 0) Then
    Begin
      If fMensagem('', 'Deseja Excluir Específicação?', ['&Sim', '&Não'], 2) = 1 Then
        cdsEtePro.Delete;
    End;
  End

  Else
  If Key = VK_RETURN Then
  Begin
    pCarregaEteProEdicao;
  End;
end;

procedure TfrmControleQualidadeProducao.dbeItePigKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If not (cdsMovPro.State in dsEditModes) Then
    cdsMovPro.Edit;

  If fPesqSubItensDaEstrutura(Self, dbeItePig, edtDesPig, Nil, Key, arrSel, dbeCodIte.Text) Then
  Begin
    If fValidaCampos(dbeItePig, True) then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmControleQualidadeProducao.dbeIteResKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If not (cdsMovPro.State in dsEditModes) Then
    cdsMovPro.Edit;

  If fPesqSubItensDaEstrutura(Self, dbeIteRes, edtDesRes, Nil, Key, arrSel, dbeCodIte.Text) Then
  Begin
    If fValidaCampos(dbeIteRes, True) then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmControleQualidadeProducao.edtCodEteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fPesqEspecificacoesTecnicas(Self, edtCodEte, edtDesEte, Nil, Key, arrSel, False, cdsMovPro.FieldByName('PRO_CODITE').AsString) Then
  Begin
    If fValidaCampos(edtCodEte, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmControleQualidadeProducao.edtOrdProKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fPesqOrdemProd(conSimples, Self, edtOrdPro, Nil, Nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtOrdPro, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmControleQualidadeProducao.fCarregaMovPro: Boolean;
begin
  Try
    With cdsMovPro.qryQuery, SQL Do
    Begin
      Close;
      ParamByName('CODPRO').AsString := edtOrdPro.Text;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      cdsMovPro.fAbreClient(True, 'TfrmControleQualidadeProducao.fCarregaMovPro');

      Result := (cdsMovPro.RecordCount > 0);

    End;

    If cdsTanPro.Active Then
      cdsTanPro.EmptyDataSet;

    If cdsEtePro.Active Then
      cdsEtePro.EmptyDataSet;

    PageControl.ActivePageIndex := 0;

    If Result Then
    Begin
      cdsMovPro.Edit;

      If cdsMovPro.FieldByName('PRO_CMPORI').IsNull Then
        cdsMovPro.FieldByName('PRO_CMPORI').AsString := 'S';

      If cdsMovPro.FieldByName('PRO_DTAINI').IsNull Then
        cdsMovPro.FieldByName('PRO_DTAINI').AsDateTime := VS_Date;

      If cdsMovPro.FieldByName('PRO_HRAINI').IsNull Then
        cdsMovPro.FieldByName('PRO_HRAINI').AsDateTime := fNow;

      cdsMovPro.Post;
    End;

    // ABRINDO ANALISE DE CONTROLE
    With cdsTanPro.qryQuery, SQL Do
    Begin
      Close;
      ParamByName('SEQPRO').AsString := cdsMovPro.FieldByName('AUTOINCREM').AsString;
      cdsTanPro.fAbreClient(True,'TfrmControleQualidadeProducao.fCarregaMovPro');
    End;

    //ABRINDO ESPECIFICAÇÕES TECNICAS
    With cdsEtePro.qryQuery, SQL Do
    Begin
      Close;
      ParamByName('SEQPRO').AsString := cdsMovPro.FieldByName('AUTOINCREM').AsString;
      cdsEtePro.fAbreClient(True,'TfrmControleQualidadeProducao.fCarregaMovPro');

      TFloatField(cdsEtePro.FieldByName('VALMIN')).DisplayFormat := fMskDigitos(4);
      TFloatField(cdsEtePro.FieldByName('VALMAX')).DisplayFormat := fMskDigitos(4);
      TFloatField(cdsEtePro.FieldByName('VALOR1')).DisplayFormat := fMskDigitos(4);
      TFloatField(cdsEtePro.FieldByName('VALOR2')).DisplayFormat := fMskDigitos(4);
      TFloatField(cdsEtePro.FieldByName('VALOR3')).DisplayFormat := fMskDigitos(4);

      TStringField(cdsEtePro.FieldByName('STA_01')).Alignment := taCenter;
      TStringField(cdsEtePro.FieldByName('STA_02')).Alignment := taCenter;
      TStringField(cdsEtePro.FieldByName('STA_03')).Alignment := taCenter;

    End;

    dbeSopro.DataSource  := cdsMovPro.dtsSource;
    dbeCodIte.DataSource := cdsMovPro.dtsSource;
    dbeCodCli.DataSource := cdsMovPro.dtsSource;
    dbeIteRes.DataSource := cdsMovPro.dtsSource;
    dbeItePig.DataSource := cdsMovPro.dtsSource;
    dbePerRes.DataSource := cdsMovPro.dtsSource;
    dbeDtaIni.DataSource := cdsMovPro.dtsSource;
    dbeHraIni.DataSource := cdsMovPro.dtsSource;
    dbeRespon.DataSource := cdsMovPro.dtsSource;
    mmoObsQua.DataSource := cdsMovPro.dtsSource;
    dbeValida.DataSource := cdsMovPro.dtsSource;
    dbeQtdFar.DataSource := cdsMovPro.dtsSource;
    dbeRespon.DataSource := cdsMovPro.dtsSource;
    dbcCmpOri.DataSource := cdsMovPro.dtsSource;
    dbeEmiLau.DataSource := cdsMovPro.dtsSource;

    cxgTanProTableView.DataController.DataSource := cdsTanPro.dtsSource;
    cxgEteProTableView.DataController.DataSource := cdsEtePro.dtsSource;
    cxgResumoTableView.DataController.DataSource := dtsResumo;

    PageControl.Enabled := Result;
    dbeIteRes.Enabled := Result;
    dbeItePig.Enabled := Result;
    dbePerRes.Enabled := Result;
    dbeDtaIni.Enabled := Result;
    dbeHraIni.Enabled := Result;
    dbeRespon.Enabled := Result;


    TFloatField(cdsMovPro.FieldByName('PRO_PERRES')).DisplayFormat    := '#,##0.000';
    TDateTimeField(cdsMovPro.FieldByName('PRO_HRAINI')).DisplayFormat := 'hh:nn';
    TDateTimeField(cdsMovPro.FieldByName('PRO_DTAINI')).EditMask      := '99/99/9999';
    TDateTimeField(cdsMovPro.FieldByName('PRO_HRAINI')).EditMask      := '99:99';

    edtDesCli.Text := fRetNomCliente(dbeCodCli.Text);
    edtDesIte.Text := fRetNomProduto(dbeCodIte.Text);
    edtRefere.Text := fRetReferenciaProd(dbeCodIte.Text);
    edtDesRes.Text := fRetNomProduto(dbeIteRes.Text);
    edtCodFor.Text := fRetFornecedorItem(dbeIteRes.Text);
    edtNomFor.Text := fRetNomFornecedor(edtCodFor.Text);

    edtDesPig.Text := fRetNomProduto(dbeItePig.Text);
    edtForPig.Text := fRetFornecedorItem(dbeItePig.Text);
    edtNomForPig.Text := fRetNomFornecedor(edtForPig.Text);

  Except
    On E : Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'TfrmControleQualidadeProducao.fCarregaMovPro');
    End;
  End;

end;

function TfrmControleQualidadeProducao.fGetSQLEtePro: String;
begin
  Result := '';
  Result := Result + ' SELECT A.AUTOINCREM,                                 ';
  Result := Result + '          ETP_SEQPRO AS SEQPRO,                       ';
  Result := Result + '          ETP_CODETE AS CODETE,                       ';
  Result := Result + '          ETM_VALMIN AS VALMIN,                       ';
  Result := Result + '          ETM_VALMAX AS VALMAX,                       ';
  Result := Result + '          ETP_VALOR1 AS VALOR1,                       ';
  Result := Result + '          ETP_STA_01 AS STA_01,                       ';
  Result := Result + '          ETP_VALOR2 AS VALOR2,                       ';
  Result := Result + '          ETP_STA_02 AS STA_02,                       ';
  Result := Result + '          ETP_VALOR3 AS VALOR3,                       ';
  Result := Result + '          ETP_STA_03 AS STA_03,                       ';
  Result := Result + '          ETE_DESCRI AS DESCRI                        ';
  Result := Result + ' FROM ETEPRO A                                        ';
  Result := Result + '   INNER JOIN ESPTEC B ON B.ETE_CODIGO = A.ETP_CODETE ';
  Result := Result + '   INNER JOIN MOVPRO C ON C.AUTOINCREM = A.ETP_SEQPRO ';
  Result := Result + '   INNER JOIN GERMAT D ON D.GMT_CODITE = C.PRO_CODITE ';
  Result := Result + '   INNER JOIN ETEMAT E ON E.ETM_SEQMAT = D.AUTOINCREM ';
  Result := Result + '                      AND E.ETM_CODETE = A.ETP_CODETE ';
  Result := Result + ' WHERE ETP_SEQPRO = :SEQPRO                           ';
  Result := Result + ' ORDER BY CODETE                                      ';

end;

function TfrmControleQualidadeProducao.fGetSQLMovPro: String;
begin
  Result := '';
  Result := Result + ' SELECT * FROM MOVPRO       ';
  Result := Result + ' WHERE PRO_CODPRO = :CODPRO ';
  Result := Result + '   AND PRO_CODEMP = :CODEMP ';
end;

function TfrmControleQualidadeProducao.fGetSQLTanPro: String;
begin
  Result := '';
  Result := Result + ' SELECT TAN_CODIGO AS CODIGO,                  ';
  Result := Result + '        TAN_DESCRI AS DESCRI,                  ';
  Result := Result + '        TAP_STA_01 AS STA_01,                  ';
  Result := Result + '        TAP_STA_02 AS STA_02,                  ';
  Result := Result + '        TAP_STA_03 AS STA_03,                  ';
  Result := Result + '        MET_DESCRI AS METODO                   ';
  Result := Result + ' FROM TIPANA                                   ';
  Result := Result + '   LEFT JOIN TANPRO ON TAP_CODTAN = TAN_CODIGO ';
  Result := Result + '                   AND TAP_SEQPRO = :SEQPRO    ';
  Result := Result + '   LEFT JOIN METODO ON MET_CODIGO = TAN_METODO ';
  Result := Result + ' ORDER BY CODIGO                               ';
end;

procedure TfrmControleQualidadeProducao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If cdsMovPro.Active And (cdsMovPro.RecordCount > 0) Then
  Begin
    Action := caNone;
    If fMensagem('', 'Deseja cancelar?', ['&Sim', '&Não'], 2) = 1 Then
    Begin
      edtOrdPro.Clear;
      fCarregaMovPro;
      pSetFocus(edtOrdPro);
    End;
  End;
end;

procedure TfrmControleQualidadeProducao.FormCreate(Sender: TObject);
begin
  inherited;

  pSetaCodIte(dbeCodIte);
  pSetaCodIte(dbeIteRes);
  pSetaCodIte(dbeItePig);

  blnSoGravar := False;
  edtOrdPro.MaxLength := fTamDocCadRec;
  edtOrdPro.TamCampo  := fTamDocCadRec;

  cdsMovPro := TZClient.Create(Self, fGetSQLMovPro);
  cdsTanPro := TZClient.Create(Self, fGetSQLTanPro);
  cdsEtePro := TZClient.Create(Self, fGetSQLEtePro);

  strStatus := '_' +
               IntToStr(cxgEteProTableViewSTA_01.Index) + '_' +
               IntToStr(cxgEteProTableViewSTA_02.Index) + '_' +
               IntToStr(cxgEteProTableViewSTA_03.Index) + '_' +
               IntToStr(cxgResumoTableViewSTA_TT.Index) + '_' ;

  strValor  := '_' +
               IntToStr(cxgEteProTableViewVALOR1.Index) + '_' +
               IntToStr(cxgEteProTableViewVALOR2.Index) + '_' +
               IntToStr(cxgEteProTableViewVALOR3.Index) + '_' +
               IntToStr(cxgResumoTableViewVALORT.Index) + '_' ;

  cdsResumo := TUniClientDataSet.Create(Self);;
  dtsResumo := fCriaDataSource(cdsResumo);

  With cdsResumo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODETE'; DataType := ftString; Size := 03; Required := False;
  End;
  With cdsResumo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DESCRI'; DataType := ftString; Size := 60; Required := False;
  End;
  With cdsResumo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'STA_01'; DataType := ftString; Size := 03; Required := False;
  End;
  With cdsResumo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'STA_02'; DataType := ftString; Size := 03; Required := False;
  End;
  With cdsResumo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'STA_03'; DataType := ftString; Size := 03; Required := False;
  End;
  With cdsResumo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'STA_TT'; DataType := ftString; Size := 03; Required := False;
  End;
  With cdsResumo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VALMIN'; DataType := ftFloat;  Size := 00; Required := False;
  End;
  With cdsResumo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VALMAX'; DataType := ftFloat;  Size := 00; Required := False;
  End;
  With cdsResumo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VALOR1'; DataType := ftFloat;  Size := 00; Required := False;
  End;
  With cdsResumo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VALOR2'; DataType := ftFloat;  Size := 00; Required := False;
  End;
  With cdsResumo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VALOR3'; DataType := ftFloat;  Size := 00; Required := False;
  End;
  With cdsResumo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VALORT'; DataType := ftFloat;  Size := 00; Required := False;
  End;
  With cdsResumo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'METODO'; DataType := ftString;  Size := 20; Required := False;
  End;
  With cdsResumo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ESCALA'; DataType := ftString;  Size := 05; Required := False;
  End;

  cdsResumo.CreateDataSet;
  cdsResumo.Open;

  TFloatField(cdsResumo.FieldByName('VALMIN')).DisplayFormat := fMskDigitos(4);
  TFloatField(cdsResumo.FieldByName('VALMAX')).DisplayFormat := fMskDigitos(4);
  TFloatField(cdsResumo.FieldByName('VALOR1')).DisplayFormat := fMskDigitos(4);
  TFloatField(cdsResumo.FieldByName('VALOR2')).DisplayFormat := fMskDigitos(4);
  TFloatField(cdsResumo.FieldByName('VALOR3')).DisplayFormat := fMskDigitos(4);
  TFloatField(cdsResumo.FieldByName('VALORT')).DisplayFormat := fMskDigitos(4);

  TStringField(cdsResumo.FieldByName('STA_01')).Alignment := taCenter;
  TStringField(cdsResumo.FieldByName('STA_02')).Alignment := taCenter;
  TStringField(cdsResumo.FieldByName('STA_03')).Alignment := taCenter;
  TStringField(cdsResumo.FieldByName('STA_TT')).Alignment := taCenter;

  PageControl.ActivePageIndex := 0;
end;

procedure TfrmControleQualidadeProducao.FormDestroy(Sender: TObject);
begin
  if Assigned(cdsMovPro) Then FreeAndNil(cdsMovPro);
  if Assigned(cdsTanPro) Then FreeAndNil(cdsTanPro);
  if Assigned(cdsEtePro) Then FreeAndNil(cdsEtePro);
  if Assigned(dtsResumo) Then FreeAndNil(dtsResumo);
  if Assigned(cdsResumo) Then FreeAndNil(cdsResumo);
  inherited;
end;

function TfrmControleQualidadeProducao.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);
  If Result Then
  Begin
    If (Sender = edtOrdPro) Then
    Begin
      If blnBuscaPorChave Then
        If not fCarregaMovPro Then
        Begin
          Result := False;
          fMensagem('', 'Ordem de Produção não cadastrada!', ['&Ok']);
        End;
    End

    Else
    If (Sender = dbeIteRes) Then
    Begin
      If fEmptyStr(dbeIteRes.Text) Then
      Begin
        edtDesRes.Clear;
        edtCodFor.Clear;
        edtNomFor.Clear;
      End
      Else
      Begin
        edtDesRes.Text := fRetNomProduto(dbeIteRes.Text);
        If fEmptyStr(edtDesRes.Text) Then
        Begin
          Result := False;
          fMensagem('', 'Sub-Item Resina inválido!', ['&Ok']);
        End
        Else If (fSubItemDaEstrutura(dbeCodIte.Text, dbeIteRes.Text)) Then
        Begin
          edtCodFor.Text := fRetFornecedorItem(dbeIteRes.Text);
          edtNomFor.Text := fRetNomFornecedor(edtCodFor.Text);
        End
        Else
        Begin
          Result := False;
          fMensagem('', 'O Sub-Item Resina Escolhido não Pertence a Estrutura!', ['&OK']);
        End;

      End;

    End

    Else
    If (Sender = dbeItePig) Then
    Begin
      If fEmptyStr(dbeItePig.Text) Then
      Begin
        edtDesRes.Clear;
        edtCodFor.Clear;
        edtNomFor.Clear;
      End
      Else
      Begin
        edtDesPig .Text := fRetNomProduto(dbeItePig.Text);
        If fEmptyStr(edtDesPig.Text) Then
        Begin
          Result := False;
          fMensagem('', 'Sub-Item Pigmento inválido!', ['&Ok']);
        End
        Else If (fSubItemDaEstrutura(dbeCodIte.Text, dbeItePig.Text)) Then
        Begin
          edtForPig.Text := fRetFornecedorItem(dbeItePig.Text);
          edtNomForPig.Text := fRetNomFornecedor(edtForPig.Text);
        End
        Else
        Begin
          Result := False;
          fMensagem('', 'O Sub-Item Pigmento Escolhido não Pertence a Estrutura!', ['&OK']);
        End;

      End;

    End


    Else
    If (Sender = dbeDtaIni) And blnBuscaPorChave Then
    Begin
      If StrToDateDef(dbeDtaIni.Text,0) > 0 Then
        dbeDtaIni.Text := FormatDateTime('dd/mm/yyyy', StrToDateDef(dbeDtaIni.Text,0))
      Else
      Begin
        Result := False;
        fMensagem('', 'Digite uma Data válida!', ['&Ok']);
      End;
    End

    Else
    If (Sender = dbeHraIni) And blnBuscaPorChave Then
    Begin
      If StrToTimeDef(dbeHraIni.Text + ':00', -1) >= 0 Then
        dbeHraIni.Text := FormatDateTime('hh:nn', StrToTimeDef(dbeHraIni.Text + ':00', -1))
      Else
      Begin
        Result := False;
        fMensagem('', 'Digite uma Hora válida!', ['&Ok']);
      End;
    End

    Else
    If (Sender = dbeRespon) Then
    Begin
      If blnBuscaPorChave Then
      Begin
        pSetFocus(cxgTanPro);
        blnMudarFoco := False;
      End;
    End

    Else
    If (Sender = edtCodEte) And blnBuscaPorChave Then
    Begin
      If fEmptyStr(edtCodEte.Text) Then
      Begin
        Result := False;
        fMensagem('', 'Digite o Código da Específicação Técnica!', ['&Ok']);
      End
      Else
      Begin
        edtDesEte.Text := fRetMaxMinEspecifiTecnica(cdsMovPro.FieldByName('PRO_CODITE').AsString,
                                                    edtCodEte.Text, fltVlrMin, fltVlrMax);

        If fEmptyStr(edtDesEte.Text) Then
        Begin
          Result := False;
          fMensagem('', 'Específicação Técnica não cadastrada ou Valor não Informado para o Produto!!', ['&Ok']);
        End;
      End;

    End

    Else
    If (Sender = edtValSt1) Or
       (Sender = edtValSt2) Or
       (Sender = edtValSt3) Then
     Begin
       If (fStrToFloat(TEditFocus(Sender).Text) < 0) And blnBuscaPorChave Then
       Begin
         Result := False;
         fMensagem('', 'Digite um Valor Maior ou Igual a Zero!', ['&OK']);
       End;
     End;

  End;

  If not Result Then
    pSetFocus(Sender);

end;

procedure TfrmControleQualidadeProducao.Label17Click(Sender: TObject);
begin
  inherited;
  mmoObsQua.Visible := Not mmoObsQua.Visible;
end;

procedure TfrmControleQualidadeProducao.mmoObsQuaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    strKey : String;
begin
  inherited;
  strKey := Key;
  strKey := AnsiUpperCase(strKey);
  Key    := strKey[1];

  If (Key = #13) And fEmptyStr(mmoObsQua.Text) Then
  Begin
    Key := #0;
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmControleQualidadeProducao.PageControlChange(Sender: TObject);
begin
  inherited;
  If (PageControl.ActivePage = tbsObserv) Then
  Begin
    Try
      pCriarFormularios(TfrmGravando, frmGravando);
      frmGravando.fExecutarAcao := fGeraResumo;
      frmGravando.lblGravando.Caption := 'Aguarde, Gerando Resumo...';
      frmGravando.ShowModal;
    Finally
      FreeAndNil(frmGravando);
    End;
  End;
  btnImprimirLaudo.Visible := (PageControl.ActivePage = tbsObserv);
end;

function TfrmControleQualidadeProducao.fGravaProgresso(cxProgress : TcxProgressBar):Boolean;
  Var
    qryAuxiliar : TUniQuery;

  Procedure pStep;
  Begin
    cxProgress.Position := cxProgress.Position + 1;
    Application.ProcessMessages;
  End;

Begin
  Result := True;
  Try
    qryAuxiliar := fCriaQuery(Self);
    fStartTransaction;
    Try
      cxProgress.Properties.Max := cdsTanPro.RecordCount +
                                   cdsEtePro.RecordCount + 2;
      cxProgress.Position := 0;

      With qryAuxiliar, SQL Do
      Begin
        Close;
        Clear;
        Add(' DELETE FROM TANPRO WHERE TAP_SEQPRO = :SEQPRO ');
        ParamByName('SEQPRO').AsString := cdsMovPro.FieldByName('AUTOINCREM').AsString;
        ExecSQL;
        pStep;

        Close;
        Clear;
        Add(' INSERT INTO TANPRO (AUTOINCREM, ');
        Add('                     TAP_SEQPRO, ');
        Add('                     TAP_CODTAN, ');
        Add('                     TAP_STA_01, ');
        Add('                     TAP_STA_02, ');
        Add('                     TAP_STA_03) ');
        Add('              VALUES(:AUTINC,    ');
        Add('                     :SEQPRO,    ');
        Add('                     :CODTAN,    ');
        Add('                     :STA_01,    ');
        Add('                     :STA_02,    ');
        Add('                     :STA_03)    ');

      End;

      // Grava MovPro;
      Result := cdsMovPro.fSalva;
      pStep;

      // Grava Analise
      cdsTanPro.DisableControls;
      cdsTanPro.First;
      While not cdsTanPro.Eof Do
      Begin
        With qryAuxiliar Do
        Begin
          ParamByName('AUTINC').AsString := fRetAutoIncrem('TANPRO', VS_strCodEmp);
          ParamByName('SEQPRO').AsString := cdsMovPro.FieldByName('AUTOINCREM').AsString;
          ParamByName('CODTAN').AsString := cdsTanPro.FieldByName('CODIGO').AsString;
          ParamByName('STA_01').AsString := cdsTanPro.FieldByName('STA_01').AsString;
          ParamByName('STA_02').AsString := cdsTanPro.FieldByName('STA_02').AsString;
          ParamByName('STA_03').AsString := cdsTanPro.FieldByName('STA_03').AsString;

          If fEmptyStr(ParamByName('STA_01').AsString) Then
            ParamByName('STA_01').Clear;

          If fEmptyStr(ParamByName('STA_02').AsString) Then
            ParamByName('STA_02').Clear;

          If fEmptyStr(ParamByName('STA_03').AsString) Then
            ParamByName('STA_03').Clear;

          If (not fEmptyStr(ParamByName('STA_01').AsString)) Or
             (not fEmptyStr(ParamByName('STA_02').AsString)) Or
             (not fEmptyStr(ParamByName('STA_03').AsString)) Then
            ExecSQL;
        End;

        pStep;
        cdsTanPro.Next;

      End;

      //Grava Especificações;
      With qryAuxiliar, SQL Do
      Begin
        Close;
        Clear;
        Add(' DELETE FROM ETEPRO WHERE ETP_SEQPRO = :SEQPRO ');
        ParamByName('SEQPRO').AsString := cdsMovPro.FieldByName('AUTOINCREM').AsString;
        ExecSQL;
        pStep;

        Close;
        Clear;
        Add(' INSERT INTO ETEPRO (AUTOINCREM, ');
        Add('                     ETP_SEQPRO, ');
        Add('                     ETP_CODETE, ');
        Add('                     ETP_VALOR1, ');
        Add('                     ETP_STA_01, ');
        Add('                     ETP_VALOR2, ');
        Add('                     ETP_STA_02, ');
        Add('                     ETP_VALOR3, ');
        Add('                     ETP_STA_03) ');
        Add('              VALUES(:AUTINC,    ');
        Add('                     :SEQPRO,    ');
        Add('                     :CODETE,    ');
        Add('                     :VALOR1,    ');
        Add('                     :STA_01,    ');
        Add('                     :VALOR2,    ');
        Add('                     :STA_02,    ');
        Add('                     :VALOR3,    ');
        Add('                     :STA_03)    ');
      End;

      cdsEtePro.DisableControls;
      cdsEtePro.First;
      While not cdsEtePro.Eof Do
      Begin
        With qryAuxiliar Do
        Begin
          ParamByName('AUTINC').AsString := fRetAutoIncrem('ETEPRO', VS_strCodEmp);
          ParamByName('SEQPRO').AsString := cdsMovPro.FieldByName('AUTOINCREM').AsString;
          ParamByName('CODETE').AsString := cdsEtePro.FieldByName('CODETE').AsString;

          ParamByName('VALOR1').AsFloat  := cdsEtePro.FieldByName('VALOR1').AsFloat;
          ParamByName('VALOR2').AsFloat  := cdsEtePro.FieldByName('VALOR2').AsFloat;
          ParamByName('VALOR3').AsFloat  := cdsEtePro.FieldByName('VALOR3').AsFloat;

          ParamByName('STA_01').AsString := cdsEtePro.FieldByName('STA_01').AsString;
          ParamByName('STA_02').AsString := cdsEtePro.FieldByName('STA_02').AsString;
          ParamByName('STA_03').AsString := cdsEtePro.FieldByName('STA_03').AsString;

          If ParamByName('VALOR1').AsFloat = 0 Then
            ParamByName('VALOR1').Clear;

          If ParamByName('VALOR2').AsFloat = 0 Then
            ParamByName('VALOR2').Clear;

          If ParamByName('VALOR3').AsFloat = 0 Then
            ParamByName('VALOR3').Clear;


          ExecSQL;
        End;

        pStep;
        cdsEtePro.Next;

      End;

    Except
      On E : Exception Do
      Begin
        fRollBack;
        Result := False;
      End;
    End;
  Finally
    cdsTanPro.EnableControls;
    cdsEtePro.EnableControls;

    If Result Then
    Begin
      fCommit;
      If not blnSoGravar Then
      Begin
        edtOrdPro.Clear;
        fCarregaMovPro;
        pSetFocus(edtOrdPro);
      End;
    End
    Else
      fRollBack;

    FreeAndNil(qryAuxiliar);
  End;

End;

Procedure TfrmControleQualidadeProducao.pCarregaEteProEdicao;
Begin
  If (cdsEtePro.Active) And (cdsEtePro.RecordCount > 0) Then
  Begin
    edtCodEte.Text := cdsEtePro.FieldByName('CODETE').AsString;
    edtDesEte.Text := cdsEtePro.FieldByName('DESCRI').AsString;
    edtValSt1.Text := cdsEtePro.FieldByName('VALOR1').AsString;
    edtValSt2.Text := cdsEtePro.FieldByName('VALOR2').AsString;
    edtValSt3.Text := cdsEtePro.FieldByName('VALOR3').AsString;

    cxgEtePro.Enabled := False;
    pSetFocus(edtCodEte);

    btnAdicionaEtePro.Tag := Ord(dsEdit);
  End;
End;

procedure TfrmControleQualidadeProducao.pnlTopEteMatExit(Sender: TObject);
begin
  inherited;
  If btnAdicionaEtePro.Tag <> 0 Then
  Begin
    If fMensagem('', 'Deseja Cancelar a Edição da Especificação Técnica!', ['&Sim', '&Não'], 2) = 1 Then
      btnCancelaEteProClick(Nil)
    Else
      pSetFocus(edtCodEte);
  End;
end;

function TfrmControleQualidadeProducao.fGeraResumo(cxProgress : TcxProgressBar):Boolean;
  Var
    cdsClone : TUniClientDataSet;
    strEteAtu: String;

    fltValTT,
    fltVal01,
    fltVal02,
    fltVal03 : Double;

    intQtdTT,
    intQtd01,
    intQtd02,
    intQtd03 : Integer;

  Function fStatus(fltValor : Double):String;
  Begin
    If fltValor = 0 Then
    Begin
      Result := '';
      Exit;
    End;

    Result := IfThen((fltValor >= cdsClone.FieldByName('VALMIN').AsFloat) And
                     (fltValor <= cdsClone.FieldByName('VALMAX').AsFloat), 'AP', 'RP');

    If blnAprovado And (Result = 'RP') Then
      blnAprovado := False;
  End;

Begin
  Result := True;
  blnAprovado := True;
  Try
    cdsClone := TUniClientDataSet.Create(Self);
    cdsClone.CloneCursor(cdsEtePro, False, True);

    strEteAtu := '';
    cdsResumo.EmptyDataSet;

    cxProgress.Properties.Max := cdsEtePro.RecordCount;

    cdsEtePro.DisableControls;
    cdsEtePro.First;
    While Not cdsEtePro.Eof Do
    Begin
      If strEteAtu <> cdsEtePro.FieldByName('CODETE').AsString Then
      Begin
        fltVal01 := 0;
        fltVal02 := 0;
        fltVal03 := 0;
        fltValTT := 0;

        intQtd01 := 0;
        intQtd02 := 0;
        intQtd03 := 0;
        intQtdTT := 0;

        cdsClone.Filter   := 'CODETE = ' + QuotedStr(cdsEtePro.FieldByName('CODETE').AsString);
        cdsClone.Filtered := True;
        cdsClone.First;
        While not cdsClone.Eof Do
        Begin
          If cdsClone.FieldByName('VALOR1').AsFloat > 0 Then
          Begin
            fltVal01 := fltVal01 + cdsClone.FieldByName('VALOR1').AsFloat;
            inc(intQtd01);
          End;

          If cdsClone.FieldByName('VALOR2').AsFloat > 0 Then
          Begin
            fltVal02 := fltVal02 + cdsClone.FieldByName('VALOR2').AsFloat;
            inc(intQtd02);
          End;

          If cdsClone.FieldByName('VALOR3').AsFloat > 0 Then
          Begin
            fltVal03 := fltVal03 + cdsClone.FieldByName('VALOR3').AsFloat;
            inc(intQtd03);
          End;

          cdsClone.Next;
        End;

        If fltVal01 > 0 Then
        Begin
          fltValTT := fltValTT + fltVal01;
          inc(intQtdTT);
        End;

        If fltVal02 > 0 Then
        Begin
          fltValTT := fltValTT + fltVal02;
          inc(intQtdTT);
        End;

        If fltVal03 > 0 Then
        Begin
          fltValTT := fltValTT + fltVal03;
          inc(intQtdTT);
        End;

        cdsResumo.Append;
        cdsResumo.FieldByName('CODETE').AsString := cdsClone.FieldByName('CODETE').AsString;
        cdsResumo.FieldByName('DESCRI').AsString := cdsClone.FieldByName('DESCRI').AsString;
        cdsResumo.FieldByName('VALMIN').AsFloat  := cdsClone.FieldByName('VALMIN').AsFloat;
        cdsResumo.FieldByName('VALMAX').AsFloat  := cdsClone.FieldByName('VALMAX').AsFloat;
        cdsResumo.FieldByName('METODO').AsString := fRetDesMetodo(fCampoTabela('ETE_METODO', 'ESPTEC', ['ETE_CODIGO'], [cdsClone.FieldByName('CODETE').AsString]));
        cdsResumo.FieldByName('ESCALA').AsString := fCampoTabela('ETE_ESCALA', 'ESPTEC', ['ETE_CODIGO'], [cdsClone.FieldByName('CODETE').AsString]);

        cdsResumo.FieldByName('VALOR1').Clear;
        cdsResumo.FieldByName('VALOR2').Clear;
        cdsResumo.FieldByName('VALOR3').Clear;
        cdsResumo.FieldByName('VALORT').Clear;

        If (fltVal01 > 0) Then
          cdsResumo.FieldByName('VALOR1').AsFloat  := fltVal01 / intQtd01;

        If (fltVal02 > 0) Then
          cdsResumo.FieldByName('VALOR2').AsFloat  := fltVal02 / intQtd02;

        If (fltVal03 > 0) Then
          cdsResumo.FieldByName('VALOR3').AsFloat  := fltVal03 / intQtd03;

        If (fltValTT > 0) Then
          cdsResumo.FieldByName('VALORT').AsFloat  := fltValTT / intQtdTT;

        cdsResumo.FieldByName('STA_01').AsString := fStatus(cdsResumo.FieldByName('VALOR1').AsFloat);
        cdsResumo.FieldByName('STA_02').AsString := fStatus(cdsResumo.FieldByName('VALOR2').AsFloat);
        cdsResumo.FieldByName('STA_03').AsString := fStatus(cdsResumo.FieldByName('VALOR3').AsFloat);
        cdsResumo.FieldByName('STA_TT').AsString := fStatus(cdsResumo.FieldByName('VALORT').AsFloat);

        cdsResumo.Post;

      End;

      strEteAtu := cdsEtePro.FieldByName('CODETE').AsString;

      cdsEtePro.Next;

      cxProgress.Position := cxProgress.Position + 1;
    End;

  Finally
    FreeAndNil(cdsClone);
    cdsEtePro.First;
    cdsEtePro.EnableControls;
    pSetFocus(dbeSopro);
  End;

End;

procedure TfrmControleQualidadeProducao.pImprimirLaudo;
  Var
    cdsRelatorio : TZClient;
    cdsEmpresa   : TZClient;
Begin
  Try
    cdsEmpresa   := TZClient.Create(Self);
    With cdsEmpresa.qryQuery, SQL Do
    Begin
      Close;
      Clear;
      Add(' SELECT *                                     ');
      Add(' FROM CADEMP                                  ');
      Add(' INNER JOIN CADCID ON CID_CODCID = EMP_CODCID ');
      Add(' WHERE EMP_CODEMP = :CODEMP                   ');
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      cdsEmpresa.fAbreClient(True, 'TfrmControleQualidadeProducao.pImprimirLaudo');

      cdsEmpresa.Edit;
      cdsEmpresa.FieldByName('EMP_C_E_P_').AsString := fFormataCEP(cdsEmpresa.FieldByName('EMP_C_E_P_').AsString);
      cdsEmpresa.Post;

    End;

    cdsRelatorio := TZClient.Create(Self);
    With cdsRelatorio.qryQuery, SQL Do
    Begin
      Close;
      Clear;
      Add(' SELECT PRO_CODEMP AS CODEMP,                       ');
      Add('        PRO_CODPRO AS CODPRO,                       ');
      Add('        PRO_NUMDOC AS NUMDOC,                       ');
      Add('        PRO_ESPDOC AS ESPDOC,                       ');
      Add('        PRO_CODCLI AS CODCLI,                       ');
      Add('        PRO_CODITE AS CODITE,                       ');
      Add('        PRO_QTDAPR AS QTDAPR,                       ');
      Add('        PRO_QTDPRO AS QTDPRO,                       ');
      Add('        PRO_DTAPRO AS DTAPRO,                       ');
      Add('        PRO_DTACAD AS DTACAD,                       ');
      Add('        PRO_OBS001 AS OBS001,                       ');
      Add('        PRO_OBS002 AS OBS002,                       ');
      Add('        PRO_CONFER AS CONFER,                       ');
      Add('        PRO_DTABAI AS DTABAI,                       ');
      Add('        PRO_SEQIND AS SEQIND,                       ');
      Add('        PRO_ENDENT AS ENDENT,                       ');
      Add('        PRO_HORBAI AS HORBAI,                       ');
      Add('        PRO_SOPRO_ AS SOPRO_,                       ');
      Add('        PRO_ITERES AS ITERES,                       ');
      Add('        PRO_PERRES AS PERRES,                       ');
      Add('        PRO_DTAINI AS DTAINI,                       ');
      Add('        PRO_HRAINI AS HRAINI,                       ');
      Add('        PRO_RESPON AS RESPON,                       ');
      Add('        PRO_OBSQUA AS OBSQUA,                       ');
      Add('        PRO_QTDFAR AS QTDFAR,                       ');
      Add('        PRO_VALIDA AS VALIDA,                       ');
      Add('        PRO_EMILAU AS EMILAU,                       ');
      Add('        PRO_CMPORI AS CMPORI,                       ');
      Add('        PRO_NUMLOT AS NUMLOT,                       ');
      Add('      A.ITE_DESITE AS DESITE,                       ');
      Add('      A.ITE_REFERE AS REFERE,                       ');
      Add('        CLI_NOMCLI AS NOMCLI,                       ');
      Add('      B.ITE_DESITE AS DESRES,                       ');
      Add('      F.FOR_NOMFOR AS NOMFOR                        ');
      Add(' FROM MOVPRO                                        ');
      Add(' INNER JOIN CADITE A ON A.ITE_CODITE = PRO_CODITE   ');
      Add(' LEFT  JOIN CADCLI ON CLI_CODCLI = PRO_CODCLI       ');
      Add(' LEFT  JOIN CADITE B ON B.ITE_CODITE = PRO_ITERES   ');
      Add(' LEFT  JOIN CADITE P ON P.ITE_CODITE = PRO_ITEPIG   ');
      Add(' LEFT  JOIN CADFOR F ON F.FOR_CODFOR = P.ITE_CODFOR ');
      Add(' WHERE PRO_CODPRO = :CODPRO                         ');
      Add('   AND PRO_CODEMP = :CODEMP                         ');
    End;

    frxDBMovPro.DataSource := cdsRelatorio.dtsSource;
    frxDBTanPro.DataSource := cdsTanPro.dtsSource;
    frxDBResumo.DataSource := dtsResumo;
    frxDBEmpres.DataSource := cdsEmpresa.dtsSource;

    cdsRelatorio.qryQuery.ParamByName('CODPRO').AsString := edtOrdPro.Text;
    cdsRelatorio.qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;
    cdsRelatorio.fAbreClient(True, 'TfrmControleQualidadeProducao.pImprimirLaudo');

    If dbcCmpOri.Checked Then
    Begin
      frxReport.Script.Variables['X'] := '[ X ]';
      frxReport.Script.Variables['Y'] := '[    ]' ;
    End
    Else
    Begin
      frxReport.Script.Variables['X'] := '[    ]';
      frxReport.Script.Variables['Y'] := '[ X ]' ;
    End;

    frxReport.Script.Variables['RESULTADO'] := IfThen(blnAprovado, 'APROVADO', 'REPROVADO');

    If FileExists(fCfgSis('PATLOG',varString)) Then
      TfrxPictureView(frxReport.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('PATLOG'));

    If fCfgSis('LDOLOT',varBoolean) Then
      TfrxMemoView(frxReport.FindObject('mmLote')).Text := cdsRelatorio.qryQuery.FieldByName('NUMLOT').AsString
    else
      TfrxMemoView(frxReport.FindObject('mmLote')).Text := IntToStr(cdsRelatorio.qryQuery.FieldByName('CODPRO').AsInteger);

    pPreviewReport(Self.Name, Self.Caption + ' (Laudo)', frxReport);
  Finally
    FreeAndNil(cdsRelatorio);
  End;
End;

end.
