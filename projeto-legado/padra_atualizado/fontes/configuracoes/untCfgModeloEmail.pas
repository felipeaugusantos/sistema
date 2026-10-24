unit untCfgModeloEmail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, untEditorHtml, Uni, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridBandedTableView, cxGridDBBandedTableView, cxGridCitel, cxGridLevel,
  cxGrid, UniClientDataSet, Clipbrd, ActiveX, MShtml, Vcl.OleCtrls, EditFocus, strUtils,
  Vcl.DBCtrls, JPeg, cxDataControllerConditionalFormattingRulesManagerDialog,
  Winapi.WinInet, untTypesSistema, untRelCtrDebitosCliente;

Type
  TCamDis = record
    strCamDis: String;
    strValDis: String;
End;

type
  TfrmCfgModeloEmail = class(TfrmPaiConfirma)
    pnlEditor: TPanel;
    Label1: TLabel;
    pnlCamDis: TPanel;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    dtsCamDis: TDataSource;
    cxGrid1DBBandedTableViewCitel1: TcxGridDBBandedTableViewCitel;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxGrid1DBBandedTableViewCitel1Column1: TcxGridDBBandedColumn;
    cxStyle2: TcxStyle;
    pnlAssunto: TPanel;
    pnlFundo: TPanel;
    Label2: TLabel;
    edtAssunto: TEditFocus;
    chkEnvDoc: TCheckBox;
    pnlMensagem: TPanel;
    btnConfiguraEmailPedidoCompraPDF: TBitBtnLocked;
    btnRegrasRelatorio: TBitBtnLocked;
    chkEnvXml: TCheckBox;
    chkEnvXls: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxGrid1DBBandedTableViewCitel1CellDblClick(
      Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGrid1DBBandedTableViewCitel1KeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure btnConfiguraEmailPedidoCompraPDFClick(Sender: TObject);
    procedure btnRegrasRelatorioClick(Sender: TObject);
  private
    qryModelo: TUniQuery;
    cdsCamDis: TUniClientDataSet;
    cdsImaEma: TUniClientDataSet;
    strPasImg: String;
    FstrEntSai: String;
    LEditorHtml : TfrmEditorHtml;

    FRegrasRelatorio: String;

    procedure pAbreEditor;
    procedure pCarregaModelo;
    procedure pCarregaImagensModelo;
    procedure pCarregaCamposDisponiveis;
    procedure pCriaClientCamposDisponiveis;
    procedure pCriaClientImagens;
    procedure pGravar;
    procedure pApagaModelo;
    procedure pGravaModelo;

    function CarregaDadosDeModeloPadrao(ACodigoModelo: String): TStringList;

    function GetIEHandle(WebBrowser: TWebbrowser; ClassName: string): HWND;
    function fRetornaCorpoEmail: String;
    procedure pApagarIECache;
    function fPodeExibirOpcaoEnviarPdfDocumento: Boolean;
    function fPodeExibirOpcaoEnviarXmlDocumento(): Boolean;
    function fPodeExibirOpcaoEnviarXlsDocumento: Boolean;

    function fOpcaoDoGrupoEnvioDeBoletoPodeEnviarArqPdf: Boolean;

    function IgnorarCampoModelo(AContador: Integer): Boolean;

    procedure CarregaCheckBoxRegras(var ARelCtrDebitosCliente: TfrmRelCtrDebitosCliente);
    function RetornaCheckboxSelecionado(ARelCtrDebitosCliente: TfrmRelCtrDebitosCliente): String;
    function fPodeParametrizarAnexoDocumentoLinkPagamento: Boolean ;
    function fDocMostrarAnexoDocumentoLinkPagamento: String ;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    strSeqGer: String;
    strEspDoc: String;
    strCodGru: String;
    strCodGat: String;
    blnObrigarAssunto : Boolean;
    optCodigo: string;
    CfgDisparaEmailPedidoDeCompraAutomatico: TCfgDisparaEmailPedidoDeCompraAutomatico;

    blnExibirChkEnvDoc,
    blnExibirChkEnvXml: Boolean;
    blnExibirChkEnvXls: Boolean;

    property strEntSai: String read FstrEntSai write FstrEntSai;
  end;

var
  frmCfgModeloEmail: TfrmCfgModeloEmail;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConstantes, untImagemBase64;

{ TfrmCfgModeloEmail }

procedure TfrmCfgModeloEmail.btnConfiguraEmailPedidoCompraPDFClick(
  Sender: TObject);
begin
  If Assigned(CfgDisparaEmailPedidoDeCompraAutomatico) Then
     CfgDisparaEmailPedidoDeCompraAutomatico(optCodigo)

end;


procedure TfrmCfgModeloEmail.btnConfirmaClick(Sender: TObject);
begin
  If (fVerificaCampos) Then
  Begin
    pGravar;
    ModalResult := mrOk;
    inherited;
  End
  Else
    ModalResult := mrNone;
end;

procedure TfrmCfgModeloEmail.btnRegrasRelatorioClick(Sender: TObject);
  Var
    LRelCtrDebitosCliente: TfrmRelCtrDebitosCliente;
begin
  If Not btnRegrasRelatorio.Visible Then
    Exit;

  pCriarFormularios(TfrmRelCtrDebitosCliente, LRelCtrDebitosCliente);
  Try
    CarregaCheckBoxRegras(LRelCtrDebitosCliente);
    LRelCtrDebitosCliente.ShowModal;

    If LRelCtrDebitosCliente.ModalResult = mrOk Then
      FRegrasRelatorio := RetornaCheckboxSelecionado(LRelCtrDebitosCliente);
  Finally
    FreeAndNil(LRelCtrDebitosCliente);
  End;
end;

procedure TfrmCfgModeloEmail.CarregaCheckBoxRegras(
  var ARelCtrDebitosCliente: TfrmRelCtrDebitosCliente);
begin
  If FRegrasRelatorio.IsEmpty Then
    Exit;

  ARelCtrDebitosCliente.chkContaCorrente.Checked := FRegrasRelatorio.Substring(0, 1) = 'S';
  ARelCtrDebitosCliente.chkProduto.Checked := FRegrasRelatorio.Substring(1, 1) = 'S';
  ARelCtrDebitosCliente.chkCheque.Checked := FRegrasRelatorio.Substring(2, 1) = 'S';
  ARelCtrDebitosCliente.chkObservacao.Checked := FRegrasRelatorio.Substring(3, 1) = 'S';
  ARelCtrDebitosCliente.chkJuros.Checked := FRegrasRelatorio.Substring(4, 1) = 'S';
  ARelCtrDebitosCliente.chkDocAg.Checked := FRegrasRelatorio.Substring(5, 1) = 'S';
  ARelCtrDebitosCliente.chkDtaVen.Checked := FRegrasRelatorio.Substring(6, 1) = 'S';
  ARelCtrDebitosCliente.chkAjuDta.Checked := FRegrasRelatorio.Substring(7, 1) = 'S';
  ARelCtrDebitosCliente.chkEndEre.Checked := FRegrasRelatorio.Substring(8, 1) = 'S';
  ARelCtrDebitosCliente.chkBancoDoBoleto.Checked := FRegrasRelatorio.Substring(9, 1) = 'S';
  ARelCtrDebitosCliente.chkNumPedFF.Checked := FRegrasRelatorio.Substring(10, 1) = 'S';
  ARelCtrDebitosCliente.chkCredito.Checked := FRegrasRelatorio.Substring(11, 1) = 'S';
end;

function TfrmCfgModeloEmail.CarregaDadosDeModeloPadrao(
  ACodigoModelo: String): TStringList;
  Var
    LTexto: String;
begin
  Result := TStringList.Create;

  edtAssunto.Text := 'Aviso de Vencimento - Cobrança com vencimento em <<DIASVEN>> dia(s).';
  LTexto := ' que vencerá em &lt;&lt;DIASVEN&gt;&gt; dia(s)';
  If ACodigoModelo.Equals('024') Then
  Begin
    edtAssunto.Text := 'Aviso de Vencimento - Cobrança com atraso de <<DIASVEN>> dia(s).';
    LTexto := ' que venceu em &lt;&lt;DIASVEN&gt;&gt; dia(s)';
  End;

  Result.Add('<p>Esse é um aviso que existe uma cobrança ' + LTexto + '.</p>');
  Result.Add('<br><p>Dados da Cobrança:<br>');
  Result.Add('<p>&lt;&lt;TABDUP&gt;&gt;</p>');
  Result.Add('<p>&lt;&lt;QRCODE&gt;&gt;</p>');
  Result.Add('<br><br>');
  Result.Add('<strong>*** Caso a liquidação da duplicata já tenha sido efetuada, desconsidere esse aviso. ***</strong>');

  fMensagem('AVISO',
            'O modelo de e-mail carregado está com o texto padrão. ' + #13 +
                'Poderá ser alterado conforme sua necessidade, limitado aos campos disponíveis.',
            ['&Ok']);
end;

procedure TfrmCfgModeloEmail.cxGrid1DBBandedTableViewCitel1CellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  Clipboard.AsText := cdsCamDis.FieldByName('VALCAM').AsString;
  SendMessage(GetIEHandle(LEditorHtml.WebBrowser, 'Internet Explorer_Server'),WM_COMMAND,26, 0);
  pSetFocus(LEditorHtml.WebBrowser);
end;

procedure TfrmCfgModeloEmail.cxGrid1DBBandedTableViewCitel1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
    SelectNext((ActiveControl), True, True);
end;

procedure TfrmCfgModeloEmail.FormActivate(Sender: TObject);
begin
  inherited;
  Self.WindowState := wsMaximized;
end;

procedure TfrmCfgModeloEmail.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  FreeAndNil(qryModelo);
  FreeAndNil(cdsCamDis);
  FreeAndNil(cdsImaEma);

  If (Assigned(LEditorHtml)) Then
  Begin
    LEditorHtml.Close();
    LEditorHtml.Release();
    pFreeAndNil(LEditorHtml);
  End;
  pApagarIECache;
end;

procedure TfrmCfgModeloEmail.FormCreate(Sender: TObject);
begin
  inherited;
  blnExibirChkEnvDoc := True;
  blnExibirChkEnvXml := True;
  blnExibirChkEnvXls := True;

  qryModelo := fCriaQuery(Self);
  strPasImg := ExtractFilePath(Application.ExeName) + PASTA_IMAGEM_EMAIL_AUT + '\';

  If (Not DirectoryExists(strPasImg)) Then
    MkDir(strPasImg);

  FstrEntSai := 'S';
end;

procedure TfrmCfgModeloEmail.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = VK_RETURN) And ((ActiveControl) = edtAssunto) Then
  Begin
    pSetFocus(LEditorHtml.WebBrowser);
    LEditorHtml.Refresh;
    blnMudarFoco := False;
  End
  Else If (Key = VK_F2) Then
  Begin
    Clipboard.AsText := cdsCamDis.FieldByName('VALCAM').AsString;
    SendMessage(GetIEHandle(LEditorHtml.WebBrowser, 'Internet Explorer_Server'),WM_COMMAND,26, 0);
    pSetFocus(LEditorHtml.WebBrowser);
  End
  Else If (Key = VK_F1) Then
  Begin
     edtAssunto.Text := edtAssunto.Text + ' ' + cdsCamDis.FieldByName('VALCAM').AsString;
     pSetFocus(edtAssunto);
  End
  Else
    inherited;

