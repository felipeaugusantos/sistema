unit untFuncTinta;

interface

uses Windows, Forms, Classes, untfuncoesSimples, SysUtils, Uni,
  untConstantes, untAutcomDllTinta, untTMatrizSaldosColorantes,
  untITintasDeMaquina, untIConfTinta, untITransferencias, untTypesSistema,
  untIFatOrdProTintaMaquina, untIDadosTinta, untICalculadorFatVendas,
  untITintaDeMaquina, untTipoTinta,  untIExecutaSQLReplicacaoTinta,
  untIFuncoesCRM, untILibTintaDllRelacao, untIFatDefineLotesPedidoWMS,
  untILiberacao, untIFuncoesSaldos, untFuncoesTintaDeMaquinaBpl, untILibTintaFactory,
  untIConsultaTinta, UniClientDataSet, DB, StrUtils, UniDataSetProvider;

Const
  DLL_TINTA = 'AutTin\AutcomTinta.dll';

procedure pRetornaPrecos(Const strCodIte: String; Var fltPreCus, fltMargem,
  fltPreVen: Double);
function fCsvToClientDataSet(strNomArq, strDelimit: String): TUniClientDataSet;
function fGeTUniClientDataSet(strSql: string; strIndice: string; blnOpen: Boolean): TUniClientDataSet;
function fGetInsert(strNomTab: String): String;
procedure pAtualizaProCodAutInc(strNomeTabela: string; intAutoInc: Integer);
procedure pRetDescUnidade(strCodUni: String; out strDescri : String; out strUnid: String);

function fItemAtivo(Const strCodIte: String): Boolean;
function fGetDescricaoProdutoTinta(const strCodIte: string): string;

procedure pEnviarLogRep(strCodite : string;
                        strIdePro : string);

function fZerarCNV_ML( strCodite : String ;
                       strIdePro : string ) : Boolean;

