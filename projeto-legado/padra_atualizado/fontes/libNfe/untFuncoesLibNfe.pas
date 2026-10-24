{**************************************************************************}
{* UNIT CONTENDO FUNCOES DA LIBNFE QUE SERAO COMPARTILHADAS PELO AUTCOM.  *}
{* MUITO CUIDADO PARA NAO INSERIR DEPENDENCIAS DE OUTRAS UNITS, UMA VEZ   *}
{* QUE ESTA UNIT ESTA SENDO COMPARTILHADA POR MAIS DE UM PROJETO...       *}
{**********************************************************************JC**}
unit untFuncoesLibNfe;

interface

uses
  SysUtils, strUtils;

  function fImprimeSubTributariaDadosProprios(strClaFis, strCfgClaVen, strCfgClaSub: String; blnCfgSimPau: Boolean; strForcaSubTributariaEmDadosProprios: String=''): Boolean;
  function fImprimeIPIDadosProprios(strClaFis, strCfgClaVen, strCfgImpValIpi: String; blnCfgConIpi: Boolean; blnInconsistenciaEFD: Boolean = False): Boolean;
  function fForcaSubTributariaEmDadosProprios(strOpcDoc: String; fltValRet, fltValorFCP, fltValorFCPST: Double; blnInconsistenciaEFD: Boolean = False): Boolean;
  function fGarantiaTemStOuFcpDeSt(strOpcDoc: String; fltValRet, fltValorFCP, fltValorFCPST: Double; blnInconsistenciaEFD: Boolean = False): Boolean;
  function fForcaSubTributariaEmDadosPropriosRegraEspecial(strOpcDoc, strTip_FC, strClaFis, strCodSit: String; blnCfgSimPau: Boolean; fltValRet, fltValorFCP, fltValorFCPST: Double): Boolean;
  function fForcaSubTributariaEmDadosPropriosRegraBrinde(strClaFis: String; fltValRet: Double; blnCfgBri_ST: Boolean): Boolean;

implementation

{**************************************************************************************}
{* - QUANDO FOR CFOP DE VENDA, CONTINUAR COMO E´ HOJE, INFORMANDO ESTES VALORES       *}
{*   NOS CAMPOS PROPRIOS, INDEPENDENTE SE A EMPRESA FOR SUBSTITUIDO OU SUBSTITUTO     *}
{*   E NAO INFORMAR NADA NOS DADOS ADICIONAIS.                                        *}
{*   - QUANDO NAO FOR CFOP DE VENDA, PROCEDER DA SEGUINTE FORMA:                      *}
{*     - SE A EMPRESA FOR 1-SUBSTITUÍDO TRIBUTARIO, IMPRIMIR ZERO NOS CAMPOS PROPRIOS *}
{*       PARA ESTES VALORES e INFORMAR NOS DADOS ADICIONAIS OS MESMOS.                *}
{*     - SE A EMPRESA FOR 2-SUBSTITUTO TRIBUTARIO, IMPRIMIR OS VALORES NOS CAMPOS     *}
{*       PROPRIOS E NAO INFORMAR NADA NOS DADOS ADICIONAIS.                           *}
{***********************************************************************************MV*}
function fImprimeSubTributariaDadosProprios(strClaFis, strCfgClaVen, strCfgClaSub: String; blnCfgSimPau: Boolean; strForcaSubTributariaEmDadosProprios: String=''): Boolean;
begin
  Result := True;
  
  If (strForcaSubTributariaEmDadosProprios = 'S') Then
  Begin
    Result := True;
    Exit;
  End;

  If (Not blnCfgSimPau) And
     ((Trim(strClaFis) = EmptyStr) Or (Pos(strClaFis, strCfgClaVen + '_5603_6603_5152_6152_5409_6409_5659_6659_') > 0)) Then
  Begin
    Result := True;
    Exit;
  End;

  If (strCfgClaSub = '1') Then
  Begin
    Result := False;
    Exit;
  End;
end;

function fImprimeIPIDadosProprios(strClaFis, strCfgClaVen, strCfgImpValIpi: String; blnCfgConIpi: Boolean; blnInconsistenciaEFD: Boolean = False): Boolean;
  Const
    CAMPO_PROPRIO = 'P'; //Campo "Valor do IPI" na Danfe

  Function fRetStrCfgImpValIpi: String;
  Begin
    Result := strCfgImpValIpi; //(P - Campo Próprio; A - Dados Adicionais)
    If Result = EmptyStr Then  //Se a configuração não existir, será sempre no Campo Próprio
      Result := CAMPO_PROPRIO;
  End;

begin
  {*****************************************}
  {* CLASSIFICAÇÃO DE VENDA                *}
  {**************************************MV*}
  If (Trim(strClaFis) = EmptyStr) Or
     (fRetStrCfgImpValIpi = CAMPO_PROPRIO) Or
     (Pos(strClaFis, strCfgClaVen) > 0) Or
     (LeftStr(strClaFis, 1) = '3') Or
     (Pos(RightStr(strClaFis, 3), '152_409_') > 0) Or
     (blnInconsistenciaEFD) Then
    Result := True
  Else
    Result := (blnCfgConIpi) And (fRetStrCfgImpValIpi = CAMPO_PROPRIO);
end;

function fForcaSubTributariaEmDadosProprios(strOpcDoc: String; fltValRet, fltValorFCP, fltValorFCPST: Double; blnInconsistenciaEFD: Boolean = False): Boolean;
begin
  Result := (Pos(strOpcDoc, 'NE_CA_') > 0) And ((fltValRet > 0) Or (fltValorFCP > 0) Or (fltValorFCPST > 0) Or blnInconsistenciaEFD);
end;

function fGarantiaTemStOuFcpDeSt(strOpcDoc: String; fltValRet, fltValorFCP, fltValorFCPST: Double; blnInconsistenciaEFD: Boolean = False): Boolean;
begin
  Result := (strOpcDoc = 'NG') And ((fltValRet > 0) Or (fltValorFCP > 0) Or (fltValorFCPST > 0) Or blnInconsistenciaEFD);
end;

function fForcaSubTributariaEmDadosPropriosRegraEspecial(strOpcDoc, strTip_FC, strClaFis, strCodSit: String; blnCfgSimPau: Boolean; fltValRet, fltValorFCP, fltValorFCPST: Double): Boolean;
var
  blnCst70: Boolean;
begin
  If Length(strCodSit) <> 3 Then
    blnCst70 := Pos('70', strCodSit) > 0
  Else
    blnCst70 := (RightStr(strCodSit, 2) = '70') ;

  Result := (Not blnCfgSimPau) And (strOpcDoc = 'OF') And (strTip_FC = 'F') And (Pos(strClaFis, '5411_6411_') > 0) And
             blnCst70 And (fltValRet > 0) And ((fltValorFCP > 0) Or (fltValorFCPST > 0));
end;

function fForcaSubTributariaEmDadosPropriosRegraBrinde(strClaFis: String; fltValRet: Double; blnCfgBri_ST: Boolean): Boolean;
begin
  Result := False;

  If not blnCfgBri_ST Then
    Exit;

  If not (Pos(strClaFis, '5910_6910_') > 0) Then
    Exit;

  If not (fltValRet > 0) Then
    Exit;

  Result := True;
end;

end.