end;

procedure TfrmCfgModeloEmail.FormShow(Sender: TObject);
begin
  inherited;
  pApagarIECache;
  pAbreEditor;
  pCarregaModelo;
  pCarregaCamposDisponiveis;
  pCarregaImagensModelo;

  chkEnvDoc.Visible := fPodeExibirOpcaoEnviarPdfDocumento;
  chkEnvXls.Visible := fPodeExibirOpcaoEnviarPdfDocumento ;
  chkEnvXml.Visible := fPodeExibirOpcaoEnviarXmlDocumento;
  chkEnvXls.Visible := fPodeExibirOpcaoEnviarXlsDocumento;

  If btnConfiguraEmailPedidoCompraPDF.Visible Then
  Begin
    btnConfiguraEmailPedidoCompraPDF.Caption := 'Definir Parâmetros Pedido de Compra';
    chkEnvDoc.Caption := 'Anexar arquivo';
  End;

  btnRegrasRelatorio.Visible := strEspDoc = 'AD';

  if (not chkEnvDoc.Visible) and
     (not chkEnvXml.Visible) and
     (not btnRegrasRelatorio.Visible) then
    pnlAssunto.Height := pnlAssunto.Height - chkEnvDoc.Height;

  frmCfgModeloEmail.blnObrigarAssunto := (strEspDoc <> 'CE');

  pSetFocus(edtAssunto);
