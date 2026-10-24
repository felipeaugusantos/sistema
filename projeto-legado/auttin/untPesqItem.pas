unit untPesqItem;

interface

uses
  Uni, SysUtils, Forms, StdCtrls, EditFocus, MaskEditFocus, untTypesSistema,
  untClassPanelCx, untFuncoesSimples, Variants, UniClientDataSet, DB, Dialogs,
  StrUtils, DBEditFocus, ExtCtrls, cxStyles, Graphics, cxCustomData, System.Generics.Collections,
  Controls, Classes,
  cxGridCustomTableView, cxGridDBTableView,untFuncoesGenerica,
  untConstantes, MaskUtils, untLegendasItem,
  untConsultasTinta;

Type

  TDefConsulaItem = class(TDefConsulta)
  private

    cdsLegendas: TLegendasItem;
  public

    blnSitPro: Boolean;

    sltItems: TStringList;

    strTabPre,
    strCodCli: String;

    blnColorirGrid: Boolean;

    Constructor Create; Reintroduce;
    Destructor Destroy; override;

    procedure pParametriza(qryConsulta: TUniQuery); override;

    function fGetCellStyle(AView: TcxGridDBTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; ADataSet: TDataSet): TcxStyle; override;

  End;

{ TDefConsulaItem }

Procedure pIniciaPesqItem(Conexao: TUniConnection;
                          strUsuario,
                          strEmpresa: String;
                          objTraceViewer: ITraceViewer;
                          intDebugH: Byte;
                          dtaDate: TDate;
                          strComputerNetName,
                          strUserFromWindows,
                          strIPAddressAsString,
                          strMacAddress: String);

function fPesqItem(opcTipIte: TTipoConsultaItem;
                   Self     : TForm;                         {* Formulário                                  *}
                   edtCodigo: TCustomEdit;                   {* Edit do Código                              *}
                   edtDesIte: TCustomEdit;                   {* Edit da Descrição do item                   *}
                   qryTabela: TUniQuery;                     {* Query                                       *}
                   Var chrKey: Char;                         {* Key                                         *}
                   Var arrSel: TConsultasArray;              {* Array de Seleção                            *}
                   blnConSim: Boolean = True;                {* Consulta Simples ou Múltipla (multi select) *}
                   objFrmPnl: TPanelCx = Nil;                {* Painel                                      *}
                   strTitulo: string = 'Consulta de Itens';
                   strTabPre: String = '1';
                   strConPag: String = '';
                   fltTaxVpr: Double = 0;
                   blnEmpFat: Boolean = False;
                   blnExiPar: Boolean = False;
                   intOpcAtivos: Integer = 0;
                   opcCodIte: TCodigoRetornoItem = cdrCodIte;
                   strAplica: String = '';
                   blnPedCom: Boolean = False;   {* Se é pedido de compra                        *}
                   strCodCli: String = '';
                   blnMostrarPrecos: Boolean = True;
                   blnTablet: Boolean = False;
                   blnConsiderarExiLis: Boolean = True;
                   strCodCmp: String = ''; // Codigo do Comprador
                   blnDepMatPriIndustrial: Boolean = False;
                   blnDepProAcaIndustrial: Boolean = False;
                   blnDepProEmbIndustrial: Boolean = False;
                   blnDepProGraIndustrial: Boolean = False;
                   blnVeioF11: Boolean = False;
                   blnSomenteAgrotoxico: Boolean = False;
                   blnMostrarItensDeServico: Boolean = False;
                   blnExibeColunaSaldoCD: Boolean = False;
                   strEmp_CD: String = '';
                   fltDescFidelidade: Double = -1;
                   blnFaturamento: Boolean = False;
                   strCodFab: String = '';
                   blnMostraSaldo: Boolean = True;
                   strFiltros: string = '';
                   strCodEmp: String = '';
                   strEmpSaldoMatrizCD: String = '';
                   strDescri: String = '';
                   strCodBar: String = '';
                   strProdutoLocalizar: String = '';
                   blnConfirma: Boolean = True;
                   blnConEquEnt: Boolean = False;
                   blnSomenteEstrutura: Boolean = False;
                   objPnlBanner: TPanelCx = Nil;
                   objPnlPreFiltro: TPanelCx = Nil;
                   strCodCnd: String = '';
                   strNumOrc: String = '';
                   strEspOrc: String = ''): Boolean;

implementation

uses
  untFuncoesGen, untModulo;

constructor TDefConsulaItem.Create;
begin
  Inherited Create;
  blnColorirGrid := False;

  blnSitPro   := fCfgSis('SITPRO', varBoolean);
  cdsLegendas := TLegendasItem.Create(Nil);
end;

destructor TDefConsulaItem.Destroy;
begin
  FreeAndNil(cdsLegendas);
  Inherited Destroy;
end;

procedure TDefConsulaItem.pParametriza(qryConsulta: TUniQuery);
Begin
  If Assigned(sltItems) And (qryConsulta.Params.FindParam('LISTA') <> Nil) Then
    qryConsulta.ParamByName('LISTA').AsString := sltItems.CommaText;
End;

