unit untCadMetaCompDepVend;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask,
  MaskEditFocus, EditFocus, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxContainer, cxTextEdit, cxMaskEdit, cxDBEdit, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCitel, cxGrid, Vcl.DBCtrls, DBEditFocus, QColorLabel, Datasnap.DBClient,
  UniClientDataSet, untTypesSistema;

type
  TfrmCadMetaCompDepVend = class(TfrmPaiCad)
    pnlDados: TPanel;
    lblMesAno: TLabel;
    lblCliDep: TLabel;
    edtNomDep: TEditFocus;
    lblCodEmp: TLabel;
    edtNomEmp: TEditFocus;
    Panel1: TPanel;
    grdMeta1: TcxGridCitel;
    grdMeta1Tv: TcxGridDBTableViewCitel;
    grdMeta1Lvl: TcxGridLevel;
    edtMesAno: TcxDBMaskEdit;
    grdMeta1TvVALINI: TcxGridDBColumn;
    grdMeta1TvVALFIN: TcxGridDBColumn;
    grdMeta1TvVALPRE: TcxGridDBColumn;
    Panel2: TPanel;
    Label37: TLabel;
    ColorLabel1: TColorLabel;
    edtTipPreMeta1: TDBEditFocus;
    Label3: TLabel;
    dbeCodMdv: TDBEditFocus;
    cdsMT1: TUniClientDataSet;
    cdsMT1MT1_VALINI: TFloatField;
    cdsMT1MT1_VALFIN: TFloatField;
    cdsMT1MT1_VALPRE: TFloatField;
    dtsMT1: TDataSource;
    dtsTabela: TDataSource;
    edtCodDep: TDBEditFocus;
    edtCodEmp: TDBEditFocus;
    cdsMT1AUTOINCREM: TStringField;
    tbsMeta2: TTabSheet;
    dtsMT2: TDataSource;
    Panel3: TPanel;
    Label1: TLabel;
    ColorLabel2: TColorLabel;
    edtTipPreMeta2: TDBEditFocus;
    Panel4: TPanel;
    grdMeta2: TcxGridCitel;
    grdMeta2Tv: TcxGridDBTableViewCitel;
    grdMeta2TvVALINI: TcxGridDBColumn;
    grdMeta2TvVALFIN: TcxGridDBColumn;
    grdMeta2TvVALPRE: TcxGridDBColumn;
    grdMeta2Lvl: TcxGridLevel;
    cdsMT2: TUniClientDataSet;
    cdsMT2AUTOINCREM: TStringField;
    cdsMT2MT2_VALINI: TFloatField;
    cdsMT2MT2_VALFIN: TFloatField;
    cdsMT2MT2_VALPRE: TFloatField;
    btnDocDev: TBitBtnLocked;
    cdsMT2DocsDev: TUniClientDataSet;
    dtsMT2DocsDev: TDataSource;
    cdsMT2DocsDevDEV_NUMDOC: TStringField;
    cdsMT2DocsDevDEV_ESPDOC: TStringField;
    cdsMT2DocsDevDEV_CODEMP: TStringField;
    cdsMT2DocsDevDEV_DOCUME: TStringField;
    cdsMT2DocsDevDEV_CLIENTE: TStringField;
    cdsMT2DocsDevDEV_DTAEMI: TDateField;
    cdsMT2DocsDevDEV_VALDOC: TFloatField;
    cdsMT2DocsDevSELECIONADO: TBooleanField;
    tbsMeta3: TTabSheet;
    Panel5: TPanel;
    grdMeta3: TcxGridCitel;
    grdMeta3Tv: TcxGridDBTableViewCitel;
    grdMeta3TvCODITE: TcxGridDBColumn;
    grdMeta3TvDESITE: TcxGridDBColumn;
    grdMeta3TvVALPRE: TcxGridDBColumn;
    grdMeta3Lvl: TcxGridLevel;
    Panel6: TPanel;
    Label6: TLabel;
    ColorLabel3: TColorLabel;
    edtTipPreMeta3: TDBEditFocus;
    btnPesqProdutos: TBitBtnLocked;
    cdsMT3: TUniClientDataSet;
    cdsMT3AUTOINCREM: TStringField;
    cdsMT3MT3_VALPRE: TFloatField;
    dtsMT3: TDataSource;
    cdsMT3MT3_CODITE: TStringField;
    cdsMT3MT3_VALMET: TFloatField;
    cdsMT3MT3_DESITE: TStringField;
    grdMeta3TvVALMET: TcxGridDBColumn;
    tbsMeta4: TTabSheet;
    tbsMeta5: TTabSheet;
    Panel7: TPanel;
    grdMeta4: TcxGridCitel;
    grdMeta4Tv: TcxGridDBTableViewCitel;
    grdMeta4TvCODGRU: TcxGridDBColumn;
    grdMeta4TvVALMET: TcxGridDBColumn;
    grdMeta4TvVALPRE: TcxGridDBColumn;
    grdMeta4Lvl: TcxGridLevel;
    Panel8: TPanel;
    btnPesqLinGru: TBitBtnLocked;
    cdsMT4: TUniClientDataSet;
    dtsMT4: TDataSource;
    cdsMT4AUTOINCREM: TStringField;
    cdsMT4MT4_CODGRU: TStringField;
    cdsMT4MT4_DESGRU: TStringField;
    cdsMT4MT4_MED12M: TFloatField;
    cdsMT4MT4_MED03M: TFloatField;
    cdsMT4MT4_ACU12M: TFloatField;
    cdsMT4MT4_ACU03M: TFloatField;
    cdsMT4MT4_EVOLUC: TFloatField;
    cdsMT4MT4_VALMET: TFloatField;
    cdsMT4MT4_VALPRE: TFloatField;
    grdMeta4TvDESGRU: TcxGridDBColumn;
    grdMeta4TvMED12M: TcxGridDBColumn;
    grdMeta4TvMED03M: TcxGridDBColumn;
    grdMeta4TvACU12M: TcxGridDBColumn;
    grdMeta4TvACU03M: TcxGridDBColumn;
    grdMeta4TvEVOLUC: TcxGridDBColumn;
    grdMT5ResumoTv: TcxGridDBTableViewCitel;
    grdMT5ResumoLvl: TcxGridLevel;
    grdMT5Resumo: TcxGridCitel;
    grdMT5ResumoTvPERIOD: TcxGridDBColumn;
    grdMT5ResumoTvTOTTIC: TcxGridDBColumn;
    grdMT5ResumoTvDIAUTI: TcxGridDBColumn;
    grdMT5ResumoTvTICDIA: TcxGridDBColumn;
    grdMT5ResumoTvTICMES: TcxGridDBColumn;
    grdMT5ResumoTvUTIMES: TcxGridDBColumn;
    grdMT5ResumoTvSUGMES: TcxGridDBColumn;
    cdsMT5Resumo: TUniClientDataSet;
    dtsMT5Resumo: TDataSource;
    cdsMT5ResumoPERIOD: TStringField;
    cdsMT5ResumoTOTTIC: TFloatField;
    cdsMT5ResumoTICDIA: TFloatField;
    cdsMt5ResumoTICMES: TFloatField;
    cdsMT5ResumoUTIMES: TIntegerField;
    cdsMT5ResumoSUGMES: TFloatField;
    cdsMT5ResumoDIAUTI: TFloatField;
    cdsMT5: TUniClientDataSet;
    cdsMT5AUTOINCREM: TStringField;
    cdsMT5MT5_QTDINI: TFloatField;
    cdsMt5Mt5_QTDFIN: TFloatField;
    cdsMT5MT5_VALPRE: TFloatField;
    dtsMT5: TDataSource;
    grdMeta5: TcxGridCitel;
    grdMeta5Tv: TcxGridDBTableViewCitel;
    grdMeta5TvQTDINI: TcxGridDBColumn;
    grdMeta5TvQTDFIN: TcxGridDBColumn;
    grdMeta5TvVALPRE: TcxGridDBColumn;
    grdMeta5Lvl: TcxGridLevel;
    Panel9: TPanel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    btnAdicionarMeta5: TBitBtnLocked;
    btnCancelarMeta5: TBitBtnLocked;
    edtQtdIniMt5: TEditFocus;
    edtQtdFinMt5: TEditFocus;
    edtValPreMt5: TEditFocus;
    Panel10: TPanel;
    lblIniMt1: TLabel;
    lblFinMt1: TLabel;
    lblPreMt1: TLabel;
    btnAdicionarMeta1: TBitBtnLocked;
    btnCancelarMeta1: TBitBtnLocked;
    edtValIniMT1: TEditFocus;
    edtValFinMT1: TEditFocus;
    edtValPreMT1: TEditFocus;
    Panel11: TPanel;
    lblIniMt2: TLabel;
    lblFinMt2: TLabel;
    lblPreMt2: TLabel;
    btnAdicionarMeta2: TBitBtnLocked;
    btnCancelarMeta2: TBitBtnLocked;
    edtValIniMT2: TEditFocus;
    edtValFinMT2: TEditFocus;
    edtValPreMT2: TEditFocus;
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDepExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnAdicionarMeta1Click(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarMeta1Click(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure grdMeta1TvKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAdicionarMeta2Click(Sender: TObject);
    procedure btnCancelarMeta2Click(Sender: TObject);
    procedure btnDocDevClick(Sender: TObject);
    procedure btnPesqProdutosClick(Sender: TObject);
    procedure btnPesqLinGruClick(Sender: TObject);
    procedure cdsMT4BeforePost(DataSet: TDataSet);
    procedure btnAdicionarMeta5Click(Sender: TObject);
    procedure btnCancelarMeta5Click(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
    procedure edtTipPreMeta1Exit(Sender: TObject);
    procedure edtTipPreMeta2Exit(Sender: TObject);
    procedure edtTipPreMeta3Exit(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    strAceRom: String;

    arrCodDep,
    arrEmpres: TConsultasArray;

    procedure pVerificaTipoPremioMeta1;
    function fGravarMeta1: Boolean;
    procedure pCarregarMeta1;

    procedure pVerificaTipoPremioMeta2;
    function fGravarMeta2: Boolean;
    procedure pCarregarMeta2;

    procedure pVerificaTipoPremioMeta3;
    function fGravarMeta3: Boolean;
    procedure pCarregarMeta3;

    function fGravarMeta4: Boolean;
    procedure pCarregarMeta4;

    function fGravarMeta5: Boolean;
    procedure pCarregarMeta5;
    procedure pCarregarMeta5Resumo;

    function fRetSqlMeta4(blnFiltraLinha: Boolean): String;
    function fRetSqlMeta5: String;
    function fRetDiasUteis(dtaIni, dtaFin: TDate): Double;
    procedure pCarregarFeriados(stlFeriados: TStringList);

    procedure pLimparCds;
    procedure pCarregaDadosAdicionais;

  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
    procedure pOnStateChange; override;
  end;

implementation

uses
  untConsultas, untFuncoesConsulta, untFuncoesSimples, System.StrUtils, Uni,
  untMetaCompDepVendDocsDevolucao, System.Math, System.DateUtils;

{$R *.dfm}

procedure TfrmCadMetaCompDepVend.btnAdicionarMeta1Click(Sender: TObject);
var
  fltValIni: Double;
  fltValFin: Double;
  fltValPre: Double;
begin
  inherited;

  fltValIni := fStrToFloat(edtValIniMt1.Text);
  fltValFin := fStrToFloat(edtValFinMt1.Text);
  fltValPre := fStrToFloat(edtValPreMt1.Text);

  If (fltValIni < 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Valor Inicial deve ser maior ou igual a zero', ['&Ok']);
    Exit;
  End;

  If (fltValFin < 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Valor Final deve ser maior que zero', ['&Ok']);
    Exit;
  End;

  If (fltValPre < 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Valor do Prêmio deve ser maior ou igual a zero', ['&Ok']);
    Exit;
  End;

  If (fltValFin = 0) And
     ((fltValPre <> 0) Or (fltValIni <> 0)) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Valor Final deve ser maior que zero', ['&Ok']);
    Exit;
  End;

  If (Not ((fltValIni = 0) And
           (fltValFin = 0))) And
     (fltValFin  <= fltValIni) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Valor Final deve ser maior que o inicial', ['&Ok']);
    Exit;
  End;

//  if (edtTipPreMeta1.Text = 'P') and (fltValPre > 100.00) then
//  Begin
//    fMensagem('ATENÇÃO!', 'O Valor Prêmio não pode ser maior que 100%', ['&Ok']);
//    Exit;
//  End;

  cdsMT1.Append;
  cdsMT1MT1_VALINI.AsFloat := fltValIni;
  cdsMT1MT1_VALFIN.AsFloat := fltValFin;
  cdsMT1MT1_VALPRE.AsFloat := fltValPre;
  cdsMT1.Post;

  btnCancelarMeta1.Click;
end;

procedure TfrmCadMetaCompDepVend.btnAdicionarMeta2Click(Sender: TObject);
var
  fltValIni: Double;
  fltValFin: Double;
  fltValPre: Double;
begin
  inherited;

  fltValIni := fStrToFloat(edtValIniMt2.Text);
  fltValFin := fStrToFloat(edtValFinMt2.Text);
  fltValPre := fStrToFloat(edtValPreMt2.Text);

  If (fltValFin  <= fltValIni) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Percentual Final deve ser maior que o inicial', ['&Ok']);
    Exit;
  End;

//  if (edtTipPreMeta2.Text = 'P') and (fltValPre > 100.00) then
//  Begin
//    fMensagem('ATENÇÃO!', 'O Valor Prêmio não pode ser maior que 100%', ['&Ok']);
//    Exit;
//  End;

  cdsMT2.Append;
  cdsMT2MT2_VALINI.AsFloat := fltValIni;
  cdsMT2MT2_VALFIN.AsFloat := fltValFin;
  cdsMT2MT2_VALPRE.AsFloat := fltValPre;
  cdsMT2.Post;

  btnCancelarMeta2.Click;
end;

procedure TfrmCadMetaCompDepVend.btnAdicionarMeta5Click(Sender: TObject);
var
  fltQteIni: Double;
  fltQtdFin: Double;
  fltValPre: Double;
begin
  inherited;

  fltQteIni := fStrToFloat(edtQtdIniMt5.Text);
  fltQtdFin := fStrToFloat(edtQtdFinMt5.Text);
  fltValPre := fStrToFloat(edtValPreMt5.Text);

  If (fltQtdFin  <= fltQteIni) Then
  Begin
    fMensagem('ATENÇÃO!', 'A Qtde Final de Tickets deve ser maior que o inicial', ['&Ok']);
    Exit;
  End;

  cdsMT5.Append;
  cdsMT5MT5_QTDINI.AsFloat := fltQteIni;
  cdsMT5MT5_QTDFIN.AsFloat := fltQtdFin;
  cdsMT5MT5_VALPRE.AsFloat := fltValPre;
  cdsMT5.Post;

  btnCancelarMeta5.Click;
end;

procedure TfrmCadMetaCompDepVend.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodMdv, edtMesAno, False);
end;

procedure TfrmCadMetaCompDepVend.btnCancelarMeta1Click(Sender: TObject);
begin
  inherited;

  edtValIniMt1.Text := '0,00';
  edtValFinMt1.Text := '0,00';
  edtValPreMt1.Text := '0,00';
  pSetFocus(edtValIniMt1);
end;

procedure TfrmCadMetaCompDepVend.btnCancelarMeta2Click(Sender: TObject);
begin
  inherited;

  edtValIniMt2.Text := '0,00';
  edtValFinMt2.Text := '0,00';
  edtValPreMt2.Text := '0,00';
  pSetFocus(edtValIniMt2);
end;

procedure TfrmCadMetaCompDepVend.btnCancelarMeta5Click(Sender: TObject);
begin
  inherited;

  edtQtdIniMt5.Text := '0,00';
  edtQtdFinMt5.Text := '0,00';
  edtValPreMt5.Text := '0,00';
  pSetFocus(edtQtdIniMt5);
end;

procedure TfrmCadMetaCompDepVend.btnDocDevClick(Sender: TObject);
var
  frmMetaCompDepVendDocsDevolucao: TfrmMetaCompDepVendDocsDevolucao;
begin
  inherited;
  pCriarFormularios(TfrmMetaCompDepVendDocsDevolucao, frmMetaCompDepVendDocsDevolucao);
  Try
    frmMetaCompDepVendDocsDevolucao.cdsDocsDev := cdsMT2DocsDev;
    frmMetaCompDepVendDocsDevolucao.ShowModal;
  Finally
    pFreeAndNil(frmMetaCompDepVendDocsDevolucao);
  End;
end;

procedure TfrmCadMetaCompDepVend.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadMetaCompDepVend.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
  begin
    fCommit;
    pCarregaDadosAdicionais;
    pLimparCds;
  end
  Else
    fRollBack;
end;

procedure TfrmCadMetaCompDepVend.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadMetaCompDepVend.btnGravarClick]');
    End;
  End;

  Try
    If blnGravou Then
    Begin
      if not fGravarMeta1 then
      begin
        fRollBack;
        Exit;
      end;

      if not fGravarMeta2 then
      begin
        fRollBack;
        Exit;
      end;

      if not fGravarMeta3 then
      begin
        fRollBack;
        Exit;
      end;

      if not fGravarMeta4 then
      begin
        fRollBack;
        Exit;
      end;

      if not fGravarMeta5 then
      begin
        fRollBack;
        Exit;
      end;

      fCommit;

    End
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message,'[btnGravarClick]');
    End;
  End;
end;

procedure TfrmCadMetaCompDepVend.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodMdv, edtMesAno, False)
  Else
    pHabilitaCodigo(dbeCodMdv, dbeCodMdv, True);

  pCarregaDadosAdicionais;
  pLimparCds;
end;

procedure TfrmCadMetaCompDepVend.btnPesqLinGruClick(Sender: TObject);
var
  arrSel: TConsultasArray;
  objConsulta: TConsultas;
  chrKey: Char;
begin
  inherited;
  chrKey := '/';
  If fPesqGrupo(Self, Nil, Nil, Nil, chrKey, arrSel, False) Then
  Begin
    for objConsulta in arrSel do
    begin
      if not cdsMT4.Locate('MT4_CODGRU', objConsulta.strCodigo, []) then
      begin;
        cdsMT4.Append;
        cdsMT4MT4_CODGRU.AsString :=  objConsulta.strCodigo;
        cdsMT4MT4_DESGRU.AsString := fRetNomeLinhaGrupo(objConsulta.strCodigo);
        cdsMT4.Post;
      end;
    end;
  End;
end;

procedure TfrmCadMetaCompDepVend.btnPesqProdutosClick(Sender: TObject);
var
  arrSel: TConsultasArray;
  objConsulta: TConsultas;
  chrKey: Char;
begin
  inherited;
  chrKey := '/';
  if fPesqItem(conIteSimples, Self, Nil, Nil, Nil, chrKey, arrSel, False) then
  Begin
    for objConsulta in arrSel do
    begin
      if not cdsMT3.Locate('MT3_CODITE', objConsulta.strCodigo, []) then
      begin;
        cdsMT3.Append;
        cdsMT3MT3_CODITE.AsString := objConsulta.strCodigo;
        cdsMT3MT3_DESITE.AsString := fRetNomProduto(objConsulta.strCodigo);
        cdsMT3.Post;
      end;
    end;
  End;
end;

procedure TfrmCadMetaCompDepVend.btnPesquisaClick(Sender: TObject);
Var
  arrConsulta: TConsultasArray;
  chrKey : Char;
begin
  inherited;
  chrKey := '/';
  If fPesqMetaCompDepVend(Self, qryTabela, chrKey, arrConsulta) Then
  begin
    pCarregaDadosAdicionais;

    pCarregarMeta1;
    pVerificaTipoPremioMeta1;

    pCarregarMeta2;
    pVerificaTipoPremioMeta2;

    pCarregarMeta3;
    pVerificaTipoPremioMeta3;

    pCarregarMeta4;

    pCarregarMeta5;

    pSetFocus(btnAlterar);
  end;
end;

procedure TfrmCadMetaCompDepVend.cdsMT4BeforePost(DataSet: TDataSet);
var
  sqlQuery: TUniQuery;
  dtaInicial12M, dtaInicial03M, dtaFinal: TDateTime;
begin
  inherited;
  if cdsMT4MT4_MED12M.isNull then
  begin
    dtaFinal := EncodeDate(StrToInt(Copy(qryTabela.FieldByName('MDV_MESANO').AsString, 4, 4)),
                           StrToInt(Copy(qryTabela.FieldByName('MDV_MESANO').AsString, 1, 2)),
                           1);
    dtaFinal := EndOfTheMonth(IncMonth(dtaFinal, -1));
    dtaInicial03M := StartOfTheMonth(IncMonth(dtaFinal, -3));
    dtaInicial12M := StartOfTheMonth(IncMonth(dtaFinal, -12));

    sqlQuery := fCriaQuery;
    try
      sqlQuery.SQL.Text := fRetSqlMeta4(True);
      sqlQuery.ParamByName('CODGRU').AsString := cdsMT4MT4_CODGRU.AsString;
      sqlQuery.ParamByName('CODEMP').AsString := qryTabela.FieldByName('MDV_CODEMP').AsString;
      sqlQuery.ParamByName('DTAINI').AsDateTime := dtaInicial12M;
      sqlQuery.ParamByName('DTAFIN').AsDateTime := dtaFinal;
      sqlQuery.Open;

      cdsMT4MT4_MED12M.AsFloat := sqlQuery.FieldByName('MEDIA').AsFloat;
      sqlQuery.Close;

      sqlQuery.ParamByName('DTAINI').AsDateTime := dtaInicial03M;
      sqlQuery.Open;

      cdsMT4MT4_MED03M.AsFloat := sqlQuery.FieldByName('MEDIA').AsFloat;
      sqlQuery.Close;

      //\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
      sqlQuery.SQL.Text := fRetSqlMeta4(False);
      sqlQuery.ParamByName('CODEMP').AsString := qryTabela.FieldByName('MDV_CODEMP').AsString;
      sqlQuery.ParamByName('DTAINI').AsDateTime := dtaInicial12M;
      sqlQuery.ParamByName('DTAFIN').AsDateTime := dtaFinal;
      sqlQuery.Open;

      if sqlQuery.FieldByName('MEDIA').AsFloat > 0 then
        cdsMT4MT4_ACU12M.AsFloat := RoundTo((cdsMT4MT4_MED12M.AsFloat*100)/sqlQuery.FieldByName('MEDIA').AsFloat, -2)
      else
        cdsMT4MT4_ACU12M.AsFloat := 0;

      sqlQuery.ParamByName('DTAINI').AsDateTime := dtaInicial03M;
      sqlQuery.Open;

      if sqlQuery.FieldByName('MEDIA').AsFloat > 0 then
        cdsMT4MT4_ACU03M.AsFloat := RoundTo((cdsMT4MT4_MED03M.AsFloat*100)/sqlQuery.FieldByName('MEDIA').AsFloat, -2)
      else
        cdsMT4MT4_ACU03M.AsFloat := 0;

      if cdsMT4MT4_MED03M.AsFloat > 0 then
        cdsMT4MT4_EVOLUC.AsFloat := RoundTo(( ( cdsMT4MT4_MED12M.AsFloat / cdsMT4MT4_MED03M.AsFloat  ) - 1) * 100, -2)
      else
        cdsMT4MT4_EVOLUC.AsFloat := 0;

    finally
      FreeAndNil(sqlQuery);
    end;
  end;
end;

procedure TfrmCadMetaCompDepVend.edtCodDepExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodDep, edtNomDep, arrCodDep, fRetDescDepartamento, Nil, 'do Departamento');
end;

procedure TfrmCadMetaCompDepVend.edtCodDepKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqDepartamento(Self, edtCodDep, edtNomDep, Nil, Key, arrCodDep, True) Then
    If fValidaCampos(edtCodDep, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadMetaCompDepVend.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmpres, fRetNomeEmpresa, nil, 'da Empresa');
end;

procedure TfrmCadMetaCompDepVend.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmpres, True, False, strAceRom) Then
    If fValidaCampos(edtCodEmp, True) Then
      Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadMetaCompDepVend.edtTipPreMeta1Exit(Sender: TObject);
begin
  inherited;
  pVerificaTipoPremioMeta1;
end;

procedure TfrmCadMetaCompDepVend.edtTipPreMeta2Exit(Sender: TObject);
begin
  inherited;
  pVerificaTipoPremioMeta2;
end;

procedure TfrmCadMetaCompDepVend.edtTipPreMeta3Exit(Sender: TObject);
begin
  inherited;
  pVerificaTipoPremioMeta3;
end;

function TfrmCadMetaCompDepVend.fGravarMeta1: Boolean;
var
  qryUpd: TUniQuery;
  I: Integer;
begin
  qryUpd := fCriaQuery;
  try
    qryUpd.SQL.Clear;
    qryUpd.SQL.Add('DELETE FROM MDVMT1 WHERE MT1_SEQMDV = :SEQMDV');
    qryUpd.ParamByName('SEQMDV').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
    qryUpd.ExecSql;

    qryUpd.SQL.Clear;
    qryUpd.SQL.Add('SELECT * FROM MDVMT1 WHERE 1=2');
    qryUpd.Open;

    cdsMT1.DisableControls;
    try
      cdsMT1.First;
      while not cdsMT1.Eof do
      begin
        qryUpd.Append;

        for I := 0 to Pred(cdsMT1.Fields.Count) do
          qryUpd.FieldByName(cdsMT1.Fields[I].FieldName).Value := cdsMT1.Fields[I].Value;

        if fEmptyStr(qryUpd.FieldByName('AUTOINCREM').AsString) then
          qryUpd.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('MDVMT1', VS_strCodEmp);

        qryUpd.FieldByName('MT1_SEQMDV').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;

        qryUpd.Post;

        cdsMT1.Next;
      end;
    finally
      cdsMT1.EnableControls;
    end;
  finally
    FreeAndNil(qryUpd);
  end;

  Result := True;
end;

function TfrmCadMetaCompDepVend.fGravarMeta2: Boolean;
var
  qryUpd: TUniQuery;
  I: Integer;
begin
  qryUpd := fCriaQuery;
  try
    qryUpd.SQL.Clear;
    qryUpd.SQL.Add('DELETE FROM MDVMT2 WHERE MT2_SEQMDV = :SEQMDV');
    qryUpd.ParamByName('SEQMDV').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
    qryUpd.ExecSql;

    qryUpd.SQL.Clear;
    qryUpd.SQL.Add('SELECT * FROM MDVMT2 WHERE 1=2');
    qryUpd.Open;

    cdsMT2.DisableControls;
    try
      cdsMT2.First;
      while not cdsMT2.Eof do
      begin
        qryUpd.Append;

        for I := 0 to Pred(cdsMT2.Fields.Count) do
          qryUpd.FieldByName(cdsMT2.Fields[I].FieldName).Value := cdsMT2.Fields[I].Value;

        if fEmptyStr(qryUpd.FieldByName('AUTOINCREM').AsString) then
          qryUpd.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('MDVMT2', VS_strCodEmp);

        qryUpd.FieldByName('MT2_SEQMDV').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;

        qryUpd.Post;

        cdsMT2.Next;
      end;
    finally
      cdsMT2.EnableControls;
    end;
  finally
    FreeAndNil(qryUpd);
  end;

  qryUpd := fCriaQuery;
  try
    qryUpd.SQL.Clear;
    qryUpd.SQL.Add('DELETE FROM MT2DEV WHERE DEV_SEQMDV = :SEQMDV');
    qryUpd.ParamByName('SEQMDV').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
    qryUpd.ExecSql;

    qryUpd.SQL.Clear;
    qryUpd.SQL.Add('SELECT * FROM MT2DEV WHERE 1=2');
    qryUpd.Open;

    cdsMT2DocsDev.DisableControls;
    try
      cdsMT2DocsDev.First;
      while not cdsMT2DocsDev.Eof do
      begin
        qryUpd.Append;

        for I := 0 to Pred(qryUpd.Fields.Count) do
          if Assigned(cdsMT2DocsDev.FindField(qryUpd.Fields[I].FieldName)) then
            qryUpd.Fields[I].Value := cdsMT2DocsDev.FieldByName(qryUpd.Fields[I].FieldName).Value;

        qryUpd.FieldByName('DEV_SEQMDV').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;

        qryUpd.Post;

        cdsMT2DocsDev.Next;
      end;
    finally
      cdsMT2DocsDev.EnableControls;
    end;
  finally
    FreeAndNil(qryUpd);
  end;

  Result := True;
end;

function TfrmCadMetaCompDepVend.fGravarMeta3: Boolean;
var
  qryUpd: TUniQuery;
  I: Integer;
begin
  qryUpd := fCriaQuery;
  try
    qryUpd.SQL.Clear;
    qryUpd.SQL.Add('DELETE FROM MDVMT3 WHERE MT3_SEQMDV = :SEQMDV');
    qryUpd.ParamByName('SEQMDV').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
    qryUpd.ExecSql;

    qryUpd.SQL.Clear;
    qryUpd.SQL.Add('SELECT * FROM MDVMT3 WHERE 1=2');
    qryUpd.Open;

    cdsMT3.DisableControls;
    try
      cdsMT3.First;
      while not cdsMT3.Eof do
      begin
        qryUpd.Append;

        for I := 0 to Pred(cdsMT3.Fields.Count) do
          if Assigned(qryUpd.FindField(cdsMT3.Fields[I].FieldName)) then
            qryUpd.FieldByName(cdsMT3.Fields[I].FieldName).Value := cdsMT3.Fields[I].Value;

        if fEmptyStr(qryUpd.FieldByName('AUTOINCREM').AsString) then
          qryUpd.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('MDVMT3', VS_strCodEmp);

        qryUpd.FieldByName('MT3_SEQMDV').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;

        qryUpd.Post;

        cdsMT3.Next;
      end;
    finally
      cdsMT3.EnableControls;
    end;
  finally
    FreeAndNil(qryUpd);
  end;

  Result := True;
end;

function TfrmCadMetaCompDepVend.fGravarMeta4: Boolean;
var
  qryUpd: TUniQuery;
  I: Integer;
begin
  qryUpd := fCriaQuery;
  try
    qryUpd.SQL.Clear;
    qryUpd.SQL.Add('DELETE FROM MDVMT4 WHERE MT4_SEQMDV = :SEQMDV');
    qryUpd.ParamByName('SEQMDV').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
    qryUpd.ExecSql;

    qryUpd.SQL.Clear;
    qryUpd.SQL.Add('SELECT * FROM MDVMT4 WHERE 1=2');
    qryUpd.Open;

    cdsMT4.DisableControls;
    try
      cdsMT4.First;
      while not cdsMT4.Eof do
      begin
        qryUpd.Append;

        for I := 0 to Pred(cdsMT4.Fields.Count) do
          if Assigned(qryUpd.FindField(cdsMT4.Fields[I].FieldName)) then
            qryUpd.FieldByName(cdsMT4.Fields[I].FieldName).Value := cdsMT4.Fields[I].Value;

        if fEmptyStr(qryUpd.FieldByName('AUTOINCREM').AsString) then
          qryUpd.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('MDVMT4', VS_strCodEmp);

        qryUpd.FieldByName('MT4_SEQMDV').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;

        qryUpd.Post;

        cdsMT4.Next;
      end;
    finally
      cdsMT4.EnableControls;
    end;
  finally
    FreeAndNil(qryUpd);
  end;

  Result := True;
end;

function TfrmCadMetaCompDepVend.fGravarMeta5: Boolean;
var
  qryUpd: TUniQuery;
  I: Integer;
begin
  qryUpd := fCriaQuery;
  try
    qryUpd.SQL.Clear;
    qryUpd.SQL.Add('DELETE FROM MDVMT5 WHERE MT5_SEQMDV = :SEQMDV');
    qryUpd.ParamByName('SEQMDV').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
    qryUpd.ExecSql;

    qryUpd.SQL.Clear;
    qryUpd.SQL.Add('SELECT * FROM MDVMT5 WHERE 1=2');
    qryUpd.Open;

    cdsMT5.DisableControls;
    try
      cdsMT5.First;
      while not cdsMT5.Eof do
      begin
        qryUpd.Append;

        for I := 0 to Pred(cdsMT5.Fields.Count) do
          qryUpd.FieldByName(cdsMT5.Fields[I].FieldName).Value := cdsMT5.Fields[I].Value;

        if fEmptyStr(qryUpd.FieldByName('AUTOINCREM').AsString) then
          qryUpd.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('MDVMT5', VS_strCodEmp);

        qryUpd.FieldByName('MT5_SEQMDV').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;

        qryUpd.Post;

        cdsMT5.Next;
      end;
    finally
      cdsMT5.EnableControls;
    end;
  finally
    FreeAndNil(qryUpd);
  end;

  Result := True;
end;

procedure TfrmCadMetaCompDepVend.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
end;

procedure TfrmCadMetaCompDepVend.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CADMDV';
  strNomeCampo      := 'MDV_CODMDV';
  qryTabela         := fCriaQuery(Self);
  dtsTabela.DataSet := qryTabela;

  SetLength(arrCamposChave, 1 );
  arrCamposChave[0] := dbeCodMdv;

  strAceRom := fCampoTabela('OPE_EMPROM', 'CADOPE', ['OPE_CODOPE'], [strLoginUsuarioLogado]);

  cdsMT1.CreateDataSet;
  cdsMT2.CreateDataSet;
  cdsMT2DocsDev.CreateDataSet;
  cdsMT3.CreateDataSet;
  cdsMT4.CreateDataSet;
  cdsMT5.CreateDataSet;
  cdsMT5Resumo.CreateDataSet;

  pgcDados.ActivePageIndex := 0;
end;

function TfrmCadMetaCompDepVend.fRetSqlMeta4(blnFiltraLinha: Boolean): String;
begin
  Result := Result + '  SELECT SUM(DET_TOTITE - DET_DESESP) AS MEDIA';
  Result := Result + '  FROM MOVDET';
  Result := Result + '  INNER JOIN CADITE ON ITE_CODITE = DET_CODITE';
  Result := Result + '  WHERE DET_PROEMB <> "S"';
  Result := Result + '    AND DET_DTAENT BETWEEN :DTAINI AND :DTAFIN';
  Result := Result + '    AND ((LOCATE(DET_CLAFIS, '+QuotedStr(VS_strClaVen)+') > 0) OR (LOCATE(DET_CLAFIS, '+QuotedStr(VS_strClaDev)+') > 0)) ';
  Result := Result + '    AND ITE_CODEMP = :CODEMP';
  if blnFiltraLinha then
    Result := Result + '    AND ITE_CODGRU = :CODGRU';
end;

function TfrmCadMetaCompDepVend.fRetSqlMeta5: String;
begin
  Result := Result + '  SELECT COUNT(DISTINCT DET_SEQGER) AS TOTTIC';
  Result := Result + '  FROM MOVDET';
  Result := Result + '  INNER JOIN CADITE ON ITE_CODITE = DET_CODITE';
  Result := Result + '  WHERE DET_PROEMB <> "S"';
  Result := Result + '    AND DET_DTAENT BETWEEN :DTAINI AND :DTAFIN';
  Result := Result + '    AND ((LOCATE(DET_CLAFIS, '+QuotedStr(VS_strClaVen)+') > 0) OR (LOCATE(DET_CLAFIS, '+QuotedStr(VS_strClaDev)+') > 0)) ';
  Result := Result + '    AND ITE_CODEMP = :CODEMP';
end;

function TfrmCadMetaCompDepVend.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender,blnBuscaPorChave)) Then
  Begin
    If (Sender = edtMesAno) Then
    Begin
      If fEmptyStr(edtMesAno.Text) or (edtMesAno.Text = '  /    ') Then
      Begin
        fMensagem('ATENÇÃO!', 'O Mês/Ano deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If String(edtMesAno.Text).Contains(' ') Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o Mês/Ano corretamente!', ['&Ok']);
        Result := False;
      End
      Else
        pCarregarMeta5Resumo;
    End

    else if Sender = edtCodDep then
    begin
      If fEmptyStr(edtCodDep.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Departamento Operador deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    end

    else if Sender = edtCodEmp then
    begin
      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Empresa deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else
        pCarregarMeta5Resumo;
    end

    else if Sender = edtTipPreMeta1 then
    begin
      if not AnsiMatchStr(edtTipPreMeta1.Text, ['V', 'P']) then
      begin
        fMensagem('', 'O campo Tipo do Prêmio (Meta 1) deve ser V ou P!', ['&O k']);
        Result := False;
      end
      else
        pVerificaTipoPremioMeta1;
    end

    else if Sender = edtTipPreMeta2 then
    begin
      if not AnsiMatchStr(edtTipPreMeta2.Text, ['V', 'P']) then
      begin
        fMensagem('', 'O campo Tipo do Prêmio (Meta 2) deve ser V ou P!', ['&O k']);
        Result := False;
      end
      else
        pVerificaTipoPremioMeta2;
    end

    else if Sender = edtTipPreMeta3 then
    begin
      if not AnsiMatchStr(edtTipPreMeta3.Text, ['V', 'P']) then
      begin
        fMensagem('', 'O campo Tipo do Prêmio (Meta 3) deve ser V ou P!', ['&O k']);
        Result := False;
      end
      else
        pVerificaTipoPremioMeta3;
    end;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadMetaCompDepVend.grdMeta1TvKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  DataSet: TDataSet;
begin
  inherited;
  if Key = VK_DELETE then
  begin
    case pgcDados.ActivePageIndex of
      0: DataSet := cdsMT1;
      1: DataSet := cdsMT2;
      2: DataSet := cdsMT3;
      3: DataSet := cdsMT4;
      4: DataSet := cdsMT5;
    else
      DataSet := Nil;
    end;

    if not Assigned(DataSet) then
      Exit;

    if DataSet.Active and (not DataSet.IsEmpty) then
      DataSet.Delete;
  end;
end;

procedure TfrmCadMetaCompDepVend.pCarregarMeta1;
var
  qrySelect: TUniQuery;
  I: Integer;
begin
  cdsMT1.EmptyDataSet;

  qrySelect := fCriaQuery;
  try
    qrySelect.SQL.Add('SELECT * FROM MDVMT1 WHERE MT1_SEQMDV = :SEQMDV');
    qrySelect.ParamByName('SEQMDV').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
    qrySelect.Open;

    while not qrySelect.Eof do
    begin
      cdsMT1.Append;
      for I := 0 to Pred(cdsMT1.Fields.Count) do
        cdsMT1.Fields[I].Value := qrySelect.FieldByName(cdsMT1.Fields[I].FieldName).Value;
      cdsMT1.Post;

      qrySelect.Next;
    end;
  finally
    FreeAndNil(qrySelect);
  end;
end;

procedure TfrmCadMetaCompDepVend.pCarregarMeta2;
var
  qrySelect: TUniQuery;
  I: Integer;
begin
  cdsMT2.EmptyDataSet;

  qrySelect := fCriaQuery;
  try
    qrySelect.SQL.Add('SELECT * FROM MDVMT2 WHERE MT2_SEQMDV = :SEQMDV');
    qrySelect.ParamByName('SEQMDV').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
    qrySelect.Open;

    while not qrySelect.Eof do
    begin
      cdsMT2.Append;
      for I := 0 to Pred(cdsMT2.Fields.Count) do
        cdsMT2.Fields[I].Value := qrySelect.FieldByName(cdsMT2.Fields[I].FieldName).Value;
      cdsMT2.Post;

      qrySelect.Next;
    end;
  finally
    FreeAndNil(qrySelect);
  end;

  cdsMT2DocsDev.EmptyDataSet;

  qrySelect := fCriaQuery;
  try
    qrySelect.SQL.Add('SELECT MT2DEV.*,');
    qrySelect.SQL.Add('  FALSE AS SELECIONADO, ');
    qrySelect.SQL.Add('  CONCAT(GER_NUMDOC, "-", GER_ESPDOC) AS DEV_DOCUME, ');
    qrySelect.SQL.Add('  CONCAT(GER_CODCLI, "-", CLI_NOMCLI) AS DEV_CLIENTE, ');
    qrySelect.SQL.Add('  GER_DTAENT AS DEV_DTAEMI, ');
    qrySelect.SQL.Add('  GER_VLRCON AS DEV_VALDOC ');
    qrySelect.SQL.Add('FROM MT2DEV');
    qrySelect.SQL.Add('LEFT JOIN MOVGER ON GER_NUMDOC = DEV_NUMDOC AND GER_ESPDOC = DEV_ESPDOC AND GER_CODEMP = DEV_CODEMP');
    qrySelect.SQL.Add('LEFT JOIN CADCLI ON CLI_CODCLI = GER_CODCLI');
    qrySelect.SQL.Add('WHERE DEV_SEQMDV = :SEQMDV');
    qrySelect.ParamByName('SEQMDV').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
    qrySelect.Open;

    while not qrySelect.Eof do
    begin
      cdsMT2DocsDev.Append;
      for I := 0 to Pred(cdsMT2DocsDev.Fields.Count) do
        cdsMT2DocsDev.Fields[I].Value := qrySelect.FieldByName(cdsMT2DocsDev.Fields[I].FieldName).Value;
      cdsMT2DocsDev.Post;

      qrySelect.Next;
    end;
  finally
    FreeAndNil(qrySelect);
  end;
end;

procedure TfrmCadMetaCompDepVend.pCarregarMeta3;
var
  qrySelect: TUniQuery;
  I: Integer;
begin
  cdsMT3.EmptyDataSet;

  qrySelect := fCriaQuery;
  try
    qrySelect.SQL.Add('SELECT MDVMT3.*, ITE_DESITE AS MT3_DESITE');
    qrySelect.SQL.Add('FROM MDVMT3');
    qrySelect.SQL.Add('LEFT JOIN CADITE ON ITE_CODITE = MT3_CODITE');
    qrySelect.SQL.Add('WHERE MT3_SEQMDV = :SEQMDV');
    qrySelect.ParamByName('SEQMDV').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
    qrySelect.Open;

    while not qrySelect.Eof do
    begin
      cdsMT3.Append;
      for I := 0 to Pred(cdsMT3.Fields.Count) do
        cdsMT3.Fields[I].Value := qrySelect.FieldByName(cdsMT3.Fields[I].FieldName).Value;
      cdsMT3.Post;

      qrySelect.Next;
    end;
  finally
    FreeAndNil(qrySelect);
  end;
end;

procedure TfrmCadMetaCompDepVend.pCarregarMeta4;
var
  qrySelect: TUniQuery;
  I: Integer;
begin
  cdsMT4.EmptyDataSet;

  qrySelect := fCriaQuery;
  try
    qrySelect.SQL.Add('SELECT MDVMT4.*, GRU_DESGRU AS MT4_DESGRU');
    qrySelect.SQL.Add('FROM MDVMT4');
    qrySelect.SQL.Add('LEFT JOIN CADGRU ON GRU_CODGRU = MT4_CODGRU');
    qrySelect.SQL.Add('WHERE MT4_SEQMDV = :SEQMDV');
    qrySelect.ParamByName('SEQMDV').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
    qrySelect.Open;

    while not qrySelect.Eof do
    begin
      cdsMT4.Append;
      for I := 0 to Pred(cdsMT4.Fields.Count) do
        if Assigned(qrySelect.FindField(cdsMT4.Fields[I].FieldName)) then
          cdsMT4.Fields[I].Value := qrySelect.FieldByName(cdsMT4.Fields[I].FieldName).Value;
      cdsMT4.Post;

      qrySelect.Next;
    end;
  finally
    FreeAndNil(qrySelect);
  end;
end;

procedure TfrmCadMetaCompDepVend.pCarregarMeta5;
var
  qrySelect: TUniQuery;
  I: Integer;
begin
  cdsMT5.EmptyDataSet;

  qrySelect := fCriaQuery;
  try
    qrySelect.SQL.Add('SELECT * FROM MDVMT5 WHERE MT5_SEQMDV = :SEQMDV');
    qrySelect.ParamByName('SEQMDV').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
    qrySelect.Open;

    while not qrySelect.Eof do
    begin
      cdsMT5.Append;
      for I := 0 to Pred(cdsMT5.Fields.Count) do
        cdsMT5.Fields[I].Value := qrySelect.FieldByName(cdsMT5.Fields[I].FieldName).Value;
      cdsMT5.Post;

      qrySelect.Next;
    end;
  finally
    FreeAndNil(qrySelect);
  end;

  pCarregarMeta5Resumo;
end;

procedure TfrmCadMetaCompDepVend.pCarregarMeta5Resumo;
var
  qrySelect: TUniQuery;
  dtaInicial12M, dtaInicial03M, dtaFinal: TDateTime;
begin
  if fEmptyStr(qryTabela.FieldByName('MDV_MESANO').AsString) or fEmptyStr(qryTabela.FieldByName('MDV_CODEMP').AsString) then
    Exit;

  dtaFinal := EncodeDate(StrToInt(Copy(qryTabela.FieldByName('MDV_MESANO').AsString, 4, 4)),
                         StrToInt(Copy(qryTabela.FieldByName('MDV_MESANO').AsString, 1, 2)),
                         1);
  dtaFinal := EndOfTheMonth(IncMonth(dtaFinal, -1));
  dtaInicial03M := StartOfTheMonth(IncMonth(dtaFinal, -3));
  dtaInicial12M := StartOfTheMonth(IncMonth(dtaFinal, -12));

  cdsMT5Resumo.EmptyDataSet;

  qrySelect := fCriaQuery;
  try
    qrySelect.SQL.Text := fRetSqlMeta5;
    qrySelect.ParamByName('CODEMP').AsString := qryTabela.FieldByName('MDV_CODEMP').AsString;
    qrySelect.ParamByName('DTAINI').AsDateTime := dtaInicial12M;
    qrySelect.ParamByName('DTAFIN').AsDateTime := dtaFinal;
    qrySelect.Open;

    cdsMT5Resumo.Append;
    cdsMT5ResumoPERIOD.AsString := 'Ano Anterior';
    cdsMT5ResumoTOTTIC.AsFloat := qrySelect.FieldByName('TOTTIC').AsFloat;
    cdsMT5ResumoDIAUTI.AsFloat := fRetDiasUteis(dtaInicial12M, dtaFinal);
    cdsMT5ResumoTICDIA.AsFloat := RoundTo(cdsMT5ResumoTOTTIC.AsFloat / cdsMT5ResumoDIAUTI.AsFloat, -2);
    cdsMt5ResumoTICMES.AsFloat := RoundTo(cdsMT5ResumoTOTTIC.AsFloat / 12, -2);
    cdsMT5ResumoUTIMES.AsFloat := fRetDiasUteis(StartOfTheMonth(fNow), EndOfTheMonth(fNow));
    cdsMT5ResumoSUGMES.AsFloat := RoundTo(cdsMT5ResumoTOTTIC.AsFloat / cdsMT5ResumoDIAUTI.AsFloat * cdsMT5ResumoUTIMES.AsFloat, -2);
    cdsMT5Resumo.Post;

    qrySelect.Close;
    qrySelect.ParamByName('DTAINI').AsDateTime := dtaInicial03M;
    qrySelect.Open;

    cdsMT5Resumo.Append;
    cdsMT5ResumoPERIOD.AsString := 'Trimestre Anterior';
    cdsMT5ResumoTOTTIC.AsFloat := qrySelect.FieldByName('TOTTIC').AsFloat;
    cdsMT5ResumoDIAUTI.AsFloat := fRetDiasUteis(dtaInicial03M, dtaFinal);
    cdsMT5ResumoTICDIA.AsFloat := RoundTo(cdsMT5ResumoTOTTIC.AsFloat / cdsMT5ResumoDIAUTI.AsFloat, -2);
    cdsMt5ResumoTICMES.AsFloat := RoundTo(cdsMT5ResumoTOTTIC.AsFloat / 03, -2);
    cdsMT5ResumoUTIMES.AsFloat := fRetDiasUteis(StartOfTheMonth(fNow), EndOfTheMonth(fNow));
    cdsMT5ResumoSUGMES.AsFloat := RoundTo(cdsMT5ResumoTOTTIC.AsFloat / cdsMT5ResumoDIAUTI.AsFloat * cdsMT5ResumoUTIMES.AsFloat, -2);
    cdsMT5Resumo.Post;
  finally
    FreeAndNil(qrySelect);
  end;
end;

procedure TfrmCadMetaCompDepVend.pgcDadosChange(Sender: TObject);
begin
  inherited;
  if (pgcDados.ActivePageIndex = tbsMeta5.PageIndex) and cdsMT5Resumo.IsEmpty then
      pCarregarMeta5Resumo;
end;

procedure TfrmCadMetaCompDepVend.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('MDV_CODMDV');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('MDV_CODMDV');

  stlDesInd.Add('Código');
end;

procedure TfrmCadMetaCompDepVend.pLimparCds;
begin
  cdsMT1.EmptyDataSet;
  cdsMT2.EmptyDataSet;
  cdsMT2DocsDev.EmptyDataSet;
  cdsMT3.EmptyDataSet;
  cdsMT4.EmptyDataSet;
  cdsMT5.EmptyDataSet;
  cdsMT5Resumo.EmptyDataSet;
end;

procedure TfrmCadMetaCompDepVend.pOnStateChange;
begin
  inherited;
  edtMesAno.Enabled := qryTabela.State in dsEditModes;
  btnAdicionarMeta1.Enabled := qryTabela.State in dsEditModes;
  btnCancelarMeta1.Enabled := qryTabela.State in dsEditModes;

  btnAdicionarMeta2.Enabled := qryTabela.State in dsEditModes;
  btnCancelarMeta2.Enabled := qryTabela.State in dsEditModes;
  btnDocDev.Enabled := qryTabela.State in dsEditModes;

  btnPesqProdutos.Enabled := qryTabela.State in dsEditModes;

  btnPesqLinGru.Enabled := qryTabela.State in dsEditModes;

  btnAdicionarMeta5.Enabled := qryTabela.State in dsEditModes;
  btnCancelarMeta5.Enabled := qryTabela.State in dsEditModes;
end;

procedure TfrmCadMetaCompDepVend.pVerificaTipoPremioMeta1;
begin
  if edtTipPreMeta1.Text = 'V' then
  begin
    cdsMT1MT1_VALPRE.DisplayFormat := '#,##0.00';
    edtValPreMT1.EditFormat := '#,##0.00';
  end
  else
  begin
    cdsMT1MT1_VALPRE.DisplayFormat := '##0.00 %';
    edtValPreMT1.EditFormat := '##0.00';
  end;
end;

procedure TfrmCadMetaCompDepVend.pVerificaTipoPremioMeta2;
begin
  if edtTipPreMeta2.Text = 'V' then
  begin
    cdsMT2MT2_VALPRE.DisplayFormat := '#,##0.00';
    edtValPreMT2.EditFormat := '#,##0.00';
  end
  else
  begin
    cdsMT2MT2_VALPRE.DisplayFormat := '##0.00 %';
    edtValPreMT2.EditFormat := '##0.00';
  end;
end;

procedure TfrmCadMetaCompDepVend.pVerificaTipoPremioMeta3;
begin
  if edtTipPreMeta3.Text = 'V' then
    cdsMT3MT3_VALPRE.DisplayFormat := '#,##0.00'
  else
    cdsMT3MT3_VALPRE.DisplayFormat := '##0.00';
end;

function TfrmCadMetaCompDepVend.fRetDiasUteis(dtaIni, dtaFin: TDate): Double;
Var
  dtaAtu: TDate;
  fltSabUti, fltDomUti: Double;
  stlFeriados: TStringList;
begin
  Result := 0;
  dtaAtu := dtaIni;

  fltSabUti := fCfgSis('SABUTI', varDouble);
  fltDomUti := fCfgSis('DOMUTI', varDouble);

  stlFeriados := TStringList.Create;
  try
    pCarregarFeriados(stlFeriados);

    While dtaAtu <= dtaFin Do
    Begin
      If DayOfTheWeek(dtaAtu) < 7 Then // Verifica se considera o sábado (0, 0.5, 0.75, 1)
      Begin
        If stlFeriados.IndexOf(FormatDateTime('dd/mm/yyyy', dtaAtu)) = -1 Then
        Begin
          If DayOfTheWeek(dtaAtu) = 6 Then
            Result := Result + fltSabUti
          Else
            Result := Result + 1;
        End;
      End
      Else If DayOfTheWeek(dtaAtu) = 7 Then // Verifica se considera o domingo (0, 0.5, 0.75, 1)
      Begin
        If stlFeriados.IndexOf(FormatDateTime('dd/mm/yyyy', dtaAtu)) = -1 Then
          Result := Result + fltDomUti;
      End;

      dtaAtu := IncDay(dtaAtu, 1);
    End;
  finally
    FreeAndNil(stlFeriados);
  end;
End;

procedure TfrmCadMetaCompDepVend.pCarregaDadosAdicionais;
begin
  edtNomDep.Text := fRetDescDepartamento(edtCodDep.Text);
  edtNomEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);
