unit untStoneExports;

interface

Uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics,

     dxCore,

     untTStoneFuncoes, untILibCartoesWrapper, untILibCartoesFactory,
     untLibCartoesTelasAbertas, untLibCartoesInterfacesTipos, untTLibCartoesFuncoes;

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

Uses untStoneBaixaCartoes, untStoneConciliacaoCartoes, untConciliacaoStone;

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

  If Not Assigned(untTStoneFuncoes.VS_FuncoesExternas) Then
    untTStoneFuncoes.VS_FuncoesExternas := TLibCartoesFactory.Get;

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

  TStoneFuncoes.FExisteCampoLiberacaoTransferencia := TStoneFuncoes.CampoExiste('MOVCAR', 'MCA_TRFLIB');
  TLibCartoesFuncoes.FExisteCampoLiberacaoTransferencia := TStoneFuncoes.FExisteCampoLiberacaoTransferencia;
End;

procedure VerificaEstruturaTabelas; StdCall;
Begin
  TStoneFuncoes.VerificaEstrutraTabelas(False);
End;

procedure pAtualizaObjetoTelasAbertas(ATelaAbertas: ITelasAbertas); StdCall;
Begin
  If Not Assigned(untLibCartoesTelasAbertas.objTelasAbertas) Then
    untLibCartoesTelasAbertas.objTelasAbertas := ATelaAbertas;
End;

procedure ImportarCartoesAPI(AAplicacao: HWND; ANomeEmpresa: String); StdCall;
Begin
  TStoneFuncoes.ImportarCartoesAPI(AAplicacao,
                                   ANomeEmpresa);
End;

procedure SetStyleAutcom(AModoClassico: Boolean); StdCall;
Begin
  untTStoneFuncoes.VS_AutcomModoClassico := AModoClassico;
  TStoneFuncoes.CarregaEstiloAutcom;
End;

procedure ConciliacaoCartoesApi; StdCall;
Var
  LConciliacaoCartoes: TConciliacaoCartoes;

  blnReabre : Boolean;

  frmStoneBaixaCartoes: TfrmStoneBaixaCartoes;

  LTextoTrava,
  LItemRegistroConciliar: String;
begin
  blnReabre := True;

  While blnReabre Do
  Begin
    LTextoTrava := 'CONCILIACAO_BAIXA_CARTOES_STONE_API';

    If Not VS_FuncoesExternas.fILock_Unlock(LTextoTrava, True, False) Then
    Begin
      TStoneFuncoes.fMensagem('ATENÇÃO', 'A rotina de baixa/conciliação da operadora Stone Online está sendo utilizada por outra estação: ' +
                                  VS_FuncoesExternas.fIGetHostLock(LTextoTrava), ['&OK'], 1);
      Exit;
    End;

    TStoneFuncoes.pCriarFormularios(TfrmStoneBaixaCartoes, frmStoneBaixaCartoes);

    LConciliacaoCartoes := TConcilStone.Create;

    Try
      VS_FuncoesExternas.pIModificaStatusTimerTemMensagemPrincipal(False);

      LConciliacaoCartoes.strNomCon    := 'Stone API';

      If LConciliacaoCartoes.fConciliaCartoes Then
      Begin
        LConciliacaoCartoes.cdsBaiCar.Filter := 'MCA_MARDES=''M'' ';
        LConciliacaoCartoes.cdsBaiCar.Filtered := True;

        If Assigned(frmStoneBaixaCartoes.cdsBaiCar) Then
          FreeAndNil(frmStoneBaixaCartoes.cdsBaiCar);

        frmStoneBaixaCartoes.cdsBaiCar := TStoneFuncoes.CriarClientDataSet(LConciliacaoCartoes.cdsBaiCar);
        frmStoneBaixaCartoes.cdsBaiCar.IndexFieldNames := LConciliacaoCartoes.cdsBaiCar.IndexFieldNames;

        frmStoneBaixaCartoes.blnConcil    := True;
        frmStoneBaixaCartoes.blnGraAju    := LConciliacaoCartoes.FBaixarAjustes;
        frmStoneBaixaCartoes.blnInconsist := LConciliacaoCartoes.blnInconsist;
        frmStoneBaixaCartoes.objConcil    := LConciliacaoCartoes.objConcil;

        frmStoneBaixaCartoes.DataInicialConciliacao := LConciliacaoCartoes.DataInicialConciliacao;
        frmStoneBaixaCartoes.DataFinalConciliacao   := LConciliacaoCartoes.DataFinalConciliacao;
        frmStoneBaixaCartoes.ExibirCartoesPendente  := LConciliacaoCartoes.ExibirCartoesPendente;

        frmStoneBaixaCartoes.FiltrosRelatorio := LConciliacaoCartoes.FiltrosRelatorio;

        If Assigned(TConcilStone(LConciliacaoCartoes).ListaRegistrosConciliar) Then
        Begin
          frmStoneBaixaCartoes.RegistrosConciliar := TStringList.Create;
          For LItemRegistroConciliar In TConcilStone(LConciliacaoCartoes).ListaRegistrosConciliar Do
            frmStoneBaixaCartoes.RegistrosConciliar.Add(LItemRegistroConciliar);
        End;

        frmStoneBaixaCartoes.Caption      := 'Conciliação de Cartão de Crédito (Stone Online)';

        frmStoneBaixaCartoes.ShowModal;
      End;

      LConciliacaoCartoes.RemoverRelatorioConciliacao('untConciliacaoStoneAPI');

      blnReabre := LConciliacaoCartoes.blnReabre;
    Finally
      VS_FuncoesExternas.pIModificaStatusTimerTemMensagemPrincipal(True);

      VS_FuncoesExternas.fILock_Unlock(LTextoTrava, False);

      FreeAndNil(LConciliacaoCartoes);
      FreeAndNil(frmStoneBaixaCartoes);

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
