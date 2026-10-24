unit untParametrosRastreamentoEnderecamento;

interface

uses
  Classes;

  type
    IParametrosRastreamentoEnderecamento = interface
    ['{FE9FB60C-C4CE-4E4A-B2FF-1D0659E5DCAF}']
      function AutoincremMOVRAS(strAutoincremMOVRAS : String) : IParametrosRastreamentoEnderecamento; overload;
      function AutoincremMOVRAS : String; overload;

      function AutoincremMOVDET(strAutoincremMOVDET : String) : IParametrosRastreamentoEnderecamento; overload;
      function AutoincremMOVDET : String; overload;

      function AutoincremORDDET(strAutoincremORDDET : String) : IParametrosRastreamentoEnderecamento; overload;
      function AutoincremORDDET : String; overload;

      function AutoincremLOTRAS(strAutoincremLOTRAS : String) : IParametrosRastreamentoEnderecamento; overload;
      function AutoincremLOTRAS : String; overload;

      function AutoincremFATGOR(strAutoincremFATGOR : String) : IParametrosRastreamentoEnderecamento; overload;
      function AutoincremFATGOR : String; overload;

      function CodigoFornecedor(strCodigoFornecedor : String) : IParametrosRastreamentoEnderecamento; overload;
      function CodigoFornecedor : String; overload;

      function CodigoItem(strCodigoItem : String) : IParametrosRastreamentoEnderecamento; overload;
      function CodigoItem : String; overload;

      function NumeroLote(strNumeroLote : String) : IParametrosRastreamentoEnderecamento; overload;
      function NumeroLote : String; overload;

      function QuantidadeEtiquetas(intQuantidadeEtiquetas : integer) : IParametrosRastreamentoEnderecamento; overload;
      function QuantidadeEtiquetas : integer; overload;

  end;


    TParametrosRastreamentoEnderecamento = class sealed(TInterfacedObject, IParametrosRastreamentoEnderecamento)
    protected
      strAutoincremMOVRAS    : String;
      strAutoincremMOVDET    : String;
      strAutoincremORDDET    : String;
      strAutoincremLOTRAS    : String;
      strAutoincremFATGOR    : String;
      strCodigoFornecedor    : String;
      strCodigoItem          : String;
      strNumeroLote          : String;
      intQuantidadeEtiquetas : integer;

      constructor Create;
    public
      const
        CODIGO_ITEM_INDEX       = 0;
        CODIGO_FORNECEDOR_INDEX = 1;
        NUMERO_LOTE_INDEX       = 2;

      function AutoincremMOVRAS(strAutoincremMOVRAS : String) : IParametrosRastreamentoEnderecamento; overload;
      function AutoincremMOVRAS : String; overload;

      function AutoincremMOVDET(strAutoincremMOVDET : String) : IParametrosRastreamentoEnderecamento; overload;
      function AutoincremMOVDET : String; overload;

      function AutoincremORDDET(strAutoincremORDDET : String) : IParametrosRastreamentoEnderecamento; overload;
      function AutoincremORDDET : String; overload;

      function AutoincremLOTRAS(strAutoincremLOTRAS : String) : IParametrosRastreamentoEnderecamento; overload;
      function AutoincremLOTRAS : String; overload;

      function AutoincremFATGOR(strAutoincremFATGOR : String) : IParametrosRastreamentoEnderecamento; overload;
      function AutoincremFATGOR : String; overload;

      function CodigoFornecedor(strCodigoFornecedor : String) : IParametrosRastreamentoEnderecamento; overload;
      function CodigoFornecedor : String; overload;

      function CodigoItem(strCodigoItem : String) : IParametrosRastreamentoEnderecamento; overload;
      function CodigoItem : String; overload;

      function NumeroLote(strNumeroLote : String) : IParametrosRastreamentoEnderecamento; overload;
      function NumeroLote : String; overload;

      function QuantidadeEtiquetas(intQuantidadeEtiquetas : integer) : IParametrosRastreamentoEnderecamento; overload;
      function QuantidadeEtiquetas : integer; overload;

      class function New() : IParametrosRastreamentoEnderecamento;
  end;



implementation


{ TParametrosRastreamentoEnderecamento }

