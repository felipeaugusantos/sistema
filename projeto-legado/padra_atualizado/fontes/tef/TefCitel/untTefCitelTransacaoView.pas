unit untTefCitelTransacaoView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, System.Generics.Collections,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, DateUtils,
  cxCalc, cxGridBandedTableView, cxGridDBBandedTableView, cxButtons, EditFocus,
  Vcl.Mask, MaskEditFocus, Datasnap.DBClient, UniClientDataSet,
  untTefCitelTransacaoController, untTefCitelTransacaoInterfaces, frxExportXLSX,
  frxExportPDF, frxExportCSV, frxDBSet, dxBarBuiltInMenu, cxGridCustomPopupMenu,
  cxGridPopupMenu, cxContainer, Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar;

type
  TExportType = (etXlsx, etCsv, etPdf) ;
  TfrmTransacaoTef = class(TfrmPai)
    srcTransacoes: TDataSource;
    StyleRepository: TcxStyleRepository;
    estiloPendente: TcxStyle;
    estiloConfirmada: TcxStyle;
    estiloCancelada: TcxStyle;
    estiloPadrao: TcxStyle;
    pnlFundo: TPanel;
    pnlAcoes: TPanel;
    btnConfirma: TcxButton;
    btnCancela: TcxButton;
    GridCitel: TcxGridCitel;
    GridCitelLevel: TcxGridLevel;
    btnConsultar: TcxButton;
    pnlFiltros: TFlowPanel;
    pnlDtaIni: TPanel;
    lblDtaIni: TLabel;
    pnlDtafin: TPanel;
    lblDtaFin: TLabel;
    pnlNumNsu: TPanel;
    lblNumNsu: TLabel;
    pnlNumAutorizacao: TPanel;
    lblFiltroNumAut: TLabel;
    pnlConsulta: TPanel;
    btnExportar: TcxButton;
    PopupMenuExportar: TPopupMenu;
    Excel1: TMenuItem;
    CSV1: TMenuItem;
    GridCitelTableView: TcxGridDBBandedTableView;
    GridCitelTableViewCODLOJ: TcxGridDBBandedColumn;
    GridCitelTableViewNUMPDV: TcxGridDBBandedColumn;
    GridCitelTableViewDTAHRA: TcxGridDBBandedColumn;
    GridCitelTableViewNUMNSU: TcxGridDBBandedColumn;
    GridCitelTableViewNUMCAR: TcxGridDBBandedColumn;
    GridCitelTableViewINFTRN: TcxGridDBBandedColumn;
    GridCitelTableViewTIPTRN: TcxGridDBBandedColumn;
    GridCitelTableViewQTDPAR: TcxGridDBBandedColumn;
    GridCitelTableViewVALTRN: TcxGridDBBandedColumn;
    GridCitelTableViewNOMRED: TcxGridDBBandedColumn;
    GridCitelTableViewNOMBAN: TcxGridDBBandedColumn;
    GridCitelTableViewCONTRO: TcxGridDBBandedColumn;
    GridCitelTableViewNSUHOS: TcxGridDBBandedColumn;
    GridCitelTableViewCODAUT: TcxGridDBBandedColumn;
    GridCitelTableViewCODSIT: TcxGridDBBandedColumn;
    GridCitelTableViewESTADO: TcxGridDBBandedColumn;
    cxGridPopupMenu: TcxGridPopupMenu;
    gbTipoBusca: TGroupBox;
    rbTodas: TRadioButton;
    rbPendentes: TRadioButton;
    rbEspecifica: TRadioButton;
    edtNumNsu: TEditFocus;
    edtNumAutorizacao: TEditFocus;
    GridCitelTableViewSEQTRN: TcxGridDBBandedColumn;
    btnImprimirComprovante: TcxButton;
    mniPDF: TMenuItem;
    frxRelatorio: TfrxReport;
    frxPDFExport: TfrxPDFExport;
    frxDBRelatorio: TfrxDBDataset;
    cdsDadosRelatorio: TUniClientDataSet;
    cdsDadosRelatorioSEQTRN: TIntegerField;
    cdsDadosRelatorioDTAHRA: TDateTimeField;
    cdsDadosRelatorioNUMNSU: TStringField;
    cdsDadosRelatorioCONTRO: TStringField;
    cdsDadosRelatorioTIPTRN: TStringField;
    cdsDadosRelatorioINFTRN: TStringField;
    cdsDadosRelatorioESTADO: TStringField;
    cdsDadosRelatorioVALTRN: TFloatField;
    cdsDadosRelatorioCODSIT: TStringField;
    cdsDadosRelatorioNOMRED: TStringField;
    cdsDadosRelatorioNOMBAN: TStringField;
    cdsDadosRelatorioNSUHOS: TStringField;
    cdsDadosRelatorioNUMCAR: TStringField;
    cdsDadosRelatorioCODLOJ: TStringField;
    cdsDadosRelatorioNUMPDV: TStringField;
    cdsDadosRelatorioQTDPAR: TIntegerField;
    cdsDadosRelatorioCODAUT: TStringField;
    cxDtInicial: TcxDateEdit;
    cxDtFinal: TcxDateEdit;
    edtVlrTransacao: TEditFocus;
    lblValor: TLabel;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure RemoverFiltro(Sender: TObject);

    procedure btnConsultarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure GridCitelTableViewStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure Excel1Click(Sender: TObject);
    procedure CSV1Click(Sender: TObject);
    procedure rbTodasKeyPress(Sender: TObject; var Key: Char);
    procedure rbTodasClick(Sender: TObject);
    procedure edtNumAutorizacaoKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure mniPDFClick(Sender: TObject);
    procedure btnImprimirComprovanteClick(Sender: TObject);
  private
    FController: TTransacaoTefController;

    procedure AfterScrollConsulta(DataSet: TDataSet);
    procedure pPreparaGridTransacoes;
    procedure pPreparaTiposConsulta;
    procedure pAjustaVisibilidadeCampos;
    procedure pHabitarExportacao(const AValue: Boolean);
    procedure pImprimirComprovante;
    procedure pExportarTransacoesParaPDF;
    function fValidarIntervaloDatas(const AdtInicial, AdtFinal: TDate;
      const AIntervalo: Integer): string;
    function fMontarParamBusca: TTransacaoTefBuscaParam;
    function fBuscaTipo: TTransacaoTefBuscaTipo;
    function fVerificarDireitoAcesso(const AKey, AText, ACaption, AMsg: string): Boolean;
    function fDataMinPermitida(const AData: TDate; AIntervalo: Integer): TDate;
    function fObterAutoIncrTransacao(const ANSU, ACodRede: string; const AData: TDate; const AValTrn: Double): string;
    function fRefreshFilterDataSet(const AParams: TTransacaoTefBuscaParam): Boolean;
    function fFiltroConsulta(const AParams: TTransacaoTefBuscaParam): string;

    procedure pCopyDados(const ADataSet: TDataSet);
    procedure pExportToPDF(const AArquivoSaidaPDF: string);
    procedure FilterDataSet(const AParams: TTransacaoTefBuscaParam);

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses
  System.Math, System.UITypes, untFuncoesSimples, untExportaGridCSV, untExportaGridExcel,
  untLiberacao, untTypesSistema, untTefCitelUtil;

