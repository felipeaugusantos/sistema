unit untTConsultaPagamentoDiarioRedeCardOnline;

interface

uses
  System.SysUtils, System.JSON, System.Generics.Collections, System.Variants;

type
  TNegociacao = class(TObject)
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

    function RetornaValorJson(AObjeto: TJsonObject; ANomeCampo: String; ATipoRetorno: TVarType = varString): Variant;
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
    constructor Create(AJSONObject: TJSONObject; ANegociacoesGlobais: TObjectList<TNegociacao>);
    destructor Destroy; override;
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
    constructor Create(AJSONObject: TJSONObject; ANegociacoesGlobais: TObjectList<TNegociacao>);
    destructor Destroy; override;
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
    FNegociacoesGlobais: TObjectList<TNegociacao>;
  public
    constructor Create(const AJSONString: string);
    destructor Destroy; override;

    procedure CopiaItensnegociacoesGlobais(var AListaNegociacao:TObjectList<TNegociacao>);

    property TemProximaChave: Boolean read FTemProximaChave;
    property ProximaPagina: String read FProximaPagina;
    property PagamentosDiarios: TArray<TPagamentosDiarios> read FPagamentosDiarios;
    property NegociacoesGlobais: TObjectList<TNegociacao> read FNegociacoesGlobais;
  end;

implementation
Uses untTRedeCardFuncoes;

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

function TNegociacao.RetornaValorJson(AObjeto: TJsonObject;
  ANomeCampo: String; ATipoRetorno: TVarType = varString): Variant;
begin
  Case ATipoRetorno of
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

constructor TPagamento.Create(AJSONObject: TJSONObject; ANegociacoesGlobais: TObjectList<TNegociacao>);
var
  NegociacoesArray: TJSONArray;
  I: Integer;
  Negociacao: TNegociacao;
  NegociacaoJson,
  LJsonObject: TJSONObject;

  LJsonString: String;
