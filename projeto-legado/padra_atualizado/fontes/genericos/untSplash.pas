unit untSplash;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Uni, DB,
  Login.View.Interfaces, untTLogin, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxProgressBar, dxGDIPlusClasses;

type
  TfrmSplash = class(TForm, ISplashView)
    tmrSplash: TTimer;
    pnlSplash: TPanel;
    imgSplash: TImage;
    lblProgresso: TLabel;
    pgbProgresso: TcxProgressBar;
    procedure tmrSplashTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure pIniciaForms;
  protected
    procedure NotificarProgresso(ANotificacao: ISplashNotificacaoProgresso);
  public
    { Public declarations }
    objSplash: ISplash;
  end;

implementation

{$R *.dfm}

procedure TfrmSplash.pIniciaForms;
begin
  objSplash.ExecutarSplash;
end;

procedure TfrmSplash.tmrSplashTimer(Sender: TObject);
begin
  Try
    tmrSplash.Enabled := False;
    pIniciaForms;
  Finally
    Close;
  End;
end;

procedure TfrmSplash.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  objSplash.RemoveView(Self);
end;

procedure TfrmSplash.FormShow(Sender: TObject);
begin
  objSplash.AddView(Self);
  tmrSplash.Enabled := True;
  Brush.Style := bsClear;
  Position := poScreenCenter;
end;

procedure TfrmSplash.NotificarProgresso(
  ANotificacao: ISplashNotificacaoProgresso);
begin
  lblProgresso.Caption        := ANotificacao.Mensagem;
  pgbProgresso.Properties.Max := ANotificacao.Max;
  pgbProgresso.Position       := ANotificacao.Progresso;
  Application.ProcessMessages;
end;

end.
