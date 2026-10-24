unit untCtaAtuDupDDA;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel,
  cxGrid, EditFocus, Uni, untFuncoesSimples, UniClientDataSet,
  UniDataSetProvider, untConstantes, StrUtils, cxProgressBar, untTypesSistema,
  untFuncoesBoleto, untCadPag, untTCadPag, untLogCtp,
  untTCadPagRepository, untFuncAutBan, untFuncoes,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxTextEdit,
  cxContainer, Vcl.ComCtrls, dxCore, cxDateUtils, cxMaskEdit, cxDropDownEdit,
  cxCalendar;

type
  TfrmCtaAtuDupDDA = class(TfrmPai)
    pnlFundo: TPanel;
    pnlTopo: TPanel;
    pnlDadosDup: TPanel;
    pnlAux2: TPanel;
    pnlTotais: TPanel;
    Label21: TLabel;
    Label9: TLabel;
    edtTotalDup: TEditFocus;
    edtTotalSelecionado: TEditFocus;
    grdDuplic: TcxGridCitel;
    grdDuplicDados: TcxGridDBTableViewCitel;
    grdDuplicDadosDDA_NUMDUP: TcxGridDBColumn;
    grdDuplicDadosDDA_CODEMP: TcxGridDBColumn;
    grdDuplicDadosCTP_PARCEL: TcxGridDBColumn;
    grdDuplicDadosCTP_CODFOR: TcxGridDBColumn;
    grdDuplicDadosDDA_DTAVEN: TcxGridDBColumn;
    grdDuplicDadosDDA_DTAEMI: TcxGridDBColumn;
    grdDuplicDadosDDA_VALTIT: TcxGridDBColumn;
    grdDuplicNivel: TcxGridLevel;
    grpArquivo: TGroupBox;
    lblFornecedor: TLabel;
    Nome: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtCedente: TEdit;
    edtDtaVenArq: TEdit;
    edtConta: TEdit;
    edtDtaArq: TEdit;
    edtCNPJArq: TEdit;
    edtDtaEmiArq: TEdit;
    edtNumDupArq: TEdit;
    edtLinDigArq: TEdit;
    edtCodAge: TEdit;
    grpSistema: TGroupBox;
    edtFornecedor: TEdit;
    edtNumDupSis: TEdit;
    edtLinDigSis: TEdit;
    edtDtaVenSis: TEdit;
    edtDtaCadSis: TEdit;
    edtCNPJSis: TEdit;
    lblCodBar: TLabel;
    lblLinDig: TLabel;
    Label1: TLabel;
    lblProtesta: TLabel;
    Label14: TLabel;
    Label6: TLabel;
    edtOcorre: TEdit;
    Label8: TLabel;
    Label11: TLabel;
    edtValorSis: TEdit;
    Label13: TLabel;
    edtValorArq: TEdit;
    btnDesmarcarTodas: TBitBtnLocked;
    BtnMarcarTodas: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    grdDuplicDadosMARDES: TcxGridDBColumn;
    grdDuplicDadosDDA_DUPCOR: TcxGridDBColumn;
    grdDuplicDadosDDA_AUTCTP: TcxGridDBColumn;
    gpbLegenda: TGroupBox;
    shp1: TShape;
    lbl1: TLabel;
    lbl3: TLabel;
    Shape1: TShape;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    edtQtdDup: TEditFocus;
    edtSelDup: TEditFocus;
    Label18: TLabel;
    edtCodBarSis: TEdit;
    Label19: TLabel;
    Label20: TLabel;
    edtCodBarArq: TEdit;
    btnBaixarDDA: TBitBtnLocked;
    grdDuplicDadosACAO: TcxGridDBColumn;
    rdgFiltrar: TRadioGroup;
    grdDuplicDadosDIVERGENCIA: TcxGridDBColumn;
    grpDataArquivos: TGroupBox;
    edtDataInicial: TcxDateEdit;
    btnReprocessar: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdDuplicDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure grdDuplicDadosDblClick(Sender: TObject);
    procedure grdDuplicDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnMarcarTodasClick(Sender: TObject);
    procedure btnDesmarcarTodasClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnBaixarDDAClick(Sender: TObject);
    procedure rdgFiltrarClick(Sender: TObject);
    procedure btnReprocessarClick(Sender: TObject);
  private
    FstrConfig: String;
    FstrCodBco: String;

    qrySelDup : TUniQuery;
    cdsSelDup : TUniClientDataSet;
    dtsSelDup : TDataSource;

    blnMarcarT: Boolean;
    blnComDiv: Boolean;

    FDataInicial: TDateTime;

    function fCriaTemporaria(pgbStatus: TcxProgressBar = Nil): Boolean;
    procedure pAtualizaDados(DataSet: TDataSet);
    procedure pAtualizaTemporaria;
    procedure pLimpaCampos;

    procedure pSelecionaDuplicata;

    procedure pCriaAgrFields;

    procedure pStep(pgbStatus: TcxProgressBar);

    function fRetNomOcoDDA(strCodOco: String): String;

    function fMarcarTodas(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fDesmarcarTodas(pgbStatus: TcxProgressBar): Boolean;
    function fAtualizarDuplicatas(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fAtualizaDDA: Boolean;
    function fAtualizaDupDDA: Boolean;
    { Private declarations }
  public
    property strConfig: String read FstrConfig write FStrConfig;
    property strCodBco: String read FstrCodBco write FstrCodBco;
    { Public declarations }
  end;

var
  frmCtaAtuDupDDA: TfrmCtaAtuDupDDA;

implementation
Uses untGravando;
{$R *.dfm}

{ TfrmCtaAtuDupDDA }

procedure TfrmCtaAtuDupDDA.pStep(pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;
end;

procedure TfrmCtaAtuDupDDA.rdgFiltrarClick(Sender: TObject);
  Var
    LFiltro: String;
begin
  inherited;
  LFiltro := '';
  If (rdgFiltrar.ItemIndex = 1) Then
    LFiltro := 'DIVERGENCIA<>''S'' '
  Else If (rdgFiltrar.ItemIndex = 2) Then
    LFiltro := 'DIVERGENCIA=''S'' ';

  cdsSelDup.Filter   := LFiltro;
  cdsSelDup.Filtered := Not LFiltro.IsEmpty;

  pLimpaCampos;
  pAtualizaTemporaria;
end;

function TfrmCtaAtuDupDDA.fRetNomOcoDDA(strCodOco: String): String;
Var intCont: Integer;
begin
  Result := '';

  For intCont := Low(NOME_OCORRENCIA_DDA) to High(NOME_OCORRENCIA_DDA) do
  Begin
    If NOME_OCORRENCIA_DDA[intCont][0] = strCodOco Then
    Begin
      Result := NOME_OCORRENCIA_DDA[intCont][1];
      Break;
    End;
  End;
end;

procedure TfrmCtaAtuDupDDA.grdDuplicDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var strMarDes,
      LDivergencia : String;
begin
  inherited;

  If Not cdsSelDup.Active Then
    Exit;

  strMarDes    := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDuplicDadosMARDES.Index]);
  LDivergencia := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDuplicDadosDIVERGENCIA.Index]);

  If strMarDes = 'M' Then
    ACanvas.Font.Color := clBlue
  Else If LDivergencia = 'S' Then
  Begin
    blnComDiv := True;
    ACanvas.Font.Color := clRed;
  End;
