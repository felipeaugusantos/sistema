{ATENÇÂO ESTA CLASSE NÂO FUNCIONA COM BANDAS ANINHADAS}
unit untTGridConfigManagerDB;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections, System.JSON,
  cxGrid, cxGridDBTableView, cxGridDBBandedTableView, Data.DB, cxGridCustomView,
  cxCustomData, cxFilter, cxDataStorage, Uni, cxGridTableView, cxGridBandedTableView,
  dxCore;

type
  // Forward declaration
  TBandConfig = class;

  // Estrutura para configuração de uma coluna
  TColumnConfig = class
  private
    FFieldName: string;
    FWidth: Integer;
    FVisible: Boolean;
    FPosition: Integer;
    FBandCaption: string;
    FBandIndex: Integer;
    FRowIndex: Integer;
    FSortOrder: TcxDataSortOrder;
    FSortIndex: Integer;
  public
    property FieldName: string read FFieldName write FFieldName;
    property Width: Integer read FWidth write FWidth;
    property Visible: Boolean read FVisible write FVisible;
    property Position: Integer read FPosition write FPosition;
    property BandCaption: string read FBandCaption write FBandCaption;
    property BandIndex: Integer read FBandIndex write FBandIndex;
    property RowIndex: Integer read FRowIndex write FRowIndex;
    property SortOrder: TcxDataSortOrder read FSortOrder write FSortOrder;
    property SortIndex: Integer read FSortIndex write FSortIndex;

    function ToJSON: TJSONObject;
    procedure FromJSON(AJson: TJSONObject);
  end;

  // Estrutura para configuração de uma banda (CONTÉM SUAS COLUNAS)
  TBandConfig = class
  private
    FCaption: string;
    FWidth: Integer;
    FVisible: Boolean;
    FPosition: Integer;
    FFixedKind: TcxGridBandFixedKind;
    FColumns: TObjectList<TColumnConfig>;
  public
    constructor Create;
    destructor Destroy; override;

    property Caption: string read FCaption write FCaption;
    property Width: Integer read FWidth write FWidth;
    property Visible: Boolean read FVisible write FVisible;
    property Position: Integer read FPosition write FPosition;
    property FixedKind: TcxGridBandFixedKind read FFixedKind write FFixedKind;
    property Columns: TObjectList<TColumnConfig> read FColumns;

    function ToJSON: TJSONObject;
    procedure FromJSON(AJson: TJSONObject);

    // Novo método auxiliar: buscar coluna pelo fieldname
    function FindColumn(const AFieldName: string): TColumnConfig;
  end;

  // Estrutura para filtro
  TFilterConfig = class
  private
    FFilterText: string;
    FActive: Boolean;
  public
    property FilterText: string read FFilterText write FFilterText;
    property Active: Boolean read FActive write FActive;

    function ToJSON: TJSONObject;
    procedure FromJSON(AJson: TJSONObject);
  end;

  // Configuração completa do Grid
  TGridConfig = class
  private
    FGridName: string;
    FBands: TObjectList<TBandConfig>;
    FFilter: TFilterConfig;
    FSaveDate: TDateTime;
  public
    constructor Create;
    destructor Destroy; override;

    property GridName: string read FGridName write FGridName;
    property Bands: TObjectList<TBandConfig> read FBands;
    property Filter: TFilterConfig read FFilter write FFilter;
    property SaveDate: TDateTime read FSaveDate write FSaveDate;

    function ToJSON: string;
    procedure FromJSON(const AJson: string);

    // Novo método: buscar banda pelo caption
    function FindBand(const ACaption: string): TBandConfig;
  end;

  // Gerenciador principal
  TGridConfigManagerDB = class
  private
    FCodOperador: string;

    // Métodos de banco de dados
    function LoadConfigFromDB(const AChave: string): string;
    procedure SaveConfigToDB(const AChave: string; const AJsonConfig: string);
    function ConfigExistsInDB(const AChave: string): Boolean;

    // Aplicação inteligente (ignora campos inexistentes)
    procedure ApplyConfigSmart(AConfig: TGridConfig;
      AView: TcxGridDBBandedTableView);

    // Buscar banda pela caption
    function FindBandByCaption(AView: TcxGridDBBandedTableView;
      const ACaption: string): TcxGridBand;

    // NOVO: Fazer merge de configurações
    procedure MergeConfigs(AExistingConfig, ANewConfig: TGridConfig);

  public
    constructor Create(const ACodOperador: string);

    property CodOperador: string read FCodOperador write FCodOperador;

    // Salvar configuração atual do grid (COM MERGE)
    procedure SaveConfig(AView: TcxGridDBBandedTableView; const AChave: string);

    // Carregar configuração e aplicar ao grid
    function LoadConfig(AView: TcxGridDBBandedTableView;
      const AChave: string): Boolean;

    // Exportar/Importar configurações
    function ExportToJSON(AView: TcxGridDBBandedTableView): string;
    procedure ImportFromJSON(AView: TcxGridDBBandedTableView; const AJson: string);

    // Excluir configuração
    procedure DeleteConfig(const AChave: string);

    // Listar todas as configurações do operador
    function ListConfigurations: TArray<string>;
  end;

