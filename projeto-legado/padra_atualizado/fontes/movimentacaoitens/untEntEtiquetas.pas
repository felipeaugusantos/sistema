unit untEntEtiquetas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, frxClass, frxDBSet, DB, UniClientDataSet, UniDataSetProvider,
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask, MaskEditFocus, Grids,
  DBGridCitel, DBGrids, Buttons, ExtCtrls, untFuncoesSimples, untTypesSistema, TypesRel,
  untFuncoesEtiquetas, frxBarcode, BitBtnLockedIncrem, ImgList,
  MemDS, DBAccess, Provider, frxExportCSVTestabilidade, System.ImageList,
  Datasnap.DBClient, untConsultas, untFuncoesConsulta;

type

  TfrmEntEtiquetas = class(TfrmPaiOrdena)
    frxReport: TfrxReport;
    frxDBImpEti: TfrxUserDataSet;
    lblOrdPro: TLabel;
    shpOrdPro: TShape;
    btnImprimir: TBitBtnLocked;
    imgLista: TImageList;
    btnMarcar: TBitBtnLocked;
    btnDesmarcar: TBitBtnLocked;
    chkImpNot: TCheckBox;
    Label11: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    edtSerEnt: TEditFocus;
    edtEspEnt: TEditFocus;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    edtNotEnt: TEditFocus;
    btnMarDes: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure frxDBImpEtiCheckEOF(Sender: TObject; var Eof: Boolean);
    procedure frxDBImpEtiFirst(Sender: TObject);
    procedure frxDBImpEtiGetValue(const VarName: String;
      var Value: Variant);
    procedure frxDBImpEtiNext(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure frxDBImpEtiPrior(Sender: TObject);
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgConsultaColEnter(Sender: TObject);
    procedure dbgConsultaCellClick(Column: TColumn);
    procedure dbgConsultaDblClick(Sender: TObject);
    procedure dbgConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnDesmarcarClick(Sender: TObject);
    procedure btnMarcarClick(Sender: TObject);
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure btnMarDesClick(Sender: TObject);
  private
    { Private declarations }
    arrFornec: TConsultasArray;

    tipTipoEtiqueta: TTipoImpressaoEntEtq;

    FReimpressao: Boolean;
    FNumSeq : Integer;

    intPreTab: Integer;
    strCodCnd: String;
    strCndPag: String;
    strNumPar: String;
    IntQtdEti: Integer;
    strIdeDig,
    strTipImp: String;
    strNomImp: String;
    strNomPro: string;
    strDesPro: string;

    stlPed: TStringList;

    intColAtu: Integer;
    cpuCampos: TCamposUso;

    qryImpEti: TUniQuery;
    dtsImpEti: TDataSource;
    updImpEti: TUniUpdateSQL;

    strAutGerEle,
    strNumDoc,
    strEspDoc,
    strCodFor,
    strSerie_: String;
    FlstItens: TStringList;

    blnMostrarTodosLote : Boolean;
    dtaDtaPre : TDate;

    {*****************************************}
    {* MATRIZ QUE REPRESENTARÁ 1 LINHA DE    *}
    {* ETIQUETAS. Ex: EM UMA IMPRESSÃO DE 2  *}
    {* COLUNAS, A MATRIZ CONTERÁ 2 ETIQUETAS *}
    {**************************************MV*}
    arrLinhasEti: Array Of String;

    procedure pInicializaColuna;
    procedure pImpEtiquetasMatricial;
    procedure pAtualizaCamposUso;
    procedure pAtribuiCamposUso;
    procedure pFinalizaCamposUso;
    procedure pImpRegistro(intQtdImp: Integer);
    procedure pImpArrLinhasEti;
    function  fRetornaSQLIte(stlCodIte: TStringList): String;

    procedure pAddColunaPrecos;

    function fGetSQLPreNota(blnFiltrarGerele: Boolean = False): String;
    function fGetSQLConfPed: String;
    function fSqlLotePreco: String;
    function fGetSQLXML: String;
    function fGetSQLPedido(blnCnvMltVen: Boolean = False): string;
    function fGetSQLMovDet: string;

    function fRetCamposIBPT(blnPreven: Boolean): string;
    function fJoinIBPT: string;

  public
    blnPreNotaFiltraAutInc: Boolean;
    { Public declarations }
    class procedure pImpEtiAtivacaoLotePreco(dtaDtaPreA : TDate);

    class procedure pImpEtiEntradaMercadorias(strNumDocA, strEspDocA, strCodForA, strSerie_A: String;
       blnControlados: Boolean = False; tpeEtique: TTipoEtiqueta = tpeItensControladosLaser; lstItens: TStringList = nil);

    class procedure pImpEtiPedidoDeCompra(strNumDocA, strEspDocA, strCodForA: String; lstItens: TStringList = nil);

    class procedure pImpEtiConfPedido(stlPedidos: TStringList);

    class procedure pImpEtiPreNota(strIdeDigA: String; blnFiltraAutInc: Boolean = False);

    class procedure pImpEtiXML(strAutGerEleA: String);

  protected
    function fGetSql(blnLike: Boolean): String; Override;
    function fSetParametros: Boolean;  Override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

implementation

uses untCfgRel, untConstantes,untFuncoesRel,
                untFuncoesEtiqItens, {untInfAdicEtiqItens, } untFuncMacro;

{$R *.dfm}

procedure TfrmEntEtiquetas.pInicializaColuna;
Begin
  lflLastField.intIndCol := 1;
  lflLastField.strNomCam := dbgConsulta.Columns[lflLastField.intIndCol].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[lflLastField.intIndCol].Title.Caption;
  lflLastField.ftyTipCam := dbgConsulta.DataSource.DataSet.FieldByName(dbgConsulta.Columns[lflLastField.intIndCol].FieldName).DataType;
End;

procedure TfrmEntEtiquetas.FormShow(Sender: TObject);
begin
  inherited;

  blnTemSelecao       := False;
  blnSempreRelerBanco := False;

  If FReimpressao Then
  Begin
    pnlHeader.Visible := True;
    pSetFocus(edtNotEnt);
  End Else
  Begin
    pInicializaColuna;
    pSetFocus(dbgConsulta);
    cdsConsulta.FieldByName('QTDETI').FocusControl;
  End;

  If tipTipoEtiqueta = etqProdutosControlados Then
    Caption := 'Impressão de Etiquetas de Produtos Controlados';

  chkImpNot.Visible := tipTipoEtiqueta In [etqEntradaMercadorias];
end;

procedure TfrmEntEtiquetas.dbgConsultaCellClick(Column: TColumn);
begin
  inherited;
  if Column.FieldName = 'IMP_S_N' Then
  Begin
    With cdsConsulta Do
    Begin
      Edit;
      if FieldByName('IMP_S_N').AsInteger = 0 Then
        FieldByName('IMP_S_N').AsInteger := 1
      Else
        FieldByName('IMP_S_N').AsInteger := 0;
      Post;
    End;
  End;

end;

procedure TfrmEntEtiquetas.dbgConsultaDblClick(Sender: TObject);
begin
  inherited;
  dbgConsultaCellClick( dbgConsulta.Columns.Items[0] );

end;

procedure TfrmEntEtiquetas.dbgConsultaColEnter(Sender: TObject);
begin
  inherited;
  if dbgConsulta.Columns.Items[dbgConsulta.SelectedIndex].ReadOnly Then
    dbgConsulta.Options := dbgConsulta.Options - [dgEditing]
  Else
    dbgConsulta.Options := dbgConsulta.Options + [dgEditing];

end;

procedure TfrmEntEtiquetas.dbgConsultaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin

  If fEmptyStr(cdsConsulta.FieldByName('CODBAR').AsString) Then
    dbgConsulta.Canvas.Font.Color := clRed;

  inherited;

  if SameText(Column.Field.FieldName, 'IMP_S_N') then
  Begin
    TDBGridCitel(Sender).Canvas.FillRect(Rect);
    imgLista.Draw(TDBGridCitel(Sender).Canvas, Rect.Left+1, Rect.Top, 0);
    If (Column.Field.AsInteger = 1) then
      imgLista.Draw(TDBGridCitel(Sender).Canvas, Rect.Left+1, Rect.Top+1, 1)
    Else
      imgLista.Draw(TDBGridCitel(Sender).Canvas, Rect.Left+1, Rect.Top+1, 2);

  end;

end;

procedure TfrmEntEtiquetas.dbgConsultaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_SPACE) Or (Key = VK_RETURN) Then
    dbgConsultaCellClick( dbgConsulta.Columns.Items[0] );
end;

procedure TfrmEntEtiquetas.edtCodForExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodFor, edtNomFor, arrFornec, fRetNomFornecedor, nil, 'do Fornecedor');
end;

procedure TfrmEntEtiquetas.edtCodForKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmEntEtiquetas.fGetSQLPreNota(blnFiltrarGerele: Boolean = False): String;
var
  intIndex: Integer;
  blnPreNotaConferencia : Boolean;
