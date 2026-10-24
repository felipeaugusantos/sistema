unit untTFecFinRepository;

interface

uses untTFecFin, Aurelius.Criteria.Base, System.Generics.Collections, System.SysUtils,
  Aurelius.Criteria.Linq, untObjectManager, untFieldFiltros, Classes, Aurelius.Types.Nullable;

Type
  TFiltros = class sealed
  Public
    CodigoEmpresa    : TFieldFiltros<String>;
    DataReferenciada : TFieldFiltros<TDateTime>;

    Constructor Create;
  End;

  TFecFinRepository = class
  Private
    blnCriouObj: Boolean;

    function fExecuta(Filter: TFiltros): TFecFin;
    function fFiltrar<E: class>(Filter: TFiltros): TCriteria;
    procedure pGravaDel(AFechamentoFinanceiro : TFecFin);
    procedure pGravarLog(AFechamentoFinanceiro : TFecFin; ADescricao, ANomeFormulario : String);
  public
    Constructor Create;
    Destructor Destroy; Override;

    procedure pDeletar(AFechamentoFinanceiro : TFecFin; ANomeFormulario : String);
    procedure pInserir(AFechamentoFinanceiro : TFecFin; ANomeFormulario : String);
    function fGetFechamentoFinanceiro(ACodigoEmpresa: String; ADataReferenciada : TDate): TFecFin;
    function fRetornaFechamento(ACodigoEmp: String; ADataRef: TDateTime): TFecFin;
  end;

implementation

uses untFuncoesSimples,
     untDelRepository,
     untUtilRepository;

{ TFiltros }

constructor TFiltros.Create;
begin
  CodigoEmpresa    := '';
  DataReferenciada := 0;
end;

{ TFecFinRepository }

constructor TFecFinRepository.Create;
begin
  blnCriouObj := False;
  frwk := fCriaObjManager(blnCriouObj);
end;

destructor TFecFinRepository.Destroy;
begin
  If blnCriouObj Then
    FreeAndNil(frwk);
  inherited;
end;

function TFecFinRepository.fExecuta(Filter: TFiltros): TFecFin;
Var
  lstFecFin: TList<TFecFin>;
begin
  lstFecFin := fFiltrar<TFecFin>(Filter).List<TFecFin>;

  If (Not Assigned(lstFecFin)) Or (lstFecFin.Count <= 0) Then
    Result := Nil
  Else
    Result := lstFecFin[0];
end;

function TFecFinRepository.fFiltrar<E>(Filter: TFiltros): TCriteria;
Var SCriteria: TCriteria;
begin
  SCriteria := frwk.objDBManager.CreateCriteria<E>;

  If Not fEmptyStr(Filter.CodigoEmpresa.Value) Then
    SCriteria.Add(TLinq.Eq('FCodigoEmpresa', Filter.CodigoEmpresa));

  If Filter.DataReferenciada.Value > 0 Then
    SCriteria.Add(TLinq.Eq('FDataReferenciada', Filter.DataReferenciada));

  Result := SCriteria;
end;

function TFecFinRepository.fGetFechamentoFinanceiro(ACodigoEmpresa: String; ADataReferenciada : TDate): TFecFin;
Var SFilter: TFiltros;
begin
  SFilter := TFiltros.Create;
  Try
    SFilter.CodigoEmpresa    := ACodigoEmpresa;
    SFilter.DataReferenciada := ADataReferenciada;
    Result := fExecuta(SFilter);
  Finally
    FreeAndNil(SFilter);
  End;
end;

function TFecFinRepository.fRetornaFechamento(ACodigoEmp: String; ADataRef: TDateTime): TFecFin;
Var
  Filter: TFiltros;
begin
  Filter := TFiltros.Create;
  Filter.CodigoEmpresa    := ACodigoEmp;
  Filter.DataReferenciada := ADataRef;

  Result := fExecuta(Filter);
  FreeAndNil(Filter);
end;

procedure TFecFinRepository.pDeletar(AFechamentoFinanceiro: TFecFin; ANomeFormulario : String);
begin
  Try
    pGravaDel(AFechamentoFinanceiro);
    pGravarLog(AFechamentoFinanceiro, 'EXCLUSÃO', ANomeFormulario);

    frwk.objDBManager.Remove(AFechamentoFinanceiro);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

procedure TFecFinRepository.pGravaDel(AFechamentoFinanceiro: TFecFin);
var
  objDel: TDelFecFin;
Begin
  objDel := TDelFecFin.Create;

  TUtil.pClone(AFechamentoFinanceiro, objDel);
  TGravaDel.pGrava(objDel, frwk);
end;

procedure TFecFinRepository.pGravarLog(AFechamentoFinanceiro: TFecFin; ADescricao, ANomeFormulario: String);
Var SLog: TLogFin;
begin
  SLog := TLogFin.Create;
  TUtil.pClone(AFechamentoFinanceiro, SLog);
  SLog.AutoIncremento := fRetAutoIncrem('LOGFIN', AFechamentoFinanceiro.CodigoEmpresa);
  SLog.DataLog        := VS_Date;
  SLog.HoraLog        := fTime();
  SLog.OperadorLog    := strLoginUsuarioLogado;
  SLog.NomeTabela     := TUtil.fRetTableName(AFechamentoFinanceiro);
  SLog.Descricao      := ADescricao;
  SLog.NomeFormulario := ANomeFormulario;
  frwk.objDBManager.Save(SLog);
end;

procedure TFecFinRepository.pInserir(AFechamentoFinanceiro: TFecFin; ANomeFormulario : String);
begin
  Try
    frwk.objDBManager.Save(AFechamentoFinanceiro);
    pGravarLog(AFechamentoFinanceiro,'INCLUSAO', ANomeFormulario);
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create('Ocorreu um erro ao inserir Fechamento Financeiro. ' + #13 + 'Erro gerado: ' + E.Message);
    End;
  End;
end;

end.
