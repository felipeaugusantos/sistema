unit untEventoR1000;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, untMskTelefone, Vcl.Mask, Uni, UniClientDataSet,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, pcnConversaoReinf,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, ACBrReinf, untTypesSistema,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData, System.UITypes,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, MaskEditFocus, untMskC_G_C_,
  Vcl.StdCtrls, ComboBoxFocus, EditFocus, frxClass, frxExportCSVTestabilidade,
  Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls;

type
  TfrmEventoR1000 = class(TfrmPai)
    pnlInferior: TPanel;
    btnGravarR1000: TBitBtnLocked;
    btnTransmitirR1000: TBitBtnLocked;
    btnBaixarXmlEnvio: TBitBtnLocked;
    btnBaixarXmlRetorno: TBitBtnLocked;
    SaveDialog: TSaveDialog;
    btnConsultaLote: TBitBtnLocked;
    tmrConsultarProcessamento: TTimer;
    pnlPrincipal: TPanel;
    lblClassTrib: TLabel;
    lblEscrituracao: TLabel;
    lblDesoneracao: TLabel;
    lblAcordo: TLabel;
    lblSituacao: TLabel;
    lblUniao: TLabel;
    edtCodClassTrib: TEditFocus;
    edtClassTrib: TEditFocus;
    cmbEscrituracao: TComboBoxFocus;
    cmbDesoneracao: TComboBoxFocus;
    cmbAcordo: TComboBoxFocus;
    cmbSituacao: TComboBoxFocus;
    cmbUniao: TComboBoxFocus;
    gpbInfoContato: TGroupBox;
    lblNomCtt: TLabel;
    lblCpfCtt: TLabel;
    lblFoneCtt: TLabel;
    lblCelCtt: TLabel;
    lblEmailCtt: TLabel;
    edtNomCtt: TEditFocus;
    mskCpfCtt: TMaskEditC_G_C_;
    edtEmaCtt: TEditFocus;
    mskTelCtt: TMaskEditFocus;
    mskCelCtt: TMaskEditFocus;
    gpbRetornoR1000: TGroupBox;
    cxgRetornoR1000: TcxGridCitel;
    cxgRetornoR1000DBTableViewCitel1: TcxGridDBTableViewCitel;
    cxgRetornoLOT_DTAENV: TcxGridDBColumn;
    cxgRetornoLOT_PROTOC: TcxGridDBColumn;
    cxgRetornoLOT_DESRET: TcxGridDBColumn;
    cxgRetornoLOT_IDEEVE: TcxGridDBColumn;
    cxgRetornoLOT_RECIBO: TcxGridDBColumn;
    cxgRetornoR1000Level1: TcxGridLevel;
    cxgRetornoLOT_CODRET: TcxGridDBColumn;
    shaErro: TShape;
    shaSucesso: TShape;
    lblErro: TLabel;
    lblSucesso: TLabel;
    btnCadManual: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnTransmitirR1000Click(Sender: TObject);
    procedure edtCodClassTribKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarR1000Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxgRetornoR1000DBTableViewCitel1DblClick(Sender: TObject);
    procedure btnBaixarXmlEnvioClick(Sender: TObject);
    procedure btnBaixarXmlRetornoClick(Sender: TObject);
    procedure btnConsultaLoteClick(Sender: TObject);
    procedure tmrConsultarProcessamentoTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxgRetornoR1000DBTableViewCitel1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnCadManualClick(Sender: TObject);
  private
    { Private declarations }
    cdsR1000: TUniClientDataSet;
    dtsR1000: TDataSource;

    blnCarregaR1000: Boolean;

    procedure pAlinhaPanelPrincipal;

    function fValidaClassificacaoTributaria: Boolean;

    function fLoteTemXml(tpXmlReinf: TtpXmlReinf): Boolean;

    procedure pConfiguraDts;
    procedure pGravaR1000;
    procedure pSalvarXmlEnvio;
    procedure pSalvarXmlRetorno;

    function fGetTipoOperacao: TTipoOperacao;

    procedure PreencherXMLR1000;

    procedure pTransmitirR1000;
    procedure pConsultarProcessamento;

    function fEventoProntoParaTransmissaoEConsulta: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    ACBrReinf: TACBrReinf;
    qryR1000: TUniQuery;

    strCodEmp: String;

    procedure pCarregaR1000;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas,
  pcnReinfR1000, ACBrUtil.DateTime, ACBrReinfConfiguracoes,
  untMensagemExplicativa, untGravando, untFuncoes, untReinfCadastroManualR1000;

