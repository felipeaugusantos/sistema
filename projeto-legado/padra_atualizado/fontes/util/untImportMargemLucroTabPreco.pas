unit untImportMargemLucroTabPreco;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
 System.Classes, Vcl.Graphics, strUtils, ComObj, untFatorPreco, Vcl.Controls,
 Vcl.Forms, Vcl.Dialogs, untPai, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts,
 Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.ComCtrls,
 Vcl.Mask, FilenameEditFocus, untZClient, untFuncoesSimples, Uni, Data.DB,
 UniClientDataSet, cxGraphics, cxControls, cxLookAndFeels,
 cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, cxButtons,
 untTValidaExcel;

 type
  TRecTabPrecos = Record
    fltPreVen,
    fltMarBru,
    fltComiss: Double;
  End;

  TArrRecPrecos = Array[1..7] Of TRecTabPrecos;

  TfrmImportMargemLucroTabPreco = class(TfrmPai)
    pnlfundo: TPanel;
    Label1: TLabel;
    btnGravar: TBitBtnLocked;
    pgbGeral: TProgressBar;
    lblAviso: TLabel;
    edtPath: TFilenameEditFocus;
    btnHlpImp: TBitBtnLocked;
    frxHelp: TfrxReport;
    frxHelp2: TfrxReport;
    procedure pCriarCds;
    procedure pLimparCds;
    procedure pInsereItensCds(intLinha: integer);
    procedure pTratarCampoNulo_Venda_ou_Margem(intTabela: integer; strCampo: string);
    procedure pFormatarCampo(strCampo: string; blnTem_ITE: boolean = False);
    procedure btnGravarClick(Sender: TObject);
    function  fCriarCdsLocalizaItens: TZClient;
    function  fTemTitulo: boolean;
    function  fValidaMargem(intTabPreco: Integer; cdsIte: TZClient; objPrecos: TArrRecPrecos): Boolean;
    function  fLocalizaItenCDS(qryLocaliza: TZClient; intLinha: Integer; var blnLeuInfItemArquivo: Boolean): boolean;
    function  fCalcularPrecos(cdsIte: TZClient): TArrRecPrecos;
    procedure btnHlpImpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    strMarMkp,
    strPcmPro: String;

    Excel : Variant;
    objFatPre: TFatorPreco;
    cdsItens : TZClient;
    qryLocalizaItem: TZClient;
    FblnRecalcMargem: boolean;

    blnArqCsv: Boolean;

    objValidaExcel : TValidadorExcel;

    Function fGetDado(strColuna: String; intLinha: Integer; ftpTipo: TFieldType = ftString): Variant;

    procedure SetblnRecalcMargem(const Value: boolean);
    const cCodIte = 'A';
          cCodBar = 'B';
          cCodFab = 'C';
          cCodFor = 'D';
          cMar__1 = 'E';
          cMar__2 = 'F';
          cMar__3 = 'G';
          cMar__4 = 'H';
          cMar__5 = 'I';
          cMar__6 = 'J';
          cMar__7 = 'K';

     const cQtdColunas = 11;
    { Private declarations }
    function fSqlBase: String;
  public
    property blnRecalcMargem: boolean read FblnRecalcMargem write SetblnRecalcMargem;
    destructor Destroy; override;
    { Public declarations }
  end;

var
  frmImportMargemLucroTabPreco: TfrmImportMargemLucroTabPreco;

implementation

{$R *.dfm}

uses untTConfiguracao, untImportMargemLucroTabPrecoConfirma;

procedure TfrmImportMargemLucroTabPreco.btnGravarClick(Sender: TObject);
  Var
    intValIni, intRes, intContador, intQtdRegistros : Integer;
    dteInicio, dteFim: TDateTime;
