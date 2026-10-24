unit untTConsultaPagamentoDiarioRedeCardOnline;

interface

uses
  System.SysUtils, System.JSON, System.Generics.Collections, System.Variants;

  function RetornaValorJson(AObjeto: TJsonObject; ANomeCampo: String; ATipoRetorno: TVarType = varString): Variant;

type
  TNegociacao = class
  private
    FCodigoClienteCedente: string;
    FIdPagamento: string;
    FNomeEmpresa: string;
    FNumeroContratoInterno: string;
    FCodigoMarca: Integer;
    FTipoNegociacao: string;
    FNomeCedente: string;
    FCodigoBanco: String;
    FTipoPagamento: string;
    FCodigoTipo: string;
    FNumeroDocumento: string;
    FNumeroConta: String;
    FCodigoStatus: Integer;
    FContagemDeposito: Integer;
    FValorLiquido: Double;
    FTemValorAtualizado: Boolean;
    FDocumentoCedente: string;
    FStatus: string;
    FOrdemCreditoPai: string;
    FNomeComercial: string;
    FDataPagamento: string;
    FCodigoAgenciaBanco: String;
    FTipo: string;
    FNumeroEmpresa: string;
    FOrigemOrdemCredito: string;

  public
    constructor Create(AJSONObject: TJSONObject);
    property CodigoClienteCedente: string read FCodigoClienteCedente;
    property IdPagamento: string read FIdPagamento;
    property NomeEmpresa: string read FNomeEmpresa;
    property NumeroContratoInterno: string read FNumeroContratoInterno;
    property CodigoMarca: Integer read FCodigoMarca;
    property TipoNegociacao: string read FTipoNegociacao;
    property NomeCedente: string read FNomeCedente;
    property CodigoBanco: String read FCodigoBanco;
    property TipoPagamento: string read FTipoPagamento;
    property CodigoTipo: string read FCodigoTipo;
    property NumeroDocumento: string read FNumeroDocumento;
    property NumeroConta: String read FNumeroConta;
    property CodigoStatus: Integer read FCodigoStatus;
    property ContagemDeposito: Integer read FContagemDeposito;
    property ValorLiquido: Double read FValorLiquido;
    property TemValorAtualizado: Boolean read FTemValorAtualizado;
    property DocumentoCedente: string read FDocumentoCedente;
    property Status: string read FStatus;
    property OrdemCreditoPai: string read FOrdemCreditoPai;
    property NomeComercial: string read FNomeComercial;
    property DataPagamento: string read FDataPagamento;
    property CodigoAgenciaBanco: String read FCodigoAgenciaBanco;
    property Tipo: string read FTipo;
    property NumeroEmpresa: string read FNumeroEmpresa;
    property OrigemOrdemCredito: string read FOrigemOrdemCredito;
  end;

  TPagamento = class
  private
    FCodigoStatus: Integer;
    FValorLiquido: Double;
    FDataPagamento: string;
    FTipo: string;
    FOrigemOrdemCredito: string;
    FNomeEmpresa: string;
    FCodigoMarca: Integer;
    FTipoNegociacao: string;
    FTipoPagamento: string;
    FCodigoTipo: string;
    FNumeroDocumento: string;
    FContagemDeposito: Integer;
    FStatus: string;
    FNomeComercial: string;
    FNumeroEmpresa: string;
    FNegociacoes: TArray<TNegociacao>;
  public
    constructor Create(AJSONObject: TJSONObject; ANegociacoesGlobais: TList<TNegociacao>);
    property CodigoStatus: Integer read FCodigoStatus;
    property ValorLiquido: Double read FValorLiquido;
    property DataPagamento: string read FDataPagamento;
    property Tipo: string read FTipo;
    property OrigemOrdemCredito: string read FOrigemOrdemCredito;
    property NomeEmpresa: string read FNomeEmpresa;
    property CodigoMarca: Integer read FCodigoMarca;
    property TipoNegociacao: string read FTipoNegociacao;
    property TipoPagamento: string read FTipoPagamento;
    property CodigoTipo: string read FCodigoTipo;
    property NumeroDocumento: string read FNumeroDocumento;
    property ContagemDeposito: Integer read FContagemDeposito;
    property Status: string read FStatus;
    property NomeComercial: string read FNomeComercial;
    property NumeroEmpresa: string read FNumeroEmpresa;
    property Negociacoes: TArray<TNegociacao> read FNegociacoes;
  end;

  TPagamentosDiarios = class
  private
    FValorLiquido: Double;
    FData: string;
    FContagem: Integer;
    FPagamentos: TArray<TPagamento>;
  public
    constructor Create(AJSONObject: TJSONObject; ANegociacoesGlobais: TList<TNegociacao>);
    property ValorLiquido: Double read FValorLiquido;
    property Data: string read FData;
    property Contagem: Integer read FContagem;
    property Pagamentos: TArray<TPagamento> read FPagamentos;
  end;

  TConsultaPagamentoDiarioRedeCardOnline = class
  private
    FTemProximaChave: Boolean;
    FProximaPagina: String;
    FPagamentosDiarios: TArray<TPagamentosDiarios>;
    FNegociacoesGlobais: TList<TNegociacao>;
  public
    constructor Create(const AJSONString: string);
    destructor Destroy; override;
    property TemProximaChave: Boolean read FTemProximaChave;
    property ProximaPagina: String read FProximaPagina;
    property PagamentosDiarios: TArray<TPagamentosDiarios> read FPagamentosDiarios;
    property NegociacoesGlobais: TList<TNegociacao> read FNegociacoesGlobais;
  end;

