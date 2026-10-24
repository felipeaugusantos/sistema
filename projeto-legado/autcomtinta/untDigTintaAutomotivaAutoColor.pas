unit untDigTintaAutomotivaAutoColor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untDigTintaAutomotiva, AppEvnts, Menus, StdCtrls, ComboBoxFocus,
  EditFocus, ExtCtrls, Buttons, ComCtrls,  Uni,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type

  TMinMax = record
    fltMin : Double;
    fltMax : Double;
  end;

  TfrmDigTintaAutomotivaAutoColor = class(TfrmDigTintaAutomotiva)
    edtDil: TEditFocus;
    Label7: TLabel;
    lbCat: TLabel;
    edtCat: TEditFocus;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnFormulacaoClick(Sender: TObject);
    procedure edtDilExit(Sender: TObject);
    procedure rdgModoVendaClick(Sender: TObject); Reintroduce;
    procedure pApagaDiluente;
    procedure cmbListaAdicionalChange(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cmbTipoEmbalagemExit(Sender: TObject);
    procedure cmbTipoEmbalagemKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbTipoEmbalagemSelect(Sender: TObject);
    procedure rdgModoVendaEnter(Sender: TObject);
    procedure rdgModoVendaExit(Sender: TObject);
    procedure edtVolumeExit(Sender: TObject);
    procedure edtQtdEmbExit(Sender: TObject);
    procedure rdbGalaoExit(Sender: TObject);
    procedure rdbLitroExit(Sender: TObject);
    procedure cmbListaAdicionalExit(Sender: TObject);
    procedure chkComCatClick(Sender: TObject);
    procedure edtCatExit(Sender: TObject);
  private
    arrMinMax: array of TMinMax;
    arrCatMinMax: TMinMax;
    intDiluente : Integer;
    qryCadDil : TUniQuery;
    strTodosDil : String;
    strEspDil : String;
    procedure pRecalcularForm;
    procedure pAtualizaPorcentagem;
    procedure pAtualizaPorcentagemCat;
    function fVerificaConfirma: Boolean;
    procedure pVerificaCatalisa;
    procedure pValidaCatalisa;
    { Private declarations }
  public
    qryCadCat : TUniQuery;
    blnCatalisa : Boolean;
    strLinha    : string;
    fltPorCat : Double;
    { Public declarations }
  end;

var
  frmDigTintaAutomotivaAutoColor: TfrmDigTintaAutomotivaAutoColor;

implementation

uses untFuncoesSimples, DB, Math, untAutoColorDinamica, StrUtils,untFuncEspecificas;

{$R *.dfm}

procedure TfrmDigTintaAutomotivaAutoColor.FormShow(Sender: TObject);
  Var
    qryGen : TUniQuery;
begin
  pMostrarAcertoTinta;
  
  fltPorCat := -1;
  qryCadDil := fCriaQuery(Self);
  qryCadDil.SQL.Text := 'SELECT * FROM AUT_CADDIL WHERE DIL_CODSIS = "' + strLinha + '"';
  qryCadDil.Open;

  rdgModoVenda.Enabled := Not qryCadDil.IsEmpty;

  qryCadCat := fCriaQuery(Self);
  qryCadCat.SQL.Text := 'SELECT * FROM AUT_CADCAT WHERE CAT_CODSIS = "' + strLinha + '"';
  qryCadCat.Open;

  chkComCat.Visible := Not qryCadCat.IsEmpty;

  chkComCat.Enabled := blnCatalisa;

  SetLength(arrMinMax, qryCadDil.RecordCount);

  While Not qryCadDil.Eof Do
  Begin
    objFormula.stlListaAdicional.Add(qryCadDil.FieldByName('DIL_CODDIL').AsString);
    arrMinMax[qryCadDil.RecNo - 1].fltMin := qryCadDil.FieldByName('DIL_PORMIN').AsFloat;
    arrMinMax[qryCadDil.RecNo - 1].fltMax := qryCadDil.FieldByName('DIL_PORMAX').AsFloat;
    qryCadDil.Next;
  End;

  intDiluente := objFormula.Count - 1;
  inherited;

  rdgModoVenda.Enabled := Not qryCadDil.IsEmpty;

  cmbListaAdicional.ItemIndex := 0;
  If rdgModoVenda.Enabled Then
    cmbListaAdicionalChange(Sender);

  rdgModoVendaClick(Sender);
  strTodosDil := cmbListaAdicional.Items.Text;

  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'SELECT * FROM AUT_CADDIL WHERE DIL_CODSIS = :CODSIS AND DIL_CATALI = "S"';
  qryGen.ParamByName('CODSIS').AsString := strLinha;
  qryGen.Open;

  If (qryGen.IsEmpty) or (qryGen.FieldByName('DIL_CATALI').IsNull) Then
    strEspDil := strTodosDil
  Else If qryGen.FieldByName('DIL_CATALI').AsString = 'S' Then
    strEspDil := qryGen.FieldByName('DIL_CODDIL').AsString;

  chkComCat.Checked := chkComCat.Visible and not chkComCat.Enabled;
  pAtualizaPorcentagemCat;

end;

procedure TfrmDigTintaAutomotivaAutoColor.FormCreate(Sender: TObject);
begin
  inherited;
  SetLength(arrMinMax, 0);

  If (fCfgSis('DIRFOR', varBoolean))  Then
    btnFormulacao.Visible :=  fVerificaAcessoSistema('DIRVISFOR');
end;

procedure TfrmDigTintaAutomotivaAutoColor.btnFormulacaoClick(
  Sender: TObject);
begin
  pRecalcularForm;
  pCalculaPrecos;
  objFormula.pCarregaPrecosBases;
  inherited;
end;

procedure TfrmDigTintaAutomotivaAutoColor.edtDilExit(Sender: TObject);
begin
  inherited;
  pRecalcularForm;
  pCalculaPrecos;
end;

procedure TfrmDigTintaAutomotivaAutoColor.rdgModoVendaClick(
  Sender: TObject);
begin
  inherited;
  edtDilExit(Sender);
  chkComCat.Visible := (rdgModoVenda.ItemIndex = 1) And Not qryCadCat.IsEmpty;
  chkComCat.Checked := chkComCat.Visible and not chkComCat.Enabled;
end;

procedure TfrmDigTintaAutomotivaAutoColor.pApagaDiluente;
begin
  While objFormula.Count > intDiluente + 1 Do
  Begin
    objFormula.Delete(intDiluente + 1);
  End;
end;

procedure TfrmDigTintaAutomotivaAutoColor.cmbListaAdicionalChange(
  Sender: TObject);
begin
  inherited;
  edtDil.Text := '0';
  edtDilExit(Sender);
  pRecalcularForm;
  pCalculaPrecos;
end;


procedure TfrmDigTintaAutomotivaAutoColor.btnConfirmaClick(
  Sender: TObject);
begin
  pRecalcularForm;
  pCalculaPrecos;

  If Not fVerificaConfirma Then
    Exit;

  If fStrToFloat(edtPrecoSemEmb.Text) <= 0 Then
    Exit;

  objFormula.intQtdEmb := StrToInt(edtQtdEmb.Text);
  matrizSaldosColorantes := objFormula.fRetMatrizSaldosColorantes;
  blnSaldoSuficiente := objFormula.fVerificaSaldosML(matrizSaldosColorantes);

  ModalResult := mrOk;
end;


procedure TfrmDigTintaAutomotivaAutoColor.cmbTipoEmbalagemExit(
  Sender: TObject);
begin
  inherited;
  pRecalcularForm;
  pCalculaPrecos;
end;

procedure TfrmDigTintaAutomotivaAutoColor.cmbTipoEmbalagemKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  pRecalcularForm;
  pCalculaPrecos;
end;

procedure TfrmDigTintaAutomotivaAutoColor.cmbTipoEmbalagemSelect(
  Sender: TObject);
begin
  inherited;
  pRecalcularForm;
  pCalculaPrecos;
end;

procedure TfrmDigTintaAutomotivaAutoColor.rdgModoVendaEnter(
  Sender: TObject);
begin
  inherited;
  pRecalcularForm;
  pCalculaPrecos;
end;

procedure TfrmDigTintaAutomotivaAutoColor.rdgModoVendaExit(
  Sender: TObject);
begin
  inherited;
  pRecalcularForm;
  pCalculaPrecos;
end;

procedure TfrmDigTintaAutomotivaAutoColor.edtVolumeExit(Sender: TObject);
begin
  inherited;
  pRecalcularForm;
  pCalculaPrecos;
end;

procedure TfrmDigTintaAutomotivaAutoColor.pRecalcularForm;
begin
  pApagaDiluente;
  pAtualizaPorcentagem;
  pRecalculaFormula(objFormula, rdgModoVenda.ItemIndex, fStrToFloat(edtDil.Text), cmbListaAdicional.Text,
                    IfThen(chkComCat.Visible and chkComCat.Checked, qryCadCat.FieldByName('CAT_CODCAT').AsString, ''),
                    strLinha, fltPorCat, fStrToFloat(edtQtdEmb.Text));

end;

procedure TfrmDigTintaAutomotivaAutoColor.edtQtdEmbExit(Sender: TObject);
begin
  inherited;
  pRecalcularForm;
  pCalculaPrecos;
end;

procedure TfrmDigTintaAutomotivaAutoColor.rdbGalaoExit(Sender: TObject);
begin
  inherited;
  pRecalcularForm;
  pCalculaPrecos;
end;

procedure TfrmDigTintaAutomotivaAutoColor.rdbLitroExit(Sender: TObject);
begin
  inherited;
  pRecalcularForm;
  pCalculaPrecos;
end;

procedure TfrmDigTintaAutomotivaAutoColor.cmbListaAdicionalExit(
  Sender: TObject);
begin
  inherited;
  pRecalcularForm;
  pCalculaPrecos;
end;

procedure TfrmDigTintaAutomotivaAutoColor.pAtualizaPorcentagem;
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

function TfrmDigTintaAutomotivaAutoColor.fVerificaConfirma: Boolean;
  Var
    intCont : Integer;
begin
  For intCont := 0 To objFormula.Count - 1 Do
  Begin
    If TBaseAutomotiva(objFormula.Items[intCont]).fltPesEsp = 0 Then
    Begin
      Result := False;
      Exit;
    End;
  End;
  Result := True;
end;

procedure TfrmDigTintaAutomotivaAutoColor.chkComCatClick(Sender: TObject);
begin
  inherited;
  If chkComCat.Checked Then
    cmbListaAdicional.Items.Text := strEspDil
  Else
    cmbListaAdicional.Items.Text := strTodosDil;

  cmbListaAdicional.ItemIndex := 0;
  cmbListaAdicionalChange(Sender);

  pAtualizaPorcentagemCat;
end;

procedure TfrmDigTintaAutomotivaAutoColor.pAtualizaPorcentagemCat;
begin
  edtCat.Visible := chkComCat.Visible;
  lbCat.Visible := chkComCat.Visible;

  pVerificaCatalisa;

end;

procedure TfrmDigTintaAutomotivaAutoColor.pVerificaCatalisa;
  Var
    qryCadCat: TUniQuery;
begin
  qryCadCat := fCriaQuery(nil);
  qryCadCat.SQL.Text := 'SELECT * FROM AUT_CADCAT WHERE CAT_CODSIS = "' + strLinha + '"';
  qryCadCat.Open;

  arrCatMinMax.fltMin := qryCadCat.FieldByName('CAT_PORMIN').AsFloat;
  arrCatMinMax.fltMax := qryCadCat.FieldByName('CAT_PORMAX').AsFloat;

  edtCat.Text := FloatToStr(qryCadCat.FieldByName('CAT_PORMIN').AsFloat);

  edtCat.Enabled := (arrCatMinMax.fltMin <> arrCatMinMax.fltMax);

  FreeAndNil(qryCadCat);

end;

procedure TfrmDigTintaAutomotivaAutoColor.pValidaCatalisa;
begin
  if fStrToFloat(edtCat.Text) > arrCatMinMax.fltMax then
    edtCat.Text := FloatToStr(arrCatMinMax.fltMax);

  if fStrToFloat(edtCat.Text) < arrCatMinMax.fltMin then
    edtCat.Text := FloatToStr(arrCatMinMax.fltMin);
end;

procedure TfrmDigTintaAutomotivaAutoColor.edtCatExit(Sender: TObject);
begin
  inherited;
  pValidaCatalisa;
  fltPorCat := fStrToFloat(edtCat.Text);
end;

end.

