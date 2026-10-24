unit untShopeeExcluirArquivosImportadosCartoes;

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

     untLibCartoesPaiSimples, untTShopeeFuncoes, untLibCartoesInterfacesTipos;

type
  TfrmShopeeExcluirArquivosImportadosCartoes = class(TfrmPaiSimples)
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
    dbgConsultaDadosDTAINI: TcxGridDBColumn;
    dbgConsultaDadosDTAFIN: TcxGridDBColumn;
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
  PARAM_NOMARQ = 'NOMARQ';

procedure TfrmShopeeExcluirArquivosImportadosCartoes.FormCreate(Sender: TObject);
begin
  inherited;

  btnConfirmar.Enabled := False;
  btnMarcarTodas.Enabled := False;
  btnDesmarcarTodas.Enabled := False;
  edtDtaImpIni.Date := VS_FuncoesExternas.fIGetVS_Date;
  edtDtaImpFin.Date := VS_FuncoesExternas.fIGetVS_Date;

  FQtdMarcados := 0;
  FExcluidoComSucesso := False;
end;

procedure TfrmShopeeExcluirArquivosImportadosCartoes.FormDestroy(
  Sender: TObject);
begin
  If Assigned(FDataSource) Then
    FreeAndNil(FDataSource);

  TShopeeFuncoes.FreeAndNilDatasets(FDatasetRegistros);
  inherited;
end;

procedure TfrmShopeeExcluirArquivosImportadosCartoes.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if fGridFocado then
    if (Key = VK_RETURN) then
    begin
      if fMarcarRegistro then
        pAtualizarSelecaoArquivos;
      Key := 0;
      Exit;
    end;

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

procedure TfrmShopeeExcluirArquivosImportadosCartoes.FormShow(Sender: TObject);
begin
  inherited;
  TShopeeFuncoes.pSetFocus(edtDtaImpIni);
end;

function TfrmShopeeExcluirArquivosImportadosCartoes.fSetParametros(
  var ADataset: TUniQuery): Boolean;
begin
  Result := False;

  if not fParametrosEstaoValidos then
    Exit;

  ADataset.ParamByName(PARAM_DTAINI).AsDate := StrToDate(edtDtaImpIni.Text);
  ADataset.ParamByName(PARAM_DTAFIN).AsDate := StrToDate(edtDtaImpFin.Text);

  if not TShopeeFuncoes.fEmptyStr(Trim(edtNomeArquivo.Text)) then
    ADataset.ParamByName(PARAM_NOMARQ).AsString := '%' + AnsiUpperCase(Trim(edtNomeArquivo.Text)) + '%';

  Result := True;
end;

function TfrmShopeeExcluirArquivosImportadosCartoes.fTemRegistrosFiltrados: Boolean;
begin
  Result := False;

  If Not Assigned(FDatasetRegistros) Then
    Exit;

  if (not FDatasetRegistros.Active) then
    Exit;

  Result := Not FDatasetRegistros.IsEmpty;
end;

function TfrmShopeeExcluirArquivosImportadosCartoes.fTemRegistrosMarcados: Boolean;
begin
  Result := False;

  if (not fTemRegistrosFiltrados) then
    Exit;

  if (FQtdMarcados = 0) then
    Exit;

  Result := True;
end;

function TfrmShopeeExcluirArquivosImportadosCartoes.fParametrosEstaoValidos: Boolean;
var
  LDtaIni, LDtaFin: TDatetime;
begin
  Result := False;

  if not TryStrToDate(edtDtaImpIni.Text, LDtaIni) then
  begin
    TShopeeFuncoes.fMensagem('Atenção', 'Data inicial do periodo de importação é inválida!', ['&OK']);
    Exit;
  end;

  if not TryStrToDate(edtDtaImpFin.Text, LDtaFin) then
  begin
    TShopeeFuncoes.fMensagem('Atenção', 'Data final do periodo de importação é inválida!', ['&OK']);
    Exit;
  end;

  if Trunc(LDtaFin) < Trunc(LDtaIni) then
  begin
    TShopeeFuncoes.fMensagem('Atenção', 'Data final é menor que o data inicial no periodo de importação!', ['&OK']);
    Exit;
  end;

  Result := True;
end;

procedure TfrmShopeeExcluirArquivosImportadosCartoes.pConfigurarOperadora;
begin
  Self.Caption := 'Excluir arquivos importados da Shopee';
  dbgConsultaDadosDTAINI.DataBinding.FieldName := 'DTAINI';
  dbgConsultaDadosDTAFIN.DataBinding.FieldName := 'DTAFIN';
  dbgConsultaDadosNOMARQ.DataBinding.FieldName := 'SHO_NOMARQ';
  dbgConsultaDadosCONCIL.DataBinding.FieldName := 'SHO_CONCIL';
