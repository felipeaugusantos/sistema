unit untConsultaPedidoCompra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untConsultaComp, DB,  
  Uni, ExtCtrls, StdCtrls, ComCtrls, Buttons, Grids, DBGridCitel, DBGrids, Mapi, frxClass, StrUtils,
  Mask, DBCtrls, untConstantes, untFuncoesGenerica, MemDS, DBAccess,
  BitBtnLockedIncrem;

type
  TfrmConsultaPedidoCompra = class(TfrmConsultaComp)
    Panel2: TPanel;
    btnEnviarEmail: TBitBtn;
    btnBaixaPedido: TBitBtn;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    dbeDtaMai: TDBEdit;
    dbeHorMai: TDBEdit;
    dbeOpeMai: TDBEdit;
    dbeDesMai: TDBEdit;
    btnItensPend: TBitBtn;
    btnGerPDF: TBitBtn;
    btnGerXLS: TBitBtn;
    lbl1: TLabel;
    dbeNomMai: TDBEdit;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnEnviarEmailClick(Sender: TObject);
    procedure edtFiltro1Change(Sender: TObject);

    function  fGeraEmail(strNumPed, strEspDoc, strEmpDes: String;
      blnQtdPendente: Boolean): String;
    procedure btnBaixaPedidoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnItensPendClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnGerPDFClick(Sender: TObject);
    procedure btnGerXLSClick(Sender: TObject);
    procedure qryConsultaAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);

  private
    FPais: TPais;
    procedure pDesabilitaColunas;

    Function fTestaPdf: Boolean;
    function EnviarEMail(const De, Para, Assunto, Texto,
                         Arquivo: string; Confirma: Boolean): Integer;

    procedure pBaixaPedidoCompraNaoEntregues;
    procedure pRefazConsulta(strCodEmp, strEspDoc: String);
    procedure pSelect(strSQL: String);
    function fUpdatePCMGER(strMotivo: String): Boolean;
    function fUpdatePCMDET: Boolean;
    procedure pGravarLogEmail(strEmailDest, strDestinatario: String);

    procedure pMostraItensPendentes;

  protected
    procedure pAtuIndice(intIndice: Integer); override;
    function fPodeDigitar(strTexto: String): Boolean;
    function fMontaSQLPed: String; overload;
    function fMontaSQL: String; override;

  public
    { Public declarations }
    blnSemPre : Boolean;
    blnComMar : Boolean;
    blnCodFab : Boolean;
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

uses untfuncoesSimples, untDigEmail, untPesqAux,
  untDigEmailPedidoCompra, untQckHTMLPedidoCompra, untmodulo,
  untMostraItensPendentes, untConsulta, untExcel, untDigPDFPedidoCompra,
  untValorPorExtenso;

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
        lpszSubject := PAnsiChar(Assunto);
       if (Texto <> '') then
        lpszNoteText := PAnsiChar(Texto);

      // remetente
      if (De <> '') then
        begin
          lpSender.ulRecipClass := MAPI_ORIG;
          lpSender.lpszName     := PAnsiChar(AnsiLowerCase(De));
          lpSender.lpszAddress  := PAnsiChar(AnsiLowerCase(De));
          lpSender.ulReserved   := 0;
          lpSender.ulEIDSize    := 0;
          lpSender.lpEntryID    := nil;
          lpOriginator          := @lpSender;
        end;

      // destinatário
      if (Para <> '') then
        begin
          lpRecepient.ulRecipClass := MAPI_TO;
          lpRecepient.lpszName     := PAnsiChar(AnsiLowerCase(Para));
          lpRecepient.lpszAddress  := PAnsiChar('SMTP:' + AnsiLowerCase(Para));
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
          FileAttach.lpszPathName := PAnsiChar(Arquivo);
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
        Result := SM(0, VS_APPLICATION_HANDLE, Msg, Flags, 0)
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
  Case Key Of
    VK_F7 : btnGerXLS.Click;
    VK_F8 : btnGerPDF.Click;
    VK_F9 : btnEnviarEmail.Click;
    VK_F10: If (btnBaixaPedido.Visible) Then
              btnBaixaPedido.Click;
    VK_F11: btnItensPend.Click;
  End;
end;

