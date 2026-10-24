unit untRecorrenciaOcorrencia;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, EditFocus,
  cxContainer, ComboBoxFocus, Vcl.Mask, MaskEditFocus, cxCheckBox,
  Datasnap.DBClient, untTRecorrenciaOcorrencia, Uni, untTypesSistema, untPai,
  UniClientDataSet;

type
  TfrmRecorrenciaOcorrencia = class(TfrmPai)
    pnlFiltros: TPanel;
    pnlPrincipal: TPanel;
    cxGridCitelRecorrenciaView: TcxGridDBTableViewCitel;
    cxGridCitelRecorrenciaLevel1: TcxGridLevel;
    cxGridCitelRecorrencia: TcxGridCitel;
    lblCliente: TLabel;
    edtCodCli: TEditFocus;
    edtDesCli: TEditFocus;
    lblGrupoOcorrencia: TLabel;
    edtCodGoc: TEditFocus;
    edtDesGoc: TEditFocus;
    lblComplemento: TLabel;
    edtCodCoc: TEditFocus;
    edtDesCoc: TEditFocus;
    lblUsuario: TLabel;
    edtCodOpe: TEditFocus;
    edtDesOpe: TEditFocus;
    lblRecorrencia: TLabel;
    cxCheckDiario: TcxCheckBox;
    cxCheckSemanal: TcxCheckBox;
    cxCheckMensal: TcxCheckBox;
    cxCheckAnual: TcxCheckBox;
    lblIntervaloRecorrencia: TLabel;
    mskDtaIni: TMaskEditFocus;
    cxCheckTerminaEm: TcxCheckBox;
    edtNroOcoTer: TEditFocus;
    lblOcorrencias: TLabel;
    cxCheckSemDataTermino: TcxCheckBox;
    lblTipo: TLabel;
    edtCodToc: TEditFocus;
    edtDesToc: TEditFocus;
    lblSituacao: TLabel;
    mskDtaIncIni: TMaskEditFocus;
    mskDtaIncFim: TMaskEditFocus;
    mskDtaAgeIni: TMaskEditFocus;
    mskDtaAgeFim: TMaskEditFocus;
    lblPeriodoInclusao: TLabel;
    lblPeriodoAgendamento: TLabel;
    lblAte1: TLabel;
    lblAte2: TLabel;
    cxCheckTerminaApos: TcxCheckBox;
    cdsRecorrencia: TUniClientDataSet;
    dtsRecorrencia: TDataSource;
    cdsRecorrenciaCLIENTE: TStringField;
    cxGridCitelRecorrenciaViewCLIENTE: TcxGridDBColumn;
    btnConfirmaConsulta: TBitBtnLocked;
    cdsRecorrenciaDTAINC: TDateTimeField;
    cdsRecorrenciaDTAAGE: TDateTimeField;
    cdsRecorrenciaGRPOCO: TStringField;
    cdsRecorrenciaTIPOCO: TStringField;
    cdsRecorrenciaCMPOCO: TStringField;
    cdsRecorrenciaSITOCO: TStringField;
    cdsRecorrenciaNOMOPE: TStringField;
    cxGridCitelRecorrenciaViewDTAINC: TcxGridDBColumn;
    cxGridCitelRecorrenciaViewDTAAGE: TcxGridDBColumn;
    cxGridCitelRecorrenciaViewGRPOCO: TcxGridDBColumn;
    cxGridCitelRecorrenciaViewTIPOCO: TcxGridDBColumn;
    cxGridCitelRecorrenciaViewCMPOCO: TcxGridDBColumn;
    cxGridCitelRecorrenciaViewSITOCO: TcxGridDBColumn;
    cxGridCitelRecorrenciaViewNOMOPE: TcxGridDBColumn;
    edtCodSit: TEditFocus;
    edtDesSitOco: TEditFocus;
    btnAlterar: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    cdsRecorrenciaRecorrencia: TStringField;
    cdsRecorrenciaITVOCO: TStringField;
    cxGridCitelRecorrenciaViewRECOCO: TcxGridDBColumn;
    cxGridCitelRecorrenciaViewITVOCO: TcxGridDBColumn;
    cdsRecorrenciaMARDES: TStringField;
    cxGridCitelRecorrenciaViewMARDES: TcxGridDBColumn;
    cdsRecorrenciaAUTINC: TStringField;
    lblLegenda: TLabel;
    cdsRecorrenciaTIPREC: TStringField;
    cdsRecorrenciaTIPITV: TStringField;
    cdsRecorrenciaDTAINI: TDateTimeField;
    cxGridCitelRecorrenciaViewDTAINI: TcxGridDBColumn;
    cxCheckRecFinalizadas: TcxCheckBox;
    cdsRecorrenciaSTATUS: TStringField;
    cxGridCitelRecorrenciaViewDESC_STATUS: TcxGridDBColumn;
    cxGridCitelRecorrenciaViewSTATUS: TcxGridDBColumn;
    cdsRecorrenciaDESC_STATUS: TStringField;
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodGocKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodTocKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCocKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodOpeKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaConsultaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodSitKeyPress(Sender: TObject; var Key: Char);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridCitelRecorrenciaViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtCodTocExit(Sender: TObject);
    procedure edtCodSitExit(Sender: TObject);
    procedure edtCodOpeExit(Sender: TObject);
    procedure edtCodCocExit(Sender: TObject);
    procedure edtCodGocExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pSetarParametro(qryParam: TUniQuery; edtCampo: TEditFocus; strNomeParam: String; TipoCampo: TFieldType = ftString); overload;
    procedure pSetarParametro(qryParam: TUniQuery; edtCampo: TMaskEditFocus; strNomeParam: String; TipoCampo: TFieldType = ftDateTime); overload;
  private
    { Private declarations }
    FCarregandoDados: Boolean;
    FQtdItensSel: Integer;

    arrCodCli: TConsultasArray;
    arrCodGoc: TConsultasArray;
    arrCodCoc: TConsultasArray;
    arrCodOpe: TConsultasArray;
    arrCodToc: TConsultasArray;
    arrCodSit: TConsultasArray;

    strCodCli: String;
    strCodGoc: String;
    strCodCoc: String;
    strCodOpe: String;
    strCodToc: String;
    strCodSit: String;

    procedure pCarregaCliente;
    procedure pCarregaGrupoOcorrencia;
    procedure pCarregaComplementoOcorrencia;
    procedure pCarregaTipoOcorrencia;
    procedure pCarregaUsuario;
    procedure pCarregaSituacao;
    procedure pCarregarDados(const blnRecarrecarConsulta: Boolean = False);
    procedure pConsultaRecorrencias;
    procedure pMarcarDesmarcar(const blnMarcar: Boolean; blnMarcarTodos: Boolean = False);
    procedure pMarcarDesmarcarTodos(const blnMarcar: Boolean);
    procedure pExcluirRecorrencias;
    procedure pExcluirRecorrencia(const strAutInc: String);
    procedure pAlterarGrupoRecorrencias;
    procedure pAlterarRecorrencia;

    function fRetornaSQLConsulta: String;
    function fValidarPodeAlterarRecorrenciasSelecionadas: Boolean;
    function fVerificaItemSelecionado: Boolean;
    function fAbrirTelaCadastroRecorrencia(ObjRecorrencia: TRecorrenciaOcorrencia): Boolean;
  public
    { Public declarations }
    FTip_Fc: String;
  end;

