unit untReinfEventos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, cxGraphics, cxControls, ACBrReinf, UniClientDataSet, Uni,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, System.StrUtils,
  cxDBData, Vcl.StdCtrls, Vcl.Mask, MaskEditFocus, cxGridLevel, System.UITypes, untTypesSistema,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGridCitel, cxGrid, frxClass, frxExportCSVTestabilidade,
  Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls,
  System.ImageList, Vcl.ImgList, cxImageList,
  cxImageComboBox, dxGDIPlusClasses, cxCheckBox, LabeledEditFocus;

type
  TfrmEventosReinf = class(TfrmPai)
    gpbServicos: TGroupBox;
    pnlbotoesTransmitidos: TPanel;
    btnBaixarXmlEnvio: TBitBtnLocked;
    btnBaixarXmlRetorno: TBitBtnLocked;
    cxgTransmitidos: TcxGridCitel;
    cxgTransmitidosDBTableViewCitel1: TcxGridDBTableViewCitel;
    cxgTransmitidosLOT_PERAPU: TcxGridDBColumn;
    cxgTransmitidosLOT_DTAENV: TcxGridDBColumn;
    cxgTransmitidosLOT_DESRET: TcxGridDBColumn;
    cxgTransmitidosLOT_IDEEVE: TcxGridDBColumn;
    cxgTransmitidosLOT_PROTOC: TcxGridDBColumn;
    cxgTransmitidosLOT_RECIBO: TcxGridDBColumn;
    cxgTransmitidosLOT_ORIRET: TcxGridDBColumn;
    cxgTransmitidosTOMADOR: TcxGridDBColumn;
    cxgTransmitidosPRESTADOR: TcxGridDBColumn;
    cxgTransmitidosFIS_TOTBRU: TcxGridDBColumn;
    cxgTransmitidosFIS_TOTRET: TcxGridDBColumn;
    cxgTransmitidosLevel1: TcxGridLevel;
    gpbNotas: TGroupBox;
    cxgNfs: TcxGridCitel;
    cxgNfsDBTableViewCitel1: TcxGridDBTableViewCitel;
    cxgNfsFIS_DTAENT: TcxGridDBColumn;
    cxgNfsFIS_DTADOC: TcxGridDBColumn;
    cxgNfsFIS_NUMDOC: TcxGridDBColumn;
    cxgNfsFIS_ESPDOC: TcxGridDBColumn;
    cxgNfsFIS_CODEMP: TcxGridDBColumn;
    cxgNfsFIS_CLFSC1: TcxGridDBColumn;
    cxgNfsFIS_VLRCON: TcxGridDBColumn;
    cxgNfsFIS_REINSS: TcxGridDBColumn;
    cxgNfsLevel1: TcxGridLevel;
    pnlSuperior: TPanel;
    cxgTransmitidosLOT_SITUAC: TcxGridDBColumn;
    tmrConsultarProcessamento: TTimer;
    btnConsultaLote: TBitBtnLocked;
    cxgTransmitidosLOT_STATUS: TcxGridDBColumn;
    SaveDialog: TSaveDialog;
    btnTransmitir: TBitBtnLocked;
    cxImageList: TcxImageList;
    pnlSuperiorDireito: TPanel;
    pnlSuperiorEsquerdo: TPanel;
    lblPerApur: TLabel;
    edtPerApu: TMaskEditFocus;
    btnCarregarPeríodo: TBitBtnLocked;
    imgNaoEnviado: TImage;
    lblNaoEnviado: TLabel;
    imgSucesso: TImage;
    lblSucesso: TLabel;
    imgRetificar: TImage;
    lblRetificar: TLabel;
    imgErro: TImage;
    lblErro: TLabel;
    cxgTransmitidosMARDES: TcxGridDBColumn;
    cxgTransmitidosCGCTOMADOR: TcxGridDBColumn;
    cxgTransmitidosCGCPRESTADOR: TcxGridDBColumn;
    cxgNfsFIS_REIRRF: TcxGridDBColumn;
    cxgNfsFIS_RECSSL: TcxGridDBColumn;
    cxgNfsFIS_VREPIS: TcxGridDBColumn;
    cxgNfsFIS_VRECOF: TcxGridDBColumn;
    cxgTransmitidosFIS_TOTRRF: TcxGridDBColumn;
    cxgTransmitidosFIS_TOTSSL: TcxGridDBColumn;
    cxgTransmitidosFIS_TOTPIS: TcxGridDBColumn;
    cxgTransmitidosFIS_TOTCOF: TcxGridDBColumn;
    cxgTransmitidosFIS_TIP_FC: TcxGridDBColumn;
    pnlTotais: TPanel;
    edtTotDoc: TLabeledEditFocus;
    edtTotImp1: TLabeledEditFocus;
    edtTotImp2: TLabeledEditFocus;
    edtTotImp3: TLabeledEditFocus;
    edtTotImp4: TLabeledEditFocus;
    cxgNfsFIS_TB01RE: TcxGridDBColumn;
    cxgNfsNAT_DESCRI: TcxGridDBColumn;
    cxgNfsFIS_TB06RE: TcxGridDBColumn;
    cxgNfsCLA_DESCRI: TcxGridDBColumn;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnTransmitirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxgTransmitidosDBTableViewCitel1DblClick(Sender: TObject);
    procedure tmrConsultarProcessamentoTimer(Sender: TObject);
    procedure btnConsultaLoteClick(Sender: TObject);
    procedure btnBaixarXmlEnvioClick(Sender: TObject);
    procedure btnBaixarXmlRetornoClick(Sender: TObject);
    procedure btnCarregarPeríodoClick(Sender: TObject);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
  private
    { Private declarations }

    qryCadFis: TUniQuery;
    cdsCadFis: TUniClientDataSet;
    dtsCadFis: TDataSource;

    qryNotas: TUniQuery;
    cdsNotas: TUniClientDataSet;
    dtsNotas: TDataSource;

    procedure pAjustaGridConformeEvento;
    procedure pAjustaTotaisConformeEvento;

    procedure pCarregarPeriodoDeApuracao;
    procedure pConfiguraDts;
    procedure pTotalizarLotes;
    function fRetTotaisLotes(const strField: String): String;

    procedure pConfiguraDtsNotas;
    procedure pAfterScrollCdsCadFis(DataSet: TDataSet);
    procedure pAjustaColunaValores;

    procedure pSeleciona(const strMarDes: String);

    function fRetEmpresas: String;

    function fRetSQLCadFis(const strEmpresas: String): String;
    function fRetSqlCadFisR2010R2020(const strEmpresas: String): String;
    function fRetSqlCadFisR4010R4020R4080(const strEmpresas: String): String;

    function fRetSQLCadFisDetalhado(const strEmpresas: String): String;
    function fRetSQLCadFisR2010R2020Detalhado(const strEmpresas: String): String;
    function fRetSQLCadFisR4010R4020R4080Detalhado(const strEmpresas: String): String;

    function fRetSQLWhereR4010R4020R4080(const strTipFC: String): String;

    function fRetEvento: String;

    function fTemLoteSelecionado: Boolean;
    function fSoSelecionouJaTransferidos: Boolean;
    function fLoteTemXml(tpXmlReinf: TtpXmlReinf): Boolean;

    procedure pFiltraSelecionados;
    procedure pRemoveFiltro;

    procedure pTransmitirR2010;
    procedure pTransmitirR2020;
    procedure pTransmitirR4010;
    procedure pTransmitirR4020;
    procedure pTransmitirR4080;

    function fProcessarTransmissao: Boolean;
    function fRetXmlEnvio: AnsiString;

    function fRetFisLotReiCADFIS: String;

    procedure pConsultarProcessamentoLote;
    procedure pConsultarLotePosicionado;

    procedure pConsultarLote2000(var blnProcessouLote: Boolean);
    procedure pConsultarLote4000(var blnProcessouLote: Boolean);

    procedure pAtualizaRetornoLote(const strCodRet,
                                   strDesRet,
                                   strDescErro,
                                   strXmlRet,
                                   strIdeEve,
                                   strRecibo: String);

    function fProntoParaConsultarProcessamentoDosLotes: Boolean;
    function fProntoParaTransmitirOuRetificarLote: Boolean;

    procedure pSalvarXmlEnvio;
    procedure pSalvarXmlRetorno;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }

    ACBrReinf: TACBrReinf;
    tpEvento: TtpEventoReinf;

    strCodEmp: String;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untGravando, pcnReinfR2010, pcnReinfR2020,
  pcnConversaoReinf, untMensagemExplicativa, ACBrUtil.DateTime, untFuncoes,
  untIntegracaoReinf, pcnReinfR4010, pcnReinfR4020, pcnReinfR4080;

procedure TfrmEventosReinf.FormCreate(Sender: TObject);
begin
  inherited;
  blnMudarFoco := False;
end;

procedure TfrmEventosReinf.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(dtsCadFis) then
    FreeAndNil(dtsCadFis);

  if Assigned(cdsCadFis) then
    FreeAndNil(cdsCadFis);

  if Assigned(qryCadFis) then
    FreeAndNil(qryCadFis);

  if Assigned(dtsNotas) then
    FreeAndNil(dtsNotas);

  if Assigned(cdsNotas) then
    FreeAndNil(cdsNotas);

  if Assigned(qryNotas) then
    FreeAndNil(qryNotas);
end;

procedure TfrmEventosReinf.FormShow(Sender: TObject);
begin
  inherited;

  if fEmptyStr(Self.strCodEmp) then
    Exit;

  pAjustaGridConformeEvento;
  pAjustaTotaisConformeEvento;

  pSetFocus(edtPerApu);
end;

procedure TfrmEventosReinf.pAjustaGridConformeEvento;
begin
  case tpEvento of
    R2010, R2020: begin
                    cxgTransmitidosFIS_TOTRET.Visible := True;
                    cxgNfsFIS_REINSS.Visible := True;
                    cxgNfsFIS_TB01RE.Visible := False;
                    cxgNfsNAT_DESCRI.Visible := False;
                    cxgNfsFIS_TB06RE.Visible := True;
                    cxgNfsCLA_DESCRI.Visible := True;
                  end;
    R4010, R4020,
    R4080:        begin
                    cxgTransmitidosFIS_TOTRRF.Visible := True;
                    cxgNfsFIS_REIRRF.Visible := True;
                    cxgNfsFIS_TB01RE.Visible := True;
                    cxgNfsNAT_DESCRI.Visible := True;
                    cxgNfsFIS_TB06RE.Visible := False;
                    cxgNfsCLA_DESCRI.Visible := False;

                    if tpEvento in [R4010, R4020] then
                    begin
                      cxgTransmitidosTOMADOR.Caption := 'Estabelecimento';
                      cxgTransmitidosCGCTOMADOR.Caption := 'CNPJ Estabelecimento';
                      cxgTransmitidosPRESTADOR.Caption := 'Beneficiário';
                      cxgTransmitidosCGCPRESTADOR.Caption := IIF(tpEvento = R4010, 'CPF', 'CNPJ') + ' Beneficiário';
                    end
                    else if tpEvento = R4080 then
                    begin
                      cxgTransmitidosPRESTADOR.Caption := 'Estabelecimento';
                      cxgTransmitidosCGCPRESTADOR.Caption := 'CNPJ Estabelecimento';
                      cxgTransmitidosTOMADOR.Caption := 'Fonte Pagadora';
                      cxgTransmitidosCGCTOMADOR.Caption := 'CNPJ Fonte Pagadora';
                    end;

                    if tpEvento = R4020 then
                    begin
                      cxgTransmitidosFIS_TOTSSL.Visible := True;
                      cxgTransmitidosFIS_TOTPIS.Visible := True;
                      cxgTransmitidosFIS_TOTCOF.Visible := True;
                      cxgNfsFIS_RECSSL.Visible := True;
                      cxgNfsFIS_VREPIS.Visible := True;
                      cxgNfsFIS_VRECOF.Visible := True;
                    end;
                  end;
  end;

  if tpEvento in [R2020, R4080] then
  begin
    cxgTransmitidosPRESTADOR.Index := cxgTransmitidosPRESTADOR.Index-3;
    cxgTransmitidosCGCPRESTADOR.Index := cxgTransmitidosCGCPRESTADOR.Index-3;
    cxgTransmitidosFIS_TIP_FC.Index := cxgTransmitidosFIS_TIP_FC.Index-2;
  end;
end;

