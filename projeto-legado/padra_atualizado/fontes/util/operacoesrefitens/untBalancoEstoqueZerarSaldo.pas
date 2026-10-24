unit untBalancoEstoqueZerarSaldo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, Grids, DBGridCitel, DBGrids, Mask, MaskEditFocus, StdCtrls,
  EditFocus, AppEvnts, Menus, Buttons, ExtCtrls, untFuncoesSimples, untTypesSistema,
  Uni, DB, StrUtils, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  Vcl.ComCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit,  cxProgressBar, untConstantes, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, ComboBoxFocus;

type
  TfrmBalancoEstoqueZerarSaldo = class(TfrmPaiConfirma)
    pnlCabecalho: TPanel;
    Label1: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    edtLocIni: TEditFocus;
    edtLocFin: TEditFocus;
    mskLinhaGrupo: TMaskEditFocus;
    edtDesGrupo: TEditFocus;
    Label2: TLabel;
    edtNomFor: TEditFocus;
    edtCodFor: TEditFocus;
    Label3: TLabel;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    edtCodUni: TEditFocus;
    Label4: TLabel;
    edtDesUni: TEditFocus;
    edtDesIte: TEditFocus;
    cxgDadosDBTableViewCitel: TcxGridDBTableViewCitel;
    cxgDadosLevel1: TcxGridLevel;
    cxgDados: TcxGridCitel;
    cxgDadosDBTableViewCitelITE_CODGRU: TcxGridDBColumn;
    cxgDadosDBTableViewCitelITE_CODITE: TcxGridDBColumn;
    cxgDadosDBTableViewCitelITE_DESITE: TcxGridDBColumn;
    cxgDadosDBTableViewCitelITE_NUMLOT: TcxGridDBColumn;
    cxgDadosDBTableViewCitelITE_SALCON: TcxGridDBColumn;
    cxgDadosDBTableViewCitelUNI_SIGUNI: TcxGridDBColumn;
    cxgDadosDBTableViewCitelITE_LOCFIS: TcxGridDBColumn;
    Label7: TLabel;
    edtCodIte: TEditFocus;
    edtDescricao: TEditFocus;
    Label5: TLabel;
    lblDepartamento: TLabel;
    edtCodDep: TEditFocus;
    edtDesDep: TEditFocus;
    cxgDadosDBTableViewCitelITE_ITEATI: TcxGridDBColumn;
    lblGrupo: TLabel;
    edtCodGrupo: TEditFocus;
    EdtDesGru: TEditFocus;
    cmbSaldo: TComboBoxFocus;
    Label9: TLabel;
    btnFiltrosLocalizacao: TBitBtnLocked;
    btnHlpImp: TBitBtnLocked;
    odgSelectFile: TOpenDialog;
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarExit(Sender: TObject);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodUniExit(Sender: TObject);
    procedure edtCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);

    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteExit(Sender: TObject);
    procedure edtCodIteEnter(Sender: TObject);
    procedure edtCodDepExit(Sender: TObject);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodGrupoExit(Sender: TObject);
    procedure edtCodGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure btnHlpImpClick(Sender: TObject);
    procedure btnFiltrosLocalizacaoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtLocIniExit(Sender: TObject);
  private
    { Private declarations }
    ListaLocFis: TStringList;

    arrProduto   : TConsultasArray;
    arrLinhaGrupo: TConsultasArray;
    arrFornecedor: TConsultasArray;
    arrDepto: TConsultasArray;
    arrMarca: TConsultasArray;
    arrUnidade: TConsultasArray;
    arrGrupo: TConsultasArray;
    qryUpdade: TUniQuery;
    qryConsulta: TUniQuery;
    qryGen   : TUniQuery;
    dtsItens : TDataSource;
    procedure pBuscaZeraItens;
    procedure pLimpaTela;
    procedure pHabilitaTela;
    procedure pSetaParametros(qryConsulta: TUniQuery);

    Function fZeraLote: Boolean;
    function fZeraItens(pgbProgresso: TcxProgressBar): Boolean;
    Function fSQLFiltros(blnCadLot : Boolean): String;


  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;

