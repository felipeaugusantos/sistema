unit untTBancoItauAPI;

interface

Uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples, Vcl.StdCtrls, Forms, UniClientDataSet,
  Winapi.Windows, untArqNaoGravados, untGravando,
{$ENDIF}
  Classes, SysUtils, System.StrUtils, IPPeerClient, IPPeerCommon,
  REST.Json, System.Json, untConstantes, System.Net.URLClient,
  System.Generics.Collections, DB,
  Uni, untTRestSynalistAutban,
  IdCoder, IdCoder3to4, IdCoderMIME,untTRegBol,
  DateUtils,untFuncAutban, untFuncoesBoleto,REST.Types, REST.Client,
  untTypesSistema,untCNFOCO_Class, untCNFOCO_Dao, HTTPSend, blcksock, synautil,
  ssl_openssl, untTIntegracaoPixCitel, untIIntegracaoPixCitel;

Type
  TRetornoPesquisaBancoItauAPI = class
  public
    IDBoleto,
    IDBeneficiario,
    SituacaoBoleto,
    SituacaoBoletoCodigo,
    StatusVencimento,
    NossoNumero,
    DacNossoNumero,
    ValorTitulo,
    SeuNumero,
    CodigoBarras,
    LinhaDigitavel,
    DataEntrada,
    DataEmissao,
    DataVencimento,
    DataPagamento,
    DataCredito,
    ValorPago,
    DataBaixaAlteracao,
    NomeDoArquivo,
    TxIdPix,
    EndToEndId,

    Historicos,
    MotivoCancelamento,

    ValorDesconto,
    ValorMulta,
    ValorJuros: String;

    CodigoCarteira,
    DescricaoInstrumentoCobranca: String;

    PagoPorPix: Boolean;
    RetVinculada : String;
  end;


Type
  TDadosCarteira = Record
    CarteiraBanco,
    EmpresaCarteira,
    CarteiraCompleta,
    LinkConsulta,
    LinkConsultaEspecifico,
    LinkInclusao,
    LinkConsultaPix,
    LinkBaixa,
    OcorrenciasDeEncargo,
    LinkApi,
    LinkTokenAPI,
    Convenio,
    CodCarteira,
    VariacaoCarteira,
    QtdDiasProtesto,
    QtdDiasLimitePagto,
    Observacao1,
    Observacao2,
    Observacao3,
    Observacao4,
    Observacao5,
    PercenMulta,
    OrgaoNegativador,
    QtdDiasNegativacao,
    QtdDiasCredito,
    Aceite,
    PastaItau,
    ContaCorrente,
    DAC,
    Agencia,
    ContaCaucao,
    TipoCobranca,
    CodigoMulta,

    GerarQRCodePix,
    ClientId,
    ClientSecret,
    ChavePix,
    AutoIncremChavePix,
    CertificadoCrt,
    CertificadoKey,

    UsaSacadorAvalista,
    NomeBeneficiario,
    EnderecoBeneficiario,
    ComplementoBeneficiario,
    BairroBeneficiario,
    CidadeBeneficiario,
    UFBeneficiario,
    CEPBeneficiario,
    CNPJBeneficiario,

    EnviarInstrucaoProtesto,
    EnviarInstrucaoNegativacao: String;

    ValorDiasCredito,
    ValorDiasCreditoPix: Integer;

    DiaUtil: Boolean;

    CodigoCarteriaVinculada,
    AgenciaVinculada,
    ContaCorrenteVinculada,
    DigitoContaVinculada: String;

    DadosEmpresa: TUniQuery;

    LinkFrancesa: String;
  end;

Type
  TMovimentoDescontoItau = Record
    Status,
    NossoNumero,
    SeuNumero,
    DataMovimentacao,
    DataVencimento: String;

    ValorTitulo,
    ValorLiquido,
    TarifaBoleto,
    Juros,
    IOF,
    Contratacao: Integer;
  End;

Type
  TBancoItauAPI = class(TObject)
  private
    FDadosCarteira : TDadosCarteira;

    FPercentualMulta,
    FPercentualMora: Double;
    FFaturamento: Boolean;
    FTentarNovamente: Boolean;
    FNossoNumeroCancelamento : String;
    FCancelarRegistro : Boolean;
    FDuplicataCancelamento: String;
    
    FListaRequisicaoRegistroBoleto : TList<TRequisicaoRegistroBoleto>;
    FRetornoBancoItauAPI: TRetornoBoletoItau;

    FTokenUsoAtual: String;

    FPastaAutcom: String;

    FRestSynalist: TRestSynalistAutban;

    FErroNossoNumeroDuplicado: Boolean;

    FTextoErroNossoNumeroDuplicado: String;

    FConsultaBoletosGerados: TUniClientDataset;

    FUtilizarNovaAPIConsulta: Boolean;

    function InterpretaMensagemErro(const AErro: String): Boolean;
    procedure CarregaDadosCarteira(ACarteira: String);
    procedure CarregaDadosBeneficiario;
    procedure CarregaLinksTabela;
    procedure ValidaSeTodosOsLinksEstaoMapeados;

    function PossuiTodosOsDadosParaRealizarAutorizacaoAPI: Boolean;

    function AguardarException429(var AContadorException: Integer{$IFNDEF LINUX}; var AProgresso: TfrmGravando{$ENDIF}): Boolean;

    procedure ConsultaFrancesaDia(const AIDFrancesa: String;
                                  const AData: TDateTime;
                                  const AFiltro: String;
                                  ATarifas: TDictionary<String, Integer>;
                                  ADescontos: TList<TMovimentoDescontoItau>
                                  {$IFNDEF LINUX}; var AProgresso: TfrmGravando{$ENDIF});
    function DataSemMovimentacaoFrancesa(const AResposta: String): Boolean;
    function ValorFrancesaEmCentavos(const AValor: String): Integer;
    procedure RegistraTarifaFrancesa(AItem: TJsonValue;
                                     ATarifas: TDictionary<String, Integer>);
    procedure RegistraMovimentoDesconto(AItem: TJsonValue;
                                        ADescontos: TList<TMovimentoDescontoItau>);

    //Dados Requisição
    function RetornaDadosDaRequisicao(ADadosDuplicata,
                                      ADadosCliente: TDataset;
                                      ANosNum:String): String;
    function RetornaBeneficiario: TJsonObject;
    function RetornaDadosBoleto(ADadosDuplicata,
                                ADadosCliente: TDataset;
                                ANosNum: String): TJsonObject;
    function RetornaInstrucaoCobranca: TJsonArray;
    function RetornaProtesto: TJsonObject;
    function RetornaNegativacao: TJsonObject;

    function RetornaPagador(ADadosCliente : TDataSet): TJsonObject;
    function RetornaEnderecoPagador(ADadosCliente : TDataSet): TJsonObject;
    function RetornaPessoaPagador(ADadosCliente : TDataSet): TJsonObject;
    function RetornaTipoPessoaPagador(ADadosCliente : TDataSet):TJsonObject;

    function RetornaSacadorAvalista: TJsonObject;

    function RetornaDadosBoletoIndividuais(ADadosDuplicata: TDataset;
                                           ANosNum: String): TJsonArray;

    function RetornaJurosMora(ADadosDuplicata : TDataSet): TJsonObject;
    function RetornaMulta(ADadosDuplicata : TDataSet):TJsonObject;
    function RetornaDesconto(ADescontos: TJsonArray): TJsonObject;
    function RetornaDescontos(ADadosDuplicata : TDataSet):TJsonArray;
    function RetornaObservacoes:TJsonArray;

     function RetornaChaveDuplicata(ADadosDuplicata: TDataset): String;
     function RetornaDadosQRCode: TJsonObject;

     function RetornaAcoesPermitidas: TJsonObject;

     function RetornaValorDuplicata(ADadosDuplicata: TDataSet): Double;
    //End Dados Requisição

    //API
    procedure GerarToken;

    function RetornaValorString(AValor: String; ATamanho: Integer = 0): String;

    function UtilizaDescontoDePontualidade(AValDes:Double): Boolean;

    function RetornaIDBeneficiario:String;
    function RetornaIDBeneficiarioVinculada:String;
    function PrettyJSON(jsonstring:String):String;
    procedure AguardeCincoSegundos;
    procedure AguardeDezSegundos;
    procedure AtualizaDadosExportacaoRemessa(ACadRec: TDataSet; ADadosRetorno: TRetornoBoletoItau);
    function NossoNumeroDuplicado(AErro: String;
                                  AStatus: Integer):Boolean;
    function RetornaValorJson(AObjeto: TJsonObject;ANomeCampo: String): String;
    function RetornaValorJsonValue(AObjeto: TJsonValue; ANomeCampo: String): String;

    function RetornaTextoErro(ACodigoRetorno,
                              ADadosRetorno: String): String;
    procedure CriarComponenteRequisicao;

    function AtualizaStatusRetornoErro(AStatusAtual: Integer;
                                       AErro: String): Integer;

    function DadosDoBoletoPertencemADuplicata(ARetornoPost: String;
                                              ADadosDuplicata,
                                              ADadosCliente: TDataset): Boolean;

    //Consulta
    function RetonaDuplicatasBoletoGerado(ACarteira: String;
                                          ADataInicial,
                                          ADataFinal: TDateTime): TUniClientDataSet;
    function RetornaDadosPesquisaBoleto(ADadosRetorno: String): TRetornoPesquisaBancoItauAPI;

    procedure ConsultaDadosPixBoleto(var ADadosBoletoRetorno: TRetornoPesquisaBancoItauAPI;
                                         ATxIdBoleto: String = '');

    procedure CorrigeDatas(var AValorDuplicata: String);

    function DeveAdicionarDuplicataEmAberto(ADataPagamento,
                                            ADataEmissao: String;
                                            ADataInicial,
                                            ADataFinal: TDateTime): Boolean;

    function RetornaDataParaCredito(ADataPagamento: String;
                                    APagoPorPix: Boolean): String;

    function ConsultaBoletoContaVinculada(ADataset: TDataset;
                                          ARetornoAnterior: TRetornoPesquisaBancoItauAPI;
                                          var ACodigoRetorno: Integer;
                                          var AContadorErro409: Integer
                                          {$IFNDEF LINUX}; var AProgresso: TfrmGravando{$ENDIF}): TRetornoPesquisaBancoItauAPI;

    function BoletoTransferidoParaContaVinculada(LDadosRetorno: TRetornoPesquisaBancoItauAPI): Boolean;

    { nova forma de pesquisa }
    function RetornaDadosPesquisaBoletoPeriodo(ADadosRetorno: String): TRetornoPesquisaBancoItauAPI;

    function ConsultaBoletosPorNossoNumeroLista(AListaBoletos: TList<TRetornoPesquisaBancoItauAPI>;
                                                AContaCorrente: String
                                                {$IFNDEF LINUX}; var AProgresso: TfrmGravando{$ENDIF}): TList<TRetornoPesquisaBancoItauAPI>;

    function ConsultaBoletosEmAbertoPorPeriodo(ADataInicial,
                                               ADataFinal: TDateTime;
                                               AListaImportada: TList<TRetornoPesquisaBancoItauAPI>;
                                               AContaCorrente: String
                                               {$IFNDEF LINUX}; var AProgresso: TfrmGravando{$ENDIF}): TList<TRetornoPesquisaBancoItauAPI>;

    function ConsultaBoletosLiquidadosPorPeriodo(ADataInicial,
                                                 ADataFinal: TDateTime;
                                                 AListaImportada: TList<TRetornoPesquisaBancoItauAPI>;
                                                 AContaCorrente: String
                                                 {$IFNDEF LINUX}; var AProgresso: TfrmGravando{$ENDIF}): TList<TRetornoPesquisaBancoItauAPI>;

    function ConsultaBoletosCanceladosPorPeriodo(ADataInicial,
                                                 ADataFinal: TDateTime;
                                                 AListaImportada: TList<TRetornoPesquisaBancoItauAPI>;
                                                 AContaCorrente: String
                                                 {$IFNDEF LINUX}; var AProgresso: TfrmGravando{$ENDIF}): TList<TRetornoPesquisaBancoItauAPI>;

    function ConsultaBoletosCanceladosPorLiquidacao(ADataInicial,
                                                    ADataFinal: TDateTime;
                                                    AListaImportada: TList<TRetornoPesquisaBancoItauAPI>;
                                                    AContaCorrente: String
                                                    {$IFNDEF LINUX}; var AProgresso: TfrmGravando{$ENDIF}): TList<TRetornoPesquisaBancoItauAPI>;
    //end consulta

    //Alteração
    procedure BaixaBoletoRegistrado(ADataSet: TDataSet);

    function RetornaIdBoletoNossoNumero(ANossoNumero: String): String;
    function DeveLimparOsDadosDoBoletoCancelamento(AStatus: Integer;
                                                   ARetorno,
                                                   ATxIdBoleto: String): Boolean;
    procedure ExibeFormMensagemErro(AMensagem: String);

    function BoletoTransferidoParaContaVinculadaEPagoPorPix(ADadosBoleto: TRetornoPesquisaBancoItauAPI): Boolean;

    function BoletoTransferidoParaContaVinculadaNovaAPI(ANossoNumeroSemDigito: String;
                                                        AEhContaVinculada: Boolean;
                                                        ADadosRetorno: TRetornoPesquisaBancoItauAPI): Boolean;
    //end alteração
  public
    constructor Create(ACarteira: String);
    Destructor Destroy; Override;

    function CadastrarNovoBoleto(ADadosDuplicata, ADadosCliente: TDataSet; Var ANosNum: String): TRetornoBoletoItau;
    procedure ReimpressaoDeBoleto(AAutoIncrem: String);

    function ConsultaBoletosPorPeriodo(ADataInicial,
                                       ADataFinal: TDateTime
                                       {$IFNDEF LINUX}; var AProgresso: TfrmGravando{$ENDIF}): TList<TRetornoPesquisaBancoItauAPI>;

    function NovaConsultaBoletos(ADataInicial,
                                 ADataFinal: TDateTime
                                 {$IFNDEF LINUX}; var AProgresso: TfrmGravando{$ENDIF}): TList<TRetornoPesquisaBancoItauAPI>;

    procedure CancelarBoletos(ADataSet:TDataSet);
    procedure GravarDadosRequisicaoRegistroBoleto;

    function VerificaSeADuplicataExisteCadrec(ABoleto: TRetornoPesquisaBancoItauAPI; out ADuplicata: TDuplicataCtr): Boolean;

    function ConsultaMovimentacoesFrancesa(const ADataInicial,
                                                 ADataFinal: TDateTime;
                                           ATarifas: TDictionary<String, Integer>;
                                           ADescontos: TList<TMovimentoDescontoItau>;
                                           out AErro: String
                                           {$IFNDEF LINUX}; var AProgresso: TfrmGravando{$ENDIF}): Boolean;
    function RetornaTarifaFrancesa(ATarifas: TDictionary<String, Integer>;
                                   ABoleto: TRetornoPesquisaBancoItauAPI): String;
    function RetornaMovimentoDesconto(ADescontos: TList<TMovimentoDescontoItau>;
                                      const ANossoNumero,
                                            AStatus: String;
                                      out AMovimento: TMovimentoDescontoItau): Boolean;

    procedure ValidarDadosAutorizacao;

    property PercentualMulta  : Double    Read FPercentualMulta  Write FPercentualMulta;
    property PercentualMora   : Double    Read FPercentualMora   Write FPercentualMora;
    property Faturamento      : Boolean   Read FFaturamento      Write FFaturamento;
    property TentarNovamente  : Boolean   Read FTentarNovamente  Write FTentarNovamente;
    property CancelarRegistro : Boolean   Read FCancelarRegistro Write FCancelarRegistro;

    property ConsultaBoletosGerados: TUniClientDataset Read FConsultaBoletosGerados Write FConsultaBoletosGerados;

    property ErroNossoNumeroDuplicado: Boolean Read FErroNossoNumeroDuplicado;
    property TextoErroNossoNumeroDuplicado: String Read FTextoErroNossoNumeroDuplicado;

    property NossoNumeroCancelamento  : String    Read FNossoNumeroCancelamento Write FNossoNumeroCancelamento;
    property DuplicataCancelamento    : String    Read FDuplicataCancelamento   Write FDuplicataCancelamento;

    property RetornoBancoItauAPI  : TRetornoBoletoItau Read  FRetornoBancoItauAPI  Write FRetornoBancoItauAPI;
  End;

implementation
Uses untTFuncoesAuxiliaresPix, untLogCtr, untFuncoesGenerica;
{ TBancoItauAPI }

function TBancoItauAPI.AguardarException429(var AContadorException: Integer{$IFNDEF LINUX}; var AProgresso: TfrmGravando{$ENDIF}): Boolean;
  Var
    LCaptionTela: String;
begin
  If AContadorException > 60 Then
    Exit(False);

  Inc(AContadorException);

 {$IFDEF LINUX}
  pMensagemOk('Erro de limitação na API do Banco Itaú. Nova tentativa em 75 segundos.');
  Aguarde(75000);
 {$ELSE}
  LCaptionTela := AProgresso.lblGravando.Caption;
  If untFuncoesSimples.fModoDeDesenvolvimento Then
    AProgresso.lblGravando.Caption := 'Erro de limitação na API do Banco Itaú. Nova tentativa em 2,5 segundos.';
  Aguarde(2500);
  AProgresso.lblGravando.Caption := LCaptionTela;
  Application.ProcessMessages;
 {$ENDIF}

  Result := True;
end;

procedure TBancoItauAPI.AguardeCincoSegundos;
begin
  Aguarde(5000);
end;

procedure TBancoItauAPI.AguardeDezSegundos;
begin
  Aguarde(10000);
end;

procedure TBancoItauAPI.AtualizaDadosExportacaoRemessa(ACadRec: TDataSet;
  ADadosRetorno: TRetornoBoletoItau);
  Var
    LCadRec: TUniQuery;

    LSql: String;
begin
  Try
    LCadRec := fCriaQuery(Nil);

    LSql := LSql + 'UPDATE    ';
    LSql := LSql + '  CADREC  ';
    LSql := LSql + 'SET ';
    LSql := LSql + '  CTR_BCOENV = :CODBCO, ';
    LSql := LSql + '  CTR_DTAENV = ' + fCurrentDate + ', ';
    LSql := LSql + '  CTR_TX_BOL = :TX_BOL, ';
    LSql := LSql + '  CTR_QRCODE = :QRCODE, ';
    LSql := LSql + '  CTR_PIXLOC = :PIXLOC, ';
    LSql := LSql + '  CTR_ID_BOL = :ID_BOL, ';
    LSql := LSql + '  CTR_LNKCIT = :LNKCIT ';
    LSql := LSql + 'WHERE ';
    LSql := LSql + '  AUTOINCREM = :AUTINC ';

    Try
      LCadRec.Close;
      LCadRec.Sql.Clear;
      LCadRec.Sql.Add(LSql);
      LCadRec.ParamByName('CODBCO').AsString := '341';

      If Not ADadosRetorno.QrCodeTxId.IsEmpty Then
      Begin
        LCadRec.ParamByName('TX_BOL').AsString := ADadosRetorno.QrCodeTxId;
        LCadRec.ParamByName('QRCODE').AsString := ADadosRetorno.QrCodeEmv;
        LCadRec.ParamByName('PIXLOC').AsString := ADadosRetorno.QrCodeUrl;
        LCadRec.ParamByName('LNKCIT').AsString := ADadosRetorno.QrCodeLinkCitel;
      End;

      LCadRec.ParamByName('ID_BOL').AsString := ADadosRetorno.idIndividualBoleto;

      LCadRec.ParamByName('AUTINC').AsString := ACadRec.FieldByName('AUTOINCREM').AsString;
      LCadRec.ExecSQL;
    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  Finally
    FreeAndNil(LCadRec);
  End;
end;


function TBancoItauAPI.AtualizaStatusRetornoErro(AStatusAtual: Integer;
  AErro: String): Integer;
  Var
    LJSonObject: TJsonObject;
begin
  Result := AStatusAtual;

  Try
    LJSonObject := TJSONObject.ParseJSONValue(AErro) As TJsonObject;

    If LJSonObject <> Nil Then
    Begin
      If RetornaValorJson(LJSonObject, 'codigo') <> EmptyStr Then
        Result := StrToInt(RetornaValorJson(LJSonObject, 'codigo'));
    End;
  Finally
    If Assigned(LJsonObject) Then
      FreeAndNil(LJsonObject);
  End;
end;

procedure TBancoItauAPI.BaixaBoletoRegistrado(ADataSet: TDataSet);
  Var
    LRetorno,
    LDadosRequisicao: String;

    LRequisicaoAlteraBoleto: TRequisicaoRegistroBoleto;

    LStatus: Integer;

    LParametros: TStringList;

    blMensJaTratada : boolean;
