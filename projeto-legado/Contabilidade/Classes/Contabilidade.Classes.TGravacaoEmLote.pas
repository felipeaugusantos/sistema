unit Contabilidade.Classes.TGravacaoEmLote;

interface

uses Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.VCLUI.Wait, FireDAC.Comp.UI,
  System.Generics.Collections, Contabilidade.Model.TDadosImportacaoContabil;

type
  TGravacaoEmLote = class(TComponent)
  private
    FDatabase : String;
    FUser_Name: String;
    FPassword : String;
    FPort     : String;
    FServer   : String;
    FDriverID : String;

    FDDatabase  : TFDConnection;
    FDDriverLink: TFDPhysMySQLDriverLink;
    FDCursor    : TFDGUIxWaitCursor;
    qryLanCon   : TFDQuery;
    FqryTrnCnt   : TFDQuery;
    qryLanConDuplo          : TFDQuery;
    qryLanConDuploAutoInc   : TFDQuery;
    qryLanCnt               : TFDQuery;
    qryLanMes   : TFDQuery;
    qryLotInc   : TFDQuery;
    FqryPlaMes  : TFDQuery;
    FqryLanBal  : TFDQuery;
    FqryFecMes  : TFDQuery;
    FqryLanDet  : TFDQuery;
    FqryLogAjc  : TFDQuery;
    FdictEmpLanPrincipal : TDictionary<String, String> ;
    FblnLANDET: Boolean;
    FblnLOGAJC: Boolean;
    FblnLogAjcSondado: Boolean;  // a sondagem devolveu resposta conclusiva?

    procedure pResolverLogAjc;
    procedure pConfiguraConexao;
    procedure pAgrupaLancamentosLanCon(AList : TObjectList<TDadosImportacaoContabil>; var AListRetorno : TObjectList<TDadosImportacaoContabil>; var AListaRecriada: boolean) ;
    procedure pAgrupaLancamentosImpostosEnt(AList : TObjectList<TDadosImportacaoContabil>; var AListRetorno : TObjectList<TDadosImportacaoContabil>; var AListaRecriada: boolean) ;
    procedure pCarregaLancamentosDesmem(const AdicDados: TDadosImportacaoContabil; var AqryAutoIncLancon: TFDQuery; var AdictCtpdet: TDictionary<String,TList<String>>) ;
    procedure pGravaLancamentosDesmem(const AdictDados: TDictionary<String,TList<String>>) ;
    procedure pVendorDriverCreated(Sender: TObject);
    procedure pDefinirTimeZoneEmSessaoMySql(const AConnection : TFDConnection; const ACodigoEmpresa : String);
    function fCfgTmZoneToMySqlFormatTimeZone(const ACodigoEmpresa : String): String;
    function fTimeZoneConfigurado(const ACodigoEmpresa : String) : Integer;
  public
    constructor Create(Owner: TComponent; strDatabaseName, strUserName, strPassword, strPort, strIPServer: String); Reintroduce;
    destructor Destroy; Override;
    procedure pGravar(aList : TObjectList<TDadosImportacaoContabil>);
    procedure pGravarDuplo(AList : TObjectList<TDadosImportacaoContabil>);
    procedure pGravarLanMes(aList : TObjectList<TDadosImportacaoContabil>);
    procedure pGravarSequencialLote(aList : TObjectList<TDadosSequencialDoLote>);
    procedure pGravarPlaMes(const Alist: TObjectList<TDadosFechamentoContabilPlaMes>);
    procedure pGravarLanBal(const Alist: TObjectList<TDadosFechamentoContabilLanBal>; const AintCntDet: Integer = 0);
    procedure pGravarFecMes(const Alist: TObjectList<TDadosFechamentoContabilFecMes>);
    procedure pGravarTrnCnt(const Alist: TObjectList<TInfoPersistirTransfCnt>; const AstrContaContabilOriginal: String) ;
    procedure pGravarLogAjc(const Alist: TList<TLogAjcItem>);
    function fStartTransaction: boolean;
    function fCommit: boolean;
    function fRollBack: boolean;
    function getDataBase: TFDConnection;
    class function fCopiaItemLancamento(const AItem: TDadosImportacaoContabil):TDadosImportacaoContabil ;
  End;

implementation

uses System.SysUtils, VCL.Forms, System.StrUtils, untFuncoesSimples, Variants,
  Data.DB, Contabilidade.Funcoes, System.Types, Contabilidade.Classes.AuditoriaFireDac,
  Contabilidade.Classes.LogAjc;

{ TGravacaoEmLote }

constructor TGravacaoEmLote.Create(Owner: TComponent; strDatabaseName,
  strUserName, strPassword, strPort, strIPServer: String);
begin
  FDriverID  := 'DriverID=MySQL';
  FDatabase  := 'Database=' + strDatabaseName;
  FUser_Name := 'User_Name=' + strUserName;
  FPassword  := 'Password=' + strPassword;
  FPort      := 'Port=' + strPort;
  FServer    := 'Server=' + strIPServer;

  FDDatabase   := TFDConnection.Create(Self);
  FDDriverLink := TFDPhysMySQLDriverLink.Create(Self);
  FDDriverLink.OnDriverCreated := pVendorDriverCreated ;
  FDCursor     := TFDGUIxWaitCursor.Create(Self);
  qryLanCon := TFDQuery.Create(Self);
  qryLanMes := TFDQuery.Create(Self);
  qryLotInc := TFDQuery.Create(Self);
  FqryTrnCnt := TFDQuery.Create(Self) ;

  qryLanConDuplo         := TFDQuery.Create(Self);
  qryLanConDuploAutoInc  := TFDQuery.Create(Self);
  qryLanCnt              := TFDQuery.Create(Self);
  FqryPlaMes             := TFDQuery.Create(Self);
  FqryLanBal             := TFDQuery.Create(Self);
  FqryFecMes             := TFDQuery.Create(Self);
  FqryLanDet             := TFDQuery.Create(Self);
  FqryLogAjc             := TFDQuery.Create(Self);

  pConfiguraConexao;
  FdictEmpLanPrincipal := TDictionary<String, String>.Create();

  FblnLANDET := fTabelaExiste('LANDET');
  pResolverLogAjc;
end;

destructor TGravacaoEmLote.Destroy;
begin
  FreeAndNil(qryLanCon);
  FreeAndNil(FqryTrnCnt) ;
  FreeAndNil(qryLanConDuplo);
  FreeAndNil(qryLanConDuploAutoInc);
  FreeAndNil(qryLanCnt);
  FreeAndNil(qryLotInc);
  FreeAndNil(FqryPlaMes);
  FreeAndNil(FqryLanBal);
  FreeAndNil(FqryFecMes);
  FreeAndNil(qryLanMes);
  FreeAndNil(FqryLanDet);
  FreeandNil(FqryLogAjc);
  FDDatabase.Connected := False;
  FreeAndNil(FDCursor);
  FreeAndNil(FDDriverLink);
  FreeAndNil(FDDatabase);
  FreeAndNil(FdictEmpLanPrincipal);
  inherited;
end;

function TGravacaoEmLote.fCommit: boolean;
begin
  FDDatabase.Commit;
  Result := True;
end;

class function TGravacaoEmLote.fCopiaItemLancamento(
  const AItem: TDadosImportacaoContabil): TDadosImportacaoContabil;
begin
  Result := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp) ;
  Result.strCtpInc := AItem.strCtpInc;
  Result.strCodigoEmpresa := AItem.strCodigoEmpresa;
  Result.dtaLancamento := AItem.dtaLancamento;
  Result.strTipoLancamento := AItem.strTipoLancamento;
  Result.strCfopConfig := AItem.strCfopConfig;
  Result.strNaturezaOperacao := AItem.strNaturezaOperacao;
  Result.strDescricaoValor := AItem.strDescricaoValor;
  Result.strContaCredito := AItem.strContaCredito;
  Result.strContaDebito := AItem.strContaDebito;
  Result.intCodigoHistoricoPadrao := AItem.intCodigoHistoricoPadrao;
  Result.strHistorico := AItem.strHistorico;
  Result.fltValorLancamento := AItem.fltValorLancamento;
  Result.intAutomatico := AItem.intAutomatico;
  Result.strCCusto := AItem.strCCusto;
  Result.strCCustoCredito := AItem.strCCustoCredito;
  Result.strTabela := AItem.strTabela;
  Result.strCodigoOperador := AItem.strCodigoOperador;
  Result.strCliFor := AItem.strCliFor;
  Result.strTip_fc := AItem.strTip_fc;
  Result.strVersaoSistema := AItem.strVersaoSistema;
  Result.strIncDocAg := AItem.strIncDocAg;
  Result.strForPgo := AItem.strForPgo;
  Result.strCodigoEmpDesmem := AItem.strCodigoEmpDesmem;
  Result.strSeqPar := AItem.strSeqPar;
  Result.strInvNco := AItem.strInvNco;
  Result.strTpOriD := AItem.strTpOriD;
  Result.strCdOriD := AItem.strCdOriD;
  Result.strOpBcDb := AItem.strOpBcDb;
  Result.strNumDoc := AItem.strNumDoc;
  Result.strTpOriC := AItem.strTpOriC;
  Result.strCdOriC := AItem.strCdOriC;
  Result.strOpBcCr := AItem.strOpBcCr;