end;

var
  frmBalancoEstoqueZerarSaldo: TfrmBalancoEstoqueZerarSaldo;


const cIndetImportPlanilhaLocFis = '+PLANILHA';

implementation

uses untFuncoesConsulta, untConsultas, untCadLote, untConDet, untGravando,
     untHistoricoBalanco, untControleContagemBalancoEstoque, untTValidaExcel;

{$R *.dfm}

procedure TfrmBalancoEstoqueZerarSaldo.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinhaGrupo,edtDesGrupo,arrLinhaGrupo,fRetNomeLinhaGrupo,Nil,'da linha/grupo',6);
end;

procedure TfrmBalancoEstoqueZerarSaldo.mskLinhaGrupoKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, nil, Key, arrLinhaGrupo, False) Then
  Begin
    fvalidaCampos(mskLinhaGrupo,False);
    self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmBalancoEstoqueZerarSaldo.btnFiltrosLocalizacaoClick(
  Sender: TObject);
  var
    objValidaExcel: TValidadorExcel;
    i: integer;
begin
  inherited;
  If odgSelectFile.Execute() Then
  Begin
    objValidaExcel := TValidadorExcel.Create(odgSelectFile.FileName, 1, '', '');
    Try
      ListaLocFis.Clear;
      for I := 0 to objValidaExcel.ArquivoCSV.Count -1 do
      Begin
        ListaLocFis.Add(QuotedStr(objValidaExcel.fGetValueCSV(i, 'A')));
      End;
      If ListaLocFis.Count > 0 Then
      Begin
        edtLocIni.Enabled := False;
        edtLocIni.Text := '';
        edtLocIni.Text := cIndetImportPlanilhaLocFis;
        If fPergunta('Importação realizada com sucesso! Deseja carregar os itens?') Then
          fValidaCampos(edtCodGrupo, True);
      End;
    Finally
      FreeAndNil(objValidaExcel);
    End;
  End;
end;

procedure TfrmBalancoEstoqueZerarSaldo.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  pMensagemOk('Para usar este recurso basta carregar uma planilha com as localizações na coluna "A"!');
end;

procedure TfrmBalancoEstoqueZerarSaldo.edtCodDepExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodDep,edtDesDep,arrDepto,fRetNomDep,Nil,'do departamento');
end;

procedure TfrmBalancoEstoqueZerarSaldo.edtCodDepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  {**********************************}
  {* NOVA CONSULTA DE DEPARTAMENTOS *}
  {*******************************TS*}
  If fPesqDepartamento(Self, edtCodDep, edtDesDep, Nil, Key, arrDepto, False) Then
  Begin
    If fValidaCampos(edtCodDep, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBalancoEstoqueZerarSaldo.edtCodForExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFor,edtNomFor,arrFornecedor,fRetNomFornecedor,Nil,'do fornecedor',8);
end;

procedure TfrmBalancoEstoqueZerarSaldo.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, nil, Key, arrFornecedor, False) Then
  Begin
    fvalidaCampos(edtCodFor,False);
    self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmBalancoEstoqueZerarSaldo.edtCodGrupoExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodGrupo,edtDesGru,arrGrupo,fRetNomGrupoProdutos,Nil,'do grupo');
end;

procedure TfrmBalancoEstoqueZerarSaldo.edtCodGrupoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrGrupo: TConsultasArray;
begin
  inherited;
  If fPesqGrupoProduto(Self, edtCodGrupo, edtDesGru, Nil, Key, arrGrupo) Then
  Begin
    If fValidaCampos(edtCodGrupo, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBalancoEstoqueZerarSaldo.edtCodIteEnter(Sender: TObject);
begin
  inherited;
  pLimpaTela;
end;

procedure TfrmBalancoEstoqueZerarSaldo.edtCodIteExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodIte, edtDesIte, arrProduto, Nil, fRetNomProduto, 'do produto');
end;

