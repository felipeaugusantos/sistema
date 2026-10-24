unit untLibCartoesCadEstabelecimentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, UniClientDataSet, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCurrencyEdit, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel, cxGrid, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, Uni,

  untLibCartoesPai, untTLibCartoesFuncoes;

type
  TOperacaoManutencao = (omNenhuma, omIncluir, omAlterar);

  TfrmCfgCadEstabelecimentosOperadorasCartoes = class(TfrmPai)
    pnlTopo: TPanel;
    btnIncluir: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnAlterar: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    pnlGrid: TPanel;
    grdLancamentos: TcxGridCitel;
    grdLancamentosDados: TcxGridDBTableViewCitel;
    grdLancamentosDadosCODEMP: TcxGridDBColumn;
    grdLancamentosNivel: TcxGridLevel;
    grdLancamentosDadosESTAB: TcxGridDBColumn;
    gbEstabelecimento: TGroupBox;
    lblCodigoEstabelecimento: TLabel;
    lblOperadora: TLabel;
    edtEstabelecimento: TDBEditFocus;
    grdLancamentosDadosNOME_ESTAB: TcxGridDBColumn;
    lblNomeEstabelecimento: TLabel;
    edtNomeEstabelecimento: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtEstabelecimentoKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure grdLancamentosDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure edtNomeEstabelecimentoKeyPress(Sender: TObject; var Key: Char);
  private
    FOperadora,
    FConfiguracao,
    FEstabelecimentosCadastrados,
    FEstabelecimentosCfg: String;

    FDatasetEstabelecimentos,
    FDatasetClone: TUniClientDataset;

    function RetornaOperadoraConfiguracao(AConfiguracao: String): String;

    function EstabelecimentoDigitadoValido: Boolean;

    procedure CarregaEstabelecimentos;

    procedure AtualizaComponentes(AOperacao: TOperacaoManutencao);

    function RetornaListaEstabelecimentosCadastrados: String;
    function RetornaFiltroCodigoConfiguracao: String;
    procedure ConfiguraCampoCodigoEstabelecimento;
    procedure CriaDataSet;
    { Private declarations }
  public
    property Operadora: String read FOperadora write FOperadora;
    property Configuracao: String read FConfiguracao write FConfiguracao;

    property EstabelecimentosCadastrados: String read FEstabelecimentosCadastrados;
    property EstabelicimentosCfg: String read FEstabelecimentosCfg write FEstabelecimentosCfg;
    { Public declarations }
  end;

var
  frmCfgCadEstabelecimentosOperadorasCartoes: TfrmCfgCadEstabelecimentosOperadorasCartoes;

implementation
Uses System.StrUtils;
{$R *.dfm}

procedure TfrmCfgCadEstabelecimentosOperadorasCartoes.AtualizaComponentes(
  AOperacao: TOperacaoManutencao);
begin
  pnlTopo.Enabled := False;
  pnlGrid.Enabled := True;
  btnIncluir.Enabled := True;
  btnAlterar.Enabled := True;
  btnExcluir.Enabled := True;
  btnGravar.Enabled := False;
  btnCancela.Enabled := False;

  If AOperacao In [omIncluir, omAlterar] Then
  Begin
    pnlTopo.Enabled := True;
    pnlGrid.Enabled := False;
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
    btnGravar.Enabled := True;
    btnCancela.Enabled := True;
  End;
end;

procedure TfrmCfgCadEstabelecimentosOperadorasCartoes.btnAlterarClick(
  Sender: TObject);
begin
  inherited;
  If FDatasetEstabelecimentos.IsEmpty Then
  Begin
    TLibCartoesFuncoes.fMensagem('ATENÇÃO', 'É necessário selecionar um registro para utilizar essa função.', ['&Ok']);
    Exit;
  End;

  FDatasetClone.Data := FDatasetEstabelecimentos.Data;

  AtualizaComponentes(omAlterar);
  FDatasetEstabelecimentos.Edit;

  pSetFocus(edtEstabelecimento);
end;

procedure TfrmCfgCadEstabelecimentosOperadorasCartoes.btnCancelaClick(
  Sender: TObject);
