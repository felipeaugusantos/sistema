unit untFatDigServicoDigObs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem, ExtCtrls, EditFocus;

type
  TfrmFatDigServicoDigObs = class(TfrmPai)
    pnlFundo: TPanel;
    btnConfirma: TBitBtnLocked;
    Label1: TLabel;
    edtObs: TEditFocus;
  private
    { Private declarations }
  public
    class function fGetObservacao(strDefault: String): String;
  end;

var
  frmFatDigServicoDigObs: TfrmFatDigServicoDigObs;

implementation

uses untFuncoesSimples;

{$R *.dfm}

{ TfrmFatDigServicoDigObs }

class function TfrmFatDigServicoDigObs.fGetObservacao(strDefault: String): String;
begin
  pCriarFormularios(TfrmFatDigServicoDigObs, frmFatDigServicoDigObs);
  Try
    frmFatDigServicoDigObs.edtObs.Text := strDefault;
    If frmFatDigServicoDigObs.ShowModal = mrOk Then
      Result := frmFatDigServicoDigObs.edtObs.Text
    Else
      Result := strDefault;
  Finally
    pFreeAndNil(frmFatDigServicoDigObs);
  End;
end;

end.