implementation

uses
  untFuncoesSimples, untConsultas, untPesqAux, StrUtils,
  untGravando, untFuncoesConsulta, untCadRecorrenciaOcorrencia, untFuncoesOcorrenciasCRM;

{$R *.dfm}

procedure TfrmRecorrenciaOcorrencia.btnAlterarClick(Sender: TObject);
begin
  inherited;

  If Not fVerificaItemSelecionado  Then
  Begin
    fMensagem('ATENÇÃO!', 'Nenhum item selecionado.', ['&Ok']);
    Exit;
  End;

  If Not fValidarPodeAlterarRecorrenciasSelecionadas Then
  Begin
    Exit;
  End;

  If FQtdItensSel > 1 Then
    pAlterarGrupoRecorrencias
  Else
    pAlterarRecorrencia;
end;

procedure TfrmRecorrenciaOcorrencia.btnConfirmaConsultaClick(Sender: TObject);
begin
  inherited;

  pCarregarDados;
end;

procedure TfrmRecorrenciaOcorrencia.btnDesmarcarTodosClick(Sender: TObject);
begin
  inherited;

  pMarcarDesmarcarTodos(False);
end;

procedure TfrmRecorrenciaOcorrencia.btnExcluirClick(Sender: TObject);
begin
  inherited;

  If Not fVerificaItemSelecionado  Then
  Begin
    fMensagem('ATENÇÃO!', 'Nenhum item selecionado.', ['&Ok']);
    Exit;
  End;

  pExcluirRecorrencias;
end;

procedure TfrmRecorrenciaOcorrencia.btnMarcarTodosClick(Sender: TObject);
begin
  inherited;

  pMarcarDesmarcarTodos(True);
end;

procedure TfrmRecorrenciaOcorrencia.cxGridCitelRecorrenciaViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If AViewInfo.GridRecord.Values[cxGridCitelRecorrenciaViewMARDES.Index] = 'S' Then
  Begin
    ACanvas.Font.Color := clBlue;
    Exit;
  End;

  If AViewInfo.GridRecord.Values[cxGridCitelRecorrenciaViewSTATUS.Index] = 'A' Then
    ACanvas.Font.Color := clInfoText;

  If AViewInfo.GridRecord.Values[cxGridCitelRecorrenciaViewSTATUS.Index] = 'F' Then
    ACanvas.Font.Color := clGreen;

  If AViewInfo.GridRecord.Values[cxGridCitelRecorrenciaViewSTATUS.Index] = 'T' Then
    ACanvas.Font.Color := clPurple;

end;

procedure TfrmRecorrenciaOcorrencia.edtCodCliExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodCli, edtDesCli, arrCodCli, Nil, fRetNomCliente, 'do Cliente');
end;

procedure TfrmRecorrenciaOcorrencia.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtDesCli, Nil, Key, arrCodCli, False) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmRecorrenciaOcorrencia.fAbrirTelaCadastroRecorrencia(ObjRecorrencia: TRecorrenciaOcorrencia): Boolean;
var
  frmCadRecorrenciaOcorrencia: TfrmCadRecorrenciaOcorrencia;