procedure TfrmEventosReinf.pAjustaTotaisConformeEvento;
begin
  edtTotDoc.Visible := True;
  edtTotDoc.Left := 329;

  case tpEvento of
    R2010, R2020: begin
                    edtTotImp1.Visible := True;
                    edtTotImp1.EditLabel.Caption := 'Total Ret.';
                    edtTotImp1.Left := edtTotDoc.Left;
                    edtTotDoc.Left := edtTotDoc.Left - (edtTotImp1.Width+1);
                  end;

    R4010, R4020, R4080: begin
                           edtTotImp1.Visible := True;
                           edtTotImp1.EditLabel.Caption := 'Total IR';
                           edtTotImp1.Left := edtTotDoc.Left;
                           edtTotDoc.Left := edtTotDoc.Left - (edtTotImp1.Width+1);

                           if tpEvento = R4020 then
                           begin
                             edtTotImp2.Visible := True;
                             edtTotImp2.EditLabel.Caption := 'Total CSLL';
                             edtTotImp2.Left := edtTotImp1.Left;
                             edtTotDoc.Left := edtTotDoc.Left - (edtTotImp2.Width+1);
                             edtTotImp1.Left := edtTotImp1.Left - (edtTotImp2.Width+1);

                             edtTotImp3.Visible := True;
                             edtTotImp3.EditLabel.Caption := 'Total PIS';
                             edtTotImp3.Left := edtTotImp2.Left;
                             edtTotDoc.Left := edtTotDoc.Left - (edtTotImp3.Width+1);
                             edtTotImp1.Left := edtTotImp1.Left - (edtTotImp3.Width+1);
                             edtTotImp2.Left := edtTotImp2.Left - (edtTotImp3.Width+1);

                             edtTotImp4.Visible := True;
                             edtTotImp4.EditLabel.Caption := 'Total COFINS';
                             edtTotImp4.Left := edtTotImp3.Left;
                             edtTotDoc.Left := edtTotDoc.Left - (edtTotImp4.Width+1);
                             edtTotImp1.Left := edtTotImp1.Left - (edtTotImp4.Width+1);
                             edtTotImp2.Left := edtTotImp2.Left - (edtTotImp4.Width+1);
                             edtTotImp3.Left := edtTotImp3.Left - (edtTotImp4.Width+1);
                           end;
                         end;
  end;
end;

procedure TfrmEventosReinf.cxgTransmitidosDBTableViewCitel1DblClick(
  Sender: TObject);
begin
  inherited;
  if not Assigned(cdsCadFis) then
    Exit;

  if cdsCadFis.IsEmpty then
    Exit;

  TfrmMensagemExplicativa.pMensagem(cdsCadFis.FieldByName('LOT_DESRET').AsString);
end;

