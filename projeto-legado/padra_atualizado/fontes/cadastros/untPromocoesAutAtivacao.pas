unit untPromocoesAutAtivacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, ComboBoxFocus, EditFocus, Vcl.Mask, MaskEditFocus,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, cxProgressBar,
  UniClientDataSet, untTypesSistema, System.UITypes, Vcl.ComCtrls,
  untCadPromocoes, untPromocoesAutResumo, untCadPromocoesAut;

type
  TfrmPromocoesAutAtivacao = class(TfrmPai)
    Panel1: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    edtDtaCadInicial: TMaskEditFocus;
    edtDtaCadFinal: TMaskEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    edtDtaAltInicial: TMaskEditFocus;
    edtDtaAltFinal: TMaskEditFocus;
    lbl3: TLabel;
    edtCodPpa: TEditFocus;
    edtDesPpa: TEditFocus;
    Label3: TLabel;
    cmbStatus: TComboBoxFocus;
    btnConfirmar: TBitBtnLocked;
    btnCancelar: TBitBtnLocked;
    grdDados: TcxGridCitel;
    grdDadosTv: TcxGridDBTableViewCitel;
    grdDadosTvCODPPA: TcxGridDBColumn;
    grdDadosTvDESPPA: TcxGridDBColumn;
    grdDadosTvDTACAD: TcxGridDBColumn;
    grdDadosTvDTAALT: TcxGridDBColumn;
    grdDadosLv: TcxGridLevel;
    grdDadosTvSTATUS: TcxGridDBColumn;
    grdDadosTvDTAATI: TcxGridDBColumn;
    btnAtivar: TBitBtnLocked;
    btnCadastro: TBitBtnLocked;
    dtsDados: TDataSource;
    grdDadosTvMARDES: TcxGridDBColumn;
    procedure btnSairClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtCodPpaExit(Sender: TObject);
    procedure edtCodPpaKeyPress(Sender: TObject; var Key: Char);
    procedure grdDadosTvSTATUSGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure grdDadosTvKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdDadosTvCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnAtivarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCadastroClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FarrPromocoes: TConsultasArray;
    FcdsDados: TUniClientDataSet;
    FStlMsgAtivacao: TStringList;
    FintPrecisaoDescontoItem: Integer;

    FpgbStatus: TcxProgressBar;

    function fConsultaPromocoes(pgbStatus: TcxProgressBar): Boolean;
    procedure pMarcaDesmarca;
    function fTemPromocaoSelecionada: Boolean;
    function fQuantidadePromocaoSelecionada: Integer;

    function fAtivaPromocoes(pgbStatus: TcxProgressBar): Boolean;

    function fAtivaPromocao(strAutInc: String): Boolean;

    function fSimulaInclusao(qryCadPpa, qryPpaVal, qryPpaIte, qryPpaCli, qryPpaCnd: TDataSet): Boolean;

    procedure OnMensagemAoUsuario(AMsg: String);
    procedure OnMensagemDeErro(AMsg: String);
    procedure OnMensagemAguarde(AMsg: String);

    procedure pLimpaMensagens;

    function fVincularPromocao(const strAutIncVpa, strCodPro: String): Boolean;
    function fSetAtivacao(const strAutIncPpa: String): Boolean;
    function fExcluirVinculo(const frmCadPromocoes: TfrmCadPromocoes; const strCodPro: String): Boolean;

    procedure pPreencheDadosGerais(const frmCadPromocoes: TfrmCadPromocoes; qryCadPpa, qryPpaVal: TDataSet);
    procedure pPreencheEmpresas(const frmCadPromocoes: TfrmCadPromocoes; qryCadPpa: TDataSet);
    procedure pPreencheTabelasPreco(const frmCadPromocoes: TfrmCadPromocoes; qryCadPpa: TDataSet);
    procedure pPreencheItens(const frmCadPromocoes: TfrmCadPromocoes; qryPpaIte: TDataSet);
    procedure pPreencheClientes(const frmCadPromocoes: TfrmCadPromocoes; qryPpaCli: TDataSet);
    procedure pPreencheCondicoes(const frmCadPromocoes: TfrmCadPromocoes; qryPpaCnd: TDataSet);
    function fSqlPpaIte: String;
  public
    { Public declarations }
    FfrmPromocoesAutResumo: TfrmPromocoesAutResumo;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses
  untGravando, untFuncoesSimples, untFuncoesConsulta, untConsultas, Uni, untConstantes;

{$R *.dfm}

procedure TfrmPromocoesAutAtivacao.btnAtivarClick(Sender: TObject);
var
  frmGravando: TfrmGravando;
begin
  inherited;

  If (not fTemPromocaoSelecionada) Then
  begin
    fMensagem('','Não existe nenhuma promoção selecionada no grid!',['&OK']);
    Exit;
  end;

  pCriarFormularios(TfrmGravando, frmGravando);
  try
    frmGravando.fExecutarAcao := fAtivaPromocoes;
    frmGravando.FForcarExibirMensagemAguarde := True;
    frmGravando.ShowModal;
  finally
    pFreeAndNil(frmGravando);
  end;

end;

procedure TfrmPromocoesAutAtivacao.btnCadastroClick(Sender: TObject);
var
  frmCadPromocoesAut: TfrmCadPromocoesAut;
begin
  inherited;

  if not fVerificaAcessoSistema('frmCadPromocoesAut') then
  begin
    fMensagem('', 'Esse usuário não tem direito a acessar esse módulo!', ['&Ok']);
    Exit;
  end;

  If (not fTemPromocaoSelecionada) Then
  begin
    fMensagem('"Atenção!','Selecione uma linha no grid para abrir o cadastro da promoção automatizada.',['&OK']);
    Exit;
  end;

  if fQuantidadePromocaoSelecionada > 1 then
  begin
    fMensagem('"Atenção!','Selecione apenas uma linha no grid para abrir o cadastro da promoção automatizada!',['&OK']);
    Exit;
  end;

  FcdsDados.Filtered := False;
  try
    FcdsDados.Filter := 'MARDES = ' + QuotedStr('M');
    FcdsDados.Filtered := True;

    pCriarFormularios(TfrmCadPromocoesAut, frmCadPromocoesAut);
    try
      frmCadPromocoesAut.FstrAutInc := FcdsDados.FieldByName('AUTOINCREM').AsString;
      frmCadPromocoesAut.ShowModal;
    finally
      pFreeAndNil(frmCadPromocoesAut);
    end;
  finally
    FcdsDados.Filtered := False;
  end;

  btnConfirmar.Click;

end;

