unit untDigTintaAutomotivaFarben;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untDigTintaAutomotiva, AppEvnts, Menus, StdCtrls, ComboBoxFocus,
  EditFocus, ExtCtrls, Buttons, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmDigTintaAutomotivaFarben = class(TfrmDigTintaAutomotiva)
    rdbSprayFarben: TRadioButton;
    procedure rdbLitroClick(Sender: TObject);
    procedure edtVolumeExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pDefineEmbalagem; override;
    procedure rdbLitroExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    strProEmbSy : String;
  end;

var
  frmDigTintaAutomotivaFarben: TfrmDigTintaAutomotivaFarben;

implementation

uses untFuncEspecificas, untFuncoesSimples;

{$R *.dfm}

procedure TfrmDigTintaAutomotivaFarben.FormShow(Sender: TObject);
begin
  inherited;
  pMostrarAcertoTinta;
end;

procedure TfrmDigTintaAutomotivaFarben.pDefineEmbalagem;
begin
  inherited;
  if (rdbSprayFarben.Checked) then
  begin
    objFormula.strCodEmb := strProEmbSy;
    pEmbalagemNaoConfigurada(objFormula.strCodEmb);
  end;
end;

procedure TfrmDigTintaAutomotivaFarben.rdbLitroClick(Sender: TObject);
begin
  inherited;
  If (rdbCopo.Checked) Then
  Begin
    objFormula.tpeTipEmb := teCopo;
    edtVolume.Text := '0,450';
  End
  Else If (rdbSpray.Checked) Then
  Begin
    objFormula.tpeTipEmb := teLata;
    edtVolume.Text := '18,000';
  End
  Else If (rdbTambor.Checked) Then
  Begin
    objFormula.tpeTipEmb := teTambor;
    edtVolume.Text := '200,000';
  End
  Else If (rdbSprayFarben.Checked) Then
  Begin
    objFormula.tpeTipEmb := teSpray;
    edtVolume.Text := '0,400';
  End;

  objFormula.fltVolumePro := fStrToFloat(edtVolume.Text);

  pDefineEmbalagem;

  pAtualizaPrecos;
end;

procedure TfrmDigTintaAutomotivaFarben.rdbLitroExit(Sender: TObject);
begin
  inherited;
  If (cmbTipoEmbalagem.Visible) And (cmbTipoEmbalagem.Enabled) Then
    pSetFocus(cmbTipoEmbalagem)
  else
  If (rdgAcerto.Visible) And (rdgAcerto.Enabled) Then
    pSetFocus(rdgAcerto)
  Else
  If (pnlAdicional.Visible) And (cmbListaAdicional.Enabled) Then
    pSetFocus(cmbListaAdicional)
  Else
  If (chkComCat.Visible) And (chkComCat.Enabled) Then
    pSetFocus(chkComCat)
  Else
  If (edtVolume.Visible) And (edtVolume.Enabled) Then
    pSetFocus(edtVolume)
  else
    pSetFocus(btnConfirma);
end;

procedure TfrmDigTintaAutomotivaFarben.edtVolumeExit(Sender: TObject);
begin
  If (fEmptyStr(edtVolume.Text)) Then
  Begin
    fMensagem('', 'O volume deve ser preenchido!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (fStrToFloat(edtVolume.Text) <= 0) Then
  Begin
    fMensagem('', 'O volume deve ser maior que Zero!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbLitro.Checked) And (fStrToFloat(edtVolume.Text) > 1) Then
  Begin
    fMensagem('', 'O volume máximo para Litro é 1,000!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbGalao.Checked) And (fStrToFloat(edtVolume.Text) > 4) Then
  Begin
    fMensagem('', 'O volume máximo para Galão é 4,000!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbCopo.Checked) And (fFormataFloat(fStrToFloat(edtVolume.Text), 3) > fFormataFloat(0.450, 3)) Then
  Begin
    fMensagem('', 'O volume máximo para Copo é 0,450!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbSpray.Checked) And (fFormataFloat(fStrToFloat(edtVolume.Text), 3) > fFormataFloat(18, 3)) Then
  Begin
    fMensagem('', 'O volume máximo para Lata é 18,000!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbTambor.Checked) And (fFormataFloat(fStrToFloat(edtVolume.Text), 3) > fFormataFloat(200, 3)) Then
  Begin
    fMensagem('', 'O volume máximo para Tambor é 200,000!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbSprayFarben.Checked) And (fFormataFloat(fStrToFloat(edtVolume.Text), 3) > fFormataFloat(400, 3)) Then
  Begin
    fMensagem('', 'O volume máximo para Spray é 0,400!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End;

  objFormula.fltVolumePro := fStrToFloat(edtVolume.Text);
  pAtualizaPrecos;
end;

end.
