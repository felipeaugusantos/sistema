unit untSplashExt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, Vcl.StdCtrls;

type
  TfrmSplashExt = class(TForm)
    lblTopo: TLabel;
    tmrTempo: TTimer;
    pgbStatus: TProgressBar;
    Image1: TImage;
    procedure tmrTempoTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    strProg  : String;
    strFlag  : String;
  end;


implementation

uses  untFuncoes, untfuncoesSimples;

{$R *.dfm}

procedure TfrmSplashExt.tmrTempoTimer(Sender: TObject);
  Var
    strPath : String;
begin

  If strProg = 'autban' Then
  Begin
    strPath   := fGetPath(ExtractFilePath(Application.ExeName) + '\autban\');

    If FileExists(strPath + '\autban.exe') Then
    Begin
      If fCriarProcesso(strPath + '\autban.exe 0 ' + strLoginUsuarioLogado + ' 0 ' + VS_strCodEmp, False) Then
      Begin
        tmrTempo.Enabled := False;

        While (FindWindow(Nil, PChar('AutBan')) <= 0) Do
        Begin
          Application.ProcessMessages;
          Sleep(100);
        End;
      End;

      Close;
    End
    Else
    Begin
      fMensagem('','AutBan não encontrado!!!', ['&Ok']);
      Close;
    End;
  End
  Else If strProg = 'auttin' Then
  Begin

    If FileExists(ExtractFilePath(Application.ExeName) + '\auttin\AutTin.exe') Then
    Begin
      If strFlag = '1' Then
      Begin

        If fCriarProcesso(ExtractFilePath(Application.ExeName) + '\auttin\AutTin.exe ' + strFlag + ' ' + strLoginUsuarioLogado + ' 0 ' + VS_strCodEmp, False) Then
        Begin
          tmrTempo.Enabled := False;

          While (FindWindow(Nil, PChar('AutTin')) <= 0) Do
          Begin
            Application.ProcessMessages;
            Sleep(100);
          End;
        End;

      End
      Else
      Begin

        If fCriarProcesso(ExtractFilePath(Application.ExeName) + '\auttin\AutTin.exe ' + strFlag + ' 999' + ' 0 ' + VS_strCodEmp, False) Then
        Begin
          tmrTempo.Enabled := False;

          While (FindWindow(Nil, PChar('AutTin')) <= 0) Do
          Begin
            Application.ProcessMessages;
            Sleep(100);
          End;
        End;

      End;

      Close;

    End
    Else
    Begin
      Close;
    End;

  End;

end;

procedure TfrmSplashExt.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

End.

