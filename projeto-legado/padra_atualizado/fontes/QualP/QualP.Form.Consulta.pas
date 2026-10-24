
unit QualP.Form.Consulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, untFuncFat,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, EditFocus, Vcl.Mask,
  MaskEditFocus, QualP.Classe.Controle, ComboBoxFocus;

type
  TfrmConsultaQualP = class(TfrmPaiSimples)
    dtsQualP: TDataSource;
    pnlFundo: TPanel;
    pnlInformacoesQualP: TPanel;
    lbl16: TLabel;
    lbl19: TLabel;
    mskPlaVei: TMaskEditFocus;
    edtDesVei: TEditFocus;
    grdQualP: TcxGridCitel;
    grdQualPDBTableViewCitel1: TcxGridDBTableViewCitel;
    grdQualPLevel1: TcxGridLevel;
    Panel1: TPanel;
    BitBtnLocked2: TBitBtnLocked;
    btnOk: TBitBtnLocked;
    edtTempoEstimadoDuracao: TEditFocus;
    Label1: TLabel;
    edtDistancia: TEditFocus;
    Label2: TLabel;
    Label3: TLabel;
    edtCustoCombustivel: TEditFocus;
    Label5: TLabel;
    edtTotalFrete: TEditFocus;
    Label6: TLabel;
    edtQuantidadeEixos: TEditFocus;
    Label8: TLabel;
    edtCustoPedagio: TEditFocus;
    grdQualPDBTableViewCitel1Column1: TcxGridDBColumn;
    grdQualPDBTableViewCitel1Column2: TcxGridDBColumn;
    grdQualPDBTableViewCitel1Column3: TcxGridDBColumn;
    pnlLinkTabela: TPanel;
    Label4: TLabel;
    edtLinkQualP: TEditFocus;
    cmbTabelaFrete: TComboBoxFocus;
    Label7: TLabel;
    Label9: TLabel;
    edtAcrescimoVeiculo: TEditFocus;
    procedure mskPlaVeiKeyPress(Sender: TObject; var Key: Char);
    procedure cmbTabelaFreteSelect(Sender: TObject);
    procedure dtsQualPDataChange(Sender: TObject; Field: TField);
    procedure mskPlaVeiExit(Sender: TObject);
    procedure mskPlaVeiChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FControleQualP       : TControleQualP;
    FBlnItemSelecionado  : Boolean;
    FProcPrepararCalculo : TProc;
    FProcCalcular        : TProc;
    FIncluirValorFrete   : Boolean;
    FFatVenda            : TFatVenda;

    procedure pLimparCampos;
    procedure pCarregarInformacoesResposta;
    procedure pRequisicaoQualP;
    procedure pCalcular;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  public
    { Public declarations }
    function fSetControleQualP(const Value: TControleQualP): TfrmConsultaQualP;
    function fSetFatVenda(const Value: TFatVenda): TfrmConsultaQualP;
    function fAbrirConsultaQualP(const ADataSet: TDataSet;
      const AProcPrepararCalculo, AProcCalcular: TProc;
      const AControl: TWinControl=nil): TfrmConsultaQualP;

    property blnItemSelecionado: Boolean read FBlnItemSelecionado;

  end;

implementation

uses
  untFuncoesSimples, untConstantes, untConsultas, untFuncoesConsulta,
  untTypesSistema, UniClientDataSet;

{$R *.dfm}

procedure TfrmConsultaQualP.cmbTabelaFreteSelect(Sender: TObject);
begin
  inherited;
  dtsQualP.DataSet.Filtered := False;

  if cmbTabelaFrete.ItemIndex > -1 then
  begin
    dtsQualP.DataSet.Filter   := 'TABELA = '+QuotedStr(Copy(cmbTabelaFrete.Text,1,1));
    dtsQualP.DataSet.Filtered := True;
  end;

  dtsQualP.DataSet.First;
end;

procedure TfrmConsultaQualP.dtsQualPDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  if not FIncluirValorFrete then
    Exit;

  if (not dtsQualP.DataSet.Active) or
     (dtsQualP.DataSet.RecordCount =0) or
     (not Assigned(FProcCalcular)) then
    Exit;

  pCalcular;
end;

function TfrmConsultaQualP.fAbrirConsultaQualP(const ADataSet: TDataSet;
  const AProcPrepararCalculo, AProcCalcular: TProc;
  const AControl: TWinControl): TfrmConsultaQualP;
begin
  Result                := Self;
  FBlnItemSelecionado   := False;
  btnOk.Enabled         := False;

  dtsQualP.DataSet      := ADataSet;
  FProcPrepararCalculo  := AProcPrepararCalculo;
  FProcCalcular         := AProcCalcular;
  FIncluirValorFrete    := not Assigned(AControl);
  pnlLinkTabela.Visible := FIncluirValorFrete;

  if not fEmptyStr(FControleQualP.PlacaVeiculo) then
  begin
    mskPlaVei.Text := FControleQualP.PlacaVeiculo;
    fValidaCampos(mskPlaVei, True);
  end;

  if FIncluirValorFrete then
    FBlnItemSelecionado := (Self.ShowModal = mrOk)
  else
    pnlInformacoesQualP.Parent := AControl;
end;

procedure TfrmConsultaQualP.FormCreate(Sender: TObject);
begin
  inherited;
  cmbTabelaFrete.Items.AddStrings(TControleQualP.fListaTabelaFrete);
end;

