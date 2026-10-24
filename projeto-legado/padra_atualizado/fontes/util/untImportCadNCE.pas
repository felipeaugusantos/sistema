unit untImportCadNCE;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, Data.DB,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, cxControls, cxContainer, cxEdit, cxProgressBar, Uni,
  cxTextEdit, cxMaskEdit, cxButtonEdit, FilenameEditFocus, cxButtons, untTValidaExcel,
  System.StrUtils, untZClient;

type
  TfrmImportCadNCE = class(TfrmPai)
    btnGravar: TBitBtnLocked;
    btnHlpImp: TcxButton;
    pnlfundo: TPanel;
    Label1: TLabel;
    edtPath: TFilenameEditFocus;
    pgbGeral: TcxProgressBar;
    frxHelp: TfrxReport;
    procedure btnHlpImpClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    objValidaExcel: TValidadorExcel;
    cdsCadNce: TZClient;

    const cQtdColunas = 3;
    const cNCE_CODITE = 'A';
          cNCE_CODEMP = 'B';
          cNCE_CODNCM = 'C';

    const cDesNCE_CODITE = 'Código Produto';
          cDesNCE_CODEMP = 'Código Empresa';
          cDesNCE_CODNCM = 'Código NCM';


    function fValidaNumerico(strColuna, strTabela, strCampo, strValor: string; var strMensagem: String): boolean;
    function fExisteRegistrosDuplicados: boolean;
    function fGetSqlCds: String;
    function fGetAcaoRegistro(intLinha: Integer): String;
    function fTemTitulo: boolean;
    function fGetAutoincrem: String;
    function fConvetVazioToNull(strTexto: String): Variant;
    function fExisteChaveUnica(strCodEmp, strCodIte: String): Boolean;

    procedure pProcessaItens;
    procedure pCriarCds;
    procedure pExibeTela;
    procedure pPreparaValidador;
    procedure pAtualizaInfoValidador;
    procedure pLimparCDS;
    procedure pInsereItensCDS(intLinha: integer);
  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples,
  untImportCadNCEConfirma,
  untTLog,
  untGravando;

{$R *.dfm}

procedure TfrmImportCadNCE.btnGravarClick(Sender: TObject);
begin
  inherited;

  If (fEmptyStr(edtPath.Text)) Then
  Begin
    pMensagemOk('Selecione o arquivo!');
    Exit;
  End
  Else If Not (FileExists(edtPath.Text)) Then
  Begin
    fMensagem('AVISO','Arquivo não encontrado: ' + edtPath.Text + ' !', ['&O K']);
    Exit;
  End;

  try
    objValidaExcel := TValidadorExcel.Create(edtPath.text, cQtdColunas, cNCE_CODNCM, '', 0);

    Try
      pPreparaValidador;
      pgbGeral.Visible := True;
      btnGravar.Enabled := True;

      If Not objValidaExcel.fValidaCampos(True, pgbGeral) Then
        Exit;

      If fExisteRegistrosDuplicados Then
        Exit;

    Finally
      btnGravar.Enabled := False;
    End;

    btnHlpImp.Enabled     := False;
    btnGravar.Enabled     := False;
    btnSair.Enabled       := False;
    edtPath.Enabled       := False;

    Mouse.SettingChanged(10);
    pgbGeral.Visible := True;
    Application.ProcessMessages;
    edtPath.Text := AnsiReplaceStr(edtPath.Text,'"','');
    pCriarCds;
    Try
      pProcessaItens;

      SetForegroundWindow(Handle);

      edtPath.Clear;
      btnHlpImp.Enabled     := True;
      btnGravar.Enabled     := True;
      btnSair.Enabled       := True;
      edtPath.Enabled       := True;
      pnlInfo.Caption       := '';
      pgbGeral.Position     := 0;
      pSetFocus(btnSair);
      cdsCadNce.Close;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmImportCadNCE.btnGravarClick]');
        btnHlpImp.Enabled     := True;
        btnGravar.Enabled     := True;
        btnSair.Enabled       := True;
        edtPath.Enabled       := True;
        pnlInfo.Caption       := '';
        pgbGeral.Position     := 0;
        pSetFocus(btnSair);
      End;
    End;
  Finally
    btnSair.Enabled       := True;
    edtPath.Enabled       := True;

    btnHlpImp.Enabled := True;
    btnGravar.Enabled := True;
    pnlInfo.Caption := '';
    FreeAndNil(objValidaExcel);
    pgbGeral.Visible := False;
  End
end;

procedure TfrmImportCadNCE.pCriarCds;
begin
  cdsCadNce.fAbreClient(True, '[TfrmImportCadNCE.pCriarCds]');
  cdsCadNce.LogChanges := False;
