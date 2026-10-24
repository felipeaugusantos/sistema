unit untFormulacaoImobiliariaAdvanced;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untFormulacaoImobiliaria, AppEvnts, Menus, StdCtrls, ComCtrls,
  Buttons, ExtCtrls;

type
  TfrmFormulacaoImobiliariaAdvanced = class(TfrmFormulacaoImobiliaria)
    procedure FormShow(Sender: TObject);
    procedure lsvFormulacaoAdvancedCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage;
      var DefaultDraw: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFormulacaoImobiliariaAdvanced: TfrmFormulacaoImobiliariaAdvanced;

implementation

uses untFuncEspecificas, StrUtils;

{$R *.dfm}

procedure TfrmFormulacaoImobiliariaAdvanced.FormShow(Sender: TObject);
  Var
    objColorante: TComponenteIndustrial;
    intContador: Integer;
begin
  For intContador := 0 To objFormula.Count-1 Do
  Begin

    objColorante := TComponenteIndustrial(objFormula.Items[intContador]);

    With lsvFormulacao.Items.Add Do
    Begin
      Caption := IfThen(objColorante.strTipComp = 'C', 'Colorante', 'Resina');
      SubItems.Add(objColorante.strCodCol);
      SubItems.Add(FloatToStrF(objColorante.fltQtdCol, ffFixed, 12, 3));
      SubItems.Add(FloatToStrF(objColorante.fltPreVen, ffFixed, 12, 6));
    End;

  End;

  memCalculo.Lines.Clear;
  memCalculo.Lines.Assign(objFormula.stlCalculo);

end;

procedure TfrmFormulacaoImobiliariaAdvanced.lsvFormulacaoAdvancedCustomDrawItem(
  Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  Stage: TCustomDrawStage; var DefaultDraw: Boolean);
begin
  inherited;

  If TComponenteIndustrial(objFormula.Items[Item.Index]).strTipComp = 'B' Then
  Begin
      Sender.Canvas.Brush.Color := $00CAFFFF;
  End
  Else If ((Item.Index mod 2) = 0) Then
  Begin
    Sender.Canvas.Brush.Color := $00DFFFDF; //verde claro
  End
  Else
  Begin
    Sender.Canvas.Brush.Color := clWindow; //verde
  End;
end;

end.
