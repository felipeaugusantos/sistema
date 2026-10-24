unit untImportacaoSimilaridade;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, strUtils, ComObj, untFatorPreco, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, untPai, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts,
  Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Mask, FilenameEditFocus, untZClient, untFuncoesSimples, Uni, Data.DB,
  UniClientDataSet, cxGraphics, cxControls, cxLookAndFeels, Math, untTypesSistema,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, cxButtons,
  untParCalculaPrecoCusto, Grids, untTValidaExcel, Datasnap.DBClient,
  EditFocus;

type
  TfrmImportacaoSimilaridade = class(TfrmPai)
    pnlfundo: TPanel;
    lblPath: TLabel;
    btnGravar: TBitBtnLocked;
    edtPath: TFilenameEditFocus;
    btnHlpImp: TBitBtnLocked;
    frxHelp: TfrxReport;
    pgbGeral: TProgressBar;

    procedure btnGravarClick(Sender: TObject);
    procedure btnHlpImpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
    blnArqCsv: Boolean;
    cdsItens : TZClient;
    objValidaExcel : TValidadorExcel;

    const
      cQtdColunas = 2;

    const
      cProdPrincipalDescricao = 'PROD PRINCIPAL';
      cSimilaresDescricao = 'SIMILARES';

    const
      cProdPrincipal = 'A';
      cSimilares = 'B';

    procedure pPrepararPlanilha;
    procedure pCriarCds;
    procedure pInsereItensCDS(intLinha: integer);
    function fTemTitulo: boolean;
    procedure pAjustaItensCDS(intLinha: integer);
    procedure pDesmarcarImportacao(intLinha: Integer);
    procedure pAtualizaCodSim(intLinha: Integer; strCodsim: string);
    procedure pAtualizaPriSim(intLinha: Integer; strCodIte: string);
    function fValidarArquivo: string;
  public
    { Public declarations }
  end;

  var
  frmImportacaoSimilaridade: TfrmImportacaoSimilaridade;

implementation

{$R *.dfm}

uses untImportacaoSimilaridadeConfirma, untFuncoesConsulta;

{ TfrmImportacaoSimilaridade }

procedure TfrmImportacaoSimilaridade.btnGravarClick(Sender: TObject);
Var
  intValIni, intContador : Integer;
  strMensagemValidacao: string;
begin
  inherited;

  If fEmptyStr(edtPath.Text) Then
  Begin
    fMensagem('AVISO','Necessário escolher o arquivo!', ['&OK']);
    Exit;
  End;

  If Not (FileExists(edtPath.Text)) Then
  Begin
    fMensagem('AVISO','Arquivo não encontrado : ' + edtPath.Text + ' !', ['&OK']);
    Exit;
  End;

  try
    objValidaExcel := TValidadorExcel.Create(edtPath.text, cQtdColunas, '', '', 0);

    pPrepararPlanilha;

    strMensagemValidacao := fValidarArquivo;
    If Not (fEmptyStr(strMensagemValidacao)) Then
    Begin
      fMensagem('AVISO', 'Arquivo inválido' + #13 + strMensagemValidacao, ['&OK']);
      Exit;
    End;

    blnArqCsv := UpperCase(ExtractFileExt(objValidaExcel.NomeArquivo)) = '.CSV';

    intValIni := IIf(fTemTitulo, 1 , 0);

    pCriarCds;

    pnlInfo.Caption := 'Aguarde... Carregando cadastro de Produtos...';

    edtPath.Text := AnsiReplaceStr(edtPath.Text,'"','');

    Try
      pgbGeral.Max := objValidaExcel.ArquivoCSV.Count;

      pgbGeral.Position := 0;

      For intContador := intValIni To (objValidaExcel.ArquivoCSV.Count -1) Do
      Begin
        If blnArqCsv Then
          If intContador > objValidaExcel.ArquivoCSV.Count Then
            Continue;

        pInsereItensCDS(intContador);
        pAjustaItensCDS(intContador);
        pgbGeral.StepBy(1);

        pnlInfo.Refresh;
      End;

      Try
        If not cdsItens.IsEmpty Then
        Begin
          pCriarFormularios(TfrmImportacaoSimilaridadeConfirma, frmImportacaoSimilaridadeConfirma);
          frmImportacaoSimilaridadeConfirma.ShowModal(cdsItens, objValidaExcel.ArquivoCSV.Count -1);

          Close;
        End;
      Finally
        FreeAndNil(frmImportacaoSimilaridadeConfirma);
      End;
    Except
      On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[TfrmImportacaoSimilaridade.btnGravarClick]');
        End;
    End;
  Finally
    FreeAndNil(objValidaExcel);
  End
end;

procedure TfrmImportacaoSimilaridade.btnHlpImpClick(Sender: TObject);
begin
  inherited;

  frxHelp.DotMatrixReport           := False;
  frxHelp.PrintOptions.PrintMode    := pmScale;
  frxHelp.PrintOptions.PrintOnSheet := 9;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxHelp);