procedure TfrmBalancoEstoqueZerarSaldo.edtCodIteKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, nil, Key, arrProduto, False, nil, 'Consulta de Itens', '1') Then
  Begin
    fValidaCampos(edtCodIte, True);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBalancoEstoqueZerarSaldo.edtCodMarExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodMar,edtDesMar,arrMarca,fRetNomMarca,Nil,'da marca');

end;

procedure TfrmBalancoEstoqueZerarSaldo.edtCodMarKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {***************************}
  {* NOVA CONSULTA DE MARCAS *}
  {************************DP*}
  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrMarca, False) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmBalancoEstoqueZerarSaldo.edtCodUniExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodUni,edtDesUni,arrUnidade,fRetNomUnidade,Nil,'da unidade');
end;

procedure TfrmBalancoEstoqueZerarSaldo.edtCodUniKeyPress(Sender: TObject;  var Key: Char);
begin
  inherited;

  If fPesqUnidade(Self, edtCodUni, edtDesUni, nil, nil, Key, arrUnidade, False) Then
  Begin
    fvalidaCampos(edtCodUni, True);
    self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmBalancoEstoqueZerarSaldo.edtLocIniExit(Sender: TObject);
begin
  inherited;
  If edtLocIni.Text <> cIndetImportPlanilhaLocFis Then
  Begin
    edtLocFin.Enabled := True;
    ListaLocFis.Clear;
  End;

end;

Function TfrmBalancoEstoqueZerarSaldo.fSQLFiltros(blnCadLot: Boolean): String;
  Var
    strSQL: String;
