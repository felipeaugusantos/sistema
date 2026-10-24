unit untRelEstComparativoPrecosFornec;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF,  untModuloSPR,
  RLFilters, RLDraftFilter, AppEvnts, Menus, StdCtrls, EditFocus, QColorLabel,
  ExtCtrls, BitBtnLockedIncrem, Buttons, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxCheckBox, Uni, untIZClient, untFuncoesRelatorios,
  UniClientDataSet,  cxLookAndFeels, untExcel, untGeraExcel, untZClient, untTSQLTrace,
  cxLookAndFeelPainters, cxNavigator, frxExportCSVTestabilidade, untFuncoesSimples,
  untIFuncoes, StrUtils, TypesRel,  untModulo, untParCalculaPrecoCusto,untFuncoesRel2,
  cxDataControllerConditionalFormattingRulesManagerDialog, untTConfiguracao;

type
  TfrmRelEstComparativoPrecosFornec = class(TfrmPaiRelatorio)
    cxgTabPreView: TcxGridDBTableView;
    cxgTabPreLevel1: TcxGridLevel;
    cxgTabPre: TcxGrid;
    cxgTabPreViewColumn1: TcxGridDBColumn;
    cxgTabPreViewColumn2: TcxGridDBColumn;
    cxgTabPreViewColumn3: TcxGridDBColumn;
    cxgTabPreViewColumn4: TcxGridDBColumn;
    cxgTabPreViewColumn5: TcxGridDBColumn;
    dtsTabPre: TDataSource;
    TabPreBASCOM: TcxGridDBColumn;
    TabPreCOMPAR: TcxGridDBColumn;
    frxReportM: TfrxReport;
    frxReportJ: TfrxReport;
    frxDBItens: TfrxDBDataset;
    btnSeleciona: TBitBtnLocked;
    btnBasCom: TBitBtnLocked;
    frxReportJp: TfrxReport;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxgTabPreViewBASCOMPropertiesChange(Sender: TObject);
    procedure btnBasComClick(Sender: TObject);
    procedure btnSelecionaClick(Sender: TObject);
    procedure TabPreCOMPARPropertiesChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    cdsTabPre,
    cdsTabIte: IZClient;
    intQtdTab: Integer;
    strTabPre: String;

    stlTabPre: TStringList;

    cdsRelato: TUniClientDataSet;

    variRecVar: TRecVariaveis;
    modiRecMod: TRecModulos;

    Function fAbreItens: Boolean;
    Function fSQLTabPre: String;
    Function fCarregaTabPre: Boolean;
    Function fSQLRelatorio: String;
    Function fRetSelecaoTabPre: String;
    Function fMarcaComparar: Boolean;

    procedure pMarcaBase;
    procedure pDesmarcaBase;
    procedure pSeleciona(blnAltCam: Boolean);
    procedure pSelecionaBase(blnAltCam: Boolean);
    procedure pMarcaCampo(strNomCam: String);
    Procedure pMontaConsulta;
    Procedure pCriaClientConsulta;
    function fRetQtdeComparar: Integer;
    procedure pGeraExcel;
    procedure pImpSubColunas(Excel: TExcel; Campos: TCampos);

  Public
    procedure pIniModulos(modRecMod: TRecModulos);
    procedure pIniVariaveis(varRecVar: TRecVariaveis);
    Function fCalculaPrecoCusto(fltPreCom,
                            fltDesF01,
                            fltDesF02,
                            fltDesF03,
                            fltDesF04,
                            fltDesF05,
                            fltDesF06,
                            fltIcmEnt,
                            fltIpiEnt,
                            fltFreEnt,
                            fltAcrFin,
                            fltSubsti,
                            fltValFre,
                            fltDesAdb,
                            fltSubFed,
                            fltTCIFCu,
                            fltTSCust,
                            fltDePiCo,
                            fltDeICMS,
                            fltFatReg: Double): Double;


  public
    { Public declarations }
  end;

var
  frmRelEstComparativoPrecosFornec: TfrmRelEstComparativoPrecosFornec;

implementation

uses untIConfiguracao;

{$R *.dfm}

Function TfrmRelEstComparativoPrecosFornec.fSQLTabPre: String;
Begin
  Result := '';
  Result := Result + '  SELECT SQL_NO_CACHE ';
  Result := Result + '    TAB_CODTAB AS CODTAB, ';
  Result := Result + '    TAB_NOMTAB AS NOMTAB, ';
  Result := Result + '    TAB_CODFOR AS CODFOR, ';
  Result := Result + '    FOR_NOMFOR AS NOMFOR, ';
  Result := Result + '    TAB_ATICMP AS ATICMP, ';
  Result := Result + '    "N"        AS BASCOM, ';
  Result := Result + '    "N"        AS COMPAR  ';
  Result := Result + '  FROM';
  Result := Result + '    TABPRE ';
  Result := Result + '  INNER JOIN CADFOR ON FOR_CODFOR = TAB_CODFOR ';
End;

procedure TfrmRelEstComparativoPrecosFornec.pDesmarcaBase;
  Var
    strCodTab: String;