procedure TfrmPromocoesAutAtivacao.btnCancelarClick(Sender: TObject);
begin
  inherited;
  edtDtaCadInicial.Clear;
  edtDtaCadFinal.Clear;
  edtDtaAltInicial.Clear;
  edtDtaAltFinal.Clear;
  edtCodPpa.Clear;
  edtDesPpa.Clear;
  cmbStatus.ItemIndex := -1;
  pSetFocus(edtDtaCadInicial);
end;

procedure TfrmPromocoesAutAtivacao.btnConfirmarClick(Sender: TObject);
var
  frmGravando: TfrmGravando;
begin
  inherited;

  If (not fVerificaCampos) then
    Exit;

  pCriarFormularios(TfrmGravando, frmGravando);
  try
    frmGravando.fExecutarAcao := fConsultaPromocoes;
    frmGravando.ShowModal;
  finally
    pFreeAndNil(frmGravando);
  end;
end;

procedure TfrmPromocoesAutAtivacao.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmPromocoesAutAtivacao.edtCodPpaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodPpa, edtDesPpa, FarrPromocoes, fRetDescPromocaoAutomatizada, Nil, 'da Promoção');
end;

procedure TfrmPromocoesAutAtivacao.edtCodPpaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqPromocoesAutomatizadas(Self, edtCodPpa, edtDesPpa, Nil, Key, FarrPromocoes, False) Then
  Begin
    fValidaCampos(edtCodPpa, False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmPromocoesAutAtivacao.fAtivaPromocoes(
  pgbStatus: TcxProgressBar): Boolean;
begin
  pInfoStatusGravacao(pgbStatus, 'Aguarde, Ativando Promoções...');
  Result := False;

  FpgbStatus := pgbStatus;

  FcdsDados.DisableControls;
  try
    FcdsDados.Filtered := False;
    FcdsDados.Filter := 'MARDES = ' + QuotedStr('M');
    FcdsDados.Filtered := True;
    FcdsDados.First;

    pCriarFormularios(TfrmPromocoesAutResumo, FfrmPromocoesAutResumo);
    try
      while not FcdsDados.Eof do
      begin
        Result := fAtivaPromocao(FcdsDados.FieldByName('AUTOINCREM').AsString);

        FcdsDados.Next;
      end;

      FfrmPromocoesAutResumo.trvMenu.FullExpand;
      FfrmPromocoesAutResumo.ShowModal;
    finally
      pFreeAndNil(FfrmPromocoesAutResumo);
    end;

    btnConfirmar.Click;

  finally
    FcdsDados.Filtered := False;
    FcdsDados.EnableControls;

    FpgbStatus := nil;
  end;
end;

function TfrmPromocoesAutAtivacao.fConsultaPromocoes(
  pgbStatus: TcxProgressBar): Boolean;
const CAMPO_STATUS =
  '  IF(PPA_DTAATI IS NULL, ' +
  '    "2", '                 + // Promoção não ativada
  '    IF(TIMESTAMP(PPA_DTAALT, PPA_HORALT) > TIMESTAMP(PPA_DTAATI, PPA_HORATI), ' +
  '      "3", '               + // Promoção ativada, porém com alterações que ainda não foram ativadas
  '      "1" '                + // Promoção ativada
  '    ) '                    +
  '  ) ';
var
  strSQL: String;
  strLin: String;
  qrySelect: TUniQuery;
begin
  Result := False;
  pInfoStatusGravacao(pgbStatus, 'Aguarde, Carregando Promoções Automatizadas...');

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  "D" AS MARDES, ';
  strSQL := strSQL + '  AUTOINCREM, ';
  strSQL := strSQL + '  PPA_CODPPA, ';
  strSQL := strSQL + '  PPA_DESPPA, ';
  strSQL := strSQL + '  PPA_DTACAD, ';
  strSQL := strSQL + '  PPA_DTAALT, ';
  strSQL := strSQL + '  PPA_DTAALT, ';
  strSQL := strSQL + '  PPA_DTAATI, ';

  strSQL := strSQL + CAMPO_STATUS + ' AS STATUS ';

  strSQL := strSQL + 'FROM CADPPA ';
  strSQL := strSQL + 'WHERE TRUE ';

  if not fEmptyStr(fTiraCaracEspeciais(edtDtaCadFinal.Text)) then
    strSQL := strSQL + '  AND PPA_DTACAD BETWEEN :DTACADINI AND :DTACADFIM ';

  if not fEmptyStr(fTiraCaracEspeciais(edtDtaAltFinal.Text)) then
    strSQL := strSQL + '  AND PPA_DTAALT BETWEEN :DTAALTINI AND :DTAALTFIM ';

  strSQL := strSQL + fStrLocate(edtCodPpa, FarrPromocoes, 'PPA_CODPPA', 'CODPPA');

  if cmbStatus.ItemIndex > -1 then
    strSQL := strSQL + '  AND ' + CAMPO_STATUS + ' = :STATUS ';

  if Assigned(FcdsDados) then
    FreeAndNil(FcdsDados);

  qrySelect := fCriaQuery;
  try
    qrySelect.SQL.Text := strSQL;

    if not fEmptyStr(fTiraCaracEspeciais(edtDtaCadFinal.Text)) then
    begin
      qrySelect.ParamByName('DTACADINI').AsDateTime := StrToDate(edtDtaCadInicial.Text);
      qrySelect.ParamByName('DTACADFIM').AsDateTime := StrToDate(edtDtaCadFinal.Text);
    end;

    if not fEmptyStr(fTiraCaracEspeciais(edtDtaAltFinal.Text)) then
    begin
      qrySelect.ParamByName('DTAALTINI').AsDateTime := StrToDate(edtDtaAltInicial.Text);
      qrySelect.ParamByName('DTAALTFIM').AsDateTime := StrToDate(edtDtaAltFinal.Text);
    end;

    pSetaParam(edtCodPpa.Text, FarrPromocoes, strLin, 'CODPPA', qrySelect);

    if cmbStatus.ItemIndex > -1 then
      qrySelect.ParamByName('STATUS').AsString := IntToStr(cmbStatus.ItemIndex+1);

    qrySelect.Open;

    FcdsDados := fCriaClientDatset(qrySelect);
  finally
    FreeAndNil(qrySelect);
  end;

  dtsDados.DataSet := FcdsDados;
  FcdsDados.First;
  pSetFocus(grdDados);
end;

function TfrmPromocoesAutAtivacao.fExcluirVinculo(
  const frmCadPromocoes: TfrmCadPromocoes; const strCodPro: String): Boolean;
var
  qryTabela: TUniQuery;
begin
  if fEmptyStr(strCodPro) then
    Exit(True);

  qryTabela := TUniQuery(frmCadPromocoes.dtsCadPromocoes.DataSet);

  if qryTabela.Active then
    qryTabela.Close;
  qryTabela.SQL.Text := 'SELECT * FROM CADPRO WHERE PRO_CODPRO = :CODPRO';
  qryTabela.ParamByName('CODPRO').AsString := strCodPro;
  qryTabela.Open;

  frmCadPromocoes.pCarregaDados;

  frmCadPromocoes.btnExcluir.Click;
  Result := True;
end;

procedure TfrmPromocoesAutAtivacao.FormCreate(Sender: TObject);
begin
  inherited;
  FStlMsgAtivacao := TStringList.Create;
  FintPrecisaoDescontoItem := fRetPrecisaoDescontoItem;
end;

procedure TfrmPromocoesAutAtivacao.FormDestroy(Sender: TObject);
begin
  inherited;

  FreeAndNil(FStlMsgAtivacao);

  if Assigned(FcdsDados) then
    FreeAndNil(FcdsDados);
end;

procedure TfrmPromocoesAutAtivacao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_F5 then
    btnCadastro.Click
  else
  if Key = VK_F10 then
    btnAtivar.Click;
end;

procedure TfrmPromocoesAutAtivacao.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodPpa);
end;

