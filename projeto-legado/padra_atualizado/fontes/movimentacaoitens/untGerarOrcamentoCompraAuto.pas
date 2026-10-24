unit untGerarOrcamentoCompraAuto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem, ExtCtrls, EditFocus, Mask, MaskEditFocus,
  untFuncoesSimples, Uni, ComCtrls, Math, untTypesSistema, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels, DB,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxGroupBox, cxProgressBar, untSaldoPedidoCompra,
  untSalvaDadosInterface, untInicializaDllPedido, untFuncoesPedidoSimples, UniClientDataSet, untTEditFocusWithTConsultasArray;

type
  TItem = Record
    strCtaPcd,
    strCodEmp,
    strIncPis,
    strCodFor,
    strCodIte,
    strCodMar,
    strDesIte,
    strCodUni: String;

    blnIgnCal: Boolean;

    fltPerIpi,
    fltValIpi,

    fltPerSub,
    fltTotSub,
    fltTotDar,

    fltPerFCP,
    fltSubFCP,

    fltDesPis,
    fltValIcm,


    fltQtdIte,
    fltEmbala,
    fltPreCus,
    fltValFre,
    fltDesUni,
    fltTotIte: Double;

    dtaDtaPed,
    dtaDtaEnt: TDateTime;
  End;

  {$M+}
  TGeraOrcFor = Class
  private
    FCodEmp,
    FCodFor: String;
    FMinOrc: Double;

    intDecUni: Integer;

    strFRMPCM: String;

    blnTemDare,
    blnZonaFranca: Boolean;

    procedure pInicializar;

  public

    FArrItem: Array Of TItem;
    strNumPedGerados: String;
    recDadGiro: TRecOpcoesGiro;
    blnAutomatico: boolean;
    strCndPagDefExterno: string;
    strTipFre: String;
    fltValFre: Double;
    strCodTra: String;
    blnCalculoIPI_ST_Externo: Boolean;
    ParametrosCalcImpostos: TParametrosCalculoImposto;
    constructor Create;
    destructor Destroy; override;

    procedure pAddItem(item: TItem);
    function fGerarOrcamento(Var strListOrca: String; pgbProgress: TCxProgressBar=Nil; strNumPok: String=''; blnAnaliseCompra: Boolean = False; strObsExterna: String = ''; blnTransacaoExterna: Boolean = False; strCodCmp: string = ''): Boolean;
    function fQtdItens: Integer;
    function fBuscaAutoincremPedidoGerado(strNumPed, strCodEmp: string): string;

  published
    property strCodFor: String read FCodFor;
    property strCodEmp: String read FCodEmp;
    property fltMinOrc: Double write FMinOrc;
  End;

  TGeraOrc = Class
  private
    FArrGeraOrcFor: Array Of TGeraOrcFor;
    FQtdOrcamentoGerado: Integer;
    FProgress: TCxProgressBar;
    FstrNumPok: String;
    FstrListaOrcamentos: String;
    Function fGeraItensGiroPrg(pgbProgress: TCxProgressBar): Boolean;

  public
    recDadGiro: TRecOpcoesGiro;
    blnAutomatico: boolean;
    strNumPedGerados: String;
    cdsItensGiro: TUniClientDataSet;
    strCndPagDefExterno: string;
    strTipFre: String;
    fltValFre: Double;
    strCodtra: String;
    blnCalculoIPI_ST_Externo: Boolean;
    constructor Create;
    destructor Destroy; override;

    procedure pAddItem(item: TItem; fltMinOrc: Double);
    procedure pGerarOrcamentos(blnAnaliseCompra: Boolean = False; strObsExterna: String = ''; blnTransacaoExterna: boolean = False; strCodCmp: String = '');

    Class Function fGeraItensGiro(blnGeracaoDePedidoAutomatico: boolean = False): Boolean;

  published
    property intQtdOrcamentoGerado: Integer read FQtdOrcamentoGerado;
    property pgbProgress: TCxProgressBar write FProgress;
    property strNumPok: String write FstrNumPok;
    property strListaOrcamentos: String read FstrListaOrcamentos;
  End;
  {$M-}

  TfrmGerarOrcamentoCompraAuto = class(TfrmPai)
    pnlFundo: TPanel;
    pnlLeft: TPanel;
    btnConfirmar: TBitBtnLocked;
    cxGroupBox4: TGroupBox;
    pnlRight: TPanel;
    chkInativoCompra: TCheckBox;
    rdgStatus: TRadioGroup;
    rdgLocFis: TRadioGroup;
    rdgModCom: TRadioGroup;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    lblEmpresa: TLabel;
    Label15: TLabel;
    mskLinGru: TMaskEditFocus;
    edtDesGru: TEditFocus;
    edtCodFor: TEditFocus;
    edtDesFor: TEditFocus;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    edtRefere: TEditFocus;
    edtCodUni: TEditFocus;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    edtCodCmp: TEditFocus;
    edtDesCmp: TEditFocus;
    edtSigUni: TEditFocus;
    edtDesUni: TEditFocus;
    cxGroupBox1: TGroupBox;
    chkMulCom: TCheckBox;
    rdgPedCom: TRadioGroup;
    rdgMimMax: TRadioGroup;
    rdgSaldo: TRadioGroup;
    Label12: TLabel;
    edtCodDep: TEditFocus;
    edtDesCodDep: TEditFocus;
    Label13: TLabel;
    edtAcoObj: TEditFocus;
    Label3: TLabel;
    edtPrdGru: TEditFocus;
    edtDesPrdPro: TEditFocus;
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodMarExit(Sender: TObject);
    procedure edtCodCmpExit(Sender: TObject);
    procedure edtCodEmpExit(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodDepExit(Sender: TObject);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure edtPrdGruExit(Sender: TObject);
    procedure edtPrdGruKeyPress(Sender: TObject; var Key: Char);
  private
    arrLinGru,
    arrCodFor,
    arrCodMar,
    arrCodCmp,
    arrCodEmp,
    arrCodDep,
    arrGrupo: TConsultasArray;

    objIterface: TSalvaInterface;

    strUniPcg: String;
    intDecUni: Integer;

    procedure pGravaOrcamentos(qryOrc: TDataSet; pgbProgress: TCxProgressBar);

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

    Function fGeraOrcamentosPrg(pgbProgress: TcxProgressBar): Boolean;

    procedure pGeraOrcamentos;

  public
    { Public declarations }
  end;


Const
  ITESAL_MenorOuIgualEstoqueMin = 0;
  ITESAL_MenorEstoqueMin = 1;

  MODCOM_Centralizado = 0;
  MODCOM_NaoCentralizado = 1;
  MODCOM_Todos = 2;

  PEDCOM_Sim = 0;
  PEDCOM_Nao = 1;
  PEDCOM_ApenasPedido = 2;
  PEDCOM_ApenasOrcamento = 3;

  LOCFIS_ComLocalizacao = 0;
  LOCFIS_SemLocalizacao = 1;
  LOCFIS_Todos = 2;

  SALDO_MenorZero = 0;
  SALDO_Zero = 1;
  SALDO_MaiorZero = 2;
  SALDO_Todos = 3;

  STATUS_Ativo = 0;
  STATUS_Inativo = 1;
  STATUS_Todos = 2;

implementation

uses untConsultas, StrUtils, untFuncoesConsulta, untPcmGer,
     untGravando, untDigGiroEstoque, untFuncoes;

{$R *.dfm}

procedure TfrmGerarOrcamentoCompraAuto.btnConfirmarClick(Sender: TObject);
Begin
  pGeraOrcamentos;

 // objIterface.fSalvaDados('', '', strLoginUsuarioLogado, True);
End;

procedure TfrmGerarOrcamentoCompraAuto.pGeraOrcamentos;
Begin

  Try

    pCriarFormularios(TfrmGravando, frmGravando);

    With frmGravando Do
    Begin
      lblGravando.Caption := 'Aguarde, preparando dados...';

      fExecutarAcao := fGeraOrcamentosPrg;

      ShowModal;
    End;

  Except

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TfrmGerarOrcamentoCompraAuto.pGeraOrcamentos');
    End;

  End;

  pFreeAndNil(frmGravando);
End;

Function TfrmGerarOrcamentoCompraAuto.fGeraOrcamentosPrg(pgbProgress: TcxProgressBar): Boolean;
  Var
    qryOrc: TUniQuery;
    strSQLQtdPen,
    strCodEmp,
    strCodFor,
    strCodMar,
    strCodCmp,
    strCodGru,
    strCodGrp,
    strCnvEmb,
    strCodDep: String;
begin
  If fVerificaCampos Then
  Begin
    qryOrc := fCriaQuery;
    strSQLQtdPen := '  IFNULL((SELECT SQL_NO_CACHE '
                  + '            IFNULL(SUM(PCD_QTDITE - PCD_QTDBAI), 0)  '
                  + '          FROM '
                  + '            PCMDET '
                  + '          WHERE '
                  + '            PCD_ESPDOC IN ("PD", "OR") AND '
                  + '            PCD_CODITE = I.ITE_CODITE AND '
                  + '            PCD_BAIXAD = 0 AND '
                  + '            PCD_CODEMP = G.ITE_CODEMP), 0) ';

    Case rdgPedCom.ItemIndex Of
      PEDCOM_Sim            : ;
      PEDCOM_Nao            : strSQLQtdPen := ' 0 ';
      PEDCOM_ApenasPedido   : strSQLQtdPen := AnsiReplaceStr(strSQLQtdPen, '("PD", "OR")', '("PD")');
      PEDCOM_ApenasOrcamento: strSQLQtdPen := AnsiReplaceStr(strSQLQtdPen, '("PD", "OR")', '("OR")');
    End;

    Cursor := crHourGlass;
    Try
      strCnvEmb            := fCfgSis('CNVEMB');

      qryOrc.SQL.Add('SELECT SQL_NO_CACHE');
      qryOrc.SQL.Add('  G.ITE_CODEMP AS CODEMP,');
      qryOrc.SQL.Add('  I.ITE_CODFOR AS CODFOR,');
      qryOrc.SQL.Add('  F.FOR_MINORC AS MINORC,');
      qryOrc.SQL.Add('  I.ITE_CODITE AS CODITE,');
      qryOrc.SQL.Add('  I.ITE_DESITE AS DESITE,');
      qryOrc.SQL.Add('  I.ITE_CODUNI AS CODUNI,');
      qryOrc.SQL.Add('  I.ITE_CODMAR AS CODMAR,');
      qryOrc.SQL.Add('  I.ITE_MLTCOM AS MLTCOM,');
      qryOrc.SQL.Add('  I.ITE_INCPIS AS INCPIS,');
      qryOrc.SQL.Add('  G.ITE_PRECUS AS PRECUS,');
      qryOrc.SQL.Add('  G.ITE_PRECOM AS PRECOM,');
      qryOrc.SQL.Add('  G.ITE_PREULT AS PREULT,');
      qryOrc.SQL.Add('  G.ITE_IPIENT AS IPIENT,');
      qryOrc.SQL.Add('  G.ITE_ACRFIN AS ACRFIN,');
      qryOrc.SQL.Add('  G.ITE_DESF01 AS DESF01,');
      qryOrc.SQL.Add('  G.ITE_DESF02 AS DESF02,');
      qryOrc.SQL.Add('  G.ITE_DESF03 AS DESF03,');
      qryOrc.SQL.Add('  G.ITE_DESF04 AS DESF04,');
      qryOrc.SQL.Add('  G.ITE_DESF05 AS DESF05,');
      qryOrc.SQL.Add('  G.ITE_DESF06 AS DESF06,');

      If strCnvEmb <> 'N' Then
        qryOrc.SQL.Add(' IFNULL((SELECT BAR_EMBALA FROM ITEBAR WHERE BAR_CODITE = :CODITE AND BAR_CODFOR = I.ITE_CODFOR ORDER BY BAR_COMPRA DESC LIMIT 1), IFNULL(ITE_EMBALA, 1)) AS ITE_EMBALA, ')
      Else
        qryOrc.SQL.Add(' 1.0000 AS ITE_EMBALA, ');

      qryOrc.SQL.Add('  SUM(G.ITE_SALDOS) AS SALDOS,');

      If rdgMimMax.ItemIndex = 0 Then
        qryOrc.SQL.Add('  SUM(G.ITE_ESTMIN) AS ESTMIN,')
      Else
        qryOrc.SQL.Add('  SUM(G.ITE_ESTMAX) AS ESTMIN,');

      qryOrc.SQL.Add('  '+ strSQLQtdPen + ' AS QTDPEN');

      qryOrc.SQL.Add('FROM');
      qryOrc.SQL.Add('  CADITE I');
      qryOrc.SQL.Add('  JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE ' + fStrLocate(edtCodEmp, arrCodEmp, 'G.ITE_CODEMP', 'CODEMP'));
      qryOrc.SQL.Add('  JOIN CADFOR F ON F.FOR_CODFOR = I.ITE_CODFOR');
      qryOrc.SQL.Add('  LEFT JOIN GRPPRD GP ON GP.PRD_CODGRU = I.ITE_PRDGRU');
      qryOrc.SQL.Add('WHERE');
      qryOrc.SQL.Add('  G.ITE_SALDOS + '+ strSQLQtdPen + ' < ');

      If rdgMimMax.ItemIndex = 0 Then
        qryOrc.SQL.Add(' G.ITE_ESTMIN ')
      Else
        qryOrc.SQL.Add(' G.ITE_ESTMAX ');

      Case rdgSaldo.ItemIndex Of
        SALDO_MenorZero: qryOrc.SQL.Add('  AND G.ITE_SALDOS < 0');
        SALDO_Zero     : qryOrc.SQL.Add('  AND G.ITE_SALDOS = 0');
        SALDO_MaiorZero: qryOrc.SQL.Add('  AND G.ITE_SALDOS > 0');
        SALDO_Todos    : ;
      End;

      Case rdgModCom.ItemIndex Of
        MODCOM_Centralizado   : qryOrc.SQL.Add('  AND G.ITE_CPRCEN  = "S"');
        MODCOM_NaoCentralizado: qryOrc.SQL.Add('  AND G.ITE_CPRCEN <> "S"');
        MODCOM_Todos          : ;
      End;

      qryOrc.SQL.Add(fStrLocateLinGru(mskLinGru, arrLinGru, 'I.ITE_CODGRU', 'CODGRU'));

      qryOrc.SQL.Add(fStrLocate(edtCodFor, arrCodFor, 'I.ITE_CODFOR', 'CODFOR'));

      qryOrc.SQL.Add(fStrLocate(edtCodMar, arrCodMar, 'I.ITE_CODMAR', 'CODMAR'));

      qryOrc.SQL.Add(fStrLocate(edtCodCmp, arrCodCmp, 'I.ITE_GRUCMP', 'CODCMP'));

      qryOrc.SQL.Add(fStrLocate(edtCodDep, arrCodDep, 'I.ITE_CODDEP', 'CODDEP'));

      qryOrc.SQL.Add(fStrLocate(edtPrdGru, arrGrupo, 'I.ITE_PRDGRU', 'CODGRU'));

      If Not fEmptyStr(edtAcoObj.Text) Then
        qryOrc.SQL.Add(' AND IFNULL(I.ITE_ACOOBJ,"") LIKE :ACOOBJ  ');

      If Not fEmptyStr(edtCodUni.Text) Then
        qryOrc.SQL.Add('  AND I.ITE_CODUNI = :CODUNI');

      Case rdgLocFis.ItemIndex Of
        LOCFIS_ComLocalizacao: qryOrc.SQL.Add('  AND IFNULL(G.ITE_LOCFIS, "") <> ""');
        LOCFIS_SemLocalizacao: qryOrc.SQL.Add('  AND IFNULL(G.ITE_LOCFIS, "")  = ""');
        LOCFIS_Todos         : ;
      End;

      Case rdgStatus.ItemIndex Of
        STATUS_Ativo  ,
        STATUS_Inativo: qryOrc.SQL.Add('  AND I.ITE_ITEATI = :ITEATI');
        STATUS_Todos  : ;
      End;

      If Not chkInativoCompra.Checked Then
        qryOrc.SQL.Add('  AND I.ITE_ATICOM = "S"');

      qryOrc.SQL.Add('GROUP BY');
      qryOrc.SQL.Add('  G.ITE_CODITE,');
      qryOrc.SQL.Add('  G.ITE_CODEMP');
      qryOrc.SQL.Add('ORDER BY');
      qryOrc.SQL.Add('  I.ITE_CODFOR');

      pSetaParam(edtCodEmp.Text, arrCodEmp, strCodEmp, 'CODEMP', qryOrc);
      pSetaParam(edtCodFor.Text, arrCodFor, strCodFor, 'CODFOR', qryOrc);
      pSetaParam(edtCodMar.Text, arrCodMar, strCodMar, 'CODMAR', qryOrc);
      pSetaParam(edtCodCmp.Text, arrCodCmp, strCodCmp, 'CODCMP', qryOrc);
      pSetaParam(mskLinGru.Text, arrLinGru, strCodGru, 'CODGRU', qryOrc);
      pSetaParam(edtCodDep.Text, arrCodDep, strCodDep, 'CODDEP', qryOrc);
      pSetaParam(edtPrdGru.Text, arrGrupo,  strCodGrp, 'CODGRU', qryOrc);

      If Not fEmptyStr(edtAcoObj.Text) Then
        qryOrc.ParamByName('ACOOBJ').AsString := edtAcoObj.Text + '%';

      If Not fEmptyStr(edtCodUni.Text) Then
        qryOrc.ParamByName('CODUNI').AsString := edtCodUni.Text;

      Case rdgStatus.ItemIndex Of
        STATUS_Ativo  : qryOrc.ParamByName('ITEATI').AsString := 'S';
        STATUS_Inativo: qryOrc.ParamByName('ITEATI').AsString := 'N';
        STATUS_Todos  : ;
      End;

      qryOrc.Open;

      If qryOrc.IsEmpty Then
        fMensagem('', 'Nenhum item encontrado para gerar orçamento!', ['&Ok'])
      Else
      Begin
        pGravaOrcamentos(qryOrc, pgbProgress);
      End;

    Finally
      Cursor := crDefault;
      FreeAndNil(qryOrc);
    End;
  End;

  Result := True;
end;

procedure TfrmGerarOrcamentoCompraAuto.pGravaOrcamentos(qryOrc: TDataSet; pgbProgress: TCxProgressBar);
  Var
    objGeraOrc: TGeraOrc;
    item: TItem;
    fltUnitar: Double;
Begin
  objGeraOrc := TGeraOrc.Create;
  Try
    If Assigned(pgbProgress) Then
    Begin
      pgbProgress.Position := 0;
      pgbProgress.Properties.Max := qryOrc.RecordCount;
      Application.ProcessMessages;
    End;

    While Not qryOrc.Eof Do
    Begin
      item.strCodEmp := qryOrc.FieldByName('CODEMP').AsString;
      item.strCodFor := qryOrc.FieldByName('CODFOR').AsString;
      item.strCodIte := qryOrc.FieldByName('CODITE').AsString;
      item.strCodMar := qryOrc.FieldByName('CODMAR').AsString;
      item.strCodUni := qryOrc.FieldByName('CODUNI').AsString;
      item.strDesIte := qryOrc.FieldByName('DESITE').AsString;
      item.strIncPis := qryOrc.FieldByName('INCPIS').AsString;
      item.fltPerIpi := qryOrc.FieldByName('IPIENT').AsFloat;

      If Not fliberaTravaValidadeCertGestao(item.strCodFor) Then
        Exit;

      item.fltDesUni := 0;

      If (strUniPcg = '1') Then
      Begin
        fltUnitar := qryOrc.FieldByName('PRECOM').AsFloat;
      End
      Else If (strUniPcg = '2') Or (strUniPcg = '6') Then
      Begin
        fltUnitar := qryOrc.FieldByName('PRECOM').AsFloat;
        fltUnitar := fltUnitar - (fltUnitar * (qryOrc.FieldByName('DESF01').AsFloat / 100));
        fltUnitar := fltUnitar - (fltUnitar * (qryOrc.FieldByName('DESF02').AsFloat / 100));
        fltUnitar := fltUnitar - (fltUnitar * (qryOrc.FieldByName('DESF03').AsFloat / 100));
        fltUnitar := fltUnitar - (fltUnitar * (qryOrc.FieldByName('DESF04').AsFloat / 100));
        fltUnitar := fltUnitar - (fltUnitar * (qryOrc.FieldByName('DESF05').AsFloat / 100));
        fltUnitar := fltUnitar - (fltUnitar * (qryOrc.FieldByName('DESF06').AsFloat / 100));
      End
      Else If (strUniPcg = '3') Then
      Begin
        fltUnitar := qryOrc.FieldByName('PRECUS').AsFloat;
      End
      Else If (strUniPcg = '4') Then
      Begin
        fltUnitar := qryOrc.FieldByName('PRECOM').AsFloat;
        fltUnitar := fltUnitar - (fltUnitar * (qryOrc.FieldByName('DESF01').AsFloat / 100));
        fltUnitar := fltUnitar - (fltUnitar * (qryOrc.FieldByName('DESF02').AsFloat / 100));
        fltUnitar := fltUnitar - (fltUnitar * (qryOrc.FieldByName('DESF03').AsFloat / 100));
        fltUnitar := fltUnitar - (fltUnitar * (qryOrc.FieldByName('DESF04').AsFloat / 100));
        fltUnitar := fltUnitar - (fltUnitar * (qryOrc.FieldByName('DESF05').AsFloat / 100));
        fltUnitar := fltUnitar - (fltUnitar * (qryOrc.FieldByName('DESF06').AsFloat / 100));
        fltUnitar := fltUnitar + ( fltUnitar * (qryOrc.FieldByName('ACRFIN').AsFloat  / 100 ) );
      End
      Else If (strUniPcg = '7') Then
      Begin
        fltUnitar := qryOrc.FieldByName('PRECOM').AsFloat;

        item.fltDesUni := RoundTo((1 - (
                      (1 - qryOrc.FieldByName('DESF01').AsFloat/100) *
                      (1 - qryOrc.FieldByName('DESF02').AsFloat/100) *
                      (1 - qryOrc.FieldByName('DESF03').AsFloat/100) *
                      (1 - qryOrc.FieldByName('DESF04').AsFloat/100) *
                      (1 - qryOrc.FieldByName('DESF05').AsFloat/100) *
                      (1 - qryOrc.FieldByName('DESF06').AsFloat/100))) * 100, -2);
      End

      Else If (strUniPcg = '8') Then
      Begin
        fltUnitar := qryOrc.FieldByName('PREULT').AsFloat;
      End

      Else fltUnitar := 0;

      fltUnitar  := fFormataFloatInterna(fltUnitar, intDecUni);

      item.fltPreCus := fltUnitar;

      item.fltQtdIte := qryOrc.FieldByName('ESTMIN').AsFloat - qryOrc.FieldByName('SALDOS').AsFloat
                                                             - qryOrc.FieldByName('QTDPEN').AsFloat;

      If chkMulCom.Checked And (Trunc(qryOrc.FieldByName('MLTCOM').AsFloat) > 0) Then
      Begin
        If Trunc(item.fltQtdIte) Mod Trunc(qryOrc.FieldByName('MLTCOM').AsFloat) > 0 Then
          item.fltQtdIte := qryOrc.FieldByName('MLTCOM').AsFloat * (Trunc(item.fltQtdIte) Div Trunc(qryOrc.FieldByName('MLTCOM').AsFloat) + 1);
      End;

      item.fltEmbala := qryOrc.FieldByName('ITE_EMBALA').AsFloat;


      If item.fltEmbala = 0 Then
        item.fltEmbala := 1;
      item.fltValFre := 0;

      item.blnIgnCal := False;

      objGeraOrc.pAddItem(item, qryOrc.FieldByName('MINORC').AsFloat);

      If Assigned(pgbProgress) Then
      Begin
        pgbProgress.Position :=  pgbProgress.Position + 1;
        Application.ProcessMessages;
      End;

      qryOrc.Next;
    End;

    If Assigned(frmGravando) Then
    Begin
      frmGravando.lblGravando.Caption := 'Aguarde, gerando orçamentos de compra...';
      Application.ProcessMessages;
    End;

    If Assigned(pgbProgress) Then
      objGeraOrc.pgbProgress := pgbProgress;

    objGeraOrc.pGerarOrcamentos;

    If objGeraOrc.intQtdOrcamentoGerado = 0 Then
      fMensagem('', 'Nenhum orçamento gerado!', ['&Ok'])
    Else
      fMensagem('', 'Foram gerados '+ IntToStr(objGeraOrc.intQtdOrcamentoGerado) +' orçamentos!', ['&Ok'])

  Finally
    objGeraOrc.Free;
  End;
End;


procedure TfrmGerarOrcamentoCompraAuto.edtPrdGruExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtPrdGru, edtDesPrdPro, arrGrupo, fRetNomeGrupoProduto, nil, 'do Grupo de Produtos', edtPrdGru.MaxLength);
end;

