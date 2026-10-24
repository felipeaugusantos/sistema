unit untEntSelPedidos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider, 
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls, StrUtils, untFuncoesGenerica,
  BitBtnLockedIncrem, MemDS, DBAccess, Provider, frxClass,
  frxExportCSVTestabilidade, untTypesSistema, Datasnap.DBClient,
  untPaiOrdenaCxGrid, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, cxCurrencyEdit, cxCheckBox, System.UITypes,
  untSelFornecedor, untFuncoesRel;

type
  TfrmEntSelPedidos = class(TfrmPaiOrdenaCxGrid)
    Panel1: TPanel;
    Label3: TLabel;
    Label5: TLabel;
    lblDtaLib: TLabel;
    edtDocOrig: TEditFocus;
    edtEmpDes: TEditFocus;
    edtDtaLib: TEditFocus;
    pnlDadosInformativos: TPanel;
    Label6: TLabel;
    Label21: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    edtPedSel: TEditFocus;
    edtTotIte: TEditFocus;
    edtTotIpi: TEditFocus;
    edtTotGer: TEditFocus;
    edtTotSub: TEditFocus;
    cdsConsultaTOTITE: TAggregateField;
    cdsConsultaTOTGER: TAggregateField;
    cdsConsultaTOTIPI: TAggregateField;
    cdsConsultaTOTSUB: TAggregateField;
    lbl1: TLabel;
    edtCgcCpf: TEditFocus;
    btnConfirma: TBitBtnLocked;
    dbgConsultaDadosPCG_NUMPED: TcxGridDBColumn;
    dbgConsultaDadosPCG_CODEMP: TcxGridDBColumn;
    dbgConsultaDadosPCG_NUMFAT: TcxGridDBColumn;
    dbgConsultaDadosPCG_CODFOR: TcxGridDBColumn;
    dbgConsultaDadosFOR_NOMFOR: TcxGridDBColumn;
    dbgConsultaDadosPCG_DTAPED: TcxGridDBColumn;
    dbgConsultaDadosPCG_TOTITE: TcxGridDBColumn;
    dbgConsultaDadosPCG_TOTSUB: TcxGridDBColumn;
    dbgConsultaDadosPCG_TOTIPI: TcxGridDBColumn;
    dbgConsultaDadosPCG_TOTFRE: TcxGridDBColumn;
    dbgConsultaDadosPCG_TOTACE: TcxGridDBColumn;
    dbgConsultaDadosPCG_TOTGER: TcxGridDBColumn;
    dbgConsultaDadosPCG_DTAENT: TcxGridDBColumn;
    dbgConsultaDadosPCG_MARDES: TcxGridDBColumn;
    btnMostrarItensPend: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure cdsConsultaAfterPost(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure dbgConsultaDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnMostrarItensPendClick(Sender: TObject);
  private
    { Private declarations }
    intOpcFil: Integer;
    blnFechaForm : Boolean;
    strTipSel: String;
    FPais: TPais;
    blnTravaFor : Boolean;
    blnErroaoMarcar: Boolean;
    strFornecedorSelecionado: String;

    procedure pCalculaDadosInformativos;
    procedure pCalculaTotal;

    procedure pMarcaDuplicata(blnMarcar: Boolean);

    procedure pAtualizaRodape(DataSet: TDataSet);
    function fAtualizaFornecedorMesmoGrupo: Boolean;

    function fRetTipSelecionados: String;
    function fVerificaQtdBai: Boolean;
    Function fVeSeAtualizaPedidoCompraGrid(strNumPed, strCodEmp, strForEle, strForPed: String): Boolean;
  public
    { Public declarations }
    blnNotEle: Boolean;
    blnNotaImportacao: Boolean;
    arrPedidos: Array Of String;
    arrEmpresas: Array Of String;
    blnConfirma: Boolean;
    strCodFor: String;
    strPedBon,
    strCodEmp: String;
    blnBonificacao: Boolean;
    strNumPed: String;
    intQtdSel: Integer;
    blnCarregProd: Boolean;
    blnFornJaAtualizado: Boolean;
    blnUsaCon: Boolean;
    fltValFre: Double;
    fltDesAce: Double;
    blnDocOri: Boolean;
    strNumDoc: String;
    strNumSer: String;
    arrDocOri: TStringArrayArray;

    blnSomenteConferido: Boolean;
  protected
    function fGetSql(blnLike: Boolean): String; Override;
    procedure pAddListaQuery; Override;
  end;

var
  frmEntSelPedidos: TfrmEntSelPedidos;

CONST
  MENSSAGEM_FORNECEDOR_MESMO_GRUPO = 'Os fornecedores dos pedidos selecionados são diferentes, porém seus CNPJ''s são do mesmo grupo de empresas. ' +
                                     'Será possivel trocar o fornecedor do(s) pedido(s). Deseja prosseguir?';


implementation

uses untFuncoes, untfuncoesSimples,
     untFatMostraItemSalBal,
     untFuncoesPedidoSimples, untPcmGer;

{$R *.dfm}

function TfrmEntSelPedidos.fGetSql(blnLike: Boolean): String;
  Var
    strSQL: String;
Begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  PCMGER.AUTOINCREM, ';
  strSQL := strSQL + '  PCG_DTALIB, ';
  strSQL := strSQL + '  PCG_NUMPED, ';
  strSQL := strSQL + '  PCG_CODEMP, ';

  strSQL := strSQL + '	IF ((SUBSTRING(PCG_DOCORI,' + IntToStr(Succ(fTamDocCadRec)) + ',2) = "NF"), ';
  strSQL := strSQL + '	     CONCAT(SUBSTRING(PCG_DOCORI,1,' + IntToStr(fTamDocCadRec) + '), "-", SUBSTRING(PCG_DOCORI,' + IntToStr(Succ(fTamDocCadRec)) + ',2), "-", SUBSTRING(PCG_DOCORI,' + IntToStr(fTamDocCadRec + 3) + ',3)), ';
  strSQL := strSQL + '       CONCAT(MG.GER_NUMFAT, IF(MG.GER_NUMFAT <> "", "-", ""), MG.GER_TIPFAT, IF(MG.GER_NUMFAT <> "", "-", ""), MG.GER_EMPFAT) ';
  strSQL := strSQL + '     )AS PCG_NUMFAT, ';

  strSQL := strSQL + '  PCG_DOCORI, ';
  strSQL := strSQL + '  PCG_EMPDES, ';
  strSQL := strSQL + '  PCG_CODFOR, ';
  strSQL := strSQL + '  FOR_NOMFOR, ';
  strSQL := strSQL + '  FOR_CGCCPF, ';
  strSQL := strSQL + '  FOR_C_G_C_, ';
  strSQL := strSQL + '  PCG_DTAPED, ';
  strSQL := strSQL + '  PCG_DTAENT, ';
  strSQL := strSQL + '  PCG_ESPDOC, ';
  strSQL := strSQL + '  IF ((MG.GER_SERIE_ IS NULL), NT.GER_SERIE_, MG.GER_SERIE_) AS GER_SERIE_, ';  

  strSQL := strSQL + '  PCG_TOTITE, ';
  strSQL := strSQL + '  PCG_TOTSUB, ';
  strSQL := strSQL + '  PCG_TOTIPI, ';
  strSQL := strSQL + '  PCG_TOTGER, ';
  strSQL := strSQL + '  IFNULL(PCG_DESACE, 0) AS PCG_TOTACE, ';
  strSQL := strSQL + '  IFNULL(PCG_VALFRE, 0) AS PCG_TOTFRE, ';

  strSQL := strSQL + '  0.00 AS MAR_TOTITE, ';
  strSQL := strSQL + '  0.00 AS MAR_TOTSUB, ';
  strSQL := strSQL + '  0.00 AS MAR_TOTIPI, ';
  strSQL := strSQL + '  0.00 AS MAR_TOTGER, ';
  strSQL := strSQL + '  PCG_PEDBON, ';

  strSQL := strSQL + '  "D" AS PCG_MARDES   ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  PCMGER ';
  strSQL := strSQL + '  JOIN CADFOR ON PCG_CODFOR = FOR_CODFOR ';

  If (intOpcFil <> 1) Then
    strSQL := strSQL + ' JOIN CADEMP ON EMP_CODEMP = PCG_CODEMP ';

  strSQL := strSQL + 'LEFT JOIN MOVGER MG';
  If fCfgSis('CPDORI', varBoolean) Then
  Begin
    strSQL := strSQL + '     ON MG.GER_NUMDOC = PCG_ORIGND AND ';
    strSQL := strSQL + '        MG.GER_ESPDOC = PCG_ORIGES AND ';
    strSQL := strSQL + '        MG.GER_CODEMP = PCG_ORIGEP AND ';

  End
  Else
  Begin
    strSQL := strSQL + '     ON MG.GER_NUMDOC = SUBSTRING(PCG_DOCORI,1,' + IntToStr(fTamDocCadRec) + ') AND ';
    strSQL := strSQL + '        MG.GER_ESPDOC = SUBSTRING(PCG_DOCORI,' + IntToStr(Succ(fTamDocCadRec)) + ',2) AND ';
    strSQL := strSQL + '        MG.GER_CODEMP = SUBSTRING(PCG_DOCORI,' + IntToStr(fTamDocCadRec + 3) + ',3) AND ';
  End;

  strSQL := strSQL + '        MG.GER_TIP_FC = "C" ';

  strSQL := strSQL + 'LEFT JOIN NOTGER NT';
  strSQL := strSQL + '     ON NT.GER_NUMDOC = MG.GER_NUMFAT AND ';
  strSQL := strSQL + '        NT.GER_ESPDOC = MG.GER_TIPFAT AND ';
  strSQL := strSQL + '        NT.GER_CODEMP = MG.GER_EMPFAT AND ';
  strSQL := strSQL + '        NT.GER_TIP_FC = "C" ';

  strSQL := strSQL + 'WHERE ';

  If fCfgSis('LIBPCM', varBoolean) Then
    strSQL := strSQL + '  PCG_PEDLIB IS NOT NULL AND ';

  If (blnNotaImportacao) And (fCfgSis('USACON') = 'N') Then
  Begin
    strSQL := strSQL + '  PCG_PEDIMP = "S" AND ';
    strSQL := strSQL + '  PCG_JAEMIT = 1 AND ';  
  End
  Else
  Begin
    strSQL := strSQL + '  PCG_PEDIMP <> "S" AND ';
    strSQL := strSQL + '  PCG_NUMCTN = 0 AND ';
  End;
  strSQL := strSQL + '  PCG_ESPDOC = "PD" AND ';
  strSQL := strSQL + '  (PCG_BAIXAD = FALSE OR PCG_BAIXAD IS NULL ) ';

  {****************************}
  {* FILTRA SOMENTE PD COMPRA *}
  {*************************PZ*}
  If (intOpcFil = 2) Then
    strSQL := strSQL + ' AND IFNULL(EMP_FORFIL,"") <> PCG_CODFOR '
  {**********************************}
  {* FILTRA SOMENTE TRANSF. ESTOQUE *}
  {*******************************PZ*}
  Else If (intOpcFil = 3) Then
    strSQL := strSQL + ' AND IFNULL(EMP_FORFIL,"") = PCG_CODFOR ';

  If Not fEmptyStr(strCodEmp) Then
    strSQL := strSQL + '  AND IF(IFNULL(PCG_EMPDES, "") = "", PCG_CODEMP = ' + QuotedStr(strCodEmp) + ', PCG_EMPDES = ' + QuotedStr(strCodEmp) + ') ';

  If Not fEmptyStr(strNumPed) Then
    strSQL := strSQL + '  AND PCG_NUMPED = ' + QuotedStr(strNumPed) + ' ';

  Result := strSQL;
End;

procedure TfrmEntSelPedidos.FormShow(Sender: TObject);
  Var
    strTipPDE: String;
begin
  inherited;

  If fEmptyStr(strNumPed) Then
  Begin
    strTipPDE := fCfgSis('TIPPDE');

    If strTipPDE = '1' Then
      intOpcFil := 2
    Else If strTipPDE = '2' Then
      intOpcFil := 3
    Else
      intOpcFil := fGetMenu('Pesquisar Somente:',['Todos','Pedido de Compra','Transferência de Estoque'],1);
  End

  Else intOpcFil := 2;

  lflLastField.intIndCol := 13;
  lflLastField.strNomCam := dbgConsultaDados.Columns[13].DataBinding.FieldName;
  lflLastField.strNomCol := dbgConsultaDados.Columns[13].Caption;
  lflLastField.ftyTipCam := ftDateTime;

  blnSempreRelerBanco := False;
  blnQuoteLista       := False;

  fAbreConsulta(TRUE);

  If cdsConsulta.IsEmpty Then
  Begin
    fMensagem('', 'Não há pedidos em aberto!', ['&O k']);
    blnFechaForm := True;
  End
  Else
    pCalculaTotal;

  If Not fCfgSis('USACON', varBoolean) Then
  Begin
    edtDtaLib.Visible := False;
    lblDtaLib.Visible := False;
  End;

  Screen.Cursor := crDefault;
  intQtdSel     := 0;
  blnTravaFor   := not fEmptyStr(strCodFor);
  strTipSel     := '';

  dbgConsultaDados.DataController.DataSet.AfterScroll := pAtualizaRodape;
  pAtualizaRodape(nil);

  psetFocus(dbgConsulta);
end;

procedure TfrmEntSelPedidos.pAtualizaRodape(DataSet: TDataSet);
begin
  With cdsConsulta Do
  Begin
    edtDocOrig.Text := FieldByName('PCG_DOCORI').AsString;
    edtEmpDes.Text  := FieldByName('PCG_EMPDES').AsString;

    If Not fEmptyStr(FieldByName('PCG_DTALIB').AsString) Then
      edtDtaLib.Text := FormatDateTime('dd/mm/yyyy', FieldByName('PCG_DTALIB').AsDateTime)
    Else
      edtDtaLib.Text := '';

    edtCgcCpf.Text  := fFormataCpfCgc(FieldByName('FOR_C_G_C_').AsString, FPais);
  End;
end;

procedure TfrmEntSelPedidos.pCalculaTotal;
Begin
   With cdsConsulta.AggFields Do
   Begin
     edtTotIte.Text := FormatFloat('#,##0.00', FieldByName('TOT_TOTITE').Value);
     edtTotIpi.Text := FormatFloat('#,##0.00', FieldByName('TOT_TOTIPI').Value);
     edtTotSub.Text := FormatFloat('#,##0.00', FieldByName('TOT_TOTSUB').Value);
     edtTotGer.Text := FormatFloat('#,##0.00', FieldByName('TOT_TOTGER').Value);
   End;
End;

procedure TfrmEntSelPedidos.cdsConsultaAfterPost(DataSet: TDataSet);
begin
  inherited;

  pCalculaTotal;
end;

Function TfrmEntSelPedidos.fVeSeAtualizaPedidoCompraGrid(strNumPed, strCodEmp, strForEle, strForPed: String): Boolean;
Begin
  Result := fVeSeAtualizaPedidoCompra(strNumPed, strCodEmp, strForEle, strForPed, Not blnNotEle);

  If Result And (Not blnNotEle) Then
  With cdsConsulta Do
  Begin
    Edit;
    FieldByName('PCG_CODFOR').AsString := strForEle;
    FieldByName('FOR_NOMFOR').AsString := fRetNomFornecedor(strForEle);
    Post;
  End;
End;

procedure TfrmEntSelPedidos.pMarcaDuplicata(blnMarcar: Boolean);
  Var
    qryGenIte: TUniQuery;
    dtsGenIte: TDataSource;
    strNotas: String;
begin
  qryGenIte := fCriaQuery(Self);
  dtsGenIte := fCriaDataSource(qryGenIte);

  blnErroaoMarcar := False;

  If blnMarcar Then
  Begin

    With cdsConsulta Do
    If fTemPreNotaPedido(FieldByName('PCG_NUMPED').AsString,
                         FieldByName('PCG_CODEMP').AsString, strNotas) Then
    Begin
      pMensagemOk('Esse pedido já está associado à(s) pré-nota(s) '+ strNotas + ' e' + #13#10 +
                  'somente poderá ser alterado após a entrada de mercadorias (se parcial) ou' + #13#10 +
                  'cancelamento da(s) pré-nota(s).');

      exit;
    End;

    If (intQtdSel > 0) or blnTravaFor Then
    Begin

      If strCodFor <> cdsConsulta.FieldByName('PCG_CODFOR').AsString Then
      Begin
        If fFornecedoresMesmoGrupo(strCodFor, cdsConsulta.FieldByName('PCG_CODFOR').AsString) Then
        Begin
          If Not(fPergunta(MENSSAGEM_FORNECEDOR_MESMO_GRUPO)) Then
          Begin
            blnErroaoMarcar := True;
            Exit;
          End;
        End
        Else
        Begin
          If ((Not blnTravaFor) Or (Not fVeSeAtualizaPedidoCompraGrid(cdsConsulta.FieldByName('PCG_NUMPED').AsString,
                                                                      cdsConsulta.FieldByName('PCG_CODEMP').AsString,
                                                                      strCodFor,
                                                                      cdsConsulta.FieldByName('PCG_CODFOR').AsString))) Then
          Begin
            blnErroaoMarcar := True;
            fMensagem('', 'Só é possivel selecionar pedidos do mesmo fornecedor ou do mesmo grupo!', ['&O k']);
            Exit;
          End
        End;
      End;

    End;

    {************************************************************************}
    {*  NAO É PERMITIDO MARCAR PEDIDOS COM DATA DE BALANÇO >= DATA CORRENTE *}
    {*********************************************************************LA*}
    If Not fTestaDataBalanco(cdsConsulta.FieldByName('PCG_NUMPED').AsString,
                             cdsConsulta.FieldByName('PCG_CODEMP').AsString,
                             qryGenIte) Then
    Begin
      fMensagem('', 'Esse pedido contem itens com data de balanço ' + DateToStr(VS_Date) + '. Verifique!', ['&O k']);

      {**********************************************************}
      {*  MOSTRA OS ITENS  COM DATA DE BALANÇO >= DATA CORRENTE *}
      {*******************************************************PB*}
      Try
        pCriarFormularios(TfrmFatMostraItemSalBal, frmFatMostraItemSalBal);
        frmFatMostraItemSalBal.strPedOrc := cdsConsulta.FieldByName('PCG_ESPDOC').AsString;
        frmFatMostraItemSalBal.strNumPed := cdsConsulta.FieldByName('PCG_NUMPED').AsString;
        frmFatMostraItemSalBal.dbgItens.DataSource := dtsGenIte;
        frmFatMostraItemSalBal.ShowModal;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[frmEntSelPedidos.pMarcaDuplicata]');
        End;
      End;

      pFreeAndNil(frmFatMostraItemSalBal);
      Exit;

    End;

    If (intQtdSel = 0) Then
    Begin
      strCodFor := cdsConsulta.FieldByName('PCG_CODFOR').AsString;
      strTipSel := IIF(fEmptyStr(cdsConsulta.FieldByName('PCG_DOCORI').AsString), 'V', 'O');

      If (Not fEmptyStr(cdsConsulta.FieldByName('PCG_DOCORI').AsString)) And
         (Pos('PD', cdsConsulta.FieldByName('PCG_DOCORI').AsString) > 0) Then
      Begin
        strTipSel := 'V';
      End;
      blnBonificacao := cdsConsulta.FieldByName('PCG_PEDBON').AsString = 'S';
      strPedBon := cdsConsulta.FieldByName('PCG_PEDBON').AsString;
    End;

    Inc(intQtdSel);
  End
  Else
  Begin
    If (intQtdSel > 0) Then
      Dec(intQtdSel);

    If (intQtdSel <= 0) Then
    Begin
      if not blnTravaFor Then
        strCodFor := '';
      blnBonificacao := False;
      strTipSel := '';
    End;
  End;

  With cdsConsulta Do
  Begin
    Edit;
    FieldByName('PCG_MARDES').AsString := IIF(FieldByName('PCG_MARDES').AsString = 'M', 'D', 'M');

    If blnMarcar Then
    Begin
      FieldByName('MAR_TOTITE').AsFloat := FieldByName('PCG_TOTITE').AsFloat;
      FieldByName('MAR_TOTGER').AsFloat := FieldByName('PCG_TOTGER').AsFloat;
      FieldByName('MAR_TOTIPI').AsFloat := FieldByName('PCG_TOTIPI').AsFloat;
      FieldByName('MAR_TOTSUB').AsFloat := FieldByName('PCG_TOTSUB').AsFloat;
    End Else
    Begin
      FieldByName('MAR_TOTITE').AsFloat := 0;
      FieldByName('MAR_TOTGER').AsFloat := 0;
      FieldByName('MAR_TOTIPI').AsFloat := 0;
      FieldByName('MAR_TOTSUB').AsFloat := 0;
    End;

    Post;
  End;
  If not blnErroaoMarcar Then
    Inherited pAddListaQuery;
end;

procedure TfrmEntSelPedidos.pAddListaQuery;
  Var
    intRecNo: Integer;
    blnPedidoNormal: Boolean;
    strAutInc : String;
    strNumFat : String;
    blnMarca  : Boolean;
begin

  intRecNo := cdsConsulta.RecNo;

  If cdsConsulta.FieldByName('PCG_MARDES').AsString <> 'M' Then
  Begin
    If fEhPedidoCompraMultiLoja(cdsConsulta.FieldByName('PCG_NUMPED').AsString, 'PD',
                                cdsConsulta.FieldByName('PCG_CODEMP').AsString) Then
    Begin
      If Not fCfgSis('PDCGTR', varBoolean) Then
      Begin
        pMensagemOk('Esse pedido de compra é multi-loja e deve ser desmembrado para utilização!');
        Exit;
      End;
    End;

    If (Pos(fCfgSis('CONFME', varString), '1_3_') > 0) And (fCfgSis('USACON', varBoolean)) And
       (not fCfgSis('REFENT', varBoolean)) And
       fPedidoDeCompraOriundoDeGarantia(cdsConsulta.FieldByName('PCG_NUMPED').AsString,
                                        cdsConsulta.FieldByName('PCG_CODEMP').AsString) Then
    Begin
      fMensagem('', 'Não é permitido efetuar a entrada de um pedido de compra originado do envio de mercadorias em garantia para o fornecedor!', ['&Ok']);
      Exit;
    End;

    If fFornecedorFilial(cdsConsulta.FieldByName('PCG_CODFOR').AsString) Then
    Begin
      if Not fVerificaClaFisForFil(cdsConsulta.FieldByName('PCG_CODFOR').AsString) then
        Exit;
    End;

    {*************************}
    {* TRAVA QTDBAI NEGATIVO *}
    {**********************AF*}
    If Not fVerificaQtdBai Then
      Exit;

    blnPedidoNormal := (fEmptyStr(cdsConsulta.FieldByName('PCG_DOCORI').AsString)) Or
                       (Pos('PD', cdsConsulta.FieldByName('PCG_DOCORI').AsString) > 0);

    If ((blnPedidoNormal) And (fRetTipSelecionados = 'O'))     Or
       ((Not blnPedidoNormal) And (fRetTipSelecionados = 'V')) Then
    Begin
      fMensagem('','Não é permitido selecionar pedidos oriundos de TE/NF de transferências com pedidos de compra de fornecedores!',['&OK']);
      Exit;
    End;

    pMarcaDuplicata(True);
    IF blnErroaoMarcar Then
    begin
      Exit;
    end;

    If strPedBon <> cdsConsulta.FieldByName('PCG_PEDBON').AsString Then
    Begin
      If strPedBon = 'S' Then
        fMensagem('','Não é permitido selecionar pedidos de tipos diferentes, o primeiro selecionado é de bonificação!',['&OK'])
      Else
        fMensagem('','Não é permitido selecionar pedidos de tipos diferentes, o pedido selecionado é de bonificação!',['&OK']);
      pMarcaDuplicata(False);
      Exit;
    End;


    blnMarca := True;
  End
  Else
  Begin
    pMarcaDuplicata(False);
    blnMarca := False;
  End;

  pCalculaDadosInformativos;

  {***************************************************************}
  {* CASO SEJA TE CONFIRMADA E TIVER MAIS DE UM PEDIDO PARA A    *}
  {* MESMA NF TEM QUE MARCAR TODOS OS PEDIDOS DA MESMA NOTA      *}
  {************************************************************GB*}
  If (cdsConsulta.FindField('PCG_NUMFAT') <> Nil) And
     (not fEmptyStr(cdsConsulta.FieldByName('PCG_NUMFAT').AsString)) Then
  Begin
    With cdsConsulta Do
    Begin
      strAutInc := FieldByName('AUTOINCREM').AsString;
      strNumFat := FieldByName('PCG_NUMFAT').AsString;

      try
        DisableControls;
        First;

        While Not Eof Do
        Begin
          If (strNumFat = FieldByName('PCG_NUMFAT').AsString) And
             (strAutInc <> FieldByName('AUTOINCREM').AsString) Then
             begin
               pMarcaDuplicata(blnMarca);
             end;
          Next;
        End;

      Finally
        cdsConsulta.RecNo := intRecNo;
        EnableControls;
      End;

    End;
  End;

  cdsConsulta.RecNo := intRecNo;
End;

procedure TfrmEntSelPedidos.pCalculaDadosInformativos;
begin
  edtPedSel.Text := IntToStr(intQtdSel);
end;

procedure TfrmEntSelPedidos.dbgConsultaDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
 With ACanvas Do
  Begin
    If cdsConsulta.IsEmpty Then
      Exit;

    IF (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgConsultaDadosPCG_MARDES.Index] = 'M') THEN
    Begin

      If Brush.Color = clHighLight Then
      Begin
        Font.Color := clHighLightText;
      End Else
      Begin
        Brush.Color := intCorSelecao;
      End;

    End;
  end;

  With cdsConsulta Do
  Begin
    If Not Active Then
      Exit;

    If fEmptyStr(FieldByName('PCG_DTALIB').AsString) And blnUsaCon Then
      ACanvas.Font.Color := clRed;

  End;