end;

function TfrmCfgModeloEmail.fRetornaCorpoEmail: String;
Var
  strCorpo    : String;
  strCorTmp   : String;
  strTagTmp   : String;
  strNomDir   : String;
  strNomArq   : String;
  strArqNov   : String;
  strTagNov   : String;
  intPosTag   : Integer;
  intContador : Integer;
  intContador2: Integer;
  blnConfirma : Boolean;
  stlImagem   : TStringList;
Const
  STR_TAGIMG = '<IMG ';
begin
  Try
    strCorpo := LEditorHtml.WebBrowser.OleObject.Document.Body.InnerHTML;
    stlImagem := TStringList.Create;
    cdsImaEma.EmptyDataSet;

    {*************************************************}
    {* PERCORRE O CORPO DO EMAIL EM BUSCA DE IMAGENS *}
    {**********************************************PZ*}
    While (Pos(STR_TAGIMG, strCorpo) > 0) Do
    Begin
      intPosTag := Pos(STR_TAGIMG, strCorpo);
      strTagTmp := '';

      {******************************}
      {* SEPARA O CAMINHO DA IMAGEM *}
      {***************************PZ*}
      If (intPosTag > 0) Then
      Begin
        For intContador := intPosTag To Length(strCorpo) Do
        Begin
          If (strCorpo[intContador] <> '>') Then
            strTagTmp := strTagTmp + strCorpo[intContador]
          Else
          Begin
            strTagTmp := strTagTmp + '>';
            Break;
          End;
        End;

        stlImagem.Add(strTagTmp);

        {********************************************************}
        {* SUBSTITUI O CAMINHO DA IMAGEM PELA PALAVRA "IMAGEMX" *}
        {* QUE SERÁ UTILIZADA MAIS A BAIXO                      *}
        {*****************************************************PZ*}
        strCorpo := AnsiReplaceStr(strCorpo, strTagTmp, 'IMAGEM' + intToStr(stlImagem.Count));
      End;
    End;

   {*******************************************************}
   {* INICIA O PROCESSO DE SUBSTITUIR O CAMINHO DA IMAGEM *}
   {* ORIGIVAL PELO CAMINHO DA IMAGEM NA PASTA DO AUTCOM  *}
   {****************************************************PZ*}
    For intContador := 0 To stlImagem.Count - 1 Do
    Begin
      strTagTmp := '';
      strCorTmp := stlImagem[intContador];
      intPosTag := Pos('src=', strCorTmp);

     {********************************}
     {* ENCONTRA O CAMINHO DA IMAGEM *}
     {*****************************PZ*}
      If (intPosTag > 0) Then
      Begin
        intPosTag := intPosTag + 5;

        For intContador2 := intPosTag To Length(strCorTmp) Do
        Begin
          If (strCorTmp[intContador2] <> '"')  Then
            strTagTmp := strTagTmp + strCorTmp[intContador2]
          Else
            Break;
        End;
      End;

     {*****************************************************************}
     {* SUBSTITUI O CAMINHO DA IMAGEM PELO CAMINHO DA PASTA DO AUTCOM *}
     {* E CRIA UM NOME ÚNICO PARA A IMAGEM                            *}
     {**************************************************************PZ*}
      If (Not fEmptyStr(strTagTmp)) Then
      Begin
        strNomDir := ExtractFileDir(strTagTmp) + '\';
        strNomArq := ExtractFileName(strTagTmp);
        blnConfirma := True;

        While blnConfirma Do
        Begin
          strArqNov := FormatDateTime('ddmmyyyyhhmmsszzz', fNow) + RightStr(strNomArq, 4);

          // PARA EVITAR DE GRAVAR IMAGENS COM O MESMO NOME
          If (Not FileExists(strArqNov)) Then
          Begin
            strTagNov := AnsiReplaceStr(strTagTmp, strNomDir, strPasImg);
            strTagNov := AnsiReplaceStr(strTagNov, strNomArq, strArqNov);
            strCorTmp := AnsiReplaceStr(strCorTmp, strTagTmp, strTagNov);

            cdsImaEma.Insert;
            cdsImaEma.FieldByName('NOMIMG').AsString := strArqNov;
            TBlobField(cdsImaEma.FieldByName('IMAGEM')).LoadFromFile(strNomDir.Replace('file://', EmptyStr) + strNomArq);
            cdsImaEma.Post;
            TBlobField(cdsImaEma.FieldByName('IMAGEM')).SaveToFile(strPasImg + strArqNov);

            //If (FileExists(strPasImg + strNomArq)) Then
            //  DeleteFile(strPasImg + strNomArq);

            blnConfirma := False;
          End;
        End;

      End;

      strCorpo := AnsiReplaceStr(strCorpo, 'IMAGEM' + intToStr(intContador+1), strCorTmp);

      {*****************************************************************}
      {* SUBSTITUI A TAG <P> por <DIV> PARA MELHORAR A VISUALIZAÇÃO DA *}
      {* MENSAGEM EM DISPOSITIVOS MÓVEIS E TELAS COM BAIXA RESOLÇÃO    *}
      {**************************************************************DF*}
      strCorpo := AnsiReplaceStr(strCorpo, '<P ', '<DIV ');
      strCorpo := AnsiReplaceStr(strCorpo, '<P>', '<DIV>');
      strCorpo := AnsiReplaceStr(strCorpo, '</P>', '</DIV>');
    End;

    Result := strCorpo;

  Finally
    FreeAndNil(stlImagem);
  End;
