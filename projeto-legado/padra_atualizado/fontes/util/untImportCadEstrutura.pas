unit untImportCadEstrutura;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxProgressBar, cxTextEdit, cxMaskEdit, cxButtonEdit,
  FilenameEditFocus, cxButtons, untTValidaExcel, strUtils, untZClient, Data.DB, Uni;

type
  TfrmImportCadEstrutura = class(TfrmPai)
    btnGravar: TBitBtnLocked;
    pnlfundo: TPanel;
    Label1: TLabel;
    edtPath: TFilenameEditFocus;
    pgbGeral: TcxProgressBar;
    btnHlpImp: TcxButton;
    frxHelp: TfrxReport;
    procedure pAtualizaInfoValidador;
    procedure pPreparaValidador;
    procedure pCriarCds;
    function fConvetVazioToNull(texto: string): Variant;

    procedure pLimparCDS;
    procedure pInsereItensCDS(intLinha: integer);

    procedure btnGravarClick(Sender: TObject);
    function fTemTitulo: boolean;
    procedure FormCreate(Sender: TObject);

    procedure ProcessaDETMAT(strSEQ_GerMat: String; strGMT_CodEmp: String; intLinha: integer);
    procedure pAtualizaCampoGerMat(strCampo: String; constField: string; intLinha: Integer);
    procedure pAtualizaCampoDetMat(strCampo: String; constField: string; intLinha: Integer);
    function fValoresIguais(Val1:Variant;  Val2: Variant): Boolean;
    procedure ProcessaGERMAT(strCodite: string; intLinha: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure btnHlpImpClick(Sender: TObject);
  private
    { Private declarations }
    objValidaExcel: TValidadorExcel;
    cdsGerMAT, cdsDetMat : TZClient;
    qryConsulta: TUniQuery;
    qryGerMat: TUniQuery;
    qryDetMat: TUniQuery;
    blnValidouPorcentagens: Boolean;
    procedure pPopulaCdsMat(strSEQ_GerMat: String);
    procedure pExibeTela;
    procedure pProcessaItens;
    function ValidarDadosNovos: Boolean;
    function ValidarDadosNovosPrg(pgbProgresso: TcxProgressBar): Boolean;
  protected
    function fComparaCodigos(strValor: Variant; inLinhaAtual: Integer; var strMensagem: string): boolean;
    function fValidaQtd(strValor: Variant; inLinhaAtual: Integer; var strMensagem: string): boolean;
    function fValidaTipQtd(strValor: Variant; inLinhaAtual: Integer; var strMensagem: string): boolean;
  public
    { Public declarations }
  end;


    const cQtdColunas = 18;
    const cGMT_CODITE = 'A';  // COD.CITEL
          cDMT_ITESUB = 'B';
          cDMT_QTDITE = 'C';
          cGMT_TIPQTD = 'D';
          cDMT_DESPCA = 'E';
          cDMT_APAREL = 'F';
          cDMT_ACUMOP = 'G';
          cDMT_BENEFI = 'H';
          cDMT_COMPEC = 'I';
          cDMT_ESPPEC = 'J';
          cDMT_LARPEC = 'K';
          cDMT_PERAPA = 'L';
          cDMT_PERBEN = 'M';
          cDMT_QTDPEC = 'N';
          cGMT_OBS001 = 'O';
          cGMT_OBS002 = 'P';
          cGMT_OBS003 = 'Q';
          cGMT_OBS004 = 'R';




    const cDesGMT_CODITE = 'Código Produto';  // COD.CITEL
          cDesDMT_ITESUB = 'Código Sub-Produto';
          cDesDMT_QTDITE = 'Quantidade';
          cDesGMT_TIPQTD = 'Tipo de Quantidade';
          cDesDMT_DESPCA = 'Destino';
          cDesDMT_APAREL = 'Aparelhada';
          cDesDMT_ACUMOP = 'Acumula na OP';
          cDesDMT_BENEFI = 'Benefic.';
          cDesDMT_COMPEC = 'Comprim';
          cDesDMT_ESPPEC = 'Espessura';
          cDesDMT_LARPEC = 'Largura';
          cDesDMT_PERAPA = 'Acr. Aparel';
          cDesDMT_PERBEN = 'Acr. Benefic';
          cDesDMT_QTDPEC = 'Quantidade';
          cDesGMT_OBS001 = 'Observação 1';
          cDesGMT_OBS002 = 'Observação 2';
          cDesGMT_OBS003 = 'Observação 3';
          cDesGMT_OBS004 = 'Observação 4';




var
  frmImportCadEstrutura: TfrmImportCadEstrutura;

implementation

uses
  untFuncoesSimples, untImportCadEstruturaConfirma, untImportCadProdutoConfirma, untTLog, untGravando;



{$R *.dfm}

procedure TfrmImportCadEstrutura.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  frxHelp.DotMatrixReport           := False;
  frxHelp.PrintOptions.PrintMode    := pmScale;
  frxHelp.PrintOptions.PrintOnSheet := 9;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxHelp);

