unit untTabelasDoItem;

interface

Uses
  cxProgressBar,
  Classes,
  SysUtils,
  Controls,
  ComCtrls,
  DB,
  DBClient,
  Forms,
  Math,
  Variants,
  untFuncoesSimples,
  Uni,
  untZClient,
  untIteBar,
  untParCalculaPrecoCusto,
  DBEditFocus,
  untTypesTabelaPreco;

Type
  TSetaCodAbf = procedure(var strCodAbfDef: String; blnApenasValida: Boolean) of object;

  TTabelaSelecionada = set of (ttsTab1, ttsTab2, ttsTab3, ttsTab4,ttsTab5, ttsTab6, ttsTab7);

  TTabelasDoItem = Class
    Private
      FInclusao: Boolean;
      blnAlterandoCnv : Boolean;

      FCopyTabDet,
      qryTabDetHeranca: TUniQuery;
      qryIteGer,
      qryCadIte: TDataSet;
      blnAlterandoIncidePis: Boolean;

      cpcParams: TParCalculaPrecoCusto;

      FEmpresasUsamPrecoMatriz: String;
      FblnIncidePis: Boolean;

      Function fGetEmpresasUsamPrecoMatriz: String;

      Function fSQLTabDets(blnTrocaTabela: Boolean = False): String;

      Function fSQLTabDet(intTabPreVen: Integer; strCodEmp: String; blnTrocaTabela: Boolean = False): String;

      Function fAjustaCustoReal: Boolean;

      Function fSQLTabelas(intTabela: Integer; strCodTab: String): String;

      Function fCarregaTabelas: Boolean;
      Function fCarregaTabelasInclusao: Boolean;
      Function fIncluiTabDet: Boolean;
      Function fAtualizaTabDetCus: Boolean;

      Function fSalvaDetCus(dataSet: TDataSet; strAutoIncrem: String; strCodTab: string; intRecNo: integer; TabelaItens: TDataSet; strCodemp: String): Boolean;


      function fRetPrecoCusto(dataSet: TDataSet; strNov: String = ''): Double;

      Procedure pAfterPostFormacaoDePreco(dataSet: TDataSet);


      Function fGeraItefor: Boolean;
      Function fGeraTabDetEmpresas: Boolean;

      Function fAtualizaEmpresasUsamPrecoMatrizIteger: Boolean;

      Function fSQLUpdateIteger: String;

      Function fSQLTabDetHeranca: String;
      function fEditaTabelaItens: Boolean;
      function fCarregaInfTabela(AstrCodTab: String; var strDescricaoTabela: String; var strFornecedorTabela: String; var strCodForTabela: String): Boolean;
      procedure pPreencheValoresPromocao;
      function fTabelaSelecionada(strTabela: String; TabelaSelecionada: TTabelaSelecionada): Boolean;
      function fAjustaCustoRealPrg(prgProgresso: TCXProgressBar): Boolean;


    Public
      cdsDados: TZClient;
      // REFTRI (CFG_TABPRD, 2026-10-19): o cadastro de produtos e avisado a cada linha gravada no frame (aba 1 do
      // pgcPrecos), para levar o valor ao produto e as abas do plugin. Nil fora do cadastro.
      pAfterPostLinhaExterno: TNotifyEvent;
      strFrmCus,
      strTipAbf,
      strTPABPC: String;
      blnSufram,
      blnCadTabelaPreco,
      blnCotDor: Boolean;
      intDecUni: Integer;

      cdsAbrFis: TZClient;
      dbeCodFor: TDBEditFocus;
      dbeIncPis: TDBEditFocus;





      strCampoFocado: String;
      AlteracaoGlobalEmpresa: Boolean;
      strCodIteFocado: String;

      MSG_VALIDACAO_MARGEM: String;
      OnSetaCodAbf: TSetaCodAbf;

      cdsTabelas: TZClient;
      strCfgTBOFPC: String;

      FopcMarPre : TopcMarPre;
      qtdTabelasAtivas: integer;
      class var blnProcessoDeImportacao: Boolean;
      class var ImportacaoOpcMarPre: TopcMarPre;

      constructor Create(Owner: TComponent; AqryIteGer, AqryCadIte: TDataSet); Reintroduce;

      Destructor Destroy; override;
      Procedure pBeforePost(dataSet: TDataSet);
      Procedure pAfterPost(dataSet: TDataSet);
      Procedure pAfterPostLinha(dataSet: TDataSet);


      Function fCarregaPrecos(blnTrocaTabela: Boolean = False;  cdsTabDet: TZClient = nil): Boolean;
      procedure pFormataCampos;


      Procedure pAtualizaPreco(fltMargem: Double);
      Procedure pAtualizaMargem(fltPreco: Double);
      Procedure pAtualizaMargemPreco(fltComissao: Double);

      function fValidaMargem(fltMargem, fltComissao: Double): Boolean;

      function fSalvaDados: Boolean;

      Function fEscolheTabelaPreco: String;

      Function fBuscaTabelaAtiva(strCodFor, strCodIte: String): String;
      Function fRecarregaTabelasPreco(strTabelas, strTabAti: String): Boolean;

      Function fValidaTabelasPreco: Boolean;

      Procedure pAdicionaTabDetInclusao;

      Procedure pPreencheTabela(qryTabela: TUniQuery; strCodTab: String);

      Function fTabelaPrecoToIteger: Boolean;

      Function fValidaPrecos: Boolean;

      Function fCarregaDadosHeranca(strCodIte: String): Boolean;

      function fValidaFornecedor: Boolean;
      procedure pRecalculaTodasTabelas(strIncPis: String);
      procedure pReplicaCNV(fltCnv: Double);

      class procedure pInciaProcessoImportacao(AImportacaoOpcMarPre: TopcMarPre);
      class procedure pFinalizaProcessoImportacao;
  end;


implementation

Uses
  StrUtils,
  UniClientDataSet,
  untTConfiguracao,
  untTabelaPrecoSelec, untCalculaComposicaoCusto, untCadPro,
  untGravando;

constructor TTabelasDoItem.Create(Owner: TComponent; AqryIteGer, AqryCadIte: TDataSet);
var intContador: integer;
Begin
  Inherited Create;
  TTabelasDoItem.blnProcessoDeImportacao := False;
  qtdTabelasAtivas := 0;
  For intContador := 1 To 7 Do
    If VS_strTabPrc[intContador] = 'S' Then
      qtdTabelasAtivas := qtdTabelasAtivas + 1;

  blnAlterandoCnv := false;
  blnAlterandoIncidePis := False;
  blnCadTabelaPreco := False;
  qryTabDetHeranca := Nil;
  strCfgTBOFPC := fCfgSis('TBOFPC');
  cdsDados := TZClient.Create(nil);
  strCampoFocado := '';

  cpcParams := TParCalculaPrecoCusto.Create(nil, TConfiguracao.fGetConfiguracao);

  FEmpresasUsamPrecoMatriz := fGetEmpresasUsamPrecoMatriz;

  blnSufram := fCfgSis('SUFRAM', varBoolean);
  strFrmCus := fCfgSis('FRMCUS', varString);

  strTipAbf := fCfgSis('TIPABF');
  strTPABPC := fCfgSis('TPABPC');
  If fCfgSis('FORCAL', varString) = 'P' Then
    FopcMarPre := opcPrecoVenda
  Else
    FopcMarPre := opcMargem;

  blnCotDor := fCfgSis('COTDOR', varBoolean);
  intDecUni := fCfgSis('DECUNI', varInteger);
  If intDecUni > fTamPrecoIteger Then
    intDecUni := 4;

  MSG_VALIDACAO_MARGEM := 'A soma do ( ICMS Saída + Impostos Federais + Despesas Operacionais + Margem Bruta ' + IIF(fCfgSis('PCMPRO') = '2', '+ Comissão ', '') + '  ) não pode ser superior a 100%.';

  qryIteGer := AqryIteGer;
  qryCadIte := AqryCadIte;

  cdsTabelas := TZClient.Create(nil, fSQLTabelas(1, ''));
  cdsTabelas.IndexFieldNames := 'TABELA';

  Self.cdsDados.IndexFieldNames := 'TABELA';

  FCopyTabDet := fCriaQuery;
  FCopyTabDet.SQL.Text := 'SELECT * FROM TABDET WHERE FALSE';
  FCopyTabDet.Open;
  FCopyTabDet.Insert;
End;

Destructor TTabelasDoItem.Destroy;
Begin
  FreeAndNil(cdsDados);
  FreeAndNil(cpcParams);
  FreeAndNil(cdsTabelas);
  Inherited;

End;

