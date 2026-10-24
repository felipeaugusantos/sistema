{***********************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Suvinil *}
{********************************************************************************PH*}
unit untAbstractGravandoExecucaoSuvinil;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB,
  Math, Uni, SQLServerUniProvider;

type
  TAbstractGravandoExecucaoSuvinil = class(TInterfacedObject, IGravandoExecucaoNome)
  private
  protected
    sprDadosBases     : TADOStoredProc;
    sprDadosColorantes: TADOStoredProc;

    conOrigem: TADOConnection;
    conexaoCores: TUniConnection;
    
    qryGrupos: TADODataSet;
    dsGrupos: TDataSource;
    qryGruposCores: TUniQuery;
    dsGruposCores: TUniDataSource;

    qryProdutos: TADODataSet;
    dsProdutos: TDataSource;
    qryProdutosCores: TUniQuery;
    dsProdutosCores: TUniDataSource;

    qryBases: TADODataSet;
    dsBases: TDataSource;
    qryBasesCores: TUniQuery;
    dsBasesCores: TUniDataSource;

    qryTipos: TADODataSet;
    dsTipos: TDataSource;
    qryTiposCores: TUniQuery;
    dsTiposCores: TUniDataSource;

    qryProdutosBasesEmbalagens: TADODataSet;
    dsProdutosBasesEmbalagens: TDataSource;
    qryProdutosBasesEmbalagensCores: TUniQuery;
    dsProdutosBasesEmbalagensCores: TUniDataSource;

    qryEmbalagens: TADODataSet;
    dsEmbalagens: TDataSource;
    qryEmbalagensCores: TUniQuery;
    dsEmbalagensCores: TUniDataSource;

    qryColorantes: TADODataSet;
    dsColorantes: TDataSource;
    qryColorantesCores: TUniQuery;
    dsColorantesCores: TUniDataSource;


    qryCores: TADODataSet;
    dsCores: TDataSource;
    qryCoresCores: TUniQuery;
    dsCoresCores: TUniDataSource;

    qryCoresColorantes: TADODataSet;
    dsCoresColorantes: TDataSource;
    qryCoresColorantesCores: TUniQuery;
    dsCoresColorantesCores: TUniDataSource;

    qryMensagens: TADODataSet;
    dsMensagens: TDataSource;
    qryMensagensCores: TUniQuery;
    dsMensagensCores: TUniDataSource;

    qryMensagensCoresBasesEmbalagens: TADODataSet;
    dsMensagensCoresBasesEmbalagens: TDataSource;
    qryMensagensCoresBasesEmbalagensCores: TUniQuery;
    dsMensagensCoresBasesEmbalagensCores: TUniDataSource;

    qryTonalidadesCores: TUniQuery;
    dsTonalidadesCores: TUniDataSource;


    function GetConexaoOrigem(): TADOConnection;
    function GetConexaoOrigemCores(): TUniConnection;
    function GetAdoDataSet(): TADODataSet;
    function GetUniQueryCores(): TUniQuery;
    function GetDataSource(const qryGen: TDataSet): TDataSource;
    function GetDataSourceCores(const qryGen: TUniQuery): TUniDataSource;

    function GetDadosBases(): TADOStoredProc;
    function GetDadosColorantes(): TADOStoredProc;

    procedure CarregarDadosBases;
    procedure CarregarDadosCores;
    procedure CarregarDadosColorantes;


    function GetUnidade(const fltVolume: Double): string;
    function fGetUnidadeLata(const fltVolume: Double): String;
    function fFormataAutInc(const intAutInc: Integer): String;
  public
    constructor Create();
    destructor Destroy; override;
    function fGetNomeGravacao: string; virtual; abstract;
    procedure Executar(const gravando: IGravando); virtual; abstract;
    function fHabilitaOpcao(): Boolean; Virtual; Abstract;

    procedure CriarObjetos;
    procedure DestruirObjetos;
  end;

  TDataSetHelper = class helper for TDataSet
  public
    procedure Filtar(const strFiltro: string);
  end;


implementation

uses
  untAutcomTintaFactory, untStrUtils, untIConfTinta;

{ TGravandoExecucaoSuvinilCores }

procedure TAbstractGravandoExecucaoSuvinil.CarregarDadosBases;
var
  intRecordsAffected: Integer;
