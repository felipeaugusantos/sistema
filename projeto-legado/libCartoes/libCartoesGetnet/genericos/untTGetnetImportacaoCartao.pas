unit untTGetnetImportacaoCartao;

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
  TGetnetImportacaoCartao = Class(TComponent)
    frmImportacaoCartoes: TForm;

    edtPasta: TEditFocus;
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

  Private
    FAplicacao: HWND;
    FstrNomCon: String;
    FstrMenCon: String;

    FArquivos: TStringList;

    FCodEmp: String;

    function ValidaImportacao: Boolean;


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

uses untTGetnetFuncoes, Uni, untGetnetTipos;

{ TGetnetImportacaoCartao }

function TGetnetImportacaoCartao.BotaoConfirma(
  pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := True;

  If Not ValidaImportacao Then
    Exit(False);

  VS_PastaConciliacao := AnsiReplaceStr(edtPasta.Text,'"','');

  TGetnetFuncoes.fArquivoFolder(True);
  pDisableControls(True);

  pProcessaArquivos(AnsiReplaceStr(edtPasta.Text,'"',''), pgbProgresso);
  pDisableControls(False);
end;

procedure TGetnetImportacaoCartao.btnConfClick(Sender: TObject);
begin
  TGetnetFuncoes.ExecutaAguarde(BotaoConfirma, 'Aguarde... Importando registros.');
end;

procedure TGetnetImportacaoCartao.btnPastaClick(Sender: TObject);
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

procedure TGetnetImportacaoCartao.btnSairClick(Sender: TObject);
begin
  frmImportacaoCartoes.Close;
end;

constructor TGetnetImportacaoCartao.Create(Owner: TComponent);
begin
  inherited;
  FArquivos  := TStringList.Create;

  FstrNomCon := 'Getnet';
end;

destructor TGetnetImportacaoCartao.Destroy;
begin
  If Assigned(FArquivos) Then
    FreeAndNil(FArquivos);
  inherited;
end;

procedure TGetnetImportacaoCartao.pAdicionaLinhas;
begin

end;

procedure TGetnetImportacaoCartao.pDisableControls(blnDisable: Boolean);
begin
  pnlFundo.Enabled  := not blnDisable;
  edtPasta.Enabled   := not blnDisable;
  btnPasta.Enabled := not blnDisable;
end;

procedure TGetnetImportacaoCartao.pGravarRegistros(var prgStatus: TcxProgressBar);
begin

end;
procedure TGetnetImportacaoCartao.pProcessaArquivos(strPath: String; var prgStatus: TcxProgressBar);
begin

end;

procedure TGetnetImportacaoCartao.ProcessaArquivosSelecionados(AAquivos: TStringList);
begin

end;

procedure TGetnetImportacaoCartao.pSelecionaFonte;
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
  frmImportacaoCartoes.Icon := TGetNetFuncoes.FIconeAplicacao;

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
    edtPasta.Text     := TGetnetFuncoes.fArquivoFolder;

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

function TGetnetImportacaoCartao.ValidaImportacao: Boolean;
begin
  Result := True;

  If (Trim(edtPasta.Text) = '') Or (Not TGetnetFuncoes.SafeFilePath(edtPasta.Text)) Then
  Begin
    TGetnetFuncoes.fMensagem('ATENÇÃO!','É necessário selecionar uma pasta válida!',['&OK']);
    Result := False;
    Exit;
  End;

end;

end.
