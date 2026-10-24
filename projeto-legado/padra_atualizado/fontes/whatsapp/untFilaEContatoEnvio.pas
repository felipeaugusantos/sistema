unit untFilaEContatoEnvio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass, System.Math,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Uni, UniClientDataSet, System.UITypes,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, untQualiZapGetClientOpenChats,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, cxLabel, cxCheckBox,
  cxMaskEdit;

type
  TfrmFilaEContatoEnvio = class(TfrmPaiConfirma)
    gpbContatos: TGroupBox;
    gpbFilas: TGroupBox;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxGridContatos: TcxGridCitel;
    cxGridContatosTableView: TcxGridDBTableViewCitel;
    cxGridContatosTITULO: TcxGridDBColumn;
    cxGridContatosCONTATO: TcxGridDBColumn;
    cxGridContatosWHATSAP: TcxGridDBColumn;
    cxGridContatosLevel1: TcxGridLevel;
    cxGridContatosMARDES: TcxGridDBColumn;
    cxGridFilasDBTableView: TcxGridDBTableViewCitel;
    cxGridFilasLevel1: TcxGridLevel;
    cxGridFilas: TcxGridCitel;
    cxGridFilasIDFILA: TcxGridDBColumn;
    cxGridFilasDESCRICAO: TcxGridDBColumn;
    cxGridFilasMARDES: TcxGridDBColumn;
    btnRestaurarContato: TBitBtnLocked;
    cxGridFilasATENDI: TcxGridDBColumn;
    cxGridContatosIDFILA: TcxGridDBColumn;
    cxGridContatosDESFILA: TcxGridDBColumn;
    pnlTopo: TPanel;
    lblTituloGatilho: TLabel;
    lblNomeGatilho: TLabel;
    lblNomeGrupo: TLabel;
    lblTituloGrupo: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxGridContatosTableViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridContatosTableViewDblClick(Sender: TObject);
    procedure cxGridContatosTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cxGridFilasDBTableViewDblClick(Sender: TObject);
    procedure cxGridFilasDBTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxGridFilasDBTableViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnSairClick(Sender: TObject);
    procedure btnRestaurarContatoClick(Sender: TObject);
  private
    { Private declarations }
    cdsContato,
    cdsFilas: TUniClientDataSet;

    dtsContato,
    dtsFilas: TDataSource;

    strUtiFilOpe: String;
    extFilEnvOpe: Extended;

    procedure pVerificaSeSolicitaFila;
    procedure pRetConfiguracoesDoOperador(var strUtiFilOpe: String; var extFilEnvOpe: Extended);
    procedure pCarregaContatos;
    procedure pCarregaFilas(strCodEmp: String; strFilasEmAndamento: String = ''; blnMarcaFilaDefault: Boolean = False);
    procedure pSelecionaContato;
    procedure pDefineFila;
    function fRetFilaDefault: Extended;
    procedure pMarcaFilaDefault(strIDFila: Extended);
    procedure pInicializaExibicaoDosContatos;
    function fTemFilaDeAtendimentoEmAndamento: Boolean;
    procedure pExibeModoEnvioOuAgendamento;
    function fModoAgendamento: Boolean;
    procedure pAjustaWhatsapp;
    procedure pDeletaFilasDeAtendimentoEmAdamento;
    function fRetFilasIdSQL(ReturnGetClientOpenChats: TReturnGetClientOpenChats): String;
    procedure pOrdenarFilas;
    procedure pMarcaContato;
    procedure pCarregaNomeGatilho;
  public
    { Public declarations }
    strCodigoCliente,
    strNomeCliente,
    strCelular,
    strCodigoGatilho,
    strCodigoGrupoGatilho: String;

    strFilaEnvEscolhida,
    strCelularEscolhido,
    strContatoEscolhido: String;

    blnEscolherFila: Boolean;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untFuncoesGenerica;

procedure TfrmFilaEContatoEnvio.FormCreate(Sender: TObject);
begin
  inherited;
  strCodigoCliente := EmptyStr;
  strNomeCliente := EmptyStr;
  strCodigoGatilho := EmptyStr;
  strCodigoGrupoGatilho := EmptyStr;
  blnEscolherFila := True;

  strFilaEnvEscolhida := EmptyStr;
  strCelularEscolhido := EmptyStr;
  strContatoEscolhido := EmptyStr;

  extFilEnvOpe := 0;
  strUtiFilOpe := EmptyStr;

  dtsContato := fCriaDataSource(cdsContato);
  cxGridContatosTableView.DataController.DataSource := dtsContato;

  dtsFilas := fCriaDataSource(cdsFilas);
  cxGridFilasDBTableView.DataController.DataSource := dtsFilas;
