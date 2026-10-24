unit untDesCam;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, MemoFocus, EditFocus, Buttons, ExtCtrls, BitBtnLockedIncrem;

type
  TfrmDesCam = class(TForm)
    pnlCabeca: TPanel;
    pnlCentral: TPanel;
    pnlRodape: TPanel;
    edtNomPar: TEditFocus;
    edtExeCor: TEditFocus;
    edtVlrInf: TEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtTamCor: TEditFocus;
    BitBtn1: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }

  public
    { Public declarations }
    strTamCam : String;
    strNomPar : String;

  end;

var
  frmDesCam: TfrmDesCam;

implementation

uses untFuncoesBoleto;

{$R *.dfm}

procedure TfrmDesCam.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if(Key = VK_Escape) then
    close;
end;

procedure TfrmDesCam.FormShow(Sender: TObject);
begin

  edtNomPar.Text := strNomPar;
  edtTamCor.Text := strTamCam;
  edtExeCor.Text := fReplicatorStr('9', StrToInt(strTamCam) );

end;

end.
