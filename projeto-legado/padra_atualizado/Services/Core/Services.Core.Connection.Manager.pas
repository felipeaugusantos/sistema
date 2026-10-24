unit Services.Core.Connection.Manager;

interface

uses
  Services.Core.Connection.Interfaces, Services.Core.Settings, Data.DB,
  Services.Core.Types, Services.Core.Utils, Services.Core.Cache, System.Classes,
  System.IOUtils, System.Variants, System.Math, untTypesSistema,
  System.SysUtils, System.StrUtils, System.Generics.Collections, DateUtils;

Type
  TConnectionsManager = class sealed
  private
    FMREW: TMultiReadExclusiveWriteSynchronizer;
    FDicConn: TDictionary<NativeUInt, IConnection>;
    class var FConnectionUser: String;
    class var FConnectionPass: String;
  strict private
    function NewConnection(ATag: NativeUInt): IConnection;
  public
    constructor Create;
    destructor Destroy; override;

    function BeginConnection(ATag: NativeUInt = 0): IConnection;
    procedure EndConnection(ATag: NativeUInt = 0);

    function FindConnection(ATag: NativeUInt; var AConn: IConnection): Boolean;

    function CurrentConnection: IConnection;
  end;

procedure pIniciarConexao();
function MainConnection: IConnection;

function fInTransaction(): Boolean;
function fStartTransaction(): Boolean;
function fCommit(): Boolean;
function fRollback(): Boolean;

procedure pCarregaNre;

function fConexaoAtiva(): Boolean;

function fAjustaNovaSenhaComLetraMaiuscula(const ASenha: String): String ;

function fGetConnectionID(): String;

function fCriaQuery(): IQuery;
function fCriaQueryObject(AOwner: TComponent): TObject;
function fCriarQuery(ASQL: String): IQuery;
function fCriaScript(): IScript;
function fExecutaSQL(ASQL: String; blnRaise: Boolean = True): Boolean;

function fDropTable(strNomeTabela: String): Boolean;

function fGetMemoryTableName(strTabela: String): String;

function fRetSeqTmp: String;

function fExisteOrcamentoPendente(strCodCli, strNumOrc: String; strCodPro: String = ''): Boolean;
function fExistePedidoPendente(strCodCli, strNumDoc: String; strCodPro: String = ''): Boolean;
function fExisteFatGorPendente(strCodCli, strNumDoc: String; strEspDoc: String; strCodPro: String = ''): Boolean;

procedure pCriaAggregate(cdsClient: TUniClientDataSet; strNomCam, strNomAgg:String; strFormat: String = '#,##0.00');
function fIntAggregate(cdsClient: TUniClientDataSet; strNomCam: String): Integer;
function fDataAggregate(cdsClient: TUniClientDataSet; strNomCam: String): TDateTime;
function fDoubleAggregate(cdsClient: TUniClientDataSet; strNomCam: String): Double;

procedure pSetaClient(cdsClient: TDataSet);

procedure pDisableControls(dtsDataSet: TDataSet; Var prcScroll: TprcScroll);
procedure pEnableControls(dtsDataSet: TDataSet; Var prcScroll: TprcScroll; blnRefresh: Boolean = False);

function fTabelaVazia(strNomeTabela: string;
  blnSempreLerBanco: Boolean = True): Boolean;

function fTabelaExiste(strNomeTabela: String): Boolean;

function fCampoExiste(const strTabela, strCampo: String): Boolean;

function fTamCodIte: Integer;
function fRetPrecisaoMargemItem: Integer;

function fRetornaTipoDoCampo( strTabela : string = ''; strCampo: string = '' ) : String;

function fRetClaIpi(strCodIte: String): String;

function fRetornaInformacaoVenda(strNumDoc, strEspDoc, strCodEmp, strCampo: String): String; overload;
function fRetornaInformacaoVenda(strNumDoc, strEspDoc, strCodEmp, strCodCli, strCampo: String): String; overload;

function fDestacarDescontoDaCondicaoPagamentoNoCampoDescontoDosItensEmPromocao: Boolean;

function fRetValorCampoIteGer(strCodIte, strCodEmp, strTabela, strCampo: String): String;

function fRetDescPromocao(Const strCodPro: String): String;

function fVerificaIntegridade(strNomFrm,
                              strTabela: String;
                              qryTabOriginal: IQuery;
                              blnGravar: Boolean = True;
                              blnSoCriaTabela: Boolean = False;
                              strMotDel: String = '';
                              strOpeDel: String = '';
                              blnTabAux: Boolean = False;
                              strOpcDel: String = ''): String; overload;

function fVerificaIntegridade(strNomFrm,
                              strTabela: String;
                              qryTabOriginal: TDataSet;
                              blnGravar: Boolean = True;
                              blnSoCriaTabela: Boolean = False;
                              strMotDel: String = '';
                              strOpeDel: String = '';
                              blnTabAux: Boolean = False;
                              strOpcDel: String = ''): String; overload;

function fExtrairNomeTabelaSQL(strString: String): String;
function fExtrairNomeTabelaSQLExportacao(strString: String): String;

function fTabelaPermiteReplicarSempre(strNomTabela: String): Boolean;

function fTabelaReplica(strNomTabela: String): Boolean;

function fCampoTabela(strCampo: String; strNomTab: String;
  arrCampoChave: Array Of String; arrValorChave: Array Of Variant;
  blnSempreLerBanco: Boolean = True; strOrderBy: String = '';
  blnUsarMax: Boolean = False): Variant;

function fRetNomGeral(strCampoRetorno, strCampoPesquisa , strNomeTabela : String; fltCodigo: Double) : String;

function fRetCidEmpresa(strCodEmp: String): String;

function fCadEmpDes(strNomCampo, strCodEmp: String): String;

function fRetNomTabAuxMov(strNomTab: String): String;

function fRetNomeEmpresa: String; overload;
function fRetNomeEmpresa(strCodEmp: String): String; overload;

function fRetEmpresaFisica: String;
function fRetEmpAcessoUsuario(strCodOpe: String): String;

function fCadEmp(strNomCampo: String): String; Overload;
function fCadEmp(strNomCampo: String; qryGenEmp: IQuery): String; Overload;

function fRetUFEmpresa(strCodEmp: String = ''): String;

function fRetNomProduto(Const strCodIte: String): String;
function fRetGrupoItem(strCodIte: String): String;
function fRetPerComGrupo(strCodGru: String): Double;
function fRetMltVenItem(Const strCodIte: String): Double;
function fRetSiglaUnidade(const strCodUni: String): String;

function fRetNomCidade(strCodigo: String; intOpcao: Integer = 0): String;

function fRetEmpresasUsamPrecoMatriz(stlEmpresas: TStringList = Nil; strCodEmp: String = ''): String;

function fRetNomeMotorista(strCodMot: String; blnAtivos: Boolean = False): String;

function fRetNomeOperador(strCodOpe: String): String;
function fRetEmpresaOperador(strCodOpe: String): String;

function fRetNomTransportadora(strCodTra: String): String;

function fRetCodCnd(strCndPag: String): String; Overload;
function fRetCodCnd(strCndPag, strEmpAce: String): String; Overload;

function fRetDescFpg(Const strCodFpg: String): String;
function fRetDesRegiao(strCodReg: String): String;

Function fGetFornecedorFilial(strCodEmp: String): String;

function fGetFiltroClienteEmpresaIdentificadora(strCodOpe: String; blnComAnd: Boolean = True): String;

function fClienteFilial(strCodCli: String): Boolean;
function fRetAtividade(strCodAti: String): String;
function fRetNomCliente(Const strCodCli: String): String;
function fRetNomFantasia(Const strCodCli: String): String;
function fRetDescontoCliente(strCodCli: String): Double;
function fRetornaTelefonesCliente(Const strCodCli: String): String;
function fRetornaEmailsCliente(Const strCodCli: String): String;

function fRetNomFanFor(strCodFor: String): String;

function fRetNomLocFisica(Const strCodLoc: String; strCodEmp: String = ''; blnRefazConsulta: Boolean = False): String;

function fRetTipoDepartamentoVarios(strTipo: String): String;

function fFormataAutInc(intAutInc: Integer; strCodEmp: String;
  strProEmp: String = ''): String;

function fRetAutoIncrem(strNomeTabela, strCodEmp: String;
  intIntervalo: Integer = -1; blnUsaTransacaoCorrente: Boolean = False): String;

function fNextAutoIncrem(strAutInc: String): String;

function fRetTamCampo(strNomeTabela: String): Integer;

function fUsaProCodigo(strNomeTabela: String): Boolean;
function fInsereProCod(strNomTab: String; blnCodAut : Boolean = true): Boolean;
function fAtualizaProCod(strNomeTabela: String; AConexao: IConnection = nil; intQtdCod: Integer = 1): String;

function fRetRcxCon(strCodEmp: String = ''): String;

function fRetSequencial(strNomCam: String; strCodEmp: String = ''; intTamanho: Integer = 6; blnApenasObterValorSequencial: Boolean = False): String;
function fRetSequencialMovCar(strTblMovCar, strCodEmp: String): String; overload;
function fRetSequencialMovCar(strTblMovCar, strCodEmp: String; Var arrCartoes: TCartoesResumoCaixaArray): String; overload;
function fRetornaSequencialUnico(strNomSeq: String; strCodEmp: String = ''): Int64;

procedure pSetNaoReplicarConfig(strCodCfg: String);

function fGetProximoCodigoEmTransacao(strTabela: String; blnChecarSeExiste:Boolean = False; strCampo: String = ''): String;

function fTamDocCadRec: Integer;

function fRetClientesFilial: String;

function fRetDescricao(strCodigo, strNomTab, strCamCod, strCanDes: String): String;

function fRetNomBanco(Const strCodBco: String): String;

function fItemPigmento(strCodIte: String; Var strCodBas: String): Boolean;

function fRetHoraServidor: TTime;
function fRetDataServidor: TDate;
function fRetDtaHraServidor: TDateTime;

function fRetornaClienteFilial(strCodEmp: String; strTipo_FC: String = 'C'): String;
function fRetClienteConsumidor(strEstado:String = ''): String;

function fGetQuantidadeFatorDupont(const fltQuantidade: Double;
  const strCodIte: string): Double;

function fTabelaExportacaoTerceirosTinta(strTabela: String): Boolean;

function fGetQuantidadeFatorAxalta(const fltQuantidade: Double; const strCodIte: string): Double;

function fEhTabelaDeContabilidade(strTabela: string): boolean;

function fGravaLogBco(conConexao: IConnection; strComand: String): Boolean;

procedure pGravaLogContabil(conConexao: IConnection; strSQL, strTabela: string);

function fGravaInfUsuarioReplicacao(intSeqReplicacao: LongInt): Boolean;

function fGravaLogRep(conConexao: IConnection; strComand, strTabela, strCarreg: String): Boolean;

function fCurrentDate: String; overload;
function fCurrentDate(Const Value: TDateTime): String; overload;

function fCurrentDateTime: String; overload;
function fCurrentDateTime(Const Value: TDateTime): String; overload;

procedure pDefinirUsuarioConexao(AUser, APass: String);

procedure pGravarErro(GravarErro:Boolean; MensagemErro:String; strRelatorio: String='');

function fRetQtdElementosKey(strKey: String; wrdMes, wrdAno: Word; var strAutInc: String; blnRobo: Boolean): Integer;
Procedure pCloneDataSet(dtsDestino, dtsOrigem: TUniClientDataSet; blnComFomatacao: Boolean = False; blnComIndiceOrdGrid: Boolean = False);
procedure pCloneData(const objDestino, objOrigem: TUniClientDataSet; blnComIndiceOrdGrid: Boolean = False);

procedure pCopiaRegistroDataSet(dtsOrigem: TDataSet; dtsDestino: TDataSet; blnEdit: Boolean = False; blnInsert: Boolean = False);
function fCriaClientDataset(ASQL: String; AOwner: TComponent = Nil): TUniClientDataSet;
function fCriaClientDatset(qryOrigem: TDataSet; blnVazio: Boolean = False; AOwner: TComponent = Nil;
  blnRegistroAtual: Boolean = False; arrAddFields: TArray<TField> = Nil; arrSizeFields: TArray<TRecSizeField> = Nil): TUniClientDataSet;

function fClienteConsumidor(strNomCli: String; blnCliBal: Boolean = False; blnSeguradora: Boolean = False): Boolean;
function fFormataNome(strNome: String; blnSoPrimeiroNome: Boolean = False): String;

function fPermiteFaturamentoEntrega(strCodCli: String; strCampoDiaMes, strCampoDiaSemana: String; dtaData: TDateTime): Boolean;

Var
  VS_stlTabNre: TStringList;
  VS_intTamCadIte: Integer;
  VS_intTamDocCadRec: Integer;
  VS_intPrecisaoMargemItem: Integer;
  blnTransferindoCodigo: Boolean;
  objConnectionsManager: TConnectionsManager;

Const
  {**************************************}
  {* MATRIZ PARA COMANDOS A SEREM GRAV. *}
  {***********************************AF*}
  arrRep1: Array[0..13] Of String = ('INSERT', 'REPLACE', 'DELETE FROM', 'UPDATE', 'SET FOREIGN_KEY_CHECKS', 'CREATE TEMPORARY TABLE ESTANT', 'DROP TABLE IF EXISTS ESTANT',
                                     'CREATE TABLE TMP_NOVOITEEMB', 'CREATE TABLE TMP_NOVOITEGER', 'CREATE TABLE TMP_NOVOACAGER', 'CREATE TABLE TMP_NOVOCFGREL',
                                     'CREATE TABLE TMP_NOVOCNFBOL', 'CREATE TABLE TMP_NOVOLAYETI', 'CREATE TABLE TMP_NOVOCADLOT');

  arrRep2: Array[0..13] Of String = (' INTO ', ' INTO ' , ''           , ' SET ' , ''                      , '',                              '',
                                     '',  '', '', '',
                                     '',  '', '');

implementation

{ TConnectionManager }

uses Services.Core.Connection.UniDac, System.RegularExpressions;

procedure pDefinirUsuarioConexao(AUser, APass: String);
begin
  TConnectionsManager.FConnectionUser := AUser;
  TConnectionsManager.FConnectionPass := APass;
end;

function fGravaInfUsuarioReplicacao(intSeqReplicacao: LongInt): Boolean;
  Var
    strSql: string;
    qryLogRep: IQuery;
begin
  Result := True;

  Try
    strSql := '';
    strSql := strSql +  'INSERT INTO USUREP (';
    strSql := strSql +  '  LOG_SEQREP, ';
    strSql := strSql +  '  LOG_NOMMAQ, ';
    strSql := strSql +  '  LOG_NOMUSU, ';
    strSql := strSql +  '  LOG_NUM_IP, ';
    strSql := strSql +  '  LOG_MACADD) ';
    strSql := strSql +  'VALUES (      ';
    strSql := strSql +  '  :SEQREP,    ';
    strSql := strSql +  '  :NOMMAQ,    ';
    strSql := strSql +  '  :NOMUSU,    ';
    strSql := strSql +  '  :NUM_IP,    ';
    strSql := strSql +  '  :MACADD )   ';

    qryLogRep := objConnectionsManager.CurrentConnection.CreateQuery();

    With qryLogRep, SQL Do
    Begin
      Close;
      Clear;

      Add(strSql);

      ParamByName('SEQREP').Value := intSeqReplicacao;
      ParamByName('NOMMAQ').Value := VS_ComputerNetName;
      ParamByName('NOMUSU').Value := GetComputerUser;
      ParamByName('NUM_IP').Value := VS_IPAddressAsString;
      ParamByName('MACADD').Value := VS_MacAddress;

      ExecSql;
    End;

  Finally

  End;

end;

{**************************************}
{* GERA O LOG DE REPLICA«√O           *}
{***********************************AF*}
function fGravaLogRep(conConexao: IConnection; strComand, strTabela, strCarreg: String): Boolean;
Var
  qryLogRep: IQuery;
Begin
  Try
    qryLogRep := conConexao.CreateQuery();

    qryLogRep.Close;
    qryLogRep.SQL.Clear;
    qryLogRep.SQL.Add('SELECT * FROM LOGREP WHERE FALSE');
    qryLogRep.Open;

    With qryLogRep Do
    Begin
      Append;

      FieldByName('LOG_DTACAD').AsDateTime := VS_Date;
      FieldByName('LOG_HRACAD').AsDateTime := Time;
      FieldByName('LOG_COMAND').AsString   := strComand;
      FieldByName('LOG_TABELA').AsString   := strTabela;
      FieldByName('LOG_CARREG').AsString   := strCarreg;

      If (FindField('LOG_CODOPE') <> Nil) And (Not fEmptyStr(strLoginUsuarioLogado)) Then
        FieldByName('LOG_CODOPE').AsString := strLoginUsuarioLogado;

      Post;
    End;

    Result := fGravaInfUsuarioReplicacao(qryLogRep.FieldByName('LOG_CODIGO').Value);

    qryLogRep.Close;

  Except
    On E: Exception Do
      Raise Exception.Create('[GRAVALOGREP] - ' + E.message);
  End;
End;

function fEhTabelaDeContabilidade(strTabela: string): boolean;
begin
  Result := MatchStr(strTabela, ['LANCON', 'PARCON', 'HISPAD', 'PLANCO']);
end;

function fCampoExiste(const strTabela, strCampo: String): Boolean;
  Var
    qryAux: IQuery;
begin
  qryAux := fCriaQuery;
  qryAux.SQL.Add('DESC ' + strTabela);
  qryAux.Open;

  Result := False;
  While (Not qryAux.Eof) Do
  Begin
    If qryAux.FieldByName('Field').AsString = strCampo Then
    Begin
      Result := True;
      Break;
    End;

    qryAux.Next;
  End;
end;

function fTamCodIte: Integer;
Var
  strSQL: String;
  qryGen: IQuery;
  intPosInicial, intQtde: Integer;
