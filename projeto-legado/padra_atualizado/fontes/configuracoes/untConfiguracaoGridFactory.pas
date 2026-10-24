unit untConfiguracaoGridFactory;

interface

uses
  untCfgGrids, DBGridCitel, System.Classes, System.SysUtils, System.StrUtils,
  untFuncoesSimples, cxGridDBTableView, System.Generics.Collections;

type
  TConfiguracaoGridFactory = class
  private
    strCodigoOperador           : String;
    strNomeFormulario           : String;

    dicGrids                    : TDictionary<String,TObject>;
    dicConfiguracaoGridOriginal : TDictionary<String,TConfiguracaoGrid>;

    procedure pAddConfiguracaoGrid(const strNomeGrid,
      strConfiguracoesColunas: String);

    function fRetornarConfiguracaoGrid(const grid: TObject): String;

    procedure pCarregarConfiguracaoGrid(const grid: TObject;
      const configuracaoGrid: TConfiguracaoGrid);

  public
    constructor Create;
    destructor Destroy; override;

    function SetCodigoOperador(
      const ACodigoOperador: String): TConfiguracaoGridFactory;

    function SetNomeFormulario(
      const ANomeFormulario: String): TConfiguracaoGridFactory;

    function fAddGridConfiguracao(
      const dbgCitel: TDBGridCitel): TConfiguracaoGridFactory; overload;

    function fAddGridConfiguracao(
      const dbgCxGrid: TcxGridDBTableView): TConfiguracaoGridFactory; overload;

    function fRestaurarConfiguracaoOriginalGrid(
      const strNomeGrid: String=''): TConfiguracaoGridFactory;

    function fGravarConfiguracaoGrids: TConfiguracaoGridFactory;
    function fDeletarConfiguracaoGrids: TConfiguracaoGridFactory;
    function fCarregarConfiguraoGrids: TConfiguracaoGridFactory;
  end;

implementation

{ TConfiguracaoGridFactory }

constructor TConfiguracaoGridFactory.Create;
begin
  dicGrids                    := TDictionary<String, TObject>.Create;
  dicConfiguracaoGridOriginal := TDictionary<String,TConfiguracaoGrid>.Create;
end;

destructor TConfiguracaoGridFactory.Destroy;
begin
  FreeAndNil(dicGrids);
  FreeAndNil(dicConfiguracaoGridOriginal);

  inherited;
end;

function TConfiguracaoGridFactory.fAddGridConfiguracao(
  const dbgCitel: TDBGridCitel): TConfiguracaoGridFactory;
begin
  Result := Self;

  If Not dicGrids.ContainsKey(dbgCitel.Name) Then
  Begin
    dicGrids.Add(dbgCitel.Name, dbgCitel);
    pAddConfiguracaoGrid(dbgCitel.Name, fRetornarConfiguracaoGrid(dbgCitel));
  End;
end;

procedure TConfiguracaoGridFactory.pAddConfiguracaoGrid(const strNomeGrid,
  strConfiguracoesColunas: String);
var
  LConfiguracaoGrid : TConfiguracaoGrid;
begin
  LConfiguracaoGrid := TConfiguracaoGrid.Create;
  LConfiguracaoGrid.CodigoOperador       := strCodigoOperador;
  LConfiguracaoGrid.NomeFormulario       := strNomeFormulario;
  LConfiguracaoGrid.NomeGrid             := strNomeGrid;
  LConfiguracaoGrid.ConfiguracoesColunas := strConfiguracoesColunas;

  dicConfiguracaoGridOriginal.Add(strNomeGrid, LConfiguracaoGrid);
end;

function TConfiguracaoGridFactory.fAddGridConfiguracao(
  const dbgCxGrid: TcxGridDBTableView): TConfiguracaoGridFactory;
begin
  Result := Self;

  If Not dicGrids.ContainsKey(dbgCxGrid.Name) Then
  Begin
    dicGrids.Add(dbgCxGrid.Name, dbgCxGrid);

    pAddConfiguracaoGrid(dbgCxGrid.Name, fRetornarConfiguracaoGrid(dbgCxGrid));
  End;
end;

procedure TConfiguracaoGridFactory.pCarregarConfiguracaoGrid(
  const grid: TObject; const configuracaoGrid: TConfiguracaoGrid);
var
  LStream : TStringStream;
begin
  If (Not Assigned(grid)) Or (Not Assigned(configuracaoGrid)) Then
    Exit;

   LStream := TStringStream.Create(configuracaoGrid.ConfiguracoesColunas);
  Try
    If (grid is TDBGridCitel) Then
      TDBGridCitel(grid).Columns.LoadFromStream(LStream)
    Else
    If (grid is TcxGridDBTableView) Then
      TcxGridDBTableView(grid).RestoreFromStream(LStream);
  Finally
    FreeAndNil(LStream);
  End;
end;

function TConfiguracaoGridFactory.fRetornarConfiguracaoGrid(
  const grid: TObject): String;
var
  LStream : TStringStream;