begin
  pCriarFormularios(TfrmCadRecorrenciaOcorrencia, frmCadRecorrenciaOcorrencia);
  Try
    frmCadRecorrenciaOcorrencia.ObjRecorrencia := ObjRecorrencia;
    frmCadRecorrenciaOcorrencia.ShowModal;
    Result := (frmCadRecorrenciaOcorrencia.ModalResult = mrOk);
  Finally
    pFreeAndNil(frmCadRecorrenciaOcorrencia);
  End;
end;

procedure TfrmRecorrenciaOcorrencia.pAlterarRecorrencia;
var
  ObjManutencaoRecorrencia: TManutencaoRecorrencia;
  ObjRecorrencia: TRecorrenciaOcorrencia;
  intRecNo: Integer;
begin
  ObjRecorrencia := TRecorrenciaOcorrencia.Create(Nil);
  ObjManutencaoRecorrencia := TManutencaoRecorrencia.Create;

  intRecNo := cdsRecorrencia.RecNo;
  cdsRecorrencia.DisableControls;
  Try
    cdsRecorrencia.First;
    While Not cdsRecorrencia.Eof Do
    Begin
      If cdsRecorrencia.FieldByName('MARDES').AsString = 'S' Then
      Begin
        ObjRecorrencia.pCarregarRecorrencia(cdsRecorrencia.FieldByName('AUTINC').AsString);
        If fAbrirTelaCadastroRecorrencia(ObjRecorrencia) Then
        Begin
          ObjManutencaoRecorrencia.pAtualizarRecorrencia(ObjRecorrencia);
        End;
        pCarregarDados(True);
      End;

      cdsRecorrencia.Next;
    End;
  Finally
    cdsRecorrencia.EnableControls;
    cdsRecorrencia.RecNo := intRecNo;
    FreeAndNil(ObjRecorrencia);
    FreeAndNil(ObjManutencaoRecorrencia);
  End;
End;

procedure TfrmRecorrenciaOcorrencia.pAlterarGrupoRecorrencias;
var
  ObjManutencaoRecorrencia: TManutencaoRecorrencia;
  ObjRecorrenciaPadrao,
  ObjRecorrencia: TRecorrenciaOcorrencia;
  intRecNo: Integer;
begin
  ObjRecorrencia := TRecorrenciaOcorrencia.Create(Nil);
  ObjRecorrenciaPadrao := TRecorrenciaOcorrencia.Create(Nil);
  ObjManutencaoRecorrencia :=  TManutencaoRecorrencia.Create;

  intRecNo := cdsRecorrencia.RecNo;
  cdsRecorrencia.DisableControls;
  Try
    ObjRecorrenciaPadrao.pCarregarRecorrencia(cdsRecorrencia.FieldByName('AUTINC').AsString);
    If fAbrirTelaCadastroRecorrencia(ObjRecorrenciaPadrao) Then
    Begin
      cdsRecorrencia.First;
      While Not cdsRecorrencia.Eof Do
      Begin
        If cdsRecorrencia.FieldByName('MARDES').AsString = 'S' Then
        Begin
          ObjRecorrencia.pCarregarRecorrencia(cdsRecorrencia.FieldByName('AUTINC').AsString);
          ObjManutencaoRecorrencia.pAtualizarRecorrencia(ObjRecorrencia, ObjRecorrenciaPadrao);
        End;

        cdsRecorrencia.Next;
      End;
      pCarregarDados(True);
    End;
  Finally
    cdsRecorrencia.EnableControls;
    cdsRecorrencia.RecNo := intRecNo;
    FreeAndNil(ObjRecorrencia);
    FreeAndNil(ObjRecorrenciaPadrao);
    FreeAndNil(ObjManutencaoRecorrencia);
  End;
End;

procedure TfrmRecorrenciaOcorrencia.pCarregaCliente;
begin
  If fEmptyStr(edtCodCli.Text) Then
  Begin
    edtDesCli.Text := 'TODOS';
    Exit;
  End;

  If (Length(arrCodCli) > 1) Then
  Begin
    edtDesCli.Text := '+1';
    Exit;
  End;

  edtDesCli.Text := fRetNomCliente(edtCodCli.Text)
end;

procedure TfrmRecorrenciaOcorrencia.pCarregaComplementoOcorrencia;
begin
  If fEmptyStr(edtCodCoc.Text) Then
  Begin
    edtDesCoc.Text := 'TODOS';
    Exit;
  End;

  If Length(arrCodCoc) > 1 Then
  Begin
    edtDesCoc.Text := '+1';
    Exit;
  End;

  edtDesCoc.Text := fRetDescCompOcorrencia(edtCodCoc.Text);
end;

procedure TfrmRecorrenciaOcorrencia.pCarregaGrupoOcorrencia;
begin
  If fEmptyStr(edtCodGoc.Text) Then
  Begin
    edtDesGoc.Text := 'TODOS';
    Exit;
  End;

  If Length(arrCodGoc) > 1 Then
  Begin
    edtDesGoc.Text := '+1';
    Exit;
  End;

  edtDesGoc.Text := fRetDescGoc(edtCodGoc.Text);
end;

