unit untCtaRelDupDDA;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiRelatorio,
  frxExportCSVTestabilidade, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF,
  Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, EditFocus, QColorLabel,
  Vcl.ExtCtrls, Vcl.Buttons, BitBtnLockedIncrem, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxCheckListBox, untFuncoesSimples, Uni, untConstantes,
  DB, UniClientDataSet, UniDataSetProvider, StrUtils, untCfgRel, untFuncoes, untFuncoesBoleto, untFuncAutban,
  cxCustomListBox, RLFilters, RLDraftFilter, System.DateUtils, Vcl.ComCtrls,
  dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar;

type
  TfrmCtaRelDupDDA = class(TfrmPaiRelatorio)
    pnlTopo: TPanel;
    Label1: TLabel;
    lstCodOco: TcxCheckListBox;
    gpbOrdem: TGroupBox;
    ColorLabel2: TColorLabel;
    edtOrdem: TEditFocus;
    frxRelatorioJ: TfrxReport;
    GroupBox1: TGroupBox;
    ColorLabel3: TColorLabel;
    edtApenasPendentes: TEditFocus;
    grpDataArquivos: TGroupBox;
    edtDataInicial: TcxDateEdit;
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
  private
    FstrConfig: String;

    qryCodOco: TUniQuery;
    qryRelato: TUniQuery;

    cdsRelato: TUniClientDataset;

    strAnoIni,
    strAnoFim: String;

    FDataInicial: TDateTime;

    procedure pFiltraOcorrencias();
    procedure pGeraRelatorio();

    procedure pCriaClientRelat;
    procedure pIncluiRegistrosRel(qryClone: TUniClientDataset; intTipo: Integer);

    function RetornaDatasetCadPagComCodigoBarras(ADataset: TUniCLientDataset): TUniClientDataset;
    function BuscaCodigoBarrasLinhaDigitavel(ADatasetDDA: TDataset;
                                             var ADatasetCadPag: TUniCLientDataset): Boolean;

    function fRetNomOcoDDA(strCodOco: String): String;
    { Private declarations }
  public
    property strConfig: String read FstrConfig write FstrConfig;
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmCtaRelDupDDA: TfrmCtaRelDupDDA;

implementation
Uses untGravando;

{$R *.dfm}

{ TfrmCtaRelDupDDA }

procedure TfrmCtaRelDupDDA.btnImprimirClick(Sender: TObject);
begin
  If Not fVerificaCampos Then
    Exit;

  If edtDataInicial.Date = 0 Then
  Begin
    fMensagem('ATENÇÃO', 'A Data dos arquivos deve ser preenchida.', ['&Ok']);
    Exit;
  End;

  If edtDataInicial.Date <> FDataInicial Then
  Begin
    FDataInicial := edtDataInicial.Date;
    TfrmGravando.fExecutarModal(pFiltraOcorrencias, 'Aguarde... Reprocessando a data inicial.', '');
  End;

  pnlBotoes.Enabled := False;
  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarModal(pGeraRelatorio, 'Aguarde... Gerando relatório.', '');
  pFreeAndNil(frmGravando);
  pnlBotoes.Enabled := True;
end;

function TfrmCtaRelDupDDA.BuscaCodigoBarrasLinhaDigitavel(ADatasetDDA: TDataset;
  var ADatasetCadPag: TUniClientDataset): Boolean;
begin
  Result := ADatasetCadPag.Locate('CTP_LINDIG', ADatasetDDA.FieldByName('DDA_LINDIG').AsString, []);

  If Not Result Then
    Result := ADatasetCadPag.Locate('CTP_CODBAR', ADatasetDDA.FieldByName('DDA_CODBAR').AsString, []);
end;

procedure TfrmCtaRelDupDDA.FormShow(Sender: TObject);
begin
  inherited;
  If TFuncoesDDA.DataInicialDDA = 0 Then
    TFuncoesDDA.DataInicialDDA := IncMonth(VS_Date, -3);

  FDataInicial := TFuncoesDDA.DataInicialDDA;
  edtDataInicial.Date := FDataInicial;
  pFiltraOcorrencias;
end;

function TfrmCtaRelDupDDA.fRetNomOcoDDA(strCodOco: String): String;
Var intCont: Integer;
begin
  Result := '';

  For intCont := Low(NOME_OCORRENCIA_DDA) to High(NOME_OCORRENCIA_DDA) do
  Begin
    If NOME_OCORRENCIA_DDA[intCont][0] = strCodOco Then
    Begin
      Result := NOME_OCORRENCIA_DDA[intCont][1];
      Break;
    End;
  End;
