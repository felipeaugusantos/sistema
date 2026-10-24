unit untSelBancoExt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  cxButtons, Uni, Data.DB;

type
  TfBaixarOFX = function (strCodBco : PChar; handlePrincipal: HWND; strLocalSalvarArquivo: PChar) : PChar;
  TpInicializaDevExpress = procedure;
  TpFinalizaDevExpres = procedure;

  TfrmSelBancoExt = class(TfrmPai)
    Panel1: TPanel;
    Label1: TLabel;
    btnFechar: TcxButton;
    Panel2: TPanel;
    btnBB: TcxButton;
    btnItau: TcxButton;
    btnSantander: TcxButton;
    btnSicredi: TcxButton;
    btnBradesco: TcxButton;
    procedure btnFecharClick(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure btnBradescoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnBBClick(Sender: TObject);
    procedure btnItauClick(Sender: TObject);
    procedure btnSantanderClick(Sender: TObject);
    procedure btnSicrediClick(Sender: TObject);
  private
    { Private declarations }
    pIniDX: TpInicializaDevExpress;
    pFiniDX: TpFinalizaDevExpres;
    DLLHandle : THandle;
    fBaixarOFX : TfBaixarOFX;

    function fRetornaPathBanc(strCodBco: String): String;
  public
    { Public declarations }
    strNomeArquivo :String;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmSelBancoExt.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
begin
  inherited;
    case Msg.Message of
    WM_KEYDOWN:
    begin
      if (Msg.wParam = VK_ESCAPE) then
      begin
        Msg.wParam := 0;
        Close;
      end;
    end;
  end;
end;

procedure TfrmSelBancoExt.btnFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmSelBancoExt.btnItauClick(Sender: TObject);
begin
  If not fVerificaAcessoSistema('CONEXDAAITA') then
  begin
    pMensagemOk('Operador sem direito de acesso!');
    Exit;
  end;

  strNomeArquivo := '';
  if @fBaixarOFX <> nil then
    strNomeArquivo := PChar(fBaixarOFX(PChar('341'), Application.Handle, PChar(fRetornaPathBanc('341'))));

  if strNomeArquivo <> '' then
    Close;
end;

procedure TfrmSelBancoExt.btnSantanderClick(Sender: TObject);
begin
  If not fVerificaAcessoSistema('CONEXDAASAN') then
  begin
    pMensagemOk('Operador sem direito de acesso!');
    Exit;
  end;

  strNomeArquivo := '';
  if @fBaixarOFX <> nil then
    strNomeArquivo := PChar(fBaixarOFX(PChar('033'), Application.Handle, PChar(fRetornaPathBanc('033'))));

  if strNomeArquivo <> '' then
    Close;
end;

procedure TfrmSelBancoExt.btnSicrediClick(Sender: TObject);
begin
  If not fVerificaAcessoSistema('CONEXDAASIC') then
  begin
    pMensagemOk('Operador sem direito de acesso!');
    Exit;
  end;

  strNomeArquivo := '';
  if @fBaixarOFX <> nil then
    strNomeArquivo := PChar(fBaixarOFX(PChar('748'), Application.Handle, PChar(fRetornaPathBanc('748'))));

  if strNomeArquivo <> '' then
    Close;
end;

procedure TfrmSelBancoExt.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  //Finalizando o Core do Devexpress na DLL
  if @pFiniDX <> nil then
     pFiniDX;

  //Liberando o Handle da DLL
  FreeLibrary(DLLHandle);
end;

procedure TfrmSelBancoExt.FormShow(Sender: TObject);
begin
  inherited;
  {************************************************************************
   *  Pegando o Handle da DLL, essa rotina evita ter que deixar a dll     *
   *  declarada na unit, fazendo com que o exe sempre tente encontrar a   *
   *  mesma para funcionar. Se o valor do Handle for diferente de 0,      *
   *  encontrou a dll, se for igual a 0 não encontrou.                    *
   *********************************************************KP*REQ.67959***}
  DLLHandle := LoadLibrary('libImpExtEletronico.dll');
  if DLLHandle = 0 then
  begin
    pMensagemOk('DLL para download do arquivo eletrônico não encontrada!');
    PostMessage(Self.Handle, WM_CLOSE, 0, 0);
    Exit;
  end;

  @fBaixarOFX     := GetProcAddress(DLLHandle, 'fBaixarExtratoBancario');

  //Inicializando o Core do Devexpress na DLL
  @pIniDX := GetProcAddress(DLLHandle, 'dxInitialize');
  if @pIniDX <> nil then
     pIniDX;

  @pFiniDX   := GetProcAddress(DLLHandle, 'dxFinalize');
end;

function TfrmSelBancoExt.fRetornaPathBanc(strCodBco: String): String;
var
  qryCons: TUniQuery;
begin
  Result := '';
  if strCodBco <> '' then
  begin
    qryCons := fCriaQuery();
    with qryCons do
    begin
      Sql.Clear;
      Sql.Text := 'SELECT BCO_PATEXT FROM CADBCO WHERE BCO_CODBCO = :CODBCO';
      ParambyName('CODBCO').AsString := strCodBco;

      Open;

      if not isEmpty then
        Result := FieldByName('BCO_PATEXT').AsString;
    end;

    FreeAndNil(qryCons);
  end;
end;

procedure TfrmSelBancoExt.btnBBClick(Sender: TObject);
begin
  If not fVerificaAcessoSistema('CONEXDAABRS') then
  begin
    pMensagemOk('Operador sem direito de acesso!');
    Exit;
  end;

  strNomeArquivo := '';
  if @fBaixarOFX <> nil then
    strNomeArquivo := PChar(fBaixarOFX(PChar('001'), Application.Handle, PChar(fRetornaPathBanc('001'))));

  if strNomeArquivo <> '' then
    Close;
end;

procedure TfrmSelBancoExt.btnBradescoClick(Sender: TObject);
begin
  If not fVerificaAcessoSistema('CONEXDAABRA') then
  begin
    pMensagemOk('Operador sem direito de acesso!');
    Exit;
  end;

  strNomeArquivo := '';
  if @fBaixarOFX <> nil then
    strNomeArquivo := PChar(fBaixarOFX(PChar('237'), Application.Handle, PChar(fRetornaPathBanc('237'))));

  if strNomeArquivo <> '' then
    Close;
end;

end.
