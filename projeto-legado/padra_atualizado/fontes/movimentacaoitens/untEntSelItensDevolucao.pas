unit untEntSelItensDevolucao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Grids, DBGridCitel, DBGrids, Menus, StdCtrls, Buttons, ExtCtrls, DB,
  Uni, untModulo, AppEvnts, UniClientDataSet, UniDataSetProvider, BitBtnLockedIncrem, MemDS,
  DBAccess, Datasnap.Provider, frxClass, frxExportCSVTestabilidade, untTipoTinta,
  Datasnap.DBClient, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCustomView, cxGridCitel, cxClasses,
  cxGridLevel, cxGrid, cxCheckBox, cxCurrencyEdit,
  cxDataControllerConditionalFormattingRulesManagerDialog, untGerarEspelhoRascunhoDANFE;

type
  TfrmEntSelItensDevolucao = class(TfrmPai)
    qryItensDev: TUniQuery;
    dtsItens: TDataSource;
    qryItensDevDET_CODITE: TStringField;
    qryItensDevITE_CODGRU: TStringField;
    qryItensDevDET_DESCRI: TStringField;
    qryItensDevDET_UNIDAD: TStringField;
    qryItensDevDET_QTDITE: TFloatField;
    qryItensDevDET_VALIPI: TFloatField;
    qryItensDevDET_TOTITE: TFloatField;
    qryItensDevDET_UNITAR: TFloatField;
    qryItensDevAUTOINCREM: TStringField;
    qryItensDevDET_ALQIPI: TFloatField;
    qryItensDevDET_BASIPI: TFloatField;
    qryItensDevDET_NUMDOC: TStringField;
    qryItensDevDET_ESPDOC: TStringField;
    qryItensDevDET_CODEMP: TStringField;
    qryItensDevDET_CODCLI: TStringField;
    qryItensDevDET_CODACA: TStringField;
    qryItensDevDET_PROACA: TStringField;
    qryItensDevDET_EMPACA: TStringField;
    qryItensDevACA_SALDOS: TFloatField;
    qryItensDevDET_PRECUS: TFloatField;
    cdsItensDev: TUniClientDataSet;
    cdsItensDevDET_CODITE: TStringField;
    cdsItensDevITE_CODGRU: TStringField;
    cdsItensDevDET_DESCRI: TStringField;
    cdsItensDevDET_UNIDAD: TStringField;
    cdsItensDevDET_QTDITE: TFloatField;
    cdsItensDevDET_UNITAR: TFloatField;
    cdsItensDevDET_VALIPI: TFloatField;
    cdsItensDevDET_TOTITE: TFloatField;
    cdsItensDevDET_ALQIPI: TFloatField;
    cdsItensDevDET_BASIPI: TFloatField;
    cdsItensDevAUTOINCREM: TStringField;
    cdsItensDevDET_NUMDOC: TStringField;
    cdsItensDevDET_ESPDOC: TStringField;
    cdsItensDevDET_CODEMP: TStringField;
    cdsItensDevDET_CODCLI: TStringField;
    cdsItensDevDET_CODACA: TStringField;
    cdsItensDevDET_PROACA: TStringField;
    cdsItensDevDET_EMPACA: TStringField;
    cdsItensDevACA_SALDOS: TFloatField;
    cdsItensDevITEATI: TStringField;
    cdsItensDevIMPLIS: TStringField;
    cdsItensDevDET_PRECUS: TFloatField;

    dspItensDev: TUniDataSetProvider;
    qryItensDevDET_CODMOT: TStringField;
    cdsItensDevDET_CODMOT: TStringField;
    btnConfirma: TBitBtnLocked;
    qryItensDevDET_CODDIV: TStringField;
    cdsItensDevDET_CODDIV: TStringField;
    qryItensDevDET_DESESP: TFloatField;
    cdsItensDevDET_DESESP: TFloatField;
    qryItensDevDET_EMP_PD: TStringField;
    cdsItensDevDET_EMP_PD: TStringField;
    cdsItensDevREPOST: TStringField;
    qryItensDevREPOST: TStringField;
    cxgItensLevel: TcxGridLevel;
    cxgItensTableView: TcxGridDBTableViewCitel;
    cxgItens: TcxGridCitel;
    cxgItensDET_CODITE: TcxGridDBColumn;
    cxgItensITE_CODGRU: TcxGridDBColumn;
    cxgItensDET_DESCRI: TcxGridDBColumn;
    cxgItensDET_UNIDAD: TcxGridDBColumn;
    cxgItensDET_QTDITE: TcxGridDBColumn;
    cxgItensDET_UNITAR: TcxGridDBColumn;
    cxgItensDET_VALIPI: TcxGridDBColumn;
    cxgItensDET_TOTITE: TcxGridDBColumn;
    cxgItensAUTOINCREM: TcxGridDBColumn;
    cxgItenQTDDEV: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cdsItensDevQTDDEV: TFloatField;
    qryItensDevQTDDEV: TFloatField;
    qryItensDevDET_VALICM: TFloatField;
    qryItensDevDET_BASICM: TFloatField;
    qryItensDevDET_VALRET: TFloatField;
    qryItensDevDET_BASRET: TFloatField;
    qryItensDevDET_DESACE: TFloatField;
    qryItensDevDET_VAL_RT: TFloatField;
    qryItensDevDET_VALCOF: TFloatField;
    qryItensDevDET_BASPIS: TFloatField;
    qryItensDevDET_VALPIS: TFloatField;
    qryItensDevDET_BASCOF: TFloatField;
    qryItensDevDET_PERBAS: TFloatField;
    qryItensDevDET_PERRED: TFloatField;
    qryItensDevDET_ALQICM: TFloatField;
    qryItensDevDET_ALQRET: TFloatField;
    qryItensDevDET_INCPIS: TStringField;
    qryItensDevDET_PEBAST: TFloatField;
    qryItensDevDET_ALQCOF: TFloatField;
    qryItensDevDET_ALQPIS: TFloatField;
    qryItensDevDET_CSTCOF: TStringField;
    qryItensDevDET_CSTPIS: TStringField;
    cdsItensDevDET_VALICM: TFloatField;
    cdsItensDevDET_BASICM: TFloatField;
    cdsItensDevDET_VALRET: TFloatField;
    cdsItensDevDET_BASRET: TFloatField;
    cdsItensDevDET_DESACE: TFloatField;
    cdsItensDevDET_VAL_RT: TFloatField;
    cdsItensDevDET_VALCOF: TFloatField;
    cdsItensDevDET_BASPIS: TFloatField;
    cdsItensDevDET_VALPIS: TFloatField;
    cdsItensDevDET_BASCOF: TFloatField;
    cdsItensDevDET_PERBAS: TFloatField;
    cdsItensDevDET_PERRED: TFloatField;
    cdsItensDevDET_ALQICM: TFloatField;
    cdsItensDevDET_ALQRET: TFloatField;
    cdsItensDevDET_INCPIS: TStringField;
    cdsItensDevDET_PEBAST: TFloatField;
    cdsItensDevDET_ALQCOF: TFloatField;
    cdsItensDevDET_ALQPIS: TFloatField;
    cdsItensDevDET_CSTCOF: TStringField;
    cdsItensDevDET_CSTPIS: TStringField;
    cdsItensDevDET_NR_COF: TStringField;
    qryItensDevDET_NR_COF: TStringField;
    qryItensDevDET_NR_PIS: TStringField;
    cdsItensDevDET_NR_PIS: TStringField;
    btnMarDes: TBitBtnLocked;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    qryItensDevDET_CODFIS: TStringField;
    cdsItensDevDET_CODFIS: TStringField;
    qryItensDevDET_CODUNI: TStringField;
    cdsItensDevDET_CODUNI: TStringField;
    cxgItensMAR_DESMAR: TcxGridDBColumn;
    cdsItensDevMAR_DESMAR: TStringField;
    qryItensDevMAR_DESMAR: TStringField;
    cdsItensDevOBSP_1: TStringField;
    cdsItensDevOBSP_2: TStringField;
    qryItensDevOBSP_1: TStringField;
    qryItensDevOBSP_2: TStringField;
    qryItensDevCODVEN: TStringField;
    cdsItensDevCODVEN: TStringField;
    qryItensDevDET_TOTFRE: TFloatField;
    cdsItensDevDET_TOTFRE: TFloatField;
    cdsItensDevDET_TABPRE: TStringField;
    qryItensDevDET_TABPRE: TStringField;
    qryItensDevDET_UNIVIS: TFloatField;
    cdsItensDevDET_UNIVIS: TFloatField;
    cdsItensDevVALIPI: TFloatField;
    cdsItensDevBASIPI: TFloatField;
    cdsItensDevVALICM: TFloatField;
    cdsItensDevBASICM: TFloatField;
    cdsItensDevVALRET: TFloatField;
    cdsItensDevBASRET: TFloatField;
    cdsItensDevDESACE: TFloatField;
    cdsItensDevTOTFRE: TFloatField;
    cdsItensDevVAL_RT: TFloatField;
    cdsItensDevBASPIS: TFloatField;
    cdsItensDevVALPIS: TFloatField;
    cdsItensDevBASCOF: TFloatField;
    cdsItensDevQTDORI: TFloatField;
    qryItensDevVALIPI: TFloatField;
    qryItensDevBASIPI: TFloatField;
    qryItensDevVALICM: TFloatField;
    qryItensDevBASICM: TFloatField;
    qryItensDevVALRET: TFloatField;
    qryItensDevBASRET: TFloatField;
    qryItensDevDESACE: TFloatField;
    qryItensDevTOTFRE: TFloatField;
    qryItensDevVAL_RT: TFloatField;
    qryItensDevVALCOF: TFloatField;
    qryItensDevBASPIS: TFloatField;
    qryItensDevBASCOF: TFloatField;
    qryItensDevQTDORI: TFloatField;
    qryItensDevTOTITE: TFloatField;
    cdsItensDevTOTITE: TFloatField;
    qryItensDevVALPIS: TFloatField;
    cdsItensDevVALCOF: TFloatField;
    qryItensDevDESESP: TFloatField;
    cdsItensDevDESESP: TFloatField;
    cxgItensNUMSER: TcxGridDBColumn;
    cdsItensDevNUMSER: TStringField;
    qryItensDevNUMSER: TStringField;
    qryItensDevDET_PROEMB: TStringField;
    cdsItensDevDET_PROEMB: TStringField;
    cxgItensDET_DTAENT: TcxGridDBColumn;
    cxgItensDET_NUMDOC: TcxGridDBColumn;
    cxgItensDET_ESPDOC: TcxGridDBColumn;
    cxgItensDET_CODEMP: TcxGridDBColumn;
    qryItensDevDET_DTAENT: TDateField;
    cdsItensDevDET_DTAENT: TDateField;
    cdsItensDevDET_NUMLOT: TStringField;
    qryItensDevNUMLOT: TStringField;
    cdsItensDevBFCPST: TFloatField;
    cdsItensDevPFCPST: TFloatField;
    cdsItensDevVFCPST: TFloatField;
    qryItensDevDET_BFCPST: TFloatField;
    qryItensDevDET_PFCPST: TFloatField;
    qryItensDevDET_VFCPST: TFloatField;
    cdsItensDevDET_BFCPST: TFloatField;
    cdsItensDevDET_PFCPST: TFloatField;
    cdsItensDevDET_VFCPST: TFloatField;
    qryItensDevBFCPST: TFloatField;
    qryItensDevVFCPST: TFloatField;
    qryItensDevPFCPST: TFloatField;
    cdsItensDevDET_IDEPRO: TStringField;
    qryItensDevDET_IDEPRO: TStringField;
    cdsItensDevDET_ITETIN: TStringField;
    qryItensDevDET_ITETIN: TStringField;
    cdsItensDevBASFCP: TFloatField;
    cdsItensDevPERFCP: TFloatField;
    cdsItensDevVALFCP: TFloatField;
    cdsItensDevICD_BASFCP: TFloatField;
    cdsItensDevICD_PERFCP: TFloatField;
    cdsItensDevICD_VALFCP: TFloatField;
    
    qryItensDevBASFCP: TFloatField;
    qryItensDevPERFCP: TFloatField;
    qryItensDevVALFCP: TFloatField;
    qryItensDevICD_BASFCP: TFloatField;
    qryItensDevICD_PERFCP: TFloatField;
    qryItensDevICD_VALFCP: TFloatField;
    cdsItensDevTABELA: TStringField;
    qryItensDevTABELA: TStringField;
    qryItensDevINCORI: TStringField;
    cdsItensDevINCORI: TStringField;
    qryItensDevITEATI: TStringField;
    qryItensDevIMPLIS: TStringField;
    cxgItensITE_CODFAB: TcxGridDBColumn;
    cdsItensDevITE_CODFAB: TStringField;
    qryItensDevITE_CODFAB: TStringField;
    cdsItensDevDET_SERIE_: TStringField;
    qryItensDevDET_SERIE_: TStringField;
    btnMarDesTodos: TBitBtnLocked;
    cdsItensDevUNICRD: TFloatField;
    qryItensDevUNICRD: TFloatField;
    btnEspelhoNF: TBitBtnLocked;
    cdsItensDevINCFUT: TStringField;
    qryItensDevINCFUT: TStringField;


    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgItensTableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure cdsItensDevBeforePost(DataSet: TDataSet);
    procedure btnMarDesClick(Sender: TObject);
    procedure cxgItensExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnMarDesTodosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnEspelhoNFClick(Sender: TObject);
  private
    { Private declarations }
    FSelGarantiaAD : Boolean;
    FstrAutDev: String;

    blnUtiliza_AD: Boolean;

    stlListSelecao : TStringList;
    cdsItensDevTmp : TUniClientDataSet;
    blnCdsCarregado: boolean;
    intDeqTem      : Integer;

    FblnAcessadoViaRetornoConsignacao : Boolean;

    function fGetItensDisponiveis: boolean;

    procedure pAddListaQuery;
    function fRetQtdDevolvida(strCodite, strDocDev, strEspDev, strEmpDev,
      strCliDev: String): Double;
    procedure pCriaClientItensDev;
    function fTemDevParcial: Boolean;
    function fPodeSelecionarItem : Boolean;

  public
    strCodcli: String;
    blnReabreAD  : Boolean;
    blnTravaAD   : Boolean;
    Procedure pCarregaCDSItens(strDocSel, strAutDev: string; blnMarcaRepostoSimNao : Boolean = False; strEmpDev: String = '');

    function fInLista: Boolean;
    Function fTemTintadeMaquina: Boolean;

    property blnTemItensDisponiveis           : boolean read fGetItensDisponiveis;
    property blnAcessadoViaRetornoConsignacao : Boolean read FblnAcessadoViaRetornoConsignacao  write FblnAcessadoViaRetornoConsignacao;
  end;

