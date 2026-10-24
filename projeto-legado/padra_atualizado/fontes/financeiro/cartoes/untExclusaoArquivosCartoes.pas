unit untExclusaoArquivosCartoes;

interface

uses
  untPaiSimples, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore,
  cxDateUtils, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog,
  Data.DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Vcl.StdCtrls, EditFocus, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade,
  Vcl.AppEvnts, Vcl.Menus, Vcl.Controls, Vcl.Buttons, BitBtnLockedIncrem,
  System.Classes, untOperadorasExclusaoArquivosCartoes, untPaiOrdenaCxGrid,
  Datasnap.DBClient, UniClientDataSet, Datasnap.Provider,
  UniDataSetProvider, MemDS, DBAccess, Uni, cxGridCitel, cxCheckBox,
  cxProgressBar, cxImageComboBox, System.ImageList, Vcl.ImgList,
  untLiberacao;

type
  TExclusaoOperadorasCartoes = (
    eocCielo,
    eocGetNet);

  TfrmExcluirArquivosImportadosCartoes = class(TfrmPaiOrdenaCxGrid)
    btnConfirmar: TBitBtnLocked;
    dbgConsultaDadosDTAARQ: TcxGridDBColumn;
    dbgConsultaDadosNOMARQ: TcxGridDBColumn;
    dbgConsultaDadosMARCADO: TcxGridDBColumn;
    shpMultSel: TShape;
    btnMarcarTodas: TBitBtnLocked;
    btnDesmarcarTodas: TBitBtnLocked;
    dbgConsultaDadosCONCIL: TcxGridDBColumn;
    imgConcil: TImageList;
    lblPeriodoImportacao1: TLabel;
    lblPeriodoImportacao2: TLabel;
    lblNomeArquivo: TLabel;
    edtDtaImpIni: TcxDateEdit;
    edtDtaImpFin: TcxDateEdit;
    btnCarregar: TBitBtnLocked;
    edtNomeArquivo: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnCarregarClick(Sender: TObject);
    procedure dbgConsultaDadosMARCADOPropertiesEditValueChanged(
      Sender: TObject);
    procedure dbgConsultaDadosCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnMarcarTodasClick(Sender: TObject);
    procedure btnDesmarcarTodasClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbgConsultaDadosDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FOperadora: IOperadora;
    FQtdMarcados: Integer;
    FExcluidoComSucesso: Boolean;
    FLiberacao: TLiberacao;

    procedure pAbreConsulta;
    procedure pAtualizarSelecaoArquivos;
    procedure pConfigurarOperadora(AOperadora: TExclusaoOperadorasCartoes);

    function fDesmarcarTodas(AProgressBar: TcxProgressBar = nil): Boolean;
    function fExcluirArquivos(AProgressBar: TcxProgressBar = nil): Boolean;
    function fGridFocado: Boolean;
    function fLiberarExclusao(AMsgLiberacao: string): Boolean;
    function fMarcarRegistro: Boolean;
    function fMarcarTodas(AProgressBar: TcxProgressBar = nil): Boolean;
    function fParametrosEstaoValidos: Boolean;
    function fTemRegistrosFiltrados: Boolean;
    function fTemRegistrosMarcados: Boolean;
  protected
    function fGetSql(AUsarLike: Boolean): string; override;
    function fSetParametros: Boolean; override;
  public
    class procedure pAbrirForm(AOperadora: TExclusaoOperadorasCartoes); static;
  end;

implementation

{$R *.dfm}

uses
  System.DateUtils, System.SysUtils, Vcl.Graphics, untFuncoesSimples,
  untFuncoesConsulta, untGravando, untTypesSistema, cxGridDBDataDefinitions,
  Winapi.Windows;

const
  PARAM_DTAINI = 'DTAINI';
  PARAM_DTAFIN = 'DTAFIN';
  PARAM_DTAARQ = 'DTAARQ';
  PARAM_NOMARQ = 'NOMARQ';

