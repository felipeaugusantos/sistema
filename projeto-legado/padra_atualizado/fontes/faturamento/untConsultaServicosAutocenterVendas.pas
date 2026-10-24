unit untConsultaServicosAutocenterVendas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Math,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit,
  DB, cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxControls, cxGridCustomView, cxGrid, DBCtrls,
  DBMemoFocus, untFuncoesSimples, Uni, BitBtnLockedIncrem,
  UniClientDataSet, cxEditRepositoryItems, DateUtils, strUtils, cxImageComboBox,
  cxSpinEdit, cxTextEdit, dxBar, dxBarExtItems, cxBarEditItem, Gauges,
  cxCheckBox, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, dxCore, frxClass,
  frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog, untLiberacao;

type
  TfrmConsultaServicosAutocenterVendas = class(TfrmPaiConfirma)
    dtsConsul: TDataSource;
    cxStyleRepositorio: TcxStyleRepository;
    cxStyleSelecao: TcxStyle;
    cxStyleGroup: TcxStyle;
    RxLabel5: TLabel;
    cxedtRepository: TcxEditRepository;
    imgcbxTipSer: TcxEditRepositoryImageComboBoxItem;
    imgcbxStaSer: TcxEditRepositoryImageComboBoxItem;
    dxBarManager1: TdxBarManager;
    mnuBarraConfig: TdxBar;
    edtQtdUltNot: TcxBarEditItem;
    edtRefresh: TcxBarEditItem;
    dxBarStatic3: TdxBarStatic;
    dxBarStatic2: TdxBarStatic;
    edtQtdDiasFatu: TdxBarSpinEdit;
    dxBarStatic6: TdxBarStatic;
    dxBarGroup1: TdxBarGroup;
    tmrAtualizar: TTimer;
    dxBarButton1: TdxBarButton;
    dxBarStatic1: TdxBarStatic;
    dxBarControlContainerItem1: TdxBarControlContainerItem;
    btnUpdate: TdxBarButton;
    btnClose: TdxBarButton;
    lblInformacao: TLabel;
    btnExpand: TdxBarButton;
    btnCollapse: TdxBarButton;
    pgbProgresso: TGauge;
    chkPedFat: TcxBarEditItem;
    chkStaFin: TcxBarEditItem;
    pnlServicos: TPanel;
    cxgConsulta: TcxGrid;
    cxgConsultaTable: TcxGridDBTableView;
    cxgConsultaPrisma: TcxGridDBColumn;
    cxgConsultaDtaDoc: TcxGridDBColumn;
    cxgConsultaNumDoc: TcxGridDBColumn;
    cxgConsultaPlaVei: TcxGridDBColumn;
    cxgConsultaDesVei: TcxGridDBColumn;
    cxgConsultaNomCli: TcxGridDBColumn;
    cxgConsultaNumPed: TcxGridDBColumn;
    cxgConsultaDesSer: TcxGridDBColumn;
    cxgConsultaQtdSer: TcxGridDBColumn;
    cxgConsultaTmpSer: TcxGridDBColumn;
    cxgConsultaTipSer: TcxGridDBColumn;
    cxgConsultaStaSer: TcxGridDBColumn;
    cxgConsultaLevel1: TcxGridLevel;
    pnlBotoesSer: TPanel;
    btnMecSer: TBitBtnLocked;
    lblMecSer: TLabel;
    btnTempoPorTipo: TdxBarButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure cxgConsultaTmpSerGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxgConsultaTableKeyPress(Sender: TObject; var Key: Char);
    procedure cxgConsultaTipSerCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure tmrAtualizarTimer(Sender: TObject);
    procedure edtRefreshChange(Sender: TObject);
    procedure imgcbxStaSerPropertiesChange(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure edtQtdDiasFatuButtonClick(Sender: TdxBarSpinEdit; Button: TdxBarSpinEditButton);
    procedure btnExpandClick(Sender: TObject);
    procedure btnMecSerClick(Sender: TObject);
    procedure dtsConsulDataChange(Sender: TObject; Field: TField);
    procedure btnTempoPorTipoClick(Sender: TObject);
  private
    { Private declarations }
    qryOpe,
    qryConsul: TUniQuery;
    cdsConsul: TUniClientDataSet;
    dicNomOpe: TDicionario;
    strStatusFinalizamServico: String;
    objLiberacao : TLiberacao;

    function fSqlConsulta: String;
    function fFormatarHora(strHora: String): String;
    function fConverteCorEscalaDeCinza(cor: TColor): TColor;
    function fCarregarMecanicosServico(strTabMec, strAutInc, strIdeSer: String): String;

    function fGetMecanicos(strCodMec: String): String;
    
    procedure pAfterScroll(DataSet: TDataSet);
    procedure pAfterPost(DataSet: TDataSet);

    procedure pAbreConsulta;
    procedure pCarregarServicosClientDataSet;
    procedure pCarregaTipoServicos;
    procedure pCarregaStatusServicos;
    procedure pAtualizarDocumentos;
    procedure pNotificaCliente(DataSet: TDataSet);
    procedure cxgConsultaSummaryTmpSerGetDisplayText(Sender: TcxDataSummaryItem;
      const AValue: Variant; AIsFooter: Boolean; var AText: string);
    function fSolicitaAvaliacaoTecladoSEAT: Boolean;
    function fTodosServicosFinalizados(strAutInc, strIdeSer: String): Boolean;
  end;

Const
  MAX_SERVICOS = 30;

implementation

uses untFuncoes, untDigMecanicos, untConsultaServicosAutocenterTempoTot,
  untFuncoesAutocenter, untFuncFat, untTypesSistema, untTecladoSEAT,
  untConsultaServicosAutocenterTecSeat;

{$R *.dfm}

function TfrmConsultaServicosAutocenterVendas.fFormatarHora(strHora: String): String;
begin
  strHora := fSegToTempoStr(SecondsBetween(0, StrToDateTimeDef(strHora, 0)));
  strHora := LeftStr(strHora, Length(strHora) - 3);//Tira os Segundos
  Result  := strHora;
end;

function TfrmConsultaServicosAutocenterVendas.fGetMecanicos(strCodMec: String): String;
  Var
    stlMec: TStringList;
    intMec: Integer;
begin
  Result := '';

  If fEmptyStr(strCodMec) Then
    Exit;

  stlMec := TStringList.Create;
  Try
    stlMec.CommaText := strCodMec;

    For intMec := 0 To stlMec.Count -1 Do
    Begin
      qryOpe.Locate('OPE_CODOPE', stlMec[intMec], []);
      stlMec[intMec] := stlMec[intMec] + '-' + qryOpe.FieldByName('OPE_NOMOPE').AsString;
    End;

    Result := AnsiReplaceStr(stlMec.CommaText, ',', ', ');
  Finally
    stlMec.Free;
  End;
end;

procedure TfrmConsultaServicosAutocenterVendas.btnAtualizarClick(Sender: TObject);
begin
  inherited;
  pAtualizarDocumentos;
end;

procedure TfrmConsultaServicosAutocenterVendas.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmConsultaServicosAutocenterVendas.btnExpandClick(Sender: TObject);
begin
  inherited;
  If Sender = btnExpand Then
  Begin
    btnExpand.Visible := ivNever;
    btnCollapse.Visible := ivAlways;
    cxgConsultaTable.ViewData.Expand(True);
  End
  Else
  Begin
    btnExpand.Visible := ivAlways;
    btnCollapse.Visible := ivNever;
    cxgConsultaTable.ViewData.Collapse(True);    
  End;
end;

procedure TfrmConsultaServicosAutocenterVendas.btnMecSerClick(Sender: TObject);
  Var
    qryMec: TUniQuery;
    intRecNo: Integer;

  procedure pAtuMec;
  begin
    cdsConsul.Edit;
    cdsConsul.FieldByName('CODMEC').AsString := frmDigMecanicos.stlMecanicos.CommaText;
    cdsConsul.Post;

    pApagaMecanicosServico( cdsConsul.FieldByName('TABMEC').AsString,
                            cdsConsul.FieldByName('AUTINC').AsString,
                            cdsConsul.FieldByName('IDESER').AsString );

    pGravaMecanicosServico( cdsConsul.FieldByName('TABMEC').AsString,
                            cdsConsul.FieldByName('AUTINC').AsString,
                            cdsConsul.FieldByName('IDESER').AsString,
                            cdsConsul.FieldByName('CODSER').AsString,
                            cdsConsul.FieldByName('VALSER').AsFloat,
                            cdsConsul.FieldByName('CODMEC').AsString,
                            cdsConsul.FieldByName('QTDSER').AsFloat );
  end;
  
begin
  If Not Assigned(dtsConsul.DataSet) Then
   Exit;

  With dtsConsul.DataSet Do
  Begin
    If (IsEmpty) Then
      Exit;

    If (Not fVerificaAcessoSistema('PEALTMECSEFIN')) And      
       (Pos(FieldByName('STASER').AsString, strStatusFinalizamServico) > 0) Then
    Begin
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Permitir alterar Mecânico de Serviço Finalizado!');
      objLiberacao.objMsgLibera.pAddTexto('Acompanhamento de Serviços - Documentos de Venda.');

      objLiberacao.strDirAce := 'PEALTMECSEFIN';
      objLiberacao.strMsgSen := 'Permitir alterar Mecânico de Serviço Finalizado!';
      objLiberacao.blnMosMen := True;
      objLiberacao.strCodOpe := strLoginUsuarioLogado;

      If (Not objLiberacao.fLibera) Then
      Begin
        Exit;
      End;
    End;
  End;

  Try
    pCriarFormularios(TfrmDigMecanicos, frmDigMecanicos);  
    frmDigMecanicos.stlMecanicos.CommaText := cdsConsul.FieldByName('CODMEC').AsString;
    frmDigMecanicos.pnlAltMecGer.Visible := True;
    frmDigMecanicos.chkAltMecGer.Caption := 'Alterar mecânico para todos serviços do documento?';

    If frmDigMecanicos.ShowModal = mrOk Then
    Begin
      qryMec := fCriaQuery;
      Try
        // Se for alterar mecânico de todos serviços
        If frmDigMecanicos.chkAltMecGer.Checked Then
        Begin
          intRecNo := cdsConsul.RecNo;
          Try
            cdsConsul.Filter := 'AUTINC = '+ QuotedStr(cdsConsul.FieldByName('AUTINC').AsString);
            cdsConsul.Filtered := True;
            
            cdsConsul.First;
            While Not cdsConsul.Eof Do
            Begin
              pAtuMec;
              cdsConsul.Next;
            End;
          Finally
            cdsConsul.Filtered := False;
            cdsConsul.Filter := '';

            cdsConsul.RecNo := intRecNo;
            btnExpandClick(btnExpand);
          End;
        End

        // Se for alterar mecânico somente do serviço atual
        Else
          pAtuMec;
      Finally
        FreeAndNil(qryMec);
      End;
    End;
  Finally
    pFreeAndNil(frmDigMecanicos);
  End;
end;

procedure TfrmConsultaServicosAutocenterVendas.btnTempoPorTipoClick(Sender: TObject);
begin
  pCriarFormularios(TfrmConsultaServicosAutocenterTempoTot, frmConsultaServicosAutocenterTempoTot);
  Try
    frmConsultaServicosAutocenterTempoTot.cdsServicos.Data := cdsConsul.Data;
    frmConsultaServicosAutocenterTempoTot.strStatusFinalizamServico := strStatusFinalizamServico; 
    frmConsultaServicosAutocenterTempoTot.ShowModal;
  Finally
    pFreeAndNil(frmConsultaServicosAutocenterTempoTot);
  End;
end;

procedure TfrmConsultaServicosAutocenterVendas.btnUpdateClick(Sender: TObject);
begin
  inherited;

  If btnUpdate.Enabled Then
  Begin
    Try
      btnUpdate.Enabled := False;
      pAtualizarDocumentos;
    Finally
      btnUpdate.Enabled := True;
    End;  
  End;
      
end;

procedure TfrmConsultaServicosAutocenterVendas.cxgConsultaTableKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  Key := UpCase(Key);
end;

function TfrmConsultaServicosAutocenterVendas.fConverteCorEscalaDeCinza(cor: TColor): TColor;
  var
    Grayshade, Red, Green, Blue: Byte;
    PixelColor: Longint;
begin
  PixelColor := ColorToRGB(cor);
  Red        := PixelColor;
  Green      := PixelColor shr 8;
  Blue       := PixelColor shr 16;
  Grayshade  := Round(0.3 * Red + 0.6 * Green + 0.1 * Blue);
  Result     := RGB(Grayshade, Grayshade, Grayshade);
end;

procedure TfrmConsultaServicosAutocenterVendas.cxgConsultaTipSerCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    item : TcxImageComboBoxItem;
    valor: variant;
    corFonte: TColor;
begin
  inherited;
  Try
    valor := Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgConsultaTipSer.Index];
    item := imgcbxTipSer.Properties.FindItemByValue(valor);

    If Assigned(item) Then
    Begin
      If (item.Tag > -1) Then
      Begin
        corFonte := fConverteCorEscalaDeCinza(item.Tag);
        ACanvas.Font.Style  := [fsBold];
        ACanvas.Brush.Color := item.Tag;
        ACanvas.Font.Color  := RGB(not GetRValue(corFonte), not GetGValue(corFonte), not GetBValue(corFonte));
      End;
    End;
  Except

  End;

