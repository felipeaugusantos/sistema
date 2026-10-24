unit untImportCadNCM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxProgressBar, cxTextEdit, cxMaskEdit, cxButtonEdit,
  FilenameEditFocus, cxButtons, untTValidaExcel, strUtils, Data.DB, Uni, untZClient;

type
  TfrmImportCadNCM = class(TfrmPai)
    btnGravar: TBitBtnLocked;
    pnlfundo: TPanel;
    Label1: TLabel;
    edtPath: TFilenameEditFocus;
    pgbGeral: TcxProgressBar;
    btnHlpImp: TcxButton;
    frxHelp: TfrxReport;
    procedure pAtualizaInfoValidador;
    procedure pPreparaValidador;
    function fConvetVazioToNull(texto: string): Variant;

    procedure pLimparCDS;
    procedure pInsereItensCDS(intLinha: integer);

    procedure btnGravarClick(Sender: TObject);
    function fTemTitulo: boolean;
    procedure FormCreate(Sender: TObject);

    procedure FormDestroy(Sender: TObject);
    procedure btnHlpImpClick(Sender: TObject);
  private
    { Private declarations }
    objValidaExcel: TValidadorExcel;
    qryConsulta: TUniQuery;
    cdsCadNcm: TZClient;
    lst: TStringList;
    procedure pExibeTela;
    procedure pProcessaItens;
    procedure pCriarCds;
    function fValidaNumerico(strColuna, strTabela, strCampo, strValor: string; var strMensagem: String): boolean;
    function fValidaListaICMS(strColuna, strTabela, strCampo, strValor: string; var strMensagem: String): boolean;
    function fValidaListaCOFINS(strColuna, strTabela, strCampo, strValor: string; var strMensagem: String): boolean;
    function fValidaListaIPI(strColuna, strTabela, strCampo, strValor: string; var strMensagem: String): boolean;
    function fValidaListaPIS(strColuna, strTabela, strCampo, strValor: string; var strMensagem: String): boolean;
    function fExisteChaveUnica(strCodNcm, strCodExc: String): Boolean;
    function fGetSqlCds: String;
    function fGetAcaoRegistro(intLinha: Integer): String;
    function fGetAutoincrem: String;
  protected
  public
    { Public declarations }
  end;

    const cQtdColunas = 9;
    const cNCM_CODNCM = 'A';
          cNCM_CODEXC = 'B';
          cNCM_ALQIPI = 'C';
          cNCM_DESCRI = 'D';
          cNCM_ANVOBR = 'E';
          cNCM_ABFICM_LISTA = 'F';
          cNCM_ABFPIS_LISTA = 'G';
          cNCM_ABFCOF_LISTA = 'H';
          cNCM_ABFIPI_LISTA = 'I';


    const cDesNCM_CODNCM = 'Código NCM';
          cDesNCM_CODEXC = 'Exceção NCM';
          cDesNCM_ALQIPI = 'Alíquota IPI';
          cDesNCM_DESCRI = 'Descrição';
          cDesNCM_ANVOBR = 'Obrigar o registro na ANVISA no Cad. Produtos';
          cDesNCM_ABFICM_LISTA = 'Abrev. ICMS';
          cDesNCM_ABFPIS_LISTA = 'Abrev. PIS';
          cDesNCM_ABFCOF_LISTA = 'Abrev. COFINS';
          cDesNCM_ABFIPI_LISTA = 'Abrev. IPI';
var
  frmImportCadNCM: TfrmImportCadNCM;

implementation

uses
  untFuncoesSimples, untImportCadNCMConfirma, untImportCadProdutoConfirma, untTLog, untGravando;

{$R *.dfm}

procedure TfrmImportCadNCM.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  frxHelp.DotMatrixReport           := False;
  frxHelp.PrintOptions.PrintMode    := pmScale;
  frxHelp.PrintOptions.PrintOnSheet := 9;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxHelp);

end;


procedure TfrmImportCadNCM.pAtualizaInfoValidador;
begin
  PnlInfo.Caption := objValidaExcel.TempoExtimado;
end;

