unit untCfgGrid;

interface

Uses
  Classes,
  Controls,
  ComCtrls,
  cxGridDBBandedTableView,
  cxGridBandedTableView,
  cxGridDBTableView,
  DBGrids,
  DBGridCitel,
  untZClient,
  untFuncoesSimples;

Type
  TColunasWidth = Array Of integer;

  TRecCampoCfg = record
    Prefixo: string;
    NomCam: string;
    ComponentName: string;
    Visible: boolean;
    Width: integer;
    BandIndex: integer;
    ColIndex: integer;
    Banda: TcxGridBand;
    Column: TcxGridBandedColumn;
  End;

  TArrBandaOcultada = array of string;

  TArrBandaOcultadaPorCfg = array of string;
  TArrColunaOcultaDaPorCfg = array of string;
  TArrColunasSempreInvisivel = array of string;

  TControleVisibilidadePorConfiguracao = record
    ArrBandaOcultadaPorCfg: TArrBandaOcultadaPorCfg;
    ArrColunaOcultaDaPorCfg: TArrColunaOcultaDaPorCfg;
    ArrColunasSempreInvisivel: TArrColunasSempreInvisivel;
    procedure pAddColunaOCultaPorCfg(AColumName: string);
    procedure pAddBandaOCultaPorCfg(ABandName: string);
    procedure pAddColunasSempreInvisivel(AColumName: string);
    procedure pInicia;
    function fLocalizaCampo(ANomCam: string): Boolean;
    function fLocalizaBanda(ACaption: string): Boolean;
    function fLocalizaCampoSempreInvisival(ANomCam: string): Boolean;
  end;

  TArrCamposCfg = Array of TRecCampoCfg;


  TCfgGrid = Class(TZClient)
  Private

    FstrNomGri: String;
    FApenasEdicaoDeVisibilidade: Boolean;
    ArrBandaOcultada: TArrBandaOcultada;
    FAjustarPosicoes: Boolean;

    FcxbItens: TcxGridDBBandedTableView;
    FcxvItens: TcxGridDBTableView;
    FdbgItens: TDBGridCitel;
    FColunasWidth: TColunasWidth;
    FblnExibirTodos: Boolean;
    FblnApllyBestFit: Boolean;
    FstrOperador: string;
    FArrCamposCfg: TArrCamposCfg;
    FArrCampoPrefixo: TArrCamposCfg;
    FArrCamposPosicaoOriginal: TArrCamposCfg;
    FblnAjustarColunas: Boolean;
    FOperacaoNova: Boolean;
    FControleVisibilidadePorConfiguracao: TControleVisibilidadePorConfiguracao;

    Function fSQLItens: String;

    Procedure pSetaColunasCxb;
    Procedure pSetaColunasDbg;
    Procedure pSetaColunasCxv;

    procedure pCorrigeVisibilidade;

    Procedure pIniciaCfg;
    Procedure pIncluiColuna(strNomCam, strNomCol, strNomBan: String; intBandIndex, intColIndex: Integer; Visible: Boolean);
    procedure pLocateBandIndexColIndex(ANomCam: String; var intBandIndex, intColIndex: integer);
    function fGetPrefixo(ANomCam: string): String;
    function  fColunaBloqueada(AColumnName: string): Boolean;

    procedure pTiraBandaSemColunas;
    procedure pSetaPosicaoBandas;
    procedure pRetornaVisibilidadeBandas;
    procedure pRetonaInvisbilidadeBandaSemColunas;
   // function fBandaOcultada(ACaptionBanda: string): Boolean;
    function fValorInvisibilidadeConfigurada(strNomCam: string): string;


  Public
    blnAjustouColunasVazio: Boolean;

    Class Procedure pIncluiColunaBloqueada(ArrCampoBloqueado: TArrCamposCfg; strNomCol: String);

    Class Procedure pBloqueiaInvisiveis(ArrCampoBloqueado: TArrCamposCfg; cxbItens: TcxGridDBTableView);

    constructor Create(Owner: TComponent; cxbItens: TcxGridDBBandedTableView; strNomGri: String; ColunasWidth: TColunasWidth = [];
                strOperador: String = ''; blnExibirTodos: Boolean = False; blnApllyBestFit: Boolean = True; ArrCamposCfg: TArrCamposCfg = [];
                blnAjustarPosicoes: Boolean = False; ArrCampoPrefixo: TArrCamposCfg = []; ArrCamposPosicaoOriginal: TArrCamposCfg = []); Reintroduce; OverLoad;

    constructor Create(Owner: TComponent; cxvItens: TcxGridDBTableView; strNomGri: String; ColunasWidth: TColunasWidth = [];
                strOperador: String = ''; blnExibirTodos: Boolean = False; blnApllyBestFit: Boolean = True; ArrCamposCfg: TArrCamposCfg = []; blnAjustarColunas: Boolean = True); Reintroduce; OverLoad;

    constructor Create(Owner: TComponent; cxbItens: TDBGridCitel; strNomGri: String; ColunasWidth: TColunasWidth = [];
                strOperador: String = ''; blnExibirTodos: Boolean = False; blnApllyBestFit: Boolean = True; ArrCamposCfg: TArrCamposCfg = []); Reintroduce; OverLoad;

    constructor Create(Owner: TComponent; cxbItens: TcxGridDBBandedTableView; strNomGri: String;
               AApenasEdicaoDeVisibilidade: Boolean;
               AControleVisibilidadePorConfiguracao:TControleVisibilidadePorConfiguracao;
               AblnApllyBestFit: Boolean;
               ArrCamposPosicaoOriginal: TArrCamposCfg = [];
               strOperador: string = '') overload;

    Destructor Destroy; override;

    class procedure pCorrigeVisibilidades(Owner: TComponent; cxvItens: TcxGridDBTableView; strNomGri: String; ColunasWidth: TColunasWidth = [];
                   strOperador: String = ''; blnExibirTodos: Boolean = False; blnApllyBestFit: Boolean = True; ArrCamposCfg: TArrCamposCfg = []);

    Procedure pAjustaColunas(blnApenasPosicoes: Boolean);
    Procedure pConfiguraColunas;
    Procedure pSetaColunas;
    procedure pAjustarLarguraColunas;
    function fCarregarConfiguracaoGrid: TCfgGrid;
    function fSalvarConfiguracaoGrid: TCfgGrid;
    function fPersisteDados: Boolean;

    Procedure pUpBand;
    Procedure pDownBand;

    Procedure pUpColuna;
    Procedure pDownColuna;
    procedure GravaOrdColunaDbg(AIndCol: integer; ANomIndex: string);
    function IndexOrdColunaDbg: string;
    function NomeColOrdColunaDbg: string;

    class procedure pResetaConfiguracao(strCodOpe, strNomGrid: string);

  End;