begin
  inherited;
  intRes := -1;
  If fVerificaCampos Then
  Begin
    btnGravar.Enabled := False;
    btnSair.Enabled   := False;
    btnHlpImp.Enabled := False;
    edtPath.Enabled   := False;

    edtPath.Text := AnsiReplaceStr(edtPath.Text,'"','');
    {*******************************}
    { VERIRICA SE O ARQUIVO EXISTE  }
    {****************************LU*}
    If Not (FileExists(edtPath.Text)) Then
    Begin
      fMensagem('AVISO', 'Arquivo não encontrado : ' + edtPath.Text + ' !', ['&O K']);
      Exit;
    End;

    objValidaExcel := TValidadorExcel.Create(edtPath.text, cQtdColunas, cCodIte, '', 0);

    Try
      Try
        pnlInfo.Caption       := 'Aguarde... Carregando tabela de Itens...';
        Application.ProcessMessages;
        qryLocalizaItem := fCriarCdsLocalizaItens();

        pCriarCds;

        blnArqCsv := True; //UpperCase(ExtractFileExt(objValidaExcel.NomeArquivo)) = '.CSV'

        If blnArqCsv Then
        Begin

          pgbGeral.Max := objValidaExcel.ArquivoCSV.count;
          intQtdRegistros := objValidaExcel.ArquivoCSV.count;
        End Else
        Begin
          {**************************************}
          {* ABRE EXCEL E ARQUIVO XLS           *}
          {***********************************LU*}
          Excel := CreateOleObject('Excel.Application');
          Excel.Visible       := False;
          Excel.DisplayAlerts := False;
          Excel.WorkBooks.Open(Filename := edtPath.Text);

          {****************************************}
          {* VAI PARA A ULTIMA CELULA COM DADOS   *}
          {* PARA PEGAR A QUANTIDADE DE REGISTROS *}
          {*************************************LU*}
          {xlCellTypeLastCell. A última célula no intervalo usado = 11}
          Excel.Selection.SpecialCells(11).Select;

          pgbGeral.Max := Excel.ActiveCell.Row -1;
          intQtdRegistros := Excel.ActiveCell.Row -1;
        End;

        pgbGeral.Position := 0;

        pLimparCDS;

        intValIni := 0;
        If intQtdRegistros > 1 Then
          intValIni := IIf(fTemTitulo, 1 , 0);

        pnlInfo.Caption       := 'Aguarde... Importando dados da planilha.';
        For intContador := intValIni To (objValidaExcel.ArquivoCSV.Count -1) Do
        Begin

          If blnArqCsv Then
          Begin
            If intContador > objValidaExcel.ArquivoCSV.Count Then
              Continue;
          End;

          pInsereItensCDS(intContador);
          pgbGeral.StepBy(1);

          dteInicio := fNow();
          dteFim := fNow();

          pnlInfo.Caption := 'Importando: ' + IntToStr(intContador) + ' de ' + IntToStr(pgbGeral.Max + 1)
          + ' - Tempo Rest.: '
          + IntToStr(Trunc((pgbGeral.Max-IntContador)/(intcontador / ((((dteFim - dteInicio) * 86400)) / 60))+1)) +' min. (' +IntToStr(Trunc((intcontador / ((((dteFim - dteInicio) * 86400)) / 60)))) +'/min)';

          pnlInfo.Refresh;
        End;

        try
          If not cdsItens.IsEmpty Then
          Begin
            pCriarFormularios(TfrmImportMargemLucroTabPrecoConfirma, frmImportMargemLucroTabPrecoConfirma);
            frmImportMargemLucroTabPrecoConfirma.blnRecalcMargem := FblnRecalcMargem;
            intRes := frmImportMargemLucroTabPrecoConfirma.ShowModal(cdsItens);
          End;
        Finally
          FreeAndNil(frmImportMargemLucroTabPrecoConfirma);
        End;

        SetForegroundWindow(Handle);
        If intRes = mrOk Then
           fMensagem('Aviso', 'Importação concluída com sucesso!', ['&O k']);

        edtPath.Clear;
        btnGravar.Enabled     := True;
        btnSair.Enabled       := True;
        edtPath.Enabled       := True;

        pnlInfo.Caption       := '';
        pgbGeral.Position     := 0;
        pSetFocus(btnSair);

        cdsItens.Close;

      Except
        On E: Exception Do
        Begin

          pMensagensErro(E.Message, '[TfrmImportMargemLucroTabPreco.btnGravarClick]');
          pSetFocus(btnSair);
        End;
      End;
    Finally
      btnGravar.Enabled  := True;
      btnSair.Enabled    := True;
      edtPath.Enabled    := True;
      btnHlpImp.Enabled  := True;
      pnlInfo.Caption    := '';
      pgbGeral.Position  := 0;
      FreeAndNil(qryLocalizaItem);
      FreeAndNil(objValidaExcel);
    End;
  End;

  Try
    Excel.Quit;
  Except
  End;