function TDefConsulaItem.fGetCellStyle(AView: TcxGridDBTableView;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; ADataSet: TDataSet): TcxStyle;
  Var
    ARowInfo: TcxRowInfo;

  function fIdxColumn(strCampo: String): Integer;
  begin
    Result := -1;

    {********************************************************}
    {* ESSA FUNÇAO TEVE DE ALTERAR O COMPONENTE DEV-EXPRESS *}
    {* SE ESTA OCORRENDO ERRO DE TYPECAST VC DEVE VERIFICAR *}
    {* NOS COMPONENTES SE A CORREÇÃO FOI APLICADA EM SUA    *}
    {* MÁQUINA                                              *}
    {*****************************************************AF*}
    If ADataSet.FindField(strCampo) <> nil Then
      Result := AView.GetColumnByFieldName(strCampo).Index;
  end;

  function fGetValor(ColumnIndex: Integer): Variant;
  begin
    Result := null;

    ARowInfo := AView.DataController.GetRowInfo(ARecord.Index);

    With AView, DataController Do
      If ColumnIndex > -1 Then
      Begin
        Result := Values[ARowInfo.RecordIndex, ColumnIndex];
      End;

  end;

begin

  Result := nil;

  If blnColorirGrid And ARecord.IsData And (ARecord.Index > -1) Then
  Begin

    If IfNull(fGetValor(fIdxColumn('ITEITEATI')), '') = 'INATIVO' Then
      Result := cdsLegendas.fRetStyle(ARRDESC_SITUACAO_ITEM[sitInativo])

    Else If IfNull(fGetValor(fIdxColumn('ITEATICOM')), '') = 'INATIVO' Then
      Result := cdsLegendas.fRetStyle(ARRDESC_SITUACAO_ITEM[sitInativoCompra])

    Else If IfNull(fGetValor(fIdxColumn('ESTRUT')), 0) > 0 Then
      Result := cdsLegendas.fRetStyle(ARRDESC_SITUACAO_ITEM[sitEstrutura])

    Else If IfNull(fGetValor(fIdxColumn('BOCACAIXA')), '') = 'SIM' Then
      Result := cdsLegendas.fRetStyle(ARRDESC_SITUACAO_ITEM[sitBocaCaixa])

    Else If (IfNull(fGetValor(fIdxColumn('EMPROMOC')), '') = 'SIM') Or
            (IfNull(fGetValor(fIdxColumn('IPR_PROMOC')), 0) > 0)    Then
      Result := cdsLegendas.fRetStyle(ARRDESC_SITUACAO_ITEM[sitPromocao])

    Else If IfNull(fGetValor(fIdxColumn('COMBO')), '') = 'S' Then
      Result := cdsLegendas.fRetStyle(ARRDESC_SITUACAO_ITEM[sitCombo])

    Else If blnSitPro And (IfNull(fGetValor(fIdxColumn('SIT_DESCRI')), '') <> '') Then
      Result := cdsLegendas.fRetStyle(fGetValor(fIdxColumn('SIT_DESCRI')));

  End;

end;




function fSubSelEstrutura: String;
var
  strSubSQL : String;
begin
  strSubSQL := '';
  strSubSQL := strSubSQL + '(SELECT ';
  strSubSQL := strSubSQL + '  COUNT(GMT.AUTOINCREM) AS EST ';
  strSubSQL := strSubSQL + 'FROM ';


  //APENAS GERMAT, POIS AGORA OS DOIS PODEM ESTAR HABILITADOS JUNTOS E A TELA EXIBE APENAS ITENS DA GERMAT
  //If (fCfgSis('UTIIND', varBoolean)) Then
  //  strSubSQL := strSubSQL + ' GEIMAT GMT '
  //Else
  strSubSQL := strSubSQL + ' GERMAT GMT ';

  strSubSQL := strSubSQL + 'WHERE ';
  strSubSQL := strSubSQL + '  I.ITE_CODITE = GMT.GMT_CODITE ) ';

  Result := strSubSQL;
end;

function fPesqItem(opcTipIte: TTipoConsultaItem;
                   Self     : TForm;                         {* Formulário                                  *}
                   edtCodigo: TCustomEdit;                   {* Edit do Código                              *}
                   edtDesIte: TCustomEdit;                   {* Edit da Descrição do item                   *}
                   qryTabela: TUniQuery;                     {* Query                                       *}
                   Var chrKey: Char;                         {* Key                                         *}
                   Var arrSel: TConsultasArray;              {* Array de Seleção                            *}
                   blnConSim: Boolean = True;                {* Consulta Simples ou Múltipla (multi select) *}
                   objFrmPnl: TPanelCx = Nil;                {* Painel                                      *}
                   strTitulo: string = 'Consulta de Itens';
                   strTabPre: String = '1';
                   strConPag: String = '';
                   fltTaxVpr: Double = 0;
                   blnEmpFat: Boolean = False;
                   blnExiPar: Boolean = False;
                   intOpcAtivos: Integer = 0;
                   opcCodIte: TCodigoRetornoItem = cdrCodIte;
                   strAplica: String = '';
                   blnPedCom: Boolean = False;   {* Se é pedido de compra                        *}
                   strCodCli: String = '';
                   blnMostrarPrecos: Boolean = True;
                   blnTablet: Boolean = False;
                   blnConsiderarExiLis: Boolean = True;
                   strCodCmp: String = ''; // Codigo do Comprador
                   blnDepMatPriIndustrial: Boolean = False;
                   blnDepProAcaIndustrial: Boolean = False;
                   blnDepProEmbIndustrial: Boolean = False;
                   blnDepProGraIndustrial: Boolean = False;
                   blnVeioF11: Boolean = False;
                   blnSomenteAgrotoxico: Boolean = False;
                   blnMostrarItensDeServico: Boolean = False;
                   blnExibeColunaSaldoCD: Boolean = False;
                   strEmp_CD: String = '';
                   fltDescFidelidade: Double = -1;
                   blnFaturamento: Boolean = False;
                   strCodFab: String = '';
                   blnMostraSaldo: Boolean = True;
                   strFiltros: string = '';
                   strCodEmp: String = '';
                   strEmpSaldoMatrizCD: String = '';
                   strDescri: String = '';
                   strCodBar: String = '';
                   strProdutoLocalizar: String = '';
                   blnConfirma: Boolean = True;
                   blnConEquEnt: Boolean = False;
                   blnSomenteEstrutura: Boolean = False;
                   objPnlBanner: TPanelCx = Nil;
                   objPnlPreFiltro: TPanelCx = Nil;
                   strCodCnd: String = '';
                   strNumOrc: String = '';
                   strEspOrc: String = ''): Boolean;

  Var
    strSQL     : String;
    strWhere   : String;
    qryConsulta: TUniQuery;
    objConsulta: TDefConsulta;
    arrOrdena,
    arrTitCol: TColunasArray;                                 {* Títulos das Colunas                         *}
    blnExcosa,
    blnItePDO,
    blnOrcPen: Boolean;
    strTabCli: String;
