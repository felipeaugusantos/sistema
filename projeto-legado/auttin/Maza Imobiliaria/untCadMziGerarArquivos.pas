unit untCadMziGerarArquivos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, CheckLst, Gauges, AppEvnts, Menus, Buttons,
  ExtCtrls, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadMziGerarArquivos = class(TfrmPai)
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
  frmCadMziGerarArquivos: TfrmCadMziGerarArquivos;

implementation

uses untMazaImobiliariaDinamica, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadMziGerarArquivos.btnConfirmaGeracaoClick(Sender: TObject);
  Var
    MazaImobiliaria: TMazaImobiliariaDinamica;
begin
  Try
    memSaida.Clear;
    
    btnConfirmaGeracao.Enabled := False;

    MazaImobiliaria                   := TMazaImobiliariaDinamica.Create(Self);
    MazaImobiliaria.RegistraAcao      := pRegistraAcao;
    MazaImobiliaria.RegistraProgresso := pRegistraProgresso;

    If chkOpcoes.Checked[0] Then
      MazaImobiliaria.Opcoes := MazaImobiliaria.Opcoes + [TMazaImobiliariaGeraBases];

    If chkOpcoes.Checked[1] Then
      MazaImobiliaria.Opcoes := MazaImobiliaria.Opcoes + [TMazaImobiliariaGeraColorantes];

    If chkOpcoes.Checked[2] Then
      MazaImobiliaria.Opcoes := MazaImobiliaria.Opcoes + [TMazaImobiliariaGeraTintas];

    If MazaImobiliaria.fProcessaArquivos Then
      fMensagem('', 'Tintas geradas com sucesso!', ['OK'])
    else
      fMensagem('', 'Não foi possível gerar as tintas!', ['OK']);

  Finally
    btnConfirmaGeracao.Enabled := True;
  End;
end;

procedure TfrmCadMziGerarArquivos.pRegistraAcao(strAcao: String);
begin
  memSaida.Lines.Add(DateTimeToStr(fNow()) + ' - ' + strAcao);
  Application.ProcessMessages;
end;

procedure TfrmCadMziGerarArquivos.pRegistraProgresso(intInicio, intAtual,
  intFinal: Integer);
begin
  Gauge1.MaxValue := intFinal;
  Gauge1.MinValue := intInicio;
  Gauge1.Progress := intAtual;
  pnlInfo.Caption := Format('Processando... %d / %d', [intAtual, intFinal]);
  Application.ProcessMessages;
end;


end.
