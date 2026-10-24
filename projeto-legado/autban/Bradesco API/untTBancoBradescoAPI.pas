unit untTBancoBradescoAPI;

interface

Uses
  System.SysUtils, System.JSON, System.Generics.Collections, REST.Json,
  System.StrUtils, System.DateUtils, System.NetEncoding, System.Variants,
  System.Classes, Vcl.Forms, WinApi.Windows, Data.DB, Uni, UniClientDataset,

  untTRestSynalistAutban, untTRegBol, untTypesSistema, untFuncoesBoleto,
  untGravando;

Type
  TDadosCarteira = Record
    CarteiraBanco,
    EmpresaCarteira,
    CarteiraCompleta,
    LinkConsulta,
    LinkConsultaPendente,
    LinkConsultaEspecifico,
    LinkInclusao,
    LinkBaixa,
    LinkApi,
    LinkTokenAPI,
    Convenio,
    CodCedente,
    CodCarteira,
    VariacaoCarteira,
    NumeroAutorizacao,
    QtdDiasProtesto,
    QtdDiasLimitePagto,
    Observacao1,
    Observacao2,
    Observacao3,
    Observacao4,
    Observacao5,
    Instrucao01,
    InstrucaoPersonalizada,
    PercenMulta,
    OrgaoNegativador,
    QtdDiasNegativacao,
    QtdDiasCredito,
    Aceite,
    ContaCorrente,
    DAC,
    Agencia,
    DigAgencia,
    ContaCaucao,
    TipoCobranca,
    CodigoMulta,
    PortadorBaixa,
    PlanoDeContasBaixa,
    EspDocumento,
    Homologacao,
    EmpresaConta,

    GerarQRCodePix,
    ClientId,
    ClientSecret,
    ChavePix,
    AutoIncremChavePix,
    CertificadoPfx,
    SenhaCertificado,

    UsaSacadorAvalista,
    NomeBeneficiario,
    EnderecoBeneficiario,
    ComplementoBeneficiario,
    BairroBeneficiario,
    CidadeBeneficiario,
    UFBeneficiario,
    CEPBeneficiario,
    CNPJBeneficiario,

    ImportarEmpresas,
    BaixarBoletosGeradoPorArquivo: String;

    ValorDiasCredito,
    ValorDiasCreditoPix: Integer;

    DiaUtil: Boolean;

    DadosEmpresa,
    DadosChavePix: TUniQuery;
  end;

Type
  TRetornoPesquisaBancoBradescoAPI = class
  public
    bancoRecebedor,
    agenciaRecebedora,
    nossoNumero,
    digitoNossoNumero,
    tipoRegistro,
    seuNumero,
    dataVencimento,
    dataPagamento,
    dataMovimento,
    nomePagador,
    descricaoOrigemPagamento,
    valorTitulo,
    valorPagamento,
    valorOscilacao,
    sinalValorOscilacao,
    numeroSequenciaTitulo,
    numeroSequenciaPagamento,
    codigoFormaCredito,
    descricaoFormaCredito,
    indicadorPagoCartorio,
    indicadorPagoQrCode,
    txId,

    Negociacao,

    agencCred,
    ctaCred,
    digCred,
    codStatus,
    status,
    bcoDepos,
    snumero,
    dataReg,
    dataEmis,
    valMoeda,
    valorIof,
    valAbat,
    valMulta,
    valPerm,
    dataInstr,
    dataCartor,
    numProtoc,
    indBoletoDda,
    valorMoedaBol,
    identTitDda,
    DtPagto,
    vlrPagto,
    ctrlPartic,

    baixaCodigo,
    baixaDescricao,
    baixaData,

    JsonBoletoConsultaLista,

    CodigoCarteira,
    NomeDoArquivo: String;
  end;

type
  TBancoBradescoAPI = class(TObject)
  private
    FDadosCarteira: TDadosCarteira;

    FPercentualMulta,
    FPercentualMora: Double;
    FFaturamento,
    FTentarNovamente,
    FNossoNumeroDuplicado: Boolean;

    FListaRequisicaoRegistroBoleto : TList<TRequisicaoRegistroBoleto>;
    FRetornoBancoBradescoAPI: TRetornoBoletoBradesco;

    FTokenUsoAtual: String;

    FPastaAutcom: String;

    FRestSynalist: TRestSynalistAutban;

    procedure DefinirURL;
    procedure CarregaDadosCarteira(ACarteira: String);
    procedure CriarComponenteRequisicao;

    //Auxiliares
    function RetornaValorDuplicata(ADadosDuplicata: TDataSet): Double;
    function RetornaDadosString(AString: String;
                                ATamanho: Integer = -1): String;
    function RetornaDadosJsonNumber(AString: String;
                                    ATamanho: Integer = -1): TJsonNumber;
    function UtilizaDescontoDePontualidade(AValorDesconto: Double): Boolean;
    procedure AtualizaDadosExportacaoRemessa(ACadRec: TDataSet;
                                             ADadosRetorno: TRetornoBoletoBradesco);

    procedure AguardeCincoSegundos;

    procedure ValidaStatusErro(ACodigoRetorno: Integer;
                               AJsonRetorno: String);
    function RetornaErrosTratadosDaAPI(ACodigoRetorno: Integer;
                                      AJsonRetorno: String): String;

    procedure CorrigeDatas(var AValorDuplicata: String);
    procedure CorrigeValores(var AValorDuplicata: String;
                             ACasasDecimais: Integer = 2);

    function TrataMensagemErro(ATextoErro: String): String;

    //Autenticação

    function AtualizaStatusRetornoErro(AStatusAtual: Integer;
                                       AErro: String): Integer;
    function RetornaTextoErro(ACodigoRetorno,
                              ADadosRetorno: String): String;

    //Requisição Convencional
    function RetornaDadosDaRequisicao(ADadosDuplicata,
                                      ADadosCliente: TDataset;
                                      var ANosNum: String): String;
    function RetornaDadosRetornoInclusaoBoleto(ARetornoJson,
                                               ANossoNumero: String): TRetornoBoletoBradesco;

    function RetornaInstrucaoCarteira(ADadosCliente: TDataset): String;

    procedure CarregaDadosBeneficiario(var ADadosRequisicao: TJsonObject);
    procedure CarregaDadosDoTitulo(var ADadosRequisicao: TJsonObject;
                                   ADadosDuplicata: TDataset;
                                   ANosNum: String);
    procedure CarregaDadosProtesto(var ADadosRequisicao: TJsonObject;
                                   ADadosDuplicata,
                                   ADadosCliente: TDataset);
    procedure CarregaDadosJuros(var ADadosRequisicao: TJsonObject;
                                ADadosDuplicata,
                                ADadosCliente: TDataset);
    procedure CarregaDadosMulta(var ADadosRequisicao: TJsonObject;
                                ADadosDuplicata: TDataset);
    procedure CarregaDadosDescontos(var ADadosRequisicao: TJsonObject;
                                    ADadosDuplicata,
                                    ADadosCliente: TDataset);
    procedure CarregaDadosPagador(var ADadosRequisicao: TJsonObject;
                                  ADadosCliente: TDataset);
    procedure CarregaDadosMensagens(var ADadosRequisicao: TJsonObject);

    procedure CarregarValoresOpcionais(var ADadosRequisicao: TJsonObject);
    procedure AdicionaValorOpcional(var ADadosRequisicao: TJsonObject;
                                    ACampoJson: String;
                                    AValor: String = '';
                                    ANumber: Boolean = False);

    function RetornaValorDecimalJsonParaTJsonNumber(AValor: Double): TJSONNumber;
    //end requisicao convencional

    //Requisição Boleto com QRCode
    function RetornaDadosDaRequisicaoBoleCode(ADadosDuplicata,
                                              ADadosCliente: TDataset;
                                              var ANosNum: String): String;

    function RetornaDadosRetornoInclusaoBoletoBoleCode(ARetornoJson: String;
                                                       ANossoNumero: String): TRetornoBoletoBradesco;

    procedure CarregaDadosBeneficiarioBoleCode(var ADadosRequisicao: TJsonObject);
    procedure CarregaDadosDoTituloBoleCode(var ADadosRequisicao: TJsonObject;
                                           ADadosDuplicata: TDataset;
                                           ANosNum: String);
    procedure CarregaDadosProtestoBoleCode(var ADadosRequisicao: TJsonObject;
                                           ADadosDuplicata,
                                           ADadosCliente: TDataset);
    procedure CarregaDadosJurosBoleCode(var ADadosRequisicao: TJsonObject;
                                        ADadosDuplicata,
                                        ADadosCliente: TDataset);
    procedure CarregaDadosMultaBoleCode(var ADadosRequisicao: TJsonObject;
                                        ADadosDuplicata: TDataset);
    procedure CarregaDadosDescontosBoleCode(var ADadosRequisicao: TJsonObject;
                                            ADadosDuplicata,
                                            ADadosCliente: TDataset);
    procedure CarregaDadosPagadorBoleCode(var ADadosRequisicao: TJsonObject;
                                          ADadosCliente: TDataset);

    procedure CarregaDadosPixBoleCode(var ADadosRequisicao: TJsonObject);

    procedure CarregarValoresOpcionaisBoleCode(var ADadosRequisicao: TJsonObject);
    procedure AdicionaValorOpcionalBoleCode(var ADadosRequisicao: TJsonObject;
                                            ACampoJson: String;
                                            AValor: String = '';
                                            ANumber: Boolean = False);

    function JsonRetornoModeloQRCode(AJsonRetorno: String): Boolean;
    //end requisicao Boleto com QRCode

    //Alteração
    procedure BaixaBoletoRegistrado(ADataSet: TDataSet);

    function DeveLimparOsDadosDoBoletoCancelamento(AStatus: Integer;
                                                   ARetorno: String): Boolean;
    //end alteração

    //Consulta
    function RetornaListaDeCarteiras: TStringList;
    function ConsultaBoletosTodasEmpresas(ADataInicial,
                                          ADataFinal: TDateTime;
                                          var AProgresso: TfrmGravando): TList<TRetornoPesquisaBancoBradescoApi>;

    function RetornaDadosRequisicaoPesquisa(ADataInicial,
                                            ADataFinal: TDateTime;
                                            ALiquidados: Boolean;
                                            APaginaAnterior: Integer): String;

    function RetornaDadosRequisicaoPesquisaPendente(ADataInicial,
                                                    ADataFinal: TDateTime;
                                                    ALiquidados: Boolean;
                                                    APaginaAnterior: Integer): String;

    function RetornaDadosRequisicaoPesquisaNossoNumero(ANossoNumero: String): String;

    function RetornaDadosPesquisaBoletoLiquidadoAPIBradesco(ADadosBoleto: String): TRetornoPesquisaBancoBradescoAPI;
    function RetornaDadosPesquisaBoletoPendentesAPIBradesco(ADadosBoleto: String): TRetornoPesquisaBancoBradescoAPI;

    function RetornaDadosPesquisaBoletoNossoNumero(ADadosBoleto: String;
                                                   AObjetoBoleto: TRetornoPesquisaBancoBradescoAPI;
                                                   ARetornouErro412PorSequencia: Boolean): TRetornoPesquisaBancoBradescoAPI;

    procedure RemoverDuplicadosNaHomologacao(var AListaImportada: TList<TRetornoPesquisaBancoBradescoApi>;
                                             ANegociacao: String);

    function EhErro412PorSequencia(AStatus: Integer;
                                   ARetornoErro: String): Boolean;

    //end consulta
  public
    constructor Create(ACarteira: String);
    Destructor Destroy; Override;

    function CadastrarNovoBoleto(ADadosDuplicata,
                                 ADadosCliente: TDataSet;
                                 Var ANosNum: String): TRetornoBoletoBradesco;

    procedure CancelarBoletos(ADataSet:TDataSet);

    function ConsultaBoletosPorPeriodo(ADataInicial,
                                       ADataFinal: TDateTime;
                                       var AProgresso: TfrmGravando): TList<TRetornoPesquisaBancoBradescoApi>;

    function ConsultaBoletosLiquidados(ADataInicial,
                                       ADataFinal: TDateTime;
                                       AListaBoletos: TList<TRetornoPesquisaBancoBradescoApi>;
                                       var AProgresso: TfrmGravando): TList<TRetornoPesquisaBancoBradescoApi>;

    function ConsultaBoletosMovimento(ADataInicial,
                                      ADataFinal: TDateTime;
                                      AListaBoletos: TList<TRetornoPesquisaBancoBradescoApi>;
                                      var AProgresso: TfrmGravando): TList<TRetornoPesquisaBancoBradescoApi>;

    procedure ConsultaBoletoPorNossoNumeroLista(ADataInicial,
                                                ADataFinal: TDateTime;
                                                ANegociacao: String;
                                                var AListaImportada: TList<TRetornoPesquisaBancoBradescoApi>;
                                                var AProgresso: TfrmGravando);

    procedure ReimpressaoDeBoleto(AAutoIncrem: String);

    procedure GravarDadosRequisicaoRegistroBoleto;

    function VerificaSeADuplicataExisteCadrec(ABoleto: TRetornoPesquisaBancoBradescoAPI;
                                              out ADuplicata: TDuplicataCtr): Boolean;

    procedure GerarToken(ALimparTokenGravado: Boolean = False);

    procedure RemoverTokenGravado;

    property PercentualMulta: Double read FPercentualMulta write FPercentualMulta;
    property PercentualMora: Double read FPercentualMora write FPercentualMora;
    property Faturamento: Boolean read FFaturamento write FFaturamento;
    property TentarNovamente: Boolean read FTentarNovamente write FTentarNovamente;

    property RetornoBancoBradescoAPI: TRetornoBoletoBradesco read FRetornoBancoBradescoAPI write FRetornoBancoBradescoAPI;

    property TokenUsoAtual: String read FTokenUsoAtual;

    property DadosCarteira: TDadosCarteira read FDadosCarteira;

    property NossoNumeroDuplicado: Boolean read FNossoNumeroDuplicado write FNossoNumeroDuplicado;
  end;

  Const
    NOSSO_NUMERO_HOMOLOGACAO: Array of String = ['17188031006', '17114004039',
                                                 '17151006429', '350008787'];

implementation

Uses untFuncoesSimples, untFuncAutban, untLogCtr;

{ TBancoBradescoAPI }

procedure TBancoBradescoAPI.AdicionaValorOpcional(
  var ADadosRequisicao: TJsonObject; ACampoJson: String; AValor: String = '';
  ANumber: Boolean = False);
begin
  If ADadosRequisicao.Values[ACampoJson] <> Nil Then
    Exit;

  If ANumber Then
  Begin
    ADadosRequisicao.AddPair(ACampoJson, TJsonNumber.Create(AValor));

    Exit;
  End;

  ADadosRequisicao.AddPair(ACampoJson, TJSONString.Create(AValor));
end;

procedure TBancoBradescoAPI.AdicionaValorOpcionalBoleCode(
  var ADadosRequisicao: TJsonObject; ACampoJson, AValor: String;
  ANumber: Boolean);
begin
  If ADadosRequisicao.Values[ACampoJson] <> Nil Then
    Exit;

  If ANumber Then
  Begin
    ADadosRequisicao.AddPair(ACampoJson, TJsonNumber.Create(AValor));

    Exit;
  End;

  ADadosRequisicao.AddPair(ACampoJson, TJSONString.Create(AValor));
end;

procedure TBancoBradescoAPI.AguardeCincoSegundos;
begin
  Aguarde(5000);
end;

procedure TBancoBradescoAPI.AtualizaDadosExportacaoRemessa(ACadRec: TDataSet;
  ADadosRetorno: TRetornoBoletoBradesco);
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
      LCadRec.ParamByName('CODBCO').AsString := '237';

      If Not ADadosRetorno.QrCodeTxId.IsEmpty Then
      Begin
        LCadRec.ParamByName('TX_BOL').AsString := ADadosRetorno.QrCodeTxId;
        LCadRec.ParamByName('QRCODE').AsString := ADadosRetorno.QrCodeEmv;
        LCadRec.ParamByName('PIXLOC').AsString := ADadosRetorno.QrCodeUrl;
        LCadRec.ParamByName('LNKCIT').AsString := ADadosRetorno.QrCodeLinkCitel;
      End;

      LCadRec.ParamByName('AUTINC').AsString := ACadRec.FieldByName('AUTOINCREM').AsString;
      LCadRec.ExecSQL;
    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  Finally
    LCadrec.Close;

    FreeAndNil(LCadRec);
  End;
end;

function TBancoBradescoAPI.AtualizaStatusRetornoErro(AStatusAtual: Integer;
  AErro: String): Integer;
  Var
    LJSonObject: TJsonObject;
begin
  Result := AStatusAtual;

  If AErro.IsEmpty Then
    Exit;

  Try
    LJSonObject := TJSONObject.ParseJSONValue(AErro) As TJsonObject;

    If LJSonObject = Nil Then
      Exit;

    If Not RetornaValorJson(LJsonObject, 'codigoRetorno').IsEmpty Then
      Exit(StrToInt(RetornaValorJson(LJsonObject, 'codigoRetorno')));

    If Not RetornaValorJson(LJsonObject, 'statusHttp').IsEmpty Then
      Exit(StrToInt(RetornaValorJson(LJsonObject, 'statusHttp')));
  Finally
    If Assigned(LJsonObject) Then
      FreeAndNil(LJsonObject);
  End;
end;

