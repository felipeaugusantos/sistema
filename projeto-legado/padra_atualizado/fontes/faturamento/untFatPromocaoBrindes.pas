unit untFatPromocaoBrindes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, untZClient, DB, strUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask,
  MaskEditFocus, EditFocus, untPromocaoBrindes, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridBandedTableView, cxGridDBBandedTableView, cxClasses, cxGridCustomView,
  cxGrid, cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmFatPromocaoBrindes = class(TfrmPaiSimples)
    pnlHeader: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    chkSomenteComPontos: TCheckBox;
    Label5: TLabel;
    edtNumDoc: TEditFocus;
    Label4: TLabel;
    edtEspDoc: TEditFocus;
    Label1: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    btnCarregarVendas: TBitBtnLocked;
    pnlGridItens: TPanel;
    cxgItensVenda: TcxGrid;
    cxgItensVendaView: TcxGridDBBandedTableView;
    cxgItensVendaViewDTAENT: TcxGridDBBandedColumn;
    cxgItensVendaViewNUMDOC: TcxGridDBBandedColumn;
    cxgItensVendaViewESPDOC: TcxGridDBBandedColumn;
    cxgItensVendaViewCODEMP: TcxGridDBBandedColumn;
    cxgItensVendaViewCODVEN: TcxGridDBBandedColumn;
    cxgItensVendaViewCODITE: TcxGridDBBandedColumn;
    cxgItensVendaViewDESCRI: TcxGridDBBandedColumn;
    cxgItensVendaViewCLAFIS: TcxGridDBBandedColumn;
    cxgItensVendaViewSIGUNI: TcxGridDBBandedColumn;
    cxgItensVendaViewQTDITE: TcxGridDBBandedColumn;
    cxgItensVendaViewUNITAR: TcxGridDBBandedColumn;
    cxgItensVendaViewTOTITE: TcxGridDBBandedColumn;
    cxgItensVendaViewPONBRI: TcxGridDBBandedColumn;
    cxgItensVendaViewITESEL: TcxGridDBBandedColumn;
    cxgItensVendaLevel: TcxGridLevel;
    btnMarcarDesmarcar: TBitBtnLocked;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    Panel1: TPanel;
    edtPonTot: TEditFocus;
    Label7: TLabel;
    Label8: TLabel;
    edtPonSel: TEditFocus;
    btnFechamento: TBitBtnLocked;
    pnlLegDevolucao: TPanel;
    shp1: TShape;
    lbl1: TLabel;
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnCarregarVendasClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
    procedure btnMarcarDesmarcarClick(Sender: TObject);
    procedure cxgItensVendaViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgItensVendaViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnFechamentoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    objEmitirBrinde: TFatEmitirBrindePromocao;
    procedure pCancelar;
    procedure pAtualizaTotalPontos;
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pEscapePressed; override;
  public
    { Public declarations }
    strOperador: String;
    blnFatVenda: Boolean;
  end;


implementation

{$R *.dfm}

uses untTypesSistema, untConsultas, untFuncoesSimples, untConstantes,
  untFatPromocaoBrindesResumo, untGravando;

procedure TfrmFatPromocaoBrindes.btnCarregarVendasClick(Sender: TObject);
begin
  inherited;
  If fValidaPanel(pnlHeader) Then
  Begin
    objEmitirBrinde.strCliente   := edtCodCli.Text;
    objEmitirBrinde.strDocumento := edtNumDoc.Text;
    objEmitirBrinde.strEspecie   := edtEspDoc.Text;
    objEmitirBrinde.strEmpresa   := edtCodEmp.Text;
    objEmitirBrinde.dtaDataInicial := strToDateDef(mskDtaIni.Text, 0);
    objEmitirBrinde.dtaDataFinal   := strToDateDef(mskDtaFin.Text, 0);
    objEmitirBrinde.blnSomenteComPontos := chkSomenteComPontos.Checked;

    If objEmitirBrinde.fCarregarItensVenda Then
    Begin
      pnlHeader.Enabled := False;
      pnlGridItens.Enabled := True;
      pSetFocus(cxgItensVenda);
    End
    Else
    Begin
      pMensagemOk('Nenhum documento de venda foi encontrado!');
      SelectFirst;
    End;

    pAtualizaTotalPontos;
  End;
