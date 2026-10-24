unit untCadCanhotosNF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, Mask,
  MaskEditFocus, EditFocus, DateUtils, StrUtils, Provider, DBClient, frxClass,
  frxExportCSVTestabilidade, MemDS, DBAccess, Uni, UniDataSetProvider, UniClientDataSet,
  cxDataControllerConditionalFormattingRulesManagerDialog, System.UITypes;

type
  TfrmCadCanhotosNF = class(TfrmPai)
    pnlPrincipal: TPanel;
    grpFiltros: TGroupBox;
    grpCanhotos: TGroupBox;
    grdCanhotosNFs: TcxGridDBTableView;
    glvCanhotosNFs: TcxGridLevel;
    cxgrdCanhotosNFs: TcxGrid;
    Label4: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    Label2: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label3: TLabel;
    mskDtaFin: TMaskEditFocus;
    rgdTipo: TRadioGroup;
    rgdCanhotos: TRadioGroup;
    btnSelTodos: TBitBtnLocked;
    btnRecebidos: TBitBtnLocked;
    clmCanhotosNFsData: TcxGridDBColumn;
    clmCanhotosNFsHora: TcxGridDBColumn;
    clmCanhotosNFsDocumento: TcxGridDBColumn;
    clmCanhotosNFsSerie: TcxGridDBColumn;
    clmCanhotosNFsForCli: TcxGridDBColumn;
    clmCanhotosNFsDesForCli: TcxGridDBColumn;
    clmCanhotosNFsEntSai: TcxGridDBColumn;
    clmCanhotosNFsStatus: TcxGridDBColumn;
    btnAtualizarFiltro: TBitBtnLocked;
    dtsCanhotos: TDataSource;
    clmCanhotosNFsAutoincrem: TcxGridDBColumn;
    clmCanhotosNFsMarDes: TcxGridDBColumn;
    btnPendentes: TBitBtnLocked;
    clmCanhotosNFsVendedor: TcxGridDBColumn;
    pnlFiltrosControleCanhoto: TPanel;
    pnlDataCanhoto: TPanel;
    Label1: TLabel;
    mskDtcIni: TMaskEditFocus;
    mskDtcFin: TMaskEditFocus;
    Label5: TLabel;
    pnlNomeCanhoto: TPanel;
    Label6: TLabel;
    edtNomCht: TEditFocus;
    clmCanhotosNfsDtaCht: TcxGridDBColumn;
    clmCanhotosNFsNomCht: TcxGridDBColumn;
    pnlFiltrosGerais: TPanel;
    procedure FormShow(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAtualizarFiltroClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnSelTodosClick(Sender: TObject);
    procedure grdCanhotosNFsCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure grdCanhotosNFsCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure grdCanhotosNFsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure rgdCanhotosExit(Sender: TObject);
    procedure btnRecebidosClick(Sender: TObject);
    procedure btnPendentesClick(Sender: TObject);
  private
    { Private declarations }
    qryConEmp  : TUniQuery;
    cdsCanhotos: TUniClientDataSet;
    dspCanhotos: TUniDataSetProvider;
    qryCanhotos: TUniQuery;
    blnControlarDadosPreenchimento: Boolean;
    procedure pCarregaEmpresa;
    function fGetSQL: String;
    procedure pExecutaSQL;
    procedure pAtualizarSituacao(strSituacao:String);
    procedure pSelecionaCanhoto;
    procedure pSelecionarTodos;
    procedure pLimparGrid;
    procedure pMarcaCanhoto(blnMarcar: Boolean);
    procedure pAdicionarDadosCanhoto(dtaDtaCht: TDate; strNomCht: String);
    procedure pConfigurarExibirExibicaoUtilizarDadosPreenchimento;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function ObterDadosCanhoto(const dtaDtaEmi: TDate; Out dtaDtaCht: TDate; Out strNomCht: String): Boolean;
  public
    procedure AfterConstruction;override;
    { Public declarations }
  end;

implementation

uses untFuncoesSimples, untConsultas, untPesqAux, untModulo, untTypesSistema, untDigDadosCanhoto;

{$R *.dfm}

procedure TfrmCadCanhotosNF.AfterConstruction;
begin
  inherited;
  pConfigurarExibirExibicaoUtilizarDadosPreenchimento;
end;

procedure TfrmCadCanhotosNF.btnAtualizarFiltroClick(Sender: TObject);
begin
  inherited;

  pExecutaSQL();
end;

procedure TfrmCadCanhotosNF.btnPendentesClick(Sender: TObject);
begin
  inherited;
  pAtualizarSituacao('N');
end;

procedure TfrmCadCanhotosNF.btnRecebidosClick(Sender: TObject);
begin
  inherited;
  pAtualizarSituacao('S');
end;

procedure TfrmCadCanhotosNF.btnSelTodosClick(Sender: TObject);
begin
  inherited;

  pSelecionarTodos();
end;

procedure TfrmCadCanhotosNF.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;

  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadCanhotosNF.fGetSQL: String;
begin
  Result := 'SELECT F.AUTOINCREM, "D" AS MARDES, ';
  Result := Result + '     FIS_DTAENT AS DTAENT, ';
  Result := Result + '     GER_HORENT AS HOREMI, ';
  Result := Result + '     CONCAT(FIS_NUMDOC, "-", FIS_ESPDOC, "-", FIS_CODEMP) AS NUMDOC, ';
  Result := Result + '     FIS_SERIE_ AS SERIE_, ';
  Result := Result + '     FIS_TIP_FC AS TIP_FC, ';
  Result := Result + '     IF(FIS_TIP_FC = "C", CONCAT(CLI_CODCLI, "-", CLI_NOMCLI), CONCAT(FOR_CODFOR, "-", FOR_NOMFOR)) AS FORCLI, ';
  Result := Result + '     FIS_ENTSAI AS ENTSAI, ';
  Result := Result + '     IF(IFNULL(FIS_CNHREC, "N") = "N", "PENDENTE", "RECEBIDO") AS CNHREC, ';
  Result := Result + '     CONCAT( OPE_CODOPE,"-",IFNULL(OPE_NOMOPE,"")) AS VENDEDOR, ';
  Result := Result + '     FIS_DTACHT AS DTACHT, ';
  Result := Result + '     FIS_NOMCHT AS NOMCHT  ';
  Result := Result + 'FROM CADFIS F ';
  Result := Result + '        LEFT  JOIN CADCLI ON CLI_CODCLI = FIS_FORCLI AND FIS_TIP_FC = "C" ';
  Result := Result + '        LEFT  JOIN CADFOR ON FOR_CODFOR = FIS_FORCLI AND FIS_TIP_FC = "F" ';
  Result := Result + '        INNER JOIN MOVGER ON GER_NUMDOC = FIS_NUMDOC ';
  Result := Result + '                         AND GER_ESPDOC = FIS_ESPDOC ';
  Result := Result + '                         AND GER_CODEMP = FIS_CODEMP ';
  Result := Result + '                         AND IF(FIS_TIP_FC = "C", GER_CODCLI, GER_CODFOR) = FIS_FORCLI ';
  Result := Result + '                         AND GER_SERIE_ = FIS_SERIE_ ';
  Result := Result + '                         AND GER_TIP_FC = FIS_TIP_FC ';
  Result := Result + '        INNER JOIN CADOPE ON OPE_CODOPE = GER_CODVEN ';

  Result := Result + '        INNER JOIN CADTRA ON TRA_CODTRA = GER_CODTRA AND TRA_CNHREC <> "N"';

  Result := Result + 'WHERE FIS_ORIDOC = "V" ';
  Result := Result + '  AND FIS_ESPDOC IN ("NF", "EL", "NV", "NS") ';

  If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)))
    And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then Begin
    Result := Result + '  AND FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN ';
  End;

  If (Not fEmptyStr(edtCodEmp.Text)) Then Begin
    Result := Result + '  AND FIS_CODEMP = :CODEMP ';
  End;

  If (rgdTipo.ItemIndex <> 2) Then Begin
    Result := Result + '  AND FIS_ENTSAI = :ENTSAI ';
  End;

  If (rgdCanhotos.ItemIndex <> 2) Then Begin
    Result := Result + '  AND FIS_CNHREC = :CNHREC ';
  End;

  {$Region 'Filtros dos campos de preenchimento do canhoto'}
  if pnlFiltrosControleCanhoto.Visible then
  begin
    If      (Not fEmptyStr(fTiraCaracEspeciais(mskDtcIni.Text)))
        And (Not fEmptyStr(fTiraCaracEspeciais(mskDtcFin.Text))) Then
    Begin
      Result := Result + '  AND FIS_DTACHT BETWEEN :DTCINI AND :DTCFIN ';
    End;

    If Not fEmptyStr(edtNomCht.Text) Then
    Begin
      Result := Result + '  AND UPPER(FIS_NOMCHT) LIKE  UPPER('+QuotedStr(edtNomCht.Text)+') ';
    End;
  end;
  {$EndRegion 'Filtros dos campos de preenchimento do canhoto'}

  Result := Result + 'UNION ALL ' + AnsiReplaceStr(Result, 'MOVGER', 'NOTGER');
