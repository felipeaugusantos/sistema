unit untCompromissos;

interface

uses
  Windows, Classes, Controls, untPaiSimples, AppEvnts, Menus, ComCtrls, StdCtrls,
  Buttons, ExtCtrls, EditFocus, Grids, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, Uni, UniClientDataSet, MemoFocus, frxClass,
  frxDMPExport, frxDBSet, BitBtnLockedIncrem, cxButtonEdit, cxLookAndFeels,
  cxLookAndFeelPainters, cxNavigator, frxExportCSVTestabilidade, Datasnap.DBClient,
  cxDataControllerConditionalFormattingRulesManagerDialog,untFuncoesRel, untFuncoesRel2;

type
  TfrmCompromissos = class(TfrmPaiSimples)
    pnl1: TPanel;
    pnl2: TPanel;
    edtSenha1: TEditFocus;
    lbl1: TLabel;
    edtNomOpe: TEditFocus;
    edtCodOpe: TEditFocus;
    lbl2: TLabel;
    pnlProgresso: TPanel;
    pnlDetalh: TPanel;
    pnlCalend: TPanel;
    grdCalend: TStringGrid;
    grdComproDBTableView1: TcxGridDBTableView;
    grdComproLevel1: TcxGridLevel;
    grdCompro: TcxGrid;
    grdComproDBTableView1Column1: TcxGridDBColumn;
    grdComproDBTableView1Column2: TcxGridDBColumn;
    grdComproDBTableView1Column3: TcxGridDBColumn;
    pnl5: TPanel;
    dtsCompro: TDataSource;
    cdsCompro: TUniClientDataSet;
    cdsComproCODOPE: TStringField;
    cdsComproDTACOM: TDateField;
    cdsComproHORCOM: TTimeField;
    cdsComproTITCOM: TStringField;
    cdsComproDESCOM: TMemoField;
    pnlMesAno: TPanel;
    cdsComproAUTOIN: TStringField;
    cdsComproCODEMP: TStringField;
    cdsComproBAIXAD: TStringField;
    mmoCompro: TMemoFocus;
    cdsComproCODOCO: TStringField;
    cxstylrpstry1: TcxStyleRepository;
    cxstylTitulo: TcxStyle;
    pnl3: TPanel;
    pnl4: TPanel;
    btnAnoAnt: TBitBtnLocked;
    btnMesAnt: TBitBtnLocked;
    btnMesPro: TBitBtnLocked;
    btnAnoPro: TBitBtnLocked;
    Panel1: TPanel;
    btnConfim: TBitBtnLocked;
    btnBaixar: TBitBtnLocked;
    btnImprim: TBitBtnLocked;
    pgbProgresso: TProgressBar;
    pnlSair: TPanel;
    btnSair1: TBitBtnLocked;
    btnGlobal: TBitBtnLocked;
    cdsComproOPECAD: TStringField;
    chkExibirBaixados: TCheckBox;
    chkTodosOperadores: TCheckBox;
    grdComproDBTableView1Column4: TcxGridDBColumn;
    grdComproDBTableViewBAIXAD: TcxGridDBColumn;
    cdsComproCLICOM: TStringField;
    cdsComproCATEGO: TStringField;
    cdsComproOBSERV: TMemoField;
    cdsComproNOMOPE: TStringField;
    cdsComproCOMPRO: TStringField;
    cdsComproNOMCLI: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure btnAnoAntClick(Sender: TObject);
    procedure btnMesAntClick(Sender: TObject);
    procedure btnMesProClick(Sender: TObject);
    procedure btnAnoProClick(Sender: TObject);
    procedure grdCalendDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure edtCodOpeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodOpeEnter(Sender: TObject);
    procedure edtCodOpeChange(Sender: TObject);
    procedure edtSenha1KeyPress(Sender: TObject; var Key: Char);
    procedure grdCalendDblClick(Sender: TObject);
    procedure grdCalendKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdCalendSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure btnConfimClick(Sender: TObject);
    procedure cdsComproAfterScroll(DataSet: TDataSet);
    procedure btnSair1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure grdComproDBTableView1DblClick(Sender: TObject);
    procedure grdComproDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnBaixarClick(Sender: TObject);
    procedure btnImprimClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnGlobalClick(Sender: TObject);
    procedure edtSenha1Exit(Sender: TObject);
    procedure grdComproDBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure chkExibirBaixadosClick(Sender: TObject);

  private
    { Private declarations }
    strDatSel: String;
    intMesSel: Integer;
    intAnoSel: Integer;
    dtaDatSel: TDateTime;
    dtaData01: TDatetime;
    tgrCelula: TGridRect;
    blnGravou: Boolean;

    function fBaixarCompromisso: Boolean;
    function fSelecionaData(intCol, intRow: Integer): Boolean;

    function fEhSabado(dtaDta:TDateTime): Boolean;
    function fEhDomingo(dtaDta:TDateTime): Boolean;

    procedure pNovoCompromisso;
    procedure pAlteraCompromisso;
    procedure pLimpaCalendario;
    procedure pLimpaCompromissos;
    procedure pCarregaCompromissos;
    procedure pMontaCalendario(dtaDatAtu: TDateTime);
    procedure pMarcarDiasComCompromissos;
    procedure pFiltraPorDataSelecionada(dtaDtaSel: TDateTime);

    procedure pListagemCompromissos;
    procedure pSetarData(Value: TDateTime);
    procedure pAtualizarCalendario;
    procedure pNovoCompromissoGlobal;
    procedure pPreencheCamposExibicao(APesquisarNomes: Boolean);
  public
  end;

Const
  SABADO = 7;
  DOMINGO = 1;

implementation

uses SysUtils, StrUtils, Forms, Graphics, DateUtils, untValorPorExtenso,
  untFuncoesSimples, untConsultas, untNovoCompromisso, untFatDigDatas,
  untCfgRel, untTypesSistema, untCompromissoGrupo, Variants;

{$R *.dfm}

{ TfrmCompromissos }

function fCheckParent(Sender, Parent: TWinControl): Boolean;
begin
  If Sender.Parent = nil Then
    Result := False
  Else If Sender.Parent = Parent Then
    Result := True
  Else
    Result := fCheckParent(Sender.Parent, Parent);
end;

procedure TfrmCompromissos.pSetarData(Value: TDateTime);
begin
  dtaDatSel := Value;
  intMesSel := MonthOf(Value);
  intAnoSel :=  YearOf(Value);
