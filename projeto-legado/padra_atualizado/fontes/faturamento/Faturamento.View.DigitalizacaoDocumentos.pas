unit Faturamento.View.DigitalizacaoDocumentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, EditFocus, Uni,
  UniClientDataSet, untImagemBase64, untTypesSistema, cxImage, cxImageList,
  System.ImageList, Vcl.ImgList, Vcl.Mask, MaskEditFocus, cxProgressBar,
  System.StrUtils;

type
  TcxPainterAccess = class(TcxGridTableDataCellPainter);
  TcxViewInfoAcess = class(TcxGridTableDataCellViewInfo);

  TfrmFatDigitalizacaoDocumentos = class(TfrmPai)
    Panel1: TPanel;
    grdDados: TcxGridCitel;
    grdDadosTv: TcxGridDBTableViewCitel;
    grdDadosLv: TcxGridLevel;
    btnExcluir: TBitBtnLocked;
    grdDadosTvGER_DTAENT: TcxGridDBColumn;
    grdDadosTvGER_NUMDOC: TcxGridDBColumn;
    grdDadosTvGER_ESPDOC: TcxGridDBColumn;
    grdDadosTvGER_CODEMP: TcxGridDBColumn;
    grdDadosTvGER_CODCLI: TcxGridDBColumn;
    grdDadosTvDIG_IMGB64: TcxGridDBColumn;
    grdDadosTvDIG_DTADIG: TcxGridDBColumn;
    dtsDados: TDataSource;
    grdDadosTvNOMEMP: TcxGridDBColumn;
    grdDadosTvNOMCLI: TcxGridDBColumn;
    ImageList1: TImageList;
    ImgList: TcxImageList;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label19: TLabel;
    lblCodEmp: TLabel;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    edtCodCli: TEditFocus;
    edtDesCli: TEditFocus;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    pnlDatas: TPanel;
    edtDtaDocIni: TMaskEditFocus;
    Label4: TLabel;
    edtDtaDig: TMaskEditFocus;
    Label5: TLabel;
    pnlConsultar: TPanel;
    btnFiltrar: TBitBtnLocked;
    grdDadosTvDIGITALIZADO: TcxGridDBColumn;
    grdDadosTvDIG_NOMARQ: TcxGridDBColumn;
    edtDtaDocFim: TMaskEditFocus;
    Label6: TLabel;
    grdDadosTvBotaoArquivo: TcxGridDBColumn;
    chkSomenteDocDig: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure grdDadosTvGER_CODEMPGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure grdDadosTvGER_CODCLIGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure grdDadosTvCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure btnFiltrarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure grdDadosTvBotaoArquivoCustomDrawCell
      (Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure grdDadosTvCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure chkSomenteDocDigClick(Sender: TObject);
  private
    { Private declarations }
    FCdsMovDig: TUniClientDataSet;
    FarrEmpres, FarrClientes: TConsultasArray;

    function fGravar(pgbStatus: TcxProgressBar): Boolean;
    function fConsultar(pgbStatus: TcxProgressBar): Boolean;
    function fAddWhere(const AstrValor, AstrCampo, AstrParametro
      : String): String;
    procedure pSetParametro(const AQry: TUniQuery;
      AstrValor, AstrParametro: String); overload;
    procedure pSetParametro(const AQry: TUniQuery; const AdtaValor: TDateTime;
      AstrParametro: String); overload;
    procedure pSelecionaGravaArquivo;
    procedure pFiltrarDigitalizados;

  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl;
      blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pEscapePressed; override;

  end;

implementation

uses
  untFuncoesSimples, untFuncoesImagem,
  Faturamento.Classes.DigitalizacaoDocumentos,
  untFuncoesConsulta, untConsultas, untGravando;

{$R *.dfm}

procedure TfrmFatDigitalizacaoDocumentos.btnExcluirClick(Sender: TObject);
begin
  inherited;
  if not FCdsMovDig.Active then
    Exit;

  if FCdsMovDig.IsEmpty then
    Exit;

  if fMensagem('AVISO', 'Deseja realmente excluir esse registro?',
    ['&Sim', '&Não']) <> 1 then
    Exit;

  try
    if TDigitalizacaoDocumentos.fExcluir(FCdsMovDig.FieldByName('AUTOINCREM').AsString) then
    Begin
      FCdsMovDig.Edit;
      FCdsMovDig.FieldByName('DIGITALIZADO').AsString := 'N';
      FCdsMovDig.FieldByName('DIG_NOMARQ').Clear;
      FCdsMovDig.FieldByName('DIG_IMGB64').Clear;
      FCdsMovDig.FieldByName('DIG_DTADIG').Clear;
      FCdsMovDig.Post;
    End;
  except
    on E: Exception do
    begin
      pMensagensErro(E.Message, 'Excluir registro');
    end;
  end;
end;

procedure TfrmFatDigitalizacaoDocumentos.btnFiltrarClick(Sender: TObject);
begin
  inherited;
  if not (fVerificaCampos)then
    Exit;

  fChamaTelaGravando(fConsultar);
end;

procedure TfrmFatDigitalizacaoDocumentos.chkSomenteDocDigClick(Sender: TObject);
begin
  inherited;
  pFiltrarDigitalizados;
end;

procedure TfrmFatDigitalizacaoDocumentos.edtCodCliExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCli, edtDesCli, FarrClientes, Nil, fRetNomCliente,
    'do Cliente');