procedure TBancoBradescoAPI.BaixaBoletoRegistrado(ADataSet: TDataSet);
  Var
    LRetorno,
    LCNPJEmpresa,
    LDadosRequisicao: String;

    LRequisicaoAlteraBoleto: TRequisicaoRegistroBoleto;

    LStatus: Integer;

    LParametros: TStringList;
begin
  LCNPJEmpresa := FDadosCarteira.DadosEmpresa.FieldByName('EMP_C_G_C_').AsString.Replace('.', EmptyStr)
                                                                                .Replace('/', EmptyStr)
                                                                                .Replace('-', EmptyStr);

  Self.FTentarNovamente := True;
  LRequisicaoAlteraBoleto := TRequisicaoRegistroBoleto.Create;

  LRequisicaoAlteraBoleto.LCartei :=  FDadosCarteira.CarteiraCompleta;
  LRequisicaoAlteraBoleto.LCodBco := '237';
  LRequisicaoAlteraBoleto.FDescricao := 'CANCELAMENTO';
  LRequisicaoAlteraBoleto.LLocImp := 'ATB';

  LDadosRequisicao := '{"cpfCnpj":{"cpfCnpj":' + StrToInt(LeftStr(LCNPJEmpresa, 8)).ToString + ',' +
                      '"filial":' + StrToInt(Copy(LCNPJEmpresa, 9, 4)).ToString + ',' +
                      '"controle":' + StrToInt(RightStr(LCNPJEmpresa, 2)).ToString + '},' +
                      '"produto":' + StrToInt(RightStr(FDadosCarteira.CodCarteira, 2)).ToString + ',' +
                      '"negociacao":' + StrToInt64(Concat(fStrZero(FDadosCarteira.Agencia, 4),
                                                          fStrZero(FDadosCarteira.ContaCorrente, 7))).ToString + ',' +
                      '"nossoNumero":' + StrToInt64(LeftStr(ADataSet.FieldByName('CTR_NOSNUM').AsString, ADataSet.FieldByName('CTR_NOSNUM').AsString.Length - 1)).ToString + ',' +
                      '"sequencia":0,' +
                      '"codigoBaixa":57}';

  LRequisicaoAlteraBoleto.FRequisicao := LDadosRequisicao;
  LRequisicaoAlteraBoleto.LDuplic := ADataSet.FieldByName('AUTOINCREM').AsString;
  LRequisicaoAlteraBoleto.LLnkApi := FDadosCarteira.LinkBaixa;

  LParametros := TStringList.Create;

  Try
    Try
      GerarToken;

      LParametros.Add('Authorization: ' + FTokenUsoAtual);
      
      LStatus := FRestSynalist.ExecuteRestSynalist('POST',
                                                   LRequisicaoAlteraBoleto.LLnkApi,
                                                   LParametros,
                                                   LRetorno,
                                                   LDadosRequisicao);

      If MatchStr(LStatus.ToString, ['200', '201']) Then
        Self.FTentarNovamente := False;

      LRequisicaoAlteraBoleto.LJsoRec := LRetorno;

      If DeveLimparOsDadosDoBoletoCancelamento(LStatus, LRetorno) Then
      Begin
        fStartTransaction;
        untFuncAutban.LimpaDadosBoleto(ADataSet.FieldByName('AUTOINCREM').AsString);

        untLogCtr.GravaLogCtr(ADataSet.FieldByName('AUTOINCREM').AsString,
                              'CANCELAMENTO DE BOLETO - BANCO BRADESCO [ONLINE]',
                              'TBancoBradescoAPI');
        fCommit;
      End
      Else
        Raise Exception.Create(RetornaTextoErro(LStatus.ToString, LRetorno));
    Except
      On E: Exception Do
      Begin
        LRequisicaoAlteraBoleto.LExcept := E.Message;
        TfrmGravando.fExecutarModalA(AguardeCincoSegundos,'Falha na comunicação, Nova tentativa em 5 segundos.', '');

        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LParametros);

    FListaRequisicaoRegistroBoleto.Add(LRequisicaoAlteraBoleto);

    FRestSynalist.StatusSemRaise := [];
  End;
end;

function TBancoBradescoAPI.CadastrarNovoBoleto(ADadosDuplicata,
  ADadosCliente: TDataSet; var ANosNum: String): TRetornoBoletoBradesco;
  Var
    LRetornoPost,
    LDadosRequisicao: String;

    LRequisicaoRegistroBoleto: TRequisicaoRegistroBoleto;

    LParametros: TStringList;

    LStatus: Integer;
begin
  Self.FTentarNovamente := True;
  Result := TRetornoBoletoBradesco.Create;
  LRequisicaoRegistroBoleto := TRequisicaoRegistroBoleto.Create;

  LRequisicaoRegistroBoleto.LCartei :=  FDadosCarteira.CarteiraCompleta;
  LRequisicaoRegistroBoleto.LCodBco := '237';
  LRequisicaoRegistroBoleto.LLocImp := IIF(Self.FFaturamento,'FAT','CTR');

  LDadosRequisicao := RetornaDadosDaRequisicao(ADadosDuplicata,
                                               ADadosCliente,
                                               ANosNum);

  LRequisicaoRegistroBoleto.LJsoEnv := LDadosRequisicao;
  LRequisicaoRegistroBoleto.LDuplic := ADadosDuplicata.FieldByName('AUTOINCREM').AsString;
  LRequisicaoRegistroBoleto.LLnkApi := FDadosCarteira.LinkInclusao;
  LRequisicaoRegistroBoleto.FDescricao := 'REGISTRO';

  LRequisicaoRegistroBoleto.FRequisicao := LDadosRequisicao;

  LParametros := TStringList.Create;

  FNossoNumeroDuplicado := False;

  Try
    Try
      GerarToken;

      LParametros.Add('Authorization: ' + FTokenUsoAtual);
      LParametros.Add('Accept: application/json');
      
      LStatus := FRestSynalist.ExecuteRestSynalist('POST',
                                                   FDadosCarteira.LinkInclusao,
                                                   LParametros,
                                                   LRetornoPost,
                                                   LDadosRequisicao);

      If Not MatchStr(LStatus.ToString, ['200', '201']) Then
        Raise Exception.Create(LRetornoPost);

      Self.FTentarNovamente := False;

      LRequisicaoRegistroBoleto.LJsoRec := LRetornoPost;

      Result := RetornaDadosRetornoInclusaoBoleto(LRetornoPost,
                                                  ANosNum);

      ANosNum := fStrZero(Result.NuTituloGerado.ToString, 11);

      If Not Result.QrCodeEmv.IsEmpty Then
      Begin
        Try
          Result.QrCodeLinkCitel := TFuncoesPixBoleto.IncluirLinkCitelPixBoleto('237',
                                                                                Result.QrCodeTxId,
                                                                                Result.QrCodeEmv,
                                                                                FormatFloat(',0.00', RetornaValorDuplicata(ADadosDuplicata)),
                                                                                FDadosCarteira.AutoIncremChavePix,
                                                                                IncDay(ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime,
                                                                                       StrToIntDef(FDadosCarteira.QtdDiasLimitePagto, 0)) + StrToTime('23:59:59'));
        Except
          Result.QrCodeLinkCitel := EmptyStr;
        End;
      End;

      AtualizaDadosExportacaoRemessa(ADadosDuplicata,
                                     Result);
    Except

      On E: Exception Do
      Begin
        LRequisicaoRegistroBoleto.LExcept := E.Message;

        LStatus := AtualizaStatusRetornoErro(LStatus,
                                             E.Message);

        If MatchStr(LStatus.ToString, ['0', '400']) Then
          FNossoNumeroDuplicado := (E.Message.Contains('TITULO JA CADASTRADO') Or
                                    E.Message.Contains('NOSSO NUMERO JA UTILIZADO'));

        Raise Exception.Create(RetornaTextoErro(LStatus.ToString, E.Message));
      End;
    End;
  Finally
    FListaRequisicaoRegistroBoleto.Add(LRequisicaoRegistroBoleto);
    FreeAndNil(LParametros);
  End;
end;

procedure TBancoBradescoAPI.CancelarBoletos(ADataSet: TDataSet);
  Var
    LDocumentosRestantes: String;

    LErroAPI: Boolean;

    LContadorTentativas: Integer;
begin
  Try
    LContadorTentativas := 1;
    LErroAPI := False;
    ADataSet.First;

    frmGravandoGenericProcedure.pgbStatus.Visible := True;
    frmGravandoGenericProcedure.pgbStatus.Position := 0;
    frmGravandoGenericProcedure.pgbStatus.Properties.Max := ADataSet.RecordCount;


    While (LContadorTentativas <= 2) Do
    Begin
      Try

        While Not ADataSet.Eof Do
        Begin
          BaixaBoletoRegistrado(ADataSet);

          ADataSet.Next;

          pStep(frmGravandoGenericProcedure.pgbStatus);
          LContadorTentativas := 0;
        End;

        LErroAPI := False;

      Except
        On E:Exception Do
        begin
          LErroAPI := True;


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

            Raise Exception.Create('Ocorreram erros ao cancelar o(s) boleto(s) no Banco Bradesco [Online].' + #13 +
                                   'Erro gerado: ' + E.Message + #13 +
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

    frmGravandoGenericProcedure.pgbStatus.Visible := False;
  Finally
    GravarDadosRequisicaoRegistroBoleto;
  End
end;

procedure TBancoBradescoAPI.CarregaDadosBeneficiario(
  var ADadosRequisicao: TJsonObject);
  Var
    LCNPJEmpresa,
    LCNPJString: String;
begin
  LCNPJEmpresa := FDadosCarteira.DadosEmpresa.FieldByName('EMP_C_G_C_').AsString.Replace('.', EmptyStr)
                                                                                .Replace('/', EmptyStr)
                                                                                .Replace('-', EmptyStr);

  If FDadosCarteira.UsaSacadorAvalista.Equals('S') Then
  Begin
    LCNPJString := FDadosCarteira.CNPJBeneficiario.Replace('.', EmptyStr)
                                                  .Replace('/', EmptyStr)
                                                  .Replace('-', EmptyStr);

    ADadosRequisicao.AddPair('nuCPFCNPJ', RetornaDadosJsonNumber(LeftStr(LCNPJString, 8), 8));
    ADadosRequisicao.AddPair('filialCPFCNPJ', RetornaDadosJsonNumber(Copy(LCNPJString, 9, 4), 4));
    ADadosRequisicao.AddPair('ctrlCPFCNPJ', RetornaDadosJsonNumber(RightStr(LCNPJString, 2), 2));

    ADadosRequisicao.AddPair('nomeSacadorAvalista', RetornaDadosString(FDadosCarteira.DadosEmpresa.FieldByName('EMP_NOMEMP').AsString, 40));
    ADadosRequisicao.AddPair('logradouroSacadorAvalista', RetornaDadosString(FDadosCarteira.DadosEmpresa.FieldByName('EMP_ENDERE').AsString, 40));
    ADadosRequisicao.AddPair('nuLogradouroSacadorAvalista', RetornaDadosString(IfEmptyStr(fRetSomenteNumeros(FDadosCarteira.DadosEmpresa.FieldByName('EMP_ENDNUM').AsString), '0'), 10));
    ADadosRequisicao.AddPair('complementoLogradouroSacadorAvalista', RetornaDadosString(FDadosCarteira.DadosEmpresa.FieldByName('EMP_ENDCMP').AsString, 15));
    ADadosRequisicao.AddPair('cepSacadorAvalista', RetornaDadosJsonNumber(LeftStr(fRetSomenteNumeros(FDadosCarteira.DadosEmpresa.FieldByName('EMP_C_E_P_').AsString), 5)));
    ADadosRequisicao.AddPair('complementoCepSacadorAvalista', RetornaDadosJsonNumber(RightStr(fRetSomenteNumeros(FDadosCarteira.DadosEmpresa.FieldByName('EMP_C_E_P_').AsString), 3)));
    ADadosRequisicao.AddPair('bairroSacadorAvalista', RetornaDadosString(FDadosCarteira.DadosEmpresa.FieldByName('EMP_BAIRRO').AsString, 40));
    ADadosRequisicao.AddPair('municipioSacadorAvalista', RetornaDadosString(FDadosCarteira.DadosEmpresa.FieldByName('CID_NOMCID').AsString, 40));
    ADadosRequisicao.AddPair('ufSacadorAvalista', RetornaDadosString(FDadosCarteira.DadosEmpresa.FieldByName('CID_ESTADO').AsString, 2));
    ADadosRequisicao.AddPair('cdIndCpfcnpjSacadorAvalista', RetornaDadosJsonNumber('2'));
    ADadosRequisicao.AddPair('nuCpfcnpjSacadorAvalista', RetornaDadosJsonNumber(LCNPJEmpresa, 14));

    Exit;
  End;

  ADadosRequisicao.AddPair('nuCPFCNPJ', RetornaDadosJsonNumber(LeftStr(LCNPJEmpresa, 8), 8));
  ADadosRequisicao.AddPair('filialCPFCNPJ', RetornaDadosJsonNumber(Copy(LCNPJEmpresa, 9, 4), 4));
  ADadosRequisicao.AddPair('ctrlCPFCNPJ', RetornaDadosJsonNumber(RightStr(LCNPJEmpresa, 2), 2));
end;

procedure TBancoBradescoAPI.CarregaDadosBeneficiarioBoleCode(
  var ADadosRequisicao: TJsonObject);
  Var
    LCNPJEmpresa,
    LCNPJString: String;
begin
  LCNPJEmpresa := FDadosCarteira.DadosEmpresa.FieldByName('EMP_C_G_C_').AsString.Replace('.', EmptyStr)
                                                                                .Replace('/', EmptyStr)
                                                                                .Replace('-', EmptyStr);

  If FDadosCarteira.UsaSacadorAvalista.Equals('S') Then
  Begin
    LCNPJString := FDadosCarteira.CNPJBeneficiario.Replace('.', EmptyStr)
                                                  .Replace('/', EmptyStr)
                                                  .Replace('-', EmptyStr);

    ADadosRequisicao.AddPair('nroCpfCnpjBenef', RetornaDadosJsonNumber(LeftStr(LCNPJString, 8), 8));
    ADadosRequisicao.AddPair('filCpfCnpjBenef', RetornaDadosJsonNumber(Copy(LCNPJString, 9, 4), 4));
    ADadosRequisicao.AddPair('digCpfCnpjBenef', RetornaDadosJsonNumber(RightStr(LCNPJString, 2), 2));

    ADadosRequisicao.AddPair('isacdrAvalsTitlo', RetornaDadosString(FDadosCarteira.DadosEmpresa.FieldByName('EMP_NOMEMP').AsString, 40));
    ADadosRequisicao.AddPair('elogdrSacdrAvals', RetornaDadosString(FDadosCarteira.DadosEmpresa.FieldByName('EMP_ENDERE').AsString, 40));
    ADadosRequisicao.AddPair('ecomplLogdrSacdr', RetornaDadosString(FDadosCarteira.DadosEmpresa.FieldByName('EMP_ENDCMP').AsString, 15));
    ADadosRequisicao.AddPair('ccepSacdrTitlo', LeftStr(fRetSomenteNumeros(FDadosCarteira.DadosEmpresa.FieldByName('EMP_C_E_P_').AsString), 5));
    ADadosRequisicao.AddPair('ccomplCepSacdr', RightStr(fRetSomenteNumeros(FDadosCarteira.DadosEmpresa.FieldByName('EMP_C_E_P_').AsString), 3));
    ADadosRequisicao.AddPair('ebairoLogdrSacdr', RetornaDadosString(FDadosCarteira.DadosEmpresa.FieldByName('EMP_BAIRRO').AsString, 40));
    ADadosRequisicao.AddPair('imunSacdrAvals', RetornaDadosString(FDadosCarteira.DadosEmpresa.FieldByName('CID_NOMCID').AsString, 40));
    ADadosRequisicao.AddPair('csglUfSacdr', RetornaDadosString(FDadosCarteira.DadosEmpresa.FieldByName('CID_ESTADO').AsString, 2));
    ADadosRequisicao.AddPair('indCpfCnpjSacdr', '2');
    ADadosRequisicao.AddPair('nroCpfCnpjSacdr', RetornaDadosJsonNumber(LCNPJEmpresa, 14));

    Exit;
  End;

  ADadosRequisicao.AddPair('nroCpfCnpjBenef', RetornaDadosJsonNumber(LeftStr(LCNPJEmpresa, 8), 8));
  ADadosRequisicao.AddPair('filCpfCnpjBenef', RetornaDadosJsonNumber(Copy(LCNPJEmpresa, 9, 4), 4));
  ADadosRequisicao.AddPair('digCpfCnpjBenef', RetornaDadosJsonNumber(RightStr(LCNPJEmpresa, 2), 2));
end;

procedure TBancoBradescoAPI.CarregaDadosCarteira(ACarteira: String);
  Const
    SQL_EMPRESA: String = 'SELECT EMP_NOMEMP, ' +
                          '       EMP_C_G_C_, ' +
                          '       EMP_ENDERE, ' +
                          '       EMP_BAIRRO, ' +
                          '       EMP_ENDNUM, ' +
                          '       EMP_ENDCMP, ' +
                          '       EMP_C_E_P_, ' +
                          '       CID_NOMCID, ' +
                          '       CID_ESTADO  ' +
                          'FROM CADEMP ' +
                          'JOIN CADCID ON CID_CODCID=EMP_CODCID ' +
                          'WHERE EMP_CODEMP=:CODEMP';

    SQL_CHAVEPIX: String = 'SELECT PIX_TIPCHV, ' +
                           '       PIX_CHAVE_  ' +
                           'FROM CCAPIX ' +
                           'WHERE AUTOINCREM=:AUTINC';
begin
  FDadosCarteira.CarteiraBanco := LeftStr(ACarteira,14);
  FDadosCarteira.EmpresaCarteira := RightStr(ACarteira, 3);
  FDadosCarteira.CarteiraCompleta := ACarteira;

  FDadosCarteira.CodCedente := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'CODEMPR', '');
  FDadosCarteira.CodCarteira := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'CODCART', '');
  FDadosCarteira.Agencia := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'CODAGEN', '');
  FDadosCarteira.ContaCorrente := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'NUMCTAC', '');
  FDadosCarteira.DAC := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'DIGCTAC', '');
  FDadosCarteira.NumeroAutorizacao := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'NUMAUTO', '');
  FDadosCarteira.QtdDiasProtesto := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'DIAPROT', '');

  FDadosCarteira.Instrucao01 := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'INSTRU1', '');
  FDadosCarteira.InstrucaoPersonalizada := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'INSTPER', '');

  FDadosCarteira.Observacao1 := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'OBSERV1', '');
  FDadosCarteira.Observacao2 := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'OBSERV2', '');
  FDadosCarteira.Observacao3 := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'OBSERV3', '');
  FDadosCarteira.Observacao4 := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'OBSERV4', '');
  FDadosCarteira.Observacao5 := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'OBSERV5', '');
  FDadosCarteira.TipoCobranca := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'TIPCOBR', '');
  FDadosCarteira.PortadorBaixa := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'PORBAI_', '');
  FDadosCarteira.PlanoDeContasBaixa := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'CTABAI_', '');
  FDadosCarteira.QtdDiasCredito := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'DIACRED', '');
  FDadosCarteira.Aceite := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'PROACEI', '');
  FDadosCarteira.DigAgencia := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'DIGAGEN', '');
  FDadosCarteira.PercenMulta := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'PERMULT', '');
  FDadosCarteira.QtdDiasLimitePagto := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'DIALIMI', '');

  FDadosCarteira.UsaSacadorAvalista := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'SACAVAL', '');
  FDadosCarteira.NomeBeneficiario := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'NOMEBEN', '');
  FDadosCarteira.EnderecoBeneficiario := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'ENDEBEN', '');
  FDadosCarteira.BairroBeneficiario := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'BAIRBEN', '');
  FDadosCarteira.ComplementoBeneficiario := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'COMPBEN', '');
  FDadosCarteira.CidadeBeneficiario := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'CIDABEN', '');
  FDadosCarteira.CidadeBeneficiario := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'ESTABEN', '');
  FDadosCarteira.CEPBeneficiario := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'CEP_BEN', '');
  FDadosCarteira.CNPJBeneficiario := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'CNPJBEN', '');

  FDadosCarteira.EspDocumento := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'ESPDOCBOL', '');

  //sim, de propósito, isso tem um motivo
  FDadosCarteira.ImportarEmpresas := 'N'; //fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'IMPORTEMP', '');
  FDadosCarteira.BaixarBoletosGeradoPorArquivo := 'N'; //fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'BAIBOLARQ', '');

  FDadosCarteira.CertificadoPfx := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'AUTHPFX', '');
  FDadosCarteira.SenhaCertificado := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'SENCERT', '');

  FDadosCarteira.ClientId := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'CLIENT_ID', '');
  FDadosCarteira.ClientSecret := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'CLIENT_SECRET', '');

  FDadosCarteira.Homologacao := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'HOMOLOGACAO', '');

  FDadosCarteira.GerarQRCodePix := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'GERAPIX', '');
  FDadosCarteira.AutoIncremChavePix := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'CHAPIX', '');

  FDadosCarteira.EmpresaConta := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'EMPCONT', '');
  If FDadosCarteira.EmpresaConta.IsEmpty Then
    FDadosCarteira.EmpresaConta := FDadosCarteira.EmpresaCarteira;

  FDadosCarteira.DadosEmpresa := fCriaQuery;
  FDadosCarteira.DadosEmpresa.SQL.Text := SQL_EMPRESA;
  FDadosCarteira.DadosEmpresa.ParamByName('CODEMP').AsString := FDadosCarteira.EmpresaConta;
  FDadosCarteira.DadosEmpresa.Open;

  FDadosCarteira.DadosChavePix := fCriaQuery;
  If Not FDadosCarteira.AutoIncremChavePix.IsEmpty Then
  Begin
    FDadosCarteira.DadosChavePix.SQL.Text := SQL_CHAVEPIX;
    FDadosCarteira.DadosChavePix.ParamByName('AUTINC').AsString := FDadosCarteira.AutoIncremChavePix;
    FDadosCarteira.DadosChavePix.Open;
  End;

  FRestSynalist.CarregaCertificados(FDadosCarteira.CarteiraCompleta,
                                    FDadosCarteira.CertificadoPfx,
                                    EmptyStr,
                                    EmptyStr,
                                    FDadosCarteira.SenhaCertificado);