end;

procedure TfrmFilaEContatoEnvio.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(dtsContato) then
    FreeAndNil(dtsContato);

  if Assigned(dtsFilas) then
    FreeAndNil(dtsFilas);

  if Assigned(cdsContato) then
    FreeAndNil(cdsContato);

  if Assigned(cdsFilas) then
    FreeAndNil(cdsFilas);
end;

procedure TfrmFilaEContatoEnvio.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaContatos;
  pVerificaSeSolicitaFila;
  pMarcaContato;
  pInicializaExibicaoDosContatos;
  pCarregaNomeGatilho;

  pExibeModoEnvioOuAgendamento;
end;

procedure TfrmFilaEContatoEnvio.pCarregaNomeGatilho;
  Var
    strNomGat : String;
    strNomGru : String;
begin
  strNomGat := fCampoTabela('WPP_DESCRI', 'WPPSAI', ['WPP_CODIGO', 'WPP_CODGRU', 'WPP_CODEMP'], [strCodigoGatilho, strCodigoGrupoGatilho, VS_strCodEmp], False);
  strNomGru := fCampoTabela('GRU_DESGRU', 'GRUWPP', ['GRU_CODGRU'], [strCodigoGrupoGatilho], False);

  lblNomeGatilho.Caption := strNomGat;
  lblNomeGrupo.Caption := strCodigoGrupoGatilho + ' - ' + strNomGru;

  If (Not fEmptyStr(strNomGat)) Then
    pnlTopo.Visible := True;
end;

procedure TfrmFilaEContatoEnvio.pMarcaContato;
begin
  if not fEmptyStr(strCodigoCliente)then
  begin
    if cdsContato.RecordCount > 1 then
    begin
      if not blnEscolherFila then
        Exit;

      try
        cdsContato.DisableControls;

        cdsContato.Filtered := False;
        cdsContato.Filter := 'MARDES = '+QuotedStr('M');
        cdsContato.Filtered := True;

        if not cdsContato.IsEmpty then
        begin
          if not fTemFilaDeAtendimentoEmAndamento then
          begin
            if (strUtiFilOpe = 'T') and (extFilEnvOpe = 0) then
              pMarcaFilaDefault(fRetFilaDefault);
          end;
        end;

        pSetFocus(cxGridContatos);
      finally
        cdsContato.Filtered := False;
        cdsContato.EnableControls;
      end;

    end
    else if not fEmptyStr(cdsContato.FieldByName('CLI_WHATSA').AsString) then
      pSelecionaContato;
  end;
end;

procedure TfrmFilaEContatoEnvio.pExibeModoEnvioOuAgendamento;
begin
  if fModoAgendamento then
  begin
    btnConfirma.Caption := 'Agendar Envio';
    Self.Caption := 'Agendamento de Envio - Whatsapp';
  end;
end;

function TfrmFilaEContatoEnvio.fModoAgendamento: Boolean;
const
  GATILHO_AGENDAMENTO_ORCAMENTO = '001008_';
begin
  Result := Pos(strCodigoGrupoGatilho+strCodigoGatilho, GATILHO_AGENDAMENTO_ORCAMENTO) > 0;
end;

procedure TfrmFilaEContatoEnvio.pInicializaExibicaoDosContatos;
begin
 cdsContato.Filtered := False;
 cxGridContatosTableView.DataController.Groups.FullExpand;
end;

procedure TfrmFilaEContatoEnvio.btnRestaurarContatoClick(Sender: TObject);
begin
  inherited;
  if not Assigned(cdsContato) then
    Exit;

  if cdsContato.IsEmpty then
    Exit;

  cdsContato.DisableControls;

  cdsContato.First;
  while not cdsContato.Eof do
  begin
    cdsContato.Edit;
    cdsContato.FieldByName('CLI_WHATSA').AsString := fFormataFone(cdsContato.FieldByName('BKP_WHATSA').AsString,
                                                                  IIF(Length(cdsContato.FieldByName('BKP_WHATSA').AsString) = 10,
                                                                      tpFixo,
                                                                      tpCelular)
                                                                  );
    cdsContato.Post;

    cdsContato.Next;
  end;

  cdsContato.EnableControls;
