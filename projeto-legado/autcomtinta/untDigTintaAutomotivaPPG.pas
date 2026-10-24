unit untDigTintaAutomotivaPPG;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untDigTintaAutomotiva, AppEvnts, Menus, StdCtrls, ComboBoxFocus,
  EditFocus, ExtCtrls, Buttons, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmDigTintaAutomotivaPPG = class(TfrmDigTintaAutomotiva)
    lblAdicional2: TLabel;
    cmbListaAdicional2: TComboBoxFocus;
    lblAdicional3: TLabel;
    cmbListaAdicional3: TComboBoxFocus;
    lblAdicional4: TLabel;
    cmbListaAdicional4: TComboBoxFocus;
    rdbCopoPpg: TRadioButton;
    btnCfgEmb: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure cmbListaAdicionalChange(Sender: TObject);
    procedure rdgModoVendaClick(Sender: TObject);Reintroduce;
    procedure edtVolumeExit(Sender: TObject);
    procedure edtQtdEmbExit(Sender: TObject);
    procedure rdbLitroClick(Sender: TObject);
    procedure btnFormulacaoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rdbCopoPpgClick(Sender: TObject);
    procedure btnCfgEmbClick(Sender: TObject);
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
    procedure pTrocarEmbalagemTinta;
    procedure pTrocarProdutoEmbalagem(strCodIte: String);

    function fRetornaTipoEmbalagem: String;        
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
  frmDigTintaAutomotivaPPG: TfrmDigTintaAutomotivaPPG;

implementation

uses untFuncEspecificas, untFuncoesSimples, Math,
  untFormulacaoAutomotiva, untTrocarEmbalagem,untPpgDinamica, untIConfTinta, untTintaMaquina,
  untIConfEmb;

{$R *.dfm}

procedure TfrmDigTintaAutomotivaPPG.FormCreate(Sender: TObject);
begin
  inherited;
  fltVolumePadraoLitro := 1;

  fltVolumePadraoGalao := 3.600;
  fltVolumeMaximoGalao := 4.000;

  fltVolumePadraoSpray := 200;
  fltVolumeMaximoSpray := 200;

  fltVolumePadraoCopo  := 18;
  fltVolumeMaximoCopo  := 18;
end;

procedure TfrmDigTintaAutomotivaPPG.FormShow(Sender: TObject);
  Var
    objFormulaPpg: TFormulaPpgDinamica;
    arrTops: Array[1..4] Of Integer;
begin
  if not Assigned(stlProEmbBd) then
  begin
    stlProEmbBd := TStringList.Create;
    stlProEmbBd.Text := strProEmbBa;
  end;

  if not Assigned(stlProEmbTb) then
  begin
    stlProEmbTb := TStringList.Create;
    stlProEmbTb.Text := strProEmbTb;
  end;

  pMostrarAcertoTinta;
  
  arrTops[1] := rdbLitro.Top;
  arrTops[2] := rdbGalao.Top;
  arrTops[3] := rdbCopo.Top;
  arrTops[4] := rdbSpray.Top;

  inherited;
  objFormulaPpg := TFormulaPpgDinamica(objFormula);

  rdbLitro.Top := arrTops[1];
  rdbGalao.Top := arrTops[2];
  rdbCopo.Top  := arrTops[3];
  rdbSpray.Top := arrTops[4];

  cmbTipoEmbalagem.Visible  := True;
  lblTipo.Visible := True;
  cmbListaAdicional.ItemIndex := objFormulaPpg.intIndiceAdicional;

  lblAdicional4.Visible := Not fEmptyStr(objFormulaPpg.strCaptionAdicional4);
  If lblAdicional4.Visible Then
  Begin
    lblAdicional4.Caption := objFormulaPpg.strCaptionAdicional4;
    cmbListaAdicional4.Items := objFormulaPpg.stlListaAdicional4;
  End;

  lblAdicional3.Visible := Not fEmptyStr(objFormulaPpg.strCaptionAdicional3);
  If lblAdicional3.Visible Then
  Begin
    lblAdicional3.Caption := objFormulaPpg.strCaptionAdicional3;
    cmbListaAdicional3.Items := objFormulaPpg.stlListaAdicional3;
  End;

  lblAdicional2.Visible := Not fEmptyStr(objFormulaPpg.strCaptionAdicional2);
  If lblAdicional2.Visible Then
  Begin
    lblAdicional2.Caption := objFormulaPpg.strCaptionAdicional2;
    cmbListaAdicional2.Items := objFormulaPpg.stlListaAdicional2;
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

function TfrmDigTintaAutomotivaPPG.fPermiteMostrarComboDeEmbalagem: Boolean;
begin
  Result := True;
end;

procedure TfrmDigTintaAutomotivaPPG.cmbListaAdicionalChange(
  Sender: TObject);
begin
  stlDiluentes := fRetDiluentes(cmbTipoEmbalagem.Text, cmbListaAdicional.ItemIndex, cmbListaAdicional3.Text);
  stlCatalisadores := fRetCatalisadores(cmbTipoEmbalagem.Text, cmbListaAdicional.ItemIndex);
  strTexturBase := fRetStrTexturBaseMat(cmbTipoEmbalagem.Text, cmbListaAdicional.ItemIndex);
  stlTexturBase := fRetTexturBaseMat(cmbTipoEmbalagem.Text, cmbListaAdicional.ItemIndex);
  pRecalculaFormula;
  inherited;
end;