implementation

uses
  System.DateUtils, untFuncoesSIMPLES;

{ TColumnConfig }

function TColumnConfig.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('fieldName', FFieldName);
  Result.AddPair('width', TJSONNumber.Create(FWidth));
  Result.AddPair('visible', TJSONBool.Create(FVisible));
  Result.AddPair('position', TJSONNumber.Create(FPosition));
  Result.AddPair('bandCaption', FBandCaption);
  Result.AddPair('bandIndex', TJSONNumber.Create(FBandIndex));
  Result.AddPair('rowIndex', TJSONNumber.Create(FRowIndex));
  Result.AddPair('sortOrder', TJSONNumber.Create(Ord(FSortOrder)));
  Result.AddPair('sortIndex', TJSONNumber.Create(FSortIndex));
end;

procedure TColumnConfig.FromJSON(AJson: TJSONObject);
begin
  FFieldName := AJson.GetValue<string>('fieldName');
  FWidth := AJson.GetValue<Integer>('width');
  FVisible := AJson.GetValue<Boolean>('visible');
  FPosition := AJson.GetValue<Integer>('position');
  FBandCaption := AJson.GetValue<string>('bandCaption', '');
  FBandIndex := AJson.GetValue<Integer>('bandIndex');
  FRowIndex := AJson.GetValue<Integer>('rowIndex');
  FSortOrder := TcxDataSortOrder(AJson.GetValue<Integer>('sortOrder'));
  FSortIndex := AJson.GetValue<Integer>('sortIndex');
end;

{ TBandConfig }

constructor TBandConfig.Create;
begin
  inherited;
  FColumns := TObjectList<TColumnConfig>.Create(True);
end;

destructor TBandConfig.Destroy;
begin
  FColumns.Free;
  inherited;
end;

function TBandConfig.FindColumn(const AFieldName: string): TColumnConfig;
var
  Col: TColumnConfig;
begin
  Result := nil;
  for Col in FColumns do
  begin
    if SameText(Col.FieldName, AFieldName) then
    begin
      Result := Col;
      Break;
    end;
  end;
end;

function TBandConfig.ToJSON: TJSONObject;
var
  JsonColumns: TJSONArray;
  Col: TColumnConfig;
begin
  Result := TJSONObject.Create;
  Result.AddPair('caption', FCaption);
  Result.AddPair('width', TJSONNumber.Create(FWidth));
  Result.AddPair('visible', TJSONBool.Create(FVisible));
  Result.AddPair('position', TJSONNumber.Create(FPosition));
  Result.AddPair('fixedKind', TJSONNumber.Create(Ord(FFixedKind)));

  // Adicionar colunas desta banda
  JsonColumns := TJSONArray.Create;
  for Col in FColumns do
    JsonColumns.AddElement(Col.ToJSON);
  Result.AddPair('columns', JsonColumns);
end;

procedure TBandConfig.FromJSON(AJson: TJSONObject);
var
  JsonColumns: TJSONArray;
  I: Integer;
  Col: TColumnConfig;
begin
  FCaption := AJson.GetValue<string>('caption');
  FWidth := AJson.GetValue<Integer>('width');
  FVisible := AJson.GetValue<Boolean>('visible');
  FPosition := AJson.GetValue<Integer>('position');
  FFixedKind := TcxGridBandFixedKind(AJson.GetValue<Integer>('fixedKind'));

  // Carregar colunas desta banda
  FColumns.Clear;
  if AJson.TryGetValue<TJSONArray>('columns', JsonColumns) then
  begin
    for I := 0 to JsonColumns.Count - 1 do
    begin
      Col := TColumnConfig.Create;
      Col.FromJSON(JsonColumns.Items[I] as TJSONObject);
      FColumns.Add(Col);
    end;
  end;
