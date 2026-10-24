unit untOpcImpOrdPro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, AppEvnts, Menus, Buttons, ExtCtrls,
  BitBtnLockedIncrem, frxClass, untFuncoesSimples, frxExportCSVTestabilidade;

type
  TfrmOpcImpOrdPro = class(TfrmPai)
    gpbImprimir: TGroupBox;
    rdbDescricao: TRadioButton;
    rdbReferenc: TRadioButton;
    btnImprimir: TBitBtnLocked;
    procedure btnImprimirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmOpcImpOrdPro: TfrmOpcImpOrdPro;

implementation

{$R *.dfm}

procedure TfrmOpcImpOrdPro.btnImprimirClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfrmOpcImpOrdPro.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(rdbDescricao);
end;

end.
