unit untGetNetExports;

interface

Uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics,

     dxCore,

     untTGetnetFuncoes, untILibCartoesWrapper, untILibCartoesFactory,
     untLibCartoesTelasAbertas, untLibCartoesInterfacesTipos, untTLibCartoesFuncoes;

procedure dxInitialize; StdCall;

procedure dxFinalize; StdCall;

procedure InicializaObjetoLibCartoes(AObjetoLibCartoes: ILibCartoes); StdCall;

procedure VerificaEstruturaTabelas; StdCall;

procedure pAtualizaObjetoTelasAbertas(ATelaAbertas: ITelasAbertas); StdCall;

procedure ImportarCartoesArquivo(AAplicacao: HWND; APastaAutcom: String; ANomeEmpresa: String); StdCall;

procedure SetStyleAutcom(AModoClassico: Boolean); StdCall;

procedure ConciliacaoCartoesArquivo; StdCall;

procedure ExcluirArquivosImportados; StdCall;

Var
  FdxInitialize: Boolean;

implementation

Uses untGetnetBaixaCartoes, untGetnetConciliacaoCartoes, untConciliacaoGetnet,
     untGetNetExcluirArquivosImportadosCartoes;

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

  If Not Assigned(untTGetNetFuncoes.VS_FuncoesExternas) Then
    untTGetNetFuncoes.VS_FuncoesExternas := TLibCartoesFactory.Get;

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

  TGetNetFuncoes.FExisteCampoLiberacaoTransferencia := TGetNetFuncoes.CampoExiste('MOVCAR', 'MCA_TRFLIB');
  TLibCartoesFuncoes.FExisteCampoLiberacaoTransferencia := TGetNetFuncoes.FExisteCampoLiberacaoTransferencia;
End;

procedure VerificaEstruturaTabelas; StdCall;
Begin
  TGetnetFuncoes.VerificaEstrutraTabelas(True);
End;

procedure pAtualizaObjetoTelasAbertas(ATelaAbertas: ITelasAbertas); StdCall;
Begin
  If Not Assigned(untLibCartoesTelasAbertas.objTelasAbertas) Then
    untLibCartoesTelasAbertas.objTelasAbertas := ATelaAbertas;
End;

procedure ImportarCartoesArquivo(AAplicacao: HWND; APastaAutcom: String; ANomeEmpresa: String); StdCall;
Begin
  TGetnetFuncoes.ImportarCartoesArquivo(AAplicacao,
                                          APastaAutcom,
                                          ANomeEmpresa);
End;

procedure SetStyleAutcom(AModoClassico: Boolean); StdCall;
Begin
  untTGetnetFuncoes.VS_AutcomModoClassico := AModoClassico;
  TGetnetFuncoes.CarregaEstiloAutcom;
End;

procedure ConciliacaoCartoesArquivo; StdCall;
Var
  LConciliacaoCartoes: TConciliacaoCartoes;
  blnReabre : Boolean;
  frmGetnetBaixaCartoes: TfrmGetnetBaixaCartoes;
  LTextoTrava: String;
begin
  blnReabre := True;

  While blnReabre Do
  Begin
    LTextoTrava := 'CONCILIACAO_BAIXA_CARTOES_Getnet';

    If Not VS_FuncoesExternas.fILock_Unlock(LTextoTrava, True, False) Then
    Begin
      TGetnetFuncoes.fMensagem('ATENÇÃO', 'A rotina de baixa/conciliação da operadora Getnet está sendo utilizada por outra estação: ' +
                              VS_FuncoesExternas.fIGetHostLock(LTextoTrava), ['&OK'], 1);
      Exit;
    End;

    TGetnetFuncoes.pCriarFormularios(TfrmGetnetBaixaCartoes, frmGetnetBaixaCartoes);

    LConciliacaoCartoes := TConcilGetnet.Create;

    Try
      VS_FuncoesExternas.pIModificaStatusTimerTemMensagemPrincipal(False);

      LConciliacaoCartoes.strNomCon    := 'GETNET';

      If LConciliacaoCartoes.fConciliaCartoes Then
      Begin
        LConciliacaoCartoes.cdsBaiCar.Filter := 'MCA_MARDES=''M'' ';
        LConciliacaoCartoes.cdsBaiCar.Filtered := True;

        If Assigned(frmGetnetBaixaCartoes.cdsBaiCar) Then
          FreeAndNil(frmGetnetBaixaCartoes.cdsBaiCar);

        frmGetnetBaixaCartoes.cdsBaiCar := TGetnetFuncoes.CriarClientDataSet(LConciliacaoCartoes.cdsBaiCar);
        frmGetnetBaixaCartoes.cdsBaiCar.IndexFieldNames := LConciliacaoCartoes.cdsBaiCar.IndexFieldNames;

        frmGetnetBaixaCartoes.blnConcil    := True;
        frmGetnetBaixaCartoes.blnGraAju    := LConciliacaoCartoes.FBaixarAjustes;
        frmGetnetBaixaCartoes.blnInconsist := LConciliacaoCartoes.FPossuiInconsistencia;
        frmGetnetBaixaCartoes.objConcil    := LConciliacaoCartoes.objConcil;

        frmGetnetBaixaCartoes.DataInicialConciliacao := LConciliacaoCartoes.DataInicialConciliacao;
        frmGetnetBaixaCartoes.DataFinalConciliacao   := LConciliacaoCartoes.DataFinalConciliacao;
        frmGetnetBaixaCartoes.ExibirCartoesPendente  := LConciliacaoCartoes.ExibirCartoesPendente;

        frmGetnetBaixaCartoes.FiltrosRelatorio := LConciliacaoCartoes.FiltrosRelatorio;

        frmGetnetBaixaCartoes.Caption      := 'Conciliação de Cartão de Crédito (Getnet)';

        frmGetnetBaixaCartoes.ShowModal;
      End;

      LConciliacaoCartoes.RemoverRelatorioConciliacao('untConciliacaoGetnet');

      blnReabre := LConciliacaoCartoes.blnReabre;
    Finally
      VS_FuncoesExternas.pIModificaStatusTimerTemMensagemPrincipal(True);

      VS_FuncoesExternas.fILock_Unlock(LTextoTrava, False);

      FreeAndNil(LConciliacaoCartoes);
      FreeAndNil(frmGetnetBaixaCartoes);

      VS_FuncoesExternas.pITrimAppMemorySize;
    End;
  End;
End;

procedure ExcluirArquivosImportados; StdCall;
var
  LFrmGetnetExcluirArquivosImportadosCartoes: TfrmGetnetExcluirArquivosImportadosCartoes;
begin
  TGetnetFuncoes.pCriarFormularios(TfrmGetnetExcluirArquivosImportadosCartoes, LFrmGetnetExcluirArquivosImportadosCartoes);
  try
    try
      LFrmGetnetExcluirArquivosImportadosCartoes.pConfigurarOperadora;
      LFrmGetnetExcluirArquivosImportadosCartoes.ShowModal;
    except
      on E: Exception do
        VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmGetnetExcluirArquivosImportadosCartoes.pAbrirForm]');
    end;
  finally
    FreeAndNil(LFrmGetnetExcluirArquivosImportadosCartoes);
    VS_FuncoesExternas.pITrimAppMemorySize;
  end;
End;

Initialization
  FdxInitialize := False;

Finalization
  If FdxInitialize Then
    dxCore.dxFinalize;

  If Assigned(TLibCartoesFuncoes.FIconeAplicacao) Then
    FreeAndNil(TLibCartoesFuncoes.FIconeAplicacao);

end.

