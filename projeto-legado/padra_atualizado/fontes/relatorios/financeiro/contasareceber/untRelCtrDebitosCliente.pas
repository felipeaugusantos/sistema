unit untRelCtrDebitosCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF,
  RLFilters, RLDraftFilter, AppEvnts, Menus, StdCtrls, EditFocus,
  QColorLabel, ExtCtrls, Buttons, BitBtnLockedIncrem, frxExportCSVTestabilidade;

type
  TfrmRelCtrDebitosCliente = class(TfrmPaiRelatorio)
    chkContaCorrente: TCheckBox;
    chkProduto: TCheckBox;
    chkCheque: TCheckBox;
    chkObservacao: TCheckBox;
    chkDocAg: TCheckBox;
    chkAjuDta: TCheckBox;
    chkDtaVen: TCheckBox;
    chkEndEre: TCheckBox;
    chkJuros: TCheckBox;
    chkBancoDoBoleto: TCheckBox;
    chkNumPedFF: TCheckBox;
    chkCredito: TCheckBox;
    rdgOrdem: TRadioGroup;
    procedure chkContaCorrenteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

procedure TfrmRelCtrDebitosCliente.chkContaCorrenteClick(Sender: TObject);
begin
  inherited;

  If chkContaCorrente.Checked Then
  Begin
    chkProduto.Enabled    := True;
    chkObservacao.Enabled := True;
    chkDocAg.Enabled      := True;
    chkEndEre.Enabled     := True;
  End
  Else
  Begin
    chkProduto.Enabled    := False;
    chkProduto.Checked    := False;
    chkObservacao.Enabled := False;
    chkObservacao.Checked := False;
    chkDocAg.Enabled      := False;
    chkDocAg.Checked      := False;
    chkEndEre.Enabled     := False;
    chkEndEre.Checked     := False;
  End;
end;

end.