end;

{ TFilterConfig }

function TFilterConfig.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('filterText', FFilterText);
  Result.AddPair('active', TJSONBool.Create(FActive));
end;

procedure TFilterConfig.FromJSON(AJson: TJSONObject);
begin
  FFilterText := AJson.GetValue<string>('filterText', '');
  FActive := AJson.GetValue<Boolean>('active');
end;

{ TGridConfig }

constructor TGridConfig.Create;
begin
  inherited;
  FBands := TObjectList<TBandConfig>.Create(True);
  FFilter := TFilterConfig.Create;
end;

destructor TGridConfig.Destroy;
begin
  FBands.Free;
  FFilter.Free;
  inherited;
end;

function TGridConfig.FindBand(const ACaption: string): TBandConfig;
var
  Band: TBandConfig;
begin
  Result := nil;
  for Band in FBands do
  begin
    if SameText(Band.Caption, ACaption) then
    begin
      Result := Band;
      Break;
    end;
  end;
end;

function TGridConfig.ToJSON: string;
var
  JsonObj: TJSONObject;
  JsonBands: TJSONArray;
  Band: TBandConfig;
begin
  JsonObj := TJSONObject.Create;
  try
    JsonObj.AddPair('gridName', FGridName);
    JsonObj.AddPair('saveDate', DateToISO8601(FSaveDate));

    // Bandas (cada uma com suas colunas)
    JsonBands := TJSONArray.Create;
    for Band in FBands do
      JsonBands.AddElement(Band.ToJSON);
    JsonObj.AddPair('bands', JsonBands);

    // Filtro
    JsonObj.AddPair('filter', FFilter.ToJSON);

    Result := JsonObj.ToString;
  finally
    JsonObj.Free;
  end;
end;

procedure TGridConfig.FromJSON(const AJson: string);
var
  JsonObj: TJSONObject;
  JsonBands: TJSONArray;
  JsonFilter: TJSONObject;
  I: Integer;
  Band: TBandConfig;
begin


  JsonObj := TJSONObject.ParseJSONValue(AJson) as TJSONObject;
  if not Assigned(JsonObj) then
    raise Exception.Create('JSON inválido');

  try
    FGridName := JsonObj.GetValue<string>('gridName');
    FSaveDate := ISO8601ToDate(JsonObj.GetValue<string>('saveDate'));

    // Carregar bandas
    FBands.Clear;
    if JsonObj.TryGetValue<TJSONArray>('bands', JsonBands) then

    begin
      for I := 0 to JsonBands.Count - 1 do
      begin
        Band := TBandConfig.Create;
        Band.FromJSON(JsonBands.Items[I] as TJSONObject);
        FBands.Add(Band);
      end;
    end;

    // Carregar filtro
    if JsonObj.TryGetValue<TJSONObject>('filter', JsonFilter) then
      FFilter.FromJSON(JsonFilter);
  finally
    JsonObj.Free;
  end;
end;

{ TGridConfigManagerDB }

constructor TGridConfigManagerDB.Create(const ACodOperador: string);
begin
  inherited Create;
  FCodOperador := ACodOperador;
end;

function TGridConfigManagerDB.LoadConfigFromDB(const AChave: string): string;
var
  Qry: TUniQuery;
begin
  Result := '';
  Qry := fCriaQuery;
  try
    Qry.SQL.Text :=
      'SELECT GRD_CFGGRD ' +
      'FROM CONFIGURACAO_GRID ' +
      'WHERE GRD_CODOPE = :CODOPE ' +
      '  AND GRD_CHAVE = :CHAVE';

    Qry.ParamByName('CODOPE').AsString := FCodOperador;
    Qry.ParamByName('CHAVE').AsString := AChave;
    Qry.Open;

    if not Qry.IsEmpty then
      Result := Qry.FieldByName('GRD_CFGGRD').AsString;
  finally
    Qry.Free;
  end;
end;

procedure TGridConfigManagerDB.SaveConfigToDB(const AChave: string;
  const AJsonConfig: string);
var
  Qry: TUniQuery;