{$R *.dfm}

procedure TfrmTransacaoTef.btnCancelaClick(Sender: TObject);
var
  blnConsultar: Boolean;
begin
  inherited;

   if not fVerificarDireitoAcesso(
     'CAR_CANC_TRANS_TEF',
     'Permitir [F7] - Cancelar Pendente em Consulta Transações TEF?',
     'Cancelar Transações TEF',
     'Cancelar Transações TEF')
  then
    Exit;

  if srcTransacoes.DataSet.RecordCount = 0 then
    Exit;

  if not fPergunta('Deseja cancelar a transação Pendente?', false) Then
    Exit;

  blnConsultar := False;
  fExecutarModal(
    procedure
    begin
      try
        blnConsultar := FController.fCancelarTransacaoPendente(srcTransacoes.DataSet.FieldByName('SEQTRN').AsInteger);
      except
        on TE: TTrasacaoTefException do
          pMensagemOk(TE.Message);

        on RE: TTransacaoTefRequestException do
          pMensagemOk(RE.Message);

        on E: Exception do
          pMensagemOk(E.Message);

      end;
    end,
    'Solicitando Cancelamento...', ''
  );

  if blnConsultar then
  begin
    fMensagem('ATENÇÃO!', 'Cancelamento solicitado.', ['&Ok']);
    btnConsultar.Click;
  end;
end;

function TfrmTransacaoTef.fVerificarDireitoAcesso(const AKey, AText, ACaption, AMsg: string): Boolean;
var
  LObjLiberacao: TLiberacao;
