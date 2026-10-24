unit untFormulacaoAutomotiva;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Menus, AppEvnts, StdCtrls, Buttons,
  BitBtnLockedIncrem, ExtCtrls, ComCtrls, untAbstractFormulaAutomotiva,
  untBaseAutomotiva, untFloatUtils, untStrUtils, untAutcomTintaFactory,
  untIConfTinta, Math;

type
  TfrmFormulacaoAutomotiva = class(TfrmPai)
    btnFmlPad: TSpeedButton;
    btnFmlDes: TSpeedButton;
    lsvFormulacao: TListView;
    pnlRodape: TPanel;
    Label1: TLabel;
    memCalculo: TMemo;
    procedure FormShow(Sender: TObject);
    procedure btnFmlDesClick(Sender: TObject);
    procedure btnFmlPadClick(Sender: TObject);
    procedure lsvFormulacaoAdvancedCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage;
      var DefaultDraw: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    conf: IConfTinta;
  public
    { Public declarations }
    Formula: TAbstractFormulaAutomotiva;
    FormulaQtdEsp: TAbstractFormulaAutomotiva;

    intDecimaisPrecoVenda: Integer;
    intDecimaisPesoEspecifico: Integer;

    blnConsLinhaDesBas: Boolean;

    procedure pRecalculaFormula(blnPadrao: Boolean); virtual;
  end;

var
  frmFormulacaoAutomotiva: TfrmFormulacaoAutomotiva;

implementation

{$R *.dfm}

{ TfrmFormulacaoAutomotiva }

procedure TfrmFormulacaoAutomotiva.btnFmlDesClick(Sender: TObject);
begin
  inherited;
  pRecalculaFormula(False);
end;

procedure TfrmFormulacaoAutomotiva.btnFmlPadClick(Sender: TObject);
begin
  inherited;
  pRecalculaFormula(True);
end;

procedure TfrmFormulacaoAutomotiva.FormCreate(Sender: TObject);
begin
  inherited;
  blnConsLinhaDesBas := False;

  intDecimaisPrecoVenda     := 6;
  intDecimaisPesoEspecifico := 4;
end;

procedure TfrmFormulacaoAutomotiva.FormShow(Sender: TObject);
var
  intCont : Integer;
begin
  inherited;
  conf := TAutcomTintaFactory.Get.fGetConfTinta(Formula.GetIdePro);
  Formula.pReajustarColunasFormulacao(lsvFormulacao); // Reajusta as colunas

  pRecalculaFormula(True);

  if Formula.GetIdePro = 'LAZ' then
  begin
    For intCont := 0 to lsvFormulacao.Columns.Count - 1 do
    begin
      if lsvFormulacao.Column[intCont].Caption = 'Peso Esp.' then
      begin
        lsvFormulacao.Columns.Delete(intCont);
        lsvFormulacao.Refresh;
        Break;
      end;
    end;
  end;


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

procedure TfrmFormulacaoAutomotiva.pRecalculaFormula(blnPadrao: Boolean);
var
  intCont : Integer;
  Base: TBaseAutomotiva;
  strTipBas: String;
  fltFator: Double;
//  intDec: Integer;
  strLinha: String;

begin
  frmFormulacaoAutomotiva.ClientWidth := Formula.fDefiniTamTelaFormulacao;  //Aumenta o tamanho do fórmulario

  If Formula.VolumeOri > 0 Then
    fltFator := Formula.VolumePro / Formula.VolumeOri
  Else
    fltFator := 1;

  If Formula.fVolumeOriginalFator Then
    fltFator := fltFator * 1000;

  //Color pro
  Base := TBaseAutomotiva(Formula.Items[0]);
  strLinha := Base.LinhaBase;

  lsvFormulacao.Clear;


  For intCont := 0 To Formula.Count-1 Do
  Begin

    If Assigned(FormulaQtdEsp) Then
      Base := TBaseAutomotiva(FormulaQtdEsp.Items[intCont])
    Else
      Base := TBaseAutomotiva(Formula.Items[intCont]);

    If (Base.TipoBase = 'C') And (Not Formula.ComCatalisador) Then
      Continue;

    If Base.TipoBase = 'B' Then
      strTipBas := 'BASE'
    Else If Base.TipoBase = 'C' Then
      strTipBas := 'CATALISADOR'
    Else If Base.TipoBase = 'CO' Then
      strTipBas := 'COLORANTE'
    Else If Base.TipoBase = 'CA' Then
      strTipBas := 'CATALISADOR'
    Else
      strTipBas := 'DILUENTE';

    If (blnPadrao) Then
    Begin
      Formula.pRecalculaFormulaMostrarPadrao(lsvFormulacao, Base,
        intDecimaisPrecoVenda, intDecimaisPesoEspecifico, blnConsLinhaDesBas,
        strTipBas, intCont);
    end
    Else
    Begin
      Formula.pRecalculaFormulaMostrarDigitado(lsvFormulacao, Base,
        intDecimaisPrecoVenda, intDecimaisPesoEspecifico, fltFator,
        blnConsLinhaDesBas, intCont, strLinha, strTipBas);
    end;
  End;

  memCalculo.Lines.Clear;
  memCalculo.Lines.Assign(formula.TextoInformativoCalculo);
end;

end.