Function TTabelasDoItem.fSQLTabelas(intTabela: Integer; strCodTab: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT                  ';
  strSQL := strSQL +  intTabela.ToString + ' AS TABELA, ';
  strSQL := strSQL + '   TAB_CODTAB AS CODTAB, ';
  strSQL := strSQL + '   TAB_NOMTAB AS NOMTAB, ';
  strSQL := strSQL + '   TAB_CODFOR AS CODFOR, ';
  strSQL := strSQL + '   FOR_NOMFOR AS NOMFOR  ';
  strSQL := strSQL + ' FROM     ';
  strSQL := strSQL + '   TABPRE ';
  strSQL := strSQL + ' INNER JOIN CADFOR ON FOR_CODFOR = TAB_CODFOR ';
  strSQL := strSQL + ' WHERE    ';
  strSQL := strSQL + '   TAB_CODTAB = ' + QuotedStr(strCodTab);
  Result := strSQL;
End;

Function TTabelasDoItem.fCarregaTabelas: Boolean;
  Var
    intContador: Integer;
    strSQL: String;
Begin
  For intContador := 1 To 7 Do
    If VS_strTabPrc[intContador] = 'S' Then
    Begin
      If Not strSQL.IsEmpty Then
        strSQL := strSQL + ' UNION ALL ';

      strSQL := strSQL + fSQLTabelas(intContador, qryIteGer.FieldByName('ITE_TABPR' + intContador.ToString).AsString);
    End;

  cdsTabelas.qryQuery.SQL.Text := strSQL;

  Result := cdsTabelas.fLeDados('TTabelasDoItem.fCarregaTabelas');
End;

Function TTabelasDoItem.fCarregaTabelasInclusao: Boolean;
  Var
    intContador: Integer;
Begin
  For intContador := 1 To 7 Do
    If VS_strTabPrc[intContador] = 'S' Then
    Begin
      cdsTabelas.Append;
      cdsTabelas.FieldByName('TABELA').AsInteger := intContador;
      cdsTabelas.Post;
    End;

  cdsTabelas.First;
  Result := True;
End;

Function TTabelasDoItem.fSQLTabDet(intTabPreVen: Integer; strCodEmp: String; blnTrocaTabela: Boolean = False): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + ' C.ITE_INCPIS, ';
  strSQL := strSQL +  'IF(IFNULL(F.ITE_CNVCUS, 0) <= 0, 1, F.ITE_CNVCUS) AS ITE_CNVCUS, ';

  strSQL := strSQL +    intTabPreVen.ToString + ' AS TABELA, ';
  strSQL := strSQL + '  T.ITE_PRECOM / IF(IFNULL(F.ITE_CNVCUS, 0) <= 0, 1, F.ITE_CNVCUS) AS ITE_PRECOM, ';
  strSQL := strSQL + '  T.ITE_VALFRE / IF(IFNULL(F.ITE_CNVCUS, 0) <= 0, 1, F.ITE_CNVCUS) AS ITE_VALFRE, ';
  strSQL := strSQL + '  T.ITE_PRECUS / IF(IFNULL(F.ITE_CNVCUS, 0) <= 0, 1, F.ITE_CNVCUS) AS ITE_PRECUS, ';
  strSQL := strSQL + '  DC.DET_OUTVAL / IF(IFNULL(F.ITE_CNVCUS, 0) <= 0, 1, F.ITE_CNVCUS) AS ITE_OUTVAL, ';

  strSQL := strSQL + '  I.ITE_MARBR' + intTabPreVen.ToString + ' AS ITE_MARBRU, ';
  strSQL := strSQL + '  I.ITE_COMTB' + intTabPreVen.ToString + ' AS ITE_COMTBL, ';
  strSQL := strSQL + '  I.ITE_PREVE' + intTabPreVen.ToString + ' AS ITE_PREVEN, ';
  strSQL := strSQL + '  I.ITE_FATREV AS ITE_FATREV, ';

  strSQL := strSQL + '  0.0000 AS ITE_MARPRO, ';
  strSQL := strSQL + '  0.0000 AS ITE_VENPRO, ';


  strSQL := strSQL + ' T.AUTOINCREM,';
  strSQL := strSQL + ' T.ITE_CODITE,';
  strSQL := strSQL + ' T.ITE_CODEMP,';
  strSQL := strSQL + ' T.ITE_DESF01,';
  strSQL := strSQL + ' T.ITE_DESF02,';
  strSQL := strSQL + ' T.ITE_DESF03,';
  strSQL := strSQL + ' T.ITE_DESF04,';
  strSQL := strSQL + ' T.ITE_DESF05,';
  strSQL := strSQL + ' T.ITE_DESF06,';
  strSQL := strSQL + ' T.ITE_PRECOM,';
  strSQL := strSQL + ' T.ITE_ICMENT,';
  strSQL := strSQL + ' T.ITE_SUBFED,';
  strSQL := strSQL + ' T.ITE_IPIENT,';
  strSQL := strSQL + ' T.ITE_FREENT,';
  strSQL := strSQL + ' T.ITE_VALFRE,';
  strSQL := strSQL + ' T.ITE_ACRFIN,';
  strSQL := strSQL + ' T.ITE_SUBSTI,';
  strSQL := strSQL + ' T.ITE_DESADB,';
  strSQL := strSQL + ' T.ITE_PRECUS,';
  strSQL := strSQL + ' DC.DET_ICMSAI AS ITE_ICMSAI,';
  strSQL := strSQL + ' T.ITE_IMPFED,';
  strSQL := strSQL + ' DC.DET_DESOPE AS ITE_DESOPE,';
  strSQL := strSQL + ' T.ITE_CODABF,';
  strSQL := strSQL + ' T.ITE_DESGER,';
  strSQL := strSQL + ' T.ITE_PROGER,';
  strSQL := strSQL + ' T.ITE_ABFIPI,';
  strSQL := strSQL + ' T.ITE_ABFCOF,';
  strSQL := strSQL + ' T.ITE_ABFPIS,';
  strSQL := strSQL + ' T.ITE_MARBRU,';
  strSQL := strSQL + ' T.ITE_PREVEN,';
  strSQL := strSQL + ' T.ITE_PREREV,';
  strSQL := strSQL + ' T.ITE_MARFEC,';
  strSQL := strSQL + ' T.ITE_CODTAB,';
  strSQL := strSQL + ' T.ITE_TCIFCU,';
  strSQL := strSQL + ' T.ITE_TSCUST,';
  strSQL := strSQL + ' T.ITE_DEPICO,';
  strSQL := strSQL + ' T.ITE_DEICMS,';
  strSQL := strSQL + ' T.ITE_FATREG,';
  strSQL := strSQL + ' T.ITE_EXCIPI,';
  strSQL := strSQL + ' T.ITE_PREDOL,';
  strSQL := strSQL + ' T.ITE_CODFOR,';
  strSQL := strSQL + ' T.ITE_COMTBL,';
  strSQL := strSQL + ' T.ITE_SEQGER,';
  strSQL := strSQL + ' T.ITE_PROCESSADO,';

  strSQL := strSQL + '  T.ITE_PRECOM / IF(IFNULL(F.ITE_CNVCUS, 0) <= 0, 1, F.ITE_CNVCUS) * ';
  strSQL := strSQL + '   ( 1 - (IFNULL(T.ITE_DESF01, 0) / 100) ) * ';
  strSQL := strSQL + '   ( 1 - (IFNULL(T.ITE_DESF02, 0) / 100) ) * ';
  strSQL := strSQL + '   ( 1 - (IFNULL(T.ITE_DESF03, 0) / 100) ) * ';
  strSQL := strSQL + '   ( 1 - (IFNULL(T.ITE_DESF04, 0) / 100) ) * ';
  strSQL := strSQL + '   ( 1 - (IFNULL(T.ITE_DESF05, 0) / 100) ) * ';
  strSQL := strSQL + '   ( 1 - (IFNULL(T.ITE_DESF06, 0) / 100) ) AS ITE_COMLIQ, ';

  strSQL := strSQL + ' @TIPABF := fGetTipoAbf("F", IF(FOR_CGCCPF = 1, "J", "F"),  FOR_I_E_S_, "", "", "", "", FOR_SIMPAU, FOR_MATREV, "", "", I.ITE_CODEMP), ';
  strSQL := strSQL + ' CASE';
  strSQL := strSQL + '   WHEN @TIPABF = "_ENT_PSI" THEN  ABF_IVA_ST_ENT_PSI ';
  strSQL := strSQL + '   WHEN @TIPABF = "_ENT_PES" THEN  ABF_IVA_ST_ENT_PES ';
  strSQL := strSQL + '   WHEN @TIPABF = "_ENT_PEF" THEN  ABF_IVA_ST_ENT_PEF ';
  strSQL := strSQL + '   WHEN @TIPABF = "_ENT_PEJ" THEN  ABF_IVA_ST_ENT_PEJ ';
  strSQL := strSQL + '   WHEN @TIPABF = "_ENT_PER" THEN  ABF_IVA_ST_ENT_PER ';
  strSQL := strSQL + '   WHEN @TIPABF = "_ENT_PSI" THEN  ABF_IVA_ST_ENT_PSI ';
  strSQL := strSQL + '   ELSE';
  strSQL := strSQL + '    ABF_IVA_ST_ENT_PEF';
  strSQL := strSQL + '  END AS ITE_IVA,';
  strSQL := strSQL + '  CAST(CONCAT(FOR_CODFOR, " - ", FOR_NOMFOR) AS CHAR(100)) AS FORNEC, ';
  strSQL := strSQL + '  TAB_NOMTAB AS NOMTAB, ';
  strSQL := strSQL + '  CAST(CONCAT(ABF_CODABF, "-", ABF_DESABF) AS CHAR(100))AS DESABF, ';
  strSQL := strSQL + '  CAST(NULL AS DECIMAL(12,4)) AS ITE_CUSREA, ';
  strSQL := strSQL + '  CAST(NULL AS DECIMAL(12,4)) AS ITE_VENDOL ';

  strSQL := strSQL + ' FROM                               ';
  strSQL := strSQL + '   TABDET T                         ';

  strSQL := strSQL + ' INNER JOIN ITEFOR F ';
  strSQL := strSQL + '     ON F.ITE_CODTAB = T.ITE_CODTAB ';
  strSQL := strSQL + '    AND F.ITE_CODITE = T.ITE_CODITE ';

  strSQL := strSQL + ' INNER JOIN TABPRE TB ON TB.TAB_CODTAB = T.ITE_CODTAB ';

  strSQL := strSQL + ' INNER JOIN ITEGER I                ';
  strSQL := strSQL + '     ON I.ITE_CODEMP = T.ITE_CODEMP ';
  strSQL := strSQL + '    AND I.ITE_CODITE = T.ITE_CODITE ';
  If Not blnTrocaTabela Then
    strSQL := strSQL + '    AND I.ITE_TABPR' + intTabPreVen.ToString + ' = T.ITE_CODTAB ';
  strSQL := strSQL + ' INNER JOIN CADITE C ON C.ITE_CODITE =  I.ITE_CODITE ';
  strSQL := strSQL + ' INNER JOIN CADFOR ON FOR_CODFOR = F.ITE_CODFOR ';
  strSQL := strSQL + ' INNER JOIN CADCID ON CID_CODCID = FOR_CODCID ';
  strSQL := strSQL + ' INNER JOIN DETCUS DC ON DC.DET_SEQDET = T.AUTOINCREM AND DC.DET_TABELA = ' + intTabPreVen.ToString ;

  If fCfgSis('TIPABF') = '2' Then
    strSQL := strSQL + '    INNER JOIN ABFICM ON ABF_CODABF = I.ITE_CODABF AND ABF_ESTADO = CID_ESTADO '
  Else
    strSQL := strSQL + '    INNER JOIN ABFICM ON ABF_CODABF = C.ITE_CODABF AND ABF_ESTADO = CID_ESTADO ';


  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   T.ITE_CODITE = :CODITE ';

  If Not fEmptyStr(strCodEmp) Then
    strSQL := strSQL + ' AND T.ITE_CODEMP = ' + QuotedStr(strCodEmp);

  If blnTrocaTabela Then
    strSQL := strSQL + ' AND  T.ITE_CODTAB = ' + '"' + qryIteGer.FieldByName('ITE_TABPR' + intTabPreVen.ToString).AsString + '"';

  Result := strSQL;
End;

Function TTabelasDoItem.fSQLTabDets(blnTrocaTabela: Boolean = False): String;
  Var
    intContador: Integer;
    strSQL: String;
Begin
  For intContador := 1 To 7 Do
    If VS_strTabPrc[intContador] = 'S' Then
    Begin
      If Not strSQL.IsEmpty Then
        strSQL := strSQL + ' UNION ALL ';

      strSQL := strSQL + fSQLTabDet(intContador, VS_strCodEmp, blnTrocaTabela);
    End;

  Result := strSQL;
End;

Function TTabelasDoItem.fCarregaPrecos(blnTrocaTabela: Boolean = False;  cdsTabDet: TZClient = nil): Boolean;
var strIndex: string;
Begin
  
  If blnCadTabelaPreco Then
  Begin
    If assigned(cdsDados) Then
      FreeAndNil(cdsDados);
    cdsDados := cdsTabDet;
    Result := True;
    strIndex  := cdsTabDet.IndexFieldNames + IIf(cdsTabDet.IndexFieldNames = '', '', ';') + 'TABELA' ;
    cdsTabDet.IndexFieldNames := strIndex;
  End
  Else
  Begin

    FInclusao := qryCadIte.State = dsInsert;
    // A carga (promocao, custo real) grava linhas: o gancho do cadastro so depois dela.
    Self.cdsDados.AfterPost := nil;

    Self.cdsDados.qryQuery.SQL.Text := fSQLTabDets(blnTrocaTabela);
    Self.cdsDados.qryQuery.ParamByName('CODITE').AsString := qryIteGer.FieldByName('ITE_CODITE').AsString;

    Result := Self.cdsDados.fLeDados('TTabelasDoItem.fCarregaPrecos') And fCarregaTabelas;
  End;

  If Result Then
  Begin
    If FInclusao Then
      Result := fCarregaTabelasInclusao;

    pFormataCampos;

    If Not FInclusao then
      fAjustaCustoReal;
  End;

  If Not FInclusao Then
    pPreencheValoresPromocao;

  Self.cdsDados.BeforePost := pBeforePost;

  Self.cdsDados.AfterPost := pAfterPostLinha;
  If FInclusao  Then
    Self.cdsDados.AfterPost := pAfterPost;

  If blnCadTabelaPreco Then
    Self.cdsDados.AfterPost := pAfterPostFormacaoDePreco;

End;

class procedure TTabelasDoItem.pFinalizaProcessoImportacao;
begin
  TTabelasDoItem.blnProcessoDeImportacao := False;
end;

procedure TTabelasDoItem.pFormataCampos;
Begin
  Self.cdsDados.pFormataDecimal('ITE_PRECOM', intDecUni);
  If blnCadTabelaPreco Then
  Begin
    Self.cdsDados.pFormataDecimal('CNV_PRECOM', intDecUni);
    Self.cdsDados.pFormataDecimal('CNV_VALFRE', intDecUni);
    Self.cdsDados.pFormataDecimal('CNV_OUTVAL', intDecUni);
    Self.cdsDados.pFormataDecimal('CNV_PREVEN', intDecUni);
    Self.cdsDados.pFormataDecimal('CNV_VENGIR', intDecUni);
    Self.cdsDados.pFormataDecimal('CNV_CUSREA', intDecUni);
    Self.cdsDados.pFormataDecimal('CNV_COMLIQ', intDecUni);
    Self.cdsDados.pFormataDecimal('CNV_PRECUS', intDecUni);
  End;

  Self.cdsDados.pFormataDecimal('ITE_PRECOM', intDecUni);
  Self.cdsDados.pFormataDecimal('ITE_COMLIQ', intDecUni);
  Self.cdsDados.pFormataDecimal('ITE_VALFRE', intDecUni);
  Self.cdsDados.pFormataDecimal('ITE_PRECUS', intDecUni);
  Self.cdsDados.pFormataDecimal('ITE_OUTVAL', intDecUni);
  Self.cdsDados.pFormataDecimal('ITE_CUSREA', intDecUni);
  Self.cdsDados.pFormataDecimal('ITE_PREVEN', intDecUni);
  Self.cdsDados.pFormataDecimal('ITE_VENDOL', intDecUni);

  Self.cdsDados.pFormataDecimal('ITE_MARPRO', intDecUni);
  Self.cdsDados.pFormataDecimal('ITE_VENPRO', intDecUni);
End;

class procedure TTabelasDoItem.pInciaProcessoImportacao(AImportacaoOpcMarPre: TopcMarPre);
begin
  TTabelasDoItem.blnProcessoDeImportacao := True;
  TTabelasDoItem.ImportacaoOpcMarPre := AImportacaoOpcMarPre;

end;

procedure TTabelasDoItem.pPreencheValoresPromocao;
  Var
    fltPreCus,
    fltPreVen,
    fltComVar,
    fltComAta,
    fltComDis,
    fltDesF07,
    fltQtdDis: Double;
    strCodPro,
    strComPro: String;
    blnParticiona,
    blnPromo: Boolean;
Begin
  If blnCadTabelaPreco Then
    Exit;
  Self.cdsDados.First;
  While not self.cdsDados.Eof Do
  Begin
    self.cdsDados.Edit;
    Self.cdsDados.FieldByName('ITE_MARPRO').AsFloat := 0;
    Self.cdsDados.FieldByName('ITE_VENPRO').AsFloat := 0;


    fRetornaPrecosPromocao(qryIteger.FieldByName('ITE_CODITE').AsString,
                           '',
                           VS_Date,
                           0,
                           0,
                           0,
                           0,
                           fltPreCus,
                           fltPreVen,
                           fltComVar,
                           fltComAta,
                           fltComDis,
                           fltQtdDis,
                           fltDesF07,
                           strComPro,
                           strCodPro,
                           blnParticiona,
                           blnPromo,
                           Self.cdsDados.FieldByName('TABELA').AsString,
                           '');
    If blnPromo Then
    Begin

      If fltPreVen > 0 Then
      Begin
        If fltPreCus = 0 Then
          fltPreCus :=  Self.cdsDados.FieldByName('ITE_PRECUS').AsFloat + Self.cdsDados.FieldByName('ITE_OUTVAL').AsFloat;

        Self.cdsDados.FieldByName('ITE_VENPRO').AsFloat := fltPreVen;


        Self.cdsDados.FieldByName('ITE_MARPRO').AsFloat :=  fCalculaPrecoVenda(2,
                                                                     fltPreCus,
                                                                     fltPreVen,
                                                                     0,
                                                                     Self.cdsDados.FieldByName('ITE_ICMSAI').AsFloat,
                                                                     Self.cdsDados.FieldByName('ITE_IMPFED').AsFloat,
                                                                     Self.cdsDados.FieldByName('ITE_DESOPE').AsFloat,
                                                                     Self.cdsDados.FieldByName('ITE_COMTBL').AsFloat);
      End Else
      begin
        Self.cdsDados.FieldByName('ITE_MARPRO').AsFloat := 0;
        Self.cdsDados.FieldByName('ITE_VENPRO').AsFloat := 0;
      End;

    End;
    self.cdsDados.Post;
    self.cdsDados.Next;
  End;
End;

procedure TTabelasDoItem.pRecalculaTodasTabelas(strIncPis: String);
begin
 Self.cdsDados.First;
 If strIncPis = '' Then
   strIncPis := 'N';
 blnAlterandoIncidePis := Self.cdsDados.FieldByName('ITE_INCPIS').AsString <> strIncPis;
 While not Self.cdsDados.Eof Do
 begin
   self.cdsDados.edit;
   Self.cdsDados.FieldByName('ITE_INCPIS').AsString := strIncPis;
   self.cdsDados.Post;
   self.cdsDados.Next;
 End;
 blnAlterandoIncidePis := False;

  {}
end;

procedure TTabelasDoItem.pReplicaCNV(fltCnv: Double);
begin
  Self.cdsDados.First;
  blnAlterandoCnv := True;
  While not Self.cdsDados.Eof Do
  Begin
    Self.cdsDados.Edit;
    Self.cdsDados.FieldByName('ITE_CNVCUS').AsFloat := fltCnv;
    strCampoFocado := 'ITE_PRECOM';
//    Self.cdsDados.FieldByName('CNV_PRECOM').AsFloat := Self.cdsDados.FieldByName('ITE_PRECOM').AsFloat / fltCnv;
    Self.cdsDados.Post;
    Self.cdsDados.Next;
  End;
  blnAlterandoCnv := False;
end;

function TTabelasDoItem.fEditaTabelaItens: Boolean;
begin
   result := False;
   If (Not fEmptyStr(cdsTabelas.FieldByName('TABELA').AsString)) Then
     If Self.cdsDados.Locate('TABELA', cdsTabelas.FieldByName('TABELA').AsString, []) Then
       Result := True;
End;

Procedure TTabelasDoItem.pAdicionaTabDetInclusao();
var LastRecNo: Integer;
Begin
  If Not FInclusao Then
    Exit;

  Try
    self.cdsDados.DisableControls;

    cdsTabelas.IndexFieldNames := 'CODTAB';
    cdsTabelas.First;
    While Not cdsTabelas.Eof Do
    Begin
      LastRecNo := cdsTabelas.RecNo;
      If fEditaTabelaItens Then
      Begin
        Self.cdsDados.Edit;

      End Else
      Begin
        self.cdsDados.Append;
        Self.cdsDados.FieldByName('TABELA').AsString     := cdsTabelas.FieldByName('TABELA').AsString;
        Self.cdsDados.FieldByName('ITE_PREDOL').AsString := 'N';
        Self.cdsDados.FieldByName('ITE_CODEMP').AsString := VS_strCodEmp;
      End;

      Self.cdsDados.FieldByName('ITE_CODTAB').AsString := cdsTabelas.FieldByName('CODTAB').AsString;
      Self.cdsDados.FieldByName('ITE_CODFOR').AsString := cdsTabelas.FieldByName('CODFOR').AsString;

      self.cdsDados.Post;
      If  cdsTabelas.RecNo <> LastRecNo Then
        cdsTabelas.RecNo := LastRecNo;

      cdsTabelas.Next;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TTabelasDoItem.pAdicionaTabDetInclusao]');
    End;
  End;

  Self.cdsDados.EnableControls;
