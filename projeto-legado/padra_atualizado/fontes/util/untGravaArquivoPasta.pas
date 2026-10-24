{**************************************************}
{* ESTA UNIT ABRE ARQUIVOS EM UMA DETERMINADA     *}
{* PASTA, CASO NÃO EXISTA A PASTA , TENTA CRIAR   *}
{* O USUARIO PODE ABRIR ARQUIVOS DA PASTA, E PODE *}
{* COPIAR( ANEXAR ) NOVOS ARQUIVOS PARA A PASTA   *}
{* ATRAVÉS DO BOTÃO LOCALIZAR                     *}
{**24/02/2011-11:03*****************************DP*}
unit untGravaArquivoPasta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, ComCtrls,
  ShlObj, cxShellCommon, cxControls, cxContainer, cxShellListView,
  BitBtnLockedIncrem, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, cxEdit, cxListView, frxClass, frxExportCSVTestabilidade;

type
  TfrmGravaArquivoPasta = class(TfrmPai)
    slvPastaCliente: TcxShellListView;
    pnSuperior: TPanel;
    cbExibicao: TComboBox;
    Label1: TLabel;
    lblCaminho: TLabel;
    Bevel1: TBevel;
    opdCarrega: TOpenDialog;
    btnImportar: TBitBtnLocked;
    btnAneCre: TBitBtnLocked;
    btnAneCli: TBitBtnLocked;
    pnlFundo: TPanel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbExibicaoChange(Sender: TObject);
    procedure slvPastaClienteCurrentFolderChanged(
      Sender: TcxCustomShellListView);
    procedure btnImportarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnAneCreClick(Sender: TObject);
    procedure btnAneCliClick(Sender: TObject);
    procedure slvPastaClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure slvPastaClienteExecuteItem(Sender: TObject; APIDL: PItemIDList;
      var AHandled: Boolean);
  private
    procedure pCopiarTodosPara(strPathOrigem, strPathDestino: String);
    procedure pPreparaTela;
    procedure ModoDock;
    function fValidarOfficeInstalado : Boolean;
    { Private declarations }
  public
    { Public declarations }

    strCodCli       : String;
    strCaminhoPasta : String;
    bCriaPasta      : Boolean;
    bEntrou         : Boolean;
    blnConsulta     : Boolean;
    blnModoDock     : Boolean;
    bTodasExtensoes : Boolean;
  end;

var
  frmGravaArquivoPasta: TfrmGravaArquivoPasta;

implementation

uses untFuncoesSimples, ComObj;

{$R *.dfm}

procedure TfrmGravaArquivoPasta.pCopiarTodosPara(strPathOrigem, strPathDestino : String);
  Var
    arquivos: TSearchRec;
begin
  strPathOrigem  := IncludeTrailingPathDelimiter(strPathOrigem);
  strPathDestino := IncludeTrailingPathDelimiter(strPathDestino);



  If Not( DirectoryExists(strPathDestino) ) Then
    If Not( fCriaDiretorio(strPathDestino) ) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é possível criar/carregar a pasta do cliente!!!'            +#13+
                            'Talvez você não tenha permissão de leitura/gravação na pasta!!!'+#13+
                            'Procure o Administrador do Sistema e informe este erro: '       +#13+
                            'Não conseguiu criar a pasta ' + strPathDestino, ['&Ok']);
      Exit;
    End;


  If FindFirst(strPathOrigem + '*.*', faArchive, arquivos) = 0 Then
  Begin
    Repeat

      CopyFile( PChar(strPathOrigem + arquivos.Name), PChar(strPathDestino + arquivos.Name), True );

    Until FindNext(arquivos) <> 0;
    FindClose(arquivos);
  End;

  fMensagem('','Copia realizada!', ['&OK']);

End;

procedure TfrmGravaArquivoPasta.pPreparaTela;
begin
  If (blnConsulta) Then
  Begin
    slvPastaCliente.options.ContextMenus := False;
    btnImportar.Enabled := False;
    btnAneCre.Enabled   := False;
    btnAneCli.Enabled   := False;
  End;
end;

