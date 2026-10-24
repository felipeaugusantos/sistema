unit untAtribuicaoOcorrenciasEmergenciasCRM;

interface

uses
  Windows, Classes, Controls, Forms, untPaiSimples, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  MaskEditFocus, EditFocus, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, UniClientDataSet, UniDataSetProvider, Uni,
  cxProgressBar, BitBtnLockedIncrem, cxLookAndFeels,
  cxLookAndFeelPainters, cxNavigator, MemDS, DBAccess, Provider, Mask,
  cxDataControllerConditionalFormattingRulesManagerDialog, Datasnap.DBClient,
  frxClass, frxExportCSVTestabilidade;

type
  TfrmAtribuicaoOcorrenciasEmergenciasCRM = class(TfrmPaiSimples)
    pnlGeral: TPanel;
    pnlCabecalho: TPanel;
    pnlBotoesInferiores: TPanel;
    Panel1: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    edtCodCli: TEditFocus;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    edtProtoc: TEditFocus;
    edtDesCli: TEditFocus;
    edtCodGoc: TEditFocus;
    edtDesGoc: TEditFocus;
    edtDesToc: TEditFocus;
    edtCodToc: TEditFocus;
    dbgOcorrenciasDBTableView1: TcxGridDBTableView;
    dbgOcorrenciasLevel1: TcxGridLevel;
    dbgOcorrencias: TcxGrid;
    dtsOcorrencias: TDataSource;
    cdsOcorrencias: TUniClientDataSet;
    cdsOcorrenciasOCO_CODOCO: TStringField;
    cdsOcorrenciasOCO_CODTOC: TStringField;
    cdsOcorrenciasTOC_DESTOC: TStringField;
    cdsOcorrenciasOCO_CODCLI: TStringField;
    cdsOcorrenciasGOC_CODGOC: TStringField;
    cdsOcorrenciasGOC_DESGOC: TStringField;
    cdsOcorrenciasCLI_NOMCLI: TStringField;
    cdsOcorrenciasOCO_DTAINC: TDateField;
    cdsOcorrenciasOCO_HORINC: TTimeField;
    cdsOcorrenciasOCO_DTACON: TDateField;
    cdsOcorrenciasOCO_HORCON: TTimeField;
    cdsOcorrenciasOCO_CODOPE: TStringField;
    cdsOcorrenciasOPE_NOMOPE: TStringField;
    cdsOcorrenciasOCO_CODEMP: TStringField;
    cdsOcorrenciasOCO_OPEOCO: TStringField;
    cdsOcorrenciasNOPEOCO: TStringField;
    dbgOcorrenciasDBTableView1TOC_DESTOC: TcxGridDBColumn;
    dbgOcorrenciasDBTableView1GOC_DESGOC: TcxGridDBColumn;
    dbgOcorrenciasDBTableView1CLI_NOMCLI: TcxGridDBColumn;
    dbgOcorrenciasDBTableView1OCO_DTAINC: TcxGridDBColumn;
    dbgOcorrenciasDBTableView1OCO_HORINC: TcxGridDBColumn;
    dbgOcorrenciasDBTableView1OCO_DTACON: TcxGridDBColumn;
    dbgOcorrenciasDBTableView1OCO_HORCON: TcxGridDBColumn;
    dbgOcorrenciasDBTableView1OPE_NOMOPE: TcxGridDBColumn;
    dbgOcorrenciasDBTableView1OCO_CODEMP: TcxGridDBColumn;
    dbgOcorrenciasDBTableView1NOPEOCO: TcxGridDBColumn;
    qryOcorrencias: TUniQuery;
    dspOcorrencias: TUniDataSetProvider;
    cdsOcorrenciasOCO_PROTOC: TStringField;
    dbgOcorrenciasDBTableView1OCO_PROTOC: TcxGridDBColumn;
    dbgOcorrenciasDBTableView1OCO_CODTOC: TcxGridDBColumn;
    dbgOcorrenciasDBTableView1GOC_CODGOC: TcxGridDBColumn;
    edtOpeOco: TEditFocus;
    edtDesOpeOco: TEditFocus;
    Label1: TLabel;
    cdsOcorrenciasSELECAO: TStringField;
    dbgOcorrenciasDBTableView1SELECAO: TcxGridDBColumn;
    btnIniBus: TBitBtnLocked;
    btnLocProx: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    btnMarcar: TBitBtnLocked;
    btnDesmarcar: TBitBtnLocked;
    btnSairBaixa: TBitBtnLocked;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnSairBaixaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cdsOcorrenciasAfterScroll(DataSet: TDataSet);
    procedure btnIniBusClick(Sender: TObject);
    procedure btnLocProxClick(Sender: TObject);
    procedure dbgOcorrenciasDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodGocKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodTocKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtOpeOcoKeyPress(Sender: TObject; var Key: Char);
    procedure dbgOcorrenciasDBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnMarcarClick(Sender: TObject);
    procedure btnDesmarcarClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    qryCadCli: TUniQuery;
    qryCadGoc: TUniQuery;
    qryCadToc: TUniQuery;
    qryCadOpe: TUniQuery;

    strValFil: String;
    strCamFil: String;

    arrOpeEmer: Array of String;    

    procedure pCarregaCliente;
    procedure pCarregaGrupoOcorrencia;
    procedure pCarregaTipoOcorrencia;
    procedure pConsultaOcorrencias;
    procedure pHabilitaBotoesPanelInferior;
    procedure pDesabilitaBotoesPanelInferior;
    procedure pFilterRecord(DataSet: TDataSet; Var Accept: Boolean);
    procedure pCarregaUsuarioOrigem;
    procedure pSelecionaLinha;
    procedure pMarcarTodas;
    procedure pDesmarcarTodas;
    procedure pChamaFormularioSelecaoOpeEmergencial;
    procedure pPreencheArrayOpeEmergencial(ArrayOperadores: Array Of String);
    procedure pAtribuiOperadoresOcorrenciasEmergenciais;
    procedure pIniciarProcessoDeAtribuicao;
    procedure pAdicionaOperadorNaOcorrenciaEmergencial(strCodOpe,strCodOco,strCodEmp: String);

    function fRetornaSQLConsulta: String;
    function fExisteSelecao: Boolean;
    function fAtribuiOperadores(pgbStatus: TcxProgressBar = Nil): Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;


