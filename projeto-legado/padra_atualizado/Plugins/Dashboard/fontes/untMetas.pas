unit untMetas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untFrameBase, FMX.Layouts, FMX.Objects, FMX.Ani, FMX.Controls.Presentation,
  System.DateUtils, System.StrUtils;

type

  TTipoResultado = (trValor, trQtdPedido, trQtdItem, trQtdProdutos, trQtdCliente);

  TfraMetas = class(TfraBaseFrame)
    Rectangle4: TRectangle;
    Rectangle6: TRectangle;
    LbMetas: TLabel;
    pieBackTotalVendido: TPie;
    FloatAnimation10: TFloatAnimation;
    pieBackVendaProjetada: TPie;
    FloatAnimation11: TFloatAnimation;
    pieBackMeta: TPie;
    FloatAnimation9: TFloatAnimation;
    Layout17: TLayout;
    pieTotalVendido: TPie;
    anmTotalVendido: TFloatAnimation;
    pieVendaProjetada: TPie;
    anmVendaProjetada: TFloatAnimation;
    pieMeta: TPie;
    anmMetaMes: TFloatAnimation;
    Circle2: TCircle;
    Label15: TLabel;
    lblTotalMeta: TLabel;
    lblTotalVendido: TLabel;
    Label17: TLabel;
    lblVendaProjetada: TLabel;
    Label29: TLabel;
    Rectangle1: TRectangle;
    Label30: TLabel;
    Rectangle12: TRectangle;
    FlowLayout6: TFlowLayout;
    lblMediaDiariaParaConcluir: TLabel;
    lblValorMedioAntDesc: TLabel;
    lblMediaDiariaPraticada: TLabel;
    lblValorMedioAtuDesc: TLabel;
    FlowLayout2: TFlowLayout;
    RoundRect1: TRoundRect;
    RoundRect2: TRoundRect;
    RoundRect3: TRoundRect;
    recMetaMargem: TRectangle;
    Rectangle3: TRectangle;
    Layout1: TLayout;
    FlowLayout3: TFlowLayout;
    lblVariacao: TLabel;
    Label2: TLabel;
    lblMargemPraticada: TLabel;
    Label6: TLabel;
    RoundRect5: TRoundRect;
    lblMetaMargem: TLabel;
    Label8: TLabel;
    RoundRect6: TRoundRect;
    Label9: TLabel;
    lblPercTotalVendido: TLabel;
    lblPercVendaProjetada: TLabel;
    Circle1: TCircle;
    pieBackMetaMargem: TPie;
    FloatAnimation1: TFloatAnimation;
    pieBackMargemPraticada: TPie;
    FloatAnimation2: TFloatAnimation;
    pieMetaMargem: TPie;
    anmMetaMargem: TFloatAnimation;
    pieMargemPraticada: TPie;
    anmMargemPraticada: TFloatAnimation;
    FlowLayoutBreak1: TFlowLayoutBreak;
    Rectangle2: TRectangle;
    Rectangle5: TRectangle;
    GridLayout1: TGridLayout;
    grdLayCabecalho: TGridLayout;
    FlowLayout4: TFlowLayout;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    FlowLayout15: TFlowLayout;
    Label7: TLabel;
    Label16: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label10: TLabel;
    Label32: TLabel;
    Label22: TLabel;
    Label24: TLabel;
    Label26: TLabel;
    Label28: TLabel;
    Label31: TLabel;
    Rectangle7: TRectangle;
    FlowLayout5: TFlowLayout;
    Label23: TLabel;
    lblCorrQtdOrcamentos: TLabel;
    Label27: TLabel;
    lblCorrValOrcamentos: TLabel;
    Label25: TLabel;
    lblCorrTickOrcamentos: TLabel;
    Label33: TLabel;
    lblCorrQtdOrcU3M: TLabel;
    Label44: TLabel;
    lblCorrValOrcU3M: TLabel;
    Label46: TLabel;
    lblCorrTickOrcU3M: TLabel;
    Rectangle9: TRectangle;
    FlowLayout7: TFlowLayout;
    Label1: TLabel;
    lblCorrQtdPedidos: TLabel;
    lblCorrPercQtdPedidos: TLabel;
    lblCorrValPedidos: TLabel;
    lblCorrPercValPedidos: TLabel;
    lblCorrTickPedidos: TLabel;
    Label34: TLabel;
    lblCorrQtdPedU3M: TLabel;
    lblCorrPercQtdPedU3M: TLabel;
    lblCorrValPedU3M: TLabel;
    lblCorrPercValPedU3M: TLabel;
    lblCorrTickPedU3M: TLabel;
    Rectangle8: TRectangle;
    FlowLayout8: TFlowLayout;
    Label36: TLabel;
    lblCorrQtdNumeroItens: TLabel;
    Label51: TLabel;
    lblCorrValNumeroItens: TLabel;
    Label49: TLabel;
    Label100: TLabel;
    Label35: TLabel;
    lblCorrQtdNumeroItensU3M: TLabel;
    Label56: TLabel;
    lblCorrValNumeroItensU3M: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Rectangle10: TRectangle;
    FlowLayout9: TFlowLayout;
    Label3: TLabel;
    lblCorrQtdConsumivel: TLabel;
    Label60: TLabel;
    lblCorrValConsumivel: TLabel;
    lblCorrPercValConsumivel: TLabel;
    lblCorrTickConsumivel: TLabel;
    Label37: TLabel;
    lblCorrQtdConsumivelU3M: TLabel;
    Label62: TLabel;
    lblCorrValConsumivelU3M: TLabel;
    lblCorrPercValConsumivelU3M: TLabel;
    lblCorrTickConsumivelU3M: TLabel;
    Rectangle11: TRectangle;
    FlowLayout10: TFlowLayout;
    Label5: TLabel;
    lblCorrQtdClientesTotal: TLabel;
    Label73: TLabel;
    lblCorrValClientesTotal: TLabel;
    Label71: TLabel;
    lblCorrTickClientesTotal: TLabel;
    Label38: TLabel;
    lblCorrQtdClientesTotalU3M: TLabel;
    Label67: TLabel;
    lblCorrValClientesTotalU3M: TLabel;
    Label69: TLabel;
    lblCorrTickClientesTotalU3M: TLabel;
    Rectangle13: TRectangle;
    FlowLayout11: TFlowLayout;
    Label80: TLabel;
    lblCorrQtdClientesReatendidos: TLabel;
    lblCorrPercQtdClientesReatendidos: TLabel;
    lblCorrValClientesReatendidos: TLabel;
    lblCorrPercQtdClientesReatendidos_: TLabel;
    lblCorrTickClientesReatendidos: TLabel;
    Label39: TLabel;
    lblCorrQtdClientesReatendidosU3M: TLabel;
    lblCorrPercQtdClientesReatendidosU3M: TLabel;
    lblCorrValClientesReatendidosU3M: TLabel;
    lblCorrPercQtdClientesReatendidosU3M_: TLabel;
    lblCorrTickClientesReatendidosU3M: TLabel;
    Rectangle14: TRectangle;
    FlowLayout12: TFlowLayout;
    Label91: TLabel;
    lblCorrQtdClientesNovos: TLabel;
    lblCorrPercQtdClientesNovos: TLabel;
    lblCorrValClientesNovos: TLabel;
    lblCorrPercQtdClientesNovos_: TLabel;
    lblCorrTickClientesNovos: TLabel;
    Label40: TLabel;
    lblCorrQtdClientesNovosU3M: TLabel;
    lblCorrPercQtdClientesNovosU3M: TLabel;
    lblCorrValClientesNovosU3M: TLabel;
    Label82: TLabel;
    lblCorrTickClientesNovosU3M: TLabel;
    Rectangle15: TRectangle;
    FlowLayout13: TFlowLayout;
    Label102: TLabel;
    lblCorrQtdClientesChave: TLabel;
    lblCorrPercQtdClientesChave: TLabel;
    lblCorrValClientesChave: TLabel;
    lblCorrPercQtdClientesChave_: TLabel;
    lblCorrTickClientesChave: TLabel;
    Label41: TLabel;
    lblCorrQtdClientesChaveU3M: TLabel;
    lblCorrPercQtdClientesChaveU3M: TLabel;
    lblCorrValClientesChaveU3M: TLabel;
    lblCorrPercQtdClientesChaveU3M_: TLabel;
    lblCorrTickClientesChaveU3M: TLabel;
    Rectangle16: TRectangle;
    FlowLayout14: TFlowLayout;
    Label18: TLabel;
    lblCorrQtdClientesChaveMeta: TLabel;
    lblCorrPercQtdClientesChaveMeta: TLabel;
    lblCorrValClientesChaveMeta: TLabel;
    lblCorrPercValClientesChaveMeta: TLabel;
    lblCorrTickClientesChaveMeta: TLabel;
    Label42: TLabel;
    lblCorrQtdClientesChaveMetaU3M: TLabel;
    lblCorrPercQtdClientesChaveMetaU3M: TLabel;
    lblCorrValClientesChaveMetaU3M: TLabel;
    lblCorrPercValClientesChaveMetaU3M: TLabel;
    lblCorrTickClientesChaveMetaU3M: TLabel;
    Line1: TLine;
    Label14: TLabel;
  private
    FEquipe: Boolean;
    FCodDep: String;
    procedure pAnimarGraficos;
    function fSqlVendasCliente(strSqlCodCli: String;
                               dteDataIni,
                               dteDataFin: TDate): String;
    function fSqlPedidos(enmTipoResultado: TTipoResultado;
                         blnSomentePedidos,
                         blnSomenteConsumiveis: Boolean;
                         enmTipoCliente: TFiltroCliente;
                         dteDataIni,
                         dteDataFin: TDate;
                         blnObterMedia: Boolean = False): String;
    function fTotalMeta(blnMargem: Boolean): Double;
    procedure pCarregaMetasFaturamento();
    procedure pCarregaMetasMargem();
    procedure pCarregaConstrucaoMeta();
  public
    constructor Create(AOwner: TComponent; blnEquipe: Boolean); reintroduce;
    procedure pCarregaDados(); override;
  end;

