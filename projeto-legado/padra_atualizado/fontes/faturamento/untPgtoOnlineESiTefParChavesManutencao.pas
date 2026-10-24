unit untPgtoOnlineESiTefParChavesManutencao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, untPaiSimples, MemoFocus,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxProgressBar, Data.DB, MemDS, DBAccess, Uni;

type

  TAltMemoFocus = class(TMemoFocus)
  private
    procedure WMPaste(var Msg: TWMPaste); message WM_PASTE;
  end;

  TfrmPgtoOnlineESiTefParChavesManutencao = class(TfrmPaiConfirma)
    Label1: TLabel;
    gbChavePublica: TGroupBox;
    Label2: TLabel;
    btnExportar: TBitBtnLocked;
    btnGerarParChaves: TBitBtnLocked;
    SaveDialog: TSaveDialog;
    btnAlterar: TBitBtnLocked;
    btnSalvar: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnGerarParChavesClick(Sender: TObject);
    procedure btnExportarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    FstrChavePrivada: String ;
    FstrChavePublica: String ;

    procedure pCriaMemoEdit;
    function fGravarChaves: Boolean ;
    function fGerarParChaves(pgbProgresso: TcxProgressBar): Boolean;
    function fCarregarParChaves(pgbProgresso: TcxProgressBar): Boolean;
    procedure pSetaTextoProgresso(pgbProgresso: TcxProgressBar; strTexto: String);
    procedure pHabilitarComponentes(const AblnHabilitar: Boolean);
    function fValidarParChaves(const AstrChavePrivada, AstrChavePublica: String): Boolean ;
    function fTeveMudancaChave: Boolean ;
  public
    { Public declarations }
    FmeChavePrivada: TAltMemoFocus ;
    FmeChavePublica: TAltMemoFocus ;
  end;

implementation

uses
  untLibJWTUtil, Clipbrd, untFuncoesSimples, untLinkPagamentoCitelUtil;

{$R *.dfm}

