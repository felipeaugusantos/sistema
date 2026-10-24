unit untDigTintaAutomotivaNexaNova;

interface

uses
  SysUtils, Classes, Controls, Forms,
  untDigTintaAutomotiva, StdCtrls, ComboBoxFocus,
  BitBtnLockedIncrem, AppEvnts, Menus, EditFocus, ExtCtrls, Buttons,
  Uni, frxClass, frxExportCSVTestabilidade;

type
  TMinMax = record
    fltMin : Double;
    fltMax : Double;
  end;
  
  TfrmDigTintaAutomotivaNexaNova = class(TfrmDigTintaAutomotiva)
    rdbCopoNexa: TRadioButton;
    lblPorcentagemDiluente: TLabel;
    edtDil: TEditFocus;
    procedure FormShow(Sender: TObject);
    procedure cmbListaAdicionalChange(Sender: TObject);
    procedure rdgModoVendaClick(Sender: TObject); override;
    procedure edtVolumeExit(Sender: TObject);
    procedure edtQtdEmbExit(Sender: TObject);
    procedure rdbLitroClick(Sender: TObject);
    procedure btnFormulacaoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rdbCopoNexaClick(Sender: TObject);
    procedure edtDilExit(Sender: TObject);
    procedure rdbCopoClick(Sender: TObject);
    procedure rdbGalaoClick(Sender: TObject);
    procedure rdbSprayClick(Sender: TObject);
    procedure rdbLataClick(Sender: TObject);
    procedure rdbBaldeClick(Sender: TObject);
    procedure rdbLitroExit(Sender: TObject);
  private
    FstlDiluentes: TStringList;
    FstlCatalisadores: TStringList;
    FstlTexturBase: TStringList;
    FstrTexturBase: String;
    strSistema: string;
    arrMinMax: array of TMinMax;

    procedure SetstlDiluentes(const Value: TStringList);
    procedure SetstlCatalisadores(const Value: TStringList);
    procedure SetstlTexturBase(const Value: TStringList);
    procedure SetstrTexturBase(const Value: String);
    procedure pRecalculaFormula();
    procedure pAtualizaPorcentagem;
    procedure IniciaArrMinMax;
    function GetPorDil: Double;
    { Private declarations }
  protected
    procedure pDefineEmbalagem; override;
    function fPermiteMostrarComboDeEmbalagem: Boolean; override;

    function fAlturaPnlAdicional: Integer; override;
    function fAlturaConsEmb: Integer; override;
    function fAlturaTrocaEmb: Integer; override;
  public
    stlOpcoesDiluicao: TStringList;

    stlProEmbBd: TStringList;
    stlProEmbTb: TStringList;

    property stlDiluentes: TStringList read FstlDiluentes write SetstlDiluentes;
    property stlCatalisadores: TStringList read FstlCatalisadores write SetstlCatalisadores;
    property stlTexturBase: TStringList read FstlTexturBase write SetstlTexturBase;
    property strTexturBase: String read FstrTexturBase write SetstrTexturBase;
    property Sistema: string read strSistema write strSistema;
    property PorDil: Double read GetPorDil;
    { Public declarations }
  end;

var
  frmDigTintaAutomotivaNexaNova: TfrmDigTintaAutomotivaNexaNova;

implementation

uses untFuncEspecificas, untFuncoesSimples,
  untFormulacaoAutomotiva, untNexaDinamica, untIConfTinta, untTintaMaquina;

{$R *.dfm}

procedure TfrmDigTintaAutomotivaNexaNova.FormCreate(Sender: TObject);
begin
  inherited;
  intAlturaOri := Self.Height;

  fltVolumePadraoLitro := 1;

  fltVolumePadraoGalao := 3.500;
  fltVolumeMaximoGalao := 4.000;

  fltVolumePadraoSpray := 200;
  fltVolumeMaximoSpray := 200;

  fltVolumePadraoCopo  := 18.000;
  fltVolumeMaximoCopo  := 18.000;
  fltVolumeMaximoBalde := 20.000;

  If (fCfgSis('DIRFOR', varBoolean))  Then
    btnFormulacao.Visible :=  fVerificaAcessoSistema('DIRVISFOR');
end;

procedure TfrmDigTintaAutomotivaNexaNova.FormShow(Sender: TObject);
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
  
  pnlAdicional.Visible := (rdgModoVenda.ItemIndex = 1);
//  Self.Height := IIF(pnlAdicional.Visible, 420, 360);

  IniciaArrMinMax;  
end;