begin
  Self.FTentarNovamente := True;
  LRequisicaoAlteraBoleto := TRequisicaoRegistroBoleto.Create;

  blMensJaTratada := False;

  LRequisicaoAlteraBoleto.LCartei :=  FDadosCarteira.CarteiraCompleta;
  LRequisicaoAlteraBoleto.LCodBco := '341';
  LRequisicaoAlteraBoleto.FDescricao := 'CANCELAMENTO';
  LRequisicaoAlteraBoleto.LLocImp := 'ATB';

  LDadosRequisicao := '{}';
  LRequisicaoAlteraBoleto.FRequisicao := LDadosRequisicao;
  LRequisicaoAlteraBoleto.LDuplic := ADataSet.FieldByName('AUTOINCREM').AsString;
  LRequisicaoAlteraBoleto.LLnkApi := FDadosCarteira.LinkBaixa.Replace('[ID_BOLETO]', RetornaIdBoletoNossoNumero(ADataSet.FieldByName('CTR_NOSNUM').AsString));

  LParametros := TStringList.Create;

  Try
    Try
      GerarToken;

      LParametros.Add('Authorization: ' + FTokenUsoAtual);
      LParametros.Add('x-itau-apikey: ' + FDadosCarteira.ClientId);
      LParametros.Add('x-itau-correlationID: 1');
      LParametros.Add('x-itau-flowID: 2');

      FRestSynalist.StatusSemRaise := [422, 204];

      LStatus := FRestSynalist.ExecuteRestSynalist('PATCH',
                                                   LRequisicaoAlteraBoleto.LLnkApi,
                                                   LParametros,
                                                   LRetorno,
                                                   LDadosRequisicao);

      If Not MatchStr(LStatus.ToString, ['204', '201', '422']) Then
        Raise Exception.Create(LRetorno);

      Self.FTentarNovamente := False;

      LRequisicaoAlteraBoleto.LJsoRec := LRetorno;

      If DeveLimparOsDadosDoBoletoCancelamento(LStatus, LRetorno, ADataSet.FieldByName('CTR_TX_BOL').AsString) Then
      Begin
        fStartTransaction;
        LimpaDadosBoleto(ADataSet.FieldByName('AUTOINCREM').AsString);

        untLogCtr.GravaLogCtr(ADataSet.FieldByName('AUTOINCREM').AsString,
                              'CANCELAMENTO DE BOLETO - BANCO ITAÚ [ONLINE]',
                              'TBancoItauAPI');
        fCommit;


        If Not fEmptyStr(ADataSet.FieldByName('CTR_LNKCIT').AsString) Then
          TFuncoesPixBoleto.RemoverLinkCitelPixBoleto(fRetCGCEmpresa(ADataSet.FieldByName('CTR_CODEMP').AsString),
                                                      ADataSet.FieldByName('CTR_CODEMP').AsString,
                                                      ADataSet.FieldByName('CTR_TX_BOL').AsString,
                                                      FDadosCarteira.AutoIncremChavePix,
                                                      True);
      End
      Else
      Begin
        blMensJaTratada := True;
        Raise Exception.Create(RetornaTextoErro(LStatus.ToString, LRetorno));
      End
    Except
      On E: Exception Do
      Begin
        LRequisicaoAlteraBoleto.LExcept := E.Message;
       {$IFDEF LINUX}
        AguardeCincoSegundos;
       {$ELSE}
        TfrmGravando.fExecutarModalA(AguardeCincoSegundos,'Falha na comunicação, Nova tentativa em 5 segundos.', '');
       {$ENDIF}

        If blMensJaTratada Then
           Raise Exception.Create(E.Message)
        Else
           Raise Exception.Create(RetornaTextoErro('', E.Message));
      End;
    End;
  Finally
    FreeAndNil(LParametros);

    FListaRequisicaoRegistroBoleto.Add(LRequisicaoAlteraBoleto);

    FRestSynalist.StatusSemRaise := [];
  End;
end;

function TBancoItauAPI.BoletoTransferidoParaContaVinculadaEPagoPorPix(
  ADadosBoleto: TRetornoPesquisaBancoItauAPI): Boolean;
begin
  Result := False;

  If Not FUtilizarNovaAPIConsulta Then
    Exit;

  If ADadosBoleto.RetVinculada <> 'S' Then
    Exit;

  If Not ADadosBoleto.PagoPorPix Then
    Exit;

  If fEmptyStr(ADadosBoleto.IDBoleto) Then
    Exit;

  Result := True;
end;

function TBancoItauAPI.BoletoTransferidoParaContaVinculadaNovaAPI(
  ANossoNumeroSemDigito: String;
  AEhContaVinculada: Boolean;
  ADadosRetorno: TRetornoPesquisaBancoItauAPI): Boolean;
begin
  Result := False;

  If Not FUtilizarNovaAPIConsulta Then
    Exit;

  If Not AEhContaVinculada Then
    Exit;

  If fEmptyStr(ANossoNumeroSemDigito) Then
    Exit;

  If Not ADadosRetorno.Historicos.Contains('BOLETO TRANSFERIDO ENTRE CONTAS') Then
    Exit;

  Result := True;
end;

function TBancoItauAPI.BoletoTransferidoParaContaVinculada(
  LDadosRetorno: TRetornoPesquisaBancoItauAPI): Boolean;
  Var
    LJsonArray: TJsonArray;

    LJsonValue: TJsonValue;
begin
  Result := False;

  If Concat(LDadosRetorno.DataEmissao, LDadosRetorno.NossoNumero).IsEmpty Then
    Exit(True);

  If LDadosRetorno.SituacaoBoleto.Equals('Baixada') Then
  Begin
    If LDadosRetorno.Historicos.IsEmpty Then
      Exit;

    LJsonArray := TJsonObject.ParseJSONValue(LDadosRetorno.Historicos) As TJsonArray;

    For LJsonValue In LJsonArray Do
    Begin
      If RetornaValorJsonValue(LJsonValue, 'operacao').Equals('ALTERACAO AGENCIA/CONTA') Then
        Exit(True);
    End;
  End;
end;

function TBancoItauAPI.CadastrarNovoBoleto(ADadosDuplicata,ADadosCliente: TDataSet; Var ANosNum: String): TRetornoBoletoItau;
  Var
    LRetornoPost,
    LDadosRequisicao: String;

    LJsonRetorno,
    LJsonDadosBoleto: TJSONObject;

    LJsonObjectGroup: TJsonArray;

    LJsonValue: TJsonValue;

    LRequisicaoRegistroBoleto : TRequisicaoRegistroBoleto;

    LStatus : Integer;

    LParametros: TStringList;
begin
  Self.FTentarNovamente := True;
  Result := TRetornoBoletoItau.Create;
  LRequisicaoRegistroBoleto := TRequisicaoRegistroBoleto.Create;

  LRequisicaoRegistroBoleto.LCartei :=  FDadosCarteira.CarteiraBanco + '-' +  FDadosCarteira.EmpresaCarteira;
  LRequisicaoRegistroBoleto.LCodBco := '341';
  LRequisicaoRegistroBoleto.LLocImp := IIF(Self.FFaturamento,'FAT','CTR');

  LDadosRequisicao := RetornaDadosDaRequisicao(ADadosDuplicata, ADadosCliente, ANosNum);
  LRequisicaoRegistroBoleto.LJsoEnv := LDadosRequisicao;
  LRequisicaoRegistroBoleto.LDuplic := ADadosDuplicata.FieldByName('AUTOINCREM').AsString;
  LRequisicaoRegistroBoleto.LLnkApi := FDadosCarteira.LinkInclusao;
  LRequisicaoRegistroBoleto.FDescricao := 'REGISTRO';

  LRequisicaoRegistroBoleto.FRequisicao := LDadosRequisicao;

  LParametros := TStringList.Create;

  FErroNossoNumeroDuplicado := False;
  FTextoErroNossoNumeroDuplicado := EmptyStr;

  Try
    Try
      GerarToken;

      LParametros.Add('Authorization: ' + FTokenUsoAtual);
      LParametros.Add(IIF(FDadosCarteira.GerarQRCodePix.Equals('S'),
                          'x-itau-correlationID: ',
                          'x-itau-apikey: ') + FDadosCarteira.ClientId);

      LStatus := FRestSynalist.ExecuteRestSynalist('POST',
                                                   FDadosCarteira.LinkInclusao,
                                                   LParametros,
                                                   LRetornoPost,
                                                   LDadosRequisicao);

      If Not MatchStr(LStatus.ToString, ['200', '201']) Then
        Raise Exception.Create(LRetornoPost);

      If Not DadosDoBoletoPertencemADuplicata(LRetornoPost, ADadosDuplicata, ADadosCliente) Then
      Begin
        LStatus := 255;

        Raise Exception.Create('A API do Banco Itaú retornou dados incorretos do boleto.' + #13 +
                               'Refaça a impressão do boleto.');
      End;

      Self.FTentarNovamente := False;

      LRequisicaoRegistroBoleto.LJsoRec := LRetornoPost;

      LJsonRetorno := TJSONObject.ParseJSONValue(LRetornoPost) as TJSONObject;
      LJsonRetorno := TJSONObject.ParseJSONValue(LJsonRetorno.GetValue('data').ToString) as TJSONObject;

      LJsonDadosBoleto := TJSONObject.ParseJSONValue(LJsonRetorno.GetValue('dado_boleto').ToString) as TJSONObject;

      LJsonObjectGroup := LJsonDadosBoleto.GetValue('dados_individuais_boleto') as TJsonArray;

      For LJsonValue In LJsonObjectGroup Do
      Begin
        Result.nossoNumero    := LJsonValue.GetValue<String>('numero_nosso_numero');
        ANosNum               := Result.nossoNumero;
        If (LJsonValue As TJsonObject).GetValue('dac_titulo') <> Nil Then
          Result.nossoNumero    := Result.nossoNumero + LJsonValue.GetValue<String>('dac_titulo');
        Result.linhaDigitavel := LJsonValue.GetValue<String>('numero_linha_digitavel');
        Result.codigoDeBarras := LJsonValue.GetValue<String>('codigo_barras');

        If (LJsonValue As TJsonObject).GetValue('id_boleto_individual') <> Nil Then
          Result.idIndividualBoleto := LJsonValue.GetValue<String>('id_boleto_individual');
      End;

      If LJsonRetorno.GetValue('dados_qrcode') <> Nil Then
      Begin
        LJsonRetorno := TJSONObject.ParseJSONValue(LJsonRetorno.GetValue('dados_qrcode').ToString) as TJSONObject;

        Result.QrCodeTxId := RetornaValorJson(LJsonRetorno,'txid');
        Result.QrCodeUrl := RetornaValorJson(LJsonRetorno,'location');
        Result.QrCodeEmv := RetornaValorJson(LJsonRetorno,'emv');

        Result.QrCodeLinkCitel := TFuncoesPixBoleto.IncluirLinkCitelPixBoleto('341',
                                                                              Result.QrCodeTxId,
                                                                              Result.QrCodeEmv,
                                                                              FormatFloat(',0.00', RetornaValorDuplicata(ADadosDuplicata)),
                                                                              FDadosCarteira.AutoIncremChavePix,
                                                                              IncDay(ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime,
                                                                                     StrToIntDef(FDadosCarteira.QtdDiasLimitePagto, 0)) + StrToTime('23:59:59'));
      End;

      AtualizaDadosExportacaoRemessa(ADadosDuplicata,
                                     Result);
    Except

      On E: Exception Do
      Begin
        LRequisicaoRegistroBoleto.LExcept := E.Message;

        LStatus := AtualizaStatusRetornoErro(LStatus,
                                             E.Message);

        If NossoNumeroDuplicado(E.Message, LStatus) Then
        Begin
          FErroNossoNumeroDuplicado := True;
          ANosNum := fStrZero((StrToInt64(ANosNum) + 1).ToString, 8);

          FTextoErroNossoNumeroDuplicado := RetornaTextoErro(LStatus.ToString, E.Message);
          Exit;
        End;

        If Not MatchStr(LStatus.ToString, ['400', '422', '202']) Then
        Begin
         {$IFDEF LINUX}
          AguardeCincoSegundos;
         {$ELSE}
          TfrmGravando.fExecutarModalA(AguardeCincoSegundos,'Falha na comunicação, Nova tentativa em 5 segundos.', '');
         {$ENDIF}
        End;

        If MatchStr(LStatus.ToString, ['202']) Then
        Begin
         {$IFDEF LINUX}
          AguardeDezSegundos;
         {$ELSE}
          TfrmGravando.fExecutarModalA(AguardeDezSegundos,'Atraso na API do Banco Itaú... Nova tentativa em 10 segundos.', '');
         {$ENDIF}
        End;

        Raise Exception.Create(RetornaTextoErro(LStatus.ToString, E.Message));
      End;
    End;
  Finally
    FListaRequisicaoRegistroBoleto.Add(LRequisicaoRegistroBoleto);
  End;
end;

procedure TBancoItauAPI.CancelarBoletos(ADataSet: TDataSet);
  Var
    LDocumentosRestantes: String;

    LErroAPI: Boolean;

    LContadorTentativas: Integer;
begin
  Try
    LContadorTentativas := 1;
    LErroAPI := False;
    ADataSet.First;

   {$IFNDEF LINUX}
    frmGravandoGenericProcedure.pgbStatus.Visible := True;
    frmGravandoGenericProcedure.pgbStatus.Position := 0;
    frmGravandoGenericProcedure.pgbStatus.Properties.Max := ADataSet.RecordCount;
   {$ENDIF}

    While (LContadorTentativas <= 2) Do
    Begin
      Try

        While Not ADataSet.Eof Do
        Begin
          BaixaBoletoRegistrado(ADataSet);

          ADataSet.Next;

         {$IFNDEF LINUX}
          pStep(frmGravandoGenericProcedure.pgbStatus);
         {$ENDIF}
          LContadorTentativas := 0;
        End;

        LErroAPI := False;

      Except
        On E:Exception Do
        begin
          LErroAPI := True;

          If InterpretaMensagemErro(E.Message) Then
            Exit;

          If (LContadorTentativas >= 2) Then
          Begin
            LDocumentosRestantes := '';

            While Not ADataSet.Eof Do
            Begin
              LDocumentosRestantes := LDocumentosRestantes + ADataSet.FieldByName('CTR_NUMDUP').AsString +
                                                             ADataSet.FieldByName('CTR_ESPDOC').AsString + '-' +
                                                             ADataSet.FieldByName('CTR_CODEMP').AsString + ', ';
              ADataSet.Next;
            End;

            LDocumentosRestantes := LeftStr(LDocumentosRestantes, LDocumentosRestantes.Length - 2);

            ExibeFormMensagemErro('Ocorreram erros ao cancelar o(s) boleto(s) no Banco Itaú [Online].' + #13#10 + E.Message + #13#10 +
                                  'Documento(s) ficaram sem cancelar o boleto: ' + LDocumentosRestantes);

          End;

          Inc(LContadorTentativas);
        End;
      End;


      If Not LErroAPI Then
      Begin
        pMensagemOk('Cancelamento realizado com sucesso!');
        Break;
      End;
    End;

   {$IFNDEF LINUX}
    frmGravandoGenericProcedure.pgbStatus.Visible := False;
   {$ENDIF}
  Finally
    GravarDadosRequisicaoRegistroBoleto;
  End
end;

procedure TBancoItauAPI.CarregaDadosBeneficiario;
  Var
    LSql:String;
begin
  FDadosCarteira.DadosEmpresa  := fCriaQuery(Nil);

  LSql := '';
  LSql := LSql + 'SELECT ';
  LSql := LSql + '  EMP_CODEMP, ';
  LSql := LSql + '  EMP_C_G_C_, ';
  LSql := LSql + '  EMP_ENDCMP, ';
  LSql := LSql + '  EMP_NOMEMP, ';
  LSql := LSql + '  EMP_ENDERE, ';
  LSql := LSql + '  EMP_ENDNUM, ';
  LSql := LSql + '  CID_NOMCID, ';
  LSql := LSql + '  EMP_BAIRRO, ';
  LSql := LSql + '  EMP_C_E_P_, ';
  LSql := LSql + '  CID_ESTADO  ';
  LSql := LSql + 'FROM ';
  LSql := LSql + '  CADEMP ';
  LSql := LSql + '  JOIN CADCID ON CID_CODCID = EMP_CODCID ';
  LSql := LSql + 'WHERE ';
  LSql := LSql + '  EMP_CODEMP = :CODEMP ';

  Try
    FDadosCarteira.DadosEmpresa.Close;
    FDadosCarteira.DadosEmpresa.SQL.Clear;
    FDadosCarteira.DadosEmpresa.SQL.Add(LSql);
    FDadosCarteira.DadosEmpresa.ParamByName('CODEMP').AsString := VS_strCodEmp;
    FDadosCarteira.DadosEmpresa.Open;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;

end;

procedure TBancoItauAPI.CarregaDadosCarteira(ACarteira: String);
  Var
    LDadosPix: TUniQuery;
begin
  FDadosCarteira.CarteiraBanco := LeftStr(ACarteira,14);
  FDadosCarteira.EmpresaCarteira := RightStr(ACarteira, 3);
  FDadosCarteira.CarteiraCompleta :=ACarteira;

  FDadosCarteira.Agencia             := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'CODAGEN', '',FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.ContaCorrente       := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'NUMCTAC', '',FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.DAC                 := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'DIGCTAC', '',FDadosCarteira.EmpresaCarteira);

  FDadosCarteira.Aceite              := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'PROACEI'      ,'', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.Convenio            := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'CODCONV'      ,'', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.CodCarteira         := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'NUMCART'      ,'', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.VariacaoCarteira    := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'VARCART'      ,'', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.QtdDiasProtesto     := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'DIAPROT'      ,'0', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.QtdDiasLimitePagto  := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'DIALIMI'      ,'0', FDadosCarteira.EmpresaCarteira);

  FDadosCarteira.Observacao1         := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'OBSERV1'      ,'', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.Observacao2         := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'OBSERV2'      ,'', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.Observacao3         := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'OBSERV3'      ,'', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.Observacao4         := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'OBSERV4'      ,'', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.Observacao5         := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'OBSERV5'      ,'', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.PercenMulta         := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'PERMUFT'      ,'', FDadosCarteira.EmpresaCarteira);

  FDadosCarteira.CodigoMulta         := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'CODIGOMULTA'   ,'', FDadosCarteira.EmpresaCarteira);

  FDadosCarteira.QtdDiasNegativacao  := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'DIANEGA'      ,'0', FDadosCarteira.EmpresaCarteira);

  FDadosCarteira.QtdDiasCredito := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'DIACRED', '0', FDadosCarteira.EmpresaCarteira);

  If Not TryStrToInt(FDadosCarteira.QtdDiasCredito, FDadosCarteira.ValorDiasCredito) Then
    FDadosCarteira.ValorDiasCredito := 0;

  FDadosCarteira.ValorDiasCreditoPix := FDadosCarteira.ValorDiasCredito;
  If Not fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'DIACRED', 'N', FDadosCarteira.EmpresaCarteira).Equals('S') Then
    FDadosCarteira.ValorDiasCreditoPix := 0;

  CarregaDadosBeneficiario;

  FDadosCarteira.EnviarInstrucaoProtesto := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'ENVPROTE','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.EnviarInstrucaoNegativacao := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'ENVNEGAT','', FDadosCarteira.EmpresaCarteira);

  FDadosCarteira.AutoIncremChavePix := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'CHAPIX','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.GerarQRCodePix := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'GERAPIX','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.CertificadoCrt := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'AUTHCRT','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.CertificadoKey := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'AUTHKEY','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.ClientId := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'CLIENT_ID','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.ClientSecret := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'CLIENT_SECRET','', FDadosCarteira.EmpresaCarteira);

  FDadosCarteira.CodigoCarteriaVinculada := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'NUMCARTVINC','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.AgenciaVinculada := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'CODAGENVINC', '',FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.ContaCorrenteVinculada := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'NUMCTACVINC', '',FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.DigitoContaVinculada := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'DIGCTACVINC', '',FDadosCarteira.EmpresaCarteira);

  If FDadosCarteira.GerarQRCodePix.Equals('S') Then
  Begin
    Try
      LDadosPix := fCriarQuery('SELECT P.PIX_CHAVE_, C.CCA_CLI_ID, C.CCA_CLISEC, ' +
                               '       C.CCA_ARQCRT, C.CCA_ARQKEY ' +
                               'FROM CCAPIX P ' +
                               'JOIN CADCCA C ON C.AUTOINCREM=P.PIX_SEQCCA ' +
                               'WHERE P.AUTOINCREM="' + FDadosCarteira.AutoIncremChavePix + '"');
      LDadosPix.Open;

      FDadosCarteira.ChavePix := LDadosPix.FieldByName('PIX_CHAVE_').AsString;
      FDadosCarteira.ClientId := LDadosPix.FieldByName('CCA_CLI_ID').AsString;
      FDadosCarteira.ClientSecret := LDadosPix.FieldByName('CCA_CLISEC').AsString;
      FDadosCarteira.CertificadoCrt := LDadosPix.FieldByName('CCA_ARQCRT').AsString;
      FDadosCarteira.CertificadoKey := LDadosPix.FieldByName('CCA_ARQKEY').AsString;
    Finally
      FreeAndNil(LDadosPix);
    End;
  End;

  FDadosCarteira.DiaUtil := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'TIPDIA'      ,'', FDadosCarteira.EmpresaCarteira) = '1';

  FDadosCarteira.UsaSacadorAvalista := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'SACAVAL'      ,'', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.NomeBeneficiario := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'NOMEBEN'      ,'', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.EnderecoBeneficiario := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'ENDEBEN'      ,'', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.BairroBeneficiario := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'BAIRBEN'      ,'', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.CidadeBeneficiario := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'CIDABEN'      ,'', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.UFBeneficiario := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'ESTABEN'      ,'', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.CEPBeneficiario := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'CEP_BEN'      ,'', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.CNPJBeneficiario := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'CNPJBEN'      ,'', FDadosCarteira.EmpresaCarteira);

  FRestSynalist.CarregaCertificados(FDadosCarteira.CarteiraCompleta,
                                    EmptyStr,
                                    FDadosCarteira.CertificadoCrt,
                                    FDadosCarteira.CertificadoKey,
                                    EmptyStr);
