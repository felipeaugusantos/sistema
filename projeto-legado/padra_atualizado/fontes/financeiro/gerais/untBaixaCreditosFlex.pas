unit untBaixaCreditosFlex;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  EditFocus, Mask, MaskEditFocus,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, cxGridBandedTableView, cxGridDBBandedTableView,
  BitBtnLockedIncrem, ComCtrls, untZClient, cxLookAndFeels,
  cxLookAndFeelPainters, cxNavigator, untBaiCreFlex, untFuncoesSimples,
  cxContainer, cxProgressBar, untMovFlex, frxClass,
  frxExportCSVTestabilidade, untTypesSistema,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmBaixaCreditosFlex = class(TfrmPaiConfirma)
    pnlCabecalho: TPanel;
    dtsBaiCre: TDataSource;
    cxStyleRepository: TcxStyleRepository;
    cxsTitulo1: TcxStyle;
    cxsTitulo2: TcxStyle;
    cxsFatura: TcxStyle;
    cxsTitulo3: TcxStyle;
    cxsEntFut: TcxStyle;
    btnConBai: TBitBtnLocked;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    lbl1: TLabel;
    mskDtaIni: TMaskEditFocus;
    lbl2: TLabel;
    mskDtaFin: TMaskEditFocus;
    lblDesDtaFin: TLabel;
    lbl3: TLabel;
    edtCodVen: TEditFocus;
    edtNomVen: TEditFocus;
    lblEmpresa: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    lbl4: TLabel;
    mskLinGru: TMaskEditFocus;
    edtNomGru: TEditFocus;
    lbl5: TLabel;
    edtCodMar: TEditFocus;
    edtNomMar: TEditFocus;
    edtCodPro: TEditFocus;
    edtNomPro: TEditFocus;
    lbl6: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    lbl7: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    lbl8: TLabel;
    rdgOpcao: TRadioGroup;
    cxgConsultaDBTableView: TcxGridDBTableView;
    cxgConsultaLevel1: TcxGridLevel;
    cxgConsulta: TcxGrid;
    cxgConsultaVENREP: TcxGridDBColumn;
    cxgConsultaVALSEL: TcxGridDBColumn;
    cxgConsultaPEREMP: TcxGridDBColumn;
    cxgConsultaVALEMP: TcxGridDBColumn;
    cxgConsultaPEVERE: TcxGridDBColumn;
    cxgConsultaVRVERE: TcxGridDBColumn;
    cxgConsultaMARDES: TcxGridDBColumn;
    lbl10: TLabel;
    cxgConsultaAUTINC: TcxGridDBColumn;
    shpMultSel: TShape;
    pnlTotais: TPanel;
    pgbProgresso: TcxProgressBar;
    cxgConsultaDTALAN: TcxGridDBColumn;
    cxgConsultaDOCUME: TcxGridDBColumn;
    cxgConsultaCLIENT: TcxGridDBColumn;
    cxgConsultaPRODUT: TcxGridDBColumn;
    cxgConsultaHISTOR: TcxGridDBColumn;
    shpConFle: TShape;
    gpbSelecionados: TGroupBox;
    lbl11: TLabel;
    lblCreSel: TLabel;
    lblDebSel: TLabel;
    lblDifSel: TLabel;
    edtQtdSel: TEditFocus;
    edtCreSel: TEditFocus;
    edtDebSel: TEditFocus;
    edtDifSel: TEditFocus;
    gpbGeral: TGroupBox;
    lblDebGer: TLabel;
    lblCreGer: TLabel;
    lbl12: TLabel;
    lblDifGer: TLabel;
    edtDebGer: TEditFocus;
    edtCreGer: TEditFocus;
    edtSldIni: TEditFocus;
    edtDifGer: TEditFocus;
    btnMovFle: TBitBtnLocked;
    lbl13: TLabel;
    lbl14: TLabel;
    shp1: TShape;
    shp2: TShape;
    cxgConsultaCONCIL: TcxGridDBColumn;
    ckbPedFle: TCheckBox;
    edtSldFin: TEditFocus;
    lbl15: TLabel;
    btnMarcaDesmarca: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure mskLinGruExit(Sender: TObject);
    procedure edtCodVenExit(Sender: TObject);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarExit(Sender: TObject);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodProExit(Sender: TObject);
    procedure edtCodProKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure cxgConsultaDBTableViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnConBaiClick(Sender: TObject);
    procedure cxgConsultaDBTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure pAtualizarTotais;
    procedure FormShow(Sender: TObject);
    procedure btnMovFleClick(Sender: TObject);
    procedure rdgOpcaoClick(Sender: TObject);
    procedure btnMarcaDesmarcaClick(Sender: TObject);
  private
    objBaiCre : TBaiCreFlex;
    arrCodVen : TConsultasArray;
    arrCodEmp : TConsultasArray;
    arrCodCli : TConsultasArray;
    arrCodFor : TConsultasArray;
    arrCodMar : TConsultasArray;
    arrCodPro : TConsultasArray;
    arrLinGru : TConsultasArray;
    blnConFle : Boolean;
    procedure pLimparCampos;
    procedure pRegistrarProgresso(strTexto: String; intAtual, intFinal: Integer);
    procedure pDesmarcarTodos;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;