end;

function TfrmCtaRelDupDDA.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If Sender = edtOrdem Then
    Begin

      If (edtOrdem.Text <> 'V') And (edtOrdem.Text <> 'D') Then
      Begin
        fMensagem('','A ordenação das duplicatas deve ser V ou D!',['&O K']);
        Result := False;
      End;

    End
    Else If Sender = edtDestino Then
    Begin

      If (edtDestino.Text <> 'V') And (edtDestino.Text <> 'I') Then
      Begin
        fMensagem('','O destino da impressão deve ser V ou I!',['&O K']);
        Result := False;
      End;

    End
    Else If Sender = edtApenasPendentes Then
    Begin

      If (edtApenasPendentes.Text <> 'S') And
         (edtApenasPendentes.Text <> 'N') Then
      Begin
        fMensagem('','O campo Apenas registros pendentes deve ser (S)im ou (N)ão!',['&O K']);
        Result := False;
      End;

    End;

  End;
end;

procedure TfrmCtaRelDupDDA.pFiltraOcorrencias;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT DDA_CODMOV, MIN(DDA_DTAVEN) AS DTAINI, MAX(DDA_DTAVEN) AS DTAFIM ';
  strSQL := strSQL + ' FROM RETDDA ';
  strSQL := strSQL + ' WHERE DDA_CODBCO=:CODBCO ';
  strSQL := strSQL + '   AND DDA_DTAARQ>=:DTAARQ ';
  strSQL := strSQL + ' GROUP BY DDA_CODMOV ';
  strSQL := strSQL + ' ORDER BY DDA_CODMOV ';

  qryCodOco := fCriaQuery(Nil);

  qryCodOco.SQL.Text := strSQL;

  qryCodOco.ParamByName('CODBCO').AsString := Copy(FstrConfig, 10, 3);
  qryCodOco.ParamByName('DTAARQ').AsDateTime := FDataInicial;
  qryCodOco.Open;

  strAnoIni := FormatDateTime('yyyy', VS_Date);
  strAnoFim := FormatDateTime('yyyy', VS_Date);

  If qryCodOco.IsEmpty Then
  Begin
    pMensagemOK('Não foram encontrados registros importados para a geração do relatório.');
    Close;
    btnImprimir.Enabled := False;
  End
  Else
  Begin
    qryCodOco.First;
    strAnoIni := FormatDateTime('yyyy', qryCodOco.FieldByName('DTAINI').Value);
    strAnoFim := FormatDateTime('yyyy', qryCodOco.FieldByName('DTAFIM').Value);

    lstCodOco.Clear;
    While Not qryCodOco.Eof do
    Begin
      lstCodOco.Items.Add;
      lstCodOco.Items[lstCodOco.Items.Count-1].Text := qryCodOco.FieldByName('DDA_CODMOV').AsString + ' - ' + fRetNomOcoDDA(qryCodOco.FieldByName('DDA_CODMOV').AsString);
      lstCodOco.Items[lstCodOco.Items.Count-1].Checked := True;

      qryCodOco.Next;
    End;
  End;
end;

procedure TfrmCtaRelDupDDA.pGeraRelatorio;
Var strSQL     : String;
    lstOcorre  : TStringList;
    intCont    : Integer;
    strNomImp  : String;
    intContador: Integer;
    blnSemReg  : Boolean;
