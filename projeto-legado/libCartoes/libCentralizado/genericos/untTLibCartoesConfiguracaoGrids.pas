unit untTLibCartoesConfiguracaoGrids;

interface

Uses
  Vcl.DBGrids, System.Classes, SysUtils, Data.DB,
  Datasnap.DBClient,

  UniClientDataSet, Uni, cxGrid, cxGridDBTableView,

  untcxGridDBColumnHelper, untTLibCartoesFuncoes;

Type
  TColunasGridCfg = Record
    FieldName,
    Caption: String;

    Width,
    Indice: Integer;

    Visible: Boolean;

    Alignment: TAlignment;
  end;

Type
  TColunasGridCfgArray = Array Of TColunasGridCfg;

Type
  TConfiguracaoGrids = Class
  private
    FColunasCfgArray,
    FColunasCfgOriginaisArray: TColunasGridCfgArray;

    FCamposIgnorados: TStringList;

    FMaxWidthGrid,
    FUtiWidthGrid: Integer;

    FChaveGrid: String;

    FConfiguracaoOperador: Boolean;

    procedure SalvaEstadoPadrao(AViewDados: TcxGridDBTableView);
  public
    constructor Create(const AcxGrid: TcxGrid;
                       AViewDados: TcxGridDBTableView;
                       AChaveGrid: String;
                       ACamposIgnorados: Array Of String); overload;

    destructor Destroy; override;

    procedure SalvarEstado(AViewDados: TcxGridDBTableView; var AColunasArray: TColunasGridCfgArray);

    procedure CarregarDadosSalvos(AViewDados: TcxGridDBTableView);
    procedure CarregarDadosOriginais(AViewDados: TcxGridDBTableView);
    procedure GravarDados(AColunasArray: TColunasGridCfgArray; AApenasOperador: Boolean);

    procedure SetaEstado(AViewDados: TcxGridDBTableView; var AColunasArray: TColunasGridCfgArray);

    procedure SetarUltimosDadosCarregados(AViewDados: TcxGridDBTableView);
    procedure SetarPadrao(AViewDados: TcxGridDBTableView);

    property ConfiguracaoOperador: Boolean read FConfiguracaoOperador write FConfiguracaoOperador;
    property ChaveGrid: String read FChaveGrid write FChaveGrid;
    property ColunasCfgOriginaisArray: TColunasGridCfgArray read FColunasCfgOriginaisArray;
  End;

implementation

{ TConfiguracaoGrids }

constructor TConfiguracaoGrids.Create(const AcxGrid: TcxGrid;
  AViewDados: TcxGridDBTableView; AChaveGrid: String;
  ACamposIgnorados: array of String);
  Var
    LCampoIgnorado: String;
begin
  FChaveGrid := AChaveGrid;

  FCamposIgnorados := TStringList.Create;
  For LCampoIgnorado In ACamposIgnorados Do
    FCamposIgnorados.Add(LCampoIgnorado);

  FMaxWidthGrid := AcxGrid.Width;
  SalvaEstadoPadrao(AViewDados);
  CarregarDadosSalvos(AViewDados);
end;

destructor TConfiguracaoGrids.Destroy;
begin
  FreeAndNil(FCamposIgnorados);
end;

procedure TConfiguracaoGrids.GravarDados(AColunasArray: TColunasGridCfgArray; AApenasOperador: Boolean);
  Var
    LDataset: TUniQuery;

    LIndice : Integer;

    LColunaCfg: TColunasGridCfg;

    LCampoGravado: Boolean;