end;

procedure TfrmConsultaServicosAutocenterVendas.cxgConsultaTmpSerGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  AText := fFormatarHora(AText);
end;

procedure TfrmConsultaServicosAutocenterVendas.cxgConsultaSummaryTmpSerGetDisplayText(Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean; var AText: string);
begin
  inherited;
  AText := fFormatarHora(AText);
end;

procedure TfrmConsultaServicosAutocenterVendas.dtsConsulDataChange(Sender: TObject; Field: TField);
begin
  If (Field <> Nil) And (dtsConsul.DataSet.State = dsEdit) And (Field.FieldName = 'STASER') And (Field.OldValue <> Field.NewValue) Then
  Begin
    If Not fVerificaAcessoSistema('PEALTSTASE') Then
    Begin
      fMensagem('', 'Usuário sem permissão de acesso para alteração do Status do Serviço', ['&O k']);
      dtsConsul.DataSet.Cancel;
      Exit;
    End;

    If Pos(Field.AsString, strStatusFinalizamServico) > 0 Then
    Begin
      If fEmptyStr(dtsConsul.DataSet.FieldByName('CODMEC').AsString) Then
      Begin
        fMensagem('', 'Não é permitido finalizar um serviço sem que tenha um mecânico vinculado!', ['&Ok']);
        dtsConsul.DataSet.Cancel;
        Exit;
      End;

      If Not fPergunta('O Status selecionado irá finalizar o serviço não permitindo alterar o mesmo!' +
                       #13#10 + 'Confirma o Status?') Then
      Begin
        dtsConsul.DataSet.Cancel;
        Exit;
      End;

      If TTecladoSEAT.fUtilizaIntegracaoComTecladoDeSatisfacaoSEAT(oaAutoCenter) Then
      Begin
        If fTodosServicosFinalizados(cdsConsul.FieldByName('AUTINC').AsString, cdsConsul.FieldByName('IDESER').AsString) And
           (Not fSolicitaAvaliacaoTecladoSEAT) Then
        Begin
          dtsConsul.DataSet.Cancel;
          Exit;
        End;
      End;

    End;
  End;
end;

procedure TfrmConsultaServicosAutocenterVendas.edtQtdDiasFatuButtonClick(Sender: TdxBarSpinEdit; Button: TdxBarSpinEditButton);
begin
  inherited;
  Case Button Of
    sbUp   : Sender.Value := Sender.Value + 1;
    sbDown : Sender.Value := Sender.Value - 1;
  End;
end;

procedure TfrmConsultaServicosAutocenterVendas.edtRefreshChange(Sender: TObject);
begin
  inherited;
  tmrAtualizar.Interval := edtRefresh.EditValue * 60 * 1000;
end;

procedure TfrmConsultaServicosAutocenterVendas.FormCreate(Sender: TObject);
begin
  inherited;
  qryOpe := fCriaQuery;
  qryOpe.SQL.Text := 'SELECT * FROM CADOPE';
  qryOpe.Open;

  objLiberacao := TLiberacao.Create;

  qryConsul := fCriaQuery(Self);
  dicNomOpe := TDicionario.Create;
end;

procedure TfrmConsultaServicosAutocenterVendas.pCarregaTipoServicos;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery(Nil);
  Try
    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT TPS_CODIGO, TPS_DESCRI, TPS_CORIDE FROM TIPSER');
    qryGen.Open;

    imgcbxTipSer.Properties.Items.Clear;

    qryGen.First;
    While Not qryGen.Eof Do
    Begin
      imgcbxTipSer.Properties.Items.Add;
      imgcbxTipSer.Properties.Items[qryGen.RecNo -1].Tag         := StrToIntDef(qryGen.FieldByName('TPS_CORIDE').AsString, -1);
      imgcbxTipSer.Properties.Items[qryGen.RecNo -1].Value       := qryGen.FieldByName('TPS_CODIGO').AsString;
      imgcbxTipSer.Properties.Items[qryGen.RecNo -1].Description := qryGen.FieldByName('TPS_DESCRI').AsString;

      qryGen.Next;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmConsultaServicosAutocenterVendas.tmrAtualizarTimer(Sender: TObject);
begin
  inherited;
  pAtualizarDocumentos;
end;

procedure TfrmConsultaServicosAutocenterVendas.pAtualizarDocumentos;
begin
  pCarregaTipoServicos;
  pCarregaStatusServicos;
  pAbreConsulta;
end;

procedure TfrmConsultaServicosAutocenterVendas.pCarregaStatusServicos;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery(Nil);
  Try
    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT STS_CODIGO, STS_DESCRI, STS_FINALI FROM STASER');
    qryGen.Open;

    strStatusFinalizamServico := '';
    imgcbxStaSer.Properties.Items.Clear;

    qryGen.First;
    While Not qryGen.Eof Do
    Begin
      imgcbxStaSer.Properties.Items.Add;
      imgcbxStaSer.Properties.Items[qryGen.RecNo -1].Tag         := StrToIntDef(qryGen.FieldByName('STS_CODIGO').AsString, -1);
      imgcbxStaSer.Properties.Items[qryGen.RecNo -1].Value       := qryGen.FieldByName('STS_CODIGO').AsString;
      imgcbxStaSer.Properties.Items[qryGen.RecNo -1].Description := qryGen.FieldByName('STS_DESCRI').AsString;

      If qryGen.FieldByName('STS_FINALI').AsString = 'S' Then
        strStatusFinalizamServico := strStatusFinalizamServico + qryGen.FieldByName('STS_CODIGO').AsString + '_';

      qryGen.Next;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmConsultaServicosAutocenterVendas.FormDestroy(Sender: TObject);
begin
  inherited;
  If Assigned(cdsConsul) Then
    FreeAndNil(cdsConsul);

  If Assigned(dicNomOpe) Then
    FreeAndNil(dicNomOpe);

  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);

  FreeAndNil(qryOpe);