var
  fraMetas: TfraMetas;

implementation

{$R *.fmx}

{ TfraMetas }

constructor TfraMetas.Create(AOwner: TComponent; blnEquipe: Boolean);
begin
  inherited Create(AOwner);
  FEquipe := blnEquipe;
end;

function TfraMetas.fSqlPedidos(enmTipoResultado: TTipoResultado;
  blnSomentePedidos, blnSomenteConsumiveis: Boolean;
  enmTipoCliente: TFiltroCliente; dteDataIni, dteDataFin: TDate; blnObterMedia: Boolean): String;
var
  strSQL: String;
const
  CLIENTE_CONSUMIDOR = '(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%")';
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';

  If enmTipoCliente = fcChaveMetaAting Then
  Begin
    strSQL := strSQL + '  FGO_CODCLI, ';
    strSQL := strSQL + '  CRF_FATINI, ';
  End;

  Case enmTipoResultado Of
    trValor       : If blnSomenteConsumiveis Then
                      strSQL := strSQL + '  SUM(FDO_TOTITE - FDO_DESESP) AS VALOR '
                    Else
                      strSQL := strSQL + '  SUM(FGO_TOTPRO + FGO_TOTSER - FGO_DESESP) AS VALOR ';
    trQtdPedido,
    trQtdItem     : strSQL := strSQL + '  COUNT(0)  AS VALOR ';
    trQtdProdutos : strSQL := strSQL + '  COUNT(DISTINCT FDO_CODITE) AS VALOR ';
    trQtdCliente  : If enmTipoCliente = fcConsumidor Then
                      strSQL := strSQL + '  COUNT(0) AS VALOR '
                    Else If enmTipoCliente = fcReatendidos Then
                      strSQL := strSQL + '  DISTINCT FGO_CODCLI AS VALOR '
                    Else
                      strSQL := strSQL + '  COUNT(DISTINCT FGO_CODCLI) AS VALOR ';
  End;

  strSQL := strSQL + 'FROM FATGOR G ';
  strSQL := strSQL + 'INNER JOIN EXTGOR ';
  strSQL := strSQL + '  ON FGO_SEQFGO = G.AUTOINCREM ';

  If enmTipoCliente <> fcTodos Then
  Begin
    strSQL := strSQL + 'INNER JOIN CADCLI ';
    strSQL := strSQL + '  ON CLI_CODCLI = FGO_CODCLI ';
  End;

  If enmTipoCliente = fcChaveMetaAting Then
  Begin
    strSQL := strSQL + 'INNER JOIN CRMFAI ';
    strSQL := strSQL + '  ON CRF_CODIGO = CLI_CRMFAI ';
  End;

  If (enmTipoResultado In [trQtdItem, trQtdProdutos]) Or blnSomenteConsumiveis Then
  Begin
    strSQL := strSQL + 'INNER JOIN FATDOR ';
    strSQL := strSQL + '  ON FDO_SEQGER = G.AUTOINCREM ';
  End;

  If blnSomenteConsumiveis Then
  Begin
    strSQL := strSQL + 'INNER JOIN CADITE ';
    strSQL := strSQL + '  ON ITE_CODITE = FDO_CODITE ';
  End;

  strSQL := strSQL + 'WHERE (FGO_TEMBRI = "S" OR FGO_VLRCON <> 0) ';

  If blnSomentePedidos Then
    strSQL := strSQL + '  AND FGO_ESPDOC = "PD" '
  Else
    strSQL := strSQL + '  AND ((FGO_ESPDOC = "OR" AND IFNULL(FGO_TIPFAT, "") <> "PD") OR FGO_ESPDOC = "PD") ';

  strSQL := strSQL + '  AND FGO_DTAENT BETWEEN ' +
            QuotedStr(FormatDateTime('yyyy-mm-dd', dteDataIni)) + ' AND ' +
            QuotedStr(FormatDateTime('yyyy-mm-dd', dteDataFin)) + ' ';

  If blnSomenteConsumiveis Then
    strSQL := strSQL + '  AND ITE_CLACRM = "C" ';

  Case enmTipoCliente Of
    fcConsumidor     : strSQL := strSQL + '  AND ' + CLIENTE_CONSUMIDOR + ' ';
    fcNaoConsumidor  : strSQL := strSQL + '  AND NOT ' + CLIENTE_CONSUMIDOR + ' ';
    fcReatendidos    : strSQL := strSQL + '  AND NOT ' + CLIENTE_CONSUMIDOR + ' ';
    fcNovos          : strSQL := strSQL + '  AND NOT ' + CLIENTE_CONSUMIDOR + ' AND (CLI_PRICOM IS NULL OR CLI_PRICOM >= ' + QuotedStr(FormatDateTime('yyyy-mm-dd', dteDataIni)) + ') ';
    fcChave          : strSQL := strSQL + '  AND CLI_CRMFAI IS NOT NULL ';
  End;

  If Not blnDireitoGeral Then
  Begin
    strSQL := strSQL + '  AND (FGO_CODVEN = ' + QuotedStr(strLogOpe) + ' ';
    If FCodDep <> '' Then
    Begin
      strSQL := strSQL + '   OR FGO_CODVEN IN ';
      strSQL := strSQL + '   (SELECT          ';
      strSQL := strSQL + '      OPE_CODOPE    ';
      strSQL := strSQL + '    FROM            ';
      strSQL := strSQL + '      CADOPE        ';
      strSQL := strSQL + '    WHERE OPE_CODDEP = ' + QuotedStr(FCodDep);
      strSQL := strSQL + '   )';
    End;
    strSQL := strSQL + '  )';
  End;

  strSQL := strSQL + '  AND LOCATE(FGO_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

  If enmTipoCliente = fcChaveMetaAting Then
  Begin
    strSQL := strSQL + 'GROUP BY ';
    strSQL := strSQL + '  FGO_CODCLI, ';
    strSQL := strSQL + '  CRF_FATINI ';
    strSQL := strSQL + 'HAVING VALOR >= (CRF_FATINI / ' +
                       ReplaceStr(ReplaceStr(FloatToStr(fltDiasUteis), '.', ''), ',', '.') + ' * ' +
                       ReplaceStr(ReplaceStr(FloatToStr(fltDiasUteisPassados), '.', ''), ',', '.') + ')';
  End;

  If blnObterMedia Then
    strSQL := 'SELECT ( VALOR / ' + IntToStr(MonthsBetween(dteDataFin, dteDataIni)) +
              ' ) AS VALOR FROM ( ' + strSQL + ' ) TAB';

  If enmTipoCliente = fcReatendidos Then
  Begin
    strSQL := 'SELECT VALOR FROM ('+strSQL+') AS VW_PED WHERE EXISTS (' + fSqlVendasCliente('VALOR', DataAntIni, DataAntFin) + ')';
              
    strSQL := 'SELECT COUNT(DISTINCT VALOR) AS VALOR FROM ('+strSQL+') AS VW_TOT ';
              
    Result := strSQL;
  End;
  Begin
    Result := strSQL;
  End;
  
