unit untFuncTinta;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, untFuncoesGenerica,
{$ELSE}
  Windows, Forms, untfuncoesSimples,
{$ENDIF}
  Classes, SysUtils, Uni, DB, System.Generics.Collections,
  untConstantes, untAutcomDllTinta, untTMatrizSaldosColorantes,
  untITintasDeMaquina, untIConfTinta, untITransferencias, untTypesSistema,
  untIFatOrdProTintaMaquina, untIDadosTinta, untICalculadorFatVendas,
  untITintaDeMaquina, untTipoTinta,  untIExecutaSQLReplicacaoTinta,
  untIFuncoesCRM, untILibTintaDllRelacao, untIFatDefineLotesPedidoWMS,
  untILiberacao, untIFuncoesSaldos, untFuncoesTintaDeMaquinaBpl;

Var
  fTipoTinta: function(strIdePro: String): TTipoTinta; stdcall;

  pRetItemColorante: procedure(strIdePro, strColTinDet: String;
    Var strCodIte, strCodBas: String; const strCodEmp: string); stdcall;

  fTintaBaixaProduto: function(strIdePro: String): Boolean; stdcall;
  fTintaBaixaEmbalagem: function(strIdePro, strTipEmb: String;
    Var strCodIte: String): Boolean; stdcall;
  fUsaChapinhaTinta: Function(strIdePro: String; strIteTin: String): Boolean; Stdcall;
  fRetornaCodigoChapinha: Function(strIdePro: String): String; Stdcall;

  fTravaQuantidadeTinta: function(strIdePro, strTipEmb: String;
    fltQtdEmb, fltQtdDig: Double): Boolean; stdcall;

  fConsultaTintaGeral: function(strIdePro: String; Sender: TForm; strCodEmp: String): String; stdcall;
  fRetornaPreco: function(Sender: TForm; qryTinta, qryTintaAux: TUniQuery;
    Var dicRetorno: TDicionario; blnFaturamento, blnPermiteTab: Boolean; sltItems: TStringList): Boolean; stdcall;

  fRetornaDescricaoTinta: function(strIdePro, strDesCri: String; qryTinta: TUniQuery; strTipPre: String): String; stdcall;
  fRetornaReferenciaTinta: function(strIdePro: String; qryTinta: TUniQuery): String; stdcall;

  fRetornaPrecoTintaSemTela: function(const strIdePro, strMD5Key: String; dicRetorno: TDicionario; qryTinta: TUniQuery; var strUltMsg: string; strEmbPro: String;
    strModVen: String; strCodDil: String): Boolean; stdcall;

  fRetornaUniTraProTinta: function(strIdePro: String; qryTinta: TUniQuery;
    fltEmbala, fltQuanti: Double; strTipPre, strIteTin,
    strCodBas, strTabPre, strCatalize: String; fltPrcTin, fltPrvTin: Double): Double; stdcall;

  fRetornaUniTraEmbTinta: function(strIdePro, strTipEmb, strTipPre: String): Double; stdcall;

  fGTinForGeral: TfGTinForGeral;

  fTintaGeraFormulacao: function (strIdePro: String): Boolean; stdcall;

  pSetaParametros: procedure (dicParametros    : TDicionario;
                              fGrvMovGer       : TfGravaMovGer;
                              fGrvMovDet       : TfGravaMovDet;
                              {$IFDEF LINUX}
                              objConnManager   : TConnectionsManager;
                              objApplication   : TApplication;
                              {$ELSE}
                              recModulos       : TRecModulosAutcom;
                              {$ENDIF}
                              objTransf        : ITransferencias = nil;
                              objOrdPro        : IFatOrdProTintaMaquina = nil; intDebugH: Byte = 0;
                              objLibera        : ILiberacao = nil;
                              objTraceViewer   : ITraceViewer = nil;
                              objExecSQL       : IExecutaSQLReplicacaoTinta = nil;
                              objLotePedWMS    : IFatDefineLotesPedidoWMS = nil;
                              objFuncoesCRM    : IFuncoesCRM = nil;
                              objFuncoesSaldos : IFuncoesSaldos = nil;
                              fExecutarConsulta: TfConsulta = nil;
                              blnModoClassico  : Boolean = True;
                              pImprimeImpFat   : TImprimeImpFatTin = Nil); stdcall;

  pSetaEmpresaLogadaTinta: procedure (strEmpLog: String); stdcall;

  pRetornaDadosTinta: procedure (strIdePro, strIteTin: String; dicRetorno: TDicionario); stdcall;

  fFormulacaoAcumulada: function (strIdePro: String): Boolean; stdcall;


  pTintaRetornaTabelaPreco: procedure (dicRetorno: TDicionario; fltFatorAcerto: Double); stdcall;

  fGetFatorML: Function (strIdePro: String): Double; stdcall;

  fTravarEstoque: function (Var dicRetorno: TDicionario): Boolean; stdcall;

  fRetSaldoML: function (strCodIte, strCodEmp: String): Double; stdcall;

  fDesfragmentaTintaSaldosOR: function (qryGenDor: TDataSet; Var blnLocFor: Boolean; blnRecalculaSaldos: Boolean = True;
    blnImpTintaMaqOutroPedido: Boolean = False; blnProducaoForaDeLoja: Boolean = False): TClassMatrizSaldosColorantes; stdcall;

  fVisualizarSaldoTintas: function (Formulas: TClassMatrizSaldosColorantes; strDescrCompleta : String = ''): Boolean; stdcall;

  fCalcularTabelasdePreco: function (strIdePro, strIteTin, strTipPre, strLinTin, strCatalize: String;
    intLazQua: Integer; fltQtdEmb: Double; fltQtdIte: Double; strDescri: String;
    qryArqFor: TUniQuery; fltVolPro: Double; Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList;
    strCodDil: string; fltPorDil: Double; strDilCon: String; fltPorCat: Double;
    strTipCor: String; strTextBase: String; intAcao: Integer; var dicRetorno: TDicionario; strPorPer: String = ''): Boolean; stdcall;

  fEscolheTinta: function(strCodCli : String = ''; blnProAca: Boolean = True; blnCampanha: Boolean = False): ShortString; stdcall;

  fGetListaTintas: function(strCodCli : String = ''; blnProAca: Boolean = True; blnCampanha: Boolean = False): TStringList; stdcall;

  fGetTintasdeMaquina: function(blnDestruir: Boolean = False): ITintasDeMaquina; stdcall;

  fGetConfTinta: function(strIdePro: String): IConfTinta; stdcall;

  fRetornaNomeTinta: function(strIdePro: String; blnExiLib: Boolean = True): String; stdcall;
  fRetornaSiglaTinta: function (strIdePro: String; blnExiLib: Boolean = True): String; stdcall;
  fNomeTabelaFormulacao: function(strIdePro: String): String; stdcall;
  fRetornaPrecoProdAcabadoPorCodigo: function(strCodAca, strEmpAca: String; Var dicRetorno: TDicionario): Boolean; stdcall;
  pCarregaDadosFormulEtiq: procedure(qryTinDet: TDataSet; Var ftiDadosEtiq: TFormulEtiq; blnFila: Boolean = True; strEspDoc : String = ''); stdcall;

  fExisteTintaJaProduzida: function(const strIteTin, strCatali, strLinTin, strTipPre, strIdePro: string; fltVolPro: Double): Boolean; stdcall;
  fGetITintadeMaquina: function(const dadosTinta: IDadosTinta; const calculadorFatVendas: TObject; dicRetorno: TDicionario = Nil): ITintaDeMaquina; stdcall;

  pRetItemEDescricaoColorante: procedure (strIdePro, strColTinDet: String;
    Var strCodIte, strCodBas, strDesBas: String; const strCodEmp: string; strLinha_: String = ''); stdcall;

  fGetQuantidadeOncaPulsoMl : function (const fltValor: Double = 0; const strIdePro: string = ''; const strFormul: String = ''): string; stdcall;

  RecalcularTintadeMaquina: procedure (const tinta: ITintaDeMaquina; const fltPreVenAtual, fltPreCusAtual: Double); stdcall;

  GetMatrizSaldoColorantes: function (const intPos: Integer; const strCodIte: string; const strIteEmb: string;
    const strIdePro: string; const strIteTin: string; const strTipPre: string; const strLinTin: string;
    const strCatali: string; const intLazQua: Integer; const fltQtdEmb: Double; const fltQtdIte: Double;
    const strDescri: string; const fltVolPro: Double; const strCodDil: string; const fltPorDil: Double;
    const strDilCon: string; const fltPorCat: Double; const strTipCor: string; const strTextBas: string;
    const intModDil: Integer; const strIteCob: string; const strEmpIte: string; const strEmpPrd: string;
    const strNumDoc: string; const strEspDoc: string; const strCodCli: string; const strCodAca: string;
    const strEmpAca: string;
    Var blnLocFor: Boolean): TClassMatrizSaldosColorantes; stdcall;

  IsTintaExistente: function(const strIdePro: string; blnExibirMsg: Boolean = True): Boolean; stdcall;

  fRetornaTabelaColoranteTinta: function (strIdePro: String): String; stdcall;

  fGetLibTintaDLLRelacao: function: ILibTintaDllRelacao; stdcall;

  dxInitializeTin: procedure; StdCall;
  dxFinalizeTin: procedure; StdCall;

  fRetornaDicConfigInicialAutcomTinta: function: TDictionary<string,boolean>; stdcall;
  pIniciaFinalizaDicConfigInicialAutcomTinta: procedure(const blnFinaliza: Boolean=False); stdcall;

  procedure pCarregaFuncoesDll(fGrvMovGer       : TfGravaMovGer;
                               fGrvMovDet       : TfGravaMovDet;
                               objTransf        : ITransferencias;
                               objOrdPro        : IFatOrdProTintaMaquina;
                               objLibera        : ILiberacao;
                               objTraceViewer   : ITraceViewer;
                               objExecSQL       : IExecutaSQLReplicacaoTinta;
                               objLotePedWMS    : IFatDefineLotesPedidoWMS;
                               objFuncoesCRM    : IFuncoesCRM;
                               objFuncoesSaldos : IFuncoesSaldos;
                               pImprimeImpFat   : TImprimeImpFatTin);
  function fUsaTmq: Boolean;
  function fStrRelFatorLit(strAliasDet: String = ''; blnVeioMarkup: Boolean = False): String;
  function fEhTintaImobiliaria(const strIdePro: String): Boolean;
  function fEhTintaAutomotiva(const strIdePro: String): Boolean;
  function fEhTintaIndustrial(const strIdePro: String): Boolean;

  {$WARNINGS OFF}
  {$IFNDEF LINUX}
  Procedure pSetLiberacaoAutcomTinta(objLibera : ILiberacao); stdcall; External 'AutcomTinta.dll' delayed;
  procedure pRegistrarCallbackCarregaMenuTintaMaquina(ACallback: Pointer); stdcall; external 'AutcomTinta.dll' delayed;
  {$ENDIF}
  {$WARNINGS ON}

