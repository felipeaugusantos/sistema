unit untMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls, Uni, untInterfaces, untTLock,
  System.ImageList, Vcl.ImgList;

type
  TStatusSatIcone = (ssiIniciando, ssiIniciado, ssiParado) ;
  TfrmMenu = class(TForm)
    TrayIcon: TTrayIcon;
    PopupMenu: TPopupMenu;
    Iniciar: TMenuItem;
    Parar: TMenuItem;
    N1: TMenuItem;
    Sair: TMenuItem;
    tmrSAT: TTimer;
    Configuracoes: TMenuItem;
    ImageListIcon: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tmrSATTimer(Sender: TObject);
    procedure IniciarClick(Sender: TObject);
    procedure PararClick(Sender: TObject);
    procedure SairClick(Sender: TObject);
    procedure ConfiguracoesClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FObjLock: TLock;
    FintInc: Integer ;
    procedure pCarregaConfiguracoes;
    procedure pCarregarModulos;
    procedure pLogarErro(E: Exception);
    procedure pExecutarTarefaSAT;
    procedure pValidaConfiguracoes;
    procedure pStatusSysTrayIcone(const AssiStatus: TStatusSatIcone = ssiIniciando) ;
    function fRetornaNomeTravaIntegradorSat(): string;
    procedure pLimpaTodasTravas;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMenu: TfrmMenu;

implementation

uses untModulo, untConfiguracoes, untUtil, untLibNfe, untModuloSAT, untCfgSATCFe,
  untDicSis;

{$R *.dfm}

procedure TfrmMenu.FormCreate(Sender: TObject);
begin
  pStatusSysTrayIcone ;

  pCarregarModulos;

  If not fTabelaExiste('LOGSAT') Then
  Begin
    pMensagemOk('Integrador SAT Citel'+#13+
                'A Tabela LOGSAT não existe. Verifique!');
    Close;
  End;

  If not frmModulo.Database.Connected Then
  Begin
    pMensagemOk('Integrador SAT Citel'+#13+
                'Não foi possível conectar no banco de dados. Verifique!');
    Close;
  End;

  pSetaPidMD5DicSis(frmModulo.Database, GetCurrentProcessId, GetMacAddress);
  pSetaPidMD5DicSisLibNfe(VS_PidMD5DicSis);
  pDeletaDicSisComMaisQueUmDia(frmModulo.Database);

  FintInc := -1 ;
  tmrSAT.Enabled := true;
  pStatusSysTrayIcone(ssiIniciado) ;
end;

procedure TfrmMenu.FormDestroy(Sender: TObject);
begin
  if Assigned(FObjLock) then
    FreeAndNil(FObjLock);
end;

function TfrmMenu.fRetornaNomeTravaIntegradorSat: string;
begin
  result := 'INTEGRADORSAT_' + VS_strCodEmp + '_' + VS_NumSerSat + '_' + fNormalizaNomeImpressora(VS_ImpressoraSat) ;
end;

procedure TfrmMenu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FObjLock.fLock_Unlock(fRetornaNomeTravaIntegradorSat, False, False, False, '', True, fRetornaNomeTravaIntegradorSat);

  pDeletaDicSisPorPidMd5(frmModulo.Database);

  frmModulo.Database.Disconnect;
  FreeAndNil(frmModulo);

  If Not TerminateProcess(GetCurrentProcess, 0) Then
    Application.Terminate;
end;

procedure TfrmMenu.pCarregaConfiguracoes;
begin
  VS_strCodEmp := fArqIni(0, 'GERAL', 'EMPSAT', '', 'opcoes_integrador_sat.ini');
  VS_PathSat   := fArqIni(0, 'GERAL', 'PATSAT', '', 'opcoes_integrador_sat.ini');

  If (fEmptyStr(VS_strCodEmp) Or fEmptyStr(VS_PathSat)) Then
  Begin
    pMensagemOk('Atenção: será necessário configurar o Integrador SAT.');

    Application.CreateForm(TfrmConfiguracoes, frmConfiguracoes);

    Try
      If (frmConfiguracoes.ShowModal <> mrOk) Then
      Begin
        If Not TerminateProcess(GetCurrentProcess, 0) Then
          Application.Terminate;
      End;

      VS_strCodEmp := fArqIni(0, 'GERAL', 'EMPSAT', '', 'opcoes_integrador_sat.ini');
      VS_PathSat   := fArqIni(0, 'GERAL', 'PATSAT', '', 'opcoes_integrador_sat.ini');
    Finally
      FreeAndNil(frmConfiguracoes);
    End;
  End;

