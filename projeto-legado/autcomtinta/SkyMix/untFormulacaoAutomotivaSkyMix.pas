unit untFormulacaoAutomotivaSkyMix;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untFormulacaoAutomotiva, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls;

type
  TfrmFormulacaoAutomotivaSkyMix = class(TfrmFormulacaoAutomotiva)
  private
    { Private declarations }
  public
    { Public declarations }
    strLinha: String;

    procedure pRecalculaFormula(blnPadrao: Boolean); override;
  end;

var
  frmFormulacaoAutomotivaSkyMix: TfrmFormulacaoAutomotivaSkyMix;

implementation

uses
  untFuncoesSimples, untTintaMaquina, untFuncEspecificas;

{$R *.dfm}

{ TfrmFormulacaoAutomotivaSkyMix }

procedure TfrmFormulacaoAutomotivaSkyMix.pRecalculaFormula(blnPadrao: Boolean);
var
  intCont : Integer;
  objBase: TBaseAutomotiva;
  strTipBas: String;
  fltFator: Double;

  strCodIte: String;
  strCodBasRet: String;
  strDesBas: String;

  function fDescricaoBase(strCodBas: String): String;
  begin
    Result := strCodBas;

    If (Not fEmptyStr(strIdePro)) Then
    Begin
      pRetItemEDescricaoColorante(strIdePro, strCodBas, strCodIte, strCodBasRet, strDesBas, VS_strCodEmp);

      If (Not fEmptyStr(strDesBas)) Then
      Begin
        Result := Result + '-' + strDesBas;
      End;
    End;
  end;
begin
  If objFormula.fltVolumeOri > 0 Then
    fltFator := objFormula.fltVolumePro / objFormula.fltVolumeOri
  Else
    fltFator := 1;

  If objFormula.fltVolumeOri > 1 Then
    fltFator := fltFator * 1000;

  lsvFormulacao.Clear;

  If (blnPadrao) Then
  Begin

    For intCont := 0 To objFormula.Count-1 Do
    Begin

      If Assigned(objFormulaQtdEsp) Then
        objBase := TBaseAutomotiva(objFormulaQtdEsp.Items[intCont])
      Else
        objBase := TBaseAutomotiva(objFormula.Items[intCont]);

      If (objBase.strTipBas = 'C') And (Not objFormula.blnComCatalisador) Then
        Continue;

      If objBase.strTipBas = 'B' Then
        strTipBas := 'BASE'
      Else If objBase.strTipBas = 'C' Then
        strTipBas := 'CATALISADOR'
      Else
        strTipBas := 'DILUENTE';

      With lsvFormulacao.Items.Add Do
      Begin
        Caption := fDescricaoBase(IIF(blnConsLinhaDesBas, objBase.strLinBas + '_', '') + objBase.strCodBas);
        SubItems.Add(strTipBas);

        SubItems.Add(FloatToStrF(objBase.fltQtdCon, ffFixed, 12, 3));
        SubItems.Add(FloatToStrF(fFormataFloatSky(objBase.fltQtdDil), ffFixed, 12, 3));
        SubItems.Add(FloatToStrF(fFormataFloatSky(objBase.fltQtdDi2), ffFixed, 12, 3));
        SubItems.Add(FloatToStrF(objBase.fltPreVen, ffFixed, 12, intDecimaisPrecoVenda));
        SubItems.Add(FloatToStrF(objBase.fltEmbala, ffFixed, 12, 4));
        SubItems.Add(FloatToStrF(objBase.fltPesEsp, ffFixed, 12, intDecimaisPesoEspecifico));
      End;

    End;
  End
  Else
  Begin
    For intCont := 0 To objFormula.Count-1 Do
    Begin

      If Assigned(objFormulaQtdEsp) Then
        objBase := TBaseAutomotiva(objFormulaQtdEsp.Items[intCont])
      Else
        objBase := TBaseAutomotiva(objFormula.Items[intCont]);

      If (objBase.strTipBas = 'C') And (Not objFormula.blnComCatalisador) Then
        Continue;

      If objBase.strTipBas = 'B' Then
        strTipBas := 'BASE'
      Else If objBase.strTipBas = 'C' Then
        strTipBas := 'CATALISADOR'
      Else
        strTipBas := 'DILUENTE';

      With lsvFormulacao.Items.Add Do
      Begin
        Caption := fDescricaoBase(IIF(blnConsLinhaDesBas, objBase.strLinBas + '_', '') + objBase.strCodBas);
        SubItems.Add(strTipBas);

        SubItems.Add(FloatToStrF(objBase.fltQtdCon * fltFator, ffFixed, 12, 3));
        SubItems.Add(FloatToStrF(fFormataFloatSky(objBase.fltQtdDil * fltFator), ffFixed, 12, 3));
        SubItems.Add(FloatToStrF(fFormataFloatSky(objBase.fltQtdDi2 * fltFator), ffFixed, 12, 3));
        SubItems.Add(FloatToStrF(objBase.fltPreVen, ffFixed, 12, intDecimaisPrecoVenda));
        SubItems.Add(FloatToStrF(objBase.fltEmbala, ffFixed, 12, 4));
        SubItems.Add(FloatToStrF(objBase.fltPesEsp, ffFixed, 12, intDecimaisPesoEspecifico));
      End;
    End;
  End;

  memCalculo.Lines.Clear;
  memCalculo.Lines.Assign(objFormula.stlCalculo);
end;

end.
