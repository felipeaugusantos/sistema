unit untBalancoEstoqueGravar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Grids, DBGridCitel, DBGrids, Mask, MaskEditFocus, StdCtrls,
  EditFocus, AppEvnts, Menus, Buttons, ExtCtrls, DB, Uni, StrUtils,
  untFuncoesSimples, ComCtrls,  BitBtnLockedIncrem, untTypesSistema,
  untCadLote, cxProgressBar, frxClass, frxExportCSVTestabilidade, untConstantes,
  MemoFocus, Datasnap.DBClient, UniClientDataSet, untRelGeraOR, math,
  untRelatorio, untAuditoriaGravacaoSaldo, untBalancoEstoqueManutencao,
  System.Generics.Collections;   {Req. 456948-B - B1}

type
  {Req. 456948 - valores de ITEGER lidos uma vez por item, no lugar de
   reabrir qryIteGer a cada linha de divergencia.}
  TdtoCustoIteGer = record
    fltPreCus: Double;
    fltPreMed: Double;
    fltPreUlt: Double;
    fltImpUlt: Double;
    fltCnv_Ml: Double;
  End;

  TOpcGravacao = (opcAtivos, opcAtivar);
  TOpcRelDiferenca = (opcAtivo, opcInativo, opcTodos);

  TItemZera = record
   FCodite,
   FNumLot,
   FLocFis: string;
  end;


  TArrItemZera = array of TItemZera;

  TItemZeraList = class
  private
    FItems: TArrItemZera;
    {Req. 456948-B - B1. FIndice responde o Contains em O(1); FItems existe
     so para preservar a ordem de insercao, que a Fase 0 e a Fase 2 de
     fZeraItens consomem. FQtd e o tamanho logico - Length(FItems) e a
     capacidade, que cresce dobrando.}
    FIndice: TDictionary<String, Integer>;
    FQtd: Integer;
    function fChave(const ACodite, ANumLot, ALocFis: string): String;
  public
    procedure AddItem(const AItem: TItemZera);
    function GetItems: TArrItemZera;
    constructor Create;
    destructor Destroy; override;
    function Contains(const ACodite, ANumLot, ALocFis: string): Boolean;
    procedure Clear;
  end;

  TfrmBalancoEstoqueGravar = class(TfrmPai)
    pnlCabecalho: TPanel;
    lblLocIni: TLabel;
    lblLocFin: TLabel;
    lblLinhaGrupo: TLabel;
    edtLocIni: TEditFocus;
    edtLocFin: TEditFocus;
    mskLinhaGrupo: TMaskEditFocus;
    edtDesGrupo: TEditFocus;
    pnlProduto: TPanel;
    dbgItens: TDBGridCitel;
    btnConfirma: TBitBtnLocked;
    lblCodFor: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    pgbItens: TProgressBar;
    mmoInativos: TMemoFocus;
    UniClientDataSet1: TUniClientDataSet;
    shpMultSel: TShape;
    btnSemDivergencia: TBitBtnLocked;
    btnGravaTodos: TBitBtnLocked;
    btnGravaAtivos: TBitBtnLocked;
    btnImprimeInativos: TBitBtnLocked;
    lblCodIte: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    lblCodMar: TLabel;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    lblCodDep: TLabel;
    edtCodDep: TEditFocus;
    edtDesDep: TEditFocus;
    lblCodUni: TLabel;
    edtCodUni: TEditFocus;
    edtDesUni: TEditFocus;
    lblPrdGru: TLabel;
    edtPrdGru: TEditFocus;
    edtDesPrdPro: TEditFocus;
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgItensKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgItensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    {Req. 456948-B - fMarcaAjuCadLot, fMarcaAjuIteger, fAjusteQtdIteger e
     fAjusteQtdCadLot foram removidas: substituidas por fAplicaAjusteIteger
     e fAplicaAjusteCadLot, uma passada derivando de MOVDET apos o laco.}
    function fAplicaAjusteIteger(AsltDocs: TStringList): Boolean;
    function fAplicaAjusteCadLot(AsltDocs: TStringList): Boolean;

    procedure btnImprimeInativosClick(Sender: TObject);
    procedure btnGravaAtivosClick(Sender: TObject);
    procedure btnGravaTodosClick(Sender: TObject);
    procedure pGeraRelatorioDivergencia(strStatus: String);
    procedure edtCodForExit(Sender: TObject);
    procedure btnSemDivergenciaClick(Sender: TObject);
    procedure edtCodIteExit(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarExit(Sender: TObject);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteEnter(Sender: TObject);
    procedure edtCodDepExit(Sender: TObject);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodUniExit(Sender: TObject);
    procedure edtCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure edtPrdGruExit(Sender: TObject);
    procedure edtPrdGruKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    GerenciaBalancoEstoqueManutencao: TGerenciaBalancoEstoqueManutencao;
    strMOVFUL: String;
    intQtdItens: Integer;
    strCodItens: String;
    blnGerarTransferencia: Boolean;
    blnEfBaixExiste: Boolean;
    qryCadIte: TUniQuery;
    qryCommand: TUniQuery;
    opcGravacao: TOpcGravacao;
    objCadLot: TCadLot;
    dtsItens : TDataSource;
    arrLinhaGrupo,
    arrFornec: TConsultasArray;
    arrProduto: TConsultasArray;
    arrMarca: TConsultasArray;
    arrDepto: TConsultasArray;
    arrUnidade: TConsultasArray;
    arrGrupoPro: TConsultasArray;
    qryGen : TUniQuery;
    strImpAju : String;
    strPreAju : String;
    strLin : String;
    strFor : String;
    strIte : String;
    strMar : String;
    strDep : String;
    strGru : String;
    strUni : String;
    strClientePedVenda_Garantia_Nao_Coletada: String;
    strCCETRA: String;
    blnUtilizaMapaDeContagemColetor: Boolean;

    strOpcGra: String;
    strSeqCon: String;
    sltInsert: TStringList;
    stlAutInc: TStringList;
    dicCustoItem: TDictionary<String, TdtoCustoIteGer>;   {Req. 456948 - M5}
    sltItensSaldoAlterado: TStringList;                   {Req. 456948 - Q8}
    FintTemLocCritica: Integer;                            {Req. 456948-B - B5}
    qryLGCEST: TUniQuery;
    objAuditoriaSaldo: IAuditoriaGravacaoSaldo;
    FstrEspDoc: String;
    FstrNumDoc: String;
    FLOG_CODCON: String;
    FItemZeraList: TItemZeraList;
    blnConAcu: Boolean;
    FintConEst: Integer;
    procedure pBuscaItens(blnAberturaDaTela: Boolean = False);
    procedure pFinalizaMapDet(strCodIte, strNumLot: String);

    function fGetSQLPED_VENDA_GARANTIA_NAO_COLETADA: string;
    procedure pLimpaTela;
    procedure pHabilitaTela;
    procedure pSetaParametrosLog(qryConsulta: TUniQuery);

    function fConfirmaAjuste(AFinalizaContagem: Boolean; strEspDoc: String; pgbProgresso: TcxProgressBar; var strErro: string; var strDocsGerados: String; blnForcaSaida: Boolean = False): Boolean;
    function fCalcTotais(strEspDoc: String; PosRecNo: integer; Var blnGeraMovGer: Boolean): Double;
    function fTabPreco: String;
    function fTabPrecoImp: String;
    function fRetSQLItens(ABlnDivergencia: Boolean; blnHavingSemDivergencia: boolean = False): string;

    function fGravar(pgbProgresso: TcxProgressBar): Boolean;
    procedure pCriaTemporariasEmContagem;
    procedure pRemoveTemporaria;
    function fGetFiltrosSQL: string;
    procedure pCarregaBALZERZeramento;   {Req. 456948-B - B3}
    function fZeraItens(pgbProgresso: TcxProgressBar): Boolean;
//    function fCarregarConfigParaGerarOrcamento(var strConPgtMas, strCodConPgt: string): boolean;
    function fIncluiPedido(cdsConsulta: TUniQuery; var strErro: String): Boolean;
    function fGeraTransferenciaItem(DataSet: TDataSet): Boolean;

    Procedure pAjustaBotoes;

    procedure pSetarParametros(qryParam: TUniQuery);

    procedure pAtivaItem(strCodIte: String);

    procedure pCarregaCustoItens;        {Req. 456948 - M5}
    procedure pNotificaSaldoAbaixMinimo; {Req. 456948 - Q8}
    procedure pBombeiaSoRepaint;         {Req. 456948-B}

    function fLoteComLocalizacaoCritica(strCodIte,strNumLot: String): Boolean;

   function fGravaLogContagemEstoque(var ASeqCon: String): Boolean;
   Procedure pInsertLoteLGCEST;

   function fTrataCampoSalExt(AField: String): string;

   function fSqlTabelaQuantidadePendente: String;   {Req. 456948}

    { Private declarations }
  public
    blnContagemControlada: Boolean;

//    fGravaMovGer : TfGravaMovGer;
//    fGravaMovDet : TfGravaMovDet;
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses  untFuncoesConsulta, untCadIte, untConsultas, untGravando , untConDet,
      untRelBalancoEstoqueDiferenca, untMovGer, untHistoricoBalanco,
  untFuncFatImp, untFuncFatTypes, untFuncoesRel,
  untControleContagemBalancoEstoque, untGeraTransferencia,
  untTBatchSQL, untTBatchSQL.Helper, untControlaNotSaldoMin, untFuncoesGenerica;   {Req. 456948}

{$R *.dfm}

procedure TfrmBalancoEstoqueGravar.mskLinhaGrupoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, nil, Key, arrLinhaGrupo, False) Then
  Begin
    fvalidaCampos(mskLinhaGrupo,False);
    self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmBalancoEstoqueGravar.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinhaGrupo,edtDesGrupo,arrLinhaGrupo,fRetNomeLinhaGrupo,Nil,'da linha/grupo',6);
end;

function TfrmBalancoEstoqueGravar.fTabPreco: String;
  Var
    strSQL: String;
    qryAux: TUniQuery;
begin
  If (strPreAju = 'CLIENTE') Then
  Begin
    Try
      qryAux := fCriaQuery;

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  CLI_TABPRE ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADCLI ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CLI_CODCLI = :CODCLI ';

      With qryAux Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODCLI').AsString := fCfgSis('CLIAJU');
        Open;

        If Not IsEmpty Then
          Result := 'PREVE' + FieldByName('CLI_TABPRE').AsString
        Else
          Result := 'PREVE1';

      End;

    Except
      Result := 'PREVE1';
    End;
    FreeAndNil(qryAux);
  End
  Else
    Result := strPreAju;
end;

function TfrmBalancoEstoqueGravar.fTabPrecoImp: String;
begin

  if SameText(strImpAju,'TOTCUS' ) Then
    Result := 'PRECUS'
  Else
  if SameText(strImpAju,'TOTULT' ) Then
    Result := 'PREULT'
  Else
  if SameText(strImpAju,'IMPULT' ) Then
    Result := 'IMPULT'
  Else
  if SameText(strImpAju,'TOTMED' ) Then
    Result := 'PREMED';

  if SameText(strImpAju,'TOTITE' ) Then
    Result := fTabPreco

end;

function TfrmBalancoEstoqueGravar.fRetSQLItens(ABlnDivergencia: Boolean; blnHavingSemDivergencia: boolean = False): string;
  Var
    strSql,
    strTabPrecoImp : String;
    blnEntFut : Boolean;
