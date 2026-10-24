unit Services.ConsultarPreco.Tinta;

interface

uses
  System.DateUtils, System.Classes, System.SysUtils, System.Generics.Collections,
  System.StrUtils, System.Math, Data.DB, Uni, Faturamento.Classes.TFatVendaBase,
  untFuncFatTypes, System.Variants, untTypesSistema, untGTinForTipos,
  Shared.Core, untFuncoesGenerica, untMovGer,
  {$I '..\..\..\core\services.core.uses.inc'};

const
  MonitorConsultaPrecoTintaId = 'MONITOR_CONSULTAR_PRECO_TINTA_%s';

type
  TConsultarPrecoTinta = class(TComponent)
  strict private
    FObjFat: TFatVendaBase;
  private const
    FQtdIte: Integer = 1;
  protected
    procedure pRetornarPrecosTinta(FEmpresa: String = '');
    procedure pRetornarFormulacao;
    procedure pRetornarSaldoDisponivel;
    procedure pCalculaPesBruLiqTinta;
  public
    FIdePro: String;
    FMD5Key: String;
    FEmbPro: String;
    FModVen: String;
    FDilCod: String;

    FIteTin: String;
    FCodIte: String;
    FDesIte: String;
    FRefere: String;
    FChaFor: String;
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

    FDesOpeTin: Double;

    FSalDis: Double;

    FDicTin: TDicionario;
    FQryTin: TUniQuery;

    FUltMsg: String;

    FFormul: TForMulTinDetArray;
    FPigmentos: TBaixaPigmentosArray;

    FPesBru: Double;
    FPesLiq: Double;

    procedure pCarregarDadosTinta;

    constructor Create(AVenda: TFatVendaBase; AIdePro, AMD5Key: String; ATabPre: string = ''; AEmbPro: String = ''; AModVen: String = ''; ACodDil: String = ''); reintroduce;
    destructor Destroy; override;
  end;

type
  TConsultarPrecoTintaMonitor = class sealed(TInterfacedObject, ITaskMonitorProcedure)
  private
    FReq_Id: String;
    FCodCli: String;
    FCacheID: String;
    FConsultarTinta: TConsultarPrecoTinta;
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
    procedure pCarregarDadosTinta;
    procedure pGravarResultadoConsulta;
    procedure pAtualizarTermino;
    procedure pRegistrarErroConsultaPreco(AError: String);
  protected
    constructor Create(AReq_Id, ACodCli, AIdePro, AMD5Key, AEmbPro, AModVen: String);
  public
    procedure pExecute;
    procedure pExecuteAll;
    destructor Destroy; Override;
    class procedure pIniciarObjetos;
    class procedure pFinalizarObjetos;
    class function New(): ITaskMonitorProcedure; overload;
    class function New(AReq_Id, ACodCli, AIdePro, AMD5Key, AEmbPro, AModVen: String): ITaskMonitorProcedure; overload;
  end;

function ExecutarConsultaPrecoTintaMonitor(): Boolean;

Var
  VS_strLockMonitorConsultaPrecoTinta: String;
  VS_dtaUltimaExecucaoMonitorConsultaPrecoTinta: TDateTime;

implementation

uses
  untFuncTinta, untTMatrizSaldosColorantes, untFuncoesSaldos,
  untImportaTintometricosTerceirosTabelas, untTipoTinta, untParCalculaPrecoCusto,
  untTConfiguracao, untCadPro, untFatVendasCalculadorWrapper, Promocao.Regra.Preco.Sugestao,
  untFatVendasCalculadorWrapperTAB, untTransferencias, untITransferencias,
  untIFatOrdProTintaMaquina, untFatOrdProTintaMaquina, untLiberacao,
  untExecutaSQLReplicacaoTinta, untFatDefineLotesPedidoWMSWrapper,
  untFuncoesCRM;

const
  NO_TIME_LIMIT = 0;

procedure pFreeLibTintaMaquina;
begin
  if HandleDllTinta <> 0 then
    FreeLibrary(HandleDllTinta);
end;

procedure pLoadLibTintaMaquina;
begin
  pCarregaFuncoesDll(fGravaMovGer,
                     fGravaMovDet,
                     TTransferencias.Create,
                     TFatOrdProTintaMaquina.Create,
                     TLiberacao.Create,
                     nil {VS_objTraceViewer},
                     TExecutaSQLReplicacaoTinta.Create,
                     TFatDefineLotesPedidoWMSWrapper.Create,
                     TFuncoesCRM.Create,
                     TFuncoesSaldos.Create,
                     nil {pImprimeFatImpTin});
end;

function ExecutarConsultaPrecoTintaMonitor(): Boolean;
Var
  LTask: TTaskMonitor;
