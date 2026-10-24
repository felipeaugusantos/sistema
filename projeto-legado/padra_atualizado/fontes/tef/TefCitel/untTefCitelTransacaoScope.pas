unit untTefCitelTransacaoScope;

interface

uses
  System.SysUtils, System.Classes, System.JSON, System.StrUtils, System.DateUtils,
  System.Generics.Collections, System.Generics.Defaults,
  REST.Types, REST.Json,REST.Client, REST.Authenticator.Basic, REST.Authenticator.OAuth,
  untTefCitelTransacaoInterfaces, untTefCitelTransacaoScopeUtils, untTefCitelTransacaoComum;

type
  TTransaocaoTefParserScope = class
  private
    FUtils: TTransacaoTefUtils;
    function fJsonStrToDadosLista(const AJson: string; const AApenasPendentes: Boolean = False): TTransacaoTefDadosLista;
    function fGetDtaHra(const AStrDta, AStrDta2: string): TDateTime;
    function fGetInfo(const ACodServ: Integer; const ATipCar: string): string;
    function fGetStatus(const ASituacao: string): TTransacaoTefStatus;
    function fGetStrStatus(const ASituacao: string): string;
    function fGetNomeBandeira(const ACodBan: string): string;
    function fGetNomeRede(const ACodRed: string): string;
    function fGetControle(const ADtaMsg, ANsu, ACodFil, ACodEmp: string): string;
    function fCalcPartContro(const AStrPar: string): Integer;

    class function fCompararTransacoesPorDataHora(const Left, Right: TTransacaoTefDados): Integer;
  public
    function fJsonToDados(const AJson: string): TTransacaoTefDados;
    function fJsonToLista(const AJson: string; const AApenasPendentes: Boolean = False): TTransacaoTefDadosLista;
    function fJsonToMsgErro(const AJson: string): String;
    function fDateTimeToDataApi(const ADateTime: TDateTime): string;

    constructor Create;
    destructor Destroy; override;
  end;

  TTransacaoTefRestConfigScope = class
  public
    class function fConfigurarScope(RestClient: TRestClient; OAuth2Authenticator: TOAuth2Authenticator; RestResponse: TRestResponse): Boolean;
  end;

  TTransacaoTefRepositoryScope = class(TInterfacedObject, ITransacaoTefRepository)
  private
    FCredenciais: TScopeCredencial;
    FParser: TTransaocaoTefParserScope;
    procedure pAddStrPar(var AStr: string; const AKey, AValue: string);
    procedure pAddParRequest(var ARequest: TRestRequest; AStrPar: string);
    function fEnviarRequisicao(AResource: string; AStrParams: string; var AStrJson: string): Boolean;
    function fVerificarCredenciais: Boolean;
    function fVerificarSeTrnEstaPendendente(const ATrn: TTransacaoTefDados): Boolean;
    function fBuscarTransacoes(const ADate: TDate; var AStrJson: string): Boolean;
    procedure pAjustarStatusPendenciaInterno(var ATrn: TTransacaoTefDados; const ATipo: TScopeTipoOperacao);
    procedure pAjustarStatusPendencia(var ATrn: TTransacaoTefDados); overload;
    procedure pAjustarStatusPendencia(ALstTrn: TTransacaoTefDadosLista); overload;
    procedure pRegistrarPendencia(const ATrn: TTransacaoTefDados; const ATipo: TScopeTipoOperacao);
  public
    function fBuscarTransacao(AParam: TTransacaoTefBuscaParam): TTransacaoTefDados;
    function fBuscarTransacoesPorData(const ADate: TDate): TTransacaoTefDadosLista;
    function fBuscarTransacoesPendentes(const ADateFrom, ADateTo: TDate): TTransacaoTefDadosLista;

    function fCancelarTransacaoPendente(const ATrn: TTransacaoTefDados): Boolean;
    function fConfirmarTransacaoPendente(const ATrn: TTransacaoTefDados): Boolean;

    class function New: ITransacaoTefRepository;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  untRestApi, untFuncoesSimples;

{ TTransacaoTefRestConfigScope }

class function TTransacaoTefRestConfigScope.fConfigurarScope(
  RestClient: TRestClient; OAuth2Authenticator: TOAuth2Authenticator;
  RestResponse: TRestResponse): Boolean;
begin
  Result := True;

  try
    RestClient.Accept := 'application/x-www-form-urlencoded';
    RestClient.ContentType := 'application/x-www-form-urlencoded';

    RestResponse.ContentType := 'application/json';
  except
    Result := False;
  end;
end;

{ TTransaocaoTefParserScope }

constructor TTransaocaoTefParserScope.Create;
begin
  FUtils := TTransacaoTefUtils.Create;
end;

destructor TTransaocaoTefParserScope.Destroy;
begin
  FreeandNil(FUtils);
  inherited;
end;

function TTransaocaoTefParserScope.fCalcPartContro(
  const AStrPar: string): Integer;
var
  LstrPar, LstrResultado: string;
  LintPos1, LintPos2, lintMult, LintAcc, LintDac: Integer;