implementation

{ TNegociacao }

constructor TNegociacao.Create(AJSONObject: TJSONObject);
begin
  FCodigoClienteCedente := RetornaValorJson(AJSONObject, 'transfereeCustomerCode');
  FIdPagamento := RetornaValorJson(AJSONObject, 'paymentId');
  FNomeEmpresa := RetornaValorJson(AJSONObject, 'companyName');
  FNumeroContratoInterno := RetornaValorJson(AJSONObject, 'internalContractNumber');
  FCodigoMarca := RetornaValorJson(AJSONObject, 'brandCode', varInteger);
  FTipoNegociacao := RetornaValorJson(AJSONObject, 'typeNegotiation');
  FNomeCedente := RetornaValorJson(AJSONObject, 'transfereeName');
  FCodigoBanco := RetornaValorJson(AJSONObject, 'bankCode');
  FTipoPagamento := RetornaValorJson(AJSONObject, 'typePayment');
  FCodigoTipo := RetornaValorJson(AJSONObject, 'typeCode');
  FNumeroDocumento := RetornaValorJson(AJSONObject, 'documentNumber');
  FNumeroConta := RetornaValorJson(AJSONObject, 'accountNumber');
  FCodigoStatus := RetornaValorJson(AJSONObject, 'statusCode', varInteger);
  FContagemDeposito :=RetornaValorJson(AJSONObject, 'depositCount', varInteger);
  FValorLiquido := RetornaValorJson(AJSONObject, 'netAmount', varDouble);
  FTemValorAtualizado := RetornaValorJson(AJSONObject, 'hasUpdateValue', varBoolean);
  FDocumentoCedente := RetornaValorJson(AJSONObject, 'transfereeDocument');
  FStatus := RetornaValorJson(AJSONObject, 'status');
  FOrdemCreditoPai := RetornaValorJson(AJSONObject, 'creditOrderParent');
  FNomeComercial := RetornaValorJson(AJSONObject, 'tradeName');
  FDataPagamento := RetornaValorJson(AJSONObject, 'paymentDate');
  FCodigoAgenciaBanco := RetornaValorJson(AJSONObject, 'bankBranchCode');
  FTipo := RetornaValorJson(AJSONObject, 'type');
  FNumeroEmpresa := RetornaValorJson(AJSONObject, 'companyNumber');
  FOrigemOrdemCredito := RetornaValorJson(AJSONObject, 'creditOrderOrigin');
end;

function RetornaValorJson(AObjeto: TJsonObject;
  ANomeCampo: String; ATipoRetorno: TVarType = varString): Variant;