Var
  fTipoTinta: function(strIdePro: String): TTipoTinta; stdcall;

  pRetItemColorante: procedure(strIdePro, strColTinDet: String;
    Var strCodIte, strCodBas: String; const strCodEmp: string); stdcall;

  fTintaBaixaProduto: function(strIdePro: String): Boolean; stdcall;
  fTintaBaixaEmbalagem: function(strIdePro, strTipEmb: String;
    Var strCodIte: String): Boolean; stdcall;

  fTravaQuantidadeTinta: function(strIdePro, strTipEmb: String;
    fltQtdEmb, fltQtdDig: Double): Boolean; stdcall;

  fConsultaTintaGeral: function(strIdePro: String; Sender: TForm; strCodEmp: String): String; stdcall;
  fRetornaDescricaoTinta: function(strIdePro, strDesCri: String; qryTinta: TUniQuery; strTipPre: String): String; stdcall;
  fRetornaReferenciaTinta: function(strIdePro: String; qryTinta: TUniQuery): String; stdcall;

  fRetornaPreco: function(Sender: TForm; qryTinta, qryTintaAux: TUniQuery;
    Var dicRetorno: TDicionario; blnFaturamento: Boolean; sltItems: TStringList): Boolean; stdcall;

  fRetornaPrecoTintaSemTela: function(const strIdePro, strMD5Key: String; dicRetorno: TDicionario; qryTinta: TUniQuery): Boolean; stdcall;

  fRetornaUniTraProTinta: function(strIdePro: String; qryTinta: TUniQuery;
    fltEmbala, fltQuanti: Double; strTipPre, strIteTin,
    strCodBas, strTabPre, strCatalize: String; fltPrcTin, fltPrvTin: Double): Double; stdcall;

  fRetornaUniTraEmbTinta: function(strIdePro, strTipEmb, strTipPre: String): Double; stdcall;


  fGTinForGeral: TfGTinForGeral;

  fTintaGeraFormulacao: function (strIdePro: String): Boolean; stdcall;
  fFormulacaoTintaMaquina: function: Boolean; stdcall;

  fRetornaPrecoTintaTipo2: function (intSeqTin: Integer; strNomeTabela: String;
    Var dicRetorno: TDicionario; blnMostraTela: Boolean = True): Boolean; stdcall;

  pSetaParametros: procedure (dicParametros    : TDicionario;
                              fGrvMovGer       : TfGravaMovGer;
                              fGrvMovDet       : TfGravaMovDet;
                              recModulos       : TRecModulosAutcom;
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


  pTintaRetornaTabelaPreco: procedure (dicRetorno: TDicionario; fltFatorAcerot: Double); stdcall;

  fGetFatorML: Function (strIdePro: String): Double; stdcall;

  fTravarEstoque: function (Var dicRetorno: TDicionario): Boolean; stdcall;

  fRetSaldoML: function (strCodIte, strCodEmp: String): Double; stdcall;

  fDesfragmentaTintaSaldosOR: function (qryGenDor: TUniQuery; Var blnLocFor: Boolean; blnRecalculaSaldos: Boolean = True; blnImpTintaMaqOutroPedido: Boolean = False): TClassMatrizSaldosColorantes; stdcall;

  fVisualizarSaldoTintas: function (Formulas: TClassMatrizSaldosColorantes; strDescrCompleta : String = ''): Boolean; stdcall;

  fCalcularTabelasdePreco: function (strIdePro, strIteTin, strTipPre, strLinTin, strCatalize: String;
    intLazQua: Integer; fltQtdEmb: Double; fltQtdIte: Double; strDescri: String;
    qryArqFor: TUniQuery; fltVolPro: Double; Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList;
    strCodDil: string; fltPorDil: Double; strDilCon: String; fltPorCat: Double;
    strTipCor: String; strTextBase: String; intAcao: Integer; var dicRetorno: TDicionario; strPorPer: String = ''): Boolean; stdcall;

  fEscolheTinta: function(strCodCli : String = ''; blnProAca: Boolean = True; blnCampanha: Boolean = False): ShortString; stdcall;

  fGetListaTintas: function(strCodCli : String = ''; blnProAca: Boolean = True; blnCampanha: Boolean = False): TStringList; stdcall;


  fExisteTintaJaProduzida: function(const strIteTin, strCatali, strLinTin, strTipPre, strIdePro: string; fltVolPro: Double): Boolean; stdcall;
  fGetITintadeMaquina: function(const dadosTinta: IDadosTinta; const calculadorFatVendas: TObject): ITintaDeMaquina; stdcall;

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


  fRetornaTabelaColoranteTinta: function (strIdePro: String): String; stdcall;


  dxInitializeTin: procedure; StdCall;
  dxFinalizeTin: procedure; StdCall;

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
  function fDummy(v: Real): Real;
  function fContaDelim(l: String; strDelimit: String): Integer;
  procedure pInsert(strInsert: String; strNomTab: String);

  Procedure pSetLiberacaoAutcomTinta(objLibera : ILiberacao); stdcall; External 'AutcomTinta.dll' delayed;
  function GetLibTintaFactory(): ILibTintaFactory; stdcall; external 'AutcomTinta.dll' name 'GetLibTintaFactory';
  function fGetConsultaTinta(strIdePro: String): IConsultaTinta; stdcall; external 'AutcomTinta.dll' name 'fGetConsultaTinta';
  function fRetornaNomeTinta(strIdePro: String; blnExiLib: Boolean = True): String; stdcall external 'AutcomTinta.dll' name 'fRetornaNomeTinta';
  function fGetConfTinta(strIdePro: String): IConfTinta; stdcall; external 'AutcomTinta.dll' name 'fGetConfTinta';
  function fGetTintasdeMaquina(blnDestruir: Boolean = False): ITintasDeMaquina; stdcall; external 'AutcomTinta.dll' name 'fGetTintasdeMaquina';
  function fGetLibTintaDLLRelacao: ILibTintaDllRelacao; stdcall; external 'AutcomTinta.dll' name 'fGetLibTintaDLLRelacao';
  function IsTintaExistente(const strIdePro: string; blnExibirMsg: Boolean = True): Boolean; stdcall; external 'AutcomTinta.dll' name 'IsTintaExistente';
  function fRetornaSiglaTinta(strIdePro: String; blnExiLib: Boolean = True): String; stdcall; external 'AutcomTinta.dll' name 'fRetornaSiglaTinta';
  function fConsultaSalcomix(Sender: TForm; strCodEmp: String): String; stdcall; external DLL_TINTA name 'fConsultaSalcomix';
  function fConsultaSalcomixGeralDinamica(Sender: TForm): String; stdcall; external DLL_TINTA name 'fConsultaSalcomixGeralDinamica';
  function fConsultaGlasurit(Sender: TForm; strCodEmp: String): String; stdcall; external DLL_TINTA name 'fConsultaGlasurit';
  function fConsultaGlasuritGeralDinamica(Sender: TForm): String; stdcall; external DLL_TINTA name 'fConsultaGlasuritGeralDinamica';


implementation

uses untModulo, untLiberacaoFactory;

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
    recModulos: TRecModulosAutcom;
begin
  VS_strUsaTmq := fCfgSis('USATMQ');

  HandleDllTinta := RetornarAutcomTintaDll;

  If (HandleDllTinta = 0) Then
  Begin
    VS_strUsaTmq := 'N';
    Exit;
  End;

  pSetLiberacaoAutcomTinta(TLiberacaoFactory.fGetLiberacao);

  fTipoTinta                := GetProcAddress(HandleDllTinta, PChar('fTipoTinta'));
  pRetItemColorante         := GetProcAddress(HandleDllTinta, PChar('pRetItemColorante'));
  fTintaBaixaProduto        := GetProcAddress(HandleDllTinta, PChar('fTintaBaixaProduto'));
  fTintaBaixaEmbalagem      := GetProcAddress(HandleDllTinta, PChar('fTintaBaixaEmbalagem'));
  fTravaQuantidadeTinta     := GetProcAddress(HandleDllTinta, PChar('fTravaQuantidadeTinta'));
  fConsultaTintaGeral       := GetProcAddress(HandleDllTinta, PChar('fConsultaTintaGeral'));
  fRetornaDescricaoTinta    := GetProcAddress(HandleDllTinta, PChar('fRetornaDescricaoTinta'));
  fRetornaReferenciaTinta   := GetProcAddress(HandleDllTinta, PChar('fRetornaReferenciaTinta'));

  fRetornaPreco             := GetProcAddress(HandleDllTinta, PChar('fRetornaPreco'));
  fRetornaPrecoTintaSemTela := GetProcAddress(HandleDllTinta, PChar('fRetornaPrecoTintaSemTela'));
  fGTinForGeral             := GetProcAddress(HandleDllTinta, PChar('fGTinForGeral'));
  fRetornaUniTraProTinta    := GetProcAddress(HandleDllTinta, PChar('fRetornaUniTraProTinta'));
  fRetornaUniTraEmbTinta    := GetProcAddress(HandleDllTinta, PChar('fRetornaUniTraEmbTinta'));
  fFormulacaoTintaMaquina   := GetProcAddress(HandleDllTinta, PChar('fFormulacaoTintaMaquina'));
  fTintaGeraFormulacao      := GetProcAddress(HandleDllTinta, PChar('fTintaGeraFormulacao'));

  fRetornaPrecoTintaTipo2   := GetProcAddress(HandleDllTinta, PChar('fRetornaPrecoTintaTipo2'));

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
  fExisteTintaJaProduzida     := GetProcAddress(HandleDllTinta, PChar('fExisteTintaJaProduzida'));
  fGetITintadeMaquina         := GetProcAddress(HandleDllTinta, PChar('fGetITintadeMaquina'));

  pRetItemEDescricaoColorante := GetProcAddress(HandleDllTinta, PChar('pRetItemEDescricaoColorante'));
  fGetQuantidadeOncaPulsoMl   := GetProcAddress(HandleDllTinta, PChar('fGetQuantidadeOncaPulsoMl'));
  RecalcularTintadeMaquina    := GetProcAddress(HandleDllTinta, PChar('RecalcularTintadeMaquina'));
  GetMatrizSaldoColorantes    := GetProcAddress(HandleDllTinta, PChar('GetMatrizSaldoColorantes'));

  fRetornaTabelaColoranteTinta := GetProcAddress(HandleDllTinta, PChar('fRetornaTabelaColoranteTinta'));

  dxInitializeTin := GetProcAddress(HandleDllTinta, PChar('dxInitializeTin'));
  dxFinalizeTin   := GetProcAddress(HandleDllTinta, PChar('dxFinalizeTin'));

  dicParametros := TDicionario.Create;
  dicParametros['codemp'] := VS_strCodEmp;
  dicParametros['usuariologado'] := strLoginUsuarioLogado;
  dicParametros['strHabilitarCRM'] := VS_strHabilitarCRM;

  dxInitializeTin;

  recModulos.Banco := frmModulo.GetCurrentConnection;
  {$WARN SYMBOL_PLATFORM OFF}
  pSetaParametros(dicParametros,
                  fGrvMovGer,
                  fGrvMovDet,
                  recModulos,
                  objTransf,
                  objOrdPro,
                  DebugHook,
                  objLibera,
                  objTraceViewer,
                  objExecSQL,
                  objLotePedWMS,
                  objFuncoesCRM,
                  objFuncoesSaldos,
                  fConsulta,
                  blnUsuarioLogadoUtilizaModoClassico,
                  pImprimeImpFat);
  {$WARN SYMBOL_PLATFORM ON}

  FreeAndNil(dicParametros);

end;

function fUsaTmq: Boolean;
begin
  Result := FileExists(ExtractFilePath(Application.ExeName) + '\auttin\AutcomTinta.dll') And
            fCfgSis('USATMQ', varBoolean);
end;

function fDummy(v: Real): Real;
Begin
  Result := v;
End;

function fContaDelim(l: String; strDelimit: String): Integer;
Var
  intCont: Integer;
begin
  Result := 0;
  For intCont := 1 To Length(l) Do
  Begin
    If intCont = 1 Then
      Continue;

    If l[intCont] = strDelimit Then
    Begin
      If (intCont < Length(l)) Then
        Inc(Result);
    End
    Else If intCont = Length(l) Then
      Inc(Result);
  End;
end;

procedure pInsert(strInsert: String; strNomTab: String);
Var
  qryGen: TUniQuery;
begin
  strInsert := '';

  if strNomTab = '' then
  begin
    fMensagem('Parametro Inválido !', 'untComuns - gGetInsert()', ['&OK']);
    Exit;
  end;

  qryGen := fCriaQuery();
  qryGen.SQL.Text := 'DESC ' + strNomTab;
  qryGen.Open;
  Begin
    If Not qryGen.IsEmpty Then
    Begin
      strInsert := 'INSERT INTO ' + strNomTab + ' VALUES ( ';
      qryGen.First;

      While Not qryGen.Eof Do
      Begin
        strInsert := strInsert + ':' + RightStr(qryGen.Fields[0].AsString, 6) + ', ';
        qryGen.Next;
      End;

      strInsert := LeftStr(strInsert, Length(strInsert) - 2) + ' )';

      If SameText(strNomTab, 'CADFOR') then
        strInsert := AnsiReplaceStr(strInsert, ':0800__', ':_0800_');
    End
    Else fMensagem('', 'A Tabela ' + strNomTab + ' não Existe!', ['&OK']);
  End;
  FreeAndNil(qryGen);
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

procedure pRetornaPrecos(Const strCodIte: String; Var fltPreCus, fltMargem,

  fltPreVen: Double);
  Var
    qryAux: TUniQuery;
begin

  fltPreCus := 0.0;
  fltMargem := 0.0;
  fltPreVen := 0.0;

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT                 ');
  qryAux.SQL.Add('  ITE_PRECUS,          ');
  qryAux.SQL.Add('  ITE_MARBR1,          ');
  qryAux.SQL.Add('  ITE_PREVE1           ');
  qryAux.SQL.Add('FROM                   ');
  qryAux.SQL.Add('  ITEGER               ');
  qryAux.SQL.Add('WHERE                  ');
  qryAux.SQL.Add('  ITE_CODITE = :CODITE ');

  qryAux.ParamByName('CODITE').AsString := strCodIte;
  qryAux.Open;

  If (Not qryAux.IsEmpty) Then
  Begin
    fltPreCus := qryAux.FieldByName('ITE_PRECUS').AsFloat;
    fltMargem := qryAux.FieldByName('ITE_MARBR1').AsFloat;
    fltPreVen := qryAux.FieldByName('ITE_PREVE1').AsFloat;
  End;

  qryAux.Close;

  FreeAndNil(qryAux);

end;

function fItemAtivo(Const strCodIte: String): Boolean;
  Var
    qryAux: TUniQuery;
begin

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT ITE_ITEATI FROM CADITE WHERE ITE_CODITE = :CODITE');
  qryAux.ParamByName('CODITE').AsString := strCodIte;
  qryAux.Open;

  Result := (qryAux.FieldByName('ITE_ITEATI').AsString = 'S') Or
            (qryAux.FieldByName('ITE_ITEATI').AsString = '');

  FreeAndNil(qryAux);

end;

function fCsvToClientDataSet(strNomArq, strDelimit: String): TUniClientDataSet;
  Var
    stlArquivo: TStringList;
    intQtdDelim: Integer;
    intContador: Integer;
    intLinha: Integer;

    //USADAS PARA A FUNÇÃO VAL
    S: String;
    V: Real;
    Code: Integer;
begin
  stlArquivo := TStringList.Create;

  If (Not FileExists(strNomArq)) Then
    Raise Exception.Create('Arquivo (' + strNomArq + ') não encontrado');

  stlArquivo.LoadFromFile(strNomArq);
  If (stlArquivo.Count <= 0) Then
  Begin
    FreeAndNil(stlArquivo);
    Raise Exception.Create('Arquivo (' + strNomArq + ') vazio!');
  End;

  intQtdDelim := fContaDelim(stlArquivo[0], strDelimit);

  Result := TUniClientDataSet.Create(Nil);
  For intContador := 1 To intQtdDelim Do
  Begin
    Result.FieldDefs.AddFieldDef.DataType := ftString;
    Result.FieldDefs.AddFieldDef.Name := fGetValorLinha(stlArquivo[0], strDelimit, intContador);
    Result.FieldDefs.AddFieldDef.Size := 50;
  End;

  Result.CreateDataSet;

  For intLinha := 1 To stlArquivo.Count-1 Do
  Begin

    Result.Append;
    For intContador := 1 To intQtdDelim Do
    Begin
      Result.Fields[intContador-1].AsString := fGetValorLinha(stlArquivo[intLinha], strDelimit, intContador);
      S := Result.Fields[intContador-1].AsString;
      Val(S, V, Code);
      fDummy(v);

      If (Code = 0) Then
      Begin
        Result.Fields[intContador-1].AsString := AnsiReplaceStr(S, '.', ',');;
      End;
    End;
    Result.Post;

  End;

  FreeAndNil(stlArquivo);
end;

function fExisteValorNoCampo(valor: Variant; strCampo, strTabela: String; strCondicao: String = ''): Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();
  qryGen.SQL.Text := 'SELECT COUNT(' + strCampo + ') QTD FROM ' + strTabela + ' WHERE ' + strCampo + ' = :VALOR ';
  If Not fEmptyStr(strCondicao) Then
    qryGen.SQL.Text := qryGen.SQL.Text + ' AND ' + strCondicao;
  qryGen.ParamByName('VALOR').Value := valor;
  qryGen.Open;
  Result := qryGen.FieldByName('QTD').AsInteger > 0;
  FreeAndNil(qryGen);
end;

function fGeTUniClientDataSet(strSql: string; strIndice: string; blnOpen: Boolean): TUniClientDataSet;
var
  qryGen: TUniQuery;
  dspGen: TUniDataSetProvider;
begin
  Try
    Try
      Result := TUniClientDataSet.Create(nil);

      qryGen := fCriaQuery(Result);
      qryGen.SQL.Text := strSql;

      dspGen := TUniDataSetProvider.Create(Result);
      dspGen.DataSet := qryGen;

      Result.SetProvider(dspGen);
      Result.IndexFieldNames := strIndice;

      if blnOpen then
        Result.Open;
    Except
      on E: Exception do
      begin
        if Assigned(dspGen) then FreeAndNil(dspGen);
        if Assigned(qryGen) then FreeAndNil(qryGen);
        if Assigned(Result) then FreeAndNil(Result);
        raise;
      end;
    End;
  Finally

  End;
end;

function fGetInsert(strNomTab: String): String;
Var
  strInsert: String;
begin
  pInsert(strInsert, strNomTab);
  Result := strInsert;
end;

procedure pAtualizaProCodAutInc(strNomeTabela: string; intAutoInc: Integer);
var
  qryProCod : TUniQuery;
  qryAux    : TUniQuery;
begin
  qryProCod := nil;
  Try
    Try
      qryAux := fCriaQuery();
      qryAux.SQL.Clear;
      qryAux.SQL.Text := 'SELECT * FROM PROCOD WHERE FALSE';
      qryAux.Open;


      qryProCod := fCriaQuery();

      if intAutoInc = 0 then
      begin
        qryProCod.SQL.Clear;
        qryProCod.SQL.Text := 'SELECT MAX( SUBSTR( AUTOINCREM, 4,14 ) ) AS AUTO FROM ' + strNomeTabela;
        qryProCod.Open;
        intAutoInc := qryProCod.FieldByName('AUTO').AsInteger;
      end;

      qryProCod.SQL.Clear;


      if (qryAux.FindField('PRO_AUTINC') <> Nil) Then
      begin
        qryProCod.SQL.Text := ' UPDATE PROCOD SET ' +
                              '   PRO_AUTINC = ' + IntToStr(intAutoInc + 1) +
                              ' WHERE PRO_NOMARQ = ' + QuotedStr(strNomeTabela);


      end
      else
      begin
        qryProCod.SQL.Text := ' UPDATE PROINC SET ' +
                              '   PRO_AUTINC = ' + IntToStr(intAutoInc + 1) +
                              ' WHERE PRO_NOMARQ = ' + QuotedStr(strNomeTabela);

      end;

      qryProCod.ExecSQL;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryProCod) then FreeAndNil(qryProCod);
    if Assigned(qryAux) then FreeAndNil(qryAux);
  End;
