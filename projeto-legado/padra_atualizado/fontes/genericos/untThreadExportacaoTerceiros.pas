unit untThreadExportacaoTerceiros;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
  untFuncoesGenerica, Faturamento.Classes.TFatVendaBase,
  Services.ConsultarPreco.Tinta,
{$ELSE}
  Windows, ActiveX, UniClientDataSet, untFuncoesSimples, untFuncoes,
  cxProgressBar, UniDataSetProvider, Forms, FireDAC.VCLUI.Wait,
  untConexaoThread,
{$ENDIF}
  Classes, Uni, SysUtils, untCadPro, DB, Math, DateUtils,
  System.Generics.Collections, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.UI, strUtils;

type
  //hack para retornar somente precos (melhoria de performance)
  TConsultarPrecoTintaHack = class(TConsultarPrecoTinta);

Type
  TValidateInf = Record
    strIdePro: string;
    strMD5Key: string;
    strTabPre: string;
    strEmbPro: String;
    strModVen: String;
    strCodDil: String;
    fltPreCus: Double;
    fltPreVen: Double;
    fltPreVe1: Double;
    fltPreVe2: Double;
    fltPreVe3: Double;
    fltPreVe4: Double;
    fltPreVe5: Double;
    fltPreVe6: Double;
    fltPreVe7: Double;
End;


type
  TThreadExportacaoTerceiros = class(TThread)
  private
    Banco: TUniConnection;
    qryInsert   : TFDQuery;
    FDDatabase  : TFDConnection;
    FDDriverLink: TFDPhysMySQLDriverLink;
    FDCursor    : TFDGUIxWaitCursor;
    fatVenda: TFatVendaBase;
    objPrecoTinta: TConsultarPrecoTinta;
    blnExportacaoNova: Boolean;
    strDataBase: String;
    procedure pSetPosicao(intMax: Integer);
    procedure pSetIdePro(const Value: String);    
  protected
   {$IFDEF LINUX}
    FInicioExportacao: TDateTime;
    FValidateIndexList: TList<Integer>;
   {$ENDIF}

    procedure Execute; override;
    procedure pCriaTabelaExportacao(); Virtual;
    Procedure pCriaBkpExportacao(); Virtual;
    Procedure pTabelaExportacaoAnterior; Virtual;

    //Validar Formulas - Procedures
    Procedure pValidacaoFormula(FInfo: TValidateInf; EEmpresa: String = ''); Virtual;
    procedure pIniciarObjetosValidacao;
    procedure pFinalizarObjetosValidacao;
    Procedure pCarregarClienteValidacao;
    Procedure pCarregarVendedorValidacao;
    Procedure pCarregarCondicaoPagtoValidacao;
    procedure pPrecosTintaValidacao(FInfo: TValidateInf);
    Procedure pCompararPrecosValidacao(AValA, AValB: Double; AInfo: string; FInfo: TValidateInf);
    function fTabelaExisteNovo(strNomeTabela: String; strDataBase: String): Boolean;

   {$IFDEF LINUX}
    procedure pGerarArrayValidacao(ACount: Integer);
    procedure pEscreverAguardeCalculando;
    procedure pEscreverAguardeInserindo;
    procedure pEscreverLogProgresso(qryGen: TUniQuery);
    Procedure pEscreverLogBackup;
    Procedure pLogCriouBackup(blnCriou: Boolean);
    function fValidarPrecosCalculado(AFinished: Boolean = False; AMaxThr: Integer = 5): Boolean;
   {$ENDIF}

    procedure pApagaTabelaExportacao;
    procedure pLimparTabelaExportacao;

    procedure pRetornaPrecoTinta(dicRetorno: TDicionario; qryColorantes,
      qryBases: TUniQuery; fltPerAcr: Double); virtual; abstract;
    procedure pGravaTintometricoTabelasTerceiros(qryInsert: TFDQuery;
      fltPreVen: Double; qryTinta: TUniQuery; intParam: Integer = 0); virtual; abstract;
    procedure pRetornaQuantidadeFormulacao(dicRetorno: TDicionario;
      qryGen: TUniQuery; qryBases: TUniQuery); virtual; abstract;
    procedure pPreencheDicRetorno(dicRetorno: TDicionario; qryGen: TUniQuery;
      strTabUni, strTabPre: String); virtual; abstract;
    function fCriaTabelaColorantes: TUniQuery; virtual;
    procedure pStep(intStep, intMax: Integer); Overload;
    procedure pStep; Overload;
    procedure pSetaParametrosEspecificos(Conexao: TUniConnection); virtual;
    procedure pProcessaTabelaCores(qryInsert: TFDQuery; qryGen, qryBases, qryColorantes: TUniQuery;
      strTabUni, strTabPre: String; fltPerAcr: Double; dicRetorno: TDicionario); Virtual;
    function RepetirPorTipo(): Integer; Virtual;
  public
    FStatus: String;
    FIdePro: String;
    intTipo: Integer;
    intLinha: Integer;
    intDiluente: Integer;
    FProgresso: TcxProgressBar;
    //Geracao automatica
    FAutoma: Boolean;
    intMax: Integer;
    VS_EmpExportacao: String;

    const BATCH_SIZE: Integer = {$IFDEF LINUX} 100 {$ELSE} 5000 {$ENDIF};

    class var FErrors: TDictionary<String, TStringList>;
    class var FMREW: TMultiReadExclusiveWriteSynchronizer;
    class procedure pAddError(AIdePro, AMsg: string);
    class function fGetErrors(AIdePro: string): TStringList;

    function fNomeTabela: String; virtual; abstract;
    function fCamposTabela: String; virtual; abstract;
    function fCamposSelect: String; virtual; abstract;
    function fQuantidadeFormulacao: Integer; virtual; abstract;
    function fFatorTinta: Double; virtual; abstract;
    function fRetMD5KEY: String; virtual; abstract;
    function fRetItemBase: String; virtual; abstract;
    function fRetDescricao: String; virtual; abstract;
    function fRetFormula(intCont: Integer): String; virtual; abstract;
    function fRetQuantidade(intCont: Integer): String; virtual; abstract;
    function fSQLInsert: String; virtual; abstract;
    procedure pAdicionaParamentros(Var DataSet: TFDQuery;
      qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0); virtual; abstract;
    function fRetornaColorantes: String; virtual; abstract;
    function fRetornaBases: String; virtual; abstract;
    function fRetornaPercentualAcrescimo(Conexao: TUniConnection): Double; virtual; abstract;
    function fRetEmbalagem(qryColorantes: TUniQuery): Double; virtual; abstract;
    function fRetCODEMP: String; Virtual;
    procedure pSetarEmpresaExportacao(); Virtual;
    procedure pIncluirLogTinSite(Conexao: TUniConnection; strStatus: String); virtual; abstract;
    Procedure pUpdateLogTinSite(Conexao: TUniConnection; strStatus: String); Virtual;
    function fRetornaTabelaPreco: String; Virtual;
    //Função fGetPorLinha, utilizado para gerar cadastro de empresas para tinta imobiliaria {RG}
    function fGetPorLinha(): Integer; Virtual;
    function fGetTipoFormula(qryGen: TUniQuery; qryBases: TUniQuery): Integer; Virtual;
    function fCarregaPromocao(strCodIte, strTabPre, strCodCli, strCodCnd: String;
        intPrzMed: Integer; var fltPreCus, fltPreVen: Double): Boolean;
    function fCriaNovaQuery(strSQL: String): TUniQuery;
    procedure pCriaNovaQuery(qryGen: TUniQuery; strSQL: String);
    constructor Create(pgbProgresso: TcxProgressBar; strIdePro: String;
      blnAuto: Boolean = False); reintroduce; virtual;
    destructor Destroy; override;
    property strIdePro: String Read FIdePro Write pSetIdePro;

  end;

