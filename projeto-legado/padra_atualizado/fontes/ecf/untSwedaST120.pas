{*******************************************}
{* CLASSE DE IMPRESSÃO DA SWEDA            *}
{* DATA: 04/01/2008                        *}
{* AUTOR: RICARDO DE LIMA                  *}
{****************************************RL*}

unit untSwedaST120;

interface

uses Windows, StrUtils, SysUtils, Uni, Db, Classes, Forms, Variants, UniClientDataSet,
     UniDataSetProvider,  IniFiles, DateUtils, untFiscal, Math,
     Dialogs, MaskUtils, untFuncoesGenerica, untTypesSistema;

type
  RegUltimaZ = record
    ModoRZ: Array[1..2] of char;
    CRO: Array[1..4] of char;
    CRZ: Array[1..4] of char;
    COO: Array[1..6] of char;
    GNF: Array[1..6] of char;
    CCF: Array[1..6] of char;
    GRG: Array[1..6] of char;
    CFD: Array[1..6] of char;
    NFC: Array[1..4] of char;
    CFC: Array[1..4] of char;
    CON: Array[0..29] of Array[0..3] of char;
    CER: Array[0..29] of Array[0..3] of char;
    CDC: Array[1..4] of char;
    CDN: Array[1..4] of char;
    VAZIO: Array[1..4] of char;
    GT: Array[1..18] of char;
    ParciaisTributados: Array[0..15] of Array[0..13] of char;
    I_ICMS: Array[1..14] of char ;
    N_ICMS: Array[1..14] of char ;
    F_ICMS: Array[1..14] of char ;
    I_ISS: Array[1..14] of char ;
    N_ISS: Array[1..14] of char ;
    F_ISS: Array[1..14] of char ;
    D_ICMS: Array[1..14] of char ; // desconto
    D_ISS: Array[1..14] of char ;
    A_ICMS: Array[1..14] of char ; // acrescimo
    A_ISS: Array[1..14] of char ;
    C_ICMS: Array[1..14] of char ; // Cancelamento
    C_ISS: Array[1..14] of char ;
    ParciaisNaoTributados: Array[0..27] of Array[0..13] of char;
    SANGRIA: Array[1..14] of char ;
    SUPRIMENTO: Array[1..14] of char ;
    C_NFISC: Array[1..14] of char ; // Cancelamento nao fiscal
    D_NFISC: Array[1..14] of char ; // Desconto nao fiscal
    A_NFISC: Array[1..14] of char ; // Acréscimo nao fiscal
    Aliquotas: Array[0..15] of Array[0..3] of char;
    DataMovimento: Array[1..6] of char;
  end;

Type TSwedaST120 = class(TFiscal)

  Private
    FPais    : TPais;
    FStatus  : String;
    FImprim  : Boolean;
    blnUltComandoErro: Boolean;

    FNumSerie: AnsiString;
    strAdicional: String;

    FDecUni: AnsiString;
    FDecQtd: AnsiString;

    intDecUni: Integer;
    intDecQtd: Integer;

    strNumCCF: AnsiString;

    procedure pCarregaMFDAdicional;
  Protected
    FImpAtiva: Boolean;
    FHandle: Cardinal;

    FVersaoSB: AnsiString;
    FNumCaixa: AnsiString;
    FCNPJ: AnsiString;
    FIE: AnsiString;

    FMarca: AnsiString;
    FModelo: AnsiString;
    FTipo: AnsiString;

    FNumUsu: AnsiString;

    objIniSweda: TIniFile;
  Public

    function fVerErrSweda(blnMostraErro: Boolean = True): Boolean; Virtual;

	  function fAbreCupom: Boolean; Override;
    function fAbrePortaImpressora: Boolean; Override;
    function fCancelaCupom: Boolean; Override;
    function fRegistraAcrDes(strAcrDes, strTip_AC, strVal_AC: String; fltTotal, fltTotImp: Double): Boolean; Override;
    function fLeituraX(strParam: String = 'N'; blnPergunta: Boolean = True): Boolean; Override;
    function fReducaoZ(strData, strHora: String): Boolean; Override;
    function fexecutaCMD(strCmd: String; blnRetorna: Boolean = False): String; Override;
    function fNumeroSerie: String; Override;
    function fRetornaCOO: String; Override;
    function fVerErro(blnMostraErro: Boolean = True): Boolean; Override;
    function fCalcAliquota(strCodFiscal: String; fltAliquota: Double; intTipRet: Integer = 1): String; Override;
    function fAbreGaveta: Boolean; Override;
    function fCancelaItem(strItem: String):Boolean; Override;
    function fStatusImpressora: String; Override;
    function fRegistraModalidades(strCodMod, strDesMod: String; fltValMod: Double; strInfAdi: String): Boolean; Override;

    function fRegistraItem(strCodIte, strDesIte, strUnidad: String;
      fltAlqIcm, fltQtdIte, fltUnitar: Double; strCodFis: String; fltDesEsp: Double; fltTotal: Double = 0): Boolean; Override;

    function fImpLinFiscal(strAtrib, strLinha: String): Boolean; Override;
    function fFechaCupom: Boolean; Override;

    procedure pFechaPortaImpressora; Override;

    procedure pPausaLeitura; Override;
    function fArredonda(fltValor: Double; intDecimal: Integer): Double; Override;
    function fRetTotalImpressora(fltQtdIte, fltUnitar: Double): Double; override;
    function fRetTotalSistema(fltQtdIte, fltUnitar: Double): Double; override;    

    function fAbreCNFVinculado(strDesFormaPgto, strValor, strNumCupom: String; strQtdPar: String = ''): Boolean; Override;
    function fFechaCNFVinculado(blnMostrarErro: Boolean = True): Boolean; Override;
    function fUsaCNFVinculado(strTexto: String): Boolean; Override;

    function fAbreRelatorioGerencial(blnMostrarErro: Boolean = True): Boolean; override;
    function fRelatorioGerencial(strTexto: String): Boolean; Override;
    function fFechaRelatorioGerencial(blnMostrarErro: Boolean = True): Boolean; Override;

    function fLeituraMemoriaFiscal(blnCompleta: Boolean; strTipoFiltro,
      strFiltroIni, strFiltroFin: String): Boolean; Override;
    function fEspelhoMFD(strTipoFiltro, strFiltroIni, strFiltroFin,
      strArquivoSaida: String): Boolean; Override;
    function fArquivoMFD(strDataIni, strDataFin, strArquivoSaida,
      strRazSocEmp, strEndereEmp: String): Boolean; Override;

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
    function fMFDAdicional: String; override;

    function fSangria(fltValor: Double): Boolean; Override;
    function fSuprimento(fltValor: Double; strModalidade: String='Dinheiro'): Boolean; Override;

    function fGerarSintegra(blnApenas75: Boolean; strArquivo, strMes, strAno,
      strRazSoc, strEndere, strNumEnd, strComple, strBairro, strCidade,
      strNumCep, strFone01, strNumFax, strContat: String): Boolean; Override;

    function fUltimoComandoComErro: Boolean; Override;
    function  fVerificaCupomAberto: Boolean; Override;

    property strStatus: String Read FStatus Write FStatus;
    property blnImprim: Boolean Read FImprim Write FImprim;

    function fEspacoEntreLinhas(intEspacos: Integer): Boolean; Override;

    Constructor Create(Owner: TComponent); Reintroduce;
    Destructor Destroy; Override;

  Protected

    function fTruncaValor(fltValor: Double): Double;
  End;

implementation

uses  untSwedaDeclaracoes, untFuncoes, untConstantes, untFuncoesSimples, untConstantesNFe;

{ TSwedaST120 }