begin

  Result := VS_intTamCadIte;

  If VS_intTamCadIte > 0 Then
    Exit;

  qryGen := fCriaQuery;

  strSQL := 'DESC CADITE;';

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;

    While (Not Eof) Do
    Begin
      If FieldByName('Field').asString = 'ITE_CODITE' Then
      Begin
        intPosInicial := Pos('(',FieldByName('Type').asString)+1;
        intQtde       := Pos(')',FieldByName('Type').asString) - intPosInicial;
        Result        := StrToInt( Copy( FieldByName('Type').asString, intPosInicial, intQtde ) );
        VS_intTamCadIte := Result;
        Break;
      End;
      Next;
    End;

  End;

End;

Procedure pVerificaIntegridadeComplementar(strNomFrm,
                                           strTabela: String;
                                           qryTabOriginal: TDataSet;
                                           blnGravar: Boolean = True;
                                           blnSoCriaTabela: Boolean = FALSE;
                                           strMotDel: String = '';
                                           strOpeDel: String = '');
  Var
    qryTabAux: IQuery;
    strTabAux: String;
Begin
  strTabAux := fRetNomTabAuxMov(strTabela);

  If fEmptyStr(strTabAux) Then
    Exit;

  qryTabAux := fCriaQuery;

  With qryTabAux, SQL Do
  Begin
    Clear;
    Add('SELECT * FROM');
    Add(strTabAux);
    Add('WHERE');
    Add('  AUX_SEQGER = :AUTINC');

    ParamByName('AUTINC').AsString := qryTabOriginal.FieldByName('AUTOINCREM').AsString;
    Open;

    If Not IsEmpty Then
      fVerificaIntegridade(strNomFrm,
                           strTabAux,
                           qryTabAux,
                           blnGravar,
                           blnSoCriaTabela,
                           strMotDel,
                           strOpeDel,
                           True);

  End;

  qryTabAux.Close;
End;

function fVerificaIntegridade(strNomFrm,
                              strTabela: String;
                              qryTabOriginal: IQuery;
                              blnGravar: Boolean = True;
                              blnSoCriaTabela: Boolean = False;
                              strMotDel: String = '';
                              strOpeDel: String = '';
                              blnTabAux: Boolean = False;
                              strOpcDel: String = ''): String;
begin
  Result := fVerificaIntegridade(strNomFrm,
                                 strTabela,
                                 TDataSet(qryTabOriginal.GetObject),
                                 blnGravar,
                                 blnSoCriaTabela,
                                 strMotDel,
                                 strOpeDel,
                                 blnTabAux,
                                 strOpcDel);

end;

function fVerificaIntegridade(strNomFrm,
                              strTabela: String;
                              qryTabOriginal: TDataSet;
                              blnGravar: Boolean = True;
                              blnSoCriaTabela: Boolean = False;
                              strMotDel: String = '';
                              strOpeDel: String = '';
                              blnTabAux: Boolean = False;
                              strOpcDel: String = ''): String;
  Var
    strSQL: String;
    intContador: Integer;
    qryGenIte: IQuery;
    qryGenTmp: IQuery;
    qryGenDel: IQuery;
    qryGenReq: IQuery;
    blnTeveNf: Boolean;
    blnGrvOpcDel: Boolean;

    function fRequeridoNatTabDel(strCampo:String):Boolean;
    begin
      Result:=False;

      If Not Assigned(qryGenReq) Then
      Begin
        qryGenReq := fCriaQuery;

        With qryGenReq Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('DESCRIBE DEL_' + strTabela);
          Open;
        End;
      End;

      If qryGenReq.Locate('Field', strCampo, [loCaseInSensitive]) Then
      Begin
        Result := (AnsiUpperCase(qryGenReq.FieldByName('Null').AsString) <> 'YES') And (AnsiUpperCase(qryGenReq.FieldByName('Null').AsString) <> 'Y');
      End;
    end;

    procedure pAdicionaPrimaryKeyDeletada(strTabela: String; qryTabela: IQuery);
      Var
        blnCriar  : Boolean;
        qryGenUpd : IQuery;
    begin
      Try
        qryGenUpd := fCriaQuery;

        qryTabela.First;
        blnCriar := (Not qryTabela.Locate('Key', 'PRI', []));

        If (blnCriar) Then
        Begin

          If (strTabela = 'NOTCOM') Then
          Begin
            qryGenUpd.Close;
            qryGenUpd.SQL.Clear;
            qryGenUpd.SQL.Add('ALTER TABLE DEL_' + strTabela + ' ADD PRIMARY KEY (GER_SEQGER, GER_CODEMP) ');
            qryGenUpd.ExecSQL;
            qryGenUpd.Close;
          End
          Else
          Begin
            qryGenUpd.Close;
            qryGenUpd.SQL.Clear;
            qryGenUpd.SQL.Add('ALTER TABLE DEL_' + strTabela + ' ADD PRIMARY KEY (AUTOINCREM) ');
            qryGenUpd.ExecSQL;
            qryGenUpd.Close;
          End;

        End;

      Finally

      End;

    end;

begin

  If fEmptyStr(strOpeDel) Then
    strOpeDel := strLoginUsuarioLogado;

  Try
    qryGenIte := fCriaQuery;
    qryGenTmp := fCriaQuery;
    qryGenDel := fCriaQuery;

    Result := '';
    blnTeveNf := False;
    blnGrvOpcDel := False;

    If (Not blnSoCriaTabela) And (qryTabOriginal.IsEmpty) Then
      Exit;

    Try
      {********************************}
      {* DESCRI«√O DA TABELA ORIGINAL *}
      {*****************************AF*}
      strSQL := '';
      strSQL := strSQL + 'DESCRIBE ';
      strSQL := strSQL + strTabela;
      With qryGenIte Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        Open;
      End;

      If fTabelaExiste('DEL_' + strTabela) Then
      Begin
        {***********************}
        {* SE A TABELA EXISTIR *}
        {********************AF*}
        With qryGenDel Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('DESCRIBE DEL_' + strTabela);
          Open;
        End;

        If qryGenDel.Locate('Field', 'AUTOINCREM', []) Then
        Begin
          {*********************************************}
          {* CASO A TABELA DE DELETADOS JA EXISTA, E   *}
          {* NAO TENHA PRIMARY KEY, CRIA A PRIMARY KEY *}
          {******************************************MV*}
          pAdicionaPrimaryKeyDeletada(strTabela, qryGenDel);
        End;

        blnGrvOpcDel := (Not strOpcDel.IsEmpty) And (qryGenDel.Locate('Field', 'OPCDEL', []));

        qryGenIte.First;
        qryGenDel.First;
        {***************************************}
        {* VERIRFICA SE OS CAMPOS EST√O IGUAIS *}
        {************************************AF*}
        For intContador := 0 To qryGenIte.RecordCount-1 Do
        Begin
          {********************}
          {* SE CAMPO EXISTIR *}
          {*****************AF*}
          If qryGenDel.Locate('Field', qryGenIte.FieldByName('Field').AsString, [loCaseInSensitive]) Then
          Begin
            {***************************}
            {* SE O TIPO FOR DIFERENTE *}
            {************************AF*}

            (*********************************************************************************************)
            (* RETIRADO POIS NAS TABELAS CRIADAS COMO CHARSET=utf8 O CHAR(X) ESTA FICANDO COM VARCHAR(X) *)
            (* FAZENDO COM QUE O MODIFY SEJA EXECUTADO A TODA HORA DEIXANDO A ROTINA LENTA               *)
            (******************************************************************************************LA*)

            {
            If qryGenIte.FieldByName('Type').AsString <> qryGenDel.FieldByName('Type').AsString Then
            Begin
              strSQL := '';
              strSQL := strSQL + 'ALTER TABLE DEL_';
              strSQL := strSQL + strTabela;
              strSQL := strSQL + ' MODIFY ';
              strSQL := strSQL + qryGenIte.FieldByName('Field').AsString;
              strSQL := strSQL + ' ';
              strSQL := strSQL + qryGenIte.FieldByName('Type').AsString;
              With qryGenTmp Do
              Begin
                Close;
                SQL.Clear;
                SQL.Add(strSQL);
                ExecSQL;
                qryGenIte.Next;
              End;
            End
            Else }
            Begin
              qryGenIte.Next;
            End;
          End
          Else
          {**************************}
          {* SE O CAMPO N√O EXISTIR *}
          {***********************AF*}
          Begin
            strSQL := '';
            strSQL := strSQL + 'ALTER TABLE DEL_';
            strSQL := strSQL + strTabela;
            strSQL := strSQL + ' ADD ';
            strSQL := strSQL + qryGenIte.FieldByName('Field').AsString;
            strSQL := strSQL + ' ';
            strSQL := strSQL + qryGenIte.FieldByName('Type').AsString;
            With qryGenTmp Do
            Begin
              Close;
              SQL.Clear;
              SQL.Add(strSQL);
              ExecSQL;
            End;
            qryGenIte.Next;
          End;
        End;
      End
      Else
      Begin
        {***************************}
        {* SE A TABELA N√O EXISTIR *}
        {************************AF*}
        strSQL := '';
        strSQL := strSQL + 'CREATE TABLE ';
        strSQL := strSQL + 'DEL_' + strTabela + ' ( ';
        qryGenIte.First;

        {********************************************************}
        {* PEGA OS CAMPOS DA TABELA ORIGINAL E COLOCA NA STRING *}
        {*****************************************************AF*}
        For intContador := 1 To qryGenIte.RecordCount Do
        Begin
          If intContador <> qryGenIte.RecordCount Then
          Begin
            strSQL := strSQL + qryGenIte.FieldByName('Field').AsString;
            strSQL := strSQL + ' ' + qryGenIte.FieldByName('Type').AsString + ', ';
          End
          Else
          Begin
            strSQL := strSQL + qryGenIte.FieldByName('Field').AsString;
            strSQL := strSQL + ' ' + qryGenIte.FieldByName('Type').AsString;
            strSQL := strSQL + ', OPEDEL VARCHAR(50)';
            strSQL := strSQL + ', DTADEL DATE';
            strSQL := strSQL + ', HORDEL VARCHAR(10) ';

            If Pos(strTabela, 'MOVGER_NOTGER_FATGOR_') > 0 Then
            Begin
              strSQL := strSQL + ', MOTDEL VARCHAR(255) ';
              strSQL := strSQL + ', OPCDEL VARCHAR(10) ';
            End;

            {*******************************************}
            {* CRIA PRIMARY KEY                        *}
            {****************************************MV*}
            If (Pos('AUTOINCREM', strSQL) > 0) Then
            Begin
              strSQL := strSQL + ', PRIMARY KEY (AUTOINCREM) ';
            End;

            strSQL := strSQL + ' ) ENGINE=InnoDB; ';

          End;
          qryGenIte.Next;
        End;

        With qryGenDel Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ExecSQL;
        End;

      End;

      If blnSoCriaTabela Then
      Begin
        Exit;
      End;

      {**************************************}
      {* GRAVA NA TABELA ORIGINAL OS CAMPOS *}
      {***********************************AF*}
      strSQL := '';
      strSQL := strSQL + 'REPLACE INTO DEL_' + strTabela + ' ( ';
      {******************}
      {* PEGA os CAMPOS *}
      {***************AF*}
      For intContador := 0 To qryTabOriginal.FieldCount-1 Do
      Begin
        If qryTabOriginal.Fields[intContador].FieldKind = fkData Then
        Begin
          strSQL := strSQL + qryTabOriginal.Fields[intContador].FieldName;
          {*****************************************************}
          {* ALTERADO PARA GRAVAR NOMFRM NO CADPAG E NO CTPDET *}
          {*25/04/2012***************************************JU*}
          If Pos('_NOMFRM', qryTabOriginal.Fields[intContador].FieldName) > 0 Then
            blnTeveNf := True;
        End;

        If intContador <> qryTabOriginal.FieldCount-1 Then
          If qryTabOriginal.Fields[intContador+1].FieldKind = fkData Then
            strSQL := strSQL + ', ';
      End;

      If (Not blnTeveNf) And (Pos(strTabela,'CADCHQ') > 0)  Then
        strSQL := strSQL + ', CHQ_NOMFRM';

      If Pos(strTabela, 'MOVGER_NOTGER_FATGOR_') > 0 Then
        strSQL := strSQL + ', OPEDEL, DTADEL, HORDEL, MOTDEL '+IIF(blnGrvOpcDel,' ,OPCDEL ',' ')+' ) VALUES ( '
      Else
        strSQL := strSQL + ', OPEDEL, DTADEL, HORDEL ) VALUES ( ';

      {*******************}
      {* PEGA OS VALORES *}
      {****************AF*}
      For intContador := 0 To qryTabOriginal.FieldCount-1 Do
      Begin
        {*************************************************}
        {* VERIFICA SE … DATA PARA FORMATAR CORRETAMENTE *}
        {**********************************************AF*}
        If qryTabOriginal.Fields[intContador].FieldKind = fkData Then
        Begin
          If (qryTabOriginal.Fields[intContador].DataType = ftDate)    Or
            (qryTabOriginal.Fields[intContador].DataType = ftDateTime) Then
          Begin
            {**********************}
            {* VERIFICA SE … NULO *}
            {*******************AF*}
            If Pos('_NOMFRM', qryTabOriginal.Fields[intContador].FieldName) > 0 Then
              strSQL := strSQL + QuotedStr(strNomfrm)

            Else If qryTabOriginal.Fields[intContador].AsString = '' Then
              strSQL := strSQL + 'NULL'
            Else
              strSQL := strSQL + QuotedStr(FormatDateTime('yyyy-mm-dd', qryTabOriginal.Fields[intContador].AsDateTime));

          End
          Else If (qryTabOriginal.Fields[intContador].DataType = ftTime) Then
            If qryTabOriginal.Fields[intContador].AsString = '' Then
              strSQL := strSQL + 'NULL'
            Else
              strSQL := strSQL + QuotedStr(FormatDateTime('hh:mm:ss', qryTabOriginal.Fields[intContador].AsDateTime))

          Else
            {**********************}
            {* VERIFICA SE … NULO *}
            {*******************AF*}
            If qryTabOriginal.Fields[intContador].AsString = '' Then
            Begin
              If Pos('_NOMFRM', qryTabOriginal.Fields[intContador].FieldName) > 0 Then
                strSQL := strSQL + QuotedStr(strNomfrm)
              Else If qryTabOriginal.Fields[intContador].Required Or
                      fRequeridoNatTabDel(qryTabOriginal.Fields[intContador].FieldName) Then
                strSQL := strSQL + QuotedStr('')
              Else
                strSQL := strSQL + 'NULL';
            End
            Else
              If (qryTabOriginal.Fields[intContador].DataType = ftString) Or
                 (qryTabOriginal.Fields[intContador].DataType = ftMemo) Or
                 ((qryTabOriginal.Fields[intContador].DataType = ftBlob) And
                  ((SameText(strTabela, 'CADMOD') OR SameText(strTabela, 'CADREL')))) Then
              Begin
                strSQL := strSQL + QuotedStr(qryTabOriginal.Fields[intContador].AsString);
              End

              Else If (qryTabOriginal.Fields[intContador].DataType = ftFloat)    Or
                      (qryTabOriginal.Fields[intContador].DataType = ftCurrency) Or
                      (qryTabOriginal.Fields[intContador].DataType = ftBCD)      Then
              Begin
                strSQL := strSQL + AnsiReplaceStr(qryTabOriginal.Fields[intContador].AsString, ',', '.');
              End

              Else
                strSQL := strSQL + qryTabOriginal.Fields[intContador].AsString;
        End;

        If intContador <> qryTabOriginal.FieldCount-1 Then
          If qryTabOriginal.Fields[intContador+1].FieldKind = fkData Then
            strSQL := strSQL + ', ';
      End;

      strSQL := strSQL + ', ' + QuotedStr(strOpeDel);
      strSQL := strSQL + ', ' + fCurrentDate + ' ';
      strSQL := strSQL + ', ' + QuotedStr(FormatDateTime('hh:mm:ss', VS_Date+Time));

      If Pos(strTabela, 'MOVGER_NOTGER_FATGOR') > 0 Then
        strSQL := strSQL + ', ' + QuotedStr(strMotDel) + IIF(blnGrvOpcDel,' ,'+QuotedStr(strOpcDel),' ') + ' )'
      Else
        strSQL := strSQL + ' )';

      If blnGravar Then
      Begin
        With qryGenDel Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ExecSQL;
        End;

        If Not blnTabAux Then
          pVerificaIntegridadeComplementar(strNomFrm,
                                           strTabela,
                                           qryTabOriginal,
                                           blnGravar,
                                           blnSoCriaTabela,
                                           strMotDel,
                                           strOpeDel);

      End
      Else
        Result := strSQL;

    Except
      On E:Exception Do
      Begin
        Raise Exception.Create(
          'Ocorreu um erro durante a gravaÁ„o do arquivo de deletado(s).' +
          #13 + E.Message + #13 + 'Tabela: ' + strTabela + '.');
      End;
    End;

  Finally

  End;

End;

function fTabelaExiste(strNomeTabela: String): Boolean;
Var
  strSQL: String;
  qryGenTmp: IQuery;

Begin

  Try
    qryGenTmp := objConnectionsManager.CurrentConnection.CreateQuery();

    Try

      If (fEmptyStr(strNomeTabela)) Then
      Begin
        Result := False;
        exit;
      End;

      strSQL := '';
      strSQL := strSQL + 'DESC ' + strNomeTabela;

      With qryGenTmp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        Open;

        Result := True;

        Close;
      End;

    Except
      On E: Exception do
      Begin
        Result := False;
      End;
    End;

  Finally

  End;

End;

function fDropTable(strNomeTabela: String): Boolean;
Var
  strSQL   : String;
  qryGenTmp: IQuery;
begin
  Result := True;

  qryGenTmp := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'DROP TABLE ' + strNomeTabela;

  If Not fTabelaExiste(strNomeTabela) Then
    Exit;

  With qryGenTmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;
  End;
end;

function fGetMemoryTableName(strTabela: String): String;
begin
  Result := 'TMP_' + strTabela + '_' + fTiraCaracEspeciais(GetIPAddress +
    IntToStr(Random(1000)) + FormatDateTime('yyyyMMddhhmmss', Now()), True, True,
    True, True, True, True);
end;

function fRetSeqTmp: String;
Var
  blnComita: Boolean;
  qryCfgSis: IQuery;
begin
  Try
    qryCfgSis := objConnectionsManager.CurrentConnection.CreateQuery;

    blnComita := False;

    If Not objConnectionsManager.CurrentConnection.InTransaction Then
    Begin
      objConnectionsManager.CurrentConnection.StartTransaction;
      blnComita := True;
    End;

    Try

      With qryCfgSis Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT                     ');
        SQL.Add('  SIS_VALCFG               ');
        SQL.Add('FROM                       ');
        SQL.Add('  CFGSIS                   ');
        SQL.Add('WHERE                      ');
        SQL.Add('  SIS_CODEMP = :CODEMP AND ');
        SQL.Add('  SIS_CODCFG = :CODCFG     ');
        SQL.Add('FOR UPDATE                 ');

        ParamByName('CODEMP').Value := VS_strCodEmp;
        ParamByName('CODCFG').Value := 'CFG_SEQTMP';
        Open;

        If Not fEmptyStr(FieldByName('SIS_VALCFG').AsString) Then
          Result := fStrZero(FieldByName('SIS_VALCFG').AsString, 7)
        Else
          Result := fStrZero('1', 7);

        fAtuCfgSis('SEQTMP', IntToStr(StrToInt(Result) + 1));

        Result := Result + VS_strCodEmp;
      End;

      If blnComita Then
        objConnectionsManager.CurrentConnection.Commit;

    Except
      On E: Exception Do
      Begin
        If blnComita Then
          objConnectionsManager.CurrentConnection.RollBack;

        Raise Exception.Create
          ('N„o consegui pegar o proximo sequencial de SEQTMP em CFGSIS. Tente novamente!');
      End;
    End;

  Finally

  End;

end;

function fFormataAutInc(intAutInc: Integer; strCodEmp: String;
  strProEmp: String = ''): String;
begin
  If fEmptyStr(strProEmp) Then
    strProEmp := fRetEmpresaFisica;

  Result := strProEmp + (IntToStr(intAutInc) + strCodEmp).PadLeft(17, '0');
end;

function fNextAutoIncrem(strAutInc: String): String;
begin
 Result := LeftStr(strAutInc, 3) + fPadL(IntToStr(StrToIntDef(Copy(strAutInc, 4, 14), 0) + 1), 14, '0') + RightStr(strAutInc, 3);
end;

function fRetAutoIncrem(strNomeTabela, strCodEmp: String;
  intIntervalo: Integer = -1; blnUsaTransacaoCorrente: Boolean = False): String;
Var
  LConnection: IConnection;

  intAutIncAtu: Integer;

  strSQL, strProEmp: String;
  qryGenCod: IQuery;

  LConID: NativeUInt;

  blnInTransaction: Boolean;

  function fAutoIncremCadastrado: Boolean;
  Var
    qryGenTmp: IQuery;

  begin
    Try

      qryGenTmp := objConnectionsManager.CurrentConnection.CreateQuery;

      With qryGenTmp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT SQL_NO_CACHE AUTOINCREM ' + '  FROM ' + strNomeTabela +
          ' WHERE AUTOINCREM = :AUTINC LIMIT 1');
        ParamByName('AUTINC').AsString := fFormataAutInc(intAutIncAtu,
          strCodEmp, strProEmp);
        Open;
        Result := (Not IsEmpty);
        Close;
      End;

    Finally

    End;

  end;

  function fGetUltAutIncPROCOD: Integer;
  Var
    strTmp: String;
    qryTmp: IQuery;
  Begin
    strTmp := '';
    strTmp := strTmp + ' SELECT ';
    strTmp := strTmp + '   MAX(MID(AUTOINCREM, 4, 14)) AUTINC ';
    strTmp := strTmp + ' FROM ';
    strTmp := strTmp + '   PROCOD ';
    strTmp := strTmp + ' WHERE ';
    strTmp := strTmp + '   PRO_CODEMP = "' + VS_strCodEmp + '" ';

    Try
      qryTmp := objConnectionsManager.CurrentConnection.CreateQuery;

      With qryTmp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strTmp);
        Open;

        If Not IsEmpty Then
          Result := FieldByName('AUTINC').AsInteger
        Else
          Result := 1;
      End;
    Except
      On E: Exception Do
        Raise Exception.Create('[fRetAutoIncrem] - ' + e.Message);
    End;

  End;