Type
  TConsultarPrecoPromocaoCache = class sealed
  private
    Type
      TRetorno = record
        fltPreCus,
        fltPreVen,
        fltComVar,
        fltComAta,
        fltComDis,
        fltQtdDis,
        fltDesF07: Double;
        strComPro: String;
        strCodPro: String;
        blnParticiona,
        blnPromo: Boolean;
        blnResult: Boolean;
      end;
  private
    class Var FDicPrecosPromocao: TDictionary<String, TConsultarPrecoPromocaoCache.TRetorno>;
  public
    class function fRetornaPrecosPromocao(strCodIte,
                                          strCodCli: String;
                                          dtaDtaPro: TDateTime;
                                          fltQtdDig,
                                          fltQtdJaDig,
                                          fltQtdJaEmPromoc: Double;
                                          intPraMed: Integer;
                                          Var fltPreCus,
                                          fltPreVen,
                                          fltComVar,
                                          fltComAta,
                                          fltComDis,
                                          fltQtdDis,
                                          fltDesF07: Double;
                                          Var strComPro: String;
                                          var strCodPro: String;
                                          Var blnParticiona,
                                          blnPromo: Boolean;
                                          strTabPre: String;
                                          strCodCnd: String;
                                          strPrzPro: String = '';
                                          strENTBRF: String = '';
                                          blnConsideraQtd: Boolean=True;
                                          blnBuscaPreco: Boolean=False;
                                          strIteVid: String = '-1';
                                          blnEntIme: Boolean=False;
                                          blnEntFut: Boolean=False;
                                          strMotFut: String = '';
                                          strEmpPro: String = '';
                                          strNumOrc: String = '';
                                          strEspOrc: String = '';
                                          Conexao: TUniConnection = Nil;
                                          blnEhConsulta: Boolean = False): Boolean;
  end;

type
  TComp = Record
    Componente: String;
    Quantidade: Double;
    Quantiddil: Double;
    Tipo      : String;
  end;

{$IFDEF LINUX}
type
  TThreadValidarPrecos = class(TThread)
  public type
    TValidateInfo = record
      strIdePro: string;
      strMD5Key: string;
      strTabPre: string;
      strEmbPro: String;
      strModVen: String;
      strCodDil: String;
      fltPreCus: Double;
      fltPreVen: Double;
      fltPreVe1: Double;
      fltPreVe2: Double;
      fltPreVe3: Double;
      fltPreVe4: Double;
      fltPreVe5: Double;
      fltPreVe6: Double;
      fltPreVe7: Double;
end;
  private
    FInfo: TValidateInfo;
    FEmpresa: String;
    fatVenda: TFatVendaBase;
    objPrecoTinta: TConsultarPrecoTinta;
  public
    class var FThreads: Integer;
    class var FErrors: TDictionary<String, TStringList>;
    class var FMREW: TMultiReadExclusiveWriteSynchronizer;
    class procedure pAddError(AIdePro, AMsg: string);
  private
    procedure pIniciarObjetos;
    procedure pFinalizarObjetos;
    procedure pCarregarCliente;
    procedure pCarregarVendedor;
    procedure pCarregarCondicaoPagto;
    procedure pValidarPrecosTinta;
  protected
    procedure Execute; override;
  public
    class procedure pWaitThreads(AMax: Integer);
    class function fGetErrors(AIdePro: string): TStringList;
    constructor Create(AValidateInfo: TValidateInfo; AEmpresa: String = ''); reintroduce;
    destructor Destroy; override;
  end;
{$ENDIF}

implementation

{ TThreadValidarPrecos }

{$IFDEF LINUX}
constructor TThreadValidarPrecos.Create(AValidateInfo: TValidateInfo; AEmpresa: String = '');
begin
  inherited Create(False);
  FInfo := AValidateInfo;
  FEmpresa := AEmpresa;
  FreeOnTerminate := True;
  AtomicIncrement(FThreads);
end;

destructor TThreadValidarPrecos.Destroy;
begin
  AtomicDecrement(FThreads);
  inherited;
end;


procedure TThreadValidarPrecos.Execute;
begin
  inherited;
  objConnectionsManager.BeginConnection();
  Try
    pIniciarObjetos;
    Try
      Try
        pCarregarCliente;
        pCarregarVendedor;
        pCarregarCondicaoPagto;
        objPrecoTinta := TConsultarPrecoTinta.Create(fatVenda, FInfo.strIdePro, FInfo.strMD5Key, FInfo.strTabPre, FInfo.strEmbPro, FInfo.strModVen, FInfo.strCodDil);
        try
          TConsultarPrecoTintaHack(objPrecoTinta).pRetornarPrecosTinta(FEmpresa);
          pValidarPrecosTinta;
        finally
          FreeAndNil(objPrecoTinta);
        end;
      Except
        On E: Exception do
          pAddError(FInfo.strIdePro, E.Message);
      End;
    Finally
      pFinalizarObjetos;
    End;
  Finally
    objConnectionsManager.EndConnection();
  End;
