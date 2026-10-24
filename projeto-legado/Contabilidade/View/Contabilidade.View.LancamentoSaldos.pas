unit Contabilidade.View.LancamentoSaldos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ComCtrls, Vcl.CheckLst, Vcl.Mask, MaskEditFocus,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, cxProgressBar,
  untIZClient, Uni, Contabilidade.View.TfrmPaiContabilidade, untExcel, untGeraExcel, cxTextEdit, cxDropDownEdit,
  System.Generics.Collections, Contabilidade.Classes.TValidaProcessoSaldoInicial;

type
  TfrmLanSal = class(TfrmPaiContabilidade)
    pgcDados: TPageControl;
    tbsFiltros: TTabSheet;
    tbsDados: TTabSheet;
    lblCodEmp: TLabel;
    Label2: TLabel;
    btnCarregar: TBitBtnLocked;
    mskExercicio: TMaskEditFocus;
    cklEmpresas: TCheckListBox;
    Label1: TLabel;
    cxGridCitel1DBTableViewCitel: TcxGridDBTableViewCitel;
    cxGridCitel1Level1: TcxGridLevel;
    cxGridCitel1: TcxGridCitel;
    cxGridCitel1DBTableViewCitelNCO_CODCON: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitelNCO_DESCRI: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitelNCO_CONRED: TcxGridDBColumn;
    btnGeraExcel: TSpeedButton;
    pnlBotoesGrid: TPanel;
    btnGravarDadosDigitados: TBitBtnLocked;
    cxGridCitel1DBTableViewCitelINI_EXERCI: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitelINI_SALINI: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitelINI_CODEMP: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitelTIPO: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure btnCarregarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cklEmpresasClickCheck(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
    procedure btnGeraExcelClick(Sender: TObject);
    procedure btnGravarDadosDigitadosClick(Sender: TObject);
    procedure cklEmpresasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxGridCitel1DBTableViewCitelKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure cxGridCitel1DBTableViewCitelEditKeyDown(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
      AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
    procedure cxGridCitel1DBTableViewCitelEditValueChanged(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  private
    { Private declarations }
    strCnpjBase : String;
    cdsDados : IZClient;
    blnINI_CREDEB_Existe : boolean;
    procedure pCarregarDados;
    function fCarregarDados(pgbProgresso: TcxProgressBar): Boolean;
    procedure pCarregaEmpresas;
    function fSQLDados(strExercicio: String): String;
    function fEmpresasSelecionadas: Integer;
    function fPegaCnpjBase: String;
    function fGetInEmpresas: String;
    function fCnpjSelecionadoIncorreto: Boolean;
    function fGravarDados(pgbProgresso: TcxProgressBar): Boolean;
    procedure pMarcarEmpresaLogada;
    procedure pInformacao(strInfo: String; pgbStatus: TcxProgressBar);
    procedure OnGeraExcel(Excel: TExcel; Dados: TDataSet; Campos: TCampos; CorFundo: TCorExcel);
    procedure pAltDados;
    function fConverteEstruturaParaValidacao: TList<TDadosValidacaoSaldoInicial>;
    function fGetEmps: TStrings;
  public
    { Public declarations }
  end;

var
  frmLanSal: TfrmLanSal;

implementation

uses
  StrUtils, untFuncoesSimples, untZClient,
  Contabilidade.Classes.TControleContabilidade, Contabilidade.Funcoes, Contabilidade.Classes.UniQueryAuditoria;

{$R *.dfm}

procedure TfrmLanSal.btnGravarDadosDigitadosClick(Sender: TObject);
begin
  inherited;
  fChamaTelaGravando(fGravarDados);
end;

procedure TfrmLanSal.btnCarregarClick(Sender: TObject);
begin
  inherited;

  If Not fVerificaCampos Then
    Exit;

  If (fEmpresasSelecionadas = 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'Deve ser selecionado uma ou mais empresas!', ['&OK']);
    pSetFocus(cklEmpresas);
    Exit;
  End;

  pCarregarDados;
end;

procedure TfrmLanSal.btnGeraExcelClick(Sender: TObject);
begin
  If TGeraExcel.fGerarRelatorio(cxGridCitel1DBTableViewCitel, Self.Caption, OnGeraExcel) Then
    fMensagem('','Arquivo Salvo com Sucesso!', ['&OK']);
end;

procedure TfrmLanSal.cklEmpresasClickCheck(Sender: TObject);
  Var
    intSel : Integer;
begin
  inherited;
  intSel := fEmpresasSelecionadas;
  If (intSel = 0) Then
    strCnpjBase := ''
  Else If (intSel = 1) Then
    strCnpjBase := fPegaCnpjBase
  Else
  Begin
    If fCnpjSelecionadoIncorreto Then
      fMensagem('ATENÇÃO!', 'Somente podem estar selecionadas juntas, empresas do mesmo CNPJ base - Matriz/Filiais', ['&OK']);
  End;
end;

procedure TfrmLanSal.cklEmpresasKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Return) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmLanSal.cxGridCitel1DBTableViewCitelEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;

  If not Assigned(AItem) then
    Exit;

  If not (AItem is TcxGridDBColumn) then
    Exit;

  if not blnINI_CREDEB_Existe then
    Exit;

  if (cxGridCitel1DBTableViewCitelINI_SALINI.Focused) then
  begin
    if (GetCharFromKeyCode(Key) = '-') or (Pos('-', AEdit.EditingValue) > 0) then
    Begin
      fMensagem('ATENÇÃO!', 'Valor inválido para o Saldo Inicial!', ['&OK']);
      cdsDados.dtsSource.DataSet.Cancel;
    end;
  End;
end;

procedure TfrmLanSal.cxGridCitel1DBTableViewCitelEditValueChanged(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem);
begin
  inherited;

  if Sender.Controller.EditingController.IsEditing then
  begin
    if Sender.Controller.EditingController.EditingItem = AItem then
    begin
      Sender.Controller.EditingController.Edit.PostEditValue;

      pAltDados;
    end;
  end;
end;

procedure TfrmLanSal.cxGridCitel1DBTableViewCitelKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_ESCAPE) And (pgcDados.ActivePage = tbsDados) Then
    pgcDados.ActivePage := tbsFiltros;
end;

function TfrmLanSal.fCarregarDados(pgbProgresso: TcxProgressBar): Boolean;
begin
  pInformacao('Aguarde... Carregando', pgbProgresso);
  cdsDados.qryQuery.Close;
  cdsDados.qryQuery.SQL.Text := fSQLDados(mskExercicio.Text);
  cdsDados.fAbreClient(True, '[TfrmLanSal.fCarregarDados]');

  TFloatField(cdsDados.FieldByName('INI_SALINI')).DisplayFormat := '##,#0.00';

  Caption := 'Lançamento de Saldos';

  If (cdsDados.IsEmpty) Then
    fMensagem('ATENÇÃO!', 'Não há dados para exibir!', ['&OK'])
  Else
  Begin
    cdsDados.First;
    Caption := 'Lançamento de Saldos - Exercício: ' + mskExercicio.Text;
    pgcDados.ActivePage := tbsDados;
    btnGeraExcel.Visible := True;
  End;

  Result := True;
end;

function TfrmLanSal.fCnpjSelecionadoIncorreto: Boolean;
  Var
    intCnt : Integer;
    strCnpj : String;
begin
  Result := False;
  For intCnt := 0 To cklEmpresas.Items.Count-1 Do // OITO PRIMEIROS DEVEM SER IGUAIS
  Begin
    If (cklEmpresas.Checked[intCnt]) Then
    Begin
      strCnpj := Copy(cklEmpresas.Items[intCnt], 7, Length(cklEmpresas.Items[intCnt]));
      If (strCnpjBase <> strCnpj) Then
      Begin
        If (LeftStr(strCnpjBase, 8) <> LeftStr(strCnpj, 8)) Then
        Begin
          cklEmpresas.Checked[intCnt] := False;
          Result := True;
          Break;
        End;
      End;
    End;
  End;
end;

function TfrmLanSal.fConverteEstruturaParaValidacao: TList<TDadosValidacaoSaldoInicial>;
var
  regItem: TDadosValidacaoSaldoInicial;
begin
  Result := TList<TDadosValidacaoSaldoInicial>.Create;
  cdsDados.DisableControls;
  cdsDados.First;
  while not cdsDados.Eof do
  begin
    FillChar(regItem, sizeOf(regItem), #0);
    regItem.AConta := cdsDados.FieldByName('NCO_CODCON').AsString;
    regItem.AEmpresa := cdsDados.FieldByName('EMP_CODEMP').AsString;
    try
      regItem.AExercicio := cdsDados.FieldByName('INI_EXERCI').AsString;
    except
      regItem.AExercicio := mskExercicio.Text;
    end;
    if blnINI_CREDEB_Existe then
    begin
      try
      regItem.ACreDeb := (cdsDados.FieldByName('INI_CREDEB').AsString)[1];
      except
        regItem.ACreDeb := #0;
      end;
      try
        regItem.AValor := abs(cdsDados.FieldByName('INI_SALINI').AsFloat) ;
      except
        regItem.AValor := 0;
      end;
    end
    else
    begin
      regItem.ACreDeb := #0;
      try
        regItem.AValor := cdsDados.FieldByName('INI_SALINI').AsFloat;
      except
        regItem.AValor := 0;
      end;
    end;
    regItem.ACCusto := #0;

    Result.Add(regItem);
    cdsDados.Next;
  end;

  cdsDados.EnableControls;
  cdsDados.First;
end;
function TfrmLanSal.fEmpresasSelecionadas: Integer;
  Var
    intCnt : Integer;
begin
  Result := 0;
  For intCnt := 0 To cklEmpresas.Items.Count-1 Do
  Begin
    If (cklEmpresas.Checked[intCnt]) Then
      Result := Result + 1;
  End;
end;

function TfrmLanSal.fGetEmps: TStrings;
var
  intCnt : Integer;
begin
  Result := TStringList.Create;
  For intCnt := 0 To cklEmpresas.Items.Count-1 Do
    If (cklEmpresas.Checked[intCnt]) Then
      Result.Add(LeftStr(cklEmpresas.Items[intCnt], 3));
end;
function TfrmLanSal.fGetInEmpresas: String;
  Var
    intCnt : Integer;
begin
  Result := '';
  For intCnt := 0 To cklEmpresas.Items.Count-1 Do
  Begin
    If (cklEmpresas.Checked[intCnt]) Then
    Begin
      If fEmptyStr(Result) Then
        Result := '"' + LeftStr(cklEmpresas.Items[intCnt], 3) + '"'
      Else
        Result := Result + ', "' + LeftStr(cklEmpresas.Items[intCnt], 3) + '"'
    End;
  End;

  If Not fEmptyStr(Result) Then
    Result := '(' + Result + ')';
end;

procedure TfrmLanSal.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskExercicio);
end;

procedure TfrmLanSal.FormCreate(Sender: TObject);
begin
  inherited;
  pgcDados.ActivePageIndex := 0;
  mskExercicio.Text := FormatDateTime('yyyy', VS_Date);
  cdsDados := TZClient.Create(Self, '');
  cxGridCitel1DBTableViewCitel.DataController.DataSource := cdsDados.dtsSource;
  strCnpjBase := '';
end;

procedure TfrmLanSal.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaEmpresas;
  pMarcarEmpresaLogada;
  blnINI_CREDEB_Existe := fCampoExiste('PLAINI', 'INI_CREDEB');
  cxGridCitel1DBTableViewCitelTIPO.Visible := blnINI_CREDEB_Existe;
  if (blnINI_CREDEB_Existe) then
    cxGridCitel1DBTableViewCitelTIPO.DataBinding.FieldName := 'INI_CREDEB';
end;

function TfrmLanSal.fPegaCnpjBase: String;
  Var
    intCnt : Integer;
begin
  Result := '';
  For intCnt := 0 To cklEmpresas.Items.Count-1 Do // OITO PRIMEIROS DEVEM SER IGUAIS
  Begin
    If (cklEmpresas.Checked[intCnt]) Then
    Begin
      Result := Copy(cklEmpresas.Items[intCnt], 7, Length(cklEmpresas.Items[intCnt]));
      Break;
    End;
  End;
end;

function TfrmLanSal.fSQLDados(strExercicio: String): String;
  Var
    strIn : String;
begin
  strIn := fGetInEmpresas;

  Result := '';
  Result := Result + ' SELECT NCO_CODCON, NCO_DESCRI, NCO_CONRED, EMP_CODEMP, ';
  Result := Result + '        IFNULL(INI_EXERCI, "' + strExercicio + '") AS INI_EXERCI, ';
  Result := Result + '        IFNULL(INI_SALINI, 0.00) AS INI_SALINI, ';//

  if blnINI_CREDEB_Existe then
    Result := Result + ' CAST(COALESCE(INI_CREDEB,"C") AS CHAR(1)) AS INI_CREDEB, ';

  Result := Result + '  CAST(COALESCE(PLAINI.INI_DTAALT, "2000-01-01 00:00:00") AS DATETIME) AS INI_DTAALT, ' ;
  Result := Result + '  CAST(COALESCE(PLAINI.INI_OPEALT, "") AS CHAR(3)) AS INI_OPEALT ' ;

  Result := Result + '   FROM PLANCO ';
  Result := Result + '   JOIN CADEMP  ON CADEMP.EMP_TPLACO = NCO_TPLACO ';
  Result := Result + '   LEFT JOIN PLAINI ON INI_CODEMP = EMP_CODEMP ';
  Result := Result + '                   AND INI_CODCON = NCO_CODCON ';
  Result := Result + '                   AND INI_EXERCI = "' + strExercicio + '" ';
  Result := Result + '  WHERE TRUE ' + fFiltroSQLAtvPas('NCO_CODCON', True);
  Result := Result + '  AND NCO_NATURE = "A" '  ;
  If Not fEmptyStr(strIn) Then
    Result := Result + '  AND EMP_CODEMP IN ' + strIn + ' '
  Else
    Result := Result + '  AND EMP_CODEMP IN (' + VS_strCodEmp + ') ';

  Result := Result + '  HAVING INI_EXERCI = "' + strExercicio + '"';
  Result := Result + '  ORDER BY NCO_CODCON, EMP_CODEMP ';
end;

function TfrmLanSal.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskExercicio) Then
    Begin
      If fEmptyStr(mskExercicio.Text, True) Then
      Begin
        fMensagem('ATENÇÃO!', 'Obrigatório preenchimento do exercício!', ['&OK']);
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmLanSal.OnGeraExcel(Excel: TExcel; Dados: TDataSet;
  Campos: TCampos; CorFundo: TCorExcel);
