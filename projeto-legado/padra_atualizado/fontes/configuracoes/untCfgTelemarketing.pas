unit untCfgTelemarketing;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, RxDBComb, untFuncoes, untfuncoesSimples;

type
  TfrmCfgTelemarketing = class(TfrmPai)
    Label108: TLabel;
    dbeTipAge: TRxDBComboBox;
    btnGravar: TBitBtn;
    procedure btnGravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCfgTelemarketing: TfrmCfgTelemarketing;

implementation

uses untPrincipal, untModulo, DB;

{$R *.dfm}

procedure TfrmCfgTelemarketing.btnGravarClick(Sender: TObject);
begin
  inherited;

  If (fVerificaCampos) And (fMensagem('', 'Confirma alterações?', ['&Sim', '&Não']) = 1) Then
  Begin
    VS_strTelAge := frmModulo.dtsCadCfg.DataSet.FieldByName('CFG_TELAGE').AsString;

    Close;
    ModalResult := mrOk;
  End;

end;

procedure TfrmCfgTelemarketing.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key of
     VK_ESCAPE: Close;
     VK_RETURN: If ActiveControl Is TRxDBComboBox Then
                  Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCfgTelemarketing.FormShow(Sender: TObject);
begin
  inherited;

  ActiveControl := dbeTipAge;
end;

initialization
  RegisterClass(TfrmCfgTelemarketing);
finalization
  UnRegisterClass(TfrmCfgTelemarketing);

end.

