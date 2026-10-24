unit untConsultaPedidoCompra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untConsultaComp, DB,  
  Uni, ExtCtrls, StdCtrls, ComCtrls, Buttons, Grids, DBGridCitel, DBGrids, Mapi, frxClass, StrUtils;

type
  TfrmConsultaPedidoCompra = class(TfrmConsultaComp)
    Panel2: TPanel;
    btnEnviarEmail: TBitBtn;
    btnBaixaPedido: TBitBtn;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnEnviarEmailClick(Sender: TObject);
    procedure edtFiltro1Change(Sender: TObject);

    function  fGeraEmail(strNumPed, strEspDoc, strEmpDes: String): String;
    procedure btnBaixaPedidoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    procedure pDesabilitaColunas;

    function EnviarEMail(const De, Para, Assunto, Texto,
                         Arquivo: string; Confirma: Boolean): Integer;

    procedure pBaixaPedidoCompraNaoEntregues;
    procedure pRefazConsulta(strCodEmp, strEspDoc: String);
    procedure pSelect(strSQL: String);    
    function fUpdatePCMGER(strMotivo: String): Boolean;
    function fUpdatePCMDET: Boolean;

  protected
    procedure pAtuIndice(intIndice: Integer); override;
    function fPodeDigitar(strTexto: String): Boolean;
    function fMontaSQLPed: String; overload;
    function fMontaSQL: String; override;

  public
    { Public declarations }
    blnSemPre : Boolean;
    blnOrdDig : Boolean;
    strTipExp : String;
    strNomeArquivo : String;
    intMinimoDigitos: Integer;
    strCodEmp : String;
    strEspecie: String;    
  end;

var
  frmConsultaPedidoCompra: TfrmConsultaPedidoCompra;

implementation

uses untModuloPcmGer, untFuncoes, untfuncoesSimples, untDigEmail, untPesqAux, untModuloCadFor,
  untDigEmailPedidoCompra, untQckHTMLPedidoCompra,
  untQckHTMLCliente;

{$R *.dfm}

{***********************************************}
{* FUNÇÃO QUE ABRE O OUTLOOK E ANEXO O ARQUIVO *}
{********************************************AC*}
function TfrmConsultaPedidoCompra.EnviarEMail(const De, Para, Assunto, Texto,
  Arquivo: string; Confirma: Boolean): Integer;
var
  Msg: TMapiMessage;
  lpSender, lpRecepient: TMapiRecipDesc;
  FileAttach: TMapiFileDesc;
  SM: TFNMapiSendMail;
  MAPIModule: HModule;
  Flags: Cardinal;
begin
  // cria propriedades da mensagem
  FillChar(Msg, SizeOf(Msg), 0);
  with Msg do
    begin
      if (Assunto <> '') then
        lpszSubject := PChar(Assunto);
       if (Texto <> '') then
        lpszNoteText := PChar(Texto);

      // remetente
      if (De <> '') then
        begin
          lpSender.ulRecipClass := MAPI_ORIG;
          lpSender.lpszName     := PChar(De);
          lpSender.lpszAddress  := PChar(De);
          lpSender.ulReserved   := 0;
          lpSender.ulEIDSize    := 0;
          lpSender.lpEntryID    := nil;
          lpOriginator          := @lpSender;
        end;

      // destinatário
      if (Para <> '') then
        begin
          lpRecepient.ulRecipClass := MAPI_TO;
          lpRecepient.lpszName     := PChar(Para);
          lpRecepient.lpszAddress  := PChar(Para);
          lpRecepient.ulReserved   := 0;
          lpRecepient.ulEIDSize    := 0;
          lpRecepient.lpEntryID    := nil;
          nRecipCount              := 1;
          lpRecips                 := @lpRecepient;
        end
      else
        lpRecips := nil;

      // arquivo anexo
      if (Arquivo = '') then
        begin
          nFileCount := 0;
          lpFiles    := nil;
        end
      else
        begin
          FillChar(FileAttach, SizeOf(FileAttach), 0);
          FileAttach.nPosition    := Cardinal($FFFFFFFF);
          FileAttach.lpszPathName := PChar(Arquivo);
          nFileCount              := 1;
          lpFiles                 := @FileAttach;

          {*******************************************}
          {* ANEXA A IMAGEM TAMBÉM SE NECESSARIO     *}
          {* SÓ É PRECISO CRIAR UMA NOVA VARIÁVEL    *}
          {* FileAttach E ACRESCENTAR MAIS UM        *)
          {* PARÂMETRO Arquivo NA FUNÇÃO             *)
          {****************************************AC*}
          //FillChar(FileAttach2, SizeOf(FileAttach2), 0);
          //FileAttach2.nPosition    := Cardinal($FFFFFFFFF);
          //FileAttach2.lpszPathName := PChar(Arquivo2);
          //nFileCount               := 2;
          //lpFiles                  := @FileAttach2;
        end;
    end;
  // carrega dll e o método para envio do email
  MAPIModule := LoadLibrary(PChar(MAPIDLL));
  if MAPIModule = 0 then
    Result := -1
  else
    try
      if Confirma then
        Flags := MAPI_DIALOG or MAPI_LOGON_UI
      else
        Flags := 0;
      @SM := GetProcAddress(MAPIModule, 'MAPISendMail');
      if @SM <> nil then
        Result := SM(0, Application.Handle, Msg, Flags, 0)
      else
        Result := 1;
    finally
      FreeLibrary(MAPIModule);
    end;