constructor TSwedaST120.Create(Owner: TComponent);
begin
  inherited;
  FPais     := fSetaPais;

  intDecUni := fCfgSis('DECUNI', varInteger);
  intDecQtd := fCfgSis('DECQTD', varInteger);

  FImpAtiva := False;
  fAbrePortaImpressora;

  SetLength(FDecUni, 2);
  SetLength(FDecQtd, 2);
  SetLength(FVersaoSB, 4);
  SetLength(FNumCaixa, 4);
  SetLength(FCNPJ, 20);
  SetLength(FIE, 20);

  SetLength(FMarca, 15);
  SetLength(FModelo, 20);
  SetLength(FTipo, 7);

  SetLength(FNumUsu, 4);

  If ECF_VersaoFirmware(FVersaoSB) <> 1 Then
    Raise Exception.Create('Erro ao capturar versão do software básico.');

  If ECF_NumeroCaixa(FNumCaixa) <> 1 Then
    Raise Exception.Create('Erro ao capturar número do caixa.');

  If ECF_CNPJMFD(FCNPJ) <> 1 Then
    Raise Exception.Create('Erro ao capturar CNPJ do usuário.');

  If ECF_InscricaoEstadualMFD(FIE) <> 1 Then
    Raise Exception.Create('Erro ao capturar IE do usuário.');

  If ECF_MarcaModeloTipoImpressoraMFD(FMarca, FModelo, FTipo) <> 1 Then
    Raise Exception.Create('Erro ao capturar Marca/Modelo/Tipo do ECF.');

  If ECF_NumeroSubstituicoesProprietario(FNumUsu) <> 1 Then
    Raise Exception.Create('Erro ao capturar número do proprietario.');

  SetLength(FNumSerie, 20);
  If ECF_NumeroSerieMFD(FNumSerie) <> 1 Then
    Raise Exception.Create('Erro ao capturar número de série.');

  If ECF_CasasDecimaisProgramada(FDecUni, FDecQtd) <> 1 Then
    Raise Exception.Create('Erro ao capturar a qtd de decimais programada.');

  If (StrToIntDef(String(FDecUni), 0) >= 1) And (StrToIntDef(String(FDecQtd), 0) >= 1) Then
  Begin
    intDecUni := StrToIntDef(String(FDecUni), 0);
    intDecQtd := StrToIntDef(String(FDecQtd), 0);
  End;

  pCarregaMFDAdicional;

end;

destructor TSwedaST120.Destroy;
begin
  pFechaPortaImpressora;

  inherited Destroy;
end;

{***********************************}
{* COMANDO .17 = ABRE CUPOM FISCAL *}
{********************************RL*}
function TSwedaST120.fAbreCupom: Boolean;
  Var
    intContador : Integer;
begin
  strNumCCF := '';

  If intDecUni <= 0 Then
  Begin
    intDecUni := fCfgSis('DECUNI', varInteger);
    intDecQtd := fCfgSis('DECQTD', varInteger);
  End;
  
  strCpfCupomFiscal    := AnsiString(strCpfClie);
  strNomeCupomFiscal   := AnsiString(Copy(strNomCli, 1, 30));
  strEndereCupomFiscal := AnsiString(Copy(strEndCli + ' - ' + strBaiCli, 1, 80));

  For intContador := 1 To 2 Do
  Begin
    ECF_AbreCupomMFD(strCpfCupomFiscal, strNomeCupomFiscal, strEndereCupomFiscal);

//    Sleep(1500);
    Result := fVerErrSweda;

    If Result Then
      Break;

  End;

end;

{*******************************************}
{* ABRE PORTA DA IMPRESSORA                *}
{****************************************RL*}
function TSwedaST120.fAbrePortaImpressora: Boolean;
	Var
    intRetorno: Integer;
begin

  pFechaPortaImpressora;

  Sleep(500);

	Result := True;
  intRetorno := ECF_AbrePortaSerial;
  If intRetorno <> 1 Then
    Result := False;

  FImpAtiva := Result;
end;

{*******************************************}
{* CANCELA CUPOM                           *}
{****************************************RL*}
function TSwedaST120.fCancelaCupom: Boolean;
begin
  ECF_CancelaCupom;
  Result := fVerErrSweda;
end;

{******************************************}
{* ENVIA COMANDO PARA A IMPRESSORA FISCAL *}
{***************************************RL*}
function TSwedaST120.fexecutaCMD(strCmd: String; blnRetorna: Boolean): String;
begin
end;

{*****************************************}
{* COMANDO .13 REALIZA LEITURA X     	   *}
{**************************************RL*}
function TSwedaST120.fLeituraX(strParam: String; blnPergunta: Boolean): Boolean;
begin

  Result    := True;
  blnImprim := True;

  If blnPergunta Then
    If fMensagem('', 'Deseja fazer Leitura "X" ?', ['Sim','Não']) = 1 Then
      blnImprim := True
    Else
    	blnImprim := False;

  If blnImprim Then
  Begin
    ECF_LeituraX;
		Result := fVerErrSweda;
  End;

end;

{*******************************************}
{* RETORNA VALOR TRUNCADO                  *}
{****************************************RL*}
function TSwedaST120.fTruncaValor(fltValor: Double): Double;
	Var
  	strValor: String;
    strAux  : String;
begin

	strValor := FloatToStr(fltValor);
  strValor := FloatToStr(fStrToFloat(strValor));

  If Pos(',',strValor) > 0 Then
	  strAux := MidStr(strValor, 0, Pos(',', strValor) + 2 )
  Else
  	strAux := strValor;


  If fStrToFloat(strValor) <= 0 Then
    strAux := '0'+ FormatSettings.DecimalSeparator + '00';
  Result := StringToFloat(strAux);

end;

{*******************************************}
{* RETORNA ERRO DA IMPRESSORA              *}
{****************************************RL*}
function TSwedaST120.fVerErro(blnMostraErro: Boolean): Boolean;
begin
  Result := fVerErrSweda(blnMostraErro);
end;

{*******************************************}
{* TRATAMENTO DE ERRO DA IMPRESSORA        *}
{****************************************RL*}
function TSwedaST120.fVerErrSweda(blnMostraErro: Boolean): Boolean;
  Var
    intRetorno: Integer;
    sack, st1, st2, st3: Integer;
    strMensagem: String;
