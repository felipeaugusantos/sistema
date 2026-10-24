unit untMensagemRemoverPix;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, untTelasAbertas, untInterfacesIntegracaoPixCitel;

type
  TfrmMensagemRemoverPix = class(TForm)
    pblTitulo: TPanel;
    lblTitulo: TLabel;
    pnlBotoes: TPanel;
    pnlMensagem: TPanel;
    imgbotao1: TImage;
    imgbotao2: TImage;
    imgbotao3: TImage;
    lblMensagem: TLabel;
    btnSim: TBitBtnLocked;
    btnNao: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnSimClick(Sender: TObject);
    procedure btnNaoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
  private
    FOpcaoSelecionada: Integer;
    FTelas : ITelasAbertas;

    procedure pEmpilharTelaAberta;
    procedure pRemoverTelaAberta;
    { Private declarations }
  public
    property OpcaoSelecionada: Integer read FOpcaoSelecionada;
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmMensagemRemoverPix.btnNaoClick(Sender: TObject);
begin
  FOpcaoSelecionada := 2;
  Self.Close;
end;

procedure TfrmMensagemRemoverPix.btnSimClick(Sender: TObject);
begin
  FOpcaoSelecionada := 1;
  Self.Close;
end;

procedure TfrmMensagemRemoverPix.FormCreate(Sender: TObject);
begin
  FOpcaoSelecionada := 0;
  pEmpilharTelaAberta;
end;

procedure TfrmMensagemRemoverPix.FormDestroy(Sender: TObject);
begin
  pRemoverTelaAberta;
end;

procedure TfrmMensagemRemoverPix.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key = VK_ESCAPE Then
    btnNao.Click;
end;

procedure TfrmMensagemRemoverPix.pEmpilharTelaAberta;
begin
  FTelas := untTelasAbertas.objTelasAbertas;

  If Assigned(FTelas) Then
    FTelas.AddFormAndSetPopupMode(Self);
end;

procedure TfrmMensagemRemoverPix.pRemoverTelaAberta;
begin
  If Assigned(FTelas) Then
    FTelas.RemoveFormParent(Self);
end;

end.
