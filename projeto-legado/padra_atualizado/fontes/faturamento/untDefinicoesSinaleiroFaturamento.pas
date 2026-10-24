unit untDefinicoesSinaleiroFaturamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, untTypesSistema;

type
  TfrmDefinicoesSinaleiroFaturamento = class(TfrmPai)
    lblPrecoUtilizadoParaCalculo: TLabel;
    lblDiaParaCorte: TLabel;
    lblMargemDocumentoAtual: TLabel;
    lblFaixaEncontradaDocumentoAtual: TLabel;
    lblMargemMesApuracao: TLabel;
    lblFaixaEncontradaMesApuracao: TLabel;
    edtPrecoUtilizadoParaCalculo: TEditFocus;
    edtDiaParaCorte: TEditFocus;
    edtFaixaEncontradaDocumentoAtual: TEditFocus;
    edtMargemDocumentoAtual: TEditFocus;
    edtMargemMesApuracao: TEditFocus;
    edtFaixaEncontradaMesApuracao: TEditFocus;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    recSinaleiro : TSinaleiro;
  end;

implementation

{$R *.dfm}

procedure TfrmDefinicoesSinaleiroFaturamento.FormShow(Sender: TObject);
begin
  inherited;
  edtPrecoUtilizadoParaCalculo.Text     := recSinaleiro.strPrecoUtilizadoParaCalculo;
  edtDiaParaCorte.Text                  := recSinaleiro.strDiaParaCorte;
  edtFaixaEncontradaDocumentoAtual.Text := recSinaleiro.strFaixaEncontradaDocumentoAtual;
  edtMargemDocumentoAtual.Text          := recSinaleiro.strMargemDocumentoAtual;
  edtMargemMesApuracao.Text             := recSinaleiro.strMargemMesApuracao;
  edtFaixaEncontradaMesApuracao.Text    := recSinaleiro.strFaixaEncontradaMesApuracao;
end;

end.
