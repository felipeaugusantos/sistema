unit untFatDigTipoEmbalagem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, AppEvnts,
  BitBtnLockedIncrem;

type
  TfrmFatDigTipoEmbalagem = class(TfrmPai)
    lstTiposEmb: TListBox;
    btnConfirmaDados: TBitBtnLocked;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure lstTiposEmbKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFatDigTipoEmbalagem: TfrmFatDigTipoEmbalagem;

implementation

{$R *.dfm}

procedure TfrmFatDigTipoEmbalagem.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  Close;
  ModalResult := mrOk;
end;

procedure TfrmFatDigTipoEmbalagem.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatDigTipoEmbalagem.lstTiposEmbKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
    btnConfirmaDados.Click

  Else If (Key = VK_ESCAPE) Then
    btnSair.Click;
end;

procedure TfrmFatDigTipoEmbalagem.FormShow(Sender: TObject);
begin
  inherited;
  lstTiposEmb.ItemIndex   := 0;
  lstTiposEmb.Selected[0] := True;
end;

end.
