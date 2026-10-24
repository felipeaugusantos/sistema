{**************************************************}
{* UNIT COM AS FUNCOES DA BEMATECH                *}
{*                                                *}
{* DATA......: 26/02/2008                         *}
{* AUTOR.....: ALEXANDRE FERRI                    *}
{*                                                *}
{***********************************************AF*}
unit untBematechN;

interface

Uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StrUtils, Uni, untFiscal, untBematechNDll;

Type
  TarrFormasPagto = Array of String[16];

Type
  TBematech = class(TFiscal)

  private
    FCodErr  : String;
    FVersaoSB: String;
    FDataGravacaoSB: TDateTime;
    FHoraGravacaoSB: TDateTime;
    FNumCaixa: String;
    FCNPJ: String;
    FIE: String;

    blnUltComandoErro: Boolean;

    procedure pCarregaDataHoraGravSB;
  public
    arrNomesFormasPagto: TarrFormasPagto;
    
    function fInicia     : Integer;
    function fFinaliza   : Integer;
    function fRetorno(Var ACK: Integer; Var ST1: Integer; Var ST2: Integer; Var ST3: Integer): String;
    function fVerErro(blnMostraErro: Boolean = True): Boolean; Override;

    function fLeituraX(strParam: String = 'N'; blnPergunta: Boolean = True): Boolean; Override;
    function fReducaoZ: Boolean; Override;
    function fAbreGaveta: Boolean; Override;
    function fStatusImpressora: String; Override;
    function fAbreCupom: Boolean; Override;
    function fRegistraItem(strCodIte, strDesIte, strUnidad: String; fltAlqIcm, fltQtdIte, fltUnitar: Double; strCodFis: String): Boolean; Override;
    function fCancelaItem(strItem: String): Boolean; Override;
    function fCancelaCupom: Boolean; Override;
    function fRegistraAcrDes(strAcrDes, strTip_AC, strVal_AC: String; fltTotal, fltTotImp: Double): Boolean; Override;
    function fRegistraModalidades(strCodMod, strDesMod: String; fltValMod: Double; strInfAdi: String): Boolean; Override;
    function fFechaCupom: Boolean; Override;
    function fRetornaCoo: String; Override;
    function fNumeroSerie: String; Override;
    function fCalcAliquota(strCodFiscal: String; fltAliquota: Double; intTipRet: Integer = 1): String; Override;
    function fFechaRelatorioGerencial(blnVerErro: Boolean = True): Boolean; Override;
    function fRelatorioGerencial(strTexto: String): Boolean; Override;
    function fEspacoEntreLinhas(intEspacos: Integer): Boolean; Override;
    function fAbreCNFVinculado(strDesFormaPgto, strValor, strNumCupom: String): Boolean; Override;
    function fFechaCNFVinculado(blnVerErro: Boolean = True): Boolean; Override;
    function fUsaCNFVinculado(strTexto: String): Boolean; Override;
    function fImpLinFiscal(strAtrib, strLinha: String): Boolean; Override;
    function fAbrePortaImpressora: Boolean; Override;
    function fexecutaCMD(strCmd: String; blnRetorna: Boolean = False): String; Override;
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

    function fSangria(fltValor: Double): Boolean; override;
    function fSuprimento(fltValor: Double): Boolean; override;

    function fGerarSintegra(blnApenas75: Boolean; strArquivo, strMes, strAno,
      strRazSoc, strEndere, strNumEnd, strComple, strBairro, strCidade,
      strNumCep, strFone01, strNumFax, strContat: String): Boolean; override;

    function fUltimoComandoComErro: Boolean; override;

    function fRetTotalImpressora(fltQtdIte, fltUnitar: Double): Double; override;

    Constructor Create(Owner: TComponent); Reintroduce;
    Destructor Destroy; override;

  End;

Var
  Handle : THandle;
  strDllBematech: String;

implementation

uses untFuncoes, untfuncoesSimples, MaskUtils;

