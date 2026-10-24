unit untCepNaoEncontrado;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, cxButtons, Vcl.StdCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Buttons, BitBtnLockedIncrem,
  Vcl.ExtCtrls, dxGDIPlusClasses, cxControls, cxContainer, cxEdit, cxImage;

type
  TfrmCepNaoEncontrado = class(TfrmPai)
    pnlPrincipal: TPanel;
    pnlMensagem: TPanel;
    lblMensagem: TLabel;
    pblTitulo: TPanel;
    lblTitulo: TLabel;
    Panel1: TPanel;
    Label1: TLabel;
    lblLinkCepExiste: TLabel;
    btnComoConsultarCepCorreios: TBitBtnLocked;
    btnComoCorrigirCepAutcom: TBitBtnLocked;
    Label3: TLabel;
    lblDescobrirCep: TLabel;
    btnComoConsultarEndereco: TBitBtnLocked;
    Panel2: TPanel;
    Label5: TLabel;
    btnSim: TBitBtnLocked;
    btnNao: TBitBtnLocked;
    cxiImagem: TcxImage;
    procedure btnSimClick(Sender: TObject);
    procedure btnNaoClick(Sender: TObject);
    procedure lblLinkCepExisteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnComoConsultarCepCorreiosClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnComoCorrigirCepAutcomClick(Sender: TObject);
    procedure btnComoConsultarEnderecoClick(Sender: TObject);
  private
    { Private declarations }
    procedure pExibirTelaComGifAnimado(const strCaption : String; const strFileName : String);
    procedure pFormShowTelaGifAnimado(Sender : TObject);
    procedure pFormKeyDownTelaGifAnimado(Sender: TObject; var Key: Word; Shift: TShiftState);
  public
    { Public declarations }
    blnContinuar : Boolean;
    class function fContinuarMesmoQueNaoTenhaEncontradoCep : Boolean;
    class function fExibirTelaInformativa : Boolean;
    class function fPathBaseGifs : String;
  end;

implementation

uses untFuncoesSimples, ShellApi, dxCore;

{$R *.dfm}

procedure TfrmCepNaoEncontrado.btnComoConsultarCepCorreiosClick(
  Sender: TObject);
begin
  pExibirTelaComGifAnimado('Cep Existe Correios', fPathBaseGifs + '\CONSULTACEP.gif');
end;

procedure TfrmCepNaoEncontrado.btnComoConsultarEnderecoClick(Sender: TObject);
begin
  inherited;
  pExibirTelaComGifAnimado('Buscar Cep Correios', fPathBaseGifs + '\CEPLOCALIDADE.gif');
end;

procedure TfrmCepNaoEncontrado.btnComoCorrigirCepAutcomClick(Sender: TObject);
begin
  inherited;
  pExibirTelaComGifAnimado('Corrigir Cep Autcom', fPathBaseGifs + '\CEPAUTCOM.gif');
end;

procedure TfrmCepNaoEncontrado.btnNaoClick(Sender: TObject);
begin
  inherited;
  blnContinuar := False;
  Close;
end;

procedure TfrmCepNaoEncontrado.btnSimClick(Sender: TObject);
begin
  inherited;
  blnContinuar := True;
  Close;
end;

class function TfrmCepNaoEncontrado.fContinuarMesmoQueNaoTenhaEncontradoCep: Boolean;
  Var
    frmCepNaoEncontrado : TfrmCepNaoEncontrado;
