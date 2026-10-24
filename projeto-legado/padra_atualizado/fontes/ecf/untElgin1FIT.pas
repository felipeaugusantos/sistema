unit untElgin1FIT;

interface

Uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StrUtils, Uni, untFiscal, untFuncoesGenerica, untTypesSistema;

function Elgin_AbrePortaSerial: Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_FechaPortaSerial: Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_AcionaGaveta:Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_LeituraX: Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_ReducaoZ( Data: AnsiString; Hora: AnsiString ): Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_AbreCupomMFD(CGC: AnsiString; Nome: AnsiString; Endereco : AnsiString): Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_CancelaCupomMFD(CGC, Nome, Endereco: AnsiString): Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_VendeItem( Codigo: AnsiString; Descricao: AnsiString; Aliquota: AnsiString; TipoQuantidade: AnsiString; Quantidade: AnsiString; CasasDecimais: Integer; ValorUnitario: AnsiString; TipoDesconto: AnsiString; Desconto: AnsiString): Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_VendeItemDepartamento( Codigo: AnsiString; Descricao: AnsiString; Aliquota: AnsiString; ValorUnitario: AnsiString; Quantidade: AnsiString; Acrescimo: AnsiString; Desconto: AnsiString; IndiceDepartamento: AnsiString; UnidadeMedida: AnsiString): Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_CancelaItemGenerico( NumeroItem: AnsiString ): Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_TerminaFechamentoCupom( Mensagem: AnsiString): Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_AcrescimoDescontoSubtotalMFD( cFlag, cTipo, cValor: AnsiString): integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_EfetuaFormaPagamento( FormaPagamento: AnsiString; ValorFormaPagamento: AnsiString ): Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_EfetuaFormaPagamentoDescricaoForma( FormaPagamento: AnsiString; ValorFormaPagamento: AnsiString; DescricaoFormaPagto: AnsiString ): integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_NumeroCupom( NumeroCupom: AnsiString ): Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_NumeroSerie( NumeroSerie: AnsiString ): Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_EspacoEntreLinhas( Dots: Integer ): Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_VerificaImpressoraLigada: Integer; StdCall; External 'Elgin.DLL' delayed;

function Elgin_LeituraMemoriaFiscalData(DataInicial, DataFinal, FlagLeitura : AnsiString): Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_LeituraMemoriaFiscalReducao(ReducaoInicial, ReducaoFinal, FlagLeitura : AnsiString): Integer; StdCall; External 'Elgin.DLL' delayed;

function Elgin_AbreComprovanteNaoFiscalVinculado( FormaPagamento: AnsiString; Valor: AnsiString; NumeroCupom: AnsiString ): Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_UsaComprovanteNaoFiscalVinculado( Texto: AnsiString ): Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_FechaComprovanteNaoFiscalVinculado: Integer; StdCall; External 'Elgin.DLL' delayed;

function Elgin_AbreRelatorioGerencial(): Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_RelatorioGerencial( Texto: AnsiString ): Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_FechaRelatorioGerencial: Integer; StdCall; External 'Elgin.DLL' delayed;

function Elgin_RetornoImpressora( var i:integer; ErrorMsg:AnsiString):integer;StdCall; External 'Elgin.DLL' delayed;

function Elgin_DownloadMFD(Arquivo: AnsiString; TipoDownload: AnsiString; ParametroInicial: AnsiString; ParametroFinal: AnsiString; UsuarioECF: AnsiString): Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_MarcaModeloTipoImpressoraMFD(Marca, Modelo, Tipo : AnsiString): Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_NumeroSubstituicoesProprietario( NumeroSubstituicoes: AnsiString ): Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_DataHoraImpressora( Data: AnsiString; Hora: AnsiString ): Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_UltimoItemVendido( NumeroItem: AnsiString ): Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_ContadorCupomFiscalMFD(CuponsEmitidos : AnsiString): Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_NumeroOperacoesNaoFiscais( NumeroOperacoes: AnsiString ): Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_ContadorRelatoriosGerenciaisMFD(Relatorios : AnsiString): Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_ContadorComprovantesCreditoMFD(Comprovantes : AnsiString): Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_DadosUltimaReducaoMFD(DadosReducao : AnsiString): Integer; StdCall; External 'Elgin.DLL' delayed;

function Elgin_VerificaTotalizadoresNaoFiscaisMFD(Totalizadores : AnsiString): Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_ValorTotalizadorNaoFiscalMFD( Totalizador: AnsiString; Valor: AnsiString ): Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_VendaBruta( VendaBruta: AnsiString ): Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_NumeroCaixa( NumeroCaixa: AnsiString ): Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_CNPJMFD(CNPJ : AnsiString): Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_InscricaoEstadualMFD(InscricaoEstadual : AnsiString): Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_DataHoraSoftwareBasico(DataSW, HoraSW: PAnsiChar ): Integer;stdcall; External 'Elgin.DLL' delayed;
function Elgin_VersaoFirmware( VersaoFirmware: AnsiString ): Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_GrandeTotal( GrandeTotal: AnsiString ): Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_Sangria( Valor: AnsiString ): Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_Suprimento( Valor: AnsiString; FormaPagamento: AnsiString ): Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_RelatorioSintegraMFD( iRelatorios: Integer;cArquivo: AnsiString; cMes: AnsiString; cAno: AnsiString; cRazaoSocial: AnsiString; cEndereco: AnsiString;cNumero: AnsiString; cComplemento: AnsiString; cBairro: AnsiString; cCidade: AnsiString; cCEP: AnsiString; cTelefone: AnsiString; cFax: AnsiString; cContato: AnsiString ): Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_LeParametrosPAF(CNPJ, Data, Hora, NumeroSerie, NumeroECF,GrandeTotal:AnsiString) :integer;stdcall; External 'Elgin.DLL' delayed;

function Elgin_LeMemoriasBinario(szNomeArquivo: AnsiString; szSerieECF: AnsiString; bArguardaConcluirLeitura: Boolean): Integer; stdcall; External 'Elgin.DLL' delayed;
function Elgin_GeraArquivoATO17Binario( szArquivoBinario, szArquivoTexto,szPeriodoIni, szPeriodoFIM:string;
  TipoPeriodo:char; szUsuario:string;szTipoLeitura:string):integer; stdcall; External 'Elgin.dll' delayed;
function Elgin_ConverteATO17ParaPAFRJ( arquivoATO17: AnsiString ): Integer; stdcall; External 'Elgin.dll' delayed;
Function Elgin_FormatoDadosMFD(ArquivoOrigem: AnsiString;
  ArquivoDestino: AnsiString;
  TipoFormato: AnsiString;
  TipoDownload: AnsiString;
  ParametroInicial: AnsiString;
  ParametroFinal: AnsiString;
  UsuarioECF: AnsiString): Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_DataMovimentoUltimaReducaoMFD( cDataMovimento: AnsiString ): Integer; StdCall; External 'Elgin.DLL' delayed;
function Elgin_FlagsFiscais( Var Flag: Integer ): Integer; StdCall; External 'Elgin.DLL' delayed;