var
  frmEntSelItensDevolucao: TfrmEntSelItensDevolucao;

implementation

uses StrUtils, untFuncoesSimples, Math, untObsGarantia, untCadPro, untCadLote, untGerarEspelhoEntMerDev, untGarant, gerarEspelhoEntMerDev.DTO;

{$R *.dfm}

function TfrmEntSelItensDevolucao.fGetItensDisponiveis: boolean;
begin
  Result := False;
  if blnCdsCarregado Then
  Begin
    cdsItensDev.Filtered := False;
    cdsItensDev.Filter   := 'DET_QTDITE > 0';
    cdsItensDev.Filtered := True;
    Result := cdsItensDev.RecordCount > 0;
  end;
end;

function TfrmEntSelItensDevolucao.fInLista: Boolean;
begin
  Result := stlListselecao.IndexOf(cdsItensDev.Fieldbyname('AUTOINCREM').AsString) > -1
end;

procedure TfrmEntSelItensDevolucao.pAddListaQuery;
var
  strAuto,
  strCodIte,
  strCodEmp  : String;
  intIndex : integer;
  objCadLot: TCadLot;
begin {AddListaQuery}
  If cdsItensDev.IsEmpty Then
    Exit;

  If Not fPodeSelecionarItem Then
    Exit;

  strAuto  := cdsItensDev.FieldByName('AUTOINCREM').AsString;
  intIndex := stlListSelecao.IndexOf(strAuto);
  If intIndex > -1 then
    stlListSelecao.Delete(intIndex)
  Else
  Begin
    stlListSelecao.Add(strAuto);

    strCodIte := cdsItensDev.FieldByName('DET_CODITE').AsString;
    strCodEmp := cdsItensDev.FieldByName('DET_CODEMP').AsString;
    If Not fPermiteReceberDevolucao(strCodIte, strCodEmp) Then
    Begin
      fMensagem('', 'O Item selecionado está marcado em seu cadastro para não receber devolução!', ['&OK']);
      stlListSelecao.Delete(stlListSelecao.IndexOf(strAuto));
      cxgItensTableView.Site.Refresh;
      Exit;
    End;

    If FSelGarantiaAD Then
    Begin
      //Verifica se tem Lote Principal de Garantia;
      objCadLot:= TCadLot.Create(Nil);
      If (not TCadLot.fItemSemNenhumLoteEmpresa(cdsItensDev.FieldByName('DET_CODITE').AsString)) And
         (not objCadLot.fExisteLotePrincipalGarantia(cdsItensDev.FieldByName('DET_CODITE').AsString, VS_strCodEmp)) Then
      Begin
        fMensagem('', 'O Item não tem um lote principal para garantia, cadastre um lote para garantia antes de continuar!', ['&OK']);
        FreeAndNil(objCadLot);
        stlListSelecao.Delete(stlListSelecao.IndexOf(strAuto));
        cxgItensTableView.Site.Refresh;
        Exit;
      End;

      FreeAndNil(objCadLot);

      cdsItensDev.Edit;

      Try
        pCriarFormularios(TfrmObsGarantia, frmObsGarantia);
        frmObsGarantia.edtObs1.Text := cdsItensDev.FieldByName('OBSP_1').AsString;
        frmObsGarantia.edtObs2.Text := cdsItensDev.FieldByName('OBSP_2').AsString;

        If frmObsGarantia.ShowModal = mrOk Then
        Begin
          cdsItensDev.FieldByName('OBSP_1').AsString := frmObsGarantia.edtObs1.Text;
          cdsItensDev.FieldByName('OBSP_2').AsString := frmObsGarantia.edtObs2.Text;
        End;

      Finally
        pFreeAndNil(frmObsGarantia);
      End;

      cdsItensDev.Post;
    End;

  End;

  btnConfirma.Enabled := stlListSelecao.Count > 0;

  cxgItensTableView.Site.Refresh;
