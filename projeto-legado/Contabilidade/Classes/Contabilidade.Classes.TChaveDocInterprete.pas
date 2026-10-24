unit Contabilidade.Classes.TChaveDocInterprete;

interface

uses Data.Db;

type
  IChaveDocInterprete = interface
    ['{BFE2932A-AECF-4C2C-865C-C225A403D017}']
    function getChave: string;
  end;

  TChaveDocInterprete = class(TInterfacedObject, IChaveDocInterprete)
  private
    FDataSet : TDataSet;
  public
    constructor Create(DataSet: TDataSet); reintroduce;
    class function New(DataSet: TDataSet): IChaveDocInterprete;
    function getChave: string;
  end;

implementation

{ TChaveDocInterprete }

constructor TChaveDocInterprete.Create(DataSet: TDataSet);
begin
  FDataSet := DataSet;
end;

function TChaveDocInterprete.getChave: string;
var
  LstrDoc: string ;
  LstrOpc: string ;
begin
  result := '';
  if Assigned(FDataSet.FindField('SEQGER')) then
    result := FDataSet.FieldByName('SEQGER').AsString
  else if Assigned(FDataSet.FindField('CARINC')) then
    result := FDataSet.FieldByName('CARINC').AsString
  else if Assigned(FDataSet.FindField('FISINC')) then
    result := FDataSet.FieldByName('FISINC').AsString
  else if Assigned(FDataSet.FindField('CHQINC')) then
    result := FDataSet.FieldByName('CHQINC').AsString
  else if Assigned(FDataSet.FindField('BANINC')) then
    result := FDataSet.FieldByName('BANINC').AsString
  else if Assigned(FDataSet.FindField('CTRINC')) then
    result := FDataSet.FieldByName('CTRINC').AsString
  else if Assigned(FDataSet.FindField('CTPINC')) then
    result := FDataSet.FieldByName('CTPINC').AsString
  else if Assigned(FDataSet.FindField('CMVINC')) then
    result := FDataSet.FieldByName('CMVINC').AsString
  else if Assigned(FDataSet.FindField('IMOINC')) then
    result := FDataSet.FieldByName('IMOINC').AsString
  else if Assigned(FDataSet.FindField('CPCINC')) then
    result := FDataSet.FieldByName('CPCINC').AsString
  else if Assigned(FDataSet.FindField('ANTINC')) then
    result := FDataSet.FieldByName('ANTINC').AsString
  else if Assigned(FDataSet.FindField('TCCINC')) then
  begin
    if FDataSet.FieldByName('TABELA').AsString = 'CADCHQ' then
    begin
      LstrOpc := 'C';
    end
    else // MOVCAR
    begin
      LstrOpc := 'M';
    end ;
    LstrDoc := copy(FDataSet.FieldByName('TCCINC').AsString, 1, 3) + LstrOpc + copy(FDataSet.FieldByName('TCCINC').AsString, 5, 16) ;
    result := LstrDoc ;
  end
  else if (Assigned(FDataSet.FindField('NUMDOC'))) and
          (Assigned(FDataSet.FindField('ESPDOC'))) and
          (Assigned(FDataSet.FindField('CODEMP'))) then
  begin
    result := FDataSet.FieldByName('NUMDOC').AsString +
              FDataSet.FieldByName('ESPDOC').AsString +
              FDataSet.FieldByName('CODEMP').AsString;
  end;
end;

class function TChaveDocInterprete.New(DataSet: TDataSet): IChaveDocInterprete;
begin
  result := Self.Create(DataSet);
end;

end.
