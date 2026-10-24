unit untImportarPlanilhaAjusteEstoque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, StrUtils,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxLookAndFeels, Data.DB,
  cxLookAndFeelPainters, cxControls, cxContainer, cxEdit, cxProgressBar,
  cxTextEdit, cxMaskEdit, cxButtonEdit, FilenameEditFocus, cxButtons,
  Uni, UniClientDataSet, untTValidaExcel, Vcl.Mask, MaskEditFocus,
  System.DateUtils;

type
  TfrmImportarPlanilhaAjusteEstoque = class(TfrmPai)
    btnGravar: TBitBtnLocked;
    btnHlpImp: TcxButton;
    pnlfundo: TPanel;
    lblPathArquivo: TLabel;
    edtPath: TFilenameEditFocus;
    pgbGeral: TcxProgressBar;
    frxHelp: TfrxReport;
    lblDtaHra: TLabel;
    mskData: TMaskEditFocus;
    mskHora: TMaskEditFocus;
    procedure btnHlpImpClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    objValidaExcel: TValidadorExcel;
    FItensDupl: TStringList;
    FIteDtaBal: TStringList;

    const QTD_COLUNAS = 6;
          CODITE = 'C';
          QTDITE = 'F';

    procedure pCriaDataSet;
    procedure pExibeTela;
    procedure pInsereItensCDS(intLinha: integer);
    procedure pProcessaItens;
    function fConvetVazioToNull(strTexto: String): Variant;
    function fRetornaLinhaAposTitulo : Integer;
    procedure pValidaItens;
  public
    { Public declarations }
    blnOk,
    blnSubPro : Boolean;
    cdsItens : TUniClientDataSet;
    strHUBMKP: String;
    strEmpExt: String;
  end;

implementation

uses
  untConfirmaImportacaoProdutosAjuste, untFuncoesSimples, untObservacao;

{$R *.dfm}

function TfrmImportarPlanilhaAjusteEstoque.fConvetVazioToNull(strTexto: String): Variant;
begin
  If fEmptyStr(strTexto) Then
    Result := null
  Else
    Result := strTexto;
end;


Procedure TfrmImportarPlanilhaAjusteEstoque.pCriaDataSet;
Begin
  cdsItens := TUniClientDataSet.Create(Self);

  With cdsItens.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODITE';
    DataType := ftString;
    Size     := fTamCodIte;
    Required := True;
  End;

  With cdsItens.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'DESITE';
    DataType := ftString;
    Size     := 70;
    Required := False;
  End;

  With cdsItens.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'UNIITE';
    DataType := ftString;
    Size     := 15;
    Required := False;
  End;

  With cdsItens.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODREF';
    DataType := ftString;
    Size     := 20;
    Required := False;
  End;

  With cdsItens.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'SALDIS';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsItens.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'SALEXT';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsItens.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'QTDITE';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsItens.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'VALIDACAO';
    DataType := ftString;
    Size     := 150;
    Required := False;
  End;

  cdsItens.CreateDataSet;

  (cdsItens.FieldByName('SALDIS') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  (cdsItens.FieldByName('SALEXT') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  (cdsItens.FieldByName('QTDITE') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));

  cdsItens.IndexFieldNames := 'CODITE';
End;

procedure TfrmImportarPlanilhaAjusteEstoque.pInsereItensCDS(intLinha: integer);
  const
    SQL = 'SELECT          '+
          '  D.DMT_ITESUB, '+
          '  D.DMT_QTDITE, '+
          '  U.UNI_DESUNI, '+
          '  C.*           '+
          'FROM            '+
          '  GERMAT G      '+
          '  INNER JOIN DETMAT D ON (D.DMT_SEQGER = G.AUTOINCREM) '+
          '  INNER JOIN CADITE C ON (C.ITE_CODITE = D.DMT_ITESUB) '+
          '  INNER JOIN CADUNI U ON (C.ITE_CODUNI = U.UNI_CODUNI) '+
          'WHERE           '+
          '  G.GMT_CODITE = :CODITE';

  var
    LQryItem,
    LQryEstrutura : TUniQuery;

  procedure Add(ACodIte, ADesIte, ADesUni, ARefere : String; AQtdIte : Double; AAchou : Boolean);
    var
      LValidacao : String;
  begin

    LValidacao := '';

    cdsItens.Open;
    cdsItens.Insert;
    cdsItens.FieldByName('CODITE').AsString  := ACodIte;
    cdsItens.FieldByName('QTDITE').AsFloat   := AQtdIte;
    cdsItens.FieldByName('DESITE').AsString  := '';
    cdsItens.FieldByName('UNIITE').AsString  := '';
    cdsItens.FieldByName('CODREF').AsString  := '';
    cdsItens.FieldByName('SALDIS').Value     := 0;

    If (AAchou) Then
    Begin
      cdsItens.FieldByName('DESITE').Value := ADesIte;
      cdsItens.FieldByName('UNIITE').Value := ADesUni;
      cdsItens.FieldByName('CODREF').Value := ARefere;
      cdsItens.FieldByName('SALDIS').Value := fRetornaSaldoDisponivel(ACodIte, False, True);
      cdsItens.FieldByName('SALEXT').Value := fRetSalExterno(ACodIte, VS_strCodEmp, strEmpExt);
    End;

    If (fEmptyStr(LValidacao)) And (AQtdIte < 0) Then
      LValidacao := 'Quantidade não informada ou valor inválido!';

    If fEmptyStr(LValidacao) And (Not AAchou) Then
      LValidacao := 'Código de produto não encontrado no autcom!';

    cdsItens.FieldByName('VALIDACAO').AsString := LValidacao;
    cdsItens.Post;

  end;

  function EhItemEstrutura : Boolean;
  begin

    Result := False;

    If (Not blnSubPro) Then
      Exit;

    If (LQryItem.IsEmpty) Then
      Exit;

    If (Not fItemEstrutura(LQryItem.FieldByName('ITE_CODITE').AsString)) Then
      Exit;

    Result := True;

  end;

  function RetornaQuantidadeCelula : Double;
    var
      LValor : String;
      LValorFinal : Double;
  begin

    Result := 0.00;
    LValor := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, QTDITE));

    If TryStrToFloat(LValor, LValorFinal) Then
      Result := LValorFinal;

  end;