end; {AddListaQuery}

procedure TfrmEntSelItensDevolucao.pCarregaCDSItens(strDocSel, strAutDev: String; blnMarcaRepostoSimNao : Boolean = False; strEmpDev: String = '');
  Const
    UNITARIO_LIQUIDO = '((D.DET_TOTITE - D.DET_DESESP - DET_DESCFF) / D.DET_QTDITE)';
  Var
    strSQL      : String;
    stlDocSel   : TStringList;
    intContador : Integer;
    fltDevolvido: Double;
    fltValUnitar: Double;
    fltValPromocAtual: Double;
    fltMenorValorAVis: Double;
    sqlCampoCredito: String;
begin
  inherited;
  FstrAutDev := strAutDev;
  strCodcli := strCodCli;
  blnUtiliza_AD := Not fEmptyStr(FstrAutDev);
  FSelGarantiaAD := Not fEmptyStr(strAutDev) And blnMarcaRepostoSimNao;

  stlDocSel := TStringList.Create;
  stlDocSel.CommaText := Trim(AnsiReplaceStr(AnsiReplaceStr(strDocSel,#39,''),'"',''));

  strSQL := '';
  strSQL := strSQL + 'SELECT ';

  If Not fEmptyStr(strAutDev) Then
    strSQL := strSQL + '  DISTINCT ';

  strSQL := strSQL + '  D.DET_CODITE, ';
  strSQL := strSQL + '  ITE_CODGRU, ';
  strSQL := strSQL + '  D.DET_DESCRI, ';
  strSQL := strSQL + '  CAST("MOVDET" AS CHAR(6)) AS TABELA, ';
  strSQL := strSQL + '  (SELECT UNI_SIGUNI FROM CADUNI WHERE UNI_CODUNI = D.DET_UNIDAD LIMIT 1) AS DET_UNIDAD, ';
  strSQL := strSQL + '  D.DET_PROEMB, ';
  strSQL := strSQL + '  ITE_CODFAB, '; //CÓDIGO DE FÁBRICA DO ITEM

  If fEmptyStr(strAutDev) Then
  Begin
    strSQL := strSQL + '  D.DET_QTDITE, ';
    strSQL := strSQL + '  0.0000 AS QTDDEV, '
  End Else
  Begin
    strSQL := strSQL + '  A.DET_QTDDEV AS DET_QTDITE, ';
    strSQL := strSQL + '  A.DET_QTDDEV AS QTDDEV,     ';
  End;

  strSQL := strSQL + '  CAST("" AS CHAR(70)) AS OBSP_1, ';
  strSQL := strSQL + '  CAST("" AS CHAR(70)) AS OBSP_2, ';

  If fCfgSis('SUGPDV') = '1' Then //Configurado para trazer como sugestao o preco praticado na venda
    strSQL := strSQL + 'D.DET_UNITAR,'
  Else
  strSQL := strSQL + UNITARIO_LIQUIDO + ' AS DET_UNITAR, ';
  strSQL := strSQL + '  D.DET_TABPRE, ';
  strSQL := strSQL + '  T.DET_UNIVIS, ';

  sqlCampoCredito := fScriptValCredito('D','T');

  If fEmptyStr(strAutDev) Then
  Begin
    strSQL := strSQL + '  D.DET_VALIPI, ';
    strSQL := strSQL + '  D.DET_TOTITE, ';
    strSQL := strSQL + '  (('+ sqlCampoCredito +') / D.DET_QTDITE) AS UNICRD, ';
    strSQL := strSQL + '  D.DET_BASIPI, ';
    strSQL := strSQL + '  D.DET_VALICM, ';
    strSQL := strSQL + '  D.DET_BASICM, ';
    strSQL := strSQL + '  D.DET_VALRET, ';
    strSQL := strSQL + '  D.DET_BASRET, ';
    strSQL := strSQL + '  D.DET_DESACE, ';
    strSQL := strSQL + '  D.DET_TOTFRE, ';

    strSQL := strSQL + '  T.DET_VAL_RT, ';
    strSQL := strSQL + '  T.DET_VALCOF, ';
    strSQL := strSQL + '  T.DET_BASPIS, ';
    strSQL := strSQL + '  T.DET_VALPIS, ';
    strSQL := strSQL + '  T.DET_BASCOF, ';

    strSQL := strSQL + '  IFNULL(T.DET_BFCPST, 0.00) AS DET_BFCPST, ';
    strSQL := strSQL + '  IFNULL(T.DET_PFCPST, 0.00) AS DET_PFCPST, ';
    strSQL := strSQL + '  IFNULL(T.DET_VFCPST, 0.00) AS DET_VFCPST,  ';

    strSQL := strSQL + '  IFNULL(ICD_PERFCP, 0.00) AS ICD_PERFCP,';
    strSQL := strSQL + '  IFNULL(ICD_VALFCP, 0.00) AS ICD_VALFCP,';
    strSQL := strSQL + '  IFNULL(ICD_BASFCP, 0.00) AS ICD_BASFCP,';

    strSQL := strSQL + '  D.DET_DESESP AS DESESP, ';
    strSQL := strSQL + '  D.DET_QTDITE AS QTDORI, ';
    strSQL := strSQL + '  D.DET_VALIPI AS VALIPI, ';
    strSQL := strSQL + '  D.DET_TOTITE AS TOTITE, ';
    strSQL := strSQL + '  D.DET_BASIPI AS BASIPI, ';
    strSQL := strSQL + '  D.DET_VALICM AS VALICM, ';
    strSQL := strSQL + '  D.DET_BASICM AS BASICM, ';
    strSQL := strSQL + '  D.DET_VALRET AS VALRET, ';
    strSQL := strSQL + '  D.DET_BASRET AS BASRET, ';
    strSQL := strSQL + '  D.DET_DESACE AS DESACE, ';
    strSQL := strSQL + '  D.DET_TOTFRE AS TOTFRE, ';

    strSQL := strSQL + '  T.DET_VAL_RT AS VAL_RT, ';
    strSQL := strSQL + '  T.DET_VALCOF AS VALCOF, ';
    strSQL := strSQL + '  T.DET_BASPIS AS BASPIS, ';
    strSQL := strSQL + '  T.DET_VALPIS AS VALPIS, ';
    strSQL := strSQL + '  T.DET_BASCOF AS BASCOF, ';

    strSQL := strSQL + '  IFNULL(T.DET_BFCPST, 0.00) AS BFCPST, ';
    strSQL := strSQL + '  IFNULL(T.DET_PFCPST, 0.00) AS PFCPST, ';
    strSQL := strSQL + '  IFNULL(T.DET_VFCPST, 0.00) AS VFCPST,  ';

    strSQL := strSQL + '  IFNULL(ICD_PERFCP, 0.00) AS PERFCP, ';
    strSQL := strSQL + '  IFNULL(ICD_VALFCP, 0.00) AS VALFCP, ';
    strSQL := strSQL + '  IFNULL(ICD_BASFCP, 0.00) AS BASFCP,  ';


    strSQL := strSQL + '  " " AS DET_CODMOT, ';
  End Else
  Begin
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, D.DET_VALIPI, (ESPDET.DET_VALIPI/ESPDET.DET_QTDITE) * A.DET_QTDDEV) AS DET_VALIPI, ';
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, D.DET_VLRCON, (ESPDET.DET_VLRCON/ESPDET.DET_QTDITE) * A.DET_QTDDEV) AS DET_TOTITE, ';
    strSQL := strSQL + '  (('+ sqlCampoCredito +') / D.DET_QTDITE) AS UNICRD, ';
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, D.DET_BASIPI, (ESPDET.DET_BASIPI/ESPDET.DET_QTDITE) * A.DET_QTDDEV) AS DET_BASIPI, ';
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, D.DET_VALICM, (ESPDET.DET_VALICM/ESPDET.DET_QTDITE) * A.DET_QTDDEV) AS DET_VALICM, ';
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, D.DET_BASICM, (ESPDET.DET_BASICM/ESPDET.DET_QTDITE) * A.DET_QTDDEV) AS DET_BASICM, ';
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, D.DET_VALRET, (ESPDET.DET_VALRET/ESPDET.DET_QTDITE) * A.DET_QTDDEV) AS DET_VALRET, ';
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, D.DET_BASRET, (ESPDET.DET_BASRET/ESPDET.DET_QTDITE) * A.DET_QTDDEV) AS DET_BASRET, ';
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, D.DET_DESACE, (ESPDET.DET_DESACE/ESPDET.DET_QTDITE) * A.DET_QTDDEV) AS DET_DESACE, ';
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, D.DET_TOTFRE, (ESPDET.DET_TOTFRE/ESPDET.DET_QTDITE) * A.DET_QTDDEV) AS DET_TOTFRE, ';

    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, T.DET_VAL_RT, (ESPDET.DET_VAL_RT/ESPDET.DET_QTDITE) * A.DET_QTDDEV) AS DET_VAL_RT, ';
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, T.DET_VALCOF, (ESPDET.DET_VALCOF/ESPDET.DET_QTDITE) * A.DET_QTDDEV) AS DET_VALCOF, ';
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, T.DET_BASPIS, (ESPDET.DET_BASPIS/ESPDET.DET_QTDITE) * A.DET_QTDDEV) AS DET_BASPIS, ';
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, T.DET_VALPIS, (ESPDET.DET_VALPIS/ESPDET.DET_QTDITE) * A.DET_QTDDEV) AS DET_VALPIS, ';
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, T.DET_BASCOF, (ESPDET.DET_BASCOF/ESPDET.DET_QTDITE) * A.DET_QTDDEV) AS DET_BASCOF, ';

    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, IFNULL(T.DET_BFCPST, 0.00), (IFNULL(ESPDET.DET_BFCPST, 0.00)/ESPDET.DET_QTDITE) * A.DET_QTDDEV) AS DET_BFCPST, ';
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, IFNULL(T.DET_PFCPST, 0.00), (IFNULL(ESPDET.DET_PFCPST, 0.00)/ESPDET.DET_QTDITE) * A.DET_QTDDEV) AS DET_PFCPST, ';
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, IFNULL(T.DET_VFCPST, 0.00), (IFNULL(ESPDET.DET_VFCPST, 0.00)/ESPDET.DET_QTDITE) * A.DET_QTDDEV) AS DET_VFCPST,  ';

    strSQL := strSQL + '  (IFNULL(ICD_BASFCP, 0.00)/D.DET_QTDITE) * A.DET_QTDDEV AS ICD_BASFCP, ';
    strSQL := strSQL + '  IFNULL(ICD_PERFCP, 0.00) AS ICD_PERFCP,';
    strSQL := strSQL + '  (IFNULL(ICD_VALFCP, 0.00)/D.DET_QTDITE) * A.DET_QTDDEV AS ICD_VALFCP, ';

    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, D.DET_DESESP, ESPDET.DET_DESESP) AS DESESP, ';
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, D.DET_QTDITE, ESPDET.DET_QTDITE) AS QTDORI, ';
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, D.DET_VALIPI, ESPDET.DET_VALIPI) AS VALIPI, ';
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, D.DET_TOTITE, ESPDET.DET_TOTITE) AS TOTITE, ';
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, D.DET_BASIPI, ESPDET.DET_BASIPI) AS BASIPI, ';
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, D.DET_VALICM, ESPDET.DET_VALICM) AS VALICM, ';
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, D.DET_BASICM, ESPDET.DET_BASICM) AS BASICM, ';
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, D.DET_VALRET, ESPDET.DET_VALRET) AS VALRET, ';
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, D.DET_BASRET, ESPDET.DET_BASRET) AS BASRET, ';
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, D.DET_DESACE, ESPDET.DET_DESACE) AS DESACE, ';
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, D.DET_TOTFRE, ESPDET.DET_TOTFRE) AS TOTFRE, ';

    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, T.DET_VAL_RT, ESPDET.DET_VAL_RT) AS VAL_RT, ';
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, T.DET_VALCOF, ESPDET.DET_VALCOF) AS VALCOF, ';
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, T.DET_BASPIS, ESPDET.DET_BASPIS) AS BASPIS, ';
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, T.DET_VALPIS, ESPDET.DET_VALPIS) AS VALPIS, ';
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, T.DET_BASCOF, ESPDET.DET_BASCOF) AS BASCOF, ';

    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, T.DET_BFCPST, ESPDET.DET_BFCPST) AS BFCPST, ';
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, T.DET_PFCPST, ESPDET.DET_PFCPST) AS PFCPST, ';
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, T.DET_VFCPST, ESPDET.DET_VFCPST) AS VFCPST, ';

    strSQL := strSQL + '  ICD_BASFCP AS BASFCP, ';
    strSQL := strSQL + '  ICD_PERFCP AS PERFCP, ';
    strSQL := strSQL + '  ICD_VALFCP AS VALFCP, ';

    strSQL := strSQL + '  A.DET_CODMOT, ';

    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, D.DET_ALQICM, ESPDET.DET_ALQICM) AS DET_ALQICM, ';
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, D.DET_ALQIPI, ESPDET.DET_ALQIPI) AS DET_ALQIPI, ';
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, D.DET_INCPIS, ESPDET.DET_INCPIS) AS DET_INCPIS, ';
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, D.DET_CODFIS, ESPDET.DET_CODFIS) AS DET_CODFIS, ';
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, T.DET_PEBAST, ESPDET.DET_PEBAST) AS DET_PEBAST, ';
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, T.DET_ALQCOF, ESPDET.DET_ALQCOF) AS DET_ALQCOF, ';
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, T.DET_ALQPIS, ESPDET.DET_ALQPIS) AS DET_ALQPIS, ';
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, T.DET_CSTCOF, ESPDET.DET_CSTCOF) AS DET_CSTCOF, ';
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, T.DET_CSTPIS, ESPDET.DET_CSTPIS) AS DET_CSTPIS, ';
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, T.DET_NR_PIS, ESPDET.DET_NR_PIS) AS DET_NR_PIS, ';
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, T.DET_NR_COF, ESPDET.DET_NR_COF) AS DET_NR_COF, ';
    strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, A.AUTOINCREM, ESPDET.AUTOINCREM) AS AUTOINCREM, ';
    If fCfgSis('SUGPDV') = '1' Then //Configurado para trazer como sugestao o preco praticado na venda
      strSQL := strSQL + '  IF(ESPDET.AUTOINCREM IS NULL, D.DET_DESESP, ESPDET.DET_DESESP) AS DET_DESESP ,  '
    Else
      strSQL := strSQL + '  0.00 DET_DESESP, ';

  End;
  If fEmptyStr(strAutDev) Then
  Begin
    strSQL := strSQL + '  D.DET_ALQICM, ';
    strSQL := strSQL + '  D.DET_ALQIPI, ';
    strSQL := strSQL + '  D.DET_INCPIS, ';
    strSQL := strSQL + '  D.DET_CODFIS, ';
    strSQL := strSQL + '  T.DET_PEBAST, ';
    strSQL := strSQL + '  T.DET_ALQCOF, ';
    strSQL := strSQL + '  T.DET_ALQPIS, ';
    strSQL := strSQL + '  T.DET_CSTCOF, ';
    strSQL := strSQL + '  T.DET_CSTPIS, ';
    strSQL := strSQL + '  T.DET_NR_PIS, ';
    strSQL := strSQL + '  T.DET_NR_COF, ';
    strSQL := strSQL + '  D.AUTOINCREM, ';
    If fCfgSis('SUGPDV') = '1' Then //Configurado para trazer como sugestao o preco praticado na venda
      strSQL := strSQL + '  D.DET_DESESP,  '
    Else
      strSQL := strSQL + '  0.00 DET_DESESP, ';

  End;
  strSQL := strSQL + '  D.DET_ALQRET, ';

  strSQL := strSQL + '  D.DET_PERBAS, ';
  strSQL := strSQL + '  D.DET_PERRED, ';
  strSQL := strSQL + '  MAR_DESMAR  , ';

  strSQL := strSQL + '  D.DET_UNIDAD AS DET_CODUNI, ';


  strSQL := strSQL + '  D.AUTOINCREM AS INCORI, ';
  strSQL := strSQL + '  IFNULL(T.DET_INCFUT,"") AS INCFUT, ';
  strSQL := strSQL + '  D.DET_DTAENT, ';
  strSQL := strSQL + '  D.DET_NUMDOC, ';
  strSQL := strSQL + '  D.DET_ESPDOC, ';
  strSQL := strSQL + '  D.DET_SERIE_, ';
  strSQL := strSQL + '  D.DET_CODEMP, ';
  strSQL := strSQL + '  D.DET_CODCLI, ';
  strSQL := strSQL + '  D.DET_CODACA, ';
  strSQL := strSQL + '  D.DET_PROACA, ';
  strSQL := strSQL + '  D.DET_EMPACA, ';
  strSQL := strSQL + '  D.DET_CODDIV, ';
  strSQL := strSQL + '  D.DET_EMP_PD, ';
  strSQL := strSQL + '  D.DET_NUMLOT, ';
  strSQL := strSQL + '  D.DET_IDEPRO, ';
  strSQL := strSQL + '  D.DET_ITETIN, ';
  strSQL := strSQL + '  ACA_SALDOS,   ';
  strSQL := strSQL + '  CADITE.ITE_ITEATI AS ITEATI, ';
  strSQL := strSQL + '  ITEGER.ITE_IMPLIS AS IMPLIS, ';

  strSQL := strSQL + '  D.DET_CODVEN AS CODVEN, ';

  strSQL := strSQL + '(SELECT CAST(GROUP_CONCAT(S.SER_NUMSER) AS CHAR(255)) FROM DETSER S WHERE S.SER_SEQGER = D.AUTOINCREM )AS NUMSER, ';


  strSQL := strSQL + ' "N" AS REPOST ,';
  strSQL := strSQL + ' (D.DET_TOTCUS/ D.DET_QTDITE) AS DET_PRECUS, ';
  strSQL := strSQL + ' DET_CODFOR ';
  strSQL := strSQL + 'FROM MOVDET D ';

  strSQL := strSQL + '  JOIN MOVTRI T ';
  strSQL := strSQL + '    ON T.DET_SEQGER = D.AUTOINCREM ';

  strSQL := strSQL + '  LEFT JOIN MOVICD FC ';
  strSQL := strSQL + '    ON FC.ICD_SEQGER = D.AUTOINCREM ';

  strSQL := strSQL + '  JOIN CADITE ';
  strSQL := strSQL + '    ON CADITE.ITE_CODITE = D.DET_CODITE ';

  strSQL := strSQL + '  JOIN ITEGER ';
  strSQL := strSQL + '    ON ITEGER.ITE_CODITE = D.DET_CODITE ';
  strSQL := strSQL + '   AND ITEGER.ITE_CODEMP = D.DET_CODEMP ';

  strSQL := strSQL + '  LEFT JOIN CADMAR ';
  strSQL := strSQL + '    ON CADMAR.MAR_CODMAR = CADITE.ITE_CODMAR ';

  strSQL := strSQL + '  LEFT JOIN ACAGER ';
  strSQL := strSQL + '    ON D.DET_EMPACA = ACA_CODEMP ';
  strSQL := strSQL + '   AND D.DET_CODEMP = ACA_EMPEST ';
  strSQL := strSQL + '   AND D.DET_CODACA = ACA_CODACA ';

  If Not fEmptyStr(strAutDev) Then
  Begin
    strSQL := strSQL + ' INNER JOIN ADEDET A ON A.DET_TIP_FC = "C"          ';
    strSQL := strSQL + '                    AND A.DET_NUMDOC = D.DET_NUMDOC ';
    strSQL := strSQL + '                    AND A.DET_ESPDOC = D.DET_ESPDOC ';
    strSQL := strSQL + '                    AND A.DET_CODEMP = D.DET_CODEMP ';
    strSQL := strSQL + '                    AND A.DET_SERIE_ = D.DET_SERIE_ ';
    strSQL := strSQL + '                    AND A.DET_CODITE = D.DET_CODITE ';
    strSQL := strSQL + '                    AND A.DET_CODADE = ' + QuotedStr(strAutDev);

    if Not fEmptystr(strEmpDev) then
      strSQL := strSQL + '                    AND A.DET_CODEMP = ' + QuotedStr(strEmpDev)
    else
      strSQL := strSQL + '                    AND A.DET_CODEMP = ' + QuotedStr(VS_strCodEmp);

    If blnMarcaRepostoSimNao Then
      strSQL := strSQL + '                  AND A.DET_GARANT = "S" '
    Else
      strSQL := strSQL + '                  AND A.DET_GARANT = "N" ';
    strSQL := strSQL + '                    AND A.DET_SEQORI = D.AUTOINCREM ';
    strSQL := strSQL + ' LEFT JOIN ESPGER ON ESPGER.GER_CODADE = ' + QuotedStr(strAutDev);
    strSQL := strSQL + ' LEFT JOIN ESPDET ON ESPDET.DET_SEQGER = ESPGER.AUTOINCREM AND ESPDET.DET_SEQDET = D.AUTOINCREM ';
  End;

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  D.DET_TIP_FC = "C" AND ';
  strSQL := strSQL + '  D.DET_PROEMB <> "S" AND ';

  strSQL := strSQL + ' ( ';
  For intContador := 0 To stlDocSel.Count -1 Do
  Begin


    strSQL := strSQL + ' ( ';
    strSQL := strSQL + '  D.DET_NUMDOC = ' + QuotedStr(Copy(stlDocSel[intContador], 01, fTamDocCadRec())) + ' AND ';
    strSQL := strSQL + '  D.DET_ESPDOC = ' + QuotedStr(Copy(stlDocSel[intContador], fTamDocCadRec() + 1, 2)) + ' AND ';
    strSQL := strSQL + '  D.DET_CODEMP = ' + QuotedStr(Copy(stlDocSel[intContador], fTamDocCadRec() + 3, 3)) + ' AND ';
    strSQL := strSQL + '  D.DET_CODCLI = ' + QuotedStr(Copy(stlDocSel[intContador], fTamDocCadRec() + 6, 8)) + ' AND ';
    strSQL := strSQL + '  IFNULL(D.DET_ORIDOC,"") = ' + QuotedStr(Copy(stlDocSel[intContador], fTamDocCadRec() + 14, 1));
    strSQL := strSQL + ' ) ';

    If intContador < stlDocSel.Count -1 Then
      strSQL := strSQL + ' OR ';

  End;

  strSQL := strSQL + ' ) ';

  If Not fEmptyStr(strAutDev) Then
   strSQL := strSQL + ' GROUP BY A.AUTOINCREM ';

  strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strSQL,'MOVDET','NOTDET'),'MOVTRI','NOTTRI'), 'MOVICD', 'NOTICD'),'T.DET_INCFUT', 'CAST("" AS CHAR(1))');

  qryItensDev.Close;
  qryItensDev.SQL.Clear;
  qryItensDev.SQL.Add(strSQL);

  cdsItensDev.Open;

  pCriaClientItensDev;