end;

function TfraMetas.fSqlVendasCliente(strSqlCodCli: String; dteDataIni,
  dteDataFin: TDate): String;
var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT 1 ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVDET D ';
  strSQL := strSQL + '  INNER JOIN MOVGER A ON D.DET_SEQGER = A.AUTOINCREM ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + cnsFiltroFFDVTR;    
  strSQL := strSQL + '      DET_CODCLI = ' + strSqlCodCli + ' ';
  strSQL := strSQL + '  AND DET_DTAENT BETWEEN ' + QuotedStr(FormatDateTime('yyyy-mm-dd', dteDataIni));
  strSQL := strSQL + '  AND ' + QuotedStr(FormatDateTime('yyyy-mm-dd', dteDataFin));
  strSQL := strSQL + '  AND DET_PROEMB <> "S" ';
  strSQL := strSQL + '  AND DET_TIP_FC = "C" ';
  strSQL := strSQL + '  AND DET_CODCLI NOT IN (' + strCliFil + ') ';
  strSQL := strSQL + '  AND ((LOCATE(DET_CLAFIS, ' + QuotedStr(strClaVen) + ') > 0) OR (LOCATE(DET_CLAFIS, ' + QuotedStr(strClaDev) + ') > 0) ';

  If fCfgSis('ENTBRF') = 'S' Then
    strSQL := strSQL + ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + QuotedStr(strClaBri) + ')) '
  Else
    strSQL := strSQL + ') ';

  Result := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQL);
