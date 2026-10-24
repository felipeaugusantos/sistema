unit untRelBalancoEstoqueDiferenca;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, Mask, MaskEditFocus, frxDesgn, frxClass,
  frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML, frxExportXLS,
  frxExportRTF, RLFilters, RLDraftFilter, AppEvnts, Menus, untTypesSistema,
  StdCtrls, EditFocus, QColorLabel, ExtCtrls, Buttons,untFuncoesSimples,
  Uni, StrUtils,  BitBtnLockedIncrem, ComObj, ComCtrls, untExcel,
  untGeraExcel, DB, untCadLote, frxExportCSVTestabilidade, ComboBoxFocus, untZClient, untBalancoEstoqueManutencao;

type
  TfrmRelBalancoEstoqueDiferenca = class(TfrmPaiRelatorio)
    mskLinhaGrupo: TMaskEditFocus;
    edtDesGrupo: TEditFocus;
    edtLocIni: TEditFocus;
    edtLocFin: TEditFocus;
    Label8: TLabel;
    Label1: TLabel;
    Label6: TLabel;
    frxRelDiferencaM: TfrxReport;
    frxRelDiferencaJ: TfrxReport;
    Shape1: TShape;
    frxRelDiferencaGmlM: TfrxReport;
    frxRelDiferencaGmlJ: TfrxReport;
    frxRelDiferencaJ2: TfrxReport;
    frxRelDiferencaGmlM2: TfrxReport;
    frxRelDiferencaGmlJ2: TfrxReport;
    frxRelDiferencaM2: TfrxReport;
    Label2: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    rdgMostrar: TRadioGroup;
    grbOpcoes: TGroupBox;
    ckbNumeroLote: TCheckBox;
    ckbLocalizacaoFisica: TCheckBox;
    ckbSuperEstoque: TCheckBox;
    rdgOrdem: TRadioGroup;
    svdExcel: TSaveDialog;
    pgbProgresso: TProgressBar;
    ColorLabel2: TColorLabel;
    ColorLabel3: TColorLabel;
    shaImprime: TShape;
    lblPermImp: TLabel;
    rdgImpIte: TRadioGroup;
    edtSupEstFin: TEditFocus;
    edtSupEstIni: TEditFocus;
    Label3: TLabel;
    Label4: TLabel;
    chkSemDif: TCheckBox;
    frxRelDiferencaResJ: TfrxReport;
    frxRelDiferencaGmlResJ: TfrxReport;
    frxRelDiferencaResM: TfrxReport;
    frxRelDiferencaGmlResM: TfrxReport;
    rdgTipo: TGroupBox;
    rdgStatus: TRadioGroup;
    chkSalCon_SalEst: TCheckBox;
    cbbTipo: TComboBoxFocus;
    lblDigita: TLabel;
    edtCodDig: TEditFocus;
    edtNomDig: TEditFocus;
    Label5: TLabel;
    edtCodMarca: TEditFocus;
    edtNomMarca: TEditFocus;
    edtCodDep: TEditFocus;
    Label9: TLabel;
    edtDesDep: TEditFocus;
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtDestinoExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtLocIniKeyPress(Sender: TObject; var Key: Char);
    procedure edtLocFinKeyPress(Sender: TObject; var Key: Char);
    procedure cbbTipoSelect(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodDigKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDigExit(Sender: TObject);
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodMarcaExit(Sender: TObject);
    procedure edtCodMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDepExit(Sender: TObject);
  private
    intConEst, intTipRel: Integer;
    objCadLot: TCadLot;
    blnCadLoc: Boolean;
    blnArmazem :Boolean;

    strDigitador: String;
    strLinMar: String;

    arrDigitador: TConsultasArray;


    procedure pGeraExcel(qryDados: TDataSet);
    procedure pMontaResumo(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);
    procedure pSomaTotais(var Totais: TTotais; Dados: TDataSet);
    procedure pVerdeVermelho(lblPermImp: TLabel; shaImprime: TShape; blnLiberado: Boolean);

    { Private declarations }
  public
    { Public declarations }
    blnImpressaoDireta: Boolean;
    arrLinhaGrupo,
    arrCodDep,
    arrDepto,
    arrFornecedor: TConsultasArray;
    arrMarca: TConsultasArray;
    strLinGrupo,
    strFornec,
    strCodDep: String;

    class function fGetSQLPED_VENDA_GARANTIA_NAO_COLETADA: string;
    Class Function fCarregaDiferencas(cdsGen : TZClient;
                                      blnMapaContagem: Boolean;
                                      mskLinhaGrupo: TMaskEditFocus;
                                      edtLocIni,
                                      edtLocFin,
                                      edtSupEstIni,
                                      edtSupEstFin,
                                      edtCodFor,
                                      edtCodDig,
                                      edtCodDep,
                                      edtCodMarca: TEditFocus;
                                      arrLinhaGrupo,
                                      arrFornecedor,
                                      arrDigitador,
                                      arrCodDep,
                                      arrMarca: TConsultasArray;
                                      rdgStatus,
                                      rdgImpIte,
                                      rdgOrdem: TRadioGroup;
                                      chkSemDif: TCheckBox;
                                      cbbTipo: TComboBoxFocus): Boolean;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmRelBalancoEstoqueDiferenca: TfrmRelBalancoEstoqueDiferenca;

implementation

uses untFuncoesConsulta, untConsultas,
     untCfgRel,  System.UITypes;


{$R *.dfm}

procedure TfrmRelBalancoEstoqueDiferenca.mskLinhaGrupoKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, nil, Key, arrLinhaGrupo, False) Then
  Begin
    fvalidaCampos(mskLinhaGrupo,False);
    self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelBalancoEstoqueDiferenca.mskLinhaGrupoExit(
  Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinhaGrupo,edtDesGrupo,arrLinhaGrupo,fRetNomeLinhaGrupo,Nil,'da linha/grupo',6);
end;


Class Function TfrmRelBalancoEstoqueDiferenca.fCarregaDiferencas(cdsGen : TZClient;
                                                                 blnMapaContagem: Boolean;
                                                                 mskLinhaGrupo: TMaskEditFocus;
                                                                 edtLocIni,
                                                                 edtLocFin,
                                                                 edtSupEstIni,
                                                                 edtSupEstFin,
                                                                 edtCodFor,
                                                                 edtCodDig,
                                                                 edtCodDep,
                                                                 edtCodMarca : TEditFocus;
                                                                 arrLinhaGrupo,
                                                                 arrFornecedor,
                                                                 arrDigitador,
                                                                 arrCodDep,
                                                                 arrMarca: TConsultasArray;
                                                                 rdgStatus,
                                                                 rdgImpIte,
                                                                 rdgOrdem: TRadioGroup;
                                                                 chkSemDif: TCheckBox;
                                                                 cbbTipo: TComboBoxFocus): Boolean;
  Var
    strSql : String;
    blnEntFut : Boolean;
    blnArmazem :Boolean;
    blnResumido: Boolean;
    intConEst: Integer;
    strFornec,
    strCodDep,
    strLinMar,
    strLinGrupo: String;
    GerenciaBalancoEstoqueManutencao : TGerenciaBalancoEstoqueManutencao;
