unit untAmazonExports;

interface

Uses Winapi.Windows, System.SysUtils,  System.Classes, Vcl.Graphics,

     dxCore,

     untTLibCartoesFuncoes, untTAmazonFuncoes, untILibCartoesWrapper,
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

Uses untAmazonBaixaRecebiveisMkt;

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

  If Not Assigned(untTAmazonFuncoes.VS_FuncoesExternas) Then
    untTAmazonFuncoes.VS_FuncoesExternas := TLibCartoesFactory.Get;

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

  TAmazonFuncoes.FExisteCampoLiberacaoTransferencia := TAmazonFuncoes.CampoExiste('MOVCAR', 'MCA_TRFLIB');
  TLibCartoesFuncoes.FExisteCampoLiberacaoTransferencia := TAmazonFuncoes.FExisteCampoLiberacaoTransferencia;
End;

procedure VerificaEstruturaTabelas; StdCall;
Begin
  TAmazonFuncoes.VerificaEstrutraTabelas(True);
  TAmazonFuncoes.VerificaEstrutraTabelas(False);
End;

procedure pAtualizaObjetoTelasAbertas(ATelaAbertas: ITelasAbertas); StdCall;
Begin
  If Not Assigned(untLibCartoesTelasAbertas.objTelasAbertas) Then
    untLibCartoesTelasAbertas.objTelasAbertas := ATelaAbertas;
End;

procedure ImportarCartoesArquivo(AAplicacao: HWND; APastaAutcom: String; ANomeEmpresa: String); StdCall;
Begin
  TAmazonFuncoes.ImportarCartoesArquivo(AAplicacao,
                                        APastaAutcom,
                                        ANomeEmpresa);
End;

procedure SetStyleAutcom(AModoClassico: Boolean); StdCall;
Begin
  untTAmazonFuncoes.VS_AutcomModoClassico := AModoClassico;
  TAmazonFuncoes.CarregaEstiloAutcom;
End;

procedure BaixarRecebiveisMktArquivo; StdCall;
  Var
    LBaixarRecebiveisAmazon: TfrmAmazonBaixaRecebiveisMkt;
    LTextoTrava: String;
Begin
  LTextoTrava := 'BAIXA_RECEBIVEIS_MKT_AMAZON_ARQUIVOS';

  If Not VS_FuncoesExternas.fILock_Unlock(LTextoTrava, True, False) Then
  Begin
    TAmazonFuncoes.fMensagem('ATENÇÃO', 'A rotina de baixa de recebíveis da AMAZON está sendo utilizada por outra estação: ' +
                                         VS_FuncoesExternas.fIGetHostLock(LTextoTrava), ['&OK'], 1);
    Exit;
  End;

  TAmazonFuncoes.pCriarFormularios(TfrmAmazonBaixaRecebiveisMkt, LBaixarRecebiveisAmazon);

  Try
    LBaixarRecebiveisAmazon.ShowModal;
  Finally
    VS_FuncoesExternas.fILock_Unlock(LTextoTrava, False);
    FreeAndNil(LBaixarRecebiveisAmazon);
  End;
End;

Initialization
  FdxInitialize := False;

Finalization
  If FdxInitialize Then
    dxFinalize;


end.