end;

function TGravacaoEmLote.getDataBase: TFDConnection;
begin
  Result := FDDatabase;
end;

function TGravacaoEmLote.fRollBack: boolean;
begin
  FDDatabase.Rollback;
  Result := True;
end;

function TGravacaoEmLote.fStartTransaction: boolean;
begin
  FDDatabase.StartTransaction;
  Result := True;
end;

procedure TGravacaoEmLote.pGravar(aList : TObjectList<TDadosImportacaoContabil>);
  var
    intCnt : Integer;
    blnParamTabelaExiste : boolean;
    blnParamCCuscr : boolean ;
    blnParamPagame : boolean ;
    blnParamVerSis : boolean ;
    blnParamEmpLog : boolean ;
    blnParamForPgo : boolean ;
    LList, LList1 : TObjectList<TDadosImportacaoContabil> ;
    LListaRecriadaAgpLancon, LListaRecriadaAgpImpEnt : boolean ;

    blnParamCliFor : boolean ;
    blnParamTip_fc : boolean ;
    blnParamSeqPar: Boolean;
    blnParamInvNco: Boolean;
    blnParamTpOriD: Boolean;
    blnParamCdOriD: Boolean;
    blnParamOpBcDb: Boolean;
    blnParamNumDoc: Boolean;
    blnParamTpOriC: Boolean;
    blnParamCdOriC: Boolean;
    blnParamOpBcCr: Boolean;
begin
  if aList.Count = 0 then
    exit;

  pContraPartidaAgrupadaNoDesmembramentoValores(aList) ;

  blnParamTabelaExiste := Assigned(qryLanCon.FindParam('TABELA'));
  blnParamCCuscr := Assigned(qryLanCon.FindParam('CCUSCR'));
  blnParamPagame := Assigned(qryLanCon.FindParam('PAGAME'));
  blnParamVerSis := Assigned(qryLanCon.FindParam('VERSIS'));
  blnParamEmpLog := Assigned(qryLanCon.FindParam('EMPLOG'));
  blnParamForPgo := Assigned(qryLanCon.FindParam('FORPGO'));

  blnParamCliFor := Assigned(qryLanCon.FindParam('CLIFOR'));
  blnParamTip_fc := Assigned(qryLanCon.FindParam('TIP_FC'));

  blnParamSeqPar := Assigned(qryLanCon.FindParam('SEQPAR'));
  blnParamInvNco := Assigned(qryLanCon.FindParam('INVNCO'));

  blnParamTpOriD := Assigned(qryLanCon.FindParam('TPORID'));
  blnParamCdOriD := Assigned(qryLanCon.FindParam('CDORID'));
  blnParamOpBcDb := Assigned(qryLanCon.FindParam('OPBCDB'));
  blnParamNumDoc := Assigned(qryLanCon.FindParam('NUMDOC'));

  blnParamTpOriC := Assigned(qryLanCon.FindParam('TPORIC'));
  blnParamCdOriC := Assigned(qryLanCon.FindParam('CDORIC'));
  blnParamOpBcCr := Assigned(qryLanCon.FindParam('OPBCCR'));

  pAgrupaLancamentosImpostosEnt(aList, LList1, LListaRecriadaAgpImpEnt);
  pAgrupaLancamentosLanCon(LList1, LList, LListaRecriadaAgpLancon) ;

  qryLanCon.Params.ClearValues();
  qryLanCon.Params.ArraySize := LList.Count;

  qryLanCon.ParamByName('CONCRE').DataType := ftString;
  qryLanCon.ParamByName('EMPRESA').DataType := ftString;
  qryLanCon.ParamByName('DTALAN').DataType := ftdatetime;
  qryLanCon.ParamByName('TIPOLAN').DataType := ftString;
  qryLanCon.ParamByName('CFOP').DataType := ftString;
  qryLanCon.ParamByName('NATOPE').DataType := ftString;
  qryLanCon.ParamByName('DESVAL').DataType := ftString;
  qryLanCon.ParamByName('CONCRE').DataType := ftString;
  qryLanCon.ParamByName('CONDEB').DataType := ftString;
  qryLanCon.ParamByName('HISPAD').DataType := ftInteger;
  qryLanCon.ParamByName('HISTOR').DataType := ftString;
  qryLanCon.ParamByName('VALLAN').DataType := ftFloat;
  qryLanCon.ParamByName('AUTOMA').DataType := ftInteger;
  qryLanCon.ParamByName('CCUSTO').DataType := ftString;
  if blnParamCCuscr then
    qryLanCon.ParamByName('CCUSCR').DataType := ftString;
  qryLanCon.ParamByName('CODOPE').DataType := ftString;
  qryLanCon.ParamByName('INCDOC').DataType := ftString;

  if blnParamTabelaExiste then
    qryLanCon.ParamByName('TABELA').DataType := ftString;

  if blnParamPagame then
    qryLanCon.ParamByName('PAGAME').DataType := ftString;

  if blnParamVerSis then
    qryLanCon.ParamByName('VERSIS').DataType := ftString;

  if blnParamEmpLog then
    qryLanCon.ParamByName('EMPLOG').DataType := ftString;

  if blnParamForPgo then
    qryLanCon.ParamByName('FORPGO').DataType := ftString;

  if blnParamCliFor then
    qryLanCon.ParamByName('CLIFOR').DataType := ftString;

  if blnParamTip_fc then
    qryLanCon.ParamByName('TIP_FC').DataType := ftString;

  if blnParamSeqPar then
    qryLanCon.ParamByName('SEQPAR').DataType := ftString;

  if blnParamInvNco then
    qryLanCon.ParamByName('INVNCO').DataType := ftString;

  if blnParamTpOriC then
    qryLanCon.ParamByName('TPORIC').DataType := ftString;

  if blnParamCdOriC then
    qryLanCon.ParamByName('CDORIC').DataType := ftString;

  if blnParamOpBcCr then
    qryLanCon.ParamByName('OPBCCR').DataType := ftString;

  if blnParamTpOriD then
    qryLanCon.ParamByName('TPORID').DataType := ftString;

  if blnParamCdOriD then
    qryLanCon.ParamByName('CDORID').DataType := ftString;

  if blnParamOpBcDb then
    qryLanCon.ParamByName('OPBCDB').DataType := ftString;

  if blnParamNumDoc then
    qryLanCon.ParamByName('NUMDOC').DataType := ftString;

  for intCnt := 0 to Pred(LList.Count) do
  begin
    qryLanCon.ParamByName('INCDOC').AsStrings[intCnt] := LList[intCnt].strCtpInc;
    qryLanCon.ParamByName('EMPRESA').AsStrings[intCnt] := LList[intCnt].strCodigoEmpresa;
    qryLanCon.ParamByName('DTALAN').AsDateTimes[intCnt] := LList[intCnt].dtaLancamento;
    qryLanCon.ParamByName('TIPOLAN').AsStrings[intCnt] := LList[intCnt].strTipoLancamento;
    qryLanCon.ParamByName('CFOP').AsStrings[intCnt] := LList[intCnt].strCfopConfig;

    if not fEmptyStr(LList[intCnt].strNaturezaOperacao) then
      qryLanCon.ParamByName('NATOPE').AsStrings[intCnt] := LList[intCnt].strNaturezaOperacao;

    qryLanCon.ParamByName('DESVAL').AsStrings[intCnt] := LList[intCnt].strDescricaoValor;

    if not fEmptyStr(LList[intCnt].strContaCredito) then
      qryLanCon.ParamByName('CONCRE').AsStrings[intCnt] := LList[intCnt].strContaCredito;

    if not fEmptyStr(LList[intCnt].strContaDebito) then
      qryLanCon.ParamByName('CONDEB').AsStrings[intCnt] := LList[intCnt].strContaDebito;

    if (LList[intCnt].intCodigoHistoricoPadrao > 0) then
      qryLanCon.ParamByName('HISPAD').AsIntegers[intCnt] := LList[intCnt].intCodigoHistoricoPadrao;

    qryLanCon.ParamByName('HISTOR').AsStrings[intCnt] := LList[intCnt].strHistorico;
    qryLanCon.ParamByName('VALLAN').AsFloats[intCnt] := LList[intCnt].fltValorLancamento;
    qryLanCon.ParamByName('AUTOMA').AsIntegers[intCnt] := LList[intCnt].intAutomatico;

    if not fEmptyStr(LList[intCnt].strCCusto) then
      qryLanCon.ParamByName('CCUSTO').AsStrings[intCnt] := LList[intCnt].strCCusto;

    if blnParamCCuscr then
      if not fEmptyStr(LList[intCnt].strCCustoCredito) then
        qryLanCon.ParamByName('CCUSCR').AsStrings[intCnt] := LList[intCnt].strCCustoCredito;

    if not fEmptyStr(LList[intCnt].strCodigoOperador) then
      qryLanCon.ParamByName('CODOPE').AsStrings[intCnt] := LList[intCnt].strCodigoOperador;

    if blnParamTabelaExiste then
      qryLanCon.ParamByName('TABELA').AsStrings[intCnt] := LList[intCnt].strTabela;

    if blnParamPagame then
      qryLanCon.ParamByName('PAGAME').AsStrings[intCnt] := LList[intCnt].strPagamento;

    if blnParamVerSis then
      qryLanCon.ParamByName('VERSIS').AsStrings[intCnt] := LList[intCnt].strVersaoSistema;

    if blnParamEmpLog then
      qryLanCon.ParamByName('EMPLOG').AsStrings[intCnt] := LList[intCnt].strCodEmpLogada;

    if blnParamForPgo then
      qryLanCon.ParamByName('FORPGO').AsStrings[intCnt] := LList[intCnt].strForPgo;

    if blnParamCliFor then
      qryLanCon.ParamByName('CLIFOR').AsStrings[intCnt] := LList[intCnt].strCliFor;

    if blnParamTip_fc then
      qryLanCon.ParamByName('TIP_FC').AsStrings[intCnt] := LList[intCnt].strTip_fc;

    if blnParamSeqPar then
      qryLanCon.ParamByName('SEQPAR').AsStrings[intCnt] := LList[intCnt].strSeqPar;

    if blnParamInvNco then
      qryLanCon.ParamByName('INVNCO').AsStrings[intCnt] := LList[intCnt].strInvNco;

    if blnParamTpOriC then
      qryLanCon.ParamByName('TPORIC').AsStrings[intCnt] := LList[intCnt].strTpOriC;

    if blnParamCdOriC then
      qryLanCon.ParamByName('CDORIC').AsStrings[intCnt] := LList[intCnt].strCdOriC;

    if blnParamOpBcCr then
      qryLanCon.ParamByName('OPBCCR').AsStrings[intCnt] := LList[intCnt].strOpBcCr;

    if blnParamTpOriD then
      qryLanCon.ParamByName('TPORID').AsStrings[intCnt] := LList[intCnt].strTpOriD;

    if blnParamCdOriD then
      qryLanCon.ParamByName('CDORID').AsStrings[intCnt] := LList[intCnt].strCdOriD;

    if blnParamOpBcDb then
      qryLanCon.ParamByName('OPBCDB').AsStrings[intCnt] := LList[intCnt].strOpBcDb;

    if blnParamNumDoc then
      qryLanCon.ParamByName('NUMDOC').AsStrings[intCnt] := LList[intCnt].strNumDoc;
  end;

  qryLanCon.Execute(LList.Count, 0);

  if LListaRecriadaAgpImpEnt then
    FreeAndNil(LList1) ;

  if LListaRecriadaAgpLancon then
    FreeAndNil(LList) ;
