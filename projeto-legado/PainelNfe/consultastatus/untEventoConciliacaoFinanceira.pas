unit untEventoConciliacaoFinanceira;

interface

uses
{$IFDEF LINUX}
  NFe.Utils,
  NFe.Modulo,
{$ELSE}
  untUtil,
  untModulo,
  Windows,
  ActiveX,
{$ENDIF}
  SysUtils,
  Classes,
  Forms,
  Variants,
  StrUtils,
  DateUtils,
  untInterfaces,
  DB,
  untConfigNFE,

  {$IF Defined(UNIDAC)}
    Uni, UniSQLMonitor, MemDS, DBAccess
  {$ELSE}
    ZConnection, ZDataset
  {$IFEND}
  , untRegistrarTarefa;

  type
    TWSCitelRetorno = class(TInterfacedObject, IInterface)
  private
    FRetornoOk: Boolean;
    FTexto: String;
    FCodigo: String;
    FDescricao: String;
    FProtocolo: String;
    FSequencial: String;
  public
    constructor Create(ATexto: String);
    function RetornoOk: Boolean;
    function Texto: String;
    function Codigo: String;
    function Descricao: String;
    function Protocolo: String;
    function Sequencial: String;
  end;

  Type
    TEventoConciliacaoFinanceira = class
  private
    Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND};
    FTarefa: TRegistrarTarefa;
    FArquivo: TStringList;
    function fValor(const AValor: Double; APrecisao, ADecimais: Integer): String;
    function fDataHora(const AData: TDateTime): String;
    function fRetornaCodigoUF_IBGE(AUF:String): String;
    function fRetornaChaveAcesso(ANumDoc, AEspDoc, ACodEmp, ACodCli: String): String;
    function fEventoConciliacaoFinanceira: String;
    function fEnviaEventoConciliacaoFinanceira: TWSCitelRetorno;
    procedure pRetornaDadosBaixa(ANumDoc, AParcel, ASeqBai, ATipPag, ACodPag, AEspDoc, ACodCli, ACodEmp: String; var AAutInc: String; var AProtoc: String; var ASeqEve: String);
    procedure pMarcaEventoEstornado(APkBaixa, APkEstorno: String);
    procedure pEventoDeConciliacaoFinanceira(AModelo, AAcesso, ADtaEve: String);
    procedure pEventoDeConciliacaoFinanceiraDetalhamento(ATipPag, ACodPag, ADesPag: String; AValPag: Double; ADtaPag: TDateTime;
                                                         ACnpjPg, AUf_Pag, ACnpjFi, ACodCar, ANumAut, ACnpjBf, AUf_Ben: String);
    procedure pEventoDeConciliacaoFinanceiraCancelamento(AModelo, AAcesso, ADtaEve, ASeqEve, AProtoc: String);
  public
    constructor Create(ATarefa: TRegistrarTarefa);
    procedure Executar;
    destructor Destroy; override;
  end;

implementation

{ TEventoConciliacaoFinanceira }

uses untLibNfe, untDicSis;


function TEventoConciliacaoFinanceira.fRetornaCodigoUF_IBGE(AUF:String): String;
begin
  Result := '';

  case IndexStr(AUF, ['RO','AC','AM','RR','PA','AP','TO','MA','PI','CE','RN','PB','PE','AL','SE','BA','MG','ES','RJ','SP','PR','SC','RS','MS','MT','GO','DF','SU','RF','EX']) of
     0: Result := '11';
     1: Result := '12';
     2: Result := '13';
     3: Result := '14';
     4: Result := '15';
     5: Result := '16';
     6: Result := '17';
     7: Result := '21';
     8: Result := '22';
     9: Result := '23';
    10: Result := '24';
    11: Result := '25';
    12: Result := '26';
    13: Result := '27';
    14: Result := '28';
    15: Result := '29';
    16: Result := '31';
    17: Result := '32';
    18: Result := '33';
    19: Result := '35';
    20: Result := '41';
    21: Result := '42';
    22: Result := '43';
    23: Result := '50';
    24: Result := '51';
    25: Result := '52';
    26: Result := '53';
    27: Result := '90';
    28: Result := '91';
    29: Result := '99';
  end;