end;

procedure TfrmImportCadNCE.pInsereItensCDS(intLinha: integer);
begin
  cdsCadNce.Insert;
  cdsCadNce.FieldByName('ACAO').AsString    := fGetAcaoRegistro(intLinha);
  cdsCadNce.FieldByName('NCE_CODITE').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cNCE_CODITE));
  cdsCadNce.FieldByName('NCE_CODEMP').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cNCE_CODEMP));
  cdsCadNce.FieldByName('NCE_CODNCM').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cNCE_CODNCM));
  cdsCadNce.FieldByName('AUTOINCREM').Value := fGetAutoincrem;
  cdsCadNce.Post;
end;

function TfrmImportCadNCE.fConvetVazioToNull(strTexto: String): Variant;
begin
  If fEmptyStr(strTexto) Then
    Result := null
  Else
    Result := strTexto;
end;

function TfrmImportCadNCE.fGetAcaoRegistro(intLinha: Integer): String;
  Var
    strCodEmp : String;
    strCodIte : String;
begin
  NullStrictConvert := False;
  strCodIte := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cNCE_CODITE));
  strCodEmp := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cNCE_CODEMP));
  Result := IIF(fExisteChaveUnica(strCodEmp, strCodIte),'A', 'I');
end;

function TfrmImportCadNCE.fExisteChaveUnica(strCodEmp, strCodIte: String): Boolean;
  Var
    qryTemp : TUniQuery;
begin
  qryTemp := fCriaQuery;
  Try
    qryTemp.SQL.Add(' SELECT * FROM CADNCE       ');
    qryTemp.SQL.Add(' WHERE NCE_CODEMP = :CODEMP ');
    qryTemp.SQL.Add('   AND NCE_CODITE = :CODITE ');
    qryTemp.SQL.Add(' LIMIT 1                    ');
    qryTemp.ParamByName('CODEMP').AsString := strCodEmp;
    qryTemp.ParamByName('CODITE').AsString := strCodIte;
    qryTemp.Open;

    Result := Not qryTemp.IsEmpty;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

function TfrmImportCadNCE.fGetAutoincrem: String;
  Var
    qryTemp : TUniQuery;
begin
  qryTemp := fCriaQuery;
  Try
    qryTemp.SQL.Add(' SELECT AUTOINCREM FROM CADNCE ');
    qryTemp.SQL.Add(' WHERE NCE_CODEMP = :CODEMP ');
    qryTemp.SQL.Add('   AND NCE_CODITE = :CODITE ');
    qryTemp.SQL.Add(' LIMIT 1                    ');
    qryTemp.ParamByName('CODEMP').AsString := cdsCadNce.FieldByName('NCE_CODEMP').Value;
    qryTemp.ParamByName('CODITE').AsString := cdsCadNce.FieldByName('NCE_CODITE').Value;
    qryTemp.Open;

    Result := qryTemp.FieldByName('AUTOINCREM').AsString;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

procedure TfrmImportCadNCE.pLimparCDS;
begin
  cdsCadNce.EmptyDataSet;
end;

procedure TfrmImportCadNCE.pAtualizaInfoValidador;
begin
  PnlInfo.Caption := objValidaExcel.TempoExtimado;
end;

procedure TfrmImportCadNCE.pPreparaValidador;
Begin
  If Not Assigned(objValidaExcel) Then
    Exit;

  objValidaExcel.FAtualizaStatus := pAtualizaInfoValidador;
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesNCE_CODITE, cNCE_CODITE, 5,  True, True, fValidaNumerico));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesNCE_CODEMP, cNCE_CODEMP, 3,  True, True, fValidaNumerico));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesNCE_CODNCM, cNCE_CODNCM, 8, False, True, fValidaNumerico));

End;

procedure TfrmImportCadNCE.pProcessaItens;
  Var
    intValIni : Integer;
    intContador : Integer;
begin
  pgbGeral.Properties.Max := objValidaExcel.ArquivoCSV.Count -1;
  pgbGeral.Position := 0;

  pLimparCDS;
  intValIni := IIf(fTemTitulo, 1 , 0);
  pgbGeral.Position := 0;
  For intContador := intValIni To (objValidaExcel.ArquivoCSV.Count -1) Do
  Begin
    pnlInfo.Caption := 'Importando os NCMs...'+ IntToStr(intContador) +'/' +IntToStr(objValidaExcel.ArquivoCSV.Count-intValIni);

    If intContador > objValidaExcel.ArquivoCSV.Count Then
      Continue;

    pInsereItensCDS(intContador);
    pgbGeral.Position := pgbGeral.Position + 1;
    Application.ProcessMessages;
  End;

  If Not cdsCadNce.IsEmpty Then
    pExibeTela;