end;

procedure TfrmCtaAtuDupDDA.grdDuplicDadosDblClick(Sender: TObject);
Var
  Key: Word;
begin
  inherited;
  If (Not cdsSelDup.Active) Or (cdsSelDup.IsEmpty) Then
  Begin
    fMensagem('', 'É necessário ter registros para marcar!', ['&Ok']);
    Exit;
  End
  Else
  Begin
    Key := VK_Return;
    grdDuplicDados.OnKeyDown(grdDuplicDados, Key, []);
  End;
end;

procedure TfrmCtaAtuDupDDA.grdDuplicDadosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Not cdsSelDup.Active) Or (cdsSelDup.IsEmpty) Then
    Exit;

  If (Key = VK_Return) Or (Key = VK_SPACE) Then
  Begin
    If (cdsSelDup.FieldByName('DIVERGENCIA').AsString = 'S') And (cdsSelDup.FieldByName('MARDES').AsString <> 'M') Then
      If fMensagem('', 'Essa duplicata foi encontrada no sistema, mas o número cadastrado não é o mesmo do importado no arquivo. Deseja realmente continuar?', ['&Sim', '&Não']) = 2 Then
        Exit;

    grdDuplic.Enabled := False;
    pnlBotoes.Enabled := False;
    pSelecionaDuplicata;
    If (cdsSelDup.RecordCount > 0) Then
      Key := VK_DOWN;
    grdDuplic.Enabled := True;
    pSetFocus(grdDuplic);
    pnlBotoes.Enabled := True;
  End;
end;

