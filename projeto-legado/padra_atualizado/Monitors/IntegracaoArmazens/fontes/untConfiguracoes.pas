unit untConfiguracoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, LabeledEditFocus, Data.DB, MemDS, DBAccess,
  Uni, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  DateEditFocus, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdFTP;

type
  TfrmConfiguracoes = class(TForm)
    btnSair: TBitBtnLocked;
    grbFTP: TGroupBox;
    edtIP: TLabeledEditFocus;
    edtPorta: TLabeledEditFocus;
    edtUsuario: TLabeledEditFocus;
    edtSenha: TLabeledEditFocus;
    edtEmpresas: TLabeledEditFocus;
    IdFTP: TIdFTP;
    btnTesteConexao: TBitBtnLocked;
    edtIntervalo: TLabeledEditFocus;
    rdgFormaGeracao: TRadioGroup;
    edtPastaExterna: TLabeledEditFocus;
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnTesteConexaoClick(Sender: TObject);
  private
    { Private declarations }
    procedure pLimparCampos;
    function fValidaCamposConexao : Boolean;
  public
    { Public declarations }
  end;

var
  frmConfiguracoes: TfrmConfiguracoes;

implementation

uses
  untPrincipal, untFuncoesSimples;

{$R *.dfm}

procedure TfrmConfiguracoes.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmConfiguracoes.btnTesteConexaoClick(Sender: TObject);
begin

  If Not fValidaCamposConexao Then
    Exit;

  IdFTP.Host     := edtIP.Text;
  IdFTP.Username := edtUsuario.Text;
  IdFTP.Password := edtSenha.Text;
  IdFTP.Port     := StrToInt(edtPorta.Text);

  Try

    Screen.Cursor := crHourGlass;

    Try
      IdFTP.Connect;
      fMensagem('Atenção!', 'Conectado com sucesso!', ['&OK']);
    Finally
      Screen.Cursor := crDefault;
    End;

  Except
    On e: Exception Do
      fMensagem('Atenção!', 'Erro: ' + E.Message, ['&OK']);
  End;

end;

procedure TfrmConfiguracoes.FormCreate(Sender: TObject);
begin
  pLimparCampos;
end;

procedure TfrmConfiguracoes.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  If (Key = VK_RETURN) Then
    SelectNext(ActiveControl, True, True);

end;

procedure TfrmConfiguracoes.pLimparCampos;
begin
  edtIP.Clear;
  edtPorta.Clear;
  edtUsuario.Clear;
  edtSenha.Clear;
  edtEmpresas.Clear;
end;

function TfrmConfiguracoes.fValidaCamposConexao : Boolean;
Var
  intValor : Integer;
begin

  Result := True;

  If fEmptyStr(edtIP.Text) Then
  Begin
    fMensagem('Atenção!', 'Informe o IP em configurações do Autcom!', ['&OK']);
    Exit(False);
  End;

  If Not TryStrToInt(edtPorta.Text, intValor) Then
  Begin
    fMensagem('Atenção!', 'Porta inválida!', ['&OK']);
    Exit(False);
  End;

  If fEmptyStr(edtUsuario.Text) Then
  Begin
    fMensagem('Atenção!', 'Informe o usuário em configurações do Autcom!', ['&OK']);
    Exit(False);
  End;

  If fEmptyStr(edtSenha.Text) Then
  Begin
    fMensagem('Atenção!', 'Informe a senha em configurações do Autcom!', ['&OK']);
    Exit(False);
  End;

end;

end.