begin

  LQryItem := fCriaQuery(Nil);

  try

    LQryItem.SQL.Clear;
    LQryItem.SQL.Add('SELECT         ');
    LQryItem.SQL.Add('  C.*,         ');
    LQryItem.SQL.Add('  U.UNI_DESUNI,');
    LQryItem.SQL.Add('  G.ITE_SALDOS ');
    LQryItem.SQL.Add('FROM           ');
    LQryItem.SQL.Add('  ITEGER G,    ');
    LQryItem.SQL.Add('  CADITE C     ');
    LQryItem.SQL.Add('  JOIN CADUNI U ON C.ITE_CODUNI = U.UNI_CODUNI ');
    LQryItem.SQL.Add('WHERE          ');
    LQryItem.SQL.Add('  C.ITE_CODITE = :CODITE      AND ');
    LQryItem.SQL.Add('  C.ITE_CODITE = G.ITE_CODITE AND ');
    LQryItem.SQL.Add('  G.ITE_CODEMP = :CODEMP ');
    LQryItem.ParamByName('CODITE').AsString := fPadL(objValidaExcel.fGetValueCSV(intLinha, CODITE), fTamCodIte, '0');
    LQryItem.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LQryItem.Open;

    If (EhItemEstrutura) Then
    Begin

      LQryEstrutura := fCriaQuery;

      Try

        LQryEstrutura.Close;
        LQryEstrutura.SQL.Clear;
        LQryEstrutura.SQL.Add(SQL);
        LQryEstrutura.ParamByName('CODITE').AsString := LQryItem.FieldByName('ITE_CODITE').AsString;
        LQryEstrutura.Open;

        LQryEstrutura.First;
        While Not LQryEstrutura.Eof Do
        Begin
          Add(LQryEstrutura.FieldByName('DMT_ITESUB').AsString,
              LQryEstrutura.FieldByName('ITE_DESITE').AsString,
              LQryEstrutura.FieldByName('UNI_DESUNI').AsString,
              LQryEstrutura.FieldByName('ITE_REFERE').AsString,
              LQryEstrutura.FieldByName('DMT_QTDITE').AsFloat * RetornaQuantidadeCelula,
              True);
          LQryEstrutura.Next;
        End;

      Finally
        FreeAndNil(LQryEstrutura);
      End;

      Exit;

    End;

    Add(fPadL(objValidaExcel.fGetValueCSV(intLinha, CODITE), fTamCodIte, '0'),
        IIF(Not LQryItem.IsEmpty, LQryItem.FieldByName('ITE_DESITE').AsString, EmptyStr),
        IIF(Not LQryItem.IsEmpty, LQryItem.FieldByName('UNI_DESUNI').AsString, EmptyStr),
        IIF(Not LQryItem.IsEmpty, LQryItem.FieldByName('ITE_REFERE').AsString, EmptyStr),
        RetornaQuantidadeCelula,
        (Not LQryItem.IsEmpty));

  finally
    FreeAndNil(LQryItem);
  end;