procedure TfrmGerarOrcamentoCompraAuto.edtPrdGruKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupoProduto(Self, edtPrdGru, edtDesPrdPro, Nil, Key, arrGrupo) Then
  Begin
    If fValidaCampos(edtPrdGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGerarOrcamentoCompraAuto.edtCodCmpExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodCmp, edtDesCmp, arrCodCmp, Nil, fRetDescGrupoCompra, 'do Grupo de Compra');
end;

procedure TfrmGerarOrcamentoCompraAuto.edtCodCmpKeyPress(Sender: TObject; var Key: Char);
begin
  If fPesqGrupoCompra(Self, edtCodCmp, edtDesCmp, Nil, Key, arrCodCmp, False) Then
  Begin
    If fValidaCampos(edtCodCmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGerarOrcamentoCompraAuto.edtCodDepExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodDep, edtDesCodDep, arrCodDep, fRetNomDep, nil, 'do Departamento');

end;

procedure TfrmGerarOrcamentoCompraAuto.edtCodDepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqDepartamento(Self, edtCodDep, edtDesCodDep, nil, key, arrCodDep, False) Then
  Begin
    if fValidaCampos(edtCodDep, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmGerarOrcamentoCompraAuto.edtCodEmpExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodEmp, edtDesEmp, arrCodEmp, Nil, fRetNomeEmpresaSelec, 'da Empresa');