end;

function TEventoConciliacaoFinanceira.fRetornaChaveAcesso(ANumDoc, AEspDoc, ACodEmp, ACodCli: String): String;
Var
  qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := '';

  qryAux := fCriaQuery(Nil);

  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT FIS_ACESSO FROM CADFIS ');
    qryAux.SQL.Add('WHERE FIS_NUMDOC = :NUMDOC ');
    qryAux.SQL.Add('  AND FIS_ESPDOC = :ESPDOC ');
    qryAux.SQL.Add('  AND FIS_CODEMP = :CODEMP ');
    qryAux.SQL.Add('  AND FIS_FORCLI = :FORCLI ');
    qryAux.SQL.Add('  AND FIS_TIP_FC = :TIP_FC ');
    qryAux.ParamByName('NUMDOC').AsString := ANumDoc;
    qryAux.ParamByName('ESPDOC').AsString := AEspDoc;
    qryAux.ParamByName('CODEMP').AsString := ACodEmp;
    qryAux.ParamByName('FORCLI').AsString := ACodCli;
    qryAux.ParamByName('TIP_FC').AsString := 'C';
    qryAux.Open;

    Result := qryAux.FieldByName('FIS_ACESSO').AsString;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TEventoConciliacaoFinanceira.pRetornaDadosBaixa(ANumDoc, AParcel, ASeqBai, ATipPag, ACodPag, AEspDoc, ACodCli, ACodEmp: String; var AAutInc: String; var AProtoc: String; var ASeqEve: String);
Var
  qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin

  qryAux := fCriaQuery(Nil);

  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT AUTOINCREM, ECO_PROTOC, ECO_SEQEVE FROM ECONFE ');
    qryAux.SQL.Add('WHERE ECO_NUMDOC = :NUMDOC ');
    qryAux.SQL.Add('  AND ECO_PARCEL = :PARCEL ');
    qryAux.SQL.Add('  AND ECO_SEQBAI = :SEQBAI ');
    qryAux.SQL.Add('  AND ECO_TIPPAG = :TIPPAG ');
    qryAux.SQL.Add('  AND ECO_CODPAG = :CODPAG ');
    qryAux.SQL.Add('  AND ECO_ESPDOC = :ESPDOC ');
    qryAux.SQL.Add('  AND ECO_CODCLI = :CODCLI ');
    qryAux.SQL.Add('  AND ECO_CODEMP = :CODEMP ');
    qryAux.SQL.Add('  AND IFNULL(ECO_SEQEST,"") = "" ');
    qryAux.SQL.Add('  AND IFNULL(ECO_FINALI,"") = "BAIXA" ');
    qryAux.SQL.Add('ORDER BY AUTOINCREM ');
    qryAux.SQL.Add('LIMIT 1 ');
    qryAux.ParamByName('NUMDOC').AsString := ANumDoc;
    qryAux.ParamByName('PARCEL').AsString := AParcel;
    qryAux.ParamByName('SEQBAI').AsString := ASeqBai;
    qryAux.ParamByName('TIPPAG').AsString := ATipPag;
    qryAux.ParamByName('CODPAG').AsString := ACodPag;
    qryAux.ParamByName('ESPDOC').AsString := AEspDoc;
    qryAux.ParamByName('CODCLI').AsString := ACodCli;
    qryAux.ParamByName('CODEMP').AsString := ACodEmp;
    qryAux.Open;

    AAutInc := qryAux.FieldByName('AUTOINCREM').AsString;
    AProtoc := qryAux.FieldByName('ECO_PROTOC').AsString;
    ASeqEve := qryAux.FieldByName('ECO_SEQEVE').AsString;
  Finally
    FreeAndNil(qryAux);
  End;

