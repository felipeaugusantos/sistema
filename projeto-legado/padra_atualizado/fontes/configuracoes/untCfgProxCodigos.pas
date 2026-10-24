unit untCfgProxCodigos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Mask, DBCtrls, DBEditFocus, Menus, Buttons,
  ExtCtrls;

type
  TfrmCfgProxCodigos = class(TfrmPai)
    pnlCentral: TPanel;
    Label5: TLabel;
    dbeSeqCtb: TDBEditFocus;
    btnGravar: TBitBtn;
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCfgProxCodigos: TfrmCfgProxCodigos;

implementation

uses untFuncoes, untfuncoesSimples;

{$R *.dfm}

procedure TfrmCfgProxCodigos.btnGravarClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) And (fMensagem('', 'Confirma alterações?', ['&Sim', '&Não']) = 1) Then
  Begin
    Close;
    ModalResult := mrOk;
  End;

end;

initialization
  RegisterClass(TfrmCfgProxCodigos);
finalization
  UnRegisterClass(TfrmCfgProxCodigos);

end.

