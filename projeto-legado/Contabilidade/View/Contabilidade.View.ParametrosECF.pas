unit Contabilidade.View.ParametrosECF;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Contabilidade.View.TfrmPaiContabilidade, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Contabilidade.Interfaces, EditFocus, Vcl.Mask,
  MaskEditFocus, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, cxGridBandedTableView, cxGridDBBandedTableView,
  cxCurrencyEdit, untTypesSistema, MemDS, DBAccess, Uni, cxButtonEdit,
  cxProgressBar, cxTextEdit, System.ImageList, Vcl.ImgList,
  cxImageList, UniClientDataSet, cxTL, cxTLdxBarBuiltInMenu, cxInplaceContainer,
  cxTLData, cxDBTL, cxCheckBox, cxMemo, dxBarBuiltInMenu, cxGridCustomPopupMenu,
  cxGridPopupMenu;

const
  FIELDFORMULA = 'FORMULA' ;
  REGISTROGRAVASALDOINICIAL = 'L100';

type
  TTipoRegistroECF = (treReferencial, treDemonstrativo) ;

  TfrmParametrosECF = class(TfrmPaiContabilidade)
    pnlFiltro: TPanel;
    edtNomEmp: TEditFocus;
    edtCodEmp: TEditFocus;
    lblCodEmp: TLabel;
    btnCarrTitulos: TBitBtnLocked;
    Label2: TLabel;
    mskPeriodoIni: TMaskEditFocus;
    mskPeriodoFin: TMaskEditFocus;
    pnlDados: TPanel;
    GridLevel: TcxGridLevel;
    Grid: TcxGridCitel;
    FDMemDados: TFDMemTable;
    dsDados: TDataSource;
    GridTab: TcxGridDBBandedTableViewCitel;
    pnlBotoesECF: TPanel;
    btnCfmECF: TBitBtnLocked;
    btnCncECF: TBitBtnLocked;
    cxImageList: TcxImageList;
    StyleRepository: TcxStyleRepository;
    EstiloSintetico: TcxStyle;
    pnlCadEmpGrupo: TPanel;
    TreeEmpCad: TcxTreeList;
    TreeEmpCadNome: TcxTreeListColumn;
    TreeEmpCadSel: TcxTreeListColumn;
    GridPopupMenu: TcxGridPopupMenu;
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnCarrTitulosClick(Sender: TObject);
    procedure GridTabEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnCfmECFClick(Sender: TObject);
    procedure btnCncECFClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure GridTabFocusedItemChanged(Sender: TcxCustomGridTableView;
      APrevFocusedItem, AFocusedItem: TcxCustomGridTableItem);
    procedure GridTabEditing(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; var AAllow: Boolean);
    procedure FDMemDadosAfterPost(DataSet: TDataSet);
    procedure GridTabStylesGetContentStyle(Sender: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
      var AStyle: TcxStyle);
    procedure TreeEmpCadSelPropertiesEditValueChanged(Sender: TObject);
  private
    FTipoRegistroECF : TTipoRegistroECF ;
    FvrtValorAnoAntigo : Variant ;
    FvrtValorSaldoInicialAntigo : Variant ;
    FarrVrtValorMesAntigo : array[0..11] of Variant ;
    FarrVrtValorSaldoInicialAntigo : array[0..11] of Variant ;
    FImageVerFormula : TBitmap ;
    FImageCalcularFormula : TBitmap ;
    FIdParametrosECF: Integer ;
    FRegistroECF: string ;
    FBlcEcf: string ;
    FRegEcf: string ;
    qryEcfLan: TUniQuery ;
    qryEcfMes: TUniQuery ;
    qryEcfCta: TUniQuery ;
    qryEcfLanExec: TUniQuery ;
    qryEcfMesExec: TUniQuery ;
    qryEcfCtaExec: TUniQuery ;
    qryEcfSldExec: TUniQuery ;
    cdsEcfCalculoAutomatico: TUniClientDataSet ;
    qryEcfVerificaCta: TUniQuery ;
    cdsPlacoPlanre: TUniClientDataSet;
    cdsCadEmpGrupo: TUniClientDataSet;
    cdsEcfCnf: TUniClientDataSet;
    function fDataInicial: TDate;
    function fDataFinal: TDate;
    function fValidaDatas: Boolean;
    procedure pCriaEstruturaTempDataset;
    procedure pCriaColunasGrid;
    procedure pSetCurColunaGridMes(colGrid : TcxGridDBBandedColumn);
    procedure pSetCurColunaGrid(colGrid : TcxGridDBBandedColumn);
    procedure pSetBtnColunaGrid(colGrid : TcxGridDBBandedColumn);
    procedure pSetMemoColunaGrid(colGrid : TcxGridDBBandedColumn);
    procedure pSetTextColunaGrid(colGrid : TcxGridDBBandedColumn);
    function fMontaStringFormula(arrSel : TConsultasArray; const strCodPlanre:string):string; overload ;
    function fMontaStringFormula(strSeqLan : string; const strCodPlanre:string):string; overload ;
    procedure pIniciaECF(blnHabilitar:boolean=True) ;
    function fIsGrupoStringFormula(const blnCodPlanre, blnNotEof : boolean):boolean ;
    function fIniciadoECF:boolean ;
    function fContMesColGrid:integer ;
    procedure pCarregaEcfLan(const strCodEmp:string) ;
    procedure pCarregaEcfMes(const strCodEmp:string) ;
    procedure pCarregaEcfCta(const strCodEmp:string) ;
    procedure pCarregaEcfFDMem ;
    procedure pCarregaPlanco ;
    function fFiltroCarregaPlancoDemonstrativo:string ;
    procedure pCarregaEcfCnf ;
    function fGravaEcfCnf:boolean ;
    procedure pCarregaCadEmpGrupo(const strCodEmpMatriz:string) ;
    function fRetornaAnoECF:integer ;
    function fRetornaRegistroECF:string ;
    function fCarregaDadosEcf:boolean ;
    procedure pAjustaValorFormula ;
    procedure pAjustaValorMeses ;
    function fFormulaToList(strFormula:string):TStringList ;
    procedure pLimpaTodosMeses(const blnEmEdicao:boolean=False) ;
    procedure pSetValorMesesFdMem(strFormula:string) ;
    procedure pTotalizaAnoRefGrid(ColAno, ColSaldoInicial, ColSaldoFinal: TcxCustomGridTableItem; const blnEmEdicao:boolean=False) ;
    procedure pTotalizaAno ;
    procedure pCarregaECFCtaExercicio ;
    function fVerificaECFCtaExercicio(arrSel: TConsultasArray):TConsultasArray ;
    procedure pVerificaECFCtaExercicioGrid(var arrSel: TConsultasArray; var strMensagem:string) ;
    procedure pCarregaInfoParametrosECF ;
    function fEhAgrupamento(strValor1, strValor2: string; blnEof:boolean):boolean ;
    procedure pLimpaCadEmpGrupo ;
    function fExecutarGeracao: boolean ;
    function fConfirmarECF(pgbProgresso: TcxProgressBar): Boolean;
    procedure pSetaTextoProgresso(pgbProgresso: TcxProgressBar;
      strTexto: String);
    procedure pGravaLancamentos(pgbProgresso: TcxProgressBar);
    procedure pApagaLancamentos;

    function fInsertECFLan(strCodRef, strCodEmp, strTipEcf, strFmtEcf:string; intAnoEcf:Integer; strRegistro:string; const strAutoIncLan:string):string;
    procedure pInsertECFMes(strSeqLan: string; intMesEcf:integer; fltVlrecf: Double; strCodEmp:string; var strAutoInc:string);
    procedure pInsertECFCta(strSeqLan: string; strCodCon:string; strCodEmp:string; var strAutoInc:string);
    procedure pInsertEcfSld(const strCodRef, strCodEmp:string; const intAnoEcf:Integer; const strRegistro:string; const strAutoIncSld:string; const fltSldini:double);
    function fGetSqlInsertECFLan:string;
    function fGetSqlInsertECFMes:string;
    function fGetSqlInsertECFCta:string;
    function fGetSqlInsertECFCnf:string;

    procedure pExtraiCtaFormulaParaDataSet(strSeqLan, strCodEmp, strFormula:String; var strAutoInc:string) ;
    function fCountCtaFormulaManual:Integer ;
    procedure pExtraiValorMesesParaDataSet(strSeqLan, strCodEmp:String;var strAutoInc:string) ;
    function fTemMovimento: boolean;

    procedure pCalculoAutomaticoFormula(strFormulas:string; blnUnicaLinha:boolean=False) ;
    function fFiltroCalculoAutomaticoFormula: string ;
    procedure pCalculoAutomatico(blnUnicaLinha:boolean=False) ;
    function fRetornoSqlCalculoValorFromFormula(const strFormulas, strCodEmp: string):string ;

    procedure pEventoShowContasPlanoReferencial(Sender: TObject; AButtonIndex: Integer) ;
    procedure pEventoCalculoAnoManual(Sender: TObject) ;

    function fConcatStringEcf(strOriginal, strValor:string):string ;
    procedure pMensagemVerificaCtaExercicio(strMensagem: string) ;
    function fIsAssignedProgresso(pgbProgresso: TcxProgressBar):boolean ;
    function fValidaInfoGridFormula(intColFormula:integer; var varFormula:variant; recRecord:TcxCustomGridRecord; blnPulaRecord:boolean):boolean ;
    function fConfirmaSobreEscreverFormula:boolean ;
    function fRetornaColbyFieldName(Sender: TcxCustomGridTableView;
      FieldName: String): TcxCustomGridTableItem;

    procedure pSomaValorSinteticoPeloAnalitico(const blnModoTotal:boolean);
    procedure pLimpaValorSintetico ;
    procedure pBuscaLinhaAnalitica;
    procedure pGuardaValorAntigoAnoMeses;
    procedure pSubtraiValorSinteticoPeloValorAnterior(const intId:integer) ;
    procedure pCarregaTreeEmpCad ;
    function fRetornaEmpCadSelecionada:string ;
    procedure pZeraMesesComFormula ;
    function fTrataValorNuloNumeric(const vrtValor:variant):double ;
    function fValorDiferenteZero(const fltValor1, fltValor2:double):boolean ;
    function fColunasGridAssigned(ColAno, ColSaldoInicial, ColSaldoFinal: TcxCustomGridTableItem):boolean ;

    function fGetSqlCarregaEcfLan:string ;
    function fGetSqlCarregaEcfMes:string ;
    function fGetSqlCarregaEcfCta:string ;
    function fIsModoPlanoReferencial:boolean ;

    function fGetSqlInsertEcfSld:string;
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    property IdParametrosECF : Integer read FIdParametrosECF write FIdParametrosECF ;
  end;

implementation

uses
  untConsultas, untFuncoesSimples, strUtils, dateUtils, Contabilidade.Consultas,
  System.JSON, Contabilidade.View.ContasContabeisPorPlanoReferencial;

{$R *.dfm}


procedure TfrmParametrosECF.btnCarrTitulosClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos Then
    Exit;

  if not fValidaDatas then
    Exit;

  if fCarregaDadosEcf then
  begin
    ////carrega as empresas do grupo
    pCarregaEcfCnf ;
    pCarregaCadEmpGrupo(edtCodEmp.Text) ;
    pCarregaTreeEmpCad ;
    pCarregaPlanco ;

    pCriaEstruturaTempDataset ;
    pCriaColunasGrid ;
    pCarregaEcfFDMem ;
    ////ajusta valores da formula
    pAjustaValorFormula ;
    ////ajusta valores dos meses
    pAjustaValorMeses ;
    ///calcula Mês a Mês quando Formula
    pCalculoAutomatico ;
    ////totaliza o ano
    pTotalizaAno ;
    ////caso seja lançamento tipo plano de contas somar os valores na hierarquia
    pSomaValorSinteticoPeloAnalitico(True) ;
    ////inicia sempre no primeiro registro.
    FDMemDados.First ;
    pIniciaECF ;
  end;

end;

procedure TfrmParametrosECF.btnCfmECFClick(Sender: TObject);
var
  strRegistro : string ;
begin
  inherited;

  if fTemMovimento then
  begin
    if fMensagem('ATENÇÃO!', 'Já existe dados gerados no período informado. ' + #13#10 +
                          'Confirma a exclusão e nova geração ? ' + #13#10 + #13#10 +
                          'Caso os dados já tenham sido integrados com outro' + #13#10 +
                          'sistema, esse processo deverá ser refeito!', ['&Sim', '&Não'], 1) = 2 then
    begin
      Exit;
    end;
  end;

  strRegistro := fRetornaRegistroECF ;
  If Not fLock_Unlock('ECFLAN_'+strRegistro, True, False) Then
  Begin
    fMensagem('ATENÇÃO!', 'A rotina "Parametros ECF - ' + strRegistro +
                          '" já está sendo utilizada por outra estação: ' +
                          fGetHostLock('ECFLAN_'+strRegistro), ['&Ok']);
    Exit;
  End
  Else
  Begin
    Try
      fExecutarGeracao ;
    Finally
      fLock_Unlock('ECFLAN_'+strRegistro, False);
    End;
  End;

  pLimpaCadEmpGrupo ;
  pIniciaECF(False) ;
  fMensagem('ATENÇÃO!', 'Concluído!' , ['&Ok']);
  pSetFocus(edtCodEmp);
end;

procedure TfrmParametrosECF.btnCncECFClick(Sender: TObject);
begin
  inherited;
  pLimpaCadEmpGrupo ;
  pIniciaECF(False) ;
  pSetFocus(edtCodEmp);
end;

procedure TfrmParametrosECF.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
Var
  arrEmp: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmParametrosECF.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if fIniciadoECF then
  begin
    fMensagem('ATENÇÃO!', 'Confirmar ou Cancelar, antes de fechar o módulo!', ['&Ok']);
    CanClose := False ;
  end;
end;

procedure TfrmParametrosECF.FormCreate(Sender: TObject);
begin
  inherited;
  edtCodEmp.Text := VS_strCodEmp;
  edtNomEmp.Text := fRetNomeEmpresa;

  qryEcfLan := fCriaQuery(Self) ;
  qryEcfMes := fCriaQuery(Self) ;
  qryEcfCta := fCriaQuery(Self) ;
  qryEcfLanExec := fCriaQuery(Self) ;
  qryEcfMesExec := fCriaQuery(Self) ;
  qryEcfCtaExec := fCriaQuery(Self) ;
  qryEcfVerificaCta := fCriaQuery(Self) ;
  qryEcfSldExec := fCriaQuery(Self) ;

  FImageVerFormula := TBitmap.Create ;
  FImageCalcularFormula := TBitmap.Create ;

end;

procedure TfrmParametrosECF.FormDestroy(Sender: TObject);
begin
  inherited;
  qryEcfLan.Close ;
  FreeAndNil(qryEcfLan) ;

  qryEcfMes.Close ;
  FreeAndNil(qryEcfMes) ;

  qryEcfCta.Close ;
  FreeAndNil(qryEcfCta) ;

  qryEcfLanExec.Close ;
  FreeAndNil(qryEcfLanExec) ;

  qryEcfMesExec.Close ;
  FreeAndNil(qryEcfMesExec) ;

  qryEcfCtaExec.Close ;
  FreeAndNil(qryEcfCtaExec) ;

  qryEcfSldExec.Close ;
  FreeAndNil(qryEcfSldExec) ;

  qryEcfVerificaCta.Close ;
  FreeAndNil(qryEcfVerificaCta) ;

  FreeAndNil(FImageVerFormula) ;
  FreeAndNil(FImageCalcularFormula) ;

end;

procedure TfrmParametrosECF.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaInfoParametrosECF ;
  pIniciaECF(False) ;
end;

function TfrmParametrosECF.fRetornaAnoECF: integer;
var
  dtIni : TDateTime ;
begin
  dtIni := fDataInicial ;
  result := YearOf(dtIni) ;
end;

function TfrmParametrosECF.fRetornaRegistroECF: string;
begin
  result := FRegistroECF ;
end;

function TfrmParametrosECF.fRetornoSqlCalculoValorFromFormula(const strFormulas,
  strCodEmp: string): string;
var
  strSql : string ;