end;

class function TThreadValidarPrecos.fGetErrors(AIdePro: string): TStringList;
begin
  FMREW.BeginRead;
  try
    Result := FErrors[AIdePro];
  finally
    FMREW.EndRead;
  end;
end;

procedure TThreadValidarPrecos.pCarregarCliente;
begin
  fatVenda.pCarregaDadosClienteBaixa(fRetClienteConsumidor(fCadEmp('ESTADO')));
end;

procedure TThreadValidarPrecos.pCarregarCondicaoPagto;
begin
  fatVenda.pAtualizaInformacoesCondPagamento;
  fatVenda.intPrzMed := fFloatToInt(fCalcMediaPagto(fatVenda.strConPag));
  fatVenda.blnTaxVpr := False;
  fatVenda.fltTaxJur := 0.00;
end;

procedure TThreadValidarPrecos.pCarregarVendedor;
begin
  if fEmptyStr(fatVenda.strCodVen) then
  begin
    fatVenda.strCodVen := strLoginUsuarioLogado;
    fatVenda.strNomVen := fRetNomVendedor(fatVenda.strCodVen);
    fatVenda.fltComVen := fCampoTabela('OPE_PERCOM', 'CADOPE', ['OPE_CODOPE'], [strLoginUsuarioLogado], False);
    fatVenda.strTipVen := fCampoTabela('OPE_INTEXT', 'CADOPE', ['OPE_CODOPE'], [strLoginUsuarioLogado], False);
  end;
  if fEmptyStr(fatVenda.strCodDig) then
  begin
    fatVenda.strCodDig := strLoginUsuarioLogado;
    fatVenda.strNomDig := fRetNomVendedor(fatVenda.strCodDig);
  end;
end;

procedure TThreadValidarPrecos.pFinalizarObjetos;
begin
  fatVenda.pFreeCdsVenda;
  If Assigned(Self.fatVenda) Then
    FreeAndNil(Self.fatVenda);
  if Assigned(objPrecoTinta) then
    FreeAndNil(objPrecoTinta);
end;

procedure TThreadValidarPrecos.pValidarPrecosTinta;

  procedure pCompararPrecos(AValA, AValB: Double; AInfo: string);
  const
    fltTolerancia = 0.02;
  var
    fltDif: Double;
  begin
    fltDif := Abs(fFormataFloat(AValA, 2) - fFormataFloat(AValB, 2));
    if fFormataFloat(fltDif, 2) > fltTolerancia then
    begin
      AValA := fFormataFloat(AValA, 2);
      AValB := fFormataFloat(AValB, 2);
      pAddError(FInfo.strIdePro, Format('Divergencia de preços na exportação da tinta '+
        '(%s): %s - %s valor gravado: %g - valor calculado: %g',
        [AInfo, FInfo.strIdePro, FInfo.strMD5Key, AValA, AValB]));
    end;
  end;

begin
  pCompararPrecos(FInfo.fltPreCus, objPrecoTinta.FPreCus, 'Preço de custo');
  pCompararPrecos(FInfo.fltPreVen, objPrecoTinta.FPreVen, 'Preço de Venda');
  pCompararPrecos(FInfo.fltPreVe1, objPrecoTinta.FPreVe1, 'Preço de Tabela 1');
  pCompararPrecos(FInfo.fltPreVe2, objPrecoTinta.FPreVe2, 'Preço de Tabela 2');
  pCompararPrecos(FInfo.fltPreVe3, objPrecoTinta.FPreVe3, 'Preço de Tabela 3');
  pCompararPrecos(FInfo.fltPreVe4, objPrecoTinta.FPreVe4, 'Preço de Tabela 4');
  pCompararPrecos(FInfo.fltPreVe5, objPrecoTinta.FPreVe5, 'Preço de Tabela 5');
  pCompararPrecos(FInfo.fltPreVe6, objPrecoTinta.FPreVe6, 'Preço de Tabela 6');
  pCompararPrecos(FInfo.fltPreVe7, objPrecoTinta.FPreVe7, 'Preço de Tabela 7');
end;

class procedure TThreadValidarPrecos.pAddError(AIdePro, AMsg: string);
begin
  FMREW.BeginWrite;
  try
    FErrors[AIdePro].Add(AMsg);
  finally
    FMREW.EndWrite;
  end;
end;

procedure TThreadValidarPrecos.pIniciarObjetos;
begin
  Self.fatVenda := TFatVendaBase.CreateInstance('PD', False);
  Self.fatVenda.strNomeForm := 'frmFatVendas';
  Self.fatVenda.strEspDoc := 'PD';
  Self.fatVenda.qryConIte := fCriarQueryIteGer(Self.fatVenda);
  Self.fatVenda.pCriarCdsVenda(nil);
end;

class procedure TThreadValidarPrecos.pWaitThreads(AMax: Integer);
begin
  while TThreadValidarPrecos.FThreads > AMax do
  begin
    WriteLog(Format('Aguardando threads validação preços: %d restante(s)', [TThreadValidarPrecos.FThreads]));
    Sleep(1000);
  end;
end;
{$ENDIF}

{ TThreadExportacaoTerceiros }

constructor TThreadExportacaoTerceiros.Create(pgbProgresso: TcxProgressBar;
  strIdePro: String; blnAuto: Boolean = False);
begin
  inherited Create(True);
 {$IFDEF LINUX}
  FValidateIndexList := TList<Integer>.Create;
 {$ENDIF}

  Self.strIdePro := strIdePro;

  FStatus := 'I';
  blnExportacaoNova := False;

  FProgresso := pgbProgresso;

  FAutoma := blnAuto;

  intTipo   := 0;
  intLinha  := 0;
end;

destructor TThreadExportacaoTerceiros.Destroy;
begin
 {$IFDEF LINUX}
  FValidateIndexList.Free;
 {$ENDIF}
  inherited;
end;

procedure TThreadExportacaoTerceiros.Execute;
var
  qryGen: TUniQuery;
  dicRetorno: TDicionario;
  qryColorantes,
  qryBases: TUniQuery;
  fltPerAcr: Double;
  strTabUni: String;
  strTabPre: String;
  intLin: Integer;
  blnCriouBkp: Boolean;