const
  CAPTION_MAR_TODOS = '[F9]Marcar Todos';
  CAPTION_DES_TODOS = '[F9]Desmarcar Todos';

implementation

{$R *.dfm}

uses untFuncoesConsulta, untConsultas, untConfirmaBaixaCreditosFlex,
     untCadMovFlex;

function TfrmBaixaCreditosFlex.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If Inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    With objBaiCre Do
    Begin
      Try
        strCreDeb := 'T';

        If (Sender = mskDtaIni) Then
        Begin
          strDtaIni := mskDtaIni.Text;

          If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
          Begin
            fMensagem('ATENÇÃO!','O campo Data Inicial deve ser preenchido!', ['&OK']);
            Result := False;
          End;
        End;

        If (Sender = mskDtaFin) Then
        Begin
          strDtaFin := mskDtaFin.Text;

          If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
          Begin
            fMensagem('ATENÇÃO!','O campo Data Final deve ser preenchido!', ['&OK']);
            Result := False;
          End;
        End;

        If (Sender = edtCodVen) Then
        Begin
          strCodVen := edtCodVen.Text;
          arrVended := arrCodVen;
        End;

        If (Sender = edtCodCli) Then
        Begin
          strCodCli := edtCodCli.Text;
          arrClient := arrCodCli;
        End;

        If (Sender = edtCodFor) Then
        Begin
          strCodFor := edtCodFor.Text;
          arrFornec := arrCodFor;
        End;

        If (Sender = edtCodMar) Then
        Begin
          strCodMar := edtCodMar.Text;
          arrMarca_ := arrCodMar;
        End;

        If (Sender = edtCodPro) Then
        Begin
          strCodPro := edtCodPro.Text;
          arrProdut := arrCodPro;
        End;

        If (Sender = edtCodEmp) Then
        Begin
          strCodEmp := edtCodEmp.Text;
          arrEmpres := arrCodEmp;
        End;

        If (Sender = mskLinGru) Then
        Begin
          strLinGru := fTiraCaracEspeciais(mskLinGru.Text);
          arrGrupo_ := arrLinGru;
        End;

        If (Sender = rdgOpcao) Then
        Begin
          Case rdgOpcao.ItemIndex Of
            0: tpcConcil := tpcNaoConciliados;
            1: tpcConcil := tpcConciliados;
            2: tpcConcil := tpcTodos;
          End;
        End;

        If (Sender = ckbPedFle) Then
        Begin
          blnPedFle := ckbPedFle.Checked;
        End;

      Except
        On E: Exception Do
        Begin
          Result := False;
          fMensagemTratada(E);
        End;
      End;

      strQuebra := 'V';
      edtNomVen.Text := strNomVen;
      edtNomCli.Text := strNomCli;
      edtNomFor.Text := strNomFor;
      edtNomPro.Text := strNomPro;
      edtNomEmp.Text := strNomEmp;
      edtNomGru.Text := strNomGru;
      edtNomMar.Text := strNomMar;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmBaixaCreditosFlex.mskLinGruExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinGru, edtNomGru, arrLinGru, fRetNomeLinhaGrupo, Nil, 'da Linha/Grupo', 6);
