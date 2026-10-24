unit untMapaDeInventarioParaColetores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, Vcl.Mask, MaskEditFocus, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid,
  untFuncoesConsulta, untTypesSistema, untFuncoesSimples, untConsultas, untZClient,
  cxContainer, cxProgressBar, MemDS, DBAccess, Uni, cxButtonEdit, cxCurrencyEdit,
  untILiberacao, untLiberacaoFactory,  cxCheckBox, Types, untMapaDeColetoresEscolhaReinciaContagem;

type
  TTipoEstadoConferencia = (tpecNaoIniciado, tpecIniciado, tpecConcluido, tpeCDivergente);
  TTipoDireito = (tpReinicioContagem, tpExclusao);

  TfrmMapaDeInventarioParaColetores = class(TfrmPai)
    Panel1: TPanel;
    edtApartamento: TEditFocus;
    edtAndar: TEditFocus;
    edtPredio: TEditFocus;
    edtRua: TEditFocus;
    edtLocFis: TEditFocus;
    Label1: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    mskLinhaGrupo: TMaskEditFocus;
    edtDesGrupo: TEditFocus;
    Label12: TLabel;
    edtFornecedor: TEditFocus;
    edtDesFornecedor: TEditFocus;
    Label13: TLabel;
    edtMarca: TEditFocus;
    edtDesMarca: TEditFocus;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    edtDesOpe: TEditFocus;
    edtCodOpe: TEditFocus;
    cxgDados: TcxGridDBTableViewCitel;
    cxlDados: TcxGridLevel;
    cxDados: TcxGridCitel;
    btnNovoMapa: TBitBtnLocked;
    btnReiniciarContagem: TBitBtnLocked;
    btnTrocaOperador: TBitBtnLocked;
    dtsDados: TDataSource;
    cxgDadosColumn1: TcxGridDBColumn;
    cxgDadosColumn2: TcxGridDBColumn;
    cxgDadosColumn3: TcxGridDBColumn;
    cxgDadosColumn4: TcxGridDBColumn;
    cxgDadosColumn5: TcxGridDBColumn;
    btnExcluirInventario: TBitBtnLocked;
    btnBusca: TBitBtnLocked;
    cxgDetalhes: TcxGridDBTableViewCitel;
    cxlDetalhe: TcxGridLevel;
    cxgDetalhe: TcxGridDBTableViewCitel;
    dtsDetalhes: TDataSource;
    cxgDetalheMPD_LOCFIS: TcxGridDBColumn;
    cxgDetalheMPD_CODITE: TcxGridDBColumn;
    cxgDetalheITE_DESITE: TcxGridDBColumn;
    cxgDetalheMPD_QTDCON: TcxGridDBColumn;
    cxgDetalheLOT_DTAVAL: TcxGridDBColumn;
    cxgDetalheMPG_CODOPE: TcxGridDBColumn;
    cxgDetalheLOT_NUMLOT: TcxGridDBColumn;
    cxgDadosColumn6: TcxGridDBColumn;
    cxgDetalheMPD_NUMCON: TcxGridDBColumn;
    cxgDetalheCOD_STATUS: TcxGridDBColumn;
    Panel2: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Concluído: TLabel;
    cxgDetalheMDP_STATUS: TcxGridDBColumn;
    cxgDetalheOPE_NOMOPE: TcxGridDBColumn;
    cxgDetalheSALDOS: TcxGridDBColumn;
    btnExpandir: TBitBtnLocked;
    btnRetrai: TBitBtnLocked;
    pnlLegendas: TPanel;
    pnlOpeResp: TPanel;
    Label14: TLabel;
    edtCodOpeResp: TEditFocus;
    edtNomOpeResp: TEditFocus;
    btnReiniciaContagemLoc: TBitBtnLocked;
    cxgDetalheSTATUS: TcxGridDBColumn;
    cxgDetalheLINDES_STATUS: TcxGridDBColumn;
    cxgDetalheITE_CODFAB: TcxGridDBColumn;
    shpConcluido: TShape;
    shpDivergente: TShape;
    shpIniciado: TShape;
    shpNaoInciaido: TShape;
    procedure edtCodOpeKeyPress(Sender: TObject; var Key: Char);
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnNovoMapaClick(Sender: TObject);
    procedure btnBuscaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxgDadosColumn1GetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnReiniciarContagemClick(Sender: TObject);
    procedure btnTrocaOperadorClick(Sender: TObject);
    procedure btnExcluirInventarioClick(Sender: TObject);
    procedure cxgDadosColumn6PropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnReiniciaContagemLocClick(Sender: TObject);
    procedure cxgDetalheCustomDrawGroupCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableCellViewInfo;
      var ADone: Boolean);
    procedure cxGrid1DBTableView1GroupGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: String);
    procedure cxgDetalheCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgDetalheFocusedItemChanged(Sender: TcxCustomGridTableView;
      APrevFocusedItem, AFocusedItem: TcxCustomGridTableItem);
    procedure cxgDetalheFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure btnExpandirClick(Sender: TObject);
    procedure btnRetraiClick(Sender: TObject);
    procedure edtCodOpeRespKeyPress(Sender: TObject; var Key: Char);
    procedure cxgDadosFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);

  private
    qryFiltroMapDet : TUniQuery;
    qryCommand : TUniQuery;
    OpcReiniciaContagem: TOpcReiniciaContagem;

    arrLinGru: TConsultasArray;
    arrProdut: TConsultasArray;
    arrCodOpe: TConsultasArray;
    arrLinFor: TConsultasArray;
    arrLinMar: TConsultasArray;
    arrOpeRsp: TConsultasArray;

    strLocFisSel: String;
    strStatusSel: String;
    strLinFor: String;
    strCodOpe: String;
    strProdut: String;
    strLinGru: String;
    strLinMar: String;
    qryMapa: TZClient;
    qryMapaDetalhe: TZClient;
    blnEntFut: Boolean;
    intConEst: Integer;
    strNovoOperadorInventarioDivergente: String;
    procedure pSetaParametros(qryDestino: TZClient);
    procedure pInsereParametrosNoSql(qryDestino: TZClient);
    procedure pSetInsereParametrosNoSql(qryDestino: TZClient);
    procedure pInsereDivergenciaGeral;
    procedure pInsereDivergenciaLocFis;
    procedure pSetSQLInsertMatDet;



    procedure pPreparaConsulta;
    procedure pSetSQLBase(qryDestino: TZClient);

    procedure pReinciaContagem;
    procedure pZeraInvetario(blnExluiContagem: Boolean = False);

    procedure pTrocaOperador(blnZeraContagem: Boolean = False);
    function fValidaOperador(Sender: TWinControl): Boolean;
    function fValidaOperadorResp(Sender: TWinControl): Boolean;
    function fValidaLinhaGrupo(Sender: TWinControl): Boolean;
    function fValidaLinhaMarca(Sender: TWinControl): Boolean;
    function fValidaLinhaFornecedor(Sender: TWinControl): Boolean;
    function fValidaLinhaCodIte(Sender: TWinControl): Boolean;
    procedure pInsereNovaContagemInventario(blnGeral: Boolean = True);
    function  fGeraInventarioDivergentes(pgbStatus: TcxProgressBar = Nil): Boolean;
    procedure pSelecionaReplicacoes(blnGeral: Boolean);
    procedure pReiniciaContagemLocFis(blnApenasLocFis: Boolean);

    function fValidaDireito(tipDireito: TTipoDireito): Boolean;



    { Private declarations }
  protected
    function fCodToTipoEstadoConferencia(value: integer):TTipoEstadoConferencia;
    function fStrToTipoEstadoConferencia(value: String): TTipoEstadoConferencia;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pExecutaTrocaDeOperador(strSeqMapGer: String; strNovoOperador: String);
    procedure pExecutaTrocaDeOperadorResponsavel(strSeqMapGer: String; strNovoOperador: String);

  public

    { Public declarations }
  end;

var
  frmMapaDeInventarioParaColetores: TfrmMapaDeInventarioParaColetores;

implementation

uses
  untGeradorMapaDeInventarioParaColetores, untGravando, untTrocaOperador, System.StrUtils;


{$R *.dfm}

procedure TfrmMapaDeInventarioParaColetores.pExecutaTrocaDeOperador(
  strSeqMapGer, strNovoOperador: String);
  var
  qryComand: TUniQuery;
begin
  qryComand := fCriaQuery;
  Try
    qryComand.SQL.Text := 'UPDATE MAPGER SET MPG_CODOPE = :CODOPE WHERE AUTOINCREM = :AUTINC';
    qryComand.ParamByName('CODOPE').AsString :=  strNovoOperador;
    qryComand.ParamByName('AUTINC').AsString :=  strSeqMapGer;
    qryComand.ExecSQL;
  Finally
    freeAndNil(qryComand);
  End;