begin
  inherited;
  AtualizaComponentes(omNenhuma);
  FDatasetEstabelecimentos.Cancel;

  pSetFocus(grdLancamentos);
end;

procedure TfrmCfgCadEstabelecimentosOperadorasCartoes.btnExcluirClick(
  Sender: TObject);
begin
  inherited;
  If FDatasetEstabelecimentos.IsEmpty Then
  Begin
    TLibCartoesFuncoes.fMensagem('ATENÇÃO', 'É necessário selecionar um registro para utilizar essa função.', ['&Ok']);
    Exit;
  End;

  If TLibCartoesFuncoes.fMensagem('ATENÇÃO', 'Tem certeza que deseja excluir o registro selecionado?', ['&Sim', '&Não'], 1) = 2 Then
    Exit;

  FDatasetEstabelecimentos.Delete;

  TLibCartoesFuncoes.fMensagem('AVISO', 'Registro excluído com sucesso!', ['&Ok']);

  pSetFocus(grdLancamentos);
end;

procedure TfrmCfgCadEstabelecimentosOperadorasCartoes.btnGravarClick(
  Sender: TObject);
  Var
    LEstabelecimento: String;
begin
  inherited;
  LEstabelecimento := edtEstabelecimento.Text;
  If Not MatchStr(FConfiguracao, ['CFG_SICEST', 'CFG_MOBEST']) Then
    LEstabelecimento := TLibCartoesFuncoes.RetiraZerosEsquerda(edtEstabelecimento.Text);

  If TLibCartoesFuncoes.fEmptyStr(LEstabelecimento) Then
  Begin
    TLibCartoesFuncoes.fMensagem('ATENÇÃO', 'O campo código do estabelecimento deve ser preenchido corretamente.', ['&Ok']);

    Exit;
  End;

  If Not EstabelecimentoDigitadoValido Then
    Exit;

  FDatasetEstabelecimentos.Post;
  AtualizaComponentes(omNenhuma);

  pSetFocus(grdLancamentos);
end;

procedure TfrmCfgCadEstabelecimentosOperadorasCartoes.btnIncluirClick(
  Sender: TObject);
begin
  inherited;
  FDatasetClone.Data := FDatasetEstabelecimentos.Data;

  AtualizaComponentes(omIncluir);
  FDatasetEstabelecimentos.Last;
  FDatasetEstabelecimentos.Append;

  FDatasetEstabelecimentos.FieldByName('CODEMP').AsString := VS_FuncoesExternas.fIRetEmpresaLogada;

  pSetFocus(edtEstabelecimento);
end;

procedure TfrmCfgCadEstabelecimentosOperadorasCartoes.CarregaEstabelecimentos;
  Var
    LValorCfg,
    LEstabelecimento: String;

    LListaEstab: TStringList;
begin
  LValorCfg := VS_FuncoesExternas.fICfgSis(StringReplace(FConfiguracao, 'CFG_', EmptyStr, []));
  If Not FEstabelecimentosCfg.Equals(LValorCfg) Then
    LValorCfg := FEstabelecimentosCfg;

  LListaEstab := TStringList.Create;
  LListaEstab.Delimiter := ',';
  LListaEstab.StrictDelimiter := True;
  LListaEstab.DelimitedText := LValorCfg;

  For LEstabelecimento In LListaEstab Do
  Begin
    FDatasetEstabelecimentos.Append;
    FDatasetEstabelecimentos.FieldByName('CODEMP').AsString := VS_FuncoesExternas.fIRetEmpresaLogada;
    FDatasetEstabelecimentos.FieldByName('ESTAB').AsString := LEstabelecimento.Split(['|'])[0];
    If LEstabelecimento.Contains('|') Then
      FDatasetEstabelecimentos.FieldByName('NOME_ESTAB').AsString := LEstabelecimento.Split(['|'])[1];
    FDatasetEstabelecimentos.Post;
  End;

  grdLancamentosDados.DataController.DataSource := TLibCartoesFuncoes.fCriaDataSource(FDatasetEstabelecimentos);
  edtEstabelecimento.Datasource := grdLancamentosDados.DataController.DataSource;
  edtNomeEstabelecimento.Datasource := grdLancamentosDados.DataController.DataSource;
