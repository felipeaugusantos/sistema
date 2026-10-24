unit untTRedeCardImportacaoCartao;

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
  TRedeCardImportacaoCartao = Class(TComponent)
    frmImportacaoCartoes: TForm;

    edtPasta: TEditFocus;
    edtCodigoEmpresa : TEditFocus;
    edtNomeEmpresa : TEditFocus;

    lstArquivos: TFileListBox;

    btnPasta  : TBitBtnLocked;
    pnlFundo   : TPanel;

    dlgPasta  : TBrowseForFolder;

    procedure pGravarRegistros(var prgStatus: TcxProgressBar); virtual;
    procedure pAdicionaLinhas;  virtual;
    procedure pDisableControls(blnDisable: Boolean);
    procedure pProcessaArquivos(strPath: String; var prgStatus: TcxProgressBar); virtual;
    procedure btnConfClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnPastaClick(Sender: TObject);
    procedure ProcessaArquivosSelecionados(AAquivos: TStringList); Virtual;
    procedure edtPastaPropertieOnExit(Sender: TObject);
    procedure pOnKeyDownEdits(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodigoEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure btnHelpClick(Sender: TObject);
  Private
    FAplicacao: HWND;
    FstrNomCon: String;
    FstrMenCon: String;

    LArquivos: TStringList;
    LSelecionarArquivos: Boolean;
    LCodEmp: String;

    stlPgto   : TStringList;
    stlCredito: TStringList;

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

    property Empresa: String read LCodEmp write LCodEmp;
    property SelecionarArquivos: Boolean read LSelecionarArquivos write LSelecionarArquivos;

    procedure pSelecionaFonte;

    Constructor Create(Owner: TComponent); override;
    Destructor Destroy; override;
  End;

  Hack = Class(TWinControl)
  End;

implementation

uses untTRedeCardFuncoes, Uni, untRedeCardTipos, untRedeCardMemoInfoImportacao;

{ TRedeCardImportacaoCartao }

function TRedeCardImportacaoCartao.BotaoConfirma(
  pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := True;

  If Not ValidaImportacao Then
    Exit(False);

  VS_PastaConciliacao := AnsiReplaceStr(edtPasta.Text,'"','');

  TRedeCardFuncoes.fArquivoFolder(True);
  pDisableControls(True);

  If LSelecionarArquivos Then
    ProcessaArquivosSelecionados(LArquivos)
  Else
    pProcessaArquivos(AnsiReplaceStr(edtPasta.Text,'"',''), pgbProgresso);

  pDisableControls(False);
end;

procedure TRedeCardImportacaoCartao.btnConfClick(Sender: TObject);
begin
  TRedeCardFuncoes.ExecutaAguarde(BotaoConfirma, 'Aguarde... Importando registros.');
end;

procedure TRedeCardImportacaoCartao.btnPastaClick(Sender: TObject);
  Var
    strPasta: String;
begin
  strPasta := edtPasta.Text;
  If SelectDirectory('Selecione a pasta dos arquivos da operadora ' + FstrNomCon, '', strPasta) Then
    edtPasta.Text := strPasta;

  CarregaArquivos;
  BringWindowToTop(FAplicacao);
  Application.BringToFront;
  frmImportacaoCartoes.BringToFront;
end;

procedure TRedeCardImportacaoCartao.btnSairClick(Sender: TObject);
begin
  frmImportacaoCartoes.Close;
end;

procedure TRedeCardImportacaoCartao.CarregaArquivos;
begin
  If LSelecionarArquivos Then
  Begin
    If  TRedeCardFuncoes.SafeFilePath(edtPasta.text) Then
    Begin
      Try
        lstArquivos.ApplyFilePath(edtPasta.text);
        lstArquivos.Update;
      Except
        TRedeCardFuncoes.fMensagem('ATENÇÃO','Não foi possível carregar os arquivos da pasta selecionada!'+ #13#10 +
                                             'Verifique se o caminho existe e se seu usuário possui permissão de acesso.',['&OK']);
      End;
    End;
  End;
end;

function TRedeCardImportacaoCartao.CarregaArquivosSelecionados: Boolean;
  Var
    I : Integer;
begin
  Result := True;

  If lstArquivos.SelCount <= 0 Then
  Begin
    TRedeCardFuncoes.fMensagem('ATENÇÃO','Selecione ao menos um arquivo para a importacao!',['&OK']);
    Result := False;
    Exit;
  End;

  LArquivos.Clear;
  For I := 0 To lstArquivos.Count - 1 Do
  Begin
    If lstArquivos.Selected[I] Then
    Begin
      LArquivos.Add(Concat(edtPasta.Text,'\',lstArquivos.Items.Strings[I]));
    End;
  End;
end;

function TRedeCardImportacaoCartao.CarregaEmpresa: Boolean;
begin
  Result := True;
  LCodEmp := '';

  {$IF Defined(VER180)}
  {$ELSE}
  If Trim(edtCodigoEmpresa.Text).Equals('') Then
  Begin
    edtNomeEmpresa.Text := '';
    TRedeCardFuncoes.fMensagem('ATENÇÃO!','Preencha o codígo da empresa!',['&OK']);
    Result := False;
    Exit;
  End;

  edtNomeEmpresa.Text := TRedeCardFuncoes.RetornaNomeEmpresa(edtCodigoEmpresa.Text);
  If Trim(edtNomeEmpresa.Text).Equals('') Then
  Begin
    Result := False;
    TRedeCardFuncoes.fMensagem('ATENÇÃO!','Essa empresa não está cadastrada!',['&OK']);
    Exit;
  End;

  LCodEmp := edtCodigoEmpresa.Text;
  {$IFEND}
end;

procedure TRedeCardImportacaoCartao.CarregaEventosGerais;
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

constructor TRedeCardImportacaoCartao.Create(Owner: TComponent);
begin
  inherited;
  stlPgto   := TStringList.Create;
  stlCredito:= TStringList.Create;

  LArquivos  := TStringList.Create;
end;

destructor TRedeCardImportacaoCartao.Destroy;
begin
  If Assigned(stlPgto) Then
    FreeAndNil(stlPgto);
  If Assigned(stlCredito) Then
    FreeAndNil(stlCredito);
  If Assigned(LArquivos) Then
    FreeAndNil(LArquivos);
  inherited;
end;

procedure TRedeCardImportacaoCartao.edtCodigoEmpresaKeyPress(Sender: TObject; var Key: Char);
begin
  If TRedeCardFuncoes.fIPesqEmpresa(frmImportacaoCartoes, edtCodigoEmpresa, edtNomeEmpresa, Key) Then
  Begin
    If CarregaEmpresa Then
      Hack(frmImportacaoCartoes).SelectNext(frmImportacaoCartoes.ActiveControl, True, True);
  End;
end;

procedure TRedeCardImportacaoCartao.edtPastaPropertieOnExit(Sender: TObject);
begin
  CarregaArquivos;
end;

procedure TRedeCardImportacaoCartao.pAdicionaLinhas;
begin

end;

procedure TRedeCardImportacaoCartao.pDisableControls(blnDisable: Boolean);
begin
  pnlFundo.Enabled  := not blnDisable;
  edtPasta.Enabled   := not blnDisable;
  btnPasta.Enabled := not blnDisable;
end;

procedure TRedeCardImportacaoCartao.pGravarRegistros(var prgStatus: TcxProgressBar);
begin

end;

procedure TRedeCardImportacaoCartao.pOnKeyDownEdits(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  {$IF Defined(VER180)}
  {$ELSE}
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
  {$IFEND}
end;

procedure TRedeCardImportacaoCartao.pProcessaArquivos(strPath: String; var prgStatus: TcxProgressBar);
begin

end;

procedure TRedeCardImportacaoCartao.PreparaFormSelecionaArquivo;
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
  edtCodigoEmpresa.Text     := LCodEmp;
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
  lstArquivos.Height := 97;
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
  {$IF Defined(VER180)}
  {$ELSE}
  lstArquivos.Font.Quality := fqClearType;
  {$IFEND}
  lstArquivos.ImeName := 'Portugu'#234's (Brasil ABNT)';
  lstArquivos.Mask := '*.csv';
  lstArquivos.MultiSelect := True;
  lstArquivos.ParentFont := False;
  lstArquivos.ParentShowHint := False;
  lstArquivos.ShowGlyphs := True;
  lstArquivos.ShowHint := False;

  edtPasta.OnExit := edtPastaPropertieOnExit;
  frmImportacaoCartoes.ClientHeight := 238;
  frmImportacaoCartoes.ClientWidth  := 465;

  CarregaEventosGerais;
  CarregaArquivos;
  CarregaEmpresa;
end;

procedure TRedeCardImportacaoCartao.ProcessaArquivosSelecionados(AAquivos: TStringList);
begin

end;

procedure TRedeCardImportacaoCartao.pSelecionaFonte;
  Var
    lblDir,
    lblInform: TLabel;
    btnSair  : TBitBtnLocked;
    btnConf  : TBitBtnLocked;
    btnHelp: TBitBtnLocked;

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
  frmImportacaoCartoes.Icon.LoadFromStream(VS_FuncoesExternas.fIGetIconApplication);

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
    edtPasta.Text     := TRedeCardFuncoes.fArquivoFolder;

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
    btnSair.Left     := 397;
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
    btnConf.Default  := True;
    btnConf.Caption  := '&Importar';
    btnConf.Glyph    := LImagemVaziaConf;

    btnHelp := TBitBtnLocked.Create(frmImportacaoCartoes);
    btnHelp.Parent   := pnlFundo;
    btnHelp.Left     := 80;
    btnHelp.Top      := 2;
    btnHelp.Width    := 30;
    btnHelp.Height   := 24;
    btnHelp.Hint     := 'Clique aqui para exibir a instrução sobre esta rotina.';
    btnHelp.ShowHint := True;
    btnHelp.TabOrder := 1;
    btnHelp.OnClick  := btnHelpClick;
    btnHelp.Default  := False;
    btnHelp.Caption  := '';
    btnHelp.Glyph.LoadFromResourceName(HInstance, 'HELP');
    btnHelp.Visible  := True;

    If LSelecionarArquivos Then
      PreparaFormSelecionaArquivo;

    frmImportacaoCartoes.ShowModal;
  Finally
    FreeAndNil(LImagemVaziaConf);
    FreeAndNil(LImagemVaziaSair);

    FreeAndNil(frmImportacaoCartoes);
  End;
end;

function TRedeCardImportacaoCartao.ValidaImportacao: Boolean;
  Var
    LMsgConfirma : String;
begin
  Result := True;

  If (Trim(edtPasta.Text) = '') Or (Not TRedeCardFuncoes.SafeFilePath(edtPasta.Text)) Then
  Begin
    TRedeCardFuncoes.fMensagem('ATENÇÃO!','É necessário selecionar uma pasta válida!',['&OK']);
    Result := False;
    Exit;
  End;

  If Not LSelecionarArquivos Then
    Exit;

  If Not CarregaEmpresa Then Result := False
  Else If Not CarregaArquivosSelecionados Then Result := False
  Else
  Begin
    LMsgConfirma := Concat('Confirma a importação do(s) arquivo(s) selecionado(s) para a empresa ',edtCodigoEmpresa.Text,' - ',edtNomeEmpresa.Text,' ?');

    If TRedeCardFuncoes.fMensagem('ATENÇÃO!', LMsgConfirma, ['&Sim', '&Não'],1) = 2 Then
      Result := False;
  End;
end;

procedure TRedeCardImportacaoCartao.btnHelpClick(Sender: TObject);
  Var
    LMemoInfo: TfrmRedeCardMemoInfoImportacao;
begin
  TRedeCardFuncoes.pCriarFormularios(TfrmRedeCardMemoInfoImportacao, LMemoInfo);
  Try
    LMemoInfo.lblTitulo.Caption := 'Conciliação de Cartões de Crédito (REDECARD)';
    LMemoInfo.edtInfo.Lines.Clear;
    LMemoInfo.edtInfo.Lines.Add(#9 + 'Para realizar a conciliação automática da RedeCard é necessário importar ' +
                                'todos os arquivos do RV que está sendo conciliado. Os arquivos que deverão ser importados são:');
    LMemoInfo.edtInfo.Lines.Add(#9 + 'EEFI - Resumo Financeiro');
    LMemoInfo.edtInfo.Lines.Add(#9 + 'EEVD - Registos de Venda a Débito');
    LMemoInfo.edtInfo.Lines.Add(#9 + 'EEVC - Registro de Vendas a Crédito');
    LMemoInfo.edtInfo.Lines.Add(EmptyStr);
    LMemoInfo.edtInfo.Lines.Add(#9 + 'Ao importar os arquivos EEVD, o Autcom não necessita de outros arquivos para fazer a conciliação, ' +
                                'pois no arquivo já possui todos os dados da venda. Mas, ao importar os arquivos EEFI, cada registro ' +
                                'necessita que os registros de venda estejam nos arquivos EEVC importados.');
    LMemoInfo.edtInfo.Lines.Add(EmptyStr);
    LMemoInfo.edtInfo.Lines.Add(#9 + 'Na importação dos arquivos, ao importar os registros dos arquivos EEFI e neles possuir RVs faltando ' +
                                'informações, o Autcom exibirá um relatório de inconsistências. No relatório exibirá o nome do arquivo ' +
                                'EEFI e os RVs que estão faltando registros.');
    LMemoInfo.edtInfo.Lines.Add(EmptyStr);
    LMemoInfo.edtInfo.Lines.Add(#9 + 'Ao realizar a conciliação automática e, no período selecionado, possuir RVs falando informações, ' +
                                'o Autcom gerará um relatório de inconsistências exibindo esses RVs antes de conciliar os registros.');
    LMemoInfo.edtInfo.Lines.Add(EmptyStr);
    LMemoInfo.edtInfo.Lines.Add(#9 + 'Depois a conciliação continua em seu processo normal.');

    LMemoInfo.ShowModal;
  Finally
    FreeAndNil(LMemoInfo);
  End;
end;

end.