begin
  LstrPar := Trim(AStrPar);
  if (LstrPar = '') or not TryStrToInt(LstrPar, LintAcc) then
  begin
    Result := 0;
    Exit;
  end;

  LintPos1 := Length(LstrPar);
  lintMult := 2;
  LintAcc := 0;

  while LintPos1 >= 1 do
  begin
    LstrResultado := IntToStr(StrToInt(LstrPar[LintPos1]) * lintMult);
    LintPos2 := Length(LstrResultado);

    while LintPos2 >= 1 do
    begin
      LintAcc := LintAcc + StrToInt(LstrResultado[LintPos2]);
      Dec(LintPos2);
    end;

    if lintMult = 2 then
      lintMult := 1
    else
      lintMult := 2;

    Dec(LintPos1);
  end;

  LintDac := LintAcc mod 10;
  LintDac := 10 - LintDac;
  if LintDac = 10 then
    LintDac := 0;

  Result := LintDac;
end;

class function TTransaocaoTefParserScope.fCompararTransacoesPorDataHora(
  const Left, Right: TTransacaoTefDados): Integer;
begin
  if Left.DtaHra < Right.DtaHra then
    Result := -1
  else if Left.DtaHra > Right.DtaHra then
    Result := 1
  else
    Result := 0;
end;

function TTransaocaoTefParserScope.fDateTimeToDataApi(
  const ADateTime: TDateTime): string;
var
  LAno, LMes, LDia: Word;
begin
  DecodeDate(ADateTime, LAno, LMes, LDia);
  Result := fPadL(IntToStr(LAno), 4, '0') + fPadL(IntToStr(LMes), 2, '0') + fPadL(IntToStr(LDia), 2, '0');
end;

function TTransaocaoTefParserScope.fGetControle(const ADtaMsg, ANsu, ACodFil,
  ACodEmp: string): string;
var
  LstrPreControle, LstrRecSoma, LstrCal1Controle, LstrSomaContro, LstrNsuInv: string;
  LintContro1, LintContro2, LintSoma: Integer;
begin
  Result := '';
  if ANsu = '' then
    Exit;

  if Length(ANsu) < 6 then
    raise Exception.Create('NSU deve ter pelo menos 6 caracteres');

  LstrNsuInv := ANsu[2] + ANsu[4] + ANsu[6] + ANsu[5] + ANsu[3] + ANsu[1];

  LstrPreControle := Copy(ADtaMsg, 5, 2) +  Copy(ADtaMsg, 8, 1) +  LstrNsuInv + Copy(ADtaMsg, 7, 1);

  LstrCal1Controle := Copy(ADtaMsg, 8, 1) + LstrNsuInv + Copy(ADtaMsg, 7, 1);
  LstrSomaContro := ACodFil + ACodEmp + Copy(ADtaMsg, 5, 2);

  LintContro1  := fCalcPartContro(LstrCal1Controle);
  LintContro2  := fCalcPartContro(LstrSomaContro);
  LintSoma := LintContro1 + LintContro2;

  if LintSoma < 10 then
    LstrRecSoma := IntToStr(LintSoma)
  else
    LstrRecSoma := IntToStr(LintSoma)[2]; // Pega o segundo dígito

  Result := LstrPreControle + LstrRecSoma;
end;

function TTransaocaoTefParserScope.fGetDtaHra(const AStrDta, AStrDta2: string): TDateTime;
var
  LFormatSettings: TFormatSettings;
  LAno, LMes, LDia: Word;
begin
  if not AStrDta.IsEmpty then
  begin
    LFormatSettings := TFormatSettings.Create;
    LFormatSettings.ShortDateFormat := 'yyyy-mm-dd';
    LFormatSettings.LongTimeFormat := 'hh:nn:ss.zzz';
    LFormatSettings.TimeSeparator := ':';
    LFormatSettings.DateSeparator := '-';
    LFormatSettings.DecimalSeparator := '.';

    if not TryStrToDateTime(AStrDta, Result, LFormatSettings) then
      raise Exception.Create('Erro ao converter data/hora.');
  end
  else if not AStrDta2.IsEmpty then
  begin
    try
      LAno := Copy(AStrDta2, 1, 4).ToInteger;
      LMes := Copy(AStrDta2, 5, 2).ToInteger;
      LDia := Copy(AStrDta2, 7, 2).ToInteger;

      Result := EncodeDateTime(LAno, LMes, LDia, 0, 0, 0, 0);
    except
      raise Exception.Create('Erro ao converter data/hora.');
    end;
  end
  else
    Result := 0;
end;

function TTransaocaoTefParserScope.fGetInfo(
 const ACodServ: Integer; const ATipCar: string): string;