procedure TfrmImportCadNCM.pPreparaValidador;
Begin
  If Not Assigned(objValidaExcel) Then
    Exit;
  objValidaExcel.FAtualizaStatus := pAtualizaInfoValidador;
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesNCM_CODNCM, cNCM_CODNCM, 8, False, True, fValidaNumerico));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesNCM_CODEXC, cNCM_CODEXC, 20, False, True, fValidaNumerico));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesNCM_ALQIPI, cNCM_ALQIPI, False));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesNCM_DESCRI, cNCM_DESCRI, 300, False, True, '', '', False));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampo(tcChar_SN, cDesNCM_ANVOBR, cNCM_ANVOBR));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesNCM_ABFICM_LISTA, cNCM_ABFICM_LISTA,  0, False, False, fValidaListaICMS));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesNCM_ABFCOF_LISTA, cNCM_ABFCOF_LISTA,  0, False, False, fValidaListaCOFINS));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesNCM_ABFPIS_LISTA, cNCM_ABFPIS_LISTA,  0, False, False, fValidaListaPIS));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesNCM_ABFIPI_LISTA, cNCM_ABFIPI_LISTA,  0, False, False, fValidaListaIPI));
End;

procedure TfrmImportCadNCM.pProcessaItens;
var intValIni,
    intContador: Integer;
begin
  pgbGeral.Properties.Max := objValidaExcel.ArquivoCSV.Count -1;

  pgbGeral.Position := 0;

  pLimparCDS;
  intValIni := IIf(fTemTitulo, 1 , 0);
  pgbGeral.Position := 0;
  For intContador := intValIni To (objValidaExcel.ArquivoCSV.Count -1) Do
  Begin
    pnlInfo.Caption := 'Importando os NCMs...'+ IntToStr(intContador) +'/' +IntToStr(objValidaExcel.ArquivoCSV.Count);
    If intContador > objValidaExcel.ArquivoCSV.Count Then
      Continue;
    pInsereItensCDS(intContador);
    pgbGeral.Position := pgbGeral.Position + 1;
    Application.ProcessMessages;
  End;

  If Not cdsCadNcm.isEmpty Then
    pExibeTela;
end;

function TfrmImportCadNCM.fExisteChaveUnica(strCodNcm, strCodExc: String): Boolean;
var
  qryTemp: TUniQuery;
begin
  Try
    qryTemp := fCriaQuery;
    qryTemp.SQL.Add(' SELECT * FROM CADNCM       ');
    qryTemp.SQL.Add(' WHERE NCM_CODNCM = :CODNCM ');
    qryTemp.SQL.Add('   AND NCM_CODEXC = :CODEXC ');
    qryTemp.SQL.Add(' LIMIT 1                    ');
    qryTemp.ParamByName('CODNCM').AsString := strCodNcm;
    qryTemp.ParamByName('CODEXC').AsString := strCodExc;
    qryTemp.Open;

    Result := Not qryTemp.IsEmpty;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

function TfrmImportCadNCM.fGetAutoincrem: String;
var
  qryTemp: TUniQuery;
begin
  Try
    qryTemp := fCriaQuery;
    qryTemp.SQL.Add(' SELECT AUTOINCREM FROM CADNCM ');
    qryTemp.SQL.Add(' WHERE NCM_CODNCM = :CODNCM ');
    qryTemp.SQL.Add('   AND NCM_CODEXC = :CODEXC ');
    qryTemp.SQL.Add(' LIMIT 1                    ');
    qryTemp.ParamByName('CODNCM').AsString := cdsCadNcm.FieldByName('NCM_CODNCM').Value;
    qryTemp.ParamByName('CODEXC').AsString := cdsCadNcm.FieldByName('NCM_CODEXC').Value;
    qryTemp.Open;

    Result := qryTemp.FieldByName('AUTOINCREM').AsString;
  Finally
    FreeAndNil(qryTemp);
  End;
end;


function TfrmImportCadNCM.fValidaListaCOFINS(strColuna, strTabela, strCampo,
  strValor: string; var strMensagem: String): boolean;
var i: integer;
    strValorLista: String;
begin
  Result := True;
  lst.Text := '';
  lst.StrictDelimiter := True;
  lst.Delimiter := ',';
  lst.DelimitedText := strValor;

  For i := 0 To Pred(lst.Count) do
  Begin
    strValorLista := Trim(lst[i]);

    qryConsulta.sql.Clear;
    qryConsulta.SQL.Text := 'SELECT AUTOINCREM FROM COFSAI  WHERE APC_CODAPC = "' + strValorLista + '"';
    qryConsulta.Open;
    If qryConsulta.IsEmpty Then
    Begin
      Result := False;
      strMensagem := 'Não foi encontrada nenhuma abreviação fiscal com o código ' + strValorLista + ' na lista de abreviações fiscais COFINS';
      Break;
    End;
  End;


