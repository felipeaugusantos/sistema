unit untConsultaCadDupGeral;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untConsultaComp, DB, 
   Uni, ExtCtrls, ComCtrls, Buttons, Grids,
  DBGridCitel, DBGrids, EditFocus, Mask, DBCtrls, DBEditFocus;

type
  TfrmConsultaCadDupGeral = class(TfrmConsultaComp)
    procedure btnExecutaTarefaClick(Sender: TObject);
  private
    { Private declarations }
  protected
  public
    { Public declarations }
  end;

var
  frmConsultaCadDupGeral: TfrmConsultaCadDupGeral;

implementation

uses untConsulta, untFuncoes, untFuncEspecificas, untFuncoesSimples,
  untDupont;

{$R *.dfm}

procedure TfrmConsultaCadDupGeral.btnExecutaTarefaClick(Sender: TObject);
  Var
    qryConsulta01: TUniQuery;
    stlDesEmb: TStringList;
    stlProEmbLt: TStringList;
    stlProEmbGl: TStringList;
    stlProEmbLa: TStringList;
    strProEmbCo: String;
    strProEmbSp: String;
    strProEmbSs: String;
    strProEmbPo: String;
    strProEmbDu: String;
    strProEmbBa: String;
    strProEmbTb: String;    
    strIteEmb: String;
    strTipEmb: String;
    strTipPre: String;
    intQtdEmb: Integer;
    fltPreEmb: Double;
    fltEmbala: Double;
    fltPreCus: Double;
    fltUnitar: Double;
    fltVolPro: Double;
    strCatali: String;
begin
  inherited;

  If (Not qryConsulta.Active) Or (qryConsulta.IsEmpty) Then
    Exit;

  qryConsulta01 := fCriaQuery(Self);
  qryConsulta01.SQL.Add('SELECT * FROM DUP_CADDUP WHERE AUTOINCREM = :AUTINC');
  qryConsulta01.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
  qryConsulta01.Open;

  stlDesEmb   := TStringList.Create;
  stlProEmbLt := TStringList.Create;
  stlProEmbGl := TStringList.Create;
  stlProEmbLa := TStringList.Create;

  stlDesEmb.Add('NORMAL');
  stlProEmbLt.Add(fArqIniTinta(0, 'DUPONT', 'ITE1_4', ''));
  stlProEmbGl.Add(fArqIniTinta(0, 'DUPONT', 'ITEGAL', ''));
  stlProEmbLa.Add(fArqIniTinta(0, 'DUPONT', 'ITELAT', ''));

  strProEmbCo := fArqIniTinta(0, 'DUPONT', 'ITECOP', '');
  strProEmbSp := fArqIniTinta(0, 'DUPONT', 'ITESPR', '');
  strProEmbSs := fArqIniTinta(0, 'DUPONT', 'ITESPS', '');
  strProEmbPo := fArqIniTinta(0, 'DUPONT', 'ITESPO', '');
  strProEmbDu := fArqIniTinta(0, 'DUPONT', 'ITESDU', '');
  strProEmbBa := fArqIniTinta(0, 'DUPONT', 'ITEBAL', '');
  strProEmbTb := fArqIniTinta(0, 'DUPONT', 'ITETAM', '');


  fDigDadosTintometricos(qryConsulta01, stlDesEmb, stlProEmbLt,
    stlProEmbGl, stlProEmbLa, strProEmbCo, strProEmbSp, strProEmbSs,
    strProEmbPo, strProEmbDu, strProEmbBa, strProEmbTb,
    strIteEmb, strTipEmb, strTipPre,
    intQtdEmb, fltPreEmb, fltEmbala, fltPreCus, fltUnitar, fltVolPro, '1', strCatali, TDicionario.Create);

  FreeAndNil(qryConsulta01);
end;

end.
