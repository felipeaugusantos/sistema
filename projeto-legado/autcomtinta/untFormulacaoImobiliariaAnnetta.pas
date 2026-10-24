unit untFormulacaoImobiliariaAnnetta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untFormulacaoImobiliaria, AppEvnts, Menus, StdCtrls, ComCtrls,
  Buttons, ExtCtrls, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmFormulacaoImobiliariaAnnetta = class(TfrmFormulacaoImobiliaria)
    procedure FormShow(Sender: TObject);
  private
    procedure MlParaOnca(fltMl: Double; var intParteInteira: Integer; var fltParteFracao: Double);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFormulacaoImobiliariaAnnetta: TfrmFormulacaoImobiliariaAnnetta;

implementation

uses untFuncEspecificas,
      untIConfTinta, untTintaMaquina, untFuncoesSimples;

{$R *.dfm}

procedure TfrmFormulacaoImobiliariaAnnetta.FormShow(Sender: TObject);
  Var
    objColorante: TColoranteImobiliario;
    intContador: Integer;
    fltInteiroOnca: Integer;
    fltFracaoOnca: Double;
    strOnca: String;

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
      MlParaOnca(objColorante.fltQtdCol, fltInteiroOnca, fltFracaoOnca);
      strOnca := Format('%dY%.2f', [Trunc(fltInteiroOnca), fltFracaoOnca]);
      SubItems.Add(strOnca);
      SubItems.Add(FloatToStrF(objColorante.fltPreVen, ffFixed, 12, 6));
    End;

  End;

  memCalculo.Lines.Clear;
  memCalculo.Lines.Assign(objFormula.stlCalculo);
end;

procedure TfrmFormulacaoImobiliariaAnnetta.MlParaOnca(fltMl: Double; var intParteInteira: Integer; var fltParteFracao: Double);
var
  fltCalculo: Double;
begin
  fltCalculo := ((fltMl / 48) / 0.61604);
  intParteInteira := Trunc(fltCalculo);
  fltParteFracao := fStrToFloat(FormatFloat('0.00', (fltCalculo - intParteInteira) * 48));
end;

end.
