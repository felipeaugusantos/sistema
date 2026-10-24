{********************************************************************************************}
{* Classe responsável pelas funcções usadas no autcomtinta que que são usadas nas dlls da   *}
{* tinta, implementando a interface IAutcomTintaWrapper, assim é possivel que as dlls tenam *}
{* acesso as funcções, sem precisarem ter acesso as implementações                          *}
{*****************************************************************************************PH*}
unit untAutcomTintaWrapper;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
  Shared.Core, Shared.Functions.DataSet,
{$ELSE}
  untFuncoesSimples, Forms,
  Vcl.Graphics, Vcl.Dialogs, BitBtnLockedIncrem,
  UniClientDataSet, EditFocus, DBEditFocus, Controls,
  untMensagemTabela, Windows,
{$ENDIF}
  untIAutcomTintaWrapper, untTintaMaquina, untIConfTinta, untIDataSet,
  untParCalculaPrecoCusto, SysUtils, untITintadeMaquinaWrapper, untIConsultaTinta,
  untIDicionario, Variants, Classes, Uni, StrUtils, untDDLFactory, untFuncEspecificas,
  untTipoCadastro, DB, untTypesSistema,
  System.UITypes, untILiberacao, untMsgLiberacao, untLiberacaoFactory;
type
  TAutcomTintaWrapper = class(TInterfacedObject, IAutcomTintaWrapper)
  public
    function fGetConfTinta(const strIdePro: String): IConfTinta;
    function fGetDataSet: IDataSet;
    {$IFNDEF LINUX}
    function GetObjTraceViewer(): ITraceViewer;
    {$ENDIF}
    function fCfgSis(const strCamCfg: String; const varTipVar: TVarType = varString; const strCodEmp: String = ''): Variant;
    function fArqIniTinta(const ReadWrite: Integer; const NomChave, NomSecao, Conteudo: String): String;

    function fLock_Unlock(strNomeTabela         : String;
                          blnTrava              : Boolean;
                          blnLoopTravamento     : Boolean = True;
                          blnHourGlass          : Boolean = false;
                          strCon_Id             : String = '';
                          blnMostraMsgTravamento: Boolean = True;
                          strOrigem             : String = ''): Boolean;

    function fVerificaAcessoSistema(strNomeForm: String; strCodOpe: String = ''): Boolean;
    function GetInToOr(const strNomeCampo: string; const strValores: string): string;


    function fGetHostLock(strNomeTabela: String; blnSohIP: Boolean = False): String;



    function GetCodEmp(): String;
    function fCalculaPrecoCusto2(const dicDados: IDicionario): Double;
    function GetIConsultaTinta(const tintadeMaquinaWrapper: ITintadeMaquinaWrapper): IConsultaTinta;
   {$IFNDEF LINUX}
    function fConsultaDinamica(const Sender: TObject; const tintadeMaquinaWrapper: ITintadeMaquinaWrapper): String;
    function fConsultaDinamicaGeral(const Sender: TObject; const tintadeMaquinaWrapper: ITintadeMaquinaWrapper): String;
    function fConsultaDinamicaVenda(const Sender: TObject; const strTabPre: String;
      const tintadeMaquinaWrapper: ITintadeMaquinaWrapper; blnFaturamento, blnPermiteTab: Boolean;
      dicRetorno: IDicionario; sltItems: TStringList): String;
   {$ENDIF}
   {$IFDEF LINUX}
    function ExecutarQueryEmCache(qryGen: TUniQuery): IMyCampoTabela; overload;
    function ExecutarQueryEmCache(qryGen: IDataSet): IMyCampoTabela; overload;
    procedure WriteError(AText: string);
    procedure WriteLog(AText: string);
   {$ENDIF}
    procedure pMensagensErro(const MensErro, LocalErro: String; const strMensagem: String = '');
    procedure pGravarErro(const GravarErro:Boolean; const MensagemErro: String);
    procedure pAjudaAutcom(const Handle: THandle; const intNumHlp: Integer);
    function fRetNomProduto(Const strCodIte: String): String;
    function GetDicionario(): IDicionario;
   {$IFNDEF LINUX}
    function pConsultaComp(arrSql,
                        arrCampos,
                        arrOrdenacao: Array Of String;
                        strCampoChave,
                        strTabela,
                        strNomForm,
                        strTitulo: String;
                        var qryTabela: IDataSet;
                        arrSubConsultas,
                        arrSubConsultasCampos: array of String;
                        blnComSaldo: Boolean = False): boolean;

    function fPesqGenericaTinta(var qryTabela: IDataSet;
                                strTabela: string;
                                strNomForm: string = '';
                                strTitulo: string = '';
                                strCamposRelacionado: string = '';
                                strFiltros: string = '';
                                blnComProdutos: boolean = True): boolean;

    function fEntraCons(const strCodigo: String): Boolean;
   {$ENDIF}

    function fMensagem(const strTitulo: String; const strTexto: String; arrOpcoes: Array Of String;
      intFocoBotao: Integer = 1; blnSaiComEsc: Boolean = False; intEstFon: Integer = 1; intWidBut: Integer = 0;
      intSomarTop: Integer=0): Integer;
    function fRetAutoIncrem(const strNomeTabela: string; const strCodEmp: string): string;
    function GetInsert(const strTabela: string): string;
    function GetInsertDelayed(const strTabela: string): string;
    function fInsereProCod(const strNomTab: string; blnCodAut : Boolean = true): Boolean;
    procedure TruncateTable(const strNomeTabela: string);
    procedure DropTable(const strNomeTabela: string);
    function fUsaProCodigo(strNomeTabela: string): Boolean;
    procedure pValidaProCod(strNomeTabela: string);
    function fGetDescricaoProdutoTinta(const strCodIte: string; Tipo: TTipoCadastro): string;
    function GetValorCampo(const strSql: string; const strNomeCampo: string; const arrParametros: array of string; blnUsaCache: Boolean = False): Variant;
    function fCalculaPrecoVenda(intOpcPrecoMargem: Integer;
                              curPrecus,
                              curPreven,
                              curMarBru,
                              curIcmsVenda,
                              curImpFed,
                              curDesOpe,
                              curValCom: Currency;
                              strMarMkp: String = '';
                              strPcmPro: String = '';
                              intDecUni: Integer = -1): Double;
   {$IFNDEF LINUX}
    function fCriarProcesso(strArquivo: string; blnTrava: Boolean): boolean;
    function GetTituloVersao(): String;
   {$ENDIF}
    function GetUsuarioUtilizaTemaClassico(): Boolean;
    function GetUsuarioLogado: string;
    function fCarregaPromocao(strCodIte, strTabPre, strCodCli, strCodCnd: String;
        intPrzMed: Integer; var fltPreCus, fltPreVen: Double; var blnPrecoFixoParaTintaDeMaquinaImobiliaria : Boolean;
        strCodEmp: String = ''; fltPrecoTotalColorantes : Double = 0): Boolean;

    function fCalculaPrecoCompraLiq(fltPreCom, fltDesf01, fltDesf02, fltDesf03,
        fltDesf04, fltDesf05, fltDesf06: Double; blnPreDol: Boolean = False): Double;

    function fCalculaPrecoCompraLiquido(fltPreCom, fltDesf01, fltDesf02, fltDesf03,
      fltDesf04, fltDesf05, fltDesf06: Double; blnPreDol: Boolean = False): Double;

    function fExisteValorNoCampo(valor: Variant; strCampo, strTabela: String; strCondicao: String = ''): Boolean;
    function IIF(lTest:Boolean; vExpr1,vExpr2:Variant):Variant;
    function fIsNumber(Const strNumber: String): Boolean;
    function fStrToFloat(strValorUnico: String): Double;
    function fSenderName(Const strName : String) : String;
    var strNomeForm : String;

    {$IFNDEF LINUX}
    function fGetMenu(strTitulo: String; arrOpcoes: Array Of String; intOpcao: Integer;
       blnSaiComEsc: Boolean = False; blnLibQtd: Boolean = False): Integer;
    {$ENDIF}

    function GetEmpBasDup: Boolean;
    function GetEmpBasDux: Boolean;
    function GetEmpBasDu2: Boolean;

    function fValidarBaseItemAmarracao(strIdePro : String; strCodBaseAtu : String; strDescBaseAtu : String ; strCodIte : String;
                                       strCoditeAnt : String; fltPesEsp : Double; fltEmbala : Double ) : Boolean;

    {$IFNDEF LINUX}
    function fDigSenVarTroDir(strNomeCli, strCpfCnpj, strCliCid, strVendedor, strIdepro,
      strDescTinta, strUnidade, strBaseAtual, strBaseNova, strDescAdicional: String) : Boolean;
    {$ENDIF}

    function fGravarLogLiberacaoBaseAutomotiva(Var strOperadorLiberou: String;
      strCodBas: String; strMensagem: String): Boolean;

    function fRemoveAcento(Str:String): String;

    procedure pEnviarLogRep(strCodite : string; strIdePro : string);

    procedure pPreencherValorVenda(strCodIte : String; strCodEmp : String; var strVlrCusto, strValorMargem, strValorVenda: String);


    procedure pReplicarFatorTintometrico(strSQL    : String;
                                         strCodIte : String);

    function fZerarCNV_ML( strCodite : String ;
                           strIdePro : string ) : Boolean;

    {$IFNDEF LINUX}
    function fRetirarEspacos(Sender: TObject): String;
    {$ENDIF}

    function fFormataFloat(fltNumero: Double; intDecimais: Integer): Double;
    function fRetGrupoItem(strCodIte: String): String;
    function fCriaQuery(): TUniQuery; overload;
    function fCriaQuery(AOwner: TComponent): TUniQuery; overload;
    function fCriaQuery(AOwner: TComponent; Conexao: TUniConnection): TUniQuery; overload;
    function fCriaClientDatset(qryOrigem: TDataSet; blnVazio: Boolean = False; AOwner: TComponent = Nil; blnRegistroAtual: Boolean = False): TUniClientDataSet;
    function fFormataFloatSky(fltValor: Double): Double;

    function fTamCodIte: Integer;

    {$IFNDEF LINUX}
    Procedure pSetaCodIte(edtCodIte: TEditFocus); overload;
    Procedure pSetaCodIte(edtCodIte: TDBEditFocus); overload;
    Procedure pSetaCodIte(edtCodIte: TStringField); overload;
    procedure pSetFocus(SenderUnico: TWinControl; Form: TCustomForm = nil);
    {$ENDIF}

    function fRetornaTipoDoCampo( strTabela : string = ''; strCampo: string = '' ) : String;

    Function fMensagemTabela(strTitulo : String;
                           strTitCol   : String;
                           arrMensagem : TStringArray;
                           strTexto    : String;
                           arrOpcoes   : Array Of String;
                           intFocoBotao: Integer = 1;
                           blnSaiComEsc: Boolean = False;
                           intEstFon   : Integer = 1;
                           intWidBut   : Integer = 0;
                           blnAutosize : Boolean = False;
                           intSomarTop : Integer=0;
                           blnObrigaEsc: Boolean = False;
                           blnOcultPainelBtn: Boolean = False;
                           blnBtnSemImg: Boolean = False;
                           intHeightOpc: Integer = 0;
                           intHeightFrm: Integer = 0;
                           intWidthFrm: Integer = 0;
                           blnBtnOk: Boolean = False): Integer;

    procedure pAddDados(Var arrAdd : TStringArray; strTexto: String; blnConsiderarEnter: Boolean = False); overload;
    procedure pAddDados(Var arrAdd, arrHin : TStringArray; strTexto: String; strHint : String = ''; blnConsiderarEnter: Boolean = False); overload;
    function fPadL(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
    function fPadC(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
    function fPadR(strTexto: String; intTamanhoMin: Integer; intTamanhoMax: Integer; strCaracter: String = ' '): String; Overload;
    function fPadR(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String; Overload;
    function fUsaQtdPendenteEntregaFutura(blnConsiderarCfgCalSal : Boolean = True; strEmpSalRes : String = ''): Boolean;
    function fSQLSaldoDisponivel(const AAlias: String = 'G';
                                        AFaturamento: Boolean = False;
                                        ALote: Boolean = False): string;
    function fSQLSaldoFisico(): String;
    procedure pSetaEmpresaLogadaTinta(strEmpLog: String);
    function fTiraCaracEspeciaisPonto(strTexto: String): String;
    function fEhAdministrador(strCodOpe: String): Boolean;
    function fTabelaExiste(strNomeTabela: String; Conexao: TUniConnection = Nil): Boolean;
    procedure pTrimAppMemorySize();

  {$IFNDEF LINUX}
    function fNow: TDateTime;
  {$ENDIF}

   {$IFNDEF LINUX}
    procedure CriarNovasFormulasDllsGeneric(AClass: String);
   {$ENDIF}
  end;

implementation

uses
{$IFDEF LINUX}
  untFuncoesGenerica,
{$ELSE}
  untConsultas, untClassPanelCx, untDigSenVarTroDir, untVersaoProg,
{$ENDIF}
  untUniQueryDataSetWrapper, untTintadeMaquinaWrapper, untDicionarioWrapper,
  untTConfiguracao, untValidarBaseItemAmarracao, untTipoTinta;

{ TAutcomTintaWrapper }

{$IFNDEF LINUX}
procedure TAutcomTintaWrapper.CriarNovasFormulasDllsGeneric(AClass: String);
Var
  HandleLibAutTin: HMODULE;
  prcCriarNovasFormulasDllGeneric: procedure(AClass: String); stdcall;
begin
  If Not Assigned(untTintaMaquina.FCallbackCarregaMenuTintaMaquina) Then
    raise Exception.Create(
      'Callback de carga do menu de Tinta de Maquina nao registrado pelo executavel. ' +
      'Verifique se autcom.exe chamou pCarregarLibTintaMaquina antes de usar o wrapper.');

  untTintaMaquina.FCallbackCarregaMenuTintaMaquina();

  HandleLibAutTin := GetModuleHandle('libAuttin.dll');
  If HandleLibAutTin = 0 Then
    raise Exception.Create('libAuttin.dll nao esta carregada apos a chamada do menu sob demanda.');

  @prcCriarNovasFormulasDllGeneric := GetProcAddress(HandleLibAutTin, 'CriarNovasFormulasDllGeneric');
  If Not Assigned(prcCriarNovasFormulasDllGeneric) Then
    raise Exception.Create('Export CriarNovasFormulasDllGeneric nao encontrado em libAuttin.dll.');

  prcCriarNovasFormulasDllGeneric(AClass);
end;
{$ENDIF}

procedure TAutcomTintaWrapper.DropTable(const strNomeTabela: string);
begin
  fExecutaSQL('DROP TABLE IF EXISTS ' + strNomeTabela);
end;

{$IFDEF LINUX}
function TAutcomTintaWrapper.ExecutarQueryEmCache(
  qryGen: IDataSet): IMyCampoTabela;
begin
  Result := Shared.Core.ExecutarQueryEmCache(TUniQuery(qryGen.GetObject));
end;
{$ENDIF}

{$IFDEF LINUX}
function TAutcomTintaWrapper.ExecutarQueryEmCache(
  qryGen: TUniQuery): IMyCampoTabela;
begin
  Result := Shared.Core.ExecutarQueryEmCache(qryGen);
end;
{$ENDIF}

function TAutcomTintaWrapper.fArqIniTinta(const ReadWrite: Integer; const NomChave, NomSecao, Conteudo: String): String;
begin
{$IFDEF LINUX}
  Result := String(fArqIniTinta(ReadWrite, NomChave, NomSecao, Conteudo));
{$ELSE}
  Result := String(untFuncEspecificas.fArqIniTinta(ReadWrite, NomChave, NomSecao, Conteudo));
{$ENDIF}
end;

function TAutcomTintaWrapper.fCalculaPrecoCompraLiq(fltPreCom, fltDesf01,
  fltDesf02, fltDesf03, fltDesf04, fltDesf05, fltDesf06: Double;
  blnPreDol: Boolean = False): Double;
begin
{$IFDEF LINUX}
  Result := untFuncoesGenerica.fCalculaPrecoCompraLiquido(fltPreCom, fltDesf01,
                                                          fltDesf02, fltDesf03,
                                                          fltDesf04, fltDesf05,
                                                          fltDesf06, -1,
                                                          blnPreDol);
{$ELSE}
  Result := untFuncoesSimples.fCalculaPrecoCompraLiquido(fltPreCom, fltDesf01,
                                                         fltDesf02, fltDesf03,
                                                         fltDesf04, fltDesf05,
                                                         fltDesf06, blnPreDol);
{$ENDIF}
end;

function TAutcomTintaWrapper.fCalculaPrecoCompraLiquido(fltPreCom, fltDesf01,
  fltDesf02, fltDesf03, fltDesf04, fltDesf05, fltDesf06: Double;
  blnPreDol: Boolean): Double;
begin
{$IFDEF LINUX}
  Result := untFuncoesGenerica.fCalculaPrecoCompraLiquido(fltPreCom, fltDesf01,
                                                          fltDesf02, fltDesf03,
                                                          fltDesf04, fltDesf05,
                                                          fltDesf06, -1,
                                                          blnPreDol);
{$ELSE}
  Result := untFuncoesSimples.fCalculaPrecoCompraLiquido(fltPreCom, fltDesf01,
                                                         fltDesf02, fltDesf03,
                                                         fltDesf04, fltDesf05,
                                                         fltDesf06, blnPreDol);
{$ENDIF}
end;

function TAutcomTintaWrapper.fCalculaPrecoCusto2(const dicDados: IDicionario): Double;
var
  parcus: TParCalculaPrecoCusto;
begin
  Result := 0;
  parcus := nil;
  Try
    Try
      parcus := TParCalculaPrecoCusto.Create(Nil, TConfiguracao.fGetConfiguracao);
      Result := parcus.fCalculaPrecoCustoRealVenda(IfNull(dicDados['preven'], 0),
        IfNull(dicDados['precus'], 0),
        IfNull(dicDados['outval'], 0),
        IfNull(dicDados['icmsai'], 0),
        IfNull(dicDados['impfed'], 0),
        IfNull(dicDados['desope'], 0),
        0,
        0);
    Except
      on E: Exception do
      begin
       {$IFDEF LINUX}
        WriteError(E.Message);
       {$ENDIF}
        raise;
      end;
    End;
  Finally
    if Assigned(parcus) then FreeAndNil(parcus);
  End;
end;

function TAutcomTintaWrapper.fCalculaPrecoVenda(intOpcPrecoMargem: Integer;
  curPrecus, curPreven, curMarBru, curIcmsVenda, curImpFed, curDesOpe,
  curValCom: Currency; strMarMkp, strPcmPro: String;
  intDecUni: Integer): Double;
begin
{$IFDEF LINUX}
  Result := untFuncoesGenerica.fCalculaPrecoVenda(intOpcPrecoMargem, curPrecus, curPreven, curMarBru, curIcmsVenda, curImpFed, curDesOpe,
    curValCom, strMarMkp, strPcmPro, intDecUni);
{$ELSE}
  Result := untFuncoesSimples.fCalculaPrecoVenda(intOpcPrecoMargem, curPrecus, curPreven, curMarBru, curIcmsVenda, curImpFed, curDesOpe,
    curValCom, strMarMkp, strPcmPro, intDecUni);
{$ENDIF}
end;

function TAutcomTintaWrapper.fCarregaPromocao(strCodIte, strTabPre, strCodCli, strCodCnd: String;
  intPrzMed: Integer; var fltPreCus, fltPreVen: Double; var blnPrecoFixoParaTintaDeMaquinaImobiliaria : Boolean;
  strCodEmp: String = ''; fltPrecoTotalColorantes : Double = 0): Boolean;
begin
  Result := untFuncEspecificas.fCarregaPromocao(strCodIte, strTabPre, strCodCli,
                                                strCodCnd, intPrzMed, fltPreCus,
                                                fltPreVen, blnPrecoFixoParaTintaDeMaquinaImobiliaria,
                                                strCodEmp, fltPrecoTotalColorantes);
end;

function TAutcomTintaWrapper.fCfgSis(const strCamCfg: String; const varTipVar: TVarType; const strCodEmp: String): Variant;
begin
{$IFDEF LINUX}
  Result := Services.Core.Settings.fCfgSis(strCamCfg, varTipVar, strCodEmp);
{$ELSE}
  Result := untFuncoesSimples.fCfgSis(strCamCfg, varTipVar, strCodEmp);
{$ENDIF}
end;

{$IFNDEF LINUX}
function TAutcomTintaWrapper.fConsultaDinamica(const Sender: TObject; const tintadeMaquinaWrapper: ITintadeMaquinaWrapper): String;
begin
  Result := TTintadeMaquinaWrapper.fConsultaDinamica(TForm(Sender), tintadeMaquinaWrapper);
end;
{$ENDIF}

{$IFNDEF LINUX}
function TAutcomTintaWrapper.fConsultaDinamicaGeral(const Sender: TObject; const tintadeMaquinaWrapper: ITintadeMaquinaWrapper): String;
begin
  Result := TTintadeMaquinaWrapper.fConsultaDinamicaGeral(TForm(Sender), tintadeMaquinaWrapper);
end;
{$ENDIF}

{$IFNDEF LINUX}
function TAutcomTintaWrapper.fConsultaDinamicaVenda(const Sender: TObject; const strTabPre: String;
  const tintadeMaquinaWrapper: ITintadeMaquinaWrapper; blnFaturamento, blnPermiteTab: Boolean; dicRetorno: IDicionario; sltItems: TStringList): String;
begin
  Result := TTintadeMaquinaWrapper.fConsultaDinamicaVenda(TForm(Sender),
    strTabPre,
    tintadeMaquinaWrapper,
    blnFaturamento, blnPermiteTab,
    dicRetorno, sltItems);
end;
{$ENDIF}

function TAutcomTintaWrapper.fCriaClientDatset(qryOrigem: TDataSet;
  blnVazio: Boolean; AOwner: TComponent;
  blnRegistroAtual: Boolean): TUniClientDataSet;
begin
{$IFDEF LINUX}
  Result := Services.Core.Connection.Manager.fCriaClientDatset(qryOrigem, blnVazio, AOwner, blnRegistroAtual);
{$ELSE}
  Result := untFuncoesSimples.fCriaClientDatset(qryOrigem, blnVazio, AOwner, blnRegistroAtual);
{$ENDIF}
end;

function TAutcomTintaWrapper.fCriaQuery(): TUniQuery;
begin
{$IFDEF LINUX}
  Result := Shared.Core.fCriaQuery;
{$ELSE}
  Result := untFuncoesSimples.fCriaQuery;
{$ENDIF}
end;

function TAutcomTintaWrapper.fCriaQuery(AOwner: TComponent): TUniQuery;
begin
{$IFDEF LINUX}
  Result := Shared.Core.fCriaQuery(AOwner);
{$ELSE}
  Result := untFuncoesSimples.fCriaQuery(AOwner);
{$ENDIF}
end;

function TAutcomTintaWrapper.fCriaQuery(AOwner: TComponent; Conexao: TUniConnection): TUniQuery;
begin
{$IFDEF LINUX}
  Result := Shared.Core.fCriaQuery(AOwner, Conexao);
{$ELSE}
  Result := untFuncoesSimples.fCriaQuery(AOwner, Conexao);
{$ENDIF}
end;

{$IFNDEF LINUX}
function TAutcomTintaWrapper.fCriarProcesso(strArquivo: string;
  blnTrava: Boolean): boolean;
begin
  Result := untFuncoesSimples.fCriarProcesso(strArquivo, blnTrava);
end;
{$ENDIF}

{$IFNDEF LINUX}
function TAutcomTintaWrapper.fDigSenVarTroDir(strNomeCli, strCpfCnpj, strCliCid,
  strVendedor, strIdepro, strDescTinta, strUnidade, strBaseAtual, strBaseNova,
  strDescAdicional: String): Boolean;
Var
  objLiberacao: ILiberacao;
begin
  Try
    Try
      objLiberacao := TLiberacaoFactory.fGetLiberacao();
      objLiberacao.objMsgLibera.Clear;
      objLiberacao.objMsgRemota.Clear;
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.lstRegistros.OwnsObjects := False;

      objLiberacao.objMsgLibera.pAddTexto('Troca de Base de Tinta Imobiliaria');
      objLiberacao.objMsgLibera.pAddTexto('------------------------------------------------------------------------------------------------------');
      objLiberacao.objMsgLibera.pAddTexto('Vendedor: ' + strVendedor);
      objLiberacao.objMsgLibera.pAddTexto('IDEPRO..: ' + strIdepro);
      objLiberacao.objMsgLibera.pAddTexto('Tinta...: ' + strDescTinta + ' - ' + ' Unidade: ' + strUnidade);
      objLiberacao.objMsgLibera.pAddTexto('------------------------------------------------------------------------------------------------------');
      objLiberacao.objMsgLibera.pAddTexto('Base Atual: ' + strBaseAtual);
      objLiberacao.objMsgLibera.pAddTexto('Nova Base.: ' + strBaseNova);
      objLiberacao.objMsgLibera.pAddTexto('Descrição Adicional: ' + strDescAdicional);
      objLiberacao.objMsgLibera.pAddTexto('------------------------------------------------------------------------------------------------------');
      objLiberacao.objMsgLibera.pAddTexto('Cidade..: ' + strCliCid);
      objLiberacao.strDirAce := 'TRODIR';
      objLiberacao.strSenLib := '';
      objLiberacao.blnLiberaAcesso := True;
      objLiberacao.blnSempreVariavelUsuario := True;
      objLiberacao.strSenFvu := 'U';
      objLiberacao.strCliente := strNomeCli;
      objLiberacao.strCpfCnpj := strCpfCnpj;
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.strCodDig := strLoginUsuarioLogado;
      objLiberacao.strMsgSen := 'LIBERAÇÃO DE ACESSO PARA TROCA DE BASE';
      objLiberacao.objMsgLibera.strTitulo := 'LIBERAÇÃO DE ACESSO PARA TROCA DE BASE';

      Result := objLiberacao.fLibera;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fDigSenVarTroDir]');
      End;
    End;
  Finally
  End;
end;
{$ENDIF}

function TAutcomTintaWrapper.fEhAdministrador(strCodOpe: String): Boolean;
begin
{$IFDEF LINUX}
  Result := Services.Core.Settings.fEhAdministrador(strCodOpe);
{$ELSE}
  Result := untFuncoesSimples.fEhAdministrador(strCodOpe);
{$ENDIF}
end;

{$IFNDEF LINUX}
function TAutcomTintaWrapper.fEntraCons(const strCodigo: String): Boolean;
begin
  Result := untFuncoesSimples.fEntraCons(strCodigo);
end;
{$ENDIF}

function TAutcomTintaWrapper.fExisteValorNoCampo(valor: Variant; strCampo,
  strTabela, strCondicao: String): Boolean;
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

function TAutcomTintaWrapper.fFormataFloat(fltNumero: Double;
  intDecimais: Integer): Double;
begin
{$IFDEF LINUX}
  Result := Services.Core.Utils.fFormataFloat(fltNumero, intDecimais);
{$ELSE}
  Result := untFuncoesSimples.fFormataFloat(fltNumero, intDecimais);
{$ENDIF}
end;

function TAutcomTintaWrapper.fFormataFloatSky(fltValor: Double): Double;
begin
{$IFDEF LINUX}
  Result := untFuncEspecificas.fFormataFloatSky(fltValor);
{$ELSE}
  Result := untFuncEspecificas.fFormataFloatSky(fltValor);
{$ENDIF}
end;

function TAutcomTintaWrapper.fGetConfTinta(const strIdePro: String): IConfTinta;
begin
  Result := untTintaMaquina.fGetConfTinta(strIdePro);
end;

function TAutcomTintaWrapper.fGetDataSet: IDataSet;
begin
  Result := TUniQueryDataSetWrapper.Create as IDataSet;
end;

function TAutcomTintaWrapper.fGetDescricaoProdutoTinta(
  const strCodIte: string; Tipo: TTipoCadastro): string;
var
  qryGen: TUniQuery;
  LMsg: string;
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
        '   AND I.ITE_CODITE = :CODITE       ' +
        '   AND IFNULL(I.ITE_ITEATI,"N") = "S"   ' +
        '   AND I.ITE_DESITE NOT LIKE "%ITEM ESPECIAL%"     ';

      If Not fEmptyStr(fCfgSis('ITESER')) Then
        qryGen.SQL.Text := qryGen.SQL.Text + '  AND I.ITE_CODITE <> ' + QuotedStr(fCfgSis('ITESER'));

      If Not fEmptyStr(fCfgSis('SERTER')) Then
        qryGen.SQL.Text := qryGen.SQL.Text + '  AND I.ITE_CODITE <> ' + QuotedStr(fCfgSis('SERTER'));

      If Not fEmptyStr(fCfgSis('ITEFRE')) Then
        qryGen.SQL.Text := qryGen.SQL.Text + '  AND I.ITE_CODITE <> ' + QuotedStr(fCfgSis('ITEFRE'));

      If Not fEmptyStr(fCfgSis('ITEBOM')) Then
        qryGen.SQL.Text := qryGen.SQL.Text + '  AND I.ITE_CODITE <> ' + QuotedStr(fCfgSis('ITEBOM'));

      If Not fEmptyStr(fCfgSis('ITEENE')) Then
        qryGen.SQL.Text := qryGen.SQL.Text + '  AND I.ITE_CODITE <> ' + QuotedStr(fCfgSis('ITEENE'));

      If Not fEmptyStr(fCfgSis('ITEVID')) Then
        qryGen.SQL.Text := qryGen.SQL.Text + '  AND I.ITE_CODITE <> ' + QuotedStr(fCfgSis('ITEVID'));

      If Not fEmptyStr(fCfgSis('ITETAX')) Then
        qryGen.SQL.Text := qryGen.SQL.Text + '  AND I.ITE_CODITE <> ' + QuotedStr(fCfgSis('ITETAX'));

      If Not fEmptyStr(fCfgSis('PROMAT')) Then
        qryGen.SQL.Text := qryGen.SQL.Text + '  AND I.ITE_CODITE <> ' + QuotedStr(fCfgSis('PROMAT'));

      If Not fEmptyStr(fCfgSis('ITECON')) Then
        qryGen.SQL.Text := qryGen.SQL.Text + '  AND I.ITE_CODITE <> ' + QuotedStr(fCfgSis('ITECON'));

      If Tipo = ttBases then
        qryGen.SQL.Text := qryGen.SQL.Text + '   AND IFNULL(I.ITE_ITEBAS,"N") = "S"  '
      Else If Tipo = ttColorantes then
        qryGen.SQL.Text := qryGen.SQL.Text + '   AND IFNULL(I.ITE_ITEPIG,"N") = "S"  ';

      qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryGen.ParamByName('CODITE').AsString := strCodIte;

     {$IFDEF LINUX}
      Result := ExecutarQueryEmCache(qryGen).FieldByName('ITE_DESITE').AsString;
     {$ELSE}
      qryGen.Open;
      Result := qryGen.FieldByName('ITE_DESITE').AsString;
     {$ENDIF}
    Except
      on E: Exception do
      begin
        LMsg := E.Message;
       {$IFDEF LINUX}
        WriteError(LMsg);
       {$ENDIF}
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

function TAutcomTintaWrapper.fGetHostLock(strNomeTabela: String;
  blnSohIP: Boolean): String;
begin
{$IFDEF LINUX}
  Result := Services.Core.Task.Lock.fGetHostLock(strNomeTabela, blnSohIP);
{$ELSE}
  Result := untFuncoesSimples.fGetHostLock(strNomeTabela, blnSohIP);
{$ENDIF}
end;

{$IFNDEF LINUX}
function TAutcomTintaWrapper.fGetMenu(strTitulo: String;
  arrOpcoes: array of String; intOpcao: Integer; blnSaiComEsc,
  blnLibQtd: Boolean): Integer;
begin
  Result := untFuncoesSimples.fGetMenu(strTitulo, arrOpcoes, intOpcao, blnSaiComEsc, blnLibQtd);
end;
{$ENDIF}

function TAutcomTintaWrapper.fGravarLogLiberacaoBaseAutomotiva(
  var strOperadorLiberou: String; strCodBas, strMensagem: String): Boolean;
begin
  If (Not fEmptyStr(strOperadorLiberou)) Then
  Begin
    Result := True;
    Exit;
  End;

  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto(strMensagem);
  objLiberacao.objMsgLibera.pAddTextoCaption('Base', strCodBas);

  objLiberacao.strDirAce := 'BAQTZE';
  objLiberacao.strMsgSen := strMensagem;
  objLiberacao.blnMosMen := True;
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCodDig := strLoginUsuarioLogado;
  objLiberacao.blnUsarSenhaFixa := False;
  objLiberacao.blnSempreVariavelUsuario := True;

  Result := objLiberacao.fLibera;

  If Result Then
    strOperadorLiberou := objLiberacao.strOperador;
end;

function TAutcomTintaWrapper.fInsereProCod(const strNomTab: string; blnCodAut : Boolean = true): Boolean;
begin
{$IFDEF LINUX}
  Result := Services.Core.Connection.Manager.fInsereProCod(strNomTab, blnCodAut);
{$ELSE}
  Result := untFuncoesSimples.fInsereProCod(strNomTab, blnCodAut);
{$ENDIF}
end;

function TAutcomTintaWrapper.fIsNumber(const strNumber: String): Boolean;
begin
{$IFDEF LINUX}
  Result := Services.Core.Utils.fIsNumber(strNumber);
{$ELSE}
  Result := untFuncoesSimples.fIsNumber(strNumber);
{$ENDIF}
end;

function TAutcomTintaWrapper.fLock_Unlock(strNomeTabela: String; blnTrava,
  blnLoopTravamento, blnHourGlass: Boolean; strCon_Id: String;
  blnMostraMsgTravamento: Boolean; strOrigem: String): Boolean;
begin
{$IFDEF LINUX}
  Result := Services.Core.Task.Lock.fLock_Unlock(strNomeTabela,
                                                 blnTrava,
                                                 blnLoopTravamento,
                                                 strCon_Id,
                                                 strOrigem);
{$ELSE}
  Result := untFuncoesSimples.fLock_Unlock(strNomeTabela,
                                           blnTrava,
                                           blnLoopTravamento,
                                           blnHourGlass,
                                           strCon_Id,
                                           blnMostraMsgTravamento,
                                           strOrigem);
{$ENDIF}
end;

function TAutcomTintaWrapper.fMensagem(const strTitulo, strTexto: String; arrOpcoes: array of String; intFocoBotao: Integer;
  blnSaiComEsc: Boolean; intEstFon, intWidBut, intSomarTop: Integer): Integer;
var
  arrOpcoesNovo: array of string;
  intCont: Integer;
begin
  SetLength(arrOpcoesNovo, Length(arrOpcoes));
  for intCont := Low(arrOpcoes) to High(arrOpcoes) do
    arrOpcoesNovo[intCont] := arrOpcoes[intCont];
{$IFDEF LINUX}
  Result := Shared.Core.fMensagem(strTitulo, strTexto, arrOpcoesNovo, intFocoBotao);
{$ELSE}
  Result := untFuncoesSimples.fMensagem(strTitulo, strTexto, arrOpcoesNovo, intFocoBotao, blnSaiComEsc, intEstFon,
    intWidBut, False, intSomarTop, False, False, False, 0);
{$ENDIF}
end;

function TAutcomTintaWrapper.fMensagemTabela(strTitulo, strTitCol: String;
  arrMensagem: TStringArray; strTexto: String; arrOpcoes: array of String;
  intFocoBotao: Integer; blnSaiComEsc: Boolean; intEstFon, intWidBut: Integer;
  blnAutosize: Boolean; intSomarTop: Integer; blnObrigaEsc, blnOcultPainelBtn,
  blnBtnSemImg: Boolean; intHeightOpc: Integer; intHeightFrm: Integer;
  intWidthFrm: Integer; blnBtnOk: Boolean): Integer;
{$IFDEF LINUX}
var
  intPosicao: Integer;
begin
  If (Length(arrOpcoes) = 2)   And
     (Trim(arrOpcoes[0]) = '') And
     (Trim(arrOpcoes[1]) = '') Then
  Begin
    arrOpcoes[0] := '&Sim';
    arrOpcoes[1] := '&Não';
  End;

  WriteLog(StringOfChar('-', 100));
  WriteLog(strTitulo);
  WriteLog(StringOfChar('-', 100));
  WriteLog(strTexto);
  WriteLog(StringOfChar('-', 100));

  for intPosicao := 0 to Length( arrOpcoes )-1 do
    if Succ(intPosicao) = intFocoBotao then
      WriteLog('[   ] ' + strTexto)
    else
      WriteLog('[ X ] ' + strTexto);

  WriteLog(StringOfChar('-', 100));

  Result := intFocoBotao;
end;
{$ELSE}
Var
  intQtdOpcoes : Integer;
  intPosicao   : Integer;
  fntFonte     : TFont;
  frmMsgTbl    : TfrmMensagemTabela;
begin
  intQtdOpcoes   := 0;

  fntFonte       := TFont.Create;
  fntFonte.Name  := 'charter';
  fntFonte.Size  := 13;
  //fntFonte.Style := [fsBold];

  For intPosicao := 0 To Length( arrOpcoes )-1 Do
  Begin
    If arrOpcoes[intPosicao] <> '' Then
      Inc(intQtdOpcoes)
    Else
      Break;
  End;

  If (Length(arrOpcoes) = 2)   And
     (Trim(arrOpcoes[0]) = '') And
     (Trim(arrOpcoes[1]) = '') Then
  Begin
    arrOpcoes[0] := '&Sim';
    arrOpcoes[1] := '&Não';
    intQtdOpcoes := 2;
  End;

  If Trim(arrOpcoes[0]) = '' Then
  Begin
    MessageDlg('É obrigatório a passagem dos parametros em ordem!', mtInformation, [mbOK], 0);
    Result := 0;
    Exit;
  End;

  {********************************}
  {* -> Define Foco para Botao    *}
  {*****************************WI*}
  If ( intFocoBotao <= 0 )           Or
     ( intFocoBotao > intQtdOpcoes ) Then
    intFocoBotao := 1;

  Try

    pCriarFormularios(TfrmMensagemTabela, frmMsgTbl);

    With frmMsgTbl Do
    Begin
      If Assigned(arrMensagem) then
        arrMensag := arrMensagem;

      strDesCol := strTitCol;

      intSomaTop := intSomarTop;
      If (blnAutosize) Then
        WindowState := wsMaximized;

      If intHeightOpc <> 0 Then
        frmMsgTbl.Height := intHeightOpc;

      If ( (ParamCount = 1) And  SameText(ParamStr(1), 'EXPEDICAO_MOTOROLA') ) Then
        blnAutosize := True;
        //intWidBut := 90;

      If strTitulo = '' Then
        strTitulo := 'AVISO';

      If intEstFon = 2 Then
        lblMensagem.Font.Name := 'Courier New';

      lblTitulo.Caption   := strTitulo;
      lblMensagem.Caption := strTexto;


      If intWidthFrm = 0 Then
        Width := 1160
      Else
        Width := intWidthFrm;

      If intHeightFrm = 0 Then
        Height := 400
      Else
        Height := intHeightFrm;


      lsvTabela.Columns[0].Width := 1135;

      If blnBtnOk Then
      Begin
        With TBitBtnLocked.Create(frmMsgTbl) Do
        Begin
          Parent := pnlBotoes;

          Left := 1;
          Top  := 05;
          Height := 28;

          If intWidBut = 0 Then
            Width      := 126
          Else
            Width      := intWidBut;

          Font       := fntFonte;
          Caption    := arrOpcoes[0];
          Tag        := 1;
          If not blnBtnSemImg Then
            Glyph      := imgbotao1.Picture.Bitmap;
          OnClick    := frmMsgTbl.pOnclick;

        End;
      End
      Else If intQtdOpcoes = 1 Then
      Begin
        With TBitBtnLocked.Create(frmMsgTbl) Do
        Begin
          parent     := pnlBotoes;

          If blnAutosize Then
          Begin
            Left  := (Screen.Width - 126) Div 2
          End Else
          Begin
            If intWidBut <> 0 Then
              Left       := 156 - ((intWidBut - 156) Div 2)
            Else
              Left       := 156;
          End;

          Top        := 05;
          Height     := 28;

          If intWidBut = 0 Then
            Width      := 126
          Else
            Width      := intWidBut;

          Font       := fntFonte;
          Caption    := arrOpcoes[0];
          Tag        := 1;
          If not blnBtnSemImg Then
            Glyph      := imgbotao1.Picture.Bitmap;
          OnClick    := frmMsgTbl.pOnclick;
        End;
      End
      Else If intQtdOpcoes = 2 Then
      Begin
        With TBitBtnLocked.Create(frmMsgTbl) Do
        Begin
          parent     := pnlBotoes;

          If blnAutosize Then
          Begin
            Left  := ((Screen.Width - 2*130) Div 2);
          End Else
          Begin
            If intWidBut <> 0 Then
              Left       := 90 - (intWidBut - 130)
            Else
              Left       := 425;
          End;

          Top        := 05;
          Height     := 28;

          If intWidBut = 0 Then
            Width      := 130
          Else
            Width      := intWidBut;

          Font       := fntFonte;
          Caption    := arrOpcoes[0];
          Tag        := 1;
          If not blnBtnSemImg Then
            Glyph      := imgbotao1.Picture.Bitmap;
          OnClick    := frmMsgTbl.pOnclick;
        End;
        With TBitBtnLocked.Create(frmMsgTbl) Do
        Begin
          parent     := pnlBotoes;

          If blnAutosize Then
          Begin

            Left  := ((Screen.Width - 2*126) Div 2) + 126 + 7;

          End Else
          Begin
            Left       := 557;
          End;

          Top        := 05;
          Height     := 28;

          If intWidBut = 0 Then
            Width      := 130
          Else
            Width      := intWidBut;

          Font       := fntFonte;
          Caption    := arrOpcoes[1];
          Tag        := 2;
          If not blnBtnSemImg Then
            Glyph      := imgbotao2.Picture.Bitmap;
          OnClick    := frmMsgTbl.pOnclick;
        End;
      End
      Else If intQtdOpcoes = 3 Then
      Begin
        frmMsgTbl.Width := 494;
        With TBitBtnLocked.Create(frmMsgTbl) Do
        Begin
          parent     := pnlBotoes;
          Left       := 18;
          Top        := 05;
          Height     := 28;
          Width      := 146;
          Font       := fntFonte;
          Caption    := arrOpcoes[0];
          Tag        := 1;
          If not blnBtnSemImg Then
            Glyph      := imgbotao1.Picture.Bitmap;
          OnClick    := frmMsgTbl.pOnclick;
        End;
        With TBitBtnLocked.Create(frmMsgTbl) Do
        Begin
          parent     := pnlBotoes;
          Left       := 166;
          Top        := 05;
          Height     := 28;
          Width      := 146;
          Font       := fntFonte;
          Caption    := arrOpcoes[1];
          Tag        := 2;
          If not blnBtnSemImg Then
            Glyph      := imgbotao2.Picture.Bitmap;
          OnClick    := frmMsgTbl.pOnclick;
        End;
        With TBitBtnLocked.Create(frmMsgTbl) Do
        Begin
          parent     := pnlBotoes;
          Left       := 314;
          Top        := 05;
          Height     := 28;
          Width      := 146;
          Font       := fntFonte;
          Caption    := arrOpcoes[2];
          Tag        := 3;
          If not blnBtnSemImg Then
            Glyph      := imgbotao3.Picture.Bitmap;
          OnClick    := frmMsgTbl.pOnclick;
        End;
      End;
    End;

    frmMsgTbl.intFocus     := intFocoBotao;
    frmMsgTbl.blnSaiComEsc := blnSaiComEsc;
    frmMsgTbl.blnObrigaEsc := blnObrigaEsc;
    frmMsgTbl.blnOcultPainelBtn := blnOcultPainelBtn;

   frmMsgTbl.ShowModal;
   Result := frmMsgTbl.intRetorno;
  Except
    On E: Exception Do
    Begin
      Result := 0;
      pMensagensErro(E.Message, '[fMensagemTabela]');
    End;
  End;

  pFreeAndNil(frmMsgTbl);
  FreeAndNil(fntFonte);
end;
{$ENDIF}

{$IFNDEF LINUX}
function TAutcomTintaWrapper.fNow: TDateTime;
begin
  Result := untFuncoesSimples.fNow();
end;
{$ENDIF}


function TAutcomTintaWrapper.fRemoveAcento(Str: String): String;
begin
{$IFDEF LINUX}
  Result := Services.Core.Utils.fRemoveAcento(Str);
{$ELSE}
  Result := untFuncoesSimples.fRemoveAcento(Str);
{$ENDIF}
end;

function TAutcomTintaWrapper.fRetAutoIncrem(const strNomeTabela, strCodEmp: string): string;
begin
{$IFDEF LINUX}
  Result := Services.Core.Connection.Manager.fRetAutoIncrem(strNomeTabela, strCodEmp);
{$ELSE}
  Result := untFuncoesSimples.fRetAutoIncrem(strNomeTabela, strCodEmp);
{$ENDIF}
end;

function TAutcomTintaWrapper.fRetGrupoItem(strCodIte: String): String;
begin
{$IFDEF LINUX}
  Result := Services.Core.Connection.Manager.fRetGrupoItem(strCodIte);
{$ELSE}
  Result := untFuncoesSimples.fRetGrupoItem(strCodIte);
{$ENDIF}
end;

{$IFNDEF LINUX}
function TAutcomTintaWrapper.fRetirarEspacos(Sender: TObject): String;
begin
  Result := untFuncoesSimples.fRetirarEspacos(Sender);
end;
{$ENDIF}

function TAutcomTintaWrapper.fRetNomProduto(const strCodIte: String): String;
begin
{$IFDEF LINUX}
  Result := Services.Core.Connection.Manager.fRetNomProduto(strCodIte);
{$ELSE}
  Result := untFuncoesSimples.fRetNomProduto(strCodIte);
{$ENDIF}
end;

function TAutcomTintaWrapper.fRetornaTipoDoCampo(strTabela, strCampo: string): String;
begin
{$IFDEF LINUX}
  Result := Services.Core.Connection.Manager.fRetornaTipoDoCampo(strTabela, strCampo);
{$ELSE}
  Result := untFuncoesSimples.fRetornaTipoDoCampo(strTabela, strCampo);
{$ENDIF}
end;

function TAutcomTintaWrapper.fStrToFloat(strValorUnico: String): Double;
begin
{$IFDEF LINUX}
  Result := Services.Core.Utils.fStrToFloat(strValorUnico);
{$ELSE}
  Result := untFuncoesSimples.fStrToFloat(strValorUnico);
{$ENDIF}
end;

function TAutcomTintaWrapper.fTabelaExiste(strNomeTabela: String;
  Conexao: TUniConnection): Boolean;
begin
{$IFDEF LINUX}
  Result := Services.Core.Connection.Manager.fTabelaExiste(strNomeTabela);
{$ELSE}
  Result := untFuncoesSimples.fTabelaExiste(strNomeTabela, False, Conexao);
{$ENDIF}
end;

function TAutcomTintaWrapper.fTamCodIte: Integer;
begin
{$IFDEF LINUX}
  Result := Services.Core.Connection.Manager.fTamCodIte;
{$ELSE}
  Result := untFuncoesSimples.fTamCodIte;
{$ENDIF}
end;

function TAutcomTintaWrapper.fTiraCaracEspeciaisPonto(strTexto: String): String;
begin
{$IFDEF LINUX}
  Result := Services.Core.Utils.fTiraCaracEspeciaisPonto(strTexto);
{$ELSE}
  Result := untFuncoesSimples.fTiraCaracEspeciaisPonto(strTexto);
{$ENDIF}
end;

function TAutcomTintaWrapper.fSenderName(Const strName: String): String;
begin
  strNomeForm  := strName;
  Result       := strNomeForm;
end;

function TAutcomTintaWrapper.fSQLSaldoDisponivel(const AAlias: String;
  AFaturamento, ALote: Boolean): string;
begin
{$IFDEF LINUX}
  Result := untFuncEspecificas.fSQLSaldoDisponivel(AAlias, AFaturamento, ALote);
{$ELSE}
  Result := untFuncoesSimples.fSQLSaldoDisponivel(AAlias, AFaturamento, ALote);
{$ENDIF}
end;

function TAutcomTintaWrapper.fSQLSaldoFisico: String;
begin
  If Not (fCfgSis('BEFTRG', VarBoolean)) Or (fUsaQtdPendenteEntregaFutura(True)) Then
    Result := 'IFNULL(ITEGER.ITE_SALDOS, 0) + ' +
              'IFNULL(ITEGER.ITE_SAL_ML, 0) / ' +
              'IF(IFNULL(ITE_CNV_ML, 0) <= 0, 1, ITE_CNV_ML) + ' +
              'IFNULL(ITEGER.ITE_QTPDBF, 0) + ' +
              'IFNULL(ITEGER.ITE_QTEF_F, 0) + ' +
              'IFNULL(ITEGER.ITE_QTEF_A, 0) + ' +
              'IFNULL(ITEGER.ITE_QTEF_P, 0) '
  Else
    Result := 'IFNULL(ITEGER.ITE_SALDOS, 0) + ' +
              'IFNULL(ITEGER.ITE_SAL_ML, 0) / ' +
              'IF(IFNULL(ITE_CNV_ML, 0) <= 0, 1, ITE_CNV_ML) ';
end;

function TAutcomTintaWrapper.fUsaProCodigo(strNomeTabela: string): Boolean;
begin
{$IFDEF LINUX}
  Result := Services.Core.Connection.Manager.fUsaProCodigo(strNomeTabela);
{$ELSE}
  Result := untFuncoesSimples.fUsaProCodigo(strNomeTabela);
{$ENDIF}
end;

function TAutcomTintaWrapper.fUsaQtdPendenteEntregaFutura(
  blnConsiderarCfgCalSal: Boolean; strEmpSalRes: String): Boolean;
begin
{$IFDEF LINUX}
  Result := Services.Core.Settings.fUsaQtdPendenteEntregaFutura(blnConsiderarCfgCalSal, strEmpSalRes);
{$ELSE}
  Result := untFuncoesSimples.fUsaQtdPendenteEntregaFutura(blnConsiderarCfgCalSal, strEmpSalRes);
{$ENDIF}
end;

function TAutcomTintaWrapper.fValidarBaseItemAmarracao(strIdePro, strCodBaseAtu,
strDescBaseAtu, strCodIte, strCoditeAnt: String; fltPesEsp,fltEmbala: Double): Boolean;
  Var
    ObjValidarBaseItemAmarracao : TValidarBaseItemAmarracao;
begin
  ObjValidarBaseItemAmarracao := TValidarBaseItemAmarracao.Create;

  Result := ObjValidarBaseItemAmarracao.fValidarBaseItemAmarracao(strIdePro,
                                                                  strCodBaseAtu,
                                                                  strDescBaseAtu,
                                                                  strCodIte,
                                                                  strCoditeAnt,
                                                                  fltPesEsp,
                                                                  fltEmbala);
  If Assigned(ObjValidarBaseItemAmarracao)Then
    FreeAndNil(ObjValidarBaseItemAmarracao);
end;

function TAutcomTintaWrapper.fVerificaAcessoSistema(strNomeForm,
  strCodOpe: String): Boolean;
begin
{$IFDEF LINUX}
  Result := Services.Core.Settings.fVerificaAcessoSistema(strNomeForm, strCodOpe);
{$ELSE}
  Result := untFuncoesSimples.fVerificaAcessoSistema(strNomeForm, strCodOpe);
{$ENDIF}
end;

function TAutcomTintaWrapper.GetCodEmp: String;
begin
{$IFDEF LINUX}
  Result := Services.Core.Settings.VS_strCodEmp;
{$ELSE}
  Result := untFuncoesSimples.VS_strCodEmp;
{$ENDIF}
end;

function TAutcomTintaWrapper.GetDicionario: IDicionario;
begin
  Result := TDicionarioWrapper.Create();
end;

function TAutcomTintaWrapper.GetEmpBasDu2: Boolean;
begin
{$IFDEF LINUX}
  Result := untFuncEspecificas.VS_blnCodEmpBasDu2;
{$ELSE}
  Result := untFuncoesSimples.VS_blnCodEmpBasDu2;
{$ENDIF}
end;

function TAutcomTintaWrapper.GetEmpBasDup: Boolean;
begin
{$IFDEF LINUX}
  Result := untFuncEspecificas.VS_blnCodEmpBasDup;
{$ELSE}
  Result := untFuncoesSimples.VS_blnCodEmpBasDup;
{$ENDIF}
end;

function TAutcomTintaWrapper.GetEmpBasDux: Boolean;
begin
{$IFDEF LINUX}
  Result := untFuncEspecificas.VS_blnCodEmpBasDux;
{$ELSE}
  Result := untFuncoesSimples.VS_blnCodEmpBasDux;
{$ENDIF}
end;

function TAutcomTintaWrapper.GetIConsultaTinta(const tintadeMaquinaWrapper: ITintadeMaquinaWrapper): IConsultaTinta;
begin
  Result := TTintadeMaquinaWrapper.Create(tintadeMaquinaWrapper);
end;

function TAutcomTintaWrapper.GetInsert(const strTabela: string): string;
begin
  Result := TDDLFactory.GetInsert(strTabela);
end;

function TAutcomTintaWrapper.GetInsertDelayed(const strTabela: string): string;
begin
  Result := TDDLFactory.GetInsertDelayed(strTabela);
end;

function TAutcomTintaWrapper.GetInToOr(const strNomeCampo,
  strValores: string): string;
begin
{$IFDEF LINUX}
  Result := untFuncoesGenerica.GetInToOr(strNomeCampo, strValores);
{$ELSE}
  Result := untFuncoesSimples.GetInToOr(strNomeCampo, strValores);
{$ENDIF}
end;

{$IFNDEF LINUX}
function TAutcomTintaWrapper.GetObjTraceViewer: ITraceViewer;
begin
  Result := untFuncoesSimples.VS_objTraceViewer;
end;
{$ENDIF}

{$IFNDEF LINUX}
function TAutcomTintaWrapper.GetTituloVersao: String;
begin
  Result := TVersaoExecutavel.GetTituloVersao;
end;
{$ENDIF}

function TAutcomTintaWrapper.GetUsuarioLogado: string;
begin
  Result := strLoginUsuarioLogado;
end;

function TAutcomTintaWrapper.GetUsuarioUtilizaTemaClassico: Boolean;
begin
{$IFDEF LINUX}
  Result := True;
{$ELSE}
  Result := blnUsuarioLogadoUtilizaModoClassico;
{$ENDIF}
end;

function TAutcomTintaWrapper.GetValorCampo(const strSql,
  strNomeCampo: string; const arrParametros: array of string;
  blnUsaCache: Boolean = False): Variant;
var
  qryGen: TUniQuery;
  intCont: Integer;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text := strSql;

      for intCont := 0 to Length(arrParametros) - 1 do
      begin
        qryGen.Params[intCont].Value := arrParametros[intCont];
      end;

     {$IFDEF LINUX}
      if blnUsaCache then
        Result := ExecutarQueryEmCache(qryGen).FieldByName(strNomeCampo).Value
      else
     {$ENDIF}
      begin
        qryGen.Open;
        Result := qryGen.FieldByName(strNomeCampo).Value;
      end;
    Except
      on E: Exception do
      begin
       {$IFDEF LINUX}
        WriteError(E.Message);
       {$ENDIF}
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;                            
end;

function TAutcomTintaWrapper.IIF(lTest: Boolean; vExpr1,
  vExpr2: Variant): Variant;
begin
{$IFDEF LINUX}
  Result := Services.Core.Utils.IIF(lTest, vExpr1, vExpr2);
{$ELSE}
  Result := untFuncoesSimples.IIF(lTest, vExpr1, vExpr2);
{$ENDIF}
end;

procedure TAutcomTintaWrapper.pAddDados(var arrAdd: TStringArray;
  strTexto: String; blnConsiderarEnter: Boolean);
begin
{$IFDEF LINUX}
  Services.Core.Utils.pAddDados(arrAdd, strTexto, blnConsiderarEnter);
{$ELSE}
  untFuncoesSimples.pAddDados(arrAdd, strTexto, blnConsiderarEnter);
{$ENDIF}
end;

procedure TAutcomTintaWrapper.pAddDados(var arrAdd, arrHin: TStringArray;
  strTexto, strHint: String; blnConsiderarEnter: Boolean);
begin
{$IFDEF LINUX}
  Services.Core.Utils.pAddDados(arrAdd, arrHin, strTexto, strHint, blnConsiderarEnter);
{$ELSE}
  untFuncoesSimples.pAddDados(arrAdd, arrHin, strTexto, strHint, blnConsiderarEnter);
{$ENDIF}
end;

procedure TAutcomTintaWrapper.pAjudaAutcom(const Handle: THandle; const intNumHlp: Integer);
begin
{$IFNDEF LINUX}
  untFuncoesSimples.pAjudaAutcom(Handle, intNumHlp);
{$ENDIF}
end;

function TAutcomTintaWrapper.fPadC(strTexto: String; intTamanho: Integer;
  strCaracter: String): String;
begin
{$IFDEF LINUX}
  Result := Services.Core.Utils.fPadC(strTexto, intTamanho, strCaracter);
{$ELSE}
  Result := untFuncoesSimples.fPadC(strTexto, intTamanho, strCaracter);
{$ENDIF}
end;

function TAutcomTintaWrapper.fPadL(strTexto: String; intTamanho: Integer;
  strCaracter: String): String;
begin
{$IFDEF LINUX}
  Result := Services.Core.Utils.fPadL(strTexto, intTamanho, strCaracter);
{$ELSE}
  Result := untFuncoesSimples.fPadL(strTexto, intTamanho, strCaracter);
{$ENDIF}
end;

function TAutcomTintaWrapper.fPadR(strTexto: String; intTamanhoMin,
  intTamanhoMax: Integer; strCaracter: String): String;
begin
{$IFDEF LINUX}
  Result := Services.Core.Utils.fPadR(strTexto, intTamanhoMin, intTamanhoMax, strCaracter);
{$ELSE}
  Result := untFuncoesSimples.fPadR(strTexto, intTamanhoMin, intTamanhoMax, strCaracter);
{$ENDIF}
end;

function TAutcomTintaWrapper.fPadR(strTexto: String; intTamanho: Integer;
  strCaracter: String): String;
begin
{$IFDEF LINUX}
  Result := Services.Core.Utils.fPadR(strTexto, intTamanho, strCaracter);
{$ELSE}
  Result := untFuncoesSimples.fPadR(strTexto, intTamanho, strCaracter);
{$ENDIF}
end;

{$IFNDEF LINUX}
function TAutcomTintaWrapper.fPesqGenericaTinta(var qryTabela: IDataSet;
                                strTabela: string;
                                strNomForm: string = '';
                                strTitulo: string = '';
                                strCamposRelacionado: string = '';
                                strFiltros: string = '';
                                blnComProdutos: boolean = True): boolean;
var
  qryGen: TUniQuery;
  frmSender: TForm;
  arrSel: TConsultasArray;
  Key: char;
begin
  key := '/';
  Result := False;
  frmSender := nil;
  Try
    Try
      qryGen := fCriaQuery();
      frmSender := TForm.Create(nil);

      if (fSenderName(strNomForm) = '') then
        frmSender.Name := 'TAutcomTintaWrapperpConsultaComp'
      else
        frmSender.Name := fSenderName(strNomForm);

      Result := untConsultas.fPesqGenericaTinta(frmSender,
                                                strTabela,
                                                qryGen,
                                                Key,
                                                arrSel,
                                                True,
                                                strCamposRelacionado,
                                                strFiltros,
                                                blnComProdutos);
      if Result then
        qryTabela := TUniQueryDataSetWrapper.Create(qryGen, True)
    Except
      on E: Exception do
      begin
       {$IFDEF LINUX}
        WriteError(E.Message);
       {$ENDIF}
        raise;
      end;
    End;
  Finally
    if Assigned(frmSender) then FreeAndNil(frmSender);
  End;

end;
{$ENDIF}

{$IFNDEF LINUX}
function TAutcomTintaWrapper.pConsultaComp(arrSql,
                                           arrCampos,
                                           arrOrdenacao: Array Of String;
                                           strCampoChave,
                                           strTabela,
                                           strNomForm,
                                           strTitulo: String;
                                           var qryTabela: IDataSet;
                                           arrSubConsultas,
                                           arrSubConsultasCampos: array of String;
                                           blnComSaldo: Boolean = False): boolean;

var
  qryGen: TUniQuery;
  frmSender: TForm;
  arrSel: TConsultasArray;
  objConsulta: TDefConsulta;
  i: integer;
begin
  Result := False;
  frmSender := nil;
  objConsulta := TDefConsulta.Create;
  Try
    Try
      qryGen := fCriaQuery();
      frmSender := TForm.Create(nil);

      if (fSenderName(strNomForm) = '') then
        frmSender.Name := 'TAutcomTintaWrapperpConsultaComp'
      else
        frmSender.Name := fSenderName(strNomForm);

      For i := 0 To High(arrSubConsultas) Do
      Begin
        objConsulta.pIncluiSubConsulta(arrSubConsultasCampos[i], arrSubConsultas[i]);
      End;

       if strTitulo = 'Consulta Item' Then
         objConsulta.pIncluiConflito('ITE_CODITE', 'I.ITE_CODITE');

       If strTitulo = 'Consulta -  Item Base' Then
         objConsulta.pIncluiConflito('ITE_CODITE', 'CADITE.ITE_CODITE');

      If blnComSaldo Then
      Begin
        objConsulta.pIncluiSubConsulta('ITE_COMSAL', 'IF(ITEGER.ITE_SALDOS > 0, "SIM", "NÃO")');
        objConsulta.pIncluiCampoSimNao('ITE_COMSAL', ['SIM', 'NÃO', 'TODOS']);
      End;

      Result := untFuncoesSimples.fConsulta(arrSql,
                                           arrCampos,
                                           arrOrdenacao,
                                           strCampoChave,
                                           strTabela,
                                           strNomForm,
                                           strTitulo,
                                           qryGen,
                                           Nil,
                                           True,
                                           arrSel,
                                           'AUTOINCREM',
                                           objConsulta, False, False, '', nil, False);
      if Result then
        qryTabela := TUniQueryDataSetWrapper.Create(qryGen, True)
    Except
      on E: Exception do
      begin
       {$IFDEF LINUX}
        WriteError(E.Message);
       {$ENDIF}
        raise;
      end;
    End;
  Finally
    if Assigned(frmSender) then FreeAndNil(frmSender);
    freeAndNil(objConsulta);
  End;
end;
{$ENDIF}

procedure TAutcomTintaWrapper.pGravarErro(const GravarErro: Boolean; const MensagemErro: String);
begin
{$IFDEF LINUX}
  Services.Core.Connection.Manager.pGravarErro(GravarErro, MensagemErro);
{$ELSE}
  untFuncoesSimples.pGravarErro(GravarErro, MensagemErro);
{$ENDIF}
end;

procedure TAutcomTintaWrapper.pMensagensErro(const MensErro, LocalErro, strMensagem: String);
begin
{$IFDEF LINUX}
  Shared.Core.pMensagensErro(MensErro + ' ' + strMensagem, LocalErro);
{$ELSE}
  untFuncoesSimples.pMensagensErro(MensErro, LocalErro, strMensagem);
{$ENDIF}
end;

{$IFDEF LINUX}
procedure TAutcomTintaWrapper.WriteError(AText: string);
begin
  Services.Core.Utils.WriteError(AText);
end;

procedure TAutcomTintaWrapper.WriteLog(AText: string);
begin
  Services.Core.Utils.WriteLog(AText);
end;
{$ENDIF}

procedure TAutcomTintaWrapper.pValidaProCod(strNomeTabela: string);
begin
{$IFDEF LINUX}
  //do nothing
{$ELSE}
  untFuncoesSimples.pValidaProCod(strNomeTabela);
{$ENDIF}
end;

procedure TAutcomTintaWrapper.TruncateTable(const strNomeTabela: string);
begin
  fExecutaSQL('TRUNCATE ' + strNomeTabela);
end;
function TAutcomTintaWrapper.fZerarCNV_ML(strCodite, strIdePro: string): Boolean;

  function fRetornaIdeProPrefixoTabela(strPrefixo: String): String;
  begin
    Result := strPrefixo;

    If strPrefixo = 'CORIMO' Then
      Result := 'CIM'
    Else If strPrefixo = 'WANPRO' Then
      Result := 'WCP';

  end;

var
  qryGen : TUniQuery;
begin
  qryGen := fCriaQuery();

  Try
    Try
      qryGen.SQL.Clear;
      qryGen.Close;


      If (fTipoTinta(fRetornaIdeProPrefixoTabela(strIdePro)) = ttAutomotiva) Then
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

procedure TAutcomTintaWrapper.pPreencherValorVenda(strCodIte : String; strCodEmp : String;
var strVlrCusto, strValorMargem, strValorVenda: String);
Var
  qryGen : TUniQuery;
begin
  qryGen := fCriaQuery();


  qryGen := fCriaQuery();

  Try
    qryGen.SQL.Text :=  ' SELECT ITE_PRECUS '+
                        '      , ITE_PREVE1 '+
                        '      , ITE_MARBR1 '+
                        '   FROM ITEGER '+
                        '  WHERE ITE_CODITE =:CODITE '+
                        '    AND ITE_CODEMP =:CODEMP ';

    qryGen.ParamByName('CODITE').AsString := strCodIte;
    qryGen.ParamByName('CODEMP').AsString := strCodEmp;

    qryGen.Open;

    strVlrCusto    := qryGen.FieldByName('ITE_PRECUS').AsString;
    strValorVenda  := qryGen.FieldByName('ITE_PREVE1').AsString;
    strValorMargem := qryGen.FieldByName('ITE_MARBR1').AsString;

  Finally
    FreeAndNil(qryGen);
  End;

end;


procedure TAutcomTintaWrapper.pEnviarLogRep(strCodite : string; strIdePro : string);
Var
  strSQL   : String;
begin
  strSQL := '';

  If fZerarCnv_Ml(strCodite, strIdePro) then
  Begin
    strSQL := 'UPDATE CADITE '+
              '   SET ITE_CNV_ML = 0 '+
              ' WHERE ITE_CODITE = :CODITE' ;

    objExeSQLRepTinta.pExecutaSQL(strSQL, ['CODITE'],[strCodite]);
  end;

End;

procedure TAutcomTintaWrapper.pReplicarFatorTintometrico(strSQL: String; strCodite : String);
begin
  objExeSQLRepTinta.pExecutaSQL(strSQL, ['CODITE'],[strCodite]);
end;

{$IFNDEF LINUX}
procedure TAutcomTintaWrapper.pSetaCodIte(edtCodIte: TEditFocus);
begin
  untFuncoesSimples.pSetaCodIte(edtCodIte);
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TAutcomTintaWrapper.pSetaCodIte(edtCodIte: TStringField);
begin
  untFuncoesSimples.pSetaCodIte(edtCodIte);
end;
{$ENDIF}

procedure TAutcomTintaWrapper.pSetaEmpresaLogadaTinta(strEmpLog: String);
begin
  pSetaEmpresaLogada(strEmpLog);
end;

{$IFNDEF LINUX}
procedure TAutcomTintaWrapper.pSetFocus(SenderUnico: TWinControl;
  Form: TCustomForm);
begin
  untFuncoesSimples.pSetFocus(SenderUnico, Form);
end;
{$ENDIF}

procedure TAutcomTintaWrapper.pTrimAppMemorySize;
begin
{$IFNDEF LINUX}
  untFuncoesSimples.pTrimAppMemorySize();
{$ENDIF}
end;

{$IFNDEF LINUX}
procedure TAutcomTintaWrapper.pSetaCodIte(edtCodIte: TDBEditFocus);
begin
  untFuncoesSimples.pSetaCodIte(edtCodIte);
end;
{$ENDIF}

end.