end;

procedure TfrmEntSelPedidos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10: Begin
              btnConfirma.Click;
              Key := 0;
            End;
    VK_F11: Begin
              btnMostrarItensPend.Click;
              Key := 0;
            End;
  End;
  
end;

procedure TfrmEntSelPedidos.FormCreate(Sender: TObject);
begin
  inherited;
  FPais := fSetaPais;
  blnDocOri     := False;
  blnFechaForm  := False;
  blnConfirma   := False;
  blnCarregProd := True;
  blnFornJaAtualizado:= False;

  blnUsaCon     := fCfgSis('USACON', varBoolean);
  strCodFor     := '';
  strNumPed     := '';
  blnNotEle     := False;
  blnNotaImportacao := False;

  blnSomenteConferido := False;
  SetLength(arrDocOri, 0, 0);
end;

function TfrmEntSelPedidos.fAtualizaFornecedorMesmoGrupo: Boolean;
Var
  strCodForNovo: String;
  cdsCopiaDados: TUniClientDataSet;
Begin
  cdsCopiaDados := TUniClientDataSet.Create(Nil);
  cdsCopiaDados.Data:= cdsConsulta.Data;

  strFornecedorSelecionado:= '';
  cdsCopiaDados.Filtered:= False;
  cdsCopiaDados.Filter  := 'PCG_MARDES = ''M''';
  cdsCopiaDados.Filtered:= True;

  cdsCopiaDados.First;
  while Not(cdsCopiaDados.Eof) do
  Begin
    strFornecedorSelecionado := strFornecedorSelecionado + '_'+ cdsCopiaDados.FieldByName('PCG_CODFOR').AsString;
    cdsCopiaDados.Next;
  End;

  pCriarFormularios(TFrmSelFornecedor, FrmSelFornecedor);
  FrmSelFornecedor.strFornecedorSelecionado:=  strFornecedorSelecionado;

  FrmSelFornecedor.qryConsulta.Close;
  FrmSelFornecedor.qryConsulta.sql.Clear;
  FrmSelFornecedor.qryConsulta.SQL.Add(' SELECT * FROM CADFOR '+
                 ' WHERE LOCATE(FOR_CODFOR, "'+strFornecedorSelecionado+'") > 0 ');
  FrmSelFornecedor.qryConsulta.Open;

  If FrmSelFornecedor.qryConsulta.RecordCount > 1 Then
  Begin
    FrmSelFornecedor.ShowModal;
    Result:= (FrmSelFornecedor.ModalResult = mrOK);
  End
  Else
    Result:= True;

  If Result Then
  Begin

    strCodForNovo:= FrmSelFornecedor.qryConsulta.FieldByName('FOR_CODFOR').AsString;
    blnFornJaAtualizado := True; //Evita que o sistema realize a atualização do fornecedor no pedido apos entrada
    cdsCopiaDados.First;
    while Not(cdsCopiaDados.Eof) do
    Begin

      fAtualizaFornecedorPedido(
        cdsCopiaDados.FieldByName('PCG_NUMPED').AsString,
        cdsCopiaDados.FieldByName('PCG_CODEMP').AsString,
        strCodForNovo);

        If(cdsConsulta.Locate('PCG_NUMPED;PCG_CODFOR;PCG_CODEMP', VarArrayOf([
                                                    cdsCopiaDados.FieldByName('PCG_NUMPED').AsString,
                                                    cdsCopiaDados.FieldByName('PCG_CODFOR').AsString,
                                                    cdsCopiaDados.FieldByName('PCG_CODEMP').AsString]), [])) Then
        Begin
          cdsConsulta.Edit;
          cdsConsulta.FieldByName('PCG_CODFOR').AsString := strCodForNovo;
          If cdsConsulta.FindField('FOR_NOMFOR') <> Nil Then
            cdsConsulta.FieldByName('FOR_NOMFOR').AsString := fRetNomFornecedor(strCodForNovo);
          cdsConsulta.Post;
        End;

      cdsCopiaDados.Next;
    End;

  End;

  FreeAndNil(FrmSelFornecedor);
  FreeAndNil(cdsCopiaDados);