end;

function TfrmCfgModeloEmail.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtAssunto) Then
    Begin
      if (blnObrigarAssunto) then
      begin
        If (fEmptyStr(edtAssunto.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Assunto deve ser preenchido!', ['&O k']);
          Result := False;
        End;
      end;
    end;

    If (Not Result) Then
      pSetFocus(Sender);
  End;

end;

procedure TfrmCfgModeloEmail.pAbreEditor;
begin
  pCriarFormularios(TfrmEditorHtml, LEditorHtml);
  LEditorHtml.Dock(pnlEditor, pnlEditor.BoundsRect);
  LEditorHtml.Align               := alClient;
  LEditorHtml.Show;

  If (strEspDoc = 'AC') Then
    LEditorHtml.WebBrowser.Silent := True;
end;

procedure TfrmCfgModeloEmail.pApagaModelo;
Var
  strSQL: String;
begin

  Try

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM MODEMA WHERE MOD_SEQGER = :SEQGER ';

    With qryModelo Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('SEQGER').AsString := strSeqGer;
      ExecSQL;
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmCfgModeloEmail.pApagaModelo]');
  End;

end;

procedure TfrmCfgModeloEmail.pApagarIECache;
var
  lpEntryInfo: PInternetCacheEntryInfo;
  hCacheDir: LongWord;
  dwEntrySize: LongWord;
begin

  If (strEspDoc <> 'AC') Then  // apenas cobrança de boleto por enquanto
    Exit;

  dwEntrySize := 0;

  FindFirstUrlCacheEntry(nil, TInternetCacheEntryInfo(nil^), dwEntrySize);

  GetMem(lpEntryInfo, dwEntrySize);

  if dwEntrySize>0 then
    lpEntryInfo^.dwStructSize := dwEntrySize;

  hCacheDir := FindFirstUrlCacheEntry(nil, lpEntryInfo^, dwEntrySize);

  if hCacheDir<>0 then
  begin
    repeat
      Application.ProcessMessages;

      DeleteUrlCacheEntry(lpEntryInfo^.lpszSourceUrlName);
      FreeMem(lpEntryInfo, dwEntrySize);
      dwEntrySize := 0;
      FindNextUrlCacheEntry(hCacheDir, TInternetCacheEntryInfo(nil^), dwEntrySize);
      GetMem(lpEntryInfo, dwEntrySize);
      if dwEntrySize>0 then
        lpEntryInfo^.dwStructSize := dwEntrySize;
    until not FindNextUrlCacheEntry(hCacheDir, lpEntryInfo^, dwEntrySize);

  end;
  FreeMem(lpEntryInfo, dwEntrySize);

  FindCloseUrlCache(hCacheDir)
end;


procedure TfrmCfgModeloEmail.pCarregaCamposDisponiveis;
  procedure pCarregaVariaveisSaida();
  Var
    intContador: Integer;
  begin
    For intContador := 0 To Length(arrVarEma) -1 Do
    Begin
      If (arrVarEma[intContador][2] = 'TODAS') Or (Pos(strEspDoc, arrVarEma[intContador][2]) > 0) Then
      Begin
        If IgnorarCampoModelo(intContador) Then
          Continue;

        cdsCamDis.Insert;
        cdsCamDis.FieldByName('CAMDIS').AsString := arrVarEma[intContador][1];
        cdsCamDis.FieldByName('VALCAM').AsString := arrVarEma[intContador][0];
        cdsCamDis.Post;
      End;
    End;
  end;

  procedure pCarregaVariaveisEntrada();
  Var
    intContador: Integer;
  begin
    For intContador := 0 To Length(arrVarEmE) -1 Do
    Begin
      If (arrVarEmE[intContador][2] = 'TODAS') Or (Pos(strEspDoc, arrVarEmE[intContador][2]) > 0) Then
      Begin
        cdsCamDis.Insert;
        cdsCamDis.FieldByName('CAMDIS').AsString := arrVarEmE[intContador][1];
        cdsCamDis.FieldByName('VALCAM').AsString := arrVarEmE[intContador][0];
        cdsCamDis.Post;
      End;
    End;
  end;
begin
  pCriaClientCamposDisponiveis;
  pCriaClientImagens;

  If FstrEntSai = 'S' Then
    pCarregaVariaveisSaida()
  Else
    pCarregaVariaveisEntrada();

  cdsCamDis.Open;
  dtsCamDis.DataSet := cdsCamDis;
end;

procedure TfrmCfgModeloEmail.pCarregaImagensModelo;
Var
  strSQL: String;
  qryImg: TUniQuery;
  tmpImg: TBytesStream;

begin

  Try

    tmpImg := TBytesStream.Create(nil);
    qryImg := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  IMG_NOMIMG AS NOMIMG, ';
    strSQL := strSQL + '  IMG_IMAGEM AS IMAGEM, ';
    strSQL := strSQL + '  IMG_IMGB64 AS IMGB64  ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  MODEMA ';
    strSQL := strSQL + '  INNER JOIN IMGMOD ON IMG_SEQGER = MODEMA.AUTOINCREM ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  MOD_SEQGER = :SEQGER ';

    With qryImg Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('SEQGER').AsString := strSeqGer;
      Open;

      While Not Eof Do
      Begin
        If (Not FileExists(strPasImg + FieldByName('NOMIMG').AsString)) Then
        Begin
          cdsImaEma.Insert;
          cdsImaEma.FieldByName('NOMIMG').AsString := FieldByName('NOMIMG').AsString;
          If FieldByName('IMAGEM').isNull Then
          Begin
            cdsImaEma.FieldByName('IMAGEM').Value := FieldByName('IMGB64').AsString;
            fStreamFromBase64(FieldByName('IMGB64').AsString, tmpImg);
            If (tmpImg.Size > 0) Then
              tmpImg.SaveToFile(strPasImg + FieldByName('NOMIMG').AsString);
          End
          Else
          Begin
            cdsImaEma.FieldByName('IMAGEM').Value := FieldByName('IMAGEM').Value;
            TBlobField(cdsImaEma.FieldByName('IMAGEM')).SaveToFile(strPasImg + FieldByName('NOMIMG').AsString);
          End;
          cdsImaEma.Post;
        End;
        Next;
      End;

    End;

  Finally
    FreeAndNil(qryImg);
    FreeAndNil(tmpImg);
  End;

end;

procedure TfrmCfgModeloEmail.pCarregaModelo;
Var
  strSQL    : String;
  stlArqHtml: TStringList;
  Flags     : OleVariant;
  strNomArq : String;

  LCodigoEmail: String;
begin
  Try

    strNomArq := ExtractFilePath(Application.ExeName) + 'ModeloEmail.html';

    LEditorHtml.WebBrowser.RegisterAsBrowser := False;
    Flags := 'navNoHistory,navNoReadFromCache,navNoWriteToCache';

    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  MOD_ASSUNT AS ASSUNT, ';
    strSQL := strSQL + '  MOD_MODELO AS MODELO, ';
    strSQL := strSQL + '  MOD_ENVDOC AS ENVDOC, ';
    strSQL := strSQL + '  MOD_ENVXML AS ENVXML, ';
    strSQL := strSQL + '  MOD_ENVXLS AS ENVXLS, ';
    strSQL := strSQL + '  MOD_REGREL ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  MODEMA ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  MOD_SEQGER = :SEQGER ';

    qryModelo.Close;
    qryModelo.SQL.Clear;
    qryModelo.SQL.Add(strSQL);
    qryModelo.ParamByName('SEQGER').AsString := strSeqGer;
    qryModelo.Open;

    If (Not qryModelo.IsEmpty)Then
    Begin
      edtAssunto.Text := qryModelo.FieldByName('ASSUNT').AsString;
      stlArqHtml := TStringList.Create;
      stlArqHtml.Add(qryModelo.FieldByName('MODELO').Value);
      stlArqHtml.SaveToFile(strNomArq, TEncoding.UTF8);
      LEditorHtml.WebBrowser.Navigate(strNomArq, Flags);

      chkEnvDoc.Checked := qryModelo.FieldByName('ENVDOC').AsString = 'S';
      chkEnvXml.Checked := qryModelo.FieldByName('ENVXML').AsString = 'S';
      chkEnvXls.Checked := qryModelo.FieldByName('ENVXLS').AsString = 'S';
      FRegrasRelatorio := qryModelo.FieldByName('MOD_REGREL').AsString;

      Exit;
    End;

    If Not strEspDoc.Equals('AC') Then
      Exit;

    LCodigoEmail := fCampoTabela('EMA_CODIGO', 'EMASAI', ['AUTOINCREM'], [strSeqGer]);

    If MatchStr(LCodigoEmail, ['023', '024']) Then
    Begin
      stlArqHtml := CarregaDadosDeModeloPadrao(LCodigoEmail);
      stlArqHtml.SaveToFile(strNomArq, TEncoding.UTF8);
      LEditorHtml.WebBrowser.Navigate(strNomArq, Flags);

      chkEnvDoc.Checked := False;
      chkEnvXml.Checked := False;
      chkEnvXls.Checked := False;
      FRegrasRelatorio := EmptyStr;
    End;
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmCfgModeloEmail.pCarregaModelo]');
  End;

