unit untPesqItem;

interface

uses
  Uni, SysUtils, Forms, StdCtrls, EditFocus, MaskEditFocus, untTypesSistema,
  untClassPanelCx, untFuncoesSimples, Variants, UniClientDataSet, DB, Dialogs,
  StrUtils, DBEditFocus, ExtCtrls, cxStyles, Graphics, cxCustomData, System.Generics.Collections,
  Controls, Classes, untSaldoPedidoCompra, Winapi.Windows,
  cxGridCustomTableView, cxGridDBTableView,untFuncoesGenerica,
  untConstantes, MaskUtils, untLegendasItem, System.Math,
  untConsultaFiltrosCtaReceber, untConsultasTinta, Produto.TSQLProdutos;

Type

  TDefConsultaItem = class(TDefConsulta)
  private

    cdsLegendas: TLegendasItem;
  public

    blnPanIte,
    blnSitPro: Boolean;

    intPriCPr: Integer;

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

{ TDefConsultaItem }

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
                   strCodVen: String = '';
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
                   strEspOrc: String = '';
                   strCodAbf: String = '';
                   strComponenteA: String = '';
                   strComponenteB: String = '';
                   strOpcDoc : String = '';
                   strExiAca: String = ''; // S ou N, caso em branco mantem o funcionamento antigo (blnVeioF11) Or (blnFaturamento))
                   blnSomenteProdutosLocEqu: Boolean = False;
                   blnSomenteAcessorioLocEqu: Boolean = False;
                   blnImpLis: Boolean = True;
                   blnRecVndBsTrc: Boolean = False;
                   blnUsaSer: Boolean = False;
                   strItensEntradaMercadoriaDev: String = '';
                   strCodAmz: String = ''): Boolean;

implementation

uses
  untFuncoesGen, untModulo, untCadPro, untCadNegBussiness,
  untConfiguraSQLConsultaEdicao,
  untLoadConsultaSQL;

constructor TDefConsultaItem.Create;
begin
  Inherited Create;
  blnColorirGrid := False;

  blnSitPro   := fCfgSis('SITPRO', varBoolean);
  intPriCPr   := fCfgSis('PRICPR', varInteger);
  cdsLegendas := TLegendasItem.Create(Nil);

  blnPanIte := fCfgSis('PANITE', VarBoolean);

  If blnPanIte Then
  Begin
    recTeclaAtalhoParaLimparPesquisa.blnUsaTeclaAtalho := True;
    recTeclaAtalhoParaLimparPesquisa.strTexto := '[ F4 ] - Limpar filtros de pesquisa';
    recTeclaAtalhoParaLimparPesquisa.Key := VK_F4;
  End;
end;

destructor TDefConsultaItem.Destroy;
begin
  FreeAndNil(cdsLegendas);
  Inherited Destroy;
end;

procedure TDefConsultaItem.pParametriza(qryConsulta: TUniQuery);
Begin
  If Assigned(sltItems) And (qryConsulta.Params.FindParam('LISTA') <> Nil) Then
    qryConsulta.ParamByName('LISTA').AsString := sltItems.CommaText;
End;

function TDefConsultaItem.fGetCellStyle(AView: TcxGridDBTableView;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; ADataSet: TDataSet): TcxStyle;
  Var
    ARowInfo: TcxRowInfo;
    intColumnCount : Integer;
    intItemCount,
    intFieldCount: Integer;
    blnDataSetAtivo: Boolean;

  procedure pArmazenarInformacoesErroColuna(const strCampo: String; const E: Exception);
    Var
      strError: String;
      strReport: String;
  begin
    Try
      strError := 'Error on fGetCellStyle(' + strCampo + ')';
      strReport := strError + sLineBreak + sLineBreak;
      strReport := strReport + 'Exception...............: ' + E.ClassName + sLineBreak;
      strReport := strReport + 'Message.................: ' + E.Message + sLineBreak;
      strReport := strReport + 'AView.ColumnCount.......: ' + IntToStr(intColumnCount) + sLineBreak;
      strReport := strReport + 'DataController.ItemCount: ' + IntToStr(intItemCount) + sLineBreak;
      strReport := strReport + 'ADataSet.FieldCount.....: ' + IntToStr(intFieldCount) + sLineBreak;
      strReport := strReport + 'ADataSet.Active.........: ' + BoolToStr(blnDataSetAtivo, True);
      pGravaLogErrArquivoLocal(strError, strReport, 'untPesqItem_fIdxColumn');
    Except
      // Perder o log e aceitável. Perder o Raise não.
    End;
  end;

  function fIdxColumn(const strCampo: String): Integer;
    Var
      cxcColuna: TcxGridDBColumn;
  begin
    Result := -1;

    {********************************************************}
    {* ESSA FUNÇAO TEVE DE ALTERAR O COMPONENTE DEV-EXPRESS *}
    {* SE ESTA OCORRENDO ERRO DE TYPECAST VC DEVE VERIFICAR *}
    {* NOS COMPONENTES SE A CORREÇÃO FOI APLICADA EM SUA    *}
    {* MÁQUINA                                              *}
    {*****************************************************AF*}
    If (ADataSet.FindField(strCampo) <> nil) Then
    Begin
      intColumnCount := AView.ColumnCount;
      intItemCount := AView.DataController.ItemCount;
      intFieldCount := ADataSet.FieldCount;
      blnDataSetAtivo := ADataSet.Active;
      Try
        cxcColuna := AView.GetColumnByFieldName(strCampo);

        If Assigned(cxcColuna) Then
          Result := cxcColuna.Index;
      Except
        On E: Exception Do
        Begin
          pArmazenarInformacoesErroColuna(strCampo, E);
          Raise;
        End;
      End;
    End;
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

    Result := inherited fGetCellStyle(AView, ARecord, AItem, ADataSet);

    If Not Assigned(Result) Then
    Begin
      If IfNull(fGetValor(fIdxColumn('ITEITEATI')), '') = 'INATIVO' Then
        Result := cdsLegendas.fRetStyle(ARRDESC_SITUACAO_ITEM[sitInativo])

      Else If IfNull(fGetValor(fIdxColumn('ITEATICOM')), '') <> 'SIM' Then
        Result := cdsLegendas.fRetStyle(ARRDESC_SITUACAO_ITEM[sitInativoCompra])

      Else If IfNull(fGetValor(fIdxColumn('ESTRUT')), 0) > 0 Then
        Result := cdsLegendas.fRetStyle(ARRDESC_SITUACAO_ITEM[sitEstrutura])

      Else If IfNull(fGetValor(fIdxColumn('BOCACAIXA')), '') = 'SIM' Then
        Result := cdsLegendas.fRetStyle(ARRDESC_SITUACAO_ITEM[sitBocaCaixa])

      Else If IfNull(fGetValor(fIdxColumn('AGR_CODAGR')), '') <> '' Then
        Result := cdsLegendas.fRetStyle(ARRDESC_SITUACAO_ITEM[sitAgregado])

      Else If (intPriCPr = 1) Then
      begin
        If (IfNull(fGetValor(fIdxColumn('EMPROMOC')), '') = 'SIM') Or
                (IfNull(fGetValor(fIdxColumn('IPR_PROMOC')), 0) > 0)    Then
          Result := cdsLegendas.fRetStyle(ARRDESC_SITUACAO_ITEM[sitPromocao])

        Else If IfNull(fGetValor(fIdxColumn('COMBO')), '') = 'S' Then
          Result := cdsLegendas.fRetStyle(ARRDESC_SITUACAO_ITEM[sitCombo])

        Else If blnSitPro And (IfNull(fGetValor(fIdxColumn('SIT_DESCRI')), '') <> '') Then
          Result := cdsLegendas.fRetStyle(fGetValor(fIdxColumn('SIT_DESCRI')));
      end
      else
      begin
        If blnSitPro And (IfNull(fGetValor(fIdxColumn('SIT_DESCRI')), '') <> '') Then
          Result := cdsLegendas.fRetStyle(fGetValor(fIdxColumn('SIT_DESCRI')))

        Else If (IfNull(fGetValor(fIdxColumn('EMPROMOC')), '') = 'SIM') Or
                (IfNull(fGetValor(fIdxColumn('IPR_PROMOC')), 0) > 0)    Then
          Result := cdsLegendas.fRetStyle(ARRDESC_SITUACAO_ITEM[sitPromocao])

        Else If IfNull(fGetValor(fIdxColumn('COMBO')), '') = 'S' Then
          Result := cdsLegendas.fRetStyle(ARRDESC_SITUACAO_ITEM[sitCombo])
      end;
    End;

  End;

end;

function fSubSelPrecoPromocao(strCodCnd, strCndPag, strTabPre, strCodCli, strNumOrc, strEspOrc: String): String;
  Var
   intPraMedio  : Integer;
   objItemPromo : TItemPromo;
begin
  If strCndPag <> '' Then
    intPraMedio := fFloatToInt(fCalcMediaPagto(strCndPag))
  Else
    intPraMedio := 0;

  objItemPromo := TItemPromo.Create;
  objItemPromo.strAndWhereCodEmp := ' G.ITE_CODEMP ';
  objItemPromo.strAndWhereCodIte := ' G.ITE_CODITE ';
  objItemPromo.strCodCli         := strCodCli;
  objItemPromo.strTabPre         := strTabPre;
  objItemPromo.strCodCnd         := strCodCnd;
  objItemPromo.strNumOrc         := strNumOrc;
  objItemPromo.strEspOrc         := strEspOrc;
  If fCfgSis('PRZPRO', varBoolean) Then
    objItemPromo.intPraMedio := intPraMedio;

  objItemPromo.strSelect := fRetSQLPrecoVendaPromo(strTabPre, 'G.', strCodCnd, True);
  Result := ' IFNULL(('+objItemPromo.fRetSubQryPromo+'), '+fGetSQLConsultaItensPrecoEstruturaPromo('G', strTabPre, strCodCli, IntToStr(intPraMedio))+') ';;

  FreeAndNil(objItemPromo);
end;

function fSubSelQtdPromocao(strCodCnd, strCndPag, strTabPre, strCodCli, strNumOrc, strEspOrc: String): String;
  Var
   intPraMedio  : Integer;
   objItemPromo : TItemPromo;
begin
  If strCndPag <> '' Then
    intPraMedio := fFloatToInt(fCalcMediaPagto(strCndPag))
  Else
    intPraMedio := 0;

  objItemPromo := TItemPromo.Create;
  objItemPromo.strAndWhereCodEmp := ' G.ITE_CODEMP ';
  objItemPromo.strAndWhereCodIte := ' G.ITE_CODITE ';
  objItemPromo.strCodCli         := strCodCli;
  objItemPromo.strTabPre         := strTabPre;
  objItemPromo.strCodCnd         := strCodCnd;
  objItemPromo.strNumOrc         := strNumOrc;
  objItemPromo.strEspOrc         := strEspOrc;

  If fCfgSis('PRZPRO', varBoolean) Then
    objItemPromo.intPraMedio := intPraMedio;

  objItemPromo.strSelect := ' ITEPRO.IPR_QTDLIM ';
  Result := ' ('+objItemPromo.fRetSubQryPromo+') ';

  FreeAndNil(objItemPromo);
end;

function fRetSQLOrcamentoPendente: String;
begin
  Result := '(SELECT COUNT(AUTOINCREM) AS ORCPEN ';
  Result := Result + 'FROM FATDOR ';
  Result := Result + 'WHERE FDO_ESPDOC = "OR" ';
  Result := Result + ' AND FDO_JAFATU = 0 ';
  Result := Result + ' AND FDO_CODITE = G.ITE_CODITE ';
  Result := Result + ' AND FDO_CODEMP = G.ITE_CODEMP) ';
end;

function fRetSQLModeloVeiculo: string;
Begin
  Result := Result + ' (SELECT GROUP_CONCAT(DISTINCT MOD_DESMOD) FROM VEIPRO ';
  Result := Result + '   LEFT JOIN DETMOD ON DETMOD.AUTOINCREM = VEI_CODMOD ';
  Result := Result + '   LEFT JOIN MODVEI ON MODVEI.MOD_CODMOD = DETMOD.MOD_CODMOD ';
  Result := Result + '  WHERE VEI_CODITE = I.ITE_CODITE) ';
End;

function fRetSQLMarcaVeiculo: string;
Begin
  Result := Result + ' (SELECT GROUP_CONCAT(DISTINCT MAR_DESMAR) ';
  Result := Result + '    FROM VEIPRO ';
  Result := Result + '    LEFT JOIN DETMOD ON DETMOD.AUTOINCREM = VEI_CODMOD ';
  Result := Result + '    LEFT JOIN MODVEI ON MODVEI.MOD_CODMOD = DETMOD.MOD_CODMOD ';
  Result := Result + '    LEFT JOIN MARVEI ON MARVEI.MAR_CODMAR = MODVEI.MOD_CODMAR ';
  Result := Result + '   WHERE VEI_CODITE = I.ITE_CODITE) ';
End;

function fSubSelPROMOC(strCodCnd, strCndPag, strTabPre, strCodCli, strNumOrc, strEspOrc: String): String;
  Var
   intPraMedio  : Integer;
   objItemPromo : TItemPromo;
begin
  If strCndPag <> '' Then
    intPraMedio := fFloatToInt(fCalcMediaPagto(strCndPag))
  Else
    intPraMedio := 0;

  objItemPromo := TItemPromo.Create;
  objItemPromo.strAndWhereCodEmp := ' G.ITE_CODEMP ';
  objItemPromo.strAndWhereCodIte := ' G.ITE_CODITE ';
  objItemPromo.strCodCli         := strCodCli;
  objItemPromo.strTabPre         := strTabPre;
  objItemPromo.strCodCnd         := strCodCnd;
  objItemPromo.strNumOrc         := strNumOrc;
  objItemPromo.strEspOrc         := strEspOrc;
  objItemPromo.blnUsaLimit := False;
  If fCfgSis('PRZPRO', varBoolean) Then
    objItemPromo.intPraMedio := intPraMedio;

  objItemPromo.strSelect := ' IF(COUNT(*) > 0, 1, NULL) ';
  Result := ' IF(IFNULL(('+objItemPromo.fRetSubQryPromo+'), '+fGetSQLConsultaItensPrecoEstruturaPromo('G', strTabPre, strCodCli, IntToStr(intPraMedio))+') > 0, "SIM", "NÃO") ';

  FreeAndNil(objItemPromo);
