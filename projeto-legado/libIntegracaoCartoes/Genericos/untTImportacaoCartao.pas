{****************************************}
{* Classe para a Importação de Arquivos *}
{*************************************AJ*}
unit untTImportacaoCartao;

interface

uses Classes, Forms, BitBtnLockedIncrem, StdCtrls, ExtCtrls, Dialogs,
  Controls, Windows, Graphics, Buttons, StrUtils, SysUtils, ComCtrls,
  StdActns,EditFocus,
  {$WARN UNIT_PLATFORM OFF}
  FileCtrl;
  {$WARN UNIT_PLATFORM ON}


Type
  TImportacaoCartao = Class(TComponent)
    frmForm   : TForm;
    pgbProg   : TProgressBar;
    edtDir    : TEditFocus;
    edtCodEmp : TEditFocus;
    edtNomEmp : TEditFocus;
    lstArquivos: TFileListBox;
    btnPasta  : TBitBtnLocked;
    pnlFund   : TPanel;

    stlPgto   : TStringList;
    stlCredito: TStringList;

    dlgPasta  : TBrowseForFolder;

    lblInform: TLabel;

    procedure pGravarRegistros; virtual;
    procedure pAdicionaLinhas;  virtual;
    procedure pDisableControls(blnDisable: Boolean);
    procedure pProcessaArquivos(strPath: String); virtual;
    procedure btnConfClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnPastaClick(Sender: TObject);
    procedure ProcessaArquivosSelecionados(AAquivos: TStringList); Virtual;
    procedure edtDirPropertieOnExit(Sender: TObject);
    procedure pOnKeyDownEdits(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);

    {$IF Defined(VER180)}  {$ELSE}
    procedure btnHelpClick(Sender: TObject);
    {$IFEND}
  Private
    FAplicacao: HWND;
    FstrNomCon: String;
    FstrMenCon: String;

    LArquivos: TStringList;
    LSelecionarArquivos: Boolean;
    LCodEmp: String;
    procedure PreparaFormSelecionaArquivo;
    procedure CarregaEventosGerais;
    procedure CarregaArquivos;
    function CarregaEmpresa: Boolean;
    function ValidaImportacao: Boolean;
    function CarregaArquivosSelecionados: Boolean;

  Public
    strNomEmp: String;

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

uses untFuncoes, untIDataSet {$IF Defined(VER180)}  {$ELSE}, untRelCartaoImportacao {$IFEND};

{ TImportacaoCartao }

procedure TImportacaoCartao.btnConfClick(Sender: TObject);
begin
  If Not ValidaImportacao Then
    Exit;

  untFuncoes.strFolderConcil := AnsiReplaceStr(edtDir.Text,'"','');
  fArquivoFolder(FstrNomCon, True);
  pDisableControls(True);
  If LSelecionarArquivos Then ProcessaArquivosSelecionados(LArquivos)
  Else pProcessaArquivos(AnsiReplaceStr(edtDir.Text,'"',''));
  pDisableControls(False);
end;

procedure TImportacaoCartao.btnPastaClick(Sender: TObject);
  Var
    strPasta: String;
begin
  strPasta := edtDir.Text;
  If FileCtrl.SelectDirectory('Selecione a pasta dos arquivos da operadora ' + FstrNomCon, '', strPasta) Then
    edtDir.Text := strPasta;

  CarregaArquivos;
  BringWindowToTop(FAplicacao);
  Application.BringToFront;
  frmForm.BringToFront;
end;

procedure TImportacaoCartao.btnSairClick(Sender: TObject);
begin
  frmForm.Close;
end;

procedure TImportacaoCartao.CarregaArquivos;
begin
  If LSelecionarArquivos Then
  Begin
    If SafeFilePath(edtDir.text) Then
    Begin
      Try
        lstArquivos.ApplyFilePath(edtDir.text);
        lstArquivos.Update;
      Except
        objFunctions.fIMensagem('ATENÇÃO','Não foi possível carregar os arquivos da pasta selecionada!'+ #13#10 +
                                          'Verifique se o caminho existe e se seu usuário possui permissão de acesso.',['&OK']);
      End;
    End;
  End;
end;

function TImportacaoCartao.CarregaArquivosSelecionados: Boolean;
  Var
    I : Integer;