begin
  Try
    Try
    {$IFDEF LINUX}
      objConnectionsManager.BeginConnection;
      Banco := objConnectionsManager.CurrentConnection.GetObject as TUniConnection;
      qryGen := fCriaQuery();
    
      If Not Banco.Connected Then
        Exit;
    {$ELSE}
      CoInitialize(Nil);
      Banco  := VS_objConexaoThread.GetConexao;
      qryGen := fCriaQuery(Nil, Banco);
    {$ENDIF}
      strDataBase := qryGen.Connection.Database;
      
      pCriaBkpExportacao();
      pCriaTabelaExportacao();
      blnCriouBkp := fTabelaExisteNovo(fNomeTabela + '_BKP', strDataBase);
      pLogCriouBackup(blnCriouBkp);

      If (Not blnCriouBkp) And (Not blnExportacaoNova) Then
        Exit;

      FDDatabase := TFDConnection.Create(Nil);
      FDDriverLink := TFDPhysMySQLDriverLink.Create(Nil);
      FDCursor  := TFDGUIxWaitCursor.Create(Nil);
      qryInsert := TFDQuery.Create(Nil);

      FDDatabase.Params.Add('Database=' + qryGen.Connection.Database);
      FDDatabase.Params.Add('User_Name=' + qryGen.Connection.Username);
      FDDatabase.Params.Add('Password=' + qryGen.Connection.Password);
      FDDatabase.Params.Add('Port=' + IntToStr(qryGen.Connection.Port));
      FDDatabase.Params.Add('Server=' + qryGen.Connection.Server);
      FDDatabase.Params.Add('DriverID=MySQL');

     {$IFDEF LINUX}
      FDDriverLink.VendorLib :=  ExtractFilePath(Application.ExeName) + '/libmysqlclient.so';
     {$ELSE}
      FDDriverLink.VendorLib :=  ExtractFilePath(Application.ExeName) + '\libmysql41.dll';
     {$ENDIF}

      FDDatabase.Connected := True;

      qryInsert.Connection := FDDatabase;
      qryInsert.SQL.Text :=  fSQLInsert;

      intLinha := 0;

      For intLin := 1 To fGetPorLinha Do
      Begin
        pCriaNovaQuery(qryGen, fCamposSelect);
        pSetarEmpresaExportacao();

        If qryGen.IsEmpty Then
        Begin
          pTabelaExportacaoAnterior;
          Exit;
        End;


        With qryGen Do
        Begin
         {$IFNDEF LINUX}
          pTrimAppMemorySize;
         {$ENDIF}

          If Not IsEmpty Then
          Begin
            intMax := RecordCount;

            pSetPosicao(intMax);

            qryColorantes := fCriaTabelaColorantes;
            qryBases  := fCriaNovaQuery(fRetornaBases);

            fltPerAcr := fRetornaPercentualAcrescimo(Banco);
            strTabPre := fRetornaTabelaPreco;
            strTabUni := strTabPre;

            pSetaParametrosEspecificos(Banco);

            //Grava log de inicio da geracao
            pIncluirLogTinSite(Banco, 'N');

            dicRetorno := TDicionario.Create;

            pProcessaTabelaCores(qryInsert, qryGen, qryBases, qryColorantes, strTabUni, strTabPre, fltPerAcr, dicRetorno);

            pUpdateLogTinSite(Banco, 'S');
          End;
        End;
        intLinha := intLinha + 1;
      End;
    Except
      on E: Exception do
      begin
        pTabelaExportacaoAnterior;
        pMensagensErro(E.Message, '[Execute]');
      end;
    End;
  Finally
    Try
     {$IFNDEF LINUX}
      CoUnInitialize;
     {$ENDIF}
    Except
    End;

    If Assigned(qryGen)        Then FreeAndNil(qryGen);
    If Assigned(dicRetorno)    Then FreeAndNil(dicRetorno);
    If Assigned(qryColorantes) Then FreeAndNil(qryColorantes);
    If Assigned(qryBases)      Then FreeAndNil(qryBases);
    If Assigned(qryInsert)     Then FreeAndNil(qryInsert);
    If Assigned(FDDatabase)    Then FreeAndNil(FDDatabase);
    If Assigned(FDDriverLink)  Then FreeAndNil(FDDriverLink);
    If Assigned(FDCursor)      Then FreeAndNil(FDCursor);

    Try
      Banco.Disconnect;
    Except
    End;

    Try
    {$IFDEF LINUX}
      objConnectionsManager.EndConnection;
    {$ELSE}
      VS_objConexaoThread.Remover(GetCurrentThreadId);
    {$ENDIF}
    Except
    End;

    FStatus := 'F';
  End;
end;

function TThreadExportacaoTerceiros.fCarregaPromocao(strCodIte, strTabPre, strCodCli, strCodCnd: String;
  intPrzMed: Integer; var fltPreCus, fltPreVen: Double): Boolean;
Var
  fltComVar,
  fltComAta,
  fltComDis,
  fltQtdDis,
  fltDesF07: Double;
  blnParticiona,
  blnPromo: Boolean;
  strComPro: String;
  strCodPro: String;
begin
  Result := (Not fClienteFilial(strCodCli{$IFNDEF LINUX}, Banco{$ENDIF})) And
            (TConsultarPrecoPromocaoCache.fRetornaPrecosPromocao(
                                    strCodIte, strCodCli, VS_Date, 0, 0, 0, intPrzMed,
                                    fltPreCus, fltPreVen, fltComVar, fltComAta,
                                    fltComDis, fltQtdDis, fltDesF07, strComPro, strCodPro, blnParticiona,
                                    blnPromo, strTabPre, strCodCnd, '', '', False,
                                    False, '-1', False, False, '', '', '', '', Banco));
end;

function TThreadExportacaoTerceiros.fCriaNovaQuery(strSQL: String): TUniQuery;
begin
  Result := fCriaQuery(Nil, Banco);

  Result.Close;
  Result.SQL.Clear;
  Result.SQL.Add(strSQL);
  Result.Open;
end;

function TThreadExportacaoTerceiros.fCriaTabelaColorantes: TUniQuery;
begin
  Result := Nil;
end;

class function TThreadExportacaoTerceiros.fGetErrors(
  AIdePro: string): TStringList;
begin
  FMREW.BeginRead;
  Try
    Result := FErrors[AIdePro];
  Finally
    FMREW.EndRead;
  End;
end;

function TThreadExportacaoTerceiros.fGetPorLinha: Integer;
begin
  Result := 1;