end;

procedure TfrmCfgModeloEmail.pCriaClientCamposDisponiveis;
begin

  cdsCamDis := TUniClientDataSet.Create(Self);
  {***********************************}
  {* DEFINIÇÃO DOS CAMPOS            *}
  {********************************PZ*}
  With cdsCamDis.FieldDefs.AddFieldDef Do Begin Name := 'CAMDIS'; DataType := ftString; Size := 050; Required := False; End;
  With cdsCamDis.FieldDefs.AddFieldDef Do Begin Name := 'VALCAM'; DataType := ftString; Size := 050; Required := False; End;

  cdsCamDis.CreateDataSet;

end;

procedure TfrmCfgModeloEmail.pCriaClientImagens;
begin
  cdsImaEma := TUniClientDataSet.Create(Self);
  {***********************************}
  {* DEFINIÇÃO DOS CAMPOS            *}
  {********************************PZ*}
  With cdsImaEma.FieldDefs.AddFieldDef Do Begin Name := 'NOMIMG'; DataType := ftString; size := 30;  Required := False; End;
  With cdsImaEma.FieldDefs.AddFieldDef Do Begin Name := 'IMAGEM'; DataType := ftBlob;                Required := False; End;

  cdsImaEma.CreateDataSet;
  TBlobField.Create(cdsImaEma.FieldByName('IMAGEM') as TBlobField);
