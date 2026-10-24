unit untTestabilidade;

interface
{$M+}

uses Windows, Messages, SysUtils, Classes, Menus, cxGrid, cxGridDBTableView,
  StrUtils, cxEditRepositoryItems, Dialogs, cxRadioGroup, Variants, Forms,
  Controls, cxVGrid

  {$IFDEF TESTABILIDADE_AUTCOM}
    , untMensagem, untFuncoesSimples
    {$IF Defined(EXE)}
//      , untCadRcxx
    {$IFEND}
  {$ENDIF}

  {$IF Defined(VER250) Or Defined(UNIDAC) Or Defined(VER300)}
    , System.Generics.Collections
  {$IFEND}
  ;

Type
    TDadosContaBanco = class(TObject)
    public
      strSeqLan: String;
      strCodPor: String;
      strCodCta: String;
      dtaDtaLan: TDateTime;
      fltValLan: Double;
  End;

  TTestabilidade = class(TObject)
    private
      FNumeroDocumento: String;
      FEspecieDocumento: String;
      FEmpresaDocumento: String;
      FClienteDocumento: String;
      FSerieDocumento: String;
      FDocumentoOriginal: String;
      FRomaneioNF: String;
      FRomaneioFF: String;
      FPedidoConsertoEquipamento: String;

      FFornecedorDocumento: String;

      FSeqLanMovBan: String;
      {$IF Defined(VER250) Or Defined(UNIDAC) Or Defined(VER300)}
        lstMovBan: TObjectList<TDadosContaBanco>;
      {$IFEND}

      {$IFDEF TESTABILIDADE_AUTCOM}
        FConteudoMensagem: String;
      {$ENDIF}

    public
      constructor Create;

      class function fGetTestabilidade: TTestabilidade;
      destructor Destroy; override;
    published
      property NumeroDocumento: String Read FNumeroDocumento Write FNumeroDocumento;
      property EspecieDocumento: String Read FEspecieDocumento Write FEspecieDocumento;
      property EmpresaDocumento: String Read FEmpresaDocumento Write FEmpresaDocumento;
      property ClienteDocumento: String Read FClienteDocumento Write FClienteDocumento;
      property SerieDocumento: String Read FSerieDocumento Write FSerieDocumento;
      property DocumentoOriginal: String Read FDocumentoOriginal Write FDocumentoOriginal;
      property RomaneioNF: String Read FRomaneioNF Write FRomaneioNF;
      property RomaneioFF: String Read FRomaneioFF Write FRomaneioFF;
      property PedidoConsertoEquipamento: String Read FPedidoConsertoEquipamento Write FPedidoConsertoEquipamento;

      property FornecedorDocumento: String Read FFornecedorDocumento Write FFornecedorDocumento;

      property SeqLanMovBan: String Read FSeqLanMovBan Write FSeqLanMovBan;

      function IndiceColunaVisivel(cxGrid: TcxGrid; strCaption: String): Integer;
      function ColunaOculta(cxGrid: TcxGrid; strCaption: String): Boolean;

      procedure FocarPesquisaGrid(cxGrid: TcxGrid; strCaption: String);
      function LocateGrid(cxGrid: TcxGrid; strCaption, strValor: String): Boolean;
      procedure EditarValorGrid(cxGrid: TcxGrid; strCaption: String);
      procedure SetaOpcaoRadioGrid(cxGrid: TcxGrid; strOpcao: String);
      function QuantidadeRegistrosGrid(cxGrid: TcxGrid): Integer;
      procedure LimparPesquisaGrid(cxGrid: TcxGrid);
      function ValorColunaGrid(cxGrid: TcxGrid; strCaption: String): String;
      function ValorColunaGroupFooter(cxGrid: TcxGrid; strCaption: String): String;
      procedure IrParaLinhaGrid(cxGrid: TcxGrid; intLinha: Integer);
      procedure HabilitarPesquisaGrid(cxGrid: TcxGrid; blnHabilitar: Boolean);
      function RegistroAtual(cxGrid: TcxGrid): Integer;
      procedure FiltrarGrid(cxGrid: TcxGrid; strCampo, strValor1, strValor2: String);
      procedure LimparFiltros(cxGrid: TcxGrid);

      procedure FocarPesquisaGridVertical(cxGrid: TcxVerticalGrid; strCaption: String);
      procedure LimparPesquisaGridVertical(cxGrid: TcxVerticalGrid);
      function ColunaSelecionadaGridVertical(cxGrid: TcxVerticalGrid): String;
      function ValorColunaGridVertical(cxGrid: TcxVerticalGrid; strCaption: String): String;

      {$IF Defined(VER250) Or Defined(UNIDAC) Or Defined(VER300)}
        procedure LimparMovimentacaoContaBanco;
        function RetornaMovimentacaoContaBanco(intIndice: Integer): TDadosContaBanco;
        function QuantidadeMovimentacaoContaBanco: Integer;
        procedure pAdicionarMovimentacaoContaBanco(strSeqLan, strCodPor, strCodCta: String;
          dtaDtaLan: TDateTime; fltValLan: Double);
      {$IFEND}

      {$IFDEF TESTABILIDADE_AUTCOM}
      procedure ClicarMenu(strCaminho: String);
      function ConteudoMensagem: String;
      procedure SetConteudoMensagem(strMsg: String);
      procedure pDestravarTodosLocksConexaoAtual;
      {$IF Defined(EXE)}
        function NecessitaFecharCaixa: Boolean;
      {$IFEND}
      {$ENDIF}
      procedure FinalizarAplicacao;

  End;

