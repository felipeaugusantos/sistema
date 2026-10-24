unit untDigTintaAutomotiva;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, ExtCtrls, Menus, Buttons,
  untFuncEspecificas, ComboBoxFocus, AppEvnts, Math, untTMatrizSaldosColorantes,
  BitBtnLockedIncrem, Uni, frxClass, frxExportCSVTestabilidade;

type
  TfrmDigTintaAutomotiva = class(TfrmPai)
    pnlGeral: TPanel;
    pnlCabecalho: TPanel;
    gpbEmbalagem: TGroupBox;
    Label1: TLabel;
    lblTipo: TLabel;
    edtQtdEmb: TEditFocus;
    rdbLitro: TRadioButton;
    rdbGalao: TRadioButton;
    pnlPreco: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label2: TLabel;
    edtPreco: TEditFocus;
    edtPreEmb: TEditFocus;
    edtPrecoSemEmb: TEditFocus;
    pnlAdicional: TPanel;
    pnlRodape: TPanel;
    Label3: TLabel;
    edtVolume: TEditFocus;
    chkComCat: TCheckBox;
    lblAdicional: TLabel;
    cmbListaAdicional: TComboBoxFocus;
    rdbCopo: TRadioButton;
    rdbSpray: TRadioButton;
    PopupMenu1: TPopupMenu;
    rdgAcerto: TRadioGroup;
    rdbTambor: TRadioButton;
    rdbLata: TRadioButton;
    cmbTipoEmbalagem: TComboBoxFocus;
    rdbBalde: TRadioButton;
    btnConfirma: TBitBtnLocked;
    btnFormulacao: TBitBtnLocked;
    lblQtdMinPermitida: TLabel;
    edtVolMinPermitida: TEditFocus;
    pnlTrocaEmb: TPanel;
    pnlConsEmb: TPanel;
    pnlModoVenda: TPanel;
    rdgModoVenda: TRadioGroup;
    chkConsEmb: TCheckBox;
    lblProEmb: TLabel;
    edtProEmb: TEditFocus;
    edtDesProEmb: TEditFocus;
    pnlObservacao: TPanel;
    lblDesAdc: TLabel;
    rdgTipoFormula: TRadioGroup;
    edtDescricaoColorista: TEditFocus;
    lblObsColorista: TLabel;
    edtDesAdc: TEditFocus;
    procedure FormShow(Sender: TObject);
    procedure rdbLitroClick(Sender: TObject);
    procedure cmbTipoEmbalagemSelect(Sender: TObject);
    procedure btnCalcularClick(Sender: TObject);
    procedure edtQtdEmbExit(Sender: TObject);
    procedure rdgModoVendaClick(Sender: TObject); virtual;
    procedure edtVolumeExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure chkComCatClick(Sender: TObject);
    procedure btnFormulacaoClick(Sender: TObject);
    procedure cmbListaAdicionalChange(Sender: TObject);
    procedure cmbListaAdicionalExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmbTipoEmbalagemExit(Sender: TObject);
    procedure chkConsEmbClick(Sender: TObject);
    procedure rdgAcertoClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtProEmbExit(Sender: TObject);
    procedure edtProEmbKeyPress(Sender: TObject; var Key: Char);
    procedure rdbLitroExit(Sender: TObject);
    procedure edtDesAdcExit(Sender: TObject);
  private
    FblnSaldoSuficiente: Boolean;
    FmatrizSaldosColorantes: TClassMatrizSaldosColorantes;
    procedure SetblnSaldoSuficiente(const Value: Boolean);
    procedure SetmatrizSaldosColorantes(
      const Value: TClassMatrizSaldosColorantes);
    procedure SetVolMinimoPermitido;

    procedure pSetarModoVenda;

    { Private declarations }


  protected
    blnHabTipoEmb: Boolean;
    intAlturaOri: Integer;
    procedure pAtualizaPrecos;
    procedure pDefineEmbalagem; virtual;
    function fPermiteMostrarComboDeEmbalagem: Boolean; virtual;
    procedure pMostrarAcertoTinta;

    procedure pConsultaProEmb(edtItem, edtDesIte: TEdit);
    function fProdutoEmbalagem(strCodIte: String): String;
    procedure pEmbalagemMudou(strCodEmb: String);
    procedure pEmbalagemNaoConfigurada(strCodEmb: String);

    function fAlturaPnlAdicional: Integer; virtual;
    function fAlturaConsEmb: Integer; virtual;
    function fAlturaTrocaEmb: Integer; virtual;
  public
    { Public declarations }
    stlDesEmb    : TStringList;
    stlProEmbLt  : TStringList;
    stlProEmbGl  : TStringList;
    stlProEmbLa  : TStringList;
    strProEmbCo  : String; // Copo
    strProEmbSp  : String; // Spray
    strProEmbTb  : String; // Tambor
    strProEmbLa  : String; // Lata
    strProEmbBa  : String; // Balde
    fltMixVolMiC : Double; // Volume minímo concentrado
    fltMixVolMiD : Double; // Volume minímo Diluído
    objFormula   : TFormulaAutomotiva;

    {*****************************************}
    {* ESTA VARIÁVEL SERÁ UTILIZADA EM CASOS *}
    {* ONDE SERÁ NECESSÁRIO MOSTRAR UMA QTD  *}
    {* DIFERENTE DO QUE ESTÁ NA TABELA.      *}
    {**************************************MV*}
    objFormulaQtdEsp: TFormulaAutomotiva;

    blnMosDil2: Boolean;
    intIndEmb: Integer;
    fltVolumePadraoLitro: Double;

    fltVolumePadraoGalao: Double;
    fltVolumeMaximoGalao: Double;

    fltVolumePadraoSpray: Double;
    fltVolumeMaximoSpray: Double;

    fltVolumePadraoCopo: Double;
    fltVolumeMaximoCopo: Double;

    fltVolumePadraoTambor: Double;
    fltVolumeMaximoTambor: Double;

    fltVolumePadraoLata: Double;
    fltVolumeMaximoLata: Double;

    fltVolumePadraoBalde: Double;
    fltVolumeMaximoBalde: Double;

    strIdePro: String;
    blnConsLinhaDesBas: Boolean;

    procedure pCalculaPrecos;

    property blnSaldoSuficiente: Boolean read FblnSaldoSuficiente write SetblnSaldoSuficiente;
    property matrizSaldosColorantes: TClassMatrizSaldosColorantes read FmatrizSaldosColorantes write SetmatrizSaldosColorantes;
  end;