end;

procedure TfrmCadCanhotosNF.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  FreeAndNil(qryConEmp);
  FreeAndNil(cdsCanhotos);
  FreeAndNil(dspCanhotos);
  FreeAndNil(qryCanhotos);
end;

procedure TfrmCadCanhotosNF.FormCreate(Sender: TObject);
begin
  inherited;
  blnControlarDadosPreenchimento := fCfgSis('CCFSDN', varBoolean);
  dspCanhotos := TUniDataSetProvider.Create(Self);
  cdsCanhotos := TUniClientDataSet.Create(Self);

  qryCanhotos := fCriaQuery;

  dspCanhotos.DataSet := qryCanhotos;
  cdsCanhotos.SetProvider(dspCanhotos);
  dtsCanhotos.DataSet := cdsCanhotos;

  qryConEmp   := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);
end;

procedure TfrmCadCanhotosNF.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case (Key) Of
    VK_F4 : pSelecionarTodos();
    VK_F5: pAtualizarSituacao('S');
    VK_F6: pAtualizarSituacao('N');
    VK_F7 : pExecutaSQL();
  End;
end;

procedure TfrmCadCanhotosNF.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIni);

  mskDtaIni.Text := FormatDateTime('dd/MM/yyyy', EncodeDate(YearOf(VS_Date), MonthOf(VS_Date), 01));
  mskDtaFin.Text := FormatDateTime('dd/MM/yyyy', EndOfTheMonth(VS_Date));

  If (Not fEmptyStr(VS_strCodEmp)) Then Begin
    edtCodEmp.Text := VS_strCodEmp;
    pCarregaEmpresa;
  End;