{*****************************************}
{* INICIA BEMATECH                       *}
{**************************************AF*}
function TBematech.fInicia: Integer;
Begin
  Result := 0;
End;

{*****************************************}
{* LIBERA A DLL                          *}
{**************************************AF*}
function TBematech.fFinaliza: Integer;
Begin
  Result := 0;
End;

{*****************************************}
{* EXECUTA A LEITURA X                   *}
{**************************************AF*}
function TBematech.fLeituraX(strParam: String = 'N'; blnPergunta: Boolean = True): Boolean;
begin
  FCodErr := IntToStr(Bematech_FI_LeituraX);
  Result  := fVerErro;
end;

{*****************************************}
{* EXECUTA A REDUCAO Z                   *}
{**************************************AF*}
function TBematech.fReducaoZ: Boolean;
begin
  FCodErr := IntToStr(Bematech_FI_ReducaoZ(PChar(''),PChar('')));
  Result  := fVerErro;
end;

{*****************************************}
{* RETORNO DA IMPRESSORA                 *}
{**************************************AF*}
function TBematech.fRetorno( Var ACK: Integer; Var ST1: Integer; Var ST2: Integer;
  Var ST3: Integer ): String;
Begin
  //Verificar
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

End;

{*****************************************}
{* VERIFICA IMPRESSORA LIGADA            *}
{* FUNÇÃO UTILIZADA PELO TEF E VERIFICA  *}
{* O ERRO POR LA                         *}
{**************************************AF*}
function TBematech.fStatusImpressora: String;
Begin
  FCodErr := IntToStr(Bematech_FI_VerificaImpressoraLigada);
  Result  := FCodErr;
End;

{*****************************************}
{* ABRE CUPOM FISCAL                     *}
{**************************************AF*}
function TBematech.fAbreCupom: Boolean;
Begin
  //Verificar
  //FCodErr := IntToStr(Bematech_FI_AbreCupom(PChar(strCpfCli)));
  strCpfCupomFiscal    := strCpfClie;
  strNomeCupomFiscal   := Copy(strNomCli, 1, 30);
  strEndereCupomFiscal := Copy(strEndCli, 1, 29);

  FCodErr := IntToStr(Bematech_FI_AbreCupomMFD(PChar(strCpfCupomFiscal), strNomeCupomFiscal, strEndereCupomFiscal));
  Result  := fVerErro;
End;

{*****************************************}
{* REGISTRA O ITEM NA IMPRESSORA         *}
{**************************************AF*}
{function TBematech.fRegistraItem(strCodIte, strDesIte, strUnidad: String; fltAlqIcm, fltQtdIte, fltUnitar: Double; strCodFis: String): Boolean;
  Var
    strAlqIcm: String;
    strQuanti: String;
    strUnitar: String;
    strDesEsp: String;
Begin

  strQuanti := FloatToStrF(fltQtdIte, ffNumber, 7, 3);
  strUnitar := FloatToStrF(fltUnitar, ffNumber, 8, 2);
  strDesEsp := FloatToStrF(        0, ffNumber, 8, 2);
  strAlqIcm := fCalcAliquota(strCodFis, fltAlqIcm, 1);

  strDesIte := strDesIte + ' ' + strUnidad;

  If Pos(LeftStr(strDesIte, 1), '0123456789') > 0 Then
  Begin
    strDesIte := 'x' + strDesIte;
  End;

  FCodErr := IntToStr(Bematech_FI_AumentaDescricaoItem(PChar(strDesIte)));
  Result  := fVerErro;

  If Result Then
  Begin
    FCodErr := IntToStr(Bematech_FI_VendeItem(PChar(strCodIte), PChar(fPadr(strDesIte, 29)), PChar(strAlqIcm), 'F', PChar(strQuanti), 2, PChar(strUnitar), '$', PChar(strDesEsp)));
    Result  := fVerErro;
  End;

End;}

