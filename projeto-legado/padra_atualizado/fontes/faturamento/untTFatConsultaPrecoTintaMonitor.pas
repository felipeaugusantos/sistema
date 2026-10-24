unit untTFatConsultaPrecoTintaMonitor;

interface

uses
  System.DateUtils, System.Classes, System.SysUtils, System.Generics.Collections, System.StrUtils,
  System.Math, Winapi.Windows, Data.DB, Uni, untUtilMonitor, Faturamento.Classes.TFatVendaBase,
  untFuncFatTypes, System.Variants, untFuncoesSimples;

const
  MonitorConsultaPrecoTintaId = 'MONITOR_CONSULTAR_PRECO_TINTA_%s';
  MonitorConsultaPrecoTintaInactivityId = 'TEST_INACTIVITY_CONSULTAR_PRECO_TINTA_%s';
  MonitorConsultaPrecoTintaParam = 'CONSULTAR_PRECO_TINTA';
  MonitorConsultaPrecoTintaTimeLimit = 30;
  MonitorConsultaPrecoTintaAttemptsLock = 30;

type
  TConsultaPrecoTintaMonitor = class sealed(TInterfacedObject, IMonitorProcedure)
  private const
    FQtdIte: Integer = 1;
  private
    FReq_Id: String;
    FCodCli: String;
    FIdePro: String;
    FMD5Key: String;
    FEMBPro: String;
    FMODVen: String;

    FIteTin: String;
    FCodIte: String;
    FDesIte: String;
    FRefere: String;
    FUnidad: String;

    FForTin: TForTin;

    FDesCor: String;
    FMontad: String;
    FLazQua: Integer;
    FTipPre: String;
    FCodEmb: String;
    FTipEmb: String;
    FQtdEmb: Integer;
    FPreEmb: Double;
    FEmbala: Double;
    FObsCol: String;
    FTipFor: Integer;
    FLinTin: String;
    FA_n_o_: String;
    FCatali: String;
    FPorper: String;
    FFatAce: Double;
    FFatTin: Double;

    FCodDil: String;
    FPorDil: Double;
    FDilCon: String;
    FPorCat: Double;
    FVolPro: Double;
    FTipCor: String;

    FTabPre: String;
    FPreVen: Double;

    FPrcTin: Double;
    FPrvTin: Double;

    FPreVe1: Double;
    FPreVe2: Double;
    FPreVe3: Double;
    FPreVe4: Double;
    FPreVe5: Double;
    FPreVe6: Double;
    FPreVe7: Double;

    FPreCus: Double;
    FPreCu2: Double;

    FOutVal: Double;
    FIcmSai: Double;
    FImpFed: Double;
    FDesOpe: Double;
    FPreMed: Double;
    FImpUlt: Double;
    FPreUlt: Double;

    FSalDis: Double;

    FDicTin: TDicionario;
    FQryTin: TUniQuery;

    FUltMsg: String;

    FCacheID: String;

    FFormul: TForMulTinDetArray;
    FPigmentos: TBaixaPigmentosArray;
  private
    class var fatVenda: TFatVendaBase;
  private
    class function fGetSQLConsultaPrecoTintaPendentes: String;
  private
    procedure pGravarResultadoCache;
  private
    procedure pAtualizarInicio;
    procedure pLocalizarCacheID;
    procedure pCarregarCliente;
    procedure pCarregarCondPagto;
    procedure pCarregarVendedor;
    procedure pRetornarPrecosTinta;
    procedure pRetornarFormulacao;
    procedure pRetornarSaldoDisponivel;
    procedure pGravarResultadoConsulta;
    procedure pAtualizarTermino;
    procedure pRegistrarErroConsultaPreco(AError: String);
  protected
    constructor Create(AReq_Id, ACodCli, AIdePro, AMD5Key, AEMBPro, AMODVen: String);
  public
    procedure pExecute;
    procedure pExecuteAll;
    function fExecute: TResultExecute;
    destructor Destroy; Override;
    class procedure ExecutarRobo();
    class procedure pIniciarObjetos;
    class procedure pFinalizarObjetos;
    class function New(): IMonitorProcedure; overload;
    class function New(AReq_Id, ACodCli, AIdePro, AMD5Key, AEMBPro, AMODVen: String): IMonitorProcedure; overload;
  end;

Var
  VS_strLockMonitorConsultaPrecoTinta: String;
  VS_dtaUltimaExecucaoMonitorConsultaPrecoTinta: TDateTime;
  VS_objProcessoMonitorConsultaPrecoTinta: TProcessInformation;

implementation

uses
  untFuncTinta, untTMatrizSaldosColorantes, untTypesSistema,
  untImportaTintometricosTerceirosTabelas, untFuncoes, untTipoTinta, untParCalculaPrecoCusto,
  untTConfiguracao, untCadPro, untFatVendasCalculadorWrapper, Promocao.Regra.Preco.Sugestao,
  untFatVendasCalculadorWrapperTAB;

{ TConsultaPrecoTintaMonitor }

constructor TConsultaPrecoTintaMonitor.Create(AReq_Id, ACodCli, AIdePro, AMD5Key, AEMBPro, AMODVen: String);
begin
  FReq_Id := AReq_Id;
  FCodCli := ACodCli;
  FIdePro := AIdePro;
  FMD5Key := AMD5Key;
  FEMBPro := AEMBPro;
  FMODVen := AMODVen;
  FDicTin := TDicionario.Create;
  FQryTin := fCriaQuery;
