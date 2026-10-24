unit untFormulacaoAutomotivaWanPro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untFormulacaoAutomotiva, AppEvnts, Menus, StdCtrls, ComCtrls,
  Buttons, BitBtnLockedIncrem, ExtCtrls, Math,  Uni;

type
  TfrmFormulacaoAutomotivaWanPro = class(TfrmFormulacaoAutomotiva)
  private
    { Private declarations }
  public
    { Public declarations }
    procedure pRecalculaFormula(blnPadrao: Boolean); override;
  end;

var
  frmFormulacaoAutomotivaWanPro: TfrmFormulacaoAutomotivaWanPro;

implementation

uses untTintaMaquina, untFuncoesSimples,  untWandaPro,untFuncEspecificas;

{$R *.dfm}

{ TfrmFormulacaoAutomotiva1 }

procedure TfrmFormulacaoAutomotivaWanPro.pRecalculaFormula(blnPadrao: Boolean);
var
  intCont : Integer;
  objBase: TBaseAutomotiva;
  strTipBas: String;
  fltFator: Double;
  strLinha: String;

  strCodIte: String;
  strCodBasRet: String;
  strDesBas: String;

  fltQtdDil: Double;
  fltQtdDi2: Double;
  fltQtdCon: Double;

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
  lsvFormulacao.Clear;

  If (blnPadrao) Then
  Begin

    For intCont := 0 To objFormula.Count-1 Do
    Begin
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
        SubItems.Add(FloatToStrF(objBase.fltQtdCon, ffFixed, 12, 1));
        SubItems.Add(FloatToStrF(objBase.fltQtdDil, ffFixed, 12, 1));
        SubItems.Add(FloatToStrF(objBase.fltQtdDi2, ffFixed, 12, 1));
        SubItems.Add(FloatToStrF(objBase.fltPreVen, ffFixed, 12, intDecimaisPrecoVenda));
        SubItems.Add(FloatToStrF(objBase.fltEmbala, ffFixed, 12, 4));
        SubItems.Add(FloatToStrF(objBase.fltPesEsp, ffFixed, 12, intDecimaisPesoEspecifico));
      End;

    End;
  End
  Else
  Begin
    objBase := TBaseAutomotiva(objFormula.Items[0]);
    strLinha := objBase.strLinBas;

    {*******************************************}
    {* REALIZA CÁLCULO DAS LINHAS:             *}
    {* AUTOBASE PLUS 100:50                    *}
    {* WANDABASE HS                            *}
    {* AUTOBASE PLUS 100:80                    *}
    {****************************************NC*}
    If (Pos(fStrZero(strLinha, 2), '04_01_14_') > 0) And (Copy(objFormula.strCodFormul,1,3) <> 'ESP') Then
    Begin

      For intCont := 0 To objFormula.Count -1 Do
      Begin
        objBase := TBaseAutomotiva(objFormula.Items[intCont]);

        If (objBase.strTipBas = 'C') And (Not objFormula.blnComCatalisador) Then
          Continue;

        If objBase.strTipBas = 'B' Then
          strTipBas := 'BASE'
        Else If objBase.strTipBas = 'C' Then
          strTipBas := 'CATALISADOR'
        Else
          strTipBas := 'DILUENTE';

        fltQtdCon := fCalculoA(objFormula, 'CON', intCont, strLinha);
        fltQtdDil := fCalculoA(objFormula, 'DIL', intCont, strLinha);
        fltQtdDi2 := 0;

        With lsvFormulacao.Items.Add Do
        Begin
          Caption := fDescricaoBase(IIF(blnConsLinhaDesBas, objBase.strLinBas + '_', '') + objBase.strCodBas);
          SubItems.Add(strTipBas);
          SubItems.Add(FloatToStrF(fltQtdCon, ffFixed, 12, 1));
          SubItems.Add(FloatToStrF(fltQtdDil, ffFixed, 12, 1));
          SubItems.Add(FloatToStrF(fltQtdDi2, ffFixed, 12, 1));
          SubItems.Add(FloatToStrF(objBase.fltPreVen, ffFixed, 12, intDecimaisPrecoVenda));
          SubItems.Add(FloatToStrF(objBase.fltEmbala, ffFixed, 12, 4));
          SubItems.Add(FloatToStrF(objBase.fltPesEsp, ffFixed, 12, intDecimaisPesoEspecifico));
        End;
      End;

    End
    {*******************************************}
    {* REALIZA CÁLCULO DAS LINHAS:             *}
    {* WANDA PU HS                             *}
    {* AUTOCOAT BT100                          *}
    {* WANDA PU MS                             *}
    {****************************************NC*}
    Else If (Pos(fStrZero(strLinha, 2), '08_13_58_') > 0) And (Copy(objFormula.strCodFormul,1,3) <> 'ESP') Then
    Begin
      For intCont := 0 To objFormula.Count -1 Do
      Begin
        objBase := TBaseAutomotiva(objFormula.Items[intCont]);

        If (objBase.strTipBas = 'C') And (Not objFormula.blnComCatalisador) Then
          Continue;

        If objBase.strTipBas = 'B' Then
          strTipBas := 'BASE'
        Else If objBase.strTipBas = 'C' Then
          strTipBas := 'CATALISADOR'
        Else
          strTipBas := 'DILUENTE';

        If (Pos(fStrZero(strLinha, 2), '08_') > 0) Then
        Begin
          fltQtdCon := fCalculoBLinha08(objFormula, 'CON', intCont);
          fltQtdDil := fCalculoBLinha08(objFormula, 'DIL', intCont);
          fltQtdDi2 := fCalculoBLinha08(objFormula, 'DI2', intCont);
        End
        Else
        Begin
          fltQtdCon := fCalculoB(objFormula, 'CON', intCont, strLinha);
          fltQtdDil := fCalculoB(objFormula, 'DIL', intCont, strLinha);
          fltQtdDi2 := fCalculoB(objFormula, 'DI2', intCont, strLinha);
        End;

        With lsvFormulacao.Items.Add Do
        Begin
          Caption := fDescricaoBase(IIF(blnConsLinhaDesBas, objBase.strLinBas + '_', '') + objBase.strCodBas);
          SubItems.Add(strTipBas);
          SubItems.Add(FloatToStrF(fltQtdCon, ffFixed, 12, 1));
          If objFormula.intIndiceAdicional = -1 Then
          Begin
            SubItems.Add(FloatToStrF(0, ffFixed, 12, 1));
            SubItems.Add(FloatToStrF(0, ffFixed, 12, 1));
          End
          Else If (objFormula.intIndiceAdicional = 0) And ((Pos(fStrZero(strLinha, 2), '58') > 0)) Then
          Begin
            SubItems.Add(FloatToStrF(0, ffFixed, 12, 1));
            SubItems.Add(FloatToStrF(fltQtdDi2, ffFixed, 12, 1));
          End
          Else If objFormula.intIndiceAdicional = 0 Then
          Begin
            SubItems.Add(FloatToStrF(fltQtdDil, ffFixed, 12, 1));
            SubItems.Add(FloatToStrF(0, ffFixed, 12, 1));
          End
          Else
          Begin
            SubItems.Add(FloatToStrF(0, ffFixed, 12, 1));
            SubItems.Add(FloatToStrF(fltQtdDi2, ffFixed, 12, 1));
          End;
          SubItems.Add(FloatToStrF(objBase.fltPreVen, ffFixed, 12, intDecimaisPrecoVenda));
          SubItems.Add(FloatToStrF(objBase.fltEmbala, ffFixed, 12, 4));
          SubItems.Add(FloatToStrF(objBase.fltPesEsp, ffFixed, 12, intDecimaisPesoEspecifico));
        End;
      End;
    End
    {*******************************************}
    {* REALIZA CÁLCULO DA LINHA:               *}
    {* SINGLE STAGE CONVERTER                  *}
    {****************************************NC*}
    Else If (Pos(fStrZero(strLinha, 2), '11_') > 0) And (Copy(objFormula.strCodFormul,1,3) <> 'ESP') Then
    Begin

      For intCont := 0 To objFormula.Count -1 Do
      Begin
        objBase := TBaseAutomotiva(objFormula.Items[intCont]);

        If (objBase.strTipBas = 'C') And (Not objFormula.blnComCatalisador) Then
          Continue;

        If objBase.strTipBas = 'B' Then
          strTipBas := 'BASE'
        Else If objBase.strTipBas = 'C' Then
          strTipBas := 'CATALISADOR'
        Else
          strTipBas := 'DILUENTE';

        fltQtdCon := fCalculoC(objFormula, intCont);

        With lsvFormulacao.Items.Add Do
        Begin
          Caption := fDescricaoBase(IIF(blnConsLinhaDesBas, objBase.strLinBas + '_', '') + objBase.strCodBas);
          SubItems.Add(strTipBas);
          SubItems.Add(FloatToStrF(fltQtdCon, ffFixed, 12, 1));
          SubItems.Add(FloatToStrF(0, ffFixed, 12, 1));
          SubItems.Add(FloatToStrF(0, ffFixed, 12, 1));
          SubItems.Add(FloatToStrF(objBase.fltPreVen, ffFixed, 12, intDecimaisPrecoVenda));
          SubItems.Add(FloatToStrF(objBase.fltEmbala, ffFixed, 12, 4));
          SubItems.Add(FloatToStrF(objBase.fltPesEsp, ffFixed, 12, intDecimaisPesoEspecifico));
        End;
      End;
    End
    Else If (Pos(fStrZero(strLinha, 2), '27_09_06_') > 0) And (Copy(objFormula.strCodFormul,1,3) <> 'ESP') Then
    Begin
      For intCont := 0 To objFormula.Count-1 Do
      Begin
        objBase := TBaseAutomotiva(objFormula.Items[intCont]);

        If (objBase.strTipBas = 'C') And (Not objFormula.blnComCatalisador) Then
          Continue;

        If objBase.strTipBas = 'B' Then
          strTipBas := 'BASE'
        Else If objBase.strTipBas = 'C' Then
          strTipBas := 'CATALISADOR'
        Else
          strTipBas := 'DILUENTE';

        fltQtdCon := fCalculoA(objFormula, 'CON', intCont, strLinha);
        With lsvFormulacao.Items.Add Do
        Begin
          Caption := fDescricaoBase(IIF(blnConsLinhaDesBas, objBase.strLinBas + '_', '') + objBase.strCodBas);
          SubItems.Add(strTipBas);
          SubItems.Add(FloatToStrF(fltQtdCon, ffFixed, 12, 1));
          SubItems.Add(FloatToStrF(0, ffFixed, 12, 1));
          SubItems.Add(FloatToStrF(0, ffFixed, 12, 1));
          SubItems.Add(FloatToStrF(objBase.fltPreVen, ffFixed, 12, intDecimaisPrecoVenda));
          SubItems.Add(FloatToStrF(objBase.fltEmbala, ffFixed, 12, 4));
          SubItems.Add(FloatToStrF(objBase.fltPesEsp, ffFixed, 12, intDecimaisPesoEspecifico));
        End;

      End;
    End
    Else
    Begin
      If objFormula.fltVolumeOri > 0 Then
        fltFator := objFormula.fltVolumePro / objFormula.fltVolumeOri
      Else
        fltFator := 1;

      If objFormula.fltVolumeOri > 1 Then
        fltFator := fltFator * 1000;

      For intCont := 0 To objFormula.Count-1 Do
      Begin
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
          SubItems.Add(FloatToStrF(objBase.fltQtdCon * fltFator, ffFixed, 12, 1));
          SubItems.Add(FloatToStrF(objBase.fltQtdDil * fltFator, ffFixed, 12, 1));
          SubItems.Add(FloatToStrF(objBase.fltQtdDi2 * fltFator, ffFixed, 12, 1));
          SubItems.Add(FloatToStrF(objBase.fltPreVen, ffFixed, 12, intDecimaisPrecoVenda));
          SubItems.Add(FloatToStrF(objBase.fltEmbala, ffFixed, 12, 4));
          SubItems.Add(FloatToStrF(objBase.fltPesEsp, ffFixed, 12, intDecimaisPesoEspecifico));
        End;

      End;
    End;
  End;

  memCalculo.Lines.Clear;
  memCalculo.Lines.Assign(objFormula.stlCalculo);
end;

end.