Function TfrmConsultaPedidoCompra.fTestaPdf: Boolean;
Begin
  Result := True;
  If (fCfgSis('LIBPCM', varBoolean))                      And
     (qryConsulta.FieldByName('Espécie').AsString = 'PD') And
     (Not fPedidoCompraLiberado(qryConsulta.FieldByName('Pedido').AsString, VS_strCodEmp)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Esse Pedido ainda não foi liberado (Liberação de Pedidos de Compra)!', ['&Ok']);
    Result := False;
    Exit;
  End;
End;

procedure TfrmConsultaPedidoCompra.btnEnviarEmailClick(Sender: TObject);
  Var
    strArqHtml : String;
    strAssunto : String;
    strTexto   : String;
    blnConfirma: Boolean;
    qryGenFor  : TUniQuery;

    strDestinatario     : String;
    strEmailDestinatario: String;
    bkmRegAtu: TBookmark;
    blnQtdPendente: Boolean;

begin
  inherited;

  If Not fTestaPdf Then
    Exit;

  qryGenFor   := fCriaQuery(Self);

  Try
    pCriarFormularios(TfrmDigEmailPedidoCompra, frmDigEmailPedidoCompra);
    {*********************************************}
    {* CARREGA O EMAIL E O CONTATO DO FORNECEDOR *}
    {******************************************JB*}
    pPesquisaCadFor(Nil, qryGenFor, qryConsulta.FieldByName('Cód. Forn.').AsString);
    frmDigEmailPedidoCompra.edtEmail.Text   := qryGenFor.FieldByName('FOR_EMAPED').AsString;
    frmDigEmailPedidoCompra.edtContato.Text := qryGenFor.FieldByName('FOR_CONTAT').AsString;
    blnConfirma := (frmDigEmailPedidoCompra.ShowModal = mrOk);

    If (blnConfirma) Then
    Begin
      strDestinatario      := frmDigEmailPedidoCompra.edtContato.Text;
      strEmailDestinatario := frmDigEmailPedidoCompra.edtEmail.Text;
      blnSemPre            := frmDigEmailPedidoCompra.blnSemPre;
      blnComMar            := frmDigEmailPedidoCompra.chkMarca.Checked;
      blnCodFab            := frmDigEmailPedidoCompra.chkCodFab.Checked;
      blnOrdDig            := frmDigEmailPedidoCompra.blnOrdDig;
      strTipExp            := frmDigEmailPedidoCompra.strTipExp;
    End;

  Except
    On E: Exception Do
    Begin
      blnConfirma := False;
      pMensagensErro(E.Message, '[frmConsultaPedidoCompra.btnEnviarEmailClick]');
    End;
  End;

  pFreeAndNil(frmDigEmailPedidoCompra);

  FreeAndNil(qryGenFor);

  If (Not blnConfirma) Then
  Begin
    Exit;
  End;

  blnQtdPendente := (fMensagem('ATENÇÃO!', 'Exibir quantidade:', ['&Total', '&Pendente']) = 2);

  strArqHtml := fGeraEmail(qryConsulta.FieldByName('Pedido').AsString,
                           qryConsulta.FieldByName('Espécie').AsString,
                           qryConsulta.FieldByName('Emp.Dest.').AsString,
                           blnQtdPendente);

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

    If EnviarEMail('', strEmailDestinatario, strAssunto , strTexto, strNomeArquivo, True) = SUCCESS_SUCCESS Then
    Begin
      pGravarLogEmail(strEmailDestinatario, strDestinatario);

      bkmRegAtu := qryConsulta.GetBookmark;
      edtFiltro1Change(edtFiltro1);
      Try
        qryConsulta.GotoBookmark(bkmRegAtu);
      Except
        //
      End;
    End;
    SetForegroundWindow(Handle);
  End
  Else
    fMensagem('ATENÇÃO!', 'Não foi possível exportar o arquivo PDF !', ['&Ok']);

end;

function TfrmConsultaPedidoCompra.fGeraEmail(strNumPed, strEspDoc, strEmpDes: String;
  blnQtdPendente: Boolean): String;
  Var
    strSQL         : String;
    strExecutavel  : String;
    strDirImagem   : String;
    strSQLQtd      : String;
    strDirGravacao : String;
begin

  If blnQtdPendente Then
    strSQLQtd := ' (PCMDET.PCD_QTDITE - PCMDET.PCD_QTDBAI) '
  Else
    strSQLQtd := ' PCMDET.PCD_QTDITE ';

  Try
    pCriarFormularios(TfrmQckHTMLPedidoCompra, frmQckHTMLPedidoCompra);
    frmQckHTMLPedidoCompra.qryRelatorio.Connection := frmModulo.Database;
    frmQckHTMLPedidoCompra.qryPedido.Connection := frmModulo.Database;
    frmQckHTMLPedidoCompra.qryEmpresa.Connection := frmModulo.Database;
    frmQckHTMLPedidoCompra.qryTransp.Connection := frmModulo.Database;

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
      strSQL := strSQL + '  ITEGER.ITE_QTDETI, ';
      strSQL := strSQL + '  CADMAR.MAR_DESMAR, ';
      strSQL := strSQL + '  CADUNI.UNI_SIGUNI, ';
      strSQL := strSQL + '  (' + strSQLQtd + ' * UNI_PESLIT / :LITGAL) AS LITROS, ';
      strSQL := strSQL + '  '  + strSQLQtd + ' AS QTDITE, ';
      If (blnQtdPendente) Then
      Begin
        strSQL := strSQL + '  PCMDET.PCD_TOTITE - PCMDET.PCD_TOTBAI AS TOTITE, ';
        strSQL := strSQL + '  PCMDET.PCD_TOTIPI - PCMDET.PCD_IPIBAI AS TOTIPI, ';
        strSQL := strSQL + '  PCMDET.PCD_TOTSUB - PCMDET.PCD_SUBBAI AS TOTSUB, ';
      End
      Else
      Begin
        strSQL := strSQL + '  PCMDET.PCD_TOTITE AS TOTITE, ';
        strSQL := strSQL + '  PCMDET.PCD_TOTIPI AS TOTIPI, ';
        strSQL := strSQL + '  PCMDET.PCD_TOTSUB AS TOTSUB, ';
      End;
      strSQL := strSQL + '  (' + strSQLQtd + ' * CADITE.ITE_PESOIT) AS PESOIT ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  PCMDET ';
      strSQL := strSQL + '  JOIN CADITE ON (PCMDET.PCD_CODITE = CADITE.ITE_CODITE ) ';
      strSQL := strSQL + '  JOIN ITEGER ON CADITE.ITE_CODITE = ITEGER.ITE_CODITE AND ';
      strSQL := strSQL + '                 ITEGER.ITE_CODEMP = :CODEMP               ';
      strSQL := strSQL + '  LEFT JOIN CADUNI ON (PCMDET.PCD_CODUNI = CADUNI.UNI_CODUNI) ';
      strSQL := strSQL + '  LEFT JOIN CADMAR ON (CADITE.ITE_CODMAR = CADMAR.MAR_CODMAR) ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  PCMDET.PCD_NUMCTN = 0 AND ';
      strSQL := strSQL + '  PCMDET.PCD_NUMPED = :NUMPED AND ';
      strSQL := strSQL + '  PCMDET.PCD_ESPDOC = :ESPDOC AND ';
      strSQL := strSQL + '  PCMDET.PCD_CODEMP = :CODEMP ';

      If blnQtdPendente Then
        strSQL := strSQL + '  AND ' + strSQLQtd + ' > 0 ';

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

        If Params.FindParam('LITGAL') <> Nil Then
        Begin
          If SameText(fCfgSis('LITGAL'), 'L') Then
            ParamByName('LITGAL').AsFloat := 1
          Else
            ParamByName('LITGAL').AsFloat := FLT_LITRO_GALAO;
        End;

        ParamByName('NUMPED').AsString := strNumPed;
        ParamByName('ESPDOC').AsString := strEspDoc;
        If fEmptyStr(strCodEmp) Then
          ParamByName('CODEMP').AsString := VS_strCodEmp
        Else
          ParamByName('CODEMP').AsString := strCodEmp;

        Open;

        TFloatField(FieldByName('PCD_QTDITE')).DisplayFormat := fMskDigitos(fCfgSis('DEQTPC', varInteger));
        TFloatField(FieldByName('PCD_UNITAR')).DisplayFormat := '#,###0.000';
        TFloatField(FieldByName('PCD_TOTITE')).DisplayFormat := '#,###0.000';
        TFloatField(FieldByName('PCD_PERIPI')).DisplayFormat := '#,####0.0000';
        TFloatField(FieldByName('PCD_TOTIPI')).DisplayFormat := '#,##0.00';
        TFloatField(FieldByName('PCD_PERSUB')).DisplayFormat := '#,####0.0000';
        TFloatField(FieldByName('PCD_TOTSUB')).DisplayFormat := '#,##0.00';
      End;
      {**************************************}
      {* CARREGANDO OS DADOS DA EMPRESA     *}
      {***********************************LU*}
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  CADEMP.EMP_CODEMP, ';
      strSQL := strSQL + '  CADEMP.EMP_NOMEMP,';
      strSQL := strSQL + '  CONCAT(CADEMP.EMP_ENDERE, ", ", IFNULL(CADEMP.EMP_ENDNUM,""),IF(IFNULL(EMP_ENDCMP, "") = "", "", CONCAT("  ", EMP_ENDCMP))) AS EMP_ENDERE, ';
      strSQL := strSQL + '  CONCAT(CADCID.CID_NOMCID, " - ", CADCID.CID_ESTADO) AS EMP_NOMCID,';
      strSQL := strSQL + '  CADEMP.EMP_BAIRRO,';
      strSQL := strSQL + '  CADEMP.EMP_C_E_P_,';
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
      If FileExists(fCfgSis('PATLOG')) Then
        strDirImagem := fCfgSis('PATLOG')
      Else
        strDirImagem := '';

    End;

    {*******************************************}
    {* PEGA O ENDEREÇO CORRENTE DO EXECUTÁVEL  *}
    {****************************************LU*}
    strExecutavel := ExtractFilePath(Application.ExeName);

    If (qryConsulta.FieldByName('Espécie').AsString = 'PD') Then
    Begin
      {*******************************************}
      {* SE NÃO EXISTIR O DIRETÓRIO ELE CRIA     *}
      {****************************************LU*}
      If Not DirectoryExists(strExecutavel + 'PedidoCompra') Then
      Begin
        CreateDir(strExecutavel + 'PedidoCompra');
      End;
      strDirGravacao := strExecutavel + 'PedidoCompra';
    End
    Else
    Begin
      If Not DirectoryExists(strExecutavel + 'OrcamentoCompra') Then
      Begin
        CreateDir(strExecutavel + 'OrcamentoCompra');
      End;
      strDirGravacao := strExecutavel + 'OrcamentoCompra';
    End;

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

      frxPagina.Script.Variables['MSGPCM'] := fCfgSis('MSGPCM');    

      If fEmptyStr(strDirImagem) Then
        TfrxPictureView(frxPagina.FindObject('rllImagem')).Clear
      Else
        TfrxPictureView(frxPagina.FindObject('rllImagem')).Picture.LoadFromFile(strDirImagem);

      TfrxMemoView(frxPagina.FindObject('rllData')).Memo.Clear;
      TfrxMemoView(frxPagina.FindObject('rllData')).Memo.Add(fRetDataExtenso(qryPedido.fieldbyname('PCG_DTAPED').AsDateTime,True));

      If (qryConsulta.FieldByName('Espécie').AsString = 'PD') Then
      Begin
        TfrxMemoView(frxPagina.FindObject('rllObservacao')).Memo.Clear;
        TfrxMemoView(frxPagina.FindObject('rllObservacao')).Memo.Add('FAVOR CONFIRMAR O RECEBIMENTO NO PEDIDO - MENCIONAR O NÚMERO DO PEDIDO NA NOTA FISCAL.');

        TfrxMemoView(frxPagina.FindObject('rllPedOrc')).Memo.Clear;
        TfrxMemoView(frxPagina.FindObject('rllPedOrc')).Memo.Add('Pedido de Compra Nº: ' + strNumPed);

        TfrxMemoView(frxPagina.FindObject('rllTituloPedOrc')).Memo.Clear;
        TfrxMemoView(frxPagina.FindObject('rllTituloPedOrc')).Memo.Add('Pedido de Compra');

        TfrxBand(frxPagina.FindObject('Transportadora')).visible := True;
      End
      Else
      Begin
        TfrxMemoView(frxPagina.FindObject('rllObservacao')).Memo.Clear;
        TfrxMemoView(frxPagina.FindObject('rllObservacao')).Memo.Add('FAVOR CONFIRMAR O RECEBIMENTO NO ORÇAMENTO - MENCIONAR O NÚMERO DO ORÇAMENTO NA NOTA FISCAL.');

        TfrxMemoView(frxPagina.FindObject('rllPedOrc')).Memo.Clear;
        TfrxMemoView(frxPagina.FindObject('rllPedOrc')).Memo.Add('Orçamento Nº: ' + strNumPed);

        TfrxMemoView(frxPagina.FindObject('rllTituloPedOrc')).Memo.Clear;
        TfrxMemoView(frxPagina.FindObject('rllTituloPedOrc')).Memo.Add('Orçamento');

        TfrxBand(frxPagina.FindObject('Transportadora')).visible := True;
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

        TfrxMemoView(frxPagina.FindObject('rllTotalSub')).Memo.Clear;
        TfrxMemoView(frxPagina.FindObject('rllTotalSub')).Memo.Add('-');

        TfrxMemoView(frxPagina.FindObject('rllTotalGeral')).Memo.Clear;
        TfrxMemoView(frxPagina.FindObject('rllTotalGeral')).Memo.Add('-');
      End
      Else
      Begin
        TfrxMemoView(frxPagina.FindObject('rllPrecoUnit')).Memo.Clear;
        TfrxMemoView(frxPagina.FindObject('rllPrecoUnit')).Memo.Add('[frxRelatorio."PCD_UNITAR"]');

        TfrxMemoView(frxPagina.FindObject('rllPrecoTot')).Memo.Clear;
        TfrxMemoView(frxPagina.FindObject('rllPrecoTot')).Memo.Add('[frxRelatorio."TOTITE"]');

        TfrxMemoView(frxPagina.FindObject('rllIpi')).Memo.Clear;
        TfrxMemoView(frxPagina.FindObject('rllIpi')).Memo.Add('[frxRelatorio."PCD_PERIPI"]');

        TfrxMemoView(frxPagina.FindObject('rllVlIpi')).Memo.Clear;
        TfrxMemoView(frxPagina.FindObject('rllVlIpi')).Memo.Add('[frxRelatorio."TOTIPI"]');

        TfrxMemoView(frxPagina.FindObject('rllTotalItens')).Memo.Clear;
        TfrxMemoView(frxPagina.FindObject('rllTotalItens')).Memo.Add('[SUM(<frxRelatorio."TOTITE">)]');

        TfrxMemoView(frxPagina.FindObject('rllTotalIpi')).Memo.Clear;
        TfrxMemoView(frxPagina.FindObject('rllTotalIpi')).Memo.Add('[SUM(<frxRelatorio."TOTIPI">)]');

        TfrxMemoView(frxPagina.FindObject('rllTotalSub')).Memo.Clear;
        TfrxMemoView(frxPagina.FindObject('rllTotalSub')).Memo.Add('[SUM(<frxRelatorio."TOTSUB">)]');

        TfrxMemoView(frxPagina.FindObject('rllTotalGeral')).Memo.Clear;
        TfrxMemoView(frxPagina.FindObject('rllTotalGeral')).Memo.Add('[SUM(<frxRelatorio."TOTITE"> +<frxRelatorio."TOTIPI"> + <frxRelatorio."TOTSUB"> ,Detalhes,2) + <frxPedido."PCG_VALFRE"> + <frxPedido."PCG_DESACE">]');
      End;

      TfrxLineView(frxPagina.FindObject('linMarca')).Visible  := blnComMar;
      TfrxMemoView(frxPagina.FindObject('mmoDesMar')).Visible := blnComMar;
      TfrxMemoView(frxPagina.FindObject('mmoMarca')).Visible  := blnComMar;

      TfrxLineView(frxPagina.FindObject('linCodFab')).Visible     := blnCodFab;
      TfrxMemoView(frxPagina.FindObject('mmoCodFab')).Visible     := blnCodFab;
      TfrxMemoView(frxPagina.FindObject('mmoCodFabrica')).Visible := blnCodFab;

      If Not blnComMar Then
      Begin
        TfrxMemoView(frxPagina.FindObject('mmoDescri')).Width := TfrxMemoView(frxPagina.FindObject('mmoDescri')).Width + TfrxMemoView(frxPagina.FindObject('mmoDesMar')).Width;
      End;

      If (blnComMar) And (Not blnCodFab) Then
      Begin
        TfrxLineView(frxPagina.FindObject('linMarca')).Left  := 400;
        TfrxMemoView(frxPagina.FindObject('mmoDesMar')).Left := 400;
        TfrxMemoView(frxPagina.FindObject('mmoMarca')).Left  := 400;

        TfrxMemoView(frxPagina.FindObject('mmoDescri')).Width := TfrxMemoView(frxPagina.FindObject('mmoDescri')).Width +
                                                                 TfrxMemoView(frxPagina.FindObject('mmoCodFabrica')).Width;
      End;

      If (Not blnComMar) And (Not blnCodFab) Then
      Begin
        TfrxMemoView(frxPagina.FindObject('mmoDescri')).Width := TfrxMemoView(frxPagina.FindObject('mmoDescri')).Width +
                                                                 TfrxMemoView(frxPagina.FindObject('mmoCodFabrica')).Width;
      End;

      frxPagina.PrepareReport(True);
      If strTipExp = 'PDF' Then
      Begin
        frxExportaPDF.FileName    := strNomeArquivo;
        frxExportaPDF.DefaultPath := strDirGravacao;
        frxExportaPDF.ShowDialog  := False;
        frxPagina.Export(frxExportaPDF);
      End
      Else
      Begin
        frxExportaXLS.FileName    := strNomeArquivo;
        frxExportaXLS.DefaultPath := strDirGravacao;
        frxExportaXLS.ShowDialog  := False;
        frxPagina.Export(frxExportaXLS);
      End;
    End;

    {**************************}
    {* GERA O ANEXO NO EMAIL  *}
    {***********************LU*}
    strNomeArquivo := strDirGravacao + '\' + strNomeArquivo;

    Result := strNomeArquivo;
    
    frmQckHTMLPedidoCompra.qryRelatorio.Close;
    frmQckHTMLPedidoCompra.qryPedido.Close;
    frmQckHTMLPedidoCompra.qryEmpresa.Close;
    frmQckHTMLPedidoCompra.qryTransp.Close;

  Except
    On E: Exception Do
    Begin
      Result := '';
      ShowMessage(E.Message);
      pMensagensErro(E.Message, '[frmConsultaPedidoCompra.fGeraEmail]');
    End;
  End;

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

  If (qryConsulta.FindField( 'Emp.Dest.' ) <> Nil) Then
     qryConsulta.FieldByName('Emp.Dest.').DisplayWidth := 10;

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
    intRecNo: Integer;
begin

  strMotivo := InputBox('Favor Digitar o Motivo da Baixa','Motivo : ','');

  If fEmptyStr(strMotivo) Then
    Exit;

  strCodEmp := qryConsulta.FieldByName('Emp.Ori.').AsString;
  strEspDoc := qryConsulta.FieldByName('Espécie').AsString;

  fStartTransaction;

  If Not fUpdatePCMGER(strMotivo) Then
    Exit;

  If Not fUpdatePCMDET Then
    Exit;

  fCommit;

  intRecNo := qryConsulta.RecNo;
  pRefazConsulta(strCodEmp, strEspDoc);  

  If intRecNo > qryConsulta.RecordCount Then
    qryConsulta.Last
  Else
    qryConsulta.RecNo := intRecNo;
    
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
      SQL.Add('    AND PCG_CODEMP = ' + QuotedStr(qryConsulta.FieldByName('Emp.Ori.').AsString));
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
			pMensagensErro(E.Message,'[TfrmConsultaPedidoCompra.fUpdatePCMGER]');
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
      SQL.Add('    AND PCD_CODEMP = ' + QuotedStr(qryConsulta.FieldByName('Emp.Ori.').AsString));
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
			pMensagensErro(E.Message,'[TfrmConsultaPedidoCompra.fUpdatePCMDET]');
      Result := False;
    End;
  End;

end;

procedure TfrmConsultaPedidoCompra.FormShow(Sender: TObject);
begin
  inherited;

  If strEspecie <> 'PD' Then
  Begin
    btnBaixaPedido.Visible := False;
    btnGerXLS.Visible      := False;
  End;

end;

procedure TfrmConsultaPedidoCompra.pRefazConsulta(strCodEmp, strEspDoc: String);
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  PCG_NUMPED AS "Pedido", ';
  strSQL := strSQL + '  PCG_CODEMP AS "Emp.Ori.", ';
  strSQL := strSQL + '  IF(PCG_EMPDES IS NULL, "", PCG_EMPDES) AS "Emp.Dest.", ';
  strSQL := strSQL + '  PCG_ESPDOC AS "Espécie", ';
  strSQL := strSQL + '  PCG_CODFOR AS "Cód. Forn.", ';
  strSQL := strSQL + '  FOR_NOMFOR AS "Fornecedor", ';
  strSQL := strSQL + '  PCG_DTAPED AS "Dta. Ped.", ';
  strSQL := strSQL + '  PCG_DTAENT AS "Dta. Entrega", ';
  strSQL := strSQL + '  PCG_CONPAG AS "Cond. Pagto.", ';
  strSQL := strSQL + '  IF(SUM(PCD_QTDBAI) <= 0, "NÃO RECEB.", "RECEB. PARC.") AS "Status", ';
  strSQL := strSQL + '  FORMAT(PCG_TOTITE, 2) AS "Total Itens", ';
  strSQL := strSQL + '  FORMAT(PCG_TOTIPI, 2) AS "Total IPI", ';
  strSQL := strSQL + '  FORMAT(PCG_TOTSUB, 2) AS "Total SUB", ';
  strSQL := strSQL + '  FORMAT(IF(PCG_VALFRE IS NULL OR PCG_VALFRE = "", 0.00, PCG_VALFRE), 2) AS "Total Frete", ';
  strSQL := strSQL + '  FORMAT(PCG_TOTGER, 2) AS "Total Pedido", ';
  strSQL := strSQL + '  PCMGER.AUTOINCREM AS "AUTOINCREM", ';
  strSQL := strSQL + '  FORMAT(SUM(PCD_QTDITE * ';

  If SameText(fCfgSis('LITGAL'), 'L') Then
    strSQL := strSQL + '  (SELECT UNI_PESLIT FROM CADUNI WHERE UNI_CODUNI = PCD_CODUNI)),2) AS "Litragem", '
  Else
    strSQL := strSQL + '  (SELECT UNI_PESLIT / ' + STR_LITRO_GALAO + ' FROM CADUNI WHERE UNI_CODUNI=PCD_CODUNI)),2) AS "Galonagem", ';

  strSQL := strSQL + '  PCG_DOCORI AS "Doc. Orig.", ';
  strSQL := strSQL + '  PCG_DTAMAI, ';
  strSQL := strSQL + '  PCG_HORMAI, ';
  strSQL := strSQL + '  CONCAT(PCG_OPEMAI, "-", OPE_NOMOPE) AS PCG_OPEMAI, ';
  strSQL := strSQL + '  PCG_DESMAI, ';
  strSQL := strSQL + '  PCG_NOMMAI, ';
  strSQL := strSQL + '  PCG_DIACOM, ';
  strSQL := strSQL + '  PCG_DIANVA, ';
  strSQL := strSQL + '  PCG_DIANVB, ';
  strSQL := strSQL + '  PCG_DIANVC  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  PCMGER, ';
  strSQL := strSQL + '  CADFOR, ';
  strSQL := strSQL + '  PCMDET ';
  strSQL := strSQL + '  LEFT JOIN CADOPE ON OPE_CODOPE = PCG_OPEMAI ';
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

procedure TfrmConsultaPedidoCompra.pGravarLogEmail(strEmailDest, strDestinatario: String);
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('UPDATE ');
  qryAux.SQL.Add('  PCMGER ');
  qryAux.SQL.Add('SET ');
  qryAux.SQL.Add('  PCG_DTAMAI = :DTAMAI, ');
  qryAux.SQL.Add('  PCG_HORMAI = :HORMAI, ');
  qryAux.SQL.Add('  PCG_OPEMAI = :OPEMAI, ');
  qryAux.SQL.Add('  PCG_NOMMAI = :NOMMAI, ');
  qryAux.SQL.Add('  PCG_DESMAI = :DESMAI ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  PCG_NUMPED = :NUMPED AND ');
  qryAux.SQL.Add('  PCG_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  PCG_CODEMP = :CODEMP ');

  qryAux.ParamByName('DTAMAI').AsDateTime := VS_Date;
  qryAux.ParamByName('HORMAI').AsDateTime := Time;
  qryAux.ParamByName('OPEMAI').AsString   := strLoginUsuarioLogado;
  qryAux.ParamByName('NOMMAI').AsString   := strDestinatario;
  qryAux.ParamByName('DESMAI').AsString   := strEmailDest;

  qryAux.ParamByName('NUMPED').AsString := qryConsulta.FieldByName('Pedido').AsString;
  qryAux.ParamByName('ESPDOC').AsString := qryConsulta.FieldByName('Espécie').AsString;
  qryAux.ParamByName('CODEMP').AsString := qryConsulta.FieldByName('Emp.Ori.').AsString;

  qryAux.ExecSQL;

  FreeAndNil(qryAux);
end;

procedure TfrmConsultaPedidoCompra.pMostraItensPendentes;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);

  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  PCD_CODITE, ');
  qryAux.SQL.Add('  PCD_DESITE, ');
  qryAux.SQL.Add('  UNI_SIGUNI, ');
  qryAux.SQL.Add('  FORMAT(PCD_QTDITE, ' + fCfgSis('DEQTPC') + ') AS PCD_QTDITE, ');
  qryAux.SQL.Add('  FORMAT(PCD_QTDBAI, ' + fCfgSis('DEQTPC') + ') AS PCD_QTDBAI, ');
  qryAux.SQL.Add('  FORMAT(IF(PCD_QTDBAI > PCD_QTDITE, 0, PCD_QTDITE - PCD_QTDBAI), 2) AS PCD_QTDRES ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  PCMDET ');
  qryAux.SQL.Add('  JOIN CADITE ON ITE_CODITE = PCD_CODITE ');
  qryAux.SQL.Add('  JOIN CADUNI ON UNI_CODUNI = IFNULL(PCD_CODUNI, ITE_CODUNI) ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  PCD_NUMPED = :NUMPED AND ');
  qryAux.SQL.Add('  PCD_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  PCD_CODEMP = :CODEMP ');
  qryAux.SQL.Add('ORDER BY ');
  qryAux.SQL.Add('  PCD_DESITE ');

  qryAux.ParamByName('NUMPED').AsString := qryConsulta.FieldByName('Pedido').AsString;
  qryAux.ParamByName('ESPDOC').AsString := qryConsulta.FieldByName('Espécie').AsString;
  qryAux.ParamByName('CODEMP').AsString := qryConsulta.FieldByName('Emp.Ori.').AsString;

  qryAux.Open;

  Try
    pCriarFormularios(TfrmMostraItensPendentes, frmMostraItensPendentes);
    frmMostraItensPendentes.dtsPedido.DataSet := qryAux;
    frmMostraItensPendentes.blnRecPar := (qryConsulta.FieldByName('Status').AsString = 'RECEB. PARC.');
    frmMostraItensPendentes.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmConsultaPedidoCompra.pMostraItensPendentes]');
    End;
  End;

  pFreeAndNil(frmMostraItensPendentes);

  qryAux.Close;
  FreeAndNil(qryAux);
