unit untFechamentoReaberturaEventos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, untTypesSistema, ACBrReinf, UniClientDataSet, Uni,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls, System.UITypes,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB,
  cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel, cxGrid, Vcl.Mask,
  MaskEditFocus, cxCheckBox;

type
  TfrmFechamentoReaberturaEventos = class(TfrmPai)
    tmrConsultarProcessamento: TTimer;
    pnlPrincipal: TPanel;
    gpbRetorno: TGroupBox;
    cxgRetorno: TcxGridCitel;
    cxgRetornoDBTableViewCitel1: TcxGridDBTableViewCitel;
    cxgRetornoLOT_CODRET: TcxGridDBColumn;
    cxgRetornoLOT_DTAENV: TcxGridDBColumn;
    cxgRetornoLOT_STATUS: TcxGridDBColumn;
    cxgRetornoLOT_PROTOC: TcxGridDBColumn;
    cxgRetornoLOT_DESRET: TcxGridDBColumn;
    cxgRetornoLOT_IDEEVE: TcxGridDBColumn;
    cxgRetornoLOT_RECIBO: TcxGridDBColumn;
    cxgRetornoLevel1: TcxGridLevel;
    lblPerApur: TLabel;
    edtPerApu: TMaskEditFocus;
    btnFecharAbrir: TBitBtnLocked;
    btnBaixarXmlEnvio: TBitBtnLocked;
    btnBaixarXmlRetorno: TBitBtnLocked;
    btnConsultaLote: TBitBtnLocked;
    cxgRetornoMARDES: TcxGridDBColumn;
    procedure FormDestroy(Sender: TObject);
    procedure btnBaixarXmlRetornoClick(Sender: TObject);
    procedure btnBaixarXmlEnvioClick(Sender: TObject);
    procedure btnFecharAbrirClick(Sender: TObject);
    procedure cxgRetornoDBTableViewCitel1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure tmrConsultarProcessamentoTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConsultaLoteClick(Sender: TObject);
  private
    { Private declarations }

    qryFechAbert: TUniQuery;
    cdsFechAbert: TUniClientDataSet;
    dtsFechAbert: TDataSource;

    tpEvento: TtpEventoReinf;

    blnfecharMovimento: Boolean;

    procedure pCarregarAberturasEFechamentos;

    procedure pDefineFechamentoAbertura;

    procedure pConfiguraDts;

    procedure pAfterScrollcdsFechAbert(DataSet: TDataSet);

    function fRetSqlLotesAbertosEFechados: String;

    function fRetEvento: String;

    procedure pSalvarXmlEnvio;

    procedure pSalvarXmlRetorno;

    function fLoteTemXml(tpXmlReinf: TtpXmlReinf): Boolean;

    procedure pAbrirMovimentacao2098;

    procedure pFecharMovimentacao2099;

    procedure pFecharAbrirMovimentacao4099;

    procedure pVerificaMovimentosExistentes(var blnR2010, blnR2020: Boolean);

    procedure pRetContato(var strNomCtt, strCpfCtt, strFonCtt, strEmaCtt: String);

    procedure pProcessarTransmissao;

    procedure pConsultarProcessamentoLote;

    procedure pConsultarLote2099(var blnProcessouLote: Boolean);
    procedure pConsultarLote2098(var blnProcessouLote: Boolean);
    procedure pConsultarLote4099(var blnProcessouLote: Boolean);

    procedure pAtualizaRetornoLote(const strCodRet,
                                         strDesRet,
                                         strDescErro,
                                         strXmlRet,
                                         strIdeEve,
                                         strStatus,
                                         strRecibo: String);

    procedure pFecharAbrirEventos;

    function fProntoParaConsultarProcessamentoDosLotes: Boolean;

    function fTemLoteComErro(var strAutoIncremLote: String): Boolean;

    function fRetXmlEnvio: AnsiString;

    function fRetSqlLotesQueSeraoFechadosOuAbertos: String;

    procedure pConsultarLotePosicionado;

    function fTemLoteSelecionado: Boolean;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    ACBrReinf: TACBrReinf;

    tpEventoFechamentoReabertura: TtpEventoFechamentoReaberturaReinf;

    strCodEmp: String;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, pcnReinfR2098, pcnReinfR2099, pcnReinfR4099,
  ACBrUtil.DateTime, pcnConversaoReinf, untFuncoes, untGravando;

{ TfrmFechamentoReaberturaEventos }


procedure TfrmFechamentoReaberturaEventos.FormCreate(Sender: TObject);
begin
  inherited;
  blnfecharMovimento := True;
end;

procedure TfrmFechamentoReaberturaEventos.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(dtsFechAbert) then
    FreeAndNil(dtsFechAbert);

  if Assigned(cdsFechAbert) then
    FreeAndNil(cdsFechAbert);

  if Assigned(qryFechAbert) then
    FreeAndNil(qryFechAbert);
end;

procedure TfrmFechamentoReaberturaEventos.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtPerApu);
end;

