unit untObsBanner;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, MemoFocus;

type
  TfrmObsBanner = class(TfrmPaiConfirma)
    mmoObserv: TMemoFocus;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmObsBanner: TfrmObsBanner;

implementation

{$R *.dfm}

end.