implementation

uses SysUtils, Variants, Graphics, untFuncoesSimples, untConsultas, untPesqAux,
     untGravando, untConsultaOcorrenciaCrmBusca, untCadOpeOcorrEmergCRM,
     untTypesSistema;

{$R *.dfm}

{ TfrmAtribuicaoOcorrenciasEmergenciasCRM }

procedure TfrmAtribuicaoOcorrenciasEmergenciasCRM.btnConfirmaClick(
  Sender: TObject);
begin
  inherited;
  If Not cdsOcorrencias.IsEmpty Then
    pIniciarProcessoDeAtribuicao;
end;

procedure TfrmAtribuicaoOcorrenciasEmergenciasCRM.btnDesmarcarClick(
  Sender: TObject);
begin
  inherited;
  If (Not cdsOcorrencias.IsEmpty) Then
    pDesmarcarTodas;
end;

procedure TfrmAtribuicaoOcorrenciasEmergenciasCRM.btnIniBusClick(Sender: TObject);
begin
  inherited;
  If cdsOcorrencias.IsEmpty Then
    Exit;

  Try
    Try
      pCriarFormularios(TfrmConsultaOcorrenciaCrmBusca, frmConsultaOcorrenciaCrmBusca);
      frmConsultaOcorrenciaCrmBusca.ShowModal;

      If (Not fEmptyStr(frmConsultaOcorrenciaCrmBusca.strValorFiltro)) Then
      Begin
        strValFil := frmConsultaOcorrenciaCrmBusca.strValorFiltro;
        strCamFil := frmConsultaOcorrenciaCrmBusca.strCampoFiltro;
        cdsOcorrencias.FindFirst;
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;
  Finally
    pFreeAndNil(frmConsultaOcorrenciaCrmBusca);
  End;
end;

procedure TfrmAtribuicaoOcorrenciasEmergenciasCRM.btnLocProxClick(Sender: TObject);
begin
  inherited;
  If (Not cdsOcorrencias.IsEmpty) And (Not fEmptyStr(strCamFil)) Then
    cdsOcorrencias.FindNext;
