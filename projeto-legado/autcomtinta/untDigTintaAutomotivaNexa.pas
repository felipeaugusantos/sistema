unit untDigTintaAutomotivaNexa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untDigTintaAutomotiva, AppEvnts, Menus, StdCtrls, ComboBoxFocus,
  EditFocus, ExtCtrls, Buttons,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmDigTintaAutomotivaNexa = class(TfrmDigTintaAutomotiva)
    lblAdicional2: TLabel;
    cmbListaAdicional2: TComboBoxFocus;
    lblAdicional3: TLabel;
    cmbListaAdicional3: TComboBoxFocus;
    lblAdicional4: TLabel;
    cmbListaAdicional4: TComboBoxFocus;
    rdbCopoNexa: TRadioButton;
    procedure FormShow(Sender: TObject);
    procedure cmbListaAdicionalChange(Sender: TObject);
    procedure rdgModoVendaClick(Sender: TObject); override;
    procedure edtVolumeExit(Sender: TObject);
    procedure edtQtdEmbExit(Sender: TObject);
    procedure rdbLitroClick(Sender: TObject);
    procedure btnFormulacaoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rdbCopoNexaClick(Sender: TObject);
  private
    FstlDiluentes: TStringList;
    FstlCatalisadores: TStringList;
    FstlTexturBase: TStringList;
    FstrTexturBase: String;

    procedure SetstlDiluentes(const Value: TStringList);
    procedure SetstlCatalisadores(const Value: TStringList);
    procedure SetstlTexturBase(const Value: TStringList);
    procedure SetstrTexturBase(const Value: String);
    procedure pRecalculaFormula();

    { Private declarations }
  protected
    procedure pDefineEmbalagem; override;
    function fPermiteMostrarComboDeEmbalagem: Boolean; override;
  public
    stlOpcoesDiluicao: TStringList;

    stlProEmbBd: TStringList;
    stlProEmbTb: TStringList;

    property stlDiluentes: TStringList read FstlDiluentes write SetstlDiluentes;
    property stlCatalisadores: TStringList read FstlCatalisadores write SetstlCatalisadores;
    property stlTexturBase: TStringList read FstlTexturBase write SetstlTexturBase;
    property strTexturBase: String read FstrTexturBase write SetstrTexturBase;
    { Public declarations }
  end;

var
  frmDigTintaAutomotivaNexa: TfrmDigTintaAutomotivaNexa;

implementation

uses untFuncEspecificas, untFuncoesSimples, Math,
  untFormulacaoAutomotiva,untIConfTinta, untTintaMaquina,untNexaDinamica;

{$R *.dfm}

procedure TfrmDigTintaAutomotivaNexa.FormCreate(Sender: TObject);
begin
  inherited;
  fltVolumePadraoLitro := 1;

  fltVolumePadraoGalao := 3.500;
  fltVolumeMaximoGalao := 4.000;

  fltVolumePadraoSpray := 200;
  fltVolumeMaximoSpray := 200;

  fltVolumePadraoCopo  := 18;
  fltVolumeMaximoCopo  := 18;
end;

procedure TfrmDigTintaAutomotivaNexa.FormShow(Sender: TObject);
  Var
    objFormulaNexa: TFormulaNexaDinamica;
    arrTops: Array[1..4] Of Integer;
begin
  pMostrarAcertoTinta;
  
  arrTops[1] := rdbLitro.Top;
  arrTops[2] := rdbGalao.Top;
  arrTops[3] := rdbCopo.Top;
  arrTops[4] := rdbSpray.Top;

  inherited;
  objFormulaNexa := TFormulaNexaDinamica(objFormula);

  rdbLitro.Top := arrTops[1];
  rdbGalao.Top := arrTops[2];
  rdbCopo.Top  := arrTops[3];
  rdbSpray.Top := arrTops[4];

  cmbTipoEmbalagem.Visible  := True;
  lblTipo.Visible := True;
  cmbListaAdicional.ItemIndex := objFormulaNexa.intIndiceAdicional;

  lblAdicional4.Visible := Not fEmptyStr(objFormulaNexa.strCaptionAdicional4);
  If lblAdicional4.Visible Then
  Begin
    lblAdicional4.Caption := objFormulaNexa.strCaptionAdicional4;
    cmbListaAdicional4.Items := objFormulaNexa.stlListaAdicional4;
  End;

  lblAdicional3.Visible := Not fEmptyStr(objFormulaNexa.strCaptionAdicional3);
  If lblAdicional3.Visible Then
  Begin
    lblAdicional3.Caption := objFormulaNexa.strCaptionAdicional3;
    cmbListaAdicional3.Items := objFormulaNexa.stlListaAdicional3;
  End;

  lblAdicional2.Visible := Not fEmptyStr(objFormulaNexa.strCaptionAdicional2);
  If lblAdicional2.Visible Then
  Begin
    lblAdicional2.Caption := objFormulaNexa.strCaptionAdicional2;
    cmbListaAdicional2.Items := objFormulaNexa.stlListaAdicional2;
  End;

  If (rdgModoVenda.ItemIndex = 0) Then
  Begin
    pnlAdicional.Visible := False;
    Self.Height := 390;
  End
  Else If (rdgModoVenda.ItemIndex = 1) Then
  Begin
    pnlAdicional.Visible := True;
    Self.Height := 485;
  End;

  cmbListaAdicional2.ItemIndex := 0;
  cmbListaAdicional3.ItemIndex := 0;
  cmbListaAdicional4.ItemIndex := 0;

