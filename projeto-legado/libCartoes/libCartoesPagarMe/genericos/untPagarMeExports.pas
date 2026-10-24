unit untPagarMeExports;

interface

Uses Winapi.Windows, System.SysUtils, Vcl.Forms, System.Classes, Vcl.Graphics,

     dxCore,

     untTLibCartoesFuncoes, untTPagarMeFuncoes, untILibCartoesWrapper,
     untILibCartoesFactory, untLibCartoesTelasAbertas,
     untLibCartoesInterfacesTipos;

procedure dxInitialize; StdCall;

procedure dxFinalize; StdCall;

procedure InicializaObjetoLibCartoes(AObjetoLibCartoes: ILibCartoes); StdCall;

procedure VerificaEstruturaTabelas; StdCall;

procedure pAtualizaObjetoTelasAbertas(ATelaAbertas: ITelasAbertas); StdCall;

procedure ImportarCartoesAPI(AAplicacao: HWND; ANomeEmpresa: String); StdCall;

procedure SetStyleAutcom(AModoClassico: Boolean); StdCall;

procedure ConciliacaoCartoesApi; StdCall;

function GetDadosFiltroImportacaoAPI: TDadosImportacaoConfirmacao; StdCall;

Var
  FdxInitialize: Boolean;

implementation
Uses untPagarMeBaixaRecebiveisMkt;

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
  FdxInitialize := False;
End;

procedure InicializaObjetoLibCartoes(AObjetoLibCartoes: ILibCartoes); StdCall;
  Var
    LStream: TMemoryStream;
Begin
  TLibCartoesFactory.Registrar(AObjetoLibCartoes);

  If Not Assigned(untTPagarMeFuncoes.VS_FuncoesExternas) Then
    untTPagarMeFuncoes.VS_FuncoesExternas := TLibCartoesFactory.Get;

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

  TPagarMeFuncoes.FExisteCampoLiberacaoTransferencia := TPagarMeFuncoes.CampoExiste('MOVCAR', 'MCA_TRFLIB');
  TLibCartoesFuncoes.FExisteCampoLiberacaoTransferencia := TPagarMeFuncoes.FExisteCampoLiberacaoTransferencia;
End;

procedure VerificaEstruturaTabelas; StdCall;
Begin
  TPagarMeFuncoes.VerificaEstrutraTabelas(True);
  TPagarMeFuncoes.VerificaEstrutraTabelas(False);
End;

procedure pAtualizaObjetoTelasAbertas(ATelaAbertas: ITelasAbertas); StdCall;
Begin
  If Not Assigned(untLibCartoesTelasAbertas.objTelasAbertas) Then
    untLibCartoesTelasAbertas.objTelasAbertas := ATelaAbertas;
End;

procedure ImportarCartoesAPI(AAplicacao: HWND; ANomeEmpresa: String); StdCall;
Begin
  TPagarMeFuncoes.ImportarCartoesApi(AAplicacao,
                                     ANomeEmpresa);
End;

procedure SetStyleAutcom(AModoClassico: Boolean); StdCall;
Begin
  untTPagarMeFuncoes.VS_AutcomModoClassico := AModoClassico;
  TPagarMeFuncoes.CarregaEstiloAutcom;
End;

procedure ConciliacaoCartoesApi; StdCall;
  Var
    LBaixarRecebiveisPagarMe: TfrmPagarMeBaixaRecebiveisMkt;

    LTextoTrava: String;
Begin
  LTextoTrava := 'BAIXA_RECEBIVEIS_CARTOES_PAGAR_ME_API';

  If Not VS_FuncoesExternas.fILock_Unlock(LTextoTrava, True, False) Then
  Begin
    TPagarMeFuncoes.fMensagem('ATENÇÃO', 'A rotina de conciliação de cartões do PAGAR.ME está sendo utilizada por outra estação: ' +
                                         VS_FuncoesExternas.fIGetHostLock(LTextoTrava), ['&OK'], 1);
    Exit;
  End;

  TPagarMeFuncoes.pCriarFormularios(TfrmPagarMeBaixaRecebiveisMkt, LBaixarRecebiveisPagarMe);
  Try
    LBaixarRecebiveisPagarMe.ShowModal;
  Finally
    VS_FuncoesExternas.fILock_Unlock(LTextoTrava, False);

    FreeAndNil(LBaixarRecebiveisPagarMe);
  End;
End;

function GetDadosFiltroImportacaoAPI: TDadosImportacaoConfirmacao; StdCall;
  Var
    LObjeto: TDadosImportacaoConfirmacao;
Begin
  LObjeto := Nil;
  Try
    LObjeto := TDadosImportacaoConfirmacao.Create;
    If Assigned(TPagarMeFuncoes.FDadosImportacaoConfirmacao) Then
    Begin
      LObjeto.ImportouVendas := TPagarMeFuncoes.FDadosImportacaoConfirmacao.ImportouVendas;
      LObjeto.ImportouPagamentos := TPagarMeFuncoes.FDadosImportacaoConfirmacao.ImportouPagamentos;
      LObjeto.DataInicial := TPagarMeFuncoes.FDadosImportacaoConfirmacao.DataInicial;
      LObjeto.DataFinal := TPagarMeFuncoes.FDadosImportacaoConfirmacao.DataFinal;
    End;

    Result := TPagarMeFuncoes.ClonarObjeto(LObjeto);
  Finally
    TPagarMeFuncoes.FreeAndNilObjeto(LObjeto);
  End;
End;

Initialization
  FdxInitialize := False;

Finalization
  If FdxInitialize Then
    dxFinalize;

  If Assigned(TLibCartoesFuncoes.FIconeAplicacao) Then
    FreeAndNil(TLibCartoesFuncoes.FIconeAplicacao);

  If Assigned(TPagarMeFuncoes.FDadosImportacaoConfirmacao) Then
    TPagarMeFuncoes.FDadosImportacaoConfirmacao := Nil;

end.
