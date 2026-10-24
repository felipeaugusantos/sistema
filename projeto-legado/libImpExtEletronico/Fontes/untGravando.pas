unit untGravando;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, dxGDIPlusClasses;


type
  TfrmGravando = class(TForm)
    pgbStatus: TProgressBar;
    lblGravando: TLabel;
    imgGravando: TImage;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }

  end;

var
  frmGravando: TfrmGravando;

implementation


{$R *.dfm}

procedure TfrmGravando.FormActivate(Sender: TObject);
begin
  Application.ProcessMessages;
end;


end.
