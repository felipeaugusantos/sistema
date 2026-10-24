unit untBanrisulExports;

interface

Uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics,

     dxCore,

     untTBanrisulFuncoes, untILibCartoesWrapper, untILibCartoesFactory,
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

Uses untBanrisulBaixaCartoes, untBanrisulConciliacaoCartoes, untConciliacaoBanrisul;

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

  If Not Assigned(untTBanrisulFuncoes.VS_FuncoesExternas) Then
    untTBanrisulFuncoes.VS_FuncoesExternas := TLibCartoesFactory.Get;

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

  TBanrisulFuncoes.FExisteCampoLiberacaoTransferencia := TBanrisulFuncoes.CampoExiste('MOVCAR', 'MCA_TRFLIB');
  TLibCartoesFuncoes.FExisteCampoLiberacaoTransferencia := TBanrisulFuncoes.FExisteCampoLiberacaoTransferencia;
End;

procedure VerificaEstruturaTabelas; StdCall;
Begin
  TBanrisulFuncoes.VerificaEstrutraTabelas(True);
End;

procedure pAtualizaObjetoTelasAbertas(ATelaAbertas: ITelasAbertas); StdCall;
Begin
  If Not Assigned(untLibCartoesTelasAbertas.objTelasAbertas) Then
    untLibCartoesTelasAbertas.objTelasAbertas := ATelaAbertas;
End;

procedure ImportarCartoesArquivo(AAplicacao: HWND; APastaAutcom: String; ANomeEmpresa: String); StdCall;
Begin
  TBanrisulFuncoes.ImportarCartoesArquivo(AAplicacao,
                                          APastaAutcom,
                                          ANomeEmpresa);
End;

procedure SetStyleAutcom(AModoClassico: Boolean); StdCall;
Begin
  untTBanrisulFuncoes.VS_AutcomModoClassico := AModoClassico;
  TBanrisulFuncoes.CarregaEstiloAutcom;
End;

procedure ConciliacaoCartoesArquivo; StdCall;
Var
  LConciliacaoCartoes: TConciliacaoCartoes;
  blnReabre : Boolean;
  frmBanrisulBaixaCartoes: TfrmBanrisulBaixaCartoes;
  LTextoTrava: String;
begin
  blnReabre := True;

  While blnReabre Do
  Begin
    LTextoTrava := 'CONCILIACAO_BAIXA_CARTOES_Banrisul';

    If Not VS_FuncoesExternas.fILock_Unlock(LTextoTrava, True, False) Then
    Begin
      TBanrisulFuncoes.fMensagem('ATENÇÃO', 'A rotina de baixa/conciliação da operadora Banrisul está sendo utilizada por outra estação: ' +
                              VS_FuncoesExternas.fIGetHostLock(LTextoTrava), ['&OK'], 1);
      Exit;
    End;

    TBanrisulFuncoes.pCriarFormularios(TfrmBanrisulBaixaCartoes, frmBanrisulBaixaCartoes);

    LConciliacaoCartoes := TConciliacaoBanrisul.Create;

    Try
      VS_FuncoesExternas.pIModificaStatusTimerTemMensagemPrincipal(False);

      LConciliacaoCartoes.strNomCon    := 'Banrisul';

      If LConciliacaoCartoes.fConciliaCartoes Then
      Begin
        LConciliacaoCartoes.cdsBaiCar.Filter := 'MCA_MARDES=''M'' ';
        LConciliacaoCartoes.cdsBaiCar.Filtered := True;

        If Assigned(frmBanrisulBaixaCartoes.cdsBaiCar) Then
          FreeAndNil(frmBanrisulBaixaCartoes.cdsBaiCar);

        frmBanrisulBaixaCartoes.cdsBaiCar := TBanrisulFuncoes.CriarClientDataSet(LConciliacaoCartoes.cdsBaiCar);
        frmBanrisulBaixaCartoes.cdsBaiCar.IndexFieldNames := LConciliacaoCartoes.cdsBaiCar.IndexFieldNames;

        frmBanrisulBaixaCartoes.blnConcil    := True;
        frmBanrisulBaixaCartoes.blnGraAju    := LConciliacaoCartoes.FBaixarAjustes;
        frmBanrisulBaixaCartoes.blnInconsist := LConciliacaoCartoes.FPossuiInconsistencia;
        frmBanrisulBaixaCartoes.objConcil    := LConciliacaoCartoes.objConcil;

        frmBanrisulBaixaCartoes.DataInicialConciliacao := LConciliacaoCartoes.DataInicialConciliacao;
        frmBanrisulBaixaCartoes.DataFinalConciliacao   := LConciliacaoCartoes.DataFinalConciliacao;
        frmBanrisulBaixaCartoes.ExibirCartoesPendente  := LConciliacaoCartoes.ExibirCartoesPendente;

        frmBanrisulBaixaCartoes.FiltrosRelatorio := LConciliacaoCartoes.FiltrosRelatorio;

        frmBanrisulBaixaCartoes.Caption      := 'Conciliação de Cartão de Crédito (Banrisul)';

        frmBanrisulBaixaCartoes.ShowModal;
      End;

      LConciliacaoCartoes.RemoverRelatorioConciliacao('untConciliacaoBanrisul');

      blnReabre := LConciliacaoCartoes.blnReabre;
    Finally
      VS_FuncoesExternas.pIModificaStatusTimerTemMensagemPrincipal(True);

      VS_FuncoesExternas.fILock_Unlock(LTextoTrava, False);

      FreeAndNil(LConciliacaoCartoes);
      FreeAndNil(frmBanrisulBaixaCartoes);

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