end;

procedure TBancoItauAPI.CarregaLinksTabela;
  Var
    LConsulta: TUniQuery;
begin
  //A PEDIDO DO RONALDO, SERÃO CARREGADOS OS LINKS APENAS PELA TABELA
  If Not fTabelaExiste('LNKBCO') Then
    Raise ExceptionAutcom.Create('Tabela dos links de boletos não existe. Entre em contato com a Citel.');

  Try
    LConsulta := fCriaQuery;
    LConsulta.SQL.Text := 'SELECT * ' +
                          'FROM LNKBCO ' +
                          'WHERE LNK_CODBCO="341" ' +
                          '  AND LNK_ROTINA="BOLETO" ' +
                          '  AND LNK_TIPAMB="P" ' +
                          '  AND TRIM(COALESCE(LNK_URLLNK, "")) <> ""';

    LConsulta.Open;

    If LConsulta.IsEmpty Then
      Raise ExceptionAutcom.Create('Links de boletos do banco Itaú não mapeados. Entre em contato com a Citel.');

    If LConsulta.Locate('LNK_CHAVE_', 'TOKEN_BOLETO_PROD', []) Then
      FDadosCarteira.LinkTokenAPI := LConsulta.FieldByName('LNK_URLLNK').AsString;

    If FDadosCarteira.GerarQRCodePix.Equals('N') Then
    Begin
      If LConsulta.Locate('LNK_CHAVE_', 'CRIAR_BOLETO_PROD', []) Then
        FDadosCarteira.LinkInclusao := LConsulta.FieldByName('LNK_URLLNK').AsString;
    End
    Else
    Begin
      If LConsulta.Locate('LNK_CHAVE_', 'CRIAR_BOLECODE_PROD', []) Then
        FDadosCarteira.LinkInclusao := LConsulta.FieldByName('LNK_URLLNK').AsString;
    End;

    If LConsulta.Locate('LNK_CHAVE_', 'CONSULTAR_TXIDBOL_PROD', []) Then
      FDadosCarteira.LinkConsultaPix := LConsulta.FieldByName('LNK_URLLNK').AsString;

    If LConsulta.Locate('LNK_CHAVE_', 'CONSULTAR_BOLETO_NN_PROD', []) Then
      FDadosCarteira.LinkConsultaEspecifico := LConsulta.FieldByName('LNK_URLLNK').AsString;

    If LConsulta.Locate('LNK_CHAVE_', 'CONSULTAR_LISTA_BOLETO_PROD', []) Then
      FDadosCarteira.LinkConsulta := LConsulta.FieldByName('LNK_URLLNK').AsString;

    If LConsulta.Locate('LNK_CHAVE_', 'BAIXAR_BOLETO_PROD', []) Then
      FDadosCarteira.LinkBaixa := LConsulta.FieldByName('LNK_URLLNK').AsString;

    If LConsulta.Locate('LNK_CHAVE_', 'CONSULTAR_FRANCESA_PROD', []) Then
      FDadosCarteira.LinkFrancesa := LConsulta.FieldByName('LNK_URLLNK').AsString;

    ValidaSeTodosOsLinksEstaoMapeados;
  Finally
    If Assigned(LConsulta) Then
    Begin
      LConsulta.Close;
      FreeAndNil(LConsulta);
    End;
  End;
end;

function TBancoItauAPI.ConsultaBoletoContaVinculada(ADataset: TDataset;
                                          ARetornoAnterior: TRetornoPesquisaBancoItauAPI;
                                          var ACodigoRetorno: Integer;
                                          var AContadorErro409: Integer
                                          {$IFNDEF LINUX}; var AProgresso: TfrmGravando{$ENDIF}): TRetornoPesquisaBancoItauAPI;
  Var
    LLinkConsulta,
    LResposta,
    LBeneficiario,
    LCaptionTela: String;

    LRealizarConsulta: Boolean;

    LParametros: TStringList;
begin
  Result := ARetornoAnterior;

  If FDadosCarteira.AgenciaVinculada.IsEmpty Then
    Exit;

  LParametros := TStringList.Create;

  Try
    LBeneficiario := fStrZero(FDadosCarteira.AgenciaVinculada, 4) +
                     fStrZero(FDadosCarteira.ContaCorrenteVinculada +
                              FDadosCarteira.DigitoContaVinculada, 8);

    LLinkConsulta := FDadosCarteira.LinkConsultaEspecifico.Replace('[BENEFICIARIO]', LBeneficiario)
                                                            .Replace('[CARTEIRA]', FDadosCarteira.CodigoCarteriaVinculada)
                                                            .Replace('[NOSSO_NUMERO]', ADataset.FieldByName('CTR_NOSNUM').AsString
                                                                                                  .Remove(ADataset.FieldByName('CTR_NOSNUM').AsString.Length -1));

    GerarToken;

    LParametros.Clear;
    LParametros.Add('Authorization: ' + FTokenUsoAtual);
    LParametros.Add('x-itau-apikey: ' + FDadosCarteira.ClientId);
    LParametros.Add('x-itau-correlationID: 1');
    LParametros.Add('x-itau-flowID: 2');

    Repeat
      LRealizarConsulta := False;

      ACodigoRetorno := FRestSynalist.ExecuteRestSynalist('GET',
                                                          LLinkConsulta,
                                                          LParametros,
                                                          LResposta);

      If Not MatchStr(ACodigoRetorno.ToString, ['200', '201']) Then
      Begin
        If ACodigoRetorno <> 429 Then
          Raise Exception.Create(LResposta);

        If AContadorErro409 <= 9 Then
        Begin
          Inc(AContadorErro409);

         {$IFDEF LINUX}
          pMensagemOk('Erro de limitação na API do Banco Itaú. Nova tentativa em 75 segundos.');
          Sleep(75000);
         {$ELSE}
          LCaptionTela := AProgresso.lblGravando.Caption;
          AProgresso.lblGravando.Caption := 'Erro de limitação na API do Banco Itaú. Nova tentativa em 75 segundos.';
          Application.ProcessMessages;
          Sleep(75000);
          AProgresso.lblGravando.Caption := LCaptionTela;
          Application.ProcessMessages;
         {$ENDIF}

          LRealizarConsulta := True;
        End;

        If Not LRealizarConsulta Then
          Raise Exception.Create(LResposta);
      End;
    Until (Not LRealizarConsulta);

    Result := RetornaDadosPesquisaBoleto(LResposta);

    If Not Result.NossoNumero.IsEmpty Then
    Begin
      Result.NossoNumero := ADataset.FieldByName('CTR_NOSNUM').AsString;
      Result.RetVinculada := 'S';
    End;
  Finally
    FreeAndNil(LParametros);
  End;
end;

function TBancoItauAPI.ConsultaBoletosCanceladosPorLiquidacao(ADataInicial,
  ADataFinal: TDateTime; AListaImportada: TList<TRetornoPesquisaBancoItauAPI>;
  AContaCorrente: String;
  var AProgresso: TfrmGravando): TList<TRetornoPesquisaBancoItauAPI>;
  Var
    LLinkConsulta,
    LResposta,
    LBeneficiario,
    LCarteira: String;

    LStatus,
    LContadorErro429: Integer;

    LParametros: TStringList;

    LDadosRetorno: TRetornoPesquisaBancoItauAPI;

    LPaginaAtual,
    LTotalPaginas: Integer;

    LJsonObject,
    LJsonPaginacao: TJsonObject;

    LJsonArray: TJsonArray;

    LJsonValue: TJsonValue;

    LIDBeneficiarioVinculada: String;
begin
  Result := AListaImportada;
  LPaginaAtual := 0;
  LTotalPaginas := 0;
  LContadorErro429 := 0;
  LParametros := TStringList.Create;
  Try
    LBeneficiario := RetornaIDBeneficiario;
    LCarteira := FDadosCarteira.CodCarteira;
    LIDBeneficiarioVinculada := RetornaIDBeneficiarioVinculada;
    If AContaCorrente.Equals(LIDBeneficiarioVinculada) Then
    Begin
      LBeneficiario := LIDBeneficiarioVinculada;
      LCarteira := FDadosCarteira.CodigoCarteriaVinculada;
    End;

    Repeat
      LLinkConsulta := FDadosCarteira.LinkConsulta.Replace('[BENEFICIARIO]', LBeneficiario)
                                                  .Replace('[CARTEIRA]', LCarteira)
                                                  .Replace('dataPagamento=[DATA_PAGAMENTO]',
                                                           'dataCancelamento=' + Concat(FormatDateTime('yyyy-mm-dd', ADataInicial), ',',
                                                                                   FormatDateTime('yyyy-mm-dd', ADataFinal)) +
                                                           '&situacao=cancelado&motivoCancelamento=baixaPorTerSidoLiquidado')
                                                  .Replace('[PAGINA]', LPaginaAtual.ToString);

      GerarToken;

      LParametros.Clear;
      LParametros.Add('Authorization: ' + FTokenUsoAtual);
      LParametros.Add('x-itau-apikey: ' + FDadosCarteira.ClientId);
      LParametros.Add('x-itau-correlationID: ' + GeraUUIDVersao4);
      LParametros.Add('x-itau-flowID: 2');

      FRestSynalist.StatusSemRaise := [429];

      LStatus := FRestSynalist.ExecuteRestSynalist('GET',
                                                   LLinkConsulta,
                                                   LParametros,
                                                   LResposta);

      If Not MatchStr(LStatus.ToString, ['200', '201']) Then
      Begin
        If LStatus <> 429 Then
          Raise Exception.Create(LResposta);

        If AguardarException429(LContadorErro429{$IFNDEF LINUX}, AProgresso{$ENDIF}) Then
          Continue;

        Raise Exception.Create(LResposta);
      End;

      LJsonArray := Nil;
      LJsonPaginacao := Nil;
      LJsonObject := TJsonObject.ParseJSONValue(LResposta) As TJsonObject;
      If Not Assigned(LJsonObject) Then
        Raise Exception.CreateFmt('Formato inesperado do arquivo de retorno do banco: %s', [LResposta]);
      Try
        If LPaginaAtual = 0 Then
        Begin
          If Not LJsonObject.TryGetValue<TJsonObject>('pagination', LJsonPaginacao) Then
            Raise Exception.CreateFmt('Formato inesperado do arquivo de retorno do banco: %s', [LResposta]);

          LTotalPaginas := StrToIntDef(RetornaValorJson(LJsonPaginacao, 'totalPages'), 0);

         {$IFNDEF LINUX}
          AProgresso.pgbStatus.Properties.Max := LTotalPaginas;
          AProgresso.pgbStatus.Position := LPaginaAtual;
         {$ENDIF}
        End;

        If Not LJsonObject.TryGetValue<TJsonArray>('data', LJsonArray) Then
          Raise Exception.CreateFmt('Formato inesperado do arquivo de retorno do banco: %s', [LResposta]);

        For LJsonValue In LJsonArray Do
        Begin
          LDadosRetorno := RetornaDadosPesquisaBoletoPeriodo(LJsonValue.ToJSON);
          LDadosRetorno.IDBeneficiario := LBeneficiario;
          LDadosRetorno.CodigoCarteira := LCarteira;
          LDadosRetorno.NomeDoArquivo := Concat(FormatDateTime('dd/mm/yyyy', ADataInicial),
                                                ' - ',
                                                FormatDateTime('dd/mm/yyyy', ADataFinal));

          LDadosRetorno.RetVinculada := 'N';
          If AContaCorrente.Equals(LIDBeneficiarioVinculada) Then
            LDadosRetorno.RetVinculada := 'S';

          Result.Add(LDadosRetorno);
        End;

        Inc(LPaginaAtual);

       {$IFNDEF LINUX}
        pStep(AProgresso.pgbStatus);
       {$ENDIF}

      Finally
        FreeAndNil(LJsonObject);
      End;
    Until(LPaginaAtual > LTotalPaginas);
  Finally
    FreeAndNil(LParametros);
  End;
end;

function TBancoItauAPI.ConsultaBoletosCanceladosPorPeriodo(ADataInicial,
                                                 ADataFinal: TDateTime;
                                                 AListaImportada: TList<TRetornoPesquisaBancoItauAPI>;
                                                 AContaCorrente: String
                                                 {$IFNDEF LINUX}; var AProgresso: TfrmGravando{$ENDIF}): TList<TRetornoPesquisaBancoItauAPI>;
  Var
    LLinkConsulta,
    LResposta,
    LBeneficiario,
    LCarteira: String;

    LStatus,
    LContadorErro429: Integer;

    LParametros: TStringList;

    LDadosRetorno: TRetornoPesquisaBancoItauAPI;

    LPaginaAtual,
    LTotalPaginas: Integer;

    LJsonObject,
    LJsonPaginacao: TJsonObject;

    LJsonArray: TJsonArray;

    LJsonValue: TJsonValue;

    LIDBeneficiarioVinculada: String;
begin

  Result := AListaImportada;
  LPaginaAtual := 0;
  LTotalPaginas := 0;
  LContadorErro429 := 0;
  LParametros := TStringList.Create;
  Try
    LBeneficiario := RetornaIDBeneficiario;
    LCarteira := FDadosCarteira.CodCarteira;
    LIDBeneficiarioVinculada := RetornaIDBeneficiarioVinculada;
    If AContaCorrente.Equals(LIDBeneficiarioVinculada) Then
    Begin
      LBeneficiario := LIDBeneficiarioVinculada;
      LCarteira := FDadosCarteira.CodigoCarteriaVinculada;
    End;

    Repeat
      LLinkConsulta := FDadosCarteira.LinkConsulta.Replace('[BENEFICIARIO]', LBeneficiario)
                                                  .Replace('[CARTEIRA]', LCarteira)
                                                  .Replace('dataPagamento=[DATA_PAGAMENTO]',
                                                           'dataCancelamento=' + Concat(FormatDateTime('yyyy-mm-dd', ADataInicial), ',',
                                                                                   FormatDateTime('yyyy-mm-dd', ADataFinal)) +
                                                           '&situacao=cancelado&situacaoProtesto=emProtesto')
                                                  .Replace('[PAGINA]', LPaginaAtual.ToString);

      GerarToken;

      LParametros.Clear;
      LParametros.Add('Authorization: ' + FTokenUsoAtual);
      LParametros.Add('x-itau-apikey: ' + FDadosCarteira.ClientId);
      LParametros.Add('x-itau-correlationID: ' + GeraUUIDVersao4);
      LParametros.Add('x-itau-flowID: 2');

      FRestSynalist.StatusSemRaise := [429];

      LStatus := FRestSynalist.ExecuteRestSynalist('GET',
                                                   LLinkConsulta,
                                                   LParametros,
                                                   LResposta);

      If Not MatchStr(LStatus.ToString, ['200', '201']) Then
      Begin
        If LStatus <> 429 Then
          Raise Exception.Create(LResposta);

        If AguardarException429(LContadorErro429{$IFNDEF LINUX}, AProgresso{$ENDIF}) Then
          Continue;

        Raise Exception.Create(LResposta);
      End;

      LJsonArray := Nil;
      LJsonPaginacao := Nil;
      LJsonObject := TJsonObject.ParseJSONValue(LResposta) As TJsonObject;
      If Not Assigned(LJsonObject) Then
        Raise Exception.CreateFmt('Formato inesperado do arquivo de retorno do banco: %s', [LResposta]);
      Try
        If LPaginaAtual = 0 Then
        Begin
          If Not LJsonObject.TryGetValue<TJsonObject>('pagination', LJsonPaginacao) Then
            Raise Exception.CreateFmt('Formato inesperado do arquivo de retorno do banco: %s', [LResposta]);

          LTotalPaginas := StrToIntDef(RetornaValorJson(LJsonPaginacao, 'totalPages'), 0);

         {$IFNDEF LINUX}
          AProgresso.pgbStatus.Properties.Max := LTotalPaginas;
          AProgresso.pgbStatus.Position := LPaginaAtual;
         {$ENDIF}
        End;

        If Not LJsonObject.TryGetValue<TJsonArray>('data', LJsonArray) Then
          Raise Exception.CreateFmt('Formato inesperado do arquivo de retorno do banco: %s', [LResposta]);

        For LJsonValue In LJsonArray Do
        Begin
          LDadosRetorno := RetornaDadosPesquisaBoletoPeriodo(LJsonValue.ToJSON);
          LDadosRetorno.IDBeneficiario := LBeneficiario;
          LDadosRetorno.CodigoCarteira := LCarteira;
          LDadosRetorno.NomeDoArquivo := Concat(FormatDateTime('dd/mm/yyyy', ADataInicial),
                                                ' - ',
                                                FormatDateTime('dd/mm/yyyy', ADataFinal));

          Result.Add(LDadosRetorno);
        End;

        Inc(LPaginaAtual);

       {$IFNDEF LINUX}
        pStep(AProgresso.pgbStatus);
       {$ENDIF}

      Finally
        FreeAndNil(LJsonObject);
      End;
    Until(LPaginaAtual > LTotalPaginas);

    LPaginaAtual := 0;
    LTotalPaginas := 0;
    LContadorErro429 := 0;

    Repeat
      LLinkConsulta := FDadosCarteira.LinkConsulta.Replace('[BENEFICIARIO]', LBeneficiario)
                                                  .Replace('[CARTEIRA]', LCarteira)
                                                  .Replace('dataPagamento=[DATA_PAGAMENTO]',
                                                           'dataCancelamento=' + Concat(FormatDateTime('yyyy-mm-dd', ADataInicial), ',',
                                                                                   FormatDateTime('yyyy-mm-dd', ADataFinal)) +
                                                           '&situacao=cancelado&situacaoProtesto=protestado')
                                                  .Replace('[PAGINA]', LPaginaAtual.ToString);

      GerarToken;

      LParametros.Clear;
      LParametros.Add('Authorization: ' + FTokenUsoAtual);
      LParametros.Add('x-itau-apikey: ' + FDadosCarteira.ClientId);
      LParametros.Add('x-itau-correlationID: ' + GeraUUIDVersao4);
      LParametros.Add('x-itau-flowID: 2');

      FRestSynalist.StatusSemRaise := [429];

      LStatus := FRestSynalist.ExecuteRestSynalist('GET',
                                                   LLinkConsulta,
                                                   LParametros,
                                                   LResposta);

      If Not MatchStr(LStatus.ToString, ['200', '201']) Then
      Begin
        If LStatus <> 429 Then
          Raise Exception.Create(LResposta);

        If AguardarException429(LContadorErro429{$IFNDEF LINUX}, AProgresso{$ENDIF}) Then
          Continue;

        Raise Exception.Create(LResposta);
      End;

      LJsonArray := Nil;
      LJsonPaginacao := Nil;
      LJsonObject := TJsonObject.ParseJSONValue(LResposta) As TJsonObject;
      If Not Assigned(LJsonObject) Then
        Raise Exception.CreateFmt('Formato inesperado do arquivo de retorno do banco: %s', [LResposta]);
      Try
        If LPaginaAtual = 0 Then
        Begin
          If Not LJsonObject.TryGetValue<TJsonObject>('pagination', LJsonPaginacao) Then
            Raise Exception.CreateFmt('Formato inesperado do arquivo de retorno do banco: %s', [LResposta]);

          LTotalPaginas := StrToIntDef(RetornaValorJson(LJsonPaginacao, 'totalPages'), 0);

         {$IFNDEF LINUX}
          AProgresso.pgbStatus.Properties.Max := LTotalPaginas;
          AProgresso.pgbStatus.Position := LPaginaAtual;
         {$ENDIF}
        End;

        If Not LJsonObject.TryGetValue<TJsonArray>('data', LJsonArray) Then
          Raise Exception.CreateFmt('Formato inesperado do arquivo de retorno do banco: %s', [LResposta]);

        For LJsonValue In LJsonArray Do
        Begin
          LDadosRetorno := RetornaDadosPesquisaBoletoPeriodo(LJsonValue.ToJSON);
          LDadosRetorno.IDBeneficiario := LBeneficiario;
          LDadosRetorno.CodigoCarteira := LCarteira;
          LDadosRetorno.NomeDoArquivo := Concat(FormatDateTime('dd/mm/yyyy', ADataInicial),
                                                ' - ',
                                                FormatDateTime('dd/mm/yyyy', ADataFinal));

          Result.Add(LDadosRetorno);
        End;

        Inc(LPaginaAtual);

       {$IFNDEF LINUX}
        pStep(AProgresso.pgbStatus);
       {$ENDIF}
      Finally
        FreeAndNil(LJsonObject);
      End;
    Until(LPaginaAtual > LTotalPaginas);
  Finally
    FreeAndNil(LParametros);
  End;