function TfrmFechamentoReaberturaEventos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
   Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin
    If Sender = edtPerApu Then
    Begin
      if edtPerApu.Text = '  /    ' then
      begin
        fMensagem('ATENÇÃO', 'Informe o período de apuração', ['&Ok']);
        Result := False;
      end
      else if (StrToInt(Copy(edtPerApu.Text, 0, 2)) < 1) or (StrToInt(Copy(edtPerApu.Text, 0, 2)) > 12) then
      begin
        fMensagem('ATENÇÃO', 'Período de apuração inválido', ['&Ok']);
        Result := False;
      end
      else if (Length(Trim(edtPerApu.Text)) < 5) or (Length(Trim(edtPerApu.Text)) = 6) then
      begin
        fMensagem('ATENÇÃO', 'Período de apuração inválido!', ['&Ok']);
        Result := False;
      end
      else if Length(Trim(edtPerApu.Text)) = 5 then
      begin
        edtPerApu.Text := Copy(edtPerApu.Text, 1, 3) + Copy(FormatDateTime('yyyy', Date), 1, 2) + Copy(edtPerApu.Text, 4, 2);
        Result := fValidaCampos(edtPerApu, False);
      end
      else
        pCarregarAberturasEFechamentos;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmFechamentoReaberturaEventos.btnBaixarXmlEnvioClick(
  Sender: TObject);
begin
  inherited;
  if not fLoteTemXml(xmlEnvio) then
    Exit;

  if not fTemLoteSelecionado then
    Exit;

  cdsFechAbert.AfterScroll := Nil;
  TfrmGravando.fExecutarModal(pSalvarXmlEnvio, 'Baixando xml, aguarde...', '');
  cdsFechAbert.AfterScroll := pAfterScrollcdsFechAbert;
end;

procedure TfrmFechamentoReaberturaEventos.btnBaixarXmlRetornoClick(
  Sender: TObject);
begin
  inherited;
  if not fLoteTemXml(xmlRetorno) then
    Exit;

  if not fTemLoteSelecionado then
    Exit;

  cdsFechAbert.AfterScroll := Nil;
  TfrmGravando.fExecutarModal(pSalvarXmlRetorno, 'Baixando xml, aguarde...', '');
  cdsFechAbert.AfterScroll := pAfterScrollcdsFechAbert;
end;


procedure TfrmFechamentoReaberturaEventos.pSalvarXmlEnvio;
begin
  pSalvarXmlReinf(xmlEnvio,
                  cdsFechAbert);
end;

procedure TfrmFechamentoReaberturaEventos.pSalvarXmlRetorno;
begin
  pSalvarXmlReinf(xmlRetorno,
                  cdsFechAbert);
end;

procedure TfrmFechamentoReaberturaEventos.btnConsultaLoteClick(Sender: TObject);
begin
  inherited;
  TfrmGravando.fExecutarModal(pConsultarLotePosicionado, 'Consultando Processamento do lote posicionado!', '');
end;

procedure TfrmFechamentoReaberturaEventos.pConsultarLotePosicionado;
var
  blnProcessouLote: Boolean;
begin
  if tpEvento = R2099 then
    pConsultarLote2099(blnProcessouLote)
  else if tpEvento = R2098 then
    pConsultarLote2098(blnProcessouLote);

  if blnProcessouLote then
    pCarregarAberturasEFechamentos;
end;

function TfrmFechamentoReaberturaEventos.fLoteTemXml(
  tpXmlReinf: TtpXmlReinf): Boolean;
begin
  Result := False;

  if not Assigned(cdsFechAbert) then
    Exit;

  if cdsFechAbert.IsEmpty then
    Exit;

  try
    Result := not fEmptyStr(cdsFechAbert.FieldByName(IIF(tpXmlReinf = xmlEnvio, 'LOT_XMLENV', 'LOT_XMLRET')).AsString);
  finally
    if not Result then
      fMensagem('ATENÇÃO', 'XML '+IIF(tpXmlReinf = xmlEnvio,'de envio', 'de retorno')+' não encontrado para baixar!', ['&Ok']);
  end;
end;

function TfrmFechamentoReaberturaEventos.fTemLoteSelecionado: Boolean;
begin
  Result := False;

  if not Assigned(cdsFechAbert) then
    Exit;

  if cdsFechAbert.IsEmpty then
    Exit;

  try
    cdsFechAbert.DisableControls;
    cdsFechAbert.Filtered := False;
    cdsFechAbert.Filter := 'MARDES = '+QuotedStr('M');
    cdsFechAbert.Filtered := True;
    Result := not cdsFechAbert.IsEmpty;
  finally
    cdsFechAbert.Filtered := False;
    cdsFechAbert.First;
    cdsFechAbert.EnableControls;

    if not Result then
      fMensagem('ATENÇÃO', 'Nenhum lote selecionado para prosseguir com a operação!', ['&Ok']);
  end;
end;

function TfrmFechamentoReaberturaEventos.fRetEvento: String;
begin
  case tpEvento of
    R2098: Result := 'R2098';
    R2099: Result := 'R2099';
    R4099: Result := 'R4099';
  end;
end;

function TfrmFechamentoReaberturaEventos.fRetSqlLotesAbertosEFechados: String;
begin
  Result := EmptyStr;

  case tpEventoFechamentoReabertura of
    serieR2000: Result := '"R2098", "R2099"';
    serieR4000: Result := '"R4099"';
  end;
end;

