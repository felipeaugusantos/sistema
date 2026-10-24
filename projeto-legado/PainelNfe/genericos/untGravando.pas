unit untGravando;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, cxControls, cxContainer, cxEdit,
  cxProgressBar, StrUtils, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,

{$IF Defined(UNIDAC)}
  System.Types, Uni
{$ELSE}
  ZConnection
{$IFEND}
  ;

type
  TfrmGravando = class(TForm)
    imgGravando: TImage;
    lblGravando: TLabel;
    tmrClose: TTimer;
    pgbStatus: TcxProgressBar;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tmrCloseTimer(Sender: TObject);
  private
    { Private declarations }
    blnFecharForm: Boolean;
    intPrimeira: Integer;
  public
    strChave: String;
    blnCopiarJRE6,
    blnRemoveJRE6,
    blnConfirma: Boolean;
    strArqPnl, strArqLoc: AnsiString;
    fExecutarAcao: function(pgbSts: TcxProgressBar; strArqPnl, strArqLoc: AnsiString; blnCopiarJRE6: Boolean; blnRemoveJRE6: Boolean=False): Boolean;
    fExecutarAcaoMetodo: function(pgbSts: TcxProgressBar): Boolean of object;
  end;

var
  frmGravando: TfrmGravando;

implementation

{$IF Defined(VER250) Or Defined(VER270) Or Defined(VER280)} uses System.UITypes;
{$IFEND}
{$R *.dfm}

procedure TfrmGravando.FormCreate(Sender: TObject);
begin
  blnRemoveJRE6 := False;
  blnCopiarJRE6 := False;
  blnFecharForm := False;
  blnConfirma := False;
  intPrimeira := -1;
  pgbStatus.Position := 0;
end;

procedure TfrmGravando.FormActivate(Sender: TObject);
begin

  If InterlockedIncrement(intPrimeira) = 0 Then
  Begin
    Try
      If strChave = 'PAINELNFE' Then
        pgbStatus.Properties.Max := 4;

      If Assigned(fExecutarAcao) Then
        blnConfirma := fExecutarAcao(pgbStatus, strArqPnl, strArqLoc, blnCopiarJRE6, blnRemoveJRE6)
      Else If Assigned(fExecutarAcaoMetodo) Then
        blnConfirma := fExecutarAcaoMetodo(pgbStatus)
      Else
        blnConfirma := False;
    Finally
      blnFecharForm := True;
    End;
  End;

end;

procedure TfrmGravando.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  If Not blnFecharForm Then
    Action := caNone;

end;

procedure TfrmGravando.tmrCloseTimer(Sender: TObject);
begin
  If blnFecharForm Then
    Close;
end;

end.