end;

procedure TfrmConsultaServicosAutocenterVendas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F5: btnUpdate.Click;
    VK_F6: btnMecSer.Click;
  End;
end;

Procedure TfrmConsultaServicosAutocenterVendas.pAbreConsulta;
Begin
  lblInformacao.Caption := 'AGUARDE, ATUALIZANDO DOCUMENTOS...';
  Try
    Application.ProcessMessages;

    With qryConsul Do
    Begin
      Close;
      SQL.text := fSqlConsulta;

      ParamByName('CODEMP').AsString  := VS_strCodEmp;
      ParamByName('CLAVEN').AsString  := VS_strClaVen;      
      ParamByName('DIAEXI').AsDate    := IncDay(VS_Date, - Floor(edtQtdDiasFatu.Value));

      Open;
    End;

    If Not Assigned(cdsConsul) Then
    Begin
      cdsConsul := fCriaClientDatset(qryConsul, True);
      TDateTimeField(cdsConsul.FieldByName('TMPSER')).Alignment := taCenter;
      TFloatField(cdsConsul.FieldByName('QTDSER')).DisplayFormat := '#,##0.00';
    End;

    cdsConsul.AfterScroll := nil;
    cdsConsul.AfterPost   := nil;

    pCarregarServicosClientDataSet;

    cdsConsul.AfterPost   := pAfterPost;
    cdsConsul.AfterScroll := pAfterScroll;

    dtsConsul.DataSet := cdsConsul;

    cxgConsultaTable.ApplyBestFit;

    btnExpandClick(btnExpand);

    pAfterScroll(cdsConsul);
  Finally
    lblInformacao.Caption := '';
  End;
end;

procedure TfrmConsultaServicosAutocenterVendas.pAfterPost(DataSet: TDataSet);
  var
    strIdeSer,
    strStaSer,
    strSeqGer,
    strTabSer: String;
