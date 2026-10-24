unit untTMobbuyPagamentosOnline;

interface

uses
  System.SysUtils, System.JSON, System.Generics.Collections, System.Variants;

type
  // Item “normalizado” de pagamento (1 por linha retornada pela API)
  TMobbuyPagamento = class
  private
    FIdPagamento: string;
    FNSU: string;
    FCodigoAutorizacao: string;
    FBandeira: string;
    FProduto: string;          // crédito, débito, etc.
    FValorBruto: Double;
    FTaxaPerc: Double;
    FValorLiquido: Double;
    FParcelaAtual: Integer;
    FParcelasTotal: Integer;
    FStatus: string;
    FDataPagamento: string;    // manter string e converter depois
    FCodigoEstab: string;
    function GetV(Obj: TJSONObject; const Nome: string; Tipo: TVarType = varString): Variant;
  public
    constructor Create(AJSONObject: TJSONObject);
    property IdPagamento: string read FIdPagamento;
    property NSU: string read FNSU;
    property CodigoAutorizacao: string read FCodigoAutorizacao;
    property Bandeira: string read FBandeira;
    property Produto: string read FProduto;
    property ValorBruto: Double read FValorBruto;
    property TaxaPerc: Double read FTaxaPerc;
    property ValorLiquido: Double read FValorLiquido;
    property ParcelaAtual: Integer read FParcelaAtual;
    property ParcelasTotal: Integer read FParcelasTotal;
    property Status: string read FStatus;
    property DataPagamento: string read FDataPagamento;
    property CodigoEstab: string read FCodigoEstab;
  end;

  // Agrupamento diário (se a Mobbuy já devolver assim; se não, você pode agrupar depois)
  TMobbuyPagamentosDiarios = class
  private
    FData: string;
    FValorLiquido: Double;
    FContagem: Integer;
    FPagamentos: TArray<TMobbuyPagamento>;
  public
    constructor Create(AJSONObject: TJSONObject);
    property Data: string read FData;
    property ValorLiquido: Double read FValorLiquido;
    property Contagem: Integer read FContagem;
    property Pagamentos: TArray<TMobbuyPagamento> read FPagamentos;
  end;

  // Objeto “raiz” da consulta (com paginação)
  TConsultaPagamentoDiarioMobbuyOnline = class
  private
    FTemProximaPagina: Boolean;
    FProximaChave: string; // token/nextKey/nextPage, conforme vier
    FPagamentosDiarios: TArray<TMobbuyPagamentosDiarios>;
    procedure LerPaginacao(const Root: TJSONObject);
  public
    constructor Create(const AJSONString: string);
    property TemProximaPagina: Boolean read FTemProximaPagina;
    property ProximaChave: string read FProximaChave;
    property PagamentosDiarios: TArray<TMobbuyPagamentosDiarios> read FPagamentosDiarios;
  end;

implementation

{ TMobbuyPagamento }

constructor TMobbuyPagamento.Create(AJSONObject: TJSONObject);
begin
  // Ajuste os nomes conforme o JSON da Mobbuy.
  // Use GetV para não quebrar se faltar campos ou mudar tipos.
  FIdPagamento      := GetV(AJSONObject, 'paymentId');
  FNSU              := GetV(AJSONObject, 'nsu');
  FCodigoAutorizacao:= GetV(AJSONObject, 'authorizationCode');
  FBandeira         := GetV(AJSONObject, 'brand');           // 'VISA', 'MASTERCARD', ...
  FProduto          := GetV(AJSONObject, 'product');         // 'credito', 'debito', ...
  FValorBruto       := GetV(AJSONObject, 'grossAmount', varDouble);
  FTaxaPerc         := GetV(AJSONObject, 'feePercent', varDouble);
  FValorLiquido     := GetV(AJSONObject, 'netAmount', varDouble);
  FParcelaAtual     := GetV(AJSONObject, 'installmentNumber', varInteger);
  FParcelasTotal    := GetV(AJSONObject, 'installments', varInteger);
  FStatus           := GetV(AJSONObject, 'status');
  FDataPagamento    := GetV(AJSONObject, 'paymentDate');     // ISO8601 provável
  FCodigoEstab      := GetV(AJSONObject, 'merchantId');
end;

