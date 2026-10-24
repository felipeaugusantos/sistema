unit untCadNexaGeraArquivosD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, CheckLst,
  Gauges,  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadNexaGeraArquivosD = class(TfrmPai)
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
  frmCadNexaGeraArquivosD: TfrmCadNexaGeraArquivosD;

implementation

uses untNexaDinamica, untFuncoesSimples;

{$R *.dfm}

{ TfrmCadNexaGeraArquivosD }

procedure TfrmCadNexaGeraArquivosD.pRegistraAcao(strAcao: String);
begin
  memSaida.Lines.Add(DateTimeToStr(fNow()) + ' - ' + strAcao);
  Application.ProcessMessages;
end;

procedure TfrmCadNexaGeraArquivosD.pRegistraProgresso(intInicio, intAtual,
  intFinal: Integer);
begin
  Gauge1.MaxValue := intFinal;
  Gauge1.MinValue := intInicio;
  Gauge1.Progress := intAtual;
  pnlInfo.Caption := Format('Processando... %d / %d', [intAtual, intFinal]);
  Application.ProcessMessages;
end;

procedure TfrmCadNexaGeraArquivosD.btnConfirmaGeracaoClick(Sender: TObject);
  Var
    Nexa: TNexaAutomotivaDinamica;

begin
  Nexa := TNexaAutomotivaDinamica.Create(Self);
  Nexa.RegistraAcao := pRegistraAcao;
  Nexa.RegistraProgresso := pRegistraProgresso;

  If chkOpcoes.Checked[0] Then
    Nexa.Opcoes := Nexa.Opcoes + [TNexaGeraBases];

  If chkOpcoes.Checked[1] Then
    Nexa.Opcoes := Nexa.Opcoes + [TNexaGeraTintas];

  If Nexa.fProcessaArquivosNovos Then
     fMensagem('', 'Tintas geradas com sucesso!', ['OK']);
end;

end.