begin
  inherited;

  Try
    btnImprimir.Enabled := False;
    blnImprime := fVerificaCampos;

    If blnImprime Then
    begin
      pCarregaConfImpr(qryCfgRel, Self.Name);
      blnImprime := fPreImpressao(qryCfgRel, strNomImp, strTipImp, False, edtDestino.Text);
    End;

    {**************************************}
    {* VERIFICA SE EXISTE UM FRX... PARA  *}
    {* MODIFICACOES PADROES               *}
    {***********************************AF*}
    If blnImprime Then
    Begin

      For intContador := 0 To Self.ComponentCount -1 Do
      Begin

        If Self.Components[intContador] Is TfrxReport Then
        Begin
          (Self.Components[intContador] As TfrxReport).PrintOptions.Printer   := AnsiReplaceStr(strNomImp,'\\' + fRetNomeRede + '\','');
          (Self.Components[intContador] As TfrxReport).PreviewOptions.Buttons := [pbPrint,pbLoad,pbSave,pbExport,pbZoom,pbFind,pbOutline,pbPageSetup,pbTools,pbNavigator];
        End;

      End;

    End;

  Finally
    btnImprimir.Enabled := True;
  End;

  lstOcorre := TStringList.Create;
  For intCont := 0 to lstCodOco.Items.Count - 1 do
  Begin
    If lstCodOco.Items[intCont].Checked Then
      lstOcorre.Add(Copy(lstCodOco.Items[intCont].Text, 1, 2));
  End;
  If lstOcorre.Count = 0 Then
  Begin
    pMensagemOK('É necessário selecionar alguma ocorrência para gerar o relatório.');
    Exit;
  End;

  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarAcao := TFuncoesDDA.fAtualizaFornDDA;
  frmGravando.lblGravando.Caption := 'Aguarde... Atualizando Fornecedores.';
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);

  TFuncoesDDA.DataInicialDDA := FDataInicial;

  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarAcao := TFuncoesDDA.fUpdAutoIncremCTPDDA;
  frmGravando.lblGravando.Caption := 'Aguarde... Atualizando Sequencial.';
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);


  strSQL := '';
  strSQL := strSQL + 'SELECT D.*, F.FOR_NOMFOR, F.FOR_C_G_C_, P.CTP_NUMDUP, P.CTP_DTACAD, COALESCE(RIGHT(P.CTP_NUMDUP, LENGTH(D.DDA_NUMDUP)), "") AS NUMDUP, ';
  strSQL := strSQL + '  P.CTP_DTAVEN, P.CTP_VALDUP, P.CTP_CODFOR, P.CTP_CODEMP, P.AUTOINCREM, P.CTP_VALORI, "CADPAG" AS TABELA ';
  strSQL := strSQL + '  FROM RETDDA D ';
  strSQL := strSQL + '  LEFT JOIN (SELECT * FROM CADPAG WHERE CTP_DTAVEN BETWEEN "' + strAnoIni + '-01-01" AND "' + strAnoFim + '-12-31") P '; //Feito uma subquery e utilizar o indice para melhorar o desempenho
  strSQL := strSQL + '  ON (P.AUTOINCREM=D.DDA_AUTCTP) ';
  strSQL := strSQL + '  LEFT JOIN CADFOR F ON F.FOR_CODFOR = P.CTP_CODFOR ';
  strSQL := strSQL + '  WHERE D.DDA_CODBCO=' + QuotedStr(Copy(FstrConfig, 10, 3));
  strSQL := strSQL + '    AND D.DDA_DTAARQ>="' + FormatDateTime('yyyy-mm-dd', FDataInicial) + '" ';
  strSQL := strSQL + '    AND D.DDA_CODMOV IN (';

  //Adicionando ocorrências selecionadas
  For intCont := 0 to lstOcorre.Count - 1 do
    strSQL := strSQL + QuotedStr(lstOcorre[intCont]) + ',';
  strSQL := Copy(strSQL, 1, Length(strSQL) - 1) + ') ';

  If Trim(edtApenasPendentes.Text).Equals('S') Then
    strSQL := strSQL +  ' AND  D.DDA_DTABAI IS NULL ';

  strSQL := strSQL + ' AND COALESCE(P.CTP_NUMDUP, "") <> "" GROUP BY D.DDA_CODBAR';

  If edtOrdem.text = 'D' Then
    strSQL := strSQL + ' ORDER BY DDA_CODMOV, CTP_NUMDUP, DDA_CODEMP, DDA_DTAVEN, TABELA'
  Else
    strSQL := strSQL + ' ORDER BY DDA_CODMOV, DDA_DTAVEN, DDA_NUMDUP, DDA_CODEMP, TABELA';

  qryRelato := fCriaQuery(Nil);

  Try
    If Not Assigned(cdsRelato) Then
      pCriaClientRelat;
    cdsRelato.EmptyDataSet;

    qryRelato.Close;
    qryRelato.SQL.Text := strSQL;
    qryRelato.Open;
    
    blnSemReg := qryRelato.IsEmpty;
    If Not blnSemReg Then
      pIncluiRegistrosRel(fCriaClientDatSet(qryRelato), 1);

    qryRelato.Close;

    //Duplicatas Não encontradas
    strSQL := 'SELECT R.*, FN.*, R.DDA_DUPCOR AS CTP_NUMDUP, R.DDA_CODFOR AS CTP_CODFOR, R.DDA_CODEMP AS CTP_CODEMP ' +
              'FROM RETDDA R ' +
              'LEFT JOIN CADFOR FN ON FN.FOR_CODFOR = R.DDA_CODFOR ' +
              'WHERE R.DDA_CODBCO=' + QuotedStr(Copy(FstrConfig, 10, 3)) +
              '  AND (R.DDA_AUTCTP IS NULL OR R.DDA_AUTCTP = "") ' +
              '  AND (R.DDA_DTAARQ>="' + FormatDateTime('yyyy-mm-dd', FDataInicial) + '") ' +
              '  AND (SELECT COUNT(TEMP.DDA_NUMDUP) ' +
              '       FROM (' + strSQL + ') TEMP ' +
              '       WHERE TEMP.DDA_NUMDUP=R.DDA_NUMDUP ' +
              '         AND TEMP.DDA_CODEMP=R.DDA_CODEMP ' +
              '         AND TEMP.DDA_VALTIT=R.DDA_VALTIT ' +
              '         AND TEMP.DDA_DTAVEN=R.DDA_DTAVEN ' +
              '         AND TEMP.DDA_CODFOR=R.DDA_CODFOR) = 0 ';

    If Trim(edtApenasPendentes.Text).Equals('S') Then
      strSQL := strSQL +  ' AND  R.DDA_DTABAI IS NULL ';

    If edtOrdem.text = 'D' Then
      strSQL := strSQL + ' ORDER BY R.DDA_CODMOV, R.DDA_NUMDUP, R.DDA_CODEMP, R.DDA_DTAVEN'
    Else
      strSQL := strSQL + ' ORDER BY R.DDA_CODMOV, R.DDA_DTAVEN, R.DDA_NUMDUP, R.DDA_CODEMP';

    qryRelato.Close;
    qryRelato.SQL.Text := strSQL;
    qryRelato.Open;
    
    blnSemReg := (blnSemReg) And (qryRelato.IsEmpty);
    If blnSemReg Then
      pMensagemOK('Não existem registros para gerar o relatório!')
    Else
    Begin
      If Not qryRelato.IsEmpty Then
        pIncluiRegistrosRel(fCriaClientDatSet(qryRelato), 0);
    End;

    If Not blnSemReg Then
    Begin

      frxRelatorioJ.Script.Variables['NOMEMP'] := fRetNomeEmpresa;
      frxRelatorioJ.Script.Variables['NOMREL'] := 'RELATÓRIO DE ARQ. DE RETORNO DDA';

      If Not fEmptyStr(fCfgSis('CORZEB')) Then
        TfrxMemoView(frxRelatorioJ.FindObject('rllZebra')).Highlight.Color := fCfgSis('CORZEB')
      Else
        TfrxMemoView(frxRelatorioJ.FindObject('rllZebra')).Highlight.Color := clWhite;

      If edtOrdem.text = 'D' Then
        cdsRelato.IndexFieldnames := 'DESCRI;CODOCO;NUMDUP;CODEMP;DTAVEN'
      Else
        cdsRelato.IndexFieldnames := 'DESCRI;CODOCO;DTAVEN;NUMDUP;CODEMP';

      frxRelatorio.DataSet := cdsRelato;

      If edtDestino.Text = 'V' Then
        pPreviewReport(Self.Name, Self.Caption, frxRelatorioJ)
      Else
      Begin
        If frxRelatorioJ.PrepareReport Then
        Begin
          frxRelatorioJ.PrintOptions.ShowDialog := (strNomImp = '');
          pPrintReport(Self.Name, Self.Caption, strNomImp, frxRelatorioJ);
        End;
      End;
    End;
  Finally
    qryRelato.Close;
  End;

