{**************************************************}
{* UNIT COM AS FUNCOES DO ECF (IMPRESSORA FISCAL) *}
{*                                                *}
{* MODELO....: (GENERICA)                         *}
{* DATA......: 27/02/2007                         *}
{* AUTOR.....: MARLON ANDREI DE CARVALHO          *}
{*                                                *}
{***********************************************MA*}
unit untBematech;

interface

Uses
  Windows, Classes, Controls, Uni;

  function Bematech_FI_UsaComprovanteNaoFiscalVinculado( cTexto: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_FechaComprovanteNaoFiscalVinculado: Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_AbreComprovanteNaoFiscalVinculado( cDesFormaPgto, cValor, cNumCupom: AnsiString): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_LinhasEntreCupons( intEspacos: Integer ): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_RelatorioGerencial( cTexto: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_FechaRelatorioGerencial: Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_LeituraX: Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_LeituraMemoriaFiscalDataMFD(DataInicial, DataFinal, FlagLeitura : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_LeituraMemoriaFiscalReducaoMFD(ReducaoInicial, ReducaoFinal, FlagLeitura : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_ReducaoZ(Data: AnsiString; Hora: AnsiString): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_AcionaGaveta: Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_DownloadMFD( Arquivo: AnsiString; TipoDownload: AnsiString; ParametroInicial: AnsiString; ParametroFinal: AnsiString; UsuarioECF: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_NumeroSubstituicoesProprietario( NumeroSubstituicoes: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_RetornoImpressora( Var ACK: Integer; Var ST1: Integer; Var ST2: Integer ): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_VerificaImpressoraLigada: Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_AbreCupom( CGC_CPF: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
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
  function Bematech_FI_LeituraMemoriaFiscalData( DataInicial: AnsiString; DataFinal: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_LeituraMemoriaFiscalReducao( ReducaoInicial: AnsiString; ReducaoFinal: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_ProgramaFormaPagamentoMFD( FormaPagto, OperacaoTef: AnsiString ) : Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_VerificaFormasPagamento( FormasPagamento: AnsiString ) : Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_NomeiaTotalizadorNaoSujeitoIcms( Indice: Integer; Totalizador: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_NumeroSerieMFD(strNumSer: AnsiString): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_NumeroCupom(strNumCoo: AnsiString): Integer; StdCall; External 'BEMAFI32.DLL' delayed;
  function Bematech_FI_VendeItemDepartamento( Codigo: AnsiString; Descricao: AnsiString; Aliquota: AnsiString; ValorUnitario: AnsiString; Quantidade: AnsiString; Acrescimo: AnsiString; Desconto: AnsiString; IndiceDepartamento: AnsiString; UnidadeMedida: AnsiString): Integer; StdCall; External 'BEMAFI32.DLL' delayed;

type
  TarrFormasPagto = Array of String[16];

  TUntBematech = class(TObject)

  constructor Create;

  private
    function fTotalImpressora(fltQtdIte, fltUnitar: Double): Double;
    function fTotalSistema(fltQtdIte, fltUnitar: Double): Double;    

  public
    arrNomesFormasPagto: TarrFormasPagto;

    procedure pSetPatDll( strPatDll: String );
    function  fGetPatDll: String;
    function  fInicia: Integer;
    function  fFinaliza: Integer;

    function  fLeituraX: Integer;
    function  fReducaoZ(strData, strHora: String): Integer;
    function  fAbreGaveta: Integer;
    function  fRelatorioGerencial( Texto: String ): Integer;
    function  fFechaRelatorioGerencial(blnVerErro: Boolean): Integer;

    function  fRetorno( Var ACK: Integer; Var ST1: Integer; Var ST2: Integer ): Integer;
    function  fImpressoraLigada: Integer;
    function  fAbreCupom( CNPJ_CPF: String='' ): Integer;
    function  fVendeItem( strCodIte, strDescri: String; strAlqTri: String; strTipQtd: String;
      fltQuanti: Double; intQtdDec: Integer; fltUnitar: Double; strTipDes: String; strUnidad: String; fltDesEsp: Double): Integer;
    function  fIniciaFechamentoCupom( strAcrDes, strTipDes: String; fltDesEsp: Double ): Integer;
    function  fEfetuaFormaPagamentoIndice( strCodMod: String; fltValFpg: Double ): Integer;
    function  fEfetuaFormaPagamentoDescricao( strCodMod: String; fltValFpg: Double; strDesPar: String ): Integer;
    function  fTerminaFechamentoCupom( strObserv: String ): Integer;
    function  fRetornaAliquotas( Var strAliquotas: String ): Integer;
    function  fCancelaCupom: Integer;
    function  fLeituraMF_Data(strDtaIni, strDtaFin: String): Integer;
    function  fLeituraMF_Reducao(strRedIni, strRedFin: String): Integer;
    function  fNumeroSerie(Var strNumSer: String): Integer;
    function  fRetornaCoo(Var strNumCoo: String): Integer;

    function  fProgramaFormaPagamentoMFD(strFormaPagto, strOperacaoTef: String) : Integer;
    function  fVerificaFormasPagamento(var strFormasPagamento: String) : Integer;
    function  fLeNomesFormasPagamento: Integer;
    procedure pLeNomesFormasPagamentoBanco(Var arrFormasBanco: TarrFormasPagto);
    function  fCadastraFormasPagamento: integer;
    function  fArredonda(fltValor: Double): Double;
    function fAbreCupomVinculado(strDesFormaPgto: String; fltValor: Double;
      strNumCupom: String): Integer;
    function fFechaCupomVinculado: Integer;
    function fUsaCupomVinculado(strTexto: String): Integer;
  End;

Var
  Bematech : TUntBematech;


implementation

uses SysUtils, StrUtils, untfuncoesSimples, untFiscal;

Var
//  Handle : THandle;
  strDllBematech  : String;

  {Bematech_FI_LeituraX: function(): Integer; StdCall;
  Bematech_FI_ReducaoZ: function( Data: String; Hora: String ): Integer; StdCall;
  Bematech_FI_AcionaGaveta: function(): Integer; StdCall;
  Bematech_FI_RelatorioGerencial: function( Texto: String ): Integer; StdCall;
  Bematech_FI_RetornoImpressora: function( Var ACK: Integer; Var ST1: Integer; Var ST2: Integer ): Integer; StdCall;
  Bematech_FI_VerificaImpressoraLigada: function(): Integer; StdCall;
  Bematech_FI_AbreCupom: function( CGC_CPF: Pchar ): Integer; StdCall;
  Bematech_FI_AumentaDescricaoItem: function( Descricao: String ): Integer; StdCall;
  Bematech_FI_VendeItem: function( Codigo: String; Descricao: String; Aliquota: String; TipoQuantidade: String; Quantidade: String; CasasDecimais: Integer; ValorUnitario: String; TipoDesconto: String; Desconto: String): Integer; StdCall;
  Bematech_FI_IniciaFechamentoCupom: function( AcrescimoDesconto: String; TipoAcrescimoDesconto: String; ValorAcrescimoDesconto: String ): Integer; StdCall;
  Bematech_FI_EfetuaFormaPagamentoIndice: function( IndiceFormaPagamento: String; ValorFormaPagamento: String ): Integer; StdCall;
  Bematech_FI_EfetuaFormaPagamentoIndiceDescricaoForma: function( IndiceFormaPagamento: String; ValorFormaPagamento: String; DescricaoParcela: String ): Integer; StdCall;
  Bematech_FI_TerminaFechamentoCupom: function( Mensagem: String ): Integer; StdCall;
  Bematech_FI_RetornoAliquotas: function( Aliquotas: String ): Integer; StdCall;
  Bematech_FI_CancelaCupom: function(): Integer; StdCall;
  Bematech_FI_LeituraMemoriaFiscalData: function( DataInicial: String; DataFinal: String ): Integer; StdCall;
  Bematech_FI_LeituraMemoriaFiscalReducao: function( ReducaoInicial: String; ReducaoFinal: String ): Integer; StdCall;
  Bematech_FI_ProgramaFormaPagamentoMFD: function ( FormaPagto, OperacaoTef: String ) : Integer; StdCall;
  Bematech_FI_VerificaFormasPagamento  : function ( FormasPagamento: String ) : Integer; StdCall;
//  Bematech_FI_NomeiaTotalizadorNaoSujeitoIcms  : function ( Indice: Integer; Totalizador: String ): Integer; StdCall;
  Bematech_FI_NumeroSerieMFD : function (strNumSer: String): Integer; StdCall;
  Bematech_FI_NumeroCupom : function (strNumCoo: String): Integer; StdCall;}


{*****************************************}
{* CONSTRUTOR                            *}
{**************************************MA*}
constructor TUntBematech.Create;
begin
  strDllBematech := '';
end;

{*****************************************}
{* SETA PATH DA DLL                      *}
{**************************************MA*}
procedure TUntBematech.pSetPatDll( strPatDll: String );
begin
  strDllBematech := strPatDll;
end;

{*****************************************}
{* OBTEM PATH DA DLL                     *}
{**************************************MA*}
function TUntBematech.fGetPatDll: String;
begin
  Result := strDllBematech;
end;

{*****************************************}
{* INICIA BEMATECH                       *}
{**************************************MA*}
function TUntBematech.fInicia: Integer;
Begin

//  If FileExists( strDllBematech ) Then
//  Begin
//    Handle := LoadLibrary(PChar(strDllBematech));
    Result := 0;
//  End
//  Else
//  Begin
//    Result := -999;
//  End;

End;

{*****************************************}
{* FINALIZA BEMATECH                     *}
{**************************************MA*}
function TUntBematech.fFinaliza: Integer;
Begin
//  FreeLibrary(Handle);
  Result := 0;
End;

{*****************************************}
{* LEITURA X                             *}
{**************************************MA*}
function TUntBematech.fLeituraX: Integer;
begin
//  Bematech_FI_LeituraX := GetProcAddress(Handle, pChar('Bematech_FI_LeituraX'));
  Result := Bematech_FI_LeituraX();
end;

{*****************************************}
{* REDUCAO Z                             *}
{**************************************MA*}
function TUntBematech.fReducaoZ(strData, strHora: String): Integer;
begin
//  Bematech_FI_ReducaoZ := GetProcAddress(Handle, pChar('Bematech_FI_ReducaoZ'));
  Result := Bematech_FI_ReducaoZ(AnsiString(Trim(strData)),AnsiString(Trim(strHora)));
end;

{*****************************************}
{* RETORNO DA IMPRESSORA                 *}
{**************************************MA*}
function TUntBematech.fRetorno( Var ACK: Integer; Var ST1: Integer; Var ST2: Integer ): Integer;
Begin
//  Bematech_FI_RetornoImpressora := GetProcAddress(Handle, pChar('Bematech_FI_RetornoImpressora'));
  Result := Bematech_FI_RetornoImpressora( ACK, ST1, ST2 );

  //Quando OK retorna ACK = 6 mas ST1 e ST2 = 0
  //Nesse caso nao tem q fazer nada
  If Result = 1 Then
    If ( ST1 + ST2 ) = 0 Then
      Result := 1
    Else
    Begin
      If ST1 = 64 Then
        Result := 1
      Else
        Result := StrToInt( RightStr( '000' + Trim( IntToStr( ACK ) ), 3 ) +
                            RightStr( '000' + Trim( IntToStr( ST1 ) ), 3 ) +
                            RightStr( '000' + Trim( IntToStr( ST2 ) ), 3 ) );
    End;

End;

{*****************************************}
{* RELATORIO GERENCIAL                   *}
{**************************************MA*}
function TUntBematech.fRelatorioGerencial( Texto: String ): Integer;
Begin
//  Bematech_FI_RelatorioGerencial := GetProcAddress(Handle, pChar('Bematech_FI_RelatorioGerencial'));
  Result := Bematech_FI_RelatorioGerencial( AnsiString(Texto) );
End;

{*****************************************}
{* VERIFICA IMPRESSORA LIGADA            *}
{**************************************MA*}
function TUntBematech.fImpressoraLigada: Integer;
Begin
//  Bematech_FI_VerificaImpressoraLigada := GetProcAddress(Handle, pChar('Bematech_FI_VerificaImpressoraLigada'));
  Result := Bematech_FI_VerificaImpressoraLigada();
End;

{*****************************************}
{* ABRE CUPOM FISCAL                     *}
{**************************************MA*}
function TUntBematech.fAbreCupom( CNPJ_CPF: String='' ): Integer;
Begin
//  Bematech_FI_AbreCupom := GetProcAddress(Handle, pChar('Bematech_FI_AbreCupom'));
  Result := Bematech_FI_AbreCupom( AnsiString( CNPJ_CPF ) );
End;

{*****************************************}
{* VENDE ITEM                            *}
{**************************************MA*}
{function TUntBematech.fVendeItem( strCodIte, strDescri: String; strAlqTri: String; strTipQtd: String; fltQuanti: Double; intQtdDec: Integer; fltUnitar: Double; strTipDes: String; fltDesEsp: Double): Integer;
Var //strAlqTri : String;
    strQuanti : String;
    strQtdDec : String;
    strUnitar : String;
    strDesEsp : String;
Begin

  //strDescri := fPadr( strDescri, 29 );
  //strAlqTri := FloatToStrF( fltAlqTri, ffNumber, 5, 2 );
  strQuanti := FloatToStrF( fltQuanti, ffNumber, 7, 3 );
  strQtdDec := RightStr( '00' + Trim( IntToStr( intQtdDec ) ), 2 );
  strUnitar := FloatToStrF( fltUnitar, ffNumber, 8, 2 );
  strDesEsp := FloatToStrF( fltDesEsp, ffNumber, 8, 2 );

//  Bematech_FI_AumentaDescricaoItem := GetProcAddress(Handle, pChar('Bematech_FI_AumentaDescricaoItem'));
//  Result := Bematech_FI_AumentaDescricaoItem( strDescri );

//  Bematech_FI_VendeItem := GetProcAddress(Handle, pChar('Bematech_FI_VendeItem'));
  Result := Bematech_FI_VendeItem( strCodIte, fPadr( strDescri, 29 ), strAlqTri, strTipQtd, strQuanti, intQtdDec, strUnitar, strTipDes, strDesEsp );

End;}

function TUntBematech.fVendeItem( strCodIte, strDescri: String; strAlqTri: String;
  strTipQtd: String; fltQuanti: Double; intQtdDec: Integer; fltUnitar: Double; strTipDes: String;
  strUnidad: String; fltDesEsp: Double): Integer;
  Var
    strQuanti: String;
    strUnitar: String;
    strDesEsp: String;
    strAcresc: String;
    strSigUni: String;
    intContador: Integer;
    blnImpUni: Boolean;
    strModEcf: String;
    intDecUni: Integer;
    fltUltDesEspIte: Double;
    fltUltAcrescIte: Double;
    fltQuantidadeCalcAcrDes: Double;
Begin

  intDecUni := fCfgSis('DECUNI', varInteger);
  If intDecUni > 3 Then
    intDecUni := 3
  Else If intDecUni < 2 Then
    intDecUni := 2;

  strModEcf := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'MODELO'       , '', fCfgSis('DIRINI') + '/opcoes_fiscal.ini' );

  If SameText(strModEcf, BEMATECH_MP20) Then
  Begin
    strQuanti := fPadL(FloatToStrF(fltQuanti, ffNumber, 7, 3), 7, '0');
    fltQuantidadeCalcAcrDes := fStrToFloat(strQuanti);
  End
  Else
  Begin
    strQuanti := AnsiReplaceText(FloatToStrF(fltQuanti, ffNumber, 7, 3), FormatSettings.ThousandSeparator, '');
    strQuanti := AnsiReplaceText(strQuanti, FormatSettings.DecimalSeparator, '');
    strQuanti := fPadL(strQuanti, 7, '0');
    fltQuantidadeCalcAcrDes := fStrToFloat(strQuanti)/1000;
  End;

  If SameText(strModEcf, BEMATECH_MP20) Then
    strUnitar := fPadL(AnsiReplaceText(FloatToStrF(fltUnitar, ffNumber, 9, intDecUni), FormatSettings.ThousandSeparator, ''), 9, '0')
  Else
    strUnitar := fPadL(AnsiReplaceText(FloatToStrF(fltUnitar, ffNumber, 9, 3), FormatSettings.ThousandSeparator, ''), 9, '0');

  pCalculaAcrDesItem(Self.fTotalImpressora, Self.fTotalSistema, fltQuantidadeCalcAcrDes, fStrToFloat(strUnitar),
    fltQuanti, fltUnitar, fltDesEsp, fltUltDesEspIte, fltUltAcrescIte);

  strDesEsp := FloatToStrF(fltUltDesEspIte, ffNumber, 8, 2);
  strAcresc := FloatToStrF(fltUltAcrescIte, ffNumber, 8, 2);

  strSigUni := strUnidad;
  blnImpUni := True;

  For intContador := 1 To length(strUnidad) Do
  Begin
    If (Pos(copy(strUnidad,intContador,1), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ') <= 0) Then
      blnImpUni := False;
  End;

  If Not blnImpUni Then
    strSigUni := 'UN';

  If SameText(strModEcf, BEMATECH_MP20) Then
  Begin
    Bematech_FI_AumentaDescricaoItem(AnsiString(LeftStr(strDescri, 200)));

    strUnitar := Copy(strUnitar, 2, 8);
    strDescri := Copy(strDescri, 1, 29); 

    Result := Bematech_FI_VendeItem(AnsiString(strCodIte), AnsiString(strDescri), AnsiString(strAlqTri),
      'F', AnsiString(strQuanti), intDecUni, AnsiString(strUnitar), AnsiString(strTipDes), AnsiString(strDesEsp));
  End
  Else
  Begin
    Result := Bematech_FI_VendeItemDepartamento(AnsiString(strCodIte), AnsiString(fPadR(strDescri, 57, 200)), AnsiString(strAlqTri),
      AnsiString(strUnitar), AnsiString(strQuanti), AnsiString(strAcresc), AnsiString(strDesEsp), AnsiString('01'), AnsiString( fstrEspaco(strSigUni,2) ));
  End;

  Sleep(StrToIntDef(fCfgSis('IF_DLY'), 0) * 1000);
End;

function TUntBematech.fTotalImpressora(fltQtdIte, fltUnitar: Double): Double;
begin
  Result := fTruncaFloat(fFormataFloat(fltQtdIte, 3) *
                         fFormataFloat(fltUniTar, 3), 2);
end;

function TUntBematech.fTotalSistema(fltQtdIte, fltUnitar: Double): Double;
begin
  Result := fFormataFloat(fltQtdIte * fltUniTar, 2);
end;

{*****************************************}
{* INICIA FECHAMENTO DO CUPOM            *}
{**************************************MA*}
function TUntBematech.fIniciaFechamentoCupom( strAcrDes, strTipDes: String; fltDesEsp: Double ): Integer;
  Var strDesEsp : String;
Begin

  strDesEsp := FloatToStrF( fltDesEsp, ffNumber, 14, 2 );
  strDesEsp := AnsiReplaceStr( strDesEsp, '.', '' );
  strDesEsp := AnsiReplaceStr( strDesEsp, ',', '' );

//  Bematech_FI_IniciaFechamentoCupom := GetProcAddress(Handle, pChar('Bematech_FI_IniciaFechamentoCupom'));
  Result := Bematech_FI_IniciaFechamentoCupom( AnsiString(strAcrDes), AnsiString(strTipDes), AnsiString(strDesEsp) );
End;

{*****************************************}
{* ATRIBUI OS VALORES DAS FORMAS DE      *}
{* PAGAMENTO                             *}
{**************************************MA*}
function  TUntBematech.fEfetuaFormaPagamentoIndice( strCodMod: String; fltValFpg: Double ): Integer;
  Var strValFpg: String;
Begin
  strCodMod := RightStr( '00' + Trim( strCodMod ), 2 );
  strValFpg := FloatToStrF( fltValFpg, ffNumber, 12, 2 );

//  Bematech_FI_EfetuaFormaPagamentoIndice := GetProcAddress(Handle, pChar('Bematech_FI_EfetuaFormaPagamentoIndice'));
  Result := Bematech_FI_EfetuaFormaPagamentoIndice( AnsiString(strCodMod), AnsiString(strValFpg) );
End;

{*****************************************}
{* ATRIBUI OS VALORES DAS FORMAS DE      *}
{* PAGAMENTO                             *}
{**************************************MA*}
function  TUntBematech.fEfetuaFormaPagamentoDescricao( strCodMod: String; fltValFpg: Double; strDesPar: String ): Integer;
  Var strValFpg: String;
Begin
  strCodMod := RightStr( '00' + Trim( strCodMod ), 2 );
  strValFpg := FloatToStrF( fltValFpg, ffNumber, 12, 2 );

  If Not fEmptyStr( strDesPar ) Then
    strDesPar := fPadr( strDesPar, 80 );

//  Bematech_FI_EfetuaFormaPagamentoIndiceDescricaoForma := GetProcAddress(Handle, pChar('Bematech_FI_EfetuaFormaPagamentoIndiceDescricaoForma'));
  Result := Bematech_FI_EfetuaFormaPagamentoIndiceDescricaoForma( AnsiString(strCodMod), AnsiString(strValFpg), AnsiString(strDesPar) );
End;

{*****************************************}
{* FINALIZA O CUPOM                      *}
{**************************************MA*}
function TUntBematech.fTerminaFechamentoCupom( strObserv: String ): Integer;
Begin
//  Bematech_FI_TerminaFechamentoCupom := GetProcAddress(Handle, pChar('Bematech_FI_TerminaFechamentoCupom'));
  Result := Bematech_FI_TerminaFechamentoCupom( AnsiString(strObserv) );
End;

{*****************************************}
{* RETORNA AS ALIQUOTAS DE ICMS          *}
{**************************************MA*}
function TUntBematech.fRetornaAliquotas( Var strAliquotas: String ): Integer;
Begin

  strAliquotas := fPadr( strAliquotas, 79 );

//  Bematech_FI_RetornoAliquotas := GetProcAddress(Handle, pChar('Bematech_FI_RetornoAliquotas'));
  Result := Bematech_FI_RetornoAliquotas( AnsiString(strAliquotas) );

End;

{*****************************************}
{* RETORNA AS ALIQUOTAS DE ICMS          *}
{**************************************MA*}
function TUntBematech.fCancelaCupom: Integer;
Begin
//  Bematech_FI_CancelaCupom := GetProcAddress(Handle, pChar('Bematech_FI_CancelaCupom'));
  Result := Bematech_FI_CancelaCupom();
End;

{*******************************************}
{* ABRE GAVETA                             *}
{****************************************MV*}
function TUntBematech.fAbreGaveta: Integer;
begin
//  Bematech_FI_AcionaGaveta := GetProcAddress(Handle, pChar('Bematech_FI_AcionaGaveta'));
  Result := Bematech_FI_AcionaGaveta();
end;


//*************************************************//
// LEITURA DA MEMORIA FISCAL POR DATA              //
//**********************************************ED*//
function TUntBematech.fLeituraMF_Data(strDtaIni, strDtaFin: String): Integer;
begin

//  Bematech_FI_LeituraMemoriaFiscalData := GetProcAddress(Handle, pChar('Bematech_FI_LeituraMemoriaFiscalData'));
  Result := Bematech_FI_LeituraMemoriaFiscalData( AnsiString( strDtaIni ), AnsiString( strDtaFin));

end;


//*************************************************//
// LEITURA DA MEMORIA FISCAL POR REDUCAO           //
//**********************************************ED*//
function TUntBematech.fLeituraMF_Reducao(strRedIni, strRedFin: String): Integer;
begin

//  Bematech_FI_LeituraMemoriaFiscalReducao := GetProcAddress(Handle, pChar('Bematech_FI_LeituraMemoriaFiscalReducao'));
  Result := Bematech_FI_LeituraMemoriaFiscalReducao( AnsiString( strRedIni ), AnsiString( strRedIni));

end;

{*****************************************}
{* CADASTRA FORMA DE PAGAMENTO           *}
{**************************************LA*}
function TUntBematech.fProgramaFormaPagamentoMFD(strFormaPagto, strOperacaoTef: String) : Integer;
Begin
//  Bematech_FI_ProgramaFormaPagamentoMFD := GetProcAddress(Handle, pChar('Bematech_FI_ProgramaFormaPagamentoMFD'));
  Try
    Result := Bematech_FI_ProgramaFormaPagamentoMFD( AnsiString( strFormaPagto ), AnsiString(strOperacaoTef) );
  Except

    On E: Exception do
    Begin
      Result := 0;
			pMensagensErro(E.Message,'[TUntBematech.fProgramaFormaPagamentoMFD]');
    End;

  End;
End;

function TUntBematech.fVerificaFormasPagamento(var strFormasPagamento: String) : Integer;
Begin
  Try
    strFormasPagamento := fPadr( strFormasPagamento, 3016 );

//  Bematech_FI_VerificaFormasPagamento := GetProcAddress(Handle, pChar('Bematech_FI_VerificaFormasPagamento'));
    Result := Bematech_FI_VerificaFormasPagamento( AnsiString(strFormasPagamento) );
  Except

    On E: Exception do
    Begin
      Result := 0;
			pMensagensErro(E.Message,'[TUntBematech.fVerificaFormasPagamento]');
    End;

  End;
end;

function TUntBematech.fLeNomesFormasPagamento: Integer;
Var
  strNome: string;
  strFormasPagamento: String;
//  intIndex : Integer;
Begin
  Result := fVerificaFormasPagamento(strFormasPagamento);

  If Result <> 1 Then
  Begin
    fMensagem('ATENÇÃO!', 'Erro ao ler as formas de pagamento da impressora!', ['&Ok']);
    Exit;
  End;

  Try
  
    if Result = 1 Then
    Begin

      SetLength(arrNomesFormasPagto,0);
      while pos(',',strFormasPagamento) > 0 Do
      Begin
        strNome := Trim(Copy(strFormasPagamento,1,16));
        If strNome <> '' Then
        Begin
          Setlength(arrNomesFormasPagto,Succ(Length(arrNomesFormasPagto)));
          arrNomesFormasPagto[High(arrNomesFormasPagto)] := ShortString(strNome);
        End;
        Delete(strFormasPagamento,1,pos(',',strFormasPagamento));
      End;

      If Length(arrNomesFormasPagto) > 1 Then
        SetLength(arrNomesFormasPagto,Pred(Length(arrNomesFormasPagto)));
    End;

  Except

    On E: Exception do
    Begin
      Result := 0;
			pMensagensErro(E.Message,'[TUntBematech.fLeNomesFormasPagamento]');
    End;

  End;

End;

procedure TUntBematech.pLeNomesFormasPagamentoBanco(Var arrFormasBanco: TarrFormasPagto);
  Var
    strSQL: String;
    qryGen: TUniQuery;
    strPatIni: String;
Begin
  Try
    SetLength(arrFormasBanco,0);

    qryGen := fCriaQuery;

    strSql := '';
    strSql := strSql + ' SELECT ';
    strSql := strSql + '   * ';
    strSql := strSql + ' FROM ';
    strSql := strSql + ' ECFMOD ';
    strSql := strSql + ' WHERE ';
    strSql := strSql + '   ECF_CODECF = :CODECF ';


    With qryGen Do
    Begin

      Close;
      Sql.Clear;
      Sql.Add(strSql);

      strPatIni := fCfgSis('DIRINI');

      ParamByName('CODECF').AsString := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'IMPRESSORA'   , '', strPatIni + '/opcoes_fiscal.ini' );

      Open;

      First;
      while Not Eof Do
      Begin
        Setlength(arrFormasBanco,Succ(Length(arrFormasBanco)));
        arrFormasBanco[High(arrFormasBanco)] := ShortString(FieldByName('ECF_DESMOD').AsString);
        Next;
      End;

      Close;

    End;
    FreeAndNil(qryGen);

  Except

    On E: Exception do
    Begin
			pMensagensErro(E.Message,'[TUntBematech.pLeNomesFormasPagamentoBanco]');
    End;

  End;
End;

function TUntBematech.fCadastraFormasPagamento: integer;
  Var
    arrFormasBanco: TarrFormasPagto;
    intBanco, intImp: integer;
    blnAchou: boolean;
Begin
  result := fLeNomesFormasPagamento;

  If Result = 1 Then
  Begin

    pLeNomesFormasPagamentoBanco(arrFormasBanco);

    For intBanco := Low(arrFormasBanco) To High(arrFormasBanco) Do
    Begin
      blnAchou := false;
      For intImp := Low(arrNomesFormasPagto) To High(arrNomesFormasPagto) Do
         If SameText(UpperCase(Trim(String(arrFormasBanco[intBanco]))),UpperCase(Trim(String(arrNomesFormasPagto[intImp])))) Then
         Begin
           blnAchou := True;
           Break;
         End;
      If (Not blnAchou) And (Not SameText(String(arrFormasBanco[intBanco]),'DINHEIRO')) Then
        result := fProgramaFormaPagamentoMFD(String(arrFormasBanco[intBanco]),'1');
  
    End;

    SetLength(arrFormasBanco,0);
    SetLength(arrNomesFormasPagto,0);
    
  End;
End;

function TUntBematech.fNumeroSerie(var strNumSer: String): Integer;
begin
  strNumSer := fStrEspaco(' ', 20);
//  Bematech_FI_NumeroSerieMFD  := GetProcAddress(Handle, pChar('Bematech_FI_NumeroSerieMFD'));
  Result := Bematech_FI_NumeroSerieMFD ( AnsiString(strNumSer) );
end;

function TUntBematech.fRetornaCoo(var strNumCoo: String): Integer;
begin
  strNumCoo := fStrEspaco(' ', 6);
//  Bematech_FI_NumeroCupom := GetProcAddress(Handle, pChar('Bematech_FI_NumeroCupom'));
  Result := Bematech_FI_NumeroCupom ( AnsiString(strNumCoo) );
end;

function TUntBematech.fArredonda(fltValor: Double): Double;
begin
  Result := fFormataFloat(fltValor,2);
end;

function TUntBematech.fAbreCupomVinculado(strDesFormaPgto: String; fltValor: Double; strNumCupom: String): Integer;
Begin
  Result := Bematech_FI_AbreComprovanteNaoFiscalVinculado( AnsiString(strDesFormaPgto), '', '');
End;

function TUntBematech.fFechaCupomVinculado: Integer;
Begin
  Result := Bematech_FI_FechaComprovanteNaoFiscalVinculado;
End;

function TUntBematech.fFechaRelatorioGerencial(blnVerErro: Boolean): Integer;
begin
  Result := Bematech_FI_FechaRelatorioGerencial();
end;

function TUntBematech.fUsaCupomVinculado(strTexto: String): Integer;
Begin
  Result := Bematech_FI_UsaComprovanteNaoFiscalVinculado( AnsiString(strTexto));
End;

End.