end;

procedure TfrmMenu.pValidaConfiguracoes;
var
  LstrSomenteImpressao: String ;
begin

  If not (fCfgSis('SATCIT') = 'S') Then
  Begin
    pMensagemOk('A empresa '+VS_strCodEmp+' não está configurada para usar Integrador SAT-CFe.');

    If Not TerminateProcess(GetCurrentProcess, 0) Then
      Application.Terminate;
  End;

  If (fEmptyStr(VS_PathSat)) Then
  Begin
    pMensagemOk('Por favor, configure o path para configurações do SAT-CFe.');

    If Not TerminateProcess(GetCurrentProcess, 0) Then
      Application.Terminate;
  End;

  If not fUsaSat Then
  Begin
    pMensagemOk('A empresa '+VS_strCodEmp+' não está configurada para usar SAT-CFe.');

    If Not TerminateProcess(GetCurrentProcess, 0) Then
      Application.Terminate;
  End;

  VS_NumSerSat := fArqIni(0, 'SATCFE', 'NUMERO_SERIE', '', VS_PathSat + '\opcoes_sat.ini');

  If fEmptyStr(VS_NumSerSat) Then
  Begin
    pMensagemOk('Atenção: é necessário configurar o número de série do SAT.');

    Application.CreateForm(TfrmCfgSATCFe, frmCfgSATCFe);

    Try
      If (frmCfgSATCFe.ShowModal <> mrOk) Then
      Begin
        If Not TerminateProcess(GetCurrentProcess, 0) Then
          Application.Terminate;
      End;

      VS_NumSerSat := fArqIni(0, 'SATCFE', 'NUMERO_SERIE', '', VS_PathSat + '\opcoes_sat.ini');
    Finally
      FreeAndNil(frmCfgSATCFe);
    End;
  End;

  VS_ImpressoraSat := fArqIni(0, 'SATCFE', 'IMPRESSORA', '', VS_PathSat + '\opcoes_sat.ini');
  If fEmptyStr(VS_ImpressoraSat) Then
  Begin
    pMensagemOk('Atenção: é necessário configurar o ponto de impressão do SAT.');

    Application.CreateForm(TfrmCfgSATCFe, frmCfgSATCFe);

    Try
      If (frmCfgSATCFe.ShowModal <> mrOk) Then
      Begin
        If Not TerminateProcess(GetCurrentProcess, 0) Then
          Application.Terminate;
      End;

      VS_ImpressoraSat := fArqIni(0, 'SATCFE', 'IMPRESSORA', '', VS_PathSat + '\opcoes_sat.ini');
    Finally
      FreeAndNil(frmCfgSATCFe);
    End;
  End;

  LstrSomenteImpressao := fArqIni(0, 'SATCFE', 'SOMENTE_IMPRESSAO', '', VS_PathSat + '\opcoes_sat.ini') ;
  If fEmptyStr(LstrSomenteImpressao) Then
  Begin
    pMensagemOk('Atenção: é necessário configurar "Somente Impressão" do SAT.');

    Application.CreateForm(TfrmCfgSATCFe, frmCfgSATCFe);

    Try
      If (frmCfgSATCFe.ShowModal <> mrOk) Then
      Begin
        If Not TerminateProcess(GetCurrentProcess, 0) Then
          Application.Terminate;
      End;

      VS_ImpressoraSat := fArqIni(0, 'SATCFE', 'IMPRESSORA', '', VS_PathSat + '\opcoes_sat.ini');
    Finally
      FreeAndNil(frmCfgSATCFe);
    End;
  End;
  VS_SomenteImpressao := LstrSomenteImpressao = 'S';

  FObjLock := TLock.Create ;
  If not FObjLock.fLock_Unlock(fRetornaNomeTravaIntegradorSat, True, False) Then
  Begin
    pMensagemOk('O Integrador SAT-CFe já esta aberto.'+#13+
                'Verifique o relatório de travas no Autcom.');

    If Not TerminateProcess(GetCurrentProcess, 0) Then
      Application.Terminate;
  End;
