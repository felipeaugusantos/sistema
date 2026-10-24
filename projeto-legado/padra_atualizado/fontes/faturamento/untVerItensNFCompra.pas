unit untVerItensNFCompra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids,
  EditFocus, DB, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmVerItensNFCompra = class(TfrmPai)
    dbgItens: TDBGridCitel;
    dtsItens: TDataSource;
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmVerItensNFCompra.dbgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_ESCAPE) Then
  Begin
    btnSair.Click;
  End;
end;

procedure TfrmVerItensNFCompra.FormShow(Sender: TObject);
begin
  inherited;
  If fCfgSis('CTLEST') = '1' Then
    fFindColumnByName(dbgItens, 'NUMLOT').Title.Caption := 'Lote'
  Else
    fFindColumnByName(dbgItens, 'NUMLOT').Title.Caption := 'Armazém';
end;

end.