end;

procedure TfrmFatPromocaoBrindes.pAtualizaTotalPontos;
begin
  edtPonTot.text := FormatFloat('#,##0.00', objEmitirBrinde.fltTotalPontosVendas);
  edtPonSel.text := FormatFloat('#,##0.00', objEmitirBrinde.fltTotalPontosSelecionado);

  If fStrToFloat(edtPonTot.Text) < 0 Then edtPonTot.Font.Color := clRed Else edtPonTot.Font.Color := clGreen;
  If fStrToFloat(edtPonSel.Text) < 0 Then edtPonSel.Font.Color := clRed Else edtPonSel.Font.Color := clGreen;
end;

procedure TfrmFatPromocaoBrindes.btnDesmarcarTodosClick(Sender: TObject);
begin
  inherited;
  If pnlGridItens.Enabled Then
  Begin
    objEmitirBrinde.pMarcarTodos('N');
    pAtualizaTotalPontos;
  End;
end;

procedure TfrmFatPromocaoBrindes.btnFechamentoClick(Sender: TObject);
  Var
    frmGravar: TfrmGravando;
begin
  inherited;
  If pnlGridItens.Enabled Then
  Begin
    Try
      if objEmitirBrinde.cdsItensVenda.RecordCount > 0 then
      begin
        objEmitirBrinde.cdsItensVenda.First;

        while not objEmitirBrinde.cdsItensVenda.Eof do
        begin
          if objEmitirBrinde.cdsItensVenda.FieldByName('ITESEL').AsString = 'N' then
          begin
            objEmitirBrinde.cdsItensVenda.Next;
            Continue;
          end;

          if objEmitirBrinde.cdsItensVenda.FieldByName('ENTFAT').AsString = 'N' then
          begin
            objEmitirBrinde.strEntRet := 'R';
            Break;
          end
          else
          begin
            objEmitirBrinde.strEntRet := 'E';
          end;

          objEmitirBrinde.cdsItensVenda.Next;
        end;
      end;

      pCriarFormularios(TfrmGravando, frmGravar);
      frmGravar.fExecutarAcao := objEmitirBrinde.fEmitirDocumentoBrinde;
      frmGravar.ShowModal;
      If frmGravar.blnConfirma Then
        pCancelar;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;
    pFreeAndNil(frmGravar);
  End;
end;

procedure TfrmFatPromocaoBrindes.btnMarcarDesmarcarClick(Sender: TObject);
begin
  inherited;
  If pnlGridItens.Enabled Then
  Begin
    objEmitirBrinde.pSelecionarItem;
    pAtualizaTotalPontos;
  End;
end;

procedure TfrmFatPromocaoBrindes.btnMarcarTodosClick(Sender: TObject);
begin
  inherited;
  If pnlGridItens.Enabled Then
  Begin
    objEmitirBrinde.pMarcarTodos('S');
    pAtualizaTotalPontos;
  End;
end;

procedure TfrmFatPromocaoBrindes.cxgItensVendaViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If Assigned(objEmitirBrinde) And objEmitirBrinde.cdsItensVenda.Active Then
  Begin
    If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensVendaViewCLAFIS.Index]) < '5000' Then
      ACanvas.Font.Color  := clRed;

    If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensVendaViewITESEL.Index]) = 'S' Then
    Begin
      If AViewInfo.Selected Then
      Begin
        ACanvas.Brush.Color := clHighlight;
        ACanvas.Font.Color  := clLime;
      End
      Else
        ACanvas.Brush.Color := clMoneyGreen;
    End;
  End;
end;

procedure TfrmFatPromocaoBrindes.cxgItensVendaViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN: btnMarcarDesmarcar.Click;
    VK_F10   : Begin
                 Key := 0;
                 btnFechamento.Click;
               End;
    VK_F2    : btnMarcarTodos.Click;
    VK_F3    : btnDesmarcarTodos.Click;
    VK_ESCAPE: pEscapePressed;
  End;
end;

procedure TfrmFatPromocaoBrindes.edtCodCliKeyPress(Sender: TObject; var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatPromocaoBrindes.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmpresas: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmpresas) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatPromocaoBrindes.FormActivate(Sender: TObject);
begin
  inherited;
  SelectFirst;
  objEmitirBrinde.strOperador := strOperador;
