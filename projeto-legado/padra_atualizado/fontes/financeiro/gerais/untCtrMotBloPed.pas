unit untCtrMotBloPed;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, AppEvnts, Menus, Buttons, ExtCtrls, MemoFocus,
  EditFocus, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCtrMotBloPed = class(TfrmPai)
    pnlGeral: TPanel;
    Label1: TLabel;
    edtPed: TEditFocus;
    Label6: TLabel;
    edtEspDoc: TEditFocus;
    Label4: TLabel;
    edtDtaCad: TEditFocus;
    Label5: TLabel;
    edtHorCad: TEditFocus;
    Label2: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    Label3: TLabel;
    edtCodVen: TEditFocus;
    edtDesVen: TEditFocus;
    Label7: TLabel;
    edtCodOpe: TEditFocus;
    edtDesOpe: TEditFocus;
    Label8: TLabel;
    memObserv: TMemoFocus;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCtrMotBloPed: TfrmCtrMotBloPed;

implementation

{$R *.dfm}

end.