Var
  ___VS_objTestabilidade: TTestabilidade = Nil;

procedure pSetFocus(SenderUnico: TWinControl);
function fEmptyStr(strString : String) : Boolean;

implementation

{$IFDEF TESTABILIDADE_AUTCOM}
{$IF Defined(EXE)}
uses untPrincipal;
{$IFEND}
{$ENDIF}


{ TTestabilidade }
function TTestabilidade.ColunaOculta(cxGrid: TcxGrid;
  strCaption: String): Boolean;
  var
   intContador: integer;
begin
  Result := True;
  For intContador := 0 To TcxGridDBTableView(cxGrid.ActiveView).VisibleColumnCount -1 Do
  Begin
    If SameText(strCaption, TcxGridDBTableView(cxGrid.ActiveView).VisibleColumns[intContador].Caption) Then
    Begin
      Result := False;
      Break;
    End;
  End;

  If Not Result Then
  Begin
    Raise Exception.Create('Coluna ' + strCaption + ' não foi ocultada.');
  End;
end;

function TTestabilidade.ColunaSelecionadaGridVertical(
  cxGrid: TcxVerticalGrid): String;
begin
  Result := TcxEditorRow(cxGrid.Rows[cxGrid.FocusedRow.Index]).Properties.Caption;
end;

constructor TTestabilidade.Create;
begin
  {$IF Defined(VER250) Or Defined(UNIDAC) Or Defined(VER300)}
  lstMovBan := TObjectList<TDadosContaBanco>.Create;
  {$IFEND}

  {$IFDEF TESTABILIDADE_AUTCOM}
    FConteudoMensagem := '';
  {$ENDIF}
end;

destructor TTestabilidade.Destroy;
begin
  {$IF Defined(VER250) Or Defined(UNIDAC) Or Defined(VER300)}
  FreeAndNil(lstMovBan);
  {$IFEND}
  inherited;
end;

procedure TTestabilidade.EditarValorGrid(cxGrid: TcxGrid; strCaption: String);
begin
  TcxGridDBTableView(cxGrid.ActiveView).Controller.FocusedColumnIndex := IndiceColunaVisivel(cxGrid, strCaption);
  TcxGridDBTableView(cxGrid.ActiveView).Controller.EditingController.ShowEdit;
end;

class function TTestabilidade.fGetTestabilidade: TTestabilidade;
begin
  If Not Assigned(___VS_objTestabilidade) Then
  Begin
    ___VS_objTestabilidade := TTestabilidade.Create;
  End;
  Result := ___VS_objTestabilidade;
end;

function TTestabilidade.IndiceColunaVisivel(cxGrid: TcxGrid;
  strCaption: String): Integer;
  Var
    intContador: Integer;  
begin
  Result := -1;
  For intContador := 0 To TcxGridDBTableView(cxGrid.ActiveView).VisibleColumnCount -1 Do
  Begin
    If SameText(strCaption, TcxGridDBTableView(cxGrid.ActiveView).VisibleColumns[intContador].Caption) Then
    Begin
      Result := intContador;
      Break;
    End;
  End;

  If Result = -1 Then
  Begin
    Raise Exception.Create('Coluna ' + strCaption + ' não encontrada.');
  End;
end;

procedure TTestabilidade.IrParaLinhaGrid(cxGrid: TcxGrid; intLinha: Integer);
  Var
    view: TcxGridDBTableView;
begin
  view := TcxGridDBTableView(cxGrid.ActiveView);
  view.DataController.FocusedRecordIndex := intLinha-1;
end;

procedure TTestabilidade.FiltrarGrid(cxGrid: TcxGrid; strCampo, strValor1, strValor2: String);
  Var
    view: TcxGridDBTableView;