implementation

Uses
  SysUtils,
  Uni, UniClientDataSet,
  untCfgGridEdicao, DB, untFuncoesCXGrid;

constructor TCfgGrid.Create(Owner: TComponent; cxbItens: TcxGridDBBandedTableView; strNomGri: String; ColunasWidth: TColunasWidth = [];
   strOperador: String = ''; blnExibirTodos: Boolean = False; blnApllyBestFit: Boolean = True; ArrCamposCfg: TArrCamposCfg = [];
   blnAjustarPosicoes: Boolean = False; ArrCampoPrefixo: TArrCamposCfg = []; ArrCamposPosicaoOriginal: TArrCamposCfg = []);
Begin
  FApenasEdicaoDeVisibilidade := False;
  FAjustarPosicoes := blnAjustarPosicoes;
  FOperacaoNova := False;

  FblnAjustarColunas := True;
  FArrCamposPosicaoOriginal := ArrCamposPosicaoOriginal;
  FstrOperador := strOperador;
  Inherited Create(Owner, fSQLItens);
  FArrCampoPrefixo := ArrCampoPrefixo;
  FColunasWidth := ColunasWidth;
  FdbgItens  := Nil;
  FcxbItens  := cxbItens;
  FcxvItens  := Nil;
  FstrNomGri := strNomGri;
  FblnExibirTodos := blnExibirTodos;
  FblnApllyBestFit := blnApllyBestFit;
  FArrCamposCfg := ArrCamposCfg;

  pIniciaCfg;
End;

constructor TCfgGrid.Create(Owner: TComponent; cxvItens: TcxGridDBTableView;  strNomGri: String; ColunasWidth: TColunasWidth = [];
  strOperador: String = ''; blnExibirTodos: Boolean = False; blnApllyBestFit: Boolean = True; ArrCamposCfg: TArrCamposCfg = []; blnAjustarColunas: Boolean = True);
begin
  FApenasEdicaoDeVisibilidade := False;
  FOperacaoNova := False;
  FAjustarPosicoes := False;
  FblnAjustarColunas := blnAjustarColunas;
  FstrOperador := strOperador;
  Inherited Create(Owner, fSQLItens);
  SetLength(FArrCampoPrefixo, 0);
  FColunasWidth := ColunasWidth;
  FdbgItens  := Nil;
  FcxbItens  := Nil;
  FcxvItens  := cxvItens;
  FstrNomGri := strNomGri;
  FblnExibirTodos := blnExibirTodos;
  FblnApllyBestFit := blnApllyBestFit;
  FstrOperador := strOperador;
  FArrCamposCfg := ArrCamposCfg;
  pIniciaCfg;
end;

procedure TCfgGrid.pAjustarLarguraColunas;
begin
  if Assigned(FcxvItens) then
    If FblnApllyBestFit Then
      FcxvItens.ApplyBestFit;

  if Assigned(FcxbItens) then
    If FblnApllyBestFit Then
      FcxbItens.ApplyBestFit;
end;

constructor TCfgGrid.Create(Owner: TComponent; cxbItens: TDBGridCitel; strNomGri: String; ColunasWidth: TColunasWidth = [];
  strOperador: String = ''; blnExibirTodos: Boolean = False; blnApllyBestFit: Boolean = True; ArrCamposCfg: TArrCamposCfg = []);
Begin
  FApenasEdicaoDeVisibilidade := False;
  FOperacaoNova := False;
  FAjustarPosicoes := False;
  FblnAjustarColunas := True;

  FstrOperador := strOperador;
  Inherited Create(Owner, fSQLItens);
  SetLength(FArrCampoPrefixo, 0);
  FColunasWidth := ColunasWidth;

  FdbgItens  := cxbItens;
  FcxbItens  := Nil;
  FcxvItens  := Nil;
  FstrNomGri := strNomGri;
  FblnExibirTodos := blnExibirTodos;
  FblnApllyBestFit := blnApllyBestFit;
  FstrOperador := strOperador;
  FArrCamposCfg := ArrCamposCfg;
  pIniciaCfg;
End;

Procedure TCfgGrid.pIniciaCfg;
Begin
  blnAjustouColunasVazio := False;

  With qryQuery Do
  Begin
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    ParamByName('NOMGRI').AsString := FstrNomGri;
    If Not fEmptyStr(FstrOperador) Then
      ParamByName('CODOPE').AsString := FstrOperador
  End;

  fAbreClient(True, 'TCfgGrid.Create');

  pAlinhaCampoCentro('NOMBAN');

  IndexFieldNames := 'CFG_NOMCAM';

  pAjustaColunas(False{blnApenasPosicoes});
  If FblnAjustarColunas Then
    pSetaColunas;
End;

class procedure TCfgGrid.pResetaConfiguracao(strCodOpe, strNomGrid: string);
var qryDelete: TUniQuery;
begin
  qryDelete := fCriaQuery;
  Try
    qryDelete.SQL.Text := 'DELETE FROM CFGGRI WHERE CFG_NOMGRI = ' + QuotedStr(strNomGrid) + ' AND CFG_CODOPE = ' + QuotedStr(strCodOpe);
    qryDelete.ExecSQL;
  Finally
    FreeAndNil(qryDelete);
  End;
end;

procedure TCfgGrid.pRetonaInvisbilidadeBandaSemColunas;
var x, i: integer;
begin
  If Assigned(FcxbItens) then
  begin
    for i := 0 to High(ArrBandaOcultada) do
    begin
      for x := 0 to   FcxbItens.Bands.Count -1 do
      begin
        If FcxbItens.Bands[x].Caption = ArrBandaOcultada[i] then
        begin
          FcxbItens.Bands[x].Visible := False;
          Break;
        end;
      end;
    end;
  end;
