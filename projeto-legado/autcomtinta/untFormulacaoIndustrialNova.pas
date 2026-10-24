unit untFormulacaoIndustrialNova;

interface

uses
  SysUtils, Classes, Controls, Forms, untFormulaIndustrial,
  untPai, StdCtrls, ExtCtrls,  ComCtrls, AppEvnts, Menus, Buttons, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmFormulacaoIndustrialNova = class(TfrmPai)
    lsvFormulacao: TListView;
    pnlRodape: TPanel;
    memCalculo: TMemo;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    formula: TFormulaIndustrial;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; const formula: TFormulaIndustrial); reintroduce;

  end;

var
  frmFormulacaoIndustrialNova: TfrmFormulacaoIndustrialNova;

implementation

{$R *.dfm}

constructor TfrmFormulacaoIndustrialNova.Create(AOwner: TComponent; const formula: TFormulaIndustrial);
begin
  inherited Create(AOwner);
  Self.formula := formula;
  Self.Caption := formula.Descricao;
end;

procedure TfrmFormulacaoIndustrialNova.FormShow(Sender: TObject);
var
  componente: TComponenteIndustrial;
  intContador: Integer;
begin
  inherited;

  For intContador := 0 To formula.Count-1 Do
  Begin

    componente := TComponenteIndustrial(formula.Items[intContador]);

    With lsvFormulacao.Items.Add Do
    Begin
      Caption := componente.CodigoComponente;
      SubItems.Add(FloatToStrF(componente.Quantidade * componente.PesoEspecifico, ffFixed, 12, 3));
      SubItems.Add(FloatToStrF(componente.Quantidade, ffFixed, 12, 3));
      SubItems.Add(FloatToStrF(componente.PrecoVenda , ffFixed, 12, 6));
    End;

  End;

  memCalculo.Lines.Clear;
  memCalculo.Text := formula.TextoCalculo;
end;

end.
