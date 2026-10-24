unit untFormulacaoImobiliariaEucatex;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untFormulacaoImobiliaria, AppEvnts, Menus, StdCtrls, ComCtrls,
  Buttons, ExtCtrls,  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmFormulacaoImobiliariaEucatex = class(TfrmFormulacaoImobiliaria)
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFormulacaoImobiliariaEucatex: TfrmFormulacaoImobiliariaEucatex;

implementation

uses untFuncEspecificas,untIConfTinta, untTintaMaquina;

{$R *.dfm}

procedure TfrmFormulacaoImobiliariaEucatex.FormShow(Sender: TObject);
  Var
    objColorante: TColoranteImobiliario;
    intContador: Integer;
    fltInteiroOnca: Double;
    fltFracaoOnca: Double;
    strOnca: String;
    conf: IConfTinta;
begin
  conf := fGetConfTinta('EUC');
  lsvFormulacao.Column[2].Caption := 'Preço';
  lsvFormulacao.Column[3].Free;
  For intContador := 0 To objFormula.Count-1 Do
  Begin

    objColorante := TColoranteImobiliario(objFormula.Items[intContador]);

    With lsvFormulacao.Items.Add Do
    Begin
      Caption := objColorante.strCodCol;

//      fltInteiroOnca := objColorante.fltQtdCol / 29.5735295625;
//      fltFracaoOnca := Frac(fltInteiroOnca) * 48.00;
//      strOnca := Format('(%.3f) %dY%.2f', [fltInteiroOnca, Trunc(fltInteiroOnca), fltFracaoOnca]);
      fltInteiroOnca := objColorante.fltQtdCol;
      fltFracaoOnca := Frac(fltInteiroOnca) * 48 / 100;
      strOnca := Format('%dY%.2f', [Trunc(fltInteiroOnca), fltFracaoOnca]);

//      If (fArqIniTinta(0, 'Eucatex Imobiliaria', 'EUCMAN', '') = 'S') Then
      If (conf.fGet('EUCMAN') = 'S') Then
        SubItems.Add(strOnca)
      Else
        SubItems.Add(FloatToStrF(objColorante.fltQtdCol, ffFixed, 12, 3));
        
      SubItems.Add(FloatToStrF(objColorante.fltPreVen, ffFixed, 12, 6));
    End;

  End;

  memCalculo.Lines.Clear;
  memCalculo.Lines.Assign(objFormula.stlCalculo);
end;

end.