Begin
  If Not fEmptyStr(edtLocIni.Text) Then
  Begin
    if not blnCadLot then
    Begin
      If edtLocIni.Text = cIndetImportPlanilhaLocFis Then
        strSQL     := strSQL     + ' AND G.ITE_LOCFIS IN ('+ListaLocFis.Commatext+')'
      Else
      Begin
        If (Not fEmptyStr(edtLocFin.Text)) Then
          strSQL     := strSQL     + ' AND LEFT(G.ITE_LOCFIS, LENGTH(:MAIOR)) BETWEEN :LOCINI AND :LOCFIN '
        Else
          strSQL     := strSQL     + '  AND G.ITE_LOCFIS LIKE :LOCINI ';
      End;
    End
    Else
    Begin
      If edtLocIni.Text = cIndetImportPlanilhaLocFis Then
        strSQL     := strSQL     + ' AND LOT_LOCFIS IN ('+ListaLocFis.Commatext+')'
      Else
      Begin
        If (Not fEmptyStr(edtLocFin.Text)) Then
          strSQL     := strSQL     + ' AND LEFT(LOT_LOCFIS, LENGTH(:MAIOR)) BETWEEN :LOCINI AND :LOCFIN '
        Else
           strSQL     := strSQL     + '  AND LOT_LOCFIS LIKE :LOCINI ';
      End;
    End;

  End;

  If Not fEmptyStr(edtCodIte.Text) Then
  Begin
    If Length(arrProduto) > 1 Then
      strSQL := strSQL + '  AND LOCATE(G.ITE_CODITE,:CODITE) > 0 '
    Else
    Begin
      strSQL := strSQL + '  AND G.ITE_CODITE = :CODITE ';
    End;
  End;

  If Not fEmptyStr(mskLinhaGrupo.Text) Then
  Begin

    {******************************************}
    {BUSCA OS GRUPOS ESCOLHIDOS                }
    {***************************************JC*}
    If Length(arrLinhaGrupo) > 1 Then
      strSQL     := strSQL     + '  AND LOCATE(I.ITE_CODGRU,:CODGRU) > 0 '
    Else
    Begin
     If RightStr(mskLinhaGrupo.Text,3) = '000' Then
       strSQL     := strSQL     + '  AND LEFT(I.ITE_CODGRU,3) = LEFT(:CODGRU,3) '
     Else
       strSQL     := strSQL     + '  AND I.ITE_CODGRU = :CODGRU ';
    End;

  End;

  If Not fEmptyStr(edtCodFor.Text) Then
  Begin
    {******************************************}
    {* BUSCA OS FORNECEDORES ESCOLHIDOS       *}
    {***************************************MV*}
    If Length(arrFornecedor) > 1 Then
      strSQL := strSQL + '  AND LOCATE(I.ITE_CODFOR,:CODFOR) > 0 '
    Else
      strSQL := strSQL + '  AND I.ITE_CODFOR = :CODFOR ';
  End;

  If Not fEmptyStr(edtCodMar.Text) Then
  Begin
    {******************************************}
    {* BUSCA AS MARCAS SELECIONADAS           *}
    {***************************************MV*}
    If Length(arrMarca) > 1 Then
      strSQL := strSQL + '  AND LOCATE(I.ITE_CODMAR,:CODMAR) > 0 '
    Else
      strSQL := strSQL + '  AND I.ITE_CODMAR = :CODMAR '
  End;

  If Not fEmptyStr(edtCodDep.Text) Then
  Begin
    {************************************************}
    {* BUSCA OS DEPARTAMENTOS SELECIONADOS          *}
    {*********************************************TS*}
    If Length(arrDepto) > 1 Then
      strSQL := strSQL + '  AND LOCATE(I.ITE_CODDEP,:CODDEP) > 0 '
    Else
      strSQL := strSQL + '  AND I.ITE_CODDEP = :CODDEP '
  End;

  If Not fEmptyStr(edtCodUni.Text) Then
  Begin
    {******************************************}
    {* BUSCA AS UNIDADES SELECIONADAS         *}
    {***************************************MV*}
    If Length(arrUnidade) > 1 Then
      strSQL := strSQL + '  AND LOCATE(I.ITE_CODUNI,:CODUNI) > 0 '
    Else
      strSQL := strSQL + '  AND I.ITE_CODUNI = :CODUNI ';
  End;

  If Not fEmptyStr(edtCodGrupo.Text) Then
  Begin
    If Length(arrGrupo) > 1 Then
      strSQL := strSQL + '  AND LOCATE(I.ITE_PRDGRU,:PRDGRU) > 0 '
    Else
    Begin
      strSQL := strSQL + '  AND I.ITE_PRDGRU = :PRDGRU ';
    End;
  End;

  If Not fEmptyStr(edtDesIte.Text) Then
    strSQL := strSQL + '  AND I.ITE_DESITE LIKE :DESITE ';

  If blnCadLot Then
  begin
    strSql := strSql + ' AND LOT_NUMLOT <> "A DEFINIR" ';
    strSql := strSql + ' AND LOT_NUMLOT NOT LIKE "FULFILLMENT%" ';
  end;

  If cmbSaldo.ItemIndex <> 2 then
  begin
    If cmbSaldo.ItemIndex = 0 Then
      strSQL := strSQL + '  AND ' + IIF(blnCadLot,'LOT_SALDOS','ITE_SALDOS') + ' > 0 '
    Else
      strSQL := strSQL + '  AND ' + IIF(blnCadLot,'LOT_SALDOS','ITE_SALDOS') + ' < 0 ';
  End;

  Result := strSQL;

  End;

procedure TfrmBalancoEstoqueZerarSaldo.pSetaParametros(qryConsulta: TUniQuery);
  Var
    strLin: String;
    strFor: String;
    strMar: String;
    strDep: String;
    strUni: String;
    strIte: String;
    strGrupo: String;
