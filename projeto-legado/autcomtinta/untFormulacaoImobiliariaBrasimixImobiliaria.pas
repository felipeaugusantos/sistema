unit untFormulacaoImobiliariaBrasimixImobiliaria;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untFormulacaoImobiliaria, AppEvnts, Menus, StdCtrls, ComCtrls, Buttons, ExtCtrls,
   BitBtnLockedIncrem;

type
  TfrmFormulacaoImobiliariaBrasimixImobiliaria = class(TfrmFormulacaoImobiliaria)
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFormulacaoImobiliariaBrasimixImobiliaria: TfrmFormulacaoImobiliariaBrasimixImobiliaria;

implementation
uses untFuncEspecificas;
{$R *.dfm}

procedure TfrmFormulacaoImobiliariaBrasimixImobiliaria.FormShow(Sender: TObject);
Var
    objColorante: TColoranteImobiliario;
    intContador: Integer;
begin
  For intContador := 0 To objFormula.Count-1 Do
  Begin

    If Assigned(objFormulaEsp) Then
      objColorante := TColoranteImobiliario(objFormulaEsp.Items[intContador])
    Else
      objColorante := TColoranteImobiliario(objFormula.Items[intContador]);

    With lsvFormulacao.Items.Add Do
    Begin
      Caption := objColorante.strCodCol;
      SubItems.Add(FloatToStrF(objColorante.fltQtdCol, ffFixed, 12, 3));
      SubItems.Add(FloatToStrF(objColorante.fltPreVen, ffFixed, 12, 6));
      SubItems.Add(FloatToStrF(objColorante.fltPesEsp, ffFixed, 12, 4))
    End;

  End;

  memCalculo.Lines.Clear;
  memCalculo.Lines.Assign(objFormula.stlCalculo);
end;

end.