implementation

{$IFDEF LINUX}
{$ELSE}
uses
  untModulo, untLiberacaoFactory;
{$ENDIF}

procedure pCarregaFuncoesDll(fGrvMovGer       : TfGravaMovGer;
                             fGrvMovDet       : TfGravaMovDet;
                             objTransf        : ITransferencias;
                             objOrdPro        : IFatOrdProTintaMaquina;
                             objLibera        : ILiberacao;
                             objTraceViewer   : ITraceViewer;
                             objExecSQL       : IExecutaSQLReplicacaoTinta;
                             objLotePedWMS    : IFatDefineLotesPedidoWMS;
                             objFuncoesCRM    : IFuncoesCRM;
                             objFuncoesSaldos : IFuncoesSaldos;
                             pImprimeImpFat   : TImprimeImpFatTin);
  Var
    dicParametros: TDicionario;
    {$IFNDEF LINUX}
    recModulos: TRecModulosAutcom;
    {$ENDIF}
begin
  VS_strUsaTmq := fCfgSis('USATMQ');

  HandleDllTinta := RetornarAutcomTintaDll;

  If (HandleDllTinta = 0) Then
  Begin
    VS_strUsaTmq := 'N';
    Exit;
  End;

 {$IFNDEF LINUX}
  pSetLiberacaoAutcomTinta(TLiberacaoFactory.fGetLiberacao);
 {$ENDIF}

  fConsultaTintaGeral       := GetProcAddress(HandleDllTinta, PChar('fConsultaTintaGeral'));
  fRetornaPreco             := GetProcAddress(HandleDllTinta, PChar('fRetornaPreco'));

  fTipoTinta                := GetProcAddress(HandleDllTinta, PChar('fTipoTinta'));
  pRetItemColorante         := GetProcAddress(HandleDllTinta, PChar('pRetItemColorante'));
  fTintaBaixaProduto        := GetProcAddress(HandleDllTinta, PChar('fTintaBaixaProduto'));
  fTintaBaixaEmbalagem      := GetProcAddress(HandleDllTinta, PChar('fTintaBaixaEmbalagem'));
  fUsaChapinhaTinta         := GetProcAddress(HandleDllTinta, PChar('fUsaChapinhaTinta'));
  fRetornaCodigoChapinha    := GetProcAddress(HandleDllTinta, PChar('fRetornaCodigoChapinha'));
  fTravaQuantidadeTinta     := GetProcAddress(HandleDllTinta, PChar('fTravaQuantidadeTinta'));

  fRetornaDescricaoTinta    := GetProcAddress(HandleDllTinta, PChar('fRetornaDescricaoTinta'));
  fRetornaReferenciaTinta   := GetProcAddress(HandleDllTinta, PChar('fRetornaReferenciaTinta'));

  fRetornaPrecoTintaSemTela := GetProcAddress(HandleDllTinta, PChar('fRetornaPrecoTintaSemTela'));
  fGTinForGeral             := GetProcAddress(HandleDllTinta, PChar('fGTinForGeral'));
  fRetornaUniTraProTinta    := GetProcAddress(HandleDllTinta, PChar('fRetornaUniTraProTinta'));
  fRetornaUniTraEmbTinta    := GetProcAddress(HandleDllTinta, PChar('fRetornaUniTraEmbTinta'));

  fTintaGeraFormulacao      := GetProcAddress(HandleDllTinta, PChar('fTintaGeraFormulacao'));

  pSetaParametros           := GetProcAddress(HandleDllTinta, PChar('pSetaParametros'));
  pSetaEmpresaLogadaTinta   := GetProcAddress(HandleDllTinta, PChar('pSetaEmpresaLogadaTinta'));
  pRetornaDadosTinta        := GetProcAddress(HandleDllTinta, PChar('pRetornaDadosTinta'));

  fFormulacaoAcumulada      := GetProcAddress(HandleDllTinta, PChar('fFormulacaoAcumulada'));
  pTintaRetornaTabelaPreco  := GetProcAddress(HandleDllTinta, PChar('pTintaRetornaTabelaPreco'));

  fGetFatorML               := GetProcAddress(HandleDllTinta, PChar('fGetFatorML'));

  fTravarEstoque              := GetProcAddress(HandleDllTinta, PChar('fTravarEstoque'));
  fRetSaldoML                 := GetProcAddress(HandleDllTinta, PChar('fRetSaldoML'));
  fDesfragmentaTintaSaldosOR  := GetProcAddress(HandleDllTinta, PChar('fDesfragmentaTintaSaldosOR'));
  fVisualizarSaldoTintas      := GetProcAddress(HandleDllTinta, PChar('fVisualizarSaldoTintas'));
  fCalcularTabelasdePreco     := GetProcAddress(HandleDllTinta, PChar('fCalcularTabelasdePreco'));

  fEscolheTinta               := GetProcAddress(HandleDllTinta, PChar('fEscolheTinta'));
  fGetListaTintas             := GetProcAddress(HandleDllTinta, PChar('fGetListaTintas'));
  fGetTintasdeMaquina         := GetProcAddress(HandleDllTinta, PChar('fGetTintasdeMaquina'));
  fGetConfTinta               := GetProcAddress(HandleDllTinta, PChar('fGetConfTinta'));
  fRetornaNomeTinta           := GetProcAddress(HandleDllTinta, PChar('fRetornaNomeTinta'));
  fRetornaSiglaTinta          := GetProcAddress(HandleDllTinta, PChar('fRetornaSiglaTinta'));
  fNomeTabelaFormulacao       := GetProcAddress(HandleDllTinta, PChar('fNomeTabelaFormulacao'));
  fRetornaPrecoProdAcabadoPorCodigo := GetProcAddress(HandleDllTinta, PChar('fRetornaPrecoProdAcabadoPorCodigo'));
  pCarregaDadosFormulEtiq     := GetProcAddress(HandleDllTinta, PChar('pCarregaDadosFormulEtiq'));
  fExisteTintaJaProduzida     := GetProcAddress(HandleDllTinta, PChar('fExisteTintaJaProduzida'));
  fGetITintadeMaquina         := GetProcAddress(HandleDllTinta, PChar('fGetITintadeMaquina'));

  pRetItemEDescricaoColorante := GetProcAddress(HandleDllTinta, PChar('pRetItemEDescricaoColorante'));
  fGetQuantidadeOncaPulsoMl   := GetProcAddress(HandleDllTinta, PChar('fGetQuantidadeOncaPulsoMl'));
  RecalcularTintadeMaquina    := GetProcAddress(HandleDllTinta, PChar('RecalcularTintadeMaquina'));
  GetMatrizSaldoColorantes    := GetProcAddress(HandleDllTinta, PChar('GetMatrizSaldoColorantes'));
  IsTintaExistente            := GetProcAddress(HandleDllTinta, PChar('IsTintaExistente'));

  fRetornaTabelaColoranteTinta := GetProcAddress(HandleDllTinta, PChar('fRetornaTabelaColoranteTinta'));
  fGetLibTintaDLLRelacao       := GetProcAddress(HandleDllTinta, PChar('fGetLibTintaDLLRelacao'));

  dxInitializeTin := GetProcAddress(HandleDllTinta, PChar('dxInitializeTin'));
  dxFinalizeTin   := GetProcAddress(HandleDllTinta, PChar('dxFinalizeTin'));

  fRetornaDicConfigInicialAutcomTinta := GetProcAddress(HandleDllTinta, PChar('fRetornaDicConfigInicialAutcomTinta'));
  pIniciaFinalizaDicConfigInicialAutcomTinta := GetProcAddress(HandleDllTinta, PChar('pIniciaFinalizaDicConfigInicialAutcomTinta'));

  dicParametros := TDicionario.Create;
  dicParametros['codemp'] := VS_strCodEmp;
  dicParametros['usuariologado'] := strLoginUsuarioLogado;
  dicParametros['strHabilitarCRM'] := VS_strHabilitarCRM;

  dxInitializeTin;

