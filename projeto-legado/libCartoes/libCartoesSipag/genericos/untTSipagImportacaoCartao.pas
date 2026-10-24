unit untTSipagImportacaoCartao;

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
  TSipagImportacaoCartao = Class(TComponent)
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
    procedure pOnKeyDownEdits(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodigoEmpresaKeyPress(Sender: TObject; var Key: Char);
  Private
    FAplicacao: HWND;
    FstrNomCon: String;
    FstrMenCon: String;

    FArquivos: TStringList;

    FCodEmp: String;

    procedure CarregaEventosGerais;
    function CarregaEmpresa: Boolean;
    function ValidaImportacao: Boolean;
    function CarregaArquivosSelecionados: Boolean;

    function BotaoConfirma(pgbProgresso: TcxProgressBar): Boolean;
  Public
    property Aplicacao: HWND read FAplicacao write FAplicacao;
    property strNomCon: String read FstrNomCon write FstrNomCon;
    property strMenCon: String read FstrMenCon write FstrMenCon;

    property Empresa: String read FCodEmp write FCodEmp;

    procedure pSelecionaFonte;

    Constructor Create(Owner: TComponent); override;
    Destructor Destroy; override;
  End;

  Hack = Class(TWinControl)
  End;

implementation

uses untTSipagFuncoes, Uni, untSipagTipos;

{ TSipagImportacaoCartao }

function TSipagImportacaoCartao.BotaoConfirma(
  pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := True;

  If Not ValidaImportacao Then
    Exit(False);

  VS_PastaConciliacao := AnsiReplaceStr(edtPasta.Text,'"','');

  TSipagFuncoes.fArquivoFolder(True);
  pDisableControls(True);

  pProcessaArquivos(AnsiReplaceStr(edtPasta.Text,'"',''), pgbProgresso);

  pDisableControls(False);
end;

procedure TSipagImportacaoCartao.btnConfClick(Sender: TObject);
begin
  TSipagFuncoes.ExecutaAguarde(BotaoConfirma, 'Aguarde... Importando registros.');
end;

procedure TSipagImportacaoCartao.btnPastaClick(Sender: TObject);
  Var
    strPasta: String;
begin
  strPasta := edtPasta.Text;
  If SelectDirectory('Selecione a pasta dos arquivos da operadora ' + FstrNomCon, '', strPasta) Then
    edtPasta.Text := strPasta;

  BringWindowToTop(FAplicacao);
  Application.BringToFront;
  frmImportacaoCartoes.BringToFront;
end;

procedure TSipagImportacaoCartao.btnSairClick(Sender: TObject);
begin
  frmImportacaoCartoes.Close;
end;

function TSipagImportacaoCartao.CarregaArquivosSelecionados: Boolean;
  Var
    I : Integer;
begin
  Result := True;

  If lstArquivos.SelCount <= 0 Then
  Begin
    TSipagFuncoes.fMensagem('ATENÇÃO','Selecione ao menos um arquivo para a importacao!',['&OK']);
    Result := False;
    Exit;
  End;

  FArquivos.Clear;
  For I := 0 To lstArquivos.Count - 1 Do
  Begin
    If lstArquivos.Selected[I] Then
    Begin
      FArquivos.Add(Concat(edtPasta.Text,'\',lstArquivos.Items.Strings[I]));
    End;
  End;
end;

function TSipagImportacaoCartao.CarregaEmpresa: Boolean;
begin
  Result := True;
  FCodEmp := '';

  If Trim(edtCodigoEmpresa.Text).Equals('') Then
  Begin
    edtNomeEmpresa.Text := '';
    TSipagFuncoes.fMensagem('ATENÇÃO!','Preencha o codígo da empresa!',['&OK']);
    Result := False;
    Exit;
  End;

  edtNomeEmpresa.Text := TSipagFuncoes.RetornaNomeEmpresa(edtCodigoEmpresa.Text);
  If Trim(edtNomeEmpresa.Text).Equals('') Then
  Begin
    Result := False;
    TSipagFuncoes.fMensagem('ATENÇÃO!','Essa empresa não está cadastrada!',['&OK']);
    Exit;
  End;

  FCodEmp := edtCodigoEmpresa.Text;
end;

procedure TSipagImportacaoCartao.CarregaEventosGerais;
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

constructor TSipagImportacaoCartao.Create(Owner: TComponent);
begin
  inherited;
  FArquivos  := TStringList.Create;
end;

destructor TSipagImportacaoCartao.Destroy;
begin
  If Assigned(FArquivos) Then
    FreeAndNil(FArquivos);
  inherited;
end;

procedure TSipagImportacaoCartao.edtCodigoEmpresaKeyPress(Sender: TObject; var Key: Char);
begin
  If TSipagFuncoes.fIPesqEmpresa(frmImportacaoCartoes, edtCodigoEmpresa, edtNomeEmpresa, Key) Then
  Begin
    If CarregaEmpresa Then
      Hack(frmImportacaoCartoes).SelectNext(frmImportacaoCartoes.ActiveControl, True, True);
  End;
end;

procedure TSipagImportacaoCartao.pAdicionaLinhas;
begin

end;

procedure TSipagImportacaoCartao.pDisableControls(blnDisable: Boolean);
begin
  pnlFundo.Enabled  := not blnDisable;
  edtPasta.Enabled   := not blnDisable;
  btnPasta.Enabled := not blnDisable;
end;

procedure TSipagImportacaoCartao.pGravarRegistros(var prgStatus: TcxProgressBar);
begin

end;

procedure TSipagImportacaoCartao.pOnKeyDownEdits(Sender: TObject; var Key: Word;
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

procedure TSipagImportacaoCartao.pProcessaArquivos(strPath: String; var prgStatus: TcxProgressBar);
begin

end;

procedure TSipagImportacaoCartao.ProcessaArquivosSelecionados(AAquivos: TStringList);
begin

end;

procedure TSipagImportacaoCartao.pSelecionaFonte;
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
  frmImportacaoCartoes.Icon := TSipagFuncoes.FIconeAplicacao;

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
    edtPasta.Text     := TSipagFuncoes.fArquivoFolder;

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

    frmImportacaoCartoes.ShowModal;
  Finally
    FreeAndNil(LImagemVaziaConf);
    FreeAndNil(LImagemVaziaSair);

    FreeAndNil(frmImportacaoCartoes);
  End;
end;

function TSipagImportacaoCartao.ValidaImportacao: Boolean;
  Var
    LMsgConfirma : String;
begin
  Result := True;

  If (Trim(edtPasta.Text) = '') Or (Not TSipagFuncoes.SafeFilePath(edtPasta.Text)) Then
  Begin
    TSipagFuncoes.fMensagem('ATENÇÃO!','É necessário selecionar uma pasta válida!',['&OK']);
    Result := False;
    Exit;
  End;
end;

end.