begin
  Result := True;
  blnUltComandoErro := False;
  sack := 0;
  st1  := 0;
  st2  := 0;
  st3  := 0;

  intRetorno := ECF_RetornoImpressoraMFD(sack, st1, st2, st3);

  If intRetorno = 1 Then
  Begin
    strMensagem := '';
    case st3 of
      //0:    strMensagem := 'COMANDO OK';
      1:    strMensagem := 'COMANDO INVÁLIDO';
      2:    strMensagem := 'ERRO DESCONHECIDO';
      3:    strMensagem := 'NÚMERO DE PARÂMETRO INVÁLIDO';
      4:    strMensagem := 'TIPO DE PARÂMETRO INVÁLIDO';
      5:    strMensagem := 'TODAS ALÍQUOTAS JÁ PROGRAMADAS';
      6:    strMensagem := 'TOTALIZADOR NÃO FISCAL JÁ PROGRAMADO';
      7:    strMensagem := 'CUPOM FISCAL ABERTO';
      8:    strMensagem := 'CUPOM FISCAL FECHADO';
      9:    strMensagem := 'ECF OCUPADO';
      10:   strMensagem := 'IMPRESSORA EM ERRO';
      11:   strMensagem := 'IMPRESSORA SEM PAPEL';
      12:   strMensagem := 'IMPRESSORA COM CABEÇA LEVANTADA';
      13:   strMensagem := 'IMPRESSORA OFF LINE';
      14:   strMensagem := 'ALÍQUOTA NÃO PROGRAMADA';
      15:   strMensagem := 'TERMINADOR DE STRING FALTANDO';
      16:   strMensagem := 'ACRÉSCIMO OU DESCONTO MAIOR QUE O TOTAL DO CUPOM FISCAL';
      17:   strMensagem := 'CUPOM FISCAL SEM ITEM VENDIDO';
      18:   strMensagem := 'COMANDO NÃO EFETIVADO';
      19:   strMensagem := 'SEM ESPAÇO PARA NOVAS FORMAS DE PAGAMENTO';
      20:   strMensagem := 'FORMA DE PAGAMENTO NÃO PROGRAMADA';
      21:   strMensagem := 'ÍNDICE MAIOR QUE NÚMERO DE FORMA DE PAGAMENTO';
      22:   strMensagem := 'FORMAS DE PAGAMENTO ENCERRADAS';
      23:   strMensagem := 'CUPOM NÃO TOTALIZADO';
      24:   strMensagem := 'COMANDO MAIOR QUE 7Fh (127d)';
      25:   strMensagem := 'CUPOM FISCAL ABERTO E SEM ÍTEM';
      26:   strMensagem := 'CANCELAMENTO NÃO IMEDIATAMENTE APÓS';
      27:   strMensagem := 'CANCELAMENTO JÁ EFETUADO';
      28:   strMensagem := 'COMPROVANTE DE CRÉDITO OU DÉBITO NÃO PERMITIDO OU JÁ EMITIDO';
      29:   strMensagem := 'MEIO DE PAGAMENTO NÃO PERMITE TEF';
      30:   strMensagem := 'SEM COMPROVANTE NÃO FISCAL ABERTO';
      31:   strMensagem := 'COMPROVANTE DE CRÉDITO OU DÉBITO JÁ ABERTO';
      32:   strMensagem := 'REIMPRESSÃO NÃO PERMITIDA';
      33:   strMensagem := 'COMPROVANTE NÃO FISCAL JÁ ABERTO';
      34:   strMensagem := 'TOTALIZADOR NÃO FISCAL NÃO PROGRAMADO';
      35:   strMensagem := 'CUPOM NÃO FISCAL SEM ÍTEM VENDIDO';
      36:   strMensagem := 'ACRÉSCIMO E DESCONTO MAIOR QUE TOTAL CNF';
      37:   strMensagem := 'MEIO DE PAGAMENTO NÃO INDICADO';
      38:   strMensagem := 'MEIO DE PAGAMENTO DIFERENTE DO TOTAL DO RECEBIMENTO';
      39:   strMensagem := 'NÃO PERMITIDO MAIS DE UMA SANGRIA OU SUPRIMENTO';
      40:   strMensagem := 'RELATÓRIO GERENCIAL JÁ PROGRAMADO';
      41:   strMensagem := 'RELATÓRIO GERENCIAL NÃO PROGRAMADO';
      42:   strMensagem := 'RELATÓRIO GERENCIAL NÃO PERMITIDO';
      43:   strMensagem := 'MFD NÃO INICIALIZADA';
      44:   strMensagem := 'MFD AUSENTE';
      45:   strMensagem := 'MFD SEM NÚMERO DE SÉRIE';
      46:   strMensagem := 'MFD JÁ INICIALIZADA';
      47:   strMensagem := 'MFD LOTADA';
      48:   strMensagem := 'CUPOM NÃO FISCAL ABERTO';
      49:   strMensagem := 'MEMÓRIA FISCAL DESCONECTADA';
      50:   strMensagem := 'MEMÓRIA FISCAL SEM NÚMERO DE SÉRIE DA MFD';
      51:   strMensagem := 'MEMÓRIA FISCAL LOTADA';
      52:   strMensagem := 'DATA INICIAL INVÁLIDA';
      53:   strMensagem := 'DATA FINAL INVÁLIDA';
      54:   strMensagem := 'CONTADOR DE REDUÇÃO Z INICIAL INVÁLIDO';
      55:   strMensagem := 'CONTADOR DE REDUÇÃO Z FINAL INVÁLIDO';
      56:   strMensagem := 'ERRO DE ALOCAÇÃO';
      57:   strMensagem := 'DADOS DO RTC INCORRETOS';
      58:   strMensagem := 'DATA ANTERIOR AO ÚLTIMO DOCUMENTO EMITIDO';
      59:   strMensagem := 'FORA DE INTERVENÇÃO TÉCNICA';
      60:   strMensagem := 'EM INTERVENÇÃO TÉCNICA';
      61:   strMensagem := 'ERRO NA MEMÓRIA DE TRABALHO';
      62:   strMensagem := 'JÁ HOUVE MOVIMENTO NO DIA';
      63:   strMensagem := 'BLOQUEIO POR RZ';
      64:   strMensagem := 'FORMA DE PAGAMENTO ABERTA';
      65:   strMensagem := 'AGUARDANDO PRIMEIRO PROPRIETÁRIO';
      66:   strMensagem := 'AGUARDANDO RZ';
      67:   strMensagem := 'ECF OU LOJA IGUAL A ZERO';
      68:   strMensagem := 'CUPOM ADICIONAL NÃO PERMITIDO';
      69:   strMensagem := 'DESCONTO MAIOR QUE TOTAL VENDIDO EM ICMS';
      70:   strMensagem := 'RECEBIMENTO NÃO FISCAL NULO NÃO PERMITIDO';
      71:   strMensagem := 'ACRÉSCIMO OU DESCONTO MAIOR QUE TOTAL NÃO FISCAL';
      72:   strMensagem := 'MEMÓRIA FISCAL LOTADA PARA NOVO CARTUCHO';
      73:   strMensagem := 'ERRO DE GRAVAÇÃO NA MF';
      74:   strMensagem := 'ERRO DE GRAVAÇÃO NA MFD';
      75:   strMensagem := 'DADOS DO RTC ANTERIORES AO ÚLTIMO DOC ARMAZENADO';
      76:   strMensagem := 'MEMÓRIA FISCAL SEM ESPAÇO PARA GRAVAR LEITURAS DA MFD';
      77:   strMensagem := 'MEMÓRIA FISCAL SEM ESPAÇO PARA GRAVAR VERSAO DO SB';
      78:   strMensagem := 'DESCRIÇÃO IGUAL A DEFAULT NÃO PERMITIDO';
      79:   strMensagem := 'EXTRAPOLADO NÚMERO DE REPETIÇÕES PERMITIDAS';
      80:   strMensagem := 'SEGUNDA VIA DO COMPROVANTE DE CRÉDITO OU DÉBITO NÃO PERMITIDO';
      81:   strMensagem := 'PARCELAMENTO FORA DA SEQUÊNCIA';
      82:   strMensagem := 'COMPROVANTE DE CRÉDITO OU DÉBITO ABERTO';
      83:   strMensagem := 'TEXTO COM SEQUÊNCIA DE ESC INVÁLIDA';
      84:   strMensagem := 'TEXTO COM SEQUÊNCIA DE ESC INCOMPLETA';
      85:   strMensagem := 'VENDA COM VALOR NULO';
      86:   strMensagem := 'ESTORNO DE VALOR NULO ';
      87:   strMensagem := 'FORMA DE PAGAMENTO DIFERENTE DO TOTAL DA SANGRIA';
      88:   strMensagem := 'REDUÇÃO NÃO PERMITIDA EM INTERVENÇÃO TÉCNICA';
      89:   strMensagem := 'AGUARDANDO RZ PARA ENTRADA EM INTERVENÇÃO TÉCNICA';
      90:   strMensagem := 'FORMA DE PAGAMENTO COM VALOR NULO NÃO PERMITIDO';
      91:   strMensagem := 'ACRÉSCIMO E DESCONTO MAIOR QUE VALOR DO ÍTEM';
      92:   strMensagem := 'AUTENTICAÇÃO NÃO PERMITIDA';
      93:   strMensagem := 'TIMEOUT NA VALIDAÇÃO';
      94:   strMensagem := 'COMANDO NÃO EXECUTADO EM IMPRESSORA BILHETE DE PASSAGEM';
      95:   strMensagem := 'COMANDO NÃO EXECUTADO EM IMPRESSORA DE CUPOM FISCAL';
      96:   strMensagem := 'CUPOM NÃO FISCAL FECHADO';
      97:   strMensagem := 'PARÂMETRO NÃO ASCII EM CAMPO ASCII';
      98:   strMensagem := 'PARÂMETRO NÃO ASCII NUMÉRICO EM CAMPO ASCII NUMÉRICO';
      99:   strMensagem := 'TIPO DE TRANSPORTE INVÁLIDO';
      100:  strMensagem := 'DATA E HORA INVÁLIDA';
      101:  strMensagem := 'SEM RELATÓRIO GERENCIAL OU COMPROVANTE DE CRÉDITO OU DÉBITO ABERTO';
      102:  strMensagem := 'NÚMERO DO TOTALIZADOR NÃO FISCAL INVÁLIDO';
      103:  strMensagem := 'PARÂMETRO DE ACRÉSCIMO OU DESCONTO INVÁLIDO';
      104:  strMensagem := 'ACRÉSCIMO OU DESCONTO EM SANGRIA OU SUPRIMENTO NÃO PERMITIDO';
      105:  strMensagem := 'NÚMERO DO RELATÓRIO GERENCIAL INVÁLIDO';
      106:  strMensagem := 'FORMA DE PAGAMENTO ORIGEM NÃO PROGRAMADA';
      107:  strMensagem := 'FORMA DE PAGAMENTO DESTINO NÃO PROGRAMADA';
      108:  strMensagem := 'ESTORNO MAIOR QUE FORMA PAGAMENTO';
      109:  strMensagem := 'CARACTER NUMÉRICO NA CODIFICAÇÃO GT NÃO PERMITIDO';
      110:  strMensagem := 'ERRO NA INICIALIZAÇÃO DA MF';
      111:  strMensagem := 'NOME DO TOTALIZADOR EM BRANCO NÃO PERMITIDO';
      112:  strMensagem := 'DATA E HORA ANTERIORES AO ÚLTIMO DOC ARMAZENADO';
      113:  strMensagem := 'PARÂMETRO DE ACRÉSCIMO OU DESCONTO INVÁLIDO';
      114:  strMensagem := 'ÍTEM ANTERIOR AOS TREZENTOS ÚLTIMOS';
      115:  strMensagem := 'ÍTEM NÃO EXISTE OU JÁ CANCELADO';
      116:  strMensagem := 'CÓDIGO COM ESPAÇOS NÃO PERMITIDO';
      117:  strMensagem := 'DESCRICAO SEM CARACTER ALFABÉTICO NÃO PERMITIDO';
      118:  strMensagem := 'ACRÉSCIMO MAIOR QUE VALOR DO ÍTEM';
      119:  strMensagem := 'DESCONTO MAIOR QUE VALOR DO ÍTEM';
      120:  strMensagem := 'DESCONTO EM ISS NÃO PERMITIDO';
      121:  strMensagem := 'ACRÉSCIMO EM ÍTEM JÁ EFETUADO';
      122:  strMensagem := 'DESCONTO EM ÍTEM JÁ EFETUADO';
      123:  strMensagem := 'ERRO NA MEMÓRIA FISCAL CHAMAR CREDENCIADO';
      124:  strMensagem := 'AGUARDANDO GRAVAÇÃO NA MEMÓRIA FISCAL';
      125:  strMensagem := 'CARACTER REPETIDO NA CODIFICAÇÃO DO GT';
      126:  strMensagem := 'VERSÃO JÁ GRAVADA NA MEMÓRIA FISCAL';
      127:  strMensagem := 'ESTOURO DE CAPACIDADE NO CHEQUE';
      128:  strMensagem := 'TIMEOUT NA LEITURA DO CHEQUE';
      129:  strMensagem := 'MÊS INVÁLIDO';
      130:  strMensagem := 'COORDENADA INVÁLIDA';
      131:  strMensagem := 'SOBREPOSIÇÃO DE TEXTO';
      132:  strMensagem := 'SOBREPOSIÇÃO DE TEXTO NO VALOR';
      133:  strMensagem := 'SOBREPOSIÇÃO DE TEXTO NO EXTENSO';
      134:  strMensagem := 'SOBREPOSIÇÃO DE TEXTO NO FAVORECIDO';
      135:  strMensagem := 'SOBREPOSIÇÃO DE TEXTO NA LOCALIDADE';
      136:  strMensagem := 'SOBREPOSIÇÃO DE TEXTO NO OPCIONAL';
      137:  strMensagem := 'SOBREPOSIÇÃO DE TEXTO NO DIA';
      138:  strMensagem := 'SOBREPOSIÇÃO DE TEXTO NO MÊS';
      139:  strMensagem := 'SOBREPOSIÇÃO DE TEXTO NO ANO';
      140:  strMensagem := 'USANDO MFD DE OUTRO ECF';
      141:  strMensagem := 'PRIMEIRO DADO DIFERENTE DE ESC OU 1C';
      142:  strMensagem := 'NÃO PERMITIDO ALTERAR SEM INTERVENÇÃO TÉCNICA';
      143:  strMensagem := 'DADOS DA ÚLTIMA RZ CORROMPIDOS';
      144:  strMensagem := 'COMANDO NÃO PERMITIDO NO MODO INICIALIZAÇÃO';
      145:  strMensagem := 'AGUARDANDO ACERTO DE RELÓGIO';
      146:  strMensagem := 'MFD JÁ INICIALIZADA PARA OUTRA MF';
      147:  strMensagem := 'AGUARDANDO ACERTO DO RELÓGIO OU DESBLOQUEIO PELO TECLADO';
      148:  strMensagem := 'VALOR FORMA DE PAGAMENTO MAIOR QUE MÁXIMO PERMITIDO';
      149:  strMensagem := 'RAZÃO SOCIAL EM BRANCO';
      150:  strMensagem := 'NOME DE FANTASIA EM BRANCO';
      151:  strMensagem := 'ENDEREÇO EM BRANCO';
      152:  strMensagem := 'ESTORNO DE CDC NÃO PERMITIDO';
      153:  strMensagem := 'DADOS DO PROPRIETÁRIO IGUAIS AO ATUAL';
      154:  strMensagem := 'ESTORNO DE FORMA DE PAGAMENTO NÃO PERMITIDO';
      155:  strMensagem := ' DESCRIÇÃO FORMA DE PAGAMENTO IGUAL JÁ PROGRAMADA';
      156:  strMensagem := 'ACERTO DE HORÁRIO DE VERÃO SÓ IMEDIATAMENTE APÓS RZ';
      157:  strMensagem := 'IT NÃO PERMITIDA MF RESERVADA PARA RZ';
      158:  strMensagem := 'SENHA CNPJ INVÁLIDA';
      159:  strMensagem := 'TIMEOUT NA INICIALIZAÇÃO DA NOVA MF';
      160:  strMensagem := 'NÃO ENCONTRADO DADOS NA MFD';
      161:  strMensagem := 'SANGRIA OU SUPRIMENTO DEVEM SER ÚNICOS NO CNF';
      162:  strMensagem := 'ÍNDICE DA FORMA DE PAGAMENTO NULO NÃO PERMITIDO';
      163:  strMensagem := 'UF DESTINO INVÁLIDA';
      164:  strMensagem := 'TIPO DE TRANSPORTE INCOMPATÍVEL COM UF DESTINO';
      165:  strMensagem := 'DESCRIÇÃO DO PRIMEIRO ÍTEM DO BILHETE DE PASSAGEM DIFERENTE DE "TARIFA"';
      166:  strMensagem := 'AGUARDANDO IMPRESSÃO DE CHEQUE OU AUTENTICAÇÃO';
      167:  strMensagem := 'NÃO PERMITIDO PROGRAMAÇAO CNPJ IE COM ESPAÇOS EM BRANCO';
      168:  strMensagem := 'NÃO PERMITIDO PROGRAMAÇÃO UF COM ESPAÇOS EM BRANCO';
      169:  strMensagem := 'NÚMERO DE IMPRESSÕES DA FITA DETALHE NESTA INTERVENÇÃO TÉCNICA ESGOTADO';
      170:  strMensagem := 'CF JÁ SUBTOTALIZADO';
      171:  strMensagem := 'CUPOM NÃO SUBTOTALIZADO';
      172:  strMensagem := 'ACRÉSCIMO EM SUBTOTAL JÁ EFETUADO';
      173:  strMensagem := 'DESCONTO EM SUBTOTAL JÁ EFETUADO';
      174:  strMensagem := 'ACRÉSCIMO NULO NÃO PERMITIDO';
      175:  strMensagem := 'DESCONTO NULO NÃO PERMITIDO';
      176:  strMensagem := 'CANCELAMENTO DE ACRÉSCIMO OU DESCONTO EM SUBTOTAL NÃO PERMITIDO';
      177:  strMensagem := 'DATA INVÁLIDA';
      178:  strMensagem := 'VALOR DO CHEQUE NULO NÃO PERMITIDO';
      179:  strMensagem := 'VALOR DO CHEQUE INVÁLIDO';
      180:  strMensagem := 'CHEQUE SEM LOCALIDADE NÃO PERMITIDO';
      181:  strMensagem := 'CANCELAMENTO ACRÉSCIMO EM ÍTEM NÃO PERMITIDO';
      182:  strMensagem := 'CANCELAMENTO DESCONTO EM ÍTEM NÃO PERMITIDO';
      183:  strMensagem := 'NÚMERO MÁXIMO DE ÍTENS ATINGIDO';
      184:  strMensagem := 'NÚMERO DE ÍTEM NULO NÃO PERMITIDO';
      185:  strMensagem := 'MAIS QUE DUAS ALÍQUOTAS DIFERENTES NO BILHETE DE PASSAGEM NÃO PERMITIDO';
      186:  strMensagem := 'ACRÉSCIMO OU DESCONTO EM ITEM NÃO PERMITIDO';
      187:  strMensagem := 'CANCELAMENTO DE ACRÉSCIMO OU DESCONTO EM ITEM NÃO PERMITIDO';
      188:  strMensagem := 'CLICHE JÁ IMPRESSO';
      189:  strMensagem := 'TEXTO OPCIONAL DO CHEQUE EXCEDEU O MÁXIMO PERMITIDO';
      190:  strMensagem := 'IMPRESSÃO AUTOMÁTICA NO VERSO NÃO PERMITIDO NESTE EQUIPAMENTO';
      191:  strMensagem := 'TIMEOUT NA INSERÇÃO DO CHEQUE';
      192:  strMensagem := 'OVERFLOW NA CAPACIDADE DE TEXTO DO COMPROVANTE DE CRÉDITO OU DÉBITO';
      193:  strMensagem := 'PROGRAMAÇÃO DE ESPAÇOS ENTRE CUPONS MENOR QUE O MÍNIMO PERMITIDO';
      194:  strMensagem := 'EQUIPAMENTO NÃO POSSUI LEITOR DE CHEQUE';
      195:  strMensagem := 'PROGRAMAÇÃO DE ALÍQUOTA COM VALOR NULO NÃO PERMITIDO';
      196:  strMensagem := 'PARÂMETRO BAUD RATE INVÁLIDO';
      197:  strMensagem := 'CONFIGURAÇÃO PERMITIDA SOMENTE PELA PORTA DOS FISCO';
      198:  strMensagem := 'VALOR TOTAL DO ITEM EXCEDE 11 DÍGITOS';
      199:  strMensagem := 'PROGRAMAÇÃO DA MOEDA COM ESPAÇOS EM BRACO NÃO PERMITIDO';
      200:  strMensagem := 'CASAS DECIMAIS DEVEM SER PROGRAMADAS COM 2 OU 3';
      201:  strMensagem := 'NÃO PERMITE CADASTRAR USUÁRIOS DIFERENTES NA MESMA MFD';
      202:  strMensagem := 'IDENTIFICAÇÃO DO CONSUMIDOR NÃO PERMITIDA PARA SANGRIA OU SUPRIMENTO';
      203:  strMensagem := 'CASAS DECIMAIS EM QUANTIDADE MAIOR DO QUE A PERMITIDA';
      204:  strMensagem := 'CASAS DECIMAIS DO UNITÁRIO MAIOR DO QUE O PERMITIDA';
      205:  strMensagem := 'POSIÇÃO RESERVADA PARA ICMS';
      206:  strMensagem := 'POSIÇÃO RESERVADA PARA ISS';
      207:  strMensagem := 'TODAS AS ALÍQUOTAS COM A MESMA VINCULAÇÃO NÃO PERMITIDO';
      208:  strMensagem := 'DATA DE EMBARQUE ANTERIOR A DATA DE EMISSÃO';
    end;

    blnUltComandoErro := (Not fEmptyStr(strMensagem));
    Result := Not blnUltComandoErro;

    If (blnMostraErro) And (Not fEmptyStr(strMensagem)) Then
    Begin
      fMensagem('ATENÇÃO!', strMensagem, ['Ok']);
    End;

  End;