Begin
  If TGerenciaBalancoEstoqueManutencao.fUtilizaRecurso Then
    GerenciaBalancoEstoqueManutencao := TGerenciaBalancoEstoqueManutencao.pIniciaProcesso;
  Try
  intConEst  := fCfgSis('CONEST');
  blnEntFut  := fCfgSis('ENTFUT', varBoolean);
  blnArmazem := fCfgSis('CTLEST') = '2';

  If blnMapaContagem Then
    blnResumido := False
  Else
    blnResumido := cbbTipo.ItemIndex = 1;

  strSql := '';
  strSql := strSql + ' SELECT ';

  If blnMapaContagem Then
  Begin
    strSql := strSql + ' H.ITE_DTACON   AS H_DTACON, ';
    strSql := strSql + ' H.ITE_HORCON   AS H_HORCON, ';
    strSql := strSql + ' H.ITE_CONTAG   AS H_CONTAG, ';
    strSql := strSql + ' H.ITE_SALCON   AS H_SALCON, ';
    strSql := strSql + ' H.ITE_GMLCON   AS H_GMLCON, ';
    strSql := strSql + ' H.ITE_CODOPE   AS H_CODOPE, ';
    strSql := strSql + ' OPE_NOMOPE     AS H_NOMOPE, ';

    strSql := strSql + ' TMP.ITE_SALCON AS SALCON_FINAL, ';
    strSql := strSql + ' TMP.ITE_GMLCON AS GMLCON_FINAL, ';
    strSql := strSql + ' TMP.RESGAR + TMP.GARCOL AS RESGAR, ';
    strSql := strSql + ' TMP.SALMAN AS SALMAN, ';
    strSql := strSql + ' TMP.BEACCS AS BEACCS, ';
  End;

  strSql := strSql + '   TMP.ITE_NUMLOT, TMP.ITE_CODITE, TMP.ITE_DESITE, TMP.ITE_ORDCON, ';
  strSql := strSql + '   TMP.ITE_REFERE, TMP.ITE_CODFAB, TMP.ITE_CODBAR, TMP.UNI_SIGUNI, ';
  strSql := strSql + '   TMP.ITE_LOCSUP, TMP.ITE_LOCFIS, TMP.MAR_DESMAR, TMP.ITE_PRECUS, ';
  strSql := strSql + '   TMP.ITE_DIFSAL, TMP.ITE_DIF_ML, TMP.ITE_DIFVAL, ';
  strSql := strSql + '   TMP.ITE_DIFVML, TMP.ITE_SAL_ML, TMP.ITE_GMLCON, ';

  If blnResumido Then
  Begin
    strSql := strSql + '   SUM(TMP.ITE_SALDOS + TMP.ITE_ENTFUT) AS ITE_SALDOS,';
    strSql := strSql + '   SUM(TMP.ITE_SALCON + TMP.RESGAR +  TMP.SALMAN + TMP.BEACCS+ TMP.GARCOL) AS ITE_SALCON, ';
  End
  Else
  Begin
    strSql := strSql + '   (TMP.ITE_SALDOS + TMP.ITE_ENTFUT) AS ITE_SALDOS,';
    strSql := strSql + '   (TMP.ITE_SALCON + TMP.RESGAR + TMP.GARCOL) AS ITE_SALCON, ';
  End;

  strSql := strSql + '   (TMP.ITE_DIFERE + TMP.RESGAR + TMP.SALMAN + TMP.BEACCS + TMP.GARCOL - TMP.ITE_ENTFUT) AS ITE_DIFERE, ';
  strSql := strSql + '   TMP.ITE_CNV_ML, ';
  strSql := strSql + '   (TMP.ITE_DIFERE + TMP.RESGAR + TMP.SALMAN  + TMP.BEACCS + TMP.GARCOL - TMP.ITE_ENTFUT) * TMP.ITE_PRECUS AS ITE_VALDIF, ';

  strSql := strSql + '   (((TMP.ITE_DIFERE + TMP.RESGAR + TMP.SALMAN + TMP.BEACCS + TMP.GARCOL - TMP.ITE_ENTFUT) * TMP.ITE_PRECUS) + TMP.ITE_VLDGML) AS ITE_VAL_DIF1, ';
  strSql := strSql + '   (TMP.ITE_DIFVAL - TMP.ITE_DIFVML) AS ITE_VAL_DIF2, ';

  strSql := strSql + '   TMP.ITE_DIFGML, ';
  strSql := strSql + '   TMP.ITE_VLDGML  ';

  If (blnArmazem) Then
    strSql := strSql + ',  TMP.AMZ_DESCRI ';

  strSql := strSql + ' FROM ( ';

  strSql := strSql + ' SELECT                                  ';
  strSql := strSql + ' 	 SQL_NO_CACHE                          ';
  strSql := strSql + ' 	 IFNULL(LOT_NUMLOT, "") AS ITE_NUMLOT, ';
  strSql := strSql + ' 	 G.ITE_CODITE           AS ITE_CODITE, ';
  strSql := strSql + ' 	 G.ITE_ORDCON           AS ITE_ORDCON, ';
  strSql := strSql + ' 	 I.ITE_DESITE           AS ITE_DESITE, ';
  strSql := strSql + ' 	 I.ITE_REFERE           AS ITE_REFERE, ';
  strSql := strSql + ' 	 I.ITE_CODBAR           AS ITE_CODBAR, ';
  strSql := strSql + ' 	 I.ITE_CODFAB           AS ITE_CODFAB, ';
  strSql := strSql + ' 	 U.UNI_SIGUNI           AS UNI_SIGUNI, ';
  strSql := strSql + ' 	 G.ITE_LOCSUP           AS ITE_LOCSUP, ';
  strSql := strSql + ' 	 IFNULL(IF(LOT_NUMLOT IS NULL, G.ITE_LOCFIS, LOT_LOCFIS), "")  AS ITE_LOCFIS, ';
  strSql := strSql + ' 	 MA.MAR_DESMAR           AS MAR_DESMAR, ';
  strSql := strSql + ' 	 G.ITE_PRECUS           AS ITE_PRECUS, ';

  strSql := strSql + ' 	 IF(LOT_NUMLOT IS NULL, -G.ITE_DIFSAL, -LOT_DIFSAL) AS ITE_DIFSAL, ';
  strSql := strSql + ' 	 IF(LOT_NUMLOT IS NULL, -G.ITE_DIF_ML, 0)           AS ITE_DIF_ML, ';

  strSql := strSql + ' 	 (IF(LOT_NUMLOT IS NULL, - G.ITE_DIFSAL, - LOT_DIFSAL) * G.ITE_PRECUS) AS ITE_DIFVAL, ';
  strSql := strSql + '   IF(LOT_NUMLOT IS NULL, (IF(I.ITE_CNV_ML > 0, (G.ITE_PRECUS / I.ITE_CNV_ML), 0) * G.ITE_DIF_ML), 0) AS ITE_DIFVML, ';

  If fCfgSis('ESTEXT', varBoolean) Then
    strSql := strSql + ' 	 IF(LOT_NUMLOT IS NULL, G.ITE_SALDOS - IF((G.ITE_SALEXT < 0) OR (G.ITE_SALEXT IS NULL), 0, G.ITE_SALEXT), LOT_SALDOS) AS ITE_SALDOS, '
  Else
    strSql := strSql + ' 	 IF(LOT_NUMLOT IS NULL, G.ITE_SALDOS, LOT_SALDOS) AS ITE_SALDOS, ';
  strSql := strSql + ' 	 IF(LOT_NUMLOT IS NULL, G.ITE_SALCON, LOT_SALCON) AS ITE_SALCON, ';

  if fCfgSis('ESTAJU', varInteger) = 2 then
    strSql := strSql + ' 	 IF(LOT_NUMLOT IS NULL, IFNULL(G.ITE_SALREG, 0), IFNULL(LOT_SALREG, 0)) AS RESGAR, '
  Else
    strSql := strSql + '0 AS RESGAR, ';


  if fCfgSis('ESTMAN', varInteger) = 2 then
    strSql := strSql + ' 	 IF(LOT_NUMLOT IS NULL, IFNULL(M.ITE_SALMAN, 0), IFNULL(LM.LOT_SALMAN, 0)) AS SALMAN, '
  Else
    strSql := strSql + '0 AS SALMAN, ';

  if TGerenciaBalancoEstoqueManutencao.fhabilitadoBEACCS then
    strSql := strSql + ' 	 IF(LOT_NUMLOT IS NULL, IFNULL(B.ITE_BEACCS, 0), IFNULL(BL.LOT_BEACCS, 0)) AS BEACCS, '
  Else
    strSql := strSql + '0 AS BEACCS, ';



  strSql := strSql + ' ' + TfrmRelBalancoEstoqueDiferenca.fGetSQLPED_VENDA_GARANTIA_NAO_COLETADA + ' AS GARCOL,';

  If fCfgSis('ESTEXT', varBoolean) Then
    strSql := strSql + ' IF(LOT_NUMLOT IS NULL, G.ITE_SALEXT, LOT_SALDOS) AS SALEXT, '
  Else
    strSql := strSql + ' 0 AS SALEXT, ';

  if blnEntFut And (Not fCfgSis('BEFTRG', VarBoolean)) Then
    strSql := strSql + ' IF(LOT_NUMLOT IS NULL, ' + fGetSQLSomaCamposEntregaFutura() + ', ' + fGetSQLSomaCamposEntregaFutura('', False, True) + ') AS ITE_ENTFUT, '
  Else
    strSql := strSql + '  0.00 AS ITE_ENTFUT, ';

  If fCfgSis('ESTEXT', varBoolean) Then
  Begin
    strSql := strSql + ' 	 (IF(LOT_NUMLOT IS NULL, (IFNULL(G.ITE_SALCON, 0) - (IFNULL(G.ITE_SALDOS, 0) - IF((G.ITE_SALEXT < 0) OR (G.ITE_SALEXT IS NULL), 0, G.ITE_SALEXT) )), (IFNULL(LOT_SALCON, 0) - (IFNULL(LOT_SALDOS,0))))) AS ITE_DIFERE, ';
    strSql := strSql + '  ((IF(LOT_NUMLOT IS NULL, (IFNULL(G.ITE_SALCON, 0) - (IFNULL(G.ITE_SALDOS, 0) - IF((G.ITE_SALEXT < 0) OR (G.ITE_SALEXT IS NULL), 0, G.ITE_SALEXT) )), (IFNULL(LOT_SALCON, 0) - (IFNULL(LOT_SALDOS,0))))*G.ITE_PRECUS)) AS ITE_VALDIF, ';
  End
  Else
  Begin
    strSql := strSql + ' 	 (IF(LOT_NUMLOT IS NULL, (IFNULL(G.ITE_SALCON, 0) - IFNULL(G.ITE_SALDOS,0)), (IFNULL(LOT_SALCON,0) - (IFNULL(LOT_SALDOS,0))))) AS ITE_DIFERE, ';
    strSql := strSql + '  ((IF(LOT_NUMLOT IS NULL, (IFNULL(G.ITE_SALCON, 0) - IFNULL(G.ITE_SALDOS,0)), (IFNULL(LOT_SALCON,0) - (IFNULL(LOT_SALDOS,0)))) * G.ITE_PRECUS)) AS ITE_VALDIF, ';
  End;

  strSql := strSql + ' 	 IF(I.ITE_CNV_ML = "" OR I.ITE_CNV_ML IS NULL OR I.ITE_CNV_ML = 0, 1, I.ITE_CNV_ML) AS ITE_CNV_ML, ';

  strSql := strSql + ' 	 IF(LOT_NUMLOT IS NULL, G.ITE_SAL_ML, LOT_SAL_ML) AS ITE_SAL_ML, ';
  strSql := strSql + ' 	 IF(LOT_NUMLOT IS NULL, G.ITE_GMLCON, LOT_ML_CON) AS ITE_GMLCON, ';
  strSql := strSql + ' 	 (IF(LOT_NUMLOT IS NULL, (G.ITE_GMLCON - G.ITE_SAL_ML), LOT_ML_CON - LOT_SAL_ML)) AS ITE_DIFGML, ';
  strSql := strSql + '   (IF(LOT_NUMLOT IS NULL, (IF(I.ITE_CNV_ML > 0, (G.ITE_PRECUS / I.ITE_CNV_ML), 0) * (G.ITE_GMLCON - G.ITE_SAL_ML)), ';
  strSql := strSql + '   (IF(I.ITE_CNV_ML > 0, (G.ITE_PRECUS / I.ITE_CNV_ML), 0) * (LOT_ML_CON - LOT_SAL_ML)))) AS ITE_VLDGML ';

  If (blnArmazem) Then
    strSql := strSql + ',  AMZ_DESCRI ';

  strSql := strSql + ' FROM        ';
  strSql := strSql + ' 	 ITEGER G ';

  strSql := strSql + ' 	 JOIN CADITE I ON G.ITE_CODITE = I.ITE_CODITE ';

  strSql := strSql + ' 	 LEFT JOIN CADMAR MA ON (I.ITE_CODMAR = MA.MAR_CODMAR) ';

  strSql := strSql + ' 	 LEFT JOIN CADUNI U ON (I.ITE_CODUNI = U.UNI_CODUNI) ';

  strSql := strSql + ' 	 LEFT JOIN CADLOT ON I.ITE_CODITE = LOT_CODITE AND   ';
  strSql := strSql + ' 	                     LOT_CODEMP = :CODEMP      AND   ';
  strSql := strSql + ' 	                     LOT_DIGCON = "S"                ';

  If Assigned(GerenciaBalancoEstoqueManutencao) Then
  Begin
    If fCfgSis('ESTMAN') = '2' Then
    Begin
      strSql := strSql + '   LEFT JOIN '+ GerenciaBalancoEstoqueManutencao.strTabela_Lote_ESTMAN+' LM ON LM.FDO_CODITE = LOT_CODITE AND LM.ID_OPERACAO = "'+GerenciaBalancoEstoqueManutencao.IDOperacao+'" ';
      strSql := strSql + '  AND  LM.FGO_EMPEXP = LOT_CODEMP ';
      strSql := strSql + '  AND  LM.FDO_NUMLOT = LOT_NUMLOT ';
      strSql := strSql + '   LEFT JOIN '+GerenciaBalancoEstoqueManutencao.strTabela_Itens_ESTMAN +' M ON M.FDO_CODITE = G.ITE_CODITE AND M.ID_OPERACAO = "'+GerenciaBalancoEstoqueManutencao.IDOperacao+'" ';
      strSql := strSql + '  AND  M.FGO_EMPEXP = G.ITE_CODEMP ';
    End;
    If GerenciaBalancoEstoqueManutencao.fhabilitadoBEACCS Then
    Begin
      strSql := strSql + '   LEFT JOIN '+GerenciaBalancoEstoqueManutencao.strTabela_Lote_BEACCS +' LB ON LB.FDO_CODITE = LOT_CODITE AND LB.ID_OPERACAO = "'+GerenciaBalancoEstoqueManutencao.IDOperacao+'" ';
      strSql := strSql + '  AND  LB.FGO_CODEMP = LOT_CODEMP ';
      strSql := strSql + '  AND  LB.FDO_NUMLOT = LOT_NUMLOT ';
      strSql := strSql + '   LEFT JOIN '+GerenciaBalancoEstoqueManutencao.strTabela_Itens_BEACCS +' B ON B.FDO_CODITE = G.ITE_CODITE AND B.ID_OPERACAO = "'+GerenciaBalancoEstoqueManutencao.IDOperacao+'" ';
      strSql := strSql + '  AND  B.FGO_CODEMP  = G.ITE_CODEMP ';
    End;
  End;


  If (blnArmazem) Then
    strSql := strSql + '  LEFT JOIN CADAMZ ON AMZ_CODAMZ = LOT_NUMLOT AND AMZ_CODEMP = LOT_CODEMP ';

  strSql := strSql + ' WHERE       ';
  strSql := strSql + ' 	 ((G.ITE_DIGCON = "S") OR (LOT_DIGCON = "S"))   AND ';
  strSql := strSql + '   G.ITE_CODEMP = :CODEMP          ';

  strSQL := strSQL + fStrLocate(edtCodFor, arrFornecedor, 'I.ITE_CODFOR', 'CODFOR');

  strSQL := strSQL + fStrLocate(edtCodMarca, arrMarca,'I.ITE_CODMAR','CODMAR');

  strSQL := strSQL + fStrLocate(edtCodDep, arrCodDep,'I.ITE_CODDEP','CODDEP');

  If (Not fEmptyStr(edtCodDig.Text)) Or (Length(arrDigitador) > 0) Then
  Begin
    strSQL := strSQL + ' AND (SELECT EST_OPEALT  ';
    strSQL := strSQL + '      FROM LOGEST ';
    strSQL := strSQL + '      WHERE ';
    strSQL := strSQL + '            EST_CODEMP = G.ITE_CODEMP ';
    strSQL := strSQL + '        AND EST_CODITE = G.ITE_CODITE ';

    strSQL := strSQL + '      ORDER BY ';
    strSQL := strSQL + '        EST_DTAALT DESC, ';
    strSQL := strSQL + '        EST_HRAALT DESC  ';
    strSQL := strSQL + '      LIMIT 1) IN (' + fArrCodigosToLista(edtCodDig.Text, arrDigitador) + ') ';
  End;

  If Not fEmptyStr(edtLocIni.Text) Then
  Begin
    If (Not fEmptyStr(edtLocFin.Text)) Then
      strSQL := strSQL + '   AND LEFT(IF(LOT_NUMLOT IS NULL, G.ITE_LOCFIS, LOT_LOCFIS), LENGTH(:MAIOR)) BETWEEN :LOCINI AND :LOCFIN '
    Else strSQL := strSQL + '   AND IF(LOT_NUMLOT IS NULL, G.ITE_LOCFIS, LOT_LOCFIS) LIKE :LOCINI ';
  End;

  If Not fEmptyStr(edtSupEstIni.Text) Then
  Begin
    If (Not fEmptyStr(edtSupEstFin.Text)) Then
      strSQL := strSQL + '   AND LEFT(G.ITE_LOCSUP, LENGTH(:MAIOR)) BETWEEN :SUPINI AND :SUPFIN '
    Else strSQL := strSQL + '   AND G.ITE_LOCSUP LIKE :SUPINI ';
  End;

  Case rdgStatus.ItemIndex Of
    0: strSQL := strSQL + '   AND ITE_ITEATI = "S" ';
    1: strSQL := strSQL + '   AND IFNULL(ITE_ITEATI, "N") = "N" ';
  End;

  strSQL := strSQL + fStrLocateLinGru(mskLinhaGrupo, arrLinhaGrupo, 'I.ITE_CODGRU', 'CODGRU');

  {**********************************}
  { FILTRO DE LOCALIZAÇAO            }
  {**********************************}
  If Assigned(rdgImpIte) Then
  Case rdgImpIte.ItemIndex Of
    0: strSQL := strSQL + '  AND IFNULL(IF(LOT_NUMLOT IS NULL, G.ITE_LOCFIS, LOT_LOCFIS), "") <> "" ';
    1: strSQL := strSQL + '  AND IFNULL(IF(LOT_NUMLOT IS NULL, G.ITE_LOCFIS, LOT_LOCFIS), "")  = "" ';
  End;

  If blnMapaContagem Or (Not chkSemDif.Checked) Then
  Begin
    strSql := strSql + '  HAVING  ';

    If intConEst = 2 Then
      strSql := strSql + '  (ITE_DIFSAL <> 0 OR ITE_DIFVML <> 0) AND ';

    strSql := strSql + '   (    ';
    strSql := strSql + '    (   ';
    strSql := strSql + '     ( ITE_NUMLOT = "" ) AND                                    ';
    strSql := strSql + '  	 ((FORMAT(ITE_SALDOS+ITE_ENTFUT,3) <> FORMAT(ITE_SALCON + RESGAR + SALMAN + BEACCS + GARCOL, 3)) ';
    strSql := strSql + ' 	     OR (FORMAT(ITE_SAL_ML,4) <> FORMAT(ITE_GMLCON,4))        ';
    strSql := strSql + '    )   ';
    strSql := strSql + '   ) OR ';
    strSql := strSql + '    (   ';
    strSql := strSql + '     ( ITE_NUMLOT <> "" ) AND                                   ';
    strSql := strSql + '  	 (FORMAT(ITE_SALDOS+ITE_ENTFUT,3) <> FORMAT(ITE_SALCON + RESGAR + SALMAN + BEACCS + GARCOL,3))  ';
    strSql := strSql + ' 	    OR (FORMAT(ITE_SAL_ML,4) <> FORMAT(ITE_GMLCON,4))         ';
    strSql := strSql + '    )   ';
    strSql := strSql + '   )    ';
  End;

  strSql := strSql + ' ) TMP ';

  If blnMapaContagem Then
  Begin
    strSql := strSql + ' INNER JOIN HISBAL H ON H.ITE_CODITE = TMP.ITE_CODITE AND H.ITE_CODEMP = :CODEMP AND H.ITE_NUMLOT = TMP.ITE_NUMLOT ';

    strSql := strSql + ' LEFT JOIN CADOPE ON OPE_CODOPE = H.ITE_CODOPE ';
  End;

  If blnResumido Then
    strSql := strSql + ' GROUP BY ITE_CODITE ';

  {***********************************}
  {* ACRESCENTOU OPÇÃO DE ORDENAÇÃO  *}
  {********************************CI*}
  strSql := strSql + ' 	ORDER BY       ';

  If blnMapaContagem Then
    strSql := strSql + ' 	H.ITE_CODITE, H.ITE_NUMLOT, H.ITE_CONTAG '
  Else
  Case rdgOrdem.ItemIndex Of
    0: strSql := strSql + ' 	  ITE_DESITE ';
    1: strSql := strSql + ' 	  IFNULL(ITE_LOCFIS, ""), ITE_DESITE ';
    2: strSql := strSql + ' 	  ITE_ORDCON, ITE_DESITE ';
  End;

  With cdsGen.qryQuery Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSql);

    ParamByName('CODEMP').AsString := VS_strCodEmp;

    pSetaParam(edtCodFor.Text,     arrFornecedor, strFornec, 'CODFOR', cdsGen.qryQuery);

    pSetaParam(edtCodMarca.Text,arrMarca,strLinMar,'CODMAR', cdsGen.qryQuery);

    pSetaParam(edtCodDep.Text,arrCodDep,strCodDep,'CODDEP', cdsGen.qryQuery);

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

    If Not fEmptyStr(edtSupEstIni.Text) Then
    Begin

      If (Not fEmptyStr(edtSupEstFin.Text)) Then
      Begin
        ParamByName('SUPINI').AsString := edtSupEstIni.Text;
        ParamByName('SUPFIN').AsString := edtSupEstFin.Text;

        If Length(edtSupEstIni.Text) > Length(edtSupEstFin.Text) Then
          ParamByName('MAIOR').AsString := edtSupEstIni.Text
        Else
          ParamByName('MAIOR').AsString := edtSupEstFin.Text;

      End
      Else
        ParamByName('SUPINI').AsString := edtSupEstIni.Text + '%';

    End;

    pSetaParam(mskLinhaGrupo.Text, arrLinhaGrupo, strLinGrupo, 'CODGRU', cdsGen.qryQuery);

    If blnMapaContagem Then
      cdsGen.pCriaSoma('H_CONTAG', 'MAX_CONTAG', 'MAX(H_CONTAG)');
  End;

  Result := cdsGen.fLeDados('', True, 'Carregando dados, aguarde...');

  Finally
    If Assigned(GerenciaBalancoEstoqueManutencao) Then
     FreeAndNil(GerenciaBalancoEstoqueManutencao);
  End;
