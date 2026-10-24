unit untShopeeExports;

interface

Uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics,

     dxCore,

     untTLibCartoesFuncoes, untTShopeeFuncoes, untILibCartoesWrapper,
     untILibCartoesFactory, untLibCartoesTelasAbertas,
     untLibCartoesInterfacesTipos;

procedure dxInitialize; StdCall;

procedure InicializaObjetoLibCartoes(AObjetoLibCartoes: ILibCartoes); StdCall;

procedure VerificaEstruturaTabelas; StdCall;

procedure pAtualizaObjetoTelasAbertas(ATelaAbertas: ITelasAbertas); StdCall;

procedure ImportarCartoesArquivo(AAplicacao: HWND; APastaAutcom: String; ANomeEmpresa: String); StdCall;

procedure SetStyleAutcom(AModoClassico: Boolean); StdCall;

procedure BaixarRecebiveisMktArquivo; StdCall;

procedure ExcluirArquivosImportados; StdCall;

Var
  FdxInitialize: Boolean;

implementation

Uses untShopeeBaixaRecebiveisMkt, untShopeeExcluirArquivosImportadosCartoes;

procedure dxInitialize; StdCall;
Begin
  If FdxInitialize Then
    Exit;

  dxCore.dxInitialize;
  FdxInitialize := True;
End;

procedure InicializaObjetoLibCartoes(AObjetoLibCartoes: ILibCartoes); StdCall;
  Var
    LStream: TMemoryStream;
Begin
  TLibCartoesFactory.Registrar(AObjetoLibCartoes);

  If Not Assigned(untTShopeeFuncoes.VS_FuncoesExternas) Then
    untTShopeeFuncoes.VS_FuncoesExternas := TLibCartoesFactory.Get;

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

  TShopeeFuncoes.FExisteCampoLiberacaoTransferencia := TShopeeFuncoes.CampoExiste('MOVCAR', 'MCA_TRFLIB');
  TLibCartoesFuncoes.FExisteCampoLiberacaoTransferencia := TShopeeFuncoes.FExisteCampoLiberacaoTransferencia;
End;

procedure VerificaEstruturaTabelas; StdCall;
Begin
  TShopeeFuncoes.VerificaEstrutraTabelas(True);
  TShopeeFuncoes.VerificaEstrutraTabelas(False);
End;

procedure pAtualizaObjetoTelasAbertas(ATelaAbertas: ITelasAbertas); StdCall;
Begin
  If Not Assigned(untLibCartoesTelasAbertas.objTelasAbertas) Then
    untLibCartoesTelasAbertas.objTelasAbertas := ATelaAbertas;
End;

procedure ImportarCartoesArquivo(AAplicacao: HWND; APastaAutcom: String; ANomeEmpresa: String); StdCall;
Begin
  TShopeeFuncoes.ImportarCartoesArquivo(AAplicacao,
                                        APastaAutcom,
                                        ANomeEmpresa);
End;

procedure SetStyleAutcom(AModoClassico: Boolean); StdCall;
Begin
  untTShopeeFuncoes.VS_AutcomModoClassico := AModoClassico;
  TShopeeFuncoes.CarregaEstiloAutcom;
End;

procedure BaixarRecebiveisMktArquivo; StdCall;
  Var
    LBaixarRecebiveisShopee: TfrmShopeeBaixaRecebiveisMkt;

    LTextoTrava: String;
Begin
  LTextoTrava := 'BAIXA_RECEBIVEIS_MKT_SHOPEE_ARQUIVOS';

  If Not VS_FuncoesExternas.fILock_Unlock(LTextoTrava, True, False) Then
  Begin
    TShopeeFuncoes.fMensagem('ATENÇÃO', 'A rotina de baixa de recebíveis do SHOPEE está sendo utilizada por outra estação: ' +
                                         VS_FuncoesExternas.fIGetHostLock(LTextoTrava), ['&OK'], 1);
    Exit;
  End;

  TShopeeFuncoes.pCriarFormularios(TfrmShopeeBaixaRecebiveisMkt, LBaixarRecebiveisShopee);
  Try
    LBaixarRecebiveisShopee.ShowModal;
  Finally
    VS_FuncoesExternas.fILock_Unlock(LTextoTrava, False);

    FreeAndNil(LBaixarRecebiveisShopee);
  End;
End;

procedure ExcluirArquivosImportados; StdCall;
var
  LFrmShopeeExcluirArquivosImportadosCartoes: TfrmShopeeExcluirArquivosImportadosCartoes;
begin
  TShopeeFuncoes.pCriarFormularios(TfrmShopeeExcluirArquivosImportadosCartoes, LFrmShopeeExcluirArquivosImportadosCartoes);
  try
    try
      LFrmShopeeExcluirArquivosImportadosCartoes.pConfigurarOperadora;
      LFrmShopeeExcluirArquivosImportadosCartoes.ShowModal;
    except
      on E: Exception do
        VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmShopeeExcluirArquivosImportadosCartoes.pAbrirForm]');
    end;
  finally
    FreeAndNil(LFrmShopeeExcluirArquivosImportadosCartoes);
    VS_FuncoesExternas.pITrimAppMemorySize;
  end;
End;

Initialization
  FdxInitialize := False;

Finalization
  If FdxInitialize Then
    dxCore.dxFinalize;

end.
