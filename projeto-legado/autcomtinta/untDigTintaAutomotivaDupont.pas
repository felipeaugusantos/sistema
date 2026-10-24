unit untDigTintaAutomotivaDupont;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  AppEvnts, Menus, StdCtrls, ComboBoxFocus,
  EditFocus, ExtCtrls, Buttons, untDigTintaAutomotivaColorPro,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmDigTintaAutomotivaDupont = class(TfrmDigTintaAutomotivaColorPro)
    rdbDuco: TRadioButton;
    rdbPoliester: TRadioButton;
    procedure rdbPoliesterClick(Sender: TObject);
    procedure rdbDucoClick(Sender: TObject);
    procedure edtVolumeExit(Sender: TObject);
    procedure rdgModoVendaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rdbLitroClick(Sender: TObject);
    procedure rdbBaldeClick(Sender: TObject);
    procedure rdbTamborClick(Sender: TObject);
    procedure btnFormulacaoClick(Sender: TObject);
  private
    { Private declarations }

  protected
    procedure pDefineEmbalagem; override;
    procedure pAjustaRadioButtons; override;
  public
    { Public declarations }
    strProEmbPo: String;
    strProEmbDu: String;
    strProEmbBa: String;
    strQualid: String;
  end;

var
  frmDigTintaAutomotivaDupont: TfrmDigTintaAutomotivaDupont;

implementation

uses
  untFuncEspecificas, untFuncoesSimples, untFormulacaoAutomotivaDupont,untDigTintaAutomotiva;

{$R *.dfm}

procedure TfrmDigTintaAutomotivaDupont.rdbPoliesterClick(Sender: TObject);
begin
  inherited;
  objFormula.tpeTipEmb := tePoliester;
  edtVolume.Text := '0,150';
  rdbLitroClick(rdbPoliester);
end;

procedure TfrmDigTintaAutomotivaDupont.rdbTamborClick(Sender: TObject);
begin
  inherited;
  objFormula.tpeTipEmb := teTambor;
  edtVolume.Text := '196,000';
  rdbLitroClick(rdbTambor);
end;

procedure TfrmDigTintaAutomotivaDupont.rdbBaldeClick(Sender: TObject);
begin
  inherited;
  objFormula.tpeTipEmb := teBalde;
  edtVolume.Text := '18,000';
  rdbLitroClick(rdbBalde);
end;

procedure TfrmDigTintaAutomotivaDupont.rdbDucoClick(Sender: TObject);
begin
  inherited;
  objFormula.tpeTipEmb := teDuco;
  edtVolume.Text := '0,150';
  rdbLitroClick(rdbPoliester);
end;

procedure TfrmDigTintaAutomotivaDupont.rdbLitroClick(Sender: TObject);
begin
//  inherited;
  If (rdbLitro.Checked) Then
  Begin
    objFormula.tpeTipEmb := teLitro;
    edtVolume.Text := '0,900';
  End
  Else If (rdbGalao.Checked) Then
  Begin
    objFormula.tpeTipEmb := teGalao;
    edtVolume.Text := '3,600';
  End
  Else If (rdbCopo.Checked) Then
  Begin
    objFormula.tpeTipEmb := teCopo;
    edtVolume.Text := '0,500';
  End
  Else If (rdbSpray.Checked) Then
  Begin
    objFormula.tpeTipEmb := teSpray;
    edtVolume.Text := '0,150';
  End
  Else If (rdbSprayS.Checked) Then
  Begin
    objFormula.tpeTipEmb := teSpray;
    edtVolume.Text := '0,150';
  End
  Else If (rdbLata.Checked) Then
  Begin
    objFormula.tpeTipEmb := teLata;
    edtVolume.Text := '18,000';
  End
  Else If (rdbBalde.Checked) Then
  Begin
    objFormula.tpeTipEmb := teBalde;
    edtVolume.Text := '18,000';
  End;

  objFormula.fltVolumePro := fStrToFloat(edtVolume.Text);

  If (rdbLitro.Checked) Or (rdbGalao.Checked) Or (rdbLata.Checked) Then
  Begin
    If blnHabTipoEmb Then
    Begin
      lblTipo.Visible          := True;
      cmbTipoEmbalagem.Visible := True;
    End;
    cmbTipoEmbalagemSelect(cmbTipoEmbalagem);
  End
  Else
  Begin
    lblTipo.Visible          := False;
    cmbTipoEmbalagem.Visible := False;
    pDefineEmbalagem;
  End;

  pAtualizaPrecos;