end;

function TfrmDigTintaAutomotivaNexa.fPermiteMostrarComboDeEmbalagem: Boolean;
begin
  Result := True;
end;

procedure TfrmDigTintaAutomotivaNexa.cmbListaAdicionalChange(
  Sender: TObject);
begin
  stlDiluentes := fRetDiluentes(cmbTipoEmbalagem.Text, cmbListaAdicional.ItemIndex, cmbListaAdicional3.Text);
  stlCatalisadores := fRetCatalisadores(cmbTipoEmbalagem.Text, cmbListaAdicional.ItemIndex);
  strTexturBase := fRetStrTexturBaseMat(cmbTipoEmbalagem.Text, cmbListaAdicional.ItemIndex);
  stlTexturBase := fRetTexturBaseMat(cmbTipoEmbalagem.Text, cmbListaAdicional.ItemIndex);
  pRecalculaFormula;
  inherited;
end;

procedure TfrmDigTintaAutomotivaNexa.SetstlDiluentes(
  const Value: TStringList);
  Var
    strAux: string;
    intAux: Integer;
begin
  If Assigned(FstlDiluentes) Then
    FreeAndNil(FstlDiluentes);

  FstlDiluentes := Value;

  strAux := cmbListaAdicional4.Items.Text;
  intAux := cmbListaAdicional4.ItemIndex;

  cmbListaAdicional4.Items.Text := FstlDiluentes.Text;

  If cmbListaAdicional4.Items.Text = strAux Then
    cmbListaAdicional4.ItemIndex := intAux
  Else
    cmbListaAdicional4.ItemIndex := 0;

  cmbListaAdicional4.Enabled := (cmbListaAdicional4.Items.Count > 0);
end;

procedure TfrmDigTintaAutomotivaNexa.SetstlCatalisadores(
  const Value: TStringList);
  Var
    strAux: string;
    intAux: Integer;
begin
  If Assigned(FstlCatalisadores) Then
    FreeAndNil(FstlCatalisadores);

  FstlCatalisadores := Value;

  strAux := cmbListaAdicional3.Items.Text;
  intAux := cmbListaAdicional3.ItemIndex;

  cmbListaAdicional3.Items.Text := FstlCatalisadores.Text;

  If cmbListaAdicional3.Items.Text = strAux Then
    cmbListaAdicional3.ItemIndex := intAux
  Else
    cmbListaAdicional3.ItemIndex := 0;

  cmbListaAdicional3.Enabled := (cmbListaAdicional3.Items.Count > 0);
end;

procedure TfrmDigTintaAutomotivaNexa.SetstlTexturBase(
  const Value: TStringList);
  Var
    strAux: string;
    intAux: Integer;
begin
  If Assigned(FstlTexturBase) Then
    FreeAndNil(FstlTexturBase);

  FstlTexturBase := Value;

  strAux := cmbListaAdicional2.Items.Text;
  intAux := cmbListaAdicional2.ItemIndex;

  cmbListaAdicional2.Items.Text := FstlTexturBase.Text;

  If cmbListaAdicional2.Items.Text = strAux Then
    cmbListaAdicional2.ItemIndex := intAux
  Else
    cmbListaAdicional2.ItemIndex := 0;

  cmbListaAdicional2.Enabled := (cmbListaAdicional2.Items.Count > 0);
end;