//  cxgItenQTDDEV.Visible  := FSelGarantiaAD;

    With cdsItensDev Do
    Begin
      First;

      While Not Eof Do
      Begin
        //So vai subtrair a qtde maxima de devoluçao quando não é entrada de devoluçao com AD.
        //pois quando é com AD a quantidade maxima já eh tratata na digitaçao da AD, então não pode subtrair a quantidade já devolvida.
        If fEmptyStr(strAutDev) And (not blnMarcaRepostoSimNao) Then
        Begin
          If Not cdsItensDevTmp.Locate('DET_CODITE;DET_NUMDOC;DET_ESPDOC;DET_CODEMP;DET_CODCLI',
                                       VarArrayOf([FieldByName('DET_CODITE').AsString,
                                                   FieldByName('DET_NUMDOC').AsString,
                                                   FieldByName('DET_ESPDOC').AsString,
                                                   FieldByName('DET_CODEMP').AsString,
                                                   FieldByName('DET_CODCLI').AsString]),
                                        []) Then
          Begin
            fltDevolvido := fRetQtdDevolvida( FieldByName('DET_CODITE').AsString,
                                              FieldByName('DET_NUMDOC').AsString,
                                              FieldByName('DET_ESPDOC').AsString,
                                              FieldByName('DET_CODEMP').AsString,
                                              FieldByName('DET_CODCLI').AsString );

            cdsItensDevTmp.Append;
            cdsItensDevTmp.FieldByName('DET_CODITE').AsString := FieldByName('DET_CODITE').AsString;
            cdsItensDevTmp.FieldByName('ITE_CODFAB').AsString := FieldByName('ITE_CODFAB').AsString;
            cdsItensDevTmp.FieldByName('DET_NUMDOC').AsString := FieldByName('DET_NUMDOC').AsString;
            cdsItensDevTmp.FieldByName('DET_ESPDOC').AsString := FieldByName('DET_ESPDOC').AsString;
            cdsItensDevTmp.FieldByName('DET_CODEMP').AsString := FieldByName('DET_CODEMP').AsString;
            cdsItensDevTmp.FieldByName('DET_CODCLI').AsString := FieldByName('DET_CODCLI').AsString;
            cdsItensDevTmp.FieldByName('DET_TOTDEV').AsFloat  := fltDevolvido;
            cdsItensDevTmp.FieldByName('NUMSER').AsString := FieldByName('NUMSER').AsString;

            If FSelGarantiaAD Then
              cdsItensDevTmp.FieldByName('REPOST').AsString   := 'N';
            cdsItensDevTmp.Post;
          End

          Else fltDevolvido := cdsItensDevTmp.FieldByName('DET_TOTDEV').AsFloat;

          cdsItensDevTmp.Edit;
          Edit;

          If FieldByName('DET_QTDITE').AsFloat <= cdsItensDevTmp.FieldByName('DET_TOTDEV').AsFloat Then
          Begin
            cdsItensDevTmp.FieldByName('DET_TOTDEV').AsFloat := cdsItensDevTmp.FieldByName('DET_TOTDEV').AsFloat -
                                                                FieldByName('DET_QTDITE').AsFloat;

            FieldByName('DET_QTDITE').AsFloat := 0;
          End Else
          Begin
            cdsItensDevTmp.FieldByName('DET_TOTDEV').AsFloat := 0;

            FieldByName('DET_QTDITE').AsFloat := FieldByName('DET_QTDITE').AsFloat - fltDevolvido;


          End;
        End;

        fltValUnitar := FieldByName('DET_UNITAR').AsFloat;

        If Pos(fCfgSis('SUGPDV'), '2_3_') > 0 Then
        Begin
          If fCfgSis('SUGPDV') = '2' Then
          Begin
            fltMenorValorAVis := fFormataFloat(FieldByName('DET_UNIVIS').AsFloat, 4)
          End
          Else
          Begin
            fltMenorValorAVis := fFormataFloat(fRetPrecoVenda(FieldByName('DET_CODITE').AsString, FieldByName('DET_TABPRE').AsString), 4);
            fltValPromocAtual := fFormataFloat(fRetornaValorPromocional(FieldByName('DET_CODITE').AsString, FieldByName('DET_CODCLI').AsString, FieldByName('DET_TABPRE').AsString), 4);

            If (fltValPromocAtual <> 0) Then
              fltMenorValorAVis := fFormataFloat(Min(fltMenorValorAVis, fltValPromocAtual), 4);
          End;

          If Not (cdsItensDev.State in dsEditModes) Then
          begin
            cdsItensDevTmp.Edit;
            Edit;
          End;

          If (fltMenorValorAVis <> 0) And (fFormataFloat(fltValUnitar, 4) > fltMenorValorAVis) Then
          Begin
            fltValUnitar := fltMenorValorAVis;
            FieldByName('DET_UNITAR').AsFloat := fltValUnitar;
          End;

          FieldByName('DET_TOTITE').AsFloat := FieldByName('DET_QTDITE').AsFloat * fltValUnitar;

          If fEmptyStr(strAutDev) Then
          Begin
            FieldByName('DET_DESESP').AsFloat := (FieldByName('DESESP').AsFloat / FieldByName('QTDORI').AsFloat) * FieldByName('DET_QTDITE').AsFloat;
            FieldByName('DET_VALIPI').AsFloat := (FieldByName('VALIPI').AsFloat / FieldByName('QTDORI').AsFloat) * FieldByName('DET_QTDITE').AsFloat;
            FieldByName('DET_BASIPI').AsFloat := (FieldByName('BASIPI').AsFloat / FieldByName('QTDORI').AsFloat) * FieldByName('DET_QTDITE').AsFloat;
            FieldByName('DET_VALICM').AsFloat := (FieldByName('VALICM').AsFloat / FieldByName('QTDORI').AsFloat) * FieldByName('DET_QTDITE').AsFloat;
            FieldByName('DET_BASICM').AsFloat := (FieldByName('BASICM').AsFloat / FieldByName('QTDORI').AsFloat) * FieldByName('DET_QTDITE').AsFloat;
            FieldByName('DET_VALRET').AsFloat := (FieldByName('VALRET').AsFloat / FieldByName('QTDORI').AsFloat) * FieldByName('DET_QTDITE').AsFloat;
            FieldByName('DET_BASRET').AsFloat := (FieldByName('BASRET').AsFloat / FieldByName('QTDORI').AsFloat) * FieldByName('DET_QTDITE').AsFloat;
            FieldByName('DET_DESACE').AsFloat := (FieldByName('DESACE').AsFloat / FieldByName('QTDORI').AsFloat) * FieldByName('DET_QTDITE').AsFloat;
            FieldByName('DET_TOTFRE').AsFloat := (FieldByName('TOTFRE').AsFloat / FieldByName('QTDORI').AsFloat) * FieldByName('DET_QTDITE').AsFloat;
            FieldByName('DET_VAL_RT').AsFloat := (FieldByName('VAL_RT').AsFloat / FieldByName('QTDORI').AsFloat) * FieldByName('DET_QTDITE').AsFloat;
            FieldByName('DET_VALCOF').AsFloat := (FieldByName('VALCOF').AsFloat / FieldByName('QTDORI').AsFloat) * FieldByName('DET_QTDITE').AsFloat;
            FieldByName('DET_BASPIS').AsFloat := (FieldByName('BASPIS').AsFloat / FieldByName('QTDORI').AsFloat) * FieldByName('DET_QTDITE').AsFloat;
            FieldByName('DET_VALPIS').AsFloat := (FieldByName('VALPIS').AsFloat / FieldByName('QTDORI').AsFloat) * FieldByName('DET_QTDITE').AsFloat;
            FieldByName('DET_BASCOF').AsFloat := (FieldByName('BASCOF').AsFloat / FieldByName('QTDORI').AsFloat) * FieldByName('DET_QTDITE').AsFloat;

            FieldByName('DET_BFCPST').AsFloat := (FieldByName('BFCPST').AsFloat / FieldByName('QTDORI').AsFloat) * FieldByName('DET_QTDITE').AsFloat;
            FieldByName('DET_PFCPST').AsFloat := FieldByName('PFCPST').AsFloat;
            FieldByName('DET_VFCPST').AsFloat := (FieldByName('VFCPST').AsFloat / FieldByName('QTDORI').AsFloat) * FieldByName('DET_QTDITE').AsFloat;

            FieldByName('ICD_BASFCP').AsFloat := (FieldByName('BASFCP').AsFloat / FieldByName('QTDORI').AsFloat) * FieldByName('DET_QTDITE').AsFloat;
            FieldByName('ICD_PERFCP').AsFloat := FieldByName('PERFCP').AsFloat;
            FieldByName('ICD_VALFCP').AsFloat := (FieldByName('VALFCP').AsFloat / FieldByName('QTDORI').AsFloat) * FieldByName('DET_QTDITE').AsFloat;




          End;

          FieldByName('QTDDEV').AsFloat := FieldByName('DET_QTDITE').AsFloat;

          cdsItensDevTmp.Post;
          Post;

        End;

      Next;
    End;

  End;

  cdsItensDev.Filtered := False;
  cdsItensDev.Filter   := 'DET_QTDITE > 0';
  cdsItensDev.Filtered := True;

  if fCfgSis('NUMSER', varBoolean) then
  begin
    cxgItensNUMSER.Visible := True;
  end
  else
  begin
    cxgItensNUMSER.Visible := False;
  end;

  cxgItensTableView.ApplyBestFit();

  pSetFocus(cxgItens);
  FreeAndNil(stlDocSel);
  blnCdsCarregado:= True;