Begin

  { Rotina conferencia pré-nota e não usa TABPRF }
  blnPreNotaConferencia := (Not blnFiltrarGerele) And (Not fCfgSis('TABPRF', varBoolean));

  Result := '';

  Result := Result + ' SELECT                      ';
  Result := Result + '   G.ITE_CODEMP AS NOMEMP,   ';
  Result := Result + '   I.ITE_APLICA AS APLICA,   ';
  Result := Result + '     ITE_DESITE AS DESITE,   ';
  Result := Result + '   I.ITE_DESSIM AS DESSIM, ';
  Result := Result + '   I.ITE_REFERE AS REFERE,   ';
  Result := Result + '   G.ITE_CODITE AS CODITE,   ';
  Result := Result + '   I.ITE_CODGRU AS CODGRU,   ';
  Result := Result + '   I.ITE_MENFIS AS MENFIS, ';
  Result := Result + '   I.ITE_MSGLV1 AS MSGLV1, ';
  Result := Result + '   I.ITE_MSGLV2 AS MSGLV2, ';
  Result := Result + '     UNI_SIGUNI AS SIGUNI,   ';

  Result := Result + fRetCamposIBPT(False);

  if blnFiltrarGerele then
    Result := Result + '     I10_QCOM AS QTDETI,   '
  else
    Result := Result + '     DIG_QTDITE AS QTDETI, ';

  Result := Result + ' ITF.ITE_CODITF AS CODITF,   ';
  Result := Result + '     B08_NNF    AS NUMDOC,   ';
  Result := Result + '     "NF"       AS ESPDOC,   ';
  Result := Result + '     B07_SERIE  AS SERIE_,   ';
  Result := Result + '   G.ITE_LOCFIS AS LOCFIS,   ';
  Result := Result + '   G.ITE_LOCSUP AS LOCSUP,   ';
  Result := Result + '     FOR_CODFOR AS CODFOR,   ';
  Result := Result + '     FOR_NOMFOR AS NOMFOR,   ';

  Result := Result + '   0.0000 AS VALITE,         ';
  Result := Result + '   0.0000 AS VALVIS,         ';


  Result := Result + '   0.0000 AS PREVIS, ';
  Result := Result + '   0.0000 AS VALPAR, ';

  Result := Result +  '1 AS QTDPAR, ';

  Result := Result + '   0.0000 AS TOTPRA, ';

  Result := Result + '   I.ITE_CODFAB AS CODFAB,   ';
  Result := Result + '     MAR_DESMAR AS DESMAR,   ';;


  Result := Result + '     IPR_PREVEN AS PROMOC,   ';
  Result := Result + '   IFNULL(IPR_PERDES, 0) AS PERDES, ';
  Result := Result + '  IFNULL(IPR_QTDMIN, 0) AS QTDMIN, ';

  Result := Result + '   G.ITE_PREVE1 AS PREVE1,   ';
  Result := Result + '   G.ITE_PREVE2 AS PREVE2,   ';
  Result := Result + '   G.ITE_PREVE3 AS PREVE3,   ';
  Result := Result + '   G.ITE_PREVE4 AS PREVE4,   ';
  Result := Result + '   G.ITE_PREVE5 AS PREVE5,   ';
  Result := Result + '   G.ITE_PREVE6 AS PREVE6,   ';
  Result := Result + '   G.ITE_PREVE7 AS PREVE7,   ';

  Result := Result + '  CAST("" AS CHAR(1)) AS EMPNOM,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS FANEMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS IESEMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS CEPEMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS ENDEMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS BAIRRO,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS ENDNUM,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS ENDCMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS CIDEMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS ESTEMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS NUMSEQ,   ';

  For intIndex := 0 To 9 Do
  Begin
    Result := Result + ' ( SELECT ITB_QTDEMB                         ';
    Result := Result + '   FROM ITEEMB                               ';
    Result := Result + '   WHERE ITB_CODITE = G.ITE_CODITE      ';
    Result := Result + '     AND ITB_CODEMP = G.ITE_CODEMP      ';
    Result := Result + '   ORDER BY ITB_QTDEMB DESC                  ';
    Result := Result + '   LIMIT '+ IntToStr(intIndex) +',1) AS QTDEM'+ IntToStr(intIndex) + ', ';

    Result := Result + ' ( SELECT ITB_DESCON                         ';
    Result := Result + '   FROM ITEEMB                               ';
    Result := Result + '   WHERE ITB_CODITE = G.ITE_CODITE      ';
    Result := Result + '     AND ITB_CODEMP = G.ITE_CODEMP      ';
    Result := Result + '   ORDER BY ITB_QTDEMB DESC                  ';
    Result := Result + '   LIMIT '+ IntToStr(intIndex) +',1) AS DESCO'+ IntToStr(intIndex) + ', ';

    Result := Result + ' ( SELECT ITB_TABPRE                         ';
    Result := Result + '   FROM ITEEMB                               ';
    Result := Result + '   WHERE ITB_CODITE = G.ITE_CODITE      ';
    Result := Result + '     AND ITB_CODEMP = G.ITE_CODEMP      ';
    Result := Result + '   ORDER BY ITB_QTDEMB DESC                  ';
    Result := Result + '   LIMIT '+ IntToStr(intIndex) +',1) AS TABPR'+ IntToStr(intIndex) + ', ';
  End;

  Result := Result + ' I.ITE_DTAALT AS DTAALT,';
  Result := Result + ' I.ITE_CODMAR AS CODMAR,';

  Result := Result + ' G.ITE_AMZETI AS AMZETI,';
  Result := Result + ' I.ITE_ITEATI AS ITEATI,';
  Result := Result + '   CONCAT(I.ITE_CODFAB, " ", CADMAR.MAR_DESMAR) AS FABMAR,   ';
  Result := Result + '   E.EMP_C_G_C_ AS EMPCGC,   ';

  Result := Result + '  CAST("" AS CHAR(1)) AS LOTECR, ';

  Result := Result + '  G.ITE_SALDOS AS SALDOS,  ';
  Result := Result + '  E.EMP_FONDA1 AS FONDA1,  ';
  Result := Result + '  E.EMP_FONDA2 AS FONDA2,  ';

  Result := Result + '   I.ITE_CODBAR AS CODBAR,   ';
  Result := Result + '     IFNULL(DET_EMBALA, 1) AS  EMBALA, ';
  Result := Result + '   IF(IFNULL(B.BAR_PREVEN, 0) =  0, 0.00, B.BAR_PREVEN) AS EMBPRE, ';
  Result := Result + '  CAST("" AS CHAR(1)) AS DESEMB, ';

  Result := Result + '   G.ITE_TABEMF AS TABEMF, ';
  Result := Result + '   G.ITE_DESFEC AS DESFEC, ';
  Result := Result + '   G.ITE_EMBFEC AS EMBFEC, ';
  Result := Result + '  CAST("" AS CHAR(1)) AS OBSIMP, ';

  Result := Result + '  (SELECT GROUP_CONCAT(CADSEM.SEM_CODSEM) ';
  Result := Result + '     FROM CADSEM ';
  Result := Result + '    WHERE CADSEM.SEM_CODITE = I.ITE_CODITE ';
  Result := Result + '      AND CADSEM.SEM_CODEMP = I.ITE_CODEMP)AS CODSEM, ';

  Result := Result + '  ITE_VALIDA AS VALIDA,';
  Result := Result + '  ITE_ITESAC AS ITESAC, ';
  Result := Result + '  ITE_COMPOS AS COMPOS, ';
  Result := Result + '  ITE_PAISOR AS PAISOR, ';
  Result := Result + '  ITE_ESTMIN AS ESTMIN, ';
  Result := Result + '  ITE_ESTMAX AS ESTMAX, ';
  Result := Result + '  I.ITE_MLTVEN AS MLTVEN, ';
  Result := Result + '  ITE_IPISAI AS IPISAI,  ';

  Result := Result + '  OPE_CODOPE AS OPEIMP, ';
  Result := Result + '  OPE_NOMOPE AS NOMOPE, ';
  Result := Result + '  (SELECT FROM_BASE64(ITE_IMGB64) FROM ITEIMG WHERE ITEIMG.ITE_CODITE = I.ITE_CODITE AND ITEIMG.ITE_PRINCI = "S" ORDER BY ITEIMG.AUTOINCREM DESC LIMIT 1) AS PROIMG, ';


 Result := Result + '   I.ITE_ATICOM AS ATICOM,   ';

  Result := Result + '   G.ITE_PREVE1,             ';
  Result := Result + '   G.ITE_PREVE2,             ';
  Result := Result + '   G.ITE_PREVE3,             ';
  Result := Result + '   G.ITE_PREVE4,             ';
  Result := Result + '   G.ITE_PREVE5,             ';
  Result := Result + '   G.ITE_PREVE6,             ';
  Result := Result + '   G.ITE_PREVE7,             ';

  if blnFiltrarGerele then
    Result := Result + '   DE.AUTOINCREM,             '
  else
    Result := Result + '   D.AUTOINCREM,             ' ;

  Result := Result + '   FALSE AS IMP_S_N,         ';
  Result := Result + '   CAST("" AS CHAR(1)) AS ALTPRE, ';
  Result := Result + '   FOR_C_G_C_ AS CGCFOR ';

  {Localizações Adicionais}
  If fCfgSis('CADLOC', varBoolean) Then
  Begin
    Result := Result + ' ,(SELECT                                 ';
    Result := Result + '    GROUP_CONCAT(CADLOC.LOC_DESCRI)      ';
    Result := Result + '  FROM                                   ';
    Result := Result + '    LOCFIS                               ';
    Result := Result + '    INNER JOIN CADLOC ON (CADLOC.LOC_CODLOC = LOCFIS.LOC_LOCFIS AND ';
    Result := Result + '                          CADLOC.LOC_CODEMP = LOCFIS.LOC_CODEMP)    ';
    Result := Result + '  WHERE                                       ';
    Result := Result + '    LOCFIS.LOC_CODITE = I.ITE_CODITE AND ';
    Result := Result + '    LOCFIS.LOC_CODEMP = :CODEMP AND      ';
    Result := Result + '    CADLOC.LOC_ATIVO_ <> "N") AS LOCADI  ';
  End
 Else
  Begin
    Result := Result + ' ,(SELECT                                 ';
    Result := Result + '    GROUP_CONCAT(LOC_LOCFIS)             ';
    Result := Result + '  FROM                                   ';
    Result := Result + '    LOCFIS                               ';
    Result := Result + '  WHERE                                  ';
    Result := Result + '    LOC_CODITE = I.ITE_CODITE AND   ';
    Result := Result + '    LOC_CODEMP = :CODEMP) AS LOCADI ';
  End;

  Result := Result + ' FROM ';

  if blnFiltrarGerele then
  begin
    Result := Result + ' GERELE NE ';
    Result := Result + ' INNER JOIN DETELE DE ON DE.DET_SEQGER = NE.AUTOINCREM ';
    Result := Result + ' INNER JOIN CADITE I ON I.ITE_CODITE = DE.DET_CODITE   ';

    Result := Result + ' INNER JOIN ITEGER G ON G.ITE_CODITE = DE.DET_CODITE AND ';
    Result := Result + '                          G.ITE_CODEMP = :CODEMP ';
  end
  else
  begin
    Result := Result + ' DIGELE D    ';
    Result := Result + ' INNER JOIN GERELE NE ON D.DIG_IDEDIG = NE.GER_IDEDIG AND D.DIG_CODEMP = NE.GER_CODEMP ';
    Result := Result + ' INNER JOIN DETELE DE ON DE.DET_SEQGER = NE.AUTOINCREM AND DE.DET_CODITE = DIG_CODITE ';
    Result := Result + ' INNER JOIN CADITE I ON I.ITE_CODITE = DIG_CODITE   ';

    Result := Result + ' INNER JOIN ITEGER G ON G.ITE_CODITE = DIG_CODITE AND ';
    Result := Result + '                          G.ITE_CODEMP = :CODEMP ';
  end;

  Result := Result + ' INNER JOIN CADEMP E ON       ';
  Result := Result + '   EMP_CODEMP = G.ITE_CODEMP  ';


  Result := Result + '  LEFT JOIN ITEBAR B ';
  Result := Result + '  ON B.BAR_CODITE = I.ITE_CODITE ';
  Result := Result + '  AND B.BAR_CODEMP = G.ITE_CODEMP AND BAR_CODBAR = I.ITE_CODBAR';

  Result := Result + ' LEFT  JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';

  Result := Result + ' INNER JOIN CADMAR ON       ';
  Result := Result + '   MAR_CODMAR = ITE_CODMAR  ';

  Result := Result + ' LEFT JOIN (SELECT IPR_PREVEN, IPR_CODITE, IPR_PERDES, IPR_QTDMIN  FROM CADPRO JOIN ITEPRO ON CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER ';
  Result := Result + '                                                       JOIN PROEMP ON CADPRO.AUTOINCREM = PROEMP.PRO_SEQGER ';
  Result := Result + '             WHERE  ';
  Result := Result + '               PROEMP.PRO_CODEMP = :CODEMP AND ' + fCurrentDate + ' BETWEEN PRO_DTAINI AND PRO_DTAFIN ';
  Result := Result + '               ORDER BY IPR_QTDMIN ASC LIMIT 1) AS TMP ON IPR_CODITE = G.ITE_CODITE ';

  Result := Result + ' LEFT JOIN CADFOR ON        ';
  Result := Result + '   FOR_CODFOR = NE.GER_CODFOR  ';
  Result := Result + ' LEFT JOIN ITEFOR ITF ON ITF.ITE_CODFOR = CADFOR.FOR_CODFOR AND ITF.ITE_CODITE = I.ITE_CODITE ' + IIF(blnPreNotaConferencia, ' AND DE.I02_CPROD = ITF.ITE_CODITF ' , '');
  Result := Result + ' LEFT JOIN CADOPE ON OPE_CODOPE = "'+strLoginUsuarioLogado+'"';

  Result := Result + fJoinIBPT;
  Result := Result + ' WHERE      ';

  if blnFiltrarGerele then
  begin
    Result := Result + '   NE.AUTOINCREM = ' + QuotedStr(strAutGerEle);
  end
  else
  begin
    Result := Result + '   NE.GER_DTACON IS NULL AND ';
    Result := Result + '   D.DIG_CODEMP = :CODEMP AND ';
    Result := Result + '   D.DIG_IDEDIG = ' + QuotedStr(strIdeDig);
  end;

  Result := Result;

End;

function TfrmEntEtiquetas.fGetSQLXML: String;
  var
    intIndex: Integer;