end;

function TfrmConsultaPedidoCompra.fPodeDigitar(strTexto: String): Boolean;
begin
  Result := False;
  If (intMinimoDigitos = -1) Or (Length(strTexto) >= intMinimoDigitos) Then
    Result := True;
end;

procedure TfrmConsultaPedidoCompra.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F9) Then
  Begin
    btnEnviarEmail.Click;
  End
  Else If (Key = VK_F10) And (btnBaixaPedido.Visible) Then
  Begin
    btnBaixaPedido.Click;
  End;  
end;

procedure TfrmConsultaPedidoCompra.btnEnviarEmailClick(Sender: TObject);
  Var
    strArqHtml : String;
    strAssunto : String;
    strTexto   : String;
    blnConfirma: Boolean;
    qryGenFor  : TUniQuery;

    strDestinatario     : String;
    strEmailDestinatario: String;

begin
  inherited;

  blnConfirma := False;

  Try
    Application.CreateForm(TfrmDigEmailPedidoCompra, frmDigEmailPedidoCompra);
    {*********************************************}
    {* CARREGA O EMAIL E O CONTATO DO FORNECEDOR *}
    {******************************************JB*}
    qryGenFor := frmModuloCadFor.qryCadFor;
    pPesquisaCadFor(frmModuloCadFor.qryCadFor, qryGenFor, qryConsulta.FieldByName('Cód. Forn.').AsString);
    frmDigEmailPedidoCompra.edtEmail.Text   := qryGenFor.FieldByName('FOR_EMAIL_').AsString;
    frmDigEmailPedidoCompra.edtContato.Text := qryGenFor.FieldByName('FOR_CONTAT').AsString;
    blnConfirma := (frmDigEmailPedidoCompra.ShowModal = mrOk);
  Finally
    If (blnConfirma) Then
    Begin
      strDestinatario      := frmDigEmailPedidoCompra.edtContato.Text;
      strEmailDestinatario := frmDigEmailPedidoCompra.edtEmail.Text;
      blnSemPre            := frmDigEmailPedidoCompra.blnSemPre;
      blnOrdDig            := frmDigEmailPedidoCompra.blnOrdDig;
      strTipExp            := frmDigEmailPedidoCompra.strTipExp;
    End;
    pFreeAndNil(frmDigEmailPedidoCompra);
  End;

  If (Not blnConfirma) Then
  Begin
    Exit;
  End;

  strArqHtml := fGeraEmail(qryConsulta.FieldByName('Pedido').AsString,
                           qryConsulta.FieldByName('Espécie').AsString,
                           qryConsulta.FieldByName('Emp. Destino').AsString);

  {************************************************}
  {* FUNÇÃO QUE ABRE O OUTLOOK E ANEXA O  ARQUIVO *}
  {*********************************************LU*}
  If (Not fEmptyStr(strNomeArquivo)) Then
  Begin
    If (qryConsulta.FieldByName('Espécie').AsString = 'PD') Then
    Begin
      strAssunto := 'Pedido de Compra Nº: ';
      strTexto := 'Segue em anexo Pedido de Compra.';
    End
    Else
    Begin
      strAssunto := 'Orçamento Nº: ';
      strTexto := 'Segue em anexo Orçamento.';
    End;

    If strTipExp = 'PDF' Then
    Begin
      strTexto := strTexto + #13#10 + #13#10;
      strTexto := strTexto + 'Caso não possua o programa Acrobat Reader para visualizar o arquivo anexo, ';
      strTexto := strTexto + 'acesse o link e faça o download: www.adobe.com';
    End;

    strAssunto := fRetNomeEmpresa + ' - ' + strAssunto + qryConsulta.FieldByName('Pedido').AsString;

    EnviarEMail('', strEmailDestinatario, strAssunto , strTexto, strNomeArquivo, True);
    SetForegroundWindow(Handle);
  End
  Else
    fMensagem('ATENÇÃO!', 'Não foi possível exportar o arquivo PDF !', ['&Ok']);

end;

function TfrmConsultaPedidoCompra.fGeraEmail(strNumPed, strEspDoc, strEmpDes: String): String;
  Var
    strSQL         : String;
    strExecutavel  : String;
    strDirImagem   : String;