end;

procedure TfrmFilaEContatoEnvio.btnSairClick(Sender: TObject);
begin
  ModalResult := mrNone;

  if fPergunta('Deseja cancelar o '+IIF(fModoAgendamento, 'agendamento de envio', 'envio')+' do whatsapp?') then
    inherited;
end;

procedure TfrmFilaEContatoEnvio.cxGridContatosTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  if not Assigned(cdsContato) then
    Exit;

  if not cdsContato.Active then
    Exit;

  if VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGridContatosMARDES.Index]) = 'M' then
  begin
    if ACanvas.Brush.Color = clHighlight then
      ACanvas.Font.Color := clLime
    else
    begin
      ACanvas.Brush.Color := clSkyBlue;
      ACanvas.Font.Color := clBlue;
    end;
  end;
end;

procedure TfrmFilaEContatoEnvio.cxGridFilasDBTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  if not Assigned(cdsFilas) then
    Exit;

  if not cdsFilas.Active then
    Exit;

  if VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGridFilasMARDES.Index]) = 'M' then
  begin
    if ACanvas.Brush.Color = clHighlight then
      ACanvas.Font.Color := clLime
    else
    begin
      ACanvas.Brush.Color := clSkyBlue;
      ACanvas.Font.Color := clBlue;
    end;
  end;
end;

procedure TfrmFilaEContatoEnvio.pSelecionaContato;
var
  strNumero: String;
  intTamNum: Integer;
  blnWhatsappValido: Boolean;
begin
  blnWhatsappValido := True;

  if not Assigned(cdsContato) then
    Exit;

  if not cdsContato.Active then
    Exit;

  if cdsContato.IsEmpty then
    Exit;

  strNumero := fTiraCaracEspeciais(cdsContato.FieldByName('CLI_WHATSA').AsString,
                                   True,
                                   True,
                                   True,
                                   True,
                                   True,
                                   True,
                                   True);

  intTamNum := Length(strNumero);
  if (cdsContato.FieldByName('MARDES').AsString = 'D') and (not InRange(intTamNum, 10, 11)) then
  begin
    strNumero := EmptyStr;
    fMensagem('','Whatsapp inválido!!', ['&Ok']);
    blnWhatsappValido := False;
  end;

  cdsContato.Edit;
  if (cdsContato.FieldByName('MARDES').AsString = 'D') and (blnWhatsappValido) then
    cdsContato.FieldByName('MARDES').AsString := 'M'
  else
  begin
    cdsContato.FieldByName('MARDES').AsString := 'D';
    cdsContato.FieldByName('IDFILA').AsExtended := 0;
    cdsContato.FieldByName('DESFILA').AsString := '';
  end;

  if blnWhatsappValido then
    cdsContato.FieldByName('CLI_WHATSA').AsString := fFormataFone(strNumero, IIF(intTamNum = 10, tpFixo, tpCelular));

  cdsContato.Post;

  if (blnEscolherFila) and (cdsContato.FieldByName('MARDES').AsString = 'M') then
  begin
    if not fTemFilaDeAtendimentoEmAndamento then
    begin
      if (strUtiFilOpe = 'T') and (extFilEnvOpe = 0) then
        pMarcaFilaDefault(fRetFilaDefault);
    end;
  end;
end;

procedure TfrmFilaEContatoEnvio.pDefineFila;
begin
  if not Assigned(cdsFilas) then
    Exit;

  if not cdsFilas.Active then
    Exit;

  if cdsFilas.IsEmpty then
    Exit;

  cdsContato.Edit;
  cdsContato.FieldByName('IDFILA').AsExtended := cdsFilas.FieldByName('FIL_IDFILA').AsExtended;
  cdsContato.FieldByName('DESFILA').AsString := cdsFilas.FieldByName('FIL_DESFIL').AsString;
  cdsContato.Post;
end;

function TfrmFilaEContatoEnvio.fTemFilaDeAtendimentoEmAndamento: Boolean;
var
  ReturnGetClientOpenChats: TReturnGetClientOpenChats;