end;

procedure TfrmImportMargemLucroTabPreco.btnHlpImpClick(Sender: TObject);
  var
    frx: TfrxReport;
begin
  inherited;
  If FblnRecalcMargem Then
    frx := frxHelp2
  Else
    frx := frxHelp;

  frx.DotMatrixReport           := False;
  frx.PrintOptions.PrintMode    := pmScale;
  frx.PrintOptions.PrintOnSheet := 9;

  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frx);
end;

destructor TfrmImportMargemLucroTabPreco.Destroy;
begin
  FreeAndNil(CdsItens);
  Excel := '';
  inherited;
end;

function TfrmImportMargemLucroTabPreco.fCalcularPrecos(cdsIte: TZClient): TArrRecPrecos;
  var
   intTabela: integer;
   fltPreCus,
   fltPre : Double;
begin
  fltPreCus := cdsite.FieldByName('ITE_PRECUS').AsFloat;

  For intTabela := 1 To 7 Do
  Begin
    If FblnRecalcMargem Then

      Result[intTabela].fltPreVen := cdsIte.FieldByName('ITE_PREVE' +  IntToStr(intTabela) + '_NOV').AsFloat
    Else
      Result[intTabela].fltMarBru := cdsIte.FieldByName('ITE_MARBR' +  IntToStr(intTabela) + '_NOV').AsFloat;
    Result[intTabela].fltComiss := cdsIte.FieldByName('ITE_COMTB' +  IntToStr(intTabela) + '_NOV').AsFloat;
    
    If (Not Assigned(objFatPre)) Or (intTabela = 1) Then
    Begin

      fltPre := untFuncoesSimples.fCalculaPrecoVenda(Iif(FblnRecalcMargem, 2, 1),
                                   fltPreCus + cdsIte.FieldByName('ITE_OUTVAL').AsFloat,
                                   Result[intTabela].fltPreven,
                                   Result[intTabela].fltMarBru,
                                   cdsIte.FieldByName('ITE_ICMSAI').AsFloat,
                                   cdsIte.FieldByName('ITE_IMPFED').AsFloat,
                                   cdsIte.FieldByName('ITE_DESOPE').AsFloat,
                                   Result[intTabela].fltComiss);

     If FblnRecalcMargem Then
        Result[intTabela].fltMarBru := fltPre
     Else
        Result[intTabela].fltPreVen := fltPre;
    End
  End;
end;

function TfrmImportMargemLucroTabPreco.fCriarCdsLocalizaItens: TZClient;
var strSql: string;
begin
  strSql := strSql + ' SELECT ' + fSqlBase;
  strSql := strSql + '   FROM ';
  strSql := strSql + ' ITEGER G ';
  strSql := strSql + '   LEFT JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE ';
  strSql := strSql + '   LEFT JOIN ITEBAR B ON B.BAR_CODITE = G.ITE_CODITE  AND B.BAR_CODEMP = G.ITE_CODEMP ';
  strSql := strSql + ' WHERE G.ITE_CODEMP = ' + VS_strCodEmp;
  Result := TZClient.Create(Self, strSql);
  Result.fAbreClient(True, 'TfrmImportTabPrecosIteger.fCriarCdsLocalizaItens');
end;

Function TfrmImportMargemLucroTabPreco.fGetDado(strColuna: String; intLinha: Integer; ftpTipo: TFieldType = ftString): Variant;
Begin
  If blnArqCsv Then
  Begin

    Result := objValidaExcel.fGetValueCSV(intLinha, strColuna);

  End Else
  Begin

    Result := Excel.Range[strColuna + IntToStr(intLinha)].Value;

  End;

  If blnArqCsv And (Result = '') And (ftpTipo in [ftFloat, ftInteger]) Then
    Result := null
  Else If (VarIsEmpty(result)) And  (ftpTipo in [ftFloat, ftInteger]) Then
    Result := null;
End;

function TfrmImportMargemLucroTabPreco.fLocalizaItenCDS(qryLocaliza: TZClient; intLinha: Integer; var blnLeuInfItemArquivo: Boolean): boolean;
  var
    strCodIte,
    strCodBar,
    strCodFor,
    strCodFab,
    strValor : String;