end;

procedure TfrmCompromissos.btnAnoAntClick(Sender: TObject);
begin
  pSetarData(IncYear(dtaDatSel, -1));
  pAtualizarCalendario;
end;

procedure TfrmCompromissos.btnAnoProClick(Sender: TObject);
begin
  pSetarData(IncYear(dtaDatSel, 1));
  pAtualizarCalendario;
end;

procedure TfrmCompromissos.btnMesAntClick(Sender: TObject);
begin
  pSetarData(IncMonth(dtaDatSel, -1));
  pAtualizarCalendario;
end;

procedure TfrmCompromissos.btnMesProClick(Sender: TObject);
begin
  pSetarData(IncMonth(dtaDatSel, 1));
  pAtualizarCalendario;
end;

procedure TfrmCompromissos.btnBaixarClick(Sender: TObject);
begin
  If Not btnBaixar.Enabled Then
    Exit;
  If fMensagem('AVISO', 'Deseja baixar compromisso?', ['&Sim', '&Não']) = 1 Then
  Begin
    If fBaixarCompromisso Then
    Begin
      fMensagem('', 'Compromisso baixado com sucesso!', ['&O k']);
      pLimpaCompromissos;
      pCarregaCompromissos;
      pMarcarDiasComCompromissos;
    End;
  End;
end;

procedure TfrmCompromissos.btnConfimClick(Sender: TObject);
  Var
    strSQL   : String;
    qryAgenda: TUniQuery;
    qryAgeCom: TUniQuery;
    blnInsert: Boolean;
begin
  If Not btnConfim.Enabled Then
    Exit;

  qryAgenda := Nil;
  qryAgeCom := Nil;
  Try
    qryAgenda := fCriaQuery(Self);
    qryAgeCom := fCriaQuery(Self);
    With cdsCompro Do
    Begin
      DisableControls;
      Filtered := False;
      First;

      fStartTransaction;

      While Not Eof Do
      Begin
        strSQL := '';
        strSQL := strSQL + 'SELECT                ';
        strSQL := strSQL + '  AUTOINCREM          ';
        strSQL := strSQL + 'FROM                  ';
        strSQL := strSQL + '  AGENDA              ';
        strSQL := strSQL + 'WHERE                 ';
        strSQL := strSQL + '  AUTOINCREM = :AUTOIN';
        qryAgeCom.Close;
        qryAgeCom.SQL.Text := strSQL;
        qryAgeCom.ParamByName('AUTOIN').AsString := FieldByName('AUTOIN').AsString;
        qryAgeCom.Open;

        blnInsert := qryAgeCom.IsEmpty;

        if blnInsert then
        begin
          strSQL := '';
          strSQL := strSQL + 'INSERT INTO ';
          strSQL := strSQL + '  AGENDA (AUTOINCREM, AGE_CODEMP, AGE_CODOPE, ';
          strSQL := strSQL + '          AGE_DTACOM, AGE_HORCOM, AGE_TITULO, ';
          strSQL := strSQL + '          AGE_DESCRI, AGE_BAIXAD, AGE_OPECAD, ';
          strSQL := strSQL + '          AGE_CLICOM, AGE_CATEGO, AGE_OBSERV) ';
          strSQL := strSQL + 'VALUES ';
          strSQL := strSQL + '         (:AUTOIN,   :CODEMP,    :CODOPE, ';
          strSQL := strSQL + '          :DTACOM,   :HORCOM,    :TITULO, ';
          strSQL := strSQL + '          :DESCRI,   "N",        :OPECAD, ';
          strSQL := strSQL + '          :CLICOM,   :CATEGO,    :OBSERV) ';
        end
        else
        begin
          strSQL := '';
          strSQL := strSQL + 'UPDATE                    ';
          strSQL := strSQL + '  AGENDA                   ';
          strSQL := strSQL + 'SET                        ';
          strSQL := strSQL + '  AGE_CODEMP = :CODEMP,    ';
          strSQL := strSQL + '  AGE_CODOPE = :CODOPE,    ';
          strSQL := strSQL + '  AGE_DTACOM = :DTACOM,    ';
          strSQL := strSQL + '  AGE_HORCOM = :HORCOM,    ';
          strSQL := strSQL + '  AGE_TITULO = :TITULO,    ';
          strSQL := strSQL + '  AGE_DESCRI = :DESCRI,    ';
          strSQL := strSQL + '  AGE_CLICOM = :CLICOM,    ';
          strSQL := strSQL + '  AGE_CATEGO = :CATEGO,    ';
          strSQL := strSQL + '  AGE_OBSERV = :OBSERV     ';
          strSQL := strSQL + 'WHERE                      ';
          strSQL := strSQL + '  AUTOINCREM = :AUTOIN     ';
        end;

        qryAgenda.Close;
        qryAgenda.SQL.Text := strSQL;

        if blnInsert then
        begin
          qryAgenda.ParamByName('AUTOIN').AsString := fRetAutoIncrem('AGENDA', FieldByName('CODEMP').AsString);

          Edit;
          FieldByName('AUTOIN').AsString := qryAgenda.ParamByName('AUTOIN').AsString;
          Post;
        end
        else
          qryAgenda.ParamByName('AUTOIN').AsString := FieldByName('AUTOIN').AsString;

        qryAgenda.ParamByName('CODEMP').AsString := FieldByName('CODEMP').AsString;
        qryAgenda.ParamByName('CODOPE').AsString := FieldByName('CODOPE').AsString;
        qryAgenda.ParamByName('DTACOM').AsDate := FieldByName('DTACOM').AsDateTime;
        qryAgenda.ParamByName('HORCOM').AsTime := FieldByName('HORCOM').AsDateTime;
        qryAgenda.ParamByName('TITULO').AsString := FieldByName('TITCOM').AsString;
        qryAgenda.ParamByName('DESCRI').AsString := FieldByName('DESCOM').AsString;
        qryAgenda.ParamByName('CATEGO').AsString := FieldByName('CATEGO').AsString;
        qryAgenda.ParamByName('OBSERV').AsString := FieldByName('OBSERV').AsString;

        qryAgenda.ParamByName('CLICOM').Clear;

        if Not fEmptyStr(FieldByName('CLICOM').AsString) then
          qryAgenda.ParamByName('CLICOM').AsString := FieldByName('CLICOM').AsString;

        if blnInsert then
          qryAgenda.ParamByName('OPECAD').AsString := FieldByName('OPECAD').AsString;

        qryAgenda.ExecSQL;
        Next;
      End;
      EnableControls;
      fCommit;
    End;
    FreeAndNil(qryAgeCom);
    FreeAndNil(qryAgenda);
    btnConfim.Enabled := False;
    pFiltraPorDataSelecionada(dtaDatSel);
    fMensagem('', 'Compromisso(s) gravado(s) com sucesso!', ['&O k']);
    blnGravou := True;
    pCarregaCompromissos;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      FreeAndNil(qryAgeCom);
      FreeAndNil(qryAgenda);
      if cdsCompro.State in dsEditModes then
        cdsCompro.Cancel;
      cdsCompro.EnableControls;
      pFiltraPorDataSelecionada(dtaDatSel);
      pMensagensErro(E.Message, '[TfrmCompromissos.btnConfimClick]');
    End;
  End;