procedure TfrmEventoR1000.btnBaixarXmlEnvioClick(Sender: TObject);
begin
  inherited;
  TfrmGravando.fExecutarModal(pSalvarXmlEnvio, 'Baixando xml, aguarde...', '');
end;

procedure TfrmEventoR1000.btnBaixarXmlRetornoClick(Sender: TObject);
begin
  inherited;
  TfrmGravando.fExecutarModal(pSalvarXmlRetorno, 'Baixando xml, aguarde...', '');
end;

procedure TfrmEventoR1000.btnCadManualClick(Sender: TObject);
const
  TIPO_EVENTO = 'R1000';
                         
  SQL_UPDATE_LOTE = ' UPDATE '+
                    '   REINF_LOTES '+
                    ' SET '+
                    '   LOT_RECIBO = :RECIBO '+
                    '  ,LOT_DESRET = :DESRET '+
                    '  ,LOT_CODRET = :CODRET '+
                    '  ,LOT_PROTOC =  NULL '+
                    ' WHERE '+
                    '   AUTOINCREM = :AUTINC ';  
var  
  qryAux: TUniQuery;
  frmReinfCadastroManualR1000: TfrmReinfCadastroManualR1000;
begin
  inherited;

  pCriarFormularios(TfrmReinfCadastroManualR1000, frmReinfCadastroManualR1000);
  try
    frmReinfCadastroManualR1000.ShowModal;
    if (frmReinfCadastroManualR1000.ModalResult = mrOk) and (not fEmptyStr(frmReinfCadastroManualR1000.edtNumRecibo.Text)) then
    begin
       qryAux := fCriaQuery(Self);
      try
        qryAux.Close;
        qryAux.SQL.Text := SQL_UPDATE_LOTE;
        qryAux.ParamByName('AUTINC').AsString := cdsR1000.FieldByName('REI_LOTREI').AsString;
        qryAux.ParamByName('RECIBO').AsString := frmReinfCadastroManualR1000.edtNumRecibo.Text;
        qryAux.ParamByName('DESRET').AsString := 'SUCESSO';
        qryAux.ParamByName('CODRET').AsString := '0';

        qryAux.ExecSQL;
        pCarregaR1000;
      finally
        FreeAndNil(qryAux);
      end;
    end;
  finally
    pFreeAndNil(frmReinfCadastroManualR1000);
  end;
end;

procedure TfrmEventoR1000.btnConsultaLoteClick(Sender: TObject);
begin
  TfrmGravando.fExecutarModal(pConsultarProcessamento, 'Consultando Processamento do Evento R1000', '');
end;

procedure TfrmEventoR1000.btnGravarR1000Click(Sender: TObject);
begin
  inherited;
  blnCarregaR1000 := False;

  if not fVerificaCampos then
    Exit;

  pGravaR1000;
end;

procedure TfrmEventoR1000.btnTransmitirR1000Click(Sender: TObject);
begin
  if not fPergunta('Deseja transmitir as informações do contribuinte?') then
    Exit;
    
  TfrmGravando.fExecutarModal(pTransmitirR1000, 'Transmitindo Informações do Contribuinte - R1000', '');
end;