begin
  ReturnGetClientOpenChats := TControllerGetClientOpenChats.fGetClientOpenChats(cdsContato.FieldByName('CLI_WHATSA').AsString);
  Result := ((Assigned(ReturnGetClientOpenChats)) and (ReturnGetClientOpenChats.openChats > 0));
  if Result then
  begin
    pDeletaFilasDeAtendimentoEmAdamento;
    pCarregaFilas(IIF(strUtiFilOpe = 'L', VS_strCodEmp, ''), fRetFilasIdSQL(ReturnGetClientOpenChats), True);
  end
  else
    pCarregaFilas(IIF(strUtiFilOpe = 'L', VS_strCodEmp, ''), '', True);
end;

function TfrmFilaEContatoEnvio.fRetFilaDefault: Extended;
var
  qryWppSai: TUniQuery;
  strSQL: String;
begin
  Result := 0;

  if fEmptyStr(strCodigoGatilho) or fEmptyStr(strCodigoGrupoGatilho) then
    Exit;

  qryWppSai := fCriaQuery(Self);
  try
    strSQL :=
    ' SELECT '+
    '   FIL_IDFILA '+
    ' FROM '+
    '   WPPSAI '+
    ' LEFT JOIN CADFIL ON '+
    '   WPP_SEQFIL = CADFIL.AUTOINCREM '+
    ' WHERE '+
    '   WPP_CODIGO = :CODIGO AND '+
    '   WPP_CODGRU = :CODGRU AND '+
    '   WPP_STATUS = "A" ';

    qryWppSai.Close;
    qryWppSai.SQL.Text := strSQL + ' AND WPP_SEQCTT = :SEQCTT ';

    qryWppSai.ParamByName('CODIGO').AsString := strCodigoGatilho;
    qryWppSai.ParamByName('CODGRU').AsString := strCodigoGrupoGatilho;
    qryWppSai.ParamByName('SEQCTT').AsString := cdsContato.FieldByName('AUTOINCREM').AsString;
    qryWppSai.Open;

    if qryWppSai.IsEmpty then
    begin
      qryWppSai.Close;
      qryWppSai.SQL.Text := strSQL + ' AND WPP_SEQCTT IS NULL ';

      qryWppSai.ParamByName('CODIGO').AsString := strCodigoGatilho;
      qryWppSai.ParamByName('CODGRU').AsString := strCodigoGrupoGatilho;
      qryWppSai.Open;
    end;

    Result := qryWppSai.FieldByName('FIL_IDFILA').AsExtended;

  finally
    FreeAndNil(qryWppSai);
  end;
end;

function TfrmFilaEContatoEnvio.fRetFilasIdSQL(
  ReturnGetClientOpenChats: TReturnGetClientOpenChats): String;
var
  Chat: TChatsClass;
begin
  Result := EmptyStr;
  for Chat in ReturnGetClientOpenChats.chats do
    Result := IIF(fEmptyStr(Result), '', Result + ',') + QuotedStr(FloatToStr(Chat.queueId));
end;

procedure TfrmFilaEContatoEnvio.pMarcaFilaDefault(strIDFila: Extended);
begin
  cdsFilas.First;
  while not cdsFilas.Eof do
  begin
    if cdsFilas.FieldByName('FIL_IDFILA').AsExtended = strIDFila then
    begin
      pDefineFila;
      Break;
    end;
    cdsFilas.Next;
  end;
end;

procedure TfrmFilaEContatoEnvio.pOrdenarFilas;
begin
  cdsFilas.IndexDefs.Add('OrdenarFilaEmAtendimento', 'ATENDI', [ixDescending]);
  cdsFilas.IndexName := 'OrdenarFilaEmAtendimento';
end;

procedure TfrmFilaEContatoEnvio.cxGridContatosTableViewDblClick(
  Sender: TObject);
begin
  inherited;
  pSelecionaContato;
end;

procedure TfrmFilaEContatoEnvio.cxGridContatosTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_RETURN,
    VK_SPACE: pSelecionaContato;
  end;
end;

procedure TfrmFilaEContatoEnvio.cxGridFilasDBTableViewDblClick(Sender: TObject);
begin
  inherited;
  pDefineFila;
end;

procedure TfrmFilaEContatoEnvio.cxGridFilasDBTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_RETURN,
    VK_SPACE: pDefineFila;
  end;
end;