end;

procedure TEventoConciliacaoFinanceira.pMarcaEventoEstornado(APkBaixa, APkEstorno: String);
Var
  qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin

  qryAux := fCriaQuery(Nil);

  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT AUTOINCREM, ECO_SEQEST FROM ECONFE ');
    qryAux.SQL.Add('WHERE AUTOINCREM = :AUTINC ');
    qryAux.ParamByName('AUTINC').AsString := APkBaixa;
    qryAux.Open;

    qryAux.Edit;
    qryAux.FieldByName('ECO_SEQEST').AsString := APkEstorno;
    qryAux.Post;

  Finally
    FreeAndNil(qryAux);
  End;

end;

function TEventoConciliacaoFinanceira.fEventoConciliacaoFinanceira: String;
var
  EventoConciliacaoFinanceiraService: IEventoConciliacaoFinanceiraService;
  objConfigSovos: TConfiguracoesNFE;
  LValCfgMDEVAR: String;
begin
  objConfigSovos := TConfiguracoesNFE.Create;

  Try
    Try
      objConfigSovos.strFitUrlWebService := fCfgSisPainel('CITURL');
      objConfigSovos.strFitLicenca       := fCfgSisPainel('CITLIC');
      objConfigSovos.strFitUsuario       := fCfgSisPainel('CITUSU');
      objConfigSovos.strFitSenha         := fCfgSisPainel('CITSEN');

      LValCfgMDEVAR := '';

      If fExisteConfiguracao('MDEVAR') Then
        LValCfgMDEVAR := fCfgSisPainel('MDEVAR');

      FArquivo.SaveToFile(fPnlDir('ULTIMO_ECONF.TXT'));

      EventoConciliacaoFinanceiraService := fCriarEventoConciliacaoFinanceiraServiceFITConfigurado(objConfigSovos, LValCfgMDEVAR);

      Result := EventoConciliacaoFinanceiraService.fEnviaTextoIntegracaoEventoDFe(FArquivo.Text);

    Except
      On E: Exception Do
      Begin
        pLogarErro(FTarefa.strTarefa, E);
        pLogImp('TEventoConciliacaoFinanceira.fEventoConciliacaoFinanceira ' + ' Erro: ' + E.Message);
      End;
    End;
  Finally
    FreeAndNil(objConfigSovos);
  End;
end;

function TEventoConciliacaoFinanceira.fEnviaEventoConciliacaoFinanceira: TWSCitelRetorno;
var
  LRetorno: String;
begin
  LRetorno := fEventoConciliacaoFinanceira;

  Result := TWSCitelRetorno.Create(LRetorno);
end;

procedure TEventoConciliacaoFinanceira.Executar;
Var
  qryEcoNfe: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  LAcesso: String;
  LModelo: String;
  LDtaEve: String;
  LSeqEve: String;
  LProtoc: String;
  LPkBaixa: String;
  LBaixa: Boolean;
  LEstorno: Boolean;
  WSCitelRetorno: TWSCitelRetorno;

  function fRetornaModelo(AEspDoc: String): String;
  begin
    Result := '';

    case IndexStr(AEspDoc, ['NF','IF']) of
      0: Result := '55';
      1: Result := '65';
    end;
  end;