begin


  Qry := fCriaQuery;
  try
    if ConfigExistsInDB(AChave) then
    begin
      // Atualizar
      Qry.SQL.Text :=
        'UPDATE CONFIGURACAO_GRID ' +
        'SET GRD_CFGGRD = :CONFIG, ' +
        '    GRD_DTGRAV = CURRENT_TIMESTAMP ' +
        'WHERE GRD_CODOPE = :CODOPE ' +
        '  AND GRD_CHAVE = :CHAVE';
    end
    else
    begin
      // Inserir
      Qry.SQL.Text :=
        'INSERT INTO CONFIGURACAO_GRID ' +
        '  (GRD_CODOPE, GRD_CHAVE, GRD_CFGGRD, GRD_DTGRAV) ' +
        'VALUES ' +
        '  (:CODOPE, :CHAVE, :CONFIG, CURRENT_TIMESTAMP)';
    end;

    Qry.ParamByName('CODOPE').AsString := FCodOperador;
    Qry.ParamByName('CHAVE').AsString := AChave;
    Qry.ParamByName('CONFIG').AsString := AJsonConfig;

    Qry.ExecSQL;
  finally
    Qry.Free;
  end;
end;

function TGridConfigManagerDB.ConfigExistsInDB(const AChave: string): Boolean;
var
  Qry: TUniQuery;
begin
  Qry := fCriaQuery;
  try
    Qry.SQL.Text :=
      'SELECT COUNT(*) AS QTD ' +
      'FROM CONFIGURACAO_GRID ' +
      'WHERE GRD_CODOPE = :CODOPE ' +
      '  AND GRD_CHAVE = :CHAVE';

    Qry.ParamByName('CODOPE').AsString := FCodOperador;
    Qry.ParamByName('CHAVE').AsString := AChave;
    Qry.Open;

    Result := Qry.FieldByName('QTD').AsInteger > 0;
  finally
    Qry.Free;
  end;
end;

function TGridConfigManagerDB.FindBandByCaption(
  AView: TcxGridDBBandedTableView; const ACaption: string): TcxGridBand;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to AView.Bands.Count - 1 do
  begin
    if SameText(AView.Bands[I].Caption, ACaption) then
    begin
      Result := AView.Bands[I];
      Break;
    end;
  end;
end;

procedure TGridConfigManagerDB.MergeConfigs(AExistingConfig, ANewConfig: TGridConfig);
var
  NewBand, ExistingBand: TBandConfig;
  NewCol, ExistingCol: TColumnConfig;
  J: Integer;