end;

function TfrmImportCadEstrutura.fComparaCodigos(strValor: Variant; inLinhaAtual: Integer; var strMensagem: string): boolean;
begin
  Result := True;
  If SameStr(VarToStr(strValor), objValidaExcel.fGetValueCSV(inLinhaAtual, cGMT_CODITE)) Then
  Begin
    Result := False;
    strMensagem := 'Código do Sub-Produto igual ao Código do Produto'
  End;
end;

function TfrmImportCadEstrutura.fValidaQtd(strValor: Variant; inLinhaAtual: Integer; var strMensagem: string): boolean;
begin
  Result := True;
  If VarToStr(strValor) <> '' Then
    If StrToFloatDef(strValor, 0)  = 0 Then
    begin
      strMensagem := 'Campo Quantidade deve ter valor maior que zero';
      Result := False;
    End

end;

function TfrmImportCadEstrutura.fValidaTipQtd(strValor: Variant; inLinhaAtual: Integer; var strMensagem: string): boolean;
begin
  Result := True;
  If strValor = '' Then
    Exit;
  If strValor <> 'P' Then
    If strValor <> 'Q' Then
    Begin
      Result := False;
      strMensagem := 'O Valor deve ser "P" ou "Q"'
    End;

end;

function TfrmImportCadEstrutura.fValoresIguais(Val1, Val2: Variant): Boolean;
begin
   Val1 := VarToStrDef(Val1, '');
   Val2 := VarToStrDef(Val2, '');
   Result := VarToString(Val1) = VarToString(Val2)
end;

procedure TfrmImportCadEstrutura.pAtualizaCampoGerMat(strCampo: String; constField: string; intLinha: Integer);
var Value: Variant;
begin
  Value := objValidaExcel.fGetValueCSV(intLinha, constField);
  If (Value <> '') Then
  Begin
    If Not fValoresIguais(cdsGerMat.FieldByName(strCampo).Value, Value)  Then
    Begin
      cdsGerMat.FieldByName(strCampo).Value := Value;
    End;
  End;

end;
procedure TfrmImportCadEstrutura.pAtualizaCampoDetMat(strCampo: String; constField: string; intLinha: Integer);
var Value: Variant;
begin
  Value := objValidaExcel.fGetValueCSV(intLinha, constField);
  If (Value <> '') Then
  Begin
    If Not fValoresIguais(cdsDetMat.FieldByName(strCampo).Value, Value)  Then
    Begin
      cdsDetMat.FieldByName(strCampo).Value := Value;
      If cdsDetMat.State = dsEdit Then
        cdsDetMat.FieldByName('ACAO').AsInteger := AcaoImpCadEstruturaToInt(tpAtualizar);
    End;
  End;

end;


procedure TfrmImportCadEstrutura.pAtualizaInfoValidador;
begin
  PnlInfo.Caption := objValidaExcel.TempoExtimado;
end;

procedure TfrmImportCadEstrutura.pPreparaValidador;
Begin
  If Not Assigned(objValidaExcel) Then
    Exit;
  objValidaExcel.FAtualizaStatus := pAtualizaInfoValidador;
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesGMT_CODITE, cGMT_CODITE, fTamCodIte, True, True, 'CADITE', 'ITE_CODITE', True));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesDMT_ITESUB, cDMT_ITESUB, fTamCodIte, True, True, 'CADITE', 'ITE_CODITE', True, fComparaCodigos ));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesDMT_QTDITE, cDMT_QTDITE, True, fValidaQtd));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesGMT_TIPQTD, cGMT_TIPQTD, 0, False, False,  '', '', False, fValidaTipQtd));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesDMT_DESPCA, cDMT_DESPCA, 0 , False, False, ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampo(tcChar_SN,  cDesDMT_APAREL, cDMT_APAREL));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampo(tcChar_SN,  cDesDMT_ACUMOP, cDMT_ACUMOP));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampo(tcChar_SN,  cDesDMT_BENEFI, cDMT_BENEFI));

  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesDMT_COMPEC, cDMT_COMPEC));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesDMT_ESPPEC, cDMT_ESPPEC));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesDMT_LARPEC, cDMT_LARPEC));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesDMT_PERAPA, cDMT_PERAPA));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesDMT_PERBEN, cDMT_PERBEN));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesDMT_QTDPEC, cDMT_QTDPEC));

  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesGMT_OBS001, cGMT_OBS001, 70, False, False, ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesGMT_OBS002, cGMT_OBS002, 70, False, False, ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesGMT_OBS003, cGMT_OBS003, 70, False, False, ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesGMT_OBS004, cGMT_OBS004, 70, False, False, ''));

