unit untTBancoSicrediAPI;

interface

Uses Classes, SysUtils, IPPeerClient, IPPeerCommon,
     REST.Json, System.Json, untConstantes, System.Net.URLClient, IdIOHandler,
     IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent,
     IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, Vcl.StdCtrls, Forms,
     System.Generics.Collections, UniClientDataSet, DB, Uni, untGravando,
     untFuncoesSimples, IdCoder, IdCoder3to4, IdCoderMIME,untTRegBol,StrUtils,
     DateUtils,untFuncAutban,Winapi.Windows,untFuncoesBoleto,REST.Types, REST.Client,
     untTypesSistema,untCNFOCO_Class, untCNFOCO_Dao,untLogCtr, untTRestSynalistAutban, untArqNaoGravados;

Type
  EExceptionBancoSicrediAPI = class(Exception);

  TDetalhamento = Record
    ValorPago,
    ValorCreditado,
    ValorIOF,
    ValorTarifa,
    CanalPagamento,
    EndToEndID,
    TextoMensagemBloqueto,
    CodigoModalidadeTitulo,

    NumeroTituloCedenteCobranca,
    DataVencimentoTituloCobranca,
    ValorOriginalTituloCobranca,
    DataEmissaoTituloCobranca : String;

    NumeroCarteiraCobranca,
    NumeroVariacaoCarteiraCobranca,
    CodigoLinhaDigitavel,
    TextoCodigoBarrasTituloCobranca,
    NumeroContratoCobranca : String;

    qrCodeURL,
    qrCodeTxId,
    qrCodeEmv : String;

  private
    function RetornaCodigoModalidadeTitulo: String;
    function RetornaValorTarifa: String;
    function DataEmissaoTituloCobrancaAsDate: String;
    function DataVencimentoTituloCobrancaAsDate: String;
  public
    Property TipoDeCobranca  : String  Read RetornaCodigoModalidadeTitulo  Write CodigoModalidadeTitulo;
    Property Tarifa          : String  Read RetornaValorTarifa             Write ValorTarifa;

    Property ADataVencimentoTituloCobranca  : String  Read DataVencimentoTituloCobrancaAsDate  Write DataVencimentoTituloCobranca;
    Property ADataEmissaoTituloCobranca     : String  Read DataEmissaoTituloCobrancaAsDate     Write DataEmissaoTituloCobranca;
  End;

Type
  TRetornoPesquisaBancoSicrediApi = class
  private
    function GetNossoNumero: String;
    function DataRegistroAsDate: String;
    function DataMovimentoAsDate: String;
    function DataVencimentoAsDate: String;
    function DataCreditoAsDate: String;
    function ValorPagoCedente:String;
  public
    indicadorContinuidade,
    quantidadeRegistros,
    proximoIndice,
    LinhaDigitavel,
    BoletoDataRegistro,
    BoletoDataVencimento,
    BoletoCooperativa,        //--
    BoletoCodigoBeneficiario,
    BoletoCooperativaPostoBeneficiario,
    BoletoNumeroBoleto,
    BoletoNumControle,
    BoletoTipoCarteira,
    BoletoDataPagamento,
    BoletoDataMovimento,
    BoletoValorOriginal,
    BoletoValorPago,
    BoletoValorJuros,
    BoletoValorDesconto,
    ValorMulta,
    BoletoValorAbatimentoLiquido,
    BoletoTipoLiquidacao,
    BoletoCarteiraConvenio,
    BoletoVariacaoCarteiraConvenio,
    BoletoDataCredito,
    BoletoCodigoBarras,
    BoletoSeuNumero,
    BoletoDataEmissao,
    ValorDesconto,
    ValorJuros,
    BoletoCodigoPagador,
    BoletoDocumentoPagador,
    BoletonomePagador,
    TxIdPix,
    NomeDoArquivo,
    CodigoCarteira: String;
    Property NossoNumero            : String  Read GetNossoNumero        Write BoletoNumeroBoleto;
    Property ABoletoDataRegistro    : String  Read DataRegistroAsDate    Write BoletoDataRegistro;
    Property ABoletoDataVencimento  : String  Read DataVencimentoAsDate  Write BoletoDataVencimento;
    Property ABoletoDataMovimento   : String  Read DataMovimentoAsDate   Write BoletoDataMovimento;
    Property ABoletoDataCredito     : String  Read DataCreditoAsDate     Write BoletoDataCredito;
    Property ABoletoValorPago       : String  Read ValorPagoCedente      Write BoletoValorPago;
  end;

Type
  TDadosCarteira = class
  public
    LHomologacao : Boolean;
    LCarteiraBanco,
    LEmpresaCarteira,
    LCarteiraCompleta,
    LLinkInclusao,
    LlinkBaixa,
    FLinkConsultaBoletosDia,
    FLinkConsultaBoletoNossoNumero,
    FLinkAlteracao,
    FOcorrenciasDeEncargo,
    LLinkApi,
    LLinkTokenAPI,
    LKeyUser,

    LCooperativa,
    LCodigoBeneficiario,
    LPosto,
    LTipoCobranca, // tipo cobranca 0 - Normal; 1 - Hibrido;
    LTipoDocto,    // Duplicata, Boleto, etc.
    LTipoDesc,     // tipo desconto;
    LTipoJuros,    // tipo juros;

    LPassword,
    LQtdDiasProtesto,
    LQtdDiasLimitePagto,
    LObservacao1,
    LObservacao2,
    LObservacao3,
    LObservacao4,
    LObservacao5,
    MigrouUf,
    LPercenMulta,
    LQtdDiasNegativacao,
    LQtdDiasNegativacaoMS,
    QtdDiasNegativacaoSP,
    LAceite,
    ImportarEmpresas,
    ImportacaoOtimizada,
    BaixarBoletosGeradoPorArquivo,

    AutoIncremChavePix: String;
  end;

Type
  TBancoSicrediAPI = class(TObject)
  private

    FHandleRequisicoes: THandle;
    LDadosCarteira : TDadosCarteira;
    LPercentualMulta,
    LPercentualMora: Double;
    LFaturamento: Boolean;
    FTentarNovamente: Boolean;
    LNossoNumeroCancelamento : String;
    LCancelarRegistro : Boolean;
    LDuplicataCancelamento: String;

    ListaRequisicaoRegistroBoleto : TList<TRequisicaoRegistroBoleto>;
    LRetornoBancoSicrediAPI: TRetornoBoletoBancoSicredi;

    FPastaAutcom: String;

    FRestSynalist: TRestSynalistAutban;

    FTokenUsoAtual: String;

    RestExecute : function (const AMetodo, AUrl,AToken : WideString;
                            out AJsonRetorno: WideString; AJsonEnvio: WideString = '';
                            AKeyUser : WideString = ''; ACooperativa : WideString = ''; APosto: WideString = ''; ABeneficiario: WideString = ''): Integer; stdcall;


    procedure CriarComponenteRequisicao;
    function DeveAdicionarDuplicata(ARetorno: TRetornoPesquisaBancoSicrediApi;
                                    ADataInicial,
                                    ADataFinal: TDateTime): Boolean;
    Procedure GerarToken;
    procedure DefinirURL;
    procedure CarregaDadosCarteira(ACarteira: String);
    function RetornaValorDuplicata(ADadosDuplicata: TDataSet): Double;
    function RetornaDadosDaRequisicao(ADadosDuplicata, ADadosCliente: TDataset;ANosNum:String): String;
    function RetornaDiasNegativacaoAuto(const AEstado: string; const LDadosCarteira: TDadosCarteira): Integer;
    function RetornaDadosDaRequisicaoBaixa: String;
    function RetornaDadosDaRequisicaoAlteracao(ADadosDuplicata: TDataSet):String;
    function RetornaCampoDecimalJSON(AValor: String): String;
    function RetornaValorString(AValor: String; ATamanho: Integer = 0): String;
    function RetornaDesconto(ADadosDuplicata : TDataSet): TJsonObject;
    function UtilizaDescontoDePontualidade(AValDes:Double): Boolean;
    function RetornaPagador(ADadosCliente : TDataSet): TJsonObject;
    function RetornaDescontoPontualidade(ADadosDuplicata : TDataSet):TJsonObject;
    function RetornaSegundoDesconto(ADadosDuplicata : TDataSet):TJsonObject;
    function RetornaCampoNossoNumero(ANosNum: String):String;
    function RetornaTipoDocumento(AIndice: Integer): String;
    function PrettyJSON(jsonstring:String):String;
    procedure Aguarde(msecs: Integer);
    procedure AguardeCincoSegundos;
    function RetornaJsonRegistroBoleto(AAutoIncrem: String): String;
    function EncontrarJsonRegistroBoleto(AAutoIncrem: String):String;
    procedure AtualizaDadosExportacaoRemessa(ACadRec: TDataSet;
                                             ADadosRetorno: TRetornoBoletoBancoSicredi);
    function RetornaLinkBaixa(ANosNum:String):String;
    function RetornaLinkAlteracao(ADadosDuplicata : TDataSet):String;
    function RetornaValorJson(AObjeto: TJsonObject;ANomeCampo: String): String;
    procedure CarregaOcorrenciasDeEncargosBancarios;

    procedure ValidaStatusErro(AStatus: Integer; ARetornoGet: String);
    Function RetornaTextoErro(ARetornoGet: String): String;
    //procedure RetornaValorJurosDescontos(var ADadosBoleto: TRetornoPesquisaBancoSicrediApi);
    function RetornaJurosMoraStr(ADadosDuplicata: TDataSet): String;
    function RetornaMultaStr(ADadosDuplicata: TDataSet): String;
    function RetornaNovaDataVencimentoStr(ADadosDuplicata: TDataSet): String;
    //function RetornaLinkConsultaBoletosDia(ACodBeneficiario: String; ADia: String; ACnpjBenefFinal: String = ''; APagina: String = ''): String;
    function RetornaDataFormatada(strData: String): String;
    function RetornaLinkConsultaBoletosNossoNumero(ACodBeneficiario, ANosNum:String): String;

    procedure ExibeFormMensagemErro(AMensagem: String);

    { nova forma de pesquisa }
    function RetornaListaDeCarteiras(ABeneficiario: String = ''): TStringList;
    function RetornaListaDadosRetornoDia(AJsonRetorno: String): TList<TRetornoPesquisaBancoSicrediApi>;
    function ConsultaBoletosTodasEmpresas(ADataInicial,
                                          ADataFinal: TDateTime;
                                          var AProgresso: TfrmGravando): TList<TRetornoPesquisaBancoSicrediApi>;

    function ConsultaBoletosLiquidadosPorDia(ADataInicial,
                                             ADataFinal: TDateTime;
                                             AListaImportada: TList<TRetornoPesquisaBancoSicrediApi>;
                                             var AProgresso: TfrmGravando): TList<TRetornoPesquisaBancoSicrediApi>;

    function ConsultaBoletosMesmoBeneficiario(ADataInicial,
                                              ADataFinal: TDateTime;
                                              var AProgresso: TfrmGravando): TList<TRetornoPesquisaBancoSicrediApi>;

    procedure AdicionaBoletosDataEmissaoLista(ADataInicial,
                                              ADataFinal: TDateTime;
                                              var AListaImportada: TList<TRetornoPesquisaBancoSicrediApi>);

    procedure ConsultaBoletoPorNossoNumero(ADataInicial,
                                           ADataFinal: TDateTime;
                                           var AListaImportada: TList<TRetornoPesquisaBancoSicrediApi>;
                                           var AProgresso: TfrmGravando;
                                           AContador: Integer = 0;
                                           ATotalCarteira: Integer = 0);
  public
    constructor Create(ACarteira: String);
    Destructor Destroy; Override;

    function CadastrarNovoBoleto(ADadosDuplicata, ADadosCliente: TDataSet; Var ANosNum: String): TRetornoBoletoBancoSicredi;
    procedure BaixaBoletoRegistrado(ADataSet: TDataSet);
    procedure AlterarBoletoRegistrado(ADuplicata:TDataSet);
    procedure CancelarRegistroBoleto;
    procedure ReimpressaoDeBoleto(AAutoIncrem: String);

    function RetonaDuplicatasBoletoGerado(ACarteira: String;
                                          ADataInicial,
                                          ADataFinal: TDateTime): TUniClientDataSet;

    function ConsultaBoletosPorPeriodo(ADataInicial,
                                       ADataFinal: TDateTime;
                                       AProgresso: TfrmGravando): TList<TRetornoPesquisaBancoSicrediApi>;
    function RetornaDadosPesquisaBoleto(ADadosRetorno: String): TRetornoPesquisaBancoSicrediApi;
    function RetornaValorJsonValue(AObjeto: TJsonValue; ANomeCampo: String): String;

    procedure CancelarBoletos(ADataSet:TDataSet);
    procedure AlterarBoletos(ADataSet:TDataSet);
    function VerificaSeADuplicataExisteCadrec(ABoleto: TRetornoPesquisaBancoSicrediApi; out ADuplicata: TDuplicataCtr): Boolean;
    procedure GravarDadosRequisicaoRegistroBoleto;

    Function Valida_Configuracao_Token(LKeyUser,
                                       LCodigoBeneficiario,
                                       LCooperativa,
                                       LPassword : String;
                                       LAmbiente : Integer;
                                       LCarteira : String ): String;

    Function VerificaRetornoValidacaoToken(AStatusCode: Integer; ARetorno: String): String;

    function DeveBloquearSeFoiGeradoPorArquivo(ADuplicata: TDuplicataCtr): Boolean;

    procedure CarregaCarteiraEmpresaImportacao(Var ACarteira,
                                               AEmpresaImportacao: String;
                                               ABoleto: TRetornoPesquisaBancoSicrediApi);

    property DadosCarteira: TDadosCarteira Read LDadosCarteira;

    property PercentualMulta  : Double    Read LPercentualMulta  Write LPercentualMulta;
    property PercentualMora   : Double    Read LPercentualMora   Write LPercentualMora;
    property Faturamento      : Boolean   Read LFaturamento      Write LFaturamento;
    property TentarNovamente  : Boolean   Read FTentarNovamente  Write FTentarNovamente;
    property CancelarRegistro : Boolean   Read LCancelarRegistro Write LCancelarRegistro;

    property NossoNumeroCancelamento  : String    Read LNossoNumeroCancelamento Write LNossoNumeroCancelamento;
    property DuplicataCancelamento    : String    Read LDuplicataCancelamento   Write LDuplicataCancelamento;

    property RetornoBancoSicrediAPI  : TRetornoBoletoBancoSicredi Read  LRetornoBancoSicrediAPI Write LRetornoBancoSicrediAPI;

    function fDiasNegativacaoParaMatoGrossoDoSulEhInvalido(AUFCliente: String): Boolean;
  End;

