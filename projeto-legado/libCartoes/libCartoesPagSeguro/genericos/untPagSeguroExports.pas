unit untPagSeguroExports;

interface

Uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics,

     dxCore,

     untTPagSeguroFuncoes, untILibCartoesWrapper, untILibCartoesFactory,
     untLibCartoesTelasAbertas, untLibCartoesInterfacesTipos, untTLibCartoesFuncoes;

procedure dxInitialize; StdCall;

procedure dxFinalize; StdCall;

procedure InicializaObjetoLibCartoes(AObjetoLibCartoes: ILibCartoes); StdCall;

procedure VerificaEstruturaTabelas; StdCall;

procedure pAtualizaObjetoTelasAbertas(ATelaAbertas: ITelasAbertas); StdCall;

procedure ImportarCartoesArquivo(AAplicacao: HWND; APastaAutcom: String; ANomeEmpresa: String); StdCall;

procedure ImportarCartoesAPI(AAplicacao: HWND; ANomeEmpresa: String); StdCall;

procedure SetStyleAutcom(AModoClassico: Boolean); StdCall;

procedure ConciliacaoCartoesArquivo; StdCall;

procedure ConciliacaoCartoesApi; StdCall;

Var
  FdxInitialize: Boolean;

implementation

Uses untPagSeguroBaixaCartoes, untPagSeguroConciliacaoCartoes,
     untConciliacaoPagSeguro, untConciliacaoPagSeguroAPI;

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

  If Not Assigned(untTPagSeguroFuncoes.VS_FuncoesExternas) Then
    untTPagSeguroFuncoes.VS_FuncoesExternas := TLibCartoesFactory.Get;

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

  TPagSeguroFuncoes.FExisteCampoLiberacaoTransferencia := TPagSeguroFuncoes.CampoExiste('MOVCAR', 'MCA_TRFLIB');
  TLibCartoesFuncoes.FExisteCampoLiberacaoTransferencia := TPagSeguroFuncoes.FExisteCampoLiberacaoTransferencia;
End;

procedure VerificaEstruturaTabelas; StdCall;
Begin
  TPagSeguroFuncoes.VerificaEstrutraTabelas(True);
  TPagSeguroFuncoes.VerificaEstrutraTabelas(False);
End;

procedure pAtualizaObjetoTelasAbertas(ATelaAbertas: ITelasAbertas); StdCall;
Begin
  If Not Assigned(untLibCartoesTelasAbertas.objTelasAbertas) Then
    untLibCartoesTelasAbertas.objTelasAbertas := ATelaAbertas;
End;

procedure ImportarCartoesArquivo(AAplicacao: HWND; APastaAutcom: String; ANomeEmpresa: String); StdCall;
Begin
  TPagSeguroFuncoes.ImportarCartoesArquivo(AAplicacao,
                                           APastaAutcom,
                                           ANomeEmpresa);
End;

procedure ImportarCartoesAPI(AAplicacao: HWND; ANomeEmpresa: String); StdCall;
Begin
  TPagSeguroFuncoes.ImportarCartoesAPI(AAplicacao,
                                       ANomeEmpresa);
End;

procedure SetStyleAutcom(AModoClassico: Boolean); StdCall;
Begin
  untTPagSeguroFuncoes.VS_AutcomModoClassico := AModoClassico;
  TPagSeguroFuncoes.CarregaEstiloAutcom;
End;

procedure ConciliacaoCartoesArquivo; StdCall;
  Var
    LConciliacaoCartoes: TConciliacaoCartoes;

    blnReabre : Boolean;

    frmPagSeguroBaixaCartoes: TfrmPagSeguroBaixaCartoes;

    LTextoTrava: String;
begin
  blnReabre := True;

  While blnReabre Do
  Begin
    LTextoTrava := 'CONCILIACAO_BAIXA_CARTOES_PAGSEGURO_ARQUIVOS';

    If Not VS_FuncoesExternas.fILock_Unlock(LTextoTrava, True, False) Then
    Begin
      TPagSeguroFuncoes.fMensagem('ATENÇÃO', 'A rotina de baixa/conciliação da operadora PAGSEGURO está sendo utilizada por outra estação: ' +
                                  VS_FuncoesExternas.fIGetHostLock(LTextoTrava), ['&OK'], 1);
      Exit;
    End;

    TPagSeguroFuncoes.pCriarFormularios(TfrmPagSeguroBaixaCartoes, frmPagSeguroBaixaCartoes);

    LConciliacaoCartoes := TConcilPagSeguro.Create;

    Try
      VS_FuncoesExternas.pIModificaStatusTimerTemMensagemPrincipal(False);

      LConciliacaoCartoes.strNomCon := 'PAGSEGURO';

      If LConciliacaoCartoes.fConciliaCartoes Then
      Begin
        LConciliacaoCartoes.cdsBaiCar.Filter := 'MCA_MARDES=''M'' ';
        LConciliacaoCartoes.cdsBaiCar.Filtered := True;

        If Assigned(frmPagSeguroBaixaCartoes.cdsBaiCar) Then
          FreeAndNil(frmPagSeguroBaixaCartoes.cdsBaiCar);

        frmPagSeguroBaixaCartoes.cdsBaiCar := TPagSeguroFuncoes.CriarClientDataSet(LConciliacaoCartoes.cdsBaiCar);
        frmPagSeguroBaixaCartoes.cdsBaiCar.IndexFieldNames := LConciliacaoCartoes.cdsBaiCar.IndexFieldNames;

        frmPagSeguroBaixaCartoes.blnConcil    := True;
        frmPagSeguroBaixaCartoes.blnGraAju    := LConciliacaoCartoes.FBaixarAjustes;
        frmPagSeguroBaixaCartoes.blnInconsist := LConciliacaoCartoes.blnInconsist;
        frmPagSeguroBaixaCartoes.objConcil    := LConciliacaoCartoes.objConcil;

        frmPagSeguroBaixaCartoes.DataInicialConciliacao := LConciliacaoCartoes.DataInicialConciliacao;
        frmPagSeguroBaixaCartoes.DataFinalConciliacao   := LConciliacaoCartoes.DataFinalConciliacao;
        frmPagSeguroBaixaCartoes.ExibirCartoesPendente  := LConciliacaoCartoes.ExibirCartoesPendente;

        frmPagSeguroBaixaCartoes.FiltrosRelatorio := LConciliacaoCartoes.FiltrosRelatorio;

        frmPagSeguroBaixaCartoes.Caption      := 'Conciliação de Cartão de Crédito (PAGSEGURO)';

        frmPagSeguroBaixaCartoes.ShowModal;
      End;

      LConciliacaoCartoes.RemoverRelatorioConciliacao('untConciliacaoPagSeguro');

      blnReabre := LConciliacaoCartoes.blnReabre;
    Finally
      VS_FuncoesExternas.pIModificaStatusTimerTemMensagemPrincipal(True);

      VS_FuncoesExternas.fILock_Unlock(LTextoTrava, False);

      FreeAndNil(LConciliacaoCartoes);
      FreeAndNil(frmPagSeguroBaixaCartoes);

      TLibCartoesFuncoes.DestroiDicionariosCache;

      VS_FuncoesExternas.pITrimAppMemorySize;
    End;
  End;