end;

function TSwedaST120.fVerificaCupomAberto: Boolean;
var intFlagFiscal: Integer;
begin
  ECF_FlagsFiscais( intFlagFiscal );
  If (intFlagFiscal = 1) Or (intFlagFiscal = 33) Or (intFlagFiscal = 37) Or (intFlagFiscal = 39) Then
    Result:=True
  Else
    Result:=False;
end;

{*******************************************}
{* FECHA A PORTA DA IMPRESSORA             *}
{****************************************RL*}
procedure TSwedaST120.pFechaPortaImpressora;
begin
  inherited;

  If FImpAtiva Then
    ECF_FechaPortaSerial;
    
  FImpAtiva := False;

end;

{*****************************************}
{* COMANDO .42 = ABRE A GAVETA           *}
{**************************************RL*}
function TSwedaST120.fAbreGaveta: Boolean;
begin

  ECF_AcionaGaveta;
  Result := fVerErrSweda;

end;

{*****************************************}
{* COMANDO .04 = CANCELA ITEM            *}
{**************************************RL*}
function TSwedaST120.fCancelaItem(strItem: String): Boolean;
begin
  inherited;

  strItem := fStrZero(strItem,3);
  ECF_CancelaItemGenerico(AnsiString(strItem));
  Result := fVerErrSweda;