begin
  FCodigoStatus := AJSONObject.GetValue<Integer>('statusCode');
  FValorLiquido := AJSONObject.GetValue<Double>('netAmount');
  FDataPagamento := AJSONObject.GetValue<string>('paymentDate');
  FTipo := AJSONObject.GetValue<string>('type');
  FOrigemOrdemCredito := AJSONObject.GetValue<string>('creditOrderOrigin');
  FNomeEmpresa := AJSONObject.GetValue<string>('companyName');
  FCodigoMarca := AJSONObject.GetValue<Integer>('brandCode');
  FTipoNegociacao := AJSONObject.GetValue<string>('typeNegotiation');
  FTipoPagamento := AJSONObject.GetValue<string>('typePayment');
  FCodigoTipo := AJSONObject.GetValue<string>('typeCode');
  FNumeroDocumento := AJSONObject.GetValue<string>('documentNumber');
  FContagemDeposito := AJSONObject.GetValue<Integer>('depositCount');
  FStatus := AJSONObject.GetValue<string>('status');
  FNomeComercial := AJSONObject.GetValue<string>('tradeName');
  FNumeroEmpresa := AJSONObject.GetValue<string>('companyNumber');

  NegociacoesArray := Nil;
  LJsonObject := Nil;
  Try
    LJsonString := AJSONObject.GetValue('negotiations').ToJson;
    NegociacoesArray := TJSONObject.ParseJSONValue(LJsonString) As TJSONArray;

    // Se não houver negociações, criamos uma com os dados do pagamento principal
    if NegociacoesArray.Count = 0 then
    begin

      if FValorLiquido = 0 then
        Exit;

      NegociacaoJson := Nil;
      try
        NegociacaoJson := TJSONObject.Create;
        // Copia todos os campos relevantes do pagamento principal para a negociação
        NegociacaoJson.AddPair('transfereeCustomerCode', '');
        NegociacaoJson.AddPair('paymentId', AJSONObject.GetValue<string>('paymentId'));
        NegociacaoJson.AddPair('companyName', FNomeEmpresa);
        NegociacaoJson.AddPair('internalContractNumber', '');
        NegociacaoJson.AddPair('brandCode', TJSONNumber.Create(FCodigoMarca));
        NegociacaoJson.AddPair('typeNegotiation', FTipoNegociacao);
        NegociacaoJson.AddPair('transfereeName', '');
        NegociacaoJson.AddPair('bankCode', AJSONObject.GetValue<string>('bankCode'));
        NegociacaoJson.AddPair('typePayment', FTipoPagamento);
        NegociacaoJson.AddPair('typeCode', FCodigoTipo);
        NegociacaoJson.AddPair('documentNumber', FNumeroDocumento);
        NegociacaoJson.AddPair('accountNumber', AJSONObject.GetValue<string>('accountNumber'));
        NegociacaoJson.AddPair('statusCode', TJSONNumber.Create(FCodigoStatus));
        NegociacaoJson.AddPair('depositCount', TJSONNumber.Create(FContagemDeposito));
        NegociacaoJson.AddPair('netAmount', TJSONNumber.Create(FValorLiquido));
        NegociacaoJson.AddPair('hasUpdateValue', TJSONBool.Create(AJSONObject.GetValue<Boolean>('hasUpdateValue')));
        NegociacaoJson.AddPair('transfereeDocument', '');
        NegociacaoJson.AddPair('status', FStatus);
        NegociacaoJson.AddPair('creditOrderParent', AJSONObject.GetValue<string>('creditOrderParent'));
        NegociacaoJson.AddPair('tradeName', FNomeComercial);
        NegociacaoJson.AddPair('paymentDate', FDataPagamento);
        NegociacaoJson.AddPair('bankBranchCode', AJSONObject.GetValue<string>('bankBranchCode'));
        NegociacaoJson.AddPair('type', FTipo);
        NegociacaoJson.AddPair('companyNumber', FNumeroEmpresa);
        NegociacaoJson.AddPair('creditOrderOrigin', FOrigemOrdemCredito);

        Negociacao := TNegociacao.Create(NegociacaoJson);
        SetLength(FNegociacoes, 1);
        FNegociacoes[0] := Negociacao;
        ANegociacoesGlobais.Add(Negociacao);
      finally
        TRedeCardFuncoes.FreeAndNilObjeto(NegociacaoJson);
      end;
    end
    else
    begin
      // Processa as negociações normalmente
      SetLength(FNegociacoes, NegociacoesArray.Count);
      for I := 0 to NegociacoesArray.Count - 1 do
      begin
        Try
          LJsonObject := TJSONObject.ParseJSONValue(NegociacoesArray.Items[I].ToJSON) As TJSONObject;
          If LJsonObject = Nil Then
            Continue;

          Negociacao := TNegociacao.Create(LJsonObject);
          FNegociacoes[I] := Negociacao;
          ANegociacoesGlobais.Add(Negociacao);
        Finally
          TRedeCardFuncoes.FreeAndNilObjeto(LJsonObject);
        End;
      end;
    end;
  Finally
    TRedeCardFuncoes.FreeAndNilObjeto(NegociacoesArray);
  End;
end;

destructor TPagamento.Destroy;
  Var
    LContador: Integer;
begin
  For LContador := 0 To Length(FNegociacoes) - 1 Do
    TRedeCardFuncoes.FreeAndNilObjeto(FNegociacoes[LContador]);
  SetLength(FNegociacoes, 0);
  inherited;
end;

{ TPagamentosDiarios }

constructor TPagamentosDiarios.Create(AJSONObject: TJSONObject; ANegociacoesGlobais: TObjectList<TNegociacao>);
var
  PagamentosArray: TJSONArray;
  I: Integer;

  LJsonString: String;

  LJsonOnject: TJsonObject;
begin
  PagamentosArray := Nil;
  LJsonOnject := Nil;
  Try
    FValorLiquido := AJSONObject.GetValue<Double>('netAmount');
    FData := AJSONObject.GetValue<string>('date');
    FContagem := AJSONObject.GetValue<Integer>('count');

    LJsonString := AJSONObject.GetValue('payments').ToJson;
    PagamentosArray := TJsonObject.ParseJSONValue(LJsonString) As TJSONArray;
    If PagamentosArray = Nil Then
      Exit;

    SetLength(FPagamentos, PagamentosArray.Count);
    for I := 0 to PagamentosArray.Count - 1 do
    begin
      Try
        LJsonOnject := TJSONObject.ParseJSONValue(PagamentosArray.Items[I].ToJson) as TJSONObject;
        FPagamentos[I] := TPagamento.Create(LJsonOnject, ANegociacoesGlobais);
      Finally
        TRedeCardFuncoes.FreeAndNilObjeto(LJsonOnject);
      End;
    end;
  Finally
    TRedeCardFuncoes.FreeAndNilObjeto(PagamentosArray);
  End;
