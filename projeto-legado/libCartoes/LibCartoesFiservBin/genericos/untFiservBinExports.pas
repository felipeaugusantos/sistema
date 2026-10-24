unit untFiservBinExports;

interface

Uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics,

     dxCore,

     untTFiservBinFuncoes, untILibCartoesWrapper, untILibCartoesFactory,
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

Uses untFiservBinBaixaCartoes, untFiservBinConciliacaoCartoes, untConciliacaoFiservBin;

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

  If Not Assigned(untTFiservBinFuncoes.VS_FuncoesExternas) Then
    untTFiservBinFuncoes.VS_FuncoesExternas := TLibCartoesFactory.Get;

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

  TFiservBinFuncoes.FExisteCampoLiberacaoTransferencia := TFiservBinFuncoes.CampoExiste('MOVCAR', 'MCA_TRFLIB');
  TLibCartoesFuncoes.FExisteCampoLiberacaoTransferencia := TFiservBinFuncoes.FExisteCampoLiberacaoTransferencia;
End;

procedure VerificaEstruturaTabelas; StdCall;
Begin
  TFiservBinFuncoes.VerificaEstrutraTabelas(True);
End;

procedure pAtualizaObjetoTelasAbertas(ATelaAbertas: ITelasAbertas); StdCall;
Begin
  If Not Assigned(untLibCartoesTelasAbertas.objTelasAbertas) Then
    untLibCartoesTelasAbertas.objTelasAbertas := ATelaAbertas;
End;

procedure ImportarCartoesArquivo(AAplicacao: HWND; APastaAutcom: String; ANomeEmpresa: String); StdCall;
Begin
  TFiservBinFuncoes.ImportarCartoesArquivo(AAplicacao,
                                          APastaAutcom,
                                          ANomeEmpresa);
End;

procedure SetStyleAutcom(AModoClassico: Boolean); StdCall;
Begin
  untTFiservBinFuncoes.VS_AutcomModoClassico := AModoClassico;
  TFiservBinFuncoes.CarregaEstiloAutcom;
End;

procedure ConciliacaoCartoesArquivo; StdCall;
Var
  LConciliacaoCartoes: TConciliacaoCartoes;
  blnReabre : Boolean;
  frmFiservBinBaixaCartoes: TfrmFiservBinBaixaCartoes;
  LTextoTrava: String;
begin
  blnReabre := True;

  While blnReabre Do
  Begin
    LTextoTrava := 'CONCILIACAO_BAIXA_CARTOES_FiservBin';

    If Not VS_FuncoesExternas.fILock_Unlock(LTextoTrava, True, False) Then
    Begin
      TFiservBinFuncoes.fMensagem('ATENÇÃO', 'A rotina de baixa/conciliação da operadora FiservBin está sendo utilizada por outra estação: ' +
                                    VS_FuncoesExternas.fIGetHostLock(LTextoTrava), ['&OK'], 1);
      Exit;
    End;

    TFiservBinFuncoes.pCriarFormularios(TfrmFiservBinBaixaCartoes, frmFiservBinBaixaCartoes);

    LConciliacaoCartoes := TConciliacaoFiservBin.Create;

    Try
      VS_FuncoesExternas.pIModificaStatusTimerTemMensagemPrincipal(False);

      LConciliacaoCartoes.strNomCon    := 'FiservBin';

      If LConciliacaoCartoes.fConciliaCartoes Then
      Begin
        LConciliacaoCartoes.cdsBaiCar.Filter := 'MCA_MARDES=''M'' ';
        LConciliacaoCartoes.cdsBaiCar.Filtered := True;

        If Assigned(frmFiservBinBaixaCartoes.cdsBaiCar) Then
          FreeAndNil(frmFiservBinBaixaCartoes.cdsBaiCar);

        frmFiservBinBaixaCartoes.cdsBaiCar := TFiservBinFuncoes.CriarClientDataSet(LConciliacaoCartoes.cdsBaiCar);
        frmFiservBinBaixaCartoes.cdsBaiCar.IndexFieldNames := LConciliacaoCartoes.cdsBaiCar.IndexFieldNames;

        frmFiservBinBaixaCartoes.blnConcil    := True;
        frmFiservBinBaixaCartoes.blnGraAju    := LConciliacaoCartoes.FBaixarAjustes;
        frmFiservBinBaixaCartoes.blnInconsist := LConciliacaoCartoes.FPossuiInconsistencia;
        frmFiservBinBaixaCartoes.objConcil    := LConciliacaoCartoes.objConcil;

        frmFiservBinBaixaCartoes.DataInicialConciliacao := LConciliacaoCartoes.DataInicialConciliacao;
        frmFiservBinBaixaCartoes.DataFinalConciliacao   := LConciliacaoCartoes.DataFinalConciliacao;
        frmFiservBinBaixaCartoes.ExibirCartoesPendente  := LConciliacaoCartoes.ExibirCartoesPendente;

        frmFiservBinBaixaCartoes.FiltrosRelatorio := LConciliacaoCartoes.FiltrosRelatorio;

        frmFiservBinBaixaCartoes.Caption      := 'Conciliação de Cartão de Crédito (FiservBin)';

        frmFiservBinBaixaCartoes.ShowModal;
      End;

      LConciliacaoCartoes.RemoverRelatorioConciliacao('untConciliacaoFiservBin');

      blnReabre := LConciliacaoCartoes.blnReabre;
    Finally
      VS_FuncoesExternas.pIModificaStatusTimerTemMensagemPrincipal(True);

      VS_FuncoesExternas.fILock_Unlock(LTextoTrava, False);

      FreeAndNil(LConciliacaoCartoes);
      FreeAndNil(frmFiservBinBaixaCartoes);

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