begin
  Result := False;
  pIniciarConexao;
  Try
    Try
      pDefinirEmpresa;
      pDefinirUsuario;
      pIniciarVariaveis;
    Except
      On E: Exception Do
      Begin
        WriteError(E.ClassName + ': ' + E.Message);
        Exit;
      End;
    End;

    Try
      If Not fCfgSis('USATMQ', varBoolean) Then
      Begin
        WriteError('Empresa configurada para nao utilizar Tinta de Maquina (' +
          VS_strCodEmp + ')');
        Exit;
      End;

      If HasParam('-f') Then
        TTaskLock.pDestravaLockForcado(Format(MonitorConsultaPrecoTintaId,
          [VS_strCodEmp]), 0);

      TTaskMonitor.SleepTimeout := 1000;

      If TUtilTaskMonitor.fLockTaskMonitor(MonitorConsultaPrecoTintaId,
        VS_strLockMonitorConsultaPrecoTinta) Then
      Begin
        Try
          pLoadLibTintaMaquina;
          Try
            LTask := TTaskMonitor.Create(MonitorConsultaPrecoTintaId,
              NO_TIME_LIMIT, VS_strLockMonitorConsultaPrecoTinta,
              TConsultarPrecoTintaMonitor.New());
            Try
              LTask.Start;
              While Not LTask.Finished Do
                Sleep(1000);
              Result := True;
            Finally
              FreeAndNil(LTask);
            End;
          Finally
            pFreeLibTintaMaquina;
          End;
        Except
          On E: Exception Do
          Begin
            WriteError(E.ClassName + ': ' + E.Message);
            Exit;
          End;
        End;
      End
      Else
        WriteError('O servico ja esta sendo executado ... ');

    Finally
      WriteLog('Encerrando servico ...');
      TUtilTaskMonitor.fRemoveLockTaskMonitor(MonitorConsultaPrecoTintaId);
    End;

  Finally
    objConnectionsManager.EndConnection;
  End;
end;

{ TConsultarPrecoTintaMonitor }

constructor TConsultarPrecoTintaMonitor.Create(AReq_Id, ACodCli, AIdePro, AMD5Key, AEmbPro, AModVen: String);
begin
  FConsultarTinta := TConsultarPrecoTinta.Create(fatVenda, AIdePro, AMD5Key, '', AEmbPro, AModVen);
  FReq_Id := AReq_Id;
  FCodCli := ACodCli;
end;

destructor TConsultarPrecoTintaMonitor.Destroy;
begin
  inherited;
end;

class function TConsultarPrecoTintaMonitor.fGetSQLConsultaPrecoTintaPendentes: String;
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

class function TConsultarPrecoTintaMonitor.New(AReq_Id, ACodCli, AIdePro, AMD5Key, AEmbPro, AModVen: String)
  : ITaskMonitorProcedure;
begin
  Result := Self.Create(AReq_Id, ACodCli, AIdePro, AMD5Key, AEmbPro, AModVen);
end;

class function TConsultarPrecoTintaMonitor.New: ITaskMonitorProcedure;
begin
  Result := Self.Create('', '', '', '', '', '');
end;

procedure TConsultarPrecoTintaMonitor.pAtualizarTermino;
Var
  LQuery: IQuery;
begin
  WriteLog('Gravando termino da consulta de preco (ID:' + FReq_Id + ')');
  LQuery := fCriaQuery;
  Try
    LQuery.Close;
    LQuery.SQL.Text := 'SELECT * FROM TINPRE_REQ WHERE TPR_REQ_ID = ' + FReq_Id;
    LQuery.Open;
    If LQuery.IsEmpty Then
      Raise Exception.Create
        ('Não foi encontrado registro na tabela TINPRE_REQ com o id informado.');
    LQuery.Edit;
    LQuery.FieldByName('TPR_DTHRES').Value := Vs_date + Time;
    LQuery.FieldByName('TPR_CACHE_').Value := IIF(FCacheID.IsEmpty, 'N', 'S');
    LQuery.Post;
  Finally

  End;
end;

procedure TConsultarPrecoTintaMonitor.pAtualizarInicio;
Var
  LQuery: IQuery;
begin
  WriteLog('Gravando inicio da consulta de preco (ID:' + FReq_Id + ')');
  LQuery := fCriaQuery;
  Try
    LQuery.Close;
    LQuery.SQL.Text := 'SELECT * FROM TINPRE_REQ WHERE TPR_REQ_ID = ' + FReq_Id;
    LQuery.Open;
    If LQuery.IsEmpty Then
      Raise Exception.Create
        ('Não foi encontrado registro na tabela TINPRE_REQ com o id informado.');
    LQuery.Edit;
    LQuery.FieldByName('TPR_DTHINI').Value := Vs_date + Time;
    LQuery.Post;
  Finally

  End;
end;

procedure TConsultarPrecoTintaMonitor.pCarregarCliente;
begin
  If Not FCacheID.IsEmpty Then
    Exit;

  If fatVenda.strCodCli.Equals(FCodCli) Then
    Exit;

  fatVenda.pCarregaDadosClienteBaixa(FCodCli);
end;

procedure TConsultarPrecoTintaMonitor.pCarregarCondPagto;
begin
  If Not FCacheID.IsEmpty Then
    Exit;

  fatVenda.pAtualizaInformacoesCondPagamento;
  fatVenda.intPrzMed := fFloatToInt(fCalcMediaPagto(fatVenda.strConPag));
  fatVenda.blnTaxVpr := False;
  fatVenda.fltTaxJur := 0.00;
end;

procedure TConsultarPrecoTintaMonitor.pCarregarVendedor;
Var
  LCodVen: String;
begin
  If Not FCacheID.IsEmpty Then
    Exit;

  LCodVen := strLoginUsuarioLogado;

  If fEmptyStr(fatVenda.strCodVen) Then
  Begin
    fatVenda.strCodVen := LCodVen;
    fatVenda.strNomVen := fRetNomVendedor(fatVenda.strCodVen);
    fatVenda.fltComVen := fCampoTabela('OPE_PERCOM', 'CADOPE', ['OPE_CODOPE'], [LCodVen], False);
    fatVenda.strTipVen := fCampoTabela('OPE_INTEXT', 'CADOPE', ['OPE_CODOPE'], [LCodVen], False);
  End;

  If fEmptyStr(fatVenda.strCodDig) Then
  Begin
    fatVenda.strCodDig := LCodVen;
    fatVenda.strNomDig := fRetNomVendedor(fatVenda.strCodDig);
  End;