procedure TfrmFechamentoReaberturaEventos.pCarregarAberturasEFechamentos;
begin
  if fEmptyStr(Self.strCodEmp) then
    Exit;

  if not Assigned(qryFechAbert) then
    qryFechAbert := fCriaQuery(Self);

  qryFechAbert.Close;
  qryFechAbert.SQL.Text :=
  ' SELECT '+
  '   "D" AS MARDES, '+
  '   AUTOINCREM, '+
  '   LOT_CODRET, '+
  '   LOT_DTAENV, '+
  '   LOT_PROTOC, '+
  '   LOT_DESRET, '+
  '   LOT_IDEEVE, '+
  '   LOT_RECIBO, '+
  '   LOT_XMLENV, '+
  '   LOT_XMLRET, '+
  '   LOT_EVENTO, '+
  '   CASE LOT_STATUS WHEN "A" THEN "ABERTO" WHEN "F" THEN "FECHADO" END AS LOT_STATUS  '+
  ' FROM '+
  '   REINF_LOTES '+
  ' WHERE '+
  '   LOT_PERAPU = :PERAPU AND '+
  '   LOT_EVENTO IN ('+fRetSqlLotesAbertosEFechados+') AND '+
  '   LOT_CODEMP = :CODEMP '+
  '   ORDER BY '+
  '   AUTOINCREM ';

  qryFechAbert.ParamByName('PERAPU').AsString := edtPerApu.Text;
  qryFechAbert.ParamByName('CODEMP').AsString := Self.strCodEmp;
  qryFechAbert.Open;

  if Assigned(cdsFechAbert) then
  begin
    FreeAndNil(dtsFechAbert);
    FreeAndNil(cdsFechAbert);
  end;

  cdsFechAbert := fCriaClientDatset(qryFechAbert);
  pConfiguraDts;

  pDefineFechamentoAbertura;

  pAfterScrollcdsFechAbert(cdsFechAbert);

  tmrConsultarProcessamento.Enabled := True;
end;

procedure TfrmFechamentoReaberturaEventos.pConfiguraDts;
begin
  pSetaClient(cdsFechAbert);
  dtsFechAbert := fCriaDataSource(cdsFechAbert);
  cxgRetornoDBTableViewCitel1.DataController.DataSource := dtsFechAbert;

  cxgRetornoDBTableViewCitel1.BeginUpdate;
  try
    cxgRetornoDBTableViewCitel1.ApplyBestFit();
  finally
    cxgRetornoDBTableViewCitel1.EndUpdate;
  end;

  cdsFechAbert.AfterScroll := pAfterScrollcdsFechAbert;
end;

procedure TfrmFechamentoReaberturaEventos.pDefineFechamentoAbertura;
begin
  cdsFechAbert.DisableControls;
  cdsFechAbert.Filtered := False;
  cdsFechAbert.Filter := ' LOT_CODRET = '+QuotedStr('0');
  cdsFechAbert.Filtered := True;

  cdsFechAbert.Last;

  blnfecharMovimento := True;
  if not fEmptyStr(cdsFechAbert.FieldByName('LOT_STATUS').AsString) then
    blnfecharMovimento := ((cdsFechAbert.FieldByName('LOT_STATUS').AsString = 'ABERTO') and
                           (cdsFechAbert.FieldByName('LOT_CODRET').AsString = '0'));

  cdsFechAbert.Filtered := False;
  cdsFechAbert.EnableControls;

  btnFecharAbrir.Caption := IIF(blnfecharMovimento, 'Fechar Movimento', 'Abrir Movimento');

  if tpEventoFechamentoReabertura = serieR2000 then
  begin
    tpEvento := IIF(blnfecharMovimento, R2099, R2098);
  end
  else if tpEventoFechamentoReabertura = serieR4000 then
    tpEvento := R4099;
end;

procedure TfrmFechamentoReaberturaEventos.pAfterScrollcdsFechAbert(
  DataSet: TDataSet);
begin
  if not Assigned(cdsFechAbert) then
    Exit;

  if cdsFechAbert.IsEmpty then
    Exit;

  btnConsultaLote.Visible := (DataSet.FieldByName('LOT_CODRET').AsString = '1') or (DataSet.FieldByName('LOT_CODRET').AsString = '2');
end;

procedure TfrmFechamentoReaberturaEventos.cxgRetornoDBTableViewCitel1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  if not Assigned(cdsFechAbert) then
    Exit;

  if not cdsFechAbert.Active then
    Exit;

  if VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgRetornoLOT_CODRET.Index]) = '1' then
  begin
    if ACanvas.Brush.Color = clHighlight then
      ACanvas.Font.Color := clBlack
    else
    begin
      ACanvas.Brush.Color := $007AA0FF;
      ACanvas.Font.Color := clBlack;
    end;
  end
  else if VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgRetornoLOT_CODRET.Index]) = '0' then
  begin
    if ACanvas.Brush.Color = clHighlight then
      ACanvas.Font.Color := clBlack
    else
    begin
      ACanvas.Brush.Color := $0090EE90;
      ACanvas.Font.Color := clBlack;
    end;
  end
  else
  begin
    if ACanvas.Brush.Color = clHighlight then
      ACanvas.Font.Color := clBlack
    else
    begin
      ACanvas.Brush.Color := clWindow;
      ACanvas.Font.Color := clBlack;
    end;
  end;
end;

