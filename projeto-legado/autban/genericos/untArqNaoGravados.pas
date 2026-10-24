unit untArqNaoGravados;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, Buttons, ExtCtrls, AppEvnts,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmArqNaoGravados = class(TForm)
    pnlCentral: TPanel;
    memResumo: TMemo;
    procedure memResumoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmArqNaoGravados: TfrmArqNaoGravados;

implementation

{$R *.dfm}

procedure TfrmArqNaoGravados.memResumoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_ESCAPE) Then
  Begin
    Close;
  End;
end;

end.