procedure TfrmFilaEContatoEnvio.pVerificaSeSolicitaFila;
begin
  pRetConfiguracoesDoOperador(strUtiFilOpe, extFilEnvOpe);

  if (strUtiFilOpe = 'L') and (extFilEnvOpe = 0) then
    blnEscolherFila := False;

  gpbFilas.Visible := blnEscolherFila;
  cxGridContatosIDFILA.Visible := blnEscolherFila;
  cxGridContatosDESFILA.Visible := blnEscolherFila;
  if not blnEscolherFila then
  begin
    cxGridFilasDESCRICAO.Width := cxGridFilasDESCRICAO.Width - cxGridContatosIDFILA.Width - cxGridContatosDESFILA.Width;
    Self.Width := Self.Width - cxGridContatosIDFILA.Width - cxGridContatosDESFILA.Width;
  end;

  if blnEscolherFila then
    pCarregaFilas(IIF(strUtiFilOpe = 'L', VS_strCodEmp, ''));
end;

procedure TfrmFilaEContatoEnvio.pRetConfiguracoesDoOperador(var strUtiFilOpe: String; var extFilEnvOpe: Extended);
var
  qryCadOpe: TUniQuery;
begin
  qryCadOpe := fCriaQuery(Self);
  try
    qryCadOpe.Close;
    qryCadOpe.SQL.Text :=
    ' SELECT '+
    '   OPE_USAFIL, '+
    '   FIL_IDFILA '+
    ' FROM '+
    '   CADOPE '+
    ' LEFT JOIN CADFIL ON '+
    '   OPE_SEQFIL = CADFIL.AUTOINCREM '+
    ' WHERE '+
    '  OPE_CODOPE = :CODOPE ';

    qryCadOpe.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
    qryCadOpe.Open;

    if not qryCadOpe.IsEmpty then
    begin
      strUtiFilOpe := qryCadOpe.FieldByName('OPE_USAFIL').AsString;
      if not qryCadOpe.FieldByName('FIL_IDFILA').IsNull then
        extFilEnvOpe := qryCadOpe.FieldByName('FIL_IDFILA').AsExtended;
    end;
  finally
    FreeAndNil(qryCadOpe);
  end;
end;

procedure TfrmFilaEContatoEnvio.pAjustaWhatsapp;
begin
  if not Assigned(cdsContato) then
    Exit;

  if cdsContato.IsEmpty then
    Exit;

  cdsContato.DisableControls;

  cdsContato.First;
  while not cdsContato.Eof do
  begin
    cdsContato.Edit;
    cdsContato.FieldByName('CLI_WHATSA').AsString := fFormataFone(cdsContato.FieldByName('CLI_WHATSA').AsString,
                                                                  IIF(Length(cdsContato.FieldByName('CLI_WHATSA').AsString) = 10,
                                                                      tpFixo,
                                                                      tpCelular)
                                                                  );
    cdsContato.Post;

    cdsContato.Next;
  end;

  cdsContato.EnableControls;

end;

procedure TfrmFilaEContatoEnvio.pCarregaContatos;
var
  qryContato: TUniQuery;