begin

  case ACodServ of
    006: Result := 'Cartão de débito á vista';
    009: Result := 'Cartão de crédito á vista';
    013: Result := 'Pré-Autorização com cartão de crédito';
    017: Result := 'Consulta de cheques – a vista';
    018: Result := 'Consulta de cheques – pré-datados';
    020: Result := 'Cartão de débito à vista forçada';
    021: Result := 'Cartão de débito pré-datada';
    022: Result := 'Cartão de débito parc. sem parcela à vista';
    023: Result := 'Cartão de débito parc. parcela à vista';
    024: Result := 'Cartão de débito parc. parcela à vista forçada';
    025: Result := 'Vale Gás';
    027: Result := 'Cartão de crédito parc. adm.';
    028: Result := 'Cartão de crédito parc. est.';
    031: Result := 'Cancelamento de débito';
    032: Result := 'Cancelamento de crédito';
    034: Result := 'Compra CDC (CNS)';
    035: Result := 'Garantia de cheques';
    036: Result := 'Desconto de cheques';
    037: Result := 'Solicitação de resumo de vendas';
    039: Result := 'Cartão de crédito IATA';
    040: Result := 'Cartão de crédito IATA parc. com juros';
    041: Result := 'Cartão de crédito IATA parc. sem juros';
    042: Result := 'Cancelamento de credito IATA';
    043: Result := 'Cancelamento cartão CDC';
    044: Result := 'Consulta planos de pagamento para cartão CDC';
    045: Result := 'Cartão CDC';
    047: Result := 'Consulta parcelas de crédito';
    048: Result := 'Consulta parcelas de débito';
    050: Result := 'cartão de débito Voucher';
    051: Result := 'Cancelamento com cartão de débito Voucher';
    056: Result := 'Cancelamento de garantia de cheque';
    058: Result := 'Consulta AVS';
    059: Result := 'Cash';
    060: Result := 'Cancelamento de Cash';
    061: Result := 'Confirmação de Pré-Autorização';
    062: Result := 'Estorno de Pré-Autorização';
    063: Result := 'Consulta de Pontos - Fidelidade';
    064: Result := 'Consulta saldo de crédito';
    065: Result := 'Consulta Cash';
    066: Result := 'Uso interno';
    067: Result := 'Uso interno';
    068: Result := 'Consulta valores possíveis de recarga de celular';
    069: Result := 'Recarga de celular';
    070: Result := 'Consulta saldo';
    071: Result := 'Consulta extrato resumido';
    072: Result := 'Consulta extrato';
    073: Result := 'Simulação de saque';
    074: Result := 'Saque – Crédito';
    075: Result := 'Consulta saldo de investimento';
    076: Result := 'Consulta extrato de investimento';
    077: Result := 'Resgate avulso';
    078: Result := 'Resgate';
    079: Result := 'Cancelamento de saque';
    080: Result := 'Cancelamento de resgate';
    081: Result := 'Obtém cartão de investimento';
    082: Result := 'Consulta medicamento';
    083: Result := 'Compra medicamento';
    084: Result := 'Estorno compra medicamento';
    085: Result := 'Pagamento de conta com cartão';
    086: Result := 'Solicitação de autorização';
    087: Result := 'Pagamento de conta sem cartão';
    088: Result := 'Débito Voucher parcelado';
    089: Result := 'Consulta pagamento de conta';
    090: Result := 'Estorno de pagamento de conta';
    091: Result := 'Pagamento de fatura';
    092: Result := 'Consulta Saldo Dèbito';
    093: Result := 'Resumo de Pagamentos';
    094: Result := 'Baixa de O.S.';
    095: Result := 'Teste de Comunicação';
    096: Result := 'Estatística';
    097: Result := 'Moedeiro';
    098: Result := 'Cartão Dinheiro';
    099: Result := 'Estorno Cartão Dinheiro';
    100: Result := 'Consulta Contrato';
    101: Result := 'Saque INSS';
    102: Result := 'Saque Cpcheque';
    103: Result := 'Consulta Vale Gás';
    104: Result := 'Compra de Cheque Pré-Datada';
    105: Result := 'Depósito CDB';
    106: Result := 'Resgate CDB';
    107: Result := 'Estorno de Depósito CDB';
    108: Result := 'Estorno de Resgate CDB';
    109: Result := 'Cartão de Crédito com juros';
    110: Result := 'Carga de Cartão Dinheiro';
    111: Result := 'Consulta Saldo do Cartão Dinheiro';
    112: Result := 'Estorno da Carga de Cartão Dinheiro';
    113: Result := 'Parcele Mais';
    114: Result := 'Estorno do Parcele Mais';
    115: Result := 'Transação Off-line';
    116: Result := 'Reservado';
    117: Result := 'Reservado';
    118: Result := 'Troco Surpresa (Chance Legal)';
    119: Result := 'Captura Pré-autorização parc. est.';
    120: Result := 'Captura Pré-autorização parc. adm.';
    121: Result := 'Consulta Resgate de Prêmios';
    122: Result := 'Pagamento de DARF';
    123: Result := 'Pagamento de GPS';
    124: Result := 'Injeção de chaves';
    125: Result := 'Débito parc. pela adm.';
    126: Result := 'Envio de off-line';
    127: Result := 'Atualização de chip';
    128: Result := 'Autorização de Voucher';
    129: Result := 'Compra Crédito parcelado plano';
    130: Result := 'Empréstimo';
    131: Result := 'Consulta Genérica';
    132: Result := 'Carga Cartão Presente';
    133: Result := 'Simulação Crediário';
    134: Result := 'Crediário';
    135: Result := 'Pagamento Mobile';
    136: Result := 'Atualização de preços';
    137: Result := 'Elegibilidade Cartão PBM';
    138: Result := 'Pré-autorização Medicamento - PBM';
    139: Result := 'Cancelamento Pré-aut. Medicamento - PBM';
    140: Result := 'Troca de senha do chip';
    141: Result := 'Reservado';
    142: Result := 'Cancelamento de Autorização de Voucher';
    143: Result := 'Pré-autorização parc. est.';
    144: Result := 'Pré-autorização parc. adm.';
    145: Result := 'Acúmulo Por Valor – Fidelidade';
    146: Result := 'Acúmulo Por Pontos – Fidelidade';
    147: Result := 'Resgate de Produto – Fidelidade';
    148: Result := 'Resgate Monetizado – Fidelidade';
    149: Result := 'Cancelamento de Operação Fidelidade';
    150: Result := 'Logon Manual';
    154: Result := 'Verifica Cartão de Pagamento Recorrente';
    155: Result := 'Cadastra Pagamento Recorrente';
    156: Result := 'Inclui Cartão de Pagamento Recorrente';
    157: Result := 'Estorno de Cadastro de Pagamento Recorrente';
    158: Result := 'Saque – Débito';
    159: Result := 'Débito para Pagamento de Fatura';
    161: Result := 'Consulta Cartão Online';
    167: Result := 'Baixa Tecnica PDV';
    168: Result := 'QR Code Comprador';
    169: Result := 'QR Code Vendedor';
    170: Result := 'Estorno Carteira Virtual';
    172: Result := 'Consulta Perguntas Dinâmicas';
    173: Result := 'Crediário Crédito';
    174: Result := 'Simulação Crediário Crédito';
    175: Result := 'Consulta Cartões por CPF';
    178: Result := 'Consulta Pagamento de Fatura';
    179: Result := 'Consulta Fatura Detalhada';
    180: Result := 'Consulta Parâmetros Débito';
    181: Result := 'Consulta Parâmetros Crédito';
    183: Result := 'Consulta Conversão de Moeda para Crédito';
    184: Result := 'Consulta Conversão de Moeda para Débito';
    185: Result := 'Verifica Integridade PDV';
    186: Result := 'Pagamento CDC';
    187: Result := 'Crédito Parc. Cliente';
    188: Result := 'Simulação Crédito Parc. Cliente';
  else
    Result := '';
  end;

  if ATipCar = 'V' then
    Result := Result + ' | Carteira Vitual'
  else
  if ATipCar = 'C' then
    Result := Result + ' | Chip'
  else
  if ATipCar = 'S' then
    Result := Result + ' | Contactless'
  else
  if ATipCar = 'M' then
    Result := Result + ' | Magnético';