end;

procedure pRetDescUnidade(strCodUni: String; out strDescri : String; out strUnid: String);
var
  qryGen: TUniQuery;
begin
  Try
    Try
      strDescri := '';
      strUnid := '';
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                       ' +
        '   UNI_SIGUNI                 ' +
        '   , UNI_DESUNI               ' +
        ' FROM                         ' +
        '   CADUNI                     ' +
        ' WHERE UNI_CODUNI = :CODUNI   ';

      qryGen.ParamByName('CODUNI').AsString := strCodUni;
      qryGen.Open;

      if qryGen.IsEmpty then
        Exit;

      strDescri := qryGen.FieldByName('UNI_DESUNI').AsString;
      strUnid := qryGen.FieldByName('UNI_SIGUNI').AsString;
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

function fGetDescricaoProdutoTinta(const strCodIte: string): string;
var
  qryGen: TUniQuery;
begin
  Result := '';
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                             ' +
        '   I.ITE_DESITE                     ' +
        ' FROM                               ' +
        '   CADITE I                         ' +
        '   INNER JOIN ITEGER G              ' +
        '     ON I.ITE_CODITE = G.ITE_CODITE ' +
        '   INNER JOIN CADMAR M              ' +
        '     ON I.ITE_CODMAR = M.MAR_CODMAR ' +
        '   INNER JOIN CADUNI U              ' +
        '     ON I.ITE_CODUNI = U.UNI_CODUNI ' +
        ' WHERE G.ITE_IMPLIS = "S"           ' +
        '   AND G.ITE_CODEMP = :CODEMP       ' +
        '   AND I.ITE_CODITE = :CODITE       ';

      qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryGen.ParamByName('CODITE').AsString := strCodIte;
      qryGen.Open;

      Result := qryGen.FieldByName('ITE_DESITE').AsString;
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