begin
  inherited;

  With cdsTabPre Do
  Begin
    DisableControls;
    strCodTab:= FieldByName('CODTAB').AsString;
    Filter   := 'BASCOM = ' + QuotedStr('S');
    Filtered := True;

    First;
    While Not Eof Do
    Begin
      If strCodTab <> FieldByName('CODTAB').AsString Then
      Begin
        Edit;
        FieldbyName('BASCOM').AsString := 'N';
        Post;
      End;

      Next;
    End;

    Filtered := False;

    Locate('CODTAB', strCodTab, []);
    EnableControls;
  End;
end;

procedure TfrmRelEstComparativoPrecosFornec.pGeraExcel;
  Var
    objGExcel   : TGeraExcel;
    intContador : Integer;
begin
  Try
    objGExcel := TGeraExcel.Create(cdsRelato, Nil);
    With objGExcel Do
    Begin
      AddCampo('CODITE', 'CÓDIGO');
      AddCampo('DESITE', 'DESCRIÇÃO');
      AddCampo('REFERE', 'REFERÊNCIA');
      AddCampo('SIGUNI', 'UNIDADE');
      AddCampo('CODFAB', 'CÓD. FÁBRICA');
      AddCampo('CODGRU', 'CÓD. LINHA/GRUPO');
      AddCampo('DESGRU', 'DESCRIÇÃO');
      AddCampo('FORPRC', 'CÓD. FORNECEDOR PRINCIPAL');
      AddCampo('FORPRN', 'NOME FORNECEDOR PRINCIPAL');

      For intContador := 0 To stlTabPre.Count - 1 Do
      Begin
        AddCampo('CUSREA' + stlTabPre[intContador], 'CUSTO REAL');
        AddCampo('VARIAC' + stlTabPre[intContador], '% VAR');
      End;

      OnImpTitColuna := pImpSubColunas;
      blnImpTitColFim := False;

      If fGerarRelatorio Then
        fMensagem('','Arquivo gerado com sucesso!', ['&Ok']);

    End;

  Finally
    FreeAndNil(objGExcel);
  End;
end;

procedure TfrmRelEstComparativoPrecosFornec.pImpSubColunas(Excel: TExcel; Campos: TCampos);
  Var
    intContador : Integer;
Begin
  With Excel Do
  Begin
    ProximaLinha;

    For intContador := 0 To stlTabPre.Count - 1 Do
    Begin
      Mesclar( fGetLetraAlfa(Campos.ColunaPorNome['CUSREA' + stlTabPre[intContador]].Coluna) + intToStr(LinhaAtual),
               fGetLetraAlfa(Campos.ColunaPorNome['VARIAC' + stlTabPre[intContador]].Coluna) + intToStr(LinhaAtual));
      Bordas(fGetLetraAlfa(Campos.ColunaPorNome['CUSREA' + stlTabPre[intContador]].Coluna) + intToStr(LinhaAtual),
             fGetLetraAlfa(Campos.ColunaPorNome['VARIAC' + stlTabPre[intContador]].Coluna) + intToStr(LinhaAtual),
             True, True, True, False);

      Escrever(LinhaAtual, Campos.ColunaPorNome['CUSREA' + stlTabPre[intContador]].Coluna, fRetNomFornecedor(fRetCodFornecedorTabelaPreco(stlTabPre[intContador])));

    End;

    ProximaLinha;
    For intContador := 0 To stlTabPre.Count - 1 Do
    Begin
      Mesclar( fGetLetraAlfa(Campos.ColunaPorNome['CUSREA' + stlTabPre[intContador]].Coluna) + intToStr(LinhaAtual),
               fGetLetraAlfa(Campos.ColunaPorNome['VARIAC' + stlTabPre[intContador]].Coluna) + intToStr(LinhaAtual));
      Bordas(fGetLetraAlfa(Campos.ColunaPorNome['CUSREA' + stlTabPre[intContador]].Coluna) + intToStr(LinhaAtual),
             fGetLetraAlfa(Campos.ColunaPorNome['VARIAC' + stlTabPre[intContador]].Coluna) + intToStr(LinhaAtual),
             True, True, False, False);

      Escrever(LinhaAtual, Campos.ColunaPorNome['CUSREA' + stlTabPre[intContador]].Coluna, fRetNomeTabelaPreco(stlTabPre[intContador]));
    End;

    {Variables['FORNECEDOR' + IntToStr(Succ(intContador))] := fRetNomFornecedor(fRetCodFornecedorTabelaPreco(stlTabPre[intContador]));
    Variables['TABELA' + IntToStr(Succ(intContador))]     := fRetNomeTabelaPreco(stlTabPre[intContador]);

    If FindObject('mmoCusRea' + IntToStr(Succ(intContador))) <> Nil Then
      TfrxMemoView(FindObject('mmoCusRea' + IntToStr(Succ(intContador)))).Text :=
         '[IIF(<frxDBItens."CUSREA' + stlTabPre[intContador] + '"> = -0.000001, ''-'', <frxDBItens."CUSREA' + stlTabPre[intContador] + '">)]';

    If FindObject('mmoVariac' + IntToStr(Succ(intContador))) <> Nil Then
      TfrxMemoView(FindObject('mmoVariac' + IntToStr(Succ(intContador)))).Text :=
         '[IIF(<frxDBItens."VARIAC' + stlTabPre[intContador] + '"> = -0.000001, ''-'', <frxDBItens."VARIAC' + stlTabPre[intContador] + '">)]';

    If FindObject('mmoTitCus' + IntToStr(Succ(intContador))) <> Nil Then
      TfrxMemoView(FindObject('mmoTitCus' + IntToStr(Succ(intContador)))).Visible := True;

    If FindObject('mmoTitVar' + IntToStr(Succ(intContador))) <> Nil Then
      TfrxMemoView(FindObject('mmoTitVar' + IntToStr(Succ(intContador)))).Visible := True;}
  End;