End;

Function TTabelasDoItem.fAjustaCustoReal: Boolean;
begin
  Result := TfrmGravando.fExecuta(fAjustaCustoRealPrg, frmGravando, 'Ajustando Custo Real...');
End;

function TTabelasDoItem.fAjustaCustoRealPrg(prgProgresso: TCXProgressBar): Boolean;
  Var
    fltDolar: Double;
    AfterPostBkp : TDataSetNotifyEvent;
    BeforePostBkp : TDataSetNotifyEvent;
Begin
  Self.cdsDados.DisableControls;
  AfterPostBkp := self.cdsDados.AfterPost;
  BeforePostBkp := self.cdsDados.BeforePost;


  Try

    Try

      If blnCotDor Then
        fltDolar := fGetUltimaCotacaoDolarVenda
      Else
        fltDolar := 0;


      prgProgresso.Properties.Max := Self.cdsDados.RecordCount -1;

      While Not Self.cdsDados.Eof Do
      Begin
        self.cdsDados.edit;

      Self.cdsDados.FieldByName('ITE_CUSREA').AsFloat :=
          untfuncoesSimples.fCalculaCustoReal(Self.cdsDados.FieldByName('ITE_PRECUS').AsFloat,
                                              Self.cdsDados.FieldByName('ITE_ICMSAI').AsFloat,
                                              Self.cdsDados.FieldByName('ITE_IMPFED').AsFloat,
                                              Self.cdsDados.FieldByName('ITE_DESOPE').AsFloat,
                                              Self.cdsDados.FieldByName('ITE_OUTVAL').AsFloat);


        If blnCotDor And (fltDolar > 0) Then
          Self.cdsDados.FieldByName('ITE_VENDOL').AsFloat := RoundTo(Self.cdsDados.FieldByName('ITE_PREVEN').AsFloat / fltDolar, -intDecUni)
        Else
          Self.cdsDados.FieldByName('ITE_VENDOL').Clear;

        self.cdsDados.Post;


        self.cdsDados.Next;

        prgProgresso.Position := Self.cdsDados.RecNo;
        Application.ProcessMessages;
      End;
    Except
      on E: Exception do
        pMensagensErro(e.message, 'TTabelasDoItem.fAjustaCustoRealPrg');
    End;

  Finally
    self.cdsDados.AfterPost := AfterPostBkp;
    self.cdsDados.BeforePost := BeforePostBkp;
    self.cdsDados.EnableControls;
  End;
  Result := True;
End;

Procedure TTabelasDoItem.pAtualizaPreco(fltMargem: Double);
Begin
  If Self.cdsDados.State In dsEditModes Then
  Begin

    Self.cdsDados.FieldByName('ITE_PREVEN').AsFloat := fCalculaPrecoVenda(1,
                                             Self.cdsDados.FieldByName('ITE_PRECUS').AsFloat + Self.cdsDados.FieldByName('ITE_OUTVAL').AsFloat,
                                             Self.cdsDados.FieldByName('ITE_PREVEN').AsFloat,
                                             fltMargem,
                                             Self.cdsDados.FieldByName('ITE_ICMSAI').AsFloat,
                                             Self.cdsDados.FieldByName('ITE_IMPFED').AsFloat,
                                             Self.cdsDados.FieldByName('ITE_DESOPE').AsFloat,
                                             Self.cdsDados.FieldByName('ITE_COMTBL').AsFloat);

  End;
End;

Procedure TTabelasDoItem.pAtualizaMargem(fltPreco: Double);
Begin
  If Self.cdsDados.State In dsEditModes Then
  Begin

    Self.cdsDados.FieldByName('ITE_MARBRU').AsFloat := fCalculaPrecoVenda(2,
                                             Self.cdsDados.FieldByName('ITE_PRECUS').AsFloat +  Self.cdsDados.FieldByName('ITE_OUTVAL').AsFloat,
                                             fltPreco,
                                             Self.cdsDados.FieldByName('ITE_MARBRU').AsFloat,
                                             Self.cdsDados.FieldByName('ITE_ICMSAI').AsFloat,
                                             Self.cdsDados.FieldByName('ITE_IMPFED').AsFloat,
                                             Self.cdsDados.FieldByName('ITE_DESOPE').AsFloat,
                                             Self.cdsDados.FieldByName('ITE_COMTBL').AsFloat);
  End;
End;

Procedure TTabelasDoItem.pAtualizaMargemPreco(fltComissao: Double);
  Var
    strCampo: String;
    intCalculo: Integer;
Begin
  If Self.cdsDados.State In dsEditModes Then
  Begin
    If FopcMarPre = opcPrecoVenda Then
    Begin
      intCalculo := 1;
      strCampo   := 'ITE_PREVEN';
    End Else
    Begin
      intCalculo := 2;
      strCampo   := 'ITE_MARBRU';
    End;

    Self.cdsDados.FieldByName(strCampo).AsFloat := fCalculaPrecoVenda(intCalculo,
                                             Self.cdsDados.FieldByName('ITE_PRECUS').AsFloat + Self.cdsDados.FieldByName('ITE_OUTVAL').AsFloat,
                                             Self.cdsDados.FieldByName('ITE_PREVEN').AsFloat,
                                             Self.cdsDados.FieldByName('ITE_MARBRU').AsFloat,
                                             Self.cdsDados.FieldByName('ITE_ICMSAI').AsFloat,
                                             Self.cdsDados.FieldByName('ITE_IMPFED').AsFloat,
                                             Self.cdsDados.FieldByName('ITE_DESOPE').AsFloat,
                                             fltComissao);
  End;
End;

function TTabelasDoItem.fValidaFornecedor: Boolean;
var StrErro: String;
begin
  cdsTabelas.First;
  Result := True;
  strErro:= '';
  If dbeCodFor.Field.AsString = '' Then
    Exit;

  While not cdsTabelas.Eof Do
  Begin
    If cdsTabelas.FieldByName('CODTAB').AsString <> '' Then
      If strCfgTBOFPC[cdsTabelas.FieldByName('TABELA').AsInteger] = 'S' Then
        If cdsTabelas.FieldByName('CODFOR').AsString <> dbeCodFor.Field.AsString Then
        Begin
          If StrErro = '' Then
            StrErro := 'Devido a configuração CFG_TBOFPC(Obrigar que a tabela de preço do fornecedor ativa, ' + #13 +
                       'ou que será ativada para o custo, tenha o mesmo fornecedor na tabela de preço, do fornecedor principal). ' + #13;
          strErro :=  strErro + #13 + 'Fornecedor da Tabela ' + cdsTabelas.FieldByName('TABELA').AsString + ': ' +
                      cdsTabelas.FieldByName('CODFOR').AsString + ' - ' + cdsTabelas.FieldByName('NOMFOR').AsString;
        End;
    cdsTabelas.Next;
  End;

  Result := strErro = '';

  If Not Result Then
  begin
    strErro := strErro + #13 + 'Diferente do Principal: ' + dbeCodFor.Field.AsString + ' - ' + fRetNomFornecedor(dbeCodFor.Field.AsString) + '.';
    strErro := strErro + #13 + 'Por favor verifique!';
    pMensagemOk(strErro, 600,300);
  End;
end;

function TTabelasDoItem.fValidaMargem(fltMargem, fltComissao: Double): Boolean;
begin
  Result := Not ((fltMargem + fltComissao +
                  Self.cdsDados.FieldByName('ITE_ICMSAI').AsFloat +
                  Self.cdsDados.FieldByName('ITE_IMPFED').AsFloat +
                  Self.cdsDados.FieldByName('ITE_DESOPE').AsFloat) > 100);

  If Not Result Then
    pMensagemOk(MSG_VALIDACAO_MARGEM);
End;

function TTabelasDoItem.fRetPrecoCusto(dataSet: TDataSet; strNov: String = ''): Double;
  Var
    blnUtilizarConversorDeMoeda: Boolean;
