unit Contabilidade.View.ExportacaoModeloContabil;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Contabilidade.View.TfrmPaiConfirmaContabilidade, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxProgressBar;

type
  TfrmExportacaoModeloContabil = class(TfrmPaiConfirmaContabilidade)
    pnlCorpo: TPanel;
    pnlDetalhes: TPanel;
    lblVersao: TLabel;
    lblTabelasLabel: TLabel;
    mmoTabelas: TMemo;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FstrCaminho: string;
    function fExportar(pgbProgresso: TcxProgressBar): Boolean;
  public
  end;

implementation

{$R *.dfm}

uses
  untFuncoesSimples,
  Contabilidade.Classes.ImportacaoModeloContabil,
  Contabilidade.Classes.TImportacaoDadosContabeis,
  Contabilidade.Classes.ExportadorModeloContabil;

procedure TfrmExportacaoModeloContabil.FormCreate(Sender: TObject);
begin
  inherited;
  blnVerificaCampos := False;

  lblVersao.Caption := 'Layout do modelo: ' + CSV_DEFAULT_VERSION;

  mmoTabelas.Lines.Clear;
  mmoTabelas.Lines.Add(DES_IMPORTACAODADOSCONTABEIS[tidcConfiguracoes]           + '  -  Configurações do sistema (Grupo CONTABILIDADE)');
  mmoTabelas.Lines.Add(DES_IMPORTACAODADOSCONTABEIS[tidcHistoricoPadrao]         + '  -  Histórico padrão');
  mmoTabelas.Lines.Add(DES_IMPORTACAODADOSCONTABEIS[tidcPlanoContas]             + '  -  Plano de contas');
  mmoTabelas.Lines.Add(DES_IMPORTACAODADOSCONTABEIS[tidcParametrosContabilizacao]+ '  -  Parâmetros de contabilização');
  mmoTabelas.Lines.Add('CMPPAR'                                                  + '  -  Complementos de contabilização');
  mmoTabelas.Lines.Add('PARNCO'                                                  + '  -  Contas contábeis por parâmetro');
end;

function TfrmExportacaoModeloContabil.fExportar(pgbProgresso: TcxProgressBar): Boolean;
var
  LExportador: TExportadorModeloContabil;
begin
  LExportador := TExportadorModeloContabil.Create;
  try
    LExportador.pExportar(FstrCaminho, pgbProgresso);
    Result := True;
  finally
    FreeAndNil(LExportador);
  end;
end;

procedure TfrmExportacaoModeloContabil.btnConfirmaClick(Sender: TObject);
var
  LDlgSave: TSaveDialog;
begin
  LDlgSave := TSaveDialog.Create(Self);
  try
    LDlgSave.Title      := 'Exportar Modelo Contábil';
    LDlgSave.DefaultExt := 'csv';
    LDlgSave.Filter     := 'Arquivo CSV (*.csv)|*.csv|Todos os arquivos (*.*)|*.*';

    if not LDlgSave.Execute then
      Exit;

    FstrCaminho := LDlgSave.FileName;
  finally
    FreeAndNil(LDlgSave);
  end;

  if fChamaTelaGravando(fExportar) then
    fMensagem('ATENÇÃO', 'Modelo contábil exportado com sucesso!', ['&Ok']);
end;

end.