begin
  qryContato := fCriaQuery(Self);
  try
    qryContato.Close;
    qryContato.SQL.Text :=
    ' SELECT '+
        IIF(not fEmptyStr(strCodigoCliente), '"Cliente"', '"Informe o Whatsapp"')+' AS TITULO, '+
        IIF(not fEmptyStr(strNomeCliente), QuotedStr(strNomeCliente), ' CLI_NOMCLI ')+ ' AS CLI_NOMCTT, '+
        IIF(not fEmptyStr(strCelular), 'CAST(' + QuotedStr(strCelular) + ' AS CHAR(30))', ' CLI_CELULA ')+' AS CLI_WHATSA, '+
        IIF(not fEmptyStr(strCelular), 'CAST(' + QuotedStr(strCelular) + ' AS CHAR(30))', ' CLI_CELULA ')+' AS BKP_WHATSA, '+
    '   "CLIENTE" AS AUTOINCREM, '+
    '   0 AS IDFILA, '+
    '   CAST("" AS CHAR(80)) AS DESFILA, '+
    '   "D" AS MARDES '+
    ' FROM '+
    '   CADCLI '+
    IIF(not fEmptyStr(strCodigoCliente), ' WHERE CLI_CODCLI = :CODCLI ', ' LIMIT 1 ')+

    IIF(not fEmptyStr(strCodigoCliente),
        ' UNION ALL '+

        ' SELECT '+
        '   "Contatos do Cliente" AS TITULO, '+
        '   C.CLI_NOMCTT, '+
        '   C.CLI_CELCTT AS CLI_WHATSA, '+
        '   C.CLI_CELCTT AS BKP_WHATSA, '+
        '   C.AUTOINCREM, '+
        '   0 AS IDFILA, '+
        '   CAST("" AS CHAR(80)) AS DESFILA, '+
        '   IF( '+
        '     IFNULL( '+
        '       (SELECT '+
        '          WPP_CODIGO '+
        '        FROM '+
        '          WPPSAI '+
        '        INNER JOIN CLICTT '+
        '          ON WPP_SEQCTT = CLICTT.AUTOINCREM '+
        '        WHERE WPP_CODGRU = :CODGRU '+
        '          AND WPP_CODIGO = :CODIGO '+
        '          AND WPP_CODEMP = :CODEMP '+
        '          AND WPP_STATUS = "A" '+
        '          AND IFNULL(WPP_SEQCTT, "") <> "" '+
        '          AND C.CLI_CODCLI = CLICTT.CLI_CODCLI '+
        '        GROUP BY 1 '+
        '        HAVING COUNT(WPP_CODIGO) = 1), '+
        '        "" '+
        '      ) <> "", '+
        '      ( '+
        '        IF( '+
        '          IFNULL( '+
        '            (SELECT '+
        '               WPP_CODIGO '+
        '             FROM '+
        '               WPPSAI '+
        '             WHERE WPP_CODGRU = :CODGRU '+
        '               AND WPP_CODIGO = :CODIGO '+
        '               AND WPP_CODEMP = :CODEMP '+
        '               AND WPP_STATUS = "A" '+
        '               AND C.AUTOINCREM = WPP_SEQCTT), '+
        '            "" '+
        '          ) <> "", '+
        '          "M", '+
        '          "D" '+
        '        ) '+
        '      ), '+
        '      "D" '+
        '   ) AS MARDES '+
        ' FROM '+
        '   CLICTT C '+
        ' WHERE '+
        '  C.CLI_CODCLI = :CODCLI ',
        '');

    if Assigned(qryContato.FindParam('CODCLI')) then
      qryContato.ParamByName('CODCLI').AsString := strCodigoCliente;

    if Assigned(qryContato.FindParam('CODGRU')) then
      qryContato.ParamByName('CODGRU').AsString := strCodigoGrupoGatilho;

    if Assigned(qryContato.FindParam('CODIGO')) then
      qryContato.ParamByName('CODIGO').AsString := strCodigoGatilho;

    if Assigned(qryContato.FindParam('CODEMP')) then
      qryContato.ParamByName('CODEMP').AsString := VS_strCodEmp;

    qryContato.Open;

    if Assigned(cdsContato) then
      FreeAndNil(cdsContato);

    cdsContato := fCriaClientDatset(qryContato);
    dtsContato.DataSet := cdsContato;

    pAjustaWhatsapp;

  finally
    FreeAndNil(qryContato);
  end;
end;

procedure TfrmFilaEContatoEnvio.pCarregaFilas(strCodEmp: String; strFilasEmAndamento: String = ''; blnMarcaFilaDefault: Boolean = False);
var
  qryCadFil: TUniQuery;