end;

procedure TfrmMapaDeInventarioParaColetores.pExecutaTrocaDeOperadorResponsavel(
  strSeqMapGer, strNovoOperador: String);
  var
  qryComand: TUniQuery;
begin
  qryComand := fCriaQuery;
  Try
    Try
      fStartTransaction;
      qryComand.SQL.Clear;
      qryComand.SQL.Text := 'UPDATE MAPGER SET MPG_CODOPE = :CODOPE WHERE AUTOINCREM = :AUTINC';
      qryComand.ParamByName('CODOPE').AsString :=  strNovoOperador;
      qryComand.ParamByName('AUTINC').AsString :=  strSeqMapGer;

      qryComand.ExecSQL;

      qryComand.SQL.Clear;
      qryComand.SQL.Text := 'UPDATE MAPDET SET MPD_CODOPE = :CODOPE WHERE MPD_SEQGER = :AUTINC AND MPD_STATUS IN ("A", "N")';
      qryComand.ParamByName('CODOPE').AsString :=  strNovoOperador;
      qryComand.ParamByName('AUTINC').AsString :=  strSeqMapGer;
      qryComand.ExecSQL;

      fCommit;

      pMensagemOk('Operador responsável trocado com sucesso');
    Except On
      E:Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.message, '[TfrmMapaDeInventarioParaColetores.pExecutaTrocaDeOperadorResponsavel]');
      End;
    End;
  Finally
    FreeAndNil(qryComand);
  End;
end;

procedure TfrmMapaDeInventarioParaColetores.pInsereParametrosNoSql(qryDestino: TZClient);
begin
  pSetInsereParametrosNoSql(qryDestino);
end;

procedure TfrmMapaDeInventarioParaColetores.pSetInsereParametrosNoSql(qryDestino: TZClient);
Begin
  If edtLocFis.Text <> '' Then
    qryDestino.qryQuery.SQL.Add('   AND MPD_LOCFIS LIKE "' + edtLocFis.Text + '%"')  ;

  If edtRua.Text <> '' Then
    qryDestino.qryQuery.SQL.Add('   AND LOCATE(LOC_R_U_A_, "' + StringReplace(edtRua.Text, ',', '_', [rfReplaceAll]) + '") > 0');
  If edtPredio.Text <> '' Then
    qryDestino.qryQuery.SQL.Add('   AND LOCATE(LOC_PREDIO, "' + StringReplace(edtPredio.Text, ',', '_', [rfReplaceAll]) + '") > 0');
  If edtAndar.Text <> '' Then
    qryDestino.qryQuery.SQL.Add('   AND LOCATE(LOC_ANDAR_, "' + StringReplace(edtAndar.Text, ',', '_', [rfReplaceAll]) + '") > 0');
  If edtApartamento.Text <> '' Then
    qryDestino.qryQuery.SQL.Add('   AND LOCATE(LOC_APARTA, "' + StringReplace(edtApartamento.Text, ',', '_', [rfReplaceAll]) + '") > 0');
End;

procedure TfrmMapaDeInventarioParaColetores.pInsereDivergenciaGeral;
begin
  qryMapa.qryQuery.SQL.Add('IF((SELECT COUNT(1) FROM MAPGER MG2');
  qryMapa.qryQuery.SQL.Add('  INNER JOIN MAPDET MD2 ON MD2.MPD_SEQGER = MG2.AUTOINCREM  AND MD2.MPD_STATUS <> "F"');
  qryMapa.qryQuery.SQL.Add('  INNER JOIN ITEGER G2 ON G2.ITE_CODITE = MD2.MPD_CODITE AND G2.ITE_CODEMP = MG2.MPG_CODEMP');
  qryMapa.qryQuery.SQL.Add('  INNER JOIN CADITE C2 ON C2.ITE_CODITE = MD2.MPD_CODITE');
  qryMapa.qryQuery.SQL.Add('  INNER JOIN CADOPE OP2 ON OP2.OPE_CODOPE = MG2.MPG_CODOPE');
  qryMapa.qryQuery.SQL.Add('   LEFT JOIN CADLOT L2 ON L2.LOT_CODITE = MD2.MPD_CODITE  AND L2.LOT_NUMLOT = MD2.MPD_NUMLOT  AND L2.LOT_CODEMP = MG2.MPG_CODEMP');
  qryMapa.qryQuery.SQL.Add('   LEFT JOIN CADLOC ON LOC_CODLOC = LOT_LOCFIS  AND LOC_CODEMP = LOT_CODEMP');
  qryMapa.qryQuery.SQL.Add(' WHERE MG2.AUTOINCREM = TMP.AUTOINCREM');
  qryMapa.qryQuery.SQL.Add('   AND MD2.MPD_STATUS = "D") > 0, "Sim", "Não") AS DIVERGENCIA_GERAL,');
end;


procedure TfrmMapaDeInventarioParaColetores.pInsereDivergenciaLocFis;
begin

  qryMapaDetalhe.qryQuery.SQL.Add('       CASE WHEN MPD_STATUS = "D" THEN "Divergente" ');
  qryMapaDetalhe.qryQuery.SQL.Add('            WHEN MPD_STATUS = "C" THEN "Concluído" ');
  qryMapaDetalhe.qryQuery.SQL.Add('            WHEN MPD_STATUS = "N" THEN "Não Iniciado" ');
  qryMapaDetalhe.qryQuery.SQL.Add('            WHEN MPD_STATUS = "A" THEN "Em Andamento" ');
  qryMapaDetalhe.qryQuery.SQL.Add('       END LINDES_STATUS, ');

  qryMapaDetalhe.qryQuery.SQL.Add('@QTD_TOT          := (SELECT COUNT(1) FROM MAPDET WHERE MPD_SEQGER = MG.AUTOINCREM AND MPD_STATUS <> "F" AND MPD_LOCFIS = MD.MPD_LOCFIS ) AS QTD_TOT,');
  qryMapaDetalhe.qryQuery.SQL.Add('@QTD_NAO_INICIADO := (SELECT COUNT(1) FROM MAPDET WHERE MPD_SEQGER = MG.AUTOINCREM AND MPD_STATUS = "N" AND MPD_LOCFIS = MD.MPD_LOCFIS ) AS QTD_NAO_INICIADO,');
  qryMapaDetalhe.qryQuery.SQL.Add('@QTD_ANDAMENTO   := (SELECT COUNT(1) FROM MAPDET WHERE MPD_SEQGER = MG.AUTOINCREM AND MPD_STATUS = "A" AND MPD_LOCFIS = MD.MPD_LOCFIS ) AS QTD_ANDAMENTO,');
  qryMapaDetalhe.qryQuery.SQL.Add('@QTD_CONCLUIDO   := (SELECT COUNT(1) FROM MAPDET WHERE MPD_SEQGER = MG.AUTOINCREM AND MPD_STATUS = "C" AND MPD_LOCFIS = MD.MPD_LOCFIS ) AS QTD_CONCLUIDO,');
  qryMapaDetalhe.qryQuery.SQL.Add('@QTD_DIVERGENTE  := (SELECT COUNT(1) FROM MAPDET WHERE MPD_SEQGER = MG.AUTOINCREM AND MPD_STATUS = "D" AND MPD_LOCFIS = MD.MPD_LOCFIS ) AS QTD_DIVERGENTE,');
  qryMapaDetalhe.qryQuery.SQL.Add('CAST(IF(@QTD_DIVERGENTE > 0, "Divergente", IF(@QTD_CONCLUIDO = @QTD_TOT, "Concluído", IF(@QTD_NAO_INICIADO = @QTD_TOT, "Não Iniciado", "Em Andamento" ))) AS CHAR(15)) AS STATUS,');
  qryMapaDetalhe.qryQuery.SQL.Add('CAST(CONCAT("(Status:", IF(@QTD_DIVERGENTE > 0, 3, IF(@QTD_CONCLUIDO = @QTD_TOT, 2, IF(@QTD_NAO_INICIADO = @QTD_TOT, 0, 1 ))), ")", MPD_LOCFIS) AS CHAR(90)) AS COD_STATUS,');
end;

