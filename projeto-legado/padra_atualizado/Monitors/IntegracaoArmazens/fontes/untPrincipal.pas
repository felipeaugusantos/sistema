unit untPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  cxProgressBar, BitBtnLockedIncrem, EditFocus, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  Data.DB, UniClientDataSet, Uni, Mandae.Classes, untJadlog, IOUtils,
  Vcl.Samples.Gauges, Vcl.Samples.Spin, Math, Vcl.ComCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase,
  IdFTP, IdFTPCommon, Midas, Vcl.AppEvnts, frxClass, frxExportPDF, frxPreview,
  Vcl.Menus, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxCore, cxDateUtils, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, Datasnap.DBClient, cxCheckBox;

type
  TRecModulos = Record
    Banco     : TUniConnection;
    ModuloSpr : Pointer;
  End;

type
  TfrmPrincipal_IntegracaoArmazens = class(TForm)
    sbStatus: TStatusBar;
    tmrMonitor: TTimer;
    IdFTP: TIdFTP;
    TrayIcon: TTrayIcon;
    ApplicationEvents: TApplicationEvents;
    popTrayIcon: TPopupMenu;
    mnuMonitorar: TMenuItem;
    mnuEncerrar: TMenuItem;
    mnuConfiguracoes: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    pgcOpcoes: TPageControl;
    tbsMonitoramento: TTabSheet;
    Panel1: TPanel;
    Processo: TGauge;
    rdgTransportadoras: TRadioGroup;
    memLog: TMemo;
    pnlRodape: TPanel;
    Bevel2: TBevel;
    lblTotalNF: TLabel;
    lblTotPed: TLabel;
    lblUltExec: TLabel;
    lblUltExecHora: TLabel;
    Panel2: TPanel;
    btnReprocessarArquivos: TBitBtnLocked;
    btnConfiguracoes: TBitBtnLocked;
    btnMonitorar: TBitBtnLocked;
    btnEncerrar: TBitBtnLocked;
    tbsEtiquetas: TTabSheet;
    Panel3: TPanel;
    Label16: TLabel;
    Label18: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    mskDtaFin: TcxDateEdit;
    mskDtaIni: TcxDateEdit;
    rdgStatusEtiqueta: TRadioGroup;
    btnConsultarEtiquetas: TBitBtnLocked;
    Panel4: TPanel;
    dtsEtiquetas: TDataSource;
    Panel5: TPanel;
    cxgEtiquetas: TcxGridCitel;
    cxgEtiquetasView: TcxGridDBTableViewCitel;
    cxgEtiquetasViewData: TcxGridDBColumn;
    cxgEtiquetasViewDocumento: TcxGridDBColumn;
    cxgEtiquetasViewEspcie: TcxGridDBColumn;
    cxgEtiquetasViewEmpresa: TcxGridDBColumn;
    cxgEtiquetasViewTransportadora: TcxGridDBColumn;
    cxgEtiquetasViewStatusetiqueta: TcxGridDBColumn;
    cxgEtiquetasLevel: TcxGridLevel;
    cxgEtiquetasViewSelecionado: TcxGridDBColumn;
    btnMarcarDesmarcar: TBitBtnLocked;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    btnAlterarStatusSelecionados: TBitBtnLocked;
    cxStyleRepository1: TcxStyleRepository;
    cxsZebra: TcxStyle;
    procedure btnMonitorarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnEncerrarClick(Sender: TObject);
    procedure tmrMonitorTimer(Sender: TObject);
    procedure btnConfiguracoesClick(Sender: TObject);
    procedure ApplicationEventsMinimize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnReprocessarArquivosClick(Sender: TObject);
    procedure mnuMonitorarClick(Sender: TObject);
    procedure mnuConfiguracoesClick(Sender: TObject);
    procedure mnuEncerrarClick(Sender: TObject);
    procedure btnConsultarEtiquetasClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnMarcarDesmarcarClick(Sender: TObject);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
    procedure btnAlterarStatusSelecionadosClick(Sender: TObject);
    procedure cxgEtiquetasViewKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private

    {Configurações}
    STR_FTP_IP,
    STR_FTP_PORTA,
    STR_FTP_USUARIO,
    STR_FTP_SENHA,
    STR_EMPRESAS,
    STR_FTP_FORMA_GERACAO,
    STR_FTP_PASTA_EXTERNA,
    STR_TIPO_ARQUIVOS,
    STR_AGRUPAR_PASTA: String;
    INT_INTERVALO  : Integer;
    BLN_FTP_UTIFTP : Boolean;
    STR_ETIQUETA_EXTENSAO : String;

    strEspPLP, strSerCor : String;

    strPathEtiquetaMarketplace: String;
    strMarketplaceEtiqueta: String;
    strRetornoEnvioNFeMarketplace: String;
    intMarketplaceTimeout: Integer;

    cdsEtiquetas: TUniClientDataSet;

    function fGetKeyLock: String;

    function  fFTP_Conectar : Boolean;
    procedure pFTP_Desconectar;

    procedure pLogaMensagem(strAutInc, strMSG, strTipo: String);
    function  fDiretorioExiste(strDiretorio : String) : Boolean;

    procedure pTerminate;

    procedure pCarregarConfiguracoes;

    function fConfiguracoesOk     : Boolean;
    function fConfiguracoesOk_FTP : Boolean;
    function fConfiguracoesOk_DIR : Boolean;

    function fGetSQLVendas : String;
    function fGetSQLEtiquetas: string;

    procedure pGerarDANFES(qryVendas : TUniQuery);
    procedure pGerar_XMLS_(qryVendas : TUniQuery);
    procedure pGerar_ETIQ_(qryVendas : TUniQuery);

    function fGerarDANFE(strAcesso, strNumDoc, strCodEmp, strCodTra: String) : Boolean;
    function fGerar_XML_(strAcesso, strNumDoc, strCodEmp, strCodTra: String): Boolean;
    function fGerar_ETQ_(strAcesso, strNumDoc, strEspDoc, strCodEmp, strCodCli, strTabela, strCodTra: String; intVolumes: Integer; dtaDtaDoc: TDatetime): Boolean;

    function fGerarNomeDANFE(strAcesso, strNumDoc, strCodEmp : String) : String;
    function fGerarNome_XML_(strAcesso, strNumDoc, strCodEmp : String) : String;
    function fGerarNome_ETQ_(strAcesso, strNumDoc, strCodEmp, strCodTra: String): String;

    function fEnviarDANFE(qryVendas: TUniQuery) : Boolean;
    function fEnviar_XML_(qryVendas : TUniQuery) : Boolean;
    function fEnviar_ETQ_(qryVendas : TUniQuery) : Boolean;

    function fKillProcess(pId: Cardinal): Boolean;

    function fDeveIgnorarDocumento(qryVendas : TUniQuery) : Boolean;

    function fGetIntegrarComMandae(strCodTra, strEspDoc: String): Boolean;
    function fUsaJadLog(strCodTra: string): Boolean;

    function fEhTransportadoraJadlog(strCodTra: string): Boolean;
    function fEhTransportadoraMagalu(strCodTra: string): Boolean;
    function fEhTransportadoraMercadoLivre(strCodTra: string): Boolean;
    function fEhTransportadoraShopee(strCodTra: string): Boolean;
    function fEhTransportadoraAmazon(strCodTra: string): Boolean;

    function fGetEtiDesTransportadoraDoc(strCodTra: string): string;

    function fRetNomeNfeImprimirExeCitel: String;
    function fRetNomeEdtImprimirExeCitel: String;

    function fRetDiretorioArquivos(strCodEmp: String  = '';
                                   strCodTra: String  = '';
                                   blnDirTemporario : Boolean = False;
                                   blnEtiquetaFTP   : Boolean = False;
                                   strNumPok        : String  = ''): String;

    function fAtualizarARMFAT(strCampo, strValor, strAutInc : String) : Boolean;
    function fEnviarArquivoBancoDados(strAutInc, str_CampoBlob, strArquivo : String) : Boolean;

    {Métodos da Integração SIGEP Web}
    function fIncluiAtualizaVolumesCorreios(Const strAutInc,
                                                  strNumDoc,
                                                  strEspDoc,
                                                  strCodEmp,
                                                  strCodCli : String;
                                                  intVolume : Integer): Boolean;

    function fUSigep(strTabela, strNumDoc, strEspDoc, strEmpDoc, strCodTra : String) : Boolean;
    function fVendaEnviaCorreio(strTabela, strNumDoc, strEspDoc, strEmpDoc, strCodTra : String): Boolean;
    function fTraEnviaCorreio(strCodTra, strEmpDoc : String) : Boolean;

    {libEditorEtiquetas}
    procedure pIniModulos(Var modRecMod: TRecModulos);

    procedure pExecucao;
    function fProcessarArquivos : Boolean;
    function fRetornaDiretorioFTP : String;

    procedure pWinExec(ACommand: String);

    procedure pLog(AInfo: String; blnGravaBanco : Boolean = False);

    procedure cdsEtiquetasBeforePost(DataSet: TDataSet);

  public

  end;

Const
  TABELA_MOVGER = 'MOVGER';
  TABELA_NOTGER = 'NOTGER';

  CAMPO_DANFE = 'ARM_PDFDAN';
  CAMPO_X_M_L = 'ARM_X_M_L_';
  CAMPO_ETIQU = 'ARM_ETIQUE';

  CAMPO_DANFE_ALIAS = 'DANFE';
  CAMPO_X_M_L_ALIAS = 'XML';
  CAMPO_ETIQU_ALIAS = 'ETIQUETA';

  CAMPO_BLOB_DANFE = 'ARM_BLBDAN';
  CAMPO_BLOB_X_M_L = 'ARM_BLBXML';
  CAMPO_BLOB_ETIQU = 'ARM_BLBETQ';

  ARQUIVO_GERADO_ENVIADO = 'S';
  ARQUIVO_INEXISTENTE    = 'N';

  LOG_TIPO_ERRO_CONEXAO_FTP   = 'ERRO_ACESSO_FTP';
  LOG_TIPO_ERRO_PUT_FTP       = 'ERRO_PUT_FTP';
  LOG_TIPO_ERRO_PROCESSAMENTO = 'ERRO_PROCESSAMENTO';
  LOG_TIPO_INICIALIZACAO      = 'ERRO_INICIALIZACAO';

  GERAR_FTP_EXTERNO = '1';
  GERAR_DIR_EXTERNO = '2';

  DIR_TEMPORARIO = 'TEMP';

  CAPTION_MONITORAR = 'Monitorar';
  CAPTION_PARAR     = 'Parar';

  ZPL_ZEBRA = 'Z';
  PDF_D_O_C = 'P';

  {libEditorEtiquetas.dll}

  {$WARN SYMBOL_PLATFORM OFF}
  function fImprimeEtiquetasDespachoPDF(modRecMod          : TRecModulos;
                                        VS_Date            : TDateTime;
                                        strLoginUsuarioLogado,
                                        VS_strCodEmp,
                                        strChaveAcesso,
                                        strDiretorioSalvar : String): Boolean; stdcall; External 'libEditorEtiquetas.dll';
  {$WARN SYMBOL_PLATFORM ON}

implementation

{$R *.dfm}

uses untConfiguracoes, untSIGEPWebFuncoes, untFuncoesSimples, untModulo,
  untWS_SkyHub, untMarketPlace, untHubCitel, untHorarioSistema, untCorreiosMain;

procedure TfrmPrincipal_IntegracaoArmazens.btnEncerrarClick(Sender: TObject);
begin
  pTerminate;
end;

procedure TfrmPrincipal_IntegracaoArmazens.ApplicationEventsMinimize(Sender: TObject);
begin
  If Not VS_TSPlus Then
  Begin
    pgcOpcoes.ActivePage := tbsMonitoramento;

    Self.Hide();
    Self.WindowState := wsMinimized;

    TrayIcon.BalloonTitle := Self.Caption;
    TrayIcon.BalloonHint  := Application.ExeName;

    TrayIcon.Visible := True;
    TrayIcon.Animate := True;
    TrayIcon.ShowBalloonHint;
  End;
end;

procedure TfrmPrincipal_IntegracaoArmazens.btnAlterarStatusSelecionadosClick(
  Sender: TObject);