end;

function TfrmCadCanhotosNF.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then Begin
    If (Sender = mskDtaIni) Then Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End Else If (Sender = mskDtaFin) Then Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then Begin
        If (fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&Ok']);
          Result := False;
        End Else If (Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text)) Then Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&Ok']);
          Result := False;
        End;
      End;
    End Else If (Sender = edtCodEmp) Then Begin
      If fEmptyStr(edtCodEmp.Text) Then Begin
        edtNomEmp.Text := 'TODAS';
      End Else Begin
        pCarregaEmpresa;

        If (qryConEmp.FieldByName('EMP_CODEMP').IsNull) Then Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End;
    End;

    {$Region 'validação dos campos de preenchimento do canhoto'}
    if Result and pnlFiltrosControleCanhoto.Visible then
    begin
      If (Sender = mskDtcFin) Then
      Begin
        if Not (fEmptyStr(fTiraCaracEspeciais(mskDtcFin.Text)))  then
          begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtcIni.Text)) Then
          begin
            fMensagem('ATENÇÃO!', 'A data inicial do canhoto deve ser preenchida!', ['&Ok']);
            Result := False;
          end
          else  If (Not fEmptyStr(fTiraCaracEspeciais(mskDtcIni.Text))) Then
          Begin
            If (fEmptyStr(fTiraCaracEspeciais(mskDtcFin.Text))) Then
            Begin
              fMensagem('ATENÇÃO!', 'A data final do canhoto deve ser preenchida!', ['&Ok']);
              Result := False;
            End
            Else If (Not fValidaPeriodo(mskDtcIni.Text, mskDtcFin.Text)) Then
            Begin
              fMensagem('ATENÇÃO!', 'A data final do canhoto deve ser maior ou igual a sua data inicial!', ['&Ok']);
              Result := False;
            End;
          End;
        end;
      End;
    end;
    {$EndRegion 'validação dos campos de preenchimento do canhoto'}
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadCanhotosNF.grdCanhotosNFsCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;

  pSelecionaCanhoto();