begin

  blnEntFut := fCfgSis('ENTFUT', varBoolean);

  strTabPrecoImp := fTabPrecoImp;

  strSql := '';

  strSql := strSql + ' SELECT ';

  strSql := strSql + '  ITE_STATUS, ';
  strSql := strSql + '  ITE_ITEATI, ';
  strSql := strSql + '  ITE_PESOIT, ';
  strSql := strSql + '  ITE_PESLIQ, ';
  strSql := strSql + '  ITE_UNITAR, ';
  strSql := strSql + '  ITE_PRECUS, ';
  strSql := strSql + '  ITE_PREMED, ';
  strSql := strSql + '  ITE_IMPULT, ';
  strSql := strSql + '  ITE_PREULT, ';
  strSql := strSql + '  ITE_PREVE2, ';
  strSql := strSql + '  ITE_PREVE3, ';
  strSql := strSql + '  ITE_PREVE4, ';
  strSql := strSql + '  ITE_PREVE5, ';
  strSql := strSql + '  ITE_PREVE6, ';
  strSql := strSql + '  ITE_PREVE7, ';
  strSql := strSql + '  ITE_LOCFIS, ';

  strSql := strSql + '   ESPITE,     ITE_NUMLOT, TEMLOTE, ITE_CODGRU, ITE_CODITE, ITE_DESITE, ';
  strSql := strSql + '   ITE_CODMAR, ITE_REFERE, ITE_CODFOR, ITE_CODUNI, UNI_SIGUNI, ';
  strSql := strSql + '   ITE_PREVE1, ITE_VALUNE, ITE_VALUNG, ITE_INCPIS, ITE_SALCON + RESGAR + BEACCS + SALMAN + GARCOL AS ITE_SALCON, ';
  strSql := strSql + '   (ITE_SALDOS + ITE_ENTFUT ) AS ITE_SALDOS, ';
  strSql := strSql + '  ITE_ENTFUT AS ITE_ENTFUT, ';

  If FintConEst = 1 Then
  Begin
    strSql := strSql + '   -(ITE_DIFERE + ITE_ENTFUT)  + RESGAR + BEACCS + SALMAN + GARCOL   AS ITE_DIFERE, ';
    strSql := strSql + '   -(ITE_DIFGML)                           AS ITE_DIFGML, ';
    strSql := strSql + '   -(ITE_DIFERE + ITE_ENTFUT) * ITE_VALUNE AS ITE_TOTITE, ';
  End Else
  Begin
    strSql := strSql + '   -(ITE_DIFERE) AS ITE_DIFERE,  ';
    strSql := strSql + '   -(ITE_DIFGML) AS ITE_DIFGML,  ';
    strSql := strSql + '   -(ITE_TOTITE) AS ITE_TOTITE,  ';
  End;
  strSql := strSql + ' RESGAR  + GARCOL AS ITE_RESGAR,  '; //Reservado para Garantia;
  strSql := strSql + ' SALMAN AS ITE_SALMAN, ';
  strSql := strSql + ' BEACCS AS ITE_BEACCS,  '; //Saldo Pedido Separado;
  strSql := strSql + ' SALEXT AS ITE_SALEXT,  '; //Saldo Externo;

  strSql := strSql + '   ITE_CNV_ML, ITE_SAL_ML, ITE_GMLCON, ITE_TOTGML, ';
  strSql := strSql + '   LOG_QTEF_A, LOG_QTEF_F, LOG_QTEF_P, LOG_SALFIS  ';
  strSql := strSql + ' FROM ( ';

  strSql := strSql + ' SELECT  SQL_NO_CACHE          ';
  strSql := strSql + '   IF(ITE_ITEATI = "S", "ATIVO", "INATIVO") AS ITE_STATUS, ';
  strSql := strSql + '   I.ITE_ITEATI AS ITE_ITEATI, ';
  strSql := strSql + ' 	 IF(I.ITE_CNV_ML > 0, "ML", "AJ") AS ESPITE, ';
  strSql := strSql + ' 	 IFNULL(LOT_NUMLOT, "") AS ITE_NUMLOT,       ';
  strSql := strSql + ' 	 IF(IFNULL((SELECT COUNT(1) FROM CADLOT WHERE LOT_CODITE = G.ITE_CODITE AND LOT_CODEMP = G.ITE_CODEMP LIMIT 1 ), 0 ) > 0, "S","N") AS TEMLOTE,       ';
  strSql := strSql + ' 	 I.ITE_CODGRU AS ITE_CODGRU, ';
  strSql := strSql + ' 	 G.ITE_CODITE AS ITE_CODITE, ';
  strSql := strSql + ' 	 I.ITE_DESITE AS ITE_DESITE, ';
  strSql := strSql + ' 	 I.ITE_CODMAR AS ITE_CODMAR, ';
  strSql := strSql + ' 	 I.ITE_REFERE AS ITE_REFERE, ';
  strSql := strSql + ' 	 I.ITE_CODFOR AS ITE_CODFOR, ';
  strSql := strSql + ' 	 I.ITE_CODUNI AS ITE_CODUNI, ';
  strSql := strSql + ' 	 U.UNI_SIGUNI AS UNI_SIGUNI, ';

  strSql := strSql + '  I.ITE_PESOIT AS ITE_PESOIT,';
  strSql := strSql + '  I.ITE_PESLIQ AS ITE_PESLIQ,';
  strSql := strSql + '  G.ITE_PRECUS AS ITE_UNITAR,';
  strSql := strSql + '  G.ITE_PRECUS AS ITE_PRECUS,';
  strSql := strSql + '  G.ITE_PREMED AS ITE_PREMED,';
  strSql := strSql + '  G.ITE_IMPULT AS ITE_IMPULT,';
  strSql := strSql + '  G.ITE_PREULT AS ITE_PREULT,';
  strSql := strSql + '  G.ITE_PREVE2 AS ITE_PREVE2,';
  strSql := strSql + '  G.ITE_PREVE3 AS ITE_PREVE3,';
  strSql := strSql + '  G.ITE_PREVE4 AS ITE_PREVE4,';
  strSql := strSql + '  G.ITE_PREVE5 AS ITE_PREVE5,';
  strSql := strSql + '  G.ITE_PREVE6 AS ITE_PREVE6,';
  strSql := strSql + '  G.ITE_PREVE7 AS ITE_PREVE7,';
  strSql := strSql + '  G.ITE_LOCFIS AS ITE_LOCFIS,';

  strSql := strSql + ' 	 G.ITE_PREVE1 AS ITE_PREVE1, ';                    //VALOR UNITARIO ORIGINAL
  strSql := strSql + ' 	 G.ITE_' + strTabPrecoImp + ' AS ITE_VALUNE, '; //VALOR UNITARIO EMBALAGEM

  strSql := strSql + ' 	 IF(I.ITE_CNV_ML > 0, (G.ITE_' + strTabPrecoImp +' /I.ITE_CNV_ML),   '; //VALOR UNITARIO GRAMAS
  strSql := strSql + ' 	                       G.ITE_' + strTabPrecoImp + ') AS ITE_VALUNG, '; //VALOR UNITARIO GRAMAS

  strSql := strSql + ' 	 I.ITE_INCPIS AS ITE_INCPIS, ';
  strSql := strSql + ' 	 IF(LOT_NUMLOT IS NULL, G.ITE_SALDOS - IF((' + fTrataCampoSalExt('G.ITE_SALEXT') + ' < 0) OR (' + fTrataCampoSalExt('G.ITE_SALEXT') + ' IS NULL), 0, ' + fTrataCampoSalExt('G.ITE_SALEXT') + '), LOT_SALDOS) AS ITE_SALDOS, ';
  strSql := strSql + ' 	 IF(LOT_NUMLOT IS NULL, G.ITE_SALCON, LOT_SALCON) AS ITE_SALCON, ';

  if blnEntFut And (Not fCfgSis('BEFTRG', VarBoolean)) Then
    strSql := strSql + ' IF(LOT_NUMLOT IS NULL, ' + fGetSQLSomaCamposEntregaFutura() + ', ' + fGetSQLSomaCamposEntregaFutura('', False, True) + ') AS ITE_ENTFUT, '
  Else
    strSql := strSql + '  0.00 AS ITE_ENTFUT, ';

  If FintConEst = 1 Then
  Begin
    strSql := strSql + ' 	 IF(LOT_NUMLOT IS NULL, (G.ITE_SALDOS - IF((' + fTrataCampoSalExt('G.ITE_SALEXT') + ' < 0) OR (' + fTrataCampoSalExt('G.ITE_SALEXT') + ' IS NULL), 0, ' + fTrataCampoSalExt('G.ITE_SALEXT') + ') - G.ITE_SALCON), (LOT_SALDOS - LOT_SALCON)) AS ITE_DIFERE,  ';
    strSql := strSql + ' 	 IF(LOT_NUMLOT IS NULL, (G.ITE_SAL_ML - G.ITE_GMLCON), (LOT_SAL_ML - LOT_ML_CON)) AS ITE_DIFGML,      ';
    strSql := strSql + ' 	 ( IF(LOT_NUMLOT IS NULL, (G.ITE_SALDOS - IF((' + fTrataCampoSalExt('G.ITE_SALEXT') + ' < 0) OR (' + fTrataCampoSalExt('G.ITE_SALEXT') + ' IS NULL), 0, ' + fTrataCampoSalExt('G.ITE_SALEXT') + ') - G.ITE_SALCON), (LOT_SALDOS - LOT_SALCON)) * G.ITE_' + strTabPrecoImp + ') AS ITE_TOTITE, ' //TOTAL EMBALAGEM
  End Else
  Begin
    strSql := strSql + ' 	 IF(LOT_NUMLOT IS NULL,   G.ITE_DIFSAL, LOT_DIFSAL) AS ITE_DIFERE, ';
    strSql := strSql + ' 	 IF(LOT_NUMLOT IS NULL,   G.ITE_DIF_ML, LOT_DIF_ML) AS ITE_DIFGML, ';
    strSql := strSql + ' 	 ( IF(LOT_NUMLOT IS NULL, G.ITE_DIFSAL, LOT_DIFSAL) * G.ITE_' + strTabPrecoImp + ') AS ITE_TOTITE, '; //TOTAL EMBALAGEM
  End;

  if fCfgSis('ESTAJU', varInteger) = 2 then
    strSql := strSql + ' 	 IF(LOT_NUMLOT IS NULL, IFNULL(G.ITE_SALREG, 0), IFNULL(LOT_SALREG, 0)) AS RESGAR, '
  Else
    strSql := strSql + '0 AS RESGAR, ';

  if fCfgSis('ESTMAN', varInteger) = 2 then
    strSql := strSql + ' 	 IF(LOT_NUMLOT IS NULL, IFNULL(M.ITE_SALMAN, 0), IFNULL(LM.LOT_SALMAN, 0)) AS SALMAN, '
  Else
    strSql := strSql + '0 AS SALMAN, ';

  if TGerenciaBalancoEstoqueManutencao.fhabilitadoBEACCS  then
    strSql := strSql + ' 	 IF(LOT_NUMLOT IS NULL, IFNULL(B.ITE_BEACCS, 0), IFNULL(LB.LOT_BEACCS, 0)) AS BEACCS, '
  Else
    strSql := strSql + '0 AS BEACCS, ';


  strSql := strSql + ' ' +fGetSQLPED_VENDA_GARANTIA_NAO_COLETADA + ' AS GARCOL,';

  If fCfgSis('ESTEXT', varBoolean) Then
    strSql := strSql + ' IF(LOT_NUMLOT IS NULL, ' + fTrataCampoSalExt('G.ITE_SALEXT') + ', LOT_SALDOS) AS SALEXT, '
  Else
    strSql := strSql + ' 0 AS SALEXT, ';

  strSql := strSql + ' 	 I.ITE_CNV_ML AS ITE_CNV_ML, ';
  strSql := strSql + ' 	 IF(LOT_NUMLOT IS NULL, G.ITE_SAL_ML, LOT_SAL_ML) AS ITE_SAL_ML, ';
  strSql := strSql + ' 	 IF(LOT_NUMLOT IS NULL, G.ITE_GMLCON, LOT_ML_CON) AS ITE_GMLCON, ';

  strSql := strSql + ' 	 IF(LOT_NUMLOT IS NULL, ';
  strSql := strSql + '   	 ((G.ITE_SAL_ML - G.ITE_GMLCON) *                                            '; //TOTAL (GRAMAS/ML)
  strSql := strSql + ' 	   (IF(I.ITE_CNV_ML > 0,(G.ITE_' + strTabPrecoImp + ' / I.ITE_CNV_ML),      '; //TOTAL (GRAMAS/ML)
  strSql := strSql + ' 	                         G.ITE_' + strTabPrecoImp + '))),';

  strSql := strSql + '   	 ((LOT_SAL_ML - LOT_ML_CON) *                                            '; //TOTAL (GRAMAS/ML)
  strSql := strSql + ' 	   (IF(I.ITE_CNV_ML > 0,(G.ITE_' + strTabPrecoImp + ' / I.ITE_CNV_ML),      '; //TOTAL (GRAMAS/ML)
  strSql := strSql + ' 	                         G.ITE_' + strTabPrecoImp + ')))) AS ITE_TOTGML,  '; //TOTAL (GRAMAS/ML)

  strSql := strSql + '    G.ITE_QTEF_A AS LOG_QTEF_A, ';
  strSql := strSql + '    G.ITE_QTEF_F AS LOG_QTEF_F, ';
  strSql := strSql + '    G.ITE_QTEF_P AS LOG_QTEF_P, ';
  strSql := strSql + '    (IFNULL(G.ITE_SALDOS, 0) + IFNULL(G.ITE_QTEF_A, 0) + IFNULL(G.ITE_QTEF_F, 0) + IFNULL(G.ITE_QTEF_P, 0)) AS LOG_SALFIS ';

  strSql := strSql + ' FROM       ';
  strSql := strSql + ' 	 ITEGER G ';
  strSql := strSql + ' 	 JOIN CADITE      I ON G.ITE_CODITE  = I.ITE_CODITE   ';
  strSql := strSql + ' 	 LEFT JOIN CADUNI U ON (I.ITE_CODUNI = U.UNI_CODUNI)  ';
  strSql := strSql + ' 	 LEFT JOIN CADLOT   ON I.ITE_CODITE  = LOT_CODITE AND ';
  strSql := strSql + ' 	                       LOT_CODEMP    = :CODEMP AND    ';
  strSql := strSql + ' 	                       LOT_DIGCON    = "S"            ';
  If Assigned(GerenciaBalancoEstoqueManutencao) Then
  Begin
    If (fCfgSis('ESTMAN') = '2') Then
    Begin
      strSql := strSql + '   LEFT JOIN '+GerenciaBalancoEstoqueManutencao.strTabela_Lote_ESTMAN + ' LM ON LM.FDO_CODITE = LOT_CODITE AND LM.ID_OPERACAO = "' + GerenciaBalancoEstoqueManutencao.IDOperacao + '" ';
      strSql := strSql + '  AND  LM.FGO_EMPEXP = LOT_CODEMP ';
      strSql := strSql + '  AND  LM.FDO_NUMLOT = LOT_NUMLOT ';
      strSql := strSql + '   LEFT JOIN '+GerenciaBalancoEstoqueManutencao.strTabela_Itens_ESTMAN +' M ON M.FDO_CODITE = G.ITE_CODITE AND M.ID_OPERACAO = "' + GerenciaBalancoEstoqueManutencao.IDOperacao + '" ';
      strSql := strSql + '  AND  M.FGO_EMPEXP = G.ITE_CODEMP ';
    End;
    If GerenciaBalancoEstoqueManutencao.fhabilitadoBEACCS Then
    Begin
      strSql := strSql + '   LEFT JOIN '+GerenciaBalancoEstoqueManutencao.strTabela_Lote_BEACCS+' LB ON LB.FDO_CODITE = LOT_CODITE  AND LB.ID_OPERACAO = "' + GerenciaBalancoEstoqueManutencao.IDOperacao + '" ';
      strSql := strSql + '  AND  LB.FGO_CODEMP = LOT_CODEMP ';
      strSql := strSql + '  AND  LB.FDO_NUMLOT = LOT_NUMLOT ';
      strSql := strSql + '   LEFT JOIN '+GerenciaBalancoEstoqueManutencao.strTabela_Itens_BEACCS +' B ON B.FDO_CODITE = G.ITE_CODITE  AND B.ID_OPERACAO = "' + GerenciaBalancoEstoqueManutencao.IDOperacao + '" ';
      strSql := strSql + '  AND  B.FGO_CODEMP = G.ITE_CODEMP ';
    End;
  End;
  strSql := strSql + ' WHERE       ';
  strSql := strSql + '   G.ITE_CODEMP = :CODEMP      AND ';
  strSql := strSql + '   ((G.ITE_DIGCON = "S") OR (LOT_DIGCON = "S"))        ';

  strSql := strSql +  fGetFiltrosSQL;

  If ABlnDivergencia and (not blnHavingSemDivergencia) Then
  Begin
    strSql := strSql + ' 	HAVING ';

    If FintConEst = 1 Then
    Begin
      strSql := strSql + '   (    ';
      strSql := strSql + '    (   ';
      strSql := strSql + '     ( ITE_NUMLOT = "" ) AND                                    ';
      strSql := strSql + '  	 (FORMAT(ITE_SALDOS + ITE_ENTFUT,3) <> FORMAT(ITE_SALCON + RESGAR  + BEACCS + SALMAN + GARCOL, 3)';
      strSql := strSql + ' 	    OR (FORMAT(ITE_SAL_ML,4) <> FORMAT(ITE_GMLCON,4))         ';
      strSql := strSql + '    )   ';
      strSql := strSql + '   ) OR ';
      strSql := strSql + '    (   ';
      strSql := strSql + '     ( ITE_NUMLOT <> "" ) AND                                   ';
      strSql := strSql + '  	 (FORMAT(ITE_SALDOS+ITE_ENTFUT,3) <> FORMAT(ITE_SALCON + RESGAR + BEACCS + SALMAN + GARCOL,3)';
      strSql := strSql + ' 	    OR (FORMAT(ITE_SAL_ML,4) <> FORMAT(ITE_GMLCON,4)))         ';
      strSql := strSql + '    )   ';
      strSql := strSql + '   )    ';
    End Else
    Begin
      strSql := strSql + '  (     ';
      strSql := strSql + '   (    ';
      strSql := strSql + '     ( ITE_NUMLOT = "" ) AND          ';
      strSql := strSql + '     (    (ROUND(ITE_DIFERE, 3) <> 0) ';
      strSql := strSql + '       OR (ROUND(ITE_DIFGML, 4) <> 0) ';
      strSql := strSql + '     )  ';
      strSql := strSql + '   ) OR ';
      strSql := strSql + '   (    ';
      strSql := strSql + '     ( ITE_NUMLOT <> "" ) AND          ';
      strSql := strSql + '     ((ROUND(ITE_DIFERE, 3) <> 0)      ';
      strSql := strSql + '       OR (ROUND(ITE_DIFGML, 4) <> 0)) ';
      strSql := strSql + '   )    ';
      strSql := strSql + '  )     ';
    End;
  end;
  If blnHavingSemDivergencia then
  begin
    strSql := strSql + ' 	HAVING ';

    If FintConEst = 1 Then
    Begin
      strSql := strSql + '   (    ';
      strSql := strSql + '    (   ';
      strSql := strSql + '     ( ITE_NUMLOT = "" ) AND                                    ';
      strSql := strSql + '  	 (FORMAT(ITE_SALDOS + ITE_ENTFUT,3) = FORMAT(ITE_SALCON + RESGAR  + BEACCS + SALMAN + GARCOL, 3)';
      strSql := strSql + ' 	    AND (FORMAT(ITE_SAL_ML,4) = FORMAT(ITE_GMLCON,4))         ';
      strSql := strSql + '    )   ';
      strSql := strSql + '   ) OR ';
      strSql := strSql + '    (   ';
      strSql := strSql + '     ( ITE_NUMLOT <> "" ) AND                                   ';
      strSql := strSql + '  	 (FORMAT(ITE_SALDOS+ITE_ENTFUT,3) = FORMAT(ITE_SALCON + RESGAR + BEACCS + SALMAN + GARCOL,3)';
      strSql := strSql + ' 	    AND (FORMAT(ITE_SAL_ML,4) = FORMAT(ITE_GMLCON,4)))         ';
      strSql := strSql + '    )   ';
      strSql := strSql + '   )    ';
    End Else
    Begin
      strSql := strSql + '  (     ';
      strSql := strSql + '   (    ';
      strSql := strSql + '     ( ITE_NUMLOT = "" ) AND (         ';
      strSql := strSql + '     (    (ROUND(ITE_DIFERE, 3) = 0) ';
      strSql := strSql + '       AND (ROUND(ITE_DIFGML, 4) = 0)) ';
      strSql := strSql + '     )  ';
      strSql := strSql + '   ) OR ';
      strSql := strSql + '   (    ';
      strSql := strSql + '     ( ITE_NUMLOT <> "" ) AND  (       ';
      strSql := strSql + '     (ROUND(ITE_DIFERE, 3) = 0)      ';
      strSql := strSql + '       AND (ROUND(ITE_DIFGML, 4) = 0)) ';
      strSql := strSql + '   )    ';
      strSql := strSql + '  )     ';
    End;

  end;

  strSql := strSql + ' 	ORDER BY       ';
  strSql := strSql + ' 	  ESPITE,      ';
  strSql := strSql + ' 	  G.ITE_CODITE ';

  strSql := strSql + ' ) TMP ';
  Result := strSql;
end;