begin

  Try
    Application.CreateForm(TfrmQckHTMLPedidoCompra, frmQckHTMLPedidoCompra);

    With frmQckHTMLPedidoCompra Do
    Begin
      {**********************************************}
      {* CARREGANDO OS DADOS DO TOPO DO PEDIDO      *}
      {*******************************************LU*}
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  PCMGER.*, ';
      strSQL := strSQL + '  CADFOR.*, ';
      strSQL := strSQL + '  CONCAT(CADCID.CID_NOMCID, " - ", CADCID.CID_ESTADO) AS FOR_NOMCID ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  PCMGER ';
      strSQL := strSQL + '  JOIN CADFOR ON (PCMGER.PCG_CODFOR = CADFOR.FOR_CODFOR) ';
      strSQL := strSQL + '  LEFT JOIN CADCID ON (CADFOR.FOR_CODCID = CADCID.CID_CODCID)';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  PCMGER.PCG_NUMCTN = 0 AND ';
      strSQL := strSQL + '  PCMGER.PCG_NUMPED = :NUMPED AND ';
      strSQL := strSQL + '  PCMGER.PCG_ESPDOC = :ESPDOC AND ';
      strSQL := strSQL + '  PCMGER.PCG_CODEMP = :CODEMP ';

      With qryPedido Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMPED').AsString := strNumPed;
        ParamByName('ESPDOC').AsString := strEspDoc;
        If fEmptyStr(strCodEmp) Then
          ParamByName('CODEMP').AsString := VS_strCodEmp
        Else
          ParamByName('CODEMP').AsString := strCodEmp;
        Open;

        TFloatField(FieldByName('PCG_TOTITE')).DisplayFormat := '#,##0.00';
        TFloatField(FieldByName('PCG_TOTGER')).DisplayFormat := '#,##0.00';
        TFloatField(FieldByName('PCG_TOTIPI')).DisplayFormat := '#,##0.00';
        TFloatField(FieldByName('PCG_TOTSUB')).DisplayFormat := '#,##0.00';
      End;
      {**************************************}
      {* CARREGANDO OS ITENS DO PEDIDO      *}
      {***********************************LU*}
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  PCMDET.*, ';
      strSQL := strSQL + '  CADITE.*, ';
      strSQL := strSQL + '  CADMAR.MAR_DESMAR, ';
      strSQL := strSQL + '  CADUNI.UNI_SIGUNI, ';
      strSQL := strSQL + '  (PCD_QTDITE * UNI_PESLIT) AS LITROS ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  PCMDET ';
      strSQL := strSQL + '  JOIN CADITE ON (PCMDET.PCD_CODITE = CADITE.ITE_CODITE) ';
      strSQL := strSQL + '  LEFT JOIN CADUNI ON (CADITE.ITE_CODUNI = CADUNI.UNI_CODUNI) ';
      strSQL := strSQL + '  LEFT JOIN CADMAR ON (CADITE.ITE_CODMAR = CADMAR.MAR_CODMAR) ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  PCMDET.PCD_NUMCTN = 0 AND ';
      strSQL := strSQL + '  PCMDET.PCD_NUMPED = :NUMPED AND ';
      strSQL := strSQL + '  PCMDET.PCD_ESPDOC = :ESPDOC AND ';
      strSQL := strSQL + '  PCMDET.PCD_CODEMP = :CODEMP ';
      strSQL := strSQL + 'ORDER BY ';
      If blnOrdDig Then
        strSQL := strSQL + '  PCMDET.AUTOINCREM '
      else
        strSQL := strSQL + '  PCMDET.PCD_DESITE ';

      With qryRelatorio Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMPED').AsString := strNumPed;
        ParamByName('ESPDOC').AsString := strEspDoc;
        If fEmptyStr(strCodEmp) Then
          ParamByName('CODEMP').AsString := VS_strCodEmp
        Else
          ParamByName('CODEMP').AsString := strCodEmp;
        Open;

        TFloatField(FieldByName('PCD_QTDITE')).DisplayFormat := '#,###0.000';
        TFloatField(FieldByName('PCD_UNITAR')).DisplayFormat := '#,###0.000';
        TFloatField(FieldByName('PCD_TOTITE')).DisplayFormat := '#,###0.000';
        TFloatField(FieldByName('PCD_PERIPI')).DisplayFormat := '#,##0.00';
        TFloatField(FieldByName('PCD_TOTIPI')).DisplayFormat := '#,##0.00';
        TFloatField(FieldByName('PCD_PERSUB')).DisplayFormat := '#,##0.00';
        TFloatField(FieldByName('PCD_TOTSUB')).DisplayFormat := '#,##0.00';
      End;
      {**************************************}
      {* CARREGANDO OS DADOS DA EMPRESA     *}
      {***********************************LU*}
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  CADEMP.EMP_CODEMP, ';
      strSQL := strSQL + '  CADEMP.EMP_NOMEMP,';
      strSQL := strSQL + '  CONCAT(CADEMP.EMP_ENDERE, ", ", CADEMP.EMP_ENDNUM) AS EMP_ENDERE, ';
      strSQL := strSQL + '  CONCAT(CADCID.CID_NOMCID, " - ", CADCID.CID_ESTADO) AS EMP_NOMCID,';
      strSQL := strSQL + '  CADEMP.EMP_EMAILC,';
      strSQL := strSQL + '  CADEMP.EMP_FONE01,';
      strSQL := strSQL + '  CADEMP.EMP_F_A_X_,';
      strSQL := strSQL + '  CADEMP.EMP_C_G_C_,';
      strSQL := strSQL + '  CADEMP.EMP_I_E_S_ ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADEMP ';
      strSQL := strSQL + '  LEFT JOIN CADCID ON (CADEMP.EMP_CODCID = CADCID.CID_CODCID) ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CADEMP.EMP_CODEMP = :CODEMP ';

      With qryEmpresa Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        If Not fEmptyStr(strEmpDes) Then
          ParamByName('CODEMP').AsString := strEmpDes
        Else
        Begin
          If fEmptyStr(strCodEmp) Then
            ParamByName('CODEMP').AsString := VS_strCodEmp
          Else
            ParamByName('CODEMP').AsString := strCodEmp;
        End;
        Open;
      End;
      {**********************************************}
      {* CARREGANDO OS DADOS DA TRANSPORTADORA      *}
      {*******************************************LU*}
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  CADTRA.*, ';
      strSQL := strSQL + '  CONCAT(CADCID.CID_NOMCID, " - ", CADCID.CID_ESTADO) AS TRA_NOMCID ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADTRA ';
      strSQL := strSQL + '  LEFT JOIN CADCID ON (CADTRA.TRA_CODCID = CADCID.CID_CODCID) ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CADTRA.TRA_CODTRA = :CODTRA ';

      With qryTransp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODTRA').AsString := qryPedido.FieldByName('PCG_CODTRA').AsString;
        Open;
      End;

      {******************************************************************}
      {* SE NÃO EXISTIR O ARQUIVO - LOGO - ELE NÃO CARREGA NO RELATÓRIO *}
      {***************************************************************LU*}
      strDirImagem := '';
      If FileExists(VS_strPatLog) Then
        strDirImagem := VS_strPatLog
      Else
        strDirImagem := '';

    End;

    {*******************************************}
    {* PEGA O ENDEREÇO CORRENTE DO EXECUTÁVEL  *}
    {****************************************LU*}
    strExecutavel := ExtractFilePath(Application.ExeName);

    {*******************************************}
    {* SE NÃO EXISTIR O DIRETÓRIO ELE CRIA     *}
    {****************************************LU*}
    If Not DirectoryExists(strExecutavel+'PedidoCompra') Then
      CreateDir(strExecutavel+'PedidoCompra');

    {*******************************************}
    {* O ARQUIVO SERÁ GERADO COM ESSE NOME     *}
    {****************************************LU*}
    If (qryConsulta.FieldByName('Espécie').AsString = 'PD') Then
    Begin
      If strTipExp = 'PDF' Then
        strNomeArquivo := 'PD_' + strNumPed + '.pdf'
      Else
        strNomeArquivo := 'PD_' + strNumPed + '.xls';
    End
    Else
    Begin
      If strTipExp = 'PDF' Then
        strNomeArquivo := 'OR_' + strNumPed + '.pdf'
      Else
        strNomeArquivo := 'OR_' + strNumPed + '.xls'
    End;

    {**************************}
    {* EXPORTA O ARQUIVO PDF  *}
    {***********************LU*}
    With frmQckHTMLPedidoCompra Do
    Begin
      If fEmptyStr(strDirImagem) Then
        TfrxPictureView(frxPagina.FindObject('rllImagem')).Clear
      Else
        TfrxPictureView(frxPagina.FindObject('rllImagem')).Picture.LoadFromFile(strDirImagem);

      TfrxMemoView(frxPagina.FindObject('rllData')).Memo.Clear;
      TfrxMemoView(frxPagina.FindObject('rllData')).Memo.Add(fRetDataExtenso(qryPedido.fieldbyname('PCG_DTAENT').AsDateTime,True));

      If (qryConsulta.FieldByName('Espécie').AsString = 'PD') Then
      Begin
        TfrxMemoView(frxPagina.FindObject('rllObservacao')).Memo.Clear;
        TfrxMemoView(frxPagina.FindObject('rllObservacao')).Memo.Add('FAVOR CONFIRMAR O RECEBIMENTO NO PEDIDO - MENCIONAR O NÚMERO DO PEDIDO NA NOTA FISCAL.');

        TfrxMemoView(frxPagina.FindObject('rllPedOrc')).Memo.Clear;
        TfrxMemoView(frxPagina.FindObject('rllPedOrc')).Memo.Add('Pedido de Compra Nº: ' + strNumPed);

        TfrxBand(frxPagina.FindObject('Transportadora')).visible := True;
      End
      Else
      Begin
        TfrxMemoView(frxPagina.FindObject('rllObservacao')).Memo.Clear;
        TfrxMemoView(frxPagina.FindObject('rllObservacao')).Memo.Add('FAVOR CONFIRMAR O RECEBIMENTO NO ORÇAMENTO - MENCIONAR O NÚMERO DO ORÇAMENTO NA NOTA FISCAL.');

        TfrxMemoView(frxPagina.FindObject('rllPedOrc')).Memo.Clear;
        TfrxMemoView(frxPagina.FindObject('rllPedOrc')).Memo.Add('Orçamento Nº: ' + strNumPed);

        TfrxBand(frxPagina.FindObject('Transportadora')).visible := False;
      End;

      If blnSemPre Then
      Begin
        TfrxMemoView(frxPagina.FindObject('rllPrecoUnit')).Memo.Clear;
        TfrxMemoView(frxPagina.FindObject('rllPrecoUnit')).Memo.Add('-');

        TfrxMemoView(frxPagina.FindObject('rllPrecoTot')).Memo.Clear;
        TfrxMemoView(frxPagina.FindObject('rllPrecoTot')).Memo.Add('-');

        TfrxMemoView(frxPagina.FindObject('rllIpi')).Memo.Clear;
        TfrxMemoView(frxPagina.FindObject('rllIpi')).Memo.Add('-');

        TfrxMemoView(frxPagina.FindObject('rllVlIpi')).Memo.Clear;
        TfrxMemoView(frxPagina.FindObject('rllVlIpi')).Memo.Add('-');

        TfrxMemoView(frxPagina.FindObject('rllTotalItens')).Memo.Clear;
        TfrxMemoView(frxPagina.FindObject('rllTotalItens')).Memo.Add('-');

        TfrxMemoView(frxPagina.FindObject('rllTotalIpi')).Memo.Clear;
        TfrxMemoView(frxPagina.FindObject('rllTotalIpi')).Memo.Add('-');

        TfrxMemoView(frxPagina.FindObject('rllTotalGeral')).Memo.Clear;
        TfrxMemoView(frxPagina.FindObject('rllTotalGeral')).Memo.Add('-');
      End
      Else
      Begin
        TfrxMemoView(frxPagina.FindObject('rllPrecoUnit')).Memo.Clear;
        TfrxMemoView(frxPagina.FindObject('rllPrecoUnit')).Memo.Add('[frxRelatorio."PCD_UNITAR"]');

        TfrxMemoView(frxPagina.FindObject('rllPrecoTot')).Memo.Clear;
        TfrxMemoView(frxPagina.FindObject('rllPrecoTot')).Memo.Add('[frxRelatorio."PCD_TOTITE"]');

        TfrxMemoView(frxPagina.FindObject('rllIpi')).Memo.Clear;
        TfrxMemoView(frxPagina.FindObject('rllIpi')).Memo.Add('[frxRelatorio."PCD_PERIPI"]');

        TfrxMemoView(frxPagina.FindObject('rllVlIpi')).Memo.Clear;
        TfrxMemoView(frxPagina.FindObject('rllVlIpi')).Memo.Add('[frxRelatorio."PCD_TOTIPI"]');

        TfrxMemoView(frxPagina.FindObject('rllTotalItens')).Memo.Clear;
        TfrxMemoView(frxPagina.FindObject('rllTotalItens')).Memo.Add('[frxPedido."PCG_TOTITE"]');

        TfrxMemoView(frxPagina.FindObject('rllTotalIpi')).Memo.Clear;
        TfrxMemoView(frxPagina.FindObject('rllTotalIpi')).Memo.Add('[frxPedido."PCG_TOTIPI"]');

        TfrxMemoView(frxPagina.FindObject('rllTotalGeral')).Memo.Clear;
        TfrxMemoView(frxPagina.FindObject('rllTotalGeral')).Memo.Add('[frxPedido."PCG_TOTGER"]');
      End;

      {******************************}
      {* DEFINE O SUBTITULO         *}
      {***************************JB*}
      If SameText(strEspDoc, 'OR') Then
        frxPagina.Script.Variables['SUBTIT'] := 'Orcamento de Compra'
      Else
        frxPagina.Script.Variables['SUBTIT'] := 'Ordem de Compra';

      frxPagina.PrepareReport(True);
      If strTipExp = 'PDF' Then
      Begin
        frxExportaPDF.FileName    := strNomeArquivo;
        frxExportaPDF.DefaultPath := strExecutavel+'PedidoCompra';
        frxExportaPDF.ShowDialog  := False;
        frxPagina.Export(frxExportaPDF);
      End
      Else
      Begin
        frxExportaXLS.FileName    := strNomeArquivo;
        frxExportaXLS.DefaultPath := strExecutavel+'PedidoCompra';
        frxExportaXLS.ShowDialog  := False;
        frxPagina.Export(frxExportaXLS);
      End;
    End;

    {**************************}
    {* GERA O ANEXO NO EMAIL  *}
    {***********************LU*}
    strNomeArquivo := strExecutavel+'PedidoCompra\'+strNomeArquivo;
    Finally;
  End;
  frmQckHTMLPedidoCompra.qryRelatorio.Close;
  frmQckHTMLPedidoCompra.qryPedido.Close;
  frmQckHTMLPedidoCompra.qryEmpresa.Close;
  frmQckHTMLPedidoCompra.qryTransp.Close;
  pFreeAndNil(frmQckHTMLPedidoCompra);