function TfrmEventosReinf.fValidaCampos(Sender: TWinControl;
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
      end;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmEventosReinf.pAfterScrollCdsCadFis(DataSet: TDataSet);
begin
  if not Assigned(cdsCadFis) then
    Exit;

  if cdsCadFis.IsEmpty then
    Exit;

  btnConsultaLote.Visible := (DataSet.FieldByName('LOT_CODRET').AsString = '1') or (DataSet.FieldByName('LOT_CODRET').AsString = '2');

  cdsNotas.Filtered := False;
  cdsNotas.Filter := 'FIS_FORCLI = '+DataSet.FieldByName('FIS_FORCLI').AsString;
  cdsNotas.Filtered := True;
end;

procedure TfrmEventosReinf.pCarregarPeriodoDeApuracao;
var
  strEmpresas: String;
  qryNotas: TUniQuery;
begin
  if fEmptyStr(Self.strCodEmp) then
    Exit;

  strEmpresas := fRetEmpresas;

  if not Assigned(qryCadFis) then
    qryCadFis := fCriaQuery(Self);

  qryCadFis.Close;
  qryCadFis.SQL.Text := fRetSQLCadFis(strEmpresas);
  qryCadFis.ParamByName('PERAPU').AsString := FormatDateBr(StrToDate('01/'+edtPerApu.Text), 'yyyy-mm-dd');
  qryCadFis.ParamByName('CODEMP').AsString := self.strCodEmp;
  qryCadFis.Open;

  if Assigned(cdsCadFis) then
  begin
    FreeAndNil(dtsCadFis);
    FreeAndNil(cdsCadFis);
  end;

  cdsCadFis := fCriaClientDatset(qryCadFis);
  pConfiguraDts;
  pTotalizarLotes;

  qryNotas := fCriaQuery(Self);
  try
    qryNotas.Close;
    qryNotas.SQL.Text := fRetSQLCadFisDetalhado(strEmpresas);
    qryNotas.ParamByName('PERAPU').AsString := FormatDateBr(StrToDate('01/'+edtPerApu.Text), 'yyyy-mm-dd');
    qryNotas.Open;

    if Assigned(cdsNotas) then
    begin
      FreeAndNil(dtsNotas);
      FreeAndNil(cdsNotas);
    end;

    cdsNotas := fCriaClientDatset(qryNotas);
  finally
    FreeAndNil(qryNotas);
  end;

  pConfiguraDtsNotas;
  pAfterScrollCdsCadFis(cdsCadFis);

  pAjustaColunaValores;
end;

procedure TfrmEventosReinf.pConfiguraDts;
begin
  TFloatField(cdsCadFis.FieldByName('FIS_TOTBRU')).DisplayFormat := '#,##0.00';
  case tpEvento of
    R2010, R2020: TFloatField(cdsCadFis.FieldByName('FIS_TOTRET')).DisplayFormat := '#,##0.00';
    R4010, R4020, R4080: begin
                           TFloatField(cdsCadFis.FieldByName('FIS_TOTRRF')).DisplayFormat := '#,##0.00';
                           if tpEvento = R4020 then
                           begin
                             TFloatField(cdsCadFis.FieldByName('FIS_TOTSSL')).DisplayFormat := '#,##0.00';
                             TFloatField(cdsCadFis.FieldByName('FIS_TOTPIS')).DisplayFormat := '#,##0.00';
                             TFloatField(cdsCadFis.FieldByName('FIS_TOTCOF')).DisplayFormat := '#,##0.00';
                           end;
                         end;
  end;

  pSetaClient(cdsCadFis);
  dtsCadFis := fCriaDataSource(cdsCadFis);
  cxgTransmitidosDBTableViewCitel1.DataController.DataSource := dtsCadFis;

  cxgTransmitidosDBTableViewCitel1.BeginUpdate;
  try
    cxgTransmitidosDBTableViewCitel1.ApplyBestFit();
  finally
    cxgTransmitidosDBTableViewCitel1.EndUpdate;
  end;

  cdsCadFis.AfterScroll := pAfterScrollCdsCadFis;
end;

procedure TfrmEventosReinf.pConfiguraDtsNotas;
begin
  TFloatField(cdsNotas.FieldByName('FIS_VLRCON')).DisplayFormat := '#,##0.00';
  case tpEvento of
    R2010, R2020: TFloatField(cdsNotas.FieldByName('FIS_REINSS')).DisplayFormat := '#,##0.00';
    R4010, R4020: begin
                    TFloatField(cdsNotas.FieldByName('FIS_REIRRF')).DisplayFormat := '#,##0.00';
                    if tpEvento = R4020 then
                    begin
                      TFloatField(cdsNotas.FieldByName('FIS_RECSSL')).DisplayFormat := '#,##0.00';
                      TFloatField(cdsNotas.FieldByName('FIS_VREPIS')).DisplayFormat := '#,##0.00';
                      TFloatField(cdsNotas.FieldByName('FIS_VRECOF')).DisplayFormat := '#,##0.00';
                    end;
                  end;
  end;

  pSetaClient(cdsNotas);
  dtsNotas := fCriaDataSource(cdsNotas);
  cxgNfsDBTableViewCitel1.DataController.DataSource := dtsNotas;

  cxgNfsDBTableViewCitel1.BeginUpdate;
  try
    cxgNfsDBTableViewCitel1.ApplyBestFit();
  finally
    cxgNfsDBTableViewCitel1.EndUpdate;
  end;
end;

procedure TfrmEventosReinf.pAjustaColunaValores;
begin
  cxgTransmitidosFIS_TOTBRU.Width := 92;
  cxgTransmitidosFIS_TOTRET.Width := 92;
  cxgTransmitidosFIS_TOTRRF.Width := 92;
  cxgTransmitidosFIS_TOTSSL.Width := 92;
  cxgTransmitidosFIS_TOTPIS.Width := 92;
  cxgTransmitidosFIS_TOTCOF.Width := 92;

  cxgNfsFIS_VLRCON.Width := 92;
  cxgNfsFIS_REINSS.Width := 92;
  cxgNfsFIS_REIRRF.Width := 92;
  cxgNfsFIS_RECSSL.Width := 92;
  cxgNfsFIS_VREPIS.Width := 92;
  cxgNfsFIS_VRECOF.Width := 92;
end;

procedure TfrmEventosReinf.btnTransmitirClick(Sender: TObject);
begin
  inherited;
  if not fProntoParaTransmitirOuRetificarLote then
    Exit;

  if not fTemLoteSelecionado then
    Exit;

  if fSoSelecionouJaTransferidos then
    Exit;

  try
    pFiltraSelecionados;

    if cdsCadFis.FieldByName('LOT_STATUS').AsString = 'FECHADO' then
    begin
      fMensagem('ATENÇÃO!', 'O período de apuração encontra-se fechado.'+sLineBreak+
                            'É necessário reabrir o movimento do período desejado para fazer a transmissão!', ['&Ok']);
      Exit;
    end;

    if not fPergunta('Deseja transmitir o evento '+fRetEvento+' referente ao período de apuração '+edtPerApu.Text+'?') then
      Exit;

    if tpEvento = R2010 then
      TfrmGravando.fExecutarModal(pTransmitirR2010, 'Transmitindo R2010', '')
    else if tpEvento = R2020 then
      TfrmGravando.fExecutarModal(pTransmitirR2020, 'Transmitindo R2020', '')
    else if tpEvento = R4010 then
      TfrmGravando.fExecutarModal(pTransmitirR4010, 'Transmitindo R4010', '')
    else if tpEvento = R4020 then
      TfrmGravando.fExecutarModal(pTransmitirR4020, 'Transmitindo R4020', '')
    else if tpEvento = R4080 then
      TfrmGravando.fExecutarModal(pTransmitirR4080, 'Transmitindo R4080', '');

  finally
    pRemoveFiltro;
  end;
end;

procedure TfrmEventosReinf.pTotalizarLotes;
begin
  edtTotDoc.Text := fRetTotaisLotes('FIS_TOTBRU');

  case tpEvento of
    R2010, R2020: edtTotImp1.Text := fRetTotaisLotes('FIS_TOTRET');

    R4010, R4020, R4080: begin
                           edtTotImp1.Text := fRetTotaisLotes('FIS_TOTRRF');

                           if tpEvento = R4020 then
                           begin
                             edtTotImp2.Text := fRetTotaisLotes('FIS_TOTSSL');
                             edtTotImp3.Text := fRetTotaisLotes('FIS_TOTPIS');
                             edtTotImp4.Text := fRetTotaisLotes('FIS_TOTCOF');
                           end;
                         end;
  end;
end;

function TfrmEventosReinf.fRetTotaisLotes(const strField: String): String;
var
  fltTotal: Double;
begin
  Result := FormatFloat('#,##0.00', 0.00);
  fltTotal := 0.00;

  if not Assigned(cdsCadFis) then
    Exit;

  try
    cdsCadFis.DisableControls;
    cdsCadFis.AfterScroll := nil;

    cdsCadFis.First;
    while not cdsCadFis.Eof do
    begin
      fltTotal := fltTotal + cdsCadFis.FieldByName(strField).AsFloat;
      cdsCadFis.Next;
    end;

    Result := FormatFloat('#,##0.00', fltTotal);

    cdsCadFis.First;
  finally
    cdsCadFis.EnableControls;
    cdsCadFis.AfterScroll := pAfterScrollCdsCadFis;
  end;
end;

procedure TfrmEventosReinf.pTransmitirR2010;
var
  objR2010: TR2010CollectionItem;
  objNfs: pcnReinfR2010.TnfsCollectionItem;
  objInfoTpServ: pcnReinfR2010.TinfoTpServCollectionItem;

  blnTransmitiu: Boolean;
begin
  blnTransmitiu := False;

  cdsCadFis.First;
  while not cdsCadFis.Eof do
  begin
    if cdsCadFis.FieldByName('LOT_SITUAC').AsString = '3' then
    begin
      cdsCadFis.Next;
      Continue;
    end;

    ACBrReinf.Eventos.Clear;
    ACBrReinf.Eventos.ReinfEventos.R2010.Clear;
    objR2010 := ACBrReinf.Eventos.ReinfEventos.R2010.New;

    objR2010.evtServTom.Sequencial := 0;

    objR2010.evtServTom.ideEvento.indRetif := trOriginal;
    if not fEmptyStr(cdsCadFis.FieldByName('LOT_RECIBO').AsString) then
    begin
      objR2010.evtServTom.ideEvento.indRetif := trRetificacao;
      objR2010.evtServTom.ideEvento.NrRecibo := cdsCadFis.FieldByName('LOT_RECIBO').AsString;
    end;

    objR2010.evtServTom.ideEvento.perApur := FormatDateBr(StrToDate('01/'+edtPerApu.Text), 'yyyy-mm');

    objR2010.evtServTom.ideEvento.ProcEmi := peAplicEmpregador;
    objR2010.evtServTom.ideEvento.VerProc := '1.0';

    objR2010.evtServTom.ideContri.TpInsc := tiCNPJ;
    objR2010.evtServTom.ideContri.NrInsc := ACBrReinf.Configuracoes.Geral.IdContribuinte;

    objR2010.evtServTom.infoServTom.ideEstabObra.indObra := ioNaoeObraDeConstrucaoCivil;
    objR2010.evtServTom.infoServTom.ideEstabObra.tpInscEstab := tiCNPJ;
    objR2010.evtServTom.infoServTom.ideEstabObra.nrInscEstab := fTiraCaracEspeciais(cdsCadFis.FieldByName('CGCTOMADOR').AsString, True, False, True);

    objR2010.evtServTom.infoServTom.ideEstabObra.idePrestServ.cnpjPrestador := cdsCadFis.FieldByName('FOR_C_G_C_').AsString; //cnpj do fornecedor prestador
    objR2010.evtServTom.infoServTom.ideEstabObra.idePrestServ.vlrTotalBruto := cdsCadFis.FieldByName('FIS_TOTBRU').AsFloat; //valor total das notas
    objR2010.evtServTom.infoServTom.ideEstabObra.idePrestServ.vlrTotalBaseRet := cdsCadFis.FieldByName('FIS_TOTBRU').AsFloat;////valor total das notas
    objR2010.evtServTom.infoServTom.ideEstabObra.idePrestServ.vlrTotalRetPrinc := cdsCadFis.FieldByName('FIS_TOTRET').AsFloat; //valor total retido
    objR2010.evtServTom.infoServTom.ideEstabObra.idePrestServ.vlrTotalRetAdic := 0.0;//vai fixo
    objR2010.evtServTom.infoServTom.ideEstabObra.idePrestServ.vlrTotalNRetPrinc := 0.0;//vai fixo
    objR2010.evtServTom.infoServTom.ideEstabObra.idePrestServ.vlrTotalNRetAdic := 0.0;//vai fixo

    objR2010.evtServTom.infoServTom.ideEstabObra.idePrestServ.indCPRB := IIF(cdsCadFis.FieldByName('FOR_C_CPRB').AsString = '0',
                                                                             icNaoContribuintePrevidenciariaReceitaBruta,
                                                                             icContribuintePrevidenciaReceitaBruta);

    objR2010.evtServTom.infoServTom.ideEstabObra.idePrestServ.nfs.Clear;
    cdsNotas.First;
    while not cdsNotas.Eof do
    begin
      objNfs := objR2010.evtServTom.infoServTom.ideEstabObra.idePrestServ.nfs.New;
      objNfs.serie := IIF(not fEmptyStr(cdsNotas.FieldByName('FIS_SERIE_').AsString), cdsNotas.FieldByName('FIS_SERIE_').AsString, '1');
      objNfs.numDocto := cdsNotas.FieldByName('FIS_NUMDOC').AsString;
      objNfs.dtEmissaoNF := cdsNotas.FieldByName('FIS_DTAENT').AsDateTime;
      objNfs.vlrBruto := cdsNotas.FieldByName('FIS_VLRCON').AsFloat;  //valor total da nota
      objNfs.obs := EmptyStr; //vai fixo

      objNfs.infoTpServ.Clear;
      objInfoTpServ := objNfs.infoTpServ.New;
      objInfoTpServ.tpServico := cdsNotas.FieldByName('FIS_TB06RE').AsString;
      objInfoTpServ.vlrBaseRet := cdsNotas.FieldByName('FIS_VLRCON').AsFloat; //valor total da nota
      objInfoTpServ.vlrRetencao := cdsNotas.FieldByName('FIS_REINSS').AsFloat; // valor total retido na nota
      objInfoTpServ.vlrRetSub := 0.00;//vai fixo
      objInfoTpServ.vlrNRetPrinc := 0.00;//vai fixo
      objInfoTpServ.vlrServicos15 := 0.00;//vai fixo
      objInfoTpServ.vlrServicos20 := 0.00;//vai fixo
      objInfoTpServ.vlrServicos25 := 0.00;//vai fixo
      objInfoTpServ.vlrAdicional := 0.00;//vai fixo
      objInfoTpServ.vlrNRetAdic := 0.00;//vai fixo

      cdsNotas.Next;
    end;

    objR2010.evtServTom.infoServTom.ideEstabObra.idePrestServ.infoProcRetPr.Clear;
    objR2010.evtServTom.infoServTom.ideEstabObra.idePrestServ.infoProcRetAd.Clear;

    ACBrReinf.Eventos.Gerar;
    ACBrReinf.Eventos.Assinar;

    if (ACBrReinf.Enviar) and (not fProcessarTransmissao) then
      Break;

    blnTransmitiu := True;
    cdsCadFis.Next;
  end;

  if blnTransmitiu then
  begin
    pCarregarPeriodoDeApuracao;
    tmrConsultarProcessamento.Enabled := True;
  end;
end;

procedure TfrmEventosReinf.pTransmitirR2020;
var
  objR2020: TR2020CollectionItem;
  objNfs: pcnReinfR2020.TnfsCollectionItem;
  objInfoTpServ: pcnReinfR2020.TinfoTpServCollectionItem;

  blnTransmitiu: Boolean;
begin
  blnTransmitiu := False;

  cdsCadFis.First;
  while not cdsCadFis.Eof do
  begin
    if cdsCadFis.FieldByName('LOT_SITUAC').AsString = '3' then
    begin
      cdsCadFis.Next;
      Continue;
    end;

    ACBrReinf.Eventos.Clear;
    ACBrReinf.Eventos.ReinfEventos.R2020.Clear;
    objR2020 := ACBrReinf.Eventos.ReinfEventos.R2020.New;

    objR2020.evtServPrest.Sequencial := 0;

    objR2020.evtServPrest.ideEvento.indRetif := trOriginal;
    if not fEmptyStr(cdsCadFis.FieldByName('LOT_RECIBO').AsString) then
    begin
      objR2020.evtServPrest.ideEvento.indRetif := trRetificacao;
      objR2020.evtServPrest.ideEvento.NrRecibo := cdsCadFis.FieldByName('LOT_RECIBO').AsString;
    end;

    objR2020.evtServPrest.ideEvento.perApur := FormatDateBr(StrToDate('01/'+edtPerApu.Text), 'yyyy-mm');

    objR2020.evtServPrest.ideEvento.ProcEmi := peAplicEmpregador;
    objR2020.evtServPrest.ideEvento.VerProc := '1.0';

    objR2020.evtServPrest.ideContri.TpInsc := tiCNPJ;
    objR2020.evtServPrest.ideContri.NrInsc := ACBrReinf.Configuracoes.Geral.IdContribuinte;

    objR2020.evtServPrest.infoServPrest.ideEstabPrest.tpInscEstabPrest := tiCNPJ;
    objR2020.evtServPrest.infoServPrest.ideEstabPrest.nrInscEstabPrest := fTiraCaracEspeciais(cdsCadFis.FieldByName('CGCPRESTADOR').AsString, True, False, True);

    objR2020.evtServPrest.infoServPrest.ideEstabPrest.ideTomador.tpInscTomador := tiCNPJ;
    objR2020.evtServPrest.infoServPrest.ideEstabPrest.ideTomador.nrInscTomador := cdsCadFis.FieldByName('CLI_C_G_C_').AsString; //cnpj do fornecedor prestador
    objR2020.evtServPrest.infoServPrest.ideEstabPrest.ideTomador.indObra := ioNaoeObraDeConstrucaoCivil;
    objR2020.evtServPrest.infoServPrest.ideEstabPrest.ideTomador.vlrTotalBruto := cdsCadFis.FieldByName('FIS_TOTBRU').AsFloat; //valor total das notas
    objR2020.evtServPrest.infoServPrest.ideEstabPrest.ideTomador.vlrTotalBaseRet := cdsCadFis.FieldByName('FIS_TOTBRU').AsFloat;////valor total das notas
    objR2020.evtServPrest.infoServPrest.ideEstabPrest.ideTomador.vlrTotalRetPrinc := cdsCadFis.FieldByName('FIS_TOTRET').AsFloat; //valor total retido
    objR2020.evtServPrest.infoServPrest.ideEstabPrest.ideTomador.vlrTotalRetAdic := 0.0;//vai fixo
    objR2020.evtServPrest.infoServPrest.ideEstabPrest.ideTomador.vlrTotalNRetPrinc := 0.0;//vai fixo
    objR2020.evtServPrest.infoServPrest.ideEstabPrest.ideTomador.vlrTotalNRetAdic := 0.0;//vai fixo

    objR2020.evtServPrest.infoServPrest.ideEstabPrest.ideTomador.nfs.Clear;
    cdsNotas.First;
    while not cdsNotas.Eof do
    begin
      objNfs := objR2020.evtServPrest.infoServPrest.ideEstabPrest.ideTomador.nfs.New;
      objNfs.serie := IIF(not fEmptyStr(cdsNotas.FieldByName('FIS_SERIE_').AsString), cdsNotas.FieldByName('FIS_SERIE_').AsString, '1');
      objNfs.numDocto := cdsNotas.FieldByName('FIS_NUMDOC').AsString;
      objNfs.dtEmissaoNF := cdsNotas.FieldByName('FIS_DTAENT').AsDateTime;
      objNfs.vlrBruto := cdsNotas.FieldByName('FIS_VLRCON').AsFloat;
      objNfs.obs := EmptyStr;

      objNfs.infoTpServ.Clear;
      objInfoTpServ := objNfs.infoTpServ.New;
      objInfoTpServ.tpServico := cdsNotas.FieldByName('FIS_TB06RE').AsString;
      objInfoTpServ.vlrBaseRet := cdsNotas.FieldByName('FIS_VLRCON').AsFloat;
      objInfoTpServ.vlrRetencao := cdsNotas.FieldByName('FIS_REINSS').AsFloat;
      objInfoTpServ.vlrRetSub := 0.00;
      objInfoTpServ.vlrNRetPrinc := 0.00;
      objInfoTpServ.vlrServicos15 := 0.00;
      objInfoTpServ.vlrServicos20 := 0.00;
      objInfoTpServ.vlrServicos25 := 0.00;
      objInfoTpServ.vlrAdicional := 0.00;
      objInfoTpServ.vlrNRetAdic := 0.00;

      cdsNotas.Next;
    end;

    objR2020.evtServPrest.infoServPrest.ideEstabPrest.ideTomador.infoProcRetPr.Clear;
    objR2020.evtServPrest.infoServPrest.ideEstabPrest.ideTomador.infoProcRetAd.Clear;

    ACBrReinf.Eventos.Gerar;
    ACBrReinf.Eventos.Assinar;

    if (ACBrReinf.Enviar) and (not fProcessarTransmissao) then
      Break;

    blnTransmitiu := True;

    cdsCadFis.Next;
  end;

  if blnTransmitiu then
  begin
    pCarregarPeriodoDeApuracao;
    tmrConsultarProcessamento.Enabled := True;
  end;
end;

procedure TfrmEventosReinf.pTransmitirR4010;
var
  objR4010: TR4010CollectionItem;
  objIdePgto: pcnReinfR4010.TidePgtoCollectionItem;
  objInfoPgto: pcnReinfR4010.TinfoPgtoCollectionItem;

  blnTransmitiu: Boolean;
  strNatRend: String;
begin
  objIdePgto := nil;
  blnTransmitiu := False;

  cdsCadFis.First;
  while not cdsCadFis.Eof do
  begin
    if cdsCadFis.FieldByName('LOT_SITUAC').AsString = '3' then
    begin
      cdsCadFis.Next;
      Continue;
    end;

    ACBrReinf.Eventos.Clear;
    ACBrReinf.Eventos.ReinfEventos.R4010.Clear;
    objR4010 := ACBrReinf.Eventos.ReinfEventos.R4010.New;

    objR4010.evtRetPF.Sequencial := 0;

    objR4010.evtRetPF.ideEvento.indRetif := trOriginal;
    if not fEmptyStr(cdsCadFis.FieldByName('LOT_RECIBO').AsString) then
    begin
      objR4010.evtRetPF.ideEvento.indRetif := trRetificacao;
      objR4010.evtRetPF.ideEvento.NrRecibo := cdsCadFis.FieldByName('LOT_RECIBO').AsString;
    end;

    objR4010.evtRetPF.ideEvento.perApur := FormatDateBr(StrToDate('01/'+edtPerApu.Text), 'yyyy-mm');

    objR4010.evtRetPF.ideEvento.ProcEmi := peAplicEmpregador;
    objR4010.evtRetPF.ideEvento.VerProc := '1.0';

    objR4010.evtRetPF.ideContri.TpInsc := tiCNPJ;
    objR4010.evtRetPF.ideContri.NrInsc := ACBrReinf.Configuracoes.Geral.IdContribuinte;

    objR4010.evtRetPF.ideEstab.tpInscEstab := tiCNPJ;
    objR4010.evtRetPF.ideEstab.nrInscEstab := ACBrReinf.Configuracoes.Geral.IdContribuinte;

    objR4010.evtRetPF.ideEstab.ideBenef.cpfBenef := cdsCadFis.FieldByName('FC_C_G_C_').AsString;
    //objR4010.evtRetPF.ideEstab.ideBenef.nmBenef := cdsCadFis.FieldByName('PRESTADOR').AsString;

    strNatRend := EmptyStr;
    objR4010.evtRetPF.ideEstab.ideBenef.idePgto.Clear;
    while not cdsNotas.Eof do
    begin
      if strNatRend <> cdsNotas.FieldByName('FIS_TB01RE').AsString then
      begin
        objIdePgto := objR4010.evtRetPF.ideEstab.ideBenef.idePgto.New;
        objIdePgto.natRend := cdsNotas.FieldByName('FIS_TB01RE').AsString;
        //objIdePgto.observ := 'Observações';

        objIdePgto.infoPgto.Clear;
      end;

      objInfoPgto := objIdePgto.infoPgto.New;
      objInfoPgto.dtFG         := cdsNotas.FieldByName('FIS_DTPGRC').AsDateTime;

      if Copy(cdsNotas.FieldByName('FIS_TB01RE').AsString,0,2) = '10' then
        objInfoPgto.compFP       := StrToDate('01/'+edtPerApu.Text); //preecher apenas se o natRend começar com 10 ou se na coluna 13º tiver S

      //objInfoPgto.indDecTerc   := 'S'; //se no natRend tiver S na coluna 13º // Ronaldo pediu pra não mandar em nenhuma hipótese, por isso está comentado
      objInfoPgto.vlrRendBruto := cdsNotas.FieldByName('FIS_VLRCON').AsFloat;
      objInfoPgto.vlrRendTrib  := cdsNotas.FieldByName('FIS_VLRCON').AsFloat;
      objInfoPgto.vlrIR        := cdsNotas.FieldByName('FIS_REIRRF').AsFloat;

      strNatRend := cdsNotas.FieldByName('FIS_TB01RE').AsString;

      cdsNotas.Next;
    end;

    ACBrReinf.Eventos.Gerar;
    ACBrReinf.Eventos.Assinar;

    if (ACBrReinf.Enviar) and (not fProcessarTransmissao) then
      Break;

    blnTransmitiu := True;

    cdsCadFis.Next;
  end;

  if blnTransmitiu then
  begin
    pCarregarPeriodoDeApuracao;
    tmrConsultarProcessamento.Enabled := True;
  end;
end;

procedure TfrmEventosReinf.pTransmitirR4020;
var
  objR4020: TR4020CollectionItem;
  objIdePgto: pcnReinfR4020.TidePgtoCollectionItem;
  objInfoPgto: pcnReinfR4020.TinfoPgtoCollectionItem;

  blnTransmitiu: Boolean;
  strNatRend: String;
begin
  objIdePgto := nil;
  blnTransmitiu := False;

  cdsCadFis.First;
  while not cdsCadFis.Eof do
  begin
    if cdsCadFis.FieldByName('LOT_SITUAC').AsString = '3' then
    begin
      cdsCadFis.Next;
      Continue;
    end;

    ACBrReinf.Eventos.Clear;
    ACBrReinf.Eventos.ReinfEventos.R4020.Clear;

    objR4020 := ACBrReinf.Eventos.ReinfEventos.R4020.New;

    objR4020.evtRetPJ.Sequencial := 0;

    objR4020.evtRetPJ.ideEvento.indRetif := trOriginal;
    if not fEmptyStr(cdsCadFis.FieldByName('LOT_RECIBO').AsString) then
    begin
      objR4020.evtRetPJ.ideEvento.indRetif := trRetificacao;
      objR4020.evtRetPJ.ideEvento.NrRecibo := cdsCadFis.FieldByName('LOT_RECIBO').AsString;
    end;

    objR4020.evtRetPJ.ideEvento.perApur := FormatDateBr(StrToDate('01/'+edtPerApu.Text), 'yyyy-mm');

    objR4020.evtRetPJ.ideEvento.ProcEmi := peAplicEmpregador;
    objR4020.evtRetPJ.ideEvento.VerProc := '1.0';

    objR4020.evtRetPJ.ideContri.TpInsc := tiCNPJ;
    objR4020.evtRetPJ.ideContri.NrInsc := ACBrReinf.Configuracoes.Geral.IdContribuinte;

    objR4020.evtRetPJ.ideEstab.tpInscEstab := tiCNPJ;
    objR4020.evtRetPJ.ideEstab.nrInscEstab := ACBrReinf.Configuracoes.Geral.IdContribuinte;

    objR4020.evtRetPJ.ideEstab.ideBenef.cnpjBenef := cdsCadFis.FieldByName('FC_C_G_C_').AsString;
    objR4020.evtRetPJ.ideEstab.ideBenef.isenImun := tiiNenhum;

    strNatRend := EmptyStr;
    objR4020.evtRetPJ.ideEstab.ideBenef.idePgto.Clear;
    while not cdsNotas.Eof do
    begin
      if strNatRend <> cdsNotas.FieldByName('FIS_TB01RE').AsString then
      begin
        objIdePgto := objR4020.evtRetPJ.ideEstab.ideBenef.idePgto.New;
        objIdePgto.natRend := cdsNotas.FieldByName('FIS_TB01RE').AsString;

        objIdePgto.infoPgto.Clear;
      end;

      objInfoPgto := objIdePgto.infoPgto.New;
      objInfoPgto.dtFG         := cdsNotas.FieldByName('FIS_DTPGRC').AsDateTime;
      objInfoPgto.vlrBruto     := cdsNotas.FieldByName('FIS_VLRCON').AsFloat;

      objInfoPgto.retencoes.vlrBaseIR     := cdsNotas.FieldByName('FIS_VLRCON').AsFloat;
      objInfoPgto.retencoes.vlrIR         := cdsNotas.FieldByName('FIS_REIRRF').AsFloat;

      objInfoPgto.retencoes.vlrBaseAgreg  := 0.0;
      objInfoPgto.retencoes.vlrAgreg      := 0.0;

      If (fFormataFloat(cdsNotas.FieldByName('FIS_RECSSL').AsFloat, 2) <> 0) Then
      Begin
        objInfoPgto.retencoes.vlrBaseCSLL   := cdsNotas.FieldByName('FIS_VLRCON').AsFloat;
        objInfoPgto.retencoes.vlrCSLL       := cdsNotas.FieldByName('FIS_RECSSL').AsFloat;
      End;

      If (fFormataFloat(cdsNotas.FieldByName('FIS_VRECOF').AsFloat, 2) <> 0) Then
      Begin
        objInfoPgto.retencoes.vlrBaseCofins := cdsNotas.FieldByName('FIS_VLRCON').AsFloat;
        objInfoPgto.retencoes.vlrCofins     := cdsNotas.FieldByName('FIS_VRECOF').AsFloat;
      End;

      If (fFormataFloat(cdsNotas.FieldByName('FIS_VREPIS').AsFloat, 2) <> 0) Then
      Begin
        objInfoPgto.retencoes.vlrBasePP     := cdsNotas.FieldByName('FIS_VLRCON').AsFloat;
        objInfoPgto.retencoes.vlrPP         := cdsNotas.FieldByName('FIS_VREPIS').AsFloat;
      End;

      strNatRend := cdsNotas.FieldByName('FIS_TB01RE').AsString;

      cdsNotas.Next;
    end;

    ACBrReinf.Eventos.Gerar;
    ACBrReinf.Eventos.Assinar;

    if (ACBrReinf.Enviar) and (not fProcessarTransmissao) then
      Break;

    blnTransmitiu := True;

    cdsCadFis.Next;
  end;

  if blnTransmitiu then
  begin
    pCarregarPeriodoDeApuracao;
    tmrConsultarProcessamento.Enabled := True;
  end;

end;

procedure TfrmEventosReinf.pTransmitirR4080;
var
  objR4080: TR4080CollectionItem;
  objIdeRend: TideRendCollectionItem;
  objInfoRec: TinfoRecCollectionItem;

  blnTransmitiu: Boolean;
  strNatRend: String;
begin
  objIdeRend := nil;

  blnTransmitiu := False;

  cdsCadFis.First;
  while not cdsCadFis.Eof do
  begin
    if cdsCadFis.FieldByName('LOT_SITUAC').AsString = '3' then
    begin
      cdsCadFis.Next;
      Continue;
    end;

    ACBrReinf.Eventos.Clear;
    ACBrReinf.Eventos.ReinfEventos.R4080.Clear;

    objR4080 := ACBrReinf.Eventos.ReinfEventos.R4080.New;

    objR4080.evtRetRec.Sequencial := 0;

    objR4080.evtRetRec.ideEvento.indRetif := trOriginal;
    if not fEmptyStr(cdsCadFis.FieldByName('LOT_RECIBO').AsString) then
    begin
      objR4080.evtRetRec.ideEvento.indRetif := trRetificacao;
      objR4080.evtRetRec.ideEvento.NrRecibo := cdsCadFis.FieldByName('LOT_RECIBO').AsString;
    end;

    objR4080.evtRetRec.ideEvento.perApur := FormatDateBr(StrToDate('01/'+edtPerApu.Text), 'yyyy-mm');

    objR4080.evtRetRec.ideEvento.ProcEmi := peAplicEmpregador;
    objR4080.evtRetRec.ideEvento.VerProc := '1.0';

    objR4080.evtRetRec.ideContri.TpInsc := tiCNPJ;
    objR4080.evtRetRec.ideContri.NrInsc := ACBrReinf.Configuracoes.Geral.IdContribuinte;

    objR4080.evtRetRec.ideEstab.tpInscEstab := tiCNPJ;
    objR4080.evtRetRec.ideEstab.nrInscEstab := ACBrReinf.Configuracoes.Geral.IdContribuinte;

    objR4080.evtRetRec.ideEstab.ideFont.cnpjFont := cdsCadFis.FieldByName('FC_C_G_C_').AsString;

    strNatRend := EmptyStr;
    objR4080.evtRetRec.ideEstab.ideFont.ideRend.Clear;
    while not cdsNotas.Eof do
    begin
      if strNatRend <> cdsNotas.FieldByName('FIS_TB01RE').AsString then
      begin
        objIdeRend := objR4080.evtRetRec.ideEstab.ideFont.ideRend.New;
        objIdeRend.natRend := cdsNotas.FieldByName('FIS_TB01RE').AsString;

        objIdeRend.infoRec.Clear;
      end;

      objInfoRec := objIdeRend.infoRec.New;
      objInfoRec.dtFG         := cdsNotas.FieldByName('FIS_DTPGRC').AsDateTime;
      objInfoRec.vlrBruto     := cdsNotas.FieldByName('FIS_VLRCON').AsFloat;
      objInfoRec.vlrBaseIR    := cdsNotas.FieldByName('FIS_VLRCON').AsFloat;
      objInfoRec.vlrIR        := cdsNotas.FieldByName('FIS_REIRRF').AsFloat;

      strNatRend := cdsNotas.FieldByName('FIS_TB01RE').AsString;

      cdsNotas.Next;
    end;

    ACBrReinf.Eventos.Gerar;
    ACBrReinf.Eventos.Assinar;

    if (ACBrReinf.Enviar) and (not fProcessarTransmissao) then
      Break;

    blnTransmitiu := True;

    cdsCadFis.Next;
  end;

  if blnTransmitiu then
  begin
    pCarregarPeriodoDeApuracao;
    tmrConsultarProcessamento.Enabled := True;
  end;

end;

function TfrmEventosReinf.fRetEmpresas: String;
var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  try
    qryAux.Close;
    qryAux.SQL.Text :=
    ' SELECT '+
    '   EMP_CODEMP '+
    ' FROM '+
    '   CADEMP '+
    ' WHERE '+
    '   SUBSTR(EMP_C_G_C_,1,8) = ( SELECT SUBSTR(EMP_C_G_C_, 1,8) FROM CADEMP WHERE EMP_CODEMP = :CODEMP ) ';

    qryAux.ParamByName('CODEMP').AsString := Self.strCodEmp;
    qryAux.Open;

    qryAux.First;
    while not qryAux.Eof do
    begin
      Result := Result + IIF(fEmptyStr(Result), '', ',') + QuotedStr(qryAux.FieldByName('EMP_CODEMP').AsString);
      qryAux.Next;
    end;
  finally
    FreeAndNil(qryAux);
  end;
end;

function TfrmEventosReinf.fRetEvento: String;
begin
  Result := EmptyStr;

  case tpEvento of
    R2010: Result := 'R2010';
    R2020: Result := 'R2020';
    R4010: Result := 'R4010';
    R4020: Result := 'R4020';
    R4080: Result := 'R4080';
  end;
end;

procedure TfrmEventosReinf.pSalvarXmlEnvio;
begin
  pSalvarXmlReinf(xmlEnvio,
                  cdsCadFis);
end;

procedure TfrmEventosReinf.pSalvarXmlRetorno;
begin
  pSalvarXmlReinf(xmlRetorno,
                  cdsCadFis);
end;

procedure TfrmEventosReinf.pSeleciona(const strMarDes: String);
begin
  if not Assigned(cdsCadFis) then
    Exit;

  try
    cdsCadFis.DisableControls;
    cdsCadFis.AfterScroll := nil;

    cdsCadFis.First;
    while not cdsCadFis.Eof do
    begin
      cdsCadFis.Edit;
      cdsCadFis.FieldByName('MARDES').AsString := strMarDes;
      cdsCadFis.Post;
      cdsCadFis.Next;
    end;

    cdsCadFis.First;
  finally
    cdsCadFis.EnableControls;
    cdsCadFis.AfterScroll := pAfterScrollCdsCadFis;
  end;
end;

function TfrmEventosReinf.fRetSQLCadFis(const strEmpresas: String): String;
begin
  case tpEvento of
    R2010, R2020 : Result := fRetSqlCadFisR2010R2020(strEmpresas);
    R4010, R4020, R4080: Result  := fRetSqlCadFisR4010R4020R4080(strEmpresas);
  end;
end;

function TfrmEventosReinf.fRetSqlCadFisR2010R2020(const strEmpresas: String): String;
begin
  Result := '  SELECT '+
            '    "D" AS MARDES,  '+
            '    DATE_FORMAT(FIS_DTAENT, "%m/%Y") AS FIS_PERAPU, '+
            '   FIS_CODEMP, '+
            '   CONCAT( '+
            '     SUBSTR(EMP_C_G_C_, 1, 2), '+
            '     ".", '+
            '     SUBSTR(EMP_C_G_C_, 3, 3), '+
            '     ".", '+
            '     SUBSTR(EMP_C_G_C_, 6, 3), '+
            '     "/", '+
            '     SUBSTR(EMP_C_G_C_, 9, 4), '+
            '     "-", '+
            '     SUBSTR(EMP_C_G_C_, 13, 2) '+
            '   ) AS '+IIF(tpEvento = R2010, ' CGCTOMADOR, ', ' CGCPRESTADOR, ')+

            ' EMP_NOMEMP AS '+IIF(tpEvento = R2010, ' TOMADOR, ', ' PRESTADOR, ')+

            '   FIS_FORCLI, '+

            '   CONCAT( '+
            '     SUBSTR('+IIF(tpEvento = R2010, 'FOR_C_G_C_', 'CLI_C_G_C_')+', 1, 2), '+
            '     ".", '+
            '     SUBSTR('+IIF(tpEvento = R2010, 'FOR_C_G_C_', 'CLI_C_G_C_')+', 3, 3), '+
            '     ".", '+
            '     SUBSTR('+IIF(tpEvento = R2010, 'FOR_C_G_C_', 'CLI_C_G_C_')+', 6, 3), '+
            '     "/", '+
            '     SUBSTR('+IIF(tpEvento = R2010, 'FOR_C_G_C_', 'CLI_C_G_C_')+', 9, 4), '+
            '     "-", '+
            '     SUBSTR('+IIF(tpEvento = R2010, 'FOR_C_G_C_', 'CLI_C_G_C_')+', 13, 2) '+
            '     ) AS '+IIF(tpEvento = R2010, ' CGCPRESTADOR, ', ' CGCTOMADOR, ')+

            IIF(tpEvento = R2010, ' FOR_NOMFOR ', ' CLI_NOMCLI ')+' AS '+IIF(tpEvento = R2010, ' PRESTADOR, ', ' TOMADOR, ')+

            '   FIS_CODEMP, '+
            IIF(tpEvento = R2010, '   FOR_C_G_C_, ', ' CLI_C_G_C_, ')+
            '   SUM(FIS_VLCON1) + SUM(IFNULL(FIS_VLCON2, 0)) + SUM(IFNULL(FIS_VLCON3, 0)) + SUM(IFNULL(FIS_VLCON4, 0)) + SUM(IFNULL(FIS_VLCON5, 0)) AS FIS_TOTBRU, '+
            '   SUM(FIS_REINSS) AS FIS_TOTRET, '+
            IIF(tpEvento = R2010, '   FOR_C_CPRB, ', '')+
            '   FIS_TIP_FC, '+
            '   FIS_LOTREI_2000, '+
            '   LOT_DTAENV, '+
            '   LOT_CODRET, '+
            '   LOT_DESRET, '+
            '   LOT_PROTOC, '+
            '   LOT_IDEEVE, '+
            '   CASE LOT_ORIRET WHEN "O" THEN "ORIGINAL" WHEN "R" THEN "RETIFICADO" ELSE "" END AS LOT_ORIRET, '+

            '   CASE LOT_STATUS WHEN "F" THEN "FECHADO" ELSE "ABERTO" END AS LOT_STATUS, '+

            '   CASE (SELECT '+
            '           LOT_STATUS '+
            '         FROM '+
            '           REINF_LOTES '+
            '         WHERE LOT_EVENTO IN ("R2098", "2099") '+
            '           AND LOT_PERAPU = DATE_FORMAT(FIS_DTAENT, "%m/%Y") '+
            '           AND LOT_CODEMP = :CODEMP '+
            '         ORDER BY AUTOINCREM DESC '+
            '         LIMIT 1) '+
            '     WHEN "A" '+
            '     THEN "ABERTO" '+
            '     WHEN "F" '+
            '     THEN "FECHADO" '+
            '     ELSE "ABERTO" '+
            '   END AS LOT_STATUS, '+

            '   LOT_RECIBO, '+
            '   LOT_XMLENV, '+
            '   LOT_XMLRET, '+
            '   LOT_EVENTO, '+
            '   IFNULL(LOT_SITUAC, "2") AS LOT_SITUAC, '+
            '   REINF_LOTES.AUTOINCREM AS AUTOINCREM_LOTE '+
            ' FROM '+
            '   CADFIS '+
            '   INNER JOIN CADEMP '+
            '     ON FIS_CODEMP = EMP_CODEMP '+

            IIF(tpEvento = R2010,
                '   INNER JOIN CADFOR '+
                '     ON FIS_FORCLI = FOR_CODFOR ',
                '   INNER JOIN CADCLI '+
                '     ON FIS_FORCLI = CLI_CODCLI ')+

            '   LEFT JOIN REINF_LOTES '+
            '     ON FIS_LOTREI_2000 = REINF_LOTES.AUTOINCREM '+

            ' WHERE DATE_FORMAT(FIS_DTAENT, "%Y%m") = DATE_FORMAT(:PERAPU, "%Y%m") '+
            '   AND IFNULL(FIS_TB06RE, "") <> "" '+
            IIF(tpEvento = R2010,
              '   AND FIS_CLFSC1 < 5000 '+
              '   AND FIS_TIP_FC = "F" '+
              '   AND FOR_CGCCPF = 1 ',

              '   AND FIS_CLFSC1 > 5000 '+
              '   AND FIS_TIP_FC = "C" '+
              '   AND CLI_CGCCPF = 1 ')+

            '   AND FIS_REINSS > 0 '+
            '   AND FIS_ESPDOC IN ("NS", "NF") '+
            '   AND FIS_CODEMP IN ('+strEmpresas+') '+
            '   AND IFNULL(FIS_HISTOR, "") NOT LIKE "%CANCEL%" '+
            '   AND IFNULL(FIS_HISTOR, "") NOT LIKE "%DENEGAD%" '+
            '   AND IFNULL(FIS_HISTOR, "") NOT LIKE "%INUTIL%" '+
            ' GROUP BY FIS_FORCLI '+
            ' ORDER BY LOT_SITUAC, '+
            '   FIS_DTAENT, '+
            '   FIS_CODEMP, '+
            '   FIS_ESPDOC, '+
            '   FIS_NUMDOC ';
end;

function TfrmEventosReinf.fRetSqlCadFisR4010R4020R4080(const strEmpresas: String): String;
begin
  Result := '  SELECT '+
            '    "D" AS MARDES,  '+
            '    FIS_DTAENT, '+
            '    DATE_FORMAT('+IIF(fCfgSis('CSCPPR') = '1', ' FIS_DTAENT ', ' CTR_DTAREC ')+', "%m/%Y") AS FIS_PERAPU, '+
            '    FIS_CODEMP, '+

            '    CONCAT( '+
            '      SUBSTR(EMP_C_G_C_, 1, 2), '+
            '      ".", '+
            '      SUBSTR(EMP_C_G_C_, 3, 3), '+
            '      ".", '+
            '      SUBSTR(EMP_C_G_C_, 6, 3), '+
            '      "/", '+
            '      SUBSTR(EMP_C_G_C_, 9, 4), '+
            '      "-", '+
            '      SUBSTR(EMP_C_G_C_, 13, 2) '+
            '    ) AS CGCTOMADOR, '+

            '    EMP_NOMEMP AS TOMADOR, '+
            '    FIS_FORCLI, '+

            IIF(tpEvento = R4010,
               ' CONCAT( '+
               '   SUBSTR(CLI_C_G_C_, 1, 3), '+
               '     ".", '+
               '     SUBSTR(CLI_C_G_C_, 4, 3), '+
               '     ".", '+
               '     SUBSTR(CLI_C_G_C_, 7, 3), '+
               '     "-", '+
               '     SUBSTR(CLI_C_G_C_, 10, 2) '+
               '     ) AS CGCPRESTADOR, ',

               ' CONCAT( '+
               '   SUBSTR(CLI_C_G_C_, 1, 2), '+
               '     ".", '+
               '     SUBSTR(CLI_C_G_C_, 3, 3), '+
               '     ".", '+
               '     SUBSTR(CLI_C_G_C_, 6, 3), '+
               '     "/", '+
               '     SUBSTR(CLI_C_G_C_, 9, 4), '+
               '     "-", '+
               '     SUBSTR(CLI_C_G_C_, 13, 2) '+
               '   ) AS CGCPRESTADOR, ')+

            '    CLI_NOMCLI AS PRESTADOR, '+

            '    FIS_CODEMP, '+
            '    CLI_C_G_C_ AS FC_C_G_C_, '+
            '    SUM(FIS_VLCON1) + SUM(IFNULL(FIS_VLCON2, 0)) + SUM(IFNULL(FIS_VLCON3, 0)) + SUM(IFNULL(FIS_VLCON4, 0)) + SUM(IFNULL(FIS_VLCON5, 0)) AS FIS_TOTBRU, '+
            '    SUM(FIS_REIRRF) AS FIS_TOTRRF, '+

            IIF(tpEvento in [R4010, R4080],
               '',
               ' SUM(FIS_RECSSL) AS FIS_TOTSSL, '+
               ' SUM(FIS_VREPIS) AS FIS_TOTPIS, '+
               ' SUM(FIS_VRECOF) AS FIS_TOTCOF, ')+

            '    FIS_TIP_FC, '+
            '    FIS_LOTREI_4000, '+
            '    LOT_DTAENV, '+
            '    LOT_CODRET, '+
            '    LOT_DESRET, '+
            '    LOT_PROTOC, '+
            '    LOT_IDEEVE, '+
            '    CASE LOT_ORIRET WHEN "O" THEN "ORIGINAL" WHEN "R" THEN "RETIFICADO" ELSE "" END AS LOT_ORIRET, '+

            '   CASE (SELECT '+
            '           LOT_STATUS '+
            '         FROM '+
            '           REINF_LOTES '+
            '         WHERE LOT_EVENTO = "R4099" '+
            '           AND LOT_PERAPU = DATE_FORMAT('+IIF(fCfgSis('CSCPPR') = '1', ' FIS_DTAENT ', ' CTR_DTAREC ')+', "%m/%Y") '+
            '           AND LOT_CODEMP = :CODEMP '+
            '         ORDER BY AUTOINCREM DESC '+
            '         LIMIT 1) '+
            '     WHEN "A" '+
            '     THEN "ABERTO" '+
            '     WHEN "F" '+
            '     THEN "FECHADO" '+
            '     ELSE "ABERTO" '+
            '   END AS LOT_STATUS, '+

            '    LOT_RECIBO, '+
            '    LOT_XMLENV, '+
            '    LOT_XMLRET, '+
            '    LOT_EVENTO, '+
            '    IFNULL(LOT_SITUAC, "2") AS LOT_SITUAC, '+
            '    REINF_LOTES.AUTOINCREM AS AUTOINCREM_LOTE '+
            '  FROM '+
            '    CADFIS '+

            IIF(fCfgSis('CSCPPR') = '2',
              ' INNER JOIN ( '+
              '   SELECT CTR_NUMDUP, CTR_CODEMP, CTR_DTACAD, CTR_CODCLI, MIN(CTR_DTAREC) AS CTR_DTAREC '+
              '   FROM CADREC '+
              '   WHERE DATE_FORMAT(CTR_DTAREC, "%Y%m") = DATE_FORMAT(:PERAPU, "%Y%m") '+
              '   GROUP BY CTR_NUMDUP, CTR_CODEMP, CTR_DTACAD, CTR_CODCLI '+
              ' ) CADREC '+
              '   ON CADFIS.FIS_NUMDOC = CADREC.CTR_NUMDUP '+
              '  AND CADFIS.FIS_CODEMP = CADREC.CTR_CODEMP '+
              '  AND CADFIS.FIS_DTAENT = CADREC.CTR_DTACAD '+
              '  AND CADFIS.FIS_FORCLI = CADREC.CTR_CODCLI '
              ,
              '')+

            '    INNER JOIN CADEMP '+
            '      ON FIS_CODEMP = EMP_CODEMP '+

            '    INNER JOIN CADCLI '+
            '      ON FIS_FORCLI = CLI_CODCLI '+

            '    LEFT JOIN REINF_LOTES '+
            '      ON FIS_LOTREI_4000 = REINF_LOTES.AUTOINCREM '+

            '  WHERE '+
            '    DATE_FORMAT('+IIF(fCfgSis('CSCPPR') = '1', ' FIS_DTAENT ', ' CTR_DTAREC ')+', "%Y%m") = DATE_FORMAT(:PERAPU, "%Y%m") '+
            '    AND IFNULL(FIS_TB01RE, "") <> "" '+
            '    AND FIS_TIP_FC = "C" '+
            '    AND FIS_ESPDOC IN ("NS", "NF") '+
            '    AND FIS_CODEMP IN ('+strEmpresas+') '+
            '    AND IFNULL(FIS_HISTOR, "") NOT LIKE "%CANCEL%" '+
            '    AND IFNULL(FIS_HISTOR, "") NOT LIKE "%DENEGAD%" '+
            '    AND IFNULL(FIS_HISTOR, "") NOT LIKE "%INUTIL%" '+

            fRetSQLWhereR4010R4020R4080('C') +

            '  GROUP BY FIS_FORCLI '+

            '  UNION ALL '+

            '  SELECT '+
            '    "D" AS MARDES,  '+
            '    FIS_DTAENT, '+
            '    DATE_FORMAT('+IIF(fCfgSis('CSCPPR') = '1', ' FIS_DTAENT ', ' CTP_DTAPAG ')+', "%m/%Y") AS FIS_PERAPU, '+
            '    FIS_CODEMP, '+
            '    CONCAT( '+
            '      SUBSTR(EMP_C_G_C_, 1, 2), '+
            '      ".", '+
            '      SUBSTR(EMP_C_G_C_, 3, 3), '+
            '      ".", '+
            '      SUBSTR(EMP_C_G_C_, 6, 3), '+
            '      "/", '+
            '      SUBSTR(EMP_C_G_C_, 9, 4), '+
            '      "-", '+
            '      SUBSTR(EMP_C_G_C_, 13, 2) '+
            '    ) AS CGCTOMADOR, '+

            '    EMP_NOMEMP AS TOMADOR, '+
            '    FIS_FORCLI, '+

            IIF(tpEvento = R4010,
               ' CONCAT( '+
               '   SUBSTR(FOR_C_G_C_, 1, 3), '+
               '   ".", '+
               '   SUBSTR(FOR_C_G_C_, 4, 3), '+
               '   ".", '+
               '   SUBSTR(FOR_C_G_C_, 7, 3), '+
               '   "-", '+
               '   SUBSTR(FOR_C_G_C_, 10, 2) '+
               '   ) AS CGCPRESTADOR, ',

               ' CONCAT( '+
               '   SUBSTR(FOR_C_G_C_, 1, 2), '+
               '   ".", '+
               '   SUBSTR(FOR_C_G_C_, 3, 3), '+
               '   ".", '+
               '   SUBSTR(FOR_C_G_C_, 6, 3), '+
               '   "/", '+
               '   SUBSTR(FOR_C_G_C_, 9, 4), '+
               '   "-", '+
               '   SUBSTR(FOR_C_G_C_, 13, 2) '+
               ' ) AS CGCPRESTADOR, ')+

            '    FOR_NOMFOR AS PRESTADOR, '+

            '    FIS_CODEMP, '+
            '    FOR_C_G_C_ AS FC_C_G_C_, '+
            '    SUM(FIS_VLCON1) + SUM(IFNULL(FIS_VLCON2, 0)) + SUM(IFNULL(FIS_VLCON3, 0)) + SUM(IFNULL(FIS_VLCON4, 0)) + SUM(IFNULL(FIS_VLCON5, 0)) AS FIS_TOTBRU, '+
            '    SUM(FIS_REIRRF) AS FIS_TOTRRF, '+

            IIF(tpEvento in [R4010, R4080],
               '',
               ' SUM(FIS_RECSSL) AS FIS_TOTSSL, '+
               ' SUM(FIS_VREPIS) AS FIS_TOTPIS, '+
               ' SUM(FIS_VRECOF) AS FIS_TOTCOF, ')+

            '    FIS_TIP_FC, '+
            '    FIS_LOTREI_4000, '+
            '    LOT_DTAENV, '+
            '    LOT_CODRET, '+
            '    LOT_DESRET, '+
            '    LOT_PROTOC, '+
            '    LOT_IDEEVE, '+
            '    CASE LOT_ORIRET WHEN "O" THEN "ORIGINAL" WHEN "R" THEN "RETIFICADO" ELSE "" END AS LOT_ORIRET, '+

            '   CASE (SELECT '+
            '           LOT_STATUS '+
            '         FROM '+
            '           REINF_LOTES '+
            '         WHERE LOT_EVENTO = "R4099" '+
            '           AND LOT_PERAPU = DATE_FORMAT('+IIF(fCfgSis('CSCPPR') = '1', ' FIS_DTAENT ', ' CTP_DTAPAG ')+', "%m/%Y") '+
            '           AND LOT_CODEMP = :CODEMP '+
            '         ORDER BY AUTOINCREM DESC '+
            '         LIMIT 1) '+
            '     WHEN "A" '+
            '     THEN "ABERTO" '+
            '     WHEN "F" '+
            '     THEN "FECHADO" '+
            '     ELSE "ABERTO" '+
            '   END AS LOT_STATUS, '+

            '    LOT_RECIBO, '+
            '    LOT_XMLENV, '+
            '    LOT_XMLRET, '+
            '    LOT_EVENTO, '+
            '    IFNULL(LOT_SITUAC, "2") AS LOT_SITUAC, '+
            '    REINF_LOTES.AUTOINCREM AS AUTOINCREM_LOTE '+
            '  FROM '+
            '    CADFIS '+

            IIF(fCfgSis('CSCPPR') = '2',
              ' INNER JOIN ( '+
              '   SELECT CTP_NUMDUP, CTP_CODEMP, CTP_DTACAD, CTP_CODFOR, CTP_SERIE_, MIN(CTP_DTAPAG) AS CTP_DTAPAG '+
              '   FROM CADPAG '+
              '   WHERE DATE_FORMAT(CTP_DTAPAG, "%Y%m") = DATE_FORMAT(:PERAPU, "%Y%m") '+
              '   GROUP BY CTP_NUMDUP, CTP_CODEMP, CTP_DTACAD, CTP_CODFOR, CTP_SERIE_ '+
              ' ) CADPAG '+
              '   ON CADFIS.FIS_NUMDOC = CADPAG.CTP_NUMDUP '+
              '  AND CADFIS.FIS_CODEMP = CADPAG.CTP_CODEMP '+
              '  AND CADFIS.FIS_DTAENT = CADPAG.CTP_DTACAD '+
              '  AND CADFIS.FIS_FORCLI = CADPAG.CTP_CODFOR '+
              '  AND CADFIS.FIS_SERIE_ = CADPAG.CTP_SERIE_ '
              ,
              '')+

            '    INNER JOIN CADEMP '+
            '      ON FIS_CODEMP = EMP_CODEMP '+

            '    INNER JOIN CADFOR '+
            '      ON FIS_FORCLI = FOR_CODFOR '+

            '    LEFT JOIN REINF_LOTES '+
            '      ON FIS_LOTREI_4000 = REINF_LOTES.AUTOINCREM '+

            '  WHERE '+
            '    DATE_FORMAT('+IIF(fCfgSis('CSCPPR') = '1', ' FIS_DTAENT ', ' CTP_DTAPAG ')+', "%Y%m") = DATE_FORMAT(:PERAPU, "%Y%m") '+
            '    AND IFNULL(FIS_TB01RE, "") <> "" '+
            '    AND FIS_TIP_FC = "F" '+
            '    AND FIS_ESPDOC IN ("NS", "NF") '+
            '    AND FIS_CODEMP IN ('+strEmpresas+') '+
            '    AND IFNULL(FIS_HISTOR, "") NOT LIKE "%CANCEL%" '+
            '    AND IFNULL(FIS_HISTOR, "") NOT LIKE "%DENEGAD%" '+
            '    AND IFNULL(FIS_HISTOR, "") NOT LIKE "%INUTIL%" '+

            fRetSQLWhereR4010R4020R4080('F') +

            '  GROUP BY FIS_FORCLI ';
end;

function TfrmEventosReinf.fRetSQLCadFisDetalhado(const strEmpresas: String): String;
begin
  case tpEvento of
    R2010, R2020 : Result := fRetSQLCadFisR2010R2020Detalhado(strEmpresas);
    R4010, R4020, R4080: Result  := fRetSQLCadFisR4010R4020R4080Detalhado(strEmpresas);
  end;
end;

function TfrmEventosReinf.fRetSQLCadFisR2010R2020Detalhado(const strEmpresas: String): String;
begin
  Result := ' SELECT '+
            '   AUTOINCREM, '+
            '   FIS_FORCLI, '+
            '   FIS_DTAENT, '+
            '   FIS_DTADOC, '+
            '   FIS_NUMDOC, '+
            '   FIS_ESPDOC, '+
            '   FIS_CODEMP, '+
            '   FIS_SERIE_, '+
            '   FIS_TB06RE, '+
            '   CLA_DESCRI, '+
            '   SUM(FIS_VLCON1) + SUM(IFNULL(FIS_VLCON2, 0)) + SUM(IFNULL(FIS_VLCON3, 0)) + SUM(IFNULL(FIS_VLCON4, 0)) + SUM(IFNULL(FIS_VLCON5, 0)) AS FIS_VLRCON, '+
            '   FIS_REINSS, '+
            '   FIS_CLFSC1 '+
            ' FROM '+
            '   CADFIS '+

            ' INNER JOIN REINF_TABE06 '+
            '   ON FIS_TB06RE = CLA_CODIGO '+

            ' WHERE DATE_FORMAT(FIS_DTAENT, "%Y%m") = DATE_FORMAT(:PERAPU, "%Y%m") '+
            '   AND IFNULL(FIS_TB06RE, "") <> "" '+
            IIF(tpEvento = R2010,
              '   AND FIS_CLFSC1 < 5000 '+
              '   AND FIS_TIP_FC = "F" ',
              '   AND FIS_CLFSC1 > 5000 '+
              '   AND FIS_TIP_FC = "C" ')+

            '   AND FIS_REINSS > 0 '+
            '   AND FIS_ESPDOC IN ("NS", "NF") '+
            '   AND FIS_CODEMP IN ('+strEmpresas+') '+
            '   AND IFNULL(FIS_HISTOR, "") NOT LIKE "%CANCEL%" '+
            '   AND IFNULL(FIS_HISTOR, "") NOT LIKE "%DENEGAD%" '+
            '   AND IFNULL(FIS_HISTOR, "") NOT LIKE "%INUTIL%" '+

            ' GROUP BY '+
            '   FIS_NUMDOC, '+
            '   FIS_CODEMP, '+
            '   FIS_ESPDOC, '+
            '   FIS_SERIE_, '+
            '   FIS_FORCLI  '+

            ' ORDER BY '+
            '   FIS_DTAENT, '+
            '   FIS_CODEMP, '+
            '   FIS_NUMDOC ';
end;

function TfrmEventosReinf.fRetSQLCadFisR4010R4020R4080Detalhado(const strEmpresas: String): String;
begin
  Result := ' SELECT '+
            '   CADFIS.AUTOINCREM, '+
            '   FIS_FORCLI, '+
            '   FIS_DTAENT, '+
                IIF(fCfgSis('CSCPPR') = '1', ' FIS_DTAENT ', ' CTR_DTAREC ')+' AS FIS_DTPGRC, '+
            '   FIS_DTADOC, '+
            '   FIS_NUMDOC, '+
            '   FIS_ESPDOC, '+
            '   FIS_CODEMP, '+
            '   FIS_SERIE_, '+
            '   SUM(FIS_VLCON1) + SUM(IFNULL(FIS_VLCON2, 0)) + SUM(IFNULL(FIS_VLCON3, 0)) + SUM(IFNULL(FIS_VLCON4, 0)) + SUM(IFNULL(FIS_VLCON5, 0)) AS FIS_VLRCON, '+
            '   FIS_CLFSC1, '+
            '   FIS_REIRRF, '+

            IIF(tpEvento in [R4010, R4080],
               '',

               ' FIS_RECSSL, '+
               ' FIS_VREPIS, '+
               ' FIS_VRECOF, ')+

            '   FIS_TB01RE, '+
            '   NAT_DESCRI  '+
            ' FROM '+
            '   CADFIS '+

            IIF(fCfgSis('CSCPPR') = '2',
              ' INNER JOIN ( '+
              '   SELECT CTR_NUMDUP, CTR_CODEMP, CTR_DTACAD, CTR_CODCLI, MIN(CTR_DTAREC) AS CTR_DTAREC '+
              '   FROM CADREC '+
              '   WHERE DATE_FORMAT(CTR_DTAREC, "%Y%m") = DATE_FORMAT(:PERAPU, "%Y%m") '+
              '   GROUP BY CTR_NUMDUP, CTR_CODEMP, CTR_DTACAD, CTR_CODCLI '+
              ' ) CADREC '+
              '   ON CADFIS.FIS_NUMDOC = CADREC.CTR_NUMDUP '+
              '  AND CADFIS.FIS_CODEMP = CADREC.CTR_CODEMP '+
              '  AND CADFIS.FIS_DTAENT = CADREC.CTR_DTACAD '+
              '  AND CADFIS.FIS_FORCLI = CADREC.CTR_CODCLI '
              ,
              '')+

            '   INNER JOIN CADCLI '+
            '     ON FIS_FORCLI = CLI_CODCLI '+

            '   INNER JOIN REINF_TABE01 '+
            '     ON FIS_TB01RE = NAT_CODIGO '+

            ' WHERE DATE_FORMAT('+IIF(fCfgSis('CSCPPR') = '1', ' FIS_DTAENT ', ' CTR_DTAREC ')+', "%Y%m") = DATE_FORMAT(:PERAPU, "%Y%m") '+
            '   AND IFNULL(FIS_TB01RE, "") <> "" '+
            '   AND FIS_TIP_FC = "C" '+
            '   AND FIS_ESPDOC IN ("NS", "NF") '+
            '   AND FIS_CODEMP IN ('+strEmpresas+') '+
            '   AND IFNULL(FIS_HISTOR, "") NOT LIKE "%CANCEL%" '+
            '   AND IFNULL(FIS_HISTOR, "") NOT LIKE "%DENEGAD%" '+
            '   AND IFNULL(FIS_HISTOR, "") NOT LIKE "%INUTIL%" '+

            fRetSQLWhereR4010R4020R4080('C') +

            ' GROUP BY '+
            '   FIS_NUMDOC, '+
            '   FIS_CODEMP, '+
            '   FIS_ESPDOC, '+
            '   FIS_SERIE_, '+
            '   FIS_FORCLI  '+

            ' UNION ALL ' +

            ' SELECT '+
            '   CADFIS.AUTOINCREM, '+
            '   FIS_FORCLI, '+
            '   FIS_DTAENT, '+
                IIF(fCfgSis('CSCPPR') = '1', ' FIS_DTAENT ', ' CTP_DTAPAG ')+' AS FIS_DTPGRC, '+
            '   FIS_DTADOC, '+
            '   FIS_NUMDOC, '+
            '   FIS_ESPDOC, '+
            '   FIS_CODEMP, '+
            '   FIS_SERIE_, '+
            '   SUM(FIS_VLCON1) + SUM(IFNULL(FIS_VLCON2, 0)) + SUM(IFNULL(FIS_VLCON3, 0)) + SUM(IFNULL(FIS_VLCON4, 0)) + SUM(IFNULL(FIS_VLCON5, 0)) AS FIS_VLRCON, '+
            '   FIS_CLFSC1, '+
            '   FIS_REIRRF, '+

            IIF(tpEvento in [R4010, R4080],
               '',

               ' FIS_RECSSL, '+
               ' FIS_VREPIS, '+
               ' FIS_VRECOF, ')+

            '   FIS_TB01RE, '+
            '   NAT_DESCRI '+
            ' FROM '+
            '   CADFIS '+

            IIF(fCfgSis('CSCPPR') = '2',
              ' INNER JOIN ( '+
              '   SELECT CTP_NUMDUP, CTP_CODEMP, CTP_DTACAD, CTP_CODFOR, CTP_SERIE_, MIN(CTP_DTAPAG) AS CTP_DTAPAG '+
              '   FROM CADPAG '+
              '   WHERE DATE_FORMAT(CTP_DTAPAG, "%Y%m") = DATE_FORMAT(:PERAPU, "%Y%m") '+
              '   GROUP BY CTP_NUMDUP, CTP_CODEMP, CTP_DTACAD, CTP_CODFOR, CTP_SERIE_ '+
              ' ) CADPAG '+
              '   ON CADFIS.FIS_NUMDOC = CADPAG.CTP_NUMDUP '+
              '  AND CADFIS.FIS_CODEMP = CADPAG.CTP_CODEMP '+
              '  AND CADFIS.FIS_DTAENT = CADPAG.CTP_DTACAD '+
              '  AND CADFIS.FIS_FORCLI = CADPAG.CTP_CODFOR '+
              '  AND CADFIS.FIS_SERIE_ = CADPAG.CTP_SERIE_ '
              ,
              '')+

            '   INNER JOIN CADFOR '+
            '     ON FIS_FORCLI = FOR_CODFOR '+

            '   INNER JOIN REINF_TABE01 '+
            '     ON FIS_TB01RE = NAT_CODIGO '+

            ' WHERE DATE_FORMAT('+IIF(fCfgSis('CSCPPR') = '1', ' FIS_DTAENT ', ' CTP_DTAPAG ')+', "%Y%m") = DATE_FORMAT(:PERAPU, "%Y%m") '+
            '   AND IFNULL(FIS_TB01RE, "") <> "" '+
            '   AND FIS_TIP_FC = "F" '+
            '   AND FIS_ESPDOC IN ("NS", "NF") '+
            '   AND FIS_CODEMP IN ('+strEmpresas+') '+
            '   AND IFNULL(FIS_HISTOR, "") NOT LIKE "%CANCEL%" '+
            '   AND IFNULL(FIS_HISTOR, "") NOT LIKE "%DENEGAD%" '+
            '   AND IFNULL(FIS_HISTOR, "") NOT LIKE "%INUTIL%" '+

            fRetSQLWhereR4010R4020R4080('F') +

            ' GROUP BY '+
            '   FIS_NUMDOC, '+
            '   FIS_CODEMP, '+
            '   FIS_ESPDOC, '+
            '   FIS_SERIE_, '+
            '   FIS_FORCLI  ';
end;

function TfrmEventosReinf.fRetSQLWhereR4010R4020R4080(const strTipFC: String): String;
begin
  Result := EmptyStr;

  if tpEvento = R4010 then
  begin
    Result := ' AND FIS_CLFSC1 < 5000 '+
              ' AND FIS_REIRRF > 0 '+
              IIF(strTipFC = 'C', ' AND CLI_CGCCPF = 2 ', ' AND FOR_CGCCPF = 2 ');
  end
  else if tpEvento = R4020 then
  begin
    Result := ' AND FIS_CLFSC1 < 5000 '+
              ' AND ( FIS_REIRRF > 0 OR FIS_RECSSL > 0 OR FIS_VREPIS > 0 OR FIS_VRECOF > 0 ) '+
              IIF(strTipFC = 'C', ' AND CLI_CGCCPF = 1 ', ' AND FOR_CGCCPF = 1 ');
  end
  else if tpEvento = R4080 then
  begin
    Result := ' AND FIS_CLFSC1 > 5000 '+
              ' AND FIS_REIRRF > 0 '+
              IIF(strTipFC = 'C', ' AND CLI_CGCCPF = 1 ', ' AND FOR_CGCCPF = 1 ');
  end;
end;

function TfrmEventosReinf.fSoSelecionouJaTransferidos: Boolean;
begin
  Result := False;

  if not Assigned(cdsCadFis) then
    Exit;

  if cdsCadFis.IsEmpty then
    Exit;

  try
    cdsCadFis.DisableControls;
    cdsCadFis.Filtered := False;
    cdsCadFis.Filter := 'LOT_SITUAC <> '+QuotedStr('3') + ' AND MARDES = ' + QuotedStr('M');
    cdsCadFis.Filtered := True;

    Result := cdsCadFis.IsEmpty;
  finally
   cdsCadFis.Filtered := False;
   cdsCadFis.EnableControls;

    if Result then
      fMensagem('ATENÇÃO', 'Todos lotes selecionados já foram transmitidos!', ['&Ok']);
  end;
end;

function TfrmEventosReinf.fLoteTemXml(tpXmlReinf: TtpXmlReinf): Boolean;
begin
  Result := False;

  if not Assigned(cdsCadFis) then
    Exit;

  if cdsCadFis.IsEmpty then
    Exit;

  try
    cdsCadFis.DisableControls;
    cdsCadFis.Filtered := False;
    cdsCadFis.Filter := IIF(tpXmlReinf = xmlEnvio, 'LOT_XMLENV IS NOT NULL ', 'LOT_XMLRET IS NOT NULL ') + ' AND MARDES = ' + QuotedStr('M');
    cdsCadFis.Filtered := True;

    Result := not cdsCadFis.IsEmpty;
  finally
   cdsCadFis.Filtered := False;
   cdsCadFis.EnableControls;

    if not Result then
      fMensagem('ATENÇÃO', 'O(s) lote(s) selecionado(s) não tem xml para baixar!', ['&Ok']);
  end;
end;

function TfrmEventosReinf.fTemLoteSelecionado: Boolean;
begin
  Result := False;

  if not Assigned(cdsCadFis) then
    Exit;

  if cdsCadFis.IsEmpty then
    Exit;

  try
    pFiltraSelecionados;
    Result := not cdsCadFis.IsEmpty;
  finally
    pRemoveFiltro;

    if not Result then
      fMensagem('ATENÇÃO', 'Nenhum lote selecionado para prosseguir com a operação!', ['&Ok']);
  end;
end;

procedure TfrmEventosReinf.pFiltraSelecionados;
begin
  cdsCadFis.DisableControls;
  cdsCadFis.Filtered := False;
  cdsCadFis.Filter := 'MARDES = '+QuotedStr('M');
  cdsCadFis.Filtered := True;
end;

procedure TfrmEventosReinf.pRemoveFiltro;
begin
  cdsCadFis.Filtered := False;
  cdsCadFis.First;
  cdsCadFis.EnableControls;
end;

function TfrmEventosReinf.fProcessarTransmissao: Boolean;
var
  qryAux: TUniQuery;
  strAutoIncremLote: String;
  strAutIncCadFis: String;
begin
  Result := True;

  strAutoIncremLote := EmptyStr;
  strAutIncCadFis := EmptyStr;

  if not fEmptyStr(ACBrReinf.WebServices.EnvioLote.RetEnvioLote.dadosRecepcaoLote.protocoloEnvio) then
  begin
    qryAux := fCriaQuery(Self);
    try
      fStartTransaction;
      try
        qryAux.Close;

        if fEmptyStr(cdsCadFis.FieldByName('AUTOINCREM_LOTE').AsString) then
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
          qryAux.ParamByName('STATUS').AsString := 'A';
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

          qryAux.ParamByName('AUTINC').AsString := cdsCadFis.FieldByName('AUTOINCREM_LOTE').AsString;
        end;

        qryAux.ParamByName('DTAENV').AsDateTime   := ACBrReinf.WebServices.EnvioLote.RetEnvioLote.dadosRecepcaoLote.dhRecepcao;
        qryAux.ParamByName('DESRET').AsString     := ACBrReinf.WebServices.EnvioLote.RetEnvioLote.Status.descRetorno;
        qryAux.ParamByName('PROTOC').AsString     := ACBrReinf.WebServices.EnvioLote.RetEnvioLote.dadosRecepcaoLote.protocoloEnvio;
        qryAux.ParamByName('ORIRET').AsString     := IIF(fEmptyStr(cdsCadFis.FieldByName('LOT_RECIBO').AsString), 'O', 'R');
        qryAux.ParamByName('XMLENV').AsAnsiString := fRetXmlEnvio;

        qryAux.ExecSQL;

        cdsNotas.DisableControls;
        cdsNotas.First;
        while not cdsNotas.Eof do
        begin
          strAutIncCadFis := strAutIncCadFis + IIF(fEmptyStr(strAutIncCadFis), '', ',') + QuotedStr(cdsNotas.FieldByName('AUTOINCREM').AsString);
          cdsNotas.Next;
        end;
        cdsNotas.EnableControls;

        qryAux.Close;
        qryAux.SQL.Text :=
        ' UPDATE '+
        '   CADFIS '+
        ' SET '+
        fRetFisLotReiCADFIS + ' = :LOTREI '+
        ' WHERE AUTOINCREM IN ('+strAutIncCadFis+') '+
        '   AND FIS_FORCLI = :FORCLI ';

        qryAux.ParamByName('LOTREI').AsString := IIF(fEmptyStr(cdsCadFis.FieldByName('AUTOINCREM_LOTE').AsString),
                                                     strAutoIncremLote,
                                                     cdsCadFis.FieldByName('AUTOINCREM_LOTE').AsString);

        qryAux.ParamByName('FORCLI').AsString := cdsCadFis.FieldByName('FIS_FORCLI').AsString;
        qryAux.ExecSQL;

        fCommit;
      except
        on E: Exception do
        begin
          Result := False;
          fRollBack;
          pMensagensErro(E.Message, 'TfrmEventosReinf.fProcessarTransmissao');
        end;
      end;

    finally
      FreeAndNil(qryAux);
    end;
  end
  else
    Result := False;

end;

function TfrmEventosReinf.fRetFisLotReiCADFIS: String;
begin
  case tpEvento of
    R2010, R2020 : Result := 'FIS_LOTREI_2000';
    R4010, R4020, R4080 : Result := 'FIS_LOTREI_4000';
  end;
end;

function TfrmEventosReinf.fRetXmlEnvio: AnsiString;
begin
  case tpEvento of
    R2010: Result := ACBrReinf.Eventos.ReinfEventos.R2010.Items[0].evtServTom.XML;
    R2020: Result := ACBrReinf.Eventos.ReinfEventos.R2020.Items[0].evtServPrest.XML;
    R4010: Result := ACBrReinf.Eventos.ReinfEventos.R4010.Items[0].evtRetPF.XML;
    R4020: Result := ACBrReinf.Eventos.ReinfEventos.R4020.Items[0].evtRetPJ.XML;
  end;
end;

function TfrmEventosReinf.fProntoParaConsultarProcessamentoDosLotes: Boolean;
begin
  Result := True;

  if fEmptyStr(Self.strCodEmp) then
    Exit(False);

  if not fReinfContribuinteAutorizado(Self.strCodEmp) then
    Exit(False);

  if not Assigned(cdsCadFis) then
    Exit(False);

  if cdsCadFis.IsEmpty then
    Exit(False);
end;

function TfrmEventosReinf.fProntoParaTransmitirOuRetificarLote: Boolean;
begin
  Result := True;

  if fEmptyStr(Self.strCodEmp) then
    Exit(False);

  if not fReinfContribuinteAutorizado(Self.strCodEmp) then
    Exit(False);

  if not Assigned(cdsCadFis) then
    Exit(False);
end;

procedure TfrmEventosReinf.tmrConsultarProcessamentoTimer(Sender: TObject);
begin
  inherited;
  tmrConsultarProcessamento.Enabled := False;
  TfrmGravando.fExecutarModal(pConsultarProcessamentoLote, 'Consultando Processamento dos lotes '+fRetEvento, '');
end;

procedure TfrmEventosReinf.btnBaixarXmlEnvioClick(Sender: TObject);
begin
  inherited;
  if not Assigned(cdsCadFis) then
    Exit;

  if not fTemLoteSelecionado then
    Exit;

  if not fLoteTemXml(xmlEnvio) then
    Exit;

  cdsCadFis.AfterScroll := Nil;
  TfrmGravando.fExecutarModal(pSalvarXmlEnvio, 'Baixando xml, aguarde...', '');
  cdsCadFis.AfterScroll := pAfterScrollCdsCadFis;
end;

procedure TfrmEventosReinf.btnBaixarXmlRetornoClick(Sender: TObject);
begin
  inherited;
  if not Assigned(cdsCadFis) then
    Exit;

  if not fTemLoteSelecionado then
    Exit;

  if not fLoteTemXml(xmlRetorno) then
    Exit;

  cdsCadFis.AfterScroll := Nil;
  TfrmGravando.fExecutarModal(pSalvarXmlRetorno, 'Baixando xml, aguarde...', '');
  cdsCadFis.AfterScroll := pAfterScrollCdsCadFis;
end;

procedure TfrmEventosReinf.btnCarregarPeríodoClick(Sender: TObject);
begin
  inherited;
  if not fVerificaCampos then
    Exit;

  TfrmGravando.fExecutarModal(pCarregarPeriodoDeApuracao, 'Aguarde...', '');
  tmrConsultarProcessamento.Enabled := True;
end;

procedure TfrmEventosReinf.btnConsultaLoteClick(Sender: TObject);
begin
  inherited;
  TfrmGravando.fExecutarModal(pConsultarLotePosicionado, 'Consultando Processamento do lote posicionado!', '');
end;

procedure TfrmEventosReinf.btnDesmarcarTodosClick(Sender: TObject);
begin
  inherited;
  pSeleciona('D');
end;

procedure TfrmEventosReinf.btnMarcarTodosClick(Sender: TObject);
begin
  inherited;
  pSeleciona('M');
end;

procedure TfrmEventosReinf.pConsultarLotePosicionado;
var
  blnProcessouLote: Boolean;
begin
  case tpEvento of
    R2010, R2020: pConsultarLote2000(blnProcessouLote);
    R4010, R4020, R4080: pConsultarLote4000(blnProcessouLote);
  end;

  if blnProcessouLote then
    pCarregarPeriodoDeApuracao;
end;

procedure TfrmEventosReinf.pConsultarProcessamentoLote;
var
 blnProcessouLote: Boolean;
begin
  inherited;

  if not fProntoParaConsultarProcessamentoDosLotes then
    Exit;

  blnProcessouLote := False;

  cdsCadFis.DisableControls;

  cdsCadFis.First;
  while not cdsCadFis.Eof do
  begin
    if (not fEmptyStr(cdsCadFis.FieldByName('LOT_PROTOC').AsString)) and
       (fEmptyStr(cdsCadFis.FieldByName('LOT_CODRET').AsString)) then
    begin
      case tpEvento of
        R2010, R2020: pConsultarLote2000(blnProcessouLote);
        R4010, R4020, R4080: pConsultarLote4000(blnProcessouLote);
      end;
    end;

    cdsCadFis.Next;
  end;

  if blnProcessouLote then
    pCarregarPeriodoDeApuracao;

  cdsCadFis.EnableControls;
end;

procedure TfrmEventosReinf.pConsultarLote2000(var blnProcessouLote: Boolean);
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
      if ACBrReinf.Consultar(cdsCadFis.FieldByName('LOT_PROTOC').AsString) then
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

        pAtualizaRetornoLote(ACBrReinf.WebServices.Consultar.RetEnvioLote.evento.Items[0].evtTotal.IdeStatus.cdRetorno,
                             IIF(not fEmptyStr(strDescErro), strDescErro, ACBrReinf.WebServices.Consultar.RetEnvioLote.evento.Items[0].evtTotal.IdeStatus.descRetorno),
                             strDescErro,
                             ACBrReinf.WebServices.Consultar.RetWS,
                             ACBrReinf.WebServices.Consultar.RetEnvioLote.evento.Items[0].Id,
                             ACBrReinf.WebServices.Consultar.RetEnvioLote.evento.Items[0].evtTotal.InfoRecEv.nrRecArqBase);

        blnProcessouLote := True;

        Break;
      end;
    end;
  except
    on E: Exception do
      pMensagensErro(E.Message, 'TfrmEventosReinf.pConsultarLote2000');
  end;

end;

procedure TfrmEventosReinf.pConsultarLote4000(var blnProcessouLote: Boolean);
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
      if ACBrReinf.Consultar(cdsCadFis.FieldByName('LOT_PROTOC').AsString) then
      begin

        if ACBrReinf.WebServices.Consultar.RetEnvioLote.evento.Count = 0 then
        begin
          Sleep(3000);
          Continue;
        end;

        strDescErro := EmptyStr;
        if ACBrReinf.WebServices.Consultar.RetEnvioLote.evento.Items[0].evtRet.IdeStatus.cdRetorno = RETORNO_ERRO then
        begin
          for intCountErro := 0 to ACBrReinf.WebServices.Consultar.RetEnvioLote.evento.Items[0].evtRet.IdeStatus.regOcorrs.Count - 1 do
          begin
            strDescErro := strDescErro + ACBrReinf.WebServices.Consultar.RetEnvioLote.evento.Items[0].evtRet.IdeStatus.regOcorrs.Items[intCountErro].codResp + ' ' +
                                         ACBrReinf.WebServices.Consultar.RetEnvioLote.evento.Items[0].evtRet.IdeStatus.regOcorrs.Items[intCountErro].dscResp + sLineBreak + sLineBreak;
          end;
        end;

        pAtualizaRetornoLote(ACBrReinf.WebServices.Consultar.RetEnvioLote.evento.Items[0].evtRet.IdeStatus.cdRetorno,
                             IIF(not fEmptyStr(strDescErro), strDescErro, ACBrReinf.WebServices.Consultar.RetEnvioLote.evento.Items[0].evtRet.IdeStatus.descRetorno),
                             strDescErro,
                             ACBrReinf.WebServices.Consultar.RetWS,
                             ACBrReinf.WebServices.Consultar.RetEnvioLote.evento.Items[0].Id,
                             ACBrReinf.WebServices.Consultar.RetEnvioLote.evento.Items[0].evtRet.InfoRecEv.nrRecArqBase);

        blnProcessouLote := True;

        Break;
      end;
    end;
  except
    on E: Exception do
      pMensagensErro(E.Message, 'TfrmEventosReinf.pConsultarLote4000');
  end;

end;

procedure TfrmEventosReinf.pAtualizaRetornoLote(const strCodRet,
                                                strDesRet,
                                                strDescErro,
                                                strXmlRet,
                                                strIdeEve,
                                                strRecibo: String);
const
  RETORNO_SUCESSO = '0';
  RETORNO_ERRO = '1';

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
    '  ,LOT_SITUAC = :SITUAC '+
    IIF(fEmptyStr(strDescErro),
        '  ,LOT_RECIBO = :RECIBO ',
        '')+
    ' WHERE '+
    '   AUTOINCREM = :AUTINC ';

    qryAux.ParamByName('CODRET').AsString := strCodRet;
    qryAux.ParamByName('DESRET').AsString := strDesRet;
    qryAux.ParamByName('XMLRET').AsString := strXmlRet;
    qryAux.ParamByName('IDEEVE').AsString := strIdeEve;

    qryAux.ParamByName('SITUAC').AsString := IIF(strCodRet = RETORNO_SUCESSO,
                                                 '3',
                                                 IIF(strCodRet = RETORNO_ERRO,
                                                     '0',
                                                     '2')
                                                 );

    if fEmptyStr(strDescErro)then
      qryAux.ParamByName('RECIBO').AsString := strRecibo;

    qryAux.ParamByName('AUTINC').AsString := cdsCadFis.FieldByName('AUTOINCREM_LOTE').AsString;
    qryAux.ExecSQL;
  finally
    FreeAndNil(qryAux);
  end;
end;

end.