end;

procedure TfrmBaixaCreditosFlex.mskLinGruKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupo(Self, mskLinGru, edtNomGru, Nil, Key, arrLinGru, False) Then
  Begin
    If fValidaCampos(mskLinGru, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBaixaCreditosFlex.pAtualizarTotais;
begin
  edtSldIni.Text := objBaiCre.strSldIni;
  edtSldFin.Text := objBaiCre.strSldFin;

  edtQtdSel.Text := objBaiCre.strQtdSel;
  edtCreSel.Text := objBaiCre.strCreSel;
  edtDebSel.Text := objBaiCre.strDebSel;
  edtDifSel.Text := objBaiCre.strDifSel;

  edtCreGer.Text := objBaiCre.strCreGer;
  edtDebGer.Text := objBaiCre.strDebGer;
  edtDifGer.Text := objBaiCre.strDifGer;

  pgbProgresso.Visible := False;
  pnlInfo.Caption := '';

  Application.ProcessMessages;
end;

procedure TfrmBaixaCreditosFlex.pLimparCampos;
  Var
    intCnt : Integer; 
begin
  For intCnt := 0 To (ComponentCount-1) Do
  Begin
    If (Components[intCnt] Is TEditFocus) Then
      TEditFocus(Components[intCnt]).Clear
    Else If (Components[intCnt] Is TMaskEditFocus) Then
      TMaskEditFocus(Components[intCnt]).Clear;
  End;

  pgbProgresso.Visible := False;
  pnlInfo.Caption := '';

  With objBaiCre Do
  Begin
    strCodVen := '';
    strCodRep := '';
    strCodEmp := '';
    strCodCli := '';
    strLinGru := '';
    strCodFor := '';
    strCodMar := '';
    strCodPro := '';
  End;

  pgbProgresso.Visible := False;
  pnlInfo.Caption := '';
end;

procedure TfrmBaixaCreditosFlex.rdgOpcaoClick(Sender: TObject);
begin
  inherited;
  If (btnConBai.Enabled) Then 
    btnConBai.Enabled := (rdgOpcao.ItemIndex <> 2);
end;

procedure TfrmBaixaCreditosFlex.btnAdicionarClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos Then
    Exit;

  pAtualizarTotais;
  objBaiCre.objLock.pDestravarTodos;

  dtsBaiCre.DataSet := objBaiCre.DataSetBaiCre;

  If (dtsBaiCre.DataSet.IsEmpty) Then
  Begin
    pLimparCampos;
    fMensagem('', 'Não há dados para gerar a conciliação de Créditos/Débitos!', ['&OK']);
    Exit;
  End;

  pAtualizarTotais;
  cxgConsultaDBTableView.ApplyBestFit;

  btnConBai.Enabled := (rdgOpcao.ItemIndex <> 2);

  pSetFocus(cxgConsulta);
end;

procedure TfrmBaixaCreditosFlex.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  btnConBai.Enabled := False;
  dtsBaiCre.DataSet := Nil;
  objBaiCre.objLock.pDestravarTodos;
  pDesmarcarTodos;
  pLimparCampos;
  pSetFocus(mskDtaIni);
end;

procedure TfrmBaixaCreditosFlex.btnConBaiClick(Sender: TObject);
begin
  inherited;

  If (Not btnConBai.Enabled) Then
    Exit;

  If (StrToIntDef(objBaiCre.strQtdSel,0) = 0) Then
  Begin
    fMensagem('Aviso', 'Nenhum registro selecionado.', ['&OK']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmConfirmaBaixaCreditosFlex, frmConfirmaBaixaCreditosFlex);
    frmConfirmaBaixaCreditosFlex.objBaiCre := objBaiCre;
    frmConfirmaBaixaCreditosFlex.blnConcil := (objBaiCre.tpcConcil = tpcConciliados);
    If (Not frmConfirmaBaixaCreditosFlex.blnConcil) Then
      frmConfirmaBaixaCreditosFlex.Caption := 'Conciliação de Débitos FLEX'
    Else
      frmConfirmaBaixaCreditosFlex.Caption := 'Conciliação de Créditos FLEX';
    frmConfirmaBaixaCreditosFlex.ShowModal;
    If (frmConfirmaBaixaCreditosFlex.blnConfirma) Then
      btnCancelaItem.Click;
  Finally
    pFreeAndNil(frmConfirmaBaixaCreditosFlex);
  End;

  pgbProgresso.Visible := False;
  pnlInfo.Caption := '';  
end;

procedure TfrmBaixaCreditosFlex.btnMarcaDesmarcaClick(Sender: TObject);
begin
  inherited;
  If (btnMarcaDesmarca.Caption = CAPTION_DES_TODOS) Then
  Begin
    pDesmarcarTodos;
  End
  Else
  Begin
    objBaiCre.pMarcarDesmarcarTodos(True);
    btnMarcaDesmarca.Caption := CAPTION_DES_TODOS;
  End;
  pAtualizarTotais;
end;

procedure TfrmBaixaCreditosFlex.pDesmarcarTodos;
begin
  If (Assigned(dtsBaiCre.DataSet)) Then
    objBaiCre.pMarcarDesmarcarTodos(False);
  btnMarcaDesmarca.Caption := CAPTION_MAR_TODOS;
end;

procedure TfrmBaixaCreditosFlex.btnMovFleClick(Sender: TObject);
begin
  inherited;
  If (btnMovFle.Enabled) Then
    pCriarForm(TfrmCadMovFlex);
end;

procedure TfrmBaixaCreditosFlex.cxgConsultaDBTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If (Not Sender.DataController.Active) Then
    Exit;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgConsultaCONCIL.Index]) = 'C' Then
    ACanvas.Font.Color := clBlue
  Else
    ACanvas.Font.Color := clBlack;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgConsultaMARDES.Index]) = 'M' Then
  Begin
    If AViewInfo.Selected Then
      ACanvas.Brush.Color := clLime
    Else
      ACanvas.Brush.Color := clAqua;
  End;
