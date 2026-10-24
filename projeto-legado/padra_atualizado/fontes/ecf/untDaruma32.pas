{**************************************************}
{* UNIT COM AS FUNCOES DO ECF (IMPRESSORA FISCAL) *}
{*                                                *}
{* MODELO....: (GENERICA)                         *}
{* DATA......: 27/02/2007                         *}
{* AUTOR.....: MARCOS VINÍCIUS DA SILVA           *}
{*                                                *}
{***********************************************MA*}
unit untDaruma32;

interface

Uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StrUtils, Uni, untFiscal, Math, untTypesSistema;

Type
  TarrFormasPagto = Array of String[16];

  TDaruma32 = class(TFiscal)

  private
    FVersaoSB: String;
    FDataGravacaoSB: TDateTime;
    FHoraGravacaoSB: TDateTime;
    FNumCaixa: String;
    FCNPJ: String;
    FIE: String;

    FCodRet : Integer;
    FMsgFechamento: String;

    blnUltComandoErro: Boolean;    

    procedure pCarregaDataHoraGravSB;
  public

    arrNomesFormasPagto: TarrFormasPagto;

    procedure pPausaLeitura; override;

    function fTipoECF: String; override;
    function fMarcaECF: String; override;
    function fModeloEcf: String; override;
    function fNumeroCCF: String; override;
    function fRetornaCOO: String; override;
    function fGrandeTotal: Double; override;
    function fVendaBruta: Double; override;   
    function fNumeroUsuario: String; override;
    function fNumeroCNPJUsuario: String; override;
    function fNumeroCaixa: String; override;
    function fNumeroIEUsuario: String; override;
    function fVersaoSoftwareBasico: String; override;
    function fDataEcf: TDateTime; override;
    function fHoraEcf: TDateTime; override;       
    function fDataGravacaoSoftwareBasico: TDateTime; override;
    function fHoraGravacaoSoftwareBasico: TDateTime; override;

    function fUltimoComandoComErro: Boolean; override;

    function fNumeroGNF: String; override;
    function fNumeroGRG: String; override;
    function fNumeroCDC: String; override;

    function fSangria(fltValor: Double): Boolean; override;
    function fSuprimento(fltValor: Double; strModalidade: String='Dinheiro'): Boolean; override;              

    function fRetTotalImpressora(fltQtdIte, fltUnitar: Double): Double; override;          

    function fInicia: Integer;
    function fFinaliza: Integer;
    function fRetorno( Var ACK: Integer; Var ST1: Integer; Var ST2: Integer ): Integer;
    function fVerErro(blnMostraErro: Boolean = True): Boolean; Override;

    function fLeituraX(strParam: String = 'N'; blnPergunta: Boolean = True): Boolean; Override;
    function fReducaoZ(strData, strHora: String): Boolean; Override;
    function fAbreGaveta: Boolean; override;
    function fStatusImpressora: String; Override;
    function fAbreCupom: Boolean; override;
    function fRegistraItem(strCodIte, strDesIte, strUnidad: String;
      fltAlqIcm, fltQtdIte, fltUnitar: Double; strCodFis: String; fltDesEsp: Double; fltTotal: Double = 0): Boolean;Overload; Override;
    function fCancelaItem(strItem: String): Boolean; Override;
    function fCancelaCupom: Boolean; Override;
    function fRegistraAcrDes(strAcrDes, strTip_AC, strVal_AC: String; fltTotal, fltTotImp: Double): Boolean; Override;
    function fRegistraModalidades(strCodMod, strDesMod: String; fltValMod: Double; strInfAdi: String): Boolean; Override;
    function fFechaCupom: Boolean; override;
    function fNumeroSerie: String; Override;
    function fCalcAliquota(strCodFiscal: String; fltAliquota: Double; intTipRet: Integer = 1): String; Override;

    function fAbreCNFVinculado(strDesFormaPgto, strValor, strNumCupom: String; strQtdPar: String = ''): Boolean; Override;
    function fFechaCNFVinculado(blnMostrarErro: Boolean = True): Boolean; override;
    function fUsaCNFVinculado(strTexto: String): Boolean; override;
    function fAbreRelatorioGerencial(blnMostrarErro: Boolean = True): Boolean; override;    
    function fRelatorioGerencial(strTexto: String): Boolean; override;
    function fFechaRelatorioGerencial(blnMostrarErro: Boolean = True): Boolean; override;

    function fImpLinFiscal(strAtrib, strLinha: String): Boolean; Override;
    function fAbrePortaImpressora: Boolean; Override;
    function fexecutaCMD(strCmd: String; blnRetorna: Boolean = False): String; Override;
    procedure pFechaPortaImpressora; Override;

    function fDadosUltimaReducao(Var drzDadosRed: TDadosReducao): Boolean; override;

    function fLeituraMemoriaFiscal(blnCompleta: Boolean; strTipoFiltro, strFiltroIni, strFiltroFin: String): Boolean; override;
    function fEspelhoMFD(strTipoFiltro, strFiltroIni, strFiltroFin, strArquivoSaida: String): Boolean; override;
    function fArquivoMFD(strDataIni, strDataFin, strArquivoSaida, strRazSocEmp, strEndereEmp: String): Boolean; override;

    function fGerarSintegra(blnApenas75: Boolean; strArquivo, strMes, strAno,
      strRazSoc, strEndere, strNumEnd, strComple, strBairro, strCidade,
      strNumCep, strFone01, strNumFax, strContat: String): Boolean; override;

    function fVerificaCupomAberto: Boolean; override;

    constructor Create(Owner: TComponent); Reintroduce;

    {**************************************************************}
    {* Funções abaixo foram declaradas para correção dos warnings *}
    {*                                                            *}
    {* DATA......: 16/07/2014                                     *}
    {* AUTOR.....: Marcelo Fagundes                               *}
    {*                                                            *}
    {***********************************************************MF*}

    function fEspacoEntreLinhas(intEspacos: Integer): Boolean; Override;
    function fUltimoItemVendido: String; Override;
    function fMFDAdicional: String; Override;
  End;