end;

procedure TfrmConsultaPedidoCompra.pAtuIndice(intIndice: Integer);
begin
  inherited;
  pDesabilitaColunas;
  {*****************************************}
  {* RETORNA A CONEXÃO COM O GRID          *}
  {**************************************MV*}
  qryConsulta.EnableControls;
end;

procedure TfrmConsultaPedidoCompra.pDesabilitaColunas;
begin
//  qryConsulta.FieldByName('PCG_CODEMP').Visible := False;

  If qryConsulta.FieldDefList.Find('AUTOINCREM') <> Nil Then
    qryConsulta.FieldByName('AUTOINCREM').Visible := False;

  If (qryConsulta.FindField( 'Litragem' ) <> Nil) Then
     qryConsulta.FieldByName('Litragem').DisplayWidth := 19;

  If (qryConsulta.FindField( 'Doc. Orig.' ) <> Nil) Then
     qryConsulta.FieldByName('Doc. Orig.').DisplayWidth := 13;

  If (qryConsulta.FindField( 'Emp. Destino' ) <> Nil) Then
     qryConsulta.FieldByName('Emp. Destino').DisplayWidth := 10;

end;

procedure TfrmConsultaPedidoCompra.edtFiltro1Change(Sender: TObject);
  Var
    strSQL: String;
