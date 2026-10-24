unit untDigData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Mask, MaskEditFocus,
  AppEvnts, BitBtnLockedIncrem;

type
  TfrmDigData = class(TfrmPai)
    Panel1: TPanel;
    mskData: TMaskEditFocus;
    lblData: TLabel;
    btnConfirmaDados: TBitBtnLocked;
    procedure btnConfirmaDadosClick(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmDigData: TfrmDigData;

implementation

uses untFuncoes;

{$R *.dfm}

{ TfrmDigData }

function TfrmDigData.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;
  If (fEmptyStr(fTiraCaracEspeciais(mskData.Text))) Then
  Begin
    fMensagem('ATENÇÃO!', 'A data deve ser preenchida!', ['&Ok']);
    Result := False;
  End;

  If (Not Result) Then
    Sender.SetFocus;

end;

procedure TfrmDigData.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
    Close;
    ModalResult := mrOk;
  End;
end;

end.

