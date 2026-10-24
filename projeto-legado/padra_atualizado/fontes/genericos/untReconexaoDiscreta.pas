unit untReconexaoDiscreta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, cxControls, cxContainer, cxEdit,
  cxProgressBar, StrUtils, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  BitBtnLockedIncrem, cxImage, dxGDIPlusClasses, Vcl.Buttons, System.Types, Uni;

type
  TfrmReconexaoDiscreta = class(TForm)
    Panel1: TPanel;
    tmrReconectar: TTimer;
    Panel2: TPanel;
    shaFundo: TShape;
    imgGravando: TcxImage;
    lblMensagem: TLabel;
    pgbProgresso: TcxProgressBar;
    btnAbortar: TSpeedButton;
    lblAbortar: TLabel;
    procedure tmrReconectarTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnAbortarClick(Sender: TObject);
  private
    { Private declarations }
  class var
    frmReconectando: TfrmReconexaoDiscreta;
    blnReconectado: Boolean;
    FErrorMessage: string;
    FErrorStackTrace: string;
    function fReconectarModulo: Boolean;
  public
    class function fTentandoReconectarModulo: Boolean;
    class procedure pReconectarModuloDiscreta(AError, AStack: String);
  end;

implementation

uses untModulo, untFuncoesSimples, untLogAut, untThreadUtils;

{$R *.dfm}

procedure TfrmReconexaoDiscreta.btnAbortarClick(Sender: TObject);
begin
  TThreadFinalizarAutcomMonitor.Monitorar;
  If Not TerminateProcess(GetCurrentProcess, 0) Then
    Application.Terminate;
end;

procedure TfrmReconexaoDiscreta.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  If Not blnReconectado Then
    Action := caNone;
end;

procedure TfrmReconexaoDiscreta.FormCreate(Sender: TObject);
begin
  btnAbortar.Visible := False;
  lblAbortar.Visible := False;
  pgbProgresso.Position := 0;
  pgbProgresso.Properties.Max := 10;
  blnReconectado := False;
end;

function TfrmReconexaoDiscreta.fReconectarModulo: Boolean;
begin
  Result := True;
  Try
    Try
      { Executamos uma função simples para testar a conexão }
      fGetConnectionID;
      TLogAut.New().pLogout;
      TLogAut.New().pLogin;
    Except
      frmModulo.GetCurrentConnection.Close;
      frmModulo.GetCurrentConnection.Connected := True;
      pDefinirCharsetConexao;
    End;

    If Assigned(pReassignConexaoLibFuncoes) Then
      pReassignConexaoLibFuncoes(frmModulo.GetCurrentConnection);
  Except
    On E: Exception Do
    Begin
      Result := False;
    End;
  End;
end;

class function TfrmReconexaoDiscreta.fTentandoReconectarModulo: Boolean;
begin
  Result := Assigned(frmReconectando);
end;

class procedure TfrmReconexaoDiscreta.pReconectarModuloDiscreta(AError, AStack: String);
begin
  If fTentandoReconectarModulo Then
    Exit;
  Try
    Application.CreateForm(TfrmReconexaoDiscreta, frmReconectando);
    frmReconectando.FErrorMessage := AError;
    frmReconectando.FErrorStackTrace := AStack;
    if VS_AutoatendimentoPagueFacil then
      frmReconectando.FormStyle := fsStayOnTop;
    frmReconectando.ShowModal;
  Finally
    FreeAndNil(frmReconectando);
  End;
end;

procedure TfrmReconexaoDiscreta.tmrReconectarTimer(Sender: TObject);
begin
  tmrReconectar.Enabled := False;
  Try
    pgbProgresso.Position := pgbProgresso.Position + 1;
    Application.ProcessMessages;
    blnReconectado := fReconectarModulo;
    if pgbProgresso.Position = pgbProgresso.Properties.Max then
    begin
      lblAbortar.Visible := True;
      btnAbortar.Visible := True;
      pgbProgresso.Position := 0;
    end;
  Finally
    tmrReconectar.Enabled := Not blnReconectado;
    If blnReconectado Then
    Begin
      pgbProgresso.Position := pgbProgresso.Properties.Max;
      Application.ProcessMessages;
      Sleep(500);
      pGravarErro(True, FErrorMessage, FErrorStackTrace);
      Close;
    End;
  End;
end;

initialization

 untModulo.ProcReconectarModuloDiscreta := TfrmReconexaoDiscreta.pReconectarModuloDiscreta;

end.