end;

procedure TfrmCompromissos.btnGlobalClick(Sender: TObject);
begin
  inherited;
  pNovoCompromissoGlobal;
end;

procedure TfrmCompromissos.btnImprimClick(Sender: TObject);
begin

  If Not btnImprim.Enabled Then
    Exit;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(61, 5016, [],
                        ['CODOPE'],
                        [edtCodOpe.Text],
                        Sender,
                        nil,
                        False);

  End;

end;

procedure TfrmCompromissos.btnSair1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmCompromissos.cdsComproAfterScroll(DataSet: TDataSet);
var
  LTexto: String;
  LCategoria: String;
begin
  LTexto := '';

  if not cdsCompro.IsEmpty then
  begin
    if not fEmptyStr(cdsComproCLICOM.AsString) then
    begin
      LCategoria := '';

      if not fEmptyStr(cdsComproCATEGO.AsString) then
      begin
        case cdsComproCATEGO.AsString[1] of
          'V': LCategoria := 'VISITA';
          'L': LCategoria := 'LIGAÇÃO';
          'E': LCategoria := 'E-MAIL';
          'W': LCategoria := 'WHATSAPP';
          'O': LCategoria := 'OUTROS';
        end;
      end;

      LTexto :=
        'CLIENTE:' + sLineBreak +
        cdsComproCLICOM.AsString + ' - ' + cdsComproNOMCLI.AsString + sLineBreak +
        sLineBreak +
        'CATEGORIA:' + sLineBreak +
        LCategoria + sLineBreak +
        sLineBreak +
        'OBSERVAÇÃO:' + sLineBreak +
        cdsComproOBSERV.AsString + sLineBreak +
        sLineBreak;
    end;

    LTexto := LTexto + 'DESCRIÇÃO:' + sLineBreak + cdsComproDESCOM.AsString;

    mmoCompro.Texto := LTexto;
  end
  else
    mmoCompro.Clear;

  btnBaixar.Enabled := not cdsCompro.IsEmpty;
  btnImprim.Enabled := not cdsCompro.IsEmpty;
end;

procedure TfrmCompromissos.chkExibirBaixadosClick(Sender: TObject);
begin
  inherited;
  pCarregaCompromissos;
  pAtualizarCalendario;
end;

procedure TfrmCompromissos.edtCodOpeChange(Sender: TObject);
begin
  edtNomOpe.Clear;
  If (Not fEmptyStr(edtCodOpe.Text)) Then
  Begin
    edtNomOpe.Text    := fRetNomeOperador(edtCodOpe.Text);
    edtSenha1.Enabled := False;
    If (Not fEmptyStr(edtNomOpe.Text)) Then
      edtSenha1.Enabled := True;
    Exit;
  End;
  edtSenha1.Enabled := False;
end;

procedure TfrmCompromissos.edtCodOpeEnter(Sender: TObject);
begin
  inherited;
  edtNomOpe.Clear;
  If Not fEmptyStr(edtCodOpe.Text) Then
  Begin
    edtNomOpe.Text    := fRetNomeOperador(edtCodOpe.Text);
    edtSenha1.Enabled := False;
    If (Not fEmptyStr(edtNomOpe.Text)) Then
      edtSenha1.Enabled := True
  End;
end;

procedure TfrmCompromissos.edtCodOpeKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  Try
    If fEntraCons(Key) Then
    Begin
      If fPesqOperador(Self, edtCodOpe, edtNomOpe, Nil, Key, arrSel) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;
end;

procedure TfrmCompromissos.edtSenha1Exit(Sender: TObject);
begin
  inherited;
  btnGlobal.Enabled := fVerificaAcessoSistema('mnuCompromissoGlobal', edtCodOpe.Text);

  chkTodosOperadores.Checked := False;
  chkTodosOperadores.Visible := fVerificaAcessoSistema('mnuExibirComprTodosOpe', edtCodOpe.Text);
end;

procedure TfrmCompromissos.edtSenha1KeyPress(Sender: TObject; var Key: Char);
  Var
    strSQL   : String;
    qryGenOpe: TUniQuery;
