unit untCieloExcluirArquivosImportadosCartoes;

interface

uses Vcl.Graphics, Data.DB, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.AppEvnts,
     Vcl.Menus, Vcl.Controls, Vcl.Buttons, System.Classes, System.ImageList,
     Vcl.ImgList, System.DateUtils, System.SysUtils, Winapi.Windows,

     Uni, UniClientDataSet, cxControls, cxLookAndFeels, cxProgressBar,
     cxImageComboBox, cxCheckBox, cxLookAndFeelPainters, cxContainer, cxEdit,
     Vcl.ComCtrls, dxCore, cxDateUtils, cxStyles, cxCustomData, cxFilter, cxData,
     cxDataStorage, cxGraphics, cxGridCitel, cxGridDBTableView, cxGrid,
     cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog,
     cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
     cxGridTableView, frxClass, frxExportCSVTestabilidade, BitBtnLockedIncrem,
     EditFocus, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
     cxGridDBDataDefinitions,

     untLibCartoesPaiSimples, untTCieloFuncoes, untCieloTipos,
     untLibCartoesInterfacesTipos;

type
  TfrmCieloExcluirArquivosImportadosCartoes = class(TfrmPaiSimples)
    btnConfirmar: TBitBtnLocked;
    btnMarcarTodas: TBitBtnLocked;
    btnDesmarcarTodas: TBitBtnLocked;
    imgConcil: TImageList;
    pnlHeader: TPanel;
    lblPeriodoImportacao1: TLabel;
    lblPeriodoImportacao2: TLabel;
    lblNomeArquivo: TLabel;
    edtDtaImpIni: TcxDateEdit;
    edtDtaImpFin: TcxDateEdit;
    btnCarregar: TBitBtnLocked;
    edtNomeArquivo: TEditFocus;
    dbgConsulta: TcxGridCitel;
    dbgConsultaDados: TcxGridDBTableViewCitel;
    dbgConsultaDadosMARCADO: TcxGridDBColumn;
    dbgConsultaDadosDTAARQ: TcxGridDBColumn;
    dbgConsultaDadosNOMARQ: TcxGridDBColumn;
    dbgConsultaDadosCONCIL: TcxGridDBColumn;
    dbgConsultaNivel: TcxGridLevel;
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
    procedure FormShow(Sender: TObject);
  private
    FDatasetRegistros: TUniClientDataset;
    FDataSource: TDataSource;

    FOperadora: IOperadora;
    FQtdMarcados: Integer;
    FExcluidoComSucesso: Boolean;

    procedure pAbreConsulta;
    procedure pAtualizarSelecaoArquivos;

    function fDesmarcarTodas(AProgressBar: TcxProgressBar = nil): Boolean;
    function fExcluirArquivos(AProgressBar: TcxProgressBar = nil): Boolean;
    function fGridFocado: Boolean;
    function fLiberarExclusao(AMsgLiberacao: string): Boolean;
    function fMarcarRegistro: Boolean;
    function fMarcarTodas(AProgressBar: TcxProgressBar = nil): Boolean;
    function fParametrosEstaoValidos: Boolean;
    function fTemRegistrosFiltrados: Boolean;
    function fTemRegistrosMarcados: Boolean;

    function fGetSql(AUsarLike: Boolean): string;
    function fSetParametros(var ADataset: TUniQuery): Boolean;
  public
    procedure pConfigurarOperadora;
  end;

implementation

{$R *.dfm}

const
  PARAM_DTAINI = 'DTAINI';
  PARAM_DTAFIN = 'DTAFIN';
  PARAM_DTAARQ = 'DTAARQ';
  PARAM_NOMARQ = 'NOMARQ';

procedure TfrmCieloExcluirArquivosImportadosCartoes.FormCreate(Sender: TObject);
begin
  inherited;

  FOperadora := nil;
  btnConfirmar.Enabled := False;
  btnMarcarTodas.Enabled := False;
  btnDesmarcarTodas.Enabled := False;
  edtDtaImpIni.Date := VS_FuncoesExternas.fIGetVS_Date;
  edtDtaImpFin.Date := VS_FuncoesExternas.fIGetVS_Date;

  FQtdMarcados := 0;
  FExcluidoComSucesso := False;
end;

procedure TfrmCieloExcluirArquivosImportadosCartoes.FormDestroy(
  Sender: TObject);