{********************************************************************}
{* BUSCA DADOS DOS ITENS QUE POSSUEM ESTOQUE DIFERENTE DE CONTAGEM  *}
{*****************************************************************JC*}
procedure TfrmBalancoEstoqueGravar.pBuscaItens(blnAberturaDaTela: Boolean = False);
begin
  With qryGen Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(fRetSQLItens(True));

    pSetarParametros(qryGen);

    Open;

    If Not IsEmpty Then
    Begin

      Filtered := False;
      Filter   := 'ITE_NUMLOT = ' + QuotedStr('') + ' AND TEMLOTE = ' + QuotedStr('S');
      Filtered := True;

      If Not IsEmpty  Then
      Begin
        fMensagem('','Houve uma inconsistência nos dados, existe contagem de item sem lote.' + #13#10 + ' Entre em contato com a Citel!',['&O K']);
        btnConfirma.Enabled := False;
        Exit;
      End
      Else
      Begin
         Filtered := False;
         First;
      End;

      (FieldByName('ITE_SALDOS') AS TFloatField).DisplayFormat := '##,#0.000';
      (FieldByName('ITE_SALCON') AS TFloatField).DisplayFormat := '##,#0.000';
      (FieldByName('ITE_DIFERE') AS TFloatField).DisplayFormat := '##,#0.000';
      (FieldByName('ITE_SAL_ML') AS TFloatField).DisplayFormat := '##,#0.0000';
      (FieldByName('ITE_GMLCON') AS TFloatField).DisplayFormat := '##,#0.0000';
      (FieldByName('ITE_DIFGML') AS TFloatField).DisplayFormat := '##,#0.0000';

      dtsItens.DataSet := qryGen;
      pHabilitaTela;
      pSetFocus(dbgItens);
    End
    Else
    Begin
      If blnAberturaDaTela Then
      begin
        btnSemDivergencia.Visible := True;
        Exit;
      End;

      pLimpaTela;
      fMensagem('', 'Nenhum registro encontrado !',['&O K']);

      If fPergunta('Efetivar contagem dos itens sem divergencias?') Then
      Begin
        Try
          pCriarFormularios(TfrmGravando, frmGravando);
          frmGravando.blnTempoRestante := True;
          frmGravando.fExecutarAcao := fgravar;
          frmGravando.ShowModal;
          if frmGravando.blnConfirma Then
            fMensagem('','Gravação de arquivos concluída !',['&O K']);
        Finally
          FreeAndNil(frmGravando);
          pLimpaTela;
        End;
      End;
    End;

  End;

  pAjustaBotoes;
end;

procedure TfrmBalancoEstoqueGravar.pCriaTemporariasEmContagem;
var qryTmp: TUniQuery;
begin
  qryTmp := fCriaQuery;
  Try
    qryTmp.SQL.Add('DROP TEMPORARY TABLE IF EXISTS '+TMP_ITEGER_CONTAGEM+';');
    qryTmp.SQL.Add('DROP TEMPORARY TABLE IF EXISTS '+TMP_CADLOT_CONTAGEM+';');
    qryTmp.SQL.Add('CREATE TEMPORARY TABLE '+TMP_ITEGER_CONTAGEM+' SELECT * FROM ITEGER WHERE ITE_DIGCON = "S" AND ITE_CODEMP = "' + VS_strCodEmp + '";');
    qryTmp.SQL.Add('CREATE TEMPORARY TABLE '+TMP_CADLOT_CONTAGEM+' SELECT * FROM CADLOT WHERE LOT_DIGCON = "S" AND LOT_CODEMP = "' + VS_strCodEmp + '";');

    qryTmp.SQL.Add('ALTER TABLE `TMP_ITEGER_CONTAGEM` ');
    qryTmp.SQL.Add('  ADD INDEX `idx_tmp_iteger_1` (`ITE_CODITE`),');
    qryTmp.SQL.Add('  ADD INDEX `idx_tmp_iteger_2` (`ITE_CODEMP`);');
    qryTmp.SQL.Add('ALTER TABLE `TMP_CADLOT_CONTAGEM`');
    qryTmp.SQL.Add('  ADD INDEX `idx_tmp_cadlot_1` (`LOT_CODEMP`),');
    qryTmp.SQL.Add('  ADD INDEX `idx_tmp_cadlot_2` (`LOT_CODITE`),');
    qryTmp.SQL.Add('  ADD INDEX `idx_tmp_cadlot_3` (`LOT_NUMLOT`);');

    qryTmp.ExecSQL
  finally
    FreeAndNil(qryTmp);
  End;
end;

procedure TfrmBalancoEstoqueGravar.pRemoveTemporaria;
var qryTmp: TUniQuery;
begin
  qryTmp := fCriaQuery;
  try
    qryTmp.SQL.Add('DROP TEMPORARY TABLE IF EXISTS '+TMP_ITEGER_CONTAGEM + ';');
    qryTmp.SQL.Add('DROP TEMPORARY TABLE IF EXISTS '+TMP_CADLOT_CONTAGEM + ';');
    qryTmp.ExecSQL;
  finally
    FreeAndNil(qryTmp);
  End
end;

procedure TfrmBalancoEstoqueGravar.pFinalizaMapDet(strCodIte, strNumLot: String);
begin
  qryCommand.SQl.Clear;
  qryCommand.SQl.Add('UPDATE MAPDET');
  qryCommand.SQl.Add('INNER JOIN CADLOT ON LOT_CODITE = MPD_CODITE');
  qryCommand.SQl.Add('                 AND LOT_CODEMP = MPD_CODEMP');
  qryCommand.SQl.Add('                 AND LOT_NUMLOT = MPD_NUMLOT');
  qryCommand.SQl.Add('SET LOT_STATUS = IF(LOT_STATUS = "B", "S", LOT_STATUS)');

  qryCommand.SQl.Add('WHERE MPD_STATUS = "C"');
  If strCodIte <> '' Then
    qryCommand.SQl.Add('AND MPD_CODITE = "'+strCodIte+'"');
  If strNumLot <> '' Then
    qryCommand.SQl.Add('AND MPD_NUMLOT = "'+strNumLot+'"');
  qryCommand.SQl.Add('AND MPD_CODEMP = "'+VS_StrCodemp+'"');
  qryCommand.ExecSQL;

  qryCommand.SQl.Clear;
  qryCommand.SQl.Add('UPDATE MAPDET SET MPD_STATUS = "F"');
  qryCommand.SQl.Add('WHERE TRUE ');
  If strCodIte <> '' Then
    qryCommand.SQl.Add('AND MPD_CODITE = "'+strCodIte+'"');
  If strNumLot <> '' Then
    qryCommand.SQl.Add('AND MPD_NUMLOT = "'+strNumLot+'"');

  qryCommand.SQl.Add('AND MPD_STATUS = "C"');
  qryCommand.SQl.Add('AND MPD_CODEMP = "'+VS_StrCodemp+'"');
  qryCommand.ExecSQL;
end;

procedure TfrmBalancoEstoqueGravar.pGeraRelatorioDivergencia(strStatus: String);
begin
  //REL_CODREL = '508118'
  TRelatorio.pExecutaRelatorio(239,
                               8118,
                               [],
                               ['CODITE',
                                'CODFOR',
                                'CODMAR',
                                'LINGRU',
                                'LOCINI',
                                'LOCFIN',
                                'CODDEP',
                                'CODUNI',
                                'STATUS'],
                               [fStrFiltroAtaRelEditor(edtCodIte, arrProduto),
                                fStrFiltroAtaRelEditor(edtCodFor, arrFornec),
                                fStrFiltroAtaRelEditor(edtCodMar, arrMarca),
                                fStrFiltroAtaRelEditor(mskLinhaGrupo, arrLinhaGrupo),
                                edtLocIni.Text,
                                edtLocFin.Text,
                                fStrFiltroAtaRelEditor(edtCodDep, arrDepto),
                                fStrFiltroAtaRelEditor(edtCodUni, arrUnidade),
                                strStatus],
                               Self,
                               [],
                               True);
end;

function TfrmBalancoEstoqueGravar.fGeraTransferenciaItem(DataSet: TDataSet): Boolean;
begin
  result := DataSet.FieldByName('ITE_DIFERE').AsFloat < 0;
end;

procedure TfrmBalancoEstoqueGravar.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  pDesligaBatchSaldosBalanco;
end;

procedure TfrmBalancoEstoqueGravar.FormCreate(Sender: TObject);
begin
  inherited;
  blnConAcu := fCfgSis('CONACU', varBoolean);
  FintConEst := fCfgSis('CONEST', varInteger);
  FItemZeraList := TItemZeraList.Create;
  dicCustoItem := TDictionary<String, TdtoCustoIteGer>.Create;   {Req. 456948 - M5}
  sltItensSaldoAlterado := TStringList.Create;                   {Req. 456948 - Q8}
  sltItensSaldoAlterado.Sorted     := True;
  sltItensSaldoAlterado.Duplicates := dupIgnore;
  strMOVFUL := fCfgSis('MOVFUL');
  If TGerenciaBalancoEstoqueManutencao.fUtilizaRecurso Then
    GerenciaBalancoEstoqueManutencao := TGerenciaBalancoEstoqueManutencao.pIniciaProcesso;

  intQtdItens := fCfgSis('ITEDOC');
  blnUtilizaMapaDeContagemColetor := fCfgSis('LRGMIC', varBoolean);
  blnEfBaixExiste := fCampoExiste('MOVDET', 'DET_EFBAIX', True);
  strClientePedVenda_Garantia_Nao_Coletada := fCfgSis('CCPVGC');
  strCCETRA := fCfgSis('CCETRA');

  qryCadIte := fCriaQuery(Self);
  qryCadIte.SQL.Text := 'UPDATE CADITE SET ITE_ITEATI = "S" WHERE ITE_CODITE = :CODITE';

  dtsItens := TDataSource.Create(Self);
  dbgItens.DataSource := dtsItens;
  qryGen := fCriaQuery(Self);

  If Not fCfgSis('USATMQ', varBoolean) Then
  Begin
    dbgItens.Columns[6].Visible := False;
    dbgItens.Columns[7].Visible := False;
    dbgItens.Columns[8].Visible := False;
  End;

  objCadLot := TCadLot.Create(Self);
  dbgItens.Columns[2].Title.Caption := objCadLot.strTitLab;

  opcGravacao := opcAtivos;
  strOpcGra := '';

  objAuditoriaSaldo := TAuditoriaGravacaoSaldo.New;

  edtCodIte.TamCampo := fTamCodIte;
end;

procedure TfrmBalancoEstoqueGravar.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FItemZeraList);
  If Assigned(dicCustoItem) Then
    FreeAndNil(dicCustoItem);
  If Assigned(sltItensSaldoAlterado) Then
    FreeAndNil(sltItensSaldoAlterado);
  IF Assigned(GerenciaBalancoEstoqueManutencao) Then
    FreeAndNil(GerenciaBalancoEstoqueManutencao);

  pDesligaBatchSaldosBalanco;

  inherited;
end;

procedure TfrmBalancoEstoqueGravar.edtCodDepExit(Sender: TObject);
begin
  inherited;
   pEdtCodSelectExit(edtCodDep, edtDesDep, arrDepto, fRetNomDep, nil, 'do Departamento');
end;

procedure TfrmBalancoEstoqueGravar.edtCodDepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqDepartamento(Self, edtCodDep, edtDesDep, Nil, Key, arrDepto, False) Then
  Begin
    fvalidaCampos(edtCodDep,True);
  End;
end;

procedure TfrmBalancoEstoqueGravar.edtCodForExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFor,edtNomFor,arrFornec,fRetNomFornecedor,nil,'do Fornecedor');
end;

procedure TfrmBalancoEstoqueGravar.edtPrdGruExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtPrdGru, edtDesPrdPro, arrGrupoPro, fRetNomeGrupoProduto, nil, 'do Grupo de Produtos', edtPrdGru.MaxLength);
end;


procedure TfrmBalancoEstoqueGravar.edtPrdGruKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupoProduto(Self, edtPrdGru, edtDesPrdPro, Nil, Key, arrGrupoPro, False) Then
  Begin
    If fValidaCampos(edtPrdGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

{**************************************************}
{* LIMPA DADOS TELA (PREPARA PARA NOVA CONSULTA)  *}
{***********************************************JC*}
procedure TfrmBalancoEstoqueGravar.pLimpaTela;
begin
  dtsItens.DataSet    := Nil;
  dbgItens.Enabled    := False;
  btnConfirma.Enabled := False;
  edtLocIni.Enabled   := True;
  edtLocFin.Enabled   := True;

  edtNomFor.Clear;
  edtCodFor.Clear;
  edtLocFin.Clear;
  edtLocIni.Clear;
  edtDesGrupo.Clear;
  mskLinhaGrupo.Clear;
  edtCodIte.Clear;
  edtDesIte.Clear;
  edtCodMar.Clear;
  edtDesMar.Clear;
  edtDesDep.Clear;
  edtCodDep.Clear;
  edtCodUni.Clear;
  edtDesUni.Clear;
  strOpcGra := '';
  Self.SelectFirst;
end;

procedure TfrmBalancoEstoqueGravar.pSetarParametros(qryParam: TUniQuery);
begin
  with qryParam do
  Begin
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    pSetaParam(edtCodFor.Text, arrFornec,   strFor, 'CODFOR', qryParam);
    pSetaParam(edtCodIte.Text, arrProduto,  strIte, 'CODITE', qryParam);
    pSetaParam(edtCodMar.Text, arrMarca,    strMar, 'CODMAR', qryParam);
    pSetaParam(edtCodDep.Text, arrDepto,    strDep, 'CODDEP', qryParam);
    pSetaParam(edtPrdGru.Text, arrGrupoPro, strGru, 'PRDGRU', qryParam);

    If Not fEmptyStr(edtLocIni.Text) Then
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

    pSetaParam(mskLinhaGrupo.Text, arrLinhaGrupo, strLin, 'CODGRU', qryParam);

    If Not fEmptyStr(edtCodUni.Text) Then
    Begin
      pSetaParam(edtCodUni.Text, arrUnidade, strUni, 'CODUNI', qryParam);
    End;
  End;

end;

{******************************************}
{* HABILITA TELA PARA CONFIRMAR GRAVACAO  *}
{***************************************JC*}
procedure TfrmBalancoEstoqueGravar.pHabilitaTela;
begin
  dbgItens.Enabled    := True;
  btnConfirma.Enabled := True;
  edtLocIni.Enabled   := False;
  edtLocFin.Enabled   := False;
end;

procedure TfrmBalancoEstoqueGravar.pInsertLoteLGCEST;
Var
  qryLGCEST: TUniQuery;
Begin
  qryLGCEST := fCriaQuery;
  Try
    If sltInsert.Count > 0 Then
    Begin
      qryLGCEST.Close;
      qryLGCEST.SQL.Clear;
      qryLGCEST.SQL.Add(sltInsert.Text);
      qryLGCEST.ExecSQL;
      sltInsert.Clear;
    End;
  Finally
    FreeAndNil(qryLGCEST);
  End;
End;

function TfrmBalancoEstoqueGravar.fGravaLogContagemEstoque(var ASeqCon: String): Boolean;
  var blnFilter: Boolean;
      intPosIni: Integer;
      strInsert: String;
      strSQLIns: String;
      strAutInc: String;
Begin
  sltInsert := TStringList.Create;
  stlAutInc := TStringList.Create;
  qryLGCEST := fCriaQuery;

  strSeqCon := '';
  strSeqCon := VS_strCodEmp + fRetSequencial('SEQCON');

  strSQLIns := '';
  strSQLIns := strSQLIns + ' INSERT INTO ';
  strSQLIns := strSQLIns + ' LGCEST (    ';
  strSQLIns := strSQLIns + ' AUTOINCREM, ';
  strSQLIns := strSQLIns + ' LOG_CODCON, ';
  strSQLIns := strSQLIns + ' LOG_DTACAD, ';
  strSQLIns := strSQLIns + ' LOG_HRACAD, ';
  strSQLIns := strSQLIns + ' LOG_CODOPE, ';
  strSQLIns := strSQLIns + ' LOG_CODITE, ';
  strSQLIns := strSQLIns + ' LOG_CODEMP, ';
  strSQLIns := strSQLIns + ' LOG_NUMLOT, ';
  strSQLIns := strSQLIns + ' LOG_SALOLD, ';
  strSQLIns := strSQLIns + ' LOG_GMLOLD, ';
  strSQLIns := strSQLIns + ' LOG_SALNEW, ';
  strSQLIns := strSQLIns + ' LOG_GMLNEW, ';
  strSQLIns := strSQLIns + ' LOG_ENTFUT, ';
  strSQLIns := strSQLIns + ' LOG_QTEF_A, ';
  strSQLIns := strSQLIns + ' LOG_QTEF_F, ';
  strSQLIns := strSQLIns + ' LOG_QTEF_P, ';
  strSQLIns := strSQLIns + ' LOG_SALFIS, ';
  strSQLIns := strSQLIns + ' LOG_DIFERE, ';
  strSQLIns := strSQLIns + ' LOG_DIFGML, ';
  strSQLIns := strSQLIns + ' LOG_ITEATI, ';

  strSQLIns := strSQLIns + ' LOG_PRECUS, ';
  strSQLIns := strSQLIns + ' LOG_LOCFIS, ';
  strSQLIns := strSQLIns + ' LOG_CONACU, ';
  strSQLIns := strSQLIns + ' LOG_CONEST, ';
  strSQLIns := strSQLIns + ' LOG_OPCGRA  ';
  strSQLIns := strSQLIns + ' ) VALUES    ';

  Try
    intPosIni := qryGen.recNo;
    qryGen.DisableControls;
    qryGen.First;
    blnFilter := qryGen.Filtered;
    qryGen.Filtered := False;

    strAutInc := fRetAutoIncrem('LGCEST', VS_strCodEmp, qryGen.RecordCount);

    Try
      While not qryGen.Eof do
      Begin
        strInsert := strSQLIns;
        strInsert := strInsert + '(' + QuotedStr(strAutInc) + ', ' +                                                           //AUTOINCREM
                           QuotedStr(strSeqCon) + ', ' +                                                                       //LOG_SEQCON
                           QuotedStr(FormatDateTime('yyyy-mm-dd', VS_Date)) + ', ' +                                           //LOG_DTACAD
                           QuotedStr(FormatDateTime('hh:mm:ss', Time)) + ', ' +                                                //LOG_HRACAD
                           QuotedStr(strLoginUsuarioLogado) + ', ' +                                                           //LOG_CODOPE
                           QuotedStr(qryGen.FieldByName('ITE_CODITE').AsString) + ', ' +                                       //LOG_CODITE
                           QuotedStr(VS_strCodEmp) + ', ' +                                                                    //LOG_CODEMP
                           QuotedStr(qryGen.FieldByName('ITE_NUMLOT').AsString) + ', ' +                                       //LOG_NUMLOT
                           AnsiReplaceStr(FormatFloat('#0.0000', qryGen.FieldByName('ITE_SALDOS').AsFloat), ',', '.') + ', ' + //LOG_SALOLD
                           AnsiReplaceStr(FormatFloat('#0.0000', qryGen.FieldByName('ITE_SAL_ML').AsFloat), ',', '.') + ', ' + //LOG_GMLOLD
                           AnsiReplaceStr(FormatFloat('#0.0000', qryGen.FieldByName('ITE_SALCON').AsFloat), ',', '.') + ', ' + //LOG_SALNEW
                           AnsiReplaceStr(FormatFloat('#0.0000', qryGen.FieldByName('ITE_GMLCON').AsFloat), ',', '.') + ', ' + //LOG_GMLNEW
                           AnsiReplaceStr(FormatFloat('#0.0000', qryGen.FieldByName('ITE_ENTFUT').AsFloat), ',', '.') + ', ' + //LOG_SALDOS
                           AnsiReplaceStr(FormatFloat('#0.0000', qryGen.FieldByName('LOG_QTEF_A').AsFloat), ',', '.') + ', ' + //LOG_QTEF_A
                           AnsiReplaceStr(FormatFloat('#0.0000', qryGen.FieldByName('LOG_QTEF_F').AsFloat), ',', '.') + ', ' + //LOG_QTEF_F
                           AnsiReplaceStr(FormatFloat('#0.0000', qryGen.FieldByName('LOG_QTEF_P').AsFloat), ',', '.') + ', ' + //LOG_QTEF_P
                           AnsiReplaceStr(FormatFloat('#0.0000', qryGen.FieldByName('LOG_SALFIS').AsFloat), ',', '.') + ', ' + //LOG_SALFIS
                           AnsiReplaceStr(FormatFloat('#0.0000', qryGen.FieldByName('ITE_DIFERE').AsFloat), ',', '.') + ', ' + //LOG_DIFERE
                           AnsiReplaceStr(FormatFloat('#0.0000', qryGen.FieldByName('ITE_DIFGML').AsFloat), ',', '.') + ', ' + //LOG_DIFGML
                           QuotedStr(qryGen.FieldByName('ITE_ITEATI').AsString) + ', ' +                                       //LOG_ITEATI

                           AnsiReplaceStr(FormatFloat('#0.0000', qryGen.FieldByName('ITE_PRECUS').AsFloat), ',', '.') + ', ' + //LOG_PRECUS
                           QuotedStr(qryGen.FieldByName('ITE_LOCFIS').AsString) + ', ' +                                       //LOG_LOCFIS
                           QuotedStr(IIF(blnConAcu, 'S', 'N')) + ', ' +                                                        //LOG_CONACU
                             QuotedStr(intToStr(FintConEst)) + ', ' +                                                          //LOG_CONEST
                           QuotedStr(strOpcGra) + ');';                                                                        //LOG_OPCGRA

        //strInsert := strInsert + 'UPDATE PROINC SET  PRO_AUTINC = PRO_AUTINC + 1 WHERE PRO_NOMARQ = "LGCEST";';

        sltInsert.Add(strInsert);

        If sltInsert.Count > 500 Then
          pInsertLoteLGCEST;

        stlAutInc.Add(strAutInc);
        strAutInc := fNextAutoIncrem(strAutInc);

       qryGen.Next;
      End;

      pInsertLoteLGCEST;

      If blnFilter Then
        qryGen.Filtered := True;
      qryGen.recNo := intPosIni;
      Result := True;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TfrmBalancoEstoqueGravar.fGravaLogContagemEstoque]');
      End;
    End;

  Finally
    FreeAndNil(sltInsert);
    FreeAndNil(qryLGCEST);
    qryGen.EnableControls;
  End;
End;

procedure TfrmBalancoEstoqueGravar.FormShow(Sender: TObject);
begin
  inherited;

  If FintConEst = 2 Then
  Begin
    dbgItens.Columns[5].Visible := False;
    dbgItens.Columns[8].Visible := False;
  End;

  strImpAju := fCfgSis('IMPAJU', varString);
  strPreAju := fCfgSis('PREAJU', varString);
  If blnContagemControlada Then
  Begin
    pnlCabecalho.Visible := False;
    pBuscaItens(True);
  End
  Else
    Self.SelectFirst;

end;

procedure TfrmBalancoEstoqueGravar.dbgItensKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If Key = #13 Then
    Self.SelectNext(ActiveControl, True, True);

end;