end;

procedure pValidaCfgITEVEN(Var strSQL: String; strCodVen, strCodCli, strOpcDoc: String);
  Var
    strCampo: String;
begin
  If (fExibirApenasItensDoVendedorVinculadoAoCliente(strCodVen, strCodCli, strOpcDoc)) Then
  Begin
    strCampo := fCampoCfgMLTOP2;

    strSQL := strSQL + ' INNER JOIN CLIVEN ON                             '+
                       '   I.ITE_'+ strCampo + ' = CLIVEN.CVE_'+ strCampo  +
                       '   AND CLIVEN.CVE_CODVEN = ' + QuotedStr(strCodVen)+
                       '   AND CLIVEN.CVE_CODCLI = ' + QuotedStr(strCodCli);
  End;
end;

function fSubSelComissaoPromocao(strCampoComissao, strCodCnd, strCndPag, strTabPre, strCodCli, strNumOrc, strEspOrc: String): String;
  Var
   intPraMedio  : Integer;
   objItemPromo : TItemPromo;
begin
  If strCndPag <> '' Then
    intPraMedio := fFloatToInt(fCalcMediaPagto(strCndPag))
  Else
    intPraMedio := 0;

  objItemPromo := TItemPromo.Create;
  objItemPromo.strAndWhereCodEmp := ' G.ITE_CODEMP ';
  objItemPromo.strAndWhereCodIte := ' G.ITE_CODITE ';
  objItemPromo.strCodCli         := strCodCli;
  objItemPromo.strTabPre         := strTabPre;
  objItemPromo.strCodCnd         := strCodCnd;
  objItemPromo.strNumOrc         := strNumOrc;
  objItemPromo.strEspOrc         := strEspOrc;
  If fCfgSis('PRZPRO', varBoolean) Then
    objItemPromo.intPraMedio := intPraMedio;

  objItemPromo.strSelect := ' ITEPRO.IPR_' + strCampoComissao + ' ';

  result := 'IF(' + fSubSelPROMOC(strCodCnd, strCndPag, strTabPre, strCodCli, strNumOrc, strEspOrc) + ' = "SIM", ' +
                ' ('+objItemPromo.fRetSubQryPromo+'), ' +
               'G.ITE_' + strCampoComissao + ')';

  FreeAndNil(objItemPromo);
end;

function fSubSelPrecoBocaCaixa: String;
var
  strSubSQL: String;
begin
  strSubSQL := '';
  strSubSQL := strSubSQL + ' (SELECT ';
  strSubSQL := strSubSQL + '  BCA_PREMIN ';
  strSubSQL := strSubSQL + 'FROM ';
  strSubSQL := strSubSQL + '  CADBCA ';
  strSubSQL := strSubSQL + 'WHERE ';
  strSubSQL := strSubSQL + '  BCA_CODEMP = G.ITE_CODEMP AND ';
  strSubSQL := strSubSQL + '  BCA_CODITE = G.ITE_CODITE LIMIT 1) ';

  Result := strSubSQL;
end;

function fSubSelComissaoBocaCaixa: String;
var
  strSubSQL : String;
begin
  strSubSQL := '';
  strSubSQL := strSubSQL + ' (SELECT ';
  strSubSQL := strSubSQL + '  BCA_COMVAR ';
  strSubSQL := strSubSQL + 'FROM ';
  strSubSQL := strSubSQL + '  CADBCA ';
  strSubSQL := strSubSQL + 'WHERE ';
  strSubSQL := strSubSQL + '  BCA_CODEMP = G.ITE_CODEMP AND ';
  strSubSQL := strSubSQL + '  BCA_CODITE = G.ITE_CODITE LIMIT 1) ';

  Result := strSubSQL;
end;

function fSubSelBOCACAIXA: String;
var
  strSubSQL: String;
begin
  strSubSQL := '';
  strSubSQL := strSubSQL + ' IF((SELECT ';
  strSubSQL := strSubSQL + '  COUNT(*) AS QTDE ';
  strSubSQL := strSubSQL + 'FROM ';
  strSubSQL := strSubSQL + '  CADBCA ';
  strSubSQL := strSubSQL + 'WHERE ';
  strSubSQL := strSubSQL + '  BCA_CODEMP = G.ITE_CODEMP AND ';
  strSubSQL := strSubSQL + '  BCA_CODITE = G.ITE_CODITE LIMIT 1) > 0, "SIM", "NÃO") ';

  Result := strSubSQL;
end;

function fSubSelCampanha(strCodCli: String): String;
begin
  Result := '';
  Result := Result + '  IF(                                                                                                                                ';
  Result := Result + '    (                                                                                                                                ';
  Result := Result + '      SELECT                                                                                                                         ';
  Result := Result + '        CD.CMD_CODITE                                                                                                                ';
  Result := Result + '      FROM                                                                                                                           ';
  Result := Result + '        (                                                                                                                            ';
  Result := Result + '          SELECT                                                                                                                     ';
  Result := Result + '            DISTINCT CG.CMG_CODCMG                                                                                                   ';
  Result := Result + '          FROM                                                                                                                       ';
  Result := Result + '            (                                                                                                                        ';
  Result := Result + '              SELECT * FROM CAMGER CG LEFT JOIN CAMCLI CC ON (CG.AUTOINCREM = CC.CCM_CODGER) WHERE CC.CCM_CODGER IS NULL             ';
  Result := Result + '              UNION                                                                                                                  ';
  Result := Result + '              SELECT * FROM CAMGER CG INNER JOIN CAMCLI CC ON (CG.AUTOINCREM = CC.CCM_CODGER) WHERE CC.CCM_CODCLI = "'+strCodCli+'"  ';
  Result := Result + '            ) CG                                                                                                                     ';
  Result := Result + '          WHERE                                                                                                                      ';
  Result := Result + '            CURRENT_DATE >= CG.CMG_DTAINI AND                                                                                        ';
  Result := Result + '            CURRENT_DATE <= CG.CMG_DTAFIN                                                                                            ';
  Result := Result + '        ) CG                                                                                                                         ';
  Result := Result + '      INNER JOIN                                                                                                                     ';
  Result := Result + '        CAMDET CD ON (CD.CMD_SEQCMG = CG.CMG_CODCMG)                                                                                 ';
  Result := Result + '      WHERE CD.CMD_CODITE = G.ITE_CODITE GROUP BY CD.CMD_CODITE                                                                      ';
  Result := Result + '    ) IS NULL, "NÃO", "SIM"                                                                                                          ';
  Result := Result + '  )                                                                                                                                  ';
end;


function fSubCodProdCli(strCodCli: String): String;
{RETORNA O CAMPO CODIGO INTERNO DE PRODUTO DO CLIENTE - POR CAMPANHA ATIVA - KM}
begin
  Result := '';
  Result := Result + '  (SELECT                                                                                                                        ';
  Result := Result + '    CD.CMD_CODPCL                                                                                                                ';
  Result := Result + '  FROM                                                                                                                           ';
  Result := Result + '    (                                                                                                                            ';
  Result := Result + '      SELECT                                                                                                                     ';
  Result := Result + '        DISTINCT CG.CMG_CODCMG                                                                                                   ';
  Result := Result + '      FROM                                                                                                                       ';
  Result := Result + '        (                                                                                                                        ';
  Result := Result + '          SELECT * FROM CAMGER CG LEFT JOIN CAMCLI CC ON (CG.AUTOINCREM = CC.CCM_CODGER) WHERE CC.CCM_CODGER IS NULL             ';
  Result := Result + '          UNION                                                                                                                  ';
  Result := Result + '          SELECT * FROM CAMGER CG INNER JOIN CAMCLI CC ON (CG.AUTOINCREM = CC.CCM_CODGER) WHERE CC.CCM_CODCLI = "'+strCodCli+'"  ';
  Result := Result + '        ) CG                                                                                                                     ';
  Result := Result + '      WHERE                                                                                                                      ';
  Result := Result + '        CURRENT_DATE >= CG.CMG_DTAINI AND                                                                                        ';
  Result := Result + '        CURRENT_DATE <= CG.CMG_DTAFIN                                                                                            ';
  Result := Result + '    ) CG                                                                                                                         ';
  Result := Result + '  INNER JOIN                                                                                                                     ';
  Result := Result + '    CAMDET CD ON (CD.CMD_SEQCMG = CG.CMG_CODCMG)                                                                                 ';
  Result := Result + '  WHERE CD.CMD_CODITE = G.ITE_CODITE LIMIT 1)                                                                                            ';
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
  strSubSQL := strSubSQL + ' GERMAT GMT ';

  strSubSQL := strSubSQL + 'WHERE ';
  strSubSQL := strSubSQL + '  I.ITE_CODITE = GMT.GMT_CODITE ) ';

  Result := strSubSQL;
end;

Function fTipoConsultaToInt(opcTipIte: TTipoConsultaItem): Integer;
Begin
  Case opcTipIte Of
   conIteCompleta   : Result := 2;
   conNovosItens    : Result := 3;
   conIteSemelhantes: Result := 4;
   conIteSimilar    : Result := 5;
   conIteAgregados  : Result := 6;
   Else               Result := 1;
  End;
