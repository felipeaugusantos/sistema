unit PagarMe.Lib.Dicionario;

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections;

type
  TBaseDictionary = class abstract
  strict private
    FLista : TDictionary<String, String>;
  strict protected
    procedure pCarregarLista; virtual;

    property Lista: TDictionary<String, String> read FLista;
  public
    constructor Create;
    destructor Destroy; override;

    function fValor(const AChave: String): String;
    function fChave(const AIndice: Integer): String;
  end;

  TErrosApi = class(TBaseDictionary)
  strict protected
    procedure pCarregarLista; override;
  end;

  TParcelasCartaoPagarMe = class(TBaseDictionary)
  strict protected
    procedure pCarregarLista; override;
  end;

  TParcelasSemJurosCartaoPagarMe = class(TBaseDictionary)
  strict protected
    procedure pCarregarLista; override;
  end;

  TDicionarioPagarMe = class sealed
  strict private
    FErrosApi               : TErrosApi;
    FParcelasCartao         : TParcelasCartaoPagarMe;
    FParcelasSemJurosCartao : TParcelasSemJurosCartaoPagarMe;

    class var FInstance: TDicionarioPagarMe;

  private
    constructor Create;
    class procedure ReleaseInstance;

  public
    destructor Destroy; override;

    class function GetInstance: TDicionarioPagarMe;

    property ErrosApi               : TErrosApi                      read FErrosApi;
    property ParcelasCartao         : TParcelasCartaoPagarMe         read FParcelasCartao;
    property ParcelasSemJurosCartao : TParcelasSemJurosCartaoPagarMe read FParcelasSemJurosCartao;
  end;

implementation

{ TDicionarioPagarMe }

constructor TDicionarioPagarMe.Create;
begin
  FErrosApi               := TErrosApi.Create;
  FParcelasCartao         := TParcelasCartaoPagarMe.Create;
  FParcelasSemJurosCartao := TParcelasSemJurosCartaoPagarMe.Create;
end;

destructor TDicionarioPagarMe.Destroy;
begin
  FreeAndNil(FErrosApi);

  inherited;
end;

class function TDicionarioPagarMe.GetInstance: TDicionarioPagarMe;
begin
   if not Assigned(FInstance) then
     FInstance := TDicionarioPagarMe.Create;

   Result := FInstance;
end;

class procedure TDicionarioPagarMe.ReleaseInstance;
begin
//
end;

{ TBaseDictionary }

constructor TBaseDictionary.Create;
begin
  FLista := TDictionary<String,String>.Create;
  pCarregarLista;
end;

destructor TBaseDictionary.Destroy;
begin
  FreeAndNil(FLista);
  inherited;
end;

function TBaseDictionary.fChave(const AIndice: Integer): String;
var
  LChave  : String;
  LIndice : Integer;
begin
  Result  := EmptyStr;
  LIndice := -1;

  if AIndice > FLista.Count then
    raise Exception.Create('List Index Out Of Bounds('+AIndice.ToString+')');

  for LChave in FLista.Keys do
  begin
    Inc(LIndice);

    if AIndice = LIndice then
    begin
      Result := LChave;
      Break;
    end;
  end;
end;

function TBaseDictionary.fValor(const AChave: String): String;
var
  LValor : String;
begin
  LValor := 'Não definido.';

  if FLista.ContainsKey(AChave) then
    LValor := FLista.Items[AChave];

  Result := LValor;
end;

procedure TBaseDictionary.pCarregarLista;
begin
  FLista.Clear;
end;

{ TErrosApi }

procedure TErrosApi.pCarregarLista;
begin
  inherited;
  Lista.Add('validation_error','Parâmetro passado está incorreto/faltando');
  Lista.Add('invalid_parameter','Parâmetro passado está incorreto/faltando');
  Lista.Add('action_forbidden','O usuário não tem permissão para fazer a ação');
  Lista.Add('internal_error','Erro interno em nosso servidor');
  Lista.Add('not_found','O recurso procurado não foi encontrado/não existe');
end;

{ TParcelasCartaoPagarMe }

procedure TParcelasCartaoPagarMe.pCarregarLista;
var
  intItem : Integer;
begin
  inherited;
  Lista.Add('QUANTIDADE PARCELAS SEM JUROS','0');

  For intItem := 1 To 12 Do
    Lista.Add(Format('Máximo de %s parcela', [intItem.ToString]), intItem.ToString);
end;

{ TParcelasSemJurosCartaoPagarMe }

procedure TParcelasSemJurosCartaoPagarMe.pCarregarLista;
var
  intItem : Integer;
begin
  inherited;
  Lista.Add('QUANTIDADE PARCELAS SEM JUROS','0');

  For intItem := 1 To 12 Do
  Begin
    If intItem = 1 Then
      Lista.Add('À vista','1')
    Else
      Lista.Add(Format('Até %s parcelas sem juros', [intItem.ToString]), intItem.ToString);
  End;
end;

initialization

finalization
  TDicionarioPagarMe.ReleaseInstance;

end.
