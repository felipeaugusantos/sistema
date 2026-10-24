unit untUltimasCompras;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB,
  cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Uni, StrUtils, BitBtnLockedIncrem, cxLookAndFeels, untCfgGrid,
  cxLookAndFeelPainters, cxNavigator, frxClass, frxExportCSVTestabilidade, cxGridCitel,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  untGerenciaPropriedadesComponentes;

type
  TfrmUltimasCompras = class(TfrmPaiEdit)
    pnlOpcoes: TPanel;
    cxgUltCmpView: TcxGridDBTableViewCitel;
    cxgUltCmpLevel1: TcxGridLevel;
    cxgUltCmp: TcxGridCitel;
    rdgEmpresas: TRadioGroup;
    pnlFornecedor: TPanel;
    rdgFornecedor: TRadioGroup;
    cxgUltCmpDTA_MOV: TcxGridDBColumn;
    cxgUltCmpNUMDOC: TcxGridDBColumn;
    cxgUltCmpESPDOC: TcxGridDBColumn;
    cxgUltCmpCODEMP: TcxGridDBColumn;
    cxgUltCmpFORNECEDOR: TcxGridDBColumn;
    cxgUltCmpQTDITE: TcxGridDBColumn;
    cxgUltCmpPR_UNITARIO: TcxGridDBColumn;
    cxgUltCmpPR_TOTAL: TcxGridDBColumn;
    cxgUltCmpPR_UNITIMP: TcxGridDBColumn;
    cxgUltCmpTOTIMP: TcxGridDBColumn;
    cxgUltCmpOPERAD: TcxGridDBColumn;
    cxgUltCmpHOR_MOV: TcxGridDBColumn;
    dtsCompras: TDataSource;
    cxgUltCmpDTADOC: TcxGridDBColumn;
    cxgUltCmpPEDCOM: TcxGridDBColumn;
    cxgUltCmpCONPAG: TcxGridDBColumn;
    cxgUltCmpUNICOM: TcxGridDBColumn;
    cxgUltCmpUNIVEN: TcxGridDBColumn;
    btnCfgGri: TBitBtnLocked;
    cxgUltCmpViewCFOP: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rdgEmpresasClick(Sender: TObject);
    procedure rdgFornecedorClick(Sender: TObject);
    procedure btnCfgGriClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    qryUltCompras: TUniQuery;
    objCfgGridUltCmp: TCfgGrid;
    objGerenciaPropriedadesComponentes: TGerenciaPropriedadesComponentes;
    procedure pCarregaUltCompras(strCodIte: String; strNomCol: String = 'DTA_MOV');
  public
    { Public declarations }
    strCodFor: String;
    strCodIte: String;
    blnExibirMovimentoFornecedorFilial : Boolean;

  end;

var
  frmUltimasCompras: TfrmUltimasCompras;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmUltimasCompras.btnCfgGriClick(Sender: TObject);
begin
  inherited;

  If fVerificaAcessoSistema('GRULCP', strLoginUsuarioLogado) Then
    objCfgGridUltCmp.pConfiguraColunas
  Else
    fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok']);
end;

procedure TfrmUltimasCompras.FormCreate(Sender: TObject);
begin
  inherited;

  qryUltCompras := fCriaQuery(Self);
  dtsCompras.DataSet := qryUltCompras;
  blnExibirMovimentoFornecedorFilial := False;
  objCfgGridUltCmp := TCfgGrid.Create(Self, cxgUltCmpView, 'Últimas Compras');

  objGerenciaPropriedadesComponentes := TGerenciaPropriedadesComponentes.Create(Self, Self.Name, strLoginUsuarioLogado);
  objGerenciaPropriedadesComponentes.pAddComponente(rdgEmpresas);
  objGerenciaPropriedadesComponentes.pCarregar(False);
end;

procedure TfrmUltimasCompras.FormDestroy(Sender: TObject);
begin
  objGerenciaPropriedadesComponentes.pSalvar;
  FreeAndNil(objGerenciaPropriedadesComponentes);
  inherited;
end;

procedure TfrmUltimasCompras.FormShow(Sender: TObject);
begin
  inherited;

  If fEmptyStr(strCodFor) Then
  Begin
    pnlFornecedor.Visible := False;
  End Else
  Begin
    pnlFornecedor.Visible := True;
    rdgFornecedor.Items[0] := strCodFor + ' - ' + fRetNomFornecedor(strCodFor);
  End;

  Caption := 'Últimas Compras do Item ' + strCodIte + ' - ' + fRetNomProduto(strCodIte);

  pCarregaUltCompras(strCodIte);

  pSetFocus(cxgUltCmp);
end;