begin
  if copy(FRegistroECF,1,1) = 'M' then
  begin
    strSql := '' ;
    strSql := strSql + '   SELECT CON_CONCRE AS BAL_CODCON, CON_DTALAN AS MES_DTAMOV, SUM(IF(C_D="C",BAL_SALFIN*-1, BAL_SALFIN)) AS BAL_SALFIN, SALDO_FINAL, SALDO_INICIAL FROM ( ' ;
    strSql := strSql + '   SELECT CON_CONCRE, EXTRACT(MONTH FROM CON_DTALAN) AS CON_DTALAN, SUM(CON_VALLAN) AS BAL_SALFIN, 0.00 AS SALDO_FINAL, 0.00 AS SALDO_INICIAL, "C" AS C_D ' ;
    strSql := strSql + '   FROM LANCON ' ;
    strSql := strSql + '   WHERE CON_CONCRE IN ('+strFormulas+') ' ;
    strSql := strSql + '         AND CON_DTALAN BETWEEN :DATAINI AND :DATAFIN ' ;
    strSql := strSql + '         AND CON_TIPLAN <> "FEC" ' ;
    strSql := strSql + '         AND CON_EMPLAN IN ('+strCodEmp+') ' ;
    strSql := strSql + '   GROUP BY CON_CONCRE, EXTRACT(MONTH FROM CON_DTALAN) ' ;
    strSql := strSql + '   UNION ALL ' ;
    strSql := strSql + '   SELECT CON_CONDEB AS CON_CONCRE, EXTRACT(MONTH FROM CON_DTALAN) AS CON_DTALAN, SUM(CON_VALLAN) AS BAL_SALFIN, 0.00 AS SALDO_FINAL, 0.00 AS SALDO_INICIAL, "D" AS C_D ' ;
    strSql := strSql + '   FROM LANCON ' ;
    strSql := strSql + '   WHERE CON_CONDEB IN ('+strFormulas+') ' ;
    strSql := strSql + '         AND CON_DTALAN BETWEEN :DATAINI AND :DATAFIN ' ;
    strSql := strSql + '         AND CON_TIPLAN <> "FEC" ' ;
    strSql := strSql + '         AND CON_EMPLAN IN ('+strCodEmp+') ' ;
    strSql := strSql + '   GROUP BY CON_CONDEB, EXTRACT(MONTH FROM CON_DTALAN) ' ;
    strSql := strSql + '   ) AS SEL ' ;
    strSql := strSql + '   GROUP BY CON_CONCRE, CON_DTALAN, SALDO_FINAL, SALDO_INICIAL ' ;
  end
  else //// demais registros
  begin
    strSql := '' ;
    strSql := strSql + '  ( ' ;
    strSql := strSql + '   SELECT BAL_CODCON, EXTRACT(MONTH FROM BAL_DTAMOV) AS MES_DTAMOV, ' ;
    strSql := strSql + '   SUM(COALESCE(CASE WHEN BAL_CRDEFI = "D" THEN BAL_SALFIN ELSE -BAL_SALFIN END,0.00)-COALESCE(CASE WHEN BAL_CRDEAN = "D" THEN BAL_SALANT ELSE -BAL_SALANT END,0.00)) AS BAL_SALFIN, ' ;
    strSql := strSql + '   SUM(COALESCE(IF(EXTRACT(MONTH FROM BAL_DTAMOV)=1,CASE WHEN BAL_CRDEAN = "D" THEN BAL_SALANT ELSE -BAL_SALANT END,0.00),0.00)) AS SALDO_INICIAL, ' ;
    strSql := strSql + '   SUM(COALESCE(IF(EXTRACT(MONTH FROM BAL_DTAMOV)=12,CASE WHEN BAL_CRDEFI = "D" THEN BAL_SALFIN ELSE -BAL_SALFIN END,0.00),0.00)) AS SALDO_FINAL FROM LANBAL' ;
    strSql := strSql + '   WHERE BAL_DTAMOV BETWEEN :DATAINI AND :DATAFIN ' ;
    strSql := strSql + '         AND BAL_CODEMP IN ('+strCodEmp+') ' ;
    strSql := strSql + '         AND BAL_CODCON IN ('+strFormulas+') ' ;
    strSql := strSql + '   GROUP BY BAL_CODCON, EXTRACT(MONTH FROM BAL_DTAMOV) ' ;
    strSql := strSql + '  ) ' ;
    strSql := strSql + '   UNION ALL ' ;
    strSql := strSql + '  ( ' ;
    strSql := strSql + '   SELECT CON_CONCRE AS BAL_CODCON, CON_DTALAN AS MES_DTAMOV, SUM(IF(C_D="C",BAL_SALFIN*-1, BAL_SALFIN)) AS BAL_SALFIN, SALDO_FINAL, SALDO_INICIAL FROM ( ' ;
    strSql := strSql + '   SELECT CON_CONCRE, EXTRACT(MONTH FROM CON_DTALAN) AS CON_DTALAN, SUM(CON_VALLAN) AS BAL_SALFIN, 0.00 AS SALDO_FINAL, 0.00 AS SALDO_INICIAL, "C" AS C_D ' ;
    strSql := strSql + '   FROM LANCON ' ;
    strSql := strSql + '   WHERE '+ fFiltroCalculoAutomaticoFormula +' CON_CONCRE IN ('+strFormulas+') ' ;
    strSql := strSql + '         AND LEFT(CON_CONCRE,1) <> "1" ' ;
    strSql := strSql + '         AND LEFT(CON_CONCRE,1) <> "2" ' ;
    strSql := strSql + '         AND CON_DTALAN BETWEEN :DATAINI AND :DATAFIN ' ;
    strSql := strSql + '         AND CON_TIPLAN <> "FEC" ' ;
    strSql := strSql + '         AND CON_EMPLAN IN ('+strCodEmp+') ' ;
    strSql := strSql + '   GROUP BY CON_CONCRE, EXTRACT(MONTH FROM CON_DTALAN) ' ;
    strSql := strSql + '   UNION ALL ' ;
    strSql := strSql + '   SELECT CON_CONDEB AS CON_CONCRE, EXTRACT(MONTH FROM CON_DTALAN) AS CON_DTALAN, SUM(CON_VALLAN) AS BAL_SALFIN, 0.00 AS SALDO_FINAL, 0.00 AS SALDO_INICIAL, "D" AS C_D ' ;
    strSql := strSql + '   FROM LANCON ' ;
    strSql := strSql + '   WHERE '+ fFiltroCalculoAutomaticoFormula +' CON_CONDEB IN ('+strFormulas+') ' ;
    strSql := strSql + '         AND LEFT(CON_CONDEB,1) <> "1" ' ;
    strSql := strSql + '         AND LEFT(CON_CONDEB,1) <> "2" ' ;
    strSql := strSql + '         AND CON_DTALAN BETWEEN :DATAINI AND :DATAFIN ' ;
    strSql := strSql + '         AND CON_TIPLAN <> "FEC" ' ;
    strSql := strSql + '         AND CON_EMPLAN IN ('+strCodEmp+') ' ;
    strSql := strSql + '   GROUP BY CON_CONDEB, EXTRACT(MONTH FROM CON_DTALAN) ' ;
    strSql := strSql + '   ) AS SEL ' ;
    strSql := strSql + '   GROUP BY CON_CONCRE, CON_DTALAN, SALDO_FINAL, SALDO_INICIAL ' ;
    strSql := strSql + '  ) ' ;
  end;
  result := strSql ;
end;