End;

procedure TfrmImportCadEstrutura.pProcessaItens;
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
    pnlInfo.Caption := 'Importando os Itens...'+ IntToStr(intContador) +'/' +IntToStr(objValidaExcel.ArquivoCSV.Count);
    If intContador > objValidaExcel.ArquivoCSV.Count Then
      Continue;
    pInsereItensCDS(intContador);
    pgbGeral.Position := pgbGeral.Position + 1;
    Application.ProcessMessages;
  End;

  If ValidarDadosNovos Then
  pExibeTela;

end;

procedure TfrmImportCadEstrutura.pCriarCds;
begin
  If Assigned(cdsGerMat) Then
    FreeAndNil(cdsGerMat);

  If Assigned(cdsDetMat) Then
    FreeAndNil(cdsDetMat);

  cdsGerMat := TZClient.Create(Self, 'SELECT GERMAT.*, ITE_DESITE, ITE_REFERE FROM GERMAT ' +
                                     ' INNER JOIN CADITE ON CADITE.ITE_CODITE = GMT_CODITE ' +
                                     ' INNER JOIN ITEGER ON ITEGER.ITE_CODITE = CADITE.ITE_CODITE AND ITEGER.ITE_CODEMP = GMT_CODEMP ' +
                                     ' WHERE FALSE');
  cdsDetMat := TZClient.Create(Self, 'SELECT DETMAT.*, 0 ACAO, ITE_DESITE, ITE_REFERE, ITE_PRECUS FROM DETMAT ' +
                                     ' INNER JOIN CADITE ON CADITE.ITE_CODITE = DMT_ITESUB ' +
                                     ' INNER JOIN ITEGER ON ITEGER.ITE_CODITE = CADITE.ITE_CODITE AND ITEGER.ITE_CODEMP = DMT_CODEMP ' +
                                     ' WHERE FALSE');

  cdsGerMat.fAbreClient(True,'[TfrmImportCadEstrutura.pCriarCds]');
  cdsDetMat.fAbreClient(True,'[TfrmImportCadEstrutura.pCriarCds]');

  cdsGerMat.IndexFieldNames := 'AUTOINCREM';
  cdsDetMat.IndexFieldNames := 'DMT_SEQGER;DMT_ITESUB';
end;

procedure TfrmImportCadEstrutura.FormCreate(Sender: TObject);
begin
  inherited;
  qryConsulta := fCriaQuery;
  qryConsulta.SQL.Add('  SELECT CADITE.ITE_CODITE, CADITE.ITE_REFERE, CADITE.ITE_DESITE, ITE_PRECUS FROM CADITE');
  qryConsulta.SQL.Add('  INNER JOIN ITEGER ON ITEGER.ITE_CODITE = CADITE.ITE_CODITE AND ITEGER.ITE_CODEMP = "' + VS_StrCodEmp+ '"');
  qryConsulta.SQL.Add('   WHERE CADITE.ITE_CODITE = :CODITE');

  qryGerMat := fCriaQuery;
  qryGerMat.SQL.Add('SELECT GERMAT.*, ITE_DESITE, ITE_REFERE FROM GERMAT ');
  qryGerMat.SQL.Add(' INNER JOIN CADITE ON CADITE.ITE_CODITE = GMT_CODITE ');
  qryGerMat.SQL.Add(' INNER JOIN ITEGER ON ITEGER.ITE_CODITE = CADITE.ITE_CODITE AND ITEGER.ITE_CODEMP = GMT_CODEMP ');
  qryGerMat.SQL.Add(' WHERE GMT_CODITE = :CODITE');


  qryDetMat := fCriaQuery;
  qryDetMat.SQL.Add('SELECT DETMAT.*,ITE_DESITE, ITE_REFERE, ITE_PRECUS  FROM DETMAT');
  qryDetMat.SQL.Add(' INNER JOIN CADITE ON CADITE.ITE_CODITE = DMT_ITESUB ');
  qryDetMat.SQL.Add(' INNER JOIN ITEGER ON ITEGER.ITE_CODITE = CADITE.ITE_CODITE AND ITEGER.ITE_CODEMP = DMT_CODEMP ');
  qryDetMat.SQL.Add(' WHERE DMT_SEQGER = :SEQGER ORDER BY DMT_SEQUEN');
