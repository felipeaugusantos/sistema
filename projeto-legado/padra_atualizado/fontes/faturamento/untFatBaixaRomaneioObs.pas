unit untFatBaixaRomaneioObs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, MemoFocus,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmFatBaixaRomaneioObs = class(TfrmPai)
    memObserv: TMemoFocus;
    btnConfirma: TBitBtnLocked;
    procedure memObservKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    function fVerificaObrigatoriedade: Boolean;
  public
    { Public declarations }
    blnObrigatorio: Boolean;
  end;

var
  frmFatBaixaRomaneioObs: TfrmFatBaixaRomaneioObs;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmFatBaixaRomaneioObs.memObservKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_F10 Then
  Begin
    Key := 0;
    btnConfirma.Click;
  End
  Else If Key = VK_ESCAPE Then
  Begin
    Close;
  End;
end;

procedure TfrmFatBaixaRomaneioObs.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaObrigatoriedade Then
    Exit;

  ModalResult := mrOk;
end;

procedure TfrmFatBaixaRomaneioObs.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(memObserv);
end;

procedure TfrmFatBaixaRomaneioObs.FormShow(Sender: TObject);
begin
  inherited;

  Application.ProcessMessages;
end;

function TfrmFatBaixaRomaneioObs.fVerificaObrigatoriedade: Boolean;
begin
  Result := True;
  If blnObrigatorio Then
  Begin
    If fEmptyStr(memObserv.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'É necessário digitar a observação!', ['&Ok']);
      Result := False;
    End;
  End;
end;

end.