end;

procedure TfrmAtribuicaoOcorrenciasEmergenciasCRM.btnMarcarClick(
  Sender: TObject);
begin
  inherited;
  If (Not cdsOcorrencias.IsEmpty) Then
    pMarcarTodas;
end;

procedure TfrmAtribuicaoOcorrenciasEmergenciasCRM.btnSairBaixaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmAtribuicaoOcorrenciasEmergenciasCRM.cdsOcorrenciasAfterScroll(
  DataSet: TDataSet);
begin
  inherited;
  if not DataSet.IsEmpty then
  begin
    pHabilitaBotoesPanelInferior;
    pSetFocus(dbgOcorrencias);
  end
  else
    pDesabilitaBotoesPanelInferior;
end;

procedure TfrmAtribuicaoOcorrenciasEmergenciasCRM.dbgOcorrenciasDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  strSelecao: String;  
begin
  inherited;
  strSelecao := VarAsType( dbgOcorrenciasDBTableView1.ViewData.Records[AViewInfo.GridRecord.Index].Values[ dbgOcorrenciasDBTableView1SELECAO.Index], varString );

  If (strSelecao = 'S') Then
  Begin
    If (Not AViewInfo.Selected) Then
    Begin
      ACanvas.Font.Color := clBlue;
    End;
  End;
end;

procedure TfrmAtribuicaoOcorrenciasEmergenciasCRM.dbgOcorrenciasDBTableView1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Return) Then
  Begin
    pSelecionaLinha;
  End
  Else If (Key = VK_Escape) Then
  Begin
    btnSair.Click;
  End
  Else If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
  End
  Else If (Key = VK_F3) Then
  Begin
    btnDesmarcar.Click;
  End
  Else If (Key = VK_F4) Then
  Begin
    btnMarcar.Click;
  End
  Else If (Key = VK_F5) Then
  Begin
    btnIniBus.Click;
  End
  Else If (Key = VK_F6) Then
  Begin
    btnLocProx.Click;
  End
end;