begin
  strValor := '';
  strCodIte :=Trim(fGetDado(cCodIte, intLinha));
  If not fEmptyStr(strCodIte) Then
    strValor := Format('%0.'+IntToStr(fTamCodIte)+'d', [StrToIntDef(strCodIte, 0)]);

  If fEmptyStr(strValor) Then
    Result := False
  Else
    Result := qryLocaliza.Locate('CODITE', strValor, []);

  If Not Result Then
  Begin
    strCodBar := Trim(fGetDado(cCodBar, intLinha));

    If Not fEmptyStr(strCodBar) Then
      Result := qryLocaliza.Locate('CODBAR', strCodBar, []);

  End;

  If Not Result Then
  Begin
    strCodFor := Trim(fGetDado(cCodFor, intLinha));
    strCodFab := Trim(fGetDado(cCodFab, intLinha));

    If (Not fEmptyStr(strCodFor)) And (Not fEmptyStr(strCodFab)) Then
      Result := qryLocaliza.Locate('CODFOR;CODFAB', VarArrayOf([strCodFor, strCodFab]), []);
  End;

  blnLeuInfItemArquivo := Not fEmptyStr(strCodIte + strCodBar + strCodFor + strCodFab);
end;

procedure TfrmImportMargemLucroTabPreco.FormCreate(Sender: TObject);
begin
  inherited;

  strMarMkp := fCfgSis('MARMKP');
  strPcmPro := fCfgSis('PCMPRO');

end;

procedure TfrmImportMargemLucroTabPreco.pCriarCds;
  var
    strSql: string;
begin
  strSql := '';
  strSql := strSql + 'SELECT ';
  strSql := strSql + fSqlBase;
  strSql := strSql + ', CAST("" AS CHAR(255)) AS DESEXC,';
  strSql := strSql + ' 0 AS IMPORT';
  strSql := strSql + ' FROM ITEGER G';
  strSql := strSql + ' LEFT JOIN ITEBAR B ON B.BAR_CODITE = G.ITE_CODITE AND B.BAR_CODEMP = G.ITE_CODEMP';
  strSql := strSql + '  LEFT JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE';
  strSql := strSql + '  WHERE FALSE';

  cdsItens := TZClient.Create(Self, strSql);

  cdsItens.fAbreClient(True,'[TfrmImportMargemLucroTabPreco.pCriarCds]');

  pFormatarCampo('COMTB1', True);
  pFormatarCampo('COMTB2', True);
  pFormatarCampo('COMTB3', True);
  pFormatarCampo('COMTB4', True);
  pFormatarCampo('COMTB5', True);
  pFormatarCampo('COMTB6', True);
  pFormatarCampo('COMTB7', True);
  pFormatarCampo('PREVE1', True);
  pFormatarCampo('PREVE2', True);
  pFormatarCampo('PREVE3', True);
  pFormatarCampo('PREVE4', True);
  pFormatarCampo('PREVE5', True);
  pFormatarCampo('PREVE6', True);
  pFormatarCampo('PREVE7', True);
  pFormatarCampo('MARBR1', True);
  pFormatarCampo('MARBR2', True);
  pFormatarCampo('MARBR3', True);
  pFormatarCampo('MARBR4', True);
  pFormatarCampo('MARBR5', True);
  pFormatarCampo('MARBR6', True);
  pFormatarCampo('MARBR7', True);

  cdsItens.LogChanges := False;

end;

procedure TfrmImportMargemLucroTabPreco.pFormatarCampo(strCampo: string; blnTem_ITE: boolean);
begin
  if not blnTem_ITE then
  Begin
    (cdsItens.FieldByName(strCampo) as TFloatField).DisplayFormat := '#,##0.00';
    (cdsItens.FieldByName('ITE_' + strCampo + '_NOV') as TFloatField).DisplayFormat := '#,##0.00';
  end
  Else
  Begin
    (cdsItens.FieldByName('ITE_' + strCampo) as TFloatField).DisplayFormat := '#,##0.00';
    (cdsItens.FieldByName('ITE_' + strCampo + '_NOV') as TFloatField).DisplayFormat := '#,##0.00';
  End
end;