procedure TfrmCtaAtuDupDDA.pAtualizaDados(DataSet: TDataSet);
begin
  With cdsSelDup Do
  Begin
    If (Not Active) Or (IsEmpty) Then
      Exit;

    edtCedente.Text    := FieldByName('DDA_NOMCED').AsString;
    edtCNPJArq.Text    := FieldByName('DDA_CNPJ__').AsString;
    edtDtaVenArq.Text  := FormatDateTime('dd/mm/yyyy', FieldByName('DDA_DTAVEN').Value);
    edtDtaEmiArq.Text  := FormatDateTime('dd/mm/yyyy', FieldByName('DDA_DTAEMI').Value);
    edtNumDupArq.Text  := FieldByName('DDA_NUMDUP').AsString;
    edtValorArq.Text   := FormatFloat('#,##0.00', FieldByName('DDA_VALTIT').AsFloat);
    edtLinDigArq.Text  := FieldByName('DDA_LINDIG').AsString;
    edtCodBarArq.Text  := FieldByName('DDA_CODBAR').AsString;
    edtCodAge.Text     := FieldByName('DDA_CODAGE').AsString;
    edtConta.Text      := FieldByName('DDA_CODCTA').AsString;
    edtDtaArq.Text     := FormatDateTime('dd/mm/yyyy', FieldByName('DDA_DTAARQ').Value);
    edtOcorre.Text     := FieldByName('DDA_CODMOV').AsString + '-' + fRetNomOcoDDA(FieldByName('DDA_CODMOV').AsString);
    edtFornecedor.Text := FieldByName('FOR_NOMFOR').AsString;
    edtCNPJSis.Text    := FieldByName('FOR_C_G_C_').AsString;
    edtDtaVenSis.Text  := FormatDateTime('dd/mm/yyyy', FieldByName('CTP_DTAVEN').Value);
    edtLinDigSis.Text  := FieldByName('CTP_LINDIG').AsString;
    edtCodBarSis.Text  := FieldByName('CTP_CODBAR').AsString;

    if FieldByName('CTP_DTACAD').Value = Null then
      edtDtaCadSis.Text  := ''
    else
      edtDtaCadSis.Text  := FormatDateTime('dd/mm/yyyy', FieldByName('CTP_DTACAD').Value);

    edtNumDupSis.Text  := FieldByName('CTP_NUMDUP').AsString;
    edtValorSis.Text   := FormatFloat('#,##0.00', FieldByName('CTP_VALORI').AsFloat);
  End;
end;

procedure TfrmCtaAtuDupDDA.btnBaixarDDAClick(Sender: TObject);
begin
  inherited;
  if cdsSelDup.IsEmpty then
  begin
    fMensagem('', 'Sem duplicatas para baixa direta!', ['&Ok']);

    Exit;
  end;

  If cdsSelDup.FieldByName('MARDES').AsString <> 'M' Then
  begin
    if (fMensagem('', 'Confirma baixa direta da duplicata nas rotinas do DDA? ' + #13 + #13 +
                      ' Duplicata deixará de ser listada nas rotinas do DDA e em caso de estar '  + #13 +
                      ' pendente no banco, a linha dígitavel/código de barras deve ser informada ' + #13+
                      ' direto no manutenção do contas a pagar ou a baixa, no banco, deverá  ' + #13 +
                      ' ocorrer de forma manual.', ['&Sim', '&Não'], 2, True, 1, 0, False, 0, False, False, False, 230) = 1) then
    begin
      cdsSelDup.Edit;

      cdsSelDup.FieldByName('DDA_ACAO').AsString := 'Baixa Direta';
      cdsSelDup.FieldByName('MARDES').AsString := 'M';
      cdsSelDup.FieldByName('TOTSEL').Value    := cdsSelDup.FieldByName('DDA_VALTIT').Value;
      cdsSelDup.FieldByName('QTDSEL').Value    := 1;

      cdsSelDup.Post;

      pAtualizaTemporaria;
    end;
  end
  Else
    fMensagem('', 'A duplicata não pode estar marcada!', ['&Ok']);
end;

procedure TfrmCtaAtuDupDDA.btnConfirmaClick(Sender: TObject);
Var
  cdsAux: TUniClientDataSet;
begin
  inherited;
  If Not cdsSelDup.IsEmpty  Then
  Begin
    cdsAux := TUniClientDataSet.Create(Nil);
    cdsAux.Data := cdsSelDup.Data;

    cdsAux.DisableControls;
    cdsAux.Filtered := False;
    cdsAux.Filter   := 'MARDES = ' + QuotedStr('M');
    cdsAux.Filtered := True;

    If cdsAux.FieldByName('MARDES').AsString <> 'M' Then
    Begin
      fMensagem('','É necessário selecionar ao menos um registro!',['&O K']);
      Exit;
    End;
  End
  Else
  Begin
    fMensagem('', 'É necessário selecionar ao menos um registro!', ['&Ok']);
    Exit;
  End;

  If (fMensagem('', 'Confirma a atualização das duplicatas?', ['&Sim', '&Não']) = 2) Then
    Exit;

  pnlBotoes.Enabled := False;
  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarAcao := fAtualizarDuplicatas;
  frmGravando.lblGravando.Caption := 'Aguarde... Atualizando Duplicatas.';
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
  pnlBotoes.Enabled := True;
