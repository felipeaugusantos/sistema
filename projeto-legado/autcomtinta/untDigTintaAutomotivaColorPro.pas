unit untDigTintaAutomotivaColorPro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untDigTintaAutomotiva, AppEvnts, Menus, StdCtrls, ComboBoxFocus,
  EditFocus, ExtCtrls, Buttons, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmDigTintaAutomotivaColorPro = class(TfrmDigTintaAutomotiva)
    rdbSprayS: TRadioButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rdbLitroClick(Sender: TObject);
    procedure edtVolumeExit(Sender: TObject);
    procedure btnFormulacaoClick(Sender: TObject);
    procedure cmbListaAdicionalChange(Sender: TObject);
    procedure rdgModoVendaClick(Sender: TObject);Reintroduce;
  private
    FstrProEmbSs: String;
    procedure SetstrProEmbSs(const Value: String);
    { Private declarations }
  protected
    procedure pDefineEmbalagem; override;
    procedure pAjustaRadioButtons; virtual;
  public
    property strProEmbSs: String read FstrProEmbSs write SetstrProEmbSs;
    { Public declarations }
  end;

var
  frmDigTintaAutomotivaColorPro: TfrmDigTintaAutomotivaColorPro;

implementation

uses untFuncoesSimples, untFuncEspecificas, untFormulacaoAutomotivaWanPro;

{$R *.dfm}

{ TfrmDigTintaAutomotivaColorPro }



procedure TfrmDigTintaAutomotivaColorPro.SetstrProEmbSs(
  const Value: String);
begin
  FstrProEmbSs := Value;
end;

procedure TfrmDigTintaAutomotivaColorPro.FormShow(Sender: TObject);
begin
  objFormula.OnEmbalagemMudou := pEmbalagemMudou;

  If fCfgSis('TREMTA', varBoolean) Then
  Begin
    chkConsEmb.Visible := False;
    pnlConsEmb.Visible := False;
  End
  Else
  Begin
    lblProEmb.Visible := False;
    edtProEmb.Visible := False;
    edtDesProEmb.Visible := False;
    pnlTrocaEmb.Visible := False;
  End;

  pMostrarAcertoTinta;

  rdgModoVenda.Enabled := objFormula.blnTemDiluido And objFormula.blnTemConcentrado;

  If (Not rdgModoVenda.Enabled) Then
  Begin
    rdgModoVenda.ItemIndex := IIF(objFormula.blnTemConcentrado, 0, 1);
    //pSetFocus(edtQtdEmb);
  End;

  if objFormula.blnTemDiluido Then
    rdgModoVenda.ItemIndex := 1;

  If fEmptyStr(strProEmbCo) Then
    rdbCopo.Visible := False;

  If fEmptyStr(strProEmbSp) Then
    rdbSpray.Visible := False;

  If fEmptyStr(strProEmbTb) Then
    rdbTambor.Visible := False;

  If stlProEmbLa.Count = 0 Then
    rdbLata.Visible := False;

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
    cmbListaAdicional.ItemIndex := 0;
  End;

  cmbTipoEmbalagem.ItemIndex := 0;

  Try

    objFormula.pCalcularPrecos;
    If (intIndEmb >= 0) Then
    Begin
      cmbTipoEmbalagem.ItemIndex := intIndEmb;
      cmbTipoEmbalagem.Enabled   := False;
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
    //SelectNext(ActiveControl, True, True);

    If (rdgModoVenda.Visible) And (rdgModoVenda.Enabled) Then
      pSetFocus(rdgModoVenda)
    Else
    If (chkConsEmb.Visible) And (chkConsEmb.Enabled) Then
      pSetFocus(chkConsEmb)
    else
    If (edtProEmb.Visible) And (edtProEmb.Enabled) Then
       pSetFocus(edtProEmb)
    Else
    If (edtQtdEmb.Visible) And (edtQtdEmb.Enabled) Then
      pSetFocus(edtQtdEmb)
    Else
    If (cmbListaAdicional.Visible) And (cmbListaAdicional.Enabled) Then
      pSetFocus(cmbListaAdicional)
    Else
      pSetFocus(edtVolume);

  Except
    On E: Exception Do
    Begin
      fMensagem('', E.Message, ['&Ok']);
    End;
  End;
end;

procedure TfrmDigTintaAutomotivaColorPro.FormCreate(Sender: TObject);
begin
  inherited;
  strProEmbSs := '';
end;

procedure TfrmDigTintaAutomotivaColorPro.pDefineEmbalagem;
begin
  inherited;
  If objFormula.blnConsiderarEmbalagem Then
  Begin
    If (rdbSprayS.Checked) Then
    Begin
      objFormula.strCodEmb := strProEmbSs;
      pEmbalagemNaoConfigurada(objFormula.strCodEmb);
    End;
  End;
end;

