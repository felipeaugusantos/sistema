unit untPgtOnlineEscolheTipoEnvioLink;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxGroupBox, cxCheckGroup,
  untPgtOnlineUtil;

type
  TfrmPgtOnlineEscolheTipoEnvioLink = class(TfrmPaiConfirma)
    rgOpcoes: TRadioGroup;
    cbOpcoesEnvio: TComboBox;
    lbOpcoesEnvio: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure rgOpcoesClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FblnConfirma: Boolean ;
    ForOpcaoSelecionada: TOpcaoRetorno ;
    FstrCodCli: String ;
    FstrMeioEnvioSelecionado: String ;
    procedure pCarregaEmailCliente(const AstrCodCli: String) ;
    procedure pCarregaCelularCliente(const AstrCodCli: String) ;
  public
    { Public declarations }
    property BlnConfirma: Boolean read FblnConfirma ;
    property OpcaoSelecionada: TOpcaoRetorno read ForOpcaoSelecionada ;
    property CodCli: String read FstrCodCli write FstrCodCli ;
    property MeioEnvioSelecionado: String read FstrMeioEnvioSelecionado write FstrMeioEnvioSelecionado ;
  end;

implementation

uses untFuncoesSimples ;

{$R *.dfm}

procedure TfrmPgtOnlineEscolheTipoEnvioLink.btnConfirmaClick(Sender: TObject);
begin
  if rgOpcoes.ItemIndex < 0 then
  begin
    pSetFocus(rgOpcoes);
    fMensagem('ATENÇÃO!', 'Nenhuma opção selecionada!', ['&Ok']);
    exit ;
  end ;

  if fEmptyStr(cbOpcoesEnvio.Text) then
  begin
    pSetFocus(cbOpcoesEnvio);
    fMensagem('ATENÇÃO!', '"Enviar para" não informada!', ['&Ok']);
    exit ;
  end ;

  ForOpcaoSelecionada := TOpcaoRetorno(rgOpcoes.ItemIndex) ;
  FstrMeioEnvioSelecionado := cbOpcoesEnvio.Text ;

  FblnConfirma := True ;

  inherited;
end;

procedure TfrmPgtOnlineEscolheTipoEnvioLink.FormCreate(Sender: TObject);
begin
  inherited;
  FblnConfirma := False ;
  FstrMeioEnvioSelecionado := '' ;
end;

procedure TfrmPgtOnlineEscolheTipoEnvioLink.FormShow(Sender: TObject);
begin
  inherited;
  rgOpcoesClick(rgOpcoes) ;
end;

procedure TfrmPgtOnlineEscolheTipoEnvioLink.pCarregaCelularCliente(
  const AstrCodCli: String);
var
  LstrCelular: String ;
begin
  cbOpcoesEnvio.Items.Clear ;

  LstrCelular := fListaCelularCliente(AstrCodCli) ;

  if not fEmptyStr(LstrCelular) then
  begin
    cbOpcoesEnvio.Items.Add(LstrCelular) ;
    cbOpcoesEnvio.ItemIndex := 0 ;
  end ;

  cbOpcoesEnvio.Visible := True ;
  lbOpcoesEnvio.Visible := True ;

end;

procedure TfrmPgtOnlineEscolheTipoEnvioLink.pCarregaEmailCliente(
  const AstrCodCli: String);
var
  LarrDados: TArrayDados ;
  LintCnt: Integer ;
begin
  LarrDados := fListaEmailsCliente(AstrCodCli) ;
  cbOpcoesEnvio.Items.Clear ;
  for LintCnt := Low(LarrDados) to High(LarrDados) do
    cbOpcoesEnvio.Items.Add(LarrDados[LintCnt]) ;

  if Length(LarrDados) > 0 then
    cbOpcoesEnvio.ItemIndex := 0 ;

  cbOpcoesEnvio.Visible := True ;
  lbOpcoesEnvio.Visible := True ;

end;

procedure TfrmPgtOnlineEscolheTipoEnvioLink.rgOpcoesClick(Sender: TObject);
begin
  inherited;
  if TRadioGroup(Sender).ItemIndex = 0 then
    pCarregaEmailCliente(FstrCodCli)
  else if TRadioGroup(Sender).ItemIndex = 1 then
    pCarregaCelularCliente(FstrCodCli) ;
end;

end.