End;


procedure TfrmEntSelPedidos.btnConfirmaClick(Sender: TObject);
  Const
    CONFERENCIA_PEDIDO = '2';
  Var
    strCodOpe     : String;
    intIndice     : Integer;
    blnDocDif     : Boolean;

    blnLiberado,
    blnConferido,
    blnOperador,
    blnBaixado,
    blnImportado,
    blnMaisDeUm,
    blnOriundoImportacaoNotaEletronica: Boolean;

    strEmpDes,
    strEmpres,
    strRetFor,
    strPreNot,
    strAutInc: String;
    pedidosConferidos: String;
    pedidosNaoConferidos: String;
begin
  blnDocDif := False;
  Try
    cdsConsulta.DisableControls;
    cdsConsulta.Filtered := False;
    blnOperador := True;


    If fCfgSis('USACON', varBoolean) Then
    Begin
      blnSomenteConferido := True;

      For intIndice := 0 To stlListSelecao.Count - 1 Do
      begin
        If cdsConsulta.Locate('AUTOINCREM', stlListSelecao[intIndice], []) Then
        Begin

          If fEmptyStr(cdsConsulta.FieldByName('PCG_DTALIB').AsString) And (cdsConsulta.FieldByName('PCG_MARDES').AsString = 'M') Then
          Begin
            if pedidosNaoConferidos = '' then
              pedidosNaoConferidos := cdsConsulta.FieldByName('PCG_NUMPED').AsString
            else
              pedidosNaoConferidos := pedidosNaoConferidos+', '+cdsConsulta.FieldByName('PCG_NUMPED').AsString;
          End
          else
          begin
            if pedidosConferidos = '' then
              pedidosConferidos := cdsConsulta.FieldByName('PCG_NUMPED').AsString
            else
              pedidosConferidos := pedidosConferidos+', '+cdsConsulta.FieldByName('PCG_NUMPED').AsString
          end;

        End;

      end;

      if pedidosNaoConferidos <> '' then
      begin
        fMensagem('', 'Os pedidos ('+pedidosNaoConferidos+') não foram conferidos!', ['&O k']);

        if (pedidosConferidos <> '') and (fPergunta('Deseja carregar apenas os conferidos?')) then
          blnSomenteConferido := True
        else
          blnSomenteConferido := False;

        if not blnSomenteConferido then
        begin
          ffrmSenha(strSenha, 'Senha por direito de acesso!');
          strCodOpe := fRetCodVendedor(strSenha);

          If (Not fVerificaAcessoSistema('ENTPNL', strCodOpe)) Or fEmptyStr(strCodOpe) Then
          Begin
            fMensagem('', 'Usuário sem permissão de acesso!', ['&O k']);
            blnOperador := False;
          End;

        end;
      end;

    End;

    If Not blnOperador Then
    Begin
      cdsConsulta.EnableControls;
      Exit;
    End;

    If stlListSelecao.Count > 0 Then
    Begin
      fltValFre := 0;
      fltDesAce := 0;
      SetLength(arrPedidos, stlListSelecao.Count);
      SetLength(arrEmpresas, stlListSelecao.Count);

      If (stlListSelecao.Count > 1) Then
        If Not(fAtualizaFornecedorMesmoGrupo) Then
          Exit;


      For intIndice := 0 To stlListSelecao.Count - 1 Do
        With cdsConsulta Do
        If Locate('AUTOINCREM', stlListSelecao[intIndice], []) Then
        Begin
          If (Not blnDocOri) Then
            fPedidoCompraCadastrado(FieldByName('PCG_NUMPED').AsString,
                                    FieldByName('PCG_CODEMP').AsString,
                                    FieldByName('PCG_ESPDOC').AsString,
                                    blnBonificacao,
                                    blnLiberado, blnConferido, blnBaixado,
                                    blnDocOri, blnImportado, blnMaisDeUm,
                                    strEmpDes, strEmpres, strRetFor, strPreNot, strAutInc, blnOriundoImportacaoNotaEletronica);

          arrPedidos[intIndice]  := FieldByName('PCG_NUMPED').AsString;
          arrEmpresas[intIndice] := FieldByName('PCG_CODEMP').AsString;

          fltValFre := fltValFre + FieldByName('PCG_TOTFRE').AsFloat;
          fltDesAce := fltDesAce + FieldByName('PCG_TOTACE').AsFloat;

          SetLength(arrDocOri, Length(arrDocOri) + 1, 3);

          arrDocOri[Length(arrDocOri) -1, 0] := Copy(FieldByName('PCG_NUMFAT').AsString, 1, fTamDocCadRec());
          arrDocOri[Length(arrDocOri) -1, 1] := Copy(FieldByName('PCG_NUMFAT').AsString, fTamDocCadRec() + 2, 2);
          arrDocOri[Length(arrDocOri) -1, 2] := Copy(FieldByName('PCG_NUMFAT').AsString, fTamDocCadRec() + 5, 3);

          If FEmptyStr(strNumDoc) Then
          Begin
            strNumDoc := Copy(FieldByName('PCG_NUMFAT').AsString, 1, fTamDocCadRec());
            strNumSer := FieldByName('GER_SERIE_').AsString;
          End
          Else If (strNumDoc + strNumSer) <> (Copy(FieldByName('PCG_NUMFAT').AsString, 1, fTamDocCadRec()) + FieldByName('GER_SERIE_').AsString) Then
            blnDocDif := True;

        End;

      If blnDocDif Then
      Begin
        strNumDoc := '';
        strNumSer := '';
      End;

      Self.Close;
      blnConfirma := True;
      blnCarregProd := False;

    End Else
    Begin
      fMensagem('', 'É necessário escolher pelo menos um pedido!', ['&O k']);
      pSetFocus(dbgConsulta);
    End;

  Finally
    cdsConsulta.EnableControls;
  End;