begin

  If not fTabelaExiste('ECONFE') Then
    Exit;

  qryEcoNfe := fCriaQuery(Nil);

  Try
    qryEcoNfe.SQL.Clear;
    qryEcoNfe.SQL.Add('SELECT ');
    qryEcoNfe.SQL.Add('AUTOINCREM, ');
    qryEcoNfe.SQL.Add('ECO_NUMDOC, ');
    qryEcoNfe.SQL.Add('ECO_PARCEL, ');
    qryEcoNfe.SQL.Add('ECO_SEQBAI, ');
    qryEcoNfe.SQL.Add('ECO_ESPDOC, ');
    qryEcoNfe.SQL.Add('ECO_CODCLI, ');
    qryEcoNfe.SQL.Add('ECO_CODEMP, ');
    qryEcoNfe.SQL.Add('ECO_DTAINC, ');
    qryEcoNfe.SQL.Add('ECO_TIPPAG, ');
    qryEcoNfe.SQL.Add('ECO_CODPAG, ');
    qryEcoNfe.SQL.Add('ECO_DESPAG, ');
    qryEcoNfe.SQL.Add('ECO_VALPAG, ');
    qryEcoNfe.SQL.Add('ECO_DTAPAG, ');
    qryEcoNfe.SQL.Add('ECO_CNPJPG, ');
    qryEcoNfe.SQL.Add('ECO_UF_PAG, ');
    qryEcoNfe.SQL.Add('ECO_CNPJFI, ');
    qryEcoNfe.SQL.Add('ECO_CODCAR, ');
    qryEcoNfe.SQL.Add('ECO_NUMAUT, ');
    qryEcoNfe.SQL.Add('ECO_CNPJBF, ');
    qryEcoNfe.SQL.Add('ECO_UF_BEN, ');
    qryEcoNfe.SQL.Add('ECO_DTAENV, ');
    qryEcoNfe.SQL.Add('ECO_SEQEVE, ');
    qryEcoNfe.SQL.Add('ECO_PROTOC, ');
    qryEcoNfe.SQL.Add('ECO_FINALI, ');
    qryEcoNfe.SQL.Add('ECO_CODRET, ');
    qryEcoNfe.SQL.Add('ECO_MSGRET, ');
    qryEcoNfe.SQL.Add('ECO_DTARET  ');
    qryEcoNfe.SQL.Add('FROM ECONFE ');
    qryEcoNfe.SQL.Add('WHERE ECO_DTAENV IS NULL ');
    qryEcoNfe.SQL.Add('  AND ECO_CODEMP = :CODEMP ');
    qryEcoNfe.SQL.Add('ORDER BY AUTOINCREM ');
    qryEcoNfe.SQL.Add('LIMIT 100 ');
    qryEcoNfe.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryEcoNfe.Open;

    While not qryEcoNfe.Eof Do
    Begin
      FArquivo.Clear;

      If fEmptyStr(qryEcoNfe.FieldByName('ECO_TIPPAG').AsString) Then
      Begin
        qryEcoNfe.Next;
        Continue;
      End;

      If fEmptyStr(qryEcoNfe.FieldByName('ECO_CODPAG').AsString) Then
      Begin
        qryEcoNfe.Next;
        Continue;
      End;

      If fEmptyStr(qryEcoNfe.FieldByName('ECO_ESPDOC').AsString) Then
      Begin
        qryEcoNfe.Next;
        Continue;
      End;

      If fEmptyStr(qryEcoNfe.FieldByName('ECO_DTAINC').AsString) Then
      Begin
        qryEcoNfe.Next;
        Continue;
      End;

      If fEmptyStr(qryEcoNfe.FieldByName('ECO_FINALI').AsString) Then
      Begin
        qryEcoNfe.Next;
        Continue;
      End;

      LAcesso := fRetornaChaveAcesso(qryEcoNfe.FieldByName('ECO_NUMDOC').AsString,
                                     qryEcoNfe.FieldByName('ECO_ESPDOC').AsString,
                                     qryEcoNfe.FieldByName('ECO_CODEMP').AsString,
                                     qryEcoNfe.FieldByName('ECO_CODCLI').AsString);

      If fEmptyStr(LAcesso) Then
      Begin
        qryEcoNfe.Edit;
        qryEcoNfe.FieldByName('ECO_DTARET').AsDateTime := nOw();
        qryEcoNfe.FieldByName('ECO_CODRET').AsString   := '999';
        qryEcoNfe.FieldByName('ECO_MSGRET').AsString   := 'Documento Fiscal sem Chave de Acesso.';
        qryEcoNfe.Post;

        qryEcoNfe.Next;
        Continue;
      End;

      LModelo  := fRetornaModelo(qryEcoNfe.FieldByName('ECO_ESPDOC').AsString);
      LDtaEve  := fDataHora(qryEcoNfe.FieldByName('ECO_DTAINC').AsDateTime);
      LBaixa   := (UpperCase(qryEcoNfe.FieldByName('ECO_FINALI').AsString) = 'BAIXA');
      LEstorno := (UpperCase(qryEcoNfe.FieldByName('ECO_FINALI').AsString) = 'ESTORNO');

      If LBaixa Then
      Begin
        pEventoDeConciliacaoFinanceira(LModelo,
                                       LAcesso,
                                       LDtaEve);

        pEventoDeConciliacaoFinanceiraDetalhamento(qryEcoNfe.FieldByName('ECO_TIPPAG').AsString,
                                                   qryEcoNfe.FieldByName('ECO_CODPAG').AsString,
                                                   qryEcoNfe.FieldByName('ECO_DESPAG').AsString,
                                                   qryEcoNfe.FieldByName('ECO_VALPAG').AsFloat,
                                                   qryEcoNfe.FieldByName('ECO_DTAPAG').AsDateTime,
                                                   qryEcoNfe.FieldByName('ECO_CNPJPG').AsString,
                                                   qryEcoNfe.FieldByName('ECO_UF_PAG').AsString,
                                                   qryEcoNfe.FieldByName('ECO_CNPJFI').AsString,
                                                   qryEcoNfe.FieldByName('ECO_CODCAR').AsString,
                                                   qryEcoNfe.FieldByName('ECO_NUMAUT').AsString,
                                                   qryEcoNfe.FieldByName('ECO_CNPJBF').AsString,
                                                   qryEcoNfe.FieldByName('ECO_UF_BEN').AsString);
      End;

      If LEstorno Then
      Begin
        pRetornaDadosBaixa(qryEcoNfe.FieldByName('ECO_NUMDOC').AsString,
                           qryEcoNfe.FieldByName('ECO_PARCEL').AsString,
                           qryEcoNfe.FieldByName('ECO_SEQBAI').AsString,
                           qryEcoNfe.FieldByName('ECO_TIPPAG').AsString,
                           qryEcoNfe.FieldByName('ECO_CODPAG').AsString,
                           qryEcoNfe.FieldByName('ECO_ESPDOC').AsString,
                           qryEcoNfe.FieldByName('ECO_CODCLI').AsString,
                           qryEcoNfe.FieldByName('ECO_CODEMP').AsString,
                           LPkBaixa,
                           LProtoc,
                           LSeqEve);

        If fEmptyStr(LProtoc) Then
        Begin
          qryEcoNfe.Next;
          Continue;
        End;

        pEventoDeConciliacaoFinanceiraCancelamento(LModelo,
                                                   LAcesso,
                                                   LDtaEve,
                                                   LSeqEve,
                                                   LProtoc);
      End;

      If fEmptyStr(FArquivo.Text) Then
      Begin
        qryEcoNfe.Next;
        Continue;
      End;

      WSCitelRetorno := fEnviaEventoConciliacaoFinanceira;

      If WSCitelRetorno.RetornoOk Then
      Begin
        qryEcoNfe.Edit;
        qryEcoNfe.FieldByName('ECO_DTAENV').AsDateTime := nOw();
        qryEcoNfe.FieldByName('ECO_DTARET').AsDateTime := nOw();
        qryEcoNfe.FieldByName('ECO_CODRET').AsString   := WSCitelRetorno.Codigo;
        qryEcoNfe.FieldByName('ECO_MSGRET').AsString   := WSCitelRetorno.Descricao;
        qryEcoNfe.FieldByName('ECO_PROTOC').AsString   := WSCitelRetorno.Protocolo;
        qryEcoNfe.FieldByName('ECO_SEQEVE').AsString   := WSCitelRetorno.Sequencial;
        qryEcoNfe.Post;

        If LEstorno Then
          pMarcaEventoEstornado(LPkBaixa, qryEcoNfe.FieldByName('AUTOINCREM').AsString);
      End
      Else
      Begin
        qryEcoNfe.Edit;
        qryEcoNfe.FieldByName('ECO_DTARET').AsDateTime := nOw();
        qryEcoNfe.FieldByName('ECO_CODRET').AsString   := WSCitelRetorno.Codigo;
        qryEcoNfe.FieldByName('ECO_MSGRET').AsString   := WSCitelRetorno.Descricao;
        qryEcoNfe.Post;
      End;

      FreeAndNil(WSCitelRetorno);

      qryEcoNfe.Next;
    End;

  Finally
    FreeAndNil(qryEcoNfe);
  End;
