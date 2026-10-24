{*************************************************************}
{* Tela onde é exibida a formulação de uma tinta imobiliária *}
{**********************************************************PH*}
unit untFormulacaoImobiliaria;

interface

uses
  SysUtils, Classes, Controls, Forms,
  untPai, StdCtrls, ExtCtrls, ComCtrls,
  untAbstractFormulaImobiliaria, AppEvnts,
  Buttons, BitBtnLockedIncrem;

type
  TfrmFormulacaoImobiliaria = class(TfrmPai)
    lsvFormulacao: TListView;
    pnlRodape: TPanel;
    memCalculo: TMemo;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    formula: TAbstractFormulaImobiliaria;
  end;

var
  frmFormulacaoImobiliaria: TfrmFormulacaoImobiliaria;

implementation

uses
  untColorante;

{$R *.dfm}

procedure TfrmFormulacaoImobiliaria.FormShow(Sender: TObject);
  Var
    colorante: TColorante;
    intContador: Integer;
begin
  inherited;

  For intContador := 0 To formula.Count-1 Do
  Begin
    colorante := TColorante(formula.Items[intContador]);

    With lsvFormulacao.Items.Add Do
    Begin
      Caption := colorante.CodigoColorante;
      SubItems.Add(FloatToStrF(colorante.Quantidade, ffFixed, 12, 3));
      SubItems.Add(FloatToStrF(colorante.PrecoVenda, ffFixed, 12, 6));
    End;

  End;

  memCalculo.Lines.Clear;
  memCalculo.Lines.Assign(formula.TextoInformativoCalculo);
end;

end.
