unit untCfgTrocaMercadoria;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls,
  DBEditFocus, EditFocus, QColorLabel, DBComboBoxFocus;

type
  TfrmCfgTrocaMercadoria = class(TfrmPai)
    pnlCentral: TPanel;
    btnGravar: TBitBtn;
    Label115: TLabel;
    Label108: TLabel;
    ColorLabel48: TColorLabel;
    edtSenTro: TEditFocus;
    dbeEntTro: TDBEditFocus;
    Label1: TLabel;
    cmbPrTrSa: TDBComboBoxFocus;
    Label2: TLabel;
    cmbPrTrEn: TDBComboBoxFocus;
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure pGravaArqIni;
    procedure pCarregaArqIni;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCfgTrocaMercadoria: TfrmCfgTrocaMercadoria;

implementation

uses untFuncoes, untfuncoesSimples, untModulo;

{$R *.dfm}

{ TfrmCfgTrocaMercadoria }

function TfrmCfgTrocaMercadoria.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  {*********************************************}
  {* VALIDAÇÕES DA A ABA PARAMETROS DA VENDA 2 *}
  {******************************************MV*}
  If (Sender = dbeEntTro) Then
  Begin
    If fEmptyStr((Sender As TDBEdit).Text) Then
    Begin
      Result := False;
    End
    Else If (Copy((Sender As TDBEdit).Text, 1, 1) <> 'S') And
            (Copy((Sender As TDBEdit).Text, 1, 1) <> 'N') Then
    Begin
      Result := False;
    End;
  End

  {*****************************************}
  {* VALIDAÇÕES REFERENTES À TROCA         *}
  {**************************************MV*}
  Else If (Sender = edtSenTro) Then
  Begin
    If fEmptyStr(edtSenTro.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A senha para utilização da Troca deve ser preenchida!', ['&Ok']);
      Result := False;
    End;
  End

  {*******************************************}
  {* PREÇO SUGESTÃO PARA ENTRADA!            *}
  {****************************************MV*}
  Else If (Sender = cmbPrTrSa) Then
  Begin

    If (fEmptyStr(cmbPrTrSa.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'É necessário escolher um preço!', ['&Ok']);
      Result := False;
    End;

  End

  {*******************************************}
  {* PREÇO SUGESTÃO PARA SAIDA!              *}
  {****************************************MV*}
  Else If (Sender = cmbPrTrEn) Then
  Begin
    If (fEmptyStr(cmbPrTrEn.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'É necessário escolher um preço!', ['&Ok']);
      Result := False;
    End;
  End;

  If (Not Result) Then
    Sender.SetFocus;

end;

procedure TfrmCfgTrocaMercadoria.pCarregaArqIni;
begin
  {*****************************************}
  {* SENHA DA TROCA DE MERCADORIAS         *}
  {**************************************MV*}
  edtSenTro.Text := frmModulo.qryCadCfg.FieldByName('CFG_SENTRO').AsString;
end;

procedure TfrmCfgTrocaMercadoria.pGravaArqIni;
begin
  {*****************************************}
  {* SENHA DA TROCA DE MERCADORIAS         *}
  {**************************************MV*}
  frmModulo.qryCadCfg.FieldByName('CFG_SENTRO').AsString := edtSenTro.Text;
end;

procedure TfrmCfgTrocaMercadoria.btnGravarClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) And (fMensagem('', 'Confirma alterações?', ['&Sim', '&Não']) = 1) Then
  Begin
    pGravaArqIni;
    Close;
    ModalResult := mrOk;
  End;

end;

procedure TfrmCfgTrocaMercadoria.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaArqIni;
end;

initialization
  RegisterClass(TfrmCfgTrocaMercadoria);
finalization
  UnRegisterClass(TfrmCfgTrocaMercadoria);

end.