procedure TfrmFechamentoReaberturaEventos.btnFecharAbrirClick(Sender: TObject);
begin
  inherited;

  if not fVerificaCampos then
    Exit;

  if not fPergunta('Deseja '+IIF(blnfecharMovimento, 'fechar ', 'abrir ') + 'o movimento de ' + edtPerApu.Text+'?') then
    Exit;

  if tpEventoFechamentoReabertura = serieR2000 then
  begin
    if not blnfecharMovimento then
      TfrmGravando.fExecutarModal(pAbrirMovimentacao2098, 'Abrindo Movimento R2098 - '+edtPerApu.Text, '')
    else if blnfecharMovimento then
      TfrmGravando.fExecutarModal(pFecharMovimentacao2099, 'Fechando Movimento R2099 - '+edtPerApu.Text, '');
  end
  else if tpEventoFechamentoReabertura = serieR4000 then
    TfrmGravando.fExecutarModal(pFecharAbrirMovimentacao4099, 'Abrindo Movimento R4099 - '+edtPerApu.Text, '')

end;

procedure TfrmFechamentoReaberturaEventos.pVerificaMovimentosExistentes(var blnR2010, blnR2020: Boolean);
begin
  blnR2010 := not fEmptyStr(fCampoTabela('AUTOINCREM', 'REINF_LOTES', ['LOT_CODEMP', 'LOT_PERAPU', 'LOT_EVENTO'], [Self.strCodEmp, edtPerApu.Text, 'R2010']));
  blnR2020 := not fEmptyStr(fCampoTabela('AUTOINCREM', 'REINF_LOTES', ['LOT_CODEMP', 'LOT_PERAPU', 'LOT_EVENTO'], [Self.strCodEmp, edtPerApu.Text, 'R2020']));
end;

procedure TfrmFechamentoReaberturaEventos.pAbrirMovimentacao2098;
var
  objR2098: TR2098CollectionItem;
begin
  try
    ACBrReinf.Eventos.Clear;
    ACBrReinf.Eventos.ReinfEventos.R2098.Clear;
    objR2098 := ACBrReinf.Eventos.ReinfEventos.R2098.New;
    objR2098.evtReabreEvPer.Sequencial := 0;

    objR2098.evtReabreEvPer.ideEvento.perApur := FormatDateBr(StrToDate('01/'+edtPerApu.Text), 'yyyy-mm');
    objR2098.evtReabreEvPer.IdeEvento.ProcEmi := peAplicEmpregador;
    objR2098.evtReabreEvPer.IdeEvento.VerProc := '1.0';

    objR2098.evtReabreEvPer.ideContri.TpInsc := tiCNPJ;
    objR2098.evtReabreEvPer.ideContri.NrInsc := ACBrReinf.Configuracoes.Geral.IdContribuinte;

    ACBrReinf.Eventos.Gerar;
    ACBrReinf.Eventos.Assinar;

    if ACBrReinf.Enviar then
      pProcessarTransmissao;
  except
    on E:Exception do
      fMensagem('ATENÇÃO!', E.Message, ['&Ok']);
  end;
end;

procedure TfrmFechamentoReaberturaEventos.pFecharMovimentacao2099;
var
  objR2099: TR2099CollectionItem;

  blnR2010,
  blnR2020: Boolean;

  strNomCtt,
  strCpfCtt,
  strFonCtt,
  strEmaCtt: String;
begin
  try
    ACBrReinf.Eventos.ReinfEventos.Clear;
    objR2099 := ACBrReinf.Eventos.ReinfEventos.R2099.New;

    objR2099.evtFechaEvPer.Sequencial := 0;

    objR2099.evtFechaEvPer.ideEvento.perApur := FormatDateBr(StrToDate('01/'+edtPerApu.Text), 'yyyy-mm');
    objR2099.evtFechaEvPer.ideEvento.ProcEmi := peAplicEmpregador;
    objR2099.evtFechaEvPer.ideEvento.VerProc := '1.0';

    objR2099.evtFechaEvPer.ideContri.TpInsc := tiCNPJ;
    objR2099.evtFechaEvPer.ideContri.NrInsc := ACBrReinf.Configuracoes.Geral.IdContribuinte;

    pRetContato(strNomCtt, strCpfCtt, strFonCtt, strEmaCtt);
    objR2099.evtFechaEvPer.ideRespInf.nmResp   := strNomCtt;
    objR2099.evtFechaEvPer.ideRespInf.cpfResp  := strCpfCtt;
    objR2099.evtFechaEvPer.ideRespInf.telefone := strFonCtt;
    objR2099.evtFechaEvPer.ideRespInf.email    := strEmaCtt;

    //Passei apenas o 2010 e o 2020 porque são os eventos que estamos usando hoje da série 2000
    pVerificaMovimentosExistentes(blnR2010, blnR2020);
    objR2099.evtFechaEvPer.infoFech.evtServTm     := IIF(blnR2010, tpSim, tpNao);
    objR2099.evtFechaEvPer.infoFech.evtServPr     := IIF(blnR2020, tpSim, tpNao);
    //não estamos usando os eventos abaixo, por isso todos estão tpNão
    objR2099.evtFechaEvPer.infoFech.evtAssDespRec := tpNao;
    objR2099.evtFechaEvPer.infoFech.evtAssDespRep := tpNao;
    objR2099.evtFechaEvPer.infoFech.evtComProd    := tpNao;
    objR2099.evtFechaEvPer.infoFech.evtCPRB       := tpNao;
    objR2099.evtFechaEvPer.infoFech.evtAquis      := tpNao;

    if (not blnR2010) and (not blnR2020) then
      objR2099.evtFechaEvPer.infoFech.compSemMovto := FormatDateBr(StrToDate('01/'+edtPerApu.Text), 'yyyy-mm');

    ACBrReinf.Eventos.Gerar;
    ACBrReinf.Eventos.Assinar;

    if ACBrReinf.Enviar then
      pProcessarTransmissao;
  except
    on E:Exception do
      fMensagem('ATENÇÃO!', E.Message, ['&Ok']);
  end;