begin
  LConID := Random(99999999);
  If blnUsaTransacaoCorrente Then
  Begin
    qryGenCod := objConnectionsManager.CurrentConnection.CreateQuery;
    blnInTransaction := objConnectionsManager.CurrentConnection.InTransaction;
  End
  Else
  Begin
    LConnection := objConnectionsManager.BeginConnection(LConID);
    qryGenCod := LConnection.CreateQuery;
    blnInTransaction := False;
  End;

  Try
    Repeat

      If Not blnInTransaction Then
      Begin
        If assigned(LConnection) Then
          LConnection.StartTransaction
        Else
          objConnectionsManager.CurrentConnection.StartTransaction;
      End;

      Try

        strSQL := '';
        strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
        strSQL := strSQL + '  PRO_AUTINC AS AUTINC  ';
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
            If SameText(strNomeTabela, 'PROCOD') Then
            Begin
              Close;
              SQL.Clear;
              SQL.Add(' SELECT * FROM PROCOD');
              Open;

              Append;
              FieldByName('PRO_NOMARQ').AsString := 'PROCOD';
              FieldByName('PRO_CODSEQ').AsString := '001';
              FieldByName('PRO_TAMCOD').AsInteger := 3;
              FieldByName('AUTOINCREM').AsString := fRetEmpresaFisica +
                (IntToStr(fGetUltAutIncPROCOD) + VS_strCodEmp).PadLeft(17, '0');
              FieldByName('PRO_CODEMP').AsString := fRetEmpresaFisica;
              FieldByName('PRO_CODAUT').AsString := 'N';
              Post;

              Close;
              SQL.Clear;
              SQL.Add(' SELECT * FROM PROINC');
              Open;

              Append;
              FieldByName('PRO_NOMARQ').AsString := 'PROCOD';
              FieldByName('PRO_AUTINC').AsInteger := 1;
              FieldByName('AUTOINCREM').AsString := fRetEmpresaFisica +
                (IntToStr(fGetUltAutIncPROCOD) + VS_strCodEmp).PadLeft(17, '0');
              Post;

              Close;
              SQL.Clear;
              SQL.Add(strSQL);
              ParamByName('NOMARQ').AsString := strNomeTabela;
              Open;
            End
            Else
            Begin
              Close;
              Raise Exception.Create('A tabela ' + strNomeTabela +
                ' n„o est· cadastrada ' +
                'na tabela de PrÛximos Incrementos! Verifique.' + #13#10);
            End;
          End;

          strProEmp := fRetEmpresaFisica;

          If FieldByName('AUTINC').IsNull Then
            intAutIncAtu := 1
          Else
            intAutIncAtu := FieldByName('AUTINC').AsInteger;

          Close;
        End;

        strSQL := '';
        strSQL := strSQL + 'UPDATE ';
        strSQL := strSQL + '  PROINC ';
        strSQL := strSQL + 'SET ';

        If intIntervalo > 1 Then
        Begin

          If intAutIncAtu = 1 Then
            strSQL := strSQL + '  PRO_AUTINC = ' + IntToStr(intIntervalo + 1)
          Else
            strSQL := strSQL + '  PRO_AUTINC = PRO_AUTINC + ' +
              IntToStr(intIntervalo);

        End
        Else
        Begin

          If intAutIncAtu = 1 Then
            strSQL := strSQL + '  PRO_AUTINC = 2 '
          Else
            strSQL := strSQL + '  PRO_AUTINC = PRO_AUTINC + 1 ';

        End;

        strSQL := strSQL + '  WHERE ';
        strSQL := strSQL + '    PRO_NOMARQ = :NOMARQ ';

        With qryGenCod Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('NOMARQ').AsString := strNomeTabela;
          ExecSQL;
          Close;
        End;

        Result := strProEmp + (IntToStr(intAutIncAtu) + strCodEmp)
          .PadLeft(17, '0');

        If Not blnInTransaction Then
        Begin
          If assigned(LConnection) Then
            LConnection.Commit
          Else
            objConnectionsManager.CurrentConnection.Commit;
        End;

      Except
        On E: Exception Do
        Begin
          If assigned(LConnection) Then
            LConnection.RollBack
          Else
            objConnectionsManager.CurrentConnection.RollBack;

          Raise Exception.Create
            (E.Message +
            'N„o consegui pegar o proximo sequencial. Tente novamente!');
        End;
      End;

    Until (Not fAutoIncremCadastrado);
  Finally
    If Not blnUsaTransacaoCorrente Then
      objConnectionsManager.EndConnection(LConID);
  End;

end;

function fRetTamCampo(strNomeTabela: String): Integer;
  Var
    strSQL   : String;
    qryGenCod: IQuery;

begin
  Try

    qryGenCod := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  PRO_TAMCOD AS TAMCOD ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  PROCOD ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '  PRO_NOMARQ = :NOMARQ ';

    With qryGenCod Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NOMARQ').AsString := strNomeTabela;
      Open;
      If Not IsEmpty Then
        Result := FieldByName('TAMCOD').AsInteger
      Else
        Result := 0;
      Close;
    End;

  Finally

  End;

end;

function fGetProximoCodigoEmTransacao(strTabela: String; blnChecarSeExiste:Boolean = False; strCampo: String = ''): String;
  Var
    LConID: NativeUInt;
    LConnection: IConnection;
    intTentativas: Integer;
    strProCod,
    strProCodTmp: String;
    blnProcodCadastrado: Boolean;
    blnProcodAtualizado: Boolean;
    blnProcodUtilizado:  Boolean;
begin
  intTentativas := 0;
  LConID := Random(99999999);
  LConnection := objConnectionsManager.BeginConnection(LConID);
  Try
    If blnChecarSeExiste Then
    Begin
      repeat
        LConnection.StartTransaction;
        strProCodTmp := fPadL(fAtualizaProCod(strTabela, LConnection), fRetTamCampo(strTabela), '0');
        LConnection.Commit;

        strProCod := fCampoTabela(strCampo, strTabela , [strCampo], [strProCodTmp]);
        blnProcodCadastrado := (strProCod = strProCodTmp);

        strProCod := fCampoTabela('PRO_CODSEQ', 'PROCOD', ['PRO_NOMARQ'], [strTabela], False);
        blnProcodUtilizado := StrToInt64Def(strProCod, 0) > StrToInt64Def(strProCodTmp, 0);

        blnProcodAtualizado := ((Not blnProcodCadastrado) And (Not blnProcodUtilizado));

        Inc(intTentativas);
        If Not blnProcodAtualizado Then
          Sleep(500);

      until blnProcodAtualizado  or (intTentativas = 50);

      Result := strProCodTmp;
    End
    Else
    Begin
      LConnection.StartTransaction;
      Result := fPadL(fAtualizaProCod(strTabela, LConnection), fRetTamCampo(strTabela), '0');
      LConnection.Commit;
    End;
  Finally
    objConnectionsManager.EndConnection(LConID);
  End;
end;

function fTamDocCadRec: Integer;
var
  qryAux: IQuery;
Begin
  Result := VS_intTamDocCadRec;
  If (Result = 6) Or (Result = 12) Then
    Exit;

  Result := 6;
  VS_intTamDocCadRec := Result;

  qryAux := fCriaQuery();
  qryAux.SQL.Text := 'DESC CADREC';
  qryAux.Open;

  While (Not qryAux.Eof) Do
  Begin
    If qryAux.FieldByName('Field').AsString = 'CTR_NUMDUP' Then
    Begin
      If UpperCase(qryAux.FieldByName('Type').AsString) = 'VARCHAR(6)' Then
        Result := 6
      Else
        Result := 12;

      VS_intTamDocCadRec := Result;
      Break;
    End;

    qryAux.Next;
  End;
End;

function fRetornaSequencialUnico(strNomSeq: String; strCodEmp: String = ''): Int64;
  Var
    blnComita: Boolean;
    qryCfgSis: IQuery;
    blnGravaLog: Boolean;
begin
  blnGravaLog := VS_blnGravaLogTransacao;
  Try
    If fEmptyStr(strCodEmp) Then
      strCodEmp := VS_strCodEmp;

    qryCfgSis := fCriaQuery;

    blnComita := False;

    If Not fInTransaction Then
    Begin
      VS_blnGravaLogTransacao := False;
      fStartTransaction;
      blnComita := True;
    End;

    Try
      With qryCfgSis Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT                     ');
        SQL.Add('  SIS_VALCFG               ');
        SQL.Add('FROM                       ');
        SQL.Add('  CFGSIS                   ');
        SQL.Add('WHERE                      ');
        SQL.Add('  SIS_CODEMP = :CODEMP AND ');
        SQL.Add('  SIS_CODCFG = :CODCFG     ');
        SQL.Add('FOR UPDATE                 ');

        ParamByName('CODEMP').Value := strCodEmp;
        ParamByName('CODCFG').Value := 'CFG_'+ strNomSeq;
        Open;

        pSetNaoReplicarConfig('CFG_' + strNomSeq);

        If Not fEmptyStr(FieldByName('SIS_VALCFG').AsString) Then
          Result := FieldByName('SIS_VALCFG').AsLargeInt
        Else
          Result := 1;

        fAtuCfgSis(strNomSeq, IntToStr(Result+1), strCodEmp);
      End;

      If blnComita Then
        fCommit;
    Except
      On E: Exception Do
      Begin
        If blnComita Then
          fRollBack;
        Raise Exception.Create('N„o consegui pegar o proximo sequencial de '+ strNomSeq
          +' em CFGSIS. Tente novamente!' + sLineBreak + E.Message);
      End;
    End;
    If blnComita Then
      fCommit;
  Finally
    VS_blnGravaLogTransacao := blnGravaLog;
  End;
End;

function fRetSequencialMovCar(strTblMovCar, strCodEmp: String; Var arrCartoes: TCartoesResumoCaixaArray): String;
  Var
    blnComitar: Boolean;
    intContador: Integer;
begin
  blnComitar := (Not objConnectionsManager.CurrentConnection.InTransaction);

  Try
    If blnComitar Then
    Begin
      fStartTransaction;
    End;

    For intContador := 0 To Length(arrCartoes) -1 Do
      arrCartoes[intContador].strNumDup := fRetSequencialMovCar(strTblMovCar, strCodEmp);

    If blnComitar Then
      fCommit;

  Except
    On E: Exception Do
    Begin
      If blnComitar Then
        fRollback;
      Raise;
    End;
  End;

end;

procedure pSetNaoReplicarConfig(strCodCfg: String);
Var
  qryGen: IQuery;
begin
  If Not fTabelaExiste('CFGAUX') Then Exit;
  qryGen := fCriaQuery;
  Try
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT * FROM CFGAUX WHERE CFG_CODCFG = "' + strCodCfg + '"');
    qryGen.Open;

    If Not qryGen.IsEmpty Then
      If qryGen.FieldByName('CFG_PERREP').AsString <> 'N' Then
      Begin
        qryGen.Edit;
        qryGen.FieldByName('CFG_PERREP').AsString := 'N';
        qryGen.Post;
      End;

    qryGen.Close;
  Finally

  End;
end;

function fRetSequencial(strNomCam: String; strCodEmp: String = ''; intTamanho: Integer = 6; blnApenasObterValorSequencial: Boolean = False): String;
var
  blnComita: Boolean;
  qryCfgSis: IQuery;
begin
  Try
    If fEmptyStr(strCodEmp) Then
      strCodEmp := VS_strCodEmp;

    fCfgSis(strNomCam, varString, strCodEmp);//Necessario para criar a configuracao quando nao existir

    qryCfgSis := fCriaQuery;

    blnComita := False;

    If (Not fInTransaction) Then
    Begin
      fStartTransaction;
      blnComita := True;
    End;

    Try

      With qryCfgSis Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT  SQL_NO_CACHE       ');
        SQL.Add('  SIS_VALCFG               ');
        SQL.Add('FROM                       ');
        SQL.Add('  CFGSIS                   ');
        SQL.Add('WHERE                      ');
        SQL.Add('  SIS_CODEMP = :CODEMP AND ');
        SQL.Add('  SIS_CODCFG = :CODCFG     ');
        SQL.Add('FOR UPDATE                 ');

        ParamByName('CODEMP').Value := strCodEmp;
        ParamByName('CODCFG').Value := 'CFG_' + strNomCam;
        Open;

        pSetNaoReplicarConfig('CFG_' + strNomCam);

        If Not fEmptyStr(FieldByName('SIS_VALCFG').AsString) Then
          Result := fStrZero(FieldByName('SIS_VALCFG').AsString, intTamanho)
        Else
          Result := fStrZero('1', intTamanho);

        if not blnApenasObterValorSequencial then
          fAtuCfgSis(strNomCam, IntToStr(StrToInt64Def(Result, 0)+1), strCodEmp);

      End;

      If blnComita Then
        fCommit;

    Except
      On E: Exception Do
      Begin
        If blnComita Then
          fRollBack;

        Raise Exception.Create('N„o consegui pegar o proximo sequencial de ' + strNomCam + ' em CFGSIS. Tente novamente!');
      End;
    End;

  Finally

  End;
end;

function fRetSequencialMovCar(strTblMovCar, strCodEmp: String): String;
  Var
    strSQL   : String;
    blnExiste: Boolean;
    qryGenCar: IQuery;
begin
  Try

    qryGenCar := fCriaQuery;

    Repeat

      Result := RightStr(fAtualizaProCod(strTblMovCar), fTamDocCadRec);

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  COUNT(*) AS QTD ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  ' + strTblMovCar + ' ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  MCA_NUMDUP = :NUMDUP AND ';
      strSQL := strSQL + '  MCA_CODEMP = :CODEMP     ';

      With qryGenCar Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDUP').AsString := Result;
        ParamByName('CODEMP').AsString := strCodEmp;
        Open;
        blnExiste := (FieldByName('QTD').AsInteger > 0);
        Close;
      End;

    Until (Not blnExiste);

  Finally

  End;

end;

function fRetRcxCon(strCodEmp: String = ''): String;
  Var
    blnComita: Boolean;
    qryCfgSis: IQuery;
begin
  Try
    If fEmptyStr(strCodEmp) Then
      strCodEmp := VS_strCodEmp;

    qryCfgSis := fCriaQuery;

    blnComita := False;

    If Not objConnectionsManager.CurrentConnection.InTransaction Then
    Begin
      fStartTransaction;
      blnComita := True;
    End;

    Try

      With qryCfgSis Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT                     ');
        SQL.Add('  SIS_VALCFG               ');
        SQL.Add('FROM                       ');
        SQL.Add('  CFGSIS                   ');
        SQL.Add('WHERE                      ');
        SQL.Add('  SIS_CODEMP = :CODEMP AND ');
        SQL.Add('  SIS_CODCFG = :CODCFG     ');
        SQL.Add('FOR UPDATE                 ');

        ParamByName('CODEMP').Value := strCodEmp;
        ParamByName('CODCFG').Value := 'CFG_RCXCON';
        Open;

        If Not fEmptyStr(FieldByName('SIS_VALCFG').AsString) Then
          Result := fStrZero(FieldByName('SIS_VALCFG').AsString, 10)
        Else
          Result := fStrZero('1', 10);

        fAtuCfgSis('RCXCON', IntToStr(StrToIntDef(Result, 0)+1), strCodEmp);

      End;

      If blnComita Then
        fCommit;

    Except
      On E: Exception Do
      Begin
        If blnComita Then
          fRollBack;

        Raise Exception.Create('N„o consegui pegar o prÛximo sequencial de RCXCON em CFGSIS. Tente novamente!');
      End;
    End;

  Finally

  End;

end;

Function fInsereProCod(strNomTab: String; blnCodAut : Boolean = true): Boolean;
  Var
    qryGen: IQuery;
Begin
  Try
    qryGen := fCriaQuery;

    With qryGen, SQL Do
    Begin
      Clear;
      Add('SELECT * FROM PROCOD ');
      Add('WHERE PRO_NOMARQ = :NOMARQ');

      ParamByName('NOMARQ').AsString := strNomTab;

      Open;

      If IsEmpty Then
      Begin

        Clear;
        Add('INSERT INTO PROCOD (PRO_NOMARQ, PRO_CODSEQ, PRO_TAMCOD, PRO_CODAUT, AUTOINCREM, PRO_CODEMP) ');
        Add('VALUES(:NOMARQ, "000000000001", 12, ' + IIF(blnCodAut, '"S"', '"N"') + ', :AUTINC, :CODEMP)');
        ParamByName('CODEMP').AsString := fRetEmpresaFisica;
        ParamByName('NOMARQ').AsString := strNomTab;
        ParamByName('AUTINC').AsString := fRetAutoIncrem('PROCOD', VS_strCodEmp);
        ExecSQL;

        Clear;
        Add('INSERT INTO PROINC (PRO_NOMARQ, PRO_AUTINC, AUTOINCREM) ');
        Add('VALUES(:NOMARQ, "1", :AUTINC)');
        ParamByName('NOMARQ').AsString := strNomTab;
        ParamByName('AUTINC').AsString := fRetAutoIncrem('PROCOD', VS_strCodEmp);
        ExecSQL;
      End;

    End;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Raise;
    End;
  End;
End;

function fAtualizaProCod(strNomeTabela: String; AConexao: IConnection = nil; intQtdCod: Integer = 1): String;
  Var
    strSQL        : String;
    intCodigoAtual: Int64;
    intTamCodigo  : Integer;
    blnComita     : Boolean;
    qryGenCod     : IQuery;

begin
  If AConexao = nil then
    AConexao := objConnectionsManager.CurrentConnection;

  qryGenCod := AConexao.CreateQuery();

  blnComita := False;

  If Not AConexao.InTransaction Then
  Begin
    AConexao.StartTransaction;
    blnComita := True;
  End;

  Try

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  PRO_CODSEQ AS CODSEQ, ';
    strSQL := strSQL + '  PRO_TAMCOD AS TAMCOD ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  PROCOD ';
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
        Raise Exception.Create('A tabela ' + strNomeTabela + ' n„o est· cadastrada ' +
                               'na tabela de PrÛximos Codigos! Verifique.' + #13#10);

      intCodigoAtual := StrToInt64(FieldByName('CODSEQ').AsString);
      intTamCodigo   := FieldByName('TAMCOD').AsInteger;
      Close;
    End;

  Except
    On E: Exception Do
    Begin
      If blnComita Then
        AConexao.Rollback;

      Raise Exception.Create(E.Message + 'N„o consegui pegar o proximo sequencial. Tente novamente!');
    End;
  End;

  Result := IntToStr(intCodigoAtual).PadLeft(intTamCodigo, '0');

  strSQL := '';
  strSQL := strSQL + ' UPDATE ';
  strSQL := strSQL + '   PROCOD ';
  strSQL := strSQL + ' SET ';
  strSQL := strSQL + '   PRO_CODSEQ = :CODSEQ ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   PRO_NOMARQ = :NOMARQ ';

  With qryGenCod Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODSEQ').AsString := IntToStr(intCodigoAtual+intQtdCod).PadLeft(IntTamCodigo, '0');
    ParamByName('NOMARQ').AsString := strNomeTabela;
    ExecSQL;
    Close;
  End;

  If blnComita Then
    AConexao.Commit;
end;

function fRetNomeEmpresa: String;
begin
  Result := fRetNomeEmpresa(VS_strCodEmp);
end;

function fRetNomeEmpresa(strCodEmp: String): String; overload;
begin
  Result := '';

  If (fEmptyStr(strCodEmp)) Then
    Exit;

  Result := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [strCodEmp], False);
End;

Function fRetEmpresaFisica: String;
Begin
  Result := fCampoTabela('PRO_CODEMP', 'PROCOD', ['PRO_NOMARQ'], ['MOVGER'], False);
End;

function fRetEmpAcessoUsuario(strCodOpe: String): String;
begin
  Result := fCampoTabela('OPE_EMPACE', 'CADOPE', ['OPE_CODOPE'], [strCodOpe], False);
end;

function fCadEmp(strNomCampo: String; qryGenEmp: IQuery): String;
  Var
    strSQL   : String;
    strCodEmp: String;
begin
  Try
    strCodEmp := VS_strCodEmp;

    strSQL := '';
    strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '   CADEMP.*, ';
    strSQL := strSQL + '   CID_NOMCID AS "EMP_NOMCID", ';
    strSQL := strSQL + '   CID_ESTADO AS "EMP_ESTADO", ';
    strSQL := strSQL + '   CONCAT(EMP_ENDERE, ", ", EMP_ENDNUM, ", ", EMP_BAIRRO, " - " , CID_NOMCID, "/", CID_ESTADO) AS EMP_ENDERECO ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADEMP ';
    strSQL := strSQL + '   JOIN CADCID ON EMP_CODCID = CID_CODCID ';
    strSQL := strSQL + ' WHERE EMP_CODEMP = :CODEMP ';

    With qryGenEmp Do
    Begin

      If (Not Active) Or IsEmpty Or (strCodEmp <> FieldByName('EMP_CODEMP').AsString) Then
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODEMP').AsString := strCodEmp;
        Open;
      End;

      If FieldByName('EMP_' + strNomCampo).IsNull Then
      Begin
        Result := '';
      End
      Else
      Begin
        Result := FieldByName('EMP_' + strNomCampo).Value;
      End;

    End;

  Finally

  End;

end;

function fRetUFEmpresa(strCodEmp: String = ''): String;
begin
  If strCodEmp = '' Then
    strCodEmp := VS_strCodEmp;
  Result := fCampoTabela('CID_ESTADO', 'CADEMP INNER JOIN CADCID ON CID_CODCID = EMP_CODCID', ['EMP_CODEMP'], [strCodEmp], False);
end;

function fCadEmp(strNomCampo: String): String;
const
  SQL_FROM = 'CADEMP JOIN CADCID ON EMP_CODCID = CID_CODCID';
  SQL_ENDERECO = 'CONCAT(EMP_ENDERE, ", ", EMP_ENDNUM, ", ", EMP_BAIRRO, " - " , CID_NOMCID, "/", CID_ESTADO)';
begin
  if strNomCampo = 'NOMCID' then
    Result := fCampoTabela('CID_NOMCID', SQL_FROM, ['EMP_CODEMP'], [VS_strCodEmp], False)
  else if strNomCampo = 'ESTADO' then
    Result := fCampoTabela('CID_ESTADO', SQL_FROM, ['EMP_CODEMP'], [VS_strCodEmp], False)
  else if strNomCampo = 'ENDERECO' then
    Result := fCampoTabela(SQL_ENDERECO, SQL_FROM, ['EMP_CODEMP'], [VS_strCodEmp], False)
  else
    Result := fCampoTabela('EMP_' + strNomCampo, SQL_FROM, ['EMP_CODEMP'], [VS_strCodEmp], False);
end;

function fRetNomProduto(Const strCodIte: String ): String;
Begin
  Result := fCampoTabela('ITE_DESITE', 'CADITE', ['ITE_CODITE'], [strCodIte], False); //Para ler a descriÁ„o do buffer
End;

function fRetGrupoItem(strCodIte: String): String;
Begin
  Result := fCampoTabela('ITE_CODGRU', 'CADITE', ['ITE_CODITE'], [strCodIte], False);
End;

function fRetPerComGrupo(strCodGru: String): Double;
begin
  Result := 0;

  If fEmptyStr(strCodGru) Then
    Exit;

  Result := fCampoTabela('GRU_PERCOM', 'CADGRU', ['GRU_CODGRU'], [strCodGru], False);
end;

function fRetMltVenItem(Const strCodIte: String): Double;
  Var
    strSQL   : String;
    qryGenIte: IQuery;
Begin
  Try

    qryGenIte := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  ITE_MLTVEN ';
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

      If Not IsEmpty Then
        Result := FieldByName('ITE_MLTVEN').AsFloat
      Else
        Result := 0;

      Close;
    End;

  Finally

  End;

End;

function fRetSiglaUnidade(const strCodUni: String): String;
begin
  Result := '';
  If fEmptyStr(strCodUni) Then
    Exit;
  Result := fCampoTabela('UNI_SIGUNI', 'CADUNI', ['UNI_CODUNI'], [strCodUni], False);
end;

function fRetNomCidade(strCodigo: String; intOpcao: Integer = 0): String;
Begin

  Result := '';

  If fEmptyStr(strCodigo) Then
    Exit;

  If (intOpcao = 0) Then
    Result := fCampoTabela('CID_NOMCID', 'CADCID', ['CID_CODCID'], [strCodigo], False)
  Else
    Result := fCampoTabela('CID_ESTADO', 'CADCID', ['CID_CODCID'], [strCodigo], False);

End;

{*******************************************}
{* FUNCAO QUE RETORNA LISTA DE EMPRESAS QUE*}
{* UTILIZAM OS PRECOS DA EMPRESA MATRIZ,   *}
{* NO CASO SE A EMRESA ATUAL FOR A PROPRIA *}
{****************************************JC*}
function fRetEmpresasUsamPrecoMatriz(stlEmpresas: TStringList = Nil; strCodEmp: String = ''): String;
  Var
    qryGenEmp: IQuery;
    strSQL   : String;
    blnSomenteMatriz: Boolean;
begin

  blnSomenteMatriz := (fCfgSis('REPPRC') = '1');

  If strCodEmp <> '' Then
    Result := strCodEmp + '_'
  Else
    Result := VS_strCodEmp + '_';

  If Assigned(stlEmpresas) Then
  Begin
    stlEmpresas.Clear;
    stlEmpresas.Add(VS_strCodEmp);
  End;

  {*******************************************}
  {* CASO SEJA EMPRESA GERENCIAL E SOMENTE A *}
  {* MESMA POSSA REPLICAR OS PRECOS, OU      *}
  {* QUALQUER EMPRESA REPLICA OS PRECOS      *}
  {****************************************JC*}
  If (fCfgSis('EMPGER', varBoolean) And blnSomenteMatriz) Or (Not blnSomenteMatriz) Then
  Begin

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  EMP_CODEMP ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP <> :CODEMP AND ';
    strSQL := strSQL + '  EMP_PREMAT = "S" ';

    (**********************************************************)
    (* SE UTILIZA DEFINI«√O DE QUEM … A MATRIZ                *)
    (* PEGA TODAS AS LOJAS QUE A EMPRESA CORRENTE COMO MATRIZ *)
    (*******************************************************LA*)
    If fCfgSis('INFMAT', varBoolean) Then
    Begin
      strSQL := strSQL + ' AND EMP_CODMAT = :CODEMP ';
    End;

    qryGenEmp:= fCriaQuery;

    With qryGenEmp Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      If strCodEmp <> '' Then
        ParamByName('CODEMP').AsString := strCodEmp
      Else
        ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      While Not Eof Do
      Begin

        Result := Result + FieldByName('EMP_CODEMP').AsString;

        If RecNo < RecordCount Then
          Result := Result + '_';

        If Assigned(stlEmpresas) Then
          stlEmpresas.Add(FieldByName('EMP_CODEMP').AsString);

        Next;
      End;

    End;

  End;

end;

function fRetNomeOperador(strCodOpe: String): String;
begin
  Result := fCampoTabela('OPE_NOMOPE', 'CADOPE', ['OPE_CODOPE'], [strCodOpe], False);
end;

function fRetEmpresaOperador(strCodOpe: String): String;
begin
  Result := fCampoTabela('OPE_CODEMP', 'CADOPE', ['OPE_CODOPE'], [strCodOpe]);
end;

function fRetDescFpg(Const strCodFpg: String): String;
Begin
  Result := '';
  If fEmptyStr(strCodFpg) Then
    Exit;
  Result := fCampoTabela('FPG_DESCRI', 'CADFPG', ['FPG_CODIGO'], [strCodFpg], False);
End;

function fRetDesRegiao(strCodReg: String): String;
Begin
  Result := '';
  If fEmptyStr(strCodReg) Then
    Exit;
  Result := fCampoTabela('REG_DESREG', 'CADREG', ['REG_CODREG'], [strCodReg], False);
End;

function fClienteFilial(strCodCli: String): Boolean;
begin
  Result := False;
  If fEmptyStr(strCodCli) Then
    Exit;
  Result := (Not fEmptyStr(strCodCli)) And
            (fCampoTabela('COUNT(*)', 'CADEMP', ['EMP_CLIFIL'], [strCodCli], False) > 0);
end;

function fRetAtividade(strCodAti: String): String;
Begin
  Result := '';
  If fEmptyStr(strCodAti) Then
    Exit;
  Result := fCampoTabela('ATI_DESATI', 'CADATI', ['ATI_CODATI'], [strCodAti], False);
End;

function fGetFiltroClienteEmpresaIdentificadora(strCodOpe: String; blnComAnd: Boolean = True): String;
begin
  Result := '';

  if blnComAnd Then
    Result := Result + ' AND ';

  If fCfgSis('IDEEMP', VarBoolean) Then
  Begin
    Result := Result + ' ( ';
    Result := Result + '   (LOCATE(CLI_EMPIDE,' + QuotedStr(fRetEmpAcessoUsuario(strCodOpe)) + ') > 0) OR ';
    Result := Result + '   (CLI_EMPIDE IS NULL) OR ';
    Result := Result + '   (CLI_EMPIDE = "") ';
    Result := Result + ' ) ';
  End
  Else
    Result := Result + ' TRUE ';
end;

function fRetNomFantasia(Const strCodCli: String): String;
Begin
  Result := fCampoTabela('CLI_FANSOB', 'CADCLI', ['CLI_CODCLI'], [strCodCli]);
End;

function fRetNomCliente(Const strCodCli: String): String;
var
  qryAux: IQuery;
Begin
  If fCfgSis('IDEEMP', VarBoolean) Then
  Begin
    qryAux := fCriaQuery();
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT CLI_NOMCLI');
    qryAux.SQL.Add('FROM CADCLI');
    qryAux.SQL.Add('WHERE CLI_CODCLI = :CODCLI');
    qryAux.SQL.Add(fGetFiltroClienteEmpresaIdentificadora(strLoginUsuarioLogado));
    qryAux.ParamByName('CODCLI').AsString := strCodCli;
    qryAux.Open;
    Result := qryAux.FieldByName('CLI_NOMCLI').AsString;
  End
  Else
  Begin
    Result := fCampoTabela('CLI_NOMCLI', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);
  End;
End;

function fRetDescontoCliente(strCodCli: String): Double;
Begin
  Result := 0;
  If fEmptyStr(strCodCli) Then
    Exit;
  Result := fCampoTabela('CLI_DESCON', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);
End;

function fRetornaTelefonesCliente(Const strCodCli: String): String;
var
  qryTelefones: IQuery;
begin
  qryTelefones := fCriaQuery;

  Result := EmptyStr;

  qryTelefones.Close;
  qryTelefones.SQL.Clear;
  qryTelefones.SQL.Add('SELECT CLI_FONE01, CLI_FONE02, CLI_CELULA');
  qryTelefones.SQL.Add('FROM CADCLI');
  qryTelefones.SQL.Add('WHERE CLI_CODCLI = :CODCLI');
  qryTelefones.ParamByName('CODCLI').AsString := strCodCli;
  qryTelefones.Open;

  if qryTelefones.IsEmpty then
    Exit;

  if not fEmptyStr(qryTelefones.FieldByName('CLI_FONE01').AsString) then
    Result := Result + qryTelefones.FieldByName('CLI_FONE01').AsString;

  if not fEmptyStr(qryTelefones.FieldByName('CLI_FONE02').AsString) then
  begin
    if not fEmptyStr(Result) then
      Result := Result + ', ';

    Result := Result + qryTelefones.FieldByName('CLI_FONE02').AsString;
  end;

  if not fEmptyStr(qryTelefones.FieldByName('CLI_CELULA').AsString) then
  begin
    if not fEmptyStr(Result) then
      Result := Result + ', ';

    Result := Result + qryTelefones.FieldByName('CLI_CELULA').AsString;
  end;
end;

function fRetornaEmailsCliente(Const strCodCli: String): String;
var
  qryEmails: IQuery;
begin
  qryEmails := fCriaQuery;

  Result := EmptyStr;

  qryEmails.Close;
  qryEmails.SQL.Clear;
  qryEmails.SQL.Add('SELECT CLI_EMAIL_, CLI_EMAIL2, CLI_EMAIL3');
  qryEmails.SQL.Add('FROM CADCLI');
  qryEmails.SQL.Add('WHERE CLI_CODCLI = :CODCLI');
  qryEmails.ParamByName('CODCLI').AsString := strCodCli;
  qryEmails.Open;

  if qryEmails.IsEmpty then
    Exit;

  if not fEmptyStr(qryEmails.FieldByName('CLI_EMAIL_').AsString) then
    Result := Result + qryEmails.FieldByName('CLI_EMAIL_').AsString;

  if not fEmptyStr(qryEmails.FieldByName('CLI_EMAIL2').AsString) then
  begin
    if not fEmptyStr(Result) then
      Result := Result + ', ';

    Result := Result + qryEmails.FieldByName('CLI_EMAIL2').AsString;
  end;

  if not fEmptyStr(qryEmails.FieldByName('CLI_EMAIL3').AsString) then
  begin
    if not fEmptyStr(Result) then
      Result := Result + ', ';

    Result := Result + qryEmails.FieldByName('CLI_EMAIL3').AsString;
  end;

end;

Function fGetFornecedorFilial(strCodEmp: String): String;
  Var
    strSQL: String;
    qryGenEmp: IQuery;
begin
  Result := '';

  Try
    qryGenEmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  EMP_FORFIL ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    With qryGenEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;

      If Not IsEmpty Then
        Result := FieldByName('EMP_FORFIL').AsString;

      Close;
    End;

  Finally

  End;

end;

function fExisteFatGorPendente(strCodCli, strNumDoc: String; strEspDoc: String; strCodPro: String = ''): Boolean;
Var
  qryGen: IQuery;
Begin
  qryGen := fCriaQuery;
  Try
    qryGen.SQL.Clear;

    qryGen.SQL.Add('SELECT   ');
    qryGen.SQL.Add
      ('  SUM(IFNULL(FDO_QTDITE,0) - IFNULL(FDO_QTDBAI,0)) AS QTDPEN ');
    qryGen.SQL.Add('FROM     ');
    qryGen.SQL.Add('  FATDOR ');
    If (Not fEmptyStr(strCodPro)) Then
    Begin
      qryGen.SQL.Add('  INNER JOIN FATGOR ON FDO_SEQGER = FATGOR.AUTOINCREM ');
      qryGen.SQL.Add('  INNER JOIN MOVOCO ON FGO_NUMDOC = OCO_NUMDOC AND    ');
      qryGen.SQL.Add('                       FGO_ESPDOC = OCO_ESPDOC AND    ');
      qryGen.SQL.Add('                       FGO_CODEMP = OCO_CODEMP        ');
    End;
    qryGen.SQL.Add('WHERE FDO_CODEMP = :CODEMP ');
    qryGen.SQL.Add('  AND FDO_JAFATU = 0       ');
    qryGen.SQL.Add('  AND FDO_ESPDOC = :ESPDOC   ');

    If Not(fEmptyStr(strNumDoc)) Then
      qryGen.SQL.Add('  AND FDO_NUMDOC <> :NUMDOC ');

    If Not(fEmptyStr(strCodPro)) Then
    Begin
      qryGen.SQL.Add('  AND ((FDO_CODCLI = :CODCLI) or (FDO_CODCLI =:CONCRM))');
      qryGen.SQL.Add('  AND OCO_CODCLI  = :CODPRO ');
    End
    Else
    Begin
      qryGen.SQL.Add('  AND FDO_CODCLI = :CODCLI ');
    End;

    qryGen.SQL.Add('HAVING QTDPEN > 0           ');

    qryGen.ParamByName('CODCLI').AsString := strCodCli;
    qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
    If Not(fEmptyStr(strNumDoc)) Then
      qryGen.ParamByName('NUMDOC').AsString := strNumDoc;
    If Not(fEmptyStr(strCodPro)) Then
    Begin
      qryGen.ParamByName('CODPRO').AsString := strCodPro;
      qryGen.ParamByName('CONCRM').AsString := fCfgSis('CONCRM', varString);
    End;
    qryGen.ParamByName('ESPDOC').AsString := strEspDoc;

    qryGen.Open;

    Result := Not qryGen.IsEmpty;

  Finally
    qryGen.Close;
  End;
End;

function fExisteOrcamentoPendente(strCodCli, strNumOrc: String; strCodPro: String = ''): Boolean;
Begin
  Result := fExisteFatGorPendente(strCodCli, strNumOrc, 'OR', strCodPro);
End;

function fExistePedidoPendente(strCodCli, strNumDoc: String; strCodPro: String = ''): Boolean;
Begin
  Result := fExisteFatGorPendente(strCodCli, strNumDoc, 'PD', strCodPro);
End;

function fRetNomTransportadora(strCodTra: String): String;
Begin
  Result := '';

  If fEmptyStr(strCodTra) Then
    Exit;

  Result := fCampoTabela('TRA_NOMTRA','CADTRA', ['TRA_CODTRA'], [strCodTra], False);
End;

function fRetCodCnd(strCndPag: String): String; Overload;
Begin
  Result := EmptyStr;

  If fEmptyStr(strCndPag) Then
    Exit;

  Result := fCampoTabela('CND_CODIGO', 'CADCND', ['CND_CNDPAG'], [strCndPag], False);
End;

function fRetCodCnd(strCndPag, strEmpAce: String): String; Overload;
Begin
  Result := EmptyStr;

  If fEmptyStr(strCndPag) Then
    Exit;

  Result := fCampoTabela('CND_CODIGO', 'CADCND', ['CND_CNDPAG', 'LOCATE(:EMPACE, CND_EMPACE) > 0'], [strCndPag, strEmpAce], False);
End;

function fRetNomLocFisica(Const strCodLoc: String; strCodEmp: String = ''; blnRefazConsulta: Boolean = False): String;
Begin
  If strCodEmp = '' Then
    strCodEmp := VS_strCodEmp;
  Result := fCampoTabela('LOC_DESCRI', 'CADLOC', ['LOC_CODLOC', 'LOC_CODEMP'],
                         [strCodLoc, strCodEmp], blnRefazConsulta);
End;

function fRetNomFanFor(strCodFor: String): String;
Var
  strSQL: String;
  qryGenFor: IQuery;
Begin
  qryGenFor := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + ' * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADFOR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  FOR_CODFOR = :CODFOR ';

  With qryGenFor Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODFOR').AsString := strCodFor;
    Open;
    If IsEmpty Then
      Result := ''
    Else
      Result := FieldByName('FOR_NOMFAN').AsString;
    Close;
  End;

End;


function fRetTipoDepartamentoVarios(strTipo: String): String;
Var
  strSQL   : String;
  qryGenDpt: IQuery;
  intCont  : Integer;
begin
  intCont   := 1;
  qryGenDpt := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '      DEP_CODIGO    ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADDEP ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  DEP_' + strTipo + ' = "S" ';

  With qryGenDpt Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;

    If Not IsEmpty Then
    Begin
      First;
      While Not Eof Do
      Begin

        If intCont = 1 then
          Result := QuotedStr(FieldByName('DEP_CODIGO').AsString)
        Else
          Result := Result + ',' + QuotedStr(FieldByName('DEP_CODIGO').AsString);

        intCont := intCont + 1;
        Next;
      End;
    End
    Else
      Result := QuotedStr('N');
    Close;
  End;
End;

function fRetNomeMotorista(strCodMot: String; blnAtivos: Boolean = False): String;
  Var
    strSQL: String;
    qryGen: IQuery;
Begin

  Try
    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT                 ';
    strSQL := strSQL + '  MOT_NOMMOT           ';
    strSQL := strSQL + 'FROM                   ';
    strSQL := strSQL + '  CADMOT               ';
    strSQL := strSQL + 'WHERE                  ';
    strSQL := strSQL + '  MOT_CODMOT = :CODMOT ';

    If blnAtivos Then
      strSQL := strSQL + '  AND MOT_STATUS = "A" ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODMOT').AsString := strCodMot;
      Open;

      Result := FieldByName('MOT_NOMMOT').AsString;

      Close;
    End;

  Finally

  End;