procedure TfrmEventoR1000.pTransmitirR1000;
const
  TIPO_EVENTO = 'R1000';

  SQL_INSERT_ENVIO = ' INSERT INTO REINF_LOTES '+
                     '   (AUTOINCREM, '+
                     '    LOT_DTAENV, '+
                     '    LOT_PROTOC, '+
                     '    LOT_DESRET, '+
                     '    LOT_XMLENV, '+
                     '    LOT_CODEMP, '+
                     '    LOT_EVENTO) '+
                     ' VALUES '+
                     '   (:AUTINC,  '+
                     '    :DTAENV,  '+
                     '    :PROTOC,  '+
                     '    :DESRET,  '+
                     '    :XMLENV,  '+
                     '    :CODEMP,  '+
                     '    :EVENTO)  ';

  SQL_UPDATE_ENVIO = ' UPDATE '+
                     '   REINF_LOTES '+
                     ' SET '+
                     '    LOT_DTAENV = :DTAENV '+
                     '   ,LOT_PROTOC = :PROTOC '+
                     '   ,LOT_DESRET = :DESRET '+
                     '   ,LOT_XMLENV = :XMLENV '+
                     ' WHERE '+
                     '   AUTOINCREM = :AUTINC ';

  SQL_UPDATE_R1000 = ' UPDATE '+
                     '   REINF_R1000 '+
                     ' SET '+
                     '   REI_LOTREI = :LOTREI '+
                     ' WHERE '+
                     '   AUTOINCREM = :AUTINC ';
var
  qryAux: TUniQuery;
  strAutIncLote: String;
begin
  inherited;

  if not fEventoProntoParaTransmissaoEConsulta then
    Exit;  

  try
    ACBrReinf.Eventos.Clear;
    PreencherXMLR1000;

    ACBrReinf.Eventos.Gerar;
    ACBrReinf.Eventos.Assinar;

    if ACBrReinf.Enviar then
    begin
      if not fEmptyStr(ACBrReinf.WebServices.EnvioLote.RetEnvioLote.dadosRecepcaoLote.protocoloEnvio) then
      begin
        qryAux := fCriaQuery(Self);
        try
          strAutIncLote := IIF(fEmptyStr(cdsR1000.FieldByName('REI_LOTREI').AsString),
                               fRetAutoIncrem('REINF_LOTES', strCodEmp),
                               cdsR1000.FieldByName('REI_LOTREI').AsString);

          fStartTransaction;

          qryAux.Close;
          qryAux.SQL.Text := IIF(fEmptyStr(cdsR1000.FieldByName('REI_LOTREI').AsString), SQL_INSERT_ENVIO, SQL_UPDATE_ENVIO);
          qryAux.ParamByName('AUTINC').AsString := strAutIncLote;
          qryAux.ParamByName('DTAENV').AsDateTime := ACBrReinf.WebServices.EnvioLote.RetEnvioLote.dadosRecepcaoLote.dhRecepcao;
          qryAux.ParamByName('DESRET').AsString := ACBrReinf.WebServices.EnvioLote.RetEnvioLote.Status.descRetorno;
          qryAux.ParamByName('XMLENV').AsAnsiString := ACBrReinf.Eventos.ReinfEventos.R1000.Items[0].evtInfoContri.XML;
          qryAux.ParamByName('PROTOC').AsString := ACBrReinf.WebServices.EnvioLote.RetEnvioLote.dadosRecepcaoLote.protocoloEnvio;

          if fEmptyStr(cdsR1000.FieldByName('REI_LOTREI').AsString) then
          begin
            qryAux.ParamByName('EVENTO').AsString := TIPO_EVENTO;
            qryAux.ParamByName('CODEMP').AsString := strCodEmp;
          end;

          qryAux.ExecSQL;

          if fEmptyStr(cdsR1000.FieldByName('REI_LOTREI').AsString) then
          begin
            qryAux.Close;
            qryAux.SQL.Text := SQL_UPDATE_R1000;
            qryAux.ParamByName('LOTREI').AsString := strAutIncLote;
            qryAux.ParamByName('AUTINC').AsString := qryR1000.FieldByName('AUTOINCREM').AsString;
            qryAux.ExecSQL;
          end;

          fCommit;
        finally
          FreeAndNil(qryAux);
        end;

        btnTransmitirR1000.Enabled := False;
        pCarregaR1000;
        tmrConsultarProcessamento.Enabled := True;
      end
      else
        Exit;
    end;
  except
    on E: Exception do
    begin
      fRollBack;
      fMensagem('ATENÇÃO!', E.Message, ['&Ok']);
    end;
  end;
end;

procedure TfrmEventoR1000.tmrConsultarProcessamentoTimer(Sender: TObject);
begin
  inherited;
  tmrConsultarProcessamento.Enabled := False;
  TfrmGravando.fExecutarModal(pConsultarProcessamento, 'Consultando Processamento do Evento R1000', '');
end;