function TfrmBalancoEstoqueGravar.fGetFiltrosSQL: string;
begin
  Result := Result + fStrLocateLinGru(mskLinhaGrupo, arrLinhaGrupo, 'I.ITE_CODGRU', 'CODGRU');

  If Not fEmptyStr(edtLocIni.Text) Then
  Begin
    If (Not fEmptyStr(edtLocFin.Text)) Then
      Result := Result + ' AND LEFT(IF(LOT_NUMLOT IS NULL, G.ITE_LOCFIS, LOT_LOCFIS), LENGTH(:MAIOR)) BETWEEN :LOCINI AND :LOCFIN '
    Else Result := Result + ' AND IF(LOT_NUMLOT IS NULL, G.ITE_LOCFIS, LOT_LOCFIS) LIKE :LOCINI ';
  End;

  Result := Result + fStrLocate(edtCodFor, arrFornec,   'I.ITE_CODFOR', 'CODFOR');
  Result := Result + fStrLocate(edtCodIte, arrProduto,  'I.ITE_CODITE', 'CODITE');
  Result := Result + fStrLocate(edtCodMar, arrMarca,    'I.ITE_CODMAR', 'CODMAR');
  Result := Result + fStrLocate(edtCodDep, arrDepto,    'I.ITE_CODDEP', 'CODDEP');
  Result := Result + fStrLocate(edtCodUni, arrUnidade,  'I.ITE_CODUNI', 'CODUNI');
  Result := Result + fStrLocate(edtPrdGru, arrGrupoPro, 'I.ITE_PRDGRU', 'PRDGRU');

end;

function TfrmBalancoEstoqueGravar.fGetSQLPED_VENDA_GARANTIA_NAO_COLETADA: string;
begin
  Result := '';
  If strClientePedVenda_Garantia_Nao_Coletada = '' Then
    Exit('0');
  Result := ' IFNULL((SELECT SUM(FDO_QTDITE) FROM FATDOR ' +
           '  WHERE FDO_ESPDOC = "PD" ' +
           '    AND FDO_JAFATU = 0 ' +
           '    AND FDO_CODEMP = "'+VS_StrCodEmp+'" ' +
           '    AND FDO_CODCLI = "'+strClientePedVenda_Garantia_Nao_Coletada+'" ' +
           '    AND FDO_CODITE = G.ITE_CODITE), 0) ';
end;

function TfrmBalancoEstoqueGravar.fGravar(pgbProgresso: TcxProgressBar): Boolean;
var strErro, strDocsGerados, strDocsGeradosML, strCodErrosAuditoria: String;
    blnNotifBkp: Boolean;
Begin
  blnNotifBkp := VS_blnNotificaSaldoAbaixMinimo;
  Try
    Result := False;
    FItemZeraList.Clear;
    strErro := '';
    strDocsGerados := '';
    strDocsGeradosML := '';
    pCarregaCustoItens;              {Req. 456948 - M5}
    sltItensSaldoAlterado.Clear;     {Req. 456948 - Q8}
    FintTemLocCritica := -1;         {Req. 456948-B - B5. Reavalia por gravacao}
    VS_blnNotificaSaldoAbaixMinimo := False;   {Req. 456948 - Q8: notificacao roda via pNotificaSaldoAbaixMinimo apos flush}
    pLigaBatchSaldosBalanco;   {Req. 456948 - M1b}
    pCriaTemporariasEmContagem;
    try
      qryCommand := fCriaQuery;
      try
        fStartTransaction;
        pLigaCacheIDTransacao(fGetConexao);   {Req. 456948}
        pLigaCachePesoEspGranel;   {Req. 456948-B}
        try
          If Not fLock_Unlock(STR_TRAVA_CONDET, True, False) Then
          Begin
            fRollback;
            pMensagemOk('Uma tarefa de balanço está sendo feita em outra estação: ' + fGetHostLock(STR_TRAVA_CONDET) + '. Tente novamente!');
            Exit;
          End;
          FLOG_CODCON := '';
          If Not fGravaLogContagemEstoque(FLOG_CODCON) Then
          Begin
            fRollback;
            pMensagemOk('Erro ao gravar o Log da Contagem');
            Exit;
          End;

          If opcGravacao = opcAtivos Then
          Begin
            qryGen.Filter   := 'ITE_STATUS = ' + QuotedStr('ATIVO');
            qryGen.Filtered := True;
          End;

          Result := fConfirmaAjuste(False, 'AJ', pgbProgresso, strErro, strDocsGerados, True);
          If strErro <> '' Then
            Result := False;

          If Result and fCfgSis('USATMQ', varBoolean) Then
          begin
            Result := fConfirmaAjuste(False, 'ML', pgbProgresso, strErro, strDocsGeradosML, True);
            If strErro <> '' Then
              Result := False;
          end;


          If Result Then
            Result := fConfirmaAjuste(True, 'AJ', pgbProgresso, strErro, strDocsGerados, False);

          If Result And (stlAutInc.Count > 0) Then
            fExecutaSQL('UPDATE LGCEST SET LOG_EFETIV = 1 WHERE AUTOINCREM IN ( ' + fCommaText(stlAutInc, True) + ')');

          {Req. 456948 - M1. Flush do lote de saldos ANTES da auditoria, que le
           o saldo gravado. Req. 456948 - M1b: no erro, descarta sem executar.}
          If Result Then
            pDescarregaEDesligaBatchSaldosBalanco
          Else
            pDesligaBatchSaldosBalanco;

          VS_blnNotificaSaldoAbaixMinimo := blnNotifBkp;

          If Result And (Not objAuditoriaSaldo.fValidouTodas(strCodErrosAuditoria)) Then
          Begin
            Result := False;
            fRollback;
            pMostraErrosAuditoria(strCodErrosAuditoria);
          End;

          If Result Then
            pNotificaSaldoAbaixMinimo;   {Req. 456948 - Q8}

          Result := Result And fzeraItens(pgbProgresso);

          If Result Then
          begin
            If strErro <> '' Then
            begin
              fRollback;
              pMensagemOk(strErro);
            End
            Else
            begin
              fCommit;
              pMensagemOk('Documento(s) de Ajuste Gerado(s):' + sLineBreak +
                           Trim(
                                 IIF(not fEmptyStr(strDocsGerados), strDocsGerados + sLineBreak, '') +
                                 IIF(not fEmptyStr(strDocsGeradosML), strDocsGeradosML, '')
                               )
                         );
            End;
          end
          Else
            fRollback;

        Finally
          If Assigned(stlAutInc) then
            FreeAndNil(stlAutInc);
          pDesligaBatchSaldosBalanco;   {Req. 456948 - M1b: idempotente, cobre os Exit acima}
          VS_blnNotificaSaldoAbaixMinimo := blnNotifBkp;
          pDesligaCacheIDTransacao;   {Req. 456948}
          pDesligaCachePesoEspGranel;   {Req. 456948-B}
        End;
      finally
        FreeAndNil(qryCommand);
      end;
    finally
      pRemoveTemporaria
    end;

  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollback;
      pDesligaBatchSaldosBalanco;   {Req. 456948 - M1b: descarta sem executar}
      VS_blnNotificaSaldoAbaixMinimo := blnNotifBkp;
      pMensagensErro(E.Message, '[TfrmBalancoEstoqueGravar.fGravar]');
      If Assigned(stlAutInc) then
        FreeAndNil(stlAutInc);
    End;
  End;

  qryGen.Filtered := False;

  fLock_Unlock(STR_TRAVA_CONDET, False, False);
End;

Procedure TfrmBalancoEstoqueGravar.pAjustaBotoes;
  Var
    blnTemInativos: Boolean;
Begin
  blnTemInativos := qryGen.Locate('ITE_STATUS', 'INATIVO', []);

  btnConfirma.Visible        := Not blnTemInativos;
  btnGravaTodos.Visible      := blnTemInativos;
  btnGravaAtivos.Visible     := blnTemInativos;
  btnImprimeInativos.Visible := blnTemInativos;
  mmoInativos.Visible        := blnTemInativos;
End;

procedure TfrmBalancoEstoqueGravar.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If fEmptyStr(strOpcGra) Then
    strOpcGra := 'CONFIRMAR';

  If fMensagem('','Deseja Imprimir o Relatório de Contagem de Estoque?', ['&S I M','&N Ã O']) = 1 Then
    pGeraRelatorioDivergencia('Ativo');

  If fMensagem('','Confirma lançamentos para acerto de estoque dos produtos ?', ['&S I M','&N Ã O']) = 2 Then
    Exit;

  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.blnTempoRestante := True;
    frmGravando.fExecutarAcao := fgravar;
    frmGravando.ShowModal;
    if frmGravando.blnConfirma Then
      fMensagem('','Gravação de arquivos concluída !',['&O K']);
  Finally
    FreeAndNil(frmGravando);
    pLimpaTela;
  End;

end;

procedure TfrmBalancoEstoqueGravar.pAtivaItem(strCodIte: String);
Begin
  With qryCadIte Do
  Begin
    Close;
    ParamByName('CODITE').AsString := strCodIte;
    ExecSQL;
  End;
End;

procedure TfrmBalancoEstoqueGravar.pSetaParametrosLog(qryConsulta: TUniQuery);
Begin
  With qryConsulta Do
  Begin
    ParamByName('CODEMP').AsString := VS_strCodEmp;
  End;
End;

function TfrmBalancoEstoqueGravar.fTrataCampoSalExt(AField: String): string;
begin
  Result := AField;
  If strMOVFUL = '2' then
    Result := '0'
end;

{Req. 456948-B. Application.ProcessMessages processaria QUALQUER mensagem
 da fila, inclusive WM_TIMER de outras telas abertas na mesma estacao - e o
 lote de saldos (M1b) fica armado globalmente durante todo o laco de
 fConfirmaAjuste. Bombeando so WM_PAINT, a barra de progresso continua
 repintando sem abrir essa janela de reentrancia.}
procedure TfrmBalancoEstoqueGravar.pBombeiaSoRepaint;
  Var
    Msg: TMsg;
begin
  {O tmrEstimado de frmGravando (untGravando.pas) so dispararia via
   WM_TIMER, que este bombeamento propositalmente nao processa. Chamado
   direto, sem depender da fila de mensagens.}
  If Assigned(frmGravando) And frmGravando.blnTempoRestante Then
    frmGravando.pAtualizaTempoRestante;

  While PeekMessage(Msg, 0, WM_PAINT, WM_PAINT, PM_REMOVE) Do
  Begin
    TranslateMessage(Msg);
    DispatchMessage(Msg);
  End;
end;

procedure TfrmBalancoEstoqueGravar.pCarregaCustoItens;
  Var
    qryCusto: TUniQuery;
    sltCodIte: TStringList;
    recCusto: TdtoCustoIteGer;
    bkmPosicao: TBookmark;
begin
  dicCustoItem.Clear;

  sltCodIte := TStringList.Create;
  Try
    sltCodIte.Sorted     := True;
    sltCodIte.Duplicates := dupIgnore;

    {O laco de gravacao percorre qryGen depois desta carga, entao a posicao
     tem que voltar ao ponto em que estava.}
    bkmPosicao := qryGen.Bookmark;
    qryGen.DisableControls;
    Try
      qryGen.First;
      While Not qryGen.Eof Do
      Begin
        sltCodIte.Add(qryGen.FieldByName('ITE_CODITE').AsString);
        qryGen.Next;
      End;
    Finally
      If Length(bkmPosicao) > 0 Then
        qryGen.Bookmark := bkmPosicao;
      qryGen.EnableControls;
    End;

    If sltCodIte.Count = 0 Then
      Exit;

    qryCusto := fCriaQuery(nil);
    Try
      With qryCusto, SQL Do
      Begin
        {ITE_CNV_ML e da CADITE; as outras quatro sao da ITEGER.}
        Add(' SELECT G.ITE_CODITE,              ');
        Add('        G.ITE_PRECUS,              ');
        Add('        G.ITE_PREMED,              ');
        Add('        G.ITE_PREULT,              ');
        Add('        G.ITE_IMPULT,              ');
        Add('        C.ITE_CNV_ML               ');
        Add('   FROM ITEGER G                   ');
        Add('  INNER JOIN CADITE C ON           ');
        Add('        C.ITE_CODITE = G.ITE_CODITE ');
        Add('  WHERE G.ITE_CODEMP = :CODEMP     ');
        Add('    AND G.ITE_CODITE IN (' + fCommaText(sltCodIte, True) + ') ');

        ParamByName('CODEMP').AsString := VS_strCodEmp;
      End;

      qryCusto.Open;
      While Not qryCusto.Eof Do
      Begin
        recCusto.fltPreCus := qryCusto.FieldByName('ITE_PRECUS').AsFloat;
        recCusto.fltPreMed := qryCusto.FieldByName('ITE_PREMED').AsFloat;
        recCusto.fltPreUlt := qryCusto.FieldByName('ITE_PREULT').AsFloat;
        recCusto.fltImpUlt := qryCusto.FieldByName('ITE_IMPULT').AsFloat;
        recCusto.fltCnv_Ml := qryCusto.FieldByName('ITE_CNV_ML').AsFloat;

        dicCustoItem.AddOrSetValue(qryCusto.FieldByName('ITE_CODITE').AsString,
                                   recCusto);
        qryCusto.Next;
      End;
      qryCusto.Close;
    Finally
      FreeAndNil(qryCusto);
    End;
  Finally
    FreeAndNil(sltCodIte);
  End;
end;

{Req. 456948 - Q8. O item entra uma vez na lista, mesmo aparecendo em varios
 lotes; a notificacao roda apos o flush da rodada, sobre o saldo final -
 nao mais uma vez por UPDATE de lote.}
procedure TfrmBalancoEstoqueGravar.pNotificaSaldoAbaixMinimo;
  Var
    intIdx: Integer;
    objNotSalMin: TControlaNotificacaoSaldoMin;
begin
  If sltItensSaldoAlterado.Count = 0 Then
    Exit;

  objNotSalMin := TControlaNotificacaoSaldoMin.Create;
  Try
    objNotSalMin.blnRetFalseSeNaoConseguirEnviarNotificaoItensAbaixoMin := False;

    If Not objNotSalMin.blnTemOperadorParaReceberNotificacao Then
      Exit;

    For intIdx := 0 To sltItensSaldoAlterado.Count - 1 Do
    Begin
      objNotSalMin.strCodIte := sltItensSaldoAlterado[intIdx];

      If objNotSalMin.blnGeraNotificacao Then
        objNotSalMin.fGerarNotificacoes;
    End;
  Finally
    FreeAndNil(objNotSalMin);
  End;
end;

function TfrmBalancoEstoqueGravar.fSqlTabelaQuantidadePendente: String;
Begin
  Result := '';
  Result := Result + 'SELECT                                                    ';
  Result := Result + '   DET_CODITE AS CODITE,                                  ';
  Result := Result + '   DET_CODEMP AS CODEMP,                                  ';
  Result := Result + '   SUM(DET_QTDPEN) AS QTDPEN                              ';
  Result := Result + ' FROM ( SELECT DET_CODITE, DET_CODEMP,                    ';
  Result := Result + '          IFNULL(DET_QTDITE-DET_QTDENT,0) AS DET_QTDPEN   ';
  Result := Result + '        FROM MOVDET D                           ';
  Result := Result + '          LEFT JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ';
  Result := Result + '          JOIN ITEGER G ON DET_CODITE   = G.ITE_CODITE    ';
  Result := Result + '                       AND DET_CODEMP   = G.ITE_CODEMP    ';
  Result := Result + '          WHERE DET_ENTFUT   = "S"                        ';
  Result := Result + '          AND IFNULL(ROUND(IFNULL(DET_QTDITE,0) - IFNULL(DET_QTDENT,0),4), 0) > 0 ';

  If blnEfBaixExiste Then
    Result := Result + '        AND DET_EFBAIX = "N" ';

  Result := Result + '          AND (DET_ESPDOC NOT IN ("ML", "PR", "TM", "EP"))';
  Result := Result + '          AND DET_TIP_FC = "C"                            ';
  Result := Result + '          AND IFNULL(DET_FILKAR,0) = 0                    ';

  If fCfgSis('EFTEST') = '2' Then
  Begin
    Result := Result + '        AND (DET_PROEMB <> "S" OR DET_BXSBIT = "S") ';//Para exibir os sub-itens (proemb = 's' e bxsbit = 's')
    Result := Result + '        AND (DET_FILKAR = 0) ';//Para nao exibir o item principal (que vai estar com filkar = 1)
  End
  Else
    Result := Result + '        AND DET_PROEMB <> "S" ';

  Result := Result + '          AND G.ITE_DIGCON = "S"                          ';
  Result := Result + '      ) A                                                 ';
  Result := Result + ' GROUP BY DET_CODITE, DET_CODEMP                          ';

End;

