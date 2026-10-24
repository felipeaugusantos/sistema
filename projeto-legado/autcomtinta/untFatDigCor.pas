unit untFatDigCor;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons,
  ExtCtrls, EditFocus, AppEvnts, BitBtnLockedIncrem;

type
  TfrmFatDigCor = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    edtDesCor: TEditFocus;
    pnlFundo: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    procedure btnCancelaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    strDesCor: String;
    blnConfirma: Boolean;
  end;

var
  frmFatDigCor: TfrmFatDigCor;

implementation

{$R *.dfm}

procedure TfrmFatDigCor.btnCancelaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatDigCor.FormShow(Sender: TObject);
begin
  inherited;
  edtDesCor.Text := strDesCor;
  blnConfirma    := False;
end;

procedure TfrmFatDigCor.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  strDesCor   := edtDesCor.Text;
  blnConfirma := True;
  Close;
end;

end.