end;

function TTransaocaoTefParserScope.fGetNomeBandeira(
  const ACodBan: string): string;
begin
  Result := FUtils.fNomeBandeira(ACodBan);

  if Result.IsEmpty then
    Result := ACodBan;
end;

function TTransaocaoTefParserScope.fGetNomeRede(const ACodRed: string): string;
begin
  Result := FUtils.fNomeAdquirente(ACodRed);

  if Result.IsEmpty then
    Result := ACodRed;
end;

function TTransaocaoTefParserScope.fGetStatus(const ASituacao: string): TTransacaoTefStatus;
begin
  if ASituacao.Equals('O') then
    Result := stConfirmada
  else
  if ASituacao.Equals('N') then
    Result := stCancelada
  else
  if ASituacao.Equals('D') then
    Result := stCancelada
  else
  if ASituacao.Equals('d') then
    Result := stCancelamentoPendente
  else
  if ASituacao.Equals('C') then
    Result := stCancelada
  else
  if ASituacao.Equals('K') then
    Result := stEstorno
  else
  if ASituacao.Equals('k') then
    Result := stCancelamentoPendente
  else
  if ASituacao.Equals('1') then
    Result := stGenerico
  else
  if ASituacao.Equals('2') then
    Result := stPendente
  else
    Result := stGenerico;
end;

function TTransaocaoTefParserScope.fGetStrStatus(
  const ASituacao: string): string;
begin
  if ASituacao.Equals('O') then
    Result := 'CONFIRMADA'
  else
  if ASituacao.Equals('N') then
    Result := 'NEGADA'
  else
  if ASituacao.Equals('D') then
    Result := 'DESFEITA'
  else
  if ASituacao.Equals('d') then
    Result := 'DESFAZIMENTO PENDENTE'
  else
  if ASituacao.Equals('C') then
    Result := 'CANCELADA'
  else
  if ASituacao.Equals('K') then
    Result := 'ESTORNO AUTORIZADO'
  else
  if ASituacao.Equals('k') then
    Result := 'ESTORNO PENDENTE'
  else
  if ASituacao.Equals('1') then
    Result := 'EM ANDAMENTO'
  else
  if ASituacao.Equals('2') then
    Result := 'PENDENTE'
  else
    Result := '';