class procedure TfrmExcluirArquivosImportadosCartoes.pAbrirForm(
  AOperadora: TExclusaoOperadorasCartoes);
var
  LFrmExcluirArquivosImportadosCartoes: TfrmExcluirArquivosImportadosCartoes;
begin
  pCriarFormularios(TfrmExcluirArquivosImportadosCartoes, LFrmExcluirArquivosImportadosCartoes);
  try
    try
      LFrmExcluirArquivosImportadosCartoes.pConfigurarOperadora(AOperadora);
      LFrmExcluirArquivosImportadosCartoes.ShowModal;
    except
      on E: Exception do
        pErro(E.Message);
    end;
  finally
    pFreeAndNil(LFrmExcluirArquivosImportadosCartoes);
  end;
end;

procedure TfrmExcluirArquivosImportadosCartoes.FormCreate(Sender: TObject);
begin
  inherited;

  blnTemSelecao := True;
  blnFecharComEscape := True;
  blnSelecionaComEnter := True;

  FOperadora := nil;
  btnConfirmar.Enabled := False;
  btnMarcarTodas.Enabled := False;
  btnDesmarcarTodas.Enabled := False;
  edtDtaImpIni.Date := VS_Date;
  edtDtaImpFin.Date := VS_Date;

  FQtdMarcados := 0;
  FExcluidoComSucesso := False;
  FLiberacao := TLiberacao.Create;
end;

procedure TfrmExcluirArquivosImportadosCartoes.FormDestroy(
  Sender: TObject);
begin
  inherited;

  if Assigned(FLiberacao) then
    FreeAndNil(FLiberacao);

  if (cdsConsulta.Active) then
  begin
    cdsConsulta.EmptyDataSet;
    cdsConsulta.Close;
  end;
end;

procedure TfrmExcluirArquivosImportadosCartoes.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if fGridFocado then
    if (Key = VK_RETURN) then
      if fMarcarRegistro then
        pAtualizarSelecaoArquivos;
  inherited;
end;

function TfrmExcluirArquivosImportadosCartoes.fSetParametros: Boolean;
begin
  Result := False;

  if not fParametrosEstaoValidos then
    Exit;

  qryConsulta.ParamByName(PARAM_DTAINI).AsDate := StrToDate(edtDtaImpIni.Text);
  qryConsulta.ParamByName(PARAM_DTAFIN).AsDate := StrToDate(edtDtaImpFin.Text);

  if not fEmptyStr(Trim(edtNomeArquivo.Text)) then
    qryConsulta.ParamByName(PARAM_NOMARQ).AsString := '%' + AnsiUpperCase(Trim(edtNomeArquivo.Text)) + '%';

  Result := True;
end;

function TfrmExcluirArquivosImportadosCartoes.fTemRegistrosFiltrados: Boolean;
begin
  Result := False;

  if (not cdsConsulta.Active) then
    Exit;

  if (cdsConsulta.IsEmpty) then
    Exit;

  Result := True;
end;

function TfrmExcluirArquivosImportadosCartoes.fTemRegistrosMarcados: Boolean;
begin
  Result := False;

  if (not fTemRegistrosFiltrados) then
    Exit;

  if (FQtdMarcados = 0) then
    Exit;

  Result := True;
end;

function TfrmExcluirArquivosImportadosCartoes.fParametrosEstaoValidos: Boolean;
var
  LDtaIni, LDtaFin: TDatetime;
begin
  Result := False;

  if not TryStrToDate(edtDtaImpIni.Text, LDtaIni) then
  begin
    fMensagem('Atenção', 'Data inicial do periodo de importação é inválida!', ['&OK']);
    Exit;
  end;

  if not TryStrToDate(edtDtaImpFin.Text, LDtaFin) then
  begin
    fMensagem('Atenção', 'Data inicial do periodo de importação é inválida!', ['&OK']);
    Exit;
  end;

  if Trunc(LDtaFin) < Trunc(LDtaIni) then
  begin
    fMensagem('Atenção', 'Data final é menor que o data inicial no periodo de importação!', ['&OK']);
    Exit;
  end;

  Result := True;