function TBematech.fRegistraItem(strCodIte, strDesIte, strUnidad: String; fltAlqIcm, fltQtdIte, fltUnitar: Double; strCodFis: String): Boolean;
  Var
    strAlqIcm: String;
    strQuanti: String;
    strUnitar: String;
    strDesEsp: String;

    intDecUni: Integer;
    strModEcf: String;
Begin

  intDecUni := fCfgSis('DECUNI', varInteger);
  If intDecUni > 3 Then
    intDecUni := 3
  Else If intDecUni < 2 Then
    intDecUni := 2;

  strAlqIcm := fCalcAliquota(strCodFis, fltAlqIcm, 1);

  //verificar
  strModEcf := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'MODELO'       , '', fCfgSis('DIRINI') + '/opcoes_fiscal.ini' );

  strQuanti := fPadL(FloatToStrF(fltQtdIte, ffNumber, 7, 3), 7, '0');

  strDesEsp := FloatToStrF(        0, ffNumber, 8, 2);

  If SameText(strModEcf, BEMATECH_MP20) Then
    strUnitar := fPadL(FloatToStrF(fltUnitar, ffNumber, 9, intDecUni), 9, '0')
  Else
    strUnitar := fPadL(FloatToStrF(fltUnitar, ffNumber, 9, 3), 9, '0');

  If SameText(strModEcf, BEMATECH_MP20) Then
  Begin
    strUnitar := Copy(strUnitar, 2, 8);

    Bematech_FI_AumentaDescricaoItem(Copy(strDesIte, 1, 200));

    FCodErr := IntToStr(Bematech_FI_VendeItem(strCodIte, Copy(strDesIte, 1, 29), strAlqIcm,
      'F', strQuanti, intDecUni, strUnitar, '%', strDesEsp));
  End
  Else
  Begin
    FCodErr := IntToStr(Bematech_FI_VendeItemDepartamento(PChar(strCodIte), fPadR(strDesIte, 57), PChar(strAlqIcm),
      PChar(strUnitar), PChar(strQuanti), PChar(strDesEsp), PChar(strDesEsp), PChar('01'), PChar('UN')));
  End;

  Result  := fVerErro;
End;

{*****************************************}
{* REGISTRA SE FOI DESCONTO OU ACRESCIMO *}
{**************************************AF*}
function TBematech.fRegistraAcrDes(strAcrDes, strTip_AC, strVal_AC: String; fltTotal, fltTotImp: Double): Boolean;
  Var
    fltValDes: Double;
    strDesEsp: String;
Begin

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
  strDesEsp := AnsiReplaceStr( strDesEsp, ',', '' );
  strDesEsp := fPadL(strDesEsp, 14, '0');

  FCodErr := IntToStr(Bematech_FI_IniciaFechamentoCupom(PChar(strAcrDes), PChar(strTip_AC), PChar(strDesEsp)));
  Result  := fVerErro;
End;

{*******************************************}
{* ATRIBUI O VALOR DAS FORMAS DE PAGAMENTO *}
{****************************************AF*}
function TBematech.fRegistraModalidades(strCodMod, strDesMod: String; fltValMod: Double; strInfAdi: String): Boolean;
  Var
    strValor: String;
Begin
  strValor := FloatToStrF(fltValMod, ffFixed, 11,2);
  strValor := AnsiReplaceStr(strValor, '.', '');

  FCodErr := IntToStr(Bematech_FI_EfetuaFormaPagamentoDescricaoForma(PChar( fPadR(strDesMod, 16)), PChar(strValor), PChar(strInfAdi)));
  Result  := fVerErro;
End;

{************************************************}
{* FECHA O CUPOM FISCAL (MENSAGEM MAX 8 LINHAS) *}
{*********************************************AF*}
function TBematech.fFechaCupom: Boolean;
  Var
    strMens: String;
    strTelFor: String;