Begin
  (***********************************************************************************)
  (* QUANDO ALTERAR ESSE SELECT ALTERAR TAMBEM TODOS OS SQL'S DESTA FUNÇÃO           *)
  (***********************************************************************************)
  Result := '';
  Result := Result + ' SELECT                      ';
  Result := Result + '   G.ITE_CODEMP AS NOMEMP,   ';
  Result := Result + '   I.ITE_APLICA AS APLICA,   ';
  Result := Result + '     ITE_DESITE AS DESITE,   ';
  Result := Result + '   I.ITE_DESSIM AS DESSIM, ';
  Result := Result + '   I.ITE_REFERE AS REFERE,   ';
  Result := Result + '   G.ITE_CODITE AS CODITE,   ';
  Result := Result + '   I.ITE_CODGRU AS CODGRU,   ';
  Result := Result + '   I.ITE_MENFIS AS MENFIS, ';
  Result := Result + '   I.ITE_MSGLV1 AS MSGLV1, ';
  Result := Result + '   I.ITE_MSGLV2 AS MSGLV2, ';
  Result := Result + '     UNI_SIGUNI AS SIGUNI,   ';
  Result := Result + fRetCamposIBPT(False);

  Result := Result + ' ITF.ITE_CODITF AS CODITF,   ';
  Result := Result + '     I10_QCOM   AS QTDETI,   ';
  Result := Result + '     B08_NNF    AS NUMDOC,   ';
  Result := Result + '     "NF"       AS ESPDOC,   ';
  Result := Result + ' B07_SERIE      AS SERIE_,   ';
  Result := Result + '   G.ITE_LOCFIS AS LOCFIS,   ';
  Result := Result + '   G.ITE_LOCSUP AS LOCSUP,   ';
  Result := Result + '     FOR_CODFOR AS CODFOR,   ';
  Result := Result + '     FOR_NOMFOR AS NOMFOR,   ';


  Result := Result + '   0.0000 AS VALITE,         ';
  Result := Result + '   0.0000 AS VALVIS,         ';

  Result := Result + '   0.0000 AS PREVIS, ';
  Result := Result + '   0.0000 AS VALPAR, ';

  Result := Result + '   0.0000 AS PREVIS, ';
  Result := Result + '   0.0000 AS VALPAR, ';

  Result := Result +  '1 AS QTDPAR, ';

  Result := Result + '0.0000 AS TOTPRA, ';


  Result := Result + '   I.ITE_CODFAB AS CODFAB,   ';
  Result := Result + '     MAR_DESMAR AS DESMAR,   ';
  Result := Result + '     IFNULL(D.DET_EMBALA, 1) AS  EMBALA, ';

  Result := Result + '     IPR_PREVEN AS PROMOC,   ';
  Result := Result + '   IFNULL(IPR_PERDES, 0) AS PERDES, ';
  Result := Result + '  IFNULL(IPR_QTDMIN, 0) AS QTDMIN, ';

  Result := Result + '  ITE_PREVE1 AS PREVE1, ';
  Result := Result + '  ITE_PREVE2 AS PREVE2, ';
  Result := Result + '  ITE_PREVE3 AS PREVE3, ';
  Result := Result + '  ITE_PREVE4 AS PREVE4, ';
  Result := Result + '  ITE_PREVE5 AS PREVE5, ';
  Result := Result + '  ITE_PREVE6 AS PREVE6, ';
  Result := Result + '  ITE_PREVE7 AS PREVE7, ';

  Result := Result + '  CAST("" AS CHAR(1)) AS EMPNOM,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS FANEMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS IESEMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS CEPEMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS ENDEMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS BAIRRO,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS ENDNUM,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS ENDCMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS CIDEMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS ESTEMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS NUMSEQ,   ';

  For intIndex := 0 To 9 Do
  Begin
    Result := Result + ' ( SELECT ITB_QTDEMB                         ';
    Result := Result + '   FROM ITEEMB                               ';
    Result := Result + '   WHERE ITB_CODITE = G.ITE_CODITE      ';
    Result := Result + '     AND ITB_CODEMP = G.ITE_CODEMP      ';
    Result := Result + '   ORDER BY ITB_QTDEMB DESC                  ';
    Result := Result + '   LIMIT '+ IntToStr(intIndex) +',1) AS QTDEM'+ IntToStr(intIndex) + ', ';

    Result := Result + ' ( SELECT ITB_DESCON                         ';
    Result := Result + '   FROM ITEEMB                               ';
    Result := Result + '   WHERE ITB_CODITE = G.ITE_CODITE      ';
    Result := Result + '     AND ITB_CODEMP = G.ITE_CODEMP      ';
    Result := Result + '   ORDER BY ITB_QTDEMB DESC                  ';
    Result := Result + '   LIMIT '+ IntToStr(intIndex) +',1) AS DESCO'+ IntToStr(intIndex) + ', ';

    Result := Result + ' ( SELECT ITB_TABPRE                         ';
    Result := Result + '   FROM ITEEMB                               ';
    Result := Result + '   WHERE ITB_CODITE = G.ITE_CODITE      ';
    Result := Result + '     AND ITB_CODEMP = G.ITE_CODEMP      ';
    Result := Result + '   ORDER BY ITB_QTDEMB DESC                  ';
    Result := Result + '   LIMIT '+ IntToStr(intIndex) +',1) AS TABPR'+ IntToStr(intIndex) + ', ';
  End;

  Result := Result + ' I.ITE_DTAALT AS DTAALT,';
  Result := Result + '   MAR_CODMAR = ITE_CODMAR,  ';
  Result := Result + ' G.ITE_AMZETI AS AMZETI,';
  Result := Result + ' I.ITE_ITEATI AS ITEATI,';
  Result := Result + '   CONCAT(I.ITE_CODFAB, " ", CADMAR.MAR_DESMAR) AS FABMAR,   ';
  Result := Result + '   E.EMP_C_G_C_ AS EMPCGC,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS LOTECR, ';

  Result := Result + '  G.ITE_SALDOS AS SALDOS,  ';
  Result := Result + '  E.EMP_FONDA1 AS FONDA1,  ';
  Result := Result + '  E.EMP_FONDA2 AS FONDA2,  ';

  Result := Result + '   I.ITE_CODBAR AS CODBAR,   ';
  Result := Result + '     IFNULL(D.DET_EMBALA, 1) AS  EMBALA, ';
  Result := Result + '  0.00 AS EMBPRE,  ';
  Result := Result + '  CAST("" AS CHAR(1)) AS DESEMB, ';

  Result := Result + '   G.ITE_TABEMF AS TABEMF, ';
  Result := Result + '   G.ITE_DESFEC AS DESFEC, ';
  Result := Result + '   G.ITE_EMBFEC AS EMBFEC, ';
  Result := Result + '  CAST("" AS CHAR(1)) AS OBSIMP, ';

  Result := Result + '  (SELECT GROUP_CONCAT(CADSEM.SEM_CODSEM) ';
  Result := Result + '     FROM CADSEM ';
  Result := Result + '    WHERE CADSEM.SEM_CODITE = I.ITE_CODITE ';
  Result := Result + '      AND CADSEM.SEM_CODEMP = I.ITE_CODEMP)AS CODSEM, ';

  Result := Result + '  ITE_VALIDA AS VALIDA,';
  Result := Result + '  ITE_ITESAC AS ITESAC, ';
  Result := Result + '  ITE_COMPOS AS COMPOS, ';
  Result := Result + '  ITE_PAISOR AS PAISOR, ';
  Result := Result + '  ITE_ESTMIN AS ESTMIN, ';
  Result := Result + '  ITE_ESTMAX AS ESTMAX, ';
  Result := Result + '  I.ITE_CODFOR AS CODFOR, ';
  Result := Result + '  FOR_NOMFOR AS NOMFOR, ';
  Result := Result + '  I.ITE_MLTVEN AS MLTVEN, ';
  Result := Result + '  ITE_IPISAI AS IPISAI,  ';

  Result := Result + '  OPE_CODOPE AS OPEIMP, ';
  Result := Result + '  OPE_NOMOPE AS NOMOPE, ';
  Result := Result + '  (SELECT FROM_BASE64(ITE_IMGB64) FROM ITEIMG WHERE ITEIMG.ITE_CODITE = I.ITE_CODITE AND ITEIMG.ITE_PRINCI = "S" ORDER BY ITEIMG.AUTOINCREM DESC LIMIT 1) AS PROIMG, ';


  Result := Result + '   I.ITE_ATICOM AS ATICOM,   ';

  Result := Result + '   G.ITE_PREVE1,             ';
  Result := Result + '   G.ITE_PREVE2,             ';
  Result := Result + '   G.ITE_PREVE3,             ';
  Result := Result + '   G.ITE_PREVE4,             ';
  Result := Result + '   G.ITE_PREVE5,             ';
  Result := Result + '   G.ITE_PREVE6,             ';
  Result := Result + '   G.ITE_PREVE7,             ';
  Result := Result + '   D.AUTOINCREM,             ';
  Result := Result + '   FALSE AS IMP_S_N,         ';

  Result := Result + ' CAST("" AS CHAR(1))  ALTPRE, ';

  Result := Result + '   FOR_C_G_C_ AS CGCFOR ';

  {Localizações Adicionais}
  If fCfgSis('CADLOC', varBoolean) Then
  Begin
    Result := Result + ' ,(SELECT                                 ';
    Result := Result + '    GROUP_CONCAT(CADLOC.LOC_DESCRI)      ';
    Result := Result + '  FROM                                   ';
    Result := Result + '    LOCFIS                               ';
    Result := Result + '    INNER JOIN CADLOC ON (CADLOC.LOC_CODLOC = LOCFIS.LOC_LOCFIS AND ';
    Result := Result + '                          CADLOC.LOC_CODEMP = LOCFIS.LOC_CODEMP)    ';
    Result := Result + '  WHERE                                       ';
    Result := Result + '    LOCFIS.LOC_CODITE = I.ITE_CODITE AND ';
    Result := Result + '    LOCFIS.LOC_CODEMP = '+QuotedStr(VS_strCodEmp)+' AND      ';
    Result := Result + '    CADLOC.LOC_ATIVO_ <> "N") AS LOCADI  ';
  End
 Else
  Begin
    Result := Result + ' ,(SELECT                                 ';
    Result := Result + '    GROUP_CONCAT(LOC_LOCFIS)             ';
    Result := Result + '  FROM                                   ';
    Result := Result + '    LOCFIS                               ';
    Result := Result + '  WHERE                                  ';
    Result := Result + '    LOC_CODITE = I.ITE_CODITE AND   ';
    Result := Result + '    LOC_CODEMP = '+QuotedStr(VS_strCodEmp)+') AS LOCADI ';
  End;

  Result := Result + ' FROM          ';
  Result := Result + '   DETELE D    ';
  Result := Result + ' INNER JOIN GERELE NE ON NE.AUTOINCREM = D.DET_SEQGER ';
  Result := Result + ' INNER JOIN CADITE I ON I.ITE_CODITE = DET_CODITE   ';

  Result := Result + ' INNER JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE AND ';
  Result := Result + '                          G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);


  Result := Result + ' LEFT  JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';

  Result := Result + ' INNER JOIN CADMAR ON MAR_CODMAR = I.ITE_CODMAR      ';


  Result := Result + ' INNER JOIN CADEMP E ON       ';
  Result := Result + '   EMP_CODEMP = G.ITE_CODEMP  ';

  Result := Result + ' LEFT JOIN (SELECT IPR_PREVEN, IPR_CODITE, IPR_PERDES, IPR_QTDMIN FROM CADPRO JOIN ITEPRO ON CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER ';
  Result := Result + '                                                       JOIN PROEMP ON CADPRO.AUTOINCREM = PROEMP.PRO_SEQGER ';
  Result := Result + '             WHERE  ';
  Result := Result + '               PROEMP.PRO_CODEMP = :CODEMP AND ' + fCurrentDate + ' BETWEEN PRO_DTAINI AND PRO_DTAFIN ';
  Result := Result + '               ORDER BY IPR_QTDMIN ASC LIMIT 1) AS TMP ON IPR_CODITE = G.ITE_CODITE ';

  Result := Result + ' LEFT JOIN CADFOR ON        ';
  Result := Result + '   NE.GER_CODFOR = FOR_CODFOR  ';
  Result := Result + ' LEFT JOIN ITEFOR ITF ON ITF.ITE_CODFOR = CADFOR.FOR_CODFOR AND ITF.ITE_CODITE = I.ITE_CODITE ';
  Result := Result + '   AND ITF.AUTOINCREM = (SELECT MAX(FF.AUTOINCREM) FROM ITEFOR FF ';
  Result := Result + '                          WHERE FF.ITE_CODITE = I.ITE_CODITE AND ';
  Result := Result + '                                FF.ITE_CODFOR = CADFOR.FOR_CODFOR) ';
  Result := Result + ' LEFT JOIN CADOPE ON OPE_CODOPE = "'+strLoginUsuarioLogado+'"';

  Result := Result + fJoinIBPT;

  Result := Result + ' WHERE      ';
  Result := Result + '   NE.AUTOINCREM = :AUTINC ';

  Result := Result;
End;


function TfrmEntEtiquetas.fRetCamposIBPT(blnPreven: Boolean): string;
  var
    i: integer;
Begin
  If blnPreven Then
  Begin
    For i := 1 To 7 Do
    Begin
      If fCfgSis('IMPPAG', varInteger) = 1 Then
      Begin
        //Internacional
        Result := Result + ' PRE_PREVE' + IntToStr(i) + '_NOV * IFNULL(ABF_PEIMPG, 0) /100 AS IBPIT' + IntToStr(i) + ' ,';
        //Federal
        Result := Result + ' PRE_PREVE' + IntToStr(i) + '_NOV * IFNULL(ABF_PEIMPG, 0) /100 AS IBPFT' + IntToStr(i) + ' ,';
        //Estadual
        Result := Result + ' PRE_PREVE' + IntToStr(i) + '_NOV * IFNULL(ABF_PEIMPG, 0) /100 AS IBPET' + IntToStr(i) + ' ,';
        //Municipal
        Result := Result + ' PRE_PREVE' + IntToStr(i) + '_NOV * IFNULL(ABF_PEIMPG, 0) /100 AS IBPMT' + IntToStr(i) + ' ,';
      End
      Else
      Begin
        //Internacional
        Result := Result + ' PRE_PREVE' + IntToStr(i) + '_NOV * IFNULL(IBP_ALQIMP, 0) /100 AS IBPIT' + IntToStr(i) + ', ';
        //Federal
        Result := Result + ' PRE_PREVE' + IntToStr(i) + '_NOV * IFNULL(IBP_ALQNAC, 0) /100 AS IBPFT' + IntToStr(i) + ', ';
        //Estadual
        Result := Result + ' PRE_PREVE' + IntToStr(i) + '_NOV * IFNULL(IBP_ALQEST, 0) /100 AS IBPET' + IntToStr(i) + ', ';
        //Municipal
        Result := Result + ' PRE_PREVE' + IntToStr(i) + '_NOV * IFNULL(IBP_ALQMUN, 0) /100 AS IBPMT' + IntToStr(i) + ', ';
      End;
    End
  End
  Else
  Begin
    For i := 1 To 7 Do
    Begin
      If fCfgSis('IMPPAG', varInteger) = 1 Then
      Begin
        //Internacional
        Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(ABF_PEIMPG, 0) /100 AS IBPIT' + IntToStr(i) + ' ,';
        //Federal
        Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(ABF_PEIMPG, 0) /100 AS IBPFT' + IntToStr(i) + ' ,';
        //Estadual
        Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(ABF_PEIMPG, 0) /100 AS IBPET' + IntToStr(i) + ' ,';
        //Municipal
        Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(ABF_PEIMPG, 0) /100 AS IBPMT' + IntToStr(i) + ' ,';
      End
      Else
      Begin
        //Internacional
        Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(IBP_ALQIMP, 0) /100 AS IBPIT' + IntToStr(i) + ', ';
        //Federal
        Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(IBP_ALQNAC, 0) /100 AS IBPFT' + IntToStr(i) + ', ';
        //Estadual
        Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(IBP_ALQEST, 0) /100 AS IBPET' + IntToStr(i) + ', ';
        //Municipal
        Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(IBP_ALQMUN, 0) /100 AS IBPMT' + IntToStr(i) + ', ';
      End;
    End;
  End;
End;

function TfrmEntEtiquetas.fJoinIBPT: string;
Begin
  Result := Result + ' LEFT JOIN CADCID EMPEST ON EMPEST.CID_CODCID = E.EMP_CODCID ';
  If fCfgSis('IMPPAG', varInteger) = 1 Then
    Result := Result + ' LEFT JOIN ABFICM ON ABF_ESTADO = EMPEST.CID_ESTADO AND ABF_CODABF = G.ITE_CODABF '
  Else
  begin
    Result := Result + 'LEFT JOIN CADIBP UTI ON UTI.AUTOINCREM = IFNULL((SELECT AUTOINCREM FROM CADIBP FUL ';
    Result := Result + '                                                  WHERE FUL.IBP_ESTADO = EMPEST.CID_ESTADO ';
    Result := Result + '                                                    AND IFNULL(FUL.IBP_E_X___, "") = IFNULL(G.ITE_EXCIPI, "") ';
    Result := Result + '                                                    AND FUL.IBP_N_C_M_ = I.ITE_CLAIPI), ';

    Result := Result + '                                                IFNULL((SELECT MAX(AUTOINCREM) FROM CADIBP FUL ';
    Result := Result + '                                                  WHERE FUL.IBP_ESTADO = EMPEST.CID_ESTADO ';
    Result := Result + '                                                    AND IFNULL(FUL.IBP_E_X___, "") = IFNULL(G.ITE_EXCIPI, "") ';
    Result := Result + '                                                    AND FUL.IBP_N_C_M_ = LEFT(I.ITE_CLAIPI, 4)) , ';
    Result := Result + '                                                    (SELECT MAX(AUTOINCREM) FROM CADIBP FUL ';
    Result := Result + '                                                  WHERE FUL.IBP_ESTADO = EMPEST.CID_ESTADO ';
    Result := Result + '                                                    AND IFNULL(FUL.IBP_E_X___, "") = IFNULL(G.ITE_EXCIPI, "") ';
    Result := Result + '                                                    AND FUL.IBP_N_C_M_ = LEFT(I.ITE_CLAIPI, 2)))) ';
  End;
End;


function TfrmEntEtiquetas.fSqlLotePreco: String;
 var intIndex: integer;

Begin
  Result := '';
  Result := Result + ' SELECT                      ';
  Result := Result + '     PRE_CODEMP AS NOMEMP,   ';
  Result := Result + '   I.ITE_APLICA AS APLICA, ';
  Result := Result + '   I.ITE_DESITE AS DESITE,   ';
  Result := Result + '   I.ITE_DESSIM AS DESSIM,   ';
  Result := Result + '   I.ITE_REFERE AS REFERE,   ';
  Result := Result + '     PRE_CODITE AS CODITE,   ';
  Result := Result + '   I.ITE_CODGRU AS CODGRU,   ';
  Result := Result + '   I.ITE_MENFIS AS MENFIS, ';
  Result := Result + '   I.ITE_MSGLV1 AS MSGLV1, ';
  Result := Result + '   I.ITE_MSGLV2 AS MSGLV2, ';
  Result := Result + '     UNI_SIGUNI AS SIGUNI,   ';

  Result := Result + fRetCamposIBPT(True);

  Result := Result + ' ITF.ITE_CODITF AS CODITF,   ';
  Result := Result + '  PRE_QTDITE    AS QTDETI,   ';
  Result := Result + '  "Número Doc."     AS NUMDOC, ';
  Result := Result + '  "Esp Doc."        AS ESPDOC, ';
  Result := Result + '  "Série Doc."      AS SERIE_, ';


  Result := Result + '   G.ITE_LOCFIS AS LOCFIS,   ';
  Result := Result + '   G.ITE_LOCSUP AS LOCSUP,   ';
  Result := Result + '     FOR_CODFOR AS CODFOR,   ';
  Result := Result + '     FOR_NOMFOR AS NOMFOR,   ';


  Result := Result + '   PRE_PREVE1_NOV AS VALITE,   ';
  Result := Result + '   PRE_PREVE1_NOV AS VALVIS,   ';


  Result := Result + '   PRE_PREVE1_NOV AS PREVIS, ';
  Result := Result + '   PRE_PREVE1_NOV AS VALPAR, ';

  Result := Result +  '1 AS QTDPAR, ';

  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G' , '1') + ' AS TOTPRA, ';

  Result := Result + ' CAST("" AS CHAR(200))  AS PREPRA,  ';
  Result := Result + ' CAST("" AS CHAR(200))  AS PARPRA,  ';
  Result := Result + ' PREITE.AUTOINCREM AS AUTINC_PREITE, ';

  Result := Result + '  @PROMOC :=  IFNULL(IPR_PREVEN, ' + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '1') + '),';
  Result := Result + '  @UNITAR := ROUND(@PROMOC - (@PROMOC * @DESCOR) / 100,' + IntToStr(fCfgSis('DECUNI', varInteger)) + ') AS EMBFUN,';
  Result := Result + '  @TOTAL := ROUND((@PROMOC - (@PROMOC * @DESCOR) / 100),'+ IntToStr(fCfgSis('DECUNI', varInteger)) + ') * @QTDEMB AS EMBFTO,';
  Result := Result + '  IF(@QTDEMB > 0,  CONCAT("LEVE ", ROUND(@QTDEMB) ," ", IFNULL(CADUNI.UNI_SIGUNI, "UND"), " POR R$ ", ROUND(@UNITAR, 2), " CADA, TOTAL R$ ", ROUND(@TOTAL, 2)), "") AS EXPEMB,';

  Result := Result + '  G.ITE_PRECUS AS CUSPRE, ';

  Result := Result + '  I.ITE_CODFAB AS CODFAB, ';
  Result := Result + '  MAR_DESMAR AS DESMAR,   ';


  Result := Result + '  IPR_PREVEN     AS PROMOC, ';
  Result := Result + '  IFNULL(IPR_PERDES, 0) AS PERDES, ';
  Result := Result + '  IFNULL(IPR_QTDMIN, 0) AS QTDMIN, ';

  Result := Result + '  PRE_PREVE1_NOV AS PREVE1, ';
  Result := Result + '  PRE_PREVE2_NOV AS PREVE2, ';
  Result := Result + '  PRE_PREVE3_NOV AS PREVE3, ';
  Result := Result + '  PRE_PREVE4_NOV AS PREVE4, ';
  Result := Result + '  PRE_PREVE5_NOV AS PREVE5, ';
  Result := Result + '  PRE_PREVE6_NOV AS PREVE6, ';
  Result := Result + '  PRE_PREVE7_NOV AS PREVE7, ';

  Result := Result + '  CAST("" AS CHAR(1)) AS EMPNOM,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS FANEMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS IESEMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS CEPEMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS ENDEMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS BAIRRO,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS ENDNUM,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS ENDCMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS CIDEMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS ESTEMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS NUMSEQ,   ';

  For intIndex := 0 To 9 Do
  Begin
    Result := Result + ' ( SELECT ITB_QTDEMB                         ';
    Result := Result + '   FROM ITEEMB                               ';
    Result := Result + '   WHERE ITB_CODITE = G.ITE_CODITE      ';
    Result := Result + '     AND ITB_CODEMP = G.ITE_CODEMP      ';
    Result := Result + '   ORDER BY ITB_QTDEMB DESC                  ';
    Result := Result + '   LIMIT '+ IntToStr(intIndex) +',1) AS QTDEM'+ IntToStr(intIndex) + ', ';

    Result := Result + ' ( SELECT ITB_DESCON                         ';
    Result := Result + '   FROM ITEEMB                               ';
    Result := Result + '   WHERE ITB_CODITE = G.ITE_CODITE      ';
    Result := Result + '     AND ITB_CODEMP = G.ITE_CODEMP      ';
    Result := Result + '   ORDER BY ITB_QTDEMB DESC                  ';
    Result := Result + '   LIMIT '+ IntToStr(intIndex) +',1) AS DESCO'+ IntToStr(intIndex) + ', ';

    Result := Result + ' ( SELECT ITB_TABPRE                         ';
    Result := Result + '   FROM ITEEMB                               ';
    Result := Result + '   WHERE ITB_CODITE = G.ITE_CODITE      ';
    Result := Result + '     AND ITB_CODEMP = G.ITE_CODEMP      ';
    Result := Result + '   ORDER BY ITB_QTDEMB DESC                  ';
    Result := Result + '   LIMIT '+ IntToStr(intIndex) +',1) AS TABPR'+ IntToStr(intIndex) + ', ';
  End;

  Result := Result + ' I.ITE_DTAALT AS DTAALT,';
  Result := Result + ' I.ITE_CODMAR AS CODMAR,';

  Result := Result + ' G.ITE_AMZETI AS AMZETI,';
  Result := Result + ' I.ITE_ITEATI AS ITEATI,';
  Result := Result + ' CAST(CONCAT(IFNULL(I.ITE_CODFAB, ""), " ", IFNULL(CADMAR.MAR_DESMAR, "")) AS CHAR(100)) AS FABMAR,   ';
  Result := Result + ' E.EMP_C_G_C_ AS EMPCGC,  ';

  Result := Result + '  CAST("" AS CHAR(1)) AS LOTECR, ';

  Result := Result + '  G.ITE_SALDOS AS SALDOS,  ';
  Result := Result + '  E.EMP_FONDA1 AS FONDA1,  ';
  Result := Result + '  E.EMP_FONDA2 AS FONDA2,  ';

  Result := Result + '  I.ITE_CODBAR AS CODBAR,   ';
  Result := Result + '  IFNULL(I.ITE_EMBALA, 1) AS EMBALA,   ';
  Result := Result + '  0.00 AS EMBPRE,  ';
  Result := Result + '  CAST("" AS CHAR(1)) AS DESEMB, ';

  Result := Result + '  G.ITE_TABEMF AS TABEMF, ';
  Result := Result + '  G.ITE_DESFEC AS DESFEC, ';
  Result := Result + '  G.ITE_EMBFEC AS EMBFEC, ';
  Result := Result + '  CAST("" AS CHAR(1)) AS OBSIMP, ';

  Result := Result + '  (SELECT GROUP_CONCAT(CADSEM.SEM_CODSEM) ';
  Result := Result + '     FROM CADSEM ';
  Result := Result + '    WHERE CADSEM.SEM_CODITE = I.ITE_CODITE ';
  Result := Result + '      AND CADSEM.SEM_CODEMP = I.ITE_CODEMP)AS CODSEM, ';

  Result := Result + '  ITE_VALIDA AS VALIDA,';
  Result := Result + '  ITE_ITESAC AS ITESAC, ';
  Result := Result + '  ITE_COMPOS AS COMPOS, ';
  Result := Result + '  ITE_PAISOR AS PAISOR, ';
  Result := Result + '  ITE_ESTMIN AS ESTMIN, ';
  Result := Result + '  ITE_ESTMAX AS ESTMAX, ';
  Result := Result + '  I.ITE_MLTVEN AS MLTVEN, ';
  Result := Result + '  ITE_IPISAI AS IPISAI,  ';

  Result := Result + '  OPE_CODOPE AS OPEIMP, ';
  Result := Result + '  OPE_NOMOPE AS NOMOPE, ';
  Result := Result + '  (SELECT FROM_BASE64(ITE_IMGB64) FROM ITEIMG WHERE ITEIMG.ITE_CODITE = I.ITE_CODITE AND ITEIMG.ITE_PRINCI = "S" ORDER BY ITEIMG.AUTOINCREM DESC LIMIT 1) AS PROIMG, ';


  Result := Result + '   I.ITE_ATICOM AS ATICOM,   ';

  Result := Result + '   PRE_PREVE1_NOV AS ITE_PREVE1, ';
  Result := Result + '   PRE_PREVE2_NOV AS ITE_PREVE2, ';
  Result := Result + '   PRE_PREVE3_NOV AS ITE_PREVE3, ';
  Result := Result + '   PRE_PREVE4_NOV AS ITE_PREVE4, ';
  Result := Result + '   PRE_PREVE5_NOV AS ITE_PREVE5, ';
  Result := Result + '   PRE_PREVE6_NOV AS ITE_PREVE6, ';
  Result := Result + '   PRE_PREVE7_NOV AS ITE_PREVE7, ';
  Result := Result + '   PREITE.AUTOINCREM,          ';
  Result := Result + '   FALSE AS IMP_S_N,           ';
  Result := Result + '   FOR_C_G_C_ AS CGCFOR ';

  {*************************************}
  {* DEFINE SE TEVE ALTERAÇÃO DE PREÇO *}
  {* UTILIZADO APENAS PARA MARCAR OS   *}
  {* ITENS                             *}
  {**********************************GB*}
  if blnMostrarTodosLote Then
  Begin
    Result := Result + ' , ';
    Result := Result + ' IF( PRE_PREVE1_NOV <> PRE_PREVE1 OR ';
    Result := Result + '     PRE_PREVE2_NOV <> PRE_PREVE2 OR ';
    Result := Result + '     PRE_PREVE3_NOV <> PRE_PREVE3 OR ';
    Result := Result + '     PRE_PREVE4_NOV <> PRE_PREVE4 OR ';
    Result := Result + '     PRE_PREVE5_NOV <> PRE_PREVE5 OR ';
    Result := Result + '     PRE_PREVE6_NOV <> PRE_PREVE6 OR ';
    Result := Result + '     PRE_PREVE7_NOV <> PRE_PREVE7, 1, 0 ) AS ALTPRE ';

  End;

  {Localizações Adicionais}
  If fCfgSis('CADLOC', varBoolean) Then
  Begin
    Result := Result + ' ,(SELECT                                 ';
    Result := Result + '    GROUP_CONCAT(CADLOC.LOC_DESCRI)      ';
    Result := Result + '  FROM                                   ';
    Result := Result + '    LOCFIS                               ';
    Result := Result + '    INNER JOIN CADLOC ON (CADLOC.LOC_CODLOC = LOCFIS.LOC_LOCFIS AND ';
    Result := Result + '                          CADLOC.LOC_CODEMP = LOCFIS.LOC_CODEMP)    ';
    Result := Result + '  WHERE                                       ';
    Result := Result + '    LOCFIS.LOC_CODITE = I.ITE_CODITE AND ';
    Result := Result + '    LOCFIS.LOC_CODEMP = :CODEMP AND      ';
    Result := Result + '    CADLOC.LOC_ATIVO_ <> "N") AS LOCADI  ';
  End
 Else
  Begin
    Result := Result + ' ,(SELECT                                 ';
    Result := Result + '    GROUP_CONCAT(LOC_LOCFIS)             ';
    Result := Result + '  FROM                                   ';
    Result := Result + '    LOCFIS                               ';
    Result := Result + '  WHERE                                  ';
    Result := Result + '    LOC_CODITE = I.ITE_CODITE AND   ';
    Result := Result + '    LOC_CODEMP = :CODEMP) AS LOCADI ';
  End;

  Result := Result + ' FROM                          ';
  Result := Result + '   PREITE                      ';
  Result := Result + '   INNER JOIN CADITE I ON   PRE_CODITE = I.ITE_CODITE ';
  Result := Result + '   INNER JOIN CADUNI   ON I.ITE_CODUNI =   UNI_CODUNI ';

  Result := Result + ' INNER JOIN ITEGER G ON          ';
  Result := Result + '   PRE_CODEMP = G.ITE_CODEMP AND ';
  Result := Result + '   PRE_CODITE = G.ITE_CODITE     ';

  Result := Result + ' INNER JOIN CADEMP E ON       ';
  Result := Result + '   EMP_CODEMP = G.ITE_CODEMP  ';

  Result := Result + ' INNER JOIN CADMAR ON       ';
  Result := Result + '   MAR_CODMAR = ITE_CODMAR  ';

  Result := Result + '  LEFT JOIN (SELECT IPR_PREVEN, IPR_CODITE, IPR_PERDES, IPR_QTDMIN FROM CADPRO JOIN ITEPRO ON CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER ';
  Result := Result + '                                                       JOIN PROEMP ON CADPRO.AUTOINCREM = PROEMP.PRO_SEQGER ';
  Result := Result + '             WHERE  ';
  Result := Result + '                PROEMP.PRO_CODEMP = :CODEMP AND ' + fCurrentDate + ' BETWEEN PRO_DTAINI AND PRO_DTAFIN ORDER BY PRO_DTAINI DESC LIMIT 1) AS TMP ON IPR_CODITE = G.ITE_CODITE ';

  Result := Result + ' LEFT JOIN CADFOR ON        ';
  Result := Result + '   FOR_CODFOR = I.ITE_CODFOR  ';
  Result := Result + ' LEFT JOIN ITEFOR ITF ON ITF.ITE_CODFOR = CADFOR.FOR_CODFOR AND ITF.ITE_CODITE = I.ITE_CODITE ';
  Result := Result + ' LEFT JOIN CADOPE ON OPE_CODOPE = "'+strLoginUsuarioLogado+'"';

  Result := Result + fJoinIBPT;

  Result := Result + ' WHERE                      ';
  Result := Result + '   PRE_CODEMP = :CODEMP AND ';
  Result := Result + '   PRE_DTAPRE = :DTAPRE     ';