end;

procedure TfrmCtaRelDupDDA.pIncluiRegistrosRel(qryClone: TUniClientDataset; intTipo: Integer);
Var
  strNumDup  : String;

  LDatasetCadPag: TUniClientDataSet;

  LPossuiCodigBarras: Boolean;
begin
  LDatasetCadPag := RetornaDatasetCadPagComCodigoBarras(qryClone);

  qryClone.First;
  While Not qryClone.Eof do
  Begin
    Application.ProcessMessages;

    cdsRelato.Append;
    cdsRelato.FieldByName('DUPCOR').AsString := IIF(qryClone.FieldByName('CTP_NUMDUP').AsString <> '',
                                                    qryClone.FieldByName('CTP_NUMDUP').AsString,
                                                    qryClone.FieldByName('DDA_DUPCOR').AsString);
    cdsRelato.FieldByName('NUMDUP').AsString := qryClone.FieldByName('DDA_NUMDUP').AsString;

    {***********************************************}
    {* VERIFICA SE O NUMDUP É VALIDO PARA O AUTCOM *}
    {********************************************AJ*}
    strNumDup := fRetSomenteNumeros(qryClone.FieldByName('DDA_NUMDUP').AsString);

    LPossuiCodigBarras := BuscaCodigoBarrasLinhaDigitavel(qryClone, LDatasetCadPag);

    If LPossuiCodigBarras Then
      cdsRelato.FieldByName('DESCRI').AsString := 'CÓDIGO DE BARRAS/LINHA DIGITÁVEL JÁ CADASTRADOS'
    Else
    Begin
      If intTipo = 1 Then
      Begin
        If (Not fEmptyStr(qryClone.FieldByName('DDA_AUTCTP').AsString)) Then
        Begin
          If (qryClone.FieldByName('DDA_DTAVEN').AsString <> qryClone.FieldByName('CTP_DTAVEN').AsString) Then
            cdsRelato.FieldByName('DESCRI').AsString := 'DOCUMENTOS ENCONTRADOS NO SISTEMA COM DIVERGÊNCIA NA DATA DE VENCIMENTO'
          Else If (qryClone.FieldByName('DDA_VALTIT').AsString = qryClone.FieldByName('CTP_VALDUP').AsString) Then
            cdsRelato.FieldByName('DESCRI').AsString := 'DOCUMENTOS ENCONTRADOS NO SISTEMA'
          Else If (Copy(FstrConfig, 10, 3) = '001') Then
          Begin
            If (qryClone.FieldByName('CTP_VALDUP').AsFloat = 0) Then
              cdsRelato.FieldByName('DESCRI').AsString := 'DOCUMENTOS ENCONTRADOS NO SISTEMA BAIXADOS'
            Else
              cdsRelato.FieldByName('DESCRI').AsString := 'DOCUMENTOS ENCONTRADOS NO SISTEMA COM DIVERGÊNCIA DE VALOR';
          End
          Else
            cdsRelato.FieldByName('DESCRI').AsString := 'DOCUMENTOS ENCONTRADOS NO SISTEMA BAIXADOS OU COM DIVERGÊNCIA DE VALOR';
        End
        Else
          cdsRelato.FieldByName('DESCRI').AsString := 'DOCUMENTOS ENCONTRADOS COM DIVERGÊNCIA NO NÚMERO OU FORNECEDOR';
      End
      Else
      Begin
        If (fEmptyStr(strNumDup)) Or (StrToInt64(strNumDup) = 0) Then
          cdsRelato.FieldByName('DESCRI').AsString := 'DOCUMENTOS QUE NÃO SERÃO IMPORTADOS'
        Else
          cdsRelato.FieldByName('DESCRI').AsString := 'DOCUMENTOS NÃO ENCONTRADOS';
      End;
    End;

    cdsRelato.FieldByName('CODOCO').AsString := qryClone.FieldByName('DDA_CODMOV').AsString;
    cdsRelato.FieldByName('NOMOCO').AsString := fRetNomOcoDDA(qryClone.FieldByName('DDA_CODMOV').AsString);
    cdsRelato.FieldByName('CODEMP').AsString := qryClone.FieldByName('CTP_CODEMP').AsString;
    cdsRelato.FieldByName('CODFOR').AsString := IIF(fEmptyStr(qryClone.FieldByName('CTP_CODFOR').AsString),
                                                    qryClone.FieldByName('DDA_CODFOR').AsString,
                                                    qryClone.FieldByName('CTP_CODFOR').AsString);

    If Not fEmptyStr(qryClone.FieldByName('FOR_NOMFOR').AsString) Then
      cdsRelato.FieldByName('NOMFOR').AsString := qryClone.FieldByName('FOR_NOMFOR').AsString
    Else
      cdsRelato.FieldByName('NOMFOR').AsString := qryClone.FieldByName('DDA_NOMCED').AsString;

    cdsRelato.FieldByName('DTAEMI').AsString := qryClone.FieldByName('DDA_DTAEMI').AsString;
    cdsRelato.FieldByName('DTAVEN').AsString := qryClone.FieldByName('DDA_DTAVEN').AsString;
    cdsRelato.FieldByName('VALDUP').Value    := qryClone.FieldByName('DDA_VALTIT').Value;
    if not qryClone.FieldByName('FOR_C_G_C_').IsNull then
      cdsRelato.FieldByName('CNPJ__').AsString := qryClone.FieldByName('FOR_C_G_C_').AsString
    else
      cdsRelato.FieldByName('CNPJ__').AsString := qryClone.FieldByName('DDA_CNPJ__').AsString;
    If LPossuiCodigBarras Then
      cdsRelato.FieldByName('DUPCAD').AsString := 'Duplicata: ' + LDatasetCadPag.FieldByName('CTP_NUMDUP').AsString + '-' +
                                                                  LDatasetCadPag.FieldByName('CTP_PARCEL').AsString + '-' +
                                                                  LDatasetCadPag.FieldByName('CTP_CODEMP').AsString;
    cdsRelato.Post;

    qryClone.Next;
  End;