end;

procedure TCfgGrid.pRetornaVisibilidadeBandas;
var x, i: integer;
begin
  If Assigned(FcxbItens) then
  begin
    for i := 0 to High(ArrBandaOcultada) do
    begin
      for x := 0 to   FcxbItens.Bands.Count -1 do
      begin
        If FcxbItens.Bands[x].Caption = ArrBandaOcultada[i] then
        begin
          FcxbItens.Bands[x].Visible := True;
          Break;
        end;
      end;
    end;
  end;
end;

Procedure TCfgGrid.pSetaColunas;
Begin
  If Assigned(FcxbItens) Then
    pSetaColunasCxb

  Else if Assigned(FcxvItens) then
    pSetaColunasCxv

  Else If Assigned(FdbgItens) Then
   pSetaColunasDbg;
End;

constructor TCfgGrid.Create(Owner: TComponent;
  cxbItens: TcxGridDBBandedTableView; strNomGri: String;
  AApenasEdicaoDeVisibilidade: Boolean;
  AControleVisibilidadePorConfiguracao: TControleVisibilidadePorConfiguracao;
  AblnApllyBestFit : Boolean;
  ArrCamposPosicaoOriginal: TArrCamposCfg = [];
  strOperador: string = '');
begin
  FApenasEdicaoDeVisibilidade:= AApenasEdicaoDeVisibilidade;
  FAjustarPosicoes := False;
  FControleVisibilidadePorConfiguracao := AControleVisibilidadePorConfiguracao;
  FblnAjustarColunas := True;
  FArrCamposPosicaoOriginal := ArrCamposPosicaoOriginal;
  FstrOperador := strOperador;
  Inherited Create(Owner, fSQLItens);
  FArrCampoPrefixo := [];
  FColunasWidth := [];
  FdbgItens  := Nil;
  FcxbItens  := cxbItens;
  FcxvItens  := Nil;
  FstrNomGri := strNomGri;
  FblnExibirTodos := False;
  FblnApllyBestFit := AblnApllyBestFit;
  FArrCamposCfg := [];
  FOperacaoNova := True;
  pIniciaCfg;
end;

Destructor TCfgGrid.Destroy;
Begin
  Inherited;

End;

function TCfgGrid.fColunaBloqueada(AColumnName: string): Boolean;
var campo: TRecCampoCfg;
begin
  Result := false;
  for campo in FArrCamposCfg do
  Begin
    if campo.ComponentName = AColumnName then
      Exit(True);
  End;

end;

Class Procedure TCfgGrid.pIncluiColunaBloqueada(ArrCampoBloqueado: TArrCamposCfg; strNomCol: String);
Begin
  SetLength(ArrCampoBloqueado, Succ(Length(ArrCampoBloqueado)));
  ArrCampoBloqueado[High(ArrCampoBloqueado)].ComponentName := strNomCol;
End;

Class Procedure TCfgGrid.pBloqueiaInvisiveis(ArrCampoBloqueado: TArrCamposCfg; cxbItens: TcxGridDBTableView);
  Var
    intContador: Integer;
Begin
  SetLength(ArrCampoBloqueado, 0);

  For intContador := 0 To cxbItens.ColumnCount - 1 Do
    If Not cxbItens.Columns[intContador].Visible Then
      pIncluiColunaBloqueada(ArrCampoBloqueado, cxbItens.Columns[intContador].Name);
End;

function TCfgGrid.fGetPrefixo(ANomCam: string): String;
var i: integer;
begin
  Result := '';
  For i := 0 To High(FArrCampoPrefixo) do
  begin
    If FArrCampoPrefixo[i].NomCam = ANomCam then
      Exit(FArrCampoPrefixo[i].Prefixo)
  End;
  {}
end;

Function TCfgGrid.fSQLItens: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT G.*, ';
  strSQL := strSQL + '   0                     AS BANIND, ';
  strSQL := strSQL + '   0                     AS COLIND, ';
  strSQL := strSQL + '   0                     AS EXISTE, ';
  strSQL := strSQL + '   CAST("" AS CHAR(100)) AS NOMBAN, ';
  strSQL := strSQL + '   CAST("" AS CHAR(100)) AS NOMCOL, ';
  strSQL := strSQL + '   CAST("N" AS CHAR(1))  AS INVISIBILIDADE_COFIGURADA';

  strSQL := strSQL + ' FROM CFGGRI G ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   CFG_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '   CFG_NOMGRI = :NOMGRI ';
  If Not fEmptyStr(FstrOperador) Then
    strSQL := strSQL + '   AND CFG_CODOPE = :CODOPE ';
  Result := strSQL;
End;

function TCfgGrid.fValorInvisibilidadeConfigurada(strNomCam: string): string;
var Col: TcxGridDBBandedColumn;
begin
  Result := 'N';
  If not FOperacaoNova then
    Exit;
  If FControleVisibilidadePorConfiguracao.fLocalizaCampo(strNomCam) then
    Exit('S');

  If strNomCam <> '' Then
  begin
    Col := FcxbItens.GetColumnByFieldName(strNomCam) as TcxGridDBBandedColumn;
    If Assigned(col) then
      If  FControleVisibilidadePorConfiguracao.fLocalizaBanda(FcxbItens.Bands[col.Position.BandIndex].Caption) then
        Exit('S');
  end;
end;

