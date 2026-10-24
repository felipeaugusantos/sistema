unit untObservacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Menus, Buttons, ExtCtrls, AppEvnts, MemoFocus,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TInputMod = (tpimNormal,     //tpimNormal = Não atera a tela,
               tpiInputQuery); //tpiInputQuery = simula a função InputQuery;}

  TfrmObservacao = class(TfrmPai)
    pnlTexto: TPanel;
    lblMensagem: TLabel;
    memObs: TMemoFocus;
    btnConfirmaDados: TBitBtnLocked;
    btnClipBoard: TBitBtnLocked;
    procedure memObsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnClipBoardClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    FUtilizarConfirmacao: Boolean;
    FConfirmou: Boolean;
    FInputMod: TInputMod;
    { Private declarations }
  public
    { Public declarations }
    property blnUtilizarConfirmacao: Boolean read FUtilizarConfirmacao write FUtilizarConfirmacao;
    property blnConfirmou: Boolean read FConfirmou write FConfirmou;
    class function fObservacao(strTitulo: string; strTexto: string;
                   intMaxLength: integer = 0; InputMod: TInputMod = tpimNormal; tamHeight: integer = 0; blnForcaBtnConfirma : Boolean = False; strTituloForm: string = ''): string;

  end;

var
  frmObservacao: TfrmObservacao;

implementation

{$R *.dfm}

uses untFuncoesSimples, untTypesSistema, untConstantes;

procedure TfrmObservacao.btnClipBoardClick(Sender: TObject);
begin
  memObs.SelectAll;
  memObs.CopyToClipboard;
  pnlInfo.Caption := 'Texto copiado! Cole através do CTRL + V';
end;

procedure TfrmObservacao.btnConfirmaDadosClick(Sender: TObject);
begin
  if Not fEmptyStr(memObs.Text) then
  begin
    if (Trim(memObs.Text)='.') Or
       (Length(memObs.Text) <= 10) then
    begin
      fMensagem('', 'É necessário que o texto seja diferente de "." e que tenha mais que 10 caracteres, ou ficar totalmente vazio. '
                  + 'Caso seja informado algum conteúdo, será usado para a Discriminação dos Serviços na NFS-e.', ['&O k']);
      Abort;
    end;
  end;
  inherited;
  FConfirmou := True;
  Close;
end;

procedure TfrmObservacao.FormActivate(Sender: TObject);
begin
  inherited;
  SetForegroundWindow(Self.Handle);
  Self.BringToFront;
end;

procedure TfrmObservacao.FormCreate(Sender: TObject);
begin
  inherited;
  FConfirmou := False;
  FUtilizarConfirmacao := False;
  FInputMod := tpimNormal;
end;

procedure TfrmObservacao.FormShow(Sender: TObject);
begin
  inherited;
  SelectFirst;
  If FInputMod = tpiInputQuery Then
    pSetFocus(memObs);
  btnConfirmaDados.Visible := FUtilizarConfirmacao;
  memObs.ReadOnly := (Not FUtilizarConfirmacao) And (FInputMod = tpimNormal);

  if not VS_ExibirMensagemAoUsuario then
  begin
    if Assigned(VS_OnMensagemAoUsuario) then
      VS_OnMensagemAoUsuario(frmObservacao.lblMensagem.Caption + sLineBreak + frmObservacao.memObs.Lines.Text);

    PostMessage(self.Handle, WM_CLOSE, 0, 0);
  end
end;

procedure TfrmObservacao.memObsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) And
     ((FInputMod = tpiInputQuery) And (Not FUtilizarConfirmacao)) And
     (Length(memObs.Lines.Text) >= memObs.MaxLength) Then
    pSetFocus(btnSair);

  If Key = VK_ESCAPE Then
    pEscapePressed;

  If (Key = Ord('A')) and (ssCtrl in Shift) then
  begin
    TMemo(Sender).SelectAll;
    Key := 0;
  end;

end;

procedure TfrmObservacao.btnSairClick(Sender: TObject);
begin
  inherited;
  If (FInputMod = tpiInputQuery) and (FUtilizarConfirmacao) Then
    memObs.Clear;
end;

class function TfrmObservacao.fObservacao(strTitulo: string; strTexto: string; intMaxLength: integer = 0; InputMod: TInputMod = tpimNormal; tamHeight: integer = 0; blnForcaBtnConfirma : Boolean = False; strTituloForm: string = ''): string;
var
  aHandle: THandle;
  wrdTexto: Word;
begin
  If Not VS_ExibirMensagemAoUsuario Then
  Begin
    If Assigned(VS_OnMensagemAoUsuario) Then
      VS_OnMensagemAoUsuario(strTitulo + ' - ' + strTexto);
    aHandle := FindWindow('TfrmAutcomSvc', Nil);
    If aHandle > 0 Then
    Begin
      wrdTexto := GlobalAddAtom(Pchar(strTitulo + ' - ' + strTexto));
      SendMessage(aHandle,CM_AVISOS,0,wrdTexto);
      GlobalDeleteAtom(wrdTexto);
    End;
    Result := EmptyStr;
    Exit;
  End;

  pCriarFormularios(TfrmObservacao, frmObservacao);
  Try
    frmObservacao.memObs.MaxLength := intMaxLength;
    frmObservacao.memObs.Lines.Text := strTexto;
    frmObservacao.lblMensagem.Caption := strTitulo;
    frmObservacao.FInputMod := InputMod;

    If strTituloForm <> '' Then
      frmObservacao.Caption  := strTituloForm;

    If InputMod = tpiInputQuery Then
    Begin
      If tamHeight = 0 Then
        frmObservacao.Height := 115 + (Trunc(intMaxLength/65) * 15)
      Else
        frmObservacao.Height := 115 + tamHeight;
      frmObservacao.FUtilizarConfirmacao := blnForcaBtnConfirma;
    End;

    frmObservacao.ShowModal;
  Finally
    fObservacao := frmObservacao.memObs.Lines.Text;
    FreeAndNil(frmObservacao);
  End;
end;

end.