begin

  case ATipoRetorno of
    varInteger: Result := 0;
    varInt64:   Result := Int64(0);
    varBoolean: Result := False;
    varDouble:  Result := 0.0;
    varDate:    Result := 0;
    else        Result := EmptyStr;
  end;

  If AObjeto.GetValue(ANomeCampo) = Nil Then
    Exit;

  Case ATipoRetorno Of
    varInteger: Result := AObjeto.GetValue<Integer>(ANomeCampo);
    varInt64: Result := AObjeto.GetValue<Int64>(ANomeCampo);
    varBoolean: Result := AObjeto.GetValue<Boolean>(ANomeCampo);
    varDouble: Result := AObjeto.GetValue<Double>(ANomeCampo);
    varDate: Result := AObjeto.GetValue<TDate>(ANomeCampo);
    Else Result := AObjeto.GetValue<String>(ANomeCampo);
  End;
end;

{ TPagamento }

constructor TPagamento.Create(AJSONObject: TJSONObject; ANegociacoesGlobais: TList<TNegociacao>);
var
  NegociacoesArray: TJSONArray;
  I: Integer;
  Negociacao: TNegociacao;
  NegociacaoJson: TJSONObject;
begin
  FCodigoStatus := RetornaValorJson(AJSONObject,'statusCode');
  FValorLiquido := RetornaValorJson(AJSONObject,'netAmount');
  FDataPagamento := RetornaValorJson(AJSONObject,'paymentDate');
  FTipo := RetornaValorJson(AJSONObject,'type');
  FOrigemOrdemCredito := RetornaValorJson(AJSONObject,'creditOrderOrigin');
  FNomeEmpresa := RetornaValorJson(AJSONObject,'companyName');
  FCodigoMarca := RetornaValorJson(AJSONObject,'brandCode');
  FTipoNegociacao := RetornaValorJson(AJSONObject,'typeNegotiation');
  FTipoPagamento := RetornaValorJson(AJSONObject,'typePayment');
  FCodigoTipo := RetornaValorJson(AJSONObject,'typeCode');
  FNumeroDocumento := RetornaValorJson(AJSONObject,'documentNumber');
  FContagemDeposito := RetornaValorJson(AJSONObject,'depositCount');
  FStatus := RetornaValorJson(AJSONObject,'status');
  FNomeComercial := RetornaValorJson(AJSONObject,'tradeName');
  FNumeroEmpresa := RetornaValorJson(AJSONObject,'companyNumber');

  NegociacoesArray := AJSONObject.GetValue<TJSONArray>('negotiations');

  // Se não houver negociações, criamos uma com os dados do pagamento principal
  if NegociacoesArray.Count = 0 then
  begin

    If FValorLiquido = 0 Then
      Exit;

    NegociacaoJson := TJSONObject.Create;
    try
      // Copia todos os campos relevantes do pagamento principal para a negociação
      NegociacaoJson.AddPair('transfereeCustomerCode', '');
      NegociacaoJson.AddPair('paymentId', RetornaValorJson(AJSONObject,'paymentId'));
      NegociacaoJson.AddPair('companyName', FNomeEmpresa);
      NegociacaoJson.AddPair('internalContractNumber', '');
      NegociacaoJson.AddPair('brandCode', TJSONNumber.Create(FCodigoMarca));
      NegociacaoJson.AddPair('typeNegotiation', FTipoNegociacao);
      NegociacaoJson.AddPair('transfereeName', '');
      NegociacaoJson.AddPair('bankCode', RetornaValorJson(AJSONObject,'bankCode'));
      NegociacaoJson.AddPair('typePayment', FTipoPagamento);
      NegociacaoJson.AddPair('typeCode', FCodigoTipo);
      NegociacaoJson.AddPair('documentNumber', FNumeroDocumento);
      NegociacaoJson.AddPair('accountNumber', RetornaValorJson(AJSONObject,'accountNumber'));
      NegociacaoJson.AddPair('statusCode', TJSONNumber.Create(FCodigoStatus));
      NegociacaoJson.AddPair('depositCount', TJSONNumber.Create(FContagemDeposito));
      NegociacaoJson.AddPair('netAmount', TJSONNumber.Create(FValorLiquido));
      {$IF Defined(VER270)}
      NegociacaoJson.AddPair('hasUpdateValue', RetornaValorJson(AJSONObject,'hasUpdateValue'));
      {$ELSE}
      NegociacaoJson.AddPair('hasUpdateValue',RetornaValorJson(AJSONObject,'hasUpdateValue'));
      {$IFEND }
      NegociacaoJson.AddPair('transfereeDocument', '');
      NegociacaoJson.AddPair('status', FStatus);
      NegociacaoJson.AddPair('creditOrderParent', RetornaValorJson(AJSONObject,'creditOrderParent'));
      NegociacaoJson.AddPair('tradeName', FNomeComercial);
      NegociacaoJson.AddPair('paymentDate', FDataPagamento);
      NegociacaoJson.AddPair('bankBranchCode', RetornaValorJson(AJSONObject,'bankBranchCode'));
      NegociacaoJson.AddPair('type', FTipo);
      NegociacaoJson.AddPair('companyNumber', FNumeroEmpresa);
      NegociacaoJson.AddPair('creditOrderOrigin', FOrigemOrdemCredito);

      Negociacao := TNegociacao.Create(NegociacaoJson);
      SetLength(FNegociacoes, 1);
      FNegociacoes[0] := Negociacao;
      ANegociacoesGlobais.Add(Negociacao);
    finally
      NegociacaoJson.Free;
    end;
  end
  else
  begin
    // Processa as negociações normalmente
    SetLength(FNegociacoes, NegociacoesArray.Count);
    for I := 0 to NegociacoesArray.Count - 1 do
    begin
      Negociacao := TNegociacao.Create(NegociacoesArray.Items[I] as TJSONObject);
      FNegociacoes[I] := Negociacao;
      ANegociacoesGlobais.Add(Negociacao);
    end;
  end;