end;

function TfraMetas.fTotalMeta(blnMargem: Boolean): Double;
var
  strSQL: String;
begin
  LbMetas.Text := 'Metas de faturamento (Vendedores)';
  strSQL := '';
  strSQL := strSQL + ' SELECT  ';
  If blnMargem Then
    strSQL := strSQL + '   AVG(MET_MARGEM) AS META '
  Else
    strSQL := strSQL + '   SUM(MET_TOTMET) AS META ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADMET ';
  strSQL := strSQL + ' WHERE MET_MESANO = ' + QuotedStr(FormatDateTime('mmyyyy', dteDtaIni));
  If Not blnDireitoGeral Then
  Begin
    LbMetas.Text := 'Metas de faturamento (Vendedor)';
    strSQL := strSQL + '   AND (MET_CODVEN = ' + QuotedStr(strLogOpe);
    If FEquipe Then
    Begin
      LbMetas.Text := 'Metas de faturamento (Vendedor/Equipe)';
      strSQL := strSQL + '   OR MET_CODVEN IN ';
      strSQL := strSQL + '   (SELECT          ';
      strSQL := strSQL + '      OPE_CODOPE    ';
      strSQL := strSQL + '    FROM            ';
      strSQL := strSQL + '      CADOPE        ';
      strSQL := strSQL + '    WHERE OPE_CODDEP = ' + QuotedStr(FCodDep);
      strSQL := strSQL + '   )';
    End;
    strSQL := strSQL + ')';
  End;

  qryAux.Close;
  qryAux.SQL.Text := strSQL;
  qryAux.Open;

  If qryAux.FieldValue('META') = Null Then
    Result := 0.0
  Else
    Result := qryAux.FieldValue('META');
end;

procedure TfraMetas.pAnimarGraficos;
  Var
    i: Integer;
begin
  for i := 0 to Self.ComponentCount -1 do
  begin
    if (Self.Components[i] is TFloatAnimation) then
    begin
      (Self.Components[i] as TFloatAnimation).Delay    := 0;
      (Self.Components[i] as TFloatAnimation).Duration := 2;
      (Self.Components[i] as TFloatAnimation).Enabled  := True;
    end;
  end;
end;

procedure TfraMetas.pCarregaConstrucaoMeta;
var
  intQtdOrcamento,
  intQtdOrcamentoU3M,
  intQtdVenda,
  intQtdVendaU3M,
  intQtdItensPorVenda,
  intQtdItensPorVendaU3M,
  intQtdConsumivel,
  intQtdConsumivelU3M,
  intQtdTotalClientes,
  intQtdTotalClientesU3M,
  intQtdClientesReatendidos,
  intQtdClientesReatendidosU3M,
  intQtdClientesNovos,
  intQtdClientesNovosU3M,
  intQtdClientesChave,
  intQtdClientesChaveU3M,
  intQtdClientesChaveMeta,
  intQtdClientesChaveMetaU3M: Integer;
  fltValorOrcamento,
  fltValorOrcamentoU3M,
  fltValorVenda,
  fltValorVendaU3M,
  fltTickMedPedido,
  fltTickMedPedidoU3M,
  fltValorConsumivel,
  fltValorConsumivelU3M,
  fltValorClientesReatendidos,
  fltValorClientesReatendidosU3M,
  fltValorClientesNovos,
  fltValorClientesNovosU3M,
  fltValorClientesChave,
  fltValorClientesChaveU3M,
  fltValorClientesChaveMeta,
  fltValorClientesChaveMetaU3M,
  fltValorMetaClientes: Double;

  function fBuscaValor(enmTipoResultado: TTipoResultado;
                       blnSomentePedidos,
                       blnSomenteConsumiveis: Boolean;
                       enmTipoCliente: TFiltroCliente;
                       blnObterMedia: Boolean = False): Double;
  var
    dtaIni, dtaFin: TDate;
  begin
    Result := 0;

    If blnObterMedia Then
    Begin
      dtaIni := DataAntIni;
      dtaFin := DataAntFin;
    End
    Else
    Begin
      dtaIni := dteDtaIni;
      dtaFin := dteDtaFin;
    End;

    qryAux.Close;
    qryAux.SQL.Text := fSqlPedidos(enmTipoResultado,
                                   blnSomentePedidos,
                                   blnSomenteConsumiveis,
                                   enmTipoCliente,
                                   dtaIni,
                                   dtaFin,
                                   blnObterMedia);
    qryAux.Open;

    While (Not qryAux.Eof) Do
    Begin
      If qryAux.FieldValue('VALOR') <> null Then
        Result := Result + qryAux.FieldValue('VALOR');

      qryAux.Next();
    End;
  end;

  function fTotalMetasClientes(): Double;
  var
    strSQL: String;
  begin
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  SUM(CRF_FATINI) AS VALOR ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCLI ';
    strSQL := strSQL + 'INNER JOIN CRMFAI ';
    strSQL := strSQL + '  ON CRF_CODIGO = CLI_CRMFAI ';
    strSQL := strSQL + 'WHERE CLI_STATUS = "A" ';

    Result := 0;

    qryAux.Close;
    qryAux.SQL.Text := strSQL;
    qryAux.Open;

    If qryAux.FieldValue('VALOR') <> null Then
      Result := qryAux.FieldValue('VALOR');
  end;

