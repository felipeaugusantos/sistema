unit untMsgPagtoAntecipado;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, MemoFocus;

type
  TfrmMsgPagtoAntecipado = class(TfrmPaiEdit)
    MemoFocus1: TMemoFocus;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMsgPagtoAntecipado: TfrmMsgPagtoAntecipado;

implementation

{$R *.dfm}

end.
