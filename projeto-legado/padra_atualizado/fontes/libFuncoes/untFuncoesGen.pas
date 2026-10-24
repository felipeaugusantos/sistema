unit untFuncoesGen;

interface
{$WARN SYMBOL_PLATFORM OFF}

Uses Uni, DB, Classes, StrUtils, Forms, SysUtils, Controls, Graphics, Dialogs, Winapi.Messages,
  Buttons, Variants, Windows, dxCore, ExtCtrls, untClassPanelCx, IniFiles, Winapi.PSApi,
  MadExcept, BitBtnLockedIncrem, Themes, dxThemeManager, UniClientDataSet, Types,
  MySqlUniProvider, untTypesSistema, UniSQLMonitor, DASQLMonitor, DateUtils,
  cxProgressBar, stdCtrls, untConstantes, untConsultaCxGridNova, Winapi.ShellAPI,
  cxGrid, cxGridDBTableView, cxGridDBBandedTableView, DBAccess, CRAccess, untICfgSis;

type
  TfrmConsultaCxGridNovaAutcom = class(TfrmConsultaCxGridNova);

  TFinalizarAutcomMonitor = class(TThread)
  private
    class var FInstance: TFinalizarAutcomMonitor;
  private
    const FTimeout = 60;
  private
    FBegin: TDateTime;
    FPID: Integer;
    FRunning: Boolean;
  protected
    procedure Execute; override;
  public
    constructor Create(APID: Integer);
    destructor Destroy; override;

    class procedure Monitorar;
    class procedure Parar;
  end;