procedure TfrmMapaDeInventarioParaColetores.pPreparaConsulta;
begin

  qryMapa.qryQuery.SQL.Clear;

  qryMapa.qryQuery.SQL.Add('SELECT TMP.AUTOINCREM, TMP.AUTOINCREM AS KEY_MAPGER,TMP.MPG_NUMINV, TMP.MPG_CODOPE, TMP.OPE_NOMOPE ,IF(SUM(TEM_DIFERENCA) > 0, "Sim", "Não") AS DIFERE,  ');
  qryMapa.qryQuery.SQL.Add('       @QTD_TOT := (SELECT COUNT(1) FROM MAPDET WHERE MPD_SEQGER = TMP.AUTOINCREM),');
  pInsereDivergenciaGeral;
  qryMapa.qryQuery.SQL.Add('       @QTD_NAO_INICIADO := (SELECT COUNT(1) FROM MAPDET WHERE MPD_SEQGER = TMP.AUTOINCREM AND MPD_STATUS = "N"),');
  qryMapa.qryQuery.SQL.Add('       @QTD_ANDAMENTO := (SELECT COUNT(1) FROM MAPDET WHERE MPD_SEQGER = TMP.AUTOINCREM AND MPD_STATUS = "A"),');
  qryMapa.qryQuery.SQL.Add('       @QTD_CONCLUIDO := (SELECT COUNT(1) FROM MAPDET WHERE MPD_SEQGER = TMP.AUTOINCREM AND MPD_STATUS = "C"),');
  qryMapa.qryQuery.SQL.Add('       IF(@QTD_CONCLUIDO = @QTD_TOT, "Concluído", IF(@QTD_NAO_INICIADO = @QTD_TOT, "Não Iniciado", "Em Andamento" )) AS STATUS, ');
  qryMapa.qryQuery.SQL.Add('       IF(@QTD_CONCLUIDO = @QTD_TOT, 2, IF(@QTD_NAO_INICIADO = @QTD_TOT, 0, 1 )) AS COD_STATUS,');

  qryMapa.qryQuery.SQL.Add('       @MAX_NUMCON := (SELECT MAX(MPD_NUMCON) FROM MAPDET WHERE MPD_SEQGER = TMP.AUTOINCREM) MAX_NUMCON,');
  qryMapa.qryQuery.SQL.Add('       @QTD_TOT_MAXNUMCOM := (SELECT COUNT(1) FROM MAPDET WHERE MPD_SEQGER = TMP.AUTOINCREM AND MPD_NUMCON = @MAX_NUMCON) QTD_TOT_MAXNUMCOM,');
  qryMapa.qryQuery.SQL.Add('       @QTD_NAOINI_MAXNUMCOM := (SELECT COUNT(1) FROM MAPDET WHERE MPD_SEQGER = TMP.AUTOINCREM AND MPD_STATUS = "N" AND MPD_NUMCON = @MAX_NUMCON) QTD_NAOINI_MAXNUMCOM,');
  qryMapa.qryQuery.SQL.Add('       @QTD_ANDAMENTO_MAXNUMCOM := (SELECT COUNT(1) FROM MAPDET WHERE MPD_SEQGER = TMP.AUTOINCREM AND MPD_STATUS = "A" AND MPD_NUMCON = @MAX_NUMCON) QTD_ANDAMENTO,');
  qryMapa.qryQuery.SQL.Add('       @QTD_CONCLUIDA_MAXNUMCOM := (SELECT COUNT(1) FROM MAPDET WHERE MPD_SEQGER = TMP.AUTOINCREM AND MPD_STATUS IN ("C","D") AND MPD_NUMCON = @MAX_NUMCON) QTD_CONCLUIDA_MAXNUMCOM,');

  qryMapa.qryQuery.SQL.Add('       CASE WHEN @QTD_TOT_MAXNUMCOM = @QTD_NAOINI_MAXNUMCOM THEN "Não Iniciado" WHEN @QTD_TOT_MAXNUMCOM = @QTD_CONCLUIDA_MAXNUMCOM THEN "Concluído"');
  qryMapa.qryQuery.SQL.Add('            WHEN (@QTD_NAOINI_MAXNUMCOM > 0 OR @QTD_CONCLUIDA_MAXNUMCOM > 0 OR @QTD_ANDAMENTO_MAXNUMCOM > 0) THEN "Em Andamento" ELSE ""');
  qryMapa.qryQuery.SQL.Add('       END STATUS_MAXNUMCOM');

  qryMapa.qryQuery.SQL.Add('FROM (');

  pSetSQLBase(qryMapa);

  qryMapa.qryQuery.SQL.Add(') TMP');

  qryMapa.qryQuery.SQL.Add(' GROUP BY AUTOINCREM');

  pSetaParametros(qryMapa);

  qryMapaDetalhe.qryQuery.SQL.Clear;
  pSetSQLBase(qryMapaDetalhe);

  qryMapaDetalhe.qryQuery.SQL.Add('ORDER BY MG.AUTOINCREM, MD.MPD_LOCFIS, MPD_NUMCON,  MPD_CODITE, LOT_NUMLOT');
  pSetaParametros(qryMapaDetalhe);
end;

procedure TfrmMapaDeInventarioParaColetores.pSetSQLBase(qryDestino: TZClient);
Begin
  qryDestino.qryQuery.SQL.Add('SELECT MG.MPG_NUMINV,');
  qryDestino.qryQuery.SQL.Add('       MG.AUTOINCREM,');
  qryDestino.qryQuery.SQL.Add('       MG.MPG_CODOPE,');
  qryDestino.qryQuery.SQL.Add('       MD.MPD_SEQGER AS KEY_MAPGER,');
  qryDestino.qryQuery.SQL.Add('       MD.AUTOINCREM AS KEY_MAPDET,');
  qryDestino.qryQuery.SQL.Add('       OPE_NOMOPE,');
  qryDestino.qryQuery.SQL.Add('       MPD_LOCFIS,');
  qryDestino.qryQuery.SQL.Add('       ITE_CODFAB,');
  qryDestino.qryQuery.SQL.Add('       MPD_CODITE,');
  qryDestino.qryQuery.SQL.Add('       MPD_CODOPE,');
  qryDestino.qryQuery.SQL.Add('       ITE_DESITE,');
  qryDestino.qryQuery.SQL.Add('       MPD_QTDCON,');
  qryDestino.qryQuery.SQL.Add('       LOT_DTAVAL,');
  qryDestino.qryQuery.SQL.Add('       LOT_NUMLOT,');
  qryDestino.qryQuery.SQL.Add('       MPD_NUMCON,');
  qryDestino.qryQuery.SQL.Add('       MPD_STATUS,');

  pInsereDivergenciaLocFis;



  if blnEntFut And (Not fCfgSis('BEFTRG', VarBoolean)) Then
    qryDestino.qryQuery.SQL.Add('     @ENT_FUT := IF(LOT_NUMLOT IS NULL, ' + fGetSQLSomaCamposEntregaFutura() + ', ' + fGetSQLSomaCamposEntregaFutura('', False, True) + ') AS ITE_ENTFUT, ')
  Else
    qryDestino.qryQuery.SQL.Add('     @ENT_FUT := 0.00 AS ITE_ENTFUT, ');

    qryDestino.qryQuery.SQL.Add('     IF(LOT_NUMLOT IS NULL, (ITE_SALDOS + @ENT_FUT), (LOT_SALDOS + @ENT_FUT)) AS SALDOS,');

  qryDestino.qryQuery.SQL.Add('       @RESGAR := IF(LOT_NUMLOT IS NULL, IFNULL(ITE_SALREG, 0), IFNULL(LOT_SALREG, 0)) AS RESGAR , ');
  qryDestino.qryQuery.SQL.Add('       @ITE_DIFERE := - IF(LOT_NUMLOT IS NULL, (G.ITE_SALDOS - G.ITE_SALEXT - IFNULL(MPD_QTDCON, 0)), (LOT_SALDOS -  IFNULL(MPD_QTDCON, 0))) AS ITE_DIFERE, ');

  If intConEst = 1 Then
    qryDestino.qryQuery.SQL.Add('  (-(@ITE_DIFERE + @ENT_FUT)  +  @RESGAR <> 0) AS TEM_DIFERENCA ')
  else
    qryDestino.qryQuery.SQL.Add('   -(@ITE_DIFERE) <> 0 AS TEM_DIFERENCA  ');




  qryDestino.qryQuery.SQL.Add('  FROM MAPGER MG');
  qryDestino.qryQuery.SQL.Add(' INNER JOIN MAPDET MD ON MD.MPD_SEQGER = MG.AUTOINCREM AND MPD_STATUS <> "F"');

  qryDestino.qryQuery.SQL.Add(Format(' %s JOIN CADLOC ON LOC_CODLOC = MD.MPD_LOCFIS  AND LOC_CODEMP = MD.MPD_CODEMP ',
                                     [ifthen(fEmptyStr(edtLocFis.Text),
                                             'LEFT',
                                             'INNER')]));


  qryDestino.qryQuery.SQL.Add('  LEFT JOIN ITEGER G ON G.ITE_CODITE = MD.MPD_CODITE AND G.ITE_CODEMP = MPG_CODEMP');
  qryDestino.qryQuery.SQL.Add('  LEFT JOIN CADITE C ON C.ITE_CODITE = MD.MPD_CODITE');
  qryDestino.qryQuery.SQL.Add('  LEFT JOIN CADOPE ON OPE_CODOPE = MPD_CODOPE');
  qryDestino.qryQuery.SQL.Add('  LEFT JOIN CADLOT L ON    L.LOT_CODITE = MD.MPD_CODITE AND L.LOT_NUMLOT = MPD_NUMLOT AND L.LOT_CODEMP = MPG_CODEMP');
  qryDestino.qryQuery.SQL.Add('                       AND IF(IFNULL(LOC_CODLOC,"") = "", True, ((LOC_CODLOC = L.LOT_LOCFIS) AND (LOC_CODEMP = L.LOT_CODEMP))) ');

  qryDestino.qryQuery.SQL.Add(' WHERE MPG_CODEMP = "'+VS_StrCodEmp+'" ');

  pInsereParametrosNoSql(qryDestino);

  qryDestino.qryQuery.SQL.Add(fStrLocate(edtFornecedor, arrLinFor, 'C.ITE_CODFOR', 'CODFOR'));
  qryDestino.qryQuery.SQL.Add(fStrLocate(edtCodOpe,     arrCodOpe, 'MG.MPG_CODOPE', 'CODOPE'));
  qryDestino.qryQuery.SQL.Add(fStrLocate(edtCodIte,     arrProdut, 'C.ITE_CODITE', 'CODITE'));
  If Not fEmptyStr(mskLinhaGrupo.Text) Then
    qryDestino.qryQuery.SQL.Add(fStrLocateLinGru(mskLinhaGrupo, arrLinGru, 'C.ITE_CODGRU','CODGRU'));
  qryDestino.qryQuery.SQL.Add(fStrLocate(edtMarca,      arrLinMar, 'C.ITE_CODMAR', 'CODMAR'));
