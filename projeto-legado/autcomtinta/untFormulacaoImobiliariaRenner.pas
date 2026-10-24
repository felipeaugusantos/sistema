unit untFormulacaoImobiliariaRenner;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untFormulacaoImobiliaria, AppEvnts, Menus, StdCtrls, ComCtrls,
  Buttons, ExtCtrls, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmFormulacaoImobiliariaRenner = class(TfrmFormulacaoImobiliaria)
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFormulacaoImobiliariaRenner: TfrmFormulacaoImobiliariaRenner;

implementation

uses untFuncEspecificas, untFuncoesSimples, untTintaMaquina;

{$R *.dfm}

procedure TfrmFormulacaoImobiliariaRenner.FormShow(Sender: TObject);
var
  objColorante: TColoranteImobiliario;
  intContador: Integer;
  fltCalculo: Double;
  fltInteiroOnca: Integer;
  fltFracaoOnca: Double;
  strOnca: string;

  strDesCol: String;
  strCodIte: String;
  strCodColRet: String;

  function fDescricaoColorante(strCodCol: String): String;
  begin
    Result := strCodCol;

    If (Not fEmptyStr(strIdePro)) Then
    Begin
      pRetItemEDescricaoColorante(strIdePro, strCodCol, strCodIte, strCodColRet, strDesCol, VS_strCodEmp);

      If (Not fEmptyStr(strDesCol)) Then
      Begin
        Result := Result + '-' + strDesCol;
      End;
    End;
  end;

begin
  For intContador := 0 To objFormula.Count-1 Do
  Begin

    objColorante := TColoranteImobiliario(objFormula.Items[intContador]);

    With lsvFormulacao.Items.Add Do
    Begin
      Caption := fDescricaoColorante(objColorante.strCodCol);
      fltCalculo := (objColorante.fltQtdCol / 48) / 0.61611520;
      fltInteiroOnca := Trunc(fltCalculo);
      fltFracaoOnca := fStrToFloat(FormatFloat('0.000', (fltCalculo - fltInteiroOnca) * 48));

      strOnca := Format('%dY%.1f', [Trunc(fltInteiroOnca), fltFracaoOnca]);
      SubItems.Add(strOnca);
      SubItems.Add(FloatToStrF(objColorante.fltPreVen, ffFixed, 12, 6));
    End;

  End;

  memCalculo.Lines.Clear;
  memCalculo.Lines.Assign(objFormula.stlCalculo);
end;

end.