end;

procedure TfrmCfgModeloEmail.pGravaModelo;
Var
  strSQL    : String;
  strAutInc : String;
  Stream    : TMemoryStream;
begin

  Try

    Try

      Stream := TMemoryStream.Create;

      fStartTransaction;

      strSQL := '';
      strSQL := strSQL + 'INSERT INTO ';
      strSQL := strSQL + '  MODEMA(AUTOINCREM,  ';
      strSQL := strSQL + '         MOD_SEQGER,  ';
      strSQL := strSQL + '         MOD_ASSUNT,  ';
      strSQL := strSQL + '         MOD_MODELO,  ';
      strSQL := strSQL + '         MOD_ENVDOC,  ';
      strSQL := strSQL + '         MOD_ENVXML,  ';
      strSQL := strSQL + '         MOD_ENVXLS,  ';
      strSQL := strSQL + '         MOD_REGREL)  ';
      strSQL := strSQL + '  VALUES(:AUTINC,     ';
      strSQL := strSQL + '         :SEQGER,     ';
      strSQL := strSQL + '         :ASSUNT,     ';
      strSQL := strSQL + '         :MODELO,     ';
      strSQL := strSQL + '         :ENVDOC,     ';
      strSQL := strSQL + '         :ENVXML,     ';
      strSQL := strSQL + '         :ENVXLS,     ';
      strSQL := strSQL + '         :REGREL)     ';


      qryModelo.Close;
      qryModelo.SQL.Clear;
      qryModelo.SQL.Add(strSQL);

      strAutInc := fRetAutoIncrem('MODEMA', VS_strCodEmp);

      qryModelo.ParamByName('AUTINC').AsString := strAutInc;
      qryModelo.ParamByName('SEQGER').AsString := strSeqGer;
      qryModelo.ParamByName('ASSUNT').AsString := edtAssunto.Text;
      qryModelo.ParamByName('MODELO').Value    := fRetornaCorpoEmail;
      qryModelo.ParamByName('ENVDOC').AsString := IIF(chkEnvDoc.Visible And chkEnvDoc.Checked, 'S', 'N');
      qryModelo.ParamByName('ENVXML').AsString := IIF(chkEnvXml.Visible And chkEnvXml.Checked, 'S', 'N');
      qryModelo.ParamByName('ENVXLS').AsString := IIF(chkEnvXLS.Visible And chkEnvXls.Checked, 'S', 'N');

      qryModelo.ParamByName('REGREL').Value    := Null;
      If Not FRegrasRelatorio.IsEmpty Then
        qryModelo.ParamByName('REGREL').AsString := FRegrasRelatorio;

      qryModelo.ExecSQL;

      strSQL := '';
      strSQL := strSQL + 'INSERT INTO           ';
      strSQL := strSQL + '  IMGMOD(AUTOINCREM,  ';
      strSQL := strSQL + '         IMG_SEQGER,  ';
      strSQL := strSQL + '         IMG_NOMIMG,  ';
      strSQL := strSQL + '         IMG_IMAGEM,  ';
      strSQL := strSQL + '         IMG_IMGB64)  ';
      strSQL := strSQL + '  VALUES(:AUTINC,     ';
      strSQL := strSQL + '         :SEQGER,     ';
      strSQL := strSQL + '         :NOMIMG,     ';
      strSQL := strSQL + '         :IMAGEM,     ';
      strSQL := strSQL + '         :IMGB64)     ';

      While Not cdsImaEma.Eof Do
      Begin

        (cdsImaEma.FieldByName('IMAGEM') as TBlobField).SaveToStream(Stream);
        Stream.Position := 0;

        qryModelo.Close;
        qryModelo.SQL.Clear;
        qryModelo.SQL.Add(strSQL);

        qryModelo.ParamByName('AUTINC').AsString := fRetAutoIncrem('IMGMOD', VS_strCodEmp);
        qryModelo.ParamByName('SEQGER').AsString := strAutInc;
        qryModelo.ParamByName('NOMIMG').AsString := cdsImaEma.FieldByName('NOMIMG').AsString;
        qryModelo.ParamByName('IMAGEM').Clear;
        qryModelo.ParamByName('IMGB64').AsString := fBase64FromFile('.\Imagens_Email\' + cdsImaEma.FieldByName('NOMIMG').AsString);
 
        qryModelo.ExecSQL;

        cdsImaEma.Next;
      End;

      fCommit;

    Finally
      FreeAndNil(Stream);
    End;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(e.Message, '[TfrmCfgModeloEmail.pGravaModelo]');
    End;
  End;
end;

procedure TfrmCfgModeloEmail.pGravar;
begin
  pApagaModelo;
  pGravaModelo;
end;

function TfrmCfgModeloEmail.RetornaCheckboxSelecionado(
  ARelCtrDebitosCliente: TfrmRelCtrDebitosCliente): String;
begin
  Result := Concat(fBoleanoToStrSN(ARelCtrDebitosCliente.chkContaCorrente.Checked),
                   fBoleanoToStrSN(ARelCtrDebitosCliente.chkProduto.Checked),
                   fBoleanoToStrSN(ARelCtrDebitosCliente.chkCheque.Checked),
                   fBoleanoToStrSN(ARelCtrDebitosCliente.chkObservacao.Checked),
                   fBoleanoToStrSN(ARelCtrDebitosCliente.chkJuros.Checked),
                   fBoleanoToStrSN(ARelCtrDebitosCliente.chkDocAg.Checked),
                   fBoleanoToStrSN(ARelCtrDebitosCliente.chkDtaVen.Checked),
                   fBoleanoToStrSN(ARelCtrDebitosCliente.chkAjuDta.Checked),
                   fBoleanoToStrSN(ARelCtrDebitosCliente.chkEndEre.Checked),
                   fBoleanoToStrSN(ARelCtrDebitosCliente.chkBancoDoBoleto.Checked),
                   fBoleanoToStrSN(ARelCtrDebitosCliente.chkNumPedFF.Checked),
                   fBoleanoToStrSN(ARelCtrDebitosCliente.chkCredito.Checked));
end;

function TfrmCfgModeloEmail.GetIEHandle(WebBrowser: TWebbrowser; ClassName: string): HWND;
var
  hwndChild, hwndTmp: HWND;
  oleCtrl: TOleControl;
  szClass: array [0..255] of char;
begin
  oleCtrl :=WebBrowser;
  hwndTmp := oleCtrl.Handle;
  while (true) do
  begin
    hwndChild := GetWindow(hwndTmp, GW_CHILD);
    GetClassName(hwndChild, szClass, SizeOf(szClass));
    if (string(szClass)=ClassName) then
    begin
      Result :=hwndChild;
      Exit;
    end;
    hwndTmp := hwndChild;
  end;
  Result := 0;
end;

function TfrmCfgModeloEmail.IgnorarCampoModelo(AContador: Integer): Boolean;
begin
  Result := False;

  If Pos(arrVarEma[AContador][0], '<<NOMCVE>>_<<CONVEN>>_<<NOMPRO>>_') > 0 Then
    Exit(True);

  If arrVarEma[AContador][0] = '<<LNKBOL>>' Then
    Exit(True);

  If MatchStr(strEspDoc, ['PX', 'AD', 'ET', 'CL']) Then
  Begin
    If arrVarEma[AContador][0] = '<<NUMEOS>>' Then
      Exit(True);
  End;

  If strEspDoc = 'PX' Then
  Begin
    If (arrVarEma[AContador][0] = '<<TABDUPPX>>') Then
    Begin
       If fCampoTabela('EMA_CODIGO', 'EMASAI', ['AUTOINCREM'], [strSeqGer]) = '002' Then
         Exit(True);
    End;
  End;

  If strEspDoc = 'TE' Then
  Begin
    If (Pos(fCfgSis('OPCROM', varString), '1_5_') > 0) and (Pos(arrVarEma[AContador][0], '<<DOCVEN>>_<<EMPVEN>>_<<NROVEN>>_<<ESPVEN>>_') > 0) then
      Exit(True)
    Else If (Pos(fCfgSis('OPCROM', varString), '1_5_') <= 0) and (Pos(arrVarEma[AContador][0], '<<PEDVEN>>_') > 0) then
      Exit(True)
  End;

  If strEspDoc = 'AC' Then
   Begin
    If arrVarEma[AContador][0].Equals('<<DIASVEN>>') Then
    Begin
      If Not MatchStr(fCampoTabela('EMA_CODIGO', 'EMASAI', ['AUTOINCREM'], [strSeqGer]),['023', '024']) Then
        Exit(True);
    End;
  End;

  If strEspDoc = 'BO' Then
  Begin
    if (MatchStr(arrVarEma[AContador][0], ['<<CGCEMP>>', '<<CGCCLI>>', '<<SERIE_>>', '<<ACESSO>>', '<<HOREMI>>', '<<ENDEMP>>', '<<ENDCLI>>'])) and
       (not MatchStr(Concat(strCodGru, strCodGat),['008004'])) then
      Exit(True);
  End;
end;

function TfrmCfgModeloEmail.fPodeExibirOpcaoEnviarPdfDocumento(): Boolean;
begin
  Result := True;

  if not blnExibirChkEnvDoc then
  begin
    Result := False;
    Exit;
  end;

  If (strEspDoc = 'BO') Then
  Begin
    If (fOpcaoDoGrupoEnvioDeBoletoPodeEnviarArqPdf) Then
      Exit;
  End
  Else If Pos(strEspDoc, 'PD_OR_AN_FF_RC_RL_'+fDocMostrarAnexoDocumentoLinkPagamento) > 0 Then
    Exit
  Else If strEntSai = 'E' Then
    Exit;

  Result := False;
end;

function TfrmCfgModeloEmail.fPodeExibirOpcaoEnviarXmlDocumento(): Boolean;
begin
  if not blnExibirChkEnvXml then
  begin
    Result := False;
    Exit;
  end;

  Result := (strEspDoc = 'AN');

  if (Result) and (not chkEnvDoc.Visible) then
    chkEnvXml.Left := chkEnvDoc.Left;
end;

function TfrmCfgModeloEmail.fPodeParametrizarAnexoDocumentoLinkPagamento: Boolean;
begin
  Result := fUsaLinkPagamentoSitefCielo and (strEspDoc = 'CB') ;
end;

function TfrmCfgModeloEmail.fDocMostrarAnexoDocumentoLinkPagamento: String;
begin
  Result := '' ;
  if not fPodeParametrizarAnexoDocumentoLinkPagamento then
    Exit ;

  Result := 'CB_' ;
end;

function TfrmCfgModeloEmail.fOpcaoDoGrupoEnvioDeBoletoPodeEnviarArqPdf() : Boolean;
begin
  Result := False;

  If (strEspDoc <> 'BO') Then
    Exit;

  If (fCampoTabela('EMA_CODIGO', 'EMASAI', ['AUTOINCREM'], [strSeqGer]) <> '004') then
    Exit;

  if fPodeParametrizarAnexoDocumentoLinkPagamento then
    Exit;

  Result := True;
end;

function TfrmCfgModeloEmail.fPodeExibirOpcaoEnviarXlsDocumento: Boolean;
begin
  Result := False;

  if not blnExibirChkEnvXls then
    Exit;

  if Pos(strEspDoc, 'CL_OR_') > 0 then
    Exit;

  Result := True;
end;

end.