function TfrmDigTintaAutomotivaNexaNova.fPermiteMostrarComboDeEmbalagem: Boolean;
begin
  Result := True;
end;

function TfrmDigTintaAutomotivaNexaNova.GetPorDil: Double;
begin
  Result := fStrToFloat(edtDil.Text);
end;

procedure TfrmDigTintaAutomotivaNexaNova.IniciaArrMinMax;
var
  qryGen: TUniQuery;
  intCont: Integer;
begin
  SetLength(arrMinMax, cmbListaAdicional.Items.Count);

  if cmbListaAdicional.Items.Count <= 0 then
    Exit;

  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT DISTINCT                                    ' +
        '   *                                                ' +
        ' FROM                                               ' +
        '   NEX_CADBAS B                                     ' +
        '   INNER JOIN PPG_CADDIL D                          ' +
        '     ON B.BAS_CODBAS = D.DIL_CODDIL                 ' +
        ' WHERE BAS_TIPO__ = :TIPO                           ' +
        '   AND ((:SISTEM LIKE CONCAT("%", DIL_SISTEM, "%")) ' +
        '     OR (:SISTEM = "PERSONALIZADA"))                ' +
        '   AND DIL_CODDIL = :CODDIL                         ';

      qryGen.ParamByName('TIPO').AsString := cmbTipoEmbalagem.Text;
      qryGen.ParamByName('SISTEM').AsString := strSistema;

      for intCont := 0 to cmbListaAdicional.Items.Count - 1 do
      begin
        qryGen.Close;
        qryGen.ParamByName('CODDIL').AsString := cmbListaAdicional.Items[intCont];
        qryGen.Open;

        arrMinMax[intCont].fltMin := qryGen.FieldByName('DIL_MINIMO').AsFloat;
        arrMinMax[intCont].fltMax := qryGen.FieldByName('DIL_MAXIMO').AsFloat;
      end;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

procedure TfrmDigTintaAutomotivaNexaNova.cmbListaAdicionalChange(
  Sender: TObject);
begin

  pRecalculaFormula;
  inherited;
end;

procedure TfrmDigTintaAutomotivaNexaNova.SetstlDiluentes(
  const Value: TStringList);
begin
  If Assigned(FstlDiluentes) Then
    FreeAndNil(FstlDiluentes);

  FstlDiluentes := Value;
end;

procedure TfrmDigTintaAutomotivaNexaNova.SetstlCatalisadores(
  const Value: TStringList);
begin
  If Assigned(FstlCatalisadores) Then
    FreeAndNil(FstlCatalisadores);

  FstlCatalisadores := Value;
end;

procedure TfrmDigTintaAutomotivaNexaNova.SetstlTexturBase(
  const Value: TStringList);
begin
  If Assigned(FstlTexturBase) Then
    FreeAndNil(FstlTexturBase);

  FstlTexturBase := Value;
end;

procedure TfrmDigTintaAutomotivaNexaNova.SetstrTexturBase(const Value: String);
begin
  FstrTexturBase := Value;
end;

procedure TfrmDigTintaAutomotivaNexaNova.rdgModoVendaClick(Sender: TObject);
begin

  Case rdgModoVenda.ItemIndex Of
    0: objFormula.mveModoVenda := mvConcentrado;
  Else
    objFormula.mveModoVenda := mvDiluido;
  End;

  pnlAdicional.Visible := (rdgModoVenda.ItemIndex = 1) ;
//  Self.ClientHeight := IIF(pnlAdicional.Visible, 420, 360);

  Self.Height := intAlturaOri;

  If Not pnlAdicional.Visible Then
    Self.Height := Self.Height - fAlturaPnlAdicional;

  If Not pnlConsEmb.Visible Then
    Self.Height := Self.Height - fAlturaConsEmb;

  If Not pnlTrocaEmb.Visible Then
    Self.Height := Self.Height - fAlturaTrocaEmb;

  pRecalculaFormula;
  pAtualizaPrecos;
end;

