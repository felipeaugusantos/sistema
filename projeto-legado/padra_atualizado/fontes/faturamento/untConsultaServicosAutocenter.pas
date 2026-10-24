unit untConsultaServicosAutocenter;

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
  cxCheckBox, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, dxCore, frxClass, frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxContainer, cxMemo,
  cxDBEdit, Vcl.Mask, DBEditFocus;

type
  TfrmConsultaServicosAutocenter = class(TfrmPaiConfirma)
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
    pnlProdutos: TPanel;
    cxgPro: TcxGrid;
    cxgProV: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    cxgProVCodIte: TcxGridDBColumn;
    cxgProVDesIte: TcxGridDBColumn;
    cxgProVSigUni: TcxGridDBColumn;
    cxgProVQtdIte: TcxGridDBColumn;
    dtsPro: TDataSource;
    pnlBotoesPro: TPanel;
    btnMecPro: TBitBtnLocked;
    pnlServicos: TPanel;
    cxgConsulta: TcxGrid;
    cxgConsultaTable: TcxGridDBTableView;
    cxgConsultaPrisma: TcxGridDBColumn;
    cxgConsultaDtaPed: TcxGridDBColumn;
    cxgConsultaNumPed: TcxGridDBColumn;
    cxgConsultaPlaVei: TcxGridDBColumn;
    cxgConsultaDesVei: TcxGridDBColumn;
    cxgConsultaNomCli: TcxGridDBColumn;
    cxgConsultaDocFat: TcxGridDBColumn;
    cxgConsultaDesSer: TcxGridDBColumn;
    cxgConsultaQtdSer: TcxGridDBColumn;
    cxgConsultaTmpSer: TcxGridDBColumn;
    cxgConsultaTipSer: TcxGridDBColumn;
    cxgConsultaStaSer: TcxGridDBColumn;
    cxgConsultaLevel1: TcxGridLevel;
    pnlBotoesSer: TPanel;
    btnMecSer: TBitBtnLocked;
    lblMecSer: TLabel;
    lblMecPro: TLabel;
    btnTempoPorTipo: TdxBarButton;
    cxgConsultaDtaAge: TcxGridDBColumn;
    cxgConsultaDtaEnt: TcxGridDBColumn;
    pnlObservacoesPedido: TPanel;
    edtMen001: TDBEditFocus;
    edtMen002: TDBEditFocus;
    edtMenexp: TDBEditFocus;
    edtMenex2: TDBEditFocus;
    edtMenex3: TDBEditFocus;
    edtMenex4: TDBEditFocus;
    pnlTituloProdutos: TPanel;
    lblProdutosPedido: TLabel;
    lblObsPedido: TLabel;
    pnlBotaoAlteracaoData: TPanel;
    btnAlteraDataEntrega: TBitBtnLocked;
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
    procedure btnMecProClick(Sender: TObject);
    procedure btnMecSerClick(Sender: TObject);
    procedure dtsProDataChange(Sender: TObject; Field: TField);
    procedure dtsConsulDataChange(Sender: TObject; Field: TField);
    procedure btnTempoPorTipoClick(Sender: TObject);
    procedure btnAlteraDataEntregaClick(Sender: TObject);
  private
    { Private declarations }
    qryOpe,
    qryConsul: TUniQuery;
    cdsConsul,
    cdsProdut: TUniClientDataSet;
    dicNomOpe: TDicionario;
    strStatusFinalizamServico: String;

    function fSqlConsulta: String;
    function fFormatarHora(strHora: String): String;
    function fConverteCorEscalaDeCinza(cor: TColor): TColor;
    function fCarregarMecanicosServico(strAutInc, strIdeSer: String): String;
    function fCarregarMecanicosProdutosObs(strAutInc, strCODMEC: String): TStringList;
    function fCarregarMecanicosServicoObs(strAutInc, strCODMEC: String): TStringList;

    function fGetMecanicos(strCodMec: String): String;
    
    procedure pAfterScroll(DataSet: TDataSet);
    procedure pAfterPost(DataSet: TDataSet);

    procedure pAfterScrollPro(DataSet: TDataSet);

    procedure pAbreConsulta;
    procedure pCarregarServicosClientDataSet;
    procedure pCarregaTipoServicos;
    procedure pCarregaStatusServicos;
    procedure pAtualizarDocumentos;
    procedure pCarregaProdutos(strAutIncFGO: String);
    function fExisteItensPendentesExpServ(strDocumento: string): Boolean;
    procedure pNotificaCliente(DataSet: TDataSet);
    procedure pAtualizaDataAgendamentoEntrega(strDtaAges, strHrAges, strDtEnts, strHrEnts, strSeqFgo: String);
    procedure cxgConsultaSummaryTmpSerGetDisplayText(Sender: TcxDataSummaryItem;
      const AValue: Variant; AIsFooter: Boolean; var AText: string);
    function fSolicitaAvaliacaoTecladoSEAT: Boolean;
    function fTodosServicosFinalizados(strAutInc, strIdeSer: String): Boolean;
  public
    blnAgendamento: Boolean;
  end;

Const
  MAX_SERVICOS = 30;

implementation

uses untFuncoes, untDigMecanicos, untConsultaServicosAutocenterTempoTot,
     untTypesSistema, untAltDataAgendamentoEntrega, untTecladoSEAT,
     untConsultaServicosAutocenterTecSeat;

{$R *.dfm}

function TfrmConsultaServicosAutocenter.fFormatarHora(strHora: String): String;
begin
  strHora := fSegToTempoStr(SecondsBetween(0, StrToDateTimeDef(strHora, 0)));
  strHora := LeftStr(strHora, Length(strHora) - 3);//Tira os Segundos
  Result  := strHora;
end;

function TfrmConsultaServicosAutocenter.fGetMecanicos(strCodMec: String): String;
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

procedure TfrmConsultaServicosAutocenter.btnAlteraDataEntregaClick(Sender: TObject);
  Var
    frmAltDataAgendamentoEntrega: TfrmAltDataAgendamentoEntrega;
begin
  pCriarFormularios(TfrmAltDataAgendamentoEntrega, frmAltDataAgendamentoEntrega);
  Try
    frmAltDataAgendamentoEntrega.edtDtaAge.Text := cdsConsul.FieldByName('FGO_DTAGES').AsString;
    frmAltDataAgendamentoEntrega.edtHraAge.Text := FormatDateTime('HH:MM', StrToTime(cdsConsul.FieldByName('FGO_HRAGES').AsString));
    frmAltDataAgendamentoEntrega.edtDtaEnt.Text := cdsConsul.FieldByName('FGO_DTENTS').AsString;
    frmAltDataAgendamentoEntrega.edtHraEnt.Text := FormatDateTime('HH:MM', StrToTime(cdsConsul.FieldByName('FGO_HRENTS').AsString));
    If frmAltDataAgendamentoEntrega.ShowModal = mrOk Then
    Begin
      pAtualizaDataAgendamentoEntrega(frmAltDataAgendamentoEntrega.edtDtaAge.Text,
                                      frmAltDataAgendamentoEntrega.edtHraAge.Text,
                                      frmAltDataAgendamentoEntrega.edtDtaEnt.Text,
                                      frmAltDataAgendamentoEntrega.edtHraEnt.Text,
                                      cdsConsul.FieldByName('AUTINC').AsString);

      pAtualizarDocumentos;
    End;
  Finally
    pFreeAndNil(frmAltDataAgendamentoEntrega);
  End;
end;

procedure TfrmConsultaServicosAutocenter.btnAtualizarClick(Sender: TObject);
begin
  inherited;
  pAtualizarDocumentos;
end;

procedure TfrmConsultaServicosAutocenter.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmConsultaServicosAutocenter.btnExpandClick(Sender: TObject);
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

