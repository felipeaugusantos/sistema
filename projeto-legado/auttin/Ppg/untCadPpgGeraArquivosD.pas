unit untCadPpgGeraArquivosD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, CheckLst,
  Gauges, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadPpgGeraArquivosD = class(TfrmPai)
    pnlFundo: TPanel;
    Gauge1: TGauge;
    pnlCabecalho: TPanel;
    memSaida: TMemo;
    chkOpcoes: TCheckListBox;
    btnConfirmaGeracao: TBitBtnLocked;
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    procedure pRegistraAcao(strAcao: String);
    procedure pRegistraProgresso(intInicio, intAtual, intFinal: Integer);
  public
    { Public declarations }
  end;

var
  frmCadPpgGeraArquivosD: TfrmCadPpgGeraArquivosD;

implementation

uses  untIConfTinta, untFuncTinta,untPpgDinamica, untFuncoesSimples;

{$R *.dfm}

{ TfrmCadPpgGeraArquivosD }

procedure TfrmCadPpgGeraArquivosD.pRegistraAcao(strAcao: String);
begin
  memSaida.Lines.Add(DateTimeToStr(fNow()) + ' - ' + strAcao);
  Application.ProcessMessages;
end;

procedure TfrmCadPpgGeraArquivosD.pRegistraProgresso(intInicio, intAtual,
  intFinal: Integer);
begin
  Gauge1.MaxValue := intFinal;
  Gauge1.MinValue := intInicio;
  Gauge1.Progress := intAtual;
  pnlInfo.Caption := Format('Processando... %d / %d', [intAtual, intFinal]);
  Application.ProcessMessages;
end;

procedure TfrmCadPpgGeraArquivosD.btnConfirmaGeracaoClick(Sender: TObject);
var
  ppg: TPpgAutomotivaDinamica;
  conf: IConfTinta;
begin
  ppg := nil;
  Try
    Try
      ppg := TPpgAutomotivaDinamica.Create(Self);
      ppg.RegistraAcao := pRegistraAcao;
      ppg.RegistraProgresso := pRegistraProgresso;

      conf  := fGetConfTinta('PPG');
      //(TPpgGeraBases, TPpgGeraTintas);

      If chkOpcoes.Checked[0] Then
        ppg.Opcoes := ppg.Opcoes + [TPpgGeraBases];

      If chkOpcoes.Checked[1] Then
        ppg.Opcoes := ppg.Opcoes + [TPpgGeraTintas];

      if conf.fGet('NOVFOR') = 'S' then // novos arquivos ppg(outra linha de produtos)
      begin
        If ppg.fProcessaArquivosNovos Then
          fMensagem('', 'Tintas geradas com sucesso!', ['OK']);
      end
      else
      begin
        If ppg.fProcessaArquivos Then
          fMensagem('', 'Tintas geradas com sucesso!', ['OK']);
      end;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(ppg) then FreeAndNil(ppg);
  End;

end;

end.