end;

procedure TfrmImportacaoSimilaridade.FormCreate(Sender: TObject);
begin
  inherited;

  edtPath.Dialog.Dialog.Filter := 'Arquivos Suportados|*.xls;*.xlsx;*.csv';

  cdsItens := Nil;
end;

function TfrmImportacaoSimilaridade.fTemTitulo: boolean;
var
  intContador: Integer;
  strCodSimilares: string;
begin
  strCodSimilares := Trim(objValidaExcel.fGetValueCSV(0, cSimilares));
  If not fEmptyStr(strCodSimilares) Then
  begin
    Result := False;

    for intContador := 1 to Length(strCodSimilares) do
    begin
      if not CharInSet(strCodSimilares[intContador], ['0','1', '2', '3', '4', '5', '6', '7', '8', '9', ',']) then
      begin
        Result := True;
        Exit;
      end;
    end;
  end
  Else
    Result := True;
end;

function TfrmImportacaoSimilaridade.fValidarArquivo: string;
var
  intContador, intValIni, intContadorStrl: Integer;
  strlCod, strlSimilares: TStringList;
begin
  strlSimilares := TStringList.Create;
  strlSimilares.Delimiter := ',';
  strlSimilares.StrictDelimiter := True;

  strlCod := TStringList.Create;

  intValIni := IIf(fTemTitulo, 1 , 0);

  if not (objValidaExcel.ArquivoCSV.Count > intValIni) then
  begin
    Result := 'Não foram encontrados códigos válidos!';
    Exit;
  end;

  For intContador := intValIni To (objValidaExcel.ArquivoCSV.Count -1) Do
  Begin
    If blnArqCsv Then
      If intContador > objValidaExcel.ArquivoCSV.Count Then
        Continue;

    if objValidaExcel.fGetValueCSV(intContador, cSimilares) <> EmptyStr then
    begin
      strlSimilares.DelimitedText := objValidaExcel.fGetValueCSV(intContador, cSimilares);

      For intContadorStrl := 0 To Pred(strlSimilares.Count) Do
      Begin
        if not (StrToIntDef(strlSimilares.Strings[intContadorStrl], 0) > 0) then
        begin
          Result := 'Código similares inválido!';
          Exit;
        end;

        if strlCod.IndexOf(strlSimilares.Strings[intContadorStrl]) >= 0 then
        begin
          Result := 'Existem códigos duplicados!';
          Exit;
        end;

        strlCod.Add(strlSimilares.Strings[intContadorStrl]);
      end;
    end;

    If Trim(objValidaExcel.fGetValueCSV(intContador, cProdPrincipal)) <> EmptyStr Then
    begin
      if not (StrToIntDef(Trim(objValidaExcel.fGetValueCSV(intContador, cProdPrincipal)), 0) > 0) then
      begin
        Result := 'Código principal inválido!';
        Exit;
      end;

      if strlSimilares.IndexOf(Trim(objValidaExcel.fGetValueCSV(intContador, cProdPrincipal))) = -1 then
      begin
        if strlCod.IndexOf(Trim(objValidaExcel.fGetValueCSV(intContador, cProdPrincipal))) >= 0 then
        begin
          Result := 'Existem códigos duplicados!';
          Exit;
        end;
       end;

      strlCod.Add(Trim(objValidaExcel.fGetValueCSV(intContador, cProdPrincipal)));
    end;
  End;
end;

procedure TfrmImportacaoSimilaridade.pAjustaItensCDS(intLinha: Integer);
var
  strCodSimAux: string;