const
  C_URL            = 'https://api-parceiro.sicredi.com.br/cobranca/boleto/v1/boletos';
  C_URL_HOM        = 'https://api-parceiro.sicredi.com.br/sb/cobranca/boleto/v1/boletos';

  C_URL_OAUTH_PROD = 'https://api-parceiro.sicredi.com.br/auth/openapi/token';
  C_URL_OAUTH_HOM  = 'https://api-parceiro.sicredi.com.br/sb/auth/openapi/token';

  INDICADOR_SITUACAO: Array of String = ['A', 'B'];

implementation

{ TBancoSicrediAPI }
procedure TBancoSicrediAPI.AdicionaBoletosDataEmissaoLista(ADataInicial,
  ADataFinal: TDateTime;
  var AListaImportada: TList<TRetornoPesquisaBancoSicrediApi>);
  Var
    LConsulta: TUniQuery;

    LBoleto: TRetornoPesquisaBancoSicrediApi;
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
                          '  CTR_TX_BOL, ' +
                          '  CTR_LINDIG  ' +
                          'FROM CADREC ' +
                          'WHERE CTR_DTAENV BETWEEN :DTAINI AND :DTAFIM ' +
                          '  AND CTR_BCOBOL="748" ' +
                          '  AND CTR_DTAREC IS NULL ' +
                          '  AND CTR_CARTEI=:CARTEI ' +
                          '  AND CTR_SEQBAI=0 ' +
                          'ORDER BY CTR_DTAVEN, CTR_NOSNUM';

    LConsulta.ParamByName('CARTEI').AsString := LDadosCarteira.LCarteiraCompleta;
    LConsulta.ParamByName('DTAINI').AsDateTime := ADataInicial;
    LConsulta.ParamByName('DTAFIM').AsDateTime := ADataFinal;

    LConsulta.Open;

    While Not LConsulta.Eof Do
    Begin
      LBoleto := TRetornoPesquisaBancoSicrediApi.Create;
      LBoleto.CodigoCarteira := LDadosCarteira.LCarteiraCompleta;
      LBoleto.NossoNumero := LConsulta.FieldByName('CTR_NOSNUM').AsString;
      LBoleto.BoletoDataVencimento := FormatDateTime('dd/mm/yyyy', LConsulta.FieldByName('CTR_DTAVEN').AsDateTime);

      AListaImportada.Add(LBoleto);

      Application.ProcessMessages;

      LConsulta.Next;
    End;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;

end;

procedure TBancoSicrediAPI.Aguarde(msecs: Integer);
  var
    FirstTickCount: LongInt;
begin
  FirstTickCount := GetTickCount;
  repeat
    Application.ProcessMessages;
  until ((LongInt(GetTickCount) - LongInt(FirstTickCount)) >= LongInt(msecs));
end;

procedure TBancoSicrediAPI.AguardeCincoSegundos;
begin
  Aguarde(5000);
end;


procedure TBancoSicrediAPI.AlterarBoletoRegistrado(ADuplicata: TDataSet);
  Var
    LRetornoPatch: WideString;
    LRetornoPatchS: String;
    LDadosRequisicao: String;
    LRequisicaoAlteraBoleto : TRequisicaoRegistroBoleto;
    LStatus: Integer;
    LParametros: TStringList;
begin
  LRequisicaoAlteraBoleto := TRequisicaoRegistroBoleto.Create;
  Self.FTentarNovamente := True;

  LRequisicaoAlteraBoleto.LCartei :=  LDadosCarteira.LCarteiraBanco + '-' +  LDadosCarteira.LEmpresaCarteira;
  LRequisicaoAlteraBoleto.LCodBco := '748';
  LRequisicaoAlteraBoleto.FDescricao := 'ALTERAÇÃO';
  LRequisicaoAlteraBoleto.LLocImp := 'ATB';

  LDadosRequisicao := RetornaDadosDaRequisicaoAlteracao(ADuplicata);
  LRequisicaoAlteraBoleto.FRequisicao := LDadosRequisicao;
  LRequisicaoAlteraBoleto.LDuplic := ADuplicata.FieldByName('AUTOINCREM').AsString;
  LRequisicaoAlteraBoleto.LLnkApi := RetornaLinkAlteracao(ADuplicata);

  Try
    Try
      GerarToken;

      If fCfgSis('DLLBOL', varBoolean) Then
      Begin

        LStatus := RestExecute('PATCH',
                               RetornaLinkAlteracao(ADuplicata),
                               'Bearer ' + FTokenUsoAtual,
                               LRetornoPatch,
                               LDadosRequisicao,
                               LDadosCarteira.LKeyUser,
                               LDadosCarteira.LCooperativa,
                               LDadosCarteira.LPosto,
                               LDadosCarteira.LCodigoBeneficiario);

        If LStatus <> 202 Then
          Raise Exception.Create('Status: ' + LStatus.ToString + ' Erro: ' + LRetornoPatch);

      End
      Else
      If Not fCfgSis('DLLBOL', varBoolean) Then
      Begin

        LParametros := TStringList.Create;

        LParametros.Add('x-api-key: ' + LDadosCarteira.LKeyUser);
        LParametros.Add('Authorization: bearer ' + FTokenUsoAtual);
        LParametros.Add('cooperativa:' + LDadosCarteira.LCooperativa);
        LParametros.Add('posto:' + LDadosCarteira.LPosto);
        LParametros.Add('codigoBeneficiario:' + LDadosCarteira.LCodigoBeneficiario);

        Try

            LStatus := FRestSynalist.ExecuteRestSynalist_Sicredi('PATCH',
                                                                 RetornaLinkAlteracao(ADuplicata),
                                                                 LParametros,
                                                                 LRetornoPatchS,
                                                                 LDadosRequisicao);

        Finally
          FreeAndNil(LParametros);
        End;

      End;

      Self.FTentarNovamente := False;

      If fCfgSis('DLLBOL', varBoolean) Then
         LRequisicaoAlteraBoleto.LJsoRec := LRetornoPatch
      Else
         LRequisicaoAlteraBoleto.LJsoRec := LRetornoPatchS;

      untLogCtr.GravaLogCtr(ADuplicata.FieldByName('AUTOINCREM').AsString,
                           'ALTERAÇÃO DATA VENCIMENTO DO BOLETO - BANCO SICREDI [ONLINE]' ,
                           'TBancoSicrediAPI');
    Except
      On E: Exception Do
      Begin
        LRequisicaoAlteraBoleto.LExcept := E.Message;

        If Not (Pos('Nova data vencimento não pode ser igual a anterior.',E.Message) > 0) Then
        Begin
          TfrmGravando.fExecutarModalA(AguardeCincoSegundos,'Falha na comunicação, Nova tentativa em 5 segundos.', '');
          Raise Exception.Create(E.Message);
        End;
      End;
    End;
  Finally
    Begin
      ListaRequisicaoRegistroBoleto.Add(LRequisicaoAlteraBoleto);
    End;
  End;
end;

procedure TBancoSicrediAPI.AlterarBoletos(ADataSet: TDataSet);
  Var
    LDocumentosRestantes : String;
    LErroAPI : Boolean;
    LContadorTentativas : Integer;
begin
  Try
    LContadorTentativas := 1;
    LErroAPI := False;
    ADataSet.First;

    frmGravandoGenericProcedure.pgbStatus.Visible := True;
    frmGravandoGenericProcedure.pgbStatus.Position := 0;
    frmGravandoGenericProcedure.pgbStatus.Properties.Max := ADataSet.RecordCount;


    While (LContadorTentativas <= 4) Do
    Begin
      Try

        While Not ADataSet.Eof Do
        Begin
          AlterarBoletoRegistrado(ADataSet);

          ADataSet.Next;
          pStep(frmGravandoGenericProcedure.pgbStatus);
          LContadorTentativas := 0;
        End;

        LErroAPI := False;

      Except
        On E:Exception Do
        begin

          LErroAPI := True;


          If (LContadorTentativas >= 4) Or Not Self.FTentarNovamente Then
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

            Raise Exception.Create('Ocorreram erros ao alterar o(s) boleto(s) no Banco do Brasil [Online].' + #13 +
                                   'Erro gerado: ' + E.Message + #13 +
                                   'Documento(s) ficaram sem alterar o boleto: ' + LDocumentosRestantes);
          End;

          Inc(LContadorTentativas);

        End;

      End;


      If Not LErroAPI Then
      Begin
        pMensagemOk('Alteração realizada com sucesso!');
        Break;
      End;
    End;

    frmGravandoGenericProcedure.pgbStatus.Visible := False;
  Finally
    GravarDadosRequisicaoRegistroBoleto;
  End;
end;

procedure TBancoSicrediAPI.AtualizaDadosExportacaoRemessa(ACadRec: TDataSet;
  ADadosRetorno: TRetornoBoletoBancoSicredi);
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
    LSql := LSql + '  CTR_LNKCIT = :LNKCIT ';
    LSql := LSql + 'WHERE ';
    LSql := LSql + '  CTR_NUMDUP = :NUMDUP AND ';
    LSql := LSql + '  CTR_PARCEL = :PARCEL AND ';
    LSql := LSql + '  CTR_ESPDOC = :ESPDOC AND ';
    LSql := LSql + '  CTR_CODEMP = :CODEMP AND ';
    LSql := LSql + '  CTR_CODCLI = :CODCLI AND ';
    LSql := LSql + '  CTR_SEQBAI = 0 ';

    Try
      LCadRec.Close;
      LCadRec.Sql.Clear;
      LCadRec.Sql.Add(LSql);
      LCadRec.ParamByName('CODBCO').AsString := '748';

      If Not ADadosRetorno.QrCodeTxId.IsEmpty Then
      Begin
        LCadRec.ParamByName('TX_BOL').AsString := ADadosRetorno.QrCodeTxId;
        LCadRec.ParamByName('QRCODE').AsString := ADadosRetorno.QrCodeEmv;
        LCadRec.ParamByName('PIXLOC').AsString := ADadosRetorno.QrCodeUrl;
        LCadRec.ParamByName('LNKCIT').AsString := ADadosRetorno.QrCodeLinkCitel;
      End;

      LCadRec.ParamByName('NUMDUP').AsString := ACadRec.FieldByName('CTR_NUMDUP').AsString;
      LCadRec.ParamByName('PARCEL').AsString := ACadRec.FieldByName('CTR_PARCEL').AsString;
      LCadRec.ParamByName('ESPDOC').AsString := ACadRec.FieldByName('CTR_ESPDOC').AsString;
      LCadRec.ParamByName('CODEMP').AsString := ACadRec.FieldByName('CTR_CODEMP').AsString;
      LCadRec.ParamByName('CODCLI').AsString := ACadRec.FieldByName('CTR_CODCLI').AsString;
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

procedure TBancoSicrediAPI.BaixaBoletoRegistrado(ADataSet:TDataSet);
  Var
    LRetornoPost: WideString;
    LRetornoPostS: String;
    LDadosRequisicao: String;
    LRequisicaoAlteraBoleto : TRequisicaoRegistroBoleto;
    LStatus: Integer;
    LParametros: TStringList;
begin
  Self.FTentarNovamente := True;
  LRequisicaoAlteraBoleto := TRequisicaoRegistroBoleto.Create;

  LRequisicaoAlteraBoleto.LCartei :=  LDadosCarteira.LCarteiraBanco + '-' +  LDadosCarteira.LEmpresaCarteira;
  LRequisicaoAlteraBoleto.LCodBco := '748';
  LRequisicaoAlteraBoleto.FDescricao := 'CANCELAMENTO';
  LRequisicaoAlteraBoleto.LLocImp := 'ATB';

  LDadosRequisicao := RetornaDadosDaRequisicaoBaixa;
  LRequisicaoAlteraBoleto.FRequisicao := LDadosRequisicao;
  LRequisicaoAlteraBoleto.LDuplic := ADataSet.FieldByName('AUTOINCREM').AsString;
  LRequisicaoAlteraBoleto.LLnkApi := RetornaLinkBaixa(ADataSet.FieldByName('CTR_NOSNUM').AsString);

  Try
    Try
      GerarToken;

      If fCfgSis('DLLBOL', varBoolean) Then
      Begin

        LStatus := RestExecute('PATCH',
                               RetornaLinkBaixa(ADataSet.FieldByName('CTR_NOSNUM').AsString),
                               'Bearer ' + FTokenUsoAtual,
                               LRetornoPost,
                               LDadosRequisicao,
                               LDadosCarteira.LKeyUser,
                               LDadosCarteira.LCooperativa,
                               LDadosCarteira.LPosto,
                               LDadosCarteira.LCodigoBeneficiario);

        If LStatus <> 202 Then
          Raise Exception.Create('Status: ' + LStatus.ToString + ' Erro: ' + LRetornoPost);

      End
      Else
      If Not fCfgSis('DLLBOL', varBoolean) Then
      Begin

        LParametros := TStringList.Create;

        LParametros.Add('Authorization: bearer ' + FTokenUsoAtual);
        LParametros.Add('x-api-key: ' + LDadosCarteira.LKeyUser);
        LParametros.Add('cooperativa:' + LDadosCarteira.LCooperativa);
        LParametros.Add('posto:' + LDadosCarteira.LPosto);
        LParametros.Add('codigoBeneficiario:' + LDadosCarteira.LCodigoBeneficiario);

        Try

            LStatus := FRestSynalist.ExecuteRestSynalist_Sicredi('PATCH',
                                                                 RetornaLinkBaixa(ADataSet.FieldByName('CTR_NOSNUM').AsString),
                                                                 LParametros,
                                                                 LRetornoPostS,
                                                                 LDadosRequisicao);

        Finally
          FreeAndNil(LParametros);
        End;

      End;

      Self.FTentarNovamente := False;

      If fCfgSis('DLLBOL', varBoolean) Then
         LRequisicaoAlteraBoleto.LJsoRec := LRetornoPost
      Else
         LRequisicaoAlteraBoleto.LJsoRec := LRetornoPostS;

      LimpaDadosBoleto(ADataSet.FieldByName('AUTOINCREM').AsString);

      untLogCtr.GravaLogCtr(ADataSet.FieldByName('AUTOINCREM').AsString,
                           'CANCELAMENTO DE BOLETO - BANCO SICREDI [ONLINE]',
                           'TBancoSicrediAPI');

      If Not fEmptyStr(ADataSet.FieldByName('CTR_LNKCIT').AsString) Then
          TFuncoesPixBoleto.RemoverLinkCitelPixBoleto(fRetCGCEmpresa(ADataSet.FieldByName('CTR_CODEMP').AsString),
                                                      ADataSet.FieldByName('CTR_CODEMP').AsString,
                                                      ADataSet.FieldByName('CTR_TX_BOL').AsString,
                                                      LDadosCarteira.AutoIncremChavePix,
                                                      True);
    Except
      On E: Exception Do
      Begin
        LRequisicaoAlteraBoleto.LExcept := E.Message;
        TfrmGravando.fExecutarModalA(AguardeCincoSegundos,'Falha na comunicação, Nova tentativa em 5 segundos.', '');
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    Begin
      ListaRequisicaoRegistroBoleto.Add(LRequisicaoAlteraBoleto);
    End;
  End;