procedure TfrmImportMargemLucroTabPreco.pInsereItensCDS(intLinha: integer);
  var
    recPrecos: TArrRecPrecos;
    i: integer;
    strCampo: string;
    TemItemArquivo: Boolean ;
begin
  try
    If fLocalizaItenCDS(qryLocalizaItem, intLinha, TemItemArquivo) Then
    Begin
      If Not TemItemArquivo Then
        Exit;
      cdsItens.Insert;

      for i := 0 to qryLocalizaItem.Fields.Count -1 do
        cdsItens.FieldByName(qryLocalizaItem.Fields[i].FieldName).Value := qryLocalizaItem.Fields[i].Value;
      { Para exitir o campo na função fIncluirPreIte }
      cdsItens.FieldByName('ITE_PRECUS_NOV').Value := qryLocalizaItem.FieldByName('ITE_PRECUS_NOV').Value;
      cdsItens.FieldByName('ITE_CODITE').Value     := qryLocalizaItem.FieldByName('ITE_CODITE').Value;
      cdsItens.FieldByName('ITE_MLTCOM_NOV').Value := qryLocalizaItem.FieldByName('ITE_MLTCOM_NOV').Value;

      cdsItens.FieldByName('ITE_DESMAX_NOV').Value := qryLocalizaItem.FieldByName('DESMAX').Value;
      cdsItens.FieldByName('ITE_DESMGE_NOV').Value := qryLocalizaItem.FieldByName('DESMGE').Value;
      cdsItens.FieldByName('ITE_DESMSU_NOV').Value := qryLocalizaItem.FieldByName('DESMSU').Value;
      cdsItens.FieldByName('ITE_MARMIN_NOV').Value := qryLocalizaItem.FieldByName('MARMIN').Value;
      cdsItens.FieldByName('IMPORT').AsInteger := 1;
    End
    Else
    Begin
      If Not TemItemArquivo Then
        Exit;
      cdsItens.Insert;
      cdsItens.FieldByName('IMPORT').AsInteger := 0;
      cdsItens.FieldByName('DESEXC').AsString := 'Produto não encontrado na Base de Dados.';
    End;

    strCampo := Iif(FblnRecalcMargem, 'ITE_PREVE', 'ITE_MARBR');

    cdsItens.FieldByName(strCampo + '1_NOV').Value := fGetDado(cMar__1, intLinha, ftFloat);
    cdsItens.FieldByName(strCampo + '2_NOV').Value := fGetDado(cMar__2, intLinha, ftFloat);
    cdsItens.FieldByName(strCampo + '3_NOV').Value := fGetDado(cMar__3, intLinha, ftFloat);
    cdsItens.FieldByName(strCampo + '4_NOV').Value := fGetDado(cMar__4, intLinha, ftFloat);
    cdsItens.FieldByName(strCampo + '5_NOV').Value := fGetDado(cMar__5, intLinha, ftFloat);
    cdsItens.FieldByName(strCampo + '6_NOV').Value := fGetDado(cMar__6, intLinha, ftFloat);
    cdsItens.FieldByName(strCampo + '7_NOV').Value := fGetDado(cMar__7, intLinha, ftFloat);
    for i := 1 to 7 do
    Begin
      pTratarCampoNulo_Venda_ou_Margem(i, strCampo);
    End;

    recPrecos := fCalcularPrecos(cdsItens);

    //Novos Valores Para Margem e Preco Venda
    for i := 1 to 7 do
    Begin
      If FblnRecalcMargem Then
        cdsItens.FieldByName('ITE_MARBR' + IntToStr(i) + '_NOV').AsFloat := recPrecos[i].fltMarBru
      Else
        cdsItens.FieldByName('ITE_PREVE' + IntToStr(i) + '_NOV').AsFloat := recPrecos[i].fltPreVen;

      If (Pos(strMarMkp, '1_5_') > 0) Then
      If Not fValidaMargem(i, cdsItens, recPrecos)  and (Not FblnRecalcMargem) Then
      Begin
        If cdsItens.FieldByName('DESEXC').AsString <> '' Then
           cdsItens.FieldByName('DESEXC').AsString := cdsItens.FieldByName('DESEXC').AsString + #$A#$D;
        cdsItens.FieldByName('DESEXC').AsString := cdsItens.FieldByName('DESEXC').AsString + 'TABELA DE PREÇOS' +
                                                   IntToStr(i) + ': A SOMA DO "ICMS DE SAÍDA" + "IMPOSTOS FEDERAIS" + "DESPESAS OPERACIONAIS" + "MARGEM BRUTA" ' +
                                                   IIF(strPcmPro = '2', '+ COMISSÃO ', '') + ' NÃO PODEM SER SUPERIOR A 100%.';
        cdsItens.FieldByName('IMPORT').AsInteger := 2;
      end;
    End;

    If cdsItens.FieldByName('IMPORT').AsInteger = 0 Then
    Begin
      cdsItens.FieldByName('CODITE').AsString := Trim(fGetDado(cCodIte, intLinha));
      cdsItens.FieldByName('CODFOR').AsString := Trim(fGetDado(cCodFor, intLinha));
      cdsItens.FieldByName('CODBAR').AsString := Trim(fGetDado(cCodBar, intLinha));
      cdsItens.FieldByName('CODFAB').AsString := Trim(fGetDado(cCodFab, intLinha));
    end;
    cdsItens.Post;
  Except
    on E: Exception do
       pMensagensErro(E.Message, '[TfrmImportMargemLucroTabPreco.pInsereItensCDS]');
  End;
