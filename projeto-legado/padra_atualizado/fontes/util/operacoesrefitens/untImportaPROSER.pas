unit untImportaPROSER;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, Vcl.ComCtrls, Uni, UniClientDataSet;

type
  TfrmImportaPROSER = class(TfrmPai)
    pnlTopo: TPanel;
    btnCarregarDadosPlanilha: TBitBtnLocked;
    pgbProgresso: TProgressBar;
    OpenDialog: TOpenDialog;
    dtsDataSource: TDataSource;
    cxGridCitel1: TcxGridCitel;
    cxGridCitel1DBTableViewCitel1: TcxGridDBTableViewCitel;
    cxGridCitel1DBTableViewCitel1Column1: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1Column2: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1Column3: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1Column4: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1IMPORT: TcxGridDBColumn;
    cxGridCitel1Level1: TcxGridLevel;
    btnGravar: TBitBtnLocked;
    btnHlpImp: TBitBtnLocked;
    frxHelp: TfrxReport;
    btnLimpar: TBitBtnLocked;
    procedure btnCarregarDadosPlanilhaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxGridCitel1DBTableViewCitel1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnGravarClick(Sender: TObject);
    procedure btnHlpImpClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
  private
    FstrPath : String;
    FDataSet : TUniClientDataSet;
    FDataSetClone: TUniClientDataSet;
    function ArquivoPlanilhaValido: Boolean;
    procedure CarregarDadosPlanilhaEmTela(const ACaminhoArquivo: String);
    function FormataTamanhoEmpresa(const ACodigoEmpresa: String): String;
    function FormataTamanhoItem(const ACodigoItem: String): String;
    function fGravarPROSER: Boolean;
    function InicializarDataSet: TUniClientDataSet;
    function TemRegistrosParaGravar: Boolean;
    function ValidouRegistro(var AMensagem: String; ACodIte, ANumSer, ACodEmp: String): Integer;
    function fQtdIteImportar(ACodIte: String; ACodEmp: String): Integer;
    function fQtdSaldoItem(ACodIte: String; ACodEmp: String): Integer;
    function fQtdNumeroSerieItem(ACodIte: String; ACodEmp: String): Integer;
    function fItemPossuiSaldo(ACodIte, ACodEmp: String): Boolean;
    function fTemNumSerRepetido(ACodEmp, ACodIte, ANumSer: String): Boolean;
    procedure pValidaSaldos;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmImportaPROSER: TfrmImportaPROSER;

implementation

uses
  untFuncoesSimples, untExcel, untFuncoesGenerica;

{$R *.dfm}

procedure TfrmImportaPROSER.btnCarregarDadosPlanilhaClick(Sender: TObject);
begin
  If Not ArquivoPlanilhaValido Then
    Exit;
  FDataSet.EmptyDataSet;
  CarregarDadosPlanilhaEmTela(OpenDialog.FileName);
  btnGravar.Enabled := (TemRegistrosParaGravar);
  btnLimpar.Enabled := True;
end;

function TfrmImportaPROSER.ArquivoPlanilhaValido: Boolean;
begin
  Result := False;
  If Not OpenDialog.Execute() Then
    Exit;
  If (Not FileExists(OpenDialog.FileName)) Then
  Begin
    fMensagem('ATENÇÃO', 'Arquivo não existe!', ['&OK']);
    Exit;
  End;
  Result := True;
end;

function TfrmImportaPROSER.TemRegistrosParaGravar : Boolean;
begin
  Result := False;
  If (Not FDataSet.Active) Then
    Exit;
  If (FDataSet.IsEmpty) Then
    Exit;
  FDataSet.Filter := 'IMPORT = 1';
  FDataSet.Filtered := True;
  Result := (Not FDataSet.IsEmpty);
  FDataSet.Filtered := False;
  FDataSet.Filter := EmptyStr;
end;

procedure TfrmImportaPROSER.btnGravarClick(Sender: TObject);
begin
  If fGravarPROSER Then
    fMensagem('ATENÇÃO', 'Dados gravados com sucesso!', ['&OK']);
  FDataSet.EmptyDataSet;
  btnGravar.Enabled := False;
  btnLimpar.Enabled := False;
end;

procedure TfrmImportaPROSER.btnHlpImpClick(Sender: TObject);
begin
  frxHelp.DotMatrixReport           := False;
  frxHelp.PrintOptions.PrintMode    := pmScale;
  frxHelp.PrintOptions.PrintOnSheet := 9;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxHelp);