begin
  qryGenOpe := fCriaQuery(Self);
  If (Key = #13) Then
  Begin
    Key := #0;
    If Not fEmptyStr(edtCodOpe.Text) Then
    Begin
      {* CARACTERE FORA DE STR_CHAR_SENHA E CRIPTOGRAFADO PELO fCrypt COMO 'A' *}
      If Not fSenhaPermitida(edtSenha1.Text) Then
      Begin
        fMensagem('', 'Login ou Senha Incorretos! Verifique.', ['&O k']);
        pSetFocus(edtCodOpe);
        FreeAndNil(qryGenOpe);
        Exit;
      End;

      strSQL := '';
      strSQL := strSQL + 'SELECT         ';
      strSQL := strSQL + '  COUNT(*) QTD ';
      strSQL := strSQL + 'FROM           ';
      strSQL := strSQL + '  CADOPE       ';
      strSQL := strSQL + 'WHERE          ';
      strSQL := strSQL + '         OPE_CODOPE = :LOGOPE AND ';
      strSQL := strSQL + '  BINARY OPE_SENOPE = :SENOPE     ';
      With qryGenOpe Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('LOGOPE').AsString := edtCodOpe.Text;
        ParamByName('SENOPE').AsString := fCrypt(edtSenha1.Text);
        Open;
        If (FieldByName('QTD').AsInteger = 1) Then
        Begin
          pMontaCalendario(dtaDatSel);
          edtCodOpe.Enabled := False;
          edtSenha1.Enabled := False;
          pnlCalend.Enabled := True;
          pnlDetalh.Enabled := True;
          blnGravou := False;
          pLimpaCompromissos;  
          pCarregaCompromissos;
          pSetFocus(grdCalend);
        End
        Else
        Begin
          fMensagem('', 'Login ou Senha Incorretos! Verifique.', ['&O k']);
          pSetFocus(edtCodOpe);
        End;
      End;
    End;
  End;
  FreeAndNil(qryGenOpe);
end;

function TfrmCompromissos.fBaixarCompromisso: Boolean;
  Var
    strSQL          : String;
    qryAgenda: TUniQuery;
begin
  Try
    fStartTransaction;
    Result := True;
    qryAgenda := fCriaQuery(Self);
    strSQL := '';
    strSQL := strSQL + 'UPDATE                  ';
    strSQL := strSQL + '  AGENDA                ';
    strSQL := strSQL + 'SET                     ';
    strSQL := strSQL + '  AGE_BAIXAD = :BAIXAD  ';
    strSQL := strSQL + 'WHERE                   ';
    strSQL := strSQL + '  AUTOINCREM = :AUTOIN  ';
    With qryAgenda Do
    Begin
      Close;
      SQL.Text := strSQL;
      ParamByName('AUTOIN').AsString := cdsComproAUTOIN.AsString;
      ParamByName('BAIXAD').AsString := 'S';
      ExecSQL;
    End;
    FreeAndNil(qryAgenda);

    fCommit;
  Except
    fRollBack;
    Result := False;
    FreeAndNil(qryAgenda);
  End;
end;

function TfrmCompromissos.fEhDomingo(dtaDta: TDateTime): Boolean;
begin
  Result := (DayOfWeek(dtaDta) = DOMINGO);
end;

function TfrmCompromissos.fEhSabado(dtaDta: TDateTime): Boolean;
begin
  Result := (DayOfWeek(dtaDta) = SABADO);
end;

procedure TfrmCompromissos.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodOpe);
end;

procedure TfrmCompromissos.FormCreate(Sender: TObject);
begin
  inherited;

  dtaDatSel := VS_Date;
  intMesSel := MonthOf(dtaDatSel);
  intAnoSel := YearOf(dtaDatSel);
  pMontaCalendario(dtaDatSel);
end;

procedure TfrmCompromissos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = VK_ESCAPE) Then
  Begin
    If grdCalend.Focused Then
    Begin
      pLimpaCalendario;
      edtCodOpe.Clear;
      edtNomOpe.Clear;
      edtSenha1.Clear;
      mmoCompro.Lines.Clear;
      cdsCompro.Close;
      edtCodOpe.Enabled := True;
      edtSenha1.Enabled := True;
      pnlCalend.Enabled := False;
      pnlDetalh.Enabled := False;
      pSetFocus(edtCodOpe);
    End
    Else
      btnSair1.Click;
  End
  Else If (Key = VK_F10) Then
    btnConfim.Click
  Else If (Key = VK_F9) Then
    btnBaixar.Click
  Else If (Key = VK_F8) Then
    btnImprim.Click
  Else If (Key = VK_F7) Then
    btnGlobal.Click
  Else
    inherited;
end;

procedure TfrmCompromissos.grdCalendDblClick(Sender: TObject);
begin
  pNovoCompromisso;
end;

procedure TfrmCompromissos.grdCalendDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  inherited;
  If (gdFocused in State) Then
  Begin
    If (Pos('«' , grdCalend.Cells[ACol, ARow]) > 0) Then
      grdCalend.Canvas.Brush.Color := clSkyBlue
    Else
      grdCalend.Canvas.Brush.Color := clBlack;
      grdCalend.Canvas.Font.Color  := clWhite;
  End;
  If ((ACol = 6) Or (ACol = 0)) And (ARow > 0) Then
    grdCalend.Canvas.Font.Color := clRed;

  If Pos('«' , grdCalend.Cells[ACol, ARow]) > 0 Then
    grdCalend.Canvas.Font.Color := clBlue;

  If Pos('[' , grdCalend.Cells[ACol, ARow]) > 0 Then
    grdCalend.Canvas.Font.Style := [fsBold];

  grdCalend.Canvas.FillRect(Rect);
  grdCalend.Canvas.TextOut(Rect.Left + 1, Rect.Top + 1, grdCalend.Cells[ACol, ARow]);
end;

procedure TfrmCompromissos.grdCalendKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = VK_Return) Then
    pNovoCompromisso
  Else If (Key = VK_F2) Then
    pSetFocus(grdCompro)
  Else If (Key = VK_F3) Then
    pListagemCompromissos;
end;

procedure TfrmCompromissos.grdCalendSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  fSelecionaData(ACol, ARow);
end;

procedure TfrmCompromissos.grdComproDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  if VarToStr(AViewInfo.GridRecord.Values[grdComproDBTableViewBAIXAD.Index]) = 'S' then
    ACanvas.Font.Color := clGreen;
end;

procedure TfrmCompromissos.grdComproDBTableView1DblClick(Sender: TObject);
begin
  pAlteraCompromisso;
end;

procedure TfrmCompromissos.grdComproDBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If (Key = VK_RETURN) Then
    pAlteraCompromisso
  Else If (Key = VK_F2) Then
    pSetFocus(grdCalend)
  Else If (Key = VK_F3) Then
    pListagemCompromissos;
end;

