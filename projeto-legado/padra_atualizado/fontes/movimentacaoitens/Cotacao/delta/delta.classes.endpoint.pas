unit Delta.Classes.EndPoint;

interface


uses classes, REST.Types, REST.Json, System.JSON,  System.IOUtils, System.StrUtils, System.SysUtils,
Cotacao.ApiPrecos.BaseParam, Generics.Collections, untFuncoesSimples;

type
  TRetConsultaEstoque = record
    dsc_item: string;
    dsc_marca: string;
    cod_produto: string;
    sdo_saldo_estoque: Double;
  End;


  TParamnsConsultaEstoque = class(TBaseParamApi)
   public
     strCodigoFabrica: String;
     RetConsultaEstoque: TRetConsultaEstoque;
     constructor create;
     function fProcessaRetono: String; override;
  End;

implementation


{ TParamnsConsultaEstoque }

constructor TParamnsConsultaEstoque.create;
begin
  inherited
end;


function TParamnsConsultaEstoque.fProcessaRetono: String;
var JsonRetKeyValue :TJsonRetKeyValue;
begin
  inherited;

  RetornoApi.Sucess := True;
  RetornoApi.Falha := '';
  If High(FArrJsonRetKeyValue)> -1 Then
  begin
    If FArrJsonRetKeyValue[0].Key = 'error' Then
    begin
      RetornoApi.Falha := FArrJsonRetKeyValue[0].Value;
      RetornoApi.Sucess := False;
    End;
  End;

  If not RetornoApi.Sucess Then
    Exit;

  For JsonRetKeyValue in FArrJsonRetKeyValue do
  begin
    If JsonRetKeyValue.Key = 'dsc_item' Then
      RetConsultaEstoque.dsc_item := JsonRetKeyValue.Value;
    If JsonRetKeyValue.Key = 'dsc_marca' Then
      RetConsultaEstoque.dsc_marca := JsonRetKeyValue.Value;
    If JsonRetKeyValue.Key = 'cod_produto' Then
      RetConsultaEstoque.cod_produto := JsonRetKeyValue.Value;
    If JsonRetKeyValue.Key = 'sdo_saldo_estoque' Then
      RetConsultaEstoque.sdo_saldo_estoque := StrToFloatDef(AnsiReplaceStr(JsonRetKeyValue.Value, '.', ','), 0);

  End;
end;

end.
