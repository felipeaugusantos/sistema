unit untTThreadNotificacao;

interface

uses
  System.Classes, Vcl.ExtCtrls, untThreadUtils, Winapi.Windows,
  untMensagemSonora, untFuncoesSimples;

type
  TThreadNotificacao = class(TSafeThread)
  private
    { Private declarations }
    intDurNot: Integer;
    strPathSomAlerta: string;
  public
    Constructor Create(ATmpDurNot: Integer; APathSomAlerta: string = ''); Reintroduce;
  protected
    procedure Execute; override;
  end;

implementation

{ TThreadNotificacao }

constructor TThreadNotificacao.Create(ATmpDurNot: Integer; APathSomAlerta: string = '');
begin
  inherited Create(False);

  If ATmpDurNot < 1 Then          // proteção contra cfg zerada/negativa
    ATmpDurNot := 1;

  intDurNot        := ATmpDurNot;
  strPathSomAlerta := APathSomAlerta;
end;

procedure TThreadNotificacao.Execute;
  Var
    intCicloAtual: Integer;
    intIteracoes : Integer;
    intIter      : Integer;
begin
  inherited;
  pLog('TThreadNotificacao.Execute');

  intCicloAtual := 0;
  intIteracoes  := (intDurNot * 1000) div 500;   // quantas batidas de 500ms cabem na janela

  While (Not Terminated) Do
  Begin
    If ((intCicloAtual mod 2) = 0) Then
    Begin
      // Janela ATIVA: toca o som a cada 500 ms durante intDurNot segundos
      For intIter := 1 to intIteracoes Do
      Begin
        If Terminated Then Break;

        TfrmMensagemSonora.pTocar(strPathSomAlerta);

        // ThreadSleep do TSafeThread: dorme em chunks de 10ms checando
        // CheckTerminated; sai imediato quando Terminate for chamado.
        ThreadSleep(500);
      End;
    End
    Else
    Begin
      // Janela SILÊNCIO: bloqueia intDurNot segundos sem consumir CPU
      ThreadSleep(intDurNot * 1000);
    End;

    Inc(intCicloAtual);
  End;
End;

end.