procedure TfrmUltimasCompras.pCarregaUltCompras(strCodIte: String; strNomCol: String = 'DTA_MOV');
  Const
    STR_TOTAL_COM_IMPOSTOS    = '  SUM((   ' +
                                '  IF( (   ' +
                                '       (IFNULL((SELECT CON_ULTPIS AS ULTPIS FROM CADEMP INNER JOIN CONEMP ON CON_EMPORI = EMP_CODEMP AND CON_EMPDES = :CODEMPLOGADA WHERE EMP_FORFIL = DET_CODFOR),"N") = "S") ' +
                                '          OR  ' +
                                '       (IFNULL((SELECT SIS_VALCFG FROM CFGSIS WHERE SIS_CODCFG = "CFG_ULTPIS" AND SIS_CODEMP = :CODEMPLOGADA ),"N") = "S") ' +
                                '       ), ' +
                                '      (D.DET_TOTITE - DET_DESESP) * (1 -(T.DET_ALQPIS + T.DET_ALQCOF )/100),  ' +  {DEDUZ PIS/COFINS}
                                '      (D.DET_TOTITE - DET_DESESP) ' +                                              {NÃO DEDUZ PIS/COFINS}
                                '     )    ' +
            '  + D.DET_VALIPI + ' +
            '  IF( (   ' +
                                '       (IFNULL((SELECT CON_ULTPIS AS ULTPIS FROM CADEMP INNER JOIN CONEMP ON CON_EMPORI = EMP_CODEMP AND CON_EMPDES = :CODEMPLOGADA WHERE EMP_FORFIL = DET_CODFOR),"N") = "S") ' +
                                '          OR  ' +
                                '       (IFNULL((SELECT SIS_VALCFG FROM CFGSIS WHERE SIS_CODCFG = "CFG_ULTPIS" AND SIS_CODEMP = :CODEMPLOGADA ),"N") = "S") ' +
                                '       ) ' +
                                '       AND (IFNULL( (SELECT SIS_VALCFG FROM CFGSIS WHERE SIS_CODCFG = "CFG_DPCSTU" AND SIS_CODEMP = :CODEMPLOGADA ), "N" ) = "S" ) ' +
                                '       AND (I.ITE_INCPIS = "S") '+
                                '       , ' +
                                '      (D.DET_VALRET) * (1 -(T.DET_ALQPIS + T.DET_ALQCOF )/100),  ' +  {DEDUZ PIS/COFINS}
                                '      (D.DET_VALRET) ' +                                              {NÃO DEDUZ PIS/COFINS}
            '    )    ' +
            '  + DET_TOTFRE + ' +
            '  IFNULL(DET_CONFRE, 0)  + IFNULL(T.DET_RPAFRE,0) + IFNULL(DET_VENDOR,0) + IFNULL(T.DET_OUTDES,0) + ' +
            '  IFNULL(T.DET_VAEIPI,0) + IFNULL(T.DET_VAERET,0) + IFNULL(DET_VFCPST,0) + ' +
            '  IFNULL(T.DET_ICMANT,0) + IFNULL(T.DET_VLGNRE,0) + DET_DESACE - ' +
            ' IF( ( ' +
            '    (IFNULL((SELECT CON_ULTPIS AS ULTPIS FROM CADEMP INNER JOIN CONEMP ON CON_EMPORI = EMP_CODEMP AND CON_EMPDES = :CODEMPLOGADA WHERE EMP_FORFIL = DET_CODFOR),"N") = "S") ' +
            '       OR ' +
            '    (IFNULL((SELECT SIS_VALCFG FROM CFGSIS WHERE SIS_CODCFG = "CFG_DEDICM" AND SIS_CODEMP = :CODEMPLOGADA ),"N") = "S") ' +
            '    ), ' +
            '    IFNULL(D.DET_VALICM,0), ' + {DEDUZ ICMS}
            '    0  ' + {NÃO ICMS}
            '  ) ' +
            ' )) ';

  Var
    strSQL  : String;