begin
  view := TcxGridDBTableView(cxGrid.ActiveView);
  view.DataController.DataSet.Filtered := False;
  view.DataController.DataSet.Filter   := strCampo + ' >= ' + QuotedStr(strValor1) + ' AND ' +
                                          strCampo + ' <= ' + QuotedStr(strValor2) ;
  view.DataController.DataSet.Filtered := True;
end;

procedure TTestabilidade.FinalizarAplicacao;
begin
  TerminateProcess(OpenProcess(PROCESS_ALL_ACCESS, TRUE, GetCurrentProcessId), 0);
end;

procedure TTestabilidade.FocarPesquisaGrid(cxGrid: TcxGrid;
  strCaption: String);
begin
  pSetFocus(cxGrid);
  TcxGridDBTableView(cxGrid.ActiveView).Controller.FocusedRow := TcxGridDBTableView(cxGrid.ActiveView).ViewData.FilterRow;
  TcxGridDBTableView(cxGrid.ActiveView).Controller.FocusedColumnIndex := IndiceColunaVisivel(cxGrid, strCaption);
  TcxGridDBTableView(cxGrid.ActiveView).Controller.EditingController.ShowEdit;
end;

procedure TTestabilidade.FocarPesquisaGridVertical(cxGrid: TcxVerticalGrid;
  strCaption: String);
  Var
    intContador: Integer;
begin
  pSetFocus(cxGrid);
  For intContador := 0 To cxGrid.Rows.Count-1 Do
  Begin
    If AnsiUpperCase(TcxEditorRow(cxGrid.Rows[intContador]).Properties.Caption) = AnsiUpperCase(strCaption) Then
    Begin
      TcxEditorRow(cxGrid.Rows[intContador]).Focused := True;
    End;
  End;
end;

procedure TTestabilidade.HabilitarPesquisaGrid(cxGrid: TcxGrid; blnHabilitar: Boolean);
begin
  TcxGridDBTableView(cxGrid.ActiveView).FilterRow.Visible := blnHabilitar;
end;

{$IF Defined(VER250) Or Defined(UNIDAC) Or Defined(VER300)}
procedure TTestabilidade.LimparMovimentacaoContaBanco;
begin
  lstMovBan.Clear;
end;

function TTestabilidade.RetornaMovimentacaoContaBanco(
  intIndice: Integer): TDadosContaBanco;
begin
  Result := lstMovBan[intIndice];
end;

procedure TTestabilidade.pAdicionarMovimentacaoContaBanco(strSeqLan, strCodPor,
  strCodCta: String; dtaDtaLan: TDateTime; fltValLan: Double);
  Var
    dados: TDadosContaBanco;
begin
  dados := TDadosContaBanco.Create;
  dados.strSeqLan := strSeqLan;
  dados.strCodPor := strCodPor;
  dados.strCodCta := strCodCta;
  dados.dtaDtaLan := dtaDtaLan;
  dados.fltValLan := fltValLan;

  lstMovBan.Add(dados);
end;

function TTestabilidade.QuantidadeMovimentacaoContaBanco: Integer;
begin
  Result := lstMovBan.Count;
end;
{$IFEND}

procedure TTestabilidade.LimparFiltros(cxGrid: TcxGrid);
  Var
    view: TcxGridDBTableView;
begin
  view := TcxGridDBTableView(cxGrid.ActiveView);
  view.DataController.DataSet.Filter   := '';
  view.DataController.DataSet.Filtered := False;
end;

procedure TTestabilidade.LimparPesquisaGrid(cxGrid: TcxGrid);
  Var
    view: TcxGridDBTableView;
    intContador: Integer;
begin
  view := TcxGridDBTableView(cxGrid.ActiveView);
  view.Controller.FocusedRow := view.ViewData.FilterRow;
  For intContador := 0 To view.VisibleColumnCount -1 Do
  Begin
    view.Controller.FocusedColumnIndex := intContador;
    view.Controller.EditingController.ShowEdit;

    If Assigned(view.Controller.EditingController.Edit) Then
    Begin
      view.Controller.EditingController.Edit.Clear;
    End;
  End;
end;

procedure TTestabilidade.LimparPesquisaGridVertical(cxGrid: TcxVerticalGrid);
  Var
    intContador: Integer;
begin
  pSetFocus(cxGrid);
  For intContador := 1 To cxGrid.Rows.Count-1 Do
  Begin
    TcxEditorRow(cxGrid.Rows[intContador]).Properties.Value := Null;
  End;
end;