End;

procedure TfrmMapaDeInventarioParaColetores.pReinciaContagem();
begin
  pZeraInvetario;
end;

procedure TfrmMapaDeInventarioParaColetores.pZeraInvetario;
var qryComand : TUniQuery;
begin
  qryComand := fCriaQuery;
  Try


    qryComand.SQL.Clear;
    qryComand.SQL.Add('UPDATE ITEGER');
    qryComand.SQL.Add('INNER JOIN MAPDET ON MAPDET.MPD_CODITE = ITEGER.ITE_CODITE AND IFNULL(MAPDET.MPD_NUMLOT, "") = "" ');
    qryComand.SQL.Add('  SET ITE_SALCON = ITE_SALCON - IFNULL(MAPDET.MPD_QTDCON, 0),');
    qryComand.SQL.Add('      ITE_GMLCON = 0,');
    qryComand.SQL.Add('      ITE_DIFSAL = 0,');
    qryComand.SQL.Add('      ITE_DIF_ML = 0 ');
    qryComand.SQL.Add('WHERE ITEGER.ITE_CODEMP = "'+ VS_strCodEmp +'"');
    qryComand.SQL.Add('AND MAPDET.MPD_SEQGER = "' + qryMapa.FieldByName('AUTOINCREM').AsString + '"');

    qryComand.ExecSQL;

    qryComand.SQL.Clear;
    qryComand.SQL.Add('UPDATE CADLOT');
    qryComand.SQL.Add('INNER JOIN MAPDET ON MAPDET.MPD_CODITE = LOT_CODITE AND MPD_NUMLOT = LOT_NUMLOT');
    qryComand.SQL.Add('  SET LOT_SALCON = LOT_SALCON - IFNULL(MAPDET.MPD_QTDCON, 0),');
    qryComand.SQL.Add('      LOT_DIFSAL = 0,');
    qryComand.SQL.Add('      LOT_ML_CON = 0,');
    qryComand.SQL.Add('      LOT_DIF_ML = 0 ');
    qryComand.SQL.Add('');
    qryComand.SQL.Add('WHERE LOT_CODEMP = "'+VS_strCodEmp+'"');
    qryComand.SQL.Add('AND MAPDET.MPD_SEQGER = "'+qryMapa.FieldByName('AUTOINCREM').AsString+'"');
    qryComand.ExecSQL;

    qryComand.SQL.Clear;
    qryComand.SQL.Add('UPDATE MAPDET SET MPD_QTDCON = 0,MPD_STATUS = "N" ');
    qryComand.SQL.Add(' WHERE MAPDET.MPD_SEQGER = "' + qryMapa.FieldByName('AUTOINCREM').AsString + '"');
    qryComand.ExecSQL;

  Finally
    FreeAndNil(qryComand)
  End;
End;

procedure TfrmMapaDeInventarioParaColetores.pTrocaOperador(blnZeraContagem: Boolean = False);
var strNovoOperador: string;
begin
  strNovoOperador := TfrmTrocaOperador.fChamaTelaTrocaOperador(qryMapa.FieldByName('MPG_CODOPE').AsString);
  If strNovoOperador <> qryMapa.FieldByName('MPG_CODOPE').AsString then
    pExecutaTrocaDeOperador(qryMapa.FieldByName('AUTOINCREM').AsString, strNovoOperador);

  If blnZeraContagem Then
    pReinciaContagem;
end;


procedure TfrmMapaDeInventarioParaColetores.pSetaParametros(qryDestino: TZClient);
begin
  pSetaParam(edtFornecedor.Text, arrLinFor, strLinFor, 'CODFOR', qryDestino.qryQuery);
  pSetaParam(edtCodOpe.Text,     arrCodOpe, strCodOpe, 'CODOPE', qryDestino.qryQuery);
  pSetaParam(edtCodIte.Text,     arrProdut, strProdut, 'CODITE', qryDestino.qryQuery);
  pSetaParam(mskLinhaGrupo.Text, arrLinGru, strLinGru, 'CODGRU', qryDestino.qryQuery);
  pSetaParam(edtMarca.Text,      arrLinMar, strLinMar, 'CODMAR', qryDestino.qryQuery);
end;


procedure TfrmMapaDeInventarioParaColetores.btnExpandirClick(Sender: TObject);
begin
  inherited;
  cxgDados.ViewData.Expand(True);
end;

procedure TfrmMapaDeInventarioParaColetores.btnRetraiClick(Sender: TObject);
begin
  inherited;
  cxgDados.ViewData.Collapse(True);
end;

procedure TfrmMapaDeInventarioParaColetores.btnBuscaClick(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryMapa);
  qryMapa := TZClient.Create(Self);
  FreeAndNil(qryMapaDetalhe);
  qryMapaDetalhe := TZClient.Create(Self);

  pPreparaConsulta;
  qryMapa.fAbreClient(false, 'TfrmMapaDeInventarioParaColetores.btnBuscaClick');
  dtsDados.DataSet := qryMapa;
  qryMapaDetalhe.fAbreClient(false, 'TfrmMapaDeInventarioParaColetores.btnBuscaClick');
  dtsDetalhes.DataSet := qryMapaDetalhe;

  strLocFisSel := '';
  strStatusSel := '';

  If qryMapaDetalhe.IsEmpty Then
    pMensagemOk('Sem dados para exibir!')
  Else
  Begin
    pnlOpeResp.Visible := fVerificaAcessoSistema('AltRspCntMapInv', strLoginUsuarioLogado);
    btnExpandir.Click;
    Application.ProcessMessages;
    btnExpandir.Click;
  End;


end;

procedure TfrmMapaDeInventarioParaColetores.btnExcluirInventarioClick(
  Sender: TObject);
  var
    qryComand : TUniQuery;