Begin
  strMenPaf01 := fRetMD5Laudo;
  strMens := '';

  strCgcCpf := fFormataCpfCgc(strCgcCpf);
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

  strTelFor := '';
  If Not fEmptyStr(strTelCli) Then
    strTelFor := '      Fone: ' + FormatMaskText('(99)9999-9999;0;_', strTelCli);

  strMens := strMens + fPadR(strMenPaf01, 48);
  strMens := strMens + fPadR('Cupom Fiscal: ' + strNumDoc + '-IF' + strTelFor, 48);
  strMens := strMens + fPadR(LeftStr(strNomCli, 39) + '-' + strCodCli, 48);
  strMens := strMens + fPadR(strEndCli + ' - ' + strBaiCli, 48);
  strMens := strMens + fPadR(strCepCli + ' - ' + strCidCli + '-' + strEstCli, 48);
  strMens := strMens + fPadR(strCGCCPF + ' - ' + strIESCli, 48);

  If fCfgSis('SIMNAC', varBoolean) Then
    strMens := strMens + fPadR( 'ICMS A SER REC. CONF. LC 123/2006 - SIMPLES NAC', 48);

  If fCfgSis('CUPMAN', varBoolean) Then
    strMens := strMens + fPadR( 'VALIDO PARA O CUPOM MANIA.ICMS DEVIDO: ' + FormatFloat('#0.00', fltIcmDev), 48);

  FCodErr := IntToStr(Bematech_FI_TerminaFechamentoCupom( pChar(strMens) ));
  Result  := fVerErro;
End;

{*****************************************}
{* CANCELA O CUMPOM                      *}
{**************************************AF*}
function TBematech.fCancelaCupom: Boolean;
Begin
  FCodErr := IntToStr(Bematech_FI_CancelaCupom);
  Result  := fVerErro;
End;

{*****************************************}
{* ABRE GAVETA                           *}
{**************************************AF*}
function TBematech.fAbreGaveta: Boolean;
begin
  FCodErr := IntToStr(Bematech_FI_AcionaGaveta);
  Result  := fVerErro;
end;

{**************************************}
{* RETORNA NUMERO DO CUPOM            *}
{***********************************AF*}
function TBematech.fRetornaCoo: String;
begin
  Result := fStrEspaco(' ',6);
  FCodErr := IntToStr(Bematech_FI_NumeroCupom(Result));
end;

{*******************************************}
{* RETORNA O NÚMERO DE SÉRIE DA IMPRESSORA *}
{****************************************AF*}
function TBematech.fNumeroSerie: String;
begin
  Result := fStrEspaco(' ', 20);
  FCodErr := IntToStr(Bematech_FI_NumeroSerieMFD(Result));
end;

destructor TBematech.Destroy;
begin
  fFinaliza;
end;

{**************************************}
{* ANALIZA MENSAGEM DE ERRO           *}
{***********************************AF*}
function TBematech.fVerErro(blnMostraErro: Boolean = True): Boolean;
  Var
    intACK: Integer;
    intST1: Integer;
    intST2: Integer;
    intST3: Integer;
    strMen: String;
    intCodErr: Integer;
    strCodErr: String;
Begin

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

    {***********************************}
    {* CHECA SENSORES DA IMPRESSORA    *}
    {********************************AF*}
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

    //intCodErr := ( StrToIntDef(FCodErr, -1) * -1 );
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
      Begin
        fMensagem('',strMen,['&OK']);
      End;

    End;

  End;
End;

{**************************************}
{* CANCELA ITEM                       *}
{***********************************AF*}
function TBematech.fCancelaItem(strItem: String): Boolean;
Begin
  FCodErr := IntToStr(Bematech_FI_CancelaItemGenerico( PChar(strItem) ));
  Result  := fVerErro;
End;

{*******************************************}
{* CÁLCULO DA ALÍQUOTA DE ICMS             *}
{* COPIADA DO AUTCOM                       *}
{****************************************RL*}
function TBematech.fCalcAliquota(strCodFiscal: String; fltAliquota: Double; intTipRet: Integer = 1): String;
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
  If Pos( strCodFiscal, '_040_050_' ) > 0 Then
    strAliquota := 'I'

  {*****************************************}
  {* SUBSTITUICAO                          *}
  {**************************************RL*}
  Else If Pos( strCodFiscal, '060_010_160_260_110_210_070_170_270_' ) > 0 Then
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
      strAliquota := FloatToStrF( fCfgSis('ICMSIM', varDouble), ffNumber, 5, 2 )
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

