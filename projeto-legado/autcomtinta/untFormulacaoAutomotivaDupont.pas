unit untFormulacaoAutomotivaDupont;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untFormulacaoAutomotiva, AppEvnts, Menus, StdCtrls, ComCtrls, Buttons,
  BitBtnLockedIncrem, ExtCtrls,  Math;

type
  TfrmFormulacaoAutomotivaDupont = class(TfrmFormulacaoAutomotiva)
  private
    { Private declarations }
  public
    procedure pRecalculaFormula(blnPadrao: Boolean); override;
    { Public declarations }
  end;

var
  frmFormulacaoAutomotivaDupont: TfrmFormulacaoAutomotivaDupont;

implementation

uses
  untFuncoesSimples, untTintaMaquina,untFuncEspecificas;

{$R *.dfm}

procedure TfrmFormulacaoAutomotivaDupont.pRecalculaFormula(blnPadrao: Boolean);
var
  intCont : Integer;
  objBase: TBaseAutomotiva;
  strTipBas: String;
  fltFator: Double;

  strCodIte: String;
  strCodBasRet: String;
  strDesBas: String;
  intDec: Integer;

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
  intDec := StrToIntDef(fGetConfTinta('DUP').fGet('DECFOR'), 1);

  If objFormula.fltVolumeOri > 0 Then
    fltFator := objFormula.fltVolumePro / objFormula.fltVolumeOri
  Else
    fltFator := 1;

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

        SubItems.Add(FloatToStrF(RoundTo(objBase.fltQtdCon, - intDec), ffFixed, 12, 3));
        SubItems.Add(FloatToStrF(RoundTo(objBase.fltQtdDil, - intDec), ffFixed, 12, 3));
        SubItems.Add(FloatToStrF(RoundTo(objBase.fltQtdDi2, - intDec), ffFixed, 12, 3));
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

        SubItems.Add(FloatToStrF(RoundTo(objBase.fltQtdCon * fltFator, -intDec), ffFixed, 12, 3));
        SubItems.Add(FloatToStrF(RoundTo(objBase.fltQtdDil * fltFator, -intDec), ffFixed, 12, 3));
        SubItems.Add(FloatToStrF(RoundTo(objBase.fltQtdDi2 * fltFator, -intDec), ffFixed, 12, 3));
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
