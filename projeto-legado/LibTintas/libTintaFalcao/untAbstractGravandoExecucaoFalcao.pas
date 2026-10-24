{***********************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta FALcolor *}
{********************************************************************************PH*}
unit untAbstractGravandoExecucaoFalcao;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB, Math, untIConfTinta;

type
  TAbstractGravandoExecucaoFalcao = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    sprDados: TADOStoredProc;
    conOrigem: TADOConnection;
    
    qryGrupos: TADODataSet;
    dsGrupos: TDataSource;
    qryProdutos: TADODataSet;
    dsProdutos: TDataSource;
    qryBases: TADODataSet;
    dsBases: TDataSource;
    qryTipos: TADODataSet;
    dsTipos: TDataSource;
    qryProdutosBasesEmbalagens: TADODataSet;
    dsProdutosBasesEmbalagens: TDataSource;
    qryEmbalagens: TADODataSet;
    dsEmbalagens: TDataSource;
    qryColorantes: TADODataSet;
    dsColorantes: TDataSource;
    qryCores: TADODataSet;
    dsCores: TDataSource;
    qryCoresColorantes: TADODataSet;
    dsCoresColorantes: TDataSource;
    qryMensagens: TADODataSet;
    dsMensagens: TDataSource;
    qryMensagensCoresBasesEmbalagens: TADODataSet;
    dsMensagensCoresBasesEmbalagens: TDataSource;
    conf: IConfTinta;

    function GetDados(): TADOStoredProc;
    function GetConexaoOrigem(): TADOConnection;
    function GetAdoDataSet(): TADODataSet;
    function GetDataSource(const qryGen: TDataSet): TDataSource;
    procedure CarregarDados;
    function GetUnidade(const fltVolume: Double): string;
    function fFormataAutInc(const intAutInc: Integer): String;
    function fValidaPath : Boolean;
    function GetPath : String;

  public
    constructor Create();
    destructor Destroy; override;
    function fGetNomeGravacao: string; virtual; abstract;
    procedure Executar(const gravando: IGravando); virtual; abstract;
    function fHabilitaOpcao(): Boolean; Virtual;
  end;

  TDataSetHelper = class helper for TDataSet
  public
    procedure Filtar(const strFiltro: string);
  end;


implementation

uses
  untAutcomTintaFactory, untStrUtils;

{ TGravandoExecucaoFalcaoCores }

procedure TAbstractGravandoExecucaoFalcao.CarregarDados;
var
  intRecordsAffected: Integer;
begin
  qryGrupos                        := GetAdoDataSet;
  dsGrupos                         := GetDataSource(qryGrupos);
  qryProdutos                      := GetAdoDataSet;
  dsProdutos                       := GetDataSource(qryProdutos);
  qryBases                         := GetAdoDataSet;
  dsBases                          := GetDataSource(qryBases);
  qryTipos                         := GetAdoDataSet;
  dsTipos                          := GetDataSource(qryTipos);
  qryProdutosBasesEmbalagens       := GetAdoDataSet;
  dsProdutosBasesEmbalagens        := GetDataSource(qryProdutosBasesEmbalagens);
  qryEmbalagens                    := GetAdoDataSet;
  dsEmbalagens                     := GetDataSource(qryEmbalagens);
  qryColorantes                    := GetAdoDataSet;
  dsColorantes                     := GetDataSource(qryColorantes);
  qryCores                         := GetAdoDataSet;
  dsCores                          := GetDataSource(qryCores);
  qryCoresColorantes               := GetAdoDataSet;
  dsCoresColorantes                := GetDataSource(qryCoresColorantes);
  qryMensagens                     := GetAdoDataSet;
  dsMensagens                      := GetDataSource(qryMensagens);
  qryMensagensCoresBasesEmbalagens := GetAdoDataSet;
  dsMensagensCoresBasesEmbalagens  := GetDataSource(qryMensagensCoresBasesEmbalagens);

  GetDados.Close;
  GetDados.Open;
  qryGrupos.Recordset                        := GetDados.Recordset;
  qryProdutos.Recordset                      := GetDados.NextRecordset(intRecordsAffected);
  qryBases.Recordset                         := GetDados.NextRecordset(intRecordsAffected);
  qryTipos.Recordset                         := GetDados.NextRecordset(intRecordsAffected);
  qryProdutosBasesEmbalagens.Recordset       := GetDados.NextRecordset(intRecordsAffected);
  qryEmbalagens.Recordset                    := GetDados.NextRecordset(intRecordsAffected);
  qryColorantes.Recordset                    := GetDados.NextRecordset(intRecordsAffected);
  qryCores.Recordset                         := GetDados.NextRecordset(intRecordsAffected);
  qryCoresColorantes.Recordset               := GetDados.NextRecordset(intRecordsAffected);
  qryMensagens.Recordset                     := GetDados.NextRecordset(intRecordsAffected);
  qryMensagensCoresBasesEmbalagens.Recordset := GetDados.NextRecordset(intRecordsAffected);
end;

constructor TAbstractGravandoExecucaoFalcao.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('FAL');

  sprDados           := nil;
  conOrigem          := nil;
  qryGrupos          := nil;
  dsGrupos           := nil;
  qryProdutos        := nil;
  dsProdutos         := nil;
  qryBases           := nil;
  dsBases            := nil;
  qryTipos           := nil;
  dsTipos            := nil;
  qryCoresColorantes := nil;
  dsCoresColorantes  := nil;
  qryMensagens       := nil;
  dsMensagens        := nil;
  qryEmbalagens      := nil;
  dsEmbalagens       := nil;
  qryColorantes      := nil;
  dsColorantes       := nil;
  qryCores           := nil;
  dsCores            := nil;

  qryProdutosBasesEmbalagens       := nil;
  dsProdutosBasesEmbalagens        := nil;
  qryMensagensCoresBasesEmbalagens := nil;
  dsMensagensCoresBasesEmbalagens  := nil;


