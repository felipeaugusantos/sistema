unit untCfgTravaVendaCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, Mask,
  DBCtrls, DBEditFocus, QColorLabel;

type
  TfrmCfgTravaVendaCliente = class(TfrmPai)
    pnlCentral: TPanel;
    btnGravar: TBitBtn;
    Label9: TLabel;
    ColorLabel23: TColorLabel;
    dbeTraScl: TDBEditFocus;
    GroupBox1: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    ColorLabel24: TColorLabel;
    dbeDianco: TDBEditFocus;
    dbeTranco: TDBEditFocus;
    edtSenNco: TEditFocus;
    GroupBox2: TGroupBox;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    ColorLabel25: TColorLabel;
    dbeAtrMax: TDBEditFocus;
    dbeTraMax: TDBEditFocus;
    edtSenMax: TEditFocus;
    GroupBox3: TGroupBox;
    Label19: TLabel;
    ColorLabel26: TColorLabel;
    Label17: TLabel;
    dbeLimiSn: TDBEditFocus;
    edtSenLim: TEditFocus;
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
  frmCfgTravaVendaCliente: TfrmCfgTravaVendaCliente;

implementation

uses untFuncoes, untfuncoesSimples, untModulo;

{$R *.dfm}

{ TfrmCfgTravaVendaCliente }

function TfrmCfgTravaVendaCliente.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  {*****************************************}
  {* VALIDAÇÕES REFERENTES À ABA TRAVA DE  *}
  {* VENDA - POR CLIENTE                   *}
  {**************************************MV*}
  If (Sender = dbeTraScl) Then
  Begin
    If fEmptyStr(dbeTraScl.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Trava atravéz da sitação deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If (Copy(dbeTraScl.Text, 1, 1) <> 'S') And
            (Copy(dbeTraScl.Text, 1, 1) <> 'N') Then
    Begin
      Result := False;
    End;
  End

  Else If (Sender = dbeDianco) Then
  Begin
    If fEmptyStr(dbeDianco.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O número máximo de dias que não compra deve ser informado!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(dbeDianco.Text) < 0.0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O número máximo de dias que não compra deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End
  End

  Else If (Sender = dbeAtrMax) Then
  Begin
    If fEmptyStr(dbeAtrMax.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Atrazo máximo deve ser informado!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(dbeAtrMax.Text) < 0.0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O Atrazo máximo deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End
  End

  Else If (Sender = dbeTranco) Or
          (Sender = dbeLimiSn) Or
          (Sender = dbeTraMax) Then
  Begin

    If fEmptyStr((Sender As TDBEdit).Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Opção de Trava deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If (Copy((Sender As TDBEdit).Text, 1, 1) <> 'A') And
            (Copy((Sender As TDBEdit).Text, 1, 1) <> 'T') And
            (Copy((Sender As TDBEdit).Text, 1, 1) <> 'N') Then
    Begin
      Result := False;
    End;

  End

  Else If (Sender = edtSenNco) Or
          (Sender = edtSenLim) Or
          (Sender = edtSenMax) Then
  Begin

    If fEmptyStr((Sender As TEdit).Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Senha para liberação da trava deve ser preenchida!', ['&Ok']);
      Result := False;
    End

  End;

  If (Not Result) Then
    Sender.SetFocus;

end;

procedure TfrmCfgTravaVendaCliente.pCarregaArqIni;
begin
  {********************************************}
  {* SENHAS DA ABA TRAVA DE VENDA POR CLIENTE *}
  {*****************************************MV*}
  edtSenNco.Text := frmModulo.qryCadCfg.FieldByName('CFG_SENNCO').AsString;
  edtSenLim.Text := frmModulo.qryCadCfg.FieldByName('CFG_SENLIM').AsString;
  edtSenMax.Text := frmModulo.qryCadCfg.FieldByName('CFG_SENMAX').AsString;
end;

procedure TfrmCfgTravaVendaCliente.pGravaArqIni;
begin
  {********************************************}
  {* SENHAS DA ABA TRAVA DE VENDA POR CLIENTE *}
  {*****************************************MV*}
  frmModulo.qryCadCfg.FieldByName('CFG_SENNCO').AsString := edtSenNco.Text;
  frmModulo.qryCadCfg.FieldByName('CFG_SENLIM').AsString := edtSenLim.Text;
  frmModulo.qryCadCfg.FieldByName('CFG_SENMAX').AsString := edtSenMax.Text;
end;

procedure TfrmCfgTravaVendaCliente.btnGravarClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) And (fMensagem('', 'Confirma alterações?', ['&Sim', '&Não']) = 1) Then
  Begin
    pGravaArqIni;
    Close;
    ModalResult := mrOk;
  End;
end;

procedure TfrmCfgTravaVendaCliente.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaArqIni;
end;

initialization
  RegisterClass(TfrmCfgTravaVendaCliente);
finalization
  UnRegisterClass(TfrmCfgTravaVendaCliente);

end.