procedure TfrmRecorrenciaOcorrencia.pCarregarDados(const blnRecarrecarConsulta: Boolean = False);
begin

  If fEmptyStr(edtCodCli.Text) And
     fEmptyStr(edtCodOpe.Text) And
     fEmptyStr(edtCodGoc.Text) And
     fEmptyStr(edtCodToc.Text) And
     fEmptyStr(edtCodCoc.Text) And
     fEmptyDate(mskDtaIncIni.Text) And
     fEmptyDate(mskDtaIncFim.Text) And
     fEmptyDate(mskDtaAgeIni.Text) And
     fEmptyDate(mskDtaAgeFim.Text) And
     fEmptyStr(edtCodSit.Text) And
     (Not blnRecarrecarConsulta) And
     (Not cxCheckRecFinalizadas.Checked) Then
  Begin
    If fMensagem('ATENÇÃO!', 'Nenhum filtro foi aplicado para realizar a consulta, desta forma o processo pode demorar. Deseja prosseguir? ', ['&Sim', '&Não']) = 2 Then
      Exit;
  End;

  FCarregandoDados := True;
  TfrmGravando.fExecutarModal(pConsultaRecorrencias, 'Aguarde carregando recorrências....', 'ConsultaRecorrencias');

end;

procedure TfrmRecorrenciaOcorrencia.pCarregaSituacao;
begin
  If fEmptyStr(edtCodSit.Text) Then
  Begin
    edtDesSitOco.Text := 'TODOS';
    Exit;
  End;

  If Length(arrCodSit) > 1 Then
  Begin
    edtDesSitOco.Text := '+1';
    Exit;
  End;

  edtDesSitOco.Text := fRetDesSitOco(edtCodSit.Text);
end;

procedure TfrmRecorrenciaOcorrencia.pCarregaTipoOcorrencia;
begin
  If fEmptyStr(edtCodToc.Text) Then
  Begin
    edtDesToc.Text := 'TODOS';
    Exit;
  End;

  If Length(arrCodToc) > 1 Then
  Begin
    edtDesToc.Text := '+1';
    Exit;
  End;

  edtDesToc.Text := fRetNomTipoOcorrencia(edtCodToc.Text);
end;

procedure TfrmRecorrenciaOcorrencia.pCarregaUsuario;
begin
  If fEmptyStr(edtCodOpe.Text) Then
  Begin
    edtDesOpe.Text := 'TODOS';
    Exit;
  End;

  If Length(arrCodOpe) > 1 Then
  Begin
    edtDesOpe.Text := '+1';
    Exit;
  End;

  edtDesOpe.Text := fRetNomeOperador(edtCodOpe.Text);
end;

function TfrmRecorrenciaOcorrencia.fRetornaSQLConsulta: String;
var
  strTipRec: String;
  strTipTer: String;