end;

function TfrmImportCadNCM.fValidaListaICMS(strColuna, strTabela, strCampo,
  strValor: string; var strMensagem: String): boolean;
var i: integer;
    strValorLista: String;
begin
  Result := True;
  lst.Text := '';
  lst.StrictDelimiter := True;
  lst.Delimiter := ',';
  lst.DelimitedText := strValor;

  For i := 0 To Pred(lst.Count) do
  Begin
    strValorLista := Trim(lst[i]);

    qryConsulta.sql.Clear;
    qryConsulta.SQL.Text := 'SELECT AUTOINCREM FROM ABFICM  WHERE ABF_CODABF = "' + strValorLista + '"';
    qryConsulta.Open;
    If qryConsulta.IsEmpty Then
    Begin
      Result := False;
      strMensagem := 'Não foi encontrada nenhuma abreviação fiscal com o código ' + strValorLista + ' na lista de abreviações fiscais';
      Break;
    End;
  End;

end;

function TfrmImportCadNCM.fValidaListaIPI(strColuna, strTabela, strCampo,
  strValor: string; var strMensagem: String): boolean;
var i: integer;
    strValorLista: String;
begin
  Result := True;
  lst.Text := '';
  lst.StrictDelimiter := True;
  lst.Delimiter := ',';
  lst.DelimitedText := strValor;

  For i := 0 To Pred(lst.Count) do
  Begin
    strValorLista := Trim(lst[i]);

    qryConsulta.sql.Clear;
    qryConsulta.SQL.Text := 'SELECT AUTOINCREM FROM IPISAI  WHERE APC_CODAPC = "' + strValorLista + '"';
    qryConsulta.Open;
    If qryConsulta.IsEmpty Then
    Begin
      Result := False;
      strMensagem := 'Não foi encontrada nenhuma abreviação fiscal com o código ' + strValorLista + ' na lista de abreviações fiscais IPI';
      Break;
    End;
  End;


end;

function TfrmImportCadNCM.fValidaListaPIS(strColuna, strTabela, strCampo,
  strValor: string; var strMensagem: String): boolean;
var i: integer;
    strValorLista: String;
begin
  Result := True;
  lst.Text := '';
  lst.StrictDelimiter := True;
  lst.Delimiter := ',';
  lst.DelimitedText := strValor;

  For i := 0 To Pred(lst.Count) do
  Begin
    strValorLista := Trim(lst[i]);

    qryConsulta.sql.Clear;
    qryConsulta.SQL.Text := 'SELECT AUTOINCREM FROM PISSAI  WHERE APC_CODAPC = "' + strValorLista + '"';
    qryConsulta.Open;
    If qryConsulta.IsEmpty Then
    Begin
      Result := False;
      strMensagem := 'Não foi encontrada nenhuma abreviação fiscal com o código ' + strValorLista + ' na lista de abreviações fiscais PIS';
      Break;
    End;
  End;


end;

function TfrmImportCadNCM.fValidaNumerico(strColuna, strTabela, strCampo,
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

procedure TfrmImportCadNCM.FormCreate(Sender: TObject);
begin
  inherited;
  lst := TStringList.Create;
  qryConsulta := fCriaQuery;
  qryConsulta.SQL.Add(' SELECT * FROM CADNCM WHERE NCM_CODNCM = :CODNCM ');
  pCriarCds;
end;

function TfrmImportCadNCM.fGetSqlCds: String;
begin
  Result := '';
  Result := Result + ' SELECT                            ';
  Result := Result + '  AUTOINCREM,                      ';
  Result := Result + '  NCM_CODNCM,                      ';
  Result := Result + '  NCM_CODEXC,                      ';
  Result := Result + '  NCM_DESCRI,                      ';
  Result := Result + '  NCM_ALQIPI,                      ';
  Result := Result + '  NCM_ANVOBR,                      ';
  Result := Result + '  CAST("" AS CHAR(255)) AS LISPIS, ';
  Result := Result + '  CAST("" AS CHAR(255)) AS LISCOF, ';
  Result := Result + '  CAST("" AS CHAR(255)) AS LISIPI, ';
  Result := Result + '  CAST("" AS CHAR(255)) AS LISICM, ';
  Result := Result + '  "I" AS ACAO                      ';
  Result := Result + ' FROM CADNCM                       ';
  Result := Result + ' WHERE FALSE                       ';
end;

procedure TfrmImportCadNCM.pCriarCds;
begin
  cdsCadNcm := TZClient.Create(Self, fGetSqlCds);
  cdsCadNcm.fAbreClient(True, '[TfrmImportCadNCM.pCriarCds]');
  cdsCadNcm.LogChanges := False;
end;

procedure TfrmImportCadNCM.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryConsulta);
  FreeAndNil(cdsCadNcm);