End;


function fRetClientesFilial: String;
Var
  intContador: Integer;
  strSQL: String;
  qryGenerica: IQuery;

Begin

  qryGenerica := objConnectionsManager.CurrentConnection.CreateQuery;

  Result := '';

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  EMP_CLIFIL ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADEMP ';

  With qryGenerica Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;

    For intContador := 0 To RecordCount - 1 Do
    Begin

      If Not fEmptyStr(FieldByName('EMP_CLIFIL').AsString) Then
        Result := Result + QuotedStr(FieldByName('EMP_CLIFIL').AsString) + ',';

      Next;
    End;

    Result := Copy(Result, 1, Length(Result) - 1);

    Close;
  End;

  If (fEmptyStr(Result)) Then
    Result := '""';

End;

function fItemPigmento(strCodIte: String; Var strCodBas: String): Boolean;
begin
  Result := False;
  strCodBas := '';

  if fEmptyStr(strCodIte) then
    exit;

  If Not fTabelaVazia('DUP_CADBAS', False) Then
  Begin
    strCodBas := fCampoTabela('BAS_CODBAS', 'DUP_CADBAS', ['BAS_CODITE'],
      [strCodIte], False);
    Result := Not fEmptyStr(strCodBas);
  End;

end;

{**************************************}
{* GERA O LOG DE ALTERA«’ES NO BANCO  *}
{***********************************AF*}
function fGravaLogBco(conConexao: IConnection; strComand: String): Boolean;
  Var
    qryLogBco: IQuery;