end;

function TThreadExportacaoTerceiros.fGetTipoFormula(qryGen: TUniQuery; qryBases: TUniQuery): Integer;
begin
  Result := 0;
end;

function TThreadExportacaoTerceiros.fRetCODEMP: String;
begin
  Result := '';
end;

function TThreadExportacaoTerceiros.fRetornaTabelaPreco: String;
Var
  strCodEmp: String;
begin
  If Not VS_EmpExportacao.IsEmpty Then
    strCodEmp := VS_EmpExportacao
  Else
    strCodEmp := VS_strCodEmp;

  If (fCfgSis('PREGER', 256, strCodEmp) = '1') Then
    Result := fCfgSis('TABPRE', 256, strCodEmp)
  Else
    Result := fCfgSis('TABTER', 256, strCodEmp);
end;

function TThreadExportacaoTerceiros.fTabelaExisteNovo(strNomeTabela: String; strDataBase: String): Boolean;
Var
  qryTabela: TUniQuery;
  strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + '  SELECT                          ' +
                       '    COUNT(*) AS TABEXI            ' +
                       '  FROM                            ' +  
                       '    information_schema. TABLES    ' +
                       '  WHERE TABLE_NAME = "' + strNomeTabela + '"  ' +
                       '    AND TABLE_SCHEMA = "' + strDataBase + '" ';
    
    qryTabela := fCriaQuery();
    qryTabela.Close;
    qryTabela.SQL.Clear;
    qryTabela.SQL.Add(strSQL);
    qryTabela.Open;

    Result := (qryTabela.FieldByName('TABEXI').AsInteger > 0);
  Finally
    FreeAndNil(qryTabela);
  End;
end;

{$IFDEF LINUX}
function TThreadExportacaoTerceiros.fValidarPrecosCalculado(AFinished: Boolean = False; AMaxThr: Integer = 5): Boolean;
var
  LError: string;
begin
  Result := True;
{  if AFinished then
    TThreadValidarPrecos.pWaitThreads(0)
  else
    TThreadValidarPrecos.pWaitThreads(AMaxThr);  }

  If TThreadExportacaoTerceiros.fGetErrors(FIdePro).Count > 0 Then
  begin
    WriteError('Ocorreram erros na validação dos preços da tinta "' + FIdePro  + '"');
    For LError In TThreadExportacaoTerceiros.fGetErrors(FIdePro) Do
      WriteError(LError);
    pTabelaExportacaoAnterior;
    Result := False;
  end;
end;
{$ENDIF}

class procedure TThreadExportacaoTerceiros.pAddError(AIdePro, AMsg: string);
begin
  FMREW.BeginWrite;
  Try
    FErrors[AIdePro].Add(AMsg);
  Finally
    FMREW.EndWrite;
  End;
end;

procedure TThreadExportacaoTerceiros.pApagaTabelaExportacao;
begin
  If fTabelaExiste(fNomeTabela{$IFNDEF LINUX}, Banco{$ENDIF}) Then
    fDropTable(fNomeTabela{$IFNDEF LINUX}, Banco{$ENDIF});
end;

procedure TThreadExportacaoTerceiros.pCarregarClienteValidacao;
begin
  fatVenda.pCarregaDadosClienteBaixa(fRetClienteConsumidor(fCadEmp('ESTADO')));
end;

procedure TThreadExportacaoTerceiros.pCarregarCondicaoPagtoValidacao;
begin
  fatVenda.pAtualizaInformacoesCondPagamento;
  fatVenda.intPrzMed := fFloatToInt(fCalcMediaPagto(fatVenda.strConPag));
  fatVenda.blnTaxVpr := False;
  fatVenda.fltTaxJur := 0.00;
end;

procedure TThreadExportacaoTerceiros.pCarregarVendedorValidacao;
begin
  If fEmptyStr(fatVenda.strCodVen) Then
  Begin
    fatVenda.strCodVen := strLoginUsuarioLogado;
    fatVenda.strNomVen := fRetNomVendedor(fatVenda.strCodVen);
    fatVenda.fltComVen := fCampoTabela('OPE_PERCOM', 'CADOPE', ['OPE_CODOPE'], [strLoginUsuarioLogado], False);
    fatVenda.strTipVen := fCampoTabela('OPE_INTEXT', 'CADOPE', ['OPE_CODOPE'], [strLoginUsuarioLogado], False);
  End;

  If fEmptyStr(fatVenda.strCodDig) Then
  begin
    fatVenda.strCodDig := strLoginUsuarioLogado;
    fatVenda.strNomDig := fRetNomVendedor(fatVenda.strCodDig);
  end;
end;

Procedure TThreadExportacaoTerceiros.pCompararPrecosValidacao(AValA, AValB: Double; AInfo: string; FInfo: TValidateInf);
const
  fltTolerancia = 0.02;
var
  fltDif: Double;
begin
  fltDif := Abs(fFormataFloat(AValA, 2) - fFormataFloat(AValB, 2));
  If fFormataFloat(fltDif, 2) > fltTolerancia Then
  Begin
    AValA := fFormataFloat(AValA, 2);
    AValB := fFormataFloat(AValB, 2);
    pAddError(FInfo.strIdePro, Format('Divergencia de preços na exportação da tinta '+
      '(%s): %s - %s valor gravado: %g - valor calculado: %g',
      [AInfo, FInfo.strIdePro, FInfo.strMD5Key, AValA, AValB]));
  End;
end;