begin
  qryGrupos                  := GetAdoDataSet;
  dsGrupos                   := GetDataSource(qryGrupos);
  qryProdutos                := GetAdoDataSet;
  dsProdutos                 := GetDataSource(qryProdutos);
  qryBases                   := GetAdoDataSet;
  dsBases                    := GetDataSource(qryBases);
  qryTipos                   := GetAdoDataSet;
  dsTipos                    := GetDataSource(qryTipos);
  qryProdutosBasesEmbalagens := GetAdoDataSet;
  dsProdutosBasesEmbalagens  := GetDataSource(qryProdutosBasesEmbalagens);
  qryEmbalagens              := GetAdoDataSet;
  dsEmbalagens               := GetDataSource(qryEmbalagens);
  qryColorantes              := GetAdoDataSet;
  dsColorantes               := GetDataSource(qryColorantes);
  qryCores                   := GetAdoDataSet;
  dsCores                    := GetDataSource(qryCores);
  qryCoresColorantes         := GetAdoDataSet;
  dsCoresColorantes          := GetDataSource(qryCoresColorantes);
  qryMensagens               := GetAdoDataSet;
  dsMensagens                := GetDataSource(qryMensagens);

  qryMensagensCoresBasesEmbalagens := GetAdoDataSet;
  dsMensagensCoresBasesEmbalagens  := GetDataSource(qryMensagensCoresBasesEmbalagens);


  GetDadosBases.Close;
  GetDadosBases.Open;

  qryGrupos.Recordset                  := GetDadosBases.Recordset;
  qryProdutos.Recordset                := GetDadosBases.NextRecordset(intRecordsAffected);
  qryBases.Recordset                   := GetDadosBases.NextRecordset(intRecordsAffected);
  qryTipos.Recordset                   := GetDadosBases.NextRecordset(intRecordsAffected);
  qryProdutosBasesEmbalagens.Recordset := GetDadosBases.NextRecordset(intRecordsAffected);
  qryEmbalagens.Recordset              := GetDadosBases.NextRecordset(intRecordsAffected);
  qryColorantes.Recordset              := GetDadosBases.NextRecordset(intRecordsAffected);
  qryCores.Recordset                   := GetDadosBases.NextRecordset(intRecordsAffected);
  qryCoresColorantes.Recordset         := GetDadosBases.NextRecordset(intRecordsAffected);

  qryMensagens.Recordset                     := GetDadosBases.NextRecordset(intRecordsAffected);
  qryMensagensCoresBasesEmbalagens.Recordset := GetDadosBases.NextRecordset(intRecordsAffected);
end;


procedure TAbstractGravandoExecucaoSuvinil.CarregarDadosColorantes;
var
  intRecordsAffected: Integer;
begin
  qryGrupos                  := GetAdoDataSet;
  dsGrupos                   := GetDataSource(qryGrupos);
  qryProdutos                := GetAdoDataSet;
  dsProdutos                 := GetDataSource(qryProdutos);
  qryBases                   := GetAdoDataSet;
  dsBases                    := GetDataSource(qryBases);
  qryTipos                   := GetAdoDataSet;
  dsTipos                    := GetDataSource(qryTipos);
  qryProdutosBasesEmbalagens := GetAdoDataSet;
  dsProdutosBasesEmbalagens  := GetDataSource(qryProdutosBasesEmbalagens);
  qryEmbalagens              := GetAdoDataSet;
  dsEmbalagens               := GetDataSource(qryEmbalagens);
  qryColorantes              := GetAdoDataSet;
  dsColorantes               := GetDataSource(qryColorantes);
  qryCores                   := GetAdoDataSet;
  dsCores                    := GetDataSource(qryCores);
  qryCoresColorantes         := GetAdoDataSet;
  dsCoresColorantes          := GetDataSource(qryCoresColorantes);
  qryMensagens               := GetAdoDataSet;
  dsMensagens                := GetDataSource(qryMensagens);

  qryMensagensCoresBasesEmbalagens := GetAdoDataSet;
  dsMensagensCoresBasesEmbalagens  := GetDataSource(qryMensagensCoresBasesEmbalagens);

  GetDadosColorantes.Close;
  GetDadosColorantes.Open;

  qryGrupos.Recordset                  := GetDadosColorantes.Recordset;
  qryProdutos.Recordset                := GetDadosColorantes.NextRecordset(intRecordsAffected);
  qryBases.Recordset                   := GetDadosColorantes.NextRecordset(intRecordsAffected);
  qryTipos.Recordset                   := GetDadosColorantes.NextRecordset(intRecordsAffected);
  qryProdutosBasesEmbalagens.Recordset := GetDadosColorantes.NextRecordset(intRecordsAffected);
  qryEmbalagens.Recordset              := GetDadosColorantes.NextRecordset(intRecordsAffected);
  qryColorantes.Recordset              := GetDadosColorantes.NextRecordset(intRecordsAffected);
  qryCores.Recordset                   := GetDadosColorantes.NextRecordset(intRecordsAffected);
  qryCoresColorantes.Recordset         := GetDadosColorantes.NextRecordset(intRecordsAffected);

  qryMensagens.Recordset                     := GetDadosColorantes.NextRecordset(intRecordsAffected);
  qryMensagensCoresBasesEmbalagens.Recordset := GetDadosColorantes.NextRecordset(intRecordsAffected);