{$IFNDEF LINUX}
  recModulos.Banco := frmModulo.GetCurrentConnection;

  If (Assigned(untfuncoesSimples.dicConfigInicial)) Then
    If Assigned(pIniciaFinalizaDicConfigInicialAutcomTinta) Then
      pIniciaFinalizaDicConfigInicialAutcomTinta;
{$ENDIF}

  {$WARN SYMBOL_PLATFORM OFF}
  pSetaParametros(dicParametros,
                  fGrvMovGer,
                  fGrvMovDet,
                  {$IFDEF LINUX}objConnectionsManager, Application{$ELSE}recModulos{$ENDIF},
                  objTransf,
                  objOrdPro,
                  DebugHook,
                  objLibera,
                  objTraceViewer,
                  objExecSQL,
                  objLotePedWMS,
                  objFuncoesCRM,
                  objFuncoesSaldos,
                  {$IFDEF LINUX}nil{$ELSE}fConsulta{$ENDIF},
                  {$IFDEF LINUX}True{$ELSE}blnUsuarioLogadoUtilizaModoClassico{$ENDIF},
                  pImprimeImpFat);
  {$WARN SYMBOL_PLATFORM ON}

  FreeAndNil(dicParametros);

end;

function fUsaTmq: Boolean;
begin
  Result := FileExists(ExtractFilePath(Application.ExeName) + DLL_TINTA_PATH) And
            fCfgSis('USATMQ', varBoolean);