Procedure TCfgGrid.pIncluiColuna(strNomCam, strNomCol, strNomBan: String; intBandIndex, intColIndex: Integer; Visible: Boolean);
Begin
  If FindKey([strNomCam]) Then
  Begin
    Edit;
  End Else
  Begin
    Insert;

    FieldByName('CFG_NOMGRI').AsString := FstrNomGri;
    FieldByName('CFG_NOMCAM').AsString := strNomCam;
    FieldByName('CFG_CODEMP').AsString := VS_strCodEmp;

    If Visible Then
      FieldByName('CFG_VISIVE').AsString := 'S'
    Else
      FieldByName('CFG_VISIVE').AsString := 'N';

    If not fEmptyStr(FstrOperador) Then
      FieldByName('CFG_CODOPE').AsString := FstrOperador

  End;
  pLocateBandIndexColIndex(strNomCam, intBandIndex, intColIndex);
  FieldByName('BANIND').AsInteger := intBandIndex;
  FieldByName('COLIND').AsInteger := intColIndex;
  FieldByName('EXISTE').AsInteger := 1;

  FieldByName('NOMCOL').AsString := fGetPrefixo(strNomCam) + strNomCol;
  FieldByName('NOMBAN').AsString := strNomBan;

  FieldByName('INVISIBILIDADE_COFIGURADA').AsString := fValorInvisibilidadeConfigurada(strNomCam);
  If FieldByName('INVISIBILIDADE_COFIGURADA').AsString = 'S' then
    FieldByName('CFG_VISIVE').AsString := 'S';
  If FControleVisibilidadePorConfiguracao.fLocalizaCampoSempreInvisival(strNomCam) then
     FieldByName('CFG_VISIVE').AsString := 'N';
  Post;
End;

Procedure TCfgGrid.pAjustaColunas(blnApenasPosicoes: Boolean);
  Var
    intContador: Integer;
Begin

  If Assigned(FcxbItens) Then
  Begin
    If FOperacaoNova then
    begin
      For intContador := 0 To FcxbItens.ColumnCount - 1 Do
        try
          If (not FControleVisibilidadePorConfiguracao.fLocalizaCampoSempreInvisival(FcxbItens.Columns[intContador].DataBinding.FieldName)) and
             (FcxbItens.Columns[intContador].Caption <> '') then
            pIncluiColuna(FcxbItens.Columns[intContador].DataBinding.FieldName,
                                      IIF(fEmptyStr(FcxbItens.Columns[intContador].Caption), FcxbItens.Columns[intContador].AlternateCaption, FcxbItens.Columns[intContador].Caption),
                                      FcxbItens.Bands[FcxbItens.Columns[intContador].Position.BandIndex].Caption,
                                      FcxbItens.Columns[intContador].Position.VisibleBandIndex,
                                      FcxbItens.Columns[intContador].Position.ColIndex,
                                      FcxbItens.Columns[intContador].Visible);
        Except
          on e: Exception do
          begin
            pMensagemOk(intContador.ToString + ' ' + e.message);
            raise Exception.Create(e.message);
          end;
        End;
    end
    Else
    begin
      For intContador := 0 To FcxbItens.ColumnCount - 1 Do
        If  FcxbItens.Columns[intContador].Position.BandIndex > -1 Then
          If (Not fColunaBloqueada(TCxGridDBBandedColumn(FcxbItens.Columns[intContador]).Name)) And
           ((FcxbItens.Columns[intContador].Visible And FcxbItens.Bands[FcxbItens.Columns[intContador].Position.BandIndex].Visible) Or (FblnExibirTodos)) Then
            pIncluiColuna(FcxbItens.Columns[intContador].DataBinding.FieldName,
                          IIF(fEmptyStr(FcxbItens.Columns[intContador].Caption), FcxbItens.Columns[intContador].AlternateCaption, FcxbItens.Columns[intContador].Caption),
                          FcxbItens.Bands[FcxbItens.Columns[intContador].Position.BandIndex].Caption,
                          FcxbItens.Columns[intContador].Position.VisibleBandIndex,
                          FcxbItens.Columns[intContador].Position.ColIndex,
                          FcxbItens.Columns[intContador].Visible);
    end
  end

  Else If Assigned(FcxvItens) Then
  Begin

    For intContador := 0 To FcxvItens.ColumnCount - 1 Do
    With FcxvItens.Columns[intContador] Do
      If (Not fColunaBloqueada(TCxGridDbColumn(FcxvItens.Columns[intContador]).Name)) And
         ((Visible)  Or (FblnExibirTodos)) Then
      pIncluiColuna(DataBinding.FieldName, IIF(fEmptyStr(Caption), AlternateCaption, Caption), '',0,intContador, Visible);

  End

  Else If Assigned(FdbgItens) Or (FblnExibirTodos) Then
  Begin

    For intContador := 0 To FdbgItens.Columns.Count - 1 Do
    With FdbgItens.Columns[intContador] Do
    If (Not fColunaBloqueada(TDBGrid(FdbgItens).Name)) And
       ((Visible)  Or (FblnExibirTodos)) Then
      pIncluiColuna(FieldName, Title.Caption, '', 0, intContador, Visible);

  End;

  If Not blnApenasPosicoes Then
  Begin
    Filter   := 'EXISTE = 0';
    Filtered := True;

    While Not Eof Do
    Begin
      Delete;
    End;

    Filtered := False;

    fSalva;
  End;

  Filter   := 'INVISIBILIDADE_COFIGURADA = ' + QuotedStr('N');
  Filtered := True;

  First;
End;

Procedure TCfgGrid.pSetaColunasCxb;
  Var
    colColuna: TcxGridDBBandedColumn;
Begin
  If FOperacaoNova then
    Self.Filtered := False;
  First;
  While Not Eof Do
  Begin
    colColuna := FcxbItens.GetColumnByFieldName(FieldByName('CFG_NOMCAM').AsString);

    If (Assigned(colColuna)) and (not fColunaBloqueada(colColuna.Name)) Then
    begin
      If FOperacaoNova then
        colColuna.Visible := (FieldByName('CFG_VISIVE').AsString = 'S') and (FieldByName('INVISIBILIDADE_COFIGURADA').AsString = 'N')
      else
        colColuna.Visible := (FieldByName('CFG_VISIVE').AsString = 'S');
    end;

    If FAjustarPosicoes Then
      colColuna.Position.ColIndex := FieldByName('COLIND').AsInteger;

    Next;
  End;

  First;

  blnAjustouColunasVazio := (Not Assigned(FcxbItens.DataController.DataSource)) Or
                            (Assigned(FcxbItens.DataController.DataSource.DataSet) and (FcxbItens.DataController.DataSource.DataSet.IsEmpty));

  pTiraBandaSemColunas;
  If Not FApenasEdicaoDeVisibilidade then
    pSetaPosicaoBandas;

  If FblnApllyBestFit Then
    FcxbItens.ApplyBestFit;