end;

procedure TfrmCtaAtuDupDDA.btnDesmarcarTodasClick(Sender: TObject);
begin
  inherited;
  If (Not cdsSelDup.Active) Or (cdsSelDup.IsEmpty) Then
  Begin
    fMensagem('', 'É necessário ter registros para marcar!', ['&Ok']);
    Exit;
  End;

  If (fMensagem('', 'Confirma desmarcar todas as duplicatas?', ['&Sim', '&Não']) = 2) Then
    Exit;

  pnlBotoes.Enabled := False;
  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarAcao := fDesmarcarTodas;
  frmGravando.lblGravando.Caption := 'Aguarde... Desmarcando Duplicatas.';
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
  pnlBotoes.Enabled := True;
end;

procedure TfrmCtaAtuDupDDA.BtnMarcarTodasClick(Sender: TObject);
begin
  inherited;
  If (Not cdsSelDup.Active) Or (cdsSelDup.IsEmpty) Then
  Begin
    fMensagem('', 'É necessário ter registros para marcar!', ['&Ok']);
    Exit;
  End;

  If (fMensagem('', 'Confirma selecionar todas as duplicatas?', ['&Sim', '&Não']) = 2) Then
    Exit;

  If blnComDiv Then
  Begin
    If fMensagem('', 'Alguns documentos filtrados foram encontrados no sistema, mas com o número cadastrado diferente do importado no arquivo.' + #13 + 'Deseja realmente continuar?', ['&Sim', '&Não']) = 2 Then
      Exit;
  End;

  pnlBotoes.Enabled := False;
  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarAcao := fMarcarTodas;
  frmGravando.lblGravando.Caption := 'Aguarde... Marcando Duplicatas.';
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
  pnlBotoes.Enabled := True;
end;

procedure TfrmCtaAtuDupDDA.btnReprocessarClick(Sender: TObject);
begin
  inherited;
  If FDataInicial = edtDataInicial.Date Then
  Begin
    fMensagem('ATENÇÃO', 'Para reprocessar, a data inicial deve ser modificada.', ['&Ok']);
    Exit;
  End;

  FDataInicial := edtDataInicial.Date;
  TFuncoesDDA.DataInicialDDA := FDataInicial;

  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarAcao := TFuncoesDDA.fAtualizaFornDDA;
  frmGravando.lblGravando.Caption := 'Aguarde... Atualizando Fornecedores.';
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);

  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarAcao := TFuncoesDDA.fUpdAutoIncremCTPDDA;
  frmGravando.lblGravando.Caption := 'Aguarde... Atualizando Sequencial.';
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);

  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarAcao := fCriaTemporaria;
  frmGravando.lblGravando.Caption := 'Aguarde... Selecionando Duplicatas.';
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);

  pAtualizaTemporaria;
end;