begin
  cpcParams.curPreCom := dataSet.FieldByName('ITE_PRECOM' + strNov).AsFloat;
  cpcParams.curDesF01 := dataSet.FieldByName('ITE_DESF01' + strNov).AsFloat;
  cpcParams.curDesF02 := dataSet.FieldByName('ITE_DESF02' + strNov).AsFloat;
  cpcParams.curDesF03 := dataSet.FieldByName('ITE_DESF03' + strNov).AsFloat;
  cpcParams.curDesF04 := dataSet.FieldByName('ITE_DESF04' + strNov).AsFloat;
  cpcParams.curDesF05 := dataSet.FieldByName('ITE_DESF05' + strNov).AsFloat;
  cpcParams.curDesF06 := dataSet.FieldByName('ITE_DESF06' + strNov).AsFloat;
  cpcParams.curICMSEnt:= dataSet.FieldByName('ITE_ICMENT' + strNov).AsFloat;
  cpcParams.curIPIEnt := dataSet.FieldByName('ITE_IPIENT' + strNov).AsFloat;
  cpcParams.curFrete  := dataSet.FieldByName('ITE_FREENT' + strNov).AsFloat;
  cpcParams.curAcrFin := dataSet.FieldByName('ITE_ACRFIN' + strNov).AsFloat;
  cpcParams.curSubsti := dataSet.FieldByName('ITE_SUBSTI' + strNov).AsFloat;
  cpcParams.curValFre := dataSet.FieldByName('ITE_VALFRE' + strNov).AsFloat;
  cpcParams.curDesAdb := dataSet.FieldByName('ITE_DESADB' + strNov).AsFloat;
  cpcParams.curSubFed := dataSet.FieldByName('ITE_SUBFED' + strNov).AsFloat;

  if blnSufram and (strFrmCus = '4') then
  begin
    cpcParams.curTCIFCu := dataSet.FieldByName('ITE_TCIFCU' + strNov).AsFloat;
    cpcParams.curTSCust := dataSet.FieldByName('ITE_TSCUST' + strNov).AsFloat;
    cpcParams.curDePiCo := dataSet.FieldByName('ITE_DEPICO' + strNov).AsFloat;
    cpcParams.curDeICMS := dataSet.FieldByName('ITE_DEICMS' + strNov).AsFloat;
    cpcParams.curFatReg := dataSet.FieldByName('ITE_FATREG' + strNov).AsFloat;
  end
  else
  begin
    cpcParams.curTCIFCu := 0;
    cpcParams.curTSCust := 0;
    cpcParams.curDePiCo := 0;
    cpcParams.curDeICMS := 0;
    cpcParams.curFatReg := 0;
  end;

  blnUtilizarConversorDeMoeda := dataSet.FieldByName('ITE_PREDOL' + strNov).AsString = 'S';

  Result := cpcParams.fCalculaPrecoCusto(blnUtilizarConversorDeMoeda);
end;

function TTabelasDoItem.fCarregaInfTabela(AstrCodTab: String; var strDescricaoTabela: String; var strFornecedorTabela: String; var strCodForTabela: String): Boolean;
var qryConsulta: TUniQuery;
begin
  strDescricaoTabela := '';
  strFornecedorTabela := '';
  strFornecedorTabela := '';
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT * FROM TABPRE WHERE TAB_CODTAB = "'+AstrCodTab+'"');
    qryConsulta.Open;
    Result := Not qryConsulta.IsEmpty;
    If Result Then
    begin
      strDescricaoTabela  := qryConsulta.FieldByName('TAB_NOMTAB').AsString;
      strCodForTabela := qryConsulta.FieldByName('TAB_CODFOR').AsString;
      strFornecedorTabela := strCodForTabela + ' - ' + fRetNomFornecedor(qryConsulta.FieldByName('TAB_CODFOR').AsString);
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

Procedure TTabelasDoItem.pBeforePost(dataSet: TDataSet);
  Var
    strCampo: String;
    intCalculo: Integer;
    fltDolar: Double;
    CalculaComposicaoCusto: TCalculaComposicaoCusto;
    strDescricaoTabela,
    strFornecedorTabela,
    strCodForTabela,
    strCodAbf: String;
    blnIncPis: Boolean;

Begin
  If (FInclusao) And (strTipAbf = '1') And Assigned(OnSetaCodAbf) And
     (qryCadIte.FieldByName('ITE_CODABF').AsString <> dataSet.FieldByName('ITE_CODABF').AsString) Then
  Begin
    strCodAbf :=  DataSet.FieldByName('ITE_CODABF').AsString;
    If Not fEmptyStr(strCodAbf) then
      strCodAbf := fStrZero(strCodAbf, 3) ;
    OnSetaCodAbf(strCodAbf, (dataSet.FieldByName('TABELA').AsInteger <> fRetPrimeiraTabPrecoAtiva));
    DataSet.FieldByName('ITE_CODABF').AsString := strCodAbf;
  End;
  If blnCadTabelaPreco then
  Begin
    If strCampoFocado = 'CNV_OUTVAL' Then
      DataSet.FieldByName('ITE_OUTVAL').AsFloat := DataSet.FieldByName('CNV_OUTVAL').AsFloat *
                                                   DataSet.FieldByName('ITE_CNVCUS').AsFloat;

    If strCampoFocado = 'CNV_PRECOM' Then
      DataSet.FieldByName('ITE_PRECOM').AsFloat := DataSet.FieldByName('CNV_PRECOM').AsFloat *
                                                   DataSet.FieldByName('ITE_CNVCUS').AsFloat;

    If strCampoFocado = 'CNV_VALFRE' Then
      DataSet.FieldByName('ITE_VALFRE').AsFloat := DataSet.FieldByName('CNV_VALFRE').AsFloat *
                                                   DataSet.FieldByName('ITE_CNVCUS').AsFloat;

    If strCampoFocado = 'ITE_PRECOM' Then
      DataSet.FieldByName('CNV_PRECOM').AsFloat := DataSet.FieldByName('ITE_PRECOM').AsFloat /
                                                   DataSet.FieldByName('ITE_CNVCUS').AsFloat;
  End;

  If (FInclusao) Then
  Begin
    If fCarregaInfTabela(Self.cdsDados.FieldByName('ITE_CODTAB').Value, strDescricaoTabela, strFornecedorTabela, strCodForTabela) Then
    begin
      If strDescricaoTabela <> Self.cdsDados.FieldByName('NOMTAB').AsString Then
        Self.cdsDados.FieldByName('NOMTAB').Value := strDescricaoTabela;
      If strFornecedorTabela <> Self.cdsDados.FieldByName('FORNEC').AsString Then
        Self.cdsDados.FieldByName('FORNEC').Value := strFornecedorTabela;
      If strCodForTabela <> Self.cdsDados.FieldByName('ITE_CODFOR').AsString Then
        Self.cdsDados.FieldByName('ITE_CODFOR').AsString := strCodForTabela;
    End
    Else
    Begin
      Self.cdsDados.FieldByName('FORNEC').AsString := '';
      Self.cdsDados.FieldByName('NOMTAB').AsString := '';
      Self.cdsDados.FieldByName('ITE_CODFOR').AsString := '';
    End;
  End;

  If blnCotDor Then
    fltDolar := fGetUltimaCotacaoDolarVenda
  Else
    fltDolar := 0;

  dataSet.FieldByName('ITE_COMLIQ').AsFloat :=
  untfuncoesSimples.fCalculaPrecoCompraLiq(dataSet.FieldByName('ITE_PRECOM').AsFloat,
                                           dataSet.FieldByName('ITE_DESF01').AsFloat,
                                           dataSet.FieldByName('ITE_DESF02').AsFloat,
                                           dataSet.FieldByName('ITE_DESF03').AsFloat,
                                           dataSet.FieldByName('ITE_DESF04').AsFloat,
                                           dataSet.FieldByName('ITE_DESF05').AsFloat,
                                           dataSet.FieldByName('ITE_DESF06').AsFloat,
                                           intDecUni,
                                           dataSet.FieldByName('ITE_PREDOL').AsString = 'S');
  If Assigned(dbeIncPis) Then
    blnIncPis := dbeIncPis.Text = 'S'
  Else
    blnIncPis := dataSet.FieldByName('ITE_INCPIS').AsString = 'S';
  If  (blnAlterandoIncidePis) And (Not blnIncPis) And (Not FInclusao) Then
  begin
    dataSet.FieldByName('ITE_IMPFED').AsFloat := 0;
    dataSet.FieldByName('ITE_SUBFED').AsFloat := 0;
  End
  Else If (not blnCadTabelaPreco) And ((blnAlterandoIncidePis) Or (FInclusao)) Then
  begin
    CalculaComposicaoCusto := TCalculaComposicaoCusto.fCalcula(blnIncPis,
                                                               dataSet.FieldByName('ITE_COMLIQ').AsFloat,
                                                               dataSet.FieldByName('ITE_CODFOR').AsString,
                                                               dataSet.FieldByName('ITE_CODABF').AsString,
                                                               dataSet.FieldByName('ITE_IPIENT').AsFloat,
                                                               cpcParams,
                                                               dataSet.FieldByName('TABELA').AsString);
    Try
      If CalculaComposicaoCusto.BlnSemST then
      Begin
        DataSet.FieldByName('ITE_ICMENT').AsFloat := CalculaComposicaoCusto.AliquotaICMSEnt;
        DataSet.FieldByName('ITE_ICMSAI').AsFloat := CalculaComposicaoCusto.AliquotaICMSSai;
        DataSet.FieldByName('ITE_SUBSTI').AsFloat := 0;
      End
      Else
      begin
        DataSet.FieldByName('ITE_ICMENT').AsFloat := 0;
        DataSet.FieldByName('ITE_ICMSAI').AsFloat := 0;
        DataSet.FieldByName('ITE_SUBSTI').AsFloat := CalculaComposicaoCusto.AliquotaST;
      End;
      If Assigned(DataSet.FindField('ITE_IVA')) Then
        dataSet.FieldByName('ITE_IVA').AsFloat := CalculaComposicaoCusto.IVAFornecedor;
      If FInclusao or blnAlterandoIncidePis  then
      Begin
        If (blnAlterandoIncidePis) Or (FInclusao) Then
        Begin
          dataSet.FieldByName('ITE_IMPFED').AsFloat := CalculaComposicaoCusto.ImpFed;
          dataSet.FieldByName('ITE_SUBFED').AsFloat := CalculaComposicaoCusto.SubFed;
        End;

        If FInclusao Then
        Begin
          dataSet.FieldByName('ITE_DESOPE').AsFloat := CalculaComposicaoCusto.DesOpe;
          dataSet.FieldByName('ITE_OUTVAL').AsFloat := CalculaComposicaoCusto.OutVal;
        End;
      End;

    Finally
      FreeAndNil(CalculaComposicaoCusto);
    End;
  End;

  dataSet.FieldByName('ITE_PRECUS').AsFloat := fRetPrecoCusto(dataSet);
  If blnCadTabelaPreco then
    dataSet.FieldByName('CNV_PRECUS').AsFloat := RoundTo(dataSet.FieldByName('ITE_PRECUS').AsFloat /
                                                         DataSet.FieldByName('ITE_CNVCUS').AsFloat, - intDecUni);


  dataSet.FieldByName('ITE_CUSREA').AsFloat :=
   untfuncoesSimples.fCalculaCustoReal(Self.cdsDados.FieldByName('ITE_PRECUS').AsFloat,
                                       Self.cdsDados.FieldByName('ITE_ICMSAI').AsFloat,
                                       Self.cdsDados.FieldByName('ITE_IMPFED').AsFloat,
                                       Self.cdsDados.FieldByName('ITE_DESOPE').AsFloat,
                                       Self.cdsDados.FieldByName('ITE_OUTVAL').AsFloat);

  If blnCotDor And (fltDolar > 0) Then
   dataSet.FieldByName('ITE_VENDOL').AsFloat := RoundTo(dataSet.FieldByName('ITE_PREVEN').AsFloat / fltDolar, -intDecUni)
  Else
    dataSet.FieldByName('ITE_VENDOL').Clear;

  If TTabelasDoItem.blnProcessoDeImportacao Then
  Begin
    If TTabelasDoItem.ImportacaoOpcMarPre =  opcPrecoVenda Then
    Begin
      intCalculo := 1;
      strCampo   := 'ITE_PREVEN';
    End Else
    Begin
      intCalculo := 2;
      strCampo   := 'ITE_MARBRU';
      If blnCadTabelaPreco Then
        If blnAlterandoCnv Then
            dataSet.FieldByName('ITE_PREVEN').AsFloat := dataSet.FieldByName('CNV_PREVEN').AsFloat *
                                                                 dataSet.FieldByName('ITE_CNVCUS').AsFloat;
    End;
  End

  Else
  If SameText(strCampoFocado, 'ITE_MARBRU') Or
     SameText(strCampoFocado, 'ITE_COMTBL') Then
  Begin
    intCalculo := 1;
    strCampo   := 'ITE_PREVEN';
  End

  Else If (SameText(strCampoFocado, 'ITE_PREVEN')) Or (SameText(strCampoFocado, 'CNV_PREVEN')) Then
  Begin
    intCalculo := 2;
    strCampo   := 'ITE_MARBRU';
    If blnCadTabelaPreco Then
    If (SameText(strCampoFocado, 'CNV_PREVEN')) Then
        dataSet.FieldByName('ITE_PREVEN').AsFloat := dataSet.FieldByName('CNV_PREVEN').AsFloat *
                                                             dataSet.FieldByName('ITE_CNVCUS').AsFloat;
  End

  Else If FopcMarPre = opcPrecoVenda Then
  Begin
    intCalculo := 1;
    strCampo   := 'ITE_PREVEN';
  End Else
  Begin
    intCalculo := 2;
    strCampo   := 'ITE_MARBRU';
    If blnCadTabelaPreco Then
      If blnAlterandoCnv Then
          dataSet.FieldByName('ITE_PREVEN').AsFloat := dataSet.FieldByName('CNV_PREVEN').AsFloat *
                                                               dataSet.FieldByName('ITE_CNVCUS').AsFloat;
  End;



  dataSet.FieldByName(strCampo).AsFloat := fCalculaPrecoVenda(intCalculo,
                                                              dataSet.FieldByName('ITE_PRECUS').AsFloat + dataSet.FieldByName('ITE_OUTVAL').AsFloat,
                                                              dataSet.FieldByName('ITE_PREVEN').AsFloat,
                                                              dataSet.FieldByName('ITE_MARBRU').AsFloat,
                                                              dataSet.FieldByName('ITE_ICMSAI').AsFloat,
                                                              dataSet.FieldByName('ITE_IMPFED').AsFloat,
                                                              dataSet.FieldByName('ITE_DESOPE').AsFloat,
                                                              dataSet.FieldByName('ITE_COMTBL').AsFloat, '', '', intDecUni);

  If (strCampo = 'ITE_MARBRU') And (dataSet.FieldByName('ITE_PREVEN').AsFloat = 0) Then
    dataSet.FieldByName('ITE_PREVEN').AsFloat := fCalculaPrecoVenda(1,
                                                                    dataSet.FieldByName('ITE_PRECUS').AsFloat + dataSet.FieldByName('ITE_OUTVAL').AsFloat,
                                                                    dataSet.FieldByName('ITE_PREVEN').AsFloat,
                                                                    dataSet.FieldByName('ITE_MARBRU').AsFloat,
                                                                    dataSet.FieldByName('ITE_ICMSAI').AsFloat,
                                                                    dataSet.FieldByName('ITE_IMPFED').AsFloat,
                                                                    dataSet.FieldByName('ITE_DESOPE').AsFloat,
                                                                    dataSet.FieldByName('ITE_COMTBL').AsFloat);
  If blnCadTabelaPreco Then
  Begin
      If dataSet.FieldByName('ITE_PREREV').AsFloat > 0 Then
        dataSet.FieldByName('ITE_DESREV').AsFloat :=  RoundTo(((dataSet.FieldByName('ITE_PREREV').AsFloat
           - dataSet.FieldByName('ITE_PREVEN').AsFloat) / dataSet.FieldByName('ITE_PREREV').AsFloat) * 100, -2);

    If dataSet.FieldByName('ITE_MARGIR').AsFloat > 0 Then
      dataSet.FieldByName('ITE_VENGIR').AsFloat := fCalculaPrecoVenda(1,
                                                                      dataSet.FieldByName('ITE_PRECUS').AsFloat + dataSet.FieldByName('ITE_OUTVAL').AsFloat,
                                                                      dataSet.FieldByName('ITE_PREVEN').AsFloat,
                                                                      dataSet.FieldByName('ITE_MARGIR').AsFloat,
                                                                      dataSet.FieldByName('ITE_ICMSAI').AsFloat,
                                                                      dataSet.FieldByName('ITE_IMPFED').AsFloat,
                                                                      dataSet.FieldByName('ITE_DESOPE').AsFloat,
                                                                      dataSet.FieldByName('ITE_COMTBL').AsFloat);

    If blnAlterandoCnv and (strCampo = 'ITE_MARBRU') Then
      dataSet.FieldByName('ITE_PREVEN').AsFloat := dataSet.FieldByName('CNV_PREVEN').AsFloat * dataSet.FieldByName('ITE_CNVCUS').AsFloat
    Else
      dataSet.FieldByName('CNV_PREVEN').AsFloat := dataSet.FieldByName('ITE_PREVEN').AsFloat / dataSet.FieldByName('ITE_CNVCUS').AsFloat;
    dataSet.FieldByName('CNV_CUSREA').AsFloat := RoundTo(dataSet.FieldByName('ITE_CUSREA').AsFloat / dataSet.FieldByName('ITE_CNVCUS').AsFloat, -intDecUni);
    dataSet.FieldByName('CNV_COMLIQ').AsFloat := RoundTo(dataSet.FieldByName('ITE_COMLIQ').AsFloat / dataSet.FieldByName('ITE_CNVCUS').AsFloat, -intDecUni);
    dataSet.FieldByName('CNV_VENGIR').AsFloat := RoundTo(dataSet.FieldByName('ITE_VENGIR').AsFloat / dataSet.FieldByName('ITE_CNVCUS').AsFloat, -intDecUni);
  End;

