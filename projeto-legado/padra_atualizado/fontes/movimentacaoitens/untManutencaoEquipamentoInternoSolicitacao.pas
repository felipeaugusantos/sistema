unit untManutencaoEquipamentoInternoSolicitacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, Vcl.Mask,
  MaskEditFocus, EditFocus, MemoFocus, untTypesSistema, MemDS, DBAccess, Uni,
  Datasnap.DBClient, UniClientDataSet, untZClient, untManutencaoEquipamentoInterno,
  cxContainer, cxProgressBar, untEditorFastImpressao, TypesRel;

type
  TOperacao = (toInclusao, toEdicao, toFinalizacao, toLista);

  TfrmManutencaoEquipamentoInternoSolicitacao = class(TfrmPai)
    pgcDados: TPageControl;
    tbsLista: TTabSheet;
    tbsInclusao: TTabSheet;
    tbsFinalizacao: TTabSheet;
    cxgvLista: TcxGridDBTableViewCitel;
    cxgListaLevel1: TcxGridLevel;
    cxgLista: TcxGridCitel;
    btnIncluir: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnAlterar: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    btnFinalizar: TBitBtnLocked;
    cxgvListaCodSolicitacao: TcxGridDBColumn;
    cxgvListaDataSolicitacao: TcxGridDBColumn;
    cxgvListaOperador: TcxGridDBColumn;
    cxgvListaPrioridade: TcxGridDBColumn;
    cxgvListaStatus: TcxGridDBColumn;
    pnlFinalizacao: TPanel;
    edtResponsavelTecnicoCodigo: TEditFocus;
    lblResponsavelTecnico: TLabel;
    lblPeriodoServicoParalizado: TLabel;
    mskDtaPeriodoServicoParalizadoFim: TMaskEditFocus;
    lblA: TLabel;
    mskDtaPeriodoServicoParalizadoInicio: TMaskEditFocus;
    lblMotivoPausa: TLabel;
    mmoMotivoPausa: TMemoFocus;
    pnlInclusao: TPanel;
    pnlDescricaoManutencao: TPanel;
    lblDescricaoManutencao: TLabel;
    mmoDescricaoManutencao: TMemoFocus;
    pnlInformacoesSolicitacao: TPanel;
    mskDtaSolicitacao: TMaskEditFocus;
    lblDataSolicitacao: TLabel;
    lblCodigoSolicitacao: TLabel;
    edtCodSolicitacao: TEditFocus;
    lblOperadorSolicitacao: TLabel;
    edtOperadorSolicitacao: TEditFocus;
    lblDepartamento: TLabel;
    edtDepartamentoCodigo: TEditFocus;
    lblStatus: TLabel;
    edtStatus: TEditFocus;
    lblPrazoEstimado: TLabel;
    mskDtaPrazoEstimado: TMaskEditFocus;
    rdgPrioridade: TRadioGroup;
    pnlEquipamentos: TPanel;
    pnlEquipamentoAdicionar: TPanel;
    lblCodEquipamento: TLabel;
    edtEquipamentoCodigo: TEditFocus;
    btnAdicionarEquipamento: TBitBtnLocked;
    edtEquipamentoDescricao: TEditFocus;
    cxgvEquipamentos: TcxGridDBTableViewCitel;
    cxgEquipamentosLevel1: TcxGridLevel;
    cxgEquipamentos: TcxGridCitel;
    cxgvEquipamentosColumn1: TcxGridDBColumn;
    cxgvEquipamentosColumn2: TcxGridDBColumn;
    cxgvEquipamentosColumn3: TcxGridDBColumn;
    cxgvEquipamentosColumn4: TcxGridDBColumn;
    cxgvEquipamentosColumn5: TcxGridDBColumn;
    edtOperadorSolicitacaoNome: TEditFocus;
    edtDepartamentoDescricao: TEditFocus;
    edtResponsavelTecnicoNome: TEditFocus;
    pnlLegendas: TPanel;
    lblLegendaDeletar: TLabel;
    lblFinalizacaoCodigoSolicitacao: TLabel;
    edtFinalizacaoCodigoSolicitacao: TEditFocus;
    pnlLegenda: TPanel;
    lblLegendaPrioridadeBaixa: TLabel;
    shpLegendaPrioridadeBaixa: TShape;
    lblLegendaPrioridadeMedia: TLabel;
    shpLegendaPrioridadeMedia: TShape;
    lblLegendaStatusCompraConcluida: TLabel;
    shpLegendaStatusCompraConcluida: TShape;
    lblLegendaStatusCompra: TLabel;
    shpLegendaStatusCompra: TShape;
    lblLegendaStatusCotacao: TLabel;
    shpLegendaStatusCotacao: TShape;
    lblLegendaStatusNegada: TLabel;
    shpLegendaStatusNegada: TShape;
    lblLegendaStatusAprovada: TLabel;
    shpLegendaStatusAprovada: TShape;
    lblLegendaStatusAberto: TLabel;
    shpLegendaStatusAberto: TShape;
    lblLegendaStatusFinalizada: TLabel;
    shpLegendaStatusFinalizada: TShape;
    lblLegendaPrioridadeAlta: TLabel;
    shpLegendaPrioridadeAlta: TShape;
    lblLegendaPrioridade: TLabel;
    lblLegendaStatus: TLabel;
    cxgvListaMEI_DESMAN: TcxGridDBColumn;
    btnImprimr: TBitBtnLocked;
    pnlDocs: TPanel;
    rdbPlaNco: TRadioButton;
    edtPlaNco: TEditFocus;
    edtDesPlaNco: TEditFocus;
    rdbNfeEnt: TRadioButton;
    Label6: TLabel;
    edtNumDoc: TEditFocus;
    lblEspecie: TLabel;
    edtEspecie: TEditFocus;
    lblSerie: TLabel;
    edtSerie: TEditFocus;
    lblEmpresaNE: TLabel;
    edtCodEmpresaNE: TEditFocus;
    edtDesEmpresaNE: TEditFocus;
    Label8: TLabel;
    edtForNot: TEditFocus;
    edtDesForNot: TEditFocus;
    procedure FormShow(Sender: TObject);
    procedure edtOperadorSolicitacaoKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure edtEquipamentoCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure btnAdicionarEquipamentoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnFinalizarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtDepartamentoCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure edtResponsavelTecnicoCodigoKeyPress(Sender: TObject;
      var Key: Char);
    procedure btnCancelaClick(Sender: TObject);
    procedure cxgvListaCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxgvListaCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure edtPlaNcoKeyPress(Sender: TObject; var Key: Char);
    procedure edtNumDocKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimrClick(Sender: TObject);
    procedure rdbNfeEntClick(Sender: TObject);
    procedure rdbPlaNcoClick(Sender: TObject);
    procedure edtNumDocExit(Sender: TObject);
    procedure edtPlaNcoExit(Sender: TObject);
    procedure edtForNotExit(Sender: TObject);
    procedure edtForNotKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    cdsEquipamentos, cdsLista: TZClient;
    dtsEquipamentos, dtsLista: TDataSource;

    blnGravando: Boolean;

    FOperacao: TOperacao;

    strDireitos: String;

    procedure pLimparCampos;
    procedure pEscondeAbas;
    procedure pAjustaTela(oOperacao: TOperacao);
    procedure pCriarCdsEquipamentos;
    procedure pCriarCdsLista;
    procedure pAjustarBotoes(oStatus: TManutencaoEquipamentoInternoStatus);
    procedure pCarregarObjeto(oManutencao: TManutencaoEquipamentoInterno);
    function fGravar(pgbProgresso: TcxProgressBar): Boolean;
    function fExcluir(pgbProgresso: TcxProgressBar): Boolean;
    procedure pCarregarSolicitacao(strCodSolicitacao: string);
    procedure pDescricaoPlano(strCodPlan : String);
    function fNfeCadastrada(strNumDoc, strSerie, strCodFor : String) : Boolean;
    function fNfeVinculada(strNumDoc, strSerie, strCodFor : String) : Boolean;
    function VerificaDocEntrada : Boolean;
    procedure pImprimir(strCodLay, strCodSol: String);
    procedure pRemoveInfo(intCmp : Integer );
    procedure pLimpaDoc;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fValidaEdtNumDoc: Boolean;
    function fValidaedtPlaNco: Boolean;
    function fValidaedtForNot : Boolean;
  end;