end;

procedure TfrmCadCanhotosNF.grdCanhotosNFsCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If (Not cdsCanhotos.Active) Then
    Exit;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, clmCanhotosNFsMarDes.Index]) = 'M' Then
  Begin
    If ACanvas.Brush.Color = clHighlight Then
      ACanvas.Font.Color  := clLime
    Else
      ACanvas.Brush.Color := clSkyBlue;
  End;

  If ACanvas.Brush.Color <> clHighlight Then
  Begin
    If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, clmCanhotosNFsStatus.Index]) = 'PENDENTE' Then
      ACanvas.Font.Color := clBlack
    Else If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, clmCanhotosNFsStatus.Index]) = 'RECEBIDO' Then
      ACanvas.Font.Color := clBlue;
  End;

end;

procedure TfrmCadCanhotosNF.grdCanhotosNFsKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_Return) Or (Key = VK_SPACE) Then Begin
    pSelecionaCanhoto();
  End;
end;

function TfrmCadCanhotosNF.ObterDadosCanhoto(const dtaDtaEmi: TDate;
  out dtaDtaCht: TDate; out strNomCht: String): Boolean;
begin
  Result := False;
  dtaDtaCht := 0;
  strNomCht := EmptyStr;
  pCriarFormularios(TfrmDigDadosCanhoto, frmDigDadosCanhoto);
  Try
     frmDigDadosCanhoto.dtaDtaEmi := dtaDtaEmi;
     frmDigDadosCanhoto.ShowModal;
     if frmDigDadosCanhoto.modalresult = mrOk then
     begin
       Result := True;
       dtaDtaCht := frmDigDadosCanhoto.dtaDtaCht;
       strNomCht := frmDigDadosCanhoto.strNomCht;
     end;
  Finally
    pFreeAndNil(frmDigDadosCanhoto);
  End;
end;

procedure TfrmCadCanhotosNF.pAdicionarDadosCanhoto(dtaDtaCht: TDate;
  strNomCht: String);
begin
  if cdsCanhotos.isEmpty then
    Exit;

  if Not (cdsCanhotos.state = dsEdit) then
    cdsCanhotos.Edit;
  cdsCanhotos.FieldByName('DTACHT').AsDateTime := dtaDtaCht;
  cdsCanhotos.FieldByName('NOMCHT').AsString := strNomCht;
  cdsCanhotos.post;
end;