procedure pEnviarLogRep(strCodite : string;
                        strIdePro : string);
Var
  qryGen   : TUniQuery;
  strSQL   : String;
begin
  strSQL := '';

  If fZerarCnv_Ml(strCodite, strIdePro) then
  Begin
    Try
      strSQL := 'UPDATE CADITE '+
                '   SET ITE_CNV_ML = 0 '+
                ' WHERE ITE_CODITE = ' + strCodite;

      qryGen := fCriaQuery();
      qryGen.SQL.Text := strSQL;
      qryGen.ExecSQL;
    Finally
      FreeAndNil(qryGen);
    End;
  end;
end;

function fZerarCnv_Ml(strCodite : String ; strIdePro : string) : Boolean;
var
  tintas : ITintasDeMaquina;
  qryGen : TUniQuery;
begin
  qryGen := fCriaQuery();

  tintas := fGetTintasdeMaquina;

  Try
    Try
      qryGen.SQL.Clear;
      qryGen.Close;

      If Not((Pos(strIdePro, tintas.fGetImobiliarias) > 0)
        Or (Pos(strIdePro, tintas.fGetIndustriais) > 0)) Then
      begin
        qryGen.SQL.Text := ' SELECT COUNT(*) AS QNTD_VINCULO '+
                           '   FROM ' + strIdePro + '_CADBAS ' +
                           '  WHERE BAS_CODITE = :CODITE     ';
      end
      Else
      begin
        qryGen.SQL.Text := ' SELECT COUNT(*) AS QNTD_VINCULO '+
                           '   FROM ' + strIdePro + '_CADCOL ' +
                           '  WHERE COL_CODITE = :CODITE     ';
      end;

      qryGen.ParamByName('CODITE').AsString := strCodite;
      qryGen.Open;

      Result := (qryGen.FieldByName('QNTD_VINCULO').AsInteger = 0);
    Except
      Result := False;
    End;

  finally
    FreeAndNil(qryGen);
  end;
end;

end.