end;

procedure TfrmFatDigitalizacaoDocumentos.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtDesCli, Nil, Key,
    FarrClientes, False) Then
  Begin
    fValidaCampos(edtCodCli, True);
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatDigitalizacaoDocumentos.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtNomEmp, FarrEmpres, fRetNomeEmpresa, nil,
    'da Empresa');
end;

procedure TfrmFatDigitalizacaoDocumentos.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key,
    FarrEmpres, False, False) Then
    If fValidaCampos(edtCodEmp, True) Then
      Self.SelectNext(ActiveControl, True, True);
end;

function TfrmFatDigitalizacaoDocumentos.fAddWhere(const AstrValor, AstrCampo,
  AstrParametro: String): String;
begin
  Result := '';
  if not fEmptyStr(AstrValor) then
    Result := '   AND ' + AstrCampo + ' = :' + AstrParametro;
end;

procedure TfrmFatDigitalizacaoDocumentos.pSetParametro(const AQry: TUniQuery;
  AstrValor, AstrParametro: String);
begin
  if not fEmptyStr(AstrValor) then
    AQry.ParamByName(AstrParametro).AsString := AstrValor;
end;

procedure TfrmFatDigitalizacaoDocumentos.pSetParametro(const AQry: TUniQuery;
  const AdtaValor: TDateTime; AstrParametro: String);
begin
  if AdtaValor > 0 then
    AQry.ParamByName(AstrParametro).AsDateTime := AdtaValor;
end;

function TfrmFatDigitalizacaoDocumentos.fConsultar
  (pgbStatus: TcxProgressBar): Boolean;
var
  LstrSql: String;
  qryConsulta: TUniQuery;