end;

procedure TfrmGerarOrcamentoCompraAuto.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
begin
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrCodEmp, False, True) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGerarOrcamentoCompraAuto.edtCodForExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodFor, edtDesFor, arrCodFor, fRetNomFornecedor, Nil, 'do Fornecedor');
end;

procedure TfrmGerarOrcamentoCompraAuto.edtCodForKeyPress(Sender: TObject; var Key: Char);
begin
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtDesFor, Nil, Key, arrCodFor, False) Then
  Begin
    If fValidaCampos(edtCodFor) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGerarOrcamentoCompraAuto.edtCodMarExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodMar, edtDesMar, arrCodMar, fRetNomeMarca, Nil, 'da Marca');
end;

procedure TfrmGerarOrcamentoCompraAuto.edtCodMarKeyPress(Sender: TObject; var Key: Char);
begin
  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrCodMar, False) Then
  Begin
    If fValidaCampos(edtCodMar) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGerarOrcamentoCompraAuto.edtCodUniKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  If fPesqUnidade(Self, edtCodUni, edtDesUni, edtSigUni, nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtCodUni, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGerarOrcamentoCompraAuto.FormCreate(Sender: TObject);
begin
  inherited;

  objIterface := TSalvaInterface.Create(Self);

  strUniPcg := fCfgSis('UNIPCG');
  intDecUni := fCfgSis('DECUNI');
end;

procedure TfrmGerarOrcamentoCompraAuto.FormShow(Sender: TObject);
begin
  inherited;
  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
  edtDesPrdPro.Text := 'TODOS';
  objIterface.fCarregaDados('', Self, '', strLoginUsuarioLogado);
end;

function TfrmGerarOrcamentoCompraAuto.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
  Var
    strMsg: String;
begin

  If Sender = mskLinGru Then
  Begin
    If Not fEmptyStr(mskLinGru.Text) Then
    Begin
      edtDesGru.Text := fRetNomeLinhaGrupo(mskLinGru.Text);
      If fEmptyStr(edtDesGru.Text) Then
        strMsg := 'Linha/Grupo Inicial não encontrada!'
    End
    Else
    Begin
      edtDesGru.Text := 'TODOS';
    End;
  End

  Else If Sender = edtCodUni Then
  Begin
    If Not fEmptyStr(edtCodUni.Text) Then
    Begin
      edtDesUni.Text := fRetNomUnidade(edtCodUni.Text);
      edtSigUni.Text := fRetSiglaUni(edtCodUni.Text);
      If fEmptyStr(edtDesUni.Text) And fEmptyStr(edtSigUni.Text) Then
        strMsg := 'Unidade não encontrada!';
    End
    Else
    Begin
      edtDesUni.Clear;
      edtSigUni.Clear;
    End;
  End

  Else If Sender = edtCodFor Then
    pDesmarcaLista(edtCodFor, arrCodFor)

  Else If Sender = edtCodMar Then
    pDesmarcaLista(edtCodMar, arrCodMar)

  Else If Sender = edtCodEmp Then
    pDesmarcaLista(edtCodEmp, arrCodEmp)

  Else If Sender = edtPrdGru Then
    pDesmarcaLista(edtPrdGru, arrGrupo)

  Else If Sender = edtCodCmp Then
    pDesmarcaLista(edtCodCmp, arrCodCmp);

  Result := fEmptyStr(strMsg);

  If Not Result Then
  Begin
    fMensagem('', strMsg, ['&O k']);
    pSetFocus(Sender);
  End;
end;

procedure TfrmGerarOrcamentoCompraAuto.mskLinGruKeyPress(Sender: TObject; var Key: Char);
begin
  If fPesqGrupo(Self, mskLinGru, edtDesGru, nil, Key, arrLinGru, False) Then
  Begin
    If fValidaCampos(mskLinGru) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

{ TGeraOrc }

constructor TGeraOrc.Create;
begin
  blnCalculoIPI_ST_Externo := False;
  SetLength(FArrGeraOrcFor, 0);
  FQtdOrcamentoGerado := 0;
  FstrNumPok := '';
  FstrListaOrcamentos := '';
end;

destructor TGeraOrc.Destroy;
  Var
    objGeraOrcFor: TGeraOrcFor;
begin
  For objGeraOrcFor In FArrGeraOrcFor Do
    objGeraOrcFor.Free;
    
  SetLength(FArrGeraOrcFor, 0);
  inherited;
end;

procedure TGeraOrc.pAddItem(item: TItem; fltMinOrc: Double);
  Var
    objGeraOrcFor: TGeraOrcFor;
begin
  If item.fltQtdIte <= 0 Then
    Exit;
    
  For objGeraOrcFor In FArrGeraOrcFor Do
  Begin
    If (objGeraOrcFor.strCodFor = item.strCodFor) And (objGeraOrcFor.strCodEmp = item.strCodEmp) Then
    Begin
      objGeraOrcFor.pAddItem(item);
      Exit;
    End;
  End;

  // Se chegou aqui é porque não achou uma GeraOrcFor com o fornecedor/emp atual, então cria um novo
  objGeraOrcFor := TGeraOrcFor.Create;
  objGeraOrcFor.pAddItem(item);
  objGeraOrcFor.fltMinOrc := fltMinOrc;
  SetLength(FArrGeraOrcFor, Length(FArrGeraOrcFor) +1);
  FArrGeraOrcFor[High(FArrGeraOrcFor)] := objGeraOrcFor;
end;

procedure TGeraOrc.pGerarOrcamentos(blnAnaliseCompra: Boolean = False; strObsExterna: String = ''; blnTransacaoExterna: boolean = False; strCodCmp: String = '');
  Var
    objGeraOrcFor: TGeraOrcFor;
    intMax: Integer;
begin
  FQtdOrcamentoGerado := 0;

  If Length(FarrGeraOrcFor) = 0 Then
    Exit;

  intMax := 0;
  For objGeraOrcFor In FArrGeraOrcFor Do
    Inc(intMax, objGeraOrcFor.fQtdItens);

  If Assigned(FProgress) Then
  Begin
    FProgress.Properties.Max := intMax;
    FProgress.Position := 0;
    Application.ProcessMessages;
  End;

  strNumPedGerados := '';

  For objGeraOrcFor In FArrGeraOrcFor Do
  Begin

    objGeraOrcFor.recDadGiro := recDadGiro;
    objGeraOrcFor.blnAutomatico := blnAutomatico;
    objGeraOrcFor.strCndPagDefExterno := Self.strCndPagDefExterno;
    objGeraOrcFor.strTipFre := Self.strTipFre;
    objGeraOrcFor.fltValFre := Self.fltValFre;
    objGeraOrcFor.strCodtra:= Self.strCodTra;
    objGeraOrcFor.blnCalculoIPI_ST_Externo := Self.blnCalculoIPI_ST_Externo;

    If objGeraOrcFor.fGerarOrcamento(FstrListaOrcamentos, FProgress, FstrNumPok, blnAnaliseCompra, strObsExterna, blnTransacaoExterna, strCodCmp) Then
    begin
      strNumPedGerados := objGeraOrcFor.strNumPedGerados;
      Inc(FQtdOrcamentoGerado);
    End;
  End;
End;

{ TGeraOrcFor }

constructor TGeraOrcFor.Create;
begin
  blnCalculoIPI_ST_Externo := False;
  pInicializar;

  intDecUni := fCfgSis('DECUNI');
  strFRMPCM := fCfgSis('FRMPCM');

  blnZonaFranca := fEhEstadoRegraZonaFranca(fCadEmp('ESTADO'));
  strTipFre := '';
  fltValFre := 0;

end;

destructor TGeraOrcFor.Destroy;
begin
  pInicializar;

  inherited;
end;

function TGeraOrcFor.fBuscaAutoincremPedidoGerado(strNumPed, strCodEmp: string): string;
  var qryConsulta : TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT AUTOINCREM FROM PCMGER');
    qryConsulta.SQL.Add(' WHERE PCG_NUMPED = :NUMPED');
    qryConsulta.SQL.Add('   AND PCG_CODEMP = :CODEMP');
    qryConsulta.ParamByName('NUMPED').AsString := strNumPed;
    qryConsulta.ParamByName('CODEMP').AsString := strCodEmp;
    qryConsulta.Open;
    If qryConsulta.IsEmpty Then
       Exit('')
    Else
      exit(qryConsulta.FieldByName('AUTOINCREM').AsString);

  Finally
    FreeAndNil(qryConsulta);
  End;

end;

function TGeraOrcFor.fGerarOrcamento(Var strListOrca: String; pgbProgress: TCxProgressBar=Nil; strNumPok: String=''; blnAnaliseCompra: Boolean = False; strObsExterna: String = ''; blnTransacaoExterna: Boolean = False; strCodCmp: string = ''): Boolean;
  Var
    strTipAbfFor,
    strCodSitIte,
    strCodSitOrigemIte,
    strObs1,
    strObs2,
    strObs3,
    strCtaPcdGer,
    strCndPag,
    strAutIncPcd,
    strCampoSaldoAdd,
    strNumPed: String;

    blnLibPcm : boolean;

    fltTotGer: Double;

    dtaDtaPedGer,
    dtaDtaEntGer: TDateTime;

    item: TItem;

    intContador,
    intDeqTpc : Integer;
    strForFil : String;

    fltValIcmGer,
    fltTotIpiGer,
    fltTotSubGer,
    fltTotDarGer,
    fltSubFCPGer,
    fltTotIteGer,
    fltBaseSTIte,
    fltBasIcmIte,
    fltBasIPI,
    fltAlqIPI,
    fltAlqIcmIte: Double;

    qryCadFor: TUniQuery;

    Procedure pCarregaDadosFornecedor;
      Var
        strSQL: String;
    Begin
      qryCadFor := fCriaQuery;

      strSQL := '';
      strSQL := strSQL + ' SELECT   ';
      strSQL := strSQL + '   FOR_CNDPAG, ';
      strSQL := strSQL + '   FOR_MINORC, ';
      strSQL := strSQL + '   FOR_PISCOF, ';
      strSQL := strSQL + '   FOR_SIMPAU, ';
      strSQL := strSQL + '   FOR_ADIDPC, ';
      strSQL := strSQL + '   FOR_FDAICD, ';
      strSQL := strSQL + '   FOR_IDPCID, ';
      strSQL := strSQL + '   FOR_ADPCPC, ';
      strSQL := strSQL + '   FOR_IFDAPC, ';
      strSQL := strSQL + '   FOR_ADICPC, ';
      strSQL := strSQL + '   FOR_ALQPIS, ';
      strSQL := strSQL + '   FOR_ALQCOF, ';
      strSQL := strSQL + '   FOR_ADIDST, ';
      strSQL := strSQL + '   FOR_REDPIS, ';
      strSQL := strSQL + '   FOR_ADIDIC, ';
      strSQL := strSQL + '   FOR_ADPCST, ';
      strSQL := strSQL + '   FOR_ADIDCI, ';
      strSQL := strSQL + '   FOR_ADPCIP, ';

      strSQL := strSQL + '   CID_ESTADO AS FOR_ESTADO ';

      strSQL := strSQL + ' FROM     ';
      strSQL := strSQL + '   CADFOR ';

      strSQL := strSQL + ' LEFT JOIN CADCID ON CID_CODCID = FOR_CODCID ';

      strSQL := strSQL + ' WHERE    ';
      strSQL := strSQL + '   FOR_CODFOR = :CODFOR ';

      qryCadFor.SQL.Text := strSQL;
      qryCadFor.ParamByName('CODFOR').AsString := FCodFor;
      qryCadFor.Open;
      ParametrosCalcImpostos.Param_Fornecedor.pCarregaConfiguracoes(qryCadFor);
      strTipAbfFor := fGetTipoAbfFornecedor(FCodFor);

      blnTemDare     := fCfgSis('DARROR', varBoolean) And
                        (Not fEhEstadoRegraZonaFranca(qryCadFor.FieldByName('FOR_ESTADO').AsString)) And
                        (fCadEmp('ESTADO') = 'RO');
    End;

begin

  Result := False;

  strForFil := fRetForFilialTodos;
  intDeqTpc := fCfgSis('DEQTPC', varInteger);
  blnLibPcm := fCfgSis('LIBPCM', varBoolean);

  If Not blnTransacaoExterna Then
    fStartTransaction;
  Try
    If blnAnaliseCompra Then
      strNumPed := fSeqPedidoCompra
    Else
      strNumPed := fSeqPedidoCompra;
    strNumPedGerados := strNumPedGerados + strNumPed +  #$A#$D;
    fltTotGer    := 0;
    fltTotIpiGer := 0;
    fltTotSubGer := 0;
    fltTotDarGer := 0;
    fltSubFCPGer := 0;
    fltTotIteGer := 0;
    fltValIcmGer := 0;

    dtaDtaPedGer := VS_Date;
    dtaDtaEntGer := VS_Date;

    pCarregaDadosFornecedor;

    strCampoSaldoAdd := fRetCampoAtualizaSaldoPedidoCompra(IIF( blnLibPcm, False, True), FCodFor, strForFil);

    If FMinOrc = - 1 Then
      FMinOrc := qryCadFor.FieldByName('FOR_MINORC').AsFloat;
    If strCndPagDefExterno <> '' Then
      strCndPag := strCndPagDefExterno
    Else
      strCndPag := qryCadFor.FieldByName('FOR_CNDPAG').AsString;

    For intContador := Low(FArrItem) To High(FArrItem) Do
    With FArrItem[intContador] Do
    begin
      If Not blnIgnCal Then
        fltTotIte := RoundTo(fltQtdIte * fCalculaUnitarioLiquido(intDecUni, fltPreCus, fltDesUni, 0, 0, 0, 0, 0), -2);
      If Not blnCalculoIPI_ST_Externo Then
      Begin
        fltBasIPI := fltTotIte;
        fltAlqIPI := fltPerIpi;
        fltValIpi := fltTotIte * fltPerIpi / 100;


        fltTotSub := RoundTo(fCalcularSubstituicaoProduto(strCodFor,                                             //strCodFor,
                                                          fRetornaAbreviacaoItem(strCodIte),                     //strCodAbf: String;
                                                          fltTotIte,                                             //fltTotIte,
                                                          0,                                                     //fltTotFre,
                                                          0,                                                     //fltTotAce: Double;
                                                          strFRMPCM,                                             //strFrmPcm,
                                                          'S',                                                   //strBStFre,
                                                          'S',                                                   //strBStAce: String;
                                                          blnZonaFranca,                                         //blnZonaFranca,
                                                          strIncPis = 'S',                                       //blnIncPis,
                                                          qryCadFor.FieldByName('FOR_SIMPAU').AsString = 'S',    //blnFornecSimples: Boolean;
                                                          blnTemDare,
                                                          fltAlqIPI,                                             //fltAlqIPI: Double;
                                                          False,
                                                          fltBasIcmIte,                                          //fltBasIcm,
                                                          fltAlqIcmIte,                                          //fltAlqIcm,
                                                          fltValIcm,                                             //fltValIcm,
                                                          fltBaseSTIte,                                          //fltBaseST,
                                                          fltDesPis,                                             //fltDesPis,
                                                          fltBasIPI,                                             //fltBasIPI,
                                                          fltValIPI,                                             //fltValIPI,
                                                          fltPerFCP,                                             //fltPerFCP,
                                                          fltSubFCP,                                             //fltSubFCP: Double;
                                                          fltTotDar,
                                                          strCodSitIte,                                          //Var strCodSit: String;
                                                          strCodSitOrigemIte,                                    //Var strCodSitOrigem: String;
                                                          fltPerSub,                                             //var fltAliquotaSub: Double;
                                                          ParametrosCalcImpostos,                                //ParametrosImpostos: TParametrosCalculoImposto;
                                                          strTipAbfFor), -2);                                    //strTipAbfFor: String = '';
      End;                                                                                                       //strTipAbfFor: String = '';

      fltTotGer := fltTotGer + fltTotIte + fltValIpi + fltTotSub + fltSubFCP - IIF(blnZonaFranca, fltDesPis - fltValIcm, 0);

      fltTotIpiGer := fltTotIpiGer + fltValIpi;
      fltTotSubGer := fltTotSubGer + fltTotSub;
      fltTotDarGer := fltTotDarGer + fltTotDar;
      fltSubFCPGer := fltSubFCPGer + fltSubFCP;
      fltTotIteGer := fltTotIteGer + fltTotIte;
      fltValIcmGer := fltValIcmGer + fltValIcm;

      If (Not fEmptyStr(strNumPok)) Then
      Begin
        dtaDtaPedGer := dtaDtaPed;
        dtaDtaEntGer := dtaDtaEnt;
        strCtaPcdGer := strCtaPcd;
      End;

    end;

    If fEmptyStr(strCndPag) Then
      strCndPag := '01000';

    // Não pode gerar o orçamento se o valor não atingiu o mínimo estipulado para o fornecedor;
    If fltTotGer < FMinOrc Then
    Begin
      If Assigned(pgbProgress) Then
      Begin
        pgbProgress.Position := pgbProgress.Position + 1;
        Application.ProcessMessages;
      End;

      Exit;
    End;

    If (Not fEmptyStr(strNumPok)) Then
    Begin
      strObs1 := 'GERADO ATRAVÉS DA ROTINA DE CROSS DOCKING';
      strObs2 := 'PEDIDO DE VENDA DO AUTCOM: '+(fCampoTabela('CONCAT(FGO_NUMDOC, "-", FGO_ESPDOC, "-", FGO_CODEMP)', 'FATGOR', ['FGO_NUMPOK'], [strNumPok]));
      strObs3 := 'PEDIDO DE VENDA DO SITE: '+strNumPok;
    End
    Else
    Begin
      If Not fEmptyStr(strObsExterna) Then
        strObs1 := strObsExterna
      Else
        strObs1 :=  IIf(blnAnaliseCompra,
                        'GERADO PELA "ARQUIVO PARA ANALISE DE COMPRA"',
                        'GERADO PELA "GERAÇÃO DE ORÇAMENTO DE COMPRA AUTOMÁTICO"');
      strObs2 := '';
      strObs3 := '';
    End;

    Result := fGravaPcmGer(strNumPed,                                  //  strNumPed,
                           FCodEmp,                                    //  strCodEmp,
                           IIf(blnAnaliseCompra, 'PD', 'OR'),          //  strEspDoc,
                           FCodFor,                                    //    strCodFor,
                           strCodTra,                                  //    strCodTra,
                           strCndPag,                                  //    strConPag: String;
                           dtaDtaEntGer,                               //    dtaDtaEnt,
                           fTime(),                                    //    tmeHorEnt,
                           dtaDtaPedGer,                               //    dtaDtaPed: TDateTime;
                           strCodCmp,                                  //    strCompra: String;
                           fltTotIpiGer,                               //    fltTotIpi,
                           fltTotSubGer,                               //    fltTotSub,
                           fltTotDarGer,                               //    fltTotDar,
                           fltSubFCPGer,                               //    fltSubFCP,
                           fltTotIteGer,                               //    fltTotIte,
                           fltTotGer,                                  //    fltTotGer: Double;
                           strObs1,                                    //    strObs001,
                           strObs2,                                    //    strObs002,
                           strObs3,                                    //    strObs003,
                           '',                                         //    strObs004,
                           '',                                         //    strObs005,
                           '',                                         //    strObsPd1,
                           '',                                         //    strObsPd2,
                           '',                                         //    strObsPd3,
                           '',                                         //    strPedVen,
                           '',                                         //    strAtenca,
                           IIf(fEmptyStr(strTipFre), '1', strTipFre),  //    strTipFre,
                           '',                                         //    strDocOri: String;
                           0,                                          //    intNumCtn: Integer;
                           'N',                                        //    strPedImp,
                           FCodEmp,                                    //    strempdes: String;
                           0,                                          //    fltDesAdi,
                           0,                                          //    fltBasCof,
                           0,                                          //    fltValCof,
                           0,                                          //    fltBasPis,
                           0,                                          //    fltValPis,
                           0,                                          //    fltBasIcm,
                           fltValIcmGer,                               //    fltValIcm,
                           0,                                          //    fltBasIpi,
                           0,                                          //    fltBasSub: Double;
                           strCtaPcdGer,                               //    strCodCta: String='';
                           strNumPok,                                  //    strNumPok: String=''): Boolean;
                           fltValFre,
                           strCndPagDefExterno = '',
                           dtaDtaEntGer);                              //    dtaDtaFat: TDateTime = 0

    If Not Result Then
      Exit;

    For item In FArrItem Do
    Begin
      Result := Result And fGravaPcmDet(strCampoSaldoAdd, // strCampoSaldoAdd
                                        intDeqTpc,
                                        strNumPed,
                                        FCodEmp,
                                        IIf(blnAnaliseCompra, 'PD', 'OR'),
                                        FCodFor,
                                        item.strCodIte,
                                        item.strCodUni,
                                        dtaDtaEntGer,
                                        fTime(),
                                        dtaDtaPedGer,
                                        strCndPag,
                                        item.strDesIte,
                                        item.fltQtdIte,
                                        item.fltPreCus,
                                        item.fltDesUni,
                                        item.fltTotIte,
                                        item.fltPerIpi,
                                        item.fltValIpi,
                                        item.fltPerSub,
                                        item.fltTotSub,
                                        item.fltTotDar,
                                        item.fltPerFCP,
                                        item.fltSubFCP,
                                        0,
                                        0,
                                        0,
                                        0,
                                        0,
                                        0,
                                        item.fltValFre,
                                        0,
                                        item.fltValIcm,
                                        item.fltDesPis,
                                        0,
                                        '',
                                        0,
                                        'N',
                                        '',
                                        strAutIncPcd,
                                        '',
                                        '',
                                        False,
                                        '',
                                        item.fltEmbala);

      If Assigned(pgbProgress) Then
      Begin
        pgbProgress.Position := pgbProgress.Position + 1;
        Application.ProcessMessages;
      End;

    End;

    If blnAutomatico Then
    Begin
      recDadGiro.objSalInt.pSetaFiltro('edtCodFor', FCodFor);

      recDadGiro.objSalInt.fSalvaDados(fBuscaAutoincremPedidoGerado(strNumPed, FCodEmp), 'frmGerarOrcamentoCompraAuto', '');
    End;

  Finally
    If Not blnTransacaoExterna Then
    Begin
      If Result Then
        fCommit
      Else
        fRollBack;
    End;

    If Result Then
      pIncrementaListaStr(strNumPed+'-'+'OR', strListOrca);

    FreeAndNil(qryCadFor);
  End;
end;

function TGeraOrcFor.fQtdItens: Integer;
begin
  Result := Length(FArrItem);
end;

procedure TGeraOrcFor.pAddItem(item: TItem);
begin
  If (Not fEmptyStr(FCodFor)) And (FCodFor <> item.strCodFor) Then
  Begin
    fMensagem('', 'Falha adicionando produto do fornecedor: '+ item.strCodFor + ' na geração do fornecedor: '+ FCodFor, ['&Ok']);
    Exit;
  End;

  If (Not fEmptyStr(FCodEmp)) And (FCodEmp <> item.strCodEmp) Then
  Begin
    fMensagem('', 'Falha adicionando produto da empresa: '+ item.strCodEmp + ' na geração da empresa: '+ FCodEmp, ['&Ok']);
    Exit;
  End;

  FCodFor := item.strCodFor;
  FCodEmp := item.strCodEmp;

  SetLength(FArrItem, Length(FArrItem) +1);
  FArrItem[High(FArrItem)] := item;
end;

procedure TGeraOrcFor.pInicializar;
begin
  SetLength(FArrItem, 0);
  FCodFor := '';
end;

Class Function TGeraOrc.fGeraItensGiro(blnGeracaoDePedidoAutomatico: boolean = False): Boolean;
  Var
    recDadGiro: TRecOpcoesGiro;
    oleItensMultiLojas: OleVariant;
    gerGeraOrc: TGeraOrc;
begin
  Result := False;

  Try
    gerGeraOrc := TGeraOrc.Create;

    recDadGiro.strPedMlj := 'N';
    gerGeraOrc.cdsItensGiro := TUniClientDataSet.Create(Nil);

    gerGeraOrc.blnAutomatico := True;

    recDadGiro.strNomFrm := 'frmGerarOrcamentoCompraAuto';

    gerGeraOrc.cdsItensGiro.Data := fRetornaProdutosGiroCotacaoAutCom(recDadGiro, oleItensMultiLojas);

    If (gerGeraOrc.cdsItensGiro.Data <> Null) And (gerGeraOrc.cdsItensGiro.RecordCount > 0) Then
    Begin

      Try
        pCriarFormularios(TfrmGravando, frmGravando);

        frmGravando.lblGravando.Caption := 'Aguarde, preparando dados...';

        frmGravando.fExecutarAcao := gerGeraOrc.fGeraItensGiroPrg;

        gerGeraOrc.pgbProgress := frmGravando.pgbStatus;
        gerGeraOrc.recDadGiro := recDadGiro; 

        frmGravando.ShowModal;

        Result := frmGravando.blnConfirma;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, 'fGeraItensGiro');
        End;
      End;

      pFreeAndNil(frmGravando);

      If gerGeraOrc.intQtdOrcamentoGerado = 0 Then
        fMensagem('', 'Nenhum orçamento gerado!', ['&Ok'])

      Else If gerGeraOrc.intQtdOrcamentoGerado = 1  Then
        fMensagem('', 'Foi gerado '+ IntToStr(gerGeraOrc.intQtdOrcamentoGerado) +' orçamento!', ['&Ok'])
      Else
        fMensagem('', 'Foram gerados '+ IntToStr(gerGeraOrc.intQtdOrcamentoGerado) +' orçamentos!', ['&Ok']);

    End;

    FreeAndNil(gerGeraOrc.cdsItensGiro);

    FreeAndNil(gerGeraOrc);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'fGeraItensGiro');
    End;
  End;