begin

end;

procedure TfrmLanSal.pAltDados;
begin
  cdsDados.Edit;
  cdsDados.FieldByName('INI_DTAALT').AsDateTime := fNow();
  cdsDados.FieldByName('INI_OPEALT').AsString := strLoginUsuarioLogado;
  cdsDados.Post;
end;

procedure TfrmLanSal.pCarregaEmpresas;
  Var
    qryCadEmp : TUniQuery;
begin
  qryCadEmp := fCriaQuery(Self);
  Try
    qryCadEmp.Close;
    qryCadEmp.SQL.Clear;
    qryCadEmp.SQL.Add(' SELECT CONCAT(EMP_CODEMP, " - ", IFNULL(EMP_C_G_C_,"")) AS EMPRESA ');
    qryCadEmp.SQL.Add('   FROM CADEMP ');
    qryCadEmp.SQL.Add('  WHERE IFNULL(EMP_C_G_C_,"") <> "" ');
    qryCadEmp.SQL.Add('  ORDER BY EMP_CODEMP ');
    qryCadEmp.Open;

    cklEmpresas.Items.Clear;

    qryCadEmp.First;
    While Not qryCadEmp.Eof Do
    Begin
      cklEmpresas.Items.Add(qryCadEmp.FieldByName('EMPRESA').AsString);
      qryCadEmp.Next;
    End;

    qryCadEmp.Close;
  Finally
    FreeAndNil(qryCadEmp);
  End;
