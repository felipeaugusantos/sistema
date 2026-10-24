unit untCadFutGerarArquivos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, CheckLst, Gauges, AppEvnts, Menus, Buttons,
  ExtCtrls, BitBtnLockedIncrem;

type
  TfrmCadFutGerarArquivos = class(TfrmPai)
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
  frmCadFutGerarArquivos: TfrmCadFutGerarArquivos;

implementation

uses untFuturaDinamica, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadFutGerarArquivos.btnConfirmaGeracaoClick(Sender: TObject);
  Var
    futura: TFuturaImobiliariaDinamica;
begin
  Try
    btnConfirmaGeracao.Enabled := False;
    
    futura := TFuturaImobiliariaDinamica.Create(Self);
    futura.RegistraAcao := pRegistraAcao;
    futura.RegistraProgresso := pRegistraProgresso;

    ////[TFuturaGeraBases, TFuturaGeraColorantes, TFuturaGeraTintas]

    If chkOpcoes.Checked[0] Then
      futura.Opcoes := futura.Opcoes + [TFuturaGeraBases];

    If chkOpcoes.Checked[1] Then
      futura.Opcoes := futura.Opcoes + [TFuturaGeraColorantes];

    If chkOpcoes.Checked[2] Then
      futura.Opcoes := futura.Opcoes + [TFuturaGeraTintas];

    If futura.fProcessaArquivos Then
      fMensagem('', 'Tintas geradas com sucesso!', ['OK']);
  Finally
    btnConfirmaGeracao.Enabled := True;
  End;
end;

procedure TfrmCadFutGerarArquivos.pRegistraAcao(strAcao: String);
begin
  memSaida.Lines.Add(DateTimeToStr(Now()) + ' - ' + strAcao);
  Application.ProcessMessages;
end;

procedure TfrmCadFutGerarArquivos.pRegistraProgresso(intInicio, intAtual,
  intFinal: Integer);
begin
  Gauge1.MaxValue := intFinal;
  Gauge1.MinValue := intInicio;
  Gauge1.Progress := intAtual;
  pnlInfo.Caption := Format('Processando... %d / %d', [intAtual, intFinal]);
  Application.ProcessMessages;
end;

end.