procedure TfrmDigTintaAutomotivaNexaNova.edtVolumeExit(Sender: TObject);
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
  Else
  If (rdbCopoNexa.Checked) And (fStrToFloat(edtVolume.Text) > 0.500) Then
  Begin
    fMensagem('', 'O volume máximo para Copo é ' + FloatToStrF(0.500, ffNumber, 12, 3) + '!', ['&Ok']);
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
  Else If (rdbCopo.Checked) And (fFormataFloat(fStrToFloat(edtVolume.Text), 3) > fltVolumeMaximoBalde) Then
  Begin
    fMensagem('', 'O volume máximo para Balde é ' + FloatToStrF(fltVolumeMaximoBalde, ffNumber, 12, 3) + '!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End
  Else If (rdbTambor.Checked) And (fFormataFloat(fStrToFloat(edtVolume.Text), 3) > fFormataFloat(fltVolumeMaximoTambor, 3)) Then
  Begin
    fMensagem('', 'O volume máximo para Tambor é ' + FloatToStrF(fltVolumeMaximoTambor, ffNumber, 12, 3) + '!', ['&Ok']);
    pSetFocus(edtVolume);
    Exit;
  End;

  objFormula.fltVolumePro := fStrToFloat(edtVolume.Text);
  pAtualizaPrecos;

  cmbListaAdicionalChange(Self);
end;

function TfrmDigTintaAutomotivaNexaNova.fAlturaConsEmb: Integer;
begin
  Result := pnlConsEmb.Height;
end;

function TfrmDigTintaAutomotivaNexaNova.fAlturaPnlAdicional: Integer;
begin
  Result := pnlAdicional.Height;
end;

function TfrmDigTintaAutomotivaNexaNova.fAlturaTrocaEmb: Integer;
begin
  Result := pnlTrocaEmb.Height;
end;

procedure TfrmDigTintaAutomotivaNexaNova.pAtualizaPorcentagem;
begin
  edtDil.Visible := Length(arrMinMax) > 0;

  If (cmbListaAdicional.ItemIndex < 0) Then
    Exit;

  If fStrToFloat(edtDil.Text) > arrMinMax[cmbListaAdicional.ItemIndex].fltMax Then
    edtDil.Text := FloatToStr(arrMinMax[cmbListaAdicional.ItemIndex].fltMax);

  If Length(arrMinMax) > 0 Then
  Begin
    if arrMinMax[cmbListaAdicional.ItemIndex].fltMax = arrMinMax[cmbListaAdicional.ItemIndex].fltMin then
      edtDil.Enabled := False;

    If fStrToFloat(edtDil.Text) > arrMinMax[cmbListaAdicional.ItemIndex].fltMax Then
      edtDil.Text := FloatToStr(arrMinMax[cmbListaAdicional.ItemIndex].fltMax);

    If fStrToFloat(edtDil.Text) < arrMinMax[cmbListaAdicional.ItemIndex].fltMin Then
      edtDil.Text := FloatToStr(arrMinMax[cmbListaAdicional.ItemIndex].fltMin);
  End;
end;

procedure TfrmDigTintaAutomotivaNexaNova.pDefineEmbalagem;
Var
  conf: IConfTinta;
begin
  inherited;
  conf := fGetConfTinta('NEX');

  If objFormula.blnConsiderarEmbalagem Then
  Begin
    //BALDE NA NEXA
    If (rdbCopo.Checked) Then
    Begin
      If (stlProEmbBd.Count <= 0) Then
      Begin
        edtPreEmb.Text := '0,00';
        fMensagem('ATENÇÃO!', 'As embalagens para Balde não estão configuradas. ' +
                              'Favor configurar.', ['&Ok']);
        Abort;
      End
      Else
        objFormula.strCodEmb := stlProEmbBd[cmbTipoEmbalagem.ItemIndex];
    End
    Else If (rdbSpray.Checked) Then
    Begin
      If (stlProEmbTb.Count <= 0) Then
      Begin
        edtPreEmb.Text := '0,00';
        fMensagem('ATENÇÃO!', 'As embalagens para Tambor não estão configuradas. ' +
                              'Favor configurar.', ['&Ok']);
        Abort;
      End
      Else
        objFormula.strCodEmb := stlProEmbTb[cmbTipoEmbalagem.ItemIndex];
    End
    Else If (rdbCopoNexa.Checked) Then
    Begin
      objFormula.strCodEmb := conf.fGet('NEXACOP');
      If (fEmptyStr(objFormula.strCodEmb)) Then
      Begin
        edtPreEmb.Text := '0,00';
        fMensagem('ATENÇÃO!', 'A embalagem para Copo não está configurada. ' +
                              'Favor configurar.', ['&Ok']);
        Abort;
      End;
    End;
  End;
end;

procedure TfrmDigTintaAutomotivaNexaNova.pRecalculaFormula;
begin
  if not fEmptyStr(cmbListaAdicional.Items[cmbListaAdicional.ItemIndex]) then
  begin
    pAtualizaPorcentagem;
    TFormulaNexaDinamica(objFormula).pReformulaNovo(cmbTipoEmbalagem.Text,
      cmbListaAdicional.Items[cmbListaAdicional.ItemIndex],
      strSistema,
      fStrToFloat(edtDil.Text));
  end;

  objFormula.pCalcularPrecos;
end;

procedure TfrmDigTintaAutomotivaNexaNova.edtDilExit(Sender: TObject);
begin
  pAtualizaPorcentagem;
  cmbListaAdicionalChange(Self);
end;

procedure TfrmDigTintaAutomotivaNexaNova.edtQtdEmbExit(Sender: TObject);
begin
  inherited;
  pRecalculaFormula;
end;

procedure TfrmDigTintaAutomotivaNexaNova.rdbBaldeClick(Sender: TObject);
begin
//  inherited;
//  inherited;
  objFormula.tpeTipEmb := teBalde;
  edtVolume.Text := FloatToStrF(fltVolumePadraoBalde, ffNumber, 12, 3);

  objFormula.fltVolumePro := fStrToFloat(edtVolume.Text);
  pRecalculaFormula;

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
end;

procedure TfrmDigTintaAutomotivaNexaNova.rdbCopoClick(Sender: TObject);
begin
//  inherited;
  objFormula.tpeTipEmb := teBalde;
  edtVolume.Text := FloatToStrF(fltVolumePadraoBalde, ffNumber, 12, 3);

  objFormula.fltVolumePro := fStrToFloat(edtVolume.Text);
  pRecalculaFormula;

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

end;

procedure TfrmDigTintaAutomotivaNexaNova.rdbCopoNexaClick(Sender: TObject);
begin
  objFormula.tpeTipEmb := teCopo;
  edtVolume.Text := '0,500';

  objFormula.fltVolumePro := fStrToFloat(edtVolume.Text);
  pRecalculaFormula;

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

procedure TfrmDigTintaAutomotivaNexaNova.rdbGalaoClick(Sender: TObject);
begin
//  inherited;
  objFormula.tpeTipEmb := teGalao;
  edtVolume.Text := FloatToStrF(fltVolumePadraoGalao, ffNumber, 12, 3);

  objFormula.fltVolumePro := fStrToFloat(edtVolume.Text);
  pRecalculaFormula;

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

procedure TfrmDigTintaAutomotivaNexaNova.rdbLataClick(Sender: TObject);
begin
//  inherited;
  objFormula.tpeTipEmb := teLata;
  edtVolume.Text := FloatToStrF(fltVolumePadraoLata, ffNumber, 12, 3);

  objFormula.fltVolumePro := fStrToFloat(edtVolume.Text);
  pRecalculaFormula;

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

procedure TfrmDigTintaAutomotivaNexaNova.rdbLitroClick(Sender: TObject);
begin
 // inherited;
  objFormula.tpeTipEmb := teLitro;
  edtVolume.Text := FloatToStrF(fltVolumePadraoLitro, ffNumber, 12, 3);

  objFormula.fltVolumePro := fStrToFloat(edtVolume.Text);
  pRecalculaFormula;

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

procedure TfrmDigTintaAutomotivaNexaNova.rdbLitroExit(Sender: TObject);
begin
  inherited;
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

procedure TfrmDigTintaAutomotivaNexaNova.rdbSprayClick(Sender: TObject);
begin
//  inherited;
  objFormula.tpeTipEmb := teTambor;
  edtVolume.Text := FloatToStrF(fltVolumePadraoTambor, ffNumber, 12, 3);

  objFormula.fltVolumePro := fStrToFloat(edtVolume.Text);
  pRecalculaFormula;

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

procedure TfrmDigTintaAutomotivaNexaNova.btnFormulacaoClick(Sender: TObject);
  Var
    frmFormulacao: TfrmFormulacaoAutomotivaNexa;
begin
  pCriarFormularios(TfrmFormulacaoAutomotivaNexa, frmFormulacao);
  frmFormulacao.objFormula := objFormula;
  frmFormulacao.strSistema := strSistema;

  If (Not blnMosDil2) Then
  Begin
    frmFormulacao.lsvFormulacao.Columns[4].Width := 0;
    frmFormulacao.Width := frmFormulacao.Width - 100;
  End;

  frmFormulacao.Caption := frmFormulacao.Caption + objFormula.strDescri;
  frmFormulacao.strIdePro := strIdePro;
  frmFormulacao.ShowModal;
  FreeAndNil(frmFormulacao);
end;

end.

