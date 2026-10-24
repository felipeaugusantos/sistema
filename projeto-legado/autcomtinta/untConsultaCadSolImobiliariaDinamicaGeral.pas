unit untConsultaCadSolImobiliariaDinamicaGeral;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untConsultaComp, DB,  
  Uni, ExtCtrls, StdCtrls, ComCtrls, Buttons, Grids, DBGridCitel, DBGrids,
  BitBtnLockedIncrem, MemDS, DBAccess;

type
  TfrmConsultaCadSolbrazImobiliariaGeral = class(TfrmConsultaComp)
    procedure btnExecutaTarefaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConsultaCadSolbrazImobiliariaGeral: TfrmConsultaCadSolbrazImobiliariaGeral;

implementation

uses untFuncoesSimples,  untSolBrazImobiliariaDinamica;

{$R *.dfm}

procedure TfrmConsultaCadSolbrazImobiliariaGeral.btnExecutaTarefaClick(
  Sender: TObject);
  Var
    qryConsulta01: TUniQuery;
    strCodIte: String;
    strDesBas: String;
    strRefBas: String;
    strUniBas: String;
    strDesCor: String;
    fltPreCus: Double;
    fltUnitar: Double;

    dicParams: TDicionario;
begin
  inherited;

  If (Not qryConsulta.Active) Or (qryConsulta.IsEmpty) Then
    Exit;

  dicParams := TDicionario.Create;

  qryConsulta01 := fCriaQuery(Self);
  qryConsulta01.SQL.Add('SELECT * FROM SOL_CADSOL WHERE AUTOINCREM = :AUTINC');
  qryConsulta01.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
  qryConsulta01.Open;

  fDigDadosTintometricos(qryConsulta01, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')), strCodIte, strDesBas,
        strRefBas, strUniBas, strDesCor, fltPreCus, fltUnitar, dicParams);

  FreeAndNil(dicParams);
  FreeAndNil(qryConsulta01);
end;

end.
