unit OrdemProducaoIndustrial.TProdutoGranel;

interface

uses
  Classes,
  OrdemProducaoIndustrial.Tipos;

Type
  TProdutoGranel = class
    private
      FCodigo       : String;
      FCodigoItem          : String;
      FCodigoItemPrincipal : String;
      FCodigoItemSecundario: String;
      FDescricao    : String;
      FMedidaUnidade: TTipoMedidaUnidade;
      FComponenteA  :String;
      FComponenteB  :String;
      FCfgUsaComponente:Boolean;
    public
      property strCodigo              : String             read FCodigo               write FCodigo;
      property strCodigoItem          : String             read FCodigoItem           write FCodigoItem;
      property strCodigoItemPrincipal : String             read FCodigoItemPrincipal  write FCodigoItemPrincipal;
      property strCodigoItemSecundario: String             read FCodigoItemSecundario write FCodigoItemSecundario;
      property strDescricao           : String             read FDescricao            write FDescricao;
      property enuMedidaUnidade       : TTipoMedidaUnidade read FMedidaUnidade        write FMedidaUnidade;
      property strComponenteA         : String             read FComponenteA          write FComponenteA;
      property strComponenteB         : String             read FComponenteB          write FComponenteB;
      property blnCfgUsaComponente    :Boolean             read FCfgUsaComponente     write FCfgUsaComponente;

      function fUsaComponenteAB   : Boolean;
      function fCfgComponente     : Boolean;
      function fRetornaCodigoItem : String;

      constructor Create;

      procedure Clear;
  End;

implementation

{ TProdutoGranel }

procedure TProdutoGranel.Clear;
begin
  FCodigo       := '';
  FDescricao    := '';
  FMedidaUnidade:= tmNull;
  FComponenteA  := '';
  FComponenteB  := '';
  FCfgUsaComponente:= False;
  FCodigoItemSecundario:= '';
  FCodigoItemPrincipal := '';

end;

constructor TProdutoGranel.Create;
begin
  Clear;
end;

function TProdutoGranel.fCfgComponente: Boolean;
begin
  Result:= (FCfgUsaComponente = True)
end;

function TProdutoGranel.fRetornaCodigoItem: String;
begin
  If strCodigoItemSecundario <> '' Then
    Result:= FCodigoItemSecundario
  Else
  Result:= FCodigoItemPrincipal;
end;

function TProdutoGranel.fUsaComponenteAB: Boolean;
begin
  Result:= False;

  If (FComponenteA = 'S') Then
    Result:= True
  Else
  If (FComponenteB = 'S') Then
    Result:= True;

end;

end.