end;

procedure TfrmImportaPROSER.btnLimparClick(Sender: TObject);
begin
  inherited;
  If (FDataSet.Active) And (FDataSet.RecordCount > 0) Then
  Begin
    If (fMensagem('Confirmação', 'Deseja realmente limpar os dados carregados?', ['&Sim','&Não']) = 1) Then
    Begin
      FDataSet.EmptyDataSet;
      btnLimpar.Enabled := False;
    End;
  End;
end;

procedure TfrmImportaPROSER.CarregarDadosPlanilhaEmTela(const ACaminhoArquivo : String);
  Var
    LExcel : TExcel;
    LContador : Integer;
    LCodIte : String;
    LNumSer : String;
    LMensagem : String;
    LLstProSer: TStringList;
    LCount : Integer;
begin
  FDataSetClone := TUniClientDataSet.Create(Self);
  pCloneDataSet(FDataSetClone, FDataSet);
  LExcel := TExcel.fCriarExcel(Self);
  FDataSet.DisableControls;
  Try
    LExcel.AbrirArquivo(ACaminhoArquivo);

    FstrPath := ACaminhoArquivo;

    pgbProgresso.Position := 0;
    pgbProgresso.Max := LExcel.MaximodeLinhas;
    For LContador := 1 To LExcel.MaximodeLinhas Do
    Begin
      pgbProgresso.Position := LContador;
      Application.ProcessMessages;
      LCodIte := FormataTamanhoItem(LExcel.Ler_Celula('A' + IntToStr(LContador)));
      If (LCodIte.IsEmpty) Then
        Continue;
      If (LCodIte <> fRetSomenteNumeros(LCodIte)) Then
        Continue;
      LNumSer := LExcel.Ler_Celula('B' + IntToStr(LContador));
      If (LNumSer.IsEmpty) Then
        Continue;

      LLstProSer := TStringList.Create;
      LLstProSer.Delimiter := ';';
      LLstProSer.StrictDelimiter := True;
      LLstProSer.DelimitedText := LNumSer;

      For LCount := 0 To LLstProSer.Count - 1 Do
      Begin
        LMensagem := '';
        FDataSet.Append;
        FDataSet.FieldByName('CODITE').AsString := LCodIte;
        FDataSet.FieldByName('NUMSER').AsString := Trim(LLstProSer[LCount]);
        FDataSet.FieldByName('CODEMP').AsString := FormataTamanhoEmpresa(LExcel.Ler_Celula('C' + IntToStr(LContador)));
        FDataSet.FieldByName('IMPORT').AsInteger := ValidouRegistro(LMensagem, LCodIte, FDataSet.FieldByName('NUMSER').AsString, FDataSet.FieldByName('CODEMP').AsString);
        FDataSet.FieldByName('MSGERR').AsString := LMensagem;
        FDataSet.Post;
        pCloneDataSet(FDataSetClone, FDataSet);
      End;

      pValidaSaldos;
    End;
  Finally
    FDataSet.EnableControls;
    pgbProgresso.Position := 0;
    FreeAndNil(LExcel);
    FreeAndNil(FDataSetClone);
    FreeAndNil(LLstProSer);
  End;
end;

procedure TfrmImportaPROSER.cxGridCitel1DBTableViewCitel1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  If (Not Assigned(FDataSet)) Then
    Exit;

  If FDataSet.IsEmpty Then
    Exit;

  If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGridCitel1DBTableViewCitel1IMPORT.Index] = 0) Then
    ACanvas.Font.Color := clRed
  Else
    ACanvas.Font.Color := clGreen;
end;

procedure TfrmImportaPROSER.FormCreate(Sender: TObject);
begin
  inherited;
  FDataSet := InicializarDataSet;
end;

procedure TfrmImportaPROSER.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FDataSet);
  inherited;
end;

function TfrmImportaPROSER.InicializarDataSet : TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Self);
  Result.FieldDefs.Add('CODITE', ftString, 7, False);
  Result.FieldDefs.Add('NUMSER', ftString, 30, False);
  Result.FieldDefs.Add('CODEMP', ftString, 3, False);
  Result.FieldDefs.Add('IMPORT', ftInteger, 0, False);
  Result.FieldDefs.Add('MSGERR', ftString, 70, False);
  Result.IndexFieldNames := 'CODITE;NUMSER;CODEMP';
  Result.CreateDataSet;
  Result.Open;
  Result.LogChanges := False;
  dtsDataSource.DataSet := Result;