end;

procedure TfrmExcluirArquivosImportadosCartoes.pConfigurarOperadora(AOperadora: TExclusaoOperadorasCartoes);
begin
  case AOperadora of
    eocCielo:
      FOperadora := TCielo.Create;
    eocGetNet:
      FOperadora := TGetNet.Create;
  end;

  if not Assigned(FOperadora) then
    raise Exception.Create('Operadora de cartões não configurada.');

  Caption := FOperadora.NomeRotina;
  dbgConsultaDadosDTAARQ.DataBinding.FieldName := FOperadora.ColunaDTAARQ;
  dbgConsultaDadosNOMARQ.DataBinding.FieldName := FOperadora.ColunaNOMARQ;
  dbgConsultaDadosCONCIL.DataBinding.FieldName := FOperadora.ColunaCONCIL;
end;

function TfrmExcluirArquivosImportadosCartoes.fMarcarRegistro: Boolean;
var
  LMarcado: Boolean;
begin
  Result := False;

  if (not fTemRegistrosFiltrados) then
    Exit;

  LMarcado := cdsConsulta.FieldByName('MARCADO').AsInteger = 1;
  if not LMarcado then
  begin
    if cdsConsulta.FieldByName(FOperadora.ColunaCONCIL).AsInteger = 1 Then
    begin
      pMensagemOk('Não é permitido excluir arquivos já conciliados!');
      Exit;
    end;
  end;

  cdsConsulta.Edit;
  cdsConsulta.FieldByName('MARCADO').AsInteger := Integer(not LMarcado);
  cdsConsulta.Post;
  Result := True;
end;

procedure TfrmExcluirArquivosImportadosCartoes.btnCarregarClick(
  Sender: TObject);
begin
  inherited;

  try
    TfrmGravando.fExecutarModal(pAbreConsulta, 'Aguarde... Carregando arquivos.','');
  finally
    FQtdMarcados := 0;
    btnConfirmar.Enabled := False;
    btnMarcarTodas.Enabled := True;
    btnDesmarcarTodas.Enabled := False;

    if cdsConsulta.IsEmpty then
      pSetFocus(edtDtaImpIni)
    else
      pSetFocus(dbgConsulta);
  end;
end;

procedure TfrmExcluirArquivosImportadosCartoes.btnConfirmarClick(
  Sender: TObject);
var
  LMsgLiberacao, LMsgDialogo, LMsgSplash, LMsgSucesso: string;
begin
  inherited;

  if (not fTemRegistrosMarcados) then
  begin
    fMensagem('', 'Nenhum registro foi marcado para exclusão.', ['&Ok']);
    Exit;
  end;

  LMsgLiberacao := 'Permitir excluir registro de arquivo importado de cartão da operadora ' + FOperadora.NomeOperadora;
  LMsgDialogo   := 'Os registros do arquivo marcado serão excluídos. Deseja continuar?';
  LMsgSplash    := 'Aguarde... Excluindo registros do arquivo marcado.';
  LMsgSucesso   := 'Os registros do arquivo marcado foram excluídos com sucesso.';

  if (FQtdMarcados > 1) then
  begin
    LMsgLiberacao := 'Permitir excluir registros de arquivos de cartão importados da operadora ' + FOperadora.NomeOperadora;
    LMsgDialogo   := 'Confirma excluir todos os arquivos marcados?';
    LMsgSplash    := 'Aguarde... Excluindo registros dos arquivos marcados.';
    LMsgSucesso   := 'Os registros dos arquivos marcados foram excluídos com sucesso.';
  end;

  if (not fLiberarExclusao(LMsgLiberacao)) or (fMensagem('', LMsgDialogo, ['&Sim', '&Não']) = 2) then
    Exit;

  FExcluidoComSucesso := False;
  pCriarFormularios(TfrmGravando, frmGravando);
  try
    frmGravando.fExecutarAcao := fExcluirArquivos;
    frmGravando.lblGravando.Caption := LMsgSplash;
    frmGravando.ShowModal;
  finally
    pFreeAndNil(frmGravando);
  end;

  if FExcluidoComSucesso then
  begin
    fMensagem('AVISO', LMsgSucesso, ['&Ok']);
    cdsConsulta.EmptyDataSet;
    pSetFocus(edtDtaImpIni);
  end;