Begin
  With qryConsulta Do
  Begin
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    If (Not fEmptyStr(edtLocIni.Text)) And (edtLocIni.Text <> cIndetImportPlanilhaLocFis) Then
    Begin

      If (Not fEmptyStr(edtLocFin.Text)) Then
      Begin
        ParamByName('LOCINI').AsString := edtLocIni.Text;
        ParamByName('LOCFIN').AsString := edtLocFin.Text;

        If Length(edtLocIni.Text) > Length(edtLocFin.Text) Then
          ParamByName('MAIOR').AsString := edtLocIni.Text
        Else
          ParamByName('MAIOR').AsString := edtLocFin.Text;

      End
      Else
        ParamByName('LOCINI').AsString := edtLocIni.Text + '%';

    End;

    If Not fEmptyStr(mskLinhaGrupo.Text) Then
    Begin
      pSetaParam(mskLinhaGrupo.Text,arrLinhaGrupo,strLin,'CODGRU', qryConsulta);
    End;

    If Not fEmptyStr(edtCodFor.Text) Then
    Begin
      pSetaParam(edtCodFor.Text, arrFornecedor, strFor, 'CODFOR', qryConsulta);
    End;

    If Not fEmptyStr(edtCodMar.Text) Then
    Begin
      pSetaParam(edtCodMar.Text, arrMarca, strMar, 'CODMAR', qryConsulta);
    End;

    If Not fEmptyStr(edtCodDep.Text) Then
    Begin
      pSetaParam(edtCodDep.Text, arrDepto, strDep, 'CODDEP', qryConsulta);
    End;

    If Not fEmptyStr(edtCodIte.Text) Then
    Begin
      pSetaParam(edtCodIte.Text,arrProduto,strIte,'CODITE',qryConsulta);
    End;

    If Not fEmptyStr(edtCodUni.Text) Then
    Begin
      pSetaParam(edtCodUni.Text, arrUnidade, strUni, 'CODUNI', qryConsulta);
    End;

    If Not fEmptyStr(edtCodGrupo.Text) Then
    Begin
      pSetaParam(edtCodGrupo.Text, arrGrupo, strGrupo, 'PRDGRU', qryConsulta);
    End;

    If Not fEmptyStr(edtDesIte.Text) Then
      ParamByName('DESITE').AsString := '%' + edtDescricao.Text + '%';
  End;
End;


procedure TfrmBalancoEstoqueZerarSaldo.pBuscaZeraItens;
  Var
    strArmazens,
    strSql: String;