End;

Procedure TTabelasDoItem.pAfterPost(dataSet: TDataSet);
 Const
   STR_CAMPOS_CUSTO =
   'ITE_CODABF,ITE_PRECOM,ITE_DESF01,ITE_DESF02,ITE_DESF03,ITE_DESF04,ITE_DESF05,ITE_DESF06,' +
   'ITE_ICMENT,ITE_SUBFED,ITE_IPIENT,ITE_FREENT,ITE_VALFRE,ITE_ACRFIN,ITE_SUBSTI,' +
   'ITE_DESADB,ITE_PRECUS,ITE_OUTVAL,ITE_ICMSAI,ITE_IMPFED,ITE_DESOPE,ITE_TCIFCU,' +
   'ITE_TSCUST,ITE_DEPICO,ITE_DEICMS,ITE_FATREG,ITE_PREDOL';

  Var
    intRecNo,
    intContador: Integer;
Begin
  Self.cdsDados.AfterPost := Nil;
  Self.cdsDados.DisableControls;
  intRecNo := Self.cdsDados.RecNo;

  For intContador := 0 To FCopyTabDet.FieldCount - 1 Do
    if Self.cdsDados.Fields.FindField(FCopyTabDet.Fields[intContador].FieldName) <> nil then
      FCopyTabDet.Fields[intContador].Value := Self.cdsDados.FieldByName(FCopyTabDet.Fields[intContador].FieldName).Value;

  self.cdsDados.First;
  While Not Self.cdsDados.Eof Do
  Begin
    If cdsTabelas.Locate('TABELA', Self.cdsDados.FieldByName('TABELA').AsString, []) Then
      If cdsTabelas.FieldByName('CODTAB').AsString  <> Self.cdsDados.FieldByName('ITE_CODTAB').AsString Then
        pPreencheTabela(nil, Self.cdsDados.FieldByName('ITE_CODTAB').AsString);

    If FCopyTabDet.FieldByName('ITE_CODTAB').AsString = Self.cdsDados.FieldByName('ITE_CODTAB').AsString Then
    Begin
      self.cdsDados.edit;

      For intContador := 0 To FCopyTabDet.FieldCount - 1 Do
        If Pos(FCopyTabDet.Fields[intContador].FieldName, STR_CAMPOS_CUSTO) > 0 Then
        begin
            If FCopyTabDet.Fields[intContador].AsString = '' then
              Continue;
            Self.cdsDados.FieldByName(FCopyTabDet.Fields[intContador].FieldName).Value := FCopyTabDet.Fields[intContador].Value;
        End;

      self.cdsDados.Post;
    End;

    self.cdsDados.Next;
  End;

  Self.cdsDados.RecNo := intRecNo;
  Self.cdsDados.EnableControls;
  Self.cdsDados.AfterPost := pAfterPost;

  If Assigned(pAfterPostLinhaExterno) Then
    pAfterPostLinhaExterno(Self);
End;

Procedure TTabelasDoItem.pAfterPostLinha(dataSet: TDataSet);
Begin
  If Assigned(pAfterPostLinhaExterno) Then
    pAfterPostLinhaExterno(Self);
End;

Procedure TTabelasDoItem.pAfterPostFormacaoDePreco(dataSet: TDataSet);
 Const
   STR_CAMPOS_CUSTO =
   '_ITE_PRECOM,ITE_DESF01,ITE_DESF02,ITE_DESF03,ITE_DESF04,ITE_DESF05,ITE_DESF06,' +
   'ITE_ICMENT,ITE_IPIENT,ITE_FREENT,ITE_VALFRE,ITE_ACRFIN,ITE_SUBSTI,' +
   'ITE_DESADB,ITE_PRECUS,ITE_TCIFCU,ITE_SUBFED,ITE_IMPFED,' +
   'ITE_TSCUST,ITE_DEPICO,ITE_DEICMS,ITE_FATREG,ITE_PREDOL,CNV_PRECOM,CNV_VALFRE';

  Var
    intRecNo,
    AValue: Variant;
    ACodite: String;
    intQtdEncontrado: integer;
Begin
  If Pos(strCampoFocado, STR_CAMPOS_CUSTO) = 0 Then
    Exit;

  If AlteracaoGlobalEmpresa Then
    If Self.CdsDados.FieldByName('ITE_CODITE').Value <>  strCodIteFocado Then
      Exit;

  Self.cdsDados.AfterPost := Nil;
  Self.cdsDados.DisableControls;
  intRecNo := Self.cdsDados.RecNo;


  AValue := Self.CdsDados.FieldByName(strCampoFocado).Value;
  If AlteracaoGlobalEmpresa Then
    ACodite := strCodIteFocado
  Else
    ACodite  := Self.CdsDados.FieldByName('ITE_CODITE').Value;


  self.cdsDados.First;
  intQtdEncontrado := 0;
   
  While Not Self.cdsDados.Eof Do
  Begin
    If ACodite = Self.CdsDados.FieldByName('ITE_CODITE').AsString Then
    Begin
      Self.cdsDados.Edit;
      Self.CdsDados.FieldByName(strCampoFocado).Value := AValue;
      Self.cdsDados.Post;
      intQtdEncontrado := intQtdEncontrado + 1;
    End;
    Self.cdsDados.Next;
    If intQtdEncontrado = qtdTabelasAtivas Then
      Break;
  End;

  Self.cdsDados.RecNo := intRecNo;
  Self.cdsDados.EnableControls;
  Self.cdsDados.AfterPost := pAfterPostFormacaoDePreco;
End;


function TTabelasDoItem.fSalvaDados: Boolean;
Begin
  Result := True;
  Try
    Self.cdsDados.DisableControls;

    Try
      Self.cdsDados.Filter   := 'ITE_CODITE IS NULL';
      Self.cdsDados.Filtered := True;
      self.cdsDados.First;

      While Not Self.cdsDados.IsEmpty Do
      Begin
        self.cdsDados.edit;
        Self.cdsDados.FieldByName('ITE_CODITE').AsString := qryCadIte.FieldByName('ITE_CODITE').AsString;

       {
        If strTipAbf = '2' Then
          Self.cdsDados.FieldByName('ITE_CODABF').Value := qryIteGer.FieldByName('ITE_CODABF').Value
        Else
          Self.cdsDados.FieldByName('ITE_CODABF').Value := qryCadIte.FieldByName('ITE_CODABF').Value;
        }

        If strTPABPC = '2' Then
        Begin
          Self.cdsDados.FieldByName('ITE_ABFIPI').Value := qryIteGer.FieldByName('ITE_ABFIPI').Value;
          Self.cdsDados.FieldByName('ITE_ABFCOF').Value := qryIteGer.FieldByName('ITE_ABFCOF').Value;
          Self.cdsDados.FieldByName('ITE_ABFPIS').Value := qryIteGer.FieldByName('ITE_ABFPIS').Value;
        End Else
        Begin
          Self.cdsDados.FieldByName('ITE_ABFIPI').Value := qryCadIte.FieldByName('ITE_ABFIPI').Value;
          Self.cdsDados.FieldByName('ITE_ABFCOF').Value := qryCadIte.FieldByName('ITE_ABFCOF').Value;
          Self.cdsDados.FieldByName('ITE_ABFPIS').Value := qryCadIte.FieldByName('ITE_ABFPIS').Value;
        End;

        Self.cdsDados.FieldByName('ITE_EXCIPI').Value := qryCadIte.FieldByName('ITE_EXCIPI').AsString;

        self.cdsDados.Post;
      End; {While Not Self.cdsDados.Eof Do}

      Self.cdsDados.Filtered := False;

      If Result Then
      Begin
        If FInclusao Then
          Result := fGeraItefor
        Else
          Result := fAtualizaEmpresasUsamPrecoMatrizIteger And
                    fAtualizaTabDetCus
      End;

      If Result And FInclusao Then
      Begin
        FblnIncidePis := fIncidePis(Self.cdsDados.FieldByName('ITE_CODITE').AsString);
        Result := fIncluiTabDet And
                  fGeraTabDetEmpresas;
      End;

      If FInclusao Then
      Begin
        FInclusao := False;
        Self.cdsDados.AfterPost := nil;
      End;

    Except
      On E: Exception Do
      Begin
        Result := false;
        pMensagensErro(E.Message, '[TTabelasDoItem.fSalvaDados]');
      End;
    End;

  Finally
    Self.cdsDados.Filtered := False;
    Self.cdsDados.EnableControls;
  End;
End;

Function TTabelasDoItem.fGeraItefor: Boolean;
  Var
    qryIteFor: TUniQuery;