End;

function TBematech.fFechaRelatorioGerencial(blnVerErro: Boolean = True): Boolean;
begin
  FCodErr := IntToStr(Bematech_FI_FechaRelatorioGerencial);
  Result  := fVerErro(blnVerErro);
end;

function TBematech.fRelatorioGerencial(strTexto: String): Boolean;
begin
  FCodErr := IntToStr(Bematech_FI_RelatorioGerencial( PChar(strTexto) ));
  Result  := fVerErro;
end;

procedure TBematech.pPausaLeitura;
begin
  inherited;
  //Sleep(??);
end;

function TBematech.fEspacoEntreLinhas(intEspacos: Integer): Boolean;
begin
  FCodErr := IntToStr(Bematech_FI_LinhasEntreCupons(intEspacos));
  Result  := fVerErro;
end;

function TBematech.fAbreCNFVinculado(strDesFormaPgto, strValor, strNumCupom: String): Boolean;
begin
  FCodErr := IntToStr(Bematech_FI_AbreComprovanteNaoFiscalVinculado( PChar(strDesFormaPgto), PChar(strValor), PChar(strNumCupom)));
  Result  := fVerErro;
end;

function TBematech.fUsaCNFVinculado(strTexto: String): Boolean;
begin
  FCodErr := IntToStr(Bematech_FI_UsaComprovanteNaoFiscalVinculado( PChar(strTexto) ));
  Result  := fVerErro;
end;

function TBematech.fFechaCNFVinculado(blnVerErro: Boolean = True): Boolean;
begin
  FCodErr := IntToStr(Bematech_FI_FechaComprovanteNaoFiscalVinculado);
  Result  := fVerErro(blnVerErro);
end;

function TBematech.fImpLinFiscal(strAtrib, strLinha: String): Boolean;
begin
  Result := True;
end;

function TBematech.fAbrePortaImpressora: Boolean;
begin
  Result := True;
end;

function TBematech.fexecutaCMD(strCmd: String; blnRetorna: Boolean): String;
begin
  Result := '';
end;

procedure TBematech.pFechaPortaImpressora;
begin
  inherited;
  //
end;

function TBematech.fRetTotalImpressora(fltQtdIte,
  fltUnitar: Double): Double;
begin
  Result := fTruncaFloat(fltQtdIte * fltUniTar, 2);
end;

procedure TBematech.pCarregaDataHoraGravSB;
  Var
    strDHUsuario,
    strSWBasico: String;
    strMFAd: Char;
begin

  If (FDataGravacaoSB = 0) Then
  Begin
    SetLength(strDHUsuario, 20);
    SetLength(strSWBasico, 20);
    strMFAd := ' ';

    FCodErr := IntToStr(Bematech_FI_DataHoraGravacaoUsuarioSWBasicoMFAdicional(strDHUsuario, strSWBasico, strMFAd));
    If (Not fVerErro) Then
    Begin
      Raise Exception.Create('Erro ao capturar hora da gravação do software básico.');
    End;

    FDataGravacaoSB := StrToDate(Copy(strSWBasico,1,2) + '/' + Copy(strSWBasico,4,2) + '/' + Copy(strSWBasico,7,4));
    FHoraGravacaoSB := StrToTime(Copy(strSWBasico,12,2) + ':' + Copy(strSWBasico,15,2) + ':' + Copy(strSWBasico,18,2));
  End;
end;

function TBematech.fLeituraMemoriaFiscal(blnCompleta: Boolean; strTipoFiltro, strFiltroIni, strFiltroFin: String): Boolean;
  Var
    strComSim: String;