end;

procedure TfrmConsultaPedidoCompra.btnItensPendClick(Sender: TObject);
begin
  inherited;
  pMostraItensPendentes;
end;

procedure TfrmConsultaPedidoCompra.FormActivate(Sender: TObject);
begin
  inherited;
  btnSair.Left := pnlBotoes.Width - btnSair.Width - 7;
end;

procedure TfrmConsultaPedidoCompra.FormCreate(Sender: TObject);
begin
  inherited;
  FPais := fSetaPais;
end;

procedure TfrmConsultaPedidoCompra.btnGerPDFClick(Sender: TObject);
  Var
    strArqHtml: String;
    blnQtdPendente: Boolean;
begin
  inherited;

  If Not fTestaPdf Then
    Exit;

  blnQtdPendente := (fMensagem('ATENÇÃO!', 'Exibir quantidade:', ['&Total', '&Pendente']) = 2);

  pCriarFormularios(TfrmDigPDFPedidoCompra, frmDigPDFPedidoCompra);
  With frmDigPDFPedidoCompra Do
  If ShowModal = mrOk Then
  Begin
    blnSemPre            := edtPreco.Text = 'S';
    blnComMar            := chkMarca.Checked;
    blnCodFab            := chkCodFab.Checked;
    blnOrdDig            := edtOrdem.Text = 'D';

    strTipExp  := 'PDF';
    strArqHtml := fGeraEmail(qryConsulta.FieldByName('Pedido').AsString,
                             qryConsulta.FieldByName('Espécie').AsString,
                             qryConsulta.FieldByName('Emp.Dest.').AsString,
                             blnQtdPendente);

    If Not fEmptyStr(strArqHtml) Then
    Begin
      fMensagem('','Arquivo ' + strArqHtml + ' gerado com sucesso!', ['&Ok']);
      pExecArquivo(strArqHtml, Handle);
    End;

  End;

  FreeAndNil(frmDigPDFPedidoCompra);