end;


procedure TfrmEntSelItensDevolucao.pCriaClientItensDev;
begin
  cdsItensDevTmp := TUniClientDataSet.Create(Self);

  With cdsItensDevTmp.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DET_CODITE';
    DataType := ftString;
    Size := fTamCodIte;
  End;

  With cdsItensDevTmp.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_CODFAB';
    DataType := ftString;
    Size := 50;
  End;



  With cdsItensDevTmp.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DET_NUMDOC';
    DataType := ftString;
    Size := 12;
  End;

  With cdsItensDevTmp.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DET_ESPDOC';
    DataType := ftString;
    Size := 2;
  End;

  With cdsItensDevTmp.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DET_CODEMP';
    DataType := ftString;
    Size := 3;
  End;

  With cdsItensDevTmp.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DET_CODCLI';
    DataType := ftString;
    Size := 8;
  End;

  With cdsItensDevTmp.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DET_TOTDEV';
    DataType := ftFloat;
  End;

  With cdsItensDevTmp.FieldDefs.AddFieldDef Do
  Begin
    Name := 'REPOST';
    DataType := ftString;
    Size := 1;
  End;


  With cdsItensDevTmp.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NUMSER';
    DataType := ftString;
    Size := 255;
  End;

  With cdsItensDevTmp.FieldDefs.AddFieldDef Do
  Begin
    Name := 'UNICRD';
    DataType := ftFloat;
  End;

  cdsItensDevTmp.CreateDataSet;
  cdsItensDevTmp.IndexFieldNames := 'DET_CODITE;DET_NUMDOC;DET_ESPDOC;DET_CODEMP;DET_CODCLI';

  If Not cdsItensDevTmp.Active Then
    cdsItensDevTmp.Open;
