unit untCfgTravaVendaPreco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, Mask,
  DBCtrls, DBEditFocus, QColorLabel, ComboBoxFocus, AppEvnts;

type
  TfrmCfgTravaVendaPreco = class(TfrmPai)
    pnlCentral: TPanel;
    btnGravar: TBitBtn;
    Label24: TLabel;
    ColorLabel27: TColorLabel;
    Label25: TLabel;
    dbeTraDes: TDBEditFocus;
    edtSenLbd: TEditFocus;
    GroupBox1: TGroupBox;
    Label22: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    dbeTraFat: TDBEditFocus;
    dbeTraFa2: TDBEditFocus;
    cmbCamTb1: TComboBoxFocus;
    cmbCamTb2: TComboBoxFocus;
    dbeTraFa3: TDBEditFocus;
    cmbCamTb3: TComboBoxFocus;
    Label6: TLabel;
    dbeTrVePr: TDBEditFocus;
    ColorLabel1: TColorLabel;
    Label7: TLabel;
    cmbCamTb4: TComboBoxFocus;
    Label8: TLabel;
    dbeTraFa4: TDBEditFocus;
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
  frmCfgTravaVendaPreco: TfrmCfgTravaVendaPreco;

implementation

uses untFuncoes, untfuncoesSimples, untConstantes, untModulo;

{$R *.dfm}

{ TfrmCfgTravaVendaPreco }