procedure TfrmConsultaServicosAutocenter.btnMecProClick(Sender: TObject);
  Var
    qryMecDor: TUniQuery;

  procedure pAtuMec;
    Var
      intMec: Integer;
  begin
    cdsProdut.Edit;
    cdsProdut.FieldByName('MECPRO').AsString := frmDigMecanicos.stlMecanicos.CommaText;
    cdsProdut.Post;

    qryMecDor.SQL.Clear;
    qryMecDor.SQL.Add('DELETE FROM MECDOR');
    qryMecDor.SQL.Add(' WHERE FDO_SEQFDO = :SEQFDO');

    qryMecDor.ParamByName('SEQFDO').AsString := cdsProdut.FieldByName('AUTINC').AsString;
    qryMecDor.ExecSQL;

    qryMecDor.SQL.Clear;
    qryMecDor.SQL.Add('INSERT INTO MECDOR(');
    qryMecDor.SQL.Add('  FDO_SEQFDO,');
    qryMecDor.SQL.Add('  FDO_CODMEC,');
    qryMecDor.SQL.Add('  FDO_OBSMEC');
    qryMecDor.SQL.Add(') VALUES (');
    qryMecDor.SQL.Add('  :SEQFDO,');
    qryMecDor.SQL.Add('  :CODMEC,');
    qryMecDor.SQL.Add('  :OBSMEC');
    qryMecDor.SQL.Add(')');

    For intMec := 0 To frmDigMecanicos.stlMecanicos.Count -1 Do
    Begin
      qryMecDor.ParamByName('SEQFDO').AsString := cdsProdut.FieldByName('AUTINC').AsString;
      qryMecDor.ParamByName('CODMEC').AsString := frmDigMecanicos.stlMecanicos[intMec];
      qryMecDor.ParamByName('OBSMEC').AsString := frmDigMecanicos.stlMecanicosObs[intMec];
      qryMecDor.ExecSQL;
    End;
  end;
begin
  If Not btnMecPro.Enabled Then
    Exit;
    
  pCriarFormularios(TfrmDigMecanicos, frmDigMecanicos);
  Try
    frmDigMecanicos.blnUtilizaObs := True;
    frmDigMecanicos.stlMecanicos.CommaText := cdsProdut.FieldByName('MECPRO').AsString;
    frmDigMecanicos.stlMecanicosObs        := fCarregarMecanicosProdutosObs(cdsProdut.FieldByName('AUTINC').AsString, cdsProdut.FieldByName('MECPRO').AsString );
    frmDigMecanicos.pnlAltMecGer.Visible := True;

    If frmDigMecanicos.ShowModal = mrOk Then
    Begin
      qryMecDor := fCriaQuery;
      Try
        // Se for alterar mecânico de todos produtos
        If frmDigMecanicos.chkAltMecGer.Checked Then
        Begin
          cdsProdut.First;
          While Not cdsProdut.Eof Do
          Begin
            pAtuMec;
            cdsProdut.Next;
          End;
        End
        // Se for alterar mecânico somente do produto atual
        Else
          pAtuMec;
      Finally
        FreeAndNil(qryMecDor);
      End;
    End;
  Finally
    pFreeAndNil(frmDigMecanicos);
  End;
end;

procedure TfrmConsultaServicosAutocenter.btnMecSerClick(Sender: TObject);
  Var
    qryMecGor: TUniQuery;
    intRecNo: Integer;

  procedure pAtuMec;
    Var
      intMec: Integer;
  begin
    If Pos(cdsConsul.FieldByName('STASER').AsString, strStatusFinalizamServico) > 0 Then
      Exit;

    If (fCfgSis('ACOSER') = '2') And Not fEmptyStr(cdsConsul.FieldByName('DOCFAT').AsString) Then
      Exit;
      
    cdsConsul.Edit;
    cdsConsul.FieldByName('CODMEC').AsString := frmDigMecanicos.stlMecanicos.CommaText;
    cdsConsul.Post;

    qryMecGor.SQL.Clear;
    qryMecGor.SQL.Add('DELETE FROM MECGOR');
    qryMecGor.SQL.Add(' WHERE FGO_SEQFGO = :SEQFGO');
    qryMecGor.SQL.Add('   AND FGO_IDESER = :IDESER');

    qryMecGor.ParamByName('SEQFGO').AsString := cdsConsul.FieldByName('AUTINC').AsString;
    qryMecGor.ParamByName('IDESER').AsString := cdsConsul.FieldByName('IDESER').AsString;
    qryMecGor.ExecSQL;

    qryMecGor.SQL.Clear;
    qryMecGor.SQL.Add('INSERT INTO MECGOR(');
    qryMecGor.SQL.Add('  FGO_SEQFGO,');
    qryMecGor.SQL.Add('  FGO_IDESER,');
    qryMecGor.SQL.Add('  FGO_CODMEC,');
    qryMecGor.SQL.Add('  FGO_OBSMEC');
    qryMecGor.SQL.Add(') VALUES (');
    qryMecGor.SQL.Add('  :SEQFGO,');
    qryMecGor.SQL.Add('  :IDESER,');
    qryMecGor.SQL.Add('  :CODMEC,');
    qryMecGor.SQL.Add('  :OBSMEC');
    qryMecGor.SQL.Add(')');

    For intMec := 0 To frmDigMecanicos.stlMecanicos.Count -1 Do
    Begin
      qryMecGor.ParamByName('SEQFGO').AsString := cdsConsul.FieldByName('AUTINC').AsString;
      qryMecGor.ParamByName('IDESER').AsString := cdsConsul.FieldByName('IDESER').AsString;
      qryMecGor.ParamByName('CODMEC').AsString := frmDigMecanicos.stlMecanicos[intMec];
      qryMecGor.ParamByName('OBSMEC').AsString := frmDigMecanicos.stlMecanicosObs[intMec];
      qryMecGor.ExecSQL;
    End;
  end;
begin
  If Not btnMecSer.Enabled Then
    Exit;

  pCriarFormularios(TfrmDigMecanicos, frmDigMecanicos);
  Try
    frmDigMecanicos.blnUtilizaObs := True;
    frmDigMecanicos.stlMecanicos.CommaText := cdsConsul.FieldByName('CODMEC').AsString;
    frmDigMecanicos.stlMecanicosObs        := fCarregarMecanicosServicoObs(cdsConsul.FieldByName('AUTINC').AsString, cdsConsul.FieldByName('CODMEC').AsString);
    frmDigMecanicos.pnlAltMecGer.Visible := True;
    frmDigMecanicos.chkAltMecGer.Caption := 'Alterar mecânico para todos serviços do pedido?';

    If frmDigMecanicos.ShowModal = mrOk Then
    Begin
      qryMecGor := fCriaQuery;
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
        FreeAndNil(qryMecGor);
      End;
    End;
  Finally
    pFreeAndNil(frmDigMecanicos);
  End;
end;

procedure TfrmConsultaServicosAutocenter.btnTempoPorTipoClick(Sender: TObject);
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

procedure TfrmConsultaServicosAutocenter.btnUpdateClick(Sender: TObject);
begin
  inherited;
  pAtualizarDocumentos;
end;

procedure TfrmConsultaServicosAutocenter.cxgConsultaTableKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  Key := UpCase(Key);
end;

function TfrmConsultaServicosAutocenter.fConverteCorEscalaDeCinza(cor: TColor): TColor;
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

function TfrmConsultaServicosAutocenter.fExisteItensPendentesExpServ(strDocumento: string): Boolean;
var
  qryItensPendentes: TUniQuery;
  strNumDoc,
  strCodEmp: string;
