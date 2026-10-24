unit untTExecucoesPastaCompra;

interface

uses
  untFuncoesSimples, cxProgressBar, Uni, DB, System.Classes, System.SysUtils,
  Winapi.Windows, untThreadUtils;

type
  TCallProgresso = procedure (posAtual: Integer; maxPostion: integer) of object;

  TCallMsg = procedure (AStrMsg: String; blnNoShow: Boolean = False) of object;

  TExecucoes = Class(TSafeThread)
    private
      FCallProgresso: TCallProgresso;
      FCallMsg: TCallMsg;
      FqryExecucao: TUniQuery;
      procedure CallpRotinas(AProcedure : String; AIntIndex: Integer);
    protected
      Procedure Execute; override;
    public
      Constructor Create(CallProgresso: TCallProgresso; CallMsg: TCallMsg); Reintroduce;
      Destructor Destroy; override;
      Property qryExecucao: TUniQuery read FqryExecucao;
  End;


implementation

uses
  untModulo;

{ TExecucoes }

constructor TExecucoes.Create(CallProgresso: TCallProgresso; CallMsg: TCallMsg);
begin
  inherited Create(True);
  FCallProgresso := CallProgresso;
  FCallMsg := CallMsg;
end;

destructor TExecucoes.Destroy;
begin
  inherited;
end;

procedure TExecucoes.CallpRotinas(AProcedure : String; AIntIndex: Integer);
begin
  If Terminated Then
    Exit;

  FqryExecucao.SQL.Clear;
  FqryExecucao.SQL.Add('CALL ' + AProcedure);
  FqryExecucao.ExecSQL;

  FCallProgresso(AIntIndex, 3);
End;

procedure TExecucoes.Execute;
var
  strProcName: String;
begin
  inherited;
  try
    FqryExecucao := fCriaQuery(Nil);
    try
      pLog('TExecucoes.Execute');
      Try
        strProcName := 'pRotinasNoturnasRecalculoGiroSaidaDias';
        FCallMsg('Executando: ' + strProcName, True);
        CallpRotinas(strProcName, 1);

        strProcName := 'pAtualizaSaldoPedidoCompra';
        FCallMsg('Executando: ' + strProcName, True);
        CallpRotinas(strProcName, 2);

        If fTipoPastaDeCompraGlobal Then
          strProcName := 'pRotinasNoturnasGeraPreOrcamentoCompraGlobal'
        Else
          strProcName := 'pRotinasNoturnasGeraPreOrcamentoCompra';
        FCallMsg('Executando: ' + strProcName, True);
        CallpRotinas(strProcName, 3);

        If Not Terminated Then
          FCallMsg('Execução concluída com sucesso!');
      Except On
        E:Exception Do
        Begin
          If Not Terminated Then
            FCallMsg('Erro ao executar procedure: ' + strProcName + '!' + #13 + E.Message);
        End;
      End;
    finally
      FreeAndNil(FqryExecucao);
    end;
  finally

  end;
end;

end.