end;

function TBancoSicrediAPI.CadastrarNovoBoleto(ADadosDuplicata,ADadosCliente: TDataSet; Var ANosNum: String): TRetornoBoletoBancoSicredi;
  Var
    LRetornoPostW: WideString;
    LRetornoPostS: String;
    LDadosRequisicao: String;
    LJsonRetorno: TJSONObject;
    LRequisicaoRegistroBoleto : TRequisicaoRegistroBoleto;
    LStatus : Integer;
    LParametros: TStringList;
begin

  If LDadosCarteira.LTipoCobranca.Equals('1') Then
  Begin
    If LDadosCarteira.AutoIncremChavePix.IsEmpty Then
      Raise Exception.Create('Para utilizar a carteira com o tipo de cobrança hibrida, é obrigatório selecionar uma chave Pix.');
  End;

  Self.FTentarNovamente := True;
  Result := TRetornoBoletoBancoSicredi.Create;
  LRequisicaoRegistroBoleto := TRequisicaoRegistroBoleto.Create;

  LRequisicaoRegistroBoleto.LCartei :=  LDadosCarteira.LCarteiraBanco + '-' +  LDadosCarteira.LEmpresaCarteira;
  LRequisicaoRegistroBoleto.LCodBco := '748';
  LRequisicaoRegistroBoleto.LLocImp := IIF(Self.LFaturamento,'FAT','CTR');
  LRequisicaoRegistroBoleto.FDescricao := 'REGISTRO';

  LDadosRequisicao := RetornaDadosDaRequisicao(ADadosDuplicata, ADadosCliente, ANosNum);
  LRequisicaoRegistroBoleto.FRequisicao := LDadosRequisicao;
  LRequisicaoRegistroBoleto.LDuplic := ADadosDuplicata.FieldByName('AUTOINCREM').AsString;
  LRequisicaoRegistroBoleto.LLnkApi := LDadosCarteira.LLinkInclusao;

  LRequisicaoRegistroBoleto.LJsoEnv := LDadosRequisicao;

  Try
    Try
      GerarToken;

      If fCfgSis('DLLBOL', varBoolean) Then
      Begin

        LStatus := RestExecute('POST',
                                LDadosCarteira.LLinkInclusao,
                                'Bearer ' + FTokenUsoAtual,
                                LRetornoPostW,
                                LDadosRequisicao,
                                LDadosCarteira.LKeyUser,
                                LDadosCarteira.LCooperativa,
                                LDadosCarteira.LPosto);

        If LStatus <> 201 Then
           Raise Exception.Create('Status: ' + LStatus.ToString + ' Erro: ' + LRetornoPostW);

      End
      Else
      If Not fCfgSis('DLLBOL', varBoolean) Then
      Begin
        LParametros := TStringList.Create;

        LParametros.Add('x-api-key: ' + LDadosCarteira.LKeyUser);
        LParametros.Add('Authorization: bearer ' + FTokenUsoAtual);
        LParametros.Add('cooperativa:' + LDadosCarteira.LCooperativa);
        LParametros.Add('posto:' + LDadosCarteira.LPosto);

        Try

            LStatus := FRestSynalist.ExecuteRestSynalist_Sicredi('POST',
                                                                 LDadosCarteira.LLinkInclusao,
                                                                 LParametros,
                                                                 LRetornoPostS,
                                                                 LDadosRequisicao);

            If LStatus <> 201 Then
               Raise Exception.Create('Status: ' + LStatus.ToString + ' Erro: ' + LRetornoPostS);

        Finally
          FreeAndNil(LParametros);
        End;

      End;

      Self.FTentarNovamente := False;

      If fCfgSis('DLLBOL', varBoolean) Then
      Begin
         LRequisicaoRegistroBoleto.LJsoRec := LRetornoPostW;
         LJsonRetorno := TJSONObject.ParseJSONValue(LRetornoPostW) as TJSONObject;
      End
      Else
      Begin
         LRequisicaoRegistroBoleto.LJsoRec := LRetornoPostS;
         LJsonRetorno := TJSONObject.ParseJSONValue(LRetornoPostS) as TJSONObject;
      End;

      Result.nossoNumero    := RetornaValorJson(LJsonRetorno,'nossoNumero');
      Result.linhaDigitavel := RetornaValorJson(LJsonRetorno,'linhaDigitavel');
      Result.codigoDeBarras := RetornaValorJson(LJsonRetorno,'codigoBarras');
      Result.cooperativa    := RetornaValorJson(LJsonRetorno,'cooperativa');
      Result.posto          := RetornaValorJson(LJsonRetorno,'posto');

      If IfEmptyStr(LDadosCarteira.LTipoCobranca, '0').Equals('1') Then
      Begin
        Result.QrCodeTxId     := fTiraEnter(RetornaValorJson(LJsonRetorno,'txid'));
        Result.QrCodeEmv      := fTiraEnter(RetornaValorJson(LJsonRetorno,'qrCode'));
      End;

      If Not Result.QrCodeTxId.IsEmpty Then
        Result.QrCodeLinkCitel := TFuncoesPixBoleto.IncluirLinkCitelPixBoleto('748',
                                                                              Result.QrCodeTxId,
                                                                              Result.QrCodeEmv,
                                                                              FormatFloat(',0.00', RetornaValorDuplicata(ADadosDuplicata)),
                                                                              LDadosCarteira.AutoIncremChavePix,
                                                                              ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime);

      AtualizaDadosExportacaoRemessa(ADadosDuplicata,
                                     Result);

    Except

      On E: Exception Do
      Begin
        LRequisicaoRegistroBoleto.LExcept := E.Message;

        TfrmGravando.fExecutarModalA(AguardeCincoSegundos,'Falha na comunicação, Nova tentativa em 5 segundos.', '');
        Raise Exception.Create(RetornaTextoErro(E.Message));
      End;
    End;
  Finally
    ListaRequisicaoRegistroBoleto.Add(LRequisicaoRegistroBoleto);
  End;
end;

procedure TBancoSicrediAPI.CancelarBoletos(ADataSet: TDataSet);
  Var
    LDocumentosRestantes : String;
    LErroAPI : Boolean;
    LContadorTentativas : Integer;
begin
  Try
    LContadorTentativas := 1;
    LErroAPI := False;
    ADataSet.First;

    frmGravandoGenericProcedure.pgbStatus.Visible := True;
    frmGravandoGenericProcedure.pgbStatus.Position := 0;
    frmGravandoGenericProcedure.pgbStatus.Properties.Max := ADataSet.RecordCount;


    While (LContadorTentativas <= 4) Do
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


          If (LContadorTentativas >= 4) Or Not Self.FTentarNovamente  Then
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

            ExibeFormMensagemErro('Ocorreram erros ao cancelar o(s) boleto(s) no Banco Banco Sicredi [Online].' + #13#10 + E.Message + #13#10 +
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

procedure TBancoSicrediAPI.CancelarRegistroBoleto;
begin
  BaixaBoletoRegistrado(Nil);
end;

procedure TBancoSicrediAPI.CarregaCarteiraEmpresaImportacao(var ACarteira,
  AEmpresaImportacao: String; ABoleto: TRetornoPesquisaBancoSicrediApi);
begin
  ACarteira := LDadosCarteira.LCarteiraCompleta.Split(['-'])[1];
  AEmpresaImportacao := EmptyStr;

  If ABoleto.CodigoCarteira.IsEmpty Then
    Exit;

  If Not ABoleto.BoletoCodigoBeneficiario.Equals(LDadosCarteira.LCodigoBeneficiario) Then
  Begin
    ACarteira := ABoleto.CodigoCarteira.Split(['-'])[1];
    AEmpresaImportacao := ABoleto.CodigoCarteira.Split(['-'])[2];
  End;
end;

procedure TBancoSicrediAPI.CarregaDadosCarteira(ACarteira: String);
begin
  LDadosCarteira := TDadosCarteira.Create;
  LDadosCarteira.LCarteiraBanco := LeftStr(ACarteira,14);
  LDadosCarteira.LEmpresaCarteira := RightStr(ACarteira, 3);
  LDadosCarteira.LCarteiraCompleta    := ACarteira;

  LDadosCarteira.LAceite              := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'PROACEI'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LQtdDiasProtesto     := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'DIAPROT'      ,'0', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LQtdDiasLimitePagto  := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'DIALIMI'      ,'0', LDadosCarteira.LEmpresaCarteira);

  LDadosCarteira.LObservacao1         := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'OBSERV1'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LObservacao2         := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'OBSERV2'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LObservacao3         := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'OBSERV3'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LObservacao4         := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'OBSERV4'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LObservacao5         := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'OBSERV5'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.MigrouUf             := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'MIGROU_DIANEG_UF','', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LPercenMulta         := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'PERMULT'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LQtdDiasNegativacao  := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'DIANEGA'      ,'0', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LQtdDiasNegativacaoMS:= fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'DIANEGAMS'    ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.QtdDiasNegativacaoSP := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'DIANEGASP'    ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LKeyUser             := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'KEY_USER'     ,'', LDadosCarteira.LEmpresaCarteira);

  LDadosCarteira.LCooperativa         := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'CODAGEN'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LCodigoBeneficiario  := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'NUMCTAC'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LPosto               := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'POSTO'        ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LTipoDocto           := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'TIPO_DOCTO'   ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LTipoCobranca        := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'TIPO_COBRANCA','', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LTipoDesc            := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'TIPO_DESC'    ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LTipoJuros           := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'TIPO_JUROS'   ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LPassword            := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'PASSWORD'     ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.ImportarEmpresas     := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'IMPORTEMP'    ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.ImportacaoOtimizada     := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'IMPOTIMIZADA'    ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.BaixarBoletosGeradoPorArquivo := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'BAIBOLARQ'    ,'N', LDadosCarteira.LEmpresaCarteira);

  LDadosCarteira.AutoIncremChavePix   := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'CHAPIX'       ,'', LDadosCarteira.LEmpresaCarteira);

  CarregaOcorrenciasDeEncargosBancarios;
  LDadosCarteira.LHomologacao         := (fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'TPAMBIENTE'   ,'', LDadosCarteira.LEmpresaCarteira) = '0');
end;

procedure TBancoSicrediAPI.CarregaOcorrenciasDeEncargosBancarios;
  Var
    lstCnfOco: TObjectList<TCnfOco>;
    objCnfOco: TCnfOco;
    objCnfDao: TCnfOcoDao;
    strOcoBco: String;
    strOcoLay: String;
    strNumPos: String;
    strOcoEsp: String;
    strOcoEmp: String;
    intOcoCar: Integer;
begin
  Try
    pDesmembraCarteira(LDadosCarteira.LCarteiraBanco + '-' + LDadosCarteira.LEmpresaCarteira,
                       strOcoBco, strOcoLay, strNumPos, strOcoEsp, strOcoEmp, intOcoCar);

    objCnfDao := TCnfOcoDao.Create(strOcoBco, strOcoLay, strNumPos,
                                   strOcoEsp, strOcoEmp, intOcoCar);

    lstCnfOco := objCnfDao.fBuscaTodas;
    If Assigned(lstCnfOco) Then
    Begin
      For objCnfOco in lstCnfOco Do
      Begin
        If fEmptyStr(LDadosCarteira.FOcorrenciasDeEncargo) Then
          LDadosCarteira.FOcorrenciasDeEncargo := '"'+objCnfOco.strCodOco+'"'
        Else
          LDadosCarteira.FOcorrenciasDeEncargo := LDadosCarteira.FOcorrenciasDeEncargo + ',"'+objCnfOco.strCodOco+'"';
      End;
    End;

  Finally
    If Assigned(lstCnfOco) Then
      FreeAndNil(lstCnfOco);

    If Assigned(objCnfDao) Then
      FreeAndNil(objCnfDao);
  End;
end;

procedure TBancoSicrediAPI.ConsultaBoletoPorNossoNumero(ADataInicial,
  ADataFinal: TDateTime;
  var AListaImportada: TList<TRetornoPesquisaBancoSicrediApi>;
  var AProgresso: TfrmGravando;
  AContador: Integer = 0;
  ATotalCarteira: Integer = 0);
  Var
    LParametros: TStringList;

    LStatus,
    LContador: Integer;

    LRetornoGet: String;

    LBoleto: TRetornoPesquisaBancoSicrediApi;

    LProcessados: Integer;