end;

procedure TfrmExcluirArquivosImportadosCartoes.btnDesmarcarTodasClick(
  Sender: TObject);
begin
  inherited;

  if (not fTemRegistrosMarcados) then
  begin
    fMensagem('', 'É necessário ter arquivos para desmarcar!', ['&Ok']);
    Exit;
  end;

  if (fMensagem('', 'Confirma desmarcar todos os arquivos?', ['&Sim', '&Não']) = 2) then
    Exit;

  pCriarFormularios(TfrmGravando,frmGravando);
  try
    frmGravando.fExecutarAcao := fDesmarcarTodas;
    frmGravando.lblGravando.Caption := 'Aguarde... Desmarcando arquivos.';
    frmGravando.ShowModal;
  finally
    pFreeAndNil(frmGravando);
  end;
end;

procedure TfrmExcluirArquivosImportadosCartoes.btnMarcarTodasClick(
  Sender: TObject);
begin
  inherited;

  if (not fTemRegistrosFiltrados) then
  begin
    fMensagem('', 'É necessário ter registros para marcar!', ['&Ok']);
    Exit;
  end;

  if (fMensagem('', 'Confirma marcar todos os arquivos?', ['&Sim', '&Não']) = 2) then
    Exit;

  pCriarFormularios(TfrmGravando, frmGravando);
  try
    frmGravando.fExecutarAcao := fMarcarTodas;
    frmGravando.lblGravando.Caption := 'Aguarde... Marcando arquivos.';
    frmGravando.ShowModal;
  finally
    pFreeAndNil(frmGravando);
  end;
end;

procedure TfrmExcluirArquivosImportadosCartoes.dbgConsultaDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  LMarcado: Boolean;
begin
  inherited;

  LMarcado := Sender.DataController.Values[
    AViewInfo.GridRecord.RecordIndex,
    dbgConsultaDadosMARCADO.Index] = 1;

  if LMarcado then
    ACanvas.Font.Color := clBlue;
end;

procedure TfrmExcluirArquivosImportadosCartoes.dbgConsultaDadosDblClick(
  Sender: TObject);
begin
  if fMarcarRegistro then
  begin
    pAtualizarSelecaoArquivos;
    inherited;
  end;
end;

procedure TfrmExcluirArquivosImportadosCartoes.dbgConsultaDadosMARCADOPropertiesEditValueChanged(
  Sender: TObject);
begin
  if (dbgConsultaDados.DataController.LockCount > 0) then
    Exit;

  dbgConsultaDados.DataController.BeginUpdate;
  try
    if fMarcarRegistro then
      pAtualizarSelecaoArquivos
    else
      TcxCheckBox(Sender).Reset;
  finally
    dbgConsultaDados.EndUpdate;
  end;
end;

function TfrmExcluirArquivosImportadosCartoes.fDesmarcarTodas(
  AProgressBar: TcxProgressBar): Boolean;
var
  LScroll: TprcScroll;
begin
  Result := False;
  try
    pDisableControls(cdsConsulta, LScroll);
    cdsConsulta.First;
    AProgressBar.Position := 0;
    AProgressBar.Properties.Max := cdsConsulta.RecordCount;

    while not cdsConsulta.Eof Do
    Begin
      pStepStatusGravacao(AProgressBar);

      if (cdsConsulta.FieldByName('MARCADO').AsInteger = 1) then
      begin
        cdsConsulta.Edit;
        cdsConsulta.FieldByName('MARCADO').AsInteger := 0;
        cdsConsulta.Post;
      end;

      cdsConsulta.Next;
    end;
  finally
    cdsConsulta.First;
    pEnableControls(cdsConsulta, LScroll);
    pAtualizarSelecaoArquivos;
  end;
