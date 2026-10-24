unit untImportSelecaoArquivo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxButtonEdit, FilenameEditFocus, Vcl.StdCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, untFuncoesSimples;

type
  TfrmImportSelecaoArquivo = class(TfrmPai)
    lblTexto: TLabel;
    edtPath: TFilenameEditFocus;
    btnGravar: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    class function fSelecionarArquivo(Var strPath       : String;
                                          strFilters    : String = '';
                                          strDefaultDir : String = ''):Boolean; static;
  end;

Const FILTER_TODOS     = 'Todos os Arquivos|*.*';
Const FILTER_PLANILHAS = 'Planilhas|*.xls;*.xlsx;*.csv';
Const FILTER_TXT       = 'Arquivos de Texto|*.txt';

implementation

{$R *.dfm}

class function TfrmImportSelecaoArquivo.fSelecionarArquivo(var strPath       : String;
                                                               strFilters    : String = '';
                                                               strDefaultDir : String = ''): Boolean;
Var
  frmImportSelecaoArquivo : TfrmImportSelecaoArquivo;
begin
  Result := False;
  Application.CreateForm(TfrmImportSelecaoArquivo, frmImportSelecaoArquivo);
  Try
    frmImportSelecaoArquivo.edtPath.Text := strPath;

    If Not (fEmptyStr(strFilters)) Then
      frmImportSelecaoArquivo.edtPath.Dialog.Dialog.Filter := 'Todos os Arquivos|*.*';

    If (Not fEmptyStr(strDefaultDir)) Then
      frmImportSelecaoArquivo.edtPath.Dialog.Dialog.DefaultExt := strDefaultDir;

    If (frmImportSelecaoArquivo.ShowModal = mrOK) And
       (Not fEmptyStr(frmImportSelecaoArquivo.edtPath.Text)) And
       (FileExists(frmImportSelecaoArquivo.edtPath.Text)) Then
    Begin
      strPath := frmImportSelecaoArquivo.edtPath.Text;
      Result  := True;
    End;
  Finally
    pFreeAndNil(frmImportSelecaoArquivo);
  End;
end;

procedure TfrmImportSelecaoArquivo.FormCreate(Sender: TObject);
begin
  inherited;
  edtPath.Dialog.Dialog.Filter := FILTER_TODOS;
end;

end.
