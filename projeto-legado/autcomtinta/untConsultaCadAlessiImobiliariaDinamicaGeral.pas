unit untConsultaCadAlessiImobiliariaDinamicaGeral;

interface

uses
  SysUtils, Classes, Controls, Forms,
  untConsultaComp, DB, 
   Uni, ExtCtrls, StdCtrls, ComCtrls, Buttons, BitBtnLockedIncrem, Grids, DBGridCitel, DBGrids,
  UniClientDataSet,  MemDS, DBAccess;

type
  TfrmConsultaCadAlessiImobiliariaDinamicaGeral = class(TfrmConsultaComp)
    procedure btnExecutaTarefaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConsultaCadAlessiImobiliariaDinamicaGeral: TfrmConsultaCadAlessiImobiliariaDinamicaGeral;

implementation

uses untFuncoesSimples, untAlessiImobiliariaDinamica,untClientDataSetFactory;

{$R *.dfm}

procedure TfrmConsultaCadAlessiImobiliariaDinamicaGeral.btnExecutaTarefaClick(
  Sender: TObject);
var
  qryConsulta: TUniQuery;

  fltPreCus: Double;
  fltUnitar: Double;
  strCodIte: String;
  strDesCor: String;
  strTabPre: String;
  strDesBas: String;
  strRefBas: String;
  strUniBas: String;
  cdsConsulta: TUniClientDataSet;
begin
  qryConsulta := nil;
  Try
    Try
      inherited;
      strTabPre := '1';

      If (Not qryConsulta.Active) Or (qryConsulta.IsEmpty) Then
        Exit;

      qryConsulta := fCriaQuery(Self);
      qryConsulta.SQL.Add('SELECT * FROM ALE_CADALE WHERE AUTOINCREM = :AUTINC');
      qryConsulta.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
      cdsConsulta := TClientDataSetFactory.GetClientDataSet(qryConsulta);

      If (Not fDigDadosTintometricos(cdsConsulta, strTabPre, strCodIte, strDesBas,
            strRefBas, strUniBas, strDesCor, fltPreCus, fltUnitar, TDicionario.Create)) Then
      Begin
        Exit;
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryConsulta) then FreeAndNil(qryConsulta);
  End;

end;

end.

