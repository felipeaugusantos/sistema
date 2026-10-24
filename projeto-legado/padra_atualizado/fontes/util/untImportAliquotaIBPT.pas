unit untImportAliquotaIBPT;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, untZClient,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxProgressBar, cxTextEdit,
  cxMaskEdit, cxButtonEdit, FilenameEditFocus, untTValidaExcel, uni,
  System.StrUtils;

type
  TfrmImportAliquotaIBPT = class(TfrmPai)
    pnlfundo: TPanel;
    Label1: TLabel;
    edtPath: TFilenameEditFocus;
    pgbGeral: TcxProgressBar;
    btnGravar: TBitBtnLocked;
    btnHlpImp: TBitBtnLocked;
    frxHelp: TfrxReport;
    procedure FormDestroy(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnHlpImpClick(Sender: TObject);
  private
    objValidaExcel: TValidadorExcel;
    cdsCadIbp : TZClient;
    FstrEstado: string;
    procedure pAtualizaInfoValidador;
    procedure pInsereItensCDS(intLinha: integer);
    procedure pProcessaItens;
    function fGetSqlCds: string;
    procedure pCriarCds;
    function fExisteChaveUnica(strCodNcm: String): Boolean;
    function fGetAcaoRegistro(intLinha: Integer): String;
    function fTemTitulo: boolean;
    procedure pExibeTela;
    procedure pLimparCDS;
    function fConvetVazioToNull(texto: string): Variant;
    procedure pPreparaValidador;
//    function fValidaNumericoPositivo(strColuna, strTabela, strCampo, strValor: string;
//      var strMensagem: String): boolean;
    function fGetAutoincrem: String;
  public
  end;

    const cQtdColunas = 6;
    const cIBP_N_C_M_ = 'A';
          cIBP_E_X___ = 'B';
          cIBP_ALQNAC = 'C';
          cIBP_ALQIMP = 'D';
          cIBP_ALQEST = 'E';
          cIBP_ALQMUN = 'F';


    const cDesIBP_N_C_M_ = 'NCM';
          cDesIBP_E_X___ = 'EX';
          cDesIBP_ALQNAC = 'Tributação Federal para Nacionais (%)';
          cDesIBP_ALQIMP = 'Tributação Federal para Importados (%)';
          cDesIBP_ALQEST = 'Tributação Estadual (%)';
          cDesIBP_ALQMUN = 'Tributação Municipal (%)';

var
  frmImportAliquotaIBPT: TfrmImportAliquotaIBPT;

implementation

uses
  untFuncoesSimples, untImportAliquotaIBPTConfirma;

{$R *.dfm}

procedure TfrmImportAliquotaIBPT.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(cdsCadIbp);
end;

procedure TfrmImportAliquotaIBPT.FormShow(Sender: TObject);
begin
  inherited;
  FstrEstado := fCadEmp('ESTADO');
end;

procedure TfrmImportAliquotaIBPT.pAtualizaInfoValidador;
begin
  PnlInfo.Caption := objValidaExcel.TempoExtimado;
end;

procedure TfrmImportAliquotaIBPT.pProcessaItens;
var intValIni,
    intContador: Integer;
begin
  pgbGeral.Properties.Max := objValidaExcel.ArquivoCSV.Count -1;

  pgbGeral.Position := 0;
  pLimparCDS;
  try
    intValIni := IIf(fTemTitulo, 1 , 0);
    pgbGeral.Position := 0;
    For intContador := intValIni To (objValidaExcel.ArquivoCSV.Count -1) Do
    Begin
      pnlInfo.Caption := 'Importando alíquotas IBPT...'+ IntToStr(intContador) +'/' +IntToStr(objValidaExcel.ArquivoCSV.Count);
      If intContador > objValidaExcel.ArquivoCSV.Count Then
        Continue;
      pInsereItensCDS(intContador);
      pgbGeral.Position := pgbGeral.Position + 1;
      Application.ProcessMessages;
    End;

    If Not cdsCadIbp.isEmpty Then
      pExibeTela;
  except
    on e: Exception do
      fMensagem('AVISO',e.message, ['&O K']);
  end;
end;

procedure TfrmImportAliquotaIBPT.pInsereItensCDS(intLinha: integer);
begin
  cdsCadIbp.Insert;
  cdsCadIbp.FieldByName('ACAO').AsString    := fGetAcaoRegistro(intLinha);
  cdsCadIbp.FieldByName('IBP_ESTADO').Value := FstrEstado;
  cdsCadIbp.FieldByName('IBP_N_C_M_').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cIBP_N_C_M_));
  cdsCadIbp.FieldByName('IBP_E_X___').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cIBP_E_X___));
  cdsCadIbp.FieldByName('IBP_ALQNAC').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cIBP_ALQNAC));
  cdsCadIbp.FieldByName('IBP_ALQIMP').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cIBP_ALQIMP));
  cdsCadIbp.FieldByName('IBP_ALQEST').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cIBP_ALQEST));
  cdsCadIbp.FieldByName('IBP_ALQMUN').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cIBP_ALQMUN));
  cdsCadIbp.FieldByName('AUTOINCREM').Value := fGetAutoincrem;
  cdsCadIbp.Post;