end;

destructor TAbstractGravandoExecucaoFalcao.Destroy;
begin
  if Assigned(dsMensagensCoresBasesEmbalagens) then FreeAndNil(dsMensagensCoresBasesEmbalagens);
  if Assigned(qryMensagensCoresBasesEmbalagens) then FreeAndNil(qryMensagensCoresBasesEmbalagens);
  if Assigned(dsMensagens) then FreeAndNil(dsMensagens);
  if Assigned(qryMensagens) then FreeAndNil(qryMensagens);
  if Assigned(dsCoresColorantes) then FreeAndNil(dsCoresColorantes);
  if Assigned(qryCoresColorantes) then FreeAndNil(qryCoresColorantes);
  if Assigned(dsCores) then FreeAndNil(dsCores);
  if Assigned(qryCores) then FreeAndNil(qryCores);
  if Assigned(dsColorantes) then FreeAndNil(dsColorantes);
  if Assigned(qryColorantes) then FreeAndNil(qryColorantes);
  if Assigned(dsEmbalagens) then FreeAndNil(dsEmbalagens);
  if Assigned(qryEmbalagens) then FreeAndNil(qryEmbalagens);
  if Assigned(dsProdutosBasesEmbalagens) then FreeAndNil(dsProdutosBasesEmbalagens);
  if Assigned(qryProdutosBasesEmbalagens) then FreeAndNil(qryProdutosBasesEmbalagens);
  if Assigned(dsTipos) then FreeAndNil(dsTipos);
  if Assigned(qryTipos) then FreeAndNil(qryTipos);
  if Assigned(dsBases) then FreeAndNil(dsBases);
  if Assigned(qryBases) then FreeAndNil(qryBases);
  if Assigned(dsProdutos) then FreeAndNil(dsProdutos);
  if Assigned(qryProdutos) then FreeAndNil(qryProdutos);
  if Assigned(dsGrupos) then FreeAndNil(dsGrupos);
  if Assigned(qryGrupos) then FreeAndNil(qryGrupos);
  if Assigned(sprDados) then FreeAndNil(sprDados);
  if Assigned(conOrigem) then FreeAndNil(conOrigem);
  inherited;
end;

function TAbstractGravandoExecucaoFalcao.fFormataAutInc(const intAutInc: Integer): String;
begin
  Result := TAutcomTintaFactory.Get.GetCodEmp +
    TStrUtils.fPadL(IntToStr(intAutInc) +
    TAutcomTintaFactory.Get.GetCodEmp, 17, '0');
end;

function TAbstractGravandoExecucaoFalcao.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoFalcao.fValidaPath : Boolean;
begin
  Result := True;

  If (Not FileExists(GetPath)) Then
    Result := False;
end;

function TAbstractGravandoExecucaoFalcao.GetDados: TADOStoredProc;
var
  parametro: TParameter;
begin
  if not Assigned(sprDados) then
  begin
    sprDados               := TADOStoredProc.Create(nil);
    sprDados.CursorType    := ctStatic;
    sprDados.Connection    := GetConexaoOrigem;
    sprDados.ProcedureName := 'SPC_LINK_TABELAS';
    parametro              := sprDados.Parameters.AddParameter;
    parametro.Name         := '@pult_dta_atu';
    parametro.Attributes   := [paNullable];
    parametro.DataType     := ftDateTime;
    parametro.Value        := StrToDate('01/01/1900');
  end;

  Result := sprDados;
end;

function TAbstractGravandoExecucaoFalcao.GetDataSource(const qryGen: TDataSet): TDataSource;
begin
  Result         := TDataSource.Create(qryGen);
  Result.DataSet := qryGen;
end;

function TAbstractGravandoExecucaoFalcao.GetPath: String;
begin
  Result := conf.fGet('PATFAL');
end;

function TAbstractGravandoExecucaoFalcao.GetUnidade(const fltVolume: Double): string;
begin
  if RoundTo(fltVolume, -3) <= 0.9 then
    Result := 'LT'
  else if RoundTo(fltVolume, -3) <= 3.6 then
    Result := 'GL'
  else
    Result := 'LA';
end;

function TAbstractGravandoExecucaoFalcao.GetAdoDataSet: TADODataSet;
begin
  Result := TADODataSet.Create(nil);
  Result.Connection := GetConexaoOrigem;
end;

function TAbstractGravandoExecucaoFalcao.GetConexaoOrigem: TADOConnection;
var
  conf: IConfTinta;
begin
  if not Assigned(conOrigem) then
  begin
    conf := TAutcomTintaFactory.Get.fGetConfTinta('FAL');
    conOrigem := TADOConnection.Create(nil);
    conOrigem.ConnectionString :=
      'Provider=SQLOLEDB.1;Password=' +
      conf.fGet('SENHDB') +
      ';Persist Security Info=True;User ID=' +
      conf.fGet('USERDB') +
      ';Initial Catalog=' +
      conf.fGet('DATABA') +
      ';Data Source=' +
      conf.fGet('SRVNAM') + ';';
    conOrigem.LoginPrompt := False;
    conOrigem.Open();
  end;

  Result := conOrigem;  
end;

{ TDataSetHelper }

procedure TDataSetHelper.Filtar(const strFiltro: string);
begin
  if strFiltro <> Self.Filter then
  begin
    Self.Filtered := False;
    Self.Filter   := strFiltro;
    Self.Filtered := True;
  end;
end;

end.