begin
  qryCadFil := fCriaQuery(Self);
  try
    qryCadFil.Close;
    qryCadFil.SQL.Text :=
    ' SELECT '+
    '   FIL_IDFILA, '+
    '   FIL_DESFIL, '+
    '   "D" AS MARDES, '+
    IIF(not fEmptyStr(strFilasEmAndamento), ' "SIM" ', ' "NÃO" ')+' AS ATENDI '+
    ' FROM '+
    '   CADFIL '+
    IIF(not fEmptyStr(strFilasEmAndamento),
        ' WHERE FIL_IDFILA IN ('+strFilasEmAndamento+') ',
        IIF(not fEmptyStr(strCodEmp),
            ' WHERE FIL_CODEMP = :CODEMP ',
            '')
        )+
    ' ORDER BY ATENDI DESC ';

    if (not fEmptyStr(strCodEmp)) and (fEmptyStr(strFilasEmAndamento)) then
      qryCadFil.ParamByName('CODEMP').AsString := strCodEmp;

    qryCadFil.Open;

    if fEmptyStr(strFilasEmAndamento) then
    begin
      if Assigned(cdsFilas) then
        FreeAndNil(cdsFilas);

      cdsFilas := fCriaClientDatset(qryCadFil);
      pOrdenarFilas;

      if (blnMarcaFilaDefault) and (extFilEnvOpe > 0) then
        pMarcaFilaDefault(extFilEnvOpe);
    end
    else
    begin
      qryCadFil.First;
      while not qryCadFil.Eof do
      begin
        if cdsFilas.Locate('FIL_IDFILA', qryCadFil.FieldByName('FIL_IDFILA').AsString, []) then
          cdsFilas.Delete;

        cdsFilas.Append;
        cdsFilas.FieldByName('FIL_IDFILA').AsString := qryCadFil.FieldByName('FIL_IDFILA').AsString;
        cdsFilas.FieldByName('FIL_DESFIL').AsString := qryCadFil.FieldByName('FIL_DESFIL').AsString;
        cdsFilas.FieldByName('MARDES').AsString     := qryCadFil.FieldByName('MARDES').AsString;
        cdsFilas.FieldByName('ATENDI').AsString     := qryCadFil.FieldByName('ATENDI').AsString;
        cdsFilas.Post;

        qryCadFil.Next;
      end;

      if blnMarcaFilaDefault then
        pMarcaFilaDefault(qryCadFil.FieldByName('FIL_IDFILA').AsExtended);
    end;

    dtsFilas.DataSet := cdsFilas;
  finally
    FreeAndNil(qryCadFil);
  end;
end;

procedure TfrmFilaEContatoEnvio.pDeletaFilasDeAtendimentoEmAdamento;
begin
  if not Assigned(cdsFilas) then
    Exit;

  if not cdsFilas.Active then
    Exit;

  if cdsFilas.IsEmpty then
    Exit;

  cdsFilas.DisableControls;
  try
    cdsFilas.Filtered := False;
    cdsFilas.Filter := 'ATENDI = '+QuotedStr('SIM');
    cdsFilas.Filtered := True;

    cdsFilas.First;
    while not cdsFilas.IsEmpty do
      cdsFilas.Delete;
  finally
    cdsFilas.Filtered := False;
    cdsFilas.Filter := EmptyStr;
    cdsFilas.EnableControls;
  end;
end;

procedure TfrmFilaEContatoEnvio.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrNone;
  strCelularEscolhido := EmptyStr;
  strContatoEscolhido := EmptyStr;
  strFilaEnvEscolhida := EmptyStr;

  if not fPergunta('Confirma o '+IIF(fModoAgendamento, 'agendamento de envio', 'envio')+' do whatsapp para o contato selecionado?') then
    Exit;

  cdsContato.DisableControls;
  try
    cdsContato.Filtered := False;
    cdsContato.Filter := ' MARDES = '+QuotedStr('M');
    cdsContato.Filtered := True;

    if cdsContato.IsEmpty then
    begin
      fMensagem('','Marque ao menos um contato para '+IIF(fModoAgendamento, 'agendar o envio do', 'enviar o')+' whatsapp!', ['&Ok']);
      pInicializaExibicaoDosContatos;
      Exit;
    end;

    while not cdsContato.Eof do
    begin
      strCelularEscolhido := strCelularEscolhido + IIF(fEmptyStr(strCelularEscolhido), '', '_') + cdsContato.FieldByName('CLI_WHATSA').AsString;
      strContatoEscolhido := strContatoEscolhido + IIF(fEmptyStr(strContatoEscolhido), '', '_') + cdsContato.FieldByName('AUTOINCREM').AsString;
      strFilaEnvEscolhida := strFilaEnvEscolhida + IIF(fEmptyStr(strFilaEnvEscolhida), '', '_') + cdsContato.FieldByName('IDFILA').AsString;

      if (blnEscolherFila) and (cdsContato.FieldByName('IDFILA').AsInteger = 0) then
      begin
        fMensagem('','Existe(m) contato(s) marcado(s) sem fila de envio definida.'+sLineBreak+
                     'Defina a fila de envio para todos os contatos marcados!', ['&Ok']);
        pInicializaExibicaoDosContatos;
        cdsFilas.Filtered := False;
        pSetFocus(cxGridFilas);
        Exit;
      end;

      cdsContato.Next;
    end;

    ModalResult := mrOk;
  finally
    cdsContato.EnableControls;
    if blnEscolherFila then
      cdsFilas.EnableControls;
  end;
end;

end.