//    intDecUni: Integer;
    blnUsaQtdPen : Boolean;
//    blnExibirInfPromoc : Boolean;
    blnExibirEmCampanha: Boolean;

    Procedure pAddNomeColuna(strNomCol: String);
    Begin
      SetLength(arrTitCol, Succ(Length(arrTitCol)));
      arrTitCol[High(arrTitCol)] := strNomCol;
    End;

    Function fSubSelMontadora: String;
    Begin
      Result := '(SELECT CAST(GROUP_CONCAT(MON_DESCRI SEPARATOR " / ") AS CHAR(120)) FROM CADMON LEFT JOIN ITEMON ON MON_CODMON = ITM_CODMON WHERE ITM_CODITE = I.ITE_CODITE)';
    End;


    Procedure pDefineConsulta;
    Begin
      objConsulta := TDefConsulaItem.Create;

      If Assigned(objFrmPnl) Then
        TDefConsulaItem(objConsulta).sltItems := objFrmPnl.sltLista;

      If blnFaturamento Then
        objConsulta.strSQLRetorno := 'SELECT CADITE.*, BAR_CODBAR, BAR_EMBALA, BAR_PREVEN, BAR_TABPRE, BAR_DESCRI FROM CADITE LEFT JOIN ITEBAR ON BAR_CODITE = ITE_CODITE AND BAR_EXBFAT = "S"';

      If Not fEmptyStr(strDescri) Then
        objConsulta.pIncluiFiltro('ITE_DESITE', ReplaceStr(strDescri, '*', '%'))

      Else If Not fEmptyStr(strCodBar) Then
      Begin
        If (Not blnFaturamento) Then
          objConsulta.pIncluiFiltro('ITE_BARRAS', ReplaceStr(strCodBar, '*', '%'))
        Else
          objConsulta.pIncluiFiltro('ITE_BARRAS_FAT', ReplaceStr(strCodBar, '*', '%'));
      End
      Else If Not fEmptyStr(strCodFab) Then
        objConsulta.pIncluiFiltro('ITE_FABRIC', ReplaceStr(ReplaceStr('*' + strCodFab + '*', '*', '%'), '%%', '%'))

      Else If Not fEmptyStr(strProdutoLocalizar) Then
      Begin
        strDescri := fRetNomProduto(strProdutoLocalizar);

        If Not fEmptyStr(strDescri) Then
        Begin
          strDescri := Copy(strDescri, 1, Pos(' ', strDescri));
          objConsulta.pIncluiFiltro('ITE_DESITE', ReplaceStr(strDescri, '*', '%'));

          objConsulta.recLocalizar.strNomCam := 'ITE_CODITE';
          objConsulta.recLocalizar.strValCam := strProdutoLocalizar;
        End;
      End;

      TDefConsulaItem(objConsulta).blnColorirGrid := Assigned(objFrmPnl);
      TDefConsulaItem(objConsulta).strTabPre := strTabPre;
      TDefConsulaItem(objConsulta).strCodCli := strCodCli;

      If (blnUsaQtdPen) Then
      Begin
        objConsulta.pIncluiSubConsulta('ITE_SALDOS2', 'G.ITE_SALDOS + IFNULL(QTDPEN, 0)');

        If Not blnExcosa Then
          objConsulta.pIncluiSubConsulta('COMSALDO', 'IF(G.ITE_SALDOS + IFNULL(QTDPEN, 0) > 0, "SIM", "NÃO")');
      End
      Else
      Begin
        objConsulta.pIncluiSubConsulta('ITE_SALDOS2', 'G.ITE_SALDOS');

        If Not blnExcosa Then
          objConsulta.pIncluiSubConsulta('COMSALDO', 'IF((G.ITE_SALDOS) > 0, "SIM", "NÃO")');
      End;


      objConsulta.pIncluiSubConsulta('ITERECDEV', 'IF(G.ITE_RECDEV = "S", "SIM", "NÃO")');

      objConsulta.pIncluiSubConsulta('ITEITEATI', 'IF(I.ITE_ITEATI = "S", "ATIVO", "INATIVO")');
      objConsulta.pIncluiSubConsulta('ITEATICOM', 'IF(I.ITE_ATICOM = "S", "ATIVO", "INATIVO")');
      objConsulta.pIncluiSubConsulta('ULTVEN', 'DATEDIFF(' + fCurrentDate + ', G.ITE_DTAUVE)');



      objConsulta.pIncluiSubConsulta('IPR_PROMOC', ' 0.00 ');
      objConsulta.pIncluiSubConsulta('IPR_JA_ATU', ' "N" ');
      objConsulta.pIncluiSubConsulta('IPR_TABPRE', 'CAST("' + strTabPre + '" AS CHAR(1))');
      objConsulta.pIncluiSubConsulta('IPR_CODCLI', 'CAST("' + strCodCli + '" AS CHAR(8))');
      objConsulta.pIncluiSubConsulta('IPR_EMPCOD', '"' + IfThen(fEmptyStr(strCodEmp), VS_strCodEmp, strCodEmp) + '"');
      objConsulta.pIncluiSubConsulta('MSGLIV'    , 'CONCAT(IFNULL(I.ITE_MSGLV1, ""), " ", IFNULL(I.ITE_MSGLV2, ""))');


      objConsulta.pIncluiSubConsulta('ITE_FABRIC', '(IF(LOCATE(" ", TRIM(REPLACE(I.ITE_FABRIC, "|", ""))) > 0, I.ITE_FABRIC, TRIM(REPLACE(I.ITE_FABRIC, "|", ""))))');

      objConsulta.pIncluiSubConsulta('ITEPESQUI', 'CAST(LTRIM(REPLACE(ITE_PESQUI, "<<csq>>", " ")) AS CHAR(255))', 'ITE_PESQUI');


      objConsulta.pFormataDecimal('ITE_EMBALA', DEC_EMBALAGEM);
      objConsulta.pFormataDecimal('ITE_SALDOS2', 3);

      objConsulta.pIncluiConflito('ITE_CODITE', 'I.ITE_CODITE');
      objConsulta.pIncluiConflito('ITE_CODABF', 'I.ITE_CODABF');

      objConsulta.pIncluiCampoSimNao('COMSALDO');
      objConsulta.pIncluiCampoSimNao('EMPROMOC');

      If blnExibirEmCampanha Then
        objConsulta.pIncluiCampoSimNao('EMCAMPANHA');

      objConsulta.pIncluiCampoSimNao('BOCACAIXA');
      objConsulta.pIncluiCampoSimNao('ITERECDEV');

      If blnItePDO Then
        objConsulta.pIncluiCampoSimNao('ITE_PDOR');
    End;

    Function fRetCodPes: String;
    Begin
      Case opcCodIte of
        cdrCodFab: Result := 'ITE_CODFAB';
        Else       Result := 'ITE_CODITE';
      End;
    End;

    Function fSQLItens: String;
      Var
        strSQL: String;