end;

procedure TBancoBradescoAPI.CarregaDadosDescontos(
  var ADadosRequisicao: TJsonObject; ADadosDuplicata, ADadosCliente: TDataset);
  Var
    LDescontoSugerido,
    LDescontoPontualidade: Double;

    LDataDesconto: TDateTime;

    LUtilizaDescontos: Boolean;

    LCampoCriar,
    LInstrucao: String;
begin
  LInstrucao := RetornaInstrucaoCarteira(ADadosCliente);

  LDescontoSugerido := ADadosDuplicata.FieldByName('CTR_DESSUJ').AsFloat;

  If fCfgSis('DESBOL', varBoolean, FDadosCarteira.EmpresaCarteira) Then
    LDescontoSugerido := 0.00;

  LUtilizaDescontos := LDescontoSugerido > 0;

  LDataDesconto := 0;
  LDescontoPontualidade := 0;

  If UtilizaDescontoDePontualidade(ADadosDuplicata.FieldByName('CTR_PERDPO').AsFloat) Then
  Begin
    LDescontoPontualidade := ADadosDuplicata.FieldByName('CTR_PERDPO').AsFloat;

    If LDescontoPontualidade > 0 Then
    Begin
      LDataDesconto := IncDay(ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime,
                              -ADadosDuplicata.FieldByName('CTR_QTDDAV').AsInteger);

      LUtilizaDescontos := True;
    End;
  End;

  If Not LUtilizaDescontos Then
    Exit;

  LCampoCriar := 'vlDesconto1|dataLimiteDesconto1';

  If LDescontoSugerido > 0 Then
  Begin
    ADadosRequisicao.AddPair(LCampoCriar.Split(['|'])[0], RetornaValorDecimalJsonParaTJsonNumber(LDescontoSugerido));

    If Not LInstrucao.Equals('15') Then
      ADadosRequisicao.AddPair(LCampoCriar.Split(['|'])[1], FormatDateTime('dd.mm.yyyy', ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime))
    Else
      ADadosRequisicao.AddPair(LCampoCriar.Split(['|'])[1], FormatDateTime('dd.mm.yyyy', IncDay(ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime, StrToIntDef(FDadosCarteira.QtdDiasLimitePagto, 0))));

    LCampoCriar := 'vlDesconto2|dataLimiteDesconto2';
  End;

  If LDescontoPontualidade > 0 Then
  Begin
    ADadosRequisicao.AddPair(LCampoCriar.Split(['|'])[0], RetornaValorDecimalJsonParaTJsonNumber(fFormataFloat(RetornaValorDuplicata(ADadosDuplicata) *
                                                                                                     (LDescontoPontualidade / 100), 2)));

    ADadosRequisicao.AddPair(LCampoCriar.Split(['|'])[1], FormatDateTime('dd.mm.yyyy', LDataDesconto));
  End;
end;

procedure TBancoBradescoAPI.CarregaDadosDescontosBoleCode(
  var ADadosRequisicao: TJsonObject; ADadosDuplicata, ADadosCliente: TDataset);
  Var
    LDescontoSugerido,
    LDescontoPontualidade: Double;

    LDataDesconto: TDateTime;

    LUtilizaDescontos: Boolean;

    LCampoCriar,
    LInstrucao: String;
begin
  LInstrucao := RetornaInstrucaoCarteira(ADadosCliente);

  LDescontoSugerido := ADadosDuplicata.FieldByName('CTR_DESSUJ').AsFloat;

  If fCfgSis('DESBOL', varBoolean, FDadosCarteira.EmpresaCarteira) Then
    LDescontoSugerido := 0.00;

  LUtilizaDescontos := LDescontoSugerido > 0;

  LDataDesconto := 0;
  LDescontoPontualidade := 0;

  If UtilizaDescontoDePontualidade(ADadosDuplicata.FieldByName('CTR_PERDPO').AsFloat) Then
  Begin
    LDescontoPontualidade := ADadosDuplicata.FieldByName('CTR_PERDPO').AsFloat;

    If LDescontoPontualidade > 0 Then
    Begin
      LDataDesconto := IncDay(ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime,
                              -ADadosDuplicata.FieldByName('CTR_QTDDAV').AsInteger);

      LUtilizaDescontos := True;
    End;
  End;

  If Not LUtilizaDescontos Then
    Exit;

  LCampoCriar := 'vdescBonifPgto01|dlimDescBonif1';

  If LDescontoSugerido > 0 Then
  Begin
    ADadosRequisicao.AddPair(LCampoCriar.Split(['|'])[0], RetornaDadosJsonNumber(FormatFloat('0.00', LDescontoSugerido).Replace(',', EmptyStr), 17));

    If Not LInstrucao.Equals('15') Then
      ADadosRequisicao.AddPair(LCampoCriar.Split(['|'])[1], FormatDateTime('dd.mm.yyyy', ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime))
    Else
      ADadosRequisicao.AddPair(LCampoCriar.Split(['|'])[1], FormatDateTime('dd.mm.yyyy', IncDay(ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime, StrToIntDef(FDadosCarteira.QtdDiasLimitePagto, 0))));

    LCampoCriar := 'vdescBonifPgto02|dlimDescBonif2';
  End;

  If LDescontoPontualidade > 0 Then
  Begin
    ADadosRequisicao.AddPair(LCampoCriar.Split(['|'])[0], RetornaDadosJsonNumber(FormatFloat('0.00',
                                                                                 RetornaValorDuplicata(ADadosDuplicata) *
                                                                                                      (LDescontoPontualidade / 100))
                                                                                                      .Replace(',', EmptyStr), 17));

    ADadosRequisicao.AddPair(LCampoCriar.Split(['|'])[1], FormatDateTime('dd.mm.yyyy', LDataDesconto));
  End;
end;

procedure TBancoBradescoAPI.CarregaDadosDoTitulo(
  var ADadosRequisicao: TJsonObject; ADadosDuplicata: TDataset; ANosNum: String);
  Var
    LNossoNumeroInteger: Int64;
begin
  If TryStrToInt64(ANosNum, LNossoNumeroInteger) Then
    ADadosRequisicao.AddPair('nuTitulo', LNossoNumeroInteger.ToString)
  Else
    ADadosRequisicao.AddPair('nuTitulo', '');

  ADadosRequisicao.AddPair('nuCliente', RightStr(ADadosDuplicata.FieldByName('CTR_NUMDUP').AsString +
                                                 ADadosDuplicata.FieldByName('CTR_PARCEL').AsString, 10));
  ADadosRequisicao.AddPair('dtEmissaoTitulo', FormatDateTime('dd.mm.yyyy', ADadosDuplicata.FieldByName('CTR_DTACAD').AsDateTime));
  ADadosRequisicao.AddPair('dtVencimentoTitulo', FormatDateTime('dd.mm.yyyy', ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime));

  ADadosRequisicao.AddPair('vlNominalTitulo', RetornaValorDecimalJsonParaTJsonNumber(RetornaValorDuplicata(ADadosDuplicata)));

  ADadosRequisicao.AddPair('cdEspecieTitulo', RetornaDadosJsonNumber('2'));

  ADadosRequisicao.AddPair('controleParticipante', ADadosDuplicata.FieldByName('CTR_NUMDUP').AsString +
                                                   fPadR(ADadosDuplicata.FieldByName('CTR_PARCEL').AsString, 03, ' ') +
                                                   ADadosDuplicata.FieldByName('CTR_ESPDOC').AsString +
                                                   ADadosDuplicata.FieldByName('CTR_CODEMP').AsString);

  ADadosRequisicao.AddPair('cdPagamentoParcial', 'N');
end;

procedure TBancoBradescoAPI.CarregaDadosDoTituloBoleCode(
  var ADadosRequisicao: TJsonObject; ADadosDuplicata: TDataset; ANosNum: String);
  Var
    LNossoNumeroInteger: Int64;
begin
  If TryStrToInt64(ANosNum, LNossoNumeroInteger) Then
    ADadosRequisicao.AddPair('ctitloCobrCdent', LNossoNumeroInteger.ToString)
  Else
    ADadosRequisicao.AddPair('ctitloCobrCdent', '');

  ADadosRequisicao.AddPair('ctitloCliCdent', RightStr(ADadosDuplicata.FieldByName('CTR_NUMDUP').AsString +
                                                      ADadosDuplicata.FieldByName('CTR_PARCEL').AsString, 15));
  ADadosRequisicao.AddPair('demisTitloCobr', FormatDateTime('dd.mm.yyyy', ADadosDuplicata.FieldByName('CTR_DTACAD').AsDateTime));
  ADadosRequisicao.AddPair('dvctoTitloCobr', FormatDateTime('dd.mm.yyyy', ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime));
  ADadosRequisicao.AddPair('cindcdEconmMoeda', RetornaDadosJsonNumber('6'));

  If Not FDadosCarteira.Homologacao.Equals('S') Then
    ADadosRequisicao.AddPair('qtdDecurPrz', RetornaDadosJsonNumber(FDadosCarteira.QtdDiasLimitePagto));

  ADadosRequisicao.AddPair('vnmnalTitloCobr', FormatFloat(',0.00', RetornaValorDuplicata(ADadosDuplicata))
                                                                                                    .Replace(',', EmptyStr)
                                                                                                    .Replace('.', EmptyStr));

  ADadosRequisicao.AddPair('cespceTitloCobr', RetornaDadosJsonNumber('2'));
  ADadosRequisicao.AddPair('cformaEmisPplta', RetornaDadosJsonNumber('2'));

  ADadosRequisicao.AddPair('cctrlPartcTitlo', ADadosDuplicata.FieldByName('CTR_NUMDUP').AsString +
                                             fPadR(ADadosDuplicata.FieldByName('CTR_PARCEL').AsString, 03, ' ') +
                                             ADadosDuplicata.FieldByName('CTR_ESPDOC').AsString +
                                             ADadosDuplicata.FieldByName('CTR_CODEMP').AsString);

  ADadosRequisicao.AddPair('cindcdPgtoParcial', 'N');
  ADadosRequisicao.AddPair('cindcdAceitSacdo', 'N');
end;

procedure TBancoBradescoAPI.CarregaDadosJuros(var ADadosRequisicao: TJsonObject;
  ADadosDuplicata, ADadosCliente: TDataset);
  Var
    LInstrucao,
    LDiasJuros: String;

    LPercentualJuros: Double;
begin
  LInstrucao := RetornaInstrucaoCarteira(ADadosCliente);

  LDiasJuros := '1';
  LPercentualJuros := fFormataFloat(Self.FPercentualMora, 2);

  If LInstrucao.Equals('08') Then
  Begin
    LDiasJuros := '0';
    LPercentualJuros := 0.00;
  End;

  ADadosRequisicao.AddPair('percentualJuros', TJSONNumber.Create('0.00'));
  ADadosRequisicao.AddPair('qtdeDiasJuros', RetornaDadosJsonNumber(LDiasJuros));
  ADadosRequisicao.AddPair('vlJuros',  RetornaValorDecimalJsonParaTJsonNumber(RetornaValorDuplicata(ADadosDuplicata) * (LPercentualJuros / 100)));
end;

procedure TBancoBradescoAPI.CarregaDadosJurosBoleCode(
  var ADadosRequisicao: TJsonObject; ADadosDuplicata, ADadosCliente: TDataset);
  Var
    LInstrucao,
    LDiasJuros,
    LValorDiarioJuros: String;
begin
  LInstrucao := RetornaInstrucaoCarteira(ADadosCliente);

  LDiasJuros := '1';
  LValorDiarioJuros := FormatFloat('0.00', RetornaValorDuplicata(ADadosDuplicata) * (fFormataFloat(Self.FPercentualMora, 5) / 100)).Replace('.', EmptyStr).Replace(',', EmptyStr);

  If LInstrucao.Equals('08') Then
  Begin
    LDiasJuros := '0';
    LValorDiarioJuros := '0';
  End;

  ADadosRequisicao.AddPair('ptxJuroVcto', RetornaDadosJsonNumber('0'));
  ADadosRequisicao.AddPair('qdiaInicJuro', RetornaDadosJsonNumber(LDiasJuros));
  ADadosRequisicao.AddPair('vdiaJuroMora', LValorDiarioJuros);
end;

procedure TBancoBradescoAPI.CarregaDadosMensagens(
  var ADadosRequisicao: TJsonObject);
  Var
    LJsonArray: TJsonArray;

    LJsonObject: TJsonObject;