end;

{**********************************************}
{* COMANDO .08 = IMPRIME UMA LINHA NÃO FISCAL *}
{*******************************************RL*}
function TSwedaST120.fImpLinFiscal(strAtrib, strLinha: String): Boolean;
begin
  inherited;

  ECF_UsaRelatorioGerencialMFD(AnsiString(strLinha));
  Result := fVerErrSweda;

end;

{*****************************************}
{* COMANDO .14 = REALIZA REDUCAO Z 			 *}
{**************************************RL*}
function TSwedaST120.fReducaoZ(strData, strHora: String): Boolean;
begin
  inherited;

	Result := True;

  If fMensagem('', 'Deseja fazer Redução Z?', ['Sim', 'Não']) = 1 Then
  Begin
    ECF_ReducaoZ(AnsiString(strData), AnsiString(strHora));
		Result := fVerErrSweda;
  End;

end;

{*****************************************}
{* COMANDO .10 = TOTALIZAR CUPOM         *}
{**************************************RL*}
function TSwedaST120.fRegistraModalidades(strCodMod, strDesMod: String; fltValMod: Double;
  strInfAdi: String): Boolean;
  Var
    strValMod: String;
begin
  inherited;

  strValMod := FloatToStrF(fltValMod, ffFixed, 12, 2);
  strValMod := fTiraCaracter(strValMod);
  strValMod := fStrZero(strValMod,12);

  ECF_EfetuaFormaPagamento(AnsiString(strDesMod), AnsiString(strValMod));
  Result := fVerErrSweda;

end;

{**************************************}
{* NÚMERO DE SÉRIE DA IMPRESSORA      *}
{* NÃO FOI IMPLEMENTADO AQUI APENAS   *}
{* NA BEMATECH                        *}
{***********************************AF*}
function TSwedaST120.fNumeroSerie: String;
begin
  Result := String(FNumSerie);
end;

procedure TSwedaST120.pPausaLeitura;
begin
  inherited;
  //
end;

function TSwedaST120.fStatusImpressora: String;
begin
  Result := IntToStr(ECF_VerificaImpressoraLigada);
  If Result = '0' Then
  Begin
    ECF_FechaPortaSerial;
    ECF_AbrePortaSerial;
    Result := IntToStr(ECF_VerificaImpressoraLigada);
  End;
end;

{*******************************************}
{* CÁLCULO DA ALÍQUOTA DE ICMS             *}
{* COPIADA DO AUTCOM                       *}
{****************************************RL*}
function TSwedaST120.fCalcAliquota(strCodFiscal: String; fltAliquota: Double; intTipRet: Integer = 1): String;
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
    qryTmpEcf: TUniQuery;

    strPatIni  : String;
    strCodEcf: String;
Begin

  Result := '';

  strAliquota := '';
  strPatIni := fCfgSis('DIRINI');
  strCodEcf := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'IMPRESSORA'   , '', strPatIni + '/opcoes_fiscal.ini' );

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
  {* SUBSTITUICAO                          *}
  {**************************************RL*}
  Else If Pos( strCodFiscal, CST_SUBSTITUICAO + CST_ANTECIPACAO_ICMS ) > 0 Then
    strAliquota := 'F'

  {*****************************************}
  {* NÃO TRIBUTADO                         *}
  {**************************************MV*}
  Else If Pos( strCodFiscal, CST_NAO_TRIBUTADO) > 0 Then
    strAliquota := 'N'

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
      strAliquota := fPadR( strCODSTB, 3 )
    Else If strAliquota = 'I' Then
      strAliquota := fPadR( strCODISE, 3 )
    Else If strAliquota = 'N' Then
      strAliquota := fPadR( strCODNIN, 3 )
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

function TSwedaST120.fRetornaCOO: String;
  Var
    strNumCoo: AnsiString;
begin
  SetLength(strNumCoo, 6);
  ECF_RetornaCOO(strNumCoo);
  Result := String(strNumCoo);
end;

{*****************************************}
{* COMANDO .01 = REGISTRA ITEM VENDIDO   *}
{**************************************MV*}
function TSwedaST120.fRegistraItem(strCodIte, strDesIte, strUnidad: String;
  fltAlqIcm, fltQtdIte, fltUnitar: Double; strCodFis: String; fltDesEsp: Double; fltTotal: Double = 0): Boolean;
  Var
    strAlqIcm: String;
    strQuanti: String;
    strUnitar: String;
    strDesEsp: String;
    strAcresc: String;
Begin

  If intDecUni < 2 Then
    intDecUni := 2
  Else If intDecUni > 3 Then
    intDecUni := 3;

  If intDecQtd < 2 Then
    intDecQtd := 2
  Else If intDecQtd > 3 Then
    intDecQtd := 3;

  strQuanti := FloatToStrF(fltQtdIte, ffNumber, 7, intDecQtd);
  strUnitar := FloatToStrF(fltUnitar, ffNumber, 9, intDecUni);
  strAlqIcm := fCalcAliquota(strCodFis, fltAlqIcm, 1);

  strQuanti := FloatToStrF(fStrToFloat(strQuanti), ffNumber, 7, 3);
  strUnitar := FloatToStrF(fStrToFloat(strUnitar), ffNumber, 9, 3);

  strDesIte := fTiraCaracEspeciais(strDesIte, False, False, False);
  strDesIte := AnsiReplaceStr(strDesIte, '|', '');

  pCalculaAcrDesItem(Self, fStrToFloat(strQuanti), fStrToFloat(strUnitar),
    fltQtdIte, fltUnitar, fltDesEsp, fltUltDesEspIte, fltUltAcrescIte);

  strDesEsp := FloatToStrF(fltUltDesEspIte, ffNumber, 8, 2);
  strAcresc := FloatToStrF(fltUltAcrescIte, ffNumber, 8, 2);

  ECF_VendeItemDepartamento(AnsiString(strCodIte),
    AnsiString(strDesIte),
    AnsiString(strAlqIcm),
    AnsiString(strUnitar),
    AnsiString(strQuanti),
    AnsiString(strAcresc),
    AnsiString(strDesEsp),
    '',
    AnsiString(strUnidad));

  Result := fVerErrSweda;

  If fIsNumber(strAlqIcm) Then
    strUltIndiceTri := strAlqIcm
  Else
    strUltIndiceTri := LeftStr(strAlqIcm, 1);