end;

procedure TfrmImportarPlanilhaAjusteEstoque.pProcessaItens;
  Var
    intValIni : Integer;
    intContador : Integer;
begin
  pgbGeral.Properties.Max := objValidaExcel.ArquivoCSV.Count -1;
  pgbGeral.Position := 0;

  If cdsItens.Active Then
    cdsItens.EmptyDataSet;

  intValIni := fRetornaLinhaAposTitulo;
  pgbGeral.Position := 0;
  For intContador := intValIni To (objValidaExcel.ArquivoCSV.Count -1) Do
  Begin
    pnlInfo.Caption := 'Importando itens...'+ IntToStr(intContador) +'/' +IntToStr(objValidaExcel.ArquivoCSV.Count-intValIni);

    If intContador > objValidaExcel.ArquivoCSV.Count Then
      Continue;

    pInsereItensCDS(intContador);
    pgbGeral.Position := pgbGeral.Position + 1;
    Application.ProcessMessages;
  End;

  pValidaItens;

  If FItensDupl.Count > 0 Then
  Begin
    TfrmObservacao.fObservacao('Não é permitido ter itens repetidos na planilha. Ajuste os itens abaixo antes de continuar:', FItensDupl.Text);
    Exit;
  End;

  If FIteDtaBal.Count > 0 Then
  Begin
    TfrmObservacao.fObservacao('Não é permitido informar uma planilha com data anterior à data de balanço do(s) produto(s) relacionado(s). '+
      'Gere uma planilha mais recente no site da empresa externa e depois tente novamente, ou remova o(s) item(ns) abaixo da planilha:',
      FIteDtaBal.Text);
    Exit;
  End;

  pExibeTela;
end;

procedure TfrmImportarPlanilhaAjusteEstoque.pExibeTela;
var
  frmConfirmaImportacaoProdutosAjuste : TfrmConfirmaImportacaoProdutosAjuste;
begin
  If Not cdsItens.IsEmpty Then
  Begin
    pCriarFormularios(TfrmConfirmaImportacaoProdutosAjuste, frmConfirmaImportacaoProdutosAjuste);
    Try
      frmConfirmaImportacaoProdutosAjuste.cdsItens    := cdsItens;
      frmConfirmaImportacaoProdutosAjuste.strHUBMKP   := strHUBMKP;
      frmConfirmaImportacaoProdutosAjuste.dtaDataPlan := StrToDateDef(mskData.Text, 0);
      frmConfirmaImportacaoProdutosAjuste.hraHoraPlan := StrToTimeDef(mskHora.Text, 0);
      frmConfirmaImportacaoProdutosAjuste.ShowModal;

      blnOk := frmConfirmaImportacaoProdutosAjuste.blnOk;
    Finally
      pFreeAndNil(frmConfirmaImportacaoProdutosAjuste);
    End;
  End;
end;

procedure TfrmImportarPlanilhaAjusteEstoque.btnGravarClick(Sender: TObject);
  Var
    dtaDtaMin: TDate;