end;

procedure TfrmFechamentoReaberturaEventos.pFecharAbrirMovimentacao4099;
var
  objR4099: TR4099CollectionItem;
  Ok: Boolean;

  strNomCtt,
  strCpfCtt,
  strFonCtt,
  strEmaCtt: String;
begin
  ACBrReinf.Eventos.Clear;
  ACBrReinf.Eventos.ReinfEventos.R4099.Clear;

  objR4099 := ACBrReinf.Eventos.ReinfEventos.R4099.New;

  objR4099.evtFech.Sequencial := 0;

  objR4099.evtFech.ideEvento.perApur := FormatDateBr(StrToDate('01/'+edtPerApu.Text), 'yyyy-mm');
  objR4099.evtFech.ideEvento.ProcEmi := peAplicEmpregador;
  objR4099.evtFech.ideEvento.VerProc := '1.0';

  objR4099.evtFech.ideContri.TpInsc := tiCNPJ;
  objR4099.evtFech.ideContri.NrInsc := ACBrReinf.Configuracoes.Geral.IdContribuinte;

  pRetContato(strNomCtt, strCpfCtt, strFonCtt, strEmaCtt);
  objR4099.evtFech.ideRespInf.nmResp   := strNomCtt;
  objR4099.evtFech.ideRespInf.cpfResp  := strCpfCtt;
  objR4099.evtFech.ideRespInf.telefone := strFonCtt;
  objR4099.evtFech.ideRespInf.email    := strEmaCtt;

  objR4099.evtFech.infoFech.fechRet := StrTotpFechRet(Ok, IIF(blnfecharMovimento, '0', '1'));

  ACBrReinf.Eventos.Gerar;
  ACBrReinf.Eventos.Assinar;

  if ACBrReinf.Enviar then
    pProcessarTransmissao;
end;

procedure TfrmFechamentoReaberturaEventos.pRetContato(var strNomCtt, strCpfCtt, strFonCtt, strEmaCtt: String);
const
  SQL_R1000 = ' SELECT '+
                '   REI_NOMCTT, '+
                '   REI_CPFCTT, '+
                '   REI_CELCTT, '+
                '   REI_EMACTT  '+
                ' FROM '+
                '   REINF_R1000 '+
                ' WHERE '+
                '   REI_CODEMP = :CODEMP ';

var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  try
    qryAux.Close;
    qryAux.SQL.Text := SQL_R1000;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.Open;

    strNomCtt := qryAux.FieldByName('REI_NOMCTT').AsString;
    strCpfCtt := qryAux.FieldByName('REI_CPFCTT').AsString;
    strFonCtt := qryAux.FieldByName('REI_CELCTT').AsString;
    strEmaCtt := qryAux.FieldByName('REI_EMACTT').AsString;
  finally
    FreeAndNil(qryAux);
  end;
end;

procedure TfrmFechamentoReaberturaEventos.pProcessarTransmissao;
var
  qryAux: TUniQuery;

  strAutoIncremLote: String;