Begin
  With qryUltCompras Do
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  SUM(DET_QTDITE) AS QTDITE, ';
    strSQL := strSQL + '  D.DET_CLAFIS AS CLAFIS, ';
    strSQL := strSQL + '  SUM(DET_TOTITE - DET_DESESP) AS PR_TOTAL, ';
    strSQL := strSQL + '  D.DET_CODITE AS CODITE, ';
    strSQL := strSQL + '  D.DET_CODFOR AS CODFOR, ';
    strSQL := strSQL + '  D.DET_DTADOC AS DTADOC, ';
    strSQL := strSQL + '  D.DET_DTAENT AS "DTA_MOV",  ';
    strSQL := strSQL + '  D.DET_HORENT AS "HOR_MOV",  ';
    strSQL := strSQL + '  D.DET_NUMDOC AS NUMDOC, ';
    strSQL := strSQL + '  D.DET_ESPDOC AS ESPDOC, ';
    strSQL := strSQL + '  D.DET_CODEMP AS CODEMP, ';
    strSQL := strSQL + '  (SELECT GROUP_CONCAT(CONCAT("PD-", PCD_NUMPED)) FROM BAIPED B ';
    strSQL := strSQL + '	 LEFT JOIN PCMDET P ON B.BAI_AUTPED = P.AUTOINCREM ';
    strSQL := strSQL + '   WHERE BAI_AUTDET = D.AUTOINCREM) AS PEDCOM,         ';
    strSQL := strSQL +    fFormataCondPagSQL('D.DET_CONPAG','CONPAG') + ',';
    strSQL := strSQL + '  U.UNI_DESUNI AS UNIVEN, ';
    strSQL := strSQL + '  N.UNI_DESUNI AS UNICOM, ';
    strSQL := strSQL + '  FOR_NOMFOR AS "FORNECEDOR",  ';
    strSQL := strSQL + '  CONCAT(D.DET_CODVEN, "-", OPE_NOMOPE) AS "OPERAD",  ';
    strSQL := strSQL + '  SUM(DET_TOTITE - DET_DESESP) / SUM(DET_QTDITE) AS "PR_UNITARIO",  ';

    strSQL := strSQL +   STR_TOTAL_COM_IMPOSTOS + ' / SUM(D.DET_QTDITE) AS "PR_UNITIMP", ';
    strSQL := strSQL +   STR_TOTAL_COM_IMPOSTOS + ' AS "TOTIMP" ';

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE I ';
    strSQL := strSQL + '  JOIN MOVDET D ON D.DET_CODITE = I.ITE_CODITE  ';
    strSQL := strSQL + '  JOIN CADFOR ON FOR_CODFOR = D.DET_CODFOR ';
    strSQL := strSQL + '  LEFT JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ';
    strSQL := strSQL + '  LEFT JOIN CADUNI U ON I.ITE_CODUNI = U.UNI_CODUNI ';
    strSQL := strSQL + '  LEFT JOIN CADUNI N ON I.ITE_UNICOM = N.UNI_CODUNI ';
    strSQL := strSQL + '  LEFT JOIN CADOPE O ON O.OPE_CODOPE = D.DET_CODVEN ';
    strSQL := strSQL + 'WHERE ';

    If fItemEstrutura(strCodIte) And (Not fCfgSis('EXPEST', varBoolean)) Then
    Begin
      strSQL := strSQL + '  FALSE AND ';
    End;

    strSQL := strSQL + '  D.DET_TIP_FC = "F"          AND ';

    If rdgFornecedor.ItemIndex = 0 Then
      strSQL := strSQL + '  DET_CODFOR = ' + QuotedStr(strCodFor) + ' AND ';

    If rdgEmpresas.ItemIndex = 0 Then
      strSQL := strSQL + '  D.DET_CODEMP = :CODEMP      AND ';

    strSQL := strSQL + '  D.DET_CODITE = :CODITE      AND ';

    If fConferenciaDepoisDaEntrada Then
      strSQL := strSQL + ' D.DET_DTAENT IS NOT NULL AND  ';

    strSQL := strSQL + '  ((';
    If Not blnExibirMovimentoFornecedorFilial Then
      strSQL := strSQL + '   D.DET_CODFOR NOT IN (' + fRetForFilialTodos(True) + ') AND ';
    strSQL := strSQL + '    LOCATE(DET_CLAFIS, :CLACOM) > 0) OR ';

    If (blnExibirMovimentoFornecedorFilial) Then
      strSQL := strSQL + ' (D.DET_CODFOR IN (' + fRetForFilialTodos(True) + ')) '
    Else
      strSQL := strSQL + ' FALSE ';

    strSQL := strSQL + '  ) ';

    strSQL := strSQL + 'GROUP BY ';
    strSQL := strSQL + '  D.DET_NUMDOC, D.DET_ESPDOC, D.DET_CODEMP, D.DET_CODFOR ';

    strSQL := 'SELECT * FROM ( SELECT * FROM ( ' + strSQL;
    strSQL := strSQL + ' ) AS TMP ';

    strSQL := strSQL + 'ORDER BY  ';
    If UpperCase(strNomCol) = 'DTA_MOV' Then
      strSQL := strSQL + '  DTA_MOV DESC, HOR_MOV DESC'
    Else
      strSQL := strSQL + '  ' + strNomCol;

    strSQL := strSQL + ' ) AS TMP2 LIMIT 30 ';

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODITE').Value    := strCodIte;
    ParamByName('CLACOM').AsString := VS_strClaCom;
    ParamByName('CODEMPLOGADA').AsString := VS_strCodEmp;

    If rdgEmpresas.ItemIndex = 0 Then
      ParamByName('CODEMP').Value  := VS_strCodEmp;

    Open;

    (FieldByName('QTDITE') As TFloatField).DisplayFormat      := '#,##0.00';
    (FieldByName('PR_TOTAL') As TFloatField).DisplayFormat    := '#,####0.0000';
    (FieldByName('PR_UNITARIO') As TFloatField).DisplayFormat := '#,####0.0000';
    (FieldByName('TOTIMP') As TFloatField).DisplayFormat      := '#,####0.0000';
    (FieldByName('PR_UNITIMP') As TFloatField).DisplayFormat  := '#,####0.0000';
  End;

end;

procedure TfrmUltimasCompras.rdgEmpresasClick(Sender: TObject);
begin
  inherited;

  pCarregaUltCompras(strCodIte);
end;

procedure TfrmUltimasCompras.rdgFornecedorClick(Sender: TObject);
begin
  inherited;

  pCarregaUltCompras(strCodIte);

end;

end.