begin
  LJsonArray := TJsonArray.Create;

  LJsonObject := TJsonObject.Create;
  LJsonObject.AddPair('mensagem', TJSONString.Create(LeftStr(FDadosCarteira.Observacao1.Trim, 60)));
  LJsonArray.AddElement(LJsonObject);

  LJsonObject := TJsonObject.Create;
  LJsonObject.AddPair('mensagem', TJSONString.Create(LeftStr(FDadosCarteira.Observacao2.Trim, 60)));
  LJsonArray.AddElement(LJsonObject);

  If Not FDadosCarteira.Observacao3.Trim.IsEmpty Then
  Begin
    LJsonObject := TJsonObject.Create;
    LJsonObject.AddPair('mensagem', TJSONString.Create(LeftStr(FDadosCarteira.Observacao3.Trim, 60)));
    LJsonArray.Add(LJsonObject);
  End;

  If Not FDadosCarteira.Observacao4.Trim.IsEmpty Then
  Begin
    LJsonObject := TJsonObject.Create;
    LJsonObject.AddPair('mensagem', TJSONString.Create(LeftStr(FDadosCarteira.Observacao4.Trim, 60)));
    LJsonArray.Add(LJsonObject);
  End;

  If Not FDadosCarteira.Observacao5.Trim.IsEmpty Then
  Begin
    LJsonObject := TJsonObject.Create;
    LJsonObject.AddPair('mensagem', TJSONString.Create(LeftStr(FDadosCarteira.Observacao5.Trim, 60)));
    LJsonArray.Add(LJsonObject);
  End;

  ADadosRequisicao.Addpair('listaMsgs', LJsonArray);
end;

procedure TBancoBradescoAPI.CarregaDadosMulta(var ADadosRequisicao: TJsonObject;
  ADadosDuplicata: TDataset);
begin
  If fFormataFloat(Self.FPercentualMulta, 3) = 0 Then
    Exit;

  ADadosRequisicao.AddPair('percentualMulta', RetornaValorDecimalJsonParaTJsonNumber(fFormataFloat(Self.FPercentualMulta, 2)));
  ADadosRequisicao.AddPair('qtdeDiasMulta', RetornaDadosJsonNumber('1'));
end;

procedure TBancoBradescoAPI.CarregaDadosMultaBoleCode(
  var ADadosRequisicao: TJsonObject; ADadosDuplicata: TDataset);
begin
  If fFormataFloat(Self.FPercentualMulta, 3) = 0 Then
    Exit;

  ADadosRequisicao.AddPair('pmultaAplicVcto', FormatFloat('0.00000', fFormataFloat(Self.FPercentualMulta, 5)).Replace(',', '.'));
  ADadosRequisicao.AddPair('qdiaInicMulta', RetornaDadosJsonNumber('1'));
end;

procedure TBancoBradescoAPI.CarregaDadosPagador(
  var ADadosRequisicao: TJsonObject; ADadosCliente: TDataset);
begin
  ADadosRequisicao.AddPair('nomePagador', RetornaDadosString(ADadosCliente.FieldByName('CLI_NOMCLI').AsString, 70));
  ADadosRequisicao.AddPair('logradouroPagador', RetornaDadosString(ADadosCliente.FieldByName('CLI_ENDERE').AsString, 40));
  ADadosRequisicao.AddPair('nuLogradouroPagador', LeftStr(IfEmptyStr(fRetSomenteNumeros(ADadosCliente.FieldByName('CLI_ENDNUM').AsString), '0'), 10));
  ADadosRequisicao.AddPair('complementoLogradouroPagador', RetornaDadosString(ADadosCliente.FieldByName('CLI_ENDCOM').AsString, 15));
  ADadosRequisicao.AddPair('cepPagador', RetornaDadosJsonNumber(LeftStr(fRetSomenteNumeros(ADadosCliente.FieldByName('CLI_C_E_P_').AsString), 5)));
  ADadosRequisicao.AddPair('complementoCepPagador', RetornaDadosJsonNumber(RightStr(fRetSomenteNumeros(ADadosCliente.FieldByName('CLI_C_E_P_').AsString), 3)));
  ADadosRequisicao.AddPair('bairroPagador', RetornaDadosString(ADadosCliente.FieldByName('CLI_BAIRRO').AsString, 40));
  ADadosRequisicao.AddPair('municipioPagador', RetornaDadosString(ADadosCliente.FieldByName('CID_NOMCID').AsString, 30));
  ADadosRequisicao.AddPair('ufPagador', RetornaDadosString(ADadosCliente.FieldByName('CID_ESTADO').AsString, 2));
  ADadosRequisicao.AddPair('cdIndCpfcnpjPagador',RetornaDadosJsonNumber(IIF(fRetSomenteNumeros(ADadosCliente.FieldByName('CLI_C_G_C_').AsString).Length < 14, '1', '2')));
  ADadosRequisicao.AddPair('nuCpfcnpjPagador', RetornaDadosJsonNumber(ADadosCliente.FieldByName('CLI_C_G_C_').AsString.Replace('.', EmptyStr)
                                                                                                     .Replace('/', EmptyStr)
                                                                                                     .Replace('-', EmptyStr)));
end;

procedure TBancoBradescoAPI.CarregaDadosPagadorBoleCode(
  var ADadosRequisicao: TJsonObject; ADadosCliente: TDataset);
begin
  ADadosRequisicao.AddPair('isacdoTitloCobr', RetornaDadosString(ADadosCliente.FieldByName('CLI_NOMCLI').AsString, 70));
  ADadosRequisicao.AddPair('elogdrSacdoTitlo', RetornaDadosString(ADadosCliente.FieldByName('CLI_ENDERE').AsString, 40));
  ADadosRequisicao.AddPair('enroLogdrSacdo', RetornaDadosJsonNumber(IfEmptyStr(fRetSomenteNumeros(ADadosCliente.FieldByName('CLI_ENDNUM').AsString), '0'), 10));
  ADadosRequisicao.AddPair('ecomplLogdrSacdo', RetornaDadosString(ADadosCliente.FieldByName('CLI_ENDCOM').AsString, 15));
  ADadosRequisicao.AddPair('ccepSacdoTitlo', RetornaDadosJsonNumber(LeftStr(fRetSomenteNumeros(ADadosCliente.FieldByName('CLI_C_E_P_').AsString), 5), 5));
  ADadosRequisicao.AddPair('ccomplCepSacdo', RetornaDadosJsonNumber(RightStr(fRetSomenteNumeros(ADadosCliente.FieldByName('CLI_C_E_P_').AsString), 3), 3));
  ADadosRequisicao.AddPair('ebairoLogdrSacdo', RetornaDadosString(ADadosCliente.FieldByName('CLI_BAIRRO').AsString, 40));
  ADadosRequisicao.AddPair('imunSacdoTitlo', RetornaDadosString(ADadosCliente.FieldByName('CID_NOMCID').AsString, 30));
  ADadosRequisicao.AddPair('csglUfSacdo', RetornaDadosString(ADadosCliente.FieldByName('CID_ESTADO').AsString, 2));
  ADadosRequisicao.AddPair('indCpfCnpjSacdo', RetornaDadosJsonNumber(IIF(fRetSomenteNumeros(ADadosCliente.FieldByName('CLI_C_G_C_').AsString).Length < 14, '1', '2')));
  ADadosRequisicao.AddPair('nroCpfCnpjSacdo', RetornaDadosJsonNumber(ADadosCliente.FieldByName('CLI_C_G_C_').AsString.Replace('.', EmptyStr)
                                                                                                                     .Replace('/', EmptyStr)
                                                                                                                     .Replace('-', EmptyStr)));
end;

procedure TBancoBradescoAPI.CarregaDadosPixBoleCode(
  var ADadosRequisicao: TJsonObject);
begin
  ADadosRequisicao.AddPair('cindcdCobrMisto', 'S');
end;

procedure TBancoBradescoAPI.CarregaDadosProtesto(
  var ADadosRequisicao: TJsonObject; ADadosDuplicata, ADadosCliente: TDataset);
  Var
    LInstrucao,
    LDiasProtesto: String;
begin
  LInstrucao := RetornaInstrucaoCarteira(ADadosCliente);
  LDiasProtesto := FDadosCarteira.QtdDiasProtesto;

  If Not MatchStr(LInstrucao, ['05', '06', '07']) Then
    Exit;

  ADadosRequisicao.AddPair('tpProtestoAutomaticoNegativacao', RetornaDadosJsonNumber(IIF(MatchStr(LInstrucao, ['05', '06']), '2', '3')));
  ADadosRequisicao.AddPair('prazoProtestoAutomaticoNegativacao', RetornaDadosJsonNumber(LDiasProtesto));
end;

procedure TBancoBradescoAPI.CarregaDadosProtestoBoleCode(
  var ADadosRequisicao: TJsonObject; ADadosDuplicata, ADadosCliente: TDataset);
  Var
    LInstrucao,
    LDiasProtesto: String;
begin
  LInstrucao := RetornaInstrucaoCarteira(ADadosCliente);
  LDiasProtesto := FDadosCarteira.QtdDiasProtesto;

  If Not MatchStr(LInstrucao, ['05', '06']) Then
  Begin
    ADadosRequisicao.AddPair('tipoRegistro', RetornaDadosJsonNumber('1'));

    Exit;
  End;

  ADadosRequisicao.AddPair('tipoRegistro', RetornaDadosJsonNumber(IIF(LInstrucao.Equals('05'), '3', '2')));
  ADadosRequisicao.AddPair('ctpoProteTitlo', RetornaDadosJsonNumber('1'));
  ADadosRequisicao.AddPair('ctpoPrzProte', RetornaDadosJsonNumber(LDiasProtesto));
  ADadosRequisicao.AddPair('ctpoProteDecurs', RetornaDadosJsonNumber('1'));
end;

procedure TBancoBradescoAPI.CarregarValoresOpcionais(
  var ADadosRequisicao: TJsonObject);
begin
  AdicionaValorOpcional(ADadosRequisicao, 'nuCPFCNPJ', '0');
  AdicionaValorOpcional(ADadosRequisicao, 'filialCPFCNPJ', '0');
  AdicionaValorOpcional(ADadosRequisicao, 'ctrlCPFCNPJ', '0');
  AdicionaValorOpcional(ADadosRequisicao, 'idProduto', '0');
  AdicionaValorOpcional(ADadosRequisicao, 'nuNegociacao', '0');
  AdicionaValorOpcional(ADadosRequisicao, 'nuCliente');
  AdicionaValorOpcional(ADadosRequisicao, 'dtEmissaoTitulo');
  AdicionaValorOpcional(ADadosRequisicao, 'dtVencimentoTitulo');
  AdicionaValorOpcional(ADadosRequisicao, 'vlNominalTitulo', '0.00');
  AdicionaValorOpcional(ADadosRequisicao, 'cdEspecieTitulo', '0', True);
  AdicionaValorOpcional(ADadosRequisicao, 'percentualJuros', '0.00', True);
  AdicionaValorOpcional(ADadosRequisicao, 'vlJuros', '0.00', True);
  AdicionaValorOpcional(ADadosRequisicao, 'qtdeDiasJuros', '0', True);
  AdicionaValorOpcional(ADadosRequisicao, 'percentualMulta', '0.00', True);
  AdicionaValorOpcional(ADadosRequisicao, 'vlMulta', '0.00', True);
  AdicionaValorOpcional(ADadosRequisicao, 'qtdeDiasMulta', '0', True);
  AdicionaValorOpcional(ADadosRequisicao, 'percentualDesconto1', '0.00', True);
  AdicionaValorOpcional(ADadosRequisicao, 'vlDesconto1', '0', True);
  AdicionaValorOpcional(ADadosRequisicao, 'dataLimiteDesconto1');
  AdicionaValorOpcional(ADadosRequisicao, 'nomePagador');
  AdicionaValorOpcional(ADadosRequisicao, 'logradouroPagador');
  AdicionaValorOpcional(ADadosRequisicao, 'nuLogradouroPagador');
  AdicionaValorOpcional(ADadosRequisicao, 'cepPagador', '0');
  AdicionaValorOpcional(ADadosRequisicao, 'complementoCepPagador', '0');
  AdicionaValorOpcional(ADadosRequisicao, 'bairroPagador');
  AdicionaValorOpcional(ADadosRequisicao, 'municipioPagador');
  AdicionaValorOpcional(ADadosRequisicao, 'ufPagador');
  AdicionaValorOpcional(ADadosRequisicao, 'cdIndCpfcnpjPagador', '0', True);
  AdicionaValorOpcional(ADadosRequisicao, 'nuCpfcnpjPagador', '0', True);
  AdicionaValorOpcional(ADadosRequisicao, 'nomeSacadorAvalista');
  AdicionaValorOpcional(ADadosRequisicao, 'logradouroSacadorAvalista');
  AdicionaValorOpcional(ADadosRequisicao, 'nuLogradouroSacadorAvalista');
  AdicionaValorOpcional(ADadosRequisicao, 'complementoLogradouroSacadorAvalista');
  AdicionaValorOpcional(ADadosRequisicao, 'cepSacadorAvalista', '0', True);
  AdicionaValorOpcional(ADadosRequisicao, 'complementoCepSacadorAvalista', '0', True);
  AdicionaValorOpcional(ADadosRequisicao, 'bairroSacadorAvalista');
  AdicionaValorOpcional(ADadosRequisicao, 'municipioSacadorAvalista');
  AdicionaValorOpcional(ADadosRequisicao, 'ufSacadorAvalista');
  AdicionaValorOpcional(ADadosRequisicao, 'cdIndCpfcnpjSacadorAvalista', '0', True);
  AdicionaValorOpcional(ADadosRequisicao, 'nuCpfcnpjSacadorAvalista', '0', True);
  AdicionaValorOpcional(ADadosRequisicao, 'enderecoSacadorAvalista');
  AdicionaValorOpcional(ADadosRequisicao, 'dddFoneSacadorAvalista', '0', True);
  AdicionaValorOpcional(ADadosRequisicao, 'foneSacadorAvalista', '0', True);

  AdicionaValorOpcional(ADadosRequisicao, 'agenciaDoDebAutomatico', '0', True);
  AdicionaValorOpcional(ADadosRequisicao, 'agenciaDoProtesto', '0', True);
  AdicionaValorOpcional(ADadosRequisicao, 'bancoDoDebAutomatico', '0', True);
  AdicionaValorOpcional(ADadosRequisicao, 'codBancoDoProtesto', '0', True);
  AdicionaValorOpcional(ADadosRequisicao, 'contaDoDebAutomatico', '0', True);
  AdicionaValorOpcional(ADadosRequisicao, 'dataLimiteDesconto2');
  AdicionaValorOpcional(ADadosRequisicao, 'dataLimiteDesconto3');
  AdicionaValorOpcional(ADadosRequisicao, 'dddFoneSacado', '0', True);
  AdicionaValorOpcional(ADadosRequisicao, 'debitoAutomatico', 'N');
  AdicionaValorOpcional(ADadosRequisicao, 'digitoAgenciaDoDebAutomat', '0', True);
  AdicionaValorOpcional(ADadosRequisicao, 'endEletronicoPagador');
  AdicionaValorOpcional(ADadosRequisicao, 'foneSacado', '0', True);
  AdicionaValorOpcional(ADadosRequisicao, 'indicadorMoeda', '1', True);
  AdicionaValorOpcional(ADadosRequisicao, 'percentualDesconto2', '0.00', True);
  AdicionaValorOpcional(ADadosRequisicao, 'percentualDesconto3', '0.00', True);
  AdicionaValorOpcional(ADadosRequisicao, 'qmoedaNegocTitlo', '0', True);
  AdicionaValorOpcional(ADadosRequisicao, 'qtdePagamentoParcial', '0', True);
  AdicionaValorOpcional(ADadosRequisicao, 'razaoDoDebAutomatico', '0', True);
  AdicionaValorOpcional(ADadosRequisicao, 'tipoPrazoDecursoTres', '0', True);
  AdicionaValorOpcional(ADadosRequisicao, 'tpVencimento', '0', True);
  AdicionaValorOpcional(ADadosRequisicao, 'vlAbatimento', '0.00', True);
  AdicionaValorOpcional(ADadosRequisicao, 'vlAbatimento', '0.00', True);
  AdicionaValorOpcional(ADadosRequisicao, 'vlDesconto2', '0.00', True);
  AdicionaValorOpcional(ADadosRequisicao, 'vlDesconto3', '0.00', True);
  AdicionaValorOpcional(ADadosRequisicao, 'vlIOF', '0.00', True);
end;

procedure TBancoBradescoAPI.CarregarValoresOpcionaisBoleCode(
  var ADadosRequisicao: TJsonObject);