begin
  if not fEmptyStr(ACBrReinf.WebServices.EnvioLote.RetEnvioLote.dadosRecepcaoLote.protocoloEnvio) then
  begin
    qryAux := fCriaQuery(Self);
    try
      try
        qryAux.Close;

        if not fTemLoteComErro(strAutoIncremLote) then
        begin
          qryAux.SQL.Text :=
          ' INSERT INTO REINF_LOTES'+
          '   (AUTOINCREM, '+
          '    LOT_DTAENV, '+
          '    LOT_DESRET, '+
          '    LOT_PROTOC, '+
          '    LOT_ORIRET, '+
          '    LOT_STATUS, '+
          '    LOT_XMLENV, '+
          '    LOT_PERAPU, '+
          '    LOT_CODEMP, '+
          '    LOT_EVENTO) '+
          ' VALUES '+
          '   (:AUTINC, '+
          '    :DTAENV, '+
          '    :DESRET, '+
          '    :PROTOC, '+
          '    :ORIRET, '+
          '    :STATUS, '+
          '    :XMLENV, '+
          '    :PERAPU, '+
          '    :CODEMP, '+
          '    :EVENTO) ';

          strAutoIncremLote := fRetAutoIncrem('REINF_LOTES', Self.strCodEmp);

          qryAux.ParamByName('AUTINC').AsString := strAutoIncremLote;
          qryAux.ParamByName('STATUS').AsString := IIF(blnfecharMovimento, 'F', 'A');
          qryAux.ParamByName('PERAPU').AsString := edtPerApu.Text;
          qryAux.ParamByName('CODEMP').AsString := Self.strCodEmp;
          qryAux.ParamByName('EVENTO').AsString := fRetEvento;
        end
        else
        begin
          qryAux.SQL.Text :=
          ' UPDATE '+
          '   REINF_LOTES '+
          ' SET '+
          '   LOT_DTAENV = :DTAENV '+
          '  ,LOT_DESRET = :DESRET '+
          '  ,LOT_PROTOC = :PROTOC '+
          '  ,LOT_ORIRET = :ORIRET '+
          '  ,LOT_XMLENV = :XMLENV '+
          '  ,LOT_CODRET =  NULL   '+
          ' WHERE '+
          '   AUTOINCREM = :AUTINC ';

          qryAux.ParamByName('AUTINC').AsString := strAutoIncremLote;
        end;

        qryAux.ParamByName('DTAENV').AsDateTime   := ACBrReinf.WebServices.EnvioLote.RetEnvioLote.dadosRecepcaoLote.dhRecepcao;
        qryAux.ParamByName('DESRET').AsString     := ACBrReinf.WebServices.EnvioLote.RetEnvioLote.Status.descRetorno;
        qryAux.ParamByName('PROTOC').AsString     := ACBrReinf.WebServices.EnvioLote.RetEnvioLote.dadosRecepcaoLote.protocoloEnvio;
        qryAux.ParamByName('ORIRET').AsString     := 'O';
        qryAux.ParamByName('XMLENV').AsAnsiString := fRetXmlEnvio;

        qryAux.ExecSQL;
      except
        on E: Exception do
        begin
          pMensagensErro(E.Message, 'TfrmFechamentoReaberturaEventos.fProcessarTransmissao');
        end;
      end;

    finally
      FreeAndNil(qryAux);
    end;

    pCarregarAberturasEFechamentos;
    tmrConsultarProcessamento.Enabled := True;
  end;
end;

procedure TfrmFechamentoReaberturaEventos.tmrConsultarProcessamentoTimer(
  Sender: TObject);
begin
  inherited;
  tmrConsultarProcessamento.Enabled := False;
  TfrmGravando.fExecutarModal(pConsultarProcessamentoLote, 'Consultando Processamento dos lotes '+fRetEvento, '');
end;

procedure TfrmFechamentoReaberturaEventos.pConsultarProcessamentoLote;
var
 blnProcessouLote: Boolean;
begin
  inherited;

  if not fProntoParaConsultarProcessamentoDosLotes then
    Exit;

  blnProcessouLote := False;

  cdsFechAbert.DisableControls;

  cdsFechAbert.Last;

  if (not fEmptyStr(cdsFechAbert.FieldByName('LOT_PROTOC').AsString)) and
     (fEmptyStr(cdsFechAbert.FieldByName('LOT_CODRET').AsString)) then
  begin
    if tpEvento = R2099 then
      pConsultarLote2099(blnProcessouLote)
    else if tpEvento = R2098 then
      pConsultarLote2098(blnProcessouLote)
    else if tpEvento = R4099 then
      pConsultarLote4099(blnProcessouLote);
  end;

  if blnProcessouLote then
    pCarregarAberturasEFechamentos;

  cdsFechAbert.EnableControls;
end;

procedure TfrmFechamentoReaberturaEventos.pConsultarLote2099(var blnProcessouLote: Boolean);
const
  RETORNO_ERRO = '1';
var
  intCount,
  intCountErro: Integer;
  strDescErro: String;
begin
  if not fProntoParaConsultarProcessamentoDosLotes then
    Exit;

  try
    for intCount := 1 to 20 do
    begin
      if ACBrReinf.Consultar(cdsFechAbert.FieldByName('LOT_PROTOC').AsString) then
      begin

        if ACBrReinf.WebServices.Consultar.RetEnvioLote.evento.Count = 0 then
        begin
          Sleep(3000);
          Continue;
        end;

        strDescErro := EmptyStr;
        if ACBrReinf.WebServices.Consultar.RetConsulta_R9011.evtTotalContrib.IdeStatus.cdRetorno = RETORNO_ERRO then
        begin
          for intCountErro := 0 to ACBrReinf.WebServices.Consultar.RetConsulta_R9011.evtTotalContrib.IdeStatus.regOcorrs.Count - 1 do
          begin
            strDescErro := strDescErro + ACBrReinf.WebServices.Consultar.RetConsulta_R9011.evtTotalContrib.IdeStatus.regOcorrs.Items[intCountErro].codResp + ' ' +
                                         ACBrReinf.WebServices.Consultar.RetConsulta_R9011.evtTotalContrib.IdeStatus.regOcorrs.Items[intCountErro].dscResp + sLineBreak + sLineBreak;
          end;
        end;

        fStartTransaction;

        pAtualizaRetornoLote(ACBrReinf.WebServices.Consultar.RetConsulta_R9011.evtTotalContrib.IdeStatus.cdRetorno,
                             IIF(not fEmptyStr(strDescErro), strDescErro, ACBrReinf.WebServices.Consultar.RetConsulta_R9011.evtTotalContrib.IdeStatus.descRetorno),
                             strDescErro,
                             ACBrReinf.WebServices.Consultar.RetWS,
                             ACBrReinf.WebServices.Consultar.RetConsulta_R9011.evtTotalContrib.Id,
                             IIF((fEmptyStr(strDescErro)) and (blnfecharMovimento), 'F', 'A'),
                             ACBrReinf.WebServices.Consultar.RetConsulta_R9011.evtTotalContrib.InfoRecEv.nrRecArqBase);

        if fEmptyStr(strDescErro) then
          pFecharAbrirEventos;

        fCommit;

        blnProcessouLote := True;

        Break;
      end;
    end;
  except
    on E: Exception do
    begin
      fRollBack;
      pMensagensErro(E.Message, 'TfrmFechamentoReaberturaEventos.pConsultarLote');
    end;
  end;