end;

function TfrmShopeeExcluirArquivosImportadosCartoes.fMarcarRegistro: Boolean;
var
  LMarcado: Boolean;
begin
  Result := False;

  if (not fTemRegistrosFiltrados) then
    Exit;

  LMarcado := FDatasetRegistros.FieldByName('MARCADO').AsInteger = 1;
  if not LMarcado then
  begin
    if FDatasetRegistros.FieldByName('SHO_CONCIL').AsInteger = 1 Then
    begin
      TShopeeFuncoes.fMensagem('ATENÇÃO', 'Não é permitido excluir arquivos já conciliados!', ['&Ok']);
      Exit;
    end;
  end;

  FDatasetRegistros.Edit;
  FDatasetRegistros.FieldByName('MARCADO').AsInteger := Integer(not LMarcado);
  FDatasetRegistros.Post;
  Result := True;
end;

procedure TfrmShopeeExcluirArquivosImportadosCartoes.btnCarregarClick(
  Sender: TObject);
begin
  inherited;

  try
    TShopeeFuncoes.AguardeExecutarModalA(pAbreConsulta, 'Aguarde... Carregando arquivos.','');
  finally
     FQtdMarcados := 0;
    btnConfirmar.Enabled := False;
    btnMarcarTodas.Enabled := False;
    btnDesmarcarTodas.Enabled := False;

    if Assigned(FDatasetRegistros) then
      pAtualizarSelecaoArquivos;

    if (not Assigned(FDatasetRegistros)) or FDatasetRegistros.IsEmpty then
      pSetFocus(edtDtaImpIni)
    else
      pSetFocus(dbgConsulta);
  end;
end;

procedure TfrmShopeeExcluirArquivosImportadosCartoes.btnConfirmarClick(
  Sender: TObject);
var
  LMsgLiberacao, LMsgDialogo, LMsgSplash, LMsgSucesso: string;
begin
  inherited;

  if (not fTemRegistrosMarcados) then
  begin
    TShopeeFuncoes.fMensagem('', 'Nenhum registro foi marcado para exclusão.', ['&Ok']);
    Exit;
  end;

  LMsgLiberacao := 'Permitir excluir registro de arquivo importado de cartão da operadora Shopee';
  LMsgDialogo   := 'Os registros do arquivo marcado serão excluídos. Deseja continuar?';
  LMsgSplash    := 'Aguarde... Excluindo registros do arquivo marcado.';
  LMsgSucesso   := 'Os registros do arquivo marcado foram excluídos com sucesso.';

  if (FQtdMarcados > 1) then
  begin
    LMsgLiberacao := 'Permitir excluir registros de arquivos de cartão importados da operadora Shopee';
    LMsgDialogo   := 'Confirma excluir todos os arquivos marcados?';
    LMsgSplash    := 'Aguarde... Excluindo registros dos arquivos marcados.';
    LMsgSucesso   := 'Os registros dos arquivos marcados foram excluídos com sucesso.';
  end;

  if Not fLiberarExclusao(LMsgLiberacao) Then
    Exit;

  If TShopeeFuncoes.fMensagem('', LMsgDialogo, ['&Sim', '&Não']) = 2 then
    Exit;

  FExcluidoComSucesso := False;
  TShopeeFuncoes.ExecutaAguarde(fExcluirArquivos, LMsgSplash);

  if FExcluidoComSucesso then
  begin
    TShopeeFuncoes.fMensagem('AVISO', LMsgSucesso, ['&Ok']);
    FDatasetRegistros.EmptyDataSet;
    pAtualizarSelecaoArquivos;
    pSetFocus(edtDtaImpIni);
  end;
end;

procedure TfrmShopeeExcluirArquivosImportadosCartoes.btnDesmarcarTodasClick(
  Sender: TObject);
begin
  inherited;

  if (not fTemRegistrosMarcados) then
  begin
    TShopeeFuncoes.fMensagem('', 'É necessário ter arquivos para desmarcar!', ['&Ok']);
    Exit;
  end;

  if (TShopeeFuncoes.fMensagem('', 'Confirma desmarcar todos os arquivos?', ['&Sim', '&Não']) = 2) then
    Exit;

  TShopeeFuncoes.ExecutaAguarde(fDesmarcarTodas, 'Aguarde... Desmarcando arquivos.');