begin
  Result := 'SELECT R.* ,           ' +
            '       M.OCO_CODCLI,   ' +
            '       CLI.CLI_NOMCLI, ' +
            '       T.TOC_CODGOC,   ' +
            '       G.GOC_DESGOC,   ' +
            '       M.OCO_CODTOC,   ' +
            '       T.TOC_DESTOC,   ' +
            '       M.OCO_CODCOC,   ' +
            '       C.COC_DESCOC,   ' +
            '       M.OCO_CODSIT,   ' +
            '       S.SIT_DESSIT,   ' +
            '       M.OCO_CODOPE,   ' +
            '       O.OPE_NOMOPE,   ' +
            '       (CASE WHEN REC_TIPREC = "D" THEN "Diária"  ' +
            '             WHEN REC_TIPREC = "S" THEN "Semanal" ' +
            '             WHEN REC_TIPREC = "M" THEN "Mensal"  ' +
            '             WHEN REC_TIPREC = "A" THEN "Anual"   ' +
            '        END) AS DESC_RECORRENCIA,                 ' +
            '       (CASE WHEN REC_TIPITV = "A" THEN "Termina após "   ' +
            '             WHEN REC_TIPITV = "D" THEN "Termina em"      ' +
            '             WHEN REC_TIPITV = "S" THEN "Sem data de término"  ' +
            '       END) AS DESC_INTERVALO,                       ' +
            '       M.OCO_DTAAGE,                                 ' +
            '       M.OCO_HORAGE,                                 ' +
            '       R.REC_STATUS,                                 ' +
            '       (CASE WHEN R.REC_STATUS = "A" THEN "Andamento"  ' +
            '             WHEN R.REC_STATUS = "F" THEN "Finalizada" ' +
            '             WHEN R.REC_STATUS = "T" THEN "Geradas no Cadastro"  ' +
            '        END) AS DESC_STATUS                       ' +
            'FROM OCOREC R                                        ' +
            'INNER JOIN MOVOCO M   ON REC_SEQOCO = M.AUTOINCREM   ' +
            'INNER JOIN CADCLI CLI ON M.OCO_CODCLI = CLI_CODCLI   ' +
            'INNER JOIN CADTOC T   ON M.OCO_CODTOC = T.TOC_CODTOC ' +
            'INNER JOIN CADGOC G   ON T.TOC_CODGOC = G.GOC_CODGOC ' +
            'LEFT  JOIN CADCOC C   ON M.OCO_CODCOC = C.COC_CODCOC ' +
            'LEFT  JOIN SITOCO S   ON M.OCO_CODSIT = S.SIT_CODSIT ' +
            'INNER JOIN CADOPE O   ON M.OCO_CODOPE = O.OPE_CODOPE ' +
            'WHERE TRUE ';

  If Not cxCheckRecFinalizadas.Checked Then
    Result := Result + '  AND OCO_OCOREC = "S"   ';

  Result := Result + fStrLocate(edtCodCli, arrCodCli, 'OCO_CODCLI', 'CODCLI');
  Result := Result + fStrLocate(edtCodGoc, arrCodGoc, 'TOC_CODGOC', 'CODGOC');
  Result := Result + fStrLocate(edtCodOpe, arrCodOpe, 'OCO_CODOPE', 'CODOPE');
  Result := Result + fStrLocate(edtCodToc, arrCodToc, 'OCO_CODTOC', 'CODTOC');
  Result := Result + fStrLocate(edtCodSit, arrCodSit, 'OCO_CODSIT', 'CODSIT');

  strTipRec := IIF(cxCheckDiario.Checked, QuotedStr(arrStrTipoRecorrencia[tpDiaria]), '');
  If cxCheckSemanal.Checked Then
  Begin
    strTipRec := strTipRec + IIF(Not fEmptyStr(strTipRec), ',', '');
    strTipRec := strTipRec + QuotedStr(arrStrTipoRecorrencia[tpSemanal]);
  End;
  If cxCheckMensal.Checked Then
  Begin
    strTipRec := strTipRec + IIF(Not fEmptyStr(strTipRec), ',', '');
    strTipRec := strTipRec + QuotedStr(arrStrTipoRecorrencia[tpMensal]);
  End;
  If cxCheckAnual.Checked Then
  Begin
    strTipRec := strTipRec + IIF(Not fEmptyStr(strTipRec), ',', '');
    strTipRec := strTipRec + QuotedStr(arrStrTipoRecorrencia[tpAnual]);
  End;
  Result := Result + IIF(Not fEmptyStr(strTipRec), ' AND REC_TIPREC IN (' + strTipRec + ')', '');

  Result := Result + IIF(fEmptyDate(mskDtaIncIni.Text), '', '  AND REC_DTAREC >= :DTAINC_INI ');
  Result := Result + IIF(fEmptyDate(mskDtaIncFim.Text), '', '  AND REC_DTAREC <= :DTAINC_FIM ');
  Result := Result + IIF(fEmptyDate(mskDtaAgeIni.Text), '', '  AND M.OCO_DTAAGE >= :DTAAGE_INI ');
  Result := Result + IIF(fEmptyDate(mskDtaAgeFim.Text), '', '  AND M.OCO_DTAAGE <= :DTAAGE_FIM ');

  strTipTer := IIF(cxCheckTerminaEm.Checked, QuotedStr(arrStrTipoIntervaloRecorrencia[tpData]), '' );
  If cxCheckTerminaApos.Checked Then
  Begin
    strTipTer := strTipTer + IIF(Not fEmptyStr(strTipTer), ',', '');
    strTipTer := strTipTer + QuotedStr(arrStrTipoIntervaloRecorrencia[tpApos]);
  End;
  If cxCheckSemDataTermino.Checked Then
  Begin
    strTipTer := strTipTer + IIF(Not fEmptyStr(strTipTer), ',', '');
    strTipTer := strTipTer + QuotedStr(arrStrTipoIntervaloRecorrencia[tpSemData]);
  End;
  Result := Result + IIF(Not fEmptyStr(strTipTer), ' AND REC_TIPITV IN (' + strTipTer + ')', '');

  Result := Result + ' ORDER BY R.AUTOINCREM';
end;

procedure TfrmRecorrenciaOcorrencia.pSetarParametro(qryParam: TUniQuery; edtCampo: TEditFocus; strNomeParam: String; TipoCampo: TFieldType = ftString);
begin
  Case TipoCampo Of
    ftString : Begin
                 If (qryParam.Params.FindParam(strNomeParam) <> Nil) Then
                   qryParam.ParamByName(strNomeParam).AsString := edtCampo.Text;
               End;
  End;
end;

procedure TfrmRecorrenciaOcorrencia.pSetarParametro(qryParam: TUniQuery;
  edtCampo: TMaskEditFocus; strNomeParam: String; TipoCampo: TFieldType = ftDateTime);
begin
  Case TipoCampo Of
    ftString : Begin
                 If (qryParam.Params.FindParam(strNomeParam) <> Nil) Then
                   qryParam.ParamByName(strNomeParam).AsString := edtCampo.Text;
               End;
    ftDateTime : Begin
                   If (qryParam.Params.FindParam(strNomeParam) <> Nil) Then
                     qryParam.ParamByName(strNomeParam).AsDateTime := StrToDateTime(edtCampo.Text);
                 End;
  End;
end;

procedure TfrmRecorrenciaOcorrencia.pConsultaRecorrencias;
var
  qryConsulta: TUniQuery;
  strAux: String;