Type
  TElgin1FIT = class(TFiscal)
  private
    FPais: TPais;
    FCodErr  : Integer;
    intDecUni: Integer;
    blnModoNovo: Boolean;
    strMensagem: String;
    strMarca: AnsiString;
    strModelo: AnsiString;
    strTipo: AnsiString;

    strCNPJ: AnsiString;
    strIE: AnsiString;

    strDataSB: AnsiString;
    strHoraSB: AnsiString;
    strVersaoSB: AnsiString;

    strMFAdicional: AnsiString;

    blnUltimoComandoErro: Boolean;

    fltVendaBruta: Double;
    function getSucesso: Boolean;
    function ObtemRetornoECF(var strMensagemErro: String): Boolean;
    function fDataUltimaReducao: TDateTime;

    procedure pCarregaMFDAdicional;
  protected
    function fRetornaObsFechamento: String; override;
  public
    strMensFechamento: AnsiString;

    property blnSucesso: Boolean Read getSucesso;

    function fVerErro(blnMostraErro: Boolean = True): Boolean; Override;

    function fLeituraX(strParam: String = 'N'; blnPergunta: Boolean = True): Boolean; Override;
    function fReducaoZ(strData, strHora: String): Boolean; Override;
    function fAbreGaveta: Boolean; Override;
    function fStatusImpressora: String; Override;
    function fAbreCupom: Boolean; Override;
    function fRegistraItem(strCodIte, strDesIte, strUnidad: String;
      fltAlqIcm, fltQtdIte, fltUnitar: Double; strCodFis: String; fltDesEsp: Double; fltTotal: Double = 0): Boolean; Overload; Override;
    function fRegistraItem(strCodIte, strDesIte, strUnidad,
      strAlqIcm: String; fltQtdIte, fltUnitar: Double; strCodFis: String; fltDesEsp: Double): Boolean; Overload; Override;

    function fCancelaItem(strItem: String): Boolean; Override;
    function fCancelaCupom: Boolean; Override;
    function fRegistraAcrDes(strAcrDes, strTip_AC, strVal_AC: String; fltTotal, fltTotImp: Double): Boolean; Override;
    function fRegistraModalidades(strCodMod, strDesMod: String; fltValMod: Double; strInfAdi: String): Boolean; Override;
    function fFechaCupom: Boolean; Override;
    function fRetornaCOO: String; Override;
    function fNumeroSerie: String; Override;
    function fCalcAliquota(strCodFiscal: String; fltAliquota: Double; intTipRet: Integer = 1): String; Override;
    function fAbreRelatorioGerencial(blnMostrarErro: Boolean = True): Boolean; Override;
    function fFechaRelatorioGerencial(blnVerErro: Boolean = True): Boolean; Override;
    function fRelatorioGerencial(strTexto: String): Boolean; Override;
    function fEspacoEntreLinhas(intEspacos: Integer): Boolean; Override;
    function fAbreCNFVinculado(strDesFormaPgto, strValor, strNumCupom: String; strQtdPar: String = ''): Boolean; Override;
    function fFechaCNFVinculado(blnVerErro: Boolean = True): Boolean; Override;
    function fUsaCNFVinculado(strTexto: String): Boolean; Override;
    function fImpLinFiscal(strAtrib, strLinha: String): Boolean; Override;
    function fAbrePortaImpressora: Boolean; Override;
    function fexecutaCMD(strCmd: String; blnRetorna: Boolean = False): String; Override;

    {***********************************}
    {* ESTA FUNÇÃO JÁ EXISTIA ANTES DO *}
    {* PAF.                            *}
    {********************************MV*}
    function fLeituraMemFiscal(strParIni, strParFin: String; intTipLei: Integer;
      strFlagCompleta: String = 'c'): Boolean;
    function fRetMensErro: String;

    function fLeituraMemoriaFiscal(blnCompleta: Boolean; strTipoFiltro, strFiltroIni, strFiltroFin: String): Boolean; Override;
    function fEspelhoMFD(strTipoFiltro, strFiltroIni, strFiltroFin, strArquivoSaida: String): Boolean; Override;
    function fArquivoMFD(strDataIni, strDataFin, strArquivoSaida, strRazSocEmp, strEndereEmp: String): Boolean; Override;

    function fModeloEcf: String; Override;
    function fNumeroUsuario: String; Override;
    function fNumeroCCF: String; Override;
    function fDataEcf: TDateTime; Override;
    function fHoraEcf: TDateTime; Override;
    function fUltimoItemVendido: String; Override;
    function fNumeroGNF: String; Override;
    function fNumeroGRG: String; Override;
    function fNumeroCDC: String; Override;
    function fDadosUltimaReducao(Var drzDadosReducao: TDadosReducao): Boolean; Override;
    function fVendaBruta: Double; Override;
    function fNumeroCaixa: String; Override;
    function fNumeroCNPJUsuario: String; Override;
    function fNumeroIEUsuario: String; Override;
    function fVersaoSoftwareBasico: String; Override;
    function fDataGravacaoSoftwareBasico: TDateTime; Override;
    function fHoraGravacaoSoftwareBasico: TDateTime; Override;
    function fTipoECF: String; Override;
    function fMarcaECF: String; Override;
    function fGrandeTotal: Double; Override;
    function fMFDAdicional: String; Override;

    function fSangria(fltValor: Double): Boolean; Override;
    function fSuprimento(fltValor: Double; strModalidade: String='Dinheiro'): Boolean; Override;

    function fGerarSintegra(blnApenas75: Boolean; strArquivo, strMes, strAno,
      strRazSoc, strEndere, strNumEnd, strComple, strBairro, strCidade,
      strNumCep, strFone01, strNumFax, strContat: String): Boolean; Override;

    function fUltimoComandoComErro: Boolean; override;

    procedure pFechaPortaImpressora; Override;
    procedure pPausaLeitura; Override;
    function fVerificaCupomAberto: Boolean; Override;

    Constructor Create(Owner: TComponent; blnModoNovo: Boolean = True); Reintroduce;
    Destructor Destroy; override;
  End;

implementation

uses untFuncoesSimples, untConstantes, untFuncoes, Data.DB, untConstantesNFe;

{ TElgin1FIT }