end;

function fStrRelFatorLit(strAliasDet: String = ''; blnVeioMarkup: Boolean = False): String;
  Var
    tintas: ITintasDeMaquina;
begin
  If fUsaTmq Then
  Begin
    If Not fEmptyStr(strAliasDet) Then
    Begin
      If strAliasDet[Length(strAliasDet)] <> '.' Then
        strAliasDet := strAliasDet + '.';
    End;

    tintas := fGetTintasdeMaquina;

    Result := ' IF((' + strAliasDet + 'DET_VOLPRO > 0) ';
    Result := Result + ' AND (LOCATE(' + strAliasDet + 'DET_IDEPRO,"' + tintas.fGetImobiliarias + '") <= 0) ';
    Result := Result + ' , ' + strAliasDet + 'DET_VOLPRO, ' + IIF(blnVeioMarkup, ' ITE_PESLIQ / DET_PESESP ', ' UNI_PESLIT / :LITGAL ') + ' ) ';
  End
  Else
  Begin
    If blnVeioMarkup Then
      Result := ' ITE_PESLIQ / DET_PESESP '
    Else
      Result := ' UNI_PESLIT / :LITGAL ';
  End;
end;

function fEhTintaImobiliaria(const strIdePro: String): Boolean;
begin
  Result := False;

  If strIdePro.IsEmpty Then
    Exit;

  If strIdePro.Equals('NOR') Then
    Exit;

  Result := untFuncoesTintaDeMaquinaBpl.fGetTintaImobiliaria(strIdePro);
end;

function fEhTintaAutomotiva(const strIdePro: String): Boolean;
begin
  Result := False;

  If strIdePro.IsEmpty Then
    Exit;

  If strIdePro.Equals('NOR') Then
    Exit;

  Result := untFuncoesTintaDeMaquinaBpl.fGetTintaAutomotiva(strIdePro);
end;

function fEhTintaIndustrial(const strIdePro: String): Boolean;
begin
  Result := False;

  If strIdePro.IsEmpty Then
    Exit;

  If strIdePro.Equals('NOR') Then
    Exit;

  Result := untFuncoesTintaDeMaquinaBpl.fGetTintaIndustrial(strIdePro);
end;

end.