function TTestabilidade.LocateGrid(cxGrid: TcxGrid; strCaption, strValor: String): Boolean;
  Var
    view: TcxGridDBTableView;
    strCampo: String;
    intIndice: Integer;
begin
  pSetFocus(cxGrid);
  view := TcxGridDBTableView(cxGrid.ActiveView);

  intIndice := IndiceColunaVisivel(cxGrid, strCaption);

  strCampo := TcxGridDBColumn(view.VisibleColumns[intIndice]).DataBinding.FieldName;

  Result := view.DataController.DataSet.Locate(strCampo, strValor, []);
  If Result Then
  Begin
    IrParaLinhaGrid(cxGrid, view.DataController.DataSet.RecNo);
  End;
end;

function TTestabilidade.QuantidadeRegistrosGrid(cxGrid: TcxGrid): Integer;
  Var
    view: TcxGridDBTableView;
begin
  view := TcxGridDBTableView(cxGrid.ActiveView);
  Result := view.DataController.RecordCount;
end;

function TTestabilidade.RegistroAtual(cxGrid: TcxGrid): Integer;
  Var
    view: TcxGridDBTableView;
begin
  view := TcxGridDBTableView(cxGrid.ActiveView);
  Result := view.DataController.FocusedDataRowIndex+1;
end;

procedure TTestabilidade.SetaOpcaoRadioGrid(cxGrid: TcxGrid; strOpcao: String);
  Var
    view: TcxGridDBTableView;
    radio: TcxRadioGroupProperties;
    intContador: Integer;
    intIdxColuna: Integer;
    intIdxLinha: Integer;
    blnEncontrou: Boolean;
begin
  view := TcxGridDBTableView(cxGrid.ActiveView);
  intIdxColuna := view.Controller.FocusedColumnIndex;
  intIdxLinha := view.DataController.FocusedRecordIndex;

  radio := (view.VisibleColumns[intIdxColuna].GetProperties(intIdxLinha) As TcxRadioGroupProperties);

  blnEncontrou := False;
  For intContador := 0 To radio.Items.Count -1 Do
  Begin
    If SameText(AnsiUpperCase(radio.Items.Items[intContador].Caption), AnsiUpperCase(strOpcao)) Then
    Begin
      view.Controller.FocusedColumn.EditValue := radio.Items.Items[intContador].Value;
      blnEncontrou := True;
    End;
  End;

  If Not blnEncontrou Then
  Begin
    Raise Exception.Create('Opção não é válida: ' + strOpcao);
  End;

end;

{$IFDEF TESTABILIDADE_AUTCOM}
procedure TTestabilidade.SetConteudoMensagem(strMsg: String);
begin
  FConteudoMensagem := strMsg;
end;
{$ENDIF}

function TTestabilidade.ValorColunaGrid(cxGrid: TcxGrid;
  strCaption: String): String;
  Var
    view: TcxGridDBTableView;
    intContador: Integer;
    blnEncontrouCaption: Boolean;
begin
  Result := '';
  blnEncontrouCaption := False;
  view := TcxGridDBTableView(cxGrid.ActiveView);
  For intContador := 0 To view.VisibleColumnCount -1 Do
  Begin
    If SameText(view.VisibleColumns[intContador].Caption, strCaption) Then
    Begin
      Result := VarToStrDef(view.VisibleColumns[intContador].EditValue, '');
      blnEncontrouCaption := True;
      Break;
    End;
  End;

  If Not blnEncontrouCaption Then
  Begin
    Raise Exception.Create('Não foi encontrada uma coluna com o nome ' + strCaption);
  End;
end;

function TTestabilidade.ValorColunaGridVertical(cxGrid: TcxVerticalGrid;
  strCaption: String): String;
  Var
    intContador: Integer;
    blnEncontrouCaption: Boolean;
begin
  Result := '';
  blnEncontrouCaption := False;
  For intContador := 1 To cxGrid.Rows.Count Do
  Begin
    If SameText(TcxEditorRow(cxGrid.Rows.Items[intContador]).Properties.Caption, strCaption) Then
    Begin
      Result := VarToStrDef(TcxEditorRow(cxGrid.Rows.Items[intContador]).Properties.Value, '');
      blnEncontrouCaption := True;
    End;
  End;

  If Not blnEncontrouCaption Then
  Begin
    Raise Exception.Create('Não foi encontrada uma linha com o nome ' + strCaption);
  End;
end;

function TTestabilidade.ValorColunaGroupFooter(cxGrid: TcxGrid;
  strCaption: String): String;
  Var
    view: TcxGridDBTableView;
    intContador: Integer;
    blnEncontrouCaption: Boolean;