end;

procedure TGravacaoEmLote.pGravarDuplo(
  AList: TObjectList<TDadosImportacaoContabil>);
var
  intCnt : Integer;
  blnParamTabelaExiste : boolean;
  blnParamCCuscr : boolean ;
  blnParamPagame : boolean ;
  blnParamVerSis : boolean ;
  blnParamEmpLog : boolean ;
  blnParamForPgo : boolean ;
  LList: TObjectList<TDadosImportacaoContabil> ;
  LListaRecriadaAgpImpEnt : boolean ;
  LdictEmpresaDesmem: TDictionary<String,TList<String>> ;
  LqryAutoInc: TFDQuery ;
  blnParamCliFor : boolean ;
  blnParamTip_Fc : boolean ;
  blnParamSeqPar : boolean ;
  blnParamInvNco : boolean ;
  blnParamTpOriD : boolean ;
  blnParamCdOriD : boolean ;
  blnParamOpBcDb : boolean ;
  blnParamNumDoc : Boolean;
  blnParamTpOriC : boolean ;
  blnParamCdOriC : boolean ;
  blnParamOpBcCr : boolean ;
begin
  if aList.Count = 0 then
    exit;

  pContraPartidaAgrupadaNoDesmembramentoValores(aList) ;

  LqryAutoInc := TFDQuery.Create(Nil);
  LdictEmpresaDesmem := TDictionary<String,TList<String>>.Create();
  try
    LqryAutoInc.Connection := FDDatabase;
    LqryAutoInc.Close ;
    LqryAutoInc.SQL.Clear ;
    LqryAutoInc.SQL.Add('SELECT LAST_INSERT_ID() ') ;

    qryLanConDuplo.Close ;
    blnParamTabelaExiste := Assigned(qryLanConDuplo.FindParam('TABELA'));
    blnParamCCuscr := Assigned(qryLanConDuplo.FindParam('CCUSCR'));
    blnParamPagame := Assigned(qryLanConDuplo.FindParam('PAGAME'));
    blnParamVerSis := Assigned(qryLanConDuplo.FindParam('VERSIS'));
    blnParamEmpLog := Assigned(qryLanConDuplo.FindParam('EMPLOG'));
    blnParamForPgo := Assigned(qryLanConDuplo.FindParam('FORPGO'));
    blnParamCliFor := Assigned(qryLanConDuplo.FindParam('CLIFOR'));
    blnParamTip_Fc := Assigned(qryLanConDuplo.FindParam('TIP_FC'));
    blnParamSeqPar := Assigned(qryLanConDuplo.FindParam('SEQPAR'));
    blnParamInvNco := Assigned(qryLanConDuplo.FindParam('INVNCO'));
    blnParamTpOriD := Assigned(qryLanConDuplo.FindParam('TPORID'));
    blnParamCdOriD := Assigned(qryLanConDuplo.FindParam('CDORID'));
    blnParamOpBcDb := Assigned(qryLanConDuplo.FindParam('OPBCDB'));
    blnParamNumDoc := Assigned(qryLanConDuplo.FindParam('NUMDOC'));
    blnParamTpOriC := Assigned(qryLanConDuplo.FindParam('TPORIC'));
    blnParamCdOriC := Assigned(qryLanConDuplo.FindParam('CDORIC'));
    blnParamOpBcCr := Assigned(qryLanConDuplo.FindParam('OPBCCR'));

    pAgrupaLancamentosImpostosEnt(aList, LList, LListaRecriadaAgpImpEnt);

    qryLanConDuplo.ParamByName('CONCRE').DataType := ftString;
    qryLanConDuplo.ParamByName('EMPRESA').DataType := ftString;
    qryLanConDuplo.ParamByName('DTALAN').DataType := ftdatetime;
    qryLanConDuplo.ParamByName('TIPOLAN').DataType := ftString;
    qryLanConDuplo.ParamByName('CFOP').DataType := ftString;
    qryLanConDuplo.ParamByName('NATOPE').DataType := ftString;
    qryLanConDuplo.ParamByName('DESVAL').DataType := ftString;
    qryLanConDuplo.ParamByName('CONCRE').DataType := ftString;
    qryLanConDuplo.ParamByName('CONDEB').DataType := ftString;
    qryLanConDuplo.ParamByName('HISPAD').DataType := ftInteger;
    qryLanConDuplo.ParamByName('HISTOR').DataType := ftString;
    qryLanConDuplo.ParamByName('VALLAN').DataType := ftFloat;
    qryLanConDuplo.ParamByName('AUTOMA').DataType := ftInteger;
    qryLanConDuplo.ParamByName('CCUSTO').DataType := ftString;
    if blnParamCCuscr then
      qryLanConDuplo.ParamByName('CCUSCR').DataType := ftString;
    qryLanConDuplo.ParamByName('CODOPE').DataType := ftString;
    qryLanConDuplo.ParamByName('INCDOC').DataType := ftString;

    if blnParamTabelaExiste then
      qryLanConDuplo.ParamByName('TABELA').DataType := ftString;

    if blnParamPagame then
      qryLanConDuplo.ParamByName('PAGAME').DataType := ftString;

    if blnParamVerSis then
      qryLanConDuplo.ParamByName('VERSIS').DataType := ftString;

    if blnParamEmpLog then
      qryLanConDuplo.ParamByName('EMPLOG').DataType := ftString;

    if blnParamForPgo then
      qryLanConDuplo.ParamByName('FORPGO').DataType := ftString;

    if blnParamCliFor then
      qryLanConDuplo.ParamByName('CLIFOR').DataType := ftString;

    if blnParamTip_Fc then
      qryLanConDuplo.ParamByName('TIP_FC').DataType := ftString;

    if blnParamSeqPar then
      qryLanConDuplo.ParamByName('SEQPAR').DataType := ftString;

    if blnParamInvNco then
      qryLanConDuplo.ParamByName('INVNCO').DataType := ftString;

    if blnParamTpOriC then
      qryLanConDuplo.ParamByName('TPORIC').DataType := ftString;

    if blnParamCdOriC then
      qryLanConDuplo.ParamByName('CDORIC').DataType := ftString;

    if blnParamOpBcCr then
      qryLanConDuplo.ParamByName('OPBCCR').DataType := ftString;

    if blnParamNumDoc then
      qryLanConDuplo.ParamByName('NUMDOC').DataType := ftString;

    if blnParamTpOriD then
      qryLanConDuplo.ParamByName('TPORID').DataType := ftString;

    if blnParamCdOriD then
      qryLanConDuplo.ParamByName('CDORID').DataType := ftString;

    if blnParamOpBcDb then
      qryLanConDuplo.ParamByName('OPBCDB').DataType := ftString;

    for intCnt := 0 to Pred(LList.Count) do
    begin

      qryLanConDuplo.ParamByName('INCDOC').AsString := LList[intCnt].strCtpInc;
      qryLanConDuplo.ParamByName('EMPRESA').AsString := LList[intCnt].strCodigoEmpDesmem;
      qryLanConDuplo.ParamByName('DTALAN').AsDateTime := LList[intCnt].dtaLancamento;
      qryLanConDuplo.ParamByName('TIPOLAN').AsString := LList[intCnt].strTipoLancamento;
      qryLanConDuplo.ParamByName('CFOP').AsString := LList[intCnt].strCfopConfig;

      qryLanConDuplo.ParamByName('NATOPE').Value := null ;
      if not fEmptyStr(LList[intCnt].strNaturezaOperacao) then
        qryLanConDuplo.ParamByName('NATOPE').AsString := LList[intCnt].strNaturezaOperacao;

      qryLanConDuplo.ParamByName('DESVAL').AsString := LList[intCnt].strDescricaoValor;

      qryLanConDuplo.ParamByName('CONCRE').Value := null ;
      if not fEmptyStr(LList[intCnt].strContaCredito) then
        qryLanConDuplo.ParamByName('CONCRE').AsString := LList[intCnt].strContaCredito;

      qryLanConDuplo.ParamByName('CONDEB').Value := null ;
      if not fEmptyStr(LList[intCnt].strContaDebito) then
        qryLanConDuplo.ParamByName('CONDEB').AsString := LList[intCnt].strContaDebito;

      qryLanConDuplo.ParamByName('HISPAD').Value := null ;
      if (LList[intCnt].intCodigoHistoricoPadrao > 0) then
        qryLanConDuplo.ParamByName('HISPAD').AsInteger := LList[intCnt].intCodigoHistoricoPadrao;

      qryLanConDuplo.ParamByName('HISTOR').AsString := LList[intCnt].strHistorico;
      qryLanConDuplo.ParamByName('VALLAN').AsFloat := LList[intCnt].fltValorLancamento;
      qryLanConDuplo.ParamByName('AUTOMA').AsInteger := LList[intCnt].intAutomatico;

      qryLanConDuplo.ParamByName('CCUSTO').Clear();
      if not fEmptyStr(LList[intCnt].strCCusto) then
        qryLanConDuplo.ParamByName('CCUSTO').AsString := LList[intCnt].strCCusto;

      if blnParamCCuscr then
      begin
        qryLanConDuplo.ParamByName('CCUSCR').Clear();
        if not fEmptyStr(LList[intCnt].strCCustoCredito) then
          qryLanConDuplo.ParamByName('CCUSCR').AsString := LList[intCnt].strCCustoCredito;
      end ;

      if not fEmptyStr(LList[intCnt].strCodigoOperador) then
        qryLanConDuplo.ParamByName('CODOPE').AsString := LList[intCnt].strCodigoOperador;

      if blnParamTabelaExiste then
        qryLanConDuplo.ParamByName('TABELA').AsString := LList[intCnt].strTabela;

      if blnParamPagame then
        qryLanConDuplo.ParamByName('PAGAME').AsString := LList[intCnt].strPagamento;

      if blnParamVerSis then
        qryLanConDuplo.ParamByName('VERSIS').AsString := LList[intCnt].strVersaoSistema;

      if blnParamEmpLog then
        qryLanConDuplo.ParamByName('EMPLOG').AsString := LList[intCnt].strCodEmpLogada;

      if blnParamForPgo then
        qryLanConDuplo.ParamByName('FORPGO').AsString := LList[intCnt].strForPgo;

      if blnParamCliFor then
        qryLanConDuplo.ParamByName('CLIFOR').AsString := LList[intCnt].strCliFor;

      if blnParamTip_Fc then
        qryLanConDuplo.ParamByName('TIP_FC').AsString := LList[intCnt].strTip_fc;

      if blnParamSeqPar then
        qryLanConDuplo.ParamByName('SEQPAR').AsString := LList[intCnt].strSeqPar;

      if blnParamInvNco then
        qryLanConDuplo.ParamByName('INVNCO').AsString := LList[intCnt].strInvNco;

      if blnParamTpOriC then
        qryLanConDuplo.ParamByName('TPORIC').AsString := LList[intCnt].strTpOriC;

      if blnParamCdOriC then
        qryLanConDuplo.ParamByName('CDORIC').AsString := LList[intCnt].strCdOriC;

      if blnParamOpBcCr then
        qryLanConDuplo.ParamByName('OPBCCR').AsString := LList[intCnt].strOpBcCr;

      if blnParamTpOriD then
        qryLanConDuplo.ParamByName('TPORID').AsString := LList[intCnt].strTpOriD;

      if blnParamCdOriD then
        qryLanConDuplo.ParamByName('CDORID').AsString := LList[intCnt].strCdOriD;

      if blnParamOpBcDb then
        qryLanConDuplo.ParamByName('OPBCDB').AsString := LList[intCnt].strOpBcDb;

      if blnParamNumDoc then
        qryLanConDuplo.ParamByName('NUMDOC').AsString := LList[intCnt].strNumDoc;

      qryLanConDuplo.ExecSQL;

      pCarregaLancamentosDesmem(LList[intCnt], LqryAutoInc, LdictEmpresaDesmem) ;

    end;

    if LdictEmpresaDesmem.Count > 0 then
    begin
      pGravaLancamentosDesmem(LdictEmpresaDesmem) ;
    end;

  finally
    if LListaRecriadaAgpImpEnt then
      FreeAndNil(LList);

    FreeAndNil(LqryAutoInc) ;
    LdictEmpresaDesmem.Clear ;
    FreeAndNil(LdictEmpresaDesmem) ;
  end;