End;

procedure TfrmRelEstComparativoPrecosFornec.pMarcaCampo(strNomCam: String);
Begin

  With cdsTabPre Do
  Begin
    Edit;
    If FieldbyName(strNomCam).AsString = 'S' Then
      FieldbyName(strNomCam).AsString := 'N'
    Else
      FieldbyName(strNomCam).AsString := 'S';
    Post;
  End;

End;

procedure TfrmRelEstComparativoPrecosFornec.TabPreCOMPARPropertiesChange(
  Sender: TObject);
begin
  inherited;

  pSeleciona(False);
end;

procedure TfrmRelEstComparativoPrecosFornec.pSelecionaBase(blnAltCam: Boolean);
  Var
    strCodTab: String;
    blnDesmarcar: Boolean;
Begin

  With cdsTabPre Do
  Begin
    DisableControls;
    strCodTab := FieldbyName('CODTAB').AsString;

    Filter       := 'COMPAR = ' + QuotedStr('S') + ' AND CODTAB <> ' + QuotedStr(strCodTab);
    Filtered     := True;
    blnDesmarcar := RecordCount > 2;
    Filtered     := False;
    Locate('CODTAB', strCodTab, []);

    If blnDesmarcar Then
    Begin
      Edit;
      FieldbyName('BASCOM').AsString := 'N';
      Post;
    End Else
    Begin
      If blnAltCam Then
        pMarcaCampo('BASCOM');

      With cdsTabPre Do
      Begin
        If (FieldbyName('BASCOM').AsString = 'S') And
           (FieldbyName('COMPAR').AsString = 'N') Then
          pMarcaCampo('COMPAR');
      End;

      pDesmarcaBase;
      pMarcaBase;
    End;

    EnableControls;
  End;
End;


procedure TfrmRelEstComparativoPrecosFornec.btnBasComClick(Sender: TObject);
begin
  inherited;

  pSelecionaBase(True);
end;

procedure TfrmRelEstComparativoPrecosFornec.pMarcaBase;
  Var
    strCodTab: String;
begin
  inherited;

  With cdsTabPre Do
  Begin
    DisableControls;
    strCodTab := FieldByName('CODTAB').AsString;

    If Not Locate('BASCOM', 'S', []) Then
    Begin
      Locate('CODTAB', strCodTab, []);

      If FieldByName('COMPAR').AsString = 'S' Then
      Begin
        pMarcaCampo('BASCOM');
      End Else
      Begin
        If Locate('COMPAR', 'S', []) Then
          pMarcaCampo('BASCOM');
      End;

    End;

    Locate('CODTAB', strCodTab, []);
    EnableControls;
  End;
End;

Function TfrmRelEstComparativoPrecosFornec.fMarcaComparar: Boolean;
  Var
    strCodTab: String;
    blnDesmarcar: Boolean;
Begin
  Result := True;

  With cdsTabPre Do
  If FieldbyName('COMPAR').AsString = 'S' Then
  Begin
    DisableControls;
    strCodTab := FieldbyName('CODTAB').AsString;

    Filter   := 'COMPAR = ' + QuotedStr('S');
    Filtered := True;
    blnDesmarcar := RecordCount > 6;

    Filtered := False;

    If Locate('CODTAB', strCodTab, []) And blnDesmarcar Then
    Begin
      Edit;
      FieldbyName('COMPAR').AsString := 'N';
      Post;
    End;

    EnableControls;
    Result := False;
  End;

End;

Function TfrmRelEstComparativoPrecosFornec.fRetQtdeComparar : Integer;
  Var
    intQtdeComparar : Integer;
Begin

  intQtdeComparar := 0;

  With cdsTabPre Do
  Begin

    First;

    while not eof do
    Begin
      If FieldbyName('COMPAR').AsString = 'S' Then intQtdeComparar := intQtdeComparar + 1;
      Next;
    End;
  End;

  Result := intQtdeComparar;
End;

procedure TfrmRelEstComparativoPrecosFornec.pSeleciona(blnAltCam: Boolean);
Begin
  If blnAltCam Then
    pMarcaCampo('COMPAR');

  With cdsTabPre Do
  Begin
    fMarcaComparar;

    If (FieldbyName('COMPAR').AsString = 'N') And
       (FieldbyName('BASCOM').AsString = 'S') Then
     pMarcaCampo('BASCOM');

  End;

  pMarcaBase;
