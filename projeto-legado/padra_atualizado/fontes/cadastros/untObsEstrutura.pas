unit untObsEstrutura;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Menus, Buttons, ExtCtrls, AppEvnts,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmObsEstrutura = class(TfrmPai)
    pnlObserv: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtObs01: TEditFocus;
    edtObs02: TEditFocus;
    edtObs03: TEditFocus;
    edtObs04: TEditFocus;
    btnConfirmar: TBitBtnLocked;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edtObs05: TEditFocus;
    edtObs06: TEditFocus;
    edtObs07: TEditFocus;
    procedure btnConfirmarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    blnConfirma: Boolean;
  end;

var
  frmObsEstrutura: TfrmObsEstrutura;

implementation

{$R *.dfm}

procedure TfrmObsEstrutura.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  blnConfirma := True;
  Close;

end;

end.