end;

procedure TfrmCfgCadEstabelecimentosOperadorasCartoes.ConfiguraCampoCodigoEstabelecimento;
begin
  If MatchStr(FConfiguracao, ['CFG_REDEST']) Then
  Begin
    edtEstabelecimento.MaxLength  := 9;
    edtEstabelecimento.CompZeros := True;
  End
  Else If MatchStr(FConfiguracao, ['CFG_PAGLNK']) Then
  Begin
    edtEstabelecimento.MaxLength  := 10;
    edtEstabelecimento.CompZeros := True;
  End
  else if MatchStr(FConfiguracao, ['CFG_PGMREI', 'CFG_PGMKEY']) then
  begin
    edtEstabelecimento.MaxLength := 100;
    edtEstabelecimento.Width     := 150;
    edtEstabelecimento.TipoTexto := ttAlfanumerico;
    edtEstabelecimento.CompZeros := False;

    lblNomeEstabelecimento.Visible := FConfiguracao.Equals('CFG_PGMREI');
    edtNomeEstabelecimento.Visible := FConfiguracao.Equals('CFG_PGMREI');
    grdLancamentosDadosNOME_ESTAB.Visible := FConfiguracao.Equals('CFG_PGMREI');
  end;
end;

procedure TfrmCfgCadEstabelecimentosOperadorasCartoes.CriaDataSet;
  Var
    LDatasetEstabelecimentos: TUniQuery;
begin
  LDatasetEstabelecimentos := VS_FuncoesExternas.fICriaQuery;
  Try
    LDatasetEstabelecimentos.SQL.Text := 'SELECT CAST(" " AS CHAR(3)) AS CODEMP, ' +
                                         '       CAST(" " AS CHAR('+edtEstabelecimento.MaxLength.ToString+')) AS ESTAB, ' +
                                         '       CAST(" " AS CHAR('+edtNomeEstabelecimento.MaxLength.ToString+')) AS NOME_ESTAB ' +
                                         'FROM DUAL';
    LDatasetEstabelecimentos.Open;

    FDatasetEstabelecimentos := TLibCartoesFuncoes.CriarClientDataSet(LDatasetEstabelecimentos, True);
    FDatasetEstabelecimentos.Open;

    FDatasetClone := TLibCartoesFuncoes.CriarClientDataSet(LDatasetEstabelecimentos, True);
    FDatasetClone.Open;
  Finally
    LDatasetEstabelecimentos.Close;
    FreeAndNil(LDatasetEstabelecimentos);
  End;
end;