function TfrmCtaAtuDupDDA.fMarcarTodas(pgbStatus: TcxProgressBar): Boolean;
Var prcScroll: TprcScroll;
begin
  Result := True;
  blnComDiv := False;
  With cdsSelDup Do
  Begin

    Try
      blnMarcarT := True;
      pDisableControls(cdsSelDup, prcScroll);
      AggregatesActive := False;
      First;

      pgbStatus.Position := 0;
      pgbStatus.Properties.Max := cdsSelDup.RecordCount;

      While Not Eof Do
      Begin
        pStep(pgbStatus);
        Try
          If (FieldByName('MARDES').AsString <> 'M') Then
            pSelecionaDuplicata;
        Except
          On E: Exception Do
          Begin
            Result := False;
            fMensagem('','Ocorreu um erro ao Marcar o Registro para Atualização !' + #13 + E.Message,['&OK']);
            Break;
          End;
        End;
        Next;
      End;
    Finally
      blnMarcarT := False;
      First;
      AggregatesActive := True;
      pEnableControls(cdsSelDup, prcScroll);

    End;
  End;

  pAtualizaTemporaria;
end;

function TfrmCtaAtuDupDDA.fAtualizaDDA: Boolean;
const
  SQL_UPDATE =
    ' UPDATE RETDDA' +
    ' SET ' +
    '   DDA_OPEBAI = :OPEBAI,' +
    '   DDA_DTABAI = :DTABAI,' +
    '   DDA_HORBAI = :HRABAI,' +
    '   DDA_TIPBAI = :TIPBAI,' +
    '   DDA_AUTCTP = :AUTCTP' +
    ' WHERE DDA_CODBCO = :CODBCO' +
    '   AND DDA_BCOCOM = :BCOCOM' +
    '   AND DDA_CODEMP = :CODEMP' +
    '   AND DDA_NUMDUP = :NUMDUP' +
    '   AND DDA_CODFOR = :CODFOR' +
    '   AND DDA_DTAVEN = :DTAVEN' +
    '   AND DDA_VALTIT = :VALTIT' +
    '   AND DDA_CODMOV = :CODMOV' +
    '   AND DDA_DTAARQ = :DTAARQ';

Var
  qryUpdDDA: TUniQuery;

begin
  Result :=True;
  Application.ProcessMessages;

  Try
    qryUpdDDA := fCriaQuery(Nil);

    qryUpdDDA.Close;
    qryUpdDDA.SQL.Clear;
    qryUpdDDA.SQL.Add(SQL_UPDATE);

    qryUpdDDA.ParamByName('OPEBAI').AsString := strLoginUsuarioLogado;
    qryUpdDDA.ParamByName('DTABAI').AsDateTime := VS_DATE;
    qryUpdDDA.ParamByName('HRABAI').AsDateTime := fTime();
    qryUpdDDA.ParamByName('TIPBAI').AsString := cdsSelDup.FieldByName('DDA_ACAO').AsString;

    if not fEmptyStr(cdsSelDup.FieldByName('DDA_AUTCTP').AsString) then
      qryUpdDDA.ParamByName('AUTCTP').AsString := cdsSelDup.FieldByName('DDA_AUTCTP').AsString
    else
      qryUpdDDA.ParamByName('AUTCTP').Value := Null;

    qryUpdDDA.ParamByName('CODBCO').AsString   := cdsSelDup.FieldByName('DDA_CODBCO').AsString;
    qryUpdDDA.ParamByName('BCOCOM').AsString   := cdsSelDup.FieldByName('DDA_BCOCOM').AsString;
    qryUpdDDA.ParamByName('NUMDUP').AsString   := cdsSelDup.FieldByName('DDA_NUMDUP').AsString;
    qryUpdDDA.ParamByName('CODFOR').AsString   := cdsSelDup.FieldByName('DDA_CODFOR').AsString;
    qryUpdDDA.ParamByName('CODEMP').AsString   := cdsSelDup.FieldByName('DDA_CODEMP').AsString;
    qryUpdDDA.ParamByName('DTAVEN').AsDateTime := cdsSelDup.FieldByName('DDA_DTAVEN').AsDateTime;
    qryUpdDDA.ParamByName('VALTIT').Value      := cdsSelDup.FieldByName('DDA_VALTIT').Value;
    qryUpdDDA.ParamByName('DTAARQ').AsDateTime := cdsSelDup.FieldByName('DDA_DTAARQ').AsDateTime;
    qryUpdDDA.ParamByName('CODMOV').AsString := cdsSelDup.FieldByName('DDA_CODMOV').AsString;

    qryUpdDDA.ExecSQL;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TfrmCtaCadDupDDA.fAtualizaDDA');
    End;
  End;

  qryUpdDDA.Close;
  FreeAndNil(qryUpdDDA);
end;

function TfrmCtaAtuDupDDA.fAtualizaDupDDA: Boolean;
Var qryUpdDDA: TUniQuery;
    strSQL   : String;
begin
  Result := True;
  strSQL := '';

  strSQL := strSQL + ' UPDATE ' + cdsSelDup.FieldByName('TABELA').AsString + ' SET CTP_LINDIG = :LINDIG, CTP_CODBAR = :CODBAR ';

  strSQL := strSQL + ' WHERE AUTOINCREM = :AUTINC ';
  Application.ProcessMessages;

  Try
    qryUpdDDA := fCriaQuery(Nil);
    With qryUpdDDA do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('AUTINC').AsString   := IIF(Not fEmptyStr(cdsSelDup.FieldByName('DDA_AUTCTP').AsString), cdsSelDup.FieldByName('DDA_AUTCTP').AsString, cdsSelDup.FieldByName('AUTOINCREM').AsString);
      ParamByName('CODBAR').AsString   := cdsSelDup.FieldByName('DDA_CODBAR').AsString;
      ParamByName('LINDIG').AsString   := cdsSelDup.FieldByName('DDA_LINDIG').AsString;

      ExecSQL;
    End;
  Except
   On E: Exception Do
   Begin
     Result := False;
     pMensagensErro(E.Message,'');
   End;
  End;
  qryUpdDDA.Close;
  FreeAndNil(qryUpdDDA);
end;

function TfrmCtaAtuDupDDA.fAtualizarDuplicatas(
  pgbStatus: TcxProgressBar): Boolean;
Var prcScroll   : TprcScroll;
    blnConfirma : Boolean;
    objCadPag   : TCadPag;
    objPagRep   : TCadPagRepository;
    strGetCodFor: String;
begin
  Result := True;
  blnConfirma := True;

  With cdsSelDup Do
  Begin

    fStartTransaction;
    Try
      pDisableControls(cdsSelDup, prcScroll);
      AggregatesActive := False;
      First;

      Filter := 'MARDES=' + QuotedStr('M');
      Filtered := True;

      pgbStatus.Position := 0;
      pgbStatus.Properties.Max := cdsSelDup.RecordCount;

      objPagRep := TCadPagRepository.Create;
      While (Not Eof) And (blnConfirma) Do
      Begin
        pStep(pgbStatus);
        If (FieldByName('DDA_ACAO').AsString <> 'Baixa Direta') Then
        Begin
          Try
            blnConfirma := fAtualizaDupDDA;

            If blnConfirma Then
            Begin
              objCadPag   := objPagRep.fRetDuplicata(FieldByName('CTP_NUMDUP').AsString,
                                             FieldByName('CTP_PARCEL').AsString,
                                             FieldByName('CTP_SEQBAI').AsInteger,
                                             FieldByName('CTP_CODEMP').AsString,
                                             FieldByName('CTP_CODFOR').AsString,
                                             FieldByName('CTP_SERIE_').AsString);
              strGetCodFor := objCadPag.objCodFor.FOR_CODFOR;

              pGravaLogCtp(objCadPag,
                           'ATUALIZAÇÃO DA LINHA DIGITÁVEL E CÓDIGO DE BARRAS - DDA',
                           'frmCtaAtuDupDDA');
            End;

            If blnConfirma Then
              blnConfirma := fAtualizaDDA;

            If Not blnConfirma Then
              Break;
          Except
            On E: Exception Do
            Begin
              blnConfirma := False;
              Result := False;
              Raise Exception.Create('Ocorreu um erro ao atualizar as duplicatas!!' + #13 +
                                     'Erro gerado: ' + E.Message);
              Break;
            End;
          End;
        End
        Else If (FieldByName('DDA_ACAO').AsString = 'Baixa Direta') Then
        Begin

          blnConfirma := fAtualizaDDA;

          If Not blnConfirma Then
            Break;
        End;
        Next;
      End;
    Finally
      rdgFiltrar.OnClick(rdgFiltrar);

      First;
      AggregatesActive := True;
      pEnableControls(cdsSelDup, prcScroll);

      If blnConfirma Then
      Begin
        fCommit;
        pMensagemOK('Duplicatas atualizadas com sucesso!');
      End
      Else
      Begin
        fRollBack;
        pMensagemOK('Ocorreu algum erro ao atualizar as duplicatas.');
      End;
    End;

    FreeAndNil(objPagRep);

    pLimpaCampos;

    pCriarFormularios(TfrmGravando,frmGravando);
    frmGravando.fExecutarAcao := fCriaTemporaria;
    frmGravando.lblGravando.Caption := 'Aguarde... Selecionando Duplicatas.';
    frmGravando.ShowModal;
    pFreeAndNil(frmGravando);

    pAtualizaTemporaria;
  End;
end;

function TfrmCtaAtuDupDDA.fDesmarcarTodas(pgbStatus: TcxProgressBar): Boolean;
Var prcScroll: TprcScroll;
begin
  Result := True;
  With cdsSelDup Do
  Begin

    Try
      blnMarcarT := True;
      pDisableControls(cdsSelDup, prcScroll);
      AggregatesActive := False;
      First;

      pgbStatus.Position := 0;
      pgbStatus.Properties.Max := cdsSelDup.RecordCount;

      While Not Eof Do
      Begin
        pStep(pgbStatus);
        Try
          If (FieldByName('MARDES').AsString = 'M') Then
            pSelecionaDuplicata;
        Except
          On E: Exception Do
          Begin
            Result := False;
            fMensagem('','Ocorreu um erro ao Desmarcar o Registro para Atualização !' + #13 + E.Message,['&OK']);
            Break;
          End;
        End;
        Next;
      End;
    Finally
      blnMarcarT := False;
      First;
      AggregatesActive := True;
      pEnableControls(cdsSelDup, prcScroll);

    End;
  End;

  pAtualizaTemporaria;
end;

procedure TfrmCtaAtuDupDDA.FormCreate(Sender: TObject);
begin
  inherited;
  If TFuncoesDDA.DataInicialDDA = 0 Then
    TFuncoesDDA.DataInicialDDA := IncMonth(VS_Date, -3);

  FDataInicial := TFuncoesDDA.DataInicialDDA;
  edtDataInicial.Date := FDataInicial;

  //Iniciando variáveis
  qrySelDup := fCriaQuery(Nil);
  cdsSelDup := TUniClientDataSet.Create(Self);
  cdsSelDup.AggregatesActive := True;
  pCriaAgrFields;

  dtsSelDup := fCriaDataSource(cdsSelDup);
  grdDuplicDados.DataController.DataSource := dtsSelDup;
  blnMarcarT := False;
end;

procedure TfrmCtaAtuDupDDA.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F4) Then
    btnBaixarDDA.Click
  Else If (Key = VK_F7) Then
    btnMarcarTodas.Click
  Else If (Key = VK_F8) Then
    btnDesmarcarTodas.Click
  Else If (Key = VK_F10) Then
    btnConfirma.Click
  Else If (Key = VK_ESCAPE) Then
    btnSair.Click;
end;

procedure TfrmCtaAtuDupDDA.FormShow(Sender: TObject);
begin
  inherited;
  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarAcao := TFuncoesDDA.fAtualizaFornDDA;
  frmGravando.lblGravando.Caption := 'Aguarde... Atualizando Fornecedores.';
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);

  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarAcao := TFuncoesDDA.fUpdAutoIncremCTPDDA;
  frmGravando.lblGravando.Caption := 'Aguarde... Atualizando Sequencial.';
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);

  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarAcao := fCriaTemporaria;
  frmGravando.lblGravando.Caption := 'Aguarde... Selecionando Duplicatas.';
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);

  pAtualizaTemporaria;