End;


function TfrmEntEtiquetas.fGetSQLConfPed: String;
var
  intIndex,
  intContador: Integer;
Begin
  Result := '';

  Result := Result + ' SELECT                    ';
  Result := Result + '   G.ITE_CODEMP AS NOMEMP, ';
  Result := Result + '   I.ITE_APLICA AS APLICA, ';
  Result := Result + '     ITE_DESITE AS DESITE, ';
  Result := Result + '   I.ITE_DESSIM AS DESSIM, ';
  Result := Result + '   I.ITE_REFERE AS REFERE, ';
  Result := Result + '   G.ITE_CODITE AS CODITE, ';
  Result := Result + '   I.ITE_CODGRU AS CODGRU, ';
  Result := Result + '   I.ITE_MENFIS AS MENFIS, ';
  Result := Result + '   I.ITE_MSGLV1 AS MSGLV1, ';
  Result := Result + '   I.ITE_MSGLV2 AS MSGLV2, ';
  Result := Result + '     UNI_SIGUNI AS SIGUNI, ';

  Result := Result + fRetCamposIBPT(False);

  Result := Result + ' ITF.ITE_CODITF AS CODITF,   ';
  Result := Result + '     PCD_QTDCON AS QTDETI,   ';
  Result := Result + '     PCG_NUMPED AS NUMDOC,   ';
  Result := Result + '     PCG_ESPDOC AS ESPDOC,   ';
  Result := Result + '   G.ITE_LOCFIS AS LOCFIS,   ';
  Result := Result + '   G.ITE_LOCSUP AS LOCSUP,   ';
  Result := Result + '     FOR_CODFOR AS CODFOR,   ';
  Result := Result + '     FOR_NOMFOR AS NOMFOR,   ';


  Result := Result + '   0.0000 AS VALITE,         ';
  Result := Result + '   0.0000 AS VALVIS,         ';


  Result := Result + '   0.0000 AS PREVIS, ';
  Result := Result + '   0.0000 AS VALPAR, ';

  Result := Result +  '1 AS QTDPAR, ';

  Result := Result + '   0.0000 AS TOTPRA, ';

  Result := Result + '   I.ITE_CODFAB AS CODFAB,   ';
  Result := Result + '     MAR_DESMAR AS DESMAR,   ';


  Result := Result + '     IPR_PREVEN AS PROMOC,   ';
  Result := Result + '   IFNULL(IPR_PERDES, 0) AS PERDES, ';
  Result := Result + '  IFNULL(IPR_QTDMIN, 0) AS QTDMIN, ';

  Result := Result + '   G.ITE_PREVE1 AS PREVE1,   ';
  Result := Result + '   G.ITE_PREVE2 AS PREVE2,   ';
  Result := Result + '   G.ITE_PREVE3 AS PREVE3,   ';
  Result := Result + '   G.ITE_PREVE4 AS PREVE4,   ';
  Result := Result + '   G.ITE_PREVE5 AS PREVE5,   ';
  Result := Result + '   G.ITE_PREVE6 AS PREVE6,   ';
  Result := Result + '   G.ITE_PREVE7 AS PREVE7,   ';

  Result := Result + '  CAST("" AS CHAR(1)) AS EMPNOM,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS FANEMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS IESEMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS CEPEMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS ENDEMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS BAIRRO,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS ENDNUM,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS ENDCMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS CIDEMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS ESTEMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS NUMSEQ,   ';

  For intIndex := 0 To 9 Do
  Begin
    Result := Result + ' ( SELECT ITB_QTDEMB                         ';
    Result := Result + '   FROM ITEEMB                               ';
    Result := Result + '   WHERE ITB_CODITE = G.ITE_CODITE      ';
    Result := Result + '     AND ITB_CODEMP = G.ITE_CODEMP      ';
    Result := Result + '   ORDER BY ITB_QTDEMB DESC                  ';
    Result := Result + '   LIMIT '+ IntToStr(intIndex) +',1) AS QTDEM'+ IntToStr(intIndex) + ', ';

    Result := Result + ' ( SELECT ITB_DESCON                         ';
    Result := Result + '   FROM ITEEMB                               ';
    Result := Result + '   WHERE ITB_CODITE = G.ITE_CODITE      ';
    Result := Result + '     AND ITB_CODEMP = G.ITE_CODEMP      ';
    Result := Result + '   ORDER BY ITB_QTDEMB DESC                  ';
    Result := Result + '   LIMIT '+ IntToStr(intIndex) +',1) AS DESCO'+ IntToStr(intIndex) + ', ';

    Result := Result + ' ( SELECT ITB_TABPRE                         ';
    Result := Result + '   FROM ITEEMB                               ';
    Result := Result + '   WHERE ITB_CODITE = G.ITE_CODITE      ';
    Result := Result + '     AND ITB_CODEMP = G.ITE_CODEMP      ';
    Result := Result + '   ORDER BY ITB_QTDEMB DESC                  ';
    Result := Result + '   LIMIT '+ IntToStr(intIndex) +',1) AS TABPR'+ IntToStr(intIndex) + ', ';
  End;

  Result := Result + ' I.ITE_DTAALT AS DTAALT,';
  Result := Result + ' I.ITE_CODMAR AS CODMAR,';

  Result := Result + ' G.ITE_AMZETI AS AMZETI,';
  Result := Result + ' I.ITE_ITEATI AS ITEATI,';
  Result := Result + '   CONCAT(I.ITE_CODFAB, " ", CADMAR.MAR_DESMAR) AS FABMAR,   ';
  Result := Result + '   E.EMP_C_G_C_ AS EMPCGC,   ';

  Result := Result + '  CAST("" AS CHAR(1)) AS LOTECR, ';

  Result := Result + '  G.ITE_SALDOS AS SALDOS,  ';
  Result := Result + '  E.EMP_FONDA1 AS FONDA1,  ';
  Result := Result + '  E.EMP_FONDA2 AS FONDA2,  ';

  Result := Result + '   I.ITE_CODBAR AS CODBAR,   ';
  Result := Result + '     "1" AS  EMBALA, ';
  Result := Result + '   IF(IFNULL(B.BAR_PREVEN, 0) =  0, 0.00, B.BAR_PREVEN) AS EMBPRE, ';
  Result := Result + '  CAST("" AS CHAR(1)) AS DESEMB, ';

  Result := Result + '   G.ITE_TABEMF AS TABEMF, ';
  Result := Result + '   G.ITE_DESFEC AS DESFEC, ';
  Result := Result + '   G.ITE_EMBFEC AS EMBFEC, ';
  Result := Result + '  CAST("" AS CHAR(1)) AS OBSIMP, ';

  Result := Result + '  (SELECT GROUP_CONCAT(CADSEM.SEM_CODSEM) ';
  Result := Result + '     FROM CADSEM ';
  Result := Result + '    WHERE CADSEM.SEM_CODITE = I.ITE_CODITE ';
  Result := Result + '      AND CADSEM.SEM_CODEMP = I.ITE_CODEMP)AS CODSEM, ';

  Result := Result + '  ITE_VALIDA AS VALIDA,';
  Result := Result + '  ITE_ITESAC AS ITESAC, ';
  Result := Result + '  ITE_COMPOS AS COMPOS, ';
  Result := Result + '  ITE_PAISOR AS PAISOR, ';
  Result := Result + '  ITE_ESTMIN AS ESTMIN, ';
  Result := Result + '  ITE_ESTMAX AS ESTMAX, ';
  Result := Result + '  I.ITE_MLTVEN AS MLTVEN, ';
  Result := Result + '  ITE_IPISAI AS IPISAI,  ';

  Result := Result + '  OPE_CODOPE AS OPEIMP, ';
  Result := Result + '  OPE_NOMOPE AS NOMOPE, ';
  Result := Result + '  (SELECT FROM_BASE64(ITE_IMGB64) FROM ITEIMG WHERE ITEIMG.ITE_CODITE = I.ITE_CODITE AND ITEIMG.ITE_PRINCI = "S" ORDER BY ITEIMG.AUTOINCREM DESC LIMIT 1) AS PROIMG, ';


 Result := Result + '   I.ITE_ATICOM AS ATICOM,   ';

  Result := Result + '   G.ITE_PREVE1,             ';
  Result := Result + '   G.ITE_PREVE2,             ';
  Result := Result + '   G.ITE_PREVE3,             ';
  Result := Result + '   G.ITE_PREVE4,             ';
  Result := Result + '   G.ITE_PREVE5,             ';
  Result := Result + '   G.ITE_PREVE6,             ';
  Result := Result + '   G.ITE_PREVE7,             ';
  Result := Result + '   PM.AUTOINCREM,             ';
  Result := Result + '   FALSE AS IMP_S_N,         ';
  Result := Result + '   CAST("" AS CHAR(1)) AS ALTPRE, ';
  Result := Result + '   FOR_C_G_C_ AS CGCFOR ';

  {Localizações Adicionais}
  If fCfgSis('CADLOC', varBoolean) Then
  Begin
    Result := Result + ' ,(SELECT                                 ';
    Result := Result + '    GROUP_CONCAT(CADLOC.LOC_DESCRI)      ';
    Result := Result + '  FROM                                   ';
    Result := Result + '    LOCFIS                               ';
    Result := Result + '    INNER JOIN CADLOC ON (CADLOC.LOC_CODLOC = LOCFIS.LOC_LOCFIS AND ';
    Result := Result + '                          CADLOC.LOC_CODEMP = LOCFIS.LOC_CODEMP)    ';
    Result := Result + '  WHERE                                       ';
    Result := Result + '    LOCFIS.LOC_CODITE = I.ITE_CODITE AND ';
    Result := Result + '    LOCFIS.LOC_CODEMP = :CODEMP AND      ';
    Result := Result + '    CADLOC.LOC_ATIVO_ <> "N") AS LOCADI  ';
  End
 Else
  Begin
    Result := Result + ' ,(SELECT                                 ';
    Result := Result + '    GROUP_CONCAT(LOC_LOCFIS)             ';
    Result := Result + '  FROM                                   ';
    Result := Result + '    LOCFIS                               ';
    Result := Result + '  WHERE                                  ';
    Result := Result + '    LOC_CODITE = I.ITE_CODITE AND   ';
    Result := Result + '    LOC_CODEMP = :CODEMP) AS LOCADI ';
  End;

  Result := Result + ' FROM PCMDET P                       ';
  Result := Result + ' INNER JOIN PCMGER PM                  ';
  Result := Result + '     ON  PM.PCG_NUMPED = P.PCD_NUMPED ';
  Result := Result + '     AND PM.PCG_CODEMP = P.PCD_CODEMP ';
  Result := Result + '     AND PM.PCG_ESPDOC = P.PCD_ESPDOC ';
  Result := Result + '     AND PM.PCG_NUMCTN = P.PCD_NUMCTN ';

  Result := Result + ' INNER JOIN CADITE I ON I.ITE_CODITE = P.PCD_CODITE   ';

  Result := Result + ' INNER JOIN ITEGER G ON G.ITE_CODITE = P.PCD_CODITE AND ';
  Result := Result + '                          G.ITE_CODEMP = :CODEMP ';

  Result := Result + ' INNER JOIN PCDCON N ON N.CON_SEQDET = P.AUTOINCREM ';
  Result := Result + ' INNER JOIN PCMCON M ON M.AUTOINCREM = N.CON_SEQGER ';

  Result := Result + ' INNER JOIN CADEMP E ON       ';
  Result := Result + '   EMP_CODEMP = G.ITE_CODEMP  ';

  Result := Result + '  LEFT JOIN ITEBAR B ';
  Result := Result + '  ON B.BAR_CODITE = I.ITE_CODITE ';
  Result := Result + '  AND B.BAR_CODEMP = G.ITE_CODEMP AND BAR_CODBAR = I.ITE_CODBAR';

  Result := Result + ' LEFT  JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';

  Result := Result + ' INNER JOIN CADMAR ON       ';
  Result := Result + '   MAR_CODMAR = ITE_CODMAR  ';


  Result := Result + ' LEFT JOIN (SELECT IPR_PREVEN, IPR_CODITE, IPR_PERDES, IPR_QTDMIN  FROM CADPRO JOIN ITEPRO ON CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER ';
  Result := Result + '                                                       JOIN PROEMP ON CADPRO.AUTOINCREM = PROEMP.PRO_SEQGER ';
  Result := Result + '             WHERE  ';
  Result := Result + '               PROEMP.PRO_CODEMP = :CODEMP AND ' + fCurrentDate + ' BETWEEN PRO_DTAINI AND PRO_DTAFIN ';
  Result := Result + '               ORDER BY IPR_QTDMIN ASC LIMIT 1) AS TMP ON IPR_CODITE = G.ITE_CODITE ';

  Result := Result + ' LEFT JOIN CADFOR ON        ';
  Result := Result + '   FOR_CODFOR = PCG_CODFOR  ';
  Result := Result + ' LEFT JOIN ITEFOR ITF ON ITF.ITE_CODFOR = CADFOR.FOR_CODFOR AND ITF.ITE_CODITE = I.ITE_CODITE ';
  Result := Result + ' LEFT JOIN CADOPE ON OPE_CODOPE = "'+strLoginUsuarioLogado+'"';

  Result := Result + fJoinIBPT;
  Result := Result + ' WHERE      ';
  Result := Result + '   PCG_BAIXAD = 0 AND ';
  Result := Result + '   PCD_QTDCON > 0 AND ';
  Result := Result + '   PCD_ESPDOC = "PD" AND ';

  Result := Result + '   PCD_NUMPED IN (' + stlPed.CommaText + ') AND ';

  Result := Result + '   (FALSE  ';

  For IntContador := 0 To stlPed.Count - 1 Do
    Result := Result + '  OR (PCG_NUMPED = ' + QuotedStr(stlPed[intContador]) + ' AND PCG_CODEMP = :CODEMP ) ';

  Result := Result + '   )  ';
  Result := Result + ' GROUP BY  P.PCD_CODITE   ';

  Result := Result;

