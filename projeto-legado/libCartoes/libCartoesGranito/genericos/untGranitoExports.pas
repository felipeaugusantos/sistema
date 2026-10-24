unit untGranitoExports;

interface

Uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics,

     dxCore,

     untTGranitoFuncoes, untILibCartoesWrapper, untILibCartoesFactory,
     untLibCartoesTelasAbertas, untLibCartoesInterfacesTipos, untTLibCartoesFuncoes;

procedure dxInitialize; StdCall;

procedure dxFinalize; StdCall;

procedure InicializaObjetoLibCartoes(AObjetoLibCartoes: ILibCartoes); StdCall;

procedure VerificaEstruturaTabelas; StdCall;

procedure pAtualizaObjetoTelasAbertas(ATelaAbertas: ITelasAbertas); StdCall;

procedure ImportarCartoesArquivo(AAplicacao: HWND; APastaAutcom: String; ANomeEmpresa: String); StdCall;

procedure SetStyleAutcom(AModoClassico: Boolean); StdCall;

procedure ConciliacaoCartoesArquivo; StdCall;

Var
  FdxInitialize: Boolean;

implementation

Uses untGranitoBaixaCartoes, untGranitoConciliacaoCartoes, untConciliacaoGranito;

procedure dxInitialize; StdCall;
begin
  If FdxInitialize Then
    Exit;

  dxCore.dxInitialize;
  FdxInitialize := True;
end;

procedure dxFinalize; StdCall;
Begin
  If Not FdxInitialize Then
    Exit;

  dxCore.dxFinalize;
End;

procedure InicializaObjetoLibCartoes(AObjetoLibCartoes: ILibCartoes); StdCall;
  Var
    LStream: TMemoryStream;
Begin
  TLibCartoesFactory.Registrar(AObjetoLibCartoes);

  If Not Assigned(untTGranitoFuncoes.VS_FuncoesExternas) Then
    untTGranitoFuncoes.VS_FuncoesExternas := TLibCartoesFactory.Get;

  If Not Assigned(untTLibCartoesFuncoes.VS_FuncoesExternas) Then
    untTLibCartoesFuncoes.VS_FuncoesExternas := TLibCartoesFactory.Get;

  LStream := Nil;
  If Not Assigned(TLibCartoesFuncoes.FIconeAplicacao) Then
  Begin
    Try
      LStream := TLibCartoesFactory.Get.fIGetIconApplication;
      TLibCartoesFuncoes.FIconeAplicacao := TIcon.Create;
      TLibCartoesFuncoes.FIconeAplicacao.LoadFromStream(LStream);
    Finally
      If Assigned(LStream) Then
        FreeAndNil(LStream);
    End;
  End;

  TGranitoFuncoes.FExisteCampoLiberacaoTransferencia := TGranitoFuncoes.CampoExiste('MOVCAR', 'MCA_TRFLIB');
  TLibCartoesFuncoes.FExisteCampoLiberacaoTransferencia := TGranitoFuncoes.FExisteCampoLiberacaoTransferencia;
End;

procedure VerificaEstruturaTabelas; StdCall;
Begin
  TGranitoFuncoes.VerificaEstrutraTabelas(True);
End;

procedure pAtualizaObjetoTelasAbertas(ATelaAbertas: ITelasAbertas); StdCall;
Begin
  If Not Assigned(untLibCartoesTelasAbertas.objTelasAbertas) Then
    untLibCartoesTelasAbertas.objTelasAbertas := ATelaAbertas;
End;

procedure ImportarCartoesArquivo(AAplicacao: HWND; APastaAutcom: String; ANomeEmpresa: String); StdCall;
Begin
  TGranitoFuncoes.ImportarCartoesArquivo(AAplicacao,
                                          APastaAutcom,
                                          ANomeEmpresa);
End;

procedure SetStyleAutcom(AModoClassico: Boolean); StdCall;
Begin
  untTGranitoFuncoes.VS_AutcomModoClassico := AModoClassico;
  TGranitoFuncoes.CarregaEstiloAutcom;