function TfrmParametrosECF.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodEmp) Then
    Begin
      If (Not fEmptyStr(edtCodEmp.Text)) Then
      Begin
        edtNomEmp.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtCodEmp.Text], False);
        If (fEmptyStr(edtNomEmp.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End
      Else
        edtNomEmp.Clear;
    End ;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmParametrosECF.fValidaDatas: Boolean;
var
  dtIni, dtFin : TDateTime ;
begin
  result := false ;
  If fEmptyStr(mskPeriodoIni.Text, True) Then
  Begin
    fMensagem('ATENÇÃO!', 'Obrigatório preenchimento do período!', ['&OK']);
    pSetFocus(mskPeriodoIni);
    Exit;
  End;

  If fEmptyStr(mskPeriodoFin.Text, True) Then
  Begin
    fMensagem('ATENÇÃO!', 'Obrigatório preenchimento do período!', ['&OK']);
    pSetFocus(mskPeriodoFin);
    Exit;
  End;

  dtIni := fDataInicial ;
  dtFin := fDataFinal ;

  if dtIni > dtFin then
  begin
    fMensagem('ATENÇÃO!', 'Data inicial maior que a data final!', ['&OK']);
    pSetFocus(mskPeriodoIni);
    Exit;
  end;

  if YearOf(dtIni) <> YearOf(dtFin) then
  begin
    fMensagem('ATENÇÃO!', 'O período deve contemplar o mesmo ano!', ['&OK']);
    pSetFocus(mskPeriodoIni);
    Exit;
  end;

  result := true ;
end;

function TfrmParametrosECF.fValidaInfoGridFormula(intColFormula: integer;
  var varFormula: variant; recRecord: TcxCustomGridRecord; blnPulaRecord:boolean): boolean;
begin
  result := False ;
  if not recRecord.HasCells then
    exit ;

  varFormula := recRecord.Values[intColFormula] ;
  if VarIsNull(varFormula) then
    exit ;

  ////pula o registro selecionado
  if blnPulaRecord then
    exit ;

  result := True ;
end;

function TfrmParametrosECF.fValorDiferenteZero(const fltValor1,
  fltValor2: double): boolean;
begin
  result := True ;
  if fltValor1 <> 0.00 then
  begin
    exit ;
  end;
  if fltValor2 <> 0.00 then
  begin
    exit ;
  end;
  result := False ;
end;

function TfrmParametrosECF.fVerificaECFCtaExercicio(
  arrSel: TConsultasArray): TConsultasArray;
var
  intCnt : integer ;
  auxRetorno : TConsultasArray ;
  strMensagem : string ;
begin
  SetLength(auxRetorno, 0) ;
  SetLength(result, 0) ;
  strMensagem := '' ;
  ////verifica no banco de dados
  qryEcfVerificaCta.DisableControls ;
  try
    for intCnt := Low(arrSel) to High(arrSel) do
    begin
      if qryEcfVerificaCta.Locate('CTA_CODCON', arrSel[intCnt].strCodigo, [loCaseInsensitive]) then
      begin
        strMensagem := fConcatStringEcf(strMensagem, qryEcfVerificaCta.FieldByName('CTA_CODCON').AsString + ' - ' + qryEcfVerificaCta.FieldByName('ECF_REGIST').AsString) ;
      end
      else
      begin
        SetLength(auxRetorno, Length(auxRetorno)+1);
        auxRetorno[High(auxRetorno)].strCodigo := arrSel[intCnt].strCodigo ;
        auxRetorno[High(auxRetorno)].strDescri := arrSel[intCnt].strDescri ;
      end;
    end;
  finally
    qryEcfVerificaCta.EnableControls ;
  end;

  pVerificaECFCtaExercicioGrid(auxRetorno, strMensagem) ;

  pMensagemVerificaCtaExercicio(strMensagem) ;

  SetLength(arrSel, 0);
  /////retorna as linha que tenham strCodigo
  for intCnt := Low(auxRetorno) to High(auxRetorno) do
  begin
    if fEmptyStr(auxRetorno[intCnt].strCodigo) then
    begin
      Continue ;
    end;
    SetLength(result, Length(result)+1);
    result[High(result)].strCodigo := auxRetorno[intCnt].strCodigo ;
    result[High(result)].strDescri := auxRetorno[intCnt].strDescri ;
  end;
  SetLength(auxRetorno, 0) ;
end;

procedure TfrmParametrosECF.pVerificaECFCtaExercicioGrid(
  var arrSel: TConsultasArray; var strMensagem:string);
var
  intCnt1, intCnt2 : integer ;
  intColFormula : integer ;
  ColFormula : TcxCustomGridTableItem ;
  varFormula : variant ;
  intFocusedRec : integer ;
begin
  ColFormula := fRetornaColbyFieldName(Gridtab, FIELDFORMULA) ;
  if not Assigned(ColFormula) then
    exit ;

  intFocusedRec := GridTab.Controller.FocusedRecordIndex ;
  intColFormula := TcxGridDBBandedColumn(ColFormula).Index ;
  for intCnt1 := 0 to GridTab.ViewData.RecordCount-1 do
  begin
    if not fValidaInfoGridFormula(intColFormula, varFormula, GridTab.ViewData.Records[intCnt1], intFocusedRec = intCnt1) then
      continue ;

    for intCnt2 := Low(arrSel) to High(arrSel) do
    begin
      ///ignora sem strCodigo
      if fEmptyStr(arrSel[intCnt2].strCodigo) then
      begin
        Continue ;
      end;

      if Pos(arrSel[intCnt2].strCodigo, vartostr(varFormula)) > 0 then
      begin
        strMensagem := fConcatStringEcf(strMensagem, arrSel[intCnt2].strCodigo + ' - ' + fRetornaRegistroECF) ;
        ////remove do retorno
        arrSel[intCnt2].strCodigo := '' ;
      end;
    end;

  end;

end;

procedure TfrmParametrosECF.pZeraMesesComFormula;
var
  intMes : integer ;
  strAuxFormula : string ;
begin
  FDMemDados.DisableControls ;
  cdsEcfCalculoAutomatico.DisableControls ;
  FDMemDados.AfterPost := nil ;
  try
    FDMemDados.First ;
    while not FDMemDados.Eof do
    begin
      strAuxFormula := FDMemDados.FieldByName(FIELDFORMULA).AsString ;
      if fEmptyStr(strAuxFormula) then
      begin
        FDMemDados.Next ;
        Continue ;
      end;
      FDMemDados.Edit ;
      for intMes := 1 to 12 do
      begin
        FDMemDados.FieldByName('MES_'+inttostr(intMes)).Clear  ;
      end;
      FDMemDados.Post ;
      FDMemDados.Next ;
    end;
  finally
    FDMemDados.EnableControls ;
    cdsEcfCalculoAutomatico.EnableControls ;
    FDMemDados.AfterPost := FDMemDadosAfterPost ;
  end;
end;

procedure TfrmParametrosECF.TreeEmpCadSelPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  TreeEmpCad.Post ;
  ////recalcula os valores
  Screen.Cursor := crSQLWait ;
  try
    ///zera os meses com formula
    pZeraMesesComFormula ;
    ///calcula Mês a Mês quando Formula
    pCalculoAutomatico ;
    ////totaliza o ano
    pTotalizaAno ;
    ////caso seja lançamento tipo plano de contas somar os valores na hierarquia
    pSomaValorSinteticoPeloAnalitico(True) ;
  finally
    Screen.Cursor := crDefault ;
  end;
end;

procedure TfrmParametrosECF.GridTabEditing(Sender: TcxCustomGridTableView;
  AItem: TcxCustomGridTableItem; var AAllow: Boolean);
var
  ColFormula, ColTipo, ColFormato, ColBotoes : TcxCustomGridTableItem ;
  ColTipCta : TcxCustomGridTableItem ;
begin
  inherited;
  ColFormula := fRetornaColbyFieldName(Sender, FIELDFORMULA) ;
  ColBotoes := fRetornaColbyFieldName(Sender, 'BOTOES') ;
  if Assigned(ColBotoes) then
    if AItem = ColBotoes then
      exit ;

  ColTipo := fRetornaColbyFieldName(Sender, 'ECF_TIPECF') ;
  if Assigned(ColTipo) then
    if AItem = ColTipo then
      exit ;

  ColFormato := fRetornaColbyFieldName(Sender, 'ECF_FMTECF') ;
  if Assigned(ColFormato) then
    if AItem = ColFormato then
      exit ;

  if Assigned(ColFormula) then
  begin
    if AItem <> ColFormula then
    begin
      AAllow := fEmptyStr(TcxGridDBBandedColumn(ColFormula).DataBinding.Field.AsString) ;
    end;
  end;

  ColTipCta := fRetornaColbyFieldName(Sender, 'NRE_TIPCTA') ;
  if Assigned(ColTipCta) then
  begin
    if not fEmptyStr(TcxGridDBBandedColumn(ColTipCta).DataBinding.Field.AsString) then
    begin
      if TcxGridDBBandedColumn(ColTipCta).DataBinding.Field.AsString = 'S' then
      begin
        AAllow := False ;
      end;
    end;
  end;

end;

procedure TfrmParametrosECF.GridTabEditKeyPress(Sender: TcxCustomGridTableView;
  AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
var
  ColFormula, ColAno, ColSaldoInicial, ColSaldoFinal : TcxCustomGridTableItem ;
  arrSel : TConsultasArray;
  strFormula : string ;
begin
  inherited;
  ColAno := fRetornaColbyFieldName(Sender, 'ANO') ;
  ColSaldoInicial := fRetornaColbyFieldName(Sender, 'SALDO_INICIAL') ;
  ColSaldoFinal := fRetornaColbyFieldName(Sender, 'SALDO_FINAL') ;
  ColFormula := fRetornaColbyFieldName(Sender, FIELDFORMULA) ;
  if Assigned(ColFormula) then
  begin
    if AItem = ColFormula then
    begin
      if key = '/' then
      begin
        if not fConfirmaSobreEscreverFormula then
        begin
          key := #0 ;
          Exit;
        end;

        If fPesqPlanoContabilEcf(Self, Nil, Nil, Nil, Key, arrSel, False, '', fIsModoPlanoReferencial) Then
        Begin
          key := #0 ;
          pCarregaECFCtaExercicio ;
          arrSel := fVerificaECFCtaExercicio(arrSel) ;
          strFormula := fMontaStringFormula(arrSel, FDMemDados.FieldByName('NRE_CODREF').AsString) ;
          TcxGridDBBandedTableViewCitel(Sender).DataController.DataSet.Edit ;
          TcxGridDBBandedColumn(ColFormula).DataBinding.Field.AsString := strFormula ;
          ///limpa todas colunas
          pGuardaValorAntigoAnoMeses ;
          pLimpaTodosMeses(True) ;
          /////recalcula os valores dos meses
          if not fEmptyStr(strFormula) then
          begin
            pCalculoAutomatico(True) ;
            pTotalizaAnoRefGrid(ColAno, ColSaldoInicial, ColSaldoFinal, True) ;
          end;
        End;
      end
      else
      begin
        key := #0 ;
      end;
    end;
  end;
end;

procedure TfrmParametrosECF.GridTabFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
var
  ColFormula : TcxCustomGridTableItem ;
begin
  inherited;
  ColFormula := fRetornaColbyFieldName(Sender, FIELDFORMULA) ;
  if Assigned(ColFormula) then
  begin
    if AFocusedItem = ColFormula then
    begin
      pnlInfo.Caption := 'Tecle / para adicionar contas na fórmula!' ;
    end
    else
    begin
      pnlInfo.Caption := '' ;
    end;
  end;
end;

procedure TfrmParametrosECF.GridTabStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
Var
  ARowInfo: TcxRowInfo;
begin
  inherited;
  If ARecord.IsData Then
  begin
    if ARecord.Index > -1 then
    begin
      ARowInfo := GridTab.DataController.GetRowInfo(ARecord.Index);
      If VarToStr(GridTab.DataController.Values[ARowInfo.RecordIndex,
                         GridTab.GetColumnByFieldName('NRE_TIPCTA').Index]) = 'S' Then
      Begin
        AStyle := EstiloSintetico;
      End;
    end;
  end;
end;

procedure TfrmParametrosECF.pAjustaValorFormula;
var
  strFormula : string ;
begin
  qryEcfCta.DisableControls ;
  FDMemDados.DisableControls ;
  FDMemDados.AfterPost := nil ;
  try
    FDMemDados.First ;
    while not FDMemDados.Eof do
    begin
      strFormula := fMontaStringFormula(FDMemDados.FieldByName('AUTOINCREM').AsString, FDMemDados.FieldByName('NRE_CODREF').AsString) ;
      if not fEmptyStr(strFormula) then
      begin
        FDMemDados.Edit ;
        FDMemDados.FieldByName(FIELDFORMULA).AsString := strFormula ;
        FDMemDados.Post ;
      end;
      FDMemDados.Next ;
    end;
  finally
    qryEcfCta.EnableControls ;
    FDMemDados.EnableControls ;
    FDMemDados.AfterPost := FDMemDadosAfterPost;
  end;
end;

procedure TfrmParametrosECF.pCalculoAutomatico(blnUnicaLinha:boolean=False);
var
  strAuxFormula : string ;
  strFormula : string ;
  JsonArr   : TJSONArray;
begin
  /////busca todas as formulas para montar o calculo automatico
  if not blnUnicaLinha then
  begin
    FDMemDados.DisableControls ;
    FDMemDados.AfterPost := nil ;
    JsonArr := TJSONArray.Create;
    try
      strFormula := '' ;
      FDMemDados.First ;
      while not FDMemDados.Eof do
      begin
        strAuxFormula := FDMemDados.FieldByName(FIELDFORMULA).AsString ;
        if fEmptyStr(strAuxFormula) then
        begin
          FDMemDados.Next ;
          Continue ;
        end;
        JsonArr.AddElement(TJSONString.Create(FDMemDados.FieldByName(FIELDFORMULA).AsString));
        FDMemDados.Next ;
      end;

      strFormula := JsonArr.ToString.Replace('[','').Replace(']','').Replace('"','') ;

    finally
      FDMemDados.EnableControls ;
      FDMemDados.AfterPost := FDMemDadosAfterPost ;
      JsonArr.Free ;
    end;
  end
  else
  begin
    strFormula := FDMemDados.FieldByName(FIELDFORMULA).AsString ;
  end;

  pCalculoAutomaticoFormula(strFormula, blnUnicaLinha) ;

end;

procedure TfrmParametrosECF.pCalculoAutomaticoFormula(strFormulas: string; blnUnicaLinha:boolean=False);
var
  strCodEmp : string ;
  strSql : string ;
  dtIni, dtFin : TDate ;
  strAuxFormula : string ;
  qryEcfCalculoAutomatico : TUniQuery ;
begin
  if fEmptyStr(strFormulas) then
  begin
    exit ;
  end;
  ////
  strCodEmp := fRetornaEmpCadSelecionada ;
  dtIni := fDataInicial ;
  dtFin := fDataFinal ;

  strSql := fRetornoSqlCalculoValorFromFormula(strFormulas, strCodEmp) ;

  If Assigned(cdsEcfCalculoAutomatico) Then
    FreeAndNil(cdsEcfCalculoAutomatico);

  qryEcfCalculoAutomatico := fCriaQuery() ;
  try
    qryEcfCalculoAutomatico.Close ;
    qryEcfCalculoAutomatico.SQL.Clear ;
    qryEcfCalculoAutomatico.SQL.Add(strSql) ;
    qryEcfCalculoAutomatico.ParamByName('DATAINI').AsDate := dtIni ;
    qryEcfCalculoAutomatico.ParamByName('DATAFIN').AsDate := dtFin ;
    qryEcfCalculoAutomatico.Open ;

    cdsEcfCalculoAutomatico := fCriaClientDatset(qryEcfCalculoAutomatico, false, Self);
    cdsEcfCalculoAutomatico.IndexFieldNames := 'BAL_CODCON' ;
    cdsEcfCalculoAutomatico.Open;

  finally
    FreeAndNil(qryEcfCalculoAutomatico) ;
  end;

  cdsEcfCalculoAutomatico.First ;

  if not blnUnicaLinha then
  begin
    ///distribui os valores nas colunas dos meses na fdMem
    FDMemDados.DisableControls ;
    cdsEcfCalculoAutomatico.DisableControls ;
    FDMemDados.AfterPost := nil ;
    try
      FDMemDados.First ;
      while not FDMemDados.Eof do
      begin
        strAuxFormula := FDMemDados.FieldByName(FIELDFORMULA).AsString ;
        if fEmptyStr(strAuxFormula) then
        begin
          FDMemDados.Next ;
          Continue ;
        end;
        FDMemDados.Edit ;
        pSetValorMesesFdMem(strAuxFormula) ;
        FDMemDados.Post ;
        FDMemDados.Next ;
      end;
    finally
      FDMemDados.EnableControls ;
      cdsEcfCalculoAutomatico.EnableControls ;
      FDMemDados.AfterPost := FDMemDadosAfterPost ;
    end;
  end
  else
  begin
    pSetValorMesesFdMem(strFormulas) ;
  end;
end;

procedure TfrmParametrosECF.pCarregaCadEmpGrupo(const strCodEmpMatriz:string);
var
  qryConsulta : TUniQuery ;
  strSql : string ;
begin
  strSql := '' ;
  strSql := strSql + ' SELECT EMP_CODEMP, EMP_NOMEMP, EMP_TPLACO ' ;
  strSql := strSql + ' FROM CADEMP ' ;
  strSql := strSql + ' WHERE SUBSTR(EMP_C_G_C_,1,8) IN (SELECT SUBSTR(EMP_C_G_C_,1,8) FROM CADEMP WHERE EMP_CODEMP = :CODEMP) ' ;
  strSql := strSql + ' ORDER BY EMP_NOMEMP ' ;

  If Assigned(cdsCadEmpGrupo) Then
    FreeAndNil(cdsCadEmpGrupo);

  qryConsulta := fCriaQuery() ;
  try
    qryConsulta.Close ;
    qryConsulta.SQL.Clear ;
    qryConsulta.SQL.Add(strSql) ;
    qryConsulta.ParamByName('CODEMP').AsString := strCodEmpMatriz ;
    qryConsulta.Open ;

    cdsCadEmpGrupo := fCriaClientDatset(qryConsulta, false, Self);
    cdsCadEmpGrupo.IndexFieldNames := 'EMP_CODEMP' ;
    cdsCadEmpGrupo.Open;

  finally
    FreeAndNil(qryConsulta) ;
  end;
end;

procedure TfrmParametrosECF.pCarregaEcfCnf;
var
  qryConsulta : TUniQuery ;
  strSql : string ;
begin
  strSql := '' ;
  strSql := strSql + ' SELECT CNF_EMPGRP ' ;
  strSql := strSql + ' FROM ECFCNF ' ;
  strSql := strSql + ' WHERE CNF_CODEMP = :CODEMP ' ;
  strSql := strSql + '       AND CNF_ANOECF = :ANOECF ' ;
  strSql := strSql + '       AND CNF_REGIST = :REGIST ' ;

  If Assigned(cdsEcfCnf) Then
    FreeAndNil(cdsEcfCnf);

  qryConsulta := fCriaQuery() ;
  try
    qryConsulta.Close ;
    qryConsulta.SQL.Clear ;
    qryConsulta.SQL.Add(strSql) ;
    qryConsulta.ParamByName('ANOECF').AsInteger := fRetornaAnoECF ;
    qryConsulta.ParamByName('REGIST').AsString := fRetornaRegistroECF ;
    qryConsulta.ParamByName('CODEMP').AsString := edtCodEmp.Text ;
    qryConsulta.Open ;

    cdsEcfCnf := fCriaClientDatset(qryConsulta, false, Self);
    cdsEcfCnf.IndexFieldNames := 'CNF_EMPGRP' ;
    cdsEcfCnf.Open;

  finally
    FreeAndNil(qryConsulta) ;
  end;
end;

procedure TfrmParametrosECF.pCarregaEcfCta(const strCodEmp:string);
var
  strSql : string ;
begin
  strSql := fGetSqlCarregaEcfCta ;

  qryEcfCta.Close ;
  qryEcfCta.SQL.Clear ;
  qryEcfCta.SQL.Add(strSql) ;
  qryEcfCta.ParamByName('ECF_ANOECF').AsInteger := fRetornaAnoECF ;
  qryEcfCta.ParamByName('ECF_REGIST').AsString := fRetornaRegistroECF ;
  qryEcfCta.ParamByName('ECF_CODEMP').AsString := strCodEmp ;
  qryEcfCta.ParamByName('BLCECF').AsString := FBlcEcf ;
  qryEcfCta.ParamByName('REGECF').AsString := FRegEcf ;
  qryEcfCta.Open ;

end;

procedure TfrmParametrosECF.pCarregaECFCtaExercicio;
var
  strSql : string ;
  strAutoInc : string ;
begin
  strSql := '' ;
  strSql := strSql + ' SELECT CTA_CODCON, ECF_REGIST ' ;
  strSql := strSql + ' FROM ECFLAN INNER JOIN ECFCTA ON ECFLAN.AUTOINCREM = ECFCTA.CTA_SEQLAN ' ;
  strSql := strSql + ' WHERE ECF_CODEMP = :CODEMP ' ;
  strSql := strSql + '       AND ECF_ANOECF = :ANOECF ' ;
  strSql := strSql + '       AND ECF_REGIST = :REGIST ' ;
  strSql := strSql + '       AND ECFLAN.AUTOINCREM <> :AUTOINCREM' ;

  if fEmptyStr(FDMemDados.FieldByName('AUTOINCREM').AsString) then
    strAutoInc := '--1' ///valor qualquer
  else
    strAutoInc := FDMemDados.FieldByName('AUTOINCREM').AsString ;

  qryEcfVerificaCta.Close ;
  qryEcfVerificaCta.SQL.Clear ;
  qryEcfVerificaCta.SQL.Add(strSql) ;
  qryEcfVerificaCta.ParamByName('ANOECF').AsInteger := fRetornaAnoECF ;
  qryEcfVerificaCta.ParamByName('CODEMP').AsString := edtCodEmp.Text ;
  qryEcfVerificaCta.ParamByName('REGIST').AsString := fRetornaRegistroECF ;
  qryEcfVerificaCta.ParamByName('AUTOINCREM').AsString := strAutoInc ;
  qryEcfVerificaCta.Open ;

end;

procedure TfrmParametrosECF.pCarregaEcfFDMem;
begin
  qryEcfLan.DisableControls ;
  FDMemDados.DisableControls ;
  FDMemDados.AfterPost := nil ;
  try
    qryEcfLan.First ;
    while not qryEcfLan.Eof do
    begin
      FDMemDados.Append ;
      FDMemDados.FieldByName('AUTOINCREM').AsString := qryEcfLan.FieldByName('AUTOINCREM').AsString ;
      FDMemDados.FieldByName('NRE_CODREF').AsString := qryEcfLan.FieldByName('NRE_CODREF').AsString ;
      FDMemDados.FieldByName('NRE_DESCRI').AsString := qryEcfLan.FieldByName('NRE_DESCRI').AsString ;
      FDMemDados.FieldByName('ECF_TIPECF').AsString := qryEcfLan.FieldByName('NRE_TIPCTA').AsString ; //qryEcfLan.FieldByName('ECF_TIPECF').AsString ;
      FDMemDados.FieldByName('ECF_FMTECF').AsString := qryEcfLan.FieldByName('ECF_FMTECF').AsString ;
      FDMemDados.FieldByName('NRE_TIPCTA').AsString := qryEcfLan.FieldByName('NRE_TIPCTA').AsString ;
      FDMemDados.FieldByName('NRE_CTASUP').AsString := qryEcfLan.FieldByName('NRE_CTASUP').AsString ;
      FDMemDados.FieldByName('NRE_NIVEL_').AsString := qryEcfLan.FieldByName('NRE_NIVEL_').AsString ;
      FDMemDados.Post ;
      qryEcfLan.Next ;
    end;
  finally
    qryEcfLan.EnableControls ;
    FDMemDados.EnableControls ;
    FDMemDados.AfterPost := FDMemDadosAfterPost ;
  end;
end;

procedure TfrmParametrosECF.pCarregaEcfLan(const strCodEmp:string);
var
  strSql : string ;
begin
  strSql := fGetSqlCarregaEcfLan ;

  qryEcfLan.Close ;
  qryEcfLan.SQL.Clear ;
  qryEcfLan.SQL.Add(strSql) ;
  qryEcfLan.ParamByName('ANOECF').AsInteger := fRetornaAnoECF ;
  qryEcfLan.ParamByName('AUTOINCREM').AsInteger := FIdParametrosECF ;
  qryEcfLan.ParamByName('CODEMP').AsString := strCodEmp ;
  qryEcfLan.Open ;

end;

procedure TfrmParametrosECF.pCarregaEcfMes(const strCodEmp:string);
var
  strSql : string ;
begin
  strSql := fGetSqlCarregaEcfMes ;

  qryEcfMes.Close ;
  qryEcfMes.SQL.Clear ;
  qryEcfMes.SQL.Add(strSql) ;
  qryEcfMes.ParamByName('ANOECF').AsInteger := fRetornaAnoECF ;
  qryEcfMes.ParamByName('AUTOINCREM').AsInteger := FIdParametrosECF ;
  qryEcfMes.ParamByName('CODEMP').AsString := strCodEmp ;
  qryEcfMes.Open ;
end;

procedure TfrmParametrosECF.pCarregaInfoParametrosECF;
var
  qryConsulta : TUniQuery ;
  strSql : string ;
begin
  strSql := '' ;
  strSql := strSql + ' SELECT CONCAT(REG_BLCECF, REG_REGECF) AS REGECF, REG_TIPREG, REG_BLCECF, REG_REGECF ' ;
  strSql := strSql + ' FROM ECFREG ' ;
  strSql := strSql + ' WHERE AUTOINCREM = :AUTOINCREM ' ;

  qryConsulta := fCriaQuery() ;
  try
    qryConsulta.Close ;
    qryConsulta.SQL.Clear ;
    qryConsulta.SQL.Add(strSql) ;
    qryConsulta.ParamByName('AUTOINCREM').AsInteger := FIdParametrosECF ;
    qryConsulta.Open ;

    FRegistroECF := qryConsulta.FieldByName('REGECF').AsString ;
    FBlcEcf := qryConsulta.FieldByName('REG_BLCECF').AsString ;
    FRegEcf := qryConsulta.FieldByName('REG_REGECF').AsString ;
    if qryConsulta.FieldByName('REG_TIPREG').AsString = 'P' then
    begin
      FTipoRegistroECF := treReferencial ;
    end
    else
    begin
      FTipoRegistroECF := treDemonstrativo ;
    end;

  finally
    FreeAndNil(qryConsulta) ;
  end;
end;

procedure TfrmParametrosECF.pCarregaPlanco;
var
  qryConsulta : TUniQuery ;
  strSql : string ;
  strTplAco : string ;
begin
  /////verifica se há EMP_TPLACO no cadastro de empresas
  strTplAco := '' ;
  if Assigned(cdsCadEmpGrupo) then
  begin
    cdsCadEmpGrupo.First ;
    while not cdsCadEmpGrupo.Eof do
    begin
      if not fEmptyStr(cdsCadEmpGrupo.FieldByName('EMP_TPLACO').AsString) then
      begin
        if fEmptyStr(strTplAco) then
        begin
          strTplAco := quotedstr(cdsCadEmpGrupo.FieldByName('EMP_TPLACO').AsString) ;
        end
        else
        begin
          strTplAco := strTplAco + ',' + quotedstr(cdsCadEmpGrupo.FieldByName('EMP_TPLACO').AsString) ;
        end;
      end;
      cdsCadEmpGrupo.Next ;
    end;
  end;

  strSql := '' ;
  strSql := strSql + '  SELECT NCO_CTAREF, NCO_CODCON ' ;
  strSql := strSql + '  FROM PLANCO INNER JOIN PLANRE ON PLANCO.NCO_CTAREF = PLANRE.NRE_CODREF ' ;
  strSql := strSql + '              INNER JOIN ECFREG ON PLANRE.NRE_BLCECF = ECFREG.REG_BLCECF AND PLANRE.NRE_REGECF = ECFREG.REG_REGECF ' ;
  strSql := strSql + '  WHERE ECFREG.AUTOINCREM = :AUTOINCREM ' ;
  if not fEmptyStr(strTplAco) then
  begin
    strSql := strSql + ' AND NCO_TPLACO IN ('+strTplAco+') ' ;
  end;
  strSql := strSql + fFiltroCarregaPlancoDemonstrativo ;
  strSql := strSql + ' ORDER BY NCO_CTAREF ' ;

  If Assigned(cdsPlacoPlanre) Then
    FreeAndNil(cdsPlacoPlanre);

  qryConsulta := fCriaQuery() ;
  try
    qryConsulta.Close ;
    qryConsulta.SQL.Clear ;
    qryConsulta.SQL.Add(strSql) ;
    qryConsulta.ParamByName('AUTOINCREM').AsInteger := FIdParametrosECF ;
    qryConsulta.Open ;

    cdsPlacoPlanre := fCriaClientDatset(qryConsulta, false, Self);
    //cdsPlacoPlanre.IndexFieldNames := 'NCO_CTAREF' ;
    cdsPlacoPlanre.Open;
    cdsPlacoPlanre.IndexDefs.Add('NCO_CTAREF', 'NCO_CTAREF', []);
    cdsPlacoPlanre.IndexDefs.Add('NCO_CODCON', 'NCO_CODCON', []);
    cdsPlacoPlanre.IndexDefs.Add('NCO_CTAREF_NCO_CODCON', 'NCO_CTAREF;NCO_CODCON', []);
    cdsPlacoPlanre.IndexName := 'NCO_CTAREF' ;
  finally
    FreeAndNil(qryConsulta) ;
  end;
end;

procedure TfrmParametrosECF.pCarregaTreeEmpCad;
var
  nodeEmpresa : TcxTreeListNode ;
begin
  if not Assigned(cdsCadEmpGrupo) then
  begin
    exit ;
  end;

  TreeEmpCad.Clear ;
  cdsCadEmpGrupo.First ;
  while not cdsCadEmpGrupo.Eof do
  begin
    nodeEmpresa := TreeEmpCad.Add ;
    nodeEmpresa.Values[0] := (not cdsEcfCnf.FindKey([cdsCadEmpGrupo.FieldByName('EMP_CODEMP').AsString])) ;
    nodeEmpresa.Texts[1] :=  cdsCadEmpGrupo.FieldByName('EMP_CODEMP').AsString + ' - ' + cdsCadEmpGrupo.FieldByName('EMP_NOMEMP').AsString ;
    cdsCadEmpGrupo.Next ;
  end;
    
end;

procedure TfrmParametrosECF.pCriaColunasGrid;
var
  intCnt : integer ;
  colGrid : TcxGridDBBandedColumn ;
  dtIni, dtFin : TDateTime ;
  intMes : Integer ;
begin
  GridTab.DataController.BeginFullUpdate;
  try
    ////limpa todas as colunas da grid
    GridTab.ClearItems ;
    //////define o tamanho padrão da BAND
    GridTab.Bands.Items[0].Width := 845 ;
    /////colunas fixas
    colGrid := GridTab.CreateColumn ;
    colGrid.DataBinding.FieldName := 'ID' ;
    colGrid.Caption := 'ID' ;
    colGrid.Visible := False ;
    colGrid.VisibleForCustomization := False ;
    colGrid.Position.BandIndex := 0;
    colGrid.Name := GridTab.Name+colGrid.DataBinding.FieldName;

    colGrid := GridTab.CreateColumn ;
    colGrid.DataBinding.FieldName := 'AUTOINCREM' ;
    colGrid.Caption := 'AUTOINCREM' ;
    colGrid.Visible := False ;
    colGrid.VisibleForCustomization := False ;
    colGrid.Position.BandIndex := 0;
    colGrid.Name := GridTab.Name+colGrid.DataBinding.FieldName;

    colGrid := GridTab.CreateColumn ;
    colGrid.DataBinding.FieldName := 'NRE_CODREF' ;
    colGrid.Caption := 'Código' ;
    colGrid.Position.BandIndex := 0;
    colGrid.Width := 82 ;
    colGrid.Options.Editing := False ;
    colGrid.Name := GridTab.Name+colGrid.DataBinding.FieldName;

    colGrid := GridTab.CreateColumn ;
    colGrid.DataBinding.FieldName := 'NRE_DESCRI' ;
    colGrid.Caption := 'Descrição' ;
    colGrid.Position.BandIndex := 0;
    colGrid.Width := 318 ;
    colGrid.Options.Editing := False ;
    colGrid.Name := GridTab.Name+colGrid.DataBinding.FieldName;

    colGrid := GridTab.CreateColumn ;
    colGrid.DataBinding.FieldName := 'NRE_NIVEL_' ;
    colGrid.Visible := False ;
    colGrid.VisibleForCustomization := False ;
    colGrid.Caption := 'Nivel' ;
    colGrid.Position.BandIndex := 0;
    colGrid.Width := 38 ;
    colGrid.Options.Editing := False ;
    colGrid.Name := GridTab.Name+colGrid.DataBinding.FieldName;

    colGrid := GridTab.CreateColumn ;
    colGrid.DataBinding.FieldName := 'NRE_TIPCTA' ;
    colGrid.Visible := False ;
    colGrid.VisibleForCustomization := False ;
    colGrid.Caption := 'Tipo' ;
    colGrid.Position.BandIndex := 0;
    colGrid.Width := 38 ;
    colGrid.Options.Editing := False ;
    colGrid.Name := GridTab.Name+colGrid.DataBinding.FieldName;

    colGrid := GridTab.CreateColumn ;
    colGrid.DataBinding.FieldName := 'NRE_CTASUP' ;
    colGrid.Visible := False ;
    colGrid.VisibleForCustomization := False ;
    colGrid.Caption := 'Nivel Superior' ;
    colGrid.Position.BandIndex := 0;
    colGrid.Width := 38 ;
    colGrid.Options.Editing := False ;
    colGrid.Name := GridTab.Name+colGrid.DataBinding.FieldName;

    colGrid := GridTab.CreateColumn ;
    colGrid.DataBinding.FieldName := 'ECF_TIPECF' ;
    colGrid.Caption := 'Tipo' ;
    colGrid.Position.BandIndex := 0;
    colGrid.Width := 38 ;
    colGrid.Name := GridTab.Name+colGrid.DataBinding.FieldName;
    colGrid.Options.Editing := False ;
    pSetTextColunaGrid(colGrid) ;

    colGrid := GridTab.CreateColumn ;
    colGrid.DataBinding.FieldName := 'ECF_FMTECF' ;
    colGrid.Caption := 'Formato' ;
    colGrid.Position.BandIndex := 0;
    colGrid.Width := 60 ;
    colGrid.Name := GridTab.Name+colGrid.DataBinding.FieldName;
    pSetTextColunaGrid(colGrid) ;

    colGrid := GridTab.CreateColumn ;
    colGrid.DataBinding.FieldName := FIELDFORMULA ;
    colGrid.Caption := 'Fórmula' ;
    colGrid.Position.BandIndex := 0;
    colGrid.Name := GridTab.Name+colGrid.DataBinding.FieldName;
    colGrid.Width := 245 ;
    colGrid.Options.Moving := False ;
    colGrid.Options.VertSizing := False ;
    colGrid.Options.HorzSizing := False ;
    pSetMemoColunaGrid(colGrid) ;

    colGrid := GridTab.CreateColumn ;
    colGrid.DataBinding.FieldName := 'BOTOES' ;
    colGrid.Caption := ' ' ;
    colGrid.Position.BandIndex := 0;
    colGrid.Options.ShowEditButtons := isebAlways ;
    colGrid.Name := GridTab.Name+colGrid.DataBinding.FieldName;
    colGrid.Width := 47 ;
    colGrid.Options.Filtering := False ;
    colGrid.Options.Moving := False ;
    colGrid.Options.Sorting := False ;
    colGrid.Options.VertSizing := False ;
    colGrid.Options.HorzSizing := False ;
    pSetBtnColunaGrid(colGrid) ;

    colGrid := GridTab.CreateColumn ;
    colGrid.DataBinding.FieldName := 'SALDO_INICIAL' ;
    colGrid.Caption := 'Saldo Inicial' ;
    colGrid.Position.BandIndex := 0;
    colGrid.Name := GridTab.Name+colGrid.DataBinding.FieldName;
    colGrid.Width := 102 ;
    colGrid.Options.Editing := False ;
    pSetCurColunaGrid(colGrid) ;

    colGrid := GridTab.CreateColumn ;
    colGrid.DataBinding.FieldName := 'ANO' ;
    colGrid.Caption := 'Ano' ;
    colGrid.Position.BandIndex := 0;
    colGrid.Name := GridTab.Name+colGrid.DataBinding.FieldName;
    colGrid.Width := 102 ;
    colGrid.Options.Editing := False ;
    pSetCurColunaGrid(colGrid) ;

    colGrid := GridTab.CreateColumn ;
    colGrid.DataBinding.FieldName := 'SALDO_FINAL' ;
    colGrid.Caption := 'Saldo Final' ;
    colGrid.Position.BandIndex := 0;
    colGrid.Name := GridTab.Name+colGrid.DataBinding.FieldName;
    colGrid.Width := 102 ;
    colGrid.Options.Editing := False ;
    pSetCurColunaGrid(colGrid) ;
    ////colunas referente aos meses.
    //////define o tamanho máximo da BAND
    GridTab.Bands.Items[1].Width := 64 * 12;
    ///para esconder os meses não filtrados
    dtIni := fDataInicial ;
    dtFin := fDataFinal ;
    ///
    for intCnt := 0 to FDMemDados.FieldCount-1 do
    begin
      if pos('MES_', FDMemDados.Fields.Fields[intCnt].FieldName) > 0 then
      begin
        colGrid := GridTab.CreateColumn ;
        colGrid.DataBinding.FieldName := FDMemDados.Fields.Fields[intCnt].FieldName ;
        intMes := strtoint(SplitString(FDMemDados.Fields.Fields[intCnt].FieldName, '_')[1]) ;
        colGrid.Caption := fRetMes(intMes) ;
        colGrid.Visible := ((intMes >= MonthOf(dtIni)) and (intMes <= MonthOf(dtFin))) ;
        colGrid.VisibleForCustomization := colGrid.Visible ;
        colGrid.Position.BandIndex := 1;
        colGrid.Name := GridTab.Name+colGrid.DataBinding.FieldName;
        colGrid.Width := 64 ;
        pSetCurColunaGridMes(colGrid) ;
      end;
      if pos('SALDO_INICIAL_', FDMemDados.Fields.Fields[intCnt].FieldName) > 0 then
      begin
        colGrid := GridTab.CreateColumn ;
        colGrid.DataBinding.FieldName := FDMemDados.Fields.Fields[intCnt].FieldName ;
        colGrid.Visible := False ;
        colGrid.VisibleForCustomization := colGrid.Visible ;
        colGrid.Position.BandIndex := 1;
        colGrid.Name := GridTab.Name+colGrid.DataBinding.FieldName;
        pSetCurColunaGridMes(colGrid) ;
      end;
    end;
    //////define o tamanho máximo da BAND
    GridTab.Bands.Items[1].Width := 64 * fContMesColGrid;
  finally
    GridTab.DataController.EndFullUpdate;
  end;
end;

procedure TfrmParametrosECF.pCriaEstruturaTempDataset;
var
  intCnt : integer ;
begin
  FDMemDados.Close ;
  FDMemDados.FieldDefs.Clear ;
  FDMemDados.FieldDefs.Add('ID',ftAutoInc, 0, True); ///campo virtual, chave primaria.
  FDMemDados.FieldDefs.Add('AUTOINCREM',ftString, 20, False);
  FDMemDados.FieldDefs.Add('NRE_CODREF',ftString, 20, True);
  FDMemDados.FieldDefs.Add('NRE_DESCRI',ftString, 120, False);
  FDMemDados.FieldDefs.Add('NRE_CTASUP',ftString, 20, False);
  FDMemDados.FieldDefs.Add('NRE_NIVEL_',ftInteger, 0, False);
  FDMemDados.FieldDefs.Add('NRE_TIPCTA',ftString, 5, False);
  FDMemDados.FieldDefs.Add('ECF_TIPECF',ftString, 1, False);
  FDMemDados.FieldDefs.Add('ECF_FMTECF',ftString, 1, False);
  FDMemDados.FieldDefs.Add('FORMULA',ftMemo, 0, False);
  FDMemDados.FieldDefs.Add('BOTOES',ftString, 1, False);
  FDMemDados.FieldDefs.Add('SALDO_INICIAL',ftFloat, 0, False);
  FDMemDados.FieldDefs.Add('ANO',ftFloat, 0, False);
  FDMemDados.FieldDefs.Add('SALDO_FINAL',ftFloat, 0, False);
  for intCnt := 1 to 12 do
  begin
    FDMemDados.FieldDefs.Add('SALDO_INICIAL_'+inttostr(intCnt),ftFloat, 0, False);
    FDMemDados.FieldDefs.Add('MES_'+inttostr(intCnt),ftFloat, 0, False);
  end;
  FDMemDados.CreateDataSet;
end;

procedure TfrmParametrosECF.pExtraiCtaFormulaParaDataSet(strSeqLan, strCodEmp,
  strFormula: String; var strAutoInc:string);
var
  lstAux : TStringList ;
  intCnt : integer ;
  strIndNameAnt : String ;
begin
  if fEmptyStr(strFormula) then
  begin
    exit ;
  end;

  lstAux := fFormulaToList(strFormula) ;
  strIndNameAnt := cdsPlacoPlanre.IndexName ;
  cdsPlacoPlanre.IndexName := 'NCO_CODCON' ;
  try
    for intCnt := 0 to lstAux.Count-1 do
    begin
      if not cdsPlacoPlanre.FindKey([lstAux.Strings[intCnt]]) then
      begin
        pInsertECFCta(strSeqLan, trim(lstAux.Strings[intCnt]), strCodEmp, strAutoInc);
      end;
    end;
  finally
    cdsPlacoPlanre.IndexName := strIndNameAnt ;
    lstAux.Free ;
  end;
end;

procedure TfrmParametrosECF.pExtraiValorMesesParaDataSet(strSeqLan,
  strCodEmp: String; var strAutoInc:string);
var
  intCnt : integer ;
  intMes : integer ;
begin
  for intCnt := 0 to FDMemDados.FieldCount-1 do
  begin
    if pos('MES_', FDMemDados.Fields.Fields[intCnt].FieldName) > 0 then
    begin
      intMes := strtoint(SplitString(FDMemDados.Fields.Fields[intCnt].FieldName, '_')[1]) ;
      pInsertECFMes(strSeqLan, intMes, FDMemDados.Fields.Fields[intCnt].AsFloat, strCodEmp, strAutoInc);
    end;
  end;
end;

procedure TfrmParametrosECF.pGravaLancamentos(pgbProgresso: TcxProgressBar);
var
  strAutoIncLan : string ;
  strAutoIncMes : string ;
  strAutoIncCta : string ;
  strAutoIncSld : string ;
  strCodEmp : string ;
  intAno : integer ;
  strRegistro : string ;
  intCountLan : integer ;
  intCountMes : integer ;
  intCountCnt : integer ;
  strProxIncLan : string ;
begin
  qryEcfLanExec.Close ;
  qryEcfLanExec.SQL.Clear ;
  qryEcfLanExec.SQL.Text := fGetSqlInsertECFLan ;

  qryEcfMesExec.Close ;
  qryEcfMesExec.SQL.Clear ;
  qryEcfMesExec.SQL.Text := fGetSqlInsertECFMes ;

  qryEcfCtaExec.Close ;
  qryEcfCtaExec.SQL.Clear ;
  qryEcfCtaExec.SQL.Text := fGetSqlInsertECFCta ;

  qryEcfSldExec.Close ;
  qryEcfSldExec.SQL.Clear ;
  qryEcfSldExec.SQL.Text := fGetSqlInsertEcfSld ;

  FDMemDados.DisableControls ;
  try
    strCodEmp := edtCodEmp.Text ;
    intAno := fRetornaAnoECF ;
    strRegistro := fRetornaRegistroECF ;
    intCountLan := FDMemDados.RecordCount ;
    intCountMes := intCountLan * 12 ;
    intCountCnt := fCountCtaFormulaManual ;
    strAutoIncMes := fRetAutoIncrem('ECFMES', strCodEmp, intCountMes);
    strAutoIncLan := fRetAutoIncrem('ECFLAN', strCodEmp, intCountLan);
    strAutoIncSld := fRetAutoIncrem('ECFSLD', strCodEmp, intCountLan);
    if intCountCnt > 0 then
    begin
      strAutoIncCta := fRetAutoIncrem('ECFCTA', strCodEmp, intCountCnt);
    end;
    strProxIncLan := strAutoIncLan ;
    FDMemDados.First ;
    while not FDMemDados.Eof do
    begin
      pgbProgresso.Position := FDMemDados.RecNo;
      Application.ProcessMessages;
      strAutoIncLan := strProxIncLan ;
      strProxIncLan := fInsertECFLan(FDMemDados.FieldByName('NRE_CODREF').AsString,
                                     strCodEmp,
                                     FDMemDados.FieldByName('ECF_TIPECF').AsString,
                                     FDMemDados.FieldByName('ECF_FMTECF').AsString,
                                     intAno,
                                     strRegistro,
                                     strAutoIncLan) ;

      pInsertEcfSld(FDMemDados.FieldByName('NRE_CODREF').AsString,
                    strCodEmp,
                    intAno,
                    strRegistro,
                    strAutoIncSld,
                    FDMemDados.FieldByName('SALDO_INICIAL').AsFloat);
      strAutoIncSld := fNextAutoIncrem(strAutoIncSld) ;

      ////salva os dados da Formula
      if intCountCnt > 0 then
      begin
        pExtraiCtaFormulaParaDataSet(strAutoIncLan, strCodEmp, FDMemDados.FieldByName(FIELDFORMULA).AsString, strAutoIncCta);
      end;
      ////salva os valores dos meses
      pExtraiValorMesesParaDataSet(strAutoIncLan, strCodEmp, strAutoIncMes);
      ////
      FDMemDados.Next ;
    end;
  finally
    FDMemDados.EnableControls ;
  end;
end;

procedure TfrmParametrosECF.pGuardaValorAntigoAnoMeses;
var
  intCnt : integer ;
begin
  ////salva os valores antigos
  FvrtValorAnoAntigo := FDMemDados.FieldByName('ANO').OldValue ;
  FvrtValorSaldoInicialAntigo := FDMemDados.FieldByName('SALDO_INICIAL').OldValue ;
  for intCnt := 1 to 12 do
  begin
    FarrVrtValorMesAntigo[intCnt-1] := FDMemDados.FieldByName('MES_'+inttostr(intCnt)).OldValue ;
    FarrVrtValorSaldoInicialAntigo[intCnt-1] := FDMemDados.FieldByName('SALDO_INICIAL_'+inttostr(intCnt)).OldValue ;
  end;
end;

procedure TfrmParametrosECF.pIniciaECF(blnHabilitar: boolean);
begin
  pnlDados.Visible := blnHabilitar ;
  if Assigned(cdsCadEmpGrupo) then
  begin
    pnlCadEmpGrupo.Visible := cdsCadEmpGrupo.RecordCount > 1 ;
  end;

  edtCodEmp.Enabled := not blnHabilitar ;
  edtNomEmp.Enabled := not blnHabilitar ;
  mskPeriodoIni.Enabled := not blnHabilitar ;
  mskPeriodoFin.Enabled := not blnHabilitar ;
  btnCarrTitulos.Enabled := not blnHabilitar ;

  blnFecharComEscape := not blnHabilitar ;
end;

procedure TfrmParametrosECF.pInsertECFCta(strSeqLan: string;
  strCodCon: string; strCodEmp:string; var strAutoInc:string);
begin
  qryEcfCtaExec.ParamByName('AUTOINCREM').AsString := strAutoInc ;
  qryEcfCtaExec.ParamByName('SEQLAN').AsString := strSeqLan ;
  qryEcfCtaExec.ParamByName('CODCON').AsString := strCodCon ;
  qryEcfCtaExec.ExecSQL ;
  strAutoInc := fNextAutoIncrem(strAutoInc)
end;

procedure TfrmParametrosECF.pInsertECFMes(strSeqLan: string; intMesEcf: integer;
  fltVlrecf: Double; strCodEmp:string;var strAutoInc:string);
begin
  qryEcfMesExec.ParamByName('AUTOINCREM').AsString := strAutoInc ;
  qryEcfMesExec.ParamByName('SEQLAN').AsString := strSeqLan ;
  qryEcfMesExec.ParamByName('MESECF').AsInteger := intMesEcf ;
  qryEcfMesExec.ParamByName('VLRECF').AsFloat := fltVlrecf ;
  qryEcfMesExec.ExecSQL ;
  strAutoInc := fNextAutoIncrem(strAutoInc)
end;

procedure TfrmParametrosECF.pInsertEcfSld(const strCodRef, strCodEmp: string;
  const intAnoEcf: Integer; const strRegistro, strAutoIncSld: string;
  const fltSldini: double);
begin
  if pos(REGISTROGRAVASALDOINICIAL, strRegistro) <= 0 then
  begin
    exit ;
  end;

  qryEcfSldExec.ParamByName('AUTOINCREM').AsString := strAutoIncSld ;
  qryEcfSldExec.ParamByName('CODREF').AsString := strCodRef ;
  qryEcfSldExec.ParamByName('CODEMP').AsString := strCodEmp ;
  qryEcfSldExec.ParamByName('SLDINI').AsFloat := fltSldini ;
  qryEcfSldExec.ParamByName('ANOECF').Asinteger := intAnoEcf ;
  qryEcfSldExec.ParamByName('REGIST').AsString := strRegistro ;
  qryEcfSldExec.ExecSQL ;
end;

procedure TfrmParametrosECF.pLimpaCadEmpGrupo;
begin
  if Assigned(cdsCadEmpGrupo) then
  begin
    cdsCadEmpGrupo.EmptyDataSet ;
  end;
end;

procedure TfrmParametrosECF.pLimpaTodosMeses(const blnEmEdicao:boolean=False);
var
  intCnt : integer ;
  ColAno : TcxCustomGridTableItem ;
begin
  if not blnEmEdicao then
  begin
    FDMemDados.AfterPost := nil ;
    FDMemDados.Edit ;
  end;
  ColAno := fRetornaColbyFieldName(GridTab, 'ANO') ;
  if Assigned(ColAno) then
  begin
    TcxGridDBBandedColumn(ColAno).DataBinding.Field.Clear ;
  end;
  for intCnt := 0 to GridTab.ColumnCount-1 do
  begin
    if pos('MES_', GridTab.Columns[intCnt].DataBinding.FieldName) > 0 then
    begin
      GridTab.Columns[intCnt].DataBinding.Field.Clear ;
    end;
    ///
    if pos('SALDO_INICIAL_', GridTab.Columns[intCnt].DataBinding.FieldName) > 0 then
    begin
      GridTab.Columns[intCnt].DataBinding.Field.Clear ;
    end;
  end;
  if not blnEmEdicao then
  begin
    FDMemDados.Post ;
    FDMemDados.AfterPost := FDMemDadosAfterPost ;
  end;
end;

procedure TfrmParametrosECF.pLimpaValorSintetico;
var
  intCnt : integer ;
begin
  FDMemDados.First ;
  while not FDMemDados.Eof do
  begin
    if FDMemDados.FieldByName('NRE_TIPCTA').AsString = 'S' then
    begin
      if fValorDiferenteZero(FDMemDados.FieldByName('ANO').AsFloat, FDMemDados.FieldByName('SALDO_INICIAL').AsFloat) then
      begin
        FDMemDados.Edit ;
        FDMemDados.FieldByName('ANO').AsFloat := 0.00 ;
        FDMemDados.FieldByName('SALDO_INICIAL').AsFloat := 0.00 ;
        FDMemDados.FieldByName('SALDO_FINAL').AsFloat := 0.00 ;
        for intCnt := 1 to 12 do
        begin
          FDMemDados.FieldByName('MES_'+inttostr(intCnt)).AsFloat := 0.00 ;
          FDMemDados.FieldByName('SALDO_INICIAL_'+inttostr(intCnt)).AsFloat := 0.00 ;
        end;
        FDMemDados.Post ;
      end;
    end;
    FDMemDados.Next ;
  end;
end;

procedure TfrmParametrosECF.pMensagemVerificaCtaExercicio(strMensagem: string);
begin
  if not fEmptyStr(strMensagem) then
  begin
    fMensagem('ATENÇÃO!', 'Conta(s) em uso em outro(s) registro(s)!' + #13+#10 +
                          strMensagem, ['&Ok']);
  end;
end;

procedure TfrmParametrosECF.pAjustaValorMeses;
var
  strFormula : string ;
begin
  qryEcfMes.DisableControls ;
  FDMemDados.DisableControls ;
  FDMemDados.AfterPost := nil ;
  try
    FDMemDados.First ;
    while not FDMemDados.Eof do
    begin
      strFormula := FDMemDados.FieldByName(FIELDFORMULA).AsString ;
      if not fEmptyStr(strFormula) then
      begin
        FDMemDados.Next ;
        Continue ;
      end;

      if qryEcfMes.Locate('MES_SEQLAN', FDMemDados.FieldByName('AUTOINCREM').AsString, [loCaseInsensitive] ) then
      begin
        FDMemDados.Edit ;
        while fEhAgrupamento(qryEcfMes.FieldByName('MES_SEQLAN').AsString, FDMemDados.FieldByName('AUTOINCREM').AsString, qryEcfMes.Eof) do
        begin
          ////distribui os valores nos meses
          FDMemDados.FieldByName('MES_'+qryEcfMes.FieldByName('MES_MESECF').AsString).AsFloat := qryEcfMes.FieldByName('MES_VLRECF').AsFloat ;
          qryEcfMes.Next ;
        end;
        FDMemDados.post ;
      end;
      FDMemDados.Next ;
    end;
  finally
    qryEcfMes.EnableControls ;
    FDMemDados.EnableControls ;
    FDMemDados.AfterPost := FDMemDadosAfterPost ;
  end;
end;

procedure TfrmParametrosECF.pApagaLancamentos;
var
  strCodEmp, strRegistro: string ;
  intAno: integer ;
begin
  strCodEmp := edtCodEmp.Text ;
  intAno := fRetornaAnoECF ;
  strRegistro := fRetornaRegistroECF ;
  qryEcfLanExec.Close ;
  qryEcfLanExec.SQL.Clear ;
  qryEcfLanExec.SQL.Text := 'DELETE FROM ECFLAN where ECF_CODEMP = :CODEMP AND ECF_ANOECF = :ANOECF AND ECF_REGIST = :REGIST;' ;
  qryEcfLanExec.ParamByName('CODEMP').AsString := strCodEmp ;
  qryEcfLanExec.ParamByName('ANOECF').AsInteger := intAno ;
  qryEcfLanExec.ParamByName('REGIST').AsString := strRegistro ;
  qryEcfLanExec.ExecSQL ;
  ///apaga o saldo inicial do exercicio.
  qryEcfSldExec.Close ;
  qryEcfSldExec.SQL.Clear ;
  qryEcfSldExec.SQL.Text := 'DELETE FROM ECFSLD where SLD_CODEMP = :CODEMP AND SLD_ANOECF = :ANOECF AND SLD_REGIST = :REGIST;' ;
  qryEcfSldExec.ParamByName('CODEMP').AsString := strCodEmp ;
  qryEcfSldExec.ParamByName('ANOECF').AsInteger := intAno ;
  qryEcfSldExec.ParamByName('REGIST').AsString := strRegistro ;
  qryEcfSldExec.ExecSQL ;
end;

procedure TfrmParametrosECF.pBuscaLinhaAnalitica;
begin
  ///busca uma linha analitica
  while not FDMemDados.Bof do
  begin
    if FDMemDados.FieldByName('NRE_TIPCTA').AsString = 'A' then
    begin
      Break;
    end;
    FDMemDados.Prior ;
  end;
end;

function TfrmParametrosECF.fMontaStringFormula(arrSel: TConsultasArray; const strCodPlanre:string):string;
var
  intCnt : integer ;
  JsonArr   : TJSONArray;
  strIndNameAnt : String ;
begin

  JsonArr := TJSONArray.Create;
  try

    if cdsPlacoPlanre.FindKey([strCodPlanre]) then
    begin
      while fIsGrupoStringFormula(cdsPlacoPlanre.FieldByName('NCO_CTAREF').AsString = strCodPlanre, not cdsPlacoPlanre.Eof) do
      begin
        JsonArr.AddElement(TJSONNumber.Create(cdsPlacoPlanre.FieldByName('NCO_CODCON').AsString));
        cdsPlacoPlanre.Next ;
      end;
    end;

    strIndNameAnt := cdsPlacoPlanre.IndexName ;
    cdsPlacoPlanre.IndexName := 'NCO_CTAREF_NCO_CODCON' ;
    try
      for intCnt := Low(arrSel) to High(arrSel) do
      begin
        if not fEmptyStr(arrSel[intCnt].strCodigo) then
        begin
          ///ignora os registro que já estão no cds para evitar duplicação
          //if cdsPlacoPlanre.Locate('NCO_CTAREF;NCO_CODCON',VarArrayOf([strCodPlanre, arrSel[intCnt].strCodigo]),[loCaseInsensitive]) then
          if cdsPlacoPlanre.FindKey([strCodPlanre, arrSel[intCnt].strCodigo]) then
          begin
            Continue ;
          end;
          JsonArr.AddElement(TJSONNumber.Create(arrSel[intCnt].strCodigo));
        end;
      end;
    finally
      cdsPlacoPlanre.IndexName := strIndNameAnt ;
    end;
    result := JsonArr.ToString.Replace('[','').Replace(']','') ;
  finally
    JsonArr.Free ;
  end;
end;

procedure TfrmParametrosECF.pSetBtnColunaGrid(colGrid: TcxGridDBBandedColumn);
var
  propBtnEdit : TcxButtonEditProperties ;
begin
  propBtnEdit := TcxButtonEditProperties.Create(colGrid) ;
  try
    cxImageList.GetImage(0,FImageVerFormula);
    cxImageList.GetImage(1,FImageCalcularFormula);

    propBtnEdit.Buttons.Items[0].Hint := 'Manutenção das contas contábeis selecionadas!' ;
    propBtnEdit.Buttons.Items[0].Kind := bkGlyph ;
    propBtnEdit.Buttons.Items[0].Glyph.SetBitmap(FImageVerFormula) ;

    propBtnEdit.Buttons.Add ;
    propBtnEdit.Buttons.Items[1].Hint := 'Recalcular Fórmula!' ;
    propBtnEdit.Buttons.Items[1].Kind := bkGlyph ;
    propBtnEdit.Buttons.Items[1].Glyph.SetBitmap(FImageCalcularFormula) ;

    propBtnEdit.OnButtonClick := pEventoShowContasPlanoReferencial ;
    colGrid.PropertiesClassName := 'TcxButtonEditProperties' ;
    colGrid.Properties.Assign(propBtnEdit);
  finally
    propBtnEdit.Free ;
  end;
end;

procedure TfrmParametrosECF.pSetCurColunaGridMes(colGrid: TcxGridDBBandedColumn);
var
  propCurr : TcxCurrencyEditProperties ;
begin
  propCurr := TcxCurrencyEditProperties.Create(colGrid) ;
  try
    propCurr.DisplayFormat := '#,##0.00' ;
    propCurr.OnEditValueChanged := pEventoCalculoAnoManual ;
    colGrid.PropertiesClassName := 'TcxCurrencyEditProperties' ;
    colGrid.Properties.Assign(propCurr);
  finally
    propCurr.Free ;
  end;
end;

procedure TfrmParametrosECF.pSetMemoColunaGrid(colGrid: TcxGridDBBandedColumn);
var
  propMemo : TcxMemoProperties ;
begin
  propMemo := TcxMemoProperties.Create(colGrid) ;
  try
    propMemo.CharCase := ecUpperCase ;
  finally
    propMemo.Free ;
  end;
end;

procedure TfrmParametrosECF.pSetCurColunaGrid(
  colGrid: TcxGridDBBandedColumn);
var
  propCurr : TcxCurrencyEditProperties ;
begin
  propCurr := TcxCurrencyEditProperties.Create(colGrid) ;
  try
    propCurr.DisplayFormat := '#,##0.00' ;
    colGrid.PropertiesClassName := 'TcxCurrencyEditProperties' ;
    colGrid.Properties.Assign(propCurr);
  finally
    propCurr.Free ;
  end;
end;

procedure TfrmParametrosECF.pSetTextColunaGrid(colGrid: TcxGridDBBandedColumn);
var
  propText : TcxTextEditProperties ;
begin
  propText := TcxTextEditProperties.Create(colGrid) ;
  try
    propText.CharCase := ecUpperCase ;
    colGrid.PropertiesClassName := 'TcxTextEditProperties' ;
    colGrid.Properties.Assign(propText);
  finally
    propText.Free ;
  end;
end;

procedure TfrmParametrosECF.pSetValorMesesFdMem(strFormula:string);
var
  lstAux : TStringList ;
  intCnt : integer ;
begin
  ///extrai as contas contabeis da formula.
  lstAux := fFormulaToList(strFormula) ;
  try
    for intCnt := 0 to lstAux.Count-1 do
    begin
      if cdsEcfCalculoAutomatico.FindKey([lstAux.Strings[intCnt]]) then
      begin
        while fEhAgrupamento(cdsEcfCalculoAutomatico.FieldByName('BAL_CODCON').AsString, lstAux.Strings[intCnt], cdsEcfCalculoAutomatico.Eof) do
        begin
          FDMemDados.FieldByName('MES_'+cdsEcfCalculoAutomatico.FieldByName('MES_DTAMOV').AsString).AsFloat := FDMemDados.FieldByName('MES_'+cdsEcfCalculoAutomatico.FieldByName('MES_DTAMOV').AsString).AsFloat + cdsEcfCalculoAutomatico.FieldByName('BAL_SALFIN').AsFloat ;
          FDMemDados.FieldByName('SALDO_INICIAL_'+cdsEcfCalculoAutomatico.FieldByName('MES_DTAMOV').AsString).AsFloat := FDMemDados.FieldByName('SALDO_INICIAL_'+cdsEcfCalculoAutomatico.FieldByName('MES_DTAMOV').AsString).AsFloat + cdsEcfCalculoAutomatico.FieldByName('SALDO_INICIAL').AsFloat ;
          cdsEcfCalculoAutomatico.Next ;
        end;
      end;
    end;
  finally
    lstAux.Free ;
  end;
end;

procedure TfrmParametrosECF.pSomaValorSinteticoPeloAnalitico(const blnModoTotal:boolean);
var
  intId : Integer ;
  intIdVolta : Integer ;
  fltValor, fltSaldoInicial : Double ;
  strNivelSintetico : string ;
  intCnt : integer ;
  arr_meses : array[0..11] of double ;
  arr_saldo_inicial : array[0..11] of double ;
begin
  //// processa somente se for plano referencial.
  if FTipoRegistroECF = treDemonstrativo then
  begin
    exit ;
  end;

  FDMemDados.DisableControls ;
  FDMemDados.AfterPost := nil ;
  try
    intId := FDMemDados.FieldByName('ID').AsInteger ;
    if blnModoTotal then
    begin
      ////limpa os valores sinteticos para recalcular com os novos valores
      pLimpaValorSintetico ;
      FDMemDados.Last ;
      pBuscaLinhaAnalitica ;
    end;

    while not FDMemDados.Bof do
    begin
      intIdVolta := FDMemDados.FieldByName('ID').AsInteger ;
      fltValor := FDMemDados.FieldByName('ANO').AsFloat ;
      fltSaldoInicial := FDMemDados.FieldByName('SALDO_INICIAL').AsFloat ;
      for intCnt := 1 to 12 do
      begin
        arr_meses[intCnt-1] := FDMemDados.FieldByName('MES_'+inttostr(intCnt)).AsFloat ;
        arr_saldo_inicial[intCnt-1] := FDMemDados.FieldByName('SALDO_INICIAL_'+inttostr(intCnt)).AsFloat ;
      end;

      if not blnModoTotal then
      begin
        pSubtraiValorSinteticoPeloValorAnterior(intIdVolta) ;
      end;

      repeat
        ///soma o valor no nivel sintetico
        strNivelSintetico := FDMemDados.FieldByName('NRE_CTASUP').AsString ;
        if FDMemDados.Locate('NRE_CODREF',strNivelSintetico,[loCaseInsensitive]) then
        begin
          if fValorDiferenteZero(fltValor, fltSaldoInicial) then
          begin
            FDMemDados.Edit ;
            FDMemDados.FieldByName('ANO').AsFloat := FDMemDados.FieldByName('ANO').AsFloat + fltValor ;
            FDMemDados.FieldByName('SALDO_INICIAL').AsFloat := FDMemDados.FieldByName('SALDO_INICIAL').AsFloat + fltSaldoInicial ;
            for intCnt := 1 to 12 do
            begin
              FDMemDados.FieldByName('MES_'+inttostr(intCnt)).AsFloat := FDMemDados.FieldByName('MES_'+inttostr(intCnt)).AsFloat + arr_meses[intCnt-1] ;
              FDMemDados.FieldByName('SALDO_INICIAL_'+inttostr(intCnt)).AsFloat := FDMemDados.FieldByName('SALDO_INICIAL_'+inttostr(intCnt)).AsFloat + arr_saldo_inicial[intCnt-1] ;
            end;
            FDMemDados.FieldByName('SALDO_FINAL').AsFloat := FDMemDados.FieldByName('SALDO_INICIAL').AsFloat + FDMemDados.FieldByName('ANO').AsFloat ;
            FDMemDados.Post ;
          end;
        end;
      until (fEmptyStr(FDMemDados.FieldByName('NRE_CTASUP').AsString));
      FDMemDados.Locate('ID',intIdVolta,[loCaseInsensitive]);
      if not blnModoTotal then
      begin
        break ;
      end;
      FDMemDados.Prior ;
      pBuscaLinhaAnalitica ;
    end;
    /////restaura o ponto de partida
    FDMemDados.Locate('ID',intId,[loCaseInsensitive]);
    /////
  finally
    FDMemDados.EnableControls ;
    FDMemDados.AfterPost := FDMemDadosAfterPost ;
  end;
end;

procedure TfrmParametrosECF.pSubtraiValorSinteticoPeloValorAnterior(
  const intId: integer);
var
  fltValor : double ;
  fltSaldoInicial : double ;
  arr_meses : array[0..12] of double ;
  arr_saldo_inicial : array[0..12] of double ;
  intCnt : integer ;
  strNivelSintetico : string ;
begin
  //////criar uma função generica para fazer o teste do varnull
  fltValor := fTrataValorNuloNumeric(FvrtValorAnoAntigo) ;
  fltSaldoInicial := fTrataValorNuloNumeric(FvrtValorSaldoInicialAntigo) ;

  for intCnt := Low(FarrVrtValorMesAntigo) to High(FarrVrtValorMesAntigo) do
  begin
    arr_meses[intCnt] := fTrataValorNuloNumeric(FarrVrtValorMesAntigo[intCnt]) ;
  end;

  for intCnt := Low(FarrVrtValorSaldoInicialAntigo) to High(FarrVrtValorSaldoInicialAntigo) do
  begin
    arr_saldo_inicial[intCnt] := fTrataValorNuloNumeric(FarrVrtValorSaldoInicialAntigo[intCnt]) ;
  end;

  repeat
    ///soma o valor no nivel sintetico
    strNivelSintetico := FDMemDados.FieldByName('NRE_CTASUP').AsString ;
    if FDMemDados.Locate('NRE_CODREF',strNivelSintetico,[loCaseInsensitive]) then
    begin
      if fValorDiferenteZero(fltValor, fltSaldoInicial) then
      begin
        FDMemDados.Edit ;
        FDMemDados.FieldByName('ANO').AsFloat := FDMemDados.FieldByName('ANO').AsFloat - fltValor ;
        FDMemDados.FieldByName('SALDO_INICIAL').AsFloat := FDMemDados.FieldByName('SALDO_INICIAL').AsFloat - fltSaldoInicial ;
        for intCnt := 1 to 12 do
        begin
          FDMemDados.FieldByName('MES_'+inttostr(intCnt)).AsFloat := FDMemDados.FieldByName('MES_'+inttostr(intCnt)).AsFloat - arr_meses[intCnt-1] ;
          FDMemDados.FieldByName('SALDO_INICIAL_'+inttostr(intCnt)).AsFloat := FDMemDados.FieldByName('SALDO_INICIAL_'+inttostr(intCnt)).AsFloat - arr_saldo_inicial[intCnt-1] ;
        end;
        FDMemDados.FieldByName('SALDO_FINAL').AsFloat := FDMemDados.FieldByName('SALDO_INICIAL').AsFloat + FDMemDados.FieldByName('ANO').AsFloat ;
        FDMemDados.Post ;
      end;
    end;
  until (fEmptyStr(FDMemDados.FieldByName('NRE_CTASUP').AsString));
  FDMemDados.Locate('ID',intId,[loCaseInsensitive]);

end;

procedure TfrmParametrosECF.pTotalizaAno;
var
  ColAno, ColSaldoInicial, ColSaldoFinal : TcxCustomGridTableItem ;
begin
  ColAno := fRetornaColbyFieldName(GridTab, 'ANO') ;
  ColSaldoInicial := fRetornaColbyFieldName(GridTab, 'SALDO_INICIAL') ;
  ColSaldoFinal := fRetornaColbyFieldName(GridTab, 'SALDO_FINAL') ;
  FDMemDados.DisableControls ;
  FDMemDados.AfterPost := nil ;
  try
    FDMemDados.First ;
    while not FDMemDados.Eof do
    begin
      pTotalizaAnoRefGrid(ColAno, ColSaldoInicial, ColSaldoFinal);
      FDMemDados.Next ;
    end;
  finally
    FDMemDados.EnableControls ;
    FDMemDados.AfterPost := FDMemDadosAfterPost ;
  end;
end;

procedure TfrmParametrosECF.pTotalizaAnoRefGrid(ColAno, ColSaldoInicial, ColSaldoFinal: TcxCustomGridTableItem; const blnEmEdicao:boolean=False);
var
  intCnt : integer ;
  strFieldMes : String ;
  ColMes : TcxCustomGridTableItem ;
begin
  if not fColunasGridAssigned(ColAno, ColSaldoInicial, ColSaldoFinal) then
  begin
    exit ;
  end;

  if not blnEmEdicao then
    FDMemDados.Edit ;

  TcxGridDBBandedColumn(ColAno).DataBinding.Field.Clear ;
  TcxGridDBBandedColumn(ColSaldoInicial).DataBinding.Field.Clear ;
  TcxGridDBBandedColumn(ColSaldoFinal).DataBinding.Field.Clear ;
  for intCnt := 0 to GridTab.ColumnCount-1 do
  begin
    if pos('MES_', GridTab.Columns[intCnt].DataBinding.FieldName) > 0 then
    begin
      if GridTab.Columns[intCnt].Visible then
      begin
        TcxGridDBBandedColumn(ColAno).DataBinding.Field.AsFloat := TcxGridDBBandedColumn(ColAno).DataBinding.Field.AsFloat + GridTab.Columns[intCnt].DataBinding.Field.AsFloat ;
      end;
    end;
  end;
  /////saldo inicial
  for intCnt := 0 to GridTab.ColumnCount-1 do
  begin
    if pos('SALDO_INICIAL_', GridTab.Columns[intCnt].DataBinding.FieldName) > 0 then
    begin
      strFieldMes := fReplaceStr(GridTab.Columns[intCnt].DataBinding.FieldName, 'SALDO_INICIAL_', 'MES_') ;
      ColMes := GridTab.GetColumnByFieldName(strFieldMes) ;
      if TcxGridDBBandedColumn(ColMes).Visible then
      begin
        TcxGridDBBandedColumn(ColSaldoInicial).DataBinding.Field.AsFloat := TcxGridDBBandedColumn(ColSaldoInicial).DataBinding.Field.AsFloat + GridTab.Columns[intCnt].DataBinding.Field.AsFloat ;
      end;
    end;
  end;
  ////saldo final
  TcxGridDBBandedColumn(ColSaldoFinal).DataBinding.Field.AsFloat := TcxGridDBBandedColumn(ColSaldoInicial).DataBinding.Field.AsFloat + TcxGridDBBandedColumn(ColAno).DataBinding.Field.AsFloat ;

  if not blnEmEdicao then
    FDMemDados.Post ;
end;

procedure TfrmParametrosECF.pEventoCalculoAnoManual(Sender: TObject);
var
  ColAno, ColSaldoInicial, ColSaldoFinal : TcxCustomGridTableItem ;
begin
  GridTab.DataController.PostEditingData ;
  ColAno := fRetornaColbyFieldName(GridTab, 'ANO') ;
  ColSaldoInicial := fRetornaColbyFieldName(GridTab, 'SALDO_INICIAL') ;
  ColSaldoFinal := fRetornaColbyFieldName(GridTab, 'SALDO_FINAL') ;
  pGuardaValorAntigoAnoMeses ;
  pTotalizaAnoRefGrid(ColAno, ColSaldoInicial, ColSaldoFinal) ;
end;

procedure TfrmParametrosECF.pEventoShowContasPlanoReferencial(Sender: TObject;
  AButtonIndex: Integer);
var
  strCodigosFormula, strFormula : string ;
  frm : TfrmContasContabeisPorPlanoReferencial ;
  ColAno, ColSaldoInicial, ColSaldoFinal, ColFormula : TcxCustomGridTableItem ;
  arrSel : TConsultasArray ;
begin
  strCodigosFormula := FDMemDados.FieldByName(FIELDFORMULA).AsString ;

  if fEmptyStr(strCodigosFormula) then
  begin
    fMensagem('ATENÇÃO!', 'Fórmula vazia!', ['&OK']);
    exit ;
  end;

  ColAno := fRetornaColbyFieldName(GridTab, 'ANO') ;
  ColSaldoInicial := fRetornaColbyFieldName(GridTab, 'SALDO_INICIAL') ;
  ColSaldoFinal := fRetornaColbyFieldName(GridTab, 'SALDO_FINAL') ;

  if AButtonIndex = 0 then
  begin
    pCriarFormularios(TfrmContasContabeisPorPlanoReferencial, frm);
    try
      frm.blnPlanoReferencial := fIsModoPlanoReferencial ;
      frm.strCodigoContas := strCodigosFormula ;
      frm.ShowModal ;
      if frm.ModalResult = idOK then
      begin
        ColFormula := fRetornaColbyFieldName(GridTab, FIELDFORMULA) ;
        if not Assigned(ColFormula) then
        begin
          exit ;
        end;

        pCarregaECFCtaExercicio ;
        arrSel := fVerificaECFCtaExercicio(frm.arrSel) ;
        strFormula := fMontaStringFormula(arrSel, FDMemDados.FieldByName('NRE_CODREF').AsString) ;
        GridTab.DataController.DataSet.Edit ;
        TcxGridDBBandedColumn(ColFormula).DataBinding.Field.AsString := strFormula ;
        ///limpa todas colunas
        pGuardaValorAntigoAnoMeses ;
        pLimpaTodosMeses(True) ;
        TcxGridDBBandedColumn(ColAno).DataBinding.Field.Clear ;
        TcxGridDBBandedColumn(ColSaldoInicial).DataBinding.Field.Clear ;
        TcxGridDBBandedColumn(ColSaldoFinal).DataBinding.Field.Clear ;
        /////recalcula os valores dos meses
        if not fEmptyStr(strFormula) then
        begin
          pCalculoAutomatico(True) ;
          pTotalizaAnoRefGrid(ColAno, ColSaldoInicial, ColSaldoFinal, True) ;
        end;

      end;

    finally
      pFreeAndNil(frm) ;
    end;
  end
  else if AButtonIndex = 1 then
  begin
    FDMemDados.Edit ;
    pGuardaValorAntigoAnoMeses ;
    pLimpaTodosMeses(True) ;
    pCalculoAutomatico(True) ;
    pTotalizaAnoRefGrid(ColAno, ColSaldoInicial, ColSaldoFinal, True) ;
    FDMemDados.Post ;
  end;

end;

function TfrmParametrosECF.fDataInicial: TDate;
Var
  wordDia, wordMes, wordAno: Word;
begin
  wordDia := 1;
  wordMes := StrToInt(LeftStr(mskPeriodoIni.Text, 2));
  wordAno := StrToInt(RightStr(mskPeriodoIni.Text, 4));
  Result := EncodeDate(wordAno, wordMes, wordDia);
end;

procedure TfrmParametrosECF.FDMemDadosAfterPost(DataSet: TDataSet);
begin
  inherited;
  ////depois de alterado recalcula os valores analiticos
  pSomaValorSinteticoPeloAnalitico(False) ;
end;

function TfrmParametrosECF.fEhAgrupamento(strValor1, strValor2: string;
  blnEof: boolean): boolean;
begin
  result := false ;
  if strValor1 <> strValor2 then
    exit ;

  if blnEof then
    exit ;

  result := true ;
end;

function TfrmParametrosECF.fExecutarGeracao: boolean;
begin
  Try
    result := fChamaTelaGravando(fConfirmarECF)
  Except
    On E: Exception Do
    begin
      raise E ;
    end;
  End;
end;

function TfrmParametrosECF.fFiltroCalculoAutomaticoFormula: string;
begin
  result := '' ;
  if FTipoRegistroECF = treDemonstrativo then
  begin
    ///o retorno da função será usada logo após o where, junto com outros filtros já definidos
    result := ' FALSE AND ';
  end;
end;

function TfrmParametrosECF.fFiltroCarregaPlancoDemonstrativo: string;
begin
  result := '' ;
  if FTipoRegistroECF = treDemonstrativo then
  begin
    result := ' AND PLANRE.NRE_CODREF = "-1" ' ;
  end;
end;

function TfrmParametrosECF.fFormulaToList(strFormula: string): TStringList;
begin
  result := TStringList.Create ;
  result.StrictDelimiter := True ;
  result.Delimiter := ',' ;
  result.DelimitedText := strFormula ;
end;

function TfrmParametrosECF.fGetSqlCarregaEcfCta: string;
begin
  if FTipoRegistroECF = treReferencial then
  begin
    Result := '' ;
    Result := Result + ' SELECT ECFCTA.AUTOINCREM, ';
    Result := Result + '        CTA_SEQLAN, ';
    Result := Result + '        CTA_CODCON ';
    Result := Result + ' FROM PLANRE INNER JOIN ECFLAN ON NRE_CODREF = ECF_CODREF ';
    Result := Result + '             INNER JOIN ECFCTA ON ECFLAN.AUTOINCREM = CTA_SEQLAN ';
    Result := Result + ' WHERE ECF_ANOECF = :ECF_ANOECF AND ';
    Result := Result + '       ECF_REGIST = :ECF_REGIST AND ';
    Result := Result + '       NRE_BLCECF = :BLCECF AND ';
    Result := Result + '       NRE_REGECF = :REGECF AND ';
    Result := Result + '       ECF_CODEMP = :ECF_CODEMP ';
    Result := Result + ' ORDER BY CTA_SEQLAN, CTA_CODCON ';
  end
  else
  begin
    Result := '' ;
    Result := Result + ' SELECT ECFCTA.AUTOINCREM, ';
    Result := Result + '         CTA_SEQLAN, ';
    Result := Result + '         CTA_CODCON ';
    Result := Result + ' FROM ECFDEM INNER JOIN ECFLAN ON DEM_CODDEM = ECF_CODREF ';
    Result := Result + '             INNER JOIN ECFCTA ON ECFLAN.AUTOINCREM = CTA_SEQLAN ';
    Result := Result + ' WHERE ECF_ANOECF = :ECF_ANOECF AND ';
    Result := Result + '        ECF_REGIST = :ECF_REGIST AND ';
    Result := Result + '        DEM_BLCECF = :BLCECF AND ';
    Result := Result + '        DEM_REGECF = :REGECF AND ';
    Result := Result + '        ECF_CODEMP = :ECF_CODEMP ';
    Result := Result + ' ORDER BY CTA_SEQLAN, CTA_CODCON ';
  end;
end;

function TfrmParametrosECF.fGetSqlCarregaEcfLan: string;
begin
  if FTipoRegistroECF = treReferencial then
  begin
    Result := '' ;
    Result := Result + '  SELECT NRE_CODREF, ';
    Result := Result + '          NRE_DESCRI, ';
    Result := Result + '          ECFLAN.AUTOINCREM, ';
    Result := Result + '          ECF_TIPECF, ';
    Result := Result + '          ECF_FMTECF, ';
    Result := Result + '          NRE_TIPCTA, ';
    Result := Result + '          NRE_CTASUP, ';
    Result := Result + '          NRE_NIVEL_ ';
    Result := Result + '   FROM PLANRE INNER JOIN ECFREG ON PLANRE.NRE_BLCECF = ECFREG.REG_BLCECF AND PLANRE.NRE_REGECF = ECFREG.REG_REGECF AND ECFREG.AUTOINCREM = :AUTOINCREM ';
    Result := Result + '               LEFT JOIN ECFLAN ON NRE_CODREF = ECF_CODREF AND ';
    Result := Result + '                                   ECF_ANOECF = :ANOECF AND ';
    Result := Result + '                                   ECF_REGIST = CONCAT(REG_BLCECF, REG_REGECF) AND ';
    Result := Result + '                                   ECF_CODEMP = :CODEMP ';
    Result := Result + '  WHERE :ANOECF BETWEEN EXTRACT(YEAR FROM NRE_DTAINI) AND EXTRACT(YEAR FROM COALESCE(NRE_DTAFIN, CAST("9999-01-01" AS DATE))) ';
    Result := Result + '  ORDER BY NRE_CODREF ';
  end
  else ///demonstrativo
  begin
    result := '' ;
    Result := Result + '      SELECT  DEM_CODDEM AS NRE_CODREF, ';
    Result := Result + '          DEM_DESCRI AS NRE_DESCRI, ';
    Result := Result + '          ECFLAN.AUTOINCREM, ';
    Result := Result + '          ECF_TIPECF, ';
    Result := Result + '          ECF_FMTECF, ';
    Result := Result + '          DEM_TIPDEM AS NRE_TIPCTA, ';
    Result := Result + '          CAST(NULL AS CHAR(20)) AS NRE_CTASUP, ';
    Result := Result + '          CAST(NULL AS UNSIGNED) AS NRE_NIVEL_ ';
    Result := Result + '   FROM ECFDEM INNER JOIN ECFREG ON ECFDEM.DEM_BLCECF = ECFREG.REG_BLCECF AND ECFDEM.DEM_REGECF = ECFREG.REG_REGECF AND ECFREG.AUTOINCREM = :AUTOINCREM ';
    Result := Result + '               LEFT JOIN ECFLAN ON DEM_CODDEM = ECF_CODREF AND ';
    Result := Result + '                                   ECF_ANOECF = :ANOECF AND ';
    Result := Result + '                                   ECF_REGIST = CONCAT(REG_BLCECF, REG_REGECF) AND ';
    Result := Result + '                                   ECF_CODEMP = :CODEMP ';
    Result := Result + '  WHERE :ANOECF BETWEEN EXTRACT(YEAR FROM DEM_DTAINI) AND EXTRACT(YEAR FROM COALESCE(DEM_DTAFIN, CAST("9999-01-01" AS DATE))) ';
    Result := Result + '  ORDER BY DEM_CODDEM ';
  end;
end;

function TfrmParametrosECF.fGetSqlCarregaEcfMes: string;
begin
  if FTipoRegistroECF = treReferencial then
  begin
    Result := '' ;
    Result := Result + ' SELECT ECFMES.AUTOINCREM, ';
    Result := Result + '   MES_SEQLAN, ';
    Result := Result + '   MES_MESECF, ';
    Result := Result + '   MES_VLRECF ';
    Result := Result + ' FROM PLANRE INNER JOIN ECFREG ON PLANRE.NRE_BLCECF = ECFREG.REG_BLCECF AND PLANRE.NRE_REGECF = ECFREG.REG_REGECF AND ECFREG.AUTOINCREM = :AUTOINCREM ';
    Result := Result + '        INNER JOIN ECFLAN ON NRE_CODREF = ECF_CODREF ';
    Result := Result + ' 		  AND ECF_REGIST = CONCAT(REG_BLCECF, REG_REGECF) ';
    Result := Result + '        INNER JOIN ECFMES ON ECFLAN.AUTOINCREM = MES_SEQLAN ';
    Result := Result + ' WHERE ECF_ANOECF = :ANOECF ';
    Result := Result + '  AND ECF_CODEMP = :CODEMP ';
    Result := Result + '  AND LAST_DAY(STR_TO_DATE(CONCAT(CAST(ECF_ANOECF AS CHAR(4)),"-",CAST(MES_MESECF AS CHAR(2)),"-","01"), "%Y-%m-%d")) BETWEEN NRE_DTAINI AND COALESCE(NRE_DTAFIN, CAST("9999-01-01" AS DATE)) ';
    Result := Result + ' ORDER BY MES_SEQLAN, MES_MESECF ';
  end
  else
  begin
    Result := '' ;
    Result := Result + '  SELECT ECFMES.AUTOINCREM, ';
    Result := Result + '    MES_SEQLAN, ';
    Result := Result + '    MES_MESECF, ';
    Result := Result + '    MES_VLRECF ';
    Result := Result + '  FROM ECFDEM INNER JOIN ECFREG ON ECFDEM.DEM_BLCECF = ECFREG.REG_BLCECF AND ECFDEM.DEM_REGECF = ECFREG.REG_REGECF AND ECFREG.AUTOINCREM = :AUTOINCREM ';
    Result := Result + '         INNER JOIN ECFLAN ON DEM_CODDEM = ECF_CODREF ';
    Result := Result + '  		  AND ECF_REGIST = CONCAT(REG_BLCECF, REG_REGECF) ';
    Result := Result + '         INNER JOIN ECFMES ON ECFLAN.AUTOINCREM = MES_SEQLAN ';
    Result := Result + '  WHERE ECF_ANOECF = :ANOECF ';
    Result := Result + '   AND ECF_CODEMP = :CODEMP ';
    Result := Result + '   AND LAST_DAY(STR_TO_DATE(CONCAT(CAST(ECF_ANOECF AS CHAR(4)),"-",CAST(MES_MESECF AS CHAR(2)),"-","01"), "%Y-%m-%d")) BETWEEN DEM_DTAINI AND COALESCE(DEM_DTAFIN, CAST("9999-01-01" AS DATE)) ';
    Result := Result + '  ORDER BY MES_SEQLAN, MES_MESECF ';
  end;
end;

function TfrmParametrosECF.fGetSqlInsertECFCnf: string;
var
  strSql:string ;
begin
  strSql := '' ;
  strSql := strSql + ' INSERT INTO ECFCNF ' ;
  strSql := strSql + ' (AUTOINCREM, ' ;
  strSql := strSql + '  CNF_CODEMP, ' ;
  strSql := strSql + '  CNF_ANOECF, ' ;
  strSql := strSql + '  CNF_REGIST, ' ;
  strSql := strSql + '  CNF_EMPGRP ' ;
  strSql := strSql + '  ) ' ;
  strSql := strSql + ' VALUES ' ;
  strSql := strSql + ' (:AUTOINCREM, ' ;
  strSql := strSql + '  :CODEMP, ' ;
  strSql := strSql + '  :ANOECF, ' ;
  strSql := strSql + '  :REGIST, ' ;
  strSql := strSql + '  :EMPGRP) ; ' ;
  result := strSql ;
end;

function TfrmParametrosECF.fGetSqlInsertECFCta: string;
var
  strSql:string ;
begin
  strSql := '' ;
  strSql := strSql + ' INSERT INTO ECFCTA ' ;
  strSql := strSql + ' (AUTOINCREM, ' ;
  strSql := strSql + ' CTA_SEQLAN, ' ;
  strSql := strSql + ' CTA_CODCON) ' ;
  strSql := strSql + ' VALUES ' ;
  strSql := strSql + ' (:AUTOINCREM, ' ;
  strSql := strSql + ' :SEQLAN, ' ;
  strSql := strSql + ' :CODCON) ; ' ;
  result := strSql ;
end;

function TfrmParametrosECF.fGetSqlInsertECFLan: string;
var
  strSql:string ;
begin
  strSql := '' ;
  strSql := strSql + ' INSERT INTO ECFLAN ' ;
  strSql := strSql + ' (AUTOINCREM, ' ;
  strSql := strSql + ' ECF_CODREF, ' ;
  strSql := strSql + ' ECF_CODEMP, ' ;
  strSql := strSql + ' ECF_TIPECF, ' ;
  strSql := strSql + ' ECF_FMTECF, ' ;
  strSql := strSql + ' ECF_ANOECF, ' ;
  strSql := strSql + ' ECF_REGIST) ' ;
  strSql := strSql + ' VALUES ' ;
  strSql := strSql + ' (:AUTOINCREM, ' ;
  strSql := strSql + ' :CODREF, ' ;
  strSql := strSql + ' :CODEMP, ' ;
  strSql := strSql + ' :TIPECF, ' ;
  strSql := strSql + ' :FMTECF, ' ;
  strSql := strSql + ' :ANOECF, ' ;
  strSql := strSql + ' :REGIST); ' ;
  result := strSql ;
end;

function TfrmParametrosECF.fGetSqlInsertECFMes: string;
var
  strSql:string ;
begin
  strSql := '' ;
  strSql := strSql + ' INSERT INTO ECFMES ' ;
  strSql := strSql + ' (AUTOINCREM, ' ;
  strSql := strSql + ' MES_SEQLAN, ' ;
  strSql := strSql + ' MES_MESECF, ' ;
  strSql := strSql + ' MES_VLRECF) ' ;
  strSql := strSql + ' VALUES ' ;
  strSql := strSql + ' ( ' ;
  strSql := strSql + ' :AUTOINCREM, ' ;
  strSql := strSql + ' :SEQLAN, ' ;
  strSql := strSql + ' :MESECF, ' ;
  strSql := strSql + ' :VLRECF ' ;
  strSql := strSql + ' ) ; ' ;
  result := strSql ;
end;

function TfrmParametrosECF.fGetSqlInsertEcfSld: string;
var
  strSql:string ;
begin
  strSql := '' ;
  strSql := strSql + ' INSERT INTO ECFSLD ' ;
  strSql := strSql + ' (AUTOINCREM, ' ;
  strSql := strSql + ' SLD_CODREF, ' ;
  strSql := strSql + ' SLD_CODEMP, ' ;
  strSql := strSql + ' SLD_SLDINI, ' ;
  strSql := strSql + ' SLD_ANOECF, ' ;
  strSql := strSql + ' SLD_REGIST) ' ;
  strSql := strSql + ' VALUES ' ;
  strSql := strSql + ' (:AUTOINCREM, ' ;
  strSql := strSql + ' :CODREF, ' ;
  strSql := strSql + ' :CODEMP, ' ;
  strSql := strSql + ' :SLDINI, ' ;
  strSql := strSql + ' :ANOECF, ' ;
  strSql := strSql + ' :REGIST); ' ;
  result := strSql ;
end;

function TfrmParametrosECF.fGravaEcfCnf: boolean;
var
  intCnt : integer ;
  qryExec : TUniQuery ;
  strAutoInc : string ;
  strSql : string ;
begin

  strSql := '' ;
  strSql := strSql + 'DELETE FROM ECFCNF WHERE CNF_CODEMP = :CODEMP ' ;
  strSql := strSql + ' AND CNF_ANOECF = :ANOECF ' ;
  strSql := strSql + ' AND CNF_REGIST = :REGIST' ;

  qryExec := fCriaQuery ;
  try
    ////limpa as configurações antigas
    qryExec.Close ;
    qryExec.SQL.Clear ;
    qryExec.SQL.Add(strSql) ;
    qryExec.ParamByName('ANOECF').AsInteger := fRetornaAnoECF ;
    qryExec.ParamByName('REGIST').AsString := fRetornaRegistroECF ;
    qryExec.ParamByName('CODEMP').AsString := edtCodEmp.Text ;
    qryExec.ExecSQL ;
    ////grava as novas configurações
    qryExec.Close ;
    qryExec.SQL.Clear ;
    qryExec.SQL.Text := fGetSqlInsertECFCnf ;
    for intCnt := 0 to TreeEmpCad.Count - 1 do
    begin
      if (not TreeEmpCad.Items[intCnt].Values[0]) then
      begin
        strAutoInc := fRetAutoIncrem('ECFCNF', edtCodEmp.Text) ;
        qryExec.ParamByName('AUTOINCREM').AsString := strAutoInc ;
        qryExec.ParamByName('ANOECF').AsInteger := fRetornaAnoECF ;
        qryExec.ParamByName('REGIST').AsString := fRetornaRegistroECF ;
        qryExec.ParamByName('CODEMP').AsString := edtCodEmp.Text ;
        qryExec.ParamByName('EMPGRP').AsString := copy(TreeEmpCad.Items[intCnt].Values[1], 1, 3) ;
        qryExec.ExecSQL ;
      end;
    end;
  finally
    FreeAndNil(qryExec) ;
  end;
  result := true ;
end;

function TfrmParametrosECF.fIniciadoECF: boolean;
begin
  result := pnlDados.Visible ;
end;

function TfrmParametrosECF.fInsertECFLan(strCodRef, strCodEmp, strTipEcf,
  strFmtEcf: string; intAnoEcf: Integer; strRegistro: string;
  const strAutoIncLan:string): string;
begin
  qryEcfLanExec.ParamByName('AUTOINCREM').AsString := strAutoIncLan ;
  qryEcfLanExec.ParamByName('CODREF').AsString := strCodRef ;
  qryEcfLanExec.ParamByName('CODEMP').AsString := strCodEmp ;
  qryEcfLanExec.ParamByName('TIPECF').AsString := strTipEcf ;
  qryEcfLanExec.ParamByName('FMTECF').AsString := strFmtEcf ;
  qryEcfLanExec.ParamByName('ANOECF').Asinteger := intAnoEcf ;
  qryEcfLanExec.ParamByName('REGIST').AsString := strRegistro ;
  qryEcfLanExec.ExecSQL ;
  result := fNextAutoIncrem(strAutoIncLan) ;
end;

function TfrmParametrosECF.fIsAssignedProgresso(
  pgbProgresso: TcxProgressBar): boolean;
begin
  result := false ;
  if not Assigned(pgbProgresso) then
    exit ;

  if not Assigned(GetParentForm(pgbProgresso).FindComponent('lblGravando')) then
    exit ;

  result := true ;
end;

function TfrmParametrosECF.fIsGrupoStringFormula(const blnCodPlanre,
  blnNotEof: boolean): boolean;
begin
  result := False ;
  if not blnCodPlanre then
    exit ;

  if not blnNotEof then
    exit ;

  result := True ;
end;

function TfrmParametrosECF.fIsModoPlanoReferencial: boolean;
begin
  result := FTipoRegistroECF = treReferencial ;
end;

function TfrmParametrosECF.fMontaStringFormula(strSeqLan: string; const strCodPlanre:string): string;
var
  arrSel : TConsultasArray ;
  strIndNameAnt : string ;
begin
  result := '' ;
  SetLength(arrSel, 0);
  if cdsPlacoPlanre.FindKey([strCodPlanre]) then
  begin
    while fIsGrupoStringFormula(cdsPlacoPlanre.FieldByName('NCO_CTAREF').AsString = strCodPlanre, not cdsPlacoPlanre.Eof) do
    begin
      SetLength(arrSel, Length(arrSel)+1);
      arrSel[High(arrSel)].strCodigo := cdsPlacoPlanre.FieldByName('NCO_CODCON').AsString ;
      cdsPlacoPlanre.Next ;
    end;
  end;

  if not fEmptyStr(strSeqLan) then
  begin
    if qryEcfCta.Locate('CTA_SEQLAN', strSeqLan, [loCaseInsensitive] ) then
    begin
      strIndNameAnt := cdsPlacoPlanre.IndexName ;
      cdsPlacoPlanre.IndexName := 'NCO_CTAREF_NCO_CODCON' ;
      try
        while fEhAgrupamento(qryEcfCta.FieldByName('CTA_SEQLAN').AsString, strSeqLan, qryEcfCta.Eof) do
        begin
          ///ignora os registro que já estão no cds para evitar duplicação
          //if cdsPlacoPlanre.Locate('NCO_CTAREF;NCO_CODCON',VarArrayOf([strCodPlanre, qryEcfCta.FieldByName('CTA_CODCON').AsString]),[loCaseInsensitive]) then
          if cdsPlacoPlanre.FindKey([strCodPlanre, qryEcfCta.FieldByName('CTA_CODCON').AsString]) then
          begin
            qryEcfCta.Next ;
            Continue ;
          end;
          SetLength(arrSel, Length(arrSel)+1);
          arrSel[High(arrSel)].strCodigo := qryEcfCta.FieldByName('CTA_CODCON').AsString ;
          qryEcfCta.Next ;
        end;
      finally
        cdsPlacoPlanre.IndexName := strIndNameAnt ;
      end;
    end;
  end;
  result := fMontaStringFormula(arrSel, strCodPlanre) ;
  SetLength(arrSel, 0);
end;

function TfrmParametrosECF.fCarregaDadosEcf: boolean;
begin
  try
    pCarregaEcfLan(edtCodEmp.Text) ;
    pCarregaEcfMes(edtCodEmp.Text) ;
    pCarregaEcfCta(edtCodEmp.Text) ;
  except
    on E: Exception do
    begin
      result := false ;
      pMensagensErro(e.Message, '[fCarregaDadosEcf]');
      exit ;
    end;
  end;

  result := true ;
end;

function TfrmParametrosECF.fColunasGridAssigned(ColAno, ColSaldoInicial,
  ColSaldoFinal: TcxCustomGridTableItem): boolean;
begin
  result := false ;
  if not Assigned(ColAno) then
  begin
    exit ;
  end;

  if not Assigned(ColSaldoInicial) then
  begin
    exit ;
  end;

  if not Assigned(ColSaldoFinal) then
  begin
    exit ;
  end;
  result := true ;
end;

function TfrmParametrosECF.fConcatStringEcf(strOriginal, strValor: string): string;
begin
  result := strOriginal ;
  if fEmptyStr(result) then
  begin
    result := strValor ;
  end
  else
  begin
    result := result + #13+#10 + strValor ;
  end;
end;

function TfrmParametrosECF.fConfirmarECF(pgbProgresso: TcxProgressBar): Boolean;
var
  strRegistro : string ;
begin
  Result := True;
  strRegistro := fRetornaRegistroECF ;
  pSetaTextoProgresso(pgbProgresso, 'Gerando' + ' Lançamentos: ' + strRegistro);

  pgbProgresso.Properties.Max := fdMemDados.RecordCount;

  fStartTransaction;
  try
    /////montar função para exclusão dos dados anteriores.
    pApagaLancamentos ;
    fGravaEcfCnf ;
    /////realiza os novos lançamentos
    pGravaLancamentos(pgbProgresso) ;
    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      raise E ;
    End;
  End;

end;

function TfrmParametrosECF.fConfirmaSobreEscreverFormula: boolean;
begin
  result := false ;
  if not fEmptyStr(FDMemDados.FieldByName(FIELDFORMULA).AsString) then
  begin
    if fMensagem('ATENÇÃO!', 'Ao adicionar novas contas, você pederá a fórmula antiga. ' + #13#10 +
                    'Deseja continuar? ', ['&Sim', '&Não'], 1) = 2 then
    begin
      Exit;
    end;
  end;
  result := true ;
end;

function TfrmParametrosECF.fContMesColGrid: integer;
var
  intCnt : integer ;
begin
  result := 0 ;
  for intCnt := 0 to GridTab.ColumnCount-1 do
  begin
    if GridTab.Columns[intCnt].Visible then
    begin
      if pos('MES_', TcxGridDBBandedColumn(GridTab.Columns[intCnt]).DataBinding.FieldName) > 0 then
      begin
        result := result + 1 ;
      end;
    end;
  end;
end;

function TfrmParametrosECF.fCountCtaFormulaManual: Integer;
var
  strFormula, strIndNameAnt : string ;
  lstAux : TStringList ;
  intCnt : integer ;
begin
  result := 0 ;
  FDMemDados.First ;
  strIndNameAnt := cdsPlacoPlanre.IndexName ;
  cdsPlacoPlanre.IndexName := 'NCO_CODCON' ;
  try
    while not FDMemDados.Eof do
    begin
      strFormula := FDMemDados.FieldByName(FIELDFORMULA).AsString ;
      if not fEmptyStr(strFormula) then
      begin
        lstAux := fFormulaToList(strFormula) ;
        try
          for intCnt := 0 to lstAux.Count-1 do
          begin
            if not cdsPlacoPlanre.FindKey([lstAux.Strings[intCnt]]) then
            begin
              result := result + 1 ;
            end;
          end;
        finally
          lstAux.Free ;
        end;
      end;
      FDMemDados.Next ;
    end;
    FDMemDados.First ;
  finally
    cdsPlacoPlanre.IndexName := strIndNameAnt ;
  end;
end;

function TfrmParametrosECF.fDataFinal: TDate;
Var
  wordDia, wordMes, wordAno: Word;
  auxData : TDateTime ;
begin
  wordDia := 1;
  wordMes := StrToInt(LeftStr(mskPeriodoFin.Text, 2));
  wordAno := StrToInt(RightStr(mskPeriodoFin.Text, 4));
  auxData := EncodeDate(wordAno, wordMes, wordDia);
  auxData := IncMonth(auxData) ;
  result := IncDay(auxData, -1) ;
end;

procedure TfrmParametrosECF.pSetaTextoProgresso(pgbProgresso: TcxProgressBar; strTexto: String);
begin
  if fIsAssignedProgresso(pgbProgresso) then
  Begin
    TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption := strTexto;
    Application.ProcessMessages;
  End;
end;

function TfrmParametrosECF.fTemMovimento: boolean;
var
  qryDados : TUniQuery;

  strCodEmp : string ;
  intAno : integer ;
  strRegistro : string ;
begin
  qryDados := fCriaQuery(Self);
  try
    strCodEmp := edtCodEmp.Text ;
    intAno := fRetornaAnoECF ;
    strRegistro := fRetornaRegistroECF ;

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Text := 'SELECT AUTOINCREM FROM ECFLAN where ECF_CODEMP = :CODEMP AND ECF_ANOECF = :ANOECF AND ECF_REGIST = :REGIST LIMIT 1' ;
    qryDados.ParamByName('CODEMP').AsString := strCodEmp ;
    qryDados.ParamByName('ANOECF').AsInteger := intAno ;
    qryDados.ParamByName('REGIST').AsString := strRegistro ;
    qryDados.Open;
    Result := not qryDados.isEmpty ;
  finally
    FreeAndNil(qryDados);
  end;
end;

function TfrmParametrosECF.fTrataValorNuloNumeric(
  const vrtValor: variant): double;
begin
  if VarIsNull(vrtValor) then
  begin
    result := 0.00 ;
  end
  else
  begin
    result := vrtValor ;
  end;
end;

function TfrmParametrosECF.fRetornaColbyFieldName(Sender: TcxCustomGridTableView; FieldName: String): TcxCustomGridTableItem;
var
  strColunaFormula : string ;
begin
  strColunaFormula := Sender.Name+FieldName ;
  result := Sender.FindItemByName(strColunaFormula) ;
end;

function TfrmParametrosECF.fRetornaEmpCadSelecionada: string;
var
  strRetorno : string ;
  intCnt : integer ;
begin
  strRetorno := '' ;

  for intCnt := 0 to TreeEmpCad.Count - 1 do
  begin
    if TreeEmpCad.Items[intCnt].Values[0] then
    begin
      if fEmptyStr(strRetorno) then
      begin
        strRetorno := quotedstr(copy(TreeEmpCad.Items[intCnt].Values[1], 1, 3)) ;
      end
      else
      begin
        strRetorno := strRetorno + ',' + quotedstr(copy(TreeEmpCad.Items[intCnt].Values[1], 1, 3)) ;
      end;
    end;
  end;

  if fEmptyStr(strRetorno) then
    strRetorno := quotedstr('-1') ;
  result := strRetorno ;
end;

end.
