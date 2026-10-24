{***********************************************************************************************}
{* Classe responsável pela conversão da classe TDicionario em IDicionario, com isso é possivel *}
{* que as dll terem ascesso a mesma clase de dicionario, sem ter conhecimento da               *}
{* implementação                                                                               *}
{********************************************************************************************PH*}
unit untDicionarioWrapper;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
  Shared.Core, untGTinForTipos,
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  untIDicionario, SysUtils, System.Classes;

type
  TDicionarioWrapper = class(TInterfacedObject, IDicionario)
  private
    blnVinculado: Boolean;
    dicionario: TDicionario;
  public
    procedure Adicionar(strChave: string; Valor: Variant);
    procedure AdicionarObjeto(strChave: string; Valor: TObject);
    procedure Limpar;
    procedure Remove(strChave: string);
    function Retorna(strChave: string): Variant;
    constructor Create(const dicionario: TDicionario); overload;
    constructor Create(); overload;
    destructor Destroy; override;
    function RetornaObjeto(strChave: string): TObject;
    function RetornaDicionario: TObject;
    function Chaves: TStringList;
  end;

implementation

{ TDicionarioWrapper }

procedure TDicionarioWrapper.Adicionar(strChave: string; Valor: Variant);
begin
  dicionario.Adicionar(strChave, Valor);
end;

procedure TDicionarioWrapper.AdicionarObjeto(strChave: string; Valor: TObject);
begin
  dicionario.AdicionarObjeto(strChave, Valor);
end;


function TDicionarioWrapper.Chaves: TStringList;
begin
  Result := dicionario.Chaves;
end;

constructor TDicionarioWrapper.Create;
begin
  inherited Create();
  dicionario := TDicionario.Create;
  blnVinculado := False;
end;

destructor TDicionarioWrapper.Destroy;
begin
  if not blnVinculado then
  begin
    if Assigned(dicionario) then FreeAndNil(dicionario);
  end; 

  inherited;
end;

constructor TDicionarioWrapper.Create(const dicionario: TDicionario);
begin
  inherited Create();
  Self.dicionario := dicionario;
  blnVinculado := True;
end;

procedure TDicionarioWrapper.Limpar;
begin
  dicionario.Limpar;
end;

procedure TDicionarioWrapper.Remove(strChave: string);
begin
  dicionario.Remove(strChave);
end;

function TDicionarioWrapper.Retorna(strChave: string): Variant;
begin
  Result := dicionario.Retorna(strChave);
end;

function TDicionarioWrapper.RetornaDicionario: TObject;
begin
  Result := dicionario;
end;

function TDicionarioWrapper.RetornaObjeto(strChave: string): TObject;
begin
  Result := dicionario.RetornaObjeto(strChave);
end;

end.