end;

function TSwedaST120.fFechaCupom: Boolean;
	Var
  	strMens  : String;
    strLinha01: String;
    strLinha02: String;
    strLinha03: String;
    strLinha04: String;
    strLinha05: String;
    strLinha06: String;
    strLinha07: String;
    strLinha08: String;

    strProcon: String;
    strAle_RJ: String;

    strMinLeg,
    strCupMan,
    strImpPag: string;

    blnImpPag: Boolean;
    intQtdNps: Integer;

    procedure pSetaLinha(strValor: String);
    begin

      If fEmptyStr(strLinha01) Then
        strLinha01 := strValor
      Else If fEmptyStr(strLinha02) Then
        strLinha02 := strValor
      Else If fEmptyStr(strLinha03) Then
        strLinha03 := strValor
      Else If fEmptyStr(strLinha04) Then
        strLinha04 := strValor
      Else If fEmptyStr(strLinha05) Then
        strLinha05 := strValor
      Else If fEmptyStr(strLinha06) Then
        strLinha06 := strValor
      Else If fEmptyStr(strLinha07) Then
        strLinha07 := strValor
      Else If fEmptyStr(strLinha08) Then
        strLinha08 := strValor;
    end;
begin

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

  strLinha01 := '';
  strLinha02 := '';
  strLinha03 := '';
  strLinha04 := '';
  strLinha05 := '';
  strLinha06 := '';
  strLinha07 := '';
  strLinha08 := '';

  blnImpPag := ((fltImpPag <> 0.00) And (fltPeImPg <> 0.00)) Or
               ((fltFedImp <> 0.00) And (fltPeImFd <> 0.00)) Or
               ((fltEstImp <> 0.00) And (fltPeImEs <> 0.00)) Or
               ((fltMunImp <> 0.00) And (fltPeImMn <> 0.00));
  
  If VS_strUsaPaf = 'S' Then
  Begin

    If Not fEmptyStr(strMenPaf01) Then
      pSetaLinha(fstrEspaco(strMenPaf01, 48));

    If Not fEmptyStr(strMenPaf02) Then
      pSetaLinha(fstrEspaco(strMenPaf02, 48));

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
    pSetaLinha(fPadR(strCepCli + ' - ' + strCidCli + '-' + strEstCli, 48));

    If Not blnImpPag Then
      pSetaLinha(fPadR(strCGCCPF + ' - ' + strIESCli, 48));
    //pSetaLinha(fPadR('Vendedor: ' + strNomVen, 48));

  End;

  If blnImpPag Then
  Begin
    If Not fUsaImpostoFonteIBPT Then
    Begin
      If fltImpPag < 1000 Then
        pSetaLinha(fPadR('Vlr.Apr.Trib "R$' + FormatFloat('#,##0.00', fltImpPag) +
                         '(' + FormatFloat('#,##0.00', fltPeImPg) +
                         IIF(fCfgSis('IMPPAG', varInteger) = 1,'%)','%)Fonte:IBPT'), 48))
      Else
        pSetaLinha(fPadR('Vlr.Ap.Tri "R$' + FormatFloat('#,##0.00', fltImpPag) +
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

  If fCfgSis('ORGDFI', varBoolean) Then
  Begin
    strProcon := 'PROCON-'+fCadEmp('ESTADO')+': ' + fCfgSis('TELPRC');
    strAle_RJ := '';
    If (Not fEmptyStr(fCfgSis('TELALE'))) Then
      strAle_RJ := ' - ALERJ: ' + fCfgSis('TELALE');
    pSetaLinha(fPadR(strProcon, 48));
  End
  Else
  Begin
    If fCfgSis('SIMNAC', varBoolean) Then
      pSetaLinha(fPadR( 'ICMS A SER REC. CONF. LC 123/2006 - SIMPLES NAC', 48));
  End;

  If (fCadEmp('ESTADO') = 'MG') And
     (fCfgSis('MINLEG', varBoolean)) Then
  Begin
    //pSetaLinha(fPadR( 'MINAS LEGAL', 40))
    strMinLeg := fPadR( 'MINAS LEGAL:' + Trim(fTiraCaracEspeciais(fNumeroCNPJUsuario, True, True, True)) + ' ' +
                        FormatDateTime('ddmmyyyy', fDataEcf) +
                        fPadL(AnsiReplaceStr(FloatToStrF(fltTotSis, ffNumber, 12, 2), '.', ''), 8, ' '), 48);

    pSetaLinha(strMinLeg);
  End
  Else
  If fCfgSis('CUPMAN', varBoolean) Then
  Begin
    //pSetaLinha(fPadR( 'VALIDO PARA O CUPOM MANIA.ICMS DEVIDO: ' + FormatFloat('#0.00', fltIcmDev), 48));
    strCupMan := fPadR( 'CUPOM MANIA, CONCORRA A PRÊMIOS VEND:' + strNomVen, 48);
    strCupMan := strCupMan + fPadR( 'ENVIE SMS P/ 6789:' + Trim(fTiraCaracEspeciais(fNumeroIEUsuario, True, True)) +
                                    FormatDateTime('ddmmyyyy', fDataEcf) +
                                    fRetornaCOO +
                                    RightStr(fNumeroCaixa, 3), 48);
    pSetaLinha(strCupMan);
  End;

  If(fEmptyStr(strMinLeg) And fEmptyStr(strCupMan)) Then
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
  strMens := strMens + fstrEspaco(strLinha01, 48);
  strMens := strMens + fstrEspaco(strLinha02, 48);
  strMens := strMens + fstrEspaco(strLinha03, 48);
  strMens := strMens + fstrEspaco(strLinha04, 48);
  strMens := strMens + fstrEspaco(strLinha05, 48);
  strMens := strMens + fstrEspaco(strLinha06, 48);
  strMens := strMens + fstrEspaco(strLinha07, 48);
  strMens := strMens + fstrEspaco(strLinha08, 48);

  ECF_TerminaFechamentoCupom(AnsiString(strMens));


  Result := fVerErrSweda;
  strCodCli := '';
end;

function TSwedaST120.fArredonda(fltValor: Double; intDecimal: Integer): Double;
begin
  Result := RoundTo(fltValor, -intDecimal);
end;

function TSwedaST120.fRegistraAcrDes(strAcrDes, strTip_AC, strVal_AC: String;
  fltTotal, fltTotImp: Double): Boolean;
  Var
    fltValDes: Double;
    strDesEsp: String;
begin
  strAcrDes := 'D';
  fltValDes := 0;
  strTip_AC := '$';

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

  ECF_IniciaFechamentoCupom(AnsiString(strAcrDes), AnsiString(strTip_AC), AnsiString(strDesEsp));

  Result := fVerErrSweda;
end;

function TSwedaST120.fAbreCNFVinculado(strDesFormaPgto, strValor,
  strNumCupom: String; strQtdPar: String = ''): Boolean;
begin
  ECF_AbreComprovanteNaoFiscalVinculado(AnsiString(strDesFormaPgto),
    AnsiString(strValor), AnsiString(strNumCupom));
  Result := fVerErrSweda;
end;

function TSwedaST120.fArquivoMFD(strDataIni, strDataFin, strArquivoSaida,
  strRazSocEmp, strEndereEmp: String): Boolean;
  Var
    intRetorno: Integer;
begin
  Try
    StrToDate(strDataIni);
  Except
    strDataIni := fStrZero(strDataIni, 7);
    strDataFin := fStrZero(strDataFin, 7);
  End;

  intRetorno := ECF_DownloadMF('Download.bin');
  If (intRetorno = 1) Then
  Begin
    ECF_ReproduzirMemoriaFiscalMFD('2', AnsiString(strDataIni), AnsiString(strDataFin), AnsiString(strArquivoSaida), '');

    Result := fVerErro(True);
  End
  Else
    Result := fVerErro(True);

end;

function TSwedaST120.fDadosUltimaReducao(
  var drzDadosReducao: TDadosReducao): Boolean;
  Var
    strData: String;
    arrDados : AnsiString;
    strDados: String;
    recUltimaZ: RegUltimaZ;
    intContador: Integer;
    intQtdTri: Integer;
    fltTotOpnf: Double;
begin
  fltTotOpnf := 0.0;

  SetLength(arrDados, 3020);

  If ECF_DadosUltimaReducaoMFD(PAnsiChar(arrDados)) = 1 Then
  Begin
    strDados := AnsiReplaceStr(String(arrDados), ',', '');

    CopyMemory(@recUltimaZ, PChar(strDados), SizeOf(recUltimaZ));

    drzDadosReducao.strNumCrz   := recUltimaZ.CRZ;
    drzDadosReducao.strNumCOORZ := recUltimaZ.COO;
    drzDadosReducao.strNumCRO   := recUltimaZ.CRO;

    strData := recUltimaZ.DataMovimento;

    Insert('/', strData, 3);
    Insert('/', strData, 6);

    drzDadosReducao.dtaDtaMov   := StrToDate(strData);

    {*****************************************}
    {* CARREGA OS TOTALIZADORES TRIBUTADOS   *}
    {**************************************MV*}
    For intContador := Low(recUltimaZ.ParciaisNaoTributados) To High(recUltimaZ.ParciaisNaoTributados) Do
    Begin
      If (Not fEmptyStr(recUltimaZ.ParciaisNaoTributados[intContador]))              And
         (LeftStr(StrPas(recUltimaZ.ParciaisNaoTributados[intContador]), 14) <> '00000000000000') Then
        fltTotOpnf := fltTotOpnf + (fStrToFloat(recUltimaZ.ParciaisNaoTributados[intContador]));
    End;

    intQtdTri := 0;
    For intContador := Low(recUltimaZ.Aliquotas) To High(recUltimaZ.Aliquotas) Do
    Begin
      If (Not fEmptyStr(recUltimaZ.Aliquotas[intContador]))    And
         (LeftStr(StrPas(recUltimaZ.Aliquotas[intContador]), 4) <> '0000') Then
        Inc(intQtdTri);
    End;

    SetLength(drzDadosReducao.arrTotali, intQtdTri + 13);

    intQtdTri := 0;
    For intContador := Low(recUltimaZ.Aliquotas) To High(recUltimaZ.Aliquotas) Do
    Begin
      If (Not fEmptyStr(recUltimaZ.Aliquotas[intContador]))    And
         (LeftStr(StrPas(recUltimaZ.Aliquotas[intContador]), 4) <> '0000') Then
      Begin
        drzDadosReducao.arrTotali[intQtdTri].strCodTot := fStrZero(intContador+1, 2) + 'T' + recUltimaZ.Aliquotas[intContador];
        drzDadosReducao.arrTotali[intQtdTri].fltValAcu := fStrToFloat(recUltimaZ.ParciaisTributados[intContador]) / 100;
        Inc(intQtdTri);
      End;
    End;

    drzDadosReducao.arrTotali[intQtdTri].strCodTot := 'F1';
    drzDadosReducao.arrTotali[intQtdTri].fltValAcu := fStrToFloat(recUltimaZ.F_ICMS) / 100;
    Inc(intQtdTri);

    drzDadosReducao.arrTotali[intQtdTri].strCodTot := 'I1';
    drzDadosReducao.arrTotali[intQtdTri].fltValAcu := fStrToFloat(recUltimaZ.I_ICMS) / 100;
    Inc(intQtdTri);

    drzDadosReducao.arrTotali[intQtdTri].strCodTot := 'N1';
    drzDadosReducao.arrTotali[intQtdTri].fltValAcu := fStrToFloat(recUltimaZ.N_ICMS) / 100;
    Inc(intQtdTri);

    drzDadosReducao.arrTotali[intQtdTri].strCodTot := 'FS1';
    drzDadosReducao.arrTotali[intQtdTri].fltValAcu := fStrToFloat(recUltimaZ.F_ISS) / 100;
    Inc(intQtdTri);

    drzDadosReducao.arrTotali[intQtdTri].strCodTot := 'Is1';
    drzDadosReducao.arrTotali[intQtdTri].fltValAcu := fStrToFloat(recUltimaZ.I_ISS) / 100;
    Inc(intQtdTri);

    drzDadosReducao.arrTotali[intQtdTri].strCodTot := 'NS1';
    drzDadosReducao.arrTotali[intQtdTri].fltValAcu := fStrToFloat(recUltimaZ.N_ISS) / 100;
    Inc(intQtdTri);

    drzDadosReducao.arrTotali[intQtdTri].strCodTot := 'OPNF';
    drzDadosReducao.arrTotali[intQtdTri].fltValAcu := fltTotOpnf / 100;
    Inc(intQtdTri);

    drzDadosReducao.arrTotali[intQtdTri].strCodTot := 'DT';
    drzDadosReducao.arrTotali[intQtdTri].fltValAcu := fStrToFloat(recUltimaZ.D_ICMS) / 100;
    Inc(intQtdTri);

    drzDadosReducao.arrTotali[intQtdTri].strCodTot := 'DS';
    drzDadosReducao.arrTotali[intQtdTri].fltValAcu := fStrToFloat(recUltimaZ.D_ISS) / 100;
    Inc(intQtdTri);

    drzDadosReducao.arrTotali[intQtdTri].strCodTot := 'AT';
    drzDadosReducao.arrTotali[intQtdTri].fltValAcu := fStrToFloat(recUltimaZ.A_ICMS) / 100;
    Inc(intQtdTri);

    drzDadosReducao.arrTotali[intQtdTri].strCodTot := 'AS';
    drzDadosReducao.arrTotali[intQtdTri].fltValAcu := fStrToFloat(recUltimaZ.A_ISS) / 100;
    Inc(intQtdTri);

    drzDadosReducao.arrTotali[intQtdTri].strCodTot := 'Can-T';
    drzDadosReducao.arrTotali[intQtdTri].fltValAcu := fStrToFloat(recUltimaZ.C_ICMS) / 100;
    Inc(intQtdTri);

    drzDadosReducao.arrTotali[intQtdTri].strCodTot := 'Can-S';
    drzDadosReducao.arrTotali[intQtdTri].fltValAcu := fStrToFloat(recUltimaZ.C_ISS) / 100;
    Result := True;
  End
  Else
  Begin
    Result := fVerErro(True);
  End;

end;

function TSwedaST120.fDataEcf: TDateTime;
begin
  Result := VS_Date;
end;

function TSwedaST120.fDataGravacaoSoftwareBasico: TDateTime;
  Var
    strDataUsu  : AnsiString;
    strDataSoft : AnsiString;
    strAdicional: AnsiString;
begin
  SetLength(strDataUsu, 20);
  SetLength(strDataSoft, 20);
  SetLength(strAdicional, 20);

  ECF_DataHoraGravacaoUsuarioSWBasicoMFAdicional(PAnsiChar(strDataUsu), PAnsiChar(strDataSoft), PAnsiChar(strAdicional));

  strDataSoft := AnsiString(fTrataStr(String(strDataSoft)));

  If fEmptyStr(String(strDataSoft)) Then
    Result := 0
  Else
  Begin
    strDataSoft := LeftStr(strDataSoft, 10);

    Result := StrToDate(String(strDataSoft));
  End;
end;

function TSwedaST120.fEspacoEntreLinhas(intEspacos: Integer): Boolean;
begin
  Result := True;
end;

function TSwedaST120.fEspelhoMFD(strTipoFiltro, strFiltroIni, strFiltroFin,
  strArquivoSaida: String): Boolean;
  Var
    strTipo: String;
begin
  If strTipoFiltro = 'C' Then
    strTipo := '2'
  Else
    strTipo := '1';

  ECF_DownloadMFD(AnsiString(strArquivoSaida), AnsiString(strTipo), AnsiString(strFiltroIni), AnsiString(strFiltroFin), '');

  Result := fVerErro(True);
end;

function TSwedaST120.fFechaCNFVinculado(blnMostrarErro: Boolean): Boolean;
begin
  ECF_FechaComprovanteNaoFiscalVinculado;
  Result := fVerErro(blnMostrarErro);
end;

function TSwedaST120.fFechaRelatorioGerencial(blnMostrarErro: Boolean): Boolean;
begin
  ECF_FechaRelatorioGerencial;
  Result := fVerErro(blnMostrarErro);
end;

function TSwedaST120.fGerarSintegra(blnApenas75: Boolean; strArquivo, strMes,
  strAno, strRazSoc, strEndere, strNumEnd, strComple, strBairro, strCidade,
  strNumCep, strFone01, strNumFax, strContat: String): Boolean;
  Var
    intRelatorio: Integer;
begin
  If blnApenas75 Then
    intRelatorio := 32
  Else
    intRelatorio := 63;
    
  ECF_RelatorioSintegraMFD(intRelatorio, AnsiString(strArquivo), AnsiString(strMes), AnsiString(strArquivo),
    AnsiString(strRazSoc), AnsiString(strEndere), AnsiString(strNumEnd), AnsiString(strComple), AnsiString(strBairro), AnsiString(strCidade), AnsiString(strNumCep),
    AnsiString(strFone01), AnsiString(strNumFax), AnsiString(strContat));
    
  Result := fVerErro(True);
end;

function TSwedaST120.fGrandeTotal: Double;
  Var
    strGT: AnsiString;
begin
  SetLength(strGT, 18);
  ECF_GrandeTotal(strGT);
  Result := fStrToFloat(String(strGT)) / 100;
end;

function TSwedaST120.fHoraEcf: TDateTime;
  Var
    strData: AnsiString;
    strHora: AnsiString;
    strResult: String;
begin
  SetLength(strData, 06);
  SetLength(strHora, 06);

  ECF_DataHoraImpressora(strData, strHora);

  strResult := String(strHora);

  Insert(':', strResult, 3);
  Insert(':', strResult, 6);

  Result := StrToTime(strResult);
end;

function TSwedaST120.fHoraGravacaoSoftwareBasico: TDateTime;
  Var
    strDataUsu  : AnsiString;
    strDataSoft : AnsiString;
    strAdicional: AnsiString;

    strHoraSoft : String;
begin
  SetLength(strDataUsu, 20);
  SetLength(strDataSoft, 20);
  SetLength(strAdicional, 20);

  ECF_DataHoraGravacaoUsuarioSWBasicoMFAdicional(PAnsiChar(strDataUsu),
    PAnsiChar(strDataSoft), PAnsiChar(strAdicional));

  strDataSoft := AnsiString(fTrataStr(String(strDataSoft)));

  If fEmptyStr(String(strDataSoft)) Then
    Result := 0
  Else
  Begin
    strHoraSoft := RightStr(Trim(String(strDataSoft)), 08);

    Result := StrToTime(strHoraSoft);
  End;
end;

function TSwedaST120.fLeituraMemoriaFiscal(blnCompleta: Boolean; strTipoFiltro,
  strFiltroIni, strFiltroFin: String): Boolean;
  Var
    strFlag: String;
begin
  Result := false;

  If blnCompleta Then
    strFlag := 'C'
  Else
    strFlag := 'S';

  If (strTipoFiltro = 'D') Then
  Begin
    ECF_LeituraMemoriaFiscalDataMFD(AnsiString(strFiltroIni), AnsiString(strFiltroFin), AnsiString(strFlag));
  End
  Else
  Begin
    ECF_LeituraMemoriaFiscalReducaoMFD(AnsiString(strFiltroIni), AnsiString(strFiltroFin), AnsiString(strFlag));
  End;

end;

function TSwedaST120.fMarcaECF: String;
begin
  Result := String(FMarca);
end;

function TSwedaST120.fModeloEcf: String;
begin
  Result := String(FModelo);
end;

function TSwedaST120.fNumeroCaixa: String;
begin
  Result := String(FNumCaixa);
end;

function TSwedaST120.fNumeroCCF: String;
begin
  If fEmptyStr(String(strNumCCF)) Then
  Begin
    SetLength(strNumCCF, 6);
    ECF_ContadorCupomFiscalMFD(strNumCCF);
  End;

  Result := String(strNumCCF);
end;

function TSwedaST120.fNumeroCDC: String;
  Var
    strNumCDC: String;
begin
  SetLength(strNumCDC, 4);
  ECF_ContadorComprovantesCreditoMFD(AnsiString(strNumCDC));

  Result := strNumCDC;
end;

function TSwedaST120.fNumeroCNPJUsuario: String;
begin
  Result := String(FCNPJ);
end;

function TSwedaST120.fNumeroGNF: String;
  Var
    strNumGNF: AnsiString;
begin
  SetLength(strNumGNF, 6);
  ECF_NumeroOperacoesNaoFiscais(strNumGNF);

  Result := String(strNumGNF);
end;

function TSwedaST120.fNumeroGRG: String;
  Var
    strNumGRG: AnsiString;
begin
  SetLength(strNumGRG, 6);
  ECF_ContadorRelatoriosGerenciaisMFD(strNumGRG);

  Result := String(strNumGRG);
end;

function TSwedaST120.fNumeroIEUsuario: String;
begin
  Result := String(FIE);
end;

function TSwedaST120.fNumeroUsuario: String;
begin
  Result := String(FNumUsu);
end;

function TSwedaST120.fRelatorioGerencial(strTexto: String): Boolean;
begin
  ECF_UsaRelatorioGerencialMFD(AnsiString(strTexto));
  Result := fVerErro;
end;

function TSwedaST120.fSangria(fltValor: Double): Boolean;
begin
  ECF_Sangria(AnsiString(FloatToStrF(fltValor, ffNumber, 12, 2)));
  Result := fVerErro(True);
end;

function TSwedaST120.fSuprimento(fltValor: Double; strModalidade: String='Dinheiro'): Boolean;
  Var
    strFormaPagto: String;
    strValor: String;
begin
  strFormaPagto := strModalidade;
  strValor := FloatToStrF(fltValor, ffNumber, 12, 2);
  strValor := AnsiReplaceStr(strValor, ',', '');

  ECF_Suprimento(AnsiString(strValor), AnsiString(strFormaPagto));
  Result := fVerErro(True);
end;

function TSwedaST120.fTipoECF: String;
begin
  Result := String(FTipo);
end;

function TSwedaST120.fUltimoComandoComErro: Boolean;
begin
  Result := blnUltComandoErro;
end;

function TSwedaST120.fUltimoItemVendido: String;
  Var
    strUltIte: String;
begin
//  SetLength(strUltIte, 4);
//  ECF_UltimoItemVendido(strUltIte);

  objIniSweda := TIniFile.Create(fCfgSis('DIRINI') + '\' + fNumeroSerie + 'ecf.ini');
  strUltIte := fStrZero(objIniSweda.ReadInteger('ECF', 'ULTITE', 0), 4);
  FreeAndNil(objIniSweda);

  Result := strUltIte;

  Result := strUltIte;
end;

function TSwedaST120.fUsaCNFVinculado(strTexto: String): Boolean;
begin
  ECF_UsaComprovanteNaoFiscalVinculado(AnsiString(strTexto));
  Result := fVerErro;
end;

function TSwedaST120.fVendaBruta: Double;
  Var
    strVenBru: String;
begin
  SetLength(strVenBru, 18);
  ECF_VendaBruta(AnsiString(strVenBru));

  Result := fStrToFloat(strVenBru) / 100;
end;

function TSwedaST120.fVersaoSoftwareBasico: String;
begin
  Result := String(FVersaoSB);
end;

function TSwedaST120.fAbreRelatorioGerencial(blnMostrarErro: Boolean): Boolean;
begin
  ECF_AbreRelatorioGerencialMFD('01');
  Result := fVerErro(True);
end;

function TSwedaST120.fMFDAdicional: String;
begin
  Result := LeftStr(Trim(String(strAdicional)), 1);
end;

procedure TSwedaST120.pCarregaMFDAdicional;
  Var
    strDataUsu  : AnsiString;
    strDataSoft : AnsiString;
    strAdicionalLoc : AnsiString;
begin
  SetLength(strDataUsu, 20);
  SetLength(strDataSoft, 20);
  SetLength(strAdicionalLoc, 20);

  If ECF_DataHoraGravacaoUsuarioSWBasicoMFAdicional(PAnsiChar(strDataUsu),
    PAnsiChar(strDataSoft), PAnsiChar(strAdicionalLoc)) <> 1 then
    Raise Exception.Create('Não foi possível capturar a MFD Adicional.');

  strAdicional := LeftStr(Trim(String(strAdicionalLoc)), 1);
end;

function TSwedaST120.fRetTotalImpressora(fltQtdIte, fltUnitar: Double): Double;
  Var
    strValor: String;
begin
  strValor := FloatToStrF(fltQtdIte * fltUnitar, ffFixed, 12, 5);
  Result   := fStrToFloat(LeftStr(strValor, Length(strValor)-3));
end;

function TSwedaST120.fRetTotalSistema(fltQtdIte, fltUnitar: Double): Double;
begin
  If Self.blnApenasItensCheckOutF11 Then
    Result := fTruncaFloat(fltQtdIte * fltUnitar, 2)
  Else
    Result := fFormataFloat(fltQtdIte * fltUnitar, 2);  
end;

end.