{********************************************************************}
{* FUNCAO QUE REALIZA LANCAMENTOS DE AJUSTE DE PRODUTOS ACERTANDO   *}
{* DIFERENCA ENTRE SALDO E CONTAGEM (BALANCO DE ESTOQUE)            *}
{*****************************************************************JC*}
function TfrmBalancoEstoqueGravar.fConfirmaAjuste(AFinalizaContagem: Boolean; strEspDoc: String; pgbProgresso: TcxProgressBar; var strErro: string; var strDocsGerados: String; blnForcaSaida: Boolean = False): Boolean;
  Var
    strArqGer  : String;
    strArqDet  : String;
    strEntSai  : String;
    strNumDocAJ: String;
    strNumDocML: String;
    blnAjuGra  : Boolean;
    strAutInc,
    strClaFis  : String;
    strAutTmp  : String;
    MovDetParams: TMovDetParams;   {Req. 456948 - M4}

    lItemZera: TItemZera;

    fltCnv_Ml  : Double;
    fltQtdIte  : Double;
    fltTotIte  : Double;
    fltTotAju  : Double;

    qryZerIte  : TUniQuery;

    objBatchMovDet: TBatchSQL;      {Req. 456948 - M4}
    sltDocsRodada : TStringList;    {Req. 456948 - documentos desta rodada}
    recCusto      : TdtoCustoIteGer;   {Req. 456948 - M5}

    recServicos: TDadosServicos;
    arrDuplic  : TarrDuplicata;

    intQtdDoc: Integer;
    {Req. 456948-B - B6. Primeiro numero de cada bloco reservado.}
    int64SeqAJ: Int64;
    int64SeqML: Int64;

    blnGeraMovGer: Boolean;

    strFilterBkp: String;
    blnVerificaSeTemDiferencasParaGravar: Boolean;

    intPosIni,
    intContador,
    intLinhasProg,   {Req. 456948-B - B5b. Contador inteiro do progresso.}
    i: Integer;
    {$region 'subFuction'}

    procedure pGravaLogItensSemNecessidadeCalc;
      Var
        strSQLFiltros: String;

      Function fLeftJoin: String;
      Begin
        Result := '';
        Result := Result + '    LEFT JOIN ( ' + fSqlTabelaQuantidadePendente + ' ';
        Result := Result + '              ) TMP ON G.ITE_CODITE = TMP.CODITE AND G.ITE_CODEMP = TMP.CODEMP ';
      End;

    Begin
      strSQLFiltros := '';

      If FintConEst = 1 Then
      Begin
        strSQLFiltros := strSQLFiltros +' AND (FORMAT(G.ITE_SALDOS - IF((' + fTrataCampoSalExt('G.ITE_SALEXT') + ' < 0) OR (' + fTrataCampoSalExt('G.ITE_SALEXT') + ' IS NULL), 0, ' + fTrataCampoSalExt('G.ITE_SALEXT') + ') + IFNULL(TMP.QTDPEN,0),3) = FORMAT(G.ITE_SALCON,3)  AND ';
        strSQLFiltros := strSQLFiltros +'      FORMAT(IFNULL(G.ITE_SAL_ML, 0),4)           = FORMAT(G.ITE_GMLCON,4))     ';
      End Else
      Begin
        strSQLFiltros := strSQLFiltros + ' AND ROUND(G.ITE_DIFSAL, 3) = 0 AND ROUND(G.ITE_DIF_ML, 4) = 0 ';
      End;

      frmgravando.lblGravando.Caption := 'Aguarde, gravando logs de contagem...';
      pBombeiaSoRepaint;

      If Not TConDet.fGravaConDetItens(Self, strSQLFiltros, VS_strCodEmp, 'N', pSetaParametrosLog, fLeftJoin) Then
        Raise Exception.Create('Erro pGravaLogItensSemNecessidadeCalc');
    End;

    procedure pSeparaItensSemNecessidadeCalc;
     var ItemZera: TItemZera;
    begin
      pGravaLogItensSemNecessidadeCalc;

      qryZerIte := fCriaQuery(Nil);
      try
        With qryZerIte Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(fRetSQLItens(False, True));
          pSetarParametros(qryZerIte);

          frmgravando.lblGravando.Caption := 'Aguarde, limpando contagem...';
          pBombeiaSoRepaint;
          qryZerIte.Open;

          while not qryZerIte.Eof Do
          begin
            ItemZera.FCodite := qryZerIte.FieldByName('ITE_CODITE').AsString;
            ItemZera.FNumLot := qryZerIte.FieldByName('ITE_NUMLOT').AsString;
            ItemZera.FLocFis := qryZerIte.FieldByName('ITE_LOCFIS').AsString;
            FItemZeraList.AddItem(ItemZera);
            qryZerIte.Next;
          end;
          THistoricoBalanco.pLimpaHistoricoNaoContados;
        end;
      finally
        FreeAndNil(qryZerIte);
      end;

    end;

   function fVerificaSeTemDiferencasParaGravar: Boolean;
    var strField: string;
        fldDif  : TField;
   Begin
     Result := False;
     If strEspDoc = 'AJ' Then
       strField := 'ITE_DIFERE'
     Else If strEspDoc = 'ML' Then
       strField := 'ITE_DIFGML'
     Else
       Exit;

     fldDif := qryGen.FieldByName(strField);

     {Req. 456948-B - B15. Faltava DisableControls: cada Next repintava o
      grid. Na passada ML (CFG_USATMQ) o dataset e varrido inteiro - 14.000
      registros na massa de volume.}
     qryGen.DisableControls;
     Try
       qryGen.First;
       While not qryGen.Eof do
       Begin
         Result := fldDif.AsFloat <> 0;
         If Result Then
           Break;
         qryGen.Next;
       End;
     Finally
       qryGen.EnableControls;
     End;
   End;

   procedure pAjustaITEGERSemContagemNaCADLOT;
   Var
    qryAuxIte: TUniQuery;
    begin

      {Ajusta os registros na Iteger que ficaram sem contagem na Cadlot}
       qryAuxIte := fCriaQuery(Nil);
       Try
         qryAuxIte.Close;
         qryAuxIte.SQL.Clear;
         qryAuxIte.SQL.Add(' SELECT ');
         qryAuxIte.SQL.Add('  ITE_CODITE AS CODITE');
         qryAuxIte.SQL.Add(' FROM ITEGER ');
         qryAuxIte.SQL.Add(' WHERE TRUE ');
         qryAuxIte.SQL.Add('  AND ITE_DIGCON = "S" ');
         qryAuxIte.SQL.Add('  AND ITE_CODEMP = :CODEMP ');
         {Apenas itens que tenha lote cadastrados}
         qryAuxIte.SQL.Add('  AND ((SELECT COUNT(1) FROM CADLOT WHERE LOT_CODITE = ITE_CODITE AND LOT_CODEMP = ITE_CODEMP AND LOT_NUMLOT <> "A DEFINIR" AND LOT_NUMLOT <> "GARANTIA") > 0) ');
         {Apenas itens que CADLOT ficou sem contagem}
         qryAuxIte.SQL.Add('  AND ((SELECT COUNT(1) FROM CADLOT WHERE LOT_CODITE = ITE_CODITE AND LOT_CODEMP = ITE_CODEMP AND LOT_NUMLOT <> "A DEFINIR" AND LOT_NUMLOT <> "GARANTIA" AND LOT_DIGCON = "S") = 0); ');

         qryAuxIte.ParamByName('CODEMP').AsString := VS_strCodEmp;
         qryAuxIte.Open;

         If Not qryAuxIte.IsEmpty Then
         Begin
           qryAuxIte.First;
           While Not qryAuxIte.Eof do
           Begin
            if not FItemZeraList.Contains(qryAuxIte.FieldByName('CODITE').AsString,'','') Then
             Begin
               lItemZera.FCodite := qryAuxIte.FieldByName('CODITE').AsString;
               lItemZera.FNumLot := '';
               lItemZera.FLocFis := '';

               FItemZeraList.AddItem(lItemZera);
             End;
             qryAuxIte.Next;
           End;
         End;
       Finally
         FreeAndNil(qryAuxIte);
       End;
    end;

   {$endregion}