function fRemoveLF(const AstrChave: String): String;
begin
  Result := AstrChave ;
  if Pos(#13, AstrChave) <= 0 then
  begin
    Result := StringReplace(AstrChave, #10, #13#10, [rfReplaceAll]);
  end;
end;

procedure TfrmPgtoOnlineESiTefParChavesManutencao.btnAlterarClick(
  Sender: TObject);
begin
  inherited;
  pHabilitarComponentes(True) ;
  pSetFocus(FmeChavePublica) ;
end;

procedure TfrmPgtoOnlineESiTefParChavesManutencao.btnExportarClick(
  Sender: TObject);
var
  LstrPath: String ;
begin
  inherited;

  if fEmptyStr(FmeChavePublica.Text) then
  begin
    fMensagem('ATENÇÃO!', 'Chave Pública não Informada!', ['&OK']);
    pSetFocus(FmeChavePublica);
    Exit ;
  end ;

  if SaveDialog.Execute then
  begin
    LstrPath := SaveDialog.Files.Strings[0] ;
    FmeChavePublica.Lines.SaveToFile(LstrPath);
    fMensagem('ATENÇÃO!', 'Arquivo gerado com sucesso!', ['&OK']);
  end ;

end;

procedure TfrmPgtoOnlineESiTefParChavesManutencao.btnGerarParChavesClick(
  Sender: TObject);
begin
  inherited;
  fChamaTelaGravando(fGerarParChaves);
end;

procedure TfrmPgtoOnlineESiTefParChavesManutencao.btnSalvarClick(
  Sender: TObject);
begin
  inherited;

  if fEmptyStr(FmeChavePrivada.Text) then
  begin
    fMensagem('ATENÇÃO!', 'Chave Privada Não Informada!', ['&OK']);
    pSetFocus(FmeChavePrivada);
    Exit ;
  end ;

  if fEmptyStr(FmeChavePublica.Text) then
  begin
    fMensagem('ATENÇÃO!', 'Chave Pública Não Informada!', ['&OK']);
    pSetFocus(FmeChavePublica);
    Exit ;
  end ;

  if fTeveMudancaChave then
    if fMensagem('ATENÇÃO!', 'Com a mudança do par de chaves será necessário atualizar a chave pública na Fiserv' + #13#10 +
                             'Deseja realmente continuar?',
                             ['&Sim', '&Não'], 2) = 2 then
      Exit;

  Screen.Cursor := crHourGlass ;
  try
    if not fValidarParChaves(FmeChavePrivada.Text, FmeChavePublica.Text) then
      Exit ;

    fGravarChaves ;

    pHabilitarComponentes(False) ;
  finally
    Screen.Cursor := crDefault ;
  end ;
end;

function TfrmPgtoOnlineESiTefParChavesManutencao.fCarregarParChaves(
  pgbProgresso: TcxProgressBar): Boolean;
begin
  pSetaTextoProgresso(pgbProgresso, 'Aguarde Carregando Par de Chaves!');
  TParChavesLinkPagamento.pCarregarChaves(FstrChavePrivada, FstrChavePublica);
  FmeChavePrivada.Text := FstrChavePrivada ;
  FmeChavePublica.Text := FstrChavePublica ;
  Result := True ;
end;

function TfrmPgtoOnlineESiTefParChavesManutencao.fGerarParChaves(
  pgbProgresso: TcxProgressBar): Boolean;
var
  LstrChavePublica, LstrChavePrivada: String ;
begin
  pSetaTextoProgresso(pgbProgresso, 'Aguarde Gerando Par de Chaves!');
  pGerarParChavesPublicoPrivado(LstrChavePrivada, LstrChavePublica);
  FmeChavePrivada.Text := fRemoveLF(LstrChavePrivada) ;
  FmeChavePublica.Text := fRemoveLF(LstrChavePublica) ;

  Result := True ;
end;

function TfrmPgtoOnlineESiTefParChavesManutencao.fGravarChaves: Boolean;
begin
  Result := False ;
  if fTeveMudancaChave then
  begin
    Result := TParChavesLinkPagamento.fSalvarChaves(Trim(FmeChavePrivada.Text), Trim(FmeChavePublica.Text));
  end ;
end;

procedure TfrmPgtoOnlineESiTefParChavesManutencao.FormCloseQuery(
  Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  if btnSalvar.Enabled then
  begin
    if fMensagem('ATENÇÃO!', 'Deseja Realmente Cancelar as Alterações?', ['&Sim', '&Não'], 2) = 2 then
    begin
      CanClose := False ;
      Exit;
    end;
  end ;
end;

procedure TfrmPgtoOnlineESiTefParChavesManutencao.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaMemoEdit ;
end;

procedure TfrmPgtoOnlineESiTefParChavesManutencao.FormShow(Sender: TObject);
begin
  inherited;
  fChamaTelaGravando(fCarregarParChaves);
  pHabilitarComponentes(False) ;
end;

function TfrmPgtoOnlineESiTefParChavesManutencao.fTeveMudancaChave: Boolean;
begin
  Result := True ;
  if Trim(FmeChavePrivada.Text) <> FstrChavePrivada then
    Exit ;

  if Trim(FmeChavePublica.Text) <> FstrChavePublica then
    Exit ;

  Result := False ;
end;

function TfrmPgtoOnlineESiTefParChavesManutencao.fValidarParChaves(
  const AstrChavePrivada, AstrChavePublica: String): Boolean;
var
  LstrMsgValidacao: String ;
begin
  Result := fValidarParChavesPublicoPrivado(AstrChavePrivada, AstrChavePublica, LstrMsgValidacao)  ;
  if not Result then
    fMensagem('ATENÇÃO!', LstrMsgValidacao, ['&OK']);
end;

procedure TfrmPgtoOnlineESiTefParChavesManutencao.pCriaMemoEdit;
begin
  FmeChavePrivada := TAltMemoFocus.Create(Self) ;
  FmeChavePrivada.Parent := Self ;
  FmeChavePrivada.Left := 8 ;
  FmeChavePrivada.Top := 31 ;
  FmeChavePrivada.Width := 394 ;
  FmeChavePrivada.Height := 290 ;
  FmeChavePrivada.ScrollBars := ssBoth ;
  FmeChavePrivada.TabOrder := 0 ;

  FmeChavePublica := TAltMemoFocus.Create(Self) ;
  FmeChavePublica.Parent := gbChavePublica ;
  FmeChavePublica.Left := 7 ;
  FmeChavePublica.Top := 23 ;
  FmeChavePublica.Width := 394 ;
  FmeChavePublica.Height := 290 ;
  FmeChavePublica.ScrollBars := ssBoth ;
  FmeChavePublica.TabOrder := 0 ;

end;

procedure TfrmPgtoOnlineESiTefParChavesManutencao.pHabilitarComponentes(
  const AblnHabilitar: Boolean);
begin
  FmeChavePrivada.ReadOnly := Not AblnHabilitar ;
  FmeChavePublica.ReadOnly := Not AblnHabilitar ;

  btnAlterar.Enabled := Not AblnHabilitar ;
  btnExportar.Enabled := Not AblnHabilitar ;

  btnGerarParChaves.Enabled := AblnHabilitar ;
  btnSalvar.Enabled := AblnHabilitar ;
end;

procedure TfrmPgtoOnlineESiTefParChavesManutencao.pSetaTextoProgresso(pgbProgresso: TcxProgressBar; strTexto: String);
begin
  If Assigned(pgbProgresso) And (GetParentForm(pgbProgresso).FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption := strTexto;
    Application.ProcessMessages;
  End;
end;

{ TAltMemoFocus }

procedure TAltMemoFocus.WMPaste(var Msg: TWMPaste);
begin
  if IsClipboardFormatAvailable(CF_TEXT) then
  begin
    Self.Text := fRemoveLF(Clipboard.AsText) ;
  end
  else
  begin
    inherited;
  end;
end;

end.
