unit untDecideDesconto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, BitBtnLockedIncrem;

Type
  TOpcaoDescontoItemCompra = (odFornecedorEAdicionais, odDigitadoAdicionais, odSomenteAdicionais, odSomaAdcionaisDescForne01);

type
  TfrmDecideDesconto = class(TForm)
    pnl1: TPanel;
    mmo1: TMemo;
    btnRecalc: TBitBtnLocked;
    btnRecalcAdicional: TBitBtnLocked;
    btnRecalcDigitado: TBitBtnLocked;
    BitBtnLocked1: TBitBtnLocked;
    procedure btnRecalcClick(Sender: TObject);
    procedure btnRecalcAdicionalClick(Sender: TObject);
    procedure btnRecalcDigitadoClick(Sender: TObject);
    procedure BitBtnLocked1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ocDescontoItemCompra: TOpcaoDescontoItemCompra;
  end;

var
  frmDecideDesconto: TfrmDecideDesconto;

implementation

{$R *.dfm}

procedure TfrmDecideDesconto.BitBtnLocked1Click(Sender: TObject);
begin
  ocDescontoItemCompra := odSomaAdcionaisDescForne01;
  Close;
end;

procedure TfrmDecideDesconto.btnRecalcAdicionalClick(Sender: TObject);
begin
  ocDescontoItemCompra := odSomenteAdicionais;
  Close;
end;

procedure TfrmDecideDesconto.btnRecalcClick(Sender: TObject);
begin
  ocDescontoItemCompra := odFornecedorEAdicionais;
  Close;
end;

procedure TfrmDecideDesconto.btnRecalcDigitadoClick(Sender: TObject);
begin
  ocDescontoItemCompra := odDigitadoAdicionais;
  Close;
end;

end.