function TfrmPromocoesAutAtivacao.fQuantidadePromocaoSelecionada: Integer;
begin
  Result := 0;

  if (Not Assigned(FcdsDados)) then
    Exit;

  if (Not FcdsDados.Active) then
    Exit;

  if (FcdsDados.IsEmpty) then
    Exit;

  FcdsDados.DisableControls;
  try
    FcdsDados.Filtered := False;
    FcdsDados.Filter := 'MARDES = ' + QuotedStr('M');
    FcdsDados.Filtered := True;

    Result := FcdsDados.RecordCount;
  finally
    FcdsDados.Filtered := False;
    FcdsDados.EnableControls;
  end;
end;

function TfrmPromocoesAutAtivacao.fTemPromocaoSelecionada: Boolean;
begin
  Result := fQuantidadePromocaoSelecionada > 0 ;
end;

function TfrmPromocoesAutAtivacao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtDtaCadFinal) and blnBuscaPorChave Then
  Begin
    If (not fEmptyStr(fTiraCaracEspeciais(edtDtaCadFinal.Text))) then
    begin
      if (fEmptyStr(fTiraCaracEspeciais(edtDtaCadInicial.Text))) Then
      begin
        fMensagem('ATENÇÃO!', 'A data inicial do Período de Cadastro deve ser deve ser preenchida!', ['&O k']);
        pSetFocus(edtDtaCadInicial);
      end
      else If Not fValidaPeriodo(edtDtaCadInicial.Text, edtDtaCadFinal.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data final do Período de Cadastro deve ser maior ou igual à data inicial!', ['&O k']);
        Result := False;
      End;
    end;
  End

  Else If (Sender = edtDtaAltFinal) and blnBuscaPorChave Then
  Begin
    If (not fEmptyStr(fTiraCaracEspeciais(edtDtaAltFinal.Text))) then
    begin
      if (fEmptyStr(fTiraCaracEspeciais(edtDtaAltInicial.Text))) Then
      begin
        fMensagem('ATENÇÃO!', 'A data inicial do Período da Última Alteração deve ser deve ser preenchida!', ['&O k']);
        pSetFocus(edtDtaAltInicial);
      end
      else If Not fValidaPeriodo(edtDtaAltInicial.Text, edtDtaAltFinal.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data final do Período da Última Alteração deve ser maior ou igual à data inicial!', ['&O k']);
        Result := False;
      End;
    end;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmPromocoesAutAtivacao.grdDadosTvSTATUSGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  case StrToIntDef(AText, 0) of
    1: AText := 'Promoção ativada';
    2: AText := 'Promoção não ativada';
    3: AText := 'Promoção ativada, mas com alterações pendentes de ativação';
  end;
end;

procedure TfrmPromocoesAutAtivacao.grdDadosTvCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If (Not Assigned(FcdsDados)) Or (Not FcdsDados.Active) Then
    Exit;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDadosTvSTATUS.Index]) = '1' Then
    ACanvas.Brush.Color := $00B7F9A4
  Else If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDadosTvSTATUS.Index]) = '2' Then
    ACanvas.Brush.Color := $0080FFFF
  Else If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDadosTvSTATUS.Index]) = '3' Then
    ACanvas.Brush.Color := $00F0CAA6;

  ACanvas.Font.Color := clBlack;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDadosTvMARDES.Index]) = 'M' Then
  Begin
    If ACanvas.Brush.Color = clHighlight Then
      ACanvas.Font.Color := clLime
    Else
    begin
      ACanvas.Brush.Color := clSkyBlue;
      ACanvas.Font.Color := clBlue;
    end;
  End;
end;

procedure TfrmPromocoesAutAtivacao.grdDadosTvKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
    pMarcaDesmarca;
end;