function TMobbuyPagamento.GetV(Obj: TJSONObject; const Nome: string; Tipo: TVarType): Variant;
begin
  case Tipo of
    varInteger: Result := 0;
    varInt64:   Result := Int64(0);
    varBoolean: Result := False;
    varDouble:  Result := 0.0;
  else
    Result := EmptyStr;
  end;

  if Obj.GetValue(Nome) = nil then Exit;

  case Tipo of
    varInteger: Result := Obj.GetValue<Integer>(Nome);
    varInt64:   Result := Obj.GetValue<Int64>(Nome);
    varBoolean: Result := Obj.GetValue<Boolean>(Nome);
    varDouble:  Result := Obj.GetValue<Double>(Nome);
  else
    Result := Obj.GetValue<string>(Nome);
  end;
end;

{ TMobbuyPagamentosDiarios }

constructor TMobbuyPagamentosDiarios.Create(AJSONObject: TJSONObject);
var
  Arr: TJSONArray;
  I: Integer;
begin
  // Se a Mobbuy NÃO agrupar por dia, você pode:
  // - preencher FData vazio e empurrar todos itens em um único “dia”, ou
  // - criar um construtor alternativo com uma lista simples de pagamentos.
  FData         := AJSONObject.GetValue<string>('date', '');
  FValorLiquido := AJSONObject.GetValue<Double>('netAmount', 0);
  FContagem     := AJSONObject.GetValue<Integer>('count', 0);

  Arr := AJSONObject.GetValue<TJSONArray>('payments');
  if Arr = nil then
    Arr := AJSONObject.GetValue<TJSONArray>('items'); // fallback comum

  if Arr <> nil then
  begin
    SetLength(FPagamentos, Arr.Count);
    for I := 0 to Arr.Count - 1 do
      FPagamentos[I] := TMobbuyPagamento.Create(Arr.Items[I] as TJSONObject);
  end;
end;

{ TConsultaPagamentoDiarioMobbuyOnline }

constructor TConsultaPagamentoDiarioMobbuyOnline.Create(const AJSONString: string);
var
  Root, Content, Fake: TJSONObject;
  Daily, Items: TJSONArray;  // <-- declare aqui
  I: Integer;
begin
  Root := TJSONObject.ParseJSONValue(AJSONString) as TJSONObject;
  try
    LerPaginacao(Root);

    // algumas APIs usam 'content'
    Content := Root.GetValue<TJSONObject>('content');
    if Content = nil then
      Content := Root;

    // tenta o daily; senão cai para array plano
    Daily := Content.GetValue<TJSONArray>('paymentsDaily');
    if Daily = nil then
      Daily := Content.GetValue<TJSONArray>('data');

    if Daily <> nil then
    begin
      SetLength(FPagamentosDiarios, Daily.Count);
      for I := 0 to Daily.Count - 1 do
        FPagamentosDiarios[I] := TMobbuyPagamentosDiarios.Create(Daily.Items[I] as TJSONObject);
    end
    else
    begin
      // fallback: lista plana de pagamentos
      Items := Content.GetValue<TJSONArray>('payments');  // <-- sem 'var'
      if Items = nil then
        Items := Content.GetValue<TJSONArray>('items');

      if Items <> nil then
      begin
        SetLength(FPagamentosDiarios, 1);
        Fake := TJSONObject.Create;
        try
          Fake.AddPair('date', '');
          Fake.AddPair('netAmount', TJSONNumber.Create(0));
          Fake.AddPair('count', TJSONNumber.Create(Items.Count));
          Fake.AddPair('payments', Items.Clone as TJSONArray);
          FPagamentosDiarios[0] := TMobbuyPagamentosDiarios.Create(Fake);
        finally
          Fake.Free;
        end;
      end;
    end;
  finally
    Root.Free;
  end;
end;

procedure TConsultaPagamentoDiarioMobbuyOnline.LerPaginacao(const Root: TJSONObject);
var
  Cursor: TJSONObject;
begin
  // Tenta vários formatos de paginação comuns
  Cursor := Root.GetValue<TJSONObject>('cursor');
  if Cursor <> nil then
  begin
    FTemProximaPagina := Cursor.GetValue<Boolean>('hasNextKey', False);
    if FTemProximaPagina then
      FProximaChave := Cursor.GetValue<string>('nextKey', '');
    Exit;
  end;

  FTemProximaPagina := Root.GetValue<Boolean>('hasNext', False) or
                       Root.GetValue<Boolean>('has_more', False);

  if Root.TryGetValue<string>('nextPageToken', FProximaChave) then Exit;
  if Root.TryGetValue<string>('next', FProximaChave) then Exit;
  if Root.TryGetValue<string>('next_url', FProximaChave) then Exit;
end;

end.

