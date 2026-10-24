unit untCadFarGerNfm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiGeraArq, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  Gauges, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadFarGerNfm = class(TfrmPaiGeraArq)
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadFarGerNfm: TfrmCadFarGerNfm;

implementation

uses untFarbenAutomotiva;

{$R *.dfm}

procedure TfrmCadFarGerNfm.btnConfirmaGeracaoClick(Sender: TObject);
begin
  tintaClasse := TFarbenAutomotivaNfm;
  inherited;
end;

end.