begin
  If cdsRecorrencia.Active Then
    cdsRecorrencia.EmptyDataSet;

  qryConsulta := fCriaQuery;
  Try
    Try
      qryConsulta.DisableControls;
      strAux := fRetornaSQLConsulta;
      qryConsulta.SQL.Add(strAux);

      pSetaParam(edtCodCli.Text, arrCodCli, strCodCli, 'CODCLI', qryConsulta);
      pSetaParam(edtCodGoc.Text, arrCodGoc, strCodGoc, 'CODGOC', qryConsulta);
      pSetaParam(edtCodCoc.Text, arrCodCoc, strCodCoc, 'CODCOC', qryConsulta);
      pSetaParam(edtCodOpe.Text, arrCodOpe, strCodOpe, 'CODOPE', qryConsulta);
      pSetaParam(edtCodToc.Text, arrCodToc, strCodToc, 'CODTOC', qryConsulta);
      pSetaParam(edtCodSit.Text, arrCodSit, strCodSit, 'CODSIT', qryConsulta);

      pSetarParametro(qryConsulta, mskDtaIncIni, 'DTAINC_INI', ftDateTime);
      pSetarParametro(qryConsulta, mskDtaIncFim, 'DTAINC_FIM', ftDateTime);
      pSetarParametro(qryConsulta, mskDtaAgeIni, 'DTAAGE_INI', ftDateTime);
      pSetarParametro(qryConsulta, mskDtaAgeFim, 'DTAAGE_FIM', ftDateTime);

      qryConsulta.Open;
      While Not qryConsulta.EOF Do
      Begin
        cdsRecorrencia.Insert;
        cdsRecorrencia.FieldByName('MARDES').AsString := 'N';
        cdsRecorrencia.FieldByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
        cdsRecorrencia.FieldByName('CLIENTE').AsString := qryConsulta.FieldByName('OCO_CODCLI').AsString + ' - ' + qryConsulta.FieldByName('CLI_NOMCLI').AsString;
        cdsRecorrencia.FieldByName('GRPOCO').AsString := qryConsulta.FieldByName('TOC_CODGOC').AsString + ' - ' + qryConsulta.FieldByName('GOC_DESGOC').AsString;
        cdsRecorrencia.FieldByName('TIPOCO').AsString := qryConsulta.FieldByName('OCO_CODTOC').AsString + ' - ' + qryConsulta.FieldByName('TOC_DESTOC').AsString;
        If Not fEmptyStr(qryConsulta.FieldByName('OCO_CODCOC').AsString) Then
          cdsRecorrencia.FieldByName('CMPOCO').AsString := qryConsulta.FieldByName('OCO_CODCOC').AsString + ' - ' + qryConsulta.FieldByName('COC_DESCOC').AsString;
        If Not fEmptyStr(qryConsulta.FieldByName('OCO_CODSIT').AsString) Then
          cdsRecorrencia.FieldByName('SITOCO').AsString := qryConsulta.FieldByName('OCO_CODSIT').AsString + ' - ' + qryConsulta.FieldByName('SIT_DESSIT').AsString;
        cdsRecorrencia.FieldByName('NOMOPE').AsString := qryConsulta.FieldByName('OCO_CODOPE').AsString + ' - ' + qryConsulta.FieldByName('OPE_NOMOPE').AsString;
        cdsRecorrencia.FieldByName('DTAINC').AsDateTime := qryConsulta.FieldByName('REC_DTAREC').AsDateTime + qryConsulta.FieldByName('REC_HRAREC').AsDateTime;
        cdsRecorrencia.FieldByName('RECOCO').AsString := qryConsulta.FieldByName('DESC_RECORRENCIA').AsString;
        If qryConsulta.FieldByName('REC_QTDTER').AsInteger > 0 Then
          cdsRecorrencia.FieldByName('ITVOCO').AsString := qryConsulta.FieldByName('DESC_INTERVALO').AsString +  ' ' + qryConsulta.FieldByName('REC_QTDTER').AsString + ' ocorrências'
        Else If qryConsulta.FieldByName('REC_DTATER').AsDateTime > 0 Then
          cdsRecorrencia.FieldByName('ITVOCO').AsString := qryConsulta.FieldByName('DESC_INTERVALO').AsString +  ' ' + qryConsulta.FieldByName('REC_DTATER').AsString
        Else
          cdsRecorrencia.FieldByName('ITVOCO').AsString := qryConsulta.FieldByName('DESC_INTERVALO').AsString;

        cdsRecorrencia.FieldByName('TIPREC').AsString := qryConsulta.FieldByName('REC_TIPREC').AsString;
        cdsRecorrencia.FieldByName('TIPITV').AsString := qryConsulta.FieldByName('REC_TIPITV').AsString;
        cdsRecorrencia.FieldByName('DTAINI').AsDateTime := qryConsulta.FieldByName('REC_DTAINI').AsDateTime + qryConsulta.FieldByName('REC_HRAINI').AsDateTime;
        cdsRecorrencia.FieldByName('DTAAGE').AsDateTime := qryConsulta.FieldByName('OCO_DTAAGE').AsDateTime + qryConsulta.FieldByName('OCO_HORAGE').AsDateTime;
        cdsRecorrencia.FieldByName('DESC_STATUS').AsString := qryConsulta.FieldByName('DESC_STATUS').AsString;
        cdsRecorrencia.FieldByName('STATUS').AsString := qryConsulta.FieldByName('REC_STATUS').AsString;


        cdsRecorrencia.Post;
        qryConsulta.Next;
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;

  Finally
    FreeAndNil(qryConsulta);
  End;