begin
  Result := False;

  pInfoStatusGravacao(pgbStatus, 'Aguarde, Consultando...');

  LstrSql := '';
  LstrSql := LstrSql + ' SELECT ';
  LstrSql := LstrSql + '   MG.GER_NUMDOC, MG.GER_ESPDOC, MG.GER_CODEMP, MG.GER_CODCLI,';
  LstrSql := LstrSql + '   MG.GER_DTAENT,          ';
  LstrSql := LstrSql + '   CE.EMP_NOMEMP AS NOMEMP,';
  LstrSql := LstrSql + '   CC.CLI_NOMCLI AS NOMCLI,';
  LstrSql := LstrSql + '   CASE WHEN MD.DIG_DTADIG IS NOT NULL THEN "S" ELSE "N" END DIGITALIZADO,';
  LstrSql := LstrSql + '   MG.AUTOINCREM SEQGER, ';
  LstrSql := LstrSql + '   MD.*                  ';
  LstrSql := LstrSql + ' FROM MOVGER MG';
  LstrSql := LstrSql + ' LEFT JOIN MOVDIG  MD ON MD.DIG_SEQGER = MG.AUTOINCREM';
  LstrSql := LstrSql + ' INNER JOIN CADEMP CE ON CE.EMP_CODEMP = MG.GER_CODEMP';
  LstrSql := LstrSql + ' INNER JOIN CADCLI CC ON CC.CLI_CODCLI = MG.GER_CODCLI';
  LstrSql := LstrSql + ' WHERE MG.GER_ESPDOC IN ("FF","DV","TR")';
  If not fEmptyStr(edtNumDoc.Text) Then
    LstrSql := LstrSql + fAddWhere(edtNumDoc.Text, 'GER_NUMDOC', 'NUMDOC');
  If not fEmptyStr(edtEspDoc.Text) Then
    LstrSql := LstrSql + fAddWhere(edtEspDoc.Text, 'GER_ESPDOC', 'ESPDOC');
  If not fEmptyStr(edtCodEmp.Text) Then
    LstrSql := LstrSql + fAddWhere(edtCodEmp.Text, 'GER_CODEMP', 'CODEMP');
  If not fEmptyStr(edtCodCli.Text) Then
    LstrSql := LstrSql + fAddWhere(edtCodCli.Text, 'GER_CODCLI', 'CODCLI');
  If not fEmptyDate(edtDtaDig.Text) Then
    LstrSql := LstrSql + fAddWhere(fTiraCaracEspeciais(edtDtaDig.Text),'DIG_DTADIG', 'DTADIG');

  LstrSql := LstrSql + '  AND MG.GER_DTAENT BETWEEN :DTAINI AND :DTAFIM';

  LstrSql := LstrSql +
    ' ORDER BY MG.GER_DTAENT, MG.GER_CODEMP, MG.GER_NUMDOC, MG.GER_ESPDOC';

  FreeAndNil(FCdsMovDig);

  qryConsulta := fCriaQuery;
  try
    qryConsulta.SQL.Text := LstrSql;
    If not fEmptyStr(edtNumDoc.Text) Then
      pSetParametro(qryConsulta, edtNumDoc.Text, 'NUMDOC');
    If not fEmptyStr(edtEspDoc.Text) Then
      pSetParametro(qryConsulta, edtEspDoc.Text, 'ESPDOC');
    If not fEmptyStr(edtCodEmp.Text) Then
      pSetParametro(qryConsulta, edtCodEmp.Text, 'CODEMP');
    If not fEmptyStr(edtCodCli.Text) Then
      pSetParametro(qryConsulta, edtCodCli.Text, 'CODCLI');
    If not fEmptyDate(edtDtaDig.Text) Then
      pSetParametro(qryConsulta, StrToDateDef(edtDtaDig.Text, 0), 'DTADIG');

    pSetParametro(qryConsulta, StrToDateDef(edtDtaDocIni.Text, 0), 'DTAINI');
    pSetParametro(qryConsulta, StrToDateDef(edtDtaDocFim.Text, 0), 'DTAFIM');

    qryConsulta.Open;
    FCdsMovDig := fCriaClientDatset(qryConsulta);
    dtsDados.DataSet := FCdsMovDig;

    pFiltrarDigitalizados;
  finally
    FreeAndNil(qryConsulta);
  end;
end;

function TfrmFatDigitalizacaoDocumentos.fGravar(pgbStatus: TcxProgressBar): Boolean;
var
  LDados: TDadosDigitalizacaoDocumentos;
  LstrCodCli: String;
begin
  pInfoStatusGravacao(pgbStatus, 'Aguarde, Gravando...');
  LDados.strNumDoc  := FCdsMovDig.FieldByName('GER_NUMDOC').asString;
  LDados.strEspDoc  := FCdsMovDig.FieldByName('GER_ESPDOC').asString;
  LDados.strCodEmp  := FCdsMovDig.FieldByName('GER_CODEMP').asString;
  LDados.strNomEmp  := FCdsMovDig.FieldByName('NOMEMP').asString;
  LDados.strCodCli  := FCdsMovDig.FieldByName('GER_CODCLI').asString;
  LDados.strNomCli  := FCdsMovDig.FieldByName('NOMCLI').asString;
  LDados.strArquivo := FCdsMovDig.FieldByName('DIG_NOMARQ').asString;
  LDados.strSeqGer  := FCdsMovDig.FieldByName('SEQGER').asString;
  LDados.dtaDtaEnt  := FCdsMovDig.FieldByName('GER_DTAENT').asDateTime;

  if fEmptyStr(LDados.strCodCli) then
  begin
    LDados.strCodCli := LstrCodCli;
    edtDesCli.Text   := fRetNomCliente(LstrCodCli);
    LDados.strNomCli := edtDesCli.Text;
  end;

  Result := TDigitalizacaoDocumentos.fGravar(LDados);

  if Result then
  begin
    TDigitalizacaoDocumentos.pGravaTmp(FCdsMovDig, LDados);
  end;

end;

procedure TfrmFatDigitalizacaoDocumentos.FormCreate(Sender: TObject);
var
  LstrSql: String;
