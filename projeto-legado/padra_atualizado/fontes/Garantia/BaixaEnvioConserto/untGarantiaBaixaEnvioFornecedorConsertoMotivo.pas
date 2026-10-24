unit untGarantiaBaixaEnvioFornecedorConsertoMotivo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untMensagem, System.ImageList, Vcl.ImgList, cxImageList, cxGraphics, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls;

type
  TfrmGarantiaBaixaEnvioConsertoMotivo = class(TfrmMensagem)
    rbAbatimentoBoleto: TRadioButton;
    rbCreditoConta: TRadioButton;
    rbNotaBonificacao: TRadioButton;
    rbProdutoSaiuLinha: TRadioButton;
    rbOutros: TRadioButton;
    edtOutros: TEdit;
    btnConfirmar: TBitBtnLocked;
    btnSair: TBitBtnLocked;
    procedure btnConfirmarClick(Sender: TObject);
    procedure pClickRadioButton(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure pnlBotoesEnter(Sender: TObject);
    procedure edtOutrosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private

    function fObterMotivo: String;
    procedure pConfigurar;
    function fValidarOutrosMotivos: Boolean;
    { Private declarations }
  public
    strMotivo: String;
    { Public declarations }
  end;

var
  frmGarantiaBaixaEnvioConsertoMotivo: TfrmGarantiaBaixaEnvioConsertoMotivo;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmGarantiaBaixaEnvioConsertoMotivo.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  strMotivo :=  fObterMotivo;
  if fEmptyStr(strMotivo) then
  begin
    fMensagem('Atenção','Por favor, informe a justificativa da baixa ou cancele a operação.',['&Ok']);
  end
  else begin
    ModalResult := MrOk;
  end;
end;

procedure TfrmGarantiaBaixaEnvioConsertoMotivo.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmGarantiaBaixaEnvioConsertoMotivo.edtOutrosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
  begin
    if fValidarOutrosMotivos then
      pSetFocus(btnConfirmar);
  end;
end;

function TfrmGarantiaBaixaEnvioConsertoMotivo.fObterMotivo: String;
Var
  intIdx: integer;
begin
  Result := EmptyStr;
  for intIdx := 0 to pnlMensagem.ControlCount -1 do
  begin
    if pnlMensagem.Controls[intIdx] is TRadioButton then
    begin
      if TRadioButton(pnlMensagem.Controls[intIdx]).Checked then
      begin
        if TRadioButton(pnlMensagem.Controls[intIdx]) = rbOutros then
        begin
          Result := edtOutros.Text;
        end
        else
        begin
          Result := TRadioButton(pnlMensagem.Controls[intIdx]).Caption;
        end;
      end;
    end;
  end;
end;

procedure TfrmGarantiaBaixaEnvioConsertoMotivo.FormCreate(Sender: TObject);
begin
  inherited;
  pConfigurar;
end;

procedure TfrmGarantiaBaixaEnvioConsertoMotivo.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key of
    VK_ESCAPE: btnSair.Click;
    VK_F10: btnConfirmar.Click;
  end;

end;

procedure TfrmGarantiaBaixaEnvioConsertoMotivo.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(rbAbatimentoBoleto);
end;

function TfrmGarantiaBaixaEnvioConsertoMotivo.fValidarOutrosMotivos: Boolean;
begin

  Result := Not fEmptyStr(edtOutros.Text);

  if Not Result then
  begin
    fMensagem('Atenção!','É obrigatório informar um motivo quando selecionado opção "Outros".',['&Ok']);
  end;

end;

procedure TfrmGarantiaBaixaEnvioConsertoMotivo.pClickRadioButton(Sender: TObject);
begin
  if Sender = rbOutros then
  begin
    edtOutros.enabled := true;
    pSetFocus(edtOutros);
  end
  else begin
    edtOutros.clear;
    edtOutros.enabled := false;
  end;
end;

procedure TfrmGarantiaBaixaEnvioConsertoMotivo.pConfigurar;
begin
  rbAbatimentoBoleto.OnClick  := pClickRadioButton;
  rbCreditoConta.OnClick      := pClickRadioButton;
  rbNotaBonificacao.OnClick   := pClickRadioButton;
  rbProdutoSaiuLinha.OnClick  := pClickRadioButton;
  rbOutros.OnClick            := pClickRadioButton;
end;

procedure TfrmGarantiaBaixaEnvioConsertoMotivo.pnlBotoesEnter(Sender: TObject);
begin
  inherited;
  pSetFocus(btnConfirmar);
end;

end.