Var
  Handle : THandle;
  strDllDaruma  : String;

  Daruma_FI_RetornaErroExtendido: function(ErroExtendido: String): Integer; stdCall;
  Daruma_FI_LeituraX: function(): Integer; StdCall;
  Daruma_FI_ReducaoZ: function(Data: String; Hora: String): Integer; StdCall;
  Daruma_FI_AcionaGaveta: function(): Integer; StdCall;
  Daruma_FI_RelatorioGerencial: function(Texto: String): Integer; StdCall;
  Daruma_FI_FechaRelatorioGerencial: function(): Integer; stdcall;
  Daruma_FI_UsaComprovanteNaoFiscalVinculado: function(cTexto: PChar): Integer; StdCall;
  Daruma_FI_AbreComprovanteNaoFiscalVinculado: function(cDesFormaPgto, cValor, cNumCupom: PChar): Integer; StdCall;
  Daruma_FI_FechaComprovanteNaoFiscalVinculado: function(): Integer; StdCall;
  Daruma_FI_RetornoImpressora: function(Var ACK: Integer; Var ST1: Integer; Var ST2: Integer): Integer; StdCall;
  Daruma_FI_VerificaImpressoraLigada: function(): Integer; StdCall;
  Daruma_FI_AbreCupom: function(CGC_CPF: Pchar): Integer; StdCall;
  Daruma_FI_AumentaDescricaoItem: function(Descricao: String): Integer; StdCall;
  Daruma_FI_VendeItem: function(Codigo: String; Descricao: String; Aliquota: String; TipoQuantidade: String; Quantidade: String; CasasDecimais: Integer; ValorUnitario: String; TipoDesconto: String; Desconto: String): Integer; StdCall;
  Daruma_FI_CancelaItemGenerico: function(strItem: String): Integer; StdCall;  
  Daruma_FI_IniciaFechamentoCupom: function(AcrescimoDesconto: String; TipoAcrescimoDesconto: String; ValorAcrescimoDesconto: String): Integer; StdCall;
  Daruma_FI_EfetuaFormaPagamento: function(DescricaoFormaPagamento: String; ValorFormaPagamento: String): Integer; StdCall;
  Daruma_FI_TerminaFechamentoCupom: function(Mensagem: String): Integer; StdCall;
  Daruma_FI_RetornoAliquotas: function(Aliquotas: String): Integer; StdCall;
  Daruma_FI_CancelaCupom: function(): Integer; StdCall;
  Daruma_FI_LeituraMemoriaFiscalData: function(DataInicial: String; DataFinal: String): Integer; StdCall;
  Daruma_FI_LeituraMemoriaFiscalReducao: function(ReducaoInicial: String; ReducaoFinal: String): Integer; StdCall;
  Daruma_FI_ProgramaFormasPagamento: function(FormaPagto: String): Integer; StdCall;
  Daruma_FI_VerificaFormasPagamentoEx: function(FormasPagamento: String): Integer; StdCall;
  Daruma_FI_NumeroSerie: function(strNumSer: String): Integer; StdCall;
  Daruma_FI_NumeroCupom: function(strNumCoo: String): Integer; StdCall;
  Daruma_FI_LerAliquotasComIndice: function(AliquotasComIndice: String): Integer; StdCall;
  Daruma_FI_VerificaModeloECF: function(): Integer; StdCall;
  Daruma_FIMFD_RetornaInformacao: function(Indice: String; Valor: String): Integer; StdCall;
  Daruma_FI_AbreRelatorioGerencial: function(): Integer; StdCall;
  Daruma_FI_GrandeTotal: function(GrandeTotal: String): Integer; StdCall;
  Daruma_FI_Sangria: function(Valor_da_Sangria: String): Integer; StdCall;
  Daruma_FI_Suprimento: function(Valor_do_Suprimento: String; Forma_de_Pagamento: String): Integer; StdCall;
  Daruma_FI_DataHoraImpressora: function(Data: String; Hora: String): Integer; StdCall;     
  Daruma_FI_StatusCupomFiscal: function(strStatus: String): Integer; StdCall; 

Const
  INF_GT_INI         = '2';
  INF_CCF            = '30';
  INF_CDC            = '45';
  INF_GNF            = '28';
  INF_GRG            = '33';      
  INF_COO            = '26';
  INF_TIPO_ECF       = '79';
  INF_MARCA_ECF      = '80';   
  INF_VERSAO_SB      = '83';
  INF_DATA_ATUAL_SB  = '85';  
  INF_NUMERO_USUARIO = '94';
  INF_CNPJ_USUARIO   = '90';
  INF_IES_USUARIO    = '91';
  INF_ECF            = '107';  

implementation