end;

procedure TfrmRecorrenciaOcorrencia.pExcluirRecorrencia(
  const strAutInc: String);
var
  objRecorrencia: TRecorrenciaOcorrencia;
begin
  objRecorrencia := TRecorrenciaOcorrencia.Create(Nil);
  Try
    objRecorrencia.pExcluir(strAutInc);
  Finally
    FreeAndNil(objRecorrencia);
  End;
end;

procedure TfrmRecorrenciaOcorrencia.pExcluirRecorrencias;
begin
  If fMensagem('Atenção!', 'As recorrências selecionadas serão excluídas. Esta operação é irreversível. ' +
                           'Deseja Continuar?', ['&Sim', '&Não'], 2) = 2 Then
  Begin
    Exit;
  End;

  fStartTransaction;

  cdsRecorrencia.DisableControls;
  Try
    Try
      cdsRecorrencia.First;
      While Not cdsRecorrencia.Eof Do
      Begin
        If cdsRecorrencia.FieldByName('MARDES').AsString = 'S' Then
          pExcluirRecorrencia(cdsRecorrencia.FieldByName('AUTINC').AsString);

        cdsRecorrencia.Next;
      End;

      fCommit;

      pCarregarDados(True);
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TfrmRecorrenciaOcorrencia.pExcluirRecorrencias]');
      End;
    End;
  Finally
    cdsRecorrencia.EnableControls;
  End;
end;

procedure TfrmRecorrenciaOcorrencia.pMarcarDesmarcar(const blnMarcar: Boolean; blnMarcarTodos: Boolean = False);
begin
  If blnMarcar And  (Pos(cdsRecorrencia.FieldByName('STATUS').AsString, 'T_F_') > 0) Then
  Begin
    If Not blnMarcarTodos Then
      fMensagem('ATENÇÃO!', 'Não é possível alterar uma recorrência finalizada.', ['&Ok']);

    Exit;
  End;

  cdsRecorrencia.Edit;
  cdsRecorrencia.FieldByName('MARDES').AsString :=  IIF(blnMarcar, 'S', 'N');
  cdsRecorrencia.Post;
end;

procedure TfrmRecorrenciaOcorrencia.pMarcarDesmarcarTodos(
  const blnMarcar: Boolean);
begin
  cdsRecorrencia.DisableControls;
  Try
    cdsRecorrencia.First;
    While Not cdsRecorrencia.Eof Do
    Begin
      pMarcarDesmarcar(blnMarcar, True);
      cdsRecorrencia.Next;
    End;
  Finally
    cdsRecorrencia.EnableControls;
  End;
end;

procedure TfrmRecorrenciaOcorrencia.edtCodCocExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodCoc, edtDesCoc, arrCodCoc, Nil, fRetDescCompOcorrencia, 'de Complemento de Ocorrência');
end;

procedure TfrmRecorrenciaOcorrencia.edtCodCocKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqComplementosOcorrencias(Self, edtCodCoc, edtDesCoc, nil, Key, arrCodCoc, False, edtCodToc.Text) Then
  Begin
    If fValidaCampos(edtCodCoc, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRecorrenciaOcorrencia.edtCodGocExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodGoc, edtDesGoc, arrCodGoc, Nil, fRetDescGoc, 'do Grupo de Ocorrência');
end;

procedure TfrmRecorrenciaOcorrencia.edtCodGocKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqGruposOcorrencias(Self, edtCodGoc, edtDesGoc, nil, Key, arrCodGoc, False) Then
  Begin
    If fValidaCampos(edtCodGoc, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRecorrenciaOcorrencia.edtCodOpeExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodOpe, edtDesOpe, arrCodOpe, fRetNomeOperador, Nil, 'do Usuário');
end;

procedure TfrmRecorrenciaOcorrencia.edtCodOpeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqOperador(Self, edtCodOpe, edtDesOpe, nil, Key, arrCodOpe, False) then
  Begin
    If fValidaCampos(edtCodOpe, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRecorrenciaOcorrencia.edtCodSitExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodSit, edtDesSitOco, arrCodSit, fRetDesSitOco, Nil, 'de Situação de Ocorrência');
end;

procedure TfrmRecorrenciaOcorrencia.edtCodSitKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqSitOcorrencias(Self, edtCodSit, edtDesSitOco, Nil, Key, arrCodSit, False, True, edtCodToc.Text ) Then
  Begin
    If fValidaCampos(edtCodSit, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRecorrenciaOcorrencia.edtCodTocExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodToc, edtDesToc, arrCodToc, Nil, fRetNomTipoOcorrencia, 'de Tipo de Ocorrência');
end;