end;

procedure TGravacaoEmLote.pVendorDriverCreated(Sender: TObject);
begin
  TAuditoriaFireDac.pRegistraVendor(Sender);
end ;

procedure TGravacaoEmLote.pGravaLancamentosDesmem(const AdictDados: TDictionary<String,TList<String>>) ;
var
  LpairItem: TPair<String,TList<String>> ;
  LarrItem: string ;
  LstrOrigem, LstrControle: string ;
  LarrSplit: TStringDynArray ;
  LqryExec: TFDQuery ;
  LblnFlag: boolean ;
  LstrEmpOri: String ;
begin

  LqryExec := TFDQuery.Create(Nil) ;
  try
    LqryExec.Connection := FDDatabase;
    LqryExec.Close ;
    LqryExec.SQL.Add('INSERT INTO LANCNT (CNT_ORIGEM, CNT_CONTRO, CNT_EMPORI) VALUES (:ORIGEM, :CONTRO, :EMPORI);') ;

    for LpairItem in AdictDados do
    begin
      ///separa o autoinc de origem
      LstrOrigem := '' ;
      LstrEmpOri := '' ;
      for LArrItem in LpairItem.Value do
      begin
        if copy(LArrItem,1,3) = copy(LpairItem.Key,1,3) then
        begin
          LarrSplit := SplitString(LArrItem, ';') ;
          LstrOrigem := LarrSplit[1] ;
          break ;
        end;
      end;
      ///lança o controle com os registros dependentes
      for LArrItem in LpairItem.Value do
      begin
        if copy(LArrItem,1,3) <> copy(LpairItem.Key,1,3) then
        begin
          LblnFlag := False ;
          LarrSplit := SplitString(LArrItem, ';') ;
          LstrControle := LarrSplit[1] ;
          if fEmptyStr(LstrOrigem) then
          begin
            LstrEmpOri := copy(LpairItem.Key,1,3) ;
            LstrOrigem := LstrControle ;
            LblnFlag := True ;
          end;
          LqryExec.Close ;
          LqryExec.ParamByName('ORIGEM').AsLargeInt := StrToInt64(LstrOrigem) ;
          LqryExec.ParamByName('CONTRO').AsLargeInt := StrToInt64(LstrControle) ;
          LqryExec.ParamByName('EMPORI').AsString := LstrEmpOri ;
          LqryExec.ExecSQL ;
          if LblnFlag then
          begin
            LstrOrigem := '' ;
            LstrEmpOri := '' ;
          end;
        end;
      end;

    end;
  finally
    FreeAndNil(LqryExec) ;
  end;

end;

procedure TGravacaoEmLote.pCarregaLancamentosDesmem(const AdicDados: TDadosImportacaoContabil; var AqryAutoIncLancon: TFDQuery; var AdictCtpdet: TDictionary<String,TList<String>>) ;
var
  LstrAutoInc: string ;
  LstrChave: string ;
  LstrValor: string ;
  LlstAutoInc: TList<String> ;
  LstrEmpChave: string ;
  LstrEmpValor: string ;
  LstrIncDoc: string ;
begin
  AqryAutoIncLancon.Close ;
  AqryAutoIncLancon.Open ;
  LstrIncDoc := ifThen(fEmptyStr(AdicDados.strIncDocAg), AdicDados.strCtpInc, AdicDados.strIncDocAg) ;
  if not FdictEmpLanPrincipal.ContainsKey(LstrIncDoc) then
    FdictEmpLanPrincipal.Add(LstrIncDoc, AdicDados.strCodigoEmpresa);

  LstrEmpChave := FdictEmpLanPrincipal.Items[LstrIncDoc] ;
  LstrEmpValor := AdicDados.strCodigoEmpDesmem ;

  LstrAutoInc := AqryAutoIncLancon.Fields.Fields[0].AsString ;
  LstrChave := LstrEmpChave + ';' + LstrIncDoc ;
  LstrValor := LstrEmpValor + ';' + LstrAutoInc ;
  if not AdictCtpdet.ContainsKey(LstrChave) then
  begin
    LlstAutoInc := TList<String>.Create ;
    LlstAutoInc.Add(LstrValor) ;
    AdictCtpdet.Add(LstrChave, LlstAutoInc);
  end
  else
  begin
    LlstAutoInc := AdictCtpdet.Items[LstrChave] ;
    LlstAutoInc.Add(LstrValor) ;
  end;