uses untFuncoes, untFuncoesSimples, untConstantes, Data.DB;

{*****************************************}
{* CONSTRUTOR                            *}
{**************************************MA*}
constructor TDaruma32.Create(Owner: TComponent);
begin
  strCpfClie   := '';
  strDllDaruma := fCfgSis('DIRINI') + '\Daruma32.dll';

  SetLength(FVersaoSB, 6);
  SetLength(FNumCaixa, 3);
  SetLength(FCNPJ, 20);
  SetLength(FIE, 20);

  If fInicia <> 0 Then
    Raise Exception.Create('Não foi possível carregar a biblioteca Daruma32.dll na pasta: ' + fCfgSis('DIRINI') + '\');

  FCodRet := Daruma_FIMFD_RetornaInformacao(INF_VERSAO_SB, FVersaoSB);

  If (Not fVerErro) Then
    Raise Exception.Create('Erro ao capturar versão do software básico.');

  FCodRet := Daruma_FIMFD_RetornaInformacao(INF_CNPJ_USUARIO, FCNPJ);

  If (Not fVerErro) Then
    Raise Exception.Create('Erro ao capturar CNPJ do usuário.');

  FCodRet := Daruma_FIMFD_RetornaInformacao(INF_IES_USUARIO, FIE);

  If (Not fVerErro) Then
    Raise Exception.Create('Erro ao capturar IE do usuário.');

  FCodRet := Daruma_FIMFD_RetornaInformacao(INF_ECF, FNumCaixa);

  If (Not fVerErro) Then
    Raise Exception.Create('Erro ao capturar número do caixa.');

  FMsgFechamento := '';
end;

{*****************************************}
{* INICIA BEMATECH                       *}
{**************************************MA*}
function TDaruma32.fImpLinFiscal(strAtrib, strLinha: String): Boolean;
begin
  Result := True;
end;

function TDaruma32.fInicia: Integer;
Begin
  If FileExists( strDllDaruma ) Then
  Begin
    Handle := LoadLibrary(PChar(strDllDaruma));
    Daruma_FI_LeituraX := GetProcAddress(Handle, pChar('Daruma_FI_LeituraX'));
    Daruma_FI_ReducaoZ := GetProcAddress(Handle, pChar('Daruma_FI_ReducaoZ'));
    Daruma_FI_AcionaGaveta := GetProcAddress(Handle, pChar('Daruma_FI_AcionaGaveta'));
    Daruma_FI_RelatorioGerencial := GetProcAddress(Handle, pChar('Daruma_FI_RelatorioGerencial'));
    Daruma_FI_FechaRelatorioGerencial := GetProcAddress(Handle, pChar('Daruma_FI_FechaRelatorioGerencial'));
    Daruma_FI_AbreComprovanteNaoFiscalVinculado := GetProcAddress(Handle, pChar('Daruma_FI_AbreComprovanteNaoFiscalVinculado'));
    Daruma_FI_FechaComprovanteNaoFiscalVinculado := GetProcAddress(Handle, pChar('Daruma_FI_FechaComprovanteNaoFiscalVinculado'));
    Daruma_FI_UsaComprovanteNaoFiscalVinculado := GetProcAddress(Handle, pChar('Daruma_FI_UsaComprovanteNaoFiscalVinculado'));
    Daruma_FI_RetornoImpressora := GetProcAddress(Handle, pChar('Daruma_FI_RetornoImpressora'));
    Daruma_FI_VerificaImpressoraLigada := GetProcAddress(Handle, pChar('Daruma_FI_VerificaImpressoraLigada'));
    Daruma_FI_AbreCupom := GetProcAddress(Handle, pChar('Daruma_FI_AbreCupom'));
    Daruma_FI_AumentaDescricaoItem := GetProcAddress(Handle, pChar('Daruma_FI_AumentaDescricaoItem'));
    Daruma_FI_VendeItem := GetProcAddress(Handle, pChar('Daruma_FI_VendeItem'));
    Daruma_FI_CancelaItemGenerico := GetProcAddress(Handle, pChar('Daruma_FI_CancelaItemGenerico'));
    Daruma_FI_IniciaFechamentoCupom := GetProcAddress(Handle, pChar('Daruma_FI_IniciaFechamentoCupom'));
    Daruma_FI_EfetuaFormaPagamento := GetProcAddress(Handle, pChar('Daruma_FI_EfetuaFormaPagamento'));
    Daruma_FI_TerminaFechamentoCupom := GetProcAddress(Handle, pChar('Daruma_FI_TerminaFechamentoCupom'));
    Daruma_FI_RetornoAliquotas := GetProcAddress(Handle, pChar('Daruma_FI_RetornoAliquotas'));
    Daruma_FI_CancelaCupom := GetProcAddress(Handle, pChar('Daruma_FI_CancelaCupom'));
    Daruma_FI_LeituraMemoriaFiscalData := GetProcAddress(Handle, pChar('Daruma_FI_LeituraMemoriaFiscalData'));
    Daruma_FI_LeituraMemoriaFiscalReducao := GetProcAddress(Handle, pChar('Daruma_FI_LeituraMemoriaFiscalReducao'));
    Daruma_FI_ProgramaFormasPagamento := GetProcAddress(Handle, pChar('Daruma_FI_ProgramaFormasPagamento'));
    Daruma_FI_VerificaFormasPagamentoEx := GetProcAddress(Handle, pChar('Daruma_FI_VerificaFormasPagamentoEx'));
    Daruma_FI_NumeroSerie := GetProcAddress(Handle, pChar('Daruma_FI_NumeroSerie'));
    Daruma_FI_NumeroCupom := GetProcAddress(Handle, pChar('Daruma_FI_NumeroCupom'));
    Daruma_FI_LerAliquotasComIndice := GetProcAddress(Handle, pChar('Daruma_FI_LerAliquotasComIndice'));
    Daruma_FI_RetornaErroExtendido := GetProcAddress(Handle, pChar('Daruma_FI_RetornaErroExtendido'));
    Daruma_FI_VerificaModeloECF := GetProcAddress(Handle, pChar('Daruma_FI_VerificaModeloECF'));
    Daruma_FIMFD_RetornaInformacao := GetProcAddress(Handle, pChar('Daruma_FIMFD_RetornaInformacao'));
    Daruma_FI_AbreRelatorioGerencial := GetProcAddress(Handle, pChar('Daruma_FI_AbreRelatorioGerencial'));
    Daruma_FI_GrandeTotal := GetProcAddress(Handle, pChar('Daruma_FI_GrandeTotal'));
    Daruma_FI_Sangria := GetProcAddress(Handle, pChar('Daruma_FI_Sangria'));
    Daruma_FI_Suprimento := GetProcAddress(Handle, pChar('Daruma_FI_Suprimento'));
    Daruma_FI_DataHoraImpressora := GetProcAddress(Handle, pChar('Daruma_FI_DataHoraImpressora'));
    Daruma_FI_StatusCupomFiscal := GetProcAddress(Handle, pChar('Daruma_FI_StatusCupomFiscal'));

    Result := 0;
  End
  Else
  Begin
    Result := -999;
  End;
End;

{*****************************************}
{* FINALIZA BEMATECH                     *}
{**************************************MA*}
function TDaruma32.fFinaliza: Integer;
Begin
  FreeLibrary(Handle);
  Result := 0;
End;

function TDaruma32.fGerarSintegra(blnApenas75: Boolean; strArquivo, strMes,
  strAno, strRazSoc, strEndere, strNumEnd, strComple, strBairro, strCidade,
  strNumCep, strFone01, strNumFax, strContat: String): Boolean;
begin
  Result := False;
end;

function TDaruma32.fGrandeTotal: Double;
  Var
    strGrandeTotal: String;
begin
  SetLength(strGrandeTotal, 18);

  FCodRet := Daruma_FI_GrandeTotal(strGrandeTotal);
  Result  := 0;

  If (fVerErro) Then
    Result := fFormataFloat(fStrToFloat(strGrandeTotal) / 100, 2);
end;

function TDaruma32.fVendaBruta: Double;
  Var
    strGrandeTotalInicial: String;
begin
  SetLength(strGrandeTotalInicial, 18);

  FCodRet := Daruma_FIMFD_RetornaInformacao(INF_GT_INI, strGrandeTotalInicial);
  Result  := 0;

  If (fVerErro) Then
  Begin
    Result := fGrandeTotal - fFormataFloat(fStrToFloat(strGrandeTotalInicial) / 100, 2);
  End;
end;

{*****************************************}
{* LEITURA X                             *}
{**************************************MA*}
function TDaruma32.fLeituraMemoriaFiscal(blnCompleta: Boolean; strTipoFiltro,
  strFiltroIni, strFiltroFin: String): Boolean;
begin
  Result := False;
end;

function TDaruma32.fLeituraX(strParam: String = 'N'; blnPergunta: Boolean = True): Boolean;
begin
  FCodRet := Daruma_FI_LeituraX;
  Result  := fVerErro;
end;

function TDaruma32.fModeloEcf: String;
  var
    intModelo: Integer;
begin
 intModelo := Daruma_FI_VerificaModeloECF();
 Result    := '';

 Case intModelo Of
   1: Result := 'FS345'; {Impressora de varejo}
   2: Result := 'FS318'; {Impressora para restaurantes}
   3: Result := 'FS2000'; {Impressora de duas estaçõe}
   4: Result := 'FS600'; {MFD (térmica) - Impressora de varejo}
 End;

end;

{*****************************************}
{* REDUCAO Z                             *}
{**************************************MA*}
function TDaruma32.fReducaoZ(strData, strHora: String): Boolean;
begin
  FCodRet := Daruma_FI_ReducaoZ(PChar(strData),PChar(strHora));
  Result  := fVerErro;
end;

{*****************************************}
{* RETORNO DA IMPRESSORA                 *}
{**************************************MA*}
function TDaruma32.fRetorno( Var ACK: Integer; Var ST1: Integer; Var ST2: Integer ): Integer;
Begin
  Result := Daruma_FI_RetornoImpressora( ACK, ST1, ST2 );

  //Quando OK retorna ACK = 6 mas ST1 e ST2 = 0
  //Nesse caso nao tem q fazer nada
  If Result = 1 Then
    If ( ST1 + ST2 ) = 0 Then
      Result := 1
    Else
      Result := StrToInt( RightStr( '000' + Trim( IntToStr( ACK ) ), 3 ) +
                          RightStr( '000' + Trim( IntToStr( ST1 ) ), 3 ) +
                          RightStr( '000' + Trim( IntToStr( ST2 ) ), 3 ) );

End;


function TDaruma32.fRetTotalImpressora(fltQtdIte, fltUnitar: Double): Double;
begin
  fltQtdIte := fFormataFloat(fltQtdIte, 3);
  fltUnitar := fFormataFloat(fltUnitar, 2);
  Result    := fFormataFloat(fltQtdIte * fltUnitar, 2);
end;

{*****************************************}
{* ABRE CUPOM FISCAL                     *}
{**************************************MA*}
function TDaruma32.fAbreCupom: Boolean;
Begin
  strCpfCupomFiscal    := AnsiString(strCpfClie);
  strNomeCupomFiscal   := AnsiString(Copy(strNomCli, 1, 30));
  strEndereCupomFiscal := AnsiString(Copy(strEndCli, 1, 79));

  FCodRet := Daruma_FI_AbreCupom(PChar(strCpfClie));
  FMsgFechamento := '';
  Result  := fVerErro;

  If Result Then
    VS_blnCupomAberto := True;
End;

{*****************************************}
{* VENDE ITEM                            *}
{**************************************MA*}
function TDaruma32.fRegistraItem(strCodIte, strDesIte, strUnidad: String;
  fltAlqIcm, fltQtdIte, fltUnitar: Double; strCodFis: String; fltDesEsp: Double; fltTotal: Double = 0): Boolean;
  Const
    intQtdDec = 2;
    strTipQtd = 'F';
    strTipDes = '$';

  Var
    strQuanti : String;
    strQtdDec : String;
    strUnitar : String;
    strDesEsp : String;
    strAlqIcm : String;
Begin
  strQuanti := FloatToStrF( fltQtdIte, ffNumber, 7, 3 );
  strQtdDec := RightStr( '00' + Trim( IntToStr( intQtdDec ) ), 2 );
  strUnitar := FloatToStrF( fltUnitar, ffNumber, 8, 2 );

  strAlqIcm := fCalcAliquota(strCodFis, fltAlqIcm, 1);

  pCalculaAcrDesItem(Self, fStrToFloat(strQuanti), fStrToFloat(strUnitar),
    fltQtdIte, fltUnitar, fltDesEsp, fltUltDesEspIte, fltUltAcrescIte);

  {*****************************************}
  {* NESTE CASO, QUANDO TEM QUE APLICAR    *}
  {* ACRÉSCIMO, MANDA UM VALOR NEGATIVO PA-*}
  {* RA O DESCONTO.                        *}
  {**************************************MA*}
  If fltUltDesEspIte > 0 Then
  Begin
    strDesEsp := FloatToStrF(fltUltDesEspIte, ffNumber, 8, 2);
  End
  Else
  Begin
    strDesEsp := FloatToStrF(-fltUltAcrescIte, ffNumber, 8, 2);
  End;

  FCodRet := Daruma_FI_VendeItem( strCodIte, fPadr( strDesIte, 29 ), strAlqIcm,
    strTipQtd, strQuanti, intQtdDec, strUnitar, strTipDes, strDesEsp);

  Result := fVerErro;

  If fIsNumber(strAlqIcm) Then
    strUltIndiceTri := strAlqIcm
  Else
    strUltIndiceTri := LeftStr(strAlqIcm, 1);

End;


{*****************************************}
{* ATRIBUI OS VALORES DAS FORMAS DE      *}
{* PAGAMENTO                             *}
{**************************************MA*}
function TDaruma32.fRegistraModalidades(strCodMod, strDesMod: String; fltValMod: Double; strInfAdi: String): Boolean;
  Var
    strValor: String;
Begin
  strValor := FloatToStrF(fltValMod, ffFixed, 12, 2);
  strValor := AnsiReplaceStr(strValor, '.', '');

  If strDesMod <> EmptyStr Then
    strDesMod := fPadr( strDesMod, 80 );

  FCodRet := Daruma_FI_EfetuaFormaPagamento(PChar( fPadR(strDesMod, 16)), PChar(strValor));
  Result  := fVerErro;
End;

{*****************************************}
{* FINALIZA O CUPOM                      *}
{**************************************MA*}
function TDaruma32.fFechaCupom: Boolean;
  Var
    strMens: String;
Begin
  If fEmptyStr(FMsgFechamento) Then
    strMens := fRetornaObsFechamento
  Else
    strMens := FMsgFechamento;

  FCodRet := Daruma_FI_TerminaFechamentoCupom( pChar(strMens) );
  Result  := fVerErro;

  If Result Then
    VS_blnCupomAberto := False;
End;

{*****************************************}
{* RETORNA AS ALIQUOTAS DE ICMS          *}
{**************************************MA*}
function TDaruma32.fCancelaCupom: Boolean;
Begin
  FCodRet := Daruma_FI_CancelaCupom;
  Result  := fVerErro;
  If Result Then
    VS_blnCupomAberto := False;
End;

{*******************************************}
{* ABRE GAVETA                             *}
{****************************************MV*}
function TDaruma32.fAbreGaveta: Boolean;
begin
  FCodRet := Daruma_FI_AcionaGaveta;
  Result  := fVerErro;
end;

function TDaruma32.fAbrePortaImpressora: Boolean;
begin
  Result := True;
end;

function TDaruma32.fAbreRelatorioGerencial(blnMostrarErro: Boolean): Boolean;
begin
  FCodRet := Daruma_FI_AbreRelatorioGerencial();
  Result  := fVerErro(blnMostrarErro);
end;

function TDaruma32.fArquivoMFD(strDataIni, strDataFin, strArquivoSaida,
  strRazSocEmp, strEndereEmp: String): Boolean;
begin
  Result := False;
end;

function TDaruma32.fNumeroCaixa: String;
begin
  Result := FNumCaixa;
end;

function TDaruma32.fNumeroCCF: String;
begin
  Result  := fStrEspaco(' ', 6);
  FCodRet := Daruma_FIMFD_RetornaInformacao(INF_CCF, Result);
end;

function TDaruma32.fNumeroCDC: String;
begin
  SetLength(Result, 4);
  FCodRet := Daruma_FIMFD_RetornaInformacao(INF_CDC, Result);
end;

function TDaruma32.fNumeroSerie: String;
begin
  Result  := fStrEspaco(' ', 20);
  FCodRet := Daruma_FI_NumeroSerie(Result);
end;

function TDaruma32.fRetornaCoo: String;
begin
  Result := fStrEspaco(' ',6);
  FCodRet := Daruma_FI_NumeroCupom(Result);
end;

function TDaruma32.fSangria(fltValor: Double): Boolean;
  Var
    strValor: String;
begin
  strValor := FloatToStrF(fltValor, ffNumber, 12, 2);
  FCodRet  := Daruma_FI_Sangria(pchar(strValor));
  Result   := fVerErro;
end;

function TDaruma32.fStatusImpressora: String;
begin
  FCodRet := Daruma_FI_VerificaImpressoraLigada;
  Result  := IntToStr(FCodRet);
end;

function TDaruma32.fSuprimento(fltValor: Double; strModalidade: String): Boolean;
  Var
    strValor: String;
begin
  strValor := FloatToStrF(fltValor, ffNumber, 12, 2);
  FCodRet  := Daruma_FI_Suprimento(PChar(strValor), PChar(strModalidade));
  Result   := fVerErro;
end;

function TDaruma32.fCancelaItem(strItem: String): Boolean;
begin
  FCodRet := Daruma_FI_CancelaItemGenerico( PChar(strItem) );
  Result  := fVerErro;
end;

function TDaruma32.fDadosUltimaReducao(var drzDadosRed: TDadosReducao): Boolean;
begin
  Result := False; 
end;

{*****************************************}
{* REGISTRA SE FOI DESCONTO OU ACRESCIMO *}
{**************************************AF*}
function TDaruma32.fRegistraAcrDes(strAcrDes, strTip_AC, strVal_AC: String; fltTotal, fltTotImp: Double): Boolean;
  Var
    fltValDes: Double;
    strDesEsp: String;
begin
  strAcrDes := 'D';
  fltValDes := 0;

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

  FCodRet := Daruma_FI_IniciaFechamentoCupom(PChar(strAcrDes), PChar(strTip_AC), PChar(strDesEsp));

  Result  := fVerErro;
End;

function TDaruma32.fVerErro(blnMostraErro: Boolean): Boolean;
  var
    strMenErro: String;
    strRetorno: String;
    intRetorno: Integer;
begin
  Result := false;
  If FCodRet = 1 Then
    Result := True

  Else If FCodRet = 0 Then
    strMenErro := 'Erro de comunicação'

  Else
  Begin
    SetLength(strRetorno, 4);
    Daruma_FI_RetornaErroExtendido(strRetorno);

    intRetorno := StrToIntDef(strRetorno, -1);

    Case intRetorno Of
      -1 :  strMenErro := 'Erro desconhecido...';
      00 :  strMenErro := 'IF em modo Manutenção. Foi ligada sem o Jumper de Operação';
      01 :  strMenErro := 'Método disponível somente em modo Manutenção';
      02 :  strMenErro := 'Erro durante a gravação da Memória Fiscal';
      03 :  strMenErro := 'Memória Fiscal esgotada';
      04 :  strMenErro := 'Erro no relógio interno da IF';
      05 :  strMenErro := 'Falha mecânica na IF';
      06 :  strMenErro := 'Erro durante a leitura da Memória Fiscal';
      07 :  strMenErro := 'Metodo permitido apenas em modo fiscal (IF sem jmper)';
      08 :  strMenErro := 'Relatório Gerêncial não aberto';
      10 :  strMenErro := 'Documento sendo emitido';
      11 :  strMenErro := 'Documento não foi aberto';
      12 :  strMenErro := 'Não existe documento a cancelar';
      13 :  strMenErro := 'Dígito não numérico não esperado, foi encontrado nos Parâmetros do Método';
      14 :  strMenErro := 'Não há mais memória disponível para esta operação/Não há nenhuma posição de méria disponível.';
      15 :  strMenErro := 'Item a cancelar não foi encontrado';
      16 :  strMenErro := 'Erro de sintaxe no método';
      17 :  strMenErro := '"Estouro" de capacidade numérica (overflow)';
      18 :  strMenErro := 'Selecionado totalizador tributado com alíquota de imposto não definida';
      19 :  strMenErro := 'Memória Fiscal vazia';
      20 :  strMenErro := 'Não existem campos que requerem atualização';
      21 :  strMenErro := 'Detectado proximidade do final da bobina de papel';
      22 :  strMenErro := 'Cupom de Redução Z já foi emitido. IF inoperante até 0:00h do próximo dia';
      23 :  strMenErro := 'Redução Z do período anterior ainda pendente. IF inoperante';
      24 :  strMenErro := 'Valor de desconto ou acréscimo inválido (limitado a 100%)';
      25 :  strMenErro := 'Caráctere inválido foi encontrado nos Parâmetros do Métodos';
      26 :  strMenErro := 'Médoto não pode ser executado';
      27 :  strMenErro := 'Impressora fora de Linha/Nenhum periférico conectado a interface auxiliar';
      28 :  strMenErro := 'Foi encontrado um campo em zero';
      29 :  strMenErro := 'Documento anterior não foi Cupom Fiscal. Não pode emitir Cupom Adicional';
      30 :  strMenErro := 'Acumulador Não Fiscal selecionado não é válido ou não está disponível';
      31 :  strMenErro := 'Não pode autenticar. Excedeu 4 repetições ou não é permitida nesta fase';
      32 :  strMenErro := 'Cupom adicional inibido por configuração';
      35 :  strMenErro := 'Relógio Interno Inoperante';
      36 :  strMenErro := 'Versão do firmware gravada na Memória Fiscal não é a esperada';
      37 :  strMenErro := 'Alíquota de imposto informada já está carregada na memória';
      38 :  strMenErro := 'Forma de pagamento selecionada não é válida';
      39 :  strMenErro := 'Erro na seqüência de fechamento do Cupom Fiscal';
      40 :  strMenErro := 'IF em Jornada Fiscal. Alteração da configuração não é permitida';
      41 :  strMenErro := 'Data inválida. Data fornecida é inferior à última gravada na Memória Fiscal';
      42 :  strMenErro := 'Leitura X inicial ainda não foi emitida';
      43 :  strMenErro := 'Não pode emitir Comprovante Vinculado';
      44 :  strMenErro := 'Cupom de Orçamento não permitido para este estabelecimento(Mensagem do Aplicativo Não Programada)';
      45 :  strMenErro := 'Campo obrigatório em branco';
      48 :  strMenErro := 'Não pode estornar';
      49 :  strMenErro := 'Forma de pagamento indicada não encontrada';
      50 :  strMenErro := 'Fim da bobina de papel';
      51 :  strMenErro := 'Nenhum usuário cadastrado na MF';
      52 :  strMenErro := 'MF não instalada ou não inicializada';
      56 :  strMenErro := 'Documento já aberto';
      61 :  strMenErro := 'Queda de energia durante a emissão de Cupom Fiscal';
      75 :  strMenErro := 'Operação com ISS não permitida (se a sua impressora for uma FS600 ou FS2100T, então será preciso ' +
                          'ter uma inscrição municipal gravada em sua impressora para que seja possível programar/utilizar alíquota de serviço).';
      76 :  strMenErro := 'Desconto em ISS não permitido neste ECF (a programação deverá ser feita por meio de intervenção técnica e caso o Estado permita)';
      77 :  strMenErro := 'Acréscimo em IOF inibido';
      80 :  strMenErro := 'Periférico na interface auxiliar não pode ser reconhecido';
      81 :  strMenErro := 'Solicitado preenchimento de cheque de banco desconhecido';
      82 :  strMenErro := 'Solicitado transmissão de mensagem nula pela interface auxiliar';
      83 :  strMenErro := 'Extenso do cheque não cabe no espaço disponível';
      84 :  strMenErro := 'Erro na comunicação com a interface auxiliar';
      85 :  strMenErro := 'Erro no dígito verificador durante comunicação com a PertoCheck';
      86 :  strMenErro := 'Falha na carga de geometria de folha de cheque';
      87 :  strMenErro := 'Parâmetros do Método: invállido para o campo de data do cheque';
      90 :  strMenErro := 'Sequência de validação de número de série inválida';
      180:  strMenErro := 'Mensagem do aplicativo não programada. (Esta mensagem não é opcional e sim uma exigência da legislação e ' +
                          'deverá ser programada para que o ECF seja liberado para a emissão de documentos fiscais. Para programar a ' +
                          'mensagem use os métodos:Daruma_Registry_AplMensagem1(Índice 36) e método:Daruma_Registry_AplMensagem2(Índice 37).';
      181:  strMenErro := 'Não é possivel realizar Redução Z entre 00:00am e 02:00am (Meia Noite e Duas da Manhã) nesta versão de ' +
                          'firmware da FS600 (está limitação existe nas versões 1.1 pra baixo.';
    End;

  End;

  If Not Result And blnMostraErro Then
  Begin
    fMensagem('', strMenErro, ['&OK']);
  End;

end;

function TDaruma32.fVerificaCupomAberto: Boolean;
var strInformacao: String;
begin
  SetLength(strInformacao, 2);
  Daruma_FI_StatusCupomFiscal( PChar( strInformacao ) );
  If Trim(strInformacao) = '1' Then
    Result:=True
  Else
    Result:=False;
end;

function TDaruma32.fCalcAliquota(strCodFiscal: String; fltAliquota: Double;
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

function TDaruma32.fFechaRelatorioGerencial(blnMostrarErro: Boolean): Boolean;
begin
  FCodRet := Daruma_FI_FechaRelatorioGerencial;
  Result  := fVerErro(blnMostrarErro);
end;

function TDaruma32.fRelatorioGerencial(strTexto: String): Boolean;
begin
  FCodRet := Daruma_FI_RelatorioGerencial( PChar(strTexto) );
  Result  := fVerErro;
end;

function TDaruma32.fUsaCNFVinculado(strTexto: String): Boolean;
begin
  FCodRet := Daruma_FI_UsaComprovanteNaoFiscalVinculado( PChar(strTexto) );
  Result  := fVerErro;
end;

procedure TDaruma32.pPausaLeitura;
begin
  inherited;
end;

function TDaruma32.fAbreCNFVinculado(strDesFormaPgto, strValor, strNumCupom: String; strQtdPar: String = ''): Boolean;
begin
  FCodRet := Daruma_FI_AbreComprovanteNaoFiscalVinculado( PChar(strDesFormaPgto), PChar(strValor), PChar(strNumCupom));
  Result  := fVerErro;
end;

function TDaruma32.fFechaCNFVinculado(blnMostrarErro: Boolean = True): Boolean;
begin
  FCodRet := Daruma_FI_FechaComprovanteNaoFiscalVinculado;
  Result  := fVerErro(blnMostrarErro);
end;

function TDaruma32.fNumeroUsuario: String;
begin
  SetLength(Result, 2);
  FCodRet := Daruma_FIMFD_RetornaInformacao(INF_NUMERO_USUARIO, Result);
end;

function TDaruma32.fNumeroCNPJUsuario: String;
begin
  Result := FCNPJ;
end;

function TDaruma32.fNumeroGNF: String;
begin
  SetLength(Result, 6);
  FCodRet := Daruma_FIMFD_RetornaInformacao(INF_GNF, Result);
end;

function TDaruma32.fNumeroGRG: String;
begin
  SetLength(Result, 6);
  FCodRet := Daruma_FIMFD_RetornaInformacao(INF_GRG, Result);
end;

function TDaruma32.fVersaoSoftwareBasico: String;
begin
  Result := FVersaoSB;
end;

function TDaruma32.fDataGravacaoSoftwareBasico: TDateTime;
begin
  pCarregaDataHoraGravSB;
  Result := FDataGravacaoSB;
end;

function TDaruma32.fEspacoEntreLinhas(intEspacos: Integer): Boolean;
begin
  Result := True;
end;

function TDaruma32.fEspelhoMFD(strTipoFiltro, strFiltroIni, strFiltroFin,
  strArquivoSaida: String): Boolean;
begin
  Result := False;
end;

function TDaruma32.fexecutaCMD(strCmd: String; blnRetorna: Boolean): String;
begin
  Result := '';
end;

function TDaruma32.fHoraGravacaoSoftwareBasico: TDateTime;
begin
  pCarregaDataHoraGravSB;
  Result := FHoraGravacaoSB;
end;

procedure TDaruma32.pCarregaDataHoraGravSB;
  Var
    strDtaAtuSb: String;
begin
  If (FDataGravacaoSB = 0) Then
  Begin
    SetLength(strDtaAtuSb, 14);

    FCodRet := Daruma_FIMFD_RetornaInformacao(INF_DATA_ATUAL_SB, strDtaAtuSb);

    If (Not fVerErro) Then
      Raise Exception.Create('Erro ao capturar hora da gravação do software básico.');

    FDataGravacaoSB := StrToDate(Copy(strDtaAtuSb,01,2) + '/' + Copy(strDtaAtuSb,03,2) + '/' + Copy(strDtaAtuSb,05,4));
    FHoraGravacaoSB := StrToTime(Copy(strDtaAtuSb,09,2) + ':' + Copy(strDtaAtuSb,11,2) + ':' + Copy(strDtaAtuSb,13,2));
  End;
end;

procedure TDaruma32.pFechaPortaImpressora;
begin
  inherited;
end;

function TDaruma32.fNumeroIEUsuario: String;
begin
  Result := FIE;
end;

function TDaruma32.fTipoECF: String;
begin
  SetLength(Result, 07);
  FCodRet := Daruma_FIMFD_RetornaInformacao(INF_TIPO_ECF, Result);
  Result  := Trim(Result);
end;

function TDaruma32.fMarcaECF: String;
begin
  SetLength(Result, 20);
  FCodRet := Daruma_FIMFD_RetornaInformacao(INF_MARCA_ECF, Result);
  Result  := Trim(Result);
end;

function TDaruma32.fMFDAdicional: String;
begin
  Result := '';
end;

function TDaruma32.fDataEcf: TDateTime;
  Var
    strData: String;
    strHora: String;
begin
  strData := '';
  strHora := '';
  SetLength(strData, 6);
  SetLength(strHora, 6);

  FCodRet := Daruma_FI_DataHoraImpressora(strData, strHora);

  If (Not fEmptyStr(strData)) Then
  Begin
    Insert('/', strData, 3);
    Insert('/', strData, 6);

    Result := StrToDate(strData);
  End
  Else
    Result := VS_Date;

end;

function TDaruma32.fHoraEcf: TDateTime;
  Var
    strData: String;
    strHora: String;
begin
  strData := '';
  strHora := '';
  SetLength(strData, 6);
  SetLength(strHora, 6);

  FCodRet := Daruma_FI_DataHoraImpressora(strData, strHora);

  If (Not fEmptyStr(strData)) Then
  Begin
    Insert(':', strHora, 3);
    Insert(':', strHora, 6);

    Result := StrToTime(strHora);
  End
  Else
    Result := fTime();
end;

function TDaruma32.fUltimoComandoComErro: Boolean;
begin
  Result := blnUltComandoErro;
end;

function TDaruma32.fUltimoItemVendido: String;
begin
  Result := '';
end;

End.