Begin

  Try
    Result := True;

    qryLogBco := conConexao.CreateQuery;

    qryLogBco.Close;
    qryLogBco.SQL.Clear;
    qryLogBco.SQL.Add('SELECT * FROM LOGBCO LIMIT 0');
    qryLogBco.Open;

    With qryLogBco Do
    Begin
      Append;
      FieldByName('LOG_DTACAD').AsDateTime := VS_Date;
      FieldByName('LOG_HRACAD').AsDateTime := Time;
      FieldByName('LOG_COMAND').AsString   := strComand;

      If FindField('LOG_CODOPE') <> Nil Then
        FieldByName('LOG_CODOPE').AsString := strLoginUsuarioLogado;

      Post;
    End;

    qryLogBco.Close;
  Except
    On E: Exception Do
      Raise Exception.Create('[fGravaLogBco] - ' + E.Message);
  End;
End;

function fTabelaExportacaoTerceirosTinta(strTabela: String): Boolean;
begin
  Result := False;
  If (strTabela = 'LOGTIN_SIT')        Or
     (strTabela = 'BAU_CADBAU_SIT')    Or
     (strTabela = 'CORIMO_CADCOR_SIT') Or
     (strTabela = 'DAC_CADDAC_SIT')    Or
     (strTabela = 'EUC_CADEUC_SIT')    Or
     (strTabela = 'FUT_CADFUT_SIT')    Or
     (strTabela = 'REI_CADREI_SIT')    Or
     (strTabela = 'SAY_CADSAY_SIT')    Or
     (strTabela = 'SHE_CADSHE_SIT')    Or
     (strTabela = 'SUV_CADSUV_SIT')    Or
     (strTabela = 'PPG_CADPPG_SIT')    Or
     (strTabela = 'BZA_CADBZA_SIT')    Or
     (strTabela = 'SKY_CADSKY_SIT')    Or
     (strTabela = 'DUP_CADDUP_SIT')    Or
     (strTabela = 'FAL_CADFAL_SIT')    Or
     (strTabela = 'LAZ_CADMIX_SIT')    Or
     (strTabela = 'ADVCOR_CADADV_SIT') Or
     (strTabela = 'ALE_CADALE_SIT')    Or
     (strTabela = 'AJT_CADAJT_SIT')    Or
     (strTabela = 'ANJ_CADANJ_SIT')    Or
     (strTabela = 'AJA_CADAJA_SIT')    Or
     (strTabela = 'BZC_CADBZC_SIT')    Or
     (strTabela = 'GEN_CADGEN_SIT')    Or
     (strTabela = 'ANN_CADANN_SIT')    Or
     (strTabela = 'BEL_CADBEL_SIT')    Or
     (strTabela = 'BZI_CADBZI_SIT')    Or
     (strTabela = 'CAL_CADCAL_SIT')    Or
     (strTabela = 'CIA_CADCIA_SIT')    Or
     (strTabela = 'DUX_CADDUX_SIT')    Or
     (strTabela = 'FAR_CADFAR_SIT')    Or
     (strTabela = 'GLO_CADGLO_SIT')    Or
     (strTabela = 'GRA_CADGRA_SIT')    Or
     (strTabela = 'HYD_CADHYD_SIT')    Or
     (strTabela = 'INT_CADINT_SIT')    Or
     (strTabela = 'IQU_CADIQU_SIT')    Or
     (strTabela = 'JOT_CADJOT_SIT')    Or
     (strTabela = 'KILD_CADKIL_SIT')   Or
     (strTabela = 'LIK_CADLIK_SIT')    Or
     (strTabela = 'LKD_CADLKD_SIT')    Or
     (strTabela = 'MZI_CADMZI_SIT')    Or
     (strTabela = 'MZA_CADMZA_SIT')    Or
     (strTabela = 'MZD_CADMZD_SIT')    Or
     (strTabela = 'MEG_CADMEG_SIT')    Or
     (strTabela = 'MON_CADMON_SIT')    Or
     (strTabela = 'NEX_CADNEX_SIT')    Or
     (strTabela = 'PPX_CADPPX_SIT')    Or
     (strTabela = 'LKC_CADLKC_SIT')    Or
     (strTabela = 'QUA_CADQUA_SIT')    Or
     (strTabela = 'REC_CADREC_SIT')    Or
     (strTabela = 'REN_CADREN_SIT')    Or
     (strTabela = 'SPA_CADSPA_SIT')    Or
     (strTabela = 'DOX_CADDOX_SIT')    Or
     (strTabela = 'STA_CADSTA_SIT')    Or
     (strTabela = 'UNI_CADUNI_SIT')    Or
     (strTabela = 'VEL_CADVEL_SIT')    Or
     (strTabela = 'WEG_CADWEG_SIT')    Or
     (strTabela = 'INK_CADINK_SIT')    Or
     (strTabela = 'STW_CADSTW_SIT')    Or
     (strTabela = 'BLT_CADBLT_SIT')    Or
     (strTabela = 'TEX_CADTEX_SIT')    Or
     (strTabela = 'CHR_CADCHR_SIT')    Or
     (strTabela = 'SHW_CADSHW_SIT')    Or
     (strTabela = 'ALE_CADALE_SIT')    Or
     (strTabela = 'ALK_CADALK_SIT')    Or
     (strTabela = 'C11_CADC11_SIT')    Or
     (strTabela = 'WANPRO_CADWAN_SIT') Or
     (strTabela = 'ADS_CADADS_SIT')    Or
     (strTabela = 'CFGTIN')            Or
     (strTabela = 'DU2_CADDU2_SIT')    Or
     (strTabela = 'ADT_CADADT_SIT')    Or
     (strTabela = 'LEI_CADLEI_SIT')    Or
     (strTabela = 'MAE_CADMAE_SIT')    Or
     (strTabela = 'SIN_CADSIN_SIT')    Or
     (strTabela = 'DCA_CADDCA_SIT')    Or
     (strTabela = 'LUZ_CADLUZ_SIT')    Or
     (strTabela = 'LEC_CADLEC_SIT')    Or
     (strTabela = 'REP_CADREP_SIT')    Or
     (strTabela = 'BAU_CADBAU_SIT_BKP')    Or
     (strTabela = 'CORIMO_CADCOR_SIT_BKP') Or
     (strTabela = 'DAC_CADDAC_SIT_BKP')    Or
     (strTabela = 'EUC_CADEUC_SIT_BKP')    Or
     (strTabela = 'FUT_CADFUT_SIT_BKP')    Or
     (strTabela = 'REI_CADREI_SIT_BKP')    Or
     (strTabela = 'SAY_CADSAY_SIT_BKP')    Or
     (strTabela = 'SHE_CADSHE_SIT_BKP')    Or
     (strTabela = 'SUV_CADSUV_SIT_BKP')    Or
     (strTabela = 'PPG_CADPPG_SIT_BKP')    Or
     (strTabela = 'BZA_CADBZA_SIT_BKP')    Or
     (strTabela = 'SKY_CADSKY_SIT_BKP')    Or
     (strTabela = 'DUP_CADDUP_SIT_BKP')    Or
     (strTabela = 'FAL_CADFAL_SIT_BKP')    Or
     (strTabela = 'LAZ_CADMIX_SIT_BKP')    Or
     (strTabela = 'ADVCOR_CADADV_SIT_BKP') Or
     (strTabela = 'ALE_CADALE_SIT_BKP')    Or
     (strTabela = 'AJT_CADAJT_SIT_BKP')    Or
     (strTabela = 'ANJ_CADANJ_SIT_BKP')    Or
     (strTabela = 'AJA_CADAJA_SIT_BKP')    Or
     (strTabela = 'BZC_CADBZC_SIT_BKP')    Or
     (strTabela = 'GEN_CADGEN_SIT_BKP')    Or
     (strTabela = 'ANN_CADANN_SIT_BKP')    Or
     (strTabela = 'BEL_CADBEL_SIT_BKP')    Or
     (strTabela = 'BZI_CADBZI_SIT_BKP')    Or
     (strTabela = 'CAL_CADCAL_SIT_BKP')    Or
     (strTabela = 'CIA_CADCIA_SIT_BKP')    Or
     (strTabela = 'DUX_CADDUX_SIT_BKP')    Or
     (strTabela = 'FAR_CADFAR_SIT_BKP')    Or
     (strTabela = 'GLO_CADGLO_SIT_BKP')    Or
     (strTabela = 'GRA_CADGRA_SIT_BKP')    Or
     (strTabela = 'HYD_CADHYD_SIT_BKP')    Or
     (strTabela = 'INT_CADINT_SIT_BKP')    Or
     (strTabela = 'IQU_CADIQU_SIT_BKP')    Or
     (strTabela = 'JOT_CADJOT_SIT_BKP')    Or
     (strTabela = 'KILD_CADKIL_SIT_BKP')   Or
     (strTabela = 'LIK_CADLIK_SIT_BKP')    Or
     (strTabela = 'LKD_CADLKD_SIT_BKP')    Or
     (strTabela = 'MZI_CADMZI_SIT_BKP')    Or
     (strTabela = 'MZA_CADMZA_SIT_BKP')    Or
     (strTabela = 'MZD_CADMZD_SIT_BKP')    Or
     (strTabela = 'MEG_CADMEG_SIT_BKP')    Or
     (strTabela = 'MON_CADMON_SIT_BKP')    Or
     (strTabela = 'NEX_CADNEX_SIT_BKP')    Or
     (strTabela = 'PPX_CADPPX_SIT_BKP')    Or
     (strTabela = 'LKC_CADLKC_SIT_BKP')    Or
     (strTabela = 'QUA_CADQUA_SIT_BKP')    Or
     (strTabela = 'REC_CADREC_SIT_BKP')    Or
     (strTabela = 'REN_CADREN_SIT_BKP')    Or
     (strTabela = 'SPA_CADSPA_SIT_BKP')    Or
     (strTabela = 'DOX_CADDOX_SIT_BKP')    Or
     (strTabela = 'STA_CADSTA_SIT_BKP')    Or
     (strTabela = 'UNI_CADUNI_SIT_BKP')    Or
     (strTabela = 'VEL_CADVEL_SIT_BKP')    Or
     (strTabela = 'WEG_CADWEG_SIT_BKP')    Or
     (strTabela = 'INK_CADINK_SIT_BKP')    Or
     (strTabela = 'STW_CADSTW_SIT_BKP')    Or
     (strTabela = 'BLT_CADBLT_SIT_BKP')    Or
     (strTabela = 'TEX_CADTEX_SIT_BKP')    Or
     (strTabela = 'CHR_CADCHR_SIT_BKP')    Or
     (strTabela = 'SHW_CADSHW_SIT_BKP')    Or
     (strTabela = 'ALE_CADALE_SIT_BKP')    Or
     (strTabela = 'ALK_CADALK_SIT_BKP')    Or
     (strTabela = 'C11_CADC11_SIT_BKP')    Or
     (strTabela = 'WANPRO_CADWAN_SIT_BKP') Or
     (strTabela = 'ADS_CADADS_SIT_BKP')    Or
     (strTabela = 'DU2_CADDU2_SIT_BKP')    Or
     (strTabela = 'ADT_CADADT_SIT_BKP')    Or
     (strTabela = 'LEI_CADLEI_SIT_BKP')    Or
     (strTabela = 'MAE_CADMAE_SIT_BKP')    Or
     (strTabela = 'SIN_CADSIN_SIT_BKP')    Or
     (strTabela = 'DCA_CADDCA_SIT_BKP')    Or
     (strTabela = 'LUZ_CADLUZ_SIT_BKP')    Or
     (strTabela = 'LEC_CADLEC_SIT_BKP')    Or
     (strTabela = 'REP_CADREP_SIT_BKP')    Then
    Result := True;
