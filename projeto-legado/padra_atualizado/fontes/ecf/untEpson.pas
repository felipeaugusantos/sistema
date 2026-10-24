
{**************************************************}
{* UNIT COM AS FUNCOES DA EPSON                   *}
{*                                                *}
{* DATA......: 26/05/2009                         *}
{* AUTOR.....: ALEXANDRE FERRI                    *}
{*                                                *}
{***********************************************AF*}
unit untEpson;

interface

Uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StrUtils, Uni, untFiscal, untFuncoesGenerica, untTypesSistema;

  function EPSON_Fiscal_Abrir_Cupom(pszCNPJ:PAnsiChar; pszRazaoSocial:PAnsiChar; pszEndereco1:PAnsiChar; pszEndereco2:PAnsiChar; dwPosicao:Integer):Integer;StdCall; External 'InterfaceEpson.dll' delayed;
  function EPSON_Impressora_Abrir_Gaveta():Integer;StdCall; External 'InterfaceEpson.dll' delayed;
  function EPSON_Serial_Abrir_PortaEx():Integer;StdCall; External 'InterfaceEpson.dll' delayed;
  function EPSON_Obter_Dados_MF_MFD(pszInicio:PAnsiChar; pszFinal:PAnsiChar; dwTipoEntrada:Integer; dwEspelhos:Integer; dwAtoCotepe:Integer; dwSintegra:Integer; pszArquivoSaida:PAnsiChar):Integer;StdCall; External 'InterfaceEpson.dll' delayed;
  function EPSON_Fiscal_Cancelar_Cupom():Integer;StdCall; External 'InterfaceEpson.dll' delayed;
  function EPSON_Fiscal_Imprimir_Mensagem(pszLinhaTexto1:PAnsiChar; pszLinhaTexto2:PAnsiChar; pszLinhaTexto3:PAnsiChar; pszLinhaTexto4:PAnsiChar; pszLinhaTexto5:PAnsiChar; pszLinhaTexto6:PAnsiChar; pszLinhaTexto7:PAnsiChar; pszLinhaTexto8:PAnsiChar):Integer;StdCall; External 'InterfaceEpson.dll' delayed;
  function EPSON_Fiscal_Fechar_Cupom(bCortarPapel:Boolean; bAdicional:Boolean):Integer;StdCall; External 'InterfaceEpson.dll' delayed;
  function EPSON_RelatorioFiscal_LeituraX():Integer;StdCall; External 'InterfaceEpson.dll' delayed;
  function EPSON_RelatorioFiscal_RZ(pszData:PAnsiChar; pszHora:PAnsiChar; dwHorarioVerao:Integer; pszCRZ:PAnsiChar):Integer;StdCall; External 'InterfaceEpson.dll' delayed;
  function EPSON_Fiscal_Desconto_Acrescimo_Item(pszValor:PAnsiChar; dwCasasDecimais:Integer; bDesconto: Boolean; bPercentagem: Boolean): Integer;StdCall; External 'InterfaceEpson.dll' delayed;
  function EPSON_Fiscal_Desconto_Acrescimo_Subtotal(pszValor:PAnsiChar; dwCasasDecimais:Integer; bDesconto:Boolean; bPercentagem:Boolean):Integer;StdCall; External 'InterfaceEpson.dll' delayed;
  function EPSON_Fiscal_Vender_Item(pszCodigo:PAnsiChar; pszDescricao:PAnsiChar; pszQuantidade:PAnsiChar; dwQuantCasasDecimais:Integer; pszUnidade:PAnsiChar; pszPrecoUnidade:PAnsiChar; dwPrecoCasasDecimais:Integer; pszAliquotas:PAnsiChar; dwLinhas:Integer):Integer;StdCall; External 'InterfaceEpson.dll' delayed;
  function EPSON_Fiscal_Pagamento(pszNumeroPagamento:PAnsiChar; pszValorPagamento:PAnsiChar; dwCasasDecimais:Integer; pszDescricao1:PAnsiChar; pszDescricao2:PAnsiChar):Integer;StdCall; External 'InterfaceEpson.dll' delayed;
  function EPSON_NaoFiscal_Abrir_Relatorio_Gerencial(pszNumeroRelatorio:PAnsiChar):Integer;StdCall; External 'InterfaceEpson.dll' delayed;
  function EPSON_NaoFiscal_Imprimir_Linha( pszImpressaoLinhaTexto:PAnsiChar ):Integer; StdCall; External 'InterfaceEpson.dll' delayed;
  function EPSON_NaoFiscal_Imprimir_LinhaEX( pszLinhaTexto:PAnsiChar ):Integer; StdCall; External 'InterfaceEpson.dll' delayed;
  function EPSON_NaoFiscal_Fechar_Relatorio_Gerencial(bStatusCortarPapel:Boolean):Integer; StdCall;External 'InterfaceEpson.dll' delayed;
  function EPSON_Obter_Contadores(pszDados:PAnsiChar):Integer;StdCall; External 'InterfaceEpson.dll' delayed;
  function EPSON_Obter_Estado_Impressora(pszDados:PAnsiChar):Integer;StdCall; External 'InterfaceEpson.dll' delayed;
  function EPSON_Serial_Fechar_Porta ():Integer;StdCall; External 'InterfaceEpson.dll' delayed;
  function EPSON_RelatorioFiscal_Leitura_MF(pszInicio:PAnsiChar; pszFim:PAnsiChar; dwTipoImpressao:Integer; pszBuffer:PAnsiChar; pszArquivo:PAnsiChar; pdwTamanhoBuffer:PInteger; dwTamBuffer:Integer):Integer;StdCall; External 'InterfaceEpson.dll' delayed;
  function EPSON_RelatorioFiscal_Abrir_Dia():Integer;StdCall; External 'InterfaceEpson.dll' delayed;
  function EPSON_Obter_Tabela_Aliquotas(pszTabelaAliquotas:PAnsiChar):Integer;StdCall; External 'InterfaceEpson.dll' delayed;
  function EPSON_Obter_Estado_Cupom(pszEstado: LPSTR): Integer; StdCall; External 'InterfaceEpson.dll' delayed;
  function EPSON_Obter_Dados_Impressora(pszDados: PAnsiChar): Integer; StdCall; External 'InterfaceEpson.dll' delayed;
  function EPSON_Obter_Arquivo_Binario_MFD(pszNomeArquivoMFD:PAnsiChar):Integer;StdCall; External 'InterfaceEpson.dll' delayed;
  function EPSON_Config_Dados_PAFECF( pszDeveloperCNPJ:PAnsiChar; pszIE:PAnsiChar; pszIM:PAnsiChar;pszName:PAnsiChar; pszNomePAF:PAnsiChar; pszVersaoPAF:PAnsiChar;pszPAFMD5:PAnsiChar; pszVersaoER:PAnsiChar):Integer;StdCall; External'InterfaceEpson.dll' delayed;
  function EPSON_Obter_Numero_Usuario(pszNumeroUsuario:PAnsiChar): Integer;StdCall; External'InterfaceEpson.dll' delayed;

  function EPSON_Obter_Dados_Ultima_RZ(pszUltimaRZ:PAnsiChar):Integer;StdCall; External 'InterfaceEpson.dll' delayed;
  function EPSON_Obter_Venda_Bruta(pszVendaBrutaAtual:PAnsiChar; pszVendaBrutaAnterior:PAnsiChar): Integer; StdCall; External 'InterfaceEpson.dll' delayed;
  function EPSON_Obter_Numero_ECF_Loja(pszECFLoja:PAnsiChar):Integer;StdCall; External 'InterfaceEpson.dll' delayed;
  function EPSON_Obter_Dados_Usuario(pszDadosUsuario:PAnsiChar):Integer;StdCall; External 'InterfaceEpson.dll' delayed;
  function EPSON_Obter_Versao_SWBasicoEX ( pszVersaoSWBasico:PAnsiChar; pszDataInstalacao:PAnsiChar;pszHoraInstalacao:PAnsiChar):Integer;StdCall; External 'InterfaceEpson.dll' delayed;
  function EPSON_Obter_GT(pszGT:PAnsiChar):Integer;StdCall; External 'InterfaceEpson.dll' delayed;
  function EPSON_NaoFiscal_Sangria(pszValor:PAnsiChar; dwCasasDecimaisValor:Integer):Integer;StdCall; External 'InterfaceEpson.dll' delayed;
  function EPSON_Obter_Hora_Relogio(pszDataHoraRelogio:PAnsiChar):Integer;StdCall; External 'InterfaceEpson.dll' delayed;
  function EPSON_Obter_Numero_Ultimo_Item(pszNumeroUltimoItem:PAnsiChar):Integer;StdCall; External 'InterfaceEpson.dll' delayed;
  function EPSON_NaoFiscal_Fundo_Troco(pszValor:PAnsiChar; dwCasasDecimaisValor:Integer):Integer; StdCall; External 'InterfaceEpson.dll' delayed;
  function EPSON_Fiscal_Cancelar_Item(pszNumeroItem:PAnsiChar):Integer;StdCall; External 'InterfaceEpson.dll' delayed;
  function EPSON_NaoFiscal_Abrir_CCD(pszNumeroDescricaoPagamento:PAnsiChar; pszValorPagamento:PAnsiChar; dwCasasDecimaisPagamento:Integer;pszParcelas:PAnsiChar):Integer; StdCall; External 'InterfaceEpson.dll' delayed;
  function EPSON_NaoFiscal_Fechar_CCD(bStatusCortarPapel:Boolean):Integer; StdCall; External 'InterfaceEpson.dll' delayed;

  function EPSON_NaoFiscal_Imprimir_15Linhas( pszLinhaTexto00:PAnsiChar; pszLinhaTexto01:PAnsiChar;
    pszLinhaTexto02:PAnsiChar; pszLinhaTexto03:PAnsiChar;
    pszLinhaTexto04:PAnsiChar; pszLinhaTexto05: PAnsiChar;pszLinhaTexto06:PAnsiChar;pszLinhaTexto07: PAnsiChar;
    pszLinhaTexto08:PAnsiChar;pszLinhaTexto09:PAnsiChar;pszLinhaTexto10:PAnsiChar;pszLinhaTexto11: PAnsiChar;
    pszLinhaTexto12:PAnsiChar;pszLinhaTexto13:PAnsiChar;pszLinhaTexto14:PAnsiChar):Integer;StdCall;External 'InterfaceEpson.dll' delayed;