begin
  // Quantidade de Orcamentos
  intQtdOrcamento := Round(fBuscaValor(trQtdPedido, False, False, fcTodos));
  lblCorrQtdOrcamentos.Text := IntToStr(intQtdOrcamento);

  intQtdOrcamentoU3M := Round(fBuscaValor(trQtdPedido, False, False, fcTodos, True));
  lblCorrQtdOrcU3M.Text := IntToStr(intQtdOrcamentoU3M);

  // Valor dos Orcamentos
  fltValorOrcamento := fBuscaValor(trValor, False, False, fcTodos);
  lblCorrValOrcamentos.Text := FormatFloat('#,##0.00', fltValorOrcamento);
  If intQtdOrcamento > 0 Then
    lblCorrTickOrcamentos.Text := FormatFloat('#,##0.00', fltValorOrcamento / intQtdOrcamento)
  Else
    lblCorrTickOrcamentos.Text := '0,00';

  fltValorOrcamentoU3M := fBuscaValor(trValor, False, False, fcTodos, True);
  lblCorrValOrcU3M.Text := FormatFloat('#,##0.00', fltValorOrcamentoU3M);
  If intQtdOrcamentoU3M > 0 Then
    lblCorrTickOrcU3M.Text := FormatFloat('#,##0.00', fltValorOrcamentoU3M / intQtdOrcamentoU3M)
  Else
    lblCorrTickOrcU3M.Text := '0,00';

  // Quantidade de Pedidos
  intQtdVenda := Round(fGetValorVendas(dteDtaIni, dteDtaFin, trContagem, taNenhum, FCodDep));
  lblCorrQtdPedidos.Text := IntToStr(intQtdVenda);
  If intQtdOrcamento > 0 Then
    lblCorrPercQtdPedidos.Text := IntToStr(Round(intQtdVenda / intQtdOrcamento * 100)) + '%'
  Else
    lblCorrPercQtdPedidos.Text := '0%';

  intQtdVendaU3M := Round(fGetValorVendas(DataAntIni, DataAntFin, trContagem, taMediaDia, FCodDep));
  lblCorrQtdPedU3M.Text := IntToStr(intQtdVendaU3M);
  If intQtdOrcamentoU3M > 0 Then
    lblCorrPercQtdPedU3M.Text :=  IntToStr(Round(intQtdVendaU3M / intQtdOrcamentoU3M * 100)) + '%'
  Else
    lblCorrPercQtdPedU3M.Text := '0%';

  // Valor dos Pedidos
  fltValorVenda := fGetValorVendas(dteDtaIni, dteDtaFin, trValorVenda, taNenhum, FCodDep);
  lblCorrValPedidos.Text := FormatFloat('#,##0.00', fltValorVenda);
  If fltValorOrcamento > 0 Then
    lblCorrPercValPedidos.Text := IntToStr(Round(fltValorVenda / fltValorOrcamento * 100)) + '%'
  Else
    lblCorrPercValPedidos.Text := '0%';
  If intQtdVenda > 0 Then
    fltTickMedPedido := fltValorVenda / intQtdVenda
  Else
    fltTickMedPedido := 0;
  lblCorrTickPedidos.Text := FormatFloat('#,##0.00', fltTickMedPedido);

  fltValorVendaU3M := fGetValorVendas(DataAntIni, DataAntFin, trValorVenda, taMediaDia, FCodDep);
  lblCorrValPedU3M.Text := FormatFloat('#,##0.00', fltValorVendaU3M);
  If fltValorOrcamentoU3M > 0 Then
    lblCorrPercValPedU3M.Text := IntToStr(Round(fltValorVendaU3M / fltValorOrcamentoU3M * 100)) + '%'
  Else
    lblCorrPercValPedU3M.Text := '0%';
  If intQtdVendaU3M > 0 Then
    fltTickMedPedidoU3M := fltValorVendaU3M / intQtdVendaU3M
  Else
    fltTickMedPedidoU3M := 0;
  lblCorrTickPedU3M.Text := FormatFloat('#,##0.00', fltTickMedPedidoU3M);

  // Número médio de itens por pedido
  If intQtdVenda > 0 Then
    intQtdItensPorVenda := Round(fGetValorVendas(dteDtaIni, dteDtaFin, trContagemItem, taNenhum, FCodDep) / intQtdVenda)
  Else
    intQtdItensPorVenda := 0;
  lblCorrQtdNumeroItens.Text := IntToStr(intQtdItensPorVenda);
  If intQtdItensPorVenda > 0 Then
    lblCorrValNumeroItens.Text := FormatFloat('#,##0.00', fltTickMedPedido / intQtdItensPorVenda)
  Else
    lblCorrValNumeroItens.Text := '0,00';

  If intQtdVendaU3M > 0 Then
    intQtdItensPorVendaU3M := Round(fGetValorVendas(DataAntIni, DataAntFin, trContagemItem, taMedia, FCodDep) / intQtdVendaU3M)
  Else
    intQtdItensPorVendaU3M := 0;
  lblCorrQtdNumeroItensU3M.Text := IntToStr(intQtdItensPorVendaU3M);
  If intQtdItensPorVendaU3M > 0 Then
    lblCorrValNumeroItensU3M.Text := FormatFloat('#,##0.00', fltTickMedPedidoU3M / intQtdItensPorVendaU3M)
  Else
    lblCorrValNumeroItensU3M.Text := '0,00';

  // Quantidade de consumiveis
  intQtdConsumivel := Round(fGetValorVendas(dteDtaIni, dteDtaFin, trContagemProdutos, taNenhum, FCodDep, fcTodos, True));
  lblCorrQtdConsumivel.Text := IntToStr(intQtdConsumivel);

  intQtdConsumivelU3M := Round(fGetValorVendas(DataAntIni, DataAntFin, trContagemProdutos, taMedia, FCodDep, fcTodos, True));
  lblCorrQtdConsumivelU3M.Text := IntToStr(intQtdConsumivelU3M);

  // Valor dos consumiveis
  fltValorConsumivel := fGetValorVendas(dteDtaIni, dteDtaFin, trValorVenda, taNenhum, FCodDep, fcTodos, True);
  lblCorrValConsumivel.Text := FormatFloat('#,##0.00', fltValorConsumivel);
  If fltValorVenda > 0 Then
    lblCorrPercValConsumivel.Text := IntToStr(Round(fltValorConsumivel / fltValorVenda * 100)) + '%'
  Else
    lblCorrPercValConsumivel.Text := '0%';
  If intQtdConsumivel > 0 Then
    lblCorrTickConsumivel.Text := FormatFloat('#,##0.00', fltValorConsumivel / intQtdConsumivel)
  Else
    lblCorrTickConsumivel.Text := '0,00';

  fltValorConsumivelU3M := fGetValorVendas(DataAntIni, DataAntFin, trValorVenda, taMedia, FCodDep, fcTodos, True);
  lblCorrValConsumivelU3M.Text := FormatFloat('#,##0.00', fltValorConsumivelU3M);
  If fltValorVendaU3M > 0 Then
    lblCorrPercValConsumivelU3M.Text := IntToStr(Round(fltValorConsumivelU3M / fltValorVendaU3M * 100)) + '%'
  Else
    lblCorrPercValConsumivelU3M.Text := '0%';
  If intQtdConsumivelU3M > 0 Then
    lblCorrTickConsumivelU3M.Text := FormatFloat('#,##0.00', fltValorConsumivelU3M / intQtdConsumivelU3M)
  Else
    lblCorrTickConsumivelU3M.Text := '0,00';

  // Quantidade total de clientes
  intQtdTotalClientes := Round(fGetValorVendas(dteDtaIni, dteDtaFin, trContagemCliente, taNenhum, FCodDep, fcConsumidor));
  intQtdTotalClientes := intQtdTotalClientes + Round(fGetValorVendas(dteDtaIni, dteDtaFin, trContagemCliente, taNenhum, FCodDep, fcNaoConsumidor));
  lblCorrQtdClientesTotal.Text := IntToStr(intQtdTotalClientes);
  lblCorrValClientesTotal.Text := FormatFloat('#,##0.00', fltValorVenda);
  If intQtdTotalClientes > 0 Then
    lblCorrTickClientesTotal.Text := FormatFloat('#,##0.00', fltValorVenda / intQtdTotalClientes)
  Else
    lblCorrTickClientesTotal.Text := '0,00';

  intQtdTotalClientesU3M := Round(fGetValorVendas(DataAntIni, DataAntFin, trContagemCliente, taMedia, FCodDep, fcConsumidor));
  intQtdTotalClientesU3M := intQtdTotalClientesU3M + Round(fGetValorVendas(DataAntIni, DataAntFin, trContagemCliente, taMedia, FCodDep, fcNaoConsumidor));
  lblCorrQtdClientesTotalU3M.Text := IntToStr(intQtdTotalClientesU3M);
  lblCorrValClientesTotalU3M.Text := FormatFloat('#,##0.00', fltValorVendaU3M);
  If intQtdTotalClientesU3M > 0 Then
    lblCorrTickClientesTotalU3M.Text := FormatFloat('#,##0.00', fltValorVendaU3M / intQtdTotalClientesU3M)
  Else
    lblCorrTickClientesTotalU3M.Text := '0,00';

  // Quantidade de clientes reatendidos
  intQtdClientesReatendidos := Round(fGetValorVendas(dteDtaIni, dteDtaFin, trContagemCliente, taNenhum, FCodDep, fcReatendidos));
  lblCorrQtdClientesReatendidos.Text := IntToStr(intQtdClientesReatendidos);
  If intQtdTotalClientes > 0 Then
    lblCorrPercQtdClientesReatendidos.Text := IntToStr(Round(intQtdClientesReatendidos / intQtdTotalClientes * 100)) + '%'
  Else
    lblCorrPercQtdClientesReatendidos.Text := '0%';

  intQtdClientesReatendidosU3M := Round(fGetValorVendas(DataAntIni, DataAntFin, trContagemCliente, taMedia, FCodDep, fcReatendidos));
  lblCorrQtdClientesReatendidosU3M.Text := IntToStr(intQtdClientesReatendidosU3M);
  If intQtdTotalClientesU3M > 0 Then
    lblCorrPercQtdClientesReatendidosU3M.Text := IntToStr(Round(intQtdClientesReatendidosU3M / intQtdTotalClientesU3M * 100)) + '%'
  Else
    lblCorrPercQtdClientesReatendidosU3M.Text := '0%';

  // Valor de pedidos para clientes reatendidos
  fltValorClientesReatendidos := fGetValorVendas(dteDtaIni, dteDtaFin, trValorVenda, taNenhum, FCodDep, fcReatendidos);
  lblCorrValClientesReatendidos.Text := FormatFloat('#,##0.00', fltValorClientesReatendidos);
  If intQtdClientesReatendidos > 0 Then
    lblCorrTickClientesReatendidos.Text := FormatFloat('#,##0.00', fltValorClientesReatendidos / intQtdClientesReatendidos)
  Else
    lblCorrTickClientesReatendidos.Text := '0,00';

  fltValorClientesReatendidosU3M := fGetValorVendas(DataAntIni, DataAntFin, trValorVenda, taMedia, FCodDep, fcReatendidos);
  lblCorrValClientesReatendidosU3M.Text := FormatFloat('#,##0.00', fltValorClientesReatendidosU3M);
  If intQtdClientesReatendidosU3M > 0 Then
    lblCorrTickClientesReatendidosU3M.Text := FormatFloat('#,##0.00', fltValorClientesReatendidosU3M / intQtdClientesReatendidosU3M)
  Else
    lblCorrTickClientesReatendidosU3M.Text := '0,00';

  // Quantidade de clientes novos
  intQtdClientesNovos := Round(fGetValorVendas(dteDtaIni, dteDtaFin, trContagemCliente, taNenhum, FCodDep, fcConsumidor));
  intQtdClientesNovos := intQtdClientesNovos + Round(fGetValorVendas(dteDtaIni, dteDtaFin, trContagemCliente, taNenhum, FCodDep, fcNovos));
  lblCorrQtdClientesNovos.Text := IntToStr(intQtdClientesNovos);
  If intQtdTotalClientes > 0 Then
    lblCorrPercQtdClientesNovos.Text := IntToStr(Round(intQtdClientesNovos / intQtdTotalClientes * 100)) + '%'
  Else
    lblCorrPercQtdClientesNovos.Text := '0%';

  intQtdClientesNovosU3M := Round(fGetValorVendas(DataAntIni, DataAntFin, trContagemCliente, taMedia, FCodDep, fcConsumidor));
  intQtdClientesNovosU3M := intQtdClientesNovosU3M + Round(fGetValorVendas(DataAntIni, DataAntFin, trContagemCliente, taMedia, FCodDep, fcNovos));
  lblCorrQtdClientesNovosU3M.Text := IntToStr(intQtdClientesNovosU3M);
  If intQtdTotalClientesU3M > 0 Then
    lblCorrPercQtdClientesNovosU3M.Text := IntToStr(Round(intQtdClientesNovosU3M / intQtdTotalClientesU3M * 100)) + '%'
  Else
    lblCorrPercQtdClientesNovosU3M.Text := '0%';

  // Valor de pedidos para clientes novos
  fltValorClientesNovos := fGetValorVendas(dteDtaIni, dteDtaFin, trValorVenda, taNenhum, FCodDep, fcNovos);
  lblCorrValClientesNovos.Text := FormatFloat('#,##0.00', fltValorClientesNovos);
  If intQtdClientesNovos > 0 Then
    lblCorrTickClientesNovos.Text := FormatFloat('#,##0.00', fltValorClientesNovos / intQtdClientesNovos)
  Else
    lblCorrTickClientesNovos.Text := '0,00';

  fltValorClientesNovosU3M := fGetValorVendas(DataAntIni, DataAntFin, trValorVenda, taMedia, FCodDep, fcNovos);
  lblCorrValClientesNovosU3M.Text := FormatFloat('#,##0.00', fltValorClientesNovosU3M);
  If intQtdClientesNovosU3M > 0 Then
    lblCorrTickClientesNovosU3M.Text := FormatFloat('#,##0.00', fltValorClientesNovosU3M / intQtdClientesNovosU3M)
  Else
    lblCorrTickClientesNovosU3M.Text := '0,00';

  // Quantidade de clientes chave
  intQtdClientesChave := Round(fGetValorVendas(dteDtaIni, dteDtaFin, trContagemCliente, taNenhum, FCodDep, fcChave));
  lblCorrQtdClientesChave.Text := IntToStr(intQtdClientesChave);
  If intQtdTotalClientes > 0 Then
    lblCorrPercQtdClientesChave.Text := IntToStr(Round(intQtdClientesChave / intQtdTotalClientes * 100)) + '%'
  Else
    lblCorrPercQtdClientesChave.Text := '0%';

  intQtdClientesChaveU3M := Round(fGetValorVendas(DataAntIni, DataAntFin, trContagemCliente, taMedia, FCodDep, fcChave));
  lblCorrQtdClientesChaveU3M.Text := IntToStr(intQtdClientesChaveU3M);
  If intQtdTotalClientesU3M > 0 Then
    lblCorrPercQtdClientesChaveU3M.Text := IntToStr(Round(intQtdClientesChaveU3M / intQtdTotalClientesU3M * 100)) + '%'
  Else
    lblCorrPercQtdClientesChaveU3M.Text := '0%';

  // Valor de pedidos para clientes chave
  fltValorClientesChave := fGetValorVendas(dteDtaIni, dteDtaFin, trValorVenda, taNenhum, FCodDep, fcChave);
  lblCorrValClientesChave.Text := FormatFloat('#,##0.00', fltValorClientesChave);
  If intQtdClientesChave > 0 Then
    lblCorrTickClientesChave.Text := FormatFloat('#,##0.00', fltValorClientesChave / intQtdClientesChave)
  Else
    lblCorrTickClientesChave.Text := '0,00';

  fltValorClientesChaveU3M := fGetValorVendas(DataAntIni, DataAntFin, trValorVenda, taMedia, FCodDep, fcChave);
  lblCorrValClientesChaveU3M.Text := FormatFloat('#,##0.00', fltValorClientesChaveU3M);
  If intQtdClientesChaveU3M > 0 Then
    lblCorrTickClientesChaveU3M.Text := FormatFloat('#,##0.00', fltValorClientesChaveU3M / intQtdClientesChaveU3M)
  Else
    lblCorrTickClientesChaveU3M.Text := '0,00';

  // Quantidade de clientes chave com meta proporcional
  intQtdClientesChaveMeta := Round(fGetValorVendas(dteDtaIni, dteDtaFin, trContagemCliente, taNenhum, FCodDep, fcChaveMetaAting));
  lblCorrQtdClientesChaveMeta.Text := IntToStr(intQtdClientesChaveMeta);
  If intQtdClientesChave > 0 Then
    lblCorrPercQtdClientesChaveMeta.Text := IntToStr(Round(intQtdClientesChaveMeta / intQtdClientesChave * 100)) + '%'
  Else
    lblCorrPercQtdClientesChaveMeta.Text := '0%';

  intQtdClientesChaveMetaU3M := Round(fGetValorVendas(DataAntIni, DataAntFin, trContagemCliente, taMedia, FCodDep, fcChaveMetaAting));
  lblCorrQtdClientesChaveMetaU3M.Text := IntToStr(intQtdClientesChaveMetaU3M);
  If intQtdClientesChaveU3M > 0 Then
    lblCorrPercQtdClientesChaveMetaU3M.Text := IntToStr(Round(intQtdClientesChaveMetaU3M / intQtdClientesChaveU3M * 100)) + '%'
  Else
    lblCorrPercQtdClientesChaveMetaU3M.Text := '0%';

  // Valor de pedidos para clientes chave com meta proporcional
  fltValorClientesChaveMeta := fGetValorVendas(dteDtaIni, dteDtaFin, trValorVenda, taNenhum, FCodDep, fcChaveMetaAting, False, True);
  fltValorMetaClientes := fTotalMetasClientes();
  lblCorrValClientesChaveMeta.Text := FormatFloat('#,##0.00', fltValorClientesChaveMeta);
  If fltValorMetaClientes > 0 Then
    lblCorrPercValClientesChaveMeta.Text := IntToStr(Round(fltValorClientesChaveMeta / fltValorMetaClientes * 100)) + '%'
  Else
    lblCorrPercValClientesChaveMeta.Text := '0%';
  If intQtdClientesChaveMeta > 0 Then
    lblCorrTickClientesChaveMeta.Text := FormatFloat('#,##0.00', fltValorClientesChaveMeta / intQtdClientesChaveMeta)
  Else
    lblCorrTickClientesChaveMeta.Text := '0,00';

  If intQtdClientesChaveMetaU3M > 0 Then
    fltValorClientesChaveMetaU3M := fGetValorVendas(DataAntIni, DataAntFin, trValorVenda, taMedia, FCodDep, fcChaveMetaAting, False, True)
  Else
    fltValorClientesChaveMetaU3M := 0;

  fltValorMetaClientes := fTotalMetasClientes();
  lblCorrValClientesChaveMetaU3M.Text := FormatFloat('#,##0.00', fltValorClientesChaveMetaU3M);
  If fltValorMetaClientes > 0 Then
    lblCorrPercValClientesChaveMetaU3M.Text := IntToStr(Round(fltValorClientesChaveMetaU3M / fltValorMetaClientes * 100)) + '%'
  Else
    lblCorrPercValClientesChaveMetaU3M.Text := '0%';
  If intQtdClientesChaveMetaU3M > 0 Then
    lblCorrTickClientesChaveMetaU3M.Text := FormatFloat('#,##0.00', fltValorClientesChaveMetaU3M / intQtdClientesChaveMetaU3M)
  Else
    lblCorrTickClientesChaveMetaU3M.Text := '0,00';