procedure TfrmCompromissos.pAlteraCompromisso;
begin
  if not cdsCompro.IsEmpty then
  begin
    try
      pCriarFormularios(TfrmNovoCompromisso, frmNovoCompromisso);

      with frmNovoCompromisso do
      begin
        Caption := 'Alterar Compromisso';
        pnlTitulo.Caption := 'Alterar Compromisso';

        edtDtaCom.Text := FormatDateTime('dd/mm/yyyy', cdsComproDTACOM.AsDateTime);

        edtHorCom.Text := FormatDateTime('hh:nn', cdsComproHORCOM.AsDateTime);

        edtTitCom.Text := cdsComproTITCOM.AsString;
        mmoDesCom.Texto := cdsComproDESCOM.AsString;

        edtCodCli.Text := cdsComproCLICOM.AsString;
        edtNomCli.Text := cdsComproNOMCLI.AsString;
        mmoObserv.Texto := cdsComproOBSERV.AsString;

        rdgCatego.ItemIndex := -1;

        if not fEmptyStr(cdsComproCATEGO.AsString) then
        begin
          case cdsComproCATEGO.AsString[1] of
            'V': rdgCatego.ItemIndex := 0;
            'L': rdgCatego.ItemIndex := 1;
            'E': rdgCatego.ItemIndex := 2;
            'W': rdgCatego.ItemIndex := 3;
            'O': rdgCatego.ItemIndex := 4;
          end;
        end;

        blnNovoCompromisso := False;

        ShowModal;

        if ModalResult = mrOk then
        begin
          cdsCompro.Edit;

          cdsComproCODEMP.AsString := vs_strCodEmp;
          cdsComproCODOPE.AsString := edtCodOpe.Text;

          cdsComproDTACOM.AsDateTime := StrToDate(edtDtaCom.Text);

          cdsComproHORCOM.AsDateTime := StrToTime(edtHorCom.Text);

          cdsComproTITCOM.AsString := edtTitCom.Text;
          cdsComproDESCOM.AsString := mmoDesCom.Texto;

          cdsComproCLICOM.AsString := edtCodCli.Text;
          cdsComproCATEGO.AsString := fRetCategoria;
          cdsComproOBSERV.AsString := mmoObserv.Texto;

          pPreencheCamposExibicao(True);

          cdsCompro.Post;

          Self.btnConfim.Enabled := True;
        end;
      end;
    finally
      FreeAndNil(frmNovoCompromisso);
    end;
  end;
end;

procedure TfrmCompromissos.pAtualizarCalendario;
begin
  pMontaCalendario(dtaDatSel);
  pMarcarDiasComCompromissos;
  pFiltraPorDataSelecionada(dtaDatSel);
  pSetFocus(grdCalend);
end;

procedure TfrmCompromissos.pCarregaCompromissos;
  Var
    strSQL   : String;
    qryGenCom: TUniQuery;
    intConta1: Integer;
    intQtdDia: Integer;
begin
  qryGenCom := fCriaQuery(Self);
  strSQL := '';
  strSQL := strSQL + ' SELECT                                      ';
  strSQL := strSQL + '   AGENDA.*,                                 ';
  strSQL := strSQL + '   CADOPE.OPE_NOMOPE AS NOMOPE,              ';
  strSQL := strSQL + '   CADCLI.CLI_NOMCLI AS NOMCLI               ';
  strSQL := strSQL + ' FROM AGENDA                                 ';
  strSQL := strSQL + ' LEFT JOIN CADOPE ON                     ';
  strSQL := strSQL + '   CADOPE.OPE_CODOPE = AGENDA.AGE_CODOPE ';
  strSQL := strSQL + ' LEFT JOIN CADCLI ON                         ';
  strSQL := strSQL + '   CADCLI.CLI_CODCLI = AGENDA.AGE_CLICOM     ';
  strSQL := strSQL + ' WHERE 1 = 1 ';

  if not chkTodosOperadores.Checked then
  begin
    strSQL := strSQL + ' AND AGENDA.AGE_CODEMP = :CODEMP ';
    strSQL := strSQL + ' AND AGENDA.AGE_CODOPE = :CODOPE ';
  end;

  if not chkExibirBaixados.Checked then
    strSQL := strSQL + ' AND AGENDA.AGE_BAIXAD = "N" ';

  strSQL := strSQL + ' ORDER BY AGENDA.AGE_DTACOM, AGENDA.AGE_HORCOM ';
  With qryGenCom Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    if not chkTodosOperadores.Checked then
    begin
      ParamByName('CODEMP').AsString := vs_strCodEmp;
      ParamByName('CODOPE').AsString := edtCodOpe.Text;
    end;

    Open;
    cdsCompro.DisableControls;
    cdsCompro.EmptyDataSet;
    While Not Eof Do
    Begin
      cdsCompro.Append;
      cdsComproAUTOIN.AsString   := FieldByName('AUTOINCREM').AsString;
      cdsComproCODEMP.AsString   := FieldByName('AGE_CODEMP').AsString;
      cdsComproCODOPE.AsString   := FieldByName('AGE_CODOPE').AsString;
      cdsComproDTACOM.AsDateTime := FieldByName('AGE_DTACOM').AsDateTime;
      cdsComproHORCOM.AsDateTime := FieldByName('AGE_HORCOM').AsDateTime;
      cdsComproTITCOM.AsString   := FieldByName('AGE_TITULO').AsString;
      cdsComproDESCOM.AsVariant  := FieldByName('AGE_DESCRI').AsVariant;
      cdsComproCODOCO.AsString   := FieldByName('AGE_CODOCO').AsString;
      cdsComproNOMOPE.AsString   := cdsComproCODOPE.AsString + ' - ' +
                                    FieldByName('NOMOPE').AsString;
      cdsComproCLICOM.AsString := FieldByName('AGE_CLICOM').AsString;
      cdsComproNOMCLI.AsString := FieldByName('NOMCLI').AsString;
      cdsComproCATEGO.AsString := FieldByName('AGE_CATEGO').AsString;
      cdsComproOBSERV.AsString := FieldByName('AGE_OBSERV').AsString;
      cdsComproBAIXAD.AsString := FieldByName('AGE_BAIXAD').AsString;

      pPreencheCamposExibicao(False);

      If (dtaDatSel <> cdsComproDTACOM.AsDateTime) Then
      Begin
        For intConta1 := 0 to 7 do
        Begin
          For intQtdDia := 0 To 7 Do
          Begin
            If (Trim(grdCalend.Cells[intConta1, intQtdDia]) = IntToStr(DayOf(cdsComproDTACOM.AsDateTime))) And
               (intMesSel = MonthOf(cdsComproDTACOM.AsDateTime)) And
               (intAnoSel = YearOf(cdsComproDTACOM.AsDateTime))  Then
            Begin
              If (DayOf(cdsComproDTACOM.AsDateTime) < 10) Then
                grdCalend.Cells[intConta1, intQtdDia] := '   ' + '«' + IntToStr(DayOf(cdsComproDTACOM.AsDateTime)) + '»'
              Else
                grdCalend.Cells[intConta1, intQtdDia] := '  '  + '«' + IntToStr(DayOf(cdsComproDTACOM.AsDateTime)) + '»';
            End;
          End;
        End;
      End;
      
      cdsCompro.Post;

      Next;
    End;
    pFiltraPorDataSelecionada(dtaDatSel);
    cdsCompro.EnableControls;
  End;
  FreeAndNil(qryGenCom);
