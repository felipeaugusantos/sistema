unit untVisualizarAplicacaoProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.ComCtrls, untFuncoesSimples,
  System.StrUtils, untGravaArquivoPasta;

type
  TfrmVisualizarAplicacaoProduto = class(TfrmPai)
    edtAplicacao: TRichEdit;
    pnlCabecalho: TPanel;
    lblProd: TLabel;
    btnCopiar: TBitBtnLocked;
    btnArqInstr: TBitBtnLocked;
    procedure btnCopiarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnArqInstrClick(Sender: TObject);
  private
    { Private declarations }
  public
    FCodIte: Integer;
  end;

var
  frmVisualizarAplicacaoProduto: TfrmVisualizarAplicacaoProduto;

implementation

{$R *.dfm}

procedure TfrmVisualizarAplicacaoProduto.btnArqInstrClick(Sender: TObject);
begin
  inherited;
  If fEmptyStr(IntToStr(FCodIte)) Then
    Exit;

  pCriarFormularios(TfrmGravaArquivoPasta, frmGravaArquivoPasta);
  Try
    frmGravaArquivoPasta.strCaminhoPasta := ExtractFilePath(Application.ExeName)+ 'Arquivos_produto\' + FormatFloat(StringOfChar('0', fTamCodIte), FCodIte);
    frmGravaArquivoPasta.Caption         := 'Pasta ( Arquivos em Anexo )';
    frmGravaArquivoPasta.btnImportar.Visible := False;
    frmGravaArquivoPasta.ShowModal;
  Finally
    FreeAndNil(frmGravaArquivoPasta);
  End;
end;

procedure TfrmVisualizarAplicacaoProduto.btnCopiarClick(Sender: TObject);
begin
  inherited;
  edtAplicacao.SelectAll;
  edtAplicacao.CopyToClipboard;
  pMensagemOk('Copiado para área de transferência');
end;

procedure TfrmVisualizarAplicacaoProduto.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F4: btnCopiar.Click;
  End;
end;

procedure TfrmVisualizarAplicacaoProduto.FormShow(Sender: TObject);
begin
  inherited;
  edtAplicacao.Perform(EM_LineScroll, 0, edtAplicacao.Lines.Count * -1);
end;

end.