function TfrmPromocoesAutAtivacao.fSqlPpaIte: String;
var
  strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  PPAITE.*, ';
  strSQL := strSQL + '  CADITE.ITE_CODITE AS CODITE, ';
  strSQL := strSQL + '  CADITE.ITE_CODFAB AS CODFAB, ';
  strSQL := strSQL + '  CADITE.ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '  CADITE.ITE_CODGRU AS CODGRU, ';
  strSQL := strSQL + '  UNI_SIGUNI AS UNIDAD, ';
  strSQL := strSQL + '  MAR_DESMAR AS DESMAR, ';
  strSQL := strSQL + '  (ITEGER.ITE_SALDOS + ITEGER.ITE_QTEF_A + ITEGER.ITE_QTEF_F + ITEGER.ITE_QTEF_P + ITEGER.ITE_QTPDBF) AS ITE_SALFIS, ';
  strSQL := strSQL + fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS, ';
  strSQL := strSQL + '  ITEGER.ITE_PRECUS AS PRECUS, ';
  strSQL := strSQL + '  ITEGER.ITE_MARBR1 AS MARBR1, ';
  strSQL := strSQL + '  ITEGER.ITE_PREVE1 AS PREVE1, ';
  strSQL := strSQL + '  ITEGER.ITE_MARBR2 AS MARBR2, ';
  strSQL := strSQL + '  ITEGER.ITE_PREVE2 AS PREVE2, ';
  strSQL := strSQL + '  ITEGER.ITE_MARBR3 AS MARBR3, ';
  strSQL := strSQL + '  ITEGER.ITE_PREVE3 AS PREVE3, ';
  strSQL := strSQL + '  ITEGER.ITE_MARBR4 AS MARBR4, ';
  strSQL := strSQL + '  ITEGER.ITE_PREVE4 AS PREVE4, ';
  strSQL := strSQL + '  ITEGER.ITE_MARBR5 AS MARBR5, ';
  strSQL := strSQL + '  ITEGER.ITE_PREVE5 AS PREVE5, ';
  strSQL := strSQL + '  ITEGER.ITE_MARBR6 AS MARBR6, ';
  strSQL := strSQL + '  ITEGER.ITE_PREVE6 AS PREVE6, ';
  strSQL := strSQL + '  ITEGER.ITE_MARBR7 AS MARBR7, ';
  strSQL := strSQL + '  ITEGER.ITE_PREVE7 AS PREVE7, ';
  strSQL := strSQL + '  ITEGER.ITE_PREMED AS PREMED, ';
  strSQL := strSQL + '  ITEGER.ITE_PREULT AS PREULT, ';
  strSQL := strSQL + '  ITEGER.ITE_IMPULT AS IMPULT, ';
  strSQL := strSQL + '  ITEGER.ITE_OUTVAL AS OUTVAL, ';
  strSQL := strSQL + '  ITEGER.ITE_ICMSAI AS ICMSAI, ';
  strSQL := strSQL + '  ITEGER.ITE_IMPFED AS IMPFED, ';
  strSQL := strSQL + '  ITEGER.ITE_DESOPE AS DESOPE, ';
  strSQL := strSQL + '  ITEGER.ITE_COMTB1 AS COMTB1, ';
  strSQL := strSQL + '  ITEGER.ITE_COMTB2 AS COMTB2, ';
  strSQL := strSQL + '  ITEGER.ITE_COMTB3 AS COMTB3, ';
  strSQL := strSQL + '  ITEGER.ITE_COMTB4 AS COMTB4, ';
  strSQL := strSQL + '  ITEGER.ITE_COMTB5 AS COMTB5, ';
  strSQL := strSQL + '  ITEGER.ITE_COMTB6 AS COMTB6, ';
  strSQL := strSQL + '  ITEGER.ITE_COMTB7 AS COMTB7, ';
  strSQL := strSQL + '  ITEGER.ITE_COMVAR AS COMVAR, ';
  strSQL := strSQL + '  ITEGER.ITE_COMATA AS COMATA, ';
  strSQL := strSQL + '  ITEGER.ITE_COMDIS AS COMDIS, ';

  strSQL := strSQL + '  ITE_IPIENT AS IPIENT, ';
  strSQL := strSQL + '  ITE_PRECOM AS PRECOM, ';
  strSQL := strSQL + '  ITE_DESF01 AS DESF01, ';
  strSQL := strSQL + '  ITE_DESF02 AS DESF02, ';
  strSQL := strSQL + '  ITE_DESF03 AS DESF03, ';
  strSQL := strSQL + '  ITE_DESF04 AS DESF04, ';
  strSQL := strSQL + '  ITE_DESF05 AS DESF05, ';
  strSQL := strSQL + '  ITE_DESF06 AS DESF06, ';
  strSQL := strSQL + '  ITE_PREDOL AS PREDOL, ';

  If (fCfgSis('TIPABF') = '1') Then
    strSQL := strSQL + ' CADITE.ITE_CODABF AS CODABF '
  Else
    strSQL := strSQL + ' ITEGER.ITE_CODABF AS CODABF ';

  strSQL := strSQL + '  FROM PPAITE ';
  strSQL := strSQL + ' INNER JOIN CADITE ON CADITE.ITE_CODITE = PPAITE.IPA_CODITE ';
  strSQL := strSQL + ' INNER JOIN ITEGER ON ITEGER.ITE_CODITE = CADITE.ITE_CODITE ';
  strSQL := strSQL + '                  AND ITEGER.ITE_CODEMP = PPAITE.IPA_CODEMP ';
  strSQL := strSQL + ' INNER JOIN CADMAR ON CADITE.ITE_CODMAR = CADMAR.MAR_CODMAR ';
  strSQL := strSQL + ' INNER JOIN CADUNI ON CADITE.ITE_CODUNI = CADUNI.UNI_CODUNI ';
  strSQL := strSQL + ' WHERE CADITE.ITE_ITEATI = "S" ';
  strSQL := strSQL + '   AND IPA_SEQPPA = :SEQPPA ';

  Result := strSQL;
End;

function TfrmPromocoesAutAtivacao.fAtivaPromocao(strAutInc: String): Boolean;
const
  SQL_CLI =
    ' SELECT PPACLI.*, CLI_NOMCLI'+
    ' FROM PPACLI'+
    ' LEFT JOIN CADCLI ON CLI_CODCLI = CPA_CODCLI'+
    ' WHERE CPA_SEQPPA = :SEQPPA';
var
  qryCadPpa,
  qryPpaVal,
  qryPpaIte,
  qryPpaCli,
  qryPpaCnd: TUniQuery;
  intQtdeErro: Integer;
  nodePpa,
  nodeVpa: TTreeNode;
  I: Integer;
  blnOk: Boolean;