begin
  strIdeSer := DataSet.FieldByName('IDESER').AsString;
  strStaSer := DataSet.FieldByName('STASER').AsString;
  strSeqGer := DataSet.FieldByName('AUTINC').AsString;
  strTabSer := DataSet.FieldByName('TABSER').AsString;

  If strIdeSer = '00' Then
    Exit;

  Try
    fStartTransaction;
    fExecutaSQL(' UPDATE ' + strTabSer +
                ' SET GER_STAS' + strIdeSer + ' = ' + QuotedStr(strStaSer) +
                ' WHERE GER_SEQGER = ' + QuotedStr(strSeqGer));
    fCommit;

    pNotificaCliente(DataSet);
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[pAfterPost]');
    End;
  End;
end;

procedure TfrmConsultaServicosAutocenterVendas.pNotificaCliente(DataSet: TDataSet);
begin
  fDisparaWhatsappAutomatico(DataSet.FieldByName('GER_NUMDOC').AsString,
                             'SE',
                             DataSet.FieldByName('GER_ESPDOC').AsString,
                             '',
                             '',
                             DataSet.FieldByName('GER_CODEMP').AsString,
                             DataSet.FieldByName('GER_CODCLI').AsString,
                             '',
                             True,
                             '',
                             nil,
                             '',
                             '',
                             '',
                             Self.UnitName,
                             '',
                             '',
                             '',
                             '',
                             DataSet.FieldByName('CODSER').AsString,
                             DataSet.FieldByName('STASER').AsString);
end;

procedure TfrmConsultaServicosAutocenterVendas.pAfterScroll(DataSet: TDataSet);
  Var
    strMecSer: String;
begin
  With DataSet Do
  Begin
    cxgConsultaStaSer.Options.Editing := (Pos(FieldByName('STASER').AsString, strStatusFinalizamServico) <= 0);

    strMecSer := fGetMecanicos(FieldByName('CODMEC').AsString);

    lblMecSer.Visible := Not fEmptyStr(strMecSer);

    If Pos(',', strMecSer) > 0 Then
      lblMecSer.Caption := 'Mecânicos: '
    Else
      lblMecSer.Caption := 'Mecânico: ';

    lblMecSer.Caption := lblMecSer.Caption + strMecSer;
  End;
end;

procedure TfrmConsultaServicosAutocenterVendas.pCarregarServicosClientDataSet;
  Var
    intSer: Integer;
    strDocAnt: String;
    prcScroll: TprcScroll;
begin
  Try
    pDisableControls(cdsConsul, prcScroll);

    strDocAnt := cdsConsul.FieldByName('NUMDOC').AsString;

    cdsConsul.EmptyDataSet;
    qryConsul.First;

    pgbProgresso.Visible  := True;
    pgbProgresso.MaxValue := qryConsul.RecordCount;

    While Not qryConsul.Eof Do
    Begin
      pgbProgresso.Progress := qryConsul.RecNo;
      Application.ProcessMessages;

      With cdsConsul Do
      Begin
        For intSer := 1 To MAX_SERVICOS Do
        Begin
          If Not fEmptyStr(qryConsul.FieldByName('CODS' + fStrZero(intSer, 2)).AsString) Then
          Begin

            If (Not chkStaFin.EditValue) And
               (fPos(qryConsul.FieldByName('STAS' + fStrZero(intSer, 2)).AsString, strStatusFinalizamServico)) Then
            Begin
              Continue;
            End;

            pCopiaRegistroDataSet(qryConsul, cdsConsul);
            Edit;
            FieldByName('IDESER').AsString := fStrZero(intSer, 2);

            FieldByName('PRISMA').AsString := FieldByName('PRIS' + fStrZero(intSer, 2)).AsString;
            FieldByName('CODSER').AsString := FieldByName('CODS' + fStrZero(intSer, 2)).AsString;
            FieldByName('DESSER').AsString := FieldByName('DESS' + fStrZero(intSer, 2)).AsString;
            FieldByName('TIPSER').AsString := FieldByName('TIPS' + fStrZero(intSer, 2)).AsString;
            FieldByName('STASER').AsString := FieldByName('STAS' + fStrZero(intSer, 2)).AsString;
            FieldByName('QTDSER').AsFloat  := FieldByName('QTDS' + fStrZero(intSer, 2)).AsFloat;
            FieldByName('VALSER').AsFloat  := FieldByName('VALS' + fStrZero(intSer, 2)).AsFloat;
            FieldByName('TMPSER').AsFloat  := FieldByName('TMPS' + fStrZero(intSer, 2)).AsFloat *
                                              FieldByName('QTDS' + fStrZero(intSer, 2)).AsFloat;
                                                                                            
            FieldByName('CODMEC').AsString := fCarregarMecanicosServico(FieldByName('TABMEC').AsString,
                                                                        FieldByName('AUTINC').AsString, fStrZero(intSer, 2));
            Post;
          End;
        End;
      End;

      qryConsul.Next;
    End;

  Finally
    pgbProgresso.Visible := False;
    pEnableControls(cdsConsul, prcScroll);
    cdsConsul.Locate('NUMDOC', strDocAnt, []);
  End;

end;

procedure TfrmConsultaServicosAutocenterVendas.FormShow(Sender: TObject);
  Var
    ASummaryItem: TcxGridDBTableSummaryItem;
begin
  inherited;
  cxgConsultaQtdSer.Visible := fCfgSis('QTDSER', varBoolean);

  cxgConsultaTable.DataController.Groups.ClearGrouping;
  cxgConsultaNumDoc.GroupBy(0);
  cxgConsultaNumDoc.Visible := False;

  ASummaryItem := cxgConsultaTable.DataController.Summary.GroupSummaryItems[0].Add as TcxGridDBTableSummaryItem;
  ASummaryItem.Column   := cxgConsultaQtdSer;
  ASummaryItem.Format   := '0.00;-0.00';
  ASummaryItem.Kind     := skSum;
  ASummaryItem.Position := spFooter;

  ASummaryItem := cxgConsultaTable.DataController.Summary.GroupSummaryItems[0].Add as TcxGridDBTableSummaryItem;
  ASummaryItem.Column   := cxgConsultaTmpSer;
  ASummaryItem.Format   := '';
  ASummaryItem.Kind     := skSum;
  ASummaryItem.Position := spFooter;
  ASummaryItem.OnGetText := cxgConsultaSummaryTmpSerGetDisplayText;

  tmrAtualizar.Interval := edtRefresh.EditValue * 60 * 1000;
  pAtualizarDocumentos;
  tmrAtualizar.Enabled := True;
end;

