unit untMercadoLivreExports;

interface

Uses Winapi.Windows, System.SysUtils,  System.Classes, Vcl.Graphics,

     dxCore,

     untTMercadoLivreFuncoes, untILibCartoesWrapper, untILibCartoesFactory,
     untLibCartoesTelasAbertas, untLibCartoesInterfacesTipos, untTLibCartoesFuncoes;

procedure dxInitialize; StdCall;

procedure dxFinalize; StdCall;

procedure InicializaObjetoLibCartoes(AObjetoLibCartoes: ILibCartoes); StdCall;

procedure VerificaEstruturaTabelas; StdCall;

procedure pAtualizaObjetoTelasAbertas(ATelaAbertas: ITelasAbertas); StdCall;

procedure ImportarCartoesArquivo(AAplicacao: HWND; APastaAutcom: String; ANomeEmpresa: String); StdCall;

procedure SetStyleAutcom(AModoClassico: Boolean); StdCall;

procedure ConciliacaoCartoesArquivo; StdCall;

procedure BaixarRecebiveisMktArquivo; StdCall;

Var
  FdxInitialize: Boolean;

implementation

Uses untMercadoLivreBaixaRecebiveisMkt;

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

  If Not Assigned(untTMercadoLivreFuncoes.VS_FuncoesExternas) Then
    untTMercadoLivreFuncoes.VS_FuncoesExternas := TLibCartoesFactory.Get;

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

  TMercadoLivreFuncoes.FExisteCampoLiberacaoTransferencia := TMercadoLivreFuncoes.CampoExiste('MOVCAR', 'MCA_TRFLIB');
  TLibCartoesFuncoes.FExisteCampoLiberacaoTransferencia := TMercadoLivreFuncoes.FExisteCampoLiberacaoTransferencia;
End;

procedure VerificaEstruturaTabelas; StdCall;
Begin
  TMercadoLivreFuncoes.VerificaEstrutraTabelas(True);
  TMercadoLivreFuncoes.VerificaEstrutraTabelas(False);
End;

procedure pAtualizaObjetoTelasAbertas(ATelaAbertas: ITelasAbertas); StdCall;
Begin
  If Not Assigned(untLibCartoesTelasAbertas.objTelasAbertas) Then
    untLibCartoesTelasAbertas.objTelasAbertas := ATelaAbertas;
End;

procedure ImportarCartoesArquivo(AAplicacao: HWND; APastaAutcom: String; ANomeEmpresa: String); StdCall;
Begin
  TMercadoLivreFuncoes.ImportarCartoesArquivo(AAplicacao,
                                              APastaAutcom,
                                              ANomeEmpresa);
End;

procedure SetStyleAutcom(AModoClassico: Boolean); StdCall;
Begin
  untTMercadoLivreFuncoes.VS_AutcomModoClassico := AModoClassico;
  TMercadoLivreFuncoes.CarregaEstiloAutcom;
End;

procedure ConciliacaoCartoesArquivo; StdCall;
begin
  TMercadoLivreFuncoes.fMensagem('ATENÇÃO',
                                 'A rotina de baixa/conciliação da operadora MERCADO LIVRE deve ser atualizada para Conciliação de Recebíveis.' + #13 +
                                     'Entre em contato com a Citel.', ['&OK'], 1);
End;

procedure BaixarRecebiveisMktArquivo; StdCall;
  Var
    LBaixarRecebiveisMercadoLivre: TfrmMercadoLivreBaixaRecebiveisMkt;

    LTextoTrava: String;
Begin
  LTextoTrava := 'BAIXA_RECEBIVEIS_MKT_MERCADOLIVRE_ARQUIVOS';

  If Not VS_FuncoesExternas.fILock_Unlock(LTextoTrava, True, False) Then
  Begin
    TMercadoLivreFuncoes.fMensagem('ATENÇÃO', 'A rotina de baixa de recebíveis do MERCADO LIVRE está sendo utilizada por outra estação: ' +
                                   VS_FuncoesExternas.fIGetHostLock(LTextoTrava), ['&OK'], 1);
    Exit;
  End;

  TMercadoLivreFuncoes.pCriarFormularios(TfrmMercadoLivreBaixaRecebiveisMkt, LBaixarRecebiveisMercadoLivre);
  Try
    LBaixarRecebiveisMercadoLivre.ShowModal;
  Finally
    VS_FuncoesExternas.fILock_Unlock(LTextoTrava, False);

    FreeAndNil(LBaixarRecebiveisMercadoLivre);
  End;
End;

Initialization
  FdxInitialize := False;

Finalization
  If FdxInitialize Then
    dxFinalize;

end.
