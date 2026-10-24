unit untConfiguracoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes,

{$IF Defined(UNIDAC)}
  Uni,
{$ELSE}
  ZConnection, ZDataset, ZDbcIntfs,
{$IFEND}
  Graphics, Controls, Forms,
  Dialogs, StdCtrls, EditFocus, ExtCtrls, Buttons, BitBtnLockedIncrem;

type
  TfrmConfiguracoes = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    edtCodEmp: TEditFocus;
    btnConfirma: TBitBtn;
    edtPatAtc: TEditFocus;
    Label2: TLabel;
    ckbMulti: TCheckBox;
    btnAjuda: TBitBtnLocked;
    procedure edtCodEmpExit(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ckbMultiClick(Sender: TObject);
    procedure btnAjudaClick(Sender: TObject);
  private
    { Private declarations }
    intQtdPastasPainelNFe: Integer;
  public
    { Public declarations }
  end;

var
  frmConfiguracoes: TfrmConfiguracoes;

implementation

uses {$IF Defined(VER250) Or Defined(VER270) Or Defined(VER280) Or Defined(VER300)}
     System.UITypes,
     {$IFEND}
     untMensagemExplicativa, untUtil;

{$R *.dfm}

procedure TfrmConfiguracoes.btnConfirmaClick(Sender: TObject);
begin
  If (fEmptyStr(edtPatAtc.Text)) Then
  Begin
    Application.MessageBox('O path do Autcom deve ser preenchido!', 'Atenção', MB_OK+MB_ICONWARNING);
    edtPatAtc.SetFocus;
    Exit;
  End;

  If (Not DirectoryExists(edtPatAtc.Text)) Then
  Begin
    Application.MessageBox('O path indicado não existe!', 'Atenção', MB_OK+MB_ICONWARNING);
    edtPatAtc.SetFocus;
    Exit;
  End;

  If (Not FileExists(edtPatAtc.Text + '\opcoes.ini')) Then
  Begin
    Application.MessageBox('Path inválido! opcoes.ini não existe neste caminho!', 'Atenção', MB_OK+MB_ICONWARNING);
    edtPatAtc.SetFocus;
    Exit;
  End;

  If (edtCodEmp.Enabled) Then
  Begin
    If (fEmptyStr(edtCodEmp.Text)) Then
    Begin
      Application.MessageBox('A empresa deve ser preenchida!', 'Atenção', MB_OK+MB_ICONWARNING);
      edtCodEmp.SetFocus;
      Exit;
    End
    Else If (Not fEmpresaNesteServidor(edtCodEmp.Text)) Then
    Begin
      edtCodEmp.SetFocus;
      Exit;
    End;
  End;

  fArqIni(1, 'GERAL', 'PATATC', edtPatAtc.Text, 'opcoespainel.ini');

  If (ckbMulti.Checked) Then
    fArqIni(1, 'GERAL', 'EMPPNL', '', 'opcoespainel.ini')
  Else
    fArqIni(1, 'GERAL', 'EMPPNL', edtCodEmp.Text, 'opcoespainel.ini');

  ModalResult := mrOk;
end;

procedure TfrmConfiguracoes.btnAjudaClick(Sender: TObject);
begin
  If (Not ckbMulti.Enabled) Then
    Application.MessageBox('Conforme os dados em EMPRESAS_NESTE_SERVIDOR, o ambiente não é compatível com a opção "Multi Empresas"!', 'Atenção', MB_OK+MB_ICONINFORMATION);

  Application.CreateForm(TfrmMensagemExplicativa, frmMensagemExplicativa);
  Try
    frmMensagemExplicativa.Height := 570;
    frmMensagemExplicativa.Width  := 750;

    frmMensagemExplicativa.Caption := 'Instruções para configuração';

    frmMensagemExplicativa.mmoInstru.Lines.Add('Atenção: A transição entre os modos de operação deve ser feita com o auxílio da CITEL, pois atalhos podem já estar definidos e, portanto, precisam ser adequados.');
    frmMensagemExplicativa.mmoInstru.Lines.Add('');
    frmMensagemExplicativa.mmoInstru.Lines.Add('Modo "Multi Empresas":');
    frmMensagemExplicativa.mmoInstru.Lines.Add('');
    frmMensagemExplicativa.mmoInstru.Lines.Add('Nesse modelo, uma única pasta PainelNFe atende à todas as empresas do servidor. Fato que simplifica e agiliza a atualização do sistema.');
    frmMensagemExplicativa.mmoInstru.Lines.Add('A identificação da empresa de operação do PainelNFe, ocorre por meio de uma TAG definida no atalho ("EMP:XXX"), ou por de uma tela de seleção (quando não definida a TAG e/ou clicar diretamente no executável).');
    frmMensagemExplicativa.mmoInstru.Lines.Add('O formato da TAG deve ser rigorosamente respeitado (com aspas e sem espaços), conforme o exemplo:');
    frmMensagemExplicativa.mmoInstru.Lines.Add('');
    frmMensagemExplicativa.mmoInstru.Lines.Add('C:\Autcom\PainelNFe\PainelNFe.exe "EMP:001"');
    frmMensagemExplicativa.mmoInstru.Lines.Add('');
    frmMensagemExplicativa.mmoInstru.Lines.Add('Ao acionar o atalho exemplificado, o PainelNFe é executado diretamente com os registros da empresa 001, sem exibir a tela de seleção.');
    frmMensagemExplicativa.mmoInstru.Lines.Add('É possível criar múltiplos atalhos (um para cada empresa), todos direcionados à mesma pasta, alterando apenas o parâmetro.');
    frmMensagemExplicativa.mmoInstru.Lines.Add('Se o atalho não possuir uma empresa definida, a tela de seleção será apresentada.');
    frmMensagemExplicativa.mmoInstru.Lines.Add('');
    frmMensagemExplicativa.mmoInstru.Lines.Add('Para habilitar esse modo, a opção correspondente (Usar PainelNFe modo "Multi Empresas") deve ser ativada na tela de configuração.');
    frmMensagemExplicativa.mmoInstru.Lines.Add('Alternativamente, pode-se limpar a propriedade EMPPNL do arquivo opcoespainel.ini EMPPNL=');
    frmMensagemExplicativa.mmoInstru.Lines.Add('');
    frmMensagemExplicativa.mmoInstru.Lines.Add('');
    frmMensagemExplicativa.mmoInstru.Lines.Add('Modo Clássico:');
    frmMensagemExplicativa.mmoInstru.Lines.Add('');
    frmMensagemExplicativa.mmoInstru.Lines.Add('Este modo representa a operação padrão do PainelNFe, onde cada empresa possui sua própria pasta de PainelNFe e cuja identificação da empresa se dá pela propriedade EMPPNL=XXX do opcoespainel.ini');
    frmMensagemExplicativa.mmoInstru.Lines.Add('');
    frmMensagemExplicativa.mmoInstru.Lines.Add('');
    frmMensagemExplicativa.mmoInstru.Lines.Add('Notas Gerais:');
    frmMensagemExplicativa.mmoInstru.Lines.Add('');
    frmMensagemExplicativa.mmoInstru.Lines.Add('Os arquivos temporários ficam em uma pasta chamada PNLDIR\XXX onde XXX é a empresa, tanto na pasta do PainelNFe quanto na pasta do Autcom exemplo:');
    frmMensagemExplicativa.mmoInstru.Lines.Add('');
    frmMensagemExplicativa.mmoInstru.Lines.Add('...Autcom\PainelNFe\PNLDIR\001');
    frmMensagemExplicativa.mmoInstru.Lines.Add('...Autcom\PainelNFe\PNLDIR\002');
    frmMensagemExplicativa.mmoInstru.Lines.Add('...Autcom\PNLDIR\001');
    frmMensagemExplicativa.mmoInstru.Lines.Add('...Autcom\PNLDIR\002');
    frmMensagemExplicativa.mmoInstru.Lines.Add('');
    frmMensagemExplicativa.mmoInstru.Lines.Add('Em cada pasta estarão os arquivos como ULTIMO_ENVIO_NFS.TXT, ULTIMO_RETORNO_NFS.TXT. Isso vale tanto para o Modo "Multi Empresas" quanto "Modo Clássico"');

    frmMensagemExplicativa.ShowModal;
  Finally
    FreeAndNil(frmMensagemExplicativa);
  End;
end;

procedure TfrmConfiguracoes.ckbMultiClick(Sender: TObject);
begin
  intQtdPastasPainelNFe := fGetPastasPainel;

  If (ckbMulti.Checked) And (fGetPastasPainel > 1) Then
  Begin
    Application.MessageBox(PChar('PainelNFe, configurado para operar no "Multi Empresas", no entanto, existem '+IntToStr(intQtdPastasPainelNFe)+' '+
                                 'PainelNFe''s no diretório do Autcom.'+#13#13+
                                 'Adeque os diretórios, ou use o "Modo Clássico".'), 'Atenção', MB_OK+MB_ICONWARNING);

    ckbMulti.Checked := False;
  End;

  edtCodEmp.Color   := IIF(ckbMulti.Checked, clSilver, clWindow);
  edtCodEmp.Enabled := Not ckbMulti.Checked;
end;

procedure TfrmConfiguracoes.edtCodEmpExit(Sender: TObject);
begin
  If (Not fEmptyStr(edtCodEmp.Text)) Then
    edtCodEmp.Text := fStrZero(edtCodEmp.Text, 3);
end;

procedure TfrmConfiguracoes.FormCreate(Sender: TObject);
begin
  edtPatAtc.Text := fArqIni(0, 'GERAL', 'PATATC', '', 'opcoespainel.ini');
  edtCodEmp.Text := fArqIni(0, 'GERAL', 'EMPPNL', '', 'opcoespainel.ini');

  ckbMulti.Enabled := (Not fEstaNoPainelNFeGeral);

  If (ckbMulti.Enabled) Then
  Begin
    ckbMulti.Checked := False;

    intQtdPastasPainelNFe := fGetPastasPainel;

    If (intQtdPastasPainelNFe <= 1) Then
    Begin
      If (FileExists(ExtractFilePath(Application.ExeName) + 'opcoespainel.ini')) Then
        ckbMulti.Checked := (fEmptyStr(edtCodEmp.Text))
      Else
        ckbMulti.Checked := True;
    End;
  End
  Else
  Begin
    ckbMulti.Checked := True;
    edtCodEmp.Text   := '';
    If fEmptyStr(edtPatAtc.Text) Then
      edtPatAtc.Text := '..\.';
  End;
end;

end.