procedure TfrmCadCanhotosNF.pAtualizarSituacao(strSituacao:String);
var strMsgConfirmacao: String;

  function fGetSQLUpdateCadFis(strAutoincrem: String): String;
  begin
    Result := 'UPDATE CADFIS SET FIS_CNHREC = "' + strSituacao + '" ';

    {$Region 'inserindo parâmetros correspondentes aos filtros de preenchimento do canhoto'}
    if blnControlarDadosPreenchimento then
    begin
      Result := Result + ', FIS_DTACHT = :DTACHT ';
      Result := Result + ', FIS_NOMCHT = :NOMCHT ';
    end;
    {$EndRegion 'inserindo parâmetros correspondentes aos filtros de preenchimento do canhoto'}

    Result := Result + ' WHERE AUTOINCREM = "' + strAutoincrem + '" ';
  end;

  var
    qryAtualizacao: TUniQuery;
    cdsAtualizacao: TUniClientDataSet;
begin
  if strSituacao = 'S' then
    strMsgConfirmacao := 'A situação dos canhotos será atualizada para "RECEBIDO"'+#13+'Confirma a operação?'
  else
    strMsgConfirmacao := 'A situação dos canhotos será atualizada para "PENDENTE"'+#13+'Confirma a operação?';

  If (cdsCanhotos.IsEmpty) Then Begin
    fMensagem('Aviso', 'Não há canhotos para atualização!', ['&Ok']);
    Exit;
  End;

  pnlInfo.Caption := 'Aguarde, atualizando situação dos canhotos...';
  Application.ProcessMessages();

  qryAtualizacao := fCriaQuery(Self);
  cdsAtualizacao := TUniClientDataSet.Create(Self);

  Try
    cdsAtualizacao.Data  := cdsCanhotos.Data;
    cdsAtualizacao.Filtered := False;
    cdsAtualizacao.Filter   := 'MARDES = ' + QuotedStr('M');
    cdsAtualizacao.Filtered := True;

    If (cdsAtualizacao.IsEmpty) Then Begin
      fMensagem('Aviso', 'Não há canhotos selecionados para atualização!', ['&Ok']);
      Exit;
    End;

    Try
      If (fMensagem('CONFIRMAÇÃO', strMsgConfirmacao , ['&Sim', '&Não']) = 1) Then Begin
        cdsAtualizacao.First();

        While (Not cdsAtualizacao.Eof) Do Begin
          qryAtualizacao.Close();
          qryAtualizacao.SQL.Clear();
          qryAtualizacao.SQL.Text :=
            fGetSQLUpdateCadFis(cdsAtualizacao.FieldByName('AUTOINCREM').AsString);

          if blnControlarDadosPreenchimento then
          begin
            if cdsAtualizacao.Fieldbyname('DTACHT').AsDatetime > 0 then
              qryAtualizacao.parambyname('DTACHT').AsDateTime := cdsAtualizacao.Fieldbyname('DTACHT').AsDatetime
            else
              qryAtualizacao.parambyname('DTACHT').Value := Null;

            if fEmptyStr(cdsAtualizacao.FieldByname('NOMCHT').AsString) then
              qryAtualizacao.parambyname('NOMCHT').Value := Null
            else
              qryAtualizacao.parambyname('NOMCHT').AsString := cdsAtualizacao.Fieldbyname('NOMCHT').AsString;

          end;
          qryAtualizacao.ExecSQL();

          cdsAtualizacao.Next();
        End;

        fMensagem('Aviso', 'Canhotos atualizados com sucesso!', ['&Ok']);

        pLimparGrid();

        pSetFocus(mskDtaIni);
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmCadCanhotosNF.pAtualizarSituacao]');
    End;
  Finally
    pnlInfo.Caption := '';
    Application.ProcessMessages();

    FreeAndNil(qryAtualizacao);
    FreeAndNil(cdsAtualizacao);
  End;
end;

procedure TfrmCadCanhotosNF.pCarregaEmpresa;
begin
  pPesquisaCadEmp(qryConEmp, qryConEmp, edtCodEmp.Text);

  With qryConEmp Do Begin
    edtNomEmp.Text := FieldByName('EMP_NOMEMP').AsString;
  End;
end;

procedure TfrmCadCanhotosNF.pConfigurarExibirExibicaoUtilizarDadosPreenchimento;
  Var
    idx,
    intEncontrados: Integer;