procedure TfrmDigTintaAutomotivaPPG.SetstlDiluentes(
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

procedure TfrmDigTintaAutomotivaPPG.SetstlCatalisadores(
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

procedure TfrmDigTintaAutomotivaPPG.SetstlTexturBase(
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

procedure TfrmDigTintaAutomotivaPPG.SetstrTexturBase(const Value: String);
begin
  FstrTexturBase := Value;
  lblAdicional2.Caption := Value;
end;

procedure TfrmDigTintaAutomotivaPPG.rdgModoVendaClick(Sender: TObject);
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

procedure TfrmDigTintaAutomotivaPPG.edtVolumeExit(Sender: TObject);
begin
  If (rdbCopoPpg.Checked) And (fStrToFloat(edtVolume.Text) > 0.500) Then
  Begin
    fMensagem('', 'O volume máximo para Copo é ' + FloatToStrF(0.500, ffNumber, 12, 3) + '!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End;

  inherited;
  cmbListaAdicionalChange(Self);
end;

procedure TfrmDigTintaAutomotivaPPG.pDefineEmbalagem;
Var
  conf: IConfTinta;
  confEmb: IConfEmb;  
begin
  conf := fGetConfTinta('PPG');
  confEmb := fGetConfEmb('PPG');    

  If (rdbGalao.Checked) Then
  Begin
    If (stlProEmbGl.Count <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'As embalagens para Galão não estão configuradas. ' +
                            'Favor configurar.', ['&Ok']);
      rdbLitro.Checked := True;
    End
    Else
      objFormula.strCodEmb := stlProEmbGl[cmbTipoEmbalagem.ItemIndex];
  End

  else If (rdbTambor.Checked) Then
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

  Else If (rdbLata.Checked) Then
  Begin
    If (stlProEmbLa.Count <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'As embalagens para Lata não estão configuradas. ' +
                            'Favor configurar.', ['&Ok']);
      rdbLitro.Checked := True;
    End
    Else
    begin
      if strProEmbLa = '' then
        objFormula.strCodEmb := stlProEmbLa[cmbTipoEmbalagem.ItemIndex] //strProEmbLa;
      else
        objFormula.strCodEmb := strProEmbLa;
    end;

  End
  Else If (rdbCopo.Checked) Then
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
  Else If (rdbCopoPpg.Checked) Then
  Begin
    //Forma nova trocando a embalagem
    objFormula.strCodEmb := confEmb.fGet('PPGCOP');

    If fEmptyStr(objFormula.strCodEmb) Then
      //Forma antiga sem trocar embalagem
      objFormula.strCodEmb := conf.fGet('PPGCOP'); //fArqIniTinta(0, 'PPG', 'PPGCOP', '');
    If (fEmptyStr(objFormula.strCodEmb)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A embalagem para Copo não estão configuradas. ' +
                            'Favor configurar.', ['&Ok']);
      rdbLitro.Checked := True;
    End;
  End
  else
    inherited;
end;

procedure TfrmDigTintaAutomotivaPPG.pRecalculaFormula;
begin
  TFormulaPpgDinamica(objFormula).pReformula(cmbTipoEmbalagem.Text,
                                            cmbListaAdicional2.Text,
                                            cmbListaAdicional3.Text,
                                            cmbListaAdicional4.Text,
                                            cmbListaAdicional.ItemIndex);
  objFormula.pCalcularPrecos;
end;

procedure TfrmDigTintaAutomotivaPPG.edtQtdEmbExit(Sender: TObject);
begin
  inherited;
  pRecalculaFormula;
end;

procedure TfrmDigTintaAutomotivaPPG.rdbCopoPpgClick(Sender: TObject);
begin
  inherited;
  edtVolume.Text := '0,500';
  rdbLitroClick(Sender);
  pRecalculaFormula;
end;

procedure TfrmDigTintaAutomotivaPPG.rdbLitroClick(Sender: TObject);
begin
  inherited;
  pRecalculaFormula;
end;

procedure TfrmDigTintaAutomotivaPPG.btnCfgEmbClick(Sender: TObject);
begin
  inherited;
//  If fStrToFloat(edtPreEmb.Text) > 0 Then
    pTrocarEmbalagemTinta;
end;

procedure TfrmDigTintaAutomotivaPPG.btnFormulacaoClick(Sender: TObject);
  Var
    frmFormulacao: TfrmFormulacaoAutomotivaPpg;
begin
  Application.CreateForm(TfrmFormulacaoAutomotivaPpg, frmFormulacao);
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

function TfrmDigTintaAutomotivaPPG.fRetornaTipoEmbalagem: String;
begin
  Result := '';
  If rdbLitro.Checked   Then Result := 'LITRO';
  If rdbCopo.Checked    Then Result := 'BALDE';
  If rdbGalao.Checked   Then Result := 'GALAO';
  If (rdbSpray.Checked) or (rdbTambor.Checked) Then Result := 'TAMBOR';
  If rdbCopoPpg.Checked Then Result := 'COPO';
end;

procedure TfrmDigTintaAutomotivaPPG.pTrocarEmbalagemTinta;
begin
  Try
    pCriarFormularios(TfrmTrocarEmbalagem,frmTrocarEmbalagem);
    frmTrocarEmbalagem.pSetaParametros(fRetornaTipoEmbalagem,IIF(cmbTipoEmbalagem.Visible,IIF(Not rdbCopoPpg.Checked,cmbTipoEmbalagem.Text,'SEM LINHA'),'SEM LINHA'));
    frmTrocarEmbalagem.ShowModal;
    If Not fEmptyStr(frmTrocarEmbalagem.strCodIte) Then
      pTrocarProdutoEmbalagem(frmTrocarEmbalagem.strCodIte);
  Finally
    FreeAndNil(frmTrocarEmbalagem);
  End;
end;

procedure TfrmDigTintaAutomotivaPPG.pTrocarProdutoEmbalagem(strCodIte: String);
begin
  objFormula.strCodEmb := strCodIte;
  pAtualizaPrecos;
end;

end.