begin
  inherited;
  If  qryMapa.IsEmpty Then
    Exit;

  If Not fValidaDireito(tpExclusao) Then
    Exit;

  If Not fPergunta('Deseja excluir o inventário ' + fPadL(qryMapa.FieldByName('MPG_NUMINV').AsString, 6, '0') + '!', False) Then
    Exit;

  pReinciaContagem;
  qryComand := fCriaQuery;
  fStartTransaction;
  try
    try
      qryComand.SQL.Clear;
      qryComand.SQL.Add('UPDATE MAPDET SET MPD_STATUS = "F"');
      qryComand.SQL.Add(' WHERE MAPDET.MPD_SEQGER = "' + qryMapa.FieldByName('AUTOINCREM').AsString + '"');
      qryComand.ExecSQL;

      qryComand.SQL.Clear;
      qryComand.SQL.Add('UPDATE  CADLOT');
      qryComand.SQL.Add('INNER JOIN MAPDET ON MAPDET.MPD_CODITE = LOT_CODITE AND MPD_NUMLOT = LOT_NUMLOT');
      qryComand.SQL.Add('  SET LOT_DIGCON = "N",');
      qryComand.SQL.Add('      LOT_STATUS = "S",');
      qryComand.SQL.Add('      LOT_SALCON = 0');
      qryComand.SQL.Add('WHERE MAPDET.MPD_SEQGER = "'+qryMapa.FieldByName('AUTOINCREM').AsString+'"');
      qryComand.SQL.Add('AND CADLOT.LOT_CODEMP = "'+VS_strCodEmp+'"');
      qryComand.SQL.Add('AND MPD_QTDCON = 0');
      qryComand.SQL.Add('AND (SELECT COUNT(1) FROM MAPDET MP2');
      qryComand.SQL.Add('      WHERE MP2.MPD_SEQGER <> "'+qryMapa.FieldByName('AUTOINCREM').AsString+'"');
      qryComand.SQL.Add('         AND MP2.MPD_CODITE = LOT_CODITE');
      qryComand.SQL.Add('         AND MP2.MPD_NUMLOT = LOT_NUMLOT');
      qryComand.SQL.Add('         AND MP2.MPD_STATUS <> "F" ) = 0');
      qryComand.ExecSQL;

      qryComand.SQL.Clear;
      qryComand.SQL.Add('UPDATE ITEGER');
      qryComand.SQL.Add('INNER JOIN MAPDET ON MAPDET.MPD_CODITE = ITE_CODITE AND IFNULL(MPD_NUMLOT, "") = ""');
      qryComand.SQL.Add('  SET ITE_DIGCON = "N",');
      qryComand.SQL.Add('      ITE_SALCON = 0');
      qryComand.SQL.Add('WHERE MAPDET.MPD_SEQGER = "'+qryMapa.FieldByName('AUTOINCREM').AsString+'"');
      qryComand.SQL.Add('AND ITEGER.ITE_CODEMP = "'+VS_strCodEmp+'"');
      qryComand.SQL.Add('AND MPD_QTDCON = 0');
      qryComand.SQL.Add('AND (SELECT COUNT(1) FROM MAPDET MP2');
      qryComand.SQL.Add('      WHERE MP2.MPD_SEQGER <> "'+qryMapa.FieldByName('AUTOINCREM').AsString+'"');
      qryComand.SQL.Add('         AND MP2.MPD_CODITE = ITE_CODITE');
      qryComand.SQL.Add('         AND IFNULL(MP2.MPD_NUMLOT, "") = ""');
      qryComand.SQL.Add('         AND MP2.MPD_STATUS <> "F" ) = 0');
      qryComand.ExecSQL;

      fCommit;

      btnBusca.Click;
      pSetFocus(btnBusca);
    Except
      on e: exception do
      Begin
        fRollBack;
        pMensagensErro(e.message, '[TfrmMapaDeInventarioParaColetores.btnExcluirInventarioClick]');
      end;

    End;
  finally
    FreeAndNil(qryComand);
  end;
end;

procedure TfrmMapaDeInventarioParaColetores.btnNovoMapaClick(Sender: TObject);

begin
  inherited;
  pCriarFormularios(TfrmGeradorMapaDeInventarioParaColetores, frmGeradorMapaDeInventarioParaColetores);
  Try
    frmGeradorMapaDeInventarioParaColetores.ShowModal;
    btnBusca.Click;
  Finally
    FreeAndNil(frmGeradorMapaDeInventarioParaColetores);
  End;
end;

function TfrmmapaDeInventarioParaColetores.fValidaDireito(tipDireito: TTipoDireito): Boolean;
var
  objLiberacao: ILiberacao;
  strDirAce,
  strMsg: String;
begin
 Result := False;
 If tipDireito = tpReinicioContagem Then
 Begin
   Result := True;

   strDirAce := 'RCNINV';
   strMsg := 'SEM PERMISSÃO PARA REINICIAR CONTAGEM';

   If Not fVerificaAcessoSistema('RCNINV') Then
     objLiberacao := TLiberacaoFactory.fGetLiberacao;
 End;
 If tipDireito = tpExclusao Then
 Begin
   Result := True;

   strDirAce := 'DELINV';
   strMsg := 'SEM PERMISSÃO PARA EXCLUIR INVENTÁRIO';

   If Not fVerificaAcessoSistema('DELINV') Then
     objLiberacao := TLiberacaoFactory.fGetLiberacao;
 End;

 If Assigned(objLiberacao) Then
 Begin
   objLiberacao.Clear;

   objLiberacao.objMsgLibera.pAddTexto(strMsg);
   objLiberacao.objMsgLibera.pAddSeparador(125);
   objLiberacao.objMsgLibera.pAddTexto('Este usuário não tem permissão para esta ação!');
   objLiberacao.objMsgLibera.pAddTexto('Será necessário senha de liberação para prosseguir.');

   objLiberacao.strDirAce := strDirAce;
   objLiberacao.strMsgSen := strMsg;
   objLiberacao.strCodOpe := strLoginUsuarioLogado;
   objLiberacao.blnSempreVariavelUsuario := True;

   Result := objLiberacao.fLibera;
 End;
end;

procedure TfrmMapaDeInventarioParaColetores.btnReiniciaContagemLocClick(
  Sender: TObject);
  var strStatus: String;
begin
  inherited;

  If Not fValidaDireito(tpReinicioContagem) Then
    Exit;

  strStatus := Copy(strStatusSel, 9, 1);
  OpcReiniciaContagem := TfrmMapaDeColetoresEscolhaReinciaContagem.fCallEscolhaReinciaContagem(strLocFisSel);
  If OpcReiniciaContagem <> opcrcIndefinido Then
    pInsereNovaContagemInventario(False);

  OpcReiniciaContagem := opcrcIndefinido;
end;

procedure TfrmMapaDeInventarioParaColetores.btnReiniciarContagemClick(
  Sender: TObject);
var status: TTipoEstadoConferencia;
begin
  inherited;
  If not btnReiniciarContagem.Visible Then
    Exit;

  If Not fValidaDireito(tpReinicioContagem) Then
    Exit;

  status := fCodToTipoEstadoConferencia(qryMapa.FieldByName('COD_STATUS').AsInteger);
  If status = tpecConcluido Then
  begin
    pMensagemOk('Status inválido!');
    Exit;
  End;

  If status = tpecIniciado then
  begin
    if fPergunta('Todas as contagens serão zeradas, deseja prosseguir?') then
    begin
      pReinciaContagem;
      btnBusca.Click;
    end;
  end;


end;

procedure TfrmMapaDeInventarioParaColetores.btnTrocaOperadorClick(
  Sender: TObject);
var status: TTipoEstadoConferencia;
    blnProsseguir: Boolean;
    blnZeraContagem: Boolean;
begin
  inherited;
  If not btnTrocaOperador.Visible Then
    Exit;

  If Not fValidaDireito(tpReinicioContagem) Then
    Exit;

  status := fCodToTipoEstadoConferencia(qryMapa.FieldByName('COD_STATUS').AsInteger);
  If status = tpecConcluido Then
  begin
    pMensagemOk('Status inválido!');
    Exit;
  End;

  blnZeraContagem := False;
  blnProsseguir :=  fPergunta('Deseja trocar o operador?');
  If blnProsseguir Then
  begin
    if status = tpecIniciado then
    begin
      blnProsseguir := fPergunta('Todas as contagens serão zeradas, deseja prosseguir?');
      blnZeraContagem:= blnProsseguir;
    end;
  end;

  If blnProsseguir Then
  begin
    pTrocaOperador(blnZeraContagem);
    btnBusca.Click;
  End;
end;

function TfrmMapaDeInventarioParaColetores.fCodToTipoEstadoConferencia(
  value: integer): TTipoEstadoConferencia;
begin
  Result := tpecNaoIniciado;
  case value of
    0: result := tpecNaoIniciado;
    1: result := tpecIniciado;
    2: result := tpecConcluido;
    3: result := tpeCDivergente;
  end;
end;

function TfrmMapaDeInventarioParaColetores.fStrToTipoEstadoConferencia(
  value: String): TTipoEstadoConferencia;
begin
  Result := tpecNaoIniciado;
  If value = 'A' Then
    result := tpecIniciado
  Else If value = 'C' Then
    result := tpecConcluido
  Else If value = 'D' Then
    result := tpeCDivergente
  Else If value = 'N' Then
    result := tpecNaoIniciado;
end;


function TfrmMapaDeInventarioParaColetores.fGeraInventarioDivergentes(pgbStatus: TcxProgressBar): Boolean;
  var
    strAutIncDet : String;
    intIncremento: Integer;