begin
  inherited;

  if Assigned(FDatasetRegistros) then
  begin
    FDatasetRegistros.Close;
    FreeAndNil(FDatasetRegistros);
  end;
end;

procedure TfrmCieloExcluirArquivosImportadosCartoes.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if fGridFocado then
    if (Key = VK_RETURN) then
      if fMarcarRegistro then
        pAtualizarSelecaoArquivos;

  if (Key = VK_F10) then
    btnConfirmar.Click
  Else If (Key = VK_F7) then
    btnMarcarTodas.Click
  Else If (Key = VK_F8) then
    btnDesmarcarTodas.Click
  Else If (Key = VK_ESCAPE) then
    btnSair.Click
  Else
    inherited;
end;

procedure TfrmCieloExcluirArquivosImportadosCartoes.FormShow(Sender: TObject);
begin
  inherited;
  TCieloFuncoes.pSetFocus(edtDtaImpIni);
end;

function TfrmCieloExcluirArquivosImportadosCartoes.fSetParametros(
  var ADataset: TUniQuery): Boolean;
begin
  Result := False;

  if not fParametrosEstaoValidos then
    Exit;

  ADataset.ParamByName(PARAM_DTAINI).AsDate := StrToDate(edtDtaImpIni.Text);
  ADataset.ParamByName(PARAM_DTAFIN).AsDate := StrToDate(edtDtaImpFin.Text);

  if not TCieloFuncoes.fEmptyStr(Trim(edtNomeArquivo.Text)) then
    ADataset.ParamByName(PARAM_NOMARQ).AsString := '%' + AnsiUpperCase(Trim(edtNomeArquivo.Text)) + '%';

  Result := True;
end;

function TfrmCieloExcluirArquivosImportadosCartoes.fTemRegistrosFiltrados: Boolean;
begin
  Result := False;

  If Not Assigned(FDatasetRegistros) Then
    Exit;

  if (not FDatasetRegistros.Active) then
    Exit;

  Result := Not FDatasetRegistros.IsEmpty;
end;

function TfrmCieloExcluirArquivosImportadosCartoes.fTemRegistrosMarcados: Boolean;
begin
  Result := False;

  if (not fTemRegistrosFiltrados) then
    Exit;

  if (FQtdMarcados = 0) then
    Exit;

  Result := True;
end;

function TfrmCieloExcluirArquivosImportadosCartoes.fParametrosEstaoValidos: Boolean;
var
  LDtaIni, LDtaFin: TDatetime;
begin
  Result := False;

  if not TryStrToDate(edtDtaImpIni.Text, LDtaIni) then
  begin
    TCieloFuncoes.fMensagem('Atenção', 'Data inicial do periodo de importação é inválida!', ['&OK']);
    Exit;
  end;

  if not TryStrToDate(edtDtaImpFin.Text, LDtaFin) then
  begin
    TCieloFuncoes.fMensagem('Atenção', 'Data inicial do periodo de importação é inválida!', ['&OK']);
    Exit;
  end;

  if Trunc(LDtaFin) < Trunc(LDtaIni) then
  begin
    TCieloFuncoes.fMensagem('Atenção', 'Data final é menor que o data inicial no periodo de importação!', ['&OK']);
    Exit;
  end;

  Result := True;
end;

procedure TfrmCieloExcluirArquivosImportadosCartoes.pConfigurarOperadora;
begin
  FOperadora := TCieloExclusao.Create;

  if not Assigned(FOperadora) then
    raise Exception.Create('Operadora de cartões não configurada.');

  Self.Caption := FOperadora.NomeRotina;
  dbgConsultaDadosDTAARQ.DataBinding.FieldName := FOperadora.ColunaDTAARQ;
  dbgConsultaDadosNOMARQ.DataBinding.FieldName := FOperadora.ColunaNOMARQ;
  dbgConsultaDadosCONCIL.DataBinding.FieldName := FOperadora.ColunaCONCIL;
end;

function TfrmCieloExcluirArquivosImportadosCartoes.fMarcarRegistro: Boolean;
var
  LMarcado: Boolean;
begin
  Result := False;

  if (not fTemRegistrosFiltrados) then
    Exit;

  LMarcado := FDatasetRegistros.FieldByName('MARCADO').AsInteger = 1;
  if not LMarcado then
  begin
    if FDatasetRegistros.FieldByName(FOperadora.ColunaCONCIL).AsInteger = 1 Then
    begin
      TCieloFuncoes.fMensagem('ATENÇÃO', 'Não é permitido excluir arquivos já conciliados!', ['&Ok']);
      Exit;
    end;
  end;

  FDatasetRegistros.Edit;
  FDatasetRegistros.FieldByName('MARCADO').AsInteger := Integer(not LMarcado);
  FDatasetRegistros.Post;
  Result := True;