end;

constructor TEventoConciliacaoFinanceira.Create(ATarefa: TRegistrarTarefa);
begin
  inherited Create;
  Banco    := frmModulo.Database;
  FTarefa  := ATarefa;
  FArquivo := TStringList.Create;
end;

destructor TEventoConciliacaoFinanceira.Destroy;
begin
  FreeAndNil(FArquivo);
  inherited;
end;

function TEventoConciliacaoFinanceira.fValor(const AValor: Double; APrecisao, ADecimais: Integer): String;
begin
  Result := FloatToStrF(AValor, ffNumber, APrecisao, ADecimais);
  Result := AnsiReplaceStr(Result, ',', '');
  Result := AnsiReplaceStr(Result, '.', '');
end;

function TEventoConciliacaoFinanceira.fDataHora(const AData: TDateTime): String;
begin
  Result := FormatDateTime('ddmmyyyyhhnnss', AData);
end;

procedure TEventoConciliacaoFinanceira.pEventoDeConciliacaoFinanceira(AModelo, AAcesso, ADtaEve: String);
var
  LLinha: String;
begin
  LLinha := '';
  LLinha := LLinha + 'NFE-ECONF|';     // 01 - Tipo do Registro
  LLinha := LLinha + '|';              // 02 - ID Referência - Informar quando não informado Chave de acesso
  LLinha := LLinha + AAcesso + '|';    // 03 - Numero da chave de acesso - Informar quando não informado ID Referencia
  LLinha := LLinha + ADtaEve + '|';    // 04 - Data Hora Evento - ddmmaaaaHHmmss
  LLinha := LLinha + '|';              // 05 - Número sequencial do item
  LLinha := LLinha + AModelo + '|';    // 06 - Modelo Documento - 55 – NF-e / 65 – NFC-e.

  FArquivo.Add(LLinha);
