unit untMsgErroSQL;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, MemoFocus;

type
  TfrmMsgErroSQL = class(TfrmPaiEdit)
    Panel1: TPanel;
    mmoErrSQL: TMemoFocus;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMsgErroSQL: TfrmMsgErroSQL;

implementation

{$R *.dfm}

end.