begin
  Result := True;
  pgbStatus.Properties.Max := qryFiltroMapDet.RecordCount;
  strAutIncDet := '';

  intIncremento := 1;
  If OpcReiniciaContagem = opcrcUltimaContagem Then
  Begin
    qryCommand.SQl.Clear;

    qryCommand.SQL.Clear;

    qryCommand.SQL.Add('UPDATE MAPDET');
    qryCommand.SQL.Add('INNER JOIN CADLOT ON LOT_NUMLOT = MPD_NUMLOT');
    qryCommand.SQL.Add('                 AND LOT_CODITE = MPD_CODITE');
    qryCommand.SQL.Add('                 AND LOT_CODEMP = MPD_CODEMP');
    qryCommand.SQL.Add('SET LOT_DIGCON = "N", LOT_SALCON = 0');
    qryCommand.SQL.Add('WHERE TRUE');
    qryCommand.SQL.Add('  AND MPD_SEQGER = "' + qryMapa.FieldByName('KEY_MAPGER').AsString + '"');
    qryCommand.SQL.Add('  AND MPD_NUMCON = ' + qryFiltroMapDet.FieldByname('MAIOR_NUMCON').AsString);
    qryCommand.SQL.Add('  AND MPD_LOCFIS = "' + qryFiltroMapDet.FieldByname('MPD_LOCFIS').AsString + '";');

    qryCommand.SQL.Add('UPDATE MAPDET ANT  ');
    qryCommand.SQL.Add('INNER JOIN  (SELECT * FROM MAPDET');
    qryCommand.SQL.Add('             WHERE MPD_SEQGER = "' + qryFiltroMapDet.FieldByName('MPD_SEQGER').AsString + '"');
    qryCommand.SQL.Add('               AND MPD_LOCFIS = "' + qryFiltroMapDet.FieldByname('MPD_LOCFIS').AsString + '"');
    qryCommand.SQL.Add('               AND MPD_NUMCON =  ' + qryFiltroMapDet.FieldByname('MAIOR_NUMCON').AsString + ')  TMP ON ANT.MPD_CODITE = TMP.MPD_CODITE AND ANT.MPD_LOCFIS = TMP.MPD_LOCFIS AND ANT.MPD_NUMLOT = TMP.MPD_NUMLOT');
    qryCommand.SQL.Add('SET ANT.MPD_STATUS = "D"');
    qryCommand.SQL.Add(' WHERE ANT.MPD_SEQGER = "' + qryFiltroMapDet.FieldByName('MPD_SEQGER').AsString + '"');
    qryCommand.SQL.Add('   AND ANT.MPD_LOCFIS = "' + qryFiltroMapDet.FieldByname('MPD_LOCFIS').AsString + '"');
    qryCommand.SQL.Add('   AND ANT.MPD_NUMCON <  ' + qryFiltroMapDet.FieldByname('MAIOR_NUMCON').AsString + ';');

    qryCommand.SQL.Add('DELETE FROM MAPDET ');
    qryCommand.SQL.Add(' WHERE MPD_SEQGER = "'+ qryFiltroMapDet.FieldByName('MPD_SEQGER').AsString + '"');
    qryCommand.SQL.Add('   AND MPD_LOCFIS = "'+ qryFiltroMapDet.FieldByname('MPD_LOCFIS').AsString + '"');
    qryCommand.SQL.Add('   AND MPD_NUMCON =  '+ qryFiltroMapDet.FieldByname('MAIOR_NUMCON').AsString + ';');

    qryCommand.ExecSQL;
    intIncremento := 0;
  End;

  pSetSQLInsertMatDet;

  While not qryFiltroMapDet.Eof Do
  Begin
    If strAutIncDet = '' Then
      strAutIncDet := fRetAutoIncrem('MAPDET', VS_StrCodEmp, qryFiltroMapDet.RecordCount +1)
    Else
      pIncrementaAutoIncrem(strAutIncDet);

    qryCommand.ParamByName('AUTOINCREM').AsString := strAutIncDet;
    qryCommand.ParamByName('MPD_SEQGER').AsString := qryFiltroMapDet.FieldByName('MPD_SEQGER').AsString;
    qryCommand.ParamByName('MPD_CODITE').AsString := qryFiltroMapDet.FieldByname('MPD_CODITE').AsString;
    qryCommand.ParamByName('MPD_LOCFIS').AsString := qryFiltroMapDet.FieldByname('MPD_LOCFIS').AsString;
    qryCommand.ParamByName('MPD_NUMLOT').AsString := qryFiltroMapDet.FieldByname('MPD_NUMLOT').AsString;
    qryCommand.ParamByName('MPD_CODEMP').AsString := qryFiltroMapDet.FieldByname('MPD_CODEMP').AsString;
    qryCommand.ParamByName('MPD_NUMCON').AsInteger := qryFiltroMapDet.FieldByname('MAIOR_NUMCON').AsInteger + intIncremento;
    qryCommand.ParamByName('MPD_CODOPE').AsString := strNovoOperadorInventarioDivergente;
    qryCommand.ParamByName('MPD_QTDCON').AsFloat  := 0;
    qryCommand.ParamByName('MPD_STATUS').AsString := 'N';

    qryCommand.ExecSQL;
    pgbStatus.Position := pgbStatus.Position + 1;
    qryFiltroMapDet.Next;
  End;
end;

procedure TfrmMapaDeInventarioParaColetores.pReiniciaContagemLocFis(blnApenasLocFis: Boolean);
Begin
  qryCommand.SQL.Clear;

  qryCommand.SQL.Add('UPDATE MAPDET');
  qryCommand.SQL.Add('INNER JOIN CADLOT ON LOT_NUMLOT = MPD_NUMLOT');
  qryCommand.SQL.Add('                 AND LOT_CODITE = MPD_CODITE');
  qryCommand.SQL.Add('                 AND LOT_CODEMP = MPD_CODEMP');
  qryCommand.SQL.Add('SET LOT_DIGCON = "N", LOT_SALCON = 0');
  qryCommand.SQL.Add('WHERE  TRUE');
  If blnApenasLocFis Then
    qryCommand.SQL.Add('  AND MPD_LOCFIS ="'+strLocFisSel+'"');
  qryCommand.SQL.Add('  AND MPD_SEQGER ="'+qryMapa.FieldByName('KEY_MAPGER').AsString+'";');


  qryCommand.SQL.Add('UPDATE MAPDET');
  qryCommand.SQL.Add('  SET MPD_QTDCON = 0,');
  qryCommand.SQL.Add('      MPD_STATUS = "N",');
  qryCommand.SQL.Add('      MPD_DTAINV = NULL,');
  qryCommand.SQL.Add('      MPD_HRAINV = NULL');
  qryCommand.SQL.Add('WHERE MPD_SEQGER ="'+qryMapa.FieldByName('KEY_MAPGER').AsString+'"');
  If blnApenasLocFis Then
    qryCommand.SQL.Add('  AND MPD_LOCFIS ="'+strLocFisSel+'"');
  qryCommand.SQL.Add(' AND  MPD_NUMCON = 1;');

  qryCommand.SQL.Add('DELETE FROM MAPDET WHERE MPD_SEQGER = "'+qryFiltroMapDet.FieldByName('MPD_SEQGER').AsString+'"  AND MPD_NUMCON > 1');
  qryCommand.ExecSQL;

  qryCommand.SQL.Clear;
End;