begin
  Result := '';
  blnEncontrouCaption := False;
  view := TcxGridDBTableView(cxGrid.ActiveView);

  For intContador := 0 To view.ColumnCount -1 Do
  Begin
    //If SameText(view.GroupedColumns[intContador].Caption, strCaption) Then
    If SameText(view.ViewInfo.FooterViewInfo.Items[intContador].Column.Caption, strCaption) Then
    Begin
      Result := VarToStrDef(view.ViewInfo.FooterViewInfo.Items[intContador].Text, '');
      blnEncontrouCaption := True;
      Break;
    End;
  End;

  If Not blnEncontrouCaption Then
  Begin
    Raise Exception.Create('Não foi encontrada uma coluna com o nome ' + strCaption);
  End;
end;

{$IFDEF TESTABILIDADE_AUTCOM}
procedure TTestabilidade.ClicarMenu(strCaminho: String);
Var
  stlMenus: TStringList;
  mnuAtual: TMenuItem;
  intIndice: Integer;
  strCaminhoAtual: String;

  function fEncontraMenu(mnuSub: TMenuItem; strCaption: String): TMenuItem; Var intIndiceSub: Integer;
  begin
    Result := Nil;
    For intIndiceSub := 0 To mnuSub.Count -1 Do
    Begin
      If AnsiSameText(AnsiReplaceText(mnuSub.Items[intIndiceSub].Caption, '&', ''), strCaption) Then
      Begin
        Result := mnuSub.Items[intIndiceSub];
        Break;
      End;
    End;
  end;
begin
  If fEmptyStr(strCaminho) Then
    Raise Exception.Create('A caminho do menu não foi especificado.');

  stlMenus := TStringList.Create; ExtractStrings(['|'], [], PChar(strCaminho), stlMenus);
  If stlMenus.Count <= 0 Then
  Begin
    Raise Exception.Create('Não foi encontrado nenhum menu para processamento.');
  End;

  mnuAtual := Nil;
  {$IF Defined(EXE)}
    For intIndice := 0 To frmPrincipal.mnuAutcomK.Items.Count -1 Do
    Begin
      If AnsiSameText(AnsiReplaceText(frmPrincipal.mnuAutcomK.Items[intIndice].Caption, '&', ''), stlMenus[0]) Then
      Begin
        mnuAtual := frmPrincipal.mnuAutcomK.Items[intIndice];
        Break;
      End;
    End;
  {$IFEND}

  If Not Assigned(mnuAtual) Then
    Raise Exception.Create('Não foi encontrado um menu ' + stlMenus[0]);

  strCaminhoAtual := stlMenus[0];
  For intIndice := 1 To stlMenus.Count -1 Do
  Begin
    strCaminhoAtual := strCaminhoAtual + '|' + stlMenus[intIndice];
    mnuAtual := fEncontraMenu(mnuAtual, stlMenus[intIndice]);
    If Not Assigned(mnuAtual) Then
      Break;
  End;

  If Not Assigned(mnuAtual) Then
    Raise Exception.Create('Não foi encontrado um menu ' + strCaminhoAtual);

  FreeAndNil(stlMenus);
  {$IF Defined(EXE)}
    PostMessage(frmPrincipal.Handle, WM_COMMAND, mnuAtual.Command, 0);
  {$IFEND}
end;

function TTestabilidade.ConteudoMensagem: String;
begin
  Result := FConteudoMensagem;
end;

procedure TTestabilidade.pDestravarTodosLocksConexaoAtual;
begin
  untFuncoesSimples.pDestravarTodosLocksConexaoAtual;
end;

{$IF Defined(EXE)}
function TTestabilidade.NecessitaFecharCaixa: Boolean;
  Var
    dtaDtaLan: TDateTime;
begin
  Result := Not fNecessitaFecharCaixa(True, dtaDtaLan, False);
end;
{$IFEND}
{$ENDIF}

procedure pSetFocus(SenderUnico: TWinControl);
  Var
    Form: TCustomForm;
begin
  If Not Assigned(SenderUnico) Then Exit;

  Try
    Form := GetParentForm(SenderUnico);

    If (Form <> nil) And (Form.CanFocus) And SenderUnico.CanFocus Then
    Begin
      Try
        SenderUnico.SetFocus;
      Except

      End;
    End;
  Except

  End;
end;

function fEmptyStr(strString : String) : Boolean;
begin
  Result := False;
  strString := AnsiReplaceStr(strString, #10, '');
  strString := AnsiReplaceStr(strString, #13, '');
  If AnsiReplaceText(strString, ' ', '') = '' Then
    Result := True;
end;

end.