End;

procedure TfrmRelEstComparativoPrecosFornec.btnImprimirClick(Sender: TObject);
  Var
    frxReport   : TfrxReport;
    intContador : Integer;
    intQtdeComp : Integer;
begin
  strTabPre :=  fRetSelecaoTabPre;

  If stlTabPre.Count < 2 Then
  Begin
    pMensagemOk('Selecione ao menos duas tabelas para comparação!');
    Exit;
  End;

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  inherited;

  If blnImprime Then
  Begin

    If fAbreItens Then
    Begin
      If edtDestino.Text = 'E' Then
        pGeraExcel
      Else
      Begin
        // Verifica a quantidade selecionada para comparação
        If fRetQtdeComparar <= 3 Then
        Begin

          intQtdeComp := 2; // Variavel utilizada no loop para limpar colunas não utilizadas na comparação

          If (strTipImp = 'M') Then
          Begin
            frxReport := frxReportM;
          End
            Else
          Begin
            frxReport := frxReportJ;
            frxReport.DotMatrixReport           := False;
            TfrxMemoView(frxReport.FindObject('mmoZebra')).Highlight.Color := fCfgSis('CORZEB');
          End;
        End
        Else // Se comparar mais de 3 fornecedores, utilizamos em modo paisagem, apenas com opção jato
        Begin
          intQtdeComp := 5; // Variavel utilizada no loop para limpar colunas não utilizadas na comparação

          frxReport := frxReportJp;
          frxReport.DotMatrixReport           := False;
          TfrxMemoView(frxReport.FindObject('mmoZebra')).Highlight.Color := fCfgSis('CORZEB');
        End;

        With frxReport, Script Do
        Begin
          Variables['NOMREL']  := 'COMPARATIVO DE PRECOS NA FORMACAO DE CUSTOS POR FORNECEDOR';

          For intContador := 0 To intQtdeComp Do
          Begin
            Variables['FORNECEDOR' + IntToStr(Succ(intContador))] := '';
            Variables['TABELA' + IntToStr(Succ(intContador))]     := '';

            If FindObject('mmoCusRea' + IntToStr(Succ(intContador))) <> Nil Then
              TfrxMemoView(FindObject('mmoCusRea' + IntToStr(Succ(intContador)))).Text := '';

            If FindObject('mmoVariac' + IntToStr(Succ(intContador))) <> Nil Then
              TfrxMemoView(FindObject('mmoVariac' + IntToStr(Succ(intContador)))).Text := '';

            If FindObject('mmoTitCus' + IntToStr(Succ(intContador))) <> Nil Then
              TfrxMemoView(FindObject('mmoTitCus' + IntToStr(Succ(intContador)))).Visible := False;

            If FindObject('mmoTitVar' + IntToStr(Succ(intContador))) <> Nil Then
              TfrxMemoView(FindObject('mmoTitVar' + IntToStr(Succ(intContador)))).Visible := False;
          End;

          For intContador := 0 To stlTabPre.Count - 1 Do
          Begin
            Variables['FORNECEDOR' + IntToStr(Succ(intContador))] := fRetNomFornecedor(fRetCodFornecedorTabelaPreco(stlTabPre[intContador]));
            Variables['TABELA' + IntToStr(Succ(intContador))]     := fRetNomeTabelaPreco(stlTabPre[intContador]);

            If FindObject('mmoCusRea' + IntToStr(Succ(intContador))) <> Nil Then
              TfrxMemoView(FindObject('mmoCusRea' + IntToStr(Succ(intContador)))).Text :=
                 '[IIF(<frxDBItens."CUSREA' + stlTabPre[intContador] + '"> = -0.000001, ''-'', <frxDBItens."CUSREA' + stlTabPre[intContador] + '">)]';

            If FindObject('mmoVariac' + IntToStr(Succ(intContador))) <> Nil Then
              TfrxMemoView(FindObject('mmoVariac' + IntToStr(Succ(intContador)))).Text :=
                 '[IIF(<frxDBItens."VARIAC' + stlTabPre[intContador] + '"> = -0.000001, ''-'', <frxDBItens."VARIAC' + stlTabPre[intContador] + '">)]';

            If FindObject('mmoTitCus' + IntToStr(Succ(intContador))) <> Nil Then
              TfrxMemoView(FindObject('mmoTitCus' + IntToStr(Succ(intContador)))).Visible := True;

            If FindObject('mmoTitVar' + IntToStr(Succ(intContador))) <> Nil Then
              TfrxMemoView(FindObject('mmoTitVar' + IntToStr(Succ(intContador)))).Visible := True;
          End;

          PrepareReport;

          PrintOptions.Printer := AnsiReplaceText(strNomImp,'\\' + fRetNomeRede + '\','');

          If (edtDestino.Text = 'V') Then
          Begin
            pPreviewReport(Self.Name, Self.Caption, frxReport);
          End Else
          Begin
            PrintOptions.ShowDialog := fEmptyStr(PrintOptions.Printer);
            pPrintReport(Self.Name, Self.Caption, strNomImp, frxReport);
          End;

        End;
      End;
    End;

  End;

  pnlInfo.Caption := '';
  pSetFocus(cxgTabPre);
end;

procedure TfrmRelEstComparativoPrecosFornec.btnSelecionaClick(Sender: TObject);
begin
  inherited;

  pSeleciona(True);

end;

procedure TfrmRelEstComparativoPrecosFornec.cxgTabPreViewBASCOMPropertiesChange(
  Sender: TObject);
begin
  inherited;

  pSelecionaBase(False);
end;

Function TfrmRelEstComparativoPrecosFornec.fCarregaTabPre: Boolean;
Begin
  With cdsTabPre, qryQuery Do
  Begin
    SQL.Text := fSQLTabPre;
    Result := fAbreClient(True, 'TfrmRelEstComparativoPrecosFornec.fCarregaTabPre');
  End;
End;

procedure TfrmRelEstComparativoPrecosFornec.FormCreate(Sender: TObject);
begin
  inherited;

  blnExcel := True;
  cdsTabPre := TZClient.Create(Self);
  dtsTabPre.DataSet := cdsTabPre.fGetDataset;
  fCarregaTabPre;

  cdsTabIte := TZClient.Create(Self);
  cdsRelato := TUniClientDataSet.Create(Self);

  frxDBItens.DataSet := cdsRelato;

  stlTabPre := TStringList.Create;

  pIniModulos(modiRecMod);
  pIniVariaveis(variRecVar);

end;

procedure TfrmRelEstComparativoPrecosFornec.FormDestroy(Sender: TObject);
begin
  inherited;

  FreeAndNil(stlTabPre);
end;

procedure TfrmRelEstComparativoPrecosFornec.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE: If fCheckParent(ActiveControl, cxgTabPre) then
                 Close;

    VK_RETURN: If fCheckParent(ActiveControl, cxgTabPre) then
                 pSetFocus(edtDestino);

    VK_SPACE:  If fCheckParent(ActiveControl, cxgTabPre) then
               Begin
                 If ssCtrl In Shift Then
                   btnBasCom.Click
                 Else
                   btnSeleciona.Click;
               End;
  End;

end;

procedure TfrmRelEstComparativoPrecosFornec.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(cxgTabPre);
end;

Function TfrmRelEstComparativoPrecosFornec.fRetSelecaoTabPre: String;
  Var
    strCodTab: String;
Begin
  With cdsTabPre Do
  Begin
    stlTabPre.Clear;
    DisableControls;
    Result := '';

    Filter := 'COMPAR = ' + QuotedStr('S');
    Filtered := True;
    intQtdTab := RecordCount;

    If Locate('BASCOM', 'S', []) Then
    Begin
      stlTabPre.Add(FieldByName('CODTAB').AsString);
      strCodTab := FieldByName('CODTAB').AsString;
    End;

    First;

    While Not Eof Do
    Begin
      If strCodTab <> FieldByName('CODTAB').AsString Then
        stlTabPre.Add(FieldByName('CODTAB').AsString);

      Result := Result + QuotedStr(FieldByName('CODTAB').AsString);
      Next;

      If Not Eof Then
        Result := Result + ', ';
    End;

    Filtered := False;
    EnableControls;
  End;

End;

Function TfrmRelEstComparativoPrecosFornec.fSQLRelatorio: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE        ';
  strSQL := strSQL + '   I.ITE_CODITE AS CODITE,  ';
  strSQL := strSQL + '   I.ITE_DESITE AS DESITE,  ';
  strSQL := strSQL + '   I.ITE_REFERE AS REFERE,  ';
  strSQL := strSQL + '     UNI_SIGUNI AS SIGUNI,  ';
  strSQL := strSQL + '   I.ITE_CODFAB AS CODFAB,  ';
  strSQL := strSQL + '   CONCAT(LEFT(I.ITE_CODGRU,3) ,".", RIGHT(I.ITE_CODGRU,3)) AS CODGRU,  ';
  strSQL := strSQL + '     GRU_DESGRU AS DESGRU,  ';
  strSQL := strSQL + '   I.ITE_CODFOR AS FORPRC,  '; //FORNECEDOR PRINCIPAL CÓDIGO
  strSQL := strSQL + '   P.FOR_NOMFOR AS FORPRN,  '; //FORNECEDOR PRINCIPAL NOME

  strSQL := strSQL + '     TAB_CODFOR AS CODFOR,  ';
  strSQL := strSQL + '   F.FOR_NOMFOR AS NOMFOR,  ';
  strSQL := strSQL + '     TAB_CODTAB AS CODTAB,  ';
  strSQL := strSQL + '     TAB_NOMTAB AS NOMTAB,  ';

  strSQL := strSQL + '   D.ITE_DESF01 AS DESF01,  ';
  strSQL := strSQL + '   D.ITE_DESF02 AS DESF02,  ';
  strSQL := strSQL + '   D.ITE_DESF03 AS DESF03,  ';
  strSQL := strSQL + '   D.ITE_DESF04 AS DESF04,  ';
  strSQL := strSQL + '   D.ITE_DESF05 AS DESF05,  ';
  strSQL := strSQL + '   D.ITE_DESF06 AS DESF06,  ';

  strSQL := strSQL + '   D.ITE_PRECOM / IF(IFNULL(ITE_CNVCUS, 0) <= 0, 1, ITE_CNVCUS) AS PRECOM,  ';
  strSQL := strSQL + '   D.ITE_ICMENT AS ICMENT,  ';
  strSQL := strSQL + '   D.ITE_SUBFED AS SUBFED,  ';
  strSQL := strSQL + '   D.ITE_IPIENT AS IPIENT,  ';
  strSQL := strSQL + '   D.ITE_FREENT AS FREENT,  ';
  strSQL := strSQL + '   D.ITE_VALFRE / IF(IFNULL(ITE_CNVCUS, 0) <= 0, 1, ITE_CNVCUS) AS VALFRE,  ';
  strSQL := strSQL + '   D.ITE_ACRFIN AS ACRFIN,  ';
  strSQL := strSQL + '   D.ITE_DESADB AS DESADB,  ';
  strSQL := strSQL + '   D.ITE_SUBSTI AS SUBSTI,  ';

  strSQL := strSQL + '   D.ITE_PRECUS AS PRECUS,  ';
  strSQL := strSQL + '   D.ITE_ICMSAI AS ICMSAI,  ';
  strSQL := strSQL + '   D.ITE_IMPFED AS IMPFED,  ';
  strSQL := strSQL + '   D.ITE_DESOPE AS DESOPE,  ';
  strSQL := strSQL + '   D.ITE_TCIFCU AS TCIFCU,  ';
  strSQL := strSQL + '   D.ITE_TSCUST AS TSCUST,  ';
  strSQL := strSQL + '   D.ITE_DEPICO AS DEPICO,  ';
  strSQL := strSQL + '   D.ITE_DEICMS AS DEICMS,  ';
  strSQL := strSQL + '   D.ITE_FATREG AS FATREG,  ';
  strSQL := strSQL + '   D.ITE_OUTVAL / IF(IFNULL(ITE_CNVCUS, 0) <= 0, 1, ITE_CNVCUS) AS OUTVAL,    ';
  strSQL := strSQL + '   IF(T.ITE_CODTAB = ' + QuotedStr(stlTabPre[0]) + ', 0, 1) AS ORDEM ';

  strSQL := strSQL + ' FROM                       ';
  strSQL := strSQL + '   ITEFOR T                 ';

  strSQL := strSQL + ' INNER JOIN TABPRE   ON T.ITE_CODTAB =   TAB_CODTAB ';

  strSQL := strSQL + ' INNER JOIN TABDET D ON D.ITE_CODTAB = T.ITE_CODTAB ';
  strSQL := strSQL + '                    AND D.ITE_CODITE = T.ITE_CODITE ';
  strSQL := strSQL + '                    AND D.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);

  strSQL := strSQL + ' INNER JOIN CADITE I ON I.ITE_CODITE = T.ITE_CODITE ';
  strSQL := strSQL + ' INNER JOIN CADFOR F ON F.FOR_CODFOR =   TAB_CODFOR ';
  strSQL := strSQL + ' INNER JOIN CADFOR P ON P.FOR_CODFOR = I.ITE_CODFOR ';
  strSQL := strSQL + ' INNER JOIN CADUNI   ON   UNI_CODUNI = I.ITE_CODUNI ';
  strSQL := strSQL + ' INNER JOIN CADGRU   ON   GRU_CODGRU = I.ITE_CODGRU ';
  strSQL := strSQL + ' WHERE          ';
  strSQL := strSQL + '   TAB_CODTAB IN (' + strTabPre + ')';
  strSQL := strSQL + ' ORDER BY ';
  strSQL := strSQL + '   I.ITE_CODITE, ORDEM ';

  Result := strSQL;
End;

Function TfrmRelEstComparativoPrecosFornec.fAbreItens: Boolean;
Begin
  With cdsTabIte, qryQuery Do
  Begin
    SQL.Text := fSQLRelatorio;
    Result   := fAbreClient(True, 'TfrmRelEstComparativoPrecosFornec.fAbreItens');

    If Result Then
      pMontaConsulta;
  End;
End;

Procedure TfrmRelEstComparativoPrecosFornec.pCriaClientConsulta;
  Var
    intContador: Integer;
Begin
  With cdsRelato, FieldDefs Do
  Begin
    Close;
    FieldDefs.Clear;
    Fields.Clear;

    With AddFieldDef Do Begin Name := 'CODITE'; DataType := ftString;             Required := False; End;
    With AddFieldDef Do Begin Name := 'DESITE'; DataType := ftString; Size := 70; Required := False; End;
    With AddFieldDef Do Begin Name := 'REFERE'; DataType := ftString; Size := 70; Required := False; End;
    With AddFieldDef Do Begin Name := 'SIGUNI'; DataType := ftString; Size := 06; Required := False; End;
    With AddFieldDef Do Begin Name := 'CODFAB'; DataType := ftString; Size := 35; Required := False; End;
    With AddFieldDef Do Begin Name := 'CODGRU'; DataType := ftString; Size := 07; Required := False; End;
    With AddFieldDef Do Begin Name := 'DESGRU'; DataType := ftString; Size := 70; Required := False; End;
    With AddFieldDef Do Begin Name := 'FORPRC'; DataType := ftString; Size := 08; Required := False; End;
    With AddFieldDef Do Begin Name := 'FORPRN'; DataType := ftString; Size := 60; Required := False; End;

    For intContador := 0 To stlTabPre.Count - 1 Do
    Begin
      With AddFieldDef Do Begin Name := 'CODFOR' + stlTabPre[intContador]; DataType := ftString;             Required := False; End;
      With AddFieldDef Do Begin Name := 'NOMFOR' + stlTabPre[intContador]; DataType := ftString; Size := 70; Required := False; End;

      With AddFieldDef Do Begin Name := 'CODTAB' + stlTabPre[intContador]; DataType := ftString;             Required := False; End;
      With AddFieldDef Do Begin Name := 'NOMTAB' + stlTabPre[intContador]; DataType := ftString; Size := 70; Required := False; End;

      With AddFieldDef Do Begin Name := 'CUSREA' + stlTabPre[intContador]; DataType := ftFloat;              Required := False; End;
      With AddFieldDef Do Begin Name := 'VARIAC' + stlTabPre[intContador]; DataType := ftFloat;              Required := False; End;
    End;

    CreateDataSet;
    Open;
  End;
End;

Procedure TfrmRelEstComparativoPrecosFornec.pMontaConsulta;
  Var
    strCodIte: String;
    fltCusBas,
    fltPreCus: Double;
    intContador: Integer;
Begin
  fltCusBas := 0;
  pCriaClientConsulta;

  With cdsTabIte Do
  Begin
    strCodIte := '';

    First;
    While Not Eof Do
    Begin

      If strCodIte <> FieldByName('CODITE').AsString Then
      Begin
        cdsRelato.Insert;

        For intContador := 0 To cdsRelato.FieldCount - 1 Do
          If cdsRelato.Fields[intContador].DataType = ftFloat Then
            cdsRelato.Fields[intContador].AsFloat := -0.000001;

        cdsRelato.FieldByName('CODITE').AsString := FieldByName('CODITE').AsString;
        cdsRelato.FieldByName('DESITE').AsString := FieldByName('DESITE').AsString;
        cdsRelato.FieldByName('REFERE').AsString := FieldByName('REFERE').AsString;
        cdsRelato.FieldByName('SIGUNI').AsString := FieldByName('SIGUNI').AsString;
        cdsRelato.FieldByName('CODFAB').AsString := FieldByName('CODFAB').AsString;
        cdsRelato.FieldByName('CODGRU').AsString := FieldByName('CODGRU').AsString;
        cdsRelato.FieldByName('DESGRU').AsString := FieldByName('DESGRU').AsString;
        cdsRelato.FieldByName('FORPRC').AsString := FieldByName('FORPRC').AsString;
        cdsRelato.FieldByName('FORPRN').AsString := FieldByName('FORPRN').AsString;

      End Else
      Begin
        cdsRelato.Edit;
      End;

      fltPrecus := fCalculaPrecoCusto(FieldByName('PRECOM').AsFloat,
                                  FieldByName('DESF01').AsFloat,
                                  FieldByName('DESF02').AsFloat,
                                  FieldByName('DESF03').AsFloat,
                                  FieldByName('DESF04').AsFloat,
                                  FieldByName('DESF05').AsFloat,
                                  FieldByName('DESF06').AsFloat,
                                  FieldByName('ICMENT').AsFloat,
                                  FieldByName('IPIENT').AsFloat,
                                  FieldByName('FREENT').AsFloat,
                                  FieldByName('ACRFIN').AsFloat,
                                  FieldByName('SUBSTI').AsFloat,
                                  FieldByName('VALFRE').AsFloat,
                                  FieldByName('DESADB').AsFloat,
                                  FieldByName('SUBFED').AsFloat,
                                  FieldByName('TCIFCU').AsFloat,
                                  FieldByName('TSCUST').AsFloat,
                                  FieldByName('DEPICO').AsFloat,
                                  FieldByName('DEICMS').AsFloat,
                                  FieldByName('FATREG').AsFloat);

      cdsRelato.FieldByName('CUSREA' + FieldByName('CODTAB').AsString).AsFloat :=
         fCalculaCustoReal(fltPrecus,
                           FieldByName('ICMSAI').AsFloat,
                           FieldByName('IMPFED').AsFloat,
                           FieldByName('DESOPE').AsFloat,
                           FieldByName('OUTVAL').AsFloat);


      If cdsRelato.State = dsInsert Then
      Begin
        If FieldByName('CODTAB').AsString = stlTabPre[0] Then
          fltCusBas := cdsRelato.FieldByName('CUSREA' + FieldByName('CODTAB').AsString).AsFloat
        Else
          fltCusBas := -1;
      End Else
      Begin
        If (fltCusBas <> -1) And (fltCusBas <> 0) Then
          cdsRelato.FieldByName('VARIAC' + FieldByName('CODTAB').AsString).AsFloat :=
            ((cdsRelato.FieldByName('CUSREA' + FieldByName('CODTAB').AsString).AsFloat / fltCusBas) - 1) * 100;
      End;

      cdsRelato.FieldByName('CODFOR' + FieldByName('CODTAB').AsString).AsString := FieldByName('CODFOR').AsString;
      cdsRelato.FieldByName('NOMFOR' + FieldByName('CODTAB').AsString).AsString := FieldByName('NOMFOR').AsString;
      cdsRelato.FieldByName('CODTAB' + FieldByName('CODTAB').AsString).AsString := FieldByName('CODTAB').AsString;
      cdsRelato.FieldByName('NOMTAB' + FieldByName('CODTAB').AsString).AsString := FieldByName('NOMTAB').AsString;


      cdsRelato.Post;

      strCodIte := FieldByName('CODITE').AsString;

      Next;
    End;
  End;

End;

procedure TfrmRelEstComparativoPrecosFornec.pIniVariaveis(varRecVar: TRecVariaveis);
Begin
  varRecVar.VS_Date                   := untFuncoesSimples.VS_Date;
  varRecVar.utcRegistros              := untFuncoesSimples.utcRegistros;
  varRecVar.strLoginUsuarioLogado     := untFuncoesSimples.strLoginUsuarioLogado;
  varRecVar.strDescriUsuarioLogado    := untFuncoesSimples.strDescriUsuarioLogado;
  varRecVar.strEmpAcessoUsuarioLogado := untFuncoesSimples.strEmpAcessoUsuarioLogado;
  varRecVar.VS_strCodEmp              := untFuncoesSimples.VS_strCodEmp;
  varRecVar.VS_strUsaTmq              := untFuncoesSimples.VS_strUsaTmq;
  varRecVar.VS_strTitLot              := untFuncoesSimples.VS_strTitLot;
  varRecVar.VS_strTitLts              := untFuncoesSimples.VS_strTitLts;
  varRecVar.strPortadoresOperador     := untFuncoesSimples.strPortadoresOperador;
  varRecVar.arrProCod                 := untFuncoesSimples.arrProCod;
  varRecVar.funcPrecoCusto            := variRecVar.funcPrecoCusto;
  varRecVar.blnUsuarioLogadoUtilizaModoClassico := untFuncoesSimples.blnUsuarioLogadoUtilizaModoClassico;

  if (not Assigned(untFuncoesSimples.VS_Trace)) then
    untFuncoesSimples.VS_Trace := TSQLTrace.Create();

  varRecVar.objTrace   := untFuncoesSimples.VS_Trace;
  varRecVar.objFuncoes := TFuncoesRelatorio.Create;
End;

procedure TfrmRelEstComparativoPrecosFornec.pIniModulos(modRecMod: TRecModulos);
Begin
  With modRecMod Do
  Begin
    Banco  := frmModulo.GetCurrentConnection;
    ModuloSpr := @frmModuloSPR;
  End;
End;


Function TfrmRelEstComparativoPrecosFornec.fCalculaPrecoCusto(fltPreCom,
                            fltDesF01,
                            fltDesF02,
                            fltDesF03,
                            fltDesF04,
                            fltDesF05,
                            fltDesF06,
                            fltIcmEnt,
                            fltIpiEnt,
                            fltFreEnt,
                            fltAcrFin,
                            fltSubsti,
                            fltValFre,
                            fltDesAdb,
                            fltSubFed,
                            fltTCIFCu,
                            fltTSCust,
                            fltDePiCo,
                            fltDeICMS,
                            fltFatReg: Double): Double;
  Var
    cpcParams: TParCalculaPrecoCusto;
Begin
  cpcParams := TParCalculaPrecoCusto.Create(Nil, TConfiguracao.fGetConfiguracao);

  With cpcParams Do
  Begin
    curPreCom := fltPreCom;
    curDesF01 := fltDesf01;
    curDesF02 := fltDesf02;
    curDesF03 := fltDesf03;
    curDesF04 := fltDesf04;
    curDesF05 := fltDesf05;
    curDesF06 := fltDesf06;
    curICMSEnt:= fltIcmEnt;
    curIPIEnt := fltIpiEnt;
    curFrete  := fltFreEnt;
    curAcrFin := fltAcrFin;
    curSubsti := fltSubsti;
    curValFre := fltValFre;
    curDesAdb := fltDesAdb;
    curSubFed := fltSubFed;

    if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
    begin
      curTCIFCu := fltTCIFCu;
      curTSCust := fltTSCust;
      curDePiCo := fltDePiCo;
      curDeICMS := fltDeICMS;
      curFatReg := fltFatReg;
    end
    else
    begin
      curTCIFCu := 0;
      curTSCust := 0;
      curDePiCo := 0;
      curDeICMS := 0;
      curFatReg := 0;
    end;
  End;
  Result := cpcParams.fCalculaPrecoCusto();

  FreeAndNil(cpcParams);
End;

end.