end;

procedure TfrmConsultaPedidoCompra.qryConsultaAfterOpen(DataSet: TDataSet);
begin
  inherited;

  With DataSet Do
  Begin
    FieldByName('PCG_DTAMAI').Visible := False;
    FieldByName('PCG_HORMAI').Visible := False;
    FieldByName('PCG_OPEMAI').Visible := False;
    FieldByName('PCG_DESMAI').Visible := False;
    FieldByName('PCG_DIACOM').Visible := False;
    FieldByName('PCG_DIANVA').Visible := False;
    FieldByName('PCG_DIANVB').Visible := False;
    FieldByName('PCG_DIANVC').Visible := False;
  End;

end;

procedure TfrmConsultaPedidoCompra.btnGerXLSClick(Sender: TObject);
  Var
    objExcel     : TExcel;
    strSQL       : String;
    qryPedOrc    : TUniQuery;
    qryItensPdOr : TUniQuery;
    qryEmpPdOr   : TUniQuery;
    qryTranPdOr  : TUniQuery;
    qryConsMed   : TUniQuery;
    strExecutavel: String;
    arrDados     : Array [1..17] Of Array [1..2] Of String;
    intCont      : Integer;
    intQtdCol    : Integer;
    strUltCol    : String;
    strConPag    : String;    
    fltSaldoDisp : Double;
    LinAux       : Integer;
    strNumDoc, strEspDoc, strEmpDoc: String;

    intMes       : Integer;
    strAno       : String;
    strMes1      : String;
    strMes2      : String;
    strMes3      : String;
    strMes4      : String;
    strAno1      : String;
    strAno2      : String;
    strAno3      : String;
    strAno4      : String;

    strDirGravacao : String;