begin
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'nroCpfCnpjSacdo', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'elogdrSacdrAvals');
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'renderEletrSacdo');
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'ctpoContrNegoc', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'renderEletrSacdr');
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'vmultaAtrsoPgto', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'ccepSacdoTitlo', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'viofPgtoTitlo', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'nroCpfCnpjSacdr', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'isacdrAvalsTitlo');
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'ialiasAdsaoCta');
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'indCpfCnpjSacdr', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'indCpfCnpjSacdo', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'cfoneSacdrTitlo', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'cfoneSacdoTitlo', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'ccomplCepSacdo', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'ccomplCepSacdr', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'nroCpfCnpjBenef', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'tipoAcesso', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'pmultaAplicVcto', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'vmultaAtrsoPgto', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'contaDeb', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'imunSacdrAvals');
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'qdiaInicJuro', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'cindcdEconmMoeda', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'filCpfCnpjBenef', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'agenciaDeb', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'cindcdAceitSacdo');
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'ecomplLogdrSacdr');
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'ctpoProteDecurs', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'tipoRegistro', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'cdddFoneSacdr', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'vdescBonifPgto02', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'cespceTitloCobr', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'vdescBonifPgto01', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'cformaEmisPplta', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'ecomplLogdrSacdo');
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'vdescBonifPgto03', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'ptxJuroVcto', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'fase', '1', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'cdddFoneSacdo', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'cpssoaJuridContr', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'agenciaDebDv', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'cindcdCobrMisto');
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'ebairoLogdrSacdo');
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'registrarTitulo', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'ebairoLogdrSacdr');
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'dlimBonifPgto');
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'isacdoTitloCobr');
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'filler');
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'cnegocCobr', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'ctpoPrzProte', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'ctpoPrzDecurs', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'ilinkGeracQrcd');
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'vnmnalTitloCobr', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'dvctoTitloCobr');
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'imunSacdoTitlo');
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'bancoDeb', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'codigoBanco', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'digCpfCnpjBenef', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'eNseqContrNegoc', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'caliasAdsaoCta');
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'qtdePgtoParcial', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'cctrlPartcTitlo');
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'qdiaInicMulta', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'elogdrSacdoTitlo');
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'cprodtServcOper', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'vdiaJuroMora', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'codUsuario');
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'agenciaDvCentPr', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'demisTitloCobr');
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'ccepSacdrTitlo', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'wqrcdPdraoMercd');
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'csglUfSacdr');
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'filler4');
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'ctitloCliCdent');
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'filler1');
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'filler3');
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'filler2');
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'csglUfSacdo');
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'dlimDescBonif3');
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'dlimDescBonif2');
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'dlimDescBonif1');
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'ctpoPrzCobr', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'bancoCentProt', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'iconcPgtoSpi');
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'vabtmtTitloCobr', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'ctpoProteTitlo', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'qmoedaNegocTitlo', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'enroLogdrSacdo');
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'cidtfdTpoVcto', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'enroLogdrSacdr');
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'vdescBonifPgto', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'cidtfdProdCobr', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'cindcdPgtoParcial');
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'nseqContrNegoc', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'pdescBonifPgto01', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'pdescBonifPgto02', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'pdescBonifPgto03', '0', True);
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'validadeAposVencimento');
  AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'pdescBonifPgto', '0', True);

  If Not FDadosCarteira.Homologacao.Equals('S') Then
  Begin
    AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'codNegativacao', '0', True);
    AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'diasNegativacao', '0', True);
    AdicionaValorOpcionalBoleCode(ADadosRequisicao, 'qtdDecurPrz', '0', True);
  End;
end;

procedure TBancoBradescoAPI.ConsultaBoletoPorNossoNumeroLista(
  ADataInicial, ADataFinal: TDateTime; ANegociacao: String;
  var AListaImportada: TList<TRetornoPesquisaBancoBradescoApi>;
  var AProgresso: TfrmGravando);
  Var
    LParametros: TStringList;

    LStatus,
    LContador: Integer;

    LDadosRequisicao,
    LRetornoGet: String;

    LErro412PorSequencia: Boolean;

    LBoleto: TRetornoPesquisaBancoBradescoApi;
begin
  AProgresso.pgbStatus.Position := 0;

  AProgresso.lblGravando.Caption := 'Importando boletos da carteira ' + FDadosCarteira.CarteiraCompleta.Split(['-'])[1] + ' - empresa ' + FDadosCarteira.CarteiraCompleta.Split(['-'])[2];
  Application.ProcessMessages;

  LParametros := TStringList.Create;

  If FDadosCarteira.Homologacao.Equals('S') Then
    RemoverDuplicadosNaHomologacao(AListaImportada, ANegociacao);

  Try
    For LContador := 0 To AListaImportada.Count - 1 Do
    Begin
      If Not AListaImportada[LContador].Negociacao.Equals(ANegociacao) Then
        Continue;

      GerarToken;

      LDadosRequisicao := RetornaDadosRequisicaoPesquisaNossoNumero(AListaImportada[LContador].nossoNumero);

      LParametros.Clear;
      LParametros.Add('Authorization: ' + FTokenUsoAtual);

      FRestSynalist.StatusSemRaise := [404, 412];

      LStatus := FRestSynalist.ExecuteRestSynalist('POST',
                                                   FDadosCarteira.LinkConsultaEspecifico,
                                                   LParametros,
                                                   LRetornoGet,
                                                   LDadosRequisicao);

      LErro412PorSequencia := EhErro412PorSequencia(LStatus, LRetornoGet);

      If (LStatus = 404) Then
      Begin
        pStep(AProgresso.pgbStatus);
        Continue;
      End;

      If Not LErro412PorSequencia Then
        ValidaStatusErro(LStatus, LRetornoGet);

      LBoleto := RetornaDadosPesquisaBoletoNossoNumero(LRetornoGet, AListaImportada[LContador], LErro412PorSequencia);

      LBoleto.CodigoCarteira := FDadosCarteira.CarteiraCompleta;
      LBoleto.NomeDoArquivo := Concat(FormatDateTime('dd/mm/yy', ADataInicial),' - ',
                                      FormatDateTime('dd/mm/yy', ADataFinal));

      CorrigeDatas(LBoleto.dataVencimento);
      CorrigeDatas(LBoleto.dataPagamento);
      CorrigeDatas(LBoleto.dataMovimento);
      CorrigeDatas(LBoleto.DtPagto);
      CorrigeDatas(LBoleto.dataReg);
      CorrigeDatas(LBoleto.dataEmis);
      CorrigeDatas(LBoleto.dataInstr);
      CorrigeDatas(LBoleto.dataCartor);
      CorrigeValores(LBoleto.vlrPagto, 2);
      CorrigeValores(LBoleto.valMoeda, 2);
      CorrigeValores(LBoleto.valorIof, 2);
      CorrigeValores(LBoleto.valAbat, 2);
      CorrigeValores(LBoleto.valPerm, 2);
      CorrigeValores(LBoleto.valMulta, 2);
      CorrigeValores(LBoleto.valorTitulo, 2);
      CorrigeValores(LBoleto.valorOscilacao, 2);

      AListaImportada[LContador] := LBoleto;

      If FDadosCarteira.Homologacao.Equals('S') Then
        Sleep(1000);

      pStep(AProgresso.pgbStatus);
    End;
  Finally
    FRestSynalist.StatusSemRaise := [];

    FreeAndNil(LParametros);
  End;
end;

function TBancoBradescoAPI.ConsultaBoletosLiquidados(ADataInicial,
  ADataFinal: TDateTime; AListaBoletos: TList<TRetornoPesquisaBancoBradescoApi>;
  var AProgresso: TfrmGravando): TList<TRetornoPesquisaBancoBradescoApi>;
  Var
    LStatus,
    LPaginaAtual: Integer;

    LParametros: TStringList;

    LRetornoGet,
    LDadosRequisicao: String;

    LJsonRetorno: TJsonObject;

    LJsonBoletos: TJsonArray;

    LBoleto: TJsonValue;

    LRegistro: TRetornoPesquisaBancoBradescoAPI;

    LProximaPagina: Boolean;
begin
  Result := AListaBoletos;

  LParametros := TStringList.Create;

  FRestSynalist.StatusSemRaise := [403, 401, 412];

  LProximaPagina := False;

  Try
    Try
      AProgresso.lblGravando.Caption := 'Aguarde... Filtrando registros.';
      AProgresso.pgbStatus.Visible := False;
      Application.ProcessMessages;

      LPaginaAtual := 0;

      Repeat
        LDadosRequisicao := RetornaDadosRequisicaoPesquisa(ADataInicial, ADataFinal, True, LPaginaAtual);

        LParametros.Clear;

        GerarToken;

        LParametros.Add('Authorization: ' + FTokenUsoAtual);

        LStatus := FRestSynalist.ExecuteRestSynalist('POST',
                                                     FDadosCarteira.LinkConsulta,
                                                     LParametros,
                                                     LRetornoGet,
                                                     LDadosRequisicao);

        If Not MatchStr(LStatus.ToString, ['200', '412']) Then
          ValidaStatusErro(LStatus, LRetornoGet);

        If LStatus = 412 Then
          Break;
        
        LJSonRetorno := TJSONObject.ParseJSONValue(LRetornoGet) as TJsonObject;

        LProximaPagina := RetornaValorJson(LJSonRetorno, 'indMaisPagina').Equals('S');
        If FDadosCarteira.Homologacao.Equals('S') Then
          LProximaPagina := False;

        LJsonBoletos := TJSONObject.ParseJSONValue(LJSonRetorno.GetValue('titulos').ToJson) as TJsonArray;

        If LJsonBoletos <> Nil Then
        Begin
          For LBoleto In LJsonBoletos Do
          Begin
            If RetornaValorJsonValue(LBoleto, 'nossoNumero').Trim.IsEmpty Then
              Continue;

            //Foi necessário pois a homologação tem uma enorme limitação
            If FDadosCarteira.Homologacao.Equals('S') Then
            Begin
              If Not MatchStr(RetornaValorJsonValue(LBoleto, 'nossoNumero'), NOSSO_NUMERO_HOMOLOGACAO) Then
                Continue;
            End;

            LRegistro := RetornaDadosPesquisaBoletoLiquidadoAPIBradesco(LBoleto.ToJson);
            If FDadosCarteira.Homologacao.Equals('S') Then
              LRegistro.codStatus := '61';

            Result.Add(LRegistro);
          End;
        End;

        FreeAndNil(LJSonRetorno);

        Inc(LPaginaAtual);
      Until(Not LProximaPagina);
    Except
      Raise;
    End;
  Finally
    FreeAndNil(LParametros);

    FRestSynalist.StatusSemRaise := [];
  End;
end;

function TBancoBradescoAPI.ConsultaBoletosMovimento(ADataInicial,
  ADataFinal: TDateTime; AListaBoletos: TList<TRetornoPesquisaBancoBradescoApi>;
  var AProgresso: TfrmGravando): TList<TRetornoPesquisaBancoBradescoApi>;
  Var
    LStatus,
    LPaginaAtual: Integer;

    LParametros: TStringList;

    LRetornoGet,
    LDadosRequisicao: String;

    LJsonRetorno: TJsonObject;

    LJsonBoletos: TJsonArray;

    LBoleto: TJsonValue;

    LRegistro: TRetornoPesquisaBancoBradescoAPI;

    LProximaPagina: Boolean;
begin
  Result := AListaBoletos;

  LParametros := TStringList.Create;

  FRestSynalist.StatusSemRaise := [403, 401, 412];

  LProximaPagina := False;

  Try
    Try
      AProgresso.lblGravando.Caption := 'Aguarde... Filtrando registros.';
      AProgresso.pgbStatus.Visible := False;
      Application.ProcessMessages;

      LPaginaAtual := 0;

      Repeat
        LDadosRequisicao := RetornaDadosRequisicaoPesquisaPendente(ADataInicial, ADataFinal, False, LPaginaAtual);

        LParametros.Clear;

        GerarToken;

        LParametros.Add('Authorization: ' + FTokenUsoAtual);

        LStatus := FRestSynalist.ExecuteRestSynalist('POST',
                                                     FDadosCarteira.LinkConsultaPendente,
                                                     LParametros,
                                                     LRetornoGet,
                                                     LDadosRequisicao);

        If Not MatchStr(LStatus.ToString, ['200', '412']) Then
          ValidaStatusErro(LStatus, LRetornoGet);

        If LStatus = 412 Then
          Break;

        LJSonRetorno := TJSONObject.ParseJSONValue(LRetornoGet) as TJsonObject;

        LProximaPagina := RetornaValorJson(LJSonRetorno, 'indMaisPagina').Equals('S');
        If FDadosCarteira.Homologacao.Equals('S') Then
          LProximaPagina := False;

        LJsonBoletos := TJSONObject.ParseJSONValue(LJSonRetorno.GetValue('titulos').ToJson) as TJsonArray;

        If LJsonBoletos <> Nil Then
        Begin
          For LBoleto In LJsonBoletos Do
          Begin
            If RetornaValorJsonValue(LBoleto, 'nossoNumero').Trim.IsEmpty Then
              Continue;

            //Foi necessário pois a homologação tem uma enorme limitação
            If FDadosCarteira.Homologacao.Equals('S') Then
            Begin
              If Not MatchStr(RetornaValorJsonValue(LBoleto, 'nossoNumero'), NOSSO_NUMERO_HOMOLOGACAO) Then
                Continue;
            End;

            LRegistro := RetornaDadosPesquisaBoletoPendentesAPIBradesco(LBoleto.ToJson);
            If FDadosCarteira.Homologacao.Equals('S') Then
              LRegistro.codStatus := '61';

            Result.Add(LRegistro);
          End;
        End;

        FreeAndNil(LJSonRetorno);

        Inc(LPaginaAtual);
      Until(Not LProximaPagina);
    Except
      Raise;
    End;
  Finally
    FreeAndNil(LParametros);

    FRestSynalist.StatusSemRaise := [];
  End;
end;

function TBancoBradescoAPI.ConsultaBoletosPorPeriodo(ADataInicial,
  ADataFinal: TDateTime;
  var AProgresso: TfrmGravando): TList<TRetornoPesquisaBancoBradescoApi>;
begin
  Result := ConsultaBoletosTodasEmpresas(ADataInicial,
                                         ADataFinal,
                                         AProgresso);
end;

function TBancoBradescoAPI.ConsultaBoletosTodasEmpresas(ADataInicial,
  ADataFinal: TDateTime;
  var AProgresso: TfrmGravando): TList<TRetornoPesquisaBancoBradescoApi>;
  Var
    LListaCarteiras,
    LListaBeneficiarios: TStringList;

    LCarteira: String;

    LBancoBradescoObj: TBancoBradescoAPI;

    LMaximoProgresso: Integer;
begin
  Result := TList<TRetornoPesquisaBancoBradescoApi>.Create;

  LListaCarteiras := RetornaListaDeCarteiras;

  LListaBeneficiarios := TStringList.Create;

  LMaximoProgresso := 0;

  Try
    For LCarteira In LListaCarteiras Do
    Begin
      LBancoBradescoObj := TBancoBradescoAPI.Create(LCarteira.Split(['|'])[0]);

      If LListaBeneficiarios.IndexOf(LCarteira.Split(['|'])[1]) = -1 Then
      Begin
        LListaBeneficiarios.Add(LCarteira.Split(['|'])[1]);

        Result := LBancoBradescoObj.ConsultaBoletosLiquidados(ADataInicial, ADataFinal, Result, AProgresso);

        Result := LBancoBradescoObj.ConsultaBoletosMovimento(ADataInicial, ADataFinal, Result, AProgresso);
      End;

      LMaximoProgresso := Result.Count - LMaximoProgresso;

      AProgresso.pgbStatus.Properties.Max := LMaximoProgresso;
      AProgresso.pgbStatus.Visible := True;

      LBancoBradescoObj.ConsultaBoletoPorNossoNumeroLista(ADataInicial,
                                                          ADataFinal,
                                                          LBancoBradescoObj.DadosCarteira.Agencia +
                                                            fStrZero(LBancoBradescoObj.DadosCarteira.ContaCorrente, 7),
                                                          Result,
                                                          AProgresso);

      FreeAndNil(LBancoBradescoObj);
    End;
  Finally
    FreeAndNil(LListaCarteiras);
    FreeAndNil(LListaBeneficiarios);
  End;
end;

procedure TBancoBradescoAPI.CorrigeDatas(var AValorDuplicata: String);
  Var
    LValorData: TDateTime;
begin
  If AValorDuplicata.IsEmpty Then
    Exit;

  AValorDuplicata := fStrZero(AValorDuplicata, 8);

  If TryStrToDateTime(Concat(LeftStr(AValorDuplicata, 2), '/',
                             Copy(AValorDuplicata, 3, 2), '/',
                             RightStr(AValorDuplicata, 4)),
                      LValorData) Then
    AValorDuplicata := DateToStr(LValorData);
end;

procedure TBancoBradescoAPI.CorrigeValores(var AValorDuplicata: String;
  ACasasDecimais: Integer = 2);
begin
  If AValorDuplicata.IsEmpty Then
    Exit;

  If ACasasDecimais <= 0 Then
    ACasasDecimais := 1;

  AValorDuplicata := AValorDuplicata.Replace('.', EmptyStr).Replace(',', EmptyStr);

  Try
    AValorDuplicata := (StrToInt64Def(AValorDuplicata, 0) / (StrToInt(fPadR('1', ACasasDecimais + 1, '0')))).ToString;
    AValorDuplicata := AValorDuplicata.Replace('.', EmptyStr);
    If LeftStr(AValorDuplicata, 1) = '0' Then
      AValorDuplicata := '0,' + RightStr(AValorDuplicata, AValorDuplicata.Length - 1);
  Except

  End;
end;