end;

function TfrmImportaPROSER.ValidouRegistro(var AMensagem: String; ACodIte, ANumSer, ACodEmp : String): Integer;
  Var
    LQuery : TUniQuery;
begin
  Result := 1;
  AMensagem := 'Tudo OK.';
  LQuery := fCriaQuery();
  Try
    LQuery.SQL.Add('SELECT ITE_CODITE, SER_NUMSER, EMP_CODEMP ');
    LQuery.SQL.Add('  FROM CADITE  ');
    LQuery.SQL.Add('  LEFT JOIN PROSER ON SER_CODITE = ITE_CODITE AND SER_NUMSER = :NUMSER AND SER_CODEMP = :CODEMP ');
    LQuery.SQL.Add('  LEFT JOIN CADEMP ON EMP_CODEMP = :CODEMP ');
    LQuery.SQL.Add(' WHERE ITE_CODITE = :CODITE ');
    LQuery.ParamByName('CODITE').AsString := ACodIte;
    LQuery.ParamByName('NUMSER').AsString := ANumSer;
    LQuery.ParamByName('CODEMP').AsString := ACodEmp;
    LQuery.Open;
    If (LQuery.IsEmpty) Then
    Begin
      Result := 0;
      AMensagem := 'Código Item não encontrado.';
      Exit;
    End;
    If (Not LQuery.FieldByName('SER_NUMSER').AsString.IsEmpty) Then
    Begin
      Result := 0;
      AMensagem := 'Número de série já consta na PROSER.';
      Exit;
    End;
    If (LQuery.FieldByName('EMP_CODEMP').AsString.IsEmpty) Then
    Begin
      Result := 0;
      AMensagem := 'Código da Empresa não encontrado.';
      Exit;
    End;
    If (Not fProdutoUsaNumeroDeSerie(ACodIte, ACodEmp)) Then
    Begin
      Result := 0;
      AMensagem := 'Produto não possui Controle de Número de Série.';
      Exit;
    End;
    If (fTemNumSerRepetido(ACodEmp, ACodIte, ANumSer)) Then
    Begin
      Result := 0;
      AMensagem := 'Número de Série duplicado na planilha para este item!';
      Exit;
    End;
    If (fQtdSaldoItem(ACodIte, ACodEmp) <= 0) Then
    Begin
      Result := 0;
      AMensagem := 'Produto sem Saldo Disponível!';
      Exit;
    End;

  Finally
    FreeAndNil(lQuery);
  End;
end;

procedure TfrmImportaPROSER.pValidaSaldos;
begin
  FDataSet.First;
  While Not FDataSEt.Eof Do
  Begin
    If (FDataSet.FieldByName('IMPORT').AsInteger = 1) Then
      If (Not fItemPossuiSaldo(FDataSet.FieldByName('CODITE').AsString, FDataSet.FieldByName('CODEMP').AsString)) Then
      Begin
        FDataSet.Edit;
        FDataSet.FieldByName('IMPORT').AsInteger := 0;
        FDataSet.FieldByName('MSGERR').AsString  := 'Quantidade de Números de Série maior que Saldo Disponível do Produto';
        FDataSet.Post;
      End;
    FDataSet.Next;
  End;
end;

function TfrmImportaPROSER.fItemPossuiSaldo(ACodIte: String; ACodEmp: String): Boolean;
begin
  Result := (fQtdSaldoItem(ACodIte, ACodEmp) - fQtdNumeroSerieItem(ACodIte, ACodEmp)) >= fQtdIteImportar(ACodIte, ACodEmp);
end;

function TfrmImportaPROSER.fQtdIteImportar(ACodIte: String; ACodEmp: String): Integer;
begin
  FDataSetClone.Filtered := False;
  FDataSetClone.Filter := 'CODITE = ' + QuotedStr(ACodIte) +
                          ' AND CODEMP = ' + QuotedStr(ACodEmp);
  FDataSetClone.Filtered := True;
  Result := FDataSetClone.RecordCount;
  FDataSetClone.Filtered := False;
end;

function TfrmImportaPROSER.fQtdSaldoItem(ACodIte: String; ACodEmp: String): Integer;
Var
  LQuery : TUniQuery;