Type

  TEpson = class(TFiscal)
  private
    FPais: TPais;
    FNumSer: String;
    blnEmitindoCupom: Boolean;

    blnExcedeuLinhasDocumento : Boolean;

    function fRetContadores: String;
    function fDadosUsuario: String;
    procedure pDadosSoftwareBasico(Var strVersao: String; Var dtaData, dtaHora: TDateTime);
    function fDadosImpressora: String;
    function fNumeroSerieInt: String;

    function fDataEpsonToDate(str: String): TDate;
    function fHoraEpsonToTime(str: String): TDateTime;
  public
    blnModoNovo: Boolean;
    intRetorno : Integer;
    strObserv  : String;

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
    function fAbreRelatorioGerencial(blnMostrarErro: Boolean = True): Boolean; override;
    function fRelatorioGerencial(strTexto: String): Boolean; Override;
    function fFechaRelatorioGerencial(blnVerErro: Boolean = True): Boolean; Override;
    function fEspacoEntreLinhas(intEspacos: Integer): Boolean; Override;
    function fAbreCNFVinculado(strDesFormaPgto, strValor, strNumCupom: String; strQtdPar: String = ''): Boolean; Override;
    function fFechaCNFVinculado(blnVerErro: Boolean = True): Boolean; Override;
    function fUsaCNFVinculado(strTexto: String): Boolean; Override;
    function fImpLinFiscal(strAtrib, strLinha: String): Boolean; Override;
    function fAbrePortaImpressora: Boolean; Override;
    function fexecutaCMD(strCmd: String; blnRetorna: Boolean = False): String; Override;
    function fRetMensErro: String;
    function fLeituraMemFiscal(strParIni, strParFin: String; intTipLei: Integer ): Boolean;
    function fEspelhoMFD(strTipoFiltro, strFiltroIni, strFiltroFin, strArquivoSaida: String): Boolean; Override;
    function fRetParEcf: String;
    function fRetParRdz: String;
    function fRetImpRdz: Boolean;
    function fVerificaCupomAberto: Boolean; reintroduce;

    function fModeloEcf: String; Override;

    procedure pFechaPortaImpressora; Override;
    procedure pPausaLeitura; Override;


    Constructor Create(Owner: TComponent; strPorta: String); Reintroduce;

    {************************************************************}
    {* Funções abaixo foram declaradas para correção de warnings*}
    {*                                                          *}
    {* DATA......: 16/07/2014                                   *}
    {* AUTOR.....: Marcelo Fagundes                             *}
    {*                                                          *}
    {*********************************************************MH*}

      function fLeituraMemoriaFiscal(blnCompleta: Boolean; strTipoFiltro, strFiltroIni, strFiltroFin: String): Boolean; Override ;
      function fArquivoMFD(strDataIni, strDataFin, strArquivoSaida, strRazSocEmp, strEndereEmp: String): Boolean; override;
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
      function fExcedeuLinhasDocumento: Boolean; override;
  End;

implementation

uses untFuncoesSimples, untConstantes, untFuncoes, Data.DB, untObservacao, untConstantesNFe;

{ TEpson }

constructor TEpson.Create(Owner: TComponent; strPorta: String);
begin
  inherited Create(Owner);
  FPais            := fSetaPais;
  FPorta           := strPorta;
  blnModoNovo      := True;
  FNumSer          := fNumeroSerieInt;
  blnEmitindoCupom := False;
  blnExcedeuLinhasDocumento := False;
  //fAbrePortaImpressora;
end;

function TEpson.fAbreCNFVinculado(strDesFormaPgto, strValor, strNumCupom: String; strQtdPar: String = ''): Boolean;
  Var
    strVal: String;
    ansiDesFormaPgto: AnsiString;
    ansiVal: AnsiString;
    ansiQtdPar: AnsiString;
begin
  strVal := AnsiReplaceStr(FloatToStrF(fStrToFloat(strValor), ffNumber, 11, 2), ',', '');
  fAbrePortaImpressora;

  blnEmitindoCupom := True;
  ansiDesFormaPgto := AnsiString(strDesFormaPgto);
  ansiVal          := AnsiString(strVal);
  ansiQtdPar       := AnsiString(strQtdPar);

  intRetorno := EPSON_NaoFiscal_Abrir_CCD(PAnsiChar(ansiDesFormaPgto), PAnsiChar(ansiVal), 2, PAnsiChar(ansiQtdPar));
  Result := fVerErro(True);

  pFechaPortaImpressora;
end;

function TEpson.fAbreCupom: Boolean;
Var
  ansiCpfClie: AnsiString;
  ansiNomCli: AnsiString;
  ansiEndCli: AnsiString;
  ansiBaiCli: AnsiString;
begin

  ansiCpfClie := AnsiString(Trim(strCpfClie));
  ansiNomCli  := AnsiString(fPadR(strNomCli, 30));
  ansiEndCli  := AnsiString(fPadR(strEndCli, 40));
  ansiBaiCli  := AnsiString(fPadR(strBaiCli, 39));

  fAbrePortaImpressora;
  blnEmitindoCupom := True;
  intRetorno  := EPSON_Fiscal_Abrir_Cupom(PAnsiChar(ansiCpfClie), PAnsiChar(ansiNomCli), PAnsiChar(ansiEndCli), PAnsiChar(ansiBaiCli), 2);
  Result := fVerErro(blnModoNovo);
  pFechaPortaImpressora;
end;

function TEpson.fAbreGaveta: Boolean;
begin
  fAbrePortaImpressora;
  intRetorno  := EPSON_Impressora_Abrir_Gaveta;
  Result := fVerErro(blnModoNovo);
  pFechaPortaImpressora;
end;

function TEpson.fAbrePortaImpressora: Boolean;
  Var
    intRet  : Integer;
    intST4  : Integer;
    strRet  : String;
    ST4     : String;
    arrRet: Array[0..20] Of AnsiChar;
