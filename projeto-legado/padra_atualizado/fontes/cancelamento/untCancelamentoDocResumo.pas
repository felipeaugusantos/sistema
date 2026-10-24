unit untCancelamentoDocResumo;

interface

uses
  Windows, Classes, Forms, untPaiSimples, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, AppEvnts, BitBtnLockedIncrem, Controls, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmCancelamentoDocResumo = class(TfrmPaiSimples)
    pnlCentral: TPanel;
    memResumo: TMemo;
    procedure memResumoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses untPai;

{$R *.dfm}

procedure TfrmCancelamentoDocResumo.memResumoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_ESCAPE) Then
  Begin
    btnSair.Click;
  End;
end;

end.