begin
  If (fPodeDigitar(TEdit(Sender).Text)) Then
  Begin
    strSQL := fMontaSQLPed;

    With qryConsulta Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;
      pAlinhaColunasNumericas;
    End;

  End;
  pDesabilitaColunas;
end;

function TfrmConsultaPedidoCompra.fMontaSQLPed: String;
  Var
    strSQL      : String;
    strSQLOrder : String;
    strOperador : String;
    strCampo    : String;
    strNomeCampo: String;
    strDesCampo : String;
    intQtdCampos: Integer;
    intIndCampo : Integer;
    blnFiltroBranco: Boolean;
    intTam      : Integer;
begin

  blnFiltroBranco := True;

  intQtdCampos := fContaCampos(lstConInd.Strings[lstIndices.ItemIndex]);
  intIndCampo  := lstIndices.ItemIndex;

  strSQL       := strSQLConsulta;
  strSQLOrder  := fRetOrderBy(lstConInd.Strings[lstIndices.ItemIndex]);
  strDesCampo  := lstConDes.Strings[lstIndices.ItemIndex];
  strNomeCampo := lstConInd.Strings[intIndCampo];

  intTam := length(strSQL);

  strSQL := copy(strSQL,1,intTam-46);

  Case intQtdCampos Of

    {*****************************************}
    {* MONTA CLÁUSULA WHERE PARA 1 PARAMETRO *}
    {**************************************MV*}
    1:Begin
        If (Not fEmptyStr(edtFiltro1.Text)) Then
        Begin
          strSQL      := strSQL + ' AND ';
          strOperador := fRetOperador(strDesCampo);
          If strOperador = 'LIKE' Then
            strSQL := strSQL + strNomeCampo + ' ' + strOperador + ' ' + QuotedStr(edtFiltro1.Text + '%')
          Else If strOperador = 'DATE' Then
            strSQL := strSQL + fAsDAte(strNomeCampo, edtFiltro1.Text)
          Else
            strSQL := strSQL + strNomeCampo + ' ' + strOperador + ' ' + edtFiltro1.Text;

          blnFiltroBranco := False;

        End;

      End;

    {*****************************************}
    {* MONTA CLÁUSULA WHERE PARA 2 PARAMETROS*}
    {**************************************MV*}
    2:Begin
        If (Trim(edtFiltro1.Text) <> '') Then
        Begin
          {******************************************}
          {* RETORNA A DESCRIÇÃO DO CAMPO, PARA SER *}
          {* USADO NA FUNÇAÕ 'fRetOperador'         *}
          {***************************************MV*}
          strCampo := AnsiReplaceStr(Copy(strDesCampo, 1, Pos('/', strDesCampo)-1), '/', '');
          strCampo := Trim(strCampo);
          strOperador := fRetOperador(strCampo);

          strCampo := AnsiReplaceStr(Copy(strNomeCampo, 1, Pos('+', strNomeCampo)-1), '+', '');

          strSQL := strSQL + ' AND ';
          If strOperador = 'LIKE' Then
            strSQL := strSQL + strCampo + ' ' + strOperador + ' ' + QuotedStr(edtFiltro1.Text + '%')
          Else If strOperador = 'DATE' Then
            strSQL := strSQL + fAsDate(strCampo, edtFiltro1.Text)
          Else
            strSQL := strSQL + strCampo + ' ' + strOperador + ' ' + edtFiltro1.Text;

          blnFiltroBranco := False;

        End;

        If (Trim(edtFiltro2.Text) <> '') Then
        Begin
          {******************************************}
          {* RETORNA A DESCRIÇÃO DO CAMPO, PARA SER *}
          {* USADO NA FUNÇAÕ 'fRetOperador'         *}
          {***************************************MV*}
          strCampo := AnsiReplaceStr(Copy(strDesCampo, Pos('/', strDesCampo), Length(strDesCampo)), '/', '');
          strCampo := Trim(strCampo);
          strOperador := fRetOperador(strCampo);

          strCampo := AnsiReplaceStr(Copy(strNomeCampo, Pos('+', strNomeCampo), Length(strNomeCampo)), '+', '');
          strSQL := strSQL + ' AND ';
          If strOperador = 'LIKE' Then
            strSQL := strSQL + strCampo + ' ' + strOperador + ' ' + QuotedStr(edtFiltro2.Text + '%')
          Else If strOperador = 'DATE' Then
            strSQL := strSQL + fAsDate(strCampo, edtFiltro2.Text)
          Else
            strSQL := strSQL + strCampo + ' ' + strOperador + ' ' + edtFiltro2.Text;

          blnFiltroBranco := False;

        End;
      End;

    {*****************************************}
    {* MONTA CLÁUSULA WHERE PARA 3 PARAMETROS*}
    {**************************************MV*}
    3:Begin

        If (Trim(edtFiltro1.Text) <> '') Then
        Begin
          strCampo := AnsiReplaceStr(Copy(strDesCampo, 1, Pos('/', strDesCampo)-1), '/', '');
          strCampo := Trim(strCampo);
          strOperador := fRetOperador(strCampo);

          strCampo := AnsiReplaceStr(Copy(strNomeCampo, 1, Pos('+', strNomeCampo)-1), '+', '');

          strSQL := strSQL + ' AND ';
          If strOperador = 'LIKE' Then
            strSQL := strSQL + strCampo + ' ' + strOperador + ' ' + QuotedStr(edtFiltro1.Text + '%')
          Else If strOperador = 'DATE' Then
            strSQL := strSQL + fAsDate(strCampo, edtFiltro1.Text)
          Else
            strSQL := strSQL + strCampo + ' ' + strOperador + ' ' + edtFiltro1.Text;

          blnFiltroBranco := False;

        End;
        Delete(strNomeCampo, 1, Pos('+', strNomeCampo));
        Delete(strDesCampo, 1, Pos('/', strDesCampo));

        If (Trim(edtFiltro2.Text) <> '') Then
        Begin
          strCampo := AnsiReplaceStr(Copy(strDesCampo, 1, Pos('/', strDesCampo)), '/', '');
          strCampo := Trim(strCampo);
          strOperador := fRetOperador(strCampo);

          strCampo := AnsiReplaceStr(Copy(strNomeCampo, 1, Pos('+', strNomeCampo)), '+', '');

          strSQL := strSQL + ' AND ';
          If strOperador = 'LIKE' Then
            strSQL := strSQL + strCampo + ' ' + strOperador + ' ' + QuotedStr(edtFiltro2.Text + '%')
          Else If strOperador = 'DATE' Then
            strSQL := strSQL + fAsDate(strCampo, edtFiltro2.Text)
          Else
            strSQL := strSQL + strCampo + ' ' + strOperador + ' ' + edtFiltro2.Text;

          blnFiltroBranco := False;

        End;
        Delete(strNomeCampo, 1, Pos('+', strNomeCampo));
        Delete(strDesCampo, 1, Pos('/', strDesCampo));

        If (edtFiltro3.Text <> '') Then
        Begin
          strSQL := strSQL + ' AND ';
          strDesCampo := Trim(strDesCampo);
          strOperador := fRetOperador(strDesCampo);

          strCampo := strNomeCampo;
          If strOperador = 'LIKE' Then
            strSQL := strSQL + strCampo + ' ' + strOperador + ' ' + QuotedStr(edtFiltro3.Text + '%')
          Else If strOperador = 'DATE' Then
            strSQL := strSQL + fAsDate(strCampo, edtFiltro3.Text)
          Else
            strSQL := strSQL + strCampo + ' ' + strOperador + ' ' + edtFiltro3.Text;

          blnFiltroBranco := False;

        End;
      End;

  End;

  strSQL := strSQL + ' GROUP BY PCG_NUMPED, PCG_ESPDOC, PCG_CODEMP ';

  If (Pos('ORDER BY', strOrderOpc) > 0) Then
  Begin
    strSQL := strSQL + ' ' + strOrderOpc;
    strSQLOrder := '';
  End
  Else
  Begin
    strSQL := strSQL + ' ORDER BY ' + strSQLOrder + strOrderOpc;
  End;

  If (Not blnMostraTudo) And (blnFiltroBranco) Then
    strSQL := strSQL + ' LIMIT 0 ';

  Result := strSQL;