End;

procedure TCfgGrid.pTiraBandaSemColunas;
  Var
    intBands,
    intColumns: Integer;
    blnTemColuna: Boolean;
Begin
  SetLength(ArrBandaOcultada, 0);

  For intBands := 0 To FcxbItens.Bands.Count - 1 Do
  Begin
    blnTemColuna := False;

    For intColumns := 0 To FcxbItens.Bands[intBands].ColumnCount - 1 Do
      If FcxbItens.Bands[intBands].Columns[intColumns].Caption = '' then
        FcxbItens.Bands[intBands].Columns[intColumns].Visible := False;

    For intColumns := 0 To FcxbItens.Bands[intBands].ColumnCount - 1 Do
    begin
      If FcxbItens.Bands[intBands].Columns[intColumns].Caption <> '' then
        If FcxbItens.Bands[intBands].Columns[intColumns].Visible Then
        begin
          blnTemColuna := True;
          break;
        end;

    end;

    FcxbItens.Bands[intBands].Visible := blnTemColuna;
    If not blnTemColuna then
    begin
      If FcxbItens.Bands[intBands].Caption <> '' then
      begin
        SetLength(ArrBandaOcultada, Length(ArrBandaOcultada) + 1);
        ArrBandaOcultada[High(ArrBandaOcultada)] := FcxbItens.Bands[intBands].Caption;
      end;
    end;

  End;
End;

procedure TCfgGrid.pSetaPosicaoBandas;
  Var
    intBands: Integer;
    strNomBan: String;
Begin
  If FApenasEdicaoDeVisibilidade then
    Exit;
  strNomBan := '';

  Self.First;
  While Not Self.Eof Do
  Begin
    If strNomBan <> Self.FieldByName('NOMBAN').AsString Then
    Begin
      For intBands := 0 To FcxbItens.Bands.Count - 1 Do
        If Self.FieldByName('NOMBAN').AsString = FcxbItens.Bands[intBands].Caption Then
          FcxbItens.Bands[intBands].Position.ColIndex := Self.FieldByName('BANIND').AsInteger;

      strNomBan := Self.FieldByName('NOMBAN').AsString;
    End;

    Self.Next;
  End;
End;

procedure TCfgGrid.pSetaColunasCxv;
  Var
    colColuna: TcxGridDBColumn;
Begin

  First;
  While Not Eof Do
  Begin
    colColuna := FcxvItens.GetColumnByFieldName(FieldByName('CFG_NOMCAM').AsString);

    If Assigned(colColuna) Then
      colColuna.Visible := FieldByName('CFG_VISIVE').AsString = 'S';

    Next;
  End;

  First;

  blnAjustouColunasVazio := (Not Assigned(FcxvItens.DataController.DataSource)) Or
                             FcxvItens.DataController.DataSource.DataSet.IsEmpty;
end;

Procedure TCfgGrid.pSetaColunasDbg;
  Var
    intContador: Integer;
Begin

  First;
  While Not Eof Do
  Begin

    For intContador := 0 To FdbgItens.Columns.Count - 1 Do
      If SameText(FdbgItens.Columns[intContador].FieldName, FieldByName('CFG_NOMCAM').AsString) Then
      Begin
        If High(FColunasWidth) > -1 Then
        Begin
          If Not (FieldByName('CFG_VISIVE').AsString = 'S') Then
             FdbgItens.Columns[intContador].Width := 0
          Else If (High(FColunasWidth) > -1) And (intContador <= High(FColunasWidth)) Then
             FdbgItens.Columns[intContador].Width := FColunasWidth[intContador];
        End
        Else
          FdbgItens.Columns[intContador].Visible := FieldByName('CFG_VISIVE').AsString = 'S';
        Break;
      End;

    Next;
  End;

  First;

  blnAjustouColunasVazio := (Not Assigned(FdbgItens.DataSource)) Or
                             FdbgItens.DataSource.DataSet.IsEmpty;
End;

Procedure TCfgGrid.pConfiguraColunas;
  Var
    cdsBkp: TUniClientDataSet;
Begin
  pRetornaVisibilidadeBandas;
  pAjustaColunas(True{blnApenasPosicoes});

  pCriarFormularios(TfrmCfgGridEdicao, frmCfgGridEdicao);

  With frmCfgGridEdicao Do
  Begin
    cxvColunasNOMBAN.Visible := Assigned(FcxbItens);

    If Not cxvColunasNOMBAN.Visible Then
      Width := Width - cxvColunasNOMBAN.Width;

    cdsBkp := TUniClientDataSet.Create(Nil);
    cdsBkp.Data := Self.Data;

    cxvColunas.DataController.DataSource := dtsSource;

    cxvColunas.NavigatorButtons.First.Click;

    pnlTitulo.Caption := FstrNomGri;

    If ShowModal = mrOk Then
    Begin
      pSetaColunas;
      Filtered := False;
      fPersisteDados;
    End Else
    Begin
      cdsBkp.First;
      pRetonaInvisbilidadeBandaSemColunas;
      While Not cdsBkp.Eof Do
      Begin

        If FindKey([cdsBkp.FieldByName('CFG_NOMCAM').AsString]) Then
        Begin
          Edit;
          FieldByName('CFG_VISIVE').AsString := cdsBkp.FieldByName('CFG_VISIVE').AsString;
          Post;
        End;

        cdsBkp.Next;
      End;

    End;

    FreeAndNil(cdsBkp);
  End;

  pFreeAndNil(frmCfgGridEdicao);
End;

procedure TCfgGrid.pCorrigeVisibilidade;
var Column : TcxGridDBColumn;
begin
  First;
  While not Eof Do
  Begin
    if FieldByName('CFG_VISIVE').AsString = 'N' Then
    begin
      Column := FcxvItens.GetColumnByFieldName(FieldByName('CFG_NOMCAM').ASString);
      If Assigned(Column) Then
      Begin
        If Column.Visible Then
          Column.Visible := False;
      End;
    end;
    Next;
  End;