End;

function TfrmEntEtiquetas.fGetSQLMovDet: string;
  var
    intIndex: Integer;
Begin
  Result := '';
  Result := Result + ' SELECT                      ';
  Result := Result + '   G.ITE_CODEMP AS NOMEMP,   ';
  Result := Result + '   I.ITE_APLICA AS APLICA,   ';
  Result := Result + '     DET_DESCRI AS DESITE,   ';
  Result := Result + '   I.ITE_DESSIM AS DESSIM, ';
  Result := Result + '     DET_REFERE AS REFERE,   ';
  Result := Result + '     DET_CODITE AS CODITE,   ';
  Result := Result + '   I.ITE_CODGRU AS CODGRU,   ';
  Result := Result + '   I.ITE_MENFIS AS MENFIS, ';
  Result := Result + '   I.ITE_MSGLV1 AS MSGLV1, ';
  Result := Result + '   I.ITE_MSGLV2 AS MSGLV2, ';
  Result := Result + '     UNI_SIGUNI AS SIGUNI,   ';

  Result := Result + fRetCamposIBPT(False);

  Result := Result + ' ITF.ITE_CODITF AS CODITF,   ';
  Result := Result + '     DET_QTDITE AS QTDETI,   ';
  Result := Result + '     DET_NUMDOC AS NUMDOC,   ';
  Result := Result + '     DET_ESPDOC AS ESPDOC,   ';
  Result := Result + '     DET_SERIE_ AS SERIE_,   ';
  Result := Result + '   G.ITE_LOCFIS AS LOCFIS,   ';
  Result := Result + '   G.ITE_LOCSUP AS LOCSUP,   ';
  Result := Result + '     FOR_CODFOR AS CODFOR,   ';
  Result := Result + '     FOR_NOMFOR AS NOMFOR,   ';


  Result := Result + '   0.0000 AS VALITE,         ';
  Result := Result + '   0.0000 AS VALVIS,         ';


  Result := Result + '   0.0000 AS PREVIS, ';
  Result := Result + '   0.0000 AS VALPAR, ';

  Result := Result +  '1 AS QTDPAR, ';

  Result := Result +  ' 0.0000 AS TOTPRA, ';

  Result := Result + '   I.ITE_CODFAB AS CODFAB,   ';
  Result := Result + '     MAR_DESMAR AS DESMAR,   ';


  Result := Result + '     IPR_PREVEN AS PROMOC,   ';
  Result := Result + '   IFNULL(IPR_PERDES, 0) AS PERDES, ';
  Result := Result + '  IFNULL(IPR_QTDMIN, 0) AS QTDMIN, ';

  Result := Result + '   G.ITE_PREVE1 AS PREVE1,   ';
  Result := Result + '   G.ITE_PREVE2 AS PREVE2,   ';
  Result := Result + '   G.ITE_PREVE3 AS PREVE3,   ';
  Result := Result + '   G.ITE_PREVE4 AS PREVE4,   ';
  Result := Result + '   G.ITE_PREVE5 AS PREVE5,   ';
  Result := Result + '   G.ITE_PREVE6 AS PREVE6,   ';
  Result := Result + '   G.ITE_PREVE7 AS PREVE7,   ';

  Result := Result + '   E.EMP_NOMEMP AS EMPNOM,   ';
  Result := Result + '   E.EMP_NOMFAN AS FANEMP,   ';
  Result := Result + '   E.EMP_I_E_S_ AS IESEMP,   ';
  Result := Result + '   E.EMP_C_E_P_ AS CEPEMP,   ';
  Result := Result + '   E.EMP_ENDERE AS ENDEMP,   ';
  Result := Result + '   E.EMP_BAIRRO AS BAIRRO,   ';
  Result := Result + '   E.EMP_ENDNUM AS ENDNUM,   ';
  Result := Result + '   E.EMP_ENDCMP AS ENDCMP,   ';
  Result := Result + '   CADCID.CID_NOMCID AS CIDEMP,   ';
  Result := Result + '   CADCID.CID_ESTADO AS ESTEMP,   ';
  Result := Result + '   "00000000"   AS NUMSEQ,   ';

  For intIndex := 0 To 9 Do
  Begin
    Result := Result + ' ( SELECT ITB_QTDEMB                         ';
    Result := Result + '   FROM ITEEMB                               ';
    Result := Result + '   WHERE ITB_CODITE = G.ITE_CODITE      ';
    Result := Result + '     AND ITB_CODEMP = G.ITE_CODEMP      ';
    Result := Result + '   ORDER BY ITB_QTDEMB DESC                  ';
    Result := Result + '   LIMIT '+ IntToStr(intIndex) +',1) AS QTDEM'+ IntToStr(intIndex) + ', ';

    Result := Result + ' ( SELECT ITB_DESCON                         ';
    Result := Result + '   FROM ITEEMB                               ';
    Result := Result + '   WHERE ITB_CODITE = G.ITE_CODITE      ';
    Result := Result + '     AND ITB_CODEMP = G.ITE_CODEMP      ';
    Result := Result + '   ORDER BY ITB_QTDEMB DESC                  ';
    Result := Result + '   LIMIT '+ IntToStr(intIndex) +',1) AS DESCO'+ IntToStr(intIndex) + ', ';

    Result := Result + ' ( SELECT ITB_TABPRE                         ';
    Result := Result + '   FROM ITEEMB                               ';
    Result := Result + '   WHERE ITB_CODITE = G.ITE_CODITE      ';
    Result := Result + '     AND ITB_CODEMP = G.ITE_CODEMP      ';
    Result := Result + '   ORDER BY ITB_QTDEMB DESC                  ';
    Result := Result + '   LIMIT '+ IntToStr(intIndex) +',1) AS TABPR'+ IntToStr(intIndex) + ', ';
  End;

  Result := Result + ' I.ITE_DTAALT AS DTAALT,';
  Result := Result + ' I.ITE_CODMAR AS CODMAR,';

  Result := Result + ' G.ITE_AMZETI AS AMZETI,';
  Result := Result + ' I.ITE_ITEATI AS ITEATI,';
  Result := Result + '   CONCAT(I.ITE_CODFAB, " ", CADMAR.MAR_DESMAR) AS FABMAR,   ';
  Result := Result + '   E.EMP_C_G_C_ AS EMPCGC,   ';

  Result := Result + '  CAST("" AS CHAR(1)) AS LOTECR, ';

  Result := Result + '  G.ITE_SALDOS AS SALDOS,  ';
  Result := Result + '  E.EMP_FONDA1 AS FONDA1,  ';
  Result := Result + '  E.EMP_FONDA2 AS FONDA2,  ';

  Result := Result + '   I.ITE_CODBAR AS CODBAR,   ';
  Result := Result + '     IFNULL(D.DET_QTDEMB, 1) AS EMBALA,   ';
  Result := Result + '  0.00 AS EMBPRE,  ';
  Result := Result + '  CAST("" AS CHAR(1)) AS DESEMB, ';

  Result := Result + '   G.ITE_TABEMF AS TABEMF, ';
  Result := Result + '   G.ITE_DESFEC AS DESFEC, ';
  Result := Result + '   G.ITE_EMBFEC AS EMBFEC, ';
  Result := Result + '  CAST("" AS CHAR(1)) AS OBSIMP, ';

  Result := Result + '  (SELECT GROUP_CONCAT(CADSEM.SEM_CODSEM) ';
  Result := Result + '     FROM CADSEM ';
  Result := Result + '    WHERE CADSEM.SEM_CODITE = I.ITE_CODITE ';
  Result := Result + '      AND CADSEM.SEM_CODEMP = I.ITE_CODEMP)AS CODSEM, ';

  Result := Result + '  ITE_VALIDA AS VALIDA,';
  Result := Result + '  ITE_ITESAC AS ITESAC, ';
  Result := Result + '  ITE_COMPOS AS COMPOS, ';
  Result := Result + '  ITE_PAISOR AS PAISOR, ';
  Result := Result + '  ITE_ESTMIN AS ESTMIN, ';
  Result := Result + '  ITE_ESTMAX AS ESTMAX, ';
  Result := Result + '  I.ITE_MLTVEN AS MLTVEN, ';
  Result := Result + '  ITE_IPISAI AS IPISAI,  ';

  Result := Result + '  OPE_CODOPE AS OPEIMP, ';
  Result := Result + '  OPE_NOMOPE AS NOMOPE, ';
  Result := Result + '  (SELECT FROM_BASE64(ITE_IMGB64) FROM ITEIMG WHERE ITEIMG.ITE_CODITE = I.ITE_CODITE AND ITEIMG.ITE_PRINCI = "S" ORDER BY ITEIMG.AUTOINCREM DESC LIMIT 1) AS PROIMG, ';


  Result := Result + '   I.ITE_ATICOM AS ATICOM,   ';

  Result := Result + '   G.ITE_PREVE1,             ';
  Result := Result + '   G.ITE_PREVE2,             ';
  Result := Result + '   G.ITE_PREVE3,             ';
  Result := Result + '   G.ITE_PREVE4,             ';
  Result := Result + '   G.ITE_PREVE5,             ';
  Result := Result + '   G.ITE_PREVE6,             ';
  Result := Result + '   G.ITE_PREVE7,             ';
  Result := Result + '   D.AUTOINCREM,             ';
  Result := Result + '   FALSE AS IMP_S_N,         ';
  Result := Result + '   CAST("" AS CHAR(1)) AS ALTPRE,  ';
  Result := Result + '   FOR_C_G_C_ AS CGCFOR,     ';

  Result := Result + '  (SELECT MOE_DOLCOM FROM CADMOE ORDER BY MOE_DTAMOE DESC LIMIT 1) AS DOLCOM, ';
  Result := Result + '  (SELECT MOE_DOLVEN FROM CADMOE ORDER BY MOE_DTAMOE DESC LIMIT 1) AS DOLVEN, ';
  Result := Result + '  (SELECT MOE_CODEMP FROM CADMOE ORDER BY MOE_DTAMOE DESC LIMIT 1) AS MOEEMP, ';
  Result := Result + '  (SELECT MOE_DTAMOE FROM CADMOE ORDER BY MOE_DTAMOE DESC LIMIT 1) AS DTAMOE, ';
  Result := Result + '  CADUNI.UNI_DESUNI AS DESUNI ';

  {Localizações Adicionais}
  If fCfgSis('CADLOC', varBoolean) Then
  Begin
    Result := Result + ' ,(SELECT                                 ';
    Result := Result + '    GROUP_CONCAT(CADLOC.LOC_DESCRI)      ';
    Result := Result + '  FROM                                   ';
    Result := Result + '    LOCFIS                               ';
    Result := Result + '    INNER JOIN CADLOC ON (CADLOC.LOC_CODLOC = LOCFIS.LOC_LOCFIS AND ';
    Result := Result + '                          CADLOC.LOC_CODEMP = LOCFIS.LOC_CODEMP)    ';
    Result := Result + '  WHERE                                       ';
    Result := Result + '    LOCFIS.LOC_CODITE = I.ITE_CODITE AND ';
    Result := Result + '    LOCFIS.LOC_CODEMP = :CODEMP AND      ';
    Result := Result + '    CADLOC.LOC_ATIVO_ <> "N") AS LOCADI  ';
  End
 Else
  Begin
    Result := Result + ' ,(SELECT                                 ';
    Result := Result + '    GROUP_CONCAT(LOC_LOCFIS)             ';
    Result := Result + '  FROM                                   ';
    Result := Result + '    LOCFIS                               ';
    Result := Result + '  WHERE                                  ';
    Result := Result + '    LOC_CODITE = I.ITE_CODITE AND   ';
    Result := Result + '    LOC_CODEMP = :CODEMP) AS LOCADI ';
  End;

  Result := Result + ' FROM MOVDET D                       ';
  Result := Result + ' INNER JOIN CADITE I ON      ';
  Result := Result + '   DET_CODITE = I.ITE_CODITE ';

  Result := Result + ' INNER JOIN ITEGER G ON          ';
  Result := Result + '   DET_CODEMP = G.ITE_CODEMP AND ';
  Result := Result + '   DET_CODITE = G.ITE_CODITE     ';

  Result := Result + ' INNER JOIN CADUNI ON      ';
  Result := Result + '   ITE_CODUNI = UNI_CODUNI ';

  Result := Result + ' INNER JOIN CADMAR ON       ';
  Result := Result + '   MAR_CODMAR = ITE_CODMAR  ';

  Result := Result + ' INNER JOIN CADEMP E ON       ';
  Result := Result + '   EMP_CODEMP = G.ITE_CODEMP  ';

  Result := Result + ' INNER JOIN CADCID ON       ';
  Result := Result + '   EMP_CODCID = CID_CODCID  ';

  Result := Result + '  LEFT JOIN (SELECT IPR_PREVEN, IPR_CODITE, IPR_PERDES, IPR_QTDMIN FROM CADPRO JOIN ITEPRO ON CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER ';
  Result := Result + '                                                       JOIN PROEMP ON CADPRO.AUTOINCREM = PROEMP.PRO_SEQGER ';
  Result := Result + '             WHERE  ';
  Result := Result + '               PROEMP.PRO_CODEMP = :CODEMP AND ' + fCurrentDate + ' BETWEEN PRO_DTAINI AND PRO_DTAFIN ORDER BY PRO_DTAINI DESC LIMIT 1) AS TMP ON IPR_CODITE = G.ITE_CODITE ';

  Result := Result + ' LEFT JOIN CADFOR ON        ';
  Result := Result + '   FOR_CODFOR = DET_CODFOR  ';
  Result := Result + ' LEFT JOIN ITEFOR ITF ON ITF.ITE_CODFOR = CADFOR.FOR_CODFOR AND ITF.ITE_CODITE = I.ITE_CODITE ';
  Result := Result + ' LEFT JOIN CADOPE ON OPE_CODOPE = "'+strLoginUsuarioLogado+'"';

  Result := Result + fJoinIBPT;
  Result := Result + ' WHERE                      ';
  Result := Result + '   DET_CODEMP = :CODEMP AND ';
  Result := Result + '   DET_ESPDOC = :ESPDOC AND ';
  Result := Result + '   DET_NUMDOC = :NUMDOC AND ';
  Result := Result + '   IFNULL(DET_SERIE_, "") = :SERIE_ AND ';
  Result := Result + '   DET_CODFOR = :CODFOR AND ';
  Result := Result + '   I.ITE_IMPETI = "S"       ';
  IF Assigned(FlstItens) Then
  Begin
    Result := Result + '   AND DET_CODITE IN (' + FlstItens.CommaText + ')';
  End;