begin
  Result := fVerificaAcessoSistema(AKey, strLoginUsuarioLogado);
  if Result Then
    Exit;

  LObjLiberacao := TLiberacao.Create;
  try
    LObjLiberacao.Clear;
    LObjLiberacao.objMsgLibera.pAddSeparador(106);
    LObjLiberacao.objMsgLibera.pAddTexto(AText);
    LObjLiberacao.objMsgLibera.pAddTextoCaption('', ACaption, 23);
    LObjLiberacao.strDirAce := AKey;
    LObjLiberacao.strMsgSen := AMsg;
    LObjLiberacao.blnMosMen := True;
    LObjLiberacao.strCodOpe := strLoginUsuarioLogado;
    LObjLiberacao.strCodDig := strLoginUsuarioLogado;
    LObjLiberacao.objMsgLibera.pAddSeparador(106);

    Result := LObjLiberacao.fLibera;
  finally
    FreeAndNil(LObjLiberacao);
  end;
end;

procedure TfrmTransacaoTef.btnConfirmaClick(Sender: TObject);
var
  blnConsultar: Boolean;
begin
  inherited;
  if srcTransacoes.DataSet.RecordCount = 0 then
    Exit;

  if not fPergunta('Deseja confirmar a transação Pendente?', false) Then
    Exit;

  blnConsultar := False;
  fExecutarModal(
    procedure
    begin
      try
        blnConsultar := FController.fConfirmarTransacaoPendente(srcTransacoes.DataSet.FieldByName('SEQTRN').AsInteger);
      except
        on TE: TTrasacaoTefException do
          pMensagemOk(TE.Message);

        on RE: TTransacaoTefRequestException do
          pMensagemOk(RE.Message);

        on E: Exception do
          pMensagemOk(E.Message);
      end;
    end,
    'Solicitando Confirmação...', ''
  );

  if blnConsultar then
  begin
    fMensagem('ATENÇÃO!', 'Confirmação solicitada.', ['&Ok']);
    btnConsultar.Click;
  end;
end;

procedure TfrmTransacaoTef.btnConsultarClick(Sender: TObject);
const
  LIntervalo = 40; // em dias
var
  LParamsBusca: TTransacaoTefBuscaParam;
  LTipoBusca: TTransacaoTefBuscaTipo;
  LDataIni, LDataFim, LDataMax: TDate;
  LMessage: string;
  LResult: Boolean;
begin
  inherited;
  pHabitarExportacao(False);

  if not fVerificarDireitoAcesso(
     'CAR_CONS_TRANS_TEF',
     'Permitir [F10] - Consultar Transações TEF no Relatório TEF?',
     'Consultar Transações TEF',
     'Consultar Transações TEF')
  then
    Exit;

  if not fVerificaCampos then
    Exit;

  LTipoBusca := fBuscaTipo;
  LDataIni   := cxDtInicial.Date;
  LDataFim   := cxDtFinal.Date;

  if fIsOpcaoTEF(toCliSiTef) and (LTipoBusca = tbPendentes) then
  begin
    LMessage := fValidarIntervaloDatas(LDataIni, LDataFim, LIntervalo);
    if LMessage <> EmptyStr then
    begin
      fMensagem('ATENÇÃO!', LMessage, ['&Ok']);
      LDataMax := fDataMinPermitida(LDataIni, LIntervalo);
      cxDtInicial.Date := LDataMax;
      cxDtInicial.SetFocus;
      Exit;
    end;
  end;

  FController.pClearDataSet;
  try
    fExecutarModal(
      procedure
      begin
        try
          case LTipoBusca of
            tbTodas:
            begin
              if not FController.fBuscarTransacoesDia(LDataIni) then
                raise Exception.Create('Erro ao buscar transações do dia.');
            end;

            tbPendentes:
            begin
              if not FController.fBuscarTransacoesPendentes(LDataIni, LDataFim) then
                raise Exception.Create('Erro ao buscar transações pendentes.');
            end;

            tbEspecifica:
            begin
              LParamsBusca := fMontarParamBusca;
              if Trim(LParamsBusca.NumNsu).IsEmpty then
                LResult := FController.fBuscarTransacoesDia(LDataIni)
              else
                LResult := FController.fBuscarTransacaoEspecifica(LParamsBusca);

              if not LResult then
                raise Exception.Create('Erro ao buscar transação específica.');
            end;
          end;

        except
          on TE: TTrasacaoTefException do
            pMensagemOk(TE.Message);

          on RE: TTransacaoTefRequestException do
            pMensagemOk(RE.Message);

          on E: Exception do
            pMensagemOk(E.Message);
        end;
      end,
      'Consultando...', ''
    );
  finally
    FilterDataSet(LParamsBusca);
    AfterScrollConsulta(FController.fGetDataset);
  end;
end;

function TFrmTransacaoTef.fFiltroConsulta(const AParams: TTransacaoTefBuscaParam): string;
var
  I: Integer;
  LListFilter: TStringList;
  LFilter: string;