Procedure TThreadExportacaoTerceiros.pCriaBkpExportacao();
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  If Not fTabelaExisteNovo(fNomeTabela, strDataBase) Then
  Begin
    blnExportacaoNova := True;
    Exit;
  End;

  Try
    Try
      If fTabelaExisteNovo(fNomeTabela + '_BKP', strDataBase) Then
        fDropTable(fNomeTabela + '_BKP');

      pEscreverLogBackup;

      strSQL := '';
      strSQL := strSQL + AnsiReplaceStr(fCamposTabela, fNomeTabela, fNomeTabela + '_BKP');

      qryGen := fCriaQuery();
      qryGen.Close;
      qryGen.SQL.Clear;
      qryGen.SQL.Add(strSQL);
      qryGen.ExecSQL;

      strSQL := '';

      If fRetCODEMP.IsEmpty Then
        strSQL := strSQL + 'ALTER TABLE ' + fNomeTabela + '_BKP' + ' ADD UNIQUE KEY (' + fRetMD5KEY + ')'
      Else
        strSQL := strSQL + 'ALTER TABLE ' + fNomeTabela + '_BKP' + ' ADD UNIQUE KEY (' + fRetMD5KEY + ', ' + fRetCODEMP + ')';

      qryGen.Close;
      qryGen.SQL.Clear;
      qryGen.SQL.Add(strSQL);
      qryGen.ExecSQL;

      strSQL := '';
      strSQL := strSQL + '  INSERT INTO ' + fNomeTabela + '_BKP SELECT * FROM ' + fNomeTabela;

      qryGen.Close;
      qryGen.SQL.Clear;
      qryGen.SQL.Add(strSQL);
      qryGen.ExecSQL;
    Except
      On E: Exception Do
      Begin
        WriteLog(Format('%s - Backup não foi criado pois apresentou erro, a exportação será finalizada agora...', [FIdePro]), True, 60);
        pMensagensErro(E.Message, '[Execute]');
      End;
    End;
  Finally
    If Assigned(qryGen) Then
      FreeAndNil(qryGen);
  End;
end;

procedure TThreadExportacaoTerceiros.pCriaNovaQuery(qryGen: TUniQuery;
  strSQL: String);
begin
  qryGen.Close;
  qryGen.SQL.Clear;
  qryGen.SQL.Add(strSQL);
  qryGen.Open;
end;

procedure TThreadExportacaoTerceiros.pCriaTabelaExportacao();
var
  qryGen: TUniQuery;
begin
  If fTabelaExisteNovo(fNomeTabela, strDataBase) Then
  Begin
    If fTabelaExisteNovo(fNomeTabela + '_BKP', strDataBase) Then
      fDropTable(fNomeTabela)
    Else
      Exit;
  End;
  
  Try
    qryGen := fCriaQuery(Nil, Banco);
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fCamposTabela);
      ExecSQL;
      Close;
      SQL.Clear;

      If fRetCODEMP.IsEmpty Then
        SQL.Add('ALTER TABLE ' + fNomeTabela + ' ADD UNIQUE KEY (' + fRetMD5KEY + ')')
      Else
        SQL.Add('ALTER TABLE ' + fNomeTabela + ' ADD UNIQUE KEY (' + fRetMD5KEY + ', ' + fRetCODEMP + ')');
      ExecSQL;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

{$IFDEF LINUX}
procedure TThreadExportacaoTerceiros.pEscreverAguardeCalculando;
begin
  WriteLog(Format('%s - Aguarde, calculando preços ...', [FIdePro]), True, 60);
end;

procedure TThreadExportacaoTerceiros.pEscreverAguardeInserindo;
begin
  WriteLog(Format('%s - Aguarde, Inserindo registros ...', [FIdePro]), True, 60);
end;

procedure TThreadExportacaoTerceiros.pEscreverLogBackup;
begin
  WriteLog(Format('%s - Aguarde, Criando backup ...', [FIdePro]), True, 60);
end;

procedure TThreadExportacaoTerceiros.pEscreverLogProgresso(qryGen: TUniQuery);
var
  LSeconds: Integer;
begin
  LSeconds := SecondsBetween(Now, FInicioExportacao);
  LSeconds := Floor((LSeconds / qryGen.RecNo) * (qryGen.RecordCount - qryGen.RecNo));
  WriteLog(Format('%s - Registros inseridos..: %d (%f%%)', [FIdePro, Pred(qryGen.RecNo), qryGen.RecNo / qryGen.RecordCount * 100]), True, 60);
  WriteLog(Format('%s - Tempo restante.......: %d min.', [FIdePro, Max(Round(LSeconds / 60), 1)]), True, 60);
  WriteLog(Format('%s - Memoria utilizada....: %s', [FIdePro, GetMemoryUsage]), True, 60);
end;

procedure TThreadExportacaoTerceiros.pFinalizarObjetosValidacao;
begin
  fatVenda.pFreeCdsVenda;
  If Assigned(Self.fatVenda) Then
    FreeAndNil(Self.fatVenda);
  if Assigned(objPrecoTinta) then
    FreeAndNil(objPrecoTinta);
end;

{$ENDIF}

{$IFDEF LINUX}
procedure TThreadExportacaoTerceiros.pGerarArrayValidacao(ACount: Integer);
var
  LSize: Integer;
  LIndex: Integer;
begin
  FMREW.BeginWrite;
  try
    if FErrors.ContainsKey(FIdePro) then
      FErrors[FIdePro].Clear
    else
      FErrors.AddOrSetValue(FIdePro, TStringList.Create);
    LSize := Floor(ACount * 0.002);
    FValidateIndexList.Clear;
    for LIndex := 0 to Pred(LSize) do
      FValidateIndexList.Add(Random(Pred(ACount)));
  finally
    FMREW.EndWrite;
  end;
end;

procedure TThreadExportacaoTerceiros.pIniciarObjetosValidacao;
begin
  Self.fatVenda := TFatVendaBase.CreateInstance('PD', False);
  Self.fatVenda.strNomeForm := 'frmFatVendas';
  Self.fatVenda.strEspDoc := 'PD';
  Self.fatVenda.qryConIte := fCriarQueryIteGer(Self.fatVenda);
  Self.fatVenda.pCriarCdsVenda(nil);
end;

{$ENDIF}

procedure TThreadExportacaoTerceiros.pLimparTabelaExportacao;
begin
  pApagaTabelaExportacao;
{$IFNDEF LINUX}
  pCriaTabelaExportacao;
{$ENDIF}
end;

{$IFDEF LINUX}
procedure TThreadExportacaoTerceiros.pLogCriouBackup(blnCriou: Boolean);
begin
  If blnCriou Then
    WriteLog(Format('%s - Backup Criado, Processando Exportação...', [FIdePro]), True, 60)
  Else If blnExportacaoNova Then
    WriteLog(Format('%s - Backup não foi criado pois não existe tabela principal da exportação. Processando Exportação...', [FIdePro]), True, 60)
  Else
    WriteLog(Format('%s - Backup não foi criado. Processo da exportação cancelado...', [FIdePro]), True, 60);
end;
{$ENDIF}