begin
  AProgresso.pgbStatus.Position := 0;
  LProcessados := 0;

  If AContador = 0 Then
  Begin
    AProgresso.lblGravando.Caption := 'Importando boletos da carteira ' + LDadosCarteira.LCarteiraCompleta.Split(['-'])[1] + ' - empresa ' + LDadosCarteira.LCarteiraCompleta.Split(['-'])[2];
    Application.ProcessMessages;
  End;

  For LContador := 0 To AListaImportada.Count - 1 Do
  Begin

    If Not AListaImportada[LContador].CodigoCarteira.Equals(LDadosCarteira.LCarteiraCompleta) Then
      Continue;

    Inc(LProcessados);
    pStep(AProgresso.pgbStatus);

    If AContador <> 0 Then
    Begin
      AProgresso.lblGravando.Caption := Format('(%d/%d) - Importando boletos por nosso número %d/%d',
                                           [AContador, ATotalCarteira, LProcessados, Trunc(AProgresso.pgbStatus.Properties.Max)]);
    End;

    If (AListaImportada[LContador].BoletoTipoLiquidacao <> '') Or
       (AListaImportada[LContador].BoletoDataPagamento <> '') Then
    Begin
      AListaImportada[LContador].ValorJuros          := AListaImportada[LContador].BoletoValorJuros;
      AListaImportada[LContador].ValorDesconto       := AListaImportada[LContador].BoletoValorDesconto;
      AListaImportada[LContador].BoletoDataMovimento := RetornaDataFormatada(AListaImportada[LContador].BoletoDataPagamento);

      AListaImportada[LContador].NomeDoArquivo := Concat(FormatDateTime('dd/mm/yy', ADataInicial), ' - ',
                                                         FormatDateTime('dd/mm/yy', ADataFinal));
      Continue;
    End;

    GerarToken;

    LParametros := TStringList.Create;
    try
      LParametros.Add('x-api-key: ' + LDadosCarteira.LKeyUser);
      LParametros.Add('Authorization: bearer ' + FTokenUsoAtual);
      LParametros.Add('cooperativa:' + LDadosCarteira.LCooperativa);
      LParametros.Add('posto:' + LDadosCarteira.LPosto);

      LStatus := FRestSynalist.ExecuteRestSynalist_Sicredi('GET',
                                                           RetornaLinkConsultaBoletosNossoNumero(LDadosCarteira.LCodigoBeneficiario,
                                                                                                 AListaImportada[LContador].NossoNumero),
                                                           LParametros,
                                                           LRetornoGet);

      If (LStatus = 404) Then
        Continue;

      ValidaStatusErro(LStatus, LRetornoGet);

      LBoleto := RetornaDadosPesquisaBoleto(LRetornoGet);

      LBoleto.CodigoCarteira := LDadosCarteira.LCarteiraCompleta;
      LBoleto.NomeDoArquivo  := Concat(FormatDateTime('dd/mm/yy', ADataInicial), ' - ',
                                       FormatDateTime('dd/mm/yy', ADataFinal));

      If Assigned(AListaImportada[LContador]) Then
        AListaImportada[LContador].Free;
      AListaImportada[LContador] := LBoleto;
    finally
      FreeAndNil(LParametros);
    end;

  End;

end;

function TBancoSicrediAPI.ConsultaBoletosLiquidadosPorDia(ADataInicial,
  ADataFinal: TDateTime;
  AListaImportada: TList<TRetornoPesquisaBancoSicrediApi>;
  var AProgresso: TfrmGravando): TList<TRetornoPesquisaBancoSicrediApi>;
  Var
    LDataAtual: TDateTime;

    LParametros: TStringList;

    LStatus,
    LPagina: Integer;

    LRetornoGet,
    LContinue,
    LLinkConsulta: String;

    LJsonObject: TJsonObject;
begin
  Result := AListaImportada;

  LDataAtual := ADataInicial;

  While LDataAtual <= ADataFinal Do
  Begin
    LContinue := 'false';

    LPagina := 0;

    Repeat
      GerarToken;

      LParametros := TStringList.Create;

      LParametros.Add('x-api-key: ' + LDadosCarteira.LKeyUser);
      LParametros.Add('Authorization: bearer ' + FTokenUsoAtual);
      LParametros.Add('cooperativa:' + LDadosCarteira.LCooperativa);
      LParametros.Add('posto:' + LDadosCarteira.LPosto);

      Try
        LLinkConsulta := LDadosCarteira.FLinkConsultaBoletosDia.Replace('[BENEFICIARIO]', LDadosCarteira.LCodigoBeneficiario)
                                                               .Replace('[DATA]', FormatDateTime('dd/mm/yyyy', LDataAtual))
                                                               .Replace('[PAGINA]', LPagina.ToString);

        If LPagina = 0 Then
          LLinkConsulta := LLinkConsulta.Replace('&pagina=0', EmptyStr);

        LStatus := FRestSynalist.ExecuteRestSynalist_Sicredi('GET',
                                                             LLinkConsulta,
                                                             LParametros,
                                                             LRetornoGet,
                                                             EmptyStr,
                                                             'application/x-xxx-form-urlencoded');

        ValidaStatusErro(LStatus, LRetornoGet);

        LJsonObject := TJSONObject.ParseJSONValue(LRetornoGet) as TJSONObject;

        Result.AddRange(RetornaListaDadosRetornoDia(LJsonObject.GetValue('items').ToJson));

        LContinue := RetornaValorJson(LJsonObject, 'hasNext').ToLowerInvariant;
      Finally
        FreeAndNil(LParametros);

        FreeAndNil(LJsonObject);
      End;

      Inc(LPagina);
    Until(LContinue.Equals('false'));

    LDataAtual := IncDay(LDataAtual, 1);
  End;
end;

function TBancoSicrediAPI.ConsultaBoletosMesmoBeneficiario(ADataInicial,ADataFinal: TDateTime; var AProgresso: TfrmGravando): TList<TRetornoPesquisaBancoSicrediApi>;
  Var
    LListaCarteiras,
    LListaBeneficiarios: TStringList;

    LCarteira: String;

    LBancoSicrediObj: TBancoSicrediAPI;

    LMaximoProgresso: Integer;
    LContador: Integer;
begin
  Result := TList<TRetornoPesquisaBancoSicrediApi>.Create;

  LListaCarteiras := RetornaListaDeCarteiras(LDadosCarteira.LCodigoBeneficiario);

  LListaBeneficiarios := TStringList.Create;

  LContador := 1;

  Try
    For LCarteira In LListaCarteiras Do
    Begin
      LBancoSicrediObj := TBancoSicrediAPI.Create(LCarteira.Split(['|'])[0]);

      LMaximoProgresso := Result.Count;

      If LListaBeneficiarios.IndexOf(LCarteira.Split(['|'])[1]) = -1 Then
      Begin
        LListaBeneficiarios.Add(LCarteira.Split(['|'])[1]);

        Result := LBancoSicrediObj.ConsultaBoletosLiquidadosPorDia(ADataInicial, ADataFinal, Result, AProgresso);
      End;

      LBancoSicrediObj.AdicionaBoletosDataEmissaoLista(ADataInicial, ADataFinal, Result);

      LMaximoProgresso := Result.Count - LMaximoProgresso;

      AProgresso.pgbStatus.Properties.Max := LMaximoProgresso;

      LBancoSicrediObj.ConsultaBoletoPorNossoNumero(ADataInicial, ADataFinal, Result, AProgresso,LContador, LListaCarteiras.Count);

      FreeAndNil(LBancoSicrediObj);
      Inc(LContador);
    End;
  Finally
    FreeAndNil(LListaCarteiras);
    FreeAndNil(LListaBeneficiarios);
  End;
end;

function TBancoSicrediAPI.ConsultaBoletosPorPeriodo(ADataInicial, ADataFinal: TDateTime;
  AProgresso: TfrmGravando): TList<TRetornoPesquisaBancoSicrediApi>;
  Var
    LRetornoGet: WideString;
    LRetornoGetS: String;
    LJsonRetorno: TJSONObject;
    LStatus : Integer;
    LParametros: TStringList;
    LConsultaBoletosGerados: TUniClientDataset;
    LDadosRetorno: TRetornoPesquisaBancoSicrediApi;
    LLabelStatus: String;
begin
  If LDadosCarteira.ImportarEmpresas.Equals('S') Then
    Exit(ConsultaBoletosTodasEmpresas(ADataInicial, ADataFinal, AProgresso));

  IF LDadosCarteira.ImportacaoOtimizada.Equals('S') Then
    Exit(ConsultaBoletosMesmoBeneficiario(ADataInicial, ADataFinal, AProgresso));

  Result       := TList<TRetornoPesquisaBancoSicrediApi>.Create;
  LJsonRetorno := TJsonObject.Create;
  LStatus := 0;

  LConsultaBoletosGerados := RetonaDuplicatasBoletoGerado(LDadosCarteira.LCarteiraCompleta,
                                                          ADataInicial,
                                                          ADataFinal);

  Try
    LConsultaBoletosGerados.First;

    AProgresso.pgbStatus.Position := 0;
    AProgresso.pgbStatus.Properties.Max := LConsultaBoletosGerados.RecordCount;

    While Not LConsultaBoletosGerados.Eof Do
    Begin
       Try
          LLabelStatus := Format(
            'Importando boletos 748 - Banco Sicredi [Online]... %.0n de %.0n', [
              AProgresso.pgbStatus.Position + 1,
              AProgresso.pgbStatus.Properties.Max]);

          pStepStatusGravacao(AProgresso.pgbStatus, LLabelStatus);

          GerarToken;

          If fCfgSis('DLLBOL', varBoolean) Then
          Begin

            LStatus := RestExecute('GET',
                                    RetornaLinkConsultaBoletosNossoNumero(LDadosCarteira.LCodigoBeneficiario, LConsultaBoletosGerados.FieldByName('CTR_NOSNUM').AsString),
                                   'Bearer ' + FTokenUsoAtual,
                                   LRetornoGet,
                                   '',
                                   LDadosCarteira.LKeyUser,
                                   LDadosCarteira.LCooperativa,
                                   LDadosCarteira.LPosto);

          End
          Else
          If Not fCfgSis('DLLBOL', varBoolean) Then
          Begin

            LParametros := TStringList.Create;

            LParametros.Add('x-api-key: ' + LDadosCarteira.LKeyUser);
            LParametros.Add('Authorization: bearer ' + FTokenUsoAtual);
            LParametros.Add('cooperativa:' + LDadosCarteira.LCooperativa);
            LParametros.Add('posto:' + LDadosCarteira.LPosto);

            Try
               LStatus := FRestSynalist.ExecuteRestSynalist_Sicredi('GET',
                                                                    RetornaLinkConsultaBoletosNossoNumero(LDadosCarteira.LCodigoBeneficiario, LConsultaBoletosGerados.FieldByName('CTR_NOSNUM').AsString),
                                                                    LParametros,
                                                                    LRetornoGetS,
                                                                    '');
            Finally
              FreeAndNil(LParametros);
            End;

          End;

          If (LStatus = 404) Then
          Begin
             LConsultaBoletosGerados.Next;
             Continue;
          End;

          ValidaStatusErro(LStatus, LRetornoGet);

          If fCfgSis('DLLBOL', varBoolean) Then
             LDadosRetorno := RetornaDadosPesquisaBoleto(LRetornoGet)
          Else
             LDadosRetorno := RetornaDadosPesquisaBoleto(LRetornoGetS);

          If LConsultaBoletosGerados.FieldByName('CTR_DTAENV').AsDateTime = VS_Date Then
          Begin
            If LDadosRetorno.LinhaDigitavel.IsEmpty Then
            Begin
              LConsultaBoletosGerados.Next;
              Continue;
            End;
          End;

          LDadosRetorno.NomeDoArquivo := Concat(FormatDateTime('dd/mm/yy', ADataInicial),' - ',
                                                FormatDateTime('dd/mm/yy', ADataFinal) );

         If DeveAdicionarDuplicata(LDadosRetorno,ADataInicial,ADataFinal) Then
           Result.Add(LDadosRetorno);

          LConsultaBoletosGerados.Next;

       Except

          On E: Exception Do
          Begin
            Raise Exception.Create(RetornaTextoErro(E.Message));
          End;

       End;

    End;

  Finally
    FreeAndNil(LJsonRetorno);
  End;

end;

function TBancoSicrediAPI.ConsultaBoletosTodasEmpresas(ADataInicial,
  ADataFinal: TDateTime;
  var AProgresso: TfrmGravando): TList<TRetornoPesquisaBancoSicrediApi>;
  Var
    LListaCarteiras,
    LListaBeneficiarios: TStringList;

    LCarteira: String;

    LBancoSicrediObj: TBancoSicrediAPI;

    LMaximoProgresso: Integer;
begin
  Result := TList<TRetornoPesquisaBancoSicrediApi>.Create;

  LListaCarteiras := RetornaListaDeCarteiras;

  LListaBeneficiarios := TStringList.Create;

  LMaximoProgresso := 0;

  Try
    For LCarteira In LListaCarteiras Do
    Begin
      LBancoSicrediObj := TBancoSicrediAPI.Create(LCarteira.Split(['|'])[0]);

      If LListaBeneficiarios.IndexOf(LCarteira.Split(['|'])[1]) = -1 Then
      Begin
        LListaBeneficiarios.Add(LCarteira.Split(['|'])[1]);

        Result := LBancoSicrediObj.ConsultaBoletosLiquidadosPorDia(ADataInicial, ADataFinal, Result, AProgresso);
      End;

      LBancoSicrediObj.AdicionaBoletosDataEmissaoLista(ADataInicial, ADataFinal, Result);

      LMaximoProgresso := Result.Count - LMaximoProgresso;

      AProgresso.pgbStatus.Properties.Max := LMaximoProgresso;

      LBancoSicrediObj.ConsultaBoletoPorNossoNumero(ADataInicial, ADataFinal, Result, AProgresso);

      FreeAndNil(LBancoSicrediObj);
    End;
  Finally
    FreeAndNil(LListaCarteiras);
    FreeAndNil(LListaBeneficiarios);
  End;
end;

function TBancoSicrediAPI.RetornaDadosPesquisaBoleto(ADadosRetorno: String): TRetornoPesquisaBancoSicrediApi;
  Var
    LJSONRetorno,
    LJsonExtracao : TJSONObject;