end;

function TfrmConsultaPedidoCompra.fMontaSQL: String;
begin
  Result := fMontaSQLPed;
end;

procedure TfrmConsultaPedidoCompra.btnBaixaPedidoClick(Sender: TObject);
begin
  inherited;
  
  If Not qryConsulta.IsEmpty Then
  Begin
    pBaixaPedidoCompraNaoEntregues;
  End;

end;

procedure TfrmConsultaPedidoCompra.pBaixaPedidoCompraNaoEntregues;
  Var
    strMotivo,
    strCodEmp,
    strEspDoc: String;
begin

  strMotivo := InputBox('Favor Digitar o Motivo da Baixa','Motivo : ','');

  If fEmptyStr(strMotivo) Then
    Exit;

  strCodEmp := qryConsulta.FieldByName('Emp.').AsString;
  strEspDoc := qryConsulta.FieldByName('Espécie').AsString;

  fStartTransaction;

  If Not fUpdatePCMGER(strMotivo) Then
    Exit;

  If Not fUpdatePCMDET Then
    Exit;

  fCommit;

  pRefazConsulta(strCodEmp, strEspDoc);  

  fMensagem('Informação','Pedido Baixado com sucesso !',['&OK']);

end;

function TfrmConsultaPedidoCompra.fUpdatePCMGER(strMotivo: String): Boolean;
  Var
    qryUpdate: TUniQuery;