procedure TfrmCfgCadEstabelecimentosOperadorasCartoes.edtEstabelecimentoKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  if Not CharInSet(Key, ['0'..'9']) Then
  Begin
    If CharInSet(Key, [#44]) Then
    Begin
      Key := #0;
      Exit;
    End;

    if ((Not CharInSet(Key, [#8, #13])) and (FOperadora <> 'PAGAR.ME')) Then
      Key := #0;
  End;
end;

procedure TfrmCfgCadEstabelecimentosOperadorasCartoes.edtNomeEstabelecimentoKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  if Not CharInSet(Key, ['0'..'9']) Then
  Begin
    If CharInSet(Key, [#44]) Then
    Begin
      Key := #0;
      Exit;
    End;

    if ((Not CharInSet(Key, [#8, #13])) and (FOperadora <> 'PAGAR.ME')) Then
      Key := #0;
  End;
end;

function TfrmCfgCadEstabelecimentosOperadorasCartoes.EstabelecimentoDigitadoValido: Boolean;
  Var
    LConsulta: TUniQuery;

    LEstabelecimento: String;
begin
  Result := False;

  If FDataSetClone.Locate('ESTAB', edtEstabelecimento.Text, []) Then
  Begin
    If FDataSetClone.RecNo <> FDatasetEstabelecimentos.RecNo Then
    Begin
      TLibCartoesFuncoes.fMensagem('ATENÇÃO', 'Esse código de estabelecimento já está cadastrado para a empresa selecionada.', ['&Ok']);

      Exit;
    End;
  End;

  LEstabelecimento := edtEstabelecimento.Text;
  If Not MatchStr(FConfiguracao, ['CFG_SICEST', 'CFG_MOBEST']) Then
    LEstabelecimento := TLibCartoesFuncoes.RetiraZerosEsquerda(edtEstabelecimento.Text);

  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := 'SELECT SIS_CODEMP, SIS_CODCFG, SIS_VALCFG ' +
                          'FROM CFGSIS ' +
                          'WHERE SIS_CODCFG';

    LConsulta.SQL.Add(RetornaFiltroCodigoConfiguracao);

    LConsulta.SQL.Add(' AND (NOT (SIS_CODCFG = "' + FConfiguracao + '" AND SIS_CODEMP="' + VS_FuncoesExternas.fIRetEmpresaLogada + '") ) ');

    LConsulta.SQL.Add(' AND LOCATE("' + LEstabelecimento + '", SIS_VALCFG) > 0 ');

    LConsulta.Open;

    Result := LConsulta.IsEmpty;

    If Result Then
      Exit;

    While Not LConsulta.Eof Do
    Begin
      If TLibCartoesFuncoes.ExisteValorMultiplosEstabelecimentos(LEstabelecimento, LConsulta.FieldByName('SIS_VALCFG').AsString, ',', Not MatchStr(FConfiguracao, ['CFG_SICEST', 'CFG_MOBEST'])) Then
      Begin
        TLibCartoesFuncoes.fMensagem('ATENÇÃO', 'Esse código de estabelecimento já está cadastrado para a empresa ' +
                                                 LConsulta.FieldByName('SIS_CODEMP').AsString + '.', ['&Ok']);

        Exit(False);
      End;

      LConsulta.Next;
    End;

    Result := True;
  Finally
    TLibCartoesFuncoes.FreeAndNilDatasets(LConsulta);
  End;
end;

procedure TfrmCfgCadEstabelecimentosOperadorasCartoes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  If FDataSetEstabelecimentos.State In [dsInsert, dsEdit] Then
  Begin
    TLibCartoesFuncoes.fMensagem('ATENÇÃO', 'Existe um registro em edição. Operação cancelada.', ['&Ok']);
    Action := caNone;

    Exit;
  End;

  inherited;

  FEstabelecimentosCadastrados := RetornaListaEstabelecimentosCadastrados;

  FreeAndNil(FDataSetEstabelecimentos);
  FreeAndNil(FDataSetClone);
end;

procedure TfrmCfgCadEstabelecimentosOperadorasCartoes.FormCreate(
  Sender: TObject);
begin
  inherited;
  FConfiguracao := '';
  FOperadora := '';
end;

procedure TfrmCfgCadEstabelecimentosOperadorasCartoes.FormKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Escape) Then
  Begin
    btnSair.Click;
  End
end;

procedure TfrmCfgCadEstabelecimentosOperadorasCartoes.FormShow(Sender: TObject);
begin
  inherited;
  ConfiguraCampoCodigoEstabelecimento;
  CriaDataSet;
  AtualizaComponentes(omNenhuma);

  FOperadora := RetornaOperadoraConfiguracao(FConfiguracao);

  lblOperadora.Caption := FOperadora;

  if FOperadora.Equals('PAGAR.ME') then
  begin
    if FConfiguracao.Equals('CFG_PGMREI') then
    begin
      gbEstabelecimento.Caption := 'Recebedor';
      Self.Caption := 'Cadastro de Recebedores PAGAR.ME';
      grdLancamentosDadosESTAB.Caption := 'Código Recebedor';
      grdLancamentosDadosESTAB.Width := 215;
      grdLancamentosDadosNOME_ESTAB.Width := 215;
    end
    else if FConfiguracao.Equals('CFG_PGMKEY') then
    begin
      gbEstabelecimento.Caption := 'Chave API';
      Self.Caption := 'Cadastro de Chaves API PAGAR.ME';
      edtEstabelecimento.PasswordChar := '*';
      grdLancamentosDadosESTAB.Caption := 'Chave API';
    end;
  end;

  CarregaEstabelecimentos;

  pSetFocus(btnIncluir);
end;

procedure TfrmCfgCadEstabelecimentosOperadorasCartoes.grdLancamentosDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  LTextoOriginal, LTextoMascarado: string;
  LInicioMascara, LFinalMascara, I: Integer;
begin
  if MatchStr(FConfiguracao, ['CFG_PGMKEY']) and (AViewInfo.Item.Index = grdLancamentosDadosESTAB.Index) then
  begin
    LTextoOriginal := VarToStr(AViewInfo.GridRecord.Values[AViewInfo.Item.Index]);

    if Length(LTextoOriginal) > 4 then
    begin
      LInicioMascara := Length(LTextoOriginal) div 3;
      LFinalMascara := Length(LTextoOriginal) - LInicioMascara;

      LTextoMascarado := Copy(LTextoOriginal, 1, LInicioMascara);
      for I := LInicioMascara + 1 to LFinalMascara do
        LTextoMascarado := LTextoMascarado + '*';
      LTextoMascarado := LTextoMascarado + Copy(LTextoOriginal, LFinalMascara + 1, Length(LTextoOriginal));

      ACanvas.FillRect(AViewInfo.Bounds, clWhite);
      ACanvas.Font.Color := clBlack;
      ACanvas.DrawText(LTextoMascarado, AViewInfo.Bounds, cxAlignLeft or cxAlignVCenter, True);

      ADone := True;
    end;
  end;
end;

function TfrmCfgCadEstabelecimentosOperadorasCartoes.RetornaFiltroCodigoConfiguracao: String;
begin
  If MatchStr(FConfiguracao, ['CFG_CIEEST', 'CFG_CIELNK']) Then
    Result := ' IN ("CFG_CIEEST", "CFG_CIELNK") '
  Else If MatchStr(FConfiguracao, ['CFG_REDEST']) Then
    Result := ' IN ("CFG_REDEST", "CFG_REDECO") '
  Else If MatchStr(FConfiguracao, ['CFG_PAGLNK']) Then
    Result := ' IN ("CFG_PAGEST", "CFG_PAGLNK") '
  Else
    Result := ' = "' + FConfiguracao + '" ';
end;

function TfrmCfgCadEstabelecimentosOperadorasCartoes.RetornaListaEstabelecimentosCadastrados: String;
begin
  Result := '';

  If FDatasetEstabelecimentos.IsEmpty Then
    Exit;

  FDatasetEstabelecimentos.First;
  While Not FDatasetEstabelecimentos.Eof Do
  Begin
    Result := Result + FDatasetEstabelecimentos.FieldByName('ESTAB').AsString;
    If Not FDatasetEstabelecimentos.FieldByName('NOME_ESTAB').AsString.IsEmpty Then
      Result := Result + '|' + FDatasetEstabelecimentos.FieldByName('NOME_ESTAB').AsString;

    Result := Result + ',';

    FDatasetEstabelecimentos.Next;
  End;

  Result := LeftStr(Result, Result.Length - 1);
end;

function TfrmCfgCadEstabelecimentosOperadorasCartoes.RetornaOperadoraConfiguracao(
  AConfiguracao: String): String;
begin
  Result := '';
  If MatchStr(AConfiguracao, ['CFG_CIEEST', 'CFG_CIELNK']) Then
    Result := 'CIELO'
  Else If MatchStr(AConfiguracao, ['CFG_REDEST']) Then
    Result := 'REDECARD'
  Else If MatchStr(AConfiguracao, ['CFG_PAGEST', 'CFG_PAGLNK']) Then
    Result := 'PAGSEGURO'
  Else If MatchStr(AConfiguracao, ['CFG_SICEST']) Then
    Result := 'SICREDI'
  else if MatchStr(AConfiguracao, ['CFG_PGMKEY', 'CFG_PGMREI']) Then
    Result := 'PAGAR.ME';
end;

end.
