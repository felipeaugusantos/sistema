unit untExtratoBaseClass;

interface

uses Classes, SysUtils, Controls, System.Generics.Collections,
     StrUtils, Forms;

type
  TExtratoBancario = Class
  private
    FArquivo: String;
    FCodBco: String;
    FDataInicial: TDate;
    FDataFinal: TDate;
    FCodPor: String;
    FPeriodo: String;

  protected
    function GetArquivo: String;
    function GetCodBco: String;
    function GetDataInicial: TDate;
    function GetDataFinal: TDate;
    function GetCodPor: String;
    function GetPeriodo: String;

    procedure SetArquivo(const Value: String);
    procedure SetCodBco(const Value: String);
    procedure SetDataInicial(const Value: TDate);
    procedure SetDataFinal(const Value: TDate);
    procedure SetCodPor(const Value: String);
    procedure SetPeriodo(const Value: String);

  public
    constructor Create;

    property Arquivo: String     Read GetArquivo      Write SetArquivo;
    property CodBco: String      Read GetCodBco       Write SetCodBco;
    property DataInicial: TDate  Read GetDataInicial  Write SetDataInicial;
    property DataFinal: TDate    Read GetDataFinal    Write SetDataFinal;
    property CodPor: String      read GetCodPor       Write SetCodPor;
    property Periodo: String     read GetPeriodo      Write SetPeriodo;

  end;

implementation

{ TExtratoBancario }

constructor TExtratoBancario.Create;
begin
  inherited;

end;

function TExtratoBancario.GetArquivo: String;
begin
  Result := FArquivo;
end;

function TExtratoBancario.GetCodBco: String;
begin
  Result := FCodBco;
end;

function TExtratoBancario.GetCodPor: String;
begin
  Result := FCodPor;
end;

function TExtratoBancario.GetDataFinal: TDate;
begin
  Result := FDataFinal;
end;

function TExtratoBancario.GetDataInicial: TDate;
begin
  Result := FDataInicial;
end;

function TExtratoBancario.GetPeriodo: String;
begin
  Result := FPeriodo;
end;

procedure TExtratoBancario.SetArquivo(const Value: String);
begin
  FArquivo := Value;
end;

procedure TExtratoBancario.SetCodBco(const Value: String);
begin
  FCodBco := Value;
end;

procedure TExtratoBancario.SetCodPor(const Value: String);
begin
  FCodPor := Value;
end;

procedure TExtratoBancario.SetDataFinal(const Value: TDate);
begin
  FDataFinal := Value;
end;

procedure TExtratoBancario.SetDataInicial(const Value: TDate);
begin
  FDataInicial := Value;
end;

procedure TExtratoBancario.SetPeriodo(const Value: String);
begin
  FPeriodo     := Value;
end;

end.