end;

procedure TfrmBaixaCreditosFlex.cxgConsultaDBTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
  Var
    DataSet : TDataSet;  
begin
  inherited;
  If Assigned(cxgConsultaDBTableView.DataController.DataSource.DataSet) Then
    DataSet := cxgConsultaDBTableView.DataController.DataSource.DataSet
  Else
    DataSet := Nil;

  If (Assigned(DataSet)) And
     (DataSet.Active) And
     (Not DataSet.IsEmpty) Then
  Begin
    Case Key Of
      VK_RETURN:
      Begin
        objBaiCre.pMarcarDesmarcarRegistro(DataSet.FieldByName('AUTINC').AsString,
                                           DataSet.FieldByName('MARDES').AsString = 'D');

        pAtualizarTotais;
      End;
    End;
  End;
end;

procedure TfrmBaixaCreditosFlex.edtCodCliExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCli, edtNomCli, arrCodCli, Nil, fRetNomCliente, 'do Cliente');
end;

procedure TfrmBaixaCreditosFlex.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrCodCli, False) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBaixaCreditosFlex.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrCodEmp, fRetNomeEmpresa, Nil, 'da Empresa', 3);
end;

procedure TfrmBaixaCreditosFlex.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrCodEmp, False, True) Then
  Begin
    If fValidaCampos(edtCodEmp, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBaixaCreditosFlex.edtCodForExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFor, edtNomFor, arrCodFor, fRetNomFornecedor, Nil, 'do Fornecedor', 8);