end;

procedure TfrmDigTintaAutomotivaDupont.pDefineEmbalagem;
begin
  inherited;
  If objFormula.blnConsiderarEmbalagem Then
  Begin
    If (rdbPoliester.Checked) Then
    Begin
      objFormula.strCodEmb := strProEmbPo;
      pEmbalagemNaoConfigurada(objFormula.strCodEmb);
    End

    Else If (rdbDuco.Checked) Then
    Begin
      objFormula.strCodEmb := strProEmbDu;
      pEmbalagemNaoConfigurada(objFormula.strCodEmb);
    End

    Else If (rdbBalde.Checked) Then
    Begin
      objFormula.strCodEmb := strProEmbBa;
      pEmbalagemNaoConfigurada(objFormula.strCodEmb);
    End

    Else If (rdbTambor.Checked) Then
    Begin
      objFormula.strCodEmb := strProEmbTb;
      pEmbalagemNaoConfigurada(objFormula.strCodEmb);
    End;
  End;
end;

procedure TfrmDigTintaAutomotivaDupont.btnFormulacaoClick(Sender: TObject);
begin
  frmFormulacaoAutomotivaDupont := nil;
  Try
    Try
      frmFormulacaoAutomotivaDupont := TfrmFormulacaoAutomotivaDupont.Create(Self);
      frmFormulacaoAutomotivaDupont.objFormula := objFormula;
      frmFormulacaoAutomotivaDupont.objFormulaQtdEsp := objFormulaQtdEsp;

      If (Not blnMosDil2) Then
      Begin
        frmFormulacaoAutomotivaDupont.lsvFormulacao.Columns[4].Width := 0;
        frmFormulacaoAutomotivaDupont.Width := frmFormulacaoAutomotivaDupont.Width - 100;
      End;

      frmFormulacaoAutomotivaDupont.Caption := frmFormulacaoAutomotivaDupont.Caption + objFormula.strDescri;
      frmFormulacaoAutomotivaDupont.strIdePro := strIdePro;
      frmFormulacaoAutomotivaDupont.blnConsLinhaDesBas := blnConsLinhaDesBas;
      frmFormulacaoAutomotivaDupont.ShowModal;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(frmFormulacaoAutomotivaDupont) then FreeAndNil(frmFormulacaoAutomotivaDupont);
  End;
end;

procedure TfrmDigTintaAutomotivaDupont.edtVolumeExit(Sender: TObject);
begin
  If (rdbPoliester.Checked) And
//     ( (fStrToFloat(edtVolume.Text) > 0.210) Or (fStrToFloat(edtVolume.Text) < 0.190) ) Then
     (fStrToFloat(edtVolume.Text) > 0.150) Then
  Begin