end;

procedure TfrmCieloExcluirArquivosImportadosCartoes.btnCarregarClick(
  Sender: TObject);
begin
  inherited;

  try
    TCieloFuncoes.AguardeExecutarModalA(pAbreConsulta, 'Aguarde... Carregando arquivos.','');
  finally
    FQtdMarcados := 0;
    btnConfirmar.Enabled := False;
    btnMarcarTodas.Enabled := True;
    btnDesmarcarTodas.Enabled := False;

    if FDatasetRegistros.IsEmpty then
      pSetFocus(edtDtaImpIni)
    else
      pSetFocus(dbgConsulta);
  end;
end;

procedure TfrmCieloExcluirArquivosImportadosCartoes.btnConfirmarClick(
  Sender: TObject);
var
  LMsgLiberacao, LMsgDialogo, LMsgSplash, LMsgSucesso: string;
begin
  inherited;

  if (not fTemRegistrosMarcados) then
  begin
    TCieloFuncoes.fMensagem('', 'Nenhum registro foi marcado para exclusão.', ['&Ok']);
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

  if Not fLiberarExclusao(LMsgLiberacao) Then
    Exit;

  If TCieloFuncoes.fMensagem('', LMsgDialogo, ['&Sim', '&Não']) = 2 then
    Exit;

  FExcluidoComSucesso := False;
  TCieloFuncoes.ExecutaAguarde(fExcluirArquivos, LMsgSplash);

  if FExcluidoComSucesso then
  begin
    TCieloFuncoes.fMensagem('AVISO', LMsgSucesso, ['&Ok']);
    FDatasetRegistros.EmptyDataSet;
    pSetFocus(edtDtaImpIni);
  end;
end;

procedure TfrmCieloExcluirArquivosImportadosCartoes.btnDesmarcarTodasClick(
  Sender: TObject);
begin
  inherited;

  if (not fTemRegistrosMarcados) then
  begin
    TCieloFuncoes.fMensagem('', 'É necessário ter arquivos para desmarcar!', ['&Ok']);
    Exit;
  end;

  if (TCieloFuncoes.fMensagem('', 'Confirma desmarcar todos os arquivos?', ['&Sim', '&Não']) = 2) then
    Exit;

  TCieloFuncoes.ExecutaAguarde(fDesmarcarTodas, 'Aguarde... Desmarcando arquivos.');
end;

procedure TfrmCieloExcluirArquivosImportadosCartoes.btnMarcarTodasClick(
  Sender: TObject);
begin
  inherited;

  if (not fTemRegistrosFiltrados) then
  begin
    TCieloFuncoes.fMensagem('', 'É necessário ter registros para marcar!', ['&Ok']);
    Exit;
  end;

  if (TCieloFuncoes.fMensagem('', 'Confirma marcar todos os arquivos?', ['&Sim', '&Não']) = 2) then
    Exit;

  TCieloFuncoes.ExecutaAguarde(fMarcarTodas, 'Aguarde... Marcando arquivos.');
end;