begin
  Try
    try
      cdsItens.Filter := 'LINHA = ' + IntToStr(intLinha) + ' AND IMPORT = 0';
      cdsItens.Filtered := True;

      if cdsItens.RecordCount > 0 then
      begin
        pDesmarcarImportacao(intLinha);
        Exit;
      end;

      cdsItens.Filter := 'LINHA = ' + IntToStr(intLinha) + ' AND ITE_CODSIM <> ' + QuotedStr(EmptyStr);

      if cdsItens.RecordCount > 1 then
      begin
        cdsItens.First;
        strCodSimAux := EmptyStr;

        while not cdsItens.Eof do
        begin
          if fEmptyStr(strCodSimAux) then
            strCodSimAux := cdsItens.FieldByName('ITE_CODSIM').Value;

          if strCodSimAux <> cdsItens.FieldByName('ITE_CODSIM').Value then
          begin
            pDesmarcarImportacao(intLinha);
            Exit;
          end;

          cdsItens.Next;
        end;

        pAtualizaCodSim(intLinha, strCodSimAux)
      end;

      if cdsItens.RecordCount = 1 then
        pAtualizaCodSim(intLinha, cdsItens.FieldByName('ITE_CODSIM').Value);

      cdsItens.Filter := 'LINHA = ' + IntToStr(intLinha);

      if Trim(objValidaExcel.fGetValueCSV(intLinha, cProdPrincipal)) <> EmptyStr then
        pAtualizaPriSim(intLinha, Trim(objValidaExcel.fGetValueCSV(intLinha, cProdPrincipal)));
    finally
      cdsItens.Filter := EmptyStr;
      cdsItens.Filtered := False;
    end;
  Except
    on E: Exception do
       pMensagensErro(E.Message, '[TfrmImportacaoSimilaridade.pAjustaItensCDS]');
  End;
end;

procedure TfrmImportacaoSimilaridade.pAtualizaCodSim(intLinha: Integer;
  strCodsim: string);
begin
  Try
    cdsItens.Filter := 'LINHA = ' + IntToStr(intLinha);
    cdsItens.Filtered := True;

    if cdsItens.RecordCount > 0 then
    begin
      cdsItens.First;

      while not cdsItens.Eof do
      begin
        cdsItens.Edit;
        cdsItens.FieldByName('ITE_CODSIM').Value := strCodsim;
        cdsItens.Post;

        cdsItens.Next;
      end;
    end;
  finally
    cdsItens.Filter := EmptyStr;
    cdsItens.Filtered := False;
  end;
end;

procedure TfrmImportacaoSimilaridade.pAtualizaPriSim(intLinha: Integer;
  strCodIte: string);
begin
  Try
    cdsItens.Filter := 'LINHA = ' + IntToStr(intLinha);
    cdsItens.Filtered := True;

    if cdsItens.RecordCount > 0 then
    begin
      cdsItens.First;

      while not cdsItens.Eof do
      begin
        cdsItens.Edit;

        if cdsItens.FieldByName('ITE_CODITE').Value = strCodIte then
          cdsItens.FieldByName('ITE_PRISIM').Value := 'S'
        else
          cdsItens.FieldByName('ITE_PRISIM').Value := 'N';

        cdsItens.Post;

        cdsItens.Next;
      end;
    end;
  finally
    cdsItens.Filter := EmptyStr;
    cdsItens.Filtered := False;
  end;
end;

procedure TfrmImportacaoSimilaridade.pCriarCds;
var
  strSql: string;
  intContador, intValIni, intContadorStrl: Integer;
  strlCod: TStringList;
