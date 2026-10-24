unit untGenericNovasFormulas;

interface

uses
  SysUtils, Variants, Classes, Controls, Forms,
  untPaiCad, StdCtrls, Mask, DBCtrls, DBEditFocus,
  ExtCtrls,  Uni, DB,
  untIConfTinta,
  cxCustomData, cxEdit, cxGridLevel,
  cxGridCustomTableView, cxGridDBTableView, cxGrid, UniClientDataSet,
  untINovaFormula, TypInfo, cxStyles, cxGraphics, cxFilter, cxData, cxDataStorage, cxDBData, cxClasses, cxControls, cxGridCustomView,
  cxGridTableView, AppEvnts, Menus, ComCtrls, Buttons, BitBtnLockedIncrem,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxClass, frxExportCSVTestabilidade,
  Datasnap.DBClient, cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmGenericNovasFormulas = class(TfrmPaiCad)
    pnlCentral: TPanel;
    pnlCabecalho: TPanel;
    lblCodigo: TLabel;
    dbeCodigo: TDBEditFocus;
    dbgvComponentes: TcxGridDBTableView;
    dbglComponentes: TcxGridLevel;
    dbgComponentes: TcxGrid;
    dtsComponentes: TDataSource;
    cdsCompoentes: TUniClientDataSet;
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dbgvComponentesEditKeyPress(Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit;
      var Key: Char);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure cdsCompoentesBeforePost(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure dbgComponentesEnter(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    function GetDefaultValue(fieldType: TFieldType): Variant;
  protected
    { Private declarations }
    qryCadNfm: TUniQuery;
    dtsCadNfm: TDataSource;
    novaFormula: INovaFormula;
    conf: IConfTinta;
    procedure pCriaDataSets;
    procedure pLigaDataSets;
    procedure pSetCamposChaves;
    procedure ConstruirGrid;
    procedure CarregarGrid;
    procedure cdsCompoenteSetText(Sender: TField; const Text: string);
    function IsComponenteCadastrado(const strComponente: string): Boolean;
    procedure SalvarComposicao;
    function ValidarComposicao: Boolean;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure CarregarCampos; virtual;
    constructor Create(AOwner: TComponent;const novaFormula: INovaFormula); reintroduce; overload;
  public
    procedure pInicializaIndices; override;
    { Public declarations }
    constructor Create(AOwner: TComponent); overload; override;
    destructor Destroy; override;
  end;

  ExceptionComponenteCadastrado = class(Exception);

var
  frmGenericNovasFormulas: TfrmGenericNovasFormulas;

implementation

uses untFuncTinta, untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmGenericoNovasFormulas }

procedure TfrmGenericNovasFormulas.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dbgComponentes.Enabled := qryTabela.State in [dsEdit, dsInsert];
  SelectNext(dbeCodigo, True, True);
end;

procedure TfrmGenericNovasFormulas.btnCancelaClick(Sender: TObject);
begin
  inherited;
  ConstruirGrid;
  dbgComponentes.Enabled := qryTabela.State in [dsEdit, dsInsert];
  CarregarCampos;
end;

procedure TfrmGenericNovasFormulas.btnExcluirClick(Sender: TObject);
var
  strCodNfm: String;
begin
  strCodNfm := dbeCodigo.Text;
  inherited;
  novaFormula.RemoverNovaFormula(strCodNfm);
  dbgComponentes.Enabled := qryTabela.State in [dsEdit, dsInsert];
  ConstruirGrid;
  CarregarCampos;
end;

procedure TfrmGenericNovasFormulas.btnGravarClick(Sender: TObject);
var
  blnInsert: Boolean;
  strNfm: String;
begin
  Try
    Try
      Screen.Cursor := crHourGlass;
      SalvarComposicao;
      blnInsert := (qryTabela.State = dsInsert);
      If (blnInsert) Then
      Begin
        strNfm := IIF(StrToInt(conf.fGet(novaFormula.GetNomeConfProCod)) > 0, conf.fGet(novaFormula.GetNomeConfProCod), '1' ) ;
        qryTabela.FieldByName('NFM_CODNFM').AsString := Format('ESP %s%s', [VS_strCodEmp, fStrZero(StrToIntDef(strNfm, 1), 5)]);
      End;
      fStartTransaction;
      inherited;
      If (blnGravou) Then
      Begin
        novaFormula.RemoverNovaFormula(qryTabela.FieldByName('NFM_CODNFM').AsString);
        novaFormula.GravarNovaFormula(qryCadNfm);
        If (blnInsert) Then
        Begin
          conf.pSet(novaFormula.GetNomeConfProCod, fStrZero(StrToInt(strNfm) + 1, 7));
        End;

        fCommit;
      End
      Else
        fRollBack;
    Except
      on E: Exception do
      begin
        fRollBack;
        fMensagem('ATENÇÃO', Format('Não foi possivel realizar a gravação da nova formula! [%s: %s]',
          [E.ClassName, E.Message]), ['&OK']);
      end;
    End;
  Finally
    dbgComponentes.Enabled := qryTabela.State in [dsEdit, dsInsert];
    Screen.Cursor := crDefault;
    blnGravou := False;
  End;
end;

procedure TfrmGenericNovasFormulas.btnIncluirClick(Sender: TObject);
begin
  inherited;
  CarregarCampos;
  blnUsaProCodigo := False;
  dbgComponentes.Enabled := qryTabela.State in [dsEdit, dsInsert];
  ConstruirGrid;
  SelectNext(dbeCodigo, True, True);
end;

procedure TfrmGenericNovasFormulas.btnPesquisaClick(Sender: TObject);
  var
    arrSel: TConsultasArray;
    Key: Char;
begin
  key := '/';
  If fPesqGenericaTinta(Self, strNomeTabela, qryTabela, key, arrSel) Then
  Begin
    pSetFocus(btnAlterar);
    ConstruirGrid;
    CarregarCampos;
  End;
end;

procedure TfrmGenericNovasFormulas.CarregarCampos;
begin

end;

procedure TfrmGenericNovasFormulas.CarregarGrid;
var
  intCont: Integer;
  intModos: Integer;
begin
  while not cdsCompoentes.IsEmpty do cdsCompoentes.Delete;
  for intCont := 1 to novaFormula.GetMaximoComponentes do
  begin
    if fEmptyStr(qryCadNfm.FieldByName(novaFormula.GetPrefixoComponente + fStrZero(intCont, 2)).AsString) then
      Break;

    cdsCompoentes.Append;
    cdsCompoentes.FieldByName('Componente').AsString := qryCadNfm.FieldByName(novaFormula.GetPrefixoComponente + fStrZero(intCont, 2)).AsString;
    for intModos := 1 to novaFormula.GetCountModos do
    begin
      cdsCompoentes.FieldByName(Trim('Quantidade ' + novaFormula.GetNomeModo(intModos))).Value :=
        qryCadNfm.FieldByName(novaFormula.GetPrefixoQuantidade(intModos) + fStrZero(intCont, 2)).Value;
    end;
    cdsCompoentes.Post;
  end;

  cdsCompoentes.First;
end;

procedure TfrmGenericNovasFormulas.cdsCompoentesBeforePost(DataSet: TDataSet);
var
  intCont: Integer;
begin
  if fEmptyStr(DataSet.FieldByName('Componente').AsString) then
  begin
    fMensagem('ATENÇÃO!', 'É obrigatório o nome do componente para poder inserir na fórmula!', ['OK']);
    Abort;
  end;

  for intCont := 0 to cdsCompoentes.FieldCount - 1 do
  begin
    if cdsCompoentes.Fields[intCont].IsNull then
      cdsCompoentes.Fields[intCont].Value := GetDefaultValue(cdsCompoentes.Fields[intCont].DataType);
  end;
end;

procedure TfrmGenericNovasFormulas.cdsCompoenteSetText(Sender: TField; const Text: string);
begin
  Try
    if fEmptyStr(Text) then
      raise Exception.Create('É obrigatório o nome do componente para poder inserir na fórmula!');

    if novaFormula.ComponenteValido(Trim(UpperCase(Text)), qryCadNfm) then
    begin
      if IsComponenteCadastrado(Trim(UpperCase(Text))) then
      begin
        cdsCompoentes.Cancel;
        cdsCompoentes.Locate('Componente', VarArrayOf([Trim(UpperCase(Text))]), []);
        raise ExceptionComponenteCadastrado.CreateFmt('O componente [%s] já está cadastrado nessa fórmula!', [Trim(UpperCase(Text))]);
      end;
      
      Sender.AsString := Trim(UpperCase(Text));
    end
    else
    begin
      novaFormula.ValidaComponente(Trim(UpperCase(Text)), qryCadNfm);
    end;
  Except
    on E: Exception do
    begin
      fMensagem('ATENÇÃO', E.Message, ['OK']);
      cdsCompoentes.Cancel;
    end;
  End;
end;

procedure TfrmGenericNovasFormulas.ConstruirGrid;
var
  intCont: Integer;
begin
  cdsCompoentes.Close;
  cdsCompoentes.FieldDefs.Clear;
  cdsCompoentes.FieldDefs.Add('Componente', ftString, novaFormula.GetTamanhoCampoComponente);

  for intCont := 1 to novaFormula.GetCountModos do
    cdsCompoentes.FieldDefs.Add(Trim('Quantidade ' + novaFormula.GetNomeModo(intCont)),
      novaFormula.GetTipoModo(intCont),
      novaFormula.GetTamanhoModo(intCont));

  cdsCompoentes.CreateDataSet;
  cdsCompoentes.FieldByName('Componente').OnSetText := cdsCompoenteSetText;
  cdsCompoentes.IndexFieldNames := 'Componente';
  dbgvComponentes.ClearItems;
  dbgvComponentes.DataController.CreateAllItems();
  CarregarGrid;
  dbgvComponentes.ApplyBestFit();
end;

constructor TfrmGenericNovasFormulas.Create(AOwner: TComponent);
begin
  inherited;
end;

constructor TfrmGenericNovasFormulas.Create(AOwner: TComponent; const novaFormula: INovaFormula);
begin
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;
  conf := fGetConfTinta(novaFormula.GetIdePro);
  Self.novaFormula := novaFormula;
  inherited Create(AOwner);
  qryCadNfm := fCriarQuery(novaFormula.GetSqlSelectNovasFormulas, Self);
  dtsCadNfm := fCriaDataSource(qryCadNfm);

  pCriaDataSets;
  pLigaDataSets;

  qryTabela := qryCadNfm;
  strNomeTabela := novaFormula.GetNomeTabelaNovaFormula;
  strNomeCampo := 'NFM_CODNFM';

  pSetCamposChaves;

  Self.Caption := 'Cadastro de novas fórmulas - ' + fRetornaNomeTinta(novaFormula.GetIdePro);
  pnlCabecalho.Caption := Self.Caption;
  ConstruirGrid;
  fInsereProCod(novaFormula.GetNomeTabelaNovaFormula);
end;

procedure TfrmGenericNovasFormulas.dbgComponentesEnter(Sender: TObject);
begin
  if dbgvComponentes.DataController.RowCount = 0 then
  begin
    dbgvComponentes.DataController.NewItemRowFocused := True;
    dbgvComponentes.Items[0].Editing := True;
  end;
end;

procedure TfrmGenericNovasFormulas.dbgvComponentesEditKeyPress(Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
var
  qryGen : TUniQuery;
  arrSel: TConsultasArray;
begin
  if not Assigned(AItem) then
    Exit;

  if not (AItem is TcxGridDBColumn) then
    Exit;

  if (AItem as TcxGridDBColumn).DataBinding.FieldName <> 'Componente' then
    Exit;

  qryGen :=  fCriaQuery;
  Try
    Try
      If fPesqGenericaTinta(Self, novaFormula.GetNomeTabelaComponete, qryGen, Key, arrSel) Then
      begin
        if IsComponenteCadastrado(qryGen.FieldByName(novaFormula.GetNomeCampoComponente).AsString) then
           raise ExceptionComponenteCadastrado.CreateFmt('O componente [%s] já está cadastrado nessa fórmula!',
           [Trim(UpperCase(qryGen.FieldByName(novaFormula.GetNomeCampoComponente).AsString))]);
        AItem.EditValue := qryGen.FieldByName(novaFormula.GetNomeCampoComponente).AsString;
        if (AItem.Index + 1) < (AItem.GridView.ItemCount) then
           AItem.GridView.Items[AItem.Index + 1].Editing := True;
      End;
    Except
      on E: ExceptionComponenteCadastrado do
      begin
        fMensagem('ATENÇÃO', Format('%s', [E.Message]), ['&Ok']);
      end;

      on E: Exception do
      begin
        fMensagem('ATENÇÃO', Format('%s: %s', [E.ClassName, E.Message]), ['&Ok']);
      end;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

destructor TfrmGenericNovasFormulas.Destroy;
begin
  if Assigned(stlCampos) then FreeAndNil(stlCampos);
  if Assigned(stlCamInd) then FreeAndNil(stlCamInd);
  if Assigned(stlDesInd) then FreeAndNil(stlDesInd);
  if Assigned(dtsCadNfm) then FreeAndNil(dtsCadNfm);
  if Assigned(qryCadNfm) then FreeAndNil(qryCadNfm);
  inherited Destroy;
end;

procedure TfrmGenericNovasFormulas.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(btnPesquisa);
end;

procedure TfrmGenericNovasFormulas.FormShow(Sender: TObject);
begin
  inherited;
  dbgComponentes.Enabled := qryTabela.State in [dsEdit, dsInsert];
end;

function TfrmGenericNovasFormulas.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  CarregarCampos;
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    if (Sender = dbeCodigo) then
    begin
      if fEmptyStr(dbeCodigo.Text) then
      begin
        fMensagem('ATENÇÃO', 'O campo código deve ser preenchido!', ['&OK']);
        Result := False;
      end;
    end
    else if (Sender = dbgComponentes) then
    begin
      Result := ValidarComposicao;
    end;
  End;

  If Not (Result) Then
    pSetFocus(Sender);
end;

function TfrmGenericNovasFormulas.GetDefaultValue(fieldType: TFieldType): Variant;
begin
  Result := Null;
  case fieldType of
    ftWideMemo, ftWideString, ftFmtMemo, ftMemo, ftString: Result := '';
    ftLargeint, ftAutoInc, ftSmallint, ftInteger, ftWord, ftFloat, ftCurrency, ftBCD: Result := 0;
    ftBoolean: Result := False;
  end;

end;

function TfrmGenericNovasFormulas.IsComponenteCadastrado(const strComponente: string): Boolean;
var
  intRecordIndex: Integer;
begin
  Result := False;

  for intRecordIndex := 0 to dbgvComponentes.DataController.RowCount - 1 do
  begin
    Result := SameText(dbgvComponentes.DataController.DisplayTexts[intRecordIndex, 0], strComponente)
      and (intRecordIndex <> dbgvComponentes.DataController.FocusedRowIndex);
    if Result then
      Exit;    
  end;
end;

procedure TfrmGenericNovasFormulas.pCriaDataSets;
begin
  qryCadNfm.FieldByName('NFM_CODNFM').DisplayLabel := 'Código';
  novaFormula.pCriaDataSets(qryCadNfm);
end;

procedure TfrmGenericNovasFormulas.pInicializaIndices;
begin
  inherited;
  stlCampos.Add('NFM_CODNFM');
  stlCampos.Add('AUTOINCREM');
  stlCamInd.Add('NFM_CODNFM');
  stlDesInd.Add('Código');
  novaFormula.pInicializaIndices(stlCampos, stlCamInd, stlDesInd);
end;

procedure TfrmGenericNovasFormulas.pLigaDataSets;
var
  intCont: Integer;
begin
  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
    Begin
      (Components[intCont] as TDBEdit).DataSource := dtsCadNfm;
    End;
  End;

  dbeCodigo.DataField := 'NFM_CODNFM';
end;

procedure TfrmGenericNovasFormulas.pSetCamposChaves;
var
  arrChaves: array of string;
  intComp: Integer;
  componente: TComponent;
  intChave: Integer;
begin
  SetLength(arrCamposChave, novaFormula.GetCountCamposChaves);
  SetLength(arrChaves, novaFormula.GetCountCamposChaves);
  novaFormula.GetCamposChaves(arrChaves);

  for intChave := 0 to Length(arrChaves) - 1 do
  begin
    for intComp := 0 to ComponentCount - 1 do
    begin
      componente := Components[intComp];
      if componente is TWinControl then
      begin
        if Assigned(GetPropInfo(componente, 'DataField')) then
        begin
          if VarToStrDef(GetPropValue(componente, 'DataField'), '') = arrChaves[intChave] then
          begin
            arrCamposChave[intChave] := TWinControl(componente);
            Break;
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmGenericNovasFormulas.SalvarComposicao;
var
  intModos: Integer;
begin
  Try
    Try
      cdsCompoentes.DisableControls;
      cdsCompoentes.First;
      while not cdsCompoentes.Eof do
      begin
        qryCadNfm.FieldByName(novaFormula.GetPrefixoComponente + fStrZero(cdsCompoentes.RecNo, 2)).AsString := cdsCompoentes.FieldByName('Componente').AsString;
        for intModos := 1 to novaFormula.GetCountModos do
        begin
          qryCadNfm.FieldByName(novaFormula.GetPrefixoQuantidade(intModos) + fStrZero(cdsCompoentes.RecNo, 2)).Value :=
            cdsCompoentes.FieldByName(Trim('Quantidade ' + novaFormula.GetNomeModo(intModos))).Value;
        end;
        cdsCompoentes.Next;
      end;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    cdsCompoentes.EnableControls;
  End;

end;

function TfrmGenericNovasFormulas.ValidarComposicao: Boolean;
var
  intX: Integer;
  intY: Integer;
  blnLinhaVazia: Boolean;
begin
  Result := True;

  if (dbgvComponentes.DataController.RowCount = 0) then
  begin
    Result := False;
    dbgvComponentes.DataController.NewItemRowFocused := True;
    fMensagem('ATENÇÃO', 'É obrigatório pelo menos um componente na fórmula!', ['OK']);
    Exit;
  end;

  for intX := 0 to dbgvComponentes.DataController.RowCount - 1 do
  begin
    blnLinhaVazia := True;
    for intY := 1 to dbgvComponentes.ItemCount - 1 do
    begin
      blnLinhaVazia := blnLinhaVazia
        and (novaFormula.IsValorVazio(dbgvComponentes.DataController.DisplayTexts[intX, intY]));
    end;

    if blnLinhaVazia then
    begin
      Result := False;
      dbgvComponentes.DataController.FocusedRowIndex := intX;
      dbgvComponentes.Items[1].Editing := True;
      fMensagem('ATENÇÃO', 'É obrigatório que a quantidade seja maior que zero!', ['OK']);
      Exit;
    end;
  end;

end;

initialization
  RegisterClass(TfrmGenericNovasFormulas);
finalization
  UnRegisterClass(TfrmGenericNovasFormulas);

end.