constructor TParametrosRastreamentoEnderecamento.Create;
begin
  strAutoincremMOVRAS    := '';
  strAutoincremMOVDET    := '';
  strAutoincremORDDET    := '';
  strAutoincremLOTRAS    := '';
  strCodigoFornecedor    := '';
  strCodigoItem          := '';
  strNumeroLote          := '';
  intQuantidadeEtiquetas := 0;
end;

class function TParametrosRastreamentoEnderecamento.New: IParametrosRastreamentoEnderecamento;
begin
  Result := Self.Create;
end;

function TParametrosRastreamentoEnderecamento.NumeroLote: String;
begin
  Result := strNumeroLote;
end;

function TParametrosRastreamentoEnderecamento.AutoincremLOTRAS(
  strAutoincremLOTRAS: String): IParametrosRastreamentoEnderecamento;
begin
  Self.strAutoincremLOTRAS := strAutoincremLOTRAS;
  Result := Self;
end;

function TParametrosRastreamentoEnderecamento.AutoincremMOVDET(
  strAutoincremMOVDET: String): IParametrosRastreamentoEnderecamento;
begin
  Self.strAutoincremMOVDET := strAutoincremMOVDET;
  Result := Self;
end;

function TParametrosRastreamentoEnderecamento.AutoincremMOVRAS(
  strAutoincremMOVRAS: String): IParametrosRastreamentoEnderecamento;
begin
  Self.strAutoincremMOVRAS := strAutoincremMOVRAS;
  Result := Self;
end;

function TParametrosRastreamentoEnderecamento.AutoincremORDDET(
  strAutoincremORDDET: String): IParametrosRastreamentoEnderecamento;
begin
  Self.strAutoincremORDDET := strAutoincremORDDET;
  Result := Self;
end;

function TParametrosRastreamentoEnderecamento.CodigoFornecedor(
  strCodigoFornecedor: String): IParametrosRastreamentoEnderecamento;
begin
  Self.strCodigoFornecedor := strCodigoFornecedor;
  Result := Self;
end;

function TParametrosRastreamentoEnderecamento.CodigoItem(
  strCodigoItem: String): IParametrosRastreamentoEnderecamento;
begin
  Self.strCodigoItem := strCodigoItem;
  Result := Self;
end;

function TParametrosRastreamentoEnderecamento.NumeroLote(
  strNumeroLote: String): IParametrosRastreamentoEnderecamento;
begin
  Self.strNumeroLote := strNumeroLote;
  Result := Self;
end;

function TParametrosRastreamentoEnderecamento.QuantidadeEtiquetas(
  intQuantidadeEtiquetas: integer): IParametrosRastreamentoEnderecamento;
begin
  Self.intQuantidadeEtiquetas := intQuantidadeEtiquetas;
  Result := Self;
end;

function TParametrosRastreamentoEnderecamento.AutoincremFATGOR(
  strAutoincremFATGOR: String): IParametrosRastreamentoEnderecamento;
begin
  Self.strAutoincremFATGOR := strAutoincremFATGOR;
  Result := Self;
end;

function TParametrosRastreamentoEnderecamento.AutoincremFATGOR: String;
begin
  Result := strAutoincremFATGOR;
end;

function TParametrosRastreamentoEnderecamento.AutoincremLOTRAS: String;
begin
  Result := strAutoincremLOTRAS;
end;

function TParametrosRastreamentoEnderecamento.AutoincremMOVDET: String;
begin
  Result := strAutoincremMOVDET;
end;

function TParametrosRastreamentoEnderecamento.AutoincremMOVRAS: String;
begin
  Result := strAutoincremMOVRAS;
end;

function TParametrosRastreamentoEnderecamento.AutoincremORDDET: String;
begin
  Result := strAutoincremORDDET;
end;

function TParametrosRastreamentoEnderecamento.CodigoFornecedor: String;
begin
  Result := strCodigoFornecedor;
end;

function TParametrosRastreamentoEnderecamento.CodigoItem: String;
begin
  Result := strCodigoItem;
end;

function TParametrosRastreamentoEnderecamento.QuantidadeEtiquetas: integer;
begin
  Result :=  intQuantidadeEtiquetas;
end;

end.