begin
  strSql := EmptyStr;

  intValIni := IIf(fTemTitulo, 1 , 0);

  For intContador := intValIni To (objValidaExcel.ArquivoCSV.Count -1) Do
  Begin
    try
      If blnArqCsv Then
        If intContador > objValidaExcel.ArquivoCSV.Count Then
          Continue;

      strlCod := TStringList.Create;
      strlCod.Delimiter := ',';
      strlCod.StrictDelimiter := True;
      strlCod.Duplicates := dupIgnore;

      if objValidaExcel.fGetValueCSV(intContador, cSimilares) <> EmptyStr then
      begin
        strlCod.DelimitedText := objValidaExcel.fGetValueCSV(intContador, cSimilares);

        For intContadorStrl := 0 To Pred(strlCod.Count) Do
        Begin
          strlCod.Strings[intContadorStrl] := fStrZero(strlCod.Strings[intContadorStrl], 5);
        end;
      end;

      If objValidaExcel.fGetValueCSV(intContador, cProdPrincipal) <> EmptyStr Then
        strlCod.Add(fStrZero(objValidaExcel.fGetValueCSV(intContador, cProdPrincipal), 5));

      if strlCod.Count > 0 then
      begin
        if not fEmptyStr(strSql) then
          strSql := strSql + (' UNION ALL ');

        strSql := strSql + ('SELECT ');
        strSql := strSql + (' ITE_CODITE,');
        strSql := strSql + (' ITE_CODFOR,');
        strSql := strSql + (' ITE_CODFAB,');
        strSql := strSql + (' ITE_DESITE,');
        strSql := strSql + (' ITE_CODSIM,');
        strSql := strSql + (' ITE_PRISIM,');
        strSql := strSql + (' 1 AS IMPORT, ');
        strSql := strSql + (IntToStr(intContador) + ' as LINHA');
        strSql := strSql + (' FROM CADITE ');
        strSql := strSql + ('  WHERE ');
        strSql := strSql + (' ITE_CODITE IN (' + fCommaTextToQuoted(strlCod.CommaText) + ')');
      end;
    finally
      FreeAndNil(strlCod);
    end;
  End;

  If Assigned(cdsItens) Then
    FreeAndNil(cdsItens);

  cdsItens := TZClient.Create(Self, strSql);

  cdsItens.fAbreClient(True,'[TfrmImportacaoSimilaridade.pCriarCds]');
end;

procedure TfrmImportacaoSimilaridade.pDesmarcarImportacao(intLinha: Integer);
begin
  Try
    cdsItens.Filter := 'LINHA = ' + IntToStr(intLinha);
    cdsItens.Filtered := True;

    if cdsItens.RecordCount > 0 then
    begin
      cdsItens.First;

      while not cdsItens.Eof do
      begin
        cdsItens.Edit;
        cdsItens.FieldByName('IMPORT').Value := '0';
        cdsItens.Post;

        cdsItens.Next;
      end;
    end;
  finally
    cdsItens.Filter := EmptyStr;
    cdsItens.Filtered := False;
  end;
end;

procedure TfrmImportacaoSimilaridade.pInsereItensCDS(intLinha: integer);
var
  strlCod: TStringList;
  intContador: Integer;
begin
  Try
    try
      strlCod := TStringList.Create;
      strlCod.Delimiter := ',';
      strlCod.StrictDelimiter := True;

      strlCod.DelimitedText := Trim(objValidaExcel.fGetValueCSV(intLinha, cSimilares));

      if Trim(objValidaExcel.fGetValueCSV(intLinha, cProdPrincipal)) <> EmptyStr then
      begin
        if not cdsItens.Locate('LINHA;ITE_CODITE',
          VarArrayOf([intLinha, fStrZero(objValidaExcel.fGetValueCSV(intLinha, cProdPrincipal), 5)]), [loCaseInSensitive]) then
        begin
          cdsItens.Append;
          cdsItens.FieldByName('LINHA').Value := intLinha;
          cdsItens.FieldByName('IMPORT').Value := '0';
          cdsItens.FieldByName('ITE_CODITE').Value := fStrZero(objValidaExcel.fGetValueCSV(intLinha, cProdPrincipal), 5);
          cdsItens.FieldByName('ITE_DESITE').Value := 'Código não encontrado';
          cdsItens.Post;
        end;
      end;

      for intContador := 0 to Pred(strlCod.Count) do
      begin
        if not cdsItens.Locate('LINHA;ITE_CODITE',
          VarArrayOf([intLinha, fStrZero(strlCod.Strings[intContador], 5)]), [loCaseInSensitive]) then
        begin
          cdsItens.Append;
          cdsItens.FieldByName('LINHA').Value := intLinha;
          cdsItens.FieldByName('IMPORT').Value := '0';
          cdsItens.FieldByName('ITE_CODITE').Value := fStrZero(strlCod.Strings[intContador], 5);
          cdsItens.FieldByName('ITE_DESITE').Value := 'Código não encontrado';
          cdsItens.Post;
        end;
      end;
    finally
      FreeAndNil(strlCod);
    end;
  Except
    on E: Exception do
       pMensagensErro(E.Message, '[TfrmImportacaoSimilaridade.pInsereItensCDS]');
  End;
end;

procedure TfrmImportacaoSimilaridade.pPrepararPlanilha;
begin
  If Not Assigned(objValidaExcel) Then
    Exit;

  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cProdPrincipalDescricao, cProdPrincipal, 5, True, True, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cSimilares, cSimilares, 255, True, True, '', ''));
end;

end.