var
  frmManutencaoEquipamentoInternoSolicitacao: TfrmManutencaoEquipamentoInternoSolicitacao;

implementation

{$R *.dfm}

uses
  untFuncoesSimples, untConsultas, untGravando;

{ TfrmPai }

procedure TfrmManutencaoEquipamentoInternoSolicitacao.btnAdicionarEquipamentoClick(
  Sender: TObject);
var
  qryBusca: TUniQuery;
begin
  qryBusca := fCriaQuery;

  cdsEquipamentos.AddIndex('indiceLocalizaEquipamento', 'EQU_CODIGO', [ixUnique]);
  cdsEquipamentos.IndexName := 'indiceLocalizaEquipamento';

  If not fValidaCampos(edtEquipamentoCodigo, True) Then
    Exit;

  try
    qryBusca.SQL.Clear;
    qryBusca.SQL.Add('SELECT CQ.EQU_CODIGO, CQ.EQU_DESCRI, CM.MAR_DESMAR, CQ.EQU_CODITE, CI.ITE_DESITE FROM CADEQU CQ');
    qryBusca.SQL.Add('INNER JOIN CADMAR CM ON CM.MAR_CODMAR = CQ.EQU_CODMAR');
    qryBusca.SQL.Add('INNER JOIN CADITE CI ON CI.ITE_CODITE = CQ.EQU_CODITE');
    qryBusca.SQL.Add('WHERE EQU_CODIGO = :CODIGO');
    qryBusca.ParamByName('CODIGO').AsString := edtEquipamentoCodigo.Text;
    qryBusca.Open;

    if qryBusca.RecordCount > 0 then
    begin
      if not cdsEquipamentos.FindKey([qryBusca.FieldByName('EQU_CODIGO').AsString]) then
      begin
        cdsEquipamentos.Append;
        cdsEquipamentos.FieldByName('EQU_CODIGO').AsString := qryBusca.FieldByName('EQU_CODIGO').AsString;
        cdsEquipamentos.FieldByName('EQU_DESCRI').AsString := qryBusca.FieldByName('EQU_DESCRI').AsString;
        cdsEquipamentos.FieldByName('MAR_DESMAR').AsString := qryBusca.FieldByName('MAR_DESMAR').AsString;
        cdsEquipamentos.FieldByName('EQU_CODITE').AsString := qryBusca.FieldByName('EQU_CODITE').AsString;
        cdsEquipamentos.FieldByName('ITE_DESITE').AsString := qryBusca.FieldByName('ITE_DESITE').AsString;
        cdsEquipamentos.Post;
      end
      else
      begin
        pMensagemOk('Equipamento ja adicionado!');
      end;
    end;

    edtEquipamentoCodigo.Clear;
    edtEquipamentoDescricao.Clear;

    pSetFocus(edtEquipamentoCodigo);
  finally
    cdsEquipamentos.IndexName := '';
    cdsEquipamentos.DeleteIndex('indiceLocalizaEquipamento');

    FreeAndNil(qryBusca);
  end;
end;

procedure TfrmManutencaoEquipamentoInternoSolicitacao.btnAlterarClick(
  Sender: TObject);
begin
  if cdsLista.IsEmpty then
    Exit;

  inherited;

  pLimparCampos;
  pCriarCdsEquipamentos;
  pCarregarSolicitacao(cdsLista.FieldByName('MEI_CODIGO').AsString);
  pAjustaTela(toEdicao);
end;

procedure TfrmManutencaoEquipamentoInternoSolicitacao.btnCancelaClick(
  Sender: TObject);
begin
  inherited;
   pAjustaTela(toLista);
end;

procedure TfrmManutencaoEquipamentoInternoSolicitacao.btnExcluirClick(
  Sender: TObject);
begin
  if cdsLista.IsEmpty then
    Exit;

  If not fPergunta('Deseja deletar a solicitação ' + cdsLista.FieldByName('MEI_CODIGO').AsString + '?') Then
    Exit;

  inherited;

  Try
    pCriarFormularios(TfrmGravando,frmGravando);
    frmGravando.strChave := 'Excluindo solicitação';
    frmGravando.fExecutarAcao := fExcluir;
    frmGravando.ShowModal;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

procedure TfrmManutencaoEquipamentoInternoSolicitacao.btnFinalizarClick(
  Sender: TObject);
begin
  if cdsLista.IsEmpty then
    Exit;

  inherited;
  pAjustaTela(toFinalizacao);
end;