begin
  Result := False;
  {Req. 456948 - M4. Variavel local de tipo classe nao e zerada pelo
   compilador; sem isto, uma excecao antes da atribuicao (linha ~1796)
   deixaria lixo de pilha, e o If Assigned(...) do Except podia chamar
   FreeAndNil em endereco invalido. Mesmo idioma de untConDet.pas:215.}
  objBatchMovDet := Nil;
  sltDocsRodada  := Nil;

  blnGerarTransferencia := False;

  strArqGer := 'MOVGER';
  strArqDet := 'MOVDET';

  {*****************************************}
  {* TOTAL DO AJUSTE (SAIDAS - ENTRADAS)   *}
  {**************************************JC*}

  blnAjuGra := strEspDoc = 'ML';
  blnVerificaSeTemDiferencasParaGravar := fVerificaSeTemDiferencasParaGravar;

  { Se não houver dados para gravar, retorna True:         }
  { na primeira passada, para registrar os ML ou finalizar }
  { na segunda passada, apenas para finalizar.             }
  If (Not AFinalizaContagem) And (Not blnVerificaSeTemDiferencasParaGravar) And blnForcaSaida Then
    Exit(True);

  {$region 'fVerificaSeTemDiferencasParaGravar'}
  If (Not AFinalizaContagem) And blnVerificaSeTemDiferencasParaGravar Then
  Begin
    objAuditoriaSaldo.Limpar;

    Try
      qryGen.DisableControls;

      Screen.Cursor := crHourGlass;
      strFilterBkp := '';
      If qryGen.Filtered Then
        strFilterBkp :=  qryGen.Filter;

      If (strCCETRA <> '') And (strEspDoc <> 'ML') Then
      Begin
        qryGen.Filtered := False;
        qryGen.Filter   :=  strFilterBkp + IIf(strFilterBkp <> '', ' AND ', '') + 'ITE_DIFERE < 0';
        qryGen.Filtered := True;

        blnGerarTransferencia := qryGen.RecordCount > 0;
      End;

      qryGen.Filtered := False;
      If blnGerarTransferencia And (strEspDoc = 'AJ') Then
        qryGen.Filter   :=  strFilterBkp + IIf(strFilterBkp <> '', ' AND ', '') + 'ITE_DIFERE > 0'

      Else
        qryGen.Filter   :=  strFilterBkp + IIf(strFilterBkp <> '', ' AND ', '') +
                                           IIf(strEspDoc = 'AJ', 'ITE_DIFERE <> 0 ', 'ITE_DIFGML <> 0') +
                                           IIf(strEspDoc = 'ML', ' AND ESPITE = '+QuotedStr(strEspDoc), '');
      qryGen.Filtered := True;

      pgbProgresso.Properties.Max := qryGen.RecordCount;
      pgbProgresso.Position       := 0;
      intQtdDoc := ceil(qryGen.RecordCount / intQtdItens);

      strAutTmp := fRetAutoIncrem('MOVDET', VS_strCodEmp, qryGen.RecordCount);

      intLinhasProg := 0;   {Req. 456948-B - B5b}

      {Req. 456948-B - B6. Um bloco de intQtdDoc numeros por especie, numa
       chamada, em vez de uma por documento (evita travar CFGSIS.CFG_PRO_AJ
       ate o commit da rodada toda).}
      int64SeqAJ := StrToInt64Def(fRetSequencial('PRO_AJ', VS_strCodEmp,
                                                 fTamDocCadRec, False, Nil,
                                                 intQtdDoc), 0);
      int64SeqML := 0;
      If blnAjuGra Then
        int64SeqML := StrToInt64Def(fRetSequencial('PRO_ML', VS_strCodEmp,
                                                   fTamDocCadRec, False, Nil,
                                                   intQtdDoc), 0);

      {Req. 456948 - M4. UM lote para a rotina inteira, nao por documento -
       preserva a ordem MOVDET -> MOVTRI/MOVAUX. True: o fCriaQuery abaixo nao
       tem outra referencia guardada, sem isso vazava um TUniQuery por rodada.}
      objBatchMovDet := TBatchHelper.CreateBatchSQL(fCriaQuery, True);
      sltDocsRodada  := TStringList.Create;

      {Req. 456948-B - B10b. Abre os moldes de dataset de fGravaMovDet junto
       com o lote, e fecha nos mesmos dois pontos - fim normal e Except.}
      pAbreMoldesMovDet;
      objBatchMovDet.BatchSize := 500;

      For i:= 1 To intQtdDoc do
      Begin


        FillChar(arrDuplic, Sizeof(arrDuplic) , #0);

        intPosIni := qryGen.recNo;
        fltQtdIte := 0.0;
        fltTotIte := 0.0;

        fltTotAju := fCalcTotais(strEspDoc,intPosIni, blnGeraMovGer);

        {********************************************}
        {* PEGA PROXIMO DOCUMENTO P/ AJUSTE (AJ/ML) *}
        {*****************************************JB*}
        strAutInc := fstrEspaco(' ', 20);
        If Not blnGeraMovGer Then
          Result := True
        Else
        Begin
          {Req. 456948-B - B6. Sai do bloco reservado antes do laco.}
          strNumDocAJ := fStrZero(int64SeqAJ, fTamDocCadRec);
          Inc(int64SeqAJ);
          If strEspDoc = 'AJ' Then
            strDocsGerados := strDocsGerados + strNumDocAJ + ' - AJ - ' + VS_strCodEmp + #$A#$D;

          strNumDocML := EmptyStr;
          If blnAjuGra Then
          Begin
            strNumDocML := fStrZero(int64SeqML, fTamDocCadRec);
            Inc(int64SeqML);
          End;

          FstrNumDoc := IIF(blnAjuGra, strNumDocML, strNumDocAJ);
          FstrEspDoc := strEspDoc;

          If (strEspDoc = 'ML') And blnAjuGra Then
            strDocsGerados := strDocsGerados + strNumDocML + ' - ML - ' + VS_strCodEmp + sLineBreak;

          {$region 'fGravaMovGer Result := fGravaMovGer(strAutInc,'}
          Result := fGravaMovGer(strAutInc,                                 // Auto Incremento (Retorno)
                               IIF(blnAjuGra, strNumDocML, strNumDocAJ),  // Numero Documento
                               strEspDoc,                                 // Espécie
                               VS_strCodEmp,                              // Empresa
                               '',                                        // Transportadora
                               strLoginUsuarioLogado,                     // Vendedor
                               '',                                        // Fornecedor
                               fCfgSis('CLIAJU'),                         // Cliente
                               'C',                                       // Tipo ((C)liente / (F)ornecedor)
                               VS_Date,                                   // Data da Entrada
                               fTime(),                                   // Hora da Entrada
                               VS_Date,                                   // Data do Documento
                               '01000',                                   // Condição de Pagamento
                               '',                                        // Estado do Cliente / Fornecedor
                               '',                                        // Nome do Consumidor
                               '',                                        // Endereço do Consumidor
                               '',                                        // Bairro do Consumidor
                               '',                                        // Cep do Consumidor
                               '',                                        // Cidade do Consumidor
                               '',                                        // Estado do Consumidor
                               '',                                        // Telefone do Consumidor
                               0,
                               '',                                        // CNPJ / CGC
                               '',                                        // CNPJ / CGC do consumidor
                               '',                                        // Inscrição estadual do Consumidor
                               '',                                        // RG do consumidor
                               0.0,                                       // Base Simples Paulista
                               0.0,                                       // Base de IPI
                               0.0,                                       // Aliquota de IPI
                               0.0,                                       // Total de IPI
                               0.0,                                       // Base de ICMS
                               0.0,                                       // Aliquota de ICMS
                               0.0,                                       // Total de ICMS
                               0.0,                                       // Valor de Substituição
                               0.0,                                       // Aliquota de Substituição
                               0.0,                                       // Base de Substituição
                               0.0,                                       // Base de Substituição Simulada
                               0.0,                                       // Desconto Especial
                               fltTotAju,                                 // Valor Contábil
                               fltTotAju,                                 // Total dos Itens
                               0.0,                                       // Total de Custo
                               0.0,                                       // Total Médio
                               '',                                        // Tipo de Frete
                               0.0,                                       // Valor do Frete
                               0.0,                                       // Peso Bruto
                               0.0,                                       // Peso Liquido
                               0.0,                                       // Volume
                               '',                                        // Especie
                               '',                                        // Marca
                               'REF.: CONTAGEM DE BALANCO',               // Mensagem 1
                               '',                                        // Mensagem 2
                               '',                                        // Mensagem 3
                               '',                                        // Mensagem 4
                               '',                                        // Mensagem 5
                               False,                                     // Indica se Faturado ou nao
                               IIF(blnAjuGra, 'AJ', EmptyStr),            // Tipo de Faturamento
                               IIF(blnAjuGra, strNumDocAJ, EmptyStr),     // Numero de Faturamento
                               IIF(blnAjuGra, VS_strCodEmp, EmptyStr),    // Empresa dd Faturamento
                               IIF(blnAjuGra, VS_Date, 0),                // Data de Faturamento
                               strLoginUsuarioLogado,                     // Vendedor do Faturamento
                               IIF(blnAjuGra, '01000', EmptyStr),         // Condição de Pagamento do Faturamento
                               False,                                     // Devolução Especial
                               IIF(blnAjuGra, fltTotAju, 0.0),            // Valor do Faturamento
                               0.0,                                       // Valor Parcela 01
                               0.0,                                       // Valor Parcela 02
                               0.0,                                       // Valor Parcela 03
                               0.0,                                       // Valor Parcela 04
                               0.0,                                       // Valor Parcela 05
                               0.0,                                       // Valor Parcela 06
                               0.0,                                       // Valor Parcela 07
                               0.0,                                       // Valor Parcela 08
                               0.0,                                       // Valor Parcela 09
                               0.0,                                       // Valor Parcela 10
                               0.0,                                       // Valor Parcela 11
                               0.0,                                       // Valor Parcela 12
                               arrDuplic,                                 // Array Duplicatas 24 Parcelas
                               '',                                        // Série
                               'N',                                       // Nota Especial
                               '9999',                                    // Classificação Fiscal 1
                               '',                                        // Classificação Fiscal 2
                               '',                                        // Classificação Fiscal 3
                               '',                                        // Natureza da Operação
                               0.0,                                       // Percentual de Desconto
                               strLoginUsuarioLogado,                     // Codigo do Digitador
                               '',                                        // Codigo da Condição
                               '',                                        // Forma de Pagamento
                               0.0,                                       // Fator para meia nota
                               recServicos,
                               0.0,                                       // Despesa acessoria
                               '',                                        // Origem do Documento (V)enda (D)evolução
                               'N',                                       // Usa controle de entrega
                               '',                                        // Representante
                               0.0,                                       // Aliquota do IRPF (SERVIÇO)
                               0.0,                                       // Valor do IRPF (SERVIÇO + PRODUTO)
                               0.0,                                       // Aliquota do Pis (SERVIÇO)
                               0.0,                                       // Valor do Pis (SERVIÇO + PRODUTO)
                               0.0,                                       // Aliquota do Cofins (SERVIÇO)
                               0.0,                                       // Valor do Cofins (SERVIÇO + PRODUTO)
                               0.0,                                       // Aliquota do CSLL (SERVIÇO)
                               0.0,                                       // Valor do CSLL (SERVIÇO + PRODUTO)
                               0.0,                                       // Valor de IRPF que foi retido
                               0.0,                                       // Valor de PIS que foi retido
                               0.0,                                       // Valor de COFINS que foi retido
                               0.0,                                       // Valor de CSLL que foi retido
                               '',                                        // Notas de Documentos Acumulados
                               0.0,                                       // Aliquota do IRPF (PRODUTOS)
                               0.0,                                       // Aliquota do PIS (PRODUTOS)
                               0.0,                                       // Aliquota do COFINS (PRODUTOS)
                               0.0,                                       // Aliquota do CSLL (PRODUTOS)
                               0.0,                                       // Valor de SERVIÇO que foi retido
                               '',                                        // Notas de documentos acumulados (SERVIÇO)
                               0.0,                                       // Percentual da Seguridade Social
                               0.0,                                       // Valor da Seguridade Social
                               0.0,                                       // Valor do IRPF Retido (Produto)
                               0.0,                                       // Valor do IRPF Devido (Produto)
                               0.0,                                       // Valor do IRPF Retido (Serviço)
                               0.0,                                       // Valor do IRPF Devido (Serviço)
                               0.0,                                       // Valor do PIS Retido (Produto)
                               0.0,                                       // Valor do PIS Devido (Produto)
                               0.0,                                       // Valor do PIS Retido (Serviço)
                               0.0,                                       // Valor do PIS Devido (Serviço)
                               0.0,                                       // Valor do COFINS Retido (Produto)
                               0.0,                                       // Valor do COFINS Devido (Produto)
                               0.0,                                       // Valor do COFINS Retido (Serviço)
                               0.0,                                       // Valor do COFINS Devido (Serviço)
                               0.0,                                       // Valor do CSLL Retido (Produto)
                               0.0,                                       // Valor do CSLL Devido (Produto)
                               0.0,                                       // Valor do CSLL Retido (Serviço)
                               0.0,                                       // Valor do CSLL Devido (Serviço)
                               '',                                        // Ordem de Produção
                               0.0,                                       // Base Orgão Público
                               0.0,                                       // ICMS Orgão Público
                               0,                                         // Número do Conhecimento de Frete
                               '',                                        // Consumidor final
                               'N',                                       // Entrega no Faturamento
                               '',                                        // Cliente de Faturamento
                               '',                                        // Operador da Expedição
                               '',                                        // strSepExp
                               '',                                        // Tabela de Preços utilizada
                               '',                                        // strNum_Pr
                               'N',                                       // Entrega Futura
                               False,                                     // Baixa de Entrega Futura
                               0,                                         // Margem de Lucro
                               0.0,                                       // Base do retido (caso tivesse) com ipi e frete de entrada
                               0.0,                                       // Valor do retido considerando a base acima.
                               'N',                                       // Gerar produção fora da loja
                               '',                                        // strNumReg
                               0,                                         // dtaDtaEntr
                               '',                                        // strClaFi4
                               'N',                                       // AUTO-SERVIÇO
                               '',                                        //Evento
                               '',                                        // AUTINC ENDEREÇO DE ENTREGA
                               '',                                        // Conteúdo do CNFNFE
                               '',                                        // Motivo da Devolução
                               '',
                               True,                                       //Imprimir duplicatas na NFe
                                0,                                         //fltValCre: Double
                                0,                                         //dtadtlBex: TDateTime
                                '',                                        //strEmlCon: String
                                0,                                         //dtaDtESNf: TDateTime
                                0,                                         //tmrHrESNf: TDateTime
                                Nil,                                       //objFinanc: Pointer
                                '',                                        //strDocCon: String         // Conhecimento de Frete
                                '',                                        //strCodObr: String
                                '',                                        //strCodArt: String
                                'N',                                       //strPermut: String         // Permuta para isenção de pagamento de comissão
                                '',                                        //strRetIss: String
                                '',                                        //strOpcDoc: String
                                0,                                         //fltFreSug: Double
                                '',                                        //strNumAde: String
                                0,                                         //fltBasAnt: Double         //BASE DE ICMS ANTECIPADO
                                0,                                         //fltValAnt: Double         //VALOR DE ICMS ANTECIPADO
                                '',                                        //strNaoAtu: String
                                '',                                        //strEntUrg: String
                                '',                                        //strMenExp: String
                                '',                                        //strMenEx2: String
                                '',                                        //strMenEx3: String
                                '',                                        //strMenEx4: String
                                0,                                         //fltDupRec: Double
                                0,                                         //fltValAdt: Double
                                0,                                         //fltDeDVCf: Double
                                '',                                        //strPlaVei: String
                                '',                                        //strKm_Vei: String
                                '',                                        //strCliOri: String
                                '',                                        //strCodMot: String
                                '',                                        //strBetone: String
                                '',                                        //strLacre_: String
                                '',                                        //strTipMps: String
                                '',                                        //strAbatim: String
                                '',                                        //strBrita_: String
                                '',                                        //strConBom: String
                                0,                                         //intFckDia: Integer
                                0,                                         //fltImpPag: Double
                                0,                                         //intPrzMed: integer
                                False,                                     //blnImpPdv: Boolean
                                False,                                     //blnDTEXREP: Boolean
                                '',                                        //strChvNfeDev: String
                                '',                                        //strOpeSol: String
                                False,                                     //blnEst_Dv: Boolean
                                '',                                        //strNumCOODev: String
                                '',                                        //strNumSerDev: String
                                '',                                        //strNumUSUDev: String
                                '',                                        //strTipDocDev: String
                                0,                                         //fltTotDif: Double
                                nil,                                       //objFazenda: Pointer
                                0,                                         //fltFedImp : Double
                                0,                                         //fltEstImp : Double
                                0,                                         //fltMunImp : Double
                                0,                                         //fltTroco_: Double
                                '',                                        //strObsNfeFis: String
                                'N',                                       //strVenPre: String
                                '',                                        //strSeqDocOri: String
                                False,                                     //blnConEqu: Boolean
                                False,                                     //blnDescIncond: Boolean
                                True,                                      //blnGraCTP: Boolean
                                '',                                        //strNumera: String
                               'N',                                        //strEdiPes: String
                                 0,                                        //fltTaxEnt: Double
                                 0,                                        //fltVrdIcm: Double
                                 0,                                        //fltBasVrd: Double
                                 0,                                        //intNroBox: Integer
                                '',                                        //strCodEmbarcacao:String
                                 0,                                        //fltTotBri
                                '',                                        //strTraRdp
                                '',                                        //strCliCtt
                                '',                                        //strCodMod
                                '',                                        //strNumGui
                                '',                                        //strHisCom
                                '',                                        //strCodPrj
                                '',                                        //strNatCfo
                                '',                                        //strTpOper
                                '',                                        //strCupDes
                               'S',                                        //strNotPau
                                 0,                                        //fltCotMoe
                                 0,                                        //fltFreMkp
                                 0,                                        //fltComMkp
                                '',                                        //strPlaFat
                               False,                                      //blnDevWms
                               False,                                      //blnFullFilmentModoRobo
                                 0,                                        //fltFreCot
                                 0,                                        //fltFreRat
                               'N',                                        //strEntSim
                                '',                                        //strSeqDmp
                                '',                                        //strEntFutOpc
                                 0,                                        //fltTotIpiEntFut
                                 0,                                        //fltTotRetEntFut
                                 0,                                        //fltTotFcpSTEntFut
                                 0,                                        //fltICMDes
                                 0,                                        //fltDesPis
                                 '',                                       //strOpFaEx
                                 '',                                       //strDocAba
                                 '',                                       //strEspAba
                                 '',                                       //strEmpAba
                                 '',                                       //strCliAba
                                False,                                     //blnColeta
                                '',                                        //strNumeroRandomico
                                '',                                        //strNumeroDrawback
                                fCfgSis('FINAJU', varString));             //finalidade Ajuste

          {$endregion 'fGravaMovGer'}

        If Result Then
          objAuditoriaSaldo.Adicionar(strAutInc, 'MOVGER');

        End;  //If fltTotAju = 0 Then

        if  blnGeraMovGer And Result then
        Begin
          {Req. 456948-B. fMarcaAjuIteger/fMarcaAjuCadLot rodavam aqui, uma vez
           por documento, e a iteracao seguinte sobrescrevia o que a anterior
           gravou. Agora so acumula o documento; a marcacao sai uma unica vez
           apos o laco, em fAplicaAjusteIteger e fAplicaAjusteCadLot.}
          If Not fEmptyStr(strAutInc) Then
            sltDocsRodada.Add(strAutInc);

          if Result Then
          Begin
            {Req. 456948 - custo vem do dicionario carregado uma vez em
             pCarregaCustoItens, em vez de reabrir qryIteGer por linha.}
            With qryGen Do
            Begin
              qryGen.RecNo := intPosIni;
              intContador := 1;
              MovDetParams.init;
              MovDetParams.ABatch := objBatchMovDet;

              While (Result) And ((Not Eof) and (intContador <= intQtdItens)) Do
              Begin
                If (blnUtilizaMapaDeContagemColetor) And (strEspDoc = 'AJ') Then
                  pFinalizaMapDet(FieldByName('ITE_CODITE').AsString,  FieldByName('ITE_NUMLOT').AsString);

                If ((strEspDoc = 'AJ') And (FormatFloat('###0.0000', FieldByName('ITE_DIFERE').AsFloat) <> '0,0000')) Or
                   ((strEspDoc = 'ML') And (FormatFloat('###0.0000', FieldByName('ITE_DIFGML').AsFloat) <> '0,0000')) Then
                Begin
                  {$region 'Gravação dos itens'}

                  {***************************************************************}
                  {* VERIFICA SE LANCAMENTO SERA DE ENTRADA OU SAIDA CONFORME    *}
                  {* VALOR DA DIFERENCA: SE FOR NEGATIVA INDICA QUE DEVE SER     *}
                  {* FEITA UMA ENTRADA, CASO POSITIVA INDICA UMA SAIDA           *}
                  {************************************************************JC*}
                  If strEspDoc = 'AJ' Then
                    strEntSai := IIF(FieldByName('ITE_DIFERE').AsFloat > 0, 'E', 'S')
                  Else
                    strEntSai := IIF(FieldByName('ITE_DIFGML').AsFloat > 0, 'E', 'S');

                  IF strEntSai = 'E' Then
                    strClaFis := '1999'
                  Else
                    strClaFis := '5999';


                  {***************************************************************}
                  {* TRANSFORMA VALOR DA QUANTIDADE E TOTAL DO ITEM EM VALORES   *}
                  {* POSITIVOS COM BASE SE E' ENTRADA OU SAIDA DE ESTOQUE        *}
                  {************************************************************JC*}
                  If strEspDoc = 'AJ' Then
                  Begin
                   // fltQtdIte := IIF(strEntSai = 'S', FieldByName('ITE_DIFERE').AsFloat, - FieldByName('ITE_DIFERE').AsFloat);
                   // fltTotIte := IIF(strEntSai = 'S', FieldByName('ITE_TOTITE').AsFloat, - FieldByName('ITE_TOTITE').AsFloat);
                    fltQtdIte := Abs(FieldByName('ITE_DIFERE').AsFloat);
                    fltTotIte := Abs(FieldByName('ITE_TOTITE').AsFloat);
                  End
                  Else If strEspDoc = 'ML' Then
                  Begin
                   // fltQtdIte := IIF(strEntSai = 'S', FieldByName('ITE_DIFGML').AsFloat, - FieldByName('ITE_DIFGML').AsFloat);
                   // fltTotIte := IIF(strEntSai = 'S', FieldByName('ITE_TOTGML').AsFloat, - FieldByName('ITE_TOTGML').AsFloat);
                    fltQtdIte := Abs(FieldByName('ITE_DIFGML').AsFloat);
                    fltTotIte := Abs(FieldByName('ITE_TOTGML').AsFloat);
                  End;

                  {Req. 456948 - vem do dicionario carregado uma vez em
                   pCarregaCustoItens; item ausente deixa recCusto zerado.}
                  If Not dicCustoItem.TryGetValue(FieldByName('ITE_CODITE').AsString,
                                                  recCusto) Then
                    recCusto := Default(TdtoCustoIteGer);

                  if blnAjuGra Then
                    fltCnv_Ml := recCusto.fltCnv_Ml
                  Else
                    fltCnv_Ml := 1;

                  If (opcGravacao = opcAtivar) And SameText(FieldByName('ITE_STATUS').AsString, 'INATIVO') Then
                    pAtivaItem(FieldByName('ITE_CODITE').AsString);

                  Result := fGravaMovDetSimplificada(strAutTmp,                          // Retorna Auto-Incremento por Referencia
                                         strAutInc,                                                  // Sequencial do Arquivo Geral
                                         IIF(blnAjuGra, strNumDocML, strNumDocAJ),                   // Numero Documento
                                         strEspDoc,                                                  // Espécie
                                         VS_strCodEmp,                                               // Empresa
                                         FieldByName('ITE_CODITE').AsString,                         // Cód. Item
                                         strLoginUsuarioLogado,                                      // Vendedor
                                         '',                                                         // Código Diversos
                                         FieldByName('ITE_CODMAR').AsString,                         // Código da Marca
                                         '',                                                         // Fornecedor
                                         fCfgSis('CLIAJU'),                                          // Cliente
                                         VS_Date,                                                    // Data da Entrada
                                         fTime(),                                                    // Hora da Entrada
                                         VS_Date,                                                    // Data do Documento
                                         '01000',                                                    // Condição de Pagamento
                                         'C',                                                        // Tipo: (C)liente / (F) Fornecedor
                                         '',                                                         // Estado do Fornecedor
                                         FieldByName('ITE_DESITE').AsString,                         // Descrição do Item
                                         FieldByName('ITE_REFERE').AsString,                         // Referência do Item
                                         FieldByName('ITE_CODUNI').AsString,                         // Cód. Unidade
                                         FieldByName('ITE_CODFOR').AsString,                         // Fornecedor Item
                                         fltQtdIte,                                                  // Quantidade do Item
                                         IIF(strEspDoc = 'AJ', FieldByName('ITE_VALUNE').AsFloat, FieldByName('ITE_VALUNG').AsFloat),   // Valor Unitario
                                         IIF(strEspDoc = 'AJ', FieldByName('ITE_VALUNE').AsFloat, FieldByName('ITE_VALUNG').AsFloat),   // Valor Unitário Original
                                         IIF(strEspDoc = 'AJ', FieldByName('ITE_VALUNE').AsFloat, FieldByName('ITE_VALUNG').AsFloat),   // Valor Unitário Original sem juros
                                         fltTotIte,                                                  // Total do Item
                                         fltTotIte,                                                  // Valor Contábil do Item
                                         (recCusto.fltPreCus / fltCnv_Ml) * fltQtdIte,    // Valor Total de Custo
                                         (recCusto.fltPreMed / fltCnv_Ml) * fltQtdIte,    // Valor Total Medio
                                         0.0,                                                        // % Desconto do Item
                                         0.0,                                                        // Valor do Frete
                                         0.0,                                                        // Valor do Desconto Especial
                                         '',                                                         // Código do Representante
                                         '',                                                         // Código do Vendedor 2
                                         0.0,                                                        // Percentual de Comissão do Vendedor
                                         0.0,                                                        // Total de Comissão do Vendedor
                                         0.0,                                                        // Total de Comissão do Vendedor 2
                                         strClaFis,                                                  // Classificação Fiscal
                                         '',                                                         // Código Fiscal
                                         0.0,                                                        // Valor IPI
                                         0.0,                                                        // Aliquota IPI
                                         0.0,                                                        // Base IPI
                                         0.0,                                                        // Valor de ICMS
                                         0.0,                                                        // Aliquota de ICMS
                                         0.0,                                                        // Base de ICMS
                                         0.0,                                                        // Valor de Substituição
                                         0.0,                                                        // Aliquota de Substituição
                                         0.0,                                                        // Base de Substituição
                                         0.0,                                                        // Total de Peso
                                         0.0,                                                        // Percentual de Base de ICMS
                                         0.0,                                                        // Percentual de Redução de Base
                                         False,                                                      // Indica se ja esta Faturado
                                         IIF(blnAjuGra, 'AJ', EmptyStr),                             // Tipo de Faturamento
                                         IIF(blnAjuGra, strNumDocAJ, EmptyStr),                      // Numero de Faturamento
                                         IIF(blnAjuGra, VS_strCodEmp, EmptyStr),                     // Empresa dd Faturamento
                                         IIF(blnAjuGra, VS_Date, 0),                                 // Data de Faturamento
                                         strLoginUsuarioLogado,                                      // Vendedor do Faturamento
                                         IIF(blnAjuGra, '01000', EmptyStr),                          // Condição de Pagamento do Faturamento
                                         IIF(blnAjuGra, fltTotIte, 0.0),                             // Valor do Faturamento
                                         'NOR',                                                      // Identificação Produto ( Normal / Outros )
                                         FieldByName('ITE_INCPIS').AsString,                         // Indice se incide Pis
                                         '',                                                         // Série
                                         0.0,                                                        // Valor de Despesa Acessória
                                         'N',                                                        // Nota Especial
                                         '',                                                         // Documento da Devolução
                                         '',                                                         // Espécie da Devolução
                                         '',                                                         // Empresa da Devolução
                                         '',                                                         // Item de Chamada (TINTA DE MAQUINA)
                                         '',                                                         // Item da Tinta (TINTA DE MAQUINA)
                                         '',                                                         // Descrição da Cor (TINTA DE MAQUINA)
                                         '',                                                         // Tipo de Embalagem (TINTA DE MAQUINA)
                                         0.0,                                                        // Quantidade de Embalagem (TINTA DE MAQUINA)
                                         0.0,                                                        // Preço da Embalagem (TINTA DE MAQUINA)
                                         '',                                                         // Tipo de Preço (TINTA DE MAQUINA)
                                         0.0,                                                        // Preço de Venda da Tinta (TINTA DE MAQUINA)
                                         0.0,                                                        // Preço de Compra da Tinta (TINTA DE MAQUINA)
                                         0.0,                                                        // Fator da Tinta (TINTA DE MAQUINA)
                                         '',                                                         // Produto Embalagem (TINTA DE MAQUINA)
                                         strLoginUsuarioLogado,                                      // Código do Digitador
                                         '',                                                         // Codigo da Condição
                                         '',                                                         // Forma de Pagamento
                                         '',                                                         // Item da Embalagem
                                         '',                                                         // Grupo do Item da Embalagem
                                         0,                                                          // Quarto da Lazzumiz
                                         'N',                                                        // É item em promoção?
                                         '',                                                         // Tipo de Tinta
                                         0.0,                                                        // Quantidade de Pulsos
                                         '',                                                         // Número do pedido de compras
                                         '',                                                         // Origem do documento
                                         '',                                                         // Pedido de Venda - Número
                                         '',                                                         // Pedido de Venda - Espécie
                                         '',                                                         // Pedido de Venda - Empresa
                                         0,                                                          // Pedido de Venda - Sequencial
                                         '',                                                         // Ordem de Produção
                                         '',                                                         // Descrição para Nota Fiscal Especial
                                         '',
                                         0,
                                         0,
                                         0.0,                                                        // Volume a produzir (Tinta de Máquina Venda Dinâmica)
                                         '',
                                         '',
                                         False,
                                         False,
                                         '',                                                           //  Especie da Entrega Fututa
                                         '',                                                           //  Documento da Entrega Fututa
                                         '',
                                         '',                                                           //  Empresa da Entrega Fututa
                                         '',
                                         '',
                                         '',
                                         '',
                                         0.0,
                                         '',
                                         0.0,
                                         0.0,
                                         0,
                                         'N',
                                         '',
                                         0,
                                         (recCusto.fltPreCus / fltCnv_Ml) * fltQtdIte, //fltTotCu2
                                         0,
                                         0,
                                         '',
                                         FieldByName('ITE_NUMLOT').AsString,
                                         '',
                                         0,
                                         0,
                                         0,
                                         (recCusto.fltPreUlt / fltCnv_Ml) * fltQtdIte, //fltTotUlt
                                         (recCusto.fltImpUlt / fltCnv_Ml) * fltQtdIte, //fltImpUlt
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         '',
                                         0,
                                         0,
                                         0,
                                         '',
                                         '',
                                         '',
                                         0,
                                         0,
                                         0,
                                         0,
                                         MovDetParams);   {Req. 456948 - M4}

                  strAutTmp := fNextAutoIncrem(strAutTmp);

                  If Not Result Then
                    Break;

                   {$endregion}
                  {*****************************************}
                  {* ATUALIZA O ESTOQUE DO ITEM, DE ACORDO *}
                  {* COM O TIPO DE MOVIMENTAÇÃO (E/S)      *}
                  {**************************************JC*}

                  If strEspDoc = 'AJ' Then
                  Begin
                    {Req. 456948-B. Antes chamava fAtualizaEstoqueCadIte, que
                     atualizava ITEGER (por lote) e CADLOT. ITEGER agora e
                     feito 1 vez so, agregado por item, em fAplicaAjusteIteger
                     (SUM(MOVDET) sobre todos os lotes). Aqui so sobra CADLOT,
                     que continua por lote porque cada lote tem saldo proprio.}
                    Result := objCadLot.fAtualizaEstoqueLote(FieldByName('ITE_CODITE').AsString,
                                                             strEntSai,
                                                             FieldByName('ITE_NUMLOT').AsString,
                                                             fltQtdIte,
                                                             '',      // strCodEmp
                                                             {AUsarBatchSaldos - mesma expressao de untFuncFat.pas.}
                                                             (Not VS_blnNotificaSaldoAbaixMinimo));

                    {Req. 456948 - Q8. O item entra uma vez, mesmo aparecendo em
                     varios lotes; a notificacao roda apos o flush, sobre o
                     saldo final.}
                    If Result Then
                      sltItensSaldoAlterado.Add(FieldByName('ITE_CODITE').AsString);
                  End
                  Else If strEspDoc = 'ML' Then
                  Begin
                    Result := fAtualizaEstoqueML(FieldByName('ITE_CODITE').AsString,
                                                 IIF(strEntSai = 'S', fltQtdIte, - fltQtdIte),
                                                 FieldByName('ITE_NUMLOT').AsString);
                  End;

                  {*********************************************}
                  {* ZERA A CONTAGEM E MARCA COMO NAO DIGITADO *}
                  {******************************************JC*}
                  if not FItemZeraList.Contains(FieldByName('ITE_CODITE').AsString,
                                                FieldByName('ITE_NUMLOT').AsString,
                                                FieldByName('ITE_LOCFIS').AsString) Then
                  Begin
                  lItemZera.FCodite := FieldByName('ITE_CODITE').AsString;
                  lItemZera.FNumLot := FieldByName('ITE_NUMLOT').AsString;
                  lItemZera.FLocFis := FieldByName('ITE_LOCFIS').AsString;

                  FItemZeraList.AddItem(lItemZera);
                  End;

                  If fLoteComLocalizacaoCritica(FieldByName('ITE_CODITE').AsString, FieldByName('ITE_NUMLOT').AsString) Then
                    ReprocessarItem(FieldByName('ITE_CODITE').AsString, VS_strCodEmp, False);


                  If Not Result Then
                    Break;

                End;

                {Req. 456948 - descarga parcial: fim de item e o unico ponto
                 seguro (MOVTRI/MOVAUX sao filhas de MOVDET por FK, mesmo
                 lote). Sem isto o lote acumularia dezenas de milhares de
                 comandos em memoria ate o fim do laco. O Clear apos o
                 Execute e obrigatorio - ExecuteBatch nao esvazia a lista.}
                If Assigned(objBatchMovDet) And
                   (objBatchMovDet.CommandCount >= 200) Then
                Begin
                  objBatchMovDet.Execute;
                  objBatchMovDet.Clear;
                End;

                {Req. 456948-B - B5/B5b. Bombeamento de mensagens e repaint da
                 barra agora a cada 50 linhas, nao por linha - ~14.000 linhas
                 na producao. Contador inteiro proprio porque Position e
                 Double e nao aceita mod.}
                Inc(intLinhasProg);
                If (intLinhasProg mod 50 = 0) Then
                Begin
                  pgbProgresso.Position := intLinhasProg;
                  pBombeiaSoRepaint;   {Req. 456948-B: so WM_PAINT, sem abrir janela pro lote de saldos (M1b)}
                End;

                Inc(intContador);
                Next;
                If Eof Then
                 intContador := intQtdItens + 1;
              End;

            End; //With qryGen Do
          End; //if Result Then
        End; // if blnGeraMovGer And Result then

      End; // For i:= 1 To intQtdDoc do

      {Req. 456948 - o lote TEM que ir ao banco antes de qualquer leitura de
       MOVDET. fAplicaAjusteIteger e fAplicaAjusteCadLot derivam dele.}
      If Assigned(objBatchMovDet) And (objBatchMovDet.CommandCount > 0) Then
        objBatchMovDet.Execute;

      {Req. 456948 - uma unica passada, derivando de MOVDET. fAplicaAjusteIteger
       so roda na passada 'AJ': na passada 'ML' (CFG_USATMQ) T.QTDAJU soma
       DET_QTDITE em gramas, e gravar isso em ITE_SALDOS corromperia o saldo em
       unidades do item. fAplicaAjusteCadLot (por lote) nao sofre do mesmo
       problema e roda em qualquer passada.}
      If Result And (strEspDoc = 'AJ') Then
        Result := fAplicaAjusteIteger(sltDocsRodada);
       If Result And (strEspDoc = 'AJ') Then
         Result := fAplicaAjusteCadLot(sltDocsRodada);

      If blnGerarTransferencia And (strCCETRA <> '') And (strEspDoc <> 'ML') Then
      Begin
        qryGen.Filtered := False;
        qryGen.Filter   :=  strFilterBkp + IIf(strFilterBkp <> '', ' AND ', '') + 'ITE_DIFERE < 0';
        qryGen.Filtered := True;

        For i := 1 To qryGen.RecordCount Do
        Begin
          qryGen.RecNo := i;

          //Adicionando o item à lista para posterior zeramento na função “fZeraItens”.
          if not FItemZeraList.Contains(qryGen.FieldByName('ITE_CODITE').AsString,
                              qryGen.FieldByName('ITE_NUMLOT').AsString,
                              qryGen.FieldByName('ITE_LOCFIS').AsString) Then
          Begin
            lItemZera.FCodite := qryGen.FieldByName('ITE_CODITE').AsString;
            lItemZera.FNumLot := qryGen.FieldByName('ITE_NUMLOT').AsString;
            lItemZera.FLocFis := qryGen.FieldByName('ITE_LOCFIS').AsString;
            FItemZeraList.AddItem(lItemZera);
        End;
        End;

        qryGen.First;
        Result := fIncluiPedido(qryGen, strErro);

      End;

      If strErro <> '' Then
        result := False;

      If Assigned(objBatchMovDet) Then
        FreeAndNil(objBatchMovDet);   {Req. 456948 - M4}
      If Assigned(sltDocsRodada) Then
        FreeAndNil(sltDocsRodada);
      pFechaMoldesMovDet;            {Req. 456948-B - B10b}
      qryGen.EnableControls;
      Screen.Cursor := crDefault;

      If strFilterBkp <> '' Then
      begin
        qryGen.Filtered := False;
        qryGen.Filter := strFilterBkp;
        qryGen.Filtered := True;
      End;
    Except
      On E: Exception Do
      Begin
        If strFilterBkp <> '' Then
        begin
          qryGen.Filtered := False;
          qryGen.Filter := strFilterBkp;
          qryGen.Filtered := True;
        End;

        qryGen.EnableControls;
        Screen.Cursor := crDefault;
        If Assigned(objBatchMovDet) Then
          FreeAndNil(objBatchMovDet);   {Req. 456948 - M4}
        If Assigned(sltDocsRodada) Then
          FreeAndNil(sltDocsRodada);
        pFechaMoldesMovDet;            {Req. 456948-B - B10b}
        Result := False;
        pMensagensErro(E.Message, '[fConfirmaAjuste]');
      End;
    End;
  End;  // fVerificaSeTemDiferencasParaGravar
  {$endregion}
  {$region 'AFinalizaContagem'}
  If AFinalizaContagem then
  Begin
    Try
      pSeparaItensSemNecessidadeCalc;
      If (strEspDoc <> 'ML') Then
        TControleContagemBalancoEstoque.pConcluiBalgerFinalizadas;

      If (blnUtilizaMapaDeContagemColetor) Then
        pFinalizaMapDet('', '');

      pAjustaITEGERSemContagemNaCADLOT;

      Result := True;

    Except
      On E: Exception Do
      Begin
        Result := False;
      End;
    End;
  End;
  {$endregion}

end;

{***************************************************************}
{* FUNCAO QUE CALCULA O TOTAL DO AJUSTE SENDO O MESMO DADO POR *}
{* TOTAL DAS SAIDAS MENOS O TOTAL DAS ENTRADAS...              *}
{* COMO VALOR TOTAL DO ITEM NEGATIVO INDICA ENTRADA E POSITIVO *}
{* INDICA SAIDA, BASTA APENAS SOMAR OS VALORES TOTAIS          *}
{************************************************************JC*}
function TfrmBalancoEstoqueGravar.fCalcTotais(strEspDoc: String; PosRecNo: integer; var blnGeraMovGer: Boolean): Double;
  Var
    strEntSai: String;
    intContador : integer;

begin
  blnGeraMovGer := False;
  Result := 0;

  With qryGen Do
  Begin

    DisableControls;
    First;
    qryGen.RecNo := PosRecNo;
    strCodItens := '';
    intContador := 1;
    While (Not Eof) And (intContador <= intQtdItens) Do
    Begin
      If (strCCETRA <> '') And (FieldByName('ITE_DIFERE').AsFloat < 0) And (strEspDoc = 'AJ')  Then
      Begin
        blnGerarTransferencia := True;
        Next;
        Continue;
      End;
      blnGeraMovGer := True;
      If (FieldByName('ESPITE').AsString = strEspDoc) Then
      Begin

        If (FieldByName('ESPITE').AsString = 'AJ') Then
          strEntSai := IIF(FieldByName('ITE_DIFERE').AsFloat > 0, 'E', 'S')
        Else
          strEntSai := IIF(FieldByName('ITE_DIFGML').AsFloat > 0, 'E', 'S');

        If (FieldByName('ESPITE').AsString = 'AJ') Then
          Result := Result + FieldByName('ITE_TOTITE').AsFloat
        Else
          Result := Result + FieldByName('ITE_TOTGML').AsFloat;

      End
      Else If (FieldByName('ESPITE').AsString = 'ML') Then
      Begin
        {****************************************************}
        {* CASO FOR TIPO "ML" PEGA O AJUSTE DO SALDO FISICO *}
        {*************************************************JB*}
        strEntSai := IIF(FieldByName('ITE_DIFERE').AsFloat > 0, 'E', 'S');

        If (FormatFloat('###0.0000', FieldByName('ITE_DIFERE').AsFloat) <> '0,0000') Then
          Result := Result + FieldByName('ITE_TOTITE').AsFloat;

      End;

      Inc(intContador);
      strCodItens := strCodItens + '"' + FieldByName('ITE_CODITE').AsString + '"';
      Next;
      If Eof Then
       intContador := intQtdItens + 1;
    End;

    EnableControls;

  End;
  qryGen.RecNo := PosRecNo;
  strCodItens := AnsiReplaceStr(strCodItens, '""', '","');
  If Result <> 0 Then
   Result := - Result;
end;

procedure TfrmBalancoEstoqueGravar.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10: If btnConfirma.Visible Then
              btnConfirma.Click;

    VK_F1:  btnGravaTodos.Click;

    VK_F2:  btnGravaAtivos.Click;

    VK_F3:  btnImprimeInativos.Click;
  End;

  Case Key Of
    VK_F10,
    VK_F1,
    VK_F2,
    VK_F3: Key := 0;
  End;
end;

procedure TfrmBalancoEstoqueGravar.btnGravaAtivosClick(Sender: TObject);
begin
  inherited;
  strOpcGra := 'CONFIRMAR_ATIVOS';

  If Not btnGravaAtivos.Visible Then
    Exit;

  opcGravacao := opcAtivos;
  btnConfirma.Click;
end;

procedure TfrmBalancoEstoqueGravar.btnGravaTodosClick(Sender: TObject);
begin
  inherited;
  strOpcGra := 'CONFIRMAR_ATIVAR_INATIVOS';

  If Not btnGravaTodos.Visible Then
    Exit;

  opcGravacao := opcAtivar;
  btnConfirma.Click;
end;

procedure TfrmBalancoEstoqueGravar.btnImprimeInativosClick(Sender: TObject);
begin
  inherited;

  If Not btnImprimeInativos.Visible Then
    Exit;
  pGeraRelatorioDivergencia('Inativo');
end;

procedure TfrmBalancoEstoqueGravar.btnSemDivergenciaClick(Sender: TObject);
begin
  inherited;
  strOpcGra := 'CONFIRMAR_SEM_DIVERGENCIA';

  If fPergunta('Efetivar contagem dos itens sem divergencias?') Then
  Begin
    Try
      pCriarFormularios(TfrmGravando, frmGravando);
      frmGravando.blnTempoRestante := True;
      frmGravando.fExecutarAcao := fgravar;
      frmGravando.ShowModal;
      if frmGravando.blnConfirma Then
        fMensagem('','Gravação de arquivos concluída !',['&O K']);
    Finally
      FreeAndNil(frmGravando);
      pLimpaTela;
    End;
  End;
  {}
end;

procedure TfrmBalancoEstoqueGravar.dbgItensDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  If Not qryGen.IsEmpty Then
  Begin

    If (Column.FieldName = 'ITE_DIFERE') And (FormatFloat('###0.0000',qryGen.FieldByName('ITE_DIFERE').AsFloat) <> '0,0000') Then
    Begin
      dbgItens.Canvas.Font.Color := clRed;
    End;

    If (Column.FieldName = 'ITE_DIFGML') And (FormatFloat('###0.0000',qryGen.FieldByName('ITE_DIFGML').AsFloat) <> '0,0000') Then
    Begin
      dbgItens.Canvas.Font.Color := clRed;
    End;

  End;

  dbgItens.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TfrmBalancoEstoqueGravar.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, nil, Key, arrFornec,False) Then
  Begin
    fvalidaCampos(edtCodFor,False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBalancoEstoqueGravar.edtCodIteEnter(Sender: TObject);
begin
  inherited;
  pLimpaTela;
end;

procedure TfrmBalancoEstoqueGravar.edtCodIteExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodIte,edtDesIte,arrProduto,nil,fRetNomProduto,'do Produto');
end;

procedure TfrmBalancoEstoqueGravar.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, nil, Key, arrProduto, False) Then
  Begin
    fvalidaCampos(edtCodIte,False);
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBalancoEstoqueGravar.edtCodMarExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodMar, edtDesMar, arrMarca, fRetNomeMarca, nil, 'da Marca');
end;