begin
  LDataset := VS_FuncoesExternas.fICriaQuery;

  VS_FuncoesExternas.fIStartTransaction;

  try
    try
      If FConfiguracaoOperador Then
      Begin
        If Not AApenasOperador Then
        Begin
          LDataset.SQL.Text := 'DELETE FROM CFGCOL_GRD ' +
                               'WHERE GRD_CHAVE_ = :CHAVE_ ' +
                               '  AND GRD_CODEMP = :CODEMP ' +
                               '  AND GRD_CODOPE = :CODOPE ';

          LDataset.ParamByName('CHAVE_').AsString := FChaveGrid;
          LDataset.ParamByName('CODEMP').AsString := VS_FuncoesExternas.fIRetEmpresaLogada;
          LDataset.ParamByName('CODOPE').AsString := VS_FuncoesExternas.fIRetOperadorLogado;

          LDataset.ExecSQL;
        End;
      End;


      LDataset.Close;
      LDataset.SQL.Text := 'SELECT * FROM CFGCOL_GRD ' +
                           'WHERE GRD_CHAVE_ = :CHAVE_ ' +
                           '  AND GRD_CODEMP = :CODEMP ';

      If Not AApenasOperador Then
        LDataset.SQL.Add('  AND GRD_CODOPE IS NULL ')
      Else
      Begin
        LDataset.SQL.Add('  AND GRD_CODOPE = :CODOPE ');

        LDataset.ParamByName('CODOPE').AsString := VS_FuncoesExternas.fIRetOperadorLogado;
      End;

      LDataset.ParamByName('CHAVE_').AsString := FChaveGrid;
      LDataset.ParamByName('CODEMP').AsString := VS_FuncoesExternas.fIRetEmpresaLogada;

      LDataset.Open;

      FConfiguracaoOperador := AApenasOperador;

      LIndice := 0;

      For LColunaCfg In AColunasArray Do
      Begin
        LCampoGravado := LDataset.Locate('GRD_COLFLD', LColunaCfg.FieldName, []);

        If LColunaCfg.Visible Then
        Begin
          If Not LCampoGravado Then
          Begin
            LDataset.Append;
            LDataset.FieldByName('AUTOINCREM').AsString  := VS_FuncoesExternas.fIRetAutoIncrem('CFGCOL_GRD', VS_FuncoesExternas.fIRetEmpresaLogada);
          End
          Else
            LDataset.Edit;

          LDataset.FieldByName('GRD_CHAVE_').AsString  := FChaveGrid;
          LDataset.FieldByName('GRD_CODEMP').AsString  := VS_FuncoesExternas.fIRetEmpresaLogada;

          If FConfiguracaoOperador Then
            LDataset.FieldByName('GRD_CODOPE').AsString  := VS_FuncoesExternas.fIRetOperadorLogado;

          LDataset.FieldByName('GRD_COLFLD').AsString  := LColunaCfg.FieldName;
          LDataset.FieldByName('GRD_COLCAP').AsString  := LColunaCfg.Caption;
          LDataset.FieldByName('GRD_COLORD').AsInteger := LIndice;
          LDataset.FieldByName('GRD_COLTAM').AsInteger := LColunaCfg.Width;
          LDataset.Post;

          Inc(LIndice);
        end
        Else If LCampoGravado Then
          LDataset.Delete;
      End;

      VS_FuncoesExternas.fICommit;
    except
      on E: Exception do
      begin
        VS_FuncoesExternas.fIRollBack;
        VS_FuncoesExternas.pIMensagensErro(E.Message, '[TConfiguracaoGrids.GravarDados]');
      end;
    end;
  finally
    FreeAndNil(LDataset);
  end;
end;

procedure TConfiguracaoGrids.CarregarDadosOriginais(
  AViewDados: TcxGridDBTableView);
  Var
    LContador,
    LIndiceArray: Integer;

    LValorArrOriginal: TColunasGridCfg;

    LColunaGrid: TcxGridDBColumn;

    LDataSource: TDataSource;
begin
  SetLength(FColunasCfgArray, 0);

  LDataSource := AViewDados.DataController.DataSource;
  AViewDados.DataController.DataSource := Nil;

  Try
    For LContador := 0 To AViewDados.ColumnCount -1 Do
      AViewDados.Columns[LContador].Visible := False;

    For LValorArrOriginal In FColunasCfgOriginaisArray Do
    Begin
      LColunaGrid := TcxGridDBColumnHelper.fFindColumnByNameView(AViewDados, LValorArrOriginal.FieldName);

      if (LColunaGrid <> nil) then
      begin
        LColunaGrid.Visible := True;
        LColunaGrid.Index   := LValorArrOriginal.Indice;
        LColunaGrid.Caption := LValorArrOriginal.Caption;
        LColunaGrid.Width   := LValorArrOriginal.Width;
        LColunaGrid.Visible := LValorArrOriginal.Visible;

        FUtiWidthGrid := FUtiWidthGrid + LColunaGrid.Width;

        SetLength(FColunasCfgArray, Length(FColunasCfgArray) + 1);
        LIndiceArray := Length(FColunasCfgArray) - 1;

        FColunasCfgArray[LIndiceArray].FieldName := LColunaGrid.DataBinding.FieldName;
        FColunasCfgArray[LIndiceArray].Caption   := LColunaGrid.Caption;
        FColunasCfgArray[LIndiceArray].Width     := LColunaGrid.Width;
        FColunasCfgArray[LIndiceArray].Visible   := LColunaGrid.Visible;
        FColunasCfgArray[LIndiceArray].Alignment := LColunaGrid.DataBinding.Field.Alignment;
        FColunasCfgArray[LIndiceArray].Indice    := LColunaGrid.Index;
      End;
    End;
  Finally
    AViewDados.DataController.DataSource := LDataSource;
  End;