end;

function fGetQuantidadeFatorAxalta(const fltQuantidade: Double; const strCodIte: string): Double;
var
  qryGen: IQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                               ' +
        '   ITE_CODITE                         ' +
        '   , ITE_CNV_ML                       ' +
        '   , (:QTD / ITE_CNV_ML) AS RESULT    ' +
        ' FROM                                 ' +
        '   CADITE I                           ' +
        '   INNER JOIN DUP_CADBAS B            ' +
        '     ON I.ITE_CODITE = B.BAS_CODITE   ' +
        ' WHERE B.BAS_CODITE = :CODITE         ' +
        ' LIMIT 1                              ';
      qryGen.ParamByName('QTD').AsFloat := fltQuantidade;
      qryGen.ParamByName('CODITE').AsString := strCodIte;
      qryGen.Open;

      if qryGen.IsEmpty then
        Result := fltQuantidade
      else
        Result := qryGen.FieldByName('RESULT').AsFloat;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;
end;

function fGetQuantidadeFatorDupont(const fltQuantidade: Double;
  const strCodIte: string): Double;
var
  qryGen: IQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := objConnectionsManager.CurrentConnection.CreateQuery;
      qryGen.SQL.Text := ' SELECT              ' +
        '   ITE_CODITE                         ' +
        '   , ITE_CNV_ML                       ' +
        '   , (:QTD / ITE_CNV_ML) AS RESULT    ' +
        ' FROM                                 ' +
        '   CADITE I                           ' +
        '   INNER JOIN DUP_CADBAS B            ' +
        '     ON I.ITE_CODITE = B.BAS_CODITE   ' +
        ' WHERE B.BAS_CODITE = :CODITE         ' +
        ' LIMIT 1                              ';
      qryGen.ParamByName('QTD').AsFloat := fltQuantidade;
      qryGen.ParamByName('CODITE').AsString := strCodIte;
      qryGen.Open;

      if qryGen.IsEmpty then
        Result := fltQuantidade
      else
        Result := qryGen.FieldByName('RESULT').AsFloat;

    Except
      on E: Exception do
        Raise Exception.Create('[fGetQuantidadeFatorDupont] - ' + E.Message);
    End;
  Finally

  End;
end;

function fRetornaClienteFilial(strCodEmp: String;
  strTipo_FC: String = 'C'): String;
begin
  If fEmptyStr(strCodEmp) Then
  Begin
    Result := '';
    exit;
  End;

  If strTipo_FC = 'C' Then
    Result := fCampoTabela('EMP_CLIFIL', 'CADEMP', ['EMP_CODEMP'],
      [strCodEmp], False)
  else
    Result := fCampoTabela('EMP_FORFIL', 'CADEMP', ['EMP_CODEMP'],
      [strCodEmp], False);
end;

Function fRetClienteConsumidor(strEstado:String = ''): String;
  Var
    qryAux: IQuery;
begin
  qryAux := fCriaQuery;
  With qryAux, SQL Do
  Begin
    Add('SELECT ');
    Add('  CLI_CODCLI ');
    Add('FROM ');
    Add('  CADCLI INNER JOIN CADCID ON CLI_CODCID = CID_CODCID');
    Add('WHERE ');
    Add('  CLI_NOMCLI LIKE "%CONSUMIDOR%" ');

    If Not fEmptyStr(strEstado) Then
      Add('AND CID_ESTADO = :ESTADO ');

    Add('LIMIT 1 ');

    If Not fEmptyStr(strEstado) Then
      ParamByName('ESTADO').AsString := strEstado;

    Open;

    If IsEmpty Then
      Result := ''
    Else
      Result := FieldByName('CLI_CODCLI').AsString;

    Close;
  End;
End;

Function fRetNomTabAuxMov(strNomTab: String): String;
Begin
  strNomTab := Trim(strNomTab);

  If SameText(strNomTab, 'MOVGER') Then
    Result := 'AUXMOV'

  Else If SameText(strNomTab, 'NOTGER') Then
    Result := 'AUXNOT'

  Else If SameText(strNomTab, 'FATGOR') Then
    Result := 'AUXGOR'

  Else If SameText(strNomTab, 'DEL_MOVGER') Then
    Result := 'DEL_AUXMOV'

  Else If SameText(strNomTab, 'DEL_NOTGER') Then
    Result := 'DEL_AUXNOT'

  Else If SameText(strNomTab, 'DEL_FATGOR') Then
    Result := 'DEL_AUXGOR'

  Else
    Result := '';
End;

function fCadEmpDes(strNomCampo, strCodEmp: String): String;
Var
  strSQL   : String;
  qryGenEmp: IQuery;
begin
  Try

    qryGenEmp := fCriaQuery;

    If fEmptyStr(strCodEmp) Then
      strCodEmp := VS_strCodEmp;

    strSQL := '';
    strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '   CADEMP.*, ';
    strSQL := strSQL + '   CID_NOMCID AS "EMP_NOMCID", ';
    strSQL := strSQL + '   CID_ESTADO AS "EMP_ESTADO"  ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADEMP ';
    strSQL := strSQL + '   JOIN CADCID ON EMP_CODCID = CID_CODCID ';
    strSQL := strSQL + ' WHERE EMP_CODEMP = :CODEMP ';

    With qryGenEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;

      If FieldByName('EMP_' + strNomCampo).IsNull Then
      Begin
        Result := '';
      End
      Else
      Begin
        Result := FieldByName('EMP_' + strNomCampo).Value;
      End;

      Close;
    End;

  Finally

  End;

end;

function fRetCidEmpresa(strCodEmp: String): String;
Var
  strSQL   : String;
  qryGenEmp: IQuery;
begin
  Try

    qryGenEmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  EMP_CODCID ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    With qryGenEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;
      Result := FieldByName('EMP_CODCID').AsString;
      Close;
    End;

  Finally

  End;

End;

function fRetNomGeral(strCampoRetorno, strCampoPesquisa , strNomeTabela : String; fltCodigo: Double) : String;
Var
  strSQL   : String;
  qryGenTmp: IQuery;
begin
  Try

    qryGenTmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
    strSQL := strSQL + strCampoRetorno + ' AS RESULTADO ' ;
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + strNomeTabela;
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + strCampoPesquisa + ' = :CODIGO ';

    With qryGenTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODIGO').AsFloat := fltCodigo;
      Open;
      Result := FieldByName('RESULTADO').AsString;
      Close;
    End;

  Finally

  End;

end;

function fCampoTabela(strCampo: String; strNomTab: String;
  arrCampoChave: Array Of String; arrValorChave: Array Of Variant;
  blnSempreLerBanco: Boolean = True; strOrderBy: String = '';
  blnUsarMax: Boolean = False): Variant;
Const
  arrParms: Array [0 .. 11] Of String = ('A', 'B', 'C', 'D', 'E', 'F', 'G',
    'H', 'I', 'J', 'K', 'L');

Var
  intCont: Integer;
  strSQL: String;
  qryGenGer: IQuery;
Begin
  Try
    qryGenGer := objConnectionsManager.CurrentConnection.CreateQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';

    if blnUsarMax then
    begin
      strSQL := strSQL + '  MAX(' + strCampo + ') ';
    end
    else
    begin
      strSQL := strSQL + '  ' + strCampo + ' ';
    end;

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ' + strNomTab + ' ';
    strSQL := strSQL + 'WHERE ';

    For intCont := 0 To Length(arrCampoChave) - 1 Do
    Begin
      If Pos('<>', arrCampoChave[intCont]) > 0 Then
        strSQL := strSQL + '  ' + arrCampoChave[intCont] + ' :' +
          String(arrParms[intCont]) + ' AND '
      Else
        strSQL := strSQL + '  ' + arrCampoChave[intCont] + ' = :' +
          String(arrParms[intCont]) + ' AND ';
    End;

    strSQL := strSQL + '  TRUE  ';

    If Not strOrderBy.IsEmpty Then
      strSQL := strSQL + ' ORDER BY ' + strOrderBy;

    strSQL := strSQL + ' LIMIT 1 ';

    With qryGenGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      For intCont := 0 To Length(arrCampoChave) - 1 Do
        ParamByName(String(arrParms[intCont])).Value := arrValorChave[intCont];

      If (Not blnSempreLerBanco) Then
      Begin
        Result := TDicResultadoQuerySimples.fExecQuery(qryGenGer);
      End
      Else
      Begin
        Open;

        Result := Fields(0).Value;

        { ******************************************* }
        { * EXECUTA UM CAST PARA NAO RETORNAR NULL  * }
        { ****************************************JC* }
        Case Fields(0).DataType Of
          ftString:
            Result := Fields(0).AsString;
          ftMemo:
            Result := Fields(0).AsString;
          ftFloat:
            Result := Fields(0).AsFloat;
          ftInteger:
            Result := Fields(0).AsInteger;
          ftBoolean:
            Result := Fields(0).AsBoolean;
          ftDate:
            Result := Fields(0).AsDateTime;
          ftTime:
            Result := Fields(0).AsDateTime;
        End;
      End;

    End;

  Except
    On E: Exception Do
      Raise Exception.Create('[fCampoTabela] - ' + E.Message);
  End;
End;

function fTabelaVazia(strNomeTabela: string;
  blnSempreLerBanco: Boolean = True): Boolean;
begin
  Result := fCampoTabela('"1"', strNomeTabela, [], [],
    blnSempreLerBanco) <> '1';
end;

function fExecutaSQL(ASQL: String; blnRaise: Boolean = True): Boolean;
begin
  objConnectionsManager.CurrentConnection.CreateQuery(ASQL).ExecSQL;
  Result := True;
end;

function fCriarQuery(ASQL: String): IQuery;
begin
  Result := objConnectionsManager.CurrentConnection.CreateQuery(ASQL);
end;

function fCriaQuery(): IQuery;
begin
  Result := objConnectionsManager.CurrentConnection.CreateQuery();
end;

function fCriaQueryObject(AOwner: TComponent): TObject;
begin
  Result := objConnectionsManager.CurrentConnection.CreateQueryObject(AOwner);
end;

function fCriaScript(): IScript;
begin
  Result := objConnectionsManager.CurrentConnection.CreateScript();
end;

function fInTransaction(): Boolean;
begin
  Result := objConnectionsManager.CurrentConnection.InTransaction();
end;

function fStartTransaction(): Boolean;
begin
  if not objConnectionsManager.CurrentConnection.InTransaction then
  begin
    objConnectionsManager.CurrentConnection.StartTransaction();
  end;
  Result := True;
end;

function fCommit(): Boolean;
begin
  if objConnectionsManager.CurrentConnection.InTransaction then
    objConnectionsManager.CurrentConnection.Commit();
  Result := True;
end;

function fRollback(): Boolean;
begin
  if objConnectionsManager.CurrentConnection.InTransaction then
    objConnectionsManager.CurrentConnection.Rollback();
  Result := True;
end;

procedure pCarregaNre;
  Var
   qryTabNRE: IQuery;
begin
  If (Not Assigned(VS_stlTabNre)) Then
  Begin
    VS_stlTabNre := TStringList.Create;

    qryTabNRE := fCriaQuery;
    qryTabNRE.SQL.Add('SELECT * FROM TABNRE');
    qryTabNRE.Open;

    If (qryTabNRE.IsEmpty) Then
      Raise Exception.Create('Tabela TABNRE vazia! Verifique!');

    While Not qryTabNRE.Eof Do
    Begin
      VS_stlTabNre.Add(qryTabNRE.Fields(0).AsString);
      qryTabNRE.Next;
    End;

    qryTabNRE.Close;
  End;
end;

{**************************************}
{* VERIFICA SE TABELA REPLICA OU N√O  *}
{***********************************AF*}
function fTabelaReplica(strNomTabela: String): Boolean;
  Var
    intContador: Integer;
Begin
  Try
    Result := fTabelaPermiteReplicarSempre(strNomTabela);

    If Not Result Then
      Exit;

    pCarregaNre;

    If Not blnTransferindoCodigo Then
    Begin

      For intContador := 0 To VS_stlTabNre.Count -1 Do
      Begin

        {**************************************}
        {* SE FOI COLOCADO NO FIM O %         *}
        {***********************************AF*}
        If Pos('%', Trim(VS_stlTabNre[intContador])) > 0 Then
        Begin

          If LeftStr(Trim(AnsiUpperCase(strNomTabela)), Length(Trim(AnsiUpperCase(VS_stlTabNre[intContador]))) - 1) = LeftStr(Trim(AnsiUpperCase(VS_stlTabNre[intContador])), Length(Trim(AnsiUpperCase(VS_stlTabNre[intContador]))) - 1) Then
          Begin
            Result := False;
            Exit;
          End;

        End
        {**************************************}
        {* SE N√O FOI COLOCADO O %            *}
        {***********************************AF*}
        Else
        Begin

          {**************************************}
          {* SE O NOME DA TABELA FOR O MESMO DA *}
          {* CONFIGURA«√O ENT√O N√O REPLICA     *}
          {***********************************AF*}
          If Trim(AnsiUpperCase(strNomTabela)) = Trim(AnsiUpperCase(VS_stlTabNre[intContador])) Then
          Begin
            Result := False;
            Exit;
          End;

        End;

      End;

    End;

  Except
    On E: Exception Do
      Raise Exception.Create('[fTabelaReplica] - ' + E.Message);
  End;