procedure TfrmAtribuicaoOcorrenciasEmergenciasCRM.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************AC*}
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtDesCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAtribuicaoOcorrenciasEmergenciasCRM.edtCodGocKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrTOcorr: TConsultasArray;
begin
  {***************************************}
  {* NOVA CONSULTA GRUPOS DE OCORRENCIAS *}
  {************************************AC*}
  If fPesqGruposOcorrencias(Self, edtCodGoc, edtDesGoc, nil, Key, arrTOcorr) Then
  Begin
    If fValidaCampos(edtCodGoc, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAtribuicaoOcorrenciasEmergenciasCRM.edtCodTocKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrTOcorr: TConsultasArray;
begin
  {**************************************}
  {* NOVA CONSULTA TIPOS DE OCORRENCIAS *}
  {***********************************AC*}
  If fPesqTiposOcorrencias(Self, edtCodToc, edtDesToc, nil, Key, arrTOcorr, True, edtCodGoc.Text, False) Then
  Begin
    If fValidaCampos(edtCodToc, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAtribuicaoOcorrenciasEmergenciasCRM.edtOpeOcoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrOpe: TConsultasArray;
begin
  inherited;
  if fPesqOperador(Self, edtOpeOco, edtDesOpeOco, nil, Key, arrOpe) then
  Begin
    If fValidaCampos(edtOpeOco, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmAtribuicaoOcorrenciasEmergenciasCRM.fAtribuiOperadores(
  pgbStatus: TcxProgressBar): Boolean;
var
  qryCon: TUniQuery;
  intCont: Integer;

  procedure pInformacao(strMsg: String);
  begin
    If Assigned(pgbStatus) Then
      TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando')).Caption := strMsg;
    Application.ProcessMessages;
  end;

  procedure pProgress(intPos, intMax: Integer);
  Begin
    If Assigned(pgbStatus) Then
    Begin
      pgbStatus.Properties.Max := intMax;
      pgbStatus.Position := intPos;
      Application.ProcessMessages;
    End;
  End;
begin
  Try
    Result := False;
    
    cdsOcorrencias.DisableControls;

    pInformacao('Carregando Ocorrências Selecionadas, Aguarde....');

    //Retorna as ocorrencias selecionadas;
//    cdsOcorrencias.Filtered := False;
//    cdsOcorrencias.Filter   := 'SELECAO = ' + QuotedStr('S');
//    cdsOcorrencias.Filtered := True;

    pInformacao('Processando Ocorrências Selecionadas, Aguarde....');

    qryCon := fCriaQuery(Self);

    cdsOcorrencias.First;
    While Not cdsOcorrencias.Eof Do
    Begin

      pProgress(cdsOcorrencias.RecNo, cdsOcorrencias.RecordCount);

      If cdsOcorrenciasSELECAO.AsString = 'S' Then
      Begin

        For intCont := 0 To Length(arrOpeEmer) - 1 Do
        Begin
          //Consulta se ja existe esse operador selecionado, na ocorrencia selecionada
          With qryCon Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(' SELECT EME_CODOPE ');
            SQL.Add('   FROM OCOEME ');
            SQL.Add('  WHERE EME_CODOCO = :CODOCO ');
            SQL.Add('    AND EME_CODEMP = :CODEMP ');
            SQL.Add('    AND EME_CODOPE = :CODOPE ');
            ParamByName('CODOCO').AsString := cdsOcorrenciasOCO_CODOCO.AsString;
            ParamByName('CODEMP').AsString := cdsOcorrenciasOCO_CODEMP.AsString;
            ParamByName('CODOPE').AsString := arrOpeEmer[intCont];
            Open;
            //Se não existir então adiciona na ocorrencia selecionada
            If IsEmpty Then
              pAdicionaOperadorNaOcorrenciaEmergencial(arrOpeEmer[intCont],
                                                       cdsOcorrenciasOCO_CODOCO.AsString,
                                                       cdsOcorrenciasOCO_CODEMP.AsString);
          End;
        End;

      End;

      cdsOcorrencias.Next;
    End;

    Result := True;
    
  Finally
    //Retorna as ocorrencias ao seu estado normal
//    cdsOcorrencias.Filtered := False;
//    cdsOcorrencias.Filter   := '';
//    cdsOcorrencias.Filtered := True;
    cdsOcorrencias.EnableControls;
    FreeAndNil(qryCon);
  End;
end;

function TfrmAtribuicaoOcorrenciasEmergenciasCRM.fExisteSelecao: Boolean;
begin
  Result := False;
  Try
    cdsOcorrencias.DisableControls;

    cdsOcorrencias.First;
    While Not cdsOcorrencias.Eof Do
    Begin
      If cdsOcorrenciasSELECAO.AsString = 'S' Then
      Begin
        Result := True;
        Break;
      End;

      cdsOcorrencias.Next;
    End;

    cdsOcorrencias.First;

    If Not Result Then
      fMensagem('ATENÇÃO','É obrigatório selecionar ao menos uma Ocorrência !',['&Ok']);
  Finally
    cdsOcorrencias.EnableControls;
  End;
end;

procedure TfrmAtribuicaoOcorrenciasEmergenciasCRM.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  cdsOcorrencias.Close;
  FreeAndNil(qryCadCli);
  FreeAndNil(qryCadGoc);
  FreeAndNil(qryCadToc);
  FreeAndNil(qryCadOpe);
end;

procedure TfrmAtribuicaoOcorrenciasEmergenciasCRM.FormCreate(Sender: TObject);
begin
  inherited;
  cdsOcorrencias.CreateDataSet;
  cdsOcorrencias.OnFilterRecord := pFilterRecord;
  qryCadCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);
  qryCadGoc := fCriarQuery('SELECT * FROM CADGOC WHERE FALSE', Self);
  qryCadToc := fCriarQuery('SELECT * FROM CADTOC WHERE FALSE', Self);
  qryCadOpe := fCriarQuery('SELECT * FROM CADOPE WHERE FALSE', Self);
end;

procedure TfrmAtribuicaoOcorrenciasEmergenciasCRM.FormShow(Sender: TObject);
begin
  inherited;
  if not fEmptyStr(edtCodCli.Text) then
    fValidaCampos(edtCodCli,True);

  pSetFocus(edtCodCli);
end;

function TfrmAtribuicaoOcorrenciasEmergenciasCRM.fRetornaSQLConsulta: String;
Var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '       OCO_CODOCO,  ';
  strSQL := strSQL + '       OCO_CODTOC,  ';
  strSQL := strSQL + '       TOC_DESTOC,  ';
  strSQL := strSQL + '       OCO_CODCLI,  ';
  strSQL := strSQL + '       GOC_CODGOC,  ';
  strSQL := strSQL + '       GOC_DESGOC,  ';
  strSQL := strSQL + '       CLI_NOMCLI,  ';
  strSQL := strSQL + '       OCO_DTAINC,  ';
  strSQL := strSQL + '       OCO_HORINC,  ';
  strSQL := strSQL + '       OCO_DTACON,  ';
  strSQL := strSQL + '       OCO_HORCON,  ';
  strSQL := strSQL + '       OCO_CODOPE,  ';
  strSQL := strSQL + '       CODOPE.OPE_NOMOPE, ';
  strSQL := strSQL + '       OCO_CODEMP,  ';
  strSQL := strSQL + '       OCO_OPEOCO,  ';
  strSQL := strSQL + '       OPEOCO.OPE_NOMOPE AS NOPEOCO, ';
  strSQL := strSQL + '       OCO_PROTOC,    ';
  strSQL := strSQL + '       "N" AS SELECAO ';
  strSQL := strSQL + '  FROM MOVOCO      ';
  strSQL := strSQL + ' INNER JOIN CADCLI ON CLI_CODCLI = OCO_CODCLI ';
  strSQL := strSQL + ' INNER JOIN CADTOC ON TOC_CODTOC = OCO_CODTOC ';
  strSQL := strSQL + ' INNER JOIN CADGOC ON GOC_CODGOC = TOC_CODGOC ';
  strSQL := strSQL + '  LEFT JOIN CADOPE CODOPE ON CODOPE.OPE_CODOPE = OCO_CODOPE ';
  strSQL := strSQL + '  LEFT JOIN CADOPE OPEOCO ON OPEOCO.OPE_CODOPE = OCO_OPEOCO ';
  strSQL := strSQL + ' WHERE OCO_CODEMP = :CODEMP ';
  strSQL := strSQL + '   AND OCO_EMERGE = "S" ';
  strSQL := strSQL + '   AND OCO_DTACON IS NULL ';

  if not fEmptyStr(edtCodCli.Text) then
    strSQL := strSQL + ' AND OCO_CODCLI = :CODCLI';

  //Operador Origem
  if not fEmptyStr(edtOpeOco.Text) then
    strSQL := strSQL + ' AND OCO_OPEOCO = :OPEOCO ';

  if not fEmptyStr(edtCodGoc.Text) then
    strSQL := strSQL + ' AND GOC_CODGOC = :CODGOC ';

  if not fEmptyStr(edtCodToc.Text) then
    strSQL := strSQL + ' AND TOC_CODTOC = :CODTOC ';

  if (not fEmptyStr(mskDtaIni.Text) And (mskDtaIni.Text <> '  /  /    ')) And
     (not fEmptyStr(mskDtaFin.Text) And (mskDtaFin.Text <> '  /  /    ')) then
    strSQL := strSQL + ' AND OCO_DTAINC BETWEEN :DTAINI AND :DTAFIN '
  else if not fEmptyStr(mskDtaIni.Text) And (mskDtaIni.Text <> '  /  /    ') then
    strSQL := strSQL + ' AND OCO_DTAINC = :DTAINI '
  else if not fEmptyStr(mskDtaFin.Text) And (mskDtaFin.Text <> '  /  /    ') then
    strSQL := strSQL + ' AND OCO_DTAINC = :DTAFIN ';

  if not fEmptyStr(edtProtoc.Text) then
    strSQL := strSQL + ' AND OCO_PROTOC = :PROTOC ';

  Result := strSQL;
end;

function TfrmAtribuicaoOcorrenciasEmergenciasCRM.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
 Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin

    If (Sender = edtCodCli) Then
    Begin
{      If fEmptyStr(edtCodCli.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Cliente deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
}
      If Not fEmptyStr(edtCodCli.Text) Then
      Begin
        pCarregaCliente;
        If qryCadCli.FieldByName('CLI_CODCLI').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Código de Cliente não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else
    If (Sender = edtOpeOco) Then
    Begin
      If Not fEmptyStr(edtOpeOco.Text) Then
      Begin
        pCarregaUsuarioOrigem;
        If qryCadOpe.FieldByName('OPE_CODOPE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Operador não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else
    If (Sender = edtCodGoc) Then
    Begin
      If Not fEmptyStr(edtCodGoc.Text) Then
      Begin
        pCarregaGrupoOcorrencia;
        If qryCadGoc.FieldByName('GOC_CODGOC').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Grupo de Ocorrência não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else
    If (Sender = edtCodToc) Then
    Begin
      If Not fEmptyStr(edtCodToc.Text) Then
      Begin
        pCarregaTipoOcorrencia;
        If qryCadToc.FieldByName('TOC_CODTOC').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Código de Tipo de Ocorrência não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else
    If (Sender = mskDtaIni) Then
    Begin
      If ((Not fEmptyStr(mskDtaIni.Text)) And (mskDtaIni.Text <> '  /  /    ')) And
         ((Not fEmptyStr(mskDtaFin.Text)) And (mskDtaFin.Text <> '  /  /    ')) And
         (StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text))  Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial não pode ser maior que a data final!', ['&Ok']);
        Result := False;
      End;
    End

    Else
    If (Sender = mskDtaFin) Then
    Begin
      If ((Not fEmptyStr(mskDtaIni.Text)) And (mskDtaIni.Text <> '  /  /    ')) And
         ((Not fEmptyStr(mskDtaFin.Text)) And (mskDtaFin.Text <> '  /  /    ')) And
         (StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text))  Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial não pode ser maior que a data final!', ['&Ok']);
        Result := False;
      End;
    End

    Else
    If (Sender = edtProtoc) Then
    Begin
      pConsultaOcorrencias;
      If not cdsOcorrencias.IsEmpty then
        pSetFocus(pnlCabecalho);
    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmAtribuicaoOcorrenciasEmergenciasCRM.pAdicionaOperadorNaOcorrenciaEmergencial(
  strCodOpe, strCodOco, strCodEmp: String);
var
  qryIns: TUniQuery;
begin
  Try
    Try
      qryIns := fCriaQuery(Self);
      With qryIns Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' INSERT INTO OCOEME ');
        SQL.Add(' (                  ');
        SQL.Add('   EME_CODOCO, ');
        SQL.Add('   EME_CODEMP, ');
        SQL.Add('   EME_CODOPE, ');
        SQL.Add('   AUTOINCREM  ');
        SQL.Add(' ) VALUES (    ');
        SQL.Add('   :CODOCO,    ');
        SQL.Add('   :CODEMP,    ');
        SQL.Add('   :CODOPE,    ');
        SQL.Add('   :AUTOIN)    ');
        ParamByName('CODOCO').AsString := strCodOco;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('CODOPE').AsString := strCodOpe;
        ParamByName('AUTOIN').AsString := fRetAutoIncrem('OCOEME', VS_strCodEmp);
        ExecSQL;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmAtribuicaoOcorrenciasEmergenciasCRM.pAdicionaOperadorNaOcorrenciaEmergencial]');
      End;
    End;
  Finally
    FreeAndNil(qryIns);
  End;                            