begin

  Result := True;

  Try

    qryUpdate := fCriaQuery;

    With qryUpdate Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' UPDATE PCMGER ');
      SQL.Add('    SET PCG_MOTBAI = ' + QuotedStr(strMotivo) + ', ');
      SQL.Add('        PCG_BAIXAD = 1 ');
      SQL.Add('  WHERE PCG_NUMPED = ' + QuotedStr(qryConsulta.FieldByName('Pedido').AsString));
      SQL.Add('    AND PCG_CODEMP = ' + QuotedStr(qryConsulta.FieldByName('Emp.').AsString));
      SQL.Add('    AND PCG_ESPDOC = ' + QuotedStr(qryConsulta.FieldByName('Espécie').AsString));
      SQL.Add('    AND PCG_NUMCTN = 0 ');
      SQL.Add('    AND (PCG_BAIXAD = FALSE OR PCG_BAIXAD IS NULL) ');
      ExecSQL;
    End;

    FreeAndNil(qryUpdate);

  Except
    On E: Exception Do
    Begin
      fRollBack;
      FreeAndNil(qryUpdate);
      fMensagem('[ fUpdatePCMGER ]', E.Message, ['&Ok']);
      Result := False;
    End;
  End;

end;

function TfrmConsultaPedidoCompra.fUpdatePCMDET: Boolean;
  Var
    qryUpdate: TUniQuery;