begin
  strArmazens := TCadLot.fRetLotesContagemAberta;

  qryConsulta := Nil;
  strSql := '';
  strSql := strSql + ' SELECT                                                  ';
  strSql := strSql + ' 	 SQL_NO_CACHE                                          ';
  strSql := strSql + ' 	 "          " AS ITE_NUMLOT,                           ';
  strSql := strSql + ' 	 IF(I.ITE_ITEATI="S", "Ativo", "Inativo") AS ITE_ITEATI, ';
  strSql := strSql + ' 	 G.ITE_CODEMP AS ITE_CODEMP,                           ';
  strSql := strSql + ' 	 I.ITE_CODGRU AS ITE_CODGRU,                           ';
  strSql := strSql + ' 	 G.ITE_CODITE AS ITE_CODITE,                           ';
  strSql := strSql + ' 	 I.ITE_DESITE AS ITE_DESITE,                           ';
  strSql := strSql + ' 	 U.UNI_SIGUNI AS UNI_SIGUNI,                           ';
  strSql := strSql + ' 	 G.ITE_SALDOS AS ITE_SALCON,                           ';
  strSql := strSql + ' 	 G.ITE_LOCFIS AS ITE_LOCFIS                            ';
  strSql := strSql + ' FROM                                                    ';
  strSql := strSql + ' 	 ITEGER G                                              ';
  strSql := strSql + ' 	 JOIN CADITE      I ON  G.ITE_CODITE = I.ITE_CODITE    ';
  strSql := strSql + ' 	 LEFT JOIN CADUNI U ON (I.ITE_CODUNI = U.UNI_CODUNI)   ';
  strSql := strSql + ' WHERE                                                   ';
  strSql := strSql + ' 	 G.ITE_DIGCON = "N" AND                                ';
  strSql := strSql + '   I.ITE_ITEATI = "S" AND                                ';
  strSql := strSql + '   G.ITE_CODEMP =:CODEMP                                 ';

  strSql := strSql +   fSQLFiltros(False);

  strSql := strSql + '  AND (SELECT COUNT(*) FROM CADLOT WHERE LOT_CODITE = I.ITE_CODITE AND LOT_CODEMP = :CODEMP) = 0 ';

  strSql := strSql + ' UNION ALL                                               ';

  strSql := strSql + ' SELECT                                                  ';
  strSql := strSql + ' 	 SQL_NO_CACHE                                          ';
  strSql := strSql + ' 	 LOT_NUMLOT   AS ITE_NUMLOT,                           ';
  strSql := strSql + '   IF(LOT_STATUS="S", "Ativo", "Inativo") AS ITE_ITEATI, ';
  strSql := strSql + ' 	 LOT_CODEMP   AS ITE_CODEMP,                           ';
  strSql := strSql + ' 	 I.ITE_CODGRU AS ITE_CODGRU,                           ';
  strSql := strSql + ' 	   LOT_CODITE AS ITE_CODITE,                           ';
  strSql := strSql + ' 	 I.ITE_DESITE AS ITE_DESITE,                           ';
  strSql := strSql + ' 	 U.UNI_SIGUNI AS UNI_SIGUNI,                           ';
  strSql := strSql + ' 	   LOT_SALDOS AS ITE_SALCON,                           ';
  strSql := strSql + ' 	   LOT_LOCFIS AS ITE_LOCFIS                            ';
  strSql := strSql + ' FROM                                                    ';
  strSql := strSql + ' 	 CADLOT                                                ';

  strSql := strSql + ' INNER JOIN ITEGER G ON LOT_CODITE = G.ITE_CODITE AND    ';
  strSql := strSql + '                	      G.ITE_CODEMP = LOT_CODEMP        ';

  strSql := strSql + ' INNER JOIN CADITE I ON LOT_CODITE = I.ITE_CODITE        ';

  strSql := strSql + ' LEFT  JOIN CADUNI U ON (I.ITE_CODUNI = U.UNI_CODUNI)    ';

  strSql := strSql + ' WHERE                                                   ';
  strSql := strSql + ' 	 LOT_DIGCON = "N" AND                                  ';
  strSql := strSql + ' 	 LOT_STATUS = "S" AND                                  ';
  strSql := strSql + '   I.ITE_ITEATI = "S" AND                                ';
  strSql := strSql + '   G.ITE_CODEMP = :CODEMP                            ';

  strSql := strSql +   fSQLFiltros(True);

  If Not fEmptyStr(strArmazens) Then
    strSQL := strSQL + ' AND ((LOT_CODITE IS NULL) OR (LOT_NUMLOT IN (' + strArmazens + '))) ';

  strSql := strSql + ' 	ORDER BY                                               ';
  strSql := strSql + ' 	  ITE_CODGRU,                                          ';
  strSql := strSql + ' 	  ITE_CODITE,                                          ';
  strSql := strSql + ' 	  ITE_NUMLOT                                           ';

  qryConsulta := qryGen;

  With qryConsulta Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSql);

    pSetaParametros(qryConsulta);
    Open;

    If Not IsEmpty Then
    Begin
      dtsItens.DataSet := qryConsulta;
      cxgDadosDBTableViewCitel.ApplyBestFit();
      TFloatField(qryConsulta.FieldByName('ITE_SALCON')).DisplayFormat := '#,##0.000';
      pHabilitaTela;
      pSetFocus(cxgDados);
    End
    Else
    Begin
      pLimpaTela;
      fMensagem('', 'Nenhum registro encontrado !',['&O K']);
    End;
  end;
end;

function TfrmBalancoEstoqueZerarSaldo.fZeraItens(pgbProgresso: TcxProgressBar): Boolean;
var
  strArmazens,
  strSql: string;