end;

function TfrmImportAliquotaIBPT.fGetAutoincrem: String;
var
  qryTemp: TUniQuery;
begin
  Try
    qryTemp := fCriaQuery;
    qryTemp.SQL.Add(' SELECT CADIBP.AUTOINCREM                                       ');
    qryTemp.SQL.Add(' FROM CADIBP                                                    ');
    qryTemp.SQL.Add(' WHERE CADIBP.IBP_N_C_M_ = :NCM AND CADIBP.IBP_ESTADO = :ESTADO ');
    qryTemp.SQL.Add(' LIMIT 1                                                        ');
    qryTemp.ParamByName('NCM').AsString := cdsCadIbp.FieldByName('IBP_N_C_M_').Value;
    qryTemp.ParamByName('ESTADO').AsString := FstrEstado;
    qryTemp.Open;

    Result := qryTemp.FieldByName('AUTOINCREM').AsString;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

function TfrmImportAliquotaIBPT.fGetAcaoRegistro(intLinha: Integer): String;
var
  strCodNcm: String;
begin
  NullStrictConvert := False;
  strCodNcm := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cIBP_N_C_M_));
  Result := IIF(fExisteChaveUnica(strCodNcm),'A','I');
end;

procedure TfrmImportAliquotaIBPT.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  frxHelp.DotMatrixReport           := False;
  frxHelp.PrintOptions.PrintMode    := pmScale;
  frxHelp.PrintOptions.PrintOnSheet := 9;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxHelp);
end;

function TfrmImportAliquotaIBPT.fConvetVazioToNull(texto: string): Variant;
begin
  If Texto = '' Then
    Result := null
  Else
    Result := texto;
end;

{function TfrmImportAliquotaIBPT.fValidaNumericoPositivo(strColuna, strTabela, strCampo, strValor: string; var strMensagem: String): boolean;
var
  intValor: Integer;
begin
  Try
    intValor := StrToInt(strValor);
    Result := intValor > 0;
  Except On
    E:Exception Do
    Begin
      strMensagem := 'O campo informado não é um valor númerico válido';
      Result := False;
    End;
  End;
end; }

function TfrmImportAliquotaIBPT.fExisteChaveUnica(strCodNcm: String): Boolean;
var
  qryTemp: TUniQuery;
begin
  Try
    qryTemp := fCriaQuery;
    qryTemp.SQL.Add(' SELECT CADIBP.AUTOINCREM                                       ');
    qryTemp.SQL.Add(' FROM CADIBP                                                    ');
    qryTemp.SQL.Add(' WHERE CADIBP.IBP_N_C_M_ = :NCM AND CADIBP.IBP_ESTADO = :ESTADO ');
    qryTemp.SQL.Add(' LIMIT 1                                                        ');
    qryTemp.ParamByName('NCM').AsString := strCodNcm;
    qryTemp.ParamByName('ESTADO').AsString := FstrEstado;
    qryTemp.Open;

    Result := Not qryTemp.IsEmpty;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