end;

procedure TEventoConciliacaoFinanceira.pEventoDeConciliacaoFinanceiraDetalhamento(ATipPag, ACodPag, ADesPag: String; AValPag: Double; ADtaPag: TDateTime;
                                                                                  ACnpjPg, AUf_Pag, ACnpjFi, ACodCar, ANumAut, ACnpjBf, AUf_Ben: String);
var
  LLinha: String;
begin
  LLinha := '';
  LLinha := LLinha + 'NFE-ECONF-DET-PAG|';                      // 01 - Tipo do Registro
  LLinha := LLinha + ATipPag + '|';                             // 02 - Tipo de pagamento - 0= Pagamento à Vista 1= Pagamento à Prazo.
  LLinha := LLinha + ACodPag + '|';                             // 03 - Meio de Pagamento - Utilizar a Tabela de códigos dos meios de pagamentos publicada no Portal Nacional da Nota Fiscal Eletrônica
  LLinha := LLinha + ADesPag + '|';                             // 04 - Descrição do meio de pagamento - Preencher informando o meio de pagamento utilizado quando o código do meio de pagamento for informado como 99-outros.
  LLinha := LLinha + fValor(AValPag, 15, 2) + '|';              // 05 - Valor do Pagamento
  LLinha := LLinha + FormatDateTime('ddmmyyyy', ADtaPag) + '|'; // 06 - Data do Pagamento - ddmmaaaa
  LLinha := LLinha + ACnpjPg + '|';                             // 07 - CNPJ do estabelecimento de pagamento
  LLinha := LLinha + fRetornaCodigoUF_IBGE(AUf_Pag) + '|';      // 08 - UF do CNPJ do estabelecimento de pagamento - Utilizar a Tabela do IBGE de código de unidades da federação (Seção 8.1 do MOC – Visão Geral, Tabela de UF, Município e País).
  LLinha := LLinha + ACnpjFi + '|';                             // 09 - CNPJ da instituição financeira
  LLinha := LLinha + ACodCar + '|';                             // 10 - Código da Operadora de cartão - Utilizar a Tabela de códigos dos meios de pagamentos publicada no Portal Nacional da Nota Fiscal Eletrônica
  LLinha := LLinha + ANumAut + '|';                             // 11 - Número de autorização da transação - Identifica o número da autorização da transação da operação
  LLinha := LLinha + ACnpjBf + '|';                             // 12 - CNPJ do estabelecimento beneficiário - CNPJ do estabelecimento beneficiário do pagamento
  LLinha := LLinha + fRetornaCodigoUF_IBGE(AUf_Ben) + '|';      // 13 - UF do CNPJ do estabelecimento beneficiário - Utilizar a Tabela do IBGE de código de unidades da federação (Seção 8.1 do MOC – Visão Geral, Tabela de UF, Município e País).

  FArquivo.Add(LLinha);