end;

function TBancoItauAPI.ConsultaBoletosEmAbertoPorPeriodo(ADataInicial,
                                               ADataFinal: TDateTime;
                                               AListaImportada: TList<TRetornoPesquisaBancoItauAPI>;
                                               AContaCorrente: String
                                               {$IFNDEF LINUX}; var AProgresso: TfrmGravando{$ENDIF}): TList<TRetornoPesquisaBancoItauAPI>;
  Var
    LLinkConsulta,
    LResposta,
    LBeneficiario,
    LCarteira: String;

    LStatus,
    LContadorErro429: Integer;

    LParametros: TStringList;

    LDadosRetorno: TRetornoPesquisaBancoItauAPI;

    LPaginaAtual,
    LTotalPaginas: Integer;

    LJsonObject,
    LJsonPaginacao: TJsonObject;

    LJsonArray: TJsonArray;

    LJsonValue: TJsonValue;
begin
  Result := AListaImportada;
  LPaginaAtual := 0;
  LTotalPaginas := 0;
  LContadorErro429 := 0;
  LParametros := TStringList.Create;
  Try
    LBeneficiario := RetornaIDBeneficiario;
    LCarteira := FDadosCarteira.CodCarteira;
    If AContaCorrente.Equals(FDadosCarteira.ContaCorrenteVinculada) Then
    Begin
      LBeneficiario := RetornaIDBeneficiarioVinculada;
      LCarteira := FDadosCarteira.CodigoCarteriaVinculada;
    End;

    Repeat
      LLinkConsulta := FDadosCarteira.LinkConsulta.Replace('[BENEFICIARIO]', LBeneficiario)
                                                  .Replace('[CARTEIRA]', LCarteira)
                                                  .Replace('dataPagamento=[DATA_PAGAMENTO]',
                                                           'dataEntrada=' + Concat(FormatDateTime('yyyy-mm-dd', ADataInicial), ',',
                                                                                   FormatDateTime('yyyy-mm-dd', ADataFinal)) +
                                                           '&situacao=aberto')
                                                  .Replace('[PAGINA]', LPaginaAtual.ToString);

      GerarToken;

      LParametros.Clear;
      LParametros.Add('Authorization: ' + FTokenUsoAtual);
      LParametros.Add('x-itau-apikey: ' + FDadosCarteira.ClientId);
      LParametros.Add('x-itau-correlationID: ' + GeraUUIDVersao4);
      LParametros.Add('x-itau-flowID: 2');

      FRestSynalist.StatusSemRaise := [429];

      LStatus := FRestSynalist.ExecuteRestSynalist('GET',
                                                   LLinkConsulta,
                                                   LParametros,
                                                   LResposta);

      If Not MatchStr(LStatus.ToString, ['200', '201']) Then
      Begin
        If LStatus <> 429 Then
          Raise Exception.Create(LResposta);

        If AguardarException429(LContadorErro429{$IFNDEF LINUX}, AProgresso{$ENDIF}) Then
          Continue;

        Raise Exception.Create(LResposta);
      End;

      LJsonArray := Nil;
      LJsonPaginacao := Nil;
      LJsonObject := TJsonObject.ParseJSONValue(LResposta) As TJsonObject;
      If Not Assigned(LJsonObject) Then
        Raise Exception.CreateFmt('Formato inesperado do arquivo de retorno do banco: %s', [LResposta]);
      Try
        If LPaginaAtual = 0 Then
        Begin
          If Not LJsonObject.TryGetValue<TJsonObject>('pagination', LJsonPaginacao) Then
            Raise Exception.CreateFmt('Formato inesperado do arquivo de retorno do banco: %s', [LResposta]);

          LTotalPaginas := StrToIntDef(RetornaValorJson(LJsonPaginacao, 'totalPages'), 0);

         {$IFNDEF LINUX}
          AProgresso.pgbStatus.Properties.Max := LTotalPaginas;
          AProgresso.pgbStatus.Position := LPaginaAtual;
         {$ENDIF}
        End;

        If Not LJsonObject.TryGetValue<TJsonArray>('data', LJsonArray) Then
          Raise Exception.CreateFmt('Formato inesperado do arquivo de retorno do banco: %s', [LResposta]);

        For LJsonValue In LJsonArray Do
        Begin
          LDadosRetorno := RetornaDadosPesquisaBoletoPeriodo(LJsonValue.ToJSON);
          LDadosRetorno.IDBeneficiario := LBeneficiario;
          LDadosRetorno.CodigoCarteira := LCarteira;
          LDadosRetorno.NomeDoArquivo := Concat(FormatDateTime('dd/mm/yyyy', ADataInicial),
                                                ' - ',
                                                FormatDateTime('dd/mm/yyyy', ADataFinal));

          Result.Add(LDadosRetorno);
        End;

        Inc(LPaginaAtual);

       {$IFNDEF LINUX}
        pStep(AProgresso.pgbStatus);
       {$ENDIF}
      Finally
        FreeAndNil(LJsonObject);
      End;
    Until(LPaginaAtual > LTotalPaginas);
  Finally
    FreeAndNil(LParametros);
  End;
end;

function TBancoItauAPI.ConsultaBoletosLiquidadosPorPeriodo(ADataInicial,
                                                 ADataFinal: TDateTime;
                                                 AListaImportada: TList<TRetornoPesquisaBancoItauAPI>;
                                                 AContaCorrente: String
                                                 {$IFNDEF LINUX}; var AProgresso: TfrmGravando{$ENDIF}): TList<TRetornoPesquisaBancoItauAPI>;
  Var
    LLinkConsulta,
    LResposta,
    LBeneficiario,
    LCarteira: String;

    LStatus,
    LContadorErro429: Integer;

    LParametros: TStringList;

    LDadosRetorno: TRetornoPesquisaBancoItauAPI;

    LPaginaAtual,
    LTotalPaginas: Integer;

    LJsonObject,
    LJsonPaginacao: TJsonObject;

    LJsonArray: TJsonArray;

    LJsonValue: TJsonValue;

    LIDBeneficiarioVinculada: String;
begin
  Result := AListaImportada;
  LPaginaAtual := 0;
  LTotalPaginas := 0;
  LContadorErro429 := 0;
  LParametros := TStringList.Create;
  Try
    LBeneficiario := RetornaIDBeneficiario;
    LCarteira := FDadosCarteira.CodCarteira;
    LIDBeneficiarioVinculada := RetornaIDBeneficiarioVinculada;
    If AContaCorrente.Equals(LIDBeneficiarioVinculada) Then
    Begin
      LBeneficiario := LIDBeneficiarioVinculada;
      LCarteira := FDadosCarteira.CodigoCarteriaVinculada;
    End;

    Repeat
      LLinkConsulta := FDadosCarteira.LinkConsulta.Replace('[BENEFICIARIO]', LBeneficiario)
                                                  .Replace('[CARTEIRA]', LCarteira)
                                                  .Replace('[DATA_PAGAMENTO]', Concat(FormatDateTime('yyyy-mm-dd', ADataInicial), ',',
                                                                                      FormatDateTime('yyyy-mm-dd', ADataFinal)))
                                                  .Replace('[PAGINA]', LPaginaAtual.ToString);

      GerarToken;

      LParametros.Clear;
      LParametros.Add('Authorization: ' + FTokenUsoAtual);
      LParametros.Add('x-itau-apikey: ' + FDadosCarteira.ClientId);
      LParametros.Add('x-itau-correlationID: ' + GeraUUIDVersao4);
      LParametros.Add('x-itau-flowID: 2');

      FRestSynalist.StatusSemRaise := [429];

      LStatus := FRestSynalist.ExecuteRestSynalist('GET',
                                                   LLinkConsulta,
                                                   LParametros,
                                                   LResposta);

      If Not MatchStr(LStatus.ToString, ['200', '201']) Then
      Begin
        If LStatus <> 429 Then
          Raise Exception.Create(LResposta);

        If AguardarException429(LContadorErro429{$IFNDEF LINUX}, AProgresso{$ENDIF}) Then
          Continue;

        Raise Exception.Create(LResposta);
      End;

      LJsonArray := Nil;
      LJsonPaginacao := Nil;
      LJsonObject := TJsonObject.ParseJSONValue(LResposta) As TJsonObject;
      If Not Assigned(LJsonObject) Then
        Raise Exception.CreateFmt('Formato inesperado do arquivo de retorno do banco: %s', [LResposta]);
      Try
        If LPaginaAtual = 0 Then
        Begin
          If Not LJsonObject.TryGetValue<TJsonObject>('pagination', LJsonPaginacao) Then
            Raise Exception.CreateFmt('Formato inesperado do arquivo de retorno do banco: %s', [LResposta]);

          LTotalPaginas := StrToIntDef(RetornaValorJson(LJsonPaginacao, 'totalPages'), 0);

         {$IFNDEF LINUX}
          AProgresso.pgbStatus.Properties.Max := LTotalPaginas;
          AProgresso.pgbStatus.Position := LPaginaAtual;
         {$ENDIF}
        End;

        If Not LJsonObject.TryGetValue<TJsonArray>('data', LJsonArray) Then
          Raise Exception.CreateFmt('Formato inesperado do arquivo de retorno do banco: %s', [LResposta]);

        For LJsonValue In LJsonArray Do
        Begin
          LDadosRetorno := RetornaDadosPesquisaBoletoPeriodo(LJsonValue.ToJSON);
          LDadosRetorno.IDBeneficiario := LBeneficiario;
          LDadosRetorno.CodigoCarteira := LCarteira;
          LDadosRetorno.NomeDoArquivo := Concat(FormatDateTime('dd/mm/yyyy', ADataInicial),
                                                ' - ',
                                                FormatDateTime('dd/mm/yyyy', ADataFinal));

          Result.Add(LDadosRetorno);
        End;

        Inc(LPaginaAtual);

       {$IFNDEF LINUX}
        pStep(AProgresso.pgbStatus);
       {$ENDIF}
      Finally
        FreeAndNil(LJsonObject);
      End;
    Until(LPaginaAtual > LTotalPaginas);
  Finally
    FreeAndNil(LParametros);
  End;
end;

function TBancoItauAPI.ConsultaMovimentacoesFrancesa(const ADataInicial,
                                                           ADataFinal: TDateTime;
                                                     ATarifas: TDictionary<String, Integer>;
                                                     ADescontos: TList<TMovimentoDescontoItau>;
                                                     out AErro: String
                                                     {$IFNDEF LINUX}; var AProgresso: TfrmGravando{$ENDIF}): Boolean;
  Var
    LData,
    LDataFinal: TDateTime;
begin
  Result := False;
  AErro := EmptyStr;

  If FDadosCarteira.LinkFrancesa.Trim.IsEmpty Then
  Begin
    AErro := 'Link da consulta de movimentações (francesa) do Itaú não cadastrado.';
    Exit;
  End;

  LData := IncDay(DateOf(ADataInicial), -5);
  If LData < IncDay(VS_Date, -45) Then
    LData := IncDay(VS_Date, -45);

  If DateOf(ADataInicial) < IncDay(VS_Date, -45) Then
    AErro := 'A francesinha do Itaú só guarda os últimos 45 dias: tarifas e duplicatas descontadas anteriores a ' +
             FormatDateTime('dd/mm/yyyy', IncDay(VS_Date, -45)) + ' não foram consultadas.';

  LDataFinal := IncDay(DateOf(ADataFinal), 5);
  If LDataFinal > VS_Date Then
    LDataFinal := VS_Date;

  Try
    While LData <= LDataFinal Do
    Begin
      If Assigned(ATarifas) Then
        ConsultaFrancesaDia(RetornaIDBeneficiario, LData, '&tipo_movimentacao=liquidacoes',
                            ATarifas, Nil{$IFNDEF LINUX}, AProgresso{$ENDIF});

      If Assigned(ADescontos) Then
        ConsultaFrancesaDia(RetornaIDBeneficiario, LData, '&tipo_cobranca=boleto_descontado',
                            Nil, ADescontos{$IFNDEF LINUX}, AProgresso{$ENDIF});

      LData := IncDay(LData, 1);
    End;

    Result := True;
  Except
    On E: Exception Do
      AErro := E.Message;
  End;
end;

procedure TBancoItauAPI.ConsultaFrancesaDia(const AIDFrancesa: String;
                                            const AData: TDateTime;
                                            const AFiltro: String;
                                            ATarifas: TDictionary<String, Integer>;
                                            ADescontos: TList<TMovimentoDescontoItau>
                                            {$IFNDEF LINUX}; var AProgresso: TfrmGravando{$ENDIF});
  Var
    LLinkConsulta,
    LResposta: String;

    LStatus,
    LContadorErro429,
    LPaginaAtual,
    LTotalPaginas: Integer;

    LParametros: TStringList;

    LStatusSemRaiseAnterior: TArrayStatusSemRaiseException;

    LJsonObject,
    LJsonPaginacao: TJsonObject;

    LJsonArray: TJsonArray;

    LJsonValue,
    LJsonResposta: TJsonValue;
begin
  LPaginaAtual := 0;
  LTotalPaginas := 1;
  LContadorErro429 := 0;
  LStatusSemRaiseAnterior := FRestSynalist.StatusSemRaise;
  LParametros := TStringList.Create;
  Try
    While LPaginaAtual < LTotalPaginas Do
    Begin
      LLinkConsulta := FDadosCarteira.LinkFrancesa.Replace('[BENEFICIARIO]', AIDFrancesa)
                                                  .Replace('[DATA]', FormatDateTime('yyyy-mm-dd', AData))
                                                  .Replace('[PAGINA]', LPaginaAtual.ToString) + AFiltro;

      GerarToken;

      LParametros.Clear;
      LParametros.Add('Authorization: ' + FTokenUsoAtual);
      LParametros.Add('x-itau-apikey: ' + FDadosCarteira.ClientId);
      LParametros.Add('x-itau-correlationID: ' + GeraUUIDVersao4);
      LParametros.Add('x-itau-flowID: 2');

      FRestSynalist.StatusSemRaise := [204, 422, 429];

      LStatus := FRestSynalist.ExecuteRestSynalist('GET',
                                                   LLinkConsulta,
                                                   LParametros,
                                                   LResposta);

      If LStatus = 204 Then
        Break;

      If LStatus = 422 Then
      Begin
        If DataSemMovimentacaoFrancesa(LResposta) Then
          Break;

        Raise Exception.Create(LResposta);
      End;

      If LStatus = 429 Then
      Begin
        If AguardarException429(LContadorErro429{$IFNDEF LINUX}, AProgresso{$ENDIF}) Then
          Continue;

        Raise Exception.Create(LResposta);
      End;

      LJsonResposta := TJsonObject.ParseJSONValue(LResposta);
      Try
        If Not (LJsonResposta Is TJsonObject) Then
          Raise Exception.CreateFmt('Formato inesperado da francesa do banco: %s', [LResposta]);

        LJsonObject := TJsonObject(LJsonResposta);

        If LJsonObject.TryGetValue<TJsonObject>('pagination', LJsonPaginacao) Then
          LTotalPaginas := StrToIntDef(RetornaValorJson(LJsonPaginacao, 'total_pages'), 1);

        If Not LJsonObject.TryGetValue<TJsonArray>('data', LJsonArray) Then
          Raise Exception.CreateFmt('Formato inesperado da francesa do banco: %s', [LResposta]);

        For LJsonValue In LJsonArray Do
        Begin
          If RetornaValorJsonValue(LJsonValue, 'nosso_numero').IsEmpty Then
            Continue;

          If Assigned(ATarifas) Then
            RegistraTarifaFrancesa(LJsonValue, ATarifas);

          If Assigned(ADescontos) Then
            RegistraMovimentoDesconto(LJsonValue, ADescontos);
        End;
      Finally
        FreeAndNil(LJsonResposta);
      End;

      Inc(LPaginaAtual);
    End;
  Finally
    FRestSynalist.StatusSemRaise := LStatusSemRaiseAnterior;
    FreeAndNil(LParametros);
  End;
end;

function TBancoItauAPI.ValorFrancesaEmCentavos(const AValor: String): Integer;
begin
  Result := Round(fStrToFloat(fTrocaPontoporVirgula(AValor)) * 100);
end;

procedure TBancoItauAPI.RegistraTarifaFrancesa(AItem: TJsonValue;
                                               ATarifas: TDictionary<String, Integer>);
  Var
    LJsonOperacoes: TJsonArray;

    LJsonOperacao: TJsonValue;

    LTarifa: Integer;
begin
  If Not AItem.TryGetValue<TJsonArray>('operacoes_cobranca', LJsonOperacoes) Then
    Exit;

  LTarifa := 0;
  For LJsonOperacao In LJsonOperacoes Do
  Begin
    If ContainsText(RetornaValorJsonValue(LJsonOperacao, 'descricao'), 'tarifa') Then
      LTarifa := LTarifa + Abs(ValorFrancesaEmCentavos(RetornaValorJsonValue(LJsonOperacao, 'valor')));
  End;

  If LTarifa > 0 Then
    ATarifas.AddOrSetValue(fStrZero(RetornaValorJsonValue(AItem, 'nosso_numero'), 8), LTarifa);
end;

procedure TBancoItauAPI.RegistraMovimentoDesconto(AItem: TJsonValue;
                                                  ADescontos: TList<TMovimentoDescontoItau>);
  Var
    LMovimento: TMovimentoDescontoItau;

    LJsonOperacoes: TJsonArray;

    LJsonOperacao: TJsonValue;

    LDescricao: String;

    LValor: Integer;
begin
  LMovimento := Default(TMovimentoDescontoItau);
  LMovimento.Status := RetornaValorJsonValue(AItem, 'codigo_status');

  If Not MatchStr(LMovimento.Status, ['EZ', 'LZ', 'BY']) Then
    Exit;

  LMovimento.NossoNumero := fStrZero(RetornaValorJsonValue(AItem, 'nosso_numero') +
                                     RetornaValorJsonValue(AItem, 'dac_titulo'), 9);
  LMovimento.SeuNumero := RetornaValorJsonValue(AItem, 'seu_numero').Trim;
  LMovimento.DataMovimentacao := RetornaValorJsonValue(AItem, 'data_movimentacao');
  LMovimento.DataVencimento := RetornaValorJsonValue(AItem, 'data_vencimento');

  CorrigeDatas(LMovimento.DataMovimentacao);
  CorrigeDatas(LMovimento.DataVencimento);
  LMovimento.ValorTitulo := ValorFrancesaEmCentavos(RetornaValorJsonValue(AItem, 'valor_titulo'));
  LMovimento.ValorLiquido := ValorFrancesaEmCentavos(RetornaValorJsonValue(AItem, 'valor_liquido_lancado'));

  If AItem.TryGetValue<TJsonArray>('operacoes_desconto', LJsonOperacoes) Then
  Begin
    For LJsonOperacao In LJsonOperacoes Do
    Begin
      LDescricao := RetornaValorJsonValue(LJsonOperacao, 'descricao');
      LValor := Abs(ValorFrancesaEmCentavos(RetornaValorJsonValue(LJsonOperacao, 'valor')));

      If ContainsText(LDescricao, 'contrata') Then
        LMovimento.Contratacao := LMovimento.Contratacao + LValor
      Else If ContainsText(LDescricao, 'tarifa') Then
        LMovimento.TarifaBoleto := LMovimento.TarifaBoleto + LValor
      Else If ContainsText(LDescricao, 'juros') Then
        LMovimento.Juros := LMovimento.Juros + LValor
      Else If ContainsText(LDescricao, 'iof') Then
        LMovimento.IOF := LMovimento.IOF + LValor;
    End;
  End;

  ADescontos.Add(LMovimento);
