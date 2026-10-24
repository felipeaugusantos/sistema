unit untTintaMaquina;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core, untGTinForTipos,
{$ELSE}
  Forms,
  Dialogs,
  Controls,
  ActiveX,
  Windows,
  UniClientDataSet,
  System.Generics.Collections,
  DXCore,
  ExtCtrls,
  Vcl.Themes,
  Vcl.Styles,
  Vcl.SysStyles, // to gain access to TSysPopupStyleHook
  untFuncoesSimples,
  untLogForm,
{$ENDIF}
  untFormulasTinta,
  StrUtils, untIConsulta, untITransferencias, untTypesSistema,
  Uni, Classes, IniFiles, SysUtils, DB,
  untConstantes, untTMatrizSaldosColorantes,
  untIConsultaTinta, untITintasDeMaquina, untIConfTinta,
  untIFatOrdProTintaMaquina, untIConfEmb, untIFuncoesCRM,
  untIDadosTinta, untITintaDeMaquina,  untTipoTinta,
  untILiberacao, untIExecutaSQLReplicacaoTinta,
  untILibTintaDllRelacao, untIFatDefineLotesPedidoWMS, untIFuncoesSaldos;

  function fRetVersionSVN: String; stdcall;
  function fTipoTinta(strIdePro: String): TTipoTinta; stdcall;
  function fRetornaTabelaColoranteTinta(strIdePro: String): String; stdcall;
  function fRetornaCampoDescricaoColorante(strIdePro: String): String;

  procedure pRetItemColorante(strIdePro, strColTinDet: String;
    Var strCodIte, strCodBas: String; const strCodEmp: string); stdcall;
  procedure pRetItemEDescricaoColorante(strIdePro, strColTinDet: String;
    Var strCodIte, strCodBas, strDesBas: String; const strCodEmp: string; strLinha_: String = ''); stdcall;

  function fGetQuantidadeOncaPulsoMl(const fltValor: Double = 0; const strIdePro: string = ''; const strFormul: String = ''): string; stdcall;
  function OncaParaMl(intParteInteira: Integer; fltParteFracao: Double): Double;
  procedure MlParaOnca(fltMl: Double; var intParteInteira: Integer; var fltParteFracao: Double);

  function fTintaBaixaProduto(strIdePro: String): Boolean; stdcall;
  function fTintaBaixaEmbalagem(strIdePro, strTipEmb: String;
    Var strCodIte: String): Boolean; stdcall;

  function fUsaChapinhaTinta(strIdePro: String; strIteTin: String): Boolean; stdcall;
  function fRetornaCodigoChapinha(strIdePro: String): String; stdcall;

  function fTravaQuantidadeTinta(strIdePro, strTipEmb: String;
    fltQtdEmb, fltQtdDig: Double): Boolean; stdcall;

  function fConsultaTintaGeral(strIdePro: String; Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaTintaVenda(strIdePro: String; Sender: TForm; strCodEmp: String;
    qryTinta: TUniQuery): String; stdcall;

  function fRetornaDescricaoTinta(strIdePro, strDesCri: String; qryTinta: TUniQuery; strTipPre: String): String; stdcall;
  function fRetornaReferenciaTinta(strIdePro: String; qryTinta: TUniQuery): String; stdcall;

  function fRetornaPreco(Sender: TForm; qryTinta, qryTintaAux: TUniQuery;
    Var dicRetorno: TDicionario; blnFaturamento, blnPermiteTab: Boolean; sltItems: TStringList): Boolean; stdcall;

  function fRetornaUniTraProTinta(strIdePro: String; qryTinta: TUniQuery;
    fltEmbala, fltQuanti: Double; strTipPre, strIteTin, strCodBas, strTabPre: String;
    strCatalize: String; fltPrcTin, fltPrvTin: Double): Double; stdcall;

  function fRetornaUniTraEmbTinta(strIdePro, strTipEmb, strTipPre: String): Double; stdcall;

  function fGTinForGeral(strIdePro, strIteTin, strTipPre, strLinTin, strCatalize: String;
    intLazQua: Integer; fltQtdEmb: Double; fltQtdIte: Double; strDescri: String;
    qryArqFor: TUniQuery; fltVolPro: Double; Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList;
    strCodDil: string; fltPorDil: Double; strDilCon: String; fltPorCat: Double;
    strTipCor: String; strTextBase: String; intAcao: Integer; strIteCob: String;
    strCodEmpPrd: string; strPerformance: String = ''): Boolean; stdcall;

  function fTintaGeraFormulacao(strIdePro: String): Boolean; stdcall;

  procedure pRetornaDadosTinta(strIdePro, strIteTin: String; dicRetorno: TDicionario); stdcall;

  procedure pSetaParametros(dicParametros    : TDicionario;
                            fGrvMovGer       : TfGravaMovGer;
                            fGrvMovDet       : TfGravaMovDet;
                            {$IFDEF LINUX}
                            objConnManager   : TConnectionsManager;
                            objApplication   : TApplication;
                            {$ELSE}
                            recModulos       : TRecModulosAutcom;
                            {$ENDIF}
                            objTransf        : ITransferencias = Nil;
                            objOrdPro        : IFatOrdProTintaMaquina = Nil; intDebugH: Byte = 0;
                            objLibera        : ILiberacao = Nil;
                            objTraceViewer   : ITraceViewer = nil;
                            objExecSQL       : IExecutaSQLReplicacaoTinta = Nil;
                            objLotePedWMS    : IFatDefineLotesPedidoWMS = Nil;
                            objFuncoesCRM    : IFuncoesCRM = Nil;
                            objFuncoesSaldos : IFuncoesSaldos = Nil;
                            fExecutarConsulta: TfConsulta = nil;
                            blmModoClassico  : Boolean = True;
                            pImprimeImpFat   : TImprimeImpFatTin = Nil); stdcall;

  procedure pSetaEmpresaLogadaTinta(strEmpLog: String); stdcall;

  function fFormulacaoAcumulada(strIdePro: String): Boolean; stdcall;

  procedure pTintaRetornaTabelaPreco(dicRetorno: TDicionario; fltFatorAcerto: Double); stdcall;

  Function fGetFatorML(strIdePro: String): Double; stdcall;

  function fRetSaldoML(strCodIte, strCodEmp: String): Double; stdcall;

  function fTravarEstoque(Var dicRetorno: TDicionario; Var blnLocFor: Boolean): Boolean; stdcall;

  function fVisualizarSaldoTintas(Formulas: TClassMatrizSaldosColorantes; strDescrCompleta : String = ''): Boolean; stdcall;

  function fDesfragmentaTintaSaldosOR(qryGenDor: TDataSet; Var blnLocFor: Boolean; blnRecalculaSaldos: Boolean = True;
    blnImpTintaMaqOutroPedido: Boolean = False; blnProducaoForaDeLoja: Boolean = False): TClassMatrizSaldosColorantes; stdcall;

  function GetMatrizSaldoColorantes(const intPos: Integer; const strCodIte: string; const strIteEmb: string;
    const strIdePro: string; const strIteTin: string; const strTipPre: string; const strLinTin: string;
    const strCatali: string; const intLazQua: Integer; const fltQtdEmb: Double; const fltQtdIte: Double;
    const strDescri: string; const fltVolPro: Double; const strCodDil: string; const fltPorDil: Double;
    const strDilCon: string; const fltPorCat: Double; const strTipCor: string; const strTextBas: string;
    const intModDil: Integer; const strIteCob: string; const strEmpIte: string; const strEmpPrd: string;
    const strNumDoc: string; const strEspDoc: string; const strCodCli: string; const strCodAca: string;
    const strEmpAca: string;
    Var blnLocFor: Boolean): TClassMatrizSaldosColorantes; stdcall;

  function fCalcularTabelasdePreco(strIdePro, strIteTin, strTipPre, strLinTin, strCatalize: String;
    intLazQua: Integer; fltQtdEmb: Double; fltQtdIte: Double; strDescri: String;
    qryArqFor: TUniQuery; fltVolPro: Double; Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList;
    strCodDil: string; fltPorDil: Double; strDilCon: String; fltPorCat: Double;
    strTipCor: String; strTextBase: String; intAcao: Integer; var dicRetorno: TDicionario; strPorPer: String = ''): Boolean; stdcall;

  function fGetConsultaTinta(strIdePro: String): IConsultaTinta; stdcall;
  function fGetTintasdeMaquina(blnDestruir: Boolean = False): ITintasDeMaquina; stdcall;
  function fGetConfTinta(strIdePro: String): IConfTinta; stdcall;
  function fGetConfEmb(strIdePro: String): IConfEmb; stdcall;
  function fGetIndicesTinta(strIdePro: String): IConsultaIndices; stdcall;

  function fRetornaNomeTinta(strIdePro: String; blnExiLib: Boolean = True): String; stdcall;
  function fGetEntradaSaida(const strClaFis: string): string;
  function fGetITintadeMaquina(const dadosTinta: IDadosTinta; const calculadorFatVendas: TObject; dicRetorno: TDicionario = Nil): ITintaDeMaquina; stdcall;

  procedure dxInitializeTin; StdCall;
  procedure dxFinalizeTin; StdCall;

  function fRetornaDicConfigInicialAutcomTinta: TDictionary<string,boolean>; stdcall;
  procedure pIniciaFinalizaDicConfigInicialAutcomTinta(const blnFinaliza: Boolean=False); stdcall;

  function fRetornaSiglaTinta(strIdePro: String; blnExiLib: Boolean = True): String; stdcall;
  function fNomeTabelaFormulacao(strIdePro: String): String; stdcall;

  function fRetornaPrecoTABSemExecutarConsulta(qryTinta: TUniQuery; dicRetorno: TDicionario;
      blnFaturamento, blnPermiteTab: Boolean; strTab: String = 'N'; strAutoTab: String = ''; strLinhaWandaPro: String = '';
      strMD5Key: String = ''; blnSemTela: Boolean = False; strEmbPro: String = ''; strModoVenda: String = ''; strCodDil: String = ''): Boolean;

  function fRetornaPrecoTintaSemTela(const strIdePro, strMD5Key: String; dicRetorno: TDicionario; qryTinta: TUniQuery; var strUltMsg: string;
    strEmbPro: String; strModVen: String; strCodDil: String): Boolean; stdcall;

  procedure pExibeMensagemTintaNaoEncontrada(dicRetorno: TDicionario);

  function fGetLibTintaDLLRelacao: ILibTintaDllRelacao; stdcall;

  Procedure pSetLiberacaoAutcomTinta(objLibera : ILiberacao); stdcall;

  procedure pRegistrarCallbackCarregaMenuTintaMaquina(ACallback: Pointer); stdcall;

Var
  objTintasDeMaquina: ITintasdeMaquina;

  {*****************************************}
  {* FUNÇÕES DE GRAVAÇÃO QUE VEM DO AUTCOM *}
  {**************************************MV*}
  fGravaMovGer      : TfGravaMovGer;
  fGravaMovDet      : TfGravaMovDet;
  objTransfere      : ITransferencias;
  objImpOrdPro      : IFatOrdProTintaMaquina;
  objLiberacao      : ILiberacao;
  objExeSQLRepTinta : IExecutaSQLReplicacaoTinta;
  objLotePedidoWMS  : IFatDefineLotesPedidoWMS;
  objFuncoesCRM     : IFuncoesCRM;
  objFuncoesSaldos  : IFuncoesSaldos;
  pImprimeFatImpTin : TImprimeImpFatTin;

  FCallbackCarregaMenuTintaMaquina: procedure(); stdcall = nil;

implementation

uses

{$IFDEF LINUX}
{$ELSE}
  untModulo, untModuloSPR,
  untSaldoTintas,
  untObservacao,
  untGravando,
{$ENDIF}
  untProdutosAcabados,
  untGlasuritDinamica,
  untSalcomixDinamica,
  Variants,
  Math,  untConfTinta,
  untConfEmb,
  untIAutcomTinta, untAutcomTintaFactory,  untFuncEspecificas, untTintadeMaquinaFactory,
  untClientDataSetFactory,
  untICalculadorFatVendas, untTintasdeMaquina,
  untLibTintaFactory, untILibTinta, untTintadeMaquinaWrapper,
  untUniQueryDataSetWrapper, untDicionarioWrapper, untVerificadorTintaExistente,
  untMatrizSaldosColorantesFactory, untISaldosColorantes,
  untLibTintaDllRelacao, untLiberacaoFactory;

function fRetVersionSVN: String;
{$I rev.inc}
Begin
  Result := SVN_REVISION;
End;

function fTipoTinta(strIdePro: String): TTipoTinta;
var
  tinta: ILibTinta;
begin
  TVerificadorTintaExistente.ExisteTinta(strIdePro);
  tinta := TLibTintaFactory.GetITintadeMaquina(strIdePro);
  if Assigned(tinta) then
  begin
    Result := tinta.fTipoTinta;
    Exit;
  end;

  If (Pos( fRetornaSiglaTinta(strIdePro), fGetTintasdeMaquina().fGetImobiliarias ) > 0) then
    Result := ttImobiliaria
  else if (Pos( fRetornaSiglaTinta(strIdePro), fGetTintasdeMaquina().fGetIndustriais) > 0) Then
    Result := ttIndustrial
  else
    Result := ttAutomotiva;
end;

function fRetornaTabelaColoranteTinta(strIdePro: String): String;
var
  strSigTin: String;
  autcomTinta: IAutcomTinta;
  tinta: ILibTinta;
begin

  Result    := '';
  strSigTin := fRetornaSiglaTinta(strIdePro);

  TVerificadorTintaExistente.ExisteTinta(strSigTin);
  tinta := TLibTintaFactory.GetITintadeMaquina(strSigTin);
  if Assigned(tinta) then
  begin
    Result := tinta.fRetornaTabelaColoranteTinta();
    Exit;
  end;

  autcomTinta := TAutcomTintaFactory.GetIAutcomTinta(strSigTin);
  if Assigned(autcomTinta) then
    Result := autcomTinta.fRetornaTabelaColoranteTinta
  else
  begin

    If strSigTin = 'GLA' Then
      Result := 'GLA_CADBAS'
    Else If strSigTin = 'SAL' Then
      Result := 'SAL_CADBAS';
  end;

end;

function fRetornaCampoDescricaoColorante(strIdePro: String): String;
var
  strSigTin: String;
  autcomTinta: IAutcomTinta;
begin
  strSigTin := fRetornaSiglaTinta(strIdePro);

  autcomTinta := TAutcomTintaFactory.GetIAutcomTinta(strSigTin);
  if Assigned(autcomTinta) then
    Result := autcomTinta.fRetornaCampoDescricaoColorante()
  else
  begin
    If Pos(strSigTin, 'SUV_BAU_QUA_CIA_MAZ_CIM_CID_BZI_DAC_FUT_SOL_MZI_COL_IQU_REC_') > 0 Then
    Begin
      Result := QuotedStr('');
    End

    Else If Pos(strSigTin, 'ADV_REI_LKS_LKD_SHE_KIL_') > 0 Then
    Begin
      Result := 'COL_DESCRI';
    End

    Else If Pos(strSigTin, 'SKY_GEN_FAR_MZA_MZD_KIN_') > 0 Then
    Begin
      Result := 'BAS_DESCRI';
    End

    Else If Pos(strSigTin, 'SAL_GLA_AUT_DUP_PPG_ZYN_LAZ_BZA_STA_WAN_WCP_') > 0 Then
    Begin
      Result := 'BAS_DESBAS';
    end

    Else If (fTipoTinta(strSigTin) in [ttImobiliaria, ttIndustrial]) Then
    Begin
      Result := 'COL_DESCRI';
    End

    Else
    Begin
      Result := 'BAS_DESBAS';
    End;
  end;

end;

{*******************************************}
{* RETORNA O PRODUTO CORRESPONDENTE À UM   *}
{* COLORANTE (OU BASE NAS AUTOMOTIVAS) DE  *}
{* ACORDO COM O CÓDIGO GRAVADO NO TINDET.  *}
{****************************************MV*}
procedure pRetItemColorante(strIdePro, strColTinDet: String;
  Var strCodIte, strCodBas: String; const strCodEmp: string);
  Var
    strDesBas: String;
begin
  pRetItemEDescricaoColorante(strIdePro, strColTinDet, strCodIte, strCodBas, strDesBas, strCodEmp);
end;

function fGetQuantidadeOncaPulsoMl(const fltValor: Double; const strIdePro: string; const strFormul: String): string;
var
  intParteInteira: Integer;
  fltParteFracao: Double;
  conf: IConfTinta;
  intUniOpr: Integer;
  strDecFor : String;
  intDecFor : Integer;
  libTinta: ILibTinta;
begin
  strDecFor := fGetConfTinta(strIdePro).fGet('DECFOR');

  If Pos(strIdePro, 'BAU_FUT_') > 0 Then
    intDecFor := 4
  Else If Pos(strIdePro,'ANN_DOX_SUV_SHE_CIA_') > 0 then
    intDecFor := 3
  Else If fEmptyStr(strDecFor) Then
    intDecFor := 2
  Else
    intDecFor := StrToIntDef(strDecFor, 2);

  Result := FloatToStrF(fltValor, ffNumber, 12, intDecFor);

  TVerificadorTintaExistente.ExisteTinta(strIdePro);
  libTinta := TLibTintaFactory.GetITintadeMaquina(strIdePro);

  conf := fGetConfTinta(strIdePro);
  intUniOpr := conf.fGetInteger('UNIOPR');

  if (intUniOpr > 0) then // A tinta tem a própria configuração
  begin
    If intUniOpr = 1 Then
    Begin
      If Assigned(libTinta) Then
      Begin
        Result := LibTinta.GetQuantidadeMlPulso(fltValor, intDecFor, strFormul);
        Exit;
      End;
    End
    Else if intUniOpr = 2 then
    begin
      If Assigned(libTinta) Then
      Begin
        Result := FloatToStrF(RoundTo(libTinta.GetQuantidadeGramaMl(fltValor, fGetFatorMl(strIdePro), strFormul), -intDecFor), ffNumber, 12, intDecFor);
        Exit;
      End;
      Result := FloatToStrF(RoundTo(fltValor * fGetFatorML(strIdePro), -intDecFor), ffNumber, 12, intDecFor);
    end
    else if intUniOpr = 3 then
    begin
      if Assigned(libTinta) then
      begin
        Result := libTinta.GetQuantidadeOncaPulsoMl(fltValor, intParteInteira, fltParteFracao, strFormul);
        Exit;
      end;

      begin
        MlParaOnca(fltValor, intParteInteira, fltParteFracao);
        Result := Format('%dY%.1f', [intParteInteira, fltParteFracao]);
      end;
    end
  end
  Else If strIdePro = 'ADT' Then
  Begin
    If Assigned(libTinta) Then
    Begin
      Result := FloatToStrF(RoundTo(libTinta.GetQuantidadeGramaMl(fltValor, fGetFatorMl(strIdePro), strFormul), -intDecFor), ffNumber, 12, intDecFor);
      Exit;
    End;
    Result := FloatToStrF(RoundTo(fltValor * fGetFatorML(strIdePro), -intDecFor), ffNumber, 12, intDecFor);
  End
  else if (fCfgSisL('PULMLS', varInteger) = 2) then
  begin
    Result := FloatToStrF(RoundTo(fltValor * fGetFatorML(strIdePro), -intDecFor), ffNumber, 12, intDecFor);
  end
  else if fCfgSisL('PULMLS', varInteger) = 3 then
  begin
{    if strIdePro = 'SUV' then
    begin
      SuvinilPulsoParaOnca(fltValor, intParteInteira, fltParteFracao);
      Result := Format('%dY%.2f', [intParteInteira, fltParteFracao]);
    end
    else}

    if Assigned(libTinta) then
    begin
      Result := libTinta.GetQuantidadeOncaPulsoMl(fltValor, intParteInteira, fltParteFracao);
      Exit;
    end;

    begin
      MlParaOnca(fltValor, intParteInteira, fltParteFracao);
      Result := Format('%dY%.1f', [intParteInteira, fltParteFracao]);
    end;
  end;

end;

function OncaParaMl(intParteInteira: Integer; fltParteFracao: Double): Double;
begin
  Result := fStrToFloat(FormatFloat('0.000', (intParteInteira * 29.5735295625) + (fltParteFracao * 0.61611520)));
end;

procedure MlParaOnca(fltMl: Double; var intParteInteira: Integer; var fltParteFracao: Double);
var
  fltCalculo: Double;
begin
  fltCalculo := ((fltMl / 48) / 0.61611520);
  intParteInteira := Trunc(fltCalculo);
  fltParteFracao := fStrToFloat(FormatFloat('0.000', (fltCalculo - intParteInteira) * 48));
end;

procedure pRetItemEDescricaoColorante(strIdePro, strColTinDet: String;
  Var strCodIte, strCodBas, strDesBas: String; const strCodEmp: string; strLinha_: String = ''); stdcall;
var
  strSigTin: String;
  strTabCol: String;
  strSQL: String;
  strCondicao: String;
  strCampoIte: String;
  strCampoDes: String;
  qryCadCol: TUniQuery;
  autcomTinta: IAutcomTinta;
  tinta: ILibTinta;

  {$IFNDEF LINUX}
  Procedure pSetaConnection(Modulo: TDataModule);
    Var
      intIndex: Integer;
  Begin
    With Modulo Do
    For intIndex := 0 To ComponentCount - 1 Do
      If Components[intIndex] Is TUniQuery Then
        (Components[intIndex] As TUniQuery).Connection := frmModulo.GetCurrentConnection;
  End;
  {$ENDIF}
begin
  {$IFNDEF LINUX}
  If (Not Assigned(frmModulo)) Then
  Begin
    pCriarModulo(TfrmModulo, TDataModule(frmModulo));
    pCriarModulo(TfrmModuloSPR, TDataModule(frmModuloSPR));
    pSetaConnection(frmModuloSPR);
  End;
  {$ENDIF}

  Try
    strSigTin   := fRetornaSiglaTinta(strIdePro);
    strTabCol   := fRetornaTabelaColoranteTinta(strSigTin);
    strCondicao := '';

    TVerificadorTintaExistente.ExisteTinta(strSigTin);
    tinta := TLibTintaFactory.GetITintadeMaquina(strSigTin);
    if Assigned(tinta) then
    begin
      tinta.pRetItemColorante(strColTinDet, strCodIte, strCodBas, strDesBas, strCodEmp);
      Exit;
    end;

    strCampoDes := fRetornaCampoDescricaoColorante(strSigTin);

    autcomTinta := TAutcomTintaFactory.GetIAutcomTinta(strSigTin);

    if Assigned(autcomTinta) then
      autcomTinta.pRetItemEDescricaoColorante(strColTinDet, strCodIte, strCodBas, strDesBas, strCodEmp)
    else
    begin
      If fTipoTinta(strSigTin) in [ttImobiliaria, ttIndustrial] Then
      Begin
        strCondicao := 'COL_CODCOL';
        strCampoIte := 'COL_CODITE';
      End
      Else
      Begin
        strCondicao := 'BAS_CODBAS';
        strCampoIte := 'BAS_CODITE';
      End;

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  ' + strCondicao + ', ';
      strSQL := strSQL + '  ' + strCampoIte + ', ';
      strSQL := strSQL + '  ' + strCampoDes + ' AS DESBAS ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  ' + strTabCol + ' ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  ' + strCondicao + ' = :CODCOL ';

      If (fCfgSis('EMPBDU', varBoolean) And (strSigTin = 'DUP'))
       Or (fCfgSis('EMPBDX', varBoolean) And (strSigTin = 'DUX'))
       Or (fCfgSis('EMPBD2', varBoolean) And (strSigTin = 'DU2')) Then
        strSQL := strSQL + '  AND BAS_CODEMP = :CODEMP ';

      If (Not fEmptyStr(strLinha_)) And (Pos(strSigTin, 'SAL_GLA_') > 0) Then
        strSQL := strSQL + '  AND BAS_LINHA_ = :LINHA_ ';

      qryCadCol := fCriaQuery(Nil);
      qryCadCol.SQL.Add(strSQL);
      qryCadCol.ParamByName('CODCOL').AsString := strColTinDet;

      If (fCfgSis('EMPBDU', varBoolean) And (strSigTin = 'DUP'))
       Or (fCfgSis('EMPBDX', varBoolean) And (strSigTin = 'DUX'))
       Or (fCfgSis('EMPBD2', varBoolean) And (strSigTin = 'DU2')) Then
        qryCadCol.ParamByName('CODEMP').AsString := strCodEmp;

      If (Not fEmptyStr(strLinha_)) And (Pos(strSigTin, 'SAL_GLA_') > 0) Then
        qryCadCol.ParamByName('LINHA_').AsString := strLinha_;

      qryCadCol.Open;

      strCodIte := qryCadCol.FieldByName(strCampoIte).AsString;
      strCodBas := qryCadCol.FieldByName(strCondicao).AsString;
      strDesBas := qryCadCol.FieldByName('DESBAS').AsString;

      qryCadCol.Close;
      FreeAndNil(qryCadCol);
    end;
  except
    on e:Exception do
    begin
      pMensagensErro(E.Message,'');
    end;
  end;

end;

function fTintaBaixaProduto(strIdePro: String): Boolean; stdcall;
var
  tinta: ILibTinta;
begin
  Result := False;

  TVerificadorTintaExistente.ExisteTinta(strIdePro);
  tinta := TLibTintaFactory.GetITintadeMaquina(strIdePro);
  if Assigned(tinta) then
  begin
    Result := tinta.fTintaBaixaProduto;
    Exit;
  end;

//  If (Pos( fRetornaSiglaTinta(strIdePro), fGetTintasdeMaquina().fGetImobiliarias ) > 0) Then
  If (Pos( fRetornaSiglaTinta(strIdePro), fGetTintasdeMaquina().fGetImobiliarias ) > 0)
   or (Pos( fRetornaSiglaTinta(strIdePro), fGetTintasdeMaquina().fGetIndustriais) > 0) Then
    Result := True;
end;

function fRetornaCodigoChapinha(strIdePro: String): String; stdcall;
Var
  tinta: ILibTinta;
  strSigTin: String;
  conf: IConfTinta;
Begin
  Result := '';

  strSigTin := fRetornaSiglaTinta(strIdePro);

  If fEmptyStr(strSigTin) Then
    Exit;

  Conf := fGetConfTinta(strSigTin);
  TVerificadorTintaExistente.ExisteTinta(strSigTin);
  tinta := TLibTintaFactory.GetITintadeMaquina(strSigTin);

  If Assigned(tinta) Then
  Begin
    Result := Tinta.fRetornaCodigoChapinha(strIdePro);
    Exit;
  End;
End;

function fUsaChapinhaTinta(strIdePro: String; strIteTin: String): Boolean; stdcall;
Var
  tinta: ILibTinta;
  strSigTin: String;
  conf: IConfTinta;
Begin
  Result  := False;

  strSigTin := fRetornaSiglaTinta(strIdePro);

  If fEmptyStr(strSigTin) Then
    Exit;

  Conf := fGetConfTinta(strSigTin);
  TVerificadorTintaExistente.ExisteTinta(strSigTin);
  tinta := TLibTintaFactory.GetITintadeMaquina(strSigTin);

  If Assigned(tinta) Then
  Begin
    Result := Tinta.fUsaChapinhaTinta(strIdePro, strIteTin);
    Exit;
  End;
End;

function fTintaBaixaEmbalagem(strIdePro, strTipEmb: String;
  Var strCodIte: String): Boolean; stdcall;
var
  strSigTin: String;
  conf: IConfTinta;
  autcomTinta: IAutcomTinta;
  tinta: ILibTinta;
begin

  Result    := False;
  strCodIte := '';
  strSigTin := fRetornaSiglaTinta(strIdePro);

  If fEmptyStr(strSigTin) Then
    Exit;

  conf := fGetConfTinta(strSigTin);

  TVerificadorTintaExistente.ExisteTinta(strSigTin);
  tinta := TLibTintaFactory.GetITintadeMaquina(strSigTin);
  if Assigned(tinta) then
  begin
    Result := tinta.fTintaBaixaEmbalagem(strTipEmb, strCodIte);
    Exit;
  end;

  autcomTinta := TAutcomTintaFactory.GetIAutcomTinta(strSigTin);
  if Assigned(autcomTinta) then
    Result := autcomTinta.fTintaBaixaEmbalagem(strTipEmb, strCodIte)
  else
  begin

    If (strSigTin = 'SAL') Then
    Begin

      If (strTipEmb = 'LT') Then // LITRO
        strCodIte := conf.fGet('SALIEM')
      Else
      If (strTipEmb = 'GL') Then // GALÃO
        strCodIte := conf.fGet('SALIGL')
      Else
      If (strTipEmb = 'BD') Then // BALDE
        strCodIte := conf.fGet('SALIBA')
      Else
      If (strTipEmb = 'SP') Then // SPRAY
        strCodIte := conf.fGet('SALISP')
      Else
      If (strTipEmb = 'CP') Then // COPO
        strCodIte := conf.fGet('SALICO');

    End
    Else If (strSigTin = 'GLA') Then
    Begin
      If (strTipEmb = 'LT') Then // LITRO
        strCodIte := conf.fGet('GLAIEM')
      else
      If (strTipEmb = 'GL') Then // GALÃO
        strCodIte := conf.fGet('GLAIGL')
      else
      if (strTipEmb = 'BD') Then // BALDE
        strCodIte := conf.fGet('GLABAL')
      else
      if (strTipEmb = 'SP') Then // SPRAY
        strCodIte := conf.fGet('GLAISP')
      else
      if (strTipEmb = 'CP') Then // COPO
        strCodIte := conf.fGet('GLAICO');
    End

    Else If (strSigtin = 'FAR') Then
    Begin
      if strTipEmb = 'LT' then
        strCodIte := conf.fGet('FARPLT')
      else
      if strTipEmb = 'GL' then
        strCodIte := conf.fGet('FARPGL')
      else
      if strTipEmb = 'LA' then
        strCodIte := conf.fGet('FARPSP')
      else
      if strTipEmb = 'CP' then
        strCodIte := conf.fGet('FARPCP')
      else
      if strTipEmb = 'TB' then
        strCodIte := conf.fGet('FARPTB')
      else
      if strTipEmb = 'SP' then
        strCodIte := conf.fGet('FARPSY');
    End

  end;

end;

{*******************************************}
{* RETORNA SE A QUANTIADE DIGITADA PARA A  *}
{* TINTA É PERMITIDA                       *}
{****************************************MV*}
function fTravaQuantidadeTinta(strIdePro, strTipEmb: String;
  fltQtdEmb, fltQtdDig: Double): Boolean;
var
  fltQtdTra: Double;
  strTintas: String;
  autcomTinta: IAutcomTinta;
begin

  Result    := True;
  fltQtdTra := 0.0;

  strTintas := 'WAN_';

  autcomTinta := TAutcomTintaFactory.GetIAutcomTinta(strIdePro);
  if Assigned(autcomTinta) then
    Result := autcomTinta.fTravaQuantidadeTinta(strTipEmb, fltQtdEmb, fltQtdDig)
  else
  begin

    If (Pos(strIdePro, strTintas) > 0) Then
    Begin

      If (strTipEmb = 'LT') Then
      Begin
        fltQtdTra := fFormataFloat(fltQtdEmb * 0.900, 02);
      End
      Else If (strTipEmb = 'GL') Then
      Begin
        fltQtdTra := fFormataFloat(fltQtdEmb * 3.600, 02);
      End;

      If (fFormataFloat(fltQtdDig, 02) > fFormataFloat(fltQtdTra, 02)) Then
      Begin
        Result := False;
      End;

    End
    Else If (Pos(strIdePro, 'PPG') > 0) Then
    Begin
      Result := True;
    End
    Else If (strIdePro = 'DUP') Then
    Begin
      Result := True;
    End;

  end;
end;

{$IFDEF LINUX}
function fConsultaTintaGeral(strIdePro: String; Sender: TForm; strCodEmp: String): String; stdcall;
begin
  raise Exception.Create('fConsultaTintaGeral nao possui implementacao para compilacao linux');
end;
{$ELSE}
function fConsultaTintaGeral(strIdePro: String; Sender: TForm; strCodEmp: String): String; stdcall;
var
  strSiglaTinta: String;
  autcomTinta: IAutcomTinta;
  tinta: ILibTinta;
begin

  Result := '-1';

  strSiglaTinta := fRetornaSiglaTinta(strIdePro);

  autcomTinta := TAutcomTintaFactory.GetIAutcomTinta(strSiglaTinta);
  if Assigned(autcomTinta) then
    Result := autcomTinta.fConsultaTintaGeral(Sender, strCodEmp)
  else
  begin

    TVerificadorTintaExistente.ExisteTinta(strSiglaTinta);
    tinta := TLibTintaFactory.GetITintadeMaquina(strSiglaTinta);
    if Assigned(tinta) then
    begin
      Result := TTintadeMaquinaWrapper.fConsultaDinamicaGeral(Sender, tinta.GetITintadeMaquina);
      Exit;
    end;

{  Else If strSiglaTinta = 'COL' Then
  Begin
    Result := fConsultaSolbrazImobiliariaDinamicaGeral(Sender, strCodEmp);
    End}

    If strSiglaTinta = 'SAL' Then
    Begin
      Result := fConsultaSalcomixGeralDinamica(Sender);
    End
    Else If strSiglaTinta = 'GLA' Then
    Begin
      Result := fConsultaGlasuritGeralDinamica(Sender);
    End
    Else If strSiglaTinta = 'ACA' Then
    Begin
      Result := fConsultaProdAcabadosGeral(Sender, strIdePro, False);
    End
  end;
end;
{$ENDIF}

{$IFDEF LINUX}
function fConsultaTintaVenda(strIdePro: String; Sender: TForm; strCodEmp: String; qryTinta: TUniQuery): String;
begin
  raise Exception.Create('fConsultaTintaVenda nao possui implementacao para compilacao linux');
end;
{$ELSE}
function fConsultaTintaVenda(strIdePro: String; Sender: TForm; strCodEmp: String; qryTinta: TUniQuery): String;
var
  strSiglaTinta: string;
  autcomTinta: IAutcomTinta;
  tinta: ILibTinta;
begin
  Result := '-1';
  strSiglaTinta := fRetornaSiglaTinta(strIdePro);

  autcomTinta := TAutcomTintaFactory.GetIAutcomTinta(strSiglaTinta);
  if Assigned(autcomTinta) then
    Result := autcomTinta.fConsultaTintaVenda(Sender, strCodEmp, qryTinta, False, False, Nil, Nil)
  else
  begin
    TVerificadorTintaExistente.ExisteTinta(strSiglaTinta);
    tinta := TLibTintaFactory.GetITintadeMaquina(strSiglaTinta);
    if Assigned(tinta) then
    begin
      Result := TTintadeMaquinaWrapper.fConsultaDinamicaVenda(Sender,
        IfNull(fCfgSis('TABPAD'), '1'),
        tinta.GetITintadeMaquina, False, False, Nil, Nil);
      Exit;
    end;

    If strSiglaTinta = 'SAL' Then
    Begin
      Result := fConsultaSalcomixVendaDinamica(Sender, strCodEmp, qryTinta, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')), False, False, Nil, Nil);
    End
    Else If strSiglaTinta = 'GLA' Then
    Begin
      Result := fConsultaGlasuritVendaDinamica(Sender, qryTinta, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')), False, False, Nil, Nil);
    End
    Else If strSiglaTinta = 'ACA' Then
    Begin
      Result := fConsultaProdAcabadosVenda(Sender, strCodEmp, qryTinta, 'NF');
    End
  end;
end;
{$ENDIF}

function fRetornaDescricaoTinta(strIdePro, strDesCri: String; qryTinta: TUniQuery; strTipPre: String): String;
var
  strSiglaTinta: string;
  autcomTinta: IAutcomTinta;
  libTinta: ILibTinta;
begin
  Result := '';
  strSiglaTinta := fRetornaSiglaTinta(strIdePro);

  autcomTinta := TAutcomTintaFactory.GetIAutcomTinta(strSiglaTinta);
  if Assigned(autcomTinta) then
    Result := autcomTinta.fRetornaDescricaoTinta(strDesCri, qryTinta, strTipPre)
  else
  begin
    TVerificadorTintaExistente.ExisteTinta(strSiglaTinta);
    libTinta := TLibTintaFactory.GetITintadeMaquina(strSiglaTinta);
    if Assigned(libTinta) then
    begin
      Result := libTinta.RetornaDescricaoTinta(strDesCri, TUniQueryDataSetWrapper.Create(qryTinta), strTipPre);
//      Exit;
    end
    Else If (strSiglaTinta = 'SAL') Then
    Begin
      Result := fRetornaDescricaoSalcomixDinamica(qryTinta, strDesCri);
    End
    Else If (strSiglaTinta = 'GLA') Then
    Begin
      Result := fRetornaDescricaoGlasuritDinamica(qryTinta, strDesCri);
    End
    Else If (strSiglaTinta = 'ACA') Then
    Begin
      Result := qryTinta.FieldByName('ACA_DESCRI').AsString;
    End
  end;

  If fTipoTinta(strIdePro) = ttAutomotiva Then
  Begin
    If (Not fEmptyStr(strTipPre)) Then
    Begin
      If strTipPre = 'D' Then
        Result := Result + ' DILUIDO'
      Else If strIdePro = 'LEC' Then
        Result := Result + ''
      Else
        Result := Result + ' CONCENTRADO'

    End;
  End;

  Result := Copy(Result, 1, 101);
end;

function fRetornaReferenciaTinta(strIdePro: String; qryTinta: TUniQuery): String;
var
  strSiglaTinta: String;
  autcomTinta: IAutcomTinta;
  cdsTinta: TUniClientDataSet;
  libTinta: ILibTinta;
begin
  Result := '';
  strSiglaTinta := fRetornaSiglaTinta(strIdePro);
  cdsTinta := TClientDataSetFactory.GetClientDataSet(qryTinta);

  autcomTinta := TAutcomTintaFactory.GetIAutcomTinta(strSiglaTinta);
  if Assigned(autcomTinta) then
    Result := autcomTinta.fRetornaReferenciaTinta(cdsTinta)
  else
  begin
    TVerificadorTintaExistente.ExisteTinta(strSiglaTinta);
    libTinta := TLibTintaFactory.GetITintadeMaquina(strSiglaTinta);
    if Assigned(libTinta) then
    begin
      Result := libTinta.RetornaReferenciaTinta(TUniQueryDataSetWrapper.Create(qryTinta));
      Exit;
    end;

    If (strSiglaTinta = 'SAL') Then
    Begin
      Result := '';
    End
    Else If (strSiglaTinta = 'GLA') Then
    Begin
      Result := '';
    End;

  end;
end;

{************************************************************}
{* RETORNA OS VALORES NECESSARIOS PARA AS TINTAS DE MAQUINA *}
{*********************************************************MV*}
{$IFDEF LINUX}
function fRetornaPreco(Sender: TForm; qryTinta, qryTintaAux: TUniQuery; Var dicRetorno: TDicionario; blnFaturamento, blnPermiteTab: Boolean; sltItems: TStringList): Boolean;
begin
  raise Exception.Create('fRetornaPreco nao possui implementacao para compilacao linux');
end;
{$ELSE}
function fRetornaPreco(Sender: TForm; qryTinta, qryTintaAux: TUniQuery; Var dicRetorno: TDicionario; blnFaturamento, blnPermiteTab: Boolean; sltItems: TStringList): Boolean;
var
  strIdePro: String;
  strSiglaTinta: string;
  autcomTinta: IAutcomTinta;
  libTinta: ILibTinta;
  saldos: ISaldosColorantes;
begin

  strIdePro := dicRetorno['idepro'];
  strSiglaTinta := fRetornaSiglaTinta(strIdePro);

  If (Not Assigned(dicRetorno)) Then
    dicRetorno := TDicionario.Create;

  dicRetorno['precus'] := 0.0;
  dicRetorno['unitar'] := 0.0;
  dicRetorno['fattin'] := 0.0;
  dicRetorno['prctin'] := 0.0;
  dicRetorno['prvtin'] := 0.0;
  dicRetorno['codite'] := '';
  dicRetorno['descor'] := '';
  dicRetorno['itetin'] := '';

  dicRetorno['tippre'] := '';
  dicRetorno['lazqua'] := 0;
  dicRetorno['tipemb'] := '';
  dicRetorno['qtdemb'] := 0;
  dicRetorno['preemb'] := 0.0;
  dicRetorno['embala'] := 0.0;
  dicRetorno['iteemb'] := '';

  dicRetorno['montad'] := '';
  dicRetorno['a_n_o_'] := '';
  dicRetorno['univer'] := '';

  {***************************************************}
  {* VOLUME A PRODUZIR: TINTA DE MÁQUINA COM VENDA   *}
  {* DINÂMICA                                        *}
  {** 01/01/1900 - 00:00 **************************MV*}
  dicRetorno['volpro'] := 0.0000;

  Result := False;
  try
    autcomTinta := TAutcomTintaFactory.GetIAutcomTinta(strSiglaTinta);
    if Assigned(autcomTinta) then
      Result := autcomTinta.fRetornaPreco(Sender, qryTinta, dicRetorno, blnFaturamento, blnPermiteTab, 'N', '', sltItems)
    else
    begin
      TVerificadorTintaExistente.ExisteTinta(strSiglaTinta);
      libTinta := TLibTintaFactory.GetITintadeMaquina(strSiglaTinta);
      if Assigned(libTinta) then
      begin
        Result := libTinta.RetornaPreco(Sender, TUniQueryDataSetWrapper.Create(qryTinta),
          TDicionarioWrapper.Create(dicRetorno), saldos, blnFaturamento, blnPermiteTab, 'N', '', sltItems);
        if Result then
        begin
          dicRetorno.AdicionarObjeto('formul', TMatrizSaldosColorantesFactory.GetMatriz(saldos));
          If (fTipoTinta(dicRetorno['idepro']) = ttAutomotiva) And (Not fEmptyStr(dicRetorno['iteemb'])) Then
            dicRetorno['saldocols'] := TMatrizSaldosColorantesFactory.GetSaldoML(TClassMatrizSaldosColorantes(dicRetorno.RetornaObjeto('formul')),
                                                                                 fCfgSis('COL_' + IIF(Pos(dicRetorno['opcdoc'], 'OR_PD_') > 0, dicRetorno['opcdoc'], 'VN')),
                                                                                 dicRetorno['iteemb'],
                                                                                 dicRetorno['qtdemb'],
                                                                                 fRetDescri('ITE_DESITE', 'ITE_CODITE', 'CADITE', dicRetorno['iteemb']));
        end;

        Exit;
      end;

      If strSiglaTinta = 'SAL' Then
      Begin
        Result := fRetornaPrecoSalcomixDinamica(Sender, qryTinta, dicRetorno, blnFaturamento, blnPermiteTab, 'N', '', sltItems);
      End
      Else If strSiglaTinta = 'GLA' Then
      Begin
        Result := fRetornaPrecoGlasuritDinamica(Sender, qryTinta, dicRetorno, blnFaturamento, blnPermiteTab, 'N', '', sltItems);
      End
      Else If strSiglaTinta = 'ACA' Then
      Begin
        Result := fRetornaPrecoProdAcabados(Sender, qryTinta, dicRetorno);
      End
    end;

    pFormataValores(dicRetorno, fCfgSis('DECUNI', varInteger));
  except

    On E: ExceptionAutCom Do
    Begin
      pMensagemOk(E.Message);
    End;

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fRetornaPreco]');
    End;
  end;
end;
{$ENDIF}

function fRetornaUniTraProTinta(strIdePro: String; qryTinta: TUniQuery;
  fltEmbala, fltQuanti: Double; strTipPre, strIteTin, strCodBas, strTabPre: String;
  strCatalize: String; fltPrcTin, fltPrvTin: Double): Double;
var
  strSiglaTinta: String;
  autcomTinta: IAutcomTinta;
  libTintas: ILibTinta;
  dicDados: TDicionario;
begin
  Result := 0.0;

  dicDados := nil;
  Try
    Try
      strSiglaTinta := fRetornaSiglaTinta(strIdePro);

      dicDados := TDicionario.Create;
      dicDados['embala'] := fltEmbala;
      dicDados['quanti'] := fltQuanti;
      dicDados['tippre'] := strTipPre;
      dicDados['itetin'] := strIteTin;
      dicDados['codbas'] := strCodBas;
      dicDados['tabpre'] := strTabPre;
      dicDados['catalize'] := strCatalize;
      dicDados['prctin'] := fltPrcTin;
      dicDados['prvtin'] := fltPrvTin;

      autcomTinta := TAutcomTintaFactory.GetIAutcomTinta(strSiglaTinta);
      if Assigned(autcomTinta) then
        Result := autcomTinta.fRetornaUniTraProTinta(qryTinta, fltEmbala, fltQuanti, strTipPre, strIteTin, strCodBas,
          strTabPre, strCatalize, fltPrcTin, fltPrvTin)
      else
      begin
        TVerificadorTintaExistente.ExisteTinta(strSiglaTinta);
        libTintas := TLibTintaFactory.GetITintadeMaquina(strSiglaTinta);
        if Assigned(libTintas) then
        begin
          Result := libTintas.RetornaUniTraProTinta(TUniQueryDataSetWrapper.Create(qryTinta),
            TDicionarioWrapper.Create(dicDados));
          Exit;
        end;

        If (strSiglaTinta = 'SAL') Then
        Begin
          Result := fRetornaUniTraProSalcomixDinamica(fltPrcTin, fltPrvTin);
        End
        Else If (strSiglaTinta = 'GLA') Then
        Begin
          Result := fRetornaUniTraProGlasuritDinamica(fltPrcTin, fltPrvTin);
        End;

      end;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(dicDados) then FreeAndNil(dicDados);
  End;
end;

function fRetornaUniTraEmbTinta(strIdePro, strTipEmb, strTipPre: String): Double;
var
  autcomTinta: IAutcomTinta;
begin
  Result := 0.0;

  autcomTinta := TAutcomTintaFactory.GetIAutcomTinta(strIdePro);
  if Assigned(autcomTinta) then
    Result := autcomTinta.fRetornaUniTraEmbTinta(strTipEmb, strTipPre);
end;

function fGTinForGeral(strIdePro, strIteTin, strTipPre, strLinTin, strCatalize: String;
  intLazQua: Integer; fltQtdEmb: Double; fltQtdIte: Double; strDescri: String;
  qryArqFor: TUniQuery; fltVolPro: Double; Var arrFormul: TForMulTinDetArray;
  Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList;
  strCodDil: string; fltPorDil: Double; strDilCon: String; fltPorCat: Double;
  strTipCor: String; strTextBase: String; intAcao: Integer; strIteCob: String;
  strCodEmpPrd: string; strPerformance: String = ''): Boolean;
var
  intCont: Integer;
  strSiglaTinta: String;
  autcomTinta: IAutcomTinta;
  libTinta: ILibTinta;
  dicDados: TDicionario;
begin
  Result := True;

  dicDados := nil;
  Try
    Try
      strSiglaTinta := fRetornaSiglaTinta(strIdePro);

      For intCont := Low(arrFormul) To High(arrFormul) Do
      Begin
        arrFormul[intCont].strFormul := '';
        arrFormul[intCont].fltQtdbas := 0.0;
      End;

      SetLength(arrBaixaPigmentos, 0);

      stlItensTraMl.Clear;

      {*******************************************}
      {* NÃO PERMITE ITENS DUPLICATADOS          *}
      {****************************************MV*}
      If (stlItensTraMl.Duplicates <> dupIgnore) Then
        stlItensTraMl.Duplicates := dupIgnore;

      If (Not stlItensTraMl.Sorted) Then
        stlItensTraMl.Sorted := True;

      if fEmptyStr(strCodEmpPrd) then
        strCodEmpPrd := VS_strCodEmp;

      dicDados := TDicionario.Create;
      dicDados['itetin'] := strIteTin;
      dicDados['tippre'] := strTipPre;
      dicDados['lintin'] := strLinTin;
      dicDados['catalize'] := strCatalize;
      dicDados['lazqua'] := intLazQua;
      dicDados['qtdemb'] := fltQtdEmb;
      dicDados['qtdite'] := fltQtdIte;
      dicDados['descri'] := strDescri;
      dicDados['volpro'] := fltVolPro;
      dicDados['coddil'] := strCodDil;
      dicDados['pordil'] := fltPorDil;
      dicDados['dilcon'] := strDilCon;
      dicDados['porcat'] := fltPorCat;
      dicDados['tipcor'] := strTipCor;
      dicDados['textbase'] := strTextBase;
      dicDados['acao'] := intAcao;
      dicDados['itecob'] := strIteCob;
      dicDados['idepro'] := strSiglaTinta;
      dicDados['codempprd'] := strCodEmpPrd;
      dicDados['porper'] := strPerformance;

      autcomTinta := TAutcomTintaFactory.GetIAutcomTinta(strIdePro);
      if Assigned(autcomTinta) then
        Result := autcomTinta.fGTinForGeral(strIteTin, strTipPre, strLinTin, strCatalize, intLazQua, fltQtdEmb,
          fltQtdIte, strDescri, qryArqFor, fltVolPro, arrFormul, arrBaixaPigmentos, stlItensTraMl, strCodDil,
          fltPorDil, strDilCon, fltPorCat, strTipCor, strTextBase, intAcao, strIteCob, strCodEmpPrd)
      else
      begin
        TVerificadorTintaExistente.ExisteTinta(strSiglaTinta);
        libTinta := TLibTintaFactory.GetITintadeMaquina(strSiglaTinta);
        if Assigned(libTinta) then
        begin
          Result := libTinta.fGTinForGeral(arrFormul, arrBaixaPigmentos,
            TDicionarioWrapper.Create(dicDados));
          stlItensTraMl.Text := IfNull(dicDados['stlItensTraMl'], '');
          Exit;
        end;

        If (strSiglaTinta = 'SAL') Then
        Begin
          Result := fGTinForSalcomixDinamica(strIteTin, fltVolPro, arrFormul, arrBaixaPigmentos, stlItensTraMl,strCodDil, strTipPre);
        End
        Else If (strSiglaTinta = 'GLA') Then
        Begin
          Result := fGTinForGlasuritDinamica(strIteTin, fltVolPro, arrFormul, arrBaixaPigmentos, stlItensTraMl, strCodDil, strTipPre);
        End;
      end;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(dicDados) then FreeAndNil(dicDados);
  End;
end;

function fTintaGeraFormulacao(strIdePro: String): Boolean;
var
  strSiglaTinta: string;
  strUsaFor: String;
  autcomTinta: IAutcomTinta;
  tinta: ILibTinta;
begin

  strSiglaTinta := fRetornaSiglaTinta(strIdePro);

  TVerificadorTintaExistente.ExisteTinta(strSiglaTinta);
  tinta := TLibTintaFactory.GetITintadeMaquina(strSiglaTinta);

  if Assigned(tinta) then
  begin
    Result := tinta.fTintaGeraFormulacao;
    Exit;
  end;

  autcomTinta := TAutcomTintaFactory.GetIAutcomTinta(strSiglaTinta);

  if Assigned(autcomTinta) then
    Result := autcomTinta.fTintaGeraFormulacao
  else
  begin
    If fTintaTemConfiguracoesNoBanco(strSiglaTinta) Then
    Begin
      strUsaFor := fgetConfTinta(strSiglaTinta).fGet('USAFOR');

      If fEmptyStr(strUsaFor) Then
        Result := (fArqIniTinta(0, 'USA_FORMUL', fRetornaSiglaTinta(strIdePro), 'S') = 'S')
      Else
        Result := (strUsaFor = 'S');
    End
    Else
      Result := (fArqIniTinta(0, 'USA_FORMUL', fRetornaSiglaTinta(strIdePro), 'S') = 'S');
  end;

end;

procedure pRetornaDadosTinta(strIdePro, strIteTin: String; dicRetorno: TDicionario);
var
  strSiglaTinta: String;
  conf: IConfTinta;
  autcomTinta: IAutcomTinta;
  libTinta: ILibTinta;
begin
  strSiglaTinta := fRetornaSiglaTinta(strIdePro);
  conf := fGetConfTinta(strSiglaTinta);

  dicRetorno['codtin'] := '';
  dicRetorno['montad'] := '';
  dicRetorno['martin'] := '';

  autcomTinta := TAutcomTintaFactory.GetIAutcomTinta(strIdePro);
  if Assigned(autcomTinta) then
    autcomTinta.pRetornaDadosTinta(strIteTin, dicRetorno)
  else
  begin
    TVerificadorTintaExistente.ExisteTinta(strSiglaTinta);
    libTinta := TLibTintaFactory.GetITintadeMaquina(strSiglaTinta);
    if Assigned(libTinta) then
    begin
      libTinta.RetornaDadosTinta(strIteTin, TDicionarioWrapper.Create(dicRetorno));
      Exit;
    end;

    If strSiglaTinta = 'SAL' Then
    Begin
      pRetornaDadosSalcomixDinamica(strIteTin, dicRetorno);
    End
    Else If strSiglaTinta = 'GLA' Then
    Begin
      pRetornaDadosGlasuritDinamica(strIteTin, dicRetorno);
    End;
  end;
end;

procedure pSetaParametros(dicParametros    : TDicionario;
                          fGrvMovGer       : TfGravaMovGer;
                          fGrvMovDet       : TfGravaMovDet;
                          {$IFDEF LINUX}
                          objConnManager   : TConnectionsManager;
                          objApplication   : TApplication;
                          {$ELSE}
                          recModulos       : TRecModulosAutcom;
                          {$ENDIF}
                          objTransf        : ITransferencias = Nil;
                          objOrdPro        : IFatOrdProTintaMaquina = Nil; intDebugH: Byte = 0;
                          objLibera        : ILiberacao = Nil;
                          objTraceViewer   : ITraceViewer = nil;
                          objExecSQL       : IExecutaSQLReplicacaoTinta = Nil;
                          objLotePedWMS    : IFatDefineLotesPedidoWMS = Nil;
                          objFuncoesCRM    : IFuncoesCRM = Nil;
                          objFuncoesSaldos : IFuncoesSaldos = Nil;
                          fExecutarConsulta: TfConsulta = nil;
                          blmModoClassico  : Boolean = True;
                          pImprimeImpFat   : TImprimeImpFatTin = Nil);

{$IFNDEF LINUX}
  Procedure pSetaConnection(Modulo: TDataModule);
    Var
      intIndex: Integer;
  Begin
    With Modulo Do
    For intIndex := 0 To ComponentCount - 1 Do
      If Components[intIndex] Is TUniQuery Then
        (Components[intIndex] As TUniQuery).Connection := frmModulo.GetCurrentConnection;
  End;
{$ENDIF}

{$IFNDEF LINUX}
Var
  strPatIni: String;
  Buffer: Array[0..254] Of Char;
{$ENDIF}
begin
  {$IFNDEF LINUX}
  pIniciaLogLeak(intDebugH, DLL_TINTA_NAME);
  {$ENDIF}

  pSetaEmpresaLogadaTinta(dicParametros['codemp']);
  strLoginUsuarioLogado := dicParametros['usuariologado'];

  If dicParametros['strHabilitarCRM'] <> Null Then
    VS_strHabilitarCRM := dicParametros['strHabilitarCRM']
  Else
    VS_strHabilitarCRM := False;

  {$IFNDEF LINUX}
  untFuncoesSimples.VS_objTraceViewer := objTraceViewer;
  {$ENDIF}

  If (Assigned(fGrvMovGer)) Then
    fGravaMovGer := fGrvMovGer;

  If (Assigned(fGrvMovDet)) Then
    fGravaMovDet := fGrvMovDet;

  If (Assigned(objTransf)) Then
    objTransfere := objTransf;

  If (Assigned(objOrdPro)) Then
    objImpOrdPro := objOrdPro;

  If (Assigned(pImprimeImpFat)) Then
    pImprimeFatImpTin := pImprimeImpFat;

  If (Assigned(objLibera)) Then
    objLiberacao := objLibera;

  If (Assigned(objExecSQL)) Then
    objExeSQLRepTinta := objExecSQL;

  If (Assigned(objLotePedWMS)) Then
    objLotePedidoWMS := objLotePedWMS;

  If (Assigned(objFuncoesCRM)) Then
    untTintaMaquina.objFuncoesCRM := objFuncoesCRM;

  If (Assigned(objFuncoesSaldos)) Then
    untTintaMaquina.objFuncoesSaldos := objFuncoesSaldos;

 {$IFDEF LINUX}
  objConnectionsManager := objConnManager;
  Application := objApplication;
 {$ELSE}
  frmModulo := TfrmModulo.CreateInstance(Nil, False);
  frmModulo.Database.AssignConnect(recModulos.Banco);
  pCriarModulo(TfrmModuloSPR, TDataModule(frmModuloSPR));
  pSetaConnection(frmModuloSPR);
  fAjustaDataSistema;
 {$ENDIF}

  VS_blnCodEmpBasDup := fCfgSis('EMPBDU', varBoolean);
  VS_blnCodEmpBasDux := fCfgSis('EMPBDX', varBoolean);
  VS_blnCodEmpBasDu2 := fCfgSis('EMPBD2', varBoolean);

  {**********************************************************************************}
  {* VERIFICA SE EXISTE O ARQUIVO OPCOES_LOCAIS.INI                                 *}
  {* CASO EXISTA - ATUALIZA A CONFIGURACAO VS_STRTIPEXP E VS_STRESP40S APARTIR DELE *}
  {* OBS: ESSE ARQUIVO DEVERÁ FICAR SEMPRE NA PASTA WINDOWS DA MAQUINA              *}
  {*******************************************************************************LU*}
 {$IFNDEF LINUX}
  strPatIni := fCfgSis('PATINI');
  If fEmptyStr(strPatIni) Then
  Begin
    GetWindowsDirectory(Buffer, 255);
    strPatIni := StrPas(Buffer);
  End;
 {$ENDIF}

 {$IFNDEF LINUX}
  pAtuVarGlobaisSimples;
 {$ELSE}
  pIniciarVariaveis;
 {$ENDIF}

 {$IFNDEF LINUX}
  strPatIni := strPatIni + '\OPCOES_LOCAIS.INI';
  VS_strEtiTintaMaq := fArqIniLocal(0, 'ETIQUETA_TINTAMAQ', 'IMP_ETI_TINTAMAQ' , VS_strEtiTintaMaq, strPatIni);
 {$ENDIF}

 {$IFNDEF LINUX}
  TLogForm.strCodEmp := VS_strCodEmp;
  TLogForm.strCodOpe := strLoginUsuarioLogado;
  TLogForm.dtaDtaLog := VS_Date;
  TLogForm.fncCriaQuery := fCriaQuery;
  TLogForm.blnLogFrm := fCfgSis('LOGFRM', varBoolean) And fTabelaExiste('LOGFRM', True);
  TLogForm.fncTime := fTime;
 {$ENDIF}
  pCarregaNre;

 {$IFNDEF LINUX}
  pIniciaDllFuncoes(frmModulo.GetCurrentConnection,
                    strLoginUsuarioLogado,
                    VS_strCodEmp,
                    DebugHook,
                    TCfgSis.Create(),
                    VS_objTraceViewer,
                    VS_Date,
                    VS_ComputerNetName,
                    VS_UserFromWindows,
                    VS_IPAddressAsString,
                    VS_MacAddress);
 {$ENDIF}

 {$IFNDEF LINUX}
  If Assigned(fExecutarConsulta) Then
    untFuncoesSimples.fConsulta := fExecutarConsulta;
 {$ENDIF}

 {$IFNDEF LINUX}
  blnUsuarioLogadoUtilizaModoClassico := blmModoClassico;
  If Not blnUsuarioLogadoUtilizaModoClassico Then
  Begin
    Try
      TStyleManager.TrySetStyle(AUTCOM_STYLE_NAME);
      TfrmGravando.CorPadraoTema := AUTCOM_COR_TELA_AGUARDE_TEMA;

      TCustomStyleEngine.UnRegisterSysStyleHook('#32768', TSysPopupStyleHook);

      TCustomStyleEngine.UnRegisterSysStyleHook('#32770', TSysDialogStyleHook);

      TCustomStyleEngine.UnRegisterSysStyleHook('ScrollBar', TSysScrollBarStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('Button', TSysButtonStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('Edit', TSysEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('ComboBox', TSysComboBoxStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('ListBox', TSysListBoxStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('ComboLBox', TSysListBoxStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('Static', TSysStaticStyleHook);

      TCustomStyleEngine.UnRegisterSysStyleHook('ToolbarWindow32', TSysToolbarStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('SysListView32', TSysListViewStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('SysTabControl32', TSysTabControlStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('SysTreeView32', TSysTreeViewStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('msctls_progress32', TSysProgressBarStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit20A', TSysRichEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit20W', TSysRichEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit30A', TSysRichEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit30W', TSysRichEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit41A', TSysRichEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit41W', TSysRichEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit50A', TSysRichEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit50W', TSysRichEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RebarWindow32', TSysReBarStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('msctls_statusbar32', TSysStatusBarStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('msctls_trackbar32', TSysTrackBarStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('msctls_updown32', TSysUpDownStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('tooltips_class32', TSysTooltipsStyleHook);
    Except
      blnUsuarioLogadoUtilizaModoClassico := True;
    End;
  End;
 {$ENDIF}

  TLibTintaFactory.ScanearDlls;
end;

procedure pSetaEmpresaLogadaTinta(strEmpLog: String); stdcall;
begin
  pSetaEmpresaLogada(strEmpLog);
end;

function fFormulacaoAcumulada(strIdePro: String): Boolean; stdcall;
var
  strTinta: String;
  autcomTinta: IAutcomTinta;
  tinta: ILibTinta;
begin
  strTinta  := '';
  strIdePro := fRetornaSiglaTinta(strIdePro);

  autcomTinta := TAutcomTintaFactory.GetIAutcomTinta(strIdePro);
  if Assigned(autcomTinta) then
    Result := autcomTinta.fFormulacaoAcumulada
  else
  begin
    TVerificadorTintaExistente.ExisteTinta(strIdePro);
    tinta := TLibTintaFactory.GetITintadeMaquina(strIdePro);
    if Assigned(tinta) then
    begin
      Result := tinta.fFormulacaoAcumulada;
      Exit;
    end;

    If strIdePro = 'SAL' Then
      strTinta := 'SALCOMIX'
    Else If strIdePro = 'GLA' Then
      strTinta := 'GLASURIT';

    If fEmptyStr(strTinta) Then
      Result := False
    Else
      Result := (fArqIniTinta(0, strTinta, 'ACUABS', '1') = '1');

  end;
end;

{******************************************}
{* ATUALIZAR QUANDO FIZER UMA NOVA TINTA  *}
{* DINAMICA. NESSAS FUNÇÕES TENTO UTILI-  *}
{* ZAR A TÁTICA DO "SEMPRE CONCENTRADO":  *}
{* USO A FORMULAÇÃO DO TINDOR, QUE JÁ VEM *}
{* DIL OU CONCENT, APLICADO A N FATORES,  *}
{* COMO SE FOSSE A FORMULA PARA FAZER 1   *}
{* CONCENTRADO. ENTÃO USO SEMPRE O VALOR  *}
{* CONCENTRADO (CUSTO E VENDA).           *}
{***************************************MV*}
procedure pTintaRetornaTabelaPreco(dicRetorno: TDicionario; fltFatorAcerto: Double); stdcall;
var
  strIdePro: String;
  autcomTinta: IAutcomTinta;
  calculadorFatVendas: ICalculadorFatVendas;
  tinta: ILibTinta;
begin
  strIdePro := dicRetorno['idepro'];
  dicRetorno['tabpre'] := IntToStr(StrToIntDef(IfNull(dicRetorno['tabpre'], IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD'))), 1));

  {**********************************************************************}
  {* SETA OS PARAMETROS NECESSARIOS PARA CALCULO DO PRECO DE PROMOCAO,  *}
  {* CASO OS MESMOS AINDA NAO TENHAM SIDO DEFINIDOS NO DICIONARIO.      *}
  {* NECESSARIO PARA GARANTIR INTEGRIDADE NO CALCULO DO PRECO           *}
  {****************************************************************JC,RO*}
  if Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
  begin
    dicRetorno['opcdoc'] := IfNull(dicRetorno['opcdoc'], calculadorFatVendas.GetStrOpcDoc);
    dicRetorno['przmed'] := IfNull(dicRetorno['przmed'], calculadorFatVendas.GetIntPrzMed);
    dicRetorno['codcnd'] := IfNull(dicRetorno['codcnd'], calculadorFatVendas.GetStrCodCnd);
    dicRetorno['codcli'] := IfNull(dicRetorno['codcli'], calculadorFatVendas.GetStrCodCli);
  end;

  autcomTinta := TAutcomTintaFactory.GetIAutcomTinta(strIdePro);
  if Assigned(autcomTinta) then
    autcomTinta.pTintaRetornaTabelaPreco(dicRetorno, fltFatorAcerto)
  else
  begin
    TVerificadorTintaExistente.ExisteTinta(strIdePro);
    tinta := TLibTintaFactory.GetITintadeMaquina(strIdePro);
    if Assigned(tinta) then
    begin
      tinta.pTintaRetornaTabelaPreco(TDicionarioWrapper.Create(dicRetorno), fltFatorAcerto);
      Exit;
    end;

    If strIdePro = 'SAL' Then
      pRetornaTabelaPrecoSalcomix(dicRetorno, fltFatorAcerto)
    Else If strIdePro = 'GLA' Then
      pRetornaTabelaPrecoGlasurit(dicRetorno, fltFatorAcerto);
  end;
end;

Function fGetFatorML(strIdePro: String): Double;
var
  strSigTin: String;
  autcomTinta: IAutcomTinta;
  tinta: ILibTinta;
Begin
  Result    := 1;
  strSigTin := fRetornaSiglaTinta(strIdePro);

  autcomTinta := TAutcomTintaFactory.GetIAutcomTinta(strIdePro);
  if Assigned(autcomTinta) then
    Result := autcomTinta.fGetFatorML
  else
  begin
    TVerificadorTintaExistente.ExisteTinta(strSigTin);
    tinta := TLibTintaFactory.GetITintadeMaquina(strSigTin);
    if Assigned(tinta) then
    begin
      Result := tinta.fGetFatorML;
      Exit;
    end;

   { If strSigTin = 'UNI' Then
      Result := (29.5735295625 / 192)

    Else If strSigTin = 'MAZ' Then
      Result := (29.5735295625 / 192)}


{    Else If strSigTin = 'COL' Then
      Result := 0.154}


    If strSigTin = 'CID' Then
      Result := 0.308

  end;

End;

function fRetSaldoML(strCodIte, strCodEmp: String): Double;
var
  qryGen: TUniQuery;
begin
{$IFNDEF LINUX}
  Result := 0;
{$ENDIF}
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();

      qryGen.SQL.Add('SELECT');
      qryGen.SQL.Add('  ((ITE_SALDOS * ITE_CNV_ML) + IFNULL(ITE_SAL_ML, 0))    TOTALML');
      qryGen.SQL.Add('FROM ITEGER G');
      qryGen.SQL.Add('  INNER JOIN CADITE I');
      qryGen.SQL.Add('    ON G.ITE_CODITE = I.ITE_CODITE');
      qryGen.SQL.Add('WHERE G.ITE_CODITE = :CODITE');
      qryGen.SQL.Add('    AND G.ITE_CODEMP = :CODEMP;');

      qryGen.ParamByName('CODITE').AsString := strCodIte;
      qryGen.ParamByName('CODEMP').AsString := strCodEmp;

      qryGen.Open;

      Result := qryGen.FieldByName('TOTALML').AsFloat;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;


function fTravarEstoque(Var dicRetorno: TDicionario; Var blnLocFor: Boolean): Boolean; stdcall;
Var
  arrFormul: TForMulTinDetArray;
  arrBaixaPigs: TBaixaPigmentosArray;
  stlItensTraML : TStringList;
  qryArqFor: TUniQuery;
  intCont: Integer;
  FormulasTinta: TFormulasTinta;
begin
  blnLocFor := True;
  SetLength(arrBaixaPigs, 0);
  qryArqFor := fCriaQuery();
  stlItensTraML := TStringList.Create;

  Result := fGTinForGeral(
    fRetornaSiglaTinta(IfNull(dicRetorno['idepro'], '')),
    IfNull(dicRetorno['itetin'], ''),
    IfNull(dicRetorno['tippre'], ''),
    IfNull(dicRetorno['lintin'], ''),
    IfNull(dicRetorno['catali'], ''),
    IfNull(dicRetorno['lazqua'], 0),
    IfNull(dicRetorno['qtdemb'], 0),
    IfNull(dicRetorno['qtdite'], 0),
    IfNull(dicRetorno['descri'], ''),
    qryArqFor,
    IfNull(dicRetorno['volpro'], ''),
    arrFormul,
    arrBaixaPigs,
    stlItensTraML,
    IfNull(dicRetorno['coddil'], ''),
    IfNull(dicRetorno['pordil'], 0),
    IfNull(dicRetorno['dilcon'], ''),
    IfNull(dicRetorno['porcat'], 0),
    IfNull(dicRetorno['tipcor'], ''),
    IfNull(dicRetorno['textbas'], ''),
    IfNull(dicRetorno['moddil'], 0),
    IfNull(dicRetorno['complementob'], ''),
    IfNull(dicRetorno['empite'], VS_strCodEmp));

  If Result Then
  Begin
    For intCont := Low(arrBaixaPigs) To High(arrBaixaPigs) Do
    Begin
      dicRetorno['codBaixaPigs' + IntToStr(intCont)] := arrFormul[intCont + 1].strFormul;
      dicRetorno['strBaixaPigs' + IntToStr(intCont)] := arrBaixaPigs[intCont].strCodIte;
      dicRetorno['qtdBaixaPigs' + IntToStr(intCont)] := arrBaixaPigs[intCont].fltQtdBaixa;
      dicRetorno['strTipComp' + IntToStr(intCont)] := IIF(arrBaixaPigs[intCont].strTipComp = '', 'C', arrBaixaPigs[intCont].strTipComp);
      dicRetorno['strPesGraPigs' + IntToStr(intCont)] := IIF(fEmptyStr(arrBaixaPigs[intCont].strPesGra), 'N', arrBaixaPigs[intCont].strPesGra); //Axalta
      dicRetorno['qtdEmbalaPigs' + IntToStr(intCont)] := arrBaixaPigs[intCont].fltEmbBas; //Axalta
    End;
  End
  Else
  Begin
//    Raise Exception.Create('ATENÇÃO: Não foi possível localizar uma fórmula referente à tinta ' +
//                            fRetornaNomeTinta(IfNull(dicRetorno['idepro'], '')) + #13#10 +
//                            '(' + IfNull(dicRetorno['itetin'], '') + ')');

{
    pMensagemOk('ATENÇÃO: Não foi possível localizar uma fórmula referente à tinta ' +
                            fRetornaNomeTinta(IfNull(dicRetorno['idepro'], '')) + #13#10 +
                            '(' + IfNull(dicRetorno['itetin'], '') + ')');}


    FormulasTinta := TFormulasTinta.Create;
    FormulasTinta.NumDoc := IfNull(dicRetorno['numdoc'],'');
    FormulasTinta.EspDoc := IfNull(dicRetorno['espdoc'],'');
    FormulasTinta.CodEmp := IfNull(dicRetorno['empite'],'');
    FormulasTinta.CodCli := IfNull(dicRetorno['codcli'],'');
    FormulasTinta.CodIte := IfNull(dicRetorno['codite'],'');
    FormulasTinta.CodAca := IfNull(dicRetorno['codaca'],'');
    FormulasTinta.EmpAca := IfNull(dicRetorno['empaca'],'');
    FormulasTinta.TipTin := IfNull(dicRetorno['idepro'],'');
    //Caso não encontre a tinta devido a mudança em sua formulação, faz a correção, caso não consiga então segue dando a mensagem para o usuário.
    if not FormulasTinta.fCorrigeFormula then
    begin
      pExibeMensagemTintaNaoEncontrada(dicRetorno);
      FreeAndNil(qryArqFor);
      blnLocFor := False;
      Exit;
    end;
    FreeAndNil(FormulasTinta);
  End;

  dicRetorno['qtdcols'] := High(arrBaixaPigs) - Low(arrBaixaPigs);

  FreeAndNil(qryArqFor);
end;

function fDesfragmentaTintaSaldosOR(qryGenDor: TDataSet; Var blnLocFor: Boolean; blnRecalculaSaldos: Boolean = True;
  blnImpTintaMaqOutroPedido: Boolean = False; blnProducaoForaDeLoja: Boolean = False): TClassMatrizSaldosColorantes;
Var
  dicFormulTinta : TDicionario;
  intCont        : Integer;
  tipoTinta      : TTipoTinta;
  blnTraEst      : Boolean;
  fltQtdTin      : Double;
  blnLotePrincipalTinta: Boolean;

  function fRetValorCampo(strCampo : String; strSigTab : String = '') : TField;
  begin

    Result := TField.Create(Nil);

    If fEmptyStr(strSigTab) Then
    Begin

      If (qryGenDor.FindField('FDO_' + strCampo) <> Nil) Then
        Result := qryGenDor.FieldByName('FDO_' + strCampo)
      Else
      If (qryGenDor.FindField('DET_' + strCampo) <> Nil) Then
        Result := qryGenDor.FieldByName('DET_' + strCampo);

    End
    Else
    begin
      If (qryGenDor.FindField(strSigTab + strCampo) <> Nil) Then
        Result := qryGenDor.FieldByName(strSigTab + strCampo);
    End;

  end;

begin

  blnLocFor := True;
  Result := TClassMatrizSaldosColorantes.Create;
  dicFormulTinta := TDicionario.Create;
  fltQtdTin := 0;

  tipoTinta := fTipoTinta(fRetValorCampo('IDEPRO').AsString);

  dicFormulTinta['idepro']       := fRetValorCampo('IDEPRO').AsString;
  dicFormulTinta['itetin']       := fRetValorCampo('ITETIN').AsString;
  dicFormulTinta['tippre']       := fRetValorCampo('TIPPRE').AsString;
  dicFormulTinta['lintin']       := fRetValorCampo('LINLIN').AsString;
  dicFormulTinta['catali']       := fRetValorCampo('CATALI').AsString;
  dicFormulTinta['lazqua']       := fRetValorCampo('LAZQUA').AsInteger;
  dicFormulTinta['qtdemb']       := fRetValorCampo('QTDEMB').AsFloat;
  dicFormulTinta['qtdite']       := fRetValorCampo('QTDITE').AsFloat;
  dicFormulTinta['desite']       := fRetValorCampo('DESCRI').AsString;
  dicFormulTinta['volpro']       := fRetValorCampo('VOLPRO').AsFloat;
  dicFormulTinta['coddil']       := fRetValorCampo('CODDIL').AsString;
  dicFormulTinta['pordil']       := fRetValorCampo('PORDIL').AsFloat;
  dicFormulTinta['dilcon']       := fRetValorCampo('DILCON').AsString;
  dicFormulTinta['porcat']       := fRetValorCampo('PORCAT').AsFloat;
  dicFormulTinta['tipcor']       := IfNull(fRetValorCampo('TIPCOR', 'FOR_').AsString, '');
  dicFormulTinta['textbase']     := IfNull(fRetValorCampo('TEXBAS', 'FOR_').AsString, '');

  dicFormulTinta['moddil']       := IfNull(fRetValorCampo('MODDIL', 'FOR_').AsString, '0');

  If fEmptyStr(dicFormulTinta['moddil']) Then
    dicFormulTinta['moddil'] := '0';

  dicFormulTinta['complementob'] := fRetValorCampo('ITECOB', 'FOR_').AsString;

  dicFormulTinta['empite'] := fRetValorCampo('EMPITE').AsString;

  if fEmptyStr(dicFormulTinta['empite']) then
    dicFormulTinta['empite'] := fRetValorCampo('CODEMP').AsString;

  //Parametros utilizados na mensagem quando formulacao nao encontrada
  dicFormulTinta['numdoc'] := fRetValorCampo('NUMDOC').AsString;
  dicFormulTinta['espdoc'] := fRetValorCampo('ESPDOC').AsString;
  dicFormulTinta['unitar'] := fRetValorCampo('UNITAR').AsString;
  dicFormulTinta['unidad'] := fRetValorCampo('UNIDAD').AsString;

  // Verifica se é importação de itens de outro documento
  if (blnImpTintaMaqOutroPedido) then
  begin
    dicFormulTinta['codcli']       := fRetValorCampo('CODCLI').AsString;
    dicFormulTinta['codite']       := fRetValorCampo('CODITE').AsString;
    dicFormulTinta['codaca']       := fRetValorCampo('CODACA').AsString;
    dicFormulTinta['empaca']       := fRetValorCampo('EMPACA').AsString;
  end;

  blnTraEst := fTravarEstoque(dicFormulTinta, blnLocFor);

  If Not blnLocFor then
  Begin
    FreeAndNil(dicFormulTinta);
    Exit;
  End;

  If blnTraEst Then
  Begin
    For intCont := 0 To dicFormulTinta['qtdcols'] Do
    Begin
      // Quando for o complemento, não adicionar aqui, pois o mesmo sera adicionado mais tarde.
      if (IfNull(dicFormulTinta['complementob'], '') = dicFormulTinta['strBaixaPigs' + IntToStr(intCont)])
        and (dicFormulTinta['strTipComp' + IntToStr(intCont)] = 'B') then
        Continue;
      Result.fAdicionar(qryGenDor.RecNo, dicFormulTinta['desite'],
                        dicFormulTinta['strBaixaPigs' + IntToStr(intCont)],
                        fRetDescri('ITE_DESITE', 'ITE_CODITE', 'CADITE', dicFormulTinta['strBaixaPigs' + IntToStr(intCont)]),
                        dicFormulTinta['codBaixaPigs' + IntToStr(intCont)],
                        dicFormulTinta['qtdBaixaPigs' + IntToStr(intCont)],
                        IfThen(tipoTinta in [ttImobiliaria, ttIndustrial], IIF(dicFormulTinta['strTipComp' + IntToStr(intCont)] = 'CT', CATALISADOR, COLORANTE), BASE_AUTOMOTIVA),
                        dicFormulTinta['strPesGraPigs' + IntToStr(intCont)],  //Peso em gramas base
                        dicFormulTinta['qtdEmbalaPigs' + IntToStr(intCont)]); //Embalagem da base

    End;
    {*********************************************}
    {* CASO SEJA IMOBILIARIA, ACRESCENTAR A BASE *}
    {******************************************PH*}
    If tipoTinta in [ttImobiliaria, ttIndustrial] Then
    Begin
      if fEmptyStr(fRetValorCampo('ITEEMB').AsString) then // A embalagem é a própia base
      begin
        Result.fAdicionar(qryGenDor.RecNo, dicFormulTinta['desite'],
                          fRetValorCampo('CODITE').AsString,
                          fRetDescri('ITE_DESITE', 'ITE_CODITE', 'CADITE', fRetValorCampo('CODITE').AsString),
                          fRetValorCampo('CODITE').AsString,
                          fRetValorCampo('QTDITE').AsFloat,
                          BASE_IMOBILIARIA,
                          'N',  //Peso em gramas base
                          0.0); //Embalagem da base
      end;

      If (dicFormulTinta['complementob'] <> Null) And (Not fEmptyStr(dicFormulTinta['complementob'])) Then
      Begin
        Result.fAdicionar(qryGenDor.RecNo, dicFormulTinta['desite'],
                          dicFormulTinta['complementob'],
                          fRetDescri('ITE_DESITE', 'ITE_CODITE', 'CADITE', dicFormulTinta['complementob']),
                          dicFormulTinta['complementob'],
                          fRetValorCampo('QTDITE').AsFloat,
                          BASE_IMOBILIARIA,
                          'N',  //Peso em gramas base
                          0.0); //Embalagem da base
      End;
    End
    Else
    Begin
      {***********************************************}
      {* CASO SEJA AUTOMOTIVA, ACRESCENTAR EMBALAGEM *}
      {********************************************PH*}

      if not fEmptyStr(fRetValorCampo('ITEEMB').AsString) then // caso tenha a embalagem
      begin
        Result.fAdicionar(qryGenDor.RecNo, dicFormulTinta['desite'],
                          fRetValorCampo('ITEEMB').AsString,
                          fRetDescri('ITE_DESITE', 'ITE_CODITE', 'CADITE', fRetValorCampo('ITEEMB').AsString),
                          fRetValorCampo('ITEEMB').AsString,
                          fRetValorCampo('QTDITE').AsFloat,
                          EMBALAGEM,
                          'N',  //Peso em gramas base
                          0.0); //Embalagem da base
      end
      Else
        fltQtdTin := fRetValorCampo('QTDITE').AsFloat;
    End;
  End;

  If blnRecalculaSaldos Then
  Begin
    blnLotePrincipalTinta := (blnProducaoForaDeLoja) And
                             (fUsaRotinaWMS) And
                             (fCfgSis('GTEPFL', varBoolean));

    Result.fRecalculaSaldos(fRetValorCampo('EMPPRD').AsString,
                            fltQtdTin,
                            fRetValorCampo('NUMDOC').AsString,
                            blnLotePrincipalTinta);
  End;

  Result.RecalcularAcumulados(nil);

  FreeAndNil(dicFormulTinta);

end;

function GetMatrizSaldoColorantes(const intPos: Integer; const strCodIte: string; const strIteEmb: string;
  const strIdePro: string; const strIteTin: string; const strTipPre: string; const strLinTin: string;
  const strCatali: string; const intLazQua: Integer; const fltQtdEmb: Double; const fltQtdIte: Double;
  const strDescri: string; const fltVolPro: Double; const strCodDil: string; const fltPorDil: Double;
  const strDilCon: string; const fltPorCat: Double; const strTipCor: string; const strTextBas: string;
  const intModDil: Integer; const strIteCob: string; const strEmpIte: string; const strEmpPrd: string;
  const strNumDoc: string; const strEspDoc: string; const strCodCli: string; const strCodAca: string;
  const strEmpAca: string;
  Var blnLocFor: Boolean): TClassMatrizSaldosColorantes;
var
  dicFormulTinta: TDicionario;
  intCont: Integer;
  blnImobiliaria: Boolean;
  blnTraEst: Boolean;
begin
  dicFormulTinta := nil;
{$IFNDEF LINUX}
  Result := nil;
{$ENDIF}
  Try
    Try
      blnLocFor := True;
      Result := TClassMatrizSaldosColorantes.Create;
      dicFormulTinta := TDicionario.Create;

      blnImobiliaria := fTipoTinta(strIdePro) = ttImobiliaria;

      dicFormulTinta['idepro'] := strIdePro;
      dicFormulTinta['itetin'] := strIteTin;
      dicFormulTinta['tippre'] := strTipPre;
      dicFormulTinta['lintin'] := strLinTin;
      dicFormulTinta['catali'] := strCatali;
      dicFormulTinta['lazqua'] := intLazQua;
      dicFormulTinta['qtdemb'] := fltQtdEmb;
      dicFormulTinta['qtdite'] := fltQtdIte;
      dicFormulTinta['desite'] := strDescri;
      dicFormulTinta['volpro'] := fltVolPro;
      dicFormulTinta['coddil'] := strCodDil;
      dicFormulTinta['pordil'] := fltPorDil;
      dicFormulTinta['dilcon'] := strDilCon;
      dicFormulTinta['porcat'] := fltPorCat;
      dicFormulTinta['tipcor'] := strTipCor;
      dicFormulTinta['textbase'] := strTextBas;
      dicFormulTinta['moddil'] := intModDil;
      dicFormulTinta['complementob'] := strIteCob;
      dicFormulTinta['empite'] := strEmpIte;
      dicFormulTinta['numdoc'] := strNumDoc;
      dicFormulTinta['espdoc'] := strEspDoc;
      dicFormulTinta['codcli'] := strCodCli;
      dicFormulTinta['codaca'] := strCodAca;
      dicFormulTinta['empaca'] := strEmpAca;
      dicFormulTinta['codite'] := strCodIte;

      blnTraEst := fTravarEstoque(dicFormulTinta, blnLocFor);

      If Not blnLocFor then
      Begin
        FreeAndNil(dicFormulTinta);
        Exit;
      End;

      If blnTraEst Then
      Begin
        For intCont := 0 To dicFormulTinta['qtdcols'] Do
        Begin
          Result.fAdicionar(intPos, dicFormulTinta['desite'],
                            dicFormulTinta['strBaixaPigs' + IntToStr(intCont)],
                            fRetDescri('ITE_DESITE', 'ITE_CODITE', 'CADITE', dicFormulTinta['strBaixaPigs' + IntToStr(intCont)]),
                            dicFormulTinta['codBaixaPigs' + IntToStr(intCont)],
                            dicFormulTinta['qtdBaixaPigs' + IntToStr(intCont)],
                            IfThen(blnImobiliaria, COLORANTE, BASE_AUTOMOTIVA),
                            'N',  //Peso em gramas base
                            0.0); //Embalagem da base

        End;
        {*********************************************}
        {* CASO SEJA IMOBILIARIA, ACRESCENTAR A BASE *}
        {******************************************PH*}
        If blnImobiliaria Then
        Begin
          Result.fAdicionar(intPos, dicFormulTinta['desite'],
                            strCodIte,
                            fRetDescri('ITE_DESITE', 'ITE_CODITE', 'CADITE', strCodIte),
                            strCodIte,
                            fltQtdIte,
                            BASE_IMOBILIARIA,
                            'N',  //Peso em gramas base
                            0.0); //Embalagem da base

          If (dicFormulTinta['complementob'] <> Null) And (Not fEmptyStr(dicFormulTinta['complementob'])) Then
          Begin
            Result.fAdicionar(intPos, dicFormulTinta['desite'],
                              dicFormulTinta['complementob'],
                              fRetDescri('ITE_DESITE', 'ITE_CODITE', 'CADITE', dicFormulTinta['complementob']),
                              dicFormulTinta['complementob'],
                              fltQtdIte,
                              BASE_IMOBILIARIA,
                              'N',  //Peso em gramas base
                              0.0); //Embalagem da base
          End;
        End
        Else
        Begin
          {***********************************************}
          {* CASO SEJA AUTOMOTIVA, ACRESCENTAR EMBALAGEM *}
          {********************************************PH*}

          Result.fAdicionar(intPos, dicFormulTinta['desite'],
                            strIteEmb,
                            fRetDescri('ITE_DESITE', 'ITE_CODITE', 'CADITE', strIteEmb),
                            strIteEmb,
                            fltQtdIte,
                            EMBALAGEM,
                            'N',  //Peso em gramas base
                            0.0); //Embalagem da base
        End;
      End;

      Result.fRecalculaSaldos(strEmpPrd, '');
      Result.RecalcularAcumulados(nil);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(dicFormulTinta) then FreeAndNil(dicFormulTinta);
  End;
end;


{$IFDEF LINUX}
function fVisualizarSaldoTintas(Formulas: TClassMatrizSaldosColorantes; strDescrCompleta : String = ''): Boolean;
begin
  raise Exception.Create('fVisualizarSaldoTintas nao possui implementacao para compilacao linux');
end;
{$ELSE}
function fVisualizarSaldoTintas(Formulas: TClassMatrizSaldosColorantes; strDescrCompleta : String = ''): Boolean;
  Var
    frmSaldos        : TfrmSaldoTintas;
    intCont          : Integer;
    blnSaldoNegativo : Boolean;
begin
  blnSaldoNegativo := false;
  Result           := False;

  For intCont := 0 To Formulas.Count - 1 Do
  begin
    If (Formulas[intCont].fltSaldoML <= 0) Or
      (Formulas[intCont].fltSaldoML < Formulas[intCont].fltQtdFormAcu) Then
      blnSaldoNegativo := True;
  end;

  if (blnSaldoNegativo) then
  begin
    Try
      pCriarFormularios(TfrmSaldoTintas, frmSaldos);
      frmSaldos.strDescrCompleta := strDescrCompleta;
      frmSaldos.Formulas  := Formulas;
      frmSaldos.ShowModal;
      FreeAndNil(frmSaldos);
      Result := True;
    Except
      If Assigned(frmSaldos) Then FreeAndNil(frmSaldos);
      Result := False;
    End;
  end;
end;
{$ENDIF}

function fCalcularTabelasdePreco(strIdePro, strIteTin, strTipPre, strLinTin, strCatalize: String;
    intLazQua: Integer; fltQtdEmb: Double; fltQtdIte: Double; strDescri: String;
    qryArqFor: TUniQuery; fltVolPro: Double; Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList;
    strCodDil: string; fltPorDil: Double; strDilCon: String; fltPorCat: Double;
    strTipCor: String; strTextBase: String; intAcao: Integer; var dicRetorno: TDicionario; strPorPer: String = ''): Boolean;
  Var
    intCont: Integer;
    fltFatorAcerto: Double;
begin
  fltFatorAcerto := IfNull(dicRetorno['fatace'], 1.00);

  Result := fGTinForGeral(strIdePro, strIteTin, strTipPre, strLinTin, strCatalize,
                  intLazQua, fltQtdEmb, fltQtdIte, strDescri, qryArqFor, fltVolPro,
                  arrFormul, arrBaixaPigmentos, stlItensTraMl, strCodDil,
                  fltPorDil, strDilCon, fltPorCat, strTipCor, strTextBase, intAcao,
                  IfNull(dicRetorno['complementob'], ''), IfNull(dicRetorno['empite'], VS_strCodEmp), strPorPer);

  If Result Then
  Begin
    dicRetorno['idepro'] := strIdePro;
    dicRetorno['iteemb'] := IfNull(dicRetorno['iteemb'], '');
    dicRetorno['itetin'] := strIteTin;
    dicRetorno['linha_'] := strLinTin;
    dicRetorno['volpro'] := fltVolPro;
    dicRetorno['tippre'] := strTipPre;
    dicRetorno['tipcor'] := strTipCor;
    dicRetorno['catali'] := strCatalize;
    dicRetorno['porper'] := strPorPer;

    For intCont := Low(arrFormul) To High(arrFormul) Do
    Begin
      dicRetorno['base' + fStrZero(intCont, 2)] := arrFormul[intCont].strFormul;
      dicRetorno['qtdb' + fStrZero(intCont, 2)] := arrFormul[intCont].fltQtdbas;
    End;

    pTintaRetornaTabelaPreco(dicRetorno, fltFatorAcerto);
  End;
end;

function fGetConsultaTinta(strIdePro: String): IConsultaTinta; stdcall;
  Var
    consultaTinta: TTintasdeMaquina;
begin
  consultaTinta := TTintasdeMaquina.Create;
  Result := consultaTinta.fGetConsulta(strIdePro);
  consultaTinta.Free;
end;

function fGetTintasdeMaquina(blnDestruir: Boolean = False): ITintasDeMaquina;
begin
  If blnDestruir Then
    objTintasDeMaquina := Nil;

  If Not Assigned(objTintasDeMaquina) Then
    objTintasDeMaquina := TTintasdeMaquina.Create;

  Result := objTintasDeMaquina;
end;

function fGetConfTinta(strIdePro: String): IConfTinta;
begin
  Result := TConfTinta.Create(strIdePro);
end;

function fGetConfEmb(strIdePro: String): IConfEmb;
begin
  Result := TConfEmb.Create(strIdePro);
end;


function fGetIndicesTinta(strIdePro: String): IConsultaIndices;
  Var
    consultaTinta: TTintasdeMaquina;
begin
  consultaTinta := TTintasdeMaquina.Create;
  Result := consultaTinta.fGetConsulta(strIdePro);
  consultaTinta.Free;
end;

function fGetEntradaSaida(const strClaFis: string): string;
begin
  Result := IIF(StrToIntDef(LeftStr(strClaFis, 1), 0) < 5, 'E', 'S');
end;

function fGetITintadeMaquina(const dadosTinta: IDadosTinta; const calculadorFatVendas: TObject; dicRetorno: TDicionario = Nil): ITintaDeMaquina; stdcall;
begin
  Result := TTintadeMaquinaFactory.GetITintadeMaquina(dadosTinta, calculadorFatVendas, dicRetorno);
end;

function fRetornaNomeTinta(strIdePro: String; blnExiLib: Boolean = True): String;
var
  strSigTinta: String;
  autcomTinta: IAutcomTinta;
  libTinta: ILibTinta;
begin
  Result    := '';
  strIdePro := AnsiUpperCase(strIdePro);
  strSigTinta := fRetornaSiglaTinta(strIdePro, blnExiLib);

  autcomTinta := TAutcomTintaFactory.GetIAutcomTinta(strIdePro);
  if Assigned(autcomTinta) then
    Result := autcomTinta.fRetornaNomeTinta
  else
  begin
    If blnExiLib Then
      TVerificadorTintaExistente.ExisteTinta(strIdePro);
    libTinta := TLibTintaFactory.GetITintadeMaquina(strIdePro);
    if Assigned(libTinta) then
    begin
      Result := libTinta.GetNomeTinta;
      Exit;
    end;


    If strSigTinta = 'SAL' Then
    Begin
      Result := 'Salcomix';
    End

    Else If strSigTinta = 'GLA' Then
    Begin
      Result := 'Glasurit';
    End

    Else If strSigTinta = 'ACA' Then
    Begin
      Result := 'Produto Acabado'; //Produtos Acabados
    End;


  end;
end;

function fRetornaSiglaTinta(strIdePro: String; blnExiLib: Boolean = True): String;
var
  libTinta: ILibTinta;
begin
  Result := '';
  strIdePro := AnsiUpperCase(strIdePro);

  If blnExiLib Then
    TVerificadorTintaExistente.ExisteTinta(strIdePro);

  libTinta := TLibTintaFactory.GetITintadeMaquina(strIdePro);
  if Assigned(libTinta) then
  begin
    Result := libTinta.IdePro;
    Exit;
  end;

  If (strIdePro = 'SAL') Or (Pos(strIdePro, 'SALCOMIX') > 0) Then
    Result := 'SAL'
  Else If (strIdePro = 'GLA') Or (Pos(strIdePro, 'GLASURIT') > 0) Then
    Result := 'GLA'
  Else If (strIdePro = 'ACA') Or (Pos(strIdePro, 'PRODUTO ACABADO') > 0) Then
    Result := 'ACA';

end;

// Utilizada somente na fatformulacaoTintas
function fNomeTabelaFormulacao(strIdePro: String): String;
var
  libTinta: ILibTinta;
begin
  Result := '';
  strIdePro := AnsiUpperCase(strIdePro);

  TVerificadorTintaExistente.ExisteTinta(strIdePro);

  libTinta := TLibTintaFactory.GetITintadeMaquina(strIdePro);
  if Assigned(libTinta) then
  begin
    Result := libTinta.GetNomeTabelaFormulacao;
    Exit;
  end;

  If (strIdePro = 'SAL') Then
    Result := 'TMP_FORSAL'
  Else If (strIdePro = 'GLA') Then
    Result := 'TMP_FORGLA';

End;

function fRetornaPrecoTintaSemTela(const strIdePro, strMD5Key: String; dicRetorno: TDicionario; qryTinta: TUniQuery; var strUltMsg: string;
    strEmbPro: String; strModVen: String; strCodDil: String): Boolean;
Var
  LExibirMensagem: Boolean;
begin

  LExibirMensagem := VS_ExibirMensagemAoUsuario;
  Try
    strUltMsg := '';
    VS_strUltimaMensagem := '';
    VS_ExibirMensagemAoUsuario := False;
    dicRetorno['idepro'] := strIdePro;
    dicRetorno['itetin'] := strMD5Key;
    Result := fRetornaPrecoTABSemExecutarConsulta(qryTinta, dicRetorno, True, True, 'S', '', '', strMD5Key, True, strEmbPro, strModVen, strCodDil);
    strUltMsg := VS_strUltimaMensagem;
  Finally
    VS_ExibirMensagemAoUsuario := LExibirMensagem;
  End;
end;

//Funcao utilizada para consulta com TAB na tela de venda da tinta
function fRetornaPrecoTABSemExecutarConsulta(qryTinta: TUniQuery; dicRetorno: TDicionario;
      blnFaturamento, blnPermiteTab: Boolean; strTab: String = 'N'; strAutoTab: String = ''; strLinhaWandaPro: String = '';
      strMD5Key: String = ''; blnSemTela: Boolean = False; strEmbPro: String = ''; strModoVenda: String = ''; strCodDil: String = ''): Boolean;
var
  strIdePro: String;
  strSiglaTinta: string;
  autcomTinta: IAutcomTinta;
  libTinta: ILibTinta;
  saldos: ISaldosColorantes;
begin

  strIdePro := dicRetorno['idepro'];
  strSiglaTinta := fRetornaSiglaTinta(strIdePro);

  If (Not Assigned(dicRetorno)) Then
    dicRetorno := TDicionario.Create;

  dicRetorno['precus'] := 0.0;
  dicRetorno['unitar'] := 0.0;
  dicRetorno['fattin'] := 0.0;
  dicRetorno['prctin'] := 0.0;
  dicRetorno['prvtin'] := 0.0;
  dicRetorno['codite'] := '';
  dicRetorno['descor'] := '';
  dicRetorno['itetin'] := '';

  dicRetorno['tippre'] := '';
  dicRetorno['lazqua'] := 0;
  dicRetorno['tipemb'] := '';
  dicRetorno['qtdemb'] := 0;
  dicRetorno['preemb'] := 0.0;
  dicRetorno['embala'] := 0.0;
  dicRetorno['iteemb'] := '';

  dicRetorno['montad'] := '';
  dicRetorno['a_n_o_'] := '';
  dicRetorno['univer'] := '';

  {***************************************************}
  {* VOLUME A PRODUZIR: TINTA DE MÁQUINA COM VENDA   *}
  {* DINÂMICA                                        *}
  {** 01/01/1900 - 00:00 **************************MV*}
  dicRetorno['volpro'] := 0.0000;

  Result := False;
  try
    autcomTinta := TAutcomTintaFactory.GetIAutcomTinta(strSiglaTinta);
    if Assigned(autcomTinta) then
      Result := autcomTinta.fRetornaPreco(Nil, qryTinta, dicRetorno, blnFaturamento, blnPermiteTab, strTab, strAutoTab, nil, strMD5Key, blnSemTela)
    else
    begin
      TVerificadorTintaExistente.ExisteTinta(strSiglaTinta);
      libTinta := TLibTintaFactory.GetITintadeMaquina(strSiglaTinta);
      if Assigned(libTinta) then
      begin
        Result := libTinta.RetornaPreco(Nil, TUniQueryDataSetWrapper.Create(qryTinta),
          TDicionarioWrapper.Create(dicRetorno), saldos, blnFaturamento, blnPermiteTab, strTab, strAutoTab, nil, strMD5Key, blnSemTela, strEmbPro, strModoVenda, strCodDil);
        if Result then
        begin
          dicRetorno.AdicionarObjeto('formul', TMatrizSaldosColorantesFactory.GetMatriz(saldos));
          If (fTipoTinta(dicRetorno['idepro']) = ttAutomotiva) And (Not fEmptyStr(dicRetorno['iteemb'])) Then
            dicRetorno['saldocols'] := TMatrizSaldosColorantesFactory.GetSaldoML(TClassMatrizSaldosColorantes(dicRetorno.RetornaObjeto('formul')),
                                                                                 fCfgSis('COL_' + IIF(Pos(dicRetorno['opcdoc'], 'OR_PD_') > 0, dicRetorno['opcdoc'], 'VN')),
                                                                                 dicRetorno['iteemb'],
                                                                                 dicRetorno['qtdemb'],
                                                                                 fRetDescri('ITE_DESITE', 'ITE_CODITE', 'CADITE', dicRetorno['iteemb']));
        end;

        Exit;
      end;

      If strSiglaTinta = 'SAL' Then
      Begin
       {$IFDEF LINUX}
        raise Exception.Create('fRetornaPrecoSalcomixDinamica nao disponivel em compilacao Linux');
       {$ELSE}
        Result := fRetornaPrecoSalcomixDinamica(Nil, qryTinta, dicRetorno, blnFaturamento, blnPermiteTab, strTab, strAutoTab, nil);
       {$ENDIF}
      End
      Else If strSiglaTinta = 'GLA' Then
      Begin
       {$IFDEF LINUX}
        raise Exception.Create('fRetornaPrecoGlasuritDinamica nao disponivel em compilacao Linux');
       {$ELSE}
        Result := fRetornaPrecoGlasuritDinamica(Nil, qryTinta, dicRetorno, blnFaturamento, blnPermiteTab, strTab, strAutoTab, nil);
       {$ENDIF}
      End
      Else If strSiglaTinta = 'ACA' Then
      Begin
       {$IFDEF LINUX}
        raise Exception.Create('fRetornaPrecoProdAcabados nao disponivel em compilacao Linux');
       {$ELSE}
        Result := fRetornaPrecoProdAcabados(Nil, qryTinta, dicRetorno);
       {$ENDIF}
      End;
    end;

    pFormataValores(dicRetorno, fCfgSis('DECUNI', varInteger));
  except

    On E: ExceptionAutCom Do
    Begin
      pMensagemOk(E.Message);
    End;

    On E: Exception Do
    Begin
      If blnSemTela Then
        Raise
      Else
        pMensagensErro(E.Message, '[fRetornaPreco]');
    End;
  end;
end;

procedure pExibeMensagemTintaNaoEncontrada(dicRetorno: TDicionario);
var
  stlTintas: TStringList;
begin
  Try
    stlTintas := TStringList.Create;

    stlTintas.Add('----------------------------------------------------------------------------------');
    stlTintas.Add('                                 A T E N Ç Ã O                                    ');
    stlTintas.Add('----------------------------------------------------------------------------------');
    stlTintas.Add('AS FÓRMULAS ABAIXO SOFRERAM ALTERAÇÕES EM SUA FORMULAÇÃO E NÃO FORAM LOCALIZADAS. ');
    stlTintas.Add('FAVOR REABRIR O DOCUMENTO ' + IfNull(dicRetorno['numdoc'], '') + ' - ' + IfNull(dicRetorno['espdoc'], '') + ' E INSERIR AS FÓRMULAS NOVAMENTE.' );
    stlTintas.Add('----------------------------------------------------------------------------------');
    stlTintas.Add('');
    stlTintas.Add('DESCRIÇÃO DA FÓRMULA: ' + IfNull(dicRetorno['desite'], ''));
    stlTintas.Add('UNIDADE.............: ' + IfNull(dicRetorno['unidad'], ''));
    stlTintas.Add('PREÇO DE VENDA......: ' + 'R$ ' + FloatToStrf(IfNull(dicRetorno['unitar'], 0), ffFixed, 12, fCfgSis('DECQTD', varInteger)));
    stlTintas.Add('QUANTIDADE..........: ' + FloatToStrf(IfNull(dicRetorno['qtdite'], 0), ffFixed, 12, fCfgSis('DECQTD', varInteger)));
    stlTintas.Add('TINTA...............: ' + fRetornaNomeTinta(IfNull(dicRetorno['idepro'], '')));
    stlTintas.Add('MD5KEY..............: ' + IfNull(dicRetorno['itetin'], ''));
    stlTintas.Add('');
    stlTintas.Add('----------------------------------------------------------------------------------');

   {$IFDEF LINUX}
    WriteLog(stlTintas.Text);
   {$ELSE}
    pCriarFormularios(TfrmObservacao, frmObservacao);
    frmObservacao.Caption             := 'Tinta de máquina';
    frmObservacao.lblMensagem.Caption := 'Formulação não encontrada';
    frmObservacao.Height              := 328;
    frmObservacao.Width               := 650;
    frmObservacao.memObs.Font.Name    := 'Courier New';
    frmObservacao.memObs.Height       := 223;
    frmObservacao.memObs.Width        := 628;
    frmObservacao.memObs.Lines.Assign(stlTintas);
    frmObservacao.ShowModal;
   {$ENDIF}
  Finally
    If Assigned(stlTintas) Then FreeAndNil(stlTintas);
   {$IFNDEF LINUX}
    If Assigned(frmObservacao) Then pFreeAndNil(frmObservacao);
   {$ENDIF}
  End;
end;

function fGetLibTintaDLLRelacao: ILibTintaDllRelacao;
begin
  Result := TLibTintaDllRelacao.Create(False);
end;

Procedure pSetLiberacaoAutcomTinta(objLibera : ILiberacao); stdcall;
Begin
  pSetLiberacao(objLibera);
End;

procedure dxInitializeTin;
Begin
{$IFNDEF LINUX}
  dxInitialize;
{$ENDIF}
End;

procedure dxFinalizeTin;
Begin
  If Assigned(frmModulo) Then
  Begin
    frmModulo.Database.AssignConnect(Nil);
    frmModulo.Database.Disconnect;
    FreeAndNil(frmModulo);
  End;

  If Assigned(frmModuloSPR) Then
    FreeAndNil(frmModuloSPR);

{$IFNDEF LINUX}
  TLibTintaFactory.UnLoadDlls;
  dxFinalize;
{$ENDIF}
End;

function fRetornaDicConfigInicialAutcomTinta: TDictionary<string,boolean>;
begin
  {$IFDEF LINUX}
  Result := Nil;
  {$ELSE}
  Result := untFuncoesSimples.dicConfigInicial;
  {$ENDIF}
end;

procedure pIniciaFinalizaDicConfigInicialAutcomTinta(const blnFinaliza: Boolean=False);
begin
  {$IFDEF LINUX}

  //NÃO FAZ NADA

  {$ELSE}
  If (blnFinaliza) Then
  Begin
    If (Assigned(untFuncoesSimples.dicConfigInicial)) Then
      FreeAndNil(untFuncoesSimples.dicConfigInicial);

    If (Assigned(untFuncoesSimples.dicConfiguracoes)) Then
    Begin
      untFuncoesSimples.dicConfiguracoes.Clear;
      untFuncoesSimples.dicConfiguracoes.TrimExcess;
    End;
  End
  Else
  Begin
    If (Assigned(untFuncoesSimples.dicConfigInicial)) Then
    Begin
      untFuncoesSimples.dicConfigInicial.Clear;
      untFuncoesSimples.dicConfigInicial.TrimExcess;
    End
    Else
      untFuncoesSimples.dicConfigInicial := TDictionary<string,boolean>.Create
  End;
  {$ENDIF}
end;

procedure pRegistrarCallbackCarregaMenuTintaMaquina(ACallback: Pointer); stdcall;
begin
  @FCallbackCarregaMenuTintaMaquina := ACallback;
end;

initialization
  objTintasDeMaquina := nil;

finalization
  objTintasDeMaquina := nil;

end.

