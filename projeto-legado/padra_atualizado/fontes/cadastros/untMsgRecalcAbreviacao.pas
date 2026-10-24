unit untMsgRecalcAbreviacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls;

type
  TfrmMsgRecalcAbreviacao = class(TfrmPaiEdit)
    mmo1: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMsgRecalcAbreviacao: TfrmMsgRecalcAbreviacao;

implementation

{$R *.dfm}

end.
