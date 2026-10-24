unit ContasBancarias.View.Frame.ContaBancaria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxLabel, cxButtons, dxGDIPlusClasses, Vcl.Menus,
  ContasBancarias.Model.ContaBancaria, System.ImageList, Vcl.ImgList,
  cxImageList, cxImage, cxGroupBox, dxScreenTip, cxClasses, dxCustomHint, cxHint;

type
  TframeContaBancaria = class(TFrame)
    pnlMain: TPanel;
    imgLogoBanco: TImage;
    lblConta: TcxLabel;
    lblUltimaImportacao: TcxLabel;
    lblPortador: TcxLabel;
    btnImportar: TcxButton;
    cxImageList: TcxImageList;
    lblBanco: TcxLabel;
    pnlMensagemErro: TPanel;
    lblErro2: TcxLabel;
    lblErro1: TcxLabel;
    lblErro3: TcxLabel;
    HintControler: TcxHintStyleController;
    pnlSaldo: TPanel;
    lblValorSaldo: TcxLabel;
    imgCarregando: TcxImage;
    pnlImportar: TPanel;
    procedure btnImportarClick(Sender: TObject);
    procedure pnlMensagemErroMouseLeave(Sender: TObject);
    procedure lblErro1MouseEnter(Sender: TObject);
    procedure lblErro2MouseEnter(Sender: TObject);
    procedure lblErro3MouseEnter(Sender: TObject);
    procedure lblErro3MouseLeave(Sender: TObject);
    procedure lblErro2MouseLeave(Sender: TObject);
    procedure lblErro1MouseLeave(Sender: TObject);
  private
    FOnImportarClick: TNotifyEvent;
    FOnConsultarSaldoClick: TNotifyEvent;
  public
    procedure CarregarDados(AConta: TContaBancaria);
    procedure SetLogoBanco(ACodigoBanco: Integer);
    procedure ConfigurarBordasArredondadas;
    property OnImportarClick: TNotifyEvent read FOnImportarClick write FOnImportarClick;
    property OnConsultarSaldoClick: TNotifyEvent read FOnConsultarSaldoClick write FOnConsultarSaldoClick;
  end;

implementation

{$R *.dfm}

{ TFrameCardConta }

procedure TframeContaBancaria.SetLogoBanco(ACodigoBanco: Integer);
var
  LIconIndex: Integer;
begin
  LIconIndex := 0;

  case ACodigoBanco of
    1:    LIconIndex := 0; // Banco do Brasil
    33:   LIconIndex := 1; // Santander
    341:  LIconIndex := 2; // Itaú
  end;


 cxImageList.GetImage(LIconIndex, imgLogoBanco.Picture.Bitmap);

end;

procedure TframeContaBancaria.CarregarDados(AConta: TContaBancaria);
begin
  lblBanco.Caption := AConta.Banco;
  lblConta.Caption := Format('Ag: %s | C/C: %s %s', [AConta.Agencia, AConta.NumeroConta, AConta.TipoConta]);

  lblUltimaImportacao.Caption := 'Última Importação: Nunca Importado.';

  If (AConta.UltimaImportacao > 0) Then
    lblUltimaImportacao.Caption := 'Última Importação: ' + FormatDateTime('dd/mm/yyyy', AConta.UltimaImportacao);

  lblPortador.Caption := 'Portador: Não Vinculado';
  if Not AConta.Portador.IsEmpty then
    lblPortador.Caption := Format('Portador: %s', [AConta.Portador]);

  SetLogoBanco(AConta.CodigoBanco);
end;

procedure TframeContaBancaria.ConfigurarBordasArredondadas;
var
  Rgn: HRGN;
  RgnImp: HRGN;
begin
  Rgn := CreateRoundRectRgn(0, 0, pnlMain.Width , pnlMain.Height , 15, 15);
  SetWindowRgn(pnlMain.Handle, Rgn, True);

  RgnImp := CreateRoundRectRgn(0, 0, pnlImportar.Width , pnlImportar.Height , 15, 15);
  SetWindowRgn(pnlImportar.Handle, RgnImp, True);
end;

procedure TframeContaBancaria.lblErro1MouseEnter(Sender: TObject);
begin
  HintControler.ShowHint(lblErro1.ClientOrigin.X,lblErro1.ClientOrigin.Y, 'Atenção', pnlMensagemErro.Hint);
end;

procedure TframeContaBancaria.lblErro1MouseLeave(Sender: TObject);
begin
  HintControler.HideHint;
end;

procedure TframeContaBancaria.lblErro2MouseEnter(Sender: TObject);
begin
  HintControler.ShowHint(lblErro2.ClientOrigin.X,lblErro2.ClientOrigin.Y, 'Atenção', pnlMensagemErro.Hint);
end;

procedure TframeContaBancaria.lblErro2MouseLeave(Sender: TObject);
begin
  HintControler.HideHint;
end;

procedure TframeContaBancaria.lblErro3MouseEnter(Sender: TObject);
begin
  HintControler.ShowHint(lblErro3.ClientOrigin.X,lblErro3.ClientOrigin.Y, 'Atenção', pnlMensagemErro.Hint);
end;

procedure TframeContaBancaria.lblErro3MouseLeave(Sender: TObject);
begin
  HintControler.HideHint;
end;

procedure TframeContaBancaria.pnlMensagemErroMouseLeave(Sender: TObject);
begin
  HintControler.HideHint;
end;

procedure TframeContaBancaria.btnImportarClick(Sender: TObject);
begin
  if Assigned(FOnImportarClick) then
    FOnImportarClick(Self);
end;

end.