procedure TfrmBalancoEstoqueGravar.edtCodMarKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrMarca, False) Then
  Begin
    fvalidaCampos(edtCodMar,False);
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBalancoEstoqueGravar.edtCodUniExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodUni,edtDesUni,arrUnidade,fRetNomUnidade,Nil,'da unidade');
end;

procedure TfrmBalancoEstoqueGravar.edtCodUniKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqUnidade(Self, edtCodUni, edtDesUni, nil, nil, Key, arrUnidade, False) Then
  Begin
    fvalidaCampos(edtCodUni,True);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmBalancoEstoqueGravar.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;

  Try

    If (inherited fValidaCampos(Sender)) Then
    Begin
      If (Sender = edtPrdGru) Then
        pBuscaItens;
    End;

  Except
    On E: Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmBalancoEstoqueGravar.fValidaCampos]');
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmBalancoEstoqueGravar.fAplicaAjusteIteger(AsltDocs: TStringList): Boolean;
  Var
    qryUpdate: TUniQuery;
begin
  Result := True;

  If (AsltDocs = Nil) Or (AsltDocs.Count = 0) Then
    Exit;

  qryUpdate := fCriaQuery;
  Try
    With qryUpdate, SQL Do
    Begin
      Add(' UPDATE ITEGER G                                          ');
      Add(' INNER JOIN (SELECT MD.DET_CODITE,                        ');
      Add('                    MD.DET_CODEMP,                        ');
      Add('                    MAX(MD.DET_SEQGER) AS SEQGER,         ');
      Add('                    SUM(IF(MD.DET_CLAFIS = 1999,          ');
      Add('                           MD.DET_QTDITE,                 ');
      Add('                           MD.DET_QTDITE * -1)) AS QTDAJU ');
      Add('               FROM MOVDET MD                             ');
      Add('              WHERE MD.DET_CODEMP = :CODEMP               ');
      Add('                AND MD.DET_SEQGER IN (' + fCommaText(AsltDocs, True) + ') ');
      Add('              GROUP BY MD.DET_CODITE, MD.DET_CODEMP) T    ');
      Add('    ON T.DET_CODITE = G.ITE_CODITE                        ');
      Add('   AND T.DET_CODEMP = G.ITE_CODEMP                        ');
      Add('   SET G.ITE_DTAAJU = :DTAAJU,                            ');
      Add('       G.ITE_SEQAJU = T.SEQGER,                           ');
      Add('       G.ITE_QTDAJU = T.QTDAJU,                           ');
      {Req. 456948-B. Sintetiza o que antes eram N UPDATE ITEGER (1 por
       lote) dentro do loop de ajuste, via objCadLot.fAtualizaEstoqueLote.
       T.QTDAJU ja soma todos os lotes do item com o sinal certo (CLAFIS
       1999 = entrada).}
      Add('       G.ITE_SALDOS = G.ITE_SALDOS + T.QTDAJU,            ');
      Add('       G.ITE_DHUPES = :DTAAJU                             ');

      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('DTAAJU').AsDate   := VS_Date;
    End;

    Try
      qryUpdate.ExecSQL;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmBalancoEstoqueGravar.fAplicaAjusteIteger]');
        Result := False;
      End;
    End;
  Finally
    FreeAndNil(qryUpdate);
  End;
end;

{***************************************************************}
{* Req. 456948 - idem para a CADLOT, agrupando por item + lote, *}
{* que e a granularidade da movimentacao no MOVDET.             *}
{***************************************************************}
function TfrmBalancoEstoqueGravar.fAplicaAjusteCadLot(AsltDocs: TStringList): Boolean;
  Var
    qryUpdate: TUniQuery;