end;

{ TPagamentosDiarios }

constructor TPagamentosDiarios.Create(AJSONObject: TJSONObject; ANegociacoesGlobais: TList<TNegociacao>);
var
  PagamentosArray: TJSONArray;
  I: Integer;
begin
  FValorLiquido := AJSONObject.GetValue<Double>('netAmount');
  FData := AJSONObject.GetValue<string>('date');
  FContagem := AJSONObject.GetValue<Integer>('count');

  PagamentosArray := AJSONObject.GetValue<TJSONArray>('payments');
  SetLength(FPagamentos, PagamentosArray.Count);
  for I := 0 to PagamentosArray.Count - 1 do
  begin
    FPagamentos[I] := TPagamento.Create(PagamentosArray.Items[I] as TJSONObject, ANegociacoesGlobais);
  end;
end;

{ TConsultaPagamentoDiarioRedeCardOnline }

constructor TConsultaPagamentoDiarioRedeCardOnline.Create(const AJSONString: string);
var
  JSONObject, CursorObject, ContentObject: TJSONObject;
  PagamentosDiariosArray: TJSONArray;
  I: Integer;
begin
  JSONObject := TJSONObject.ParseJSONValue(AJSONString) as TJSONObject;
  try
    CursorObject := JSONObject.GetValue<TJSONObject>('cursor');
    FTemProximaChave := CursorObject.GetValue<Boolean>('hasNextKey');

    If FTemProximaChave Then
      FProximaPagina := CursorObject.GetValue<string>('nextKey');

    FNegociacoesGlobais := TList<TNegociacao>.Create;

    ContentObject := JSONObject.GetValue<TJSONObject>('content');
    PagamentosDiariosArray := ContentObject.GetValue<TJSONArray>('paymentsDaily');
    SetLength(FPagamentosDiarios, PagamentosDiariosArray.Count);

    for I := 0 to PagamentosDiariosArray.Count - 1 do
    begin
      FPagamentosDiarios[I] := TPagamentosDiarios.Create(PagamentosDiariosArray.Items[I] as TJSONObject, FNegociacoesGlobais);
    end;
  finally
    JSONObject.Free;
  end;
end;

destructor TConsultaPagamentoDiarioRedeCardOnline.Destroy;
begin
  FNegociacoesGlobais.Free;
  inherited;
end;

end.
