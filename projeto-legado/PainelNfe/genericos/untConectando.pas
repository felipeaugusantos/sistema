unit untConectando;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, cxControls, cxContainer, cxEdit,
  cxProgressBar, StrUtils, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  BitBtnLockedIncrem

{$IF Defined(UNIDAC)}
  ,System.Types, Uni
{$ELSE}
  ,ZConnection, Buttons
{$IFEND}
  ;

type
  TfrmConectando = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    lblTentativas: TLabel;
    btnAbortar: TBitBtnLocked;
    tmrReconectar: TTimer;
    memErro: TMemo;
    procedure tmrReconectarTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnAbortarClick(Sender: TObject);
  private
    { Private declarations }
    class var frmConectando: TfrmConectando;
    blnReconectado: Boolean;
    intProximaTentativaEm: Integer;
    function fReconectarModulo: Boolean;
  public
    class function fTentandoReconectarModulo: Boolean;
    class procedure pReconectarModulo(strErro: String);
  end;

implementation

uses untModulo, untUtil;

{$R *.dfm}

procedure TfrmConectando.btnAbortarClick(Sender: TObject);
begin
  If Not KillProcess(GetCurrentProcessId) Then
    Application.Terminate;
end;

procedure TfrmConectando.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  If Not blnReconectado Then
    Action := caNone;
end;

procedure TfrmConectando.FormCreate(Sender: TObject);
begin
  blnReconectado := False;
  intProximaTentativaEm := 15;
end;

function TfrmConectando.fReconectarModulo: Boolean;
begin
  Try
    frmModulo.Database.Disconnect;
    frmModulo.Database.Connected := True;
    pDefinirCharsetConexao;
    Result := True;
    if Assigned(VS_LimpaTodasTravas) then
      VS_LimpaTodasTravas ;
  Except
    On E: Exception Do
    Begin
      Result := False;
      memErro.Text := E.Message;
    End;
  End;
end;

class function TfrmConectando.fTentandoReconectarModulo: Boolean;
begin
  Result := Assigned(frmConectando);
end;

class procedure TfrmConectando.pReconectarModulo(strErro: String);
begin
  If fTentandoReconectarModulo Then
    Exit;

  Try
    Application.CreateForm(TfrmConectando, frmConectando);
    frmConectando.memErro.Text := strErro;
    frmConectando.ShowModal;
  Finally
    FreeAndNil(frmConectando);
  End;
end;

procedure TfrmConectando.tmrReconectarTimer(Sender: TObject);
begin
  Try
    tmrReconectar.Enabled := False;
    intProximaTentativaEm := intProximaTentativaEm - 1;

    If intProximaTentativaEm <= 0 Then
    Begin
      intProximaTentativaEm := 15;
      lblTentativas.Caption := 'Tentando reconectar-se ao servidor ...' + #13;
      Application.ProcessMessages;
      blnReconectado := fReconectarModulo;
    End
    Else
    Begin
      lblTentativas.Caption := 'Uma nova tentativa será executada em ' +
        IntToStr(intProximaTentativaEm) + ' segundos.' + #13;
      Application.ProcessMessages;
    End;
  Finally
    tmrReconectar.Enabled := Not blnReconectado;

    If blnReconectado Then
      Close;
  End;
end;

end.