procedure TfrmMapaDeInventarioParaColetores.pSelecionaReplicacoes(blnGeral: Boolean);
var UltimaContagem: integer;
begin
  qryFiltroMapDet.SQL.Clear;


  If OpcReiniciaContagem  = opcrcUltimaContagem then
  Begin
    qryFiltroMapDet.SQL.Add('SELECT MAX(MPD_NUMCON) AS ULTIMACONTAGEM');
    qryFiltroMapDet.SQL.Add(' FROM MAPDET D');
    qryFiltroMapDet.SQL.Add('WHERE MPD_SEQGER = "'+qryMapa.FieldByName('KEY_MAPGER').AsString+'"');
    qryFiltroMapDet.SQL.Add('  AND MPD_LOCFIS = "'+strLocFisSel+'"');
    qryFiltroMapDet.SQL.Add('GROUP BY MPD_LOCFIS');
    qryFiltroMapDet.Open;
    UltimaContagem := qryFiltroMapDet.FieldByName('ULTIMACONTAGEM').AsInteger;
  End;

  qryFiltroMapDet.SQL.Clear;


  {  qryFiltroMapDet.SQL.Clear;
    qryFiltroMapDet.SQL.Add('SELECT MAX(MPD_NUMCON) AS MAIOR_NUMCON, D.*,');
    qryFiltroMapDet.SQL.Add('      (SELECT COUNT(1)');
    qryFiltroMapDet.SQL.Add('        FROM MAPDET D2');
    qryFiltroMapDet.SQL.Add('       WHERE D2.MPD_SEQGER = "' + qryMapa.FieldByName('KEY_MAPGER').AsString + '"');
    qryFiltroMapDet.SQL.Add('         AND D2.MPD_STATUS = "N"');
    qryFiltroMapDet.SQL.Add('         AND D2.MPD_LOCFIS = D.MPD_LOCFIS');
    qryFiltroMapDet.SQL.Add('         AND D2.MPD_CODITE = D.MPD_CODITE');
    qryFiltroMapDet.SQL.Add('         AND D2.MPD_NUMLOT = D.MPD_NUMLOT) AS QTD_PENDENTE');
    qryFiltroMapDet.SQL.Add(' FROM MAPDET D');
    qryFiltroMapDet.SQL.Add('WHERE MPD_SEQGER = "' + qryMapa.FieldByName('KEY_MAPGER').AsString+ '"');
    qryFiltroMapDet.SQL.Add('  AND MPD_STATUS = "D"');
    qryFiltroMapDet.SQL.Add('GROUP BY MPD_LOCFIS, MPD_CODITE, MPD_NUMLOT');
    qryFiltroMapDet.SQL.Add('HAVING QTD_PENDENTE = 0');
  End
  Else
  Begin
}
    qryFiltroMapDet.SQL.Clear;
    qryFiltroMapDet.SQL.Add('SELECT MAX(MPD_NUMCON) AS MAIOR_NUMCON, D.*,');
    qryFiltroMapDet.SQL.Add('      (SELECT MAX(MPD_NUMCON)');
    qryFiltroMapDet.SQL.Add('        FROM MAPDET D2');
    qryFiltroMapDet.SQL.Add('       WHERE D2.MPD_SEQGER = "' + qryMapa.FieldByName('KEY_MAPGER').AsString + '"');
    qryFiltroMapDet.SQL.Add('         AND D2.MPD_LOCFIS = D.MPD_LOCFIS');
    qryFiltroMapDet.SQL.Add('         AND D2.MPD_CODITE = D.MPD_CODITE');
    qryFiltroMapDet.SQL.Add('         AND D2.MPD_NUMLOT = D.MPD_NUMLOT) AS MAX_NUMCON, ');
    qryFiltroMapDet.SQL.Add('      (SELECT COUNT(1)');
    qryFiltroMapDet.SQL.Add('        FROM MAPDET D2');
    qryFiltroMapDet.SQL.Add('       WHERE D2.MPD_SEQGER = "' + qryMapa.FieldByName('KEY_MAPGER').AsString + '"');
    qryFiltroMapDet.SQL.Add('         AND D2.MPD_STATUS = "N"');
    qryFiltroMapDet.SQL.Add('         AND D2.MPD_LOCFIS = D.MPD_LOCFIS');
    qryFiltroMapDet.SQL.Add('         AND D2.MPD_CODITE = D.MPD_CODITE');
    qryFiltroMapDet.SQL.Add('         AND D2.MPD_NUMLOT = D.MPD_NUMLOT) AS QTD_PENDENTE');
    qryFiltroMapDet.SQL.Add(' FROM MAPDET D');
    qryFiltroMapDet.SQL.Add('WHERE MPD_SEQGER = "' + qryMapa.FieldByName('KEY_MAPGER').AsString+ '"');
    If Not blnGeral Then
      qryFiltroMapDet.SQL.Add('  AND MPD_LOCFIS = "'+strLocFisSel+'"');

    case OpcReiniciaContagem of
      opcrcDivergentes   : qryFiltroMapDet.SQL.Add('  AND MPD_STATUS = "D"');
      opcrcUltimaContagem: qryFiltroMapDet.SQL.Add('  AND MPD_NUMCON = '+UltimaContagem.ToString);
    End;



    qryFiltroMapDet.SQL.Add('GROUP BY MPD_LOCFIS, MPD_CODITE, MPD_NUMLOT');
    If OpcReiniciaContagem = opcrcDivergentes Then
      qryFiltroMapDet.SQL.Add('HAVING QTD_PENDENTE = 0 AND MAIOR_NUMCON = MAX_NUMCON');
//  End;
End;

procedure TfrmMapaDeInventarioParaColetores.pInsereNovaContagemInventario(blnGeral: Boolean = True);
var frmGravando:  TFrmGravando;
begin

  pSelecionaReplicacoes(blnGeral);
  qryFiltroMapDet.Open;


  If qryFiltroMapDet.IsEmpty Then
  Begin
    case OpcReiniciaContagem of
      opcrcDivergentes: Begin
                          If blnGeral Then
                            pMensagemOk('Não existem itens divergente para serem reiniciados.')
                          Else
                            pMensagemOk('Não existem itens divergente para serem reiniciados nessa localização ('+strLocFisSel+').');
                        End;

    End;
    Exit;
  End;

  If not qryFiltroMapDet.Eof Then
  begin
    strNovoOperadorInventarioDivergente := TfrmTrocaOperador.fChamaTelaTrocaOperador('');
    If strNovoOperadorInventarioDivergente = '' Then
    Begin
      pMensagemOk('É preciso definir o operador!');
      Exit;
    End;

    If OpcReiniciaContagem in[opcrcTotal, opcrcTotalLocalizacao] Then
    Begin
      pReiniciaContagemLocFis(OpcReiniciaContagem = opcrcTotalLocalizacao);
      btnBusca.Click;
      Exit;
    End;

    pCriarFormularios(TfrmGravando, frmGravando);
    Try
      frmGravando.Caption := 'Processando...';
      frmGravando.fExecutarAcao := fGeraInventarioDivergentes;
      frmGravando.Showmodal;
    Finally
      FreeAndNil(frmGravando);
      strNovoOperadorInventarioDivergente := ''
    End;

    btnBusca.Click;
  End;
end;

procedure TfrmMapaDeInventarioParaColetores.cxgDadosColumn1GetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  AText := fPadL(AText, 6, '0')
end;

procedure TfrmMapaDeInventarioParaColetores.cxgDadosColumn6PropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  OpcReiniciaContagem := opcrcDivergentes;
  If qryMapa.FieldByName('DIVERGENCIA_GERAL').AsString = 'Não' Then
    pMensagemOk('Não existem divergências!')
  Else
    pInsereNovaContagemInventario;
  OpcReiniciaContagem := opcrcIndefinido;

end;

procedure TfrmMapaDeInventarioParaColetores.cxgDadosFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  inherited;
  If Not Assigned(qryMapa) Then
    Exit;

  edtCodOpeResp.Text := qryMapa.FieldByName('MPG_CODOPE').AsString;
  edtNomOpeResp.Text := fRetNomeOperador(edtCodOpeResp.Text)
end;

procedure TfrmMapaDeInventarioParaColetores.cxgDetalheCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var strStatus: String;
    status: TTipoEstadoConferencia;
begin
  inherited;
  If (AViewInfo.Item.Index = cxgDetalheMPD_QTDCON.Index) Or  (AViewInfo.Item.Index = cxgDetalheLINDES_STATUS.Index) then
  Begin
    strStatus := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,cxgDetalheMDP_STATUS.Index]);
    status := fStrToTipoEstadoConferencia(strStatus);
    Case status of
      tpecIniciado   : ACanvas.Brush.Color := clSkyBlue;
      tpecConcluido  : ACanvas.Brush.Color := clWebLightGreen;
      tpeCDivergente : ACanvas.Brush.Color := clWebDarkSalmon;
      tpecNaoIniciado: ACanvas.Brush.Color := clBtnFace;
    End;
    Case status of
      tpecIniciado,
      tpecConcluido,
      tpeCDivergente,
      tpecNaoIniciado : ACanvas.Font.Color := clBlack;
    End;
  End;
end;

procedure TfrmMapaDeInventarioParaColetores.cxgDetalheCustomDrawGroupCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableCellViewInfo; var ADone: Boolean);

var
  strStatus: String;
  status: TTipoEstadoConferencia;
  strLocFis: String;

begin
  inherited;
  strStatus := VarToStr (AViewInfo.GridRecord.Values [1]);

  strLocFis := Copy(strStatus, 11, Length(strStatus));
  strStatus := Copy(strStatus, 9, 1);



  If strStatus <> '' Then
  Begin
    status := fCodToTipoEstadoConferencia(strToInt(strStatus));
    Case status of
      tpecIniciado   : ACanvas.Brush.Color := clSkyBlue;
      tpecConcluido  : ACanvas.Brush.Color := clWebLightGreen;
      tpeCDivergente : ACanvas.Brush.Color := clWebDarkSalmon;
      tpecNaoIniciado: ACanvas.Brush.Color := clBtnFace;
     End;
  End;
  ACanvas.Font.Color := clBlack;



end;

procedure TfrmMapaDeInventarioParaColetores.cxgDetalheFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
{}
end;