end;

procedure TfrmEntSelItensDevolucao.btnConfirmaClick(Sender: TObject);
  Var
    intContador : Integer;
begin
  For intContador := 0 To Pred(stlListSelecao.Count) Do
  Begin
    If cdsItensDev.Locate('AUTOINCREM', stlListSelecao[intContador], []) Then
    Begin
      If cdsItensDev.FieldByName('QTDDEV').AsFloat = 0 Then
      Begin
        fMensagem('ATENÇÃO', 'Para continuar, informe a quantidade a devolver nos itens selecionados!', ['&OK']);
        Exit();
      End;
    End;
  End;

  ModalResult := mrOk;

  inherited;
end;

procedure TfrmEntSelItensDevolucao.btnEspelhoNFClick(Sender: TObject);
var
  objGerarEspelho: TGerarEspelhoDevolucaoAD;
begin
  inherited;
  try
    if blnUtiliza_AD then
    begin
      objGerarEspelho := TGerarEspelhoDevolucaoAD.Create;
      objGerarEspelho.fGerarEspelho(strCodcli, FstrAutDev, VS_strCodEmp);
    end
    else
    begin
      objGerarEspelho := TGerarEspelhoEntMerDev.Create;
      TGerarEspelhoEntMerDev(objGerarEspelho).fGerarEspelhoDevolucao(strCodcli, cdsItensDev, True);
    end;

  finally
    FreeAndNil(objGerarEspelho);
  end;