begin
  Result := TRetornoPesquisaBancoSicrediApi.Create;

  If ADadosRetorno.IsEmpty Then
     Exit;

  LJSONRetorno := TJSONObject.ParseJSONValue(ADadosRetorno) as TJSONObject;

  Try

     Result.LinhaDigitavel     := RetornaValorJsonValue(LJSONRetorno, 'linhaDigitavel');
     Result.BoletoCodigoBarras := RetornaValorJsonValue(LJSONRetorno, 'codigoBarras');
     Result.BoletoSeuNumero    := RetornaValorJsonValue(LJSONRetorno, 'seuNumero');
     Result.NossoNumero        := RetornaValorJsonValue(LJSONRetorno, 'nossoNumero');
     Result.BoletoTipoCarteira := RetornaValorJsonValue(LJSONRetorno, 'tipoCarteira');

     {* PAGADOR *}
     LJsonExtracao := LJsonRetorno.GetValue('pagador') as TJSONObject;
     If Assigned(LJsonExtracao) Then
     Begin
       Result.BoletoCodigoPagador    := RetornaValorJson(LJsonExtracao, 'codigo');
       Result.BoletoDocumentoPagador := RetornaValorJson(LJsonExtracao, 'documento');
       Result.BoletoNomePagador      := RetornaValorJson(LJsonExtracao, 'nome');
     End;

     Result.BoletoDataEmissao    := RetornaDataFormatada(RetornaValorJsonValue(LJSONRetorno, 'dataEmissao'));
     Result.BoletoDataVencimento := RetornaDataFormatada(LeftStr(RetornaValorJsonValue(LJSONRetorno, 'dataVencimento'), 10));
     Result.BoletoValorOriginal  := RetornaValorJsonValue(LJSONRetorno, 'valorNominal');

     {* PAGAMENTO *}
     LJsonExtracao := LJsonRetorno.GetValue('dadosLiquidacao') as TJSONObject;
     If Assigned(LJsonExtracao) Then
     Begin
       Result.BoletoDataPagamento := RetornaDataFormatada( Copy( RetornaValorJson(LJsonExtracao, 'data'),1,10) );
       Result.BoletoDataMovimento := RetornaDataFormatada( Copy( RetornaValorJson(LJsonExtracao, 'data'),1,10) );
       Result.BoletoValorPago     := RetornaValorJson(LJsonExtracao, 'valor');
       Result.Valormulta          := RetornaValorJson(LJsonExtracao, 'multa');
       Result.ValorJuros          := RetornaValorJson(LJsonExtracao, 'juros');
       Result.ValorDesconto       := RetornaValorJson(LJsonExtracao, 'desconto');
       Result.BoletoValorAbatimentoLiquido := RetornaValorJson(LJsonExtracao, 'abatimento');
     End;

     Result.BoletoTipoLiquidacao  := RetornaValorJsonValue(LJSONRetorno, 'situacao');

  Finally
    FreeAndNil(LJSONRetorno);
  End;
end;

function TBancoSicrediAPI.RetornaValorJsonValue(AObjeto: TJsonValue;
  ANomeCampo: String): String;
begin
  If Not AObjeto.TryGetValue<String>(ANomeCampo, Result) Then
    Result := '';
end;

Function TBancoSicrediAPI.RetornaDataFormatada(strData : String): String;
 Var
     dtRes : String;
Begin

   dtRes := Copy(strData,9,2) + '/' + Copy(strData,6,2) + '/' + Copy(strData,1,4);

   result := dtRes;

End;