end;

procedure TfrmFatPromocaoBrindes.FormCreate(Sender: TObject);
begin
  inherited;
  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);
  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);
  strOperador    := strLoginUsuarioLogado;

  objEmitirBrinde := TFatEmitirBrindePromocao.Create;
  cxgItensVendaView.DataController.DataSource := objEmitirBrinde.cdsItensVenda.dtsSource;

  pAtualizaTotalPontos;

  edtNumDoc.MaxLength := fTamDocCadRec();
  edtNumDoc.TamCampo  := edtNumDoc.MaxLength;

  blnFatVenda := False;
end;

procedure TfrmFatPromocaoBrindes.FormDestroy(Sender: TObject);
begin
  If Assigned(objEmitirBrinde) Then
    FreeAndNil(objEmitirBrinde);
  inherited;
end;

procedure TfrmFatPromocaoBrindes.FormShow(Sender: TObject);
begin
  inherited;
  objEmitirBrinde.blnFatVenda := blnFatVenda;
end;

function TfrmFatPromocaoBrindes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin
    If (Sender = edtCodCli) Then
    Begin
      If fEmptyStr(edtCodCli.Text) Then
      Begin
        pMensagemOk('Informe o código do cliente!');
        Result := False;
      End
      Else
      Begin
        edtNomCli.Text := fRetNomCliente(edtCodCli.Text);
        If fEmptyStr(edtNomCli.Text) Then
        Begin
          pMensagemOk('Nenhum cliente encontrado com este código!');
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtNumDoc) Then
    Begin
      mskDtaIni.Enabled := True;
      mskDtaFin.Enabled := True;

      If Not fEmptyStr(edtNumDoc.Text) Then
      Begin
        mskDtaIni.Enabled := False;
        mskDtaFin.Enabled := False;
        mskDtaIni.Clear;
        mskDtaFin.Clear;
      End;

      If fEmptyStr(edtNumDoc.Text) And fClienteConsumidor(edtNomCli.Text,True,True) Then
      Begin
        pMensagemOk('Favor informar o número do documento!');
        Result := False;
      End
    End

    Else If (Sender = edtEspDoc) Then
    Begin
      If fEmptyStr(edtEspDoc.Text) And (Not fEmptyStr(edtNumDoc.Text)) Then
      Begin
        pMensagemOk('Favor informar a espécie do documento!');
        Result := False;
      End
    End

    Else If (Sender = edtCodEmp) Then
    Begin
      edtDesEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);

      If fEmptyStr(edtCodEmp.Text) And (Not fEmptyStr(edtNumDoc.Text)) Then
      Begin
        pMensagemOk('Favor informar a empresa de emissão do documento!');
        Result := False;
      End
      Else If Not fEmptyStr(edtCodEmp.Text) Then
      Begin
        If fEmptyStr(edtDesEmp.Text) Then
        Begin
          pMensagemOk('Nenhuma empresa encontrada com este código!');
          Result := False;
        End
        Else If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          pMensagemOk('Usuário sem direito de acesso a esta empresa!');
          Result := False;
        End;
      End;
    End

    Else If (sender = mskDtaIni) And mskDtaIni.Enabled Then
    Begin
      If strToDateDef(mskDtaIni.Text, 0) = 0 Then
      Begin
        pMensagemOk('Informe a data inicial corretamente!');
        Result := False;
      End;
    End

    Else If (sender = mskDtaFin) And mskDtaFin.Enabled Then
    Begin
      If strToDateDef(mskDtaFin.Text, 0) = 0 Then
      Begin
        pMensagemOk('Informe a data final corretamente!');
        Result := False;
      End;
    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFatPromocaoBrindes.pEscapePressed;
begin
  If pnlGridItens.Enabled Then
  Begin
    If fPergunta('Deseja cancelar a emissão do(s) brinde(s)?') Then
      pCancelar;
  End
  Else
    inherited;
end;

procedure TfrmFatPromocaoBrindes.pCancelar;
begin
  objEmitirBrinde.cdsItensVenda.Close;
  pnlHeader.Enabled := True;
  pnlGridItens.Enabled := False;
  pAtualizaTotalPontos;
  SelectFirst;
end;

end.