end;

procedure TfrmFechamentoReaberturaEventos.pConsultarLote2098(var blnProcessouLote: Boolean);
const
  RETORNO_ERRO = '1';
var
  intCount,
  intCountErro: Integer;
  strDescErro: String;
begin
  if not fProntoParaConsultarProcessamentoDosLotes then
    Exit;

  try
    for intCount := 1 to 20 do
    begin
      if ACBrReinf.Consultar(cdsFechAbert.FieldByName('LOT_PROTOC').AsString) then
      begin

        if ACBrReinf.WebServices.Consultar.RetEnvioLote.evento.Count = 0 then
        begin
          Sleep(3000);
          Continue;
        end;

        strDescErro := EmptyStr;
        if ACBrReinf.WebServices.Consultar.RetEnvioLote.evento.Items[0].evtTotal.IdeStatus.cdRetorno = RETORNO_ERRO then
        begin
          for intCountErro := 0 to ACBrReinf.WebServices.Consultar.RetEnvioLote.evento.Items[0].evtTotal.IdeStatus.regOcorrs.Count - 1 do
          begin
            strDescErro := strDescErro + ACBrReinf.WebServices.Consultar.RetEnvioLote.evento.Items[0].evtTotal.IdeStatus.regOcorrs.Items[intCountErro].codResp + ' ' +
                                         ACBrReinf.WebServices.Consultar.RetEnvioLote.evento.Items[0].evtTotal.IdeStatus.regOcorrs.Items[intCountErro].dscResp + sLineBreak + sLineBreak;
          end;
        end;

        fStartTransaction;

        pAtualizaRetornoLote(ACBrReinf.WebServices.Consultar.RetEnvioLote.evento.Items[0].evtTotal.IdeStatus.cdRetorno,
                             IIF(not fEmptyStr(strDescErro), strDescErro, ACBrReinf.WebServices.Consultar.RetEnvioLote.evento.Items[0].evtTotal.IdeStatus.descRetorno),
                             strDescErro,
                             ACBrReinf.WebServices.Consultar.RetWS,
                             ACBrReinf.WebServices.Consultar.RetEnvioLote.evento.Items[0].Id,
                             IIF((fEmptyStr(strDescErro)) and (blnfecharMovimento), 'F', 'A'),
                             ACBrReinf.WebServices.Consultar.RetEnvioLote.evento.Items[0].evtTotal.InfoRecEv.nrRecArqBase);

        if fEmptyStr(strDescErro) then
          pFecharAbrirEventos;

        fCommit;

        blnProcessouLote := True;

        Break;
      end;
    end;
  except
    on E: Exception do
    begin
      fRollBack;
      pMensagensErro(E.Message, 'TfrmFechamentoReaberturaEventos.pConsultarLote');
    end;
  end;
end;

procedure TfrmFechamentoReaberturaEventos.pConsultarLote4099(var blnProcessouLote: Boolean);
const
  RETORNO_ERRO = '1';
var
  intCount,
  intCountErro: Integer;
  strDescErro: String;
begin
  if not fProntoParaConsultarProcessamentoDosLotes then
    Exit;

  try
    for intCount := 1 to 20 do
    begin
      if ACBrReinf.Consultar(cdsFechAbert.FieldByName('LOT_PROTOC').AsString) then
      begin

        if ACBrReinf.WebServices.Consultar.RetEnvioLote.evento.Count = 0 then
        begin
          Sleep(3000);
          Continue;
        end;

        strDescErro := EmptyStr;
        if ACBrReinf.WebServices.Consultar.RetConsulta_R9015.evtRetCons.IdeStatus.cdRetorno = RETORNO_ERRO then
        begin
          for intCountErro := 0 to ACBrReinf.WebServices.Consultar.RetConsulta_R9015.evtRetCons.IdeStatus.regOcorrs.Count - 1 do
          begin
            strDescErro := strDescErro + ACBrReinf.WebServices.Consultar.RetConsulta_R9015.evtRetCons.IdeStatus.regOcorrs.Items[intCountErro].codResp + ' ' +
                                         ACBrReinf.WebServices.Consultar.RetConsulta_R9015.evtRetCons.IdeStatus.regOcorrs.Items[intCountErro].dscResp + sLineBreak + sLineBreak;
          end;
        end;

        fStartTransaction;

        pAtualizaRetornoLote(ACBrReinf.WebServices.Consultar.RetConsulta_R9015.evtRetCons.IdeStatus.cdRetorno,
                             IIF(not fEmptyStr(strDescErro), strDescErro, ACBrReinf.WebServices.Consultar.RetConsulta_R9015.evtRetCons.IdeStatus.descRetorno),
                             strDescErro,
                             ACBrReinf.WebServices.Consultar.RetWS,
                             ACBrReinf.WebServices.Consultar.RetConsulta_R9015.evtRetCons.Id,
                             IIF((fEmptyStr(strDescErro)) and (blnfecharMovimento), 'F', 'A'),
                             ACBrReinf.WebServices.Consultar.RetConsulta_R9015.evtRetCons.InfoRecEv.nrRecArqBase);

        if fEmptyStr(strDescErro) then
          pFecharAbrirEventos;

        fCommit;

        blnProcessouLote := True;

        Break;
      end;
    end;
  except
    on E: Exception do
    begin
      fRollBack;
      pMensagensErro(E.Message, 'TfrmFechamentoReaberturaEventos.pConsultarLote');
    end;
  end;