end;

procedure TGravacaoEmLote.pGravarLanMes(
  aList: TObjectList<TDadosImportacaoContabil>);
  var
    intCnt : Integer;
begin
  if (aList.Count = 0) then
    exit;

  qryLanMes.Params.ClearValues();
  qryLanMes.Params.ArraySize := aList.Count;

  qryLanMes.ParamByName('EMPLAN').DataType := ftString;
  qryLanMes.ParamByName('DTALAN').DataType := ftdatetime;
  qryLanMes.ParamByName('TIPLAN').DataType := ftString;
  qryLanMes.ParamByName('CLAFIS').DataType := ftString;
  qryLanMes.ParamByName('NATOPE').DataType := ftString;
  qryLanMes.ParamByName('DESVAL').DataType := ftString;
  qryLanMes.ParamByName('CONCRE').DataType := ftString;
  qryLanMes.ParamByName('CONDEB').DataType := ftString;
  qryLanMes.ParamByName('HISPAD').DataType := ftInteger;
  qryLanMes.ParamByName('HISTOR').DataType := ftString;
  qryLanMes.ParamByName('VALLAN').DataType := ftFloat;
  qryLanMes.ParamByName('AUTOMA').DataType := ftInteger;
  qryLanMes.ParamByName('CODOPE').DataType := ftString;
  qryLanMes.ParamByName('CCUSTO').DataType := ftString;
  qryLanMes.ParamByName('INCDOC').DataType := ftString;

  for intCnt := 0 to Pred(aList.Count) do
  begin
    qryLanMes.ParamByName('EMPLAN').AsStrings[intCnt] := aList[intCnt].strCodigoEmpresa;
    qryLanMes.ParamByName('DTALAN').AsDateTimes[intCnt] := aList[intCnt].dtaLancamento;
    qryLanMes.ParamByName('TIPLAN').AsStrings[intCnt] := aList[intCnt].strTipoLancamento;
    qryLanMes.ParamByName('CLAFIS').AsStrings[intCnt] := aList[intCnt].strCfopConfig;

    if not fEmptyStr(aList[intCnt].strNaturezaOperacao) then
      qryLanMes.ParamByName('NATOPE').AsStrings[intCnt] := aList[intCnt].strNaturezaOperacao;

    qryLanMes.ParamByName('DESVAL').AsStrings[intCnt] := aList[intCnt].strDescricaoValor;

    if not fEmptyStr(aList[intCnt].strContaCredito) then
      qryLanMes.ParamByName('CONCRE').AsStrings[intCnt] := aList[intCnt].strContaCredito;

    if not fEmptyStr(aList[intCnt].strContaDebito) then
      qryLanMes.ParamByName('CONDEB').AsStrings[intCnt] := aList[intCnt].strContaDebito;

    if (aList[intCnt].intCodigoHistoricoPadrao <> -1) then
      qryLanMes.ParamByName('HISPAD').AsIntegers[intCnt] := aList[intCnt].intCodigoHistoricoPadrao;

    qryLanMes.ParamByName('HISTOR').AsStrings[intCnt] := aList[intCnt].strHistorico;
    qryLanMes.ParamByName('VALLAN').AsFloats[intCnt] := aList[intCnt].fltValorLancamento;
    qryLanMes.ParamByName('AUTOMA').AsIntegers[intCnt] := aList[intCnt].intAutomatico;

    if not fEmptyStr(aList[intCnt].strCodigoOperador) then
      qryLanMes.ParamByName('CODOPE').AsStrings[intCnt] := aList[intCnt].strCodigoOperador;

    if not fEmptyStr(aList[intCnt].strCCusto) then
      qryLanMes.ParamByName('CCUSTO').AsStrings[intCnt] := aList[intCnt].strCCusto;

    qryLanMes.ParamByName('INCDOC').AsStrings[intCnt] := aList[intCnt].strCtpInc;
  end;

  qryLanMes.Execute(aList.Count, 0);
end;

procedure TGravacaoEmLote.pGravarSequencialLote(
  aList: TObjectList<TDadosSequencialDoLote>);
  var
    intCnt : Integer;
begin
  if aList.Count = 0 then
    exit;

  qryLotInc.Params.ClearValues();
  qryLotInc.Params.ArraySize := aList.Count;

  qryLotInc.ParamByName('INCDOC').DataType := ftString;
  qryLotInc.ParamByName('TIPLAN').DataType := ftString;
  qryLotInc.ParamByName('COMPET').DataType := ftString;
  qryLotInc.ParamByName('EMPLAN').DataType := ftString;
  qryLotInc.ParamByName('DTALAN').DataType := ftDateTime;
  qryLotInc.ParamByName('AUTOMA').DataType := ftInteger;
  qryLotInc.ParamByName('SEQUEN').DataType := ftInteger;

  for intCnt := 0 to Pred(aList.Count) do
  begin
    qryLotInc.ParamByName('INCDOC').AsStrings[intCnt] := aList[intCnt].strIncDoc;
    qryLotInc.ParamByName('TIPLAN').AsStrings[intCnt] := aList[intCnt].strTipLan;
    qryLotInc.ParamByName('COMPET').AsStrings[intCnt] := aList[intCnt].strCompet;
    qryLotInc.ParamByName('EMPLAN').AsStrings[intCnt] := aList[intCnt].strEmpLan;
    qryLotInc.ParamByName('DTALAN').AsDateTimes[intCnt] := aList[intCnt].dtaDtaLan;
    qryLotInc.ParamByName('AUTOMA').AsIntegers[intCnt] := aList[intCnt].intAutoma;
    qryLotInc.ParamByName('SEQUEN').AsIntegers[intCnt] := aList[intCnt].intSequen;
  end;

  qryLotInc.Execute(aList.Count, 0);
end;

procedure TGravacaoEmLote.pGravarPlaMes(const Alist: TObjectList<TDadosFechamentoContabilPlaMes>);
var
  LintCnt: integer ;
  LblnParamCreDeb: Boolean ;
begin
  if AList.Count = 0 then
    exit;

  LblnParamCreDeb := Assigned(FqryPlaMes.FindParam('CREDEB'));

  FqryPlaMes.Params.ClearValues();
  FqryPlaMes.Params.ArraySize := AList.Count;

  FqryPlaMes.ParamByName('CODCON').DataType := ftString;
  FqryPlaMes.ParamByName('SALINI').DataType := ftFloat;
  FqryPlaMes.ParamByName('CODEMP').DataType := ftString;
  FqryPlaMes.ParamByName('DTASAL').DataType := ftDateTime;
  FqryPlaMes.ParamByName('CCUSTO').DataType := ftString;
  if LblnParamCreDeb then
    FqryPlaMes.ParamByName('CREDEB').DataType := ftString;

  for LintCnt := 0 to Pred(AList.Count) do
  begin
    FqryPlaMes.ParamByName('CODCON').AsStrings[LintCnt] := AList[LintCnt].CodCon ;
    FqryPlaMes.ParamByName('SALINI').AsFloats[LintCnt] := AList[LintCnt].SalIni ;
    FqryPlaMes.ParamByName('CODEMP').AsStrings[LintCnt] := AList[LintCnt].CodEmp ;
    FqryPlaMes.ParamByName('DTASAL').AsDateTimes[LintCnt] := AList[LintCnt].DtaSal ;
    if not fEmptyStr(AList[LintCnt].CCusto) then
      FqryPlaMes.ParamByName('CCUSTO').AsStrings[LintCnt] := AList[LintCnt].CCusto ;
    if LblnParamCreDeb then
      FqryPlaMes.ParamByName('CREDEB').AsStrings[LintCnt] := AList[LintCnt].CreDeb ;
  end ;

  FqryPlaMes.Execute(aList.Count, 0);
end ;

procedure TGravacaoEmLote.pGravarLanBal(const Alist: TObjectList<TDadosFechamentoContabilLanBal>; const AintCntDet: Integer = 0);
var
  LblnParamCRDEAN: Boolean;
  LblnParamCRDEFI: Boolean;
  LintIdx, LintIdxDet: integer ;
  LLanDet: TPairLanDet;
  LblnGravaLanDet: Boolean;