begin
  // Para cada banda da nova configuração
  for NewBand in ANewConfig.Bands do
  begin
    // Procurar banda correspondente na configuração existente
    ExistingBand := AExistingConfig.FindBand(NewBand.Caption);

    if Assigned(ExistingBand) then
    begin
      // Banda existe: atualizar propriedades da banda
      ExistingBand.Width := NewBand.Width;
      ExistingBand.Visible := NewBand.Visible;
      ExistingBand.Position := NewBand.Position;
      ExistingBand.FixedKind := NewBand.FixedKind;

      // Fazer merge das colunas desta banda
      for NewCol in NewBand.Columns do
      begin
        ExistingCol := ExistingBand.FindColumn(NewCol.FieldName);

        if Assigned(ExistingCol) then
        begin
          // Coluna existe: atualizar
          ExistingCol.Width := NewCol.Width;
          ExistingCol.Visible := NewCol.Visible;
          ExistingCol.Position := NewCol.Position;
          ExistingCol.BandCaption := NewCol.BandCaption;
          ExistingCol.BandIndex := NewCol.BandIndex;
          ExistingCol.RowIndex := NewCol.RowIndex;
          ExistingCol.SortOrder := NewCol.SortOrder;
          ExistingCol.SortIndex := NewCol.SortIndex;
        end
        else
        begin
          // Coluna não existe: adicionar nova
          // Primeiro, verificar se a coluna já está presente em outra banda
          for J := 0 to AExistingConfig.Bands.Count - 1 do
          begin
            if AExistingConfig.Bands[J] <> ExistingBand then
            begin
              // Se já existe em outra banda, remover de lá
              ExistingCol := AExistingConfig.Bands[J].FindColumn(NewCol.FieldName);
              if Assigned(ExistingCol) then
              begin
                AExistingConfig.Bands[J].Columns.Remove(ExistingCol);
                Break; // Se encontrar, remove e não continua procurando em outras bandas
              end;
            end;
          end;

          // Adiciona a coluna à banda atual
          ExistingCol := TColumnConfig.Create;
          ExistingCol.FieldName := NewCol.FieldName;
          ExistingCol.Width := NewCol.Width;
          ExistingCol.Visible := NewCol.Visible;
          ExistingCol.Position := NewCol.Position;
          ExistingCol.BandCaption := NewCol.BandCaption;
          ExistingCol.BandIndex := NewCol.BandIndex;
          ExistingCol.RowIndex := NewCol.RowIndex;
          ExistingCol.SortOrder := NewCol.SortOrder;
          ExistingCol.SortIndex := NewCol.SortIndex;
          ExistingBand.Columns.Add(ExistingCol);
        end;
      end;
      // Colunas que existem no banco mas não na nova configuração são MANTIDAS
    end
    else
    begin
      // Banda não existe: adicionar toda a banda nova com suas colunas
      ExistingBand := TBandConfig.Create;
      ExistingBand.Caption := NewBand.Caption;
      ExistingBand.Width := NewBand.Width;
      ExistingBand.Visible := NewBand.Visible;
      ExistingBand.Position := NewBand.Position;
      ExistingBand.FixedKind := NewBand.FixedKind;

      // Copiar todas as colunas
      for NewCol in NewBand.Columns do
      begin
        ExistingCol := TColumnConfig.Create;
        ExistingCol.FieldName := NewCol.FieldName;
        ExistingCol.Width := NewCol.Width;
        ExistingCol.Visible := NewCol.Visible;
        ExistingCol.Position := NewCol.Position;
        ExistingCol.BandCaption := NewCol.BandCaption;
        ExistingCol.BandIndex := NewCol.BandIndex;
        ExistingCol.RowIndex := NewCol.RowIndex;
        ExistingCol.SortOrder := NewCol.SortOrder;
        ExistingCol.SortIndex := NewCol.SortIndex;
        ExistingBand.Columns.Add(ExistingCol);
      end;

      AExistingConfig.Bands.Add(ExistingBand);
    end;
  end;

  // Bandas que existem no banco mas não na nova configuração são MANTIDAS automaticamente

  // Atualizar filtro
  AExistingConfig.Filter.Active := ANewConfig.Filter.Active;
  AExistingConfig.Filter.FilterText := ANewConfig.Filter.FilterText;

  // Atualizar data de salvamento
  AExistingConfig.SaveDate := ANewConfig.SaveDate;
end;


procedure TGridConfigManagerDB.ApplyConfigSmart(AConfig: TGridConfig;
  AView: TcxGridDBBandedTableView);
var
  BandConfig: TBandConfig;
  ColConfig: TColumnConfig;
  Band: TcxGridBand;
  Col: TcxGridDBBandedColumn;
  I: Integer;
begin
  AView.BeginUpdate;
  try
    // 1. Aplicar configurações das bandas (ignora bandas inexistentes)
    for BandConfig in AConfig.Bands do
    begin



      Band := FindBandByCaption(AView, BandConfig.Caption);

      if Assigned(Band) then
      begin
        try
          Band.Width := BandConfig.Width;
          Band.Visible := BandConfig.Visible;
          Band.FixedKind := BandConfig.FixedKind;
         if BandConfig.Position < AView.Bands.Count then
            Band.Index := BandConfig.Position;
        except
          // Ignora erros individuais
        end;

        // 2. Limpar ordenação anterior das colunas desta banda
        for I := 0 to AView.ColumnCount - 1 do
        begin
          Col := AView.Columns[I] as TcxGridDBBandedColumn;
          if Assigned(Col.Position.Band) and (Col.Position.Band = Band) then
          begin
            Col.SortOrder := soNone;
            Col.SortIndex := -1;
          end;
        end;



        // 3. Aplicar cada coluna desta banda (ignora colunas inexistentes)
        for ColConfig in BandConfig.Columns do
        begin
          Col := AView.GetColumnByFieldName(ColConfig.FieldName) as TcxGridDBBandedColumn;

          if Assigned(Col) then
          begin
            try
              Col.Width := ColConfig.Width;
              Col.Visible := ColConfig.Visible;

              // Posicionar coluna NA BANDA CORRETA
              Col.Position.BandIndex := Band.Index;
              Col.Position.RowIndex := ColConfig.RowIndex;
              Col.Position.ColIndex := ColConfig.Position;

              // Aplicar ordenação
              if ColConfig.SortOrder <> soNone then
              begin
                Col.SortIndex := ColConfig.SortIndex;
                Col.SortOrder := ColConfig.SortOrder;
              end;
            except
              // Ignora erros individuais e continua
            end;
          end;
          // Se a coluna não existe no grid atual: simplesmente ignora
        end;
      end;
      // Se a banda não existe no grid atual: simplesmente ignora
    end;

    // 4. Aplicar filtro (se possível)
    try
      AView.DataController.Filter.Active := False;
      AView.DataController.Filter.Clear;

      if AConfig.Filter.Active and (AConfig.Filter.FilterText <> '') then
      begin
        AView.DataController.Filter.FilterText := AConfig.Filter.FilterText;
        AView.DataController.Filter.Active := True;
      end;
    except
      // Se filtro falhar, continua sem ele
    end;

  finally
    AView.EndUpdate;
  end;