begin
  Result := EmptyStr;
  LStream := TStringStream.Create;
  Try
    If (grid Is TDBGridCitel) Then
      TDBGridCitel(grid).Columns.SaveToStream(LStream)
    Else
    If (grid Is TcxGridDBTableView) Then
      TcxGridDBTableView(grid).StoreToStream(LStream);

    Result := LStream.DataString;
  Finally
    FreeAndNil(LStream);
  End;
end;

function TConfiguracaoGridFactory.SetCodigoOperador(
  const ACodigoOperador: String): TConfiguracaoGridFactory;
begin
  Result            := Self;
  strCodigoOperador := ACodigoOperador;
end;

function TConfiguracaoGridFactory.SetNomeFormulario(
  const ANomeFormulario: String): TConfiguracaoGridFactory;
begin
  Result            := Self;
  strNomeFormulario := ANomeFormulario;
end;

function TConfiguracaoGridFactory.fCarregarConfiguraoGrids: TConfiguracaoGridFactory;
var
  LKey              : String;
  LCfgGrid          : TCfgGrid;
  LConfiguracaoGrid : TConfiguracaoGrid;
begin
  Result := Self;

  LCfgGrid := TCfgGrid.Create;
  Try
    For LKey In dicGrids.Keys Do
    Begin
      Try
        LConfiguracaoGrid := LCfgGrid.fDadosConfiguracaoGrid(strCodigoOperador,
                               strNomeFormulario, LKey);

        pCarregarConfiguracaoGrid(dicGrids.Items[LKey], LConfiguracaoGrid);
      Finally
        If Assigned(LConfiguracaoGrid) Then
          FreeAndNil(LConfiguracaoGrid);
      End;
    End;
  Finally
    FreeAndNil(LCfgGrid);
  End;
end;

function TConfiguracaoGridFactory.fGravarConfiguracaoGrids: TConfiguracaoGridFactory;
var
  LKey              : String;
  LCfgGrid          : TCfgGrid;
  LConfiguracaoGrid : TConfiguracaoGrid;
  LGravado          : Boolean;
begin
  Result := Self;

  Try
    LCfgGrid := TCfgGrid.Create;
    Try
      fStartTransaction;

      LGravado := False;
      For LKey In dicGrids.Keys Do
      Begin
        LConfiguracaoGrid := TConfiguracaoGrid.Create;
        Try
          LConfiguracaoGrid.CodigoOperador       := strCodigoOperador;
          LConfiguracaoGrid.NomeFormulario       := strNomeFormulario;
          LConfiguracaoGrid.NomeGrid             := LKey;
          LConfiguracaoGrid.ConfiguracoesColunas := fRetornarConfiguracaoGrid(dicGrids.Items[LKey]);

          LGravado := LCfgGrid.fSalvar(LConfiguracaoGrid);

          If Not LGravado Then
            Exit;

        Finally
          FreeAndNil(LConfiguracaoGrid);
        End;
      End;

      If LGravado Then
      Begin
        fCommit;
        pMensagemOk('Configurações gravadas com sucesso!')
      End
      Else
        raise Exception.Create('Não foi possível salvar as configurações da grid!');

    Finally
      FreeAndNil(LCfgGrid);
    End;
  Except
    On E:Exception Do
    Begin
      fRollBack;
      pMensagemOk(E.Message);
    End;
  End;
end;

function TConfiguracaoGridFactory.fDeletarConfiguracaoGrids: TConfiguracaoGridFactory;
  Var
    strKey: String;
    objCfgGrid: TCfgGrid;
    objConfiguracaoGrid: TConfiguracaoGrid;
begin
  Result := Self;
  objCfgGrid := TCfgGrid.Create;

  Try

    For strKey In dicGrids.Keys Do
    Begin
      objConfiguracaoGrid := TConfiguracaoGrid.Create;
      Try
        objConfiguracaoGrid.CodigoOperador       := strCodigoOperador;
        objConfiguracaoGrid.NomeFormulario       := strNomeFormulario;
        objConfiguracaoGrid.NomeGrid             := strKey;
        objConfiguracaoGrid.ConfiguracoesColunas := fRetornarConfiguracaoGrid(dicGrids.Items[strKey]);

        If (Not objCfgGrid.fDeletar(objConfiguracaoGrid)) Then
          Exit;

      Finally
        FreeAndNil(objConfiguracaoGrid);
      End;
    End;
  Finally
    FreeAndNil(objCfgGrid);
  End;
end;

function TConfiguracaoGridFactory.fRestaurarConfiguracaoOriginalGrid(
  const strNomeGrid: String): TConfiguracaoGridFactory;
var
  LKey : String;
begin
  Result := Self;

  For LKey In dicGrids.Keys Do
  Begin
    If (fEmptyStr(strNomeGrid)) Or
       (strNomeGrid = LKey)  Then
      pCarregarConfiguracaoGrid(dicGrids.Items[LKey], dicConfiguracaoGridOriginal.Items[LKey]);
  End;
end;

end.

