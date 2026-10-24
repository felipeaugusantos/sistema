unit untGeradorMapaDeInventarioParaColetores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.Mask, MaskEditFocus, EditFocus, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, MemDS, DBAccess, Uni,
  untFuncoesConsulta, untTypesSistema, untFuncoesSimples, untConsultas, untZClient,
  cxCheckBox, cxCurrencyEdit, cxContainer, cxProgressBar, System.StrUtils, untTBatchSQL;

type
  TfrmGeradorMapaDeInventarioParaColetores = class(TfrmPai)
    Panel1: TPanel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    edtApartamento: TEditFocus;
    edtAndar: TEditFocus;
    edtPredio: TEditFocus;
    edtRua: TEditFocus;
    edtLocFis: TEditFocus;
    mskLinhaGrupo: TMaskEditFocus;
    edtDesGrupo: TEditFocus;
    edtFornecedor: TEditFocus;
    edtDesFornecedor: TEditFocus;
    edtMarca: TEditFocus;
    edtDesMarca: TEditFocus;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    Label14: TLabel;
    edtCodDep: TEditFocus;
    edtDesCodDep: TEditFocus;
    Panel2: TPanel;
    cxDados: TcxGridCitel;
    cxgDados: TcxGridDBTableViewCitel;
    cxlDados: TcxGridLevel;
    Label1: TLabel;
    edtCodOpe: TEditFocus;
    edtDesOpe: TEditFocus;
    btnConfirmar: TBitBtnLocked;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmarcar: TBitBtnLocked;
    btnEspaco: TBitBtnLocked;
    dtsDados: TDataSource;
    cxgDadosColumn1: TcxGridDBColumn;
    cxgDadosColumn2: TcxGridDBColumn;
    cxgDadosColumn3: TcxGridDBColumn;
    cxgDadosColumn4: TcxGridDBColumn;
    cxgDadosColumn5: TcxGridDBColumn;
    cxgDadosColumn6: TcxGridDBColumn;
    rdgSaldo: TRadioGroup;
    btnBusca: TBitBtnLocked;
    rdgListagem: TRadioGroup;
    chkLocFisVazia: TCheckBox;
    chkExcluirItensSaldoReservado: TCheckBox;
    cxgDadosColumn7: TcxGridDBColumn;
    btnHlpImp: TBitBtnLocked;
    chkMovProgramada: TCheckBox;
    chkApenasItensMapeados: TCheckBox;
    lblLocSep: TLabel;
    edtCodLocSep: TEditFocus;
    edtDesLocSep: TEditFocus;
    procedure btnBuscaClick(Sender: TObject);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);

    procedure edtCodOpeKeyPress(Sender: TObject; var Key: Char);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure cxgDadosKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure btnDesmarcarClick(Sender: TObject);
    procedure btnEspacoClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure rdgListagemClick(Sender: TObject);
    procedure btnHlpImpClick(Sender: TObject);
    procedure edtCodLocSepKeyPress(Sender: TObject; var Key: Char);
  private
    qryMapa: TZClient;
    qryMapaDetalhado: TZClient;
    qryComand : TUniQuery;
    arrLinGru: TConsultasArray;
    arrProdut: TConsultasArray;
    arrOperad: TConsultasArray;
    arrLinFor: TConsultasArray;
    arrLinMar: TConsultasArray;
    arrCodDep: TConsultasArray;
    arrLocSep: TConsultasArray;

    strLinFor: String;
    strCodDep: String;
    strProdut: String;
    strLinGru: String;
    strLinMar: String;
    strCodItens: String;
    strMarcaDesmarca: String;
    strCodInventario : String;
    strLocSep: String;

    procedure pPreparaConsulta(qryDestino: TZClient;  blnDetalhe: Boolean);
    procedure pAjustaColunas;
    procedure pInsereParametrosNoSql(qryDestino: TZClient);
    procedure pSetaParametros(qryDestino: TZClient);
    function  fMarcaDesmarcaTodos(pgbStatus: TcxProgressBar = Nil): Boolean;
    function  fGeraInventario(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fGerenciaMapDetGravacao(intQtdRegistros: integer; strAutIncGer: String; var  strAutIncDet: string; objBatchMapDet, objBatchItens: TBatchSQL): Boolean;
    function fPulaRegistroNumLotVazio: Boolean;


    procedure pSetAutoincrem(var strAutIncDet: String; intQtdRegistros: integer);

    function fGetQuantidadeRegistros: integer;
    function fGeraMapger(out strAutInc: String): Boolean;
    procedure pPreencheListaItensMarcados;

    function fGeraScriptMapDet(strAutIncGer: String; strAutIncDet: String; qryFonteDados: TZClient; objBatchMapDet, objBatchItens: TBatchSQL): Boolean;
    function fExecutaScriptMapDet(objBatchMapDet: TBatchSQL): Boolean;
    function fExecutaScriptItens(objBatchItens: TBatchSQL): Boolean;
    procedure pMarcaDesmarca(blnInverte: Boolean = False);
    function fGerarInventario(var strMensagem: String): Boolean;
    function fValidaOperadorPreenchido(var strMensagem: string): Boolean;
    function fGravaConDet: Boolean;
    function fValidaOperador(Sender: TWinControl): Boolean;
    function fValidaLinhaGrupo(Sender: TWinControl): Boolean;
    function fValidaMarca(Sender: TWinControl): Boolean;
    function fValidaFornecedor(Sender: TWinControl): Boolean;
    function fValidaProduto(Sender: TWinControl): Boolean;
    function fValidaDepartamento(Sender: TWinControl): Boolean;
    function fValidaLocalSeparacao(Sender: TWinControl): Boolean;


    procedure processaMarcaDesmarcaTodos;

    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;


  public
    destructor Destroy; override;
    { Public declarations }
  end;

var
  frmGeradorMapaDeInventarioParaColetores: TfrmGeradorMapaDeInventarioParaColetores;

implementation

uses
  untGravando, untConDet, untConstantes, untHistoricoBalanco;

{$R *.dfm}

procedure TfrmGeradorMapaDeInventarioParaColetores.btnBuscaClick(
  Sender: TObject);
begin
  inherited;
  If Assigned(qryMapa) Then
  Begin
    FreeAndNil(qryMapa);
    FreeAndNil(qryMapaDetalhado);
    qryMapa := TZClient.Create(Self);
    qryMapaDetalhado := TZClient.Create(Self);
  End;
  pPreparaConsulta(qryMapa, False);
  pPreparaConsulta(qryMapaDetalhado, True);
  qryMapa.fAbreClient(false, 'TfrmGeradorMapaDeInventarioParaColetores.btnBuscaClick');
  If rdgListagem.ItemIndex = 1 Then
    qryMapaDetalhado.fAbreClient(false, 'TfrmGeradorMapaDeInventarioParaColetores.btnBuscaClick');

  dtsDados.DataSet := qryMapa;

  btnConfirmar.Enabled := Not qryMapa.IsEmpty;
  btnMarcarTodos.Enabled := btnConfirmar.Enabled;
  btnDesmarcar.Enabled := btnConfirmar.Enabled;
  btnEspaco.Enabled := btnConfirmar.Enabled;

end;

function TfrmGeradorMapaDeInventarioParaColetores.fValidaOperador(Sender: TWinControl): Boolean;
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
    end
    Else If Not fVerificaAcessoSistema('btnBalanco', edtCodOpe.Text) Then
    Begin
      pMensagemOk('Operador sem direto de acesso ao balanço de estoque!');
      Result := false;
    end;
  end;
End;

function TfrmGeradorMapaDeInventarioParaColetores.fValidaLinhaGrupo(Sender: TWinControl): Boolean;
begin
  Result := True;
  if Not (Sender =  mskLinhaGrupo) Then
    Exit;

  If Not fEmptyStr(mskLinhaGrupo.Text) Then
    pEdtCodSelectExit(mskLinhaGrupo,edtDesGrupo,arrLinGru, fRetNomeLinhaGrupo,Nil,'da linha/grupo',6)
  Else
    edtDesGrupo.Text := '';
End;

function TfrmGeradorMapaDeInventarioParaColetores.fValidaLocalSeparacao(
  Sender: TWinControl): Boolean;
begin
  Result := True;
  if Not (Sender = edtCodLocSep) Then
    Exit;

  edtDesLocSep.Text := fRetLocSep(edtCodLocSep.Text);

  If (Not fEmptyStr(edtCodLocSep.Text)) And fEmptyStr(edtDesLocSep.Text) Then
  Begin
    fMensagem('ATENÇÃO!','Esse local de separação não está cadastrado!',['&OK']);
    Result := False;
  End;
end;

function TfrmGeradorMapaDeInventarioParaColetores.fValidaMarca(Sender: TWinControl): Boolean;
begin
  Result := True;
  if Not (Sender = edtMarca) Then
    Exit;
  If Not fEmptyStr(edtMarca.Text) Then
    pEdtCodSelectExit(edtMarca, edtDesMarca ,arrLinMar, fRetNomMarca, nil, 'da Marca')
  Else
    edtDesMarca.Text := '';
end;

function TfrmGeradorMapaDeInventarioParaColetores.fValidaFornecedor(Sender: TWinControl): Boolean;
begin
  Result := True;
  if Not (Sender = edtFornecedor) Then
    Exit;

  If Not fEmptyStr(edtFornecedor.Text) Then
    pEdtCodSelectExit(edtFornecedor, edtDesFornecedor, arrLinFor, fRetNomFornecedor, Nil, 'do Fornecedor')
  Else
    edtDesFornecedor.Text := '';
end;

function TfrmGeradorMapaDeInventarioParaColetores.fValidaProduto(Sender: TWinControl): Boolean;
begin
  Result := True;
  if Not (Sender = edtCodIte) Then
    Exit;
  If Not fEmptyStr(edtCodIte.Text) Then
    pEdtCodSelectExit(edtCodIte, edtDesIte, arrProdut, nil, fRetNomProduto, 'do Produto')
  Else
    edtDesIte.Text := '';
End;

function TfrmGeradorMapaDeInventarioParaColetores.fValidaDepartamento(Sender: TWinControl): Boolean;
begin
  Result := True;
  if Not (Sender = edtCodDep) Then
    Exit;
  If Not fEmptyStr(edtCodDep.Text) Then
    pEdtCodSelectExit(edtCodDep, edtDesCodDep, arrCodDep, fRetNomDep, nil, 'do Departamento')
  Else
    edtDesCodDep.Text := '';
End;


function TfrmGeradorMapaDeInventarioParaColetores.fValidaCampos(
  Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  Result := Result And fValidaOperador(Sender);
  Result := Result And fValidaLinhaGrupo(Sender);
  Result := Result And fValidaMarca(Sender);
  Result := Result And fValidaFornecedor(Sender);
  Result := Result And fValidaProduto(Sender);
  Result := Result And fValidaProduto(Sender);
  Result := Result And fValidaDepartamento(Sender);
  Result := Result And fValidaLocalSeparacao(Sender);
end;

procedure TfrmGeradorMapaDeInventarioParaColetores.pAjustaColunas;
var
  blnVisible: Boolean;
begin
  blnVisible := rdgListagem.ItemIndex = 0;


  cxgDadosColumn6.Visible := blnVisible;
  cxgDadosColumn5.Visible := blnVisible;
  cxgDadosColumn3.Visible := blnVisible;
  cxgDadosColumn2.Visible := blnVisible;
  cxgDadosColumn7.Visible := blnVisible;
  If Not blnVisible Then
    chkLocFisVazia.Enabled := True;
end;

procedure TfrmGeradorMapaDeInventarioParaColetores.pInsereParametrosNoSql(qryDestino: TZClient);
begin
  If edtLocFis.Text <> '' Then
    qryDestino.qryQuery.SQL.Add('   AND LOC_CODLOC LIKE "' + edtLocFis.Text + '%"');
  If edtRua.Text <> '' Then
    qryDestino.qryQuery.SQL.Add('   AND  LOC_R_U_A_ = ' + QuotedStr(edtRua.Text));
  If edtPredio.Text <> '' Then
    qryDestino.qryQuery.SQL.Add('   AND  LOC_PREDIO = ' + QuotedStr(edtPredio.Text));
  If edtAndar.Text <> '' Then
    qryDestino.qryQuery.SQL.Add('   AND  LOC_ANDAR_ = ' + QuotedStr(edtAndar.Text));
  If edtApartamento.Text <> '' Then
    qryDestino.qryQuery.SQL.Add('   AND  LOC_APARTA = ' + QuotedStr(edtApartamento.Text));
end;

procedure TfrmGeradorMapaDeInventarioParaColetores.pPreparaConsulta(qryDestino: TZClient;  blnDetalhe: Boolean);
  var  strMovLotIte, strMovLot: string;
begin
  strMovLot := '';
  strMovLot := strMovLot  + '( SELECT ';
  strMovLot := strMovLot  + '    LOT_LOCFIS ';
  strMovLot := strMovLot  + '  FROM ';
  strMovLot := strMovLot  + '    MOVLOT ';
  strMovLot := strMovLot  + '  INNER JOIN CADLOT  ON LOT_CODEMP = MLT_CODEMP ';
  strMovLot := strMovLot  + '                    AND LOT_CODITE = MLT_CODITE ';
  strMovLot := strMovLot  + '                    AND LOT_NUMLOT IN (MLT_LOTORI, MLT_LOTDES) ';
  strMovLot := strMovLot  + '  WHERE MLT_DTAREA IS NULL ';
  strMovLot := strMovLot  + '    AND MLT_CODEMP = "' + VS_StrCodEmp + '") ';

  strMovLotIte := '';
  strMovLotIte := strMovLotIte  + '( SELECT ';
  strMovLotIte := strMovLotIte  + '    LOT_LOCFIS ';
  strMovLotIte := strMovLotIte  + '  FROM ';
  strMovLotIte := strMovLotIte  + '    MOVLOT ';
  strMovLotIte := strMovLotIte  + '  INNER JOIN CADLOT  ON LOT_CODEMP = MLT_CODEMP ';
  strMovLotIte := strMovLotIte  + '                    AND LOT_CODITE = MLT_CODITE ';
  strMovLotIte := strMovLotIte  + '                    AND LOT_NUMLOT IN (MLT_LOTORI, MLT_LOTDES) ';
  strMovLotIte := strMovLotIte  + '  WHERE MLT_DTAREA IS NULL ';
  strMovLotIte := strMovLotIte  + '    AND MLT_CODEMP = "' + VS_StrCodEmp + '" ';
  If (chkMovProgramada.Checked) and (rdgListagem.ItemIndex = 0) Then
    strMovLotIte := strMovLotIte  + '   AND MLT_CODITE = G.ITE_CODITE ';
  strMovLotIte := strMovLotIte  + ')' ;
  qryDestino.qryQuery.SQL.Clear;

  qryDestino.qryQuery.SQL.Add('SELECT * FROM (');
  qryDestino.qryQuery.SQL.Add('SELECT CAST("D" AS CHAR(1)) AS MARCAD,');
  qryDestino.qryQuery.SQL.Add('       G.ITE_CODITE,');
  qryDestino.qryQuery.SQL.Add('       G.ITE_CODEMP,');
  qryDestino.qryQuery.SQL.Add('       C.ITE_DESITE,');
  qryDestino.qryQuery.SQL.Add('       L.LOT_LOCFIS,');
  qryDestino.qryQuery.SQL.Add('       L.LOT_NUMLOT,');
  qryDestino.qryQuery.SQL.Add('       LOC_DESCRI,');
  qryDestino.qryQuery.SQL.Add('       @SALDO_ITE := IFNULL(ITE_SALDOS + IF(IFNULL(ITE_CNV_ML, 0) > 0, IFNULL(ITE_SAL_ML, 0) / ITE_CNV_ML, 0), 0)');
  qryDestino.qryQuery.SQL.Add('        - (IFNULL(ITE_QTPD_V, 0) + IFNULL(ITE_QTPD_F, 0))');
  qryDestino.qryQuery.SQL.Add('        - IFNULL(ITE_SALREG, 0)');
  qryDestino.qryQuery.SQL.Add('        - IFNULL(ITE_SALEXT, 0)');
  qryDestino.qryQuery.SQL.Add('        - IFNULL(ITE_QTPD_P, 0)');
  qryDestino.qryQuery.SQL.Add('        - IFNULL(ITE_QTPD_E, 0) AS SALDO_ITE,');
  qryDestino.qryQuery.SQL.Add('       CASE WHEN SIS_VALCFG = "1" THEN @ENT_FUT_LOT := IFNULL(ITE_QTEF_A, 0) + IFNULL(ITE_QTEF_F, 0) + IFNULL(ITE_QTEF_P, 0)');
  qryDestino.qryQuery.SQL.Add('            WHEN SIS_VALCFG = "3" THEN @ENT_FUT_LOT := IFNULL(ITE_QTEF_F, 0)');
  qryDestino.qryQuery.SQL.Add('            WHEN SIS_VALCFG = "4" THEN @ENT_FUT_LOT := IFNULL(ITE_QTEF_A, 0) + IFNULL(ITE_QTEF_P, 0)');
  qryDestino.qryQuery.SQL.Add('            WHEN SIS_VALCFG = "5" THEN @ENT_FUT_LOT := IFNULL(ITE_QTEF_A, 0) + IFNULL(ITE_QTEF_F, 0)');
  qryDestino.qryQuery.SQL.Add('       END AS ENTREGA_FUTURA_ITE,');

  qryDestino.qryQuery.SQL.Add('       @SALDO_LOT := IFNULL(LOT_SALDOS + IF(IFNULL(ITE_CNV_ML, 0) > 0, IFNULL(LOT_SAL_ML, 0) / ITE_CNV_ML, 0), 0)');
  qryDestino.qryQuery.SQL.Add('        - (IFNULL(LOT_QTPD_V, 0) + IFNULL(LOT_QTPD_F, 0))');
  qryDestino.qryQuery.SQL.Add('        - IFNULL(LOT_SALREG, 0)');
  qryDestino.qryQuery.SQL.Add('        - IFNULL(LOT_QTPD_P, 0)');
  qryDestino.qryQuery.SQL.Add('        - IFNULL(LOT_QTPD_E, 0) AS SALDO_LOT,');

  //saldo reservado garantia
  qryDestino.qryQuery.SQL.Add('       @SALRES := ');
  qryDestino.qryQuery.SQL.Add('          IFNULL(LOT_QTPD_V, 0) ');
  qryDestino.qryQuery.SQL.Add('        + IFNULL(LOT_QTPD_F, 0)');
  qryDestino.qryQuery.SQL.Add('        + IFNULL(LOT_QTPD_P, 0)');
  qryDestino.qryQuery.SQL.Add('        + IFNULL(LOT_QTPD_E, 0) AS SALRES,');



  qryDestino.qryQuery.SQL.Add('       CASE WHEN SIS_VALCFG = "1" THEN @ENT_FUT_LOT := IFNULL(LOT_QTEF_A, 0) + IFNULL(LOT_QTEF_F, 0) + IFNULL(LOT_QTEF_P, 0)');
  qryDestino.qryQuery.SQL.Add('            WHEN SIS_VALCFG = "3" THEN @ENT_FUT_LOT := IFNULL(LOT_QTEF_F, 0)');
  qryDestino.qryQuery.SQL.Add('            WHEN SIS_VALCFG = "4" THEN @ENT_FUT_LOT := IFNULL(LOT_QTEF_A, 0) + IFNULL(LOT_QTEF_P, 0)');
  qryDestino.qryQuery.SQL.Add('            WHEN SIS_VALCFG = "5" THEN @ENT_FUT_LOT := IFNULL(LOT_QTEF_A, 0) + IFNULL(LOT_QTEF_F, 0)');
  qryDestino.qryQuery.SQL.Add('       END AS ENTREGA_FUTURA_LOT,');
  qryDestino.qryQuery.SQL.Add('       IF(LOT_NUMLOT IS NULL, IFNULL(@SALDO_ITE, 0) + IFNULL(@ENTREGA_FUTURA_ITE, 0), IFNULL(@SALDO_LOT, 0) + IFNULL(@ENT_FUT_LOT, 0)) AS SALDO_CALC  ');
  qryDestino.qryQuery.SQL.Add('  FROM CADITE C');
  qryDestino.qryQuery.SQL.Add(' INNER JOIN ITEGER G ON G.ITE_CODITE = C.ITE_CODITE');
  qryDestino.qryQuery.SQL.Add(' INNER JOIN CADLOT L ON L.LOT_CODITE = C.ITE_CODITE AND L.LOT_CODEMP = G.ITE_CODEMP  AND LOT_TRANSI = "N" ');
  qryDestino.qryQuery.SQL.Add('  LEFT JOIN CADLOC ON LOC_CODLOC = LOT_LOCFIS AND LOC_CODEMP = LOT_CODEMP ');
  qryDestino.qryQuery.SQL.Add(' INNER JOIN CFGSIS ON SIS_CODCFG = "CFG_CALSAL" AND SIS_CODEMP = G.ITE_CODEMP');
  qryDestino.qryQuery.SQL.Add(' WHERE G.ITE_CODEMP = "'+ VS_StrCodEmp + '"');
  qryDestino.qryQuery.SQL.Add('   AND IF(L.LOT_NUMLOT IS NOT NULL, LOT_DIGCON <> "S", ITE_DIGCON <> "S") ');
  qryDestino.qryQuery.SQL.Add('   AND L.LOT_NUMLOT <> "A DEFINIR" AND L.LOT_NUMLOT <> "GARANTIA" ');
  qryDestino.qryQuery.SQL.Add('   AND IF(CADLOC.LOC_CODLOC IS NULL, TRUE, (SELECT COUNT(1)  FROM MAPDET  ');
  qryDestino.qryQuery.SQL.Add('                                             INNER JOIN MAPGER ON MAPGER.AUTOINCREM = MPD_SEQGER   ');
  qryDestino.qryQuery.SQL.Add('                                             WHERE MPD_LOCFIS = LOC_CODLOC ');
  If (rdgListagem.ItemIndex = 0) And (Not chkLocFisVazia.Checked) Then
    qryDestino.qryQuery.SQL.Add('                                               AND IF(MPG_ITEMAP ="S",  MPD_CODITE = LOT_CODITE, TRUE) ');
  qryDestino.qryQuery.SQL.Add('                                               AND MPD_STATUS <> "F" ');
  qryDestino.qryQuery.SQL.Add('                                               AND MPD_CODEMP = LOC_CODEMP) = 0) ');
  qryDestino.qryQuery.SQL.Add('   AND IF(L.LOT_NUMLOT IS NOT NULL, (SELECT COUNT(1) FROM MAPDET WHERE MPD_NUMLOT = LOT_NUMLOT AND MPD_CODITE = LOT_CODITE AND MPD_CODEMP = LOT_CODEMP AND MPD_STATUS <> "F") = 0, ');
  qryDestino.qryQuery.SQL.Add('                                    (SELECT COUNT(1) FROM MAPDET WHERE MPD_CODITE = G.ITE_CODITE AND MPD_CODEMP = G.ITE_CODEMP AND MPD_STATUS <> "F") = 0) ');

  qryDestino.qryQuery.SQL.Add('   AND IFNULL(L.LOT_LOCFIS, "") <> "" ');
  qryDestino.qryQuery.SQL.Add('   AND IF(L.LOT_NUMLOT IS NOT NULL, LOT_STATUS = "S", TRUE) ');
  If (rdgListagem.ItemIndex = 1) And (Not chkLocFisVazia.Checked) Then
    qryDestino.qryQuery.SQL.Add('   AND IF(L.LOT_NUMLOT IS NOT NULL, LOT_SALDOS > 0, TRUE) ');

  If chkMovProgramada.Checked Then
    qryDestino.qryQuery.SQL.Add('AND IF(L.LOT_NUMLOT IS NOT NULL, LOC_CODLOC NOT IN(' +  strMovLotIte + '), TRUE)');

  pInsereParametrosNoSql(qryDestino);

  qryDestino.qryQuery.SQL.Add(fStrLocate(edtFornecedor, arrLinFor,  'C.ITE_CODFOR', 'CODFOR'));
  qryDestino.qryQuery.SQL.Add(fStrLocate(edtCodDep,     arrCodDep,  'C.ITE_CODDEP', 'CODDEP'));
  qryDestino.qryQuery.SQL.Add(fStrLocate(edtCodIte,     arrProdut, 'C.ITE_CODITE', 'CODITE'));
  If Not fEmptyStr(mskLinhaGrupo.Text) Then
    qryDestino.qryQuery.SQL.Add(fStrLocateLinGru(mskLinhaGrupo, arrLinGru, 'C.ITE_CODGRU','CODGRU'));
  qryDestino.qryQuery.SQL.Add(fStrLocate(edtMarca,      arrLinMar, 'C.ITE_CODMAR', 'CODMAR'));
  qryDestino.qryQuery.SQL.Add(fStrLocate(edtCodLocSep,  arrLocSep, 'L.LOT_LOCSEP', 'CODSEP'));

  If chkExcluirItensSaldoReservado.Checked Then
  Begin
    qryDestino.qryQuery.SQL.Add('        AND (IFNULL(LOT_QTPD_V, 0) ');
    qryDestino.qryQuery.SQL.Add('        + IFNULL(LOT_QTPD_F, 0)');
    qryDestino.qryQuery.SQL.Add('        + IFNULL(LOT_QTPD_P, 0)');
    qryDestino.qryQuery.SQL.Add('        + IFNULL(LOT_QTPD_E, 0) = 0)');
  End;

  If (rdgListagem.ItemIndex = 1) And (chkLocFisVazia.Checked) Then
  Begin
    qryDestino.qryQuery.SQL.Add('UNION ALL');
    qryDestino.qryQuery.SQL.Add(' SELECT');
    qryDestino.qryQuery.SQL.Add('   CAST("D" AS CHAR(1)) AS MARCAD,');
    qryDestino.qryQuery.SQL.Add('   CAST("" AS CHAR(1)) ITE_CODITE,');
    qryDestino.qryQuery.SQL.Add('   LOC_CODEMP AS ITE_CODEMP,');
    qryDestino.qryQuery.SQL.Add('   CAST("" AS CHAR(1)) AS ITE_DESITE,');
    qryDestino.qryQuery.SQL.Add('   LOC_CODLOC AS LOT_LOCFIS,');
    qryDestino.qryQuery.SQL.Add('   CAST("" AS CHAR(1)) LOT_NUMLOT,');
    qryDestino.qryQuery.SQL.Add('   LOC_DESCRI,');
    qryDestino.qryQuery.SQL.Add('   0.00 AS SALDO_ITE,');
    qryDestino.qryQuery.SQL.Add('   0.00 AS ENTREGA_FUTURA_ITE,');
    qryDestino.qryQuery.SQL.Add('   0.00 AS SALDO_LOT,');

    qryDestino.qryQuery.SQL.Add('   0.0000 AS SALRES,');

    qryDestino.qryQuery.SQL.Add('   0.00 AS ENTREGA_FUTURA_LOT,');
    qryDestino.qryQuery.SQL.Add('   0 AS SALDO_CALC');

    qryDestino.qryQuery.SQL.Add('   FROM CADLOC');
    qryDestino.qryQuery.SQL.Add(' WHERE LOC_CODEMP = "'+ VS_StrCodEmp + '"');
    qryDestino.qryQuery.SQL.Add('  AND (SELECT COUNT(1) FROM MAPDET WHERE MPD_LOCFIS = LOC_CODLOC AND MPD_CODEMP = LOC_CODEMP AND MPD_STATUS <> "F") = 0 ');
    If chkMovProgramada.Checked Then
      qryDestino.qryQuery.SQL.Add('  AND LOC_CODLOC NOT IN(' +  strMovLot + ')');

    qryDestino.qryQuery.SQL.Add('  AND LOC_ATIVO_ = "S" ');
    pInsereParametrosNoSql(qryDestino);
    qryDestino.qryQuery.SQL.Add(') TMP');

    If (Not blnDetalhe) Then
      qryDestino.qryQuery.SQL.Add(' GROUP BY LOT_LOCFIS');

  End
  Else
  Begin
    If (rdgListagem.ItemIndex = 1) And (Not blnDetalhe)  Then
      qryDestino.qryQuery.SQL.Add(' GROUP BY L.LOT_LOCFIS');
    qryDestino.qryQuery.SQL.Add(') TMP');
  End;
  If rdgSaldo.Enabled Then
  Begin
     case rdgSaldo.itemIndex of
        0: qryDestino.qryQuery.SQL.Add(' WHERE  SALDO_CALC > 0');
        1: qryDestino.qryQuery.SQL.Add(' WHERE  SALDO_CALC = 0');
        3: qryDestino.qryQuery.SQL.Add(' WHERE  SALDO_CALC < 0');
     end;
  End;

  pSetaParametros(qryDestino);
end;

procedure TfrmGeradorMapaDeInventarioParaColetores.pSetaParametros(qryDestino: TZClient);
begin
  pSetaParam(edtFornecedor.Text, arrLinFor, strLinFor, 'CODFOR', qryDestino.qryQuery);
  pSetaParam(edtCodDep.Text,     arrCodDep, strCodDep, 'CODDEP', qryDestino.qryQuery);
  pSetaParam(edtCodIte.Text,     arrProdut, strProdut, 'CODITE', qryDestino.qryQuery);
  pSetaParam(mskLinhaGrupo.Text, arrLinGru, strLinGru, 'CODGRU', qryDestino.qryQuery);
  pSetaParam(edtMarca.Text,      arrLinMar, strLinMar, 'CODMAR', qryDestino.qryQuery);
  pSetaParam(edtCodLocSep.Text,  arrLocSep, strLocSep, 'CODSEP', qryDestino.qryQuery);
end;

procedure TfrmGeradorMapaDeInventarioParaColetores.rdgListagemClick(
  Sender: TObject);
begin
  pAjustaColunas;
  btnBusca.Click;
  chkLocFisVazia.Enabled := False;
  rdgSaldo.Enabled := True;

  If rdgListagem.ItemIndex = 0 Then
  begin
    chkLocFisVazia.Checked := False;
    chkExcluirItensSaldoReservado.Enabled := True;
    chkApenasItensMapeados.Enabled := True;
  End
  Else
  begin
    chkLocFisVazia.Enabled := True;
    rdgSaldo.Enabled := False;
    chkExcluirItensSaldoReservado.Enabled := false;
    chkExcluirItensSaldoReservado.Checked := false;
    chkApenasItensMapeados.Enabled := False;
    chkApenasItensMapeados.Checked := false;
  End
end;

procedure TfrmGeradorMapaDeInventarioParaColetores.btnConfirmarClick(
  Sender: TObject);
  var
    strMensagem: String;
begin
  inherited;
  If Not btnConfirmar.Enabled Then
    Exit;
  qryMapa.DisableControls;
  Try
    If fGerarInventario(strMensagem) then
    Begin
      pMensagemOk('Mapa de Inventario Gerado!');
      Close;
    End
    Else If Not fEmptyStr(strMensagem) Then
      pMensagemOk(strMensagem);
  finally
    qryMapa.EnableControls;
  end;
end;

function TfrmGeradorMapaDeInventarioParaColetores.fValidaOperadorPreenchido(var strMensagem: String): Boolean;
begin
  strMensagem := '';
  If fEmptyStr(edtCodOpe.text) Then
    strMensagem := 'É preciso informar o operador.';

  If fEmptyStr(edtDesOpe.Text) Then
    strMensagem := 'Operador informado é inválido.';

  If Not fVerificaAcessoSistema('btnBalanco', edtCodOpe.Text) Then
    strMensagem := 'Operador sem direto de acesso ao balanço de estoque!';

  Result := strMensagem = '';
  If not Result Then
    pSetFocus(edtCodOpe);
End;

function TfrmGeradorMapaDeInventarioParaColetores.fGeraInventario(
  pgbStatus: TcxProgressBar): Boolean;
var
  strAutIncGer: String;
  strAutIncDet: String;
  intQtdRegistros: integer;
  objBatchMapDet: TBatchSQL;
  objBatchItens: TBatchSQL;
begin
  intQtdRegistros :=  fGetQuantidadeRegistros;
  pgbStatus.Properties.Max := intQtdRegistros;
  result := fGeraMapger(strAutIncGer);
  If result Then
  begin
    objBatchMapDet := TBatchSQL.Create(Nil);
    objBatchItens := TBatchSQL.Create(Nil);
    Try
      objBatchMapDet.BatchSize := 500;
      objBatchItens.BatchSize := 500;
      qryMapa.First;
      strAutIncDet := '';
      while not qryMapa.Eof do
      begin
        result := fGerenciaMapDetGravacao(intQtdRegistros, strAutIncGer, strAutIncDet, objBatchMapDet, objBatchItens);
        If not result Then
          Exit;
        qryMapa.Next;
        pgbStatus.Position := qryMapa.RecNo;
        if qryMapa.RecNo mod 10 =  0 then
          ApplicatioN.ProcessMessages;
      end;
      result := fExecutaScriptMapDet(objBatchMapDet);
      If result Then
        result := fExecutaScriptItens(objBatchItens);
    Finally
      FreeAndNil(objBatchMapDet);
      FreeAndNil(objBatchItens);
    End;
  end;
end;

function TfrmGeradorMapaDeInventarioParaColetores.fGerenciaMapDetGravacao(intQtdRegistros: integer; strAutIncGer: String; var  strAutIncDet: string; objBatchMapDet, objBatchItens: TBatchSQL): Boolean;
begin
  Result := False;

  If rdgListagem.ItemIndex = 0 Then
  Begin
      pSetAutoincrem(strAutIncDet, intQtdRegistros);
    Result := fGeraScriptMapDet(strAutIncGer, strAutIncDet, qryMapa, objBatchMapDet, objBatchItens);
  End
  Else
  Begin
    qryMapaDetalhado.Filtered := False;
    qryMapaDetalhado.Filter := 'LOT_LOCFIS = ' + QuotedStr(qryMapa.FieldByName('LOT_LOCFIS').AsString);
    qryMapaDetalhado.Filtered := True;
    While not qryMapaDetalhado.Eof Do
    begin
      If fPulaRegistroNumLotVazio then
      Begin
        qryMapaDetalhado.Next;
        continue;
      End;

      pSetAutoincrem(strAutIncDet, intQtdRegistros);
      Result := fGeraScriptMapDet(strAutIncGer, strAutIncDet, qryMapaDetalhado, objBatchMapDet, objBatchItens);
      If not Result Then
        Exit;
      qryMapaDetalhado.Next
    End;
  End;
End;

function TfrmGeradorMapaDeInventarioParaColetores.fPulaRegistroNumLotVazio: Boolean;
begin
  Result := False;
  If qryMapaDetalhado.RecordCount > 1  Then
    If qryMapaDetalhado.FieldByname('LOT_NUMLOT').AsString = '' Then
      Result := True;
End;

procedure TfrmGeradorMapaDeInventarioParaColetores.pSetAutoincrem(var strAutIncDet: String; intQtdRegistros: integer);
begin
  If strAutIncDet = '' Then
    strAutIncDet:= fRetAutoIncrem('MAPDET', VS_StrCodEmp, intQtdRegistros)
  Else
    pIncrementaAutoIncrem(strAutIncDet);
end;

function TfrmGeradorMapaDeInventarioParaColetores.fGeraScriptMapDet(
  strAutIncGer: String; strAutIncDet: String; qryFonteDados: TZClient; objBatchMapDet, objBatchItens: TBatchSQL): Boolean;
var
  varCodIte, varNumLot: Variant;
begin
  result := True;
  Try
    If qryFonteDados.FieldByname('ITE_CODITE').AsString <> '' Then
    Begin
      varCodIte := qryFonteDados.FieldByname('ITE_CODITE').AsString;
      varNumLot := qryFonteDados.FieldByname('LOT_NUMLOT').AsString;
    End
    Else
    Begin
      varCodIte := Null;
      varNumLot := Null;
    End;

    objBatchMapDet.BeginInsert('MAPDET')
      .Fields('AUTOINCREM, MPD_SEQGER, MPD_CODITE, MPD_LOCFIS, MPD_NUMLOT, MPD_QTDCON, MPD_STATUS, MPD_CODEMP, MPD_CODOPE, MPD_NUMCON')
      .Values(':AUTOINCREM, :MPD_SEQGER, :MPD_CODITE, :MPD_LOCFIS, :MPD_NUMLOT, :MPD_QTDCON, :MPD_STATUS, :MPD_CODEMP, :MPD_CODOPE, :MPD_NUMCON')
      .AddParam('AUTOINCREM', strAutIncDet, ftString)
      .AddParam('MPD_SEQGER', strAutIncGer, ftString)
      .AddParam('MPD_CODITE', varCodIte, ftString)
      .AddParam('MPD_LOCFIS', qryFonteDados.FieldByname('LOT_LOCFIS').AsString, ftString)
      .AddParam('MPD_NUMLOT', varNumLot, ftString)
      .AddParam('MPD_QTDCON', 0, ftFloat)
      .AddParam('MPD_STATUS', 'N', ftString)
      .AddParam('MPD_CODEMP', qryFonteDados.FieldByname('ITE_CODEMP').AsString, ftString)
      .AddParam('MPD_CODOPE', edtCodOpe.Text, ftString)
      .AddParam('MPD_NUMCON', '1', ftString)
      .EndInsert;

    If qryFonteDados.FieldByname('LOT_NUMLOT').AsString = '' Then
      objBatchItens.BeginUpdate('ITEGER')
        .SetClause('ITE_GMLCON = 0, ITE_DIFSAL = 0, ITE_DIF_ML = 0')
        .WhereClause('ITE_CODITE = :ITE_CODITE AND ITE_CODEMP = :ITE_CODEMP')
        .AddParam('ITE_CODITE', qryFonteDados.FieldByname('ITE_CODITE').AsString, ftString)
        .AddParam('ITE_CODEMP', qryFonteDados.FieldByname('ITE_CODEMP').AsString, ftString)
        .EndUpdate;

    If qryFonteDados.FieldByname('LOT_NUMLOT').AsString <> '' Then
      objBatchItens.BeginUpdate('CADLOT')
        .SetClause('LOT_SALCON = 0, LOT_DIFSAL = 0, LOT_ML_CON = 0, LOT_STATUS = :LOT_STATUS, LOT_DIF_ML = 0')
        .WhereClause('LOT_CODITE = :LOT_CODITE AND LOT_CODEMP = :LOT_CODEMP AND LOT_NUMLOT = :LOT_NUMLOT')
        .AddParam('LOT_STATUS', 'B', ftString)
        .AddParam('LOT_CODITE', qryFonteDados.FieldByname('ITE_CODITE').AsString, ftString)
        .AddParam('LOT_CODEMP', qryFonteDados.FieldByname('ITE_CODEMP').AsString, ftString)
        .AddParam('LOT_NUMLOT', qryFonteDados.FieldByname('LOT_NUMLOT').AsString, ftString)
        .EndUpdate;
  Except
    On e: Exception do
    Begin
      pMensagensErro(e.Message, '[TfrmGeradorMapaDeInventarioParaColetores.fGeraScriptMapDet]');
      Result := False;
    End;
  End;
end;

function TfrmGeradorMapaDeInventarioParaColetores.fExecutaScriptMapDet(objBatchMapDet: TBatchSQL): Boolean;
begin
  result := True;
  Try
    result := objBatchMapDet.Execute(qryComand);
  Except
    On e: Exception do
    Begin
      pMensagensErro(e.Message, '[TfrmGeradorMapaDeInventarioParaColetores.fExecutaScriptMapDet]');
      Result := False;
    End;
  End;
end;

function TfrmGeradorMapaDeInventarioParaColetores.fExecutaScriptItens(objBatchItens: TBatchSQL): Boolean;
begin
  result := True;
  Try
    result := objBatchItens.Execute(qryComand);
  Except
    On e: Exception do
    Begin
      pMensagensErro(e.Message, '[TfrmGeradorMapaDeInventarioParaColetores.fExecutaScriptItens]');
      Result := False;
    End;
  End;
end;

function TfrmGeradorMapaDeInventarioParaColetores.fGeraMapger(
  out strAutInc: String): Boolean;
begin
  Result := True;
  Try
    strCodInventario := fAtualizaProCod('MAPGER', 'MPG_NUMINV', '', 1, Nil,
      function (const AValue : String) : String
      begin
        Result := fPadL(AValue, 12, '0');
      end
    );
    strAutInc := fRetAutoIncrem('MAPGER', VS_strCodEmp);

    qryComand.SQL.Clear;
    qryComand.SQL.Add('INSERT INTO MAPGER (AUTOINCREM, MPG_NUMINV, MPG_CODOPE, MPG_CODEMP, MPG_ITEMAP) VALUES (:AUTOINCREM, :MPG_NUMINV, :MPG_CODOPE, :MPG_CODEMP, :MPG_ITEMAP)');
    qryComand.ParamByName('AUTOINCREM').AsString := strAutInc;
    qryComand.ParamByName('MPG_NUMINV').AsString := strCodInventario;
    qryComand.ParamByName('MPG_CODOPE').AsString := edtCodOpe.Text;
    qryComand.ParamByName('MPG_CODEMP').AsString := VS_StrCodEmp;
    qryComand.ParamByName('MPG_ITEMAP').AsString := IIf(chkApenasItensMapeados.Checked, 'S', 'N');

    qryComand.ExecSQL;

  Except
    on e: Exception do
    Begin
      Result := False;
      pMensagensErro(e.Message, '[TfrmGeradorMapaDeInventarioParaColetores.fGeraMapger]');
    End;
  End;
end;

procedure TfrmGeradorMapaDeInventarioParaColetores.pPreencheListaItensMarcados;
begin
  qryMapa.First;
  strCodItens := '';
  While not qryMapa.Eof do
  begin
    strCodItens := strCodItens + qryMapa.FieldByName('ITE_CODITE').AsString + ',';
    qryMapa.Next;
  End;
  strCodItens := '"' + AnsiReplaceStr(strCodItens, ',', '","') + '"';
  strCodItens := AnsiReplaceStr(strCodItens, ',""', '');

  qryMapa.First;
End;

function TfrmGeradorMapaDeInventarioParaColetores.fGerarInventario(var strMensagem: String): Boolean;
begin
  Result := False;
  strMensagem := '';

  If not fValidaOperadorPreenchido(strMensagem) then
    Exit;

  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    qryMapa.Filtered := False;
    qryMapa.Filter := 'MARCAD = ' + QuotedStr('M');
    qryMapa.Filtered := True;
    If qryMapa.IsEmpty then
    begin
      strMensagem := 'Nenhum registro selecionado. Impossível gerar mapa de inventário.';
      Exit;
    End;

    pPreencheListaItensMarcados;

    fStartTransaction;
    Try
      result := fGravaConDet;
      If result Then
      Begin
        frmGravando.Caption := 'processando';
        frmGravando.fExecutarAcao := fGeraInventario;
        frmGravando.Showmodal;

        result := frmGravando.blnConfirma;
        If result then
          fCommit
        Else
          fRollBack

      End;
    Except
      on e: exception do
      Begin
        fRollBack;
        pMensagensErro(e.Message, '[TfrmGeradorMapaDeInventarioParaColetores.fGerarInventario]');
      End;
    End;
  Finally
    qryMapa.Filtered := False;
    qryMapa.Filter := '';
    qryMapa.EnableControls;
    FreeAndNil(frmGravando);
  End;

End;

function TfrmGeradorMapaDeInventarioParaColetores.fGetQuantidadeRegistros: integer;
begin
  Result := 0;
  If rdgListagem.ItemIndex = 0 Then
  Begin
    Result := qryMapa.RecordCount;
    Exit;
  End;

  qryMapa.First;
  While not qryMapa.Eof Do
  begin
    qryMapaDetalhado.Filtered := False;
    qryMapaDetalhado.Filter := 'LOT_LOCFIS = ' + QuotedStr(qryMapa.FieldByName('LOT_LOCFIS').AsString);
    qryMapaDetalhado.Filtered := True;
    Result := Result + qryMapaDetalhado.RecordCount;
    qryMapa.Next;
  End;
end;

procedure TfrmGeradorMapaDeInventarioParaColetores.btnDesmarcarClick(
  Sender: TObject);
begin
  inherited;
  If Not btnDesmarcar.Enabled Then
    Exit;
  strMarcaDesMarca := 'D';
  processaMarcaDesmarcaTodos;
end;

procedure TfrmGeradorMapaDeInventarioParaColetores.btnEspacoClick(
  Sender: TObject);
begin
  inherited;
  If Not btnEspaco.Enabled Then
    Exit;

  pMarcaDesmarca(True);
end;

procedure TfrmGeradorMapaDeInventarioParaColetores.btnHlpImpClick(
  Sender: TObject);
begin
  inherited;
  pMensagemOk('Saldo reservado = Pedido de Venda + Pedido Filial + Pedido Endereçamento + Pedido Ordem de Produção.');
end;

procedure TfrmGeradorMapaDeInventarioParaColetores.btnMarcarTodosClick(
  Sender: TObject);
begin
  inherited;
  If Not btnMarcarTodos.Enabled Then
    Exit;

  strMarcaDesMarca := 'M';
  processaMarcaDesmarcaTodos;
end;

procedure TfrmGeradorMapaDeInventarioParaColetores.processaMarcaDesmarcaTodos;
begin
  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    frmGravando.Caption := 'Processando...';
    frmGravando.fExecutarAcao := fMarcaDesmarcaTodos;
    frmGravando.Showmodal;
  Finally
    FreeAndNil(frmGravando)
  End;
End;

function TfrmGeradorMapaDeInventarioParaColetores.fMarcaDesmarcaTodos(pgbStatus: TcxProgressBar = Nil): Boolean;
begin
  qryMapa.DisableControls;
  Try
    Result := True;
    pgbStatus.Properties.Max := qryMapa.RecordCount -1;
    qryMapa.First;
    while not qryMapa.Eof do
    begin
      pMarcaDesmarca;
      qryMapa.Next;
      pgbStatus.Position := qryMapa.RecNo;
      Application.ProcessMessages;
    End;
  Finally
    qryMapa.EnableControls;
  End;
end;

procedure TfrmGeradorMapaDeInventarioParaColetores.pMarcaDesmarca(blnInverte: Boolean = False);
begin
  qryMapa.Edit;
  If blnInverte Then
    qryMapa.fieldByName('MARCAD').AsString := IIf(qryMapa.fieldByName('MARCAD').AsString = 'D', 'M', 'D')
  Else
    qryMapa.fieldByName('MARCAD').AsString := strMarcaDesMarca;
  qryMapa.Post;
End;

procedure TfrmGeradorMapaDeInventarioParaColetores.cxgDadosKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If key = VK_SPACE Then
    btnEspaco.Click;
end;

destructor TfrmGeradorMapaDeInventarioParaColetores.Destroy;
begin
  freeAndNil(qryMapa);
  freeAndNil(qryMapaDetalhado);
  freeAndNil(qryComand);
  inherited;
end;

procedure TfrmGeradorMapaDeInventarioParaColetores.edtCodDepKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqDepartamento(Self, edtCodDep, edtDesCodDep, nil, key, arrCodDep, False) Then
  Begin
    if fValidaCampos(edtCodDep, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGeradorMapaDeInventarioParaColetores.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, nil, Key, arrProdut, False, nil, 'Consulta de Itens', '1') Then
  Begin
    fValidaCampos(edtCodIte, True);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGeradorMapaDeInventarioParaColetores.edtCodLocSepKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqLocSep(Self, edtCodLocSep, edtDesLocSep, Nil, Key, arrLocSep) Then
  Begin
    If fValidaCampos(edtCodLocSep, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGeradorMapaDeInventarioParaColetores.edtCodOpeKeyPress(Sender: TObject;
  var Key: Char);
begin

  inherited;
  if fPesqOperador(Self,
                   edtCodOpe,
                   edtDesOpe,
                   Nil,
                   Key,
                   arrOperad,
                   False) Then
  Begin
    If fValidaCampos(edtCodOpe, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmGeradorMapaDeInventarioParaColetores.edtFornecedorKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtFornecedor, edtDesFornecedor, Nil, Key, arrLinFor, False) Then
  Begin
    If fValidaCampos(edtFornecedor, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmGeradorMapaDeInventarioParaColetores.edtMarcaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqMarcas(Self, edtMarca, edtDesMarca, Nil, Key, arrLinMar, False) Then
  Begin
    If fValidaCampos(edtMarca, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGeradorMapaDeInventarioParaColetores.FormCreate(Sender: TObject);
begin
  inherited;
  qryMapa := TZClient.Create(Self);
  qryComand := fCriaQuery;
  pAjustaColunas;

  edtCodIte.TamCampo  := fTamCodIte;
  edtCodIte.MaxLength := fTamCodIte;
end;

procedure TfrmGeradorMapaDeInventarioParaColetores.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case key of
    VK_F10 :  btnConfirmar.Click;
    VK_F9  :  btnMarcarTodos.Click;
    VK_F8  :  btnDesmarcar.Click;
    VK_F5  :  btnBusca.Click;
  end;
end;

procedure TfrmGeradorMapaDeInventarioParaColetores.mskLinhaGrupoKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, nil, Key, arrLinGru, False) Then
  Begin
    If fValidaCampos(mskLinhaGrupo, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;


function TfrmGeradorMapaDeInventarioParaColetores.fGravaConDet: Boolean;
begin
  Result := False;
  Try
    // A MESMA TRAVA SERVE A HISTÓRICO DE CONTAGEM
    If fLock_Unlock(STR_TRAVA_CONDET, True, False) Then
    Begin
      If Not TConDet.fGravaConDetItens(Self, 'AND G.ITE_CODITE IN('+strCodItens+')', VS_strCodEmp, 'S', nil) Then
      Begin
        fLock_Unlock(STR_TRAVA_CONDET, False, False);
        Exit;
      End;

    End Else
    Begin
      pMensagemOk('Uma tarefa de balanço está sendo feita em outra estação: ' + fGetHostLock(STR_TRAVA_CONDET) + '. Tente novamente!');
      Exit;
    End;


    if fCfgSis('CONDET', varBoolean) Then
    Begin
      qryComand.SQL.Clear;
      qryComand.SQL.Add(' DELETE L                                             ');
      qryComand.SQL.Add(' FROM LOCCON L                                        ');
      qryComand.SQL.Add('   INNER JOIN CADITE I ON I.ITE_CODITE = L.ITE_CODITE ');
      qryComand.SQL.Add('   INNER JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE ');
      qryComand.SQL.Add('                      AND G.ITE_CODEMP = :CODEMP      ');
      qryComand.SQL.Add(' WHERE TRUE ');
      qryComand.SQL.Add('   AND G.ITE_CODITE IN('+strCodItens+')');
      qryComand.ExecSQL;
    End;
    Result := True;
    fLock_Unlock(STR_TRAVA_CONDET, False, False);
  Except
    on e: Exception do
    begin
      pMensagensErro(e.Message,'[TfrmGeradorMapaDeInventarioParaColetores.fGravaConDet]' );
      Result := False;
    End;
  End;
end;


end.