constructor TElgin1FIT.Create(Owner: TComponent; blnModoNovo: Boolean = True);
begin
  FPais := fSetaPais;
  Self.blnModoNovo := blnModoNovo;
  FCodErr := Elgin_AbrePortaSerial;
  If (fVerErro(Self.blnModoNovo)) Then
  Begin
    intDecUni := fCfgSis('DECUNI', varInteger);
    If intDecUni > 3 Then
      intDecUni := 3
    Else If intDecUni < 2 Then
      intDecUni := 2;

    strDataSB := AnsiString(StringOfChar(#0, 6));
    strHoraSB := AnsiString(StringOfChar(#0, 6));
    Elgin_DataHoraSoftwareBasico(PAnsiChar(strDataSB), PAnsiChar(strHoraSB));

    strMarca := AnsiString(StringOfChar(#0, 15));
    strModelo := AnsiString(StringOfChar(#0, 20));
    strTipo := AnsiString(StringOfChar(#0, 7));
    Elgin_MarcaModeloTipoImpressoraMFD(AnsiString(strMarca), AnsiString(strModelo), AnsiString(strTipo));

    strCNPJ := AnsiString(StringOfChar(#0, 20));
    strIE := AnsiString(StringOfChar(#0, 15));
    Elgin_CNPJMFD(AnsiString(strCNPJ));
    Elgin_InscricaoEstadualMFD(AnsiString(strIE));

    strVersaoSB := AnsiString(StringOfChar(#0, 8));
    Elgin_VersaoFirmware(AnsiString(strVersaoSB));

    strDataSB := Copy(strDataSB, 1, 2) + '/' + Copy(strDataSB, 3, 2) + '/' + Copy(strDataSB, 5, 2);
    strHoraSB := Copy(strHoraSB, 1, 2) + ':' + Copy(strHoraSB, 3, 2) + ':' + Copy(strHoraSB, 5, 2);

    strMarca := AnsiString(Trim(String(strMarca)));
    strModelo := AnsiString(Trim(String(strModelo)));
    strTipo := AnsiString(Trim(String(strTipo)));
    strCNPJ := AnsiString(Trim(String(strCNPJ)));
    strIE := AnsiString(Trim(String(strIE)));
    strDataSB := AnsiString(Trim(String(strDataSB)));
    strHoraSB := AnsiString(Trim(String(strHoraSB)));
    strVersaoSB := AnsiString(Trim(String(strVersaoSB)));

    pCarregaMFDAdicional;

    fltVendaBruta := 0;

  End
  Else
    Raise Exception.Create('Atenção: não foi possível conectar-se à impressora. Favor tentar novamente.');
    
  strMensFechamento := '';
end;

destructor TElgin1FIT.Destroy;
begin
  Elgin_FechaPortaSerial;
  inherited;
end;

function TElgin1FIT.fAbreCNFVinculado(strDesFormaPgto, strValor,
  strNumCupom: String; strQtdPar: String = ''): Boolean;
begin
  FCodErr := Elgin_AbreComprovanteNaoFiscalVinculado(AnsiString(strDesFormaPgto), AnsiString(strValor), '');
  Result  := fVerErro(blnModoNovo);
end;

function TElgin1FIT.fAbreCupom: Boolean;
begin
  FCodErr := Elgin_AbreCupomMFD(AnsiString(strCpfClie), AnsiString(strNomCli), AnsiString(strEndCli));
  Result  := fVerErro(blnModoNovo);
end;

function TElgin1FIT.fAbreGaveta: Boolean;
begin
  FCodErr := Elgin_AcionaGaveta;
  Result := fVerErro(blnModoNovo);
end;

function TElgin1FIT.fAbrePortaImpressora: Boolean;
begin
  Result := True;
end;

function TElgin1FIT.fAbreRelatorioGerencial(blnMostrarErro: Boolean): Boolean;
begin
  Elgin_AbreRelatorioGerencial;
  Result := fVerErro(blnModoNovo);
end;

function TElgin1FIT.fArquivoMFD(strDataIni, strDataFin, strArquivoSaida,
  strRazSocEmp, strEndereEmp: String): Boolean;
  Var
    strNomeArqPafRj: String;
begin

//  strDataIni := FormatDateTime('aaaammdd', StrToDate(strDataIni));
//  strDataFin := FormatDateTime('aaaammdd', StrToDate(strDataFin));
  strNomeArqPafRj := ExtractFilePath(strArquivoSaida) + '\PAF-RJ_' + ExtractFileName(strArquivoSaida);

  If (Elgin_LeMemoriasBinario('PAF\MEMORIAS_BINARIO.BIN', AnsiString(fNumeroSerie), True) = 1) Then
  Begin
    If (Elgin_GeraArquivoATO17Binario('PAF\MEMORIAS_BINARIO.BIN', strArquivoSaida,
      strDataIni, strDataFin, 'D', fNumeroUsuario, 'MFD') = 1) Then
    Begin
      Elgin_ConverteATO17ParaPAFRJ(AnsiString(strArquivoSaida));
      Result := fVerErro(blnModoNovo);

      If Result Then
      Begin
        DeleteFile(strArquivoSaida);
        fRenomearArquivo(strNomeArqPafRj, strArquivoSaida);
      End;

    End
    Else
    Begin
      Result := fVerErro(blnModoNovo);
    End;
  End
  Else
  Begin
    Result := fVerErro(blnModoNovo);
  End;
end;

function TElgin1FIT.fCalcAliquota(strCodFiscal: String; fltAliquota: Double;
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
Begin

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

  {*****************************************}
  {* ISENTO                                *}
  {**************************************RL*}
  If Pos( strCodFiscal, CST_ISENTO ) > 0 Then
    strAliquota := 'I'

  {*****************************************}
  {* NÃO TRIBUTADO                         *}
  {**************************************AF*}
  Else If Pos( strCodFiscal, CST_NAO_TRIBUTADO ) > 0 Then
    strAliquota := 'N'

  {*****************************************}
  {* SUBSTITUICAO                          *}
  {**************************************RL*}
  Else If Pos( strCodFiscal, CST_SUBSTITUICAO + CST_ANTECIPACAO_ICMS ) > 0 Then
    strAliquota := 'F'

  {*****************************************}
  {* SERVICOS                              *}
  {**************************************RL*}
  Else If Pos( strCodFiscal, '_SSS_' ) > 0 Then
    strAliquota := 'S'

  {*****************************************}
  {* TRIBUTADO                             *}
  {**************************************RL*}
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

  {*****************************************}
  {* SE O TIPO DE RETORNO É 1              *}
  {* PROCURA INDICE                        *}
  {**************************************MA*}
  If ( intTipRet = 1 ) Then
  Begin

    {*****************************************}
    {* VERIFICA ALIQUOTA COM CADASTRO DE     *}
    {* IMPRESSORAS FISCAIS                   *}
    {**************************************MA*}
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

function TElgin1FIT.fCancelaCupom: Boolean;
begin
  FCodErr := Elgin_CancelaCupomMFD(AnsiString(strCpfClie), AnsiString(strNomCli), AnsiString(strEndCli));
  Result  := fVerErro(blnModoNovo);
end;

function TElgin1FIT.fCancelaItem(strItem: String): Boolean;
begin
  FCodErr := Elgin_CancelaItemGenerico(AnsiString(strItem));
  Result  := fVerErro(blnModoNovo);
end;

function TElgin1FIT.fDadosUltimaReducao(
  var drzDadosReducao: TDadosReducao): Boolean;
  Var
    strDados: String;
    strTotTri: String;
    strAlqTri: String;
    strAliquotas: String;
    intIndAlq: Integer;
    intIndVal: Integer;

    fltValor: Double;
    intContador: Integer;
    intTamMat: Integer;

    fltTotOpnf: Double;
    strTotNaoFis: AnsiString;
    strDesNaoFis: String;
    strValNaoFis: AnsiString;

    strData: String;
begin
  SetLength(strDados, 1278);
  strTotNaoFis := AnsiString(StringOfChar(#0, 299));
  If Elgin_DadosUltimaReducaoMFD(AnsiString(strDados)) = 1 Then
  Begin

    strData := fGetValorLinha(strDados, ',', 37);
    strData := Copy(strData,1,2) + '/' + Copy(strData,3,2) + '/' + Copy(strData,5,2);

    drzDadosReducao.strNumCrz := fGetValorLinha(strDados, ',', 3);
    drzDadosReducao.strNumCOORZ := fGetValorLinha(strDados, ',', 4);
    drzDadosReducao.strNumCRO := fGetValorLinha(strDados, ',', 2);
    drzDadosReducao.dtaDtaMov := StrToDate(strData);

    fltTotOpnf := 0;
    {****************************************}
    {* CAPTURA OS TOTALIZADORES NÃO FISCAIS *}
    {*************************************MV*}
    If Elgin_VerificaTotalizadoresNaoFiscaisMFD(AnsiString(strTotNaoFis)) = 1 Then
    Begin

      For intContador := 1 To 14 Do
      Begin
        strValNaoFis := AnsiString(StringOfChar(#0, 14));
        strDesNaoFis := Trim(fGetValorLinha(String(strTotNaoFis), ',', intContador));
        Elgin_ValorTotalizadorNaoFiscalMFD(AnsiString(strDesNaoFis), AnsiString(strValNaoFis));
        fltTotOpnf := fltTotOpnf + (fStrToFloat(String(strValNaoFis)) / 100);
      End;

    End;

    strTotTri := fGetValorLinha(strDados, ',', 17);
    strAliquotas := fGetValorLinha(strDados, ',', 36);

    intIndAlq := 1;
    intIndVal := 1;

    For intContador := 1 To 16 Do
    Begin
      strAlqTri := Copy(strAliquotas, intIndAlq, 4);
      fltValor  := fStrToFloat(Copy(strTotTri, intIndVal, 14)) / 100;

      If (Not fEmptyStr(strAlqTri)) And (strAlqTri <> '0000') Then
      Begin
        intTamMat := Length(drzDadosReducao.arrTotali);
        SetLength(drzDadosReducao.arrTotali, intTamMat+1);
        drzDadosReducao.arrTotali[intTamMat].strCodTot := fStrZero(intContador-1, 2) + 'T' + strAlqTri;
        drzDadosReducao.arrTotali[intTamMat].fltValAcu := fltValor;
      End;

      Inc(intIndAlq, 4);
      Inc(intIndVal, 14);
    End;

    intTamMat := Length(drzDadosReducao.arrTotali);
    SetLength(drzDadosReducao.arrTotali, intTamMat+13);

    drzDadosReducao.arrTotali[intTamMat].strCodTot := 'F1';
    drzDadosReducao.arrTotali[intTamMat].fltValAcu := fStrToFloat(fGetValorLinha(strDados, ',', 20)) / 100;
    Inc(intTamMat);

    drzDadosReducao.arrTotali[intTamMat].strCodTot := 'I1';
    drzDadosReducao.arrTotali[intTamMat].fltValAcu := fStrToFloat(fGetValorLinha(strDados, ',', 18)) / 100;
    Inc(intTamMat);

    drzDadosReducao.arrTotali[intTamMat].strCodTot := 'N1';
    drzDadosReducao.arrTotali[intTamMat].fltValAcu := fStrToFloat(fGetValorLinha(strDados, ',', 19)) / 100;
    Inc(intTamMat);

    drzDadosReducao.arrTotali[intTamMat].strCodTot := 'FS1';
    drzDadosReducao.arrTotali[intTamMat].fltValAcu := fStrToFloat(fGetValorLinha(strDados, ',', 23)) / 100;
    Inc(intTamMat);

    drzDadosReducao.arrTotali[intTamMat].strCodTot := 'Is1';
    drzDadosReducao.arrTotali[intTamMat].fltValAcu := fStrToFloat(fGetValorLinha(strDados, ',', 21)) / 100;
    Inc(intTamMat);

    drzDadosReducao.arrTotali[intTamMat].strCodTot := 'NS1';
    drzDadosReducao.arrTotali[intTamMat].fltValAcu := fStrToFloat(fGetValorLinha(strDados, ',', 22)) / 100;
    Inc(intTamMat);

    drzDadosReducao.arrTotali[intTamMat].strCodTot := 'OPNF';
    drzDadosReducao.arrTotali[intTamMat].fltValAcu := fltTotOpnf / 100;
    Inc(intTamMat);

    drzDadosReducao.arrTotali[intTamMat].strCodTot := 'DT';
    drzDadosReducao.arrTotali[intTamMat].fltValAcu := fStrToFloat(fGetValorLinha(strDados, ',', 24)) / 100;
    Inc(intTamMat);

    drzDadosReducao.arrTotali[intTamMat].strCodTot := 'DS';
    drzDadosReducao.arrTotali[intTamMat].fltValAcu := fStrToFloat(fGetValorLinha(strDados, ',', 25)) / 100;
    Inc(intTamMat);

    drzDadosReducao.arrTotali[intTamMat].strCodTot := 'AT';
    drzDadosReducao.arrTotali[intTamMat].fltValAcu := fStrToFloat(fGetValorLinha(strDados, ',', 26)) / 100;
    Inc(intTamMat);

    drzDadosReducao.arrTotali[intTamMat].strCodTot := 'AS';
    drzDadosReducao.arrTotali[intTamMat].fltValAcu := fStrToFloat(fGetValorLinha(strDados, ',', 27)) / 100;
    Inc(intTamMat);

    drzDadosReducao.arrTotali[intTamMat].strCodTot := 'Can-T';
    drzDadosReducao.arrTotali[intTamMat].fltValAcu := fStrToFloat(fGetValorLinha(strDados, ',', 28)) / 100;
    Inc(intTamMat);

    drzDadosReducao.arrTotali[intTamMat].strCodTot := 'Can-S';
    drzDadosReducao.arrTotali[intTamMat].fltValAcu := fStrToFloat(fGetValorLinha(strDados, ',', 29)) / 100;

    Result := True;
  End
  Else
  Begin
    Result := fVerErro(blnModoNovo);
  End;
end;

function TElgin1FIT.fDataEcf: TDateTime;
  Var
    strData: AnsiString;
    strHora: AnsiString;
begin
  strData := AnsiString(StringOfChar(#0, 6));
  strHora := AnsiString(StringOfChar(#0, 6));
  Elgin_DataHoraImpressora(AnsiString(strData), AnsiString(strHora));
  strData := Copy(strData, 1, 2) + '/' + Copy(strData, 3, 2) + '/' + Copy(strData, 5, 2);
  Result := StrToDate(String(strData));
end;

function TElgin1FIT.fDataGravacaoSoftwareBasico: TDateTime;
begin
  Result := StrToDate(String(strDataSB));
end;

function TElgin1FIT.fDataUltimaReducao: TDateTime;
  Var
    strData: AnsiString;
begin
  strData := AnsiString(StringOfChar(#0, 6));
  Elgin_DataMovimentoUltimaReducaoMFD(AnsiString(strData));
  strData := Copy(strData, 1,2) + '/' + Copy(strData, 3,2) + '/' + Copy(strData, 5,2);
  Result := StrToDate(String(strData));
end;

function TElgin1FIT.fEspacoEntreLinhas(intEspacos: Integer): Boolean;
begin
  FCodErr := Elgin_EspacoEntreLinhas(intEspacos);
  Result  := fVerErro(blnModoNovo);
end;

function TElgin1FIT.fEspelhoMFD(strTipoFiltro, strFiltroIni, strFiltroFin,
  strArquivoSaida: String): Boolean;
  Var
    strTipo: String;
    strUsuario: String;
begin
  If strTipoFiltro = 'C' Then
  Begin
    strTipo := '2';
    strUsuario := fNumeroUsuario;
  End
  Else
  Begin
    strTipo := '1';
    strUsuario := '';
  End;

  If (Elgin_DownloadMFD('DownloadElgin.Mfd', AnsiString(strTipo), AnsiString(strFiltroIni), AnsiString(strFiltroFin), AnsiString(strUsuario)) = 1) Then
  Begin
    Elgin_FormatoDadosMFD('DownloadElgin.Mfd', AnsiString(strArquivoSaida), '0', AnsiString(strTipo), AnsiString(strFiltroIni), AnsiString(strFiltroFin), AnsiString(strUsuario));
    Result := fVerErro(blnModoNovo);
  End
  Else
    Result  := fVerErro(blnModoNovo);
end;

function TElgin1FIT.fexecutaCMD(strCmd: String;
  blnRetorna: Boolean): String;
begin
  Result := '';
end;

function TElgin1FIT.fFechaCNFVinculado(blnVerErro: Boolean = True): Boolean;
begin
  FCodErr := Elgin_FechaComprovanteNaoFiscalVinculado;
  If (blnModoNovo) Then
    Result := fVerErro(blnModoNovo)
  Else
    Result := fVerErro(blnVerErro);
end;

function TElgin1FIT.fFechaCupom: Boolean;
  Var
    strMens: AnsiString;
begin
  If fEmptyStr(String(strMensFechamento)) Then
    strMens := AnsiString(fRetornaObsFechamento)
  Else
    strMens := AnsiString(strMensFechamento);

  FCodErr := Elgin_TerminaFechamentoCupom(AnsiString(strMens));
  Result  := fVerErro(blnModoNovo);

  strMensFechamento := '';
end;

function TElgin1FIT.fFechaRelatorioGerencial(blnVerErro: Boolean = True): Boolean;
begin
  FCodErr := Elgin_FechaRelatorioGerencial;
  Result  := fVerErro(blnModoNovo);
end;

function TElgin1FIT.fGerarSintegra(blnApenas75: Boolean; strArquivo, strMes,
  strAno, strRazSoc, strEndere, strNumEnd, strComple, strBairro, strCidade,
  strNumCep, strFone01, strNumFax, strContat: String): Boolean;
begin
  Elgin_RelatorioSintegraMFD(28, AnsiString(strArquivo), AnsiString(strMes), AnsiString(strAno), AnsiString(strRazSoc),
    AnsiString(strEndere), AnsiString(strNumEnd), AnsiString(strComple), AnsiString(strBairro), AnsiString(strCidade), AnsiString(strNumCep),
    AnsiString(strFone01), AnsiString(strNumFax), AnsiString(strContat));
  Result := fVerErro(blnModoNovo);
end;

function TElgin1FIT.fGrandeTotal: Double;
  Var
    strValor: AnsiString;
begin
  strValor := '';
  strValor := AnsiString(StringOfChar(#0, 18));
  Elgin_GrandeTotal(AnsiString(strValor));
  Result := fStrToFloat(String(strValor)) / 100;
end;

function TElgin1FIT.fHoraEcf: TDateTime;
  Var
    strData: AnsiString;
    strHora: AnsiString;
begin
  strData := AnsiString(StringOfChar(#0, 6));
  strHora := AnsiString(StringOfChar(#0, 6));
  Elgin_DataHoraImpressora(AnsiString(strData), AnsiString(strHora));
  strHora := Copy(strHora, 1, 2) + ':' + Copy(strHora, 3, 2) + ':' + Copy(strHora, 5, 2);

  Result := StrToTime(String(strHora));
end;

function TElgin1FIT.fHoraGravacaoSoftwareBasico: TDateTime;
begin
  Result := StrToTime(String(strHoraSB));
end;

function TElgin1FIT.fImpLinFiscal(strAtrib, strLinha: String): Boolean;
begin
  Result := True;
end;

function TElgin1FIT.fLeituraMemFiscal(strParIni, strParFin: String;
  intTipLei: Integer; strFlagCompleta: String = 'c'): Boolean;
begin
  If intTipLei = 1 Then
  Begin
    strParIni := FormatDateTime('dd/mm/yyyy', StrToDate(strParIni));
    strParFin := FormatDateTime('dd/mm/yyyy', StrToDate(strParFin));

    FCodErr := Elgin_LeituraMemoriaFiscalData(AnsiString(strParIni), AnsiString(strParFin), AnsiString(strFlagCompleta));
  End
  Else
  Begin
    FCodErr := Elgin_LeituraMemoriaFiscalReducao(AnsiString(strParIni), AnsiString(strParFin), AnsiString(strFlagCompleta));
  End;

  Result := fVerErro(blnModoNovo);
end;

function TElgin1FIT.fLeituraMemoriaFiscal(blnCompleta: Boolean; strTipoFiltro,
  strFiltroIni, strFiltroFin: String): Boolean;
begin
  Result := fLeituraMemFiscal(strFiltroIni, strFiltroFin,
    IIF(strTipoFiltro='D', 1, 2), IIF(blnCompleta,'c', 's'));
end;

function TElgin1FIT.fLeituraX(strParam: String;
  blnPergunta: Boolean): Boolean;
begin
  FCodErr := Elgin_LeituraX;
  Result  := fVerErro(blnModoNovo);
end;

function TElgin1FIT.fMarcaECF: String;
begin
  Result := String(strMarca);
end;

function TElgin1FIT.fMFDAdicional: String;
begin
  Result := String(strMFAdicional);
end;

function TElgin1FIT.fModeloEcf: String;
begin
  Result := String(strModelo);
end;

function TElgin1FIT.fNumeroCaixa: String;
  Var
    strTmp: AnsiString;
begin
  strTmp := AnsiString(StringOfChar(#0, 4));
  Elgin_NumeroCaixa(AnsiString(strTmp));
  Result := fStrZero(Trim(String(strTmp)), 4);
end;

function TElgin1FIT.fNumeroCCF: String;
  Var
    strTmp : AnsiString;
begin
  strTmp := AnsiString(StringOfChar(#0, 6));
  Elgin_ContadorCupomFiscalMFD(AnsiString(strTmp));
  Result := fStrZero(Trim(String(strTmp)), 6);
end;

function TElgin1FIT.fNumeroCDC: String;
  Var
    strTmp : AnsiString;
begin
  strTmp := AnsiString(StringOfChar(#0, 4));
  Elgin_ContadorComprovantesCreditoMFD(AnsiString(strTmp));
  Result := fStrZero(Trim(String(strTmp)), 4);
end;

function TElgin1FIT.fNumeroCNPJUsuario: String;
begin
  Result := String(strCNPJ);
end;

function TElgin1FIT.fNumeroGNF: String;
  Var
    strTmp : AnsiString;
begin
  strTmp := AnsiString(StringOfChar(#0, 6));
  Elgin_NumeroOperacoesNaoFiscais(AnsiString(strTmp));
  Result := fStrZero(Trim(String(strTmp)), 6);
end;

function TElgin1FIT.fNumeroGRG: String;
  Var
    strTmp : AnsiString;
begin
  strTmp := AnsiString(StringOfChar(#0, 6));
  Elgin_ContadorRelatoriosGerenciaisMFD(AnsiString(strTmp));
  Result := fStrZero(Trim(String(strTmp)), 6);
end;

function TElgin1FIT.fNumeroIEUsuario: String;
begin
  Result := String(strIE);
end;

function TElgin1FIT.fNumeroSerie: String;
  Var
    strTmp : AnsiString;
begin
  strTmp := AnsiString(StringOfChar(#0, 20));
  Elgin_NumeroSerie(AnsiString(strTmp));
  Result := Trim(String(strTmp));
end;

function TElgin1FIT.fNumeroUsuario: String;
  Var
    strTmp : AnsiString;
begin
  strTmp := AnsiString(StringOfChar(#0, 4));
  Elgin_NumeroSubstituicoesProprietario(AnsiString(strTmp));
  Result := fStrZero(RightStr(String(strTmp), 2), 2);
end;

function TElgin1FIT.fReducaoZ(strData, strHora: String): Boolean;
  Var
    strDataTmp, strHoraTmp: AnsiString;
begin
  strDataTmp := AnsiString(strData);
  strHoraTmp := AnsiString(strHora);

  fltVendaBruta := fVendaBruta;

  FCodErr := Elgin_ReducaoZ(AnsiString(strDataTmp), AnsiString(strHoraTmp));
  Result  := fVerErro(blnModoNovo);
end;

function TElgin1FIT.fRegistraAcrDes(strAcrDes, strTip_AC,
  strVal_AC: String; fltTotal, fltTotImp: Double): Boolean;
  Var
    fltValDes: Double;
    strVal_ACTmp: AnsiString;
    strTip_ACTmp: AnsiString;
begin
   fltValDes := 0.0;
   strVal_ACTmp := AnsiString(strVal_AC);
   strTip_ACTmp := AnsiString(strTip_AC);

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

  If (strTip_ACTmp = '%') Then
  Begin
    strVal_ACTmp := AnsiString(FloatToStr(fltValDes));
    strVal_ACTmp := AnsiString(FloatToStrF(fStrToFloat(String(strVal_ACTmp)), ffFixed, 12, 2));
    strVal_ACTmp := AnsiString(AnsiReplaceStr(String(strVal_ACTmp), ',', ''));
    strVal_ACTmp := RightStr(strVal_ACTmp, 4);
  End
  Else
  Begin
    strVal_ACTmp := AnsiString(FloatToStrF( fltValDes, ffNumber, 14, 2 ));
    strVal_ACTmp := AnsiString(AnsiReplaceStr( String(strVal_ACTmp), '.', '' ));
    //strVal_AC := AnsiReplaceStr( strVal_AC, ',', '' );
    strVal_ACTmp := AnsiString(fPadL(String(strVal_ACTmp), 14, '0'));
  End;

  sleep(1000);
  Elgin_AcrescimoDescontoSubtotalMFD(AnsiString(strAcrDes), AnsiString(strTip_ACTmp), AnsiString(strVal_ACTmp));
  Result := fVerErro(blnModoNovo);
end;

function TElgin1FIT.fRegistraItem(strCodIte, strDesIte, strUnidad: String;
  fltAlqIcm, fltQtdIte, fltUnitar: Double; strCodFis: String; fltDesEsp: Double; fltTotal: Double = 0): Boolean;
  Var
    strAlqIcm: String;
    strQtdIte: String;
    strUnitar: String;
    strDesEsp: String;
    strAcresc: String;
    sepAnt: Char;
begin

  sepAnt := FormatSettings.DecimalSeparator;
  FormatSettings.DecimalSeparator := ',';

  strDesIte := AnsiReplaceText(strDesIte, '"', '');
  strDesIte := AnsiReplaceText(strDesIte, #39, '');
  strDesIte := AnsiReplaceText(strDesIte, #34, '');
  strDesIte := AnsiReplaceStr(strDesIte, #34, '');
  strDesIte := AnsiReplaceStr(strDesIte, '"', '');

  If Not fEmptyStr(strCodFis) Then
    strAlqIcm := fCalcAliquota(strCodFis, fltAlqIcm, 1);
    
  strQtdIte := AnsiReplaceStr(FloatToStrF(fltQtdIte, ffFixed, 12, 3), '.', '');
  strUnitar := FloatToStrF(fltUnitar, ffFixed, 12, intDecUni);

  pCalculaAcrDesItem(Self, fStrToFloat(strQtdIte), fStrToFloat(strUnitar),
    fltQtdIte, fltUnitar, fltDesEsp, fltUltDesEspIte, fltUltAcrescIte);

  strDesEsp := FloatToStrF(fltUltDesEspIte, ffFixed, 5, 2);
  strAcresc := FloatToStrF(fltUltAcrescIte, ffFixed, 5, 2);

  FCodErr := Elgin_VendeItemDepartamento(AnsiString(strCodIte), AnsiString(strDesIte), AnsiString(strAlqIcm), AnsiString(strUnitar),
    AnsiString(strQtdIte), AnsiString(strAcresc), AnsiString(strDesEsp), '00', AnsiString(strUnidad));

  Result := fVerErro(blnModoNovo);

  If fIsNumber(strAlqIcm) Then
    strUltIndiceTri := strAlqIcm
  Else
    strUltIndiceTri := LeftStr(strAlqIcm, 1);

  FormatSettings.DecimalSeparator := sepAnt;
end;

function TElgin1FIT.fRegistraModalidades(strCodMod, strDesMod: String;
  fltValMod: Double; strInfAdi: String): Boolean;
  Var
    strValMod   : AnsiString;
    strCodModTmp: AnsiString;
    strInfAdiTmp: AnsiString;
begin
  strCodModTmp := AnsiString(strCodMod);
  strInfAdiTmp := AnsiString(strInfAdi);
  strValMod    := AnsiString(FloatToStrF(fltValMod, ffFixed, 12, 2));

  FCodErr   := Elgin_EfetuaFormaPagamentoDescricaoForma(AnsiString(strCodModTmp), AnsiString(strValMod), AnsiString(strInfAdiTmp));
  Result    := fVerErro(blnModoNovo);
end;

function TElgin1FIT.fRelatorioGerencial(strTexto: String): Boolean;
begin
  FCodErr := Elgin_RelatorioGerencial(AnsiString(strTexto));
  Result  := fVerErro(blnModoNovo);
end;

function TElgin1FIT.fRetMensErro: String;
begin
  Result := strMensagem;  
end;

function TElgin1FIT.fRetornaCoo: String;
  Var
    strTmp : AnsiString;
begin
  strTmp := AnsiString(StringOfChar(#0, 6));
  Elgin_NumeroCupom(AnsiString(strTmp));
  Result := String(strTmp);
end;

function TElgin1FIT.fRetornaObsFechamento: String;
	Var
  	strMens  :  AnsiString;
    strLinha01: AnsiString;
    strLinha02: AnsiString;
    strLinha03: AnsiString;
    strLinha04: AnsiString;
    strLinha05: AnsiString;
    strLinha06: AnsiString;
    strLinha07: AnsiString;
    strLinha08: AnsiString;
    strMinLeg,
    strCupMan,
    strImpPag: Ansistring;
    blnImpPag: Boolean;    
    intQtdNps: Integer;

    procedure pSetaLinha(strValor: String);
    begin

      If fEmptyStr(String(strLinha01)) Then
        strLinha01 := AnsiString(strValor)
      Else If fEmptyStr(String(strLinha02)) Then
        strLinha02 := AnsiString(strValor)
      Else If fEmptyStr(String(strLinha03)) Then
        strLinha03 := AnsiString(strValor)
      Else If fEmptyStr(String(strLinha04)) Then
        strLinha04 := AnsiString(strValor)
      Else If fEmptyStr(String(strLinha05)) Then
        strLinha05 := AnsiString(strValor)
      Else If fEmptyStr(String(strLinha06)) Then
        strLinha06 := AnsiString(strValor)
      Else If fEmptyStr(String(strLinha07)) Then
        strLinha07 := AnsiString(strValor)
      Else If fEmptyStr(String(strLinha08)) Then
        strLinha08 := AnsiString(strValor);

    end;
begin
  strCupMan := '';
  strMinLeg := '';

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

  strLinha01 := '';
  strLinha02 := '';
  strLinha03 := '';
  strLinha04 := '';
  strLinha05 := '';
  strLinha06 := '';
  strLinha07 := '';
  strLinha08 := '';

  If (VS_strUsaPaf = 'S') And Not fEmptyStr(strMenPaf01) Then
    pSetaLinha(fPadR(strMenPaf01, 48));

  If (VS_strUsaPaf = 'S') And Not fEmptyStr(strMenPaf02) Then
    pSetaLinha(fPadR(strMenPaf02, 48));

  blnImpPag := ((fltImpPag <> 0.00) And (fltPeImPg <> 0.00)) Or
               ((fltFedImp <> 0.00) And (fltPeImFd <> 0.00)) Or
               ((fltEstImp <> 0.00) And (fltPeImEs <> 0.00)) Or
               ((fltMunImp <> 0.00) And (fltPeImMn <> 0.00));

  If blnImpPag Then
  Begin
    If Not fUsaImpostoFonteIBPT Then
    Begin
      If fltImpPag < 1000 Then
        pSetaLinha(fPadR(strMsgArreTribu48 + FormatFloat('#,##0.00', fltImpPag) +
                         '(' + FormatFloat('#,##0.00', fltPeImPg) + '%)', 48))
      Else
        pSetaLinha(fPadR(strMsgArreTribuRedz48 + FormatFloat('#,##0.00', fltImpPag) +
                         '(' + FormatFloat('#,##0.00', fltPeImPg) + '%)', 48));
    End
    Else
    Begin
      strImpPag := '';
      strImpPag := AnsiString(strImpPag) + AnsiString(VAL_APR_IBPT);

      If (fltFedImp <> 0.00) Then
        strImpPag := AnsiString(strImpPag) + AnsiString(FormatFloat('#,##0.00', fltFedImp)) + AnsiString(FEDERAL);

      If (fltEstImp <> 0.00) Then
        strImpPag := AnsiString(strImpPag) + '/' + AnsiString(FormatFloat('#,##0.00', fltEstImp)) + AnsiString(ESTADUAL);

      If (fltMunImp <> 0.00) Then
        strImpPag := AnsiString(strImpPag) + '/' + AnsiString(FormatFloat('#,##0.00', fltMunImp)) + AnsiString(MUNICIPAL);

      strImpPag := strImpPag + AnsiString(FONTE_IBPT);
      strImpPag := AnsiString(Copy(fPadR(String(strImpPag), 48), 1, 48));
      pSetaLinha(String(strImpPag));
    End;
  End;

  If VS_strUsaPaf = 'S' Then
  Begin
    pSetaLinha(fPadR(fRetDocMaisTelParaIF(strNumDoc, strTelCli, 48), 48));
    pSetaLinha(fPadR(LeftStr(strNomCli, 39) + '-' + strCodCli, 48));

    If fEmptyStr(strMenPaf02) Then
      pSetaLinha(fPadR(strEndCli + ' - ' + strBaiCli, 48));

    If Not blnImpPag Then
      pSetaLinha(fPadR(strCepCli + ' - ' + strCidCli + '-' + strEstCli, 48));

    //pSetaLinha(fPadR(strCGCCPF + ' - ' + strIESCli, 48));
    //pSetaLinha(fPadR('Vendedor: ' + strNomVen, 48));

  End
  Else
  Begin
    pSetaLinha(fPadR(fRetDocMaisTelParaIF(strNumDoc, strTelCli, 48), 48));
    pSetaLinha(fPadR(LeftStr(strNomCli, 39) + '-' + strCodCli, 48));
    pSetaLinha(fPadR(strEndCli + ' - ' + strBaiCli, 48));

    If Not blnImpPag Then
      pSetaLinha(fPadR(strCepCli + ' - ' + strCidCli + '-' + strEstCli, 48));

    pSetaLinha(fPadR(strCGCCPF + ' - ' + strIESCli, 48));
    //pSetaLinha(fPadR('Vendedor: ' + strNomVen, 48));

  End;

  If fCfgSis('SIMNAC', varBoolean) Then
    pSetaLinha(fPadR( 'ICMS A SER REC. CONF. LC 123/2006 - SIMPLES NAC', 48));

  If (fCadEmp('ESTADO') = 'MG') And
     (fCfgSis('MINLEG', varBoolean)) Then
  Begin
    //pSetaLinha(fPadR( 'MINAS LEGAL', 40))
    strMinLeg := AnsiString(fPadR( 'MINAS LEGAL:' + Trim(fTiraCaracEspeciais(fNumeroCNPJUsuario, True, True, True)) + ' ' +
                            FormatDateTime('ddmmyyyy', fDataEcf) +
                            fPadL(AnsiReplaceStr(FloatToStrF(fltTotSis, ffNumber, 12, 2), '.', ''), 8, ' '), 48));

    pSetaLinha(String(strMinLeg));
  End
  Else
  If fCfgSis('CUPMAN', varBoolean) Then
  Begin
    //pSetaLinha(fPadR( 'VALIDO PARA O CUPOM MANIA.ICMS DEVIDO: ' + FormatFloat('#0.00', fltIcmDev), 48));
    strCupMan := AnsiString(fPadR( 'CUPOM MANIA, CONCORRA A PRÊMIOS VEND:' + strNomVen, 48));
    pSetaLinha(String(strCupMan));
    strCupMan := AnsiString(fPadR( 'ENVIE SMS P/ 6789:' + Trim(fTiraCaracEspeciais(fNumeroIEUsuario, True, True)) +
                                    FormatDateTime('ddmmyyyy', fDataEcf) +
                                    fRetornaCOO +
                                    RightStr(fNumeroCaixa, 3), 48));

    pSetaLinha(String(strCupMan));
  End;

  If(fEmptyStr(String(strMinLeg)) And fEmptyStr(String(strCupMan))) Then
  Begin
    pSetaLinha(fPadR('Vendedor: ' + strNomVen, 48));
  End;

  If (fCfgSis('UTINPS', varBoolean)) And
     (fGanhouNetpoints(strNumDoc,
                       'IF',
                       VS_strCodEmp,
                       strCodCli,
                       fSerieIF,
                       intQtdNps)) Then
  Begin
    pSetaLinha(Format(MSG_NETPOINTS, [IntToStr(intQtdNps)]));
  End;

  strMens := '';
  strMens := strMens + AnsiString(fPadR(String(strLinha01), 48));
  strMens := strMens + AnsiString(fPadR(String(strLinha02), 48));
  strMens := strMens + AnsiString(fPadR(String(strLinha03), 48));
  strMens := strMens + AnsiString(fPadR(String(strLinha04), 48));
  strMens := strMens + AnsiString(fPadR(String(strLinha05), 48));
  strMens := strMens + AnsiString(fPadR(String(strLinha06), 48));
  strMens := strMens + AnsiString(fPadR(String(strLinha07), 48));
  strMens := strMens + AnsiString(fPadR(String(strLinha08), 48));
  Result := String(strMens);
end;

function TElgin1FIT.fSangria(fltValor: Double): Boolean;
begin
  Elgin_Sangria(AnsiString(FloatToStrF(fltValor, ffNumber, 13, 2)));
  Result := fVerErro(blnModoNovo);
end;

function TElgin1FIT.fStatusImpressora: String;
begin
  FCodErr := Elgin_VerificaImpressoraLigada;
  Result  := IntToStr(FCodErr);
end;

function TElgin1FIT.fSuprimento(fltValor: Double; strModalidade: String='Dinheiro'): Boolean;
begin
  Elgin_Suprimento(AnsiString(FloatToStrF(fltValor, ffNumber, 13, 2)), AnsiString(strModalidade));
  Result := fVerErro(blnModoNovo);
end;

function TElgin1FIT.fTipoECF: String;
begin
  Result := String(strTipo);
end;

function TElgin1FIT.fUltimoComandoComErro: Boolean;
begin
  Result := blnUltimoComandoErro;
end;

function TElgin1FIT.fUltimoItemVendido: String;
  Var
    strTmp: AnsiString;
begin
  strTmp := AnsiString(StringOfChar(#0, 4));
  Elgin_UltimoItemVendido(AnsiString(strTmp));
  Result := fStrZero(Trim(String(strTmp)), 4);
end;

function TElgin1FIT.fUsaCNFVinculado(strTexto: String): Boolean;
begin
  FCodErr := Elgin_UsaComprovanteNaoFiscalVinculado(AnsiString(strTexto));
  Result  := fVerErro(blnModoNovo);
end;

function TElgin1FIT.fVendaBruta: Double;
  Var
    strValor: AnsiString;
begin

  If (fltVendaBruta > 0) And (fDataUltimaReducao = fDataEcf) Then
  Begin
    Result := fltVendaBruta;
  End
  Else
  Begin
    fltVendaBruta := 0;
    strValor := AnsiString(StringOfChar(#0, 14));
    Elgin_VendaBruta(AnsiString(strValor));
    Result := fStrToFloat(Trim(String(strValor))) / 100;
  End;
end;

function TElgin1FIT.fVerErro(blnMostraErro: Boolean): Boolean;
  var
    strCirc: string;
begin
  if(FCodErr = 1) then
    Result := True
  else begin
    strMensagem := 'Erro não identificado';
    case FCodErr of
      0: //strMensagem := 'Erro de comunicação';
        If (ObtemRetornoECF(strCirc)) Then
          strMensagem := strCirc
        Else
          strMensagem := 'Erro na comunicação.';
      -2: strMensagem := 'Erro Nº -2 - Parâmetro inválido';
      -4: strMensagem := 'Erro Nº -4 - Arquivo ini não encontrado ou parâmetro inválido para o nome da porta';
      -5: strMensagem := 'Erro Nº -5 - Erro ao abrir a porta de comunicação';
      -27: strMensagem := 'Erro Nº -27 - Status da impressora diferente de 6,0,0,0 (Ack, St1, St2 e St3)';
    end;
    Result := False;

    If (blnMostraErro) Then
      fMensagem('ATENÇÃO!', strMensagem, ['&Ok']);
  end;

  blnUltimoComandoErro := (Not Result);

end;

function TElgin1FIT.fVerificaCupomAberto: Boolean;
var intFlagFiscal : Integer;
begin
  Elgin_FlagsFiscais( intFlagFiscal ); 
  If (intFlagFiscal = 1) Or (intFlagFiscal = 33) Or (intFlagFiscal = 37) Or (intFlagFiscal = 39) Then
    Result:=True
  Else
    Result:=False;  
end;

function TElgin1FIT.fVersaoSoftwareBasico: String;
begin
  Result := String(strVersaoSB);
end;

function TElgin1FIT.ObtemRetornoECF(var strMensagemErro: String): Boolean;
var
  iRetorno, iCodErro: Integer;
  strErroMsg: AnsiString;
  bSucesso: Boolean;
begin
  strErroMsg := AnsiString(StringOfChar(#0, 1024));
  iRetorno := Elgin_RetornoImpressora(iCodErro, AnsiString(strErroMsg));
  strMensagemErro := 'Erro nº: ' + intToStr(iCodErro) + ' - ' + String(strErroMsg);

  If (iRetorno = 1) Then
    bSucesso := True
  Else
    bSucesso := False;

  ObtemRetornoECF := bSucesso;
End;

function TElgin1FIT.getSucesso: Boolean;
begin
  Result := (FCodErr = 1);
end;

procedure TElgin1FIT.pCarregaMFDAdicional;
  Var
    strCNPJInt,
    strDataInt,
    strHoraInt,
    strSerieInt,
    strNumEcfInt,
    strGTInt: AnsiString;
begin
  strCNPJInt := AnsiString(StringOfChar(#0, 18));
  strDataInt := AnsiString(StringOfChar(#0, 06));
  strHoraInt := AnsiString(StringOfChar(#0, 06));
  strSerieInt := AnsiString(StringOfChar(#0, 21));
  strNumEcfInt := AnsiString(StringOfChar(#0, 04));
  strGTInt := AnsiString(StringOfChar(#0, 20));

  Elgin_LeParametrosPAF(AnsiString(strCNPJInt), AnsiString(strDataInt), AnsiString(strHoraInt), AnsiString(strSerieInt),
    AnsiString(strNumEcfInt), AnsiString(strGTInt));

  strMFAdicional := '';
  strSerieInt := AnsiString(Trim(String(strSerieInt)));
  If Length(strSerieInt) = 21 Then
    strMFAdicional := RightStr(strSerieInt, 1);
end;

procedure TElgin1FIT.pFechaPortaImpressora;
begin
  inherited;
  //
end;

procedure TElgin1FIT.pPausaLeitura;
begin
  inherited;
  //
end;

function TElgin1FIT.fRegistraItem(strCodIte, strDesIte, strUnidad,
  strAlqIcm: String; fltQtdIte, fltUnitar: Double;
  strCodFis: String; fltDesEsp: Double): Boolean;
  Var
    strQtdIte: String;
    strUnitar: String;
    strDesEsp: String;
    strAcresc: String;
    sepAnt: Char;
begin

  sepAnt := FormatSettings.DecimalSeparator;
  FormatSettings.DecimalSeparator := ',';

  strDesIte := AnsiReplaceText(strDesIte, '"', '');
  strDesIte := AnsiReplaceText(strDesIte, #39, '');
  strDesIte := AnsiReplaceText(strDesIte, #34, '');
  strDesIte := AnsiReplaceStr(strDesIte, #34, '');
  strDesIte := AnsiReplaceStr(strDesIte, '"', '');

  strQtdIte := AnsiReplaceStr(FloatToStrF(fltQtdIte, ffFixed, 12, 3), '.', '');
  strUnitar := FloatToStrF(fltUnitar, ffFixed, 12, intDecUni);

  pCalculaAcrDesItem(Self, fStrToFloat(strQtdIte), fStrToFloat(strUnitar),
    fltQtdIte, fltUnitar, fltDesEsp, fltUltDesEspIte, fltUltAcrescIte);

  strDesEsp := FloatToStrF(fltUltDesEspIte, ffFixed, 5, 2);
  strAcresc := FloatToStrF(fltUltAcrescIte, ffFixed, 5, 2);

  FCodErr := Elgin_VendeItemDepartamento(AnsiString(strCodIte), AnsiString(strDesIte), AnsiString(strAlqIcm), AnsiString(strUnitar),
    AnsiString(strQtdIte), AnsiString(strAcresc), AnsiString(strDesEsp), '00', AnsiString(strUnidad));

  Result := fVerErro(blnModoNovo);

  If fIsNumber(strAlqIcm) Then
    strUltIndiceTri := strAlqIcm
  Else
    strUltIndiceTri := LeftStr(strAlqIcm, 1);

  FormatSettings.DecimalSeparator := sepAnt;
end;

end.