procedure TfrmEventoR1000.cxgRetornoR1000DBTableViewCitel1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  if not Assigned(cdsR1000) then
    Exit;

  if not cdsR1000.Active then
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

procedure TfrmEventoR1000.cxgRetornoR1000DBTableViewCitel1DblClick(
  Sender: TObject);
begin
  inherited;
  if not Assigned(cdsR1000) then
    Exit;

  if cdsR1000.IsEmpty then
    Exit;

  TfrmMensagemExplicativa.pMensagem(cdsR1000.FieldByName('LOT_DESRET').AsString);
end;

procedure TfrmEventoR1000.edtCodClassTribKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrSel: TConsultasArray;
begin
  inherited;
  if fPesqReinfClassificacaoTributaria(Self, edtCodClassTrib, edtClassTrib, nil, Key, arrSel) then
    fValidaCampos(edtCodClassTrib, True);
end;

procedure TfrmEventoR1000.FormCreate(Sender: TObject);
begin
  inherited;
  blnMudarFoco := False;

  blnCarregaR1000 := True;
end;

procedure TfrmEventoR1000.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(dtsR1000) then
    FreeAndNil(dtsR1000);

  if Assigned(cdsR1000) then
    FreeAndNil(cdsR1000);

  if Assigned(qryR1000) then
    FreeAndNil(qryR1000);
end;

procedure TfrmEventoR1000.FormShow(Sender: TObject);
begin
  inherited;

  pAlinhaPanelPrincipal;

  if fEmptyStr(Self.strCodEmp) then
    Exit;

  pCarregaR1000;
end;

procedure TfrmEventoR1000.pAlinhaPanelPrincipal;
begin
  pnlPrincipal.Left := (Self.Width - pnlPrincipal.Width) div 2;
  //pnlPrincipal.Top := (Self.Height - pnlPrincipal.Height) div 2;
end;

procedure TfrmEventoR1000.pCarregaR1000;
const
  SQL_R1000 = ' SELECT '+
              '   "M" AS MARDES, '+
              '   REINF_R1000.AUTOINCREM, '+
              '   REI_CODEMP, '+
              '   REI_CLATRI, '+
              '   CLA_DESCRI, '+
              '   REI_ESCRIT, '+
              '   REI_DESONE, '+
              '   REI_ACORDO, '+
              '   REI_SITUAC, '+
              '   REI_VINUNI, '+
              '   REI_NOMCTT, '+
              '   REI_CPFCTT, '+
              '   REI_FONCTT, '+
              '   REI_CELCTT, '+
              '   REI_EMACTT, '+
              '   REI_LOTREI, '+
              '   LOT_CODRET, '+
              '   LOT_DTAENV, '+
              '   LOT_PROTOC, '+
              '   LOT_DESRET, '+
              '   LOT_RECIBO, '+
              '   LOT_XMLENV, '+
              '   LOT_XMLRET, '+
              '   LOT_EVENTO, '+
              '   LOT_IDEEVE  '+
              ' FROM '+
              '   REINF_R1000 '+
              ' INNER JOIN REINF_TABE08 ON '+
              '   REI_CLATRI = CLA_CODIGO '+
              ' LEFT JOIN REINF_LOTES ON '+
              '   REI_LOTREI = REINF_LOTES.AUTOINCREM '+
              ' WHERE '+
              '   REI_CODEMP = :CODEMP ';