end;

procedure TfrmCtaAtuDupDDA.pCriaAgrFields;
begin
  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_TOTSEL';
    FieldName     := 'TOT_TOTSEL';
    DataSet       := cdsSelDup;
    Expression    := 'SUM(TOTSEL)';
    DisplayFormat := '#,##0.00';
    Active        := True;
  End;
  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_VALTIT';
    FieldName     := 'TOT_VALTIT';
    DataSet       := cdsSelDup;
    Expression    := 'SUM(DDA_VALTIT)';
    DisplayFormat := '#,##0.00';
    Active        := True;
  End;
  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_QTDSEL';
    FieldName     := 'TOT_QTDSEL';
    DataSet       := cdsSelDup;
    Expression    := 'SUM(QTDSEL)';
    Active        := True;
  End;
  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_QTDTIT';
    FieldName     := 'TOT_QTDTIT';
    DataSet       := cdsSelDup;
    Expression    := 'COUNT(DDA_NUMDUP)';
    Active        := True;
  End;
end;

function TfrmCtaAtuDupDDA.fCriaTemporaria(pgbStatus: TcxProgressBar = Nil): Boolean;
  Var
    strSQL : String;
    prcScroll: TprcScroll;
begin
  Result := True;
  strSQL := '';
  strSQL := strSQL + 'SELECT D.*, P.*, F.FOR_NOMFOR, F.FOR_C_G_C_, "CADPAG" AS TABELA, ';
  strSQL := strSQL + '       "D" AS MARDES, CAST(0 AS DECIMAL(15,2)) AS TOTSEL, 0 AS QTDSEL, CAST(" " AS CHAR(100)) AS DDA_ACAO, ';
  strSQL := strSQL + '       "N" AS DIVERGENCIA ';
  strSQL := strSQL + '  FROM RETDDA D ';
  strSQL := strSQL + '  JOIN CADPAG P ON (P.AUTOINCREM=D.DDA_AUTCTP) ';
  strSQL := strSQL + '  JOIN CADFOR F ON F.FOR_CODFOR = P.CTP_CODFOR ';
  strSQL := strSQL + '  WHERE D.DDA_CODBCO = ' + QuotedStr(Copy(FstrConfig, 10, 3));
  strSQL := strSQL + '    AND D.DDA_DTAARQ>="' + FormatDateTime('yyyy-mm-dd', FDataInicial) + '" ';
  strSQL := strSQL + '    AND D.DDA_DTABAI IS NULL ';

  strSQL := 'SELECT * FROM (' + strSQL + ' ORDER BY DDA_CODMOV, DDA_NUMDUP, DDA_CODEMP, DDA_DTAVEN) AS RETTMP GROUP BY DDA_CODBAR';

  Try
    blnComDiv := False;
    cdsSelDup.Close;
    With qrySelDup do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      If Not qrySelDup.IsEmpty  Then
        pSetaClient(qrySelDup);

      cdsSelDup.Filtered := False;

      Application.ProcessMessages;

      If Assigned(cdsSelDup) Then
        FreeAndNil(cdsSelDup);

      cdsSelDup := fCriaClientDatset(qrySelDup);
      cdsSelDup.Close;

      cdsSelDup.AggregatesActive := True;
      pCriaAgrFields;

      dtsSelDup := fCriaDataSource(cdsSelDup);
      grdDuplicDados.DataController.DataSource := dtsSelDup;

      cdsSelDup.Open;

      (cdsSelDup.FieldByName('DDA_VALTIT') As TFloatField).DisplayFormat    := '#,##0.00';
      cdsSelDup.AfterScroll := Nil;

      With cdsSelDup Do
      Begin
        //Removendo duplicatas com codigo de barras ou linha digitavel ja cadastrados
        SetProvider(Nil);
        First;

        pgbStatus.Position := 0;
        pgbStatus.Properties.Max := cdsSelDup.RecordCount;

        pDisableControls(cdsSelDup, prcScroll);
        cdsSelDup.AggregatesActive := False;


        While Not Eof do
        Begin
          If fVerificaLinDigCtaPag(False,
                                   FieldByName('DDA_LINDIG').AsString,
                                   FieldByName('DDA_CODBAR').AsString,
                                   FieldByName('AUTOINCREM').AsString).Count > 0 Then
          Begin
            Delete;
            Continue;
          End;

          //Validando número da duplicata
          If Not TFuncoesDDA.ValidaNumeroDuplicataDDA(FieldByName('CTP_NUMDUP').AsString, FieldByName('DDA_DUPCOR').AsString) Then
          Begin
            Edit;
            FieldByName('DIVERGENCIA').AsString := 'S';
            Post;
          End;

          Application.ProcessMessages;

          pStep(pgbStatus);
          Next;
        End;
        First;
      End;

      If Not cdsSelDup.IsEmpty Then
        rdgFiltrar.OnClick(rdgFiltrar);

      If (IsEmpty) Or (Not Active) Then
      Begin
        pLimpaCampos;
        pSetFocus(btnSair);
      End
      Else
        pSetFocus(grdDuplic);
    End;
  Finally
    qrySelDup.Close;
    cdsSelDup.AggregatesActive := True;
    pEnableControls(cdsSelDup, prcScroll);
    cdsSelDup.AfterScroll := pAtualizaDados;
  End;