end;

procedure TGridConfigManagerDB.SaveConfig(AView: TcxGridDBBandedTableView;
  const AChave: string);
var
  NewConfig, ExistingConfig: TGridConfig;
  Col: TcxGridDBBandedColumn;
  Band: TcxGridBand;
  ColConfig: TColumnConfig;
  BandConfig: TBandConfig;
  I, J: Integer;
  JsonText, ExistingJson: string;
begin
  NewConfig := TGridConfig.Create;
  try
    NewConfig.GridName := AChave;
    NewConfig.SaveDate := Now;

    // Capturar configuração atual do grid
    for I := 0 to AView.Bands.Count - 1 do
    begin
      Band := AView.Bands[I];
      BandConfig := TBandConfig.Create;
      BandConfig.Caption := Band.Caption;
      BandConfig.Width := Band.Width;
      BandConfig.Visible := Band.Visible;
      BandConfig.Position := I;
      BandConfig.FixedKind := Band.FixedKind;

      // Adicionar colunas desta banda
      for J := 0 to AView.ColumnCount - 1 do
      begin
        Col := AView.Columns[J] as TcxGridDBBandedColumn;

        // Se a coluna pertence a esta banda
        if Assigned(Col.Position.Band) and
           (Col.Position.Band.Index = Band.Index) and
           (Col.DataBinding.FieldName <> '') then
        begin
          ColConfig := TColumnConfig.Create;
          ColConfig.FieldName := Col.DataBinding.FieldName;
          ColConfig.Width := Col.Width;
          ColConfig.Visible := Col.Visible;
          ColConfig.Position := Col.Position.ColIndex;
          ColConfig.BandCaption := Band.Caption;
          ColConfig.BandIndex := Band.Index;
          ColConfig.RowIndex := Col.Position.RowIndex;
          ColConfig.SortOrder := Col.SortOrder;
          ColConfig.SortIndex := Col.SortIndex;

          BandConfig.Columns.Add(ColConfig);
        end;
      end;

      NewConfig.Bands.Add(BandConfig);
    end;

    // Salvar filtro
    NewConfig.Filter.Active := AView.DataController.Filter.Active;
    NewConfig.Filter.FilterText := AView.DataController.Filter.FilterText;

    // MERGE: Carregar configuração existente e fazer merge
    ExistingJson := LoadConfigFromDB(AChave);

    if ExistingJson <> '' then
    begin
      // Existe configuração no banco: fazer MERGE
      ExistingConfig := TGridConfig.Create;
      try
        ExistingConfig.FromJSON(ExistingJson);

        // Fazer merge: atualiza existing com new, mantém o que não está em new
        MergeConfigs(ExistingConfig, NewConfig);

        // Salvar o resultado do merge
        JsonText := ExistingConfig.ToJSON;
      finally
        ExistingConfig.Free;
      end;
    end
    else
    begin
      // Não existe: salvar direto
      JsonText := NewConfig.ToJSON;
    end;

    SaveConfigToDB(AChave, JsonText);
  finally
    NewConfig.Free;
  end;
end;

function TGridConfigManagerDB.LoadConfig(AView: TcxGridDBBandedTableView;
  const AChave: string): Boolean;
var
  JsonText: string;
  Config: TGridConfig;