end;

procedure TConfiguracaoGrids.CarregarDadosSalvos(
  AViewDados: TcxGridDBTableView);
  Var
    LContador,
    LIndice,
    LIndiceArray: Integer;

    LConsulta: TUniQuery;

    LColunaGrid: TcxGridDBColumn;

    LDataSource: TDataSource;
begin
  LConsulta := VS_FuncoesExternas.fICriaQuery;

  try
    LConsulta.SQL.Text := 'SHOW TABLES LIKE "CFGCOL_GRD"';
    LConsulta.Open;

    If LConsulta.IsEmpty Then
    Begin
      CarregarDadosOriginais(AViewDados);
      Exit;
    End;

    LConsulta.Close;
    LConsulta.SQL.Text := 'SELECT * ' +
                          'FROM CFGCOL_GRD ' +
                          'WHERE GRD_CHAVE_ = :CHAVE_ ' +
                          '  AND GRD_CODEMP = :CODEMP ' +
                          '  AND GRD_CODOPE = :CODOPE ' +
                          'ORDER BY GRD_COLORD ';

    LConsulta.ParamByName('CHAVE_').AsString := FChaveGrid;
    LConsulta.ParamByName('CODEMP').AsString := VS_FuncoesExternas.fIRetEmpresaLogada;
    LConsulta.ParamByName('CODOPE').AsString := VS_FuncoesExternas.fIRetOperadorLogado;
    LConsulta.Open;

    FConfiguracaoOperador := True;

    If LConsulta.IsEmpty Then
    Begin
      LConsulta.Close;
      LConsulta.SQL.Text := 'SELECT * ' +
                            'FROM CFGCOL_GRD ' +
                            'WHERE GRD_CHAVE_ = :CHAVE_ ' +
                            '  AND GRD_CODEMP = :CODEMP ' +
                            '  AND GRD_CODOPE IS NULL ' +
                            'ORDER BY GRD_COLORD ';

      LConsulta.ParamByName('CHAVE_').AsString := FChaveGrid;
      LConsulta.ParamByName('CODEMP').AsString := VS_FuncoesExternas.fIRetEmpresaLogada;
      LConsulta.Open;

      FConfiguracaoOperador := False;
    End;

    SetLength(FColunasCfgArray, 0);

    If Not LConsulta.IsEmpty Then
    Begin
      LDataSource := AViewDados.DataController.DataSource;
      AViewDados.DataController.DataSource := Nil;

      Try
        For LContador := 0 To AViewDados.ColumnCount -1 Do
          AViewDados.Columns[LContador].Visible := False;

        LIndice := 0;
        FUtiWidthGrid := 0;

        LConsulta.First;

        While Not LConsulta.Eof Do
        Begin
          LColunaGrid := TcxGridDBColumnHelper.fFindColumnByNameView(AViewDados, LConsulta.FieldByName('GRD_COLFLD').AsString);

          if (LColunaGrid <> nil) then
          begin
            LColunaGrid.Visible := True;
            LColunaGrid.Index   := LIndice;
            LColunaGrid.Caption := LConsulta.FieldByName('GRD_COLCAP').AsString;
            LColunaGrid.Width   := LConsulta.FieldByName('GRD_COLTAM').AsInteger;

            FUtiWidthGrid := FUtiWidthGrid + LColunaGrid.Width;

            SetLength(FColunasCfgArray, Length(FColunasCfgArray) + 1);
            LIndiceArray := Length(FColunasCfgArray) - 1;

            FColunasCfgArray[LIndiceArray].FieldName := LColunaGrid.DataBinding.FieldName;
            FColunasCfgArray[LIndiceArray].Caption   := LColunaGrid.Caption;
            FColunasCfgArray[LIndiceArray].Width     := LColunaGrid.Width;
            FColunasCfgArray[LIndiceArray].Visible   := LColunaGrid.Visible;
            FColunasCfgArray[LIndiceArray].Alignment := LColunaGrid.DataBinding.Field.Alignment;
            FColunasCfgArray[LIndiceArray].Indice    := LColunaGrid.Index;

            Inc(LIndice);
          End;

          LConsulta.Next;
        End;
      Finally
        AViewDados.DataController.DataSource := LDataSource;
      End;
    end
    Else
      CarregarDadosOriginais(AViewDados);
  finally
    FreeAndNil(LConsulta);
  end;