procedure TfrmRecorrenciaOcorrencia.edtCodTocKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqTiposOcorrencias(Self, edtCodToc, edtDesToc, nil, Key, arrCodToc, False, edtCodGoc.Text, False) Then
  Begin
    If fValidaCampos(edtCodToc, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRecorrenciaOcorrencia.FormCreate(Sender: TObject);
begin
  inherited;

  cdsRecorrencia.CreateDataSet;
end;

function TfrmRecorrenciaOcorrencia.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin

    If (Sender = edtCodCli) Then
    Begin
      pCarregaCliente;
      If fEmptyStr(edtDesCli.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse Código de Cliente não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtCodGoc) Then
    Begin
      pCarregaGrupoOcorrencia;
      If fEmptyStr(edtDesGoc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse Código de Grupo de Ocorrência não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtCodCoc) Then
    Begin
      pCarregaComplementoOcorrencia;
      If fEmptyStr(edtDesCoc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse Código de Complemento de Ocorrência não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtCodToc) Then
    Begin
      pCarregaTipoOcorrencia;
      If fEmptyStr(edtDesToc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse Código de Tipo de Ocorrência não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtCodOpe) Then
    Begin
      pCarregaUsuario;
      If fEmptyStr(edtDesOpe.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse Código de Operador não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtCodSit) Then
    Begin
      pCarregaSituacao;
      If fEmptyStr(edtDesSitOco.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse Código de Situação não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = mskDtaIncIni) Then
    Begin
      If (Not fEmptyDate(mskDtaIncIni.Text)) And
         (Not fEmptyDate(mskDtaIncFim.Text)) And
         (StrToDate(mskDtaIncIni.Text) > StrToDate(mskDtaIncFim.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial não pode ser maior que a data final!', ['&Ok']);
        Result := False;
      End;
    End
    Else
    If (Sender = mskDtaIncFim) Then
    Begin
      If (Not fEmptyDate(mskDtaIncIni.Text)) And
         (Not fEmptyDate(mskDtaIncFim.Text)) And
         (StrToDate(mskDtaIncIni.Text) > StrToDate(mskDtaIncFim.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial não pode ser maior que a data final!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = mskDtaAgeIni) Then
    Begin
      If (Not fEmptyDate(mskDtaAgeIni.Text)) And
         (Not fEmptyDate(mskDtaAgeFim.Text)) And
         (StrToDate(mskDtaAgeIni.Text) > StrToDate(mskDtaAgeFim.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial não pode ser maior que a data final!', ['&Ok']);
        Result := False;
      End;
    End
    Else
    If (Sender = mskDtaAgeFim) Then
    Begin

      If (Not fEmptyDate(mskDtaAgeIni.Text)) And
         (Not fEmptyDate(mskDtaAgeFim.Text)) And
         (StrToDate(mskDtaAgeIni.Text) > StrToDate(mskDtaAgeFim.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial não pode ser maior que a data final!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

function TfrmRecorrenciaOcorrencia.fValidarPodeAlterarRecorrenciasSelecionadas: Boolean;
var
  strTipoRecorrencia,
  strTipoRecorrenciaAnt,
  strTipoIntervalo,
  strTipoIntervaloAnt: String;
  intRecNo: Integer;
begin
  Result := True;

  intRecNo := cdsRecorrencia.RecNo;
  cdsRecorrencia.DisableControls;
  Try
    cdsRecorrencia.First;
    While Not cdsRecorrencia.Eof Do
    Begin
      If (cdsRecorrencia.FieldByName('MARDES').AsString = 'S') Then
      Begin
        strTipoRecorrencia := cdsRecorrencia.FieldByName('TIPREC').AsString;
        strTipoIntervalo := cdsRecorrencia.FieldByName('TIPITV').AsString;

        If (strTipoRecorrencia <> strTipoRecorrenciaAnt) And (Not fEmptyStr(strTipoRecorrenciaAnt)) Then
        Begin
          Result := False;
          Break;
        End;

        If (strTipoIntervalo <> strTipoIntervaloAnt) And (Not fEmptyStr(strTipoIntervaloAnt)) Then
        Begin
          Result := False;
          Break;
        End;

        strTipoRecorrenciaAnt := strTipoRecorrencia;
        strTipoIntervaloAnt := strTipoIntervalo;
      End;
      cdsRecorrencia.Next;
    End;

    If Not Result Then
      fMensagem('ATENÇÃO!', 'Só é permitido alterar simultaneamente recorrências que são do mesmo tipo (diária, semanal, mensal ou anual) e que tem o mesmo intervalo.', ['&Ok']);
  Finally
    cdsRecorrencia.EnableControls;
    cdsRecorrencia.RecNo := intRecNo;
  End;
end;

function TfrmRecorrenciaOcorrencia.fVerificaItemSelecionado: Boolean;
var
  intRecNo: Integer;
begin
  intRecNo := cdsRecorrencia.RecNo;
  cdsRecorrencia.Filter := 'MARDES=''S''';
  cdsRecorrencia.Filtered := True;
  FQtdItensSel := cdsRecorrencia.RecordCount;
  Result := (FQtdItensSel > 0);

  cdsRecorrencia.Filtered := False;
  cdsRecorrencia.RecNo := intRecNo;
end;

procedure TfrmRecorrenciaOcorrencia.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: pMarcarDesmarcar(cdsRecorrencia.FieldByName('MARDES').AsString = 'N');
    VK_F5 : btnAlterar.Click;
    VK_F6 : btnExcluir.Click;
    VK_F7 : btnMarcarTodos.Click;
    VK_F8 : btnDesmarcarTodos.Click;
  End;
end;

procedure TfrmRecorrenciaOcorrencia.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(edtCodCli);
end;

end.