begin
  Result := False;

  // Carregar JSON do banco
  JsonText := LoadConfigFromDB(AChave);
  if JsonText = '' then
    Exit;

  Config := TGridConfig.Create;
  try
    // Parse do JSON
    Config.FromJSON(JsonText);

    // Aplicar configuração (ignora campos e bandas inexistentes automaticamente)
    ApplyConfigSmart(Config, AView);

    Result := True;
  finally
    Config.Free;
  end;
end;

function TGridConfigManagerDB.ExportToJSON(
  AView: TcxGridDBBandedTableView): string;
var
  Config: TGridConfig;
  Col: TcxGridDBBandedColumn;
  Band: TcxGridBand;
  ColConfig: TColumnConfig;
  BandConfig: TBandConfig;
  I, J: Integer;
begin
  Config := TGridConfig.Create;
  try
    Config.GridName := AView.Name;
    Config.SaveDate := Now;

    // Salvar bandas E suas colunas
    for I := 0 to AView.Bands.Count - 1 do
    begin
      Band := AView.Bands[I];
      BandConfig := TBandConfig.Create;
      BandConfig.Caption := Band.Caption;
      BandConfig.Width := Band.Width;
      BandConfig.Visible := Band.Visible;
      BandConfig.Position := Band.Position.BandIndex;
      BandConfig.FixedKind := Band.FixedKind;

      // Adicionar colunas desta banda
      for J := 0 to AView.ColumnCount - 1 do
      begin
        Col := AView.Columns[J] as TcxGridDBBandedColumn;

        if Assigned(Col.Position.Band) and
           (Col.Position.Band.Index = Band.Index) and
           (Col.DataBinding.FieldName <> '') then
        begin
          ColConfig := TColumnConfig.Create;
          ColConfig.FieldName := Col.DataBinding.FieldName;
          ColConfig.Width := Col.Width;
          ColConfig.Visible := Col.Visible;
          ColConfig.Position := Col.Position.ColIndex;
          ColConfig.BandCaption := Band.Caption;
          ColConfig.BandIndex := Band.Index;
          ColConfig.RowIndex := Col.Position.RowIndex;
          ColConfig.SortOrder := Col.SortOrder;
          ColConfig.SortIndex := Col.SortIndex;

          BandConfig.Columns.Add(ColConfig);
        end;
      end;

      Config.Bands.Add(BandConfig);
    end;

    Config.Filter.Active := AView.DataController.Filter.Active;
    Config.Filter.FilterText := AView.DataController.Filter.FilterText;

    Result := Config.ToJSON;
  finally
    Config.Free;
  end;
end;

procedure TGridConfigManagerDB.ImportFromJSON(AView: TcxGridDBBandedTableView;
  const AJson: string);
var
  Config: TGridConfig;
begin
  Config := TGridConfig.Create;
  try
    Config.FromJSON(AJson);
    ApplyConfigSmart(Config, AView);
  finally
    Config.Free;
  end;
end;

procedure TGridConfigManagerDB.DeleteConfig(const AChave: string);
var
  Qry: TUniQuery;
begin
  Qry := fCriaQuery;
  try
    Qry.SQL.Text :=
      'DELETE FROM CONFIGURACAO_GRID ' +
      'WHERE GRD_CODOPE = :CODOPE ' +
      '  AND GRD_CHAVE = :CHAVE';

    Qry.ParamByName('CODOPE').AsString := FCodOperador;
    Qry.ParamByName('CHAVE').AsString := AChave;
    Qry.ExecSQL;
  finally
    Qry.Free;
  end;
end;

function TGridConfigManagerDB.ListConfigurations: TArray<string>;
var
  Qry: TUniQuery;
  List: TStringList;
  I: Integer;
begin
  List := TStringList.Create;
  try
    Qry := fCriaQuery;
    try
      Qry.SQL.Text :=
        'SELECT GRD_CHAVE ' +
        'FROM CONFIGURACAO_GRID ' +
        'WHERE GRD_CODOPE = :CODOPE ' +
        'ORDER BY GRD_CHAVE';

      Qry.ParamByName('CODOPE').AsString := FCodOperador;
      Qry.Open;

      while not Qry.Eof do
      begin
        List.Add(Qry.FieldByName('GRD_CHAVE').AsString);
        Qry.Next;
      end;
    finally
      Qry.Free;
    end;

    SetLength(Result, List.Count);
    for I := 0 to List.Count - 1 do
      Result[I] := List[I];
  finally
    List.Free;
  end;
end;

end.