begin
  strArmazens := TCadLot.fRetLotesContagemAberta;


  Result := True;
  strSql := strSql + ' UPDATE                                                  ';
  strSql := strSql + ' 	 ITEGER G                                              ';

  strSql := strSql + '   INNER JOIN CADITE I ON G.ITE_CODITE = I.ITE_CODITE    ';
  strSql := strSql + ' 	 LEFT JOIN CADLOT ON G.ITE_CODITE = LOT_CODITE  AND    ';
  strSql := strSql + ' 	                     G.ITE_CODEMP = LOT_CODEMP         ';

  strSql := strSql + ' SET                                                     ';
  strSql := strSql + ' 	 G.ITE_SALCON = 0,                                     ';
  strSql := strSql + ' 	 G.ITE_ORDCON = 0,                                     ';
  strSql := strSql + ' 	 G.ITE_GMLCON = 0,                                     ';
  strSql := strSql + ' 	 G.ITE_DIFSAL = 0,                                     ';
  strSql := strSql + ' 	 G.ITE_DIF_ML = 0,                                     ';
  strSql := strSql + ' 	 G.ITE_DIGCON = "S"                                    ';

  strSql := strSql + ' WHERE                                                   ';
  strSql := strSql + '   G.ITE_DIGCON = "N" AND                                ';


  strSql := strSql + '   G.ITE_CODEMP = :CODEMP                                ';


  strSql := strSql +   fSQLFiltros(False);

  If Not fEmptyStr(strArmazens) Then
    strSQL := strSQL + ' AND ((LOT_CODITE IS NULL) OR (LOT_NUMLOT IN (' + strArmazens + '))) ';

  strSql := strSql + '  AND (SELECT COUNT(*) FROM CADLOT WHERE LOT_CODITE = I.ITE_CODITE AND LOT_CODEMP = :CODEMP) = 0 ';

  qryUpdade   := fCriaQuery;
  qryConsulta := qryUpdade;

  frmGravando.lblGravando.Caption := 'Aguarde, gravando log de contagem...';
  Application.ProcessMessages;

  // A MESMA TRAVA SERVE A HISTÓRICO DE CONTAGEM
  If fLock_Unlock(STR_TRAVA_CONDET, True, False) Then
  Begin
    If Not TConDet.fGravaConDetItens(Self, fSQLFiltros(False), VS_strCodEmp, 'S', pSetaParametros) Then
    Begin
      Result := False;
      fLock_Unlock(STR_TRAVA_CONDET, False, False);
      Exit;
    End;

  End Else
  Begin
    pMensagemOk('Uma tarefa de balanço está sendo feita em outra estação: ' + fGetHostLock(STR_TRAVA_CONDET) + '. Tente novamente!');
    Exit;
  End;

  With qryConsulta Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSql);

    pSetaParametros(qryConsulta);

    Try
      If THistoricoBalanco.fDeveGravarHistorico Then
        pValidaProCod('HISBAL');

      fStartTransaction;
      TControleContagemBalancoEstoque.pIncluiBalgerZeraSaldoProduto(fSQLFiltros(False), strArmazens, pSetaParametros);
      THistoricoBalanco.pIncluiHistoricoZeraSaldoProduto(fSQLFiltros(False), strArmazens, pSetaParametros);

      ExecSQL;

      if fCfgSis('CONDET', varBoolean) Then
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' DELETE L                                             ');
        SQL.Add(' FROM LOCCON L                                        ');
        SQL.Add('   INNER JOIN CADITE I ON I.ITE_CODITE = L.ITE_CODITE ');
        SQL.Add('   INNER JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE ');
        SQL.Add('                      AND G.ITE_CODEMP = :CODEMP      ');
        SQL.Add(' WHERE TRUE ');
        SQL.Add( fSQLFiltros(False));
        pSetaParametros(qryConsulta);
        ExecSQL;
      End;

      If fZeraLote Then
      Begin
        fCommit;
        fMensagem('', 'Contagem de estoque zerada para os itens !',['&O K']);
        pLimpaTela;
      End
      Else
      Begin
        fRollBack;
        fMensagem('', 'Não foi possível zerar os dados!',['&O K']);
      End;

      FreeAndNil(qryUpdade);
    Except
      On E: Exception Do
      Begin
        fRollBack;
        Result := False;
        pMensagensErro(E.Message, '[TfrmBalancoEstoqueZerarSaldo.pBuscaZeraItens]');
      End;
    End;
  End;

  fLock_Unlock(STR_TRAVA_CONDET, False, False);
end;

Function TfrmBalancoEstoqueZerarSaldo.fZeraLote: Boolean;
  Var
    objCadLot: TCadLot;