end;


procedure TAbstractGravandoExecucaoSuvinil.CarregarDadosCores;
begin
  qryGruposCores                   := GetUniQueryCores;
  dsGruposCores                    := GetDataSourceCores(qryGruposCores);
  qryProdutosCores                 := GetUniQueryCores;
  dsProdutosCores                  := GetDataSourceCores(qryProdutosCores);
  qryBasesCores                    := GetUniQueryCores;
  dsBasesCores                     := GetDataSourceCores(qryBasesCores);
  qryTiposCores                    := GetUniQueryCores;
  dsTiposCores                     := GetDataSourceCores(qryTiposCores);
  qryProdutosBasesEmbalagensCores  := GetUniQueryCores;
  dsProdutosBasesEmbalagensCores   := GetDataSourceCores(qryProdutosBasesEmbalagensCores);
  qryEmbalagensCores               := GetUniQueryCores;
  dsEmbalagensCores                := GetDataSourceCores(qryEmbalagensCores);
  qryColorantesCores               := GetUniQueryCores;
  dsColorantesCores                := GetDataSourceCores(qryColorantesCores);
  qryCoresCores                    := GetUniQueryCores;
  dsCoresCores                     := GetDataSourceCores(qryCoresCores);
  qryCoresColorantesCores          := GetUniQueryCores;
  dsCoresColorantesCores           := GetDataSourceCores(qryCoresColorantesCores);
  qryMensagensCores                := GetUniQueryCores;
  dsMensagensCores                 := GetDataSourceCores(qryMensagensCores);

  qryMensagensCoresBasesEmbalagensCores := GetUniQueryCores;
  dsMensagensCoresBasesEmbalagensCores  := GetDataSourceCores(qryMensagensCoresBasesEmbalagensCores);

  qryTonalidadesCores              := GetUniQueryCores;
  dsTonalidadesCores               := GetDataSourceCores(qryTonalidadesCores);

  qryProdutosCores.SQL.Add('SELECT * FROM V_TWEB_PRODUTOS');
  qryProdutosCores.Open;

  qryGruposCores.SQL.Add('SELECT * FROM V_TWEB_GRUPOS');
  qryGruposCores.Open;

  qryEmbalagensCores.SQL.Add('SELECT * FROM V_TWEB_EMBALAGENS');
  qryEmbalagensCores.Open;

  qryBasesCores.SQL.Add('SELECT * FROM V_TWEB_TIPOS_BASES');
  qryBasesCores.Open;

  qryProdutosBasesEmbalagensCores.SQL.Add('SELECT * FROM V_TWEB_BASES');
  qryProdutosBasesEmbalagensCores.Open;

  qryColorantesCores.SQL.Add('SELECT * FROM V_TWEB_COLORANTES');
  qryColorantesCores.Open;

  qryCoresColorantesCores.SQL.Add('SELECT * FROM V_TWEB_CORES_COLORANTES');
  qryCoresColorantesCores.Open;

  qryCoresCores.SQL.Add('SELECT * FROM TWEB_CORES');
  qryCoresCores.Open;

  qryMensagensCores.SQL.Add('SELECT * FROM TMENSAGENS');
  qryMensagensCores.Open;

  qryMensagensCoresBasesEmbalagensCores.SQL.Add('SELECT * FROM TMENSAGENS_FORMULAS');
  qryMensagensCoresBasesEmbalagensCores.Open;

  qryTonalidadesCores.SQL.Add('SELECT * FROM TWEB_TONALIDADES');
  qryTonalidadesCores.Open;
end;


constructor TAbstractGravandoExecucaoSuvinil.Create;
begin
  inherited Create;
end;