end;

function TTransaocaoTefParserScope.fJsonToDados(
  const AJson: string): TTransacaoTefDados;
var
  LlstDados: TTransacaoTefDadosLista;
begin
  LlstDados := nil;
  try
    LlstDados := Self.fJsonStrToDadosLista(AJson);

    if LlstDados.Count = 0 then
      raise TTrasacaoTefNotFoundException.Create('Transação não encontrada.');

    Result := LlstDados.First;
  finally
    if Assigned(LlstDados) then
      FreeAndNil(LlstDados);
  end;
end;

function TTransaocaoTefParserScope.fJsonToLista(
  const AJson: string; const AApenasPendentes: Boolean = False): TTransacaoTefDadosLista;
begin
  try
    Result := Self.fJsonStrToDadosLista(AJson, AApenasPendentes);

    //ordenar registros por data/hora
    Result.Sort(TComparer<TTransacaoTefDados>.Construct(fCompararTransacoesPorDataHora));
  except
    raise;
  end;

  Result.Sort();
end;

function TTransaocaoTefParserScope.fJsonToMsgErro(
  const AJson: string): String;
var
  LJsonObject: TJsonObject;
begin
  try
    try
      LJsonObject := TJsonObject.ParseJSONValue(AJson)as TJsonObject;
      Result := LJsonObject.GetValue<string>('mensagem');
    except
      Result := '';
    end;
  finally
    if Assigned(LJsonObject) then
      FreeAndNil(LJsonObject);
  end;
end;

function TTransaocaoTefParserScope.fJsonStrToDadosLista(const AJson: string; const AApenasPendentes: Boolean = False): TTransacaoTefDadosLista;
var
  LJsonValue: TJSONValue;
  LTransacoesArray: TJsonArray;
  LTransacaoObject: TJSONObject;
  LTransacaoItem: TTransacaoTefDados;
  LintCount: Integer;
  LStatus: TTransacaoTefStatus;
  LstrTipCar: string;
