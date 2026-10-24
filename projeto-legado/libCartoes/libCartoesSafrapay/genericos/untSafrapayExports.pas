unit untSafrapayExports;

interface

Uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics,

     dxCore,

     untTSafrapayFuncoes, untILibCartoesWrapper, untILibCartoesFactory,
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

Uses untSafrapayBaixaCartoes, untSafrapayConciliacaoCartoes, untConciliacaoSafrapay;

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

  If Not Assigned(untTSafraPayFuncoes.VS_FuncoesExternas) Then
    untTSafrapayFuncoes.VS_FuncoesExternas := TLibCartoesFactory.Get;

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

  TSafrapayFuncoes.FExisteCampoLiberacaoTransferencia := TSafrapayFuncoes.CampoExiste('MOVCAR', 'MCA_TRFLIB');
  TLibCartoesFuncoes.FExisteCampoLiberacaoTransferencia := TSafrapayFuncoes.FExisteCampoLiberacaoTransferencia;
End;

procedure VerificaEstruturaTabelas; StdCall;
Begin
  TSafrapayFuncoes.VerificaEstrutraTabelas(True);
End;

procedure pAtualizaObjetoTelasAbertas(ATelaAbertas: ITelasAbertas); StdCall;
Begin
  If Not Assigned(untLibCartoesTelasAbertas.objTelasAbertas) Then
    untLibCartoesTelasAbertas.objTelasAbertas := ATelaAbertas;
End;

procedure ImportarCartoesArquivo(AAplicacao: HWND; APastaAutcom: String; ANomeEmpresa: String); StdCall;
Begin
  TSafrapayFuncoes.ImportarCartoesArquivo(AAplicacao,
                                          APastaAutcom,
                                          ANomeEmpresa);
End;

procedure SetStyleAutcom(AModoClassico: Boolean); StdCall;
Begin
  untTSafrapayFuncoes.VS_AutcomModoClassico := AModoClassico;
  TSafrapayFuncoes.CarregaEstiloAutcom;
End;

procedure ConciliacaoCartoesArquivo; StdCall;
Var
  LConciliacaoCartoes: TConciliacaoCartoes;
  blnReabre : Boolean;
  frmSafrapayBaixaCartoes: TfrmSafrapayBaixaCartoes;
  LTextoTrava: String;
begin
  blnReabre := True;

  While blnReabre Do
  Begin
    LTextoTrava := 'CONCILIACAO_BAIXA_CARTOES_Safrapay';

    If Not VS_FuncoesExternas.fILock_Unlock(LTextoTrava, True, False) Then
    Begin
      TSafraPayFuncoes.fMensagem('ATENÇÃO', 'A rotina de baixa/conciliação da operadora Safrapay está sendo utilizada por outra estação: ' +
                                 VS_FuncoesExternas.fIGetHostLock(LTextoTrava), ['&OK'], 1);
      Exit;
    End;

    TSafrapayFuncoes.pCriarFormularios(TfrmSafrapayBaixaCartoes, frmSafrapayBaixaCartoes);

    LConciliacaoCartoes := TConcilSafrapay.Create;

    Try
      VS_FuncoesExternas.pIModificaStatusTimerTemMensagemPrincipal(False);

      LConciliacaoCartoes.strNomCon    := 'Safrapay';

      If LConciliacaoCartoes.fConciliaCartoes Then
      Begin
        LConciliacaoCartoes.cdsBaiCar.Filter := 'MCA_MARDES=''M'' ';
        LConciliacaoCartoes.cdsBaiCar.Filtered := True;

        If Assigned(frmSafrapayBaixaCartoes.cdsBaiCar) Then
          FreeAndNil(frmSafrapayBaixaCartoes.cdsBaiCar);

        frmSafrapayBaixaCartoes.cdsBaiCar := TSafrapayFuncoes.CriarClientDataSet(LConciliacaoCartoes.cdsBaiCar);
        frmSafrapayBaixaCartoes.cdsBaiCar.IndexFieldNames := LConciliacaoCartoes.cdsBaiCar.IndexFieldNames;

        frmSafrapayBaixaCartoes.blnConcil    := True;
        frmSafrapayBaixaCartoes.blnGraAju    := LConciliacaoCartoes.FBaixarAjustes;
        frmSafrapayBaixaCartoes.blnInconsist := LConciliacaoCartoes.FPossuiInconsistencia;
        frmSafrapayBaixaCartoes.objConcil    := LConciliacaoCartoes.objConcil;

        frmSafrapayBaixaCartoes.DataInicialConciliacao := LConciliacaoCartoes.DataInicialConciliacao;
        frmSafrapayBaixaCartoes.DataFinalConciliacao   := LConciliacaoCartoes.DataFinalConciliacao;
        frmSafrapayBaixaCartoes.ExibirCartoesPendente  := LConciliacaoCartoes.ExibirCartoesPendente;

        frmSafrapayBaixaCartoes.FiltrosRelatorio := LConciliacaoCartoes.FiltrosRelatorio;

        frmSafrapayBaixaCartoes.Caption      := 'Conciliação de Cartão de Crédito (Safrapay)';

        frmSafrapayBaixaCartoes.ShowModal;
      End;

      LConciliacaoCartoes.RemoverRelatorioConciliacao('untConciliacaoSafrapay');

      blnReabre := LConciliacaoCartoes.blnReabre;
    Finally
      VS_FuncoesExternas.pIModificaStatusTimerTemMensagemPrincipal(True);

      VS_FuncoesExternas.fILock_Unlock(LTextoTrava, False);

      FreeAndNil(LConciliacaoCartoes);
      FreeAndNil(frmSafrapayBaixaCartoes);

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

