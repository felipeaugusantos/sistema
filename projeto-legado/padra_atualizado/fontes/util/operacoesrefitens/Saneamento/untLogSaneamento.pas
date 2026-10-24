unit untLogSaneamento;

interface

uses
 Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.ComCtrls, untFuncoesSimples,
  System.StrUtils;

type
  TfrmLogSaneamento = class(TfrmPai)
    pnlCabecalho: TPanel;
    lblTitulo: TLabel;
    edtLog: TRichEdit;
    btnCopiar: TBitBtnLocked;
    procedure btnCopiarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
  public
    stlErros: TStringList;
  end;

var
  frmLogSaneamento: TfrmLogSaneamento;

implementation

{$R *.dfm}

procedure TfrmLogSaneamento.btnCopiarClick(Sender: TObject);
begin
  inherited;
  edtLog.SelectAll;
  edtLog.CopyToClipboard;
  pMensagemOk('Copiado para área de transferência');
end;

procedure TfrmLogSaneamento.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F4: btnCopiar.Click;
    VK_ESCAPE: Close;
  End;
end;

procedure TfrmLogSaneamento.FormShow(Sender: TObject);
begin
  inherited;
  edtLog.Lines := stlErros;
  edtLog.Perform(EM_LineScroll, 0, edtLog.Lines.Count * -1);
end;

end.