procedure TThreadExportacaoTerceiros.pPrecosTintaValidacao(FInfo: TValidateInf);
begin
  pCompararPrecosValidacao(FInfo.fltPreCus, objPrecoTinta.FPreCus, 'Preço de custo', FInfo);
  pCompararPrecosValidacao(FInfo.fltPreVen, objPrecoTinta.FPreVen, 'Preço de Venda', FInfo);
  pCompararPrecosValidacao(FInfo.fltPreVe1, objPrecoTinta.FPreVe1, 'Preço de Tabela 1', FInfo);
  pCompararPrecosValidacao(FInfo.fltPreVe2, objPrecoTinta.FPreVe2, 'Preço de Tabela 2', FInfo);
  pCompararPrecosValidacao(FInfo.fltPreVe3, objPrecoTinta.FPreVe3, 'Preço de Tabela 3', FInfo);
  pCompararPrecosValidacao(FInfo.fltPreVe4, objPrecoTinta.FPreVe4, 'Preço de Tabela 4', FInfo);
  pCompararPrecosValidacao(FInfo.fltPreVe5, objPrecoTinta.FPreVe5, 'Preço de Tabela 5', FInfo);
  pCompararPrecosValidacao(FInfo.fltPreVe6, objPrecoTinta.FPreVe6, 'Preço de Tabela 6', FInfo);
  pCompararPrecosValidacao(FInfo.fltPreVe7, objPrecoTinta.FPreVe7, 'Preço de Tabela 7', FInfo);
end;

procedure TThreadExportacaoTerceiros.pProcessaTabelaCores(qryInsert: TFDQuery;
  qryGen, qryBases, qryColorantes: TUniQuery; strTabUni, strTabPre: String;
  fltPerAcr: Double; dicRetorno: TDicionario);
Var
  intRepetir: Integer;
  intContador: Integer;
begin
  qryGen.First;
  For intRepetir := 1 To RepetirPorTipo Do
  Begin
    FProgresso.Position := 0;
    While Not qryGen.Eof Do
    Begin

      dicRetorno.Limpar;

      pPreencheDicRetorno(dicRetorno, qryGen, strTabUni, strTabPre);

      {************************************************************}
      {** CONTADOR ADICIONADO PARA GRAVAR DUAS FORMULAS COM      **}
      {** DILUENTES DIFERENTES E CALCULAR CORRETAMENTE OS PREÇOS **}
      {*********************************************************RG*}
      intDiluente := 0;

      For intContador := 0 To fGetTipoFormula(qryGen, qryBases) Do
      Begin

        {************************************************************}
        {** VALIDAÇÃO FEITA PARA VERIFICAR SE EXISTE BASE AMARRADA **}
        {**         SE FOR 3 EXISTE BASE NÃO AMARRADA              **}
        {********************************************************RG**}
        If fGetTipoFormula(qryGen, qryBases) = 3 Then
          Break;

        pRetornaQuantidadeFormulacao(dicRetorno, qryGen, qryBases);

        pRetornaPrecoTinta(dicRetorno, qryColorantes, qryBases, fltPerAcr);

        pGravaTintometricoTabelasTerceiros(qryInsert,
          IfNull(dicRetorno['preve'+dicRetorno['tabelaunica']], 0.0), qryGen);

        Inc(intDiluente);
      End;

      If ((qryGen.RecNo mod 100 = 0) Or (qryGen.RecNo = intMax)) And (Not FAutoma) Then
          Synchronize(pStep);

      qryGen.Next;
    End;
    qryGen.First;
    Inc(IntTipo);
  End;
end;

procedure TThreadExportacaoTerceiros.pSetaParametrosEspecificos(
  Conexao: TUniConnection);
begin
  //
end;

procedure TThreadExportacaoTerceiros.pSetarEmpresaExportacao;
begin

end;

procedure TThreadExportacaoTerceiros.pSetIdePro(const Value: String);
begin
  FIdePro := Value;
end;

procedure TThreadExportacaoTerceiros.pSetPosicao(intMax: Integer);
begin
  If Assigned(FProgresso) Then
  Begin
    FProgresso.Position := 0;
    FProgresso.Properties.Min := 0;
    FProgresso.Properties.Max := intMax;
  End;
end;

procedure TThreadExportacaoTerceiros.pStep;
begin
  pStep(100, intMax);
end;

procedure TThreadExportacaoTerceiros.pTabelaExportacaoAnterior;
Var
  qryGen: TUniQuery;
begin
  Try
    pCriaTabelaExportacao();

    If Not fTabelaExisteNovo(fNomeTabela + '_BKP', strDataBase) Then
      Exit;

    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('  INSERT INTO ' + fNomeTabela + ' SELECT * FROM ' + fNomeTabela + '_BKP ');
    qryGen.ExecSQL;
  Finally
    If Assigned(qryGen) Then
      FreeAndNil(qryGen);
  End;
end;

procedure TThreadExportacaoTerceiros.pUpdateLogTinSite(Conexao: TUniConnection;
  strStatus: String);
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Nil, Conexao);

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' UPDATE LOGTIN_SIT SET LOG_HORFIN = :HORFIN, LOG_EXECUT = :EXECUT ');
    qryGen.SQL.Add('  WHERE LOG_IDEPRO = "' + FIdePro + '"        ');
    qryGen.ParamByName('HORFIN').AsDateTime := Time;
    qryGen.ParamByName('EXECUT').AsString := strStatus;
    qryGen.ExecSQL;
  Finally
    FreeAndNil(qryGen);
  End;
end;

Procedure TThreadExportacaoTerceiros.pValidacaoFormula(FInfo: TValidateInf; EEmpresa: String = '');
begin
  Try
    Try
      pIniciarObjetosValidacao;
      pCarregarClienteValidacao;
      pCarregarVendedorValidacao;
      pCarregarCondicaoPagtoValidacao;
      objPrecoTinta := TConsultarPrecoTinta.Create(fatVenda, FInfo.strIdePro, FInfo.strMD5Key, FInfo.strTabPre, FInfo.strEmbPro, FInfo.strModVen, FInfo.strCodDil);
      Try
        TConsultarPrecoTintaHack(objPrecoTinta).pRetornarPrecosTinta(EEmpresa);
        pPrecosTintaValidacao(FInfo);
      Finally
        FreeAndNil(objPrecoTinta);
      End;
    Except
      On E: Exception do
        pAddError(FInfo.strIdePro, E.Message);
    End;
  Finally
    pFinalizarObjetosValidacao;
  End;
end;

function TThreadExportacaoTerceiros.RepetirPorTipo: Integer;
begin
  Result := 1;
