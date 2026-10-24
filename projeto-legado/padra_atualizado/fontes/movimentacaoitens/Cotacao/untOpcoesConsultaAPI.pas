unit untOpcoesConsultaAPI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.StdCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls;

type
  TfrmOpcoesConsultaAPI = class(TfrmPaiConfirma)
    RadioGroup1: TRadioGroup;
    CheckBox1: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmOpcoesConsultaAPI: TfrmOpcoesConsultaAPI;

implementation

{$R *.dfm}

end.