end;

destructor TConsultaPrecoTintaMonitor.Destroy;
begin
  FDicTin.LimparObjetos;
  FDicTin.Limpar;
  FreeAndNil(FDicTin);
  FreeAndNil(FQryTin);
  inherited;
end;

class procedure TConsultaPrecoTintaMonitor.ExecutarRobo;
begin
  TUtilMonitor.pTestInactivity(MonitorConsultaPrecoTintaInactivityId,
    MonitorConsultaPrecoTintaTimeLimit, VS_objProcessoMonitorConsultaPrecoTinta,
    VS_dtaUltimaExecucaoMonitorConsultaPrecoTinta);

  TUtilMonitor.pRunMonitor(MonitorConsultaPrecoTintaId, VS_objProcessoMonitorConsultaPrecoTinta,
    VS_dtaUltimaExecucaoMonitorConsultaPrecoTinta, ExtractFileName(ParamStr(0)), MonitorConsultaPrecoTintaParam);

  TUtilMonitor.pClearAttemptsLock(Format(MonitorConsultaPrecoTintaId, [VS_strCodEmp]),
    MonitorConsultaPrecoTintaAttemptsLock);
end;

function TConsultaPrecoTintaMonitor.fExecute: TResultExecute;
begin
  FillChar(Result, SizeOf(Result), #0);
  pExecute;
end;

class function TConsultaPrecoTintaMonitor.fGetSQLConsultaPrecoTintaPendentes: String;
begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE      ';
  Result := Result + '   *                      ';
  Result := Result + ' FROM                     ';
  Result := Result + '   TINPRE_REQ             ';
  Result := Result + ' WHERE TPR_CODEMP = "%s"  ';
  Result := Result + '   AND TPR_DTHRES IS NULL ';
  Result := Result + ' ORDER BY TPR_DTHREQ      ';
  Result := Result + ' LIMIT 50;                ';
end;

class function TConsultaPrecoTintaMonitor.New(AReq_Id, ACodCli, AIdePro, AMD5Key, AEMBPro, AMODVen: String)
  : IMonitorProcedure;
begin
  Result := Self.Create(AReq_Id, ACodCli, AIdePro, AMD5Key, AEMBPro, AMODVen);
end;

class function TConsultaPrecoTintaMonitor.New: IMonitorProcedure;
begin
  Result := Self.Create('', '', '', '', '', '');
end;

procedure TConsultaPrecoTintaMonitor.pAtualizarTermino;
Var
  LQuery: TUniQuery;
begin
  LQuery := fCriaQuery;
  Try
    LQuery.Close;
    LQuery.SQL.Text := 'SELECT * FROM TINPRE_REQ WHERE TPR_REQ_ID = ' + FReq_Id;
    LQuery.Open;
    If LQuery.IsEmpty Then
      Raise Exception.Create
        ('Não foi encontrado registro na tabela TINPRE_REQ com o id informado.');
    LQuery.Edit;
    LQuery.FieldByName('TPR_DTHRES').Value := Vs_date + fTime();
    LQuery.FieldByName('TPR_CACHE_').Value := IIF(FCacheID.IsEmpty, 'N', 'S');
    LQuery.Post;
  Finally
    FreeAndNil(LQuery);
  End;
end;

procedure TConsultaPrecoTintaMonitor.pAtualizarInicio;
Var
  LQuery: TUniQuery;
begin
  LQuery := fCriaQuery;
  Try
    LQuery.Close;
    LQuery.SQL.Text := 'SELECT * FROM TINPRE_REQ WHERE TPR_REQ_ID = ' + FReq_Id;
    LQuery.Open;
    If LQuery.IsEmpty Then
      Raise Exception.Create
        ('Não foi encontrado registro na tabela TINPRE_REQ com o id informado.');
    LQuery.Edit;
    LQuery.FieldByName('TPR_DTHINI').Value := Vs_date + fTime();
    LQuery.Post;
  Finally
    FreeAndNil(LQuery);
  End;
end;

procedure TConsultaPrecoTintaMonitor.pCarregarCliente;
begin
  If Not FCacheID.IsEmpty Then
    Exit;

  If fatVenda.strCodCli.Equals(FCodCli) Then
    Exit;

  fatVenda.pCarregaDadosClienteBaixa(FCodCli);
end;

procedure TConsultaPrecoTintaMonitor.pCarregarCondPagto;
begin
  If Not FCacheID.IsEmpty Then
    Exit;

  fatVenda.pAtualizaInformacoesCondPagamento;
  fatVenda.intPrzMed := fFloatToInt(fCalcMediaPagto(fatVenda.strConPag));
  fatVenda.blnTaxVpr := False;
  fatVenda.fltTaxJur := 0.00;
end;

procedure TConsultaPrecoTintaMonitor.pCarregarVendedor;
Var
  LCodVen: String;
begin
  If Not FCacheID.IsEmpty Then
    Exit;

  LCodVen := strLoginUsuarioLogado;

  If fEmptyStr(fatVenda.strCodVen) Then
  Begin
    fatVenda.strCodVen := LCodVen;
    fatVenda.strNomVen := fRetNomVendRep(fatVenda.strCodVen);
    fatVenda.fltComVen := fCampoTabela('OPE_PERCOM', 'CADOPE', ['OPE_CODOPE'], [LCodVen], False);
    fatVenda.strTipVen := fCampoTabela('OPE_INTEXT', 'CADOPE', ['OPE_CODOPE'], [LCodVen], False);
  End;

  If fEmptyStr(fatVenda.strCodDig) Then
  Begin
    fatVenda.strCodDig := LCodVen;
    fatVenda.strNomDig := fRetNomVendRep(fatVenda.strCodDig);
  End;
end;

procedure TConsultaPrecoTintaMonitor.pExecute;
begin
  Try
    Try
      pAtualizarInicio;
      pLocalizarCacheID;
      pCarregarCliente;
      pCarregarCondPagto;
      pCarregarVendedor;
      pRetornarPrecosTinta;
      pRetornarFormulacao;
      pRetornarSaldoDisponivel;
      pGravarResultadoConsulta;
      pAtualizarTermino;
    Except
      On E: Exception Do
        pRegistrarErroConsultaPreco(E.Message);
    End;
  Finally
//    pSetLogBinON;
  End;
end;

procedure TConsultaPrecoTintaMonitor.pExecuteAll;
var
  LQuery: TUniQuery;
  LReq_Id: String;
  LCodCli: String;
  LIdePro: String;
  LMD5Key: String;
  LEMBPro: String;
  LMODVen: String;
begin
  LQuery := fCriaQuery();
  Try
    LQuery.SQL.Add(Format(fGetSQLConsultaPrecoTintaPendentes, [VS_strCodEmp]));
    LQuery.Open();

    While (Not LQuery.Eof) Do
    Begin
      LReq_Id := LQuery.FieldByName('TPR_REQ_ID').AsString;
      LCodCli := LQuery.FieldByName('TPR_CODCLI').AsString;
      LIdePro := LQuery.FieldByName('TPR_IDEPRO').AsString;
      LMD5Key := LQuery.FieldByName('TPR_MD5TIN').AsString;
      LEMBPro := LQuery.FieldByName('TPR_EMBPRO').AsString;
      LMODVen := LQuery.FieldByName('TPR_MODVEN').AsString;

      TConsultaPrecoTintaMonitor.New(LReq_Id, LCodCli, LIdePro, LMD5Key, LEMBPro, LMODVen).pExecute();

      If (LQuery.RecNo Mod 10 = 0) Then
      Begin
        pZerarTentativasLock(Format(MonitorConsultaPrecoTintaId, [VS_strCodEmp]));
        pTrimAppMemorySize();
        Sleep(1000);
      End;

      LQuery.Next;
    End;
  Finally
    FreeAndNil(LQuery);
  End;
end;

class procedure TConsultaPrecoTintaMonitor.pFinalizarObjetos;
begin
  fatVenda.pFreeCdsVenda;
  If Assigned(Self.fatVenda) Then
    FreeAndNil(Self.fatVenda);
end;

function fColorante(strCodCol, strIdePro, strCodEmp: String): String;
Var
  strCodBasRet: String;
begin
  Result := '';
  If Not fEmptyStr(strCodCol) Then
  Begin
    pRetItemColorante(strIdePro, strCodCol, Result, strCodBasRet, strCodEmp);
    Result := Trim(Result);
  End;
end;

procedure TConsultaPrecoTintaMonitor.pGravarResultadoCache;
Var
  LQuery: TUniQuery;
  LCache: TUniQuery;
  LIndex: Integer;
begin
  If FCacheID.IsEmpty Then
    Exit;

  LQuery := fCriaQuery;
  LCache := fCriaQuery;
  Try
    LCache.Close;
    LCache.SQL.Text := 'SELECT * FROM TINPRE_RES WHERE TPR_RES_ID = ' + FCacheID;
    LCache.Open;

    LQuery.Close;
    LQuery.SQL.Text := 'SELECT * FROM TINPRE_RES WHERE FALSE';
    LQuery.Open;
    LQuery.Append;

    For LIndex := 0 To LQuery.Fields.Count - 1 Do
    Begin
      If LQuery.Fields[LIndex].FieldName.Equals('TPR_RES_ID') Then
        Continue;

      If LQuery.Fields[LIndex].FieldName.Equals('TPR_REQ_ID') Then
      Begin
        LQuery.Fields[LIndex].Value := FReq_Id.ToInt64;
        Continue;
      End;

      If LQuery.Fields[LIndex].FieldName.Equals('TPR_SALDIS') Then
      Begin
        LQuery.Fields[LIndex].Value := FSalDis;
        Continue;
      End;

      LQuery.Fields[LIndex].Value := LCache.Fields[LIndex].Value;
    End;

    LQuery.Post;
  Finally
    FreeAndNil(LQuery);
    FreeAndNil(LCache);
  End;
end;

procedure TConsultaPrecoTintaMonitor.pGravarResultadoConsulta;
Var
  LQuery: TUniQuery;
  LCodEmp: String;
begin
  If Not FCacheID.IsEmpty Then
  Begin
    pGravarResultadoCache;
    Exit;
  End;

  LCodEmp := VS_strCodEmp;

  LQuery := fCriaQuery;
  Try
    LQuery.Close;
    LQuery.SQL.Text := 'SELECT * FROM TINPRE_RES WHERE FALSE';
    LQuery.Open;
    LQuery.Append;
    LQuery.FieldByName('TPR_REQ_ID').Value := FReq_Id.ToInt64;
    LQuery.FieldByName('TPR_CODEMP').Value := VS_strCodEmp;
    LQuery.FieldByName('TPR_IDEPRO').Value := FIdePro;
    LQuery.FieldByName('TPR_MD5TIN').Value := FMD5Key;
    LQuery.FieldByName('TPR_EMBPRO').Value := FEMBPro;
    LQuery.FieldByName('TPR_MODVEN').Value := FMODVen;
    LQuery.FieldByName('TPR_CODCLI').Value := FCodCli;
    LQuery.FieldByName('TPR_CODITE').Value := FCodIte;
    LQuery.FieldByName('TPR_IDEPRO').Value := FIdePro;
    LQuery.FieldByName('TPR_DESCRI').Value := FDesIte.Replace('"', '').Replace('''', '');
    LQuery.FieldByName('TPR_REFERE').Value := FRefere.Replace('"', '').Replace('''', '');
    LQuery.FieldByName('TPR_UNIDAD').Value := FUnidad;
    LQuery.FieldByName('TPR_TABPRE').Value := FTabPre;
    LQuery.FieldByName('TPR_PREVEN').Value := FPreVen;
    LQuery.FieldByName('TPR_PREVE1').Value := FPreVe1;
    LQuery.FieldByName('TPR_PREVE2').Value := FPreVe2;
    LQuery.FieldByName('TPR_PREVE3').Value := FPreVe3;
    LQuery.FieldByName('TPR_PREVE4').Value := FPreVe4;
    LQuery.FieldByName('TPR_PREVE5').Value := FPreVe5;
    LQuery.FieldByName('TPR_PREVE6').Value := FPreVe6;
    LQuery.FieldByName('TPR_PREVE7').Value := FPreVe7;
    LQuery.FieldByName('TPR_OUTVAL').Value := FOutVal;
    LQuery.FieldByName('TPR_ICMSAI').Value := FIcmSai;
    LQuery.FieldByName('TPR_IMPFED').Value := FImpFed;
    LQuery.FieldByName('TPR_DESOPE').Value := FDesOpe;
    LQuery.FieldByName('TPR_PREMED').Value := FPreMed; { TODO : conferir precos }
    LQuery.FieldByName('TPR_IMPULT').Value := FImpUlt;
    LQuery.FieldByName('TPR_PREULT').Value := FPreUlt;
    LQuery.FieldByName('TPR_PRECUS').Value := FPreCus;
    LQuery.FieldByName('TPR_PRECU2').Value := FPreCu2;
    LQuery.FieldByName('TPR_SALDIS').Value := FSalDis;
    //Dados para gravacao FATDOR
    LQuery.FieldByName('TPR_PRCTIN').Value := FPrcTin;
    LQuery.FieldByName('TPR_PRVTIN').Value := FPrvTin;
    LQuery.FieldByName('TPR_ITETIN').Value := FIteTin;
    LQuery.FieldByName('TPR_DESCOR').Value := FDesCor.Replace('"', '').Replace('''', '');
    LQuery.FieldByName('TPR_TIPEMB').Value := FTipEmb;
    LQuery.FieldByName('TPR_QTDEMB').Value := FQtdEmb;
    LQuery.FieldByName('TPR_PREEMB').Value := FPreEmb;
    LQuery.FieldByName('TPR_ITEEMB').Value := FCodEmb;
    //Dados para gravacao TINDOR
    LQuery.FieldByName('TPR_MONTAD').Value := FMontad;
    LQuery.FieldByName('TPR_A_N_O_').Value := FA_n_o_;
    LQuery.FieldByName('TPR_TIPPRE').Value := FTipPre;
    LQuery.FieldByName('TPR_FATTIN').Value := FFatTin;
    LQuery.FieldByName('TPR_LAZQUA').Value := FLazQua;
    LQuery.FieldByName('TPR_VOLPRO').Value := FVolPro;
    LQuery.FieldByName('TPR_LINLIN').Value := FLinTin;
    LQuery.FieldByName('TPR_CATALI').Value := FCatali.Replace('"', '').Replace('''', '');
    LQuery.FieldByName('TPR_CODDIL').Value := FCodDil;
    LQuery.FieldByName('TPR_PORDIL').Value := FPorDil;
    LQuery.FieldByName('TPR_DILCON').Value := FDilCon;
    LQuery.FieldByName('TPR_PORCAT').Value := FPorCat;
    LQuery.FieldByName('TPR_OBSCOL').Value := FObsCol.Replace('"', '').Replace('''', '');
    LQuery.FieldByName('TPR_TIPFOR').Value := FTipFor;
    LQuery.FieldByName('TPR_TINAUT').Value := fTipoTinta(FIdePro) = ttAutomotiva;
    LQuery.FieldByName('TPR_FORM01').Value := FFormul[01].strFormul;
    LQuery.FieldByName('TPR_FORM02').Value := FFormul[02].strFormul;
    LQuery.FieldByName('TPR_FORM03').Value := FFormul[03].strFormul;
    LQuery.FieldByName('TPR_FORM04').Value := FFormul[04].strFormul;
    LQuery.FieldByName('TPR_FORM05').Value := FFormul[05].strFormul;
    LQuery.FieldByName('TPR_FORM06').Value := FFormul[06].strFormul;
    LQuery.FieldByName('TPR_FORM07').Value := FFormul[07].strFormul;
    LQuery.FieldByName('TPR_FORM08').Value := FFormul[08].strFormul;
    LQuery.FieldByName('TPR_FORM09').Value := FFormul[09].strFormul;
    LQuery.FieldByName('TPR_FORM10').Value := FFormul[10].strFormul;
    LQuery.FieldByName('TPR_FORM11').Value := FFormul[11].strFormul;
    LQuery.FieldByName('TPR_FORM12').Value := FFormul[12].strFormul;
    LQuery.FieldByName('TPR_FORM13').Value := FFormul[13].strFormul;
    LQuery.FieldByName('TPR_FORM14').Value := FFormul[14].strFormul;
    LQuery.FieldByName('TPR_FORM15').Value := FFormul[15].strFormul;
    LQuery.FieldByName('TPR_FORM16').Value := FFormul[16].strFormul;
    LQuery.FieldByName('TPR_FORM17').Value := FFormul[17].strFormul;
    LQuery.FieldByName('TPR_FORM18').Value := FFormul[18].strFormul;
    LQuery.FieldByName('TPR_FORM19').Value := FFormul[19].strFormul;
    LQuery.FieldByName('TPR_FORM20').Value := FFormul[20].strFormul;
    LQuery.FieldByName('TPR_ITEC01').Value := fColorante(FFormul[01].strFormul, FIdePro, LCodEmp);
    LQuery.FieldByName('TPR_ITEC02').Value := fColorante(FFormul[02].strFormul, FIdePro, LCodEmp);
    LQuery.FieldByName('TPR_ITEC03').Value := fColorante(FFormul[03].strFormul, FIdePro, LCodEmp);
    LQuery.FieldByName('TPR_ITEC04').Value := fColorante(FFormul[04].strFormul, FIdePro, LCodEmp);
    LQuery.FieldByName('TPR_ITEC05').Value := fColorante(FFormul[05].strFormul, FIdePro, LCodEmp);
    LQuery.FieldByName('TPR_ITEC06').Value := fColorante(FFormul[06].strFormul, FIdePro, LCodEmp);
    LQuery.FieldByName('TPR_ITEC07').Value := fColorante(FFormul[07].strFormul, FIdePro, LCodEmp);
    LQuery.FieldByName('TPR_ITEC08').Value := fColorante(FFormul[08].strFormul, FIdePro, LCodEmp);
    LQuery.FieldByName('TPR_ITEC09').Value := fColorante(FFormul[09].strFormul, FIdePro, LCodEmp);
    LQuery.FieldByName('TPR_ITEC10').Value := fColorante(FFormul[10].strFormul, FIdePro, LCodEmp);
    LQuery.FieldByName('TPR_ITEC11').Value := fColorante(FFormul[11].strFormul, FIdePro, LCodEmp);
    LQuery.FieldByName('TPR_ITEC12').Value := fColorante(FFormul[12].strFormul, FIdePro, LCodEmp);
    LQuery.FieldByName('TPR_ITEC13').Value := fColorante(FFormul[13].strFormul, FIdePro, LCodEmp);
    LQuery.FieldByName('TPR_ITEC14').Value := fColorante(FFormul[14].strFormul, FIdePro, LCodEmp);
    LQuery.FieldByName('TPR_ITEC15').Value := fColorante(FFormul[15].strFormul, FIdePro, LCodEmp);
    LQuery.FieldByName('TPR_ITEC16').Value := fColorante(FFormul[16].strFormul, FIdePro, LCodEmp);
    LQuery.FieldByName('TPR_ITEC17').Value := fColorante(FFormul[17].strFormul, FIdePro, LCodEmp);
    LQuery.FieldByName('TPR_ITEC18').Value := fColorante(FFormul[18].strFormul, FIdePro, LCodEmp);
    LQuery.FieldByName('TPR_ITEC19').Value := fColorante(FFormul[19].strFormul, FIdePro, LCodEmp);
    LQuery.FieldByName('TPR_ITEC20').Value := fColorante(FFormul[20].strFormul, FIdePro, LCodEmp);
    LQuery.FieldByName('TPR_QTDB01').Value := FFormul[01].fltQtdbas;
    LQuery.FieldByName('TPR_QTDB02').Value := FFormul[02].fltQtdbas;
    LQuery.FieldByName('TPR_QTDB03').Value := FFormul[03].fltQtdbas;
    LQuery.FieldByName('TPR_QTDB04').Value := FFormul[04].fltQtdbas;
    LQuery.FieldByName('TPR_QTDB05').Value := FFormul[05].fltQtdbas;
    LQuery.FieldByName('TPR_QTDB06').Value := FFormul[06].fltQtdbas;
    LQuery.FieldByName('TPR_QTDB07').Value := FFormul[07].fltQtdbas;
    LQuery.FieldByName('TPR_QTDB08').Value := FFormul[08].fltQtdbas;
    LQuery.FieldByName('TPR_QTDB09').Value := FFormul[09].fltQtdbas;
    LQuery.FieldByName('TPR_QTDB10').Value := FFormul[10].fltQtdbas;
    LQuery.FieldByName('TPR_QTDB11').Value := FFormul[11].fltQtdbas;
    LQuery.FieldByName('TPR_QTDB12').Value := FFormul[12].fltQtdbas;
    LQuery.FieldByName('TPR_QTDB13').Value := FFormul[13].fltQtdbas;
    LQuery.FieldByName('TPR_QTDB14').Value := FFormul[14].fltQtdbas;
    LQuery.FieldByName('TPR_QTDB15').Value := FFormul[15].fltQtdbas;
    LQuery.FieldByName('TPR_QTDB16').Value := FFormul[16].fltQtdbas;
    LQuery.FieldByName('TPR_QTDB17').Value := FFormul[17].fltQtdbas;
    LQuery.FieldByName('TPR_QTDB18').Value := FFormul[18].fltQtdbas;
    LQuery.FieldByName('TPR_QTDB19').Value := FFormul[19].fltQtdbas;
    LQuery.FieldByName('TPR_QTDB20').Value := FFormul[20].fltQtdbas;
    //Dados para gravacao FORTIN
    LQuery.FieldByName('TPR_MODDIL').Value := FForTin.intModDil;
    LQuery.FieldByName('TPR_TEXBAS').Value := FForTin.strTextBase;
    LQuery.FieldByName('TPR_TIPCOR').Value := FForTin.strTipCor;
    LQuery.FieldByName('TPR_ITECOB').Value := FForTin.strCompB;
    LQuery.FieldByName('TPR_UNIVER').Value := FForTin.strUniver;
    LQuery.FieldByName('TPR_FATACE').Value := FFatAce;
    LQuery.FieldByName('TPR_CATAL_').Value := FForTin.strCatali.Replace('"', '').Replace('''', '');
    LQuery.Post;
  Finally
    FreeAndNil(LQuery);
  End;
end;

class procedure TConsultaPrecoTintaMonitor.pIniciarObjetos;
begin
  If Assigned(Self.fatVenda) Then
    Exit;

  Self.fatVenda := TFatVendaBase.CreateInstance('PD', False);
  Self.fatVenda.strNomeForm := 'frmFatVendas';
  Self.fatVenda.strEspDoc := 'PD';
  Self.fatVenda.qryConIte := fCriarQueryIteGer(Self.fatVenda);

  If cdsVenda = nil Then
    Self.fatVenda.pCriarCdsVenda(nil);

  fExecutaSQL('REPLACE INTO TABNRE (NOMTAB) VALUES ("TINPRE_REQ")');
  fExecutaSQL('REPLACE INTO TABNRE (NOMTAB) VALUES ("TINPRE_RES")');

  pCarregaTABNRE(True);
end;

procedure TConsultaPrecoTintaMonitor.pLocalizarCacheID;
Var
  LQuery: TUniQuery;
begin
  LQuery := fCriaQuery;
  Try
    LQuery.SQL.Add('SELECT SQL_NO_CACHE ');
    LQuery.SQL.Add('  TPR_RES_ID ');
    LQuery.SQL.Add('FROM ');
    LQuery.SQL.Add('  TINPRE_REQ A ');
    LQuery.SQL.Add('  JOIN TINPRE_RES B ');
    LQuery.SQL.Add('    ON A.TPR_REQ_ID = B.TPR_REQ_ID ');
    LQuery.SQL.Add('WHERE TRUE ');
    LQuery.SQL.Add('  AND A.TPR_IDEPRO = "' + FIdePro + '" ');
    LQuery.SQL.Add('  AND A.TPR_MD5TIN = "' + FMD5Key + '" ');

    If (fTipoTinta(FIdePro) = ttAutomotiva) Then
    Begin
      LQuery.SQL.Add(' AND A.TPR_EMBPRO = "' + FEMBPro + '" ');
      LQuery.SQL.Add(' AND A.TPR_MODVEN = "' + FMODVen + '" ');
    End;

    LQuery.SQL.Add('  AND A.TPR_CODEMP = "' + VS_strCodEmp + '"   ');
    LQuery.SQL.Add('  AND A.TPR_CACHE_ = "N" ');
    LQuery.SQL.Add('  AND A.TPR_MSGERR IS NULL ');
    LQuery.SQL.Add('  AND TPR_DTHRES > DATE_SUB(' + fCurrentDateTime + ', INTERVAL 10 MINUTE) ');
    LQuery.Open;
    FCacheID := LQuery.FieldByName('TPR_RES_ID').AsString;
  Finally
    FreeAndNil(LQuery);
  End;
end;

procedure TConsultaPrecoTintaMonitor.pRegistrarErroConsultaPreco(AError: String);
Var
  LQuery: TUniQuery;
begin
  LQuery := fCriaQuery;
  Try
    LQuery.Close;
    LQuery.SQL.Text := 'SELECT * FROM TINPRE_REQ WHERE TPR_REQ_ID = ' + FReq_Id;
    LQuery.Open;
    If LQuery.IsEmpty Then
      Raise Exception.Create
        ('Não foi encontrado registro na tabela TINPRE_REQ com o id informado.');
    LQuery.Edit;
    LQuery.FieldByName('TPR_DTHRES').Value := Vs_date + fTime();
    LQuery.FieldByName('TPR_MSGERR').Value := AError;
    LQuery.Post;
  Finally
    FreeAndNil(LQuery);
  End;
end;

procedure TConsultaPrecoTintaMonitor.pRetornarPrecosTinta;
begin
  If Not FCacheID.IsEmpty Then
    Exit;

  If (VS_strUsaTmq = 'N') Then
    Raise Exception.Create('Empresa não configurada para utilizar tinta de máquina.');

  If Not IsTintaExistente(FIdePro, False) Then
    Raise Exception.Create('Não foi encontrado nenhum módulo de tinta com IDEPRO = "'+FIdePro+'".');

  If Not fatVenda.fPodeUtilizarTinta(FIdePro) Then
    Raise Exception.Create('Não é permitido vender uma tinta ' + fRetornaNomeTinta(FIdePro) +
      ' sem utilizar produção fora da loja.');

  fatVenda.strIdePro := FIdePro;

  FTabPre := fatVenda.fDefineTabelaPrecoItem(FIdePro, '');

  FDicTin['idepro'] := FIdePro;
  FDicTin['codemp'] := VS_strCodEmp;
  FDicTin['opcdoc'] := fatVenda.strOpcDoc;
  FDicTin['oprflj'] := fatVenda.strOprFlj;
  FDicTin['codempprd'] := VS_strCodEmp;
  FDicTin['empprd'] := fCfgSis('EMPPRD');
  FDicTin['emp_cd'] := fCfgSis('EMP_CD');
  FDicTin['Cd_S_N'] := IIF(fatVenda.blnEnt_CD, 'S', 'N');
  FDicTin['empfat'] := IIF(fatVenda.blnEmpFat, VS_strCodEmp, fatVenda.fEmpresaSaldoMatriz_CD);
  FDicTin['FatS_N'] := IIF(fatVenda.blnEmpFat, 'S', 'N');
  FDicTin['usaprecus'] := False;
  FDicTin['usapremed'] := False;
  FDicTin['codcli'] := fatVenda.strCodCli;
  FDicTin['przmed'] := fatVenda.intPrzMed;
  FDicTin['codcnd'] := fatVenda.strCodCnd;
  FDicTin['propre'] := (fCfgSis('PROPRE') = TRegraPrecoSugestao.PrecoDeTabela.Valor.ToString);
  FDicTin['tabpre'] := FTabPre;

  FDicTin.AdicionarObjeto('calculadorFatVendas', TFatVendasCalculadorWrapper.Create(fatVenda));
  FDicTin.AdicionarObjeto('calculadorFatVendasTAB', TFatVendasCalculadorWrapperTAB.Create(fatVenda));

  pSetaEmpresaLogadaTinta(FDicTin['codemp']);

  If Not Assigned(untFuncTinta.fRetornaPrecoTintaSemTela) Then
    Raise Exception.Create('Não foi encontrada a função "fRetornaPrecoTintaSemTela".');

  If Not untFuncTinta.fRetornaPrecoTintaSemTela(FIdePro, FMD5Key, FDicTin, FQryTin, FUltMsg, FEMBPro, FMODVen, '') Then
    If Not FUltMsg.IsEmpty Then
      Raise Exception.Create(FUltMsg)
    Else
      Raise Exception.Create('Não foi possível retornar o preço da tinta.');

  FCodIte := FDicTin['codite'];

  If fEmptyStr(FCodIte) Then
    Raise Exception.Create('Não foi possível determinar o código do produto base.');

  FDesCor := FDicTin['descor'];
  FIteTin := FDicTin['itetin'];
  FCatali := FDicTin['catali'];
  FPorper := IfNull(FDicTin['porper'], '');
  FLinTin := FDicTin['linha_'];
  FObsCol := IfNull(FDicTin['obscolorista'], '');
  FTipFor := IfNull(FDicTin['tipoformulacao'], 0);
  FTipEmb := FDicTin['tipemb'];
  FQtdEmb := FDicTin['qtdemb'];
  FTipPre := FDicTin['tippre'];
  FLazQua := FDicTin['lazqua'];
  FPreEmb := FDicTin['preemb'];
  FEmbala := FDicTin['embala'];
  FCodEmb := FDicTin['iteemb'];
  FUnidad := IfNull(FDicTin['unidad'], '');

  pRetornaDadosTinta(FIdePro, FIteTin, FDicTin);

  FMontad := FDicTin['montad'];
  FA_n_o_ := FDicTin['a_n_o_'];
  FFatAce := IfNull(FDicTin['fatace'], 1.0);
  FVolPro := FDicTin['volpro'];

  { ********************************************* }
  { * VARIAVEIS DE TINTAS COM DILUIÇÃO DINAMICA * }
  { ******************************************PH* }
  FCodDil := IfNull(FDicTin['coddil'], '');
  FPorDil := IfNull(FDicTin['pordil'], 0.0);
  FDilCon := IfNull(FDicTin['dilcon'], '');
  FPorCat := IfNull(FDicTin['porcat'], 0.0);

  FTipCor := IfNull(FDicTin['tipcor'], '');

  FForTin.intModDil := IfNull(FDicTin['moddil'], 0);
  FForTin.strTextBase := IfNull(FDicTin['texbas'], '');
  FForTin.strTipCor := IfNull(FDicTin['tipcor'], '');
  FForTin.Formulas := TClassMatrizSaldosColorantes(FDicTin.RetornaObjeto('formul'));
  FForTin.Formulas := TClassMatrizSaldosColorantes.Create(FForTin.Formulas);
  FForTin.blnTemSaldoVenda := IfNull(FDicTin['saldocols'], True);
  FForTin.fltQtdMaximoBase := IfNull(FDicTin['maximoqtdbase'], 0);
  FForTin.strCompB := IfNull(FDicTin['complementob'], '');
  FForTin.strUniver := IfNull(FDicTin['univer'], '');
  FForTin.strCatali := IfNull(FDicTin['catal_'], '');

  FRefere := fRetornaReferenciaTinta(FIdePro, FQryTin);

  If fEmptyStr(FRefere) Then
    FRefere := fatVenda.fRetReferenciaTinta(FCodIte);

  FDesIte := fRetornaDescricaoTinta(FIdePro, FDesCor, FQryTin, FTipPre);

  If SameText(FIdePro, 'STA') And (fGetConfTinta(FIdePro).fGet('DESPST') = 'S') Then
    FDesIte := FDesIte + ' ' + FLinTin + ' ' + FA_n_o_;

  If fEmptyStr(FDesIte) Then
    Raise Exception.Create('Não foi possível retornar a descrição da tinta.');

  FPreVen := fFormataFloat(FDicTin['unitar'], fatVenda.VS_intDecUni);

  If FPreVen <= 0 Then
    Raise Exception.Create('O preço de venda está zerado. Verificar formulação');

  FPreVe1 := IfNull(FDicTin['preve1'], FPreVen);
  FPreVe2 := IfNull(FDicTin['preve2'], FPreVen);
  FPreVe3 := IfNull(FDicTin['preve3'], FPreVen);
  FPreVe4 := IfNull(FDicTin['preve4'], FPreVen);
  FPreVe5 := IfNull(FDicTin['preve5'], FPreVen);
  FPreVe6 := IfNull(FDicTin['preve6'], FPreVen);
  FPreVe7 := IfNull(FDicTin['preve7'], FPreVen);

  FFatTin := IfNull(FDicTin['fattin'], 0.0);

  FPrcTin := IfNull(FDicTin['prctin'], 0.0);
  FPrvTin := IfNull(FDicTin['preve' + FTabPre], 0.0);

  FOutVal := IfNull(FDicTin['outval'], 0);
  FIcmSai := IfNull(FDicTin['icmsai'], 0);
  FImpFed := IfNull(FDicTin['impfed'], 0);
  FDesOpe := IfNull(FDicTin['desope'], 0);
  FPreMed := IfNull(FDicTin['premed'], 0);
  FImpUlt := IfNull(FDicTin['impult'], 0);
  FPreUlt := IfNull(FDicTin['preult'], 0);

  FPreCus := fFormataFloat(FDicTin['precus'], fatVenda.VS_intDecUni);
  FPreCu2 := fFormataFloat(IfNull(FDicTin['precu2'], FPreCus), fatVenda.VS_intDecUni);
end;

procedure TConsultaPrecoTintaMonitor.pRetornarFormulacao;
Var
  LTinAux: TUniQuery;
  LItensTraML: TStringList;
  LCont: Integer;
begin
  If Not FCacheID.IsEmpty Then
    Exit;

  If (Not Assigned(fGTinForGeral)) Then
    Raise Exception.Create('Não foi encontrada a função "fGTinForGeral"');

  LTinAux := fCriaQuery;
  LItensTraML := TStringList.Create;

  For LCont := Low(FFormul) To High(FFormul) Do
  Begin
    FFormul[LCont].strFormul := '';
    FFormul[LCont].fltQtdbas := 0.0;
  End;

  SetLength(FPigmentos, 0);

  Try
    If Not fGTinForGeral(fRetornaSiglaTinta(IfNull(FDicTin['idepro'], '')),
      IfNull(FDicTin['itetin'], ''), IfNull(FDicTin['tippre'], ''), IfNull(FDicTin['lintin'], ''),
      IfNull(FDicTin['catali'], ''), IfNull(FDicTin['lazqua'], 0), IfNull(FDicTin['qtdemb'], 0),
      IfNull(FDicTin['qtdite'], 0), IfNull(FDicTin['descri'], ''), LTinAux,
      IfNull(FDicTin['volpro'], ''), FFormul, FPigmentos, LItensTraML,
      IfNull(FDicTin['coddil'], ''), IfNull(FDicTin['pordil'], 0), IfNull(FDicTin['dilcon'], ''),
      IfNull(FDicTin['porcat'], 0), IfNull(FDicTin['tipcor'], ''), IfNull(FDicTin['textbas'], ''),
      IfNull(FDicTin['moddil'], 0), IfNull(FDicTin['complementob'], ''),
      IfNull(FDicTin['empite'], VS_strCodEmp)) Then
      Raise Exception.Create('Não foi possível carregar a formulação desta tinta.');
  Finally
    FreeAndNil(LTinAux);
    FreeAndNil(LItensTraML);
  End;

  For LCont := Low(FFormul) To High(FFormul) Do
  Begin
    FFormul[LCont].fltQtdbas := FFormul[LCont].fltQtdbas * FQtdIte;
  End;

end;

procedure TConsultaPrecoTintaMonitor.pRetornarSaldoDisponivel;
Var
  LCodIte: String;
begin
  If Not FCacheID.IsEmpty Then
    LCodIte := fCampoTabela('TPR_CODITE', 'TINPRE_RES', ['TPR_RES_ID'], [FCacheID], False)
  Else
    LCodIte := FCodIte;

  FSalDis := fRetornaSaldoDisponivel(LCodIte, False, True);
end;

end.