end;

procedure TfrmAtribuicaoOcorrenciasEmergenciasCRM.pAtribuiOperadoresOcorrenciasEmergenciais;
begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fAtribuiOperadores;
    frmGravando.ShowModal;
    If frmGravando.blnConfirma Then
    Begin
      pDesmarcarTodas;
      fMensagem('INFORMAÇÃO','Operação realizada com sucesso !',['&Ok']);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[btnConfirma.pAtribuiOperadoresOcorrenciasEmergenciais]');
    End;
  End;
end;

procedure TfrmAtribuicaoOcorrenciasEmergenciasCRM.pCarregaCliente;
begin
  pPesquisaCadCli(qryTabela, qryCadCli, edtCodCli.Text);
  With qryCadCli Do
  Begin
    edtDesCli.Text := FieldByName('CLI_NOMCLI').AsString;
  End;
end;

procedure TfrmAtribuicaoOcorrenciasEmergenciasCRM.pCarregaGrupoOcorrencia;
begin
  pPesquisaCadGOc(nil, qryCadGoc, edtCodGoc.Text);
  With qryCadGoc Do
  Begin
    edtDesGoc.Text := FieldByName('GOC_DESGOC').AsString;
  End;
end;

procedure TfrmAtribuicaoOcorrenciasEmergenciasCRM.pCarregaTipoOcorrencia;
begin
  pPesquisaCadToc(qryTabela, qryCadToc, edtCodToc.Text, edtCodGoc.Text, False);
  With qryCadToc Do
  Begin
    edtDesTOc.Text := FieldByName('TOC_DESTOC').AsString;
  End;