end;

procedure TfrmCompromissos.pFiltraPorDataSelecionada(dtaDtaSel: TDateTime);
begin
  cdsCompro.Filtered := False;
  cdsCompro.Filter   := 'DTACOM = ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaDtaSel));
  cdsCompro.Filtered := True;
end;

procedure TfrmCompromissos.pLimpaCalendario;
  Var
    intConta1: Integer;
    intQtdDia: Integer;
begin
  For intConta1 := 0 to 7 do
  Begin
    grdCalend.Cells[intConta1, 0] := '';
    For intQtdDia := 0 To 7 Do
      grdCalend.Cells[intConta1, intQtdDia] := '';
  End;
end;

procedure TfrmCompromissos.pLimpaCompromissos;
begin
  cdsCompro.Close;
  cdsCompro.CreateDataSet;
  cdsCompro.EmptyDataSet;
end;

procedure TfrmCompromissos.pListagemCompromissos;
begin
  If (Not fEmptyStr(edtCodOpe.Text)) And (Not edtCodOpe.Enabled) Then
  begin
    If Assigned(prcExecutaRelatorio) Then
    begin
      prcExecutaRelatorio(62, 5027, [],
                          ['CODOPE'],
                          [edtCodOpe.Text],
                          nil,
                          nil,
                          True);
    End;
  end;
end;

procedure TfrmCompromissos.pMarcarDiasComCompromissos;
  Var
    strFilter: String;
    intConta1: Integer;
    intQtdDia: Integer;
begin
  With cdsCompro Do
  Begin
    DisableControls;
    strFilter := Filter;
    Filtered  := False;
    Filter    := 'MONTH(DTACOM) = ' + IntToStr(intMesSel) + ' AND ' +
                 'YEAR(DTACOM)  = ' + IntToStr(intAnoSel);
    Filtered  := True;
    First;
    While Not Eof Do
    Begin
      For intConta1 := 0 to 7 do
      Begin
        For intQtdDia := 0 To 7 Do
        Begin
          If (Trim(grdCalend.Cells[intConta1, intQtdDia]) = IntToStr(DayOf(cdsComproDTACOM.AsDateTime))) And
             (intMesSel = MonthOf(cdsComproDTACOM.AsDateTime)) And
             (intAnoSel = YearOf(cdsComproDTACOM.AsDateTime))  Then
          Begin
            If (DayOf(cdsComproDTACOM.AsDateTime) < 10) Then
              grdCalend.Cells[intConta1, intQtdDia] := '   ' + '«' + IntToStr(DayOf(cdsComproDTACOM.AsDateTime)) + '»'
            Else If (cdsComproDTACOM.AsDateTime = VS_Date) Then
              grdCalend.Cells[intConta1, intQtdDia] := '   ' + '[' + IntToStr(DayOf(cdsComproDTACOM.AsDateTime)) + ']'
            Else
              grdCalend.Cells[intConta1, intQtdDia] := '  '  + '«' + IntToStr(DayOf(cdsComproDTACOM.AsDateTime)) + '»';
          End;
        End;
      End;
      Next;
    End;
    Filtered := False;
    Filter   := strFilter;
    Filtered := True;
    EnableControls;
  End;
end;

procedure TfrmCompromissos.pMontaCalendario(dtaDatAtu: TDateTime);
  Var
    intQtdDia: Integer;
    intQtdSem: Integer;
    intConta1: Integer;
    strDiaMes: String;
  Const
    arrDiaSem: Array[1..7] Of String = (' Domingo',
                                        ' Segunda',
                                        ' Terça',
                                        ' Quarta',
                                        ' Quinta',
                                        ' Sexta',
                                        ' Sábado');
begin
  pLimpaCalendario;
  For intConta1 := 1 to 7 do
    grdCalend.Cells[intConta1 - 1, 0] := arrDiaSem[intConta1];
  intQtdSem := 1;
  For intQtdDia := 1 To DaysInMonth(dtaDatAtu) Do
  Begin
    dtaData01 := StrToDate(IntToStr(intQtdDia) + FormatSettings.DateSeparator + IntToStr(MonthOf(dtaDatAtu)) +
                                                 FormatSettings.DateSeparator + IntToStr(YearOf(dtaDatAtu)));
    If (DayOf(dtaData01) < 10) Then
      grdCalend.Cells[DayOfWeek(dtaData01) - 1, intQtdSem] := '    ' + IntToStr(DayOf(dtaData01))
    Else
      grdCalend.Cells[DayOfWeek(dtaData01) - 1, intQtdSem] := '   '  + IntToStr(DayOf(dtaData01));

    If (dtaData01 = dtaDatAtu) Then
    Begin
      tgrCelula.Left      := DayOfWeek(dtaData01) - 1;
      tgrCelula.Right     := DayOfWeek(dtaData01) - 1;
      tgrCelula.Top       := intQtdSem;
      tgrCelula.Bottom    := intQtdSem;
      grdCalend.Selection := tgrCelula;
      If (Pos('«', Trim(grdCalend.Cells[tgrCelula.Left, tgrCelula.Top])) > 0) Then
      Begin
        strDiaMes := Trim(grdCalend.Cells[tgrCelula.Left, tgrCelula.Top]);
        strDiaMes := AnsiReplaceStr(strDiaMes, '«', '');
        strDiaMes := AnsiReplaceStr(strDiaMes, '»', '');
        If (StrToInt(strDiaMes) < 10) Then
        Begin
          grdCalend.Cells[tgrCelula.Left, tgrCelula.Top] :=  '  ' + '[' +
             Trim(grdCalend.Cells[tgrCelula.Left, tgrCelula.Top]) + ']';
        End
        Else
        Begin
          grdCalend.Cells[tgrCelula.Left, tgrCelula.Top] :=  ' ' + '[' +
            Trim(grdCalend.Cells[tgrCelula.Left, tgrCelula.Top]) + ']';
        End;
      End
      Else If (dtaDatSel = VS_Date) Then
      Begin
        If (StrToInt(Trim(grdCalend.Cells[tgrCelula.Left, tgrCelula.Top])) < 10) Then
        Begin
          grdCalend.Cells[tgrCelula.Left, tgrCelula.Top] :=  '   ' + '[' +
              Trim(grdCalend.Cells[tgrCelula.Left, tgrCelula.Top]) + ']';
        End
        Else
        Begin
          grdCalend.Cells[tgrCelula.Left, tgrCelula.Top] :=  '  ' + '[' +
             Trim(grdCalend.Cells[tgrCelula.Left, tgrCelula.Top]) + ']';
        End;
      End;
      pnlMesAno.Caption := fRetMesExtenso(MonthOf(dtaDatAtu)) + ' / ' +
                           IntToStr(YearOf(dtaDatAtu));
    End;
    If (DayOfWeek(dtaData01) - 1 = 6) Then
      intQtdSem := intQtdSem + 1;
  End;
