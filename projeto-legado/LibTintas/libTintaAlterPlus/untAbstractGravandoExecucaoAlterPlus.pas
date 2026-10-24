{***********************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta ALPcolor *}
{********************************************************************************PH*}
unit untAbstractGravandoExecucaoAlterPlus;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB, Math, untIConfTinta;

type
  TAbstractGravandoExecucaoAlterPlus = class(TInterfacedObject, IGravandoExecucaoNome)
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

{ TGravandoExecucaoAlterPlusCores }

procedure TAbstractGravandoExecucaoAlterPlus.CarregarDados;
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

constructor TAbstractGravandoExecucaoAlterPlus.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('ALP');

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

destructor TAbstractGravandoExecucaoAlterPlus.Destroy;
begin
  FreeAndNil(dsMensagensCoresBasesEmbalagens);
  FreeAndNil(qryMensagensCoresBasesEmbalagens);
  FreeAndNil(dsMensagens);
  FreeAndNil(qryMensagens);
  FreeAndNil(dsCoresColorantes);
  FreeAndNil(qryCoresColorantes);
  FreeAndNil(dsCores);
  FreeAndNil(qryCores);
  FreeAndNil(dsColorantes);
  FreeAndNil(qryColorantes);
  FreeAndNil(dsEmbalagens);
  FreeAndNil(qryEmbalagens);
  FreeAndNil(dsProdutosBasesEmbalagens);
  FreeAndNil(qryProdutosBasesEmbalagens);
  FreeAndNil(dsTipos);
  FreeAndNil(qryTipos);
  FreeAndNil(dsBases);
  FreeAndNil(qryBases);
  FreeAndNil(dsProdutos);
  FreeAndNil(qryProdutos);
  FreeAndNil(dsGrupos);
  FreeAndNil(qryGrupos);
  FreeAndNil(sprDados);
  FreeAndNil(conOrigem);
  inherited;
end;

function TAbstractGravandoExecucaoAlterPlus.fFormataAutInc(const intAutInc: Integer): String;
begin
  Result := TAutcomTintaFactory.Get.GetCodEmp +
    TStrUtils.fPadL(IntToStr(intAutInc) +
    TAutcomTintaFactory.Get.GetCodEmp, 17, '0');
end;

function TAbstractGravandoExecucaoAlterPlus.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoAlterPlus.fValidaPath : Boolean;
begin
  Result := True;

  If (Not FileExists(GetPath)) Then
    Result := False;
end;

function TAbstractGravandoExecucaoAlterPlus.GetDados: TADOStoredProc;
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

function TAbstractGravandoExecucaoAlterPlus.GetDataSource(const qryGen: TDataSet): TDataSource;
begin
  Result         := TDataSource.Create(qryGen);
  Result.DataSet := qryGen;
end;

function TAbstractGravandoExecucaoAlterPlus.GetPath: String;
begin
  Result := conf.fGet('PATALP');
end;

function TAbstractGravandoExecucaoAlterPlus.GetUnidade(const fltVolume: Double): string;
begin
  if RoundTo(fltVolume, -3) <= 0.9 then
    Result := 'LT'
  else if RoundTo(fltVolume, -3) <= 3.6 then
    Result := 'GL'
  else
    Result := 'LA';
end;

function TAbstractGravandoExecucaoAlterPlus.GetAdoDataSet: TADODataSet;
begin
  Result := TADODataSet.Create(nil);
  Result.Connection := GetConexaoOrigem;
end;

function TAbstractGravandoExecucaoAlterPlus.GetConexaoOrigem: TADOConnection;
var
  conf: IConfTinta;
begin
  if not Assigned(conOrigem) then
  begin
    conf := TAutcomTintaFactory.Get.fGetConfTinta('ALP');
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