function TfrmManutencaoEquipamentoInternoSolicitacao.VerificaDocEntrada : Boolean;
begin
  Result := True;
  If rdbNfeEnt.Checked And (Not fEmptyStr(edtNumDoc.Text)) And
    (fEmptyStr(edtSerie.Text) Or fEmptyStr(edtForNot.Text) ) Then
  Begin
    pSetFocus(edtNumDoc);
    Result := False;
    fMensagem('ATENÇÃO!', 'É necessário informar a Série e o Fornecedor da Nota de Entrada!', ['&OK']);
  End;
end;

procedure TfrmManutencaoEquipamentoInternoSolicitacao.btnGravarClick(
  Sender: TObject);
begin
  inherited;

  if Not VerificaDocEntrada Then
    Exit;

  Try
    pCriarFormularios(TfrmGravando,frmGravando);
    frmGravando.strChave := 'Gravando informações';
    frmGravando.fExecutarAcao := fGravar;
    frmGravando.ShowModal;
  Finally
    pFreeAndNil(frmGravando);
  End;

end;

procedure TfrmManutencaoEquipamentoInternoSolicitacao.pImprimir(strCodLay, strCodSol: String);
Var
  objImpressao: TEditorFastImpressao;
Begin
  objImpressao := TEditorFastImpressao.Create(Nil);
  try
    objImpressao.recDocume.strCodLay := strCodLay;
    objImpressao.recDocume.strNumDoc := strCodSol;
    objImpressao.recDocume.strCodEmp := VS_strCodEmp;
    objImpressao.recDocume.strEspDoc := 'SME';
    objImpressao.tpeTipoEtiqueta     := tpeSolicitacaoManutencaoEquipamentos;
    objImpressao.recDocume.intQtdImp := 1;
    objImpressao.recDocume.blnVisPdf := True;
    objImpressao.recDocume.strSaida  := 'P';
    objImpressao.fImprimeDocumento(tpaNormal, '', '');
  Finally
    FreeAndNil(objImpressao);
  End;
end;

procedure TfrmManutencaoEquipamentoInternoSolicitacao.btnImprimrClick(
  Sender: TObject);
Var
  strCodLay: String;
Begin
  strCodLay := fCampoTabela('LAY_CODLAY','LAYETI',['LAY_TIPLAY', 'LAY_PADRAO', 'LAY_CODEMP'],[ARR_TIPO_LAYOUT[tpeSolicitacaoManutencaoEquipamentos], 'S', VS_strCodEmp]);
  if Not fEmptyStr(strCodLay) Then
    pImprimir(strCodLay, cdsLista.FieldByName('MEI_CODIGO').AsString)
  Else
    fMensagem('ATENÇÃO', 'Não existe layout disponível para continuar!', ['&O k']);
End;

procedure TfrmManutencaoEquipamentoInternoSolicitacao.btnIncluirClick(
  Sender: TObject);
begin
  inherited;
  pLimparCampos;
  pCriarCdsEquipamentos;
  pAjustaTela(toInclusao);
end;

procedure TfrmManutencaoEquipamentoInternoSolicitacao.cxgvListaCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  pAjustarBotoes(TManutencaoEquipamentoInternoStatusFuncoes.fStringPraTStatus(cdsLista.FieldByName('MEI_STATUS').AsString));
end;

procedure TfrmManutencaoEquipamentoInternoSolicitacao.cxgvListaCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If AViewInfo.Item.Name = cxgvListaPrioridade.Name Then
  Begin
    If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgvListaPrioridade.Index] = 'Baixa') Then
    Begin
      ACanvas.Brush.Color := clWebLightGreen;
      ACanvas.Font.Color := clWindowText;
    End
    Else
    Begin
      If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgvListaPrioridade.Index] = 'Média') Then
      Begin
        ACanvas.Brush.Color := clWebPaleGoldenrod;
        ACanvas.Font.Color := clWindowText;
      End
      Else
      Begin
        If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgvListaPrioridade.Index] = 'Alta') Then
        Begin
          ACanvas.Brush.Color := clWebLightSalmon;
          ACanvas.Font.Color := clWindowText;
        End;
      End;
    End;
  end;

  If AViewInfo.Item.Name = cxgvListaStatus.Name Then
  Begin
    case TManutencaoEquipamentoInternoStatusFuncoes.fStringPraTStatus(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgvListaStatus.Index])) of
      tsAberto:
        begin
          ACanvas.Brush.Color := clWebPaleTurquoise;
          ACanvas.Font.Color := clWindowText;
        end;
      tsAprovada:
        begin
          ACanvas.Brush.Color := clWebLightSkyBlue;
          ACanvas.Font.Color := clWindowText;
        end;
      tsNegada:
        begin
          ACanvas.Brush.Color := clWebAntiqueWhite;
          ACanvas.Font.Color := clWindowText;
        end;
      tsCotacao:
        begin
          ACanvas.Brush.Color := clWebLightgrey;
          ACanvas.Font.Color := clWindowText;
        end;
      tsPedCompra:
        begin
          ACanvas.Brush.Color := clWebPeachPuff;
          ACanvas.Font.Color := clWindowText;
        end;
      tsConcluida:
        begin
          ACanvas.Brush.Color := clWebHoneydew;
          ACanvas.Font.Color := clWindowText;
        end;
      tsFinalizada:
        begin
          ACanvas.Brush.Color := clWebBeige;
          ACanvas.Font.Color := clWindowText;
        end;
    end;
  end;
end;

