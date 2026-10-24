unit SkyPecas.Classes.EndPoint;

interface

uses classes, REST.Types, REST.Json, System.JSON,  System.IOUtils, System.StrUtils,
     System.SysUtils, Generics.Collections,
     Cotacao.ApiPrecos.BaseParam,
     Cotacao.ApiPrecos.ConstAndTypes;

type
  TSkyPecasloja = record
    cod: Integer;
    nome: string;
    cidade: string;
    uf: string;
    telefone: string;
    codFornecedorAutcom: String;
  End;

  TSkyPecasLojas = array of TSkyPecasloja;

  TSkyPecasConexao = record
    token: string;
    data_expiracao: TDate;
    acao: string;
    SkyPecasLojas: TSkyPecasLojas;
  End;

  TParamSkyAcesso = class(TBaseParamApi)
  private
    FCnpj: String;
    FUsuario: String;
    FSenha: String;
  protected
    function getJsonEnvion: String; override;
  public
    SkyPecasConexao: TSkyPecasConexao;
    function fProcessaRetono: String; override;
    procedure pSetParamnsAutenticacao(ACnpj, AUser, APass: String);
    function fFornecedorSkyPecas(ACodFor: String): Boolean;
    function fCodFornecedorSkyPecas(ACodFor: String): Integer;
    property JsonEnvioBody: String read getJsonEnvion;

  End;

  TSkyPecasRetornoProduto = Record
    descricao: String;
    codigo_fabricante: String;
    codigo_barras: String;
    marca: string;
    estoque: double;
    valor: double;
    procedure ReiniciaValores;
  End;

  TParamSkyConsultaProduto = class(TBaseParamApi)
  public
    codigo_barras: String;
    codigo_fabrica: String;
    produto: String;
    Marca: String;
    Empresa: integer;
    RetornoProduto: TSkyPecasRetornoProduto;
    function fProcessaRetono: String; override;

  End;

implementation

uses
  untCfgRelacionaFornecedorSkyFornecedorAutcom;

{ TParamSkyPecas }

function TParamSkyAcesso.fCodFornecedorSkyPecas(ACodFor: String): integer;
var SkyPecasloja: TSkyPecasloja;
begin
  Result := -1;
  For SkyPecasloja in SkyPecasConexao.SkyPecasLojas do
    If SkyPecasloja.codFornecedorAutcom =  ACodFor then
      Result := SkyPecasloja.cod;


end;

function TParamSkyAcesso.fFornecedorSkyPecas(ACodFor: String): Boolean;
var SkyPecasloja: TSkyPecasloja;
begin
  Result := False;
  For SkyPecasloja in SkyPecasConexao.SkyPecasLojas do
    If SkyPecasloja.codFornecedorAutcom =  ACodFor then
      Exit(True)
end;

function TParamSkyAcesso.fProcessaRetono: String;
var
  JsonRetKeyValue :TJsonRetKeyValue;
  PosArray: integer;