begin

  Result := True;

  Try

    qryUpdate := fCriaQuery;

    With qryUpdate Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' UPDATE PCMDET ');
      SQL.Add('    SET PCD_ENTREG = "N", ');
      SQL.Add('        PCD_BAIXAD = 1    ');
      SQL.Add('  WHERE PCD_NUMPED = ' + QuotedStr(qryConsulta.FieldByName('Pedido').AsString));
      SQL.Add('    AND PCD_CODEMP = ' + QuotedStr(qryConsulta.FieldByName('Emp.').AsString));
      SQL.Add('    AND PCD_ESPDOC = ' + QuotedStr(qryConsulta.FieldByName('Espécie').AsString));
      SQL.Add('    AND PCD_NUMCTN = 0 ');
      SQL.Add('    AND (PCD_BAIXAD = FALSE OR PCD_BAIXAD IS NULL) ');
      ExecSQL;
    End;

    FreeAndNil(qryUpdate);

  Except
    On E: Exception Do
    Begin
      fRollBack;
      FreeAndNil(qryUpdate);
      fMensagem('[ fUpdatePCMDET ]', E.Message, ['&Ok']);
      Result := False;
    End;
  End;

end;

procedure TfrmConsultaPedidoCompra.FormShow(Sender: TObject);
begin
  inherited;

  If strEspecie <> 'PD' Then
    btnBaixaPedido.Visible := False;

end;

procedure TfrmConsultaPedidoCompra.pRefazConsulta(strCodEmp, strEspDoc: String);
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  PCG_NUMPED AS "Pedido", ';
  strSQL := strSQL + '  PCG_CODEMP AS "Emp.", ';
  strSQL := strSQL + '  PCG_ESPDOC AS "Espécie", ';
  strSQL := strSQL + '  PCG_CODFOR AS "Cód. Forn.", ';
  strSQL := strSQL + '  FOR_NOMFOR AS "Fornecedor", ';
  strSQL := strSQL + '  PCG_DTAENT AS "Dta. Ped.", ';
  strSQL := strSQL + '  PCG_DTAPED AS "Dta. Entrega", ';
  strSQL := strSQL + '  PCG_CONPAG AS "Cond. Pagto.", ';
  strSQL := strSQL + '  FORMAT(PCG_TOTITE, 2) AS "Total Itens", ';
  strSQL := strSQL + '  FORMAT(PCG_TOTIPI, 2) AS "Total IPI", ';
  strSQL := strSQL + '  FORMAT(PCG_TOTSUB, 2) AS "Total SUB", ';
  strSQL := strSQL + '  FORMAT(PCG_TOTGER, 2) AS "Total Pedido", ';
  strSQL := strSQL + '  PCMGER.AUTOINCREM AS "AUTOINCREM", ';
  strSQL := strSQL + '  FORMAT(SUM((PCD_QTDITE * ';
  strSQL := strSQL + '      (SELECT UNI_PESLIT ';
  strSQL := strSQL + '       FROM CADUNI ';
  strSQL := strSQL + '       JOIN CADITE ON (UNI_CODUNI=ITE_CODUNI) ';
  strSQL := strSQL + '       WHERE ITE_CODITE = PCD_CODITE))),2) AS "Litragem", ';
  strSQL := strSQL + '  PCG_DOCORI AS "Doc. Orig.", ';
  strSQL := strSQL + '  IF(PCG_EMPDES IS NULL, "", PCG_EMPDES) AS "Emp. Destino" ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  PCMGER, ';
  strSQL := strSQL + '  CADFOR, ';
  strSQL := strSQL + '  PCMDET ';
  strSQL := strSQL + 'WHERE ';

  If strEspDoc = 'PD' Then
    strSQL    := strSQL + '  PCG_ESPDOC = "PD" '
  Else
    strSQL    := strSQL + '  PCG_ESPDOC = "OR" ';

  strSQL := strSQL + '  AND PCG_CODEMP  = ' + QuotedStr(strCodEmp) + ' ';  
  strSQL := strSQL + '  AND PCG_NUMCTN = 0 ';
  strSQL := strSQL + '  AND FOR_CODFOR = PCG_CODFOR ';
  strSQL := strSQL + '  AND PCG_NUMPED = PCD_NUMPED ';
  strSQL := strSQL + '  AND (PCG_BAIXAD = FALSE OR PCG_BAIXAD IS NULL) ';

  strSQL := strSQL + '  GROUP BY PCG_NUMPED, PCG_ESPDOC, PCG_CODEMP ';

  pSelect(strSQL);  

end;

procedure TfrmConsultaPedidoCompra.pSelect(strSQL: String);
begin

  With qryConsulta Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;

    //pEscondeAutoIncremento(qryConsulta);
    pAlinhaColunasNumericas;
  End;

end;

end.