function TfrmConsultaServicosAutocenterVendas.fSqlConsulta: String;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  "MOVGER" AS TABGER, ';
  strSQL := strSQL + '  "SERMOV" AS TABSER, ';
  strSQL := strSQL + '  "MECGER" AS TABMEC, ';
  strSQL := strSQL + '  MOVGER.AUTOINCREM AS AUTINC, ';

  strSQL := strSQL + '  GER_NUMDOC, GER_ESPDOC, GER_CODEMP, GER_CODCLI, ';

  strSQL := strSQL + '  CONCAT(DATE_FORMAT(GER_DTAENT,"%d/%m/%Y"), " ", DATE_FORMAT(GER_HORENT,"%H:%i")) AS DTADOC, ';

  strSQL := strSQL + '  CONCAT(GER_NUMDOC, "-", GER_ESPDOC, "-", GER_CODEMP) AS NUMDOC, ';
  strSQL := strSQL + '  GER_CODCLI AS CODCLI, ';  
  strSQL := strSQL + '  CONCAT(CLI_NOMCLI, " (", CLI_CODCLI, ") ") AS NOMCLI, ';

  strSQL := strSQL + '  CONCAT(LEFT(AUX_PLAVEI, 3), "-", RIGHT(AUX_PLAVEI, 4)) AS PLAVEI, ';

  strSQL := strSQL + '  CONCAT(IFNULL(MAR_DESMAR, ""), " ", ';
  strSQL := strSQL + '         IFNULL(MOD_DESMOD, ""), " ", ';
  strSQL := strSQL + '         IFNULL(VEI_ANOVEI, ""), " ", ';
  strSQL := strSQL + '         IFNULL(COR_DESCOR, "")) AS DESVEI, ';

  strSQL := strSQL + '  "00" AS IDESER, ';

  strSQL := strSQL + '  LPAD("", 05, " ") AS CODSER, ';
  strSQL := strSQL + '  GER_CODS01 AS CODS01, ';
  strSQL := strSQL + '  GER_CODS02 AS CODS02, ';
  strSQL := strSQL + '  GER_CODS03 AS CODS03, ';
  strSQL := strSQL + '  GER_CODS04 AS CODS04, ';
  strSQL := strSQL + '  GER_CODS05 AS CODS05, ';
  strSQL := strSQL + '  GER_CODS06 AS CODS06, ';
  strSQL := strSQL + '  GER_CODS07 AS CODS07, ';
  strSQL := strSQL + '  GER_CODS08 AS CODS08, ';
  strSQL := strSQL + '  GER_CODS09 AS CODS09, ';
  strSQL := strSQL + '  GER_CODS10 AS CODS10, ';
  strSQL := strSQL + '  GER_CODS11 AS CODS11, ';
  strSQL := strSQL + '  GER_CODS12 AS CODS12, ';
  strSQL := strSQL + '  GER_CODS13 AS CODS13, ';
  strSQL := strSQL + '  GER_CODS14 AS CODS14, ';
  strSQL := strSQL + '  GER_CODS15 AS CODS15, ';
  strSQL := strSQL + '  GER_CODS16 AS CODS16, ';
  strSQL := strSQL + '  GER_CODS17 AS CODS17, ';
  strSQL := strSQL + '  GER_CODS18 AS CODS18, ';
  strSQL := strSQL + '  GER_CODS19 AS CODS19, ';
  strSQL := strSQL + '  GER_CODS20 AS CODS20, ';
  strSQL := strSQL + '  GER_CODS21 AS CODS21, ';
  strSQL := strSQL + '  GER_CODS22 AS CODS22, ';
  strSQL := strSQL + '  GER_CODS23 AS CODS23, ';
  strSQL := strSQL + '  GER_CODS24 AS CODS24, ';
  strSQL := strSQL + '  GER_CODS25 AS CODS25, ';
  strSQL := strSQL + '  GER_CODS26 AS CODS26, ';
  strSQL := strSQL + '  GER_CODS27 AS CODS27, ';
  strSQL := strSQL + '  GER_CODS28 AS CODS28, ';
  strSQL := strSQL + '  GER_CODS29 AS CODS29, ';
  strSQL := strSQL + '  GER_CODS30 AS CODS30, ';

  strSQL := strSQL + '  LPAD("", 80, " ") AS DESSER, ';
  strSQL := strSQL + '  GER_DESS01 AS DESS01, ';
  strSQL := strSQL + '  GER_DESS02 AS DESS02, ';
  strSQL := strSQL + '  GER_DESS03 AS DESS03, ';
  strSQL := strSQL + '  GER_DESS04 AS DESS04, ';
  strSQL := strSQL + '  GER_DESS05 AS DESS05, ';
  strSQL := strSQL + '  GER_DESS06 AS DESS06, ';
  strSQL := strSQL + '  GER_DESS07 AS DESS07, ';
  strSQL := strSQL + '  GER_DESS08 AS DESS08, ';
  strSQL := strSQL + '  GER_DESS09 AS DESS09, ';
  strSQL := strSQL + '  GER_DESS10 AS DESS10, ';
  strSQL := strSQL + '  GER_DESS11 AS DESS11, ';
  strSQL := strSQL + '  GER_DESS12 AS DESS12, ';
  strSQL := strSQL + '  GER_DESS13 AS DESS13, ';
  strSQL := strSQL + '  GER_DESS14 AS DESS14, ';
  strSQL := strSQL + '  GER_DESS15 AS DESS15, ';
  strSQL := strSQL + '  GER_DESS16 AS DESS16, ';
  strSQL := strSQL + '  GER_DESS17 AS DESS17, ';
  strSQL := strSQL + '  GER_DESS18 AS DESS18, ';
  strSQL := strSQL + '  GER_DESS19 AS DESS19, ';
  strSQL := strSQL + '  GER_DESS20 AS DESS20, ';
  strSQL := strSQL + '  GER_DESS21 AS DESS21, ';
  strSQL := strSQL + '  GER_DESS22 AS DESS22, ';
  strSQL := strSQL + '  GER_DESS23 AS DESS23, ';
  strSQL := strSQL + '  GER_DESS24 AS DESS24, ';
  strSQL := strSQL + '  GER_DESS25 AS DESS25, ';
  strSQL := strSQL + '  GER_DESS26 AS DESS26, ';
  strSQL := strSQL + '  GER_DESS27 AS DESS27, ';
  strSQL := strSQL + '  GER_DESS28 AS DESS28, ';
  strSQL := strSQL + '  GER_DESS29 AS DESS29, ';
  strSQL := strSQL + '  GER_DESS30 AS DESS30, ';

  strSQL := strSQL + '  LPAD("", 04, " ") AS STASER, ';
  strSQL := strSQL + '  GER_STAS01 AS STAS01, ';
  strSQL := strSQL + '  GER_STAS02 AS STAS02, ';
  strSQL := strSQL + '  GER_STAS03 AS STAS03, ';
  strSQL := strSQL + '  GER_STAS04 AS STAS04, ';
  strSQL := strSQL + '  GER_STAS05 AS STAS05, ';
  strSQL := strSQL + '  GER_STAS06 AS STAS06, ';
  strSQL := strSQL + '  GER_STAS07 AS STAS07, ';
  strSQL := strSQL + '  GER_STAS08 AS STAS08, ';
  strSQL := strSQL + '  GER_STAS09 AS STAS09, ';
  strSQL := strSQL + '  GER_STAS10 AS STAS10, ';
  strSQL := strSQL + '  GER_STAS11 AS STAS11, ';
  strSQL := strSQL + '  GER_STAS12 AS STAS12, ';
  strSQL := strSQL + '  GER_STAS13 AS STAS13, ';
  strSQL := strSQL + '  GER_STAS14 AS STAS14, ';
  strSQL := strSQL + '  GER_STAS15 AS STAS15, ';
  strSQL := strSQL + '  GER_STAS16 AS STAS16, ';
  strSQL := strSQL + '  GER_STAS17 AS STAS17, ';
  strSQL := strSQL + '  GER_STAS18 AS STAS18, ';
  strSQL := strSQL + '  GER_STAS19 AS STAS19, ';
  strSQL := strSQL + '  GER_STAS20 AS STAS20, ';
  strSQL := strSQL + '  GER_STAS21 AS STAS21, ';
  strSQL := strSQL + '  GER_STAS22 AS STAS22, ';
  strSQL := strSQL + '  GER_STAS23 AS STAS23, ';
  strSQL := strSQL + '  GER_STAS24 AS STAS24, ';
  strSQL := strSQL + '  GER_STAS25 AS STAS25, ';
  strSQL := strSQL + '  GER_STAS26 AS STAS26, ';
  strSQL := strSQL + '  GER_STAS27 AS STAS27, ';
  strSQL := strSQL + '  GER_STAS28 AS STAS28, ';
  strSQL := strSQL + '  GER_STAS29 AS STAS29, ';
  strSQL := strSQL + '  GER_STAS30 AS STAS30, ';

  strSQL := strSQL + '  LPAD("", 04, " ") AS PRISMA, ';
  strSQL := strSQL + '  GER_PRIS01 AS PRIS01, ';
  strSQL := strSQL + '  GER_PRIS02 AS PRIS02, ';
  strSQL := strSQL + '  GER_PRIS03 AS PRIS03, ';
  strSQL := strSQL + '  GER_PRIS04 AS PRIS04, ';
  strSQL := strSQL + '  GER_PRIS05 AS PRIS05, ';
  strSQL := strSQL + '  GER_PRIS06 AS PRIS06, ';
  strSQL := strSQL + '  GER_PRIS07 AS PRIS07, ';
  strSQL := strSQL + '  GER_PRIS08 AS PRIS08, ';
  strSQL := strSQL + '  GER_PRIS09 AS PRIS09, ';
  strSQL := strSQL + '  GER_PRIS10 AS PRIS10, ';
  strSQL := strSQL + '  GER_PRIS11 AS PRIS11, ';
  strSQL := strSQL + '  GER_PRIS12 AS PRIS12, ';
  strSQL := strSQL + '  GER_PRIS13 AS PRIS13, ';
  strSQL := strSQL + '  GER_PRIS14 AS PRIS14, ';
  strSQL := strSQL + '  GER_PRIS15 AS PRIS15, ';
  strSQL := strSQL + '  GER_PRIS16 AS PRIS16, ';
  strSQL := strSQL + '  GER_PRIS17 AS PRIS17, ';
  strSQL := strSQL + '  GER_PRIS18 AS PRIS18, ';
  strSQL := strSQL + '  GER_PRIS19 AS PRIS19, ';
  strSQL := strSQL + '  GER_PRIS20 AS PRIS20, ';
  strSQL := strSQL + '  GER_PRIS21 AS PRIS21, ';
  strSQL := strSQL + '  GER_PRIS22 AS PRIS22, ';
  strSQL := strSQL + '  GER_PRIS23 AS PRIS23, ';
  strSQL := strSQL + '  GER_PRIS24 AS PRIS24, ';
  strSQL := strSQL + '  GER_PRIS25 AS PRIS25, ';
  strSQL := strSQL + '  GER_PRIS26 AS PRIS26, ';
  strSQL := strSQL + '  GER_PRIS27 AS PRIS27, ';
  strSQL := strSQL + '  GER_PRIS28 AS PRIS28, ';
  strSQL := strSQL + '  GER_PRIS29 AS PRIS29, ';
  strSQL := strSQL + '  GER_PRIS30 AS PRIS30, ';

  strSQL := strSQL + '  LPAD("", 04, " ") AS TIPSER, ';
  strSQL := strSQL + '  S1.SER_TIPSER  AS TIPS01, ';
  strSQL := strSQL + '  S2.SER_TIPSER  AS TIPS02, ';
  strSQL := strSQL + '  S3.SER_TIPSER  AS TIPS03, ';
  strSQL := strSQL + '  S4.SER_TIPSER  AS TIPS04, ';
  strSQL := strSQL + '  S5.SER_TIPSER  AS TIPS05, ';
  strSQL := strSQL + '  S6.SER_TIPSER  AS TIPS06, ';
  strSQL := strSQL + '  S7.SER_TIPSER  AS TIPS07, ';
  strSQL := strSQL + '  S8.SER_TIPSER  AS TIPS08, ';
  strSQL := strSQL + '  S9.SER_TIPSER  AS TIPS09, ';
  strSQL := strSQL + '  S10.SER_TIPSER AS TIPS10, ';
  strSQL := strSQL + '  S11.SER_TIPSER AS TIPS11, ';
  strSQL := strSQL + '  S12.SER_TIPSER AS TIPS12, ';
  strSQL := strSQL + '  S13.SER_TIPSER AS TIPS13, ';
  strSQL := strSQL + '  S14.SER_TIPSER AS TIPS14, ';
  strSQL := strSQL + '  S15.SER_TIPSER AS TIPS15, ';
  strSQL := strSQL + '  S16.SER_TIPSER AS TIPS16, ';
  strSQL := strSQL + '  S17.SER_TIPSER AS TIPS17, ';
  strSQL := strSQL + '  S18.SER_TIPSER AS TIPS18, ';
  strSQL := strSQL + '  S19.SER_TIPSER AS TIPS19, ';
  strSQL := strSQL + '  S20.SER_TIPSER AS TIPS20, ';
  strSQL := strSQL + '  S21.SER_TIPSER AS TIPS21, ';
  strSQL := strSQL + '  S22.SER_TIPSER AS TIPS22, ';
  strSQL := strSQL + '  S23.SER_TIPSER AS TIPS23, ';
  strSQL := strSQL + '  S24.SER_TIPSER AS TIPS24, ';
  strSQL := strSQL + '  S25.SER_TIPSER AS TIPS25, ';
  strSQL := strSQL + '  S26.SER_TIPSER AS TIPS26, ';
  strSQL := strSQL + '  S27.SER_TIPSER AS TIPS27, ';
  strSQL := strSQL + '  S28.SER_TIPSER AS TIPS28, ';
  strSQL := strSQL + '  S29.SER_TIPSER AS TIPS29, ';
  strSQL := strSQL + '  S30.SER_TIPSER AS TIPS30, ';

  strSQL := strSQL + '  0.0000     AS QTDSER, ';
  strSQL := strSQL + '  GER_QTDS01 AS QTDS01, ';
  strSQL := strSQL + '  GER_QTDS02 AS QTDS02, ';
  strSQL := strSQL + '  GER_QTDS03 AS QTDS03, ';
  strSQL := strSQL + '  GER_QTDS04 AS QTDS04, ';
  strSQL := strSQL + '  GER_QTDS05 AS QTDS05, ';
  strSQL := strSQL + '  GER_QTDS06 AS QTDS06, ';
  strSQL := strSQL + '  GER_QTDS07 AS QTDS07, ';
  strSQL := strSQL + '  GER_QTDS08 AS QTDS08, ';
  strSQL := strSQL + '  GER_QTDS09 AS QTDS09, ';
  strSQL := strSQL + '  GER_QTDS10 AS QTDS10, ';
  strSQL := strSQL + '  GER_QTDS11 AS QTDS11, ';
  strSQL := strSQL + '  GER_QTDS12 AS QTDS12, ';
  strSQL := strSQL + '  GER_QTDS13 AS QTDS13, ';
  strSQL := strSQL + '  GER_QTDS14 AS QTDS14, ';
  strSQL := strSQL + '  GER_QTDS15 AS QTDS15, ';
  strSQL := strSQL + '  GER_QTDS16 AS QTDS16, ';
  strSQL := strSQL + '  GER_QTDS17 AS QTDS17, ';
  strSQL := strSQL + '  GER_QTDS18 AS QTDS18, ';
  strSQL := strSQL + '  GER_QTDS19 AS QTDS19, ';
  strSQL := strSQL + '  GER_QTDS20 AS QTDS20, ';
  strSQL := strSQL + '  GER_QTDS21 AS QTDS21, ';
  strSQL := strSQL + '  GER_QTDS22 AS QTDS22, ';
  strSQL := strSQL + '  GER_QTDS23 AS QTDS23, ';
  strSQL := strSQL + '  GER_QTDS24 AS QTDS24, ';
  strSQL := strSQL + '  GER_QTDS25 AS QTDS25, ';
  strSQL := strSQL + '  GER_QTDS26 AS QTDS26, ';
  strSQL := strSQL + '  GER_QTDS27 AS QTDS27, ';
  strSQL := strSQL + '  GER_QTDS28 AS QTDS28, ';
  strSQL := strSQL + '  GER_QTDS29 AS QTDS29, ';
  strSQL := strSQL + '  GER_QTDS30 AS QTDS30, ';

  strSQL := strSQL + '  0.0000     AS VALSER, ';
  strSQL := strSQL + '  GER_VALS01 AS VALS01, ';
  strSQL := strSQL + '  GER_VALS02 AS VALS02, ';
  strSQL := strSQL + '  GER_VALS03 AS VALS03, ';
  strSQL := strSQL + '  GER_VALS04 AS VALS04, ';
  strSQL := strSQL + '  GER_VALS05 AS VALS05, ';
  strSQL := strSQL + '  GER_VALS06 AS VALS06, ';
  strSQL := strSQL + '  GER_VALS07 AS VALS07, ';
  strSQL := strSQL + '  GER_VALS08 AS VALS08, ';
  strSQL := strSQL + '  GER_VALS09 AS VALS09, ';
  strSQL := strSQL + '  GER_VALS10 AS VALS10, ';
  strSQL := strSQL + '  GER_VALS11 AS VALS11, ';
  strSQL := strSQL + '  GER_VALS12 AS VALS12, ';
  strSQL := strSQL + '  GER_VALS13 AS VALS13, ';
  strSQL := strSQL + '  GER_VALS14 AS VALS14, ';
  strSQL := strSQL + '  GER_VALS15 AS VALS15, ';
  strSQL := strSQL + '  GER_VALS16 AS VALS16, ';
  strSQL := strSQL + '  GER_VALS17 AS VALS17, ';
  strSQL := strSQL + '  GER_VALS18 AS VALS18, ';
  strSQL := strSQL + '  GER_VALS19 AS VALS19, ';
  strSQL := strSQL + '  GER_VALS20 AS VALS20, ';
  strSQL := strSQL + '  GER_VALS21 AS VALS21, ';
  strSQL := strSQL + '  GER_VALS22 AS VALS22, ';
  strSQL := strSQL + '  GER_VALS23 AS VALS23, ';
  strSQL := strSQL + '  GER_VALS24 AS VALS24, ';
  strSQL := strSQL + '  GER_VALS25 AS VALS25, ';
  strSQL := strSQL + '  GER_VALS26 AS VALS26, ';
  strSQL := strSQL + '  GER_VALS27 AS VALS27, ';
  strSQL := strSQL + '  GER_VALS28 AS VALS28, ';
  strSQL := strSQL + '  GER_VALS29 AS VALS29, ';
  strSQL := strSQL + '  GER_VALS30 AS VALS30, ';

  strSQL := strSQL + '  CURRENT_TIME() AS TMPSER, ';
  strSQL := strSQL + '  S1.SER_TMPMED  AS TMPS01, ';
  strSQL := strSQL + '  S2.SER_TMPMED  AS TMPS02, ';
  strSQL := strSQL + '  S3.SER_TMPMED  AS TMPS03, ';
  strSQL := strSQL + '  S4.SER_TMPMED  AS TMPS04, ';
  strSQL := strSQL + '  S5.SER_TMPMED  AS TMPS05, ';
  strSQL := strSQL + '  S6.SER_TMPMED  AS TMPS06, ';
  strSQL := strSQL + '  S7.SER_TMPMED  AS TMPS07, ';
  strSQL := strSQL + '  S8.SER_TMPMED  AS TMPS08, ';
  strSQL := strSQL + '  S9.SER_TMPMED  AS TMPS09, ';
  strSQL := strSQL + '  S10.SER_TMPMED AS TMPS10, ';
  strSQL := strSQL + '  S11.SER_TMPMED AS TMPS11, ';
  strSQL := strSQL + '  S12.SER_TMPMED AS TMPS12, ';
  strSQL := strSQL + '  S13.SER_TMPMED AS TMPS13, ';
  strSQL := strSQL + '  S14.SER_TMPMED AS TMPS14, ';
  strSQL := strSQL + '  S15.SER_TMPMED AS TMPS15, ';
  strSQL := strSQL + '  S16.SER_TMPMED AS TMPS16, ';
  strSQL := strSQL + '  S17.SER_TMPMED AS TMPS17, ';
  strSQL := strSQL + '  S18.SER_TMPMED AS TMPS18, ';
  strSQL := strSQL + '  S19.SER_TMPMED AS TMPS19, ';
  strSQL := strSQL + '  S20.SER_TMPMED AS TMPS20, ';
  strSQL := strSQL + '  S21.SER_TMPMED AS TMPS21, ';
  strSQL := strSQL + '  S22.SER_TMPMED AS TMPS22, ';
  strSQL := strSQL + '  S23.SER_TMPMED AS TMPS23, ';
  strSQL := strSQL + '  S24.SER_TMPMED AS TMPS24, ';
  strSQL := strSQL + '  S25.SER_TMPMED AS TMPS25, ';
  strSQL := strSQL + '  S26.SER_TMPMED AS TMPS26, ';
  strSQL := strSQL + '  S27.SER_TMPMED AS TMPS27, ';
  strSQL := strSQL + '  S28.SER_TMPMED AS TMPS28, ';
  strSQL := strSQL + '  S29.SER_TMPMED AS TMPS29, ';
  strSQL := strSQL + '  S30.SER_TMPMED AS TMPS30, ';

  strSQL := strSQL + '  LPAD("", 255, " ") AS CODMEC, ';
  strSQL := strSQL + '  CAST((SELECT GROUP_CONCAT(DISTINCT CONCAT(FDO_NUMDOC, "-", FDO_ESPDOC, "-", FDO_CODEMP)) ';
  strSQL := strSQL + '        FROM FATDOR WHERE FDO_NUMFAT = GER_NUMDOC AND FDO_TIPFAT = GER_ESPDOC ';
  strSQL := strSQL + '                      AND FDO_EMPFAT = GER_CODEMP) AS CHAR(100)) AS NUMPED ';

  strSQL := strSQL + 'FROM     ';
  strSQL := strSQL + '  MOVGER ';
  strSQL := strSQL + '  INNER JOIN SERMOV ON SERMOV.GER_SEQGER = MOVGER.AUTOINCREM ';
  strSQL := strSQL + '  INNER JOIN AUXMOV ON AUXMOV.AUX_SEQGER = MOVGER.AUTOINCREM ';
  strSQL := strSQL + '  LEFT JOIN CADVEI ON VEI_PLAVEI = AUX_PLAVEI ';
  strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = GER_CODCLI ';

  strSQL := strSQL + '  LEFT JOIN CORVEI ON VEI_CODCOR = COR_CODCOR ';
  strSQL := strSQL + '  LEFT JOIN MARVEI ON VEI_CODMAR = MAR_CODMAR ';
  strSQL := strSQL + '  LEFT JOIN MODVEI ON VEI_CODMOD = MOD_CODMOD ';

  strSQL := strSQL + '  LEFT JOIN CADSER S1  ON S1.SER_CODSER  = GER_CODS01 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S2  ON S2.SER_CODSER  = GER_CODS02 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S3  ON S3.SER_CODSER  = GER_CODS03 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S4  ON S4.SER_CODSER  = GER_CODS04 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S5  ON S5.SER_CODSER  = GER_CODS05 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S6  ON S6.SER_CODSER  = GER_CODS06 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S7  ON S7.SER_CODSER  = GER_CODS07 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S8  ON S8.SER_CODSER  = GER_CODS08 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S9  ON S9.SER_CODSER  = GER_CODS09 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S10 ON S10.SER_CODSER = GER_CODS10 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S11 ON S11.SER_CODSER = GER_CODS11 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S12 ON S12.SER_CODSER = GER_CODS12 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S13 ON S13.SER_CODSER = GER_CODS13 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S14 ON S14.SER_CODSER = GER_CODS14 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S15 ON S15.SER_CODSER = GER_CODS15 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S16 ON S16.SER_CODSER = GER_CODS16 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S17 ON S17.SER_CODSER = GER_CODS17 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S18 ON S18.SER_CODSER = GER_CODS18 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S19 ON S19.SER_CODSER = GER_CODS19 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S20 ON S20.SER_CODSER = GER_CODS20 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S21 ON S21.SER_CODSER = GER_CODS21 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S22 ON S22.SER_CODSER = GER_CODS22 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S23 ON S23.SER_CODSER = GER_CODS23 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S24 ON S24.SER_CODSER = GER_CODS24 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S25 ON S25.SER_CODSER = GER_CODS25 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S26 ON S26.SER_CODSER = GER_CODS26 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S27 ON S27.SER_CODSER = GER_CODS27 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S28 ON S28.SER_CODSER = GER_CODS28 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S29 ON S29.SER_CODSER = GER_CODS29 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S30 ON S30.SER_CODSER = GER_CODS30 ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  GER_CODEMP =  :CODEMP AND ';
  strSQL := strSQL + '  GER_DTAENT >= :DIAEXI AND ';
  strSQL := strSQL + '  GER_TIP_FC =  "C"     AND ';
  strSQL := strSQL + '  GER_TOTSER > 0.00     AND ';
  strSQL := strSQL + '  LOCATE(GER_CLAFIS, :CLAVEN) > 0 ';

  Result := strSQL;