End;


function fTabelaPermiteReplicarSempre(strNomTabela: String): Boolean;
begin
  Result := True;

  {***************************************************}
  {* N√O REPLICA A TABNRE!!!!                        *}
  {** 09/06/2008 - 09:54 **************************MV*}
  {** 09/06/2009 - 17:47 **************************JB*}
  {** 13/02/2013 - ********************************JU*}
  If (strNomTabela = 'TABNRE')         Or
     (strNomTabela = 'LOGREP')         Or
     (strNomTabela = 'USUREP')         Or
     (strNomTabela = 'LOGERR')         Or
     (strNomTabela = 'LCKATC')         Or
     (strNomTabela = 'AUXCFG')         Or
     (strNomTabela = 'TAGDIR')         Or
     (strNomTabela = 'LOGSQL')         Or
     (strNomTabela = 'CADBCO')         Or
     (strNomTabela = 'INFSIS')         Or
     (strNomTabela = 'PROINC')         Or
     (strNomTabela = 'PROCOD')         Or
     (strNomTabela = 'NFE_NFEPRINTER') Or
     (strNomTabela = 'NFE_TEMPO')      Or
     (strNomTabela = 'NFE_LOCAL')      Or
     (strNomTabela = 'LOGACE')         Or
     (strNomTabela = 'LOGFRM')         Or
     (strNomTabela = 'MNUACE')         Or
     (strNomTabela = 'CONDET')         Or
     (strNomTabela = 'PCMGER_RES')     Or
     (strNomTabela = 'PCMDET_RES')     Or
     (strNomTabela = 'PCDDET_RES')     Or
     (strNomTabela = 'PCMIRQ_RES')     Or
     (strNomTabela = 'TRANSACOES')     Then
  Begin
    Result := False;
  End;
end;

//**************************************//
// RETORNA NOME DE TABELA               //
//***********************************WI*//
function fExtrairNomeTabelaSQL(strString: String): String;
  Var
    strTmp     : String;
    intPosicao : Integer;
    intContador: Integer;
Begin
  strString := AnsiUpperCase(Trim(strString));

  If Length(strString) > 1000 Then
  Begin
    Result := fExtrairNomeTabelaSQL(LeftStr(strString, 1000));
    If Result <> '' Then
      Exit;
  End;

  Result     := '';
  intPosicao := 0;

  If LeftStr(strString,6) = 'INSERT' Then
  Begin
    intPosicao :=  Pos('INTO ', strString);
    strTmp := Copy(strString, intPosicao, Length(strString)-intPosicao);
    strTmp := TRegEx.Replace(strTmp, 'INTO ', '');
  End

  Else If LeftStr(strString,6) = 'UPDATE' Then
  Begin
    intPosicao :=  Pos('UPDATE ', strString);
    strTmp := Copy(strString, intPosicao, Length(strString)-intPosicao);
    strTmp := TRegEx.Replace(strTmp, 'UPDATE ', '');
  End

  Else If LeftStr(strString,6) = 'DELETE' Then
  Begin
    intPosicao := Pos('FROM ', strString);
    strTmp := Copy(strString, intPosicao, Length(strString)-intPosicao);
    strTmp := TRegEx.Replace(strTmp, 'FROM ', '');
  End

  Else If LeftStr(strString,7) = 'REPLACE' Then
  Begin
    intPosicao := Pos('INTO ', strString);
    strTmp := Copy(strString, intPosicao, Length(strString)-intPosicao);
    strTmp := TRegEx.Replace(strTmp, 'INTO ', '');
  End;

  If (intPosicao > 0) Then
  Begin
    strTmp := fTrocaCaracter(strTmp,'(', ' ');
    strTmp := fTrocaCaracter(strTmp,')', ' ');
    strTmp := fTrocaCaracter(strTmp,',', ' ');
    strTmp := Trim(strTmp);

    For intContador := 1 To Length(strTmp) Do
    Begin
      If fEmptyStr(Copy(strTmp, intContador, 1)) Then
        Break;

      Result := Result + Copy(strTmp, intContador, 1);
    End;

    Result := Trim(Result);
  End;

  If Not fEmptyStr(Result) Then
  Begin

    intPosicao := Pos('.',Result);

    If intPosicao > 0 Then
      Result := Copy(Result, intPosicao +1, Length(Result) -intPosicao);

  End;
End;

function fExtrairNomeTabelaSQLExportacao(strString: String): String;
Var
  strTmp     : String;
  intPosicao : Integer;
  intContador: Integer;
  intPosY: Integer;
Begin
  strString := AnsiUpperCase(Trim(strString));

  If Length(strString) > 1000 Then
  Begin
    Result := fExtrairNomeTabelaSQL(LeftStr(strString, 1000));
    If Result <> '' Then
      Exit;
  End;

  Result     := '';
  intPosicao := 0;

  If LeftStr(strString,6) = 'INSERT' Then
  Begin
    intPosicao :=  Pos('INTO ', strString);
    strTmp := Copy(strString, intPosicao, Length(strString)-intPosicao);
    strTmp := TRegEx.Replace(strTmp, 'INTO ', '');
  End

  Else If LeftStr(strString,6) = 'UPDATE' Then
  Begin
    intPosicao :=  Pos('UPDATE ', strString);
    strTmp := Copy(strString, intPosicao, Length(strString)-intPosicao);
    strTmp := TRegEx.Replace(strTmp, 'UPDATE ', '');
  End

  Else If LeftStr(strString,6) = 'DELETE' Then
  Begin
    intPosicao := Pos('FROM ', strString);
    strTmp := Copy(strString, intPosicao, Length(strString)-intPosicao);
    strTmp := TRegEx.Replace(strTmp, 'FROM ', '');
  End

  Else If LeftStr(strString,7) = 'REPLACE' Then
  Begin
    intPosicao := Pos('INTO ', strString);
    strTmp := Copy(strString, intPosicao, Length(strString)-intPosicao);
    strTmp := TRegEx.Replace(strTmp, 'INTO ', '');
  End

  Else If LeftStr(strString, 4) = 'DESC' Then
  Begin
    intPosicao := Pos('DESC ', strString);
    strTmp := Copy(strString, intPosicao, Length(strString));
    strTmp := TRegEx.Replace(strTmp, 'DESC ', '');
    Exit(strTmp);
  End

  Else If LeftStr(strString, 4) = 'DROP' Then
  Begin
    intPosicao := Pos('TABLE ', strString);
    strTmp := Copy(strString, intPosicao, Length(strString));
    strTmp := TRegEx.Replace(strTmp, 'TABLE ', '');
    Exit(strTmp);
  End;

  If (intPosicao > 0) Then
  Begin
    strTmp := fTrocaCaracter(strTmp,'(', ' ');
    strTmp := fTrocaCaracter(strTmp,')', ' ');
    strTmp := fTrocaCaracter(strTmp,',', ' ');
    strTmp := Trim(strTmp);

    For intContador := 1 To Length(strTmp) Do
    Begin
      If fEmptyStr(Copy(strTmp, intContador, 1)) Then
        Break;

      Result := Result + Copy(strTmp, intContador, 1);
    End;

    Result := Trim(Result);
  End;

  If Not fEmptyStr(Result) Then
  Begin

    intPosicao := Pos('.',Result);

    If intPosicao > 0 Then
      Result := Copy(Result, intPosicao +1, Length(Result) -intPosicao);

  End;
End;

procedure pGravaLogContabil(conConexao: IConnection; strSQL, strTabela: string);

  function fExtrairTipLan: string;
    const
      FIELD_TO_FIND : String = 'CON_TIPLAN';
      arrIgnoreChar : array[1..3] of string = ('=', '"', chr(39));
      MAX_LENGTH_TIPLAN : Integer = 3;
    var
      intPos : Integer;
      intCnt : Integer;
  begin
    Result := '';

    intPos := Pos(FIELD_TO_FIND, strSQL);

    if (intPos > 0) then
    begin
      intPos := intPos + Length(FIELD_TO_FIND);
      for intCnt := intPos to Length(strSQL) do
      begin
        if not fEmptyStr(strSQL[intCnt]) then
        begin
          if not (MatchStr(strSQL[intCnt], arrIgnoreChar)) then
            Result := Result + strSQL[intCnt];
        end;

        if Length(Result) = MAX_LENGTH_TIPLAN then
          break;
      end;
    end;
  end;

  var
    qryLogCtl: IQuery;
begin
  if strSQL.IsEmpty then
    exit;

  if (LeftStr(strSQL, 30).Contains('INSERT')) then
    exit;

  qryLogCtl := conConexao.CreateQuery;
  try
    qryLogCtl.SQL.Text := 'SELECT * FROM LOGCTL WHERE FALSE';
    qryLogCtl.Open;
    qryLogCtl.Append;
    qryLogCtl.FieldByName('CTL_CODEMP').AsString := VS_strCodEmp;
    qryLogCtl.FieldByName('CTL_DTALOG').AsDateTime := VS_Date;
    qryLogCtl.FieldByName('CTL_HORLOG').AsDateTime := Time;
    qryLogCtl.FieldByName('CTL_TABELA').AsString := strTabela;

    if (strTabela = 'LANCON') or (strTabela = 'PARCON') then
      qryLogCtl.FieldByName('CTL_TIPLAN').AsString := fExtrairTipLan;

    qryLogCtl.FieldByName('CTL_COMAND').AsString := strSQL;
    qryLogCtl.FieldByName('CTL_CODOPE').AsString := strLoginUsuarioLogado;
    qryLogCtl.Post;
  finally

  end;
end;

procedure pDefinirCharsetConexao(AConnection: IConnection);
var
  qryGen : IQuery;
begin

  qryGen := AConnection.CreateQuery;

  Try

    With qryGen Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add('SET character_set_connection = LATIN1');
      ExecSQL;

      SQL.Clear;
      SQL.Add('SET character_set_client = LATIN1');
      ExecSQL;

      SQL.Clear;
      SQL.Add('SET character_set_database = LATIN1');
      ExecSQL;

      SQL.Clear;
      SQL.Add('SET character_set_results = LATIN1');
      ExecSQL;

      SQL.Clear;
      SQL.Add('SET character_set_server = LATIN1');
      ExecSQL;

      SQL.Clear;
      SQL.Add('SET collation_connection = latin1_swedish_ci');
      ExecSQL;

      SQL.Clear;
      SQL.Add('SET collation_database = latin1_swedish_ci');
      ExecSQL;

      SQL.Clear;
      SQL.Add('SET collation_server = latin1_swedish_ci');
      ExecSQL;

      SQL.Clear;
      SQL.Add('SET sql_mode = ""');
      ExecSQL;

      SQL.Clear;
      SQL.Add('SET group_concat_max_len = 3072');
      ExecSQL;

    End;

  Finally

  End;

end;

procedure pIniciarConexao();
begin
  objConnectionsManager := TConnectionsManager.Create;
  objConnectionsManager.BeginConnection;
  TUniDacMonitor.Start;
end;

{ TConnectionsManager }

constructor TConnectionsManager.Create;
begin
  FMREW := TMultiReadExclusiveWriteSynchronizer.Create;
  FDicConn := TDictionary<NativeUInt, IConnection>.Create;
end;

destructor TConnectionsManager.Destroy;
begin
  FDicConn.Free;
  FMREW.Free;
  inherited;
end;

function TConnectionsManager.NewConnection(ATag: NativeUInt): IConnection;
begin
  Result := TUniDacConnection.Create(ATag);
  Result.SetUser(TConnectionsManager.FConnectionUser);
  Result.SetPassword(TConnectionsManager.FConnectionPass);
  Result.SetServer(ReadIniFile('BANCO', 'NUMIP', '', GetIniFile));
  Result.SetDatabase(ReadIniFile('BANCO', 'NOMBAN', 'AUTCOM', GetIniFile));
  Result.SetPort(ReadIniFile('BANCO', 'PORTA', '3306', GetIniFile).ToInteger());
  Result.Connect;
end;

function TConnectionsManager.BeginConnection(ATag: NativeUInt = 0): IConnection;
var
  LKey: NativeUInt;
  LConn: IConnection;
begin
  FMREW.BeginWrite;
  try
    if ATag > 0 then
      LKey := ATag
    else
      LKey := TThread.CurrentThread.ThreadID;
    if not FDicConn.TryGetValue(LKey, LConn) then
    begin
      LConn := NewConnection(LKey);
      FDicConn.Add(LKey, LConn);
    end;
    Result := LConn;
  finally
    FMREW.EndWrite;
  end;
end;

procedure TConnectionsManager.EndConnection(ATag: NativeUInt = 0);
var
  LKey: NativeUInt;
  LConn: IConnection;
begin
  FMREW.BeginWrite;
  try
    if ATag > 0 then
      LKey := ATag
    else
      LKey := TThread.CurrentThread.ThreadID;
    if FDicConn.TryGetValue(LKey, LConn) then
    begin
      LConn.Disconnect;
      FDicConn.Remove(LKey);
    end;
  finally
    FMREW.EndWrite;
  end;
end;

function TConnectionsManager.CurrentConnection: IConnection;
var
  LKey: NativeUInt;
  LConn: IConnection;
begin
  FMREW.BeginRead;
  try
    LKey := TThread.CurrentThread.ThreadID;
    if FDicConn.TryGetValue(LKey, LConn) then
      Exit(LConn);
    raise EThread.Create('No current connection for thread');
  finally
    FMREW.EndRead;
  end;
end;

function TConnectionsManager.FindConnection(ATag: NativeUInt; var AConn: IConnection): Boolean;
begin
  FMREW.BeginRead;
  try
    Result := FDicConn.TryGetValue(ATag, AConn);
  finally
    FMREW.EndRead;
  end;
end;

function MainConnection: IConnection;
begin
  Result := objConnectionsManager.CurrentConnection;
end;

function fCurrentDate: String;
begin
  Result := fCurrentDate(VS_Date);
end;

function fCurrentDate(Const Value: TDateTime): String;
begin
  Result := 'CAST("' + FormatDateTime('yyyy-mm-dd', Value) + '" AS DATE)';
end;

function fCurrentDateTime: String;
begin
  Result := fCurrentDateTime(VS_Date + Time);
end;

function fCurrentDateTime(Const Value: TDateTime): String;
begin
  Result := 'CAST("' + FormatDateTime('yyyy-mm-dd hh:mm:ss', Value) + '" AS DATETIME)';
end;

{*************************************************}
{*   Grava Mensagens de Erro no Arquivo de LOG   *}
{**********************************************DV*}
procedure pGravarErro(GravarErro:Boolean; MensagemErro:String; strRelatorio: String='');
  Var
    qryLogErr: IQuery;
begin
  If Not GravarErro Then
    Exit;

  if strRelatorio.IsEmpty then
    strRelatorio := GetStackTrace;

  qryLogErr := fCriaQuery;
  qryLogErr.SQL.Add('SELECT * FROM LOGERR WHERE FALSE');

  Try
    With qryLogErr Do
    Begin
      Open;
      Append;
      FieldByName('LOG_CODEMP').AsString   := VS_strCodEmp;
      FieldByName('LOG_LOGOPE').AsString   := strLoginUsuarioLogado;
      FieldByName('LOG_DTAERR').AsDateTime := VS_Date;
      FieldByName('LOG_HORERR').AsDateTime := Time;
      FieldByName('LOG_DESCRI').AsString   := MensagemErro;
      If Not fEmptyStr(strRelatorio) Then
        FieldByName('LOG_RELERR').AsString   := strRelatorio;
      Post;
      Close;
    End;
  Except
    On E: Exception Do
      Raise Exception.Create('[fGravaLogErr] - ' + E.Message);
  End;
end;

Function fDoubleAggregate(cdsClient: TUniClientDataSet; strNomCam: String): Double;
Begin
  With cdsClient Do
  If TAggregateField(FieldByName(strNomCam)).Value = Null Then
    Result := 0
  Else
    Result := TAggregateField(FieldByName(strNomCam)).Value;
End;

procedure pSetaClient(cdsClient: TDataSet);
  Var
    intContador: Integer;
Begin
  For intContador := 0 To cdsClient.Fields.Count - 1 Do
  Begin
    If cdsClient.Fields[intContador].ReadOnly Then
      cdsClient.Fields[intContador].ProviderFlags := cdsClient.Fields[intContador].ProviderFlags - [pfInWhere, pfInUpdate];
    cdsClient.Fields[intContador].ReadOnly := False;
    cdsClient.Fields[intContador].Required := False;
  End;
End;

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
    EnableControls;
    AfterScroll := prcScroll;
    If blnRefresh then
      AfterScroll(dtsDataSet)
  End;
End;

Function fDataAggregate(cdsClient: TUniClientDataSet; strNomCam: String): TDateTime;
Begin
  With cdsClient Do
  If TAggregateField(FieldByName(strNomCam)).Value = Null Then
    Result := 0
  Else
    Result := TAggregateField(FieldByName(strNomCam)).Value;
End;

Function fIntAggregate(cdsClient: TUniClientDataSet; strNomCam: String): Integer;
Begin
  With cdsClient Do
  If TAggregateField(FieldByName(strNomCam)).Value = Null Then
    Result := 0
  Else
    Result := TAggregateField(FieldByName(strNomCam)).Value;
End;

Procedure pCriaAggregate(cdsClient: TUniClientDataSet; strNomCam, strNomAgg:String; strFormat: String = '#,##0.00');
Begin
  With TAggregateField.Create(cdsClient) Do
  Begin
    Name          := strNomAgg;
    FieldName     := strNomAgg;
    DataSet       := cdsClient;
    Expression    := 'SUM(' + strNomCam + ')';
    DisplayFormat := strFormat;
    Active        := True;
  End;
End;

function fRetornaInformacaoVenda(strNumDoc, strEspDoc, strCodEmp, strCampo: String): String;
begin
  Result := fRetornaInformacaoVenda(strNumDoc, strEspDoc, strCodEmp, '', strCampo);