begin
  LQuery := fCriaQuery();
  Try
    LQuery.SQL.Add('SELECT IFNULL(SUM(ITE_SALDOS),0) AS ITE_SALDOS FROM ITEGER ');
    LQuery.SQL.Add(' WHERE ITE_CODITE = :CODITE ');
    LQuery.SQL.Add('   AND ITE_CODEMP = :CODEMP ');
    LQuery.ParamByName('CODITE').AsString := ACodIte;
    LQuery.ParamByName('CODEMP').AsString := ACodEmp;
    LQuery.Open;
    Result := LQuery.FieldByName('ITE_SALDOS').AsInteger;
  Finally
    FreeAndNil(LQuery);
  End;
end;

function TfrmImportaPROSER.fQtdNumeroSerieItem(ACodIte: String; ACodEmp: String): Integer;
Var
  LQuery : TUniQuery;
begin
  LQuery := fCriaQuery();
  Try
    LQuery.SQL.Add('SELECT COUNT(1) AS QTD FROM PROSER ');
    LQuery.SQL.Add(' WHERE SER_CODITE = :CODITE ');
    LQuery.SQL.Add('   AND SER_CODEMP = :CODEMP ');
    LQuery.ParamByName('CODITE').AsString := ACodIte;
    LQuery.ParamByName('CODEMP').AsString := ACodEmp;
    LQuery.Open;
    Result := LQuery.FieldByName('QTD').AsInteger;
  Finally
    FreeAndNil(LQuery);
  End;
end;

function TfrmImportaPROSER.fGravarPROSER: Boolean;
  Var
    LQuery : TUniQuery;
    LRecNo : Integer;
begin
  Result := False;

  If FDataSet.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'Sem dados para importar!', ['&OK']);
    Exit;
  End;

  LQuery := fCriaQuery();
  LQuery.SQL.Add(' INSERT INTO PROSER (AUTOINCREM, SER_CODITE, SER_NUMSER, SER_CODEMP) ');
  LQuery.SQL.Add('             VALUES (:AUTINC, :CODITE, :NUMSER, :CODEMP) ');
  FDataSet.DisableControls;
  LRecNo := FDataSet.RecNo;
  Try
    FDataSet.Filter := 'IMPORT = 1';
    FDataSet.Filtered := True;
    fStartTransaction;
    FDataSet.First;
    While Not FDataSet.Eof Do
    Begin
      Try
        LQuery.ParamByName('AUTINC').AsString := fRetAutoIncrem('PROSER', FDataSet.FieldByName('CODEMP').AsString);
        LQuery.ParamByName('CODITE').AsString := FDataSet.FieldByName('CODITE').AsString;
        LQuery.ParamByName('NUMSER').AsString := FDataSet.FieldByName('NUMSER').AsString;
        LQuery.ParamByName('CODEMP').AsString := FDataSet.FieldByName('CODEMP').AsString;
        LQuery.ExecSQL;
      Except
        On E: Exception Do
        Begin
          fRollback;
          pMensagensErro(E.Message, '');
          Exit;
        End;
      End;
      FDataSet.Next;
    End;
    fCommit;
    Result := True;
  Finally
    FDataSet.Filtered := False;
    FDataSet.Filter := EmptyStr;
    FDataSet.RecNo := LRecNo;
    FDataSet.EnableControls;
  End;
end;

function TfrmImportaPROSER.fTemNumSerRepetido(ACodEmp, ACodIte, ANumSer: String): Boolean;
begin
  FDataSetClone.Filtered := False;
  FDataSetClone.Filter := 'CODEMP = ' + QuotedStr(ACodEmp) + ' AND CODITE = ' + QuotedStr(ACodIte) +
              ' AND NUMSER = ' + QuotedStr(ANumSer);
  FDataSetClone.Filtered := True;

  Result := FDataSetClone.RecordCount > 0;
end;

function TfrmImportaPROSER.FormataTamanhoEmpresa(
  const ACodigoEmpresa: String): String;
begin
  Result := ACodigoEmpresa;
  If (Length(Result) = 3) Then
    Exit;
  If (Length(Result) > 3) Then
    Exit;
  Result := fPadL(Result, 3, '0') ;
end;

function TfrmImportaPROSER.FormataTamanhoItem(const ACodigoItem: String): String;
begin
  Result := ACodigoItem;
  If (Length(Result) = 5) Then
    Exit;
  If (Length(Result) = 7) Then
    Exit;
  If (Length(Result) < 5) Then
    Exit(fPadL(Result, 5, '0'));
  Result := fPadL(Result, 7, '0');
end;

end.