procedure TAbstractGravandoExecucaoSuvinil.CriarObjetos;
begin
  inherited Create;
  sprDadosBases                     := nil;

  conOrigem                         := nil;
  conexaoCores                      := Nil;

  qryGrupos                         := nil;
  dsGrupos                          := nil;
  qryGruposCores                    := Nil;
  dsGruposCores                     := Nil;

  qryProdutos                       := nil;
  dsProdutos                        := nil;
  qryProdutosCores                  := Nil;
  dsProdutosCores                   := Nil;

  qryBases                          := nil;
  dsBases                           := nil;
  qryBasesCores                     := Nil;
  dsBasesCores                      := Nil;

  qryTipos                          := nil;
  dsTipos                           := nil;
  qryTiposCores                     := Nil;
  dsTiposCores                      := Nil;

  qryProdutosBasesEmbalagens        := nil;
  dsProdutosBasesEmbalagens         := nil;
  qryProdutosBasesEmbalagensCores   := Nil;
  dsProdutosBasesEmbalagensCores    := Nil;

  qryEmbalagens                     := nil;
  dsEmbalagens                      := nil;
  qryEmbalagensCores                := Nil;
  dsEmbalagensCores                 := Nil;

  qryColorantes                     := nil;
  dsColorantes                      := nil;
  qryColorantesCores                := Nil;
  dsColorantesCores                 := Nil;

  qryCores                          := nil;
  dsCores                           := nil;
  qryCoresCores                     := Nil;
  dsCoresCores                      := Nil;

  qryCoresColorantes                := nil;
  dsCoresColorantes                 := nil;
  qryCoresColorantesCores           := Nil;
  dsCoresColorantesCores            := Nil;

  qryMensagens                      := nil;
  dsMensagens                       := nil;
  qryMensagensCores                 := Nil;
  dsMensagensCores                  := Nil;

  qryMensagensCoresBasesEmbalagens  := nil;
  dsMensagensCoresBasesEmbalagens   := nil;
  qryMensagensCoresBasesEmbalagensCores := Nil;
  dsMensagensCoresBasesEmbalagensCores  := Nil;

  qryTonalidadesCores               := Nil;
  dsTonalidadesCores                := Nil;
end;

destructor TAbstractGravandoExecucaoSuvinil.Destroy;
begin
  inherited;
  DestruirObjetos;
end;