begin
  if not Assigned(qryR1000) then
    qryR1000 := fCriaQuery(Self);

  qryR1000.Close;
  qryR1000.SQL.Text := SQL_R1000;
  qryR1000.ParamByName('CODEMP').AsString := strCodEmp;
  qryR1000.Open;

  edtCodClassTrib.Text := qryR1000.FieldByName('REI_CLATRI').AsString;
  edtClassTrib.Text := qryR1000.FieldByName('CLA_DESCRI').AsString;
  cmbEscrituracao.ItemIndex := StrToIntDef(qryR1000.FieldByName('REI_ESCRIT').AsString, 0);
  cmbDesoneracao.ItemIndex := StrToIntDef(qryR1000.FieldByName('REI_DESONE').AsString, 0);
  cmbAcordo.ItemIndex := StrToIntDef(qryR1000.FieldByName('REI_ACORDO').AsString, 0);
  cmbSituacao.ItemIndex := StrToIntDef(qryR1000.FieldByName('REI_SITUAC').AsString, 0);
  cmbUniao.ItemIndex := StrToIntDef(qryR1000.FieldByName('REI_VINUNI').AsString, 0);
  edtNomCtt.Text := qryR1000.FieldByName('REI_NOMCTT').AsString;
  mskCpfCtt.Text := qryR1000.FieldByName('REI_CPFCTT').AsString;
  mskTelCtt.Text := qryR1000.FieldByName('REI_FONCTT').AsString;
  mskCelCtt.Text := qryR1000.FieldByName('REI_CELCTT').AsString;
  edtEmaCtt.Text := qryR1000.FieldByName('REI_EMACTT').AsString;
  
  btnConsultaLote.Visible := (qryR1000.FieldByName('LOT_CODRET').AsString = '1') or (qryR1000.FieldByName('LOT_CODRET').AsString = '2');

  if (Pos('MS1005', qryR1000.FieldByName('LOT_DESRET').AsString) > 0) or
     ((fEmptyStr(qryR1000.FieldByName('LOT_PROTOC').AsString)) and (not fEmptyStr(qryR1000.FieldByName('LOT_RECIBO').AsString))) then
  begin
    btnCadManual.Visible := True;
    if not fEmptyStr(qryR1000.FieldByName('LOT_RECIBO').AsString) then
      btnCadManual.Caption := 'Editar Número do Recibo';
  end;

  if Assigned(cdsR1000) then
  begin
    FreeAndNil(dtsR1000);
    FreeAndNil(cdsR1000);
  end;

  cdsR1000 := fCriaClientDatset(qryR1000);
  pConfiguraDts;
end;

procedure TfrmEventoR1000.pConfiguraDts;
begin
  pSetaClient(cdsR1000);
  dtsR1000 := fCriaDataSource(cdsR1000);
  cxgRetornoR1000DBTableViewCitel1.DataController.DataSource := dtsR1000;
end;

procedure TfrmEventoR1000.pConsultarProcessamento;
const
  RETORNO_ERRO = '1';
var
  qryAux: TUniQuery;

  intCount,
  intCountErro: Integer;
  strDescErro: String;
begin
  inherited;

  if not fEventoProntoParaTransmissaoEConsulta then
    Exit;

  if fEmptyStr(qryR1000.FieldByName('LOT_PROTOC').AsString) then
    Exit;

  try
    for intCount := 1 to 20 do
    begin
      if ACBrReinf.Consultar(qryR1000.FieldByName('LOT_PROTOC').AsString) then
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
          IIF(fEmptyStr(strDescErro),
              '  ,LOT_RECIBO = :RECIBO ',
              '')+
          ' WHERE '+
          '   AUTOINCREM = :AUTINC ';

          qryAux.ParamByName('CODRET').AsString := ACBrReinf.WebServices.Consultar.RetEnvioLote.evento.Items[0].evtTotal.IdeStatus.cdRetorno;
          qryAux.ParamByName('DESRET').AsString := IIF(not fEmptyStr(strDescErro), strDescErro, ACBrReinf.WebServices.Consultar.RetEnvioLote.evento.Items[0].evtTotal.IdeStatus.descRetorno);
          qryAux.ParamByName('XMLRET').AsString := ACBrReinf.WebServices.Consultar.RetWS;
          qryAux.ParamByName('IDEEVE').AsString := ACBrReinf.WebServices.Consultar.RetEnvioLote.evento.Items[0].Id;

          if fEmptyStr(strDescErro)then
            qryAux.ParamByName('RECIBO').AsString := ACBrReinf.WebServices.Consultar.RetEnvioLote.evento.Items[0].evtTotal.InfoRecEv.nrRecArqBase;

          qryAux.ParamByName('AUTINC').AsString := qryR1000.FieldByName('REI_LOTREI').AsString;
          qryAux.ExecSQL;         
            
        finally
          FreeAndNil(qryAux);
        end;
        Break;
      end;
    end;

    pCarregaR1000;
  except
    on E: Exception do
      fMensagem('ATENÇÃO!', E.Message, ['&Ok']);
  end;
end;