begin
  if blnControlarDadosPreenchimento then
    Self.Width := 1060
  else
    Self.width  := 800;

  pnlFiltrosControleCanhoto.Visible := blnControlarDadosPreenchimento;
  intEncontrados := 0;
  for idx := 0 to grdCanhotosNFs.ColumnCount -1 do
  begin
    If IndexStr(grdCanhotosNFs.Columns[idx].DataBinding.FieldName, ['DTACHT', 'NOMCHT']) >= 0 then
    begin
      grdCanhotosNFs.Columns[idx].Visible := blnControlarDadosPreenchimento;
      inc(intEncontrados);
      IF intEncontrados = 2 then
        Break;
    end;
  end;
end;

procedure TfrmCadCanhotosNF.pExecutaSQL;

  procedure pFormataCampos(DataSet: TDataSet);
    Var
      intIndex: integer;
  Begin
    If DataSet.Active Then
      With DataSet, Fields Do
      For intIndex := 0 To Count - 1 Do Begin
        If Fields[intIndex].FieldName <> 'FORCLI' Then
          TStringField(Fields[intIndex]).Alignment := taCenter;
      End;
  end;

begin
  If (Not fValidaCampos(mskDtaIni)) Or (Not fValidaCampos(mskDtaFin))
    Or (Not fValidaCampos(edtCodEmp)) Then Begin
    Exit;
  End;

  {$Region 'validação dos campos de preenchimento do canhoto'}
  if pnlFiltrosControleCanhoto.Visible then
  begin
    If Not fValidaCampos(mskDtcFin)Then
      Exit;
  end;
  {$EndRegion 'validação dos campos de preenchimento do canhoto'}

  pnlInfo.Caption := 'Aguarde, atualizando dados...';
  Application.ProcessMessages();

  If (Not cdsCanhotos.IsEmpty) And (cdsCanhotos.Active) Then Begin
    cdsCanhotos.EmptyDataSet();
  End;

  cdsCanhotos.Close();

  qryCanhotos.Close();
  qryCanhotos.SQL.Clear();
  qryCanhotos.SQL.Text := fGetSQL();

  If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)))
    And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then Begin
    qryCanhotos.ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
    qryCanhotos.ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
  End;

  If (Not fEmptyStr(edtCodEmp.Text)) Then Begin
    qryCanhotos.ParamByName('CODEMP').AsString := edtCodEmp.Text;
  End;

  If (rgdTipo.ItemIndex <> 2) Then Begin
    Case (rgdTipo.ItemIndex) Of
      0: qryCanhotos.ParamByName('ENTSAI').AsString := 'E';
      1: qryCanhotos.ParamByName('ENTSAI').AsString := 'S';
    End;
  End;

  If (rgdCanhotos.ItemIndex <> 2) Then Begin
    Case (rgdCanhotos.ItemIndex) Of
      0: qryCanhotos.ParamByName('CNHREC').AsString := 'N';
      1: qryCanhotos.ParamByName('CNHREC').AsString := 'S';
    End;
  End;

  {$Region 'Preenchendo parâmetros correspondentes aos filtros de preenchimento do canhoto'}
  if pnlFiltrosControleCanhoto.Visible then
  begin
    If      (Not fEmptyStr(fTiraCaracEspeciais(mskDtcIni.Text)))
        And (Not fEmptyStr(fTiraCaracEspeciais(mskDtcFin.Text))) Then
    Begin
      qryCanhotos.ParamByName('DTCINI').AsDateTime := StrToDate(mskDtcIni.Text);
      qryCanhotos.ParamByName('DTCFIN').AsDateTime := StrToDate(mskDtcFin.Text);
    End;
  end;
  {$EndRegion 'Preenchendo parâmetros correspondentes aos filtros de preenchimento do canhoto'}

  qryCanhotos.Open;
  pSetaClient(qryCanhotos);

  dspCanhotos.DataSet := qryCanhotos;
  cdsCanhotos.SetProvider(dspCanhotos);
  cdsCanhotos.Open;
  pSetaClient(cdsCanhotos);
  pFormataCampos(cdsCanhotos);

  If (qryCanhotos.IsEmpty) Then Begin
    fMensagem('Aviso', 'Não há canhotos para visualização!', ['&Ok']);
    pSetFocus(mskDtaIni);
  End;

  pnlInfo.Caption := '';
  Application.ProcessMessages();