procedure TAbstractGravandoExecucaoSuvinil.DestruirObjetos;
begin
  if Assigned(dsMensagensCoresBasesEmbalagens)  then
    FreeAndNil(dsMensagensCoresBasesEmbalagens);

  if Assigned(qryMensagensCoresBasesEmbalagens) then
    FreeAndNil(qryMensagensCoresBasesEmbalagens);

  if Assigned(dsMensagensCoresBasesEmbalagensCores)  then
    FreeAndNil(dsMensagensCoresBasesEmbalagensCores);

  if Assigned(qryMensagensCoresBasesEmbalagensCores) then
    FreeAndNil(qryMensagensCoresBasesEmbalagensCores);

  if Assigned(qryTonalidadesCores) Then
    FreeAndNil(qryTonalidadesCores);

  if Assigned(dsMensagens) then
    FreeAndNil(dsMensagens);

  if Assigned(qryMensagens) then
    FreeAndNil(qryMensagens);

  if Assigned(dsMensagensCores) then
    FreeAndNil(dsMensagensCores);

  if Assigned(qryMensagensCores) then
    FreeAndNil(qryMensagensCores);

  if Assigned(dsCoresColorantes) then
    FreeAndNil(dsCoresColorantes);

  if Assigned(qryCoresColorantes) then
    FreeAndNil(qryCoresColorantes);

  if Assigned(dsCoresColorantesCores) then
    FreeAndNil(dsCoresColorantesCores);

  if Assigned(qryCoresColorantesCores) then
    FreeAndNil(qryCoresColorantesCores);

  if Assigned(dsCores) then
    FreeAndNil(dsCores);

  if Assigned(qryCores) then
    FreeAndNil(qryCores);

  if Assigned(dsCoresCores) then
    FreeAndNil(dsCoresCores);

  if Assigned(qryCoresCores) then
    FreeAndNil(qryCoresCores);

  if Assigned(dsColorantes) then
    FreeAndNil(dsColorantes);

  if Assigned(qryColorantes) then
    FreeAndNil(qryColorantes);

  if Assigned(dsColorantesCores) then
    FreeAndNil(dsColorantesCores);

  if Assigned(qryColorantesCores) then
    FreeAndNil(qryColorantesCores);

  if Assigned(dsEmbalagens) then
    FreeAndNil(dsEmbalagens);

  if Assigned(qryEmbalagens) then
    FreeAndNil(qryEmbalagens);

  if Assigned(dsEmbalagensCores) then
    FreeAndNil(dsEmbalagensCores);

  if Assigned(qryEmbalagensCores) then
    FreeAndNil(qryEmbalagensCores);

  if Assigned(dsProdutosBasesEmbalagens) then
    FreeAndNil(dsProdutosBasesEmbalagens);

  if Assigned(qryProdutosBasesEmbalagens) then
    FreeAndNil(qryProdutosBasesEmbalagens);

  if Assigned(dsProdutosBasesEmbalagensCores) then
    FreeAndNil(dsProdutosBasesEmbalagensCores);

  if Assigned(qryProdutosBasesEmbalagensCores) then
    FreeAndNil(qryProdutosBasesEmbalagensCores);

  if Assigned(dsTipos) then
    FreeAndNil(dsTipos);

  if Assigned(qryTipos) then
    FreeAndNil(qryTipos);

  if Assigned(dsTiposCores) then
    FreeAndNil(dsTiposCores);

  if Assigned(qryTiposCores) then
    FreeAndNil(qryTiposCores);

  if Assigned(dsBases) then
    FreeAndNil(dsBases);

  if Assigned(qryBases) then
    FreeAndNil(qryBases);

  if Assigned(dsBasesCores) then
    FreeAndNil(dsBasesCores);

  if Assigned(qryBasesCores) then
    FreeAndNil(qryBasesCores);

  if Assigned(dsProdutos) then
    FreeAndNil(dsProdutos);

  if Assigned(qryProdutos) then
    FreeAndNil(qryProdutos);

  if Assigned(dsProdutosCores) then
    FreeAndNil(dsProdutosCores);

  if Assigned(qryProdutosCores) then
    FreeAndNil(qryProdutosCores);

  if Assigned(dsGrupos) then
    FreeAndNil(dsGrupos);

  if Assigned(qryGrupos) then
    FreeAndNil(qryGrupos);

  if Assigned(dsGruposCores) then
    FreeAndNil(dsGruposCores);

  if Assigned(qryGruposCores) then
    FreeAndNil(qryGruposCores);

  if Assigned(sprDadosBases) then
    FreeAndNil(sprDadosBases);

  if Assigned(conOrigem) then
    FreeAndNil(conOrigem);

  if Assigned(conexaoCores) then
    FreeAndNil(conexaoCores);

  TAutcomTintaFactory.Get.DropTable('TMP_QRYBASES');
  TAutcomTintaFactory.Get.DropTable('TMP_QRYCOLORANTES');
  TAutcomTintaFactory.Get.DropTable('TMP_QRYCORES');
  TAutcomTintaFactory.Get.DropTable('TMP_QRYCORESCOLORANTES');
  TAutcomTintaFactory.Get.DropTable('TMP_QRYEMBALAGENS');
  TAutcomTintaFactory.Get.DropTable('TMP_QRYGRUPOS');
  TAutcomTintaFactory.Get.DropTable('TMP_QRYPRODUTOS');
  TAutcomTintaFactory.Get.DropTable('TMP_QRYPRODUTOSBASESEMBALAGENS');
  TAutcomTintaFactory.Get.DropTable('TMP_SUV_CADSUV');
  TAutcomTintaFactory.Get.DropTable('TMP_QRYMENSAGENSCORESBASESEMBALAGENS');
  TAutcomTintaFactory.Get.DropTable('TMP_QRYMENSAGENS');
end;

function TAbstractGravandoExecucaoSuvinil.fFormataAutInc(const intAutInc: Integer): String;
begin
  Result := TAutcomTintaFactory.Get.GetCodEmp +
    TStrUtils.fPadL(IntToStr(intAutInc) +
    TAutcomTintaFactory.Get.GetCodEmp, 17, '0');
end;

function TAbstractGravandoExecucaoSuvinil.fGetUnidadeLata(
  const fltVolume: Double): String;
begin
  Result := 'LA';

  If FloatToStr(fltVolume) = '21' Then
    Result := '1J'
  Else If FloatToStr(fltVolume) = '22' Then
    Result := '2J'
  Else If FloatToStr(fltVolume) = '24' Then
    Result := '3J'
  Else If FloatToStr(fltVolume) = '25' Then
    Result := '4J'
  Else If FloatToStr(fltVolume) = '26' Then
    Result := '5J'
  Else If FloatToStr(fltVolume) = '29' Then
    Result := '6J';