end;

function TBancoItauAPI.DataSemMovimentacaoFrancesa(const AResposta: String): Boolean;
  Var
    LJsonResposta,
    LJsonCampo: TJsonValue;

    LJsonCampos: TJsonArray;
begin
  Result := False;

  LJsonResposta := TJsonObject.ParseJSONValue(AResposta);
  Try
    If Not (LJsonResposta Is TJsonObject) Then
      Exit;

    If Not TJsonObject(LJsonResposta).TryGetValue<TJsonArray>('campos', LJsonCampos) Then
      Exit;

    For LJsonCampo In LJsonCampos Do
    Begin
      If RetornaValorJsonValue(LJsonCampo, 'campo').Equals('data') And
         ContainsText(RetornaValorJsonValue(LJsonCampo, 'mensagem'), 'movimenta') Then
        Exit(True);
    End;
  Finally
    FreeAndNil(LJsonResposta);
  End;
end;

function TBancoItauAPI.RetornaTarifaFrancesa(ATarifas: TDictionary<String, Integer>;
                                             ABoleto: TRetornoPesquisaBancoItauAPI): String;
  Var
    LTarifa: Integer;
begin
  Result := EmptyStr;

  If Not Assigned(ATarifas) Then
    Exit;

  If ATarifas.TryGetValue(LeftStr(fStrZero(ABoleto.NossoNumero, 9), 8), LTarifa) Then
    Result := LTarifa.ToString;
end;

function TBancoItauAPI.RetornaMovimentoDesconto(ADescontos: TList<TMovimentoDescontoItau>;
                                                const ANossoNumero,
                                                      AStatus: String;
                                                out AMovimento: TMovimentoDescontoItau): Boolean;
  Var
    LMovimento: TMovimentoDescontoItau;
begin
  Result := False;
  AMovimento := Default(TMovimentoDescontoItau);

  If Not Assigned(ADescontos) Then
    Exit;

  For LMovimento In ADescontos Do
  Begin
    If LMovimento.Status.Equals(AStatus) And LMovimento.NossoNumero.Equals(fStrZero(ANossoNumero, 9)) Then
    Begin
      AMovimento := LMovimento;
      Exit(True);
    End;
  End;
end;

function TBancoItauAPI.ConsultaBoletosPorNossoNumeroLista(AListaBoletos: TList<TRetornoPesquisaBancoItauAPI>;
                                                AContaCorrente: String
                                                {$IFNDEF LINUX}; var AProgresso: TfrmGravando{$ENDIF}): TList<TRetornoPesquisaBancoItauAPI>;
  Var
    LStatus,
    LContador,
    LTentativas,
    LContadorErro429: Integer;

    LParametros: TStringList;

    LResposta,
    LLinkConsulta,
    LBeneficiario: String;

    LTerminou: Boolean;

    LDadosRetorno: TRetornoPesquisaBancoItauAPI;
    LIDBeneficiarioVinculada,
    LNossoNumeroSemDigito,
    LDigitoNossoNumero: String;
begin
  Result := AListaBoletos;

  If Result.Count = 0 THen
    Exit;

  LParametros := TStringList.Create;

  LBeneficiario := RetornaIDBeneficiario;
  LIDBeneficiarioVinculada := RetornaIDBeneficiarioVinculada;
  If AContaCorrente.Equals(LIDBeneficiarioVinculada) Then
    LBeneficiario := LIDBeneficiarioVinculada;

  Try
    Try
      LContadorErro429 := 0;

      For LContador := 0 To Result.Count - 1 Do
      Begin
        If Not AListaBoletos[LContador].IDBeneficiario.Equals(LBeneficiario) Then
          Continue;

        LTerminou := False;
        LTentativas := 0;
        While Not LTerminou Do
        Begin
          LLinkConsulta := FDadosCarteira.LinkConsultaEspecifico.Replace('[BENEFICIARIO]', Result[LContador].IDBeneficiario)
                                                                .Replace('[CARTEIRA]', Result[LContador].CodigoCarteira)
                                                                .Replace('[NOSSO_NUMERO]', Result[LContador].NossoNumero)
                                                                .Replace('[DATA_EMISSAO]', Result[LContador].DataEmissao);

          GerarToken;

          LParametros.Clear;
          LParametros.Add('Authorization: ' + FTokenUsoAtual);
          LParametros.Add('x-itau-apikey: ' + FDadosCarteira.ClientId);
          LParametros.Add('x-itau-correlationID: 1');
          LParametros.Add('x-itau-flowID: 2');

          FRestSynalist.StatusSemRaise := [429];

          LStatus := FRestSynalist.ExecuteRestSynalist('GET',
                                                       LLinkConsulta,
                                                       LParametros,
                                                       LResposta);

          If Not MatchStr(LStatus.ToString, ['200', '201']) Then
          Begin
            If LStatus <> 429 Then
              Raise Exception.Create(LResposta);

            If AguardarException429(LContadorErro429{$IFNDEF LINUX}, AProgresso{$ENDIF}) Then
              Continue;

            Raise Exception.Create(LResposta);
          End;

          LDadosRetorno := RetornaDadosPesquisaBoleto(LResposta);

          If LDadosRetorno.DataEmissao.Equals(FormatDateTime('yyyy-mm-dd', VS_Date)) Then
          Begin
            If LDadosRetorno.LinhaDigitavel.IsEmpty Then
            Begin
              LTerminou := True;
              FreeAndNil(LDadosRetorno);
              Continue;
            End;
          End;

          If Concat(LDadosRetorno.DataEmissao, LDadosRetorno.NossoNumero).IsEmpty Then
          Begin
            Sleep(200);
            Inc(LTentativas);
            LTerminou := LTentativas >= 2;
            FreeAndNil(LDadosRetorno);
            Continue;
          End;

          LDadosRetorno.NomeDoArquivo := Result[LContador].NomeDoArquivo;
          LDadosRetorno.RetVinculada  := Result[LContador].RetVinculada;

          ConsultaDadosPixBoleto(LDadosRetorno);

          LNossoNumeroSemDigito := Result[LContador].NossoNumero;

          If BoletoTransferidoParaContaVinculadaEPagoPorPix(LDadosRetorno) Then
          Begin
            Try
              LDadosRetorno.NossoNumero := fCampotabela('CTR_NOSNUM', 'CADREC', ['CTR_BCOBOL', 'CTR_ID_BOL'], ['341', LDadosRetorno.IDBoleto]);
            Except
              FreeAndNil(LDadosRetorno);
              Raise;
            End;
          End
          Else If BoletoTransferidoParaContaVinculadaNovaAPI(LNossoNumeroSemDigito, LBeneficiario = LIDBeneficiarioVinculada, LDadosRetorno) Then
          Begin
            Try
              LDigitoNossoNumero := fCalcDigito('341',
                                                IntToStr(StrToInt64(LNossoNumeroSemDigito)),
                                                '341API',
                                                StrToInt(Copy(FDadosCarteira.CarteiraCompleta, 14, 1)),
                                                FDadosCarteira.EmpresaCarteira);
              LDadosRetorno.NossoNumero := LNossoNumeroSemDigito + LDigitoNossoNumero;
              LDadosRetorno.NossoNumero := fStrZero(LDadosRetorno.NossoNumero, 9);
            Except
              FreeAndNil(LDadosRetorno);
              Raise;
            End;
          End;

          CorrigeDatas(LDadosRetorno.DataEntrada);
          CorrigeDatas(LDadosRetorno.DataEmissao);
          CorrigeDatas(LDadosRetorno.DataVencimento);
          CorrigeDatas(LDadosRetorno.DataPagamento);
          CorrigeDatas(LDadosRetorno.DataBaixaAlteracao);

          LDadosRetorno.DataCredito := RetornaDataParaCredito(LDadosRetorno.DataPagamento,
                                                              LDadosRetorno.PagoPorPix);

          Result[LContador].Free;
          Result[LContador] := LDadosRetorno;

          LTerminou := True;

          Sleep(250); //Tentativa de diminuir erros 429 da API
        End;

       {$IFNDEF LINUX}
        pStep(AProgresso.pgbStatus);
       {$ENDIF}
      End;
    Finally
      FreeAndNil(LParametros);

      FRestSynalist.StatusSemRaise := [];
    End;
  Except
    Raise;
  End;
end;

function TBancoItauAPI.NovaConsultaBoletos(ADataInicial,
                                 ADataFinal: TDateTime
                                 {$IFNDEF LINUX}; var AProgresso: TfrmGravando{$ENDIF}): TList<TRetornoPesquisaBancoItauAPI>;
  Var
    LListaBeneficiarios: TStringList;

    LBeneficiario: String;

    LMaximoProgresso: Integer;
begin
  Result := TList<TRetornoPesquisaBancoItauApi>.Create;

  LListaBeneficiarios := TStringList.Create;
  LListaBeneficiarios.Add(RetornaIDBeneficiario);
  LListaBeneficiarios.Add(RetornaIDBeneficiarioVinculada);

  LMaximoProgresso := 0;

  Try
    For LBeneficiario In LListaBeneficiarios Do
    Begin
      If LBeneficiario.Trim.IsEmpty Then
        Continue;

      Try
       {$IFNDEF LINUX}
        AProgresso.lblGravando.Caption := 'Importando boletos da carteira ' + FDadosCarteira.CarteiraCompleta.Split(['-'])[1] + ' - empresa ' + FDadosCarteira.CarteiraCompleta.Split(['-'])[2] + '.';
       {$ENDIF}

        Result := ConsultaBoletosEmAbertoPorPeriodo(ADataInicial,
                                                    ADataFinal,
                                                    Result,
                                                    LBeneficiario
                                                    {$IFNDEF LINUX},AProgresso{$ENDIF});

        Result := ConsultaBoletosLiquidadosPorPeriodo(ADataInicial,
                                                      ADataFinal,
                                                      Result,
                                                      LBeneficiario
                                                      {$IFNDEF LINUX},AProgresso{$ENDIF});

        Result := ConsultaBoletosCanceladosPorLiquidacao(ADataInicial,
                                                         ADataFinal,
                                                         Result,
                                                      LBeneficiario
                                                      {$IFNDEF LINUX},AProgresso{$ENDIF});

        Result := ConsultaBoletosCanceladosPorPeriodo(ADataInicial,
                                                      ADataFinal,
                                                      Result,
                                                      LBeneficiario
                                                      {$IFNDEF LINUX},AProgresso{$ENDIF});

        LMaximoProgresso := Result.Count - LMaximoProgresso;

       {$IFNDEF LINUX}
        AProgresso.pgbStatus.Properties.Max := LMaximoProgresso;
       {$ENDIF}

        ConsultaBoletosPorNossoNumeroLista(Result, LBeneficiario{$IFNDEF LINUX}, AProgresso{$ENDIF});
      Except
        On E: Exception Do
        Begin
          If E.Message.ToLowerInvariant.Contains('is not authorized to access this resource with an explicit deny') Then
          Begin
            fMensagem('ATENÇÃO', 'O beneficiário com o número ' + LBeneficiario + ' não possui ' +
                                 'permissão para utilizar a nova forma de consulta.' + #13 +
                                 'Para realizar a liberação, é necessário ir ao Bankline do Itaú e realizar o ' +
                                 'consentimento de uma chave Pix da conta para utilização do Autcom.', ['&Ok']);

            Continue;
          End;

          Raise Exception.Create(RetornaTextoErro('', E.Message));
        End;
      End;
    End;
  Finally
    FreeAndNil(LListaBeneficiarios);
  End;
end;

function TBancoItauAPI.ConsultaBoletosPorPeriodo(ADataInicial,
                                       ADataFinal: TDateTime
                                       {$IFNDEF LINUX}; var AProgresso: TfrmGravando{$ENDIF}): TList<TRetornoPesquisaBancoItauAPI>;
  Var
    LLinkConsulta,
    LResposta,
    LCaptionTela: String;

    LStatus,
    LContadorErro429: Integer;

    LParametros: TStringList;

    LDadosRetorno: TRetornoPesquisaBancoItauAPI;
begin
  If FUtilizarNovaAPIConsulta Then
    Exit(NovaConsultaBoletos(ADataInicial,
                             ADataFinal
                             {$IFNDEF LINUX},AProgresso{$ENDIF}));

  Result := TList<TRetornoPesquisaBancoItauAPI>.Create;

  LParametros := TStringList.Create;

  If Not Assigned(FConsultaBoletosGerados) Then
  Begin
    FConsultaBoletosGerados := RetonaDuplicatasBoletoGerado(FDadosCarteira.CarteiraCompleta,
                                                            ADataInicial,
                                                            ADataFinal);

    FConsultaBoletosGerados.First;

   {$IFNDEF LINUX}
    AProgresso.pgbStatus.Position := 0;
    AProgresso.pgbStatus.Properties.Max := FConsultaBoletosGerados.RecordCount;
   {$ENDIF}
  End;

  Try
    LContadorErro429 := 0;

    While Not FConsultaBoletosGerados.Eof Do
    Begin
      LLinkConsulta := FDadosCarteira.LinkConsultaEspecifico.Replace('[BENEFICIARIO]', RetornaIDBeneficiario)
                                                            .Replace('[CARTEIRA]', FDadosCarteira.CodCarteira)
                                                            .Replace('[NOSSO_NUMERO]', FConsultaBoletosGerados.FieldByName('CTR_NOSNUM').AsString
                                                                                                           .Remove(FConsultaBoletosGerados.FieldByName('CTR_NOSNUM').AsString.Length -1));
     Try
      GerarToken;

      LParametros.Clear;
      LParametros.Add('Authorization: ' + FTokenUsoAtual);
      LParametros.Add('x-itau-apikey: ' + FDadosCarteira.ClientId);
      LParametros.Add('x-itau-correlationID: 1');
      LParametros.Add('x-itau-flowID: 2');

      FRestSynalist.StatusSemRaise := [429];

      LStatus := FRestSynalist.ExecuteRestSynalist('GET',
                                                   LLinkConsulta,
                                                   LParametros,
                                                   LResposta);

      If Not MatchStr(LStatus.ToString, ['200', '201']) Then
      Begin
        If LStatus <> 429 Then
          Raise Exception.Create(LResposta);

        If LContadorErro429 <= 5 Then
        Begin
          Inc(LContadorErro429);

         {$IFDEF LINUX}
          pMensagemOk('Erro de limitação na API do Banco Itaú. Nova tentativa em 75 segundos.');
          Aguarde(75000);
         {$ELSE}
          LCaptionTela := AProgresso.lblGravando.Caption;

          AProgresso.lblGravando.Caption := 'Erro de limitação na API do Banco Itaú. Nova tentativa em 75 segundos.';
          Aguarde(75000);

          AProgresso.lblGravando.Caption := LCaptionTela;
          Application.ProcessMessages;
         {$ENDIF}

          Continue;
        End;

        Raise Exception.Create(LResposta);
      End;

      LDadosRetorno := RetornaDadosPesquisaBoleto(LResposta);

      If BoletoTransferidoParaContaVinculada(LDadosRetorno) Then
        LDadosRetorno := ConsultaBoletoContaVinculada(FConsultaBoletosGerados,
                                                      LDadosRetorno,
                                                      LStatus,
                                                      LContadorErro429
                                                      {$IFNDEF LINUX}, AProgresso{$ENDIF});

      If FConsultaBoletosGerados.FieldByName('CTR_DTAENV').AsDateTime = VS_Date Then
      Begin
        If LDadosRetorno.LinhaDigitavel.IsEmpty Then
        Begin
         {$IFNDEF LINUX}
          pStep(AProgresso.pgbStatus);
         {$ENDIF}

          FConsultaBoletosGerados.Next;

          Continue;
        End;
      End;

      If Concat(LDadosRetorno.DataEmissao, LDadosRetorno.NossoNumero).IsEmpty Then
      Begin
       {$IFNDEF LINUX}
        pStep(AProgresso.pgbStatus);
       {$ENDIF}

        FConsultaBoletosGerados.Next;

        Continue;
      End;

      LDadosRetorno.NomeDoArquivo := Concat(FormatDateTime('dd/mm/yyyy', ADataInicial),
                                            ' - ',
                                            FormatDateTime('dd/mm/yyyy', ADataFinal));

      LDadosRetorno.TxIdPix := FConsultaBoletosGerados.FieldByName('CTR_TX_BOL').AsString;
      If Not LDadosRetorno.TxIdPix.IsEmpty Then
        ConsultaDadosPixBoleto(LDadosRetorno,
                               FConsultaBoletosGerados.FieldByName('CTR_TX_BOL').AsString);

      CorrigeDatas(LDadosRetorno.DataEmissao);
      CorrigeDatas(LDadosRetorno.DataVencimento);
      CorrigeDatas(LDadosRetorno.DataPagamento);
      CorrigeDatas(LDadosRetorno.DataBaixaAlteracao);

      LDadosRetorno.DataCredito := RetornaDataParaCredito(LDadosRetorno.DataPagamento,
                                                          LDadosRetorno.PagoPorPix);

      If DeveAdicionarDuplicataEmAberto(IIF(Not LDadosRetorno.SituacaoBoletoCodigo.Equals('32'),
                                            LDadosRetorno.DataPagamento,
                                            LDadosRetorno.DataBaixaAlteracao),
                                            FConsultaBoletosGerados.FieldByName('CTR_DTAENV').AsString,
                                            ADataInicial,
                                            ADataFinal) Then
        Result.Add(LDadosRetorno);

     {$IFNDEF LINUX}
      pStep(AProgresso.pgbStatus);
     {$ENDIF}

      FConsultaBoletosGerados.Next;

     Except
        On E: Exception Do
          Raise Exception.Create(RetornaTextoErro('', E.Message));
     End;
    End;

  Finally
    FreeAndNil(LParametros);

    FRestSynalist.StatusSemRaise := [];
  End;

  FConsultaBoletosGerados.Close;

  FreeAndNil(FConsultaBoletosGerados);
end;


procedure TBancoItauAPI.ConsultaDadosPixBoleto(
  var ADadosBoletoRetorno: TRetornoPesquisaBancoItauAPI; ATxIdBoleto: String = '');
  Var
    LLinkConsulta,
    LResposta,
    LTxIdBoleto: String;

    LStatus: Integer;

    LParametros: TStringList;

    LJsonObject,
    LComponentesValor: TJsonObject;

    LJsonValue: TJsonValue;

    LJsonArray: TJsonArray;