procedure TfrmImportAliquotaIBPT.btnGravarClick(Sender: TObject);
begin
  If Not (FileExists(edtPath.Text)) Then
  Begin
    fMensagem('AVISO','Arquivo não encontrado : ' + edtPath.Text + ' !', ['&O K']);
    Exit;
  End;

  try
    objValidaExcel := TValidadorExcel.Create(edtPath.text, cQtdColunas, cIBP_N_C_M_, '', 0);

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
      cdsCadIbp.Close;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmImportAliquotaIBPT.btnGravarClick]');
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

procedure TfrmImportAliquotaIBPT.pPreparaValidador;
Begin
  If Not Assigned(objValidaExcel) Then
    Exit;

  objValidaExcel.FAtualizaStatus := pAtualizaInfoValidador;
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesIBP_N_C_M_, cIBP_N_C_M_, 0, False, True, '')); //fValidaNumericoPositivo));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesIBP_E_X___, cIBP_E_X___, 3, False, False, ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesIBP_ALQNAC, cIBP_ALQNAC, False));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesIBP_ALQIMP, cIBP_ALQIMP, False));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesIBP_ALQEST, cIBP_ALQEST, False));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesIBP_ALQMUN, cIBP_ALQMUN, False));
End;

function TfrmImportAliquotaIBPT.fGetSqlCds: string;
var
  strSql: string;
begin
  strSql := '';
  strSql := strSql + 'SELECT ';
  strSql := strSql + '  CADIBP.IBP_ESTADO, ';
  strSql := strSql + '  CADIBP.AUTOINCREM, ';
  strSql := strSql + '  CADIBP.IBP_N_C_M_, ';
  strSql := strSql + '  CADIBP.IBP_ALQNAC, ';
  strSql := strSql + '  CADIBP.IBP_ALQIMP, ';
  strSql := strSql + '  CADIBP.IBP_ALQEST, ';
  strSql := strSql + '  CADIBP.IBP_ALQMUN, ';
  strSql := strSql + '  CADIBP.IBP_E_X___, ';
  strSql := strSql + '  "I" AS ACAO        ';
  strSql := strSql + 'FROM ';
  strSql := strSql + '  CADIBP ';
  strSql := strSql + 'WHERE FALSE ';

  Result := strSql;
end;

procedure TfrmImportAliquotaIBPT.pCriarCds;
begin
  cdsCadIbp := TZClient.Create(Self, fGetSqlCds);
  cdsCadIbp.fAbreClient(True, '[TfrmImportAliquotaIBPT.pCriarCds]');
  cdsCadIbp.LogChanges := False;
end;

procedure TfrmImportAliquotaIBPT.pExibeTela;
begin
  If not cdsCadIbp.IsEmpty Then
  Begin
   pCriarFormularios(TfrmImportAliquotaIBPTConfirma, frmImportAliquotaIBPTConfirma);
    Try
      frmImportAliquotaIBPTConfirma.cdsCadIbp := cdsCadIbp;
      frmImportAliquotaIBPTConfirma.ShowModal;
    Finally
      pFreeAndNil(frmImportAliquotaIBPTConfirma);
    End;
  End
end;

procedure TfrmImportAliquotaIBPT.pLimparCDS;
begin
  cdsCadIbp.EmptyDataSet;
end;

function TfrmImportAliquotaIBPT.fTemTitulo: boolean;
  var
    intValDef: Integer;
begin
  If objValidaExcel.fGetValueCSV(0, cIBP_N_C_M_) <> '' Then
    Result := not TryStrToInt(Trim(objValidaExcel.fGetValueCSV(0, cIBP_N_C_M_)), intValDef)
  Else
    Result := False;
end;

end.