end;

destructor TPagamentosDiarios.Destroy;
  Var
    LContador: Integer;
begin
  For LContador := 0 To Length(FPagamentos) - 1 Do
    TRedeCardFuncoes.FreeAndNilObjeto(FPagamentos[LContador]);
  SetLength(FPagamentos, 0);

  inherited;
end;

{ TConsultaPagamentoDiarioRedeCardOnline }

procedure TConsultaPagamentoDiarioRedeCardOnline.CopiaItensnegociacoesGlobais(
  var AListaNegociacao: TObjectList<TNegociacao>);
  Var
    LItemNegociacao: TNegociacao;
begin
  If Not Assigned(AListaNegociacao) Then
    AListaNegociacao := TObjectList<TNegociacao>.Create;

  If Not Assigned(FNegociacoesGlobais) Then
    Exit;

  If FNegociacoesGlobais.Count = 0 Then
    Exit;

  For LItemNegociacao In FNegociacoesGlobais Do
    AListaNegociacao.Add(TRedeCardFuncoes.ClonarObjeto(LItemNegociacao));
end;

constructor TConsultaPagamentoDiarioRedeCardOnline.Create(const AJSONString: string);
var
  JSONObject, CursorObject, ContentObject: TJSONObject;
  PagamentosDiariosArray: TJSONArray;
  I: Integer;

  LStringJson: String;

  LJsonObjectArray: TJsonObject;
begin
  JSONObject := Nil;
  CursorObject := Nil;
  ContentObject := Nil;
  PagamentosDiariosArray := Nil;
  LJsonObjectArray := Nil;
  try
    JSONObject := TJSONObject.ParseJSONValue(AJSONString) as TJSONObject;
    If JsonObject = Nil Then
      Exit;

    LStringJson := JSONObject.GetValue('cursor').ToJson;
    CursorObject :=  TJSONObject.ParseJSONValue(LStringJson) as TJSONObject;
    FTemProximaChave := CursorObject.GetValue<Boolean>('hasNextKey');

    If FTemProximaChave Then
      FProximaPagina := CursorObject.GetValue<string>('nextKey');

    If Assigned(FNegociacoesGlobais) Then
      FreeAndNil(FNegociacoesGlobais);
    FNegociacoesGlobais := TObjectList<TNegociacao>.Create(False);

    LStringJson := JSONObject.GetValue('content').ToJson;
    ContentObject := TJSONObject.ParseJSONValue(LStringJson) as TJSONObject;

    LStringJson := ContentObject.GetValue('paymentsDaily').ToJson;
    PagamentosDiariosArray := TJSONObject.ParseJSONValue(LStringJson) as TJSONArray;
    SetLength(FPagamentosDiarios, PagamentosDiariosArray.Count);

    for I := 0 to PagamentosDiariosArray.Count - 1 do
    begin
      Try
        LJsonObjectArray := TJSONObject.ParseJSONValue(PagamentosDiariosArray.Items[I].ToJson) as TJSONObject;
        FPagamentosDiarios[I] := TPagamentosDiarios.Create(LJsonObjectArray, FNegociacoesGlobais);
      Finally
        TRedeCardFuncoes.FreeAndNilObjeto(LJsonObjectArray);
      End;
    end;
  finally
    TRedeCardFuncoes.FreeAndNilObjeto(PagamentosDiariosArray);
    TRedeCardFuncoes.FreeAndNilObjeto(ContentObject);
    TRedeCardFuncoes.FreeAndNilObjeto(CursorObject);
    TRedeCardFuncoes.FreeAndNilObjeto(JSONObject);
  end;
end;

destructor TConsultaPagamentoDiarioRedeCardOnline.Destroy;
  Var
    LContador: Integer;
begin
  For LContador := 0 To Length(FPagamentosDiarios) - 1 Do
    TRedeCardFuncoes.FreeAndNilObjeto(FPagamentosDiarios[LContador]);
  SetLength(FPagamentosDiarios, 0);

  If Assigned(FNegociacoesGlobais) Then
    FreeAndNil(FNegociacoesGlobais);
  inherited;
end;

end.