var
  frmDigTintaAutomotiva: TfrmDigTintaAutomotiva;

implementation

uses  untFormulacaoAutomotiva,
  untFuncoesSimples, untConsultas, untTypesSistema;
{$R *.dfm}

procedure TfrmDigTintaAutomotiva.FormShow(Sender: TObject);
begin
  inherited;
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

  If Assigned(stlProEmbLa) Then
  Begin
    If fEmptyStr(strProEmbLa) And (stlProEmbLa.Count <= 0) Then
      rdbLata.Visible := False;
  End
  Else
  Begin
    If fEmptyStr(strProEmbLa) Then
      rdbLata.Visible := False;
  End;

  If fEmptyStr(strProEmbBa) Then
    rdbBalde.Visible := False;


  pMostrarAcertoTinta;

  cmbTipoEmbalagem.Items.Assign(stlDesEmb);
  If cmbTipoEmbalagem.Items.Count < 1 Then
  Begin
    Raise Exception.Create('Atenção: O tipo da embalagem não está preenchido, favor preencher no cadastro de bases.' + #13#10 +
                           'Não será possível continuar.');
  End
  Else If cmbTipoEmbalagem.Items.Count = 1 Then
  Begin
    cmbTipoEmbalagem.ItemIndex := 0;

    lblTipo.Visible          := False;
    cmbTipoEmbalagem.Visible := False;
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
    End
    Else
    Begin
      cmbTipoEmbalagem.ItemIndex := 0;
    End;

    objFormula.fltVolumePro := fStrToFloat(edtVolume.Text);

    pSetarModoVenda;

    cmbTipoEmbalagemSelect(cmbTipoEmbalagem);

    rdbLitroClick(rdbLitro);

    SetVolMinimoPermitido;

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

  Except
    On E: EAbort Do
    Begin
      Abort;
    End;

    On E: Exception Do
    Begin
      fMensagem('', E.Message, ['&Ok']);
    End;
  End;
end;