begin
  if AList.Count = 0 then
    exit;

  LblnParamCRDEAN := Assigned(FqryLanBal.FindParam('CRDEAN'));
  LblnParamCRDEFI := Assigned(FqryLanBal.FindParam('CRDEFI'));

  FqryLanBal.Params.ClearValues();
  FqryLanBal.Params.ArraySize := AList.Count;
  FqryLanBal.ParamByName('DTAMOV').DataType := ftDateTime;
  FqryLanBal.ParamByName('CODCON').DataType := ftString;
  FqryLanBal.ParamByName('SALANT').DataType := ftFloat;
  FqryLanBal.ParamByName('DEBITO').DataType := ftFloat;
  FqryLanBal.ParamByName('CREDIT').DataType := ftFloat;
  FqryLanBal.ParamByName('SALFIN').DataType := ftFloat;
  FqryLanBal.ParamByName('CODEMP').DataType := ftString;
  FqryLanBal.ParamByName('CCUSTO').DataType := ftString;
  if LblnParamCRDEAN then
    FqryLanBal.ParamByName('CRDEAN').DataType := ftString;
  if LblnParamCRDEFI then
    FqryLanBal.ParamByName('CRDEFI').DataType := ftString;

  LblnGravaLanDet := False;
  if FblnLANDET and (AintCntDet > 0) then
  begin
     LblnGravaLanDet := True;

    FqryLanDet.Params.ClearValues();
    FqryLanDet.Params.ArraySize := AintCntDet;
    FqryLanDet.ParamByName('DTAMOV').DataType := ftDateTime;
    FqryLanDet.ParamByName('CODCON').DataType := ftString;
    FqryLanDet.ParamByName('CCUSTO').DataType := ftString;
    FqryLanDet.ParamByName('CODEMP').DataType := ftString;
    FqryLanDet.ParamByName('EMPDET').DataType := ftString;
    FqryLanDet.ParamByName('SALFIN').DataType := ftFloat;
    FqryLanDet.ParamByName('SALANT').DataType := ftFloat;
    FqryLanDet.ParamByName('CRDEFI').DataType := ftString;
    FqryLanDet.ParamByName('CRDEAN').DataType := ftString;
    FqryLanDet.ParamByName('CREDIT').DataType := ftFloat;
    FqryLanDet.ParamByName('DEBITO').DataType := ftFloat;
  end;

  LintIdxDet := 0;
  for LintIdx := 0 to Pred(AList.Count) do
  begin
    FqryLanBal.ParamByName('DTAMOV').AsDateTimes[LintIdx] := AList[LintIdx].DtaMov ;
    FqryLanBal.ParamByName('CODCON').AsStrings[LintIdx] := AList[LintIdx].CodCon ;
    FqryLanBal.ParamByName('SALANT').AsFloats[LintIdx] := AList[LintIdx].SalAnt ;
    FqryLanBal.ParamByName('DEBITO').AsFloats[LintIdx] := AList[LintIdx].Debito ;
    FqryLanBal.ParamByName('CREDIT').AsFloats[LintIdx] := AList[LintIdx].Credit ;
    FqryLanBal.ParamByName('SALFIN').AsFloats[LintIdx] := AList[LintIdx].SalFin ;
    FqryLanBal.ParamByName('CODEMP').AsStrings[LintIdx] := AList[LintIdx].CodEmp ;
    if not fEmptyStr(AList[LintIdx].CCusto) then
      FqryLanBal.ParamByName('CCUSTO').AsStrings[LintIdx] := AList[LintIdx].CCusto ;
    if LblnParamCRDEAN then
      FqryLanBal.ParamByName('CRDEAN').AsStrings[LintIdx] := AList[LintIdx].CrDeAn ;
    if LblnParamCRDEFI then
      FqryLanBal.ParamByName('CRDEFI').AsStrings[LintIdx] := AList[LintIdx].CrDeFi ;

    if LblnGravaLanDet and (AList[LintIdx].LanDet.Count > 0) then
    begin
      for LLanDet in AList[LintIdx].LanDet do
      begin
        if (Succ(LintIdxDet) > AintCntDet) then
        begin
          LblnGravaLanDet := False;
          FqryLanDet.Params.ClearValues();
          FqryLanDet.Params.ArraySize := 0;
          break;
        end;

        FqryLanDet.ParamByName('DTAMOV').AsDateTimes[LintIdxDet] := AList[LintIdx].DtaMov ;
        FqryLanDet.ParamByName('CODCON').AsStrings[LintIdxDet]   := AList[LintIdx].CodCon ;
        if not fEmptyStr(AList[LintIdx].CCusto) then
          FqryLanDet.ParamByName('CCUSTO').AsStrings[LintIdxDet] := AList[LintIdx].CCusto ;
        FqryLanDet.ParamByName('CODEMP').AsStrings[LintIdxDet]   := AList[LintIdx].CodEmp ;
        FqryLanDet.ParamByName('EMPDET').AsStrings[LintIdxDet]   := LLanDet.Key ;
        FqryLanDet.ParamByName('SALFIN').AsFloats[LintIdxDet]    := LLanDet.Value.SalFin;
        FqryLanDet.ParamByName('SALANT').AsFloats[LintIdxDet]    := LLanDet.Value.SalAnt;
        FqryLanDet.ParamByName('CRDEFI').AsStrings[LintIdxDet]   := LLanDet.Value.CrDeFi;
        FqryLanDet.ParamByName('CRDEAN').AsStrings[LintIdxDet]   := LLanDet.Value.CrDeAn;
        FqryLanDet.ParamByName('CREDIT').AsFloats[LintIdxDet]    := LLanDet.Value.Credit;
        FqryLanDet.ParamByName('DEBITO').AsFloats[LintIdxDet]    := LLanDet.Value.Debito;

        Inc(LintIdxDet);
      end;
    end;
  end ;
  FqryLanBal.Execute(aList.Count, 0);
  if LblnGravaLanDet and (FqryLanDet.Params.ArraySize > 0) then
    FqryLanDet.Execute(FqryLanDet.Params.ArraySize, 0);
end ;

procedure TGravacaoEmLote.pGravarFecMes(const Alist: TObjectList<TDadosFechamentoContabilFecMes>);
var
  LintCnt: integer ;
begin
  if AList.Count = 0 then
    exit;

  FqryFecMes.Params.ClearValues();
  FqryFecMes.Params.ArraySize := AList.Count;

  FqryFecMes.ParamByName('CODOPE').DataType := ftString;
  FqryFecMes.ParamByName('DTAFEC').DataType := ftDateTime;
  FqryFecMes.ParamByName('MESDTA').DataType := ftDateTime;
  FqryFecMes.ParamByName('CODEMP').DataType := ftString;
  FqryFecMes.ParamByName('EMPGRV').DataType := ftString;

  for LintCnt := 0 to Pred(AList.Count) do
  begin
    FqryFecMes.ParamByName('CODOPE').AsStrings[LintCnt] := AList[LintCnt].CodOpe ;
    FqryFecMes.ParamByName('DTAFEC').AsDateTimes[LintCnt] := AList[LintCnt].DtaFec ;
    FqryFecMes.ParamByName('MESDTA').AsDateTimes[LintCnt] := AList[LintCnt].MesDta ;
    FqryFecMes.ParamByName('CODEMP').AsStrings[LintCnt] := AList[LintCnt].CodEmp ;
    FqryFecMes.ParamByName('EMPGRV').AsStrings[LintCnt] := AList[LintCnt].EmpGrv ;
  end ;
  FqryFecMes.Execute(aList.Count, 0);

end ;

procedure TGravacaoEmLote.pGravarTrnCnt(const Alist: TObjectList<TInfoPersistirTransfCnt>;
                                        const AstrContaContabilOriginal: String) ;
var
  LintCnt: Integer ;
  LlstCredito: TObjectList<TInfoPersistirTransfCnt> ;
  LlstDebito: TObjectList<TInfoPersistirTransfCnt> ;
  LItem, LItemAdd: TInfoPersistirTransfCnt ;
