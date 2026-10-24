unit untCieloExports;

interface

Uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics,

     dxCore,

     untTCieloFuncoes, untILibCartoesWrapper, untILibCartoesFactory,
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

Uses untCieloBaixaCartoes, untCieloConciliacaoCartoes, untConciliacaoCielo,
     untCieloExcluirArquivosImportadosCartoes;

procedure dxInitialize; StdCall;
Begin
  If FdxInitialize Then
    Exit;

  dxCore.dxInitialize;
  FdxInitialize := True;
End;

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

  If Not Assigned(untTCieloFuncoes.VS_FuncoesExternas) Then
    untTCieloFuncoes.VS_FuncoesExternas := TLibCartoesFactory.Get;

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

  TCieloFuncoes.FExisteCampoLiberacaoTransferencia := TCieloFuncoes.CampoExiste('MOVCAR', 'MCA_TRFLIB');
  TLibCartoesFuncoes.FExisteCampoLiberacaoTransferencia := TCieloFuncoes.FExisteCampoLiberacaoTransferencia;
End;

procedure VerificaEstruturaTabelas; StdCall;
Begin
  TCieloFuncoes.VerificaEstrutraTabelas(True);
End;

procedure pAtualizaObjetoTelasAbertas(ATelaAbertas: ITelasAbertas); StdCall;
Begin
  If Not Assigned(untLibCartoesTelasAbertas.objTelasAbertas) Then
    untLibCartoesTelasAbertas.objTelasAbertas := ATelaAbertas;
End;

procedure ImportarCartoesArquivo(AAplicacao: HWND; APastaAutcom: String; ANomeEmpresa: String); StdCall;
Begin
  TCieloFuncoes.ImportarCartoesArquivo(AAplicacao,
                                       APastaAutcom,
                                       ANomeEmpresa);
End;

procedure SetStyleAutcom(AModoClassico: Boolean); StdCall;
Begin
  untTCieloFuncoes.VS_AutcomModoClassico := AModoClassico;
  TCieloFuncoes.CarregaEstiloAutcom;
End;

procedure ConciliacaoCartoesArquivo; StdCall;
  Var
    LConciliacaoCartoes: TConcilCielo;

    blnReabre : Boolean;

    frmCieloBaixaCartoes: TfrmCieloBaixaCartoes;

    LTextoTrava: String;
begin
  blnReabre := True;

  While blnReabre Do
  Begin
    LTextoTrava := 'CONCILIACAO_BAIXA_CARTOES_CIELO';

    If Not VS_FuncoesExternas.fILock_Unlock(LTextoTrava, True, False) Then
    Begin
      TCieloFuncoes.fMensagem('ATENÇÃO', 'A rotina de baixa/conciliação da operadora CIELO está sendo utilizada por outra estação: ' +
                              VS_FuncoesExternas.fIGetHostLock(LTextoTrava), ['&OK'], 1);
      Exit;
    End;

    TCieloFuncoes.pCriarFormularios(TfrmCieloBaixaCartoes, frmCieloBaixaCartoes);

    LConciliacaoCartoes := TConcilCielo.Create;

    Try
      VS_FuncoesExternas.pIModificaStatusTimerTemMensagemPrincipal(False);
      LConciliacaoCartoes.strNomCon    := 'CIELO';

      If LConciliacaoCartoes.fConciliaCartoes Then
      Begin
        If Assigned(frmCieloBaixaCartoes.cdsBaiCar) Then
          FreeAndNil(frmCieloBaixaCartoes.cdsBaiCar);

        LConciliacaoCartoes.cdsBaiCar.Filter := 'MCA_MARDES=''M'' ';
        LConciliacaoCartoes.cdsBaiCar.Filtered := True;

        frmCieloBaixaCartoes.cdsBaiCar := TCieloFuncoes.CriarClientDataSet(LConciliacaoCartoes.cdsBaiCar);
        frmCieloBaixaCartoes.cdsBaiCar.IndexFieldNames := LConciliacaoCartoes.cdsBaiCar.IndexFieldNames;

        frmCieloBaixaCartoes.blnConcil    := True;
        frmCieloBaixaCartoes.blnGraAju    := LConciliacaoCartoes.FBaixarAjustes;
        frmCieloBaixaCartoes.blnInconsist := LConciliacaoCartoes.FPossuiInconsistencia;
        frmCieloBaixaCartoes.objConcil    := LConciliacaoCartoes.objConcil;

        frmCieloBaixaCartoes.DataInicialConciliacao := LConciliacaoCartoes.DataInicialConciliacao;
        frmCieloBaixaCartoes.DataFinalConciliacao   := LConciliacaoCartoes.DataFinalConciliacao;
        frmCieloBaixaCartoes.ExibirCartoesPendente  := LConciliacaoCartoes.ExibirCartoesPendente;

        frmCieloBaixaCartoes.FiltrosRelatorio := LConciliacaoCartoes.FiltrosRelatorio;

        frmCieloBaixaCartoes.Caption      := 'Conciliação de Cartão de Crédito (CIELO)';

        frmCieloBaixaCartoes.ShowModal;
      End;

      LConciliacaoCartoes.RemoverRelatorioConciliacao('untConciliacaoCielo');

      blnReabre := LConciliacaoCartoes.blnReabre;
    Finally
      VS_FuncoesExternas.pIModificaStatusTimerTemMensagemPrincipal(True);

      FreeAndNil(frmCieloBaixaCartoes);
      FreeAndNil(LConciliacaoCartoes);

      TCieloFuncoes.DestroiDicionariosCache;

      VS_FuncoesExternas.fILock_Unlock(LTextoTrava, False);

      VS_FuncoesExternas.pITrimAppMemorySize;
    End;
  End;
End;

procedure ExcluirArquivosImportados; StdCall;
var
  LFrmCieloExcluirArquivosImportadosCartoes: TfrmCieloExcluirArquivosImportadosCartoes;
begin
  TCieloFuncoes.pCriarFormularios(TfrmCieloExcluirArquivosImportadosCartoes, LFrmCieloExcluirArquivosImportadosCartoes);
  try
    try
      LFrmCieloExcluirArquivosImportadosCartoes.pConfigurarOperadora;
      LFrmCieloExcluirArquivosImportadosCartoes.ShowModal;
    except
      on E: Exception do
        VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmCieloExcluirArquivosImportadosCartoes.pAbrirForm]');
    end;
  finally
    TCieloFuncoes.DestroiDicionariosCache;
    FreeAndNil(LFrmCieloExcluirArquivosImportadosCartoes);
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