begin
  If (Not fExibirTelaInformativa) Then
  Begin
    Result := fMensagem('ATENÇÃO!', 'CEP não encontrado!' + #13 + 'Deseja continuar mesmo assim?', ['&Sim', '&Não'],2) = 1;
    Exit;
  End;
  pCriarFormularios(TfrmCepNaoEncontrado, frmCepNaoEncontrado);
  Try
    frmCepNaoEncontrado.ShowModal;
    Result := frmCepNaoEncontrado.blnContinuar;
  Finally
    pFreeAndNil(frmCepNaoEncontrado);
  End;
end;

class function TfrmCepNaoEncontrado.fExibirTelaInformativa: Boolean;
  Var
    strPathBaseGifs : String;
begin
  Result := False;

  strPathBaseGifs := fPathBaseGifs;

  If (Not DirectoryExists(strPathBaseGifs)) Then
    Exit;

  If (Not FileExists(strPathBaseGifs + '\CONSULTACEP.gif')) Then
    Exit;

  If (Not FileExists(strPathBaseGifs + '\CEPAUTCOM.gif')) Then
    Exit;

  If (Not FileExists(strPathBaseGifs + '\CEPLOCALIDADE.gif')) Then
    Exit;

  Result := True;
end;

procedure TfrmCepNaoEncontrado.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(btnNao);
  lblLinkCepExiste.Left := fFloatToInt(Self.Width / 2) - fFloatToInt(lblLinkCepExiste.Width / 2);
  lblDescobrirCep.Left := fFloatToInt(Self.Width / 2) - fFloatToInt(lblDescobrirCep.Width / 2);
end;

procedure TfrmCepNaoEncontrado.FormCreate(Sender: TObject);
begin
  inherited;
  blnContinuar := False;
  lblLinkCepExiste.Caption := fCfgSis('URLCEX', varString);
  If fEmptyStr(lblLinkCepExiste.Caption) Then
    lblLinkCepExiste.Caption := 'https://www2.correios.com.br/sistemas/buscacep/buscaEndereco.cfm';
  lblDescobrirCep.Caption := fCfgSis('URLBCP', varString);
  If fEmptyStr(lblDescobrirCep.Caption) Then
    lblDescobrirCep.Caption := 'https://www2.correios.com.br/sistemas/buscacep/buscaCep.cfm';
end;

class function TfrmCepNaoEncontrado.fPathBaseGifs: String;
begin
  Result := ExtractFilePath(Application.ExeName) + 'recursos';
end;

procedure TfrmCepNaoEncontrado.lblLinkCepExisteClick(Sender: TObject);
begin
  inherited;
  ShellExecute(Application.Handle, 'open', PChar(TLabel(Sender).Caption), Nil, Nil, 0);
end;

procedure TfrmCepNaoEncontrado.pFormShowTelaGifAnimado(Sender : TObject);
begin
  cxiImagem.AnimationOptions.Animation := bTrue;
  cxiImagem.AnimationOptions.AnimationLoop := bTrue;
end;

procedure TfrmCepNaoEncontrado.pFormKeyDownTelaGifAnimado(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key <> VK_Escape Then
    Exit;
  If (Not (Sender Is TForm)) Then
    Exit;
  TForm(Sender).Close;
end;

procedure TfrmCepNaoEncontrado.pExibirTelaComGifAnimado(const strCaption : String; const strFileName : String);
  Var
    frmExibirPassoAPassoGif : TfrmPai;
    objSmartImage : TdxSmartImage;
begin
  inherited;
  pCriarFormularios(TfrmPai, frmExibirPassoAPassoGif);
  Try
    objSmartImage := TdxSmartImage.Create;
    Try
      objSmartImage.LoadFromFile(strFileName);
      frmExibirPassoAPassoGif.Caption := strCaption;
      frmExibirPassoAPassoGif.Position := poMainFormCenter;
      frmExibirPassoAPassoGif.Height := 768;
      frmExibirPassoAPassoGif.Width := 1366;
      cxiImagem.Visible := True;
      cxiImagem.Parent := frmExibirPassoAPassoGif;
      cxiImagem.Align := alClient;
      cxiImagem.Picture.Graphic := objSmartImage;
      frmExibirPassoAPassoGif.OnShow := pFormShowTelaGifAnimado;
      frmExibirPassoAPassoGif.OnKeyDown := pFormKeyDownTelaGifAnimado;
      frmExibirPassoAPassoGif.ShowModal;
    Finally
      FreeAndNil(objSmartImage);
    End;
  Finally
    cxiImagem.Visible := False;
    cxiImagem.Align := alNone;
    cxiImagem.Parent := Self;
    cxiImagem.AnimationOptions.Animation := bFalse;
    cxiImagem.AnimationOptions.AnimationLoop := bFalse;
    pFreeAndNil(frmExibirPassoAPassoGif);
  End;
end;

end.