begin
  Result := TList<TTransacaoTefDados>.Create();
  try
    try
      LJsonValue := TJsonObject.ParseJSONValue(AJson);

      if not Assigned(LJsonValue) then
        raise Exception.Create('JSON inválido ou string vazia');

      if LJsonValue is TJSONArray then
        LTransacoesArray := LJsonValue as TJSONArray
      else
        raise Exception.Create('A string JSON não representa um array');

      for LintCount := 0 to LTransacoesArray.Count - 1 do
      begin
        LTransacaoObject := LTransacoesArray.Items[LintCount] as TJSONObject;
        FillChar(LTransacaoItem,SizeOf(LTransacaoItem),#0);

        LStatus := Self.fGetStatus(LTransacaoObject.GetValue<string>('situacao_mensagem'));
        if AApenasPendentes then
        begin
          if (LStatus <> stPendente) and (LStatus <> stCancelamentoPendente) then
            Continue;
        end;
        LTransacaoItem.DtaHra := Self.fGetDtaHra(LTransacaoObject.GetValue<string>('dt_administradora'), LTransacaoObject.GetValue<string>('data_mensagem'));
        LTransacaoItem.NumNsu := LTransacaoObject.GetValue<string>('nsu');
        LTransacaoItem.NsuHos := LTransacaoObject.GetValue<string>('nsu_host');
        LTransacaoItem.NumPdv := copy(LTransacaoItem.NumNsu, 1, 3) ;
        LTransacaoItem.TipTrn := 'TEF';
        try
          LstrTipCar := LTransacaoObject.GetValue<string>('tipo_cartao')
        except
          LstrTipCar := '';
        end;
        LTransacaoItem.InfTrn := Self.fGetInfo(StrToIntDef(LTransacaoObject.GetValue<string>('cod_servico'), 0), LstrTipCar);
        LTransacaoItem.Status := LStatus;
        LTransacaoItem.Estado := Self.fGetStrStatus(LTransacaoObject.GetValue<string>('situacao_mensagem'));
        try
          LTransacaoItem.ValTrn := LTransacaoObject.GetValue<Double>('valor');
        except
          LTransacaoItem.ValTrn := 0;
        end;
        LTransacaoItem.CodSit := LTransacaoObject.GetValue<string>('situacao_mensagem');
        LTransacaoItem.CodEst := LTransacaoObject.GetValue<string>('cod_estabelecimento');
        LTransacaoItem.CodLoj := '';
        try
          LTransacaoItem.QtdPar := LTransacaoObject.GetValue<Integer>('qtd_parcelas');
        except
          LTransacaoItem.QtdPar := 0;
        end;
        LTransacaoItem.CodAut := LTransacaoObject.GetValue<string>('cod_autorizacao');
        LTransacaoItem.CodRed := LTransacaoObject.GetValue<string>('cod_rede');
        LTransacaoItem.NomRed := Self.fGetNomeRede(LTransacaoObject.GetValue<string>('cod_rede'));
        LTransacaoItem.NomBan := Self.fGetNomeBandeira(LTransacaoObject.GetValue<string>('cod_bandeira'));
        LTransacaoItem.NumCar := LTransacaoObject.GetValue<string>('numero_conta');
        LTransacaoItem.Contro := Self.fGetControle(
          LTransacaoObject.GetValue<string>('data_mensagem'),
          LTransacaoObject.GetValue<string>('nsu'),
          LTransacaoObject.GetValue<string>('cod_filial'),
          LTransacaoObject.GetValue<string>('cod_empresa')
        );
        LTransacaoItem.Versao := LTransacaoObject.GetValue<string>('versao_grav');

        Result.Add(LTransacaoItem);
      end;
    finally
      if Assigned(LJsonValue) then
        FreeandNil(LJsonValue);
    end;
  except
    on E: Exception do
    begin
      raise TTrasacaoTefParseException.Create('Erro ao converter resposta: ' + E.Message);
    end;
  end;
end;

{ TTransacaoTefRepositoryScope }

constructor TTransacaoTefRepositoryScope.Create;
begin
  FCredenciais := TScopeCredencial.Create;
  FParser := TTransaocaoTefParserScope.Create;
end;

destructor TTransacaoTefRepositoryScope.Destroy;
begin
  FreeAndNil(FParser);
  FreeAndNil(FCredenciais);
  inherited;
end;

function TTransacaoTefRepositoryScope.fBuscarTransacao(
  AParam: TTransacaoTefBuscaParam): TTransacaoTefDados;
var
  LStrPar, LStrJsonRet: string;
begin
  FillChar(Result,SizeOf(Result),#0);

  LStrPar := '';
  pAddStrPar(LStrPar,'nsu', AParam.NumNsu);
  pAddStrPar(LStrPar,'data_mensagem', FParser.fDateTimeToDataApi(AParam.DtaTrn));

  if not AParam.NumCar.IsEmpty then
    pAddStrPar(LStrPar,'numero_conta', AParam.NumCar);

  if fEnviarRequisicao('scopeUnico1', LStrPar, LStrJsonRet) then
    Result := FParser.fJsonToDados(LStrJsonRet)
  else
    raise TTrasacaoTefResponseException.Create('API Consulta Scope [fBuscarTransacao]' + IfThen(not LStrJsonRet.IsEmpty, ': ' + FParser.fJsonToMsgErro(LStrJsonRet)));

  pAjustarStatusPendencia(Result);
end;

function TTransacaoTefRepositoryScope.fBuscarTransacoes(const ADate: TDate; var AStrJson: string): Boolean;
var
  LResource: string;
begin
  if Trunc(ADate) = Trunc(VS_Date) then
    LResource := 'scopeDia'
  else if Trunc(ADate) = (Trunc(VS_Date) - 1) then
    LResource := 'scopeDiaMenos1'
  else
    raise TTransacaoTefRequestException.Create('A API Consulta Scope permite apenas consultas de transações do mesmo dia ou do dia anterior (exceto consulta por transação específica).');

  Result := fEnviarRequisicao(LResource, '', AStrJson);
end;

function TTransacaoTefRepositoryScope.fBuscarTransacoesPendentes(
  const ADateFrom, ADateTo: TDate): TTransacaoTefDadosLista;
var
  LStrJsonRet: string;
  LResult: Boolean;
begin
  LResult := fBuscarTransacoes(ADateFrom, LStrJsonRet);
  if not LResult then
   raise TTrasacaoTefResponseException.Create('API Consulta Scope [fBuscarTransacoesPendentes]' + IfThen(not LStrJsonRet.IsEmpty, ': ' + FParser.fJsonToMsgErro(LStrJsonRet)))
  else
  begin
    Result := FParser.fJsonToLista(LStrJsonRet, True);
    Self.pAjustarStatusPendencia(Result);
  end;
end;

function TTransacaoTefRepositoryScope.fBuscarTransacoesPorData(
  const ADate: TDate): TTransacaoTefDadosLista;
var
  LStrJsonRet: string;
  LResult: Boolean;
begin
  LResult := fBuscarTransacoes(ADate, LStrJsonRet);
  if not LResult then
    raise TTrasacaoTefResponseException.Create('API Consulta Scope [fBuscarTransacoesPorData]' + IfThen(not LStrJsonRet.IsEmpty, ': ' + FParser.fJsonToMsgErro(LStrJsonRet)))
  else
  begin
    Result := FParser.fJsonToLista(LStrJsonRet);
    Self.pAjustarStatusPendencia(Result);
  end;
end;

function TTransacaoTefRepositoryScope.fCancelarTransacaoPendente(
  const ATrn: TTransacaoTefDados): Boolean;
var
  LStrPar, LStrJsonRet: string;
  LMsgErro: string;
begin
  if not fVerificarSeTrnEstaPendendente(ATrn) then
    raise TTransacaoTefRequestException.Create('A transação a ser desfeita deve estar pendente!');

  if TScopeControleOperacoes.fTransacaoComTravaAtiva(ATrn.Contro, LMsgErro) then
    raise TTransacaoTefRequestException.Create(LMsgErro);

  LStrPar := '';
  pAddStrPar(LStrPar,'nsu', ATrn.NumNsu);
  pAddStrPar(LStrPar,'versao_grav', ATrn.Versao);

  Result := fEnviarRequisicao('scopeDesfazerVendaPendente', LStrPar, LStrJsonRet);

  if Result then
    Self.pRegistrarPendencia(ATrn, toDesfazimentoSolicitado)
  else
    raise TTrasacaoTefResponseException.Create('API Consulta Scope [fCancelarTransacaoPendente]' + IfThen(not LStrJsonRet.IsEmpty, ': ' + FParser.fJsonToMsgErro(LStrJsonRet)));
end;

function TTransacaoTefRepositoryScope.fConfirmarTransacaoPendente(
  const ATrn: TTransacaoTefDados): Boolean;
var
  LStrPar, LStrJsonRet: string;
  LStrMsgValidacao: string;
begin
  if not fVerificarSeTrnEstaPendendente(ATrn) then
    raise TTransacaoTefRequestException.Create('A transação a ser confirmada deve estar pendente!');

  if TScopeControleOperacoes.fTransacaoComTravaAtiva(ATrn.Contro, LStrMsgValidacao) then
    raise TTransacaoTefRequestException.Create(LStrMsgValidacao);

  LStrPar := '';
  pAddStrPar(LStrPar,'nsu', ATrn.NumNsu);
  pAddStrPar(LStrPar,'versao_grav', ATrn.Versao);

  Result := fEnviarRequisicao('scopeConfirmarVendaPendente', LStrPar, LStrJsonRet);

  if Result then
    Self.pRegistrarPendencia(ATrn, toConfirmacaoSolicitada)
  else
    raise TTrasacaoTefResponseException.Create('API Consulta Scope [fConfirmarTransacaoPendente]' + IfThen(not LStrJsonRet.IsEmpty, ': ' + FParser.fJsonToMsgErro(LStrJsonRet)));
end;

function TTransacaoTefRepositoryScope.fEnviarRequisicao(AResource, AStrParams: string; var AStrJson: string): Boolean;
var
  LControllerRest: TControllerRest;
  LRestRequest: TRestRequest;
  LStrParamsCod: string;
  LMsgErro: string;
begin
  if not Self.fVerificarCredenciais then
    raise TTrasacaoTefCredenciaisException.Create('Credenciais inválidas. Verificar CFGs: CFG_CS_USR, CFG_CS_PWD, CFG_CS_URL, CFG_CS_COD, CFG_CS_TOK.');

  AStrJson := '';
  LStrParamsCod := AStrParams;
  LControllerRest := TControllerRest.Create('SCTRN', TTransacaoTefRestConfigScope.fConfigurarScope);
  LRestRequest := TRestRequest.Create(LControllerRest.RestClient);

  try
    LRestRequest.Client.BaseURL := FCredenciais.fUrl;
    LRestRequest.Method := rmPOST;
    LRestRequest.Resource := AResource;

    pAddStrPar(LStrParamsCod, 'key', FCredenciais.fChave);
    pAddStrPar(LStrParamsCod, 'cnpj', FCredenciais.fCnpj);
    pAddStrPar(LStrParamsCod, 'token', FCredenciais.fToken);
    pAddParRequest(LRestRequest, LStrParamsCod);

    if Assigned(LRestRequest.Client.Authenticator) then
      LRestRequest.Client.Authenticator.Free;
    LRestRequest.Client.Authenticator := THTTPBasicAuthenticator.Create(FCredenciais.fUsuario, FCredenciais.fSenha);

    Result := LControllerRest.fExecute(LRestRequest, AStrJson, ['200','201']);

    if not Result then
    begin
      LMsgErro := EmptyStr;
      if Assigned(LRestRequest.Response) then
      begin
       if (LRestRequest.Response.StatusCode = 401) then
         LMsgErro := 'Credenciais não autorizadas, Verificar CFGs: CFG_CS_USR, CFG_CS_PWD.';
       if (LRestRequest.Response.StatusCode = 404) then
         LMsgErro := 'A url da API é inválida: ' + FCredenciais.fUrl;
      end;

      if LMsgErro.IsEmpty then
      begin
        LMsgErro := 'A API Scope não retornou o resultado desejado, tente novamente.';
        if not AStrJson.IsEmpty then
         LMsgErro := FParser.fJsonToMsgErro(AStrJson);
      end;
      raise Exception.Create(LMsgErro);
    end;
  finally
    FreeAndNil(LRestRequest);
    FreeAndNil(LControllerRest);
  end;
end;

class function TTransacaoTefRepositoryScope.New: ITransacaoTefRepository;
begin
  Result := Self.Create;
end;

procedure TTransacaoTefRepositoryScope.pAddParRequest(
  var ARequest: TRestRequest; AStrPar: string);
var
  LParameters: TStringList;
  LParam: string;
  LPos: Integer;
begin
  LParameters := TStringList.Create;
  try
    LParameters.Delimiter := ';';
    LParameters.DelimitedText := AStrPar;
    for LParam in LParameters do
    begin
      LPos := Pos('|', LParam);
      ARequest.Params.AddItem(Copy(LParam, 1, LPos - 1), Copy(LParam, LPos + 1, Length(LParam) - LPos), TRESTRequestParameterKind.pkGETorPOST);
    end;
  finally
    FreeAndNil(LParameters);
  end;
end;

procedure TTransacaoTefRepositoryScope.pAddStrPar(var AStr: string; const AKey,
  AValue: string);
begin
  if AStr <> '' then
    AStr := AStr + ';';

  AStr := AStr + AKey + '|' + AValue;
end;

procedure TTransacaoTefRepositoryScope.pAjustarStatusPendencia(
  var ATrn: TTransacaoTefDados);
var
  LStatus: TScopeTipoOperacao;
begin
  if ATrn.Status <> stPendente then
    Exit;

  LStatus := TScopeControleOperacoes.fStatusControle(ATrn.Contro);

  pAjustarStatusPendenciaInterno(ATrn, LStatus);
end;

procedure TTransacaoTefRepositoryScope.pAjustarStatusPendencia(
  ALstTrn: TTransacaoTefDadosLista);
var
  LCount, LIndexOf, I: Integer;
  LItem: TTransacaoTefDados;
  LListPendentes: TTransacaoTefDadosLista;
  LdictStatus: TDictionary<string, TScopeTipoOperacao>;
  LStatus: TScopeTipoOperacao;
begin
  if (not Assigned(ALstTrn)) or (ALstTrn.Count = 0) then
    Exit;

  LListPendentes := TTransacaoTefDadosLista.Create;
  try
    for LItem in ALstTrn do
    begin
      if LItem.Status = stPendente then
        LListPendentes.Add(LItem);
    end;

    LCount := LListPendentes.Count;
    if LCount = 1 then
    begin
      LItem := LListPendentes.Items[0];
      LIndexOf := ALstTrn.IndexOf(LItem);

      LStatus := TScopeControleOperacoes.fStatusControle(LItem.Contro);
      pAjustarStatusPendenciaInterno(LItem, LStatus);
      ALstTrn[LIndexOf] := LItem;

      Exit;
    end;

    if LCount = 0 then
      Exit;

    LdictStatus := TScopeControleOperacoes.fStatusOperacoesRecentes(LListPendentes);
    if not Assigned(LdictStatus) then
      Exit;

    try
      for I := 0 to Pred(LListPendentes.Count) do
      begin
        LItem := LListPendentes.Items[I];
        LIndexOf := ALstTrn.IndexOf(LItem);

        if LdictStatus.TryGetValue(LItem.Contro, LStatus) then
        begin
          pAjustarStatusPendenciaInterno(LItem, LStatus);
          ALstTrn[LIndexOf] := LItem;
        end;
      end;

    finally
      FreeAndNil(LdictStatus);
    end;
  finally
    FreeAndNil(LListPendentes);
  end;
end;

procedure TTransacaoTefRepositoryScope.pAjustarStatusPendenciaInterno(
  var ATrn: TTransacaoTefDados; const ATipo: TScopeTipoOperacao);
begin
  case ATipo of
    toConfirmacaoSolicitada:
      begin
        ATrn.Status := stConfirmacaoPendente;
        ATrn.Estado := 'PENDÊNCIA COM CONFIRMAÇÃO SOLICITADA';
      end;

    toDesfazimentoSolicitado:
      begin
        ATrn.Status := stCancelamentoPendente;
        ATrn.Estado := 'PENDÊNCIA COM CANCELAMENTO SOLICITADO';
      end;
  end;
end;

procedure TTransacaoTefRepositoryScope.pRegistrarPendencia(const ATrn: TTransacaoTefDados; const ATipo: TScopeTipoOperacao);
begin
  TScopeControleOperacoes.pRegistrarOperacao(ATrn, ATipo);
end;

function TTransacaoTefRepositoryScope.fVerificarCredenciais: Boolean;
begin
  Result := True;

  if FCredenciais.fUsuario.IsEmpty then
  begin
    Result := False;
    Exit;
  end;

  if FCredenciais.fSenha.IsEmpty then
  begin
    Result := False;
    Exit;
  end;

  if FCredenciais.fUrl.IsEmpty then
  begin
    Result := False;
    Exit;
  end;

  if FCredenciais.fToken.IsEmpty then
  begin
    Result := False;
    Exit;
  end;
end;

function TTransacaoTefRepositoryScope.fVerificarSeTrnEstaPendendente(
  const ATrn: TTransacaoTefDados): Boolean;
var
  LTrnAux: TTransacaoTefDados;
  LTrnPar: TTransacaoTefBuscaParam;
begin
  FillChar(LTrnPar,SizeOf(LTrnPar),#0);
  LTrnPar.DtaTrn := ATrn.DtaHra;
  LTrnPar.NumNsu := ATrn.NumNsu;
  LTrnPar.NumCar := ATrn.NumCar;

  LTrnAux := Self.fBuscarTransacao(LTrnPar);
  Result := LTrnAux.Status = stPendente;
end;

end.