procedure TfrmManutencaoEquipamentoInternoSolicitacao.edtDepartamentoCodigoKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrDep: TConsultasArray;
begin
  inherited;
  If fPesqDepartamento(Self, edtDepartamentoCodigo, edtDepartamentoDescricao, Nil, Key, arrDep) Then
  Begin
    If fValidaCampos(edtDepartamentoCodigo, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmManutencaoEquipamentoInternoSolicitacao.edtEquipamentoCodigoKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrEqu: TConsultasArray;
begin
  inherited;

  {*********************************}
  {* NOVA CONSULTA DE EQUIPAMENTOS *}
  {******************************RV*}
  If fPesqEquipamento(Self, edtEquipamentoCodigo, edtEquipamentoDescricao, Nil, Key, arrEqu) Then
  Begin
    If fValidaCampos(edtEquipamentoCodigo, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmManutencaoEquipamentoInternoSolicitacao.fValidaedtForNot : Boolean;
begin
  Result := True;
  If Not fEmptyStr(edtForNot.Text) Then
  Begin
    edtDesForNot.Text := fRetNomFornecedor(edtForNot.text);
    If fEmptyStr(edtDesForNot.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Fornecedor não Encontrado!', ['&OK']);
      Result := False;
    End;
  End;
end;

procedure TfrmManutencaoEquipamentoInternoSolicitacao.edtForNotExit(
  Sender: TObject);
begin
  inherited;

  If (Not fValidaedtForNot) or
    (Not fValidaEdtNumDoc) Then
    edtForNot.Clear;
end;

procedure TfrmManutencaoEquipamentoInternoSolicitacao.edtForNotKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrForNot : TConsultasArray;
begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, edtForNot, edtDesForNot, nil, Key, arrForNot) Then
  Begin
    If fValidaCampos(edtForNot, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmManutencaoEquipamentoInternoSolicitacao.pLimpaDoc;
begin
  edtSerie.Clear;
  edtForNot.Clear;
  edtDesForNot.Clear;
end;

function TfrmManutencaoEquipamentoInternoSolicitacao.fValidaEdtNumDoc: Boolean;
begin
  Result := True;
  If rdbNfeEnt.Checked And
    (Not fEmptyStr(edtNumDoc.Text)) And
    (Not fEmptyStr(edtSerie.Text)) And
    (Not fEmptyStr(edtForNot.Text)) Then
  Begin
    If Not fNfeCadastrada(edtNumDoc.Text, edtSerie.Text, edtForNot.text) Then
    Begin
      pLimpaDoc;
      fMensagem('ATENÇÃO', 'NF-e não localizada no Livro Fiscal!', ['%OK']);
      Result := False;
    End
    Else
    Begin
      If fNfeVinculada(edtNumDoc.Text, edtSerie.Text, edtForNot.text) Then
      Begin
        pLimpaDoc;
        fMensagem('ATENÇÃO', 'NF-e vinculada a outra solicitação!', ['%OK']);
        Result := False;
      End;
    End;
  End
end;

procedure TfrmManutencaoEquipamentoInternoSolicitacao.edtNumDocExit(
  Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtNumDoc.Text) Then
    pLimpaDoc
  Else
    fValidaEdtNumDoc;
end;

procedure TfrmManutencaoEquipamentoInternoSolicitacao.edtNumDocKeyPress(
  Sender: TObject; var Key: Char);
var
  arrSel: TConsultasArray;
  qryConsulta: TUniQuery;
begin
  inherited;

  qryConsulta := fCriaQuery();
  Try
    If fPesqLivroFiscal(Self, qryConsulta, Key, arrSel, True, conGeral, 'F', '', '', '', False, 0, 0) Then
    Begin
      edtNumDoc.Text := qryConsulta.FieldByName('FIS_NUMDOC').AsString;
      edtSerie.Text  := qryConsulta.FieldByName('FIS_SERIE_').AsString;
      edtForNot.Text := qryConsulta.FieldByName('FIS_FORCLI').AsString;

      If fValidaCampos(edtNumDoc, True) Then
        self.SelectNext(ActiveControl, True, True);
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

function TfrmManutencaoEquipamentoInternoSolicitacao.fValidaedtPlaNco : Boolean;
begin
  Result := True;
  If rdbPlaNco.Checked And (Not fEmptyStr(edtPlaNco.Text)) Then
  Begin
    pDescricaoPlano(edtPlaNco.Text);
    If fEmptyStr(edtDesPlaNco.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Plano contábil inexistente!', ['&OK']);
      Result := False;
    End;
  End;
end;

procedure TfrmManutencaoEquipamentoInternoSolicitacao.edtPlaNcoExit(
  Sender: TObject);
begin
  inherited;

  If Not fValidaedtPlaNco Then
    edtPlaNco.Clear;
end;

procedure TfrmManutencaoEquipamentoInternoSolicitacao.edtPlaNcoKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrSel : TConsultasArray;
begin
  inherited;

  If fPesqPlanoContabil(Self, edtPlaNco, Nil, Nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtPlaNco, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmManutencaoEquipamentoInternoSolicitacao.edtOperadorSolicitacaoKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrOperador: TConsultasArray;
begin
  inherited;

  If fPesqOperador(Self, edtOperadorSolicitacao, edtOperadorSolicitacaoNome, Nil, Key, arrOperador) Then
  Begin
    If fValidaCampos(edtOperadorSolicitacao, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmManutencaoEquipamentoInternoSolicitacao.edtResponsavelTecnicoCodigoKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrDiversos : TConsultasArray;
begin
  inherited;
  If fPesqDiversos(Self, edtResponsavelTecnicoCodigo, edtResponsavelTecnicoNome, Nil, Key, arrDiversos, True, True) Then
  Begin
    If fValidaCampos(edtResponsavelTecnicoCodigo, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmManutencaoEquipamentoInternoSolicitacao.fExcluir(
  pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := False;

  try
    fStartTransaction;

    if TManutencaoEquipamentoInterno.fDeletarSolicitacao(cdsLista.FieldByName('MEI_CODIGO').AsString) then
    begin
      fCommit;
      pMensagemOk('Solicitação excluida com sucesso!');
      pAjustaTela(toLista);
    end
    else
    begin
      fRollBack;
      pMensagemOk('Erro ao excluir solicitaçao!');
    end;
  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
    End;
  End;
end;

function TfrmManutencaoEquipamentoInternoSolicitacao.fGravar(pgbProgresso: TcxProgressBar): Boolean;
var
  oManutencao: TManutencaoEquipamentoInterno;
  oManutencaoItens: TManutencaoEquipamentoInternoItens;
  blnGravouDados: Boolean;
begin
  blnGravando := True;
  blnGravouDados := False;

  oManutencao := TManutencaoEquipamentoInterno.Create;
  oManutencaoItens := TManutencaoEquipamentoInternoItens.Create;
  try
    case FOperacao of
      toInclusao :
        begin
          If fVerificaCampos Then
          Begin
            pCarregarObjeto(oManutencao);

            fStartTransaction;
            if oManutencao.fIncluirSolicicao(oManutencao)then
            begin
              cdsEquipamentos.First;
              while not cdsEquipamentos.Eof do
              begin
                oManutencaoItens.CodigoManutencao := oManutencao.Codigo;
                oManutencaoItens.CodigoEquipamento := cdsEquipamentos.FieldByName('EQU_CODIGO').AsString;
                oManutencaoItens.fIncluirSolicicaoItens(oManutencaoItens);

                cdsEquipamentos.Next;
              end;
              blnGravouDados := True;
            end;

            if blnGravouDados then
            begin
              if rdbNfeEnt.Checked And
                (Not fEmptyStr(edtNumDoc.Text)) then
                oManutencao.fVinculaSolicitacao(edtFinalizacaoCodigoSolicitacao.text,
                                                edtNumDoc.Text,
                                                'NF');
              fCommit;
              pMensagemOk('Solicitação gravada com sucesso!');
              pAjustaTela(toLista);
            end
            else
            begin
              fRollBack;
              pMensagemOk('Erro ao gravar solicitaçao!');
            end;
          End;
        end;
      toFinalizacao:
        begin
          If fVerificaCampos Then
          Begin
            pCarregarObjeto(oManutencao);

            fStartTransaction;
            blnGravouDados := oManutencao.fFinalizarSolicitacao(oManutencao);

            if blnGravouDados then
            begin
              fCommit;
              pMensagemOk('Solicitação finalizada com sucesso!');
              pAjustaTela(toLista);
            end
            else
            begin
              fRollBack;
              pMensagemOk('Erro ao finalizar solicitaçao!');
            end;
          End;
        end;
      toEdicao:
        begin
          If fVerificaCampos Then
          Begin
            pCarregarObjeto(oManutencao);

            fStartTransaction;
            if oManutencao.fAlterarSolicicao(oManutencao)then
            begin
              TManutencaoEquipamentoInternoItens.fDeletarItens(oManutencao.Codigo, False);
              cdsEquipamentos.First;
              while not cdsEquipamentos.Eof do
              begin
                oManutencaoItens.CodigoManutencao := oManutencao.Codigo;
                oManutencaoItens.CodigoEquipamento := cdsEquipamentos.FieldByName('EQU_CODIGO').AsString;
                oManutencaoItens.fIncluirSolicicaoItens(oManutencaoItens);

                cdsEquipamentos.Next;
              end;
              blnGravouDados := True;
            end;

            if blnGravouDados then
            begin
              fCommit;
              pMensagemOk('Solicitação atualizada com sucesso!');
              pAjustaTela(toLista);
            end
            else
            begin
              fRollBack;
              pMensagemOk('Erro ao atualizar solicitaçao!');
            end;
          End;
        end;
    end;
  finally
    Result := blnGravouDados;
    FreeAndNil(oManutencao);
    FreeAndNil(oManutencaoItens);
    blnGravando := False;
  end;
end;

procedure TfrmManutencaoEquipamentoInternoSolicitacao.FormCreate(
  Sender: TObject);
begin
  inherited;
  pCriarCdsLista;
end;

procedure TfrmManutencaoEquipamentoInternoSolicitacao.FormShow(Sender: TObject);
begin
  inherited;

  blnValidaDataMuitoAntiga := False;

  If fValidarDirEspecificos(strDireitos, strLoginUsuarioLogado, Self.Name) Then
  Begin
    {* INSERÇÃO *}
    If Pos('I', strDireitos) > 0 Then
      btnIncluir.Visible := True
    Else
      btnIncluir.Visible := False;

    {* ALTERAÇÃO *}
    If Pos('A', strDireitos) > 0 Then
      btnAlterar.Visible := True
    Else
      btnAlterar.Visible := False;

    {* EXCLUIR *}
    If Pos('E', strDireitos) > 0 Then
      btnExcluir.Visible := True
    Else
      btnExcluir.Visible := False;
  End;

  pEscondeAbas;
  pAjustaTela(toLista);
end;

procedure TfrmManutencaoEquipamentoInternoSolicitacao.pDescricaoPlano(strCodPlan : String);
begin
  if Not fEmptyStr(strCodPlan) then
    edtDesPlaNco.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [strCodPlan], False)
  else
    edtDesPlaNco.Text := '';
end;

function TfrmManutencaoEquipamentoInternoSolicitacao.fNfeCadastrada(strNumDoc, strSerie, strCodFor : String) : Boolean;
var
  qryBusca: TUniQuery;
begin
  qryBusca := fCriaQuery;

  try
    qryBusca.Close;
    qryBusca.SQL.Clear;
    qryBusca.SQL.Add('SELECT COUNT(1) AS QTD ');
    qryBusca.SQL.Add(' FROM CADFIS ');
    qryBusca.SQL.Add('WHERE FIS_NUMDOC = :NUMDOC ');
    qryBusca.SQL.Add('  AND FIS_CODEMP = :CODEMP ');
    qryBusca.SQL.Add('  AND FIS_SERIE_ = :SERIE_ ');
    qryBusca.SQL.Add('  AND FIS_FORCLI = :FORCLI ');
    qryBusca.SQL.Add('  AND FIS_ESPDOC = :ESPDOC ');
    qryBusca.SQL.Add('  AND FIS_ENTSAI = :ENTSAI ');
    qryBusca.SQL.Add('  AND FIS_TIP_FC = :TIP_FC ');
    qryBusca.ParamByName('NUMDOC').AsString := strNumDoc;
    qryBusca.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryBusca.ParamByName('SERIE_').AsString := strSerie;
    qryBusca.ParamByName('FORCLI').AsString := strCodFor;
    qryBusca.ParamByName('ESPDOC').AsString := 'NF';
    qryBusca.ParamByName('ENTSAI').AsString := 'E';
    qryBusca.ParamByName('TIP_FC').AsString := 'F';
    qryBusca.Open;

    Result := qryBusca.FieldByName('QTD').AsInteger > 0;
  finally
    FreeAndNil(qryBusca);
  end;
end;

function TfrmManutencaoEquipamentoInternoSolicitacao.fNfeVinculada(strNumDoc, strSerie, strCodFor : String) : Boolean;
var
  qryBusca: TUniQuery;
begin
  qryBusca := fCriaQuery;

  try
    qryBusca.Close;
    qryBusca.SQL.Clear;
    qryBusca.SQL.Add('SELECT COUNT(1) AS QTD ');
    qryBusca.SQL.Add(' FROM MNEQIG ');
    qryBusca.SQL.Add('WHERE MEI_CODEMP = :CODEMP');
    qryBusca.SQL.Add('  AND MEI_NUMDOC = :NUMDOC');
    qryBusca.SQL.Add('  AND MEI_SERIE_ = :SERIE_ ');
    qryBusca.SQL.Add('  AND MEI_CODFOR = :CODFOR ');
    qryBusca.SQL.Add('  AND MEI_ESPDOC = :ESPDOC ');
    qryBusca.SQL.Add('  AND MEI_TIPVIN = :TIPVIN');
    qryBusca.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryBusca.ParamByName('NUMDOC').AsString := strNumDoc;
    qryBusca.ParamByName('SERIE_').AsString := strSerie;
    qryBusca.ParamByName('CODFOR').AsString := strCodFor;
    qryBusca.ParamByName('ESPDOC').AsString := 'NF';
    qryBusca.ParamByName('TIPVIN').AsInteger := 1;
    qryBusca.Open;

    Result := qryBusca.FieldByName('QTD').AsInteger > 0;
  finally
    FreeAndNil(qryBusca);
  end;
end;

function TfrmManutencaoEquipamentoInternoSolicitacao.fValidaCampos(
  Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    case FOperacao of
      toInclusao, toEdicao:
        begin
          If (Sender = edtOperadorSolicitacao) Then
          Begin
            if fEmptyStr(edtOperadorSolicitacao.Text) then
            begin
              fMensagem('ATENÇÃO!', 'O Código do Operador deve ser preenchido!', ['&Ok']);
              Result := False;
            end
            else
            begin
              edtOperadorSolicitacaoNome.Text := fRetNomVendRep(edtOperadorSolicitacao.Text);

              if fEmptyStr(edtOperadorSolicitacaoNome.Text) then
              begin
                pMensagemOk('Operador não encontrado com este código!');
                edtOperadorSolicitacao.Clear;
                Result := False;
              end;
            end;
          End
          Else If (Sender = edtDepartamentoCodigo) Then
          Begin
            If (fEmptyStr(edtDepartamentoCodigo.Text)) Then
            Begin
              fMensagem('ATENÇÃO!','Informe o departamento!',['&OK']);
              Result := False;
            End
            Else
            Begin
              edtDepartamentoCodigo.Text := fPadL(edtDepartamentoCodigo.Text, edtDepartamentoCodigo.TamCampo, '0');
              edtDepartamentoDescricao.Text := fRetDescDepartamento(edtDepartamentoCodigo.Text);

              If fEmptyStr(edtDepartamentoDescricao.Text) Then
              Begin
                fMensagem('ATENÇÃO!','Departamento não encontrado!',['&OK']);
                Result := False;
              End;
            End;
          End
          Else If (Sender = mmoDescricaoManutencao) Then
          Begin
            if fEmptyStr(Trim(mmoDescricaoManutencao.Text)) then
            begin
              fMensagem('ATENÇÃO!', 'A descrição da manutenção deve ser preenchida!', ['&Ok']);
              Result := False;
            end;
          End
          Else If (Sender = mskDtaPrazoEstimado) Then
          Begin
            If (Not fEmptyDate(mskDtaPrazoEstimado.Text)) And
               (StrToDateDef(mskDtaPrazoEstimado.Text, 0) < VS_Date) Then
            Begin
              fMensagem('ATENÇÃO!', 'O Prazo estimado conclusão deve ser preenchido!', ['&Ok']);
              Result := False;
            End;
          End
          Else If (Sender = edtEquipamentoCodigo) Then
          Begin
            if blnGravando then
            begin
              if cdsEquipamentos.IsEmpty then
              Begin
                fMensagem('', 'A lista de equipamentos não pode ser vazia!' , ['&Ok']);
                Result := False;
              End;
            end
            else
            begin
              If fEmptyStr(edtEquipamentoCodigo.Text) Then
              Begin
                fMensagem('', 'O Equipamento deve ser preenchido!' , ['&Ok']);
                Result := False;
              End
              Else
              Begin
                edtEquipamentoCodigo.Text := fPadL(edtEquipamentoCodigo.Text, edtEquipamentoCodigo.TamCampo, '0');
                edtEquipamentoDescricao.Text := fRetNomEquipamentoOs(edtEquipamentoCodigo.Text);

                If (fEmptyStr(edtEquipamentoDescricao.Text)) Then
                Begin
                  fMensagem('ATENÇÃO!', 'Equipamento informado é inválido!', ['&OK']);
                  edtEquipamentoCodigo.Clear;
                  Result := False;
                End;
              End;
            end;
          End;
        end;
      toFinalizacao:
        begin
          If (Sender = edtResponsavelTecnicoCodigo) Then
          Begin
            if fEmptyStr(edtResponsavelTecnicoCodigo.Text) then
            begin
              fMensagem('ATENÇÃO!', 'O Código do Responsável Técnico deve ser preenchido!', ['&Ok']);
              Result := False;
            end
            else
            begin
              edtResponsavelTecnicoCodigo.Text := fPadL(edtResponsavelTecnicoCodigo.Text, edtResponsavelTecnicoCodigo.TamCampo, '0');
              edtResponsavelTecnicoNome.Text := fRetNomProfissional(edtResponsavelTecnicoCodigo.Text);

              if fEmptyStr(edtResponsavelTecnicoNome.Text) then
              begin
                pMensagemOk('Responsável Técnico não encontrado com este código!');
                edtResponsavelTecnicoCodigo.Clear;
                Result := False;
              end;
            end;
          End
          Else If (Sender = mmoMotivoPausa) Then
          Begin
            if fEmptyStr(Trim(mmoMotivoPausa.Text)) AND ((not fEmptyDate(mskDtaPeriodoServicoParalizadoInicio.Text)) OR (not fEmptyDate(mskDtaPeriodoServicoParalizadoFim.Text))) then
            begin
              fMensagem('ATENÇÃO!', 'O Motivo da Pausa deve ser preenchido!', ['&Ok']);
              Result := False;
            end;
          End
          Else If (Sender = mskDtaPeriodoServicoParalizadoInicio) Then
          Begin
            If fEmptyDate(mskDtaPeriodoServicoParalizadoInicio.Text) AND (not fEmptyDate(mskDtaPeriodoServicoParalizadoFim.Text)) Then
            Begin
              fMensagem('ATENÇÃO!', 'O inicio do Periodo Serviço Paralizado deve ser preenchido!', ['&Ok']);
              Result := False;
            End;
          End
          Else If (Sender = mskDtaPeriodoServicoParalizadoFim) Then
          Begin
            If fEmptyDate(mskDtaPeriodoServicoParalizadoFim.Text) AND (not fEmptyDate(mskDtaPeriodoServicoParalizadoInicio.Text)) Then
            Begin
              fMensagem('ATENÇÃO!', 'O fim do Periodo Serviço Paralizado deve ser preenchido!', ['&Ok']);
              Result := False;
            End;
          End
          Else If (Sender = edtNumDoc) Then
            Result := fValidaEdtNumDoc
          Else If (Sender = edtPlaNco) Then
            Result := fValidaedtPlaNco
          Else If (Sender = edtForNot) Then
            Result := fValidaedtForNot;
        end;
    end;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmManutencaoEquipamentoInternoSolicitacao.pAjustarBotoes(
  oStatus: TManutencaoEquipamentoInternoStatus);
begin
  case oStatus of
    tsAberto:
      begin
        btnAlterar.Enabled := True;
        btnExcluir.Enabled := True;
        btnFinalizar.Enabled := False;
      end;
    tsAprovada:
      begin
        btnAlterar.Enabled := True;
        btnExcluir.Enabled := True;
        btnFinalizar.Enabled := True;
      end;
    tsNegada:
      begin
        btnAlterar.Enabled := True;
        btnExcluir.Enabled := True;
        btnFinalizar.Enabled := False;
      end;
    tsCotacao:
      begin
        btnAlterar.Enabled := False;
        btnExcluir.Enabled := False;
        btnFinalizar.Enabled := False;
      end;
    tsPedCompra:
      begin
        btnAlterar.Enabled := False;
        btnExcluir.Enabled := False;
        btnFinalizar.Enabled := False;
      end;
    tsConcluida:
      begin
        btnAlterar.Enabled := False;
        btnExcluir.Enabled := False;
        btnFinalizar.Enabled := True;
      end;
    tsFinalizada:
      begin
        btnAlterar.Enabled := False;
        btnExcluir.Enabled := False;
        btnFinalizar.Enabled := False;
      end;
  end;
end;

procedure TfrmManutencaoEquipamentoInternoSolicitacao.pAjustaTela(
  oOperacao: TOperacao);
begin
  FOperacao := oOperacao;

  case FOperacao of
    toInclusao:
      begin
        btnIncluir.Enabled := False;
        btnGravar.Enabled := True;
        btnAlterar.Enabled := False;
        btnExcluir.Enabled := False;
        btnCancela.Enabled := True;
        btnFinalizar.Enabled := False;

        mskDtaSolicitacao.Text := DateToStr(VS_Date);
        edtOperadorSolicitacao.Text := strLoginUsuarioLogado;
        edtOperadorSolicitacaoNome.Text := strDescriUsuarioLogado;
        rdgPrioridade.ItemIndex := 2;
        edtStatus.Text := TManutencaoEquipamentoInternoStatusFuncoes.fTSatusParaString(tsAberto);

        pgcDados.ActivePage := tbsInclusao;
      end;
    toLista:
      begin
        pgcDados.ActivePage := tbsLista;
        btnIncluir.Enabled := True;
        btnGravar.Enabled := False;
        btnAlterar.Enabled := True;
        btnExcluir.Enabled := True;
        btnCancela.Enabled := False;
        btnFinalizar.Enabled := True;
        TManutencaoEquipamentoInterno.pCarregaListaSolicitacoes(tsTodas, cdsLista);
        pAjustarBotoes(TManutencaoEquipamentoInternoStatusFuncoes.fStringPraTStatus(cdsLista.FieldByName('MEI_STATUS').AsString));
      end;
    toFinalizacao:
      begin
        pgcDados.ActivePage := tbsFinalizacao;
        btnIncluir.Enabled := False;
        btnGravar.Enabled := True;
        btnAlterar.Enabled := False;
        btnExcluir.Enabled := False;
        btnCancela.Enabled := True;
        btnFinalizar.Enabled := False;
        pLimparCampos;
        edtFinalizacaoCodigoSolicitacao.Text := cdsLista.FieldByName('MEI_CODIGO').AsString;
        edtEspecie.Text := 'NF';
        edtCodEmpresaNE.Text    := VS_strCodEmp;
        edtDesEmpresaNE.Text    := fRetNomeEmpresaSelec(edtCodEmpresaNE.Text);
      end;
    toEdicao:
      begin
        btnIncluir.Enabled := False;
        btnGravar.Enabled := True;
        btnAlterar.Enabled := False;
        btnExcluir.Enabled := False;
        btnCancela.Enabled := True;
        btnFinalizar.Enabled := False;

        edtStatus.Text := TManutencaoEquipamentoInternoStatusFuncoes.fTSatusParaString(tsAberto);

        pgcDados.ActivePage := tbsInclusao;
      end;
  end;
end;

procedure TfrmManutencaoEquipamentoInternoSolicitacao.pCarregarObjeto(
  oManutencao: TManutencaoEquipamentoInterno);
begin
  case FOperacao of
    toInclusao, toEdicao:
      begin
        oManutencao.Codigo := edtCodSolicitacao.Text;
        oManutencao.DataCadastro := mskDtaSolicitacao.Text;
        oManutencao.OperadorCadastro := edtOperadorSolicitacao.Text;
        oManutencao.Departamento := edtDepartamentoCodigo.Text;
        oManutencao.Prioridade := rdgPrioridade.Items[rdgPrioridade.ItemIndex];
        oManutencao.Status := edtStatus.Text;
        oManutencao.DataEstimadaConclusao := mskDtaPrazoEstimado.Text;
        oManutencao.DescricaoManutencao := mmoDescricaoManutencao.Texto;
      end;
    toFinalizacao:
      begin
        oManutencao.Codigo := edtFinalizacaoCodigoSolicitacao.Text;
        oManutencao.Status := TManutencaoEquipamentoInternoStatusFuncoes.fTSatusParaString(tsFinalizada);
        oManutencao.ResponsavelTecnico := edtResponsavelTecnicoCodigo.Text;
        oManutencao.DataInicialParalizacao := mskDtaPeriodoServicoParalizadoInicio.Text;
        oManutencao.DataFinalParalizacao := mskDtaPeriodoServicoParalizadoFim.Text;
        oManutencao.MotivoPausa := mmoMotivoPausa.Texto;

        if rdbPlaNco.CheCked Then
        Begin
          oManutencao.TipoVinculo := 0;
          oManutencao.CadCta      := edtPlaNco.Text;
        End
        Else
        Begin
          oManutencao.TipoVinculo     := 1;
          oManutencao.NumeroDocumento := edtNumDoc.Text;
          oManutencao.EspDoc          := edtEspecie.Text;
          oManutencao.Serie           := edtSerie.Text;
          oManutencao.CodFor          := edtForNot.Text;
        End;
      end;
  end;
end;

procedure TfrmManutencaoEquipamentoInternoSolicitacao.pCarregarSolicitacao(strCodSolicitacao: string);
var
  oManutencao: TManutencaoEquipamentoInterno;
begin
  oManutencao := TManutencaoEquipamentoInterno.fCarregarSolicitacao(strCodSolicitacao);

  edtCodSolicitacao.Text := oManutencao.Codigo;
  mskDtaSolicitacao.Text := oManutencao.DataCadastro;
  edtOperadorSolicitacao.Text := oManutencao.OperadorCadastro;
  edtOperadorSolicitacaoNome.Text := fRetNomVendRep(edtOperadorSolicitacao.Text);
  edtDepartamentoCodigo.Text := oManutencao.Departamento;
  edtDepartamentoDescricao.Text := fRetDescDepartamento(edtDepartamentoCodigo.Text);
  rdgPrioridade.ItemIndex := rdgPrioridade.Items.IndexOf(oManutencao.Prioridade);
  edtStatus.Text := oManutencao.Status;
  mskDtaPrazoEstimado.Text := oManutencao.DataEstimadaConclusao;
  mmoDescricaoManutencao.Texto := oManutencao.DescricaoManutencao;
  edtResponsavelTecnicoCodigo.Text := oManutencao.ResponsavelTecnico;
  mskDtaPeriodoServicoParalizadoInicio.Text := oManutencao.DataInicialParalizacao;
  mskDtaPeriodoServicoParalizadoFim.Text := oManutencao.DataFinalParalizacao;
  mmoMotivoPausa.Texto := oManutencao.MotivoPausa;

  Case oManutencao.TipoVinculo Of
    0:
      Begin
        rdbPlaNco.Checked := True;
        edtPlaNco.Text := oManutencao.CadCta;
        pDescricaoPlano(edtPlaNco.Text);
      End;
    1:
      Begin
        rdbNfeEnt.Checked := True;
        edtNumDoc.Text    := oManutencao.NumeroDocumento;
        edtSerie.text     := oManutencao.Serie;
        edtForNot.text    := oManutencao.CodFor;
        edtDesForNot.Text := fRetNomFornecedor(edtForNot.text);
      End;
  End;

  TManutencaoEquipamentoInternoItens.pCarregarItensSolicitacao(strCodSolicitacao, cdsEquipamentos);
end;

procedure TfrmManutencaoEquipamentoInternoSolicitacao.pCriarCdsEquipamentos;
begin
  if Assigned(cdsEquipamentos) then
    FreeAndNil(cdsEquipamentos);

  cdsEquipamentos := TZClient.Create(Self);
  cdsEquipamentos.Close;
  cdsEquipamentos.FieldDefs.Clear;
  cdsEquipamentos.FieldDefs.Add('AUTOINCREM', ftString, 20);
  cdsEquipamentos.FieldDefs.Add('EQU_CODIGO', ftString, 10);
  cdsEquipamentos.FieldDefs.Add('EQU_DESCRI', ftString, 255);
  cdsEquipamentos.FieldDefs.Add('MAR_DESMAR', ftString, 255);
  cdsEquipamentos.FieldDefs.Add('EQU_CODITE', ftString, 10);
  cdsEquipamentos.FieldDefs.Add('ITE_DESITE', ftString, 255);
  cdsEquipamentos.CreateDataSet;
  cdsEquipamentos.Open;
  cdsEquipamentos.EmptyDataSet;

  dtsEquipamentos := TDataSource.Create(nil);
  dtsEquipamentos.DataSet := cdsEquipamentos;

  cxgvEquipamentos.DataController.DataSource := dtsEquipamentos;
end;

procedure TfrmManutencaoEquipamentoInternoSolicitacao.pCriarCdsLista;
begin
  if Assigned(cdsLista) then
    FreeAndNil(cdsLista);

  cdsLista := TZClient.Create(Self);
  cdsLista.Close;
  cdsLista.FieldDefs.Clear;
  cdsLista.FieldDefs.Add('AUTOINCREM', ftString, 20);
  cdsLista.FieldDefs.Add('MEI_CODIGO', ftString, 10);
  cdsLista.FieldDefs.Add('MEI_DTACAD', ftString, 255);
  cdsLista.FieldDefs.Add('MEI_OPECAD', ftString, 255);
  cdsLista.FieldDefs.Add('MEI_PRIORI', ftString, 10);
  cdsLista.FieldDefs.Add('MEI_STATUS', ftString, 255);
  cdsLista.FieldDefs.Add('MEI_DESMAN', ftString, 800);
  cdsLista.FieldDefs.Add('MEI_TIPVIN', ftInteger);
  cdsLista.FieldDefs.Add('MEI_NUMDOC', ftString, 20);
  cdsLista.CreateDataSet;
  cdsLista.Open;
  cdsLista.EmptyDataSet;

  dtsLista := TDataSource.Create(nil);
  dtsLista.DataSet := cdsLista;

  cxgvLista.DataController.DataSource := dtsLista;
end;

procedure TfrmManutencaoEquipamentoInternoSolicitacao.pEscondeAbas;
var
  intCont: Integer;
begin
  for intCont := 0 to Pred(pgcDados.PageCount) do
    pgcDados.Pages[intCont].TabVisible := False;
end;

procedure TfrmManutencaoEquipamentoInternoSolicitacao.pLimparCampos;
Var
  intContador: Integer;
begin
  For intContador := 0 To Self.ComponentCount -1 Do
  Begin
    If (Self.Components[intContador] Is TMaskEditFocus) Then
      (Self.Components[intContador] As TMaskEditFocus).Clear

    Else If (Self.Components[intContador] Is TEditFocus) Then
      (Self.Components[intContador] As TEditFocus).Clear

    Else If (Self.Components[intContador] Is TMemoFocus) Then
      (Self.Components[intContador] As TMemoFocus).Lines.Clear;
  End;
end;

procedure TfrmManutencaoEquipamentoInternoSolicitacao.pRemoveInfo(intCmp : Integer );
begin
  Case intCmp of
    0 :
      begin
        edtPlaNco.Clear;
        edtDesPlaNco.Clear;
      end;
    1 : pLimpaDoc;
  end;
end;

procedure TfrmManutencaoEquipamentoInternoSolicitacao.rdbNfeEntClick(
  Sender: TObject);
begin
  inherited;

  pRemoveInfo(0);
end;

procedure TfrmManutencaoEquipamentoInternoSolicitacao.rdbPlaNcoClick(
  Sender: TObject);
begin
  inherited;

  pRemoveInfo(1);
end;

end.