end;

function TfrmCtaRelDupDDA.RetornaDatasetCadPagComCodigoBarras(
  ADataset: TUniCLientDataset): TUniClientDataset;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;

  Try
    ADataset.IndexFieldNames := 'DDA_DTAVEN';
    ADataset.First;

    LConsulta.SQL.Text := 'SELECT CTP_NUMDUP, ' +
                          '       CTP_SERIE_, ' +
                          '       CTP_PARCEL, ' +
                          '       CTP_CODFOR, ' +
                          '       CTP_DTACAD, ' +
                          '       CTP_DTAVEN, ' +
                          '       CTP_CODEMP, ' +
                          '       CTP_LINDIG, ' +
                          '       CTP_CODBAR  ' +
                          'FROM CADPAG ' +
                          'WHERE CTP_DTAVEN BETWEEN :DTAINI AND :DTAFIN ' +
                          '  AND ((CTP_CODBAR IS NOT NULL AND CTP_CODBAR<>"") OR ' +
                          '       (CTP_LINDIG IS NOT NULL AND CTP_LINDIG<>"")) ';

    LConsulta.ParamByName('DTAINI').AsDateTime := IncDay(ADataset.FieldByName('DDA_DTAVEN').AsDateTime, -10);
    ADataset.Last;
    LConsulta.ParamByName('DTAFIN').AsDateTime := IncDay(ADataset.FieldByName('DDA_DTAVEN').AsDateTime, 10);

    LConsulta.Open;

    Result := fCriaCLientDatSet(LConsulta);
    Result.Open;
  Finally
    ADataset.IndexFieldNames := EmptyStr;
    ADataset.First;

    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