begin
  //Verificar

  strComSim := IIF(blnCompleta, 'C', 'S');

  If (strTipoFiltro = 'D') Then
  Begin
    FCodErr := IntToStr(Bematech_FI_LeituraMemoriaFiscalDataMFD(strFiltroIni, strFiltroFin, strComSim));
  End
  Else
  Begin
    FCodErr := IntToStr(Bematech_FI_LeituraMemoriaFiscalReducaoMFD(strFiltroIni, strFiltroFin, strComSim));
  End;
  Result := fVerErro(True);
end;

function TBematech.fEspelhoMFD(strTipoFiltro, strFiltroIni, strFiltroFin,
  strArquivoSaida: String): Boolean;
  Var
    strNumSubst: String;
    strTipDow: String;
    intContador: Integer;
begin
  strNumSubst := '';
  For intContador := 1 To 4 Do
    strNumSubst := strNumSubst + ' ';

  strTipDow := IIF(strTipoFiltro = 'D', '1', '2');

  FCodErr := IntToStr(Bematech_FI_NumeroSubstituicoesProprietario(strNumSubst));
  If FCodErr = '1' Then
  Begin
    strNumSubst := Trim(strNumSubst);
    FCodErr := IntToStr(Bematech_FI_DownloadMFD('Download.mfd', strTipDow, strFiltroIni, strFiltroFin, strNumSubst));

    If (FCodErr = '1') Then
    Begin
      FCodErr := IntToStr(Bematech_FI_FormatoDadosMFD('Download.mfd', strArquivoSaida, '0', strTipDow, strFiltroIni, strFiltroFin, strNumSubst));
      Result := fVerErro(True);
    End
    Else
    Begin
      Result := fVerErro(True);
    End;
  End
  Else
  Begin
    Result := fVerErro(True);
  End;

end;

function TBematech.fArquivoMFD(strDataIni, strDataFin, strArquivoSaida, strRazSocEmp, strEndereEmp: String): Boolean;
  Var
    strNumSubst: String;
    intContador: Integer;
begin
  strNumSubst := '';
  For intContador := 1 To 4 Do
    strNumSubst := strNumSubst + ' ';

  FCodErr := IntToStr(Bematech_FI_NumeroSubstituicoesProprietario(strNumSubst));
  If FCodErr = '1' Then
  Begin
    strNumSubst := Trim(strNumSubst);
    FCodErr := IntToStr(Bematech_FI_DownloadMFD('Download.mfd', '1', strDataIni, strDataFin, strNumSubst));

    If (FCodErr = '1') Then
    Begin
      FCodErr := IntToStr(BemaGeraRegistrosTipoE('Download.mfd', strArquivoSaida, strDataIni, strDataFin, strRazSocEmp, strEndereEmp, '', '2', '', '', '', '', '', '', '', '', '', '', '', '', ''));
      Result := True;
    End
    Else
    Begin
      Result := fVerErro(True);
    End;
  End
  Else
  Begin
    Result := fVerErro(True);
  End;
end;

function TBematech.fModeloEcf: String;
begin
  Result := '';
  SetLength(Result, 10);
  FCodErr := IntToStr(Bematech_FI_ModeloImpressora(Result));

  Result := Trim(Result);
end;

function TBematech.fNumeroUsuario: String;
begin
  Result := '';
  SetLength(Result, 4);
  FCodErr := IntToStr(Bematech_FI_NumeroSubstituicoesProprietario(Result));

  Result := fStrZero(Result, 4);
end;

function TBematech.fNumeroCCF: String;
begin
  Result := '';
  SetLength(Result, 6);

  FCodErr := IntToStr(Bematech_FI_ContadorCupomFiscalMFD(Result));
end;

function TBematech.fDataEcf: TDateTime;
  Var
    strData,
    strHora: String;
begin

  strData := '';
  strHora := '';
  SetLength(strData, 6);
  SetLength(strHora, 6);

  FCodErr := IntToStr(Bematech_FI_DataHoraImpressora(strData, strHora));

  If (Not fEmptyStr(strData)) Then
  Begin
    Insert('/', strData, 3);
    Insert('/', strData, 6);

    Result := StrToDate(strData);
  End
  Else
    Result := VS_Date;