begin
  qryCadPpa := fCriaQuery;
  qryPpaVal := fCriaQuery;
  qryPpaIte := fCriaQuery;
  qryPpaCli := fCriaQuery;
  qryPpaCnd := fCriaQuery;
  try
    pInfoStatusGravacao(FpgbStatus, 'Aguarde, Buscando informações...');
    qryCadPpa.SQL.Add('SELECT * FROM CADPPA WHERE AUTOINCREM = :AUTINC');
    qryCadPpa.ParamByName('AUTINC').AsString := strAutInc;
    qryCadPpa.Open;

    qryPpaVal.SQL.Add('SELECT * FROM PPAVAL WHERE VPA_SEQPPA = :SEQPPA');
    qryPpaVal.ParamByName('SEQPPA').AsString := strAutInc;
    qryPpaVal.Open;

    qryPpaIte.SQL.Add(fSqlPpaIte);
    qryPpaIte.ParamByName('SEQPPA').AsString := strAutInc;
    qryPpaIte.Open;

    qryPpaCli.SQL.Add(SQL_CLI);
    qryPpaCli.ParamByName('SEQPPA').AsString := strAutInc;
    qryPpaCli.Open;

    qryPpaCnd.SQL.Add('SELECT * FROM PPACND WHERE NPA_SEQPPA = :SEQPPA');
    qryPpaCnd.ParamByName('SEQPPA').AsString := strAutInc;
    qryPpaCnd.Open;

    intQtdeErro := 0;
    nodePpa := FfrmPromocoesAutResumo.fAddItem('Promoção automatizada: ' + qryCadPpa.FieldByName('PPA_CODPPA').AsString + ' - ' + qryCadPpa.FieldByName('PPA_DESPPA').AsString, Nil);

    fStartTransaction;

    while not qryPpaVal.Eof do
    begin
      blnOk := fSimulaInclusao(qryCadPpa, qryPpaVal, qryPpaIte, qryPpaCli, qryPpaCnd);

      if not blnOk then
      begin
        Inc(intQtdeErro);
        FfrmPromocoesAutResumo.pSetError(nodePpa);
      end;

      nodeVpa := FfrmPromocoesAutResumo.fAddItem(
        fPadR(qryPpaVal.FieldByName('VPA_CODPRO').AsString, 8) +
        ' - ' +
        fPadR(qryPpaVal.FieldByName('VPA_DESVPA').AsString, 80) +
        ' - Validade: ' +
        qryPpaVal.FieldByName('VPA_DTAINI').AsString +
        ' à ' +
        qryPpaVal.FieldByName('VPA_DTAFIN').AsString
        , nodePpa, blnOk);

      for I := 0 to Pred(FStlMsgAtivacao.Count) do
        FfrmPromocoesAutResumo.fAddItem(FStlMsgAtivacao[I], nodeVpa, blnOk, True);

      qryPpaVal.Next;
    end;

    Result := intQtdeErro = 0;

    if Result then
    begin
      fSetAtivacao(strAutInc);

      fCommit;
    end
    else
      fRollBack;

  finally
    FreeAndNil(qryCadPpa);
    FreeAndNil(qryPpaVal);
    FreeAndNil(qryPpaIte);
    FreeAndNil(qryPpaCli);
    FreeAndNil(qryPpaCnd);
  end;
end;

procedure TfrmPromocoesAutAtivacao.pMarcaDesmarca;
begin
  If (Not Assigned(FcdsDados)) Or (Not FcdsDados.Active) Then
    Exit;

  FcdsDados.Edit;
  FcdsDados.FieldByName('MARDES').AsString := IIF(FcdsDados.FieldByName('MARDES').AsString = 'D', 'M', 'D');
  FcdsDados.Post;
end;

procedure TfrmPromocoesAutAtivacao.pPreencheClientes(
  const frmCadPromocoes: TfrmCadPromocoes; qryPpaCli: TDataSet);
var
  strCodIte: String;
  strMsgCliente, strMsgTmp: String;
  strEmpresasSelecionadas: String;
  strTabelasPrecoSelecionadas: String;