begin
  If blnEmitindoCupom Then
  Begin
    Result := True;
    Exit;
  End;

  // ShowMessage('abre porta');
  //ShowMessage('ap 1');
  intRetorno  := EPSON_Serial_Abrir_PortaEx();
  Result := fVerErro(blnModoNovo);

  //ShowMessage('ap 2');
  {********************************************}
  {* VERIFICA SE A JORNADA DO DIA ESTÁ ABERTA *}
  {*****************************************AF*}
  If Result Then
  Begin
    //ShowMessage('ap 3');

    SetLength(strRet, 21);
    FillChar(arrRet, 21, #0);
    intRet := EPSON_Obter_Estado_Impressora(arrRet);
    SetString(strRet, arrRet, 21);

    //ShowMessage('ap 4 ' + strRet);

    If intRet <> 0 Then
      Result := False
    Else
    begin

      ST4 := Copy(strRet,13,4);

      intST4 := StrToInt('$' + ST4);
      If (intST4 >= 32768) Then intST4 := intST4 - 32768;
      If (intST4 >= 16384) Then intST4 := intST4 - 16384;
      If (intST4 >= 4096)  Then intST4 := intST4 - 4096;
      If (intST4 >= 2048)  Then intST4 := intST4 - 2048;
      If (intST4 >= 1024)  Then intST4 := intST4 - 1024;
      If (intST4 < 128)    Then EPSON_RelatorioFiscal_Abrir_Dia; //Período de vendas fechado

    End;

  End;

end;

function TEpson.fArquivoMFD(strDataIni, strDataFin, strArquivoSaida,
  strRazSocEmp, strEndereEmp: String): Boolean;
  Var
    ansiVerPaf     : AnsiString;
    ansiMD5Laudo   : AnsiString;
    ansiVersaoPAFER: AnsiString;

    ansiDataIni     : AnsiString;
    ansiDataFin     : AnsiString;
    ansiArquivoSaida: AnsiString;
begin
  ansiVerPaf      := AnsiString(VS_strVerPaf);
  ansiMD5Laudo    := AnsiString(fRetMD5Laudo);
  ansiVersaoPAFER := AnsiString(fRetVersaoPAFER);

  fAbrePortaImpressora;
  EPSON_Config_Dados_PAFECF('51212892000125', 'ISENTO', '',
    'CITEL ANALÁSE E PROGRAMAÇÃO DE SISTEMAS', 'PDVCitel', PAnsiChar(ansiVerPaf),
    PAnsiChar(ansiMD5Laudo), PAnsiChar(ansiVersaoPAFER));

  ansiDataIni      := AnsiString(AnsiReplaceStr(strDataIni, '/', ''));
  ansiDataFin      := AnsiString(AnsiReplaceStr(strDataFin, '/', ''));
  ansiArquivoSaida := AnsiString(strArquivoSaida);

  Result := EPSON_OBTER_DADOS_MF_MFD(PAnsiChar(ansiDataIni), PAnsiChar(ansiDataFin), 0, 0, 3, 0, PAnsiChar(ansiArquivoSaida)) = 0;
  pFechaPortaImpressora;

  If Result Then
    fRenomearArquivo(String(ansiArquivoSaida + '_CTP.txt'), strArquivoSaida);
end;

function TEpson.fCalcAliquota(strCodFiscal: String; fltAliquota: Double; intTipRet: Integer): String;
  Var
    strPatIni: String;
    strCodEcf: String;
    strAliquota: String;
    qryTmpEcf: TUniQuery;
    strSQL: String;
    strCODSTB: String;
    strCODISE: String;
    strCODNIN: String;
    strCod018: String;
    strCodAtu: String;
    blnPrimei: Boolean;
    strPriCod: String;
    strIdeSer: String;
    strCodAlq: String;
    fltValAlq: Double;
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

function TEpson.fCancelaCupom: Boolean;
begin
  fAbrePortaImpressora;
  intRetorno  := EPSON_Fiscal_Cancelar_Cupom;
  Result := fVerErro(blnModoNovo);
  blnEmitindoCupom := False;
  pFechaPortaImpressora;
end;

function TEpson.fCancelaItem(strItem: String): Boolean;
Var
  ansiItem: ansiString;
begin

  ansiItem := ansiString(strItem);

  fAbrePortaImpressora;
  intRetorno := EPSON_Fiscal_Cancelar_Item(PAnsiChar(ansiItem));
  Result := fVerErro(True);
  pFechaPortaImpressora;
end;

function TEpson.fDadosImpressora: String;
  Var
    ansiDados: AnsiString;
begin
  fAbrePortaImpressora;

  ansiDados  := AnsiString(StringOfChar(' ', 109));
  intRetorno := EPSON_Obter_Dados_Impressora(PAnsiChar(ansiDados));
  Result     := String(ansiDados);

  pFechaPortaImpressora;
end;

function TEpson.fDadosUltimaReducao(var drzDadosRed: TDadosReducao): Boolean;

Const

  arrPosTotali: Array[1..13] Of Array[1..3] Of String = (
    ('I1'   , ''   , 'I'),
    ('N1'   , ''   , 'N'),
    ('F1'   , ''   , 'F'),
    ('IS1'  , ''   , 'IS'),
    ('NS1'  , ''   , 'NS'),
    ('FS1'  , ''   , 'FS'),
    ('DT'   , '156', 'DT'),
    ('DS'   , '173', 'DS'),
    ('AT'   , '207', 'AT'),
    ('AS'   , '223', 'AS'),
    ('Can-T', '105', 'Can-T'),
    ('Can-S', '122', 'Can-S'),
    ('OPNF' , '818', 'OPNF')
  );


var
  ansiDadosRed: AnsiString;

  ansiDtaMov: AnsiString;
  ansiAlqIcm: AnsiString;
  ansiValIcm: AnsiString;

  intConta    : Integer;
  intPosAlqIcm: Integer;
  intPosValIcm: Integer;
  intTamMat   : Integer;
  intContador : Integer;
  intPosAlqIni: Integer;
  intQtdCarAlq: Integer;
  intPosValIni: Integer;
  intQtdCarVal: Integer;
  intPosiOPNF : Integer;
  intContOPNF : Integer;

  ansiLisAlq: ansiString;
  ansiLisVal: ansiString;

  function fRetValorAliquotas(ansiAliquota: AnsiString): String;
  Var
    blnAchou   : Boolean;
    ansiAlqAtu : AnsiString;
    intContador: Integer;
    intPosAlq  : Integer;
  Begin
    Result := '';

    intContador := 1;
    intPosAlq   := 1;
    blnAchou    := False;

    While (intContador <= 24) Do  //quantidade de alíquotas possíveis
    Begin
      ansiAlqAtu := Copy(ansiLisAlq, intContador, 5);

      If (Pos(ansiAliquota, ansiAlqAtu) > 0) Then
      Begin
        blnAchou := True;
        Break;
      End;

      Inc(intContador, 5);
      Inc(intPosAlq);
    End;

    If (blnAchou) Then
    Begin
      Result := String(Copy(ansiLisVal, (1 + (17 * (intPosAlq - 1))), 17));
    End;

  End;

begin
  fAbrePortaImpressora;

  intPosAlqIni := 258;
  intQtdCarAlq := 120;
  intPosValIni := 384;
  intQtdCarVal := 408;

  ansiDadosRed := AnsiString(StringOfChar(' ', 1168));
  intRetorno   := EPSON_Obter_Dados_Ultima_RZ(PAnsiChar(ansiDadosRed));
  Result       := fVerErro(blnModoNovo);

  pFechaPortaImpressora;

  If (Not Result) Then
    Exit;

  ansiLisAlq := Copy(ansiDadosRed, intPosAlqIni, intQtdCarAlq);
  ansiLisVal := Copy(ansiDadosRed, intPosValIni, intQtdCarVal);

  intConta     := 1;
  intPosAlqIcm := 258;
  intPosValIcm := 384;

  Try

    ansiDtaMov := Copy(ansiDadosRed, 1160, 08);
    Insert('/', ansiDtaMov, 3);
    Insert('/', ansiDtaMov, 6);

    drzDadosRed.strNumCrz   := Copy(String(ansiDadosRed), 0027, 06);
    drzDadosRed.strNumCOORZ := Copy(String(ansiDadosRed), 0021, 06);
    drzDadosRed.strNumCRO   := Copy(String(ansiDadosRed), 0033, 06);
    drzDadosRed.dtaDtaMov   := StrToDate(String(ansiDtaMov));
    SetLength(drzDadosRed.arrTotali, 0);

    {*****************************************}
    {* PEGA OS DADOS DA TRIBUTAÇÃO           *}
    {**************************************MV*}
    ansiAlqIcm := Copy(ansiDadosRed, intPosAlqIcm, 05);
    ansiValIcm := Copy(ansiDadosRed, intPosValIcm, 17);

    While (Pos('T', String(ansiAlqIcm)) > 0) Do
    Begin

      intTamMat := Length(drzDadosRed.arrTotali);
      SetLength(drzDadosRed.arrTotali, intTamMat+1);

      drzDadosRed.arrTotali[intTamMat].strCodTot := fStrZero(intConta, 02) + String(ansiAlqIcm);
      drzDadosRed.arrTotali[intTamMat].fltValAcu := fStrToFloat(String(ansiValIcm)) / 100;

      Inc(intPosAlqIcm, 05);
      Inc(intPosValIcm, 17);
      Inc(intConta);

      ansiAlqIcm := Copy(ansiDadosRed, intPosAlqIcm, 05);
      ansiValIcm := Copy(ansiDadosRed, intPosValIcm, 17);
    End;

    For intContador := Low(arrPosTotali) To High(arrPosTotali) Do
    Begin

      intTamMat := Length(drzDadosRed.arrTotali);
      SetLength(drzDadosRed.arrTotali, intTamMat+1);

      If (arrPosTotali[intContador][1] <> 'OPNF') Then
      Begin
        If (fEmptyStr(arrPosTotali[intContador][2])) Then
          ansiValIcm := AnsiString(String(fRetValorAliquotas(AnsiString(arrPosTotali[intContador][3]))))
        Else
          ansiValIcm := Copy(ansiDadosRed, StrToInt(arrPosTotali[intContador][2]), 17);

        drzDadosRed.arrTotali[intTamMat].strCodTot := arrPosTotali[intContador][1];
        drzDadosRed.arrTotali[intTamMat].fltValAcu := fStrToFloat(String(ansiValIcm)) / 100;

      End
      Else
      Begin
        intPosiOPNF := StrToInt(arrPosTotali[intContador][2]);

        drzDadosRed.arrTotali[intTamMat].strCodTot := arrPosTotali[intContador][1];

        For intContOPNF := 1 To 20 Do
        Begin
          ansiValIcm := Copy(ansiDadosRed, intPosiOPNF, 13);
          drzDadosRed.arrTotali[intTamMat].fltValAcu := drzDadosRed.arrTotali[intTamMat].fltValAcu + fStrToFloat(String(ansiValIcm)) / 100;
          Inc(intPosiOPNF, 17);
        End;

      End;
    End;


  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fDadosUltimaReducao]');
    End;
  End;

end;

function TEpson.fDadosUsuario: String;
  Var
    ansiRet: AnsiString;
begin
  fAbrePortaImpressora;

  ansiRet := AnsiString(StringOfChar(' ', 49));
  EPSON_Obter_Dados_Usuario(PAnsiChar(ansiRet));

  pFechaPortaImpressora;

  Result := String(ansiRet);
end;

function TEpson.fDataEcf: TDateTime;
  Var
    arrRet: Array[0..14] Of AnsiChar;
    strRet: String;
    strData: String;
begin
  fAbrePortaImpressora;
  FillChar(arrRet, 15, #0);
  EPSON_Obter_Hora_Relogio(arrRet);
  SetString(strRet, arrRet, 15);
  pFechaPortaImpressora;

  strData := LeftStr(strRet, 8);
  Result := fDataEpsonToDate(strData);
end;

function TEpson.fDataEpsonToDate(str: String): TDate;
begin
  Result := StrToDate(LeftStr(str, 2) + '/' + Copy(str, 3, 2) + '/' + RightStr(str, 4));
end;

function TEpson.fDataGravacaoSoftwareBasico: TDateTime;
  Var
    strVersao: String;
    dtaHora: TDateTime;
begin
  pDadosSoftwareBasico(strVersao, Result, dtaHora);
end;

function TEpson.fEspacoEntreLinhas(intEspacos: Integer): Boolean;
begin
  Result := True;
end;

function TEpson.fEspelhoMFD(strTipoFiltro, strFiltroIni, strFiltroFin, strArquivoSaida: String): Boolean;
Var
  ansiUm  : AnsiString;
  ansiDois: AnsiString;
  ansiArquivoSaida: AnsiString;
begin

  ansiUm           := AnsiString(AnsiReplaceStr(strFiltroIni, '/', ''));
  ansiDois         := AnsiString(AnsiReplaceStr(strFiltroFin, '/', ''));
  ansiArquivoSaida := AnsiString(strArquivoSaida);

  fAbrePortaImpressora;
  Result := EPSON_OBTER_DADOS_MF_MFD(PAnsiChar(ansiUm), PAnsiChar(ansiDois), 0, 2, 2, 0, PAnsiChar(ansiArquivoSaida)) = 0;
  pFechaPortaImpressora;

  If Result Then
  Begin
    fRenomearArquivo(strArquivoSaida + '_ESP.txt', strArquivoSaida);
  End;
end;

function TEpson.fExcedeuLinhasDocumento: Boolean;
begin
  Result := blnExcedeuLinhasDocumento;
end;

function TEpson.fexecutaCMD(strCmd: String; blnRetorna: Boolean): String;
begin
  Result := '';
end;

function TEpson.fFechaCNFVinculado(blnVerErro: Boolean = True): Boolean;
begin
  fAbrePortaImpressora;
  intRetorno := EPSON_NaoFiscal_Fechar_CCD(True);
  Result := fVerErro(blnVerErro);
  blnEmitindoCupom := False;
  pFechaPortaImpressora;
end;

function TEpson.fFechaCupom: Boolean;
  Var
    strMen001: String;
    strMen002: String;
    strMen003: String;
    strMen004: String;
    strMen005: String;
    strMen006: String;
    strMen007: String;
    strMen008: String;
    strMinLeg,
    strCupMan,
    strImpPag: string;
    blnImpPag: Boolean;
    intQtdNps: Integer;

    ansiMen001: AnsiString;
    ansiMen002: AnsiString;
    ansiMen003: AnsiString;
    ansiMen004: AnsiString;
    ansiMen005: AnsiString;
    ansiMen006: AnsiString;
    ansiMen007: AnsiString;
    ansiMen008: AnsiString;

  procedure pSetaLinha(strValor: String);
  begin
    If fEmptyStr(strMen001) Then
      strMen001 := strValor
    Else If fEmptyStr(strMen002) Then
      strMen002 := strValor
    Else If fEmptyStr(strMen003) Then
      strMen003 := strValor
    Else If fEmptyStr(strMen004) Then
      strMen004 := strValor
    Else If fEmptyStr(strMen005) Then
      strMen005 := strValor
    Else If fEmptyStr(strMen006) Then
      strMen006 := strValor
    Else If fEmptyStr(strMen007) Then
      strMen007 := strValor
    Else If fEmptyStr(strMen008) Then
      strMen008 := strValor;
  end;

Begin
  strMen001 := '';
  strMen002 := '';
  strMen003 := '';
  strMen004 := '';
  strMen005 := '';
  strMen006 := '';
  strMen007 := '';
  strMen008 := '';

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
                         '(' + FormatFloat('#,##0.00', fltPeImPg) +
                         IIF(fCfgSis('IMPPAG', varInteger) = 1,'%)','%)Fonte:IBPT'), 48))
      Else
        pSetaLinha(fPadR(strMsgArreTribuRedz48 + FormatFloat('#,##0.00', fltImpPag) +
                         '(' + FormatFloat('#,##0.00', fltPeImPg) +
                         IIF(fCfgSis('IMPPAG', varInteger) = 1,'%)','%)Fonte:IBPT'), 48));
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
      strImpPag := Copy(fPadR(strImpPag, 48), 1, 48);
      pSetaLinha(strImpPag);
    End;
  End;

  strMinLeg := '';
  strCupMan := '';

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

  If fCfgSis('IMPCAC', varBoolean) Then
    pSetaLinha(fPadR('Cupom Fiscal: ' + strNumDoc + '-IF', 48));

  pSetaLinha(fPadR(LeftStr(strNomCli, 39) + ' - ' + strCodCli, 48));
  pSetaLinha(fPadR(strEndCli + ' - ' + strBaiCli, 48));

  If Not blnImpPag Then
    pSetaLinha(fPadR(strCepCli + ' - ' + strCidCli + '-' + strEstCli, 48));

  pSetaLinha(fPadR(strCGCCPF + ' - ' + strIESCli, 48));

  If fCfgSis('SIMNAC', varBoolean) Then
    pSetaLinha(fPadR( 'ICMS A SER REC. CONF. LC 123/2006 - SIMPLES NAC', 48));

  If (fCadEmp('ESTADO') = 'MG') And
     (fCfgSis('MINLEG', varBoolean)) Then
  Begin
    strMinLeg := fPadR( 'MINAS LEGAL:' + Trim(fTiraCaracEspeciais(fNumeroCNPJUsuario, True, True, True)) + ' ' +
                         FormatDateTime('ddmmyyyy', fDataEcf) +
                         fPadL(AnsiReplaceStr(FloatToStrF(fltTotSis, ffNumber, 12, 2), '.', ''), 8, ' '), 48);

    pSetaLinha(strMinLeg);
  End
  Else
  If fCfgSis('CUPMAN', varBoolean) Then
  Begin
    strCupMan := fPadR( 'CUPOM MANIA, CONCORRA A PRÊMIOS VEND:' + strNomVen, 48);
    pSetaLinha(strCupMan);

    strCupMan := '';
    strCupMan := fPadR( 'ENVIE SMS P/ 6789:' + Trim(fTiraCaracEspeciais(fNumeroIEUsuario, True, True)) +
                         FormatDateTime('ddmmyyyy', fDataEcf) +
                         fRetornaCOO +
                         RightStr(fNumeroCaixa, 3), 48);

    pSetaLinha(strCupMan);
  End;

  If(fEmptyStr(strMinLeg) And fEmptyStr(strCupMan))Then
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

  ansiMen001 := AnsiString(strMen001);
  ansiMen002 := AnsiString(strMen002);
  ansiMen003 := AnsiString(strMen003);
  ansiMen004 := AnsiString(strMen004);
  ansiMen005 := AnsiString(strMen005);
  ansiMen006 := AnsiString(strMen006);
  ansiMen007 := AnsiString(strMen007);
  ansiMen008 := AnsiString(strMen008);

  fAbrePortaImpressora;
  intRetorno  := EPSON_Fiscal_Imprimir_Mensagem(PAnsiChar(ansiMen001),PAnsiChar(ansiMen002),
    PAnsiChar(ansiMen003),PAnsiChar(ansiMen004),PAnsiChar(ansiMen005),PAnsiChar(ansiMen006),
    PAnsiChar(ansiMen007),PAnsiChar(ansiMen008));
  Result      := fVerErro(blnModoNovo);
  pFechaPortaImpressora;

  If Result Then
  Begin
    fAbrePortaImpressora;
    intRetorno  := EPSON_Fiscal_Fechar_Cupom(True,False);
    Result      := fVerErro(blnModoNovo);
    blnEmitindoCupom := False;
    pFechaPortaImpressora;
  End
  Else
    blnEmitindoCupom := False;