CONST
    ERR_UNKNOW_ERROR    = 0000000;
    ERR_UNKNOW_DATABASE = 0000001;
    ERR_ACCESS_DENIED   = 0000002;
    ERR_TABLE_NOT_EXIST = 0000003;
    ERR_FIELD_NOT_FOUND = 0000004;
    ERR_TABLE_READONLY  = 0000005;
    ERR_NOT_VALID_INT   = 0000006;
    ERR_NOT_VALID_DATE  = 0000007;
    ERR_NOT_VALID_FLOAT = 0000008;
    ERR_NOT_IN_EDIT     = 0000009; //Not in EDIT or INSERT mode
    ERR_SQL_SYNTAX      = 0000010;
    ERR_BD_NOT_ACTIVE   = 0000011;
    ERR_FIELD_NOT_NULL  = 0000012;
    ERR_PRIMARY_KEY     = 0000013;
    ERR_ORDER_BY        = 0000014;
    ERR_DEFAULT_PRINTER = 0000015;
    ERR_FIELD_UNKNOWN   = 0000016;
    ERROR_FOREIGN_KEY_DELETE = 1217;

  procedure dxInitializeFuncoes; StdCall;
  procedure dxFinalizeFuncoes; StdCall;
  procedure pErro(strMensagem: String);

  procedure pIniciaDllFuncoes(Conexao: TUniConnection;
                              strUsuario,
                              strEmpresa: String;
                              intDebugH: Byte;
                              objFuncoes: ICfgSis;
                              objTraceViewer: ITraceViewer;
                              dtaDate: TDate;
                              strComputerNetName,
                              strUserFromWindows,
                              strIPAddressAsString,
                              strMacAddress: String); StdCall;

  procedure pReassignConexaoLibFuncoes(const AConexao: TUniConnection); StdCall;

  procedure pCriarFormularios(Classe: TComponentClass; Var frmForm); StdCall;

  procedure pBrowserNavigate(strURL: String);

  procedure pStepStatusGravacao(pgbStatus: TcxProgressBar; strInformacao: String='');

  procedure pFreeAndNil(Var frmForm); StdCall;
  procedure pRetornaPrecos(Const strCodIte: String; Var fltPreCus, fltMargem, fltPreVen: Double); StdCall;
  procedure pSetaClient(cdsClient: TDataSet); StdCall;
  procedure pSetFocus(SenderUnico: TWinControl; Form: TCustomForm = nil); StdCall;

  Function fStartTransactionGen: Boolean;
  function fCommitGen:Boolean;
  Function fRollBackGen: Boolean;
  function fConexaoAtivaGen(): Boolean; stdcall;
  function fInTransactionGen(objConexao: TUniConnection = Nil): Boolean; stdcall;

  function fCriaQuery(AOwner: TComponent): TUniQuery; StdCall;
  function fCriarQuery(strSQL: String; blnDeixarAberto: Boolean = False; AOwner: TComponent = nil): TUniQuery; StdCall;
  function fFormataFloat(fltNumero: Double; intDecimais: Integer): Double; StdCall;
  function fStrToFloat(strValor: String): Double; StdCall;
  function fEmptyStr(strString : String) : Boolean; StdCall;
  function fStrZero(Zeros: string; Quant: Integer): String; StdCall;
  function fSVN_RevisionFuncoes: String; stdcall;
  procedure pSetForegroundWindowsConsulta; StdCall;

  Procedure pDisableControls(dtsDataSet: TDataSet; Var prcScroll: TprcScroll);
  Procedure pEnableControls(dtsDataSet: TDataSet; Var prcScroll: TprcScroll; blnRefresh: Boolean = False);
  Procedure pCloneDataSet(dtsDestino, dtsOrigem: TUniClientDataSet; blnComFomatacao: Boolean = False);

  function fGetGridRowScreenPosition(Grid: TcxGrid; View: TcxGridDBTableView): TRect; overload;
  function fGetGridRowScreenPosition(Grid: TcxGrid; View: TcxGridDBBandedTableView): TRect; overload;

  function fCommaText(stlListSelecao: TStringList; blnQuoted: Boolean = False; strSeparator : String = ', '): String;

  function fConsulta(arrSql,
                     arrCampos,
                     arrOrdenacao: Array Of String;
                     strCampoChave,
                     strTabela,
                     strNomForm,
                     strTitulo: String;
                     qryAux: TUniQuery;
                     objFrmPnl: TPanelCx;
                     blnSimples: Boolean;
                     Var arrSelec: TConsultasArray;
                     strCodBusca: String = 'AUTOINCREM';
                     objConsulta: Pointer = Nil;
                     blnTablet: Boolean = False;
                     blnConIte: Boolean = False;
                     strCampoChave2: String = '';
                     pAfterAtualiza: TGenericProcedureWithClientParam = Nil;
                     blnRefresh: boolean = True;
                     blnConfirma: boolean = True;
                     blnConCon: Boolean = True;
                     fChamaCadastro : TBooleanFunctionWithBooleanParam = Nil;
                     objPnlBanner: TPanelCx = Nil;
                     objPnlPreFiltro: TPanelCx = Nil;
                     _Application : TApplication = Nil;
                     pBeforeAtualiza: TGenericProcedureWithClientParamAndVar = Nil): Boolean; StdCall;

  function fMensagem(strTitulo, strTexto: String; arrOpcoes: Array Of String; intFocoBotao: Integer = 1; blnSaiComEsc: Boolean = False; intEstFon: Integer = 1; intWidBut: Integer = 0): Integer; StdCall;
  function fRetAutoIncrem(strNomeTabela, strCodEmp: String): String; StdCall;
  function fFormataAutInc(intAutInc: Integer; strCodEmp: String; strProEmp: String = ''): String; StdCall;
  function fRetPrecisaoMargemItem: Integer;

  function fCalculaPrecoVenda(intOpcPrecoMargem: Integer;
                              curPrecus: Currency;
                              curPreven: Currency;
                              curMarBru: Double;
                              curIcmsVenda: Currency;
                              curImpFed: Currency;
                              curDesOpe: Currency;
                              curValCom: Currency;
                              strMarMkp: String = '' ):Double; StdCall;

  function fProdutoCadastrado(strCodIte: String): Boolean; StdCall;
  function fComponentByName(Owner: TWinControl; strNome: String): TComponent; StdCall;
  function fPadL(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String; StdCall;
  function fPadC(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String; StdCall;
  function fPadR(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String; StdCall;
  function fMskDigitos(intDigitos: Integer): String; StdCall;
  Function fRetEmpresaFisica: String; StdCall;
  function fExecutaSQL(strSQL: String): Boolean; StdCall;
  function fStrSQLOR(strCampo : String;
                     strParam : String;
                     arrLinha : TConsultasArray;
                     blnSemAND: Boolean = True;
                     blnNegar : Boolean = False): String;
  procedure pSetaParamOR(arrLinha : TConsultasArray;
                         strParam : String;
                         qryTabela: TUniQuery);

  function fGetPathTempOpcoesLocais: String;

  function BlockInput(Block: BOOL): BOOL; stdcall; external 'User32.dll' delayed;

  procedure pMensagensErro(MensErro, LocalErro:String;strMensagem : String = '' );
  function fParseError(strErrorMessage: String; Var strInfoAdicional: String): Integer;
  function fPosicoes(strString: String; chrBusca: Char): TIntArray;

  procedure pRedimensionarTelaSeguindoMenuIniciar(frmForm: TForm);
  function fPermiteCarregarSelecao(const ANomeForm : String): Boolean;

  function fConsultaComConfiguracaoNova(arrSql,
                                        arrCampos,
                                        arrOrdenacao: Array Of String;
                                        strCampoChave,
                                        strTabela,
                                        strNomForm,
                                        strTitulo: String;
                                        qryAux: TUniQuery;
                                        objFrmPnl: TPanelCx;
                                        blnSimples: Boolean;
                                        Var arrSelec: TConsultasArray;
                                        strCodBusca: String = 'AUTOINCREM';
                                        objConsulta: Pointer = Nil;
                                        blnTablet: Boolean = False;
                                        blnConIte: Boolean = False;
                                        strCampoChave2 : String = '';
                                        pAfterAtualiza: TGenericProcedureWithClientParam = Nil;
                                        blnRefresh : Boolean = True;
                                        blnConfirma: boolean = True;
                                        blnConCon: Boolean = True;
                                        fChamaCadastro : TBooleanFunctionWithBooleanParam = Nil;
                                        objPnlBanner: TPanelCx = Nil;
                                        objPnlPreFiltro: TPanelCx = Nil;
                                        _Application : TApplication = Nil;
                                        pBeforeAtualiza: TGenericProcedureWithClientParamAndVar = Nil): Boolean;

  function fVerificaAcessoSistema(strNomeForm: String; strCodOpe: String = ''): Boolean;
  function fVerPermissaoOperadorPorGrupo(strNomForm: String; strCodOpe: String = ''): Boolean;
  function fVerPermissaoOperador(strNomForm: String; strCodOpe: String = ''): Boolean;
  function fEhAdministrador(strCodOpe: String): Boolean;
  function fCfgSis(strCamCfg: String;  varTipVar: TVarType = varString; strCodEmp: String = ''): Variant;

  function fGetConnectionID(): String;

  function GetParamsExec: String;

  procedure pLog(strValor: String; qrySQL: TUniQuery = nil);

  function KillProcess(pid: cardinal; AForceKill: Boolean = True): Boolean;

  Function fTextoToLinha(strInfo: String): String;
  Function fLinhaToTexto(strInfo: String): String;

  function fKeyIsDown(const Key: integer): boolean;

  function fCalculaContraste(corFundo, corFonte: TColor): Double;
  function fCalculaMatiz(corFundo, corFonte: TColor): Double;
  function fTime(const AForceTime: Boolean = False) : TDateTime;
  function fSafeSQLValue(const AValue : String) : String;
  procedure pTrimAppMemorySize;

Var
  Database: TUniConnection;

var
  VS_HabLogArq: String;
  VS_CnxIdeLog: String;
  VS_PidIdeLog: string;
  VS_ParamsExec: string;
  VS_strCodEmp: String;
  objFuncaoSis: ICfgSis;
  VS_objTraceViewer: ITraceViewer;
  strUsuarioLogado: String;
  VS_Date: TDate;
  VS_intPrecisaoMargemItem: Integer;
  VS_ComputerNetName,
  VS_UserFromWindows,
  VS_IPAddressAsString,
  VS_MacAddress: String;
  VS_GravaUsuRep  : String;
  VS_LogRepConId  : String;
  VS_UsuRepConId  : String;
  VS_LogRepCodOp  : String;
  VS_LogRepIdTra  : String;
  VS_ConnectionID : String;

implementation

uses untMensagem, Math, untModuloReplicacaoLibFuncoes,untFuncoesGenCompartilhada,
  System.UITypes, untHorarioSistema, System.RegularExpressions;

Function fTextoToLinha(strInfo: String): String;
Begin
  Result := AnsiReplaceStr(strInfo, #13#10, '<<csq>>');
End;

Function fLinhaToTexto(strInfo: String): String;
Begin
  Result := strInfo;
  Result := AnsiReplaceStr(Result, '<<csq>>', #13#10);
  Result := AnsiReplaceStr(Result, '<<CSQ>>', #13#10);
End;

procedure pStepStatusGravacao(pgbStatus: TcxProgressBar; strInformacao: String='');
begin
  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Position := pgbStatus.Position + 1;

    If (Not fEmptyStr(strInformacao)) And (GetParentForm(pgbStatus).FindComponent('lblGravando') <> Nil) Then
      TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando')).Caption := strInformacao;

    Application.ProcessMessages;
  End;
end;

{**************************************}
{* CRIA UMA QUERYNOVA PARA SER USADA  *}
{***********************************AF*}
function fCriaQuery(AOwner: TComponent): TUniQuery;
Begin
  Result := TUniQuery.Create(AOwner);
  Result.Connection  := Database;
  Result.Tag := Result.Connection.Tag;
  If Assigned(untFuncoesGen.VS_objTraceViewer) Then
    untFuncoesGen.VS_objTraceViewer.SetQueryEvents(Result);
End;

function fConexaoAtivaGen(): Boolean;
begin
  Result := Assigned(Database) And Database.Connected;
end;

function fInTransactionGen(objConexao: TUniConnection = Nil): Boolean;
begin
  If Assigned(objConexao) Then
    Result := objConexao.InTransaction
  else
    Result := Assigned(Database) And Database.InTransaction;
end;

Function fStartTransactionGen: Boolean;
Begin
  Try
    Result := True;

    If (Not Database.InTransaction) Then
      Database.StartTransaction;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pErro(E.Message);
    End;
  End;

End;

Function fRollBackGen: Boolean;
Begin
  Try
    Result := True;

    If Database.InTransaction Then
      Database.Rollback;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pErro(E.Message);
    End;
  End;
End;

function fCommitGen:Boolean;
Begin
  Try
    Result := True;

    If Database.InTransaction Then
      Database.Commit;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pErro(E.Message);
    End;
  End;
End;

{**************************************}
{* VERIFICA SE UMA STRING ESTA VAZIA  *}
{***********************************MV*}
function fEmptyStr(strString : String) : Boolean;
Begin
  Result := False;
  strString := AnsiReplaceStr(strString, #10, '');
  strString := AnsiReplaceStr(strString, #13, '');
  If AnsiReplaceText(strString, ' ', '') = '' Then
    Result := True;
End;

procedure pReassignConexaoLibFuncoes(const AConexao: TUniConnection);
Begin
  If Not Assigned(AConexao) Then
    Exit;

  If Not Assigned(Database) Then
    Database := TUniConnection.Create(Nil);

  // o vinculo anterior pode estar orfão apos a queda da conexao
  Try
    Database.AssignConnect(Nil);
  Except
    //do nothing
  End;

  Database.AssignConnect(AConexao);
End;

{*************************************}
{* INICIA VARIAVEIS DEFAULT DA DLL   *}
{**********************************AF*}
procedure pIniciaDllFuncoes(Conexao: TUniConnection;
                            strUsuario,
                            strEmpresa: String;
                            intDebugH: Byte;
                            objFuncoes: ICfgSis;
                            objTraceViewer: ITraceViewer;
                            dtaDate: TDate;
                            strComputerNetName,
                            strUserFromWindows,
                            strIPAddressAsString,
                            strMacAddress: String);
Begin
  If Not Assigned(Database) Then
    Database := TUniConnection.Create(Nil);

  Database.AssignConnect(Conexao);
  strUsuarioLogado := Trim(strUsuario);
  VS_strCodEmp     := Trim(strEmpresa);
  objFuncaoSis     := objFuncoes;
  VS_objTraceViewer:= objTraceViewer;

  VS_Date              := dtaDate;
  VS_ComputerNetName   := strComputerNetName;
  VS_UserFromWindows   := strUserFromWindows;
  VS_IPAddressAsString := strIPAddressAsString;
  VS_MacAddress        := strMacAddress;

  If Not Assigned(ShowDebugFormProc) Then
    If Not Assigned(frmModuloReplicacaoLibFuncoes) Then
      frmModuloReplicacaoLibFuncoes := TfrmModuloReplicacaoLibFuncoes.Create(Nil);
End;

{***************************************}
{* INSERE ZEROS A FRENTE DE UMA STRING *}
{************************************AF*}
function fStrZero(Zeros: String; Quant: Integer): String;
  Var
	  I, Tamanho: Integer;
	  Aux: string;
Begin
  Tamanho := Length(Zeros);
  Aux := Zeros;
  Zeros:='';
  For I := 1 To Tamanho Do
	If Aux[i] <> ',' Then
	  Zeros := Zeros + Aux[i];

  Tamanho := Length(Zeros);
  Aux := Zeros;
  Zeros:='';
  for I:=1 to Quant-Tamanho do
  Zeros:=Zeros + '0';
  Aux := Zeros + Aux;
  fStrZero := Aux;
End;

function fSVN_RevisionFuncoes: String;
{$I rev.inc}
Begin
  Result := SVN_REVISION;
End;

procedure pSetForegroundWindowsConsulta;
begin
  If Assigned(VS_frmConsulta) Then
    SetForegroundWindow(VS_frmConsulta.Handle);
end;

Procedure pDisableControls(dtsDataSet: TDataSet; Var prcScroll: TprcScroll);
Begin
  With dtsDataSet Do
  Begin
    prcScroll := AfterScroll;
    AfterScroll := Nil;
    DisableControls;
  End;
End;

Procedure pEnableControls(dtsDataSet: TDataSet; Var prcScroll: TprcScroll; blnRefresh: Boolean = False);
Begin
  With dtsDataSet Do
  Begin
    AfterScroll := prcScroll;
    EnableControls;
    If blnRefresh then
      AfterScroll(dtsDataSet)
  End;
End;

function fGetParentLeft(AControl: TWinControl): Integer;
begin
  If AControl = nil Then Exit(0);
  Result := AControl.Left + fGetParentLeft(AControl.Parent);
end;

function fGetParentTop(AControl: TWinControl): Integer;
begin
  If AControl = nil Then Exit(0);
  Result := AControl.Top + fGetParentTop(AControl.Parent);
end;

function fGetGridRowScreenPosition(Grid: TcxGrid; View: TcxGridDBTableView): TRect;
begin
  Result := Result.Empty;
  If View.ViewData.Rows[(View.datacontroller.FocusedDataRowIndex)].ViewInfo <> Nil Then
  Begin
    Result := View.ViewData.Rows[(View.datacontroller.FocusedDataRowIndex)].ViewInfo.Bounds;
    Result.Top  := fGetParentTop(Grid) + Result.Top;
    Result.Left := fGetParentLeft(Grid) + Result.Left;
    Result.Bottom := fGetParentTop(Grid) + Result.Bottom;
  End;
end;

function fGetGridRowScreenPosition(Grid: TcxGrid; View: TcxGridDBBandedTableView): TRect;
begin
  Result := Result.Empty;
  If View.ViewData.Rows[(View.datacontroller.FocusedDataRowIndex)].ViewInfo <> Nil Then
  Begin
    Result := View.ViewData.Rows[(View.datacontroller.FocusedDataRowIndex)].ViewInfo.Bounds;
    Result.Left   := fGetParentLeft(Grid) + Result.Left;
    Result.Top    := fGetParentTop(Grid)  + Result.Top;
    Result.Bottom := fGetParentTop(Grid)  + Result.Bottom;
  End;
end;

Procedure pCloneDataSet(dtsDestino, dtsOrigem: TUniClientDataSet; blnComFomatacao: Boolean = False);
  Var
    intContador: Integer;
    prcScroll: TprcScroll;
Begin

  Try
    pDisableControls(dtsOrigem, prcScroll);

    dtsDestino.Data := dtsOrigem.Data;

    If blnComFomatacao Then
    Begin
      For intContador := 0 To dtsOrigem.FieldCount -1 Do
      Begin
        dtsDestino.Fields[intContador].DisplayLabel := dtsOrigem.Fields[intContador].DisplayLabel;

        If dtsDestino.Fields[intContador].DataType = ftFloat Then
          TFloatField(dtsDestino.Fields[intContador]).DisplayFormat := TFloatField(dtsOrigem.Fields[intContador]).DisplayFormat;

      End;
    End;

  Finally
    pEnableControls(dtsOrigem, prcScroll);
  End;

End;

{********************************}
{* CRIA FORMULÁRIOS TENTANDO 5X *}
{*****************************AF*}
procedure pCriarFormularios(Classe: TComponentClass; Var frmForm);
  Var
    intCont: Integer;
    strMsg: String;
Begin

  strMsg := '';

  For intCont := 0 To 4 Do
  Begin

    Try
      Application.CreateForm(Classe, frmForm);
      strMsg := '';
    Except
    On E: Exception Do
      strMsg := E.Message + ' ' + E.ClassName;
    End;

    If fEmptyStr(strMsg) Then
      Break;

    Application.ProcessMessages;
    Sleep(1500);

  End;

  If Not fEmptyStr(strMsg) Then
    Raise Exception.Create('Erro ao criar o formulário.' + #13 + strMsg);

End;

{********************************************}
{* UMA MANEIRA DIFERENTE DO FREEANDNIL PARA *}
{* LIBERAR FORMULÁRIOS DA MEMÓRIA           *}
{*****************************************AF*}
procedure pFreeAndNil(Var frmForm);
Begin
  If Assigned(TForm(frmForm)) Then
  Begin
    Try
      Application.ProcessMessages;
      FreeAndNil(frmForm);
    Except
      // Apenas para nao dar erro;
    End;
  End;
  Application.ProcessMessages;
End;

{****************************}
{* ATIVA ERRO DO EUREKA     *}
{*************************AF*}
procedure pErro(strMensagem: String);
Begin
  HandleException;
End;

{*****************}
{* NOVA CONSULTA *}
{**************AF*}
function fConsulta(arrSql,
                   arrCampos,
                   arrOrdenacao: Array Of String;
                   strCampoChave,
                   strTabela,
                   strNomForm,
                   strTitulo: String;
                   qryAux: TUniQuery;
                   objFrmPnl: TPanelCx;
                   blnSimples: Boolean;
                   Var arrSelec: TConsultasArray;
                   strCodBusca: String = 'AUTOINCREM';
                   objConsulta: Pointer = Nil;
                   blnTablet: Boolean = False;
                   blnConIte: Boolean = False;
                   strCampoChave2 : String = '';
                   pAfterAtualiza: TGenericProcedureWithClientParam = Nil;
                   blnRefresh: Boolean = True;
                   blnConfirma: boolean = True;
                   blnConCon: Boolean = True;
                   fChamaCadastro : TBooleanFunctionWithBooleanParam = Nil;
                   objPnlBanner: TPanelCx = Nil;
                   objPnlPreFiltro: TPanelCx = Nil;
                   _Application : TApplication = Nil;
                   pBeforeAtualiza: TGenericProcedureWithClientParamAndVar = Nil): Boolean;
Begin

  Try
    If fEmptyStr(strCampoChave) Then
      strCampoChave := 'AUTOINCREM';

    If fEmptyStr(strCampoChave2) Then
      strCampoChave2 := strCampoChave;

    If Not blnTablet Then
    Begin
      Result := fConsultaComConfiguracaoNova(arrSql,
                                             arrCampos,
                                             arrOrdenacao,
                                             strCampoChave,
                                             strTabela,
                                             strNomForm,
                                             strTitulo,
                                             qryAux,
                                             objFrmPnl,
                                             blnSimples,
                                             arrSelec,
                                             strCodBusca,
                                             objConsulta,
                                             blnTablet,
                                             blnConIte,
                                             strCampoChave2,
                                             pAfterAtualiza,
                                             blnRefresh,
                                             blnConfirma,
                                             blnConCon,
                                             fChamaCadastro,
                                             objPnlBanner,
                                             objPnlPreFiltro,
                                             _Application,
                                             pBeforeAtualiza);

    End

    Else Result := False;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pErro(E.Message);
    End;
  End;

End;


{*****************************************************************************************}
{*                                                                                       *}
{* -> Funcao Mensagem                                                                    *}
{*                                                                                       *}
{*    - Parametros:                                                                      *}
{*      1) Titulo                                                                        *}
{*      2) Texto                                                                         *}
{*      3) Matriz com o nome para até 03 botoes, sendo que vc pode passar ['',''] para   *}
{*         a funcao atribuir automaticamente Sim / Nao como Default                      *}
{***********************************************************************************MV*WI*}
function fMensagem(strTitulo, strTexto: String; arrOpcoes: Array Of String; intFocoBotao: Integer = 1; blnSaiComEsc: Boolean = False; intEstFon: Integer = 1; intWidBut: Integer = 0): Integer;
  Var
    intQtdOpcoes : Integer;
    intPosicao   : Integer;
    fntFonte     : TFont;
begin
  intQtdOpcoes   := 0;

  fntFonte       := TFont.Create;
  fntFonte.Name  := 'charter';
  fntFonte.Size  := 13;

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
  End
  Else If (Length(arrOpcoes) = 1)   And
     (Trim(arrOpcoes[0]) = '') Then
  Begin
    arrOpcoes[0] := '&Ok';
    intQtdOpcoes := 1;
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

    pCriarFormularios(TfrmMensagem, frmMensagem);

    With frmMensagem Do
    Begin

      If strTitulo = '' Then
        strTitulo := 'AVISO';

      If intEstFon = 2 Then
        lblMensagem.Font.Name := 'Courier New';

      lblTitulo.Caption   := strTitulo;
      lblMensagem.Caption := strTexto;

      If intQtdOpcoes = 1 Then
      Begin
        With TBitBtnLocked.Create(frmMensagem) Do
        Begin
          parent     := pnlBotoes;

          If intWidBut <> 0 Then
            Left       := 156 - ((intWidBut - 156) Div 2)
          Else
            Left       := 156;

          Top        := 05;
          Height     := 28;

          If intWidBut = 0 Then
            Width      := 126
          Else
            Width      := intWidBut;

          Font       := fntFonte;
          Caption    := arrOpcoes[0];
          Tag        := 1;
          Glyph      := imgbotao1.Picture.Bitmap;
          OnClick    := frmMensagem.pOnclick;
        End;
      End
      Else If intQtdOpcoes = 2 Then
      Begin
        With TBitBtnLocked.Create(frmMensagem) Do
        Begin
          parent     := pnlBotoes;

          If intWidBut <> 0 Then
            Left       := 90 - (intWidBut - 130)
          Else
            Left       := 90;

          Top        := 05;
          Height     := 28;

          If intWidBut = 0 Then
            Width      := 130
          Else
            Width      := intWidBut;

          Font       := fntFonte;
          Caption    := arrOpcoes[0];
          Tag        := 1;
          Glyph      := imgbotao1.Picture.Bitmap;
          OnClick    := frmMensagem.pOnclick;
        End;
        With TBitBtnLocked.Create(frmMensagem) Do
        Begin
          parent     := pnlBotoes;
          Left       := 222;
          Top        := 05;
          Height     := 28;

          If intWidBut = 0 Then
            Width      := 130
          Else
            Width      := intWidBut;
            
          Font       := fntFonte;
          Caption    := arrOpcoes[1];
          Tag        := 2;
          Glyph      := imgbotao2.Picture.Bitmap;
          OnClick    := frmMensagem.pOnclick;
        End;
      End
      Else If intQtdOpcoes = 3 Then
      Begin
        With TBitBtnLocked.Create(frmMensagem) Do
        Begin
          parent     := pnlBotoes;
          Left       := 28;
          Top        := 05;
          Height     := 28;
          Width      := 126;
          Font       := fntFonte;
          Caption    := arrOpcoes[0];
          Tag        := 1;
          Glyph      := imgbotao1.Picture.Bitmap;
          OnClick    := frmMensagem.pOnclick;
        End;
        With TBitBtnLocked.Create(frmMensagem) Do
        Begin
          parent     := pnlBotoes;
          Left       := 156;
          Top        := 05;
          Height     := 28;
          Width      := 126;
          Font       := fntFonte;
          Caption    := arrOpcoes[1];
          Tag        := 2;
          Glyph      := imgbotao2.Picture.Bitmap;
          OnClick    := frmMensagem.pOnclick;
        End;
        With TBitBtnLocked.Create(frmMensagem) Do
        Begin
          parent     := pnlBotoes;
          Left       := 284;
          Top        := 05;
          Height     := 28;
          Width      := 126;
          Font       := fntFonte;
          Caption    := arrOpcoes[2];
          Tag        := 3;
          Glyph      := imgbotao3.Picture.Bitmap;
          OnClick    := frmMensagem.pOnclick;
        End;
      End;
    End;

    frmMensagem.intFocus     := intFocoBotao;
    frmMensagem.blnSaiComEsc := blnSaiComEsc;
    frmMensagem.ShowModal;
    Result := frmMensagem.intRetorno;

  Except
    On E: Exception Do
    Begin
      Result := 0;
      pErro(E.Message);
    End;
  End;

  pFreeAndNil(frmMensagem);
  FreeAndNil(fntFonte);

end;

function fRetAutoIncrem(strNomeTabela, strCodEmp: String): String;
  Var
    intAutIncAtu: Integer;

    strSQL,
    strProEmp: String;
    qryGenCod: TUniQuery;

    function fAutoIncremCadastrado: Boolean;
      Var
        qryGenTmp : TUniQuery;

    begin
      Try

        qryGenTmp := fCriaQuery(Nil);

        With qryGenTmp Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT SQL_NO_CACHE AUTOINCREM FROM ' + strNomeTabela + ' WHERE AUTOINCREM = :AUTINC LIMIT 1');
          ParamByName('AUTINC').AsString := fFormataAutInc(intAutIncAtu, strCodEmp, strProEmp);
          Open;
          Result := (Not IsEmpty);
          Close;
        End;

        Finally
          FreeAndNil(qryGenTmp);
        End;

    end;

begin
  qryGenCod := fCriaQuery(Nil);

  Repeat

    Try

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  PRO_AUTINC AS AUTINC ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  PROINC ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  PRO_NOMARQ = :NOMARQ ';
      strSQL := strSQL + ' FOR UPDATE ';

      With qryGenCod Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NOMARQ').AsString := strNomeTabela;
        Open;

        If IsEmpty Then
        Begin
          Close;
          FreeAndNil(qryGenCod);
          Raise Exception.Create('A tabela ' + strNomeTabela + ' não está cadastrada ' +
                                 'na tabela de Próximos Codigos! Verifique.' + #13#10);
        End;

        strProEmp := fRetEmpresaFisica;

        If FieldByName('AUTINC').Value = Null Then
          intAutIncAtu := 1
        Else
          intAutIncAtu := FieldByName('AUTINC').AsInteger;

        Close;
      End;

      strSQL := '';
      strSQL := strSQL + 'UPDATE ';
      strSQL := strSQL + '  PROINC ';
      strSQL := strSQL + 'SET ';

      If intAutIncAtu = 1 Then
        strSQL := strSQL + '  PRO_AUTINC = 2 '
      Else
        strSQL := strSQL + '  PRO_AUTINC = PRO_AUTINC + 1 ';

      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  PRO_NOMARQ = :NOMARQ ';

      With qryGenCod Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NOMARQ').AsString := strNomeTabela;
        ExecSQL;
        Close;
      End;

      Result :=  strProEmp + fPadL(IntToStr(intAutIncAtu) + strCodEmp, 17, '0');

    Except
      On E: Exception Do
      Begin
        FreeAndNil(qryGenCod);
        Raise Exception.Create(E.message + 'Não consegui pegar o proximo sequencial. Tente novamente!');
      End;
    End;

  Until (Not fAutoIncremCadastrado);

  FreeAndNil(qryGenCod);

end;

procedure pRetornaPrecos(Const strCodIte: String; Var fltPreCus, fltMargem, fltPreVen: Double);
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

Function fMarkupToMargem(fltMarkup: Double): Double;
Var
  LPrecision: Integer;
Begin
  LPrecision := Max(4, fRetPrecisaoMargemItem);

  If ( ( fltMarkup / 100 ) + 1 ) <> 0 Then
    Result := RoundTo( (( fltMarkup / 100 ) / ( ( fltMarkup / 100 ) + 1 )) * 100, -LPrecision)
  Else
    Result := 0;
End;

Function fMargemToMarkup(fltMargem: Double): Double;
Var
  LPrecision: Integer;
Begin
  LPrecision := Max(4, fRetPrecisaoMargemItem);

  If RoundTo(fltMargem, -LPrecision) <> RoundTo(100, -LPrecision) Then
    Result := ((fltMargem / 100) / (1 - fltMargem/ 100)) * 100
  Else
    Result := 0;
End;

{***********************************************}
{* CALCULA 1 PRECO DE VENDA  E  2 MARGEM BRUTA *}
{********************************************AF*}
function fCalculaPrecoVenda(intOpcPrecoMargem: Integer;
                            curPrecus: Currency;
                            curPreven: Currency;
                            curMarBru: Double;
                            curIcmsVenda: Currency;
                            curImpFed: Currency;
                            curDesOpe: Currency;
                            curValCom: Currency;
                            strMarMkp: String = '' ):Double;
  Var
    strPcmPro,
    strMargemMarkup : String;
    fltPreCus       : Double;
    intDecUni: Integer;
Begin
  intDecUni := fCfgSis('DECUNI', varInteger);

  Result := 0;
  If fEmptyStr(strMarMkp) Then
    strMargemMarkup := fCfgSis('MARMKP')
  Else
    strMargemMarkup := strMarMkp;

  {*********************************************}
  {* caso nao use comissao por tabela de preco *}
  {******************************************jc*}

  If fEmptyStr(strPcmPro) Then
    strPcmPro := fCfgSis('PCMPRO');

  {MANTENDO O PARAMETRO CURVALCOM, MESMO QUANDO PCMPRO = '3' - QUE NÃO UTILIZA COMISSÃO, POIS USA O CAMPO DE VALOR
  PARA OUTROS ACRESCIMOS, PORTANTO SÓ SERÁ ZERADO QUANTO PCMPRO = '1' - KM}
  If strPcmPro = '1' Then
    curValCom := 0;

  {*****************************************}
  {* intOpcCalculo -> 1 Margem             *}
  {*               -> 2 MarKup             *}
  {**************************************WI*}
  If strMargemMarkup = '' Then
    strMargemMarkup := '1';

  {*****************************************}
  {* -> Calcula Preco de Venda             *}
  {**************************************WI*}
  If ( intOpcPrecoMargem = 1 ) Then
  Begin

    // CFG_MARMKP = MARGEM OU MARKUP OPÇÃO 2 (MODELO NOVO)
    If ( strMargemMarkup = '1' ) Or ( strMargemMarkup = '2' ) Then
    Begin

      // MARKUP OPÇÃO 2 (MODELO NOVO)
      If ( strMargemMarkup = '2' ) Then
        curMarBru := fMarkupToMargem(curMarBru);

      Result := curPrecus;

      curMarBru := curMarBru + curIcmsVenda + curImpFed + curDesOpe + curValCom;

      If (curMarBru = 100) Then
        curMarBru := 0;

      If (Result / ( 1 - ( curMarBru / 100 ) )) <> 0 Then
        Result := Result / ( 1 - ( curMarBru / 100 ) );

    End

    Else If ( strMargemMarkup = '5' ) Then
    Begin
      If curPrecus / (1 - ((curIcmsVenda + curImpFed + curDesOpe + curValCom )/100)) = 0 Then
        Result := curPrecus
      Else
        Result := curPrecus / (1 - ((curIcmsVenda + curImpFed + curDesOpe + curValCom )/100));

      If (100 - curMarBru) <> 0 Then
        Result := Result / ((100 - curMarBru) /100)
      Else
        Result := 0;
    End

    Else {If ( strMargemMarkup = '3' ) Then // MARKUP MODELO ANTIGO}
    Begin
      If curPrecus / (1 - ((curIcmsVenda + curImpFed + curDesOpe + curValCom )/100)) = 0 Then
        Result := curPrecus
      Else
        Result := curPrecus / (1 - ((curIcmsVenda + curImpFed + curDesOpe + curValCom )/100));

      Result := Result + ( ( Result * curMarBru ) / 100 );
    End

  End

  {*****************************************}
  {* -> Calcula Margem Bruta               *}
  {**************************************WI*}
  Else If ( intOpcPrecoMargem = 2 ) Then
  Begin

    // CFG_MARMKP = MARGEM OU MARKUP OPÇÃO 2 (MODELO NOVO)
    If ( strMargemMarkup = '1' ) Or ( strMargemMarkup = '2' ) Then
    Begin
      If curPreven <> 0 Then
      Begin
        Result := curPreVen * (1 - ((curIcmsVenda + curImpFed + curDesOpe + curValCom )/100)) - curPrecus;

        Result := (Result / curPreven) * 100;
      End

      Else
        Result := 0.0;

      // MARKUP OPÇÃO 2 (MODELO NOVO)
      If ( strMargemMarkup = '2' ) Then
        Result := fMargemToMarkup(Result);
    End

    Else If ( strMargemMarkup = '5' ) Then
    Begin
      If curPrecus / (1 - ((curIcmsVenda + curImpFed + curDesOpe + curValCom )/100)) = 0 Then
        Result := curPrecus
      Else
        Result := curPrecus / (1 - ((curIcmsVenda + curImpFed + curDesOpe + curValCom )/100));

      If curPreVen <> 0 Then
        Result := ((curPreVen - Result) / curPreVen) * 100
      Else
        Result := 0;
    End

    Else {If ( strMargemMarkup = '3' ) Then }
    Begin

      If curPrecus / (1 - ((curIcmsVenda + curImpFed + curDesOpe + curValCom )/100)) = 0 Then
        fltPreCus := curPrecus
      Else
        fltPreCus := curPrecus / (1 - ((curIcmsVenda + curImpFed + curDesOpe + curValCom )/100));

      If fltPreCus <> 0 Then
        Result := ( ( curPreVen / fltPreCus ) * 100 ) - 100
      Else
        Result := 0.0;
    End;

    Result := Result;
  End;

  If (intOpcPrecoMargem = 1) Then
    Result := fStrToFloat( FormatFloat(fMskDigitos(intDecUni), Result ) )
  Else
    Result := fStrToFloat( FormatFloat(fMskDigitos(fRetPrecisaoMargemItem), Result ) );

End;

function fRetPrecisaoMargemItem: Integer;
  Var
    qryAux: TUniQuery;
    strAux: String;
Begin
  Result := 2;

  If VS_intPrecisaoMargemItem > -1 Then
  Begin
    Result := Max(Result, VS_intPrecisaoMargemItem);
    Exit;
  End;

  qryAux := fCriaQuery(nil);
  qryAux.SQL.Text := 'DESC ITEGER';
  qryAux.Open;
  While (Not qryAux.Eof) Do
  Begin
    If qryAux.FieldByName('Field').AsString = 'ITE_MARBR1' Then
    Begin
      strAux := Trim(qryAux.FieldByName('Type').AsString);
      strAux := Copy(strAux, Succ(Pos(',', strAux)), 1);
      VS_intPrecisaoMargemItem := strToIntDef(strAux, 2);
      Result := Max(Result, VS_intPrecisaoMargemItem);
      Break;
    End;
    qryAux.Next;
  End;
  FreeAndNil(qryAux);
end;


{*****************************************}
{* RETORNA SE O PRODUTO ESTA CADASTRADO  *}
{* OU NÃO                                *}
{**************************************MV*}
function fProdutoCadastrado(strCodIte: String): Boolean;
  Var
    strSQL   : String;
    qryGenIte: TUniQuery;
begin

  Try
    qryGenIte := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS QTD ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      Open;
      Result := FieldByName('QTD').AsInteger > 0;
      Close;
    End;

  Finally
    FreeAndNil(qryGenIte);
  End;

end;

procedure pSetaClient(cdsClient: TDataSet);
  Var
    intContador: Integer;
Begin
  With cdsClient Do
  For intContador := 0 To Fields.Count - 1 Do
  Begin
    Fields[intContador].ReadOnly := False;
    Fields[intContador].Required := False;
  End;
End;

function fComponentByName(Owner: TWinControl; strNome: String): TComponent;
  Var
    intContador: Integer;
begin
  Result := Nil;

  For intContador := 0 To Owner.ControlCount -1 Do
  Begin
    If (Owner.Controls[intContador] Is TControl) Then
      If AnsiUpperCase((Owner.Controls[intContador] As TControl).Name) = AnsiUpperCase(strNome) Then
      Begin
        Result := (Owner.Controls[intContador] As TControl);
        Break;
      End;
  End;

end;

{*********************************************}
{* FUNCAO PARA CRIAR QUERY E RETER OS CAMPOS *}
{******************************************PH*}
function fCriarQuery(strSQL: String; blnDeixarAberto: Boolean = False; AOwner: TComponent = nil): TUniQuery;
  Var
    intCont: Integer;
begin
  Result := fCriaQuery(AOwner);
  Result.SQL.Text := strSQL;
  Result.Open;

  If Not blnDeixarAberto Then
    Result.Close;

  For intCont := 0 To Result.FieldDefs.Count - 1 Do
    Result.FieldDefs[intCont].CreateField(Result);
end;

{******************************************}
{* FORMATA UM NUMERO COM X CASAS DECIMAIS *}
{***************************************MV*}
function fFormataFloat(fltNumero: Double; intDecimais: Integer): Double;
Begin
  Result := TFuncoesGenCompartilhada.fFormataFloat(fltNumero, intDecimais);
End;

{************************************}
{* TRANSFORMA STRING PARA DOUBLE    *}
{* QUANDO USAVA fStrToFloat EM UM    *}
{* VALOR DE MILHAR EX 1.005,23      *}
{* OCORRIA ERRO POR CAUSA DO .      *}
{*********************************AF*}
function fStrToFloat(strValor: String): Double;
Begin
  Result := TFuncoesGenCompartilhada.fStrToFloat(strValor);
End;

function fFormataAutInc(intAutInc: Integer; strCodEmp: String; strProEmp: String = ''): String;
begin
  If fEmptyStr(strProEmp) Then
    strProEmp := fRetEmpresaFisica;

  Result := strProEmp + fstrZero(IntToStr(intAutInc) + strCodEmp, 17);
end;

{*****************************************}
{* FAZ ALINHAENTO (PAD) À ESQUERDA       *}
{**************************************WI*}
function fPadL(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
  Var
    intContador: Integer;
begin
  Result := strTexto;

  If Length(strTexto) < intTamanho Then
  Begin
    intTamanho := intTamanho - Length(strTexto);
  End
  Else
  Begin
    Result := Copy(strTexto,1,intTamanho);
    Exit;
  End;

  For intContador := 1 To intTamanho Do
    Result := strCaracter + Result;
end;


{*****************************************}
{* FAZ ALINHAMENTO (PAD) CENTRAL         *}
{**************************************MV*}
function fPadC(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
  Var
    intDir, intEsq: Integer;
    intContador: Integer;
begin
  intTamanho := intTamanho - Length(strTexto);
  intDir := (intTamanho Div 2);
  intEsq := (intTamanho Div 2) + intTamanho Mod 2;

  Result := strTexto;
  For intContador := 1 To intDir Do
    Result := Result + strCaracter;
  For intContador := 1 To intEsq Do
    Result := strCaracter + Result;
end;

{*****************************************}
{* FAZ ALINHAENTO (PAD) À DIREITA       *}
{**************************************WI*}
function fPadR(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
  Var
    intContador: Integer;
begin
  Result := strTexto;
  If Length(strTexto) < intTamanho Then
  Begin
    intTamanho := intTamanho - Length(strTexto);
  End
  Else
  Begin
    Result := Copy(strTexto,1,intTamanho);
    Exit;
  End;

  For intContador := 1 To intTamanho Do
    Result := Result + strCaracter;
end;

{*****************************************}
{* RETORNA MASCARA PARA A FUNÇÃO         *}
{* 'FormatFloat'                         *}
{**************************************MV*}
function fMskDigitos(intDigitos: Integer): String;
begin
  result := TFuncoesGenCompartilhada.fMskDigitos(intDigitos);
end;

Function fRetEmpresaFisica: String;
  Var
    qryGen: TUniQuery;
Begin
  Try
    qryGen := fCriaQuery(Nil);
    With qryGen Do
    Begin
      SQL.Text := 'SELECT PRO_CODEMP FROM PROCOD WHERE PRO_NOMARQ = "MOVGER"';
      Open;

      If IsEmpty Then
        Result := VS_strCodEmp
      Else
        Result := FieldByName('PRO_CODEMP').AsString;

      Close;

    End;
    FreeAndNil(qryGen);

  Except
    On E: Exception Do
    Begin
      Result := VS_strCodEmp;
      pErro(E.Message);
    End;
  End;
End;

function fExecutaSQL(strSQL: String): Boolean;
  Var
    qryGen: TUniQuery;
Begin
  Result := True;
	Try
    qryGen := fCriaQuery(nil);
		With qryGen do
		Begin
			Close;
			SQL.Clear;
			SQL.Add(strSQL);
      ExecSQL;
		End;

	Except
		On E: Exception do
		Begin
			Result := False;
			pErro(E.Message);
		End;
	End;
  FreeAndNil(qryGen);
End;

function fStrSQLOR(strCampo : String;
                   strParam : String;
                   arrLinha : TConsultasArray;
                   blnSemAND: Boolean = True;
                   blnNegar : Boolean = False): String;
  Var
    intCon: Integer;
begin
  Result := '';

  If blnNegar Then
    Result := Result + ' NOT( '
  Else
    Result := Result + ' ( ';
  If (Length(arrLinha) > 1) Then
  Begin
    For intCon := 0 to Length(arrLinha) - 1 Do
    Begin
      Result := Result + ' (' + strCampo + '= :' + strParam + IntToStr(intCon);
      If intCon = (Length(arrLinha) - 1) Then
        Result := Result + ')'
      Else
        Result := Result + ') OR ';
    End;
  End
  Else
    Result := Result + strCampo + '= :' + strParam;

  Result := Result + ' )';

  If Not blnSemAND Then
    Result := '  AND ' + Result;
end;

procedure pSetaParamOR(arrLinha : TConsultasArray;
                       strParam : String;
                       qryTabela: TUniQuery);
  Var
    intCon: Integer;
begin
  If (Length(arrLinha) > 1) Then
  Begin
    For intCon := 0 to Length(arrLinha) - 1 Do
      qryTabela.ParamByName(strParam + IntToStr(intCon)).AsString := arrLinha[intCon].strCodigo;
  End
  Else
    qryTabela.ParamByName(strParam).AsString := arrLinha[0].strCodigo;
end;

function fGetPathTempOpcoesLocais: String;
  Var
    Buffer: Array[0..254] Of Char;
    strPatIni: String;
		iniArqIni : TIniFile;
begin
  Result := '';
  GetWindowsDirectory(Buffer, 255);
  strPatIni := StrPas(Buffer) + '\OPCOES_LOCAIS.INI';

  If FileExists(strPatIni) Then
  Begin
    iniArqIni := TIniFile.Create(strPatIni);
    Try
      Result := iniArqIni.ReadString('ARQUIVOS_TEMPORARIOS', 'PATH' , Result)
    Finally
      iniArqIni.Free;
    End;
  End;
end;

procedure pSetFocus(SenderUnico: TWinControl; Form: TCustomForm = nil);
begin
  If Not Assigned(SenderUnico) Then
    Exit;

  If ((GetKeyState(VK_SHIFT) And 128) = 128) And
     ((GetKeyState(VK_TAB) And 128) = 128) Then
    Exit;

  Try
    if Form = Nil then
      Form := GetParentForm(SenderUnico);


    If (Form <> nil) And (Form.CanFocus) And SenderUnico.CanFocus Then
    Begin
      Try
        SenderUnico.SetFocus;

        if (SenderUnico is TCustomCheckBox) or (SenderUnico is TCustomCombo) then
          SenderUnico.Perform(WM_UPDATEUISTATE, MakeWParam(UIS_CLEAR, UISF_HIDEFOCUS), 0);

      Except

      End;
    End;
  Except

  End;
end;

function DLLMain(dwReason: DWORD): Boolean;
begin
  Result:=True;

  {case dwReason of
    DLL_PROCESS_ATTACH:
    begin
      ThemeServices.Create;
    end;

    DLL_PROCESS_DETACH:
    begin
      ThemeServices.Free;
    end;
  end;}
end;

function fParseError(strErrorMessage: String; Var strInfoAdicional: String): Integer;
  Var
    arrPosicoes: TIntArray;
begin

  arrPosicoes := fPosicoes(strErrorMessage, #39);

  If (Pos('Unknown database', strErrorMessage) > 0) Then
  Begin
    Result := ERR_UNKNOW_DATABASE;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1] - arrPosicoes[0]);
  End
  Else If (Pos('Access denied for user', strErrorMessage) > 0) Then
  Begin
    Result := ERR_ACCESS_DENIED;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[1], arrPosicoes[3] - arrPosicoes[1]);
  End
  Else If (Pos('Table', strErrorMessage) > 0) And (Pos('doesn'#39't exist', strErrorMessage) > 0) Then
  Begin
    Result := ERR_TABLE_NOT_EXIST;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  End
  Else If ((Pos('Field', strErrorMessage) > 0) And (Pos('not found', strErrorMessage) > 0)) OR
          ((Pos('Coluna', strErrorMessage) > 0) And (Pos('desconhecida', strErrorMessage) > 0)) Then
  Begin
    Result := ERR_FIELD_NOT_FOUND;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  End
  Else If (Pos('Operation is not allowed in READ ONLY mode', strErrorMessage) > 0) Then
  Begin
    Result := ERR_TABLE_READONLY;
  End
  Else If (Pos('Cannot modify a read-only dataset', strErrorMessage) > 0) Then
  Begin
    Result := ERR_TABLE_READONLY;
  End
  Else If (Pos('not a valid integer value', strErrorMessage) > 0) Then
  Begin
    Result := ERR_NOT_VALID_INT;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  End
  Else If (Pos('not a valid date', strErrorMessage) > 0) Then
  Begin
    Result := ERR_NOT_VALID_DATE;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  End
  Else If (Pos('not a valid floating point value', strErrorMessage) > 0) Then
  Begin
    Result := ERR_NOT_VALID_FLOAT;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  End
  Else If (Pos('Dataset not in edit or insert mode', strErrorMessage) > 0) Then
  Begin
    Result := ERR_NOT_IN_EDIT;
  End
  Else If (Pos('You have an error in your SQL syntax', strErrorMessage) > 0) Then
  Begin
    Result := ERR_SQL_SYNTAX;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  End
  Else If (Pos('Can'#39't connect to local MySQL server through socket', strErrorMessage) > 0) Then
  Begin
    Result := ERR_BD_NOT_ACTIVE;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  End
  Else If (Pos('Column', strErrorMessage) > 0) And (Pos('cannot be null', strErrorMessage) > 0) Then
  Begin
    Result := ERR_FIELD_NOT_NULL;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  End
  Else If (Pos('Duplicate entry', strErrorMessage) > 0 ) And (Pos('for key', strErrorMessage) > 0) Then
  Begin
    Result := ERR_PRIMARY_KEY;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  End
  Else If (Pos('duplicado', strErrorMessage) > 0 ) Or (Pos('duplicate', strErrorMessage) > 0) Then
  Begin
    Result := ERR_PRIMARY_KEY;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  End
  Else If (Pos('Unknown column', strErrorMessage) > 0) And (Pos('order clause', strErrorMessage) > 0) Then
  Begin
    Result := ERR_ORDER_BY;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  End
  Else If (Pos('There is no default printer currently selected', strErrorMessage) > 0) Then
  Begin
    Result := ERR_DEFAULT_PRINTER;
    strInfoAdicional := '';
  End
//#################################################
  Else If (Pos('linha pai', strErrorMessage) > 0) And (Pos('chave estrangeira', strErrorMessage) > 0) Then
  Begin
    Result := ERROR_FOREIGN_KEY_DELETE;
    strInfoAdicional := '';
  End
  Else If (Pos('parent row', strErrorMessage) > 0) And (Pos('foreign key', strErrorMessage) > 0) Then
  Begin
    Result := ERROR_FOREIGN_KEY_DELETE;
    strInfoAdicional := '';
  End
//#################################################
  Else If (Pos('Unknown column', strErrorMessage) > 0) And (Pos('field list', strErrorMessage) > 0) Then
  Begin
    Result := ERR_FIELD_UNKNOWN;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  End
  Else
    Result := ERR_UNKNOW_ERROR;
end;


procedure pMensagensErro(MensErro, LocalErro:String;strMensagem : String = '' );
  Var
    NrErro: Integer;
    strInfo: String;
begin

  NrErro := fParseError(MensErro, strInfo);

  Case NrErro Of
    ERR_UNKNOW_ERROR         :pErro(MensErro + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_UNKNOW_DATABASE      :pErro(strInfo + ': Banco de dados inexistente' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_ACCESS_DENIED        :pErro('Accesso negado ao usuário ' + strInfo + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_TABLE_NOT_EXIST      :pErro('Tabela ' + strInfo + ' não Existe!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_FIELD_NOT_FOUND      :pErro('Campo ' + strInfo + ' não Existe!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_TABLE_READONLY       :pErro('Operação não suportada no modo Somente Leitura!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_NOT_VALID_INT        :pErro(strInfo + ' não é um número inteiro válido!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_NOT_VALID_DATE       :fMensagem('ATENÇÃO!',strInfo + ' não é uma data válida!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem, ['&OK']);
    ERR_NOT_VALID_FLOAT      :pErro(strInfo + ' não é um número válido!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_NOT_IN_EDIT          :pErro('Tabela não está em modo de Edição!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_SQL_SYNTAX           :pErro('Há um erro de Sintaxe no SQL: ' + strInfo + #10 + 'Local: ' + #10 + LocalErro + #10 + strMensagem);
    ERR_BD_NOT_ACTIVE        :pErro('O Servidor de banco de dados não está ativo!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_FIELD_NOT_NULL       :pErro('O campo ' + strInfo + ' é de preenchimento obrigatório!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_PRIMARY_KEY          :pErro(strInfo + ': valor duplicado não permitido!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_ORDER_BY             :pErro('Coluna ' + strInfo + ' desconhecida no processo de ordenação!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERROR_FOREIGN_KEY_DELETE :fMensagem('ATENÇÃO!', 'Não é possivel excluir esse registro, pois existe movimentação para o mesmo.', ['&O k']);
    ERR_DEFAULT_PRINTER      :fMensagem('ATENÇÃO!', 'Não há impressora padrão selecionada!', ['&O k']);
    ERR_FIELD_UNKNOWN        :fMensagem('ATENÇÃO!', 'Coluna ' + strInfo + ' desconhecida !', ['&O k']);
  End;

end;

function fPosicoes(strString: String; chrBusca: Char): TIntArray;
  Var
    intContador: Integer;
begin

  For intContador := 1 To Length(strString) Do
  Begin
    If strString[intContador] = chrBusca Then
    Begin
      SetLength(Result, Length(Result)+1);
      Result[Length(Result)-1] := intContador;
    End
  End;

end;

procedure pRedimensionarTelaSeguindoMenuIniciar(frmForm: TForm);
var
  Tasklist : HWnd;
  Bordered : TRect;
begin
  Tasklist := FindWindow('Shell_TrayWnd', nil);
  GetWindowRect(Tasklist, Bordered);

  If (Bordered.Height <= 0) Or (Bordered.Width <= 0) Then
  begin
    frmForm.Height := Screen.Height;
    frmForm.Width  := Screen.Width;
    Exit;
  end;

  if Bordered.Height < Bordered.Width then
  Begin
    frmForm.Height := Screen.Height-Bordered.Height;
    frmForm.Width  := Screen.Width;
  End
  Else
  Begin
    frmForm.Height := Screen.Height;
    frmForm.Width  := Screen.Width-Bordered.Width;
  End;

End;

function fPermiteCarregarSelecao(const ANomeForm : String): Boolean;
begin
  Result := True;

  If ANomeForm = 'frmEditorMetas' Then
    Exit;

  Result := False;
End;

function fConsultaComConfiguracaoNova(arrSql,
                                      arrCampos,
                                      arrOrdenacao: Array Of String;
                                      strCampoChave,
                                      strTabela,
                                      strNomForm,
                                      strTitulo: String;
                                      qryAux: TUniQuery;
                                      objFrmPnl: TPanelCx;
                                      blnSimples: Boolean;
                                      Var arrSelec: TConsultasArray;
                                      strCodBusca: String = 'AUTOINCREM';
                                      objConsulta: Pointer = Nil;
                                      blnTablet: Boolean = False;
                                      blnConIte: Boolean = False;
                                      strCampoChave2 : String = '';
                                      pAfterAtualiza: TGenericProcedureWithClientParam = Nil;
                                      blnRefresh : Boolean = True;
                                      blnConfirma: Boolean = True;
                                      blnConCon: Boolean = True;
                                      fChamaCadastro : TBooleanFunctionWithBooleanParam = Nil;
                                      objPnlBanner: TPanelCx = Nil;
                                      objPnlPreFiltro: TPanelCx = Nil;
                                      _Application : TApplication = Nil;
                                      pBeforeAtualiza: TGenericProcedureWithClientParamAndVar = Nil): Boolean;
  Var
    intCon  : Integer;
    strSimilar,
    strSQLRetorno: String;
    frmConsulta: TfrmConsultaCxGridNovaAutcom;
Begin
  frmConsulta := TfrmConsultaCxGridNovaAutcom.Create(nil);
  try
    {Req: 113771 - O parâmetro "Application" quando informado possibilita a abertura de
     formulários do projeto autcom via DLL sem ocultar o form da pesquisa!}
    If Assigned(_Application) Then
    Begin

      frmConsulta.ParentWindow := _Application.Handle;
      frmConsulta.BorderStyle  := bsDialog; {<<- Não retirar!}

      {Para compor a borda do "bsDialog"}
      frmConsulta.BorderWidth := 10;

      frmConsulta.Width  := Screen.WorkAreaWidth;
      frmConsulta.Height := Screen.WorkAreaHeight;

      frmConsulta.Left := Screen.WorkAreaLeft;
      frmConsulta.Top  := Screen.WorkAreaTop;
    End;

    VS_frmConsulta := frmConsulta;

    frmConsulta.pBeforeAtualiza := pBeforeAtualiza;
    frmConsulta.pAfterAtualiza := pAfterAtualiza;
    frmConsulta.strNomForm  := Trim(strNomForm);
    frmConsulta.strCodBusca := Trim(strCodBusca);
    frmConsulta.Caption     := Trim(strTitulo);
    frmConsulta.strTitPesq  := Trim(strTitulo);
    frmConsulta.blnSimples  := blnSimples;
    frmConsulta.objConsulta := objConsulta;
    frmConsulta.blnRefresh  := blnRefresh;

    If (fPermiteCarregarSelecao(strNomForm)) Then
      frmConsulta.arrSelec := arrSelec;

    frmConsulta.pSetaOrdenacao(arrOrdenacao);
    frmConsulta.pSetaCampos(arrCampos);
    frmConsulta.pSetaSql(arrSQL);

    frmConsulta.objFrmPnl    := objFrmPnl;
    frmConsulta.objPnlBanner := objPnlBanner;
    frmConsulta.objPnlPreFiltro := objPnlPreFiltro;

    frmConsulta.btnConfirma.Visible := blnConfirma;

    frmConsulta.blnConCon := blnConCon;
    frmConsulta.fChamaCadastro := Nil;

    frmConsulta.blnConite := blnConIte;
    
    If Assigned(fChamaCadastro) Then
      frmConsulta.fChamaCadastro := @fChamaCadastro;

    If Assigned(frmConsulta.objFrmPnl) And
       Assigned(frmConsulta.objFrmPnl.frmPanel) Then
      pSetCxControlsScrollbarModeClassic(frmConsulta.objFrmPnl.frmPanel);

    frmConsulta.ShowModal;

    Result := frmConsulta.blnConfirma;

    If Assigned(frmConsulta.objFrmPnl) Then
      frmConsulta.objFrmPnl.pRetornaValores(frmConsulta.cdsConsulta);

    {***************************}
    {* SIMPLES OU NAO TEM QUE  *}
    {* PEGAR SELEÇÃO DO ARRAY  *}
    {************************NC*}
    SetLength(arrSelec, 0);
    For intCon := 0 To Length(frmConsulta.arrCodSel) - 1 do
    Begin
      SetLength(arrSelec, Length(arrSelec) + 1);
      arrSelec[Length(arrSelec) - 1].strCodigo := frmConsulta.arrCodSel[intCon];
    End;

    strSimilar := '';
    If Assigned(frmConsulta.objFrmPnl) And
       Assigned(frmConsulta.objFrmPnl.frmPanel) Then
    Begin
      strSimilar := frmConsulta.objFrmPnl.strSimilar;
      frmConsulta.objFrmPnl.frmPanel.Close;
      frmConsulta.objFrmPnl.frmPanel.ManualDock(Nil);
      FreeAndNil(frmConsulta.objFrmPnl.frmPanel);
    End;

    If Result Then
    Begin
      strSQLRetorno := 'SELECT * FROM ' + Trim(strTabela);

      If Assigned(objConsulta) And (Not fEmptyStr(TDefConsulta(objConsulta).strSQLRetorno)) Then
        strSQLRetorno := TDefConsulta(objConsulta).strSQLRetorno;

      If blnSimples Then
      Begin
        qryAux.Close;
        qryAux.Fields.Clear;
        qryAux.FieldDefs.Clear;
        qryAux.SQL.Clear;

        qryAux.SQL.Add(strSQLRetorno + ' WHERE ' + strTabela + '.' + Trim(strCampoChave2) + ' = :CHAVE');

        If (strSimilar <> '') Then
           qryAux.ParamByName('CHAVE').AsString := strSimilar
        Else If (Not fEmptyStr(frmConsulta.strAutoIncremSimilarSelecionado)) Then
          qryAux.ParamByName('CHAVE').AsString := frmConsulta.strAutoIncremSimilarSelecionado
        Else
          qryAux.ParamByName('CHAVE').AsString := frmConsulta.cdsConsulta.FieldByName(Trim(strCampoChave)).AsString;

        qryAux.Open;
      End
      Else
      Begin
        qryAux.Close;
        qryAux.Fields.Clear;
        qryAux.FieldDefs.Clear;
        qryAux.SQL.Clear;
        qryAux.SQL.Add(strSQLRetorno + ' WHERE ');
        If Length(arrSelec) = 0  Then
          qryAux.SQL.Add('FALSE ')
        Else
        Begin
          qryAux.SQL.Add(fStrSQLOR(Trim(strCodBusca), Trim(strCodBusca), arrSelec));
          pSetaParamOR(arrSelec, Trim(strCodBusca), qryAux);
        End;
        qryAux.Open;
      End;
    End;
  finally
    pFreeAndNil(frmConsulta);
  end;
End;

function fEhAdministrador(strCodOpe: String): Boolean;
Begin
  Result := SameText('999', strCodOpe) Or
            SameText('998', strCodOpe) Or
            SameText('997', strCodOpe);
End;

{********************************************************}
{* VERIFICAD SE O OPERADOR TEM DIREITO AO FORM A SER    *}
{* ACESSADO RETORNANDO TRUE SE TEM ACESSO E FALSE SE    *}
{* NAO TEM ACESSO                                       *}
{*****************************************************AF*}
function fVerPermissaoOperador(strNomForm: String; strCodOpe: String = ''): Boolean;
  Var
    strOperador: String;
    strSQL     : String;
    qryPerOpeAux  : TUniQuery;

begin
  try
    If (strNomForm = 'frmLogoff') Or (strNomForm = 'frmSobre') Or (strNomForm = 'frmUtilMenuPAFNFCe') Then
      Exit(True);

    If (Not fEmptyStr(strCodOpe)) Then
      strOperador := strCodOpe
    Else
      strOperador := strUsuarioLogado;

    if fEhAdministrador(strOperador) Then
      Exit(True);

    qryPerOpeAux := fCriaQuery(Nil);
    Try
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  * ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '   DIROPE ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '   OPE_CODOPE = :CODOPE AND ';
      strSQL := strSQL + '   DIR_NOMFRM = :NOMFRM ';
      Result := False;

      qryPerOpeAux.SQL.Add(strSQL);
      qryPerOpeAux.ParamByName('CODOPE').AsString := strOperador;
      qryPerOpeAux.ParamByName('NOMFRM').AsString := strNomForm;
      qryPerOpeAux.Open;

      If Not qryPerOpeAux.IsEmpty Then
        Result := True;

      qryPerOpeAux.Close;

    Finally
      FreeAndNil(qryPerOpeAux);
    End;
  except on e: Exception do
    raise;
  end;
end;

{***************************************************************}
{* VERIFICA SE O OPERADOR TEM ACESSO AO FORM PELO DIREITO      *}
{* DE GRUPO DE USUARIO CASO ELE NAO TENHA ACESSO COM OPERADOR  *}
{************************************************************AF*}
function fVerPermissaoOperadorPorGrupo(strNomForm: String; strCodOpe: String = ''): Boolean;
  Var
    strOperador: String;
    strSQL     : String;
    qryGenGpo  : TUniQuery;

begin
  Try

    qryGenGpo := fCriaQuery(Nil);

    If (Not fEmptyStr(strCodOpe)) Then
      strOperador := strCodOpe
    Else
      strOperador := strUsuarioLogado;

    If Not fEhAdministrador(strOperador) Then
    Begin
      Result := False;
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  *  ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '   DIRGPO D, ';
      strSQL := strSQL + '   OPEGPO O, ';
      strSQL := strSQL + '   CADGPO G ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '   O.OPE_CODOPE = :CODOPE AND ';
      strSQL := strSQL + '   O.GPO_CODGPO = G.GPO_CODGPO AND ';
      strSQL := strSQL + '   G.GPO_CODGPO = D.GPO_CODGPO AND ';
      strSQL := strSQL + '   D.DIR_NOMFRM = :NOMFRM ';
      With qryGenGpo Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODOPE').AsString := strOperador;
        ParamByName('NOMFRM').AsString := strNomForm;
        Open;
        If Not IsEmpty Then
          Result := True;
      End;
      qryGenGpo.Close;
    End
    Else
      Result := True;

  Finally
    FreeAndNil(qryGenGpo);
  End;

end;

{**********************************}
{* VERIFICA SE TEM PERMISSÃO NO   *}
{* CADOPE E NO CADGPO             *}
{*******************************AF*}
function fVerificaAcessoSistema(strNomeForm: String; strCodOpe: String = ''): Boolean;
Begin
  try
    If fVerPermissaoOperador(strNomeForm, strCodOpe) Then
      Result := True
    Else If fVerPermissaoOperadorPorGrupo(strNomeForm, strCodOpe) Then
      Result := True
    Else If fEmptyStr(strNomeForm) Then
      Result := True
    Else
      Result := False;
  except on e: Exception do
    raise;
  end;
End;

function fKeyIsDown(const Key: integer): boolean;
begin
  Result := GetKeyState(Key) and 128 > 0;
end;

procedure pBrowserNavigate(strURL: String);
Var
  strBrowser : String;
Begin
  strBrowser := ExtractFilePath(Application.ExeName) + '\browser\CitelBrowser.exe';

  If FileExists(strBrowser) Then
    WinExec(PAnsiChar(AnsiString(strBrowser + ' ' + strURL)), SW_SHOWMAXIMIZED)
  Else
    ShellExecute(0, nil, PChar(strURL), nil, nil, SW_SHOWNORMAL);
End;

function fCalculaContraste(corFundo, corFonte: TColor): Double;
  Var
    Color : LongInt;
    R, G, B : Byte;
    fltBrilhoFundo, fltBrilhoFonte: Double;
begin
  Color := ColorToRGB(corFundo);
  R := GetRValue(Color);
  G := GetGValue(Color);
  B := GetBValue(Color);
  fltBrilhoFundo := ((R * 299) + (G * 587) + (B * 114)) / 1000;

  Color := ColorToRGB(corFonte);
  R := GetRValue(Color);
  G := GetGValue(Color);
  B := GetBValue(Color);
  fltBrilhoFonte := ((R * 299) + (G * 587) + (B * 114)) / 1000;

  Result := Abs(fltBrilhoFonte - fltBrilhoFundo);
end;

function fCalculaMatiz(corFundo, corFonte: TColor): Double;
  Var
    Color : LongInt;
    R1, G1, B1 : Byte;
    R2, G2, B2 : Byte;
begin
  Color := ColorToRGB(corFundo);
  R1 := GetRValue(Color);
  G1 := GetGValue(Color);
  B1 := GetBValue(Color);

  Color := ColorToRGB(corFonte);
  R2 := GetRValue(Color);
  G2 := GetGValue(Color);
  B2 := GetBValue(Color);

  Result := Abs(R1- R2) + Abs(G1- G2) + Abs(B1- B2);
end;


procedure dxInitializeFuncoes;
Begin
  dxInitialize;
End;

procedure dxFinalizeFuncoes;
Begin
  StyleServices.ApplyThemeChange;
  dxFinalize;
End;

function fCfgSis(strCamCfg: String; varTipVar: TVarType = varString; strCodEmp: String = ''): Variant;
begin
  Result := objFuncaoSis.fICfgSis(strCamCfg, varTipVar, strCodEmp);
end;

function GetParamsExec: String;
  Var
    intParam : Integer;
begin
  Result := EmptyStr;

  For intParam := 0 To ParamCount Do
  Begin
    If fEmptyStr(Result) Then
      Result := ParamStr(intParam)
    Else
      Result := Result + ' ' + ParamStr(intParam);
  End;
end;

function fGetConnectionID(): String;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  Try
    qryAux.SQL.Add('SELECT CONNECTION_ID()');
    qryAux.Open;
    Result := qryAux.Fields[0].AsString;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure pLog(strValor: String; qrySQL: TUniQuery);
  const
    _FILE_LOG : String = '.\log_autcom.txt';
  Var
    stlLog : TStringList;
    blnLogHabilitadoPorArquivo : Boolean;

  function fFloatToStrPonto(valor: double; inte,deci: integer): string;
  begin
    Result := AnsiReplaceStr(FloatToStrF(valor, ffFixed, inte,deci),',','.');
  end;

  function fSQLBindLog(qryDados: TUniQuery): String;
    Var
      intCnt : Integer;
  begin
    Result := qryDados.SQL.Text;

    For intCnt := 0 To qryDados.ParamCount-1 Do
    Begin
      Case qryDados.Params[intCnt].DataType Of
        ftDateTime:
          Result := ReplaceStr(Result, ':' + qryDados.Params[intCnt].Name, QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss', qryDados.Params[intCnt].AsDateTime)));

        ftDate:
          Result := ReplaceStr(Result, ':' + qryDados.Params[intCnt].Name, QuotedStr(FormatDateTime('yyyy-mm-dd', qryDados.Params[intCnt].AsDate)));

        ftFloat:
          Result := ReplaceStr(Result, ':' + qryDados.Params[intCnt].Name, QuotedStr(fFloatToStrPonto(qryDados.Params[intCnt].AsFloat, 12, 2)));
        Else
          Result := ReplaceStr(Result, ':' + qryDados.Params[intCnt].Name, QuotedStr(qryDados.Params[intCnt].AsString));
      End;
    End;
  end;
begin
  blnLogHabilitadoPorArquivo := FileExists(ExtractFilePath(Application.ExeName) + '__hablog.txt');
  Try
    If (VS_HabLogArq = '') And (VS_strCodEmp <> '') Then
      VS_HabLogArq := fCfgSis('HABLOG', varString);
    If (blnLogHabilitadoPorArquivo) Then
      VS_HabLogArq := 'S';
  Except
    VS_HabLogArq := '';
    If (blnLogHabilitadoPorArquivo) Then
      VS_HabLogArq := 'S';
  End;

  If (VS_HabLogArq <> 'S') Then
    Exit;

  Try
    If (VS_CnxIdeLog = '') Then
      VS_CnxIdeLog := fGetConnectionID;
  Except
    VS_CnxIdeLog := 'SEM IDE';
  End;

  Try
    If (VS_PidIdeLog = '') Then
      VS_PidIdeLog := IntToStr(GetCurrentProcessId);
  Except
    VS_PidIdeLog := 'SEM PID';
  End;

  Try
    If (VS_ParamsExec = '') Then
      VS_ParamsExec := GetParamsExec;
  Except
    VS_ParamsExec := 'SEM PARAMS';
  End;

  stlLog := TStringList.Create;
  Try
    Try
      If FileExists(_FILE_LOG) Then
        stlLog.LoadFromFile(_FILE_LOG);
      stlLog.Add('ID Conexao: '+ fPadR(VS_CnxIdeLog, 10) +
                 ' -> PID: ' + fPadR(VS_PidIdeLog, 10) +
                 ' -> ' + FormatDateTime('dd/mm/yyyy hh:nn:ss:zzz', VS_Date + fTime()) +
                 ' -> ' + strValor +
                 ' -> ' + VS_ParamsExec
                 );
      if Assigned(qrySQL) then
        stlLog.Add(fSQLBindLog(qrySQL));

      stlLog.SaveToFile(_FILE_LOG);
    Finally
      FreeAndNil(stlLog);
    End;
  Except
  End;
end;

procedure ForceKill(AProcess: Integer);
  Var
    strComand : String;
begin
  strComand := 'taskkill /F /PID ' + AProcess.ToString;
  pLog('WinExec ' + strComand);
  WinExec(PAnsiChar(AnsiString(strComand)), SW_HIDE);
end;

function KillProcess(pid: cardinal; AForceKill: Boolean = True): Boolean;
var
  killer: THandle;
begin
  pLog('KillProcess ' + pid.ToString);
  killer := OpenProcess(PROCESS_TERMINATE, False, pid);
  Result := TerminateProcess(killer, 0);
  if not Result and AForceKill Then
    ForceKill(pid);
end;

{ TFinalizarAutcomMonitor }

constructor TFinalizarAutcomMonitor.Create(APID: Integer);
begin
  inherited Create(True);
  FreeOnTerminate := True;
  FBegin := Date + fTime(True);
  FPID := APID;
end;

destructor TFinalizarAutcomMonitor.Destroy;
begin
  Self.FInstance := nil;
  inherited;
end;

procedure TFinalizarAutcomMonitor.Execute;
begin
  inherited;
  pLog('TFinalizarAutcomMonitor.Execute');
  FRunning := True;
  While Not Terminated Do
  Begin
    If SecondsBetween(Date + fTime(True), FBegin) > FTimeout Then
    Begin
      KillProcess(FPID);
      Break;
    End;
  End;
  FRunning := False;
end;

class procedure TFinalizarAutcomMonitor.Monitorar;
begin
  If Not Assigned(Self.FInstance) Then
    Self.FInstance := TFinalizarAutcomMonitor.Create(GetCurrentProcessId);

  If Not Self.FInstance.FRunning Then
    Self.FInstance.Start;
end;

class procedure TFinalizarAutcomMonitor.Parar;
begin
  If Assigned(Self.FInstance) Then
    Self.FInstance.Terminate;
end;

function fCommaText(stlListSelecao: TStringList; blnQuoted: Boolean = False; strSeparator : String = ', '): String;
  Var
    intContador: Integer;
    strDado: String;
Begin
  Result := '';

  For intContador := 0 To stlListSelecao.Count - 1 Do
  Begin
    If blnQuoted Then
      strDado := QuotedStr(stlListSelecao[intContador])
    Else
      strDado := stlListSelecao[intContador];

    If intContador = 0 Then
      Result := strDado
    Else
      Result := Result + strSeparator +  strDado;
  End;
end;

function fTime(const AForceTime: Boolean = False) : TDateTime;
begin
  If (AForceTime) Then
    Result := untHorarioSistema.GetTime()
  Else
    Result := untHorarioSistema.GetTime(VS_strCodEmp, Database);
end;

function fSafeSQLValue(const AValue : String): String;
begin
  Result := AValue;
  If (AValue.Contains('\')) Then
  Begin
    // Procura uma barra invertida e coloca outra para não quebrar o SQL
    // Transforma \ em \\
    // Se já estiver \\ não faz nada
    Result := TRegEx.Replace(AValue, '(?<!\\)\\(?!\\)', '\\\\');
  End;
end;

function fGetUsuarioLogado(): String;
begin
  Result := strUsuarioLogado;
end;

function fGetEmpresaLogada(): String;
begin
  Result := VS_strCodEmp;
end;

procedure pTrimAppMemorySize;

   function fRetOpeMemTri: string;
     Var
       qryAux: TUniQuery;
   begin
     Result := '';

     qryAux := fCriaQuery(Nil);
     Try
       Try
         qryAux.Close;
         qryAux.SQL.Text := 'SELECT IFNULL(SIS_VALCFG, "N") FROM CFGSIS WHERE SIS_CODCFG = "CFG_MEMSWA" AND SIS_CODEMP = '+QuotedStr(fGetEmpresaLogada);
         qryAux.Open;
         If (Not qryAux.IsEmpty) Then
         Begin
           If (qryAux.Fields[0].AsString = 'S') Then
             Result := 'N';
         End;

         If (Result = '') Then
         Begin
           qryAux.Close;
           qryAux.SQL.Text := 'SELECT OPE_MEMTRI FROM CADOPE WHERE OPE_CODOPE = '+QuotedStr(fGetUsuarioLogado);
           qryAux.Open;

           If (Not qryAux.IsEmpty) Then
             Result := qryAux.Fields[0].AsString;
         End;
       Except
         //
       End;
     Finally
       qryAux.Free;
     End;
   end;

Begin
{$IFNDEF LINUX}
  If (VS_TrimMemorySize = 'N') Or
     (Length(fGetEmpresaLogada) <> 3) Or
     (Length(fGetUsuarioLogado) <> 3) Then
    Exit;

  If (VS_TrimMemorySize = '') Then
  Begin
    VS_TrimMemorySize := fRetOpeMemTri;

    If (Pos(AnsiUpperCase(VS_TrimMemorySize), 'S_N_') = 0) Then
      VS_TrimMemorySize := 'S';
  End;

  If (VS_TrimMemorySize = 'S') Then
  Begin
    Try
      EmptyWorkingSet(GetCurrentProcess);
    Except
      //
    End;
  End;
{$ENDIF}
End;

initialization
  VS_PidIdeLog := GetCurrentProcessId.ToString;

  EnableUniSQL := False;
  DLLProc:=@DLLMain;
  if Assigned(DLLProc) then
  begin
    DLLMain(DLL_PROCESS_ATTACH);
  end;

  frmModuloReplicacaoLibFuncoes := Nil;
  Database := Nil;

  VS_intPrecisaoMargemItem := -1;

  VS_GravaUsuRep  := '';
  VS_LogRepConId  := '';
  VS_UsuRepConId  := '';
  VS_LogRepCodOp  := '';
  VS_LogRepIdTra  := '';
  VS_ConnectionID := '';

Finalization

  If Assigned(Database) Then
    FreeAndNil(Database);

  If Assigned(frmModuloReplicacaoLibFuncoes) Then
    FreeAndNil(frmModuloReplicacaoLibFuncoes);

  TFinalizarAutcomMonitor.Parar;

end.