end;

class procedure TCfgGrid.pCorrigeVisibilidades(Owner: TComponent;
  cxvItens: TcxGridDBTableView; strNomGri: String; ColunasWidth: TColunasWidth;
  strOperador: String; blnExibirTodos, blnApllyBestFit: Boolean;
  ArrCamposCfg: TArrCamposCfg);
var
  objCfgGri: TCfgGrid;
begin
  objCfgGri := TCfgGrid.Create(Owner, cxvItens, strNomGri, ColunasWidth, strOperador, blnExibirTodos, blnApllyBestFit, ArrCamposCfg, false);
  Try
    objCfgGri.pCorrigeVisibilidade;
  Finally
    FreeAndNil(objCfgGri);
  End;
end;

{function TCfgGrid.fBandaOcultada(ACaptionBanda: string): Boolean;
var i: integer;
begin
  Result := False;
  for i := 0 to High(ArrBandaOcultada) do
    If ACaptionBanda=  ArrBandaOcultada[i] then
    begin
      Result := True;
      Break;
    end;
end;}

function TCfgGrid.fCarregarConfiguracaoGrid: TCfgGrid;
Var
  intRecNo: Integer;
Begin
  Result := Self;
  if Assigned(FcxvItens) then
    fGetFuncoesCxGrid.fCarregarView(FcxvItens, FstrNomGri, Self, intRecNo);
End;

function TCfgGrid.fSalvarConfiguracaoGrid: TCfgGrid;
Begin
  Result := Self;
  if Assigned(FcxvItens) then
    fGetFuncoesCxGrid.pSalvarView(FcxvItens, FstrNomGri, Self);
End;

Procedure TCfgGrid.pUpBand;
  Var
    intBandaCorrente,
    intBandaAnterior: Integer;

    strNomCol: String;

    cdsBkp: TUniClientDataSet;
Begin
  Self.DisableControls;

  strNomCol := Self.FieldByName('CFG_NOMCAM').AsString;

  // TODOS TEM Q TER NOME DE COLUNAS
  cdsBkp := TUniClientDataSet.Create(Nil);
  cdsBkp.Data := Self.Data;

  Self.Locate('CFG_NOMCAM', strNomCol, []);

  cdsBkp.IndexFieldNames := 'BANIND;COLIND';

  cdsBkp.Locate('CFG_NOMCAM', strNomCol, []);

  intBandaCorrente := cdsBkp.FieldByName('BANIND').AsInteger;

  While Not cdsBkp.Bof Do
  Begin
    If cdsBkp.FieldByName('BANIND').AsInteger < intBandaCorrente Then
    Begin
      intBandaAnterior := cdsBkp.FieldByName('BANIND').AsInteger;

      Self.Filter := 'BANIND = ' + intBandaAnterior.ToString();
      Self.Filtered := True;

      Self.First;
      While Not Self.Eof Do
      Begin
        Self.Edit;
        Self.FieldByName('BANIND').AsInteger := -1;
        Self.Post;
      End;

      Self.Filter := 'BANIND = ' + intBandaCorrente.ToString();
      Self.Filtered := True;

      Self.First;
      While Not Self.Eof Do
      Begin
        Self.Edit;
        Self.FieldByName('BANIND').AsInteger := intBandaAnterior;
        Self.Post;
      End;

      Self.Filter := 'BANIND = -1';
      Self.Filtered := True;

      Self.First;
      While Not Self.Eof Do
      Begin
        Self.Edit;
        Self.FieldByName('BANIND').AsInteger := intBandaCorrente;
        Self.Post;
      End;

      Break;
    End;

    cdsBkp.Prior;
  End;

  FreeAndNil(cdsBkp);

  Self.Filtered := False;
  Self.Locate('CFG_NOMCAM', strNomCol, []);

  Self.EnableControls;
End;

Procedure TCfgGrid.pDownBand;
  Var
    intBandaCorrente,
    intBandaAnterior: Integer;

    strNomCol: String;

    cdsBkp: TUniClientDataSet;
Begin
  Self.DisableControls;

  strNomCol := Self.FieldByName('CFG_NOMCAM').AsString;

  // TODOS TEM Q TER NOME DE COLUNAS
  cdsBkp := TUniClientDataSet.Create(Nil);
  cdsBkp.Data := Self.Data;

  Self.Locate('CFG_NOMCAM', strNomCol, []);

  cdsBkp.IndexFieldNames := 'BANIND;COLIND';

  cdsBkp.Locate('CFG_NOMCAM', strNomCol, []);

  intBandaCorrente := cdsBkp.FieldByName('BANIND').AsInteger;

  While Not cdsBkp.eof Do
  Begin
    If cdsBkp.FieldByName('BANIND').AsInteger > intBandaCorrente Then
    Begin
      intBandaAnterior := cdsBkp.FieldByName('BANIND').AsInteger;

      Self.Filter := 'BANIND = ' + intBandaAnterior.ToString();
      Self.Filtered := True;

      Self.First;
      While Not Self.Eof Do
      Begin
        Self.Edit;
        Self.FieldByName('BANIND').AsInteger := -1;
        Self.Post;
      End;

      Self.Filter := 'BANIND = ' + intBandaCorrente.ToString();
      Self.Filtered := True;

      Self.First;
      While Not Self.Eof Do
      Begin
        Self.Edit;
        Self.FieldByName('BANIND').AsInteger := intBandaAnterior;
        Self.Post;
      End;

      Self.Filter := 'BANIND = -1';
      Self.Filtered := True;

      Self.First;
      While Not Self.Eof Do
      Begin
        Self.Edit;
        Self.FieldByName('BANIND').AsInteger := intBandaCorrente;
        Self.Post;
      End;

      Break;
    End;

    cdsBkp.Next;
  End;

  FreeAndNil(cdsBkp);

  Self.Filtered := False;
  Self.Locate('CFG_NOMCAM', strNomCol, []);

  Self.EnableControls;
End;

Procedure TCfgGrid.pUpColuna;
  Var
    intBandaCorrente: Integer;

    intColunaCorrente,
    intColunaAnterior: Integer;

    strNomBanAnterior,
    strNomCol: String;
    strNomColAnterior: String;