procedure TfrmDigTintaAutomotiva.rdbLitroClick(Sender: TObject);
begin
  inherited;
  If (rdbLitro.Checked) Then
  Begin
    objFormula.tpeTipEmb := teLitro;
    edtVolume.Text := FloatToStrF(fltVolumePadraoLitro, ffNumber, 12, 3);
  End
  Else If (rdbGalao.Checked) Then
  Begin
    objFormula.tpeTipEmb := teGalao;
    edtVolume.Text := FloatToStrF(fltVolumePadraoGalao, ffNumber, 12, 3);
  End
  Else If (rdbCopo.Checked) Then
  Begin
    objFormula.tpeTipEmb := teCopo;
    edtVolume.Text := FloatToStrF(fltVolumePadraoCopo, ffNumber, 12, 3);
  End
  Else If (rdbSpray.Checked) Then
  Begin
    objFormula.tpeTipEmb := teSpray;
    edtVolume.Text := FloatToStrF(fltVolumePadraoSpray, ffNumber, 12, 3);
  End
  Else If (rdbTambor.Checked) Then
  Begin
    objFormula.tpeTipEmb := teTambor;
    edtVolume.Text := FloatToStrF(fltVolumePadraoTambor, ffNumber, 12, 3);
  End
  Else If (rdbLata.Checked) Then
  Begin
    objFormula.tpeTipEmb := teLata;
    edtVolume.Text := FloatToStrF(fltVolumePadraoLata, ffNumber, 12, 3);
  End
  Else If (rdbBalde.Checked) Then
  Begin
    objFormula.tpeTipEmb := teBalde;
    edtVolume.Text := FloatToStrF(fltVolumePadraoBalde, ffNumber, 12, 3);
  End;
  objFormula.fltVolumePro := fStrToFloat(edtVolume.Text);

  If fPermiteMostrarComboDeEmbalagem Then
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

procedure TfrmDigTintaAutomotiva.rdbLitroExit(Sender: TObject);
begin
  inherited;
  If cmbTipoEmbalagem.Visible And cmbTipoEmbalagem.Enabled Then
    pSetFocus(cmbTipoEmbalagem)
  else
  if pnlAdicional.Visible And pnlAdicional.Enabled Then
    pSetFocus(pnlAdicional)
  else
  if pnlRodape.Visible and pnlRodape.Enabled Then
  Begin
    If (chkComCat.Enabled) And (chkComCat.Visible) Then
      pSetFocus(chkComCat)
    Else
      pSetFocus(edtVolume);
  End
  else
    if pnlBotoes.Visible and pnlBotoes.Enabled Then
      pSetFocus(btnConfirma);

end;

procedure TfrmDigTintaAutomotiva.cmbTipoEmbalagemSelect(Sender: TObject);
begin
  inherited;
  pDefineEmbalagem;
  //pAtualizaPrecos;
end;

procedure TfrmDigTintaAutomotiva.pCalculaPrecos;
begin
  Try
    objFormula.pCalcularPrecos;
  Except
    on E: EAbort do
    begin
      raise;
    end;

  
    On E: Exception Do
    Begin
      fMensagem('', E.Message, ['&Ok']);
    End;
  End;
  
  edtPreEmb.Text := FloatToStrF(objFormula.fltPrecoEmbalagem * fStrToFloat(edtQtdEmb.Text), ffFixed, 12, 2);
  If (rdgModoVenda.ItemIndex = 0) Then
    edtPrecoSemEmb.Text  := FloatToStrF(objFormula.fltPrecoVenCon, ffFixed, 12, 2)
  Else
    edtPrecoSemEmb.Text  := FloatToStrF(objFormula.fltPrecoVenDil, ffFixed, 12, 2);

  edtPrecoSemEmb.Text := FloatToStrF(fStrToFloat(edtPrecoSemEmb.Text) * fStrToFloat(edtQtdEmb.Text),
    ffFixed, 12, 2);

  edtPreco.Text := FloatToStrF(fStrToFloat(edtPrecoSemEmb.Text) + fStrToFloat(edtPreEmb.Text),
    ffFixed, 12, 2);
end;

procedure TfrmDigTintaAutomotiva.pConsultaProEmb(edtItem, edtDesIte: TEdit);
  Var
    arrSel: TConsultasArray;
    Key: Char;