begin
  inherited;

  qryPedOrc    := fCriaQuery;
  qryItensPdOr := fCriaQuery;
  qryEmpPdOr   := fCriaQuery;
  qryTranPdOr  := fCriaQuery;
  qryConsMed   := fCriaQuery;

  strNumDoc := qryConsulta.FieldByName('Pedido').AsString;
  strEspDoc := qryConsulta.FieldByName('Espécie').AsString;
  strEmpDoc := qryConsulta.FieldByName('Emp.Dest.').AsString;

  If Not fTestaPdf Then
    Exit;

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
  strSQL := strSQL + '  LEFT JOIN CADCID ON (CADFOR.FOR_CODCID = CADCID.CID_CODCID) ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  PCMGER.PCG_NUMCTN = 0 AND ';
  strSQL := strSQL + '  PCMGER.PCG_NUMPED = :NUMPED AND ';
  strSQL := strSQL + '  PCMGER.PCG_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  PCMGER.PCG_CODEMP = :CODEMP ';

  With qryPedOrc Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMPED').AsString := strNumDoc;
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
  strSQL := strSQL + '  ITEGER.ITE_DTAULT, ';
  strSQL := strSQL + '  ITEGER.ITE_SALDOS, ';
  strSQL := strSQL + '  CADMAR.MAR_DESMAR, ';
  strSQL := strSQL + '  CADUNI.UNI_SIGUNI, ';
  strSQL := strSQL + '  IF(PCMGER.PCG_TIPFRE="1","CIF","FOB") AS PCG_TIPFRE, ';
  strSQL := strSQL + '  CADABF.ABF_IVAV_E, ';
  strSQL := strSQL + '  0   AS ITE_CONMED, ';
  strSQL := strSQL + '  (PCD_QTDITE * UNI_PESLIT) AS LITROS, ';
  strSQL := strSQL + '  (PCD_QTDITE * CADITE.ITE_PESOIT) AS PESOIT ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  PCMDET ';
  strSQL := strSQL + '  JOIN PCMGER ON (PCMDET.PCD_NUMPED = PCMGER.PCG_NUMPED  ';
  strSQL := strSQL + '              AND PCMDET.PCD_ESPDOC = PCMGER.PCG_ESPDOC  ';
  strSQL := strSQL + '              AND PCMDET.PCD_CODEMP = PCMGER.PCG_CODEMP  ';
  strSQL := strSQL + '              AND PCMDET.PCD_NUMCTN = PCMGER.PCG_NUMCTN) ';
  strSQL := strSQL + '  JOIN CADITE ON (PCMDET.PCD_CODITE = CADITE.ITE_CODITE) ';
  strSQL := strSQL + '  JOIN CADFOR ON (PCMDET.PCD_CODFOR = CADFOR.FOR_CODFOR) ';
  strSQL := strSQL + '  JOIN ITEGER ON CADITE.ITE_CODITE = ITEGER.ITE_CODITE AND    ';
  strSQL := strSQL + '                 ITEGER.ITE_CODEMP = :CODEMP                  ';
  strSQL := strSQL + '  LEFT JOIN CADCID ON (CADFOR.FOR_CODCID = CADCID.CID_CODCID) ';
  strSQL := strSQL + '  LEFT JOIN CADUNI ON (CADITE.ITE_CODUNI = CADUNI.UNI_CODUNI) ';
  strSQL := strSQL + '  LEFT JOIN CADMAR ON (CADITE.ITE_CODMAR = CADMAR.MAR_CODMAR) ';
  strSQL := strSQL + '  LEFT JOIN CADABF ON (CADITE.ITE_CODABF = CADABF.ABF_CODABF  ';
  strSQL := strSQL + '                   AND CADCID.CID_ESTADO = CADABF.ABF_ESTADO) ';
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

  With qryItensPdOr Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMPED').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    If fEmptyStr(strCodEmp) Then
      ParamByName('CODEMP').AsString := VS_strCodEmp
    Else
      ParamByName('CODEMP').AsString := strCodEmp;
    Open;

    TFloatField(FieldByName('PCD_QTDITE')).DisplayFormat := '#,##0.000';
    TFloatField(FieldByName('PCD_UNITAR')).DisplayFormat := '#,##0.000';
    TFloatField(FieldByName('PCD_TOTITE')).DisplayFormat := '#,##0.000';
    TFloatField(FieldByName('PCD_PERIPI')).DisplayFormat := '#,##0.0000';
    TFloatField(FieldByName('PCD_TOTIPI')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('PCD_PERSUB')).DisplayFormat := '#,##0.0000';
    TFloatField(FieldByName('PCD_TOTSUB')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ABF_IVAV_E')).DisplayFormat := '#,##0.0000';
  End;

  {**************************************}
  {* CARREGANDO OS DADOS DA EMPRESA     *}
  {***********************************LU*}
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CADEMP.EMP_CODEMP, ';
  strSQL := strSQL + '  CADEMP.EMP_NOMEMP,';
  strSQL := strSQL + '  CONCAT(CADEMP.EMP_ENDERE, ", ", IFNULL(CADEMP.EMP_ENDNUM,""),IF(IFNULL(EMP_ENDCMP, "") = "", "", CONCAT("  ", EMP_ENDCMP))) AS EMP_ENDERE, ';
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

  With qryEmpPdOr Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    If Not fEmptyStr(strEmpDoc) Then
      ParamByName('CODEMP').AsString := strEmpDoc
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

  With qryTranPdOr Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODTRA').AsString := qryPedOrc.FieldByName('PCG_CODTRA').AsString;
    Open;
  End;

  {************************************************}
  {* CARREGANDO OS DADOS DO CONSUMO MEDIO DO ITEM *}
  {*********************************************IV*}

  intMes := StrToInt(LeftStr(FormatDateTime('mm/yyyy', VS_Date),2));
  strAno := RightStr(FormatDateTime('mm/yyyy', VS_Date),4);

  If intMes <= 3 Then
  Begin
    strMes4 := fStrZero(IntToStr(intMes),2);
    strAno4 := strAno;
    Inc(intMes,-1);

    If intMes <> 0 Then
    Begin
      strMes3 := fStrZero(IntToStr(intMes),2);
      strAno3 := strAno;
      Inc(intMes,-1);
    End
    Else
    Begin
      strMes3 := '12';
      strAno3 := IntToStr(StrToInt(strAno) -1);
      strAno  := strAno3;
      intMes  := 11;
    End;

    If intMes <> 0 Then
    Begin
      strMes2 := fStrZero(IntToStr(intMes),2);
      strAno2 := strAno;
      Inc(intMes,-1);
    End
    Else
    Begin
      strMes2 := '12';
      strAno2 := IntToStr(StrToInt(strAno) -1);
      strAno  := strAno2;
      intMes  := 11;
    End;

    If intMes <> 0 Then
    Begin
      strMes1 := fStrZero(IntToStr(intMes),2);
      strAno1 := strAno;
    End
    Else
    Begin
      strMes1 := '12';
      strAno1 := IntToStr(StrToInt(strAno) -1);
      strAno  := strAno1;
    End;

  End
  Else
  Begin
    strMes4 := fStrZero(IntToStr(intMes),2);
    strAno4 := strAno;
    Inc(intMes, -1);

    strMes3 := fStrZero(IntToStr(intMes),2);
    strAno3 := strAno;
    Inc(intMes, -1);

    strMes2 := fStrZero(IntToStr(intMes),2);
    strAno2 := strAno;
    Inc(intMes, -1);

    strMes1 := fStrZero(IntToStr(intMes),2);
    strAno1 := strAno;
  End;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  (SUM(IFNULL((SELECT SQL_NO_CACHE GIR_QSAI' + strMes1 + ' FROM GIRITE WHERE GIR_CODITE = G.ITE_CODITE ';
  strSQL := strSQL + '       AND GIR_CODEMP = G.ITE_CODEMP AND GIR_A_N_O_ = ' + QuotedStr(strAno1) + ' ), 0 )) +             ';
  strSQL := strSQL + '   SUM(IFNULL((SELECT SQL_NO_CACHE GIR_QSAI' + strMes2 + ' FROM GIRITE WHERE GIR_CODITE = G.ITE_CODITE ';
  strSQL := strSQL + '       AND GIR_CODEMP = G.ITE_CODEMP AND GIR_A_N_O_ = ' + QuotedStr(strAno2) + ' ), 0 )) +             ';
  strSQL := strSQL + '   SUM(IFNULL((SELECT SQL_NO_CACHE GIR_QSAI' + strMes3 + ' FROM GIRITE WHERE GIR_CODITE = G.ITE_CODITE ';
  strSQL := strSQL + '       AND GIR_CODEMP = G.ITE_CODEMP AND GIR_A_N_O_ = ' + QuotedStr(strAno3) + ' ), 0 )))/3 AS MEDIA   ';
  strSQL := strSQL + '  FROM        ';
  strSQL := strSQL + '    CADITE I, ';
  strSQL := strSQL + '    ITEGER G, ';
  strSQL := strSQL + '    PCMDET D  ';
  strSQL := strSQL + ' WHERE I.ITE_CODITE = G.ITE_CODITE  ';
  strSQL := strSQL + '   AND I.ITE_CODITE = D.PCD_CODITE  ';
  strSQL := strSQL + '   AND D.PCD_NUMPED = :NUMDOC       ';
  strSQL := strSQL + '   AND D.PCD_CODITE = :CODITE       ';
  strSQL := strSQL + ' GROUP BY I.ITE_CODITE              ';

  With qryConsMed Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMDOC').AsString := qryPedOrc.FieldByName('PCG_NUMPED').AsString;
  End;

  {*******************************************}
  {* PEGA O ENDEREÇO CORRENTE DO EXECUTÁVEL  *}
  {****************************************LU*}
  strExecutavel := ExtractFilePath(Application.ExeName);

  If (qryConsulta.FieldByName('Espécie').AsString = 'PD') Then
  Begin
    {*******************************************}
    {* SE NÃO EXISTIR O DIRETÓRIO ELE CRIA     *}
    {****************************************LU*}
    If Not DirectoryExists(strExecutavel + 'PedidoCompra') Then
    Begin
      CreateDir(strExecutavel + 'PedidoCompra');
    End;
    strDirGravacao := strExecutavel + 'PedidoCompra';
  End
  Else
  Begin
    If Not DirectoryExists(strExecutavel + 'OrcamentoCompra') Then
    Begin
      CreateDir(strExecutavel + 'OrcamentoCompra');
    End;
    strDirGravacao := strExecutavel + 'OrcamentoCompra';
  End;

  {*******************************************}
  {* O ARQUIVO SERÁ GERADO COM ESSE NOME     *}
  {****************************************LU*}
  If (qryConsulta.FieldByName('Espécie').AsString = 'PD') Then
    strNomeArquivo := 'PD_' + strNumDoc + '.xls'
  Else
    strNomeArquivo := 'OR_' + strNumDoc + '.xls';

  arrDados[01][01] := 'CÓDIGO';
  arrDados[02][01] := 'DESCRIÇÃO';
  arrDados[03][01] := 'MARCA';
  arrDados[04][01] := 'CÓD. FÁBRICA';
  arrDados[05][01] := 'UNID.';
  arrDados[06][01] := 'QTDE.';
  arrDados[07][01] := 'PREÇO UNIT.';
  arrDados[08][01] := 'PREÇO TOTAL';
  arrDados[09][01] := '% IPI';
  arrDados[10][01] := 'VR. IPI';
  arrDados[11][01] := 'ULT. COMPRA';
  arrDados[12][01] := 'CONS. MÉDIO';
  arrDados[13][01] := 'SALDO DISP.';
  arrDados[14][01] := 'FRETE';
  arrDados[15][01] := 'ICMS ST';
  arrDados[16][01] := '% ST';
  arrDados[17][01] := 'IVA';

  arrDados[01][02] := 'PCD_CODITE';
  arrDados[02][02] := 'PCD_DESITE';
  arrDados[03][02] := 'MAR_DESMAR';
  arrDados[04][02] := 'ITE_CODFAB';
  arrDados[05][02] := 'UNI_SIGUNI';
  arrDados[06][02] := 'PCD_QTDITE';
  arrDados[07][02] := 'PCD_UNITAR';
  arrDados[08][02] := 'PCD_TOTITE';
  arrDados[09][02] := 'PCD_PERIPI';
  arrDados[10][02] := 'PCD_TOTIPI';
  arrDados[11][02] := 'ITE_DTAULT';
  arrDados[12][02] := 'ITE_CONMED';
  arrDados[13][02] := 'ITE_SALDOS';
  arrDados[14][02] := 'PCG_TIPFRE';
  arrDados[15][02] := 'PCD_TOTSUB';
  arrDados[16][02] := 'PCD_PERSUB';
  arrDados[17][02] := 'ABF_IVAV_E';

  objExcel := TExcel.fCriarExcel(Self);
  strNomeArquivo := strDirGravacao + '\' + strNomeArquivo;

  If Not objExcel.CriarArquivo(strNomeArquivo) Then
  begin
    FreeAndNil(objExcel);
    Exit;
  End;

  With objExcel Do
  Begin

    PintarTudo(Branco);
    DefinirFonte(CourierNew, 10);

    LinhaAtual := 1;
    intQtdCol  := Length(arrDados);
    strUltCol  := fGetLetraAlfa(intQtdCol);

    With qryEmpPdOr Do
    Begin
      Escrever(ProximaLinha,01, FieldByName('EMP_NOMEMP').AsString);
      DefinirFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), CourierNew, 14);

      Escrever(ProximaLinha,01, FieldByName('EMP_ENDERE').AsString);
      Escrever(ProximaLinha,01, FieldByName('EMP_NOMCID').AsString);
      Escrever(ProximaLinha,01, 'CNPJ: ' + fFormataCpfCgc(FieldByName('EMP_C_G_C_').AsString, FPais) +
                             ' | IE: ' + FieldByName('EMP_I_E_S_').AsString);
      Escrever(ProximaLinha,01, FieldByName('EMP_EMAILC').AsString);
      Escrever(ProximaLinha,01, 'Fone: ' + FieldByName('EMP_FONE01').AsString +
                             ' | Fax: ' + FieldByName('EMP_F_A_X_').AsString);
    End;

    ProximaLinha;
    Escrever(ProximaLinha,01, 'DEPARTAMENTO DE COMPRAS');

    If strEspDoc = 'PD' Then
      Escrever(ProximaLinha,01, 'PEDIDO DE COMPRA')
    Else
      Escrever(ProximaLinha,01, 'ORÇAMENTO');

    DefinirFonte('A' + IntToStr(LinhaAtual-1), strUltCol + IntToStr(LinhaAtual), CourierNew, 14);

    With qryPedOrc Do
    Begin
      ProximaLinha;
      Escrever(ProximaLinha, 01, 'Orçamento Nro. ' + strNumDoc);
      Escrever(ProximaLinha, 01, 'Nome:      ' + FieldByName('FOR_NOMFOR').AsString);
      Escrever(ProximaLinha, 01, 'Endereço:  ' + FieldByName('FOR_ENDERE').AsString);
      Escrever(LinhaAtual,08, 'Bairro:    ' + FieldByName('FOR_BAIRRO').AsString);
      Escrever(ProximaLinha, 01, 'Município: ' + FieldByName('FOR_NOMCID').AsString);
      Escrever(LinhaAtual,08, 'C.E.P.:    ' + fFormataCEP(FieldByName('FOR_C_E_P_').AsString));
      Escrever(ProximaLinha, 01, 'CNPJ:      ' + fFormataCpfCgc(FieldByName('FOR_C_G_C_').AsString, FPais));
      Escrever(LinhaAtual,08, 'I.E.:      ' + FieldByName('FOR_I_E_S_').AsString);
      Escrever(ProximaLinha, 01, 'Fone:      ' + fFormataFone(FieldByName('FOR_FONE01').AsString));
      Escrever(LinhaAtual,08, 'Atenção:   ' + FieldByName('PCG_ATENCA').AsString);
      Escrever(ProximaLinha, 01, 'Fax:       ' + FieldByName('FOR_F_A_X_').AsString);
      Escrever(LinhaAtual,08, 'Entrega:   ' + FieldByName('PCG_DTAENT').AsString);

      strConPag := (fFormataCondPag(FieldByName('PCG_CONPAG').AsString));
      strConPag := Copy(strConPag, 5, Length(strConPag)) + ' D.D.L.';
      Escrever(ProximaLinha, 01, 'Cond.Pgto: ' + strConPag);

      Escrever(LinhaAtual,08, 'Contato:   ' + FieldByName('FOR_CONTAT').AsString);
      ProximaLinha;
    End;

    {**************************************************}
    {* COLOCA EM NEGRITO E ALINHA AO CENTRO DA CELULA *}
    {***********************************************LU*}
    For intCont := 1 To 11 Do
    Begin
      Mesclar('A' + IntToStr(intCont), strUltCol + IntToStr(intCont));
      Negrito('A' + IntToStr(intCont), strUltCol + IntToStr(intCont), True);
      Alinhamento('A' + IntToStr(intCont), strUltCol + IntToStr(intCont), Centro);
    End;

    CorFundo('A8', strUltCol + '8', Cinza);
    Bordas('A2',  strUltCol + '7',  True,True,True,True);
    Bordas('A8',  strUltCol + '8',  True,True,True,True);
    Bordas('A9',  strUltCol + '10', True,True,True,True);
    Bordas('A11', strUltCol + '20', True,True,True,True);

    For intCont := 12 To LinhaAtual Do
    Begin
      Mesclar('A' + IntToStr(intCont), 'G' + IntToStr(intCont));
      Mesclar('H' + IntToStr(intCont), strUltCol + IntToStr(intCont));
      Negrito('A' + IntToStr(intCont), strUltCol + IntToStr(intCont), True);
      Alinhamento('A' + IntToStr(intCont), strUltCol + IntToStr(intCont), Esquerda);
    End;

    With qryItensPdOr Do
    Begin

      ProximaLinha;

      For intCont := 1 To intQtdCol Do
      Begin
        Escrever(LinhaAtual, intCont, arrDados[intCont, 01]);
        Negrito(LinhaAtual, intCont, True);

        If FieldByName(arrDados[intCont, 02]).DataType = ftFloat Then
          Alinhamento(LinhaAtual,intCont, Direita)
        Else
          Alinhamento(LinhaAtual,intCont, Esquerda);

      End;

      CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Preto);
      CorFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Branco);
      Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

      First;

      While Not Eof Do
      Begin

        ProximaLinha;

        For intCont := 1 To intQtdCol Do
        Begin

          If intCont = 12 Then
          Begin
            qryConsMed.ParamByName('CODITE').AsString := FieldByName(arrDados[01, 02]).AsString;
            qryConsMed.Open;

            Escrever(LinhaAtual, intCont, FormatFloat('#,##0.00', qryConsMed.FieldByName('MEDIA').AsFloat));
            Alinhamento(LinhaAtual, intCont, Direita);

            qryConsMed.Close;
          End
          Else If intCont = 13 Then
          Begin
            fltSaldoDisp := FieldByName(arrDados[intCont, 02]).AsFloat -
                            fRetornaSalRes(VS_strCodEmp, False, '', FieldByName(arrDados[01, 02]).AsString, strEmpDoc);
            Escrever(LinhaAtual, intCont, FormatFloat('#,##0.00', fltSaldoDisp));
            Alinhamento(LinhaAtual, intCont, Direita);
          End
          Else If FieldByName(arrDados[intCont, 02]).DataType = ftFloat Then
          Begin
            If arrDados[intCont, 01] = 'IVA' Then
              Escrever(LinhaAtual, intCont, '''' + FormatFloat('#,##0.0000', FieldByName(arrDados[intCont, 02]).AsFloat))
            Else Escrever(LinhaAtual, intCont, FormatFloat('#,##0.00', FieldByName(arrDados[intCont, 02]).AsFloat));

            Alinhamento(LinhaAtual, intCont, Direita);
          End
          Else
          Begin
            Escrever(LinhaAtual, intCont, '''' + FieldByName(arrDados[intCont, 02]).AsString);
            Alinhamento(LinhaAtual, intCont, Esquerda);
          End;

        End;

        Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

        If LinhaAtual Mod 2 = 0 Then
          CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Cinza);

        Next;
      End;

    End;

    With qryPedOrc Do
    Begin
      ProximaLinha;
      LinAux := LinhaAtual;

      Escrever(ProximaLinha,  11, 'Soma dos Itens: ');
      Escrever(LinhaAtual, 13, FormatFloat('##,#0.00', FieldByName('PCG_TOTITE').AsFloat));
      Escrever(ProximaLinha,  11, 'Soma do I.P.I.: ');
      Escrever(LinhaAtual, 13, FormatFloat('##,#0.00', FieldByName('PCG_TOTIPI').AsFloat));
      Escrever(ProximaLinha,  11, 'Valor da Susbt: ');
      Escrever(LinhaAtual, 13, FormatFloat('##,#0.00', FieldByName('PCG_TOTSUB').AsFloat));
      Escrever(ProximaLinha,  11, 'Valor do Frete: ');
      Escrever(LinhaAtual, 13, FormatFloat('##,#0.00', FieldByName('PCG_VALFRE').AsFloat));
      Escrever(ProximaLinha,  11, 'Total do Pedido: ');
      Escrever(LinhaAtual, 13, FormatFloat('##,#0.00', FieldByName('PCG_TOTGER').AsFloat));
      ProximaLinha;

      For intCont := LinAux To LinhaAtual Do
      Begin
        Mesclar('K' + IntToStr(intCont), 'L' + IntToStr(intCont));
        Mesclar('M' + IntToStr(intCont), 'O' + IntToStr(intCont));
        Negrito('K' + IntToStr(intCont), 'O' + IntToStr(intCont), True);
        Alinhamento('K' + IntToStr(intCont), 'L' + IntToStr(intCont), Esquerda);
        Alinhamento('M' + IntToStr(intCont), 'O' + IntToStr(intCont), Direita);
      End;

      Bordas('A' + IntToStr(LinAux), strUltCol + IntToStr(LinhaAtual), True, True, True, True);
    End;

    With qryTranPdOr Do
    Begin
      ProximaLinha;
      LinAux := LinhaAtual;

      Escrever(ProximaLinha,  01, 'TRANSPORTADORA');
      DefinirFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), CourierNew, 14);
      Escrever(ProximaLinha,  01, FieldByName('TRA_NOMTRA').AsString);
      Escrever(ProximaLinha,  01, 'Endereço:  ' + FieldByName('TRA_ENDERE').AsString);
      Escrever(LinhaAtual, 04, 'Bairro:    ' + FieldByName('TRA_BAIRRO').AsString);
      Escrever(ProximaLinha,  01, 'Município: ' + FieldByName('TRA_NOMCID').AsString);
      Escrever(LinhaAtual, 04, 'C.E.P.:    ' + fFormataCEP(FieldByName('TRA_C_E_P_').AsString));
      Escrever(ProximaLinha,  01, 'Fone/Fax:  ' + fFormataFone(FieldByName('TRA_FONE01').AsString) +
                               '  /  '       + fFormataFone(FieldByName('TRA_F_A_X_').AsString));
      ProximaLinha;

      Negrito('A' + IntToStr(LinAux+1), 'O' + IntToStr(LinAux+2), True);

      For intCont := LinAux To LinhaAtual Do
      Begin
        Mesclar('A' + IntToStr(intCont), 'C' + IntToStr(intCont));
        Mesclar('D' + IntToStr(intCont), 'O' + IntToStr(intCont));
        Alinhamento('A' + IntToStr(intCont), 'O' + IntToStr(intCont), Esquerda);
      End;

      Bordas('A' + IntToStr(LinAux), strUltCol + IntToStr(LinhaAtual), True, True, True, True);
    End;

    With qryPedOrc Do
    Begin
      ProximaLinha;
      LinAux := LinhaAtual;

      Escrever(ProximaLinha,  01, 'LOCAL DE ENTREGA');
      DefinirFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), CourierNew, 14);
      Negrito('A' + IntToStr(LinAux+1), 'O' + IntToStr(LinAux+1), True);
      Escrever(ProximaLinha,  01, 'A/C:       ' + FieldByName('PCG_NOMENT').AsString);
      Escrever(ProximaLinha,  01, 'Endereço:  ' + FieldByName('PCG_ENDENT').AsString);
      Escrever(ProximaLinha,  01, 'Município: ' + FieldByName('PCG_CIDENT').AsString);

      ProximaLinha;
      LinAux := LinhaAtual;
      
      Escrever(ProximaLinha, 01, 'OBSERVAÇÕES');
      Mesclar('A' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual));
      DefinirFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), CourierNew, 14);

      If strEspDoc = 'PD' Then
        Escrever(ProximaLinha, 02, 'FAVOR CONFIRMAR O RECEBIMENTO NO PEDIDO - MENCIONAR O NÚMERO DO PEDIDO NA NOTA FISCAL.')
      Else
        Escrever(ProximaLinha, 02, 'FAVOR CONFIRMAR O RECEBIMENTO NO ORÇAMENTO - MENCIONAR O NÚMERO DO ORÇAMENTO NA NOTA FISCAL.');

      Escrever(ProximaLinha, 02, FieldByName('PCG_OBS001').AsString);
      Escrever(ProximaLinha, 02, FieldByName('PCG_OBS002').AsString);
      Escrever(ProximaLinha, 02, FieldByName('PCG_OBS003').AsString);
      Escrever(ProximaLinha, 02, FieldByName('PCG_OBS004').AsString);
      Escrever(ProximaLinha, 02, FieldByName('PCG_OBS005').AsString);
      ProximaLinha;

      Negrito('A' + IntToStr(LinAux+1), 'O' + IntToStr(LinAux+2), True);

      For intCont := LinAux+2 To LinhaAtual Do
      Begin
        Mesclar('B' + IntToStr(intCont), 'P' + IntToStr(intCont));
        Alinhamento('A' + IntToStr(intCont), 'P' + IntToStr(intCont), Esquerda);
      End;

      Bordas('A' + IntToStr(LinAux), strUltCol + IntToStr(LinhaAtual), True, True, True, True);
    End;

    Escrever(ProximaLinha, 01, 'Desenvolvido por Citel Software');
    Mesclar('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));
    Alinhamento('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Direita);
    Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), True, True, True, True);

    OrientacaoPagina(Paisagem);

    //CongelarPaines('A22');
    AutoAjuste;
    SalvarArquivo;
    FecharArquivo;

  End;

  fMensagem('','Arquivo ' + strNomeArquivo + ' gerado com sucesso!', ['&Ok']);

  FreeAndNil(objExcel);

  FreeAndNil(qryConsMed);
  FreeAndNil(qryTranPdOr);
  FreeAndNil(qryItensPdOr);
  FreeAndNil(qryEmpPdOr);
  FreeAndNil(qryPedOrc);

{******************************************************************************}
{ Padrão "Espelho" da impressão do orçamento/pedido                            }
{******************************************************************************}
//  strTipExp  := 'XLS';
//  strArqHtml := fGeraEmail(qryConsulta.FieldByName('Pedido').AsString,
//                           qryConsulta.FieldByName('Espécie').AsString,
//                           qryConsulta.FieldByName('Emp.Dest.').AsString);
//  If Not fEmptyStr(strArqHtml) Then
//    fMensagem('','Arquivo ' + strArqHtml + ' gerado com sucesso!', ['&Ok']);
{******************************************************************************}
end;

end.