End;

procedure ConciliacaoCartoesApi; StdCall;
  Var
    LConciliacaoCartoes: TConciliacaoCartoes;

    blnReabre : Boolean;

    frmPagSeguroBaixaCartoes: TfrmPagSeguroBaixaCartoes;

    LTextoTrava: String;
begin
  blnReabre := True;

  While blnReabre Do
  Begin
    LTextoTrava := 'CONCILIACAO_BAIXA_CARTOES_PAGSEGURO_API';

    If Not VS_FuncoesExternas.fILock_Unlock(LTextoTrava, True, False) Then
    Begin
      TPagSeguroFuncoes.fMensagem('ATENÇÃO', 'A rotina de baixa/conciliação da operadora PAGSEGURO Online está sendo utilizada por outra estação: ' +
                                  VS_FuncoesExternas.fIGetHostLock(LTextoTrava), ['&OK'], 1);
      Exit;
    End;

    TPagSeguroFuncoes.pCriarFormularios(TfrmPagSeguroBaixaCartoes, frmPagSeguroBaixaCartoes);

    LConciliacaoCartoes := TConcilPagSeguroAPI.Create;

    Try
      VS_FuncoesExternas.pIModificaStatusTimerTemMensagemPrincipal(False);

      LConciliacaoCartoes.strNomCon    := 'PAGSEGURO API';

      If LConciliacaoCartoes.fConciliaCartoes Then
      Begin
        LConciliacaoCartoes.cdsBaiCar.Filter := 'MCA_MARDES=''M'' ';
        LConciliacaoCartoes.cdsBaiCar.Filtered := True;

        If Assigned(frmPagSeguroBaixaCartoes.cdsBaiCar) Then
          FreeAndNil(frmPagSeguroBaixaCartoes.cdsBaiCar);

        frmPagSeguroBaixaCartoes.cdsBaiCar := TPagSeguroFuncoes.CriarClientDataSet(LConciliacaoCartoes.cdsBaiCar);
        frmPagSeguroBaixaCartoes.cdsBaiCar.IndexFieldNames := LConciliacaoCartoes.cdsBaiCar.IndexFieldNames;

        frmPagSeguroBaixaCartoes.blnConcil    := True;
        frmPagSeguroBaixaCartoes.blnGraAju    := LConciliacaoCartoes.FBaixarAjustes;
        frmPagSeguroBaixaCartoes.blnInconsist := LConciliacaoCartoes.blnInconsist;
        frmPagSeguroBaixaCartoes.objConcil    := LConciliacaoCartoes.objConcil;

        frmPagSeguroBaixaCartoes.DataInicialConciliacao := LConciliacaoCartoes.DataInicialConciliacao;
        frmPagSeguroBaixaCartoes.DataFinalConciliacao   := LConciliacaoCartoes.DataFinalConciliacao;
        frmPagSeguroBaixaCartoes.ExibirCartoesPendente  := LConciliacaoCartoes.ExibirCartoesPendente;

        frmPagSeguroBaixaCartoes.FiltrosRelatorio := LConciliacaoCartoes.FiltrosRelatorio;

        frmPagSeguroBaixaCartoes.Caption      := 'Conciliação de Cartão de Crédito (PAGSEGURO Online)';

        frmPagSeguroBaixaCartoes.ShowModal;
      End;

      LConciliacaoCartoes.RemoverRelatorioConciliacao('untConciliacaoPagSeguroAPI');

      blnReabre := LConciliacaoCartoes.blnReabre;
    Finally
      VS_FuncoesExternas.pIModificaStatusTimerTemMensagemPrincipal(True);

      VS_FuncoesExternas.fILock_Unlock(LTextoTrava, False);

      FreeAndNil(LConciliacaoCartoes);
      FreeAndNil(frmPagSeguroBaixaCartoes);

      TLibCartoesFuncoes.DestroiDicionariosCache;

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
