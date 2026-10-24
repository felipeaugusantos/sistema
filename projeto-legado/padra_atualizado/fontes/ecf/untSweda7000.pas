{**************************************************}
{* UNIT COM AS FUNCOES DO ECF (IMPRESSORA FISCAL) *}
{*                                                *}
{* MODELO....: SWEDA 9000                         *}
{* DATA......: 27/02/2007                         *}
{* AUTOR.....: MARLON ANDREI DE CARVALHO "O MITO" *}
{*                                                *}
{* OBSERVACAO: A Dll da Sweda deve sempre ser     *}
{*             enviada com o Autcom.exe pois      *}
{*             a chamada está estática.           *}
{*             Tentei fazer chamada dinâmica mas  *}
{*             estava dando erro e tinha pouco    *}
{*             tempo.                             *}
{***********************************************MA*}
unit untSweda7000;

interface
{$WARN SYMBOL_PLATFORM OFF}

Uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StrUtils, Math;

type
  TUntSweda7000 = class(TObject)

  constructor Create;

  private


  public

    procedure pSetPatDll( strPatDll: String );
    function  fGetPatDll: String;
    function  fInicia( intPorta: Integer ): Integer;
    function  fFinaliza: Integer;
    function  fEnviaComando( strCmdImp: String ): String;
    function  fLeituraX: String;
    function  fParEcf: String;
    function  fReducaoZ: String;
    function  fAbreGaveta: Integer;
    function  fLeMemFiscal( dtaDtaIni, dtaDtaFin: TDateTime ): String;
    function  fLeMemFiscalReducao( strRedIni, strRedFim: String): String;
    function  fRetorno: String;
    function  fImpressoraLigada: String;
    function  fAbreCupom( CNPJ_CPF: String='' ): String;
    function  fVendeItem( strCodIte, strDescri: String; strAlqTri: String; strTipQtd: String; fltQuanti: Double; intQtdDec: Integer; fltUnitar: Double; strTipDes: String; fltDesEsp: Double): String;
    function  fEfetuaFormaPagamentoIndice( strCodMod: String; fltValFpg: Double; strInfAdi: String ): String;
    function  fTerminaFechamentoCupom( strObserv: String ): String;
    function  fCancelaCupom: String;
    function  fDescEspecial(fltDesEsp: Double): String;
    function  fAcrescimo(fltAcrEsp: Double): String;
    function  fArredonda(fltValor: Double): Double;
    function  fVerificaCupomAberto: Boolean;

  End;

Var
  Sweda7000 : TUntSweda7000;

implementation

uses untfuncoesSimples;

Var
  strDllSweda7000 : String;
  strComando: array[0..512] of Char;

Function AbrePorta(Numero,Timeout:Integer):Boolean; far; Export;
external 'SERSWEDA.DLL' delayed;

Function EnviaComando(Texto1:PChar):ShortString; far; Export;
external 'SERSWEDA.DLL' delayed;

Function FechaPorta(Numero:Integer):Boolean; far; Export;
external 'SERSWEDA.DLL' delayed;

{*****************************************}
{* CONSTRUTOR                            *}
{**************************************MA*}
constructor TUntSweda7000.Create;
begin
  strDllSweda7000 := '';
end;

{*****************************************}
{* SETA PATH DA DLL                      *}
{**************************************MA*}
procedure TUntSweda7000.pSetPatDll( strPatDll: String );
begin
  strDllSweda7000 := strPatDll;
end;

{*****************************************}
{* OBTEM PATH DA DLL                     *}
{**************************************MA*}
function TUntSweda7000.fGetPatDll: String;
begin
  Result := strDllSweda7000;
end;

{*****************************************}
{* INICIA Sweda7000                      *}
{**************************************MA*}
function TUntSweda7000.fInicia( intPorta: Integer ): Integer;
Begin

  If FileExists( strDllSweda7000 ) Then
  Begin

    Try
      AbrePorta( intPorta,5 );
      Result := 0;
    Except
      Result := -999;
    End;

  End
  Else
  Begin
    Result := -999;
  End;

End;