procedure TfrmDigTintaAutomotivaColorPro.rdbLitroClick(Sender: TObject);
begin
  If (rdbLitro.Checked) Then
  Begin
    objFormula.tpeTipEmb := teLitro;
    edtVolume.Text := Iif(rdgModoVenda.ItemIndex = 0, '0,900', FormatFloat('#,###0.000', objFormula.fltVolumeOri));
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
    edtVolume.Text := '0,400';
  End
  Else If (rdbSprayS.Checked) Then
  Begin
    objFormula.tpeTipEmb := teSpray;
    edtVolume.Text := '0,100';
  End
  Else If (rdbLata.Checked) Then
  Begin
    objFormula.tpeTipEmb := teLata;
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

procedure TfrmDigTintaAutomotivaColorPro.rdgModoVendaClick(Sender: TObject);
var
  objBase: TBaseAutomotiva;
begin
  inherited;
  If strIdePro = 'WCP' Then
  Begin
    objBase := TBaseAutomotiva(objFormula.Items[0]);

    If (Pos(fStrZero(objBase.strLinBas,3), '008_058_059_013_') > 0) And (rdgModoVenda.ItemIndex = 1) Then
    Begin
      edtVolume.Text := FormatFloat('#,###0.000', objFormula.fltVolumeOri);
      objFormula.fltVolumePro := fStrToFloat(edtVolume.Text);
    End;

    objFormula.intIndiceAdicional := cmbListaAdicional.ItemIndex;
    pAtualizaPrecos;
  end;
end;

procedure TfrmDigTintaAutomotivaColorPro.btnFormulacaoClick(Sender: TObject);
begin
  frmFormulacaoAutomotivaWanPro := nil;
  Try
    Try
      frmFormulacaoAutomotivaWanPro := TfrmFormulacaoAutomotivaWanPro.Create(Self);
      frmFormulacaoAutomotivaWanPro.objFormula := objFormula;
      frmFormulacaoAutomotivaWanPro.objFormulaQtdEsp := objFormulaQtdEsp;

      If (Not blnMosDil2) Then
      Begin
        frmFormulacaoAutomotivaWanPro.lsvFormulacao.Columns[4].Width := 0;
        frmFormulacaoAutomotivaWanPro.Width := frmFormulacaoAutomotivaWanPro.Width - 100;
      End;

      frmFormulacaoAutomotivaWanPro.Caption := frmFormulacaoAutomotivaWanPro.Caption + objFormula.strDescri;
      frmFormulacaoAutomotivaWanPro.strIdePro := strIdePro;
      frmFormulacaoAutomotivaWanPro.blnConsLinhaDesBas := blnConsLinhaDesBas;
      frmFormulacaoAutomotivaWanPro.ShowModal;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(frmFormulacaoAutomotivaWanPro) then FreeAndNil(frmFormulacaoAutomotivaWanPro);
  End;
end;

procedure TfrmDigTintaAutomotivaColorPro.cmbListaAdicionalChange(
  Sender: TObject);
begin
  inherited;
  If strIdePro = 'WCP' Then
  Begin
    edtVolume.Text := FormatFloat('#,###0.000', objFormula.fltVolumeOri);
    objFormula.fltVolumePro := fStrToFloat(edtVolume.Text);
    pAtualizaPrecos;
  end;
end;

procedure TfrmDigTintaAutomotivaColorPro.edtVolumeExit(Sender: TObject);
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
  Else If (rdbCopo.Checked) And (fFormataFloat(fStrToFloat(edtVolume.Text), 3) > 0.5) Then
  Begin
    fMensagem('', 'O volume máximo para Copo é 0,500!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbSpray.Checked) And (fFormataFloat(fStrToFloat(edtVolume.Text), 3) > fFormataFloat(0.4, 3)) Then
  Begin
    fMensagem('', 'O volume máximo para Spray é 0,400!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbSprayS.Checked) And (fFormataFloat(fStrToFloat(edtVolume.Text), 3) > fFormataFloat(0.4, 3)) Then
  Begin
    fMensagem('', 'O volume máximo para Spray Sintético é 0,400!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbLata.Checked) And (fStrToFloat(edtVolume.Text) > 18) Then
  Begin
    fMensagem('', 'O volume máximo para Lata é 18,000!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End;

  objFormula.fltVolumePro := fStrToFloat(edtVolume.Text);
  pAtualizaPrecos;
end;

procedure TfrmDigTintaAutomotivaColorPro.pAjustaRadioButtons;
begin
  rdbLitro.Top := rdbLitro.Top + cmbTipoEmbalagem.Height Div 2;
  rdbGalao.Top := rdbGalao.Top + cmbTipoEmbalagem.Height Div 2;
  rdbCopo.Top  := rdbCopo.Top  + cmbTipoEmbalagem.Height Div 2;
  rdbSpray.Top := rdbSpray.Top + cmbTipoEmbalagem.Height;
  rdbSprayS.Top := rdbSprayS.Top + cmbTipoEmbalagem.Height;
  rdbTambor.Top := rdbTambor.Top + cmbTipoEmbalagem.Height;
  rdbLata.Top := rdbLata.Top + cmbTipoEmbalagem.Height;
end;

end.