end;

procedure TfraMetas.pCarregaDados;
begin
  inherited;
  pIniciaVariaveis();

  If FEquipe Then
    FCodDep := strCodDeptoUsuarioLogado
  Else
    FCodDep := '';

  pCarregaMetasFaturamento();
  If fTemDireitoAcesso('DASHBOARD_VER_MARGEM') Then
    pCarregaMetasMargem()
  Else
    recMetaMargem.Destroy;

  pCarregaConstrucaoMeta();

  pAnimarGraficos();
end;

procedure TfraMetas.pCarregaMetasFaturamento;
var
  fltTotalMeta,
  fltTotalVendido,
  fltTotalProjetado,
  fltMaior,
  fltValPorGrau: Double;
begin
  fltTotalMeta := fTotalMeta(False);

  qryAux.Close;
  qryAux.SQL.Text := fSQLVendas(dteDtaIni, dteDtaFin, trValorVenda, taNenhum, FCodDep);
  qryAux.Open;

  If qryAux.FieldValue('VALOR') = Null Then
    fltTotalVendido := 0.0
  Else
    fltTotalVendido := qryAux.FieldValue('VALOR');

  fltTotalProjetado := (fltTotalVendido / fltDiasUteisPassados) * fltDiasUteis;

  If (fltTotalVendido > fltTotalMeta) And (fltTotalVendido > fltTotalProjetado) Then
    fltMaior := fltTotalVendido
  Else If fltTotalProjetado > fltTotalMeta Then
    fltMaior := fltTotalProjetado
  Else
    fltMaior := fltTotalMeta;

  fltValPorGrau := fltMaior / 270;
  If fltValPorGrau = 0 Then
    fltValPorGrau := 1;

  anmTotalVendido.StopValue := fltTotalVendido / fltValPorGrau;
  anmVendaProjetada.StopValue := fltTotalProjetado / fltValPorGrau;
  anmMetaMes.StopValue := fltTotalMeta / fltValPorGrau;

  lblTotalVendido.Text := 'R$ ' + FormatFloat('#,##0.00', fltTotalVendido);
  If fltTotalMeta > 0 Then
    lblPercTotalVendido.Text := FormatFloat('0', (fltTotalVendido / fltTotalMeta) * 100) + '%'
  Else
    lblPercTotalVendido.Text := '';
  lblVendaProjetada.Text := 'R$ ' + FormatFloat('#,##0.00', fltTotalProjetado);
  If fltTotalMeta > 0 Then
    lblPercVendaProjetada.Text := FormatFloat('0', (fltTotalProjetado / fltTotalMeta) * 100) + '%'
  Else
    lblPercVendaProjetada.Text := '';
  lblTotalMeta.Text := 'R$ ' + FormatFloat('#,##0.00', fltTotalMeta);

  If fltDiasRestantes > 0 Then
    lblMediaDiariaParaConcluir.Text := 'R$ ' + FormatFloat('#,##0.00', (fltTotalMeta - fltTotalVendido) / fltDiasRestantes)
  Else
    lblMediaDiariaParaConcluir.Text := 'R$ ' + FormatFloat('#,##0.00', (fltTotalMeta - fltTotalVendido));
  lblMediaDiariaPraticada.Text := 'R$ ' + FormatFloat('#,##0.00', fltTotalVendido / fltDiasUteisPassados);