Begin
  qryIteFor := fCriaQuery;
  qryIteFor.SQL.Text := 'SELECT * FROM ITEFOR WHERE FALSE';
  qryIteFor.Open;

  self.cdsDados.First;
  While Not Self.cdsDados.Eof Do
  Begin

    If Not qryIteFor.Locate('ITE_CODTAB', Self.cdsDados.FieldByName('ITE_CODTAB').AsString, []) Then
    Begin
      qryIteFor.Append;
      qryIteFor.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ITEFOR', VS_strCodEmp);

      self.cdsDados.edit;
      Self.cdsDados.FieldByName('AUTOINCREM').AsString := qryIteFor.FieldByName('AUTOINCREM').AsString ;
      self.cdsDados.Post;

      qryIteFor.FieldByName('ITE_CODEMP').AsString := VS_strCodEmp;
      qryIteFor.FieldByName('ITE_CODTAB').AsString := Self.cdsDados.FieldByName('ITE_CODTAB').AsString;
      qryIteFor.FieldByName('ITE_CODFOR').AsString := Self.cdsDados.FieldByName('ITE_CODFOR').AsString;

      qryIteFor.FieldByName('ITE_CODITE').Value := qryCadIte.FieldByName('ITE_CODITE').Value;
      qryIteFor.FieldByName('ITE_DESFAB').Value := qryCadIte.FieldByName('ITE_DESFAB').Value;
      qryIteFor.FieldByName('ITE_CODFAB').Value := qryCadIte.FieldByName('ITE_CODFAB').Value;
      qryIteFor.FieldByName('ITE_CLAIPI').Value := qryCadIte.FieldByName('ITE_CLAIPI').Value;
      qryIteFor.FieldByName('ITE_DIAFOR').Value := qryCadIte.FieldByName('ITE_DIAFOR').Value;
      qryIteFor.FieldByName('ITE_MLTCOM').Value := qryCadIte.FieldByName('ITE_MLTCOM').Value;
      qryIteFor.FieldByName('ITE_UNICOM').Value := qryCadIte.FieldByName('ITE_UNICOM').Value;

      qryIteFor.FieldByName('TFO_PESOIT').Value := qryCadIte.FieldByName('ITE_PESOIT').Value;
      qryIteFor.FieldByName('TFO_SITPRO').Value := qryCadIte.FieldByName('ITE_SITPRO').Value;
      qryIteFor.FieldByName('TFO_PRDGRU').Value := qryCadIte.FieldByName('ITE_PRDGRU').Value;
      qryIteFor.FieldByName('TFO_REFERE').Value := qryCadIte.FieldByName('ITE_REFERE').Value;
      qryIteFor.FieldByName('TFO_NOTESP').Value := qryCadIte.FieldByName('ITE_NOTESP').Value;

      qryIteFor.FieldByName('TFO_EMBALA').Value := qryCadIte.FieldByName('ITE_EMBALA').Value;
      qryIteFor.FieldByName('TFO_BAREMB').Value := qryCadIte.FieldByName('ITE_BAREMB').Value;
      qryIteFor.FieldByName('TFO_CODBAR').Value := qryCadIte.FieldByName('ITE_CODBAR').Value;

      qryIteFor.Post;
    End;

    self.cdsDados.Next;
  End;

  FreeAndNil(qryIteFor);

  Result := True;
End;

Function TTabelasDoItem.fGeraTabDetEmpresas: Boolean;
  Var
    qryEmpresas,
    qryTabDet: TUniQuery;
    intCampos: Integer;
    recNo: integer;
Begin
  qryTabDet := fCriaQuery;
  qryTabDet.SQL.Text := 'SELECT * FROM TABDET WHERE FALSE';
  qryTabDet.Open;

  qryEmpresas := fCriaQuery;
  qryEmpresas.SQL.Text := 'SELECT EMP_CODEMP FROM CADEMP WHERE EMP_CODEMP <> ' + QuotedStr(VS_strCodEmp);
  qryEmpresas.Open;
  Result := True;
  While Not qryEmpresas.Eof Do
  Begin
    self.cdsDados.First;
    While Not Self.cdsDados.Eof Do
    Begin

      If Not qryTabDet.Locate('ITE_CODTAB;ITE_CODEMP',
                              VarArrayOf([Self.cdsDados.FieldByName('ITE_CODTAB').AsString, qryEmpresas.FieldByName('EMP_CODEMP').AsString]), []) Then
      Begin
        qryTabDet.Append;

        For intCampos := 0 To qryTabDet.FieldCount - 1 Do
          If Pos(qryTabDet.Fields[intCampos].FieldName, 'ITE_PREVEN-ITE_MARBRU-ITE_COMTBL') = 0 Then
            if Self.cdsDados.Fields.FindField(qryTabDet.Fields[intCampos].FieldName) <> nil then
              qryTabDet.Fields[intCampos].Value := Self.cdsDados.FieldByName(qryTabDet.Fields[intCampos].FieldName).Value;

        If Assigned(cdsAbrFis) And cdsAbrFis.Locate('EMP_CODEMP', qryEmpresas.FieldByName('EMP_CODEMP').AsString, []) Then
        Begin

{          If Not fEmptyStr(cdsAbrFis.FieldByName('CODABF').AsString) Then
            qryTabDet.FieldByName('ITE_CODABF').Value := cdsAbrFis.FieldByName('CODABF').Value;}


          If Not fEmptyStr(cdsAbrFis.FieldByName('ABFIPI').AsString) Then
            qryTabDet.FieldByName('ITE_ABFIPI').Value := cdsAbrFis.FieldByName('ABFIPI').Value;

          If Not fEmptyStr(cdsAbrFis.FieldByName('ABFCOF').AsString) Then
            qryTabDet.FieldByName('ITE_ABFCOF').Value := cdsAbrFis.FieldByName('ABFCOF').Value;

          If Not fEmptyStr(cdsAbrFis.FieldByName('ABFPIS').AsString) Then
            qryTabDet.FieldByName('ITE_ABFPIS').Value := cdsAbrFis.FieldByName('ABFPIS').Value;
        End;

        qryTabDet.FieldByName('ITE_CODEMP').AsString := qryEmpresas.FieldByName('EMP_CODEMP').AsString;
        qryTabDet.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('TABDET', VS_strCodEmp);
        qryTabDet.FieldByName('ITE_SEQGER').AsString := Self.cdsDados.FieldByName('AUTOINCREM').AsString;
        recNo := Self.cdsDados.RecNo;



        qryTabDet.Post;
        result := Result And fSalvaDetCus(Self.cdsDados,
                               qryTabDet.FieldByName('AUTOINCREM').AsString,
                               Self.cdsDados.FieldByName('ITE_CODTAB').AsString,
                               recNo,
                               Self.cdsDados,
                               qryTabDet.FieldByName('ITE_CODEMP').AsString);

      End;

      self.cdsDados.Next;
    End;

    qryEmpresas.Next;
  End;

  FreeAndNil(qryEmpresas);

End;

Function TTabelasDoItem.fBuscaTabelaAtiva(strCodFor, strCodIte: String): String;
  Var
    qryTabAti: TUniQuery;
Begin
  qryTabAti := fCriaQuery;
  With qryTabAti, SQL Do
  Begin
    Clear;
    Add('SELECT');
    Add('  TAB_CODTAB');
    Add('FROM');
    Add('  ITEFOR');
    Add('INNER JOIN TABPRE ON TAB_CODTAB = ITE_CODTAB AND TAB_ATICMP = "S"');
    Add('WHERE');
    Add('  ITE_CODITE = :CODITE AND');
    Add('  ITE_CODFOR = :CODFOR    ');

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODFOR').AsString := strCodFor;

    Open;

    If IsEmpty Then
      Result := ''
    Else
      Result := FieldByName('TAB_CODTAB').AsString;

    Close;
  End;
  FreeAndNil(qryTabAti);
End;

Function TTabelasDoItem.fEscolheTabelaPreco: String;
  Var
    intIndice,
    intContador: Integer;
    stlTabelas: TStringList;
Begin
  Result := '';
  intContador := 0;

  For intIndice := 1 To Length(VS_strTabPrc) Do
  Begin
    If VS_strTabPrc[intIndice] = 'S' Then
    Begin
      Inc(intContador);
      Result := intIndice.ToString;
    End;
  End;

  If intContador > 1 Then
  Begin
    pCriarFormularios(TfrmTabelaPrecoSelec, frmTabelaPrecoSelec);
    If frmTabelaPrecoSelec.ShowModal = mrOk Then
    Begin
      stlTabelas := TStringList.Create;

     For intIndice := 0 To frmTabelaPrecoSelec.cklTabelas.Count - 1 Do
       If frmTabelaPrecoSelec.cklTabelas.Checked[intIndice] Then
         stlTabelas.Add(RightStr(frmTabelaPrecoSelec.cklTabelas.Items[intIndice], 1));

      Result := stlTabelas.CommaText;

      FreeAndNil(stlTabelas);
    End

    Else Result := '';

    pFreeAndNil(frmTabelaPrecoSelec);
  End;
End;

Function TTabelasDoItem.fRecarregaTabelasPreco(strTabelas, strTabAti: String): Boolean;
  Var
    cdsSalva: TUniClientDataSet;
    stlTabelas: TStringList;
    intContador: Integer;
    TabelaSelecionada: TTabelaSelecionada;
Begin
  Try
    Result := False;

    If Not (qryIteGer.State In dsEditModes) Then
      Exit;

    cdsSalva := TUniClientDataSet.Create(Nil);
    cdsSalva.Data := Self.cdsDados.Data;

    stlTabelas := TStringList.Create;
    stlTabelas.Text := AnsiReplaceStr(strTabelas, ',', #13#10);
    TabelaSelecionada := [];
    For intContador := 0 To stlTabelas.Count -1 Do
    Begin
      qryIteGer.FieldByName('ITE_TABPR' + Trim(stlTabelas[intContador])).AsString := strTabAti;
      If stlTabelas[intContador] = '1' then
        TabelaSelecionada := TabelaSelecionada + [ttsTab1]
      Else If stlTabelas[intContador] = '2' then
        TabelaSelecionada := TabelaSelecionada + [ttsTab2]
      Else If stlTabelas[intContador] = '3' then
        TabelaSelecionada := TabelaSelecionada + [ttsTab3]
      Else If stlTabelas[intContador] = '4' then
        TabelaSelecionada := TabelaSelecionada + [ttsTab4]
      Else If stlTabelas[intContador] = '5' then
        TabelaSelecionada := TabelaSelecionada + [ttsTab5]
      Else If stlTabelas[intContador] = '6' then
        TabelaSelecionada := TabelaSelecionada + [ttsTab6]
      Else If stlTabelas[intContador] = '7' then
        TabelaSelecionada := TabelaSelecionada + [ttsTab7];
    End;

    Result := fCarregaPrecos(True);

    cdsSalva.First;
    While Not cdsSalva.Eof Do
    Begin

      If Self.cdsDados.Locate('TABELA', cdsSalva.FieldByName('TABELA').AsString, []) Then
      Begin
        self.cdsDados.edit;
        For intContador := 0 To Self.cdsDados.Fields.Count -1 Do
        Begin
          If (Not fTabelaSelecionada(cdsSalva.FieldByName('TABELA').AsString, TabelaSelecionada)) Then
            If (Not (Self.cdsDados.Fields[intContador].FieldName = 'ITE_PREVEN')) Then
              Self.cdsDados.Fields[intContador].Value := cdsSalva.Fields[intContador].Value;
        End;

        self.cdsDados.Post;
      End;

      cdsSalva.Next;
    End;

    FreeAndNil(stlTabelas);
    FreeAndNil(cdsSalva);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TTabelasDoItem.fRecarregaTabelasPreco]');
    End;
  End;
End;

function TTabelasDoItem.fTabelaSelecionada(strTabela: String; TabelaSelecionada: TTabelaSelecionada): Boolean;
var intTabela: Integer;
Begin
  intTabela := StrToInt(strTabela);

  case intTabela of
    1: Result := ttsTab1 in TabelaSelecionada;
    2: Result := ttsTab2 in TabelaSelecionada;
    3: Result := ttsTab3 in TabelaSelecionada;
    4: Result := ttsTab4 in TabelaSelecionada;
    5: Result := ttsTab5 in TabelaSelecionada;
    6: Result := ttsTab6 in TabelaSelecionada;
    7: Result := ttsTab7 in TabelaSelecionada;
    Else
      Result := False;
  End;

End;


Procedure TTabelasDoItem.pPreencheTabela(qryTabela: TUniQuery; strCodTab: String);
  Var
    blnLiberar: Boolean;
Begin
  If Not Assigned(qryTabela) Then
  Begin
    qryTabela := fCriaQuery;
    qryTabela.SQL.Text := 'SELECT * FROM TABPRE WHERE TAB_CODTAB = ' + QuotedStr(strCodTab);
    qryTabela.Open;
    blnLiberar := True;
  End

  Else blnLiberar := False;

  If cdsTabelas.Locate('TABELA', Self.cdsDados.FieldByName('TABELA').AsString, []) Then
  Begin
    If cdsTabelas.State <> dsEdit Then
      cdsTabelas.Edit;

    cdsTabelas.FieldByName('CODTAB').AsString := qryTabela.FieldByName('TAB_CODTAB').AsString;
    cdsTabelas.FieldByName('NOMTAB').AsString := qryTabela.FieldByName('TAB_NOMTAB').AsString;
    cdsTabelas.FieldByName('CODFOR').AsString := qryTabela.FieldByName('TAB_CODFOR').AsString;
    cdsTabelas.FieldByName('NOMFOR').AsString := fRetNomFornecedor(qryTabela.FieldByName('TAB_CODFOR').AsString);

    cdsTabelas.Post;
  End;

  If Self.cdsDados.State in dsEditModes Then
    Self.cdsDados.FieldByName('ITE_CODTAB').AsString := cdsTabelas.FieldByName('CODTAB').AsString;

  If blnLiberar Then
    FreeAndNil(qryTabela);

End;

Function TTabelasDoItem.fValidaTabelasPreco: Boolean;
Begin
  Result := True;
//  Result := Not cdsTabelas.Locate('CODTAB', NULL, []);