end;

function TfrmExcluirArquivosImportadosCartoes.fExcluirArquivos(
  AProgressBar: TcxProgressBar): Boolean;
var
  LScroll: TprcScroll;
  LDelete: TUniQuery;
begin
  Result := False;
  pDisableControls(cdsConsulta, LScroll);
  LDelete := fCriaQuery;
  try
    AProgressBar.Position := 0;
    AProgressBar.Properties.Max := FQtdMarcados;
    LDelete.SQL.Text :=
      ' DELETE FROM ' + FOperadora.Tabela +
      ' WHERE ' + FOperadora.ColunaDTAARQ + ' = :'+PARAM_DTAARQ+
      '   AND ' + FOperadora.ColunaNOMARQ + ' = :'+PARAM_NOMARQ;

    fStartTransaction;
    try
      cdsConsulta.First;
      while not cdsConsulta.Eof do
      begin
        if cdsConsulta.FieldByName('MARCADO').AsInteger <> 1 then
        begin
          cdsConsulta.Next;
          Continue;
        end;

        if cdsConsulta.FieldByName(FOperadora.ColunaCONCIL).AsInteger <> 0 then
        begin
          cdsConsulta.Next;
          Continue;
        end;

        pStepStatusGravacao(AProgressBar);

        LDelete.Close;
        LDelete.ParamByName(PARAM_DTAARQ).AsDate := cdsConsulta.FieldByName(FOperadora.ColunaDTAARQ).AsDatetime;
        LDelete.ParamByName(PARAM_NOMARQ).AsString := cdsConsulta.FieldByName(FOperadora.ColunaNOMARQ).AsString;
        LDelete.ExecSQL;

        cdsConsulta.Next;
      end;

      fCommit;
      Result := True;
      FExcluidoComSucesso := True;
    except
      on E: Exception do
      begin
        fRollback;
        pMensagensErro(
          'Ocorreu um erro ao excluir os registros marcados!' + #13 + E.Message,
          '[TfrmExcluirArquivosImportadosCartoes.fExcluirArquivos]');
        Exit;
      end;
    end;
  finally
    pEnableControls(cdsConsulta, LScroll);
    FreeAndNil(LDelete);
  end;
end;

function TfrmExcluirArquivosImportadosCartoes.fGetSql(
  AUsarLike: Boolean): string;
begin
  Result :=
    ' SELECT '+
        'CONCAT('+
          FOperadora.ColunaNOMARQ+ ', ' +
          '"-", '+
          'DATE_FORMAT('+FOperadora.ColunaDTAARQ+', "%s/%m/%Y")) AS AUTOINCREM, '+
        '0 AS MARCADO, '+
        FOperadora.ColunaNOMARQ + ', '+
        FOperadora.ColunaDTAARQ + ', '+
        'MAX(' + FOperadora.ColunaCONCIL + ') AS ' + FOperadora.ColunaCONCIL +
    ' FROM '+
        FOperadora.Tabela +
    ' WHERE '+
        FOperadora.ColunaDTAARQ + ' BETWEEN :' + PARAM_DTAINI + ' AND :' + PARAM_DTAFIN;

  if not fEmptyStr(Trim(edtNomeArquivo.Text)) then
  begin
    Result := Result +
      ' AND UPPER(' + FOperadora.ColunaNOMARQ + ') LIKE :' + PARAM_NOMARQ;
  end;

  Result := Result +
    ' GROUP BY ' + string.Join(',', [FOperadora.ColunaDTAARQ, FOperadora.ColunaNOMARQ]) +
    ' ORDER BY ' + string.Join(',', [FOperadora.ColunaDTAARQ, FOperadora.ColunaNOMARQ]);
end;

function TfrmExcluirArquivosImportadosCartoes.fGridFocado: Boolean;
begin
  Result := False;

  if (cdsConsulta.RecordCount = 0) then
    Exit;

  if (not dbgConsulta.Focused) then
    Exit;

  if (not dbgConsultaDados.Focused) then
    Exit;

  Result := True;