end;

procedure TfrmEntSelItensDevolucao.btnMarDesClick(Sender: TObject);
begin
  inherited;

  pAddListaQuery;
end;

procedure TfrmEntSelItensDevolucao.btnMarDesTodosClick(Sender: TObject);
  Var
    blnSetQtdDevQtdTot : Boolean;
    intIndex : Integer;
begin
  inherited;

  cdsItensDev.DisableControls;
  Try
    If stlListSelecao.Count = 0 Then
    Begin
      blnSetQtdDevQtdTot := fMensagem('ATENÇÃO', 'Deseja preencher a quantidade a devolver com a quantidade total do envio?', ['&Sim', '&NÃO']) = 1;

      // Marcar todos
      cdsItensDev.First;
      While Not cdsItensDev.Eof Do
      Begin
        pAddListaQuery;

        If blnSetQtdDevQtdTot Then
        Begin
          cdsItensDev.Edit;
          cdsItensDev.FieldByName('QTDDEV').AsFloat := cdsItensDev.FieldByName('DET_QTDITE').AsFloat;
          cdsItensDev.Post;
        End;

        cdsItensDev.Next;
      End;
    End
    Else
    Begin
      cdsItensDev.First;
      While Not cdsItensDev.Eof Do
      Begin
        intIndex := stlListSelecao.IndexOf(cdsItensDev.FieldByName('AUTOINCREM').AsString);
        If intIndex > -1 then
          stlListSelecao.Delete(intIndex);

        cdsItensDev.Next;
      End;
    End;
  Finally
    cdsItensDev.EnableControls;
    cxgItensTableView.Site.Refresh;
  End;
end;

procedure TfrmEntSelItensDevolucao.cdsItensDevBeforePost(DataSet: TDataSet);
begin
  inherited;

  With DataSet Do
  Begin
    If RoundTo(FieldByName('QTDDEV').AsFloat, -2) > RoundTo(FieldByName('DET_QTDITE').AsFloat, -2) Then
    Begin
      pMensagemOk('A quantidade devolvida deve ser menor ou igual a quantidade disponível!');
      Cancel;
      Abort;
    End;

    If FieldByName('QTDDEV').AsFloat < 0 Then
    Begin
      pMensagemOk('A quantidade devolvida deve ser maior que zero!');
      Cancel;
      Abort;
    End;

  End;
end;

