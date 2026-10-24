unit untFormulacaoImobiliariaRecoa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untFormulacaoImobiliaria, AppEvnts, Menus, StdCtrls, ComCtrls,
  Buttons, ExtCtrls,  BitBtnLockedIncrem;

type
  TfrmFormulacaoImobiliariaRecoa = class(TfrmFormulacaoImobiliaria)
    procedure FormShow(Sender: TObject);
  private
    procedure MlParaOnca(fltMl: Double; var intParteInteira: Integer; var fltParteFracao: Double);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFormulacaoImobiliariaRecoa: TfrmFormulacaoImobiliariaRecoa;

implementation

uses untFuncEspecificas, untFuncoesSimples,untIConfTinta, untTintaMaquina;

{$R *.dfm}

procedure TfrmFormulacaoImobiliariaRecoa.FormShow(Sender: TObject);
  Var
    objColorante: TColoranteImobiliario;
    intContador: Integer;
    fltInteiroOnca: Integer;
    fltFracaoOnca: Double;
    strOnca: String;
begin
  For intContador := 0 To objFormula.Count-1 Do
  Begin

    objColorante := TColoranteImobiliario(objFormula.Items[intContador]);

    With lsvFormulacao.Items.Add Do
    Begin
      Caption := objColorante.strCodCol;
      MlParaOnca(objColorante.fltQtdCol, fltInteiroOnca, fltFracaoOnca);
      strOnca := Format('%dY%.3f', [Trunc(fltInteiroOnca), fltFracaoOnca]);
      SubItems.Add(strOnca);
      SubItems.Add(FloatToStrF(objColorante.fltPreVen, ffFixed, 12, 6));
    End;

  End;

  memCalculo.Lines.Clear;
  memCalculo.Lines.Assign(objFormula.stlCalculo);
end;

procedure TfrmFormulacaoImobiliariaRecoa.MlParaOnca(fltMl: Double; var intParteInteira: Integer; var fltParteFracao: Double);
var
  fltCalculo: Double;
begin
  fltCalculo := ((fltMl / 48) / 0.616125);
  intParteInteira := Trunc(fltCalculo);
  fltParteFracao := fStrToFloat(FormatFloat('0.000', (fltCalculo - intParteInteira) * 48));
end;

end.
