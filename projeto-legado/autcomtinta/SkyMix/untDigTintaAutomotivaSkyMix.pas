unit untDigTintaAutomotivaSkyMix;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untDigTintaAutomotiva, AppEvnts, Menus, StdCtrls, ComboBoxFocus, EditFocus, ExtCtrls, Buttons, BitBtnLockedIncrem,
  StrUtils, frxClass, frxExportCSVTestabilidade;

type
  TfrmDigTintaAutomotivaSkyMix = class(TfrmDigTintaAutomotiva)
    procedure rdgModoVendaClick(Sender: TObject);Reintroduce;
    procedure rdbLitroClick(Sender: TObject);
    procedure btnFormulacaoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    strLinha: string;
    function GetLinha: String;
    procedure SetLinha(const Value: String);

    { Private declarations }
  public
    property Linha: String read GetLinha write SetLinha;
    { Public declarations }
  end;

var
  frmDigTintaAutomotivaSkyMix: TfrmDigTintaAutomotivaSkyMix;

implementation

uses untFuncoesSimples, untFuncEspecificas, untFormulacaoAutomotivaSkyMix;

{$R *.dfm}

{ TfrmDigTintaAutomotivaSkyMix }

procedure TfrmDigTintaAutomotivaSkyMix.btnFormulacaoClick(Sender: TObject);
begin
  frmFormulacaoAutomotivaSkyMix := nil;
  Try
    Try
      frmFormulacaoAutomotivaSkyMix := TfrmFormulacaoAutomotivaSkyMix.Create(Self);
      frmFormulacaoAutomotivaSkyMix.objFormula := objFormula;
      frmFormulacaoAutomotivaSkyMix.objFormulaQtdEsp := objFormulaQtdEsp;

      If (Not blnMosDil2) Then
      Begin
        frmFormulacaoAutomotivaSkyMix.lsvFormulacao.Columns[4].Width := 0;
        frmFormulacaoAutomotivaSkyMix.Width := frmFormulacaoAutomotivaSkyMix.Width - 100;
      End;

      frmFormulacaoAutomotivaSkyMix.Caption := frmFormulacaoAutomotivaSkyMix.Caption + objFormula.strDescri;
      frmFormulacaoAutomotivaSkyMix.strIdePro := 'SKY';
      frmFormulacaoAutomotivaSkyMix.blnConsLinhaDesBas := blnConsLinhaDesBas;
      frmFormulacaoAutomotivaSkyMix.strLinha := strLinha;
      frmFormulacaoAutomotivaSkyMix.ShowModal;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(frmFormulacaoAutomotivaSkyMix) then FreeAndNil(frmFormulacaoAutomotivaSkyMix);
  End;
end;

procedure TfrmDigTintaAutomotivaSkyMix.FormCreate(Sender: TObject);
begin
  inherited;
  If (fCfgSis('DIRFOR', varBoolean))  Then
    btnFormulacao.Visible :=  fVerificaAcessoSistema('DIRVISFOR');
end;

function TfrmDigTintaAutomotivaSkyMix.GetLinha: String;
begin
  Result := strLinha;
end;

procedure TfrmDigTintaAutomotivaSkyMix.rdbLitroClick(Sender: TObject);
begin
  inherited;
  If (Trim(UpperCase(LeftStr(strLinha, 2))) = Trim(UpperCase('PU'))) and (rdgModoVenda.ItemIndex = 1) Then
  Begin
    If (rdbLitro.Checked) Then
    Begin
      objFormula.tpeTipEmb := teLitro;
      edtVolume.Text := FloatToStr(0.675);
    End
    Else If (rdbGalao.Checked) Then
    Begin
      objFormula.tpeTipEmb := teGalao;
      edtVolume.Text := FloatToStr(0.675*4);
    End;

    objFormula.fltVolumePro := fStrToFloat(edtVolume.Text);
    pAtualizaPrecos;
  End;
end;

procedure TfrmDigTintaAutomotivaSkyMix.rdgModoVendaClick(Sender: TObject);
begin
  If rdbLitro.Checked then
    edtVolume.Text := FloatToStr(0.9)
  Else If rdbGalao.Checked then
    edtVolume.Text := FloatToStr(3.6);

  If (Trim(UpperCase(LeftStr(strLinha, 2))) = Trim(UpperCase('PU')))
    And (rdgModoVenda.ItemIndex = 1) Then
  Begin
    If (rdbLitro.Checked) then
      edtVolume.Text := FloatToStr(0.675)
    Else If (rdbGalao.Checked) Then
      edtVolume.Text := FloatToStr(0.675*4);
  End;

  edtVolumeExit(edtVolume);

  inherited;
end;

procedure TfrmDigTintaAutomotivaSkyMix.SetLinha(const Value: String);
begin
  strLinha := Value;
end;

end.