begin
  Result := False;
  if not fEmptyStr(strDocumento) then
  begin
    try
      strNumDoc := Copy(strDocumento,1,12);
      strCodEmp := Copy(strDocumento,17,3);

      qryItensPendentes := fCriaQuery;
      qryItensPendentes.Close;
      qryItensPendentes.SQL.Clear;

      qryItensPendentes.SQL.Add(' SELECT                           ');
      qryItensPendentes.SQL.Add('   IF(                            ');
      qryItensPendentes.SQL.Add('     SUM(PENDEN) <> 0,            ');
      qryItensPendentes.SQL.Add('     "S",                         ');
      qryItensPendentes.SQL.Add('     "N"                          ');
      qryItensPendentes.SQL.Add('   ) PENDEN                       ');
      qryItensPendentes.SQL.Add(' FROM(                            ');
      qryItensPendentes.SQL.Add('   SELECT                         ');
      qryItensPendentes.SQL.Add('     IF(                          ');
      qryItensPendentes.SQL.Add('       SUM(                       ');
      qryItensPendentes.SQL.Add('         IF(                      ');
      qryItensPendentes.SQL.Add('           FDO_ENTSAI = "S" AND   ');
      qryItensPendentes.SQL.Add('           FDO_PENDEN = TRUE,     ');
      qryItensPendentes.SQL.Add('           FDO_QTDITE,            ');
      qryItensPendentes.SQL.Add('           IF(                    ');
      qryItensPendentes.SQL.Add('             FDO_ENTSAI = "E" AND ');
      qryItensPendentes.SQL.Add('             FDO_PENDEN = TRUE,   ');
      qryItensPendentes.SQL.Add('             FDO_QTDITE * -1,     ');
      qryItensPendentes.SQL.Add('             0                    ');
      qryItensPendentes.SQL.Add('           )                      ');
      qryItensPendentes.SQL.Add('         )                        ');
      qryItensPendentes.SQL.Add('       ) <> 0,                    ');
      qryItensPendentes.SQL.Add('       TRUE,                      ');
      qryItensPendentes.SQL.Add('       FALSE                      ');
      qryItensPendentes.SQL.Add('     ) PENDEN                     ');
      qryItensPendentes.SQL.Add('   FROM                           ');
      qryItensPendentes.SQL.Add('     FDOSEP                       ');
      qryItensPendentes.SQL.Add('   WHERE FDO_CODEMP =:CODEMP      ');
      qryItensPendentes.SQL.Add('     AND FDO_NUMDOC =:NUMDOC      ');
      qryItensPendentes.SQL.Add('   GROUP BY                       ');
      qryItensPendentes.SQL.Add('     FDO_CODEMP,                  ');
      qryItensPendentes.SQL.Add('     FDO_NUMDOC,                  ');
      qryItensPendentes.SQL.Add('     FDO_CODCLI,                  ');
      qryItensPendentes.SQL.Add('     FDO_SEQINC,                  ');
      qryItensPendentes.SQL.Add('     FDO_CODITE                   ');
      qryItensPendentes.SQL.Add(' )PENDENCIA                       ');

      qryItensPendentes.ParamByName('CODEMP').AsString := strCodEmp;
      qryItensPendentes.ParamByName('NUMDOC').AsString := strNumDoc;

      qryItensPendentes.Open;

      Result := (qryItensPendentes.FieldByName('PENDEN').AsString = 'S');
    finally
      FreeAndNil(qryItensPendentes);
    end;
  end;
end;

procedure TfrmConsultaServicosAutocenter.cxgConsultaTipSerCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
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
      corFonte := fConverteCorEscalaDeCinza(item.Tag);
      ACanvas.Font.Style  := [fsBold];
      ACanvas.Brush.Color := item.Tag;
      ACanvas.Font.Color  := RGB(not GetRValue(corFonte), not GetGValue(corFonte), not GetBValue(corFonte));
    End;
  Except

  End;
end;

procedure TfrmConsultaServicosAutocenter.cxgConsultaTmpSerGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  AText := fFormatarHora(AText);
end;

procedure TfrmConsultaServicosAutocenter.cxgConsultaSummaryTmpSerGetDisplayText(Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean; var AText: string);
begin
  inherited;
  AText := fFormatarHora(AText);
end;

