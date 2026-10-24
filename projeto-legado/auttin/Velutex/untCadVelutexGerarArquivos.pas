unit untCadVelutexGerarArquivos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, CheckLst, Gauges, AppEvnts, Menus, Buttons,
  ExtCtrls, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadVelutexGerarArquivos = class(TfrmPai)
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
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadVelutexGerarArquivos: TfrmCadVelutexGerarArquivos;

implementation

uses untVelutexDinamica, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadVelutexGerarArquivos.btnConfirmaGeracaoClick(Sender: TObject);
  Var
    Velutex: TVelutexDinamica;
begin
  Try
    memSaida.Clear;
    
    btnConfirmaGeracao.Enabled := False;

    Velutex                   := TVelutexDinamica.Create(Self);
    Velutex.RegistraAcao      := pRegistraAcao;
    Velutex.RegistraProgresso := pRegistraProgresso;

    If chkOpcoes.Checked[0] Then
      Velutex.Opcoes := Velutex.Opcoes + [TVelutexGeraBases];

    If chkOpcoes.Checked[1] Then
      Velutex.Opcoes := Velutex.Opcoes + [TVelutexGeraColorantes];

    If chkOpcoes.Checked[2] Then
      Velutex.Opcoes := Velutex.Opcoes + [TVelutexGeraTintas];

    If Velutex.fProcessaArquivos Then
      fMensagem('', 'Tintas geradas com sucesso!', ['OK'])
    else
      fMensagem('', 'Não foi possível gerar as tintas!', ['OK']);

  Finally
    btnConfirmaGeracao.Enabled := True;
  End;
end;

procedure TfrmCadVelutexGerarArquivos.pRegistraAcao(strAcao: String);
begin
  memSaida.Lines.Add(DateTimeToStr(fNow()) + ' - ' + strAcao);
  Application.ProcessMessages;
end;

procedure TfrmCadVelutexGerarArquivos.pRegistraProgresso(intInicio, intAtual,
  intFinal: Integer);
begin
  Gauge1.MaxValue := intFinal;
  Gauge1.MinValue := intInicio;
  Gauge1.Progress := intAtual;
  pnlInfo.Caption := Format('Processando... %d / %d', [intAtual, intFinal]);
  Application.ProcessMessages;
end;


end.