end;



procedure TfrmImportCadEstrutura.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryConsulta);
  FreeAndNil(qryGerMat);
  FreeAndNil(qryDetMat);
  If Assigned(cdsGerMat) Then
    FreeAndNil(cdsGerMat);

  If Assigned(cdsDetMat) Then
    FreeAndNil(cdsDetMat);

  inherited;

end;

procedure TfrmImportCadEstrutura.pExibeTela;
begin
  If not cdsGerMat.IsEmpty Then
  Begin
   pCriarFormularios(TfrmImportCadEstruturaConfirma, frmImportCadEstruturaConfirma);
    Try
      frmImportCadEstruturaConfirma.cdsGerMat := cdsGerMAT;
      frmImportCadEstruturaConfirma.cdsDetMat := cdsDetMAT;
      frmImportCadEstruturaConfirma.ShowModal;
    Finally
      pFreeAndNil(frmImportCadEstruturaConfirma);
    End;
  End;
end;

function TfrmImportCadEstrutura.fConvetVazioToNull(texto: string): Variant;
begin
  If Texto = '' Then
    Result := null
  Else
    Result := texto;
end;




procedure TfrmImportCadEstrutura.pPopulaCdsMat(strSEQ_GerMat: String);
var i: integer;
begin
  If Length(strSEQ_GerMat) < 20 Then
    Exit;

  If cdsDetMat.IsEmpty Then
  begin
    qryDetMat.Close;
    qryDetMat.ParamByName('SEQGER').AsString := strSEQ_GerMat;
    qryDetMat.Open;
    qryDetMat.First;
    While Not qryDetMat.Eof Do
    Begin
      cdsDetMat.Insert;
      For i := 0 To qryDetMat.FieldCount -1 do
        cdsDetMat.FieldByName(qryDetMat.Fields[i].FieldName).Value := qryDetMat.Fields[i].Value;
      cdsDetMat.FieldByName('ACAO').AsInteger := AcaoImpCadEstruturaToInt(tpSem);
      cdsDetMat.Post;
      qryDetMat.Next;
    End;
  End;
End;

procedure TfrmImportCadEstrutura.ProcessaGERMAT(strCodite: string; intLinha: Integer);
var i: integer;
Begin
  cdsGerMat.First;
  If cdsGerMat.Locate('GMT_CODITE', strCodite, []) Then
    Exit;

  qryGerMat.Close;
  qryGerMat.ParamByName('CODITE').AsString := strCodite;
  qryGerMat.Open;

  If Not qryGerMat.IsEmpty Then
  Begin
    cdsGerMat.Insert;
    For i := 0 To qryGerMat.FieldCount -1 do
    Begin
      cdsGerMat.FieldByName(qryGerMat.Fields[i].FieldName).Value := qryGerMat.Fields[i].Value;
    End;
  End
  Else
  begin
    cdsGerMat.Insert;
    cdsGerMat.FieldByName('GMT_CODITE').AsString := strCodite;
    cdsGerMat.FieldByName('AUTOINCREM').AsString := strCodite;
    cdsGerMat.FieldByName('GMT_CODEMP').AsString := VS_StrCodEmp;

  End;
  pAtualizaCampoGerMat('GMT_TIPQTD', cGMT_TIPQTD, intLinha);

  pAtualizaCampoGerMat('GMT_OBS001', cGMT_OBS001, intLinha);
  pAtualizaCampoGerMat('GMT_OBS002', cGMT_OBS002, intLinha);
  pAtualizaCampoGerMat('GMT_OBS003', cGMT_OBS003, intLinha);
  pAtualizaCampoGerMat('GMT_OBS004', cGMT_OBS004, intLinha);

  If Not fCfgSis('ESTPER', varBoolean) Then
    cdsGerMat.FieldByName('GMT_TIPQTD').AsString := 'Q';

  qryConsulta.Close;
  qryConsulta.ParamByName('CODITE').AsString := strCodite;
  qryConsulta.Open;
  cdsGerMat.FieldByName('ITE_DESITE').AsString := qryConsulta.FieldByName('ITE_DESITE').AsString;
  cdsGerMat.FieldByName('ITE_REFERE').AsString := qryConsulta.FieldByName('ITE_REFERE').AsString;
  cdsGerMat.Post;