end;

procedure TfrmShopeeExcluirArquivosImportadosCartoes.btnMarcarTodasClick(
  Sender: TObject);
begin
  inherited;

  if (not fTemRegistrosFiltrados) then
  begin
    TShopeeFuncoes.fMensagem('', 'É necessário ter registros para marcar!', ['&Ok']);
    Exit;
  end;

  if (TShopeeFuncoes.fMensagem('', 'Confirma marcar todos os arquivos?', ['&Sim', '&Não']) = 2) then
    Exit;

  TShopeeFuncoes.ExecutaAguarde(fMarcarTodas, 'Aguarde... Marcando arquivos.');
end;

procedure TfrmShopeeExcluirArquivosImportadosCartoes.dbgConsultaDadosCustomDrawCell(
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

procedure TfrmShopeeExcluirArquivosImportadosCartoes.dbgConsultaDadosDblClick(
  Sender: TObject);
begin
  if fMarcarRegistro then
  begin
    pAtualizarSelecaoArquivos;
    inherited;
  end;
end;

procedure TfrmShopeeExcluirArquivosImportadosCartoes.dbgConsultaDadosMARCADOPropertiesEditValueChanged(
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
    dbgConsultaDados.DataController.EndUpdate;
  end;
end;

function TfrmShopeeExcluirArquivosImportadosCartoes.fDesmarcarTodas(
  AProgressBar: TcxProgressBar): Boolean;
var
  LScroll: TprcScroll;
begin
  Result := False;
  try
    TShopeeFuncoes.pDisableControls(FDatasetRegistros, LScroll);
    FDatasetRegistros.First;
    AProgressBar.Position := 0;
    AProgressBar.Properties.Max := FDatasetRegistros.RecordCount;

    while not FDatasetRegistros.Eof Do
    Begin
      TShopeeFuncoes.pStepStatusGravacao(AProgressBar);

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
    TShopeeFuncoes.pEnableControls(FDatasetRegistros, LScroll);
    pAtualizarSelecaoArquivos;
  end;
end;

function TfrmShopeeExcluirArquivosImportadosCartoes.fExcluirArquivos(
  AProgressBar: TcxProgressBar): Boolean;
const
  FILTRO_ARQUIVO = ' WHERE SHO_NOMARQ = :' + PARAM_NOMARQ +
                   '   AND SHO_DTADEC BETWEEN :' + PARAM_DTAINI + ' AND :' + PARAM_DTAFIN;
var
  LScroll: TprcScroll;
  LDelete: TUniQuery;
  LNomeArquivo: string;
  LDataInicial,
  LDataFinal: TDateTime;
begin
  Result := False;
  TShopeeFuncoes.pDisableControls(FDatasetRegistros, LScroll);

  LDelete := Nil;
  try
    LDelete := VS_FuncoesExternas.fICriaQuery;
    AProgressBar.Position := 0;
    AProgressBar.Properties.Max := FQtdMarcados;

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

        if FDatasetRegistros.FieldByName('SHO_CONCIL').AsInteger <> 0 then
        begin
          FDatasetRegistros.Next;
          Continue;
        end;

        TShopeeFuncoes.pStepStatusGravacao(AProgressBar);

        LNomeArquivo := FDatasetRegistros.FieldByName('SHO_NOMARQ').AsString;
        LDataInicial := FDatasetRegistros.FieldByName('DTAINI').AsDateTime;
        LDataFinal   := FDatasetRegistros.FieldByName('DTAFIN').AsDateTime;

        {SHO_PDPGTO - pedidos ligados ao extrato arquivos normais != Order.all}
        LDelete.Close;
        LDelete.SQL.Text := ' DELETE P ' +
                            '   FROM SHO_PDPGTO P ' +
                            '  INNER JOIN (SELECT SHO_CODAUT, IFNULL(SHO_CODEMP, "") AS SHO_CODEMP ' +
                            '                FROM SHO_SHPGTO ' + FILTRO_ARQUIVO +
                            '               UNION ' +
                            '              SELECT SHO_CODAUT, IFNULL(SHO_CODEMP, "") ' +
                            '                FROM SHO_SHAJUS ' + FILTRO_ARQUIVO + ') X ' +
                            '     ON X.SHO_CODAUT = P.SHO_ID_PED ' +
                            '  WHERE IFNULL(P.SHO_CODEMP, "") = X.SHO_CODEMP ' +
                            '    AND IFNULL(P.SHO_CONCIL, 0) = 0';
        LDelete.ParamByName(PARAM_NOMARQ).AsString := LNomeArquivo;
        LDelete.ParamByName(PARAM_DTAINI).AsDate := LDataInicial;
        LDelete.ParamByName(PARAM_DTAFIN).AsDate := LDataFinal;
        LDelete.ExecSQL;

        {SHO_SHPGTO - extrato}
        LDelete.Close;
        LDelete.SQL.Text := ' DELETE FROM SHO_SHPGTO ' + FILTRO_ARQUIVO +
                            '    AND IFNULL(SHO_CONCIL, 0) = 0';
        LDelete.ParamByName(PARAM_NOMARQ).AsString := LNomeArquivo;
        LDelete.ParamByName(PARAM_DTAINI).AsDate := LDataInicial;
        LDelete.ParamByName(PARAM_DTAFIN).AsDate := LDataFinal;
        LDelete.ExecSQL;

        {SHO_SHAJUS - ajustes}
        LDelete.Close;
        LDelete.SQL.Text := ' DELETE FROM SHO_SHAJUS ' + FILTRO_ARQUIVO +
                            '    AND IFNULL(SHO_CONCIL, 0) = 0';
        LDelete.ParamByName(PARAM_NOMARQ).AsString := LNomeArquivo;
        LDelete.ParamByName(PARAM_DTAINI).AsDate := LDataInicial;
        LDelete.ParamByName(PARAM_DTAFIN).AsDate := LDataFinal;
        LDelete.ExecSQL;

        {SHO_PDPGTO - arquivo de pedidos - Order.all}
        LDelete.Close;
        LDelete.SQL.Text :=
          ' DELETE FROM SHO_PDPGTO ' +
          '  WHERE SHO_NOMARQ = :' + PARAM_NOMARQ +
          '    AND IFNULL(SHO_IMPAPI, "N") = "N"' +
          '    AND IFNULL(SHO_CONCIL, 0) = 0';
        LDelete.ParamByName(PARAM_NOMARQ).AsString := LNomeArquivo;
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
          '[TfrmShopeeExcluirArquivosImportadosCartoes.fExcluirArquivos]');
        Exit;
      end;
    end;
  finally
    TShopeeFuncoes.pEnableControls(FDatasetRegistros, LScroll);
    TShopeeFuncoes.FreeAndNilDatasets(LDelete);
  end;
end;

function TfrmShopeeExcluirArquivosImportadosCartoes.fGetSql(
  AUsarLike: Boolean): string;
begin
  Result :=
    ' SELECT SHO_NOMARQ AS AUTOINCREM, ' +
    '        0 AS MARCADO, ' +
    '        SHO_NOMARQ, ' +
    '        MIN(SHO_DTADEC) AS DTAINI, '+
    '        MAX(SHO_DTADEC) AS DTAFIN, '  +
    '        MAX(SHO_CONCIL) AS SHO_CONCIL ' +
    '   FROM (SELECT SHO_NOMARQ, SHO_DTADEC, SHO_CONCIL FROM SHO_SHPGTO ' +
    '         UNION ALL ' +
    '         SELECT SHO_NOMARQ, SHO_DTADEC, SHO_CONCIL FROM SHO_SHAJUS ' +
    '         UNION ALL ' +
    '         SELECT SHO_NOMARQ, CAST(NULLIF(SHO_DTAPAG, "0000-00-00") AS DATE), SHO_CONCIL FROM SHO_PDPGTO ' +
    '          WHERE IFNULL(SHO_IMPAPI, "N") = "N") A ' +
    '  WHERE SHO_NOMARQ IS NOT NULL ';

  if not TShopeeFuncoes.fEmptyStr(Trim(edtNomeArquivo.Text)) then
    Result := Result + ' AND UPPER(SHO_NOMARQ) LIKE :' + PARAM_NOMARQ;

  Result := Result +
    '  GROUP BY SHO_NOMARQ ' +
    ' HAVING (MIN(SHO_DTADEC) IS NULL) ' +
    '     OR (MIN(SHO_DTADEC) <= :' + PARAM_DTAFIN +
    '         AND MAX(SHO_DTADEC) >= :' + PARAM_DTAINI + ')' +
    '  ORDER BY MIN(SHO_DTADEC), SHO_NOMARQ';
end;

function TfrmShopeeExcluirArquivosImportadosCartoes.fGridFocado: Boolean;
begin
  Result := False;

  If Not Assigned(FDatasetRegistros) Then
    Exit;

  if (FDatasetRegistros.RecordCount = 0) then
    Exit;

  if not Assigned(ActiveControl) then
    Exit;

  if (ActiveControl <> dbgConsulta) and (not dbgConsulta.ContainsControl(ActiveControl)) then
    Exit;

  Result := True;
end;

function TfrmShopeeExcluirArquivosImportadosCartoes.fLiberarExclusao(AMsgLiberacao: string): Boolean;
begin
  Result := VS_FuncoesExternas.fIPedirLiberacao('mnuExcluirArquivoDaShopee',
                                                'Excluir arquivos importados da Shopee',
                                                AMsgLiberacao);
end;

function TfrmShopeeExcluirArquivosImportadosCartoes.fMarcarTodas(
  AProgressBar: TcxProgressBar): Boolean;
var
  LScroll: TprcScroll;
  LQtdConciliados: Integer;
  LRegistroConciliado, LRegistroMarcado: Boolean;
begin
  Result := True;
  LQtdConciliados := 0;
  TShopeeFuncoes.pDisableControls(FDatasetRegistros, LScroll);
  FDatasetRegistros.First;
  AProgressBar.Position := 0;
  AProgressBar.Properties.Max := FDatasetRegistros.RecordCount;
  try
    while not FDatasetRegistros.Eof do
    begin
      TShopeeFuncoes.pStepStatusGravacao(AProgressBar);
      LRegistroMarcado := FDatasetRegistros.FieldByName('MARCADO').AsInteger = 1;
      LRegistroConciliado := FDatasetRegistros.FieldByName('SHO_CONCIL').AsInteger <> 0;
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
    TShopeeFuncoes.pEnableControls(FDatasetRegistros, LScroll);
    pAtualizarSelecaoArquivos;
  end;

  if (LQtdConciliados = 1) then
    TShopeeFuncoes.fMensagem('ATENÇÃO', 'Um registro não foi marcado porque está conciliado.', ['&Ok'])
  else if (LQtdConciliados > 1) then
    TShopeeFuncoes.fMensagem('ATENÇÃO', Format('%d registros não foram marcados porque estão conciliados.', [LQtdConciliados]), ['&Ok']);
end;

procedure TfrmShopeeExcluirArquivosImportadosCartoes.pAtualizarSelecaoArquivos;
var
  LScroll: TprcScroll;
  LRecNoBkp, LQtdConciliados, LQtdRegistros: Integer;
begin
  if (not FDatasetRegistros.Active) then
    Exit;

  FQtdMarcados := 0;
  LQtdConciliados := 0;
  LQtdRegistros := FDatasetRegistros.RecordCount;
  TShopeeFuncoes.pDisableControls(FDatasetRegistros, LScroll);
  LRecNoBkp := FDatasetRegistros.RecNo;
  try
    if (LQtdRegistros = 0) then
      Exit;

    FDatasetRegistros.First;
    while not FDatasetRegistros.Eof do
    begin
      FQtdMarcados := FQtdMarcados + FDatasetRegistros.FieldByName('MARCADO').AsInteger;
      LQtdConciliados := LQtdConciliados + FDatasetRegistros.FieldByName('SHO_CONCIL').AsInteger;
      FDatasetRegistros.Next;
    end;
  finally
    FDatasetRegistros.RecNo := LRecNoBkp;
    TShopeeFuncoes.pEnableControls(FDatasetRegistros, LScroll);
    btnConfirmar.Enabled := (FQtdMarcados > 0);
    btnMarcarTodas.Enabled := (FQtdMarcados < (LQtdRegistros - LQtdConciliados));
    btnDesmarcarTodas.Enabled := (FQtdMarcados > 0);
  end;
end;

procedure TfrmShopeeExcluirArquivosImportadosCartoes.pAbreConsulta;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := fGetSQL(True);

    if not fSetParametros(LConsulta) then
      Exit;

    LConsulta.Open;

    dbgConsultaDados.DataController.DataSource := Nil;

    If Assigned(FDataSource) Then
      FreeAndNil(FDataSource);

    TShopeeFuncoes.FreeAndNilDatasets(FDatasetRegistros);
    FDatasetRegistros := TShopeeFuncoes.CriarClientDataSet(LConsulta);

    FDataSource := TDataSource.Create(Nil);
    FDataSource.AutoEdit := False;
    FDataSource.DataSet := FDatasetRegistros;

    dbgConsultaDados.DataController.DataSource := FDataSource;
  Finally
    TShopeeFuncoes.FreeAndNilDatasets(LConsulta);
  End;
end;

end.