begin
  inherited;

  PosArray := 0;

  case RetornoApi.StatusCode of
    200: Begin
           For JsonRetKeyValue  in FArrJsonRetKeyValue do
           begin
             If JsonRetKeyValue.Key = 'token' Then
               SkyPecasConexao.token := JsonRetKeyValue.Value;
             If JsonRetKeyValue.Key = 'lojas.cod' Then
             begin
               SetLength(SkyPecasConexao.SkyPecasLojas, succ(Length(SkyPecasConexao.SkyPecasLojas)));
               PosArray := High(SkyPecasConexao.SkyPecasLojas);
               SkyPecasConexao.SkyPecasLojas[PosArray].cod := StrToInt(JsonRetKeyValue.Value);
               SkyPecasConexao.SkyPecasLojas[PosArray].codFornecedorAutcom :=
                 TfrmCfgRelacionaForncedorSkyFornecedorAutcom.fFornecedorRelacaoSky(SkyPecasConexao.SkyPecasLojas[PosArray].cod.Tostring);
             End;
             If JsonRetKeyValue.Key = 'lojas.nome' Then
               SkyPecasConexao.SkyPecasLojas[PosArray].nome := JsonRetKeyValue.Value;
             If JsonRetKeyValue.Key = 'lojas.cidade' Then
               SkyPecasConexao.SkyPecasLojas[PosArray].cidade := JsonRetKeyValue.Value;
             If JsonRetKeyValue.Key = 'lojas.uf' Then
               SkyPecasConexao.SkyPecasLojas[PosArray].uf:= JsonRetKeyValue.Value;
             If JsonRetKeyValue.Key = 'lojas.telefone' Then
               SkyPecasConexao.SkyPecasLojas[PosArray].telefone := JsonRetKeyValue.Value;
           End;
         End;
    400: Begin
           For JsonRetKeyValue  in FArrJsonRetKeyValue do
           begin
             If JsonRetKeyValue.Key = 'error' Then
               RetornoApi.Falha := JsonRetKeyValue.Value;
           End;
         End;
    429: RetornoApi.Falha := '429: Muitas requisições, consulta Sky Peças bloqueada temporariamente!';

  End;
end;

function TParamSkyAcesso.getJsonEnvion(): String;
begin
  Result := '';
  Result := Result + '{';
  Result := Result + '"cnpj": "'+FCnpj+'",';
  Result := Result + '"login": "'+FUsuario+'",';
  Result := Result + '"senha": "'+FSenha+'"';
  Result := Result + '}';
end;

procedure TParamSkyAcesso.pSetParamnsAutenticacao(ACnpj, AUser, APass: String);
begin
  FCnpj := ACnpj;
  FUsuario := AUser;
  FSenha := APass;
end;

{ TParamSkyConsultaProduto }

function TParamSkyConsultaProduto.fProcessaRetono: String;
var
  JsonRetKeyValue :TJsonRetKeyValue;
begin
  inherited;
  case RetornoApi.StatusCode of
    200: Begin
           For JsonRetKeyValue  in FArrJsonRetKeyValue do
           begin
             If JsonRetKeyValue.Key = 'produtos.descricao' Then
               Self.RetornoProduto.descricao := JsonRetKeyValue.Value;
             If JsonRetKeyValue.Key = 'produtos.codigo_barra' Then
               Self.RetornoProduto.codigo_barras := JsonRetKeyValue.Value;
             If JsonRetKeyValue.Key = 'produtos.codigo_fabricante' Then
               Self.RetornoProduto.codigo_fabricante := JsonRetKeyValue.Value;
             If JsonRetKeyValue.Key = 'produtos.marca' Then
               Self.RetornoProduto.Marca := JsonRetKeyValue.Value;
             If JsonRetKeyValue.Key = 'produtos.estoque' Then
               Self.RetornoProduto.estoque := StrToFloatDef(AnsiReplaceStr(JsonRetKeyValue.Value, '.', ','), 0);
             If JsonRetKeyValue.Key = 'produtos.valor' Then
               Self.RetornoProduto.valor := StrToFloatDef(AnsiReplaceStr(JsonRetKeyValue.Value, '.', ','), 0);
           End;
         End;
    400: Begin
           For JsonRetKeyValue  in FArrJsonRetKeyValue do
           begin
             If JsonRetKeyValue.Key = 'error' Then
               RetornoApi.Falha := JsonRetKeyValue.Value;
           End;
         End;
    404: Begin
           For JsonRetKeyValue  in FArrJsonRetKeyValue do
           begin

             If JsonRetKeyValue.Key = 'error' Then
               RetornoApi.Falha := JsonRetKeyValue.Value;
           End;
         End;

  End;
end;

{ TSkyPecasRetornoProduto }

procedure TSkyPecasRetornoProduto.ReiniciaValores;
begin
  Self.descricao := '';
  Self.codigo_fabricante := '';
  Self.codigo_barras := '';
  Self.marca := '';
  Self.estoque := 0;
  Self.valor := 0;
end;

end.