End;

function TfrmConsultaServicosAutocenterVendas.fTodosServicosFinalizados(strAutInc, strIdeSer: String): Boolean;
  Var
    intSer: Integer;
    strCam: String;
    qrySer: TUniQuery;
begin
  qrySer := fCriaQuery;

  Try
    Result := True;

    strCam := '';
    For intSer := 1 To MAX_SERVICOS Do
      strCam := strCam + 'GER_STAS' + fStrZero(intSer, 2) + ',';

    Delete(strCam, Length(strCam), 1);

    qrySer.SQL.Add('SELECT '+ strCam);
    qrySer.SQL.Add('FROM SERMOV');
    qrySer.SQL.Add('WHERE GER_SEQGER = :SEQGER');

    qrySer.ParamByName('SEQGER').AsString := strAutInc;
    qrySer.Open;

    For intSer := 0 To qrySer.FieldCount -1 Do
    Begin
      If SameStr(qrySer.Fields[intSer].FieldName, 'GER_STAS' + strIdeSer) Then
        Continue;

      If qrySer.Fields[intSer].IsNull Then
        Break;

      If Pos(qrySer.Fields[intSer].AsString, strStatusFinalizamServico) <= 0 Then
        Exit(False);
    End;

  Finally
    FreeAndNil(qrySer);
  End;
