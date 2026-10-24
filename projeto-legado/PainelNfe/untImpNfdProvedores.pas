unit untImpNfdProvedores;

{
  Editor da impressao dinamica: cadastro de provedores (IMPNFE_PRV) e acesso a
  Datasets, Variaveis, Testar, Comparar e Exportar.
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DB, DBCtrls,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData,
  cxTextEdit, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid,
  {$IFDEF VER300}
  cxDataControllerConditionalFormattingRulesManagerDialog,
  {$ENDIF}
{$IF Defined(UNIDAC)}
  Uni;
{$ELSE}
  ZConnection, ZDataset;
{$IFEND}

type
  TfrmImpNfdProvedores = class(TForm)
    grdPrv: TcxGrid;
    tbvPrv: TcxGridDBTableView;
    tbvPrvPRV_NOME: TcxGridDBColumn;
    tbvPrvPRV_DESCRI: TcxGridDBColumn;
    lvlPrv: TcxGridLevel;
    pnlCampos: TPanel;
    lblNome: TLabel;
    dbeNome: TDBEdit;
    lblDescri: TLabel;
    dbeDescri: TDBEdit;
    btnSalvar: TButton;
    btnNovo: TButton;
    btnEditar: TButton;
    btnExcluir: TButton;
    btnCancelar: TButton;
    btnCds: TButton;
    btnVars: TButton;
    btnTestar: TButton;
    btnExportar: TButton;
    btnComparar: TButton;
    btnFechar: TButton;
    dtsPrv: TDataSource;
    dlgExportar: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure dtsPrvStateChange(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnCdsClick(Sender: TObject);
    procedure btnVarsClick(Sender: TObject);
    procedure btnTestarClick(Sender: TObject);
    procedure btnExportarClick(Sender: TObject);
    procedure btnCompararClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
  private
    qryPrv: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    // resposta do Novo: carregar os dados padrões (IMPNFE_PRD) no Salvar
    FCarregaPadrao: Boolean;
    procedure pAbrir(const ALocalizar: String = '');
    procedure pAjustaBotoes;
    procedure pHabilitaCampos(AHabilita: Boolean);
    function fEmEdicao: Boolean;
    function fTemRegistro: Boolean;
    procedure pCarregaPadrao(const APrv: String; out AQtdCds, AQtdFld, AQtdVar: Integer);
    function fSqlTexto(const AValor: String): String;
    function fSqlValor(AField: TField): String;
    function fExportaTabela(ALinhas: TStrings; const ATabela, ACampoPrv, AOrdem, APrv: String): Integer;
    function fMontaUpdateLayout(const AEmp, AModelo, AVersao: String; out AUpdate: String): Boolean;
    procedure pGravaUtf8(const AArquivo: String; ALinhas: TStrings);
    procedure pCompararNFCe;
  public
    { Public declarations }
  end;

var
  frmImpNfdProvedores: TfrmImpNfdProvedores;

implementation

uses
  untUtil, untImpNfdCds, untImpNfdVariaveis, untImpNfdTestar, untNfeDinamico,
  untNfceDinamico;

{$R *.dfm}

{ TfrmImpNfdProvedores }

procedure TfrmImpNfdProvedores.FormCreate(Sender: TObject);
begin
  qryPrv := fCriaQuery(Self);
  qryPrv.SQL.Text := 'SELECT PRV_NOME, PRV_DESCRI FROM IMPNFE_PRV ORDER BY PRV_NOME';
{$IF Defined(UNIDAC)}
  qryPrv.KeyFields := 'PRV_NOME';
{$IFEND}
  dtsPrv.DataSet := qryPrv;
end;

procedure TfrmImpNfdProvedores.FormShow(Sender: TObject);
begin
  pAbrir;
end;

procedure TfrmImpNfdProvedores.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if fEmEdicao then
  begin
    if MessageDlg('Existem alterações não salvas. Deseja descartá-las e sair?',
         mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      qryPrv.Cancel
    else
      CanClose := False;
  end;
end;

procedure TfrmImpNfdProvedores.pAbrir(const ALocalizar: String);
begin
  qryPrv.Close;
  qryPrv.Open;
  if ALocalizar <> '' then
    qryPrv.Locate('PRV_NOME', ALocalizar, []);
  pAjustaBotoes;
end;

function TfrmImpNfdProvedores.fEmEdicao: Boolean;
begin
  Result := Assigned(qryPrv) and (qryPrv.State in [dsEdit, dsInsert]);
end;

function TfrmImpNfdProvedores.fTemRegistro: Boolean;
begin
  Result := Assigned(qryPrv) and qryPrv.Active and (not qryPrv.IsEmpty);
end;

procedure TfrmImpNfdProvedores.pHabilitaCampos(AHabilita: Boolean);
var
  i: Integer;
begin
  for i := 0 to pnlCampos.ControlCount - 1 do
  begin
    if pnlCampos.Controls[i] is TLabel then
      Continue;
    pnlCampos.Controls[i].Enabled := AHabilita;
  end;
end;

procedure TfrmImpNfdProvedores.pAjustaBotoes;
var
  blnEdicao, blnReg: Boolean;
begin
  if (csDestroying in ComponentState) or (not Assigned(qryPrv)) then
    Exit;

  blnEdicao := fEmEdicao;
  blnReg    := fTemRegistro;

  btnSalvar.Enabled   := blnEdicao;
  btnCancelar.Enabled := blnEdicao;
  btnNovo.Enabled     := qryPrv.Active and (not blnEdicao);
  btnEditar.Enabled   := blnReg and (not blnEdicao);
  btnExcluir.Enabled  := blnReg and (not blnEdicao);

  btnCds.Enabled    := blnReg and (not blnEdicao);
  btnVars.Enabled   := blnReg and (not blnEdicao);
  btnTestar.Enabled := blnReg and (not blnEdicao);
  btnExportar.Enabled := blnReg and (not blnEdicao);
  // comparador: somente NOTA_FISCAL e CUPOM_FISCAL
  btnComparar.Enabled := blnReg and (not blnEdicao) and
    (SameText(qryPrv.FieldByName('PRV_NOME').AsString, cstProvedorNotaFiscal) or
     SameText(qryPrv.FieldByName('PRV_NOME').AsString, cstProvedorCupomFiscal));

  grdPrv.Enabled := not blnEdicao;
  pHabilitaCampos(blnEdicao);
  // o nome é a chave (PK): só pode ser informado na inclusão
  dbeNome.Enabled := blnEdicao and (qryPrv.State = dsInsert);
end;

procedure TfrmImpNfdProvedores.dtsPrvStateChange(Sender: TObject);
begin
  // os dados padrões valem somente para a inclusão em andamento
  if Assigned(qryPrv) and (qryPrv.State <> dsInsert) then
    FCarregaPadrao := False;
  pAjustaBotoes;
end;

procedure TfrmImpNfdProvedores.btnNovoClick(Sender: TObject);
var
  blnPadrao: Boolean;
begin
  if fEmEdicao then
    Exit;

  blnPadrao := MessageDlg('Deseja carregar os dados padrões (datasets, campos e variáveis) ' +
    'no novo provedor?', mtConfirmation, [mbYes, mbNo], 0) = mrYes;

  qryPrv.Append;
  FCarregaPadrao := blnPadrao;
  dbeNome.SetFocus;
end;

procedure TfrmImpNfdProvedores.btnEditarClick(Sender: TObject);
begin
  if (not fTemRegistro) or fEmEdicao then
    Exit;
  qryPrv.Edit;
  dbeDescri.SetFocus;
end;

procedure TfrmImpNfdProvedores.btnCancelarClick(Sender: TObject);
begin
  if fEmEdicao then
    qryPrv.Cancel;
end;

procedure TfrmImpNfdProvedores.btnSalvarClick(Sender: TObject);
var
  qry: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  blnInserindo, blnPadrao, blnTransacao: Boolean;
  strNome: String;
  intQtd, intQtdCds, intQtdFld, intQtdVar: Integer;
begin
  if not fEmEdicao then
    Exit;

  qryPrv.UpdateRecord;

  strNome := Trim(qryPrv.FieldByName('PRV_NOME').AsString);
  if fEmptyStr(strNome) then
  begin
    MessageDlg('Informe o nome do provedor.', mtInformation, [mbOk], 0);
    dbeNome.SetFocus;
    Exit;
  end;

  intQtdCds := 0;
  intQtdFld := 0;
  intQtdVar := 0;

  blnInserindo := (qryPrv.State = dsInsert);
  blnPadrao    := blnInserindo and FCarregaPadrao;

  // o nome é a chave: não pode repetir
  if blnInserindo then
  begin
    // NOTA_FISCAL e reservado (criado pelo script 003)
    if SameText(strNome, cstProvedorNotaFiscal) then
    begin
      MessageDlg('O nome "' + cstProvedorNotaFiscal + '" é reservado para a NF-e e não pode ser incluído manualmente.',
        mtInformation, [mbOk], 0);
      dbeNome.SetFocus;
      Exit;
    end;

    // CUPOM_FISCAL e reservado (criado pelo script 004)
    if SameText(strNome, cstProvedorCupomFiscal) then
    begin
      MessageDlg('O nome "' + cstProvedorCupomFiscal + '" é reservado para a NFC-e e não pode ser incluído manualmente.',
        mtInformation, [mbOk], 0);
      Exit;
    end;

    qry := fCriaQuery(Self);
    try
      qry.SQL.Text := 'SELECT COUNT(*) AS QTD FROM IMPNFE_PRV WHERE PRV_NOME = :NOME';
      qry.ParamByName('NOME').AsString := strNome;
      qry.Open;
      intQtd := qry.FieldByName('QTD').AsInteger;
      qry.Close;
    finally
      FreeAndNil(qry);
    end;

    if intQtd > 0 then
    begin
      MessageDlg('Já existe o provedor "' + strNome + '".', mtInformation, [mbOk], 0);
      dbeNome.SetFocus;
      Exit;
    end;

    qryPrv.FieldByName('PRV_NOME').AsString := strNome;
  end;

  // com dados padrões: provedor + datasets/campos/variáveis na mesma transação
  blnTransacao := blnPadrao and (not qryPrv.Connection.InTransaction);
  if blnTransacao then
    qryPrv.Connection.StartTransaction;
  try
    qryPrv.Post;

    if blnPadrao then
      pCarregaPadrao(strNome, intQtdCds, intQtdFld, intQtdVar);

    if blnTransacao then
      qryPrv.Connection.Commit;
  except
    on E: Exception do
    begin
      if blnTransacao and qryPrv.Connection.InTransaction then
        qryPrv.Connection.Rollback;
      MessageDlg('Não foi possível salvar o provedor.' + sLineBreak + E.Message, mtError, [mbOk], 0);
      // Post já feito e desfeito pelo Rollback: recarrega para não exibir registro inexistente
      if blnPadrao and (qryPrv.State = dsBrowse) then
        pAbrir;
      Exit;
    end;
  end;

  pAbrir(strNome);

  if blnPadrao then
  begin
    if (intQtdCds + intQtdFld + intQtdVar) = 0 then
      MessageDlg('Provedor gravado, mas não há dados padrões cadastrados na IMPNFE_PRD.',
        mtWarning, [mbOk], 0)
    else
      MessageDlg('Provedor gravado com os dados padrões:' + sLineBreak +
        IntToStr(intQtdCds) + ' dataset(s), ' + IntToStr(intQtdFld) + ' campo(s) e ' +
        IntToStr(intQtdVar) + ' variável(is).' + sLineBreak +
        'Preencha o caminho do XML dos campos na tela de Datasets.', mtInformation, [mbOk], 0);
  end;
end;

procedure TfrmImpNfdProvedores.pCarregaPadrao(const APrv: String;
  out AQtdCds, AQtdFld, AQtdVar: Integer);
var
  qry: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  AQtdCds := 0;
  AQtdFld := 0;
  AQtdVar := 0;

  if fEmptyStr(APrv) then
    raise Exception.Create('Provedor não identificado para carregar os dados padrões.');

  qry := fCriaQuery(Self);
  try
    // datasets
    qry.SQL.Text :=
      'INSERT INTO IMPNFE_CDS (CDS_CODPRV, CDS_NOMCDS, CDS_NOMFRX, CDS_ORIGEM, CDS_SELECT) ' +
      'SELECT :PRV, PRD_NOMCDS, PRD_NOMFRX, IFNULL(PRD_ORIGEM, ''X''), PRD_SELECT ' +
      'FROM IMPNFE_PRD WHERE PRD_TIPO = ''C''';
    qry.ParamByName('PRV').AsString := APrv;
    qry.ExecSQL;
    AQtdCds := qry.RowsAffected;

    // campos: somente dos datasets criados acima; caminhos do XML (principal e auxiliar) em branco
    qry.SQL.Text :=
      'INSERT INTO IMPNFE_FLD (FLD_CODPRV, FLD_CODCDS, FLD_NOME, FLD_TIPO, FLD_CAMINH, FLD_CAMAUX, FLD_AJUSTE, FLD_DEFAUL) ' +
      'SELECT c.CDS_CODPRV, c.CDS_NOMCDS, p.PRD_NOME, p.PRD_TIPDAD, '''', '''', p.PRD_AJUSTE, p.PRD_DEFAUL ' +
      'FROM IMPNFE_PRD p ' +
      'JOIN IMPNFE_CDS c ON c.CDS_CODPRV = :PRV AND c.CDS_NOMCDS = p.PRD_NOMCDS ' +
      'WHERE p.PRD_TIPO = ''F''';
    qry.ParamByName('PRV').AsString := APrv;
    qry.ExecSQL;
    AQtdFld := qry.RowsAffected;

    // variáveis
    qry.SQL.Text :=
      'INSERT INTO IMPNFE_VAR (VAR_CODPRV, VAR_NOME, VAR_ORIGEM, VAR_CAMPO, VAR_SELECT, ' +
      'VAR_TIPO, VAR_FORMAT, VAR_FUNC, VAR_DEFAUL, VAR_ORDEM) ' +
      'SELECT :PRV, PRD_NOME, IFNULL(PRD_ORIGEM, ''C''), PRD_CAMPO, PRD_SELECT, ' +
      'IFNULL(PRD_TIPDAD, ''STR''), PRD_FORMAT, PRD_FUNC, PRD_DEFAUL, PRD_ORDEM ' +
      'FROM IMPNFE_PRD WHERE PRD_TIPO = ''V''';
    qry.ParamByName('PRV').AsString := APrv;
    qry.ExecSQL;
    AQtdVar := qry.RowsAffected;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TfrmImpNfdProvedores.btnExcluirClick(Sender: TObject);
var
  qry: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  intQtdCds: Integer;
  strNome: String;
begin
  if (not fTemRegistro) or fEmEdicao then
    Exit;

  strNome := qryPrv.FieldByName('PRV_NOME').AsString;

  qry := fCriaQuery(Self);
  try
    qry.SQL.Text := 'SELECT COUNT(*) AS QTD FROM IMPNFE_CDS WHERE CDS_CODPRV = :PRV';
    qry.ParamByName('PRV').AsString := strNome;
    qry.Open;
    intQtdCds := qry.FieldByName('QTD').AsInteger;
    qry.Close;

    if intQtdCds > 0 then
    begin
      MessageDlg('Existem datasets (CDS) vinculados a este provedor.' + sLineBreak +
        'Exclua os datasets antes de excluir o provedor.', mtInformation, [mbOk], 0);
      Exit;
    end;

    if MessageDlg('Deseja realmente excluir o provedor "' + strNome + '" e as suas variáveis?',
         mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
      Exit;

    qry.SQL.Text := 'DELETE FROM IMPNFE_VAR WHERE VAR_CODPRV = :PRV';
    qry.ParamByName('PRV').AsString := strNome;
    qry.ExecSQL;
  finally
    FreeAndNil(qry);
  end;

  qryPrv.Delete;
  pAjustaBotoes;
end;

procedure TfrmImpNfdProvedores.btnCdsClick(Sender: TObject);
var
  frm: TfrmImpNfdCds;
begin
  if (not fTemRegistro) or fEmEdicao then
    Exit;

  frm := TfrmImpNfdCds.Create(nil);
  try
    frm.NomePrv := qryPrv.FieldByName('PRV_NOME').AsString;
    frm.ShowModal;
  finally
    FreeAndNil(frm);
  end;
end;

procedure TfrmImpNfdProvedores.btnVarsClick(Sender: TObject);
var
  frm: TfrmImpNfdVariaveis;
begin
  if (not fTemRegistro) or fEmEdicao then
    Exit;

  frm := TfrmImpNfdVariaveis.Create(nil);
  try
    frm.NomePrv := qryPrv.FieldByName('PRV_NOME').AsString;
    frm.ShowModal;
  finally
    FreeAndNil(frm);
  end;
end;

procedure TfrmImpNfdProvedores.btnTestarClick(Sender: TObject);

  function fEscolheTeste: Integer;
  var
    dlg: TForm;
    cmp: TComponent;
  begin
    dlg := CreateMessageDialog('Deseja abrir o layout (fr3) ou ver os dados montados (datasets e variáveis)?',
      mtConfirmation, [mbYes, mbNo, mbCancel]);
    try
      dlg.Caption := 'Testar layout';
      cmp := dlg.FindComponent('Yes');
      if cmp is TButton then
        TButton(cmp).Caption := 'Abrir fr3';
      cmp := dlg.FindComponent('No');
      if cmp is TButton then
        TButton(cmp).Caption := 'Ver dados';
      cmp := dlg.FindComponent('Cancel');
      if cmp is TButton then
        TButton(cmp).Caption := 'Cancelar';
      Result := dlg.ShowModal;
    finally
      FreeAndNil(dlg);
    end;
  end;

var
  strChave, strDocumento, strLayout: String;
  blnNFe, blnNFCe: Boolean;
  intOpcao: Integer;
begin
  if (not fTemRegistro) or fEmEdicao then
    Exit;

  blnNFe := SameText(qryPrv.FieldByName('PRV_NOME').AsString, cstProvedorNotaFiscal);
  blnNFCe := SameText(qryPrv.FieldByName('PRV_NOME').AsString, cstProvedorCupomFiscal);
  if blnNFe then
    strDocumento := 'NF-e'
  else if blnNFCe then
    strDocumento := 'NFC-e'
  else
    strDocumento := 'NFS-e';

  strChave := '';
  if not InputQuery('Testar layout', 'Informe a chave de acesso da ' + strDocumento + ':', strChave) then
    Exit;

  strChave := Trim(strChave);
  if fEmptyStr(strChave) then
    Exit;

  intOpcao := fEscolheTeste;
  if intOpcao = mrNo then
  begin
    TImpNfdTestar.pVerDados(qryPrv.FieldByName('PRV_NOME').AsString, strChave);
    Exit;
  end;
  if intOpcao <> mrYes then
    Exit;

  if blnNFe then
  begin
    strLayout := 'R';
    if not InputQuery('Testar layout NF-e', 'Layout (R = retrato, P = paisagem, S = simplificado):', strLayout) then
      Exit;
    strLayout := UpperCase(Trim(strLayout));
    if (strLayout <> 'R') and (strLayout <> 'P') and (strLayout <> 'S') then
    begin
      MessageDlg('Layout inválido: informe R, P ou S.', mtInformation, [mbOk], 0);
      Exit;
    end;
    TImpNfdTestar.pTestarNFe(strChave, strLayout);
    Exit;
  end;

  if blnNFCe then
  begin
    TImpNfdTestar.pTestarNFCe(strChave, 'D');
    Exit;
  end;

  TImpNfdTestar.pTestar(qryPrv.FieldByName('PRV_NOME').AsString, strChave);
end;

procedure TfrmImpNfdProvedores.btnCompararClick(Sender: TObject);
var
  strChave: String;
begin
  // compara os datasets da rotina antiga com os do provedor dinamico
  if (not fTemRegistro) or fEmEdicao then
    Exit;
  if SameText(qryPrv.FieldByName('PRV_NOME').AsString, cstProvedorCupomFiscal) then
  begin
    pCompararNFCe;
    Exit;
  end;
  if not SameText(qryPrv.FieldByName('PRV_NOME').AsString, cstProvedorNotaFiscal) then
    Exit;

  strChave := '';
  if not InputQuery('Comparar rotina antiga x nova', 'Informe a chave de acesso da NF-e:', strChave) then
    Exit;

  strChave := Trim(strChave);
  if fEmptyStr(strChave) then
    Exit;

  Screen.Cursor := crHourGlass;
  try
    TImpNfdTestar.pTestarNFe(strChave, 'C');
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmImpNfdProvedores.pCompararNFCe;
var
  strInformado: String;
begin
  // NFC-e: uma chave ou uma pasta de XMLs (lote)
  strInformado := '';
  if not InputQuery('Comparar rotina antiga x nova - NFC-e',
    'Informe a chave de acesso da NFC-e ou a pasta com os XMLs (lote):', strInformado) then
    Exit;

  strInformado := Trim(strInformado);
  if fEmptyStr(strInformado) then
    Exit;

  if DirectoryExists(strInformado) then
  begin
    TImpNfdTestar.pCompararLoteNFCe(strInformado);
    Exit;
  end;

  Screen.Cursor := crHourGlass;
  try
    TImpNfdTestar.pTestarNFCe(strInformado, 'C');
  finally
    Screen.Cursor := crDefault;
  end;
end;

{ ------------------------------ Exportar ------------------------------ }

function TfrmImpNfdProvedores.fSqlTexto(const AValor: String): String;
begin
  // literal MySQL: barra invertida primeiro, depois aspas e quebras de linha (texto nao tem #0)
  Result := StringReplace(AValor, '\', '\\', [rfReplaceAll]);
  Result := StringReplace(Result, '''', '''''', [rfReplaceAll]);
  Result := StringReplace(Result, #10, '\n', [rfReplaceAll]);
  Result := StringReplace(Result, #13, '\r', [rfReplaceAll]);
  Result := StringReplace(Result, #26, '\Z', [rfReplaceAll]);
  Result := '''' + Result + '''';
end;

function TfrmImpNfdProvedores.fSqlValor(AField: TField): String;
begin
  if AField.IsNull then
    Result := 'NULL'
  else if AField.DataType in [ftSmallint, ftInteger, ftWord, ftLargeint, ftAutoInc] then
    Result := AField.AsString
  else if AField.DataType in [ftFloat, ftCurrency, ftBCD, ftFMTBcd] then
    Result := StringReplace(AField.AsString, ',', '.', [rfReplaceAll])
  else
    Result := fSqlTexto(AField.AsString);
end;

function TfrmImpNfdProvedores.fExportaTabela(ALinhas: TStrings;
  const ATabela, ACampoPrv, AOrdem, APrv: String): Integer;
var
  qry: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  strCampos, strValores: String;
  i: Integer;
begin
  // um INSERT por registro, com todas as colunas da tabela (SELECT *)
  Result := 0;
  ALinhas.Add('');
  ALinhas.Add('/* ' + ATabela + ' */');

  qry := fCriaQuery(Self);
  try
    qry.SQL.Text := 'SELECT * FROM ' + ATabela + ' WHERE ' + ACampoPrv + ' = :PRV ORDER BY ' + AOrdem;
    qry.ParamByName('PRV').AsString := APrv;
    qry.Open;

    strCampos := '';
    for i := 0 to qry.FieldCount - 1 do
    begin
      if strCampos <> '' then
        strCampos := strCampos + ', ';
      strCampos := strCampos + qry.Fields[i].FieldName;
    end;

    while not qry.Eof do
    begin
      strValores := '';
      for i := 0 to qry.FieldCount - 1 do
      begin
        if strValores <> '' then
          strValores := strValores + ', ';
        strValores := strValores + fSqlValor(qry.Fields[i]);
      end;
      ALinhas.Add('INSERT INTO ' + ATabela + ' (' + strCampos + ') VALUES (' + strValores + ');');
      Inc(Result);
      qry.Next;
    end;
    qry.Close;
  finally
    FreeAndNil(qry);
  end;
end;

function TfrmImpNfdProvedores.fMontaUpdateLayout(const AEmp, AModelo, AVersao: String;
  out AUpdate: String): Boolean;
var
  qry: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  blnLayDms: Boolean;
begin
  // layout dinâmico (campos novos da IMPNFE) em formato de UPDATE
  Result  := False;
  AUpdate := '';

  qry := fCriaQuery(Self);
  try
    // NF-e: tambem o layout simplificado (NFE_LAYDMS)
    blnLayDms := SameText(AModelo, 'NFE') and fCampoExiste('IMPNFE', 'NFE_LAYDMS');
    if blnLayDms then
      qry.SQL.Text :=
        'SELECT NFE_LAYDMP, NFE_LAYDMR, NFE_LAYDMS FROM IMPNFE ' +
        'WHERE NFE_CODEMP = :EMP AND NFE_MODELO = :MODELO AND NFE_VERSAO = :VERSAO'
    else
      qry.SQL.Text :=
        'SELECT NFE_LAYDMP, NFE_LAYDMR FROM IMPNFE ' +
        'WHERE NFE_CODEMP = :EMP AND NFE_MODELO = :MODELO AND NFE_VERSAO = :VERSAO';
    qry.ParamByName('EMP').AsString    := AEmp;
    qry.ParamByName('MODELO').AsString := AModelo;
    qry.ParamByName('VERSAO').AsString := AVersao;
    qry.Open;
    if not qry.IsEmpty then
    begin
      AUpdate :=
        'UPDATE IMPNFE SET ' +
        'NFE_LAYDMP = ' + fSqlValor(qry.FieldByName('NFE_LAYDMP')) + ', ' +
        'NFE_LAYDMR = ' + fSqlValor(qry.FieldByName('NFE_LAYDMR')) + ' ';
      if blnLayDms then
        AUpdate := AUpdate + ', NFE_LAYDMS = ' + fSqlValor(qry.FieldByName('NFE_LAYDMS')) + ' ';
      AUpdate := AUpdate +
        'WHERE NFE_CODEMP = ' + fSqlTexto(AEmp) +
        ' AND NFE_MODELO = ' + fSqlTexto(AModelo) +
        ' AND NFE_VERSAO = ' + AVersao + ';';
      Result := True;
    end;
    qry.Close;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TfrmImpNfdProvedores.pGravaUtf8(const AArquivo: String; ALinhas: TStrings);
var
  fs: TFileStream;
{$IF CompilerVersion >= 20}
  bytes: TBytes;
{$ELSE}
  strUtf8: AnsiString;
{$IFEND}
begin
  // UTF-8 sem BOM (o script começa com SET NAMES utf8)
  fs := TFileStream.Create(AArquivo, fmCreate);
  try
{$IF CompilerVersion >= 20}
    bytes := TEncoding.UTF8.GetBytes(ALinhas.Text);
    if Length(bytes) > 0 then
      fs.WriteBuffer(bytes[0], Length(bytes));
{$ELSE}
    strUtf8 := UTF8Encode(ALinhas.Text);
    if Length(strUtf8) > 0 then
      fs.WriteBuffer(strUtf8[1], Length(strUtf8));
{$IFEND}
  finally
    FreeAndNil(fs);
  end;
end;

procedure TfrmImpNfdProvedores.btnExportarClick(Sender: TObject);
var
  lst: TStringList;
  strPrv, strEmp, strModelo, strVersao, strUpdate, strMsgLayout: String;
  intResp, intQtdPrv, intQtdCds, intQtdFld, intQtdVar, i: Integer;
  blnLayout: Boolean;
begin
  if (not fTemRegistro) or fEmEdicao then
    Exit;

  strPrv := qryPrv.FieldByName('PRV_NOME').AsString;

  intResp := MessageDlg('Deseja exportar junto o layout fr3 da nota (IMPNFE: NFE_LAYDMP/NFE_LAYDMR)?',
    mtConfirmation, [mbYes, mbNo, mbCancel], 0);
  if intResp = mrCancel then
    Exit;
  blnLayout := (intResp = mrYes);

  intQtdPrv := 0;
  intQtdCds := 0;
  intQtdFld := 0;
  intQtdVar := 0;

  strUpdate    := '';
  strMsgLayout := '';
  if blnLayout then
  begin
    if not (fCampoExiste('IMPNFE', 'NFE_LAYDMP') and fCampoExiste('IMPNFE', 'NFE_LAYDMR')) then
    begin
      MessageDlg('Os campos NFE_LAYDMP/NFE_LAYDMR não existem na IMPNFE (rodar o SCRIPT_PAINEL_002).',
        mtInformation, [mbOk], 0);
      Exit;
    end;

    strEmp    := '';
    strModelo := 'NFS';
    if SameText(strPrv, cstProvedorNotaFiscal) then
      strModelo := 'NFE';
    if SameText(strPrv, cstProvedorCupomFiscal) then
      strModelo := 'NFCE';
    strVersao := '4.00';
    if not InputQuery('Exportar layout', 'Empresa (NFE_CODEMP):', strEmp) then
      Exit;
    if not InputQuery('Exportar layout', 'Modelo (NFE_MODELO):', strModelo) then
      Exit;
    if not InputQuery('Exportar layout', 'Versão (NFE_VERSAO):', strVersao) then
      Exit;

    strEmp    := Trim(strEmp);
    strModelo := UpperCase(Trim(strModelo));
    strVersao := StringReplace(Trim(strVersao), ',', '.', [rfReplaceAll]);

    if fEmptyStr(strEmp) or fEmptyStr(strModelo) or fEmptyStr(strVersao) then
    begin
      MessageDlg('Informe a empresa, o modelo e a versão.', mtInformation, [mbOk], 0);
      Exit;
    end;

    // a versão vai direto no UPDATE: só dígitos e ponto
    for i := 1 to Length(strVersao) do
      if not (((strVersao[i] >= '0') and (strVersao[i] <= '9')) or (strVersao[i] = '.')) then
      begin
        MessageDlg('Versão inválida: ' + strVersao, mtInformation, [mbOk], 0);
        Exit;
      end;

    if not fMontaUpdateLayout(strEmp, strModelo, strVersao, strUpdate) then
    begin
      MessageDlg('Não existe configuração na IMPNFE para empresa ' + strEmp + ', modelo ' +
        strModelo + ' e versão ' + strVersao + '.', mtInformation, [mbOk], 0);
      Exit;
    end;
  end;

  dlgExportar.FileName := 'IMPNFE_' + strPrv + '.sql';
  if not dlgExportar.Execute then
    Exit;

  lst := TStringList.Create;
  try
    Screen.Cursor := crHourGlass;
    try
      try
        lst.Add('/* Exportação do provedor de layout dinâmico de NFS-e (Req. 999999)');
        lst.Add('   Provedor : ' + strPrv);
        lst.Add('   Gerado em: ' + FormatDateTime('dd/mm/yyyy hh:nn:ss', Now));
        if blnLayout then
          lst.Add('   Layout   : IMPNFE empresa ' + strEmp + ', modelo ' + strModelo + ', versão ' + strVersao);
        lst.Add('   Requer as tabelas/colunas do SCRIPT_PAINEL_002 no banco de destino. */');
        lst.Add('');
        lst.Add('SET NAMES utf8;');

        // ordem das chaves estrangeiras: provedor -> datasets -> campos / variáveis
        intQtdPrv := fExportaTabela(lst, 'IMPNFE_PRV', 'PRV_NOME', 'PRV_NOME', strPrv);
        intQtdCds := fExportaTabela(lst, 'IMPNFE_CDS', 'CDS_CODPRV', 'CDS_NOMCDS', strPrv);
        intQtdFld := fExportaTabela(lst, 'IMPNFE_FLD', 'FLD_CODPRV', 'FLD_CODCDS, FLD_NOME', strPrv);
        intQtdVar := fExportaTabela(lst, 'IMPNFE_VAR', 'VAR_CODPRV', 'VAR_ORDEM, VAR_NOME', strPrv);

        if blnLayout then
        begin
          lst.Add('');
          lst.Add('/* IMPNFE - layout fr3 dinâmico (NFE_LAYDMP/NFE_LAYDMR) */');
          lst.Add(strUpdate);
          strMsgLayout := ' e o layout fr3 da IMPNFE';
        end;

        pGravaUtf8(dlgExportar.FileName, lst);
      except
        on E: Exception do
        begin
          Screen.Cursor := crDefault;
          MessageDlg('Não foi possível exportar o provedor.' + sLineBreak + E.Message, mtError, [mbOk], 0);
          Exit;
        end;
      end;
    finally
      Screen.Cursor := crDefault;
    end;
  finally
    FreeAndNil(lst);
  end;

  MessageDlg('Provedor exportado em:' + sLineBreak + dlgExportar.FileName + sLineBreak + sLineBreak +
    IntToStr(intQtdPrv) + ' provedor, ' + IntToStr(intQtdCds) + ' dataset(s), ' +
    IntToStr(intQtdFld) + ' campo(s), ' + IntToStr(intQtdVar) + ' variável(is)' +
    strMsgLayout + '.', mtInformation, [mbOk], 0);
end;

procedure TfrmImpNfdProvedores.btnFecharClick(Sender: TObject);
begin
  Close;
end;

end.
