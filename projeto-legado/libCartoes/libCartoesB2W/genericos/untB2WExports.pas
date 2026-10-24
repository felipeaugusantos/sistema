unit untB2WExports;

interface

Uses Winapi.Windows, System.SysUtils, Vcl.Forms, System.Classes, Vcl.Graphics,

     dxCore,

     untTLibCartoesFuncoes, untTB2WFuncoes, untILibCartoesWrapper,
     untILibCartoesFactory, untLibCartoesTelasAbertas,
     untLibCartoesInterfacesTipos;

procedure dxInitialize; StdCall;

procedure dxFinalize; StdCall;

procedure InicializaObjetoLibCartoes(AObjetoLibCartoes: ILibCartoes); StdCall;

procedure VerificaEstruturaTabelas; StdCall;

procedure pAtualizaObjetoTelasAbertas(ATelaAbertas: ITelasAbertas); StdCall;

procedure ImportarCartoesArquivo(AAplicacao: HWND; APastaAutcom: String; ANomeEmpresa: String); StdCall;

procedure SetStyleAutcom(AModoClassico: Boolean); StdCall;

procedure BaixarRecebiveisMktArquivo; StdCall;

Var
  FdxInitialize: Boolean;

implementation

Uses untB2WBaixaRecebiveisMkt;

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

  If Not Assigned(untTB2WFuncoes.VS_FuncoesExternas) Then
    untTB2WFuncoes.VS_FuncoesExternas := TLibCartoesFactory.Get;

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

  TB2WFuncoes.FExisteCampoLiberacaoTransferencia := TB2WFuncoes.CampoExiste('MOVCAR', 'MCA_TRFLIB');
  TLibCartoesFuncoes.FExisteCampoLiberacaoTransferencia := TB2WFuncoes.FExisteCampoLiberacaoTransferencia;
End;

procedure VerificaEstruturaTabelas; StdCall;
Begin
  TB2WFuncoes.VerificaEstrutraTabelas(True);
  TB2WFuncoes.VerificaEstrutraTabelas(False);
End;

procedure pAtualizaObjetoTelasAbertas(ATelaAbertas: ITelasAbertas); StdCall;
Begin
  If Not Assigned(untLibCartoesTelasAbertas.objTelasAbertas) Then
    untLibCartoesTelasAbertas.objTelasAbertas := ATelaAbertas;
End;

procedure ImportarCartoesArquivo(AAplicacao: HWND; APastaAutcom: String; ANomeEmpresa: String); StdCall;
Begin
  TB2WFuncoes.ImportarCartoesArquivo(AAplicacao,
                                               APastaAutcom,
                                               ANomeEmpresa);
End;

procedure SetStyleAutcom(AModoClassico: Boolean); StdCall;
Begin
  untTB2WFuncoes.VS_AutcomModoClassico := AModoClassico;
  TB2WFuncoes.CarregaEstiloAutcom;
End;

procedure BaixarRecebiveisMktArquivo; StdCall;
  Var
    LBaixarRecebiveisB2W: TfrmB2WBaixaRecebiveisMkt;

    LTextoTrava: String;
Begin
  LTextoTrava := 'BAIXA_RECEBIVEIS_MKT_B2W_ARQUIVOS';

  If Not VS_FuncoesExternas.fILock_Unlock(LTextoTrava, True, False) Then
  Begin
    TB2WFuncoes.fMensagem('ATENÇÃO', 'A rotina de baixa de recebíveis da B2W está sendo utilizada por outra estação: ' +
                                                VS_FuncoesExternas.fIGetHostLock(LTextoTrava), ['&OK'], 1);
    Exit;
  End;

  TB2WFuncoes.pCriarFormularios(TfrmB2WBaixaRecebiveisMkt, LBaixarRecebiveisB2W);
  Try
    LBaixarRecebiveisB2W.ShowModal;
  Finally
    VS_FuncoesExternas.fILock_Unlock(LTextoTrava, False);

    FreeAndNil(LBaixarRecebiveisB2W);
  End;
End;

Initialization
  FdxInitialize := False;

Finalization
  If FdxInitialize Then
    dxFinalize;

end.
