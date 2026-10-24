unit untFormulacaoImobiliaria;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, ComCtrls,
  untFuncEspecificas, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmFormulacaoImobiliaria = class(TfrmPai)
    lsvFormulacao: TListView;
    pnlRodape: TPanel;
    memCalculo: TMemo;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    objFormula: TFormulaImobiliaria;
    objFormulaEsp: TFormulaImobiliaria;
    strIdePro: String;
  end;

var
  frmFormulacaoImobiliaria: TfrmFormulacaoImobiliaria;

implementation

uses untFuncoesSimples, untTintaMaquina, untIConfTinta;

{$R *.dfm}

procedure TfrmFormulacaoImobiliaria.FormCreate(Sender: TObject);
begin
  inherited;
  strIdePro := '';
end;

procedure TfrmFormulacaoImobiliaria.FormShow(Sender: TObject);
  Var
    objColorante: TColoranteImobiliario;
    intContador: Integer;

    strCodIte   : String;
    strCodColRet: String;
    strDesCol   : String;

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
  inherited;


  For intContador := 0 To objFormula.Count-1 Do
  Begin

    If Assigned(objFormulaEsp) Then
      objColorante := TColoranteImobiliario(objFormulaEsp.Items[intContador])
    Else
      objColorante := TColoranteImobiliario(objFormula.Items[intContador]);

    With lsvFormulacao.Items.Add Do
    Begin
      Caption := fDescricaoColorante(objColorante.strCodCol);

      SubItems.Add(FloatToStrF(objColorante.fltQtdCol, ffFixed, 12, 3));

      SubItems.Add(FloatToStrF(objColorante.fltPreVen, ffFixed, 12, 6));
    End;

  End;

  memCalculo.Lines.Clear;
  memCalculo.Lines.Assign(objFormula.stlCalculo);
end;

end.