Begin
  Try
    objCadLot := TCadLot.Create(Self);
    With qryGen Do
    Begin
      DisableControls;

      Filter   := 'ITE_NUMLOT <> ' + QuotedStr('          ');
      Filtered := True;

      frmGravando.lblGravando.Caption := 'Aguarde, atualizando contagem dos lotes...';
      frmGravando.pgbStatus.Properties.Max := qryGen.RecordCount;
      frmGravando.pgbStatus.Position := 0;
      Application.ProcessMessages;

      First;
      Result := objCadLot.fZeraContagemLote(False, fSQLFiltros(True), pSetaParametros);

      Filtered := False;

      EnableControls;
    End;
    FreeAndNil(objCadLot);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro('', E.Message + '[fZeraLote] ');
    End;
  End;

End;

procedure TfrmBalancoEstoqueZerarSaldo.pHabilitaTela;
begin
  cxgDados.Enabled    := True;
  btnConfirma.Enabled := True;
  edtLocIni.Enabled   := False;
  edtLocFin.Enabled   := False;
  edtCodFor.Enabled   := False;
  edtCodMar.Enabled   := False;
  edtCodDep.Enabled   := False;
  edtCodUni.Enabled   := False;
  edtDesIte.Enabled   := False;
end;

procedure TfrmBalancoEstoqueZerarSaldo.pLimpaTela;
begin
  dtsItens.DataSet       := Nil;
  cxgDados.Enabled       := False;
  btnConfirma.Enabled    := False;
  edtLocIni.Enabled      := True;
  edtLocFin.Enabled      := True;
  edtCodFor.Enabled      := True;
  edtCodMar.Enabled      := True;
  edtCodDep.Enabled      := True;
  edtCodUni.Enabled      := True;
  edtCodIte.Enabled      := True;
  edtDescricao.Enabled   := True;
  ListaLocFis.Clear;

  mskLinhaGrupo.Clear;
  edtDescricao.Clear;
  edtLocIni.Clear;
  edtLocFin.Clear;
  edtCodFor.Clear;
  edtCodMar.Clear;
  edtCodDep.Clear;
  edtCodUni.Clear;
  edtDesIte.Clear;
  edtDesGrupo.Clear;
  edtNomFor.Clear;
  edtDesMar.Clear;
  edtDesUni.Clear;
  edtCodIte.Clear;

  Self.SelectFirst;
end;

procedure TfrmBalancoEstoqueZerarSaldo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(ListaLocFis);
  inherited;

end;

procedure TfrmBalancoEstoqueZerarSaldo.FormCreate(Sender: TObject);
begin
  inherited;
  dtsItens := TDataSource.Create(Self);
  ListaLocFis := TStringList.Create;
  cxgDadosDBTableViewCitel.DataController.DataSource := dtsItens;
  qryGen := fCriaQuery(Self);
end;

procedure TfrmBalancoEstoqueZerarSaldo.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If btnConfirma.Enabled Then
  Begin
    Try
      pCriarFormularios(TfrmGravando, frmGravando);
      frmGravando.fExecutarAcao := fZeraItens;
      frmGravando.lblGravando.Caption := 'Aguarde, gravando quantidade zero na contagem...';
      frmGravando.ShowModal;
    Finally
      FreeAndNil(frmGravando);
    End;
  End;
end;

procedure TfrmBalancoEstoqueZerarSaldo.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F10 : btnConfirma.Click;
    VK_F9 : btnFiltrosLocalizacao.Click;
  End;
end;

procedure TfrmBalancoEstoqueZerarSaldo.FormShow(Sender: TObject);
  Var
    strCodAmz: String;
    intNumAmz: Integer;
begin
  inherited;
  Self.SelectFirst;

  If (fCfgSis('CTLEST') = '2') And TCadLot.fTemContagemArmazem(strCodAmz, intNumAmz) Then
    If intNumAmz > 1 Then
      Caption := Caption + ' - Armazéns ' + strCodAmz
    Else
      Caption := Caption + ' - Armazém ' + strCodAmz + '-' + fRetNomeArmazem(strCodAmz);

end;

function TfrmBalancoEstoqueZerarSaldo.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
Begin

  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = edtCodGrupo) Then
    Begin

      If blnValidaIndividual then
        pBuscaZeraItens;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
End;

end.

