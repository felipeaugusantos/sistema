unit untFormulacaoAutomotiva;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, ComCtrls,
  untFuncEspecificas, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmFormulacaoAutomotiva = class(TfrmPai)
    lsvFormulacao: TListView;
    pnlRodape: TPanel;
    memCalculo: TMemo;
    Label1: TLabel;
    btnFmlDes: TSpeedButton;
    btnFmlPad: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure btnFmlPadClick(Sender: TObject);
    procedure btnFmlDesClick(Sender: TObject);
    procedure lsvFormulacaoAdvancedCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage;
      var DefaultDraw: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    objFormula: TFormulaAutomotiva;

    {*****************************************}
    {* ESTA VARIÁVEL SERÁ UTILIZADA EM CASOS *}
    {* ONDE SERÁ NECESSÁRIO MOSTRAR UMA QTD  *}
    {* DIFERENTE DO QUE ESTÁ NA TABELA.      *}
    {**************************************MV*}
    objFormulaQtdEsp: TFormulaAutomotiva;

    intDecimaisPrecoVenda: Integer;
    intDecimaisPesoEspecifico: Integer;

    strIdePro: String;
    blnConsLinhaDesBas: Boolean;

    procedure pRecalculaFormula(blnPadrao: Boolean); virtual;
  end;

var
  frmFormulacaoAutomotiva: TfrmFormulacaoAutomotiva;

implementation

uses untFuncoesSimples, untTintaMaquina;

{$R *.dfm}

procedure TfrmFormulacaoAutomotiva.FormCreate(Sender: TObject);
begin
  inherited;
  strIdePro := '';
  blnConsLinhaDesBas := False;

  intDecimaisPrecoVenda     := 6;
  intDecimaisPesoEspecifico := 4;
end;

procedure TfrmFormulacaoAutomotiva.FormShow(Sender: TObject);
begin
  inherited;
  pRecalculaFormula(True);
end;

procedure TfrmFormulacaoAutomotiva.pRecalculaFormula(blnPadrao: Boolean);
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

        //Utilizado somente para Salcomix e Glasurit
        If ((objBase.fltQtdPCo > 0) Or (objBase.fltQtdPDi > 0)) Then
        Begin
          SubItems.Add(FloatToStrF(objBase.fltQtdPCo, ffFixed, 12, 3));
          SubItems.Add(FloatToStrF(objBase.fltQtdPDi, ffFixed, 12, 3));
          SubItems.Add(FloatToStrF(objBase.fltQtdDi2, ffFixed, 12, 3));
          SubItems.Add(FloatToStrF(objBase.fltPreVen, ffFixed, 12, intDecimaisPrecoVenda));
          SubItems.Add(FloatToStrF(objBase.fltEmbala, ffFixed, 12, 4));
          SubItems.Add(FloatToStrF(objBase.fltPesEsp, ffFixed, 12, intDecimaisPesoEspecifico));
        End
        Else
        Begin
          SubItems.Add(FloatToStrF(objBase.fltQtdCon, ffFixed, 12, objFormula.fCasasDecimaisFormulacao));
          SubItems.Add(FloatToStrF(objBase.fltQtdDil, ffFixed, 12, objFormula.fCasasDecimaisFormulacao));
          SubItems.Add(FloatToStrF(objBase.fltQtdDi2, ffFixed, 12, objFormula.fCasasDecimaisFormulacao));
          SubItems.Add(FloatToStrF(objBase.fltPreVen, ffFixed, 12, intDecimaisPrecoVenda));
          SubItems.Add(FloatToStrF(objBase.fltEmbala, ffFixed, 12, 4));
          SubItems.Add(FloatToStrF(objBase.fltPesEsp, ffFixed, 12, intDecimaisPesoEspecifico));
        End;
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

        //Utilizado somente para Salcomix e Glasurit
        If ((objBase.fltQtdPCo > 0) Or (objBase.fltQtdPDi > 0)) Then
        Begin
          SubItems.Add(FloatToStrF(objBase.fltQtdCon, ffFixed, 12, 3));
          SubItems.Add(FloatToStrF(objBase.fltQtdDil, ffFixed, 12, 3));
          SubItems.Add(FloatToStrF(objBase.fltQtdDi2, ffFixed, 12, 3));
          SubItems.Add(FloatToStrF(objBase.fltPreVen, ffFixed, 12, intDecimaisPrecoVenda));
          SubItems.Add(FloatToStrF(objBase.fltEmbala, ffFixed, 12, 4));
          SubItems.Add(FloatToStrF(objBase.fltPesEsp, ffFixed, 12, intDecimaisPesoEspecifico));
        End
        Else
        Begin
          SubItems.Add(FloatToStrF(objBase.fltQtdCon * fltFator, ffFixed, 12, objFormula.fCasasDecimaisFormulacao));
          SubItems.Add(FloatToStrF(objBase.fltQtdDil * fltFator, ffFixed, 12, objFormula.fCasasDecimaisFormulacao));
          SubItems.Add(FloatToStrF(objBase.fltQtdDi2 * fltFator, ffFixed, 12, objFormula.fCasasDecimaisFormulacao));
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

procedure TfrmFormulacaoAutomotiva.btnFmlPadClick(Sender: TObject);
begin
  inherited;
  pRecalculaFormula(True);
end;

procedure TfrmFormulacaoAutomotiva.btnFmlDesClick(Sender: TObject);
begin
  inherited;
  pRecalculaFormula(False);
end;

procedure TfrmFormulacaoAutomotiva.lsvFormulacaoAdvancedCustomDrawItem(
  Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  Stage: TCustomDrawStage; var DefaultDraw: Boolean);
begin
  inherited;

  If btnFmlPad.Down Then
  Begin
    If ((Item.Index mod 2) = 0) Then
    Begin
      Sender.Canvas.Brush.Color := $00FFFFBF; //azul
    End
    Else
    Begin
      Sender.Canvas.Brush.Color := clWindow; //verde
    End;
  End
  Else
  Begin
    If ((Item.Index mod 2) = 0) Then
    Begin
      Sender.Canvas.Brush.Color := $00BFFFBF; //verde
    End
    Else
    Begin
      Sender.Canvas.Brush.Color := clWindow;
    End;
  End;



  Sender.Canvas.Font.Color := clBlack;
end;

end.