end;

procedure TfrmCadMetaCompDepVend.pCarregarFeriados(stlFeriados: TStringList);
  Var
    qryFeriados: TUniQuery;
Begin
  stlFeriados.Clear;

  qryFeriados := fCriaQuery;
  Try
    qryFeriados.SQL.Add('SELECT FER_DTAFER AS DTAFER');
    qryFeriados.SQL.Add('  FROM CADFER');
    qryFeriados.SQL.Add('UNION ALL');
    qryFeriados.SQL.Add('SELECT FCI_DTAFER AS DTAFER');
    qryFeriados.SQL.Add('  FROM FERCID');
    qryFeriados.SQL.Add(' WHERE FCI_CODCID = (SELECT EMP_CODCID');
    qryFeriados.SQL.Add('                       FROM CADEMP');
    qryFeriados.SQL.Add('                      WHERE EMP_CODEMP = :CODEMP)');

    qryFeriados.ParamByName('CODEMP').AsString := qryTabela.FieldByName('MDV_CODEMP').AsString;
    qryFeriados.Open;

    While not qryFeriados.Eof Do
    Begin
      stlFeriados.Add(FormatDateTime('dd/mm/yyyy', qryFeriados.FieldByName('DTAFER').AsDateTime));
      qryFeriados.Next;
    End;
  Finally
    FreeAndNil(qryFeriados);
  End;
end;

end.