constructor TBancoSicrediAPI.Create(ACarteira: String);
begin
  FPastaAutcom := ExtractFilePath(Application.ExeName).Replace('autban\', EMptyStr)
                                                      .Replace('Autban\', EMptyStr)
                                                      .Replace('AUTBAN\', EMptyStr)
                                                      .Replace('AutBan\', EMptyStr);

  CarregaDadosCarteira(ACarteira);
  CriarComponenteRequisicao;
  DefinirURL;
  ListaRequisicaoRegistroBoleto := TList<TRequisicaoRegistroBoleto>.Create;
  LRetornoBancoSicrediAPI := TRetornoBoletoBancoSicredi.Create;
  FRestSynalist := TRestSynalistAutban.Create;
end;

procedure TBancoSicrediAPI.CriarComponenteRequisicao;
  Var
    LCaminhoDll : String;
begin

  If fCfgSis('DLLBOL', varBoolean) Then
  Begin
    LCaminhoDll := ExtractFilePath(Application.ExeName) + 'RestApiBoleto.dll';

    If Not FileExists(LCaminhoDll) Then
      Raise Exception.Create('O arquivo ' + LCaminhoDll + ' não foi encontrado na pasta do AUTCOM. Operação cancelada!');

    FHandleRequisicoes := LoadLibrary(PChar(LCaminhoDll));
    RestExecute := GetProcAddress(FHandleRequisicoes, 'Execute_');
  End;

end;

procedure TBancoSicrediAPI.DefinirURL;
begin
  LDadosCarteira.LLinkTokenAPI := IIF(LDadosCarteira.LHomologacao,C_URL_OAUTH_HOM, C_URL_OAUTH_PROD);
  LDadosCarteira.LLinkApi      := IIF(LDadosCarteira.LHomologacao,C_URL_HOM, C_URL);

  LDadosCarteira.LLinkInclusao           := LDadosCarteira.LLinkApi;
  LDadosCarteira.FLinkAlteracao          := Concat(LDadosCarteira.LLinkApi,'/[NOSSO_NUMERO]/data-vencimento');
  LDadosCarteira.LLinkBaixa              := Concat(LDadosCarteira.LLinkApi,'/[NOSSO_NUMERO]/baixa');
  LDadosCarteira.FLinkConsultaBoletoNossoNumero := LDadosCarteira.LLinkApi;

  LDadosCarteira.FLinkConsultaBoletosDia := LDadosCarteira.LLinkApi + '/liquidados/dia?' +
                                            'codigoBeneficiario=[BENEFICIARIO]&' +
                                            'dia=[DATA]&' +
                                            'pagina=[PAGINA]';
end;

destructor TBancoSicrediAPI.Destroy;
begin
  GravarDadosRequisicaoRegistroBoleto;
  FreeAndNil(ListaRequisicaoRegistroBoleto);
  FreeAndNil(LRetornoBancoSicrediAPI);

  If FHandleRequisicoes <> 0 Then
  Begin
    FHandleRequisicoes := 0;
    FreeLibrary(FHandleRequisicoes);
  End;
  inherited;
end;


function TBancoSicrediAPI.DeveAdicionarDuplicata(ARetorno: TRetornoPesquisaBancoSicrediApi; ADataInicial, ADataFinal: TDateTime): Boolean;
begin

  Result := DateTimeInRange(StrToDateTime(ARetorno.BoletoDataEmissao),
                            ADataInicial,
                            ADataFinal);

  If Not ARetorno.BoletoDataPagamento.IsEmpty Then
  Begin

    Result := DateTimeInRange(StrToDateTime(ARetorno.BoletoDataPagamento),
                              ADataInicial,
                              ADataFinal);

  End;
end;

function TBancoSicrediAPI.DeveBloquearSeFoiGeradoPorArquivo(
  ADuplicata: TDuplicataCtr): Boolean;
begin
  If LDadosCarteira.ImportarEmpresas.Equals('S') Then
  Begin
    If LDadosCarteira.BaixarBoletosGeradoPorArquivo.Equals('S') Then
      Exit(False);
  End;

  Result := Not ADuplicata.strCartei.Contains('CONFIG748API');
end;

{****************************************************************
 * FUNÇÃO CRIADA PARA ENCONTRAR DUPLICATAS GRAVADAS COM O CAMPO *
 * REG_DUPLIC INCORRETO                                         *
 *************************************************REQ: 242707*MT*}

function TBancoSicrediAPI.EncontrarJsonRegistroBoleto(AAutoIncrem: String): String;
  Var
    LRegBol : TUniQuery;
    LNosNumCadRec : String;
    LDtaVenCadRec,
    LstrDataConv,
    LstrDataNova : String;
    LJsonRetorno: TJSONObject;
begin
  Result := '';

  Try
    LRegBol := fCriaQuery(Nil);
    Try
      LRegBol.Close;
      LRegBol.Sql.Text := 'SELECT                             '+
                          '  REG_JSOENV,                      '+
                          '  REG_JSOREC                       '+
                          'FROM                               '+
                          '  REGBOL WHERE REG_CODBCO = "748"  '+
                          '  AND REG_EXCEPT IS NULL           '+
                          '  AND REG_JSOREC IS NOT NULL       '+
                          '  AND IFNULL(REG_DESCRI,"REGISTRO") = "REGISTRO" '+
                          'ORDER BY REG_DTAREG DESC,          '+
                          '  REG_HRAREG DESC                  ';
      LRegBol.Open;

      LNosNumCadRec := fCampoTabela('CTR_NUMDUP', 'CADREC', ['AUTOINCREM'], [AAutoIncrem], False)+
                       fCampoTabela('CTR_PARCEL', 'CADREC', ['AUTOINCREM'], [AAutoIncrem], False);

      LDtaVenCadRec := fCampoTabela('CTR_DTAVEN', 'CADREC', ['AUTOINCREM'], [AAutoIncrem], False);

      LRegBol.First;
      While Not LRegBol.Eof Do
      Begin
        LJsonRetorno := TJSONObject.ParseJSONValue(LRegBol.FieldByName('REG_JSOENV').AsString) as TJSONObject;

        If RightStr(LJsonRetorno.GetValue<String>('seuNumero'),10).Equals( RightStr(LNosNumCadRec,10) ) Then
        Begin

          LstrDataConv := LJsonRetorno.GetValue<String>('dataVencimento');
          LstrDataNova := copy(LstrDataConv,9,2) +'-'+ copy(LstrDataConv,6,2) +'-'+ copy(LstrDataConv,1,4);

          //If LJsonRetorno.GetValue<String>('dataVencimento').Equals(LDtaVenCadRec.Replace('/','.')) Then
          If LstrDataNova = LDtaVenCadRec.Replace('/','-') Then
          Begin
            Result := LRegBol.FieldByName('REG_JSOREC').AsString;
            Break;
          End;
        End;

        LRegBol.Next;
      End;
    Except
      On E : Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LRegBol);
    FreeAndNil(LJsonRetorno);
  End;

end;

function TBancoSicrediAPI.fDiasNegativacaoParaMatoGrossoDoSulEhInvalido(
  AUFCliente: String): Boolean;
begin
  Result := False;

  If (AUFCliente <> 'MS') Then
    Exit;

  If (fEmptyStr(LDadosCarteira.LQtdDiasNegativacaoMS)) And
     (StrToIntDef(LDadosCarteira.LQtdDiasNegativacao, 0) > 0) Then
    Exit(True);

  If (StrToIntDef(LDadosCarteira.LQtdDiasNegativacaoMS, 0) > 0) And
     Not (StrToIntDef(LDadosCarteira.LQtdDiasNegativacaoMS, 0) In [46..99]) Then
    Exit(True);
end;

procedure TBancoSicrediAPI.GerarToken;
  Var
    LDadosEnvio: String;
    LParametros: TStringList;
    LRestSynalist :TRestSynalistAutban;
begin
  LParametros := TStringList.Create;

  LDadosEnvio := 'username=' + (LDadosCarteira.LCodigoBeneficiario + LDadosCarteira.LCooperativa) + '&' +
                 'password=' + LDadosCarteira.LPassword + '&' +
                 'scope=cobranca' + '&' +
                 'grant_type=password';

  LParametros.Add('x-api-key: ' + LDadosCarteira.LKeyUser);
  LParametros.Add('context:COBRANCA');

  LRestSynalist := TRestSynalistAutban.Create;

  Try
    Try
      FTokenUsoAtual := LRestSynalist.GetToken('POST',
                                                LDadosCarteira.LLinkTokenAPI,
                                                LParametros,
                                                LDadosCarteira.LCarteiraBanco + '-' +  LDadosCarteira.LEmpresaCarteira,
                                                LDadosEnvio,
                                                'application/x-www-form-urlencoded');
    Except
      On E: Exception Do
        Raise Exception.Create('Ocorreu um erro ao realizar a autenticação na API do Banco.' + #13#10 +
                               'Verifique se as chaves de autenticação da conta estão liberadas para utilização no ambiente de ' +
                                IIF(LDadosCarteira.LHomologacao,'HOMOLOGAÇÃO', 'PRODUÇÃO') + '.' + #13#10 +
                               'Erro gerado: ' + E.Message);
    End;
  Finally
    FreeAndNil(LParametros);
    FreeAndNil(LRestSynalist);
  End;

end;

Function TBancoSicrediAPI.Valida_Configuracao_Token(LKeyUser,
                                                     LCodigoBeneficiario,
                                                     LCooperativa,
                                                     LPassword : String;
                                                     LAmbiente : Integer;
                                                     LCarteira : String ): String;
  Var
    LResposta : String;
    LStatusCode : Integer;

    LDadosEnvio: String;
    LParametros: TStringList;
begin

  Result := '';

  LParametros := TStringList.Create;

  LDadosEnvio := 'username=' + (LCodigoBeneficiario + LCooperativa) + '&' +
                 'password=' + LPassword + '&' +
                 'scope=cobranca' + '&' +
                 'grant_type=password';

  LParametros.Add('x-api-key: ' + LKeyUser);
  LParametros.Add('context:COBRANCA');

  Try
    Try

      FRestSynalist.GetToken('POST',
                             IIF( LAmbiente = 0, C_URL_OAUTH_HOM, C_URL_OAUTH_PROD),
                             LParametros,
                             LCarteira,
                             LResposta,
                             LStatusCode,
                             LDadosEnvio,
                             'application/x-www-form-urlencoded'
                            );

      Result := VerificaRetornoValidacaoToken(LStatusCode, LResposta);

    Except
      On E: Exception Do
        Raise Exception.Create('Ocorreu um erro ao realizar a autenticação na API do Banco.' + #13 +
                               'Erro gerado: ' + E.Message);
    End;
  Finally
    FreeAndNil(LParametros);
  End;

end;

Function TBancoSicrediAPI.VerificaRetornoValidacaoToken(AStatusCode: Integer; ARetorno: String) : String;
begin
  If AStatusCode <> 200 Then
  Begin

     If (Pos('INVALID USER CREDENTIALS',AnsiUpperCase(ARetorno)) > 0) Then
         Result := 'Credenciais de acesso inválidas.'
     Else
     If (Pos('IDENTIFIED BY HEADER X-API-KEY, IS INVALID',AnsiUpperCase(ARetorno)) > 0) Then
         Result := 'Chave de acesso informada é inválida.'
     Else
     If (Pos('ACCESS DENIED FOR THIS ENVIRONMENT.',AnsiUpperCase(ARetorno)) > 0) Then
         Result := 'Acesso negado para este ambiente.'
     Else
         Result := 'Erro encontrado durante a validação das credenciais.' + #13 + ARetorno;
         //Raise Exception.Create('Chave de acesso informada é inválida.');

  End
  Else
     Result := 'Credenciais validadas com sucesso.';
end;

procedure TBancoSicrediAPI.GravarDadosRequisicaoRegistroBoleto;
  Var
    LRequisicaoRegistroBoleto : TRequisicaoRegistroBoleto;
begin
  If Assigned(ListaRequisicaoRegistroBoleto) Then
  Begin
    If ListaRequisicaoRegistroBoleto.Count > 0 Then
    Begin
      // GRAVA DADOS DAS REQUISIÇÕES
      For LRequisicaoRegistroBoleto In ListaRequisicaoRegistroBoleto Do
      Begin
        TRegBol.GravarRequisicaoReqistroBoleto(LRequisicaoRegistroBoleto);
      End;

      ListaRequisicaoRegistroBoleto.Clear;
    End;
  End;
end;

{function TBancoSicrediAPI.ImportarDetalhamento(
  ADadosBoleto: TRetornoPesquisaBancoSicrediApi): Boolean;
begin
  Result := False;

  If fStrToFloat(ADadosBoleto.BoletoValorPago) > 0 Then
    Exit(True);

  If Pos(ADadosBoleto.BoletoCodigoEstadoTituloCobranca, LDadosCarteira.FOcorrenciasDeEncargo) > 0 Then
    Exit(True);

end;}

{procedure TBancoSicrediAPI.OnAfterExecute(Sender: TCustomRESTRequest);
begin
  Application.ProcessMessages;
end;}

procedure TBancoSicrediAPI.ReimpressaoDeBoleto(AAutoIncrem: String);
  Var
    LJsonRetorno: TJSONObject;
    LJsonRegistro: String;
    LCadRec: TUniQuery;
begin
  Try
    LRetornoBancoSicrediAPI := TRetornoBoletoBancoSicredi.Create;
    Try
      LJsonRegistro := RetornaJsonRegistroBoleto(AAutoIncrem);

      If fEmptyStr(LJsonRegistro) Then
      Begin

        LCadRec := fCriaQuery(Nil);
        LCadRec.Close;
        LCadRec.SQL.Clear;
        LCadRec.SQL.Add('SELECT CTR_LINDIG, CTR_NOSNUM, CTR_TX_BOL, CTR_QRCODE ' +
                        'FROM CADREC WHERE AUTOINCREM = :AUTOINC');

        LCadRec.ParamByName('AUTOINC').AsString := AAutoIncrem;
        LCadRec.Open;

        LRetornoBancoSicrediAPI.nossoNumero := RetornaCampoNossoNumero(LCadRec.FieldByName('CTR_NOSNUM').AsString);
        LRetornoBancoSicrediAPI.QrCodeTxId  := LCadRec.FieldByName('CTR_TX_BOL').AsString;
        LRetornoBancoSicrediAPI.QrCodeEmv   := LCadRec.FieldByName('CTR_QRCODE').AsString;
        LRetornoBancoSicrediAPI.cooperativa    := LDadosCarteira.LCooperativa;
        LRetornoBancoSicrediAPI.posto          := LDadosCarteira.LPosto;
        LRetornoBancoSicrediAPI.linhaDigitavel   := LCadRec.FieldByName('CTR_LINDIG').AsString;
        LRetornoBancoSicrediAPI.codigoDeBarras   := Copy(LRetornoBancoSicrediAPI.linhaDigitavel, 01, 04) +
                                                    Copy(LRetornoBancoSicrediAPI.linhaDigitavel, 33, 15) +
                                                    Copy(LRetornoBancoSicrediAPI.linhaDigitavel, 05, 05) +
                                                    Copy(LRetornoBancoSicrediAPI.linhaDigitavel, 11, 08) +
                                                    Copy(LRetornoBancoSicrediAPI.linhaDigitavel, 19, 02) +
                                                    Copy(LRetornoBancoSicrediAPI.linhaDigitavel, 22, 10);
        Exit;
      End;

      LJsonRetorno := TJSONObject.ParseJSONValue(LJsonRegistro) as TJSONObject;

      LRetornoBancoSicrediAPI.nossoNumero    := RetornaValorJson(LJsonRetorno,'nossoNumero');
      LRetornoBancoSicrediAPI.linhaDigitavel := RetornaValorJson(LJsonRetorno,'linhaDigitavel');
      LRetornoBancoSicrediAPI.codigoDeBarras := RetornaValorJson(LJsonRetorno,'codigoBarras');
      LRetornoBancoSicrediAPI.cooperativa    := RetornaValorJson(LJsonRetorno,'cooperativa');
      LRetornoBancoSicrediAPI.posto          := RetornaValorJson(LJsonRetorno,'posto');

      If IfEmptyStr(LDadosCarteira.LTipoCobranca, '0').Equals('1') Then
      Begin
        LRetornoBancoSicrediAPI.QrCodeTxId     := RetornaValorJson(LJsonRetorno,'txid');
        LRetornoBancoSicrediAPI.QrCodeEmv      := RetornaValorJson(LJsonRetorno,'qrCode');
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

    If Assigned(LCadRec) Then
      FreeAndNil(LCadRec);
  End;
end;
function TBancoSicrediAPI.RetornaCampoDecimalJSON(AValor: String): String;
begin
  Result := AValor.Replace('.', EmptyStr);
  Result := Result.Replace(',', '.');
end;

function TBancoSicrediAPI.RetornaCampoNossoNumero(ANosNum: String): String;
begin
  Result := fPadL(ANosNum, 09, '0') ;
end;

function TBancoSicrediAPI.RetornaTipoDocumento(AIndice: Integer): String;
Begin

  Case AIndice of
     0: result := 'DUPLICATA_MERCANTIL_INDICACAO';
     1: result := 'DUPLICATA_RURAL';
     2: result := 'NOTA_PROMISSORIA';
     3: result := 'NOTA_PROMISSORIA_RURAL';
     4: result := 'NOTA_SEGUROS';
     5: result := 'RECIBO';
     6: result := 'LETRA_CAMBIO';
     7: result := 'NOTA_DEBITO';
     8: result := 'DUPLICATA_SERVICO_INDICACAO';
     9: result := 'OUTROS';
    10: result := 'BOLETO_PROPOSTA';
    11: result := 'CARTAO_CREDITO';
  End;

End;

function TBancoSicrediAPI.RetornaDadosDaRequisicao(ADadosDuplicata,ADadosCliente: TDataset; ANosNum: String): String;
  Var
    Json: TJSONObject;
    LDiasNegativacao:Integer;
begin
  Json := TJsonObject.Create;

  try
    Json.AddPair('tipoCobranca'       ,IIF(fEmptyStr(LDadosCarteira.LTipoCobranca),'NORMAL',IIF(LDadosCarteira.LTipoCobranca='0','NORMAL','HIBRIDO')));
    Json.AddPair('codigoBeneficiario' ,LDadosCarteira.LCodigoBeneficiario);

    Json.AddPair('pagador'  ,RetornaPagador(ADadosCliente));   //Objeto

    Json.AddPair('especieDocumento' ,RetornaTipoDocumento(strToInt(LDadosCarteira.LTipoDocto)));

    //*** Obs: ENVIO DE "NOSSO NUMERO" se nao for enviado gera automaticamente pelo sicredi; ***

    Json.AddPair('seuNumero' , RightStr( Trim(UpperCase(ADadosDuplicata.FieldByName('CTR_NUMDUP').AsString +
                                                        ADadosDuplicata.FieldByName('CTR_PARCEL').AsString)), 10) );

    Json.AddPair('dataVencimento',FormatDateTime('YYYY-MM-DD', ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime));

    if (StrToIntDef(LDadosCarteira.LQtdDiasNegativacao,0) = 0) then  // NÃO PODE SER PRENCHIDO SE O CAMPO "DIAS DE NEGATIVAÇÃO" ESTIVER PREENCHIDO;
    Begin
       If (StrToIntDef(LDadosCarteira.LQtdDiasProtesto,0) > 0) then
           Json.AddPair('diasProtestoAuto' ,Trunc(StrToIntDef(LDadosCarteira.LQtdDiasProtesto,0)).ToString);
    End;

    if (StrToIntDef(LDadosCarteira.LQtdDiasProtesto,0) = 0) then    // NÃO PODE SER PRENCHIDO SE O CAMPO "DIAS DE PROTESTO" ESTIVER PREENCHIDO;
    Begin
      LDiasNegativacao := RetornaDiasNegativacaoAuto(ADadosCliente.FieldByName('CID_ESTADO').AsString,LDadosCarteira);
      If (LDiasNegativacao > 0) Then
        Json.AddPair('diasNegativacaoAuto',IntToStr(LDiasNegativacao));
    End;

    //Campo obrigatorio, porem se estiver enviando o tipo 'Normal' e especie documento = Boleto Proposta;
    //Json.AddPair('qtdediasValidadeQR'           ,LDadosCarteira.LQtdeDiasValidadeQR);

    Json.AddPair('valor' ,RetornaCampoDecimalJSON(RetornaValorDuplicata(ADadosDuplicata).ToString));

    // Descontos
    If UtilizaDescontoDePontualidade(ADadosDuplicata.FieldByName('CTR_PERDPO').AsFloat) then
    Begin

      // verificar tipo_desc LDadosCarteira.LTipoDesc(VALOR; PERCENTUAL);
      Json.AddPair('desconto',  RetornaDescontoPontualidade(ADadosDuplicata));
      If (ADadosDuplicata.FieldByName('CTR_DESSUJ').AsFloat > 0) Then
        Json.AddPair('segundoDesconto',  RetornaSegundoDesconto(ADadosDuplicata));
    End
    Else
    Begin
      If ADadosDuplicata.FieldByName('CTR_DESSUJ').AsFloat > 0 Then
         Json.AddPair('desconto',  RetornaDesconto(ADadosDuplicata));
    End;

    // não deve ser preenchido caso o desconto normal tenha sido informado;
    // Json.AddPair('descontoAntecipado' ,'0.00'); opcional

    Json.AddPair('tipoJuros', IIF(fEmptyStr(LDadosCarteira.LTipoDesc),'0', IIF( (LDadosCarteira.LTipoDocto = '0'), 'VALOR', 'PERCENTUAL' )));

    If (Self.LPercentualMora > 0) Then
       Json.AddPair('juros',  RetornaJurosMorastr(ADadosDuplicata));

    If (Self.LPercentualMulta > 0) Then
       Json.AddPair('multa',  RetornaMultastr(ADadosDuplicata));

    Json.AddPair('informativo','['+ Copy(Trim(LDadosCarteira.LObservacao1),1,80) + ', '
                                  + Copy(Trim(LDadosCarteira.LObservacao2),1,80) + ', '
                                  + Copy(Trim(LDadosCarteira.LObservacao3),1,80) + ', '
                                  + Copy(Trim(LDadosCarteira.LObservacao4),1,80) + ', '
                                  + Copy(Trim(LDadosCarteira.LObservacao5),1,80) + ']');

    Json.AddPair('mensagem','['+ Copy(Trim(LDadosCarteira.LObservacao1),1,80) + ', '
                               + Copy(Trim(LDadosCarteira.LObservacao2),1,80) + ', '
                               + Copy(Trim(LDadosCarteira.LObservacao3),1,80) + ', '
                               + Copy(Trim(LDadosCarteira.LObservacao4),1,80) + ', '
                               + Copy(Trim(LDadosCarteira.LObservacao5),1,80) + ']');

    Result := PrettyJSON(Json.ToString);

  Finally
    FreeAndNil(Json);
  End;
end;


function TBancoSicrediAPI.RetornaDiasNegativacaoAuto(const AEstado: string; const LDadosCarteira: TDadosCarteira): Integer;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery(Nil);
  Try
    LConsulta.Close;
    LConsulta.SQL.Clear;
    LConsulta.SQL.Text := 'SELECT                           '+
                          '  NEG_DIA_UF                     '+
                          'FROM                             '+
                          '  DIANEG                         '+
                          'WHERE NEG_CHAVE_ = :NEG_CHAVE_   '+
                          '  AND NEG_COD_UF = :NEG_COD_UF   ';


    LConsulta.ParamByName('NEG_CHAVE_').AsString := LDadosCarteira.LCarteiraBanco + '-' +  LDadosCarteira.LEmpresaCarteira;
    LConsulta.ParamByName('NEG_COD_UF').AsString := AEstado;
    LConsulta.Open;

    if not LConsulta.IsEmpty then
    begin
      Result := LConsulta.FieldByName('NEG_DIA_UF').AsInteger;
      Exit;
    end;

  Finally
    If Assigned(LConsulta) Then
      FreeAndNil(LConsulta);
  End;

  Result := StrToIntDef(LDadosCarteira.LQtdDiasNegativacao, 0);

  If LDadosCarteira.MigrouUf.Equals('SIM') Then
    Exit;

  if AEstado = 'MS' then
  begin
    if Not fEmptyStr(LDadosCarteira.LQtdDiasNegativacaoMS) then
      Result := StrToIntDef(LDadosCarteira.LQtdDiasNegativacaoMS, 0);
  end
  else if AEstado = 'SP' then
  begin
    if Not fEmptyStr(LDadosCarteira.QtdDiasNegativacaoSP) then
      Result := StrToIntDef(LDadosCarteira.QtdDiasNegativacaoSP, 0);
  end;
end;

function TBancoSicrediAPI.RetornaDadosDaRequisicaoAlteracao(ADadosDuplicata: TDataSet): String;
  Var
    Json: TJSONObject;
begin

  Try
    Json  := TJsonObject.Create;
    Json.AddPair('dataVencimento',RetornaNovaDataVencimentoStr(ADadosDuplicata));
    Result := PrettyJSON(Json.ToString);
  Finally
    FreeAndNil(Json);
  End;
end;

function TBancoSicrediAPI.RetornaDadosDaRequisicaoBaixa: String;
  Var
    Json: TJSONObject;
begin
  Json := TJsonObject.Create;
  Try
    Json.AddPair('','');
    Result := PrettyJSON(Json.ToString);
  Finally
    FreeAndNil(Json);
  End;

end;

{function TBancoSicrediAPI.RetornaDadosDaRequisicaoGerarPix: String;
  Var
    Json: TJSONObject;
begin
  Json := TJsonObject.Create;
  Try
    Json.AddPair('numeroConvenio',StrToInt64Def(LDadosCarteira.LConvenio,0).ToString);
    Result := PrettyJSON(Json.ToString);
  Finally
    FreeAndNil(Json);
  End;
end;}

function TBancoSicrediAPI.PrettyJSON(JsonString:String):String;
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


function TBancoSicrediAPI.RetornaDesconto(ADadosDuplicata : TDataSet): TJsonObject;
  var
    LDataExpiracao : TDateTime;
    LValorCalc : Double;
begin
  Result := TJSONObject.Create;

  If ADadosDuplicata.FieldByName('CTR_DESSUJ').AsFloat > 0 Then
  Begin
    LDataExpiracao := (ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime -  ADadosDuplicata.FieldByName('CTR_QTDDAV').AsInteger);

    If LDadosCarteira.LTipoDocto = '0' Then // Valor
       LValorCalc := ADadosDuplicata.FieldByName('CTR_DESSUJ').AsFloat
    Else
       LValorCalc := (( ADadosDuplicata.FieldByName('CTR_DESSUJ').AsFloat / ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat ) * 100);

    Result.AddPair('tipoDesconto', IIF(fEmptyStr(LDadosCarteira.LTipoDesc),'0', IIF( (LDadosCarteira.LTipoDocto = '0'), 'VALOR', 'PERCENTUAL' )));
    Result.AddPair('valorDesconto1' ,RetornaCampoDecimalJSON(fFormataFloat(LValorCalc,2).ToString));
    Result.AddPair('dataDesconto1'  ,FormatDateTime('YYYY-MM-DD', LDataExpiracao));
  End;

End;

function TBancoSicrediAPI.RetornaJsonRegistroBoleto(AAutoIncrem: String): String;
  Var
    LRegBol : TUniQuery;
    LSql: String;
begin
  LRegBol := fCriaQuery(Nil);

  Try
    LSql := 'SELECT                        '+
            '  REG_JSOREC                  '+
            'FROM                          '+
            '  REGBOL                      '+
            'WHERE REG_DUPLIC = :DUPLIC    '+
            '  AND REG_EXCEPT IS NULL      '+
            '  AND REG_JSOREC IS NOT NULL  '+
            '  AND IFNULL(REG_DESCRI,"REGISTRO") = "REGISTRO" '+
            'ORDER BY REG_DTAREG DESC,     '+
            '  REG_HRAREG DESC             ';
    Try
      LRegBol.Close;
      LRegBol.SQL.Clear;
      LRegBol.SQL.Add(LSql);
      LRegBol.ParamByName('DUPLIC').AsString := AAutoIncrem;
      LRegBol.Open;
      Result := LRegBol.FieldByName('REG_JSOREC').AsString;

      If fEmptyStr(Result) Or (LRegBol.RecordCount > 1) Then
      Begin
        Result := EncontrarJsonRegistroBoleto(AAutoIncrem);
      End;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  Finally
    FreeAndNil(LRegBol);
  End;
end;

function TBancoSicrediAPI.RetornaJurosMoraStr(ADadosDuplicata: TDataSet): String;
  Var
    LValorMora : Double;
begin
  Result := '';
  LValorMora := fFormataFloat(ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat * (Self.LPercentualMora/100), 2);

  If (LValorMora > 0) Then
  Begin
    Result := RetornaCampoDecimalJSON(LValorMora.ToString);
  End;

end;

function TBancoSicrediAPI.RetornaLinkAlteracao(
  ADadosDuplicata: TDataSet): String;
begin
  Result := StringReplace(LDadosCarteira.FLinkAlteracao, '[NOSSO_NUMERO]', RetornaCampoNossoNumero(ADadosDuplicata.FieldByName('CTR_NOSNUM').AsString), [rfReplaceAll]);
end;

function TBancoSicrediAPI.RetornaLinkBaixa(ANosNum: String): String;
begin
  Result := StringReplace(LDadosCarteira.LLinkBaixa, '[NOSSO_NUMERO]', RetornaCampoNossoNumero(ANosNum), [rfReplaceAll]);
end;

{function TBancoSicrediAPI.RetornaLinkConsultaBoletosDia(ACodBeneficiario, ADia, ACnpjBenefFinal, Apagina: String): String;
  Var
    LLink_: String;
begin
  LLink_ := LDadosCarteira.FLinkConsultaBoletosDia + 'codigoBeneficiario=' + ACodBeneficiario + '&dia=' + ADia;

  If ACnpjBenefFinal <> '' Then
     LLink_ := LLink_ + '&cpfCnpjBeneficiarioFinal='+ACnpjBenefFinal;

  If APagina <> '' Then
     LLink_ := LLink_ + '&pagina='+Apagina;

  Result := LLink_;
end;}

function TBancoSicrediAPI.RetornaLinkConsultaBoletosNossoNumero(ACodBeneficiario, ANosNum:String): String;
  Var
    LLink_: String;
begin
  LLink_ := LDadosCarteira.FLinkConsultaBoletoNossoNumero + '?codigoBeneficiario=' + ACodBeneficiario + '&nossoNumero=' + ANosNum;

  Result := LLink_;
end;

function TBancoSicrediAPI.RetornaListaDadosRetornoDia(
  AJsonRetorno: String): TList<TRetornoPesquisaBancoSicrediApi>;
  Var
    LJsonArray: TJsonArray;

    LJsonValue: TJsonValue;

    LBoleto: TRetornoPesquisaBancoSicrediApi;
begin
  Result := TList<TRetornoPesquisaBancoSicrediApi>.Create;

  LJsonArray := TJSONObject.ParseJSONValue(AJsonRetorno) As TJsonArray;
  If LJsonArray = Nil Then
    Exit;

  Try
    For LJsonValue In LJsonArray Do
    Begin
      LBoleto := TRetornoPesquisaBancoSicrediApi.Create;
      LBoleto.BoletoCooperativa := RetornaValorJsonValue(LJsonValue, 'cooperativa');
      LBoleto.BoletoCodigoBeneficiario := RetornaValorJsonValue(LJsonValue, 'codigoBeneficiario');
      LBoleto.BoletoCooperativaPostoBeneficiario := RetornaValorJsonValue(LJsonValue, 'cooperativaPostoBeneficiario');
      LBoleto.BoletoNumeroBoleto := RetornaValorJsonValue(LJsonValue, 'nossoNumero');
      LBoleto.BoletoSeuNumero := RetornaValorJsonValue(LJsonValue, 'seuNumero');
      LBoleto.BoletoTipoCarteira := RetornaValorJsonValue(LJsonValue, 'tipoCarteira');
      LBoleto.BoletoDataPagamento := RetornaValorJsonValue(LJsonValue, 'dataPagamento');
      LBoleto.BoletoValorOriginal := RetornaValorJsonValue(LJsonValue, 'valor');
      LBoleto.BoletoValorPago := RetornaValorJsonValue(LJsonValue, 'valorLiquidado');
      LBoleto.BoletoValorJuros := RetornaValorJsonValue(LJsonValue, 'jurosLiquido');
      LBoleto.BoletoValorDesconto := RetornaValorJsonValue(LJsonValue, 'descontoLiquido');
      LBoleto.BoletoValorAbatimentoLiquido := RetornaValorJsonValue(LJsonValue, 'abatimentoLiquido');
      LBoleto.ValorMulta := RetornaValorJsonValue(LJsonValue, 'multaLiquida');
      LBoleto.BoletoTipoLiquidacao := RetornaValorJsonValue(LJsonValue, 'tipoLiquidacao');

      LBoleto.CodigoCarteira := LDadosCarteira.LCarteiraCompleta;

      Result.Add(LBoleto);
    End;
  Finally
    FreeAndNil(LJsonArray);
  End;
end;

function TBancoSicrediAPI.RetornaListaDeCarteiras(ABeneficiario: String = ''): TStringList;
  Var
    LConsulta: TUniQuery;

    LChave: String;
begin
  Result := TStringList.Create;

  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT SIS_CHAVE_, SIS_VALCFG ' +
                          'FROM CFGBAN ' +
                          'WHERE SIS_CODBAN="748" ' +
                          '  AND SIS_NUMPOS="API" ' +
                          '  AND SIS_CODEMP IN (' + fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ') ' +
                          '  AND SIS_CODCFG="NUMCTAC" ' +
                          '  AND SIS_CHAVE_ LIKE "CONFIG748API-%-%" ' ;

    If Not ABeneficiario.IsEmpty Then
      LConsulta.SQL.Text := LConsulta.SQL.Text +  ' AND SIS_VALCFG = :CODBEN ';

    LConsulta.SQL.Text := LConsulta.SQL.Text +
                          'GROUP BY SIS_CHAVE_ ' +
                          'ORDER BY SIS_CHAVE_ ';

    If Not ABeneficiario.IsEmpty Then
    Begin
      LConsulta.ParamByName('CODBEN').AsString := ABeneficiario;
    End;

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

{function TBancoSicrediAPI.RetornaLinkGerarPix(ANosNum: String): String;
begin
  Result := StringReplace(LDadosCarteira.FLinkGerarPix, '[NOSSO_NUMERO]', RetornaCampoNossoNumero(ANosNum), [rfReplaceAll]);
end;}

function TBancoSicrediAPI.RetornaDescontoPontualidade(ADadosDuplicata : TDataSet):TJsonObject;
  Var
    LValorCorrigido: Double;
    LDataExpiracao : TDateTime;
    LValorCalc     : Double;
begin
  Result := TJSONObject.Create;
  LValorCorrigido := (ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat * ( ADadosDuplicata.FieldByName('CTR_PERDPO').AsFloat / 100.00));
  LDataExpiracao  := (ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime - ADadosDuplicata.FieldByName('CTR_QTDDAV').AsInteger);

  If LValorCorrigido > 0 Then
  Begin
    If LDadosCarteira.LTipoDocto = '0' Then // Valor
       LValorCalc := LValorCorrigido
    Else
       LValorCalc := (( LValorCorrigido / ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat ) * 100);

    Result.AddPair('tipoDesconto', IIF(fEmptyStr(LDadosCarteira.LTipoDesc),'0', IIF( (LDadosCarteira.LTipoDocto = '0'), 'VALOR', 'PERCENTUAL' )));
    Result.AddPair('valorDesconto1', RetornaCampoDecimalJSON(fFormataFloat(LValorCalc,2).ToString));
    Result.AddPair('datadesconto1', FormatDateTime('YYYY-MM-DD', LDataExpiracao));
  End;

end;

function TBancoSicrediAPI.RetornaNovaDataVencimentoStr(ADadosDuplicata: TDataSet):String;
Begin
  Result := FormatDateTime('YYYY-MM-DD', ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime);
End;

function TBancoSicrediAPI.RetornaMultaStr(ADadosDuplicata: TDataSet):String;
  Var
    LValorMulta : Double;
begin
  Result  := '';

  If Self.LPercentualMulta = 0 Then
    Self.LPercentualMulta := fStrToFloat(LDadosCarteira.LPercenMulta);

  //LValorMulta := fFormataFloat(ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat * (Self.LPercentualMulta/100), 2);
  LValorMulta := fFormataFloat(Self.LPercentualMulta, 2);

  If (LValorMulta > 0) Then
  Begin
    Result := RetornaCampoDecimalJSON(LValorMulta.ToString);
  End;
end;

function TBancoSicrediAPI.RetornaPagador(ADadosCliente: TDataSet): TJsonObject;
begin
  Result  := TJsonObject.Create;

  Result.AddPair('tipoPessoa'  ,IIF(Length(fTiraCaracEspeciaisPonto(ADadosCliente.FieldByName('CLI_C_G_C_').AsString)) = 11,'PESSOA_FISICA','PESSOA_JURIDICA'));
  Result.AddPair('documento'   ,fTiraCaracEspeciaisPonto(ADadosCliente.FieldByName('CLI_C_G_C_').AsString));
  Result.AddPair('nome'        ,RetornaValorString(ADadosCliente.FieldByName('CLI_NOMCLI').AsString, 40));
  Result.AddPair('endereco'    ,RetornaValorString(RetornaEnderecoENumeroCom30Caracteres(ADadosCliente.FieldByName('CLI_ENDERE').AsString,                                                                                         ADadosCliente.FieldByName('CLI_ENDNUM').AsString)));
  Result.AddPair('cidade'      ,RetornaValorString(ADadosCliente.FieldByName('CID_NOMCID').AsString, 25));
  Result.AddPair('uf'          ,ADadosCliente.FieldByName('CID_ESTADO').AsString);
  Result.AddPair('cep'         ,fRetSomenteNumeros(ADadosCliente.FieldByName('CLI_C_E_P_').AsString));
  //Result.AddPair('Telefone'  ,fRetSomenteNumeros(ADadosCliente.FieldByName('CLI_C_E_P_').AsString));   //opcional
  //Result.AddPair('email'     ,fRetSomenteNumeros(ADadosCliente.FieldByName('CLI_C_E_P_').AsString));   //opcional
end;

{function TBancoSicrediAPI.RetornaBeneficiarioFinal(ADadosBeneficiario: TDataSet): TJsonObject;
begin
  Result  := TJsonObject.Create;

  //Result.AddPair('documento'     ,fTiraCaracEspeciais(LDadosCarteira.LCnpjBen,true,true,true,true,true,true));
  //Result.AddPair('tipoPessoa'    ,IIF(Length(fTiraCaracEspeciais(LDadosCarteira.LCnpjBen,true,true,true,true,true,true)) = 11,'PESSOA_FISICA','PESSOA_JURIDICA'));
  //Result.AddPair('nome'          ,RetornaValorString(fTiraCaracEspeciais(LDadosCarteira.LNomeBen), 40));
  //Result.AddPair('logradouro'    ,RetornaValorString(RetornaEnderecoENumeroCom30Caracteres(LDadosCarteira.LEndBen,''))); //opcional
  //Result.AddPair('complemento'   ,'');                                                                              //opcional
  //Result.AddPair('numeroEndereco',LDadosCarteira.LNumBen);                                                          //opcional
  //Result.AddPair('cidade'        ,RetornaValorString(fTiraCaracEspeciais(LDadosCarteira.LCidBen), 25));             //opcional
  //Result.AddPair('uf'            ,LDadosCarteira.LEstBen;                                                           //opcional
  //Result.AddPair('cep'           ,fRetSomenteNumeros(fTiraCaracEspeciais(LDadosCarteira.LCepBen)));                 //opcional
  //Result.AddPair('Telefone'    ,fRetSomenteNumeros(ADadosCliente.FieldByName('CLI_C_E_P_').AsString));            //opcional
  //Result.AddPair('email'       ,fRetSomenteNumeros(ADadosCliente.FieldByName('CLI_C_E_P_').AsString));            //opcional
end;}

function TBancoSicrediAPI.RetornaSegundoDesconto(ADadosDuplicata: TDataSet): TJsonObject;
  Var
    LDataExpiracao : TDateTime;
    LValorCalc : Double;
begin
  Result := TJSONObject.Create;
  LDataExpiracao := (ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime - ADadosDuplicata.FieldByName('CTR_QTDDAV').AsInteger);

  LValorCalc := 0;

  If ADadosDuplicata.FieldByName('CTR_DESSUJ').AsFloat > 0 Then
  Begin
    If LDadosCarteira.LTipoDocto = '0' Then // Valor
       LValorCalc := ADadosDuplicata.FieldByName('CTR_DESSUJ').AsFloat
    Else
       LValorCalc := (( ADadosDuplicata.FieldByName('CTR_DESSUJ').AsFloat / ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat ) * 100);
  End;

  Result.AddPair('valorDesconto2' , RetornaCampoDecimalJSON(fFormataFloat(LValorCalc,2).ToString));
  Result.AddPair('datadesconto2'  , FormatDateTime('DD.MM.YYYY', LDataExpiracao));
end;

function TBancoSicrediAPI.RetornaValorDuplicata(ADadosDuplicata: TDataSet): Double;
begin
  Result := ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat;

  If fCfgSis('VALIMP', varBoolean, LDadosCarteira.LEmpresaCarteira) then
  Begin
    Result := ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat +
              ADadosDuplicata.FieldByName('CTR_JURSUJ').AsFloat +
              ADadosDuplicata.FieldByName('CTR_DESCOB').AsFloat;
  End;

  Result := fFormataFloat(Result, 2);
end;

function TBancoSicrediAPI.RetornaValorJson(AObjeto: TJsonObject;
  ANomeCampo: String): String;
begin
  Result := '';
  If AObjeto.GetValue(ANomeCampo) <> Nil Then
  Begin
    Try
      Result := AObjeto.GetValue<string>(ANomeCampo);
    Except
      Result := AObjeto.GetValue(ANomeCampo).ToString;
    End;
  End;
end;

{procedure TBancoSicrediAPI.RetornaValorJurosDescontos(
  var ADadosBoleto: TRetornoPesquisaBancoSicrediApi);
begin
  If (fStrToFloat( fTrocaPontoporVirgula(ADadosBoleto.BoletoValorPago)) > fStrToFloat(fTrocaPontoporVirgula(ADadosBoleto.BoletoValorOriginal))) Then
    ADadosBoleto.valorJuros := (fStrToFloat(fTrocaPontoporVirgula(ADadosBoleto.BoletoValorPago)) - fStrToFloat(fTrocaPontoporVirgula(ADadosBoleto.BoletoValorOriginal))).ToString;

  If (fStrToFloat(fTrocaPontoporVirgula(ADadosBoleto.BoletoValorOriginal)) < fStrToFloat(fTrocaPontoporVirgula(ADadosBoleto.BoletoValorOriginal))) Then
    ADadosBoleto.valorDesconto := (fStrToFloat(fTrocaPontoporVirgula(ADadosBoleto.BoletoValorOriginal)) - fStrToFloat(fTrocaPontoporVirgula(ADadosBoleto.BoletoValorPago))).ToString;
end;}

function TBancoSicrediAPI.RetornaValorString(AValor: String;
  ATamanho: Integer): String;
begin
  Result := AValor;

  If Result.IsEmpty Then
    Exit;

  If ATamanho > 0 Then
    Result := LeftStr(Result, ATamanho);

  Result := fRemoveAcento(Result);
  Result := fTiraCaracEspeciais(Result);
  Result := RetiraQuebraLinha(Result);
end;

function TBancoSicrediAPI.UtilizaDescontoDePontualidade(
  AValDes: Double): Boolean;
begin
  Result := False;

  If fCfgSis('DESPON', varBoolean, LDadosCarteira.LEmpresaCarteira) Then
  Begin
    If (AValDes > 0) Then
      Result := True;
  End;

end;

procedure TBancoSicrediAPI.ValidaStatusErro(AStatus: Integer; ARetornoGet: String);
Var
    LErroInstabilidade,
    LErroAutenticacao,
    LErro : String;
begin
  LErro := '';

  LErroInstabilidade := 'Ocorreu um erro não identificado no servidor do banco. Tente novamente mais tarde! ';

  LErroAutenticacao  := 'Ocorreu um erro ao realizar a autenticação na API do Banco.';

  If AStatus <> 200 Then
  Begin

    If ((AStatus = 0) Or fEmptystr(ARetornoGet)) Then
       LErro := LErroInstabilidade;

    // Verifica se é erro de authenticação - gerar token
    If (Pos(LErroAutenticacao, ARetornoGet) > 0) Then
        LErro := LErroAutenticacao;

    If fEmptystr(LErro) Then
       LErro := LErroInstabilidade;

    Raise Exception.Create(LErro);

  End;

end;

Function TBancoSicrediAPI.RetornaTextoErro(ARetornoGet: String): String;
Var
    LErroInstabilidade,
    LErroAutenticacao: String;

    LJsonObject: TJsonObject;

    LMensagem: String;
    LJsonErro: String;
begin
  Result := '';

  LErroInstabilidade := 'Ocorreu um erro não identificado no servidor do banco. Tente novamente mais tarde! ';

  LErroAutenticacao  := 'Ocorreu um erro ao realizar a autenticação na API do Banco.';

  If (Pos(LErroAutenticacao, ARetornoGet) < 1) Then
     LJsonErro := Copy(ARetornoGet,(Pos('Erro:',ARetornoGet) + 5),ARetornoGet.Length)
  Else
     LJsonErro := ARetornoGet;

  Try
    LJsonObject := TJSONObject.ParseJSONValue(LJsonErro) As TJsonObject;

    If LJsonObject = Nil Then
    Begin

       // Verifica se é erro de authenticação - gerar token
       If (Pos(LErroAutenticacao, ARetornoGet) > 0) Then
           Result := LErroAutenticacao
       Else
           Result := LErroInstabilidade;

       Exit;
    End;

    if LJsonObject.TryGetValue('message', LMensagem) then
    begin
        Result := LMensagem;
    end;

    If Result.IsEmpty Then
       Result := LErroInstabilidade;

    FreeAndNil(LJsonObject);
  Except
    Result := LErroInstabilidade;
  End;

end;

function TBancoSicrediAPI.VerificaSeADuplicataExisteCadrec(ABoleto: TRetornoPesquisaBancoSicrediApi;out ADuplicata: TDuplicataCtr): Boolean;
  Var
    LPesquisa: TUniQuery;
begin
  ADuplicata.strAutoIn := EmptyStr;
  ADuplicata.strNumDup := EmptyStr;
  ADuplicata.strParcel := EmptyStr;
  ADuplicata.strEspdoc := EmptyStr;
  ADuplicata.strCodEmp := EmptyStr;
  ADuplicata.strCodCli := EmptyStr;
  ADuplicata.EndToEndPix := EmptyStr;

  LPesquisa := Nil;
  Try
    LPesquisa := fCriaQuery;
    LPesquisa.SQL.Text := 'SELECT AUTOINCREM, CTR_NUMDUP, CTR_CODEMP,     ' +
                          'CTR_PARCEL, CTR_ESPDOC, CTR_CODCLI, CTR_CARTEI,' +
                          'CTR_END_ID, CTR_DTAVEN                         ' +
                          'FROM CADREC                                    ' +
                          'WHERE RIGHT(CTR_NOSNUM, 9) = :NOSNUM           ' +
                          '  AND CTR_BCOENV=:BCOENV                       ' +
                          //'  AND CTR_DTAVEN=:DTAVEN                       ' +
                          '  AND CTR_SEQBAI=0                             ';

    LPesquisa.ParamByName('NOSNUM').AsString   := ABoleto.NossoNumero;
    LPesquisa.ParamByName('BCOENV').AsString   := '748';
//    LPesquisa.ParamByName('DTAVEN').AsDateTime := StrToDate(ABoleto.ABoletoDataVencimento);

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
    ADuplicata.strCartei := LPesquisa.FieldByName('CTR_CARTEI').AsString;
    ADuplicata.EndToEndPix := LPesquisa.FieldByName('CTR_END_ID').AsString;

    //Atualiza a data de vencimento de acorodo co o registro do banco.
    ABoleto.BoletoDataVencimento := LPesquisa.FieldByName('CTR_DTAVEN').AsString;

    If LPesquisa.RecordCount > 1 Then
    Begin
      LPesquisa.Filter := 'CTR_CARTEI=' + ABoleto.CodigoCarteira.QuotedString;
      LPesquisa.Filtered := True;

      If Not LPesquisa.IsEmpty Then
      Begin
        ADuplicata.strAutoIn := LPesquisa.FieldByName('AUTOINCREM').AsString;
        ADuplicata.strNumDup := LPesquisa.FieldByName('CTR_NUMDUP').AsString;
        ADuplicata.strParcel := LPesquisa.FieldByName('CTR_PARCEL').AsString;
        ADuplicata.strEspdoc := LPesquisa.FieldByName('CTR_ESPDOC').AsString;
        ADuplicata.strCodEmp := LPesquisa.FieldByName('CTR_CODEMP').AsString;
        ADuplicata.strCodCli := LPesquisa.FieldByName('CTR_CODCLI').AsString;
        ADuplicata.strCartei := LPesquisa.FieldByName('CTR_CARTEI').AsString;
        ADuplicata.EndToEndPix := LPesquisa.FieldByName('CTR_END_ID').AsString;
      End;
    End;
  Finally
    FreeAndNil(LPesquisa);
  End;
end;

function TBancoSicrediAPI.RetonaDuplicatasBoletoGerado(
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
                          '  AND CTR_BCOBOL="748" ' +
                          '  AND CTR_CARTEI=:CARTEI ' +
                          '  AND CTR_DTAENV<=:DTAENV ' +

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
                          '  AND CTR_BCOBOL="748" ' +
                          '  AND CTR_CARTEI=:CARTEI ' +
                          '  AND CTR_SEQBAI=0 ' +

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

{ TDadosToken }

{function TDadosToken.GetAccessToken: String;
begin
  If Not fEmptyStr(Self.Exception) Then
    Raise SysUtils.Exception.Create(Self.Exception)
  Else
    Result := Self.Access_Token;
end;

{function TDadosToken.GetRefreshToken: String;
begin
  If Not fEmptyStr(Self.Exception) Then
    Raise SysUtils.Exception.Create(Self.Exception)
  Else
    Result := Self.Refresh_Token;
end;}

{function TDadosToken.RefreshToken: Boolean;
begin
   Result := False;

  If Not Assigned(Self) Then
    Exit(True);

  If (fNow > Self.RefreshTime) Then
    Exit(True);

 If Not fEmptyStr(Self.Exception) Then
   Exit(True);

end;}

{ TRetornoPesquisaSicrediApi }

function TRetornoPesquisaBancoSicrediApi.DataCreditoAsDate: String;
begin
  Result := Self.BoletoDataCredito.Replace('.','/');
end;

function TRetornoPesquisaBancoSicrediApi.DataMovimentoAsDate: String;
begin
  Result := Self.BoletoDataMovimento.Replace('.','/');
end;

function TRetornoPesquisaBancoSicrediApi.DataRegistroAsDate: String;
begin
  Result := Self.BoletoDataRegistro.Replace('.','/');
end;

function TRetornoPesquisaBancoSicrediApi.DataVencimentoAsDate: String;
begin
  Result := Self.BoletoDataVencimento.Replace('.','/');
end;

function TRetornoPesquisaBancoSicrediApi.GetNossoNumero: String;
begin
  Result := RightStr(Self.BoletoNumeroBoleto,9);
end;

function TRetornoPesquisaBancoSicrediApi.ValorPagoCedente: String;
begin

  Result := Self.BoletoValorPago;

end;

{ TDetalhamento }

function TDetalhamento.DataEmissaoTituloCobrancaAsDate: String;
begin
  Result := Self.DataEmissaoTituloCobranca.Replace('.','/');
end;

function TDetalhamento.DataVencimentoTituloCobrancaAsDate: String;
begin
  Result := Self.DataVencimentoTituloCobranca.Replace('.','/');
end;

function TDetalhamento.RetornaCodigoModalidadeTitulo: String;
begin
  Result := Self.CodigoModalidadeTitulo;

  If fEmptyStr(Result) Then
    Result := '1';
end;

function TDetalhamento.RetornaValorTarifa: String;
begin
  Result := Self.ValorTarifa;

  If Self.TipoDeCobranca.Equals('6') Then // 6 = descontada
    Result := '0';

end;

procedure TBancoSicrediAPI.ExibeFormMensagemErro(AMensagem: String);
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