Begin
  Self.DisableControls;

  strNomCol := Self.FieldByName('CFG_NOMCAM').AsString;

  Self.IndexFieldNames := 'BANIND;COLIND';

  Self.Locate('CFG_NOMCAM', strNomCol, []);

  intBandaCorrente  := Self.FieldByName('BANIND').AsInteger;
  intColunaCorrente := Self.FieldByName('COLIND').AsInteger;

  Self.Prior;
  If strNomCol <> Self.FieldByName('CFG_NOMCAM').AsString Then
  Begin
  //  intBandaAnterior  := Self.FieldByName('BANIND').AsInteger;
    intColunaAnterior := Self.FieldByName('COLIND').AsInteger;
    strNomColAnterior := Self.FieldByName('CFG_NOMCAM').AsString;
    strNomBanAnterior := Self.FieldByName('NOMBAN').AsString;

    If Self.FieldByName('BANIND').AsInteger <> intBandaCorrente Then
    Begin
      // NÃO VAI DEIXAR MUDAR DE BANDA
      (*
      Self.Locate('CFG_NOMCAM', strNomCol, []);

      Self.Edit;
      Self.FieldByName('BANIND').AsInteger := intBandaAnterior;
      Self.FieldByName('COLIND').AsInteger := Succ(intColunaAnterior);
      Self.FieldByName('NOMBAN').AsString  := strNomBanAnterior;
      Self.Post;
      *)
    End Else
    Begin
      Self.Edit;
      Self.FieldByName('COLIND').AsInteger := intColunaCorrente;
      Self.Post;

      Self.Locate('CFG_NOMCAM', strNomCol, []);
      Self.Edit;
      Self.FieldByName('COLIND').AsInteger := intColunaAnterior;
      Self.Post;
    End;

  End;

  Self.IndexFieldNames := 'CFG_NOMCAM';
  Self.Locate('CFG_NOMCAM', strNomCol, []);

  Self.EnableControls;
End;

Procedure TCfgGrid.GravaOrdColunaDbg(AIndCol: integer; ANomIndex: string);
Begin
  qryQuery.First;
  While not qryQuery.EOF do
  begin
    if qryQuery.FieldByName('CFG_NOMCAM').AsString = FdbgItens.Columns[AIndCol].FieldName then
    Begin
      qryQuery.Edit;
      qryQuery.FieldByName('CFG_ORDENA').AsString := 'S';
      qryQuery.FieldByName('CFG_NOMIND').AsString := ANomIndex;
      qryQuery.Post;
    End
    Else
    Begin
      qryQuery.Edit;
      qryQuery.FieldByName('CFG_ORDENA').AsString := 'N';
      qryQuery.FieldByName('CFG_NOMIND').AsString := '';
      qryQuery.Post;
    End;
    qryQuery.Next;
  end;
End;

Function TCfgGrid.IndexOrdColunaDbg: string;
begin
  qryQuery.First;
  While not qryQuery.EOF do
  begin
    if qryQuery.FieldByName('CFG_ORDENA').AsString = 'S' then
      Exit(qryQuery.FieldByName('CFG_NOMIND').AsString);
    qryQuery.Next;
  end;
  Result := '';
end;

Function TCfgGrid.NomeColOrdColunaDbg: string;
begin
  qryQuery.First;
  While not qryQuery.EOF do
  begin
    if qryQuery.FieldByName('CFG_ORDENA').AsString = 'S' then
      Exit(qryQuery.FieldByName('CFG_NOMCAM').AsString);
    qryQuery.Next;
  end;
  Result := '';
end;

Procedure TCfgGrid.pDownColuna;
  Var
    intBandaCorrente: Integer;

    intColunaPosterior,
    intColunaCorrente: Integer;

    strNomBanPosterior,

    strNomCol: String;
    strNomColPosterior: String;

    cdsBkp: TUniClientDataSet;

Begin
  Self.DisableControls;

  strNomCol := Self.FieldByName('CFG_NOMCAM').AsString;

  // TODOS TEM Q TER NOME DE COLUNAS
  cdsBkp := TUniClientDataSet.Create(Nil);
  cdsBkp.Data := Self.Data;

  cdsBkp.IndexFieldNames := 'BANIND;COLIND';

  cdsBkp.Locate('CFG_NOMCAM', strNomCol, []);

  intBandaCorrente  := cdsBkp.FieldByName('BANIND').AsInteger;
  intColunaCorrente := cdsBkp.FieldByName('COLIND').AsInteger;

  cdsBkp.Next;
  If strNomCol <> cdsBkp.FieldByName('CFG_NOMCAM').AsString Then
  Begin
   // intBandaPosterior  := cdsBkp.FieldByName('BANIND').AsInteger;
    intColunaPosterior := cdsBkp.FieldByName('COLIND').AsInteger;
    strNomColPosterior := cdsBkp.FieldByName('CFG_NOMCAM').AsString;
    strNomBanPosterior := cdsBkp.FieldByName('NOMBAN').AsString;

    If cdsBkp.FieldByName('BANIND').AsInteger <> intBandaCorrente Then
    Begin

      // NÃO VAI DEIXAR MUDAR DE BANDA
      (*
      While (Not cdsBkp.Eof) And (intBandaPosterior = cdsBkp.FieldByName('BANIND').AsInteger) Do
      Begin

        If Self.Locate('CFG_NOMCAM', cdsBkp.FieldByName('CFG_NOMCAM').AsString, []) Then
        Begin
          Self.Edit;
          Self.FieldByName('COLIND').AsInteger := Succ(Self.FieldByName('COLIND').AsInteger);
          Self.Post;
        End;

        cdsBkp.Next;
      End;

      Self.Locate('CFG_NOMCAM', strNomCol, []);
      Self.Edit;
      Self.FieldByName('BANIND').AsInteger  := intBandaPosterior;
      Self.FieldByName('COLIND').AsInteger  := intColunaPosterior;
      Self.FieldByName('NOMBAN').AsString := strNomBanPosterior;
      Self.Post;
      *)

    End Else
    Begin
      Self.Locate('CFG_NOMCAM', cdsBkp.FieldByName('CFG_NOMCAM').AsString, []);

      Self.Edit;
      Self.FieldByName('COLIND').AsInteger := intColunaCorrente;
      Self.Post;

      Self.Locate('CFG_NOMCAM', strNomCol, []);
      Self.Edit;
      Self.FieldByName('COLIND').AsInteger := intColunaPosterior;
      Self.Post;
    End;

  End;

  FreeAndNil(cdsBkp);

  Self.EnableControls;