end;

function fRetornaInformacaoVenda(strNumDoc, strEspDoc, strCodEmp, strCodCli, strCampo: String): String; overload;
  Const
    ARRTABELAS: Array[1..6] Of String = ('FATGOR', 'MOVGER', 'NOTGER', 'DEL_FATGOR', 'DEL_MOVGER', 'DEL_NOTGER');
  Var
    qryGen: IQuery;
    intTab: Integer;
    strAbvTab: String;
    strCampoAux: String;

  function fGetSQL(strTabela: String): String;
  begin

    Result := '';
    Result := Result + 'SELECT ' + strCampoAux + ' AS CAMPO ';
    Result := Result + 'FROM   ' + strTabela + '       ';
    Result := Result + 'WHERE  ' + strAbvTab + 'NUMDOC = "' + strNumDoc + '" AND ';
    Result := Result + '       ' + strAbvTab + 'ESPDOC = "' + strEspDoc + '" AND ';
    Result := Result + '       ' + strAbvTab + 'CODEMP = "' + strCodEmp + '"     ';

    If Not strCodCli.IsEmpty Then
      Result := Result + ' AND ' + strAbvTab + 'CODCLI = "' + strCodCli + '"     ';

    If Pos('FATGOR', strTabela) <= 0 Then
      Result := Result + ' AND ' + strAbvTab + 'TIP_FC = "C" ';
  end;

begin
  Result := '';

  qryGen := fCriaQuery;

  With qryGen, SQL Do
  Begin
    For intTab := Low(ARRTABELAS) To High(ARRTABELAS) Do
    Begin
      If (Pos('FATGOR', ARRTABELAS[intTab]) > 0) And (Pos(strEspDoc, 'PD_OR_') <= 0) Then
        Continue;

      If Pos('FATGOR', ARRTABELAS[intTab]) > 0 Then strAbvTab := 'FGO_' Else strAbvTab := 'GER_';

      strCampoAux := AnsiReplaceStr(strCampo, strAbvTab, '');

      If strCampoAux <> 'AUTOINCREM' Then
        strCampoAux := strAbvTab + strCampoAux;

      If Not fCampoExiste(ARRTABELAS[intTab], strCampoAux) Then
        Continue;

      Clear;
      Add(fGetSQL(ARRTABELAS[intTab]));
      Open;

      Result := FieldByName('CAMPO').AsString;

      If Not fEmptyStr(Result) Then
        Break;
    End;
  End;
end;

function fDestacarDescontoDaCondicaoPagamentoNoCampoDescontoDosItensEmPromocao: Boolean;
begin
  Result := (fCfgSis('CNDVEN') = 'I') And fCfgSis('PRODES', varBoolean) And fCfgSis('PROCND', varBoolean);
end;

function fRetValorCampoIteGer(strCodIte, strCodEmp, strTabela, strCampo: String): String;
Begin
  Result := fCampoTabela(strCampo, strTabela, ['ITE_CODITE','ITE_CODEMP'], [strCodIte,strCodEmp], False);
End;

function fRetDescPromocao(Const strCodPro: String): String;
begin
  Result := fCampoTabela('PRO_DESPRO', 'CADPRO', ['PRO_CODPRO'], [strCodPro], False);
end;

function fRetPrecisaoMargemItem: Integer;
  Var
    qryAux: IQuery;
    strAux: String;
Begin
  Result := 2;

  If VS_intPrecisaoMargemItem > -1 Then
  Begin
    Result := Max(Result, VS_intPrecisaoMargemItem);
    Exit;
  End;

  qryAux := fCriaQuery();
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
end;

function fRetQtdElementosKey(strKey: String; wrdMes, wrdAno: Word; var strAutInc: String; blnRobo: Boolean): Integer;
var
  qryKeyEle: IQuery;
begin
  Result := 0;

  qryKeyEle := fCriaQuery;

  qryKeyEle.Close;
  qryKeyEle.SQL.Text :=
  ' SELECT '+
  '   AUTOINCREM, '+
  '   KEY_CONELE '+
  ' FROM '+
  '   KEYELE '+
  ' WHERE '+
  '   KEY_KEYAPI = :KEYAPI AND '+
  '   KEY_COMPET = :COMPET AND '+
  '   KEY_A_N_O_ = :A_N_O_ AND '+
  '   KEY_CONPOR = :CONPOR ';

  qryKeyEle.ParamByName('KEYAPI').AsString := strKey;
  qryKeyEle.ParamByName('COMPET').AsString := fStrZero(wrdMes.ToString,2);
  qryKeyEle.ParamByName('A_N_O_').AsString := wrdAno.ToString;
  qryKeyEle.ParamByName('CONPOR').AsString := IIF(blnRobo, 'R', 'A');
  qryKeyEle.Open;

  if not qryKeyEle.IsEmpty then
  begin
    strAutInc := qryKeyEle.FieldByName('AUTOINCREM').AsString;
    Result := qryKeyEle.FieldByName('KEY_CONELE').AsInteger;
  end;
end;

Procedure pCloneDataSet(dtsDestino, dtsOrigem: TUniClientDataSet; blnComFomatacao: Boolean = False; blnComIndiceOrdGrid: Boolean = False);
  Var
    intContador: Integer;
Begin

  Try
    dtsOrigem.DisableControls;

    pCloneData(dtsDestino, dtsOrigem, blnComIndiceOrdGrid);

    dtsDestino.LogChanges := False;

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
    dtsOrigem.EnableControls;
  End;

End;

procedure pCloneData(const objDestino, objOrigem: TUniClientDataSet; blnComIndiceOrdGrid: Boolean = False);
var
  IndexNameOrigem: string;
  IndexOptions: TIndexOptions;
  FieldName: string;
begin
  If blnComIndiceOrdGrid Then
  Begin
    IndexNameOrigem := objOrigem.IndexName;

    if (not IndexNameOrigem.IsEmpty) and (Pos(UpperCase(cnsNomeIdxGrid), UpperCase(IndexNameOrigem)) > 0) then
    begin
      objOrigem.IndexName  := NullAsStringValue;
      objDestino.IndexName := NullAsStringValue;

      objDestino.Data := objOrigem.Data;

      FieldName := Copy(IndexNameOrigem, 1, Pos(UpperCase(cnsNomeIdxGrid), UpperCase(IndexNameOrigem)) - 1);
      if Assigned(objDestino.FindField(FieldName)) then
      begin
        objDestino.IndexDefs.Update;
        IndexOptions := [];

        if Pos(UpperCase(cnsNomeIdxGrid + 'ASC'), UpperCase(IndexNameOrigem)) = 0 then
          IndexOptions := [ixDescending];

        objDestino.AddIndex(IndexNameOrigem, FieldName, IndexOptions);
      end;

      if not IndexNameOrigem.IsEmpty then
      begin
        objDestino.IndexName := IndexNameOrigem;
        objOrigem.IndexName := IndexNameOrigem;
      end;
    end
    else
    begin
      objDestino.Data := objOrigem.Data;
    end;
  End
  Else
  Begin
    objDestino.Data := objOrigem.Data;
  End;
end;

Function fRetDescricao(strCodigo, strNomTab, strCamCod, strCanDes: String): String;
  Var
    qryTabela: IQuery;
Begin
  qryTabela := fCriaQuery;
  With qryTabela, SQL Do
  Begin
    Add('SELECT');
    Add(strCanDes);
    Add('FROM');
    Add(strNomTab);
    Add('WHERE');
    Add(strCamCod + ' = ' + QuotedStr(strCodigo));

    Open;

    If IsEmpty Then
      Result := ''
    Else
      Result := FieldByName(strCanDes).AsString;

    Close;
  End;
End;

function fRetNomBanco(Const strCodBco: String): String;
Begin

  Result := '';

  If fEmptyStr(strCodBco) Then
    Exit;

  Result := fCampoTabela('BCO_NOMBCO', 'CADBCO', ['BCO_CODBCO'], [strCodBco], False);

end;

function fCriaClientDataset(ASQL: String; AOwner: TComponent = Nil): TUniClientDataSet;
Var
  LQuery: IQuery;
begin
  LQuery := fCriaQuery;
  Try
    LQuery.SQL.Text := ASQL;
    LQuery.Open;
    Result := fCriaClientDatSet(TDataSet(LQuery.GetObject));
  Finally

  End;
end;

procedure pCopiaRegistroDataSet(dtsOrigem  : TDataSet;
                                dtsDestino : TDataSet;
                                blnEdit    : Boolean = False;
                                blnInsert  : Boolean = False);
  Var
    intCont  : Integer;
begin
  If blnEdit Then
    dtsDestino.Edit
  Else
  If blnInsert Then
    dtsDestino.Insert
  Else
    dtsDestino.Append;
  With dtsOrigem Do
    For intCont := 0 To Fields.Count -1 Do
      dtsDestino.Fields[intCont].Value := Fields[intCont].Value;
  dtsDestino.Post;
end;

function fRetHoraServidor: TTime;
begin
  Try
    With fCriaQuery Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT CURRENT_TIME');
      Open;

      Result := FieldByName('CURRENT_TIME').AsDateTime;
    End;
  Except
    Result := Time;
  End;
end;

function fRetDataServidor: TDate;
begin
  Try
    With fCriaQuery Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT CURRENT_DATE');
      Open;
      Result := FieldByName('CURRENT_DATE').AsDateTime;
    End;
  Except
    Result := Date();
  End;
end;

function fRetDtaHraServidor : TDateTime;
var
  qryDtaHra : IQuery;
begin
  Try
    qryDtaHra := fCriaQuery();
    qryDtaHra.Close;
    qryDtaHra.SQL.Clear;
    qryDtaHra.SQL.Add('SELECT CURRENT_TIMESTAMP AS DATA_HORA');
    qryDtaHra.Open;
    Result := qryDtaHra.FieldByName('DATA_HORA').AsDateTime;
  Except
    Result := Now();
  End;
end;

{**********************************************************************}
{* CRIA UM CLIENTDATASET COM A MESMA ESTRUTURA E VALORES DE UMA QUERY *}
{*******************************************************************JC*}
function fCriaClientDatset(qryOrigem: TDataset; blnVazio: Boolean = False;
 AOwner: TComponent = Nil; blnRegistroAtual: Boolean = False; arrAddFields: TArray<TField> = Nil; arrSizeFields: TArray<TRecSizeField> = Nil): TUniClientDataSet;
  Var
    intCont  : Integer;
    intIdx_  : Integer;
    intSize  : Integer;
    intRecno : Integer;
begin

  Result := TUniClientDataSet.Create(AOwner);

  For intCont := 0 To qryOrigem.Fields.Count -1 Do
  Begin
    intSize := qryOrigem.Fields[intCont].Size;

    If Assigned(arrSizeFields) Then
    Begin
      For intIdx_ := 0 To Length(arrSizeFields) -1 Do
      Begin
        If (qryOrigem.Fields[intCont].FieldName = arrSizeFields[intIdx_].Name) Then
          intSize := arrSizeFields[intIdx_].Size
      End;
    End;

    With Result.FieldDefs.AddFieldDef Do
    Begin
      Name     := qryOrigem.Fields[intCont].FieldName;
      DataType := qryOrigem.Fields[intCont].DataType;
      Size     := intSize;
      Required := False;
    End;
  End;

  For intCont := 0 To Length(arrAddFields) -1 Do
    Result.FieldDefs.Add(arrAddFields[intCont].FieldName,
                         arrAddFields[intCont].DataType,
                         arrAddFields[intCont].Size,
                         False);

  Result.CreateDataSet;
  Result.Open;

  Result.LogChanges := False;

  If blnVazio Then
    Exit;

  With qryOrigem Do
  Begin
    intRecno := RecNo;
    DisableControls;

    If Not blnRegistroAtual Then
      First;

    While (Not Eof) Or blnRegistroAtual Do
    Begin
      Result.Append;

      For intCont := 0 To Fields.Count -1 Do
        Result.Fields[intCont].Value := Fields[intCont].Value;

      Result.Post;

      If blnRegistroAtual Then
        Break;

      Next;
    End;
    RecNo := intRecno;
    EnableControls;
  End;

end;

function fRetClaIpi(strCodIte: String): String;
  Var
    qryAux: IQuery;
begin
  qryAux := fCriaQuery;
  qryAux.SQL.Add('SELECT ITE_CLAIPI FROM CADITE WHERE ITE_CODITE = :CODITE');
  qryAux.ParamByName('CODITE').AsString := strCodIte;
  qryAux.Open;
  Result := qryAux.FieldByName('ITE_CLAIPI').AsString;
end;

function fRetornaTipoDoCampo( strTabela: string = ''; strCampo: string = '' ) : String;
Var
  qryAux: IQuery;
Begin
  if (strTabela = '') Then
    Result := '';
  if (strCampo = '') Then
    Result := '';
  if (strTabela <> '') And (strCampo <> '') Then
  Begin
    qryAux := fCriaQuery;
    qryAux.SQL.Text := 'DESC ' + strTabela;
    qryAux.Open;
    While (Not qryAux.Eof) Do
    Begin
      If ( qryAux.FieldByName('Field').AsString = strCampo ) Then
        Result := UpperCase(qryAux.FieldByName('Type').AsString);
      qryAux.Next;
    End;
  End;
End;

function fUsaProCodigo(strNomeTabela: String): Boolean;
Var
  strSQL   : String;
  qryGenAut: IQuery;
begin
  Try
    qryGenAut := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  PRO_CODAUT AS CODAUT ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  PROCOD ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  PRO_NOMARQ = :NOMARQ ';

    With qryGenAut Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NOMARQ').AsString := strNomeTabela;
      Open;
      Result := (FieldByName('CODAUT').AsString = 'S');
      Close;
    End;

  Finally

  End;
end;

function fClienteConsumidor(strNomCli: String; blnCliBal: Boolean = False; blnSeguradora: Boolean = False): Boolean;
begin

  Result := False;

  If Pos('CONSUMIDOR', strNomCli) > 0 Then
    Result := True;

  If blnCliBal Then
  Begin

    If Pos('BALCAO', strNomCli) > 0 Then
      Result := True

    Else If Pos('BALC√O', strNomCli) > 0 Then
      Result := True;

  End;

  If blnSeguradora And (Pos('SEGURADORA', strNomCli) > 0) Then
    Result := True;

end;

function fFormataNome(strNome: String; blnSoPrimeiroNome: Boolean = False): string;
const
  excecao: array[0..5] of string = (' da ', ' de ', ' do ', ' das ', ' dos ', ' e ');
var
  tamanho, j: integer;
  i: byte;
begin
  Result := AnsiLowerCase(Trim(strNome));
  if (blnSoPrimeiroNome) and (Pos(' ', Result) > 0) then
    Result := Copy(Result, 1, Pos(' ', Result)-1);

  tamanho := Length(Result);

  for j := 1 to tamanho do
  begin
    if (j = 1) or ((j>1) and (Result[j-1]=Chr(32))) then
      Result[j] := AnsiUpperCase(Result[j])[1];
  end;

  for i := 0 to Length(excecao)-1 do
    Result:= StringReplace(result,excecao[i],excecao[i],[rfReplaceAll, rfIgnoreCase]);
end;

function fPermiteFaturamentoEntrega(strCodCli: String; strCampoDiaMes, strCampoDiaSemana: String; dtaData: TDateTime): Boolean;
  Var
    strDiaMes : String;
    strDiaSem : String;
    intCnt : Integer;
    intDiaSem : Integer;
begin
  Result := True;

  If (Not fCfgSis('UTDTFE', varBoolean)) Then
    Exit;

  strDiaMes := fCampoTabela(strCampoDiaMes, 'CADCLI', ['CLI_CODCLI'], [strCodCli]);
  strDiaSem := fCampoTabela(strCampoDiaSemana, 'CADCLI', ['CLI_CODCLI'], [strCodCli]);

  strDiaSem := fPadR(strDiaSem, 7, 'N');
  intDiaSem := DayOfWeek(dtaData);

  For intCnt := 1 To 7 Do
  Begin
    If (intDiaSem = intCnt) Then
    Begin
      Result := (strDiaSem[intCnt] = 'S');
      Break;
    End;
  End;

  If (Result) Then
    Result := fTransform(strDiaMes, 2).Contains(fStrZero(DayOf(dtaData), 2));
End;

function fConexaoAtiva(): Boolean;
begin
  Result := Assigned(objConnectionsManager) and objConnectionsManager.CurrentConnection.Connected;
end;

function fGetConnectionID(): String;
  Var
    qryAux: IQuery;
begin
  qryAux := fCriaQuery();
  qryAux.SQL.Add('SELECT CONNECTION_ID()');
  qryAux.Open;
  Result := qryAux.Fields(0).AsString;
end;

function fAjustaNovaSenhaComLetraMaiuscula(const ASenha: String): String ;
const
  A = 1 ;
  F = 5 ;
var
  LSenha: String ;
  LCnt: Integer ;
begin
  // essa funÁ„o foi necess·ria, pois o fDecrypt/fCrypt sÛ aceita letras maiusculas
  Result := '' ;
  LSenha := LowerCase(ASenha) ;
  for LCnt := 1 to Length(LSenha) do
  begin
    if LCnt in [A, F] then
      Result := Result + UpperCase(LSenha[LCnt])
    else
      Result := Result + LSenha[LCnt];
  end;
end;

initialization

pDefinirUsuarioConexao(fDecrypt('„ùÎ‡õ¿‰ÊõÎÏë').ToLower, fDecrypt('„ùÎ‡õ¿ùÁÏ‰ë„ùí').ToLower);

objConnectionsManager := nil;

VS_intPrecisaoMargemItem := -1;
VS_intTamDocCadRec := -1;
VS_intTamCadIte := -1;

finalization

If Assigned(VS_stlTabNre) then
  FreeAndNil(VS_stlTabNre);

end.