end;

procedure TConsultarPrecoTintaMonitor.pExecute;
begin
  Try
    pAtualizarInicio;
    pLocalizarCacheID;
    pCarregarCliente;
    pCarregarCondPagto;
    pCarregarVendedor;
    pCarregarDadosTinta;
    pGravarResultadoConsulta;
    pAtualizarTermino;
  except
    on E: Exception do
    begin
      pRegistrarErroConsultaPreco(E.Message);
    end;
  end;
end;

procedure TConsultarPrecoTintaMonitor.pExecuteAll;
var
  LQuery: IQuery;
  LReq_Id: String;
  LCodCli: String;
  LIdePro: String;
  LMD5Key: String;
  LEmbPro: String;
  LModVen: String;
begin
  LQuery := fCriaQuery();
  LQuery.SQL.Add(Format(fGetSQLConsultaPrecoTintaPendentes, [VS_strCodEmp]));
  LQuery.Open();

  If LQuery.IsEmpty Then
    Exit;

  pIniciarObjetos;
  Try
    While (Not LQuery.Eof) Do
    Begin
      LReq_Id := LQuery.FieldByName('TPR_REQ_ID').AsString;
      LCodCli := LQuery.FieldByName('TPR_CODCLI').AsString;
      LIdePro := LQuery.FieldByName('TPR_IDEPRO').AsString;
      LMD5Key := LQuery.FieldByName('TPR_MD5TIN').AsString;
      LEmbPro := LQuery.FieldByName('TPR_EMBPRO').AsString;
      LModVen := LQuery.FieldByName('TPR_MODVEN').AsString;

      TConsultarPrecoTintaMonitor.New(LReq_Id, LCodCli, LIdePro, LMD5Key, LEmbPro, LModVen).pExecute();

      If (LQuery.RecNo Mod 10 = 0) Then
      Begin
        pZerarTentativasLock(Format(MonitorConsultaPrecoTintaId, [VS_strCodEmp]));
        Sleep(1000);
      End;

      LQuery.Next;
    End;
  Finally
    pFinalizarObjetos;
  End;
end;

class procedure TConsultarPrecoTintaMonitor.pFinalizarObjetos;
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

procedure TConsultarPrecoTintaMonitor.pGravarResultadoCache;
Var
  LQuery: IQuery;
  LCache: IQuery;
  LIndex: Integer;
begin
  If FCacheID.IsEmpty Then
    Exit;

  LQuery := fCriaQuery;
  LCache := fCriaQuery;

  LCache.Close;
  LCache.SQL.Text := 'SELECT * FROM TINPRE_RES WHERE TPR_RES_ID = ' + FCacheID;
  LCache.Open;

  LQuery.Close;
  LQuery.SQL.Text := 'SELECT * FROM TINPRE_RES WHERE FALSE';
  LQuery.Open;
  LQuery.Append;

  For LIndex := 0 To LQuery.FieldCount - 1 Do
  Begin
    If LQuery.Fields(LIndex).FieldName.Equals('TPR_RES_ID') Then
      Continue;

    If LQuery.Fields(LIndex).FieldName.Equals('TPR_REQ_ID') Then
    Begin
      LQuery.Fields(LIndex).Value := FReq_Id.ToInt64;
      Continue;
    End;

    If LQuery.Fields(LIndex).FieldName.Equals('TPR_SALDIS') Then
    Begin
      LQuery.Fields(LIndex).Value := FConsultarTinta.FSalDis;
      Continue;
    End;

    LQuery.Fields(LIndex).Value := LCache.Fields(LIndex).Value;
  End;

  LQuery.Post;
end;

procedure TConsultarPrecoTintaMonitor.pGravarResultadoConsulta;
Var
  LQuery: IQuery;
  LCodEmp: String;