end;

procedure TfrmAtribuicaoOcorrenciasEmergenciasCRM.pCarregaUsuarioOrigem;
begin
  pPesquisaCadOpe(qryTabela, qryCadOpe, edtOpeOco.Text);
  With qryCadOpe Do
  Begin
    edtDesOpeOco.Text := FieldByName('OPE_NOMOPE').AsString;
  End;
end;

procedure TfrmAtribuicaoOcorrenciasEmergenciasCRM.pChamaFormularioSelecaoOpeEmergencial;
  Var
    frmCadOpeOcorrEmergCRM: TfrmCadOpeOcorrEmergCRM;
begin
  try
    pCriarFormularios(TfrmCadOpeOcorrEmergCRM,frmCadOpeOcorrEmergCRM);
    frmCadOpeOcorrEmergCRM.blnInsert  := True;
    frmCadOpeOcorrEmergCRM.strOpeResp := strLoginUsuarioLogado;
    frmCadOpeOcorrEmergCRM.ShowModal;
    if Assigned(frmCadOpeOcorrEmergCRM.arrOpe) then
      pPreencheArrayOpeEmergencial(frmCadOpeOcorrEmergCRM.arrOpe);
  finally
    FreeAndNil(frmCadOpeOcorrEmergCRM);
  end;