begin
  pInfoStatusGravacao(FpgbStatus, 'Aguarde, Incluindo Clientes...', qryPpaCli.RecordCount);

  strCodIte := frmCadPromocoes.fVerificaProdutos(Nil);
  strEmpresasSelecionadas := frmCadPromocoes.fGetEmpresasSelecionadas;
  strTabelasPrecoSelecionadas := frmCadPromocoes.fGetTabelasPrecoSelecionadas;
  strMsgCliente := '';

  qryPpaCli.First;
  while not qryPpaCli.Eof do
  begin
    strMsgTmp := '';

    frmCadPromocoes.pIncluirClienteAutomatizada(
      qryPpaCli.FieldByName('CPA_CODCLI').AsString,
      qryPpaCli.FieldByName('CLI_NOMCLI').AsString,
      strCodIte,
      strEmpresasSelecionadas,
      strTabelasPrecoSelecionadas,
      strMsgTmp);

    if not fEmptyStr(strMsgTmp) then
      strMsgCliente := strMsgCliente + strMsgTmp;

    qryPpaCli.Next;
    pStepStatusGravacao(FpgbStatus);
  end;

  if not fEmptyStr(strMsgCliente) then
    FStlMsgAtivacao.Add(
      'Cliente(s) não incluído(s)! ' +
      'O(s) cliente(s) abaixo já estão em outras promoções' + frmCadPromocoes.fMsgTabloid() + ' vigentes:' + sLineBreak +
      'Cliente: ' + #13#10 + strMsgCliente);
end;

procedure TfrmPromocoesAutAtivacao.pPreencheCondicoes(
  const frmCadPromocoes: TfrmCadPromocoes; qryPpaCnd: TDataSet);
begin
  qryPpaCnd.First;
  pInfoStatusGravacao(FpgbStatus, 'Aguarde, Incluindo Condições de Pagamentos...', qryPpaCnd.RecordCount);
  while not qryPpaCnd.Eof do
  begin
    frmCadPromocoes.edtCodCnd.Text := qryPpaCnd.FieldByName('NPA_CODCND').AsString;
    frmCadPromocoes.edtJurRem.Text := qryPpaCnd.FieldByName('NPA_JURREM').AsString;
    frmCadPromocoes.btnIncCndPag.Click;

    qryPpaCnd.Next;
    pStepStatusGravacao(FpgbStatus);
  end;
end;

procedure TfrmPromocoesAutAtivacao.pPreencheDadosGerais(
  const frmCadPromocoes: TfrmCadPromocoes; qryCadPpa, qryPpaVal: TDataSet);
var
  LDataSet: TDataSet;
begin
  LDataSet := frmCadPromocoes.dtsCadPromocoes.DataSet;

  LDataSet.FieldByName('PRO_DESPRO').Value := qryPpaVal.FieldByName('VPA_DESVPA').Value;
  LDataSet.FieldByName('PRO_DTAINI').Value := qryPpaVal.FieldByName('VPA_DTAINI').Value;
  LDataSet.FieldByName('PRO_DTAFIN').Value := qryPpaVal.FieldByName('VPA_DTAFIN').Value;

  LDataSet.FieldByName('PRO_CODEMP').Value := qryCadPpa.FieldByName('PPA_CODEMP').Value;
  LDataSet.FieldByName('PRO_PREDES').Value := 'D';
  LDataSet.FieldByName('PRO_TABPRE').Value := qryCadPpa.FieldByName('PPA_TABPRE').Value;
  LDataSet.FieldByName('PRO_ENTFUT').Value := qryCadPpa.FieldByName('PPA_ENTFUT').Value;
  LDataSet.FieldByName('PRO_DESADI').Value := 'N';
  LDataSet.FieldByName('PRO_QTDLIM').Value := 0;
  LDataSet.FieldByName('PRO_QTDMIN').Value := 0;
  LDataSet.FieldByName('PRO_IDXPRO').Value := 1;
  LDataSet.FieldByName('PRO_ENTIME').Value := qryCadPpa.FieldByName('PPA_ENTIME').Value;
  LDataSet.FieldByName('PRO_COMPRO').Value := qryCadPpa.FieldByName('PPA_COMPRO').Value;
  LDataSet.FieldByName('PRO_COMSAL').Value := qryCadPpa.FieldByName('PPA_COMSAL').Value;
  LDataSet.FieldByName('PRO_IDXQTD').Value := qryCadPpa.FieldByName('PPA_IDXQTD').Value;
  LDataSet.FieldByName('PRO_ECOMME').Value := qryCadPpa.FieldByName('PPA_ECOMME').Value;
  LDataSet.FieldByName('PRO_RESNCO').Value := qryCadPpa.FieldByName('PPA_RESNCO').Value;
  LDataSet.FieldByName('PRO_TABLOI').Value := 'N';
  LDataSet.FieldByName('PRO_PROPRE').Value := qryCadPpa.FieldByName('PPA_PROPRE').Value;
  LDataSet.FieldByName('PRO_TRAPRO').Value := qryCadPpa.FieldByName('PPA_TRAPRO').Value;

  If Not LDataSet.FieldByName('PRO_IDXPRO').IsNull Then
    frmCadPromocoes.rdgPreDes.ItemIndex := LDataSet.FieldByName('PRO_IDXPRO').AsInteger
  Else If (LDataSet.FieldByName('PRO_PREDES').AsString = 'D') Then
    frmCadPromocoes.rdgPreDes.ItemIndex := IDX_TIPO_DESCONTO_PROMOCAO[tdpDescon]
  Else If (LDataSet.FieldByName('PRO_DESADI').AsString = 'S') Then
    frmCadPromocoes.rdgPreDes.ItemIndex := IDX_TIPO_DESCONTO_PROMOCAO[tdpPrecosDescAdicional]
  Else If (LDataSet.FieldByName('PRO_PREDES').AsString = 'P') Then
    frmCadPromocoes.rdgPreDes.ItemIndex := IDX_TIPO_DESCONTO_PROMOCAO[tdpPrecos];

  If (LDataSet.FieldByName('PRO_COMPRO').AsString = 'P') Then
    frmCadPromocoes.rdgComPro.ItemIndex := 0
  Else
    frmCadPromocoes.rdgComPro.ItemIndex := 1;

  frmCadPromocoes.rdgQtdLim.ItemIndex := LDataSet.FieldByName('PRO_IDXQTD').AsInteger;

  frmCadPromocoes.chkEntIme.Checked := LDataSet.FieldByName('PRO_ENTIME').AsString = 'S';
  frmCadPromocoes.chkEntFut.Checked := LDataSet.FieldByName('PRO_ENTFUT').AsString = 'S';
  frmCadPromocoes.chkEcommerce.Checked := LDataSet.FieldByName('PRO_ECOMME').AsString = 'S';
end;

procedure TfrmPromocoesAutAtivacao.pPreencheEmpresas(
  const frmCadPromocoes: TfrmCadPromocoes; qryCadPpa: TDataSet);
var
  strEmpresas: String;
begin
  strEmpresas := fCampoTabela('GROUP_CONCAT(EPA_CODEMP)', 'PPAEMP', ['EPA_SEQPPA'], [qryCadPpa.FieldByName('AUTOINCREM').AsString]);

  frmCadPromocoes.pMarcarEmpresas(strEmpresas);
end;

procedure TfrmPromocoesAutAtivacao.pPreencheItens(
  const frmCadPromocoes: TfrmCadPromocoes; qryPpaIte: TDataSet);
var
  Parametro: TParametroProduto;
  strMsgProJaInc,
  strMsgProIncOu,
  strMsgItemEstr01,
  strMsgItemEstr02,
  strMsgProSemEstoque: String;
  strMsgTmp: String;
  strEmpresasSelecionadas: String;
  strTabelasPrecoSelecionadas: String;
begin
  If (not frmCadPromocoes.fVerificaEmpresas()) then
    Exit;

  If (not frmCadPromocoes.fVerificaCamposTela()) Then
    Exit;

  strMsgProJaInc := '';
  strMsgProIncOu := '';
  strMsgItemEstr01 := '';
  strMsgItemEstr02 := '';
  strMsgProSemEstoque := '';

  strEmpresasSelecionadas := frmCadPromocoes.fGetEmpresasSelecionadas;
  strTabelasPrecoSelecionadas := frmCadPromocoes.fGetTabelasPrecoSelecionadas;

  qryPpaIte.First;
  pInfoStatusGravacao(FpgbStatus, 'Aguarde, Incluindo Itens...', qryPpaIte.RecordCount);
  while not qryPpaIte.Eof do
  begin
    Parametro.strCodIte    := qryPpaIte.FieldByName('CODITE').AsString;
    Parametro.strDesIte    := qryPpaIte.fieldbyname('DESITE').AsString;
    Parametro.strCodFab    := qryPpaIte.fieldbyname('CODFAB').AsString;
    Parametro.strUnidad    := qryPpaIte.fieldbyname('UNIDAD').AsString;
    Parametro.strDesmar    := qryPpaIte.fieldbyname('DESMAR').AsString;
    Parametro.strSalFis    := qryPpaIte.fieldbyname('ITE_SALFIS').AsString;
    Parametro.strSalDis    := qryPpaIte.fieldbyname('ITE_SALDIS').AsString;
    Parametro.fltQtdMin    := qryPpaIte.FieldByName('IPA_QTDMIN').AsFloat;
    Parametro.fltQtdLim    := qryPpaIte.FieldByName('IPA_QTDLIM').AsFloat;
    Parametro.fltDesAdi    := fStrToFloat(frmCadPromocoes.edtDesAdi.Text);
    Parametro.intTabPre    := StrToIntDef(frmCadPromocoes.cmbTabPre.Text,0);
    Parametro.fltComVarIte := qryPpaIte.fieldbyname('COMVAR').AsFloat;
    Parametro.fltComVarEdt := qryPpaIte.FieldByName('IPA_COMVAR').AsFloat;
    Parametro.fltPerEst    := fStrToFloat(frmCadPromocoes.edtPerEst.Text);
    Parametro.fltComAtaIte := qryPpaIte.fieldbyname('COMATA').AsFloat;
    Parametro.fltComAtaEdt := qryPpaIte.FieldByName('IPA_COMATA').AsFloat;
    Parametro.fltComDisIte := qryPpaIte.fieldbyname('COMDIS').AsFloat;
    Parametro.fltComDisEdt := qryPpaIte.FieldByName('IPA_COMDIS').AsFloat;
    Parametro.intPrzMed    := qryPpaIte.FieldByName('IPA_PRZMED').AsInteger;
    Parametro.fltPreCusEdt := qryPpaIte.FieldByName('IPA_PRECUS').AsFloat;
    Parametro.fltPreVenEdt := qryPpaIte.FieldByName('IPA_PREVEN').AsFloat;
    Parametro.fltPerDes    := qryPpaIte.FieldByName('IPA_PERDES').AsFloat;
    Parametro.fltPreVe1    := qryPpaIte.fieldbyname('PREVE1').AsFloat;
    Parametro.fltPreVe2    := qryPpaIte.fieldbyname('PREVE2').AsFloat;
    Parametro.fltPreVe3    := qryPpaIte.fieldbyname('PREVE3').AsFloat;
    Parametro.fltPreVe4    := qryPpaIte.fieldbyname('PREVE4').AsFloat;
    Parametro.fltPreVe5    := qryPpaIte.fieldbyname('PREVE5').AsFloat;
    Parametro.fltPreVe6    := qryPpaIte.fieldbyname('PREVE6').AsFloat;
    Parametro.fltPreVe7    := qryPpaIte.fieldbyname('PREVE7').AsFloat;
    Parametro.fltPreCusIte := qryPpaIte.fieldbyname('PRECUS').AsFloat;
    Parametro.fltOutVal    := qryPpaIte.fieldbyname('OUTVAL').AsFloat;
    Parametro.fltIcmSai    := qryPpaIte.fieldbyname('ICMSAI').AsFloat;
    Parametro.fltImpFed    := qryPpaIte.fieldbyname('IMPFED').AsFloat;
    Parametro.fltDesOpe    := qryPpaIte.fieldbyname('DESOPE').AsFloat;
    Parametro.fltComTb1    := qryPpaIte.fieldbyname('COMTB1').AsFloat;
    Parametro.fltComTb2    := qryPpaIte.fieldbyname('COMTB2').AsFloat;
    Parametro.fltComTb3    := qryPpaIte.fieldbyname('COMTB3').AsFloat;
    Parametro.fltComTb4    := qryPpaIte.fieldbyname('COMTB4').AsFloat;
    Parametro.fltComTb5    := qryPpaIte.fieldbyname('COMTB5').AsFloat;
    Parametro.fltComTb6    := qryPpaIte.fieldbyname('COMTB6').AsFloat;
    Parametro.fltComTb7    := qryPpaIte.fieldbyname('COMTB7').AsFloat;
    Parametro.fltMarBr1    := qryPpaIte.fieldbyname('MARBR1').AsFloat;
    Parametro.fltMarBr2    := qryPpaIte.fieldbyname('MARBR2').AsFloat;
    Parametro.fltMarBr3    := qryPpaIte.fieldbyname('MARBR3').AsFloat;
    Parametro.fltMarBr4    := qryPpaIte.fieldbyname('MARBR4').AsFloat;
    Parametro.fltMarBr5    := qryPpaIte.fieldbyname('MARBR5').AsFloat;
    Parametro.fltMarBr6    := qryPpaIte.fieldbyname('MARBR6').AsFloat;
    Parametro.fltMarBr7    := qryPpaIte.fieldbyname('MARBR7').AsFloat;
    Parametro.fltPreMed    := qryPpaIte.fieldbyname('PREMED').AsFloat;
    Parametro.fltPreUlt    := qryPpaIte.fieldbyname('PREULT').AsFloat;
    Parametro.fltImpUlt    := qryPpaIte.fieldbyname('IMPULT').AsFloat;
    Parametro.fltIpiEnt    := qryPpaIte.fieldbyname('IPIENT').AsFloat;
    Parametro.fltPreCom    := qryPpaIte.fieldbyname('PRECOM').AsFloat;
    Parametro.fltDesF01    := qryPpaIte.fieldbyname('DESF01').AsFloat;
    Parametro.fltDesF02    := qryPpaIte.fieldbyname('DESF02').AsFloat;
    Parametro.fltDesF03    := qryPpaIte.fieldbyname('DESF03').AsFloat;
    Parametro.fltDesF04    := qryPpaIte.fieldbyname('DESF04').AsFloat;
    Parametro.fltDesF05    := qryPpaIte.fieldbyname('DESF05').AsFloat;
    Parametro.fltDesF06    := qryPpaIte.fieldbyname('DESF06').AsFloat;
    Parametro.strPreDol    := qryPpaIte.fieldbyname('PREDOL').AsString;
    Parametro.strCodAbf    := qryPpaIte.fieldbyname('CODABF').AsString;
    Parametro.strCodCli    := '';
    Parametro.strEmpresasSelecionadas := strEmpresasSelecionadas;
    Parametro.strTabelasPrecoSelecionadas := strTabelasPrecoSelecionadas;

    frmCadPromocoes.pIncluirProdutoAutomatizada(
      strMsgProJaInc,
      strMsgProIncOu,
      strMsgItemEstr01,
      strMsgItemEstr02,
      strMsgProSemEstoque,
      Parametro);

    qryPpaIte.Next;

    pStepStatusGravacao(FpgbStatus);
  end;

  If (Not fEmptyStr(strMsgProJaInc + strMsgProIncOu + strMsgItemEstr01 + strMsgItemEstr02 + strMsgProSemEstoque)) Then
  Begin
    strMsgTmp := 'O(s) item(s) abaixo possuem as seguintes observações:' + sLineBreak;

    If Not fEmptyStr(strMsgProIncOu) Then
      strMsgTmp := strMsgTmp +' - '+'Produtos que estão vigentes em outras promoções' + frmCadPromocoes.fMsgTabloid() + ': ' + #13#10 + strMsgProIncOu + #13#10;

    If Not fEmptyStr(strMsgProJaInc) Then
      strMsgTmp := strMsgTmp +' - '+'Produtos que estão vigente nesta promoção: ' + #13#10 + strMsgProJaInc + #13#10;

    If Not fEmptyStr(strMsgProSemEstoque) Then
      strMsgTmp := strMsgTmp +' - '+'Produtos sem quantidade limite para promoção: ' + #13#10 + strMsgProSemEstoque + #13#10;

    If Not fEmptyStr(strMsgItemEstr01) Then
      strMsgTmp := strMsgTmp +' - '+
             'Quando o sistema está configurado para sugerir o preço de venda do produto principal da estrutura '+
             '(CFG_SUGVLE-'+fRetNomCfg('SUGVLE')+'), no faturamento é carregado os sub-produtos (CFG_CAREST-'+fRetNomCfg('CAREST')+') e o sistema está configurado '+
             'para não ratear o valor sugerido entre os itens (CFG_RATEST-'+fRetNomCfg('RATEST')+'), não é permitido inserir na promoção o item estrutura. Cadastre a promoção para os sub-produtos.'+#13#10+
             'Itens Estrutura: '+strMsgItemEstr01+#13#10+#13#10+'Você pode consultar a estrutura completa no botão específico nesta tela.';

    If Not fEmptyStr(strMsgItemEstr02) Then
      strMsgTmp := strMsgTmp +' - '+
             'Quando o sistema está configurado para sugerir o preço de venda dos sub-produtos (CFG_SUGVLE-'+fRetNomCfg('SUGVLE')+') '+
             'e no faturamento é carregado o item estrutura (CFG_CAREST-'+fRetNomCfg('CAREST')+'), não é permitido inserir na promoção o item estrutura. Cadastre a promoção para os sub-produtos.'+#13#10+
             'Itens Estrutura: '+strMsgItemEstr02+#13#10+#13#10+'Você pode consultar a estrutura completa no botão específico nesta tela.';

    FStlMsgAtivacao.Add(strMsgTmp);
  End;

end;

procedure TfrmPromocoesAutAtivacao.pPreencheTabelasPreco(
  const frmCadPromocoes: TfrmCadPromocoes; qryCadPpa: TDataSet);
begin
  frmCadPromocoes.pMarcarTabelasPreco(qryCadPpa.FieldByName('PPA_TABPRE').AsString);
end;

function TfrmPromocoesAutAtivacao.fVincularPromocao(
  const strAutIncVpa, strCodPro: String): Boolean;
Var
  qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();
  try
    qryGen.SQL.Add('UPDATE PPAVAL SET VPA_CODPRO = :CODPRO WHERE AUTOINCREM = :AUTINC');

    qryGen.ParamByName('AUTINC').AsString := strAutIncVpa;
    qryGen.ParamByName('CODPRO').AsString := strCodPro;

    qryGen.ExecSQL;

    Result := qryGen.RowsAffected = 1;
  finally
    FreeAndNil(qryGen);
  end;
end;

procedure TfrmPromocoesAutAtivacao.OnMensagemAguarde(AMsg: String);
begin

end;

procedure TfrmPromocoesAutAtivacao.OnMensagemAoUsuario(AMsg: String);
begin
  if FStlMsgAtivacao.IndexOf(AMsg) = -1 then
    FStlMsgAtivacao.Add(AMsg);
end;

procedure TfrmPromocoesAutAtivacao.OnMensagemDeErro(AMsg: String);
begin
  if FStlMsgAtivacao.IndexOf(AMsg) = -1 then
    FStlMsgAtivacao.Add(AMsg);
end;

function TfrmPromocoesAutAtivacao.fSetAtivacao(
  const strAutIncPpa: String): Boolean;
Var
  qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();
  try
    qryGen.SQL.Add('UPDATE CADPPA SET');
    qryGen.SQL.Add('  PPA_DTAATI = :DTAATI,');
    qryGen.SQL.Add('  PPA_HORATI = :HORATI');
    qryGen.SQL.Add('WHERE AUTOINCREM = :AUTINC');

    qryGen.ParamByName('AUTINC').AsString   := strAutIncPpa;
    qryGen.ParamByName('DTAATI').AsDateTime := fNow;
    qryGen.ParamByName('HORATI').AsDateTime := fNow;

    qryGen.ExecSQL;

    Result := qryGen.RowsAffected = 1;
  finally
    FreeAndNil(qryGen);
  end;
end;

function TfrmPromocoesAutAtivacao.fSimulaInclusao(qryCadPpa,
  qryPpaVal, qryPpaIte, qryPpaCli, qryPpaCnd: TDataSet): Boolean;
var
  frmCadPromocoes: TfrmCadPromocoes;
begin
  pInfoStatusGravacao(FpgbStatus, 'Aguarde, Ativando Promoção...');
  frmCadPromocoes := TfrmCadPromocoes.Create(Nil);

  VS_ExibirMensagemAoUsuario := False;
  VS_ExibirMensagemDeErro    := False;
  VS_ExibirMensagemAguarde   := False;

  VS_OnMensagemDeErro    := OnMensagemDeErro;
  VS_OnMensagemAoUsuario := OnMensagemAoUsuario;
  VS_OnMensagemAguarde   := OnMensagemAguarde;

  try
    FStlMsgAtivacao.Clear;

    frmCadPromocoes.FblnAutomatizada := True;
    frmCadPromocoes.Show;
    frmCadPromocoes.Hide;

    fExcluirVinculo(frmCadPromocoes, qryPpaVal.FieldByName('VPA_CODPRO').AsString);

    frmCadPromocoes.btnIncluir.Click;

    pPreencheDadosGerais(frmCadPromocoes, qryCadPpa, qryPpaVal);
    pPreencheEmpresas(frmCadPromocoes, qryCadPpa);
    pPreencheTabelasPreco(frmCadPromocoes, qryCadPpa);
    pPreencheItens(frmCadPromocoes, qryPpaIte);
    pPreencheClientes(frmCadPromocoes, qryPpaCli);
    pPreencheCondicoes(frmCadPromocoes, qryPpaCnd);

    pInfoStatusGravacao(FpgbStatus, 'Aguarde, Ativando Promoção...');
    frmCadPromocoes.btnGravar.Click;

    pLimpaMensagens;

    Result := FStlMsgAtivacao.Count = 0;
    if Result then
      if fVincularPromocao(
        qryPpaVal.FieldByName('AUTOINCREM').AsString,
        frmCadPromocoes.dtsCadPromocoes.DataSet.FieldByName('PRO_CODPRO').AsString) then
        qryPpaVal.Refresh;

  finally
    pFreeAndNil(frmCadPromocoes);
    VS_ExibirMensagemAoUsuario := True;
    VS_ExibirMensagemDeErro    := True;
    VS_ExibirMensagemAguarde   := True;

    VS_OnMensagemDeErro    := nil;
    VS_OnMensagemAoUsuario := nil;
    VS_OnMensagemAguarde   := nil;
  end;
end;

procedure TfrmPromocoesAutAtivacao.pLimpaMensagens;
const
  MSG_DELETE: Array[0..1] Of String = (
    'Confirma? [ Sim ] ',
    'Deseja realmente excluir o cadastro completo da promoção? [ Sim ] ');
var
  intIdx: Integer;
  intContador: Integer;
begin
  for intContador := Low(MSG_DELETE) to High(MSG_DELETE) do
  begin
    intIdx := FStlMsgAtivacao.IndexOf(MSG_DELETE[intContador]);
    if intIdx >= 0 then
      FStlMsgAtivacao.Delete(intIdx);
  end;
end;


end.