begin
  if AList.Count = 0 then
    exit;

  FqryTrnCnt.Params.ClearValues();
  FqryTrnCnt.Params.ArraySize := AList.Count;
  FqryTrnCnt.ParamByName('CNTORI').DataType := ftString;
  FqryTrnCnt.ParamByName('CNTNOV').DataType := ftString;
  FqryTrnCnt.ParamByName('CREDEB').DataType := ftString;
  FqryTrnCnt.ParamByName('CODOPE').DataType := ftString;
  FqryTrnCnt.ParamByName('DTATRN').DataType := ftDate;
  FqryTrnCnt.ParamByName('HRATRN').DataType := ftString;
  FqryTrnCnt.ParamByName('LANCON').DataType := ftLargeint;

  for LintCnt := 0 to Pred(AList.Count) do
  begin
    FqryTrnCnt.ParamByName('CNTORI').AsStrings[LintCnt]   := AstrContaContabilOriginal ;
    FqryTrnCnt.ParamByName('CNTNOV').AsStrings[LintCnt]   := AList[LintCnt].ContaContabil ;
    FqryTrnCnt.ParamByName('CREDEB').AsStrings[LintCnt]   := AList[LintCnt].CreDeb ;
    FqryTrnCnt.ParamByName('CODOPE').AsStrings[LintCnt]   := AList[LintCnt].CodOpe ;
    FqryTrnCnt.ParamByName('DTATRN').AsDates[LintCnt]     := AList[LintCnt].DtaTrn ;
    FqryTrnCnt.ParamByName('HRATRN').AsStrings[LintCnt]   := AList[LintCnt].HraTrn ;
    FqryTrnCnt.ParamByName('LANCON').AsLargeInts[LintCnt] := AList[LintCnt].Lancon ;
  end ;
  FqryTrnCnt.Execute(aList.Count, 0);

  LlstCredito := TObjectList<TInfoPersistirTransfCnt>.Create ;
  LlstDebito  := TObjectList<TInfoPersistirTransfCnt>.Create ;
  try
    for LItem in AList do
    begin
      if LItem.CreDeb = 'D' then
      begin
        LItemAdd := TInfoPersistirTransfCnt.Create ;
        LItemAdd.ContaContabil := LItem.ContaContabil ;
        LItemAdd.Lancon := LItem.Lancon ;
        LlstDebito.Add(LItemAdd) ;
      end
      else if LItem.CreDeb = 'C' then
      begin
        LItemAdd := TInfoPersistirTransfCnt.Create ;
        LItemAdd.ContaContabil := LItem.ContaContabil ;
        LItemAdd.Lancon := LItem.Lancon ;
        LlstCredito.Add(LItemAdd) ;
      end ;
    end ;

    if LlstDebito.Count > 0 then
    begin
      FqryTrnCnt.Close ;
      FqryTrnCnt.SQL.Clear ;
      FqryTrnCnt.SQL.Text := fGetSqlUpdateLanconTrnCntDebito ;

      FqryTrnCnt.Params.ClearValues();
      FqryTrnCnt.Params.ArraySize := LlstDebito.Count;
      FqryTrnCnt.ParamByName('CONDEB').DataType :=     ftString;
      FqryTrnCnt.ParamByName('AUTOINCREM').DataType := ftLargeint;

      for LintCnt := 0 to Pred(LlstDebito.Count) do
      begin
        FqryTrnCnt.ParamByName('CONDEB').AsStrings[LintCnt]       := LlstDebito[LintCnt].ContaContabil ;
        FqryTrnCnt.ParamByName('AUTOINCREM').AsLargeInts[LintCnt] := LlstDebito[LintCnt].Lancon ;
      end ;
      FqryTrnCnt.Execute(LlstDebito.Count, 0);
    end ;

    if LlstCredito.Count > 0 then
    begin
      FqryTrnCnt.Close ;
      FqryTrnCnt.SQL.Clear ;
      FqryTrnCnt.SQL.Text := fGetSqlUpdateLanconTrnCntCredito ;

      FqryTrnCnt.Params.ClearValues();
      FqryTrnCnt.Params.ArraySize := LlstCredito.Count;
      FqryTrnCnt.ParamByName('CONCRE').DataType :=     ftString;
      FqryTrnCnt.ParamByName('AUTOINCREM').DataType := ftLargeint;

      for LintCnt := 0 to Pred(LlstCredito.Count) do
      begin
        FqryTrnCnt.ParamByName('CONCRE').AsStrings[LintCnt]       := LlstCredito[LintCnt].ContaContabil ;
        FqryTrnCnt.ParamByName('AUTOINCREM').AsLargeInts[LintCnt] := LlstCredito[LintCnt].Lancon ;
      end ;
      FqryTrnCnt.Execute(LlstCredito.Count, 0);
    end ;

  finally
    FreeAndNil(LlstCredito) ;
    FreeAndNil(LlstDebito) ;
  end ;

end ;

procedure TGravacaoEmLote.pGravarLogAjc(const Alist: TList<TLogAjcItem>);
var
  LintCnt: integer ;
begin
  if not FblnLogAjcSondado then
    pResolverLogAjc;

  if not FblnLOGAJC then
    exit;

  if AList.Count = 0 then
    exit;

  FqryLogAjc.Params.ClearValues();
  FqryLogAjc.Params.ArraySize := AList.Count;

  FqryLogAjc.ParamByName('CODEMP').DataType := ftString;
  FqryLogAjc.ParamByName('DTAALT').DataType := ftDate;
  FqryLogAjc.ParamByName('HRAALT').DataType := ftTime;
  FqryLogAjc.ParamByName('CODOPE').DataType := ftString;
  FqryLogAjc.ParamByName('TABELA').DataType := ftString;
  FqryLogAjc.ParamByName('INCDOC').DataType := ftString;
  FqryLogAjc.ParamByName('TIPAJU').DataType := ftString;
  FqryLogAjc.ParamByName('COLUNA').DataType := ftString;
  FqryLogAjc.ParamByName('VALANT').DataType := ftString;
  FqryLogAjc.ParamByName('VALATU').DataType := ftString;
  FqryLogAjc.ParamByName('NOMFRM').DataType := ftString;
  FqryLogAjc.ParamByName('SEQAJU').DataType := ftString;

  for LintCnt := 0 to Pred(AList.Count) do
  begin
    FqryLogAjc.ParamByName('CODEMP').AsStrings[LintCnt] := Copy(AList[LintCnt].CodEmp, 1, 3);
    FqryLogAjc.ParamByName('DTAALT').AsDates[LintCnt]   := AList[LintCnt].DtaAlt;
    FqryLogAjc.ParamByName('HRAALT').AsTimes[LintCnt]   := AList[LintCnt].HraAlt;
    FqryLogAjc.ParamByName('CODOPE').AsStrings[LintCnt] := Copy(AList[LintCnt].CodOpe, 1, 3);

    FqryLogAjc.ParamByName('TABELA').AsStrings[LintCnt] := Copy(AList[LintCnt].Tabela, 1, 10);
    FqryLogAjc.ParamByName('INCDOC').AsStrings[LintCnt] := Copy(AList[LintCnt].Incdoc, 1, CTamMaxIncDoc);
    FqryLogAjc.ParamByName('TIPAJU').AsStrings[LintCnt] := Copy(AList[LintCnt].Tipaju, 1, 3);
    FqryLogAjc.ParamByName('COLUNA').AsStrings[LintCnt] := Copy(AList[LintCnt].Coluna, 1, 30);

    if AList[LintCnt].ValAnt <> '' then
      FqryLogAjc.ParamByName('VALANT').AsStrings[LintCnt] := Copy(AList[LintCnt].ValAnt, 1, CTamMaxValor);

    if AList[LintCnt].ValAtu <> '' then
      FqryLogAjc.ParamByName('VALATU').AsStrings[LintCnt] := Copy(AList[LintCnt].ValAtu, 1, CTamMaxValor);

    if AList[LintCnt].NomFrm <> '' then
      FqryLogAjc.ParamByName('NOMFRM').AsStrings[LintCnt] := Copy(AList[LintCnt].NomFrm, 1, 60);

    if AList[LintCnt].SeqAju <> '' then
     FqryLogAjc.ParamByName('SEQAJU').AsStrings[LintCnt] := Copy(AList[LintCnt].SeqAju, 1, 36);
  end ;
  FqryLogAjc.Execute(aList.Count, 0);
end;

procedure TGravacaoEmLote.pAgrupaLancamentosLanCon(
  AList : TObjectList<TDadosImportacaoContabil>;
  var AListRetorno : TObjectList<TDadosImportacaoContabil>;
  var AListaRecriada: boolean);
var
  strChave : string ;
  LItem : TDadosImportacaoContabil ;
  LList : TObjectList<TDadosImportacaoContabil> ;
  LstControle : TStringList ;
  LstDuplicado : TStringList ;
  LItemAux : TDadosImportacaoContabil ;
  LDictAgrupar : TDictionary<string,TDadosImportacaoContabil> ;
  blnListaRecriada : boolean ;
begin
  blnListaRecriada := False ;
  LList := aList ;
  ///verifica o primeiro item da lista
  if fPodeAgruparLancamentos(aList[0].strTipoLancamento, fCfgAgrLan = 'S') then
  begin
    LstControle := TStringList.Create ;
    LstDuplicado := TStringList.Create ;
    LDictAgrupar := TDictionary<string,TDadosImportacaoContabil>.Create ;
    try
      LstControle.Sorted := True ;
      LstDuplicado.Sorted := True ;
      for LItem in aList do
      begin
        strChave := fRetornaChaveAgrupaLancamentos(LItem) ;
        if LstControle.IndexOf(strChave) = -1 then
        begin
          LstControle.Add(strChave) ;
        end
        else
        begin
          if LstDuplicado.IndexOf(strChave) = -1 then
          begin
            LstDuplicado.Add(strChave) ;
          end ;
        end;
      end;

      if LstDuplicado.Count > 0 then
      begin
        LList := TObjectList<TDadosImportacaoContabil>.Create ;
        blnListaRecriada := True ;
        for LItem in aList do
        begin
          strChave := fRetornaChaveAgrupaLancamentos(LItem) ;

          if LstDuplicado.IndexOf(strChave) = -1 then
          begin
            LItemAux := fCopiaItemLancamento(LItem) ;
            LList.Add(LItemAux) ;
          end
          else
          begin
            ////controla o somatorio com o dict e depois adiciona na lista principal
            if not LDictAgrupar.ContainsKey(strChave) then
            begin
              LItemAux := fCopiaItemLancamento(LItem) ;
              LItemAux.strCfopConfig := '';
              LDictAgrupar.Add(strChave, LItemAux);
            end
            else
            begin
              ////soma o valor
              LItemAux := LDictAgrupar.Items[strChave] ;
              LItemAux.fltValorLancamento := LItemAux.fltValorLancamento + LItem.fltValorLancamento ;
            end;
          end;
        end;
        ///inclui na lista os valores agrupados
        for LItemAux in LDictAgrupar.Values do
        begin
          LList.Add(LItemAux) ;
        end;
        ///
      end;
    finally
      FreeAndNil(LstControle) ;
      FreeAndNil(LstDuplicado) ;
      FreeAndNil(LDictAgrupar) ;
    end;
  end;

  AListRetorno := LList ;
  AListaRecriada := blnListaRecriada ;