end;

function TfrmConsultaServicosAutocenterVendas.fSolicitaAvaliacaoTecladoSEAT: Boolean;
  Var
    frmAvaliacaoTecSeat: TfrmConsultaServicosAutocenterTecSeat;
begin
  Result := True;

  If TTecladoSEAT.fDocumentoJaFoiAvaliado(cdsConsul.FieldByName('GER_NUMDOC').AsString,
                                          cdsConsul.FieldByName('GER_ESPDOC').AsString,
                                          cdsConsul.FieldByName('GER_CODEMP').AsString) Then
    Exit;

  Try
    pCriarFormularios(TfrmConsultaServicosAutocenterTecSeat, frmAvaliacaoTecSeat);

    frmAvaliacaoTecSeat.strNumDoc := cdsConsul.FieldByName('GER_NUMDOC').AsString;
    frmAvaliacaoTecSeat.strEspDoc := cdsConsul.FieldByName('GER_ESPDOC').AsString;
    frmAvaliacaoTecSeat.strEmpDoc := cdsConsul.FieldByName('GER_CODEMP').AsString;

    frmAvaliacaoTecSeat.ShowModal;

    Result := (frmAvaliacaoTecSeat.ModalResult = mrOk);
  Finally
    pFreeAndNil(frmAvaliacaoTecSeat);
  End;
end;

procedure TfrmConsultaServicosAutocenterVendas.imgcbxStaSerPropertiesChange(
  Sender: TObject);
begin
  inherited;
  If cdsConsul.State = dsEdit Then
  Begin
    cdsConsul.AfterScroll := nil;
    cdsConsul.Post;
    cdsConsul.AfterScroll := pAfterScroll;
    pAfterScroll(cdsConsul);
  End;
end;

function TfrmConsultaServicosAutocenterVendas.fCarregarMecanicosServico(strTabMec, strAutInc, strIdeSer: String): String;
begin
  Result    := fCampoTabela('GROUP_CONCAT(GER_CODMEC)', strTabMec, ['GER_SEQGER', 'GER_IDESER'], [strAutInc, strIdeSer]);
end;

end.