begin
  inherited;
  LstrSql := '';
  LstrSql := LstrSql + ' SELECT ';
  LstrSql := LstrSql + '   MG.GER_NUMDOC, MG.GER_ESPDOC, MG.GER_CODEMP, MG.GER_CODCLI,';
  LstrSql := LstrSql + '   MG.GER_DTAENT,          ';
  LstrSql := LstrSql + '   CE.EMP_NOMEMP AS NOMEMP,';
  LstrSql := LstrSql + '   CC.CLI_NOMCLI AS NOMCLI,';
  LstrSql := LstrSql + '   CASE WHEN MD.DIG_DTADIG IS NOT NULL THEN "S" ELSE "N" END DIGITALIZADO,';
  LstrSql := LstrSql + '   MG.AUTOINCREM SEQGER, ';
  LstrSql := LstrSql + '   MD.*                  ';
  LstrSql := LstrSql + ' FROM MOVGER MG';
  LstrSql := LstrSql + ' LEFT JOIN MOVDIG  MD ON MD.DIG_SEQGER = MG.AUTOINCREM';
  LstrSql := LstrSql + ' INNER JOIN CADEMP CE ON CE.EMP_CODEMP = MG.GER_CODEMP';
  LstrSql := LstrSql + ' INNER JOIN CADCLI CC ON CC.CLI_CODCLI = MG.GER_CODCLI';
  LstrSql := LstrSql + ' WHERE FALSE';
  FCdsMovDig := fCriaClientDataset(LstrSql);
  dtsDados.DataSet := FCdsMovDig;

  FCdsMovDig.IndexFieldNames := 'GER_DTAENT;GER_CODEMP;GER_NUMDOC;GER_ESPDOC';
end;

procedure TfrmFatDigitalizacaoDocumentos.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FCdsMovDig);
end;

procedure TfrmFatDigitalizacaoDocumentos.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Shift = []) then
  begin
    if (Key = VK_F5) then
      btnExcluir.Click;
  end;
end;