end;

procedure TfrmFechamentoReaberturaEventos.pAtualizaRetornoLote(const strCodRet,
                                                                     strDesRet,
                                                                     strDescErro,
                                                                     strXmlRet,
                                                                     strIdeEve,
                                                                     strStatus,
                                                                     strRecibo: String);
var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  try
    qryAux.Close;
    qryAux.SQL.Text :=
    ' UPDATE '+
    '   REINF_LOTES '+
    ' SET '+
    '   LOT_CODRET = :CODRET '+
    '  ,LOT_DESRET = :DESRET '+
    '  ,LOT_XMLRET = :XMLRET '+
    '  ,LOT_IDEEVE = :IDEEVE '+
    '  ,LOT_STATUS = :STATUS '+
    IIF(fEmptyStr(strDescErro),
        '  ,LOT_RECIBO = :RECIBO ',
        '')+
    ' WHERE '+
    '   AUTOINCREM = :AUTINC ';

    qryAux.ParamByName('CODRET').AsString := strCodRet;
    qryAux.ParamByName('DESRET').AsString := strDesRet;
    qryAux.ParamByName('XMLRET').AsString := strXmlRet;
    qryAux.ParamByName('IDEEVE').AsString := strIdeEve;
    qryAux.ParamByName('STATUS').AsString := strStatus;

    if fEmptyStr(strDescErro)then
      qryAux.ParamByName('RECIBO').AsString := strRecibo;

    qryAux.ParamByName('AUTINC').AsString := cdsFechAbert.FieldByName('AUTOINCREM').AsString;
    qryAux.ExecSQL;
  finally
    FreeAndNil(qryAux);
  end;
end;

procedure TfrmFechamentoReaberturaEventos.pFecharAbrirEventos;
var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  try
    qryAux.Close;
    qryAux.SQL.Text :=
    ' UPDATE '+
    '   REINF_LOTES '+
    ' SET '+
    '   LOT_STATUS = :STATUS '+
    ' WHERE '+
    '   LOT_CODEMP = :CODEMP AND '+
    '   LOT_PERAPU = :PERAPU AND '+
    '   LOT_EVENTO IN ('+fRetSqlLotesQueSeraoFechadosOuAbertos+') ';

    qryAux.ParamByName('STATUS').AsString := IIF(blnfecharMovimento, 'F', 'A');
    qryAux.ParamByName('CODEMP').AsString := Self.strCodEmp;
    qryAux.ParamByName('PERAPU').AsString := edtPerApu.Text;
    qryAux.ExecSQL;
  finally
    FreeAndNil(qryAux);
  end;
end;

function TfrmFechamentoReaberturaEventos.fProntoParaConsultarProcessamentoDosLotes: Boolean;
begin
  Result := True;

  if fEmptyStr(Self.strCodEmp) then
    Exit(False);

  if not fReinfContribuinteAutorizado(Self.strCodEmp) then
    Exit(False);

  if not Assigned(cdsFechAbert) then
    Exit(False);

  if cdsFechAbert.IsEmpty then
    Exit(False);
end;

function TfrmFechamentoReaberturaEventos.fTemLoteComErro(var strAutoIncremLote: String): Boolean;
begin
  strAutoIncremLote := fCampoTabela('AUTOINCREM',
                       'REINF_LOTES',
                       ['LOT_CODEMP', 'LOT_PERAPU', 'LOT_EVENTO', 'LOT_CODRET'],
                       [Self.strCodEmp, edtPerApu.Text, fRetEvento, '1']);

  Result := not fEmptyStr(strAutoIncremLote);
end;

function TfrmFechamentoReaberturaEventos.fRetXmlEnvio: AnsiString;
begin
  Result := AnsiString(EmptyStr);

  case tpEvento of
    R2098: Result := ACBrReinf.Eventos.ReinfEventos.R2098.Items[0].evtReabreEvPer.XML;
    R2099: Result := ACBrReinf.Eventos.ReinfEventos.R2099.Items[0].evtFechaEvPer.XML;
    R4099: Result := ACBrReinf.Eventos.ReinfEventos.R4099.Items[0].evtFech.XML;
  end;
end;

function TfrmFechamentoReaberturaEventos.fRetSqlLotesQueSeraoFechadosOuAbertos: String;
begin
  Result := EmptyStr;

  case tpEvento of
    R2098, R2099: Result := '"R2010", "R2020"';
    R4099: Result := '"R4010", "R4020", "R4080"';
  end;
end;

end.