function TfrmConsultaQualP.fSetControleQualP(
  const Value: TControleQualP): TfrmConsultaQualP;
begin
  Result := Self;

  FControleQualP := Value;
end;

function TfrmConsultaQualP.fSetFatVenda(
  const Value: TFatVenda): TfrmConsultaQualP;
begin
  Result := Self;

  FFatVenda := Value;
end;

function TfrmConsultaQualP.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  Try
    If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
    Begin
      If (Sender = mskPlaVei) And (blnBuscaPorChave) Then
      Begin
        If fVeiculoInativo(mskPlaVei.Text) Then
        Begin
          mskPlaVei.Text := '';
          fMensagem('','Este veículo está inativo.',['&Ok']);
          Result := False;
        End
        Else
        Begin
          If Not fEmptyStr(mskPlaVei.Text) Then
          Begin
            edtDesVei.Text := fRetornaDescricaoVeic(mskPlaVei.Text);
            If fEmptyStr(edtDesVei.Text) Then
            Begin
              fMensagem('ATENÇÃO!', 'Esse veículo não está cadastrado!', ['&Ok']);
              Result := False;
            End
            Else
              pRequisicaoQualP;
          End
          Else
            pLimparCampos;
        End;
      End
    End;
  Except
    On E: ExceptionAutCom Do
    Begin
      pMensagemOk(E.Message);
      Result := False;
    End;

    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmConsultaQualP.fValidaCampos]');
      Result := False;
    End;
  End;

  If (Not Result) Then
  Begin
    pSetFocus(Sender);
  End
  Else
    blnMudarFoco := False;
end;

procedure TfrmConsultaQualP.mskPlaVeiChange(Sender: TObject);
begin
  inherited;
  pLimparCampos;
end;

procedure TfrmConsultaQualP.mskPlaVeiExit(Sender: TObject);
begin
  inherited;
  if fEmptyStr(edtDesVei.Text) then
    fValidaCampos(mskPlaVei, True);
end;

procedure TfrmConsultaQualP.mskPlaVeiKeyPress(Sender: TObject; var Key: Char);
var
  LArrVei : TConsultasArray;
  LFiltro : String;
begin
  inherited;
  LFiltro := ' VEI_STATUS = "A" AND VEI_PINQLP = "S" ';

  If fPesqVeiculos(Self, mskPlaVei, edtDesVei, Nil, Key, LArrVei, True, False, LFiltro) Then
    fValidaCampos(mskPlaVei, True)
end;

procedure TfrmConsultaQualP.pCalcular;
begin
  if FControleQualP.OcorreuErro then
  begin
    pLimparCampos;
    FControleQualP.pClear;
    Exit;
  end;

  FControleQualP.ValorBaseFrete := 0;

  if FIncluirValorFrete then
    FControleQualP.ValorBaseFrete := dtsQualP.DataSet.FieldByName('VALOR').AsFloat
  else
  if Assigned(FProcCalcular) then
  begin
    FProcCalcular;
    edtTotalFrete.Text       := FormatFloat(',0.00', FControleQualP.ValorTotalFrete);
    edtAcrescimoVeiculo.Text := FormatFloat(',0.00', FControleQualP.ValorAcrescimoVeiculo);
  end;
end;

procedure TfrmConsultaQualP.pCarregarInformacoesResposta;
begin
  edtDistancia.Text            := FControleQualP.Resposta.Distancia.Texto;
  edtTempoEstimadoDuracao.Text := FControleQualP.Resposta.Duracao.Texto;
  edtCustoCombustivel.Text     := FormatFloat(',0.00', FControleQualP.CustoCombustivel);
  edtLinkQualP.Text            := FControleQualP.Resposta.LinkSiteQualp;
  edtCustoPedagio.Text         := FormatFloat(',0.00', FControleQualP.CustoPedagio);
  edtQuantidadeEixos.Text      := FControleQualP.QuantidadeEixos.ToString;
end;

procedure TfrmConsultaQualP.pLimparCampos;
begin
  edtDesVei.Clear;

  edtQuantidadeEixos.Clear;
  edtDistancia.Clear;
  edtTempoEstimadoDuracao.Clear;
  edtCustoCombustivel.Clear;
  edtCustoPedagio.Clear;
  edtAcrescimoVeiculo.Clear;
  edtLinkQualP.Clear;
  edtTotalFrete.Clear;

  cmbTabelaFrete.ItemIndex := -1;

  if dtsQualP.DataSet.Active then
    TUniClientDataSet(dtsQualP.DataSet).EmptyDataSet;
end;

procedure TfrmConsultaQualP.pRequisicaoQualP;
begin
  if (dtsQualp.DataSet.Active) then
  begin
    if (dtsQualp.DataSet.RecordCount > 0) and
       (FIncluirValorFrete) then
      Exit;
  end;

  try
    if Assigned(FProcPrepararCalculo) then
    begin
      FControleQualP.PlacaVeiculo := mskPlaVei.Text;
      FProcPrepararCalculo;

      if Assigned(FControleQualP.Resposta) then
        pCarregarInformacoesResposta;

      if FIncluirValorFrete then
        btnOk.Enabled := (dtsQualP.DataSet.Active and (dtsQualP.DataSet.RecordCount > 0))
      else
        pCalcular;
    end;
  except
    on E: ExceptionAutCom do
      pMensagemOk(E.Message);

    on E: Exception do
      pMensagensErro(E.Message,'[TfrmConsultaQualP.btnRequisicaoQualPClick]');
  end;
end;

end.
