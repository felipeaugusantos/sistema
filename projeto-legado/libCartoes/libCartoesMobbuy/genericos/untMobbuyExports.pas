unit untMobbuyExports;

interface

Uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics,

     dxCore,

     untTMobbuyFuncoes, untILibCartoesWrapper, untILibCartoesFactory,
     untLibCartoesTelasAbertas, untLibCartoesInterfacesTipos, untTLibCartoesFuncoes,
     untConciliacaoMobbuyAPI;

procedure dxInitialize; StdCall;

procedure dxFinalize; StdCall;

procedure InicializaObjetoLibCartoes(AObjetoLibCartoes: ILibCartoes); StdCall;

procedure VerificaEstruturaTabelas; StdCall;

procedure pAtualizaObjetoTelasAbertas(ATelaAbertas: ITelasAbertas); StdCall;

procedure ImportarCartoesAPI(AAplicacao: HWND; ANomeEmpresa: String); StdCall;

procedure SetStyleAutcom(AModoClassico: Boolean); StdCall;

procedure ConciliacaoCartoesApi; StdCall;

Var
  FdxInitialize: Boolean;

implementation

Uses untMobbuyBaixaCartoes;

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

  If Not Assigned(untTMobbuyFuncoes.VS_FuncoesExternas) Then
    untTMobbuyFuncoes.VS_FuncoesExternas := TLibCartoesFactory.Get;

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

  TMobbuyFuncoes.FExisteCampoLiberacaoTransferencia := TMobbuyFuncoes.CampoExiste('MOVCAR', 'MCA_TRFLIB');
  TLibCartoesFuncoes.FExisteCampoLiberacaoTransferencia := TMobbuyFuncoes.FExisteCampoLiberacaoTransferencia;
End;

procedure VerificaEstruturaTabelas; StdCall;
Begin
  TMobbuyFuncoes.VerificaEstrutraTabelas(False);
End;

procedure pAtualizaObjetoTelasAbertas(ATelaAbertas: ITelasAbertas); StdCall;
Begin
  If Not Assigned(untLibCartoesTelasAbertas.objTelasAbertas) Then
    untLibCartoesTelasAbertas.objTelasAbertas := ATelaAbertas;
End;

procedure ImportarCartoesAPI(AAplicacao: HWND; ANomeEmpresa: String); StdCall;
Begin
  TMobbuyFuncoes.ImportarCartoesAPI(AAplicacao,
                                      ANomeEmpresa);
End;

procedure SetStyleAutcom(AModoClassico: Boolean); StdCall;
Begin
  untTMobbuyFuncoes.VS_AutcomModoClassico := AModoClassico;
  TMobbuyFuncoes.CarregaEstiloAutcom;
End;


procedure ConciliacaoCartoesApi; StdCall;
  Var
    LConciliacaoCartoes: TConciliacaoMobbuyAPI;
    blnReabre : Boolean;
    frmMobbuyBaixaCartoes: TfrmMobbuyBaixaCartoes;
    LTextoTrava: String;
begin
  blnReabre := True;

  While blnReabre Do
  Begin
    LTextoTrava := 'CONCILIACAO_BAIXA_CARTOES_SEMPRE_PRONTO_API';

    If Not VS_FuncoesExternas.fILock_Unlock(LTextoTrava, True, False) Then
    Begin
      TMobbuyFuncoes.fMensagem('ATENÇÃO', 'A rotina de baixa/conciliação da operadora SEMPRE PRONTO Online está sendo utilizada por outra estação: ' +
                               VS_FuncoesExternas.fIGetHostLock(LTextoTrava), ['&OK'], 1);
      Exit;
    End;

    TMobbuyFuncoes.pCriarFormularios(TfrmMobbuyBaixaCartoes, frmMobbuyBaixaCartoes);

    LConciliacaoCartoes := TConciliacaoMobbuyAPI.Create;

    Try
      LConciliacaoCartoes.strNomCon    := 'SEMPRE PRONTO API';

      If LConciliacaoCartoes.fConciliaCartoes Then
      Begin
        LConciliacaoCartoes.cdsBaiCar.Filter := 'MCA_MARDES=''M'' ';
        LConciliacaoCartoes.cdsBaiCar.Filtered := True;

        If Assigned(frmMobbuyBaixaCartoes.cdsBaiCar) Then
          FreeAndNil(frmMobbuyBaixaCartoes.cdsBaiCar);

        frmMobbuyBaixaCartoes.cdsBaiCar := TMobbuyFuncoes.CriarClientDataSet(LConciliacaoCartoes.cdsBaiCar);
        frmMobbuyBaixaCartoes.cdsBaiCar.IndexFieldNames := LConciliacaoCartoes.cdsBaiCar.IndexFieldNames;

        frmMobbuyBaixaCartoes.blnConcil    := True;
        frmMobbuyBaixaCartoes.blnGraAju    := LConciliacaoCartoes.FBaixarAjustes;
        frmMobbuyBaixaCartoes.blnInconsist := LConciliacaoCartoes.FPossuiInconsistencia;
        frmMobbuyBaixaCartoes.objConcil    := LConciliacaoCartoes.objConcil;

        frmMobbuyBaixaCartoes.DataInicialConciliacao := LConciliacaoCartoes.DataInicialConciliacao;
        frmMobbuyBaixaCartoes.DataFinalConciliacao   := LConciliacaoCartoes.DataFinalConciliacao;
        frmMobbuyBaixaCartoes.ExibirCartoesPendente  := LConciliacaoCartoes.ExibirCartoesPendente;

        frmMobbuyBaixaCartoes.FiltrosRelatorio := LConciliacaoCartoes.FiltrosRelatorio;

        frmMobbuyBaixaCartoes.Caption      := 'Conciliação de Cartão de Crédito (SEMPRE PRONTO API)';

        frmMobbuyBaixaCartoes.ShowModal;
      End;

      LConciliacaoCartoes.RemoverRelatorioConciliacao('untConciliacaoMobbuyAPI');

      blnReabre := LConciliacaoCartoes.blnReabre;
    Finally
      VS_FuncoesExternas.fILock_Unlock(LTextoTrava, False);

      FreeAndNil(LConciliacaoCartoes);
      FreeAndNil(frmMobbuyBaixaCartoes);
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