procedure TfrmConsultaServicosAutocenter.dtsConsulDataChange(Sender: TObject; Field: TField);
begin
  btnMecSer.Enabled := (Not dtsConsul.DataSet.IsEmpty) And (Pos(dtsConsul.DataSet.FieldByName('STASER').AsString, strStatusFinalizamServico) = 0);
  btnAlteraDataEntrega.Enabled := Not dtsConsul.DataSet.IsEmpty;

  If (fCfgSis('ACOSER') = '2') And Not fEmptyStr(dtsConsul.DataSet.FieldByName('DOCFAT').AsString) Then
    btnMecSer.Enabled := False;

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

      if (fCfgSis('USAEXS', varBoolean)) and (fExisteItensPendentesExpServ(cdsConsul.FieldByName('NUMPED').AsString)) then
      begin
        fMensagem('', 'Não é permitido finalizar um serviço com itens pendentes na expedição de serviço!', ['&Ok']);
        dtsConsul.DataSet.Cancel;
        Exit;
      end;

      If Not fPergunta('O Status selecionado irá finalizar o serviço não permitindo alterar o mesmo ' +
                       'e quando todos os serviços estiverem finalizados irá liberar o prisma!' +
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

procedure TfrmConsultaServicosAutocenter.dtsProDataChange(Sender: TObject; Field: TField);
begin
  btnMecPro.Enabled := Not dtsPro.Dataset.IsEmpty;
end;

procedure TfrmConsultaServicosAutocenter.edtQtdDiasFatuButtonClick(Sender: TdxBarSpinEdit; Button: TdxBarSpinEditButton);
begin
  inherited;
  Case Button Of
    sbUp   : Sender.Value := Sender.Value + 1;
    sbDown : Sender.Value := Sender.Value - 1;
  End;
end;

procedure TfrmConsultaServicosAutocenter.edtRefreshChange(Sender: TObject);
begin
  inherited;
  tmrAtualizar.Interval := edtRefresh.EditValue * 60 * 1000;
end;

procedure TfrmConsultaServicosAutocenter.FormCreate(Sender: TObject);
var
  intQtdeMaxDias: Integer;
begin
  inherited;
  pnlProdutos.Visible := fCfgSis('PROASE', varBoolean) And (fCfgSis('ACOSER') <> '2');

  intQtdeMaxDias := fCfgSis('DMAXAC', varInteger);

  if intQtdeMaxDias > 180 then // máximo permitido
    intQtdeMaxDias := 180
  else if intQtdeMaxDias < 30 then // mínimo que já era padrão do sistema antes de existir a "CFG_DMAXAC"
    intQtdeMaxDias := 30;

  edtQtdDiasFatu.MaxValue := intQtdeMaxDias;

  qryOpe := fCriaQuery;
  qryOpe.SQL.Text := 'SELECT * FROM CADOPE';
  qryOpe.Open;

  qryConsul := fCriaQuery(Self);
  dicNomOpe := TDicionario.Create;

  cdsProdut := TUniClientDataSet.Create(Nil);
  cdsProdut.FieldDefs.Add('SEQFGO', ftString, 20);
  cdsProdut.FieldDefs.Add('AUTINC', ftString, 20);
  cdsProdut.FieldDefs.Add('CODITE', ftString,  fTamCodIte);
  cdsProdut.FieldDefs.Add('DESITE', ftString, 70);
  cdsProdut.FieldDefs.Add('SIGUNI', ftString,  7);
  cdsProdut.FieldDefs.Add('QTDITE', ftFloat);
  cdsProdut.FieldDefs.Add('MECPRO', ftString, 99);
  cdsProdut.CreateDataSet;
  cdsProdut.IndexFieldNames := 'DESITE';
  cdsProdut.AfterScroll := pAfterScrollPro;
  dtsPro.Dataset := cdsProdut;
end;

procedure TfrmConsultaServicosAutocenter.pCarregaTipoServicos;
begin

  With fCriaQuery(Nil), SQL Do
  Begin
    Add('SELECT TPS_CODIGO, TPS_DESCRI, TPS_CORIDE FROM TIPSER');
    Open;

    imgcbxTipSer.Properties.Items.Clear;

    While Not Eof Do
    Begin
      imgcbxTipSer.Properties.Items.Add;
      imgcbxTipSer.Properties.Items[RecNo -1].Tag         := FieldByName('TPS_CORIDE').AsInteger;
      imgcbxTipSer.Properties.Items[RecNo -1].Value       := FieldByName('TPS_CODIGO').AsString;
      imgcbxTipSer.Properties.Items[RecNo -1].Description := FieldByName('TPS_DESCRI').AsString;
      Next;
    End;

    Destroy;
  End;

end;

procedure TfrmConsultaServicosAutocenter.tmrAtualizarTimer(Sender: TObject);
begin
  inherited;
  pAtualizarDocumentos;
end;

procedure TfrmConsultaServicosAutocenter.pAtualizaDataAgendamentoEntrega(strDtaAges, strHrAges, strDtEnts, strHrEnts, strSeqFgo: String);
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  Try
    qryAux.Close;
    qryAux.SQL.Clear;

    qryAux.SQL.Add(' UPDATE SERGOR ');
    qryAux.SQL.Add(' SET FGO_DTAGES = :DTAGES, ');
    qryAux.SQL.Add(' FGO_HRAGES = :HRAGES, ');
    qryAux.SQL.Add(' FGO_DTENTS = :DTENTS, ');
    qryAux.SQL.Add(' FGO_HRENTS = :HRENTS ');
    qryAux.SQL.Add(' WHERE FGO_SEQFGO = :SEQFGO ');

    qryAux.ParamByName('DTAGES').AsDateTime := StrToDate(strDtaAges);
    qryAux.ParamByName('HRAGES').AsDateTime := StrToTime(strHrAges);
    qryAux.ParamByName('DTENTS').AsDateTime := StrToDate(strDtEnts);
    qryAux.ParamByName('HRENTS').AsDateTime := StrToTime(strHrEnts);
    qryAux.ParamByName('SEQFGO').AsString   := strSeqFgo;

    qryAux.ExecSQL;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmConsultaServicosAutocenter.pAtualizarDocumentos;
begin
  pCarregaTipoServicos;
  pCarregaStatusServicos;
  pAbreConsulta;
end;

procedure TfrmConsultaServicosAutocenter.pCarregaStatusServicos;
begin

  With fCriaQuery(Nil), SQL Do
  Begin
    Add('SELECT STS_CODIGO, STS_DESCRI, STS_FINALI FROM STASER');
    Open;

    strStatusFinalizamServico := '';
    imgcbxStaSer.Properties.Items.Clear;

    While Not Eof Do
    Begin
      imgcbxStaSer.Properties.Items.Add;
      imgcbxStaSer.Properties.Items[RecNo -1].Tag         := FieldByName('STS_CODIGO').AsInteger;
      imgcbxStaSer.Properties.Items[RecNo -1].Value       := FieldByName('STS_CODIGO').AsString;
      imgcbxStaSer.Properties.Items[RecNo -1].Description := FieldByName('STS_DESCRI').AsString;

      If FieldByName('STS_FINALI').AsString = 'S' Then
        strStatusFinalizamServico := strStatusFinalizamServico + FieldByName('STS_CODIGO').AsString + '_';

      Next;
    End;

    Destroy;
  End;

end;

procedure TfrmConsultaServicosAutocenter.FormDestroy(Sender: TObject);
begin
  inherited;
  If Assigned(cdsConsul) Then
    FreeAndNil(cdsConsul);

  If Assigned(dicNomOpe) Then
    FreeAndNil(dicNomOpe);

  FreeAndNil(cdsProdut);
  FreeAndNil(qryOpe);
end;

procedure TfrmConsultaServicosAutocenter.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F5: btnUpdate.Click;
    VK_F6: btnMecSer.Click;
    VK_F7: btnMecPro.Click;
    VK_F8: btnAlteraDataEntrega.Click;
  End;
end;

Procedure TfrmConsultaServicosAutocenter.pAbreConsulta;
Begin
  lblInformacao.Caption := 'AGUARDE, ATUALIZANDO PEDIDOS...';
  Try
    Application.ProcessMessages;

    With qryConsul Do
    Begin
      Close;
      SQL.text := fSqlConsulta;

      ParamByName('CODEMP').AsString  := VS_strCodEmp;
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

procedure TfrmConsultaServicosAutocenter.pAfterPost(DataSet: TDataSet);
  var
    strIdeSer,
    strStaSer,
    strSeqFgo: String;
begin
  strIdeSer := DataSet.FieldByName('IDESER').AsString;
  strStaSer := DataSet.FieldByName('STASER').AsString;
  strSeqFgo := DataSet.FieldByName('AUTINC').AsString;

  if not fCampoExiste('SERGOR', 'FGO_STAS' + strIdeSer, True) then
    Exit;

  fExecutaSQL(' UPDATE SERGOR ' +
              ' SET FGO_STAS' + strIdeSer + ' = ' + QuotedStr(strStaSer) +
              ' WHERE FGO_SEQFGO = ' + QuotedStr(strSeqFgo));

  pNotificaCliente(DataSet);
end;

procedure TfrmConsultaServicosAutocenter.pNotificaCliente(DataSet: TDataSet);
begin
  fDisparaWhatsappAutomatico(DataSet.FieldByName('FGO_NUMDOC').AsString,
                             'SE',
                             DataSet.FieldByName('FGO_ESPDOC').AsString,
                             '',
                             '',
                             DataSet.FieldByName('FGO_CODEMP').AsString,
                             DataSet.FieldByName('FGO_CODCLI').AsString,
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

function TfrmConsultaServicosAutocenter.fTodosServicosFinalizados(strAutInc, strIdeSer: String): Boolean;
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
      strCam := strCam + 'FGO_STAS' + fStrZero(intSer, 2) + ',';

    Delete(strCam, Length(strCam), 1);

    qrySer.SQL.Add('SELECT '+ strCam);
    qrySer.SQL.Add('FROM SERGOR');
    qrySer.SQL.Add('WHERE FGO_SEQFGO = :SEQFGO');

    qrySer.ParamByName('SEQFGO').AsString := strAutInc;
    qrySer.Open;

    For intSer := 0 To qrySer.FieldCount -1 Do
    Begin
      If SameStr(qrySer.Fields[intSer].FieldName, 'FGO_STAS' + strIdeSer) Then
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

function TfrmConsultaServicosAutocenter.fSolicitaAvaliacaoTecladoSEAT: Boolean;
  Var
    frmAvaliacaoTecSeat: TfrmConsultaServicosAutocenterTecSeat;
begin
  Result := True;

  If TTecladoSEAT.fDocumentoJaFoiAvaliado(cdsConsul.FieldByName('FGO_NUMDOC').AsString,
                                          cdsConsul.FieldByName('FGO_ESPDOC').AsString,
                                          cdsConsul.FieldByName('FGO_CODEMP').AsString) Then
    Exit;

  Try
    pCriarFormularios(TfrmConsultaServicosAutocenterTecSeat, frmAvaliacaoTecSeat);

    frmAvaliacaoTecSeat.strNumDoc := cdsConsul.FieldByName('FGO_NUMDOC').AsString;
    frmAvaliacaoTecSeat.strEspDoc := cdsConsul.FieldByName('FGO_ESPDOC').AsString;
    frmAvaliacaoTecSeat.strEmpDoc := cdsConsul.FieldByName('FGO_CODEMP').AsString;

    frmAvaliacaoTecSeat.ShowModal;

    Result := (frmAvaliacaoTecSeat.ModalResult = mrOk);
  Finally
    pFreeAndNil(frmAvaliacaoTecSeat);
  End;
end;

procedure TfrmConsultaServicosAutocenter.pAfterScroll(DataSet: TDataSet);
  Var
    strMecSer: String;
begin
  With DataSet Do
  Begin
    cxgConsultaStaSer.Options.Editing := (Pos(FieldByName('STASER').AsString, strStatusFinalizamServico) <= 0);

    If (fCfgSis('ACOSER') = '2') And Not fEmptyStr(FieldByName('DOCFAT').AsString) Then
      cxgConsultaStaSer.Options.Editing := False;

    cdsProdut.Filter := 'SEQFGO = ' + QuotedStr(FieldByName('AUTINC').AsString);
    cdsProdut.Filtered := True;

    strMecSer := fGetMecanicos(FieldByName('CODMEC').AsString);

    lblMecSer.Visible := Not fEmptyStr(strMecSer);

    If Pos(',', strMecSer) > 0 Then
      lblMecSer.Caption := 'Mecânicos: '
    Else
      lblMecSer.Caption := 'Mecânico: ';

    lblMecSer.Caption := lblMecSer.Caption + strMecSer;
  End;
end;

procedure TfrmConsultaServicosAutocenter.pAfterScrollPro(DataSet: TDataSet);
  Var
    strMecPro: String;
begin
  strMecPro := fGetMecanicos(DataSet.FieldByName('MECPRO').AsString);

  lblMecPro.Visible := Not fEmptyStr(strMecPro);

  If Pos(',', strMecPro) > 0 Then
    lblMecPro.Caption := 'Mecânicos: '
  Else
    lblMecPro.Caption := 'Mecânico: ';

  lblMecPro.Caption := lblMecPro.Caption + strMecPro;
end;

procedure TfrmConsultaServicosAutocenter.pCarregaProdutos(strAutIncFGO: String);
  Var
    qryPro: TUniQuery;
begin
  If Not pnlProdutos.Visible Then
    Exit;

  If fEmptyStr(strAutIncFGO) Then
    Exit;
    
  qryPro := fCriaQuery;
  Try
    qryPro.SQL.Add('SELECT FATDOR.AUTOINCREM AS AUTINC,');
    qryPro.SQL.Add('       FDO_SEQGER AS SEQFGO,');
    qryPro.SQL.Add('       ITE_CODITE AS CODITE,');
    qryPro.SQL.Add('       ITE_DESITE AS DESITE,');
    qryPro.SQL.Add('       UNI_SIGUNI AS SIGUNI,');
    qryPro.SQL.Add('       FDO_QTDITE AS QTDITE,');
    qryPro.SQL.Add('       (SELECT GROUP_CONCAT(FDO_CODMEC) FROM MECDOR WHERE FDO_SEQFDO = FATDOR.AUTOINCREM) AS MECPRO');
    qryPro.SQL.Add('  FROM FATDOR');
    qryPro.SQL.Add('  JOIN CADITE ON ITE_CODITE = FDO_CODITE');
    qryPro.SQL.Add('  JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI');
    qryPro.SQL.Add(' WHERE FDO_SEQGER IN ('+ strAutIncFGO +')');
    qryPro.SQL.Add('   AND FDO_CODEMP = :CODEMP');
    qryPro.SQL.Add('   AND FDO_CODITE <> :ITESER');
    qryPro.SQL.Add('   AND FDO_CODITE <> :SERTER');

    qryPro.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryPro.ParamByName('ITESER').AsString := fCfgSis('ITESER');
    qryPro.ParamByName('SERTER').AsString := fCfgSis('SERTER');
    qryPro.Open;

    cdsProdut.EmptyDataSet;

    While Not qryPro.Eof Do
    Begin
      cdsProdut.Append;
      cdsProdut.FieldByName('AUTINC').AsString := qryPro.FieldByName('AUTINC').AsString;
      cdsProdut.FieldByName('SEQFGO').AsString := qryPro.FieldByName('SEQFGO').AsString;
      cdsProdut.FieldByName('CODITE').AsString := qryPro.FieldByName('CODITE').AsString;
      cdsProdut.FieldByName('DESITE').AsString := qryPro.FieldByName('DESITE').AsString;
      cdsProdut.FieldByName('SIGUNI').AsString := qryPro.FieldByName('SIGUNI').AsString;
      cdsProdut.FieldByName('QTDITE').AsString := qryPro.FieldByName('QTDITE').AsString;
      cdsProdut.FieldByName('MECPRO').AsString := qryPro.FieldByName('MECPRO').AsString;
      cdsProdut.Post;
      
      qryPro.Next;
    End;    
  Finally
    FreeAndNil(qryPro);
  End;              
end;

procedure TfrmConsultaServicosAutocenter.pCarregarServicosClientDataSet;
  Var
    intSer: Integer;
    strPedAnt,
    strAutIncFGO: String;
    prcScroll: TprcScroll;
begin
  Try
    pDisableControls(cdsConsul, prcScroll);

    strPedAnt := cdsConsul.FieldByName('NUMPED').AsString;

    cdsConsul.EmptyDataSet;
    qryConsul.First;

    pgbProgresso.Visible  := True;
    pgbProgresso.MaxValue := qryConsul.RecordCount;

    strAutIncFGO := '';
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

            If FieldByName('FGO_DTAGES').AsDateTime = 0 Then
              FieldByName('DTAGES').AsString := '';

            If FieldByName('FGO_DTENTS').AsDateTime = 0 Then
              FieldByName('DTENTS').AsString := '';

            FieldByName('PRISMA').AsString := FieldByName('PRIS' + fStrZero(intSer, 2)).AsString;
            FieldByName('CODSER').AsString := FieldByName('CODS' + fStrZero(intSer, 2)).AsString;
            FieldByName('DESSER').AsString := FieldByName('DESS' + fStrZero(intSer, 2)).AsString;
            FieldByName('TIPSER').AsString := FieldByName('TIPS' + fStrZero(intSer, 2)).AsString;
            FieldByName('STASER').AsString := FieldByName('STAS' + fStrZero(intSer, 2)).AsString;
            FieldByName('QTDSER').AsFloat  := FieldByName('QTDS' + fStrZero(intSer, 2)).AsFloat;
            FieldByName('TMPSER').AsFloat  := FieldByName('TMPS' + fStrZero(intSer, 2)).AsFloat *
                                              FieldByName('QTDS' + fStrZero(intSer, 2)).AsFloat;
            FieldByName('CODMEC').AsString := fCarregarMecanicosServico(FieldByName('AUTINC').AsString, fStrZero(intSer, 2));
            Post;
          End;
        End;
      End;

      strAutIncFGO := strAutIncFGO + IIF(fEmptyStr(strAutIncFGO), '', ',') + QuotedStr(cdsConsul.FieldByName('AUTINC').AsString);

      qryConsul.Next;
    End;

    // Carrega os produtos de todos os pedidos
    pCarregaProdutos(strAutIncFGO);
  Finally
    pgbProgresso.Visible := False;
    pEnableControls(cdsConsul, prcScroll);
    cdsConsul.Locate('NUMPED', strPedAnt, []);
  End;

end;

procedure TfrmConsultaServicosAutocenter.FormShow(Sender: TObject);
  {$IFDEF TESTABILIDADE_AUTCOM}
    //Não agrupa caso seja teste automatizado
  {$ELSE}
    Var
      intCol: Integer;
      ASummaryItem: TcxGridDBTableSummaryItem;
  {$ENDIF}
begin
  inherited;
  cxgConsultaQtdSer.Visible := fCfgSis('QTDSER', varBoolean);

  {$IFDEF TESTABILIDADE_AUTCOM}
    //Não agrupa caso seja teste automatizado
  {$ELSE}
    If blnAgendamento Then
    Begin
      cxgConsultaTable.DataController.Groups.ClearGrouping;
      cxgConsultaTipSer.GroupBy(0);
      cxgConsultaTipSer.Visible := False;
      cxgConsultaDtaAge.SortOrder := soAscending;

      chkStaFin.ShowCaption := False;
      chkStaFin.Visible := ivNever;

      For intCol := 0 To cxgConsultaTable.ColumnCount -1 Do
        cxgConsultaTable.Columns[intCol].Options.CellMerging := False;
    End
    Else
    Begin
      cxgConsultaTable.DataController.Groups.ClearGrouping;
      cxgConsultaNumPed.GroupBy(0);
      cxgConsultaNumPed.Visible := False;
    End;

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
  {$ENDIF}

  tmrAtualizar.Interval := edtRefresh.EditValue * 60 * 1000;
  pAtualizarDocumentos;
  tmrAtualizar.Enabled := True;
end;

function TfrmConsultaServicosAutocenter.fSqlConsulta: String;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  FATGOR.AUTOINCREM AS AUTINC, ';

  strSQL := strSQL + '  FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP, FGO_CODCLI, ';

  strSQL := strSQL + '  FGO_DTAGES, FGO_HRAGES, FGO_DTENTS, FGO_HRENTS, ';

  strSQL := strSQL + '  CONCAT(DATE_FORMAT(FGO_DTAENT,"%d/%m/%Y"), " ", DATE_FORMAT(FGO_HORENT,"%H:%i")) AS DTAPED, ';

  strSQL := strSQL + '  CONCAT(DATE_FORMAT(FGO_DTAGES,"%d/%m/%Y"), " ", DATE_FORMAT(FGO_HRAGES,"%H:%i")) AS DTAGES, ';
  strSQL := strSQL + '  FGO_DTAGES, ';

  strSQL := strSQL + '  CONCAT(DATE_FORMAT(FGO_DTENTS,"%d/%m/%Y"), " ", DATE_FORMAT(FGO_HRENTS,"%H:%i")) AS DTENTS, ';
  strSQL := strSQL + '  FGO_DTENTS, ';

  strSQL := strSQL + '  CONCAT(FGO_NUMDOC, "-", FGO_ESPDOC, "-", FGO_CODEMP) AS NUMPED, ';
  strSQL := strSQL + '  CONCAT(CLI_NOMCLI, " (", CLI_CODCLI, ") ") AS NOMCLI, ';

  strSQL := strSQL + '  CONCAT(LEFT(FGO_PLAVEI, 3), "-", RIGHT(FGO_PLAVEI, 4)) AS PLAVEI, ';

  strSQL := strSQL + '  CONCAT(IFNULL(MAR_DESMAR, ""), " ", ';
  strSQL := strSQL + '         IFNULL(MOD_DESMOD, ""), " ", ';
  strSQL := strSQL + '         IFNULL(VEI_ANOVEI, ""), " ", ';
  strSQL := strSQL + '         IFNULL(COR_DESCOR, "")) AS DESVEI, ';

  strSQL := strSQL + '  "00" AS IDESER, ';

  strSQL := strSQL + '  LPAD("", 05, " ") AS CODSER, ';
  strSQL := strSQL + '  FGO_CODS01 AS CODS01, ';
  strSQL := strSQL + '  FGO_CODS02 AS CODS02, ';
  strSQL := strSQL + '  FGO_CODS03 AS CODS03, ';
  strSQL := strSQL + '  FGO_CODS04 AS CODS04, ';
  strSQL := strSQL + '  FGO_CODS05 AS CODS05, ';
  strSQL := strSQL + '  FGO_CODS06 AS CODS06, ';
  strSQL := strSQL + '  FGO_CODS07 AS CODS07, ';
  strSQL := strSQL + '  FGO_CODS08 AS CODS08, ';
  strSQL := strSQL + '  FGO_CODS09 AS CODS09, ';
  strSQL := strSQL + '  FGO_CODS10 AS CODS10, ';
  strSQL := strSQL + '  FGO_CODS11 AS CODS11, ';
  strSQL := strSQL + '  FGO_CODS12 AS CODS12, ';
  strSQL := strSQL + '  FGO_CODS13 AS CODS13, ';
  strSQL := strSQL + '  FGO_CODS14 AS CODS14, ';
  strSQL := strSQL + '  FGO_CODS15 AS CODS15, ';
  strSQL := strSQL + '  FGO_CODS16 AS CODS16, ';
  strSQL := strSQL + '  FGO_CODS17 AS CODS17, ';
  strSQL := strSQL + '  FGO_CODS18 AS CODS18, ';
  strSQL := strSQL + '  FGO_CODS19 AS CODS19, ';
  strSQL := strSQL + '  FGO_CODS20 AS CODS20, ';
  strSQL := strSQL + '  FGO_CODS21 AS CODS21, ';
  strSQL := strSQL + '  FGO_CODS22 AS CODS22, ';
  strSQL := strSQL + '  FGO_CODS23 AS CODS23, ';
  strSQL := strSQL + '  FGO_CODS24 AS CODS24, ';
  strSQL := strSQL + '  FGO_CODS25 AS CODS25, ';
  strSQL := strSQL + '  FGO_CODS26 AS CODS26, ';
  strSQL := strSQL + '  FGO_CODS27 AS CODS27, ';
  strSQL := strSQL + '  FGO_CODS28 AS CODS28, ';
  strSQL := strSQL + '  FGO_CODS29 AS CODS29, ';
  strSQL := strSQL + '  FGO_CODS30 AS CODS30, ';

  strSQL := strSQL + '  LPAD("", 80, " ") AS DESSER, ';
  strSQL := strSQL + '  FGO_DESS01 AS DESS01, ';
  strSQL := strSQL + '  FGO_DESS02 AS DESS02, ';
  strSQL := strSQL + '  FGO_DESS03 AS DESS03, ';
  strSQL := strSQL + '  FGO_DESS04 AS DESS04, ';
  strSQL := strSQL + '  FGO_DESS05 AS DESS05, ';
  strSQL := strSQL + '  FGO_DESS06 AS DESS06, ';
  strSQL := strSQL + '  FGO_DESS07 AS DESS07, ';
  strSQL := strSQL + '  FGO_DESS08 AS DESS08, ';
  strSQL := strSQL + '  FGO_DESS09 AS DESS09, ';
  strSQL := strSQL + '  FGO_DESS10 AS DESS10, ';
  strSQL := strSQL + '  FGO_DESS11 AS DESS11, ';
  strSQL := strSQL + '  FGO_DESS12 AS DESS12, ';
  strSQL := strSQL + '  FGO_DESS13 AS DESS13, ';
  strSQL := strSQL + '  FGO_DESS14 AS DESS14, ';
  strSQL := strSQL + '  FGO_DESS15 AS DESS15, ';
  strSQL := strSQL + '  FGO_DESS16 AS DESS16, ';
  strSQL := strSQL + '  FGO_DESS17 AS DESS17, ';
  strSQL := strSQL + '  FGO_DESS18 AS DESS18, ';
  strSQL := strSQL + '  FGO_DESS19 AS DESS19, ';
  strSQL := strSQL + '  FGO_DESS20 AS DESS20, ';
  strSQL := strSQL + '  FGO_DESS21 AS DESS21, ';
  strSQL := strSQL + '  FGO_DESS22 AS DESS22, ';
  strSQL := strSQL + '  FGO_DESS23 AS DESS23, ';
  strSQL := strSQL + '  FGO_DESS24 AS DESS24, ';
  strSQL := strSQL + '  FGO_DESS25 AS DESS25, ';
  strSQL := strSQL + '  FGO_DESS26 AS DESS26, ';
  strSQL := strSQL + '  FGO_DESS27 AS DESS27, ';
  strSQL := strSQL + '  FGO_DESS28 AS DESS28, ';
  strSQL := strSQL + '  FGO_DESS29 AS DESS29, ';
  strSQL := strSQL + '  FGO_DESS30 AS DESS30, ';

  strSQL := strSQL + '  LPAD("", 04, " ") AS STASER, ';
  strSQL := strSQL + '  FGO_STAS01 AS STAS01, ';
  strSQL := strSQL + '  FGO_STAS02 AS STAS02, ';
  strSQL := strSQL + '  FGO_STAS03 AS STAS03, ';
  strSQL := strSQL + '  FGO_STAS04 AS STAS04, ';
  strSQL := strSQL + '  FGO_STAS05 AS STAS05, ';
  strSQL := strSQL + '  FGO_STAS06 AS STAS06, ';
  strSQL := strSQL + '  FGO_STAS07 AS STAS07, ';
  strSQL := strSQL + '  FGO_STAS08 AS STAS08, ';
  strSQL := strSQL + '  FGO_STAS09 AS STAS09, ';
  strSQL := strSQL + '  FGO_STAS10 AS STAS10, ';
  strSQL := strSQL + '  FGO_STAS11 AS STAS11, ';
  strSQL := strSQL + '  FGO_STAS12 AS STAS12, ';
  strSQL := strSQL + '  FGO_STAS13 AS STAS13, ';
  strSQL := strSQL + '  FGO_STAS14 AS STAS14, ';
  strSQL := strSQL + '  FGO_STAS15 AS STAS15, ';
  strSQL := strSQL + '  FGO_STAS16 AS STAS16, ';
  strSQL := strSQL + '  FGO_STAS17 AS STAS17, ';
  strSQL := strSQL + '  FGO_STAS18 AS STAS18, ';
  strSQL := strSQL + '  FGO_STAS19 AS STAS19, ';
  strSQL := strSQL + '  FGO_STAS20 AS STAS20, ';
  strSQL := strSQL + '  FGO_STAS21 AS STAS21, ';
  strSQL := strSQL + '  FGO_STAS22 AS STAS22, ';
  strSQL := strSQL + '  FGO_STAS23 AS STAS23, ';
  strSQL := strSQL + '  FGO_STAS24 AS STAS24, ';
  strSQL := strSQL + '  FGO_STAS25 AS STAS25, ';
  strSQL := strSQL + '  FGO_STAS26 AS STAS26, ';
  strSQL := strSQL + '  FGO_STAS27 AS STAS27, ';
  strSQL := strSQL + '  FGO_STAS28 AS STAS28, ';
  strSQL := strSQL + '  FGO_STAS29 AS STAS29, ';
  strSQL := strSQL + '  FGO_STAS30 AS STAS30, ';

  strSQL := strSQL + '  LPAD("", 04, " ") AS PRISMA, ';
  strSQL := strSQL + '  FGO_PRIS01 AS PRIS01, ';
  strSQL := strSQL + '  FGO_PRIS02 AS PRIS02, ';
  strSQL := strSQL + '  FGO_PRIS03 AS PRIS03, ';
  strSQL := strSQL + '  FGO_PRIS04 AS PRIS04, ';
  strSQL := strSQL + '  FGO_PRIS05 AS PRIS05, ';
  strSQL := strSQL + '  FGO_PRIS06 AS PRIS06, ';
  strSQL := strSQL + '  FGO_PRIS07 AS PRIS07, ';
  strSQL := strSQL + '  FGO_PRIS08 AS PRIS08, ';
  strSQL := strSQL + '  FGO_PRIS09 AS PRIS09, ';
  strSQL := strSQL + '  FGO_PRIS10 AS PRIS10, ';
  strSQL := strSQL + '  FGO_PRIS11 AS PRIS11, ';
  strSQL := strSQL + '  FGO_PRIS12 AS PRIS12, ';
  strSQL := strSQL + '  FGO_PRIS13 AS PRIS13, ';
  strSQL := strSQL + '  FGO_PRIS14 AS PRIS14, ';
  strSQL := strSQL + '  FGO_PRIS15 AS PRIS15, ';
  strSQL := strSQL + '  FGO_PRIS16 AS PRIS16, ';
  strSQL := strSQL + '  FGO_PRIS17 AS PRIS17, ';
  strSQL := strSQL + '  FGO_PRIS18 AS PRIS18, ';
  strSQL := strSQL + '  FGO_PRIS19 AS PRIS19, ';
  strSQL := strSQL + '  FGO_PRIS20 AS PRIS20, ';
  strSQL := strSQL + '  FGO_PRIS21 AS PRIS21, ';
  strSQL := strSQL + '  FGO_PRIS22 AS PRIS22, ';
  strSQL := strSQL + '  FGO_PRIS23 AS PRIS23, ';
  strSQL := strSQL + '  FGO_PRIS24 AS PRIS24, ';
  strSQL := strSQL + '  FGO_PRIS25 AS PRIS25, ';
  strSQL := strSQL + '  FGO_PRIS26 AS PRIS26, ';
  strSQL := strSQL + '  FGO_PRIS27 AS PRIS27, ';
  strSQL := strSQL + '  FGO_PRIS28 AS PRIS28, ';
  strSQL := strSQL + '  FGO_PRIS29 AS PRIS29, ';
  strSQL := strSQL + '  FGO_PRIS30 AS PRIS30, ';

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
  strSQL := strSQL + '  FGO_QTDS01 AS QTDS01, ';
  strSQL := strSQL + '  FGO_QTDS02 AS QTDS02, ';
  strSQL := strSQL + '  FGO_QTDS03 AS QTDS03, ';
  strSQL := strSQL + '  FGO_QTDS04 AS QTDS04, ';
  strSQL := strSQL + '  FGO_QTDS05 AS QTDS05, ';
  strSQL := strSQL + '  FGO_QTDS06 AS QTDS06, ';
  strSQL := strSQL + '  FGO_QTDS07 AS QTDS07, ';
  strSQL := strSQL + '  FGO_QTDS08 AS QTDS08, ';
  strSQL := strSQL + '  FGO_QTDS09 AS QTDS09, ';
  strSQL := strSQL + '  FGO_QTDS10 AS QTDS10, ';
  strSQL := strSQL + '  FGO_QTDS11 AS QTDS11, ';
  strSQL := strSQL + '  FGO_QTDS12 AS QTDS12, ';
  strSQL := strSQL + '  FGO_QTDS13 AS QTDS13, ';
  strSQL := strSQL + '  FGO_QTDS14 AS QTDS14, ';
  strSQL := strSQL + '  FGO_QTDS15 AS QTDS15, ';
  strSQL := strSQL + '  FGO_QTDS16 AS QTDS16, ';
  strSQL := strSQL + '  FGO_QTDS17 AS QTDS17, ';
  strSQL := strSQL + '  FGO_QTDS18 AS QTDS18, ';
  strSQL := strSQL + '  FGO_QTDS19 AS QTDS19, ';
  strSQL := strSQL + '  FGO_QTDS20 AS QTDS20, ';
  strSQL := strSQL + '  FGO_QTDS21 AS QTDS21, ';
  strSQL := strSQL + '  FGO_QTDS22 AS QTDS22, ';
  strSQL := strSQL + '  FGO_QTDS23 AS QTDS23, ';
  strSQL := strSQL + '  FGO_QTDS24 AS QTDS24, ';
  strSQL := strSQL + '  FGO_QTDS25 AS QTDS25, ';
  strSQL := strSQL + '  FGO_QTDS26 AS QTDS26, ';
  strSQL := strSQL + '  FGO_QTDS27 AS QTDS27, ';
  strSQL := strSQL + '  FGO_QTDS28 AS QTDS28, ';
  strSQL := strSQL + '  FGO_QTDS29 AS QTDS29, ';
  strSQL := strSQL + '  FGO_QTDS30 AS QTDS30, ';

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

  strSQL := strSQL + '  CAST(                                                 ';
  strSQL := strSQL + '    (SELECT                                             ';
  strSQL := strSQL + '      GROUP_CONCAT(                                     ';
  strSQL := strSQL + '        DISTINCT CONCAT(                                ';
  strSQL := strSQL + '          FDO_NUMFAT,                                   ';
  strSQL := strSQL + '          "-",                                          ';
  strSQL := strSQL + '          FDO_TIPFAT,                                   ';
  strSQL := strSQL + '          "-",                                          ';
  strSQL := strSQL + '          FDO_EMPFAT                                    ';
  strSQL := strSQL + '        )                                               ';
  strSQL := strSQL + '      )                                                 ';
  strSQL := strSQL + '    FROM                                                ';
  strSQL := strSQL + '      FATDOR                                            ';
  strSQL := strSQL + '    WHERE FDO_SEQGER = FATGOR.AUTOINCREM                ';
  strSQL := strSQL + '      AND FDO_CODITE IN                                 ';
  strSQL := strSQL + '      (SELECT                                           ';
  strSQL := strSQL + '        SIS_VALCFG                                      ';
  strSQL := strSQL + '      FROM                                              ';
  strSQL := strSQL + '        CFGSIS                                          ';
  strSQL := strSQL + '      WHERE SIS_CODCFG IN ("CFG_ITESER", "CFG_SERTER")  ';
  strSQL := strSQL + '        AND SIS_CODEMP = FDO_CODEMP)) AS CHAR(100)      ';
  strSQL := strSQL + '  ) AS DOCFAT,                                          ';

  strSQL := strSQL + '  FGO_MEN001 AS MEN001, ';
  strSQL := strSQL + '  FGO_MEN002 AS MEN002, ';
  strSQL := strSQL + '  FGO_MENEXP AS MENEXP, ';
  strSQL := strSQL + '  FGO_MENEX2 AS MENEX2, ';
  strSQL := strSQL + '  FGO_MENEX3 AS MENEX3, ';
  strSQL := strSQL + '  FGO_MENEX4 AS MENEX4  ';

  strSQL := strSQL + 'FROM     ';
  strSQL := strSQL + '  FATGOR ';
  strSQL := strSQL + '  INNER JOIN SERGOR ON SERGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ';
  strSQL := strSQL + '  INNER JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ';
  strSQL := strSQL + '  INNER JOIN CADVEI ON VEI_PLAVEI = FGO_PLAVEI ';
  strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = FGO_CODCLI ';

  strSQL := strSQL + '  LEFT JOIN CORVEI ON VEI_CODCOR = COR_CODCOR ';
  strSQL := strSQL + '  LEFT JOIN MARVEI ON VEI_CODMAR = MAR_CODMAR ';
  strSQL := strSQL + '  LEFT JOIN MODVEI ON VEI_CODMOD = MOD_CODMOD ';

  strSQL := strSQL + '  LEFT JOIN CADSER S1  ON S1.SER_CODSER  = FGO_CODS01 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S2  ON S2.SER_CODSER  = FGO_CODS02 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S3  ON S3.SER_CODSER  = FGO_CODS03 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S4  ON S4.SER_CODSER  = FGO_CODS04 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S5  ON S5.SER_CODSER  = FGO_CODS05 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S6  ON S6.SER_CODSER  = FGO_CODS06 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S7  ON S7.SER_CODSER  = FGO_CODS07 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S8  ON S8.SER_CODSER  = FGO_CODS08 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S9  ON S9.SER_CODSER  = FGO_CODS09 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S10 ON S10.SER_CODSER = FGO_CODS10 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S11 ON S11.SER_CODSER = FGO_CODS11 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S12 ON S12.SER_CODSER = FGO_CODS12 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S13 ON S13.SER_CODSER = FGO_CODS13 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S14 ON S14.SER_CODSER = FGO_CODS14 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S15 ON S15.SER_CODSER = FGO_CODS15 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S16 ON S16.SER_CODSER = FGO_CODS16 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S17 ON S17.SER_CODSER = FGO_CODS17 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S18 ON S18.SER_CODSER = FGO_CODS18 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S19 ON S19.SER_CODSER = FGO_CODS19 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S20 ON S20.SER_CODSER = FGO_CODS20 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S21 ON S21.SER_CODSER = FGO_CODS21 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S22 ON S22.SER_CODSER = FGO_CODS22 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S23 ON S23.SER_CODSER = FGO_CODS23 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S24 ON S24.SER_CODSER = FGO_CODS24 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S25 ON S25.SER_CODSER = FGO_CODS25 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S26 ON S26.SER_CODSER = FGO_CODS26 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S27 ON S27.SER_CODSER = FGO_CODS27 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S28 ON S28.SER_CODSER = FGO_CODS28 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S29 ON S29.SER_CODSER = FGO_CODS29 ';
  strSQL := strSQL + '  LEFT JOIN CADSER S30 ON S30.SER_CODSER = FGO_CODS30 ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  FGO_CODEMP =  :CODEMP AND ';
  strSQL := strSQL + '  FGO_DTAENT >= :DIAEXI AND ';
  strSQL := strSQL + '  FGO_ESPDOC = "PD" AND ';
  strSQL := strSQL + '  NOT (FGO_JAFATU = 1 AND IFNULL(FGO_MOTBAI, "") <> "") ';

  If blnAgendamento Then
    strSQL := strSQL + '  AND FGO_DTAGES > 0 ';

  If Not chkPedFat.EditValue Then
    strSQL := strSQL + '  AND FGO_JAFATU = 0 ';

  Result := strSQL;
End;

procedure TfrmConsultaServicosAutocenter.imgcbxStaSerPropertiesChange(
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

function TfrmConsultaServicosAutocenter.fCarregarMecanicosServico(strAutInc, strIdeSer: String): String;
begin
  Result := fCampoTabela('GROUP_CONCAT(FGO_CODMEC)', 'MECGOR', ['FGO_SEQFGO', 'FGO_IDESER'], [strAutInc, strIdeSer]);
end;

function TfrmConsultaServicosAutocenter.fCarregarMecanicosProdutosObs(strAutInc,
  strCODMEC: String): TStringList;
var
  stlCodMec: TStringList;
  intCount: Integer;
begin

  Result := TStringList.Create;

  stlCodMec := TStringList.Create;
  stlCodMec.CommaText := strCODMEC;

  for intCount := 0 to stlCodMec.Count -1 do
  begin
    Result.Add(fCampoTabela('FDO_OBSMEC', 'MECDOR', ['FDO_SEQFDO', 'FDO_CODMEC'], [strAutInc, stlCodMec[intCount]]));
  end;

  FreeAndNil(stlCodMec);
end;

function TfrmConsultaServicosAutocenter.fCarregarMecanicosServicoObs(strAutInc, strCODMEC: String): TStringList;
var
  stlCodMec: TStringList;
  intCount: Integer;
begin

  Result := TStringList.Create;

  stlCodMec := TStringList.Create;
  stlCodMec.CommaText := strCODMEC;

  for intCount := 0 to stlCodMec.Count -1 do
  begin
    Result.Add(fCampoTabela('FGO_OBSMEC', 'MECGOR', ['FGO_SEQFGO', 'FGO_CODMEC'], [strAutInc, stlCodMec[intCount]]));
  end;

  FreeAndNil(stlCodMec);

end;

end.