end;

procedure TfrmCadCanhotosNF.pLimparGrid;
begin
  If (Not cdsCanhotos.IsEmpty) And (cdsCanhotos.Active) Then Begin
    cdsCanhotos.EmptyDataSet();
  End;

  cdsCanhotos.Close(); 
  qryCanhotos.Close();
end;

procedure TfrmCadCanhotosNF.pMarcaCanhoto(blnMarcar: Boolean);
begin
  Try
    With cdsCanhotos Do Begin
      Edit;
      FieldByName('MARDES').AsString := IIF(blnMarcar, 'M', 'D');
      Post;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmImpBoletoIndiv.pMarcaCanhoto]');
  End;
end;

procedure TfrmCadCanhotosNF.pSelecionaCanhoto();
  Var
    dtaDtaCht: TDate;
    strNomCht: String;
    blnMarcar: Boolean;
begin
  If (Not cdsCanhotos.Active) Or (cdsCanhotos.IsEmpty) Then Begin
    Exit;
  End;

  blnMarcar := cdsCanhotos.FieldByName('MARDES').AsString <> 'M';

  if blnMarcar then
  begin
    if blnControlarDadosPreenchimento then
    begin
      if not ObterDadosCanhoto(cdsCanhotos.FieldByName('DTAENT').AsDateTime, dtaDtaCht, strNomCht) Then
        Exit;

      pAdicionarDadosCanhoto(dtaDtaCht, strNomCht);
    end;
  end;

  pMarcaCanhoto(blnMarcar);
end;

procedure TfrmCadCanhotosNF.pSelecionarTodos;
Var
  dtaDtaEmi,
  dtaDtaCht: TDate;
  strNomCht: String;
  blnObterDadosCanhoto: Boolean;
begin
  If (Not cdsCanhotos.Active) Then
    Exit;
  blnObterDadosCanhoto :=  blnControlarDadosPreenchimento;
  Try
    cdsCanhotos.DisableControls;
    cdsCanhotos.First;
    {$Region 'Obtendo dados do canhoto'}
    if  blnObterDadosCanhoto then
    begin
      dtaDtaEmi := 0;
      //percorrendo grid para identificar a data mais recente - data do canhoto não poderá ser anterior a esta.
      While Not cdsCanhotos.Eof do
      begin
        if cdsCanhotos.FieldByName('DTAENT').AsDateTime > dtaDtaEmi then
          dtaDtaEmi := cdsCanhotos.FieldByName('DTAENT').AsDateTime;

        cdsCanhotos.Next;
      end;

      if not ObterDadosCanhoto(dtaDtaEmi, dtaDtaCht, strNomCht) Then
         Exit;

      cdsCanhotos.First;

      //desabilitando para não solicitar dados novamente
      blnControlarDadosPreenchimento := False;
    end;
    {$EndRegion 'Obtendo dados do canhoto'}

    While (Not cdsCanhotos.Eof) Do
    Begin
      pSelecionaCanhoto();

      if blnObterDadosCanhoto then
      begin
        if cdsCanhotos.FieldByName('MARDES').AsString = 'M' then
        begin
          pAdicionarDadosCanhoto(dtaDtaCht, strNomCht);
        end;
      end;
      cdsCanhotos.Next;
    End;
  Finally
    blnControlarDadosPreenchimento := blnObterDadosCanhoto;
    cdsCanhotos.EnableControls;
  End;
end;

procedure TfrmCadCanhotosNF.rgdCanhotosExit(Sender: TObject);
begin
  inherited;

  pExecutaSQL();
end;

end.
