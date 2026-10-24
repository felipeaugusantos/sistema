unit untImportacaoArquivo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxProgressBar,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, cxTextEdit, cxMaskEdit,
  cxButtonEdit, FilenameEditFocus, Vcl.Menus, cxButtons, untPai,
  Math, Types, frxClass;

type
  TfrmImportacaoArquivo = class(TForm)
    plnFundo: TPanel;
    plnRodape: TPanel;
    edtCaminhoArquivo: TFilenameEditFocus;
    lblPath: TLabel;
    pnlInfor: TPanel;
    pnlInfo: TPanel;
    pnlNomeForm: TPanel;
    btnImportar: TBitBtnLocked;
    btnSair: TBitBtnLocked;
    procedure btnImportarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    function fValidaArquivo: Boolean;

    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmImportacaoArquivo.btnImportarClick(Sender: TObject);
begin
  If (Not fValidaArquivo) Then
    Exit;

  ModalResult := MrOK;
end;

function TfrmImportacaoArquivo.fValidaArquivo: Boolean;
begin
  Result := False;

  If (Not FileExists(edtCaminhoArquivo.Text)) Then
  Begin
    fMensagem('AVISO','Arquivo não encontrado: ' + edtCaminhoArquivo.Text + ' !', ['&OK']);
    Exit;
  End;

  Result := True;
end;

procedure TfrmImportacaoArquivo.btnSairClick(Sender: TObject);
begin
  ModalResult := mrCancel;
  Close;
end;

procedure TfrmImportacaoArquivo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key Of
    VK_ESCAPE: btnSairClick(Sender);
  End;
end;

end.