end;

procedure TEventoConciliacaoFinanceira.pEventoDeConciliacaoFinanceiraCancelamento(AModelo, AAcesso, ADtaEve, ASeqEve, AProtoc: String);
var
  LLinha: String;
begin
  LLinha := '';
  LLinha := LLinha + 'NFE-ECONF-CANC|'; // 01 - Tipo do Registro
  LLinha := LLinha + '|';               // 02 - ID Referencia - Informar quando não informado Chave de acesso
  LLinha := LLinha + AAcesso + '|';     // 03 - Numero da chave de acesso - Informar quando não informado ID Referencia
  LLinha := LLinha + ADtaEve + '|';     // 04 - Data Hora Evento - ddmmaaaaHHmmss
  LLinha := LLinha + ASeqEve + '|';     // 05 - Número sequencial do item
  LLinha := LLinha + AModelo + '|';     // 06 - Modelo Documento - 55 – NF-e / 65 – NFC-e
  LLinha := LLinha + AProtoc + '|';     // 07 - Número do Protocolo de Envio - Informar o número do Protocolo de Autorização do Evento da NF-e a que se refere este cancelamento

  FArquivo.Add(LLinha);
end;

{ TWSCitelRetorno }

constructor TWSCitelRetorno.Create(ATexto: String);
begin
  FTexto      := ATexto;
  FCodigo     := fGetValorLinha(ATexto, '|', 4);
  FDescricao  := fGetValorLinha(ATexto, '|', 5);
  FProtocolo  := fGetValorLinha(ATexto, '|', 6);
  FRetornoOk  := (fGetValorLinha(ATexto, '|', 4) = '135');
  FSequencial := fGetValorLinha(ATexto, '|', 8);
end;

function TWSCitelRetorno.RetornoOk: Boolean;
begin
  Result := FRetornoOk;
end;

function TWSCitelRetorno.Texto: String;
begin
  Result := FTexto;
end;

function TWSCitelRetorno.Codigo: String;
begin
  Result := FCodigo;
end;

function TWSCitelRetorno.Descricao: String;
begin
  Result := FDescricao;
end;

function TWSCitelRetorno.Protocolo: String;
begin
  Result := FProtocolo;
end;

function TWSCitelRetorno.Sequencial: String;
begin
  Result := FSequencial;
end;

end.