End;

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
                   strCodVen: String = '';
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
                   strEspOrc: String = '';
                   strCodAbf: String = '';
                   strComponenteA: String = '';
                   strComponenteB: String = '';
                   strOpcDoc : String = '';
                   strExiAca: String = ''; // S ou N, caso em branco mantem o funcionamento antigo (blnVeioF11) Or (blnFaturamento))
                   blnSomenteProdutosLocEqu: Boolean = False;
                   blnSomenteAcessorioLocEqu: Boolean = False;
                   blnImpLis: Boolean = True;
                   blnRecVndBsTrc: Boolean = False;
                   blnUsaSer: Boolean = False;
                   strItensEntradaMercadoriaDev: String = '';
                   strCodAmz: String = ''
                   ): Boolean;
  Var
    strSQLPar,
    strCpoPesqDesc,
    strSQL     : String;
    qryConsulta: TUniQuery;
    objConsulta: TDefConsulta;

    objDefConsulta: TDefConsulta;

    fltDolar : Double;

    arrTitCol: TColunasArray;                                 {* Títulos das Colunas                         *}


    strPDCPRO: String;

    blnExiPrecos,
    blnExcosa,
    blnEstExt,
    blnItePDO,
    blnConsultou,
    blnUsaQtdPen,
    blnOrcPen: Boolean;
    strTabCli: String;
    intDecUni: Integer;
    intDecQtd: Integer;
    blnExibirInfPromoc : Boolean;
    blnExibirEmCampanha: Boolean;
    blnAcessoTodasAsEmpresas: Boolean;
    blnExibirCodProCliente,
    blnViewDiasSemVenda: Boolean;
    blnTemNegocAtiva,
    blnBEFTRG: Boolean;
    ProcAtualizaPrecoNegociacao: TGenericProcedureWithClientParam;
    objSQLProdutos: TSQLProdutos;
    strSalFis: String;
    objLoadSql: TLoadConsultaSQL;

    Procedure pAddNomeColuna(strNomCol: String);
    Begin
      SetLength(arrTitCol, Succ(Length(arrTitCol)));
      arrTitCol[High(arrTitCol)] := strNomCol;
    End;

    Function fSubSelMontadora: String;
    Begin
      Result := '(SELECT CAST(GROUP_CONCAT(MON_DESCRI SEPARATOR " / ") AS CHAR(120)) FROM CADMON LEFT JOIN ITEMON ON MON_CODMON = ITM_CODMON WHERE ITM_CODITE = I.ITE_CODITE)';
    End;

    function fSQLItensVendidoEmPDOR: String;
    Begin
      Result := '';
      Result := Result + ' (SELECT IF(COUNT(*) > 0, "SIM", "NÃO") FROM FATDOR WHERE FDO_CODITE = G.ITE_CODITE AND FDO_CODEMP = G.ITE_CODEMP ';
      Result := Result + IfThen(fEmptyStr(strCodCli), '', ' AND FDO_CODCLI = ' + QuotedStr(strCodCli)) + ')';
    End;

    function fGetSQLEmpSaldos: String;
    begin
      Result := '';

      Result := Result + ' (SELECT SUM(ITODAS.ITE_SALDOS) ';
      Result := Result + ' + SUM(' + fGetSQLSomaCamposEntregaFutura('ITODAS', True) + ')';

      Result := Result + '    FROM ITEGER ITODAS ';
      Result := Result + '   WHERE ITODAS.ITE_CODITE = I.ITE_CODITE ' ;
      If (Not blnAcessoTodasAsEmpresas) Then
        Result := Result + '   AND (LOCATE(ITODAS.ITE_CODEMP, ' + QuotedStr(strEmpEstUsuarioLogado) + ') > 0)  ' ;
      Result := Result + ' ) ';
    end;

    function fGetSQLEmpSaldosDis: String;
    begin
      Result := '';

      Result := Result + ' (SELECT SUM(' + fSQLSaldoDisponivel('ITODAS') + ')';
      Result := Result + '    FROM ITEGER ITODAS ';
      Result := Result + '   WHERE ITODAS.ITE_CODITE = I.ITE_CODITE ' ;
      If (Not blnAcessoTodasAsEmpresas) Then
        Result := Result + '   AND (LOCATE(ITODAS.ITE_CODEMP, ' + QuotedStr(strEmpEstUsuarioLogado) + ') > 0)  ' ;
      Result := Result + ' ) ';
    end;

    function fGetSQLSaldoCompartilhado: String;
    begin
      Result := '';
      Result := Result + ' (SELECT SUM(IFNULL(ITE_SALDOS + IF(IFNULL(ITE_CNV_ML, 0) > 0, IFNULL(ITE_SAL_ML, 0) / ITE_CNV_ML, 0), 0) ';

      Result := Result + '      + IFNULL(ITE_QTPDBF, 0) ';                            // SALDO FÍSICO PEDIDO DE BAIXA DE ENTREGA FUTURA

      Result := Result + '      - (IFNULL(ITE_QTPD_V, 0) + IFNULL(ITE_QTPD_F, 0)) ';  // PEDIDO
      Result := Result + '      - IFNULL(ITE_SALREG, 0) ';                            // GARANTIA
      Result := Result + '      - IF((ITE_SALEXT < 0) OR (ITE_SALEXT IS NULL), 0, ITE_SALEXT) '; // EXTERNO
      Result := Result + '      - IFNULL(ITE_QTPD_P, 0) ';                            // ORDEM PRODUÇÃO
      Result := Result + '      - IFNULL(ITE_QTPD_E, 0) ';                            // ENDEREÇAMENTO
      Result := Result + '      - IFNULL(ITE_SDPDBF, 0) ';                            // RESERVADO PEDIDO DE BAIXA DE ENTREGA FUTURA

      Case fCfgSis('CALSAL', varInteger) Of
        1:  Begin
              Result := Result +                            ' + IFNULL(ITE_QTEF_A, 0)';
              Result := Result +                            ' + IFNULL(ITE_QTEF_F, 0)';
              Result := Result +                            ' + IFNULL(ITE_QTEF_P, 0)';
            End;

        2:  ;

        3:  Begin
              Result := Result +                            ' + IFNULL(ITE_QTEF_F, 0)';
            End;

        4:  Begin
              Result := Result +                            ' + IFNULL(ITE_QTEF_A, 0)';
              Result := Result +                            ' + IFNULL(ITE_QTEF_P, 0)';
            End;

        5:  Begin
              Result := Result +                            ' + IFNULL(ITE_QTEF_A, 0)';
              Result := Result +                            ' + IFNULL(ITE_QTEF_F, 0)';
            End;
      End;

      Result := Result + ' ) ';
      Result := Result + ' FROM ITEGER IG ';
      Result := Result + ' WHERE IG.ITE_CODITE = I.ITE_CODITE ';
      Result := Result + '   AND IG.ITE_CODEMP IN (SELECT EPS_EMPSAI FROM CADEPS WHERE EPS_CODEMP = ' +QuotedStr(VS_StrCodEmp) + ')';
      Result := Result + ' ) ';
    end;

    function fGetSQLSaldoReservadoEmOrdemDeProducao: String;
    begin
      Result := '';
      Result := Result + '  (SELECT                                                       ';
      Result := Result + '     IFNULL(SUM(IFNULL(PRO_QTDAPR,0) - IFNULL(PRO_QTDPRO,0)),0) ';
      Result := Result + '   FROM MOVPRO                                                  ';
      Result := Result + '  WHERE PRO_CODEMP = ' + QuotedStr(VS_strCodEmp)                 ;
      Result := Result + '    AND PRO_CODITE = I.ITE_CODITE                               ';
      Result := Result + '    AND PRO_DTABAI IS NULL)                                     ';
    end;

    function fRetSQLPreVen:String;
    begin
      If fltTaxVpr > 0.00 Then
        Result := '('+ fGetSQLITE_PREVE('G', strTabPre) + ' * ( 1 + ' + AnsiReplaceStr(FloatToStr(fltTaxVpr / 100), ',', '.')  + '))'
      Else
        Result := '('+ fGetSQLITE_PREVE('G', strTabPre) +')';
    end;

    function fRetSQLPreCli: String;
    begin
      If fltTaxVpr > 0.00 Then
        Result := '('+ fGetSQLITE_PREVE('G', strTabCli) + ' * ( 1 + ' + AnsiReplaceStr(FloatToStr(fltTaxVpr / 100), ',', '.')  + '))'
      Else
        Result := '('+ fGetSQLITE_PREVE('G', strTabCli) +')';
    end;

    Procedure pDefineConsulta;
    Begin
      objConsulta := TDefConsultaItem.Create;

      objConsulta.stlCamposComplementares.Add('ITEITEATI');
      objConsulta.stlCamposComplementares.Add('ITEATICOM');
      objConsulta.stlCamposComplementares.Add('ESTRUT');
      objConsulta.stlCamposComplementares.Add('BOCACAIXA');
      objConsulta.stlCamposComplementares.Add('EMPROMOC');
      objConsulta.stlCamposComplementares.Add('IPR_PROMOC');
      objConsulta.stlCamposComplementares.Add('COMBO');
      objConsulta.stlCamposComplementares.Add('SIT_DESCRI');
      objConsulta.stlCamposComplementares.Add('AGR_CODAGR');
      objConsulta.stlCamposComplementares.Add('IMPRIMELIS');

      If fCfgSis('ITPMOD') = '2' Then
        objConsulta.strCampoBuscaPalavraExataPorToken := 'ITE_PESQUI';

      If fCfgSis('ITPMOD') = '3' Then
        objConsulta.strCampoBuscaComplementarPorToken := 'ITE_PESQUI';

      If Assigned(objFrmPnl) Then
        TDefConsultaItem(objConsulta).sltItems := objFrmPnl.sltLista;

      If blnFaturamento Then
        objConsulta.strSQLRetorno := 'SELECT CADITE.*, BAR_CODBAR, BAR_EMBALA, BAR_PREVEN, BAR_TABPRE, BAR_DESCRI, UNI_SIGUNI FROM CADITE LEFT JOIN ITEBAR ON BAR_CODITE = ITE_CODITE AND BAR_EXBFAT = "S" ' +
          ' LEFT JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI';

      If Not fEmptyStr(strDescri) Then
        objConsulta.pIncluiFiltro(strCpoPesqDesc, ReplaceStr(strDescri, '*', '%'))

      Else If Not fEmptyStr(strCodBar) Then
      Begin
        If (Not blnFaturamento) Then
          objConsulta.pIncluiFiltro('ITE_BARRAS', ReplaceStr(strCodBar, '*', '%'))
        Else
          objConsulta.pIncluiFiltro('ITE_BARRAS_FAT', ReplaceStr(strCodBar, '*', '%'));
      End
      Else If Not fEmptyStr(strCodFab) Then
      Begin
        If fCfgSis('ITPFAB', VarBoolean) And (fCfgSis('ITPMOD') = '2') Then
          objConsulta.pIncluiFiltro('ITEPESQUI', ReplaceStr(ReplaceStr(strCodFab, '*', '%'), '%%', '%'))
        Else
          objConsulta.pIncluiFiltro('ITE_FABRIC', ReplaceStr(ReplaceStr(strCodFab, '*', '%'), '%%', '%'));
      End
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

      TDefConsultaItem(objConsulta).blnColorirGrid := Assigned(objFrmPnl);
      TDefConsultaItem(objConsulta).strTabPre := strTabPre;
      TDefConsultaItem(objConsulta).strCodCli := strCodCli;

      objConsulta.blnSimilares := (fCfgSis('POSSIM', varInteger) = 2) And
                                  (fCfgSis('PANITE', varBoolean));
      blnUsaQtdPen := (Not fCfgSis('BEFTRG', VarBoolean)) Or fUsaQtdPendenteEntregaFutura;

      strSalFis := 'ITE_SALDOS + IF(IFNULL(I.ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / I.ITE_CNV_ML, 0)';
      If ((Not blnBEFTRG) Or (fUsaQtdPendenteEntregaFutura)) Then
        strSalFis := strSalFis + ' + ' + fGetSQLSomaCamposEntregaFutura('G');

      objConsulta.pIncluiSubConsulta('ITE_SALFIS', strSalFis);

      objConsulta.pIncluiSubConsulta('ITE_SALDOS2', fSQLSaldoDisponivel('G', True, False, True));
      If Not blnExcosa Then
        objConsulta.pIncluiSubConsulta('COMSALDO', 'IF(' + fSQLSaldoDisponivel('G', True) + ' > 0, "SIM", "NÃO")');

      If blnItePDO Then
        objConsulta.pIncluiSubConsulta('ITE_PDOR', fSQLItensVendidoEmPDOR);

      objConsulta.pIncluiSubConsulta('ITERECDEV', 'IF(G.ITE_RECDEV = "S", "SIM", "NÃO")');

      objConsulta.pIncluiSubConsulta('ESMIDIGGER', 'IF(G.ITE_ESMIDG = "D", "DIGITADO", "GERADO")');

      objConsulta.pIncluiSubConsulta('ITEITEATI', 'IF(I.ITE_ITEATI = "S", "ATIVO", "INATIVO")');
      objConsulta.pIncluiSubConsulta('ITEATICOM', 'IF(I.ITE_ATICOM = "S", "SIM", "NÃO")');

      If Not blnViewDiasSemVenda Then
        objConsulta.pIncluiSubConsulta('ULTVEN', 'CEIL(DATEDIFF(' + fCurrentDate + ', IFNULL(G.ITE_DTAUVE, G.ITE_DTABAL)))');
      If (blnExibirInfPromoc) Then
      Begin
        objConsulta.pIncluiSubConsulta('IPR_PREPRO', fSubSelPrecoPromocao(strCodCnd, strConPag, strTabPre, strCodCli, strNumOrc, strEspOrc));
        objConsulta.pIncluiSubConsulta('ITE_COMVAR', fSubSelComissaoPromocao('COMVAR', strCodCnd, strConPag, strTabPre, strCodCli, strNumOrc, strEspOrc));
        objConsulta.pIncluiSubConsulta('ITE_COMATA', fSubSelComissaoPromocao('COMATA', strCodCnd, strConPag, strTabPre, strCodCli, strNumOrc, strEspOrc));
        objConsulta.pIncluiSubConsulta('ITE_COMDIS', fSubSelComissaoPromocao('COMDIS', strCodCnd, strConPag, strTabPre, strCodCli, strNumOrc, strEspOrc));
      End
      Else
      Begin
        objConsulta.pIncluiSubConsulta('IPR_PREPRO', ' 0.00 ');
        objConsulta.pIncluiSubConsulta('ITE_COMVAR', 'G.ITE_COMVAR');
        objConsulta.pIncluiSubConsulta('ITE_COMATA', 'G.ITE_COMATA');
        objConsulta.pIncluiSubConsulta('ITE_COMDIS', 'G.ITE_COMDIS');
      End;

      If blnExibirEmCampanha Then
      Begin
        objConsulta.pIncluiSubConsulta('EMCAMPANHA',  fSubSelCampanha(strCodCli));
      End;

      If blnExibirCodProCliente Then
      Begin
        objConsulta.pIncluiSubConsulta('CODCPL',  fSubCodProdCli(strCodCli));
      End;

      If Not blnExibirInfPromoc Then
      Begin
        objConsulta.pIncluiSubConsulta('IPR_PROMOC', ' 0.00 ');
        objConsulta.pIncluiSubConsulta('IPR_JA_ATU', ' "S" ');
      End
      Else If blnTemNegocAtiva Then
      Begin
        objConsulta.pIncluiSubConsulta('IPR_PROMOC', ' 0.00 ');
        objConsulta.pIncluiSubConsulta('IPR_JA_ATU', ' "N" ');
      End
      Else
      Begin
        objConsulta.pIncluiSubConsulta('IPR_PROMOC', fSubSelPrecoPromocao(strCodCnd, strConPag, strTabPre, strCodCli, strNumOrc, strEspOrc));
        objConsulta.pIncluiSubConsulta('IPR_JA_ATU', ' "S" ');
      End;

      objConsulta.pIncluiSubConsulta('IPR_TABPRE', 'CAST("' + strTabPre + '" AS CHAR(1))');
      objConsulta.pIncluiSubConsulta('IPR_CODCLI', 'CAST("' + strCodCli + '" AS CHAR(8))');
      objConsulta.pIncluiSubConsulta('IPR_EMPCOD', '"' + IfThen(fEmptyStr(strCodEmp), VS_strCodEmp, strCodEmp) + '"');
      objConsulta.pIncluiSubConsulta('MSGLIV'    , 'CONCAT(IFNULL(I.ITE_MSGLV1, ""), "<<csq>>", IFNULL(I.ITE_MSGLV2, ""))');

      If (blnFaturamento) Then
        objConsulta.pIncluiSubConsulta('ITE_BARRAS_FAT', '(SELECT GROUP_CONCAT(BAR_CODBAR SEPARATOR "|") FROM ITEBAR WHERE BAR_CODITE = I.ITE_CODITE AND BAR_EXBFAT = "S")');

      If (blnExibirInfPromoc) Then
        objConsulta.pIncluiSubConsulta('QTDPROMOC', fSubSelQtdPromocao(strCodCnd, strConPag, strTabPre, strCodCli, strNumOrc, strEspOrc))
      Else
        objConsulta.pIncluiSubConsulta('QTDPROMOC', ' 0.00 ');

      objConsulta.pIncluiSubConsulta('BCA_PREMIN', fSubSelPrecoBocaCaixa);
      objConsulta.pIncluiSubConsulta('BCA_COMVAR', fSubSelComissaoBocaCaixa);

      If (blnExibirInfPromoc) Then
        objConsulta.pIncluiSubConsulta('EMPROMOC',   fSubSelPROMOC(strCodCnd, strConPag, strTabPre, strCodCli, strNumOrc, strEspOrc))
      Else
        objConsulta.pIncluiSubConsulta('EMPROMOC',   '"NÃO"');

      objConsulta.pIncluiSubConsulta('BOCACAIXA',  fSubSelBOCACAIXA);
      objConsulta.pIncluiSubConsulta('ESTRUT',     fSubSelEstrutura);

      objConsulta.pIncluiSubConsulta('ITEAPLICA', STR_APLICACAO_PADRAO, 'ITE_APLICA');

      objConsulta.pIncluiSubConsulta('CAM_LOCFIS', fSQLLocalFisica('G', True));
      objConsulta.pIncluiSubConsulta('ITE_PREVEN', fRetSQLPreVen);
      objConsulta.pFormataDecimal('ITE_PREVEN', intDecUni);
      objConsulta.pIncluiSubConsulta('ITE_PRECLI', fRetSQLPreCli);
      objConsulta.pFormataDecimal('ITE_PRECLI', intDecUni);

      //Mantido o mesmo nome do alias "ITE_FABRIC", o motivo é que se alterado o nome do alias o campo não ficava disponível na consulta.
      If (fCfgSis('FABVEN') = 'G') Then
        objConsulta.pIncluiSubConsulta('ITE_FABRIC', '(IF(LOCATE(" ", TRIM(REPLACE(I.ITE_CODFAB, "|", ""))) > 0, I.ITE_CODFAB, TRIM(REPLACE(I.ITE_CODFAB, "|", ""))))')
      Else
        objConsulta.pIncluiSubConsulta('ITE_FABRIC', '(IF(LOCATE(" ", TRIM(REPLACE(I.ITE_FABRIC, "|", ""))) > 0, I.ITE_FABRIC, TRIM(REPLACE(I.ITE_FABRIC, "|", ""))))');

      If fCfgSis('ITPMOD') = '1' Then
        objConsulta.pIncluiSubConsulta('ITEPESQUI', 'CAST(LTRIM(REPLACE(ITE_PESQUI, "<<csq>>", " ")) AS CHAR(1000))', 'ITE_PESQUI')
      Else
        objConsulta.pIncluiSubConsulta('ITEPESQUI', 'LTRIM(REPLACE(ITE_PESQUI, "<<csq>>", " "))', 'ITE_PESQUI');

      If blnOrcPen Then
        objConsulta.pIncluiSubConsulta('ORCPEN', fRetSQLOrcamentoPendente);

      objConsulta.pFormataDecimal('ITE_EMBALA', DEC_EMBALAGEM);
      objConsulta.pFormataDecimal('ITE_SALFIS', intDecQtd);
      objConsulta.pFormataDecimal('ITE_SALDOS2', intDecQtd);

      objConsulta.pIncluiConflito('ITE_CODITE', 'I.ITE_CODITE');
      objConsulta.pIncluiConflito('ITE_CODABF', 'I.ITE_CODABF');

      objConsulta.pIncluiCampoSimNao('COMSALDO');

      If blnEstExt Then
        objConsulta.pIncluiCampoSimNao('SALDOEXTERNO');

      objConsulta.pIncluiCampoSimNao('EMPROMOC');

      objConsulta.pIncluiCampoSimNao('ITEATICOM');

      If blnExibirEmCampanha Then
        objConsulta.pIncluiCampoSimNao('EMCAMPANHA');

      objConsulta.pIncluiCampoSimNao('BOCACAIXA');
      objConsulta.pIncluiCampoSimNao('ITERECDEV');

      If blnItePDO Then
        objConsulta.pIncluiCampoSimNao('ITE_PDOR');

      strSQLPar := 'CAST(IF(RIGHT(@TODLOC :=  CONCAT(@LOCFIS := IFNULL((SELECT GROUP_CONCAT(IFNULL(LOC_LOCFIS, "") SEPARATOR ",")  ' +
                   '                                                FROM LOCFIS  ' +
                   '                                               WHERE LOC_CODEMP = G.ITE_CODEMP  ' +
                   '                                                AND LOC_CODITE = G.ITE_CODITE), ""),  ' +
                   '                          IF(@LOCFIS = "", "", ","),  ' +
                   '                           IFNULL(G.ITE_LOCFIS, ""),  ' +
                   '                           IF(IFNULL(G.ITE_LOCFIS, "") = "", "", ",") ,  ' +
                   '                           IFNULL(G.ITE_LOCSUP, "")), 1) = ",", LEFT(@TODLOC, LENGTH(@TODLOC) -1), @TODLOC) AS CHAR(255)) ';
      objConsulta.pIncluiSubConsulta('LOCGER', strSQLPar);
      objConsulta.pIncluiSubConsulta('TIPOS_PRODUTO', ' CASE '+
                                                      '   WHEN G.ITE_TIPPRO = "00" THEN "Mercadoria para Revenda" '+
                                                      '   WHEN G.ITE_TIPPRO = "01" THEN "Matéria Prima" '+
                                                      '   WHEN G.ITE_TIPPRO = "02" THEN "Embalagem" '+
                                                      '   WHEN G.ITE_TIPPRO = "03" THEN "Produto em Processo" '+
                                                      '   WHEN G.ITE_TIPPRO = "04" THEN "Produto Acabado" '+
                                                      '   WHEN G.ITE_TIPPRO = "05" THEN "Subproduto" '+
                                                      '   WHEN G.ITE_TIPPRO = "06" THEN "Produto Intermediário" '+
                                                      '   WHEN G.ITE_TIPPRO = "07" THEN "Material de Uso/Consumo" '+
                                                      '   WHEN G.ITE_TIPPRO = "08" THEN "Ativo Imobilizado" '+
                                                      '   WHEN G.ITE_TIPPRO = "09" THEN "Serviços" '+
                                                      '   WHEN G.ITE_TIPPRO = "10" THEN "Outros Insumos" '+
                                                      '   WHEN G.ITE_TIPPRO = "99" THEN "Outros" '+
                                                      ' END ');
      objConsulta.pIncluiCampoSimNao('EXPSIT');
      objConsulta.pIncluiSubConsulta('EXPSIT', 'IF(ITE_EXPSIT = "S", "SIM", "NÃO")');

      objConsulta.pIncluiCampoSimNao('SOBENC');
      objConsulta.pIncluiSubConsulta('SOBENC', 'IF(G.ITE_SOBENC = "S", "SIM", "NÃO")');
    End; {Procedure pDefineConsulta;}

    Procedure pDefineConsultaConfigurada;
    Begin
      objDefConsulta := TDefConsultaItem.Create;

      objDefConsulta.stlCamposComplementares.Add('ITEITEATI');
      objDefConsulta.stlCamposComplementares.Add('ITEATICOM');
      objDefConsulta.stlCamposComplementares.Add('ESTRUT');
      objDefConsulta.stlCamposComplementares.Add('BOCACAIXA');
      objDefConsulta.stlCamposComplementares.Add('EMPROMOC');
      objDefConsulta.stlCamposComplementares.Add('IPR_PROMOC');
      objDefConsulta.stlCamposComplementares.Add('COMBO');
      objDefConsulta.stlCamposComplementares.Add('SIT_DESCRI');
      objDefConsulta.stlCamposComplementares.Add('IMPRIMELIS');

      If fCfgSis('ITPMOD') = '2' Then
        objDefConsulta.strCampoBuscaPalavraExataPorToken := 'ITE_PESQUI';

      If fCfgSis('ITPMOD') = '3' Then
        objDefConsulta.strCampoBuscaComplementarPorToken := 'ITE_PESQUI';

      If Assigned(objFrmPnl) Then
        TDefConsultaItem(objDefConsulta).sltItems := objFrmPnl.sltLista;

      If blnFaturamento Then
        objDefConsulta.strSQLRetorno := 'SELECT CADITE.*, BAR_CODBAR, BAR_EMBALA, BAR_PREVEN, BAR_TABPRE, BAR_DESCRI, UNI_SIGUNI FROM CADITE LEFT JOIN ITEBAR ON BAR_CODITE = ITE_CODITE AND BAR_EXBFAT = "S" ' +
          ' LEFT JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI';

      If Not fEmptyStr(strDescri) Then
        objDefConsulta.pIncluiFiltro(strCpoPesqDesc, ReplaceStr(strDescri, '*', '%'))

      Else If Not fEmptyStr(strCodBar) Then
      Begin
        If (Not blnFaturamento) Then
          objDefConsulta.pIncluiFiltro('ITE_BARRAS', ReplaceStr(strCodBar, '*', '%'))
        Else
          objDefConsulta.pIncluiFiltro('ITE_BARRAS_FAT', ReplaceStr(strCodBar, '*', '%'));
      End
      Else If Not fEmptyStr(strCodFab) Then
      Begin
        If fCfgSis('ITPFAB', VarBoolean) And (fCfgSis('ITPMOD') = '2') Then
          objDefConsulta.pIncluiFiltro('ITEPESQUI', ReplaceStr(ReplaceStr(strCodFab, '*', '%'), '%%', '%'))
        Else
          objDefConsulta.pIncluiFiltro('ITE_FABRIC', ReplaceStr(ReplaceStr(strCodFab, '*', '%'), '%%', '%'))
      End
      Else If Not fEmptyStr(strProdutoLocalizar) Then
      Begin
        strDescri := fRetNomProduto(strProdutoLocalizar);

        If Not fEmptyStr(strDescri) Then
        Begin
          strDescri := Copy(strDescri, 1, Pos(' ', strDescri));
          objDefConsulta.pIncluiFiltro('ITE_DESITE', ReplaceStr(strDescri, '*', '%'));

          objDefConsulta.recLocalizar.strNomCam := 'ITE_CODITE';
          objDefConsulta.recLocalizar.strValCam := strProdutoLocalizar;
        End;
      End;

      TDefConsultaItem(objDefConsulta).blnColorirGrid := Assigned(objFrmPnl);
      TDefConsultaItem(objDefConsulta).strTabPre := strTabPre;
      TDefConsultaItem(objDefConsulta).strCodCli := strCodCli;
    End; {pDefineConsultaConfigurada}

    Function fRetCodPes: String;
    Begin
      Case opcCodIte of
        cdrCodFab: Result := 'ITE_CODFAB';
        Else       Result := 'ITE_CODITE';
      End;
    End;

    function fGetSQLPreMin(strTabela: String): String;
      Var
        strDesMax: String;
    Begin
      If Not fCfgSis('ITETBP', VarBoolean) Then
        strDesMax := 'G.ITE_DESMAX'
      Else
        strDesMax := 'IFNULL((SELECT ITE_DESMAX ' +
                     '        FROM ITETBP TBP ' +
                     '        WHERE TBP.ITE_CODITE = G.ITE_CODITE AND ' +
                     '              TBP.ITE_CODEMP = G.ITE_CODEMP AND ' +
                     '              TBP.ITE_TABPRE = ' + strTabela +  ') , 0.00)';

      Result := '  ITE_PREMIN' + strTabela + ', ';  pAddNomeColuna('Preço Mínimo' + strTabela);

      objConsulta.pIncluiSubConsulta('ITE_PREMIN' + strTabela, fGetSQLITE_PREVE('G', strTabela) + ' * (1 - (' + strDesMax + '/100))');
      objConsulta.pFormataDecimal('ITE_PREMIN' + strTabela, intDecUni);
    End;

    Function fSQLPrecos: String;
      Var
        strSQL: String;
        intContador: Integer;
        blnExiCom: Boolean;
    Begin
      strSQL := '';
      blnExiCom := False;

      For intContador := 1 to 7 Do
        If (VS_strTabPrc[intContador] = 'S') And blnExiPrecos Then
        Begin

          strSQL := strSQL + ' PREPRO' + IntToStr(intContador) + ', ';
          pAddNomeColuna('Preço Promoção ' + IntToStr(intContador));

          If (blnExibirInfPromoc) Then
            objConsulta.pIncluiSubConsulta('PREPRO' + IntToStr(intContador), fSubSelPrecoPromocao(strCodCnd, strConPag, IntToStr(intContador), strCodCli, strNumOrc, strEspOrc))
          Else
            objConsulta.pIncluiSubConsulta('PREPRO' + IntToStr(intContador), ' 0.00 ');

          objConsulta.pFormataDecimal('PREPRO' + IntToStr(intContador), intDecUni);

          If (Assigned(objFrmPnl)) And (objFrmPnl.blnEstaEmAbastecimentoPorDepositoUsandoPrecoLocal) Then
            strSQL := strSQL + fGetSQLITE_PREVE('G', IntToStr(intContador), True, True) + ', '
          Else
            strSQL := strSQL + fGetSQLITE_PREVE('G', IntToStr(intContador), True) + ', ';

          pAddNomeColuna('Preço Venda' + IntToStr(intContador));
          objConsulta.pFormataDecimal('ITE_PREVE' +IntToStr(intContador), intDecUni);
          objConsulta.pIncluiCamposDisplayGeneric('ITE_PREVE' +IntToStr(intContador));

          if fCfgSis('COTDOR', varBoolean) And (fltDolar > 0) Then
          Begin
            objConsulta.pIncluiSubConsulta('ITE_DOLAR' + IntToStr(intContador), 'G.ITE_PREVE' + IntToStr(intContador) + ' / ' + AnsiReplaceStr(FloatToStr(fltDolar), ',', '.'));
            strSQL := strSQL +'ITE_DOLAR' + IntToStr(intContador) + ', ' ;
            pAddNomeColuna('(US$) Preço Venda ' + IntToStr(intContador));
          End;

          If Not blnExiCom Then
          Begin
            If fCfgSis('PCMPRO') = '1' Then
            Begin
              blnExiCom := True;
              strSQL := strSQL + '  G.ITE_COMTB1, ';
              pAddNomeColuna('%Comissão');

              objConsulta.pIncluiSubConsulta('VLR_COMIS1', '((G.ITE_PREVE1 / 100) * G.ITE_COMTB1)');
              strSQL := strSQL + 'VLR_COMIS1, ' ;
              pAddNomeColuna('Vlr.Comissão1');
              objConsulta.pFormataDecimal('VLR_COMIS1', intDecUni);

            End Else If fCfgSis('PCMPRO') = '2' Then
            Begin
              strSQL := strSQL + '  G.ITE_COMTB' + intToStr(intContador) +', ';
              pAddNomeColuna('%Comissão' + intToStr(intContador));

              objConsulta.pIncluiSubConsulta('VLR_COMIS' + intToStr(intContador), '((G.ITE_PREVE' + intToStr(intContador) + ' / 100) * G.ITE_COMTB' + intToStr(intContador) + ')');
              strSQL := strSQL + 'VLR_COMIS' + intToStr(intContador) + ', ';
              pAddNomeColuna('Vlr.Comissão' + intToStr(intContador));
              objConsulta.pFormataDecimal('VLR_COMIS' + intToStr(intContador), intDecUni);

            End
            Else {NESTA OPÇÃO O CAMPO ITE_COMTB1 NÃO É TRATADO COMO COMISSÃO, DEVEMOS PASSAR A DESCRICAO INFORMADA NA CFG_TCOMTB}
            Begin
              strSQL := strSQL + '  G.ITE_COMTB' + intToStr(intContador) +', ';
              pAddNomeColuna('%'+fCfgSis('TCOMTB'));

              objConsulta.pIncluiSubConsulta('VLR_COMIS' + intToStr(intContador), '((G.ITE_PREVE' + intToStr(intContador) + ' / 100) * G.ITE_COMTB' + intToStr(intContador) + ')');
              strSQL := strSQL + 'VLR_COMIS' + intToStr(intContador) + ', ';
              pAddNomeColuna(fCfgSis('TCOMTB') + intToStr(intContador));
              objConsulta.pFormataDecimal('VLR_COMIS' + intToStr(intContador), intDecUni);
            End;
          End;

          strSQL := strSQL + fGetSQLPreMin(IntToStr(intContador));
        End;

      If Not blnExiPrecos Then
      Begin
        strSQL := strSQL + '  ITE_PREVEN, '; pAddNomeColuna('Preço Venda');
      End;

      strSQL := strSQL + '  ITE_PREVEN, '; pAddNomeColuna('Valor Parcela');

      strSQL := strSQL + '  ITE_PRECLI, '; pAddNomeColuna('Preço Cliente');

      Result := strSQL;
    End;

    Function fJoinGrupoDeCompra: String;
      Var
        strSQL: String;
    Begin
      strSQL := '';

      strSQL := strSQl + '  LEFT JOIN GRU_COMPRA GC ON GC.GRU_CODIGO = ITE_GRUCMP ';

      If Not fEmptyStr(strCodCmp) Then
         strSQL := strSQl + '  AND IF(IFNULL(GC.GRU_OPERES, "") = "", TRUE, GC.GRU_OPERES = "' + strCodCmp +'") ';

      strSQL := strSQl + '  LEFT JOIN CADOPE CMP ON CMP.OPE_CODOPE = GC.GRU_OPERES ';

      Result := strSQL;
    End;

    Function fSQLJoinSemelhantes: String;
      Var
        strSQL: String;
    Begin
      strSQL := '';
      strSQL := strSQL + ' LEFT JOIN CADSEM S ON ';
      strSQL := strSQL + '   SEM_CODITE = I.ITE_CODITE  AND ';
      strSQL := strSQL + '   SEM_CODSEM = ' + QuotedStr(strCodFab);

      Result := strSQL;
    End;

    Function fSQLJoinSomenteEstrutura: String;
      Var
        strSQL: String;
    Begin
      strSQL := '';

      If (fCfgSis('UTIIND', varBoolean)) Then
        strSQL := strSQL + ' LEFT JOIN GEIMAT GM ON GM.GMT_CODITE = I.ITE_CODITE '
      Else
        strSQL := strSQL + ' LEFT JOIN GERMAT GM ON GM.GMT_CODITE = I.ITE_CODITE ';

      Result := strSQL;
    End;

    function fGetSQLDesMax: String;
    Var
      intContador: integer;
      strSQL,
      strDesMax,
      strDesMsu,
      strDesMge: String;
    Begin
      strSQL := '';
      For intContador := 1 to 7 Do
      Begin
        If (VS_strTabPrc[intContador] = 'S') Then
        Begin
          If Not fCfgSis('ITETBP', VarBoolean) Then
          begin
            strSQL := strSQL + ' (G.ITE_DESMAX) AS ITE_DESMAX' + IntToStr(intContador) + ', '; pAddNomeColuna('Desc. Máx. Vendedor' + IntToStr(intContador));
            strSQL := strSQL + ' (G.ITE_DESMSU) AS ITE_DESMSU' + IntToStr(intContador) + ', '; pAddNomeColuna('Desc. Máx. Sub-Gerente' + IntToStr(intContador));
            strSQL := strSQL + ' (G.ITE_DESMGE) AS ITE_DESMGE' + IntToStr(intContador) + ', '; pAddNomeColuna('Desc. Máx. Gerente' + IntToStr(intContador));
          end
          Else
          begin
            strDesMax := '  IFNULL((SELECT TBP.ITE_DESMAX ' +
                         '        FROM ITETBP TBP ' +
                         '        WHERE TBP.ITE_CODITE = G.ITE_CODITE AND ' +
                         '              TBP.ITE_CODEMP = G.ITE_CODEMP AND ' +
                         '              TBP.ITE_TABPRE = ' + IntToStr(intContador) +  ') , 0.00)';

            strDesMsu := '  IFNULL((SELECT TBP.ITE_DESMSU ' +
                         '        FROM ITETBP TBP ' +
                         '        WHERE TBP.ITE_CODITE = G.ITE_CODITE AND ' +
                         '              TBP.ITE_CODEMP = G.ITE_CODEMP AND ' +
                         '              TBP.ITE_TABPRE = ' + IntToStr(intContador) +  ') , 0.00)';

            strDesMge := '  IFNULL((SELECT TBP.ITE_DESMGE ' +
                         '        FROM ITETBP TBP ' +
                         '        WHERE TBP.ITE_CODITE = G.ITE_CODITE AND ' +
                         '              TBP.ITE_CODEMP = G.ITE_CODEMP AND ' +
                         '              TBP.ITE_TABPRE = ' + IntToStr(intContador) +  ') , 0.00)';

            strSQL := strSQL + 'ITE_DESMAX' + IntToStr(intContador) + ', '; pAddNomeColuna('Desc. Máx. Vendedor' + IntToStr(intContador));
            objConsulta.pIncluiSubConsulta('ITE_DESMAX' + IntToStr(intContador), strDesMax);

            strSQL := strSQL + 'ITE_DESMSU' + IntToStr(intContador) + ', '; pAddNomeColuna('Desc. Máx. Sub-Gerente' + IntToStr(intContador));
            objConsulta.pIncluiSubConsulta('ITE_DESMSU' + IntToStr(intContador), strDesMsu);

            strSQL := strSQL + 'ITE_DESMGE' + IntToStr(intContador) + ', '; pAddNomeColuna('Desc. Máx. Gerente' + IntToStr(intContador));
            objConsulta.pIncluiSubConsulta('ITE_DESMGE' + IntToStr(intContador), strDesMge);
          end;

          objConsulta.pFormataDecimal('ITE_DESMAX' + IntToStr(intContador), intDecUni);
          objConsulta.pFormataDecimal('ITE_DESMSU' + IntToStr(intContador), intDecUni);
          objConsulta.pFormataDecimal('ITE_DESMGE' + IntToStr(intContador), intDecUni);
        end;
      end;

      Result := strSQL;
    End;

    Function fSQLItens: String;
      Var
        strSQL, strTABPRC: String;
        intCnt : Integer;
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT ';

      If fCfgSis('TIPGIR', varBoolean) Then
        strSQL := strSQL + '  G.ITE_NIVGIR, '
      Else
        strSQL := strSQL + '  I.ITE_NVLGIR, ';
      pAddNomeColuna('Giro');

      strSQL := strSQL + ' IMPRIMELIS, '; pAddNomeColuna('Imprime Lista');
      objConsulta.pIncluiSubConsulta('IMPRIMELIS', 'IF(G.ITE_IMPLIS = "S", "SIM", "NÃO")');
      objConsulta.pIncluiCampoSimNao('IMPRIMELIS');

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

      If fCfgSis('PROVEI', varBoolean) Then
      Begin
        objConsulta.pIncluiSubConsulta('MODELV', fRetSQLModeloVeiculo);
        objConsulta.pIncluiSubConsulta('MARCAV', fRetSQLMarcaVeiculo);
        strSQL := strSQL + '  MODELV, ';        pAddNomeColuna('Modelo Veiculo');
        strSQL := strSQL + '  MARCAV, ';        pAddNomeColuna('Marca Veiculo');
      End;

      strSQL := strSQL + '  I.ITE_CODGRU, ';  pAddNomeColuna('Grupo');
      strSQL := strSQL + '  I.ITE_PAGREV, ';  pAddNomeColuna('Página da Revista');

      strTABPRC := fCfgSis('TABPRC');
      For intCnt := 1 To Length(strTABPRC) Do
      Begin
        if strTABPRC[intCnt] = 'S' Then
        Begin
          strSQL := strSQL + '  G.ITE_MARBR' + IntToStr(intCnt) + ', ';  pAddNomeColuna('Margem ' + IntToStr(intCnt));
        End;
      End;

      strSQL := strSQL + '  DG.GRU_DESGRU, '; pAddNomeColuna('Descrição Grupo');
      objConsulta.pIncluiConflito('GRU_DESGRU', 'DG.GRU_DESGRU');

      objConsulta.pIncluiSubConsulta('DESLIN', 'DL.GRU_DESGRU');

      strSQL := strSQL + '  DESLIN, ';        pAddNomeColuna('Descrição da Linha');

      strSQL := strSQL + '  I.ITE_CODITE, ';  pAddNomeColuna('Código');
      strSQL := strSQL + '  I.ITE_DESITE, ';  pAddNomeColuna('Descrição');

      strSQL := strSQL + '  I.ITE_VALIDA, ';  pAddNomeColuna('Validade');
      strSQL := strSQL + '  I.ITE_CODSIM, ';  pAddNomeColuna('Código Similaridade');

      strSQL := strSQL + '  I.ITE_CBNDES, ';  pAddNomeColuna('Convênio BNDES');

      strSQL := strSQL + '   ITENOTULT, ';  pAddNomeColuna('Doc Ult. Compra');
      objConsulta.pIncluiSubConsulta('ITENOTULT', 'SUBSTRING(G.ITE_NOTULT,1,12)');

      strSQL := strSQL + '  G.ITE_QTDUCO, ';  pAddNomeColuna('Qtd Ult. Compra');

      strSQL := strSQL + '  I.ITE_CEREPI, ';  pAddNomeColuna('Certificado de Aprovação EPI (CA)');

      If fCfgSis('CADMON', varBoolean) Then
      Begin
        objConsulta.pIncluiSubConsulta('MONTADORA', fSubSelMontadora);

        strSQL := strSQL + '  MONTADORA,  ';  pAddNomeColuna('Montadora');
      End;

      strSQL := strSQL + '  I.ITE_REFERE, ';  pAddNomeColuna('Referência');
      strSQL := strSQL + '  U.UNI_SIGUNI, ';  pAddNomeColuna('Unid.');

      If (blnMostraSaldo) Then
      Begin
        strSQL := strSQL + '  ITE_SALFIS,  ';
        pAddNomeColuna('Saldo Físico');
        strSQL := strSQL + '  ITE_SALDOS2,  ';
        pAddNomeColuna('Saldo Disponível');
      End;

      {*******************************************************************************}
      {*    Caso o parãmetro  VENMAD = Utilizar rotinas de venda de madeira? = SIM   *}
      {*           então ira calcular o fator que estiver definido no campo          *}
      {*             FATCMP - Fator de conversão madeira de m³ para Peças            *}
      {*****************************************************************************WG}
      If fCfgSis('VENMAD', varBoolean) Then
      Begin
         objConsulta.pIncluiSubConsulta('FATCMP', 'IF(U.UNI_METFAT = "S", IF(G.ITE_SALDOS * I.ITE_FATCMP = 0, NULL, G.ITE_SALDOS * I.ITE_FATCMP), NULL)');
         strSQL := strSQL + '   FATCMP, ';
         pAddNomeColuna('Saldo em Peças');
         objConsulta.pFormataDecimal('FATCMP', 4);
      End;

      If blnExcosa Then
      Begin
        objConsulta.pIncluiSubConsulta('COMSALDO', 'IF((' + fGetSQLEmpSaldos + ') > 0, "SIM", "NÃO")');
        objConsulta.pIncluiSubConsulta('SALDOTODAS', fGetSQLEmpSaldos);
        objConsulta.pFormataDecimal('SALDOTODAS', intDecQtd);

        strSQL := strSQL + '  SALDOTODAS,  ';  pAddNomeColuna('Saldo Físico de Todas as Empresas');

        objConsulta.pIncluiSubConsulta('SALDODTODAS', fGetSQLEmpSaldosDis);
        objConsulta.pFormataDecimal('SALDODTODAS', intDecQtd);

        strSQL := strSQL + '  SALDODTODAS,  ';  pAddNomeColuna('Saldo Disponivel de Todas as Empresas');

      End;

      If fCfgSis('EXIORD', varBoolean) Then
      Begin
        objConsulta.pIncluiSubConsulta('SALROP', fGetSQLSaldoReservadoEmOrdemDeProducao);
        strSQL := strSQL + 'SALROP, '; pAddNomeColuna('Saldo reservado em Ordem de Produção');
      End;

      If blnEstExt Then
        objConsulta.pIncluiSubConsulta('SALDOEXTERNO', 'IF(IFNULL(G.ITE_SALEXT, 0) > 0, "SIM", "NÃO")');

      If blnExibeColunaSaldoCD Then
      Begin
        objConsulta.pIncluiSubConsulta('SALDOSCD', 'CD.ITE_SALDOS');
        objConsulta.pFormataDecimal('SALDOSCD', intDecQtd);

        strSQL := strSQL + ' SALDOSCD, '; pAddNomeColuna('Saldo C.D.');
      End;

      strSQL := strSQL + '  ITEAPLICA,    ';  pAddNomeColuna('Aplicação');
      strSQL := strSQL + ' G.ITE_PRECUS,  ';  pAddNomeColuna('Preço Custo');

      strSQL := strSQL + fSQLPrecos;

      If fltDescFidelidade <> -1 Then
      Begin
        strSQL := strSQL +  AnsiReplaceStr(FloatToStr(fltDescFidelidade), ',', '.') + ', '; pAddNomeColuna('%Desc. Fidelidade');
      End;

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
      strSQL := strSQL + '  CAM_LOCFIS,    '; pAddNomeColuna('Loc. Física');
      strSQL := strSQL + '  G.ITE_LOCSUP,  '; pAddNomeColuna('Loc. Super Estoque');
      strSQL := strSQL + '  I.ITE_CODFOR,  '; pAddNomeColuna('Cód. Fornecedor');
      strSQL := strSQL + '  F.FOR_NOMFOR,  '; pAddNomeColuna('Nome do Fornecedor');

      If blnViewDiasSemVenda Then
         strSQL := strSQL + '  VW_ITEGER_DATA_DIAS_SEM_VENDA.ULTVEN,        '
      Else
        strSQL := strSQL + '  ULTVEN,        ';
      pAddNomeColuna('Dias sem venda');

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

      If fCfgSis('UPSEML', varBoolean) Then
      Begin
        objConsulta.pIncluiSubConsulta('SALCMP', fGetSQLSaldoCompartilhado);
        strSQL := strSQL + 'SALCMP, '; pAddNomeColuna('Saldo compartilhado');
      End;

      If blnEstExt Then
      Begin
        strSQL := strSQL + '  SALDOEXTERNO, '; pAddNomeColuna('Com Saldo Externo');
      End;

      strSQL := strSQL + '  EMPROMOC,      '; pAddNomeColuna('Em Promoção');
      strSQL := strSQL + '  BOCACAIXA,     '; pAddNomeColuna('Em boca de caixa');

      If blnExibirEmCampanha Then
      Begin
        strSQL := strSQL + '  EMCAMPANHA,    '; pAddNomeColuna('Em Campanha');
      End;

      If blnExibirCodProCliente Then
      Begin
        strSQL := strSQL + '  CODCPL,    '; pAddNomeColuna('Cód. Interno Produto Cliente');
      End;

      strSQL := strSQL + '  CMP.OPE_NOMOPE, '; pAddNomeColuna('Comprador');

      If blnItePDO Then
      Begin
        strSQL := strSQL + '  ITE_PDOR,    '; pAddNomeColuna('Itens Vendidos em PD/OR');
      End;
      strSQL := strSQL + '  LOCGER,    '; pAddNomeColuna('Localizações Fisicas');

      strSQL := strSQL + '  I.ITE_CDCEST,  '; pAddNomeColuna('Classificação CEST');
      strSQL := strSQL + '  I.ITE_TMPGAR,  ';  pAddNomeColuna('Tempo de Garantia');
      strSQL := strSQL + '  TIPOS_PRODUTO,  ';  pAddNomeColuna('Tipo de Produto (Sped)');

      If fCfgSis('TRQDMI', varBoolean) Then
      Begin
        For intCnt := 1 To Length(VS_strTabPrc) Do
        Begin
          If (VS_strTabPrc[intCnt] = 'S') Then
          Begin
            strSQL := strSQL + ' G.ITE_MINTB' + IntToStr(intCnt) + ', ';
            pAddNomeColuna('Qtd. Mín. Tabela ' + IntToStr(intCnt));
          End;
        End;
      End;

      If strPDCPRO <> 'N' Then
      Begin
        objConsulta.pIncluiSubConsulta('QTD_PEDCOM', '(' + fSQLQuantidadePendenteCompra('I.ITE_CODITE', VS_StrCodemp, False, True) + ')' +
                                                     IfThen(Not fCfgSis('EXGACN', varBoolean), ' - (' + fSQLQuantidadePendenteCompraGarantia('I.ITE_CODITE', VS_StrCodemp) + ')', ''));
        strSQL := strSQL + 'QTD_PEDCOM, '; pAddNomeColuna('Qtd.Ped.Compra');
      End;

      If strPDCPRO = 'T' Then
      Begin
        objConsulta.pIncluiSubConsulta('QTD_PEDCOT', '(' + fSQLQuantidadePendenteCompra('I.ITE_CODITE', '', False, True) + ')' +
                                                      IfThen(Not fCfgSis('EXGACN', varBoolean), ' - (' + fSQLQuantidadePendenteCompraGarantia('I.ITE_CODITE', '') + ')', ''));
        strSQL := strSQL + 'QTD_PEDCOT, '; pAddNomeColuna('Qtd.Ped.Compra.Lojas');
      End;

      If strPDCPRO <> 'N' Then
      Begin
        objConsulta.pIncluiSubConsulta('QTD_REQPEN', '(' + fSQLQuantidadeReqPendente('I.ITE_CODITE', VS_StrCodemp, False, True) + ')');
        strSQL := strSQL + 'QTD_REQPEN, '; pAddNomeColuna('Qtd.Req.Pendente');
      End;

      If strPDCPRO = 'T' Then
      Begin
        objConsulta.pIncluiSubConsulta('QTD_REQPET', '(' + fSQLQuantidadeReqPendente('I.ITE_CODITE', '', False, True) + ')');
        strSQL := strSQL + 'QTD_REQPET, '; pAddNomeColuna('Qtd.Req.Pendente.Lojas');
      End;

      strSQL := strSQL + '  I.ITE_DESSIM, '; pAddNomeColuna('Descrição Simplificada');

      strSQL := strSQL + '  ITEPESQUI,     '; pAddNomeColuna('Descrição Livre');

      strSQL := strSQL + '  I.ITE_MLTCOM,  '; pAddNomeColuna('Múlt. Compra');
      strSQL := strSQL + '  I.ITE_MLTVEN,  '; pAddNomeColuna('Múlt. Venda');

      strSQL := strSQL + '  GPR_DESCRI,  '; pAddNomeColuna('Grupo de Preços');
      strSQL := strSQL + '  PRD_DESGRU,  '; pAddNomeColuna('Grupo de Produto');
      strSQL := strSQL + '  GRU_DESCRI,  '; pAddNomeColuna('Grupo de Compra');

      strSQL := strSQL + fGetSQLDesMax;

      objConsulta.pIncluiSubConsulta('ITE_PESOIT', 'I.ITE_PESOIT');
      objConsulta.pFormataDecimal('ITE_PESOIT', intDecQtd);

      strSQL := strSQL + '  ITE_PESOIT,  '; pAddNomeColuna('Pes. Bruto');
      strSQL := strSQL + '  I.ITE_PESLIQ,  '; pAddNomeColuna('Pes. Líquido');
      strSQL := strSQL + '  G.ITE_ESTMIN,  '; pAddNomeColuna('Est. Mínimo');
      strSQL := strSQL + '  G.ITE_ESTMAX,  '; pAddNomeColuna('Est. Máximo');

      strSQL := strSQL + '  I.ITE_QRCODE,  '; pAddNomeColuna('URL do produto');
      objConsulta.ArrFieldLink := objConsulta.ArrFieldLink + ['ITE_QRCODE'];

      If (Not fEmptyStr(strEmpSaldoMatrizCD)) And (strEmpSaldoMatrizCD <> VS_strCodEmp) And (Pos(strOpcDoc, 'OR_PD_VN_') > 0) Then
      Begin
        objConsulta.pIncluiSubConsulta('ITE_EMINEL', '(SELECT ITEGER.ITE_ESTMIN FROM ITEGER WHERE ITEGER.ITE_CODITE = G.ITE_CODITE AND ITEGER.ITE_CODEMP = '+QuotedStr(VS_strCodEmp)+')');
        strSQL := strSQL + 'ITE_EMINEL, '; pAddNomeColuna('Est.Mínimo Emp. Logada');
        objConsulta.pIncluiSubConsulta('ITE_EMAXEL', '(SELECT ITEGER.ITE_ESTMAX FROM ITEGER WHERE ITEGER.ITE_CODITE = G.ITE_CODITE AND ITEGER.ITE_CODEMP = '+QuotedStr(VS_strCodEmp)+')');
        strSQL := strSQL + 'ITE_EMAXEL, '; pAddNomeColuna('Est.Máximo Emp. Logada');
        strTitulo := 'ConsultadeItens-EstoqueEmpresaLogada.';
      End;

      strSQL := strSQL + '  ESMIDIGGER,  '; pAddNomeColuna('Est. Mín. Dig/Gerado');

      strSQL := strSQL + '  ITERECDEV,     '; pAddNomeColuna('Permite Devolução');

      If TDefConsultaItem(objConsulta).blnSitPro Then
      Begin
        strSQL := strSQL + '  SIT_DESCRI,   ';  pAddNomeColuna('Situação do Produto');
      End;
      strSQL := strSQL + '  ITE_DALTPR, '; pAddNomeColuna('Dta. Alteração de Preço');
      strSQL := strSQL + '  ITE_DTACAD, '; pAddNomeColuna('Dta. Cadastro');
      strSQL := strSQL + '  EXPSIT,  ';  pAddNomeColuna('Export. para E-Commerce');
      strSQL := strSQL + '  SOBENC,  ';  pAddNomeColuna('Sob encomenda?');

      If (fCfgSis('PDISIF') = 'S') And (fCfgSis('ICMDEB') = 'S') Then
      Begin
        objConsulta.pIncluiSubConsulta('ITE_CUSREA',
           '((IFNULL(G.ITE_PRECUS,0) + IFNULL(G.ITE_OUTVAL,0)) / (1 - (IFNULL(G.ITE_ICMSAI,0) + IFNULL(G.ITE_DESOPE,0) + (IFNULL(G.ITE_IMPFED,0) * (1 - (IFNULL(G.ITE_ICMSAI,0) / 100.0)))) / 100))');

        strSQL := strSQL + ' ITE_CUSREA, '; pAddNomeColuna('Preço de custo real');
      End
      Else
      Begin
        objConsulta.pIncluiSubConsulta('ITE_CUSREA',
          '((IFNULL(G.ITE_PRECUS,0) + IFNULL(G.ITE_OUTVAL,0)) / (1 - (IFNULL(G.ITE_ICMSAI,0) + IFNULL(G.ITE_DESOPE,0) + IFNULL(G.ITE_IMPFED,0)) / 100))');

        strSQL := strSQL + ' ITE_CUSREA, '; pAddNomeColuna('Preço de custo real');
      End;

   	  strSQL := strSQL + '  AGR_CODAGR, '; pAddNomeColuna('Código de Agrupamento');
      objConsulta.pIncluiListaForcaContida('AGR_CODAGR');
      objConsulta.pIncluiSubConsulta('AGR_CODAGR', '(SELECT GROUP_CONCAT(AGR_CODAGR) FROM CADAGR WHERE AGR_CODITE = I.ITE_CODITE)');

      if fCfgSis('CLIPRO',varBoolean) then
      begin
        strSQL := strSQL + '  CLI_COD_NF, '; pAddNomeColuna('Cód. Fábrica Cliente');
        objConsulta.pIncluiListaForcaContida('CLI_COD_NF');
        objConsulta.pIncluiSubConsulta('CLI_COD_NF', '(SELECT GROUP_CONCAT(DISTINCT CLI_COD_NF) FROM CLIPRO WHERE CLI_CODITE = I.ITE_CODITE)');
      end;

      strSQL := strSQL + '  DIASSV, '; pAddNomeColuna('Dias sem Venda - Geral');
      objConsulta.pIncluiSubConsulta('DIASSV', '(SELECT DATEDIFF(' + fCurrentDate + ', GREATEST(IFNULL(MAX(ITE.ITE_DTAUVE), CAST("1900-01-01" AS DATE)), IFNULL(MIN(ITE.ITE_DTABAL), CAST("1900-01-01" AS DATE)))) FROM ITEGER AS ITE WHERE ITE.ITE_CODITE = I.ITE_CODITE GROUP BY ITE.ITE_CODITE)');

      objConsulta.pIncluiIconeSobEncomenda('SOBENC', frmModuloLegenda.imglSobEnc, fCfgSis('CORSEN', varInteger));

      // CAMPOS QUE NAO APARECEM NA GRID - SEM NOME DE COLUNA

      If TDefConsultaItem(objConsulta).blnSitPro Then
      Begin
        strSQL := strSQL + '  SIT_CORSIT,   ';
      End;

      strSQL := strSQL + '  ESTRUT,        ';
      strSQL := strSQL + '  I.ITE_INFGAR,  ';
      strSQL := strSQL + '  (REPLACE(I.ITE_APLICA, "<<csq>>", CHAR(13))) AS ITE_APLICA,  ';
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

      objConsulta.pIncluiSubConsulta('COMBO', '(SELECT ' +
                                                '   IF(COUNT(*) > 0, "S", "N") ' +
      ' FROM ' +
      '   COMVEN C ' +
      '   INNER JOIN COMEMP E ON E.COM_SEQGER = C.AUTOINCREM ' +
      '   INNER JOIN PROATI A ON A.ATI_SEQGER = C.AUTOINCREM ' +
      ' WHERE ' +
      '   CURRENT_DATE BETWEEN C.COM_DTAINI AND C.COM_DTAFIN AND E.COM_CODEMP = G.ITE_CODEMP AND A.ATI_CODITE = I.ITE_CODITE)');

      strSQL := strSQL + '  I.AUTOINCREM,   ';
      strSQL := strSQL + '  I.ITE_COMPNA,   ';
      strSQL := strSQL + '  I.ITE_COMPNB,   ';
      strSQL := strSQL + '  G.ITE_QTPD_F,   ';
      strSQL := strSQL + '  G.ITE_SALTRA,   ';
      strSQL := strSQL + '  SAL_FILLIB,     ';
      strSQL := strSQL + '  SAL_FILNLI      ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + '   CADITE I ';

      strSQL := strSQL + ' LEFT JOIN CADDEP ON DEP_CODIGO = ITE_CODDEP ';
      strSQL := strSQL + ' INNER JOIN CADUNI U ON U.UNI_CODUNI = I.ITE_CODUNI ';
      strSQL := strSQL + ' INNER JOIN CADMAR M ON I.ITE_CODMAR = M.MAR_CODMAR ';
      strSQL := strSQL + ' INNER JOIN ITEGER G ON I.ITE_CODITE = G.ITE_CODITE AND ';
      strSQL := strSQL + '                        G.ITE_CODEMP = ' + QuotedStr(IIF(blnEmpFat, strCodEmp, strEmpSaldoMatrizCD)) + ' ';

      If Not fEmptyStr(strCodAmz) Then
      Begin
        strSQL := strSQL + ' INNER JOIN CADLOT AMZ ON AMZ.LOT_CODITE = G.ITE_CODITE ';
        strSQL := strSQL + '                        AND AMZ.LOT_CODEMP = G.ITE_CODEMP';
        strSQL := strSQL + '                        AND AMZ.LOT_NUMLOT = ' + strCodAmz.QuotedString + ' ';
      End;

      If blnViewDiasSemVenda Then
        strSQL := strSQL + ' INNER JOIN VW_ITEGER_DATA_DIAS_SEM_VENDA ON VW_ITEGER_DATA_DIAS_SEM_VENDA.ITE_CODITE = G.ITE_CODITE AND VW_ITEGER_DATA_DIAS_SEM_VENDA.ITE_CODEMP = G.ITE_CODEMP ';

      If fCfgSis('COSMAR', varBoolean) Then
      Begin
        If fCfgSis('UTIVMA', varBoolean) Then
        Begin
          If (blnFaturamento) Then
          Begin
            If (fExisteVendedorAssociadoMarca(strCodVen)) Then
              strSQL := strSQL + ' INNER JOIN VENMAR ON I.ITE_CODMAR = VENMAR.VEM_CODMAR AND ' +
                'VENMAR.VEM_CODVEN = ' + QuotedStr(strCodVen);
          End
          Else
          Begin
            If (fExisteVendedorAssociadoMarca(strLoginUsuarioLogado)) Then
              strSQL := strSQL + ' INNER JOIN VENMAR ON I.ITE_CODMAR = VENMAR.VEM_CODMAR AND ' +
                'VENMAR.VEM_CODVEN = ' + QuotedStr(strLoginUsuarioLogado);
          End;
        End;
      End;

      pValidaCfgITEVEN(strSQL, strCodVen, strCodCli, strOpcDoc);

      If TDefConsultaItem(objConsulta).blnSitPro Then
        If fCfgSis('SITEMP') = '1' Then
          strSQL := strSQL + 'LEFT JOIN SITPRO ON I.ITE_SITPRO = SIT_CODIGO '
        Else
          strSQL := strSQL + 'LEFT JOIN SITPRO ON G.ITE_SITPRO = SIT_CODIGO ';

      strSQL := strSQL + ' LEFT JOIN ITEBAR ON BAR_CODITE = I.ITE_CODITE AND BAR_PRINCI = 1 ';

      strSQL := strSQL + ' LEFT JOIN CADFOR F ON I.ITE_CODFOR = F.FOR_CODFOR ';

      strSQL := strSQL + ' LEFT JOIN CADGPR ON GPR_CODIGO = ITE_CODGPR ';

      strSQL := strSQL + ' LEFT JOIN GRPPRD ON PRD_CODGRU = ITE_PRDGRU ';

      strSQL := strSQL + ' LEFT JOIN CADGRU DG ON DG.GRU_CODGRU = ITE_CODGRU ';

      strSQL := strSQL + ' LEFT JOIN CADGRU DL ON DL.GRU_CODGRU = CONCAT(LEFT(ITE_CODGRU, 3), "000") ';

      strSQL := strSQL + ' LEFT JOIN SALPDC ON SAL_CODITE = I.ITE_CODITE ';
      strSQL := strSQL + '                 AND SAL_CODEMP = G.ITE_CODEMP ';


      {******************************************************************}
      {* CONDIÇÃO ESPECÍFICA PARA CONSULTA DE ITENS DO PEDIDO DE COMPRA *}
      {***************************************************************JU*}
      strSQL := strSQl + fJoinGrupoDeCompra;

      If blnExibeColunaSaldoCD Then
      Begin
        strSQL := strSQL + '  LEFT JOIN ITEGER CD ON I.ITE_CODITE = CD.ITE_CODITE AND ';
        strSQL := strSQL + '                        CD.ITE_CODEMP = ' + QuotedStr(strEmp_CD) + ' ';
      End;

      If opcTipIte = conIteSemelhantes Then
        strSQL := strSQL + fSQLJoinSemelhantes;

      If (blnSomenteEstrutura) Then
        strSQL := strSQL + fSQLJoinSomenteEstrutura;

      Result := strSQL;
    End;

    Function fSQLWhere(blnCompleto: Boolean = True): String;
      Var
        strWhere: String;
    Begin
      strWhere := '';

      If blnCompleto Then
        strWhere := strWhere + 'WHERE TRUE ';

      If blnPedCom Then
      Begin
        if Not fCfgSis('ITEINA', varBoolean) then
        begin
          strWhere := strWhere + '  AND ITE_ATICOM = "S"  ';
        end;

        If Not fCfgSis('MOSITE', varBoolean) Then
          strWhere := strWhere + ' AND ITE_ITEATI = "S" ';

        If blnImpLis And (Not fCfgSis('EXILCC', varBoolean)) And blnConsiderarExiLis Then
          strWhere := strWhere + ' AND G.ITE_IMPLIS = "S" ';
      End
      Else
      Begin

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

      If (Not blnPedCom) And blnImpLis And (Not fCfgSis('EXILIS', varBoolean)) And blnConsiderarExiLis Then
      Begin
        If (Not blnEmpFat) Or (Not blnCompleto) Then
          strWhere := strWhere + '  AND G.ITE_IMPLIS = "S" '
        Else
        Begin
          strWhere := strWhere + '  AND EXISTS (                     ';
          strWhere := strWhere + '    SELECT                         ';
          strWhere := strWhere + '      IL.ITE_CODITE                ';
          strWhere := strWhere + '    FROM                           ';
          strWhere := strWhere + '      ITEGER IL                    ';
          strWhere := strWhere + '    WHERE                          ';
          strWhere := strWhere + '      I.ITE_CODITE = IL.ITE_CODITE ';
          strWhere := strWhere + '      AND IL.ITE_IMPLIS = "S"      ';

          If (fCfgSis('ILIEMP', VarBoolean)) And
             (fCfgSis('EPRPLI', varBoolean)) Then
            strWhere := strWhere + '      AND IL.ITE_CODEMP = "' + IIF(blnEmpFat, strCodEmp, strEmpSaldoMatrizCD) + '"  ';

          strWhere := strWhere + '  )                                ';
        End;
      End;

      // na consulta da Correçao da ordem de produçao pode incluir matéria prima ou embalagem
      If blnDepProEmbIndustrial And blnDepMatPriIndustrial And (fCfgSis('UTIIND', varBoolean)) Then
      Begin
          //Filtra somente produtos com o departamento materia prima da aba Industrial
          strWhere := strWhere + '  AND ( I.ITE_CODDEP IN (' + fRetTipoDepartamentoVarios('PROMAP') + ') ';
          //Filtra somente produtos com o departamento produto embalagem da aba Industrial
          strWhere := strWhere + '  OR I.ITE_CODDEP IN (' + fRetTipoDepartamentoVarios('PROEMB') + ')) ';
      End
      Else
      Begin
        If blnDepMatPriIndustrial And (fCfgSis('UTIIND', varBoolean)) Then
        Begin
          //Filtra somente produtos com o departamento materia prima da aba Industrial
          strWhere := strWhere + '  AND I.ITE_CODDEP IN (' + fRetTipoDepartamentoVarios('PROMAP') + ') ';
        End;

        If blnDepProEmbIndustrial And (fCfgSis('UTIIND', varBoolean)) Then
        Begin
          //Filtra somente produtos com o departamento produto embalagem da aba Industrial
          strWhere := strWhere + '  AND I.ITE_CODDEP IN (' + fRetTipoDepartamentoVarios('PROEMB') + ') ';
        End;
      End;

      If blnDepProAcaIndustrial And (fCfgSis('UTIIND', varBoolean)) Then
      Begin
        //Filtra somente produtos com o departamento produto acabado da aba Industrial
        strWhere := strWhere + '  AND I.ITE_CODDEP IN (' + fRetTipoDepartamentoVarios('PROACA') + ') ';
      End;


      If blnDepProGraIndustrial And (fCfgSis('UTIIND', varBoolean)) Then
      Begin
        //Filtra somente produtos com o departamento a granel da aba Industrial
        strWhere := strWhere + '  AND I.ITE_CODDEP IN (' + fRetTipoDepartamentoVarios('PROGRA') + ') ';
      End;

      If (fCfgSis('EXIACA', varBoolean)) Then
      Begin
        If fEmptyStr(strExiAca) Then
          strExiAca := IIF((blnVeioF11) Or (blnFaturamento), 'S', 'N');

        If (strExiAca = 'S') And (Pos(strOpcDoc, 'OR_PD_VN_') > 0) Then
          strWhere := strWhere + '  AND COALESCE(CADDEP.DEP_PROACA, "N") = "S" ';
      End
      Else If (strExiAca = 'S') And (Not fEmptyStr(strCodAmz)) Then
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

      if not fEmptyStr(strCodAbf) then
      begin
        if fCfgSis('TIPABF') = '2' then
          strWhere := strWhere + ' AND (G.ITE_CODABF = ' + QuotedStr(strCodAbf) + ') '
        else
          strWhere := strWhere + ' AND (I.ITE_CODABF = ' + QuotedStr(strCodAbf) + ') ';
      end;

      If strComponenteB = 'S' Then
      Begin
        objSQLProdutos:=TSQLProdutos.Create;
        Try
          strWhere := strWhere + objSQLProdutos.fRetornaFiltroSQLComponenteFormulacaoB;
        Finally
          FreeAndNil(objSQLProdutos);
        End;
      End;

      If (strComponenteA = 'A') AND (strComponenteB = 'B') Then
      Begin
        strWhere:= strWhere + '  AND ITE_COMPNB = "N"';
        strWhere:= strWhere + '  AND ITE_COMPNA = "N"';
      End;

      If Not fEmptyStr(strItensEntradaMercadoriaDev) Then
      Begin
        strWhere := strWhere + ' AND I.ITE_CODITE IN('+strItensEntradaMercadoriaDev+') ';
      End;

      If (blnSomenteEstrutura) Then
        strWhere := strWhere + ' AND IFNULL(GM.AUTOINCREM, "") <> "" ';

      strWhere := strWhere + strAplica;

      If blnSomenteProdutosLocEqu Then
      Begin
        strWhere:= strWhere + '  AND ITE_REALOC = "S"';
        strWhere:= strWhere + '  AND ITE_TIPLOC = "P"';
      End;

      If blnSomenteAcessorioLocEqu Then
      Begin
        strWhere:= strWhere + '  AND ITE_REALOC = "S"';
        strWhere:= strWhere + '  AND ITE_TIPLOC = "A"';
      End;

      If blnRecVndBsTrc Then
      Begin
        strWhere:= strWhere + '  AND I.ITE_BASTRO = "S"';
        strWhere:= strWhere + '  AND I.ITE_TPPROD = "R"';
      End;

      If blnUsaSer Then
        strWhere := strWhere + ' AND G.ITE_USASER = "S"';

      If (fCfgSis('OSBPCP', varBoolean)) And (blnFaturamento) Then
      Begin
        If (fCfgSis('VENSUB', varString) <> 'S') Or ((fCfgSis('TRASUB', varString) <> 'S') And (Pos(strOpcDoc, 'TE_') > 0)) Then
        Begin
          strWhere := strWhere + '  AND NOT EXISTS (SELECT DETMAT.DMT_ITESUB FROM DETMAT INNER JOIN GERMAT ON GERMAT.AUTOINCREM = DETMAT.DMT_SEQGER '+
                                 '                  WHERE DETMAT.DMT_ITESUB = I.ITE_CODITE ';

          If (fCfgSis('TRASUB', varString) = 'P') And (Pos(strOpcDoc, 'TE_') > 0) Then
            strWhere := strWhere + '  AND I.ITE_TRASUB <> "S"'
          Else If fCfgSis('VENSUB', varString) = 'P' Then
            strWhere := strWhere + '  AND I.ITE_VENSUB <> "S"';

          strWhere := strWhere + ')';
        End;
      End;

      Result := strWhere;
    End;

    Function fMostrarAplicacao: Boolean;
      Var
        strSQL: String;
        qryConfig: TUniQuery;
    Begin
      strSQL := '';
      strSQL := strSQL + ' SELECT CFG_EXPAND FROM CFGCON C';
      strSQL := strSQL + ' INNER JOIN CFGEMP E ON E.CFG_CODEMP = :CODEMP AND E.CFG_SEQGER = C.AUTOINCREM';
      strSQL := strSQL + ' WHERE C.CFG_CHAVE_ = :CHAVE_  ';

      qryConfig := fCriaQuery(Nil);
      qryConfig.SQL.Text := strSQL;

      qryConfig.ParamByName('CHAVE_').AsString := TLoadConsultaSQL.fGetChaveConsulta(strTitulo);
      qryConfig.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryConfig.Open;

      Result := qryConfig.FieldByName('CFG_EXPAND').AsString = 'S';

      FreeAndNil(qryConfig);
    End;

    Procedure pTrataConsultaConfigurada;
      //Var
      //  intContador: Integer;
    Begin

      If Not fEmptyStr(strCodCmp) Then
        objLoadSQL.stlJoins.add(fJoinGrupoDeCompra);

      If opcTipIte = conIteSemelhantes Then
        objLoadSQL.stlJoins.Add(fSQLJoinSemelhantes);

      If (blnSomenteEstrutura) Then
        objLoadSQL.stlJoins.Add(fSQLJoinSomenteEstrutura);

      objLoadSQL.pSetaWhereAdicional(fSQLWhere(False));

      strSQL := strSQL + ' IMPRIMELIS, '; pAddNomeColuna('Imprime Lista');
      objLoadSQL.fIncluiSubConsulta('IMPRIMELIS', 'IF(G.ITE_IMPLIS = "S", "SIM", "NÃO")','');

      If Assigned(objFrmPnl) And Assigned(objFrmPnl.sltLista) Then
      Begin
        objLoadSQL.fIncluiSubConsulta( 'VENDIDO', 'CAST(IF(LOCATE(I.ITE_CODITE, :LISTA) > 0, 1, NULL) AS UNSIGNED)', 'TAB');

        objDefConsulta.pIncluiIcone('VENDIDO', 0, 0);
        objDefConsulta.pIncluiIcone('VENDIDO', 1, 1);
      End;

      objLoadSQL.fIncluiCampoObrigatorio('I.ITE_CODITE', 'Código');
      objLoadSQL.fIncluiCampoObrigatorio('I.ITE_DESITE', 'Descrição');

      If strPDCPRO <> 'N' Then
      Begin
        objLoadSQL.fIncluiSubConsulta('QTD_PEDCOM', '(' + fSQLQuantidadePendenteCompra('I.ITE_CODITE', VS_StrCodemp, False, True) + ')', 'Qtd.Ped.Compra');
      End;

      If strPDCPRO = 'T' Then
      Begin
        objLoadSQL.fIncluiSubConsulta('QTD_PEDCOT', '(' + fSQLQuantidadePendenteCompra('I.ITE_CODITE', '', False, True) + ')', 'Qtd.Ped.Compra.Lojas');
      End;

      If strPDCPRO <> 'N' Then
      Begin
        objLoadSQL.fIncluiSubConsulta('QTD_REQPEN', '(' + fSQLQuantidadeReqPendente('I.ITE_CODITE', VS_StrCodemp, False, True) + ')', 'Qtd.Req.Pendente');
      End;

      If strPDCPRO = 'T' Then
      Begin
        objLoadSQL.fIncluiSubConsulta('QTD_REQPET', '(' + fSQLQuantidadeReqPendente('I.ITE_CODITE', '', False, True) + ')', 'Qtd.Req.Pendente.Lojas');
      End;

      objLoadSQL.fIncluiSubConsulta('ITE_PREVEN', fRetSQLPreVen, 'Preço Venda');
      objDefConsulta.pFormataDecimal('ITE_PREVEN', intDecUni);
      objDefConsulta.pIncluiCamposDisplayGeneric('ITE_PREVEN');

      objLoadSQL.fIncluiSubConsulta('ITEITEATI', 'IF(I.ITE_ITEATI = "S", "ATIVO", "INATIVO")','');
      objLoadSQL.fIncluiSubConsulta('ITEATICOM', 'IF(I.ITE_ATICOM = "S", "SIM", "NÃO")','');
      objLoadSQL.fIncluiSubConsulta('BOCACAIXA',  fSubSelBOCACAIXA,'');

      If (blnExibirInfPromoc) Then
        objLoadSQL.fIncluiSubConsulta('EMPROMOC',   fSubSelPROMOC(strCodCnd, strConPag, strTabPre, strCodCli, strNumOrc, strEspOrc),'')
      Else
        objLoadSQL.fIncluiSubConsulta('EMPROMOC',   '"NÃO"','');

      If Assigned(objFrmPnl) Then
      Begin

        If Not TDefConsultaItem(objDefConsulta).blnPanIte Then
        Begin
          objLoadSQL.fIncluiSubConsulta('CAM_LOCFIS', 'ITE_LOCFIS', 'Loc. Física');
          If Not blnViewDiasSemVenda Then
            objLoadSQL.fIncluiSubConsulta('ULTVEN', 'DATEDIFF(' + fCurrentDate + ', IFNULL(G.ITE_DTAUVE, G.ITE_DTABAL))', 'Dias sem venda');

          objLoadSQL.fIncluiCampoObrigatorio('G.ITE_LOCSUP', 'Super Estoque');
          objLoadSQL.fIncluiCampoObrigatorio('I.ITE_TMPGAR', 'Tempo de Garantia');
          objLoadSQL.fIncluiCampoObrigatorio('I.ITE_INFGAR', 'Informação Garantia');
        End;

        objLoadSQL.fIncluiCampoObrigatorio('G.ITE_SALDOS');
        objLoadSQL.fIncluiCampoObrigatorio('G.ITE_SAL_ML');
	      objLoadSQL.fIncluiCampoObrigatorio('I.ITE_CNV_ML');

        objLoadSQL.fIncluiCampoObrigatorio('I.ITE_CODSIM');

        If (Not objLoadSQL.fCampoDefinidoPeloUsuaio('ITE_APLICA')) And fMostrarAplicacao Then
        Begin
          objLoadSQL.fIncluiCampoObrigatorio('I.ITE_APLICA');

          objLoadSQL.fIncluiSubConsulta('MSGLIV', 'CONCAT(IFNULL(I.ITE_MSGLV1, ""), "<<csq>>", IFNULL(I.ITE_MSGLV2, ""))', 'Mensagem Livre (Texto)');
        End;
      End;

      objLoadSQL.fIncluiCampoObrigatorio('I.AUTOINCREM');

      If (blnFaturamento) Then
        objLoadSQL.fIncluiSubConsulta('ITE_BARRAS_FAT', 'I.ITE_BARRAS', 'Cód. Barras');

      objLoadSQL.pCarregaDadosConsulta;

      objLoadSQL.pSetaParametroStr(':EMPFAT', IIF(blnEmpFat, strCodEmp, strEmpSaldoMatrizCD));
      objLoadSQL.pSetaParametroStr(':EMP_CD', strEmp_CD);
      objLoadSQL.pSetaParametroStr(':CODCLI', strCodCli);
      objLoadSQL.pSetaParametroStr(':CODCMP', strCodCmp);
      objLoadSQL.pSetaParametroStr(':CODCND', strCodCnd);
      objLoadSQL.pSetaParametroStr(':NUMORC', strNumOrc);
      objLoadSQL.pSetaParametroStr(':ESPORC', strEspOrc);

      objLoadSQL.pSetaParametroInt(':TABPRE', StrToIntDef(strTabPre, 1));
      objLoadSQL.pSetaParametroInt(':OPCATI', intOpcAtivos);

      objLoadSQL.pSetaParametroInt(':TIPCON',  fTipoConsultaToInt(opcTipIte));

      objLoadSQL.pSetaParametroFlt(':TAXVPR', fltTaxVpr);
      objLoadSQL.pSetaParametroFlt(':DESFIL', fltDescFidelidade);
      objLoadSQL.pSetaParametroFlt(':COTDOL', fltDolar);

      objLoadSQL.pSetaParametroBln(':EMPMAT', blnEmpFat);
      objLoadSQL.pSetaParametroBln(':EXILIS', blnConsiderarExiLis);

      objLoadSQL.pSetaParametroBln(':MATPRI', blnDepMatPriIndustrial);
      objLoadSQL.pSetaParametroBln(':PROACA', blnDepProAcaIndustrial);
      objLoadSQL.pSetaParametroBln(':PROEMB', blnDepProEmbIndustrial);
      objLoadSQL.pSetaParametroBln(':PROGRA', blnDepProGraIndustrial);
      objLoadSQL.pSetaParametroBln(':EQUENT', blnConEquEnt);
      objLoadSQL.pSetaParametroBln(':SOESTR', blnSomenteEstrutura);

      If blnTemNegocAtiva And blnExibirInfPromoc Then
        ProcAtualizaPrecoNegociacao := pAtualizaPrecoPromocaoNegociado
      Else
        ProcAtualizaPrecoNegociacao := nil;

      objConsulta.pIncluiIgnoreChar('*', '%', 'ITE_BARRAS');
      objConsulta.pIncluiIgnoreChar('*', '%', 'ITE_BARRAS_FAT');
      objConsulta.pIncluiIgnoreChar('*', '%', 'ITEPESQUI');
      objConsulta.pIncluiIgnoreChar('*', '%', 'ITE_FABRIC');
      {objConsulta.pIncluiIgnoreChar('*', '%', 'ITE_DESITE');}

      blnConsultou := untFuncoesGen.fConsulta(objLoadSQL.arrSQL,
                                              objLoadSQL.arrNomeColunas,
                                              [],
                                              '',
                                              'CADITE',
                                              Self.Name,
                                              strTitulo,
                                              qryConsulta,
                                              objFrmPnl,
                                              blnConSim,
                                              arrSel,
                                              fRetCodPes,
                                              objDefConsulta,
                                              blnTablet,
                                              True,
                                              '',
                                              ProcAtualizaPrecoNegociacao,
                                              True,
                                              blnConfirma,
                                              True,
                                              Nil,
                                              objPnlBanner,
                                              objPnlPreFiltro);

      FreeAndNil(objLoadSql);
    End;

