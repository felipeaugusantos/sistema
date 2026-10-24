unit untFatMenuPrecoQtde;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Buttons, BitBtnLockedIncrem;

type
  TfrmFatMenuPrecoQtde = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    pnlNumDoc: TPanel;
    rdgPreco: TRadioGroup;
    rdgQtde: TRadioGroup;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmFatMenuPrecoQtde.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatMenuPrecoQtde.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Escape) Then
    Begin
      Close;
    End;
end;

end.