end;

function TBematech.fHoraEcf: TDateTime;
  Var
    strData,
    strHora: String;
begin

  strData := '';
  strHora := '';
  SetLength(strData, 6);
  SetLength(strHora, 6);

  FCodErr := IntToStr(Bematech_FI_DataHoraImpressora(strData, strHora));

  If (Not fEmptyStr(strData)) Then
  Begin
    Insert(':', strHora, 3);
    Insert(':', strHora, 6);

    Result := StrToTime(strHora);
  End
  Else
    Result := Time;
end;

function TBematech.fUltimoItemVendido: String;
begin
  Result := '';
  SetLength(Result, 4);
  FCodErr := IntToStr(Bematech_FI_UltimoItemVendido(Result));

  Result := fStrZero(Trim(Result), 4);
end;

function TBematech.fNumeroGNF: String;
begin
  Result := '';
  SetLength(Result, 6);
  FCodErr := IntToStr(Bematech_FI_NumeroOperacoesNaoFiscais(Result));

  Result := fStrZero(Result, 6);
end;

function TBematech.fNumeroGRG: String;
begin
  Result := '';
  SetLength(Result, 6);
  FCodErr := IntToStr(Bematech_FI_ContadorRelatoriosGerenciaisMFD(Result));

  Result := fStrZero(Result, 6);
end;

function TBematech.fNumeroCDC: String;
begin
  Result := '';
  SetLength(Result, 4);
  FCodErr := IntToStr(Bematech_FI_ContadorComprovantesCreditoMFD(Result));

  Result := fStrZero(Result, 4);
end;

function TBematech.fDadosUltimaReducao(Var drzDadosRed: TDadosReducao): Boolean;
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
    strDadosRed: String;
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

    strDtaMov := Copy(strDadosRed, 1273, 06);
    Insert('/', strDtaMov, 3);
    Insert('/', strDtaMov, 6);

    drzDadosRed.strNumCrz   := Copy(strDadosRed, 0009, 04);
    drzDadosRed.strNumCOORZ := Copy(strDadosRed, 0014, 06);
    drzDadosRed.strNumCRO   := Copy(strDadosRed, 0004, 04);
    drzDadosRed.dtaDtaMov   := StrToDate(strDtaMov);
    SetLength(drzDadosRed.arrTotali, 0);

    {*****************************************}
    {* PEGA OS DADOS DA TRIBUTAÇÃO           *}
    {**************************************MV*}
    strAlqIcm := Copy(strDadosRed, intPosAlqIcm, 04);
    strValIcm := Copy(strDadosRed, intPosValIcm, 14);
    While (strAlqIcm <> '0000') Do
    Begin

      intTamMat := Length(drzDadosRed.arrTotali);
      SetLength(drzDadosRed.arrTotali, intTamMat+1);

      drzDadosRed.arrTotali[intTamMat].strCodTot := fStrZero(intConta, 02) + 'T' + strAlqIcm;
      drzDadosRed.arrTotali[intTamMat].fltValAcu := fStrToFloat(strValIcm) / 100;

      Inc(intPosAlqIcm, 04);
      Inc(intPosValIcm, 14);
      Inc(intConta);

      strAlqIcm := Copy(strDadosRed, intPosAlqIcm, 04);
      strValIcm := Copy(strDadosRed, intPosValIcm, 14);
    End;

    For intContador := Low(arrPosTotali) To High(arrPosTotali) Do
    Begin

      intTamMat := Length(drzDadosRed.arrTotali);
      SetLength(drzDadosRed.arrTotali, intTamMat+1);

      strValIcm := Copy(strDadosRed, StrToInt(arrPosTotali[intContador][2]), 14);

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

function TBematech.fVendaBruta: Double;
  Var
    stlMapa: TStringList;
    strVendaBruta: String;