//  If Not Result Then
//    pMensagemOk('Informe o código das tabelas de preço para a inclusão do produto!');
End;

Function TTabelasDoItem.fTabelaPrecoToIteger: Boolean;
Begin
  Try
    cdsTabelas.IndexFieldNames := 'TABELA';
    cdsTabelas.First;

    // COPIA AS INFORMAÇÕES DA PRIMEIRA TABELA PARA O ITEGER
    If Self.cdsDados.Locate('ITE_CODTAB;TABELA',
                   VarArrayOf([cdsTabelas.FieldByName('CODTAB').AsString, cdsTabelas.FieldByName('TABELA').AsString]), []) Then
    Begin
      qryIteGer.FieldByName('ITE_PRECUS').Value := Self.cdsDados.FieldByName('ITE_PRECUS').Value;
      qryIteGer.FieldByName('ITE_PREDOL').Value := Self.cdsDados.FieldByName('ITE_PREDOL').Value;
      qryIteGer.FieldByName('ITE_PRECOM').Value := Self.cdsDados.FieldByName('ITE_PRECOM').Value;
      qryIteGer.FieldByName('ITE_DESF01').Value := Self.cdsDados.FieldByName('ITE_DESF01').Value;
      qryIteGer.FieldByName('ITE_DESF02').Value := Self.cdsDados.FieldByName('ITE_DESF02').Value;
      qryIteGer.FieldByName('ITE_DESF03').Value := Self.cdsDados.FieldByName('ITE_DESF03').Value;
      qryIteGer.FieldByName('ITE_DESF04').Value := Self.cdsDados.FieldByName('ITE_DESF04').Value;
      qryIteGer.FieldByName('ITE_DESF05').Value := Self.cdsDados.FieldByName('ITE_DESF05').Value;
      qryIteGer.FieldByName('ITE_DESF06').Value := Self.cdsDados.FieldByName('ITE_DESF06').Value;
      qryIteGer.FieldByName('ITE_ICMENT').Value := Self.cdsDados.FieldByName('ITE_ICMENT').Value;
      qryIteGer.FieldByName('ITE_SUBFED').Value := Self.cdsDados.FieldByName('ITE_SUBFED').Value;
      qryIteGer.FieldByName('ITE_IPIENT').Value := Self.cdsDados.FieldByName('ITE_IPIENT').Value;
      qryIteGer.FieldByName('ITE_FREENT').Value := Self.cdsDados.FieldByName('ITE_FREENT').Value;
      qryIteGer.FieldByName('ITE_VALFRE').Value := Self.cdsDados.FieldByName('ITE_VALFRE').Value;
      qryIteGer.FieldByName('ITE_ACRFIN').Value := Self.cdsDados.FieldByName('ITE_ACRFIN').Value;
      qryIteGer.FieldByName('ITE_SUBSTI').Value := Self.cdsDados.FieldByName('ITE_SUBSTI').Value;
      qryIteGer.FieldByName('ITE_DESADB').Value := Self.cdsDados.FieldByName('ITE_DESADB').Value;
      qryIteGer.FieldByName('ITE_TCIFCU').Value := Self.cdsDados.FieldByName('ITE_TCIFCU').Value;
      qryIteGer.FieldByName('ITE_TSCUST').Value := Self.cdsDados.FieldByName('ITE_TSCUST').Value;
      qryIteGer.FieldByName('ITE_DEPICO').Value := Self.cdsDados.FieldByName('ITE_DEPICO').Value;
      qryIteGer.FieldByName('ITE_DEICMS').Value := Self.cdsDados.FieldByName('ITE_DEICMS').Value;
      qryIteGer.FieldByName('ITE_FATREG').Value := Self.cdsDados.FieldByName('ITE_FATREG').Value;
      qryIteGer.FieldByName('ITE_OUTVAL').Value := Self.cdsDados.FieldByName('ITE_OUTVAL').Value;
      qryIteGer.FieldByName('ITE_ICMSAI').Value := Self.cdsDados.FieldByName('ITE_ICMSAI').Value;
      qryIteGer.FieldByName('ITE_IMPFED').Value := Self.cdsDados.FieldByName('ITE_IMPFED').Value;
      qryIteGer.FieldByName('ITE_DESOPE').Value := Self.cdsDados.FieldByName('ITE_DESOPE').Value;
      qryIteGer.FieldByName('ITE_TABPR' + cdsTabelas.FieldByName('TABELA').AsString).Value := Self.cdsDados.FieldByName('ITE_CODTAB').Value;
    End;

    // ACERTA A MARGEM DAS OUTRAS TABELAS DE PREÇO
    While Not cdsTabelas.Eof Do
    Begin

      If Self.cdsDados.Locate('ITE_CODTAB;TABELA',
                     VarArrayOf([cdsTabelas.FieldByName('CODTAB').AsString, cdsTabelas.FieldByName('TABELA').AsString]), []) Then
      Begin
        qryIteGer.FieldByName('ITE_PREVE' + cdsTabelas.FieldByName('TABELA').AsString).Value := Self.cdsDados.FieldByName('ITE_PREVEN').Value;
        qryIteGer.FieldByName('ITE_MARBR' + cdsTabelas.FieldByName('TABELA').AsString).Value := Self.cdsDados.FieldByName('ITE_MARBRU').Value;
        qryIteGer.FieldByName('ITE_COMTB' + cdsTabelas.FieldByName('TABELA').AsString).Value := Self.cdsDados.FieldByName('ITE_COMTBL').Value;
        qryIteGer.FieldByName('ITE_TABPR' + cdsTabelas.FieldByName('TABELA').AsString).Value := Self.cdsDados.FieldByName('ITE_CODTAB').Value;
      End;

      cdsTabelas.Next;
    End;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TTabelasDoItem.fRecarregaTabelasPreco]');
    End;
  End;
End;

Function TTabelasDoItem.fValidaPrecos: Boolean;
Begin
  Result := False;

  self.cdsDados.First;
  While Not Self.cdsDados.Eof Do
  Begin
    If Self.cdsDados.FieldByName('ITE_PRECOM').AsFloat <= 0 Then
    Begin
      pMensagemOk('O preço de compra deve ser maior que zero!');
      Exit;
    End;
    If Self.cdsDados.FieldByName('ITE_CODABF').AsString = '' Then
    Begin
      pMensagemOk('A Abreviação de ICMS deve ser Preenchida!');
      Exit;
    End;

    self.cdsDados.Next;
  End;

  Result := True;
End;

Function TTabelasDoItem.fSQLUpdateIteger: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT          ';
  strSQL := strSQL + '   I.*,          ';

  strSQL := strSQL + '   T.ITE_PRECUS  AS ITE_PRECUS_TAB,          ';
  strSQL := strSQL + '   DC.DET_OUTVAL AS ITE_OUTVAL_TAB,          ';
  strSQL := strSQL + '   DC.DET_ICMSAI AS ITE_ICMSAI_TAB,          ';
  strSQL := strSQL + '   DC.DET_DESOPE AS ITE_DESOPE_TAB,          ';
  strSQL := strSQL + '   DC.DET_PREVEN AS ITE_PREVEN, ';
  strSQL := strSQL + '   T.ITE_IMPFED AS ITE_IMPFED_TAB,          ';
  strSQL := strSQL + '   T.ITE_CODTAB  ';
  strSQL := strSQL + ' FROM     ';
  strSQL := strSQL + '   ITEGER I ';

  strSQL := strSQL + ' INNER JOIN TABDET T  ';
  strSQL := strSQL + '    ON T.ITE_CODITE = I.ITE_CODITE ';
  strSQL := strSQL + '   AND T.ITE_CODEMP = I.ITE_CODEMP ';
  strSQL := strSQL + '   AND T.ITE_CODTAB IN (I.ITE_TABPR1, I.ITE_TABPR2, I.ITE_TABPR3, I.ITE_TABPR4, I.ITE_TABPR5, I.ITE_TABPR6, I.ITE_TABPR7) ';

  strSQL := strSQL + ' INNER JOIN DETCUS DC ON DC.DET_SEQDET = T.AUTOINCREM AND DET_TABELA  = :TABELA  ';

  strSQL := strSQL + ' WHERE    ';
  strSQL := strSQL + '       T.ITE_CODITE = :CODITE  ';
  strSQL := strSQL + '   AND T.ITE_CODTAB = :CODTAB  ';
  strSQL := strSQL + '   AND T.ITE_CODEMP IN ( ' + FEmpresasUsamPrecoMatriz + ') ';

  Result := strSQL;
End;

Function TTabelasDoItem.fGetEmpresasUsamPrecoMatriz: String;
  Var
    stlEmpresas: TStringList;
Begin
  stlEmpresas := TStringList.Create;

  fRetEmpresasUsamPrecoMatriz(stlEmpresas);

  Result := fCommaText(stlEmpresas, True);

  FreeAndNil(stlEmpresas);
End;

Function TTabelasDoItem.fAtualizaEmpresasUsamPrecoMatrizIteger: Boolean;
  Var
    cdsIteger: TZClient;
    intContador: Integer;
Begin
  Result := True;

  cdsIteger := TZClient.Create(nil, fSQLUpdateIteger);

  self.cdsDados.First;

  While Not Self.cdsDados.Eof Do
  Begin
    cdsIteger.Close;
    cdsIteger.qryQuery.ParamByName('CODITE').AsString := Self.cdsDados.FieldByName('ITE_CODITE').AsString;
    cdsIteger.qryQuery.ParamByName('CODTAB').AsString := Self.cdsDados.FieldByName('ITE_CODTAB').AsString;
    cdsIteger.qryQuery.ParamByName('TABELA').AsString := Self.cdsDados.FieldByName('TABELA').AsString;
    Result := cdsIteger.fLeDados('fAtualizaEmpresasUsamPrecoMatrizIteger');

    If Not Result Then
      Break;

    While Not cdsIteger.Eof Do
    Begin
      If cdsIteger.FieldByName('ITE_CODEMP').AsString = VS_StrCodEmp Then
      Begin
        cdsIteger.Next;
        Continue;
      End;

      For intContador := 1 To 7 Do
        If (cdsIteger.FieldByName('ITE_CODTAB').AsString = cdsIteger.FieldByName('ITE_TABPR' + intContador.ToString).AsString) And
           (Self.cdsDados.FieldByName('TABELA').AsInteger = intContador)then
        Begin

          cdsIteger.Edit;
          cdsIteger.FieldByName('ITE_PREVE' + intContador.ToString).Value := Self.cdsDados.FieldByName('ITE_PREVEN').Value;

          cdsIteger.FieldByName('ITE_MARBR' + intContador.ToString).AsFloat := fCalculaPrecoVenda(2,
                                               cdsIteger.FieldByName('ITE_PRECUS_TAB').AsFloat + cdsIteger.FieldByName('ITE_OUTVAL_TAB').AsFloat,
                                               cdsIteger.FieldByName('ITE_PREVE' + intContador.ToString).AsFloat,
                                               cdsIteger.FieldByName('ITE_MARBR' + intContador.ToString).AsFloat,
                                               cdsIteger.FieldByName('ITE_ICMSAI_TAB').AsFloat,
                                               cdsIteger.FieldByName('ITE_IMPFED_TAB').AsFloat,
                                               cdsIteger.FieldByName('ITE_DESOPE_TAB').AsFloat,
                                               cdsIteger.FieldByName('ITE_COMTB' + intContador.ToString).AsFloat);

          cdsIteger.Post;
        End;

       cdsIteger.Next;
    End;

    Result := cdsIteger.fSalva;

    If Not Result Then
      Break;

    self.cdsDados.Next;
  End;

  FreeAndNil(cdsIteger);
End;

Function TTabelasDoItem.fSQLTabDetHeranca: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT          ';
  strSQL := strSQL + '   T.*,          ';
  strSQL := strSQL + '   I.ITE_TABPR1, ';
  strSQL := strSQL + '   I.ITE_TABPR2, ';
  strSQL := strSQL + '   I.ITE_TABPR3, ';
  strSQL := strSQL + '   I.ITE_TABPR4, ';
  strSQL := strSQL + '   I.ITE_TABPR5, ';
  strSQL := strSQL + '   I.ITE_TABPR6, ';
  strSQL := strSQL + '   I.ITE_TABPR7  ';

  strSQL := strSQL + ' FROM     ';
  strSQL := strSQL + '   ITEGER I ';

  strSQL := strSQL + ' INNER JOIN TABDET T  ';
  strSQL := strSQL + '    ON T.ITE_CODITE = I.ITE_CODITE ';
  strSQL := strSQL + '   AND T.ITE_CODEMP = I.ITE_CODEMP ';
  strSQL := strSQL + '   AND T.ITE_CODTAB IN (I.ITE_TABPR1, I.ITE_TABPR2, I.ITE_TABPR3, I.ITE_TABPR4, I.ITE_TABPR5, I.ITE_TABPR6, I.ITE_TABPR7) ';

  strSQL := strSQL + ' WHERE    ';
  strSQL := strSQL + '       I.ITE_CODITE = :CODITE ';
  strSQL := strSQL + '   AND I.ITE_CODEMP = :CODEMP ';
  Result := strSQL;
End;

Function TTabelasDoItem.fCarregaDadosHeranca(strCodIte: String): Boolean;
  Var
    intContador: Integer;