end;

procedure TConfiguracaoGrids.SalvaEstadoPadrao(
  AViewDados: TcxGridDBTableView);
begin
  SalvarEstado(AViewDados, FColunasCfgOriginaisArray);
end;

procedure TConfiguracaoGrids.SalvarEstado(AViewDados: TcxGridDBTableView;
  var AColunasArray: TColunasGridCfgArray);
  Var
    LIndice,
    LTamanhoArray: Integer;
begin
  SetLength(FColunasCfgArray, 0);

  for LIndice := 0 To Pred(AViewDados.ColumnCount) Do
  begin
    If AViewDados.Columns[LIndice].DataBinding.FieldName.IsEmpty Then
      Continue;

    If FCamposIgnorados.IndexOf(AViewDados.Columns[LIndice].DataBinding.FieldName) > -1 Then
      Continue;

    SetLength(AColunasArray, Length(AColunasArray) + 1);

    LTamanhoArray := Length(AColunasArray) - 1;

    AColunasArray[LTamanhoArray].Indice    := AViewDados.Columns[LIndice].Index;
    AColunasArray[LTamanhoArray].FieldName := AViewDados.Columns[LIndice].DataBinding.FieldName;
    AColunasArray[LTamanhoArray].Caption   := AViewDados.Columns[LIndice].Caption;
    AColunasArray[LTamanhoArray].Width     := AViewDados.Columns[LIndice].Width;
    AColunasArray[LTamanhoArray].Visible   := AViewDados.Columns[LIndice].Visible;
    AColunasArray[LTamanhoArray].Alignment := AViewDados.Columns[LIndice].DataBinding.Field.Alignment;
  end;
end;

procedure TConfiguracaoGrids.SetaEstado(AViewDados: TcxGridDBTableView;
  var AColunasArray: TColunasGridCfgArray);
  Var
    LContador: Integer;

    LColunaGrid: TcxGridDBColumn;

    LDataSource: TDataSource;
begin
  LDataSource := AViewDados.DataController.DataSource;
  AViewDados.DataController.DataSource := Nil;

  Try
    For LContador := 0 To Pred(AViewDados.ColumnCount) Do
      AViewDados.Columns[LContador].Visible := False;

    For LContador := Low(AColunasArray) To High(AColunasArray) Do
    Begin
      If Not AColunasArray[LContador].Visible Then
        Continue;

      LColunaGrid := TcxGridDBColumnHelper.fFindColumnByNameView(AViewDados, AColunasArray[LContador].FieldName);
      If LColunaGrid = Nil Then
        Continue;

      LColunaGrid.Index                       := AColunasArray[LContador].Indice;
      LColunaGrid.DataBinding.FieldName       := AColunasArray[LContador].FieldName;
      LColunaGrid.Caption                     := AColunasArray[LContador].Caption;
      LColunaGrid.Width                       := AColunasArray[LContador].Width;
      LColunaGrid.Visible                     := AColunasArray[LContador].Visible;
      LColunaGrid.DataBinding.Field.Alignment := AColunasArray[LContador].Alignment;
    End;
  Finally
    AViewDados.DataController.DataSource := LDataSource;
  End;
end;

procedure TConfiguracaoGrids.SetarPadrao(AViewDados: TcxGridDBTableView);
begin
  SetaEstado(AViewDados, FColunasCfgOriginaisArray);
end;

procedure TConfiguracaoGrids.SetarUltimosDadosCarregados(
  AViewDados: TcxGridDBTableView);
begin
  If (Length(FColunasCfgArray) > 0) then
    SetaEstado(AViewDados, FColunasCfgArray);
end;

end.
