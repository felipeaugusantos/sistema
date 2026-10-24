unit untMultiSelectLocalizador;

interface

uses
  Classes, untIMultiSelectLocalizador, SysUtils, untIDataSet;

type


  TMultiSelectLocalizador = class(TInterfacedObject, IMultiSelectLocalizador)
  private
    stlSqls: TStringList;
    function GetSqls(): TStringList;
  public
    constructor Create(); virtual;
    destructor Destroy; override;
    function Localizar(out cdsGen: IDataSet; const arrParametros: array of string; const arrValores: array of Variant): Boolean; virtual;
    property Sqls: TStringList read GetSqls;
  end;

  TMultiSelectLocalizadorClass = class of TMultiSelectLocalizador;

implementation

uses
  untAutcomTintaFactory;

type
  TMultiSelectLocalizadorStringList = class(TStringList)
  public
    function Add(const S: string): Integer; override;
  end;

{ TMultiSelectLocalizador }
constructor TMultiSelectLocalizador.Create();
begin
  inherited Create();
  stlSqls := nil;
end;

destructor TMultiSelectLocalizador.Destroy;
begin
  if Assigned(stlSqls) then FreeAndNil(stlSqls);
  inherited;
end;

function TMultiSelectLocalizador.GetSqls: TStringList;
begin
  if not Assigned(stlSqls) then
  begin
    stlSqls := TMultiSelectLocalizadorStringList.Create;
  end;
      
  Result := stlSqls;
end;

function TMultiSelectLocalizador.Localizar(out cdsGen: IDataSet; const arrParametros: array of string;
  const arrValores: array of Variant): Boolean;
var
  intSqls: Integer;
  intParametros: Integer;
begin
  Result := False;

  Try
    cdsGen := TAutcomTintaFactory.Get.fGetDataSet;
    for intSqls := 0 to GetSqls.Count - 1 do
    begin
      cdsGen.Close;
      cdsGen.SQL := GetSqls.Strings[intSqls];

      for intParametros := Low(arrParametros) to High(arrParametros) do
      begin
        cdsGen.ParamByName(arrParametros[intParametros]).Value := arrValores[intParametros];
      end;
      cdsGen.Open;

      Result := not cdsGen.IsEmpty;
      if Result then
        Exit;
    end;
  Except
    on E: Exception do
    begin
      raise;
    end;
  End;
end;

{ TMultiSelectLocalizadorStringList }

function TMultiSelectLocalizadorStringList.Add(const S: string): Integer;
begin
  Result := -1;
  if IndexOf(S) < 0 then
    Result := inherited Add(S);
end;

end.