end;

Function TGeraOrc.fGeraItensGiroPrg(pgbProgress: TCxProgressBar): Boolean;
  Var
    item: TItem;
Begin
  cdsItensGiro.First;
  While Not cdsItensGiro.Eof Do
  Begin
    If cdsItensGiro.FieldByName('ITE_CODEMP').AsString = VS_StrCodEmp Then
    Begin
      item.strCodEmp := cdsItensGiro.FieldByName('ITE_CODEMP').AsString;
      item.strCodFor := cdsItensGiro.FieldByName('ITE_CODFOR').AsString;
      item.strCodIte := cdsItensGiro.FieldByName('ITE_CODITE').AsString;
      item.strCodMar := cdsItensGiro.FieldByName('ITE_CODMAR').AsString;
      item.strCodUni := cdsItensGiro.FieldByName('ITE_CODUNI').AsString;
      item.strDesIte := cdsItensGiro.FieldByName('ITE_DESITE').AsString;
      item.fltPreCus := cdsItensGiro.FieldByName('ITE_UNITAR').AsFloat;
      item.fltDesUni := cdsItensGiro.FieldByName('ITE_DESUNI').AsFloat;
      item.fltQtdIte := cdsItensGiro.FieldByName('ITE_QTDITE').AsFloat;
      item.fltEmbala := cdsItensGiro.FieldByName('ITE_EMBALA').AsFloat;
      item.fltPerIpi := cdsItensGiro.FieldByName('ITE_PERIPI').AsFloat;
      item.fltValIpi := cdsItensGiro.FieldByName('ITE_TOTIPI').AsFloat;
      item.strIncPis := cdsItensGiro.FieldByName('ITE_INCPIS').AsString;
      item.fltValFre := 0;

      If item.fltEmbala = 0 Then
        item.fltEmbala := 1;

      item.blnIgnCal := False;

      pAddItem(item, -1);
    End;

    pgbProgress.Position :=  pgbProgress.Position + 1;
    Application.ProcessMessages;

    cdsItensGiro.Next;
  End;

  pGerarOrcamentos;

  Result := True;
End;


end.
