unit untComplementoEtiquetasProd;

interface

uses Uni, Contnrs, Classes;

type
  TComplementoEtiquetasProd = class(TObject)
  private
    FarrComplementos : array[1..10] of string;

    function  getComplemento(i : Integer) : String;
    procedure setComplemento(i : Integer; strComplemento : String);
    function fNomeCampo(i: Integer): String;
  public
    property arrComplementos[i : Integer] : String read getComplemento write setComplemento ;

    procedure Clear;
    procedure pSalva(strCodIte : String);
    procedure pBusca(strCodIte : String);

    function fComplementosVazio: Boolean;
    function fValorConfigLabel(i: Integer): String;

    constructor Create;
  end;


implementation

uses SysUtils, untFuncoesSimples, Data.DB, untConstantes, untTypesSistema;

{ TComplementoEtiquetasProd }

procedure TComplementoEtiquetasProd.Clear;
var
  i : Integer;
begin
  //limpa o array
  For i := 1 to 10 do
  begin
    arrComplementos[i] := '';
  end;
end;

constructor TComplementoEtiquetasProd.Create;
begin
  Clear;
end;

function TComplementoEtiquetasProd.getComplemento(i: Integer): String;
begin
  if i > 10 then
    Raise ExceptionAutCom.Create('O limite de Complementos é 10!');

  Result :=  FarrComplementos[i];
end;

procedure TComplementoEtiquetasProd.pBusca(strCodIte : String);
var
  qryComEti : TUniQuery;
  i : integer;
begin
  qryComEti := fCriaQuery(nil);
  try
    clear;

    qryComEti.SQL.Text := 'SELECT * FROM COMETI WHERE ETI_CODITE = :CODITE';
    qryComEti.Params.ParamByName('CODITE').AsString := strCodIte;

    qryComEti.Open;
    qryComEti.First;

    //recupera os valores
    if not qryComEti.IsEmpty then
      for i := 1 to 10 do
        arrComplementos[i] := qryComEti.FieldByName(fNomeCampo(i)).AsString;

  finally
    qryComEti.Close;
    FreeAndNil(qryComEti);
  end;

end;

function TComplementoEtiquetasProd.fNomeCampo(i : Integer) : String;
begin
  //monta o número com dois caractéres
  Result := 'ETI_COMP' + fPadL(IntToStr(i), 2, '0');
end;

function TComplementoEtiquetasProd.fValorConfigLabel(i : Integer) : String;
begin
  //monta o número com dois caractéres
  Result := fCfgSis('CETI' +fPadL(IntToStr(i), 2, '0'), varString);
end;


function TComplementoEtiquetasProd.fComplementosVazio : Boolean;
var
  i : Integer;
begin
  Result := True;
  For i := 1 to 10 do
  begin
    if not fEmptyStr(arrComplementos[i]) then
    begin
      Result := False;
      break;
    end;
  end;
end;


procedure TComplementoEtiquetasProd.pSalva(strCodIte : String);
var
  qryComEti : TUniQuery;
  i : integer;

  function fNomeParametro : String;
  begin
    Result := 'COMP' + fPadL(IntToStr(i), 2, '0');
  end;

begin
  qryComEti := fCriaQuery(nil);
  try
    if not fComplementosVazio then
    begin
      qryComEti.SQL.Add('REPLACE INTO COMETI SET');
      qryComEti.SQL.Add('ETI_CODITE = :CODITE');
      for i := 1 to 10 do
      begin

        //Adiciona o update do campo
        qryComEti.SQL.Add(', ' + fNomeCampo(i) + ' = :' + fNomeParametro);

        //atribui valor ao parâmetro
        qryComEti.Params.ParamByName(fNomeParametro).AsString := arrComplementos[i];

      end;
    end
    else
      qryComEti.SQL.Text := 'DELETE FROM COMETI WHERE ETI_CODITE = :CODITE';

    //executa o comando
    qryComEti.Params.ParamByName('CODITE').AsString := strCodIte;
    qryComEti.ExecSQL;

  finally
    FreeAndNil(qryComEti);
  end;

end;

procedure TComplementoEtiquetasProd.setComplemento(i: Integer; strComplemento: String);
begin
  if i > 10 then
    Raise ExceptionAutCom.Create('O limite de Complementos é 10!');
  FarrComplementos[i] := strComplemento;
end;

end.