begin
  Result := True;

  If lstArquivos.SelCount <= 0 Then
  Begin
    objFunctions.fIMensagem('ATENÇÃO','Selecione ao menos um arquivo para a importacao!',['&OK']);
    Result := False;
    Exit;
  End;

  LArquivos.Clear;
  For I := 0 To lstArquivos.Count - 1 Do
  Begin
    If lstArquivos.Selected[I] Then
    Begin
      LArquivos.Add(Concat(edtDir.Text,'\',lstArquivos.Items.Strings[I]));
    End;
  End;
end;

function TImportacaoCartao.CarregaEmpresa: Boolean;
begin
  Result := True;
  LCodEmp := '';

  {$IF Defined(VER180)}
  {$ELSE}
  If Trim(edtCodEmp.Text).Equals('') Then
  Begin
    edtNomEmp.Text := '';
    objFunctions.fIMensagem('ATENÇÃO!','Preencha o codígo da empresa!',['&OK']);
    Result := False;
    Exit;
  End;

  edtNomEmp.Text := RetornaNomeEmpresa(edtCodEmp.Text);
  If Trim(edtNomEmp.Text).Equals('') Then
  Begin
    Result := False;
    objFunctions.fIMensagem('ATENÇÃO!','Essa empresa não está cadastrada!',['&OK']);
    Exit;
  End;

  LCodEmp := edtCodEmp.Text;
  {$IFEND}
end;

procedure TImportacaoCartao.CarregaEventosGerais;
  Var
    I : Integer;
begin
  For I := 0 To frmForm.ComponentCount -1 Do
  Begin
    If (frmForm.Components[I] Is TEditFocus) Then
    Begin
      (frmForm.Components[I] As TEditFocus).OnKeyDown := pOnKeyDownEdits;
    End
  End;
end;

constructor TImportacaoCartao.Create(Owner: TComponent);
begin
  inherited;
  stlPgto   := TStringList.Create;
  stlCredito:= TStringList.Create;

  LArquivos  := TStringList.Create;
end;

destructor TImportacaoCartao.Destroy;
begin
  If Assigned(stlPgto) Then
    FreeAndNil(stlPgto);
  If Assigned(stlCredito) Then
    FreeAndNil(stlCredito);
  If Assigned(LArquivos) Then
    FreeAndNil(LArquivos);
  inherited;
end;

procedure TImportacaoCartao.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
begin
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  {$IF Defined(VER180)}
  {$ELSE}
  If fIPesqEmpresa(frmForm, edtCodEmp, edtNomEmp, Key) Then
  Begin
    If CarregaEmpresa Then
      Hack(frmForm).SelectNext(frmForm.ActiveControl, True, True);
  End;
  {$IFEND}
end;

procedure TImportacaoCartao.edtDirPropertieOnExit(Sender: TObject);
begin
  CarregaArquivos;
end;

procedure TImportacaoCartao.pAdicionaLinhas;
begin

end;

procedure TImportacaoCartao.pDisableControls(blnDisable: Boolean);
begin
  pnlFund.Enabled  := not blnDisable;
  edtDir.Enabled   := not blnDisable;
  btnPasta.Enabled := not blnDisable;

  If Assigned(lstArquivos) Then
  Begin
    lstArquivos.Enabled := not blnDisable;
    edtCodEmp.Enabled := not blnDisable;
  End;
end;

procedure TImportacaoCartao.pGravarRegistros;
begin

end;

procedure TImportacaoCartao.pOnKeyDownEdits(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  {$IF Defined(VER180)}
  {$ELSE}
  If (Key = VK_Return) Then
  Begin
    If Trim(TEditFocus(Sender).Name).Equals('edtCodEmp') Then
    Begin
      If CarregaEmpresa Then
      Begin
        Hack(frmForm).SelectNext(frmForm.ActiveControl, True, True);
      End;
    End
    Else
    Begin
      Hack(frmForm).SelectNext(frmForm.ActiveControl, True, True);
    End;
  End;
  {$IFEND}
end;

procedure TImportacaoCartao.pProcessaArquivos(strPath: String);
begin

end;

procedure TImportacaoCartao.PreparaFormSelecionaArquivo;
begin
  {CÓDIGO DA EMPRESA}
  edtCodEmp := TEditFocus.Create(frmForm);
  edtCodEmp.Parent   := frmForm;
  edtCodEmp.Left     := 8;
  edtCodEmp.Top      := 49;
  edtCodEmp.Height   := 21;
  edtCodEmp.TabOrder := 1;
  edtCodEmp.Width    := 65;
  edtCodEmp.Alignment := taLeftJustify ;
  edtCodEmp.MaxLength := 3 ;
  edtCodEmp.NormalColor := clWindow;
  edtCodEmp.FocusColor := clInfoBk;
  edtCodEmp.RequeridoColor := clRed;
  edtCodEmp.Requerido := False;
  edtCodEmp.CompZeros := True;
  edtCodEmp.TamCampo := 3;
  edtCodEmp.TipoTexto := ttNumerico;
  edtCodEmp.Text     := LCodEmp;
  edtCodEmp.Name     := 'edtCodEmp';
  edtCodEmp.OnKeyPress := edtCodEmpKeyPress;

  {NOME DA EMPRESA}
  edtNomEmp := TEditFocus.Create(frmForm);
  edtNomEmp.Parent    := frmForm;
  edtNomEmp.Left      := 74;
  edtNomEmp.Top       := 49;
  edtNomEmp.Height    := 21;
  edtNomEmp.TabOrder  := 2;
  edtNomEmp.Width     := 386;
  edtNomEmp.TabStop := False;
  edtNomEmp.Alignment := taLeftJustify;
  edtNomEmp.Color := 16768952;
  edtNomEmp.ReadOnly := True;
  edtNomEmp.NormalColor := 16768952;
  edtNomEmp.FocusColor := clInfoBk;
  edtNomEmp.RequeridoColor := clRed;
  edtNomEmp.Requerido := False;
  edtNomEmp.CompZeros := False;
  edtNomEmp.TamCampo := 0;
  edtNomEmp.TipoTexto := ttAlfanumerico;

  {LISTA DE ARQUIVOS}
  lstArquivos := TFileListBox.Create(frmForm);
  lstArquivos.Parent := frmForm;
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

  edtDir.OnExit := edtDirPropertieOnExit;
  frmForm.ClientHeight := 238;
  frmForm.ClientWidth  := 465;

  CarregaEventosGerais;
  CarregaArquivos;
  CarregaEmpresa;
end;

procedure TImportacaoCartao.ProcessaArquivosSelecionados(AAquivos: TStringList);
begin

end;

procedure TImportacaoCartao.pSelecionaFonte;
  Var
    lblDir: TLabel;
    btnSair  : TBitBtnLocked;
    btnConf  : TBitBtnLocked;
    {$IF Defined(VER180)}  {$ELSE}
      btnHelp: TBitBtnLocked;
    {$IFEND}
Begin

  frmForm := TForm.Create(Self);
  With frmForm Do
  Begin
    BorderStyle  := bsSingle;
    Caption      := 'Selecione a pasta dos arquivos (' + FstrNomCon + ')';
    ClientHeight := 102;
    ClientWidth  := 472;
    Color        := 16770261;
    Position     := poScreenCenter;
    BorderIcons  := [biSystemMenu];
    Icon.LoadFromResourceName(HInstance, 'AUTCOM1');  //utilizando recurso para adicionar o icone AJ
  End;

  lblDir := TLabel.Create(frmForm);
  With lblDir Do
  Begin
    Parent   := frmForm;
    Left     := 8;
    Top      := 8;
    AutoSize := True;
    Caption  := 'Pasta dos Arquivos';
  End;

  edtDir := TEditFocus.Create(frmForm);
  With edtDir Do
  Begin
    Parent   := frmForm;
    Left     := 8;
    Top      := 27;
    Height   := 21;
    TabOrder := 0;
    Width    := 430;
    NormalColor := clWindow;
    FocusColor := clInfoBk;
    RequeridoColor := clRed;
    Requerido := False;
    Text     := fArquivoFolder(FstrNomCon);
  End;

  btnPasta := TBitBtnLocked.Create(frmForm);
  With btnPasta Do
  Begin
    Parent   := frmForm;
    Left     := 438;
    Top      := 26;
    Width    := 23;
    Height   := 23;
    TabOrder := 0;
    OnClick  := btnPastaClick;
    Caption  := '';
    Glyph.LoadFromResourceName(HInstance, 'PASTA');
  End;

  lblInform := TLabel.Create(frmForm);
  With lblInform Do
  Begin
    Parent   := frmForm;
    Left     := 0;
    Top      := IIF(LSelecionarArquivos,179,49);
    AutoSize := False;
    Width    := frmForm.Width;
    Alignment:= taCenter;
    Caption  := FstrMenCon;
  End;

  pnlFund := TPanel.Create(frmForm);
  With pnlFund Do
  Begin
    Parent   := frmForm;
    Align    := alBottom;
    Height   := 28;
    Color    := clGray;
    TabOrder := 1;
  End;

  pgbProg := TProgressBar.Create(frmForm);
  With pgbProg Do
  Begin
    Parent   := frmForm;
    Align    := alBottom;
    Height   := 10;
    Position := 0;
  End;

  btnSair := TBitBtnLocked.Create(frmForm);
  With btnSair Do
  Begin
    Parent   := pnlFund;
    Left     := IIF(LSelecionarArquivos,388,397);
    Top      := 2;
    Width    := 72;
    Height   := 24;
    TabOrder := 1;
    OnClick  := btnSairClick;
    Kind     := bkClose;
    Caption  := '&Sair';
    Cancel   := True;
    Glyph    := TBitmap.Create;
  End;

  btnConf := TBitBtnLocked.Create(frmForm);
  With btnConf Do
  Begin
    Parent   := pnlFund;
    Left     := 5;
    Top      := 2;
    Width    := 72;
    Height   := 24;
    TabOrder := 0;
    OnClick  := btnConfClick;
    Default  := IIF(LSelecionarArquivos,False,True);
    Caption  := '&Importar';
    Glyph    := TBitmap.Create;
  End;

  {$IF Defined(VER180)} {$ELSE}
    btnHelp := TBitBtnLocked.Create(frmForm);
    With btnHelp Do
    Begin
      Parent   := pnlFund;
      Left     := 80;
      Top      := 2;
      Width    := 30;
      Height   := 24;
      Hint     := 'Clique aqui para exibir a instrução sobre esta rotina.';
      ShowHint := True;
      TabOrder := 1;
      OnClick  := btnHelpClick;
      Default  := False;
      Caption  := '';
      Glyph.LoadFromResourceName(HInstance, 'HELP');
      Visible  := MatchStr(FstrNomCon, ['REDECARD', 'MERCADO LIVRE']);
    End;
  {$IFEND}

  If LSelecionarArquivos Then
    PreparaFormSelecionaArquivo;

  frmForm.ShowModal;

  FreeAndNil(frmForm);
end;

function TImportacaoCartao.ValidaImportacao: Boolean;
  Var
    LMsgConfirma : String;
begin
  Result := True;

  If (Trim(edtDir.Text) = '') Or (Not SafeFilePath(edtDir.Text)) Then
  Begin
    objFunctions.fIMensagem('ATENÇÃO!','É necessário selecionar uma pasta válida!',['&OK']);
    Result := False;
    Exit;
  End;

  If Not LSelecionarArquivos Then
    Exit;

  If Not CarregaEmpresa Then Result := False
  Else If Not CarregaArquivosSelecionados Then Result := False
  Else
  Begin
    LMsgConfirma := Concat('Confirma a importação do(s) arquivo(s) selecionado(s) para a empresa ',edtCodEmp.Text,' - ',edtNomEmp.Text,' ?');

    If objFunctions.fIMensagem('ATENÇÃO!', LMsgConfirma, ['&Sim', '&Não'],1) = 2 Then
      Result := False;
  End;
end;

{$IF Defined(VER180)}  {$ELSE}
procedure TImportacaoCartao.btnHelpClick(Sender: TObject);
begin
  frmRelCartaoImportacao := TfrmRelCartaoImportacao.Create(Self);
  If FstrNomCon = 'REDECARD' Then
    frmRelCartaoImportacao.pAbreAjuda('frmImpRedeCard', 'IMPORTACAO')
  Else If FstrNomCon = 'MERCADO LIVRE' Then
    pExibirRelatorio('frmRelCartaoImportacao', 'Instruções para Conciliação Mercado Livre', TReport.New(frmRelCartaoImportacao.frxInstrucoesML));
  FreeAndNil(frmRelCartaoImportacao);
end;
{$IFEND}

end.
