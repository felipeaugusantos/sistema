unit untFatMostraItemSalBal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids,
  AppEvnts, BitBtnLockedIncrem;

type
  TfrmFatMostraItemSalBal = class(TfrmPai)
    pnlDados: TPanel;
    dbgItens: TDBGridCitel;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    strPedOrc: String;
    strNumPed: String;
  end;

var
  frmFatMostraItemSalBal: TfrmFatMostraItemSalBal;

implementation

{$R *.dfm}

procedure TfrmFatMostraItemSalBal.FormShow(Sender: TObject);
begin
  inherited;

  If strPedOrc = 'PD' Then
    frmFatMostraItemSalBal.Caption := 'Itens travados referente ao Pedido Nº ' + strNumPed
  Else
  If strPedOrc = 'OR' Then
    frmFatMostraItemSalBal.Caption := 'Itens travados referente ao Orçamento Nº ' + strNumPed;
end;

procedure TfrmFatMostraItemSalBal.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Escape) Then
    Close;
end;

end.