End;

function TfrmImportCadEstrutura.ValidarDadosNovos: Boolean;
  var frmGravando: TFrmGravando;
begin
  blnValidouPorcentagens := False;
  If Not fCfgSis('ESTPER', varBoolean) Then
    Exit(True);

  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    frmGravando.fExecutarAcao := ValidarDadosNovosPrg;
    frmGravando.lblGravando.Caption := 'Aguarde... Validando Porcentagens.';
    frmGravando.Showmodal;
  Finally
    Result := blnValidouPorcentagens;
    pFreeAndNil(frmGravando);
  End;
end;

function  TfrmImportCadEstrutura.ValidarDadosNovosPrg(pgbProgresso: TcxProgressBar): Boolean;
  var fltValAcu: Double;

  frmLog: TfrmLog;
begin
  pCriarFormularios(TfrmLog, frmLog);
  cdsGerMat.Filtered := False;
  cdsGerMat.Filter := 'GMT_TIPQTD = ' + QuotedStr('P');
  cdsGerMat.Filtered := True;
  pgbProgresso.Properties.Max := cdsGerMAT.RecordCount -1;
  While Not cdsGerMat.Eof Do
  Begin
    cdsDetMat.Filtered := False;
    cdsDetMat.Filter :=  'DMT_SEQGER = ' + QuotedStr(cdsGerMat.FieldByName('AUTOINCREM').AsString);
    cdsDetMat.Filtered := True;
    fltValAcu := 0;

    While not cdsDetMat.Eof do
    Begin
      fltValAcu := fltValAcu + cdsDetMat.FieldByName('DMT_QTDITE').AsFloat;
      cdsDetMat.Next;
    End;

    If fltValAcu <> 100 Then
    begin
      cdsDetMat.First;
      frmLog.pAddLinha('Item Estrutura: ' + cdsGerMAT.FieldByName('GMT_CODITE').AsString + ' As Quantidades tem que fechar em 100%');
      While not cdsDetMat.Eof do
      Begin

        frmLog.pAddLinha('    Sub-Produtos: ' + cdsDetMAT.FieldByName('DMT_ITESUB').AsString + ' = ' + cdsDetMAT.FieldByName('DMT_QTDITE').AsString);
        cdsDetMat.Next;
      End;
    End;

    cdsGerMat.Next;

    pgbProgresso.Position := pgbProgresso.Position + 1;
    Application.ProcessMessages;
  End;
  blnValidouPorcentagens := True;
  Result := True;
  If frmLog.memLog.Text <> '' Then
  Begin
    Result := False;
    blnValidouPorcentagens := false;
    frmLog.ShowModal;
  End;
  cdsGerMat.Filtered := False;
  cdsGerMat.Filter := '';
  cdsGerMat.Filtered := True;
  cdsDetMat.Filtered := False;
  cdsDetMat.Filter := '';

end;

procedure TfrmImportCadEstrutura.ProcessaDETMAT(strSEQ_GerMat: String; strGMT_CodEmp: String; intLinha: integer);
var strIteSub: String;
    intSequen: integer;