procedure TfrmEventoR1000.pGravaR1000;
const
  SQL_INSERT_R1000 = ' INSERT INTO REINF_R1000 '+
                     '   (AUTOINCREM, '+
                     '    REI_CODEMP, '+
                     '    REI_CLATRI, '+
                     '    REI_ESCRIT, '+
                     '    REI_DESONE, '+
                     '    REI_ACORDO, '+
                     '    REI_SITUAC, '+
                     '    REI_VINUNI, '+
                     '    REI_NOMCTT, '+
                     '    REI_CPFCTT, '+
                     '    REI_FONCTT, '+
                     '    REI_CELCTT, '+
                     '    REI_EMACTT) '+
                     ' VALUES '+
                         '(:AUTINC, '+
                     '     :CODEMP, '+
                     '     :CLATRI, '+
                     '     :ESCRIT, '+
                     '     :DESONE, '+
                     '     :ACORDO, '+
                     '     :SITUAC, '+
                     '     :VINUNI, '+
                     '     :NOMCTT, '+
                     '     :CPFCTT, '+
                     '     :FONCTT, '+
                     '     :CELCTT, '+
                     '     :EMACTT) ';

  SQL_UPDATE_R1000 = ' UPDATE '+
                     '   REINF_R1000 '+
                     ' SET '+
                     '    REI_CLATRI = :CLATRI'+
                     '   ,REI_ESCRIT = :ESCRIT'+
                     '   ,REI_DESONE = :DESONE'+
                     '   ,REI_ACORDO = :ACORDO'+
                     '   ,REI_SITUAC = :SITUAC'+
                     '   ,REI_VINUNI = :VINUNI'+
                     '   ,REI_NOMCTT = :NOMCTT'+
                     '   ,REI_CPFCTT = :CPFCTT'+
                     '   ,REI_FONCTT = :FONCTT'+
                     '   ,REI_CELCTT = :CELCTT'+
                     '   ,REI_EMACTT = :EMACTT'+
                     ' WHERE '+
                     '    AUTOINCREM = :AUTINC AND '+
                     '    REI_CODEMP = :CODEMP ';

var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  try
    qryAux.Close;
    qryAux.SQL.Text := IIF(qryR1000.IsEmpty, SQL_INSERT_R1000, SQL_UPDATE_R1000);

    if qryR1000.IsEmpty then
      qryAux.ParamByName('AUTINC').AsString := fRetAutoIncrem('REINF_R1000', VS_strCodEmp)
    else
      qryAux.ParamByName('AUTINC').AsString := qryR1000.FieldByName('AUTOINCREM').AsString;

    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('CLATRI').AsString := edtCodClassTrib.Text;
    qryAux.ParamByName('ESCRIT').AsString := IntToStr(cmbEscrituracao.ItemIndex);
    qryAux.ParamByName('DESONE').AsString := IntToStr(cmbDesoneracao.ItemIndex);
    qryAux.ParamByName('ACORDO').AsString := IntToStr(cmbAcordo.ItemIndex);
    qryAux.ParamByName('SITUAC').AsString := IntToStr(cmbSituacao.ItemIndex);
    qryAux.ParamByName('VINUNI').AsString := IntToStr(cmbUniao.ItemIndex);
    qryAux.ParamByName('NOMCTT').AsString := edtNomCtt.Text;
    qryAux.ParamByName('CPFCTT').AsString := fTiraCaracEspeciais(mskCpfCtt.Text, True, True, True, True, True, True);
    qryAux.ParamByName('FONCTT').AsString := fTiraCaracEspeciais(mskTelCtt.Text, True, True, True, True, True, True);
    qryAux.ParamByName('CELCTT').AsString := fTiraCaracEspeciais(mskCelCtt.Text, True, True, True, True, True, True);
    qryAux.ParamByName('EMACTT').AsString := edtEmaCtt.Text;
    qryAux.ExecSQL;

    pCarregaR1000;

    btnTransmitirR1000.Enabled := True;
    fMensagem('ATENÇÃO!', 'Informações do contribuinte gravadas com sucesso!', ['&Ok']);
  finally
    FreeAndNil(qryAux);
  end;
end;

