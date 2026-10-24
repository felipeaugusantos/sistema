unit untBaixaOrdProdIndustrialTipoBaixa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, untConsultas, untTypesSistema, untOrdProIndustrial,
  untCadLote;

type
  TfrmBaixaOrdProdIndustrialTipoBaixa = class(TfrmPaiConfirma)
    pnlGeral: TPanel;
    gpbTipo: TGroupBox;
    rdbAcabado: TRadioButton;
    rdbResiduo: TRadioButton;
    rdbAcabadoResiduo: TRadioButton;
    pnlResiduo: TPanel;
    pnlLote: TPanel;
    pnlProduto: TPanel;
    Label1: TLabel;
    edtDesProdutoResiduo: TEditFocus;
    edtProdutoResiduo: TEditFocus;
    Label12: TLabel;
    edtLote: TEditFocus;
    pnlQuantidade: TPanel;
    Label2: TLabel;
    edtQtdResiduo: TEditFocus;
    procedure edtProdutoResiduoKeyPress(Sender: TObject; var Key: Char);
    procedure rdbAcabadoClick(Sender: TObject);
    procedure rdbResiduoClick(Sender: TObject);
    procedure rdbAcabadoResiduoClick(Sender: TObject);
    procedure pConfiguraTela(PenuTipoBaixa : TTipoBaixa);

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtLoteKeyPress(Sender: TObject; var Key: Char);
  private
    objCadLot    : TCadLot;
    { Private declarations }
  public
    enuTipoBaixa : TTipoBaixa;
    fltPesoProducao : real;
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmBaixaOrdProdIndustrialTipoBaixa.btnConfirmaClick(Sender: TObject);
begin
  if fVerificaCampos then
    ModalResult := mrOk;
end;

procedure TfrmBaixaOrdProdIndustrialTipoBaixa.edtLoteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  If fPesqLoteItens(Self, edtLote, edtProdutoResiduo, fCfgSis('DECUNI', varInteger), nil, Key, arrSel, true, '', '', true, False, nil, False, False) Then
  Begin
    If fValidaCampos(edtLote, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBaixaOrdProdIndustrialTipoBaixa.edtProdutoResiduoKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  if fPesqItem(conIteSimples, Self, edtProdutoResiduo, edtDesProdutoResiduo, nil, Key, arrSel, True,
               nil, 'Consulta de Itens', '1', '',0,False,False,0,cdrCodIte,'',False,'','',True,False, False,'',True) then
  Begin
    If fValidaCampos(edtProdutoResiduo, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBaixaOrdProdIndustrialTipoBaixa.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(edtProdutoResiduo);

  blnPassarRadioButtonComEnter := False;
  objCadLot := TCadLot.Create(Self);
end;

procedure TfrmBaixaOrdProdIndustrialTipoBaixa.FormShow(Sender: TObject);
begin
  inherited;
  rdbAcabadoClick(rdbAcabado);
  pnlLote.Visible := fUsaRotinaWMS();
end;

function TfrmBaixaOrdProdIndustrialTipoBaixa.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  if pnlResiduo.Visible then
  begin
    If (Sender = edtProdutoResiduo) Then
    Begin
      If fEmptyStr(edtProdutoResiduo.Text) Then
      Begin
        Result := fMensagem('', 'Informe o Produto Residuo para efetuar a baixa!', ['&OK']) = -1;
      End
      Else
      Begin
        edtDesProdutoResiduo.Text := fRetNomProduto(edtProdutoResiduo.Text);
        If fEmptyStr(edtDesProdutoResiduo.Text) Then
        Begin
          Result := fMensagem('', 'Produto não encontrado!', ['&OK']) = -1;
        End
        Else
        Begin
          If not fEhMateriaPrima(edtProdutoResiduo.Text) Then
            Result := fMensagem('', 'O produto residuo deve ser uma matéria prima!', ['&OK']) = -1;
        End;

      End;

    End
    Else
    If (Sender = edtQtdResiduo) Then
    Begin
      if (fStrToFloat(edtQtdResiduo.Text) <= 0) Then
      Begin
        Result := fMensagem('', 'A quantidade do produto residuo deve ser maior que zero!', ['&Ok']) = -1;
      End;
    End
    Else
    If (Sender = edtLote) and pnlLote.Visible Then
    Begin
      If fEmptyStr(edtLote.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o número do lote!', ['&Ok']);
        Result := False;
      End

      Else If Not objCadLot.fExisteLote(edtProdutoResiduo.Text, VS_strCodEmp, edtLote.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Lote não encontrado!', ['&Ok']);
        Result := False;
      End

      Else If objCadLot.fEhPrincipalGarantia(edtProdutoResiduo.Text, edtLote.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não é permitido selecionar um lote principal para garantia!', ['&Ok']);
        Result := False;
      End

      Else If  SameText(edtLote.Text, 'A DEFINIR') Then
      Begin
        fMensagem('ATENÇÃO!', 'Não é permitido utilizar o lote "A DEFINIR"!', ['&Ok']);
        Result := False;
      End
    End;

  end;

  if Result = False then
    pSetFocus(Sender);
end;

procedure TfrmBaixaOrdProdIndustrialTipoBaixa.rdbAcabadoClick(Sender: TObject);
begin
  inherited;
  pConfiguraTela(tpbAcabado);

end;

procedure TfrmBaixaOrdProdIndustrialTipoBaixa.rdbAcabadoResiduoClick(
  Sender: TObject);
begin
  inherited;
  pConfiguraTela(tpbAcabadoResiduo);
end;

procedure TfrmBaixaOrdProdIndustrialTipoBaixa.rdbResiduoClick(Sender: TObject);
begin
  inherited;
  pConfiguraTela(tpbResiduo);
end;

procedure TfrmBaixaOrdProdIndustrialTipoBaixa.pConfiguraTela(PenuTipoBaixa : TTipoBaixa);
begin
  enuTipoBaixa := PenuTipoBaixa;
  case PenuTipoBaixa of

    tpbAcabado :
      if pnlResiduo.visible then
      begin
        pnlResiduo.Visible := False;
        Self.Height := Self.Height - pnlResiduo.Height;
        Self.ClientWidth  := (gpbTipo.Left * 2) + gpbTipo.Width;
      end;

    tpbAcabadoResiduo,
    tpbResiduo :
    begin

      if not pnlResiduo.visible then
      begin
        pnlResiduo.Visible := True;
        Self.Height        := Self.Height + pnlResiduo.Height;
        Self.ClientWidth   := gpbTipo.Left + edtDesProdutoResiduo.Left + edtDesProdutoResiduo.Width;
      end;

      if not (PenuTipoBaixa = tpbAcabadoResiduo) then
        edtQtdResiduo.text := FormatFloat('#,##0.00',fltPesoProducao)
      else
        edtQtdResiduo.Text := FormatFloat('#,##0.00',0);

    end;

  end;
end;

end.