end;

function TfrmExcluirArquivosImportadosCartoes.fLiberarExclusao(AMsgLiberacao: string): Boolean;
begin
  FLiberacao.Clear;
  FLiberacao.objMsgLibera.pAddTexto(AMsgLiberacao);
  FLiberacao.strDirAce := FOperadora.DireitoAcesso;
  FLiberacao.strMsgSen := FOperadora.NomeRotina;
  FLiberacao.strCodOpe := strLoginUsuarioLogado;
  FLiberacao.strCodDig := strLoginUsuarioLogado;
  FLiberacao.pInformaNumDocEspDocCodEmp(EmptyStr, EmptyStr, VS_strCodEmp);
  Result := FLiberacao.fLibera;
end;

function TfrmExcluirArquivosImportadosCartoes.fMarcarTodas(
  AProgressBar: TcxProgressBar): Boolean;
var
  LScroll: TprcScroll;
  LQtdConciliados: Integer;
  LRegistroConciliado, LRegistroMarcado: Boolean;
begin
  Result := True;
  LQtdConciliados := 0;
  pDisableControls(cdsConsulta, LScroll);
  cdsConsulta.First;
  AProgressBar.Position := 0;
  AProgressBar.Properties.Max := cdsConsulta.RecordCount;
  try
    while not cdsConsulta.Eof do
    begin
      pStepStatusGravacao(AProgressBar);
      LRegistroMarcado := cdsConsulta.FieldByName('MARCADO').AsInteger = 1;
      LRegistroConciliado := cdsConsulta.FieldByName(FOperadora.ColunaCONCIL).AsInteger <> 0;
      LQtdConciliados := LQtdConciliados + Integer(LRegistroConciliado);

      if ((not LRegistroConciliado) and (not LRegistroMarcado)) then
      begin
        cdsConsulta.Edit;
        cdsConsulta.FieldByName('MARCADO').AsInteger := 1;
        cdsConsulta.Post;
      end;

      cdsConsulta.Next;
    end;
  finally
    cdsConsulta.First;
    pEnableControls(cdsConsulta, LScroll);
    pAtualizarSelecaoArquivos;
  end;

  if (LQtdConciliados = 1) then
    pMensagemOK('um registro não foi marcado porque está conciliado.')
  else if (LQtdConciliados > 1) then
    pMensagemOK(Format('%d registros não foram marcados porque estão conciliados.', [LQtdConciliados]));
end;

procedure TfrmExcluirArquivosImportadosCartoes.pAtualizarSelecaoArquivos;
var
  LScroll: TprcScroll;
  LRecNoBkp, LQtdConciliados, LQtdRegistros: Integer;
begin
  if (not cdsConsulta.Active) then
    Exit;

  FQtdMarcados := 0;
  LQtdConciliados := 0;
  LQtdRegistros := cdsConsulta.RecordCount;
  pDisableControls(cdsConsulta, LScroll);
  LRecNoBkp := cdsConsulta.RecNo;
  try
    if (LQtdRegistros = 0) then
      Exit;

    cdsConsulta.First;
    while not cdsConsulta.Eof do
    begin
      FQtdMarcados := FQtdMarcados + cdsConsulta.FieldByName('MARCADO').AsInteger;
      LQtdConciliados := LQtdConciliados + cdsConsulta.FieldByName(FOperadora.ColunaCONCIL).AsInteger;
      cdsConsulta.Next;
    end;
  finally
    cdsConsulta.RecNo := LRecNoBkp;
    pEnableControls(cdsConsulta, LScroll);
    btnConfirmar.Enabled := (FQtdMarcados > 0);
    btnMarcarTodas.Enabled := (FQtdMarcados < (LQtdRegistros - LQtdConciliados));
    btnDesmarcarTodas.Enabled := (FQtdMarcados > 0);
  end;
end;

procedure TfrmExcluirArquivosImportadosCartoes.pAbreConsulta;
begin
  inherited fAbreConsulta;
end;

end.