end;

function TAbstractGravandoExecucaoSuvinil.GetDadosBases: TADOStoredProc;
var
  parametro: TParameter;
begin

  If Not Assigned(sprDadosBases) Then
  Begin
    sprDadosBases               := TADOStoredProc.Create(nil);
    sprDadosBases.CursorType    := ctStatic;
    sprDadosBases.Connection    := GetConexaoOrigem;
    sprDadosBases.ProcedureName := 'SPC_LINK_TABELAS';

    parametro := sprDadosBases.Parameters.AddParameter;

    parametro.Name          := '@pult_dta_atu';
    parametro.Attributes    := [paNullable];
    parametro.DataType      := ftDateTime;
    parametro.Value         := StrToDate('01/01/1900');
  End;

  sprDadosBases.Connection    := GetConexaoOrigem;

  Result := sprDadosBases;
end;

function TAbstractGravandoExecucaoSuvinil.GetDadosColorantes: TADOStoredProc;
var
  parametro: TParameter;
begin

  If Not Assigned(sprDadosColorantes) Then
  Begin
    sprDadosColorantes               := TADOStoredProc.Create(nil);
    sprDadosColorantes.CursorType    := ctStatic;
    sprDadosColorantes.Connection    := GetConexaoOrigem;
    sprDadosColorantes.ProcedureName := 'SPC_LINK_TABELAS';

    parametro := sprDadosColorantes.Parameters.AddParameter;

    parametro.Name          := '@pult_dta_atu';
    parametro.Attributes    := [paNullable];
    parametro.DataType      := ftDateTime;
    parametro.Value         := StrToDate('01/01/1900');
  End;

  sprDadosColorantes.Connection    := GetConexaoOrigem;

  Result := sprDadosColorantes;

end;

function TAbstractGravandoExecucaoSuvinil.GetDataSource(const qryGen: TDataSet): TDataSource;
begin
  Result := TDataSource.Create(qryGen);
  Result.DataSet := qryGen;
end;

function TAbstractGravandoExecucaoSuvinil.GetDataSourceCores(
  const qryGen: TUniQuery): TUniDataSource;
begin
  Result := TUniDataSource.Create(qryGen);
  Result.DataSet := qryGen;
end;

function TAbstractGravandoExecucaoSuvinil.GetUnidade(const fltVolume: Double): string;
begin
  If RoundTo(fltVolume, -3) <= 0.9 Then
    Result := 'LT'
  Else If FloatToStr(fltVolume) = '4,4' Then
    Result := 'BD'
  Else If RoundTo(fltVolume, -3) <= 5.8 Then
    Result := 'GL'
  Else
    Result := fGetUnidadeLata(fltVolume);
end;

function TAbstractGravandoExecucaoSuvinil.GetUniQueryCores: TUniQuery;
begin
  Result := TUniQuery.Create(nil);
  Result.Connection := GetConexaoOrigemCores;
end;

function TAbstractGravandoExecucaoSuvinil.GetAdoDataSet: TADODataSet;
begin
  Result := TADODataSet.Create(nil);
  Result.Connection := GetConexaoOrigem;
end;

function TAbstractGravandoExecucaoSuvinil.GetConexaoOrigem: TADOConnection;
var
  conf: IConfTinta;
begin
  if not Assigned(conOrigem) then
  begin
    conf := TAutcomTintaFactory.Get.fGetConfTinta('SUV');
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

function TAbstractGravandoExecucaoSuvinil.GetConexaoOrigemCores: TUniConnection;
var
  conf: IConfTinta;
begin
  if not Assigned(conOrigem) then
  begin
    conf := TAutcomTintaFactory.Get.fGetConfTinta('SUV');
    conexaoCores := TUniConnection.Create(nil);
    conexaoCores.ProviderName := 'SQL Server';
    conexaoCores.Username := Conf.fGet('USERDB');
    conexaoCores.Password := Conf.fGet('SENHDB');
    conexaoCores.Server := Conf.fGet('SRVNAM');
    conexaoCores.Database := Conf.fGet('DATABA');
    conexaoCores.LoginPrompt := False;
    conexaoCores.Connect;
  end;

  Result := conexaoCores;
end;

{ TDataSetHelper }

procedure TDataSetHelper.Filtar(const strFiltro: string);
begin
  if strFiltro <> Self.Filter then
  begin
    Self.Filtered := False;
    Self.Filter := strFiltro;
    Self.Filtered := True;
  end;
end;

end.