begin
  inherited;

  If (fEmptyStr(edtPath.Text)) Then
  Begin
    pMensagemOk('Selecione um arquivo!');
    pSetFocus(edtPath);
    Exit;
  End
  Else If Not (FileExists(edtPath.Text)) Then
  Begin
    fMensagem('AVISO','Arquivo não encontrado: ' + edtPath.Text + ' !', ['&O K']);
    pSetFocus(edtPath);
    Exit;
  End;

  if (fEmptyDate(mskData.Text)) or (StrToTimeDef(mskHora.Text, 0) = 0) then
  begin
    fMensagem('', 'A data e hora da extração da planilha são obrigatórias. Informe exatamente os dados ' +
      'do momento em que a planilha foi gerada.', ['&OK']);
    pSetFocus(mskData);
    Exit;
  end;

  dtaDtaMin := DateOf(IncDay(fNow, -10));

  If StrToDate(mskData.Text) < dtaDtaMin Then
  Begin
    fMensagem('', 'Não é permitido informar uma planilha com data anterior à '+ FormatDateTime('dd/mm/yyyy', dtaDtaMin) +'.'+ sLineBreak +
      'Gere uma planilha mais recente no site da empresa externa e depois tente novamente.', ['&OK']);
    pSetFocus(mskData);
    Exit;
  End;

  try
    objValidaExcel := TValidadorExcel.Create(edtPath.text, QTD_COLUNAS, '', '', 0);

    btnHlpImp.Enabled     := False;
    btnGravar.Enabled     := False;
    btnSair.Enabled       := False;
    edtPath.Enabled       := False;

    Mouse.SettingChanged(10);
    pgbGeral.Visible := True;
    Application.ProcessMessages;
    edtPath.Text := AnsiReplaceStr(edtPath.Text,'"','');

    Try
      pProcessaItens;

      SetForegroundWindow(Handle);
      edtPath.Clear;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmImportarPlanilhaAjusteEstoque.btnGravarClick]');
      End;
    End;
  Finally
    btnSair.Enabled       := True;
    edtPath.Enabled       := True;

    btnHlpImp.Enabled := True;
    btnGravar.Enabled := True;
    pnlInfo.Caption := '';
    FreeAndNil(objValidaExcel);
    pgbGeral.Position     := 0;
    pgbGeral.Visible := False;
    pSetFocus(btnSair);
  End;

  Close;
end;

procedure TfrmImportarPlanilhaAjusteEstoque.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  frxHelp.DotMatrixReport           := False;
  frxHelp.PrintOptions.PrintMode    := pmScale;
  frxHelp.PrintOptions.PrintOnSheet := 9;
  frxHelp.Variables['CTLEST']       := fCfgSis('CTLEST', varString);
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxHelp);
end;

procedure TfrmImportarPlanilhaAjusteEstoque.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSet;

  FItensDupl := TStringList.Create;
  FItensDupl.Sorted     := True;
  FItensDupl.Duplicates := dupIgnore;

  FIteDtaBal := TStringList.Create;
  FIteDtaBal.Sorted     := True;
  FIteDtaBal.Duplicates := dupIgnore;
end;

procedure TfrmImportarPlanilhaAjusteEstoque.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FItensDupl);
  FreeAndNil(FIteDtaBal);
end;

function TfrmImportarPlanilhaAjusteEstoque.fRetornaLinhaAposTitulo: Integer;
  var
    intTestedor : Integer;
    intContador : Integer;
begin
  Result := 0;
  For intContador := 0 To Pred(objValidaExcel.ArquivoCSV.Count) Do
  Begin
    If TryStrToInt(Trim(objValidaExcel.fGetValueCSV(intContador, CODITE)), intTestedor) Then
      Exit(intContador);
  End;
end;

procedure TfrmImportarPlanilhaAjusteEstoque.pValidaItens;
  Var
    cdsClone: TUniClientDataSet;
    dtaDtaBal: TDate;
begin
  cdsClone := TUniClientDataSet.Create(Nil);

  Try
    FItensDupl.Clear;
    FIteDtaBal.Clear;

    cdsItens.DisableControls;
    pCloneDataSet(cdsClone, cdsItens);

    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      cdsClone.Filtered := False;
      cdsClone.Filter   := 'CODITE = ' + QuotedStr(cdsItens.FieldByName('CODITE').AsString);
      cdsClone.Filtered := True;

      If cdsClone.RecordCount > 1 Then
        FItensDupl.Add(cdsItens.FieldByName('CODITE').AsString + ' - ' +
                       cdsItens.FieldByName('DESITE').AsString);

      dtaDtaBal := fCampoTabela('ITE_DTABAL', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'],
                                [cdsItens.FieldByName('CODITE').AsString, VS_StrCodEmp]);

      If dtaDtaBal > StrToDate(mskData.Text) Then
        FIteDtaBal.Add(cdsItens.FieldByName('CODITE').AsString + ' - ' +
                       cdsItens.FieldByName('DESITE').AsString);

      cdsItens.Next;
    End;
  Finally
    cdsItens.EnableControls;
    FreeAndNil(cdsClone);
  End;
end;

end.