End;

function TfrmEntEtiquetas.fGetSQLPedido(blnCnvMltVen: Boolean = False): string;
  var
    intIndex: Integer;
begin
  Result := '';
  Result := Result + ' SELECT                      ';
  Result := Result + '   G.ITE_CODEMP AS NOMEMP,   ';
  Result := Result + '   I.ITE_APLICA AS APLICA,   ';
  Result := Result + '     PCD_DESITE AS DESITE,   ';
  Result := Result + '   I.ITE_DESSIM AS DESSIM, ';
  Result := Result + '   I.ITE_REFERE AS REFERE,   ';
  Result := Result + '     PCD_CODITE AS CODITE,   ';
  Result := Result + '   I.ITE_CODGRU AS CODGRU,   ';
  Result := Result + '   I.ITE_MENFIS AS MENFIS, ';
  Result := Result + '   I.ITE_MSGLV1 AS MSGLV1, ';
  Result := Result + '   I.ITE_MSGLV2 AS MSGLV2, ';
  Result := Result + '     UNI_SIGUNI AS SIGUNI,   ';

  Result := Result + fRetCamposIBPT(False);
  Result := Result + ' ITF.ITE_CODITF AS CODITF,   ';

  If fCfgSis('CNVEMB') <> 'N' Then
  Begin
    If blnCnvMltVen then
      Result := Result + '  CEIL(PCD_QTDITE * IF(PCD_EMBALA IS NULL OR PCD_EMBALA = 0, 1, PCD_EMBALA)/IF(I.ITE_MLTVEN IS NULL OR I.ITE_MLTVEN = 0, 1, I.ITE_MLTVEN)) AS QTDETI,   '
    Else
      Result := Result + '  PCD_QTDITE * IF(PCD_EMBALA IS NULL OR PCD_EMBALA = 0, 1, PCD_EMBALA) AS QTDETI,   '
  End
  Else
  Begin
    If blnCnvMltVen then
      Result := Result + '     CEIL(PCD_QTDITE/IF(I.ITE_MLTVEN IS NULL OR I.ITE_MLTVEN = 0, 1, I.ITE_MLTVEN)) AS QTDETI,   '
    Else
      Result := Result + '     PCD_QTDITE AS QTDETI,   ';
  End;
  Result := Result + '     PCD_NUMPED AS NUMDOC,   ';
  Result := Result + '     PCD_ESPDOC AS ESPDOC,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS SERIE_, ';
  Result := Result + '   G.ITE_LOCFIS AS LOCFIS,   ';
  Result := Result + '   G.ITE_LOCSUP AS LOCSUP,   ';
  Result := Result + '     FOR_CODFOR AS CODFOR,   ';
  Result := Result + '     FOR_NOMFOR AS NOMFOR,   ';
  Result := Result + '     UNI_SIGUNI AS SIGUNI,   ';


  Result := Result + '   0.0000 AS VALITE,         ';
  Result := Result + '   0.0000 AS VALVIS,         ';


  Result := Result + '   0.0000 AS PREVIS, ';
  Result := Result + '   0.0000 AS VALPAR, ';

  Result := Result +  '1 AS QTDPAR, ';

  Result := Result + '   0.0000 AS TOTPRA, ';

  Result := Result + '   I.ITE_CODFAB AS CODFAB,   ';
  Result := Result + '     MAR_DESMAR AS DESMAR,   ';


  Result := Result + '     IPR_PREVEN AS PROMOC,   ';
  Result := Result + '   IFNULL(IPR_PERDES, 0) AS PERDES, ';
  Result := Result + '  IFNULL(IPR_QTDMIN, 0) AS QTDMIN, ';

  Result := Result + '   G.ITE_PREVE1 AS PREVE1,   ';
  Result := Result + '   G.ITE_PREVE2 AS PREVE2,   ';
  Result := Result + '   G.ITE_PREVE3 AS PREVE3,   ';
  Result := Result + '   G.ITE_PREVE4 AS PREVE4,   ';
  Result := Result + '   G.ITE_PREVE5 AS PREVE5,   ';
  Result := Result + '   G.ITE_PREVE6 AS PREVE6,   ';
  Result := Result + '   G.ITE_PREVE7 AS PREVE7,   ';

  Result := Result + '  CAST("" AS CHAR(1)) AS EMPNOM,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS FANEMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS IESEMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS CEPEMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS ENDEMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS BAIRRO,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS ENDNUM,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS ENDCMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS CIDEMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS ESTEMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS NUMSEQ,   ';
 For intIndex := 0 To 9 Do
  Begin
    Result := Result + ' ( SELECT ITB_QTDEMB                         ';
    Result := Result + '   FROM ITEEMB                               ';
    Result := Result + '   WHERE ITB_CODITE = G.ITE_CODITE      ';
    Result := Result + '     AND ITB_CODEMP = G.ITE_CODEMP      ';
    Result := Result + '   ORDER BY ITB_QTDEMB DESC                  ';
    Result := Result + '   LIMIT '+ IntToStr(intIndex) +',1) AS QTDEM'+ IntToStr(intIndex) + ', ';

    Result := Result + ' ( SELECT ITB_DESCON                         ';
    Result := Result + '   FROM ITEEMB                               ';
    Result := Result + '   WHERE ITB_CODITE = G.ITE_CODITE      ';
    Result := Result + '     AND ITB_CODEMP = G.ITE_CODEMP      ';
    Result := Result + '   ORDER BY ITB_QTDEMB DESC                  ';
    Result := Result + '   LIMIT '+ IntToStr(intIndex) +',1) AS DESCO'+ IntToStr(intIndex) + ', ';

    Result := Result + ' ( SELECT ITB_TABPRE                         ';
    Result := Result + '   FROM ITEEMB                               ';
    Result := Result + '   WHERE ITB_CODITE = G.ITE_CODITE      ';
    Result := Result + '     AND ITB_CODEMP = G.ITE_CODEMP      ';
    Result := Result + '   ORDER BY ITB_QTDEMB DESC                  ';
    Result := Result + '   LIMIT '+ IntToStr(intIndex) +',1) AS TABPR'+ IntToStr(intIndex) + ', ';
  End;
  Result := Result + ' I.ITE_DTAALT AS DTAALT,';
  Result := Result + ' I.ITE_CODMAR AS CODMAR,';

  Result := Result + ' G.ITE_AMZETI AS AMZETI,';
  Result := Result + ' I.ITE_ITEATI AS ITEATI,';
  Result := Result + '   CONCAT(I.ITE_CODFAB, " ", CADMAR.MAR_DESMAR) AS FABMAR,   ';
  Result := Result + '   E.EMP_C_G_C_ AS EMPCGC,   ';

  Result := Result + '  CAST("" AS CHAR(1)) AS LOTECR, ';

  Result := Result + '  CAST("" AS CHAR(1)) AS LOTECR, ';

  Result := Result + '  G.ITE_SALDOS AS SALDOS,  ';
  Result := Result + '  E.EMP_FONDA1 AS FONDA1,  ';
  Result := Result + '  E.EMP_FONDA2 AS FONDA2,  ';

  Result := Result + '   I.ITE_CODBAR AS CODBAR,   ';
  Result := Result + '  IF(PCD_EMBALA IS NULL OR PCD_EMBALA = 0, 1, PCD_EMBALA) AS EMBALA,   ';
  Result := Result + '  0.00 AS EMBPRE,  ';
  Result := Result + '  CAST("" AS CHAR(1)) AS DESEMB, ';

  Result := Result + '   G.ITE_TABEMF AS TABEMF, ';
  Result := Result + '   G.ITE_DESFEC AS DESFEC, ';
  Result := Result + '   G.ITE_EMBFEC AS EMBFEC, ';
  Result := Result + '  CAST("" AS CHAR(1)) AS OBSIMP, ';

  Result := Result + '  (SELECT GROUP_CONCAT(CADSEM.SEM_CODSEM) ';
  Result := Result + '     FROM CADSEM ';
  Result := Result + '    WHERE CADSEM.SEM_CODITE = I.ITE_CODITE ';
  Result := Result + '      AND CADSEM.SEM_CODEMP = I.ITE_CODEMP)AS CODSEM, ';

  Result := Result + '  ITE_VALIDA AS VALIDA,';
  Result := Result + '  ITE_ITESAC AS ITESAC, ';
  Result := Result + '  ITE_COMPOS AS COMPOS, ';
  Result := Result + '  ITE_PAISOR AS PAISOR, ';
  Result := Result + '  ITE_ESTMIN AS ESTMIN, ';
  Result := Result + '  ITE_ESTMAX AS ESTMAX, ';
  Result := Result + '  I.ITE_MLTVEN AS MLTVEN, ';
  Result := Result + '  ITE_IPISAI AS IPISAI,  ';

  Result := Result + '  OPE_CODOPE AS OPEIMP, ';
  Result := Result + '  OPE_NOMOPE AS NOMOPE, ';
  Result := Result + '  (SELECT FROM_BASE64(ITE_IMGB64) FROM ITEIMG WHERE ITEIMG.ITE_CODITE = I.ITE_CODITE AND ITEIMG.ITE_PRINCI = "S" ORDER BY ITEIMG.AUTOINCREM DESC LIMIT 1) AS PROIMG, ';


  Result := Result + '   I.ITE_ATICOM AS ATICOM,   ';

  Result := Result + '   G.ITE_PREVE1,             ';
  Result := Result + '   G.ITE_PREVE2,             ';
  Result := Result + '   G.ITE_PREVE3,             ';
  Result := Result + '   G.ITE_PREVE4,             ';
  Result := Result + '   G.ITE_PREVE5,             ';
  Result := Result + '   G.ITE_PREVE6,             ';
  Result := Result + '   G.ITE_PREVE7,             ';
  Result := Result + '   D.AUTOINCREM,             ';
  Result := Result + '   FALSE AS IMP_S_N,         ';

  Result := Result + ' CAST("" AS CHAR(1)) AS  ALTPRE, ';

  Result := Result + '   FOR_C_G_C_ AS CGCFOR ';

  {Localizações Adicionais}
  If fCfgSis('CADLOC', varBoolean) Then
  Begin
    Result := Result + ' ,(SELECT                                 ';
    Result := Result + '    GROUP_CONCAT(CADLOC.LOC_DESCRI)      ';
    Result := Result + '  FROM                                   ';
    Result := Result + '    LOCFIS                               ';
    Result := Result + '    INNER JOIN CADLOC ON (CADLOC.LOC_CODLOC = LOCFIS.LOC_LOCFIS AND ';
    Result := Result + '                          CADLOC.LOC_CODEMP = LOCFIS.LOC_CODEMP)    ';
    Result := Result + '  WHERE                                       ';
    Result := Result + '    LOCFIS.LOC_CODITE = I.ITE_CODITE AND ';
    Result := Result + '    LOCFIS.LOC_CODEMP = :CODEMP AND      ';
    Result := Result + '    CADLOC.LOC_ATIVO_ <> "N") AS LOCADI  ';
  End
 Else
  Begin
    Result := Result + ' ,(SELECT                                 ';
    Result := Result + '    GROUP_CONCAT(LOC_LOCFIS)             ';
    Result := Result + '  FROM                                   ';
    Result := Result + '    LOCFIS                               ';
    Result := Result + '  WHERE                                  ';
    Result := Result + '    LOC_CODITE = I.ITE_CODITE AND   ';
    Result := Result + '    LOC_CODEMP = :CODEMP) AS LOCADI ';
  End;

  Result := Result + ' FROM                        ';
  Result := Result + '   PCMDET D                  ';
  Result := Result + '   INNER JOIN CADITE I ON   PCD_CODITE = I.ITE_CODITE ';
  Result := Result + '   INNER JOIN CADUNI   ON I.ITE_CODUNI =   UNI_CODUNI ';

  Result := Result + ' INNER JOIN ITEGER G ON          ';
  Result := Result + '   PCD_CODEMP = G.ITE_CODEMP AND ';
  Result := Result + '   PCD_CODITE = G.ITE_CODITE     ';

  Result := Result + ' INNER JOIN CADMAR ON       ';
  Result := Result + '   MAR_CODMAR = ITE_CODMAR  ';

  Result := Result + ' INNER JOIN CADEMP E ON       ';
  Result := Result + '   EMP_CODEMP = G.ITE_CODEMP  ';

  Result := Result + '  LEFT JOIN (SELECT IPR_PREVEN, IPR_CODITE, IPR_PERDES, IPR_QTDMIN FROM CADPRO JOIN ITEPRO ON CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER ';
  Result := Result + '                                                       JOIN PROEMP ON CADPRO.AUTOINCREM = PROEMP.PRO_SEQGER ';
  Result := Result + '             WHERE  ';
  Result := Result + '               PROEMP.PRO_CODEMP = :CODEMP AND ' + fCurrentDate + ' BETWEEN PRO_DTAINI AND PRO_DTAFIN ORDER BY PRO_DTAINI DESC LIMIT 1) AS TMP ON IPR_CODITE = G.ITE_CODITE ';

  Result := Result + ' LEFT JOIN CADFOR ON        ';
  Result := Result + '   PCD_CODFOR = FOR_CODFOR  ';
  Result := Result + ' LEFT JOIN ITEFOR ITF ON ITF.ITE_CODFOR = CADFOR.FOR_CODFOR AND ITF.ITE_CODITE = I.ITE_CODITE ';
  If fCfgSis('TABPRF', varBoolean) Then
  Begin
    Result := Result + '  AND (SELECT COUNT(*) FROM TABPRE    ';
    Result := Result + '  WHERE ITF.ITE_CODTAB = TAB_CODTAB AND TAB_ATICMP = "S") > 0 ';
  End
  Else
  Begin
    Result := Result + '   AND ITF.AUTOINCREM = (SELECT MAX(FF.AUTOINCREM) FROM ITEFOR FF              ';
    Result := Result + '                                 WHERE FF.ITE_CODITE = G.ITE_CODITE            ';
    Result := Result + '                                   AND FF.ITE_CODFOR = CADFOR.FOR_CODFOR)      ';
  End;
  Result := Result + ' LEFT JOIN CADOPE ON OPE_CODOPE = "'+strLoginUsuarioLogado+'"';

  Result := Result + fJoinIBPT;


  Result := Result + ' WHERE                      ';
  Result := Result + '   PCD_CODEMP = :CODEMP AND ';
  Result := Result + '   PCD_ESPDOC = :ESPDOC AND ';
  Result := Result + '   PCD_NUMPED = :NUMDOC AND ';
  Result := Result + '   PCD_CODFOR = :CODFOR     ';

  IF Assigned(FlstItens) Then
  Begin
    Result := Result + '   AND PCD_CODITE IN (' + FlstItens.CommaText + ')';
  End;

