unit untDigTintaAutomotivaSalcomix;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untDigTintaAutomotiva, AppEvnts, Menus, StdCtrls, ComboBoxFocus,
  EditFocus, ExtCtrls, Buttons, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmDigTintaAutomotivaSalcomix = class(TfrmDigTintaAutomotiva)
    chkResina325: TCheckBox;
    procedure chkComCatClick(Sender: TObject);
    procedure edtVolumeExit(Sender: TObject);
    procedure rdbLitroClick(Sender: TObject);
    procedure cmbTipoEmbalagemSelect(Sender: TObject);
    procedure rdgModoVendaClick(Sender: TObject);Reintroduce;
    procedure chkConsEmbClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtQtdEmbExit(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    strQtdEmbAnt: String;
    strVolumeAnt: String;
    procedure pMarcarParaRecarregarBases;
    procedure pAntesCalcularFormula(Sender: TObject);
    procedure pDepoisCalcularFormula(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
    strLinha: String;
    strLinhasDiluido: String;
    strLinhasResina325: String;
  end;

var
  frmDigTintaAutomotivaSalcomix: TfrmDigTintaAutomotivaSalcomix;

implementation

uses untSalcomixDinamica, untFuncoesSimples, untAguardando, untIConfTinta,
  untTintaMaquina;

{$R *.dfm}

procedure TfrmDigTintaAutomotivaSalcomix.btnConfirmaClick(Sender: TObject);
begin
  TFormulaSalcomix(objFormula).antesCalcularFormula := Nil;
  TFormulaSalcomix(objFormula).depoisCalcularFormula := Nil;
  inherited;
end;

procedure TfrmDigTintaAutomotivaSalcomix.chkComCatClick(Sender: TObject);
begin
  pMarcarParaRecarregarBases;
  inherited;
end;

procedure TfrmDigTintaAutomotivaSalcomix.chkConsEmbClick(Sender: TObject);
begin
  pMarcarParaRecarregarBases;
  inherited;
end;

procedure TfrmDigTintaAutomotivaSalcomix.cmbTipoEmbalagemSelect(
  Sender: TObject);
begin
  pMarcarParaRecarregarBases;
  inherited;
end;

procedure TfrmDigTintaAutomotivaSalcomix.edtQtdEmbExit(Sender: TObject);
begin
  If (strQtdEmbAnt <> edtQtdEmb.Text) Then
  Begin
    strQtdEmbAnt := edtQtdEmb.Text;
    pMarcarParaRecarregarBases;
  End;
  inherited;
end;

procedure TfrmDigTintaAutomotivaSalcomix.edtVolumeExit(Sender: TObject);
begin
  If (strVolumeAnt <> edtVolume.Text) Then
  Begin
    strVolumeAnt := edtVolume.Text;
    pMarcarParaRecarregarBases;
  End;
  inherited;
end;

procedure TfrmDigTintaAutomotivaSalcomix.FormCreate(Sender: TObject);
begin
  inherited;
  strLinhasDiluido := 'S850';
  strLinhasResina325 := 'S326';

  If (fCfgSis('DIRFOR', varBoolean))  Then
    btnFormulacao.Visible :=  fVerificaAcessoSistema('DIRVISFOR');
end;

procedure TfrmDigTintaAutomotivaSalcomix.FormShow(Sender: TObject);
var
  strSenha: String;
  strUsuario: String;
  strDatabase: String;
  strHost: String;
  conf: IConfTinta;
  strNomeTinta: String;
begin
  strNomeTinta :=  IIF(Caption = 'Glasurit', 'GLA', 'SAL');

  conf        := fGetConfTinta(strNomeTinta);
  strSenha    := conf.fGet('SENSQS');
  strUsuario  := conf.fGet('USUSQS');
  strDatabase := conf.fGet('DATSQS');
  strHost     := conf.fGet('HOSSQS');

  If fEmptyStr(strUsuario) Then
  Begin
    fMensagem('', 'É necessário configurar a integração com o sistema ' + Caption + '.' + #13 +
                 'Campo "Usuário" está vazio nas configurações.', ['&Ok']);
    Exit;
  End
  Else If fEmptyStr(strSenha) Then
  Begin
    fMensagem('', 'É necessário configurar a integração com o sistema ' + Caption + '.' + #13 +
                 'Campo "Senha" está vazio nas configurações.', ['&Ok']);
    Exit;
  End
  Else If fEmptyStr(strDatabase) Then
  Begin
    fMensagem('', 'É necessário configurar a integração com o sistema ' + Caption + '.' + #13 +
                 'Campo "Banco" está vazio nas configurações.', ['&Ok']);
    Exit;
  End
  Else If fEmptyStr(strHost) Then
  Begin
    fMensagem('', 'É necessário configurar a integração com o sistema ' + Caption + '.' + #13 +
                 'Campo "IP / Host" está vazio nas configurações.', ['&Ok']);
    Exit;
  End;

  inherited;
  rdgModoVenda.Enabled := False;
  chkResina325.Enabled := False;

  If (Pos(Copy(strLinha,1,4), strLinhasDiluido) > 0) Then
  Begin
    rdgModoVenda.Enabled := True;
    rdgModoVenda.ItemIndex := 1;
  End
  else
    rdgModoVenda.ItemIndex := 0;

  If (Pos(Copy(strLinha,1,4), strLinhasResina325) > 0) Then
  Begin
    chkResina325.Enabled := True;
  End;

  if Pos('ESP',objFormula.strDescri) > 0 then  //novas formulas usam quantidades concentradas e diluidas.
  begin
    rdgModoVenda.Enabled := objFormula.blnTemDiluido And objFormula.blnTemConcentrado;

    If (Not rdgModoVenda.Enabled) Then
    Begin
      rdgModoVenda.ItemIndex := IIF(objFormula.blnTemConcentrado, 0, 1);
    End;
  end;

  pMarcarParaRecarregarBases;
  TFormulaSalcomix(objFormula).antesCalcularFormula := pAntesCalcularFormula;
  TFormulaSalcomix(objFormula).depoisCalcularFormula := pDepoisCalcularFormula;

  strQtdEmbAnt := edtQtdEmb.Text;
  strVolumeAnt := edtVolume.Text;

  If rdgModoVenda.Enabled And rdgModoVenda.Visible Then
    pSetFocus(rdgModoVenda)
  else
  if chkConsEmb.Enabled And chkConsEmb.Visible Then
    pSetFocus(chkConsEmb)
  else
  if edtProEmb.Enabled And edtProEmb.Visible Then
    pSetFocus(edtProEmb)
  else
  if edtQtdEmb.Enabled And edtQtdEmb.Visible Then
    pSetFocus(edtQtdEmb);


end;

procedure TfrmDigTintaAutomotivaSalcomix.pAntesCalcularFormula(Sender: TObject);
begin
  frmAguardando := TfrmAguardando.Create(Nil);
  frmAguardando.lblTexto.Caption := 'Aguardando sistema ' + Caption;
  frmAguardando.tmrFechar.Interval := 1000;
  frmAguardando.tmrFechar.Enabled := False;
  frmAguardando.tmrFechar.Enabled := True;
  frmAguardando.Show;
  frmAguardando.pFechar;
  Application.ProcessMessages;
end;

procedure TfrmDigTintaAutomotivaSalcomix.pDepoisCalcularFormula(
  Sender: TObject);
begin
  //
end;

procedure TfrmDigTintaAutomotivaSalcomix.pMarcarParaRecarregarBases;
begin
  TFormulaSalcomix(objFormula).blnRecarregarBases := True;
  TFormulaSalcomix(objFormula).blnResina325 := chkResina325.Checked;
  If Assigned(objFormulaQtdEsp) Then
  Begin
    TFormulaSalcomix(objFormulaQtdEsp).blnRecarregarBases := True;
    TFormulaSalcomix(objFormulaQtdEsp).blnResina325 := chkResina325.Checked;
  End;
end;

procedure TfrmDigTintaAutomotivaSalcomix.rdbLitroClick(Sender: TObject);
begin
  pMarcarParaRecarregarBases;
  inherited;
  strVolumeAnt := edtVolume.Text;
end;

procedure TfrmDigTintaAutomotivaSalcomix.rdgModoVendaClick(Sender: TObject);
begin
  pMarcarParaRecarregarBases;
  inherited;
end;

end.

