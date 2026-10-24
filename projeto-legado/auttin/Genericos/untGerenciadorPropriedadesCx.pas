{***********************************************************************************************}
{* Classe responsável por associar os tipos de configurações das dlls das tintas com a tela de *}
{* configuração, com isso é possivel cada configuração ser representada de uma maneira no      *}
{* grid                                                                                        *}
{********************************************************************************************PH*}
unit untGerenciadorPropriedadesCx;

interface

uses
  cxEdit, Classes, SysUtils;

type
  TGerenciadorPropriedadesCx = class(TInterfacedObject)
  private
    stlPropriedades: TStringList;
    function GetStlPropriedades: TStringList;
  public
    constructor Create();
    destructor Destroy; override;
    procedure SetPropriedade(const index: Integer; const propriedade: TcxEditRepositoryItem);
    function GetPropriedade(const index: Integer): TcxEditRepositoryItem;

    property Proriedade[const index: Integer]: TcxEditRepositoryItem read GetPropriedade write SetPropriedade; default;
  end;

implementation

{ TGerenciadorPropriedadesCx }

constructor TGerenciadorPropriedadesCx.Create;
begin
  inherited Create;
  stlPropriedades := nil;
end;

destructor TGerenciadorPropriedadesCx.Destroy;
begin
  if Assigned(stlPropriedades) then FreeAndNil(stlPropriedades);
  inherited;
end;

function TGerenciadorPropriedadesCx.GetPropriedade(const index: Integer): TcxEditRepositoryItem;
var
  intIndex: Integer;
begin
  Result := nil;
  intIndex := GetStlPropriedades.IndexOf(IntToStr(index));
  if intIndex >= 0 then
    Result := TcxEditRepositoryItem(GetStlPropriedades.Objects[intIndex]);
end;

function TGerenciadorPropriedadesCx.GetStlPropriedades: TStringList;
begin
  if not Assigned(stlPropriedades) then
  begin
    stlPropriedades := TStringList.Create;
  end;

  Result := stlPropriedades;
end;

procedure TGerenciadorPropriedadesCx.SetPropriedade(const index: Integer; const propriedade: TcxEditRepositoryItem);
begin
  GetStlPropriedades.AddObject(IntToStr(index), propriedade);
end;

end.