//        intCnt : Integer;
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT ';

      If {(blnFaturamento Or ) And} Assigned(objFrmPnl) And Assigned(objFrmPnl.sltLista) Then
      Begin
        strSQL := strSQL + ' VENDIDO, ';  pAddNomeColuna('TAB');
        objConsulta.pIncluiSubConsulta('VENDIDO', 'CAST(IF(LOCATE(I.ITE_CODITE, :LISTA) > 0, 1, NULL) AS UNSIGNED)');
        objConsulta.pIncluiIcone('VENDIDO', 0, 0);
        objConsulta.pIncluiIcone('VENDIDO', 1, 1);
      End;

      If (fCfgSis('TIPABF', varString) = '1') Then
        objConsulta.pIncluiSubConsulta('ABFICM', '(SELECT CONCAT(ABF_CODABF, "-", ABF_DESABF) FROM ABFICM WHERE ABF_CODABF = I.ITE_CODABF LIMIT 1)')
      Else
        objConsulta.pIncluiSubConsulta('ABFICM', '(SELECT CONCAT(ABF_CODABF, "-", ABF_DESABF) FROM ABFICM WHERE ABF_CODABF = G.ITE_CODABF LIMIT 1)');

      strSQL := strSQL + '  I.ITE_CODGRU, ';  pAddNomeColuna('Grupo');
      strSQL := strSQL + '  I.ITE_CODITE, ';  pAddNomeColuna('Código');
      strSQL := strSQL + '  I.ITE_DESITE, ';  pAddNomeColuna('Descrição');


      strSQL := strSQL + '  I.ITE_REFERE, ';  pAddNomeColuna('Referência');
      strSQL := strSQL + '  U.UNI_SIGUNI, ';  pAddNomeColuna('Unid.');

      If (blnMostraSaldo) Then
      Begin
        strSQL := strSQL + '  ITE_SALDOS2,  ';
        pAddNomeColuna('Saldo');
      End;

      {*******************************************************************************}
      {*    Caso o parãmetro  VENMAD = Utilizar rotinas de venda de madeira? = SIM   *}
      {*           então ira calcular o fator que estiver definido no campo          *}
      {*             FATCMP - Fator de conversão madeira de m³ para Peças            *}
      {*****************************************************************************WG}




      strSQL := strSQL + '  IPR_PROMOC,    '; pAddNomeColuna('Preço Promoção');
      strSQL := strSQL + '  QTDPROMOC,     '; pAddNomeColuna('Quantidade Promoção');
      strSQL := strSQL + '  BCA_PREMIN,    '; pAddNomeColuna('Preço Boca de Caixa');
      strSQL := strSQL + '  BCA_COMVAR,    '; pAddNomeColuna('Comissão Boca de Caixa');

      strSQL := strSQL + '  M.MAR_DESMAR,  '; pAddNomeColuna('Marca');

       pAddNomeColuna('Cód. Barra');

      If (Not blnFaturamento) Then
        strSQL := strSQL + '  I.ITE_BARRAS,  '
      Else
        strSQL := strSQL + '  ITE_BARRAS_FAT,  ';

      strSQL := strSQL + '  I.ITE_BAREMB,  '; pAddNomeColuna('Cód. Barra Embalagem');

      pAddNomeColuna('Cód. Fábrica');
	   strSQL := strSQL + '  ITE_FABRIC,  ';  

      strSQL := strSQL + '  I.ITE_DESFAB,  '; pAddNomeColuna('Des. Fábrica');
      strSQL := strSQL + '  ITE_LOCFIS,    '; pAddNomeColuna('Loc. Física');
      strSQL := strSQL + '  G.ITE_LOCSUP,  '; pAddNomeColuna('Loc. Super Estoque');
      strSQL := strSQL + '  I.ITE_CODFOR,  '; pAddNomeColuna('Cód. Fornecedor');
      strSQL := strSQL + '  F.FOR_NOMFOR,  '; pAddNomeColuna('Nome do Fornecedor');
      strSQL := strSQL + '  ULTVEN,        '; pAddNomeColuna('Dias sem venda');
      strSQL := strSQL + '  I.ITE_DTAALT,  '; pAddNomeColuna('Última Alteração');
      strSQL := strSQL + '  G.ITE_DTAULT,  '; pAddNomeColuna('Última Compra');

      strSQL := strSQL + '  I.ITE_EMBALA , '; pAddNomeColuna('Embalagem de Compra');
      strSQL := strSQL + '  ABFICM,        '; pAddNomeColuna('Cód. Fiscal');
      strSQL := strSQL + '  I.ITE_CLAIPI,  '; pAddNomeColuna('Cód. NCM');
      strSQL := strSQL + '  G.ITE_IPISAI,  '; pAddNomeColuna('IPI de Saída');
      strSQL := strSQL + '  DEP_DESCRI,    '; pAddNomeColuna('Departamento');
      strSQL := strSQL + '  ITEATICOM,     '; pAddNomeColuna('Ativo para Compra');
      strSQL := strSQL + '  ITEITEATI,     '; pAddNomeColuna('Status');
      strSQL := strSQL + '  ITE_DIAFOR,    '; pAddNomeColuna('Dias para entrega do Fornecedor');
      strSQL := strSQL + '  ITE_COMVAR,  '; pAddNomeColuna('% Prêmio Vend. Int.');
      strSQL := strSQL + '  ITE_COMATA,  '; pAddNomeColuna('% Prêmio Repres. Ext.');
      strSQL := strSQL + '  ITE_COMDIS,  '; pAddNomeColuna('% Prêmio Repres. Ext. Distrib.');
      strSQL := strSQL + '  COMSALDO,      '; pAddNomeColuna('Com Saldo');
      strSQL := strSQL + '  EMPROMOC,      '; pAddNomeColuna('Em Promoção');
      strSQL := strSQL + '  BOCACAIXA,     '; pAddNomeColuna('Em boca de caixa');

      If blnExibirEmCampanha Then
      Begin
        strSQL := strSQL + '  EMCAMPANHA,    '; pAddNomeColuna('Em Campanha');
      End;

      strSQL := strSQL + '  CMP.OPE_NOMOPE, '; pAddNomeColuna('Comprador');

      If blnItePDO Then
      Begin
        strSQL := strSQL + '  ITE_PDOR,    '; pAddNomeColuna('Itens Vendidos em PD/OR');
      End;

      strSQL := strSQL + '  I.ITE_CDCEST,  '; pAddNomeColuna('Classificação CEST');
      strSQL := strSQL + '  I.ITE_TMPGAR,  ';  pAddNomeColuna('Tempo de Garantia');



      strSQL := strSQL + '  I.ITE_DESSIM, '; pAddNomeColuna('Descrição Simplificada');

      strSQL := strSQL + '  ITEPESQUI,     '; pAddNomeColuna('Descrição Livre');

      strSQL := strSQL + '  I.ITE_MLTCOM,  '; pAddNomeColuna('Múlt. Compra');
      strSQL := strSQL + '  I.ITE_MLTVEN,  '; pAddNomeColuna('Múlt. Venda');

      strSQL := strSQL + '  GPR_DESCRI,  '; pAddNomeColuna('Grupo de Preços');
      strSQL := strSQL + '  PRD_DESGRU,  '; pAddNomeColuna('Grupo de Produto');
      strSQL := strSQL + '  GRU_DESCRI,  '; pAddNomeColuna('Grupo de Compra');

      strSQL := strSQL + '  G.ITE_DESMAX,  '; pAddNomeColuna('Desc. Máx. Vendedor');
      strSQL := strSQL + '  G.ITE_DESMSU,  '; pAddNomeColuna('Desc. Máx. Sub-Gerente');
      strSQL := strSQL + '  G.ITE_DESMGE,  '; pAddNomeColuna('Desc. Máx. Gerente');
      strSQL := strSQL + '  I.ITE_PESOIT,  '; pAddNomeColuna('Pes. Bruto');
      strSQL := strSQL + '  I.ITE_PESLIQ,  '; pAddNomeColuna('Pes. Líquido');
      strSQL := strSQL + '  G.ITE_ESTMIN,  '; pAddNomeColuna('Est. Mínimo');
      strSQL := strSQL + '  G.ITE_ESTMAX,  '; pAddNomeColuna('Est. Máximo');

      strSQL := strSQL + '  ITERECDEV,     '; pAddNomeColuna('Permite Devolução');

      If TDefConsulaItem(objConsulta).blnSitPro Then
      Begin
        strSQL := strSQL + '  SIT_DESCRI,   ';  pAddNomeColuna('Situação do Produto');
      End;

      // CAMPOS QUE NAO APARECEM NA GRID - SEM NOME DE COLUNA

      If TDefConsulaItem(objConsulta).blnSitPro Then
      Begin
        strSQL := strSQL + '  SIT_CORSIT,   ';
      End;

      strSQL := strSQL + '  ESTRUT,        ';
      strSQL := strSQL + '  I.ITE_INFGAR,  ';
      strSQL := strSQL + '  I.ITE_APLICA,  ';
      strSQL := strSQL + '  I.ITE_CODSIM,  ';
      strSQL := strSQL + '  G.ITE_SAL_ML,  ';
      strSQL := strSQL + '  I.ITE_CNV_ML,  ';
      strSQL := strSQL + '  I.ITE_MSGLV1,  ';
      strSQL := strSQL + '  I.ITE_MSGLV2,  ';
      strSQL := strSQL + '  G.ITE_SALDOS,  ';
      strSQL := strSQL + '  BAR_EMBALA,    ';
      strSQL := strSQL + '  BAR_PREVEN,    ';
      strSQL := strSQL + '  BAR_DESCRI,    ';
      strSQL := strSQL + '  BAR_TABPRE,    ';
      strSQL := strSQL + '  IPR_CODCLI,    ';
      strSQL := strSQL + '  IPR_JA_ATU,    ';
      strSQL := strSQL + '  IPR_TABPRE,    ';
      strSQL := strSQL + '  IPR_EMPCOD,    ';
      strSQL := strSQL + '  IPR_PREPRO,    ';

      If blnOrcPen Then
        strSQL := strSQL + '  ORCPEN,      ';

      strSQL := strSQL + '  MSGLIV, ';

      strSQL := strSQL + ' (SELECT AGR_CODAGR FROM CADAGR WHERE AGR_CODITE = I.ITE_CODITE LIMIT 1) AS CODAGR, ';

      {Combo}
      strSQL := strSQL + ' (SELECT ';
      strSQL := strSQL + '   IF(COUNT(*) > 0, "S", "N") ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + '   COMVEN C ';
      strSQL := strSQL + '   INNER JOIN COMEMP E ON E.COM_SEQGER = C.AUTOINCREM ';
      strSQL := strSQL + '   INNER JOIN PROATI A ON A.ATI_SEQGER = C.AUTOINCREM ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   CURRENT_DATE BETWEEN C.COM_DTAINI AND C.COM_DTAFIN AND E.COM_CODEMP = G.ITE_CODEMP AND A.ATI_CODITE = I.ITE_CODITE) AS COMBO, ';

      strSQL := strSQL + '  I.AUTOINCREM   ';

      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + '   CADITE I ';

      strSQL := strSQL + ' LEFT JOIN CADDEP ON DEP_CODIGO = ITE_CODDEP ';
      strSQL := strSQL + ' INNER JOIN CADUNI U ON U.UNI_CODUNI = I.ITE_CODUNI ';
      strSQL := strSQL + ' INNER JOIN CADMAR M ON I.ITE_CODMAR = M.MAR_CODMAR ';
      strSQL := strSQL + ' INNER JOIN ITEGER G ON I.ITE_CODITE = G.ITE_CODITE AND ';
      strSQL := strSQL + '                        G.ITE_CODEMP = ' + QuotedStr(IIF(blnEmpFat, strCodEmp, strEmpSaldoMatrizCD)) + ' ';

      If TDefConsulaItem(objConsulta).blnSitPro Then
        If fCfgSis('SITEMP') = '1' Then
          strSQL := strSQL + 'LEFT JOIN SITPRO ON I.ITE_SITPRO = SIT_CODIGO '
        Else
          strSQL := strSQL + 'LEFT JOIN SITPRO ON G.ITE_SITPRO = SIT_CODIGO ';

      strSQL := strSQL + ' LEFT JOIN ITEBAR ON BAR_CODITE = I.ITE_CODITE AND BAR_PRINCI = 1 ';

      strSQL := strSQL + ' LEFT JOIN CADFOR F ON I.ITE_CODFOR = F.FOR_CODFOR ';

      strSQL := strSQL + ' LEFT JOIN CADGPR ON GPR_CODIGO = ITE_CODGPR ';

      strSQL := strSQL + ' LEFT JOIN GRPPRD ON PRD_CODGRU = ITE_PRDGRU ';

      {******************************************************************}
      {* CONDIÇÃO ESPECÍFICA PARA CONSULTA DE ITENS DO PEDIDO DE COMPRA *}
      {***************************************************************JU*}
      strSQL := strSQl + '  LEFT JOIN GRU_COMPRA ON ITE_GRUCMP = GRU_CODIGO ';
      strSQL := strSQl + '  LEFT JOIN CADOPE CMP ON CMP.OPE_CODOPE = GRU_OPERES ';


      If blnExibeColunaSaldoCD Then
      Begin
        strSQL := strSQL + '  LEFT JOIN ITEGER CD ON I.ITE_CODITE = CD.ITE_CODITE AND ';
        strSQL := strSQL + '                        CD.ITE_CODEMP = ' + QuotedStr(strEmp_CD) + ' ';
      End;

      If opcTipIte = conIteSemelhantes Then
      Begin
        strSQL := strSQL + ' LEFT JOIN CADSEM S ON ';
        strSQL := strSQL + '   SEM_CODITE = I.ITE_CODITE  AND ';
        strSQL := strSQL + '   SEM_CODSEM = ' + QuotedStr(strCodFab);
      End;


      Result := strSQL;
    End;

    Function fSQLWhere: String;
      Var
        strWhere: String;
    Begin
      strWhere := '';

      If blnPedCom Then
      Begin
        strWhere := strWhere + 'WHERE ';

        strWhere := strWhere + '  ITE_ATICOM = "S"  ';

        If Not fCfgSis('MOSITE', varBoolean) Then
          strWhere := strWhere + ' AND ITE_ITEATI = "S" ';

        If Not fEmptyStr(strCodCmp) Then
          strWhere := strWhere + '  AND IF(IFNULL(GRU_OPERES, "") = "", TRUE, GRU_OPERES = "' + strCodCmp +'") ';

        If (Not fCfgSis('EXILIS', varBoolean)) And blnConsiderarExiLis Then
        Begin
          strWhere := strWhere + ' AND G.ITE_IMPLIS = "S" ';
        End;

      End
      Else
      Begin
        strWhere := strWhere + 'WHERE TRUE';

        If intOpcAtivos = -1 Then
        Begin
          If Not fCfgSis('MOSITE', varBoolean) Then
            strWhere := strWhere + ' AND ITE_ITEATI = "S" ';
        End Else
        Begin
          If (intOpcAtivos in [0,1]) then
           strWhere := strWhere + '  AND I.ITE_ITEATI = "S" '
          Else If (intOpcAtivos = 2) then
           strWhere := strWhere + '  AND IFNULL(ITE_ITEATI, "N") = "N" ';
        End;

        (*
        If blnFaturamento And {complerekey}
          ((Not fEmptyStr(strDescri)) Or
           (Not fEmptyStr(strCodBar)) Or
           (Not fEmptyStr(strCodFab))) Then
          strWhere := strWhere + ' AND FALSE ';
        *)
      End;

      If opcTipIte = conIteSimilar Then
        strWhere := strWhere + '  AND ITE_CODSIM IS NOT NULL ';


      {Req: 108347
      If opcTipIte = conIteAgregados Then
        strWhere := strWhere + '  AND ITE_CODAGR IS NOT NULL ';

       Foi alterado o campo "ITE_CODAGR" para o subselect na "CADAGR", pois no cadastro
       dos agregados desde muito tempo não se grava esse campo!}
      If opcTipIte = conIteAgregados Then
        strWhere := strWhere + '  AND (SELECT COUNT(*) FROM CADAGR WHERE AGR_CODITE = I.ITE_CODITE LIMIT 1) > 0 ';

      If (fCfgSis('USASER', varBoolean)) And (Not blnMostrarItensDeServico) Then
      Begin
        strWhere := strWhere + '  AND I.ITE_CODITE <> ' + QuotedStr(fCfgSis('ITESER')) + ' ';
        strWhere := strWhere + '  AND I.ITE_CODITE <> ' + QuotedStr(fCfgSis('SERTER')) + ' ';
      End;

      If (Not fCfgSis('EXILIS', varBoolean)) And blnConsiderarExiLis Then
      Begin
        If (Not blnEmpFat) Then
          strWhere := strWhere + '  AND G.ITE_IMPLIS = "S" '
        Else
          strWhere := strWhere + '  AND EXISTS (SELECT IL.ITE_CODITE FROM ITEGER IL WHERE I.ITE_CODITE = IL.ITE_CODITE AND IL.ITE_IMPLIS = "S") '
      End;


      If (fCfgSis('EXIACA', varBoolean)) And (blnVeioF11) Then
        strWhere := strWhere + '  AND COALESCE(CADDEP.DEP_PROACA, "N") = "S" ';

      If blnSomenteAgrotoxico Then
        strWhere := strWhere + '  AND ITE_AGROTO = "S" ';

      If opcTipIte = conNovosItens Then
        strWhere := strWhere + ' AND DATE_SUB(' + fCurrentDate + ', INTERVAL ' + IntToStr(fCfgSis('QTDNIT', varInteger)) + ' DAY) < I.ITE_DTACAD ';

      If blnConEquEnt Then
        strWhere := strWhere + ' AND I.ITE_CODITE = ' + QuotedStr(fCfgSis('ITECON', VarString));

      If opcTipIte = conIteSemelhantes Then
      Begin
        If Not fEmptyStr(strCodFab) Then
          strWhere := strWhere + ' AND (I.ITE_CODFAB = ' + QuotedStr(strCodFab) + ' OR S.SEM_CODSEM = ' + QuotedStr(strCodFab) + ') AND ';

        strWhere := strWhere + ' ((I.ITE_CODITE = S.SEM_CODITE) ';

        If Not fEmptyStr(strCodFab) Then
          strWhere := strWhere + ' OR (I.ITE_CODFAB = ' + QuotedStr(strCodFab) + ') ';

        strWhere := strWhere + ' ) ';
      End;

      If (blnSomenteEstrutura) Then
        strWhere := strWhere + ' AND IFNULL(GM.AUTOINCREM, "") <> "" ';

      strWhere := strWhere + strAplica;

      Result := strWhere;
    End;

begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    chrKey := #0;

    Try
      pIniciaPesqItem(frmModulo.GetCurrentConnection, untFuncoesSimples.strLoginUsuarioLogado, untFuncoesSimples.VS_strCodEmp,
                      untFuncoesSimples.VS_objTraceViewer, DebugHook,
                      untFuncoesSimples.VS_Date, untFuncoesSimples.VS_ComputerNetName, untFuncoesSimples.VS_UserFromWindows,
                      untFuncoesSimples.VS_IPAddressAsString, untFuncoesSimples.VS_MacAddress);

      blnExibirEmCampanha := (Not fEmptyStr(strCodCli));

      blnUsaQtdPen := fUsaQtdPendenteEntregaFutura;

      If (blnUsaQtdPen) And (blnFaturamento) And (Not (fCfgSis('CNFTEF', varBoolean))) Then
        blnUsaQtdPen := False;

      blnExcosa    := fCfgSis('EXCOSA', varBoolean) And blnMostraSaldo;
      blnItePDO    := fCfgSis('ITEPDO', VarBoolean);
      blnOrcPen    := fCfgSis('ORCPEN', VarBoolean);

      If fEmptyStr(strCodEmp) Then
        strCodEmp := VS_strCodEmp;

      If fEmptyStr(strEmpSaldoMatrizCD) Then
        strEmpSaldoMatrizCD := VS_strCodEmp;

      If fEmptyStr(strTabPre) Then
        strTabPre := '1';

      strTabCli := fCampoTabela('CLI_TABPRE', 'CADCLI', ['CLI_CODCLI'], [strCodCli]);
      If fEmptyStr(strTabCli) Then
        strTabCli := strTabPre;

      SetLength(arrTitCol, 0);

      pDefineConsulta;

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If Assigned(objFrmPnl) Then
        objFrmPnl.blnExibirSaldos := blnMostraSaldo;

      strSQL := fSQLItens;
      If opcTipIte = conIteAgregados then
        arrOrdena := ['ITE_CODAGR', 'ITE_DESITE']
      Else If blnItePDO Then
        arrOrdena := ['ITE_DESITE', 'MAR_DESMAR', 'ITEAPLICA',
                      'ITE_REFERE', 'ITE_CODFAB', 'ITE_CODITE',
                      'COMSALDO'  , 'EMPROMOC', 'ITE_PDOR']
      Else
        arrOrdena := ['ITE_DESITE', 'MAR_DESMAR', 'ITEAPLICA',
                      'ITE_REFERE', 'ITE_CODFAB', 'ITE_CODITE',
                      'COMSALDO'  , 'EMPROMOC'];

      If untFuncoesGen.fConsulta([strSQL, fSQLWhere + strFiltros],
                   arrTitCol,
                   ['ITE_DESITE', 'MAR_DESMAR', 'ITEAPLICA',
                    'ITE_REFERE', 'ITE_CODFAB', 'ITE_CODITE',
                    'COMSALDO'  , 'EMPROMOC', 'ITE_PDOR'],
                   '',
                   'CADITE',
                   Self.Name,
                   strTitulo,
                   qryConsulta,
                   objFrmPnl,
                   blnConSim,
                   arrSel,
                   fRetCodPes,
                   objConsulta,
                   blnTablet,
                   True,
                   '',
                   Nil,
                   True,
                   blnConfirma,
                   True,
                   Nil,
                   objPnlBanner,
                   objPnlPreFiltro) Then
      Begin
          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName(fRetCodPes).AsString
            Else
              edtCodigo.Text := qryConsulta.FieldByName(fRetCodPes).AsString;
          End;

          If Assigned(edtDesIte) Then
            edtDesIte.Text := qryConsulta.FieldByName('ITE_DESITE').AsString;

          If (Length(arrSel) > 1) Then
          Begin

            If Assigned(edtCodigo) then
            Begin
              If (edtCodigo Is TMaskEditFocus) Then
                (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 5)
              Else
                edtCodigo.Text := fStrZero('0', 5);
            End;

            If Assigned(edtDesIte) Then
              edtDesIte.Text := '+1';

          End;

        Result := True;

        If Not Assigned(qryTabela) Then
          FreeAndNil(qryConsulta);
      End;

      FreeAndNil(objConsulta);
      fDropTable(VS_MemoryTableEntFut);

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;

  End;
end;

Procedure pIniciaPesqItem(Conexao: TUniConnection;
                          strUsuario,
                          strEmpresa: String;
                          objTraceViewer: ITraceViewer;
                          intDebugH: Byte;
                          dtaDate: TDate;
                          strComputerNetName,
                          strUserFromWindows,
                          strIPAddressAsString,
                          strMacAddress: String);
Begin
  pIniciaDllFuncoes(Conexao, strUsuario, strEmpresa, intDebugH, TCfgSis.Create(), objTraceViewer,
                    dtaDate, strComputerNetName, strUserFromWindows, strIPAddressAsString, strMacAddress);
End;

end.