end;

procedure TfrmImportMargemLucroTabPreco.pLimparCDS;
begin
  cdsItens.First;
  while not cdsItens.Eof do
  Begin
    cdsItens.Delete;
  End;
end;

procedure TfrmImportMargemLucroTabPreco.pTratarCampoNulo_Venda_ou_Margem(intTabela: integer; strCampo: string);
begin
  If cdsItens.FieldByName(strCampo + IntToStr(intTabela) + '_NOV').Value = null Then
    cdsItens.FieldByName(strCampo + IntToStr(intTabela) + '_NOV').Value :=
        cdsItens.FieldByName(strCampo + IntToStr(intTabela)).Value;
end;


procedure TfrmImportMargemLucroTabPreco.SetblnRecalcMargem(
  const Value: boolean);
begin
  FblnRecalcMargem := Value;
  If FblnRecalcMargem Then
  Begin
    lblAviso.Caption := 'A margem de lucro será recalculada';
    Self.Caption := 'Importação Preço de Venda por Tabela de Preço';
  End
  Else
  begin
    Self.Caption := 'Importação Margem de Lucro por Tabela de Preço';
    lblAviso.Caption := 'O preço de venda será recalculado';
  End;

end;

function TfrmImportMargemLucroTabPreco.fTemTitulo: boolean;
  var
    intValDef: Integer;
begin
  If Trim(fGetDado(cCodIte, 1)) <> '' Then
    result := not TryStrToInt(Trim(fGetDado(cCodIte, 1)), intValDef)
  Else
  Begin
    If objValidaExcel.fGetValueCSV(0, cCODITE) <> '' Then
      Result := not TryStrToInt(Trim(objValidaExcel.fGetValueCSV(0, cCODITE)), intValDef)
    Else
      Result := False;
  End;
end;

function TfrmImportMargemLucroTabPreco.fValidaMargem(intTabPreco: Integer; cdsIte: TZClient; objPrecos: TArrRecPrecos): Boolean;
begin
  Result := cdsIte.FieldByName('ITE_IMPFED').AsFloat +
            cdsIte.FieldByName('ITE_DESOPE').AsFloat +
            cdsIte.FieldByName('ITE_ICMSAI').AsFloat +
            cdsIte.FieldByName('ITE_COMTB' + intToStr(intTabPreco)+ '_NOV').AsFloat +
            objPrecos[intTabPreco].fltMarBru <= 100;
end;

