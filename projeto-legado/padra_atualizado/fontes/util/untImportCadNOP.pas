unit untImportCadNOP;

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
  TfrmImportCadNOP = class(TfrmPai)
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
    cdsCadNop: TZClient;

    const cQtdColunas = 3;
    const cNOP_CODPAI = 'A';
          cNOP_CODNCM = 'B';
          cNOP_CODITE = 'C';
    const cDesNOP_CODPAI = 'Código País';
          cDesNOP_CODNCM = 'Código NCM';
          cDesNOP_CODITE = 'Código Produto';

    function fValidaNumerico(strColuna, strTabela, strCampo, strValor: string; var strMensagem: String): boolean;
    function fGetSqlCds: String;
    function fGetAcaoRegistro(intLinha: Integer): String;
    function fTemTitulo: boolean;
    function fGetAutoincrem: String;
    function fConvetVazioToNull(strTexto: String): Variant;
    function fExisteChaveUnica(strCodPai, strCodIte: String): Boolean;

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
  untImportCadNOPConfirma,
  untTLog,
  untGravando;

{$R *.dfm}

procedure TfrmImportCadNOP.btnGravarClick(Sender: TObject);
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
    objValidaExcel := TValidadorExcel.Create(edtPath.text, cQtdColunas, cNOP_CODNCM, '', 0);

    Try
      pPreparaValidador;
      pgbGeral.Visible := True;
      btnGravar.Enabled := True;
      If Not objValidaExcel.fValidaCampos(True, pgbGeral) Then
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
      cdsCadNop.Close;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmImportCadNOP.btnGravarClick]');
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

procedure TfrmImportCadNOP.pCriarCds;
begin
  cdsCadNop.fAbreClient(True, '[TfrmImportCadNOP.pCriarCds]');
  cdsCadNop.LogChanges := False;
end;

procedure TfrmImportCadNOP.pInsereItensCDS(intLinha: integer);
begin
  cdsCadNop.Insert;
  cdsCadNop.FieldByName('ACAO').AsString    := fGetAcaoRegistro(intLinha);
  cdsCadNop.FieldByName('NOP_CODPAI').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cNOP_CODPAI));
  cdsCadNop.FieldByName('NOP_CODNCM').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cNOP_CODNCM));
  cdsCadNop.FieldByName('NOP_CODITE').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cNOP_CODITE));
  cdsCadNop.FieldByName('AUTOINCREM').Value := fGetAutoincrem;
  cdsCadNop.Post;
end;

function TfrmImportCadNOP.fConvetVazioToNull(strTexto: String): Variant;
begin
  If fEmptyStr(strTexto) Then
    Result := null
  Else
    Result := strTexto;
end;

function TfrmImportCadNOP.fGetAcaoRegistro(intLinha: Integer): String;
  Var
    strCodPai : String;
    strCodIte : String;
begin
  NullStrictConvert := False;
  strCodPai := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cNOP_CODPAI));
  strCodIte := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cNOP_CODITE));
  Result := IIF(fExisteChaveUnica(strCodPai, strCodIte),'A', 'I');
end;

function TfrmImportCadNOP.fExisteChaveUnica(strCodPai, strCodIte: String): Boolean;
  Var
    qryTemp : TUniQuery;
begin
  qryTemp := fCriaQuery;
  Try
    qryTemp.SQL.Add(' SELECT * FROM CADNOP       ');
    qryTemp.SQL.Add(' WHERE NOP_CODPAI = :CODPAI ');
    qryTemp.SQL.Add('   AND NOP_CODITE = :CODITE ');
    qryTemp.SQL.Add(' LIMIT 1                    ');
    qryTemp.ParamByName('CODPAI').AsString := strCodPai;
    qryTemp.ParamByName('CODITE').AsString := strCodIte;
    qryTemp.Open;

    Result := Not qryTemp.IsEmpty;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

function TfrmImportCadNOP.fGetAutoincrem: String;
  Var
    qryTemp : TUniQuery;
begin
  qryTemp := fCriaQuery;
  Try
    qryTemp.SQL.Add(' SELECT AUTOINCREM FROM CADNOP ');
    qryTemp.SQL.Add(' WHERE NOP_CODPAI = :CODPAI ');
    qryTemp.SQL.Add('   AND NOP_CODITE = :CODITE ');
    qryTemp.SQL.Add(' LIMIT 1                    ');
    qryTemp.ParamByName('CODPAI').AsString := cdsCadNop.FieldByName('NOP_CODPAI').Value;
    qryTemp.ParamByName('CODITE').AsString := cdsCadNop.FieldByName('NOP_CODITE').Value;
    qryTemp.Open;

    Result := qryTemp.FieldByName('AUTOINCREM').AsString;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

procedure TfrmImportCadNOP.pLimparCDS;
begin
  cdsCadNOP.EmptyDataSet;
end;

procedure TfrmImportCadNOP.pAtualizaInfoValidador;
begin
  PnlInfo.Caption := objValidaExcel.TempoExtimado;
end;

procedure TfrmImportCadNOP.pPreparaValidador;
Begin
  If Not Assigned(objValidaExcel) Then
    Exit;

  objValidaExcel.FAtualizaStatus := pAtualizaInfoValidador;
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesNOP_CODNCM, cNOP_CODNCM, 8, False, True, fValidaNumerico));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesNOP_CODPAI, cNOP_CODPAI,  4,  True, True, fValidaNumerico));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesNOP_CODITE, cNOP_CODITE,  5,  True, True, fValidaNumerico));
End;

procedure TfrmImportCadNOP.pProcessaItens;
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

  If Not cdsCadNop.IsEmpty Then
    pExibeTela;
end;

procedure TfrmImportCadNOP.pExibeTela;
  Var
    frmImportCadNOPConfirma : TfrmImportCadNOPConfirma;
begin
  If not cdsCadNop.IsEmpty Then
  Begin
    pCriarFormularios(TfrmImportCadNOPConfirma, frmImportCadNOPConfirma);
    Try
      frmImportCadNOPConfirma.cdsCadNOP := cdsCadNOP;
      frmImportCadNOPConfirma.ShowModal;
    Finally
      pFreeAndNil(frmImportCadNOPConfirma);
    End;
  End;
end;

procedure TfrmImportCadNOP.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  frxHelp.DotMatrixReport           := False;
  frxHelp.PrintOptions.PrintMode    := pmScale;
  frxHelp.PrintOptions.PrintOnSheet := 9;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxHelp);
end;

function TfrmImportCadNOP.fGetSqlCds: String;
begin
  Result := '';
  Result := Result + ' SELECT       ';
  Result := Result + '  AUTOINCREM, ';
  Result := Result + '  NOP_CODNCM, ';
  Result := Result + '  NOP_CODPAI, ';
  Result := Result + '  NOP_CODITE, ';
  Result := Result + '  "I" AS ACAO ';
  Result := Result + ' FROM CADNOP  ';
  Result := Result + ' WHERE FALSE  ';
end;

procedure TfrmImportCadNOP.FormCreate(Sender: TObject);
begin
  inherited;
  cdsCadNop := TZClient.Create(Self, fGetSqlCds);
end;

function TfrmImportCadNOP.fValidaNumerico(strColuna, strTabela, strCampo,
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

function TfrmImportCadNOP.fTemTitulo: boolean;
  var
    intValDef: Integer;
begin
  If objValidaExcel.fGetValueCSV(0, cNOP_CODPAI) <> '' Then
    Result := not TryStrToInt(Trim(objValidaExcel.fGetValueCSV(0, cNOP_CODPAI)), intValDef)
  Else
    Result := False;
end;

end.