procedure TfrmCtaRelDupDDA.pCriaClientRelat;
begin
  {******************************}
  {* CLIENTDATASET - RELATÓRIO  *}
  {***************************AJ*}
  cdsRelato := TUniClientDataSet.Create(Self);
  cdsRelato.DisableControls;
  cdsRelato.FetchOnDemand := False;

  With cdsRelato.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NUMDUP';
    DataType := ftString;
    Size := 25;
  End;

  With cdsRelato.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DUPCOR';
    DataType := ftString;
    Size := 25;
  End;

  With cdsRelato.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DESCRI';
    DataType := ftString;
    Size := 100;
  End;

  With cdsRelato.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODOCO';
    DataType := ftString;
    Size := 2;
  End;

  With cdsRelato.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NOMOCO';
    DataType := ftString;
    Size := 80;
  End;

  With cdsRelato.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODEMP';
    DataType := ftString;
    Size := 3;
  End;

  With cdsRelato.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODFOR';
    DataType := ftString;
    Size := 8;
  End;

  With cdsRelato.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NOMFOR';
    DataType := ftString;
    Size := 100;
  End;

  With cdsRelato.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DTAEMI';
    DataType := ftDateTime;
  End;

  With cdsRelato.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DTAVEN';
    DataType := ftDateTime;
  End;

  With cdsRelato.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VALDUP';
    DataType := ftBCD;
    Size := 15;
  End;

  With cdsRelato.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CNPJ__';
    DataType := ftString;
    Size := 15;
  End;

  With cdsRelato.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DUPCAD';
    DataType := ftString;
    Size := 60;
  End;

  cdsRelato.CreateDataSet;
  cdsRelato.Open;
end;

end.