begin
  LTxIdBoleto := ATxIdBoleto;

  If LTxIdBoleto.IsEmpty Then
  Begin
    If Not MatchStr(ADadosBoletoRetorno.DescricaoInstrumentoCobranca.ToLowerInvariant, ['boleto_pix', 'bolecode']) Then
      Exit;

    LTxIdBoleto := fCampotabela('CTR_TX_BOL', 'CADREC', ['CTR_BCOBOL', 'CTR_ID_BOL'], ['341', ADadosBoletoRetorno.IDBoleto]);

    If LTxIdBoleto.IsEmpty THen
      Exit;
  End;

  LLinkConsulta := FDadosCarteira.LinkConsultaPix.Replace('[TXID]', LTxIdBoleto);

  GerarToken;

  LParametros := TStringList.Create;
  LParametros.Clear;
  LParametros.Add('Authorization: ' + FTokenUsoAtual);

  FRestSynalist.StatusSemRaise := [404];

  LStatus := FRestSynalist.ExecuteRestSynalist('GET',
                                               LLinkConsulta,
                                               LParametros,
                                               LResposta);

  FreeAndNil(LParametros);

  If MatchStr(LStatus.ToString, ['404']) Then
    Exit;

  If Not MatchStr(LStatus.ToString, ['200', '201']) Then
    Raise Exception.Create('Ocorreu um erro ao consultar o Pix do boleto.' + #13 +
                           'Erro gerado: ' + LResposta);

  LJsonObject := TJsonObject.ParseJSONValue(LResposta) As TJsonObject;
  Try
    If LJsonObject.GetValue<String>('status') = 'CONCLUIDA' Then
    Begin
      LJsonArray := TJsonObject.ParseJSONValue(LJsonObject.GetValue('pix').ToJSON) as TJSONArray;

      For LJsonValue In LJsonArray Do
      Begin
        ADadosBoletoRetorno.SituacaoBoletoCodigo := '06';

        ADadosBoletoRetorno.ValorPago := RetornaValorJsonValue(LJsonValue, 'valor');
        ADadosBoletoRetorno.DataPagamento := RetornaValorJsonValue(LJsonValue, 'horario');
        ADadosBoletoRetorno.EndToEndId := RetornaValorJsonValue(LJsonValue, 'endToEndId');
        ADadosBoletoRetorno.PagoPorPix := True;

        LComponentesValor := LJsonValue.GetValue<TJsonObject>('componentesValor');
        If LComponentesValor.GetValue('desconto') <> Nil Then
          ADadosBoletoRetorno.ValorDesconto := (LComponentesValor.GetValue('desconto') As TJsonObject).GetValue<String>('valor');

        If LComponentesValor.GetValue('multa') <> Nil Then
          ADadosBoletoRetorno.ValorMulta := (LComponentesValor.GetValue('multa') As TJsonObject).GetValue<String>('valor');

        If LComponentesValor.GetValue('juros') <> Nil Then
          ADadosBoletoRetorno.ValorJuros := (LComponentesValor.GetValue('juros') As TJsonObject).GetValue<String>('valor');
      End;
    End;
  Finally
    FreeAndNil(LJsonObject);
  End;
end;

procedure TBancoItauAPI.CorrigeDatas(var AValorDuplicata: String);
  Var
    LValorData: TDateTime;
begin
  If AValorDuplicata.IsEmpty Then
    Exit;

  If TryStrToDateTime(Concat(AValorDuplicata.Substring(8, 2), '/',
                             AValorDuplicata.Substring(5, 2), '/',
                             AValorDuplicata.Substring(0, 4)),
                      LValorData) Then
    AValorDuplicata := DateToStr(LValorData);
end;