procedure TfrmCieloExcluirArquivosImportadosCartoes.dbgConsultaDadosCustomDrawCell(
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

procedure TfrmCieloExcluirArquivosImportadosCartoes.dbgConsultaDadosDblClick(
  Sender: TObject);
begin
  if fMarcarRegistro then
  begin
    pAtualizarSelecaoArquivos;
    inherited;
  end;
end;

procedure TfrmCieloExcluirArquivosImportadosCartoes.dbgConsultaDadosMARCADOPropertiesEditValueChanged(
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

function TfrmCieloExcluirArquivosImportadosCartoes.fDesmarcarTodas(
  AProgressBar: TcxProgressBar): Boolean;
var
  LScroll: TprcScroll;
begin
  Result := False;
  try
    TCieloFuncoes.pDisableControls(FDatasetRegistros, LScroll);
    FDatasetRegistros.First;
    AProgressBar.Position := 0;
    AProgressBar.Properties.Max := FDatasetRegistros.RecordCount;

    while not FDatasetRegistros.Eof Do
    Begin
      TCieloFuncoes.pStepStatusGravacao(AProgressBar);

      if (FDatasetRegistros.FieldByName('MARCADO').AsInteger = 1) then
      begin
        FDatasetRegistros.Edit;
        FDatasetRegistros.FieldByName('MARCADO').AsInteger := 0;
        FDatasetRegistros.Post;
      end;

      FDatasetRegistros.Next;
    end;
  finally
    FDatasetRegistros.First;
    TCieloFuncoes.pEnableControls(FDatasetRegistros, LScroll);
    pAtualizarSelecaoArquivos;
  end;
end;

function TfrmCieloExcluirArquivosImportadosCartoes.fExcluirArquivos(
  AProgressBar: TcxProgressBar): Boolean;
var
  LScroll: TprcScroll;
  LDelete: TUniQuery;
begin
  Result := False;
  TCieloFuncoes.pDisableControls(FDatasetRegistros, LScroll);
  LDelete := VS_FuncoesExternas.fICriaQuery;
  try
    AProgressBar.Position := 0;
    AProgressBar.Properties.Max := FQtdMarcados;
    LDelete.SQL.Text :=
      ' DELETE FROM ' + FOperadora.Tabela +
      ' WHERE ' + FOperadora.ColunaDTAARQ + ' = :'+PARAM_DTAARQ+
      '   AND ' + FOperadora.ColunaNOMARQ + ' = :'+PARAM_NOMARQ;

    VS_FuncoesExternas.fIStartTransaction;
    try
      FDatasetRegistros.First;
      while not FDatasetRegistros.Eof do
      begin
        if FDatasetRegistros.FieldByName('MARCADO').AsInteger <> 1 then
        begin
          FDatasetRegistros.Next;
          Continue;
        end;

        if FDatasetRegistros.FieldByName(FOperadora.ColunaCONCIL).AsInteger <> 0 then
        begin
          FDatasetRegistros.Next;
          Continue;
        end;

        TCieloFuncoes.pStepStatusGravacao(AProgressBar);

        LDelete.Close;
        LDelete.ParamByName(PARAM_DTAARQ).AsDate := FDatasetRegistros.FieldByName(FOperadora.ColunaDTAARQ).AsDatetime;
        LDelete.ParamByName(PARAM_NOMARQ).AsString := FDatasetRegistros.FieldByName(FOperadora.ColunaNOMARQ).AsString;
        LDelete.ExecSQL;

        FDatasetRegistros.Next;
      end;

      VS_FuncoesExternas.fICommit;
      Result := True;
      FExcluidoComSucesso := True;
    except
      on E: Exception do
      begin
        VS_FuncoesExternas.fIRollback;
        VS_FuncoesExternas.pIMensagensErro(
          'Ocorreu um erro ao excluir os registros marcados!' + #13 + E.Message,
          '[TfrmCieloExcluirArquivosImportadosCartoes.fExcluirArquivos]');
        Exit;
      end;
    end;
  finally
    TCieloFuncoes.pEnableControls(FDatasetRegistros, LScroll);
    FreeAndNil(LDelete);
  end;
end;

function TfrmCieloExcluirArquivosImportadosCartoes.fGetSql(
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

  if not TCieloFuncoes.fEmptyStr(Trim(edtNomeArquivo.Text)) then
  begin
    Result := Result +
      ' AND UPPER(' + FOperadora.ColunaNOMARQ + ') LIKE :' + PARAM_NOMARQ;
  end;

  Result := Result +
    ' GROUP BY ' + string.Join(',', [FOperadora.ColunaDTAARQ, FOperadora.ColunaNOMARQ]) +
    ' ORDER BY ' + string.Join(',', [FOperadora.ColunaDTAARQ, FOperadora.ColunaNOMARQ]);
end;

function TfrmCieloExcluirArquivosImportadosCartoes.fGridFocado: Boolean;
begin
  Result := False;

  If Not Assigned(FDatasetRegistros) Then
    Exit;

  if (FDatasetRegistros.RecordCount = 0) then
    Exit;

  if (not dbgConsultaDados.Focused) then
    Exit;

  Result := True;
end;

function TfrmCieloExcluirArquivosImportadosCartoes.fLiberarExclusao(AMsgLiberacao: string): Boolean;
begin
  Result := VS_FuncoesExternas.fIPedirLiberacao(FOperadora.DireitoAcesso,
                                                FOperadora.NomeRotina,
                                                AMsgLiberacao);
end;

function TfrmCieloExcluirArquivosImportadosCartoes.fMarcarTodas(
  AProgressBar: TcxProgressBar): Boolean;
var
  LScroll: TprcScroll;
  LQtdConciliados: Integer;
  LRegistroConciliado, LRegistroMarcado: Boolean;
begin
  Result := True;
  LQtdConciliados := 0;
  TCieloFuncoes.pDisableControls(FDatasetRegistros, LScroll);
  FDatasetRegistros.First;
  AProgressBar.Position := 0;
  AProgressBar.Properties.Max := FDatasetRegistros.RecordCount;
  try
    while not FDatasetRegistros.Eof do
    begin
      TCieloFuncoes.pStepStatusGravacao(AProgressBar);
      LRegistroMarcado := FDatasetRegistros.FieldByName('MARCADO').AsInteger = 1;
      LRegistroConciliado := FDatasetRegistros.FieldByName(FOperadora.ColunaCONCIL).AsInteger <> 0;
      LQtdConciliados := LQtdConciliados + Integer(LRegistroConciliado);

      if ((not LRegistroConciliado) and (not LRegistroMarcado)) then
      begin
        FDatasetRegistros.Edit;
        FDatasetRegistros.FieldByName('MARCADO').AsInteger := 1;
        FDatasetRegistros.Post;
      end;

      FDatasetRegistros.Next;
    end;
  finally
    FDatasetRegistros.First;
    TCieloFuncoes.pEnableControls(FDatasetRegistros, LScroll);
    pAtualizarSelecaoArquivos;
  end;

  if (LQtdConciliados = 1) then
    TCieloFuncoes.fMensagem('ATENÇÃO', 'Um registro não foi marcado porque está conciliado.', ['&Ok'])
  else if (LQtdConciliados > 1) then
    TCieloFuncoes.fMensagem('ATENÇÃO', Format('%d registros não foram marcados porque estão conciliados.', [LQtdConciliados]), ['&Ok']);
end;

procedure TfrmCieloExcluirArquivosImportadosCartoes.pAtualizarSelecaoArquivos;
var
  LScroll: TprcScroll;
  LRecNoBkp, LQtdConciliados, LQtdRegistros: Integer;
begin
  if (not FDatasetRegistros.Active) then
    Exit;

  FQtdMarcados := 0;
  LQtdConciliados := 0;
  LQtdRegistros := FDatasetRegistros.RecordCount;
  TCieloFuncoes.pDisableControls(FDatasetRegistros, LScroll);
  LRecNoBkp := FDatasetRegistros.RecNo;
  try
    if (LQtdRegistros = 0) then
      Exit;

    FDatasetRegistros.First;
    while not FDatasetRegistros.Eof do
    begin
      FQtdMarcados := FQtdMarcados + FDatasetRegistros.FieldByName('MARCADO').AsInteger;
      LQtdConciliados := LQtdConciliados + FDatasetRegistros.FieldByName(FOperadora.ColunaCONCIL).AsInteger;
      FDatasetRegistros.Next;
    end;
  finally
    FDatasetRegistros.RecNo := LRecNoBkp;
    TCieloFuncoes.pEnableControls(FDatasetRegistros, LScroll);
    btnConfirmar.Enabled := (FQtdMarcados > 0);
    btnMarcarTodas.Enabled := (FQtdMarcados < (LQtdRegistros - LQtdConciliados));
    btnDesmarcarTodas.Enabled := (FQtdMarcados > 0);
  end;
end;

procedure TfrmCieloExcluirArquivosImportadosCartoes.pAbreConsulta;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := VS_FuncoesExternas.fICriaQuery;

  Try
    LConsulta.SQL.Text := fGetSQL(True);
    fSetParametros(LConsulta);

    LConsulta.Open;

    dbgConsultaDados.DataController.DataSource := Nil;

    If Assigned(FDataSource) Then
      FreeAndNil(FDataSource);

    TCieloFuncoes.FreeAndNilDatasets(FDatasetRegistros);
    FDatasetRegistros := TCieloFuncoes.CriarClientDataSet(LConsulta);

    FDataSource := TDataSource.Create(Nil);
    FDataSource.AutoEdit := False;
    FDataSource.DataSet := FDatasetRegistros;

    dbgConsultaDados.DataController.DataSource := FDataSource;
  Finally
    TCieloFuncoes.FreeAndNilDatasets(LConsulta);
  End;
end;

end.