End;

function TfrmEntEtiquetas.fGetSql(blnLike: Boolean): String;
Var
  strSQL: String;

Begin
  (***********************************************************************************)
  (* QUANDO ALTERAR ESSE SELECT ALTERAR TAMBEM TODOS OS SQL'S DESTA FUNÇÃO           *)
  (***********************************************************************************)
  If (tipTipoEtiqueta = etqPreNota) Then
    strSQL := fGetSQLPreNota(blnPreNotaFiltraAutInc)
  Else If tipTipoEtiqueta = impXML Then
    strSQL := fGetSQLXML
  Else If tipTipoEtiqueta = etqLotePrecos Then
    strSQL := fSqlLotePreco
  Else If tipTipoEtiqueta = etqConfPedido Then
    strSQL := fGetSQLConfPed
  Else If tipTipoEtiqueta In [etqEntradaMercadorias, etqProdutosControlados] Then
    strSQL := fGetSQLMovDet
  Else
    strSQL := fGetSQLPedido(fPergunta('Na Impressão de Etiquetas gerar a quantidade ' +#$A#$D + 'convertida para o múltiplo de vendas?', False));

  Result := strSQL;
End;

function TfrmEntEtiquetas.fSetParametros: Boolean;
Begin
  With qryConsulta Do
  Begin
    If (tipTipoEtiqueta = etqPreNota) Or (tipTipoEtiqueta = etqConfPedido) Then
      ParamByName('CODEMP').AsString   := VS_strCodEmp

    Else If tipTipoEtiqueta = impXML Then
     ParamByName('AUTINC').AsString   := strAutGerEle

    Else If tipTipoEtiqueta = etqLotePrecos Then
    Begin
      ParamByName('CODEMP').AsString   := VS_strCodEmp;
      ParamByName('DTAPRE').AsDateTime := dtaDtaPre;
    End
    Else
    Begin
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODFOR').AsString := strCodFor;

      If Params.FindParam('SERIE_') <> Nil Then
        ParamByName('SERIE_').AsString := strSerie_;
    End;

  End;

  Result := True;
End;

procedure TfrmEntEtiquetas.btnMarDesClick(Sender: TObject);
begin
  inherited;

  dbgConsultaCellClick( dbgConsulta.Columns.Items[0] );
end;

procedure TfrmEntEtiquetas.btnDesmarcarClick(Sender: TObject);
  Var
    intRecNo : Integer;
begin
  inherited;
  With cdsConsulta Do
  Begin
    intRecNo := RecNo;
    Try
      DisableControls;
      First;
      While not Eof Do
      Begin
        Edit;
        FieldByName('IMP_S_N').ASInteger := 0;
        Post;
        Next;
      End;   
    Finally
      RecNo := intRecNo;
      EnableControls;
    End;
  End;

end;

procedure TfrmEntEtiquetas.btnImprimirClick(Sender: TObject);
  var
    tpeEtique: TTipoEtiqueta;
    blnPrePro: Boolean;
    prmDllEtq: TParamDllEtiquetas;
    strDesEti: String;
    blnExiPrePro : boolean;

    Function fRetTipoEtq: Boolean;
    Begin
      If tipTipoEtiqueta = etqProdutosControlados Then
      Begin
        If fCfgSis('ETIPCT') = 'L' Then
          tpeEtique := tpeItensControladosLaser
        Else
          tpeEtique := tpeItensControladosArgox;

        intPreTab := 1;
        Result := True;
      End

      Else Result := fEscolheTipoEtiqueta (tpeEtique,
                                          False,
                                          blnPrePro,
                                          intPreTab,
                                          strCodCnd,
                                          strCndPag,
                                          strNumPar,
                                          strDesEti,
                                          blnExiPrePro);
    End;

begin

  inherited;

  If cdsConsulta.IsEmpty Then
    Exit;

  FNumSeq := 0;

  cdsConsulta.Filter := '(QTDETI > 0) AND (IMP_S_N = 1)';
  cdsConsulta.Filtered := True;

  if cdsConsulta.RecordCount <= 0 Then
  Begin
    cdsConsulta.Filtered := False;
    cdsConsulta.Filter := '';
    pMensagemOK('Selecione pelo menos um item para impressão!');
    Exit;
  End;

  intColAtu := 1;

  cdsConsulta.DisableControls;

  Try

    If(strTipImp <> 'M') Then
    Begin
      If fRetTipoEtq Then
      Begin
        prmDllEtq := TParamDllEtiquetas.Create;
        prmDllEtq.cdsPromoc := cdsConsulta;
        prmDllEtq.tpeTipEtq := tpeEtique;
        prmDllEtq.frxUserDd := frxDBImpEti;
        prmDllEtq.qryImpres := qryConsulta;
        prmDllEtq.intTabPre := intPreTab;
        prmDllEtq.blnPromoc := False;
        prmDllEtq.blnPrePro := blnExiPrePro;
        prmDllEtq.strNomFrm := Self.Name;
        prmDllEtq.strTipTipoEtiqueta := tipTipoEtiqueta;
        prmDllEtq.strCndDes := strCndPag;
        prmDllEtq.strNumPar := strNumPar;

        Case tipTipoEtiqueta Of
          etqEntradaMercadorias : prmDllEtq.blnImpNot := chkImpNot.Checked;
          etqProdutosControlados: prmDllEtq.blnImpNot := True;
          Else                    prmDllEtq.blnImpNot := False;
        End;

        fImprimeEtiqueta(prmDllEtq, 'fimprimeetiquetaentradamerc');

        FreeAndNil(prmDllEtq);
      End;
    End
    Else
      pImpEtiquetasMatricial;

  Except

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmEntEtiquetas.btnImprimirClick]');
    End;

  End;

  qryConsulta.Filtered := False;
  cdsConsulta.Filtered := False;

  cdsConsulta.EnableControls;

end;

procedure TfrmEntEtiquetas.btnMarcarClick(Sender: TObject);
  Var
    intRecNo : Integer;
    intOpcao : Integer;
begin
  inherited;

  If tipTipoEtiqueta = etqLotePrecos Then
  Begin
    If blnMostrarTodosLote Then
      intOpcao := fGetMenu('Opções', [ 'TODOS OS ITENS', 'ITENS COM CÓDIGO DE BARRAS CADASTRADO', 'ITENS COM PREÇOS ALTERADOS' ], 1 )
    Else
      intOpcao := fGetMenu('Opções', [ 'TODOS OS ITENS', 'ITENS COM CÓDIGO DE BARRAS CADASTRADO' ], 1 );
  End
  Else
    intOpcao := fGetMenu('Opções', [ 'TODOS OS ITENS', 'ITENS COM CÓDIGO DE BARRAS CADASTRADO'], 1 );


  With cdsConsulta Do
  Begin
    intRecNo := RecNo;
    Try
      DisableControls;
      First;
      While not Eof Do
      Begin
        Edit;
        Case intOpcao Of
          1: FieldByName('IMP_S_N').ASInteger := 1;
          2: FieldByName('IMP_S_N').ASInteger := IIF( fEmptyStr(FieldByName('CODBAR').AsString), 0 ,1 );
          3: FieldByName('IMP_S_N').ASInteger := FieldByName('ALTPRE').AsInteger;
        End;
        Post;
        Next;
      End;
    Finally
      RecNo := intRecNo;
      EnableControls;
    End;
  End;

end;

procedure TfrmEntEtiquetas.frxDBImpEtiCheckEOF(Sender: TObject;
  var Eof: Boolean);
begin
  inherited;

  Eof := cdsConsulta.Eof;

end;

procedure TfrmEntEtiquetas.frxDBImpEtiFirst(Sender: TObject);
begin
  inherited;

  cdsConsulta.First;
  IntQtdEti := Pred(cdsConsulta.FieldByName('QTDETI').AsInteger);

end;

procedure TfrmEntEtiquetas.frxDBImpEtiGetValue(const VarName: String;
  var Value: Variant);
begin
  inherited;
   If intPreTab <= 0 then
      intPreTab := 1;

  With cdsConsulta Do
  If SameText('VALITE',VarName) Or SameText('VALVIS',VarName) Then
  Begin
    Value := FieldByName('ITE_PREVE' + IntToStr(intPreTab)).Value;
  End

  Else If SameText('PROMOC',VarName) Then
  Begin
    If FieldByName('PROMOC').IsNull Then
      Value := FieldByName('ITE_PREVE' + IntToStr(intPreTab)).Value
    Else
      Value := FieldByName('PROMOC').Value;
  End

  {Else If SameText('CODBAR',VarName) And
     ((Length(FieldByName( VarName ).AsString) > 13) Or
      (StrToInt64Def(FieldByName( VarName ).AsString,-1) = -1)) Then
    Value := '0'}

  Else If SameText('NUMSEQ',VarName) Then
  Begin
    Value := fRetSequencial('PROCON', VS_strCodEmp);
  End

  Else
    Value := FieldByName( VarName ).Value;

end;

procedure TfrmEntEtiquetas.frxDBImpEtiNext(Sender: TObject);
begin
  inherited;

  If IntQtdEti <= 0 Then
  Begin

    cdsConsulta.Next;
    IntQtdEti := cdsConsulta.FieldByName('QTDETI').AsInteger;

  End;

  Dec(IntQtdEti);

end;

procedure TfrmEntEtiquetas.frxDBImpEtiPrior(Sender: TObject);
begin
  inherited;
  cdsConsulta.Prior;
end;

procedure TfrmEntEtiquetas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If modalResult <> mrOk Then
  Begin
    If Not fPergunta('Deseja sair?') Then
      Action := canone;
  End;
end;

procedure TfrmEntEtiquetas.FormCreate(Sender: TObject);
begin
  inherited;
  blnPreNotaFiltraAutInc := False;
  tipTipoEtiqueta := etqEntradaMercadorias;

  intPreTab := 1;
  cpuCampos := Nil;

  updImpEti := TUniUpdateSQL.Create(Self);
  qryImpEti := fCriaQuery(Self);
  qryImpEti.UpdateObject := updImpEti;
  dtsImpEti := fCriaDataSource(qryImpEti);
  blnMostrarTodosLote := (fCfgSis('TPLTPR', varString) = '2');

  stlPed := TStringList.Create;

  edtNotEnt.TamCampo  := fTamNumDoc();
  edtNotEnt.MaxLength := edtNotEnt.TamCampo;
end;

procedure TfrmEntEtiquetas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10: btnImprimir.Click;
    VK_F6 : btnMarcar.Click;
    VK_F7 : btnDesmarcar.Click;
  End;

end;

procedure TfrmEntEtiquetas.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  Case Key Of
    '-' : Key := #0;
  End;
end;

class procedure TfrmEntEtiquetas.pImpEtiAtivacaoLotePreco(dtaDtaPreA: TDate);
  var
    frmEntEtiquetas: TfrmEntEtiquetas;
begin
  try
    pCriarFormularios(TfrmEntEtiquetas, frmEntEtiquetas);
    With frmEntEtiquetas Do
    Begin
      tipTipoEtiqueta := etqLotePrecos;
      dtaDtaPre := dtaDtaPreA;
      pAddColunaPrecos;

      fAbreConsulta;
      
      ShowModal;
    End;
  Finally
    FreeAndNil(frmEntEtiquetas);
  End;

end;

class procedure TfrmEntEtiquetas.pImpEtiConfPedido(stlPedidos: TStringList);
  var
    frmEntEtiquetas: TfrmEntEtiquetas;
begin
  Try
    pCriarFormularios(TfrmEntEtiquetas, frmEntEtiquetas);
    With frmEntEtiquetas Do
    Begin
      tipTipoEtiqueta := etqConfPedido;
      stlPed := stlPedidos;

      fAbreConsulta;

      if cdsConsulta.RecordCount > 0 then
        ShowModal;

    End;
  Finally
    FreeAndNil(frmEntEtiquetas)
  End;
end;

class procedure TfrmEntEtiquetas.pImpEtiEntradaMercadorias(strNumDocA,
  strEspDocA, strCodForA, strSerie_A: String; blnControlados: Boolean = False; tpeEtique: TTipoEtiqueta = tpeItensControladosLaser; lstItens: TStringList = nil);
  var
    frmEntEtiquetas: TfrmEntEtiquetas;
begin
  Try
    pCriarFormularios(TfrmEntEtiquetas, frmEntEtiquetas);
    With frmEntEtiquetas Do
    Begin
      FReimpressao := fEmptyStr(strNumDocA);

      If blnControlados Then
        tipTipoEtiqueta := etqProdutosControlados;

      strNumDoc := strNumDocA;
      strEspDoc := strEspDocA;
      strCodFor := strCodForA;
      strSerie_ := strSerie_A;
      FlstItens := lstItens;

      If Not FReimpressao Then
      Begin
        fAbreConsulta;

        If cdsConsulta.RecordCount > 0 then
          ShowModal;
      End Else
      Begin
        ShowModal;
      End

    End;
  Finally
    FreeAndNil(frmEntEtiquetas)
  End;
end;

class procedure TfrmEntEtiquetas.pImpEtiPedidoDeCompra(strNumDocA, strEspDocA,
  strCodForA: String; lstItens: TStringList = nil);
  var
    frmEntEtiquetas: TfrmEntEtiquetas;
begin
  Try
    pCriarFormularios(TfrmEntEtiquetas, frmEntEtiquetas);
    With frmEntEtiquetas Do
    Begin
      tipTipoEtiqueta := etqPedido;
      strNumDoc := strNumDocA;
      strEspDoc := strEspDocA;
      strCodFor := strCodForA;
      strSerie_ := '';
      FlstItens := lstItens;


      fAbreConsulta;

      if frmEntEtiquetas.cdsConsulta.RecordCount > 0 then
        ShowModal;

    End;
  Finally
    FreeAndNil(frmEntEtiquetas)
  End;
end;

class procedure TfrmEntEtiquetas.pImpEtiPreNota(strIdeDigA: String; blnFiltraAutInc: Boolean = False);
  var
    frmEntEtiquetas: TfrmEntEtiquetas;
begin
  Try
    pCriarFormularios(TfrmEntEtiquetas, frmEntEtiquetas);
    With frmEntEtiquetas Do
    Begin
      tipTipoEtiqueta := etqPreNota;
      if blnFiltraAutInc then
      begin
        blnPreNotaFiltraAutInc := blnFiltraAutInc;
        strAutGerEle := strIdeDigA
      end
      else begin
        strIdeDig := strIdeDigA;
      end;

      fAbreConsulta;

      if cdsConsulta.RecordCount > 0 then
        ShowModal;

    End;
  Finally
    FreeAndNil(frmEntEtiquetas)
  End;
end;

procedure TfrmEntEtiquetas.pImpEtiquetasMatricial;
  Var
    intContador: Integer;
    intQtdTopo : Integer;
    intQtdImp  : Integer;
    cdsFiltro  : TUniClientDataSet;
    stlCodIte  : TStringList;
begin
  pCarregaConfImpr(qryCfgRel,Self.Name);

  strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
  strNomPro := qryCfgRel.FieldByName('REL_NOMPRO').AsString;
  strDesPro := qryCfgRel.FieldByName('REL_DESPRO').AsString;

  TCfgRel.pCarregaConfImpr(qryCfgRel,Self.Name + '_ITE');

  If Not fEmptyStr(qryCfgRel.FieldByName('REL_NOMFIL').AsString) Then
  Begin
    strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
    strNomPro := qryCfgRel.FieldByName('REL_NOMPRO').AsString;
    strDesPro := qryCfgRel.FieldByName('REL_DESPRO').AsString;
  End;

  If Not fVerificaImpressora(strNomImp) Then
  Begin
    fMensagem('','Impressora configurada incorretamente!',['&OK']);
    Exit;
  End;

  Try

    stlCodIte := TStringList.Create;
    cdsFiltro  := TUniClientDataSet.Create(Self);

    cdsFiltro.Data     := cdsConsulta.Data;
    cdsFiltro.Filter   := 'QTDETI > 0';
    cdsFiltro.Filtered := True;

    With cdsFiltro Do
    Begin
      First;

      While Not Eof Do
      Begin
        stlCodIte.Add(cdsFiltro.FieldByName('CODITE').AsString);
        Next;
      End;
    End;

    cdsFiltro.Filtered := False;

    If (stlCodIte.Count > 0) Then
    Begin
      With qryImpEti Do
      Begin

        intQtdTopo := fRetTopoEtiqueta('ITE');

        For intContador := 1 to intQtdTopo Do
        Begin
          pEscreveLinha(untFuncMacro.strArqTxt, ' ', False, strNomImp);
        End;

        Close;
        SQL.Clear;
        SQL.Add(fRetornaSQLIte(stlCodIte));
        Open;

        First;

        While Not Eof Do
        Begin
          cdsFiltro.Filtered := False ;
          cdsFiltro.Filter   := 'CODITE = ' + QuotedStr(FieldByName('ITE_CODITE').AsString);
          cdsFiltro.Filtered := True;
          intQtdImp := cdsFiltro.FieldByName('QTDETI').AsInteger;

          Application.ProcessMessages;
          pAtualizaCamposUso;
          Application.ProcessMessages;
          pImpRegistro(intQtdImp);
          Application.ProcessMessages;

          Next;
        End;
        {*****************************************}
        {* É NECESSARIO CHAMAR ESSA PROCEDURE    *}
        {* NESSE PONTO PARA QUE SAIA A ÚLTIMA    *}
        {* ETIQUETA                              *}
        {**************************************MV*}
        pImpArrLinhasEti;

      End;

    End;

  Finally
    FreeAndNil(cdsFiltro);
    FreeAndNil(stlCodIte);
  End;

end;

procedure TfrmEntEtiquetas.pImpRegistro(intQtdImp: Integer);
  Var
    intQtdCol: Integer;
    intQtdColOri: Integer;
    intContador: Integer;
    intLinhaAtu: Integer;
    intLinha : Integer;

    intTamLinAnt: Integer;

    intNumCol: Integer;
    intLinhaEti: Integer;
    strNumCol: String;
    strLinha : String;
    strSQL   : String;
    qryCnfEti: TUniQuery;
begin

  intLinhaAtu := 1;
  intLinha    := 0;

  intLinhaEti := 0;

  strSQL := '';
  strSQL := strSQL + 'SELECT   ';
  strSQL := strSQL + '  *      ';
  strSQL := strSQL + 'FROM     ';
  strSQL := strSQL + '  CNFETI ';
  strSQL := strSQL + 'WHERE    ';
  strSQL := strSQL + '  CNF_TIPETI = :TIPETI AND ';
  strSQL := strSQL + '  CNF_CODEMP = :CODEMP     ';
  strSQL := strSQL + 'ORDER BY ';
  strSQL := strSQL + '  CNF_IDENTI, CNF_LINIMP, CNF_COL001 ';

  qryCnfEti := fCriaQuery(Self);
  With qryCnfEti Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('TIPETI').AsString := 'ITE';
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;

    While (intQtdImp > 0) Do
    Begin
      First;

      intQtdColOri := FieldByName('CNF_QTDCOL').AsInteger;
      intQtdCol := intQtdColOri;

      If (intQtdCol > intQtdImp) And (intColAtu <= 1) Then
        intQtdCol := intQtdImp;

      {*****************************************}
      {* LÊ E INTERPRETA O ID = '00'           *}
      {**************************************MV*}
      If intColAtu <= 1 Then
      Begin
        pI_LinhasEti(Self, cpuCampos, strLinha, intLinhaAtu, intLinha, strNomImp, strNomPro, strDesPro, 0, qryCnfEti);
        {*****************************************}
        {* ESCREVE COM WRITE, MAS NÃO IMPRIME    *}
        {**************************************MV*}
        pEscreveLinha(strArqTxt, AnsiString(strLinha), not VS_SpoolImpressaoCitel, strNomImp, strNomPro, strDesPro);
      End;
      Next;

      {If (Length(arrLinhasEti) = 0) Then
      Begin
        SetLength(arrLinhasEti, RecordCount-1);
      End;}

      If (Length(arrLinhasEti) = 0) Then
      Begin
        If RecordCount > 0 Then
          SetLength(arrLinhasEti, RecordCount-1)
        Else
          SetLength(arrLinhasEti, 0);
      End;

      While (Not Eof) Do
      Begin

        pAtualizaCamposUso;

        strLinha := '';

        For intContador := intColAtu To IIF(intQtdImp = 1, intColAtu, intQtdCol) Do
        Begin

          strNumCol := fStrZero(IntToStr(intContador), 03);
          intNumCol := FieldByName('CNF_COL' + strNumCol).AsInteger;

          intTamLinAnt := Length(arrLinhasEti[intLinhaEti]);
          pI_LinhasEti(Self, cpuCampos, strLinha, intLinhaAtu, intLinha, strNomImp, strNomPro, strDesPro, (intNumCol - intTamLinAnt), qryCnfEti);

          arrLinhasEti[intLinhaEti] := arrLinhasEti[intLinhaEti] + strLinha;
          strLinha := ''; //Se desistir da matriz, tirar essa linha

        End;
        Inc(intLinhaEti);

        {*****************************************}
        {* NEXT NO ARQUIVO DE CNF                *}
        {**************************************MV*}
        Next;

      End;

      intLinhaEti := 0;
      Inc(intColAtu, intQtdImp);
      Dec(intQtdImp, (intQtdColOri+1) - (intColAtu - intQtdImp));

      If intColAtu > intQtdColOri Then
      Begin
        pImpArrLinhasEti;
        intColAtu := 1;
      End;

    End;

  End;

end;

procedure TfrmEntEtiquetas.pAddColunaPrecos;
  Var
    intIndex : Integer;
begin
  For intIndex := 1 To Length(VS_strTabPrc) Do
  Begin
    if VS_strTabPrc[intIndex] = 'S' Then
    Begin
      With dbgConsulta.Columns.Add Do
      Begin
        Title.Caption := 'Preço de Venda [' + IntToStr(intIndex) + ']';
        FieldName := 'PREVE' + IntToStr(intIndex);
        ReadOnly  := True;
      End;
    End;                  
  End;
end;

procedure TfrmEntEtiquetas.pAtribuiCamposUso;
begin
  If Assigned(cpuCampos) THen
    FreeAndNil(cpuCampos);

  cpuCampos := TCamposUso.Create;
  cpuCampos.AdicionaCampos(qryImpEti, 'CADITE');
end;

procedure TfrmEntEtiquetas.pAtualizaCamposUso;
begin
  pFinalizaCamposUso;
  pAtribuiCamposUso;
end;

procedure TfrmEntEtiquetas.pFinalizaCamposUso;
begin
  If cpuCampos <> Nil Then
    FreeAndNil(cpuCampos);
end;

procedure TfrmEntEtiquetas.pImpArrLinhasEti;
  Var
    intContador1: Integer;
    intLength1: Integer;
    blnUltimoReg: Boolean;
    strLinhaAtu: String;
    blnImprime: Boolean;
begin
  strLinhaAtu := '';
  blnUltimoReg := False;
  intLength1 := Length(arrLinhasEti);
  blnImprime := False;

  For intContador1 := 0 To intLength1-1 Do
  Begin
    If arrLinhasEti[intContador1] <> '' Then
    Begin
      blnImprime := True;
      Break;
    End;
  End;

  If Not blnImprime Then
  Begin
    Exit;
  End;

  For intContador1 := 0 To intLength1-1 Do
  Begin
    If (intContador1 = intLength1-1) Then
    Begin
      blnUltimoReg := True;
    End;

    pEscreveLinha(strArqTxt, AnsiString(arrLinhasEti[intContador1]), blnUltimoReg, strNomImp, strNomPro, strDesPro);
    strLinhaAtu := '';
  End;

  SetLength(arrLinhasEti, 0);
end;


function TfrmEntEtiquetas.fRetornaSQLIte(stlCodIte: TStringList): String;
Var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT   ';
  strSQL := strSQL + '  *      ';
  strSQL := strSQL + 'FROM     ';
  strSQL := strSQL + '  CADITE ';
  strSQL := strSQL + 'WHERE    ';
  strSQL := strSQL + '  ITE_CODITE IN ( ' + stlCodIte.CommaText + ' ) ';

  Result := strSQL;
end;

function TfrmEntEtiquetas.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
Begin

  Result := True;

  If pnlHeader.Visible And (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtNotEnt) Then
    Begin

      If fEmptyStr(edtNotEnt.Text) Then
      Begin
        pMensagemOk('Informe o Número do Documento!');
        Result := False;
      End;

    End

    Else If (Sender = edtEspEnt) Then
    Begin

      If fEmptyStr(edtEspEnt.Text) Then
      Begin
        pMensagemOk('Informe a Espécie do Documento!');
        Result := False;
      End

    End

    Else If (Sender = edtCodFor) Then
    Begin

      If fEmptyStr(edtCodFor.Text) Then
      Begin
        pMensagemOk('Informe o Código do Fornecedor!');
        Result := False;
      End

      Else If blnBuscaPorChave Then
      Begin
        strNumDoc := edtNotEnt.Text;
        strEspDoc := edtEspEnt.Text;
        strCodFor := edtCodFor.Text;
        strSerie_ := edtSerEnt.Text;

        fAbreConsulta;
        pInicializaColuna;

        If cdsConsulta.IsEmpty Then
        Begin
          Result := False;
          pMensagemOk('Nenhum documento encontrado!');
        End
      End;

    End

  End;

  If Not Result Then
    pSetFocus(Sender);
End;

class procedure TfrmEntEtiquetas.pImpEtiXML(strAutGerEleA: String);
  var
    frmEntEtiquetas: TfrmEntEtiquetas;
begin
  Try
    pCriarFormularios(TfrmEntEtiquetas, frmEntEtiquetas);
    With frmEntEtiquetas Do
    Begin
      tipTipoEtiqueta := impXML;
      strAutGerEle := strAutGerEleA;

      fAbreConsulta;

      if cdsConsulta.RecordCount > 0 then
        ShowModal;

    End;
  Finally
    FreeAndNil(frmEntEtiquetas)
  End;
end;

end.