End;


procedure TfrmRelBalancoEstoqueDiferenca.btnImprimirClick(Sender: TObject);
  Var
    cdsGen : TZClient;
    frxRel : TfrxReport;
    strNomImp: String;
    fltLeftSemReferecia, fltWidthReferencia, fltWidthDesc, fltWidthVar, fltPadIntervalo: Double;
    fleObjeto: TMemoryStream;
begin
  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  inherited;

  If blnImprime Then
  Begin
    cdsGen := TZClient.Create(Nil);

    If fCarregaDiferencas(cdsGen,
                          False,
                          mskLinhaGrupo,
                          edtLocIni,
                          edtLocFin,
                          edtSupEstIni,
                          edtSupEstFin,
                          edtCodFor,
                          edtCodDig,
                          edtCodDep,
                          edtCodMarca,
                          arrLinhaGrupo,
                          arrFornecedor,
                          arrDigitador,
                          arrCodDep,
                          arrMarca,
                          rdgStatus,
                          rdgImpIte,
                          rdgOrdem,
                          chkSemDif,
                          cbbTipo) And
                          (Not cdsGen.IsEmpty) Then
      Begin
        frxRelatorio.DataSet := cdsGen;

        pCarregaConfImpr(qryCfgRel, Self.Name);
        strTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
        strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

        If strTipImp = 'M' Then
        Begin
          If fCfgSis('USATMQ', varBoolean) Then
          Begin
            If intConEst = 1 Then
            Begin
              if cbbTipo.ItemIndex = 0 then             // Completo
              begin
                frxRel    := frxRelDiferencaGmlM;
                intTipRel := 1;
              end
              else                                      // Resumido
              begin
                frxRel    := frxRelDiferencaGmlResM;
                intTipRel := 1;
              end;
            End
            Else
            Begin
              frxRel    := frxRelDiferencaGmlM2;
              intTipRel := 2;
            End
          End Else
          Begin
            If intConEst = 1 Then
            Begin
              if cbbTipo.ItemIndex = 0 then             // Completo
              begin
                frxRel    := frxRelDiferencaM;
                intTipRel := 3;
              end
              else                                      // Resumido
              begin
                frxRel    := frxRelDiferencaResM;
                intTipRel := 3;
              end;
            End
            Else
            Begin
              frxRel    := frxRelDiferencaM2;
              intTipRel := 4;
            End;
          End;
        End
        Else
        Begin
          If fCfgSis('USATMQ', varBoolean) Then
          Begin
            If intConEst = 1 Then
            Begin
              if cbbTipo.ItemIndex = 0 then             // Completo
              begin
                frxRel    := frxRelDiferencaGmlJ;
                intTipRel := 1;
              end
              else                                      // Resumido
              begin
                frxRel    := frxRelDiferencaGmlResJ;
                intTipRel := 1;
              end;
            End
            Else
            Begin
              frxRel    := frxRelDiferencaGmlJ2;
              intTipRel := 2;
            End
          End Else
          Begin
            If intConEst = 1 Then
            Begin
              if cbbTipo.ItemIndex = 0 then             // Completo
              begin
                frxRel    := frxRelDiferencaJ;
                intTipRel := 3;
              end
              else                                      // Resumido
              begin
                frxRel    := frxRelDiferencaResJ;
                intTipRel := 3;
              end;
            End
            Else
            Begin
              frxRel    := frxRelDiferencaJ2;
              intTipRel := 4;
            End
          End;

          frxRel.DotMatrixReport           := False;
          frxRel.PrintOptions.PrintMode    := pmScale;
          frxRel.PrintOptions.PrintOnSheet := 9; //A4
        End;

        frxRel.PrintOptions.Printer := AnsiReplaceText(strNomImp,'\\' + fRetNomeRede + '\','');

        frxRel.Script.Variables['blnLocSup'] := ckbSuperEstoque.Checked;
        frxRel.Script.Variables['blnOcultar_saldoEstoque_Diferenca'] := chkSalCon_SalEst.Checked;

        strDigitador := AnsiReplaceText(AnsiReplaceText(fArrCodigosToLista(edtCodDig.Text, arrDigitador),',','_' ),'''','');
        frxRel.Script.Variables['DIGITADOR'] := fStrTitulo(edtCodDig.Text, edtNomDig, arrDigitador, strDigitador, 'DIGITADOR');

        frxRel.Script.Variables['MARCA'] := fStrTitulo(edtCodMarca.Text, edtNomMarca, arrMarca, strLinMar, 'MARCA');

        frxRel.Script.Variables['LINGRU'] := fStrTitulo(mskLinhaGrupo.Text, edtDesGrupo, arrLinhaGrupo, strLinGrupo, 'LINHA / GRUPO');

        If fEmptyStr(edtLocIni.Text) Then
          frxRel.Script.Variables['LOCAL1'] := 'LOC. FISICA INICIAL: TODAS '
        Else
          frxRel.Script.Variables['LOCAL1'] := 'LOC. FISICA INICIAL: ' + edtLocIni.Text;

        If (fEmptyStr(edtLocFin.Text)) Then
          frxRel.Script.Variables['LOCAL2'] := 'LOC. FISICA FINAL  : NENHUMA'
        Else
          frxRel.Script.Variables['LOCAL2'] := 'LOC. FISICA FINAL  : ' + edtLocFin.Text;

        frxRel.Script.Variables['FORNECEDOR'] := fStrTitulo(edtCodFor.Text, edtNomFor, arrFornecedor, strFornec, 'FORNECEDOR');

        frxRel.Script.Variables['DEPARTAMENTO'] := 'DEPARTAMENTO: ' + IIF(fEmptyStr(edtCodDep.Text), 'TODOS', edtCodDep.Text + '-' + edtDesDep.Text);

        frxRel.Script.Variables['SEMDIF'] := chkSemDif.Checked;

        frxRel.Script.Variables['STATUS'] := 'STATUS: ' + UpperCase(rdgStatus.Items[rdgStatus.ItemIndex]);

        {***************************************}
        {* ACRESCENTOU MOSTRAR CODIGO DE BARRA *}
        {************************************DP*}
        if cbbTipo.ItemIndex = 0 then
        begin
          TfrxMemoView(frxRel.FindObject('rllReferencia')).Visible := True;
          TfrxMemoView(frxRel.FindObject('rllRefere')).Visible := True;
          If (rdgMostrar.ItemIndex = 0) Then
          Begin
            TfrxMemoView(frxRel.FindObject('rllReferencia')).Text := 'REFERENCIA';
            TfrxMemoView(frxRel.FindObject('rllRefere')).DataField := 'ITE_REFERE';
          End
          Else If (rdgMostrar.ItemIndex = 1) Then
          Begin
            TfrxMemoView(frxRel.FindObject('rllReferencia')).Text := 'COD.FABRICA';
            TfrxMemoView(frxRel.FindObject('rllRefere')).DataField := 'ITE_CODFAB';
          End
          Else If (rdgMostrar.ItemIndex = 2) Then
          Begin
            TfrxMemoView(frxRel.FindObject('rllReferencia')).Text := 'MARCA';
            TfrxMemoView(frxRel.FindObject('rllRefere')).DataField := 'MAR_DESMAR';
          End
          Else If (rdgMostrar.ItemIndex = 3) Then
          Begin
            TfrxMemoView(frxRel.FindObject('rllReferencia')).Text := 'COD.BARRA';
            TfrxMemoView(frxRel.FindObject('rllRefere')).DataField := 'ITE_CODBAR';
          End
          Else
          Begin
            TfrxMemoView(frxRel.FindObject('rllReferencia')).Visible := False;
            TfrxMemoView(frxRel.FindObject('rllRefere')).Visible := False;
          End;
        end;
        {********************************************}
        {* ACRESCENTOU OPÇOES DE LOTE E LOCALIZAÇÃO *}
        {*****************************************CI*}
        Try
          fleObjeto := TMemoryStream.Create;
          frxRel.SaveToStream(fleObjeto);

          if cbbTipo.ItemIndex = 0 then
          begin
            If (rdgMostrar.ItemIndex = 4) Then
            Begin
              fltWidthReferencia  := TfrxMemoView(frxRel.FindObject('rllRefere')).Width;
              fltLeftSemReferecia := TfrxMemoView(frxRel.FindObject('rllUnidade')).Left;
            End
            Else
            Begin
              fltWidthReferencia  := 0.00;
              fltLeftSemReferecia := TfrxMemoView(frxRel.FindObject('rllReferencia')).Left;
            End;

            fltPadIntervalo := TfrxMemoView(frxRel.FindObject('rllDetLote')).Left -
                               TfrxMemoView(frxRel.FindObject('rllTitDescricao')).Width;

            If (not(ckbNumeroLote.Checked) and (ckbLocalizacaoFisica.Checked))  Then
            Begin
              fltWidthDesc := TfrxMemoView(frxRel.FindObject('frxRelatorioHORENV')).Width + fltWidthReferencia +
                              TfrxMemoView(frxRel.FindObject('rllTitLote')).Width/2;
              fltWidthVar  := TfrxMemoView(frxRel.FindObject('rllTitLocalizacao')).Width +
                              TfrxMemoView(frxRel.FindObject('rllTitLote')).Width/2;
              TfrxMemoView(frxRel.FindObject('rllTitLote')).Text           := '';
              TfrxMemoView(frxRel.FindObject('rllDetLote')).Visible        := False;
              TfrxMemoView(frxRel.FindObject('rllTitLocalizacao')).Text    := 'LOC. FÍSICA';
              TfrxMemoView(frxRel.FindObject('rllDetLocalizacao')).Visible := True;
              TfrxMemoView(frxRel.FindObject('rllTitLocalizacao')).Left    := fltWidthDesc + fltPadIntervalo;
              TfrxMemoView(frxRel.FindObject('rllDetLocalizacao')).Left    := fltWidthDesc + fltPadIntervalo;
              TfrxMemoView(frxRel.FindObject('rllDetLocalizacao')).Width   := fltWidthVar;
              TfrxMemoView(frxRel.FindObject('rllTitLocalizacao')).Width   := fltLeftSemReferecia -
                                                                              TfrxMemoView(frxRel.FindObject('rllTitLocalizacao')).Left;


            End
            Else If ((ckbNumeroLote.Checked) and not(ckbLocalizacaoFisica.Checked))  Then
            Begin
              fltWidthDesc := TfrxMemoView(frxRel.FindObject('frxRelatorioHORENV')).Width + fltWidthReferencia +
                              TfrxMemoView(frxRel.FindObject('rllTitLocalizacao')).Width/2;
              fltWidthVar  := TfrxMemoView(frxRel.FindObject('rllDetLote')).Width +
                              TfrxMemoView(frxRel.FindObject('rllTitLocalizacao')).Width/2;

              If objCadLot.tplTipLot = tplArmazem Then
              Begin
                TfrxMemoView(frxRel.FindObject('rllTitLote')).Text := 'ARMAZEM';
                TfrxMemoView(frxRel.FindObject('rllDetLote')).Text := '[frxRelatorio."AMZ_DESCRI"]';
              End
              Else
              Begin
                TfrxMemoView(frxRel.FindObject('rllTitLote')).Text := 'LOTE';
                TfrxMemoView(frxRel.FindObject('rllDetLote')).Text := '[frxRelatorio."ITE_NUMLOT"]';
              End;

              TfrxMemoView(frxRel.FindObject('rllDetLote')).Visible        := True;
              TfrxMemoView(frxRel.FindObject('rllTitLocalizacao')).Text    := '';
              TfrxMemoView(frxRel.FindObject('rllDetLocalizacao')).Visible := False;
              TfrxMemoView(frxRel.FindObject('rllTitLote')).Left           := fltWidthDesc + fltPadIntervalo;
              TfrxMemoView(frxRel.FindObject('rllDetLote')).Left           := fltWidthDesc + fltPadIntervalo;
              TfrxMemoView(frxRel.FindObject('rllDetLote')).Width          := fltWidthVar;
              TfrxMemoView(frxRel.FindObject('rllTitLote')).Width          := fltLeftSemReferecia -
                                                                              TfrxMemoView(frxRel.FindObject('rllTitLote')).Left;

            End
            Else If (not(ckbNumeroLote.Checked) and not(ckbLocalizacaoFisica.Checked))  Then
            Begin
              fltWidthDesc := TfrxMemoView(frxRel.FindObject('frxRelatorioHORENV')).Width + fltWidthReferencia +
                              TfrxMemoView(frxRel.FindObject('rllTitLote')).Width +
                              TfrxMemoView(frxRel.FindObject('rllTitLocalizacao')).Width;
              TfrxMemoView(frxRel.FindObject('rllTitLote')).Text           := '';
              TfrxMemoView(frxRel.FindObject('rllDetLote')).Visible        := False;
              TfrxMemoView(frxRel.FindObject('rllTitLocalizacao')).Text    := '';
              TfrxMemoView(frxRel.FindObject('rllDetLocalizacao')).Visible := False;
            End
            Else
            Begin

              If objCadLot.tplTipLot = tplArmazem Then
              Begin
                TfrxMemoView(frxRel.FindObject('rllTitLote')).Text := 'NOM. ARMAZ.';
                TfrxMemoView(frxRel.FindObject('rllDetLote')).Text := '[frxRelatorio."AMZ_DESCRI"]';
              End
              Else
              Begin
                TfrxMemoView(frxRel.FindObject('rllTitLote')).Text := 'NUM. DO LOTE';
                TfrxMemoView(frxRel.FindObject('rllDetLote')).Text := '[frxRelatorio."ITE_NUMLOT"]';
              End;

              fltWidthDesc := TfrxMemoView(frxRel.FindObject('frxRelatorioHORENV')).Width + fltWidthReferencia;
              TfrxMemoView(frxRel.FindObject('rllTitLote')).Left         := TfrxMemoView(frxRel.FindObject('rllTitLote')).Left + fltWidthReferencia;
              TfrxMemoView(frxRel.FindObject('rllDetLote')).Left         := TfrxMemoView(frxRel.FindObject('rllDetLote')).Left + fltWidthReferencia;
              TfrxMemoView(frxRel.FindObject('rllTitLocalizacao')).Left  := TfrxMemoView(frxRel.FindObject('rllTitLocalizacao')).Left + fltWidthReferencia;
              TfrxMemoView(frxRel.FindObject('rllDetLocalizacao')).Left  := TfrxMemoView(frxRel.FindObject('rllDetLocalizacao')).Left + fltWidthReferencia;
            End;

            TfrxMemoView(frxRel.FindObject('rllTitDescricao')).Width := fltLeftSemReferecia;
            TfrxMemoView(frxRel.FindObject('frxRelatorioHORENV')).Width := fltWidthDesc;

            If (shaImprime.Brush.Color = clRed) Or
               ((shaImprime.Brush.Color = clGreen) And (chkSalCon_SalEst.Checked)) Then
            Begin
              TfrxMemoView(frxRel.FindObject('rllCusto')).Visible  := (shaImprime.Brush.Color = clGreen);
              TfrxMemoView(frxRel.FindObject('rdbCusto')).Visible  := (shaImprime.Brush.Color = clGreen);
              TfrxMemoView(frxRel.FindObject('rllDifVal')).Visible := False;
              TfrxMemoView(frxRel.FindObject('rdbDifVal')).Visible := False;
              TfrxMemoView(frxRel.FindObject('rllTotDif')).Visible := False;
              TfrxMemoView(frxRel.FindObject('rdbTotDif')).Visible := False;
            End
            Else if (shaImprime.Brush.Color = clGreen) then
            Begin
              TfrxMemoView(frxRel.FindObject('rllCusto')).Visible  := True;
              TfrxMemoView(frxRel.FindObject('rdbCusto')).Visible  := True;
              TfrxMemoView(frxRel.FindObject('rllDifVal')).Visible := True;
              TfrxMemoView(frxRel.FindObject('rdbDifVal')).Visible := True;
              TfrxMemoView(frxRel.FindObject('rllTotDif')).Visible := True;
              TfrxMemoView(frxRel.FindObject('rdbTotDif')).Visible := True;
            End;
          end;

          {*************************************}
          {* ACRESCENTOU OPÇÃO EXPORTAR EXCEL  *}
          {**********************************CI*}

          If edtDestino.Text = 'E' Then
             pGeraExcel(cdsGen)
          Else If edtDestino.Text = 'V' Then
            pPreviewReport(Self.Name, Self.Caption + ' (Relatório)', frxRel)
          Else If frxRel.PrepareReport Then
            pPrintReport(Self.Name, Self.Caption + ' (Relatório)', strNomImp, frxRel);

          fleObjeto.Position := 0;
          frxRel.LoadFromStream(fleObjeto);
        Finally
          If Assigned(fleObjeto) Then
            FreeAndNil(fleObjeto);
        End;

      End

      Else
      Begin
        fMensagem('', 'Nenhum registro encontrado !',['&O K']);
      End;

     FreeAndNil(cdsGen);
  End;

  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';
end;

procedure TfrmRelBalancoEstoqueDiferenca.FormCreate(Sender: TObject);
begin
  inherited;
  blnImpressaoDireta := False;

  blnCadLoc  := fCfgSis('CADLOC', varBoolean);

  objCadLot  := TCadLot.Create(Self);
  blnArmazem := fCfgSis('CTLEST') = '2';

  If blnArmazem Then
    ckbNumeroLote.Caption := 'Nome do Armazém'
  Else
    ckbNumeroLote.Caption := 'Número do Lote';

  pVerdeVermelho(lblPermImp, shaImprime, fVerificaAcessoSistema('RELBALESTAJU'));
  intConEst := fCfgSis('CONEST');
end;

procedure TfrmRelBalancoEstoqueDiferenca.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(mskLinhaGrupo);
end;

procedure TfrmRelBalancoEstoqueDiferenca.cbbTipoSelect(Sender: TObject);
begin
  inherited;
  if cbbTipo.ItemIndex = 1 then
  begin
    rdgMostrar.ItemIndex         := 4;
    rdgMostrar.Enabled           := False;

    ckbNumeroLote.Checked        := False;
    ckbLocalizacaoFisica.Checked := False;
    ckbSuperEstoque.Checked      := False;
    grbOpcoes.Enabled            := False;
  end
  else
  begin
    rdgMostrar.Enabled           := True;
    grbOpcoes.Enabled            := True;
  end;
end;

procedure TfrmRelBalancoEstoqueDiferenca.edtCodDepExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodDep, edtDesDep, arrDepto, fRetNomDep, nil, 'do Departamento');
end;

procedure TfrmRelBalancoEstoqueDiferenca.edtCodDepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqDepartamento(Self, edtCodDep, edtDesDep, Nil, Key, arrCodDep, True) Then
  Begin
    If fValidaCampos(edtCodDep, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelBalancoEstoqueDiferenca.edtCodDigExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodDig, edtNomDig, arrDigitador, fRetNomeOperador, nil, 'do Operador');
end;

procedure TfrmRelBalancoEstoqueDiferenca.edtCodDigKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqOperador(Self, edtCodDig, edtNomDig, nil, Key, arrDigitador, False) then
  Begin
    If fValidaCampos(edtCodDig, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelBalancoEstoqueDiferenca.edtCodForExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFor,edtNomFor,arrFornecedor,fRetNomFornecedor,nil,'do Fornecedor');
end;

procedure TfrmRelBalancoEstoqueDiferenca.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, nil, Key, arrFornecedor, False) Then
  Begin
    fvalidaCampos(edtCodFor,False);
    self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelBalancoEstoqueDiferenca.edtCodMarcaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodMarca,edtNomMarca,
                    arrMarca,fRetNomMarca,nil,'da Marca');
end;

procedure TfrmRelBalancoEstoqueDiferenca.edtCodMarcaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if fPesqMarcas(Self, edtCodMarca, edtNomMarca, Nil, Key, arrMarca, False) then
  begin
  If fValidaCampos(edtCodMarca, True) Then
      SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmRelBalancoEstoqueDiferenca.edtDestinoExit(Sender: TObject);
begin
//  inherited;

end;

procedure TfrmRelBalancoEstoqueDiferenca.edtLocFinKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If blnCadLoc And fPesqLocFisica(Self, edtLocFin, Nil, Nil, Key, arrSel) And
     fValidaCampos(edtLocFin, True) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmRelBalancoEstoqueDiferenca.edtLocIniKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If blnCadLoc And fPesqLocFisica(Self, edtLocIni, Nil, Nil, Key, arrSel) And
     fValidaCampos(edtLocIni, True) Then
    SelectNext(ActiveControl, True, True);
end;

function TfrmRelBalancoEstoqueDiferenca.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;

  Try

    If (inherited fValidaCampos(Sender)) Then
    Begin

      If (Sender = edtLocIni) Then
      Begin

        If blnCadLoc Then
        Begin

          If (Not fEmptyStr(edtLocIni.Text)) Then
          Begin

            If fEmptyStr(fRetNomLocFisica(edtLocIni.Text)) Then
            Begin
              pMensagemOk('Localização Física inicial não encontrada!');
              Result := False;
            End

          End;

        End;

      End

      Else If (Sender = edtLocFin) Then
      Begin

        If blnCadLoc Then
        Begin

          If (Not fEmptyStr(edtLocFin.Text)) Then
          Begin

            If fEmptyStr(fRetNomLocFisica(edtLocFin.Text)) Then
            Begin
              pMensagemOk('Localização Física final não encontrada!');
              Result := False;
            End

          End;

        End;

      End
      Else If (Sender = edtDestino) Then
      Begin
        If fEmptyStr(edtDestino.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'O Destino do Relatório deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else If (Pos(edtDestino.Text, 'V_I_E_') <= 0) Then
        Begin
          fMensagem('ATENÇÃO', 'O Destino do Relatório deve ser V, I ou E!', ['&Ok']);
          Result := False;

        End;

      End
      Else If (Sender = edtCodMarca) Then
      Begin
        pDesmarcaLista(edtCodMarca,arrMarca,'TMP_MARCA');
      End
      Else If (Sender = edtCodDep) Then
      Begin

        If Not fEmptyStr(edtCodDep.Text) Then
        Begin
          edtDesDep.Text := fRetNomDep(edtCodDep.Text);
          If fEmptyStr(edtDesDep.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Departamento não encontrado!', ['&Ok']);
            Result := False;
          End
        End

        Else edtNomFor.Text := 'TODOS';

      End

    End;

  Except
    On E: Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmRelBalancoEstoqueDiferenca.fValidaCampos]');
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmRelBalancoEstoqueDiferenca.pGeraExcel(qryDados: TDataSet);
  Var
    objGeraExcel: TGeraExcel;
begin
  objGeraExcel := TGeraExcel.Create(qryDados, pgbProgresso);
  With objGeraExcel Do
  Begin
    blnImpEmp := True;
    strNomRel := 'RELATORIO DE DIFERENCAS (SALDO / CONTAGEM)';
    AddFiltro(fStrTitulo(mskLinhaGrupo.Text,edtDesGrupo,arrLinhaGrupo, strLinGrupo,'LINHA/GRUPO'));
    If fEmptyStr(edtLocIni.Text) Then
      AddFiltro('LOC. FÍSICA INICIAL: TODAS')
    Else
      AddFiltro('LOC. FÍSICA INICIAL: ' + edtLocIni.Text);

    If (fEmptyStr(edtLocFin.Text)) Then
      AddFiltro('LOC.FÍSICA FINAL: NENHUMA')
    Else
      AddFiltro('LOC. FÍSICA FINAL: ' + edtLocFin.Text);

    AddFiltro(fStrTitulo(edtCodFor.Text,edtNomFor, arrFornecedor, strFornec, 'FORNECEDOR'));

    AddFiltro(fStrTitulo(edtCodDep.Text,edtDesdep, arrCodDep, strCodDep, 'DEPARTAMENTO'));

    Case rdgStatus.ItemIndex Of
      0: AddFiltro('STATUS: ATIVO');
      1: AddFiltro('STATUS: INATIVO');
      2: AddFiltro('STATUS: TODOS');
    End;

    AddCampo( 'ITE_CODITE', 'CODIGO');
    AddCampo( 'ITE_DESITE', 'DESCRICAO');

    If objCadLot.tplTipLot = tplArmazem Then
      AddCampo( 'ITE_NUMLOT', 'ARMAZEM')
    Else
      AddCampo( 'ITE_NUMLOT', 'NUM. LOTE');

    AddCampo( 'ITE_LOCFIS', 'LOC. FISICA');
    AddCampo( 'ITE_LOCSUP', 'SUPER ESTOQ.');
    AddCampo( 'ITE_REFERE', 'REFERENCIA');

    AddCampo( 'UNI_SIGUNI', 'UN.');

    Case intTipRel Of
    1: Begin
        // frxRelDiferencaGmlJ / frxRelDiferencaGmlM
        // frxRelDiferencaGmlResJ / frxRelDiferencaGmlResM

        if cbbTipo.ItemIndex = 0 then
        begin
          If (Not chkSalCon_SalEst.Checked) Then
             AddCampo( 'ITE_SALDOS', 'SALDO');
          AddCampo( 'ITE_SALCON', 'CONTAGEM');
          If (Not chkSalCon_SalEst.Checked) Then
            AddCampo( 'ITE_DIFERE', 'DIFERENCA');
          If (Not chkSalCon_SalEst.Checked) Then
            AddCampo( 'ITE_SAL_ML', 'SALDO(G/ML)');
          AddCampo( 'ITE_GMLCON', 'CONT.(G/ML)');
          If (Not chkSalCon_SalEst.Checked) Then
            AddCampo( 'ITE_DIFGML', 'DIFER.(G/ML)');

          {********************************************************}
          {* ACRESCENTOU PERMISSÃO DE IMPRIMIR CUSTO E DIFERENÇA  *}
          {*****************************************************CI*}
          If (shaImprime.Brush.Color = clGreen) Then
          Begin
            AddCampo( 'ITE_PRECUS', 'CUSTO UNI.');
            AddCampo( 'ITE_VAL_DIF1', 'VAL. DIFER.');
          End;
        end
        else
        begin
          If (Not chkSalCon_SalEst.Checked) Then
            AddCampo( 'ITE_SALDOS', 'SALDO');
          AddCampo( 'ITE_SALCON', 'CONTAGEM');
          AddCampo( 'ITE_SAL_ML', 'SALDO(G/ML)');
          AddCampo( 'ITE_GMLCON', 'CONT.(G/ML)');
        end;

       End;
    2: Begin
        // frxRelDiferencaGmlJ2 / frxRelDiferencaGmlM2
        If (Not chkSalCon_SalEst.Checked) Then
        Begin
          AddCampo( 'ITE_SALDOS', 'SALDO');
          AddCampo( 'ITE_DIFSAL', 'DIFERENCA');
          AddCampo( 'ITE_SAL_ML', 'SALDO(G/ML)');
          AddCampo( 'ITE_DIF_ML', 'DIFER.(G/ML)');
        End;

        {********************************************************}
        {* ACRESCENTOU PERMISSÃO DE IMPRIMIR CUSTO E DIFERENÇA  *}
        {*****************************************************CI*}

        If (shaImprime.Brush.Color = clGreen) Then
        Begin
          AddCampo( 'ITE_PRECUS', 'CUSTO UNI.');
          AddCampo( 'ITE_VAL_DIF2', 'VAL. DIFER.');
        End;
       End;
    3: Begin
        // frxRelDiferencaJ / frxRelDiferencaM
        // frxRelDiferencaResJ / frxRelDiferencaResM

        if cbbTipo.ItemIndex = 0 then
        begin
          If (Not chkSalCon_SalEst.Checked) Then
             AddCampo( 'ITE_SALDOS', 'SALDO');
          AddCampo( 'ITE_SALCON', 'CONTAGEM');
          If (Not chkSalCon_SalEst.Checked) Then
            AddCampo( 'ITE_DIFERE', 'DIFERENCA');

          {********************************************************}
          {* ACRESCENTOU PERMISSÃO DE IMPRIMIR CUSTO E DIFERENÇA  *}
          {*****************************************************CI*}

          If (shaImprime.Brush.Color = clGreen) Then
          Begin
            AddCampo( 'ITE_PRECUS', 'CUSTO UNI.');
            AddCampo( 'ITE_VALDIF', 'VAL. DIFER.');
          End;
        end
        else
        begin
          If (Not chkSalCon_SalEst.Checked) Then
            AddCampo( 'ITE_SALDOS', 'SALDO');
          AddCampo( 'ITE_SALCON', 'CONTAGEM');
        end;

       End;
    4: Begin
        // frxRel := frxRelDiferencaJ2 / frxRelDiferencaM2
        If (Not chkSalCon_SalEst.Checked) Then
        Begin  
          AddCampo( 'ITE_SALDOS', 'SALDO');
          AddCampo( 'ITE_DIFSAL', 'DIFERENCA');
        End;

        {********************************************************}
        {* ACRESCENTOU PERMISSÃO DE IMPRIMIR CUSTO E DIFERENÇA  *}
        {*****************************************************CI*}
        If (shaImprime.Brush.Color = clGreen) Then
        Begin
            AddCampo( 'ITE_PRECUS', 'CUSTO UNI.');
            AddCampo( 'ITE_DIFVAL', 'VAL. DIFER.');
        End;

       End;
    End;
  End;

  if (intConEst = 2) or (cbbTipo.ItemIndex = 0) then
  begin

    objGeraExcel.AddTotais('TOTDIF');

    objGeraExcel.OnMontaResumo := pMontaResumo;
    objGeraExcel.OnSomaResumo  := pSomaTotais;

  end;

  If objGeraExcel.fGerarRelatorio Then
    fMensagem('','Arquivo gerado com sucesso!', ['&OK']);

  FreeAndNil(objGeraExcel);

end;

procedure TfrmRelBalancoEstoqueDiferenca.pMontaResumo(Excel: TExcel; Campos: TCampos;
  Quebra: TRecQuebras);
  Var
    strTotVal: String;
begin
  With Excel Do
  Begin
    ProximaLinha;
    strTotVal := 'TOTAL DIFERENCAS: ' + fPadL(FormatFloat('##,#0.00', Quebra.Totais['TOTDIF']), 14);
    Case intTipRel Of
    1: Begin
        // frxRelDiferencaGmlJ / frxRelDiferencaGmlM
        If (shaImprime.Brush.Color = clGreen) Then
          Escrever(LinhaAtual, Campos.ColunaPorNome['ITE_VAL_DIF1'].Coluna, strTotVal);
       End;
    2: Begin
        // frxRelDiferencaGmlJ2 / frxRelDiferencaGmlM2
        If (shaImprime.Brush.Color = clGreen) Then
          Escrever(LinhaAtual, Campos.ColunaPorNome['ITE_VAL_DIF2'].Coluna, strTotVal);
       End;
    3: Begin
        // frxRelDiferencaJ / frxRelDiferencaM
        If (shaImprime.Brush.Color = clGreen) Then
          Escrever(LinhaAtual, Campos.ColunaPorNome['ITE_VALDIF'].Coluna, strTotVal);
       End;
    4: Begin
        // frxRel := frxRelDiferencaJ2 / frxRelDiferencaM2
        If (shaImprime.Brush.Color = clGreen) Then
          Escrever(LinhaAtual, Campos.ColunaPorNome['ITE_DIFVAL'].Coluna, strTotVal);
       End;
    End;

    Negrito    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True);
    CorFundo   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Amarelo);
    CorFonte   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Azul);
    Bordas     ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
    Alinhamento('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Direita);

  End;
end;

procedure TfrmRelBalancoEstoqueDiferenca.pSomaTotais(var Totais: TTotais;
  Dados: TDataSet);
Begin
    Case intTipRel Of
    1: Begin
        // frxRelDiferencaGmlJ / frxRelDiferencaGmlM
        Totais['TOTDIF'] := Totais['TOTDIF'] + Dados.FieldByName('ITE_VAL_DIF1').AsCurrency;
       End;
    2: Begin
        // frxRelDiferencaGmlJ2 / frxRelDiferencaGmlM2
        Totais['TOTDIF'] := Totais['TOTDIF'] + Dados.FieldByName('ITE_VAL_DIF2').AsCurrency;
       End;
    3: Begin
        // frxRelDiferencaJ / frxRelDiferencaM
        Totais['TOTDIF'] := Totais['TOTDIF'] + Dados.FieldByName('ITE_VALDIF').AsCurrency;
       End;
    4: Begin
        // frxRel := frxRelDiferencaJ2 / frxRelDiferencaM2
        Totais['TOTDIF'] := Totais['TOTDIF'] + Dados.FieldByName('ITE_DIFVAL').AsCurrency;
       End;
    End;


End;

procedure TfrmRelBalancoEstoqueDiferenca.pVerdeVermelho(lblPermImp: TLabel; shaImprime: TShape; blnLiberado: Boolean);
Begin
  If (blnLiberado) Then
  Begin
    lblPermImp.Enabled     := True;
    shaImprime.Brush.Color := clGreen;
  End
  Else
  Begin
    lblPermImp.Enabled     := False;
    shaImprime.Brush.Color := clRed;
  End;
End;

class function TfrmRelBalancoEstoqueDiferenca.fGetSQLPED_VENDA_GARANTIA_NAO_COLETADA: string;
var strClientePedVenda_Garantia_Nao_Coletada: String;
begin
  Result := '';
  strClientePedVenda_Garantia_Nao_Coletada := fCfgSis('CCPVGC');
  If strClientePedVenda_Garantia_Nao_Coletada = '' Then
    Exit('0');
  Result := ' IFNULL((SELECT SUM(FDO_QTDITE) FROM FATDOR ' +
           '  WHERE FDO_ESPDOC = "PD" ' +
           '    AND FDO_JAFATU = 0 ' +
           '    AND FDO_CODEMP = "'+VS_StrCodEmp+'" ' +
           '    AND FDO_CODCLI = "'+strClientePedVenda_Garantia_Nao_Coletada+'" ' +
           '    AND FDO_CODITE = G.ITE_CODITE), 0) ';
end;

End.