begin
  LListFilter := TStringList.Create;
  try
    if not(Trim(AParams.CodAut).IsEmpty) then
      LListFilter.Add('CODAUT=' + AParams.CodAut.QuotedString);

    if not (Trim(AParams.NumNsu).IsEmpty) then
      LListFilter.Add('NUMNSU=' + AParams.NumNsu.QuotedString);

    if (AParams.ValTrn > 0) then
      LListFilter.Add('VALTRN=' + FloatToStr(AParams.ValTrn));

    LFilter := '';
    for I := 0 to Pred(LListFilter.Count) do
    begin
      if LFilter.IsEmpty then
        LFilter := LListFilter.Strings[I]
      else
        LFilter := LFilter + ' AND ' + LListFilter.Strings[I];
    end;
    Result := LFilter;
  finally
    FreeAndNil(LListFilter);
  end;
end;

function TfrmTransacaoTEF.fRefreshFilterDataSet(const AParams: TTransacaoTefBuscaParam): Boolean;
var
  LDataSet: TDataset;
  LFilter: string;
  LAfterScrollEvent: TDataSetNotifyEvent;
begin
  LDataSet := FController.fGetDataset;

  LAfterScrollEvent := LDataSet.AfterScroll ;
  LDataSet.AfterScroll := Nil ;
  LDataSet.DisableControls;
  try
    LDataSet.Filtered := False;
    LDataSet.Filter := '';

    if LDataSet.IsEmpty then
      Exit(False);

    LFilter := fFiltroConsulta(AParams);
    if LFilter.IsEmpty then
      Exit(False);

    LDataSet.Filter := LFilter;
    LDataSet.Filtered := True;
  finally
    LDataSet.EnableControls;
    Result := (LDataSet.RecordCount > 0);
    LDataSet.AfterScroll := LAfterScrollEvent ;
  end;
end;

procedure TfrmTransacaoTEF.FilterDataSet(const AParams: TTransacaoTefBuscaParam);
var
  LResult: Boolean;
  LEnabled: Boolean;
begin
  LEnabled := False;
  try
    LResult := fRefreshFilterDataSet(AParams);
    LEnabled := (FController.fGetDataset.RecordCount > 0);
  finally
    pHabitarExportacao(LEnabled);
  end;

  if LResult then
    Exit;

  if (not LEnabled) and FController.fGetDataset.Filtered then
    pMensagemOk('A transação não foi encontrada');

end;

procedure TfrmTransacaoTef.btnImprimirComprovanteClick(Sender: TObject);
begin
  inherited;
  pImprimirComprovante;
end;

function TfrmTransacaoTef.fValidarIntervaloDatas(const AdtInicial, AdtFinal: TDate;
  const AIntervalo: Integer): string;
var
  LStrDateMin: string;
  LDateMin: TDate;
begin
  Result := EmptyStr;

  if AdtInicial = 0 then
    Result := 'É necessário informar uma data inicial.'
  else if AdtFinal = 0 then
    Result := 'É necessário informar uma data final.';

  if (AdtInicial > VS_Date) or (AdtFinal > VS_Date) then
    Result := 'A data inicial e final devem ser menor ou igual a data atual.'
  else if (AdtInicial > AdtFinal) then
    Result := 'A data inicial não pode ser maior que a data final.';

  if Result <> EmptyStr then
    Exit;

  LDateMin := incDay(AdtFinal, - AIntervalo);
  LStrDateMin := FormatDateTime('dd/mm/yyyy', LDateMin);
  if AdtInicial < LDateMin then
  begin
    Result := Format('O período informado não pode ser superior a %d dias para a consulta.' +
      sLineBreak + 'A data inicial mínima permitida é %s.', [AIntervalo, LStrDateMin]);
  end;
end;

procedure TfrmTransacaoTef.pHabitarExportacao(const AValue: Boolean);
begin
  btnExportar.Enabled := AValue;
end;

procedure TfrmTransacaoTef.CSV1Click(Sender: TObject);
Var
  objExportaCSV: TExportaGridCSV;
begin
  inherited;

  if (not srcTransacoes.DataSet.Active) or (srcTransacoes.DataSet.IsEmpty) then
    Exit ;

  objExportaCSV := TExportaGridCSV.Create(Self, GridCitelTableView);
  Try
    If (Not objExportaCSV.fExporta) Then
      pMensagemOk('Ocorreu um erro ao gerar o arquivo csv!');
  Finally
    FreeAndNil(objExportaCSV);
  End;
end;