End;

procedure ConciliacaoCartoesArquivo; StdCall;
Var
  LConciliacaoCartoes: TConciliacaoCartoes;
  blnReabre : Boolean;
  frmGranitoBaixaCartoes: TfrmGranitoBaixaCartoes;
  LTextoTrava: String;
begin
  blnReabre := True;

  While blnReabre Do
  Begin
    LTextoTrava := 'CONCILIACAO_BAIXA_CARTOES_Granito';

    If Not VS_FuncoesExternas.fILock_Unlock(LTextoTrava, True, False) Then
    Begin
      TGranitoFuncoes.fMensagem('ATENÇÃO', 'A rotina de baixa/conciliação da operadora Granito está sendo utilizada por outra estação: ' +
                                    VS_FuncoesExternas.fIGetHostLock(LTextoTrava), ['&OK'], 1);
      Exit;
    End;

    TGranitoFuncoes.pCriarFormularios(TfrmGranitoBaixaCartoes, frmGranitoBaixaCartoes);

    LConciliacaoCartoes := TConciliacaoGranito.Create;

    Try
      VS_FuncoesExternas.pIModificaStatusTimerTemMensagemPrincipal(False);

      LConciliacaoCartoes.strNomCon    := 'Granito';

      If LConciliacaoCartoes.fConciliaCartoes Then
      Begin
        LConciliacaoCartoes.cdsBaiCar.Filter := 'MCA_MARDES=''M'' ';
        LConciliacaoCartoes.cdsBaiCar.Filtered := True;

        If Assigned(frmGranitoBaixaCartoes.cdsBaiCar) Then
          FreeAndNil(frmGranitoBaixaCartoes.cdsBaiCar);

        frmGranitoBaixaCartoes.cdsBaiCar := TGranitoFuncoes.CriarClientDataSet(LConciliacaoCartoes.cdsBaiCar);
        frmGranitoBaixaCartoes.cdsBaiCar.IndexFieldNames := LConciliacaoCartoes.cdsBaiCar.IndexFieldNames;

        frmGranitoBaixaCartoes.blnConcil    := True;
        frmGranitoBaixaCartoes.blnGraAju    := LConciliacaoCartoes.FBaixarAjustes;
        frmGranitoBaixaCartoes.blnInconsist := LConciliacaoCartoes.FPossuiInconsistencia;
        frmGranitoBaixaCartoes.objConcil    := LConciliacaoCartoes.objConcil;

        frmGranitoBaixaCartoes.DataInicialConciliacao := LConciliacaoCartoes.DataInicialConciliacao;
        frmGranitoBaixaCartoes.DataFinalConciliacao   := LConciliacaoCartoes.DataFinalConciliacao;
        frmGranitoBaixaCartoes.ExibirCartoesPendente  := LConciliacaoCartoes.ExibirCartoesPendente;

        frmGranitoBaixaCartoes.FiltrosRelatorio := LConciliacaoCartoes.FiltrosRelatorio;

        frmGranitoBaixaCartoes.Caption      := 'Conciliação de Cartão de Crédito (Granito)';

        frmGranitoBaixaCartoes.ShowModal;
      End;

      LConciliacaoCartoes.RemoverRelatorioConciliacao('untConciliacaoGranito');

      blnReabre := LConciliacaoCartoes.blnReabre;
    Finally
      VS_FuncoesExternas.pIModificaStatusTimerTemMensagemPrincipal(True);

      VS_FuncoesExternas.fILock_Unlock(LTextoTrava, False);

      FreeAndNil(LConciliacaoCartoes);
      FreeAndNil(frmGranitoBaixaCartoes);

      VS_FuncoesExternas.pITrimAppMemorySize;
    End;
  End;
End;

Initialization
  FdxInitialize := False;

Finalization
  If FdxInitialize Then
    dxFinalize;

  If Assigned(TLibCartoesFuncoes.FIconeAplicacao) Then
    FreeAndNil(TLibCartoesFuncoes.FIconeAplicacao);

end.