function TfrmFatDigitalizacaoDocumentos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (Sender = edtDtaDocIni) then
  Begin
    If fEmptyDate(edtDtaDocIni.Text) then
    Begin
      fMensagem('Atenção!', 'Informar a Data Inicial para a Pesquisa de Documentos!', ['&O k']);
      Result := False;
    End
    Else
    Begin
      if not fValidaDataStr(edtDtaDocIni.Text)Then
      Begin
        fMensagem('ATENÇÃO!', 'A data informada no campo Data Inicial não é válida!',['&OK']);
        Result := False;
      End;
    End
  End

  Else If (Sender = edtDtaDocFim) then
  Begin
    If fEmptyDate(edtDtaDocFim.Text) then
    Begin
      fMensagem('Atenção!', 'Informar a Data Final para a Pesquisa de Documentos!', ['&O k']);
      Result := False;
    End
    Else
    Begin
      if not fValidaDataStr(edtDtaDocFim.Text)Then
      Begin
        fMensagem('ATENÇÃO!', 'A data informada no campo Data Final não é válida!',['&OK']);
        Result := False;
      End;
    End
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmFatDigitalizacaoDocumentos.grdDadosTvBotaoArquivoCustomDrawCell
  (Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  APainter: TcxPainterAccess;
begin
  inherited;
  APainter := TcxPainterAccess(TcxViewInfoAcess(AViewInfo)
    .GetPainterClass.Create(ACanvas, AViewInfo));
  Try
    APainter.DrawBorders;

    ImgList.Draw(ACanvas.Canvas, AViewInfo.ClientBounds.Left +
      ((AViewInfo.ClientBounds.Width - 16) div 2), AViewInfo.ClientBounds.Top +
      ((AViewInfo.ClientBounds.Height - 16) div 2), 1)
  Finally
    APainter.Free;
  End;
  ADone := True;
end;

procedure TfrmFatDigitalizacaoDocumentos.grdDadosTvCellClick
  (Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  If ACellViewInfo = Nil Then
    Exit;

  If ACellViewInfo.Item = Nil Then
    Exit;

  If (ACellViewInfo.Item.Caption = 'Imagem') Then
  Begin
    If not (FCdsMovDig.FieldByName('DIG_IMGB64').IsNull) then
      TDigitalizacaoDocumentos.pMostrarImagem(VarToStr(ACellViewInfo.Value));
  End
  Else If (ACellViewInfo.Item.Name = 'grdDadosTvBotaoArquivo') Then
  Begin
    AHandled := True;
    pSelecionaGravaArquivo;
  End;
end;

procedure TfrmFatDigitalizacaoDocumentos.grdDadosTvCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  APainter: TcxPainterAccess;
begin
  inherited;
  If AViewInfo.GridRecord.Index < 0 Then
    Exit;

  {IMAGEM}
  If AViewInfo.Item.Index = grdDadosTvDIG_IMGB64.Index Then
  Begin
    If grdDadosTv.ViewData.Records[AViewInfo.GridRecord.Index].Values[grdDadosTvDIG_IMGB64.Index] <> null then
    Begin
      APainter := TcxPainterAccess(TcxViewInfoAcess(AViewInfo).GetPainterClass.Create(ACanvas, AViewInfo));
      Try
        APainter.DrawBorders;

        ImgList.Draw(ACanvas.Canvas, AViewInfo.ClientBounds.Left +
          ((AViewInfo.ClientBounds.Width - 16) div 2), AViewInfo.ClientBounds.Top +
          ((AViewInfo.ClientBounds.Height - 16) div 2), 0);
      Finally
        APainter.Free;
      End;
      ADone := True;
    End;
  End;
  {DIGITALIZADO}
  If AViewInfo.Item.Index = grdDadosTvDIGITALIZADO.Index Then
  Begin
    APainter := TcxPainterAccess(TcxViewInfoAcess(AViewInfo)
      .GetPainterClass.Create(ACanvas, AViewInfo));
    Try
      APainter.DrawBorders;

      If grdDadosTv.ViewData.Records[AViewInfo.GridRecord.Index].Values[grdDadosTvDIGITALIZADO.Index] = 'S' then
        ImgList.Draw(ACanvas.Canvas, AViewInfo.ClientBounds.Left +
          ((AViewInfo.ClientBounds.Width - 16) div 2), AViewInfo.ClientBounds.Top
          + ((AViewInfo.ClientBounds.Height - 16) div 2), 2)
      Else
        ImgList.Draw(ACanvas.Canvas, AViewInfo.ClientBounds.Left +
          ((AViewInfo.ClientBounds.Width - 16) div 2), AViewInfo.ClientBounds.Top
          + ((AViewInfo.ClientBounds.Height - 16) div 2), 3)
    Finally
      APainter.Free;
    End;
    ADone := True;
  End;
end;

procedure TfrmFatDigitalizacaoDocumentos.grdDadosTvGER_CODCLIGetDisplayText
  (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  AText := AText + '-' + VarToStr(ARecord.Values[grdDadosTvNOMCLI.Index]);
end;

procedure TfrmFatDigitalizacaoDocumentos.grdDadosTvGER_CODEMPGetDisplayText
  (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  AText := AText + '-' + VarToStr(ARecord.Values[grdDadosTvNOMEMP.Index]);
end;

procedure TfrmFatDigitalizacaoDocumentos.pEscapePressed;
begin
  inherited;

end;

procedure TfrmFatDigitalizacaoDocumentos.pSelecionaGravaArquivo;
  Var LstrArquivo : String;
begin
  LstrArquivo := fSelecionaArquivo('', 'Imagens|*.jpeg;*.jpg;*.png', [ofFileMustExist]);
  if (not fEmptyStr(LstrArquivo)) then
  Begin
    if (Not FileExists(LstrArquivo)) then
    begin
      fMensagem('', 'O Arquivo é inválido ou não existe!', ['&O k']);
      Exit;
    end;

    FCdsMovDig.Edit;
    FCdsMovDig.FieldByName('DIGITALIZADO').AsString := 'S';
    FCdsMovDig.FieldByName('DIG_NOMARQ').AsString   := LstrArquivo;
    FCdsMovDig.FieldByName('DIG_DTADIG').AsDateTime := fNow;
    FCdsMovDig.Post;

    fChamaTelaGravando(fGravar);
  End;
End;

procedure TfrmFatDigitalizacaoDocumentos.pFiltrarDigitalizados;
begin
  If (not FCdsMovDig.Active) Then
    Exit;

  If chkSomenteDocDig.Checked Then
  Begin
    FCdsMovDig.Filtered := False;
    FCdsMovDig.Filter   := ' DIGITALIZADO = ' + QuotedStr('S');
    FCdsMovDig.Filtered := True;
  End
  Else
    FCdsMovDig.Filtered := False;
end;




end.