begin
  if blnFaturamento and (untFuncoesSimples.fCfgSis('PPFDDI', varString) = '2') then
    strCpoPesqDesc := 'ITEPESQUI'
  else
    strCpoPesqDesc := 'ITE_DESITE';


  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    pCriarModuloLegenda;
    Try
      chrKey := #0;



      {$WARNINGS OFF}
      pIniciaPesqItem(frmModulo.GetCurrentConnection, untFuncoesSimples.strLoginUsuarioLogado, untFuncoesSimples.VS_strCodEmp,
                      untFuncoesSimples.VS_objTraceViewer, DebugHook,
                      untFuncoesSimples.VS_Date, untFuncoesSimples.VS_ComputerNetName, untFuncoesSimples.VS_UserFromWindows,
                      untFuncoesSimples.VS_IPAddressAsString, untFuncoesSimples.VS_MacAddress);
      {$WARNINGS ON}

      blnExiPrecos := True;

      {Requisito 58996 MENIL}
      If (Pos('S', VS_strTabFat) <= 0) And Not fVerificaAcessoSistema('VITBPR') Then
        blnExiPrecos := False;

      fltDolar := fGetUltimaCotacaoDolarVenda;

      blnExibirInfPromoc     := (fCfgSis('CNFTPR', VarBoolean));
      blnExibirEmCampanha    := (Not fEmptyStr(strCodCli)) And (fClienteEmCampanha(strCodCli));
      blnExibirCodProCliente := (blnExibirEmCampanha) And (fCfgSis('CIPCAM', varBoolean)) And (Pos(strOpcDoc, 'PD_OR_VN') > 0);
      blnTemNegocAtiva := ( fCampoTabela('NEG_STATUS', 'CADNEG', ['NEG_STATUS'], ['A'], False) = 'A' );
      blnAcessoTodasAsEmpresas := (Not fCfgSis('ACEMPI', varBoolean));
      blnBEFTRG := fCfgSis('BEFTRG', VarBoolean);

      blnViewDiasSemVenda := fTemViewDiasSemVenda;

      If (Not blnFaturamento) Then
        blnExibirInfPromoc := True;

      intDecUni := fCfgSis('DECUNI', varInteger);
      If intDecUni = 0 Then
        intDecUni := 2
      Else If intDecUni > fTamPrecoIteger Then
        intDecUni := 4;

      intDecQtd    := Max(3, fCfgSis('DECQTD', varInteger));
      blnExcosa    := fCfgSis('EXCOSA', varBoolean) And blnMostraSaldo;
      blnItePDO    := fCfgSis('ITEPDO', VarBoolean);
      blnOrcPen    := fCfgSis('ORCPEN', VarBoolean);
      strPDCPRO    := fCfgSis('PDCPRO', VarString);

      If fEmptyStr(strCodEmp) Then
        strCodEmp := VS_strCodEmp;

      If fEmptyStr(strEmpSaldoMatrizCD) Then
        strEmpSaldoMatrizCD := VS_strCodEmp;

      blnEstExt := fCfgSis('ESTEXT', varBoolean, IIF(blnEmpFat, strCodEmp, strEmpSaldoMatrizCD));

      If fEmptyStr(strTabPre) Then
        strTabPre := '1';

      strTabCli := fCampoTabela('CLI_TABPRE', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);

      If fEmptyStr(strTabCli) And fCfgSis('HIETAB', VarBoolean) Then
        strTabCli := fCampoTabela('OPE_TABPRE', 'CADOPE', ['OPE_CODOPE'], [strCodVen], False);

      If fEmptyStr(strTabCli) Then
        strTabCli := strTabPre;

      SetLength(arrTitCol, 0);

      pDefineConsulta;

      pDefineConsultaConfigurada;

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If Assigned(objFrmPnl) Then
      Begin
        objFrmPnl.blnExibirSaldos := blnMostraSaldo;
        objFrmPnl.blnAlternarModoTab := blnFaturamento;
      End;

      strSQL := fSQLItens;

      objDefConsulta.pAdicionaTabela('CADITE', 'I');
      objDefConsulta.pAdicionaTabela('ITEGER', 'G');

      If TLoadConsultaSQL.fUsaConsultaConfigurada(strTitulo, objLoadSQL, objDefConsulta, False) Then
      Begin

        pTrataConsultaConfigurada;

      End Else

      Begin
        objConsulta.pAdicionaTabela('CADITE', 'I');
        objConsulta.pAdicionaTabela('ITEGER', 'G');

        objConsulta.strChaveConsulta      := TLoadConsultaSQL.fGetChaveConsulta(strTitulo);
        objConsulta.funcConfiguraConsulta := TfrmConfiguraSQLConsultaEdicao.fConfiguraConsulta;

        If blnTemNegocAtiva And blnExibirInfPromoc Then
          ProcAtualizaPrecoNegociacao := pAtualizaPrecoPromocaoNegociado
        Else
          ProcAtualizaPrecoNegociacao := nil;

        objConsulta.pIncluiIgnoreChar('*', '%', 'ITE_BARRAS');
        objConsulta.pIncluiIgnoreChar('*', '%', 'ITE_BARRAS_FAT');
        objConsulta.pIncluiIgnoreChar('*', '%', 'ITEPESQUI');
        objConsulta.pIncluiIgnoreChar('*', '%', 'ITE_FABRIC');
        {objConsulta.pIncluiIgnoreChar('*', '%', 'ITE_DESITE');}

        blnConsultou := untFuncoesGen.fConsulta([strSQL, fSQLWhere + strFiltros],
                   arrTitCol,
                   ['ITE_DESITE', 'MAR_DESMAR', 'ITEAPLICA',
                    'ITE_REFERE', 'ITE_CODFAB', 'ITE_CODITE',
                    'COMSALDO'  , 'EMPROMOC', 'ITE_PDOR', 'ITE_VALIDA'],
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
                   ProcAtualizaPrecoNegociacao,
                   True,
                   blnConfirma,
                   True,
                   Nil,
                   objPnlBanner,
                   objPnlPreFiltro);

      End;

      FreeAndNil(objLoadSQL);

      If blnConsultou Then
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

      If Assigned(objDefConsulta) Then
        pFreeAndNil(objDefConsulta);

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