end;

procedure TfrmCompromissos.pNovoCompromisso;
  Var
    dtaReplic : TDatetime;
    intTesteDta : Integer;
begin
  pCriarFormularios(TfrmNovoCompromisso, frmNovoCompromisso);
  Try
    With frmNovoCompromisso Do
    Begin
      edtDtaCom.Text     := FormatDateTime('dd/mm/yyyy', dtaDatSel);
      grpReplica.Visible := True;
      blnNovoCompromisso := True;
      ShowModal;
      If (ModalResult = mrOk) Then
      Begin
        If chkReplic.Checked Then
        Begin
          dtaReplic := StrToDate(edtDtaIni.Text);

          pnlProgresso.Visible  := True;
          pgbProgresso.Position := 0;
          pgbProgresso.Max      := DaysBetween(dtaReplic,StrToDate(edtDtaFin.Text));

          While dtaReplic <= StrToDate(edtDtaFin.Text) Do
          Begin
            cdsCompro.Append;
            cdsComproCODEMP.AsString   := VS_strCodEmp;
            cdsComproCODOPE.AsString   := edtCodOpe.Text;
            cdsComproDTACOM.AsDateTime := dtaReplic;
            cdsComproHORCOM.AsDateTime := StrToTime(edtHorCom.Text);
            cdsComproTITCOM.AsString   := edtTitCom.Text;
            cdsComproDESCOM.AsString   := mmoDesCom.Texto;
            cdsComproOPECAD.AsString   := edtCodOpe.Text;
            cdsComproCLICOM.AsString   := edtCodCli.Text;
            cdsComproCATEGO.AsString   := fRetCategoria;
            cdsComproOBSERV.AsString   := mmoObserv.Texto;
            pPreencheCamposExibicao(True);
            cdsCompro.Post;

            dtaReplic := IncDay(dtaReplic, StrToInt(edtPeriod.Text));

            pgbProgresso.Position := pgbProgresso.Position + StrToInt(edtPeriod.Text);
            Application.ProcessMessages;

            intTesteDta := 1;
            While intTesteDta <= 2 Do
            Begin
              If chkDesDom.Checked Then
                dtaReplic := IIf(fEhFeriado(dtaReplic), IncDay(dtaReplic, 1), dtaReplic);

              If chkDesSab.Checked Then
                dtaReplic := IIf(fEhSabado(dtaReplic), IncDay(dtaReplic, 1), dtaReplic);

              If chkDesDom.Checked Then
                dtaReplic := IIf(fEhDomingo(dtaReplic), IncDay(dtaReplic, 1), dtaReplic);

              intTesteDta := intTesteDta + 1; 
            End;
          End;

          pgbProgresso.Position := 0;
          pnlProgresso.Visible  := False;
        End
        Else
        Begin
          cdsCompro.Append;
          cdsComproCODEMP.AsString   := VS_strCodEmp;
          cdsComproCODOPE.AsString   := edtCodOpe.Text;
          cdsComproDTACOM.AsDateTime := StrToDate(edtDtaCom.Text);
          cdsComproHORCOM.AsDateTime := StrToTime(edtHorCom.Text);
          cdsComproTITCOM.AsString   := edtTitCom.Text;
          cdsComproDESCOM.AsString   := mmoDesCom.Texto;
          cdsComproOPECAD.AsString   := edtCodOpe.Text;
          cdsComproCLICOM.AsString   := edtCodCli.Text;
          cdsComproCATEGO.AsString   := fRetCategoria;
          cdsComproOBSERV.AsString   := mmoObserv.Texto;
          pPreencheCamposExibicao(True);
          cdsCompro.Post;
        End;

        Self.btnConfim.Enabled := True;
        pMarcarDiasComCompromissos;
      End;
    End;
  Finally
    FreeAndNil(frmNovoCompromisso);
  End;
end;

procedure TfrmCompromissos.pNovoCompromissoGlobal;
  Var
    dtaReplic : TDatetime;
    intTesteDta : Integer;
    intContaUsuario : integer;
    strCadastradoPor : string;
    frmCompromissoGrupo: TfrmCompromissoGrupo;