procedure TfrmEntSelItensDevolucao.cxgItensExit(Sender: TObject);
begin
  inherited;
  cdsItensDev.CheckBrowseMode;
end;

procedure TfrmEntSelItensDevolucao.cxgItensTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If stlListselecao.IndexOf( Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensAUTOINCREM.Index]) > -1 Then
    ACanvas.Font.Color := clBlue
  Else
    ACanvas.Font.Color := clBlack;
end;

procedure TfrmEntSelItensDevolucao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  blnReabreAD := False;
  If FSelGarantiaAD And (ModalResult = mrOK) Then
  Begin
    If (stlListSelecao.Count <> cdsItensDev.RecordCount) Or fTemDevParcial Then
      If fMensagem('', 'Recebimento parcial!' + #13 + 'Deseja manter os produtos não recebidos para receber em outra Garantia?', ['&Sim', '&Não'], 2) = 1 Then
        blnReabreAD := True;
  End;

end;

Function TfrmEntSelItensDevolucao.fTemDevParcial : Boolean;
Begin
  Result := False;
  Try
    cdsItensDev.DisableControls;
    cdsItensDev.First;
    While Not cdsItensDev.Eof Do
    Begin
      If cdsItensDev.FieldByName('DET_QTDITE').AsFloat > cdsItensDev.FieldByName('QTDDEV').AsFloat Then
      Begin
        Result := True;
        Break;
      End;

      cdsItensDev.Next;
    End;

  Finally
    cdsItensDev.First;
    cdsItensDev.EnableControls;
  End;
End;

function TfrmEntSelItensDevolucao.fTemTintadeMaquina: Boolean;
begin
  Result := False;
  Try
    cdsItensDev.DisableControls;
    cdsItensDev.First;
    While Not cdsItensDev.Eof Do
    Begin
      If fInLista Then
        If cdsItensDev.FieldByName('DET_IDEPRO').AsString <> 'NOR' Then
        Begin
          Result := True;
          Break;
        End;
     cdsItensDev.Next;
    End;

  Finally
    cdsItensDev.First;
    cdsItensDev.EnableControls;
  End;
end;

procedure TfrmEntSelItensDevolucao.FormCreate(Sender: TObject);
begin
  inherited;

  {Se resolução disponível for inferior ou igual à (1366 x 768), ajusta a tela!}
  If (Screen.Width <= 1366) Or ((Screen.Height - VS_HEIGHT_START_MENU_WINDOWS) < 768) Then
    Self.Position := poScreenCenter;

  pSetaCodIte(qryItensDevDET_CODITE);
  pSetaCodIte(cdsItensDevDET_CODITE);
  stlListSelecao := TStringList.Create;
  stlListSelecao.Clear;

  cxgItenQTDDEV.Visible := False;
  FSelGarantiaAD := False;
  intDeqTem := fCfgSis('DEQTEM', varInteger);
  TcxCurrencyEditProperties(cxgItenQTDDEV.Properties).DecimalPlaces := intDeqTem;
  TcxCurrencyEditProperties(cxgItenQTDDEV.Properties).DisplayFormat := fMskDigitos(intDeqTem);
  TcxCurrencyEditProperties(cxgItensDET_QTDITE.Properties).DecimalPlaces := intDeqTem;
  TcxCurrencyEditProperties(cxgItensDET_QTDITE.Properties).DisplayFormat := fMskDigitos(intDeqTem);

  FblnAcessadoViaRetornoConsignacao := False;

  blnTravaAD := False;
 
  //qryItensDev.Fields.Add(qryItensDevDET_PRECUS);

{  With qryItensDev.FieldDefs.Add() Do
  Begin
    Name := 'DET_PRECUS';
    DataType := ftFloat;
    //Size := fTamCodIte;
  End;

  With cdsItensDev.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DET_PRECUS';
    DataType := ftFloat;
    //Size := fTamCodIte;
  End;}
end;

procedure TfrmEntSelItensDevolucao.FormDestroy(Sender: TObject);
begin
  inherited;

  stlListSelecao.Clear;
  FreeAndNil(stlListSelecao);
end;

procedure TfrmEntSelItensDevolucao.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key of
    VK_F10  : if btnConfirma.Enabled Then
                btnConfirma.Click;
    VK_F2   : If btnMarDesTodos.Enabled And btnMarDesTodos.Visible Then
                btnMarDesTodos.Click;
    VK_ESCAPE: Close;
{  End;

  Case Key Of}
    VK_UP,
    VK_DOWN: If (ssShift In Shift) Then
                pAddListaQuery;

    VK_SPACE: pAddListaQuery;

    VK_RETURN: Begin
                 If cxgItenQTDDEV.Visible Then
                   cxgItenQTDDEV.Focused := True
                 Else
                   pAddListaQuery;
               End;

  End;
end;

procedure TfrmEntSelItensDevolucao.FormShow(Sender: TObject);
begin
  inherited;
  btnMarDesTodos.Visible := blnAcessadoViaRetornoConsignacao;
  btnEspelhoNF.Visible   := fVerificaAcessoSistema('ESPDNF', strLoginUsuarioLogado);
end;

function TfrmEntSelItensDevolucao.fPodeSelecionarItem: Boolean;
Begin
  Result := True;


  If (cdsItensDev.FieldByName('ITEATI').AsString = 'N') Or (cdsItensDev.FieldByName('IMPLIS').AsString = 'N') Then
  Begin
    pMensagemOk('O Item não pode ser selecionado, pois está com status Inativo ou Imprime Lista igual a não.');
    Result := False;
  End;


  If (Result) And (blnTravaAD) Then
    Result := (Not fTemADPendenteDocto(cdsItensDev.FieldByName('DET_CODEMP').AsString,
                                       cdsItensDev.FieldByName('DET_CODCLI').AsString,
                                       cdsItensDev.FieldByName('DET_NUMDOC').AsString,
                                       cdsItensDev.FieldByName('DET_ESPDOC').AsString,
                                       cdsItensDev.FieldByName('DET_SERIE_').AsString,
                                       True));


end;

function TfrmEntSelItensDevolucao.fRetQtdDevolvida(strCodite, strDocDev,
  strEspDev, strEmpDev, strCliDev: String): Double;
  Var strSQL: String;
      qryGen: TUniQuery;
begin

  qryGen := fCriaQuery;

  if not FblnAcessadoViaRetornoConsignacao then
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT       ';
    strSQL := strSQL + '  DET_QTDITE ';
    strSQL := strSQL + 'FROM         ';
    strSQL := strSQL + '  MOVDET     ';
    strSQL := strSQL + 'WHERE        ';
    strSQL := strSQL + '  DET_TIP_FC = "C"     AND ';
    strSQL := strSQL + '  DET_CODITE = :CODITE AND ';
    strSQL := strSQL + '  DET_DOCDEV = :DOCDEV AND ';
    strSQL := strSQL + '  DET_ESPDEV = :ESPDEV AND ';
    strSQL := strSQL + '  DET_EMPDEV = :EMPDEV AND ';
    strSQL := strSQL + '  DET_CODCLI = :CLIDEV     ';

    strSQL := 'SELECT SUM(DET_QTDITE) AS QTDE FROM (' + strSQL + ') TMP';
  End
  Else
  Begin
    strSQL := '';
    strSQL := strSQL + ' SELECT IFNULL(SUM(MOVCON.CON_QTDITE),0) QTDE '+
                       '   FROM MOVCON '+
                       '  WHERE MOVCON.CON_NUMDOC = :DOCDEV '+
                       '    AND MOVCON.CON_ESPDOC = :ESPDEV '+
                       '    AND MOVCON.CON_CODEMP = :EMPDEV '+
                       '    AND MOVCON.CON_CODITE = :CODITE ';
  End;

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODITE').AsString := strCodite;
    ParamByName('DOCDEV').AsString := strDocDev;
    ParamByName('ESPDEV').AsString := strEspDev;
    ParamByName('EMPDEV').AsString := strEmpDev;

    if not FblnAcessadoViaRetornoConsignacao  then
      ParamByName('CLIDEV').AsString := strCliDev;

    Open;
    Result := FieldByName('QTDE').AsFloat;
  End;

  FreeAndNil(qryGen);

end;

end.