end;

procedure TThreadExportacaoTerceiros.pStep(intStep, intMax: Integer);
begin
  If Assigned(FProgresso) Then
  Begin
    FProgresso.Position := FProgresso.Position + intStep;

    FProgresso.Properties.Text := FloatToStr(FProgresso.Position) + '/' + intToStr(intMax);

    Application.ProcessMessages;
  End;
end;

{ TConsultarPrecoPromocaoCache }

class function TConsultarPrecoPromocaoCache.fRetornaPrecosPromocao( strCodIte,
                                                                    strCodCli: String;
                                                                    dtaDtaPro: TDateTime;
                                                                    fltQtdDig,
                                                                    fltQtdJaDig,
                                                                    fltQtdJaEmPromoc: Double;
                                                                    intPraMed: Integer;
                                                                    Var fltPreCus,
                                                                    fltPreVen,
                                                                    fltComVar,
                                                                    fltComAta,
                                                                    fltComDis,
                                                                    fltQtdDis,
                                                                    fltDesF07: Double;
                                                                    Var strComPro: String;
                                                                    var strCodPro: String;
                                                                    Var blnParticiona,
                                                                    blnPromo: Boolean;
                                                                    strTabPre: String;
                                                                    strCodCnd: String;
                                                                    strPrzPro: String = '';
                                                                    strENTBRF: String = '';
                                                                    blnConsideraQtd: Boolean=True;
                                                                    blnBuscaPreco: Boolean=False;
                                                                    strIteVid: String = '-1';
                                                                    blnEntIme: Boolean=False;
                                                                    blnEntFut: Boolean=False;
                                                                    strMotFut: String = '';
                                                                    strEmpPro: String = '';
                                                                    strNumOrc: String = '';
                                                                    strEspOrc: String = '';
                                                                    Conexao: TUniConnection = Nil;
                                                                    blnEhConsulta: Boolean = False ): Boolean;
Var
  LKey: String;
  LRetorno: TConsultarPrecoPromocaoCache.TRetorno;
begin
  LKey := strCodIte                     + '|' +
          strCodCli                     + '|' +
          DateTimeToStr(dtaDtaPro)      + '|' +
          FloatToStr(fltQtdDig)         + '|' +
          FloatToStr(fltQtdJaDig)       + '|' +
          FloatToStr(fltQtdJaEmPromoc)  + '|' +
          FloatToStr(intPraMed)         + '|' +
          strTabPre                     + '|' +
          strCodCnd                     + '|' +
          strPrzPro                     + '|' +
          strENTBRF                     + '|' +
          BoolToStr(blnConsideraQtd)    + '|' +
          BoolToStr(blnBuscaPreco)      + '|' +
          strIteVid                     + '|' +
          BoolToStr(blnEntIme)          + '|' +
          BoolToStr(blnEntFut)          + '|' +
          strEmpPro                     + '|' +
          strNumOrc                     + '|' +
          strEspOrc                     + '|' +
          BoolToStr(blnEhConsulta);

  If Assigned(Conexao) Then
    LKey := LKey                        + '|' +
            Conexao.Server              + '|' +
            Conexao.DataBase            + '|' +
            Conexao.Port.ToString;

  If Self.FDicPrecosPromocao.TryGetValue(LKey, LRetorno) Then
  Begin
    fltPreCus     := LRetorno.fltPreCus;
    fltPreVen     := LRetorno.fltPreVen;
    fltComVar     := LRetorno.fltComVar;
    fltComAta     := LRetorno.fltComAta;
    fltComDis     := LRetorno.fltComDis;
    fltQtdDis     := LRetorno.fltQtdDis;
    fltDesF07     := LRetorno.fltDesF07;
    strComPro     := LRetorno.strComPro;
    strCodPro     := LRetorno.strCodPro;
    blnParticiona := LRetorno.blnParticiona;
    blnPromo      := LRetorno.blnPromo;
    Result        := LRetorno.blnResult;
    Exit;
  End;

  Result := untCadPro.fRetornaPrecosPromocao( strCodIte,
                                              strCodCli,
                                              dtaDtaPro,
                                              fltQtdDig,
                                              fltQtdJaDig,
                                              fltQtdJaEmPromoc,
                                              intPraMed,
                                              fltPreCus,
                                              fltPreVen,
                                              fltComVar,
                                              fltComAta,
                                              fltComDis,
                                              fltQtdDis,
                                              fltDesF07,
                                              strComPro,
                                              strCodPro,
                                              blnParticiona,
                                              blnPromo,
                                              strTabPre,
                                              strCodCnd,
                                              strPrzPro,
                                              strENTBRF,
                                              blnConsideraQtd,
                                              blnBuscaPreco,
                                              strIteVid,
                                              blnEntIme,
                                              blnEntFut,
                                              strMotFut,
                                              strEmpPro,
                                              strNumOrc,
                                              strEspOrc,
                                              Conexao,
                                              blnEhConsulta );

  LRetorno.fltPreCus     := fltPreCus;
  LRetorno.fltPreVen     := fltPreVen;
  LRetorno.fltComVar     := fltComVar;
  LRetorno.fltComAta     := fltComAta;
  LRetorno.fltComDis     := fltComDis;
  LRetorno.fltQtdDis     := fltQtdDis;
  LRetorno.fltDesF07     := fltDesF07;
  LRetorno.strComPro     := strComPro;
  LRetorno.strCodPro     := strCodPro;
  LRetorno.blnParticiona := blnParticiona;
  LRetorno.blnPromo      := blnPromo;
  LRetorno.blnResult     := Result;

  Self.FDicPrecosPromocao.Add(LKey, LRetorno);
end;

initialization
{$IFDEF LINUX}
  TThreadExportacaoTerceiros.FMREW := TMultiReadExclusiveWriteSynchronizer.Create;
  TThreadExportacaoTerceiros.FErrors := TDictionary<String,TStringList>.Create;
{$ENDIF}
  TConsultarPrecoPromocaoCache.FDicPrecosPromocao := TDictionary<String, TConsultarPrecoPromocaoCache.TRetorno>.Create;

finalization
{$IFDEF LINUX}
  TThreadExportacaoTerceiros.FMREW.Free;
  TThreadExportacaoTerceiros.FErrors.Free;
{$ENDIF}
  TConsultarPrecoPromocaoCache.FDicPrecosPromocao.Free;

end.