end;

procedure TfrmLanSal.pCarregarDados;
begin
  fChamaTelaGravando(fCarregarDados);
end;

procedure TfrmLanSal.pgcDadosChange(Sender: TObject);
begin
  inherited;
  btnGeraExcel.Visible := (pgcDados.ActivePage = tbsDados) And (Not cdsDados.IsEmpty);
end;

function TfrmLanSal.fGravarDados(pgbProgresso: TcxProgressBar): Boolean;
  Var
    qryInsert : TUniQuery;
    LlstDados: TList<TDadosValidacaoSaldoInicial>;
begin
  Result := False;
  try
    LlstDados := fConverteEstruturaParaValidacao ;

    if not TValidaProcessoSaldoInicial.fValidaPlaDet(LlstDados, TMostraMensagemErroValidacao.pMostra, mskExercicio.Text, fGetEmps) then
      Exit;
  finally
    FreeAndNil(LlstDados);
  end;

  qryInsert := fCriaQueryContabilidade('PLAINI', Self.Name, Self);
  fStartTransaction;
  btnGravarDadosDigitados.Enabled := False;
  Try
    Screen.Cursor := crSQLWait;
    qryInsert.Close;
    qryInsert.SQL.Clear;
    qryInsert.SQL.Add(' SELECT * ');
    qryInsert.SQL.Add('   FROM PLAINI ');
    qryInsert.SQL.Add('  WHERE INI_CODCON = :CODCON ');
    qryInsert.SQL.Add('    AND INI_EXERCI = :EXERCI ');
    qryInsert.SQL.Add('    AND INI_CODEMP = :CODEMP ');

    cdsDados.DisableControls;
    Try
      pgbProgresso.Properties.Max := cdsDados.RecordCount;

      cdsDados.First;
      While Not cdsDados.Eof Do
      Begin
        pgbProgresso.Position := cdsDados.RecNo;
        Application.ProcessMessages;

        qryInsert.Close;
        qryInsert.ParamByName('CODCON').AsString := cdsDados.FieldByName('NCO_CODCON').AsString;
        qryInsert.ParamByName('EXERCI').AsString := cdsDados.FieldByName('INI_EXERCI').AsString;
        qryInsert.ParamByName('CODEMP').AsString := cdsDados.FieldByName('EMP_CODEMP').AsString;
        qryInsert.Open;

        If (qryInsert.IsEmpty) Then
        Begin
          qryInsert.Insert;
          qryInsert.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('PLAINI', VS_strCodEmp);
          qryInsert.FieldByName('INI_CODCON').AsString := cdsDados.FieldByName('NCO_CODCON').AsString;
          qryInsert.FieldByName('INI_EXERCI').AsString := cdsDados.FieldByName('INI_EXERCI').AsString;
          qryInsert.FieldByName('INI_CODEMP').AsString := cdsDados.FieldByName('EMP_CODEMP').AsString;
        End
        Else
          qryInsert.Edit;

        if blnINI_CREDEB_Existe then
        begin
          qryInsert.FieldByName('INI_CREDEB').AsString := cdsDados.FieldByName('INI_CREDEB').AsString;
          qryInsert.FieldByName('INI_SALINI').AsFloat := Abs(cdsDados.FieldByName('INI_SALINI').AsFloat);
        end
        else
          qryInsert.FieldByName('INI_SALINI').AsFloat := cdsDados.FieldByName('INI_SALINI').AsFloat;

        if cdsDados.FieldByName('INI_DTAALT').AsDateTime <= StrToDatetime('01/01/2000 00:00:00') then
          qryInsert.FieldByName('INI_DTAALT').Clear
        else
          qryInsert.FieldByName('INI_DTAALT').AsDateTime := cdsDados.FieldByName('INI_DTAALT').AsDateTime;
        if cdsDados.FieldByName('INI_OPEALT').AsString = '' then
          qryInsert.FieldByName('INI_OPEALT').Clear
        else
          qryInsert.FieldByName('INI_OPEALT').AsString := cdsDados.FieldByName('INI_OPEALT').AsString;

        qryInsert.Post;

        cdsDados.Next;
      End;

      pgbProgresso.Position := 0;

      fCommit;

      Result := True;

      fMensagem('ATENÇÃO!', 'Gravação concluída com sucesso!', ['&OK']);

      cdsDados.Close;

      pgcDados.ActivePageIndex := 0;
    Except
      On E: Exception Do
      Begin
        Result := False;
        fRollBack;
        pMensagensErro(E.Message, '[TfrmLanSal.fGravarDados]');
      End;
    End;

    cdsDados.EnableControls;
  Finally
    Screen.Cursor := crDefault;
    btnGravarDadosDigitados.Enabled := True;
    FreeAndNil(qryInsert);
  End;
end;

procedure TfrmLanSal.pMarcarEmpresaLogada;
  Var
    intCnt : Integer;
begin
  For intCnt := 0 To cklEmpresas.Items.Count-1 Do
  Begin
    If LeftStr(cklEmpresas.Items[intCnt], 3) = VS_strCodEmp Then
    Begin
      cklEmpresas.Checked[intCnt] := True;
      strCnpjBase := fPegaCnpjBase;
      Break;
    End;
  End;
end;

procedure TfrmLanSal.pInformacao(strInfo: String; pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) And (GetParentForm(pgbStatus).FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando')).Caption := strInfo;
    Application.ProcessMessages;
  End;
end;

end.