constructor TBancoItauAPI.Create(ACarteira: String);
begin
  FPastaAutcom := ExtractFilePath(Application.ExeName).Replace('autban\', EMptyStr)
                                                      .Replace('Autban\', EMptyStr)
                                                      .Replace('AUTBAN\', EMptyStr);

  CriarComponenteRequisicao;
  CarregaDadosCarteira(ACarteira);
  FListaRequisicaoRegistroBoleto := TList<TRequisicaoRegistroBoleto>.Create;
  FRetornoBancoItauAPI := TRetornoBoletoItau.Create;

  FUtilizarNovaAPIConsulta := fCfgSis('ITAUVN', varBoolean);

  CarregaLinksTabela;
end;

procedure TBancoItauAPI.CriarComponenteRequisicao;
begin
  FRestSynalist := TRestSynalistAutban.Create;
end;

function TBancoItauAPI.DadosDoBoletoPertencemADuplicata(ARetornoPost: String;
  ADadosDuplicata, ADadosCliente: TDataset): Boolean;
  Var
    LJsonRetorno,
    LJsonDadosBoleto,
    LJsonPagador: TJSONObject;

    LJsonArray: TJsonArray;

    LJsonValue: TJsonValue;

    LDocumento: String;
begin
  Result := True;

  Try
    LJsonRetorno := TJSONObject.ParseJSONValue(ARetornoPost) as TJSONObject;
    LJsonRetorno := TJSONObject.ParseJSONValue(LJsonRetorno.GetValue('data').ToString) as TJSONObject;

    Try
      LJsonDadosBoleto := TJSONObject.ParseJSONValue(LJsonRetorno.GetValue('dado_boleto').ToString) as TJSONObject;

      If fFormataFloat(RetornaValorImportacaoDouble(RetornaValorJson(LJsonDadosBoleto, 'valor_total_titulo')), 2) <>
         fFormataFloat(RetornaValorDuplicata(ADadosDuplicata), 2) Then
        Exit(False);

      If Not RetornaValorJson(LJsonDadosBoleto, 'data_emissao').Equals(FormatDateTime('yyyy-mm-dd', ADadosDuplicata.FieldByName('CTR_DTACAD').AsDateTime)) Then
        Exit(False);

      LJsonPagador := TJSONObject.ParseJSONValue(LJsonDadosBoleto.GetValue('pagador').ToString) as TJSONObject;
      LJsonPagador := TJSONObject.ParseJSONValue(LJsonPagador.GetValue('pessoa').ToString) as TJSONObject;
      LJsonPagador := TJSONObject.ParseJSONValue(LJsonPagador.GetValue('tipo_pessoa').ToString) as TJSONObject;

      LDocumento := RetornaValorJson(LJsonPagador, 'numero_cadastro_nacional_pessoa_juridica');
      If LDocumento.IsEmpty Then
        LDocumento := RetornaValorJson(LJsonPagador, 'numero_cadastro_pessoa_fisica');

      If Not LDocumento.Equals(fTiraCaracEspeciaisPonto(ADadosCliente.FieldByName('CLI_C_G_C_').AsString)) Then
        Exit(False);

      LJsonArray := LJsonDadosBoleto.GetValue('dados_individuais_boleto') as TJsonArray;

      For LJsonValue In LJsonArray Do
      Begin
        If Not RetornaValorJsonValue(LJsonValue, 'texto_seu_numero').Equals(RightStr(ADadosDuplicata.FieldByName('CTR_NUMDUP').AsString +
                                                                                     ADadosDuplicata.FieldByName('CTR_PARCEL').AsString, 10)) Then
          Exit(False);

        Break;
      End;
    Finally
      FreeAndNil(LJsonRetorno);
    End;
  Except
    Raise;
  End;
end;

destructor TBancoItauAPI.Destroy;
begin
  GravarDadosRequisicaoRegistroBoleto;

  If Assigned(FListaRequisicaoRegistroBoleto) Then
  FreeAndNil(FListaRequisicaoRegistroBoleto);

  If Assigned(FRetornoBancoItauAPI) Then
  FreeAndNil(FRetornoBancoItauAPI);

  If Assigned(FRestSynalist) Then
  FreeAndNil(FRestSynalist);
  inherited;
end;


function TBancoItauAPI.DeveAdicionarDuplicataEmAberto(ADataPagamento,
  ADataEmissao: String; ADataInicial, ADataFinal: TDateTime): Boolean;
begin
  Result := DateTimeInRange(StrToDateTime(ADataEmissao),
                            ADataInicial,
                            ADataFinal);

  If Not ADataPagamento.IsEmpty Then
  Begin
    Result := DateTimeInRange(StrToDateTime(ADataPagamento),
                              ADataInicial,
                              ADataFinal);

    If Not Result Then
      Result := DateTimeInRange(fAcertaDataParaDiaUtil(StrToDateTime(ADataPagamento)),
                                ADataInicial,
                                ADataFinal);
  End;
end;

function TBancoItauAPI.DeveLimparOsDadosDoBoletoCancelamento(AStatus: Integer;
  ARetorno, ATxIdBoleto: String): Boolean;
  Var
    LJsonObject: TJsonObject;

    LJsonArray: TJsonArray;

    LJsonValue: TJsonValue;

    LDadosRetorno: TRetornoPesquisaBancoItauAPI;
begin
  Result := MatchStr(AStatus.ToString, ['201', '204']);

  If Result Then
    Exit;

  If AStatus = 422 Then
  Begin
    Try
      LJsonObject := TJsonObject.ParseJSONValue(ARetorno) as TJsonObject;

      Try
        LJsonArray := LJsonObject.GetValue<TJsonArray>('campos');

        For LJsonValue In LJsonArray Do
        Begin
          If RetornaValorJsonValue(LJsonValue, 'campo').Equals('situacaoGeral') Then
          Begin
            If MatchStr(RetornaValorJsonValue(LJsonValue, 'valor'), ['BAIXADO']) Then
            Begin
              If ATxIdBoleto.IsEmpty Then
                Exit(True)
              Else
              Begin
                LDadosRetorno := TRetornoPesquisaBancoItauAPI.Create;
                ConsultaDadosPixBoleto(LDadosRetorno, ATxIdBoleto);

                Exit(Not LDadosRetorno.SituacaoBoletoCodigo.Equals('06'));
              End;
            End;
          End;
        End;
      Finally
        FreeAndNil(LJsonObject);
      End;
    Except
      Result := False;
    End;
  End;
end;

procedure TBancoItauAPI.GerarToken;
  Var
    LDadosEnvio: String;

    LParametros: TStringList;
begin
  LParametros := TStringList.Create;
  
  LDadosEnvio := 'grant_type=client_credentials&' +
                 'client_id=' + FDadosCarteira.ClientId + '&' +
                 'client_secret=' + FDadosCarteira.ClientSecret;

  Try
    Try
      FTokenUsoAtual := 'Bearer ' + FRestSynalist.GetToken('POST',
                                                           FDadosCarteira.LinkTokenAPI,
                                                           LParametros,
                                                           FDadosCarteira.CarteiraCompleta,
                                                           LDadosEnvio,
                                                           'application/x-www-form-urlencoded');
    Except
      On E: Exception Do
        Raise Exception.Create('Ocorreu um erro ao realizar a autenticação na API do Banco.' + #13 +
                               'Erro gerado: ' + E.Message);
    End;
  Finally
    FreeAndNil(LParametros);
  End;
end;

procedure TBancoItauAPI.GravarDadosRequisicaoRegistroBoleto;
  Var
    LRequisicaoRegistroBoleto : TRequisicaoRegistroBoleto;
begin
  If Assigned(FListaRequisicaoRegistroBoleto) Then
  Begin
    If FListaRequisicaoRegistroBoleto.Count > 0 Then
    Begin
      // GRAVA DADOS DAS REQUISIÇÕES
      For LRequisicaoRegistroBoleto In FListaRequisicaoRegistroBoleto Do
        TRegBol.GravarRequisicaoReqistroBoleto(LRequisicaoRegistroBoleto);
    End;

    FListaRequisicaoRegistroBoleto.Clear;
  End;
end;

function TBancoItauAPI.NossoNumeroDuplicado(AErro: String; AStatus: Integer): Boolean;
begin
  Result := AErro.ToUpperInvariant.Contains('TÍTULO JÁ CADASTRADO NA COBRANÇA');

  If Not Result Then
    Result := AErro.ToUpperInvariant.Contains('COBRANCA HIBRIDA COM ID DE BOLETO OU TXID JA EXISTENTE');

  If Not Result Then
    Result := AErro.ToUpperInvariant.Contains('COBRANCA HÍBRIDA COM ID DE BOLETO OU TXID JÁ EXISTENTE NA BASE DE DADOS.');

  If Not Result Then
    Result := AErro.ToUpperInvariant.Contains('NOSSO NÚMERO JÁ REGISTRADO');

  If Not Result Then
    Result := AStatus = 255;
end;

procedure TBancoItauAPI.ReimpressaoDeBoleto(AAutoIncrem: String);
  Var
    LJsonRetorno,
    LDadosBoleto,
    LJsonObjectGroup: TJsonObject;

    LJsonValue: TJsonValue;

    LJsonRegistro: String;
    LCadRec: TUniQuery;
begin
  LJsonRetorno := Nil;
  LDadosBoleto := Nil;
  LCadRec := Nil;

  Try
    FRetornoBancoItauAPI := TRetornoBoletoItau.Create;
    Try
      LJsonRegistro := TFuncoesPixBoleto.RetornaJsonRegistroBoleto(AAutoIncrem, '341');

      If fEmptyStr(LJsonRegistro) Then
      Begin

        LCadRec := fCriaQuery(Nil);
        LCadRec.Close;
        LCadRec.SQL.Clear;
        LCadRec.SQL.Add('SELECT CTR_NOSNUM, CTR_TX_BOL, CTR_QRCODE, CTR_LINDIG ' +
                        'FROM CADREC WHERE AUTOINCREM = :AUTOINC');

        LCadRec.ParamByName('AUTOINC').AsString := AAutoIncrem;
        LCadRec.Open;

        FRetornoBancoItauAPI.nossoNumero               := LCadRec.FieldByName('CTR_NOSNUM').AsString;
        FRetornoBancoItauAPI.QrCodeTxId                := LCadRec.FieldByName('CTR_TX_BOL').AsString;
        FRetornoBancoItauAPI.QrCodeEmv                 := LCadRec.FieldByName('CTR_QRCODE').AsString;
        FRetornoBancoItauAPI.linhaDigitavel            := LCadRec.FieldByName('CTR_LINDIG').AsString;
        FRetornoBancoItauAPI.codigoDeBarras            := Copy(FRetornoBancoItauAPI.linhaDigitavel, 01, 04) +
                                                              Copy(FRetornoBancoItauAPI.linhaDigitavel, 33, 15) +
                                                              Copy(FRetornoBancoItauAPI.linhaDigitavel, 05, 05) +
                                                              Copy(FRetornoBancoItauAPI.linhaDigitavel, 11, 08) +
                                                              Copy(FRetornoBancoItauAPI.linhaDigitavel, 19, 02) +
                                                              Copy(FRetornoBancoItauAPI.linhaDigitavel, 22, 10);

        Exit;
      End;

      LJsonRetorno := TJSONObject.ParseJSONValue(LJsonRegistro) as TJSONObject;

      LJsonRetorno := TJSONObject.ParseJSONValue(LJsonRetorno.GetValue('data').ToString) as TJSONObject;

      LDadosBoleto := TJSONObject.ParseJSONValue(LJsonRetorno.GetValue('dado_boleto').ToString) as TJSONObject;

      For LJsonValue In LDadosBoleto.GetValue('dados_individuais_boleto') as TJsonArray Do
      Begin
        FRetornoBancoItauAPI.nossoNumero    := Concat(LJsonValue.GetValue<String>('numero_nosso_numero'),
                                                      LJsonValue.GetValue<String>('dac_titulo'));
        FRetornoBancoItauAPI.linhaDigitavel := LJsonValue.GetValue<String>('numero_linha_digitavel');;
        FRetornoBancoItauAPI.codigoDeBarras := LJsonValue.GetValue<String>('codigo_barras');;
      End;

      {QrCode}
      LJsonObjectGroup := LJsonRetorno.GetValue('dados_qrcode') as TJSONObject;
      If Assigned(LJsonObjectGroup) Then
      Begin
        FRetornoBancoItauAPI.QrCodeUrl  :=  RetornaValorJson(LJsonObjectGroup,'location');
        FRetornoBancoItauAPI.QrCodeTxId :=  RetornaValorJson(LJsonObjectGroup,'txid');
        FRetornoBancoItauAPI.QrCodeEmv  :=  RetornaValorJson(LJsonObjectGroup,'emv');
      End;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    If Assigned(LJsonRetorno) Then
      FreeAndNil(LJsonRetorno);

    If Assigned(LDadosBoleto) Then
      FreeAndNil(LDadosBoleto);

    If Assigned(LCadRec) Then
      FreeAndNil(LCadRec);
  End;
end;

function TBancoItauAPI.RetonaDuplicatasBoletoGerado(
  ACarteira: String; ADataInicial, ADataFinal: TDateTime): TUniClientDataSet;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;
  Try
    LConsulta.SQL.Text := 'SELECT AUTOINCREM, ' +
                          '  CTR_NUMDUP, ' +
                          '  CTR_PARCEL, ' +
                          '  CTR_ESPDOC, ' +
                          '  CTR_CODEMP, ' +
                          '  CTR_CODCLI, ' +
                          '  CTR_CARTEI, ' +
                          '  CTR_NOSNUM, ' +
                          '  CTR_DTACAD, ' +
                          '  CTR_DTAENV, ' +
                          '  CTR_DTAVEN, ' +
                          '  CTR_VALDUP, ' +
                          '  CTR_DTAENV, ' +
                          '  CTR_TX_BOL  ' +
                          'FROM CADREC ' +
                          'WHERE CTR_DTAREC IS NULL ' +
                          '  AND CTR_BCOBOL="341" ' +
                          '  AND CTR_CARTEI=:CARTEI ' +
                          '  AND CTR_DTAENV<=:DTAENV ' +
                          '  AND (CTR_ID_BOL IS NOT NULL ' +
                          '  AND CTR_ID_BOL<>"") ' +

                          'UNION ' +

                          'SELECT AUTOINCREM, ' +
                          '  CTR_NUMDUP, ' +
                          '  CTR_PARCEL, ' +
                          '  CTR_ESPDOC, ' +
                          '  CTR_CODEMP, ' +
                          '  CTR_CODCLI, ' +
                          '  CTR_CARTEI, ' +
                          '  CTR_NOSNUM, ' +
                          '  CTR_DTACAD, ' +
                          '  CTR_DTAENV, ' +
                          '  CTR_DTAVEN, ' +
                          '  CTR_VALDUP, ' +
                          '  CTR_DTAENV, ' +
                          '  CTR_TX_BOL  ' +
                          'FROM CADREC ' +
                          'WHERE CTR_DTAREC BETWEEN :DTAINI AND :DTAFIM ' +
                          '  AND CTR_BCOBOL="341" ' +
                          '  AND CTR_CARTEI=:CARTEI ' +
                          '  AND CTR_SEQBAI=0 ' +
                          '  AND (CTR_ID_BOL IS NOT NULL ' +
                          '  AND CTR_ID_BOL<>"") ' +

                          'ORDER BY CTR_DTAVEN';

    LConsulta.ParamByName('CARTEI').AsString := ACarteira;
    LConsulta.ParamByName('DTAENV').AsDateTime := ADataFinal;
    LConsulta.ParamByName('DTAINI').AsDateTime := ADataInicial;
    LConsulta.ParamByName('DTAFIM').AsDateTime := ADataFinal;

    LConsulta.Open;

    Result := fCriaClientDatSet(LConsulta);
  Finally
    FreeAndNil(LConsulta);
  End;
end;

function TBancoItauAPI.RetornaAcoesPermitidas: TJsonObject;
begin
  Result := TJsonObject.Create;

  Result.AddPair('emitir_segunda_via', 'true');
  Result.AddPair('comandar_instrucao_alterar_dados_cobranca', 'true');
end;

function TBancoItauAPI.RetornaBeneficiario: TJsonObject;
  Var
    LJsonTipoPessoa,
    LJsonEndereco: TJsonObject;

begin
  Result := TJSONObject.Create;
  Result.AddPair('id_beneficiario'       , RetornaIDBeneficiario);

  If FDadosCarteira.UsaSacadorAvalista.Equals('N') Then
    Exit;

  LJsonTipoPessoa := TJsoNObject.Create;
  LJsonEndereco := TJsoNObject.Create;

  LJsonTipoPessoa.AddPair('codigo_tipo_pessoa', 'J');

  Result.AddPair('nome_cobranca', RetornaValorString(FDadosCarteira.NomeBeneficiario, 50));

  LJsonTipoPessoa.AddPair('numero_cadastro_nacional_pessoa_juridica', fTiraCaracEspeciaisPonto(FDadosCarteira.CNPJBeneficiario));
  Result.AddPair('tipo_pessoa', LJsonTipoPessoa);

  LJsonEndereco.AddPair('nome_logradouro', RetornaValorString(FDadosCarteira.EnderecoBeneficiario, 45));
  LJsonEndereco.AddPair('nome_bairro', RetornaValorString(FDadosCarteira.BairroBeneficiario, 15));
  LJsonEndereco.AddPair('nome_cidade', RetornaValorString(FDadosCarteira.CidadeBeneficiario, 20));
  LJsonEndereco.AddPair('sigla_UF', RetornaValorString(FDadosCarteira.UFBeneficiario, 2));
  LJsonEndereco.AddPair('numero_CEP', fRetSomenteNumeros(FDadosCarteira.CEPBeneficiario));
  Result.AddPair('endereco', LJsonEndereco);
end;

function TBancoItauAPI.RetornaChaveDuplicata(ADadosDuplicata: TDataset): String;
begin
  Result := fPadR(ADadosDuplicata.FieldByName('CTR_NUMDUP').AsString, 12) +
            fPadR(ADadosDuplicata.FieldByName('CTR_PARCEL').AsString, 03) +
            fPadR(ADadosDuplicata.FieldByName('CTR_ESPDOC').AsString, 02) +
            fPadR(ADadosDuplicata.FieldByName('CTR_CODEMP').AsString, 03);
end;

function TBancoItauAPI.RetornaDadosBoleto(ADadosDuplicata, ADadosCliente: TDataset;
  ANosNum: String): TJsonObject;
  Var
    LDescontos: TJsonArray;
begin
  Result := TJSONObject.Create;
  Result.AddPair('codigo_carteira'            , FDadosCarteira.CodCarteira);
  Result.AddPair('valor_total_titulo'         , fValNumForm(RetornaValorDuplicata(ADadosDuplicata),17));
  Result.AddPair('codigo_especie'             , '01');
  Result.AddPair('data_emissao'               , FormatDateTime('yyyy-mm-dd', ADadosDuplicata.FieldByName('CTR_DTACAD').AsDateTime));

  Result.AddPair('instrucao_cobranca'         , RetornaInstrucaoCobranca);

  Result.AddPair('pagador'                    , RetornaPagador(ADadosCliente));

  If FDadosCarteira.UsaSacadorAvalista = 'S' Then
    Result.AddPair('sacador_avalista'         , RetornaSacadorAvalista);

  Result.AddPair('dados_individuais_boleto'   , RetornaDadosBoletoIndividuais(ADadosDuplicata, ANosNum));

  Result.AddPair('juros'                      , RetornaJurosMora(ADadosDuplicata));
  Result.AddPair('multa'                      , RetornaMulta(ADadosDuplicata));

  LDescontos := RetornaDescontos(ADadosDuplicata);
  If LDescontos <> Nil Then
    Result.AddPair('desconto'                   , RetornaDesconto(LDescontos));

  If FDadosCarteira.GerarQRCodePix.Equals('S') Then
    Result.AddPair('lista_mensagem_cobranca'    , RetornaObservacoes)
  Else
    Result.AddPair('desconto_expresso', 'false');
end;

function TBancoItauAPI.RetornaDadosBoletoIndividuais(ADadosDuplicata: TDataset;ANosNum: String): TJsonArray;
  Var
    LDataLimitePagamento: TDateTime;

    LJsonObject: TJsonObject;
begin
  Result := TJsonArray.Create;
  LJsonObject := TJsonObject.Create;

  LJsonObject.AddPair('numero_nosso_numero'     , ANosNum);
  LJsonObject.AddPair('data_vencimento'         , FormatDateTime('yyyy-mm-dd',ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime));
  LJsonObject.AddPair('valor_titulo'            , fValNumForm(RetornaValorDuplicata(ADadosDuplicata),17));

  LDataLimitePagamento := IncDay(ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime, StrToIntDef(FDadosCarteira.QtdDiasLimitePagto,0));

  If (LDataLimitePagamento > ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime) Then
    LJsonObject.AddPair('data_limite_pagamento' , FormatDateTime('yyyy-mm-dd',LDataLimitePagamento));

  LJsonObject.AddPair('texto_uso_beneficiario'  , RetornaChaveDuplicata(ADadosDuplicata));

  LJsonObject.AddPair('texto_seu_numero', RightStr(ADadosDuplicata.FieldByName('CTR_NUMDUP').AsString +
                                                   ADadosDuplicata.FieldByName('CTR_PARCEL').AsString, 10));

  If FDadosCarteira.GerarQRCodePix.Equals('N') Then
    LJsonObject.AddPair('mensagens_cobranca'    , RetornaObservacoes);

  Result.AddElement(LJsonObject);
end;

function TBancoItauAPI.RetornaDadosDaRequisicao(ADadosDuplicata,ADadosCliente: TDataset; ANosNum: String): String;
  Var
    LJSONBoleto,

    LJsonBoletoSemQRCode: TJSONObject;
begin
  LJSONBoleto := TJsonObject.Create;

  Try
    //LJSONBoleto.AddPair('etapa_processo_boleto'   , IIF(FDadosCarteira.GerarQRCodePix.Equals('S'), 'simulacao', 'validacao'));
    LJSONBoleto.AddPair('etapa_processo_boleto'   , 'efetivacao');
    LJSONBoleto.AddPair('beneficiario'            , RetornaBeneficiario);
    LJSONBoleto.AddPair('dado_boleto'             , RetornaDadosBoleto(ADadosDuplicata, ADadosCliente, ANosNum));

    If FDadosCarteira.GerarQRCodePix.Equals('S') Then
      LJSONBoleto.AddPair('dados_qrcode'          , RetornaDadosQRCode);

    LJSONBoleto.AddPair('acoes_permitidas'        , RetornaAcoesPermitidas);

    If Not FDadosCarteira.GerarQRCodePix.Equals('S') Then
    Begin
      LJsonBoletoSemQRCode := TJSONObject.Create;
      LJsonBoletoSemQRCode.AddPair('data', LJSONBoleto);
      Result := PrettyJSON(LJsonBoletoSemQRCode.ToString);
    End
    Else
      Result := PrettyJSON(LJSONBoleto.ToString);
  Finally
    FreeAndNil(LJSONBoleto);
  End;
end;

function TBancoItauAPI.RetornaDadosPesquisaBoleto(
  ADadosRetorno: String): TRetornoPesquisaBancoItauAPI;
  Var
    LJSONRetorno,
    LJsonExtracao,
    LJsonObjectBaixada: TJSONObject;

    LJsonArray,
    LJsonArrayInterno,
    LJsonArrayHistorico: TJsonArray;

    LJsonValueBoleto: TJsonValue;
begin
  Result := TRetornoPesquisaBancoItauAPI.Create;

  If ADadosRetorno.IsEmpty Then
    Exit;

  LJSONRetorno := TJSONObject.ParseJSONValue(ADadosRetorno) as TJSONObject;

  Try
    LJSONArray := LJsonRetorno.GetValue('data') As TJsonArray;

    For LJsonValueBoleto In LJSONArray Do
    Begin
      Result.IDBoleto := RetornaValorJsonValue(LJsonValueBoleto, 'id_boleto');

      LJsonExtracao := LJsonValueBoleto.GetValue<TJsonObject>('dado_boleto');

      Result.DescricaoInstrumentoCobranca := RetornaValorJson(LJsonExtracao, 'descricao_instrumento_cobranca');
      Result.SeuNumero := RetornaValorJson(LJsonExtracao, 'texto_uso_beneficiario');

      Result.DataEmissao := RetornaValorJsonValue(LJsonValueBoleto, 'data_emissao');
      If Result.DataEmissao.IsEmpty Then
        Result.DataEmissao := RetornaValorJson(LJsonExtracao, 'data_emissao');

      LJsonArrayInterno := LJsonExtracao.GetValue('dados_individuais_boleto') As TJsonArray;

      Result.SituacaoBoleto := RetornaValorJsonValue(LJsonArrayInterno.Items[0], 'situacao_geral_boleto');
      Result.StatusVencimento := RetornaValorJsonValue(LJsonArrayInterno.Items[0], 'status_vencimento');
      Result.NossoNumero := RetornaValorJsonValue(LJsonArrayInterno.Items[0], 'numero_nosso_numero') +
                            RetornaValorJsonValue(LJsonArrayInterno.Items[0], 'dac_titulo');
      Result.DataVencimento := RetornaValorJsonValue(LJsonArrayInterno.Items[0], 'data_vencimento');
      Result.ValorTitulo := RetornaValorJsonValue(LJsonArrayInterno.Items[0], 'valor_titulo');
      Result.CodigoBarras := RetornaValorJsonValue(LJsonArrayInterno.Items[0], 'codigo_barras');
      Result.LinhaDigitavel := RetornaValorJsonValue(LJsonArrayInterno.Items[0], 'numero_linha_digitavel');

      Result.NossoNumero := fStrZero(Result.NossoNumero, 9);

      If LJsonExtracao.GetValue('historico') <> Nil Then
        Result.Historicos := LJsonExtracao.GetValue('historico').ToJSON;

      Result.SituacaoBoletoCodigo := '02';
      If LJsonExtracao.GetValue('pagamentos_cobranca') <> Nil Then
      Begin
        LJsonArrayInterno := LJsonExtracao.GetValue('pagamentos_cobranca') As TJsonArray;

        Result.DataPagamento := RetornaValorJsonValue(LJsonArrayInterno.Items[0], 'data_inclusao_pagamento');
        Result.ValorPago := RetornaValorJsonValue(LJsonArrayInterno.Items[0], 'valor_pago_total_cobranca');

        Result.ValorDesconto := RetornaValorJsonValue(LJsonArrayInterno.Items[0], 'valor_pago_desconto_cobranca');
        Result.ValorMulta := RetornaValorJsonValue(LJsonArrayInterno.Items[0], 'valor_pago_multa_cobranca');
        Result.ValorJuros := RetornaValorJsonValue(LJsonArrayInterno.Items[0], 'valor_pago_juro_cobranca');

        Result.SituacaoBoletoCodigo := '06';
      End
      Else If Result.SituacaoBoleto.Equals('Baixada') Then
      Begin
        If LJsonExtracao.GetValue('baixa') <> Nil Then
        Begin
          LJsonObjectBaixada := LJsonExtracao.GetValue('baixa') As TJsonObject;
          Result.PagoPorPix := RetornaValorJson(LJsonObjectBaixada, 'motivo_baixa').Contains('Baixa por ter sido liquidado');
          If Result.PagoPorPix Then
          Begin
            Result.SituacaoBoletoCodigo := '06';
            Result.DataPagamento := RetornaValorJson(LJsonObjectBaixada, 'data_inclusao_alteracao_baixa');
          End;
        End;
      End
      Else
      Begin
        If LJsonExtracao.GetValue('historico') <> Nil Then
        Begin
          LJsonArrayHistorico := LJsonExtracao.GetValue('historico') As TJsonArray;
          If MatchStr(RetornaValorJsonValue(LJsonArrayHistorico.Items[0], 'operacao').ToUpperInvariant,
                      ['TITULO ENVIADO AO CARTORIO', 'ENTRADA EM CARTORIO CONFIRMADA PROTOCOLO GERADO']) Then
          Begin
            Result.SituacaoBoletoCodigo := '32';
            Result.DataBaixaAlteracao := RetornaValorJsonValue(LJsonArrayHistorico.Items[0], 'data');
          End;
        End;
      End;

      Result.PagoPorPix :=  Result.SituacaoBoleto.ToUpperInvariant.Equals('BAIXADA');
      If Result.PagoPorPix Then
        Result.PagoPorPix := Not Result.DataPagamento.IsEmpty;

      Result.RetVinculada := 'N';
    End;
  Finally
    FreeAndNil(LJSONRetorno);
  End;
end;

function TBancoItauAPI.RetornaDadosPesquisaBoletoPeriodo(
  ADadosRetorno: String): TRetornoPesquisaBancoItauAPI;
  Var
    LJsonValueBoleto: TJsonValue;

    LJsonObjectCancelamento: TJsonObject;
begin
  Result := TRetornoPesquisaBancoItauAPI.Create;

  If ADadosRetorno.IsEmpty Then
    Exit;

  LJsonValueBoleto := TJSONObject.ParseJSONValue(ADadosRetorno) as TJSONValue;

  Try
    Result.IDBoleto := RetornaValorJsonValue(LJsonValueBoleto, 'idBoleto');
    Result.DataVencimento := RetornaValorJsonValue(LJsonValueBoleto, 'dataVencimento');
    Result.DataEmissao := RetornaValorJsonValue(LJsonValueBoleto, 'dataEmissao');
    Result.DataEntrada := RetornaValorJsonValue(LJsonValueBoleto, 'dataEntrada');
    Result.ValorTitulo := RetornaValorJsonValue(LJsonValueBoleto, 'valor');
    Result.SituacaoBoleto := RetornaValorJsonValue(LJsonValueBoleto, 'situacao');
    Result.NossoNumero := RetornaValorJsonValue(LJsonValueBoleto, 'nossoNumero');
    Result.DataPagamento := RetornaValorJsonValue(LJsonValueBoleto, 'dataPagamento');
    Result.ValorPago := RetornaValorJsonValue(LJsonValueBoleto, 'valorPagoTotal');

    If LJsonValueBoleto.TryGetValue<TJSONObject>('cancelamento', LJsonObjectCancelamento) Then
    Begin
      Result.DataBaixaAlteracao := RetornaValorJson(LJsonObjectCancelamento, 'dataCancelamento');
      Result.MotivoCancelamento := RetornaValorJson(LJsonObjectCancelamento, 'motivoCancelamento');
    End;
  Finally
    FreeAndNil(LJsonValueBoleto);
  End;
end;

function TBancoItauAPI.RetornaDadosQRCode: TJsonObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('chave', FDadosCarteira.ChavePix);
  Result.AddPair('tipo_cobranca', 'cob');
end;

function TBancoItauAPI.RetornaDataParaCredito(ADataPagamento: String;
  APagoPorPix: Boolean): String;
begin
  Result := EmptyStr;

  If Not ADataPagamento.IsEmpty Then
  Begin
    Result := DateTimeToStr(IncDay(StrToDateTime(ADataPagamento), FDadosCarteira.ValorDiasCredito));
    If APagoPorPix Then
      Result := DateTimeToStr(IncDay(StrToDateTime(ADataPagamento), FDadosCarteira.ValorDiasCreditoPix));

    Result := DateTimeToStr(fAcertaDataParaDiaUtil(StrToDateTime(Result)));
  End;
end;

function TBancoItauAPI.PossuiTodosOsDadosParaRealizarAutorizacaoAPI: Boolean;
begin
  Result := True;

  If FDadosCarteira.ClientId.Trim.IsEmpty Then
    Result := False;

  If FDadosCarteira.ClientSecret.Trim.IsEmpty Then
    Result := False;

  If FDadosCarteira.CertificadoCrt.Trim.IsEmpty Then
    Result := False;

  If FDadosCarteira.CertificadoKey.Trim.IsEmpty Then
    Result := False;

  If Not Result Then
    fMensagem('ATENÇÃO', 'A carteira não possui os dados de autorização cadastrados.' + #13 +
                         'Verifique os dados ' +
                         IIF(FDadosCarteira.GerarQRCodePix.Equals('S'),
                             'da Conta Bancária da Chave Pix.',
                             'de Autenticação da Carteira.'),
                         ['&Ok']);
end;

function TBancoItauAPI.PrettyJSON(JsonString:String):String;
  Var
    Jdoc:TJSONObject;
begin
  Try
    Jdoc:=TJSONObject.ParseJSONValue(JsonString) as TJSONObject;
    result:=TJSON.Format(Jdoc);
  Finally
    FreeAndNil(Jdoc);
  End;
end;


function TBancoItauAPI.RetornaDesconto(ADescontos: TJsonArray): TJsonObject;
begin
  Result := TJSONObject.Create;

  Result.AddPair('codigo_tipo_desconto'  , '01');
  Result.AddPair('descontos'             , ADescontos);
End;

function TBancoItauAPI.RetornaJurosMora(ADadosDuplicata: TDataSet): TJsonObject;
  Var
    LValorMora : Double;
begin
  Result := TJSONObject.Create;
  LValorMora := fFormataFloat(Self.FPercentualMora, 5);

  If LValorMora > 0 Then
  Begin
    If FDadosCarteira.CodigoMulta.Equals('2') Then
    Begin
      Result.AddPair('codigo_tipo_juros'    ,'91'); //percentual por dia de atraso
      Result.AddPair('data_juros'           ,FormatDateTime('yyyy-mm-dd', IncDay(ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime, 1)));
      Result.AddPair('percentual_juros'     ,fValNumForm(LValorMora,12, 5));
    End
    Else
    Begin
      Result.AddPair('codigo_tipo_juros'    ,'93'); //valor por dia de atrado
      Result.AddPair('data_juros'           ,FormatDateTime('yyyy-mm-dd', IncDay(ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime, 1)));
      Result.AddPair('valor_juros'          ,fValNumForm(ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat * (LValorMora / 100),15, 2));
    End
  End
  Else
    Result.AddPair('codigo_tipo_juros'    ,'05');
end;

function TBancoItauAPI.RetornaDescontos(ADadosDuplicata: TDataSet): TJsonArray;
  Var
    LValorCorrigido: Double;
    LDataExpiracao : TDateTime;

    LPossuiDescontos: Boolean;

    LJsonObject: TJsonObject;
begin
  Result := Nil;

  LPossuiDescontos := UtilizaDescontoDePontualidade(ADadosDuplicata.FieldByName('CTR_PERDPO').AsFloat);
  If ADadosDuplicata.FieldByName('CTR_DESSUJ').AsFloat > 0 Then
    LPossuiDescontos := True;

  If Not LPossuiDescontos Then
    Exit;

  Result := TJSONArray.Create;

  If ADadosDuplicata.FieldByName('CTR_DESSUJ').AsFloat > 0 Then
  Begin
    LJsonObject := TJsonObject.Create;
    LDataExpiracao  := (ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime - ADadosDuplicata.FieldByName('CTR_QTDDAV').AsInteger);

    LJsonObject.AddPair('data_desconto', FormatDateTime('yyyy-mm-dd', LDataExpiracao));
    LJsonObject.AddPair('valor_desconto', fValNumForm(ADadosDuplicata.FieldByName('CTR_DESSUJ').AsFloat, 17));

    Result.AddElement(LJsonObject);
  End;

  If UtilizaDescontoDePontualidade(ADadosDuplicata.FieldByName('CTR_PERDPO').AsFloat) Then
  Begin
    LJsonObject := TJsonObject.Create;
    LValorCorrigido := (ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat * ( ADadosDuplicata.FieldByName('CTR_PERDPO').AsFloat / 100.00));
    LDataExpiracao  := (ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime - ADadosDuplicata.FieldByName('CTR_QTDDAV').AsInteger);

    LJsonObject.AddPair('data_desconto', FormatDateTime('yyyy-mm-dd', LDataExpiracao));
    LJsonObject.AddPair('valor_desconto', fValNumForm(LValorCorrigido, 17));

    Result.AddElement(LJsonObject);
  End;
end;

function TBancoItauAPI.RetornaEnderecoPagador(
  ADadosCliente: TDataSet): TJsonObject;
begin
  Result  := TJSONObject.Create;
  Result.AddPair('complemento'       ,RetornaValorString(ADadosCliente.FieldByName('CLI_ENDCOM').AsString, 15));
  Result.AddPair('nome_bairro'       ,RetornaValorString(ADadosCliente.FieldByName('CLI_BAIRRO').AsString, 15));
  Result.AddPair('nome_cidade'       ,RetornaValorString(ADadosCliente.FieldByName('CID_NOMCID').AsString, 20));
  Result.AddPair('nome_logradouro'   ,RetornaValorString(Concat(ADadosCliente.FieldByName('CLI_ENDERE').AsString,
                                                                ADadosCliente.FieldByName('CLI_ENDNUM').AsString), 45));
  Result.AddPair('numero_CEP'        ,RetornaValorString(ADadosCliente.FieldByName('CLI_C_E_P_').AsString));
  Result.AddPair('sigla_UF'          ,RetornaValorString(ADadosCliente.FieldByName('CID_ESTADO').AsString));
end;

function TBancoItauAPI.RetornaIDBeneficiario: String;
begin
  Result := fPadL(FDadosCarteira.Agencia       , 004, '0') +
            fPadL(FDadosCarteira.ContaCorrente , 007, '0') +
            fPadL(FDadosCarteira.DAC           , 001, '0') ;
end;

function TBancoItauAPI.RetornaIDBeneficiarioVinculada: String;
begin
  If FDadosCarteira.AgenciaVinculada.IsEmpty Then
    Exit(EmptyStr);

  Result := fPadL(FDadosCarteira.AgenciaVinculada, 004, '0') +
            fPadL(FDadosCarteira.ContaCorrenteVinculada, 007, '0') +
            fPadL(FDadosCarteira.DigitoContaVinculada, 001, '0') ;
end;

function TBancoItauAPI.RetornaIdBoletoNossoNumero(ANossoNumero: String): String;
begin
  Result := RetornaIDBeneficiario +
            FDadosCarteira.CodCarteira +
            LeftStr(ANossoNumero, ANossoNumero.Length - 1);
end;

function TBancoItauAPI.RetornaInstrucaoCobranca: TJsonArray;
begin
  Result := TJSONArray.Create;

  If Not FDadosCarteira.EnviarInstrucaoProtesto.Equals('N') Then
    Result.AddElement(RetornaProtesto);

  If Not FDadosCarteira.EnviarInstrucaoNegativacao.Equals('N') Then
    Result.AddElement(RetornaNegativacao);
end;

function TBancoItauAPI.RetornaMulta(ADadosDuplicata: TDataSet):TJsonObject;
  Var
    LValorMulta : Double;
begin
  Result  := TJSONObject.Create;

  If Self.FPercentualMulta = 0 Then
    Self.FPercentualMulta := fStrToFloat(FDadosCarteira.PercenMulta);

  LValorMulta := fFormataFloat(ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat * (Self.FPercentualMulta/100), 2);
  If FDadosCarteira.CodigoMulta.Equals('1') Then
    LValorMulta := fFormataFloat(Self.FPercentualMulta, 2);

  If (LValorMulta > 0) Then
  Begin
    If FDadosCarteira.CodigoMulta.Equals('2') Then
    Begin
      Result.AddPair('codigo_tipo_multa'   ,'02');
      Result.AddPair('data_multa'          ,FormatDateTime('yyyy-mm-dd', IncDay(ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime, 1)));
      Result.AddPair('percentual_multa'    ,fValNumForm(Self.FPercentualMulta, 12, 5));
    End
    Else
    Begin
      Result.AddPair('codigo_tipo_multa'   ,'01');
      Result.AddPair('data_multa'          ,FormatDateTime('yyyy-mm-dd', IncDay(ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime, 1)));
      Result.AddPair('valor_multa'         ,fValNumForm(LValorMulta, 15, 2));
    End;
  End
  Else
    Result.AddPair('codigo_tipo_multa'   ,'03');
end;

function TBancoItauAPI.RetornaNegativacao: TJsonObject;
begin
  Result  := TJSONObject.Create;

  If (StrToIntDef(FDadosCarteira.QtdDiasNegativacao,0) > 0 )Then
  Begin
    Result.AddPair('codigo_instrucao_cobranca'      ,'2');
    Result.AddPair('quantidade_dias_apos_vencimento', FDadosCarteira.QtdDiasNegativacao);
    Result.AddPair('dia_util'                       , 'false');
  End
  Else
    Result.AddPair('codigo_instrucao_cobranca'     , '5'); // não negativar
end;

function TBancoItauAPI.RetornaProtesto: TJsonObject;
begin
  Result  := TJSONObject.Create;

  If (StrToIntDef(FDadosCarteira.QtdDiasProtesto,0) > 0 )Then
  Begin
    Result.AddPair('codigo_instrucao_cobranca'       , '1');
    Result.AddPair('quantidade_dias_apos_vencimento' , FDadosCarteira.QtdDiasProtesto);
    If FDadosCarteira.DiaUtil Then
      Result.AddPair('dia_util'                        , 'true')
    Else
      Result.AddPair('dia_util'                        , 'false');
  End
  Else
    Result.AddPair('codigo_instrucao_cobranca'       , '4'); // não protestar
end;

function TBancoItauAPI.RetornaObservacoes: TJsonArray;
  Var
    Json: TJSONObject;
begin
  Result := TJsonArray.Create;

  If Not fEmptyStr(FDadosCarteira.Observacao1) Then
  Begin
    Json := TJsonObject.Create;
    Json.AddPair('mensagem', FDadosCarteira.Observacao1);
    Result.AddElement(Json);
  End;

  If Not fEmptyStr(FDadosCarteira.Observacao2) Then
  Begin
    Json := TJsonObject.Create;
    Json.AddPair('mensagem', FDadosCarteira.Observacao2);
    Result.AddElement(Json);
  End;

  If Not fEmptyStr(FDadosCarteira.Observacao3) Then
  Begin
    Json := TJsonObject.Create;
    Json.AddPair('mensagem', FDadosCarteira.Observacao3);
    Result.AddElement(Json);
  End;

  If Not fEmptyStr(FDadosCarteira.Observacao4) Then
  Begin
    Json := TJsonObject.Create;
    Json.AddPair('mensagem', FDadosCarteira.Observacao4);
    Result.AddElement(Json);
  End;

  If Not fEmptyStr(FDadosCarteira.Observacao5) Then
  Begin
    Json := TJsonObject.Create;
    Json.AddPair('mensagem', FDadosCarteira.Observacao5);
    Result.AddElement(Json);
  End;
end;

function TBancoItauAPI.RetornaPagador(ADadosCliente: TDataSet): TJsonObject;
begin
  Result  := TJsonObject.Create;

  Result.AddPair('pessoa'  , RetornaPessoaPagador(ADadosCliente));
  Result.AddPair('endereco', RetornaEnderecoPagador(ADadosCliente));
end;

function TBancoItauAPI.RetornaPessoaPagador(
  ADadosCliente: TDataSet): TJsonObject;
begin
  Result  := TJsonObject.Create;

  If fTiraCaracEspeciais(ADadosCliente.FieldByName('CLI_C_G_C_').AsString).Length = 11 Then
    Result.AddPair('nome_pessoa'        , RetornaValorString(ADadosCliente.FieldByName('CLI_NOMCLI').AsString, 50))
  Else
  Begin
    Result.AddPair('nome_fantasia'      , RetornaValorString(ADadosCliente.FieldByName('CLI_FANSOB').AsString, 50));
    Result.AddPair('nome_pessoa'        , RetornaValorString(ADadosCliente.FieldByName('CLI_NOMCLI').AsString, 50));
  End;

  Result.AddPair('tipo_pessoa'        , RetornaTipoPessoaPagador(ADadosCliente));
end;

function TBancoItauAPI.RetornaSacadorAvalista: TJsonObject;
  Var
    LJsonPessoa,
    LTipoPessoa,
    LEndereco: TJsonObject;
begin
  Result := TJSONObject.Create;

  LJsonPessoa := TJsonObject.Create;
  LJsonPessoa.AddPair('nome_pessoa'                   , RetornaValorString(FDadosCarteira.DadosEmpresa.FieldByName('EMP_NOMEMP').AsString, 50));

  LTipoPessoa := TJsonObject.Create;
  LTipoPessoa.AddPair('codigo_tipo_pessoa'             , 'J');
  LTipoPessoa.AddPair('numero_cadastro_nacional_pessoa_juridica', fTiraCaracEspeciaisPonto(FDadosCarteira.DadosEmpresa.FieldByName('EMP_C_G_C_').AsString));

  LJsonPessoa.AddPair('tipo_pessoa'                    , LTipoPessoa);

  Result.AddPair('pessoa'                              , LJsonPessoa);

  LEndereco := TJsonObject.Create;
  LEndereco.AddPair('nome_logradouro', RetornaValorString(Concat(FDadosCarteira.DadosEmpresa.FieldByName('EMP_ENDERE').AsString,
                                                                       FDadosCarteira.DadosEmpresa.FieldByName('EMP_ENDNUM').AsString), 45));
  LEndereco.AddPair('nome_bairro', RetornaValorString(FDadosCarteira.DadosEmpresa.FieldByName('EMP_BAIRRO').AsString, 15));
  LEndereco.AddPair('nome_cidade', RetornaValorString(fRetCidEmpresa(FDadosCarteira.DadosEmpresa.FieldByName('EMP_CODEMP').AsString), 20));
  LEndereco.AddPair('sigla_UF', RetornaValorString(fRetUFEmpresa(FDadosCarteira.DadosEmpresa.FieldByName('EMP_CODEMP').AsString), 2));
  LEndereco.AddPair('numero_CEP', fRetSomenteNumeros(FDadosCarteira.DadosEmpresa.FieldByName('EMP_C_E_P_').AsString));
  Result.AddPair('endereco', LEndereco);
end;

function TBancoItauAPI.RetornaTextoErro(ACodigoRetorno,
  ADadosRetorno: String): String;
  Var
    LJsonObject: TJsonObject;

    LJsonValue: TJsonValue;

    LErro: String;

    LErroInstabilidade,
    LErroAutenticacao : String;
begin
  Result := 'Status: ' + ACodigoRetorno + ' - Erro: ' + ADadosRetorno;

  LErroInstabilidade := 'Ocorreu um erro não identificado no servidor do banco. Tente novamente mais tarde! ';

  LErroAutenticacao  := 'Ocorreu um erro ao realizar a autenticação na API do Banco.';

  Try
    LJsonObject := TJSONObject.ParseJSONValue(ADadosRetorno) As TJsonObject;

    If LJsonObject = Nil Then
    Begin
       Result := LErroInstabilidade;

       // Verifica se é erro de authenticação - gerar token
       If (Pos(LErroAutenticacao, ADadosRetorno) > 0) Then
           Result := LErroAutenticacao;

       Exit;
    End;

    LErro := 'Status: ' + ACodigoRetorno + ' - Erro: ';
    For LJsonValue In LJsonObject.GetValue('campos') as TJsonArray Do
    Begin
      If ACodigoRetorno = '422' Then
         LErro := LErro + 'Campo: ' + LJsonValue.GetValue<String>('campo') +
                          ' - Valor: ' + LJsonValue.GetValue<String>('valor') + '.' + #13;

      LErro := LErro + LJsonValue.GetValue<String>('mensagem') + '. ';

      If LErro.ToLowerInvariant.Contains('atualização não permitida na mesma data de emissão do título') Then
        LErro := 'O boleto só poderá ser cancelado no próximo dia útil de sua emissão.' + #13 +
                 'Para boletos emitidos em finais de semana e feriados, só poderão ser cancelados no segundo ' +
                 'dia útil após sua emissão.';
    End;

    If (fEmptyStr(ACodigoRetorno) or fEmptyStr(ADadosRetorno)) Then
        LErro := LErroInstabilidade
    Else
       Result := LErro;

    FreeAndNil(LJsonObject);
  Except
    Result := LErroInstabilidade;
  End;
end;

function TBancoItauAPI.RetornaTipoPessoaPagador(
  ADadosCliente: TDataSet): TJsonObject;
  Var
    LPessoaFisica:Boolean;
    LDocumento:String;
begin
  LDocumento := fTiraCaracEspeciais(ADadosCliente.FieldByName('CLI_C_G_C_').AsString);
  LPessoaFisica :=  (Length(LDocumento) = 11);
  Result := TJSONObject.Create;
  Result.AddPair('codigo_tipo_pessoa',IIF(LPessoaFisica,'F','J'));

  If LPessoaFisica Then
    Result.AddPair('numero_cadastro_pessoa_fisica',LDocumento)
  Else
    Result.AddPair('numero_cadastro_nacional_pessoa_juridica',LDocumento);
end;

function TBancoItauAPI.RetornaValorDuplicata(
  ADadosDuplicata: TDataSet): Double;
begin
  Result := ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat;

  If fCfgSis('VALIMP', varBoolean, FDadosCarteira.EmpresaCarteira) then
  Begin
    Result := ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat +
              ADadosDuplicata.FieldByName('CTR_JURSUJ').AsFloat +
              ADadosDuplicata.FieldByName('CTR_DESCOB').AsFloat;

  End;
end;

function TBancoItauAPI.RetornaValorJson(AObjeto: TJsonObject;
  ANomeCampo: String): String;
begin
  Result := '';
  If AObjeto.GetValue(ANomeCampo) <> Nil Then
    Result := AObjeto.GetValue<string>(ANomeCampo);
end;

function TBancoItauAPI.RetornaValorJsonValue(AObjeto: TJsonValue;
  ANomeCampo: String): String;
begin
  If Not AObjeto.TryGetValue<String>(ANomeCampo, Result) Then
    Result := '';
end;

function TBancoItauAPI.RetornaValorString(AValor: String;
  ATamanho: Integer): String;
begin
  Result := AValor;

  If Result.IsEmpty Then
    Exit;

  Result := fRemoveAcento(Result);
  Result := fTiraCaracEspeciais(Result);
  Result := fTiraEnter(Result);

  If ATamanho > 0 Then
    Result := LeftStr(Result, ATamanho);
end;

function TBancoItauAPI.InterpretaMensagemErro(const AErro: String): Boolean;
begin
  Result := False;

  if AErro.Contains('Acesso a rota não permitido filter failed') then
  begin
    fMensagem('ATENÇÃO',
              'Suas credenciais de acesso não têm permissão para utilizar esta rotina.' + sLineBreak +
              'Entre em contato com o Itaú para solicitar a liberação dos acessos (scopes) ' +
              'ou a geração de uma nova credencial.',
              ['&Ok']);
    Result := True;
    Exit;
  end;
end;


function TBancoItauAPI.UtilizaDescontoDePontualidade(
  AValDes: Double): Boolean;
begin
  Result := False;

  If fCfgSis('DESPON', varBoolean, FDadosCarteira.EmpresaCarteira) Then
  Begin
    If (AValDes > 0) Then
      Result := True;
  End;

end;

procedure TBancoItauAPI.ValidarDadosAutorizacao;
  Var
    LGeradoToken: Boolean;

    LLinkConsulta,
    LResposta: String;

    LRetornoConsulta: Integer;

    LParametros: TStringList;
begin
  If Not PossuiTodosOsDadosParaRealizarAutorizacaoAPI Then
    Exit;

  FTokenUsoAtual := EmptyStr;

  Try
    FRestSynalist.StatusSemRaise := [404, 401, 403];

    Try
      FRestSynalist.RemoveTokenAtivo(FDadosCarteira.CarteiraCompleta);
      GerarToken;

      LGeradoToken := Not FTokenUsoAtual.Replace('Bearer ', EmptyStr).IsEMpty;
    Except
      On E: Exception Do
      Begin
        fMensagem('ERRO', E.Message, ['&Ok']);

        Exit;
      End;
    End;

    If Not LGeradoToken Then
    Begin
      fMensagem('ATENÇÃO', 'Não foi possível atenticar a API. Verifique os dados de autorização.', ['&Ok']);

      Exit;
    End;

    Try
      LLinkConsulta := FDadosCarteira.LinkConsultaEspecifico.Replace('[BENEFICIARIO]', RetornaIDBeneficiario)
                                                              .Replace('[CARTEIRA]', FDadosCarteira.CodCarteira)
                                                              .Replace('[NOSSO_NUMERO]', '91010101');

      LParametros := TStringList.Create;
      LParametros.Add('Authorization: ' + FTokenUsoAtual);
      LParametros.Add('x-itau-apikey: ' + FDadosCarteira.ClientId);
      LParametros.Add('x-itau-correlationID: 1');
      LParametros.Add('x-itau-flowID: 2');

      LRetornoConsulta := FRestSynalist.ExecuteRestSynalist('GET',
                                                            LLinkConsulta,
                                                            LParametros,
                                                            LResposta);
    Except
      On E: Exception Do
        LResposta := E.Message;
    End;

    If Not MatchStr(LRetornoConsulta.ToString, ['200', '201', '404']) Then
    Begin
      If MatchStr(LRetornoConsulta.ToString, ['401', '403']) Then
        fMensagem('ATENÇÃO', 'O sistema conseguiu realizar a comunicação parcial com a API.' + #13 +
                             'Nesse caso, é necessário entrar em contato com a Citel para que possamos ' +
                             'pedir a liberação total das chaves de acesso para o banco Itaú.', ['&Ok'])
      Else
        fMensagem('ERRO', LResposta, ['&Ok']);

      Exit;
    End;
  Finally
    FRestSynalist.StatusSemRaise := [];
  End;

  fMensagem('ATENÇÃO', 'Dados de autorização validados com sucesso.', ['&Ok']);
end;

procedure TBancoItauAPI.ValidaSeTodosOsLinksEstaoMapeados;
  Var
    LMensagem: String;
begin
  LMensagem := 'Links de boletos do banco Itaú não devidamente mapeados. Entre em contato com a Citel.';

  If FDadosCarteira.LinkTokenAPI.Trim.IsEmpty Then
    Raise ExceptionAutcom.Create(LMensagem);

  If FDadosCarteira.LinkInclusao.Trim.IsEmpty Then
    Raise ExceptionAutcom.Create(LMensagem);

  If FDadosCarteira.LinkConsultaPix.Trim.IsEmpty Then
    Raise ExceptionAutcom.Create(LMensagem);

  If FDadosCarteira.LinkConsultaEspecifico.Trim.IsEmpty Then
    Raise ExceptionAutcom.Create(LMensagem);

  If FDadosCarteira.LinkConsulta.Trim.IsEmpty Then
    Raise ExceptionAutcom.Create(LMensagem);

  If FDadosCarteira.LinkBaixa.Trim.IsEmpty Then
    Raise ExceptionAutcom.Create(LMensagem);
end;

function TBancoItauAPI.VerificaSeADuplicataExisteCadrec(ABoleto: TRetornoPesquisaBancoItauAPI;out ADuplicata: TDuplicataCtr): Boolean;
  Var
    LPesquisa: TUniQuery;
begin
  ADuplicata.strAutoIn := EmptyStr;
  ADuplicata.strNumDup := EmptyStr;
  ADuplicata.strParcel := EmptyStr;
  ADuplicata.strEspdoc := EmptyStr;
  ADuplicata.strCodEmp := EmptyStr;
  ADuplicata.strCodCli := EmptyStr;

  LPesquisa := fCriaQuery;
  Try
    LPesquisa.SQL.Text := 'SELECT AUTOINCREM, CTR_NUMDUP, CTR_CODEMP,      ' +
                          'CTR_PARCEL, CTR_ESPDOC, CTR_CODCLI, CTR_CARTEI, ' +
                          'CTR_ID_BOL                                      ' +
                          'FROM CADREC                                     ' +
                          'WHERE CTR_NOSNUM=:NOSNUM                        ';

    If Not FUtilizarNovaAPIConsulta Then
      LPesquisa.SQL.Add('  AND CTR_BCOBOL=:BCOENV                      ');

    LPesquisa.SQL.Add('  AND CTR_BCOENV=:BCOENV                        ' +
                      '  AND CTR_SEQBAI=0                              ');

    LPesquisa.ParamByName('NOSNUM').AsString   := ABoleto.NossoNumero;
    LPesquisa.ParamByName('BCOENV').AsString   := '341';

    LPesquisa.Open;

    Result := Not LPesquisa.IsEmpty;
    If Not Result Then
      Exit;

    ADuplicata.strAutoIn := LPesquisa.FieldByName('AUTOINCREM').AsString;
    ADuplicata.strNumDup := LPesquisa.FieldByName('CTR_NUMDUP').AsString;
    ADuplicata.strParcel := LPesquisa.FieldByName('CTR_PARCEL').AsString;
    ADuplicata.strEspdoc := LPesquisa.FieldByName('CTR_ESPDOC').AsString;
    ADuplicata.strCodEmp := LPesquisa.FieldByName('CTR_CODEMP').AsString;
    ADuplicata.strCodCli := LPesquisa.FieldByName('CTR_CODCLI').AsString;

    If LPesquisa.RecordCount > 1 Then
    Begin
      LPesquisa.Filter := 'CTR_CARTEI=' + FDadosCarteira.CarteiraBanco.QuotedString;
      LPesquisa.Filtered := True;

      If Not LPesquisa.IsEmpty Then
      Begin
        ADuplicata.strAutoIn := LPesquisa.FieldByName('AUTOINCREM').AsString;
        ADuplicata.strNumDup := LPesquisa.FieldByName('CTR_NUMDUP').AsString;
        ADuplicata.strParcel := LPesquisa.FieldByName('CTR_PARCEL').AsString;
        ADuplicata.strEspdoc := LPesquisa.FieldByName('CTR_ESPDOC').AsString;
        ADuplicata.strCodEmp := LPesquisa.FieldByName('CTR_CODEMP').AsString;
        ADuplicata.strCodCli := LPesquisa.FieldByName('CTR_CODCLI').AsString;
      End;

      If LPesquisa.RecordCount > 1 Then
      Begin
        LPesquisa.Filter := 'CTR_CARTEI=' + FDadosCarteira.CarteiraBanco.QuotedString + ' AND ' +
                            'CTR_ID_BOL=' + ABoleto.IDBoleto.QuotedString;
        LPesquisa.Filtered := True;

        If Not LPesquisa.IsEmpty Then
        Begin
          ADuplicata.strAutoIn := LPesquisa.FieldByName('AUTOINCREM').AsString;
          ADuplicata.strNumDup := LPesquisa.FieldByName('CTR_NUMDUP').AsString;
          ADuplicata.strParcel := LPesquisa.FieldByName('CTR_PARCEL').AsString;
          ADuplicata.strEspdoc := LPesquisa.FieldByName('CTR_ESPDOC').AsString;
          ADuplicata.strCodEmp := LPesquisa.FieldByName('CTR_CODEMP').AsString;
          ADuplicata.strCodCli := LPesquisa.FieldByName('CTR_CODCLI').AsString;
        End;
      End;
    End;
  Finally
    LPesquisa.Close;
    FreeAndNil(LPesquisa);
  End;
end;

procedure TBancoItauAPI.ExibeFormMensagemErro(AMensagem: String);
  Var
    LArqNaoGravados: TfrmArqNaoGravados;
begin
  Try
    pCriarFormularios(TfrmArqNaoGravados,LArqNaoGravados);
    LArqNaoGravados.Caption := 'AVISO';
    LArqNaoGravados.memResumo.WantReturns := True;
    LArqNaoGravados.memResumo.Lines.Add(AMensagem);
    LArqNaoGravados.ShowModal;
  Finally
    FreeAndNil(LArqNaoGravados);
  End;
end;

end.
