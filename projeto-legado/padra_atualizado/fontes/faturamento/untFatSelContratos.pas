unit untFatSelContratos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids, DB,
  AppEvnts, BitBtnLockedIncrem;

type
  TfrmFatSelContratos = class(TfrmPai)
    dbgContratos: TDBGridCitel;
    dtsContratos: TDataSource;
    procedure dbgContratosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFatSelContratos: TfrmFatSelContratos;

implementation

{$R *.dfm}

procedure TfrmFatSelContratos.dbgContratosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
  Begin
    Close;
    ModalResult := mrOk;
  End
  Else If (Key = VK_ESCAPE) Then
  Begin
    Close;
  End;
end;

end.