begin
  Key := '/';
  If fPesqItemEmbalagem(Self, edtItem, edtDesIte, Nil, Key, arrSel) Then
    If fValidaCampos(edtItem, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmDigTintaAutomotiva.pMostrarAcertoTinta;
begin
  if (fCfgSis('FATAC1', varDouble) > 1) or (fCfgSis('FATAC2', varDouble) > 1) then
  begin
    rdgAcerto.Visible := True;
  end
  else
  begin
    rdgAcerto.Visible := False;
  end;
end;

procedure TfrmDigTintaAutomotiva.pSetarModoVenda;
begin

  Case rdgModoVenda.ItemIndex Of
    0: objFormula.mveModoVenda := mvConcentrado;
    Else
      objFormula.mveModoVenda := mvDiluido;
  End;

  If (rdgModoVenda.ItemIndex = 0) And (objFormula.blnAdicionalConcentrado) Then
    pnlAdicional.Visible := True
  Else If (rdgModoVenda.ItemIndex = 1) And (objFormula.blnAdicionalDiluido) Then
    pnlAdicional.Visible := True
  Else
    pnlAdicional.Visible := False;

  Self.Height := intAlturaOri;

  If Not pnlAdicional.Visible Then
    Self.Height := Self.Height - fAlturaPnlAdicional;

  If Not pnlConsEmb.Visible Then
    Self.Height := Self.Height - fAlturaConsEmb;

  If Not pnlTrocaEmb.Visible Then
    Self.Height := Self.Height - fAlturaTrocaEmb;

end;

procedure TfrmDigTintaAutomotiva.pAtualizaPrecos;
begin
  pCalculaPrecos;
end;

procedure TfrmDigTintaAutomotiva.btnCalcularClick(Sender: TObject);
begin
  inherited;
  pCalculaPrecos;
end;

procedure TfrmDigTintaAutomotiva.edtDesAdcExit(Sender: TObject);
begin
  inherited;
  TEditFocus(Sender).Text := fRetirarEspacos(Sender);
end;

procedure TfrmDigTintaAutomotiva.edtProEmbExit(Sender: TObject);
Var
  strMensagem : String;
begin
  inherited;
  If fEmptyStr(edtProEmb.Text) Then
  Begin
    If (Not fCfgSis('AUTEMB', varBoolean)) Then
    Begin
      pMensagemOk('É necessário escolher um produto embalagem.');
      pSetFocus(edtProEmb);
      Exit;
    End;
  End
  Else
  Begin
    strMensagem := fProdutoEmbalagem(edtProEmb.Text);

    If Not fEmptyStr(strMensagem) Then
    Begin
      pMensagemOk(strMensagem);
      pSetFocus(edtProEmb);
      Exit;
    End;
  End;

  objFormula.strCodEmb := edtProEmb.Text;

  If (edtQtdEmb.Enabled) and (edtQtdEmb.Visible) Then
    pSetFocus(edtQtdEmb)
  Else
  If (edtQtdEmb.Enabled) and (edtQtdEmb.Visible) Then

end;

procedure TfrmDigTintaAutomotiva.edtProEmbKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    pConsultaProEmb(TEdit(Sender), edtDesProEmb);
  End;
end;

procedure TfrmDigTintaAutomotiva.edtQtdEmbExit(Sender: TObject);
begin
  inherited;

  If (fEmptyStr(edtQtdEmb.Text)) Then
  Begin
    fMensagem('', 'A quantidade da embalagem deve ser preenchida!', ['&Ok']);
    pSetFocus(edtQtdEmb);
    Exit;
  End
  Else If (fStrToFloat(edtQtdEmb.Text) <= 0) Then
  Begin
    fMensagem('', 'A quantidade da embalagem deve ser maior que Zero!', ['&Ok']);
    pSetFocus(edtQtdEmb);
    Exit;
  End;

  pAtualizaPrecos;
end;

procedure TfrmDigTintaAutomotiva.rdgAcertoClick(Sender: TObject);
begin
  inherited;
  Case rdgAcerto.ItemIndex Of
    0: objFormula.fltFatorAcerto := IIF(objFormula.AcertoValor, 0.0, 1.0);
    1: objFormula.fltFatorAcerto := fCfgSis('FATAC1', varDouble);
    2: objFormula.fltFatorAcerto := fCfgSis('FATAC2', varDouble);
  End;
  pAtualizaPrecos;
end;

procedure TfrmDigTintaAutomotiva.rdgModoVendaClick(Sender: TObject);
begin
  inherited;
  //pAtualizaPrecos;

  Case rdgModoVenda.ItemIndex Of
    0: objFormula.mveModoVenda := mvConcentrado;
    Else
      objFormula.mveModoVenda := mvDiluido;
  End;

  If (rdgModoVenda.ItemIndex = 0) And (objFormula.blnAdicionalConcentrado) Then
    pnlAdicional.Visible := True
  Else If (rdgModoVenda.ItemIndex = 1) And (objFormula.blnAdicionalDiluido) Then
    pnlAdicional.Visible := True
  Else
    pnlAdicional.Visible := False;

{  If (pnlAdicional.Visible) Then
    Self.Height := 430
  Else
    Self.Height := 387;}

  Self.Height := intAlturaOri;

  If Not pnlAdicional.Visible Then
    Self.Height := Self.Height - fAlturaPnlAdicional;

  If Not pnlConsEmb.Visible Then
    Self.Height := Self.Height - fAlturaConsEmb;

  If Not pnlTrocaEmb.Visible Then
    Self.Height := Self.Height - fAlturaTrocaEmb;

  pAtualizaPrecos;
  SetVolMinimoPermitido;

end;

procedure TfrmDigTintaAutomotiva.edtVolumeExit(Sender: TObject);
begin
  inherited;
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
  Else If (rdbGalao.Checked) And (fStrToFloat(edtVolume.Text) > fFormataFloat(fltVolumeMaximoGalao, 3)) Then
  Begin
    fMensagem('', 'O volume máximo para Galão é ' + FloatToStrF(fltVolumeMaximoGalao, ffNumber, 12, 3) + '!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbCopo.Checked) And (fFormataFloat(fStrToFloat(edtVolume.Text), 3) > fltVolumeMaximoCopo) Then
  Begin
    fMensagem('', 'O volume máximo para Copo é ' + FloatToStrF(fltVolumeMaximoCopo, ffNumber, 12, 3) + '!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbSpray.Checked) And (fFormataFloat(fStrToFloat(edtVolume.Text), 3) > fFormataFloat(fltVolumeMaximoSpray, 3)) Then
  Begin
    fMensagem('', 'O volume máximo para Spray é ' + FloatToStrF(fltVolumeMaximoSpray, ffNumber, 12, 3) + '!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbTambor.Checked) And (fFormataFloat(fStrToFloat(edtVolume.Text), 3) > fFormataFloat(fltVolumeMaximoTambor, 3)) Then
  Begin
    fMensagem('', 'O volume máximo para Tambor é ' + FloatToStrF(fltVolumeMaximoTambor, ffNumber, 12, 3) + '!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbLata.Checked) And (fFormataFloat(fStrToFloat(edtVolume.Text), 3) > fFormataFloat(fltVolumeMaximoLata, 3)) Then
  Begin
    fMensagem('', 'O volume máximo para Lata é ' + FloatToStrF(fltVolumeMaximoLata, ffNumber, 12, 3) + '!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbBalde.Checked) And (fFormataFloat(fStrToFloat(edtVolume.Text), 3) > fFormataFloat(fltVolumeMaximoBalde, 3)) Then
  Begin
    fMensagem('', 'O volume máximo para Balde é ' + FloatToStrF(fltVolumeMaximoBalde, ffNumber, 12, 3) + '!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End  ;

  objFormula.fltVolumePro := fStrToFloat(edtVolume.Text);
  pAtualizaPrecos;
end;

function TfrmDigTintaAutomotiva.fAlturaConsEmb: Integer;
begin
  Result := pnlConsEmb.Height;
end;

function TfrmDigTintaAutomotiva.fAlturaPnlAdicional: Integer;
begin
  Result := pnlAdicional.Height;
end;

function TfrmDigTintaAutomotiva.fAlturaTrocaEmb: Integer;
begin
  Result := pnlTrocaEmb.Height;
end;

procedure TfrmDigTintaAutomotiva.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN Then
  Begin
    If (ActiveControl <> Nil) And (ActiveControl.Name = '') Then
      SelectNext(ActiveControl, True, True);
  End
  Else If Key = VK_ESCAPE Then
  Begin
    btnSair.Click;
  End;
end;

procedure TfrmDigTintaAutomotiva.btnConfirmaClick(Sender: TObject);
var
  strMensagem: String;
begin
  inherited;

  If (fStrToFloat(edtPrecoSemEmb.Text) <= 0.0) Then
    Exit;

  If (objFormula.blnConsiderarEmbalagem) And (fEmptyStr(objFormula.strCodEmb)) Then
  Begin
    fMensagem('ATENÇÃO!', 'A embalagem não está configurada corretamente. Favor verificar.', ['&Ok']);
    Exit;
  End;

  If (objFormula.blnConsiderarEmbalagem) And (fEmptyStr(fRetNomProduto(objFormula.strCodEmb))) Then
  Begin
    fMensagem('ATENÇÃO!', 'O produto embalagem configurado não está cadastrado no sistema.', ['&Ok']);
    Exit;
  End;

  If (objFormula.blnConsiderarEmbalagem) And (Not (fEmptyStr(objFormula.strCodEmb))) Then
  Begin
    strMensagem := fProdutoEmbalagem(objFormula.strCodEmb);

    If Not fEmptyStr(strMensagem) Then
    Begin
      fMensagem('ATENÇÃO!', strMensagem, ['&Ok']);
      Exit;
    End;
  End;
  
  if (lblQtdMinPermitida.Visible) and (fStrToFloat(edtVolMinPermitida.text) > 0.0)then
  begin
    if ( fStrToFloat(edtVolume.Text) < fStrToFloat(edtVolMinPermitida.text)) then
    begin
      fMensagem('ATENÇÃO!', 'O volume vendido deverá ser maior que o volume minímo permitido, '+#13#10+'pois um ou mais componentes da formulação ficarão zerados.', ['&Ok']);
      Exit;
    end;
  end;

  objFormula.intQtdEmb   := StrToInt(edtQtdEmb.Text);
  matrizSaldosColorantes := objFormula.fRetMatrizSaldosColorantes;
  blnSaldoSuficiente     := objFormula.fVerificaSaldosML(matrizSaldosColorantes);

  ModalResult := mrOk;
end;

procedure TfrmDigTintaAutomotiva.chkComCatClick(Sender: TObject);
begin
  inherited;
  objFormula.blnComCatalisador := chkComCat.Checked;
  pAtualizaPrecos;
end;

procedure TfrmDigTintaAutomotiva.chkConsEmbClick(Sender: TObject);
begin
  inherited;
  objFormula.blnConsiderarEmbalagem := chkConsEmb.Checked;

  If Not objFormula.blnConsiderarEmbalagem Then
    objFormula.strCodEmb := '';

  If objFormula.blnConsiderarEmbalagem Then
    pDefineEmbalagem;

  pAtualizaPrecos;
end;

procedure TfrmDigTintaAutomotiva.btnFormulacaoClick(Sender: TObject);
begin
  inherited;
  pCriarFormularios(TfrmFormulacaoAutomotiva, frmFormulacaoAutomotiva);
  frmFormulacaoAutomotiva.objFormula := objFormula;
  frmFormulacaoAutomotiva.objFormulaQtdEsp := objFormulaQtdEsp;

  If (Not blnMosDil2) Then
  Begin
    frmFormulacaoAutomotiva.lsvFormulacao.Columns[4].Width := 0;
    frmFormulacaoAutomotiva.Width := frmFormulacaoAutomotiva.Width - 100;
  End;

  frmFormulacaoAutomotiva.Caption := frmFormulacaoAutomotiva.Caption + objFormula.strDescri;

  frmFormulacaoAutomotiva.strIdePro := strIdePro;
  frmFormulacaoAutomotiva.blnConsLinhaDesBas := blnConsLinhaDesBas;


  frmFormulacaoAutomotiva.ShowModal;
  FreeAndNil(frmFormulacaoAutomotiva);
end;

procedure TfrmDigTintaAutomotiva.cmbListaAdicionalChange(Sender: TObject);
begin
  inherited;
  objFormula.intIndiceAdicional := cmbListaAdicional.ItemIndex;
  pAtualizaPrecos;
end;

procedure TfrmDigTintaAutomotiva.cmbListaAdicionalExit(Sender: TObject);
begin
  inherited;
  If (cmbListaAdicional.ItemIndex < 0) Then
  Begin
    fMensagem('', 'O campo ' + lblAdicional.Caption + ' deve ser preenchido.', ['&Ok']);
    pSetFocus(cmbListaAdicional);
  End;
end;

procedure TfrmDigTintaAutomotiva.FormActivate(Sender: TObject);
begin
  inherited;
  If rdgModoVenda.Enabled And rdgModoVenda.Visible Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmDigTintaAutomotiva.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  objFormula.OnEmbalagemMudou := Nil;
  inherited;
end;

procedure TfrmDigTintaAutomotiva.FormCreate(Sender: TObject);
begin
  inherited;
  intAlturaOri := Self.Height;

  chkConsEmb.Visible := fCfgSis('AUTEMB', varBoolean);
  pnlConsEmb.Visible := chkConsEmb.Visible;

  blnMosDil2 := False;
  intIndEmb := -1;
  edtQtdEmb.Text := '1';

  strProEmbCo := '';
  strProEmbSp := '';
  strProEmbTb := '';
  strProEmbLa := '';

  fltVolumePadraoLitro  := 0.900;

  fltVolumePadraoGalao  := 3.600;
  fltVolumeMaximoGalao  := 4.000;

  fltVolumePadraoSpray  := 0.400;
  fltVolumeMaximoSpray  := 0.400;

  fltVolumePadraoCopo   := 0.500;
  fltVolumeMaximoCopo   := 0.500;

  fltVolumePadraoTambor := 200.000;
  fltVolumeMaximoTambor := 200.000;

  fltVolumePadraoLata   := 18.000;
  fltVolumeMaximoLata   := 18.000;

  fltVolumePadraoBalde   := 18.000;
  fltVolumeMaximoBalde   := 18.000;

  strIdePro := '';
  blnConsLinhaDesBas := False;

  If (fCfgSis('DIRFOR', varBoolean))  Then
    btnFormulacao.Visible :=  fVerificaAcessoSistema('DIRVISFOR');

  pSetaCodIte(edtProEmb);
end;

procedure TfrmDigTintaAutomotiva.cmbTipoEmbalagemExit(Sender: TObject);
begin
  inherited;
  If (cmbTipoEmbalagem.ItemIndex < 0) Then
  Begin
    fMensagem('', 'O tipo de embalagem deve ser preenchido.', ['&Ok']);
    pSetFocus(cmbListaAdicional);
  End
  else
  begin
    If ((rdgAcerto.Enabled) And (rdgAcerto.Visible))Then
      pSetFocus(rdgAcerto)
    Else
    If ((cmbListaAdicional.Enabled) And (pnlAdicional.Visible)) Then
      pSetFocus(cmbListaAdicional)
    Else
    If ((chkComCat.Enabled) And (chkComCat.Visible)) Then
      pSetFocus(chkComCat)
    else
    If ((edtVolume.Enabled) and(edtVolume.Visible)) Then
      pSetFocus(edtVolume)
    Else
      pSetFocus(btnConfirma);
  end;
end;

procedure TfrmDigTintaAutomotiva.pDefineEmbalagem;
begin
  Try
    Try
      If objFormula.blnConsiderarEmbalagem Then
      Begin
        If (rdbLitro.Checked) Then
        Begin
          objFormula.strCodEmb := stlProEmbLt[cmbTipoEmbalagem.ItemIndex];
          pEmbalagemNaoConfigurada(objFormula.strCodEmb);
        End
        Else If (rdbGalao.Checked) Then
        Begin
          objFormula.strCodEmb := stlProEmbGl[cmbTipoEmbalagem.ItemIndex];
          pEmbalagemNaoConfigurada(objFormula.strCodEmb);
        End
        Else If (rdbCopo.Checked) Then
        Begin
          objFormula.strCodEmb := strProEmbCo;
          pEmbalagemNaoConfigurada(objFormula.strCodEmb);
        End
        Else If (rdbSpray.Checked) Then
        Begin
          objFormula.strCodEmb := strProEmbSp;
          pEmbalagemNaoConfigurada(objFormula.strCodEmb);
        End
        Else If (rdbTambor.Checked) Then
        Begin
          objFormula.strCodEmb := strProEmbTb;
          pEmbalagemNaoConfigurada(objFormula.strCodEmb);
        End
        Else If (rdbLata.Checked) Then
        Begin
          if strProEmbLa = '' then
            objFormula.strCodEmb := stlProEmbLa[cmbTipoEmbalagem.ItemIndex] //strProEmbLa;
          else
            objFormula.strCodEmb := strProEmbLa;
          pEmbalagemNaoConfigurada(objFormula.strCodEmb);
        End
        Else If (rdbBalde.Checked) Then
        Begin
          objFormula.strCodEmb := strProEmbBa;
          pEmbalagemNaoConfigurada(objFormula.strCodEmb);
        End;
      End;
    Except
      on E: Exception do
      begin
        objFormula.strCodEmb := '';
        edtPreEmb.Text := '0,00';
        fMensagem('ATENÇÃO', 'A embalagem não está configurada corretamente. Favor verificar.', ['OK']);
        Abort;
      end;
    End;
  Finally
  End;

end;

procedure TfrmDigTintaAutomotiva.pEmbalagemMudou(strCodEmb: String);
begin
  edtProEmb.Text := strCodEmb;
  If fEmptyStr(strCodEmb) Then
    edtDesProEmb.Clear
  Else
    edtDesProEmb.Text := fRetNomProduto(strCodEmb);

  If fCfgSis('TREMTA', varBoolean) Then
    objFormula.blnConsiderarEmbalagem := (Not fEmptyStr(edtProEmb.Text));

//  pAtualizaPrecos;
end;

procedure TfrmDigTintaAutomotiva.pEmbalagemNaoConfigurada(strCodEmb: String);
begin
  If fCfgSis('TREMTA', varBoolean) And (fEmptyStr(strCodEmb)) Then
    fMensagem('ATENÇÃO!', 'A embalagem selecionada não está configurada no auttin. Favor configurar.', ['&Ok']);
end;

procedure TfrmDigTintaAutomotiva.SetblnSaldoSuficiente(
  const Value: Boolean);
begin
  FblnSaldoSuficiente := Value;
end;

procedure TfrmDigTintaAutomotiva.SetmatrizSaldosColorantes(
  const Value: TClassMatrizSaldosColorantes);
begin
  FmatrizSaldosColorantes := Value;
end;

procedure TfrmDigTintaAutomotiva.SetVolMinimoPermitido;
begin
  if rdgModoVenda.ItemIndex =  0 then // Concentrado
  begin
    if (fltMixVolMiC > 0) then
    begin
      lblQtdMinPermitida.Visible := True;
      edtVolMinPermitida.Visible := True;
      edtVolMinPermitida.Text := FloatToStrF(fltMixVolMiC, ffNumber, 12, 3)
    end
    else
    begin
      lblQtdMinPermitida.Visible := false;
      edtVolMinPermitida.Visible := false;
    end
  end
  else // Diluída
  begin
    if (fltMixVolMiD > 0) then
    begin
      lblQtdMinPermitida.Visible := True;
      edtVolMinPermitida.Visible := True;
      edtVolMinPermitida.Text := FloatToStrF(fltMixVolMiD, ffNumber, 12, 3);
    end
    else
    begin
      lblQtdMinPermitida.Visible := false;
      edtVolMinPermitida.Visible := false;
    end
  end;
end;

function TfrmDigTintaAutomotiva.fPermiteMostrarComboDeEmbalagem: Boolean;
begin
  Result := (rdbLitro.Checked) Or (rdbGalao.Checked) Or (rdbLata.Checked);
end;

function TfrmDigTintaAutomotiva.fProdutoEmbalagem(strCodIte: String): String;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  qryAux.SQL.Text := 'SELECT I.ITE_PROEMB '+
                     '     , I.ITE_ITEATI '+
                     '     , G.ITE_IMPLIS '+
                     '  FROM CADITE I    '+
                     ' INNER JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE '+
                     '                    AND G.ITE_CODEMP = :CODEMP '+
                     ' WHERE I.ITE_CODITE = :CODITE';
  qryAux.ParamByName('CODITE').AsString := strCodIte;
  qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryAux.Open;

  If qryAux.FieldByName('ITE_PROEMB').AsString <> 'S' Then
    Result := 'Este produto não é uma embalagem!'
  else
  If QryAux.FieldByName('ITE_ITEATI').AsString <> 'S' Then
    Result := 'Este produto não está ativo!'
  else
  If QryAux.FieldByName('ITE_IMPLIS').AsString <> 'S' Then
    Result := 'O campo imprime lista deve estar como "S"!.'
  else
    Result := '';

  FreeAndNil(qryAux);
end;

end.