begin
  try
    sbStatus.Panels[0].Text := 'Aguarde ...';
    Screen.Cursor := crHourGlass;
    Application.ProcessMessages;
    cdsEtiquetas.DisableControls;
    cdsEtiquetas.First;
    while not cdsEtiquetas.Eof do
    begin
      if cdsEtiquetas.FieldByName('Selecionado').AsString = 'S' then
      begin
        cdsEtiquetas.Edit;
        if cdsEtiquetas.FieldByName('Status etiqueta').AsString = 'Processada' then
          cdsEtiquetas.FieldByName('Status etiqueta').AsString := 'Não processada'
        else
          cdsEtiquetas.FieldByName('Status etiqueta').AsString := 'Processada';
        cdsEtiquetas.Post;
      end;
      cdsEtiquetas.Next;
    end;
    cdsEtiquetas.First;
    cdsEtiquetas.EnableControls;
  finally
    sbStatus.Panels[0].Text := '';
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmPrincipal_IntegracaoArmazens.btnConfiguracoesClick(Sender: TObject);
begin
  pCriarFormularios(TfrmConfiguracoes, frmConfiguracoes);
  frmConfiguracoes.rdgFormaGeracao.ItemIndex := IIF(STR_FTP_FORMA_GERACAO = GERAR_FTP_EXTERNO, 0, 1);
  frmConfiguracoes.edtPastaExterna.Text      := STR_FTP_PASTA_EXTERNA;
  frmConfiguracoes.edtIP.Text        := STR_FTP_IP;
  frmConfiguracoes.edtPorta.Text     := STR_FTP_PORTA;
  frmConfiguracoes.edtUsuario.Text   := STR_FTP_USUARIO;
  frmConfiguracoes.edtSenha.Text     := STR_FTP_SENHA;
  frmConfiguracoes.edtIntervalo.Text := IntToStr(INT_INTERVALO);
  frmConfiguracoes.edtEmpresas.Text  := STR_EMPRESAS;
  frmConfiguracoes.ShowModal;
end;

procedure TfrmPrincipal_IntegracaoArmazens.btnConsultarEtiquetasClick(
  Sender: TObject);
var
  qryEtiquetas: TUniQuery;
begin
  qryEtiquetas := fCriaQuery;
  try
    dtsEtiquetas.DataSet := nil;

    if Assigned(cdsEtiquetas) then
      FreeAndNil(cdsEtiquetas);

    qryEtiquetas.SQL.Text := fGetSQLEtiquetas;

    case rdgStatusEtiqueta.ItemIndex of
      0: qryEtiquetas.SQL.Add(' AND `Status etiqueta` = ''Processada''');
      1: qryEtiquetas.SQL.Add(' AND `Status etiqueta` = ''Não processada''');
    end;

    qryEtiquetas.ParamByName('DTAINI').AsDateTime := mskDtaIni.Date;
    qryEtiquetas.ParamByName('DTAFIN').AsDateTime := mskDtaFin.Date;
    qryEtiquetas.Open;

    cdsEtiquetas := fCriaClientDatset(qryEtiquetas);
    cdsEtiquetas.BeforePost := Self.cdsEtiquetasBeforePost;
    cdsEtiquetas.FieldByName('Data').Alignment := taCenter;
    cdsEtiquetas.FieldByName('Documento').Alignment := taCenter;
    cdsEtiquetas.FieldByName('Espécie').Alignment := taCenter;
    cdsEtiquetas.FieldByName('Empresa').Alignment := taCenter;
    dtsEtiquetas.DataSet := cdsEtiquetas;

    cxgEtiquetasView.DataController.Filter.Clear;
    cxgEtiquetasView.Controller.GoToFirst;
    pSetFocus(cxgEtiquetas);
  finally
    qryEtiquetas.Free;
  end;
end;

procedure TfrmPrincipal_IntegracaoArmazens.btnMarcarDesmarcarClick(
  Sender: TObject);
begin
  if not Assigned(cdsEtiquetas) then
    Exit;
  if cdsEtiquetas.IsEmpty then
    Exit;
  if cxgEtiquetasView.Controller.FocusedRow is TcxGridFilterRow then
    Exit;
  cdsEtiquetas.Edit;
  cdsEtiquetas.FieldByName('Selecionado').AsString :=
    IIF(cdsEtiquetas.FieldByName('Selecionado').AsString.Equals('S'), 'N', 'S');
  cdsEtiquetas.Post;
end;

procedure TfrmPrincipal_IntegracaoArmazens.btnMarcarTodosClick(Sender: TObject);
begin
  try
    sbStatus.Panels[0].Text := 'Aguarde ...';
    Screen.Cursor := crHourGlass;
    Application.ProcessMessages;
    cdsEtiquetas.DisableControls;
    cdsEtiquetas.First;
    while not cdsEtiquetas.Eof do
    begin
      cdsEtiquetas.Edit;
      cdsEtiquetas.FieldByName('Selecionado').AsString := 'S';
      cdsEtiquetas.Post;
      cdsEtiquetas.Next;
    end;
    cdsEtiquetas.First;
    cdsEtiquetas.EnableControls;
  finally
    sbStatus.Panels[0].Text := '';
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmPrincipal_IntegracaoArmazens.btnMonitorarClick(Sender: TObject);
begin

  If Not fConfiguracoesOk Then
  Begin
    pLog('Realize as configurações primeiramente!', True);
    Exit;
  End;

  If Not FileExists(fRetNomeNfeImprimirExeCitel) Then
  Begin
    pLog('Não encontrado: NFeImpressao.exe (Diretório raiz)', True);
    Exit;
  End;

  If Not FileExists(fRetNomeEdtImprimirExeCitel) Then
  Begin
    pLog('Não encontrado: libEditorEtiquetas.dll (Diretório raiz)', True);
    Exit;
  End;

  If fCfgSis('CITINF', varString, VS_strCodEmp) <> 'S' Then
  Begin
    pLog('CFG_CITINF deve ser habilitada ("S")!', True);
    Exit;
  End;

  If Not BLN_FTP_UTIFTP Then
  Begin
    pLog('CFG_UTIFTP deve ser habilitada ("S")!', True);
    Exit;
  End;

  {Parar Monitor}
  If (btnMonitorar.Caption = CAPTION_PARAR) Then
  Begin
    tmrMonitor.Enabled   := False;
    btnMonitorar.Caption := CAPTION_MONITORAR;
    Exit;
  End;

  tmrMonitor.Enabled  := False;
  tmrMonitor.Interval := INT_INTERVALO * 1000;

  Try
    btnMonitorar.Caption := CAPTION_PARAR;
    if pgcOpcoes.ActivePage = tbsMonitoramento then
      pExecucao;
  Finally
    tmrMonitor.Enabled   := True;
  End;

end;

procedure TfrmPrincipal_IntegracaoArmazens.btnReprocessarArquivosClick(Sender: TObject);
var
  qryAux    : TUniQuery;
  qryUpd    : TUniQuery;
  intQtdReg : Integer;
const
  SQL_UPDATE_ARMFAT = 'UPDATE ARMFAT SET ARM_PDFDAN = IF(ARM_PDFDAN = ''N'', NULL, ARM_PDFDAN), ' +
                                        'ARM_X_M_L_ = IF(ARM_X_M_L_ = ''N'', NULL, ARM_X_M_L_), ' +
                                        'ARM_ETIQUE = IF(ARM_ETIQUE = ''N'', NULL, ARM_ETIQUE)  ' +
                      'WHERE AUTOINCREM = :AUTINC ';

  SQL_AUTINC_REPROC = 'SELECT       ' +
                      '  AUTOINCREM ' +
                      'FROM         ' +
                      '  ARMFAT     ' +
                      'WHERE        ' +
                      '  ((ARM_PDFDAN = ''N'') OR (ARM_X_M_L_ = ''N'') OR (ARM_ETIQUE = ''N'')) AND ARM_STATUS = 0 ';

begin

  qryAux := fCriaQuery();
  qryUpd := fCriaQuery();

  Self.Cursor := crHourGlass;

  Try

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(SQL_AUTINC_REPROC);
    qryAux.Open;

    If qryAux.IsEmpty Then
    Begin
      pLog('Não existe(m) registro(s) para reprocessar!');
      Exit;
    End
    Else
    Begin

      intQtdReg := qryAux.RecordCount;

      qryAux.First;
      While Not qryAux.Eof Do
      Begin
        pZerarTentativasLock(fGetKeyLock);

        qryUpd.Close;
        qryUpd.SQL.Clear;
        qryUpd.SQL.Add(SQL_UPDATE_ARMFAT);
        qryUpd.ParamByName('AUTINC').AsString := qryAux.FieldByName('AUTOINCREM').AsString;

        Try
          qryUpd.ExecSQL;
        Except
          On E: Exception Do
            pLog('Erro: ' + E.Message, True);
        End;

        qryAux.Next;

      End;

      pLog(intQtdReg.ToString + ' documento(s) retornou para fila de processamento!');

    End;

  Finally

    FreeAndNil(qryAux);
    FreeAndNil(qryUpd);

    Self.Cursor := crDefault;

  End;

end;

procedure TfrmPrincipal_IntegracaoArmazens.cdsEtiquetasBeforePost(
  DataSet: TDataSet);
begin
  if not cdsEtiquetas.Active then
    Exit;
  if cdsEtiquetas.State <> dsEdit then
    Exit;
  if cdsEtiquetas.FieldByName('Status etiqueta').Value = cdsEtiquetas.FieldByName('Status etiqueta').OldValue then
    Exit;
  if cdsEtiquetas.FieldByName('Status etiqueta').AsString.Equals('Processada') then
    fExecutaSQL('UPDATE ARMFAT SET ARM_ETIQUE = "S" ' +
                'WHERE AUTOINCREM = "' + cdsEtiquetas.FieldByName('AUTOINCREM').AsString + '"')
  else
    fExecutaSQL('UPDATE ARMFAT SET ARM_STATUS = 0, ARM_ETIQUE = NULL ' +
                'WHERE AUTOINCREM = "' + cdsEtiquetas.FieldByName('AUTOINCREM').AsString + '"');
end;