End;

procedure TCfgGrid.pLocateBandIndexColIndex(ANomCam: String; var intBandIndex, intColIndex: integer);
Var
  i: Integer;
begin
  For i := 0 To High(FArrCamposPosicaoOriginal) Do
  Begin
    If FArrCamposPosicaoOriginal[i].NomCam = ANomCam Then
    Begin
      intBandIndex := FArrCamposPosicaoOriginal[i].BandIndex;
      intColIndex := FArrCamposPosicaoOriginal[i].colIndex;
      Exit;
    End;
  End;

end;

function TCfgGrid.fPersisteDados: Boolean;
var qryComand: TUniQuery;
  function fTrataSQLNull(AValue: string; blnSetOperador : Boolean = False): string;
  begin
    If AValue = '' then
      Result := IIf(blnSetOperador, ' IS ', '') + 'NULL'
    else
     Result := IIf(blnSetOperador, ' = ', '') + '"' + AValue + '"';
  end;

begin
  Result := True;
  qryComand := fCriaQuery;
  try

    qryComand.SQL.Clear;
    while not Self.Eof do
    begin

      qryComand.SQL.add('DELETE FROM CFGGRI');
      qryComand.SQL.add(' WHERE CFG_NOMGRI = '+ fTrataSQLNull(Self.FieldByName('CFG_NOMGRI').AsString));
      qryComand.SQL.add('   AND CFG_CODEMP = '+ fTrataSQLNull(Self.FieldByName('CFG_CODEMP').AsString));
      qryComand.SQL.add('   AND CFG_NOMCAM = '+ fTrataSQLNull(Self.FieldByName('CFG_NOMCAM').AsString));
      qryComand.SQL.add('   AND CFG_CODOPE '+ fTrataSQLNull(Self.FieldByName('CFG_CODOPE').AsString, True) + ';');

      qryComand.SQL.Add('INSERT INTO CFGGRI (CFG_CODEMP, CFG_NOMCAM, CFG_NOMGRI, CFG_VISIVE, CFG_CODOPE, CFG_ORDENA, CFG_NOMIND) VALUES ');
      qryComand.SQL.Add('(' + fTrataSQLNull(Self.FieldByName('CFG_CODEMP').AsString) + ',');
      qryComand.SQL.Add(fTrataSQLNull(Self.FieldByName('CFG_NOMCAM').AsString) + ',');
      qryComand.SQL.Add(fTrataSQLNull(Self.FieldByName('CFG_NOMGRI').AsString) + ',');
      qryComand.SQL.Add(fTrataSQLNull(Self.FieldByName('CFG_VISIVE').AsString) + ',');
      qryComand.SQL.Add(fTrataSQLNull(Self.FieldByName('CFG_CODOPE').AsString) + ',');
      qryComand.SQL.Add(fTrataSQLNull(Self.FieldByName('CFG_ORDENA').AsString) + ',');
      qryComand.SQL.Add(fTrataSQLNull(Self.FieldByName('CFG_NOMIND').AsString) + ');');
      Self.Next;
    end;
    qryComand.ExecSQL;
  finally
    FreeAndNil(qryComand)
  end;
end;

{ TControleVisibilidadePorConfiguracao }

function TControleVisibilidadePorConfiguracao.fLocalizaBanda(ACaption: string): Boolean;
var i: integer;
begin
  Result := False;
  For i:= 0 To High(ArrBandaOcultadaPorCfg) do
  begin
    If  ArrBandaOcultadaPorCfg[i] = ACaption then
      Exit(True)
  End;

end;

function TControleVisibilidadePorConfiguracao.fLocalizaCampo(ANomCam: string): Boolean;
var i: integer;
begin
  Result := False;
  For i:= 0 To High(ArrColunaOcultaDaPorCfg) do
  begin
    If  ArrColunaOcultaDaPorCfg[i] = ANomCam then
      Exit(True)
  End;
end;

function TControleVisibilidadePorConfiguracao.fLocalizaCampoSempreInvisival(ANomCam: string): Boolean;
var i: integer;
begin
  Result := False;
  For i:= 0 To High(ArrColunasSempreInvisivel) do
  begin
    If ArrColunasSempreInvisivel[i] = ANomCam then
      Exit(True)
  End;
end;

procedure TControleVisibilidadePorConfiguracao.pAddBandaOCultaPorCfg(
  ABandName: string);
begin
  SetLength(ArrBandaOcultadaPorCfg, Length(ArrBandaOcultadaPorCfg) + 1);
  ArrBandaOcultadaPorCfg[High(ArrBandaOcultadaPorCfg)] := ABandName;

end;

procedure TControleVisibilidadePorConfiguracao.pAddColunaOCultaPorCfg(
  AColumName: string);
begin
  SetLength(ArrColunaOcultaDaPorCfg, Length(ArrColunaOcultaDaPorCfg) + 1);
  ArrColunaOcultaDaPorCfg[High(ArrColunaOcultaDaPorCfg)] := AColumName;
end;

procedure TControleVisibilidadePorConfiguracao.pAddColunasSempreInvisivel(
  AColumName: string);
begin
  SetLength(ArrColunasSempreInvisivel, Length(ArrColunasSempreInvisivel) + 1);
  ArrColunasSempreInvisivel[High(ArrColunasSempreInvisivel)] := AColumName;
end;

procedure TControleVisibilidadePorConfiguracao.pInicia;
begin
  SetLength(ArrColunaOcultaDaPorCfg, 0);
  SetLength(ArrBandaOcultadaPorCfg, 0);
  SetLength(ArrColunasSempreInvisivel, 0);
end;

end.