Begin
  Result := fCarregaTabelas;

  pAdicionaTabDetInclusao;

  If Not Assigned(qryTabDetHeranca) Then
    qryTabDetHeranca := fCriaQuery(nil);

  qryTabDetHeranca.SQL.Text := fSQLTabDetHeranca;
  qryTabDetHeranca.ParamByName('CODITE').AsString := strCodIte;
  qryTabDetHeranca.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryTabDetHeranca.Open;

  qryTabDetHeranca.IndexFieldNames := 'ITE_CODTAB';
  qryTabDetHeranca.KeyFields := 'ITE_CODTAB';

  self.cdsDados.First;
  While Not Self.cdsDados.Eof Do
  Begin

    If qryTabDetHeranca.Locate('ITE_CODTAB', Self.cdsDados.FieldByName('ITE_CODTAB').AsString, []) Then
    Begin
      self.cdsDados.edit;

      For intContador := 0 To Self.cdsDados.Fields.Count - 1 Do
        If (Pos(Self.cdsDados.Fields[intContador].FieldName, 'AUTOINCREM-ITE_CODITE-ITE_CODTAB-ITE_CODEMP') = 0) And
           Assigned(qryTabDetHeranca.FindField(Self.cdsDados.Fields[intContador].FieldName)) Then
          Self.cdsDados.Fields[intContador].Value := qryTabDetHeranca.FieldByName(Self.cdsDados.Fields[intContador].FieldName).Value;

      self.cdsDados.Post;
    End;

    self.cdsDados.Next;
  End;
End;

Function TTabelasDoItem.fIncluiTabDet: Boolean;
  Var
    qryTabDet: TUniQuery;
    intContador: Integer;
    recNo: integer;
Begin
  qryTabDet := fCriaQuery;
  qryTabDet.SQL.Text := 'SELECT * FROM TABDET WHERE FALSE';
  qryTabDet.Open;

  Self.cdsDados.DisableControls;

  Self.cdsDados.Filtered := False;
  Result := True;
  self.cdsDados.First;
  While Not Self.cdsDados.Eof Do
  Begin

    If Not qryTabDet.Locate('ITE_CODTAB', Self.cdsDados.FieldByName('ITE_CODTAB').AsString, []) Then
    Begin
      qryTabDet.Append;

      For intContador := 0 To qryTabDet.FieldCount - 1 Do
        If Pos(qryTabDet.Fields[intContador].FieldName, 'ITE_PREVEN-ITE_MARBRU-ITE_COMTBL') = 0 Then
          if Self.cdsDados.Fields.FindField(qryTabDet.Fields[intContador].FieldName) <> nil then
            qryTabDet.Fields[intContador].Value := Self.cdsDados.FieldByName(qryTabDet.Fields[intContador].FieldName).Value;

      qryTabDet.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('TABDET', VS_strCodEmp);
      qryTabDet.FieldByName('ITE_SEQGER').AsString := Self.cdsDados.FieldByName('AUTOINCREM').AsString;
      recNo := Self.cdsDados.RecNo;


      qryTabDet.Post;
      Result := Result And fSalvaDetCus(Self.cdsDados,
                             qryTabDet.FieldByName('AUTOINCREM').AsString,
                             Self.cdsDados.FieldByName('ITE_CODTAB').AsString,
                             recNo,
                             Self.cdsDados,
                             VS_strCodEmp);
    End;
    self.cdsDados.Next;
  End;

  Self.cdsDados.EnableControls;

  FreeAndNil(qryTabDet);


End;


Function TTabelasDoItem.fAtualizaTabDetCus(): Boolean;
var
  qryComand : TUniQuery;
begin
  self.cdsDados.First;
  Result := True;
  qryComand := fCriaQuery;
  Try
    Try

      qryComand.SQL.Add('REPLACE INTO DETCUS (DET_SEQDET, DET_TABELA, DET_ICMSAI, DET_DESOPE, DET_OUTVAL,DET_MARBRU,DET_PREVEN ) VALUES (:SEQDET, :TABELA, :ICMSAI, :DESOPE, :OUTVAL,:MARBRU, :PREVEN);');
      Self.cdsDados.First;
      While Not Self.cdsDados.Eof Do
      Begin
        qryComand.ParamByName('SEQDET').Value :=  Self.cdsDados.FieldByName('AUTOINCREM').Value;
        qryComand.ParamByName('TABELA').Value :=  Self.cdsDados.FieldByName('TABELA').Value;
        qryComand.ParamByName('ICMSAI').Value :=  Self.cdsDados.FieldByName('ITE_ICMSAI').Value;
        qryComand.ParamByName('DESOPE').Value :=  Self.cdsDados.FieldByName('ITE_DESOPE').Value;
        qryComand.ParamByName('OUTVAL').Value :=  Self.cdsDados.FieldByName('ITE_OUTVAL').Value * Self.cdsDados.FieldByName('ITE_CNVCUS').Value;
        qryComand.ParamByName('MARBRU').Value :=  Self.cdsDados.FieldByName('ITE_MARBRU').Value;
        qryComand.ParamByName('PREVEN').Value :=  Self.cdsDados.FieldByName('ITE_PREVEN').Value* Self.cdsDados.FieldByName('ITE_CNVCUS').Value;
        qryComand.ExecSQL;
        Self.cdsDados.Next;
      End;
    Except
      on E: Exception do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TTabelasDoItem.fAtualizaTabDetCus]');
      End;
    End;
  Finally
    Self.cdsDados.First;
    FreeAndNil(qryComand);
  End;

End;

Function TTabelasDoItem.fSalvaDetCus(dataSet: TDataSet; strAutoIncrem: String; strCodTab: String; intRecNo: integer; TabelaItens: TDataSet; strCodemp: String): Boolean;
var qryComand: TUniQuery;
    i, AtuRecNo: integer;
    strTabela: String;
    CalculaComposicaoCusto: TCalculaComposicaoCusto;
    fltPreCus: Double;
    fltIcmEnt,
    fltSubsti,
    fltIcmSai,
    fltImpFed,
    fltSubFed,
    fltOutval,
    fltDesOpe,
    fltMarBru,
    fltPreVen: Double;
    blnUtilizarConversorDeMoeda: Boolean;
begin
  Result := True;
  dataSet.First;
  qryComand := fCriaQuery;

  fltIcmSai := 0;
  fltDesOpe := 0;
  fltOutVal := 0;
  fltPreVen := 0;
  Try
    Try
      qryComand.SQL.Add('REPLACE INTO DETCUS (DET_SEQDET, DET_TABELA, DET_ICMSAI, DET_DESOPE, DET_OUTVAL,DET_MARBRU,DET_PREVEN ) VALUES (:SEQDET, :TABELA, :ICMSAI, :DESOPE, :OUTVAL,:MARBRU, :PREVEN);');
      while not dataSet.Eof do
      Begin
          AtuRecNo := dataSet.RecNo;
          strTabela := dataSet.FieldByName('TABELA').Value;
          If strCodTab  <> dataSet.FieldByName('ITE_CODTAB').Value then
          Begin
            dataSet.RecNo := intRecNo;

            CalculaComposicaoCusto := TCalculaComposicaoCusto.fRetCustoTabDet(dataSet.FieldByName('ITE_IPIENT').AsFloat,
                                                                              FblnIncidePis,
                                                                              dataSet.FieldByName('ITE_CODFOR').AsString,
                                                                              dataSet.FieldByName('ITE_CODABF').AsString,
                                                                              '',
                                                                              strTabela,
                                                                              dataSet.FieldByName('ITE_CODEMP').AsString);
            Try

              If CalculaComposicaoCusto.BlnSemST then
              Begin
                fltIcmEnt := CalculaComposicaoCusto.AliquotaICMSEnt;
                fltIcmSai := CalculaComposicaoCusto.AliquotaICMSSai;
                fltSubsti := 0;
              End
              Else
              begin
                fltIcmEnt := 0;
                fltIcmSai := 0;
                fltSubsti := CalculaComposicaoCusto.AliquotaST;
              End;

              fltImpFed := CalculaComposicaoCusto.ImpFed;
              fltSubFed := CalculaComposicaoCusto.SubFed;
              fltDesOpe := CalculaComposicaoCusto.DesOpe;
              fltOutVal := CalculaComposicaoCusto.OutVal;
            Finally
              FreeAndNil(CalculaComposicaoCusto);
            End;

            cpcParams.curPreCom := dataSet.FieldByName('ITE_PRECOM').AsFloat;
            cpcParams.curDesF01 := dataSet.FieldByName('ITE_DESF01').AsFloat;
            cpcParams.curDesF02 := dataSet.FieldByName('ITE_DESF02').AsFloat;
            cpcParams.curDesF03 := dataSet.FieldByName('ITE_DESF03').AsFloat;
            cpcParams.curDesF04 := dataSet.FieldByName('ITE_DESF04').AsFloat;
            cpcParams.curDesF05 := dataSet.FieldByName('ITE_DESF05').AsFloat;
            cpcParams.curDesF06 := dataSet.FieldByName('ITE_DESF06').AsFloat;
            cpcParams.curICMSEnt:= fltIcmEnt;
            cpcParams.curIPIEnt := dataSet.FieldByName('ITE_IPIENT').AsFloat;
            cpcParams.curFrete  := dataSet.FieldByName('ITE_FREENT').AsFloat;
            cpcParams.curAcrFin := dataSet.FieldByName('ITE_ACRFIN').AsFloat;
            cpcParams.curSubsti := fltSubsti;
            cpcParams.curValFre := dataSet.FieldByName('ITE_VALFRE').AsFloat;
            cpcParams.curDesAdb := dataSet.FieldByName('ITE_DESADB').AsFloat;
            cpcParams.curSubFed := fltSubFed;

            if blnSufram and (strFrmCus = '4') then
            begin
              cpcParams.curTCIFCu := dataSet.FieldByName('ITE_TCIFCU').AsFloat;
              cpcParams.curTSCust := dataSet.FieldByName('ITE_TSCUST').AsFloat;
              cpcParams.curDePiCo := dataSet.FieldByName('ITE_DEPICO').AsFloat;
              cpcParams.curDeICMS := dataSet.FieldByName('ITE_DEICMS').AsFloat;
              cpcParams.curFatReg := dataSet.FieldByName('ITE_FATREG').AsFloat;
            end
            else
            begin
              cpcParams.curTCIFCu := 0;
              cpcParams.curTSCust := 0;
              cpcParams.curDePiCo := 0;
              cpcParams.curDeICMS := 0;
              cpcParams.curFatReg := 0;
            end;

            blnUtilizarConversorDeMoeda := dataSet.FieldByName('ITE_PREDOL').AsString = 'S';

            fltPreCus := cpcParams.fCalculaPrecoCusto(blnUtilizarConversorDeMoeda);

            fltMarBru := dataSet.FieldByName('ITE_MARBRU').AsFloat;
            fltPreVen := fCalculaPrecoVenda(1,
                                            fltPrecus + fltOutVal,
                                            0,
                                            dataSet.FieldByName('ITE_MARBRU').AsFloat,
                                            fltIcmSai,
                                            fltImpFed,
                                            fltDesOpe,
                                            dataSet.FieldByName('ITE_COMTBL').AsFloat,
                                            '',
                                            '',
                                            intDecUni);
          End
          Else
          Begin
            fltIcmSai := dataSet.FieldByName('ITE_ICMSAI').AsFloat;
            fltDesOpe := dataSet.FieldByName('ITE_DESOPE').AsFloat;
            fltOutVal := dataSet.FieldByName('ITE_OUTVAL').AsFloat;
            fltMarBru := dataSet.FieldByName('ITE_MARBRU').AsFloat;
            fltPreVen := dataSet.FieldByName('ITE_PREVEN').AsFloat;
          End;
          qryComand.ParamByName('SEQDET').Value :=  strAutoIncrem;
          qryComand.ParamByName('TABELA').Value :=  strTabela;

          qryComand.ParamByName('ICMSAI').Value :=  fltIcmSai;
          qryComand.ParamByName('DESOPE').Value :=  fltDesOpe;
          qryComand.ParamByName('OUTVAL').Value :=  fltOutVal;
          qryComand.ParamByName('MARBRU').Value :=  fltMarBru;
          qryComand.ParamByName('PREVEN').Value :=  fltPreVen;
          qryComand.ExecSQL;
          dataSet.RecNo := AtuRecNo;

        dataSet.Next;
      End;

      For i := 1 To  7 do
      Begin
        If VS_strTabPrc[i] = 'N' Then
        Begin
          qryComand.ParamByName('SEQDET').Value :=  strAutoIncrem;
          qryComand.ParamByName('TABELA').Value :=  i.ToString;

          qryComand.ParamByName('ICMSAI').Value :=  fltIcmSai;
          qryComand.ParamByName('DESOPE').Value :=  fltDesOpe;
          qryComand.ParamByName('OUTVAL').Value :=  fltOutVal;
          qryComand.ParamByName('MARBRU').Value :=  TabelaItens.FieldByName('ITE_MARBRU').AsFloat;
          qryComand.ParamByName('PREVEN').Value :=  fltPreVen;
          qryComand.ExecSQL;
        End;
      End;

      dataSet.RecNO :=  intRecNo;
    Except
      on E: Exception do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TTabelasDoItem.fSalvaDetCus]');
      End;
    End;
  Finally
    FreeAndNil(qryComand)
  End;
End;


end.