procedure TfrmMapaDeInventarioParaColetores.cxgDetalheFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  inherited;

  strLocFisSel := '';
  strStatusSel := '';

  if AFocusedRecord <> nil then
  begin
    strLocFisSel := VarToStr(AFocusedRecord.Values[cxgDetalheMPD_LOCFIS.Index]);
    strStatusSel := VarToStr(AFocusedRecord.Values[cxgDetalheCOD_STATUS.Index]);
  end;

  btnReiniciaContagemLoc.Caption := '[ F8 ] Reiniciar Contagem da Localização ' + strLocFisSel;

end;

procedure TfrmMapaDeInventarioParaColetores.cxGrid1DBTableView1GroupGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: String);
var
  strLocFis: String;
begin
  inherited;

  strLocFis := Copy(AText, 11, Length(AText));

  AText := strLocFis
end;

procedure TfrmMapaDeInventarioParaColetores.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, nil, Key, arrProdut, False, nil, 'Consulta de Itens', '1') Then
  Begin
    fValidaCampos(edtCodIte, True);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmMapaDeInventarioParaColetores.edtCodOpeKeyPress(Sender: TObject;
  var Key: Char);
begin

  inherited;
  if fPesqOperador(Self,
                   edtCodOpe,
                   edtDesOpe,
                   Nil,
                   Key,
                   arrCodOpe) Then //blnCompradores
  Begin
    If fValidaCampos(edtCodOpe, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmMapaDeInventarioParaColetores.edtCodOpeRespKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  if fPesqOperador(Self,
                   edtCodOpeResp,
                   edtNomOpeResp,
                   Nil,
                   Key,
                   arrOpeRsp,
                   False,
                   False,
                   False,
                   False,
                   False,
                   False,
                   False,
                   False,
                   False,
                   False,
                   True) Then
  Begin
    If fValidaCampos(edtCodOpeResp, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmMapaDeInventarioParaColetores.edtFornecedorKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtFornecedor, edtDesFornecedor, Nil, Key, arrLinFor, False) Then
  Begin
    If fValidaCampos(edtFornecedor, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmMapaDeInventarioParaColetores.edtMarcaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqMarcas(Self, edtMarca, edtDesMarca, Nil, Key, arrLinMar, False) Then
  Begin
    If fValidaCampos(edtMarca, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmMapaDeInventarioParaColetores.pSetSQLInsertMatDet;
begin
  qryCommand.SQl.Clear;
  qryCommand.SQL.Add('INSERT INTO MAPDET (AUTOINCREM, MPD_SEQGER, MPD_CODITE, MPD_LOCFIS, MPD_NUMLOT, MPD_QTDCON, MPD_STATUS, MPD_CODEMP, MPD_CODOPE, MPD_NUMCON) VALUES ');
  qryCommand.SQL.Add('                   (:AUTOINCREM, :MPD_SEQGER, :MPD_CODITE, :MPD_LOCFIS, :MPD_NUMLOT, :MPD_QTDCON, :MPD_STATUS, :MPD_CODEMP, :MPD_CODOPE, :MPD_NUMCON)');
End;


procedure TfrmMapaDeInventarioParaColetores.FormCreate(Sender: TObject);
begin
  inherited;
  OpcReiniciaContagem := opcrcIndefinido;
  blnEntFut := fCfgSis('ENTFUT', varBoolean);
  strNovoOperadorInventarioDivergente := '';
  qryFiltroMapDet := fCriaQuery;
  qryCommand := fCriaQuery;
  pSetSQLInsertMatDet;
  intConEst := fCfgSis('CONEST');

  qryMapa := TZClient.Create(Self);

  shpIniciado.Brush.Color := clSkyBlue;
  shpNaoInciaido.Brush.Color := clBtnFace;
  shpDivergente.Brush.Color := clWebDarkSalmon;
  shpConcluido.Brush.Color := clWebLightGreen;

  edtCodIte.TamCampo  := fTamCodIte;
  edtCodIte.MaxLength := fTamCodIte;

end;

procedure TfrmMapaDeInventarioParaColetores.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryMapa);
  FreeAndNil(qryFiltroMapDet);
  FreeAndNil(qryCommand);

  inherited;
end;

procedure TfrmMapaDeInventarioParaColetores.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case key of
    VK_F10 :  btnNovoMapa.Click;
    VK_F5  :  btnBusca.Click;
    VK_F9  :  btnReiniciarContagem.Click;
    VK_F8  :  btnTrocaOperador.Click;
    VK_F7  :  btnExcluirInventario.Click;
  end;
end;

procedure TfrmMapaDeInventarioParaColetores.mskLinhaGrupoKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, nil, Key, arrLinGru, False) Then
  Begin
    If fValidaCampos(mskLinhaGrupo, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmMapaDeInventarioParaColetores.fValidaOperador(Sender: TWinControl): Boolean;
begin
  Result := True;
  If Not (Sender = edtCodOpe) Then
    Exit;
  If fEmptyStr(edtCodOpe.Text) Then
    edtDesOpe.Clear
  Else
  Begin
    edtDesOpe.Text := fRetNomeOperador(edtCodOpe.Text);
    If fEmptyStr(edtDesOpe.Text) Then
    begin
      pMensagemOk('Operador não encontrado!');
      Result := false;
    end;
  End;
end;

function TfrmMapaDeInventarioParaColetores.fValidaOperadorResp(
  Sender: TWinControl): Boolean;
begin
  Result := True;

  If Not (Sender = edtCodOpeResp) Then
    Exit;

  If fEmptyStr(edtCodOpeResp.Text) Then
    edtNomOpeResp.Clear
  Else
  Begin
    edtNomOpeResp.Text := fRetNomeOperador(edtCodOpeResp.Text);
    If fEmptyStr(edtNomOpeResp.Text) Then
    begin
      pMensagemOk('Operador não encontrado!');
      Result := false;
    end;
    If Not fVerificaAcessoSistema('btnInventarioMapa', edtCodOpeResp.Text) Then
    Begin
      pMensagemOk('Operador sem direito de acesso ao balanço de estoque no coletor');
      edtCodOpeResp.Clear;
      edtNomOpeResp.Clear;
      Result := False;
    End
    Else
    Begin
      pExecutaTrocaDeOperadorResponsavel(qryMapa.FieldByName('AUTOINCREM').AsString, edtCodOpeResp.Text);
      btnBusca.Click;
    End;
  End;
end;

function TfrmMapaDeInventarioParaColetores.fValidaLinhaGrupo(Sender: TWinControl): Boolean;
begin
  Result := True;
  If Not (Sender = mskLinhaGrupo) Then
    Exit;
  If Not fEmptyStr(mskLinhaGrupo.Text) Then
    pEdtCodSelectExit(mskLinhaGrupo,edtDesGrupo,arrLinGru, fRetNomeLinhaGrupo,Nil,'da linha/grupo',6)
  Else
    edtDesGrupo.Text := '';
End;

function TfrmMapaDeInventarioParaColetores.fValidaLinhaMarca(Sender: TWinControl): Boolean;
begin
  Result := True;
  If Not (Sender = edtMarca) Then
    Exit;
  If Not fEmptyStr(edtMarca.Text) Then
    pEdtCodSelectExit(edtMarca, edtDesMarca ,arrLinMar, fRetNomMarca, nil, 'da Marca')
  Else
    edtDesMarca.Text := '';
end;

function TfrmMapaDeInventarioParaColetores.fValidaLinhaFornecedor(Sender: TWinControl): Boolean;
begin
  Result := True;
  If Not (Sender = edtFornecedor) Then
    Exit;

  If Not fEmptyStr(edtFornecedor.Text) Then
    pEdtCodSelectExit(edtFornecedor, edtDesFornecedor, arrLinFor, fRetNomFornecedor, Nil, 'do Fornecedor')
  Else
   edtDesFornecedor.Text := '';
end;

function TfrmMapaDeInventarioParaColetores.fValidaLinhaCodIte(Sender: TWinControl): Boolean;
begin
  Result := True;
  If Not (Sender = edtCodIte) Then
    Exit;
  If Not fEmptyStr(edtCodIte.Text) Then
    pEdtCodSelectExit(edtCodIte, edtDesIte, arrProdut, nil, fRetNomProduto, 'do Produto')
  Else
    edtDesIte.Text := '';
end;

function TfrmMapaDeInventarioParaColetores.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  Result := Result And fValidaOperador(Sender);
  Result := Result And fValidaLinhaGrupo(Sender);
  Result := Result And fValidaLinhaMarca(Sender);
  Result := Result And fValidaLinhaFornecedor(Sender);
  Result := Result And fValidaLinhaCodIte(Sender);
  Result := Result And fValidaOperadorResp(Sender);
end;

end.