end;

procedure TfrmImportCadNCM.pExibeTela;
begin
  If not cdsCadNcm.IsEmpty Then
  Begin
   pCriarFormularios(TfrmImportCadNCMConfirma, frmImportCadNCMConfirma);
    Try
      frmImportCadNCMConfirma.cdsCadNCM := cdsCadNCM;
      frmImportCadNCMConfirma.ShowModal;
    Finally
      pFreeAndNil(frmImportCadNCMConfirma);
    End;
  End;
end;

procedure TfrmImportCadNCM.pInsereItensCDS(intLinha: integer);
begin
  cdsCadNcm.Insert;
  cdsCadNcm.FieldByName('ACAO').AsString    := fGetAcaoRegistro(intLinha);
  cdsCadNcm.FieldByName('NCM_CODNCM').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cNCM_CODNCM));
  cdsCadNcm.FieldByName('NCM_CODEXC').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cNCM_CODEXC));
  cdsCadNcm.FieldByName('AUTOINCREM').Value := fGetAutoincrem;
  cdsCadNcm.FieldByName('NCM_ALQIPI').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cNCM_ALQIPI));
  cdsCadNcm.FieldByName('NCM_DESCRI').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cNCM_DESCRI));
  cdsCadNcm.FieldByName('NCM_ANVOBR').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cNCM_ANVOBR));
  cdsCadNcm.FieldByName('LISPIS').Value     := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cNCM_ABFPIS_LISTA));
  cdsCadNcm.FieldByName('LISCOF').Value     := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cNCM_ABFCOF_LISTA));
  cdsCadNcm.FieldByName('LISIPI').Value     := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cNCM_ABFIPI_LISTA));
  cdsCadNcm.FieldByName('LISICM').Value     := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cNCM_ABFICM_LISTA));
  cdsCadNcm.Post;
end;

function TfrmImportCadNCM.fGetAcaoRegistro(intLinha: Integer): String;
var
  strCodNcm,
  strCodExc: String;
begin
  NullStrictConvert := False;	
  strCodNcm := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cNCM_CODNCM));
  strCodExc := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cNCM_CODEXC));
  Result := IIF(fExisteChaveUnica(strCodNcm, strCodExc),'A', 'I');
end;

function TfrmImportCadNCM.fConvetVazioToNull(texto: string): Variant;
begin
  If Texto = '' Then
    Result := null
  Else
    Result := texto;
end;

procedure TfrmImportCadNCM.pLimparCDS;
begin
  cdsCadNcm.EmptyDataSet;
end;

procedure TfrmImportCadNCM.btnGravarClick(Sender: TObject);
begin
  inherited;
  If Not (FileExists(edtPath.Text)) Then
  Begin
    fMensagem('AVISO','Arquivo não encontrado : ' + edtPath.Text + ' !', ['&O K']);
    Exit;
  End;

  try
    objValidaExcel := TValidadorExcel.Create(edtPath.text, cQtdColunas, cNCM_CODNCM, '', 0);

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
      cdsCadNcm.Close;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmImportCadNCM.btnGravarClick]');
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

function TfrmImportCadNCM.fTemTitulo: boolean;
  var
    intValDef: Integer;
begin
  If objValidaExcel.fGetValueCSV(0, cNCM_CODNCM) <> '' Then
    Result := not TryStrToInt(Trim(objValidaExcel.fGetValueCSV(0, cNCM_CODNCM)), intValDef)
  Else
    Result := False;
end;


end.