{*****************************************}
{* FINALIZA Sweda7000                    *}
{**************************************MA*}
function TUntSweda7000.fFinaliza: Integer;
Begin

  Try
    FechaPorta( 2 );
    Result := 0;
  Except
    Result := -999;
  End;
    
End;

{*****************************************}
{* ENVIA UM COMANDO PARA IMPRESSORA E    *}
{* RETORNA O RETORNO DELA                *}
{**************************************MA*}
function TUntSweda7000.fEnviaComando( strCmdImp: String ): String;
Begin
  Try
    StrPCopy( strComando, strCmdImp );
    Result := String(EnviaComando( strComando ));
  Except
    Result := 'ERRO-Ocorreu um erro durante o envio de comandos para a impressora !';
  End;
End;

function TUntSweda7000.fVerificaCupomAberto: Boolean;
var strRet: string;
begin
  strRet := fEnviaComando( #27 + '.28' + '}' );
  If Copy( strRet, 10, 1) = 'P' Then
    Result:=True
  Else
    Result:=False; 
end;

{*****************************************}
{* LEITURA X                             *}
{**************************************MA*}
function TUntSweda7000.fLeituraX: String;
begin
  Result := fEnviaComando( #27 + '.13N}' );
end;

{*****************************************}
{* PARAMETROS DA ECF                     *}
{**************************************MA*}
function TUntSweda7000.fParEcf: String;
begin
  Result := fEnviaComando( #27 + '.18}' );
end;

{*****************************************}
{* REDUCAO Z                             *}
{**************************************MA*}
function TUntSweda7000.fReducaoZ: String;
begin
  Result := fEnviaComando( #27 + '.14N' + FormatDateTime( 'DDMMYY', VS_Date ) + '}' );
end;

{*****************************************}
{* RELATORIO GERENCIAL                   *}
{**************************************MA*}
function TUntSweda7000.fLeMemFiscal( dtaDtaIni, dtaDtaFin: TDateTime ): String;
Var
  strDtaIni, strDtaFin: String;
Begin
  strDtaIni := FormatDateTime( 'ddmmyy', dtaDtaIni );
  strDtaFin := FormatDateTime( 'ddmmyy', dtaDtaFin );

  Result := fEnviaComando( #27 + '.16' + strDtaIni + strDtaFin + '}' );
End;

function TUntSweda7000.fLeMemFiscalReducao( strRedIni, strRedFim: String): String;
Begin
  Result := fEnviaComando( #27 + '.15' +  fStrZero(strRedIni,4) + fStrZero(strRedFim,4) + '}' );
End;

{*****************************************}
{* VERIFICA RETORNO DA IMPRESSORA        *}
{**************************************MA*}
function TUntSweda7000.fRetorno: String;
Begin
  Result := fEnviaComando( #27 + '.23}' );
End;

{*****************************************}
{* VERIFICA IMPRESSORA LIGADA            *}
{**************************************MA*}
function TUntSweda7000.fImpressoraLigada: String;
Begin
  Result := fEnviaComando( #27 + '.23}' );
End;

{*****************************************}
{* ABRE CUPOM FISCAL                     *}
{**************************************MA*}
function TUntSweda7000.fAbreCupom( CNPJ_CPF: String='' ): String;
Begin

  Result := fEnviaComando( #27 + '.17' + Trim( CNPJ_CPF ) + '}' );


End;

{*****************************************}
{* VENDE ITEM - Simples!                 *}
{**************************************MA*}
function TUntSweda7000.fVendeItem( strCodIte, strDescri: String; strAlqTri: String; strTipQtd: String; fltQuanti: Double; intQtdDec: Integer; fltUnitar: Double; strTipDes: String; fltDesEsp: Double): String;
Var strQuanti : String;
//    strQtdDec : String;
    strUnitar : String;
    strDesEsp : String;
    fltTotIte : Double;
    strTotIte : String;
    strCmdFin : String;

    strDesAdi: String;
Begin

  strCodIte := fPadr( fStrZero(strCodIte,13), 13 );
  strDescri := fPadr( Copy(strDescri, 1, 24), 24 );

  strDesAdi := Trim(Copy(strDescri, 25, 209));

  strQuanti := fValNumForm( fltQuanti, 7, 3 );
  strUnitar := fValNumForm( fltUnitar, 9, 2 );
  fltTotIte := RoundTo( fFormataFloat( fltQuanti, 2 ) * fFormataFloat( fltUnitar, 2 ), -2 );
  strTotIte := fValNumForm( fltTotIte, 12, 2 );

  If fIsNumber( strAlqTri ) Then
    strAlqTri := 'T' + strAlqTri
  Else
    strAlqTri := fPadr( Trim( strAlqTri ), 3 );

  strCmdFin := #27 + '.01' + strCodIte + strQuanti + strUnitar + strTotIte + strDescri + strAlqTri + strDesAdi + '}';

  Result := fEnviaComando( strCmdFin );


  //Abaixo a aplicação de desconto do Item
  If ( LeftStr( Result, 5 ) = '.+000' ) And ( fltDesEsp > 0.0 ) Then
  Begin
    strDesEsp := fValNumForm( fltDesEsp, 12, 2 );
    Result := fEnviaComando( #27 + '.02          ' + strDesEsp + '}' );
  End;

End;

{*****************************************}
{* ATRIBUI OS VALORES DAS FORMAS DE      *}
{* PAGAMENTO                             *}
{**************************************MA*}
function  TUntSweda7000.fEfetuaFormaPagamentoIndice( strCodMod: String; fltValFpg: Double; strInfAdi: String ): String;
  Var strValFpg: String;
Begin
  strCodMod := RightStr( '00' + Trim( strCodMod ), 2 );
  strValFpg := fValNumForm( fltValFpg, 12, 2 );
  strInfAdi := fPadr( strInfAdi, 80 );

  Result := fEnviaComando( #27 + '.10' + strCodMod + strValFpg + '{' + strInfAdi + '}' );

End;

{*****************************************}
{* FINALIZA O CUPOM                      *}
{**************************************MA*}
function TUntSweda7000.fTerminaFechamentoCupom( strObserv: String ): String;
Begin
  //Indicadores Aqui
  strObserv := strObserv;
  //Result := fEnviaComando( #27 + '.12N0' + strObserv + '}' );
  //Result := fEnviaComando( #27 + '.12N' + strObserv + '}' ); //ALEXANDRE
  Result := fEnviaComando( #27 + '.12NN' + strObserv + '}' );
End;

{*****************************************}
{* RETORNA AS ALIQUOTAS DE ICMS          *}
{**************************************MA*}
//function TUntSweda7000.fRetornaAliquotas( Var strAliquotas: String ): Integer;
//Begin
//
//  strAliquotas := fPadr( strAliquotas, 79 );
//
//  Bematech_FI_RetornoAliquotas := GetProcAddress(Handle, pChar('Bematech_FI_RetornoAliquotas'));
//  Result := Bematech_FI_RetornoAliquotas( strAliquotas );
//  o caminho do risco é o sucesso... Raulzito
//End;

{*****************************************}
{* RETORNA AS ALIQUOTAS DE ICMS          *}
{**************************************MA*}
function TUntSweda7000.fCancelaCupom: String;
Begin
  Result := fEnviaComando( #27 + '.05}' );
End;



//*************************************************//
// FUNCAO QUE ENVIA PARA A IMPRESSORA O DESC. ESP. //
//**********************************************ED*//
function TUntSweda7000.fDescEspecial( fltDesEsp: Double): String;
  Var strValDes: String;

Begin
  strValDes := fValNumForm( fltDesEsp, 12, 2 );
  Result := fEnviaComando( #27 + '.03' + fReplicatorStr(' ',10) + strValDes + 'S' );
end;

function TUntSweda7000.fAcrescimo(fltAcrEsp: Double): String;
  Var
    strAcrEsp: String;
Begin
  strAcrEsp := fValNumForm( fltAcrEsp, 11, 2 );
  Result := fEnviaComando( #27 + '.11510000' + fStrZero(strAcrEsp,11) + 'S' );
End;

function TUntSweda7000.fAbreGaveta: Integer;
begin
    Result := StrToInt(fEnviaComando( #27 + '.21}' ));
end;

function TUntSweda7000.fArredonda(fltValor: Double): Double;
begin
  Result := RoundTo(fltValor,-2);
end;

End.

