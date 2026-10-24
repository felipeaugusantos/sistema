unit untFatMostraDivergenciasPedOrc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids, DB,
  AppEvnts, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, untFuncoesSimples;

type
  TfrmFatMostraDivergenciasPedOrc = class(TfrmPai)
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

var
  frmFatMostraDivergenciasPedOrc: TfrmFatMostraDivergenciasPedOrc;

implementation

{$R *.dfm}

procedure TfrmFatMostraDivergenciasPedOrc.dbgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_ESCAPE) Then
    Close;
end;

procedure TfrmFatMostraDivergenciasPedOrc.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(dbgItens);
end;

end.