procedure TfrmPrincipal_IntegracaoArmazens.cxgEtiquetasViewKeyPress(
  Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    btnMarcarDesmarcar.Click;
end;

function TfrmPrincipal_IntegracaoArmazens.fAtualizarARMFAT(strCampo, strValor, strAutInc : String): Boolean;
var
  qryUpdate : TUniQuery;
begin

  If fEmptyStr(strCampo) Then
    Exit(False);

  If fEmptyStr(strValor) Then
    Exit(False);

  If fEmptyStr(strAutInc) Then
    Exit(False);

  qryUpdate := fCriaQuery();

  Try

    qryUpdate.Close;
    qryUpdate.SQL.Clear;
    qryUpdate.SQL.Add('UPDATE ARMFAT SET ' + strCampo + ' = ' + QuotedStr(strValor) + ' WHERE AUTOINCREM = ' + QuotedStr(strAutInc));

    Try
      qryUpdate.ExecSQL;
      Result := True;
    Except
      Result := False;
    End;

  Finally
    FreeAndNil(qryUpdate);
  End;

end;

function TfrmPrincipal_IntegracaoArmazens.fConfiguracoesOk : Boolean;
begin

  Result := False;

  If (STR_FTP_FORMA_GERACAO = GERAR_FTP_EXTERNO) Then
    Result := fConfiguracoesOk_FTP

  Else

  If (STR_FTP_FORMA_GERACAO = GERAR_DIR_EXTERNO) Then
    Result := fConfiguracoesOk_DIR;

end;

function TfrmPrincipal_IntegracaoArmazens.fConfiguracoesOk_DIR: Boolean;
begin

  Result := False;

  If fEmptyStr(STR_FTP_PASTA_EXTERNA) Then
    Exit;

  If Not fDiretorioExiste(STR_FTP_PASTA_EXTERNA) Then
    Exit;

  If fEmptyStr(STR_EMPRESAS) Then
    Exit;

  Result := True;

end;

function TfrmPrincipal_IntegracaoArmazens.fConfiguracoesOk_FTP: Boolean;
begin

  Result := False;

  If fEmptyStr(STR_FTP_IP) Then
    Exit;

  If fEmptyStr(STR_FTP_PORTA) Then
    Exit;

  If fEmptyStr(STR_FTP_USUARIO) Then
    Exit;

  If fEmptyStr(STR_FTP_SENHA) Then
    Exit;

  If fEmptyStr(STR_EMPRESAS) Then
    Exit;

  Result := True;

end;

function TfrmPrincipal_IntegracaoArmazens.fGetEtiDesTransportadoraDoc(strCodTra: string): string;
begin
  Result := fCampoTabela('TRA_ETIDES', 'CADTRA', ['TRA_CODTRA'], [strCodTra], False);
end;

function TfrmPrincipal_IntegracaoArmazens.fGetIntegrarComMandae(strCodTra, strEspDoc: String): Boolean;
  var
    LblnTransportadoraIntegraComMandae : Boolean;
begin
  Result := False;

  if not fEmptyStr(strCodTra) then
  Begin
    LblnTransportadoraIntegraComMandae := fCampoTabela('TRA_ETIDES', 'CADTRA', ['TRA_CODTRA'], [strCodTra]) = 'MANDAE';

    if (LblnTransportadoraIntegraComMandae) And
       (fCfgSis('MANUSA', varBoolean)) And
       (fEmptyStr(fCfgSis('MANESP')) or (Pos(strEspDoc, fTransform(fCfgSis('MANESP'), 2)) > 0)) then
      Result := True;
  End;

end;

function TfrmPrincipal_IntegracaoArmazens.fGetKeyLock: String;
begin
  Result := 'Exportacao_DANFE_XML_Etiqueta';
end;

function TfrmPrincipal_IntegracaoArmazens.fUsaJadLog(strCodTra: string): Boolean;
begin
  Result := (fCfgSis('USAJAD', varBoolean)) and (fEhTransportadoraJadlog(strCodTra));
end;

function TfrmPrincipal_IntegracaoArmazens.fEhTransportadoraJadlog(strCodTra: string): Boolean;
begin
  Result := fCampoTabela('TRA_ETIDES', 'CADTRA', ['TRA_CODTRA'], [strCodTra], False) = 'JADLOG';
end;

function TfrmPrincipal_IntegracaoArmazens.fEhTransportadoraMercadoLivre(strCodTra: string): Boolean;
begin
  Result := fGetEtiDesTransportadoraDoc(strCodTra) = 'MERCADO LIVRE';
end;

function TfrmPrincipal_IntegracaoArmazens.fEhTransportadoraMagalu(strCodTra: string): Boolean;
begin
  Result := fGetEtiDesTransportadoraDoc(strCodTra) = 'MAGALU';
end;

function TfrmPrincipal_IntegracaoArmazens.fEhTransportadoraShopee(strCodTra: string): Boolean;
begin
  Result := fGetEtiDesTransportadoraDoc(strCodTra) = 'SHOPEE';
end;

function TfrmPrincipal_IntegracaoArmazens.fEhTransportadoraAmazon(strCodTra: string): Boolean;
begin
  Result := fGetEtiDesTransportadoraDoc(strCodTra) = 'AMAZON';
end;

function TfrmPrincipal_IntegracaoArmazens.fDeveIgnorarDocumento(qryVendas: TUniQuery): Boolean;
Var
  blnUSigep: Boolean;
  blnB2W   : Boolean;
begin

  Result := False;

  If rdgTransportadoras.Visible And (rdgTransportadoras.ItemIndex <> 3) Then
  Begin

    blnUSigep := fUSigep(qryVendas.FieldByName('TABELA').AsString,
                         qryVendas.FieldByName('NUMDOC').AsString,
                         qryVendas.FieldByName('ESPDOC').AsString,
                         qryVendas.FieldByName('CODEMP').AsString,
                         qryVendas.FieldByName('CODTRA').AsString);

    blnB2W := (fUtilizaRotinaDeImpressaoDeEtiquetaDeDespachoB2WEntrega And
               fTransportadoraRealizaColetaB2WEntrega(fGetCodigoDaTransportadora(qryVendas.FieldByName('NUMDOC').AsString,
                                                                                 qryVendas.FieldByName('ESPDOC').AsString,
                                                                                 qryVendas.FieldByName('CODEMP').AsString,
                                                                                 qryVendas.FieldByName('TABELA').AsString)));

    Case rdgTransportadoras.ItemIndex Of
      0: Result := Not blnUSigep;
      1: Result := Not blnB2W;
      2: Result := (blnUSigep) Or (blnB2W);
    End;

  End;

end;

function TfrmPrincipal_IntegracaoArmazens.fDiretorioExiste(strDiretorio: String) : Boolean;
begin

  Result := False;

  If fEmptyStr(strDiretorio) Then
    Exit;

  If Not DirectoryExists(strDiretorio) Then
  Begin
    If Not CreateDir(strDiretorio) Then
      Exit;
  End;

  Result := True;

end;

function TfrmPrincipal_IntegracaoArmazens.fProcessarArquivos : Boolean;
const
  MAX_TENTATIVAS = 10;
Var
  qryTmp : TUniQuery;

  blnDAN,
  blnXML,
  blnETQ,
  blnFail: Boolean;
  LTentativa: Integer;
begin
  pZerarTentativasLock(fGetKeyLock);

  If memLog.Lines.Count > 500 Then
    memLog.Lines.Clear;

  Result := False;
  qryTmp := fCriaQuery();

  lblTotPed.Caption := '0';
  Processo.MaxValue := 0;
  Processo.Progress := 0;

  Try
    pLog('Buscando documentos, aguarde...');
    Self.Refresh;
    Application.ProcessMessages;

    qryTmp.Close;
    qryTmp.SQL.Clear;
    qryTmp.SQL.Add(fGetSQLVendas + ' LIMIT 500 ');
    qryTmp.ParamByName('CODEMP').AsString := STR_EMPRESAS;
    qryTmp.Open;

    If qryTmp.IsEmpty Then
      Exit(False);

    rdgTransportadoras.Enabled := False;
    tbsEtiquetas.TabVisible := False;

    lblTotPed.Caption := IntToStr(qryTmp.RecordCount);

    Try
      pLog('Gerando DANFEs, aguarde...');
      Application.ProcessMessages;
      pGerarDANFES(qryTmp);
    Finally

    End;

    Try
      pLog('Gerando XMLs, aguarde...');
      Application.ProcessMessages;
      pGerar_XMLS_(qryTmp);
    Finally

    End;

    Try
      pLog('Gerando Etiquetas, aguarde...');
      Application.ProcessMessages;
      pGerar_ETIQ_(qryTmp);
    Finally

    End;

    {Envios FTP}
    If Not fFTP_Conectar Then
      Exit(False);

    Try

      For LTentativa := 1 To MAX_TENTATIVAS Do
      Begin

        pLog('Enviando arquivos (T' + LTentativa.ToString + '), aguarde ...');
        Application.ProcessMessages;

        Processo.MaxValue := qryTmp.RecordCount;
        Processo.Progress := 0;

        blnFail := False;

        qryTmp.First;
        While Not qryTmp.Eof Do
        Begin
          pZerarTentativasLock(fGetKeyLock);

          If Not fDeveIgnorarDocumento(qryTmp) Then
          Begin
            blnDAN := fEnviarDANFE(qryTmp);
            blnXML := fEnviar_XML_(qryTmp);
            blnETQ := fEnviar_ETQ_(qryTmp);

            blnFail := blnFail Or IIF(blnDAN And blnXML And blnETQ, False, True);

            {Status}
            fAtualizarARMFAT('ARM_STATUS',
                             IIF(blnDAN And blnXML And blnETQ, '1', '0'),
                             qryTmp.FieldByName('AUTINC_ARMFAT').AsString);
          End;

          Processo.Progress := Processo.Progress + 1;
          Application.ProcessMessages;

          qryTmp.Next;

        End;

        Result := Not blnFail;

        If Result Then
          Break;

        pLog('Executando nova tentativa ... ');
        Application.ProcessMessages;
        Sleep(1000);
      End;

    Finally
      If Result Then
        pLog('Rotina concluída com sucesso!');
      Application.ProcessMessages;
    End;

  Finally

    {Mostra hora última execução / checagem}
    lblUltExecHora.Caption := FormatDateTime('hh:mm:ss', fRetornaHoraServidor);

    rdgTransportadoras.Enabled := True;
    tbsEtiquetas.TabVisible := True;

    FreeAndNil(qryTmp);
    pFTP_Desconectar;

  End;

end;

function TfrmPrincipal_IntegracaoArmazens.fGerarDANFE(strAcesso, strNumDoc, strCodEmp, strCodTra: String) : Boolean;
const
  strImpressora     = ' "NENHUMA"';
  strReimpressaoNFE = ' " "';
  strTipo           = 'NFE';
  strApresentar     = ' "N"';
var
  strDiretorio, strNfeImprimirExe, strEmpresa, strAce : String;
begin
  pLog('Gerando DANFE ' + strAcesso);

  Result := True;

  If fEmptyStr(strAcesso) Then
    Exit(False);

  {CITINF: NFe: Imprimir nota fiscal pelo NFeImpressão?}
  If fCfgSis('CITINF', varString, VS_strCodEmp) = 'S' Then
  Begin

    strEmpresa   := ' "' + VS_strCodEmp + '"';
    strAce       := ' "' + strAcesso    + '"';
    strDiretorio := ' "' + fRetDiretorioArquivos(strCodEmp, strCodTra, True) + '\' + fGerarNomeDANFE(strAcesso, strNumDoc, strCodEmp) + '"';

    strNfeImprimirExe := fRetNomeNfeImprimirExeCitel;
    If FileExists(strNfeImprimirExe) Then
    Begin
      pWinExec(strNfeImprimirExe + ' ' + strTipo + '_IMPRIMIR_PDF' + //Parâmetro 1
               strEmpresa        +                                   //Parâmetro 2
               strAce            +                                   //Parâmetro 3
               strImpressora     +                                   //Parâmetro 4
               strReimpressaoNFE +                                   //Parâmetro 5
               strDiretorio      +                                   //Parâmetro 6
               strApresentar     );                                  //Parâmetro 7
    End;
  End

  Else

  {Download FIT}
  Begin
    Result := False;
  End;

end;

function TfrmPrincipal_IntegracaoArmazens.fGerarNomeDANFE(strAcesso, strNumDoc, strCodEmp: String): String;
begin
  Result := strAcesso + '.pdf';
end;

function TfrmPrincipal_IntegracaoArmazens.fGerarNome_ETQ_(strAcesso, strNumDoc, strCodEmp, strCodTra: String): String;
begin
  Result := strAcesso + IIF(STR_ETIQUETA_EXTENSAO.Equals(ZPL_ZEBRA), '.zpl', 'E.pdf');
end;

function TfrmPrincipal_IntegracaoArmazens.fGerarNome_XML_(strAcesso, strNumDoc, strCodEmp: String): String;
begin
  Result := strAcesso + '.xml';
end;

function TfrmPrincipal_IntegracaoArmazens.fGerar_ETQ_(strAcesso, strNumDoc, strEspDoc, strCodEmp, strCodCli, strTabela, strCodTra: String; intVolumes: Integer; dtaDtaDoc: TDatetime): Boolean;
var
  strArquivoEtiqueta: String;
  modRecMod    : TRecModulos;
  WS_SkyHub    : TWS_SkyHub;
  Pedido       : untWS_SkyHub.TDocumento;
  strLayDoc    : String;
  strDocumento : String;
  LMensagem    : String;
  LError       : string;
  LObjMandaeBuilder: TMandaeBuilder;
begin
  pLog('Gerando etiqueta NFe ' + strAcesso);

  If fEmptyStr(strAcesso) Then
    Exit(False);

  strArquivoEtiqueta := fRetDiretorioArquivos(strCodEmp, strCodTra, True) + '\' + fGerarNome_ETQ_(strAcesso, strNumDoc, strCodEmp, strCodTra);

  strDocumento := strNumDoc + '-' + strEspDoc + '-' + strCodEmp;

  If fGetIntegrarComMandae(strCodTra, strEspDoc) Then
  Begin
    pLog('Etiqueta Mandae');
    LObjMandaeBuilder := TMandaeBuilder.Create;
    Try
      LObjMandaeBuilder.strNumeroDocumento  := strNumDoc;
      LObjMandaeBuilder.strEspecieDocumento := strEspDoc;
      LObjMandaeBuilder.strCodigoEmpresa    := strCodEmp;
      LObjMandaeBuilder.intNumeroVolumes    := intVolumes;
      LObjMandaeBuilder.dtaDocumento        := dtaDtaDoc;
      if not LObjMandaeBuilder.fGerarEtiquetas(LMensagem) then
      Begin
        pLog(LMensagem, True);
        Exit(False);
      End;
    Finally
      FreeAndNil(LObjMandaeBuilder);
    End;
  End

  Else If (strEspDoc = 'NF') and fUsaJadLog(strCodTra) Then
  Begin
    pLog('Etiqueta JADLOG');
    if not untJadLog.fGerouEtiqueta(strNumDoc, strEspDoc, strCodEmp) then
    begin
      if not untJadLog.fEnviaPedidoJadlog(strNumDoc, strEspDoc, strCodEmp, 0) then
      begin
        pLog(strDocumento + ': ' + 'Não foi possível gerar a etiqueta JADLOG!', True);
        Exit(False);
      end;
    end;
  End

  Else If (strEspDoc = 'NF') and (fEhTransportadoraMercadoLivre(strCodTra)) Then
  Begin
    pLog('Etiqueta Mercado Livre');
    If Not fValidaNotaMarketPlace(strNumDoc, strEspDoc, strCodEmp, strCodCli, PREFIX_MERCADO_LIVRE) Then
    Begin
      pLog(strDocumento + ': ' + 'Não foi possível gerar a etiqueta do Mercado Livre!', True);
      Exit(False);
    End;
    LMensagem := EmptyStr;
    Result := fDownloadEtiquetMarketplacePDF(strNumDoc, strEspDoc, strCodEmp, strCodCli, PREFIX_MERCADO_LIVRE, LMensagem, strPathEtiquetaMarketplace, strMarketplaceEtiqueta, strRetornoEnvioNFeMarketplace, intMarketplaceTimeout);
    If Not Result Then
    Begin
      LMensagem := 'Não foi possível gerar a etiqueta do Mercado Livre.' + sLineBreak + LMensagem;
      pLog(LMensagem, True);
    End
    Else
    Begin
      pLog('Copiando arquivo "' + strPathEtiquetaMarketplace + '" para "' + strArquivoEtiqueta + '"');
      If FileExists(strArquivoEtiqueta) Then
        TFile.Delete(strArquivoEtiqueta);
      TFile.Copy(strPathEtiquetaMarketplace, strArquivoEtiqueta);
    End;
    Exit;
  End

  Else If (strEspDoc = 'NF') and (fEhTransportadoraMagalu(strCodTra)) Then
  Begin
    pLog('Etiqueta Magazine Luiza');
    If Not fValidaNotaMarketPlace(strNumDoc, strEspDoc, strCodEmp, strCodCli, PREFIX_MAGALU) Then
    Begin
      pLog(strDocumento + ': ' + 'Não foi possível gerar a etiqueta do Magazine Luiza!', True);
      Exit(False);
    End;
    LMensagem := EmptyStr;
    Result := fDownloadEtiquetMarketplacePDF(strNumDoc, strEspDoc, strCodEmp, strCodCli, PREFIX_MAGALU, LMensagem, strPathEtiquetaMarketplace, strMarketplaceEtiqueta, strRetornoEnvioNFeMarketplace, intMarketplaceTimeout);
    If Not Result Then
    Begin
      LMensagem := 'Não foi possível gerar a etiqueta do Magazine Luiza.' + sLineBreak + LMensagem;
      pLog(LMensagem, True);
    End
    Else
    Begin
      pLog('Copiando arquivo "' + strPathEtiquetaMarketplace + '" para "' + strArquivoEtiqueta + '"');
      If FileExists(strArquivoEtiqueta) Then
        TFile.Delete(strArquivoEtiqueta);
      TFile.Copy(strPathEtiquetaMarketplace, strArquivoEtiqueta);
    End;
    Exit;
  End

  Else If (strEspDoc = 'NF') and (fEhTransportadoraShopee(strCodTra)) Then
  Begin
    pLog('Etiqueta Shopee');
    If Not fValidaNotaMarketPlace(strNumDoc, strEspDoc, strCodEmp, strCodCli, PREFIX_SHOPEE) Then
    Begin
      pLog(strDocumento + ': ' + 'Não foi possível gerar a etiqueta do Shopee!', True);
      Exit(False);
    End;
    LMensagem := EmptyStr;
    Result := fDownloadEtiquetMarketplacePDF(strNumDoc, strEspDoc, strCodEmp, strCodCli, PREFIX_SHOPEE, LMensagem, strPathEtiquetaMarketplace, strMarketplaceEtiqueta, strRetornoEnvioNFeMarketplace, intMarketplaceTimeout);
    If Not Result Then
    Begin
      LMensagem := 'Não foi possível gerar a etiqueta do Shopee.' + sLineBreak + LMensagem;
      pLog(LMensagem, True);
    End
    Else
    Begin
      pLog('Copiando arquivo "' + strPathEtiquetaMarketplace + '" para "' + strArquivoEtiqueta + '"');
      If FileExists(strArquivoEtiqueta) Then
        TFile.Delete(strArquivoEtiqueta);
      TFile.Copy(strPathEtiquetaMarketplace, strArquivoEtiqueta);
    End;
    Exit;
  End

  Else If (strEspDoc = 'NF') and (fEhTransportadoraAmazon(strCodTra)) Then
  Begin
    pLog('Etiqueta Amazon');
    If Not fValidaNotaMarketPlace(strNumDoc, strEspDoc, strCodEmp, strCodCli, PREFIX_AMAZON) Then
    Begin
      pLog(strDocumento + ': ' + 'Não foi possível gerar a etiqueta do Amazon!', True);
      Exit(False);
    End;
    LMensagem := EmptyStr;
    Result := fDownloadEtiquetMarketplacePDF(strNumDoc, strEspDoc, strCodEmp, strCodCli, PREFIX_AMAZON, LMensagem, strPathEtiquetaMarketplace, strMarketplaceEtiqueta, strRetornoEnvioNFeMarketplace, intMarketplaceTimeout);
    If Not Result Then
    Begin
      LMensagem := 'Não foi possível gerar a etiqueta do Amazon.' + sLineBreak + LMensagem;
      pLog(LMensagem, True);
    End
    Else
    Begin
      pLog('Copiando arquivo "' + strPathEtiquetaMarketplace + '" para "' + strArquivoEtiqueta + '"');
      If FileExists(strArquivoEtiqueta) Then
        TFile.Delete(strArquivoEtiqueta);
      TFile.Copy(strPathEtiquetaMarketplace, strArquivoEtiqueta);
    End;
    Exit;
  End

  Else If (fUtilizaRotinaDeImpressaoDeEtiquetaDeDespachoB2WEntrega And
           fTransportadoraRealizaColetaB2WEntrega(fGetCodigoDaTransportadora(strNumDoc, strEspDoc, strCodEmp, strTabela))) Then
  Begin
    pLog('Etiqueta B2W Entrega (Direct)');
    {Identifica pedido de origem do documento de venda}
    Pedido := RetornaPedidoDocumentoVenda(strNumDoc, strEspDoc, strCodEmp);
    If fEmptyStr(Pedido.strNumDoc) Then
    Begin
      pLog(strDocumento + ': ' + 'Para gerar etiquetas de despacho B2W Entrega (Direct), é necessário que o documento seja de origem de um pedido de venda!', True);
      Exit(False);
    End;

    {Identifica Layout}
    strLayDoc := fRetornaLayoutEtiquetaDespachoB2W(Pedido.strNumDoc, Pedido.strEspDoc, Pedido.strCodEmp);

    If fEmptyStr(strLayDoc) Then
    Begin
      pLog(strDocumento + ': ' + 'O modelo da etiqueta de despacho B2W Entrega (Direct), não foi encontrado!', True);
      Exit(False);
    End;

    {Gerar PLP B2W}
    WS_SkyHub := TWS_SkyHub.Create(Pedido.strNumDoc, Pedido.strEspDoc, Pedido.strCodEmp);

    Try

      Try
        If Not WS_SkyHub.GerarPLP(LError) Then
        Begin
          pLog(strDocumento + ': ' + 'Não foi possível gerar a PLP B2W Entrega (Direct): ' + LError, True);
          Exit(False);
        End;
      Except
        On E: Exception Do
        Begin
          pLog(strDocumento + ': ' + 'Não foi possível gerar a PLP B2W Entrega (Direct)!' + #13 + 'Erro: ' + E.Message, True);
          Exit(False);
        End;
      End;

    Finally
      FreeAndNil(WS_SkyHub);
    End;

  End;

  pLog('Imprime Etiquetas Despacho PDF');
  pIniModulos(modRecMod);
  Result := fImprimeEtiquetasDespachoPDF(modRecMod,
                                         fRetornaDataHoraServidor,
                                         strLoginUsuarioLogado,
                                         VS_strCodEmp,
                                         strAcesso,
                                         strArquivoEtiqueta);

  If FileExists(strArquivoEtiqueta) Then
    pLog('Arquivo gerado com sucesso "' + strArquivoEtiqueta + '".')
  Else
    pLog('Arquivo não foi gerado "' + strArquivoEtiqueta + '".');
end;

function TfrmPrincipal_IntegracaoArmazens.fGerar_XML_(strAcesso, strNumDoc, strCodEmp, strCodTra: String): Boolean;
var
  strDiretorio : String;
  qryXML       : TUniQuery;
  strXML       : TStringList;
begin
  pLog('Gerando XML ' + strAcesso);

  Result := True;

  If fEmptyStr(strAcesso) Then
    Exit(False);

  {CITINF: NFe: Imprimir nota fiscal pelo NFeImpressão?}
  If fCfgSis('CITINF', varString, VS_strCodEmp) = 'S' Then
  Begin

    strDiretorio := fRetDiretorioArquivos(strCodEmp, strCodTra, True) + '\' + fGerarNome_XML_(strAcesso, strNumDoc, strCodEmp);

    qryXML := fCriaQuery();

    Try

      qryXML.Close;
      qryXML.SQL.Clear;
      qryXML.SQL.Add('SELECT * FROM XMLNFE WHERE NFE_ACESSO = :ACESSO');
      qryXML.ParamByName('ACESSO').AsString := strAcesso;
      qryXML.Open;

      If Not qryXML.IsEmpty Then
      Begin

        strXML := TStringList.Create;
        strXML.Text := qryXML.FieldByName('NFE_ARQXML').AsString;

        pLog('Salvando arquivo XML ' + strDiretorio);
        strXML.SaveToFile(strDiretorio);
        FreeAndNil(strXML);

      End;

    Finally
      FreeAndNil(qryXML);
    End;

  End

  Else

  {Download FIT}
  Begin
    Result := False;
  End;

end;

function TfrmPrincipal_IntegracaoArmazens.fGetSQLEtiquetas: string;
begin
  Result := '';
  Result := Result + ' SELECT                                                ';
  Result := Result + '   *                                                   ';
  Result := Result + ' FROM                                                  ';
  Result := Result + '   (SELECT                                             ';
  Result := Result + '     DATE(ARM_DTAGRA) AS `Data`,                       ';
  Result := Result + '     GER_NUMDOC AS `Documento`,                        ';
  Result := Result + '     GER_ESPDOC AS `Espécie`,                          ';
  Result := Result + '     GER_CODEMP AS `Empresa`,                          ';
  Result := Result + '     TRA_NOMTRA AS `Transportadora`,                   ';
  Result := Result + '     IF(                                               ';
  Result := Result + '       IFNULL(ARM_ETIQUE, "N") = "N",                  ';
  Result := Result + '       "Não processada",                               ';
  Result := Result + '       "Processada"                                    ';
  Result := Result + '     ) AS `Status etiqueta`,                           ';
  Result := Result + '     "N" AS `Selecionado`,                             ';
  Result := Result + '     A.AUTOINCREM                                      ';
  Result := Result + '   FROM                                                ';
  Result := Result + '     MOVGER G                                          ';
  Result := Result + '     INNER JOIN ARMFAT A                               ';
  Result := Result + '       ON (                                            ';
  Result := Result + '         A.ARM_NUMDOC = G.GER_NUMDOC                   ';
  Result := Result + '         AND A.ARM_ESPDOC = G.GER_ESPDOC               ';
  Result := Result + '         AND A.ARM_CODEMP = G.GER_CODEMP               ';
  Result := Result + '         AND A.ARM_SERIE_ = G.GER_SERIE_               ';
  Result := Result + '         AND IF(                                       ';
  Result := Result + '           A.ARM_TIP_FC = "C",                         ';
  Result := Result + '           A.ARM_FORCLI = G.GER_CODCLI,                ';
  Result := Result + '           A.ARM_FORCLI = G.GER_CODFOR                 ';
  Result := Result + '         )                                             ';
  Result := Result + '       )                                               ';
  Result := Result + '     INNER JOIN CADTRA                                 ';
  Result := Result + '       ON TRA_CODTRA = GER_CODTRA                      ';
  Result := Result + '   WHERE GER_DTAENT BETWEEN :DTAINI                    ';
  Result := Result + '     AND :DTAFIN                                       ';
  Result := Result + '   UNION                                               ';
  Result := Result + '   SELECT                                              ';
  Result := Result + '     DATE(ARM_DTAGRA) AS `Data`,                       ';
  Result := Result + '     GER_NUMDOC AS `Documento`,                        ';
  Result := Result + '     GER_ESPDOC AS `Espécie`,                          ';
  Result := Result + '     GER_CODEMP AS `Empresa`,                          ';
  Result := Result + '     TRA_NOMTRA AS `Transportadora`,                   ';
  Result := Result + '     IF(                                               ';
  Result := Result + '       IFNULL(ARM_ETIQUE, "N") = "N",                  ';
  Result := Result + '       "Não processada",                               ';
  Result := Result + '       "Processada"                                    ';
  Result := Result + '     ) AS `Status etiqueta`,                           ';
  Result := Result + '     "N" AS `Selecionado`,                             ';
  Result := Result + '     A.AUTOINCREM                                      ';
  Result := Result + '   FROM                                                ';
  Result := Result + '     NOTGER G                                          ';
  Result := Result + '     INNER JOIN ARMFAT A                               ';
  Result := Result + '       ON (                                            ';
  Result := Result + '         A.ARM_NUMDOC = G.GER_NUMDOC                   ';
  Result := Result + '         AND A.ARM_ESPDOC = G.GER_ESPDOC               ';
  Result := Result + '         AND A.ARM_CODEMP = G.GER_CODEMP               ';
  Result := Result + '         AND A.ARM_SERIE_ = G.GER_SERIE_               ';
  Result := Result + '         AND IF(                                       ';
  Result := Result + '           A.ARM_TIP_FC = "C",                         ';
  Result := Result + '           A.ARM_FORCLI = G.GER_CODCLI,                ';
  Result := Result + '           A.ARM_FORCLI = G.GER_CODFOR                 ';
  Result := Result + '         )                                             ';
  Result := Result + '       )                                               ';
  Result := Result + '     INNER JOIN CADTRA                                 ';
  Result := Result + '       ON TRA_CODTRA = GER_CODTRA                      ';
  Result := Result + '   WHERE GER_DTAENT BETWEEN :DTAINI                    ';
  Result := Result + '     AND :DTAFIN ) AS TMP                              ';
  Result := Result + '   WHERE TRUE                                          ';
end;

function TfrmPrincipal_IntegracaoArmazens.fGetSQLVendas: String;
begin

  Result := 'SELECT                                                    ' +
            '  ''MOVGER''   AS TABELA,                                 ' +
            '  A.AUTOINCREM AS AUTINC_ARMFAT,                          ' +
            '  G.AUTOINCREM AS AUTINC,                                 ' +
            '  A.ARM_PDFDAN AS DANFE,                                  ' +
            '  A.ARM_X_M_L_ AS XML,                                    ' +
            '  A.ARM_ETIQUE AS ETIQUETA,                               ' +
            '  L.NFE_ACESSO AS ACESSO,                                 ' +
            '  G.GER_NUMDOC AS NUMDOC,                                 ' +
            '  G.GER_ESPDOC AS ESPDOC,                                 ' +
            '  G.GER_CODEMP AS CODEMP,                                 ' +
            '  G.GER_CODCLI AS CODCLI,                                 ' +
            '  F.FGO_NUMPOK AS NUMPOK,                                 ' +
            '  G.GER_VOLUME AS VOLUME,                                 ' +
            '  G.GER_DTAENT AS DTAENT,                                 ' +
            '  G.GER_CODTRA AS CODTRA                                  ' +
            'FROM                                                      ' +
            '  MOVGER G                                                ' +
            '  INNER JOIN ARMFAT A ON (A.ARM_NUMDOC = G.GER_NUMDOC AND ' +
            '                          A.ARM_ESPDOC = G.GER_ESPDOC AND ' +
            '                          A.ARM_CODEMP = G.GER_CODEMP AND ' +
            '                          A.ARM_SERIE_ = G.GER_SERIE_ AND ' +
            '                          IF(A.ARM_TIP_FC = ''C'', A.ARM_FORCLI = G.GER_CODCLI, A.ARM_FORCLI = G.GER_CODFOR)) ' +

            '  INNER JOIN LOGNFE L ON (L.NFE_NUMDOC = G.GER_NUMDOC AND ' +
            '                          L.NFE_ESPDOC = G.GER_ESPDOC AND ' +
            '                          L.NFE_CODEMP = G.GER_CODEMP AND ' +
            '                          L.NFE_CODCLI = G.GER_CODCLI AND ' +
            '                          L.NFE_SERIE_ = G.GER_SERIE_)    ' +

            '  LEFT JOIN FATGOR F ON (G.GER_NUMDOC = F.FGO_NUMFAT AND ' +
            '                         G.GER_ESPDOC = F.FGO_TIPFAT AND ' +
            '                         G.GER_CODEMP = F.FGO_EMPFAT AND ' +
            '                         G.GER_CODCLI = F.FGO_CODCLI AND ' +
            '                         G.GER_TIP_FC = "C")             ' +

            'WHERE                                                     ' +
            '  A.ARM_STATUS = 0                  AND                   ' +
            '  LOCATE(G.GER_CODEMP, :CODEMP) > 0 AND                   ' +
            '  G.GER_ESPDOC = ''NF''             AND                   ' +
            '  L.NFE_STATUS = ''AT''             AND                   ' +
            '  L.NFE_ACESSO IS NOT NULL          AND                   ' +
            '  G.GER_CLAFIS > 5000                                     ' +

            'UNION ALL                                                 ' +

            'SELECT                                                    ' +
            '  ''NOTGER''  AS TABELA,                                  ' +
            '  A.AUTOINCREM AS AUTINC_ARMFAT,                          ' +
            '  G.AUTOINCREM AS AUTINC,                                 ' +
            '  A.ARM_PDFDAN AS DANFE,                                  ' +
            '  A.ARM_X_M_L_ AS XML,                                    ' +
            '  A.ARM_ETIQUE AS ETIQUETA,                               ' +
            '  L.NFE_ACESSO AS ACESSO,                                 ' +
            '  G.GER_NUMDOC AS NUMDOC,                                 ' +
            '  G.GER_ESPDOC AS ESPDOC,                                 ' +
            '  G.GER_CODEMP AS CODEMP,                                 ' +
            '  G.GER_CODCLI AS CODCLI,                                 ' +
            '  F.FGO_NUMPOK AS NUMPOK,                                 ' +
            '  G.GER_VOLUME AS VOLUME,                                 ' +
            '  G.GER_DTAENT AS DTAENT,                                 ' +
            '  G.GER_CODTRA AS CODTRA                                  ' +
            'FROM                                                      ' +
            '  NOTGER G                                                ' +
            '  INNER JOIN ARMFAT A ON (A.ARM_NUMDOC = G.GER_NUMDOC AND ' +
            '                          A.ARM_ESPDOC = G.GER_ESPDOC AND ' +
            '                          A.ARM_CODEMP = G.GER_CODEMP AND ' +
            '                          A.ARM_SERIE_ = G.GER_SERIE_ AND ' +
            '                          IF(A.ARM_TIP_FC = ''C'', A.ARM_FORCLI = G.GER_CODCLI, A.ARM_FORCLI = G.GER_CODFOR)) ' +

            '  INNER JOIN LOGNFE L ON (L.NFE_NUMDOC = G.GER_NUMDOC AND                          ' +
            '                          L.NFE_ESPDOC = G.GER_ESPDOC AND                          ' +
            '                          L.NFE_CODEMP = G.GER_CODEMP AND                          ' +
            '                          L.NFE_CODCLI = G.GER_CODCLI AND                          ' +
            '                          L.NFE_SERIE_ = G.GER_SERIE_)                             ' +

            '  LEFT JOIN FATGOR F ON (G.GER_NUMDOC = F.FGO_NUMFAT AND ' +
            '                         G.GER_ESPDOC = F.FGO_TIPFAT AND ' +
            '                         G.GER_CODEMP = F.FGO_EMPFAT AND ' +
            '                         G.GER_CODCLI = F.FGO_CODCLI AND ' +
            '                         G.GER_TIP_FC = "C")             ' +

            'WHERE                                                    ' +
            '  A.ARM_STATUS = 0                  AND ' +
            '  LOCATE(G.GER_CODEMP, :CODEMP) > 0 AND ' +
            '  G.GER_ESPDOC = ''NF''             AND ' +
            '  L.NFE_STATUS = ''AT''             AND ' +
            '  L.NFE_ACESSO IS NOT NULL          AND ' +
            '  G.GER_CLAFIS > 5000 ';
end;

function TfrmPrincipal_IntegracaoArmazens.fIncluiAtualizaVolumesCorreios(Const strAutInc,
                                                            strNumDoc,
                                                            strEspDoc,
                                                            strCodEmp,
                                                            strCodCli : String;
                                                            intVolume : Integer): Boolean;

Var
  intContador : Integer;
  strDiverg, strDivergMSG : String;
  intQtdVol   : Integer;
  blnEnviado  : Boolean;
  strJsonEnv, strJsonRet, strIdPost, strNumObj: String;

Const
  STR_MSG_NAO_INCLUIU_DOC_PLP = 'Não foi possível incluir documento na Pré Lista de Postagem!';

begin
  pLog('Comunicando com os correios ' + strNumDoc
    + '-' + strEspDoc + '-' + strCodEmp + '(inclusão dos volumes) ... ');

  If (intVolume <= 0) Then
    intVolume := 1;

  strDiverg := fDivergenciasEndereco(strNumDoc, strEspDoc, strCodEmp);

  If not fEmptyStr(strDiverg) Then
  Begin

    strDivergMSG := IIF(Pos('ENDCLI', strDiverg) > 0, 'O endereço do cliente possui mais de 50 caracteres.'    + #13, '') +
                    IIF(Pos('ENDCOM', strDiverg) > 0, 'O complemento do cliente possui mais de 30 caracteres.' + #13, '') +
                            'Favor corrigir, caso contrário será rejeitado na geração da PLP';

    pLog(strDivergMSG);
    pLogaMensagem(strAutInc, strDivergMSG, LOG_TIPO_ERRO_PROCESSAMENTO);
    Exit(False);

  End;

  {Documento já incluido em uma Pré Lista de Postagem Enviada!}
  If fDocumentoEmPLP(strNumDoc, strEspDoc, strCodEmp, blnEnviado, intQtdVol) Then
    If blnEnviado Then
      Exit(True);

  {Já foi gerado em "COROBJ" os códigos de objetos}
  If (intQtdVol >= intVolume) Then
    Exit(True);

  Try

    fStartTransaction;

    For intContador := 1 To intVolume Do
    Begin

      strJsonEnv := '';
      strJsonRet := '';
      strIdPost  := '';
      strNumObj  := '';

      If fCfgSis('USIGEP') = 'A' Then
      Begin
        Try
          If Not fEnviaPreListaPostagem(strNumDoc, strEspDoc, strCodEmp, strCodCli, fSerCorToCodCorreio(strSerCor),
                                        intVolume, strJsonEnv, strJsonRet, strIdPost, strNumObj) Then
            Break;
        Except
          On E: Exception do
            Raise Exception.Create('Não foi possível gerar a Pré Lista de Postagem! '+ E.Message);
        End;
      End;

      If Not fIncluiDocPLP(strNumDoc, strEspDoc, strCodEmp, strSerCor,
                           strJsonEnv, strJsonRet, strIdPost, strNumObj) Then
      Begin

        fRollBack;
        pLog(STR_MSG_NAO_INCLUIU_DOC_PLP);
        pLogaMensagem(strAutInc, STR_MSG_NAO_INCLUIU_DOC_PLP, LOG_TIPO_ERRO_PROCESSAMENTO);
        Break;

        Exit(False);

      End;

    End;

    Result := fCommit;

  Except
    On E : Exception Do
    Begin
      fRollBack;
      Result := False;
      pLog(E.Message);
      pLogaMensagem(strAutInc, E.Message, LOG_TIPO_ERRO_PROCESSAMENTO);
    End;
  End;

end;

procedure TfrmPrincipal_IntegracaoArmazens.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Assigned(cdsEtiquetas) then
    FreeAndNil(cdsEtiquetas);
end;

procedure TfrmPrincipal_IntegracaoArmazens.FormCreate(Sender: TObject);
begin
  Try

    Try
      pConectarModulos;
    Except
      On E: Exception Do
      Begin
        If fConexaoAtiva Then
          pLog('Erro (pConectarModulos): ' + E.Message, True)
        Else
          pMensagemOk(E.Message);
        pTerminate;
      End;
    End;

    pDefinirUsuario;
    pIniciarVariaveis;
    fAjustaDataSistema;

    If Pos(fCfgSis('USIGEP', varString, VS_strCodEmp), 'S_A_') = 0 Then
    Begin
      Self.Height := Self.Height - rdgTransportadoras.Height;
      rdgTransportadoras.Visible := False;
    End;

    pDestravaLockForcado(fGetKeyLock, 5);
    If Not fLock_Unlock(fGetKeyLock, True, False) Then
    Begin
      pMensagemOk(Self.Caption + ' já executando!');
      pTerminate;
    End;

  Except
    On E: Exception Do
    Begin
      If fConexaoAtiva Then
        pLogaMensagem('', E.Message, LOG_TIPO_INICIALIZACAO)
      Else
        pTerminate;
    End;
  End;

  {Carrega variáveis e objetos}
  untWS_SkyHub.VS_strCodEmp          := untFuncoesSimples.VS_strCodEmp;
  untWS_SkyHub.Database              := untModulo.frmModulo.GetCurrentConnection;
  untWS_SkyHub.fRetAutoIncrem        := untFuncoesSimples.fRetAutoIncrem;
  untWS_SkyHub.strLoginUsuarioLogado := untFuncoesSimples.strLoginUsuarioLogado;

  intMarketplaceTimeout := 0;

//  cdsEtiquetas.CreateDataSet;
  dtsEtiquetas.DataSet := cdsEtiquetas;

  mskDtaIni.Date := Date;
  mskDtaFin.Date := Date;

  pgcOpcoes.ActivePage := tbsMonitoramento;
end;

procedure TfrmPrincipal_IntegracaoArmazens.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    VK_F5: if pgcOpcoes.ActivePage = tbsEtiquetas then btnConsultarEtiquetas.Click;
    VK_F6: if pgcOpcoes.ActivePage = tbsEtiquetas then btnMarcarTodos.Click;
    VK_F7: if pgcOpcoes.ActivePage = tbsEtiquetas then btnDesmarcarTodos.Click;
    VK_F8: if pgcOpcoes.ActivePage = tbsEtiquetas then btnAlterarStatusSelecionados.Click;
  end;
end;

procedure TfrmPrincipal_IntegracaoArmazens.FormShow(Sender: TObject);
begin

  {Caso não pegou do .ini ([GERAL]-CODEMP)}
  If fEmptyStr(VS_strCodEmp) Then
    VS_strCodEmp := fRetEmpresa;

  sbStatus.Panels[1].Text := 'Banco: ' + frmModulo.GetCurrentConnection.Server         + ':' +
                                         IntToStr(frmModulo.GetCurrentConnection.Port) + '/' +
                                         frmModulo.GetCurrentConnection.Database;

  pCarregarConfiguracoes;
  DefinirTimeZoneEmSessaoMySql(frmModulo.GetCurrentConnection, VS_strCodEmp);
end;

function TfrmPrincipal_IntegracaoArmazens.fRetDiretorioArquivos(strCodEmp: String  = '';
                                                                strCodTra: String  = '';
                                                                blnDirTemporario : Boolean = False;
                                                                blnEtiquetaFTP   : Boolean = False;
                                                                strNumPok        : String  = ''): String;
var
  strDir           : String;
  strPatTra        : String;
  strDirTemporario : String;
begin
  strPatTra := '';
  If STR_AGRUPAR_PASTA = '2' {Empresa + Transportadora} Then
    strPatTra := fTratarNomeDiretorio(fRetNomTransportadora(strCodTra));

  If (STR_FTP_FORMA_GERACAO = GERAR_FTP_EXTERNO) Then
    Result := ExtractFilePath(Application.ExeName) + 'ARQUIVOS' + IIF(blnEtiquetaFTP, '\' + strNumPok, '')
  Else If (STR_FTP_FORMA_GERACAO = GERAR_DIR_EXTERNO) Then
  Begin
    {Organiza diretórios por empresa...}
    If (blnDirTemporario) Then
    Begin
      strDirTemporario := ExtractFilePath(Application.ExeName) + '\' + DIR_TEMPORARIO;
      If Not DirectoryExists(strDirTemporario) Then
        CreateDir(strDirTemporario);
      strDir := IIF(Not fEmptyStr(strCodEmp), strDirTemporario + '\' + strCodEmp, strDirTemporario);
      If Not DirectoryExists(strDir) Then
        CreateDir(strDir);
      If Not strPatTra.IsEmpty Then
        strDir := strDir + '\' + strPatTra;
      If Not DirectoryExists(strDir) Then
        CreateDir(strDir);
      Result := IIF(fDiretorioExiste(strDir), strDir, strDirTemporario);
    End Else
    Begin
      strDir := IIF(Not fEmptyStr(strCodEmp), STR_FTP_PASTA_EXTERNA + '\' + strCodEmp, STR_FTP_PASTA_EXTERNA);
      If Not DirectoryExists(strDir) Then
        CreateDir(strDir);
      If Not strPatTra.IsEmpty Then
        strDir := strDir + '\' + strPatTra;
      If Not DirectoryExists(strDir) Then
        CreateDir(strDir);
      Result := IIF(fDiretorioExiste(strDir), strDir, STR_FTP_PASTA_EXTERNA);
    End;
  End;
end;


function TfrmPrincipal_IntegracaoArmazens.fRetNomeEdtImprimirExeCitel: String;
begin
  Result := ExtractFilePath(Application.ExeName) + '\libEditorEtiquetas.dll';
end;

function TfrmPrincipal_IntegracaoArmazens.fRetNomeNfeImprimirExeCitel: String;
begin
  Result := ExtractFilePath(Application.ExeName) + '\NFeImpressao.exe';
end;

function TfrmPrincipal_IntegracaoArmazens.fRetornaDiretorioFTP: String;
  var
    LDiretorio : String;
begin
  LDiretorio := fCfgSis('DIRFTP', varString, VS_strCodEmp);
  Result := IIF(LDiretorio.IsEmpty, '', LDiretorio +  '\');
end;

function TfrmPrincipal_IntegracaoArmazens.fTraEnviaCorreio(strCodTra, strEmpDoc : String): Boolean;
begin

  Result := False;

  If fEmptyStr(strCodTra) Then
    Exit(False);

  If Pos(fCfgSis('USIGEP', varString, VS_strCodEmp), 'S_A_') > 0 Then
  Begin
    strSerCor := fCampoTabela('TRA_CODSER', 'CORTRA', ['TRA_CODTRA', 'TRA_CODEMP'], [strCodTra, strEmpDoc]);
    Result    := Not fEmptyStr(strSerCor);
  End
  Else If (fCfgSis('USIGEP', varString, VS_strCodEmp) = 'O') Then
  Begin
    strSerCor := fCampoTabela('TRA_TIPETQ', 'CADTRA', ['TRA_CODTRA'], [strCodTra]);
    Result    := (Pos(strSerCor, 'C_T_') > 0); //Correio ou Transportadora.

    If Result Then
      strSerCor := strCodTra;
  End;

end;

function TfrmPrincipal_IntegracaoArmazens.fUSigep(strTabela, strNumDoc, strEspDoc, strEmpDoc, strCodTra : String): Boolean;
begin

  If fEmptyStr(strTabela) Then
    Exit(False);

  If fEmptyStr(strNumDoc) Then
    Exit(False);

  If fEmptyStr(strEspDoc) Then
    Exit(False);

  If fEmptyStr(strEmpDoc) Then
    Exit(False);

  If fEmptyStr(strCodTra) Then
    Exit(False);

  If Pos(fCfgSis('USIGEP', varString, VS_strCodEmp), 'S_A_') = 0 Then
    Exit(False);

  Result := fVendaEnviaCorreio(strTabela, strNumDoc, strEspDoc, strEmpDoc, strCodTra);

end;

function TfrmPrincipal_IntegracaoArmazens.fVendaEnviaCorreio(strTabela, strNumDoc, strEspDoc, strEmpDoc, strCodTra : String): Boolean;
begin

  Result := False;

  If fEmptyStr(strEspPLP) Or (Pos(strEspDoc, strEspPLP) > 0) Then
    Result := fTraEnviaCorreio(strCodTra, strEmpDoc);

end;

procedure TfrmPrincipal_IntegracaoArmazens.mnuConfiguracoesClick(
  Sender: TObject);
begin
  btnConfiguracoes.Click;
end;

procedure TfrmPrincipal_IntegracaoArmazens.mnuEncerrarClick(Sender: TObject);
begin
  btnEncerrar.Click;
end;

procedure TfrmPrincipal_IntegracaoArmazens.mnuMonitorarClick(Sender: TObject);
begin
  TrayIcon.Visible := False;
  Show();
  WindowState := wsNormal;
  Application.BringToFront();
end;

procedure TfrmPrincipal_IntegracaoArmazens.pCarregarConfiguracoes;
begin
  BLN_FTP_UTIFTP  := (fCfgSis('UTIFTP', varString, VS_strCodEmp) = 'S');
  STR_FTP_IP      := fCfgSis('CONFTP', varString, VS_strCodEmp);
  STR_FTP_PORTA   := fCfgSis('PORFTP', varString, VS_strCodEmp);
  STR_FTP_USUARIO := fCfgSis('USUFTP', varString, VS_strCodEmp);
  STR_FTP_SENHA   := fCfgSis('SENFTP', varString, VS_strCodEmp);
  STR_EMPRESAS    := fCfgSis('EMPFTP', varString, VS_strCodEmp);
  STR_TIPO_ARQUIVOS := fCfgSis('ARQFTP', varString, VS_strCodEmp);
  STR_AGRUPAR_PASTA := fCfgSis('AGRFTP', varString, VS_strCodEmp);
  INT_INTERVALO := StrToInt(fCfgSis('INTFTP', varString, VS_strCodEmp));
  STR_FTP_FORMA_GERACAO := fCfgSis('FORFTP', varString, VS_strCodEmp);
  STR_FTP_PASTA_EXTERNA := fCfgSis('PATFTP', varString, VS_strCodEmp);
  STR_ETIQUETA_EXTENSAO := fCfgSis('ETIEXT', varString, VS_strCodEmp);
  strEspPLP := fTransform(fCfgSis('ESPPLP', varString, VS_strCodEmp), 2);
end;

function TfrmPrincipal_IntegracaoArmazens.fEnviarArquivoBancoDados(strAutInc, str_CampoBlob, strArquivo: String): Boolean;
var
  qryEnviar : TUniQuery;
  strMSG    : String;
begin

  Result := False;

  If fEmptyStr(strAutInc) Then
    Exit;

  If fEmptyStr(str_CampoBlob) Then
    Exit;

  If fEmptyStr(strArquivo) Then
    Exit;

  If Not FileExists(strArquivo) Then
    Exit;

  qryEnviar := fCriaQuery();

  Try

    qryEnviar.Close;
    qryEnviar.SQL.Add('SELECT * FROM ARMFAT WHERE AUTOINCREM = ' + QuotedStr(strAutInc));
    qryEnviar.Open;

    If Not qryEnviar.IsEmpty Then
    Begin

      qryEnviar.Edit;

      {Log}
      strMSG := IIF(STR_FTP_FORMA_GERACAO = GERAR_FTP_EXTERNO, 'Enviado FTP', 'Gerado diretório') +
                ' (' + str_CampoBlob + '): ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', fRetornaDataHoraServidor);

      If qryEnviar.FieldByName('ARM_L_O_G_').IsNull Then
        qryEnviar.FieldByName('ARM_L_O_G_').AsString := strMSG
      Else
        qryEnviar.FieldByName('ARM_L_O_G_').AsString := qryEnviar.FieldByName('ARM_L_O_G_').AsString + #13#10 + strMSG;

      TBlobField(qryEnviar.FieldByName(str_CampoBlob)).Clear;
      TBlobField(qryEnviar.FieldByName(str_CampoBlob)).LoadFromFile(strArquivo);
      qryEnviar.Post;

      Result := True;

    End;

  Finally
    FreeAndNil(qryEnviar);
  End;

end;

function TfrmPrincipal_IntegracaoArmazens.fEnviarDANFE(qryVendas: TUniQuery) : Boolean;
var
  strDirCompleto : String;
  strDirFinal    : String;
  strArquivo     : String;

  function fAguardarMontagemDoArquivo(LFile: String): Boolean;
  var
    LSize: Cardinal;
  begin
    LSize := fTamanhoArquivo(LFile);
    Sleep(200);
    Result := Not SameValue(LSize, fTamanhoArquivo(LFile));
  end;

begin

  Result := False;

  {Já gerou e enviou!}
  If (qryVendas.FieldByName(CAMPO_DANFE_ALIAS).AsString = 'S') Then
    Exit(True);

  {Se nao foi configurado para Gerar PDF DANFE}
  If Not STR_TIPO_ARQUIVOS.Contains('P') Then
    Exit(True);

  {PDF DANFE}
  strDirCompleto := fRetDiretorioArquivos(qryVendas.FieldByName('CODEMP').AsString, qryVendas.FieldByName('CODTRA').AsString, True)
    + '\' + fGerarNomeDANFE(qryVendas.FieldByName('ACESSO').AsString,
                            qryVendas.FieldByName('NUMDOC').AsString,
                            qryVendas.FieldByName('CODEMP').AsString);

  strDirFinal := fRetDiretorioArquivos(qryVendas.FieldByName('CODEMP').AsString, qryVendas.FieldByName('CODTRA').AsString)
    + '\' + fGerarNomeDANFE(qryVendas.FieldByName('ACESSO').AsString,
                            qryVendas.FieldByName('NUMDOC').AsString,
                            qryVendas.FieldByName('CODEMP').AsString);

  If fAguardarMontagemDoArquivo(strDirCompleto) Then
    Exit(False);

  pLog('Movendo arquivo DANFe para diretório final: ' + strDirFinal);

  strArquivo  := fRetornaDiretorioFTP + ExtractFileName(strDirCompleto);

  If FileExists(strDirCompleto) Then
  Begin
    Try

      If (STR_FTP_FORMA_GERACAO = GERAR_FTP_EXTERNO) Then
        IdFTP.Put(strDirCompleto, strArquivo);

      fEnviarArquivoBancoDados(qryVendas.FieldByName('AUTINC_ARMFAT').AsString,
                               CAMPO_BLOB_DANFE,
                               strDirCompleto);

      Result := fAtualizarARMFAT(CAMPO_DANFE,
                                 ARQUIVO_GERADO_ENVIADO,
                                 qryVendas.FieldByName('AUTINC_ARMFAT').AsString);

      If (Result) Then
        If (STR_FTP_FORMA_GERACAO = GERAR_FTP_EXTERNO) Then
          DeleteFile(strDirCompleto)
        Else If (STR_FTP_FORMA_GERACAO = GERAR_DIR_EXTERNO) Then
        Begin
          MoveFile(PWideChar(strDirCompleto), PWideChar(strDirFinal));
          DeleteFile(strDirCompleto);
        End;

    Except

      On E: Exception Do
      Begin

        fAtualizarARMFAT(CAMPO_DANFE,
                         ARQUIVO_INEXISTENTE,
                         qryVendas.FieldByName('AUTINC_ARMFAT').AsString);

        pLogaMensagem(qryVendas.FieldByName('AUTINC').AsString, E.Message, LOG_TIPO_ERRO_PUT_FTP);

      End;

    End;
  End;

end;

function TfrmPrincipal_IntegracaoArmazens.fEnviar_ETQ_(qryVendas: TUniQuery) : Boolean;
var
  strDirCompleto : String;
  strDirFinal    : String;
  strArquivo     : String;
  blnEtiquetaFTP : Boolean;
  strNumPok      : String;
begin

  Result := False;

  blnEtiquetaFTP := STR_ETIQUETA_EXTENSAO.Equals(ZPL_ZEBRA);
  strNumPok      := qryVendas.FieldByName('NUMPOK').AsString;

  strNumPok := strNumPok.Replace(PREFIX_MERCADO_LIVRE, '');
  strNumPok := strNumPok.Replace(PREFIX_MAGALU       , '');
  strNumPok := strNumPok.Replace(PREFIX_SHOPEE       , '');
  strNumPok := strNumPok.Replace(PREFIX_VIAVAREJO    , '');
  strNumPok := strNumPok.Replace(PREFIX_OLIST        , '');
  strNumPok := strNumPok.Replace(PREFIX_AMAZON       , '');

  {Já gerou e enviou!}
  If (qryVendas.FieldByName(CAMPO_ETIQU_ALIAS).AsString = 'S') Then
    Exit(True);

  {Se nao foi configurado para Gerar Etiqueta}
  If Not STR_TIPO_ARQUIVOS.Contains('E') Then
    Exit(True);

  {Etiqueta}
  strDirCompleto := fRetDiretorioArquivos(qryVendas.FieldByName('CODEMP').AsString, qryVendas.FieldByName('CODTRA').AsString, True, blnEtiquetaFTP, strNumPok)
    + '\' + fGerarNome_ETQ_(qryVendas.FieldByName('ACESSO').AsString,
                            qryVendas.FieldByName('NUMDOC').AsString,
                            qryVendas.FieldByName('CODEMP').AsString,
                            qryVendas.FieldByName('CODTRA').AsString);

  strDirFinal := fRetDiretorioArquivos(qryVendas.FieldByName('CODEMP').AsString, qryVendas.FieldByName('CODTRA').AsString, False, blnEtiquetaFTP, strNumPok)
    + '\' + fGerarNome_ETQ_(qryVendas.FieldByName('ACESSO').AsString,
                            qryVendas.FieldByName('NUMDOC').AsString,
                            qryVendas.FieldByName('CODEMP').AsString,
                            qryVendas.FieldByName('CODTRA').AsString);

  strArquivo := fRetornaDiretorioFTP + ExtractFileName(strDirCompleto);

  If FileExists(strDirCompleto) Then
  Begin
    pLog('Movendo arquivo etiqueta para diretório final: ' + strDirFinal);

    Try

      If (STR_FTP_FORMA_GERACAO = GERAR_FTP_EXTERNO) Then
        IdFTP.Put(strDirCompleto, strArquivo);

      fEnviarArquivoBancoDados(qryVendas.FieldByName('AUTINC_ARMFAT').AsString,
                               CAMPO_BLOB_ETIQU,
                               strDirCompleto);

      Result := fAtualizarARMFAT(CAMPO_ETIQU,
                                 ARQUIVO_GERADO_ENVIADO,
                                 qryVendas.FieldByName('AUTINC_ARMFAT').AsString);

      If (Result) Then
        If (STR_FTP_FORMA_GERACAO = GERAR_FTP_EXTERNO) Then
        Begin
          DeleteFile(strDirCompleto);

          If blnEtiquetaFTP Then
            RemoveDir(ExtractFileDir(strDirCompleto));

        End
        Else If (STR_FTP_FORMA_GERACAO = GERAR_DIR_EXTERNO) Then
        Begin
          If FileExists(strDirFinal) Then
            TFile.Delete(strDirFinal);
          MoveFile(PWideChar(strDirCompleto), PWideChar(strDirFinal));
          DeleteFile(strDirCompleto);
        End;

    Except

      On E: Exception Do
      Begin

        fAtualizarARMFAT(CAMPO_ETIQU,
                         ARQUIVO_INEXISTENTE,
                         qryVendas.FieldByName('AUTINC_ARMFAT').AsString);

        pLogaMensagem(qryVendas.FieldByName('AUTINC').AsString, E.Message, LOG_TIPO_ERRO_PUT_FTP);

      End;

    End;
  End;
end;

function TfrmPrincipal_IntegracaoArmazens.fEnviar_XML_(qryVendas: TUniQuery) : Boolean;
var
  strDirCompleto : String;
  strDirFinal    : String;
  strArquivo     : String;
begin

  Result := False;

  {Já gerou e enviou!}
  If (qryVendas.FieldByName(CAMPO_X_M_L_ALIAS).AsString = 'S') Then
    Exit(True);

  {Se nao foi configurado para Gerar XML DANFE}
  If Not STR_TIPO_ARQUIVOS.Contains('X') Then
    Exit(True);

  {XML}
  strDirCompleto := fRetDiretorioArquivos(qryVendas.FieldByName('CODEMP').AsString, qryVendas.FieldByName('CODTRA').AsString, True)
    + '\' + fGerarNome_XML_(qryVendas.FieldByName('ACESSO').AsString,
                            qryVendas.FieldByName('NUMDOC').AsString,
                            qryVendas.FieldByName('CODEMP').AsString);

  strDirFinal := fRetDiretorioArquivos(qryVendas.FieldByName('CODEMP').AsString, qryVendas.FieldByName('CODTRA').AsString)
    + '\' + fGerarNome_XML_(qryVendas.FieldByName('ACESSO').AsString,
                                                                                                         qryVendas.FieldByName('NUMDOC').AsString,
                                                                                                         qryVendas.FieldByName('CODEMP').AsString);

  strArquivo     := fRetornaDiretorioFTP + ExtractFileName(strDirCompleto);

  pLog('Movendo arquivo XML para diretório final: ' + strDirFinal);

  If FileExists(strDirCompleto) Then
  Begin
    Try

      If (STR_FTP_FORMA_GERACAO = GERAR_FTP_EXTERNO) Then
        IdFTP.Put(strDirCompleto, strArquivo);

      fEnviarArquivoBancoDados(qryVendas.FieldByName('AUTINC_ARMFAT').AsString,
                               CAMPO_BLOB_X_M_L,
                               strDirCompleto);

      Result := fAtualizarARMFAT(CAMPO_X_M_L,
                                 ARQUIVO_GERADO_ENVIADO,
                                 qryVendas.FieldByName('AUTINC_ARMFAT').AsString);

      If (Result) Then
        If (STR_FTP_FORMA_GERACAO = GERAR_FTP_EXTERNO) Then
          DeleteFile(strDirCompleto)
        Else If (STR_FTP_FORMA_GERACAO = GERAR_DIR_EXTERNO) Then
        Begin
          MoveFile(PWideChar(strDirCompleto), PWideChar(strDirFinal));
          DeleteFile(strDirCompleto);
        End;

    Except

      On E: Exception Do
      Begin

        fAtualizarARMFAT(CAMPO_X_M_L,
                         ARQUIVO_INEXISTENTE,
                         qryVendas.FieldByName('AUTINC_ARMFAT').AsString);

        pLogaMensagem(qryVendas.FieldByName('AUTINC').AsString, E.Message, LOG_TIPO_ERRO_PUT_FTP);

      End;

    End;
  End;

end;

function TfrmPrincipal_IntegracaoArmazens.fFTP_Conectar: Boolean;
begin

  Result := True;

  If (STR_FTP_FORMA_GERACAO <> GERAR_FTP_EXTERNO) Then
    Exit;

  IdFTP.Host         := STR_FTP_IP;
  IdFTP.Username     := STR_FTP_USUARIO;
  IdFTP.Password     := STR_FTP_SENHA;
  IdFTP.Port         := StrToInt(STR_FTP_PORTA);
  IdFTP.TransferType := ftBinary;
  IdFTP.Passive      := True;

  Try
    IdFTP.Connect;
  Except
    On E: Exception Do
    Begin
      pLogaMensagem('', E.Message, LOG_TIPO_ERRO_CONEXAO_FTP);
      Result := False;
    End;
  End;

end;

procedure TfrmPrincipal_IntegracaoArmazens.pExecucao;
begin
  fAjustaDataSistema;

  {Cria diretório ARQUIVOS}
  If (STR_FTP_FORMA_GERACAO = GERAR_FTP_EXTERNO) Then
    fDiretorioExiste(fRetDiretorioArquivos);

  {Cria diretório TEMP}
  If (STR_FTP_FORMA_GERACAO = GERAR_DIR_EXTERNO) Then
    fDiretorioExiste(fRetDiretorioArquivos('', '', True));

  Try
    fProcessarArquivos;
  Except
    On E: Exception Do
      pLogaMensagem('', E.Message, LOG_TIPO_ERRO_PROCESSAMENTO);
  End;
end;

procedure TfrmPrincipal_IntegracaoArmazens.pFTP_Desconectar;
begin

  If (STR_FTP_FORMA_GERACAO <> GERAR_FTP_EXTERNO) Then
    Exit;

  If IdFTP.Connected Then
    IdFTP.Disconnect;

end;

procedure TfrmPrincipal_IntegracaoArmazens.pGerarDANFES(qryVendas: TUniQuery);
begin

  If Not Assigned(qryVendas) Then
    Exit;

  If qryVendas.IsEmpty Then
    Exit;

  {Se nao foi configurado para Gerar PDF DANFE}
  If Not STR_TIPO_ARQUIVOS.Contains('P') Then
    Exit;

  Processo.MaxValue := qryVendas.RecordCount;
  Processo.Progress := 0;

  qryVendas.First;
  While Not qryVendas.Eof Do
  Begin
    pZerarTentativasLock(fGetKeyLock);

    {Se já S/N gerou, enviou/erro desconsidera!}
    If (Not fEmptyStr(qryVendas.FieldByName(CAMPO_DANFE_ALIAS).AsString))
      Or fDeveIgnorarDocumento(qryVendas) Then
    Begin
      Processo.Progress := Processo.Progress + 1;
      qryVendas.Next;
      Continue;
    End;

    fGerarDANFE(qryVendas.FieldByName('ACESSO').AsString,
                qryVendas.FieldByName('NUMDOC').AsString,
                qryVendas.FieldByName('CODEMP').AsString,
                qryVendas.FieldByName('CODTRA').AsString);

    Processo.Progress := Processo.Progress + 1;
    Application.ProcessMessages;
    qryVendas.Next;
  End;

End;

procedure TfrmPrincipal_IntegracaoArmazens.pGerar_ETIQ_(qryVendas: TUniQuery);
var
  blnGerarEtiqueta, blnUSigep : Boolean;
  CP_strCodEmp : String;
  objHubCitel  : THubCitel;
begin

  If Not Assigned(qryVendas) Then
    Exit;

  If qryVendas.IsEmpty Then
    Exit;

  {Se nao foi configurado para Gerar Etiqueta}
  If Not STR_TIPO_ARQUIVOS.Contains('E') Then
    Exit;

  Processo.MaxValue := qryVendas.RecordCount;
  Processo.Progress := 0;

  qryVendas.First;
  While Not qryVendas.Eof Do
  Begin
    pZerarTentativasLock(fGetKeyLock);

    {Se já S/N gerou, enviou/erro desconsidera!}
    If (Not fEmptyStr(qryVendas.FieldByName(CAMPO_ETIQU_ALIAS).AsString))
      Or fDeveIgnorarDocumento(qryVendas) Then
    Begin
      Processo.Progress := Processo.Progress + 1;
      qryVendas.Next;
      Continue;
    End;

    {** Hub Citel - .ZPL (Zebra) **}
    If (STR_ETIQUETA_EXTENSAO.Equals(ZPL_ZEBRA)) Then
    Begin

      objHubCitel := THubCitel.New;

      Try

        If Not objHubCitel.RetornaEtiquetaZPLHubCitel(qryVendas.FieldByName('NUMDOC').AsString,
                                                      qryVendas.FieldByName('ESPDOC').AsString,
                                                      qryVendas.FieldByName('CODEMP').AsString,
                                                      qryVendas.FieldByName('CODCLI').AsString,
                                                      qryVendas.FieldByName('ACESSO').AsString) Then
        Begin
          pLog(untHubCitel.GLog.Text, True);
        End;

      Finally
        FreeAndNil(objHubCitel);
      End;

      Processo.Progress := Processo.Progress + 1;
      qryVendas.Next;
      Continue;

    End;

    Try

      {Altera empresa logada para a geração dos códigos de objetos}
      CP_strCodEmp := VS_strCodEmp;
      VS_strCodEmp := qryVendas.FieldByName('CODEMP').AsString;

      blnGerarEtiqueta := True;

      strSerCor := '';
      blnUSigep := fUSigep(qryVendas.FieldByName('TABELA').AsString,
                           qryVendas.FieldByName('NUMDOC').AsString,
                           qryVendas.FieldByName('ESPDOC').AsString,
                           qryVendas.FieldByName('CODEMP').AsString,
                           qryVendas.FieldByName('CODTRA').AsString);

      {(SIGEP-WEB)}
      If (Pos(fCfgSis('USIGEP', varString, VS_strCodEmp), 'S_A_') > 0) And (blnUSigep) Then
        blnGerarEtiqueta := fIncluiAtualizaVolumesCorreios(qryVendas.FieldByName('AUTINC').AsString,
                                                           qryVendas.FieldByName('NUMDOC').AsString,
                                                           qryVendas.FieldByName('ESPDOC').AsString,
                                                           qryVendas.FieldByName('CODEMP').AsString,
                                                           qryVendas.FieldByName('CODCLI').AsString,
                                                           qryVendas.FieldByName('VOLUME').AsInteger);
      If (blnGerarEtiqueta) Then
        fGerar_ETQ_(qryVendas.FieldByName('ACESSO').AsString,
                    qryVendas.FieldByName('NUMDOC').AsString,
                    qryVendas.FieldByName('ESPDOC').AsString,
                    qryVendas.FieldByName('CODEMP').AsString,
                    qryVendas.FieldByName('CODCLI').AsString,
                    qryVendas.FieldByName('TABELA').AsString,
                    qryVendas.FieldByName('CODTRA').AsString,
                    qryVendas.FieldByName('VOLUME').AsInteger,
                    qryVendas.FieldByName('DTAENT').AsDateTime);

      Processo.Progress := Processo.Progress + 1;
      Application.ProcessMessages;
      qryVendas.Next;

    Finally
      VS_strCodEmp := CP_strCodEmp;
    End;

  End;

end;

procedure TfrmPrincipal_IntegracaoArmazens.pGerar_XMLS_(qryVendas: TUniQuery);
begin

  If Not Assigned(qryVendas) Then
    Exit;

  If qryVendas.IsEmpty Then
    Exit;

  {Se nao foi configurado para Gerar XML DANFE}
  If Not STR_TIPO_ARQUIVOS.Contains('X') Then
    Exit;

  Processo.MaxValue := qryVendas.RecordCount;
  Processo.Progress := 0;

  qryVendas.First;
  While Not qryVendas.Eof Do
  Begin
    pZerarTentativasLock(fGetKeyLock);

    {Se já S/N gerou, enviou/erro desconsidera!}
    If (Not fEmptyStr(qryVendas.FieldByName(CAMPO_X_M_L_ALIAS).AsString))
      Or fDeveIgnorarDocumento(qryVendas) Then
    Begin
      Processo.Progress := Processo.Progress + 1;
      qryVendas.Next;
      Continue;
    End;

    fGerar_XML_(qryVendas.FieldByName('ACESSO').AsString,
                qryVendas.FieldByName('NUMDOC').AsString,
                qryVendas.FieldByName('CODEMP').AsString,
                qryVendas.FieldByName('CODTRA').AsString);

    Processo.Progress := Processo.Progress + 1;
    Application.ProcessMessages;
    qryVendas.Next;
  End;

end;

procedure TfrmPrincipal_IntegracaoArmazens.pIniModulos(var modRecMod: TRecModulos);
begin
  modRecMod.Banco     := frmModulo.GetCurrentConnection;
  modRecMod.ModuloSpr := Nil;
end;

function TfrmPrincipal_IntegracaoArmazens.fKillProcess(pId: Cardinal): Boolean;
var
  killer: THandle;
begin
  killer := OpenProcess(PROCESS_TERMINATE, False, pId);
  Result := TerminateProcess(killer, 0);
end;

procedure TfrmPrincipal_IntegracaoArmazens.pLog(AInfo: String; blnGravaBanco : Boolean = False);
begin
  memLog.Lines.Add(FormatDateTime('hh:mm:ss', fTime()) + ' - ' + AInfo);
  If (blnGravaBanco) Then
    pLogaMensagem('', AInfo, LOG_TIPO_ERRO_PROCESSAMENTO);
end;

procedure TfrmPrincipal_IntegracaoArmazens.pLogaMensagem(strAutInc, strMSG, strTipo: String);
var
  qryLog : TUniQuery;
begin

  If fEmptyStr(strMSG) Then
    Exit;

  If fEmptyStr(strTipo) Then
    Exit;

  qryLog := fCriaQuery();

  Try

    qryLog.Close;
    qryLog.SQL.Clear;
    qryLog.SQL.Add('SELECT * FROM ARMLOG WHERE FALSE');
    qryLog.Open;

    qryLog.Insert;

    If Not fEmptyStr(strAutInc) Then
      qryLog.FieldByName('ARM_AUTINC').AsString := strAutInc;

    qryLog.FieldByName('ARM_DTAGRV').AsDateTime := fRetornaDataServidor;
    qryLog.FieldByName('ARM_HRAGRV').AsDateTime := fRetornaHoraServidor;
    qryLog.FieldByName('ARM_TIPLOG').AsString   := strTipo;
    qryLog.FieldByName('ARM_MSGLOG').AsString   := strMSG;

    qryLog.Insert;

  Finally
    FreeAndNil(qryLog);
  End;

end;

procedure TfrmPrincipal_IntegracaoArmazens.pTerminate;
begin
  if fConexaoAtiva then
  begin
    fLock_Unlock(fGetKeyLock, False, False);
    pFecharBanco(frmModulo.GetCurrentConnection);
  end;
  if not fKillProcess(GetCurrentProcessId) then
    Application.Terminate;
end;

procedure TfrmPrincipal_IntegracaoArmazens.pWinExec(ACommand: String);
begin
  pLog('Executando ' + ACommand);
  WinExec(PAnsiChar(AnsiString(ACommand)), SW_HIDE);
end;

procedure TfrmPrincipal_IntegracaoArmazens.btnDesmarcarTodosClick(
  Sender: TObject);
begin
  try
    sbStatus.Panels[0].Text := 'Aguarde ...';
    Screen.Cursor := crHourGlass;
    Application.ProcessMessages;
    cdsEtiquetas.DisableControls;
    cdsEtiquetas.First;
    while not cdsEtiquetas.Eof do
    begin
      cdsEtiquetas.Edit;
      cdsEtiquetas.FieldByName('Selecionado').AsString := 'N';
      cdsEtiquetas.Post;
      cdsEtiquetas.Next;
    end;
    cdsEtiquetas.First;
    cdsEtiquetas.EnableControls;
  finally
    sbStatus.Panels[0].Text := '';
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmPrincipal_IntegracaoArmazens.tmrMonitorTimer(Sender: TObject);
begin
  tmrMonitor.Enabled := False;
  try
    if pgcOpcoes.ActivePage = tbsMonitoramento then
      pExecucao;
  finally
    tmrMonitor.Enabled := True;
  end;
end;

end.
