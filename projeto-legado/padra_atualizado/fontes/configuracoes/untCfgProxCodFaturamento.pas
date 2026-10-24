unit untCfgProxCodFaturamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls,
  DBEditFocus;

type
  TfrmCfgProxCodFaturamento = class(TfrmPai)
    pnlCentral: TPanel;
    Label146: TLabel;
    Label147: TLabel;
    Label149: TLabel;
    Label150: TLabel;
    Label151: TLabel;
    Label152: TLabel;
    Label153: TLabel;
    Label99: TLabel;
    Label100: TLabel;
    Label107: TLabel;
    Label133: TLabel;
    Label6: TLabel;
    Label164: TLabel;
    Label165: TLabel;
    dbePro_NF: TDBEditFocus;
    dbePro_MI: TDBEditFocus;
    dbePro_OR: TDBEditFocus;
    dbePro_PD: TDBEditFocus;
    dbePro_TR: TDBEditFocus;
    dbePro_AJ: TDBEditFocus;
    dbePro_BR: TDBEditFocus;
    dbePro_Te: TDBEditFocus;
    dbePro_Cp: TDBEditFocus;
    dbePro_Dv: TDBEditFocus;
    dbePro_FF: TDBEditFocus;
    dbeProCco: TDBEditFocus;
    dbePro_TM: TDBEditFocus;
    dbePro_ML: TDBEditFocus;
    btnGravar: TBitBtn;
    Label1: TLabel;
    dbeProChq: TDBEditFocus;
    Label2: TLabel;
    dbePro_PI: TDBEditFocus;
    Label3: TLabel;
    dbePro_OP: TDBEditFocus;
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCfgProxCodFaturamento: TfrmCfgProxCodFaturamento;

implementation

uses untFuncoes, untfuncoesSimples;

{$R *.dfm}

{ TfrmPai1 }

function TfrmCfgProxCodFaturamento.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  {*****************************************}
  {* VALIDAÇÕES PARA OS PROXIMOS SEQUENCI- *}
  {* AIS PARA FATURAMENTO                  *}
  {**************************************MV*}
  If (Sender = dbePro_NF) Or
     (Sender = dbePro_MI) Or
     (Sender = dbePro_OR) Or
     (Sender = dbePro_PD) Or
     (Sender = dbePro_TR) Or
     (Sender = dbePro_AJ) Or
     (Sender = dbePro_BR) Or
     (Sender = dbePro_DV) Or
     (Sender = dbePro_FF) Or
     (Sender = dbePro_TM) Or
     (Sender = dbePro_ML) Or
     (Sender = dbeProCco) Or
     (Sender = dbeProChq) Or
     (Sender = dbePro_PI) Then
  Begin

    If fEmptyStr((Sender As TDBEditFocus).Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Todos os sequênciais devem ser preenchidos!', ['&Ok']);
      Result := False;
    End;

  End;

  If (Not Result) Then
    Sender.SetFocus;

end;

procedure TfrmCfgProxCodFaturamento.btnGravarClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) And (fMensagem('', 'Confirma alterações?', ['&Sim', '&Não']) = 1) Then
  Begin
    Close;
    ModalResult := mrOk;
  End;
end;

initialization
  RegisterClass(TfrmCfgProxCodFaturamento);
finalization
  UnRegisterClass(TfrmCfgProxCodFaturamento);

end.