end;

function TEpson.fFechaRelatorioGerencial(blnVerErro: Boolean = True): Boolean;
begin
  fAbrePortaImpressora;
  intRetorno := EPSON_NaoFiscal_Fechar_Relatorio_Gerencial(True);
  Result     := fVerErro(blnModoNovo);
  blnEmitindoCupom := False;
  pFechaPortaImpressora;
end;

function TEpson.fGerarSintegra(blnApenas75: Boolean; strArquivo, strMes, strAno,
  strRazSoc, strEndere, strNumEnd, strComple, strBairro, strCidade, strNumCep,
  strFone01, strNumFax, strContat: String): Boolean;
begin
  //Não precisa mais, agora qdo homologa o PDV, o autsi gera o sintegra.
  Result := true;
end;

function TEpson.fGrandeTotal: Double;
  Var
    arrRet: Array[0..19] Of AnsiChar;
    strRet: String;
begin
  FillChar(arrRet, 19, #0);
  fAbrePortaImpressora;
  EPSON_Obter_GT(arrRet);
  pFechaPortaImpressora;
  SetString(strRet, arrRet, 19);
  Result := fStrToFloat(strRet) / 100;
end;

function TEpson.fHoraEcf: TDateTime;
  {Var
    arrRet: Array[0..14] Of AnsiChar;
    strRet: String;
    strHora: String;}
begin
  {FillChar(arrRet, 15, #0);
  fAbrePortaImpressora('TEpson.fHoraEcf');
  EPSON_Obter_Hora_Relogio(arrRet);
  pFechaPortaImpressora;
  SetString(strRet, arrRet, 15);

  strHora := RightStr(trim(strRet), 6);
  Result := fHoraEpsonToTime(strHora);}

  Result := fTime();
end;

function TEpson.fHoraEpsonToTime(str: String): TDateTime;
begin
  Result := StrToTime(LeftStr(str, 2) + ':' + Copy(str, 3, 2) + ':' + RightStr(str, 2));
end;

function TEpson.fHoraGravacaoSoftwareBasico: TDateTime;
  Var
    strVersao: String;
    dtaData: TDateTime;
begin
  pDadosSoftwareBasico(strVersao, dtaData, Result);
end;

function TEpson.fImpLinFiscal(strAtrib, strLinha: String): Boolean;
begin
  Result := True;
end;

function TEpson.fLeituraX(strParam: String; blnPergunta: Boolean): Boolean;
begin
  fAbrePortaImpressora;
  intRetorno  := EPSON_RelatorioFiscal_LeituraX;
  Result      := fVerErro(blnModoNovo);
  pFechaPortaImpressora;
end;

function TEpson.fMarcaECF: String;
begin
  Result := 'EPSON';
end;

function TEpson.fMFDAdicional: String;
begin
  Result := ' ';
end;

function TEpson.fModeloEcf: String;
begin
  Result := Copy(fDadosImpressora, 61, 20);
end;

function TEpson.fNumeroCaixa: String;
  Var
    ansiRet: AnsiString;
begin
  fAbrePortaImpressora;

  ansiRet := AnsiString(StringOfChar(' ', 8));
  EPSON_Obter_Numero_ECF_Loja(PAnsiChar(ansiRet));

  pFechaPortaImpressora;

  Result := String(LeftStr(ansiRet, 3));
end;

function TEpson.fNumeroCCF: String;
begin
  Result := Copy(fRetContadores, 43, 6);
end;

function TEpson.fNumeroCDC: String;
begin
  Result := Copy(fRetContadores, 25, 6);
end;

function TEpson.fNumeroCNPJUsuario: String;
begin
  Result := LeftStr(fDadosUsuario, 18);
end;

function TEpson.fNumeroGNF: String;
begin
  Result := Copy(fRetContadores, 19, 6);
end;

function TEpson.fNumeroGRG: String;
begin
  Result := Copy(fRetContadores, 37, 6);
end;

function TEpson.fNumeroIEUsuario: String;
begin
  Result := Copy(fDadosUsuario, 19, 15);
end;

function TEpson.fNumeroSerie: String;
begin
  Result := FNumSer;
end;

function TEpson.fNumeroSerieInt: String;
begin
  Result := LeftStr(fDadosImpressora,20);
end;

function TEpson.fNumeroUsuario: String;
  Var
    ansiValor: AnsiString;
begin
  fAbrePortaImpressora;
  ansiValor := AnsiString(StringOfChar(' ', 2));
  intRetorno := EPSON_Obter_Numero_Usuario(PAnsiChar(ansiValor));
  Result := String(ansiValor);
  pFechaPortaImpressora;
end;

function TEpson.fReducaoZ(strData, strHora: String): Boolean;
  Var
    ansiNumRed: AnsiString;
    ansiData  : AnsiString;
    ansiHora  : AnsiString;
    strDtaHor : String;
begin
  ansiNumRed := AnsiString(StringOfChar(' ', 5));

  ansiData := AnsiString(strData);
  ansiHora := AnsiString(strHora);

  If Not fEmptyStr(String(ansiData)) Then
  Begin
    strDtaHor := AnsiReplaceStr(String(ansiData), '/', '');
    ansiData  := AnsiString(strDtaHor);
    strDtaHor := AnsiReplaceStr(String(ansiHora), ':', '');
    ansiHora  := AnsiString(strDtaHor);
  End;

  fAbrePortaImpressora;
  intRetorno  := EPSON_RelatorioFiscal_RZ(PAnsiChar(ansiData),PAnsiChar(ansiHora),3,PAnsiChar(ansiNumRed));
  Result      := fVerErro(blnModoNovo);
  pFechaPortaImpressora;
end;

function TEpson.fRegistraAcrDes(strAcrDes, strTip_AC, strVal_AC: String; fltTotal, fltTotImp: Double): Boolean;
Var
  ansiVal_AC: AnsiString;
begin

  If fStrToFloat(strVal_AC)<> 0 Then
  Begin
    strVal_AC  := AnsiReplaceStr(FloatToStrF(fStrToFloat(strVal_AC), ffNumber, 12, 2), ',', '');
    ansiVal_AC := AnsiString(strVal_AC);

    fAbrePortaImpressora;
    intRetorno  := EPSON_Fiscal_Desconto_Acrescimo_Subtotal(PAnsiChar(ansiVal_AC), 2, IIF(strAcrDes = 'D', True, False), False);
    Result      := fVerErro(blnModoNovo);
    pFechaPortaImpressora;
  End
  Else
    Result := True;

end;

function TEpson.fRegistraItem(strCodIte, strDesIte, strUnidad: String; fltAlqIcm, fltQtdIte, fltUnitar: Double; strCodFis: String;
  fltDesEsp: Double; fltTotal: Double = 0): Boolean;
  Var
    strAlqIcm: String;
begin
  strAlqIcm := '';

  If Not fEmptyStr(strCodFis) Then
    strAlqIcm := fCalcAliquota(strCodFis, fltAlqIcm, 1);

  Result := fRegistraItem(strCodIte, strDesIte, strUnidad, strAlqIcm, fltQtdIte, fltUnitar, strCodFis, fltDesEsp);
end;

function TEpson.fRegistraModalidades(strCodMod, strDesMod: String; fltValMod: Double; strInfAdi: String): Boolean;
  Var
    strValor : String;
    strInfAd1: String;
    strInfAd2: String;

    ansiCodMod: AnsiString;
    ansiValor : AnsiString;
    ansiInfAd1: AnsiString;
    ansiInfAd2: AnsiString;

begin
  strValor := AnsiReplaceStr(FloatToStrF(fltValMod, ffFixed, 13, 2), ',', '');

  strInfAd1 := fPadR(Copy(strInfAdi,01,40), 40);
  strInfAd2 := fPadR(Copy(strInfAdi,40,40), 40);
  fAbrePortaImpressora;

  ansiCodMod := AnsiString(strCodMod);
  ansiValor  := AnsiString(strValor);
  ansiInfAd1 := AnsiString(strInfAd1);
  ansiInfAd2 := AnsiString(strInfAd2);

  intRetorno  := EPSON_Fiscal_Pagamento(PAnsiChar(ansiCodMod), PAnsiChar(ansiValor), 2, PAnsiChar(ansiInfAd1), PAnsiChar(ansiInfAd2));

  Result      := fVerErro(blnModoNovo);

  pFechaPortaImpressora;

end;

function TEpson.fAbreRelatorioGerencial(blnMostrarErro: Boolean): Boolean;
Var
  ansiNumGer: AnsiString;
begin
  ansiNumGer := AnsiString('01');

  fAbrePortaImpressora;
  blnEmitindoCupom := True;
  intRetorno  := EPSON_NaoFiscal_Abrir_Relatorio_Gerencial(PAnsiChar(ansiNumGer));
  Result := fVerErro(blnMostrarErro);
  pFechaPortaImpressora;
end;

function TEpson.fRelatorioGerencial(strTexto: String): Boolean;
Begin
  Result := fUsaCNFVinculado(strTexto);
end;

function TEpson.fUsaCNFVinculado(strTexto: String): Boolean;
  Var
    ansiTexto: AnsiString;
begin
  blnExcedeuLinhasDocumento := False;
  ansiTexto := AnsiString(strTexto);
  fAbrePortaImpressora;
  intRetorno := EPSON_NaoFiscal_Imprimir_LinhaEX(PAnsiChar(ansiTexto));
  Result := fVerErro;
  pFechaPortaImpressora;
end;

{***********************************************************}
{* ESSE MÉTODO ESTÁ CHAMANDO UMA FNC QUE RETORNA DIVERSAS  *}
{* INFORMAÇÕES QUE SÃO ELAS:                               *}
{*                                                         *}
{* COO CRZ CRO GNF CDC NFC GRG CCF CFC CFD DFI NCN UCF CLX *}
{***********************************************************}
{* COO - Contador de Odem de Operação                      *}
{* CRZ - Contador de Redução Z                             *}
{* CRO - Contador de Reinício de Operação                  *}
{* GNF - Contador Geral Não Fiscal                         *}
{* CDC - Contador de Cupom de Débito/Crédito               *}
{* NFC - Contador de Cupom Não-Fiscal                      *}
{* GRG - Contagor Geral de Relatório Gerencial             *}
{* CCF - Contador de Cupom Fiscal                          *}
{* CFC - Contador de Cupom Fiscal Cancelado                *}
{* CFD - Contador de Fita Detalhe                          *}
{* DFI - Contador de Documentos Fiscais                    *}
{* NCN - Número de Comp. de Crédito/Débito não emitidos    *}
{* UCF - COO do Último Cupom Fiscal                        *}
{* CLX - Contador de Leitura X                             *}
{********************************************************AF*}
function TEpson.fRetornaCoo: String;
begin
  Result := LeftStr(fRetContadores,6);
end;

function TEpson.fRetContadores: String;
  Var
    ansiContadores: AnsiString;
begin
  ansiContadores := AnsiString(StringOfChar(' ', 85));
  fAbrePortaImpressora;
  intRetorno := EPSON_Obter_Contadores(PAnsiChar(ansiContadores));
  Result := String(ansiContadores);
  pFechaPortaImpressora;
end;

function TEpson.fSangria(fltValor: Double): Boolean;
  Var
    strVal: String;
    ansiVal: AnsiString;
begin
  strVal  := AnsiReplaceStr(FloatToStrF(fltValor, ffNumber, 11, 2), ',', '');
  ansiVal := AnsiString(strVal);

  fAbrePortaImpressora;
  intRetorno := EPSON_NaoFiscal_Sangria(PAnsiChar(ansiVal), 2);
  Result := fVerErro(True);
  pFechaPortaImpressora;
end;

function TEpson.fStatusImpressora: String;
begin
  Result := '1';
end;

function TEpson.fSuprimento(fltValor: Double; strModalidade: String): Boolean;
  Var
    strVal : String;
    ansiVal: AnsiString;
begin
  strVal  := AnsiReplaceStr(FloatToStrF(fltValor, ffNumber, 11, 2), ',', '');
  ansiVal := AnsiString(strVal);

  fAbrePortaImpressora;
  intRetorno := EPSON_NaoFiscal_Fundo_Troco(PAnsiChar(ansiVal), 2);
  Result := fVerErro(True);
  pFechaPortaImpressora;
end;

function TEpson.fTipoECF: String;
begin
  Result := 'ECF-IF';
end;

function TEpson.fUltimoComandoComErro: Boolean;
begin
  Result := False;
end;

function TEpson.fUltimoItemVendido: String;
  Var
    ansiUltIte: AnsiString;
begin
  ansiUltIte := AnsiString(StringOfChar(' ', 4));
  fAbrePortaImpressora;
  EPSON_Obter_Numero_Ultimo_Item(PAnsiChar(ansiUltIte));
  Result := String(ansiUltIte);
  pFechaPortaImpressora;
end;

function TEpson.fVendaBruta: Double;
  Var
    ansiRetAnt: AnsiString;
    ansiRet    : AnsiString;
begin

  ansiRet    := AnsiString(StringOfChar(' ', 15));
  ansiRetAnt := AnsiString(StringOfChar(' ', 15));

  fAbrePortaImpressora;
  EPSON_Obter_Venda_Bruta(PAnsiChar(ansiRet), PAnsiChar(ansiRetAnt));
  Result := fFormataFloat(fStrToFloat(String(ansiRet)) / 100, 2);
  pFechaPortaImpressora;
end;

function TEpson.fVerErro(blnMostraErro: Boolean): Boolean;
  Var
    strMen: String;
begin

  Result := True;
  strMen := fRetMensErro;
  If (Not fEmptyStr(strMen)) And (blnMostraErro) Then
  Begin
    fMensagem('', strMen, ['&Ok']);
    blnEmitindoCupom := False;
    Result           := False;
  End;

end;

function TEpson.fVerificaCupomAberto: Boolean;
  var
    ansiEstado: AnsiString;
begin
  ansiEstado := AnsiString(StringOfChar(' ', 57));
  fAbrePortaImpressora;
  EPSON_Obter_Estado_Cupom(PAnsiChar(ansiEstado));
  pFechaPortaImpressora;

  If Copy(ansiEstado, 1, 2) = '01' Then
    Result:=True
  Else
    Result:=False;
end;

function TEpson.fVersaoSoftwareBasico: String;
  Var
    dtaData: TDateTime;
    dtaHora: TDateTime;
begin
  pDadosSoftwareBasico(Result, dtaData, dtaHora);
end;

function TEpson.fRetMensErro: String;
  Var
    intST3: Integer;
    intST4: Integer;
    intST5: Integer;
    intRet: Integer;
    ansiRet: AnsiString;
    ST1err: String;
    ST1field: String;
    ST2     : String;
    ST3     : String;
    ST4     : String;
    ST5     : String;
    flagB10 : Boolean;
    flagB11 : Boolean;
begin
  Result := '';

  ansiRet := AnsiString(StringOfChar(' ', 21));

  intRet := EPSON_Obter_Estado_Impressora(PAnsiChar(ansiRet));

  If intRet <> 0 Then
    Result := 'Erro ao tentar obter o estado da impressora!'
  Else
  begin

    If intRetorno <> 0 Then
    Begin

      ST1err   := String(Copy(ansiRet,1,2));
      ST1field := String(Copy(ansiRet,3,2));
      ST2 := String(Copy(ansiRet,5,4));
      ST3 := String(Copy(ansiRet,9,4));
      ST4 := String(Copy(ansiRet,13,4));
      ST5 := String(Copy(ansiRet,17,4));

      {********************************}
      {* PARÂMETROS DO ÚLTIMO COMANDO *}
      {*****************************AF*}
      Case StrToInt(ST1err) Of
        1: Result := 'Campo deve ser um ponteiro para string.';
        2: Result := 'String com data inválida.';
        3: Result := 'String com hora inválida.';
        4: Result := 'String não está vazia ou contém data inválida.';
        5: Result := 'String não está vazia ou contém hora inválida.';
        6: Result := 'String não pode ser vazia.';
      End;

      If StrToInt(ST1err) > 6 Then
        Result := 'Erro não mapeado.';

      If StrToInt(ST1err) <> 0 Then
        Result := Result + ' - Campo com erro: ' + ST1field;

      {**************************}
      {* ESTADO DA COMUNICAÇÃO  *}
      {***********************AF*}
      Case StrToInt('$' + ST2) Of
        1:  Result := 'Porta já está aberta.';
        2:  Result := 'Porta usada por outra aplicação.';
        4:  Result := 'Número de porta inválido.';
        5:  Result := 'Velocidade inválida.';
        16: Result := 'String não está vazia ou contém hora inválida.';
      end;

      If Not StrToInt('$' + ST2) In ([0,1,2,4,5,16]) Then
        Result := 'Erro interno da biblioteca.';

      {************************}
      {* ESTADO DA IMPRESSORA *}
      {*********************AF*}
      intST3  := StrToInt('$' + ST3);

      {************************}
      {* TRATAMENTO DO BIT 15 *}
      {************************}
      If (intST3 >= 32768) Then
      Begin
        Result := 'Impressora(Offline) - ';
        intST3 := intST3 - 32768;
      End;

      {************************}
      {* TRATAMENTO DO BIT 14 *}
      {************************}
      If (intST3 >= 16384) Then
      Begin
        Result := Result + 'Erro de impressão - ';
        intST3 := intST3 - 16384;
      End;

      {************************}
      {* TRATAMENTO DO BIT 13 *}
      {************************}
      If (intST3 >= 8192) Then
      Begin
        Result := Result + 'Tampa superior aberta - ';
        intST3 := intST3 - 8192;
      End;

      {************************}
      {* TRATAMENTO DO BIT 12 *}
      {************************}
      If (intST3 >= 4096) Then
      Begin
        Result := Result + 'Estado da gaveta = 1 - ';
        intST3 := intST3 - 4096;
      End;

      {******************************}
      {* TRATAMENTO DOS BITS 10 E 9 *}
      {******************************}
      If (intST3 >= 1024) Then
        intST3  := intST3 - 1024;

      If (intST3 >= 512) Then
        intST3  := intST3 - 512;

      {***********************}
      {* TRATAMENTO DO BIT 8 *}
      {***********************}
      If (intST3 >= 256) Then
      Begin
        Result := Result + 'Aguardando retirada do papel - ';
        intST3 := intST3 - 256;
      End;

      {***********************}
      {* TRATAMENTO DO BIT 7 *}
      {***********************}
      If (intST3 >= 128) Then
      Begin
        Result := Result + 'Aguardando inserção do papel - ';
        intST3 := intST3 - 128;
      End;

      {***********************}
      {* TRATAMENTO DO BIT 6 *}
      {***********************}
      If (intST3 >= 64) Then
      Begin
        Result := Result + 'Estado do sensor inferior da estação de cheque = 1 - ';
        intST3 := intST3 - 64;
      End;

      {***********************}
      {* TRATAMENTO DO BIT 5 *}
      {***********************}
      If (intST3 >= 32) Then
      Begin
        Result := Result + 'Estado do sensor superior da estação do cheque = 1 - ';
        intST3 := intST3 - 32;
      End;

      {***********************}
      {* TRATAMENTO DO BIT 4 *}
      {***********************}
      If (intST3 >= 16) Then
      Begin
        Result := Result + 'Estado do sensor de autenticação = 1 - ';
        intST3 := intST3 - 16;
      End;

      {***********************}
      {* TRATAMENTO DO BIT 3 *}
      {***********************}
      If (intST3 >= 8) Then
      Begin
        Result := Result + 'Sem papel - ';
        intST3 := intST3 - 8;
      End;

      {***********************}
      {* TRATAMENTO DO BIT 2 *}
      {***********************}
      If (intST3 >= 4) Then
      Begin
        //Result := Result + 'Pouco papel - ';
        intST3 := intST3 - 4;
      End;

      {***********************}
      {* TRATAMENTO DO BIT 1 *}
      {***********************}
      If (intST3 >= 2) Then
      Begin
        Result := Result + 'Sem papel - ';
        intST3 := intST3 - 2;
      End;

      {***********************}
      {* TRATAMENTO DO BIT 0 *}
      {***********************}
      If (intST3 >= 1) Then
      Begin
        //Result := Result + 'Pouco papel - ';
      End;

      {*****************}
      {* ESTADO FISCAL *}
      {**************AF*}
      flagB11 := False;
      flagB10 := False;

      intST4  := StrToInt('$' + ST4);
      {*******************************}
      {* TRATAMENTO DOS BITS 15 E 14 *}
      {*******************************}
      If (intST4 >= 32768) Then
        intST4 := intST4 - 32768;

      If (intST4 >= 16384) Then
        intST4 := intST4 - 16384;

      {*************************}
      {* TRATAMENTO DO BITS 12 *}
      {*************************}
      If (intST4 >= 4096) Then
      Begin
        Result := Result + 'Modo de Intervenção Técnica - ';
        intST4 := intST4 - 4096;
      End;

      {*******************************}
      {* TRATAMENTO DOS BITS 11 E 10 *}
      {*******************************}
      If (intST4 >= 2048) Then
      Begin
        flagB11 := True;
        intST4 := intST4 - 2048;
      End;

      If (intST4 >= 1024) Then
        flagB10 := True;

      If ((flagB11 = True) And (flagB10 = True)) Then Result := Result + 'Erro de leitura/escrita da Memória Fiscal - '
      Else If ((flagB11 = True)  And (flagB10 = False)) Then Result := Result + 'Memória Fiscal cheia - ';

      {*****************************************}
      {* ESTADO DE EXECUÇÃO DO ÚLTIMO COMANDO  *}
      {*****************************************}
      ST5    := UpperCase(ST5);
      intST5 := StrToInt('$' + ST5);

      If Not (ST5 = '0000') Then
      Begin
        Case intST5 of
          $0001: Result := Result + 'Erro interno';
          $0002: Result := Result + 'Erro de iniciação do equipamento';
          $0003: Result := Result + 'Erro de processo interno';
          $0101: Result := Result + 'Comando inválido para o estado atual. Verifique se há redução Z pendente.';
          $0102: Result := Result + 'Comando inválido para o documento atual';
          $0106: Result := Result + 'Comando aceito apenas fora de intervenção';
          $0107: Result := Result + 'Comando aceito apenas dentro de intervenção';
          $0108: Result := Result + 'Comando inválido durante processo de scan';
          $0109: Result := Result + 'Excesso de intervenções';
          $0201: Result := Result + 'Comando com frame inválido';
          $0202: Result := Result + 'Comando inválido';
          $0203: Result := Result + 'Campos em excesso';
          $0204: Result := Result + 'Campos em falta';
          $0205: Result := Result + 'Campo não opcional';
          $0206: Result := Result + 'Campo alfanumérico inválido';
          $0207: Result := Result + 'Campo alfabético inválido';
          $0208: Result := Result + 'Campo numérico inválido';
          $0209: Result := Result + 'Campo binário inválido';
          $020A: Result := Result + 'Campo imprimível inválido';
          $020B: Result := Result + 'Campo hexadecimal inválido';
          $020C: Result := Result + 'Campo data inválido';
          $020D: Result := Result + 'Campo hora inválido';
          $020E: Result := Result + 'Campo com atributos de impressão inválidos';
          $020F: Result := Result + 'Campo booleano inválido';
          $0210: Result := Result + 'Campo com tamanho inválido';
          $0211: Result := Result + 'Extensão de comando inválida';
          $0212: Result := Result + 'Código de barra não permitido';
          $0213: Result := Result + 'Atributos de impressão não permitidos';
          $0214: Result := Result + 'Atributos de impressão inválidos';
          $0215: Result := Result + 'Código de barras incorretamente definido';
          $0217: Result := Result + 'Comando invalido para a porta selecionada';
          $0301: Result := Result + 'Erro de hardware';
          $0302: Result := Result + 'Impressora não está pronta';
          $0303: Result := Result + 'Erro de Impressão';
          $0304: Result := Result + 'Falta de papel';
          $0305: Result := Result + 'Pouco papel disponível';
          $0306: Result := Result + 'Erro em carga ou expulsão do papel';
          $0307: Result := Result + 'Característica não suportada pela impressora';
          $0308: Result := Result + 'Erro de display';
          $0309: Result := Result + 'Seqüência de scan inválida';
          $300A: Result := Result + 'Número de área de recorte inválido';
          $300B: Result := Result + 'Scanner não preparado';
          $300C: Result := Result + 'Qualidade de Logotipo não suportada pela impressora';
          $030E: Result := Result + 'Erro de leitura do microcódigo';
          $0401: Result := Result + 'Número de série inválido';
          $0402: Result := Result + 'Requer dados de fiscalização já configurados';
          $0501: Result := Result + 'Data / Hora não configurada';
          $0502: Result := Result + 'Data inválida';
          $0503: Result := Result + 'Data em intervalo inválido';
          $0504: Result := Result + 'Nome operador inválido';
          $0505: Result := Result + 'Número de caixa inválido';
          $0508: Result := Result + 'Dados de Cabeçalho ou rodapé inválidos';
          $0509: Result := Result + 'Excesso de fiscalização';
          $500C: Result := Result + 'Número máximo de meios de pagamento já definidos';
          $050D: Result := Result + 'Meio de pagamento já definido';
          $050E: Result := Result + 'Meio de pagamento inválido';
          $050F: Result := Result + 'Descrição do meio de pagamento inválido';
          $0510: Result := Result + 'Valor máximo de desconto inválido';
          $0513: Result := Result + 'Logotipo do usuário inválido';
          $0514: Result := Result + 'Seqüência de logotipo inválido';
          $0515: Result := Result + 'Configuração de display inválida';
          $0516: Result := Result + 'Dados do MICR inválidos';
          $0517: Result := Result + 'Campo de endereço inválido';
          $0518: Result := Result + 'Nome da loja não definido';
          $0519: Result := Result + 'Dados fiscais não definidos';
          $510A: Result := Result + 'Número seqüencial do ECF inválido';
          $510B: Result := Result + 'Simbologia do GT inválida, devem ser todos diferentes';
          $510C: Result := Result + 'Número de CNPJ inválido';
          $051D: Result := Result + 'Senha de fiscalização inválida';
          $051E: Result := Result + 'Último documento deve ser uma redução Z';
          $051F: Result := Result + 'Símbolo da moeda igual ao atualmente cadastrado';
          $0520: Result := Result + 'Identificação da alíquota não cadastrada';
          $0521: Result := Result + 'Alíquota não cadastrada';
          $0601: Result := Result + 'Memória de Fita-detalhe esgotada';
          $0605: Result := Result + 'Número de série invalido para a Memória de Fita-detalhe';
          $0606: Result := Result + 'Memória de Fita-detalhe não iniciada';
          $0607: Result := Result + 'Memória de Fita-detalhe não pode estar iniciada';
          $0608: Result := Result + 'Número de série da Memória de Fita-detalhe não confere';
          $0609: Result := Result + 'Erro Interno na Memória de Fita-detalhe';
          $0701: Result := Result + 'Valor inválido para o número do registro';
          $0702: Result := Result + 'Valor inválido para o número do item';
          $0703: Result := Result + 'Intervalo inválido para a leitura da MFD';
          $0704: Result := Result + 'Número de usuário inválido para MFD';
          $0801: Result := Result + 'Comando inválido com jornada fiscal fechada';
          $0802: Result := Result + 'Comando inválido com jornada fiscal aberta';
          $0803: Result := Result + 'Memória Fiscal esgotada';
          $0804: Result := Result + 'Jornada fiscal deve ser fechada';
          $0805: Result := Result + 'Não há meios de pagamento definidos';
          $0806: Result := Result + 'Excesso de meios de pagamento utilizados na jornada fiscal';
          $0807: Result := Result + 'Jornada fiscal sem movimento de vendas';
          $0808: Result := Result + 'Intervalo de jornada fiscal inválido';
          $0809: Result := Result + 'Existem mais dados para serem lidos';
          $800A: Result := Result + 'Não existem mais dados para serem lidos';
          $800B: Result := Result + 'Não pode abrir jornada fiscal';
          $800C: Result := Result + 'Não pode fechar jornada fiscal';
          $080D: Result := Result + 'Limite máximo do período fiscal atingido';
          $080E: Result := Result + 'Limite máximo do período fiscal não atingido';
          $080F: Result := Result + 'Abertura da jornada fiscal não permitida';
          $0901: Result := Result + 'Valor muito grande';
          $0902: Result := Result + 'Valor muito pequeno';
          $0903: Result := Result + 'Itens em excesso';
          $0904: Result := Result + 'Alíquotas em excesso';
          $0905: Result := Result + 'Desconto ou acréscimos em excesso';
          $0906: Result := Result + 'Meios de pagamento em excesso';
          $0907: Result := Result + 'Item não encontrado';
          $0908: Result := Result + 'Meio de pagamento não encontrado';
          $0909: Result := Result + 'Total nulo';
          $900C: Result := Result + 'Tipo de pagamento não definido';
          $090F: Result := Result + 'Alíquota não encontrada';
          $0910: Result := Result + 'Alíquota inválida';
          $0911: Result := Result + 'Excesso de meios de pagamento com CDC';
          $0912: Result := Result + 'Meio de pagamento com CDC já emitido';
          $0913: Result := Result + 'Meio de pagamento com CDC ainda não emitido';
          $0914: Result := Result + 'Leitura da Memória Fiscal – intervalo CRZ inválido';
          $0915: Result := Result + 'Leitura da Memória Fiscal – intervalo de data inválido';
          $0A01: Result := Result + 'Operação não permitida após desconto / acréscimo';
          $0A02: Result := Result + 'Operação não permitida após registro de pagamentos';
          $0A03: Result := Result + 'Tipo de item inválido';
          $0A04: Result := Result + 'Linha de descrição em branco';
          $0A05: Result := Result + 'Quantidade muito pequena';
          $0A06: Result := Result + 'Quantidade muito grande';
          $0A07: Result := Result + 'Total do item com valor muito alto';
          $0A08: Result := Result + 'Operação não permitida antes do registro de pagamentos';
          $0A09: Result := Result + 'Registro de pagamento incompleto';
          $0A0A: Result := Result + 'Registro de pagamento finalizado';
          $0A0B: Result := Result + 'Valor pago inválido';
          $0A0C: Result := Result + 'Valor de desconto ou acréscimo não permitido';
          $0A0E: Result := Result + 'Valor não pode ser zero';
          $0A0F: Result := Result + 'Operação não permitida antes do registro de itens';
          $0A11: Result := Result + 'Cancelamento de desconto e acréscimo somente para item atual';
          $0A12: Result := Result + 'Não foi possível cancelar último Cupom Fiscal';
          $0A13: Result := Result + 'Último Cupom Fiscal não encontrado';
          $0A14: Result := Result + 'Último Comprovante Não-Fiscal não encontrado';
          $0A15: Result := Result + 'Cancelamento de CDC necessária';
          $0A16: Result := Result + 'Número de item em Cupom Fiscal inválido';
          $0A17: Result := Result + 'Operação somente permitida após subtotalização';
          $0A18: Result := Result + 'Operação somente permitida durante a venda de itens';
          $0A19: Result := Result + 'Operação não permitida em item com desconto ou acréscimo';
          $0A1A: Result := Result + 'Dígitos de quantidade inválidos';
          $0A1B: Result := Result + 'Dígitos de valor unitário inválido';
          $0A1C: Result := Result + 'Não há desconto ou acréscimo a cancelar';
          $0A1D: Result := Result + 'Não há item para cancelar';
          $0A1E: Result := Result + 'Desconto ou acréscimo somente no item atual';
          $0A1F: Result := Result + 'Desconto ou acréscimo já efetuado';
          $0A20: Result := Result + 'Desconto ou acréscimo nulo não permitido';
          $0A21: Result := Result + 'Valor unitário inválido';
          $0A22: Result := Result + 'Quantidade inválida';
          $0A23: Result := Result + 'Código de item inválido';
          $0A24: Result := Result + 'Descrição inválida';
          $0A25: Result := Result + 'Operação de desconto ou acréscimo não permitida';
          $0A26: Result := Result + 'Mensagem promocional já impressa';
          $0A27: Result := Result + 'Linhas adicionais não podem ser impressas';
          $0A28: Result := Result + 'Dados do consumidor já impresso';
          $0A29: Result := Result + 'Dados do consumidor somente no fim do documento';
          $0A2A: Result := Result + 'Dados do consumidor somente no inicio do documento';
          $0A2B: Result := Result + 'Comando Inválido para o item';
          $0E01:
          Begin
            blnExcedeuLinhasDocumento := True;
            Result := Result + 'Número de linhas em documento excedido';
          End;
          $0E02: Result := Result + 'Número do relatório inválido';
          $0E03: Result := Result + 'Operação não permitida após registro de itens';
          $0E04: Result := Result + 'Registro de valor nulo não permitido';
          $0E05: Result := Result + 'Não há desconto a cancelar';
          $0E06: Result := Result + 'Não há acréscimo a cancelar';
          $0E07: Result := Result + 'Operação somente permitida após subtotalização';
          $0E08: Result := Result + 'Operação somente permitida durante registro de itens';
          $0E09: Result := Result + 'Operação não-fiscal inválida';
          $0E0A: Result := Result + 'Último comprovante Não-Fiscal não encontrado';
          $0E0B: Result := Result + 'Meio de pagamento não encontrado';
          $0E0C: Result := Result + 'Não foi possível imprimir nova via';
          $0E0D: Result := Result + 'Não foi possível realizar reimpressão';
          $0E0E: Result := Result + 'Não foi possível imprimir nova parcela';
          $0E0F: Result := Result + 'Não há mais parcelas a imprimir';
          $0E10: Result := Result + 'Registro de item Não-Fiscal inválido';
          $0E11: Result := Result + 'Desconto ou acréscimo já efetuado';
          $0E12: Result := Result + 'Valor de desconto ou acréscimo inválido';
          $0E13: Result := Result + 'Não foi possível cancelar o item';
          $0E14: Result := Result + 'Itens em excesso';
          $0E15: Result := Result + 'Operação Não-Fiscal não cadastrada';
          $0E16: Result := Result + 'Excesso de relatórios / operações não-fiscais cadastradas';
          $0E17: Result := Result + 'Relatório não encontrado';
          $0E18: Result := Result + 'Comando não permitido';
          $0E19: Result := Result + 'Comando não permitido em operações não-fiscais para movimento de monetário';
          $0E1A: Result := Result + 'Comando permitido apenas em operações não-fiscais para movimento de monetário';
          $0E1B: Result := Result + 'Número de parcelas inválido para a emissão de CCD';
          $0E1C: Result := Result + 'Operação não fiscal já cadastrada';
          $0E1D: Result := Result + 'Relatório gerencial já cadastrado';
          $0E1E: Result := Result + 'Relatório Gerencial Inválido';
          $3001: Result := Result + 'Configuração de cheque não registrada';
          $3002: Result := Result + 'Configuração de cheque não encontrada';
          $3003: Result := Result + 'Valor do cheque já impresso';
          $3004: Result := Result + 'Nominal ao cheque já impresso';
          $3005: Result := Result + 'Linhas adicionais no cheque já impresso';
          $3006: Result := Result + 'Autenticação já impressa';
          $3007: Result := Result + 'Número máximo de autenticações já impresso';
          Else   Result := Result + 'Erro desconhecido';
        End;

      End;

    End;
  End;
end;

procedure TEpson.pDadosSoftwareBasico(var strVersao: String; var dtaData,
  dtaHora: TDateTime);
  Var
    ansiVersao: AnsiString;
    ansiData  : AnsiString;
    ansiHora  : AnsiString;
begin

  ansiVersao := AnsiString(StringOfChar(' ', 8));
  ansiData   := AnsiString(StringOfChar(' ', 8));
  ansiHora   := AnsiString(StringOfChar(' ', 6));

  fAbrePortaImpressora;
  EPSON_Obter_Versao_SWBasicoEX(PAnsiChar(ansiVersao), PAnsiChar(ansiData), PAnsiChar(ansiHora));
  pFechaPortaImpressora;

  dtaData := fDataEpsonToDate(String(ansiData));
  dtaHora := fHoraEpsonToTime(String(ansiHora));
end;

procedure TEpson.pFechaPortaImpressora;
begin
  inherited;
  If blnEmitindoCupom Then
    Exit;

  intRetorno  := EPSON_Serial_Fechar_Porta;
end;

procedure TEpson.pPausaLeitura;
begin
  inherited;

end;

function TEpson.fLeituraMemFiscal(strParIni, strParFin: String; intTipLei: Integer): Boolean;
  Var
    strBuffer: String;
    intBuffer: Integer;
    ansiParIni: AnsiString;
    ansiParFin: AnsiString;
    ansiBuffer: AnsiString;
    ansiSaida : AnsiString;
begin

  If intTipLei = 1 Then
  Begin
    strParIni := FormatDateTime('ddmmyyyy', StrToDate(strParIni));
    strParFin := FormatDateTime('ddmmyyyy', StrToDate(strParFin));
  End;

  SetLength(strBuffer, 10000);
  intBuffer := 0;

  ansiParIni := AnsiString(strParIni);
  ansiParFin := AnsiString(strParFin);
  ansiBuffer := AnsiString(strBuffer);
  ansiSaida  := AnsiString('saida.txt');

  fAbrePortaImpressora;
  intRetorno := EPSON_RelatorioFiscal_Leitura_MF(PAnsiChar(ansiParIni), PAnsiChar(ansiParFin), intTipLei + 4, PAnsiChar(ansiBuffer), PAnsiChar(ansiSaida), @intBuffer, 10000);
  Result := fVerErro(blnModoNovo);
  pFechaPortaImpressora;

end;

function TEpson.fLeituraMemoriaFiscal(blnCompleta: Boolean; strTipoFiltro,
  strFiltroIni, strFiltroFin: String): Boolean;
  Var
    intTipoX: Integer;
    strBuffer: String;
    intBuffer: Integer;

    ansiFiltroIni: AnsiString;
    ansiFiltroFin: AnsiString;
    ansiBuffer   : AnsiString;
    ansiSaida    : AnsiString;
begin
  If (blnCompleta) Then
  Begin
    intTipoX := IIF(strTipoFiltro='D', 1, 0);
  End
  Else
  Begin
    intTipoX := IIF(strTipoFiltro='D', 3, 2);
  End;

  SetLength(strBuffer, 10000);
  intBuffer := 0;

  ansiFiltroIni := AnsiString(strFiltroIni);
  ansiFiltroFin := AnsiString(strFiltroFin);
  ansiBuffer    := AnsiString(strBuffer);
  ansiSaida     := AnsiString('saida.txt');

  fAbrePortaImpressora;
  intRetorno := EPSON_RelatorioFiscal_Leitura_MF(PAnsiChar(ansiFiltroIni), PAnsiChar(ansiFiltroFin), intTipoX + 4, PAnsiChar(ansiBuffer), PAnsiChar(ansiSaida), @intBuffer, 10000);
  Result := fVerErro(blnModoNovo);
  pFechaPortaImpressora;

end;

function TEpson.fRetParEcf: String;
  Var
    ansiRetorno: AnsiString;
begin
  ansiRetorno := AnsiString(StringOfChar(' ', 553));
  fAbrePortaImpressora;
  EPSON_Obter_Tabela_Aliquotas(PAnsiChar(ansiRetorno));
  Result := String(ansiRetorno);
  pFechaPortaImpressora;
end;

function TEpson.fRetParRdz: String;
  Var
    ansiDadosRed: AnsiString;
begin
  ansiDadosRed := AnsiString(StringOfChar(' ', 1168));
  fAbrePortaImpressora;
  intRetorno := EPSON_Obter_Dados_Ultima_RZ(PAnsiChar(ansiDadosRed));
  Result := String(ansiDadosRed);
  pFechaPortaImpressora;
end;

function TEpson.fRegistraItem(strCodIte, strDesIte, strUnidad, strAlqIcm: String;
  fltQtdIte, fltUnitar: Double; strCodFis: String; fltDesEsp: Double): Boolean;
  Var
    strQuanti: String;
    strUnitar: String;
    strQuantiVirg: String;
    strUnitarVirg: String;
    strVal : String;
    ansiVal: AnsiString;

    ansiCodIte: AnsiString;
    ansiDesIte: AnsiString;
    ansiQuanti: AnsiString;
    ansiUnidad: AnsiString;
    ansiUnitar: AnsiString;
    ansiAlqIcm: AnsiString;
    intDecUni : Integer;
begin
  intDecUni := 2;

  strQuantiVirg := FloatToStrF(fltQtdIte, ffFixed, 12, fCfgSis('DECQTD', varInteger));
  strUnitarVirg := FloatToStrF(fltUnitar, ffFixed, 12, intDecUni);

  strQuanti := AnsiReplaceStr(strQuantiVirg, ',', '');
  strUnitar := AnsiReplaceStr(strUnitarVirg, ',', '');

  pCalculaAcrDesItem(Self, fStrToFloat(strQuantiVirg), fStrToFloat(strUnitarVirg),
    fltQtdIte, fltUnitar, fltDesEsp, fltUltDesEspIte, fltUltAcrescIte);

  ansiCodIte := AnsiString(strCodIte);
  ansiDesIte := AnsiString(fPadR(strDesIte, 57));
  ansiQuanti := AnsiString(strQuanti);
  ansiUnidad := AnsiString(strUnidad);
  ansiUnitar := AnsiString(strUnitar);
  ansiAlqIcm := AnsiString(Trim(strAlqIcm));

  fAbrePortaImpressora;
  intRetorno  := EPSON_Fiscal_Vender_Item(PAnsiChar(ansiCodIte), PAnsiChar(ansiDesIte), PAnsiChar(ansiQuanti), fCfgSis('DECQTD', varInteger), PAnsiChar(ansiUnidad), PAnsiChar(ansiUnitar), intDecUni, PAnsiChar(ansiAlqIcm), 2);
  Result      := fVerErro(blnModoNovo);
  pFechaPortaImpressora;

  If fIsNumber(strAlqIcm) Then
    strUltIndiceTri := strAlqIcm
  Else
    strUltIndiceTri := LeftStr(strAlqIcm, 1);

  If Result Then
  Begin
    If (fFormataFloat(fltUltDesEspIte, 2) > 0) Then
    Begin
      strVal  := AnsiReplaceStr(FloatToStrF(fltUltDesEspIte, ffFixed, 12, 2), ',', '');
      ansiVal := AnsiString(strVal);

      fAbrePortaImpressora;
      intRetorno := EPSON_Fiscal_Desconto_Acrescimo_Item(PAnsiChar(ansiVal), 2, True, False);
      Result      := fVerErro(blnModoNovo);
      pFechaPortaImpressora;
    End
    Else If (fFormataFloat(fltUltAcrescIte, 2) > 0) Then
    Begin
      strVal  := AnsiReplaceStr(FloatToStrF(fltUltAcrescIte, ffFixed, 12, 2), ',', '');
      ansiVal := AnsiString(strVal);

      fAbrePortaImpressora;
      intRetorno := EPSON_Fiscal_Desconto_Acrescimo_Item(PAnsiChar(ansiVal), 2, False, False);
      Result      := fVerErro(blnModoNovo);
      pFechaPortaImpressora;
    End;
  End;
end;

function TEpson.fRetImpRdz: Boolean;

Const

  arrPosTotali: Array[1..13] Of Array[1..3] Of String = (
    ('I1'   , ''   , 'I'),
    ('N1'   , ''   , 'N'),
    ('F1'   , ''   , 'F'),
    ('IS1'  , ''   , 'IS'),
    ('NS1'  , ''   , 'NS'),
    ('FS1'  , ''   , 'FS'),
    ('DT'   , '156', 'DT'),
    ('DS'   , '173', 'DS'),
    ('AT'   , '207', 'AT'),
    ('AS'   , '223', 'AS'),
    ('Can-T', '105', 'Can-T'),
    ('Can-S', '122', 'Can-S'),
    ('OPNF' , '818', 'OPNF')
  );


var
  drzDadosRed: TDadosReducao;
  ansiDadosRed: AnsiString;

  ansiDtaMov: AnsiString;
  ansiAlqIcm: AnsiString;
  ansiValIcm: AnsiString;

  intConta    : Integer;
  intPosAlqIcm: Integer;
  intPosValIcm: Integer;
  intTamMat   : Integer;
  intContador : Integer;
  intPosAlqIni: Integer;
  intQtdCarAlq: Integer;
  intPosValIni: Integer;
  intQtdCarVal: Integer;
  intPosiOPNF : Integer;
  intContOPNF : Integer;

  ansiLisAlq: ansiString;
  ansiLisVal: ansiString;

  function fRetValorAliquotas(ansiAliquota: AnsiString): String;
  Var
    blnAchou   : Boolean;
    ansiAlqAtu : AnsiString;
    intContador: Integer;
    intPosAlq  : Integer;
  Begin
    Result := '';

    intContador := 1;
    intPosAlq   := 1;
    blnAchou    := False;

    While (intContador <= 24) Do  //quantidade de alíquotas possíveis
    Begin
      ansiAlqAtu := Copy(ansiLisAlq, intContador, 5);

      If (Pos(ansiAliquota, ansiAlqAtu) > 0) Then
      Begin
        blnAchou := True;
        Break;
      End;

      Inc(intContador, 5);
      Inc(intPosAlq);
    End;

    If (blnAchou) Then
    Begin
      Result := String(Copy(ansiLisVal, (1 + (17 * (intPosAlq - 1))), 17));
    End;

  End;

begin
  fAbrePortaImpressora;

  intPosAlqIni := 258;
  intQtdCarAlq := 120;
  intPosValIni := 384;
  intQtdCarVal := 408;

  ansiDadosRed := AnsiString(StringOfChar(' ', 1168));
  intRetorno   := EPSON_Obter_Dados_Ultima_RZ(PAnsiChar(ansiDadosRed));
  Result       := fVerErro(blnModoNovo);

  pFechaPortaImpressora;

  If (Not Result) Then
    Exit;

  ansiLisAlq := Copy(ansiDadosRed, intPosAlqIni, intQtdCarAlq);
  ansiLisVal := Copy(ansiDadosRed, intPosValIni, intQtdCarVal);

  intConta     := 1;
  intPosAlqIcm := 258;
  intPosValIcm := 384;

  Try

    ansiDtaMov := Copy(ansiDadosRed, 1160, 08);
    Insert('/', ansiDtaMov, 3);
    Insert('/', ansiDtaMov, 6);

    drzDadosRed.strNumCrz   := Copy(String(ansiDadosRed), 0027, 06);
    drzDadosRed.strNumCOORZ := Copy(String(ansiDadosRed), 0021, 06);
    drzDadosRed.strNumCRO   := Copy(String(ansiDadosRed), 0033, 06);
    drzDadosRed.dtaDtaMov   := StrToDate(String(ansiDtaMov));
    SetLength(drzDadosRed.arrTotali, 0);

    {*****************************************}
    {* PEGA OS DADOS DA TRIBUTAÇÃO           *}
    {**************************************MV*}
    ansiAlqIcm := Copy(ansiDadosRed, intPosAlqIcm, 05);
    ansiValIcm := Copy(ansiDadosRed, intPosValIcm, 17);

    While (Pos('T', String(ansiAlqIcm)) > 0) Do
    Begin

      intTamMat := Length(drzDadosRed.arrTotali);
      SetLength(drzDadosRed.arrTotali, intTamMat+1);

      drzDadosRed.arrTotali[intTamMat].strCodTot := fStrZero(intConta, 02) + String(ansiAlqIcm);
      drzDadosRed.arrTotali[intTamMat].fltValAcu := fStrToFloat(String(ansiValIcm)) / 100;

      Inc(intPosAlqIcm, 05);
      Inc(intPosValIcm, 17);
      Inc(intConta);

      ansiAlqIcm := Copy(ansiDadosRed, intPosAlqIcm, 05);
      ansiValIcm := Copy(ansiDadosRed, intPosValIcm, 17);
    End;

    For intContador := Low(arrPosTotali) To High(arrPosTotali) Do
    Begin

      intTamMat := Length(drzDadosRed.arrTotali);
      SetLength(drzDadosRed.arrTotali, intTamMat+1);

      If (arrPosTotali[intContador][1] <> 'OPNF') Then
      Begin
        If (fEmptyStr(arrPosTotali[intContador][2])) Then
          ansiValIcm := AnsiString(String(fRetValorAliquotas(AnsiString(arrPosTotali[intContador][3]))))
        Else
          ansiValIcm := Copy(ansiDadosRed, StrToInt(arrPosTotali[intContador][2]), 17);

        drzDadosRed.arrTotali[intTamMat].strCodTot := arrPosTotali[intContador][1];
        drzDadosRed.arrTotali[intTamMat].fltValAcu := fStrToFloat(String(ansiValIcm)) / 100;

      End
      Else
      Begin
        intPosiOPNF := StrToInt(arrPosTotali[intContador][2]);

        drzDadosRed.arrTotali[intTamMat].strCodTot := arrPosTotali[intContador][1];

        For intContOPNF := 1 To 20 Do
        Begin
          ansiValIcm := Copy(ansiDadosRed, intPosiOPNF, 13);
          drzDadosRed.arrTotali[intTamMat].fltValAcu := drzDadosRed.arrTotali[intTamMat].fltValAcu + fStrToFloat(String(ansiValIcm)) / 100;
          Inc(intPosiOPNF, 17);
        End;

      End;
    End;

    pCriarFormularios(TfrmObservacao, frmObservacao);
    frmObservacao.memObs.Lines.add('CRZ:' + drzDadosRed.strNumCrz);
    frmObservacao.memObs.Lines.add('COORZ:' + drzDadosRed.strNumCOORZ);
    frmObservacao.memObs.Lines.add('CRO:' + drzDadosRed.strNumCRO);
    frmObservacao.memObs.Lines.add('DATA MOV:' + FORMATDATETIME('DD/MM/YYYY',  drzDadosRed.dtaDtaMov));

    For intContador := Low(drzDadosRed.arrTotali) To High(drzDadosRed.arrTotali) Do
    Begin
      frmObservacao.memObs.Lines.add(drzDadosRed.arrTotali[intContador].strCodTot + ':' + FormatFloat('#,##0.00', drzDadosRed.arrTotali[intContador].fltValAcu));
    End;

    frmObservacao.ShowModal;
    pFreeAndNil(frmObservacao);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fDadosUltimaReducao]');
    End;
  End;

end;

end.
