unit untCadPpgGeraRegrasDiluicao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, CheckLst,
  Gauges, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadPpgGeraRegrasDiluicao = class(TfrmPai)
    pnlFundo: TPanel;
    Gauge1: TGauge;
    pnlCabecalho: TPanel;
    memSaida: TMemo;
    btnConfirmaGeracao: TBitBtnLocked;
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    procedure pRegistraAcao(strAcao: String);
    procedure pRegistraProgresso(intInicio, intAtual, intFinal: Integer);
  public
    { Public declarations }
  end;

var
  frmCadPpgGeraRegrasDiluicao: TfrmCadPpgGeraRegrasDiluicao;

implementation

uses untPpgDinamica, untFuncoesSimples;

{$R *.dfm}

{ TfrmCadPpgGeraRegrasDiluicao }

procedure TfrmCadPpgGeraRegrasDiluicao.pRegistraAcao(strAcao: String);
begin
  memSaida.Lines.Add(DateTimeToStr(fNow()) + ' - ' + strAcao);
  Application.ProcessMessages;
end;

procedure TfrmCadPpgGeraRegrasDiluicao.pRegistraProgresso(intInicio, intAtual,
  intFinal: Integer);
begin
  Gauge1.MaxValue := intFinal;
  Gauge1.MinValue := intInicio;
  Gauge1.Progress := intAtual;
  pnlInfo.Caption := Format('Processando... %d / %d', [intAtual, intFinal]);
  Application.ProcessMessages;
end;

procedure TfrmCadPpgGeraRegrasDiluicao.btnConfirmaGeracaoClick(Sender: TObject);
  Var
    ppg: TPpgAutomotivaDinamica;
begin
  ppg := TPpgAutomotivaDinamica.Create(Self);
  ppg.RegistraAcao := pRegistraAcao;
  ppg.RegistraProgresso := pRegistraProgresso;

  If ppg.fProcessaArquivosDiluicao Then
    fMensagem('', 'Regras de Diluição geradas com sucesso!', ['OK']);
end;

end.
