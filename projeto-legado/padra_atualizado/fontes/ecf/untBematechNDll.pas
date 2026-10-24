unit untBematechNDll;

interface 

Uses SysUtils, Windows, untFiscal, Classes, Uni, untFuncoesGenerica, Dialogs,
  Forms, Vcl.Controls, untTypesSistema;

  function Bematech_FI_UsaComprovanteNaoFiscalVinculado( cTexto: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_LinhasEntreCupons( intEspacos: Integer ): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_IniciaModoTEF(): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_FinalizaModoTEF(): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_FechaComprovanteNaoFiscalVinculado: Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_AbreComprovanteNaoFiscalVinculado( cDesFormaPgto, cValor, cNumCupom: AnsiString): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_AbreRelatorioGerencialMFD( cIndice: AnsiString): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_RelatorioGerencial( cTexto: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_FechaRelatorioGerencial: Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_LeituraX: Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_ReducaoZ(Data: AnsiString; Hora: AnsiString): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_AcionaGaveta: Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_RetornoImpressora( Var ACK: Integer; Var ST1: Integer; Var ST2: Integer ): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_VerificaImpressoraLigada: Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_AbreCupomMFD(CGC: Ansistring; Nome: Ansistring; Endereco : Ansistring): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_AumentaDescricaoItem( Descricao: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_VendeItem( Codigo: AnsiString; Descricao: AnsiString; Aliquota: AnsiString; TipoQuantidade: AnsiString; Quantidade: AnsiString; CasasDecimais: Integer; ValorUnitario: AnsiString; TipoDesconto: AnsiString; Desconto: AnsiString): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_IniciaFechamentoCupom( AcrescimoDesconto: AnsiString; TipoAcrescimoDesconto: AnsiString; ValorAcrescimoDesconto: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_EfetuaFormaPagamentoIndice( IndiceFormaPagamento: AnsiString; ValorFormaPagamento: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_EfetuaFormaPagamentoIndiceDescricaoForma( IndiceFormaPagamento: AnsiString; ValorFormaPagamento: AnsiString; DescricaoParcela: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_EfetuaFormaPagamentoDescricaoForma(strDesMod: AnsiString; strValMod: AnsiString; strDescri: AnsiString): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_TerminaFechamentoCupom( Mensagem: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_RetornoAliquotas( Aliquotas: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_CancelaCupom: Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_CancelaItemGenerico(strItem: AnsiString): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_LeituraMemoriaFiscalDataMFD(DataInicial, DataFinal, FlagLeitura : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_LeituraMemoriaFiscalReducaoMFD(ReducaoInicial, ReducaoFinal, FlagLeitura : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_DownloadMFD( Arquivo: AnsiString; TipoDownload: AnsiString; ParametroInicial: AnsiString; ParametroFinal: AnsiString; UsuarioECF: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_FormatoDadosMFD( ArquivoOrigem: AnsiString; ArquivoDestino: AnsiString; TipoFormato: AnsiString; TipoDownload: AnsiString; ParametroInicial: AnsiString; ParametroFinal: AnsiString; UsuarioECF: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_NumeroSubstituicoesProprietario( NumeroSubstituicoes: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_ProgramaFormaPagamentoMFD( FormaPagto, OperacaoTef: AnsiString ) : Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_VerificaFormasPagamento( FormasPagamento: AnsiString ) : Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_NomeiaTotalizadorNaoSujeitoIcms( Indice: Integer; Totalizador: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_NumeroSerieMFD(strNumSer: AnsiString): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_NumeroCupom(strNumCoo: AnsiString): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_ModeloImpressora( cModeloImp: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_ContadorCupomFiscalMFD(CuponsEmitidos : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_DataHoraImpressora( Data: AnsiString; Hora: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_UltimoItemVendido( NumeroItem: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_VendeItemDepartamento( Codigo: AnsiString; Descricao: AnsiString; Aliquota: AnsiString; ValorUnitario: AnsiString; Quantidade: AnsiString; Acrescimo: AnsiString; Desconto: AnsiString; IndiceDepartamento: AnsiString; UnidadeMedida: AnsiString): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_NumeroOperacoesNaoFiscais( NumeroOperacoes: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_ContadorRelatoriosGerenciaisMFD (Relatorios : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_ContadorComprovantesCreditoMFD(Comprovantes : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_DadosUltimaReducaoMFD(DadosReducao : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_VendaBruta ( VendaBruta : AnsiString ): integer; stdcall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_VersaoFirmwareMFD( VersaoFirmware: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_DataHoraGravacaoUsuarioSWBasicoMFAdicional( dataUsuario, dataSoftwareBasico: AnsiString; var letraAdicional: char ): integer; stdcall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_NumeroCaixa( NumeroCaixa: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_CNPJMFD(CNPJ : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_InscricaoEstadualMFD(InscricaoEstadual : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_MarcaModeloTipoImpressoraMFD(Marca, Modelo, Tipo : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_MapaResumo:Integer; StdCall; External 'BEMAFI32.DLL' delayed Name 'Bematech_FI_MapaResumo';
  function Bematech_FI_GrandeTotal( GrandeTotal: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_HabilitaDesabilitaRetornoEstendidoMFD(FlagRetorno : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_RetornoImpressoraMFD( Var ACK: Integer; Var ST1: Integer; Var ST2: Integer; Var ST3: Integer ): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_FlagsFiscais(Var Flag: Integer): Integer; StdCall; External 'BEMAFI32.DLL' delayed;

  function Bematech_FI_RelatorioSintegraMFD( iRelatorios : Integer;
                                             cArquivo    : AnsiString;
                                             cMes        : AnsiString;
                                             cAno        : AnsiString;
                                             cRazaoSocial: AnsiString;
                                             cEndereco   : AnsiString;
                                             cNumero     : AnsiString;
                                             cComplemento: AnsiString;
                                             cBairro     : AnsiString;
                                             cCidade     : AnsiString;
                                             cCEP        : AnsiString;
                                             cTelefone   : AnsiString;
                                             cFax        : AnsiString;
                                             cContato    : AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL' delayed;

  function Bematech_FI_Sangria( Valor: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_Suprimento( Valor: AnsiString; FormaPagamento: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function BemaGeraRegistrosTipoE( cArqMFD: AnsiString; cArqTXT: AnsiString; cDataInicial: AnsiString; cDataFinal: AnsiString; cRazao: AnsiString; cEndereco: AnsiString; cPAR1: AnsiString; cCMD: AnsiString; cPAR2: AnsiString; cPAR3: AnsiString; cPAR4: AnsiString; cPAR5: AnsiString; cPAR6: AnsiString; cPAR7: AnsiString; cPAR8: AnsiString; cPAR9: AnsiString; cPAR10: AnsiString; cPAR11: AnsiString; cPAR12: AnsiString; cPAR13: AnsiString; cPAR14: AnsiString ): Integer; StdCall; External 'BemaMFD2.dll' delayed;
  function Bematech_FI_AcionaGuilhotinaMFD( iTipoCorte: Integer ): Integer; StdCall; External 'BEMAFI32.DLL' delayed;

Type
  TarrFormasPagto = Array of String[16];

  TBematech = class(TFiscal)

  private
    FCodErr  : String;
    FVersaoSB: AnsiString;
    FDataGravacaoSB: TDateTime;
    FHoraGravacaoSB: TDateTime;
    FNumCaixa: AnsiString;
    FCNPJ: AnsiString;
    FIE: AnsiString;

    FPais: TPais;

    fltTotMlg: Double;
    blnUltComandoErro: Boolean;
    FNumSer: string;
    intDecUn: Integer;
    strDirIni: String;
    intUltItem: Integer;

    dtaDigitada: TDateTime;

    procedure pCarregaDataHoraGravSB;
    procedure pAtualizarDataHoraGravSB_obj(strSWBasicoString: string);
    function fFmtDecimalBemat: Integer;
    function fNumeroSerieInt: String;

    function fEspelhoMFDLocal(strTipoFiltro, strFiltroIni, strFiltroFin, strArquivoSaida: String): Boolean;

    function fCarregaDataHoraGravacaoSoftwareBasicoBanco(Var strSWBasicoString: String): Boolean;
    procedure pAtualizarDataHoraGravacaoSoftwareBasico(strCodEcf, strData: String);
    procedure pProcedureLMF(Sender: TObject);

    function fDataJaExistePafR02(dtaData: TDateTime): Boolean;
  public
    arrNomesFormasPagto: TarrFormasPagto;

    function fInicia     : Integer;
    function fFinaliza   : Integer;
    function fRetorno(Var ACK: Integer; Var ST1: Integer; Var ST2: Integer; Var ST3: Integer): String;
    function fVerErro(blnMostraErro: Boolean = True): Boolean; Override;

    function fLeituraX(strParam: String = 'N'; blnPergunta: Boolean = True): Boolean; Override;
    function fReducaoZ(strData, strHora: String): Boolean; Override;
    function fAbreGaveta: Boolean; Override;
    function fStatusImpressora: String; Override;
    function fAbreCupom: Boolean; Override;
    function fRegistraItem(strCodIte, strDesIte, strUnidad: String; fltAlqIcm, fltQtdIte, fltUnitar: Double;
      strCodFis: String; fltDesEsp: Double; fltTotal: Double = 0): Boolean; Override;
    function fCancelaItem(strItem: String): Boolean; Override;
    function fCancelaCupom: Boolean; Override;
    function fRegistraAcrDes(strAcrDes, strTip_AC, strVal_AC: String; fltTotal, fltTotImp: Double): Boolean; Override;
    function fRegistraModalidades(strCodMod, strDesMod: String; fltValMod: Double; strInfAdi: String): Boolean; Override;
    function fFechaCupom: Boolean; Override;
    function fRetornaCOO: String; Override;
    function fNumeroSerie: String; Override;
    function fCalcAliquota(strCodFiscal: String; fltAliquota: Double; intTipRet: Integer = 1): String; Override;
    function fAbreRelatorioGerencial(blnMostrarErro: Boolean = True): Boolean; override;
    function fFechaRelatorioGerencial(blnVerErro: Boolean = True): Boolean; Override;
    function fRelatorioGerencial(strTexto: String): Boolean; Override;
    function fEspacoEntreLinhas(intEspacos: Integer): Boolean; Override;
    function fAbreCNFVinculado(strDesFormaPgto, strValor, strNumCupom: String; strQtdPar: String = ''): Boolean; Override;
    function fFechaCNFVinculado(blnVerErro: Boolean = True): Boolean; Override;
    function fUsaCNFVinculado(strTexto: String): Boolean; Override;
    function fImpLinFiscal(strAtrib, strLinha: String): Boolean; Override;
    function fAbrePortaImpressora: Boolean; Override;
    function fexecutaCMD(strCmd: String; blnRetorna: Boolean = False): String; Override;
    function fVerificaCupomAberto: Boolean; override;
    procedure pFechaPortaImpressora; Override;

    procedure pPausaLeitura; Override;

    function fLeituraMemoriaFiscal(blnCompleta: Boolean; strTipoFiltro, strFiltroIni, strFiltroFin: String): Boolean; override;
    function fEspelhoMFD(strTipoFiltro, strFiltroIni, strFiltroFin, strArquivoSaida: String): Boolean; override;
    function fArquivoMFD(strDataIni, strDataFin, strArquivoSaida, strRazSocEmp, strEndereEmp: String): Boolean; override;

    function fModeloEcf: String; override;
    function fNumeroUsuario: String; override;
    function fNumeroCCF: String; override;
    function fDataEcf: TDateTime; override;
    function fHoraEcf: TDateTime; override;
    function fUltimoItemVendido: String; override;
    function fNumeroGNF: String; override;
    function fNumeroGRG: String; override;
    function fNumeroCDC: String; override;
    function fDadosUltimaReducao(Var drzDadosRed: TDadosReducao): Boolean; override;
    function fVendaBruta: Double; override;
    function fNumeroCaixa: String; override;
    function fNumeroCNPJUsuario: String; override;
    function fNumeroIEUsuario: String; override;
    function fVersaoSoftwareBasico: String; override;
    function fDataGravacaoSoftwareBasico: TDateTime; override;
    function fHoraGravacaoSoftwareBasico: TDateTime; override;
    function fTipoECF: String; override;
    function fMarcaECF: String; override;
    function fGrandeTotal: Double; override;
    function fMFDAdicional: String; override;

    function fSangria(fltValor: Double): Boolean; override;
    function fSuprimento(fltValor: Double; strModalidade: String='Dinheiro'): Boolean; override;

    function fGerarSintegra(blnApenas75: Boolean; strArquivo, strMes, strAno,
      strRazSoc, strEndere, strNumEnd, strComple, strBairro, strCidade,
      strNumCep, strFone01, strNumFax, strContat: String): Boolean; override;

    function fUltimoComandoComErro: Boolean; override;

    function fRetTotalImpressora(fltQtdIte, fltUnitar: Double): Double; override;

    function fCalculaValorIcms(fltValorBruto: Double): Double; override;

    function fAcionaGuilhotina: Boolean; override;

    function fReducaoZPendente: Boolean; override;

    Constructor Create(Owner: TComponent); Reintroduce;
    Destructor Destroy; override;

  End;

  Const
    DEC_UNIT = 3;

  Var
    //Handle : THandle;
    strDllBematech: String;

    //GLOBAIS POR CONTA DE UM BUG NA BEMAFI32.DLL
    strDHUsuario: AnsiString;
    strSWBasico: AnsiString;
    strMFAd: Char;

    Bematech_FI_CancelaCupomCV0909: function(COO: AnsiString): Integer; StdCall;
    Bematech_FI_VerificaZPendente: function (StatusRZ: AnsiString): Integer; StdCall;

implementation

uses
  StrUtils, untFuncoes, untFuncoesSimples, untConstantes,
  untBematechMFDLocal, Data.DB, untDigDataHoraSWBasico, untConstantesNFe;

{ TBematech }

constructor TBematech.Create(Owner: TComponent);
begin
  dtaDigitada := 0;
  FPais := fSetaPais;
  strCpfClie := '';
//  strDllBematech := ExtractFilePath(Application.ExeName) + 'BEMAFI32.DLL';
  strDllBematech := fCfgSis('DIRINI') + '/BEMAFI32.DLL';

  If fInicia <> 0 Then
    Raise Exception.Create('Não foi possível carregar a DLL da bematech!');

  SetLength(FVersaoSB, 6);
  SetLength(FNumCaixa, 4);
  SetLength(FCNPJ, 20);
  SetLength(FIE, 20);

  FDataGravacaoSB := 0;
  FHoraGravacaoSB := 0;

  Bematech_FI_HabilitaDesabilitaRetornoEstendidoMFD('1');

  FCodErr := IntToStr(Bematech_FI_VersaoFirmwareMFD(FVersaoSB));
  If (Not fVerErro) Then
    Raise Exception.Create('Erro ao capturar versão do software básico.');

  FCodErr := IntToStr(Bematech_FI_NumeroCaixa(FNumCaixa));
  If (Not fVerErro) Then
    Raise Exception.Create('Erro ao capturar número do caixa.');

  FCodErr := IntToStr(Bematech_FI_CNPJMFD(FCNPJ));
  If (Not fVerErro) Then
    Raise Exception.Create('Erro ao capturar CNPJ do usuário.');

  FCodErr := IntToStr(Bematech_FI_InscricaoEstadualMFD(FIE));
  If (Not fVerErro) Then
    Raise Exception.Create('Erro ao capturar IE do usuário.');

  pCarregaDataHoraGravSB;

  FNumSer   := fNumeroSerieInt;
  intDecUn  := fCfgSis('DECUNI', varInteger);
  strDirIni := fCfgSis('DIRINI');
end;

destructor TBematech.Destroy;
begin
  fFinaliza;
  inherited;
end;

function TBematech.fAbreCNFVinculado(strDesFormaPgto, strValor,
  strNumCupom: String; strQtdPar: String = ''): Boolean;
begin
  FCodErr := IntToStr(Bematech_FI_AbreComprovanteNaoFiscalVinculado( AnsiString(strDesFormaPgto), AnsiString(strValor), AnsiString(strNumCupom)));
  Result  := fVerErro;
end;

function TBematech.fAbreCupom: Boolean;
begin
  intUltItem := 0;
  fltTotMlg  := 0;

  strCpfCupomFiscal    := AnsiString(strCpfClie);
  strNomeCupomFiscal   := AnsiString(Copy(strCodCli + '-' + strNomCli, 1, 30));

  strEndereCupomFiscal := AnsiString(Copy( strEndCli + '-' +
                                           strBaiCli + '-' +
                                           strCidCli + '-' +
                                           strEstCli, 1, 79));
  FCodErr := IntToStr(Bematech_FI_AbreCupomMFD(strCpfCupomFiscal, strNomeCupomFiscal, strEndereCupomFiscal));
  Result  := fVerErro;

  If Result Then
  Begin
    VS_blnCupomAberto := True;
    dtaDigitada := 0;
  End;
end;

function TBematech.fAbreGaveta: Boolean;
begin
  FCodErr := IntToStr(Bematech_FI_AcionaGaveta);
  Result  := fVerErro;
end;

function TBematech.fAbrePortaImpressora: Boolean;
begin
  Result := True;
end;

function TBematech.fAbreRelatorioGerencial(
  blnMostrarErro: Boolean): Boolean;
begin
  Bematech_FI_AbreRelatorioGerencialMFD('01');
  Result := fVerErro(blnMostrarErro);
end;

function TBematech.fAcionaGuilhotina: Boolean;
begin
  FCodErr := IntToStr(Bematech_FI_AcionaGuilhotinaMFD(0));
  Result := fVerErro;
end;

function TBematech.fArquivoMFD(strDataIni, strDataFin, strArquivoSaida,
  strRazSocEmp, strEndereEmp: String): Boolean;
  Var
    strNumSubst: AnsiString;
    intContador: Integer;
    strPathDownloadMFD: AnsiString;
begin
  strPathDownloadMFD := AnsiString(fCfgSis('DIRINI')+'\Download.mfd');
  strNumSubst := '';
  For intContador := 1 To 4 Do
    strNumSubst := strNumSubst + ' ';

  FCodErr := IntToStr(Bematech_FI_NumeroSubstituicoesProprietario(strNumSubst));
  Result := fVerErro(True);
  If Result Then
  Begin
    strNumSubst := AnsiString(Trim(String(strNumSubst)));
    FCodErr := IntToStr(Bematech_FI_DownloadMFD(strPathDownloadMFD, '1', AnsiString(strDataIni), AnsiString(strDataFin), strNumSubst));
    Result := fVerErro(True);

    If Result Then
    Begin
      FCodErr := IntToStr(BemaGeraRegistrosTipoE(strPathDownloadMFD, AnsiString(strArquivoSaida), AnsiString(strDataIni), AnsiString(strDataFin), AnsiString(strRazSocEmp), AnsiString(strEndereEmp), '', '2', '', '', '', '', '', '', '', '', '', '', '', '', ''));
      Result := fVerErro(True);
    End;
  End;    
end;

function TBematech.fCalcAliquota(strCodFiscal: String; fltAliquota: Double;
  intTipRet: Integer): String;
  Var
    strAliquota: String;
    strCODSTB  : String;
    strCODISE  : String;
    strCODNIN  : String;
    strCodAlq  : String;
    fltValAlq  : Double;
    strIdeSer  : String;
    strCod018  : String;
    strCodAtu  : String;
    strPriCod  : String;
    blnPrimei  : Boolean;
    strSQL     : String;
    qryTmpEcf  : TUniQuery;
    strPatIni  : String;
    strCodEcf  : String;
begin
  strPatIni := fCfgSis('DIRINI');
  strCodEcf := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'IMPRESSORA'   , '', strPatIni + '/opcoes_fiscal.ini' );

  Result := '';
  strAliquota := '';

  qryTmpEcf := fCriaQuery;
  With qryTmpEcf Do
  Begin
    strSQL := '';
    strSQL := strSQL + ' SELECT * ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADECF ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   ECF_CODECF = :CODECF ';

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODECF').AsString := strCodEcf;
    Open;

    strCODSTB := FieldByName( 'ECF_CODSTB' ).AsString;
    strCODISE := FieldByName( 'ECF_CODISE' ).AsString;
    strCODNIN := FieldByName( 'ECF_CODNIN' ).AsString;

    Close;
  End;

  If Pos( strCodFiscal, CST_ISENTO ) > 0 Then
    strAliquota := 'I'

  Else If Pos( strCodFiscal, CST_NAO_TRIBUTADO ) > 0 Then
    strAliquota := 'N'

  Else If Pos( strCodFiscal, CST_SUBSTITUICAO + CST_ANTECIPACAO_ICMS ) > 0 Then
    strAliquota := 'F'

  Else If Pos( strCodFiscal, '_SSS_' ) > 0 Then
    strAliquota := 'S'

  Else
  Begin

    If ( fCfgSis('SIMPAU') = 'S' ) Then
//      strAliquota := FloatToStrF( fCfgSis('ICMSIM', varDouble), ffNumber, 5, 2 )
      strAliquota := FloatToStrF(fRetornaAliquotaIcmsInternaDoEstado(fCadEmp('ESTADO')), ffNumber, 5, 2)
    Else
    Begin

      If ( strEstCli = fCadEmp('ESTADO') ) Or fEmptyStr(strIESCli) Then
        strAliquota := FloatToStrF( fltAliquota, ffNumber, 5, 2 )
      Else
      Begin

        strAliquota := FloatToStrF( 0.00, ffNumber, 5, 2 );
        If ( strEstCli = fCadEmp('ESTADO') ) Then
          strAliquota := FloatToStrF( 18.00, ffNumber, 5, 2 )

        Else If ( Pos( strEstCli, '_PR_RJ_MG_RS_SC_SP_' ) > 0 ) Then
          strAliquota := FloatToStrF( 12.00, ffNumber, 5, 2 )

        Else
          strAliquota := FloatToStrF( 7.00, ffNumber, 5, 2 );

        If fEmptyStr( strIESCli ) And ( Not ( strEstCli = fCadEmp('ESTADO') ) ) Then
          strAliquota := FloatToStrF( 18.00, ffNumber, 5, 2 );

      End;

    End;

  End;

  If ( intTipRet = 1 ) Then
  Begin

    If strAliquota = 'F' Then
      strAliquota := fPadR( strCODSTB, 2 )
    Else If strAliquota = 'I' Then
      strAliquota := fPadR( strCODISE, 2 )
    Else If strAliquota = 'N' Then
      strAliquota := fPadR( strCODNIN, 2 )
    Else
    Begin

      With qryTmpEcf Do
      Begin
        strSql := '';
        strSql := strSql + ' SELECT * ';
        strSql := strSql + ' FROM ';
        strSql := strSql + '   ECFALQ ';
        strSql := strSql + ' WHERE ';
        strSql := strSql + '   ECF_CODECF = :CODECF ';

        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODECF').AsString := strCodEcf;
        Open;

        If IsEmpty() Then
          Exit;

        First;

        strCod018 := '';
        strCodAtu := '';
        blnPrimei := True;

        While Not Eof Do
        Begin

          If blnPrimei Then
          Begin
            strPriCod := FieldByName( 'ECF_CODALQ' ).AsString;
            blnPrimei := True;
          End;

          strCodAlq := FieldByName( 'ECF_CODALQ' ).AsString;
          fltValAlq := FieldByName( 'ECF_PERALQ' ).AsFloat;
          strIdeSer := FieldByName( 'ECF_SERVIC' ).AsString;

          If fEmptyStr( strCod018 ) Then
            If FloatToStrF( fltValAlq, ffNumber, 5, 2 ) = FloatToStrF( 18.00, ffNumber, 5, 2 ) Then
              strCod018 := strCodAlq;

          If strAliquota = 'S' Then
          Begin
            If fEmptyStr( strCodAtu ) Then
              strCodAtu := strCodAlq;
          End
          Else
          Begin
            If Pos( strAliquota, 'FIN' ) <= 0 Then
            Begin
              If ( FloatToStrF( fltValAlq, ffNumber, 5, 2 ) = strAliquota ) Then
              Begin
                strCodAtu := strCodAlq;
                Break;
              End;
            End;
          End;

          Next;
        End;

        If fEmptyStr( strCodAtu ) Then
          strCodAtu := strCod018;

        If fEmptyStr( strCodAtu ) Then
          strCodAtu := strPriCod;

        strAliquota := strCodAtu;

        Close;
      End;

    End;

  End;

  Result := AnsiReplaceStr( strAliquota, '.', ',' );
  FreeAndNil(qryTmpEcf);
end;

function TBematech.fCalculaValorIcms(fltValorBruto: Double): Double;
begin
  Result := fTruncaFloat(fltValorBruto, 2);
end;

function TBematech.fCancelaCupom: Boolean;
  Var
    HandleDllBema: Cardinal;
    blnMp4200: Boolean;
    strPatIni: String;
begin
  strPatIni := fCfgSis('DIRINI');
  blnMp4200 := (fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'MP4200'   , 'N', strPatIni + '/opcoes_fiscal.ini' ) = 'S');
  If (Not VS_blnCupomAberto) And (blnMp4200) Then
  Begin
    If Not Assigned(Bematech_FI_CancelaCupomCV0909) Then
    Begin
      HandleDllBema := LoadLibrary('BEMAFI32.DLL');
      If HandleDllBema = 0 Then
      Begin
        RaiseLastOSError;
      End;

      Bematech_FI_CancelaCupomCV0909 := GetProcAddress(HandleDllBema, 'Bematech_FI_CancelaCupomCV0909');
      If Not Assigned(Bematech_FI_CancelaCupomCV0909) Then
      Begin
        Raise ExceptionAutCom.Create('Atenção: foi configurado para utilizar a impressora Bematech MP 4200, porém, não foram encontradas algumas funções. ' +
          'Por favor, verifique se a versão da DLL da bematech (BemaFI32.dll) está atualizada.');
      End;
    End;

    FCodErr := IntToStr(Bematech_FI_CancelaCupomCV0909(AnsiString(fRetornaCOO)));
    Result := fVerErro;
    Exit;
  End;

  FCodErr := IntToStr(Bematech_FI_CancelaCupom);
  Result  := fVerErro;

  If Result Then
    VS_blnCupomAberto := False;
end;

function TBematech.fCancelaItem(strItem: String): Boolean;
begin
  FCodErr := IntToStr(Bematech_FI_CancelaItemGenerico( AnsiString(strItem) ));
  Result  := fVerErro;
end;

function TBematech.fDataJaExistePafR02(dtaData: TDateTime): Boolean;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  qryAux.SQL.Add('SELECT COUNT(*) AS QTD FROM PAFR02 WHERE PAF_NUMSER = :NUMSER AND PAF_DTAMOV = :DTAMOV ');
  qryAux.ParamByName('NUMSER').AsString := fNumeroSerie;
  qryAux.ParamByName('DTAMOV').AsDateTime := dtaData;
  qryAux.Open;

  Result := (qryAux.FieldByName('QTD').AsInteger > 0);

  FreeAndNil(qryAux);
end;

function TBematech.fDadosUltimaReducao(
  var drzDadosRed: TDadosReducao): Boolean;
  Const
    arrPosTotali: Array[1..13] Of Array[1..2] Of String = (
      ('I1'   , '560'),
      ('N1'   , '575'),
      ('F1'   , '590'),
      ('IS1'  , '605'),
      ('NS1'  , '620'),
      ('FS1'  , '635'),
      ('DT'   , '650'),
      ('DS'   , '665'),
      ('AT'   , '680'),
      ('AS'   , '695'),
      ('Can-T', '710'),
      ('Can-S', '725'),
      ('OPNF' , '740')
    );
  Var
    strDadosRed: AnsiString;
    intConta: Integer;
    intPosAlqIcm: Integer;
    intPosValIcm: Integer;

    strDtaMov: String;
    strAlqIcm: String;
    strValIcm: String;
    intTamMat: Integer;
    intContador: Integer;
begin
  intConta := 1;
  intPosAlqIcm := 1208;
  intPosValIcm := 335;

  SetLength(strDadosRed, 1278);
  FCodErr := IntToStr(Bematech_FI_DadosUltimaReducaoMFD(strDadosRed));

  Result := fVerErro;

  If (Not Result) Then
    Exit;

  Try

    strDtaMov := Copy(String(strDadosRed), 1273, 06);
    If strDtaMov = '000000' Then
    Begin
      If dtaDigitada = 0 Then
      Begin
        While (Not ffrmData(dtaDigitada, 'Redução sem movimento', 'Informe a data da redução')) Or
              (fDataJaExistePafR02(dtaDigitada)) Do
        Begin
          Application.ProcessMessages;
        End;
      End;
      strDtaMov := FormatDateTime('ddmmyy', dtaDigitada);
    End;

    Insert('/', strDtaMov, 3);
    Insert('/', strDtaMov, 6);

    drzDadosRed.strNumCrz   := Copy(String(strDadosRed), 0009, 04);
    drzDadosRed.strNumCOORZ := Copy(String(strDadosRed), 0014, 06);
    drzDadosRed.strNumCRO   := Copy(String(strDadosRed), 0004, 04);
    drzDadosRed.dtaDtaMov   := StrToDate(strDtaMov);
    SetLength(drzDadosRed.arrTotali, 0);

    {*****************************************}
    {* PEGA OS DADOS DA TRIBUTAÇÃO           *}
    {**************************************MV*}
    strAlqIcm := Copy(String(strDadosRed), intPosAlqIcm, 04);
    strValIcm := Copy(String(strDadosRed), intPosValIcm, 14);
    While (strAlqIcm <> '0000') Do
    Begin

      intTamMat := Length(drzDadosRed.arrTotali);
      SetLength(drzDadosRed.arrTotali, intTamMat+1);

      drzDadosRed.arrTotali[intTamMat].strCodTot := fStrZero(intConta, 02) + 'T' + strAlqIcm;
      drzDadosRed.arrTotali[intTamMat].fltValAcu := fStrToFloat(strValIcm) / 100;

      Inc(intPosAlqIcm, 04);
      Inc(intPosValIcm, 14);
      Inc(intConta);

      strAlqIcm := Copy(String(strDadosRed), intPosAlqIcm, 04);
      strValIcm := Copy(String(strDadosRed), intPosValIcm, 14);
    End;

    For intContador := Low(arrPosTotali) To High(arrPosTotali) Do
    Begin

      intTamMat := Length(drzDadosRed.arrTotali);
      SetLength(drzDadosRed.arrTotali, intTamMat+1);

      strValIcm := Copy(String(strDadosRed), StrToInt(arrPosTotali[intContador][2]), 14);

      drzDadosRed.arrTotali[intTamMat].strCodTot := arrPosTotali[intContador][1];
      drzDadosRed.arrTotali[intTamMat].fltValAcu := fStrToFloat(strValIcm) / 100;

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fDadosUltimaReducao]');
    End;
  End;
  
end;

function TBematech.fDataEcf: TDateTime;
//  Var
//    strData: String;
//    strHora: String;
begin
//  strData := '';
//  strHora := '';
//  SetLength(strData, 6);
//  SetLength(strHora, 6);
//
//  FCodErr := IntToStr(Bematech_FI_DataHoraImpressora(strData, strHora));
//
//  If (Not fEmptyStr(strData)) Then
//  Begin
//    Insert('/', strData, 3);
//    Insert('/', strData, 6);
//
//    Result := StrToDate(strData);
//  End
//  Else
    Result := VS_Date;
    
end;

function TBematech.fDataGravacaoSoftwareBasico: TDateTime;
begin
  pCarregaDataHoraGravSB;
  Result := FDataGravacaoSB;
end;

function TBematech.fEspacoEntreLinhas(intEspacos: Integer): Boolean;
begin
  FCodErr := IntToStr(Bematech_FI_LinhasEntreCupons(intEspacos));
  Result  := fVerErro;
end;

function TBematech.fEspelhoMFD(strTipoFiltro, strFiltroIni, strFiltroFin,
  strArquivoSaida: String): Boolean;
  Var
    strNumSubst: AnsiString;
    strTipDow: AnsiString;
    intContador: Integer;
    strPathDownloadMFD: AnsiString;
begin
  If fCfgSis('MFDLOC', varBoolean) Then
  Begin
    Result := fEspelhoMFDLocal(strTipoFiltro, strFiltroIni, strFiltroFin, strArquivoSaida);
    Exit;
  End;

  strPathDownloadMFD := AnsiString(fCfgSis('DIRINI')+'\Download.mfd');
  strNumSubst := '';
  For intContador := 1 To 4 Do
    strNumSubst := strNumSubst + ' ';

  strTipDow := AnsiString(IIF(strTipoFiltro = 'D', '1', '2'));

  FCodErr := IntToStr(Bematech_FI_NumeroSubstituicoesProprietario(strNumSubst));
  Result := fVerErro(True);

  If Result Then
  Begin
    strNumSubst := AnsiString(Trim(String(strNumSubst)));
    FCodErr := IntToStr(Bematech_FI_DownloadMFD(strPathDownloadMFD, strTipDow, AnsiString(strFiltroIni), AnsiString(strFiltroFin), strNumSubst));
    Result := fVerErro(True);

    If Result Then
    Begin
      FCodErr := IntToStr(Bematech_FI_FormatoDadosMFD(strPathDownloadMFD, AnsiString(strArquivoSaida), '0', strTipDow, AnsiString(strFiltroIni), AnsiString(strFiltroFin), strNumSubst));
      Result := fVerErro(True);
    End;
  End;
  
end;

function TBematech.fexecutaCMD(strCmd: String;
  blnRetorna: Boolean): String;
begin
  Result := '';
end;

function TBematech.fFechaCNFVinculado(blnVerErro: Boolean): Boolean;
begin
  FCodErr := IntToStr(Bematech_FI_FechaComprovanteNaoFiscalVinculado);
  Result  := fVerErro(blnVerErro);
end;

function TBematech.fFechaCupom: Boolean;
  Var
    strMens,
    strImpPag: String;
    strCupMan: string;
    blnImpPag: Boolean;
    intLinMsg: Integer;
    intQtdNps: Integer;

  procedure pAddMensagem(strValue: String);
  begin
    If (Not fEmptyStr(strValue)) Then
    Begin
      strMens := strMens + strValue;
      intLinMsg := intLinMsg + 1;
    End;
  end;

  function fTemLinhaDisponivel: Boolean;
  begin
    Result := (intLinMsg < fCfgSis('QMXMCU', varInteger));
  end;

begin
  strMens := '';
  strCupMan := '';
  intLinMsg := 0;

  strCgcCpf := fFormataCpfCgc(strCgcCpf, FPais);
  If Pos('/', strCgcCpf) > 0 Then
  Begin
    strCgcCpf := 'CNPJ: ' + strCgcCpf;
    strIesCli := 'IES.: ' + strIesCli;
  End
  Else
  Begin
    strCgcCpf := 'CPF: ' + strCgcCpf;
    strIesCli := 'RG.: ' + strRG_Cli;
  End;

  If (VS_strUsaPaf = 'S') And Not fEmptyStr(strMenPaf01) Then
    pAddMensagem(fPadR(strMenPaf01, 48));

  If (VS_strUsaPaf = 'S') And Not fEmptyStr(strMenPaf02) Then
    pAddMensagem(fPadR(strMenPaf02, 48));

  blnImpPag := ((fltImpPag <> 0.00) And (fltPeImPg <> 0.00)) Or
               ((fltFedImp <> 0.00) And (fltPeImFd <> 0.00)) Or
               ((fltEstImp <> 0.00) And (fltPeImEs <> 0.00)) Or
               ((fltMunImp <> 0.00) And (fltPeImMn <> 0.00));

  If blnImpPag Then
  Begin
    If Not fUsaImpostoFonteIBPT Then
    Begin
      If fltImpPag < 1000 Then
        pAddMensagem(fPadR(strMsgArreTribu48 + FormatFloat('#,##0.00', fltImpPag) +
                           '(' + FormatFloat('#,##0.00', fltPeImPg) + '%)', 48))
      Else
        pAddMensagem(fPadR(strMsgArreTribuRedz48 + FormatFloat('#,##0.00', fltImpPag) +
                           '(' + FormatFloat('#,##0.00', fltPeImPg) + '%)', 48));
    End
    Else
    Begin
      strImpPag := '';
      strImpPag := strImpPag + VAL_APR_IBPT;

      If (fltFedImp <> 0.00) Then
        strImpPag := strImpPag + FormatFloat('#,##0.00', fltFedImp) + FEDERAL;

      If (fltEstImp <> 0.00) Then
        strImpPag := strImpPag + '/' + FormatFloat('#,##0.00', fltEstImp) + ESTADUAL;

      If (fltMunImp <> 0.00) Then
        strImpPag := strImpPag + '/' + FormatFloat('#,##0.00', fltMunImp) + MUNICIPAL;

      strImpPag := strImpPag + FONTE_IBPT;
      pAddMensagem(Copy(fPadR(strImpPag, 48), 1, 48));
    End;
  End;

  If VS_strUsaPaf = 'S' Then
  Begin
    pAddMensagem(fPadR(fRetDocMaisTelParaIF(strNumDoc, strTelCli, 48), 48));

    If Not blnImpPag Then
      pAddMensagem(fPadR(LeftStr(strNomCli, 39) + '-' + strCodCli, 48));

    If fEmptyStr(strMenPaf02) Then
      pAddMensagem(fPadR(strEndCli + ' - ' + strBaiCli, 48));
  End
  Else
  Begin
    pAddMensagem(fPadR(fRetDocMaisTelParaIF(strNumDoc, strTelCli, 48), 48));
    pAddMensagem(fPadR(LeftStr(strNomCli, 39) + '-' + strCodCli, 48));
    pAddMensagem(fPadR(strEndCli + ' - ' + strBaiCli, 48));

    If Not blnImpPag Then
      pAddMensagem(fPadR(strCepCli + ' - ' + strCidCli + '-' + strEstCli, 48));
  End;

  If fCfgSis('ORGDFI', varBoolean) Then
    pAddMensagem(fPadR( 'PROCON-'+fCadEmp('ESTADO')+': ' + fCfgSis('ENDPRC') + ' TEL: ' + fCfgSis('TELPRC') , 48))

  Else If fCfgSis('SIMNAC', varBoolean) Then
    pAddMensagem(fPadR( 'ICMS A SER REC. CONF. LC 123/2006 - SIMPLES NAC', 48));

  If fCfgSis('ORGDFI', varBoolean) And (Not fEmptyStr(fCfgSis('ENDALE'))) Then
    pAddMensagem(fPadR( 'ALERJ: ' + fCfgSis('ENDALE') + ' TEL: ' + fCfgSis('TELALE') , 48));

  If (fCadEmp('ESTADO') = 'MG') And
     (fCfgSis('MINLEG', varBoolean)) Then
  Begin
    pAddMensagem(fPadR( 'MINAS LEGAL:' + Trim(fTiraCaracEspeciais(fNumeroCNPJUsuario, True, True, True)) + ' ' +
                                FormatDateTime('ddmmyyyy', fDataEcf) +
                                fPadL(AnsiReplaceStr(FloatToStrF(fltTotMlg, ffNumber, 12, 2), '.', ''), 8, ' '), 48));
  End
  Else
  If fCfgSis('CUPMAN', varBoolean) Then
  Begin
    strCupMan := fPadR( 'CUPOM MANIA, CONCORRA A PRÊMIOS VEND:' + strNomVen, 48);
    strCupMan := strCupMan + fPadR( 'ENVIE SMS P/ 6789:' + Trim(fTiraCaracEspeciais(fNumeroIEUsuario, True, True)) +
                                    FormatDateTime('ddmmyyyy', fDataEcf) +
                                    fRetornaCOO +
                                    RightStr(fNumeroCaixa, 3), 48);

    pAddMensagem(strCupMan);
  End;

  If fEmptyStr(strCupMan) Then
  Begin
    pAddMensagem(fPadR('Vendedor: ' + strNomVen, 48));
  End;

  If (fTemLinhaDisponivel) And
     (fCfgSis('UTINPS', varBoolean)) And
     (fGanhouNetpoints(strNumDoc,
                       'IF',
                       VS_strCodEmp,
                       strCodCli,
                       fSerieIF,
                       intQtdNps)) Then
  Begin
    pAddMensagem(Format(MSG_NETPOINTS, [IntToStr(intQtdNps)]));
  End;

  FCodErr := IntToStr(Bematech_FI_TerminaFechamentoCupom( AnsiString(strMens) ));
  Result  := fVerErro;

  If Result Then
    VS_blnCupomAberto := False;
end;

function TBematech.fFechaRelatorioGerencial(blnVerErro: Boolean): Boolean;
begin
  FCodErr := IntToStr(Bematech_FI_FechaRelatorioGerencial);
  Result  := fVerErro(blnVerErro);
end;

function TBematech.fFinaliza: Integer;
begin
  Result := 0
end;

function TBematech.fGerarSintegra(blnApenas75: Boolean; strArquivo, strMes,
  strAno, strRazSoc, strEndere, strNumEnd, strComple, strBairro, strCidade,
  strNumCep, strFone01, strNumFax, strContat: String): Boolean;
  Var
    intRelatorio: Integer;
begin

  If (blnApenas75) Then
    intRelatorio := 32
  Else
    intRelatorio := 63;

  FCodErr := IntToStr(Bematech_FI_RelatorioSintegraMFD(intrelatorio, AnsiString(strArquivo),
                      AnsiString(strMes), AnsiString(strAno), AnsiString(strRazSoc), AnsiString(strEndere), AnsiString(strNumEnd),
                      AnsiString(strComple), AnsiString(strBairro), AnsiString(strCidade), AnsiString(strNumCep), AnsiString(strFone01),
                      AnsiString(strNumFax), AnsiString(strContat)));
  Result := fVerErro;
end;

function TBematech.fGrandeTotal: Double;
  Var
    strGrandeTotal: AnsiString;
begin
  SetLength(strGrandeTotal, 18);
  FCodErr := IntToStr(Bematech_FI_GrandeTotal(strGrandeTotal));
  Result := 0;

  If (fVerErro) Then
    Result := fFormataFloat(fStrToFloat(String(strGrandeTotal))/100, 2);
    
end;

function TBematech.fHoraEcf: TDateTime;
begin
  Result := fTime();
end;

function TBematech.fHoraGravacaoSoftwareBasico: TDateTime;
begin
  pCarregaDataHoraGravSB;
  Result := FHoraGravacaoSB;
end;

function TBematech.fImpLinFiscal(strAtrib, strLinha: String): Boolean;
begin
  Result := True;
end;

function TBematech.fInicia: Integer;
begin
  Result:=0
end;

function TBematech.fLeituraMemoriaFiscal(blnCompleta: Boolean;
  strTipoFiltro, strFiltroIni, strFiltroFin: String): Boolean;
  Var
    strComSim: String;
begin
  strComSim := IIF(blnCompleta, 'C', 'S');

  If (strTipoFiltro = 'D') Then
    FCodErr := IntToStr(Bematech_FI_LeituraMemoriaFiscalDataMFD(AnsiString(strFiltroIni), AnsiString(strFiltroFin), AnsiString(strComSim)))
  Else
    FCodErr := IntToStr(Bematech_FI_LeituraMemoriaFiscalReducaoMFD(AnsiString(strFiltroIni), AnsiString(strFiltroFin), AnsiString(strComSim)));

  Result := fVerErro(True);
  
end;

function TBematech.fLeituraX(strParam: String;
  blnPergunta: Boolean): Boolean;
begin
  FCodErr := IntToStr(Bematech_FI_LeituraX);
  Result  := fVerErro;
end;

function TBematech.fMarcaECF: String;
  Var
    strModelo: AnsiString;
    strTipo: AnsiString;
    strResult: AnsiString;
begin
  SetLength(strResult, 15);
  SetLength(strModelo, 20);
  SetLength(strTipo, 07);

  FCodErr := IntToStr(Bematech_FI_MarcaModeloTipoImpressoraMFD(strResult, strModelo, strTipo));
  Result := Trim(String(strResult));
end;

function TBematech.fMFDAdicional: String;
begin
  Result := '';
end;

function TBematech.fModeloEcf: String;
  Var
    strResult: AnsiString;
begin
  SetLength(strResult, 10);
  FCodErr := IntToStr(Bematech_FI_ModeloImpressora(strResult));

  Result := Trim(String(strResult));
end;

function TBematech.fNumeroCaixa: String;
begin
  Result := String(FNumCaixa);
end;

function TBematech.fNumeroCCF: String;
  Var
    strResult: AnsiString;
begin
  SetLength(strResult, 6);
  FCodErr := IntToStr(Bematech_FI_ContadorCupomFiscalMFD(strResult));
  Result := String(strResult);
end;

function TBematech.fNumeroCDC: String;
  Var
    strResult: AnsiString;
begin
  SetLength(strResult, 4);
  FCodErr := IntToStr(Bematech_FI_ContadorComprovantesCreditoMFD(strResult));

  Result := fStrZero(String(strResult), 4);
end;

function TBematech.fNumeroCNPJUsuario: String;
begin
  Result := String(FCNPJ);
end;

function TBematech.fNumeroGNF: String;
  Var
    strResult: AnsiString;
begin
  SetLength(strResult, 6);
  FCodErr := IntToStr(Bematech_FI_NumeroOperacoesNaoFiscais(strResult));
  Result := fStrZero(String(strResult), 6);
end;

function TBematech.fNumeroGRG: String;
  Var
    strResult: AnsiString;
begin
  SetLength(strResult, 6);
  FCodErr := IntToStr(Bematech_FI_ContadorRelatoriosGerenciaisMFD(strResult));
  Result := fStrZero(String(strResult), 6);
end;

function TBematech.fNumeroIEUsuario: String;
begin
  Result := String(FIE);
end;

function TBematech.fNumeroSerie: String;
begin
  Result := FNumSer;
end;

function TBematech.fNumeroSerieInt: String;
  Var
    strResult: AnsiString;
begin
  SetLength(strResult, 20);
  FCodErr := IntToStr(Bematech_FI_NumeroSerieMFD(strResult));
  Result := String(strResult);
end;

function TBematech.fNumeroUsuario: String;
  Var
    strResult: AnsiString;
begin
  SetLength(strResult, 4);
  FCodErr := IntToStr(Bematech_FI_NumeroSubstituicoesProprietario(strResult));
  Result := fStrZero(String(strResult), 4);
end;

function TBematech.fReducaoZ(strData, strHora: String): Boolean;
begin
  FCodErr := IntToStr(Bematech_FI_ReducaoZ(AnsiString(Trim(strData)),AnsiString(Trim(strHora))));
  Result  := fVerErro;
end;

function TBematech.fReducaoZPendente: Boolean;
  Const
    RZ_PENDENTE : String = '1';

  Var
    strResult: AnsiString;
    HandleDllBema: Cardinal;
begin
  SetLength(strResult, 1);
  Try
    If Not Assigned(Bematech_FI_VerificaZPendente) Then
    Begin
      HandleDllBema := LoadLibrary('BEMAFI32.DLL');
      If HandleDllBema = 0 Then
        Result := False
      Else
      Begin
        Bematech_FI_VerificaZPendente := GetProcAddress(HandleDllBema, 'Bematech_FI_VerificaZPendente');
        If Not Assigned(Bematech_FI_VerificaZPendente) Then
          Result := False
        Else
        Begin
          FCodErr := IntToStr(Bematech_FI_VerificaZPendente(strResult));
          Result := (Trim(String(strResult)) = RZ_PENDENTE);
        End;
      End;
    End
    Else
    Begin
      FCodErr := IntToStr(Bematech_FI_VerificaZPendente(strResult));
      Result := (Trim(String(strResult)) = RZ_PENDENTE);
    End;
  Except
    Result := False;
  End;
end;

function TBematech.fRegistraAcrDes(strAcrDes, strTip_AC, strVal_AC: String;
  fltTotal, fltTotImp: Double): Boolean;
  Var
    fltValDes: Double;
    strDesEsp: String;
begin
  strAcrDes := 'D';
  fltValDes := 0;

  fltTotMlg := fltTotal;

  If fFormataFloat( fltTotImp, 2 ) > fFormataFloat( fltTotal, 2 ) Then
  Begin
    strAcrDes := 'D';
    fltValDes := fltTotImp - fltTotal;
  End
  Else If fFormataFloat( fltTotImp, 2 ) < fFormataFloat( fltTotal, 2 ) Then
  Begin
    strAcrDes := 'A';
    fltValDes := fltTotal - fltTotImp;
  End;

  strDesEsp := FloatToStrF( fltValDes, ffNumber, 14, 2 );
  strDesEsp := AnsiReplaceStr( strDesEsp, '.', '' );
  strDesEsp := AnsiReplaceStr( strDesEsp, ',', '' );
  strDesEsp := fPadL(strDesEsp, 14, '0');

  FCodErr := IntToStr(Bematech_FI_IniciaFechamentoCupom(AnsiString(strAcrDes), AnsiString(strTip_AC), AnsiString(strDesEsp)));
  Result  := fVerErro;
end;

function TBematech.fRegistraItem(strCodIte, strDesIte, strUnidad: String;
  fltAlqIcm, fltQtdIte, fltUnitar: Double; strCodFis: String; fltDesEsp: Double; fltTotal: Double = 0): Boolean;
  Var
    strAlqIcm: String;
    strQuanti: String;
    strUnitar: String;
    strDesEsp: String;
    strAcresc: String;
    strModEcf: String;
    strSigUni: String;
    intDecUni: Integer;
    intContador: Integer;
    blnImpUni: Boolean;
    fltQuantidadeCalcAcrDes: Double;
    fltTotIteSistema: Double;

  procedure pSetaUnitarioEcf;
  begin
    If SameText(strModEcf, BEMATECH_MP20) Then
      strUnitar := fPadL(AnsiReplaceText(FloatToStrF(fltUnitar, ffNumber, 9, intDecUni), FormatSettings.ThousandSeparator, ''), 9, '0')
    Else
      strUnitar := fPadL(AnsiReplaceText(FloatToStrF(fltUnitar, ffNumber, 9, 3), FormatSettings.ThousandSeparator, ''), 9, '0');
  end;
begin
  intDecUni := fFmtDecimalBemat;

  strAlqIcm := fCalcAliquota(strCodFis, fltAlqIcm, 1);
  strModEcf := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'MODELO', '', strDirIni + '/opcoes_fiscal.ini' );

  If SameText(strModEcf, BEMATECH_MP20) Then
  Begin
    strQuanti := fPadL(FloatToStrF(fltQtdIte, ffNumber, 7, DEC_UNIT), 7, '0');
    fltQuantidadeCalcAcrDes := fStrToFloat(strQuanti);
  End
  Else
  Begin
    strQuanti := AnsiReplaceText(FloatToStrF(fltQtdIte, ffNumber, 7, DEC_UNIT), FormatSettings.ThousandSeparator, '');
    strQuanti := AnsiReplaceText(strQuanti, FormatSettings.DecimalSeparator, '');
    strQuanti := fPadL(strQuanti, 7, '0');
    fltQuantidadeCalcAcrDes := fStrToFloat(strQuanti)/1000;
  End;

  strSigUni := strUnidad;
  blnImpUni := True;

  For intContador := 1 To length(strUnidad) Do
  Begin
    If (Pos(copy(strUnidad,intContador,1), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ') <= 0) Then
      blnImpUni := False;
  End;

  If Not blnImpUni Then
    strSigUni := 'UN';

  pSetaUnitarioEcf;

  pCalculaAcrDesItem(Self, fltQuantidadeCalcAcrDes, fStrToFloat(strUnitar),
    fltQtdIte, fltUnitar, fltDesEsp, fltUltDesEspIte, fltUltAcrescIte);

  fltTotIteSistema := (fFormataFloat(fltQtdIte * fltUnitar, 2) - fltDesEsp);

  If (fFormataFloat(fRetTotalImpressora(fltQtdIte, fltUnitar)+fltUltAcrescIte, 2) = fltTotIteSistema) And
     (fFormataFloat(fltUltAcrescIte, 2) = fFormataFloat(0.01, 2)) And
     (fFormataFloat(fltTotIteSistema, 2) < fFormataFloat(1.00, 2)) Then
  Begin
    fltUnitar := fFormataFloat((fltTotIteSistema + fltUltAcrescIte) / fltQtdIte, intDecUni);
    fltUltDesEspIte := fltUltAcrescIte;
    fltUltAcrescIte := 0;

    If fRetTotalImpressora(fltQtdIte, fltUnitar) = fFormataFloat(fltTotIteSistema, 2) Then
    Begin
      fltUltDesEspIte := 0;
    End;

    pSetaUnitarioEcf;

  End;

  strDesEsp := FloatToStrF(fltUltDesEspIte, ffNumber, 8, 2);
  strAcresc := FloatToStrF(fltUltAcrescIte, ffNumber, 8, 2);

  If SameText(strModEcf, BEMATECH_MP20) Then
  Begin
    strUnitar := Copy(strUnitar, 2, 8);
    Bematech_FI_AumentaDescricaoItem(AnsiString(Copy(strDesIte, 1, 200)));
    FCodErr := IntToStr(Bematech_FI_VendeItem(AnsiString(strCodIte), AnsiString(Copy(strDesIte, 1, 29)), AnsiString(strAlqIcm), 'F', AnsiString(strQuanti), intDecUni, AnsiString(strUnitar), '$', AnsiString(strDesEsp)));
  End
  Else
    FCodErr := IntToStr(Bematech_FI_VendeItemDepartamento(AnsiString(strCodIte),
      AnsiString(fPadR(strDesIte, 57, 200)), AnsiString(strAlqIcm), AnsiString(strUnitar), AnsiString(strQuanti),
      AnsiString(strAcresc), AnsiString(strDesEsp), AnsiString('01'), AnsiString(fstrEspaco(strSigUni,2))));

  Result  := fVerErro;

  If fIsNumber(strAlqIcm) Then
    strUltIndiceTri := strAlqIcm
  Else
    strUltIndiceTri := LeftStr(strAlqIcm, 1);

  If Result Then
  Begin
    Inc(intUltItem,1);
  End;

  //Retirado, pois função  Bematech_FI_UltimoItemVendido está sempre retornando 0000
  {If Result Then
  Begin
    SetLength(strUltItemVendido, 5);
    FCodErr := IntToStr(Bematech_FI_UltimoItemVendido(strUltItemVendido));
    Result := fVerErro;

    If Result Then
    Begin
      If intUltItem <> StrToIntDef(String(strUltItemVendido), 0) Then
      Begin
        Raise Exception.Create('ATENÇÃO: houve um problema ao registrar o item ' +
          strCodIte + '-' + strDesIte + '. Por favor, reimprima o cupom.');
      End;
    End;
  End;}

end;

function TBematech.fRegistraModalidades(strCodMod, strDesMod: String;
  fltValMod: Double; strInfAdi: String): Boolean;
  Var
    strValor: String;
begin
  strValor := FloatToStrF(fltValMod, ffFixed, 11,2);
  strValor := AnsiReplaceStr(strValor, '.', '');

  If fEmptyStr(strInfAdi) Then
  Begin
    strInfAdi := ' ';
  End;

  FCodErr := IntToStr(Bematech_FI_EfetuaFormaPagamentoDescricaoForma(AnsiString( Trim(LeftStr(strDesMod, 16))), AnsiString(strValor), AnsiString(strInfAdi)));
  Result  := fVerErro;
end;

function TBematech.fRelatorioGerencial(strTexto: String): Boolean;
begin
  FCodErr := IntToStr(Bematech_FI_RelatorioGerencial( AnsiString(strTexto) ));
  Result  := fVerErro;
end;

function TBematech.fRetornaCoo: String;
  Var
    strResult: AnsiString;
begin
  SetLength(strResult,6);
  FCodErr := IntToStr(Bematech_FI_NumeroCupom(strResult));
  Result := String(strResult);
end;

function TBematech.fRetorno(var ACK, ST1, ST2, ST3: Integer): String;
begin
  Result := IntToStr(Bematech_FI_RetornoImpressoraMFD( ACK, ST1, ST2, ST3 ));

  If Result = '1' Then
  Begin
    If ( ST1 + ST2 + ST3 ) = 0 Then
      Result := '0'
    Else
      Result := RightStr( '000' + Trim( IntToStr( ACK ) ), 3 ) +
                RightStr( '000' + Trim( IntToStr( ST1 ) ), 3 ) +
                RightStr( '000' + Trim( IntToStr( ST2 ) ), 3 ) +
                RightStr( '000' + Trim( IntToStr( ST3 ) ), 3 );  
  End;
end;

function TBematech.fRetTotalImpressora(fltQtdIte,
  fltUnitar: Double): Double;
begin
  Result := fTruncaFloat( fFormataFloat(fltQtdIte, DEC_UNIT) * fFormataFloat(fltUniTar, fFmtDecimalBemat), 2);
end;

function TBematech.fSangria(fltValor: Double): Boolean;
  Var
    strValor: String;
begin
  strValor := FloatToStrF(fltValor, ffNumber, 12, 2);
  FCodErr := IntToStr(Bematech_FI_Sangria(AnsiString(strValor)));

  Result := fVerErro;
end;

function TBematech.fStatusImpressora: String;
begin
  FCodErr := IntToStr(Bematech_FI_VerificaImpressoraLigada);
  Result  := FCodErr;
end;

function TBematech.fSuprimento(fltValor: Double; strModalidade: String='Dinheiro'): Boolean;
  Var
    strValor: String;
begin
  strValor := FloatToStrF(fltValor, ffNumber, 12, 2);
  FCodErr := IntToStr(Bematech_FI_Suprimento(AnsiString(strValor), AnsiString(strModalidade)));

  Result := fVerErro;
end;

function TBematech.fTipoECF: String;
  Var
    strMarca: AnsiString;
    strModelo: AnsiString;
    strResult: AnsiString;
begin
  SetLength(strMarca, 15);
  SetLength(strModelo, 20);
  SetLength(strResult, 07);

  FCodErr := IntToStr(Bematech_FI_MarcaModeloTipoImpressoraMFD(strMarca, strModelo, strResult));
  Result := Trim(String(strResult));
end;

function TBematech.fUltimoComandoComErro: Boolean;
begin
  Result := blnUltComandoErro;
end;

function TBematech.fUltimoItemVendido: String;
begin
//  Result := '';
//  SetLength(Result, 4);
//  FCodErr := IntToStr(Bematech_FI_UltimoItemVendido(Result));

//  Result := fStrZero(Trim(Result), 4);
  Result := fStrZero(intUltItem, 4);
end;

function TBematech.fUsaCNFVinculado(strTexto: String): Boolean;
begin
  FCodErr := IntToStr(Bematech_FI_UsaComprovanteNaoFiscalVinculado( AnsiString(strTexto) ));
  Result  := fVerErro;
end;

function TBematech.fVendaBruta: Double;
  Var
    stlMapa: TStringList;
    strVendaBruta: String;
begin
  FCodErr := IntToStr(Bematech_FI_MapaResumo);
  Result := 0;
  If (fVerErro) Then
  Begin
    Try
      stlMapa := TStringList.Create;

      If FileExists(fArquivoRetornoTxtBemaFI32) Then
        stlMapa.LoadFromFile(fArquivoRetornoTxtBemaFI32);

      If stlMapa.Count = 0 Then
        Exit;

      strVendaBruta := Copy(stlMapa[2], 25, 16);

      Result := fStrToFloat(strVendaBruta);
    Finally
      FreeAndNil(stlMapa);
    end;
  End;
end;

function TBematech.fVerErro(blnMostraErro: Boolean): Boolean;
  Var
    intACK: Integer;
    intST1: Integer;
    intST2: Integer;
    intST3: Integer;
    strMen: String;
    intCodErr: Integer;
    strCodErr: String;
begin
  blnUltComandoErro := False;

  Result := True;
  strMen := '';

  intCodErr := StrToInt(FCodErr);

  If intCodErr = 1 Then
  Begin
    intACK := 0;
    intST1 := 0;
    intST2 := 0;
    intST3 := 0;

    strCodErr := fStrZero(fRetorno(intACK, intST1, intST2, intST3), 12);
  End;

  If intCodErr = 1 Then
  Begin
    intACK := StrToInt( Copy( strCodErr, 1, 3 ) );
    intST1 := StrToInt( Copy( strCodErr, 4, 3 ) );
    intST2 := StrToInt( Copy( strCodErr, 7, 3 ) );
    intST3 := StrToInt( Copy( strCodErr, 10, 3 ) );

    If intACK = 21 Then
    Begin

      If blnMostraErro Then
        fMensagem('', 'RECEBIMENTO INCORRETO DA IMPRESSORA (NAK).', ['&OK']);

      Result := False;
    End

    Else If intACK = 6 Then
    Begin

      If intST1 >= 128 Then
      Begin
        strMen := strMen + ' FIM DE PAPEL,';
        intST1 := intST1 - 128;
        Result := False;
      End;

      If intST1 >= 64 Then
      Begin
        //strMen := strMen + ' POUCO PAPEL,';
        intST1 := intST1 - 64;
      End;

      If intST1 >= 32 Then
      Begin
        strMen := strMen + ' ERRO NO RELÓGIO,';
        intST1 := intST1 - 32;
        Result := False;
      End;

      If intST1 >= 16 Then
      Begin
        strMen := strMen + ' IMPRESSORA EM ERRO,';
        intST1 := intST1 - 16;
        Result := False;
      End;

      If intST1 >= 8 Then
      Begin
        strMen := strMen + ' COMANDO NÃO INICIADO COM ESC,';
        intST1 := intST1 - 8;
        Result := False;
      End;

      If intST1 >= 4 Then
      Begin
        strMen := strMen + ' COMANDO INEXISTENTE,';
        intST1 := intST1 - 4;
        Result := False;
      End;

      If intST1 >= 2 Then
      Begin
        strMen := strMen + ' CUPOM ABERTO,';
        intST1 := intST1 - 2;
        Result := False;
      End;

      If intST1 >= 1 Then
      Begin
        strMen := strMen + ' NÚMERO DE PARÂMETRO(S) INVÁLIDO(S),';
        intST1 := intST1 - 1;
        Result := False;
      End;

      If intST2 >= 128 Then
      Begin
        strMen := strMen + ' TIPO DE PARÂMETRO DE COMANDO INVÁLIDO,';
        intST2 := intST2 - 128;
        Result := False;
      End;

      If intST2 >= 64 Then
      Begin
        strMen := strMen + ' MEMÓRIA FISCAL LOTADA,';
        intST2 := intST2 - 64;
        Result := False;
      End;

      If intST2 >= 32 Then
      Begin
        strMen := strMen + ' ERRO NA MEMÓRIA RAM,';
        intST2 := intST2 - 32;
        Result := False;
      End;

      If intST2 >= 16 Then
      Begin
        strMen := strMen + ' ALÍQUOTA NÃO PROGRAMADA,';
        intST2 := intST2 - 16;
        Result := False;
      End;

      If intST2 >= 8 Then
      Begin
        strMen := strMen + ' CAPACIDADE DE ALÍQUOTAS LOTADA,';
        intST2 := intST2 - 8;
        Result := False;
      End;

      If intST2 >= 4 Then
      Begin
        strMen := strMen + ' CANCELAMENTO NÃO PERMITIDO,';
        intST2 := intST2 - 4;
        Result := False;
      End;

      If intST2 >= 2 Then
      Begin
        strMen := strMen + ' CNPJ/IE DO PROPRIETÁRIO NÃO PROGRAMADO,';
        intST2 := intST2 - 2;
        Result := False;
      End;

      If intST2 >= 1 Then
      Begin
        strMen := strMen + ' COMANDO (MAC) NÃO EXECUTADO,';
        intST2 := intST2 - 1;
        Result := False;
      End;

      If intST3 > 0 Then
        strMen := '';

      Case intST3 Of
        001: strMen := strMen + ' COMANDO INVÁLIDO, ';
        002: strMen := strMen + ' ERRO DESCONHECIDO, ';
        003: strMen := strMen + ' NÚMERO DE PARÂMETRO INVÁLIDO, ';
        004: strMen := strMen + ' TIPO DE PARÂMETRO INVÁLIDO, ';
        005: strMen := strMen + ' TODAS ALÍQUOTAS JÁ PROGRAMADAS, ';
        006: strMen := strMen + ' TOTALIZADOR NÃO FISCAL JÁ PROGRAMADO, ';
        007: strMen := strMen + ' CUPOM FISCAL ABERTO, ';
        008: strMen := strMen + ' CUPOM FISCAL FECHADO, ';
        009: strMen := strMen + ' ECF OCUPADO, ';
        010: strMen := strMen + ' IMPRESSORA EM ERRO, ';
        011: strMen := strMen + ' IMPRESSORA SEM PAPEL, ';
        012: strMen := strMen + ' IMPRESSORA COM CABEÇA LEVANTADA, ';
        013: strMen := strMen + ' IMPRESSORA OFF LINE, ';
        014: strMen := strMen + ' ALÍQUOTA NÃO PROGRAMADA, ';
        015: strMen := strMen + ' TERMINADOR DE STRING FALTANDO, ';
        016: strMen := strMen + ' ACRÉSCIMO OU DESCONTO MAIOR QUE O TOTAL DO CUPOM FISCAL, ';
        017: strMen := strMen + ' CUPOM FISCAL SEM ITEM VENDIDO, ';
        018: strMen := strMen + ' COMANDO NÃO EFETIVADO, ';
        019: strMen := strMen + ' SEM ESPAÇO PARA NOVAS FORMAS DE PAGAMENTO, ';
        020: strMen := strMen + ' FORMA DE PAGAMENTO NÃO PROGRAMADA, ';
        021: strMen := strMen + ' ÍNDICE MAIOR QUE NÚMERO DE FORMA DE PAGAMENTO, ';
        022: strMen := strMen + ' FORMAS DE PAGAMENTO ENCERRADAS, ';
        023: strMen := strMen + ' CUPOM NÃO TOTALIZADO, ';
        024: strMen := strMen + ' COMANDO MAIOR QUE 7Fh (127d), ';
        025: strMen := strMen + ' CUPOM FISCAL ABERTO E SEM ÍTEM, ';
        026: strMen := strMen + ' CANCELAMENTO NÃO IMEDIATAMENTE APÓS, ';
        027: strMen := strMen + ' CANCELAMENTO JÁ EFETUADO, ';
        028: strMen := strMen + ' COMPROVANTE DE CRÉDITO OU DÉBITO NÃO PERMITIDO OU JÁ EMITIDO, ';
        029: strMen := strMen + ' MEIO DE PAGAMENTO NÃO PERMITE TEF, ';
        030: strMen := strMen + ' SEM COMPROVANTE NÃO FISCAL ABERTO, ';
        031: strMen := strMen + ' COMPROVANTE DE CRÉDITO OU DÉBITO JÁ ABERTO, ';
        032: strMen := strMen + ' REIMPRESSÃO NÃO PERMITIDA, ';
        033: strMen := strMen + ' COMPROVANTE NÃO FISCAL JÁ ABERTO, ';
        034: strMen := strMen + ' TOTALIZADOR NÃO FISCAL NÃO PROGRAMADO, ';
        035: strMen := strMen + ' CUPOM NÃO FISCAL SEM ÍTEM VENDIDO, ';
        036: strMen := strMen + ' ACRÉSCIMO E DESCONTO MAIOR QUE TOTAL CNF, ';
        037: strMen := strMen + ' MEIO DE PAGAMENTO NÃO INDICADO, ';
        038: strMen := strMen + ' MEIO DE PAGAMENTO DIFERENTE DO TOTAL DO RECEBIMENTO, ';
        039: strMen := strMen + ' NÃO PERMITIDO MAIS DE UMA SANGRIA OU SUPRIMENTO, ';
        040: strMen := strMen + ' RELATÓRIO GERENCIAL JÁ PROGRAMADO, ';
        041: strMen := strMen + ' RELATÓRIO GERENCIAL NÃO PROGRAMADO, ';
        042: strMen := strMen + ' RELATÓRIO GERENCIAL NÃO PERMITIDO, ';
        043: strMen := strMen + ' MFD NÃO INICIALIZADA, ';
        044: strMen := strMen + ' MFD AUSENTE, ';
        045: strMen := strMen + ' MFD SEM NÚMERO DE SÉRIE, ';
        046: strMen := strMen + ' MFD JÁ INICIALIZADA, ';
        047: strMen := strMen + ' MFD LOTADA, ';
        048: strMen := strMen + ' CUPOM NÃO FISCAL ABERTO, ';
        049: strMen := strMen + ' MEMÓRIA FISCAL DESCONECTADA, ';
        050: strMen := strMen + ' MEMÓRIA FISCAL SEM NÚMERO DE SÉRIE DA MFD, ';
        051: strMen := strMen + ' MEMÓRIA FISCAL LOTADA, ';
        052: strMen := strMen + ' DATA INICIAL INVÁLIDA, ';
        053: strMen := strMen + ' DATA FINAL INVÁLIDA, ';
        054: strMen := strMen + ' CONTADOR DE REDUÇÃO Z INICIAL INVÁLIDO, ';
        055: strMen := strMen + ' CONTADOR DE REDUÇÃO Z FINAL INVÁLIDO, ';
        056: strMen := strMen + ' ERRO DE ALOCAÇÃO, ';
        057: strMen := strMen + ' DADOS DO RTC INCORRETOS, ';
        058: strMen := strMen + ' DATA ANTERIOR AO ÚLTIMO DOCUMENTO EMITIDO, ';
        059: strMen := strMen + ' FORA DE INTERVENÇÃO TÉCNICA, ';
        060: strMen := strMen + ' EM INTERVENÇÃO TÉCNICA, ';
        061: strMen := strMen + ' ERRO NA MEMÓRIA DE TRABALHO, ';
        062: strMen := strMen + ' JÁ HOUVE MOVIMENTO NO DIA, ';
        063: strMen := strMen + ' BLOQUEIO POR RZ, ';
        064: strMen := strMen + ' FORMA DE PAGAMENTO ABERTA, ';
        065: strMen := strMen + ' AGUARDANDO PRIMEIRO PROPRIETÁRIO, ';
        066: strMen := strMen + ' AGUARDANDO RZ, ';
        067: strMen := strMen + ' ECF OU LOJA IGUAL A ZERO, ';
        068: strMen := strMen + ' CUPOM ADICIONAL NÃO PERMITIDO, ';
        069: strMen := strMen + ' DESCONTO MAIOR QUE TOTAL VENDIDO EM ICMS, ';
        070: strMen := strMen + ' RECEBIMENTO NÃO FISCAL NULO NÃO PERMITIDO, ';
        071: strMen := strMen + ' ACRÉSCIMO OU DESCONTO MAIOR QUE TOTAL NÃO FISCAL, ';
        072: strMen := strMen + ' MEMÓRIA FISCAL LOTADA PARA NOVO CARTUCHO, ';
        073: strMen := strMen + ' ERRO DE GRAVAÇÃO NA MF, ';
        074: strMen := strMen + ' ERRO DE GRAVAÇÃO NA MFD, ';
        075: strMen := strMen + ' DADOS DO RTC ANTERIORES AO ÚLTIMO DOC ARMAZENADO, ';
        076: strMen := strMen + ' MEMÓRIA FISCAL SEM ESPAÇO PARA GRAVAR LEITURAS DA MFD, ';
        077: strMen := strMen + ' MEMÓRIA FISCAL SEM ESPAÇO PARA GRAVAR VERSAO DO SB, ';
        078: strMen := strMen + ' DESCRIÇÃO IGUAL A DEFAULT NÃO PERMITIDO, ';
        079: strMen := strMen + ' EXTRAPOLADO NÚMERO DE REPETIÇÕES PERMITIDAS, ';
        080: strMen := strMen + ' SEGUNDA VIA DO COMPROVANTE DE CRÉDITO OU DÉBITO NÃO PERMITIDO, ';
        081: strMen := strMen + ' PARCELAMENTO FORA DA SEQUÊNCIA, ';
        082: strMen := strMen + ' COMPROVANTE DE CRÉDITO OU DÉBITO ABERTO, ';
        083: strMen := strMen + ' TEXTO COM SEQUÊNCIA DE ESC INVÁLIDA, ';
        084: strMen := strMen + ' TEXTO COM SEQUÊNCIA DE ESC INCOMPLETA, ';
        085: strMen := strMen + ' VENDA COM VALOR NULO, ';
        086: strMen := strMen + ' ESTORNO DE VALOR NULO, ';
        087: strMen := strMen + ' FORMA DE PAGAMENTO DIFERENTE DO TOTAL DA SANGRIA, ';
        088: strMen := strMen + ' REDUÇÃO NÃO PERMITIDA EM INTERVENÇÃO TÉCNICA, ';
        089: strMen := strMen + ' AGUARDANDO RZ PARA ENTRADA EM INTERVENÇÃO TÉCNICA, ';
        090: strMen := strMen + ' FORMA DE PAGAMENTO COM VALOR NULO NÃO PERMITIDO, ';
        091: strMen := strMen + ' ACRÉSCIMO E DESCONTO MAIOR QUE VALOR DO ÍTEM, ';
        092: strMen := strMen + ' AUTENTICAÇÃO NÃO PERMITIDA, ';
        093: strMen := strMen + ' TIMEOUT NA VALIDAÇÃO, ';
        094: strMen := strMen + ' COMANDO NÃO EXECUTADO EM IMPRESSORA BILHETE DE PASSAGEM, ';
        095: strMen := strMen + ' COMANDO NÃO EXECUTADO EM IMPRESSORA DE CUPOM FISCAL, ';
        096: strMen := strMen + ' CUPOM NÃO FISCAL FECHADO, ';
        097: strMen := strMen + ' PARÂMETRO NÃO ASCII EM CAMPO ASCII, ';
        098: strMen := strMen + ' PARÂMETRO NÃO ASCII NUMÉRICO EM CAMPO ASCII NUMÉRICO, ';
        099: strMen := strMen + ' TIPO DE TRANSPORTE INVÁLIDO, ';
        100: strMen := strMen + ' DATA E HORA INVÁLIDA, ';
        101: strMen := strMen + ' SEM RELATÓRIO GERENCIAL OU COMPROVANTE DE CRÉDITO OU DÉBITO ABERTO, ';
        102: strMen := strMen + ' NÚMERO DO TOTALIZADOR NÃO FISCAL INVÁLIDO, ';
        103: strMen := strMen + ' PARÂMETRO DE ACRÉSCIMO OU DESCONTO INVÁLIDO, ';
        104: strMen := strMen + ' ACRÉSCIMO OU DESCONTO EM SANGRIA OU SUPRIMENTO NÃO PERMITIDO, ';
        105: strMen := strMen + ' NÚMERO DO RELATÓRIO GERENCIAL INVÁLIDO, ';
        106: strMen := strMen + ' FORMA DE PAGAMENTO ORIGEM NÃO PROGRAMADA, ';
        107: strMen := strMen + ' FORMA DE PAGAMENTO DESTINO NÃO PROGRAMADA, ';
        108: strMen := strMen + ' ESTORNO MAIOR QUE FORMA PAGAMENTO, ';
        109: strMen := strMen + ' CARACTER NUMÉRICO NA CODIFICAÇÃO GT NÃO PERMITIDO, ';
        110: strMen := strMen + ' ERRO NA INICIALIZAÇÃO DA MF, ';
        111: strMen := strMen + ' NOME DO TOTALIZADOR EM BRANCO NÃO PERMITIDO, ';
        112: strMen := strMen + ' DATA E HORA ANTERIORES AO ÚLTIMO DOC ARMAZENADO, ';
        113: strMen := strMen + ' PARÂMETRO DE ACRÉSCIMO OU DESCONTO INVÁLIDO, ';
        114: strMen := strMen + ' ÍTEM ANTERIOR AOS TREZENTOS ÚLTIMOS, ';
        115: strMen := strMen + ' ÍTEM NÃO EXISTE OU JÁ CANCELADO, ';
        116: strMen := strMen + ' CÓDIGO COM ESPAÇOS NÃO PERMITIDO, ';
        117: strMen := strMen + ' DESCRICAO SEM CARACTER ALFABÉTICO NÃO PERMITIDO, ';
        118: strMen := strMen + ' ACRÉSCIMO MAIOR QUE VALOR DO ÍTEM, ';
        119: strMen := strMen + ' DESCONTO MAIOR QUE VALOR DO ÍTEM, ';
        120: strMen := strMen + ' DESCONTO EM ISS NÃO PERMITIDO, ';
        121: strMen := strMen + ' ACRÉSCIMO EM ÍTEM JÁ EFETUADO, ';
        122: strMen := strMen + ' DESCONTO EM ÍTEM JÁ EFETUADO, ';
        123: strMen := strMen + ' ERRO NA MEMÓRIA FISCAL CHAMAR CREDENCIADO, ';
        124: strMen := strMen + ' AGUARDANDO GRAVAÇÃO NA MEMÓRIA FISCAL, ';
        125: strMen := strMen + ' CARACTER REPETIDO NA CODIFICAÇÃO DO GT, ';
        126: strMen := strMen + ' VERSÃO JÁ GRAVADA NA MEMÓRIA FISCAL, ';
        127: strMen := strMen + ' ESTOURO DE CAPACIDADE NO CHEQUE, ';
        128: strMen := strMen + ' TIMEOUT NA LEITURA DO CHEQUE, ';
        129: strMen := strMen + ' MÊS INVÁLIDO, ';
        130: strMen := strMen + ' COORDENADA INVÁLIDA, ';
        131: strMen := strMen + ' SOBREPOSIÇÃO DE TEXTO, ';
        132: strMen := strMen + ' SOBREPOSIÇÃO DE TEXTO NO VALOR, ';
        133: strMen := strMen + ' SOBREPOSIÇÃO DE TEXTO NO EXTENSO, ';
        134: strMen := strMen + ' SOBREPOSIÇÃO DE TEXTO NO FAVORECIDO, ';
        135: strMen := strMen + ' SOBREPOSIÇÃO DE TEXTO NA LOCALIDADE, ';
        136: strMen := strMen + ' SOBREPOSIÇÃO DE TEXTO NO OPCIONAL, ';
        137: strMen := strMen + ' SOBREPOSIÇÃO DE TEXTO NO DIA, ';
        138: strMen := strMen + ' SOBREPOSIÇÃO DE TEXTO NO MÊS, ';
        139: strMen := strMen + ' SOBREPOSIÇÃO DE TEXTO NO ANO, ';
        140: strMen := strMen + ' USANDO MFD DE OUTRO ECF, ';
        141: strMen := strMen + ' PRIMEIRO DADO DIFERENTE DE ESC OU 1C, ';
        142: strMen := strMen + ' NÃO PERMITIDO ALTERAR SEM INTERVENÇÃO TÉCNICA, ';
        143: strMen := strMen + ' DADOS DA ÚLTIMA RZ CORROMPIDOS, ';
        144: strMen := strMen + ' COMANDO NÃO PERMITIDO NO MODO INICIALIZAÇÃO, ';
        145: strMen := strMen + ' AGUARDANDO ACERTO DE RELÓGIO, ';
        146: strMen := strMen + ' MFD JÁ INICIALIZADA PARA OUTRA MF, ';
        147: strMen := strMen + ' AGUARDANDO ACERTO DO RELÓGIO OU DESBLOQUEIO PELO TECLADO, ';
        148: strMen := strMen + ' VALOR FORMA DE PAGAMENTO MAIOR QUE MÁXIMO PERMITIDO, ';
        149: strMen := strMen + ' RAZÃO SOCIAL EM BRANCO, ';
        150: strMen := strMen + ' NOME DE FANTASIA EM BRANCO, ';
        151: strMen := strMen + ' ENDEREÇO EM BRANCO, ';
        152: strMen := strMen + ' ESTORNO DE CDC NÃO PERMITIDO, ';
        153: strMen := strMen + ' DADOS DO PROPRIETÁRIO IGUAIS AO ATUAL, ';
        154: strMen := strMen + ' ESTORNO DE FORMA DE PAGAMENTO NÃO PERMITIDO, ';
        155: strMen := strMen + ' DESCRIÇÃO FORMA DE PAGAMENTO IGUAL JÁ PROGRAMADA, ';
        156: strMen := strMen + ' ACERTO DE HORÁRIO DE VERÃO SÓ IMEDIATAMENTE APÓS RZ, ';
        157: strMen := strMen + ' IT NÃO PERMITIDA MF RESERVADA PARA RZ, ';
        158: strMen := strMen + ' SENHA CNPJ INVÁLIDA, ';
        159: strMen := strMen + ' TIMEOUT NA INICIALIZAÇÃO DA NOVA MF, ';
        160: strMen := strMen + ' NÃO ENCONTRADO DADOS NA MFD, ';
        161: strMen := strMen + ' SANGRIA OU SUPRIMENTO DEVEM SER ÚNICOS NO CNF, ';
        162: strMen := strMen + ' ÍNDICE DA FORMA DE PAGAMENTO NULO NÃO PERMITIDO, ';
        163: strMen := strMen + ' UF DESTINO INVÁLIDA, ';
        164: strMen := strMen + ' TIPO DE TRANSPORTE INCOMPATÍVEL COM UF DESTINO, ';
        165: strMen := strMen + ' DESCRIÇÃO DO PRIMEIRO ÍTEM DO BILHETE DE PASSAGEM DIFERENTE DE "TARIFA", ';
        166: strMen := strMen + ' AGUARDANDO IMPRESSÃO DE CHEQUE OU AUTENTICAÇÃO, ';
        167: strMen := strMen + ' NÃO PERMITIDO PROGRAMAÇAO CNPJ IE COM ESPAÇOS EM BRANCO, ';
        168: strMen := strMen + ' NÃO PERMITIDO PROGRAMAÇÃO UF COM ESPAÇOS EM BRANCO, ';
        169: strMen := strMen + ' NÚMERO DE IMPRESSÕES DA FITA DETALHE NESTA INTERVENÇÃO TÉCNICA ESGOTADO, ';
        170: strMen := strMen + ' CF JÁ SUBTOTALIZADO, ';
        171: strMen := strMen + ' CUPOM NÃO SUBTOTALIZADO, ';
        172: strMen := strMen + ' ACRÉSCIMO EM SUBTOTAL JÁ EFETUADO, ';
        173: strMen := strMen + ' DESCONTO EM SUBTOTAL JÁ EFETUADO, ';
        174: strMen := strMen + ' ACRÉSCIMO NULO NÃO PERMITIDO, ';
        175: strMen := strMen + ' DESCONTO NULO NÃO PERMITIDO, ';
        176: strMen := strMen + ' CANCELAMENTO DE ACRÉSCIMO OU DESCONTO EM SUBTOTAL NÃO PERMITIDO, ';
        177: strMen := strMen + ' DATA INVÁLIDA, ';
        178: strMen := strMen + ' VALOR DO CHEQUE NULO NÃO PERMITIDO, ';
        179: strMen := strMen + ' VALOR DO CHEQUE INVÁLIDO, ';
        180: strMen := strMen + ' CHEQUE SEM LOCALIDADE NÃO PERMITIDO, ';
        181: strMen := strMen + ' CANCELAMENTO ACRÉSCIMO EM ÍTEM NÃO PERMITIDO, ';
        182: strMen := strMen + ' CANCELAMENTO DESCONTO EM ÍTEM NÃO PERMITIDO, ';
        183: strMen := strMen + ' NÚMERO MÁXIMO DE ÍTENS ATINGIDO, ';
        184: strMen := strMen + ' NÚMERO DE ÍTEM NULO NÃO PERMITIDO, ';
        185: strMen := strMen + ' MAIS QUE DUAS ALÍQUOTAS DIFERENTES NO BILHETE DE PASSAGEM NÃO PERMITIDO, ';
        186: strMen := strMen + ' ACRÉSCIMO OU DESCONTO EM ITEM NÃO PERMITIDO, ';
        187: strMen := strMen + ' CANCELAMENTO DE ACRÉSCIMO OU DESCONTO EM ITEM NÃO PERMITIDO, ';
        188: strMen := strMen + ' CLICHE JÁ IMPRESSO, ';
        189: strMen := strMen + ' TEXTO OPCIONAL DO CHEQUE EXCEDEU O MÁXIMO PERMITIDO, ';
        190: strMen := strMen + ' IMPRESSÃO AUTOMÁTICA NO VERSO NÃO PERMITIDO NESTE EQUIPAMENTO, ';
        191: strMen := strMen + ' TIMEOUT NA INSERÇÃO DO CHEQUE, ';
        192: strMen := strMen + ' OVERFLOW NA CAPACIDADE DE TEXTO DO COMPROVANTE DE CRÉDITO OU DÉBITO, ';
        193: strMen := strMen + ' PROGRAMAÇÃO DE ESPAÇOS ENTRE CUPONS MENOR QUE O MÍNIMO PERMITIDO, ';
        194: strMen := strMen + ' EQUIPAMENTO NÃO POSSUI LEITOR DE CHEQUE, ';
        195: strMen := strMen + ' PROGRAMAÇÃO DE ALÍQUOTA COM VALOR NULO NÃO PERMITIDO, ';
        196: strMen := strMen + ' PARÂMETRO BAUD RATE INVÁLIDO, ';
        197: strMen := strMen + ' CONFIGURAÇÃO PERMITIDA SOMENTE PELA PORTA DOS FISCO, ';
        198: strMen := strMen + ' VALOR TOTAL DO ITEM EXCEDE 11 DÍGITOS, ';
        199: strMen := strMen + ' PROGRAMAÇÃO DA MOEDA COM ESPAÇOS EM BRACO NÃO PERMITIDO, ';
        200: strMen := strMen + ' CASAS DECIMAIS DEVEM SER PROGRAMADAS COM 2 OU 3, ';
        201: strMen := strMen + ' NÃO PERMITE CADASTRAR USUÁRIOS DIFERENTES NA MESMA MFD, ';
        202: strMen := strMen + ' IDENTIFICAÇÃO DO CONSUMIDOR NÃO PERMITIDA PARA SANGRIA OU SUPRIMENTO, ';
        203: strMen := strMen + ' CASAS DECIMAIS EM QUANTIDADE MAIOR DO QUE A PERMITIDA, ';
        204: strMen := strMen + ' CASAS DECIMAIS DO UNITÁRIO MAIOR DO QUE O PERMITIDA, ';
        205: strMen := strMen + ' POSIÇÃO RESERVADA PARA ICMS, ';
        206: strMen := strMen + ' POSIÇÃO RESERVADA PARA ISS, ';
        207: strMen := strMen + ' TODAS AS ALÍQUOTAS COM A MESMA VINCULAÇÃO NÃO PERMITIDO, ';
        208: strMen := strMen + ' DATA DE EMBARQUE ANTERIOR A DATA DE EMISSÃO, ';
        209: strMen := strMen + ' ALÍQUOTA DE ISS NÃO PERMITIDA SEM INSCRIÇÃO MUNICIPAL, ';
        210: strMen := strMen + ' RETORNO PACOTE CLICHE FORA DA SEQUÊNCIA, ';
        211: strMen := strMen + ' ESPAÇO PARA ARMAZENAMENTO DO CLICHE ESGOTADO, ';
        212: strMen := strMen + ' CLICHE GRÁFICO NÃO DISPONÍVEL PARA CONFIRMAÇÃO, ';
        213: strMen := strMen + ' CRC DO CLICHE GRÁFICO DIFERENTE DO INFORMADO, ';
        214: strMen := strMen + ' INTERVALO INVÁLIDO, ';
        215: strMen := strMen + ' USUÁRIO JÁ PROGRAMADO, ';
        217: strMen := strMen + ' DETECTADA ABERTURA DO EQUIPAMENTO, ';
        218: strMen := strMen + ' CANCELAMENTO DE ACRÉSCIMO/DESCONTO NÃO PERMITIDO, ';
      End;

      strMen := Trim(strMen);

      If strMen <> '' Then
      Begin
        blnUltComandoErro := True;
        strMen := LeftStr(strMen, Length(strMen) -1) + '.';

        If blnMostraErro Then
          fMensagem('',strMen,['&OK']);

      End;

    End;

  End
  Else If ( intCodErr <= 0 ) Then
  Begin
    intCodErr := Abs(intCodErr);

    case intCodErr of
      00 : strMen := 'Erro de Comunicação !';
      01 : strMen := 'Erro de Execução na Função. Verifique!';
      02 : strMen := 'Parâmetro Inválido !';
      03 : strMen := 'Alíquota não programada !';
      04 : strMen := 'Arquivo BemaFI32.INI não encontrado. Verifique!';
      05 : strMen := 'Erro ao Abrir a Porta de Comunicação';
      06 : strMen := 'Impressora Desligada ou Desconectada';
      07 : strMen := 'Banco Não Cadastrado no Arquivo BemaFI32.ini';
      08 : strMen := 'Erro ao Criar ou Gravar no Arquivo Retorno.txt ou Status.txt';
      18 : strMen := 'Não foi possível abrir arquivo INTPOS.001 !';
      19 : strMen := 'Parâmetro diferentes !';
      20 : strMen := 'Transação cancelada pelo Operador !';
      21 : strMen := 'A Transação não foi aprovada !';
      22 : strMen := 'Não foi possível terminar a Impressão !';
      23 : strMen := 'Não foi possível terminar a Operação !';
      24 : strMen := 'Forma de pagamento não programada.';
      25 : strMen := 'Totalizador não fiscal não programado.';
      26 : strMen := 'Transação já Efetuada !';
      28 : strMen := 'Não há Informações para serem Impressas !';
    End;

    Result := fEmptyStr(strMen);

    If Not Result Then
    Begin

      If blnMostraErro And (intCodErr >= 0) Then
        fMensagem('',strMen,['&OK']);

    End;

  End;

end;

function TBematech.fVerificaCupomAberto: Boolean;
var intFlag : Integer;
begin
  intFlag:=0; 
  Bematech_FI_FlagsFiscais( intFlag );
  
  If (intFlag = 1) Or (intFlag = 33) Or (intFlag = 37) Or (intFlag = 39)  Then
    Result:=True 
  Else
    Result:=False;  
end;

function TBematech.fVersaoSoftwareBasico: String;
begin
  Result := String(FVersaoSB);
end;

function TBematech.fCarregaDataHoraGravacaoSoftwareBasicoBanco(
  var strSWBasicoString: String): Boolean;
  Var
    qryEcf: TUniQuery;
    strPatIni: String;
    strCodEcf: String;
begin
  Result := True;
  strPatIni := fCfgSis('DIRINI');
  strCodEcf := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'IMPRESSORA'   , '', strPatIni + '/opcoes_fiscal.ini' );

  qryEcf := fCriaQuery;
  Try
    qryEcf.SQL.Add('SELECT ECF_DHGRSB FROM CADECF WHERE ECF_CODECF = :CODECF ');
    qryEcf.ParamByname('CODECF').AsString := strCodEcf;
    qryEcf.Open;

    strSWBasicoString := qryEcf.FieldByName('ECF_DHGRSB').AsString;
    If fEmptyStr(strSwBasicoString) Then
    Begin
      pCriarFormularios(TfrmDigDataHoraSWBasico, frmDigDataHoraSWBasico);
      frmDigDataHoraSWBasico.pProcedureLMF := pProcedureLMF;
      If frmDigDataHoraSWBasico.ShowModal = mrOk Then
      Begin
        strSWBasicoString := frmDigDataHoraSWBasico.edtDataHora.Text;
        pAtualizarDataHoraGravacaoSoftwareBasico(strCodEcf, strSWBasicoString);
      End
      Else
      Begin
        pMensagemOk('Atenção: não foi possível capturar a data e hora de gravação ' +
                    'do software básico do ECF e a configuração manual foi abortada.' + #13#10 +
                    'Não será possível usar o ECF.');
        Result := False;
      End;
      FreeAndNil(frmDigDataHoraSWBasico);
    End;
  Finally
    FreeAndNil(qryEcf);
  End;
end;

procedure TBematech.pAtualizarDataHoraGravacaoSoftwareBasico(strCodEcf,
  strData: String);
  Var
    qryUpd: TUniQuery;
begin
  qryUpd := fCriaQuery;
  qryUpd.SQL.Add('UPDATE CADECF SET ECF_DHGRSB = :DHGRSB WHERE ECF_CODECF = :CODECF ');
  qryUpd.ParamByName('DHGRSB').AsString := strData;
  qryUpd.ParamByName('CODECF').AsString := strCodEcf;
  qryUpd.ExecSQL;
  FreeAndNil(qryUpd);
end;

procedure TBematech.pAtualizarDataHoraGravSB_obj(strSWBasicoString: string);
begin
  If Pos('/', String(strSWBasico)) > 0 Then
  Begin
    FDataGravacaoSB := StrToDateDef(Copy(strSWBasicoString,1,10), 0);
    FHoraGravacaoSB := StrToTimeDef(Copy(strSWBasicoString,12,8), 0);
  End
  Else
  Begin
    FDataGravacaoSB := StrToDateDef(Copy(strSWBasicoString,1,2) + '/' + Copy(strSWBasicoString,4,2) + '/' + Copy(strSWBasicoString,7,4), 0);
    FHoraGravacaoSB := StrToTimeDef(Copy(strSWBasicoString,12,2) + ':' + Copy(strSWBasicoString,15,2) + ':' + Copy(strSWBasicoString,18,2), 0);
  End;
end;

procedure TBematech.pCarregaDataHoraGravSB;
  Var
    strSWBasicoString: String;
begin
  If (FDataGravacaoSB = 0) Then
  Begin
    SetLength(strDHUsuario, 20);
    SetLength(strSWBasico, 20);
    strMFAd := ' ';

    FCodErr := IntToStr(Bematech_FI_DataHoraGravacaoUsuarioSWBasicoMFAdicional(strDHUsuario, strSWBasico, strMFAd));
    If (Not fVerErro(False)) Then
    Begin
      If Not fCarregaDataHoraGravacaoSoftwareBasicoBanco(strSWBasicoString) Then
        Raise Exception.Create('Configuração de data e hora da gravação do software básico não foi concluída.')
      else
        pAtualizarDataHoraGravSB_obj(strSWBasicoString);
    End
    Else
    Begin
      strSWBasicoString := String(strSWBasico);
      pAtualizarDataHoraGravSB_obj(strSWBasicoString);
      if (FDataGravacaoSB <= 0) or (FHoraGravacaoSB <= 0) then
      begin
        if not fCarregaDataHoraGravacaoSoftwareBasicoBanco(strSWBasicoString) then
          Raise Exception.Create('Configuração de data e hora da gravação do software básico não foi concluída.')
        else
          pAtualizarDataHoraGravSB_obj(strSWBasicoString);
      end;
    End;

    If (FDataGravacaoSB <= 0) Or (FHoraGravacaoSB <= 0) Then
    Begin
      Raise Exception.Create('Erro ao capturar hora da gravação do software básico (2).');
    End;
  End;
end;

function TBematech.fFmtDecimalBemat: Integer;
  var intDec: Integer;
begin
  intDec := intDecUn;
  If intDec > 3 Then
    intDec := 3
  Else If intDec < 2 Then
    intDec := 2;
  Result := intDec;
end;

procedure TBematech.pFechaPortaImpressora;
begin
  inherited;

end;

function TBematech.fEspelhoMFDLocal(strTipoFiltro, strFiltroIni, strFiltroFin, strArquivoSaida: String): Boolean;
  Var
    mfdLocal: TBematechMFDLocal;
begin
  Result := False;
  mfdLocal := TBematechMFDLocal.Create(strTipoFiltro, strFiltroIni, strFiltroFin, strArquivoSaida);

  Try
    Try
      Result := mfdLocal.fEspelhoMFDLocal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TBematech.fEspelhoMFDLocal]');
      End;
    End;
  Finally
    FreeAndNil(mfdLocal);
  End;
end;

procedure TBematech.pPausaLeitura;
begin
  inherited;
  
end;

procedure TBematech.pProcedureLMF(Sender: TObject);
begin
  fLeituraMemoriaFiscal(False, 'C', '1', '1');
end;

end.