begin
  FCodErr := IntToStr(Bematech_FI_MapaResumo);
  Result := 0;
  If (fVerErro) Then
  Begin
    stlMapa := TStringList.Create;
    stlMapa.LoadFromFile('c:\RETORNO.TXT');

    strVendaBruta := Copy(stlMapa[2], 25, 16);

    Result := fStrToFloat(strVendaBruta);

    FreeAndNil(stlMapa);
  End;
end;

function TBematech.fNumeroCaixa: String;
begin
  Result := FNumCaixa;
end;

function TBematech.fNumeroCNPJUsuario: String;
begin
  Result := FCNPJ;
end;

function TBematech.fNumeroIEUsuario: String;
begin
  Result := FIE;
end;

function TBematech.fVersaoSoftwareBasico: String;
begin
  Result := FVersaoSB;
end;

function TBematech.fDataGravacaoSoftwareBasico: TDateTime;
begin
  pCarregaDataHoraGravSB;
  Result := FDataGravacaoSB;
end;

function TBematech.fHoraGravacaoSoftwareBasico: TDateTime;
begin
  pCarregaDataHoraGravSB;
  Result := FHoraGravacaoSB;
end;

function TBematech.fTipoECF: String;
  Var
    strMarca,
    strModelo: String;
begin

  SetLength(strMarca, 15);
  SetLength(strModelo, 20);
  SetLength(Result, 07);

  FCodErr := IntToStr(Bematech_FI_MarcaModeloTipoImpressoraMFD(strMarca, strModelo, Result));
  Result := Trim(Result);
end;

function TBematech.fMarcaECF: String;
  Var
    strModelo,
    strTipo: String;
begin

  SetLength(Result, 15);
  SetLength(strModelo, 20);
  SetLength(strTipo, 07);

  FCodErr := IntToStr(Bematech_FI_MarcaModeloTipoImpressoraMFD(Result, strModelo, strTipo));
  Result := Trim(Result);
end;

function TBematech.fGrandeTotal: Double;
  Var
    strGrandeTotal: String;
begin
  SetLength(strGrandeTotal, 18);
  FCodErr := IntToStr(Bematech_FI_GrandeTotal(strGrandeTotal));
  Result := 0;

  If (fVerErro) Then
  Begin
    Result := fFormataFloat(fStrToFloat(strGrandeTotal)/100, 2);
  End;
end;

function TBematech.fSangria(fltValor: Double): Boolean;
  Var
    strValor: String;
begin
  strValor := FloatToStrF(fltValor, ffNumber, 12, 2);
  FCodErr := IntToStr(Bematech_FI_Sangria(strValor));

  Result := fVerErro;
end;

function TBematech.fSuprimento(fltValor: Double): Boolean;
  Var
    strValor: String;
begin
  strValor := FloatToStrF(fltValor, ffNumber, 12, 2);
  FCodErr := IntToStr(Bematech_FI_Suprimento(strValor, PChar('Dinheiro')));

  Result := fVerErro;
end;

function TBematech.fGerarSintegra(blnApenas75: Boolean; strArquivo, strMes,
  strAno, strRazSoc, strEndere, strNumEnd, strComple, strBairro, strCidade,
  strNumCep, strFone01, strNumFax, strContat: String): Boolean;
  Var
    intRelatorio: Integer;
begin

  if (blnApenas75) Then
    intRelatorio := 32
  Else
    intRelatorio := 63;

  FCodErr := IntToStr(Bematech_FI_RelatorioSintegraMFD(intrelatorio, strArquivo,
                      strMes, strAno, strRazSoc, strEndere, strNumEnd,
                      strComple, strBairro, strCidade, strNumCep, strFone01,
                      strNumFax, strContat));
  Result := fVerErro;
end;

function TBematech.fUltimoComandoComErro: Boolean;
begin
  Result := blnUltComandoErro;
end;

constructor TBematech.Create(Owner: TComponent);
begin
  
end;

end.


