unit untEntItensNaoAvaliados;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, AppEvnts, Menus, Buttons, ExtCtrls;

type
  TfrmEntItensNaoAvaliados = class(TfrmPai)
    memItens: TMemo;
    procedure memItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEntItensNaoAvaliados: TfrmEntItensNaoAvaliados;

implementation

{$R *.dfm}

procedure TfrmEntItensNaoAvaliados.memItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_ESCAPE) Then
    Close;
end;

end.