end;

procedure TfrmAtribuicaoOcorrenciasEmergenciasCRM.pConsultaOcorrencias;
begin
  with qryOcorrencias do
  begin
    cdsOcorrencias.Close;
    Close;
    SQL.Clear;
    SQL.Add(fRetornaSQLConsulta);

    ParamByName('CODEMP').AsString := VS_strCodEmp;    

    if not fEmptyStr(edtCodCli.Text) then
      ParamByName('CODCLI').AsString := edtCodCli.Text;

    if not fEmptyStr(edtOpeOco.Text) then
      ParamByName('OPEOCO').AsString := edtOpeOco.Text;

    if not fEmptyStr(edtCodGoc.Text) then
      ParamByName('CODGOC').AsString := edtCodGoc.Text;

    if not fEmptyStr(edtCodToc.Text) then
      ParamByName('CODTOC').AsString := edtCodToc.Text;

    if (not fEmptyStr(mskDtaIni.Text) And (mskDtaIni.Text <> '  /  /    ')) And
       (not fEmptyStr(mskDtaFin.Text) And (mskDtaFin.Text <> '  /  /    ')) then
    begin
      ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
    end
    else if not fEmptyStr(mskDtaIni.Text) And (mskDtaIni.Text <> '  /  /    ') then
      ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text)
    else if not fEmptyStr(mskDtaFin.Text) And (mskDtaFin.Text <> '  /  /    ') then
      ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);

    if not fEmptyStr(edtProtoc.Text) then
      ParamByName('PROTOC').AsString := edtProtoc.Text;

    Open;
    pSetaClient(qryOcorrencias);
    
    cdsOcorrencias.Open;
    pSetaClient(cdsOcorrencias);
  end;
end;