function TfrmEventoR1000.fEventoProntoParaTransmissaoEConsulta: Boolean;
begin
  Result := True;

  if fEmptyStr(strCodEmp) then
    Exit(False);

  if not Assigned(qryR1000) then
    Exit(False);

  if not fReinfContribuinteCadastrado(qryR1000.FieldByName('REI_CODEMP').AsString) then
  begin
    fMensagem('ATENÇÃO!', 'Faça a gravação das informações antes de Transmitir/Consultar Processamento!', ['&Ok']);
    Exit(False);
  end;
end;

function TfrmEventoR1000.fGetTipoOperacao: TTipoOperacao;
begin
  Result := toInclusao;
  if (not fEmptyStr(cdsR1000.FieldByName('LOT_RECIBO').AsString)) then
    Result := toAlteracao;

  //Result := toExclusao;
end;

procedure TfrmEventoR1000.PreencherXMLR1000;
var
  ok: Boolean;
  objR1000: TR1000CollectionItem;
  objSoftwareHouse: TSoftwareHouseCollectionItem;
begin
  ACBrReinf.Eventos.Clear;
  ACBrReinf.Eventos.ReinfEventos.R1000.Clear;
  objR1000 := ACBrReinf.Eventos.ReinfEventos.R1000.New;

  objR1000.evtInfoContri.Sequencial     := 0;
  objR1000.evtInfoContri.ModoLancamento := fGetTipoOperacao;

  objR1000.evtInfoContri.IdeEvento.ProcEmi := peAplicEmpregador;
  objR1000.evtInfoContri.IdeEvento.VerProc := '1.0';

  objR1000.evtInfoContri.ideContri.TpInsc := tiCNPJ;
  objR1000.evtInfoContri.ideContri.NrInsc := ACBrReinf.Configuracoes.Geral.IdContribuinte;

  objR1000.evtInfoContri.infoContribuinte.IdePeriodo.IniValid := FormatDateBr(IncMonth(Date,-1),'yyyy-mm');

  objR1000.evtInfoContri.infoContribuinte.IdePeriodo.FimValid := EmptyStr;

  objR1000.evtInfoContri.infoContribuinte.InfoCadastro.ClassTrib := StrTotpClassTrib(Ok, edtCodClassTrib.Text);

  objR1000.evtInfoContri.infoContribuinte.InfoCadastro.indEscrituracao    := TindEscrituracao(cmbEscrituracao.ItemIndex);
  objR1000.evtInfoContri.infoContribuinte.InfoCadastro.indDesoneracao     := TindDesoneracao(cmbDesoneracao.ItemIndex);
  objR1000.evtInfoContri.infoContribuinte.InfoCadastro.indAcordoIsenMulta := TindAcordoIsenMulta(cmbAcordo.ItemIndex);
  objR1000.evtInfoContri.infoContribuinte.InfoCadastro.indSitPJ           := TindSitPJ(cmbSituacao.ItemIndex);
  objR1000.evtInfoContri.infoContribuinte.InfoCadastro.indUniao           := IIF(cmbUniao.ItemIndex = 0, EmptyStr, IntToStr(cmbUniao.ItemIndex));
  objR1000.evtInfoContri.infoContribuinte.InfoCadastro.dtTransfFinsLucr   := 0;
  objR1000.evtInfoContri.infoContribuinte.InfoCadastro.dtObito            := 0;

  objR1000.evtInfoContri.infoContribuinte.InfoCadastro.Contato.NmCtt    := edtNomCtt.Text;
  objR1000.evtInfoContri.infoContribuinte.InfoCadastro.Contato.CpfCtt   := fTiraCaracEspeciais(mskCpfCtt.Text, True, True, True, True, True, True);
  objR1000.evtInfoContri.infoContribuinte.InfoCadastro.Contato.FoneFixo := fTiraCaracEspeciais(mskTelCtt.Text, True, True, True, True, True, True);
  objR1000.evtInfoContri.infoContribuinte.InfoCadastro.Contato.FoneCel  := fTiraCaracEspeciais(mskCelCtt.Text, True, True, True, True, True, True);
  objR1000.evtInfoContri.infoContribuinte.InfoCadastro.Contato.email    := edtEmaCtt.Text;

  objR1000.evtInfoContri.infoContribuinte.InfoCadastro.SoftwareHouse.Clear;
  objSoftwareHouse := objR1000.evtInfoContri.infoContribuinte.InfoCadastro.SoftwareHouse.New;

  objSoftwareHouse.CnpjSoftHouse := '51212892000125';
  objSoftwareHouse.NmRazao       := 'CITEL ANALISE E PROGRAMACAO DE SISTEMAS LTDA';
  objSoftwareHouse.NmCont        := 'Citel';
  objSoftwareHouse.Telefone      := '1640096000';
  objSoftwareHouse.email         := 'citel@citelsoftware.com.br';