Begin
  cdsGerMat.First;
  If cdsGerMat.FieldByName('AUTOINCREM').AsString <> strSEQ_GerMat Then
    if Not cdsGerMat.Locate('AUTOINCREM', strSEQ_GerMat, []) Then
      raise Exception.Create('Falha ao definir o Item da Estrutura.');

  strIteSub := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cDMT_ITESUB));

  cdsDetMat.First;

  cdsDetMat.Filtered := False;
  cdsDetMat.Filter :=  'DMT_SEQGER = ' + QuotedStr(strSEQ_GerMat);
  cdsDetMat.Filtered := True;

  pPopulaCdsMat(strSEQ_GerMat);

  intSequen := cdsDetMat.RecordCount + 1;


  cdsDetMat.First;
  If Not cdsDetMat.Locate('DMT_SEQGER;DMT_ITESUB',  VarArrayof([strSEQ_GerMat,strIteSub]), []) Then
  Begin
    qryConsulta.Close;
    qryConsulta.ParamByName('CODITE').AsString := strIteSub;
    qryConsulta.Open;
    cdsDetMat.Insert;
    cdsDetMat.FieldByName('ACAO').AsInteger := AcaoImpCadEstruturaToInt(tpInserir);
    cdsDetMat.FieldByName('ITE_DESITE').AsString := qryConsulta.FieldByName('ITE_DESITE').AsString;
    cdsDetMat.FieldByName('ITE_REFERE').AsString := qryConsulta.FieldByName('ITE_REFERE').AsString;
    cdsDetMat.FieldByName('DMT_SEQUEN').AsInteger := intSequen;
    cdsDetMat.FieldByName('DMT_CUSITE').AsFloat := qryConsulta.FieldByName('ITE_PRECUS').AsFloat;
    cdsDetMat.FieldByName('DMT_CODEMP').AsString := IIf(strGMT_CodEmp <> '', strGMT_CodEmp, VS_StrCodEmp);
    cdsDetMat.FieldByName('AUTOINCREM').AsString := strIteSub;

  End
  Else
  Begin
    cdsDetMat.Edit;
    cdsDetMat.FieldByName('ACAO').AsInteger := AcaoImpCadEstruturaToInt(tpSem);
  End;
  cdsDetMat.FieldByName('DMT_ITESUB').Value := strIteSub;
  pAtualizaCampoDetMat('DMT_QTDITE', cDMT_QTDITE,intLinha);
  cdsDetMat.FieldByName('DMT_SEQGER').Value := strSEQ_GerMat;

  pAtualizaCampoDetMat('DMT_DESPCA', cDMT_DESPCA, intLinha);
  pAtualizaCampoDetMat('DMT_APAREL', cDMT_APAREL, intLinha);
  pAtualizaCampoDetMat('DMT_ACUMOP', cDMT_ACUMOP, intLinha);
  pAtualizaCampoDetMat('DMT_BENEFI', cDMT_BENEFI, intLinha);
  pAtualizaCampoDetMat('DMT_COMPEC', cDMT_COMPEC, intLinha);
  pAtualizaCampoDetMat('DMT_ESPPEC', cDMT_ESPPEC, intLinha);
  pAtualizaCampoDetMat('DMT_LARPEC', cDMT_LARPEC, intLinha);
  pAtualizaCampoDetMat('DMT_PERAPA', cDMT_PERAPA, intLinha);
  pAtualizaCampoDetMat('DMT_PERBEN', cDMT_PERBEN, intLinha);
  pAtualizaCampoDetMat('DMT_QTDPEC', cDMT_QTDPEC, intLinha);


  cdsDetMat.Post;

  cdsDetMat.Filtered := False;
  cdsDetMat.Filter :=  '';


End;

procedure TfrmImportCadEstrutura.pInsereItensCDS(intLinha: integer);
var strCodIte: String;
begin
   Try
     If objValidaExcel.fGetValueCSV(intLinha, cGMT_CODITE) = '' Then
       Exit;
     strCodIte := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cGMT_CODITE));
     ProcessaGERMAT(strCodIte, intLinha);

     cdsGerMAT.First;
     If Not cdsGerMat.Locate('GMT_CODITE', strCodite, []) Then
       raise Exception.Create('Falha ao definir o Item da Estrutura.');

     ProcessaDETMAT(cdsGerMat.FieldByName('AUTOINCREM').AsString, cdsGerMat.FieldByName('GMT_CODEMP').AsString, intLinha);

   Except
     on E: Exception do
        pMensagensErro(E.Message, '[TfrmImportCadProduto.pInsereItensCDS]');
   End;
end;

procedure TfrmImportCadEstrutura.pLimparCDS;
begin
  cdsGerMAT.EmptyDataSet;
  cdsDetMAT.EmptyDataSet;
end;

procedure TfrmImportCadEstrutura.btnGravarClick(Sender: TObject);
begin
  inherited;
  If Not (FileExists(edtPath.Text)) Then
  Begin
    fMensagem('AVISO','Arquivo não encontrado : ' + edtPath.Text + ' !', ['&O K']);
    Exit;
  End;

  try
    objValidaExcel := TValidadorExcel.Create(edtPath.text, cQtdColunas, cGMT_CODITE, '', 0);

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
      cdsGerMAT.Close;
      cdsDetMAT.Close;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmImportCadProduto.btnGravarClick]');
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

function TfrmImportCadEstrutura.fTemTitulo: boolean;
  var
    intValDef: Integer;
begin
  If objValidaExcel.fGetValueCSV(0, cGMT_CODITE) <> '' Then
    Result := not TryStrToInt(Trim(objValidaExcel.fGetValueCSV(0, cGMT_CODITE)), intValDef)
  Else
    Result := False;
end;


end.
