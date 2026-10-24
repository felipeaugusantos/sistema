unit untAguardando;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmAguardando = class(TForm)
    lblTexto: TLabel;
    tmrFechar: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tmrFecharTimer(Sender: TObject);
  private
    { Private declarations }
    blnFechar: Boolean;
  public
    { Public declarations }
    procedure pFechar;
  end;

var
  frmAguardando: TfrmAguardando;

implementation

{$R *.dfm}

{ TfrmAguardando }

procedure TfrmAguardando.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  If (blnFechar) Then
    Action := caFree;
end;

procedure TfrmAguardando.FormCreate(Sender: TObject);
begin
  blnFechar := False;
end;

procedure TfrmAguardando.pFechar;
begin
  blnFechar := True;
  Application.ProcessMessages;
end;

procedure TfrmAguardando.tmrFecharTimer(Sender: TObject);
begin
  If (blnFechar) Then
  Begin
    tmrFechar.Enabled := False;
    blnFechar := False;

    Self.Close;
  End;
end;

end.