procedure TfrmDigTintaAutomotivaNexa.SetstrTexturBase(const Value: String);
begin
  FstrTexturBase := Value;
  lblAdicional2.Caption := Value;
end;

procedure TfrmDigTintaAutomotivaNexa.rdgModoVendaClick(Sender: TObject);
begin

  Case rdgModoVenda.ItemIndex Of
    0: objFormula.mveModoVenda := mvConcentrado;
    Else
      objFormula.mveModoVenda := mvDiluido;
  End;

  If (rdgModoVenda.ItemIndex = 0) Then
  Begin
    pnlAdicional.Visible := False;
    Self.Height := 390;
  End
  Else If (rdgModoVenda.ItemIndex = 1) Then
  Begin
    pnlAdicional.Visible := True;
    Self.Height := 485;
  End;
  
  pRecalculaFormula;
  pAtualizaPrecos;
end;

procedure TfrmDigTintaAutomotivaNexa.edtVolumeExit(Sender: TObject);
begin
  If (rdbCopoNexa.Checked) And (fStrToFloat(edtVolume.Text) > 0.500) Then
  Begin
    fMensagem('', 'O volume máximo para Copo é ' + FloatToStrF(0.500, ffNumber, 12, 3) + '!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End;

  inherited;
  cmbListaAdicionalChange(Self);
end;

procedure TfrmDigTintaAutomotivaNexa.pDefineEmbalagem;
Var
  conf: IConfTinta;
begin
  inherited;
  conf := fGetConfTinta('NEX');
  //BALDE NA Nexa
  If (rdbCopo.Checked) Then
  Begin
    If (stlProEmbBd.Count <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'As embalagens para Balde não estão configuradas. ' +
                            'Favor configurar.', ['&Ok']);
      rdbLitro.Checked := True;
    End
    Else
      objFormula.strCodEmb := stlProEmbBd[cmbTipoEmbalagem.ItemIndex];
  End
  Else If (rdbSpray.Checked) Then
  Begin
    If (stlProEmbTb.Count <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'As embalagens para Tambor não estão configuradas. ' +
                            'Favor configurar.', ['&Ok']);
      rdbLitro.Checked := True;
    End
    Else
      objFormula.strCodEmb := stlProEmbTb[cmbTipoEmbalagem.ItemIndex];
  End
  Else If (rdbCopoNexa.Checked) Then
  Begin
    objFormula.strCodEmb := conf.fGet('NEXACOP'); 
    If (fEmptyStr(objFormula.strCodEmb)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A embalagem para Copo não estão configuradas. ' +
                            'Favor configurar.', ['&Ok']);
      rdbLitro.Checked := True;
    End;
  End;
end;

procedure TfrmDigTintaAutomotivaNexa.pRecalculaFormula;
begin
  TFormulaNexaDinamica(objFormula).pReformula(cmbTipoEmbalagem.Text,
                                            cmbListaAdicional2.Text,
                                            cmbListaAdicional3.Text,
                                            cmbListaAdicional4.Text,
                                            cmbListaAdicional.ItemIndex);
  objFormula.pCalcularPrecos;
end;

procedure TfrmDigTintaAutomotivaNexa.edtQtdEmbExit(Sender: TObject);
begin
  inherited;
  pRecalculaFormula;
end;

procedure TfrmDigTintaAutomotivaNexa.rdbCopoNexaClick(Sender: TObject);
begin
  inherited;
  edtVolume.Text := '0,500';
  rdbLitroClick(Sender);
  pRecalculaFormula;
end;

procedure TfrmDigTintaAutomotivaNexa.rdbLitroClick(Sender: TObject);
begin
  inherited;
  pRecalculaFormula;
end;

procedure TfrmDigTintaAutomotivaNexa.btnFormulacaoClick(Sender: TObject);
  Var
    frmFormulacao: TfrmFormulacaoAutomotivaNexa;
begin
  Application.CreateForm(TfrmFormulacaoAutomotivaNexa, frmFormulacao);
  frmFormulacao.objFormula := objFormula;

  If (Not blnMosDil2) Then
  Begin
    frmFormulacao.lsvFormulacao.Columns[4].Width := 0;
    frmFormulacao.Width := frmFormulacao.Width - 100;
  End;

  frmFormulacao.Caption := frmFormulacao.Caption + objFormula.strDescri;
  frmFormulacao.ShowModal;
  FreeAndNil(frmFormulacao);
end;

end.