end;

procedure TfrmImportCadNCE.pExibeTela;
  Var
    frmImportCadNCEConfirma : TfrmImportCadNCEConfirma;
begin
  If not cdsCadNce.IsEmpty Then
  Begin
    pCriarFormularios(TfrmImportCadNCEConfirma, frmImportCadNCEConfirma);
    Try
      frmImportCadNCEConfirma.cdsCadNce := cdsCadNce;
      frmImportCadNCEConfirma.ShowModal;
    Finally
      pFreeAndNil(frmImportCadNCEConfirma);
    End;
  End;
end;

procedure TfrmImportCadNCE.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  frxHelp.DotMatrixReport           := False;
  frxHelp.PrintOptions.PrintMode    := pmScale;
  frxHelp.PrintOptions.PrintOnSheet := 9;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxHelp);
end;

function TfrmImportCadNCE.fGetSqlCds: String;
begin
  Result := '';
  Result := Result + ' SELECT       ';
  Result := Result + '  AUTOINCREM, ';
  Result := Result + '  NCE_CODITE, ';
  Result := Result + '  NCE_CODEMP, ';
  Result := Result + '  NCE_CODNCM, ';
  Result := Result + '  "I" AS ACAO ';
  Result := Result + ' FROM CADNCE  ';
  Result := Result + ' WHERE FALSE  ';
end;

procedure TfrmImportCadNCE.FormCreate(Sender: TObject);
begin
  inherited;
  cdsCadNce := TZClient.Create(Self, fGetSqlCds);
end;

function TfrmImportCadNCE.fValidaNumerico(strColuna, strTabela, strCampo,
  strValor: string; var strMensagem: String): boolean;
begin
  Try
    StrToInt(strValor);
    Result := True;
  Except On
    E:Exception Do
    Begin
      strMensagem := 'O campo informado não é um valor em formato númerico válido';
      Result := False;
    End;
  End;
end;

function TfrmImportCadNCE.fExisteRegistrosDuplicados: Boolean;
Var
  intValIni : Integer;
  intContador : Integer;
  intContador2 : Integer;
  strCodIte: String;
  strCodEmp: String;
  intQtdReg: Integer;
  strCodDup: String;

begin

  Result := False;

  If Not Assigned(objValidaExcel) Then
    Exit;

  frmLog := TfrmLog.Create(nil);

  Try
    intValIni := IIf(fTemTitulo, 1 , 0);
    pgbGeral.Position := 0;
    For intContador := intValIni To (objValidaExcel.ArquivoCSV.Count -1) Do
    Begin
      pnlInfo.Caption := 'Procurando registros duplicados...'+ IntToStr(intContador) +'/' +IntToStr(objValidaExcel.ArquivoCSV.Count-intValIni);

      If intContador > objValidaExcel.ArquivoCSV.Count Then
        Continue;

      intQtdReg := 0;

      strCodIte := objValidaExcel.fGetValueCSV(intContador, cNCE_CODITE);
      strCodEmp := objValidaExcel.fGetValueCSV(intContador, cNCE_CODEMP);

      For intContador2 := intValIni To (objValidaExcel.ArquivoCSV.Count -1) Do
      Begin
        If intContador2 > objValidaExcel.ArquivoCSV.Count Then
          Continue;

        If (strCodIte = objValidaExcel.fGetValueCSV(intContador2, cNCE_CODITE)) And
           (strCodEmp = objValidaExcel.fGetValueCSV(intContador2, cNCE_CODEMP)) Then
        Begin
          Inc(intQtdReg);

          If (intQtdReg > 1) And (pos(strCodIte, strCodDup) = 0) Then
          Begin
            If fEmptyStr(strCodDup) Then
              strCodDup := strCodIte
            Else
              strCodDup := strCodDup + ' , ' + strCodIte;

            frmLog.pAddLinha('O produto '+strCodIte+' da linha '+IntToStr(intContador2)+' está duplicado, verifique o produto e a empresa.');
          End;
        End;

      End;

      pgbGeral.Position := pgbGeral.Position + 1;
      Application.ProcessMessages;
    End;

    If not fEmptyStr(strCodDup) Then
    Begin
      Result := True;
      frmLog.Showmodal;
    End;

  Finally
    FreeAndNil(frmLog);
  End;

end;

function TfrmImportCadNCE.fTemTitulo: boolean;
  var
    intValDef: Integer;
begin
  If objValidaExcel.fGetValueCSV(0, cNCE_CODEMP) <> '' Then
    Result := not TryStrToInt(Trim(objValidaExcel.fGetValueCSV(0, cNCE_CODEMP)), intValDef)
  Else
    Result := False;
end;

end.