procedure TfrmAtribuicaoOcorrenciasEmergenciasCRM.pDesabilitaBotoesPanelInferior;
begin
  btnConfirma.Enabled  := False;
  btnIniBus.Enabled    := False;
  btnLocProx.Enabled   := False;
  btnMarcar.Enabled    := False;
  btnDesmarcar.Enabled := False;
end;

procedure TfrmAtribuicaoOcorrenciasEmergenciasCRM.pDesmarcarTodas;
begin
  Try
    cdsOcorrencias.DisableControls;

//    cdsOcorrencias.Filtered := False;
//    cdsOcorrencias.Filter   := 'SELECAO = ' + QuotedStr('S');
//    cdsOcorrencias.Filtered := True;

    cdsOcorrencias.First;
    While Not cdsOcorrencias.Eof Do
    Begin
      cdsOcorrencias.Edit;
      cdsOcorrenciasSELECAO.AsString := 'N';
      cdsOcorrencias.Post;

      cdsOcorrencias.Next;
    End;

//    cdsOcorrencias.Filtered := False;
//    cdsOcorrencias.Filter   := 'SELECAO = ' + QuotedStr('N');
//    cdsOcorrencias.Filtered := True;

    cdsOcorrencias.First;
  Finally
    cdsOcorrencias.EnableControls;
  End;
end;

procedure TfrmAtribuicaoOcorrenciasEmergenciasCRM.pFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
//  If Pos('_PROTOC', strCamFil) > 0 Then
//       Accept := FloatToStrF(fStrToFloat(strValFil),ffFixed,15,2) = FloatToStrF(DataSet.FieldByName(strCamFil).AsFloat,ffFixed,15,2)
//  Else
  Accept := (Pos(strValFil, DataSet.FieldByName(strCamFil).AsString) > 0);
end;

procedure TfrmAtribuicaoOcorrenciasEmergenciasCRM.pHabilitaBotoesPanelInferior;
begin
  btnConfirma.Enabled  := True;
  btnIniBus.Enabled    := True;
  btnLocProx.Enabled   := True;
  btnMarcar.Enabled    := True;
  btnDesmarcar.Enabled := True;
end;

procedure TfrmAtribuicaoOcorrenciasEmergenciasCRM.pIniciarProcessoDeAtribuicao;
begin
  If fExisteSelecao Then
  Begin
    SetLength(arrOpeEmer,0);
    pChamaFormularioSelecaoOpeEmergencial;
    If Length(arrOpeEmer) > 0 Then
      pAtribuiOperadoresOcorrenciasEmergenciais;
  End;
end;

procedure TfrmAtribuicaoOcorrenciasEmergenciasCRM.pMarcarTodas;
begin
  Try
    cdsOcorrencias.DisableControls;

//    cdsOcorrencias.Filtered := False;
//    cdsOcorrencias.Filter   := 'SELECAO = ' + QuotedStr('N');
//    cdsOcorrencias.Filtered := True;

    cdsOcorrencias.First;
    While Not cdsOcorrencias.Eof Do
    Begin
      cdsOcorrencias.Edit;
      cdsOcorrenciasSELECAO.AsString := 'S';
      cdsOcorrencias.Post;

      cdsOcorrencias.Next;
    End;

//    cdsOcorrencias.Filtered := False;
//    cdsOcorrencias.Filter   := 'SELECAO = ' + QuotedStr('S');
//    cdsOcorrencias.Filtered := True;

    cdsOcorrencias.First;
  Finally
    cdsOcorrencias.EnableControls;
  End;
end;

procedure TfrmAtribuicaoOcorrenciasEmergenciasCRM.pPreencheArrayOpeEmergencial(
  ArrayOperadores: array of String);
var
  intCont: Integer;
begin
  SetLength(arrOpeEmer,Length(ArrayOperadores));
  For intCont := 0 To Length(ArrayOperadores) - 1 Do
    arrOpeEmer[intCont] := ArrayOperadores[intCont];
end;

procedure TfrmAtribuicaoOcorrenciasEmergenciasCRM.pSelecionaLinha;
begin
  cdsOcorrencias.Edit;
  cdsOcorrenciasSELECAO.AsString := IIF(cdsOcorrenciasSELECAO.AsString = 'S','N','S');
  cdsOcorrencias.Post;
end;

end.