end;

procedure TfrmEntSelPedidos.FormPaint(Sender: TObject);
begin
  inherited;

  If blnFechaForm Then
    Close;

end;

function TfrmEntSelPedidos.fRetTipSelecionados: String;
Begin
   Result := strTipSel;
End;

function TfrmEntSelPedidos.fVerificaQtdBai: Boolean;
  Var
    qryGen: TUniQuery;
Begin

  Try
    If Not fCfgSis('USACON', varBoolean) Then
    Begin
      Result := True;
      Exit;
    End;

    qryGen := fCriaQuery(Self);

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT ');
      SQL.Add('  PCD_QTDBAI, PCD_CODITE ');
      SQL.Add('FROM ');
      SQL.Add('  PCMDET ');
      SQL.Add('WHERE ');
      SQL.Add('  PCD_QTDBAI < 0 AND ');
      SQL.Add('  PCD_NUMPED = :NUMPED AND ');
      SQL.Add('  PCD_ESPDOC = :ESPDOC AND ');
      SQL.Add('  PCD_CODEMP = :CODEMP     ');

      ParamByName('NUMPED').AsString := cdsConsulta.FieldByName('PCG_NUMPED').AsString;
      ParamByName('ESPDOC').AsString := cdsConsulta.FieldByName('PCG_ESPDOC').AsString;
      ParamByName('CODEMP').AsString := cdsConsulta.FieldByName('PCG_CODEMP').AsString;

      Open;

      If IsEmpty Then
        Result := True
      Else
      Begin
        Result := False;
        pMensagemOk('O campo PCD_QTDBAI do item ' + FieldByName('PCD_CODITE').AsString + ' está com quantidade ' +
        FloatToStrF(FieldByName('PCD_QTDBAI').AsFloat, ffNumber, 15, 2) + ' referente ao pedido ' +
        cdsConsulta.FieldByName('PCG_NUMPED').AsString + #13#10 + 'Favor entrar em contato com a citel imediatamente!');
      End;

      Close;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro('Erro: ' + e.Message, '');
    End;
  End;
  FreeAndNil(qryGen);

End;

procedure TfrmEntSelPedidos.btnMostrarItensPendClick(Sender: TObject);
begin
  inherited;
  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(111, 5864, [],
                        ['NUMDOC','ESPDOC','CODEMP'],
                        [cdsConsulta.FieldByName('PCG_NUMPED').AsString,
                        cdsConsulta.FieldByName('PCG_ESPDOC').AsString,
                        cdsConsulta.FieldByName('PCG_CODEMP').AsString],
                        Sender,
                        nil,
                        True);
  End;
end;

end.
