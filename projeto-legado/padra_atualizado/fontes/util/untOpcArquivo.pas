unit untOpcArquivo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.StdCtrls, Vcl.ExtCtrls,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem, untPaiConfirma;

type
  TfrmOpcArquivo = class(TfrmPai)
    GroupBox1: TGroupBox;
    rdbNovo: TRadioButton;
    rdbConsultar: TRadioButton;
    btnConfirmar: TBitBtnLocked;
    procedure btnConfirmarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses untAdicionaArquivo, untConsultaArquivo, untFuncoesSimples;

procedure TfrmOpcArquivo.btnConfirmarClick(Sender: TObject);
begin
  if rdbNovo.Checked then
    pCriarForm(TfrmAdicionaArquivo)
  else
    pCriarForm(TfrmConsultaArquivo);

end;

end.