procedure TfrmTransacaoTef.edtNumAutorizacaoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not (CharInSet(Key, ['0'..'9', #8, '.', '-'])) then
    Key := #0
  else
  begin
    if (Key = '.') and (Pos('.', (Sender as TEditFocus).Text) > 0) then
      Key := #0;

    if (Key = '-') and (Pos('-', (Sender as TEditFocus).Text) > 0) then
      Key := #0;
  end;
end;

procedure TfrmTransacaoTef.Excel1Click(Sender: TObject);
Var
  objExportaExcel: TExportaGridExcel;
begin
  inherited;

  if (not srcTransacoes.DataSet.Active) or (srcTransacoes.DataSet.IsEmpty) then
    Exit ;

  objExportaExcel := TExportaGridExcel.Create(Self, GridCitelTableView);
  Try
    If (Not objExportaExcel.fExporta) Then
      pMensagemOk('Ocorreu um erro ao gerar o arquivo Excel!');
  Finally
    FreeAndNil(objExportaExcel);
  End;
end;

procedure TfrmTransacaoTef.pExportarTransacoesParaPDF;
var
  LFileName: string;
begin
  if (not srcTransacoes.DataSet.Active) or (srcTransacoes.DataSet.IsEmpty) then
    Exit;
  try
    pCopyDados(srcTransacoes.DataSet);
    if not cdsDadosRelatorio.IsEmpty then
    begin
      LFileName := 'TransacoesTef_' + FormatDateTime('ddmmyy_hhmmss', now());
      pExportToPDF(LFileName);
    end;
  except
    on E: Exception do
      pMensagemOk('Ocorreu um erro ao exportar para PDF:' + sLineBreak + E.Message);
  end;
end;

function TfrmTransacaoTef.fBuscaTipo: TTransacaoTefBuscaTipo;
begin
  Result := tbTodas;
  if rbPendentes.Checked then
    Result := tbPendentes
  else if rbEspecifica.Checked then
    Result := tbEspecifica;
end;

function TfrmTransacaoTef.fDataMinPermitida(const AData: TDate; AIntervalo: Integer): TDate;
begin
  Result := AData;
  if DaysBetween(Date, AData) > AIntervalo then
    Result := IncDay(Date, - AIntervalo);
end;

function TfrmTransacaoTef.fMontarParamBusca: TTransacaoTefBuscaParam;
begin
  Result.CodSit := '';
  Result.CodLoj := '';
  Result.NumCar := '';
  Result.NumNsu := '';
  Result.CodAut := '';
  Result.ValTrn := 0.0;
  Result.DtaTrn := cxDtInicial.Date;

  if pnlNumNsu.Visible then
    Result.NumNsu := Trim(edtNumNsu.Text);

  if pnlNumAutorizacao.Visible then
  begin
     Result.CodAut := Trim(edtNumAutorizacao.Text);
     Result.ValTrn := StrToFloatDef(edtVlrTransacao.Text, 0);
  end;

end;

procedure TfrmTransacaoTef.FormCreate(Sender: TObject);
begin
  inherited;
  FController := TTransacaoTefController.Create;
  pHabitarExportacao(false);
  btnImprimirComprovante.Enabled := False;
end;

procedure TfrmTransacaoTef.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FController);
end;

procedure TfrmTransacaoTef.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  if Key = VK_F6 then
  begin
    Key := 0;
    if btnImprimirComprovante.Enabled then
       pImprimirComprovante;
    Exit;
  end;

  if Key = VK_ESCAPE then
  begin
    Key := 0;
    btnSair.Click;
    Exit;
  end;

  if Key = VK_F10 then
  begin
    Key := 0;
    if btnConsultar.Enabled then
      btnConsultar.Click;
  end

  else if (ssAlt in Shift) and (Key = Ord('C')) then
  begin
    Key := 0;
    if btnConsultar.Enabled then
      btnConsultar.Click;
  end

  else
  if Key = VK_F5 then
  begin
    Key := 0;
    if btnConfirma.Enabled then
      btnConfirma.Click;
  end

  else
  if Key = VK_F7 then
  begin
    Key := 0;
    if btnCancela.Enabled then
      btnCancela.Click;
  end

  else
  if Key = VK_F9 then
  begin
    Key := 0;
    if btnExportar.Enabled then
      btnExportar.Click;
  end;
end;

procedure TfrmTransacaoTef.FormShow(Sender: TObject);
begin
  inherited;
  pPreparaGridTransacoes;
  pPreparaTiposConsulta;
  pAjustaVisibilidadeCampos;
  btnConsultar.SetFocus;
end;

function TfrmTransacaoTef.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var
  LMsgErr: string;
begin
  Result := True;
  If not (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
    Exit;

  LMsgErr := EmptyStr;

  If (Sender = cxDtInicial) and pnlDtaIni.Visible then
  Begin
    if cxDtInicial.Date = 0 Then
      LMsgErr := 'A Data Inicial deve ser preenchida!'
    else
    begin
      if (cxDtInicial.Date > Date)  then
        LMsgErr := Format('Informe uma Data Inicial menor ou igual a %s', [FormatDateTime('dd/mm/yyyy', Date)])
      else if not fDataValida(cxDtInicial.Date) then
        LMsgErr := 'Informe uma Data Inicial válida!';
    end;
  End;

  If (Sender = cxDtFinal) and pnlDtaFin.Visible Then
  Begin
    If cxDtFinal.Date = 0 Then
      LMsgErr := 'A Data Final deve ser preenchida!'
    else
    begin
      if (cxDtFinal.Date > Date)  then
        LMsgErr := Format('Informe uma Data Final menor ou igual a %s', [FormatDateTime('dd/mm/yyyy', Date)])
      else
      begin
        if not fDataValida(cxDtFinal.Date) then
          LMsgErr := 'Informe uma Data Final válida!'
        else if Not fValidaPeriodo( DateToStr(cxDtInicial.Date), DateToStr(cxDtFinal.Date)) Then
          LMsgErr := 'A Data Final deve ser maior ou igual a Data Inicial!';
      end;
    end;
  End;

  if pnlNumNsu.Visible then
  begin
    If (Sender = edtNumNsu) or (Sender = edtNumAutorizacao) Then
    Begin
      Result := fValidaCampos(cxDtInicial, blnBuscaPorChave); // é requerida a data inicial
      Exit;
    end;
  end;

  Result := LMsgErr.IsEmpty;
  if not Result then
  begin
    fMensagem('ATENÇÃO!', LMsgErr, ['&Ok']);
    pSetFocus(Sender);
  end;

end;

procedure TfrmTransacaoTef.GridCitelTableViewStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
Var
  LstrSeq: string;
  LStatus: TTransacaoTefStatus;
begin
  inherited;
  If (ARecord.IsData) and (ARecord.Index > -1) Then
  begin
    LstrSeq := VarToStr(Sender.DataController.Values[ARecord.RecordIndex, GridCitelTableViewSEQTRN.Index]);
    LStatus := FController.fGetTrnStatus(StrToIntDef(LstrSeq, -1));

    case LStatus of
      stConfirmada:
        AStyle := estiloConfirmada;

      stPendente, stCancelamentoPendente, stConfirmacaoPendente:
        AStyle := estiloPendente;

      stCancelada, stEstorno:
        AStyle := estiloCancelada;

      else
        AStyle := estiloPadrao;
    end;
  end;
end;

procedure TfrmTransacaoTef.pImprimirComprovante;
var
  LMensagem: string;
  LAutoIncr: string;
  LViaCliente, LViaLoja: string;
  LDtHora: TDateTime;
  LNumNSU: string;
  LData: TDate;
  LCodRede: string;
  LValTrn: Double;
begin
  if (not srcTransacoes.DataSet.Active) or (srcTransacoes.DataSet.IsEmpty) then
  begin
    pMensagemOk('Nenhum registro encontrado para impressão.');
    Exit;
  end;

  if not fVerificarDireitoAcesso(
     'CARREIMPFET',
     'Permitir reimprimir transações TEF efetuadas',
     'Reimprimir transações TEF',
     'Reimprimir transações TEF')
  then
    Exit;

  LCodRede:= srcTransacoes.DataSet.FieldByName('CODRED').AsString;
  LNumNSU := srcTransacoes.DataSet.FieldByName('NSUHOS').AsString;
  LDtHora := srcTransacoes.DataSet.FieldByName('DTAHRA').AsDateTime;
  LValTrn := srcTransacoes.DataSet.FieldByName('VALTRN').AsFloat;

  LCodRede:= fStrZero(LCodRede,5);
  LNumNSU := fstrzero(LNumNSU,14); // fPadL(AstrNsu, 14, '0')
  LData   := Trunc(LDtHora);

  LAutoIncr := fObterAutoIncrTransacao(LNumNSU, LCodRede, LData, LValTrn);

  if LAutoIncr = EmptyStr then
  begin
    LMensagem := 'Não foi possível recuperar dados do comprovante!';
    fMensagem('ATENÇÃO!', LMensagem, ['&OK']);
    Exit;
  end;

  LMensagem := EmptyStr;
  pPreparaDadosReimpressaoViaTefTra(LAutoIncr, LViaCliente, LViaLoja, LMensagem);

  if not fEmptyStr(LViaCliente) then
  begin
    if fImpCupom(LViaCliente, LViaLoja) then
      Exit;
    LMensagem := 'Não foi possível imprimir o comprovante!'
  end;

  if fEmptyStr(LMensagem) then
    LMensagem := 'Não foi possível recuperar dados do comprovante!';

  fMensagem('ATENÇÃO!', LMensagem, ['&OK']);

end;

function TfrmTransacaoTef.fObterAutoIncrTransacao(const ANSU, ACodRede: string; const AData: TDate; const AValTrn: Double): string;
begin
  Result := untTefCitelUtil.fObterAutoIncrTransacao(ANSU, ACodRede, AData, AValTrn);
end;

procedure TfrmTransacaoTef.mniPDFClick(Sender: TObject);
begin
  inherited;
  pExportarTransacoesParaPDF;
end;

procedure TfrmTransacaoTef.pAjustaVisibilidadeCampos;
var
  I: Integer;
  LTipoBusca: TTransacaoTefBuscaTipo;
  LarrFiltros: TArray<string>;
  LstrFiltro: string;
begin
  // desabilita todos os filtros
  for I := 0 to pnlFiltros.ControlCount - 1 do
  begin
    if (pnlFiltros.Controls[I] is TPanel) then
      TPanel(pnlFiltros.Controls[I]).visible := False;
  end;

  edtNumNsu.Clear;
  edtNumAutorizacao.Clear;
  edtVlrTransacao.Clear;
  cxDtInicial.Date := VS_Date;
  cxDtFinal.Date := VS_Date;

  //obtem tipo de busca selecionado
  LTipoBusca := fBuscaTipo;
  //obtem filtros para o tipo de busca
  LarrFiltros := FController.fGetViewControls.fParamsBusca(LTipoBusca);
  for LstrFiltro in LarrFiltros do
  begin
    if LstrFiltro.Equals('DTATRN') or LstrFiltro.Equals('DTAINI') then
      pnlDtaIni.visible := True;

    if LstrFiltro.Equals('DTAFIN') then
      pnlDtaFin.visible := True;

    if LstrFiltro.Equals('NUMNSU') then
      pnlNumNsu.visible := True;

    if LstrFiltro.Equals('NUMAUT') then
      pnlNumAutorizacao.visible := True;
  end;
end;

procedure TfrmTransacaoTef.pPreparaTiposConsulta;
var
  LTipoBusca: TTransacaoTefBuscaTipo;
  LintCount: Integer;
begin
  for LintCount := 0 to gbTipoBusca.ControlCount -1 do
  begin
    if not (gbTipoBusca.Controls[LintCount] is TRadioButton) then
      Continue;

    TRadioButton(gbTipoBusca.Controls[LintCount]).Visible := False;
    TRadioButton(gbTipoBusca.Controls[LintCount]).Checked := False;
  end;

  for LTipoBusca in FController.fGetViewControls.fTiposBuscaPermitidos do
  begin
    if LTipoBusca = tbTodas then
      rbTodas.Visible := True;

    if LTipoBusca = tbPendentes then
      rbPendentes.Visible := True;

    if LTipoBusca = tbEspecifica then
      rbEspecifica.Visible := True;
  end;

  for LintCount := 0 to gbTipoBusca.ControlCount -1 do
  begin
    if not (gbTipoBusca.Controls[LintCount] is TRadioButton) then
      Continue;

    if not TRadioButton(gbTipoBusca.Controls[LintCount]).Visible then
      Continue;

    TRadioButton(gbTipoBusca.Controls[LintCount]).Checked := True;
    //TRadioButton(gbTipoBusca.Controls[LintCount]).SetFocus;
    Break;
  end;
end;

procedure TfrmTransacaoTef.pPreparaGridTransacoes;
var
  LlstColunas: TStringList;
  LstrColuna: string;
  LintCount: Integer;
  LColuna: TcxGridDBColumn;
begin
  srcTransacoes.DataSet := FController.fGetDataset;
  srcTransacoes.DataSet.AfterScroll := AfterScrollConsulta;

  LlstColunas := TStringList.Create;
  try
    for LstrColuna in FController.fGetViewControls.fColunasGrid do
      LlstColunas.Add(LstrColuna);

    for LintCount := 0 to GridCitelTableView.ColumnCount - 1 do
    begin
      if not (GridCitelTableView.Columns[LintCount] is TcxGridDBBandedColumn) then
        Continue;

      LColuna := TcxGridDBColumn(GridCitelTableView.Columns[LintCount]);
      LColuna.Visible := LlstColunas.IndexOf(LColuna.DataBinding.FieldName.ToUpper) <> -1;
    end;
  finally
    FreeandNil(LlstColunas);
  end;
end;

procedure TfrmTransacaoTef.rbTodasClick(Sender: TObject);
begin
  inherited;
  pAjustaVisibilidadeCampos;
end;

procedure TfrmTransacaoTef.rbTodasKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    Key := #0;
  end;
end;

procedure TfrmTransacaoTef.RemoverFiltro(Sender: TObject);
var
  LRemoveFilter: Boolean;
  LParamsFilter: TTransacaoTefBuscaParam;
  LFilter: string;
begin
  LRemoveFilter := Trim(edtNumNsu.Text).IsEmpty and
    Trim(edtNumAutorizacao.Text).IsEmpty and
    (StrToFloatDef(edtVlrTransacao.Text, 0) = 0);

  if LRemoveFilter then
  begin
    if FController.fGetDataset.Filtered then
    begin
      FController.fGetDataset.Filtered := False;
      FController.fGetDataset.Filter := '';
    end;
    Exit;
  end;

  if (FController.fGetDataset.RecordCount > 0) or FController.fGetDataset.Filtered then
  begin
    LParamsFilter := fMontarParamBusca;
    LFilter := fFiltroConsulta(LParamsFilter);
    if LFilter <> FController.fGetDataset.Filter then
      FilterDataSet(LParamsFilter);
  end;

end;

procedure TfrmTransacaoTef.AfterScrollConsulta(DataSet: TDataSet);
var
  LTransacaoStatus: TTransacaoTefStatus;
begin
  try
    btnConfirma.Enabled := False;
    btnCancela.Enabled := False;
    btnImprimirComprovante.Enabled := False;

    if DataSet.IsEmpty then
      Exit;

    if not Assigned(FController) then
      Exit;

    LTransacaoStatus := FController.fGetTrn(Dataset.FieldByName('SEQTRN').AsInteger).Status;

    case LTransacaoStatus of
      stPendente:
      begin
        btnConfirma.Enabled := True;
        btnCancela.Enabled := True;
      end;
      stConfirmada, stEstorno:
        btnImprimirComprovante.Enabled := True;
    end;
  except
    on E: Exception do
      pMensagensErro(E.Message, '[AfterScrollConsulta]');
  end
end;

procedure TfrmTransacaoTef.pCopyDados(const ADataSet: TDataSet);
var
  LField : TField;
begin
  ADataSet.DisableControls;
  try
    if not cdsDadosRelatorio.Active then
      cdsDadosRelatorio.Open
    else
      cdsDadosRelatorio.EmptyDataSet;

    ADataSet.First;
    While not ADataSet.Eof do
    begin
      cdsDadosRelatorio.Append;
      for LField in ADataSet.Fields do
      begin
        if cdsDadosRelatorio.FindField(LField.FieldName) <> nil then
          cdsDadosRelatorio.FieldByName(LField.FieldName).Value := LField.Value;
      end;

      if cdsDadosRelatorio.Modified then
        cdsDadosRelatorio.Post
      else
        cdsDadosRelatorio.Cancel;

      ADataSet.Next;
    end;
  finally
    ADataSet.EnableControls;
  end;
end;

procedure TfrmTransacaoTef.pExportToPDF(const AArquivoSaidaPDF: string);
var
  LArquivo: string;
  LSaveDlg: TSaveDialog;
begin
  if cdsDadosRelatorio.IsEmpty then // programacao defensiva
  begin
    fMensagem('Aviso!', 'Nenhum dado disponível para exportar!', ['&Ok']);
    Exit;
  end;

  LArquivo := Trim(AArquivoSaidaPDF);
  if ( (not LArquivo.IsEmpty) and (not LArquivo.Contains('.pdf')) ) then
    LArquivo := LArquivo + '.pdf';

  LSaveDlg := TSaveDialog.Create(nil);
  try
    LSaveDlg.FileName := LArquivo;
    LSaveDlg.Filter := 'Arquivos PDF (*.pdf)|*.pdf';
    LSaveDlg.DefaultExt := 'pdf';
    LSaveDlg.Title := 'Exportar para PDF';

    LArquivo := EmptyStr;
    if LSaveDlg.Execute then
      LArquivo := LSaveDlg.FileName;
  finally
    FreeAndNil(LSaveDlg);
  end;

  if LArquivo = EmptyStr then
    Exit;

  frxPDFExport.ShowProgress := False;
  frxRelatorio.ShowProgress := False;
  frxPDFExport.ShowDialog := False;
  frxPDFExport.EmbeddedFonts := True;
  frxPDFExport.FileName := LArquivo;

  try
    if frxRelatorio.PrepareReport and frxRelatorio.Export(frxPDFExport) then
      pMensagemOk('Arquivo gerado com sucesso!');
  except
    raise;
  end;
end;

end.