end;

procedure TfrmBaixaCreditosFlex.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrCodFor, False) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBaixaCreditosFlex.edtCodMarExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodMar, edtNomMar, arrCodMar, fRetNomMarca, Nil, 'da Marca');
end;

procedure TfrmBaixaCreditosFlex.edtCodMarKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqMarcas(Self, edtCodMar, edtNomMar, Nil, Key, arrCodMar, False) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBaixaCreditosFlex.edtCodProExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodPro, edtNomPro, arrCodPro, Nil, fRetNomProduto, 'do Produto');
end;

procedure TfrmBaixaCreditosFlex.edtCodProKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqItem(conIteSimples, Self, edtCodPro, edtNomPro, Nil, Key, arrCodPro, False, Nil, 'Consulta de Itens', '1') then
  Begin
    If fValidaCampos(edtCodPro,False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBaixaCreditosFlex.edtCodVenExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodVen, edtNomVen, arrCodVen, fRetNomVendRep, Nil, 'do Vendedor');
end;

procedure TfrmBaixaCreditosFlex.edtCodVenKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fPesqOperador(Self, edtCodVen, edtNomVen, nil, Key, arrCodVen, False)) then
  Begin
    If fValidaCampos(edtCodVen, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBaixaCreditosFlex.FormActivate(Sender: TObject);
begin
  inherited;
  btnMarcaDesmarca.Caption := CAPTION_MAR_TODOS;

  cxgConsultaVENREP.Caption := 'VENDEDOR';
  cxgConsultaPEVERE.Caption := '% VEN.';
  cxgConsultaVRVERE.Caption := 'VR. VENDEDOR';

  pSetFocus(mskDtaIni);
end;

procedure TfrmBaixaCreditosFlex.FormCreate(Sender: TObject);
begin
  inherited;
  objBaiCre := TBaiCreFlex.Create(Self);
  objBaiCre.onProgresso := pRegistrarProgresso;
  blnConFle := fVerificaAcessoSistema('CONFLE');
  btnMovFle.Enabled := fVerificaAcessoSistema('frmCadMovFlex');
  pSetaCodIte(edtCodPro);
end;

procedure TfrmBaixaCreditosFlex.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(objBaiCre);
end;

procedure TfrmBaixaCreditosFlex.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  Var
    DataSet : TDataSet;
begin
  inherited;

  If (Key = VK_F8) Then
    btnMovFle.Click;

  If Assigned(cxgConsultaDBTableView.DataController.DataSource.DataSet) Then
    DataSet := cxgConsultaDBTableView.DataController.DataSource.DataSet
  Else
    DataSet := Nil;

  If (Assigned(DataSet)) And
     (DataSet.Active) And
     (Not DataSet.IsEmpty) Then
  Begin
    Case Key Of
      VK_F10 : btnConBai.Click;
      VK_F9  : btnMarcaDesmarca.Click;
    End;
  End;
end;

procedure TfrmBaixaCreditosFlex.FormShow(Sender: TObject);
begin
  inherited;
  If (Not blnConFle) Then
  Begin
    rdgOpcao.Enabled := False;
    shpConFle.Brush.Color := clRed;
  End
  Else
  Begin
    rdgOpcao.Enabled := True;
    shpConFle.Brush.Color := clGreen;
  End;
end;

procedure TfrmBaixaCreditosFlex.pRegistrarProgresso(strTexto: String; intAtual, intFinal: Integer);
begin
  pgbProgresso.Visible := True;
  pgbProgresso.Properties.Min := 0;
  pgbProgresso.Properties.Max := intFinal;
  pgbProgresso.Position := intAtual;
  pnlInfo.Caption := strTexto;
  Application.ProcessMessages;
end;

end.