end;

procedure TfrmEventoR1000.pSalvarXmlEnvio;
begin
  if not fLoteTemXml(xmlEnvio) then
    Exit;

  pSalvarXmlReinf(xmlEnvio,
                  cdsR1000);
end;

procedure TfrmEventoR1000.pSalvarXmlRetorno;
begin
  if not fLoteTemXml(xmlRetorno) then
    Exit;

  pSalvarXmlReinf(xmlRetorno,
                  cdsR1000);
end;

function TfrmEventoR1000.fLoteTemXml(tpXmlReinf: TtpXmlReinf): Boolean;
begin
  Result := False;

  if not Assigned(cdsR1000) then
    Exit;

  if cdsR1000.IsEmpty then
    Exit;

  try
    Result := not fEmptyStr(cdsR1000.FieldByName(IIF(tpXmlReinf = xmlEnvio, 'LOT_XMLENV', 'LOT_XMLRET')).AsString);
  finally
    if not Result then
      fMensagem('ATENÇÃO', 'XML '+IIF(tpXmlReinf = xmlEnvio,'de envio', 'de retorno')+' não encontrado para baixar!', ['&Ok']);
  end;
end;

function TfrmEventoR1000.fValidaClassificacaoTributaria: Boolean;
begin
  Result := True;

  if fEmptyStr(edtCodClassTrib.Text) then
  begin
    fMensagem('ATENÇÃO!', 'Informe a Classificação Tributária!', ['&Ok']);
    Result := False;
  end
  else
  begin
    edtClassTrib.Text := fRetReinfClassificacaoTributaria(edtCodClassTrib.Text);
    if fEmptyStr(edtClassTrib.Text) then
    begin
      fMensagem('ATENÇÃO!', 'Classificação Tributária inválida!', ['&Ok']);
      Result := False;
    end;
  end;
end;

function TfrmEventoR1000.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin
    if Sender = edtCodClassTrib then
      Result := fValidaClassificacaoTributaria
    else if Sender = edtNomCtt then
    begin
      if fEmptyStr(edtNomCtt.Text) then
      begin
        fMensagem('ATENÇÃO!', 'Informe o nome do contato!', ['&Ok']);
        Result := False;
      end;
    end
    else if Sender = mskCpfCtt then
    begin
      if not fValidaCPF(mskCpfCtt.Text) then
      begin
        fMensagem('ATENÇÃO!', 'Cpf do contato inválido!', ['&Ok']);
        Result := False;
      end;
    end
    else if Sender = mskTelCtt then
    begin
      if (fEmptyStr(fTiraCaracEspeciais(mskTelCtt.Text, True, True, True, True, True, True))) or
         (Length(fTiraCaracEspeciais(mskTelCtt.Text, True, True, True, True, True, True)) < 10) then
      begin
        fMensagem('ATENÇÃO!', 'Telefone do contato inválido!', ['&Ok']);
        Result := False;
      end;
    end

    else if Sender = mskCelCtt then
    begin
      if fEmptyStr(fTiraCaracEspeciais(mskCelCtt.Text, True, True, True, True, True, True)) or
        (Length(fTiraCaracEspeciais(mskCelCtt.Text, True, True, True, True, True, True)) < 11) then
      begin
        fMensagem('ATENÇÃO!', 'Celular do contato inválido!', ['&Ok']);
        Result := False;
      end;
    end

    else if Sender = edtEmaCtt then
    begin
      if not fEnderecoEmailValido(edtEmaCtt.Text) then
      begin
        fMensagem('ATENÇÃO!', 'e-mail Inválido!', ['&Ok']);
        Result := False;
      end;
    end
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

end.