end;

procedure TfrmCtaAtuDupDDA.pLimpaCampos;
begin
  edtCedente.Clear;
  edtCNPJArq.Clear;
  edtDtaVenArq.Clear;
  edtDtaEmiArq.Clear;
  edtNumDupArq.Clear;
  edtValorArq.Clear;
  edtLinDigArq.Clear;
  edtCodAge.Clear;
  edtConta.Clear;
  edtDtaArq.Clear;
  edtOcorre.Clear;
  edtFornecedor.Clear;
  edtCNPJSis.Clear;
  edtDtaVenSis.Clear;
  edtDtaCadSis.Clear;
  edtNumDupSis.Clear;
  edtValorSis.Clear;
  edtLinDigSis.Clear;
  edtCodBarSis.Clear;
  edtCodBarArq.Clear;
end;

procedure TfrmCtaAtuDupDDA.pSelecionaDuplicata;
begin
  With cdsSelDup do
  Begin
    Edit;
    If FieldByName('MARDES').AsString <> 'M' Then
    Begin
      FieldByName('MARDES').AsString := 'M';
      FieldByName('TOTSEL').Value    := FieldByName('DDA_VALTIT').Value;
      FieldByName('QTDSEL').Value    := 1;
      FieldByName('DDA_ACAO').AsString := 'Atualizar';
    End
    Else
    Begin
      FieldByName('MARDES').AsString := 'D';
      FieldByName('TOTSEL').Value    := 0;
      FieldByName('QTDSEL').Value    := 0;
      FieldByName('DDA_ACAO').AsString := ' ';
    End;
    Post;
  End;

  If Not blnMarcarT Then
    pAtualizaTemporaria;
end;

procedure TfrmCtaAtuDupDDA.pAtualizaTemporaria;
begin
  With cdsSelDup Do
  Begin
    If Not IsEmpty Then
    Begin

      edtTotalDup.Text         := FormatFloat('#,##0.00', fDoubleAggregate(cdsSelDup, 'TOT_VALTIT'));
      edtTotalSelecionado.Text := FormatFloat('#,##0.00', fDoubleAggregate(cdsSelDup, 'TOT_TOTSEL'));
      edtQtdDup.Text           := InttoStr(fIntAggregate(cdsSelDup, 'TOT_QTDTIT'));
      edtSelDup.Text           := InttoStr(fIntAggregate(cdsSelDup, 'TOT_QTDSEL'));

      pAtualizaDados(Nil);
    End
    Else
    Begin
      edtTotalDup.Text         := '0,00';
      edtTotalSelecionado.Text := '0,00';
      edtQtdDup.Text           := '0';
      edtSelDup.Text           := '0';
    End;
  End;
end;

end.