begin
  Result := True;

  If (AsltDocs = Nil) Or (AsltDocs.Count = 0) Then
    Exit;

  qryUpdate := fCriaQuery;
  Try
    With qryUpdate, SQL Do
    Begin
      Add(' UPDATE CADLOT L                                          ');
      Add(' INNER JOIN (SELECT MD.DET_CODITE,                        ');
      Add('                    MD.DET_CODEMP,                        ');
      Add('                    MD.DET_NUMLOT,                        ');
      Add('                    MAX(MD.DET_SEQGER) AS SEQGER,         ');
      Add('                    SUM(IF(MD.DET_CLAFIS = 1999,          ');
      Add('                           MD.DET_QTDITE,                 ');
      Add('                           MD.DET_QTDITE * -1)) AS QTDAJU ');
      Add('               FROM MOVDET MD                             ');
      Add('              WHERE MD.DET_CODEMP = :CODEMP               ');
      Add('                AND MD.DET_SEQGER IN (' + fCommaText(AsltDocs, True) + ') ');
      Add('              GROUP BY MD.DET_CODITE, MD.DET_CODEMP,      ');
      Add('                       MD.DET_NUMLOT) T                   ');
      Add('    ON T.DET_CODITE = L.LOT_CODITE                        ');
      Add('   AND T.DET_CODEMP = L.LOT_CODEMP                        ');
      Add('   AND T.DET_NUMLOT = L.LOT_NUMLOT                        ');
      Add('   SET L.LOT_DTAAJU = :DTAAJU,                            ');
      Add('       L.LOT_SEQAJU = T.SEQGER,                           ');
      Add('       L.LOT_QTDAJU = T.QTDAJU                            ');

      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('DTAAJU').AsDate   := VS_Date;
    End;

    Try
      qryUpdate.ExecSQL;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmBalancoEstoqueGravar.fAplicaAjusteCadLot]');
        Result := False;
      End;
    End;
  Finally
    FreeAndNil(qryUpdate);
  End;
end;

function TfrmBalancoEstoqueGravar.fIncluiPedido(cdsConsulta: TUniQuery; var strErro: String): boolean;
  var
    objGeraTransferencia: TGeraTransferencia;
Begin
   objGeraTransferencia := TGeraTransferencia.Create(cdsConsulta, fGeraTransferenciaItem);
   objGeraTransferencia.strFieldQuantidade := 'ITE_DIFERE';
   objGeraTransferencia.strEmpresaDestino := strCCETRA;
   Result := objGeraTransferencia.fGeraPedidosVenda(strErro);
   If Result Then
     Result := strErro = '';

End;



function TfrmBalancoEstoqueGravar.fLoteComLocalizacaoCritica(strCodIte,
  strNumLot: String): Boolean;
Var
  qryAux: TUniQuery;
begin
  Result := False;

  If fEmptyStr(strCodIte) Then
    Exit;

  If fEmptyStr(strNumLot) Then
    Exit;

  If Not fCfgSis('CADLOC', varBoolean) Then
    Exit;

  {Req. 456948-B - B5. Curto-circuito: se a base nao tem nenhuma
   localizacao marcada como critica, esta funcao nao pode devolver True, e
   a consulta por linha e trabalho jogado fora - 280 vezes numa rodada de
   280 linhas quando CFG_CADLOC = "S" e CADLOC.LOC_CRITIC nunca e "S".
   Avaliado uma vez por gravacao - fGravar zera o cache no inicio.}
  If FintTemLocCritica < 0 Then
  Begin
    qryAux := fCriaQuery;
    Try
      qryAux.SQL.Add(' SELECT COUNT(1) AS QTD FROM CADLOC WHERE LOC_CRITIC = "S" ');
      qryAux.Open;
      FintTemLocCritica := IIF(qryAux.FieldByName('QTD').AsInteger > 0, 1, 0);
    Finally
      FreeAndNil(qryAux);
    End;
  End;

  If FintTemLocCritica = 0 Then
    Exit;

  qryAux := fCriaQuery;

  Try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(' SELECT ');
    qryAux.SQL.Add('   COUNT(1) AS QTD ');
    qryAux.SQL.Add(' FROM ');
    qryAux.SQL.Add('   CADLOT ');
    qryAux.SQL.Add('   INNER JOIN CADLOC  ON LOC_CODLOC = LOT_LOCFIS ');
    qryAux.SQL.Add(' WHERE LOT_CODITE = :CODITE ');
    qryAux.SQL.Add('   AND LOT_NUMLOT = :NUMLOT ');
    qryAux.SQL.Add('   AND LOC_CRITIC = "S" ');

    qryAux.ParamByName('CODITE').AsString := strCodIte;
    qryAux.ParamByName('NUMLOT').AsString := strNumLot;

    qryAux.Open;

    Result := qryAux.FieldByName('QTD').AsFloat > 0;

  Finally
    FreeAndNil(qryAux);
  End
end;


{TItemZeraList}
function TItemZeraList.fChave(const ACodite, ANumLot, ALocFis: string): String;
begin
  Result := ACodite + #1 + ANumLot + #1 + ALocFis;
end;

{Req. 456948-B - B1. Nao devolve a capacidade ao sistema: a lista e usada uma
 vez por gravacao e a rodada seguinte tem tamanho parecido, entao manter o
 array evita realocar tudo de novo. FQtd = 0 e o que zera a lista de fato.}
procedure TItemZeraList.Clear;
begin
  FQtd := 0;
  If Assigned(FIndice) Then
    FIndice.Clear;
end;

{Req. 456948-B - B3. Carga do conjunto PROCESSADO em BALZER, com
 ZER_ORIGEM = "Z" - distinto da foto do B9, que usa "C".

 E o driver das passadas set-based das Fases 0 e 2. Sai de FItemZeraList, e
 nao de LOT_DIGCON = "S": o conjunto processado e o que a rotina decidiu
 processar, que pode diferir do contado (gravacao so de ativos, itens
 acrescentados por pAjustaITEGERSemContagemNaCADLOT, ramo de transferencia).

 Blocos de 500 INSERT concatenados, o mesmo tamanho que pInsertLoteLGCEST ja
 usa em producao.}
procedure TfrmBalancoEstoqueGravar.pCarregaBALZERZeramento;
  Var
    qryCarga: TUniQuery;
    ArrItens: TArrItemZera;
    Item    : TItemZera;
    sltVals : TStringList;
    strDta  : String;
    strHra  : String;

  {Req. 456948-B - B3c. A juncao e manual de proposito: sltVals.CommaText
   APLICA ASPAS - envolve cada tupla em aspa dupla e duplica as internas, e
   o comando sai com erro de sintaxe. CommaText serve para lista de valores
   simples, nao para montar VALUES de SQL.}
  procedure pDescarrega;
    Var
      strLista: String;
      intIdx  : Integer;
  Begin
    If sltVals.Count = 0 Then
      Exit;

    strLista := '';
    For intIdx := 0 To sltVals.Count - 1 Do
    Begin
      If intIdx > 0 Then
        strLista := strLista + ',';
      strLista := strLista + sltVals[intIdx];
    End;

    qryCarga.SQL.Clear;
    qryCarga.SQL.Add(' INSERT INTO BALZER (ZER_CON_ID, ZER_CODCON, ZER_ORIGEM,  ');
    qryCarga.SQL.Add('                     ZER_CODEMP, ZER_CODITE, ZER_NUMLOT,  ');
    qryCarga.SQL.Add('                     ZER_LOCFIS, ZER_DTACAD, ZER_HRACAD)  ');
    qryCarga.SQL.Add(' VALUES ' + strLista);
    qryCarga.ExecSQL;
    sltVals.Clear;
  End;

begin
  ArrItens := FItemZeraList.GetItems;
  If Length(ArrItens) = 0 Then
    Exit;

  strDta := QuotedStr(FormatDateTime('yyyy-mm-dd', VS_Date));
  strHra := QuotedStr(FormatDateTime('hh:mm:ss', fTime()));

  qryCarga := fCriaQuery;
  sltVals  := TStringList.Create;
  Try
    {Idempotencia: refaz a lista em vez de duplicar}
    qryCarga.SQL.Text := ' DELETE FROM BALZER               ' +
                         '  WHERE ZER_CODCON = :CODCON  AND ' +
                         '        ZER_ORIGEM = "Z"          ';
    qryCarga.ParamByName('CODCON').AsString := FLOG_CODCON;
    qryCarga.ExecSQL;

    {Req. 456948-B - B16. Faxina por data: o DELETE por ZER_CODCON acima so
     alcanca a propria rodada. Sem esta segunda limpeza BALZER cresce para
     sempre - medido na origem, 112.840 linhas em 6 rodadas. Depende do
     indice idx_balzer_dtacad em ZER_DTACAD (criado junto com a tabela
     neste requisito) - sem ele o DELETE varre a tabela inteira.

     O corte vem de fNow, nao de CURRENT_DATE do servidor: e um DELETE, e
     estacao com relogio adiantado apagaria linha dentro da janela.}
    qryCarga.SQL.Text := ' DELETE FROM BALZER WHERE ZER_DTACAD < :DTALIM ';
    qryCarga.ParamByName('DTALIM').AsDateTime := Int(fNow) - INT_DIAS_RETENCAO_BALZER;
    qryCarga.ExecSQL;

    sltVals.StrictDelimiter := True;

    {Todo item entra - so o UPDATE de CADLOT tem gate de localizacao.}
    For Item In ArrItens Do
    Begin
      sltVals.Add('(' + QuotedStr(VS_ConnectionID) + ',' +
                        QuotedStr(FLOG_CODCON)     + ',' +
                        QuotedStr('Z')             + ',' +   {Req. 456948-B - B3c}
                        QuotedStr(VS_strCodEmp)    + ',' +
                        QuotedStr(Item.FCodite)    + ',' +
                        QuotedStr(Item.FNumLot)    + ',' +
                        QuotedStr(Item.FLocFis)    + ',' +
                        strDta + ',' + strHra + ')');

      If sltVals.Count >= 500 Then
        pDescarrega;
    End;

    pDescarrega;
  Finally
    FreeAndNil(sltVals);
    FreeAndNil(qryCarga);
  End;
end;

function TfrmBalancoEstoqueGravar.fZeraItens(pgbProgresso: TcxProgressBar): Boolean;
const
  CHUNK_SIZE_BATCH = 1000;
var
  Item: TItemZera;
  ArrItemZera: TArrItemZera;
  lstCodites: TStringList;
  lstChunk: TStringList;
  strInList: String;
  intChunkInicio: Integer;
  intChunkFim: Integer;
begin
  Result := True;
  ArrItemZera := FItemZeraList.GetItems;

  If Length(ArrItemZera) = 0 Then
    Exit;

  {Req. 456948-B - B3. O fRetAutoIncrem(CONDET) que ficava aqui saiu: cada
   passada set-based reserva o seu proprio bloco, dimensionado pelo COUNT que
   ela mesma faz. Antes era um por linha, dentro do laco.}
  pCarregaBALZERZeramento;

  {****************************************************************************}
  {* FASE 0 - CONDET de nivel de item.                                        *}
  {*                                                                          *}
  {* TEM que rodar ANTES da Fase 1, que zera ITE_SALCON e ITE_DIGCON: o        *}
  {* registro guarda o valor anterior.                                        *}
  {*                                                                          *}
  {* Req. 456948-B - B2. Era um laco por item chamando pZeraItem, e cada       *}
  {* chamada fazia um SELECT SQL_NO_CACHE em ITEGER mais um INSERT ... SELECT  *}
  {* - 280 de cada numa rodada de 280 linhas, medido em 2026-08-20. Virou uma  *}
  {* passada dirigida por BALZER.                                              *}
  {****************************************************************************}
  frmgravando.lblGravando.Caption := 'Aguarde, registrando auditoria dos itens sem divergência (CONDET)...';
  pBombeiaSoRepaint;

  If Not TConDet.fGravaConDetZeraItensRodada(Self, VS_ConnectionID,
                                             FLOG_CODCON, VS_strCodEmp) Then
    Raise Exception.Create('Erro fZeraItens Fase 0');

  {****************************************************************************}
  {* FASE 1 - Operacoes em lote: substitui N round-trips individuais por      *}
  {* 3 SQLs unicos com IN(...), eliminando o gargalo principal em volumes      *}
  {* acima de 500 itens (UPDATE ITEGER, DELETE LOCCON, DELETE HISBAL).        *}
  {* fZeraContagemLote e fZeraContagemLocFis permanecem por item na Fase 2   *}
  {* pois nao possuem equivalente batch direto sem refatoracao de untCadLote. *}
  {****************************************************************************}
  lstCodites := TStringList.Create;
  Try
    lstCodites.Sorted     := True;
    lstCodites.Duplicates := dupIgnore;
    {Sem filtro: UPDATE de ITEGER/LOCCON/HISBAL valem para todo item. O
     gate de localizacao fica so no UPDATE de CADLOT.}
    For Item In ArrItemZera Do
      lstCodites.Add(Item.FCodite);

    If Assigned(pgbProgresso) Then
    Begin
      pgbProgresso.Properties.Max := lstCodites.Count;
      pgbProgresso.Position        := 0;
    End;
    frmgravando.lblGravando.Caption := 'Aguarde, zerando contagens em lote (ITEGER / LOCCON / HISBAL)...';
    pBombeiaSoRepaint;

    If lstCodites.Count > 0 Then
    Begin
      intChunkInicio := 0;
      While intChunkInicio < lstCodites.Count Do
      Begin
        lstChunk := TStringList.Create;
        Try
          intChunkFim := Min(intChunkInicio + CHUNK_SIZE_BATCH, lstCodites.Count);
          While intChunkInicio < intChunkFim Do
          Begin
            lstChunk.Add(lstCodites[intChunkInicio]);
            Inc(intChunkInicio);
          End;

          strInList := fCommaText(lstChunk, True);

          {zera contagem em ITEGER para o bloco atual}
          fExecutaSQL(
            'UPDATE ITEGER SET ITE_ORDCON=0, ITE_SALCON=0, ITE_GMLCON=0, ' +
            '  ITE_DIFSAL=0, ITE_DIF_ML=0, ITE_DIGCON="N" ' +
            'WHERE ITE_CODEMP=' + QuotedStr(VS_strCodEmp) +
            '  AND ITE_CODITE IN (' + strInList + ')', True);

          {remove localizacoes de contagem do bloco atual}
          fExecutaSQL(
            'DELETE FROM LOCCON WHERE ITE_CODEMP=' + QuotedStr(VS_strCodEmp) +
            ' AND ITE_CODITE IN (' + strInList + ')', True);

          {limpa historico de balanco do bloco atual - condicional CONEST=1 e CONACU=2}
          If THistoricoBalanco.fDeveGravarHistorico Then
            fExecutaSQL(
              'DELETE FROM HISBAL WHERE ITE_CODEMP=' + QuotedStr(VS_strCodEmp) +
              ' AND ITE_CODITE IN (' + strInList + ')', True);

          {avanca progresso apos cada chunk processado}
          If Assigned(pgbProgresso) Then
          Begin
            pgbProgresso.Position := intChunkInicio;
            pBombeiaSoRepaint;
          End;
        Finally
          FreeAndNil(lstChunk);
        End;
      End;
    End;
  Finally
    FreeAndNil(lstCodites);
  End;

  {****************************************************************************}
  {* FASE 2 - contagem de lote e de localizacao fisica.                       *}
  {*                                                                          *}
  {* Req. 456948-B - B3. Era um laco por item chamando pZeraItem, e cada       *}
  {* chamada custava: COUNT(1) nas temporarias, fRetAutoIncrem, SET @EMPFIS,   *}
  {* INSERT em CONDET, UPDATE conjugado de CADLOT com ITEGER (mais 3           *}
  {* statements de trigger por linha de ITEGER tocada) e o UPDATE de LOTLOC.   *}
  {* Medido em 2026-08-20, rodada de 280 linhas: 215 COUNT, 216 SET, 216       *}
  {* INSERT, 216 UPDATE e 216 toques em ITEGER.                               *}
  {*                                                                          *}
  {* A ordem entre 2a e 2b nao e negociavel: o CONDET guarda LOT_SALCON e      *}
  {* LOT_DIGCON de antes do zeramento.                                        *}
  {****************************************************************************}
  frmgravando.lblGravando.Caption := 'Aguarde, zerando contagens de lote e localização física...';
  pBombeiaSoRepaint;

  {2a - CONDET de lote, com os valores ainda por zerar}
  If Not TConDet.fGravaConDetZeraLotesRodada(Self, VS_ConnectionID,
                                             FLOG_CODCON, VS_strCodEmp) Then
    Raise Exception.Create('Erro fZeraItens Fase 2a');

  {2b - zera CADLOT e, quando houver, LOTLOC. Nao toca ITEGER: a Fase 1 ja
   gravou os mesmos campos (B4).}
  If Not objCadLot.fZeraContagemLoteRodada(VS_ConnectionID, FLOG_CODCON) Then
    Raise Exception.Create('Erro fZeraItens Fase 2b');
End;

{Req. 456948-B - B1. Era varredura linear sobre o array. E chamada uma vez
 por linha no laco de divergencias, uma por linha em
 pSeparaItensSemNecessidadeCalc e uma por linha em
 pAjustaITEGERSemContagemNaCADLOT - com a lista crescendo, dava O(n^2).}
function TItemZeraList.Contains(const ACodite, ANumLot,
  ALocFis: string): Boolean;
begin
  Result := FIndice.ContainsKey(fChave(ACodite, ANumLot, ALocFis));
end;

constructor TItemZeraList.Create;
begin
  FIndice := TDictionary<String, Integer>.Create;   {Req. 456948-B}
  FQtd    := 0;
  SetLength(FItems, 0); // Inicializa o array vazio
end;

destructor TItemZeraList.Destroy;
begin
  FreeAndNil(FIndice);   {Req. 456948-B}
  // Aqui você pode liberar recursos se necessário
  inherited;
end;

{Req. 456948-B - B1. Cresce dobrando a capacidade em vez de +1 por insercao:
 19.768 insercoes davam 19.768 realocacoes do array inteiro.}
procedure TItemZeraList.AddItem(const AItem: TItemZera);
  Var
    strChave: String;
begin
  strChave := fChave(AItem.FCodite, AItem.FNumLot, AItem.FLocFis);

  If FIndice.ContainsKey(strChave) Then
    Exit;

  If FQtd = Length(FItems) Then
  Begin
    If FQtd = 0 Then
      SetLength(FItems, 256)
    Else
      SetLength(FItems, FQtd * 2);
  End;

  FItems[FQtd] := AItem;
  FIndice.Add(strChave, FQtd);
  Inc(FQtd);
end;

{Req. 456948-B - B1. Devolve so a parte usada: Length(FItems) agora e a
 capacidade, nao a quantidade. Quem chama faz Length() no resultado, entao
 devolver o array inteiro traria posicoes vazias.}
function TItemZeraList.GetItems: TArrItemZera;
begin
  Result := Copy(FItems, 0, FQtd);
end;

end.