function TfrmImportMargemLucroTabPreco.fSqlBase: String;
begin
  Result := '';
  Result := Result + (' G.ITE_CODITE AS CODITE ,');
  { Para exitir o campo na função fIncluirPreIte }
  Result := Result + (' G.ITE_PRECUS AS ITE_PRECUS ,');
  Result := Result + (' G.ITE_PRECUS AS ITE_PRECUS_NOV ,');
  Result := Result + (' G.ITE_CODITE AS ITE_CODITE ,');
  Result := Result + (' I.ITE_MLTCOM AS ITE_MLTCOM_NOV ,');
  Result := Result + (' G.ITE_DESMAX AS DESMAX, ');
  Result := Result + (' G.ITE_DESMGE AS DESMGE, ');
  Result := Result + (' G.ITE_DESMGE AS ITE_DESMGE_NOV, ');
  Result := Result + (' G.ITE_DESMSU AS DESMSU, ');
  Result := Result + (' G.ITE_DESMSU AS ITE_DESMSU_NOV, ');
  Result := Result + (' G.ITE_DESMAX AS ITE_DESMAX_NOV,');
  Result := Result + (' G.ITE_MARMIN AS ITE_MARMIN_NOV,');
  Result := Result + (' G.ITE_MARMIN AS MARMIN,');
  {}

  Result := Result + (' B.BAR_CODBAR AS CODBAR ,');
  Result := Result + (' I.ITE_CODFOR AS CODFOR ,');
  Result := Result + (' I.ITE_CODFAB AS CODFAB ,');
  Result := Result + (' I.ITE_DESITE AS DESITE ,');

  Result := Result + (' G.ITE_DESF01 AS ITE_DESF01 ,');
  Result := Result + (' G.ITE_DESF02 AS ITE_DESF02 ,');
  Result := Result + (' G.ITE_DESF03 AS ITE_DESF03 ,');
  Result := Result + (' G.ITE_DESF04 AS ITE_DESF04 ,');
  Result := Result + (' G.ITE_DESF05 AS ITE_DESF05 ,');
  Result := Result + (' G.ITE_DESF06 AS ITE_DESF06 ,');
  Result := Result + (' G.ITE_ICMENT AS ITE_ICMENT ,');
  Result := Result + (' G.ITE_SUBFED AS ITE_SUBFED ,');
  Result := Result + (' G.ITE_IPIENT AS ITE_IPIENT ,');
  Result := Result + (' G.ITE_FREENT AS ITE_FREENT ,');
  Result := Result + (' G.ITE_VALFRE AS ITE_VALFRE ,');
  Result := Result + (' G.ITE_ACRFIN AS ITE_ACRFIN ,');
  Result := Result + (' G.ITE_SUBSTI AS ITE_SUBSTI ,');
  Result := Result + (' G.ITE_DESADB AS ITE_DESADB ,');
  Result := Result + (' G.ITE_PREDOL AS ITE_PREDOL ,');
  Result := Result + (' G.ITE_ICMSAI AS ITE_ICMSAI ,');
  Result := Result + (' G.ITE_IMPFED AS ITE_IMPFED ,');
  Result := Result + (' G.ITE_OUTVAL AS ITE_OUTVAL ,');
  Result := Result + (' G.ITE_DESOPE AS ITE_DESOPE ,');
  Result := Result + (' G.ITE_COMTB1 AS ITE_COMTB1 ,');
  Result := Result + (' G.ITE_COMTB2 AS ITE_COMTB2 ,');
  Result := Result + (' G.ITE_COMTB3 AS ITE_COMTB3 ,');
  Result := Result + (' G.ITE_COMTB4 AS ITE_COMTB4 ,');
  Result := Result + (' G.ITE_COMTB5 AS ITE_COMTB5 ,');
  Result := Result + (' G.ITE_COMTB6 AS ITE_COMTB6 ,');
  Result := Result + (' G.ITE_COMTB7 AS ITE_COMTB7 ,');

  Result := Result + (' G.ITE_PREVE1 AS ITE_PREVE1 ,');
  Result := Result + (' G.ITE_PREVE2 AS ITE_PREVE2 ,');
  Result := Result + (' G.ITE_PREVE3 AS ITE_PREVE3 ,');
  Result := Result + (' G.ITE_PREVE4 AS ITE_PREVE4 ,');
  Result := Result + (' G.ITE_PREVE5 AS ITE_PREVE5 ,');
  Result := Result + (' G.ITE_PREVE6 AS ITE_PREVE6 ,');
  Result := Result + (' G.ITE_PREVE7 AS ITE_PREVE7 ,');

  Result := Result + (' G.ITE_MARBR1 AS ITE_MARBR1 ,');
  Result := Result + (' G.ITE_MARBR2 AS ITE_MARBR2 ,');
  Result := Result + (' G.ITE_MARBR3 AS ITE_MARBR3 ,');
  Result := Result + (' G.ITE_MARBR4 AS ITE_MARBR4 ,');
  Result := Result + (' G.ITE_MARBR5 AS ITE_MARBR5 ,');
  Result := Result + (' G.ITE_MARBR6 AS ITE_MARBR6 ,');
  Result := Result + (' G.ITE_MARBR7 AS ITE_MARBR7 ,');
  Result := Result + (' G.ITE_PRECOM AS ITE_PRECOM, ');
  Result := Result + (' G.ITE_DESF01 AS ITE_DESF01_NOV,');
  Result := Result + (' G.ITE_DESF02 AS ITE_DESF02_NOV,');
  Result := Result + (' G.ITE_DESF03 AS ITE_DESF03_NOV,');
  Result := Result + (' G.ITE_DESF04 AS ITE_DESF04_NOV,');
  Result := Result + (' G.ITE_DESF05 AS ITE_DESF05_NOV,');
  Result := Result + (' G.ITE_DESF06 AS ITE_DESF06_NOV,');
  Result := Result + (' G.ITE_ICMENT AS ITE_ICMENT_NOV,');
  Result := Result + (' G.ITE_SUBFED AS ITE_SUBFED_NOV,');
  Result := Result + (' G.ITE_IPIENT AS ITE_IPIENT_NOV,');
  Result := Result + (' G.ITE_FREENT AS ITE_FREENT_NOV,');
  Result := Result + (' G.ITE_VALFRE AS ITE_VALFRE_NOV,');
  Result := Result + (' G.ITE_ACRFIN AS ITE_ACRFIN_NOV,');
  Result := Result + (' G.ITE_SUBSTI AS ITE_SUBSTI_NOV,');
  Result := Result + (' G.ITE_DESADB AS ITE_DESADB_NOV,');
  Result := Result + (' G.ITE_ICMSAI AS ITE_ICMSAI_NOV,');
  Result := Result + (' G.ITE_IMPFED AS ITE_IMPFED_NOV,');
  Result := Result + (' G.ITE_OUTVAL AS ITE_OUTVAL_NOV,');
  Result := Result + (' G.ITE_DESOPE AS ITE_DESOPE_NOV,');
  Result := Result + (' G.ITE_PRECOM AS ITE_PRECOM_NOV,');

  Result := Result + (' G.ITE_COMTB1 AS ITE_COMTB1_NOV,');
  Result := Result + (' G.ITE_COMTB2 AS ITE_COMTB2_NOV,');
  Result := Result + (' G.ITE_COMTB3 AS ITE_COMTB3_NOV,');
  Result := Result + (' G.ITE_COMTB4 AS ITE_COMTB4_NOV,');
  Result := Result + (' G.ITE_COMTB5 AS ITE_COMTB5_NOV,');
  Result := Result + (' G.ITE_COMTB6 AS ITE_COMTB6_NOV,');
  Result := Result + (' G.ITE_COMTB7 AS ITE_COMTB7_NOV,');

  Result := Result + (' G.ITE_PREVE1 AS ITE_PREVE1_NOV,');
  Result := Result + (' G.ITE_PREVE2 AS ITE_PREVE2_NOV,');
  Result := Result + (' G.ITE_PREVE3 AS ITE_PREVE3_NOV,');
  Result := Result + (' G.ITE_PREVE4 AS ITE_PREVE4_NOV,');
  Result := Result + (' G.ITE_PREVE5 AS ITE_PREVE5_NOV,');
  Result := Result + (' G.ITE_PREVE6 AS ITE_PREVE6_NOV,');
  Result := Result + (' G.ITE_PREVE7 AS ITE_PREVE7_NOV,');

  Result := Result + (' G.ITE_MARBR1 AS ITE_MARBR1_NOV,');
  Result := Result + (' G.ITE_MARBR2 AS ITE_MARBR2_NOV,');
  Result := Result + (' G.ITE_MARBR3 AS ITE_MARBR3_NOV,');
  Result := Result + (' G.ITE_MARBR4 AS ITE_MARBR4_NOV,');
  Result := Result + (' G.ITE_MARBR5 AS ITE_MARBR5_NOV,');
  Result := Result + (' G.ITE_MARBR6 AS ITE_MARBR6_NOV,');
  Result := Result + (' G.ITE_MARBR7 AS ITE_MARBR7_NOV');

end;



end.