end;

procedure TfraMetas.pCarregaMetasMargem;
var
  fltMetaMargem,
  fltMargemPraticada,
  fltMaior,
  fltValPorGrau: Double;
begin
  fltMetaMargem := fTotalMeta(True);

  qryAux.Close;
  qryAux.SQL.Text := fSQLVendas(dteDtaIni, dteDtaFin, trMargemLucro, taNenhum, FCodDep);
  qryAux.Open;

  If qryAux.FieldValue('VALOR') = Null Then
    fltMargemPraticada := 0.0
  Else
    fltMargemPraticada := qryAux.FieldValue('VALOR');

  If fltMargemPraticada > fltMetaMargem Then
    fltMaior := fltMargemPraticada
  Else
    fltMaior := fltMetaMargem;

  fltValPorGrau := fltMaior / 270;
  If fltValPorGrau = 0 Then
    fltValPorGrau := 1;

  anmMargemPraticada.StopValue := fltMargemPraticada / fltValPorGrau;
  anmMetaMargem.StopValue := fltMetaMargem / fltValPorGrau;

  lblMargemPraticada.Text := FormatFloat('0', fltMargemPraticada) + '%';
  lblMetaMargem.Text := FormatFloat('0', fltMetaMargem) + '%';
  lblVariacao.Text := FormatFloat('0', fltMargemPraticada - fltMetaMargem) + '%';

  If fltMargemPraticada < fltMetaMargem Then
    lblVariacao.FontColor := $FFC56C6C
  Else
    lblVariacao.FontColor := $FF60B1CC;
end;

end.