begin
  WriteLog('Gravando resultado da consulta de preco (ID:' + FReq_Id + ')');

  If Not FCacheID.IsEmpty Then
  Begin
    pGravarResultadoCache;
    Exit;
  End;

  LCodEmp := VS_strCodEmp;

  LQuery := fCriaQuery;

  LQuery.Close;
  LQuery.SQL.Text := 'SELECT * FROM TINPRE_RES WHERE FALSE';
  LQuery.Open;

  LQuery.Append;
  LQuery.FieldByName('TPR_REQ_ID').Value := FReq_Id.ToInt64;
  LQuery.FieldByName('TPR_CODEMP').Value := VS_strCodEmp;
  LQuery.FieldByName('TPR_IDEPRO').Value := FConsultarTinta.FIdePro;
  LQuery.FieldByName('TPR_MD5TIN').Value := FConsultarTinta.FMD5Key;
  LQuery.FieldByName('TPR_EMBPRO').Value := FConsultarTinta.FEmbPro;
  LQuery.FieldByName('TPR_MODVEN').Value := FConsultarTinta.FModVen;
  LQuery.FieldByName('TPR_CODCLI').Value := FCodCli;
  LQuery.FieldByName('TPR_CODITE').Value := FConsultarTinta.FCodIte;
  LQuery.FieldByName('TPR_IDEPRO').Value := FConsultarTinta.FIdePro;
  LQuery.FieldByName('TPR_DESCRI').Value := FConsultarTinta.FDesIte.Replace('"', '').Replace('''', '');
  LQuery.FieldByName('TPR_REFERE').Value := FConsultarTinta.FRefere.Replace('"', '').Replace('''', '');
  LQuery.FieldByName('TPR_UNIDAD').Value := FConsultarTinta.FUnidad;
  LQuery.FieldByName('TPR_TABPRE').Value := FConsultarTinta.FTabPre;
  LQuery.FieldByName('TPR_PREVEN').Value := FConsultarTinta.FPreVen;
  LQuery.FieldByName('TPR_PREVE1').Value := FConsultarTinta.FPreVe1;
  LQuery.FieldByName('TPR_PREVE2').Value := FConsultarTinta.FPreVe2;
  LQuery.FieldByName('TPR_PREVE3').Value := FConsultarTinta.FPreVe3;
  LQuery.FieldByName('TPR_PREVE4').Value := FConsultarTinta.FPreVe4;
  LQuery.FieldByName('TPR_PREVE5').Value := FConsultarTinta.FPreVe5;
  LQuery.FieldByName('TPR_PREVE6').Value := FConsultarTinta.FPreVe6;
  LQuery.FieldByName('TPR_PREVE7').Value := FConsultarTinta.FPreVe7;
  LQuery.FieldByName('TPR_OUTVAL').Value := FConsultarTinta.FOutVal;
  LQuery.FieldByName('TPR_ICMSAI').Value := FConsultarTinta.FIcmSai;
  LQuery.FieldByName('TPR_IMPFED').Value := FConsultarTinta.FImpFed;
  LQuery.FieldByName('TPR_DESOPE').Value := FConsultarTinta.FDesOpe;
  LQuery.FieldByName('TPR_PREMED').Value := FConsultarTinta.FPreMed; { TODO : conferir precos }
  LQuery.FieldByName('TPR_IMPULT').Value := FConsultarTinta.FImpUlt;
  LQuery.FieldByName('TPR_PREULT').Value := FConsultarTinta.FPreUlt;
  LQuery.FieldByName('TPR_PRECUS').Value := FConsultarTinta.FPreCus;
  LQuery.FieldByName('TPR_PRECU2').Value := FConsultarTinta.FPreCu2;
  LQuery.FieldByName('TPR_SALDIS').Value := FConsultarTinta.FSalDis;
  //Dados para gravacao FATDOR
  LQuery.FieldByName('TPR_PRCTIN').Value := FConsultarTinta.FPrcTin;
  LQuery.FieldByName('TPR_PRVTIN').Value := FConsultarTinta.FPrvTin;
  LQuery.FieldByName('TPR_ITETIN').Value := FConsultarTinta.FIteTin;
  LQuery.FieldByName('TPR_DESCOR').Value := FConsultarTinta.FDesCor.Replace('"', '').Replace('''', '');
  LQuery.FieldByName('TPR_TIPEMB').Value := FConsultarTinta.FTipEmb;
  LQuery.FieldByName('TPR_QTDEMB').Value := FConsultarTinta.FQtdEmb;
  LQuery.FieldByName('TPR_PREEMB').Value := FConsultarTinta.FPreEmb;
  LQuery.FieldByName('TPR_ITEEMB').Value := FConsultarTinta.FCodEmb;
  //Dados para gravacao TINDOR
  LQuery.FieldByName('TPR_MONTAD').Value := FConsultarTinta.FMontad;
  LQuery.FieldByName('TPR_A_N_O_').Value := FConsultarTinta.FA_n_o_;
  LQuery.FieldByName('TPR_TIPPRE').Value := FConsultarTinta.FTipPre;
  LQuery.FieldByName('TPR_FATTIN').Value := FConsultarTinta.FFatTin;
  LQuery.FieldByName('TPR_LAZQUA').Value := FConsultarTinta.FLazQua;
  LQuery.FieldByName('TPR_VOLPRO').Value := FConsultarTinta.FVolPro;
  LQuery.FieldByName('TPR_LINLIN').Value := FConsultarTinta.FLinTin;
  LQuery.FieldByName('TPR_CATALI').Value := FConsultarTinta.FCatali.Replace('"', '').Replace('''', '');
  LQuery.FieldByName('TPR_CODDIL').Value := FConsultarTinta.FCodDil;
  LQuery.FieldByName('TPR_PORDIL').Value := FConsultarTinta.FPorDil;
  LQuery.FieldByName('TPR_DILCON').Value := FConsultarTinta.FDilCon;
  LQuery.FieldByName('TPR_PORCAT').Value := FConsultarTinta.FPorCat;
  LQuery.FieldByName('TPR_OBSCOL').Value := FConsultarTinta.FObsCol.Replace('"', '').Replace('''', '');
  LQuery.FieldByName('TPR_TIPFOR').Value := FConsultarTinta.FTipFor;
  LQuery.FieldByName('TPR_TINAUT').Value := fTipoTinta(FConsultarTinta.FIdePro) = ttAutomotiva;
  LQuery.FieldByName('TPR_FORM01').Value := FConsultarTinta.FFormul[01].strFormul;
  LQuery.FieldByName('TPR_FORM02').Value := FConsultarTinta.FFormul[02].strFormul;
  LQuery.FieldByName('TPR_FORM03').Value := FConsultarTinta.FFormul[03].strFormul;
  LQuery.FieldByName('TPR_FORM04').Value := FConsultarTinta.FFormul[04].strFormul;
  LQuery.FieldByName('TPR_FORM05').Value := FConsultarTinta.FFormul[05].strFormul;
  LQuery.FieldByName('TPR_FORM06').Value := FConsultarTinta.FFormul[06].strFormul;
  LQuery.FieldByName('TPR_FORM07').Value := FConsultarTinta.FFormul[07].strFormul;
  LQuery.FieldByName('TPR_FORM08').Value := FConsultarTinta.FFormul[08].strFormul;
  LQuery.FieldByName('TPR_FORM09').Value := FConsultarTinta.FFormul[09].strFormul;
  LQuery.FieldByName('TPR_FORM10').Value := FConsultarTinta.FFormul[10].strFormul;
  LQuery.FieldByName('TPR_FORM11').Value := FConsultarTinta.FFormul[11].strFormul;
  LQuery.FieldByName('TPR_FORM12').Value := FConsultarTinta.FFormul[12].strFormul;
  LQuery.FieldByName('TPR_FORM13').Value := FConsultarTinta.FFormul[13].strFormul;
  LQuery.FieldByName('TPR_FORM14').Value := FConsultarTinta.FFormul[14].strFormul;
  LQuery.FieldByName('TPR_FORM15').Value := FConsultarTinta.FFormul[15].strFormul;
  LQuery.FieldByName('TPR_FORM16').Value := FConsultarTinta.FFormul[16].strFormul;
  LQuery.FieldByName('TPR_FORM17').Value := FConsultarTinta.FFormul[17].strFormul;
  LQuery.FieldByName('TPR_FORM18').Value := FConsultarTinta.FFormul[18].strFormul;
  LQuery.FieldByName('TPR_FORM19').Value := FConsultarTinta.FFormul[19].strFormul;
  LQuery.FieldByName('TPR_FORM20').Value := FConsultarTinta.FFormul[20].strFormul;
  LQuery.FieldByName('TPR_ITEC01').Value := fColorante(FConsultarTinta.FFormul[01].strFormul, FConsultarTinta.FIdePro, LCodEmp);
  LQuery.FieldByName('TPR_ITEC02').Value := fColorante(FConsultarTinta.FFormul[02].strFormul, FConsultarTinta.FIdePro, LCodEmp);
  LQuery.FieldByName('TPR_ITEC03').Value := fColorante(FConsultarTinta.FFormul[03].strFormul, FConsultarTinta.FIdePro, LCodEmp);
  LQuery.FieldByName('TPR_ITEC04').Value := fColorante(FConsultarTinta.FFormul[04].strFormul, FConsultarTinta.FIdePro, LCodEmp);
  LQuery.FieldByName('TPR_ITEC05').Value := fColorante(FConsultarTinta.FFormul[05].strFormul, FConsultarTinta.FIdePro, LCodEmp);
  LQuery.FieldByName('TPR_ITEC06').Value := fColorante(FConsultarTinta.FFormul[06].strFormul, FConsultarTinta.FIdePro, LCodEmp);
  LQuery.FieldByName('TPR_ITEC07').Value := fColorante(FConsultarTinta.FFormul[07].strFormul, FConsultarTinta.FIdePro, LCodEmp);
  LQuery.FieldByName('TPR_ITEC08').Value := fColorante(FConsultarTinta.FFormul[08].strFormul, FConsultarTinta.FIdePro, LCodEmp);
  LQuery.FieldByName('TPR_ITEC09').Value := fColorante(FConsultarTinta.FFormul[09].strFormul, FConsultarTinta.FIdePro, LCodEmp);
  LQuery.FieldByName('TPR_ITEC10').Value := fColorante(FConsultarTinta.FFormul[10].strFormul, FConsultarTinta.FIdePro, LCodEmp);
  LQuery.FieldByName('TPR_ITEC11').Value := fColorante(FConsultarTinta.FFormul[11].strFormul, FConsultarTinta.FIdePro, LCodEmp);
  LQuery.FieldByName('TPR_ITEC12').Value := fColorante(FConsultarTinta.FFormul[12].strFormul, FConsultarTinta.FIdePro, LCodEmp);
  LQuery.FieldByName('TPR_ITEC13').Value := fColorante(FConsultarTinta.FFormul[13].strFormul, FConsultarTinta.FIdePro, LCodEmp);
  LQuery.FieldByName('TPR_ITEC14').Value := fColorante(FConsultarTinta.FFormul[14].strFormul, FConsultarTinta.FIdePro, LCodEmp);
  LQuery.FieldByName('TPR_ITEC15').Value := fColorante(FConsultarTinta.FFormul[15].strFormul, FConsultarTinta.FIdePro, LCodEmp);
  LQuery.FieldByName('TPR_ITEC16').Value := fColorante(FConsultarTinta.FFormul[16].strFormul, FConsultarTinta.FIdePro, LCodEmp);
  LQuery.FieldByName('TPR_ITEC17').Value := fColorante(FConsultarTinta.FFormul[17].strFormul, FConsultarTinta.FIdePro, LCodEmp);
  LQuery.FieldByName('TPR_ITEC18').Value := fColorante(FConsultarTinta.FFormul[18].strFormul, FConsultarTinta.FIdePro, LCodEmp);
  LQuery.FieldByName('TPR_ITEC19').Value := fColorante(FConsultarTinta.FFormul[19].strFormul, FConsultarTinta.FIdePro, LCodEmp);
  LQuery.FieldByName('TPR_ITEC20').Value := fColorante(FConsultarTinta.FFormul[20].strFormul, FConsultarTinta.FIdePro, LCodEmp);
  LQuery.FieldByName('TPR_QTDB01').Value := FConsultarTinta.FFormul[01].fltQtdbas;
  LQuery.FieldByName('TPR_QTDB02').Value := FConsultarTinta.FFormul[02].fltQtdbas;
  LQuery.FieldByName('TPR_QTDB03').Value := FConsultarTinta.FFormul[03].fltQtdbas;
  LQuery.FieldByName('TPR_QTDB04').Value := FConsultarTinta.FFormul[04].fltQtdbas;
  LQuery.FieldByName('TPR_QTDB05').Value := FConsultarTinta.FFormul[05].fltQtdbas;
  LQuery.FieldByName('TPR_QTDB06').Value := FConsultarTinta.FFormul[06].fltQtdbas;
  LQuery.FieldByName('TPR_QTDB07').Value := FConsultarTinta.FFormul[07].fltQtdbas;
  LQuery.FieldByName('TPR_QTDB08').Value := FConsultarTinta.FFormul[08].fltQtdbas;
  LQuery.FieldByName('TPR_QTDB09').Value := FConsultarTinta.FFormul[09].fltQtdbas;
  LQuery.FieldByName('TPR_QTDB10').Value := FConsultarTinta.FFormul[10].fltQtdbas;
  LQuery.FieldByName('TPR_QTDB11').Value := FConsultarTinta.FFormul[11].fltQtdbas;
  LQuery.FieldByName('TPR_QTDB12').Value := FConsultarTinta.FFormul[12].fltQtdbas;
  LQuery.FieldByName('TPR_QTDB13').Value := FConsultarTinta.FFormul[13].fltQtdbas;
  LQuery.FieldByName('TPR_QTDB14').Value := FConsultarTinta.FFormul[14].fltQtdbas;
  LQuery.FieldByName('TPR_QTDB15').Value := FConsultarTinta.FFormul[15].fltQtdbas;
  LQuery.FieldByName('TPR_QTDB16').Value := FConsultarTinta.FFormul[16].fltQtdbas;
  LQuery.FieldByName('TPR_QTDB17').Value := FConsultarTinta.FFormul[17].fltQtdbas;
  LQuery.FieldByName('TPR_QTDB18').Value := FConsultarTinta.FFormul[18].fltQtdbas;
  LQuery.FieldByName('TPR_QTDB19').Value := FConsultarTinta.FFormul[19].fltQtdbas;
  LQuery.FieldByName('TPR_QTDB20').Value := FConsultarTinta.FFormul[20].fltQtdbas;
  //Dados para gravacao FORTIN
  LQuery.FieldByName('TPR_MODDIL').Value := FConsultarTinta.FForTin.intModDil;
  LQuery.FieldByName('TPR_TEXBAS').Value := FConsultarTinta.FForTin.strTextBase;
  LQuery.FieldByName('TPR_TIPCOR').Value := FConsultarTinta.FForTin.strTipCor;
  LQuery.FieldByName('TPR_ITECOB').Value := FConsultarTinta.FForTin.strCompB;
  LQuery.FieldByName('TPR_UNIVER').Value := FConsultarTinta.FForTin.strUniver;
  LQuery.FieldByName('TPR_FATACE').Value := FConsultarTinta.FFatAce;
  LQuery.FieldByName('TPR_CATAL_').Value := FConsultarTinta.FForTin.strCatali.Replace('"', '').Replace('''', '');
  LQuery.Post;
end;

class procedure TConsultarPrecoTintaMonitor.pIniciarObjetos;
begin
  If Assigned(Self.fatVenda) Then
    Exit;

  Self.fatVenda := TFatVendaBase.CreateInstance('PD', False);
  Self.fatVenda.strNomeForm := 'frmFatVendas';
  Self.fatVenda.strEspDoc := 'PD';
  Self.fatVenda.qryConIte := fCriarQueryIteGer(Self.fatVenda);

  Self.fatVenda.pCriarCdsVenda(nil);

  If Assigned(VS_stlTabNre) Then
    FreeAndNil(VS_stlTabNre);

  fExecutaSQL('REPLACE INTO TABNRE (NOMTAB) VALUES ("TINPRE_REQ")');
  fExecutaSQL('REPLACE INTO TABNRE (NOMTAB) VALUES ("TINPRE_RES")');

  pCarregaNre;
end;

procedure TConsultarPrecoTintaMonitor.pLocalizarCacheID;
Var
  LQuery: IQuery;
begin
  LQuery := fCriaQuery;
  LQuery.SQL.Add('SELECT SQL_NO_CACHE ');
  LQuery.SQL.Add('  TPR_RES_ID ');
  LQuery.SQL.Add('FROM ');
  LQuery.SQL.Add('  TINPRE_REQ A ');
  LQuery.SQL.Add('  JOIN TINPRE_RES B ');
  LQuery.SQL.Add('    ON A.TPR_REQ_ID = B.TPR_REQ_ID ');
  LQuery.SQL.Add('WHERE TRUE ');
  LQuery.SQL.Add('  AND A.TPR_IDEPRO = "' + FConsultarTinta.FIdePro + '" ');
  LQuery.SQL.Add('  AND A.TPR_MD5TIN = "' + FConsultarTinta.FMD5Key + '" ');

  If fTipoTinta(FConsultarTinta.FIdePro) = ttAutomotiva Then
  Begin
    LQuery.SQL.Add(' AND A.TPR_EMBPRO = "' + FConsultarTinta.FEmbPro + '" ');
    LQuery.SQL.Add(' AND A.TPR_MODVEN = "' + FConsultarTinta.FModVen + '" ');
  End;

  LQuery.SQL.Add('  AND A.TPR_CODEMP = "' + VS_strCodEmp + '"   ');
  LQuery.SQL.Add('  AND A.TPR_CACHE_ = "N" ');
  LQuery.SQL.Add('  AND A.TPR_MSGERR IS NULL ');
  LQuery.SQL.Add('  AND TPR_DTHRES > DATE_SUB(' + fCurrentDateTime + ', INTERVAL 10 MINUTE) ');
  LQuery.Open;
  FCacheID := LQuery.FieldByName('TPR_RES_ID').AsString;
end;

procedure TConsultarPrecoTintaMonitor.pRegistrarErroConsultaPreco(AError: String);
Var
  LQuery: IQuery;
begin
  LQuery := fCriaQuery;
  LQuery.Close;
  LQuery.SQL.Text := 'SELECT * FROM TINPRE_REQ WHERE TPR_REQ_ID = ' + FReq_Id;
  LQuery.Open;
  If LQuery.IsEmpty Then
    Raise Exception.Create
      ('Não foi encontrado registro na tabela TINPRE_REQ com o id informado.');
  LQuery.Edit;
  LQuery.FieldByName('TPR_DTHRES').Value := Vs_date + Time;
  LQuery.FieldByName('TPR_MSGERR').Value := AError;
  LQuery.Post;
end;

procedure TConsultarPrecoTintaMonitor.pCarregarDadosTinta;
begin
  If FCacheID.IsEmpty Then
  Begin
    FConsultarTinta.pCarregarDadosTinta;
    Exit;
  End;
  FConsultarTinta.FCodIte := fCampoTabela('TPR_CODITE', 'TINPRE_RES', ['TPR_RES_ID'], [FCacheID], False);
  FConsultarTinta.pRetornarSaldoDisponivel;
end;

{ TConsultarPrecoTinta }

constructor TConsultarPrecoTinta.Create(AVenda: TFatVendaBase; AIdePro, AMD5Key: String; ATabPre: string = ''; AEmbPro: String = ''; AModVen: String = ''; ACodDil: String = '');
begin
  inherited Create(AVenda);
  FObjFat := AVenda;
  FIdePro := AIdePro;
  FMD5Key := AMD5Key;
  FTabPre := ATabPre;
  FEmbPro := AEmbPro;
  FModVen := AModVen;
  FDilCod := ACodDil;
  FDicTin := TDicionario.Create;
  FQryTin := Shared.Core.fCriaQuery;
  FillChar(FForTin, SizeOf(FForTin), #0);
end;

destructor TConsultarPrecoTinta.Destroy;
begin
  FDicTin.LimparObjetos;
  FDicTin.Limpar;
  FreeAndNil(FDicTin);
  FreeAndNil(FQryTin);
  inherited;
end;

procedure TConsultarPrecoTinta.pCalculaPesBruLiqTinta;
var
  LIndex: Integer;
begin
  FPesBru := 0;
  FPesLiq := 0;

  If (fTipoTinta(FIdePro) in [ttAutomotiva, ttIndustrial]) Then
  Begin
    For LIndex := 0 To FForTin.Formulas.Count - 1 Do
    Begin
      If FForTin.Formulas[LIndex].strBasCol <> EMBALAGEM then
      Begin
        FPesBru := FPesBru + FForTin.Formulas[LIndex].fltQtdFormula;
        FPesLiq := FPesLiq + FForTin.Formulas[LIndex].fltQtdFormula;
      End;
    End;

    FPesBru := fFormataFloat(FPesBru / 1000, 4);
    FPesLiq := fFormataFloat(FPesLiq / 1000, 4);
  End;
end;

procedure TConsultarPrecoTinta.pCarregarDadosTinta;
begin
  Self.pRetornarPrecosTinta;
  Self.pRetornarFormulacao;
  Self.pRetornarSaldoDisponivel;
  Self.pCalculaPesBruLiqTinta;
end;

procedure TConsultarPrecoTinta.pRetornarFormulacao;
Var
  LTinAux: TUniQuery;
  LItensTraML: TStringList;
  LCont: Integer;
begin
  If (Not Assigned(fGTinForGeral)) Then
    Raise Exception.Create('Não foi encontrada a função "fGTinForGeral"');

  LTinAux := Shared.Core.fCriaQuery;
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

procedure TConsultarPrecoTinta.pRetornarPrecosTinta(FEmpresa: String = '');
Var
  strTabPrc: String;
begin
  WriteLog('Carregando Precos da Tinta ['+ FIdePro + ' - ' + FMD5Key + ']');

  If (VS_strUsaTmq = 'N') Then
    Raise Exception.Create('Empresa não configurada para utilizar tinta de máquina.');

  If Not IsTintaExistente(FIdePro, False) Then
    Raise Exception.Create('Não foi encontrado nenhum módulo de tinta com IDEPRO = "'+FIdePro+'".');

  If Not FObjFat.fPodeUtilizarTinta(FIdePro) Then
    Raise Exception.Create('Não é permitido vender uma tinta ' + fRetornaNomeTinta(FIdePro) +
      ' sem utilizar produção fora da loja.');

  FObjFat.strIdePro := FIdePro;

  If FTabPre.IsEmpty then
    FTabPre := FObjFat.fDefineTabelaPrecoItem(FIdePro, '');

  FDicTin['idepro'] := FIdePro;

  If FEmpresa.IsEmpty Then
    FDicTin['codemp'] := VS_strCodEmp
  Else
    FDicTin['codemp'] := FEmpresa;

  FDicTin['opcdoc'] := FObjFat.strOpcDoc;
  FDicTin['oprflj'] := FObjFat.strOprFlj;
  FDicTin['codempprd'] := VS_strCodEmp;
  FDicTin['empprd'] := fCfgSis('EMPPRD');
  FDicTin['emp_cd'] := fCfgSis('EMP_CD');
  FDicTin['empfat'] := IIF(FObjFat.blnEmpFat, VS_strCodEmp, FObjFat.fEmpresaSaldoMatriz_CD);
{$IFNDEF LINUX}
  FDicTin['FatS_N'] := IIF(FObjFat.blnEmpFat, 'S', 'N');
  FDicTin['Cd_S_N'] := IIF(FObjFat.blnEnt_CD, 'S', 'N');
{$ELSE}
  FDicTin['FatS_N'] := 'N';
  FDicTin['Cd_S_N'] := 'N';
{$ENDIF}
  FDicTin['usaprecus'] := False;
  FDicTin['usapremed'] := False;
  FDicTin['codcli'] := FObjFat.strCodCli;
  FDicTin['przmed'] := FObjFat.intPrzMed;
  FDicTin['codcnd'] := FObjFat.strCodCnd;
  FDicTin['propre'] := (fCfgSis('PROPRE') = TRegraPrecoSugestao.PrecoDeTabela.Valor.ToString);
  FDicTin['tabpre'] := FTabPre;

  FDicTin.AdicionarObjeto('calculadorFatVendas', TFatVendasCalculadorWrapper.Create(FObjFat));
  FDicTin.AdicionarObjeto('calculadorFatVendasTAB', TFatVendasCalculadorWrapperTAB.Create(FObjFat));

  pSetaEmpresaLogadaTinta(FDicTin['codemp']);

  If Not Assigned(untFuncTinta.fRetornaPrecoTintaSemTela) Then
    Raise Exception.Create('Não foi encontrada a função "fRetornaPrecoTintaSemTela".');

  If Not untFuncTinta.fRetornaPrecoTintaSemTela(FIdePro, FMD5Key, FDicTin, FQryTin, FUltMsg, FEmbPro, FModVen, FDilCod) Then
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
    FRefere := FObjFat.fRetReferenciaTinta(FCodIte);

  FDesIte := fRetornaDescricaoTinta(FIdePro, FDesCor, FQryTin, FTipPre);

  If SameText(FIdePro, 'STA') And (fGetConfTinta(FIdePro).fGet('DESPST') = 'S') Then
    FDesIte := FDesIte + ' ' + FLinTin + ' ' + FA_n_o_;

  If fEmptyStr(FDesIte) Then
    Raise Exception.Create('Não foi possível retornar a descrição da tinta.');

  FChaFor := FDesIte + ' ' + FRefere;

  If FDicTin['unitar_sem_formatar'] = Null Then
    FDicTin['unitar_sem_formatar'] := FDicTin['unitar'];

  FPreVen := fFormataFloat(FDicTin['unitar'], FObjFat.VS_intDecUni);

  If FPreVen <= 0 Then
    Raise Exception.Create('Não foi possível retornar o preço da tinta. Verifique a formulação');


  strTabPrc := fCfgSis('TABPRC', 256, FDicTin['codemp']);


  If strTabPrc[1] = 'S' Then
    FPreVe1 := IfNull(FDicTin['preve1'], FPreVen)
  Else
    FPreVe1 := 0.0;

  If strTabPrc[2] = 'S' Then
    FPreVe2 := IfNull(FDicTin['preve2'], FPreVen)
  Else
    FPreVe2 := 0.0;

  If strTabPrc[3] = 'S' Then
    FPreVe3 := IfNull(FDicTin['preve3'], FPreVen)
  Else
    FPreVe3 := 0.0;

  If strTabPrc[4] = 'S' Then
    FPreVe4 := IfNull(FDicTin['preve4'], FPreVen)
  Else
    FPreVe4 := 0.0;

  If strTabPrc[5] = 'S' Then
    FPreVe5 := IfNull(FDicTin['preve5'], FPreVen)
  Else
    FPreVe5 := 0.0;

  If strTabPrc[6] = 'S' Then
    FPreVe6 := IfNull(FDicTin['preve6'], FPreVen)
  Else
    FPreVe6 := 0.0;

  If strTabPrc[7] = 'S' Then
    FPreVe7 := IfNull(FDicTin['preve7'], FPreVen)
  Else
    FPreVe7 := 0.0;

  FFatTin := IfNull(FDicTin['fattin'], 0.0);

  FPrcTin := IfNull(FDicTin['prctin'], 0.0);
  FPrvTin := IfNull(FDicTin['preve' + FTabPre], 0.0);

  FOutVal := IfNull(FDicTin['outval'], 0);
  FIcmSai := IfNull(FDicTin['icmsai'] / FDicTin['unitar_sem_formatar'] * 100, 0);
  FImpFed := IfNull(FDicTin['impfed'] / FDicTin['unitar_sem_formatar'] * 100, 0);
  FDesOpe := IfNull(FDicTin['desope'] / FDicTin['unitar_sem_formatar'] * 100, 0);
  FPreMed := IfNull(FDicTin['premed'], 0);
  FImpUlt := IfNull(FDicTin['impult'], 0);
  FPreUlt := IfNull(FDicTin['preult'], 0);

  FPreCus := fFormataFloat(FDicTin['precus'], FObjFat.VS_intDecUni);
  FPreCu2 := fFormataFloat(IfNull(FDicTin['precu2'], FPreCus), FObjFat.VS_intDecUni);

  FDesOpeTin := IfNull(FDicTin['desopetinta'], 0.0);
end;

procedure TConsultarPrecoTinta.pRetornarSaldoDisponivel;
begin
  FSalDis := fRetornaSaldoDisponivel(FCodIte, False, True);
end;

initialization

finalization

end.