//    fMensagem('', 'O volume Poliester deve estar entre 0,190 e 0,210!', ['&Ok']);
    fMensagem('', 'O volume Poliester deve estar entre 0,150!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbDuco.Checked) And (fFormataFloat(fStrToFloat(edtVolume.Text), 3) > fFormataFloat(0.150, 3)) Then
  Begin
    fMensagem('', 'O volume máximo para Duco é 0,150!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbBalde.Checked) And (fFormataFloat(fStrToFloat(edtVolume.Text), 3) > fFormataFloat(18.000, 3)) Then
  Begin
    fMensagem('', 'O volume máximo para Balde é 18,000!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbTambor.Checked) And (fFormataFloat(fStrToFloat(edtVolume.Text), 3) > fFormataFloat(196.000, 3)) Then
  Begin
    fMensagem('', 'O volume máximo para Tambor é 196,000!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbSprayS.Checked) And (fFormataFloat(fStrToFloat(edtVolume.Text), 3) > fFormataFloat(0.150, 3)) Then
  Begin
    fMensagem('', 'O volume máximo para Spray Sintético é 0,150!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbGalao.Checked) And (fStrToFloat(edtVolume.Text) > fFormataFloat(3.600, 3)) Then
  Begin
    fMensagem('', 'O volume máximo para Galão é 3,600!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbLitro.Checked) And (fStrToFloat(edtVolume.Text) > fFormataFloat(0.900, 3)) Then
  Begin
    fMensagem('', 'O volume máximo para Litro é 0,900!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End;
  inherited;
end;

procedure TfrmDigTintaAutomotivaDupont.pAjustaRadioButtons;
begin
  //
end;

procedure TfrmDigTintaAutomotivaDupont.rdgModoVendaClick(Sender: TObject);
begin
  inherited;
  Self.Height := 460 - IIF(pnlAdicional.Visible, 0, pnlAdicional.Height);
end;

procedure TfrmDigTintaAutomotivaDupont.FormShow(Sender: TObject);
begin
//  inherited;
//  rdgModoVendaClick(rdgModoVenda);

  objFormula.OnEmbalagemMudou := pEmbalagemMudou;

  If fCfgSis('TREMTA', varBoolean) Then
  Begin
    chkConsEmb.Visible := False;
  End
  Else
  Begin
    lblProEmb.Visible := False;
    edtProEmb.Visible := False;
    edtDesProEmb.Visible := False;
  End;

  pMostrarAcertoTinta;

  rdgModoVenda.Enabled := objFormula.blnTemDiluido And objFormula.blnTemConcentrado;

  If (Not rdgModoVenda.Enabled) Then
  Begin
    rdgModoVenda.ItemIndex := IIF(objFormula.blnTemConcentrado, 0, 1);
    //pSetFocus(edtQtdEmb);
  End;

  If fEmptyStr(strProEmbCo) Then
    rdbCopo.Visible := False;

  If fEmptyStr(strProEmbSp) Then
    rdbSpray.Visible := False;

  If fEmptyStr(strProEmbTb) Then
    rdbTambor.Visible := False;

  If fEmptyStr(strProEmbSs) Then
    rdbSprayS.Visible := False;

  If fEmptyStr(strProEmbPo) Then
    rdbPoliester.Visible := False;

  If fEmptyStr(strProEmbDu) Then
    rdbDuco.Visible := False;

  If fEmptyStr(strProEmbBa) Then
    rdbBalde.Visible := False;

  cmbTipoEmbalagem.Items.Assign(stlDesEmb);
  If cmbTipoEmbalagem.Items.Count < 1 Then
  Begin
    Raise Exception.Create('Atenção: a(s) embalagens(s) dessa fórmula não foi setada. Não será possível continuar.');
  End
  Else If cmbTipoEmbalagem.Items.Count = 1 Then
  Begin
    cmbTipoEmbalagem.ItemIndex := 0;
    lblTipo.Visible := False;
    cmbTipoEmbalagem.Visible := False;
    pAjustaRadioButtons;
  End;

  blnHabTipoEmb := cmbTipoEmbalagem.Visible;

  If (objFormula.blnDadosAdicionais) Then
  Begin
    lblAdicional.Caption := objFormula.strCaptionAdicional;
    cmbListaAdicional.Items.Assign(objFormula.stlListaAdicional);
  End;

  cmbTipoEmbalagem.ItemIndex := 0;

  Try

    objFormula.pCalcularPrecos;
    If (intIndEmb >= 0) Then
    Begin
      cmbTipoEmbalagem.ItemIndex := intIndEmb;
      cmbTipoEmbalagem.Enabled   := False;
      // (Duxone e BP) ou Cormax
      If ((intIndEmb = 0) And (strQualid = 'BP')) or (intIndEmb = 4) Then
      Begin
        rdgModoVenda.ItemIndex := 0;
        rdgModoVenda.Enabled   := False;
      End;
    End
    Else
    Begin
      cmbTipoEmbalagem.ItemIndex := 0;
    End;

    edtVolumeExit(edtVolume);
    rdbLitroClick(rdbLitro);
    cmbTipoEmbalagemSelect(cmbTipoEmbalagem);
    pAtualizaPrecos;

    rdgModoVendaClick(rdgModoVenda);
    SelectNext(ActiveControl, True, True);

  Except
    On E: Exception Do
    Begin
      fMensagem('', E.Message, ['&Ok']);
    End;
  End;

end;

end.