end;

procedure TGravacaoEmLote.pAgrupaLancamentosImpostosEnt(AList : TObjectList<TDadosImportacaoContabil>; var AListRetorno : TObjectList<TDadosImportacaoContabil>; var AListaRecriada: boolean) ;
var
  LstrChave : string ;
  LItem, LItemAux : TDadosImportacaoContabil ;
  LlstControleUnico, LlstControleAgrupar : TStringList ;
  LblnImpAgr: Boolean;
  LdicAgrupar : TDictionary<string, TDadosImportacaoContabil> ;
begin
  AListRetorno := AList ;
  AListaRecriada := False ;

  if AList.Count = 0 then
    Exit;

  if AList.First.strTipoLancamento <> 'ENT' then
    Exit;

  LblnImpAgr := fCfgImpAgr;

  if not LblnImpAgr then
    Exit;

  LlstControleUnico := TStringList.Create;
  LlstControleAgrupar := TStringList.Create;
  LdicAgrupar := TDictionary<string, TDadosImportacaoContabil>.Create ;
  try
    LlstControleUnico.Sorted := True;
    LlstControleAgrupar.Sorted := True;

    for LItem in AList do
    begin
      LstrChave := fRetornaChaveImpAgr(LItem) ;
      if fPodeAgruparLancamentoImpAgr(LItem, LblnImpAgr) and (LlstControleUnico.IndexOf(LstrChave) <> -1) then
      begin
        if (LlstControleAgrupar.IndexOf(LstrChave) = -1) then
          LlstControleAgrupar.Add(LstrChave);
      end
      else
        LlstControleUnico.Add(LstrChave);
    end;

    if LlstControleAgrupar.Count = 0 then
      Exit;

    AListRetorno := TObjectList<TDadosImportacaoContabil>.Create ;
    AListaRecriada := True;

    for LItem in AList do
    begin
      LstrChave := fRetornaChaveImpAgr(LItem) ;

      //adiciona na lista itens sem agrupamento
      if LlstControleAgrupar.IndexOf(LstrChave) = -1 then
      begin
        LItemAux := fCopiaItemLancamento(LItem) ;
        AListRetorno.Add(LItemAux);
      end

      //itens do agrupamento, segundo em diante
      else if LdicAgrupar.ContainsKey(LstrChave) then
      begin
        LItemAux := LdicAgrupar.Items[LstrChave] ;
        LItemAux.fltValorLancamento := LItemAux.fltValorLancamento + LItem.fltValorLancamento ;
      end

      //primeiro item do agrupamento
      else
      begin
        LItemAux := fCopiaItemLancamento(LItem) ;
        LdicAgrupar.Add(LstrChave, LItemAux);
      end;

    end;

    //adiciona na lista itens agrupados
    for LItemAux in LdicAgrupar.Values do
      AListRetorno.Add(LItemAux) ;

  finally
    FreeAndNil(LlstControleUnico);
    FreeAndNil(LlstControleAgrupar);
    FreeAndNil(LdicAgrupar);
  end;
end;

//procedure TGravacaoEmLote.OnExecuteError(ASender: TObject; ATimes,
//  AOffset: Integer; AError: EFDDBEngineException; var AAction: TFDErrorAction);
//begin
//end;

procedure TGravacaoEmLote.pResolverLogAjc;
  Var
    Lsonda: TSondaTabela;
begin
  { Sondagem no FDDatabase: e ele que grava a LOGAJC. Antes usava fTabelaExiste sem
    conexao, que caia na conexao UniDAC corrente -- perguntava num banco e gravava em
    outro. }
  Lsonda := fSondarTabelaContabil('LOGAJC', FDDatabase);

  { staFalhou nao e resposta. Guardar uma falha transitoria faria o lote inteiro deixar
    de auditar em silencio ate o objeto ser recriado; por isso o par de flags permite
    tentar de novo na primeira gravacao. }
  FblnLogAjcSondado := (Lsonda <> staFalhou);
  FblnLOGAJC        := (Lsonda = staExiste);
end;

procedure TGravacaoEmLote.pConfiguraConexao;
begin
  FDDatabase.Params.Add(FDatabase);
  FDDatabase.Params.Add(FUser_Name);
  FDDatabase.Params.Add(FPassword);
  FDDatabase.Params.Add(FPort);
  FDDatabase.Params.Add(FServer);
  FDDatabase.Params.Add(FDriverID);

  if FileExists(ExtractFilePath(Application.ExeName) + 'libmysql57.dll') then
    FDDriverLink.VendorLib := ExtractFilePath(Application.ExeName) + 'libmysql57.dll'
  else
    FDDriverLink.VendorLib := ExtractFilePath(Application.ExeName) + 'libmysql41.dll';

  FDDatabase.Connected := True;

  pDefinirTimeZoneEmSessaoMySql(FDDatabase, VS_strCodEmp);

  qryLanCon.Connection := FDDatabase;
  qryLanCon.SQL.text := fGetSqlInsertLanCon;

  FqryTrnCnt.Connection := FDDatabase ;
  FqryTrnCnt.Close ;
  FqryTrnCnt.SQL.Clear ;
  FqryTrnCnt.SQL.Text := fGetSqlInsertTrnCnt ;


  qryLanConDuplo.Connection := FDDatabase;
  qryLanConDuplo.SQL.text := fGetSqlInsertLanCon;

  qryLanConDuploAutoInc.Connection := FDDatabase;
  qryLanConDuploAutoInc.SQL.text := fGetSqlLastAutoIncLanCon ;

  qryLanCnt.Connection := FDDatabase;
  qryLanCnt.SQL.Text := fGetSqlInsertLanCnt ;

  qryLotInc.Connection := FDDatabase;
  qryLotInc.SQL.Text := fGetSqlInsertLotInc;

  FqryPlaMes.Connection := FDDatabase;
  FqryPlaMes.SQL.Text := fGetSqlInsertPlaMes ;

  FqryLanBal.Connection := FDDatabase;
  FqryLanBal.SQL.Text := fGetSqlInsertLanBal ;

  FqryFecMes.Connection := FDDatabase;
  FqryFecMes.SQL.Text := fGetSqlinsertFecMes ;

  qryLanMes.Connection := FDDatabase;
  qryLanMes.SQL.text := fGetSqlInsertLanMes;

  FqryLanDet.Connection := FDDatabase;
  FqryLanDet.SQL.Text := fGetSqlInsertLanDet;

  FqryLogAjc.Connection := FDDatabase;
  FqryLogAjc.SQL.Text := fGetSQLInsertLogAjc;
end;

procedure TGravacaoEmLote.pDefinirTimeZoneEmSessaoMySql(const AConnection : TFDConnection; const ACodigoEmpresa : String);
  Var
    LQryTimeZone : TFDQuery;
    LUsaTimeZone : String;
begin
  If ACodigoEmpresa.IsEmpty Then
    Exit;
  If (Not fConfiguracaoExiste('USATMZ', ACodigoEmpresa)) Then
    Exit;
  LUsaTimeZone := fCfgSis('USATMZ', varString, ACodigoEmpresa);
  If (LUsaTimeZone.IsEmpty) Or (LUsaTimeZone = 'N') Then
    Exit;
  LQryTimeZone := TFDQuery.Create(Self);
  Try
    LQryTimeZone.Connection := AConnection;
    LQryTimeZone.SQL.Text := Format('SET time_zone = %s;', [QuotedStr(fCfgTmZoneToMySqlFormatTimeZone(ACodigoEmpresa))]);
    LQryTimeZone.ExecSQL;
  Finally
    FreeAndNil(LQryTimeZone);
  End;
end;

function TGravacaoEmLote.fCfgTmZoneToMySqlFormatTimeZone(const ACodigoEmpresa : String): String;
  Const
    arrTimeZonesPemrmitidos : Array [1..4] Of Integer = (-2, -3, -4, -5);
  Var
    LTimeZoneConfigurado : Integer;
    LContador : Integer;
begin
  Result := '-3:00';
  If ACodigoEmpresa.IsEmpty Then
    Exit;
  LTimeZoneConfigurado := fTimeZoneConfigurado(ACodigoEmpresa);
  If LTimeZoneConfigurado = 0 Then
    Exit;
  For LContador := Low(arrTimeZonesPemrmitidos) To High(arrTimeZonesPemrmitidos) Do
  Begin
    If (arrTimeZonesPemrmitidos[LContador] = LTimeZoneConfigurado) Then
    Begin
      Result := Format('%d:00', [LTimeZoneConfigurado]);
      Exit;
    End;
  End;
end;

function TGravacaoEmLote.fTimeZoneConfigurado(const ACodigoEmpresa : String) : Integer;
  Var
    LTimeZone : String;
begin
  Result := 0;

  If (Not fConfiguracaoExiste('TMZONE', ACodigoEmpresa)) Then
    Exit;

  LTimeZone := fCfgSis('TMZONE', varString, ACodigoEmpresa);

  If (LTimeZone.IsEmpty) Then
    Exit;

  Result := StrToIntDef(LTimeZone, 0);
end;

end.