begin
  pCriarFormularios(TfrmCompromissoGrupo, frmCompromissoGrupo);

  Try
    frmCompromissoGrupo.edtDtaCom.Text     := FormatDateTime('dd/mm/yyyy', dtaDatSel);
    frmCompromissoGrupo.grpReplica.Visible := True;
    frmCompromissoGrupo.ShowModal;

    If (frmCompromissoGrupo.ModalResult = mrOk) Then
    Begin
      strCadastradoPor := ' < '+ edtCodOpe.Text+'-'+edtNomOpe.Text+' - '+FormatDateTime('dd/mm/yyyy', Date)+
                          ' '+FormatDateTime('hh:mm:ss', fTime())+' >';
      For intContaUsuario := 0 To length(frmCompromissoGrupo.arrUsuarios) -1 Do
      Begin
        If frmCompromissoGrupo.chkReplic.Checked Then
        Begin
          dtaReplic := StrToDate(frmCompromissoGrupo.edtDtaIni.Text);

          pnlProgresso.Visible  := True;
          pgbProgresso.Position := 0;
          pgbProgresso.Max      := DaysBetween(dtaReplic,StrToDate(frmCompromissoGrupo.edtDtaFin.Text));


          While dtaReplic <= StrToDate(frmCompromissoGrupo.edtDtaFin.Text) Do
          Begin
            cdsCompro.Append;
            cdsComproCODEMP.AsString   := VS_strCodEmp;
            cdsComproCODOPE.AsString   := frmCompromissoGrupo.arrUsuarios[intContaUsuario];
            cdsComproDTACOM.AsDateTime := dtaReplic;
            cdsComproHORCOM.AsDateTime := StrToTime(frmCompromissoGrupo.edtHorCom.Text);
            cdsComproTITCOM.AsString   := frmCompromissoGrupo.edtTitCom.Text;
            cdsComproDESCOM.AsString   := frmCompromissoGrupo.mmoDesCom.Texto+#13+
                                          strCadastradoPor;
            cdsComproOPECAD.AsString   := edtCodOpe.Text;
            cdsComproCLICOM.AsString   := frmCompromissoGrupo.edtCodCli.Text;
            cdsComproCATEGO.AsString   := frmCompromissoGrupo.fRetCategoria;
            cdsComproOBSERV.AsString   := frmCompromissoGrupo.mmoObserv.Texto;
            pPreencheCamposExibicao(True);
            cdsCompro.Post;

            dtaReplic := IncDay(dtaReplic, StrToInt(frmCompromissoGrupo.edtPeriod.Text));

            pgbProgresso.Position := pgbProgresso.Position + StrToInt(frmCompromissoGrupo.edtPeriod.Text);
            Application.ProcessMessages;

            intTesteDta := 1;
            While intTesteDta <= 2 Do
            Begin
              If frmCompromissoGrupo.chkDesDom.Checked Then
                dtaReplic := IIf(fEhFeriado(dtaReplic), IncDay(dtaReplic, 1), dtaReplic);

              If frmCompromissoGrupo.chkDesSab.Checked Then
                dtaReplic := IIf(fEhSabado(dtaReplic), IncDay(dtaReplic, 1), dtaReplic);

              If frmCompromissoGrupo.chkDesDom.Checked Then
                dtaReplic := IIf(fEhDomingo(dtaReplic), IncDay(dtaReplic, 1), dtaReplic);

              intTesteDta := intTesteDta + 1;
            End;
          End;

          pgbProgresso.Position := 0;
          pnlProgresso.Visible  := False;
        End
        Else
        Begin
          cdsCompro.Append;
          cdsComproCODEMP.AsString   := VS_strCodEmp;
          cdsComproCODOPE.AsString   := frmCompromissoGrupo.arrUsuarios[intCOntaUsuario];
          cdsComproDTACOM.AsDateTime := StrToDate(frmCompromissoGrupo.edtDtaCom.Text);
          cdsComproHORCOM.AsDateTime := StrToTime(frmCompromissoGrupo.edtHorCom.Text);
          cdsComproTITCOM.AsString   := frmCompromissoGrupo.edtTitCom.Text;
          cdsComproDESCOM.AsString   := frmCompromissoGrupo.mmoDesCom.Texto+#13+
                                        strCadastradoPor;
          cdsComproOPECAD.AsString   := edtCodOpe.Text;
          cdsComproCLICOM.AsString   := frmCompromissoGrupo.edtCodCli.Text;
          cdsComproCATEGO.AsString   := frmCompromissoGrupo.fRetCategoria;
          cdsComproOBSERV.AsString   := frmCompromissoGrupo.mmoObserv.Texto;
          pPreencheCamposExibicao(True);
          cdsCompro.Post;
        End;
      End;

      Self.btnConfim.Enabled := True;
      pMarcarDiasComCompromissos;
    End;
  Finally
    pFreeAndNil(frmNovoCompromisso);
  End;
end;

procedure TfrmCompromissos.pPreencheCamposExibicao(APesquisarNomes: Boolean);
var
  LCategoria: String;
begin
  if APesquisarNomes then
  begin
    cdsComproNOMOPE.AsString :=  cdsComproCODOPE.AsString + ' - ' +
                                 fRetNomeOperador(cdsComproCODOPE.AsString);

    if not fEmptyStr(cdsComproCLICOM.AsString) then
      cdsComproNOMCLI.AsString := fRetNomCliente(cdsComproCLICOM.AsString);
  end;

  cdsComproCOMPRO.AsString := cdsComproTITCOM.AsString;

  if not fEmptyStr(cdsComproCLICOM.AsString) then
  begin
    LCategoria := '';

    if not fEmptyStr(cdsComproCATEGO.AsString) then
    begin
      case cdsComproCATEGO.AsString[1] of
        'V': LCategoria := 'VISITA';
        'L': LCategoria := 'LIGAÇÃO';
        'E': LCategoria := 'E-MAIL';
        'W': LCategoria := 'WHATSAPP';
        'O': LCategoria := 'OUTROS';
      end;
    end;

    cdsComproCOMPRO.AsString := LCategoria + ' - ' +
                                cdsComproCLICOM.AsString + ' - ' +
                                cdsComproNOMCLI.AsString;
  end;
end;

function TfrmCompromissos.fSelecionaData(intCol, intRow: Integer): Boolean;
  Var
    strTexto: String;
begin
  strDatSel := '';
  strTexto := grdCalend.Cells[intCol, intRow];
  If fEmptyStr(strTexto) Then
  Begin
    pSetFocus(grdCalend);
    Result := False;
    Exit;
  End;
  strDatSel := strTexto + FormatSettings.DateSeparator + IntToStr(MonthOf(dtaData01)) +
                          FormatSettings.DateSeparator + IntToStr(YearOf(dtaData01));
  strDatSel := AnsiReplaceStr (strDatSel, '[','');
  strDatSel := AnsiReplaceStr (strDatSel, ']','');
  strDatSel := AnsiReplaceStr (strDatSel, '«','');
  strDatSel := AnsiReplaceStr (strDatSel, '»','');
  dtaDatSel := StrToDate(strDatSel);
  intMesSel := MonthOf(dtaDatSel);
  intAnoSel := YearOf(dtaDatSel);

  cdsCompro.DisableControls;
  pFiltraPorDataSelecionada(dtaDatSel);
  If Not cdsCompro.IsEmpty And (dtaDatSel <> VS_Date) Then
  Begin
    If (DayOf(dtaDatSel) < 10) Then
      grdCalend.Cells[DayOfWeek(dtaDatSel)-1, intRow] := '   ' + '«' + IntToStr(DayOf(dtaDatSel)) + '»'
    Else
      grdCalend.Cells[DayOfWeek(dtaDatSel)-1, intRow] := '  '  + '«' + IntToStr(DayOf(dtaDatSel)) + '»';
  End;
  cdsCompro.EnableControls;

  Result := True;
end;

end.
