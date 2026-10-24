unit untTShopeeImportacaoCartao;

interface

uses System.Classes, Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Dialogs,
     Vcl.Controls, WinApi.Windows, Vcl.Graphics, Vcl.Buttons, System.StrUtils,
     System.SysUtils, Vcl.ComCtrls, Vcl.StdActns, System.IOUtils,

     {$IFNDEF LINUX}
     {$WARNINGS OFF}
     Vcl.FileCtrl,
     {$WARNINGS ON}
     {$ENDIF}

     BitBtnLockedIncrem, EditFocus, cxProgressBar,

     untLibCartoesGravando;
Type
  TShopeeImportacaoCartao = Class(TComponent)
    frmImportacaoCartoes: TForm;

    edtPasta: TEditFocus;
    edtCodigoEmpresa : TEditFocus;
    edtNomeEmpresa : TEditFocus;

    stlPgto   : TStringList;

    lstArquivos: TFileListBox;
    FArquivosSelecionadosLista: TStringList;

    btnPasta  : TBitBtnLocked;
    pnlFundo   : TPanel;

    dlgPasta  : TBrowseForFolder;

    pnlNenhumArquivo: TPanel;

    FArquivos: TStringList;

    procedure pGravarRegistros(var prgStatus: TcxProgressBar); virtual;
    procedure pAdicionaLinhas(var prgStatus: TcxProgressBar);  virtual;
    procedure pProcessaArquivos(strPath: String; var prgStatus: TcxProgressBar); virtual;
    procedure pDisableControls(blnDisable: Boolean);
    procedure btnConfClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnPastaClick(Sender: TObject);
    procedure ProcessaArquivosSelecionados(AArquivos: TStringList; var prgStatus: TcxProgressBar); Virtual;
    procedure edtPastaPropertieOnExit(Sender: TObject);
    procedure pOnKeyDownEdits(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodigoEmpresaKeyPress(Sender: TObject; var Key: Char);
  Private
    FAplicacao: HWND;
    FstrNomCon: String;
    FstrMenCon: String;

    FSelecionarArquivos: Boolean;
    FCodEmp: String;

    procedure PreparaFormSelecionaArquivo;
    procedure CarregaEventosGerais;
    procedure CarregaArquivos;
    function CarregaEmpresa: Boolean;
    function ValidaImportacao: Boolean;
    function CarregaArquivosSelecionados: Boolean;

    function BotaoConfirma(pgbProgresso: TcxProgressBar): Boolean;
  Public
    property Aplicacao: HWND read FAplicacao write FAplicacao;
    property strNomCon: String read FstrNomCon write FstrNomCon;
    property strMenCon: String read FstrMenCon write FstrMenCon;

    property Empresa: String read FCodEmp write FCodEmp;
    property SelecionarArquivos: Boolean read FSelecionarArquivos write FSelecionarArquivos;

    procedure pSelecionaFonte;

    Constructor Create(Owner: TComponent); override;
    Destructor Destroy; override;
  End;

  Hack = Class(TWinControl)
  End;

Var
  FPedidosNaoEncontradosNoHub: TStringList;

implementation

uses untTShopeeFuncoes, Uni, untShopeeTipos;

{ TShopeeImportacaoCartao }

function TShopeeImportacaoCartao.BotaoConfirma(
  pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := True;

  If Not ValidaImportacao Then
    Exit(False);

  VS_PastaConciliacao := AnsiReplaceStr(edtPasta.Text,'"','');

  TShopeeFuncoes.fArquivoFolder(True);
  pDisableControls(True);

  FPedidosNaoEncontradosNoHub.Clear;

  Try
    If FSelecionarArquivos Then
    Begin
      ProcessaArquivosSelecionados(FArquivosSelecionadosLista, pgbProgresso);
      Exit;
    End;

    pProcessaArquivos(AnsiReplaceStr(edtPasta.Text,'"',''), pgbProgresso);
  Finally
    pDisableControls(False);
  End;
end;

procedure TShopeeImportacaoCartao.btnConfClick(Sender: TObject);
begin
  TShopeeFuncoes.ExecutaAguarde(BotaoConfirma, 'Aguarde... Importando registros.');
end;

procedure TShopeeImportacaoCartao.btnPastaClick(Sender: TObject);
  Var
    strPasta: String;
begin
  strPasta := edtPasta.Text;
  If SelectDirectory('Selecione a pasta dos arquivos do Market Place ' + FstrNomCon, '', strPasta) Then
    edtPasta.Text := strPasta;

  CarregaArquivos;
  BringWindowToTop(FAplicacao);
  Application.BringToFront;
  frmImportacaoCartoes.BringToFront;
end;

procedure TShopeeImportacaoCartao.btnSairClick(Sender: TObject);
begin
  frmImportacaoCartoes.Close;
end;

procedure TShopeeImportacaoCartao.CarregaArquivos;
begin
  If FSelecionarArquivos Then
  Begin
    If  TShopeeFuncoes.SafeFilePath(edtPasta.text) Then
    Begin
      Try
        lstArquivos.ApplyFilePath(edtPasta.text);
        lstArquivos.Update;

        pnlNenhumArquivo.Visible := False;
        If lstArquivos.Items.Count = 0 Then
        Begin
          pnlNenhumArquivo.Visible := True;
          pnlNenhumArquivo.BringToFront;
        End;
      Except
        TShopeeFuncoes.fMensagem('ATENÇÃO','Não foi possível carregar os arquivos da pasta selecionada!'+ #13#10 +
                                           'Verifique se o caminho existe e se seu usuário possui permissão de acesso.',['&OK']);
      End;
    End;
  End;
end;

function TShopeeImportacaoCartao.CarregaArquivosSelecionados: Boolean;
  Var
    I : Integer;
begin
  Result := True;

  If lstArquivos.SelCount <= 0 Then
  Begin
    TShopeeFuncoes.fMensagem('ATENÇÃO','Selecione ao menos um arquivo para a importacao!',['&OK']);
    Result := False;
    Exit;
  End;

  FArquivosSelecionadosLista.Clear;
  For I := 0 To lstArquivos.Count - 1 Do
  Begin
    If lstArquivos.Selected[I] Then
    Begin
      FArquivosSelecionadosLista.Add(Concat(edtPasta.Text,'\',lstArquivos.Items.Strings[I]));
    End;
  End;
end;

function TShopeeImportacaoCartao.CarregaEmpresa: Boolean;
begin
  Result := True;
  FCodEmp := EmptyStr;

  If Trim(edtCodigoEmpresa.Text).Equals('') Then
  Begin
    edtNomeEmpresa.Text := '';
    TShopeeFuncoes.fMensagem('ATENÇÃO!','Preencha o codígo da empresa!',['&OK']);
    Result := False;
    Exit;
  End;

  edtNomeEmpresa.Text := TShopeeFuncoes.RetornaNomeEmpresa(edtCodigoEmpresa.Text);
  If Trim(edtNomeEmpresa.Text).Equals('') Then
  Begin
    Result := False;
    TShopeeFuncoes.fMensagem('ATENÇÃO!','Essa empresa não está cadastrada!',['&OK']);
    Exit;
  End;

  FCodEmp := edtCodigoEmpresa.Text;
end;

procedure TShopeeImportacaoCartao.CarregaEventosGerais;
  Var
    I : Integer;
begin
  For I := 0 To frmImportacaoCartoes.ComponentCount -1 Do
  Begin
    If (frmImportacaoCartoes.Components[I] Is TEditFocus) Then
    Begin
      (frmImportacaoCartoes.Components[I] As TEditFocus).OnKeyDown := pOnKeyDownEdits;
    End
  End;
end;

constructor TShopeeImportacaoCartao.Create(Owner: TComponent);
begin
  inherited;
  FArquivos  := TStringList.Create;
  FArquivosSelecionadosLista := TStringList.Create;
  stlPgto   := TStringList.Create;

  FSelecionarArquivos := VS_FuncoesExternas.fICfgSis('SHOEMP', varBoolean);

  FPedidosNaoEncontradosNoHub := TStringList.Create;
end;

destructor TShopeeImportacaoCartao.Destroy;
begin
  If Assigned(FArquivos) Then
    FreeAndNil(FArquivos);
  If Assigned(FArquivosSelecionadosLista) Then
    FreeAndNil(FArquivosSelecionadosLista);
  If Assigned(FPedidosNaoEncontradosNoHub) Then
    FreeAndNil(FPedidosNaoEncontradosNoHub);

  If Assigned(stlPgto) Then
    FreeAndNil(stlPgto);
  inherited;
end;

procedure TShopeeImportacaoCartao.edtCodigoEmpresaKeyPress(Sender: TObject; var Key: Char);
begin
  If TShopeeFuncoes.fIPesqEmpresa(frmImportacaoCartoes, edtCodigoEmpresa, edtNomeEmpresa, Key) Then
  Begin
    If CarregaEmpresa Then
      Hack(frmImportacaoCartoes).SelectNext(frmImportacaoCartoes.ActiveControl, True, True);
  End;
end;

procedure TShopeeImportacaoCartao.edtPastaPropertieOnExit(Sender: TObject);
begin
  CarregaArquivos;
end;

procedure TShopeeImportacaoCartao.pAdicionaLinhas(var prgStatus: TcxProgressBar);
begin

end;

procedure TShopeeImportacaoCartao.pDisableControls(blnDisable: Boolean);
begin
  pnlFundo.Enabled  := not blnDisable;
  edtPasta.Enabled   := not blnDisable;
  btnPasta.Enabled := not blnDisable;
end;

procedure TShopeeImportacaoCartao.pGravarRegistros(var prgStatus: TcxProgressBar);
begin

end;

procedure TShopeeImportacaoCartao.pOnKeyDownEdits(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = VK_Return) Then
  Begin
    If Trim(TEditFocus(Sender).Name).Equals('edtCodigoEmpresa') Then
    Begin
      If CarregaEmpresa Then
      Begin
        Hack(frmImportacaoCartoes).SelectNext(frmImportacaoCartoes.ActiveControl, True, True);
      End;
    End
    Else
    Begin
      Hack(frmImportacaoCartoes).SelectNext(frmImportacaoCartoes.ActiveControl, True, True);
    End;
  End;
end;

procedure TShopeeImportacaoCartao.pProcessaArquivos(strPath: String;
  var prgStatus: TcxProgressBar);
begin

end;

procedure TShopeeImportacaoCartao.PreparaFormSelecionaArquivo;
  Var
    lblMensagemSemArquivos: TLabel;
begin
  {CÓDIGO DA EMPRESA}
  edtCodigoEmpresa := TEditFocus.Create(frmImportacaoCartoes);
  edtCodigoEmpresa.Parent   := frmImportacaoCartoes;
  edtCodigoEmpresa.Left     := 8;
  edtCodigoEmpresa.Top      := 49;
  edtCodigoEmpresa.Height   := 21;
  edtCodigoEmpresa.TabOrder := 1;
  edtCodigoEmpresa.Width    := 65;
  edtCodigoEmpresa.Alignment := taLeftJustify ;
  edtCodigoEmpresa.MaxLength := 3 ;
  edtCodigoEmpresa.NormalColor := clWindow;
  edtCodigoEmpresa.FocusColor := clInfoBk;
  edtCodigoEmpresa.RequeridoColor := clRed;
  edtCodigoEmpresa.Requerido := False;
  edtCodigoEmpresa.CompZeros := True;
  edtCodigoEmpresa.TamCampo := 3;
  edtCodigoEmpresa.TipoTexto := ttNumerico;
  edtCodigoEmpresa.Text     := FCodEmp;
  edtCodigoEmpresa.Name     := 'edtCodigoEmpresa';
  edtCodigoEmpresa.OnKeyPress := edtCodigoEmpresaKeyPress;

  {NOME DA EMPRESA}
  edtNomeEmpresa := TEditFocus.Create(frmImportacaoCartoes);
  edtNomeEmpresa.Parent    := frmImportacaoCartoes;
  edtNomeEmpresa.Left      := 74;
  edtNomeEmpresa.Top       := 49;
  edtNomeEmpresa.Height    := 21;
  edtNomeEmpresa.TabOrder  := 2;
  edtNomeEmpresa.Width     := 386;
  edtNomeEmpresa.TabStop := False;
  edtNomeEmpresa.Alignment := taLeftJustify;
  edtNomeEmpresa.Color := 16768952;
  edtNomeEmpresa.ReadOnly := True;
  edtNomeEmpresa.NormalColor := 16768952;
  edtNomeEmpresa.FocusColor := clInfoBk;
  edtNomeEmpresa.RequeridoColor := clRed;
  edtNomeEmpresa.Requerido := False;
  edtNomeEmpresa.CompZeros := False;
  edtNomeEmpresa.TamCampo := 0;
  edtNomeEmpresa.TipoTexto := ttAlfanumerico;

  {LISTA DE ARQUIVOS}
  lstArquivos := TFileListBox.Create(frmImportacaoCartoes);
  lstArquivos.Parent := frmImportacaoCartoes;
  lstArquivos.Left   := 8;
  lstArquivos.Top    := 71;
  lstArquivos.Height := 127;
  lstArquivos.Width  := 452;
  lstArquivos.TabOrder := 3;
  lstArquivos.Color := clWindow;
  lstArquivos.FileType := [ftReadOnly, ftDirectory, ftNormal];
  lstArquivos.Font.Charset := ANSI_CHARSET;
  lstArquivos.Font.Color := clBlack;
  lstArquivos.Font.Height := -13;
  lstArquivos.Font.Name := 'Arial';
  lstArquivos.Font.Pitch := fpVariable;
  lstArquivos.Font.Style := [];
  lstArquivos.Font.Quality := fqClearType;
  lstArquivos.ImeName := 'Portugu'#234's (Brasil ABNT)';
  lstArquivos.Mask := '*.csv';
  lstArquivos.MultiSelect := True;
  lstArquivos.ParentFont := False;
  lstArquivos.ParentShowHint := False;
  lstArquivos.ShowGlyphs := True;
  lstArquivos.ShowHint := False;

  {MENSAGEM DE NENHUM ARQUIVO NA PASTA (PEDIDO PELO RONALDO)}
  pnlNenhumArquivo := TPanel.Create(frmImportacaoCartoes);
  pnlNenhumArquivo.Parent := frmImportacaoCartoes;
  pnlNenhumArquivo.TabStop := False;
  pnlNenhumArquivo.StyleElements := [];
  pnlNenhumArquivo.Color := clWindow;
  pnlNenhumArquivo.Top := lstArquivos.Top - 8 + (lstArquivos.Height Div 2);
  pnlNenhumArquivo.Left := lstArquivos.Left + 2;
  pnlNenhumArquivo.Width := lstArquivos.Width - 4;
  pnlNenhumArquivo.Height := 20;
  pnlNenhumArquivo.BevelOuter := bvNone;
  lblMensagemSemArquivos := TLabel.Create(pnlNenhumArquivo);
  lblMensagemSemArquivos.Parent := pnlNenhumArquivo;
  lblMensagemSemArquivos.Transparent := True;
  lblMensagemSemArquivos.Align := alClient;
  lblMensagemSemArquivos.Caption := 'Nenhum arquivo na pasta para importar';
  lblMensagemSemArquivos.Alignment := taCenter;

  edtPasta.OnExit := edtPastaPropertieOnExit;
  frmImportacaoCartoes.ClientHeight := 238;
  frmImportacaoCartoes.ClientWidth  := 465;

  CarregaEventosGerais;
  CarregaArquivos;
  CarregaEmpresa;
end;

procedure TShopeeImportacaoCartao.ProcessaArquivosSelecionados(AArquivos: TStringList;
  var prgStatus: TcxProgressBar);
begin

end;

procedure TShopeeImportacaoCartao.pSelecionaFonte;
  Var
    lblDir,
    lblInform: TLabel;
    btnSair  : TBitBtnLocked;
    btnConf  : TBitBtnLocked;

    LImagemVaziaConf,
    LImagemVaziaSair: TBitmap;
Begin
  frmImportacaoCartoes := TForm.Create(Self);
  frmImportacaoCartoes.BorderStyle  := bsSingle;
  frmImportacaoCartoes.Caption      := 'Selecione a pasta dos arquivos (' + FstrNomCon + ')';
  frmImportacaoCartoes.ClientHeight := 102;
  frmImportacaoCartoes.ClientWidth  := 472;
  frmImportacaoCartoes.Color        := 16770261;
  frmImportacaoCartoes.Position     := poScreenCenter;
  frmImportacaoCartoes.BorderIcons  := [biSystemMenu];
  frmImportacaoCartoes.Icon := TShopeeFuncoes.FIconeAplicacao;

  LImagemVaziaConf := TBitmap.Create;
  LImagemVaziaSair := TBitmap.Create;

  Try
    lblDir := TLabel.Create(frmImportacaoCartoes);
    lblDir.Parent   := frmImportacaoCartoes;
    lblDir.Left     := 8;
    lblDir.Top      := 8;
    lblDir.AutoSize := True;
    lblDir.Caption  := 'Pasta dos Arquivos';

    edtPasta := TEditFocus.Create(frmImportacaoCartoes);
    edtPasta.Parent   := frmImportacaoCartoes;
    edtPasta.Left     := 8;
    edtPasta.Top      := 27;
    edtPasta.Height   := 21;
    edtPasta.TabOrder := 0;
    edtPasta.Width    := 430;
    edtPasta.NormalColor := clWindow;
    edtPasta.FocusColor := clInfoBk;
    edtPasta.RequeridoColor := clRed;
    edtPasta.Requerido := False;
    edtPasta.Text     := TShopeeFuncoes.fArquivoFolder;

    btnPasta := TBitBtnLocked.Create(frmImportacaoCartoes);
    btnPasta.Parent   := frmImportacaoCartoes;
    btnPasta.Left     := 438;
    btnPasta.Top      := 26;
    btnPasta.Width    := 23;
    btnPasta.Height   := 23;
    btnPasta.TabOrder := 0;
    btnPasta.OnClick  := btnPastaClick;
    btnPasta.Caption  := '';
    btnPasta.Glyph.LoadFromResourceName(HInstance, 'PASTA');

    lblInform := TLabel.Create(frmImportacaoCartoes);
    lblInform.Parent   := frmImportacaoCartoes;
    lblInform.Left     := 0;
    lblInform.Top      := 49;
    lblInform.AutoSize := False;
    lblInform.Width    := frmImportacaoCartoes.Width;
    lblInform.Alignment:= taCenter;
    lblInform.Caption  := FstrMenCon;

    pnlFundo := TPanel.Create(frmImportacaoCartoes);
    pnlFundo.Parent   := frmImportacaoCartoes;
    pnlFundo.Align    := alBottom;
    pnlFundo.Height   := 28;
    pnlFundo.Color    := clGray;
    pnlFundo.TabOrder := 1;

    btnSair := TBitBtnLocked.Create(frmImportacaoCartoes);
    btnSair.Parent   := pnlFundo;
    btnSair.Left     := 390;
    btnSair.Top      := 2;
    btnSair.Width    := 72;
    btnSair.Height   := 24;
    btnSair.TabOrder := 1;
    btnSair.OnClick  := btnSairClick;
    btnSair.Kind     := bkClose;
    btnSair.Caption  := '&Sair';
    btnSair.Cancel   := True;
    btnSair.Glyph    := LImagemVaziaSair;

    btnConf := TBitBtnLocked.Create(frmImportacaoCartoes);
    btnConf.Parent   := pnlFundo;
    btnConf.Left     := 5;
    btnConf.Top      := 2;
    btnConf.Width    := 72;
    btnConf.Height   := 24;
    btnConf.TabOrder := 0;
    btnConf.OnClick  := btnConfClick;
    btnConf.Default  := Not FSelecionarArquivos;
    btnConf.Caption  := '&Importar';
    btnConf.Glyph    := LImagemVaziaConf;

    If FSelecionarArquivos Then
      PreparaFormSelecionaArquivo;

    frmImportacaoCartoes.ShowModal;
  Finally
    FreeAndNil(LImagemVaziaConf);
    FreeAndNil(LImagemVaziaSair);

    FreeAndNil(frmImportacaoCartoes);
  End;
end;

function TShopeeImportacaoCartao.ValidaImportacao: Boolean;
  Var
    LMsgConfirma : String;
begin
  Result := True;

  If (Trim(edtPasta.Text) = '') Or (Not TShopeeFuncoes.SafeFilePath(edtPasta.Text)) Then
  Begin
    TShopeeFuncoes.fMensagem('ATENÇÃO!','É necessário selecionar uma pasta válida!',['&OK']);
    Result := False;
    Exit;
  End;

  If Not FSelecionarArquivos Then
    Exit;

  If Not CarregaEmpresa Then
    Result := False
  Else If Not CarregaArquivosSelecionados Then
    Result := False
  Else
  Begin
    LMsgConfirma := Concat('Confirma a importação do(s) arquivo(s) selecionado(s) para a empresa ',edtCodigoEmpresa.Text,' - ',edtNomeEmpresa.Text,' ?');

    If TShopeeFuncoes.fMensagem('ATENÇÃO!', LMsgConfirma, ['&Sim', '&Não'],1) = 2 Then
      Result := False;
  End;
end;

end.