procedure TfrmGravaArquivoPasta.btnAneCliClick(Sender: TObject);
begin
  inherited;
  pCopiarTodosPara(strCaminhoPasta, ExtractFilePath(Application.ExeName)+ 'ANEXOS\' + strCodCli);
end;

procedure TfrmGravaArquivoPasta.btnAneCreClick(Sender: TObject);
begin
  inherited;
  pCopiarTodosPara(strCaminhoPasta, ExtractFilePath(Application.ExeName)+ 'CONSULTA_CREDITO\' + strCodCli);
end;

procedure TfrmGravaArquivoPasta.btnImportarClick(Sender: TObject);
  var
    LintIdx : Integer;
begin
  if bTodasExtensoes then
    opdCarrega.Filter := 'Todos|*.*';

  opdCarrega.Execute;

  For LintIdx := 0 To opdCarrega.Files.Count -1 Do
  Begin
    If (opdCarrega.Files[LintIdx] <> '') And ((ExtractFilePath(opdCarrega.Files[LintIdx]) <> strCaminhoPasta)) Then
    Begin

      If FileExists( strCaminhoPasta + '\' + ExtractFileName(opdCarrega.Files[LintIdx])) Then
      Begin
        If fMensagem('ATENÇÃO!', 'O arquivo "'+opdCarrega.Files[LintIdx]+'" a ser importado já existe no destino. Deseja substituir ?!', ['&Sim', '&Não']) = 1 Then
        Begin
          CopyFile( PChar(opdCarrega.Files[LintIdx]), PChar( strCaminhoPasta + '\' + ExtractFileName(opdCarrega.Files[LintIdx])), False);
        End;
      End Else
        CopyFile( PChar(opdCarrega.Files[LintIdx]), PChar( strCaminhoPasta + '\' + ExtractFileName(opdCarrega.Files[LintIdx])), False);
    End;
  End;
  

end;

procedure TfrmGravaArquivoPasta.cbExibicaoChange(Sender: TObject);
begin
  inherited;

  Case cbExibicao.ItemIndex Of
    0:slvPastaCliente.ViewStyle := vsList;
    1:slvPastaCliente.ViewStyle := vsReport;
    2:slvPastaCliente.ViewStyle := vsIcon;
    3:slvPastaCliente.ViewStyle := vsSmallIcon;
  End;

end;

procedure TfrmGravaArquivoPasta.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  Action := caFree;
end;

procedure TfrmGravaArquivoPasta.FormCreate(Sender: TObject);
begin
  inherited;

  bCriaPasta  := True;
  bEntrou     := False;
  blnConsulta := False;
  bTodasExtensoes := False;
end;

procedure TfrmGravaArquivoPasta.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key of
    VK_Escape:If Not blnModoDock Then Close;
  End;

end;

procedure TfrmGravaArquivoPasta.FormShow(Sender: TObject);
begin
  inherited;

  If Not( DirectoryExists(strCaminhoPasta) ) Then
    If bCriaPasta Then
      If Not( fCriaDiretorio(strCaminhoPasta) ) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não é possível criar/carregar a pasta do cliente!!!'            +#13+
                              'Talvez você não tenha permissão de leitura/gravação na pasta!!!'+#13+
                              'Procure o Administrador do Sistema e informe este erro: '       +#13+
                              'Não conseguiu criar a pasta ' + strCaminhoPasta, ['&Ok']);
        Close;
        Exit;
      End;

  If Not DirectoryExists(strCaminhoPasta) Then
  Begin
    lblCaminho.Caption                := '';
    lblCaminho.Hint                   := '';
    Raise Exception.Create('Diretório '+strCaminhoPasta + ' não existe!');
  End;

  Try
    slvPastaCliente.Root.BrowseFolder := bfCustomPath;
    slvPastaCliente.Root.CustomPath   := strCaminhoPasta;
  Except
    lblCaminho.Caption                := '';
    lblCaminho.Hint                   := '';
    Raise Exception.Create('Não foi possível acessar o diretório '+strCaminhoPasta);
  End;

  lblCaminho.Caption                := strCaminhoPasta;
  lblCaminho.Hint                   := strCaminhoPasta;
  bEntrou                           := True;

  btnAneCre.Visible := not fEmptyStr(strCodCli);
  btnAneCli.Visible := not fEmptyStr(strCodCli);


  If blnConsulta Then
  Begin
    slvPastaCliente.DragDropSettings.DropEffect := [];
    slvPastaCliente.DragDropSettings.AllowDragObjects := False;

  End;

  pPreparaTela;

  Application.ProcessMessages;

  pSetFocus(slvPastaCliente);

  If blnModoDock then
    ModoDock;
end;

function TfrmGravaArquivoPasta.fValidarOfficeInstalado: Boolean;
  var
    LPrograma : Variant;
begin
  Result := False;

  if fEmptyStr(Trim(slvPastaCliente.SelectedFilePaths.Text)) then
    Exit(True);

  if Pos(ExtractFileExt(UpperCase(Trim(slvPastaCliente.SelectedFilePaths.Text))), '.DOC_.DOCX_.CSV_.XLS_.XLSX') > 0 then
  Begin
    Try
      if Pos(ExtractFileExt(UpperCase(Trim(slvPastaCliente.SelectedFilePaths.Text))), '.DOC_.DOCX') > 0 then
        LPrograma := CreateOleObject('Word.Application')
      else
        LPrograma := CreateOleObject('Excel.Application');

      Exit(True);
    Except
      try
        LPrograma := CreateOleObject('com.sun.star.ServiceManager');

        Exit(True);
      Except
        On E: Exception Do
          fMensagem('ATENÇÃO!', 'Máquina não encontra-se preparada para abrir esse arquivo. É necessário que o Microsoft Office ou '+
          'Libre Office estejam instalados!',['&Ok']);
      end;
    End;
  End
  Else
    Exit(True);

end;

procedure TfrmGravaArquivoPasta.ModoDock;
begin
  pnlStatus.Visible := False;
  btnSair.Visible := False;
end;

procedure TfrmGravaArquivoPasta.slvPastaClienteCurrentFolderChanged(
  Sender: TcxCustomShellListView);
begin
  inherited;

  If bEntrou Then
  Begin
    fMensagem('ATENÇÃO!', 'Esta função não permite alterar/trocar de pasta!!!',['&Ok']);
    slvPastaCliente.Root.CustomPath := strCaminhoPasta;
  End;

end;

procedure TfrmGravaArquivoPasta.slvPastaClienteExecuteItem(Sender: TObject;
  APIDL: PItemIDList; var AHandled: Boolean);
begin
  if not fValidarOfficeInstalado then
    Abort;

  inherited;
end;

procedure TfrmGravaArquivoPasta.slvPastaClienteKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If (blnConsulta) And (Key = VK_DELETE) Then
    Key := 0;

  inherited;
end;

end.