constructor TBancoBradescoAPI.Create(ACarteira: String);
begin
  FPastaAutcom := ExtractFilePath(Application.ExeName).Replace('autban\', EMptyStr)
                                                      .Replace('Autban\', EMptyStr)
                                                      .Replace('AUTBAN\', EMptyStr);

  CriarComponenteRequisicao;
  CarregaDadosCarteira(ACarteira);
  DefinirURL;
  FListaRequisicaoRegistroBoleto := TList<TRequisicaoRegistroBoleto>.Create;
  FRetornoBancoBradescoAPI := TRetornoBoletoBradesco.Create;

  FNossoNumeroDuplicado := False;
end;

procedure TBancoBradescoAPI.CriarComponenteRequisicao;
begin
  FRestSynalist := TRestSynalistAutban.Create;
end;

procedure TBancoBradescoAPI.DefinirURL;
  Var
    LLinkAmbiente: String;
begin
  LLinkAmbiente := 'https://openapisandbox.prebanco.com.br/';
  If Not FDadosCarteira.Homologacao.Equals('S') Then
    LLinkAmbiente := 'https://openapi.bradesco.com.br/';

  FDadosCarteira.LinkTokenAPI := LLinkAmbiente + 'auth/server-mtls/v2/token';
  FDadosCarteira.LinkInclusao := LLinkAmbiente + 'boleto/cobranca-registro/v1/cobranca';
  FDadosCarteira.LinkBaixa := LLinkAmbiente + 'boleto/cobranca-baixa/v1/baixar';

  FDadosCarteira.LinkConsultaEspecifico := LLinkAmbiente + 'boleto/cobranca-consulta/v1/consultar';

  FDadosCarteira.LinkConsulta := LLinkAmbiente + 'boleto/cobranca-lista/v1/listar';
  FDadosCarteira.LinkConsultaPendente := LLinkAmbiente + 'boleto/cobranca-pendente/v1/listar';

  If FDadosCarteira.GerarQRCodePix.Equals('S') Then
    FDadosCarteira.LinkInclusao := LLinkAmbiente + 'boleto-hibrido/cobranca-registro/v1/gerarBoleto';
end;

destructor TBancoBradescoAPI.Destroy;
begin
  GravarDadosRequisicaoRegistroBoleto;
  FreeAndNil(FListaRequisicaoRegistroBoleto);
  FreeAndNil(FRetornoBancoBradescoAPI);
  FreeAndNil(FRestSynalist);

  FDadosCarteira.DadosEmpresa.Close;
  FreeAndNil(FDadosCarteira.DadosEmpresa);

  FDadosCarteira.DadosChavePix.Close;
  FreeAndNil(FDadosCarteira.DadosChavePix);
  inherited;
end;

function TBancoBradescoAPI.DeveLimparOsDadosDoBoletoCancelamento(
  AStatus: Integer; ARetorno: String): Boolean;
  Var
    LJsonObject: TJsonObject;
begin
  Result := AStatus.ToString.Equals('200');

  If Not Result Then
    Exit;

  Try
    LJsonObject := TJsonObject.ParseJSONValue(AREtorno) As TJsonObject;

    Result := RetornaValorJson(LJsonObject, 'status').Equals('200');

    If Not Result Then
      Raise Exception.Create('Erro código: ' + RetornaValorJson(LJsonObject, 'status') + ' - ' +
                             RetornaValorJson(LJsonObject, 'mensagem'));

    FreeAndNil(LJsonObject);
  Except
    Raise;
  End;
end;

function TBancoBradescoAPI.EhErro412PorSequencia(AStatus: Integer;
  ARetornoErro: String): Boolean;
  Var
    LJsonObject: TJsonObject;
begin
  Result := AStatus = 412;

  If Not Result THen
    Exit;

  LJsonObject := Nil;
  Try
    LJsonObject := TJsonObject.ParseJSONValue(ARetornoErro) As TJsonObject;
    If LJsonObject = Nil Then
      Exit(False);

    Result := LJsonObject.ToString.Contains('CBTT0929 - NUMERO DE SEQUENCIA DO TITULO INVALIDO');
  Finally
    If Assigned(LJsonObject) Then
      FreeAndNil(LJsonObject);
  End;
end;

procedure TBancoBradescoAPI.GerarToken(ALimparTokenGravado: Boolean = False);
  Var
    LDadosEnvio: String;

    LParametros: TStringList;
begin
  If ALimparTokenGravado Then
    FRestSynalist.RemoverTokenGravado(FDadosCarteira.CarteiraCompleta);

  If Not FRestSynalist.RetornaTokenAtivo(FDadosCarteira.CarteiraCompleta).Token.IsEmpty Then
  Begin
    FTokenUsoAtual := 'Bearer ' + FRestSynalist.RetornaTokenAtivo(FDadosCarteira.CarteiraCompleta).Token;

    Exit;
  End;

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
                                                           'application/x-www-form-urlencoded',
                                                           True);
    Except
      On E: Exception Do
        Raise Exception.Create('Ocorreu um erro ao realizar a autenticação na API do Banco.' + #13 +
                               'Erro gerado: ' + E.Message);
    End;
  Finally
    FreeAndNil(LParametros);
  End;
end;

procedure TBancoBradescoAPI.GravarDadosRequisicaoRegistroBoleto;
  Var
    LRequisicaoRegistroBoleto : TRequisicaoRegistroBoleto;
begin
  If Assigned(FListaRequisicaoRegistroBoleto) Then
  Begin
    If FListaRequisicaoRegistroBoleto.Count > 0 Then
    Begin
      For LRequisicaoRegistroBoleto In FListaRequisicaoRegistroBoleto Do
        TRegBol.GravarRequisicaoReqistroBoleto(LRequisicaoRegistroBoleto);
    End;

    FListaRequisicaoRegistroBoleto.Clear;
  End;
end;

function TBancoBradescoAPI.JsonRetornoModeloQRCode(
  AJsonRetorno: String): Boolean;
begin
  Result := AJsonRetorno.Contains('"wqrcdPdraoMercd"') And
            AJsonRetorno.Contains('"linhaDig10"');

  If Not Result Then
    Result := AJsonRetorno.Contains('"cnegocCobr"') And
              AJsonRetorno.Contains('"cidtfdProdCobr"') And
              AJsonRetorno.Contains('"dataReg10"');
end;

procedure TBancoBradescoAPI.ReimpressaoDeBoleto(AAutoIncrem: String);
  Var
    LJsonRegistro: String;

    LConsulta: TUniQuery;

    LNossoNumero: String;
begin
  LConsulta := fCriaQuery;

  If Assigned(FRetornoBancoBradescoAPI) Then
    FreeAndNil(FRetornoBancoBradescoAPI);

  Try
    Try
      LJsonRegistro := TFuncoesPixBoleto.RetornaJsonRegistroBoleto(AAutoIncrem, '237');

      LConsulta.SQL.Text := 'SELECT CTR_NOSNUM, CTR_TX_BOL, CTR_QRCODE, CTR_LINDIG, CTR_NUMDUP, CTR_PARCEL ' +
                            'FROM CADREC WHERE AUTOINCREM = :AUTOINC';

      LConsulta.ParamByName('AUTOINC').AsString := AAutoIncrem;
      LConsulta.Open;

      If fEmptyStr(LJsonRegistro) Then
      Begin
        FRetornoBancoBradescoAPI := TRetornoBoletoBradesco.Create;

        LNossoNumero := LeftStr(LConsulta.FieldByName('CTR_NOSNUM').AsString, LConsulta.FieldByName('CTR_NOSNUM').AsString.Length - 1);

        If Not TryStrToInt64(LNossoNumero, FRetornoBancoBradescoAPI.NuTituloGerado) Then
          Raise Exception.CreateFmt('Nosso número da duplicata %s%s é inválido.',
                                    [LConsulta.FieldByName('CTR_NUMDUP').AsString, LConsulta.FieldByName('CTR_PARCEL').AsString]);

        FRetornoBancoBradescoAPI.linhaDigitavel := LConsulta.FieldByName('CTR_LINDIG').AsString;
        FRetornoBancoBradescoAPI.CdBarras := Copy(FRetornoBancoBradescoAPI.linhaDigitavel, 01, 04) +
                                             Copy(FRetornoBancoBradescoAPI.linhaDigitavel, 33, 15) +
                                             Copy(FRetornoBancoBradescoAPI.linhaDigitavel, 05, 05) +
                                             Copy(FRetornoBancoBradescoAPI.linhaDigitavel, 11, 08) +
                                             Copy(FRetornoBancoBradescoAPI.linhaDigitavel, 19, 02) +
                                             Copy(FRetornoBancoBradescoAPI.linhaDigitavel, 22, 10);

        Exit;
      End;

      FRetornoBancoBradescoAPI := RetornaDadosRetornoInclusaoBoleto(LJsonRegistro,
                                                                    LConsulta.FieldByName('CTR_NOSNUM').AsString);
      FRetornoBancoBradescoAPI.CdBarras := Copy(FRetornoBancoBradescoAPI.linhaDigitavel, 01, 04) +
                                           Copy(FRetornoBancoBradescoAPI.linhaDigitavel, 33, 15) +
                                           Copy(FRetornoBancoBradescoAPI.linhaDigitavel, 05, 05) +
                                           Copy(FRetornoBancoBradescoAPI.linhaDigitavel, 11, 08) +
                                           Copy(FRetornoBancoBradescoAPI.linhaDigitavel, 19, 02) +
                                           Copy(FRetornoBancoBradescoAPI.linhaDigitavel, 22, 10);

    Except
      Raise;
    End;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

procedure TBancoBradescoAPI.RemoverDuplicadosNaHomologacao(
  var AListaImportada: TList<TRetornoPesquisaBancoBradescoApi>;
  ANegociacao: String);
  Var
    LListaNossoNumero: TStringList;

    LContador: Integer;
begin
  LListaNossoNumero := TStringList.Create;

  Try
    LContador := 0;
    While LContador < AListaImportada.Count Do
    Begin
      If Not AListaImportada[LContador].Negociacao.Equals(ANegociacao) Then
      Begin
        Inc(LContador);
        Continue;
      End;

      If LListaNossoNumero.IndexOf(AListaImportada[LContador].nossoNumero + AListaImportada[LContador].digitoNossoNumero) = -1 Then
      Begin
        LListaNossoNumero.Add(AListaImportada[LContador].nossoNumero + AListaImportada[LContador].digitoNossoNumero);
        Inc(LContador);
        Continue;
      End;

      AListaImportada.Delete(LContador);
    End;
  Finally
    FreeAndNil(LListaNossoNumero);
  End;
end;

procedure TBancoBradescoAPI.RemoverTokenGravado;
begin
  FRestSynalist.RemoverTokenGravado(FDadosCarteira.CarteiraCompleta);
end;

function TBancoBradescoAPI.RetornaDadosDaRequisicao(ADadosDuplicata,
  ADadosCliente: TDataset; var ANosNum: String): String;
  Var
    LJsonRequisicao: TJsonObject;
begin
  If FDadosCarteira.GerarQRCodePix.Equals('S') Then
    Exit(RetornaDadosDaRequisicaoBoleCode(ADadosDuplicata,
                                          ADadosCliente,
                                          ANosNum));

  LJsonRequisicao := TJsonObject.Create;

  Try
    CarregaDadosBeneficiario(LJsonRequisicao);

    LJsonRequisicao.AddPair('idProduto', RetornaDadosJsonNumber(FDadosCarteira.CodCarteira));
    LJsonRequisicao.AddPair('nuNegociacao', RetornaDadosJsonNumber(Concat(fStrZero(FDadosCarteira.Agencia, 4),
                                                                   '0000000',
                                                                    fStrZero(FDadosCarteira.ContaCorrente, 7))));

    CarregaDadosDoTitulo(LJsonRequisicao,
                         ADadosDuplicata,
                         ANosNum);

    CarregaDadosProtesto(LJsonRequisicao,
                         ADadosDuplicata,
                         ADadosCliente);

    CarregaDadosJuros(LJsonRequisicao,
                      ADadosDuplicata,
                      ADadosCliente);

    CarregaDadosMulta(LJsonRequisicao,
                      ADadosDuplicata);

    CarregaDadosDescontos(LJsonRequisicao,
                          ADadosDuplicata,
                          ADadosCliente);

    CarregaDadosPagador(LJsonRequisicao,
                        ADadosCliente);

    CarregaDadosMensagens(LJsonRequisicao);

    CarregarValoresOpcionais(LJsonRequisicao);

    Result := TJson.Format(LJsonRequisicao);
  Finally
    FreeAndNil(LJsonRequisicao);
  End;
end;

function TBancoBradescoAPI.RetornaDadosDaRequisicaoBoleCode(ADadosDuplicata,
  ADadosCliente: TDataset; var ANosNum: String): String;
  Var
    LJsonRequisicao: TJsonObject;

    LCodigoNegociacao: String;
begin
  LJsonRequisicao := TJsonObject.Create;

  LCodigoNegociacao := fPadR('1', 18, '1');
  If Not FDadosCarteira.Homologacao.Equals('S') Then
    LCodigoNegociacao := Concat(fStrZero(FDadosCarteira.Agencia, 4),
                                '0000000',
                                fStrZero(FDadosCarteira.ContaCorrente, 7));

  Try
    CarregaDadosBeneficiarioBoleCode(LJsonRequisicao);

    LJsonRequisicao.AddPair('registrarTitulo', RetornaDadosJsonNumber('1', 1));
    LJsonRequisicao.AddPair('codUsuario', 'APISERVIC');
    LJsonRequisicao.AddPair('tipoAcesso', RetornaDadosJsonNumber('2', 1));
    LJsonRequisicao.AddPair('codigoBanco', RetornaDadosJsonNumber('237'));

    LJsonRequisicao.AddPair('cidtfdProdCobr', RetornaDadosJsonNumber(RightStr(FDadosCarteira.CodCarteira, 2), 2));
    LJsonRequisicao.AddPair('cnegocCobr', RetornaDadosJsonNumber(LCodigoNegociacao, 18));

    CarregaDadosDoTituloBoleCode(LJsonRequisicao,
                                 ADadosDuplicata,
                                 ANosNum);

    CarregaDadosProtestoBoleCode(LJsonRequisicao,
                                 ADadosDuplicata,
                                 ADadosCliente);

    CarregaDadosJurosBoleCode(LJsonRequisicao,
                              ADadosDuplicata,
                              ADadosCliente);

    CarregaDadosMultaBoleCode(LJsonRequisicao,
                              ADadosDuplicata);

    CarregaDadosDescontosBoleCode(LJsonRequisicao,
                                  ADadosDuplicata,
                                  ADadosCliente);

    CarregaDadosPagadorBoleCode(LJsonRequisicao,
                                ADadosCliente);

    CarregaDadosPixBoleCode(LJsonRequisicao);

    CarregarValoresOpcionaisBoleCode(LJsonRequisicao);

    Result := TJson.Format(LJsonRequisicao);
  Finally
    FreeAndNil(LJsonRequisicao);
  End;
end;

function TBancoBradescoAPI.RetornaDadosJsonNumber(AString: String;
  ATamanho: Integer): TJsonNumber;
begin
  If AString.Trim.IsEmpty Then
    Exit(TJsonNumber.Create('0'));

  Try
    AString := StrToInt64(AString).ToString;
  Except
    AString := '0';
  End;

  If ATamanho <> -1 Then
    Exit(TJSONNumber.Create(RightStr(AString, ATamanho)));

  Result := TJSONNumber.Create(AString);
end;

function TBancoBradescoAPI.RetornaDadosPesquisaBoletoLiquidadoAPIBradesco(
  ADadosBoleto: String): TRetornoPesquisaBancoBradescoAPI;
  Var
    LJsonBoleto: TJsonObject;
begin
  Result := TRetornoPesquisaBancoBradescoAPI.Create;

  LJsonBoleto := TJSONObject.ParseJSONValue(ADadosBoleto) As TJsonObject;
  If LJsonBoleto = Nil Then
    Exit;

  Try
    Result.bancoRecebedor := RetornaValorJson(LJsonBoleto, 'bancoRecebedor');
    Result.agenciaRecebedora := RetornaValorJson(LJsonBoleto, 'agenciaRecebedora');
    Result.nossoNumero := RetornaValorJson(LJsonBoleto, 'nossoNumero');
    Result.digitoNossoNumero := RetornaValorJson(LJsonBoleto, 'digitoNossoNumero');
    Result.tipoRegistro := RetornaValorJson(LJsonBoleto, 'tipoRegistro');
    Result.seuNumero := RetornaValorJson(LJsonBoleto, 'seuNumero');
    Result.dataVencimento := RetornaValorJson(LJsonBoleto, 'dataVencimento');
    Result.dataPagamento := RetornaValorJson(LJsonBoleto, 'dataPagamento');
    Result.dataMovimento := RetornaValorJson(LJsonBoleto, 'dataMovimento');
    Result.nomePagador := RetornaValorJson(LJsonBoleto, 'nomePagador');
    Result.descricaoOrigemPagamento := RetornaValorJson(LJsonBoleto, 'descricaoOrigemPagamento');
    Result.valorTitulo := RetornaValorJson(LJsonBoleto, 'valorTitulo');
    Result.valorOscilacao := RetornaValorJson(LJsonBoleto, 'valorOscilacao');
    Result.sinalValorOscilacao := RetornaValorJson(LJsonBoleto, 'sinalValorOscilacao');
    Result.valorPagamento := RetornaValorJson(LJsonBoleto, 'valorPagamento');
    Result.numeroSequenciaTitulo := RetornaValorJson(LJsonBoleto, 'numeroSequenciaTitulo');
    Result.numeroSequenciaPagamento := RetornaValorJson(LJsonBoleto, 'numeroSequenciaPagamento');
    Result.codigoFormaCredito := RetornaValorJson(LJsonBoleto, 'codigoFormaCredito');
    Result.descricaoFormaCredito := RetornaValorJson(LJsonBoleto, 'descricaoFormaCredito');
    Result.indicadorPagoCartorio := RetornaValorJson(LJsonBoleto, 'indicadorPagoCartorio');
    Result.indicadorPagoQrCode := RetornaValorJson(LJsonBoleto, 'indicadorPagoQrCode');
    Result.txId := RetornaValorJson(LJsonBoleto, 'txId');

    Result.Negociacao := FDadosCarteira.Agencia + fStrZero(FDadosCarteira.ContaCorrente, 7);
    Result.JsonBoletoConsultaLista := ADadosBoleto;
  Finally
    FreeAndNil(LJsonBoleto);
  End;
end;

function TBancoBradescoAPI.RetornaDadosPesquisaBoletoNossoNumero(
  ADadosBoleto: String; AObjetoBoleto: TRetornoPesquisaBancoBradescoAPI;
  ARetornouErro412PorSequencia: Boolean): TRetornoPesquisaBancoBradescoAPI;
  Var
    LJsonBoleto: TJsonObject;
begin
  Result := AObjetoBoleto;

  If ARetornouErro412PorSequencia Then
  Begin
    Try
      LJsonBoleto := TJSONObject.ParseJSONValue(AObjetoBoleto.JsonBoletoConsultaLista) As TJsonObject;
      If LJsonBoleto = Nil Then
        Exit;

      Result.agencCred := RetornaValorJson(LJsonBoleto, 'agenciaRecebedora');
      Result.ctaCred := '';
      Result.digCred := '';

      Result.bcoDepos := RetornaValorJson(LJsonBoleto, 'bancoRecebedor');
      Result.snumero := RetornaValorJson(LJsonBoleto, 'seuNumero');
      Result.valMoeda := RetornaValorJson(LJsonBoleto, 'valorTitulo');

      If RetornaValorJson(LJsonBoleto, 'sinalValorOscilacao') = '-' Then
        Result.valAbat := RetornaValorJson(LJsonBoleto, 'valorOscilacao')
      Else If RetornaValorJson(LJsonBoleto, 'sinalValorOscilacao') = '+' Then
        Result.valPerm := RetornaValorJson(LJsonBoleto, 'valorOscilacao');
      Result.dataInstr := RetornaValorJson(LJsonBoleto, 'dataMovimento');

      Result.valorMoedaBol := RetornaValorJson(LJsonBoleto, 'valorTitulo');
      Result.DtPagto := RetornaValorJson(LJsonBoleto, 'dataPagamento');
      Result.vlrPagto := RetornaValorJson(LJsonBoleto, 'valorPagamento');

      If Result.digitoNossoNumero.IsEmpty Then
        Result.digitoNossoNumero := fCalcDigito('237',
                                                Result.nossoNumero, '237API',
                                                StrToInt(FDadosCarteira.CarteiraCompleta.Split(['-'])[1]),
                                                FDadosCarteira.CarteiraCompleta.Split(['-'])[2]);

      If Result.indicadorPagoQrCode.Equals('S') Then
      Begin
        Result.DtPagto := Result.dataPagamento;
        Result.vlrPagto := Result.valorPagamento;

        Result.baixaCodigo := '51';
        Result.baixaDescricao := 'PAGO POR QRCODE';
        Result.baixaData := Result.dataPagamento;
      End;

      Exit;
    Finally
      If Assigned(LJsonBoleto) Then
        FreeAndNil(LJsonBoleto);
    End;
  End;

  LJsonBoleto := TJSONObject.ParseJSONValue(ADadosBoleto) As TJsonObject;
  If LJsonBoleto = Nil Then
    Exit;

  LJsonBoleto := TJSONObject.ParseJSONValue(LJsonBoleto.GetValue('titulo').ToJson) As TJsonObject;

  If LJsonBoleto = Nil Then
    Exit;

  Result.agencCred := RetornaValorJson(LJsonBoleto, 'agencCred');
  Result.ctaCred := RetornaValorJson(LJsonBoleto, 'ctaCred');
  Result.digCred := RetornaValorJson(LJsonBoleto, 'digCred');

  If Not FDadosCarteira.Homologacao.Equals('S') Then
    Result.codStatus := RetornaValorJson(LJsonBoleto, 'codStatus');

  Result.status := RetornaValorJson(LJsonBoleto, 'status');
  Result.bcoDepos := RetornaValorJson(LJsonBoleto, 'bcoDepos');
  Result.snumero := RetornaValorJson(LJsonBoleto, 'snumero');
  Result.dataReg := RetornaValorJson(LJsonBoleto, 'dataReg');
  Result.dataEmis := RetornaValorJson(LJsonBoleto, 'dataEmis');
  Result.valMoeda := RetornaValorJson(LJsonBoleto, 'valMoeda');
  Result.valorIof := RetornaValorJson(LJsonBoleto, 'valorIof');
  Result.valAbat := RetornaValorJson(LJsonBoleto, 'valAbat');
  Result.valPerm := RetornaValorJson(LJsonBoleto, 'valPerm');
  Result.dataInstr := RetornaValorJson(LJsonBoleto, 'dataInstr');
  Result.dataCartor := RetornaValorJson(LJsonBoleto, 'dataCartor');
  Result.numProtoc := RetornaValorJson(LJsonBoleto, 'numProtoc');
  Result.identTitDda := RetornaValorJson(LJsonBoleto, 'identTitDda');
  Result.indBoletoDda := RetornaValorJson(LJsonBoleto, 'indBoletoDda');
  Result.valorMoedaBol := RetornaValorJson(LJsonBoleto, 'valorMoedaBol');
  Result.DtPagto := RetornaValorJson(LJsonBoleto, 'DtPagto');
  Result.vlrPagto := RetornaValorJson(LJsonBoleto, 'vlrPagto');
  Result.ctrlPartic := RetornaValorJson(LJsonBoleto, 'ctrlPartic');

  If Result.digitoNossoNumero.IsEmpty Then
    Result.digitoNossoNumero := fCalcDigito('237',
                                            Result.nossoNumero, '237API',
                                            StrToInt(FDadosCarteira.CarteiraCompleta.Split(['-'])[1]),
                                            FDadosCarteira.CarteiraCompleta.Split(['-'])[2]);

  If FDadosCarteira.Homologacao.Equals('S') Then
  Begin
    Result.snumero := Result.seuNumero;
    Result.valMoeda := Result.valorTitulo;
    If Result.sinalValorOscilacao.Equals('+') Then
      Result.valPerm := Result.valorOscilacao
    Else
      Result.valAbat := Result.valorOscilacao;

    If Not MatchStr(Result.valorPagamento, [EmptyStr, '0']) Then
    Begin
      Result.DtPagto := Result.dataPagamento;
      Result.vlrPagto := Result.valorPagamento;
    End;
  End;

  If Result.indicadorPagoQrCode.Equals('S') Then
  Begin
    Result.DtPagto := Result.dataPagamento;
    Result.vlrPagto := Result.valorPagamento;
  End;

  If LJsonBoleto.GetValue('baixa') = Nil Then
    Exit;

  LJsonBoleto := TJSONObject.ParseJSONValue(LJsonBoleto.GetValue('baixa').ToJSON) As TJsonObject;
  If LJsonBoleto = Nil Then
    Exit;

  Result.baixaCodigo := RetornaValorJson(LJsonBoleto, 'codigo');
  Result.baixaDescricao := RetornaValorJson(LJsonBoleto, 'descricao');
  Result.baixaData := RetornaValorJson(LJsonBoleto, 'data');

  FreeAndNil(LJsonBoleto);
end;

function TBancoBradescoAPI.RetornaDadosPesquisaBoletoPendentesAPIBradesco(
  ADadosBoleto: String): TRetornoPesquisaBancoBradescoAPI;
  Var
    LJsonBoleto: TJsonObject;
begin
  Result := TRetornoPesquisaBancoBradescoAPI.Create;

  LJsonBoleto := TJSONObject.ParseJSONValue(ADadosBoleto) As TJsonObject;
  If LJsonBoleto = Nil Then
    Exit;

  Try
    Result.codStatus := RetornaValorJson(LJsonBoleto, 'codStatus');
    Result.status := RetornaValorJson(LJsonBoleto, 'descrStatus');
    Result.nossoNumero := RetornaValorJson(LJsonBoleto, 'nossoNumero');
    Result.digitoNossoNumero := RetornaValorJson(LJsonBoleto, 'digitoNossoNumero');
    Result.seuNumero := RetornaValorJson(LJsonBoleto, 'seuNumero');
    Result.dataVencimento := RetornaValorJson(LJsonBoleto, 'dataVencto');
    Result.dataMovimento := RetornaValorJson(LJsonBoleto, 'dataReg');
    Result.valorTitulo := RetornaValorJson(LJsonBoleto, 'valTitulo');
    Result.ctrlPartic := RetornaValorJson(LJsonBoleto, 'ctrlPartic');

    Result.Negociacao := FDadosCarteira.Agencia + fStrZero(FDadosCarteira.ContaCorrente, 7);
    Result.JsonBoletoConsultaLista := ADadosBoleto;
   Finally
     FreeAndNil(LJsonBoleto);
   End;
end;

function TBancoBradescoAPI.RetornaDadosRequisicaoPesquisa(ADataInicial,
  ADataFinal: TDateTime; ALiquidados: Boolean; APaginaAnterior: Integer): String;
  Var
    LJsonRequisicao,
    LJsonCpfCnpj: TJsonObject;

    LCNPJEmpresa: String;
begin
  LCNPJEmpresa := FDadosCarteira.DadosEmpresa.FieldByName('EMP_C_G_C_').AsString.Replace('.', EmptyStr)
                                                                                .Replace('/', EmptyStr)
                                                                                .Replace('-', EmptyStr);

  LJsonRequisicao := TJsonObject.Create;

  Try
    LJsonCpfCnpj := TJsonObject.Create;
    LJsonCpfCnpj.AddPair('cpfCnpj', TJsonNumber.Create(StrToInt(LeftStr(LCNPJEmpresa, 8))));
    LJsonCpfCnpj.AddPair('filial', TJsonNumber.Create(StrToInt(Copy(LCNPJEmpresa, 9, 4))));
    LJsonCpfCnpj.AddPair('controle', TJsonNumber.Create(StrToInt(RightStr(LCNPJEmpresa, 2))));

    LJsonRequisicao.AddPair('cpfCnpj', LJsonCpfCnpj);
    LJsonRequisicao.AddPair('produto', TJsonNumber.Create(StrToInt(FDadosCarteira.CodCarteira)));
    LJsonRequisicao.AddPair('negociacao', TJsonNumber.Create(StrToInt64(FDadosCarteira.Agencia + fStrZero(FDadosCarteira.ContaCorrente, 7))));

    If Not ALiquidados Then
    Begin
      LJsonRequisicao.AddPair('dataRegistroDe', TJsonNumber.Create(FormatDateTime('ddmmyyyy', ADataInicial)));
      LJsonRequisicao.AddPair('dataRegistroAte', TJsonNumber.Create(FormatDateTime('ddmmyyyy', ADataFinal)));
      LJsonRequisicao.AddPair('dataVencimentoDe', TJsonNumber.Create(0));
      LJsonRequisicao.AddPair('dataVencimentoAte', TJsonNumber.Create(0));
      LJsonRequisicao.AddPair('nossoNumero', TJsonNumber.Create(0));
      LJsonRequisicao.AddPair('valorTituloDe', TJsonNumber.Create(0));
      //LJsonRequisicao.AddPair('valorTituloAte', TJsonNumber.Create(0));
    End
    Else
    Begin
      LJsonRequisicao.AddPair('dataMovimentoDe', TJsonNumber.Create(IIF(ALiquidados, 0, FormatDateTime('ddmmyyyy', ADataInicial))));
      LJsonRequisicao.AddPair('dataMovimentoAte', TJsonNumber.Create(IIF(ALiquidados, 0, FormatDateTime('ddmmyyyy', ADataFinal))));
      LJsonRequisicao.AddPair('dataPagamentoDe', TJsonNumber.Create(IIF(Not ALiquidados, 0, FormatDateTime('ddmmyyyy', ADataInicial))));
      LJsonRequisicao.AddPair('dataPagamentoAte', TJsonNumber.Create(IIF(Not ALiquidados, 0, FormatDateTime('ddmmyyyy', ADataFinal))));
      LJsonRequisicao.AddPair('origemPagamento', TJsonNumber.Create(0));
      LJsonRequisicao.AddPair('valorTituloDe', TJsonNumber.Create(0));
      LJsonRequisicao.AddPair('valorTituloAte', TJsonNumber.Create(0));
    End;

    LJsonRequisicao.AddPair('paginaAnterior', TJsonNumber.Create(APaginaAnterior));

    Result := LJsonRequisicao.ToJSON;
  Finally
    FreeAndNil(LJsonRequisicao);
  End;
end;

function TBancoBradescoAPI.RetornaDadosRequisicaoPesquisaNossoNumero(
  ANossoNumero: String): String;
  Var
    LJsonRequisicao,
    LJsonCpfCnpj: TJsonObject;

    LCNPJEmpresa: String;
begin
  LCNPJEmpresa := '12345678000199';
  If Not FDadosCarteira.Homologacao.Equals('S') Then
    LCNPJEmpresa := FDadosCarteira.DadosEmpresa.FieldByName('EMP_C_G_C_').AsString.Replace('.', EmptyStr)
                                                                                  .Replace('/', EmptyStr)
                                                                                  .Replace('-', EmptyStr);

  LJsonRequisicao := TJsonObject.Create;

  Try
    LJsonCpfCnpj := TJsonObject.Create;
    LJsonCpfCnpj.AddPair('cpfCnpj', TJsonNumber.Create(StrToInt(LeftStr(LCNPJEmpresa, 8))));
    LJsonCpfCnpj.AddPair('filial', TJsonNumber.Create(StrToInt(Copy(LCNPJEmpresa, 9, 4))));
    LJsonCpfCnpj.AddPair('controle', TJsonNumber.Create(StrToInt(RightStr(LCNPJEmpresa, 2))));

    LJsonRequisicao.AddPair('cpfCnpj', LJsonCpfCnpj);
    LJsonRequisicao.AddPair('produto', TJsonNumber.Create(StrToInt(FDadosCarteira.CodCarteira)));
    LJsonRequisicao.AddPair('negociacao', TJsonNumber.Create(StrToInt64(FDadosCarteira.Agencia + fStrZero(FDadosCarteira.ContaCorrente, 7))));

    LJsonRequisicao.AddPair('nossoNumero', TJsonNumber.Create(StrToInt64(ANossoNumero)));
    LJsonRequisicao.AddPair('sequencia', TJsonNumber.Create(0));
    LJsonRequisicao.AddPair('status', TJsonNumber.Create(0));

    Result := LJsonRequisicao.ToJSON;
  Finally
    FreeAndNil(LJsonRequisicao);
  End;
end;

function TBancoBradescoAPI.RetornaDadosRequisicaoPesquisaPendente(ADataInicial,
  ADataFinal: TDateTime; ALiquidados: Boolean;
  APaginaAnterior: Integer): String;
  Var
    LJsonRequisicao,
    LJsonCpfCnpj,
    LJsonCnpjPagador: TJsonObject;

    LCNPJEmpresa: String;
begin
  LCNPJEmpresa := FDadosCarteira.DadosEmpresa.FieldByName('EMP_C_G_C_').AsString.Replace('.', EmptyStr)
                                                                                .Replace('/', EmptyStr)
                                                                                .Replace('-', EmptyStr);

  LJsonRequisicao := TJsonObject.Create;

  Try
    LJsonCpfCnpj := TJsonObject.Create;
    LJsonCpfCnpj.AddPair('cpfCnpj', TJsonNumber.Create(StrToInt(LeftStr(LCNPJEmpresa, 8))));
    LJsonCpfCnpj.AddPair('filial', TJsonNumber.Create(StrToInt(Copy(LCNPJEmpresa, 9, 4))));
    LJsonCpfCnpj.AddPair('controle', TJsonNumber.Create(StrToInt(RightStr(LCNPJEmpresa, 2))));

    LJsonRequisicao.AddPair('cpfCnpj', LJsonCpfCnpj);
    LJsonRequisicao.AddPair('produto', TJsonNumber.Create(StrToInt(FDadosCarteira.CodCarteira)));
    LJsonRequisicao.AddPair('negociacao', TJsonNumber.Create(StrToInt64(FDadosCarteira.Agencia + fStrZero(FDadosCarteira.ContaCorrente, 7))));
    LJsonRequisicao.AddPair('nossoNumero', TJsonNumber.Create(0));

    LJsonCnpjPagador := TJsonObject.Create;
    LJsonCnpjPagador.AddPair('cpfCnpj', TJsonNumber.Create(0));
    LJsonCnpjPagador.AddPair('filial', TJsonNumber.Create(0));
    LJsonCnpjPagador.AddPair('controle', TJsonNumber.Create(0));

    LJsonRequisicao.AddPair('cpfCnpjPagador', LJsonCnpjPagador);

    LJsonRequisicao.AddPair('dataRegistroDe', TJsonNumber.Create(StrToInt64(FormatDateTime('ddmmyyyy', ADataInicial))));
    LJsonRequisicao.AddPair('dataRegistroAte', TJsonNumber.Create(StrToInt64(FormatDateTime('ddmmyyyy', ADataFinal))));
    LJsonRequisicao.AddPair('dataVencimentoDe', TJsonNumber.Create(0));
    LJsonRequisicao.AddPair('dataVencimentoAte', TJsonNumber.Create(0));
    LJsonRequisicao.AddPair('valorTituloDe', TJsonNumber.Create(0));
    LJsonRequisicao.AddPair('faixaVencto', TJsonNumber.Create(7));

    LJsonRequisicao.AddPair('paginaAnterior', TJsonNumber.Create(APaginaAnterior));

    Result := LJsonRequisicao.ToJSON;
  Finally
    FreeAndNil(LJsonRequisicao);
  End;
end;

function TBancoBradescoAPI.RetornaDadosRetornoInclusaoBoleto(
  ARetornoJson: String; ANossoNumero: String): TRetornoBoletoBradesco;
  Var
    LRetorno: TRetornoBoletoBradesco;

    LJsonObject: TJsonObject;
begin
  If JsonRetornoModeloQRCode(ARetornoJson) Then
    Exit(RetornaDadosRetornoInclusaoBoletoBoleCode(ARetornoJson, ANossoNumero));

  LRetorno := TRetornoBoletoBradesco.Create;

  Try
    LJsonObject := TJsonObject.ParseJSONValue(ARetornoJson) AS TJsonObject;

    If LJsonObject = Nil Then
      Exit(LRetorno);

    LRetorno.CodigoRetorno := RetornaValorJson(LJsonObject, 'codigoRetorno');
    LRetorno.MensagemRetorno := RetornaValorJson(LJsonObject, 'mensagemRetorno');
    LRetorno.SeuNumeroTitulo := RetornaValorJson(LJsonObject, 'seuNumeroTitulo');
    LRetorno.DtRegistro := RetornaValorJson(LJsonObject, 'dtRegistro');
    LRetorno.DtEmissao := RetornaValorJson(LJsonObject, 'dtEmissao');
    LRetorno.DtVencimento := RetornaValorJson(LJsonObject, 'dtVencimento');
    LRetorno.DataEnvioCartorio := RetornaValorJson(LJsonObject, 'dataEnvioCartorio');
    LRetorno.DataSustacao := RetornaValorJson(LJsonObject, 'dataSustacao');
    LRetorno.LinhaDigitavel := fRetSomenteNumeros(RetornaValorJson(LJsonObject, 'linhaDigitavel'));
    LRetorno.CdBarras := Copy(LRetorno.LinhaDigitavel, 01, 04) +
                         Copy(LRetorno.LinhaDigitavel, 33, 15) +
                         Copy(LRetorno.LinhaDigitavel, 05, 05) +
                         Copy(LRetorno.LinhaDigitavel, 11, 08) +
                         Copy(LRetorno.LinhaDigitavel, 19, 02) +
                         Copy(LRetorno.LinhaDigitavel, 22, 10);

    TryStrToInt64(RetornaValorJson(LJsonObject, 'nuTituloGerado'), LRetorno.NuTituloGerado);
    TryStrToInt(RetornaValorJson(LJsonObject, 'qtdeCasasDecimaisMulta'), LRetorno.QtdeCasasDecimaisMulta);
    TryStrToInt(RetornaValorJson(LJsonObject, 'cdValorMulta'), LRetorno.CdValorMulta);

    TryStrToFloat(RetornaValorJson(LJsonObject, 'vlIOF'), LRetorno.VlIOF);
    TryStrToFloat(RetornaValorJson(LJsonObject, 'vlTitulo'), LRetorno.VlTitulo);
    TryStrToFloat(RetornaValorJson(LJsonObject, 'vlAbatimento'), LRetorno.VlAbatimento);
    TryStrToFloat(RetornaValorJson(LJsonObject, 'vlMulta'), LRetorno.VlMulta);
    TryStrToFloat(RetornaValorJson(LJsonObject, 'vlTituloEmitidoBoleto'), LRetorno.VlTituloEmitidoBoleto);
  Finally
    Result := LRetorno;

    If LJsonObject <> Nil Then
      FreeAndNil(LJsonObject);
  End;
end;

function TBancoBradescoAPI.RetornaDadosRetornoInclusaoBoletoBoleCode(
  ARetornoJson: String; ANossoNumero: String): TRetornoBoletoBradesco;
  Var
    LRetorno: TRetornoBoletoBradesco;

    LJsonObject: TJsonObject;
begin
  LRetorno := TRetornoBoletoBradesco.Create;

  Try
    LJsonObject := TJsonObject.ParseJSONValue(ARetornoJson) AS TJsonObject;

    If LJsonObject = Nil Then
      Exit(LRetorno);

    LRetorno.CodigoRetorno := RetornaValorJson(LJsonObject, 'statusHttp');
    LRetorno.MensagemRetorno := EmptyStr;
    LRetorno.SeuNumeroTitulo := RetornaValorJson(LJsonObject, 'snumero10');
    LRetorno.DtRegistro := RetornaValorJson(LJsonObject, 'dataReg10').Insert(2, '.').Insert(5, '.');
    LRetorno.DtEmissao := RetornaValorJson(LJsonObject, 'dataEmis10');
    LRetorno.DtVencimento := RetornaValorJson(LJsonObject, 'dataVencto10');
    LRetorno.DataEnvioCartorio := RetornaValorJson(LJsonObject, 'dataCartor10').Insert(2, '.').Insert(5, '.');
    LRetorno.DataSustacao := RetornaValorJson(LJsonObject, 'dataSust10').Insert(2, '.').Insert(5, '.');
    LRetorno.LinhaDigitavel := fRetSomenteNumeros(RetornaValorJson(LJsonObject, 'linhaDig10'));
    LRetorno.CdBarras := Copy(LRetorno.LinhaDigitavel, 01, 04) +
                         Copy(LRetorno.LinhaDigitavel, 33, 15) +
                         Copy(LRetorno.LinhaDigitavel, 05, 05) +
                         Copy(LRetorno.LinhaDigitavel, 11, 08) +
                         Copy(LRetorno.LinhaDigitavel, 19, 02) +
                         Copy(LRetorno.LinhaDigitavel, 22, 10);

    LRetorno.QrCodeTxId := RetornaValorJson(LJsonObject, 'iconcPgtoSpi');
    LRetorno.QrCodeUrl := RetornaValorJson(LJsonObject, 'ilinkGeracQrcd');
    LRetorno.QrCodeEmv := RetornaValorJson(LJsonObject, 'wqrcdPdraoMercd');

    ANossoNumero := RetornaValorJson(LJsonObject, 'ctitloCobrCdent');
    TryStrToInt64(ANossoNumero, LRetorno.NuTituloGerado);
    TryStrToInt(RetornaValorJson(LJsonObject, 'qtdeCasMul10'), LRetorno.QtdeCasasDecimaisMulta);
    TryStrToInt(RetornaValorJson(LJsonObject, 'codValMul10'), LRetorno.CdValorMulta);

    TryStrToFloat(RetornaValorJson(LJsonObject, 'valorIof10'), LRetorno.VlIOF);
    TryStrToFloat(RetornaValorJson(LJsonObject, 'valMoeda10'), LRetorno.VlTitulo);
    TryStrToFloat(RetornaValorJson(LJsonObject, 'valAbat10'), LRetorno.VlAbatimento);
    TryStrToFloat(RetornaValorJson(LJsonObject, 'valMoeda10'), LRetorno.VlTituloEmitidoBoleto);
  Finally
    Result := LRetorno;

    If LJsonObject <> Nil Then
      FreeAndNil(LJsonObject);
  End;
end;

function TBancoBradescoAPI.RetornaDadosString(AString: String;
  ATamanho: Integer = -1): String;
begin
  Result := fTiraCaracEspeciais(AString, True, False, True, True, True, True, True);
  Result := fTiraEnter(Result);
  Result := fRemoveAcento(Result);

  If ATamanho > 0 Then
    Exit(LeftStr(Result, ATamanho));
end;

function TBancoBradescoAPI.RetornaErrosTratadosDaAPI(ACodigoRetorno: Integer;
  AJsonRetorno: String): String;
  Var
    LJsonObject: TJsonObject;
begin
  If MatchStr(AJsonRetorno, [EmptyStr, '{}']) Then
    Exit(EmptyStr);

  Try
    LJsonObject := TJSONObject.ParseJSONValue(AJsonRetorno) As TJsonObject;

    Result := LJsonObject.GetValue<String>('mensagem') + ' - ' + LJsonObject.GetValue<String>('causa');
    If Result.Contains('CBTT0403 - USUARIO NAO AUTORIZADO') Then
      Result := Result + #13 + 'Verifique os dados da conta na carteira e se todos os recursos ' +
                               'necessários foram liberados no Portal Developers do Bradesco.';
  Except
    Result := AJsonRetorno;
  End;
end;

function TBancoBradescoAPI.RetornaInstrucaoCarteira(
  ADadosCliente: TDataset): String;
begin
  Result := FDadosCarteira.Instrucao01;

  If ADadosCliente.FieldByName('CLI_PROPER').AsString.Equals('S') Then
  Begin
    If Not FDadosCarteira.InstrucaoPersonalizada.IsEmpty Then
      Result := FDadosCarteira.InstrucaoPersonalizada;
  End;
end;

function TBancoBradescoAPI.RetornaListaDeCarteiras: TStringList;
  Var
    LConsulta: TUniQuery;

    LChave: String;
begin
  Result := TStringList.Create;

  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT SIS_CHAVE_, SIS_VALCFG ' +
                          'FROM CFGBAN ' +
                          'WHERE SIS_CODBAN="237" ' +
                          '  AND SIS_NUMPOS="API" ' +
                          '  AND SIS_CODCFG="NUMCTAC" ';

    If FDadosCarteira.ImportarEmpresas.Equals('S') Then
      LConsulta.SQL.Add('  AND SIS_CODEMP IN (' + fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ') ' +
                        '  AND SIS_CHAVE_ LIKE "CONFIG237API-%-%" ' +
                        'GROUP BY SIS_CHAVE_ ' +
                        'ORDER BY SIS_CHAVE_ ')
    Else
      LConsulta.SQL.Add('  AND SIS_CHAVE_ = "' + FDadosCarteira.CarteiraCompleta + '" ');

    LConsulta.Open;

    While Not LConsulta.Eof Do
    Begin
      LChave := LConsulta.FieldByName('SIS_CHAVE_').AsString + '|' +  LConsulta.FieldByName('SIS_VALCFG').AsString;
      If Result.IndexOf(LChave) = -1 Then
        Result.Add(LChave);

      LConsulta.Next;
    End;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

function TBancoBradescoAPI.RetornaTextoErro(ACodigoRetorno,
  ADadosRetorno: String): String;
  Var
    LJsonObject: TJsonObject;

    LErro: String;
begin
  Result := 'Status: ' + ACodigoRetorno + ' - Erro: ' + ADadosRetorno;

  If Not MatchStr(ACodigoRetorno, ['400']) Then
    Exit;

  LJsonObject := TJSONObject.ParseJSONValue(ADadosRetorno) As TJsonObject;

  If LJsonObject = Nil Then
    Exit;

  Try
    If Not RetornaValorJson(LJsonObject, 'codigoRetorno').IsEmpty Then
    Begin
      LErro := 'Status: ' + ACodigoRetorno + ' - Erro: ';
      LErro := LErro + RetornaValorJson(LJsonObject, 'codigoRetorno') + ' - ' +
                       RetornaValorJson(LJsonObject, 'mensagemRetorno') + '. ';

      Result := LErro;
    End;

    If Not RetornaValorJson(LJsonObject, 'statusHttp').IsEmpty Then
    Begin
      LErro := 'Status: ' + ACodigoRetorno + ' - Erro: ';
      LErro := LErro + ' - ' +
                       TrataMensagemErro(RetornaValorJson(LJsonObject, 'errorMessage')) + '. ';

      Result := LErro;
    End;

    FreeAndNil(LJsonObject);
  Except

  End;
end;

function TBancoBradescoAPI.RetornaValorDecimalJsonParaTJsonNumber(
  AValor: Double): TJSONNumber;
begin
  Try
    Result := TJsonNumber.Create(FormatFloat(',0.00', AValor).Replace('.', EmptyStr).Replace(',', '.'));
  Except
    Result := TJsonNumber.Create('0.00');
  End;
end;

function TBancoBradescoAPI.RetornaValorDuplicata(
  ADadosDuplicata: TDataSet): Double;
begin
  Result := ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat;

  If fCfgSis('VALIMP', varBoolean, FDadosCarteira.EmpresaCarteira) then
    Result := ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat +
              ADadosDuplicata.FieldByName('CTR_JURSUJ').AsFloat +
              ADadosDuplicata.FieldByName('CTR_DESCOB').AsFloat;

  If fCfgSis('DESBOL', varBoolean, FDadosCarteira.EmpresaCarteira) Then
    Result := Result -
              ADadosDuplicata.FieldByName('CTR_DESSUJ').AsFloat;
end;

function TBancoBradescoAPI.TrataMensagemErro(ATextoErro: String): String;
begin
  Result := ATextoErro;

  If ATextoErro.Contains('DADOS INCONSISTENTES -') Then
    Result := 'Dados Inconsistentes. Verifique os dados de Agência, Conta Corrente, Código da Carteira e Cedente ' +
              'gravados na configuração da carteira';
end;

function TBancoBradescoAPI.UtilizaDescontoDePontualidade(
  AValorDesconto: Double): Boolean;
begin
  Result := False;

  If fCfgSis('DESPON', varBoolean, FDadosCarteira.EmpresaCarteira) Then
  Begin
    If (AValorDesconto > 0) Then
      Result := True;
  End;
end;

procedure TBancoBradescoAPI.ValidaStatusErro(ACodigoRetorno: Integer;
  AJsonRetorno: String);
begin
  If MatchStr(ACodigoRetorno.ToString, ['200', '201']) Then
    Exit;

  Case ACodigoRetorno Of
    401,403: Raise Exception.Create('BCOAPI - Erro código: ' + ACodigoRetorno.ToString + ' - Ocorreu um erro ao autorizar a requisição.' + #13 +
                                    'Erro gerado: ' + AJsonRetorno);
    400, 412, 500: Raise Exception.Create('BCOAPI - Erro código: ' + ACodigoRetorno.ToString + ' - Ocorreu um erro ao realizar a requisição.' + #13 +
                                          'Erro gerado: ' + RetornaErrosTratadosDaAPI(ACodigoRetorno, AJsonRetorno));
    Else Raise Exception.Create('Erro código: ' + ACodigoRetorno.ToString + ' - Ocorreu um erro ao realizar a requisição.' + #13 +
                                'Erro gerado: ' + AJsonRetorno);

  End;
end;

function TBancoBradescoAPI.VerificaSeADuplicataExisteCadrec(
  ABoleto: TRetornoPesquisaBancoBradescoAPI;
  out ADuplicata: TDuplicataCtr): Boolean;
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
                          'CTR_DTAENV                                      ' +
                          'FROM CADREC                                     ' +
                          'WHERE CTR_NOSNUM=:NOSNUM                        ' +
                          '  AND CTR_BCOENV=:BCOENV                        ' +
                          '  AND CTR_SEQBAI=0                              ';

    LPesquisa.ParamByName('NOSNUM').AsString   := fStrZero(RightStr(ABoleto.nossoNumero + ABoleto.digitoNossoNumero, 12), 12);
    LPesquisa.ParamByName('BCOENV').AsString   := '237';

    LPesquisa.Open;

    Result := Not LPesquisa.IsEmpty;
    If Not Result Then
    Begin
      LPesquisa.Close;

      LPesquisa.SQL.Text := 'SELECT AUTOINCREM, CTR_NUMDUP, CTR_CODEMP,      ' +
                            'CTR_PARCEL, CTR_ESPDOC, CTR_CODCLI, CTR_CARTEI, ' +
                            'CTR_DTAENV                                      ' +
                            'FROM CADREC                                     ' +
                            'WHERE CTR_NUMDUP=:NUMDUP                        ' +
                            '  AND CTR_PARCEL=:PARCEL                        ' +
                            '  AND CTR_ESPDOC=:ESPDOC                        ' +
                            '  AND CTR_CODEMP=:CODEMP                        ';

      LPesquisa.ParamByName('NUMDUP').AsString   := LeftStr(ABoleto.ctrlPartic, 12);
      LPesquisa.ParamByName('PARCEL').AsString   := Copy(ABoleto.ctrlPartic, 13, 3).Trim;
      LPesquisa.ParamByName('ESPDOC').AsString   := Copy(ABoleto.ctrlPartic, 16, 2).Trim;
      LPesquisa.ParamByName('CODEMP').AsString   := Copy(ABoleto.ctrlPartic, 18, 3).Trim;

      LPesquisa.Open;

      Result := Not LPesquisa.IsEmpty;
      If Not Result Then
        Exit;
    End;

    ADuplicata.strAutoIn := LPesquisa.FieldByName('AUTOINCREM').AsString;
    ADuplicata.strNumDup := LPesquisa.FieldByName('CTR_NUMDUP').AsString;
    ADuplicata.strParcel := LPesquisa.FieldByName('CTR_PARCEL').AsString;
    ADuplicata.strEspdoc := LPesquisa.FieldByName('CTR_ESPDOC').AsString;
    ADuplicata.strCodEmp := LPesquisa.FieldByName('CTR_CODEMP').AsString;
    ADuplicata.strCodCli := LPesquisa.FieldByName('CTR_CODCLI').AsString;

    If LPesquisa.RecordCount > 1 Then
    Begin
      LPesquisa.Filter := 'CTR_CARTEI=' + FDadosCarteira.CarteiraCompleta.QuotedString;
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
  Finally
    LPesquisa.Close;

    FreeAndNil(LPesquisa);
  End;
end;

end.