function TfrmCfgTravaVendaPreco.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  {*****************************************}
  {* VALIDAÇÕES DA ABA TRAVA PARA VALOR DE *}
  {* VENDA - POR PREÇO                     *}
  {**************************************MV*}
  If (Sender = dbeTraFat) Then
  Begin

    If fEmptyStr(dbeTraFat.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Fator da trava (Tabela 1) deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(dbeTraFat.Text) = 0.0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O Fator da trava (Tabela 1) deve ser diferente de Zero!', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbeTraFa2) Then
  Begin

    If fEmptyStr(dbeTraFa2.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Fator da trava (Tabela 2) deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(dbeTraFa2.Text) = 0.0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O Fator da trava (Tabela 2) deve ser diferente de Zero!', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbeTraFa3) Then
  Begin

    If fEmptyStr(dbeTraFa3.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Fator da trava (Tabela 3) deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(dbeTraFa3.Text) = 0.0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O Fator da trava (Tabela 3) deve ser diferente de Zero!', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbeTraFa4) Then
  Begin

    If fEmptyStr(dbeTraFa4.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Fator da trava (Tabela 4) deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(dbeTraFa4.Text) = 0.0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O Fator da trava (Tabela 4) deve ser diferente de Zero!', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbeTraDes) Then
  Begin

    If fEmptyStr(dbeTraDes.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Opção de trava deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If (Copy(dbeTraDes.Text, 1, 1) <> '1') And
            (Copy(dbeTraDes.Text, 1, 1) <> '2') And
            (Copy(dbeTraDes.Text, 1, 1) <> '3') Then
    Begin
      Result := False;
    End;

  End

  Else If (Sender = dbeTrVePr) Then
  Begin
    Result := (Pos(dbeTrVePr.Text, '12') > 0);
  End

  Else If (Sender = edtSenLbd) Then
  Begin

    If fEmptyStr(edtSenLbd.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Senha para liberação da trava deve ser preenchida!', ['&Ok']);
      Result := False;
    End

  End;

  If (Not Result) Then
    Sender.SetFocus;

end;

procedure TfrmCfgTravaVendaPreco.pCarregaArqIni;
  Var
    intIndice: Integer;
begin
  {******************************************}
  {* SENHA PARA LIBERAÇÃO DE TRAVA DE VENDA *}
  {* POR PREÇO                              *}
  {***************************************MV*}
  edtSenLbd.Text := frmModulo.qryCadCfg.FieldByName('CFG_SENLBD').AsString;

  If (frmModulo.qryCadCfg.FieldByName('CFG_CAMTB1').AsString = 'VE1') Then
    intIndice := 0
  Else If (frmModulo.qryCadCfg.FieldByName('CFG_CAMTB1').AsString = 'VE2') Then
    intIndice := 1
  Else If (frmModulo.qryCadCfg.FieldByName('CFG_CAMTB1').AsString = 'VE3') Then
    intIndice := 2
  Else If (frmModulo.qryCadCfg.FieldByName('CFG_CAMTB1').AsString = 'VE4') Then
    intIndice := 3
  Else
    intIndice := 4;

  cmbCamTb1.ItemIndex := intIndice;

  If (frmModulo.qryCadCfg.FieldByName('CFG_CAMTB2').AsString = 'VE1') Then
    intIndice := 0
  Else If (frmModulo.qryCadCfg.FieldByName('CFG_CAMTB2').AsString = 'VE2') Then
    intIndice := 1
  Else If (frmModulo.qryCadCfg.FieldByName('CFG_CAMTB2').AsString = 'VE3') Then
    intIndice := 2
  Else If (frmModulo.qryCadCfg.FieldByName('CFG_CAMTB2').AsString = 'VE4') Then
    intIndice := 3
  Else
    intIndice := 4;

  cmbCamTb2.ItemIndex := intIndice;

  If (frmModulo.qryCadCfg.FieldByName('CFG_CAMTB3').AsString = 'VE1') Then
    intIndice := 0
  Else If (frmModulo.qryCadCfg.FieldByName('CFG_CAMTB3').AsString = 'VE2') Then
    intIndice := 1
  Else If (frmModulo.qryCadCfg.FieldByName('CFG_CAMTB3').AsString = 'VE3') Then
    intIndice := 2
  Else If (frmModulo.qryCadCfg.FieldByName('CFG_CAMTB3').AsString = 'VE4') Then
    intIndice := 3
  Else
    intIndice := 4;

  cmbCamTb3.ItemIndex := intIndice;

  If (frmModulo.qryCadCfg.FieldByName('CFG_CAMTB4').AsString = 'VE1') Then
    intIndice := 0
  Else If (frmModulo.qryCadCfg.FieldByName('CFG_CAMTB4').AsString = 'VE2') Then
    intIndice := 1
  Else If (frmModulo.qryCadCfg.FieldByName('CFG_CAMTB4').AsString = 'VE3') Then
    intIndice := 2
  Else If (frmModulo.qryCadCfg.FieldByName('CFG_CAMTB4').AsString = 'VE4') Then
    intIndice := 3
  Else
    intIndice := 4;

  cmbCamTb4.ItemIndex := intIndice;
end;

procedure TfrmCfgTravaVendaPreco.pGravaArqIni;
  Var
    strCampo: String;
begin
  {******************************************}
  {* SENHA PARA LIBERAÇÃO DE TRAVA DE VENDA *}
  {* POR PREÇO                              *}
  {***************************************MV*}
  frmModulo.qryCadCfg.FieldByName('CFG_SENLBD').AsString := edtSenLbd.Text;

  Case cmbCamTb1.ItemIndex Of
    0: strCampo := 'VE1';
    1: strCampo := 'VE2';
    2: strCampo := 'VE3';
    3: strCampo := 'VE4';
    4: strCampo := 'CUS';
  End;
  frmModulo.qryCadCfg.FieldByName('CFG_CAMTB1').AsString := strCampo;

  Case cmbCamTb2.ItemIndex Of
    0: strCampo := 'VE1';
    1: strCampo := 'VE2';
    2: strCampo := 'VE3';
    3: strCampo := 'VE4';
    4: strCampo := 'CUS';
  End;
  frmModulo.qryCadCfg.FieldByName('CFG_CAMTB2').AsString := strCampo;

  Case cmbCamTb3.ItemIndex Of
    0: strCampo := 'VE1';
    1: strCampo := 'VE2';
    2: strCampo := 'VE3';
    3: strCampo := 'VE4';
    4: strCampo := 'CUS';
  End;
  frmModulo.qryCadCfg.FieldByName('CFG_CAMTB3').AsString := strCampo;

  Case cmbCamTb4.ItemIndex Of
    0: strCampo := 'VE1';
    1: strCampo := 'VE2';
    2: strCampo := 'VE3';
    3: strCampo := 'VE4';
    4: strCampo := 'CUS';
  End;
  frmModulo.qryCadCfg.FieldByName('CFG_CAMTB4').AsString := strCampo;
end;

procedure TfrmCfgTravaVendaPreco.btnGravarClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) And (fMensagem('', 'Confirma alterações?', ['&Sim', '&Não']) = 1) Then
  Begin
    pGravaArqIni;
    Close;
    ModalResult := mrOk;
  End;
end;

procedure TfrmCfgTravaVendaPreco.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaArqIni;
end;

initialization
  RegisterClass(TfrmCfgTravaVendaPreco);
finalization
  UnRegisterClass(TfrmCfgTravaVendaPreco);

end.