end;

procedure TfrmMenu.pCarregarModulos;
begin
  pCarregaConfiguracoes;
  pAbrirBanco(frmModulo);
  VS_LimpaTodasTravas := pLimpaTodasTravas ;
  pValidaConfiguracoes;
  TLibNfe.pCarregaConfigNFE(frmModulo.Database);
  pSetaConfiguracoesPainel(VS_confignfe);
  pCarregaConfiguracoesLib(frmModulo.Database);
end;

procedure TfrmMenu.pLimpaTodasTravas;
begin
  if not Assigned(FObjLock) then
    Exit ;

  FObjLock.pDestravarTodos(True);
  //recria a trava
  FObjLock.fLock_Unlock(fRetornaNomeTravaIntegradorSat, True, False) ;
end;

procedure TfrmMenu.pLogarErro(E: Exception);
Var
  LErro: TStringList;
begin
  LErro := TStringList.Create;
  Try
    LErro.Add('Erro: ' + E.Message);
    LErro.SaveToFile('ERRO_INTEGRADOR_SAT.TXT');
  Finally
    FreeAndNil(LErro);
  End;

  raise Exception.Create(e.Message) ;
end;

procedure TfrmMenu.pStatusSysTrayIcone(const AssiStatus: TStatusSatIcone);
begin
  TrayIcon.IconIndex := Integer(AssiStatus) ;
  if AssiStatus = ssiIniciado then
  begin
    Iniciar.Enabled := False ;
    Parar.Enabled := True ;
  end
  else if AssiStatus = ssiParado then
  begin
    Iniciar.Enabled := True ;
    Parar.Enabled := False ;
  end ;
  Application.ProcessMessages ;
end;

procedure TfrmMenu.pExecutarTarefaSAT;
var
  objModuloSAT: TModuloSAT;
begin

  objModuloSAT := TModuloSAT.Create;

  Try

    Try
      objModuloSAT.Executar;
    Finally
      objModuloSAT.Destroy;
    End;

  Except
    On E: Exception Do
      pLogarErro(E);
  End;
end;

procedure TfrmMenu.tmrSATTimer(Sender: TObject);
begin

  If InterlockedIncrement(FintInc) = 0 Then
  Begin

    tmrSAT.Enabled := False;
    Try
      pExecutarTarefaSAT;
    Finally
      InterlockedDecrement(FintInc);
      tmrSAT.Enabled := True;
    End;

  end
  else
    InterlockedDecrement(FintInc);

  Application.ProcessMessages;
end;

procedure TfrmMenu.IniciarClick(Sender: TObject);
begin
  tmrSAT.Enabled := True;
  pStatusSysTrayIcone(ssiIniciado) ;
end;

procedure TfrmMenu.PararClick(Sender: TObject);
begin
  tmrSAT.Enabled := False;
  pStatusSysTrayIcone(ssiParado) ;
end;

procedure TfrmMenu.ConfiguracoesClick(Sender: TObject);
begin
  Application.CreateForm(TfrmCfgSATCFe, frmCfgSATCFe);

  Try
    frmCfgSATCFe.ShowModal;
  Finally
    FreeAndNil(frmCfgSATCFe);
  End;
end;

procedure TfrmMenu.SairClick(Sender: TObject);
begin
  tmrSAT.Enabled := False;
  pStatusSysTrayIcone(ssiParado) ;
  pLimpaTodasTravas ;
  Close;
end;

initialization

  EnableUniSQL := False;

end.
