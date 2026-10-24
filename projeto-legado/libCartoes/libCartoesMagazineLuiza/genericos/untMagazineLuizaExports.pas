unit untMagazineLuizaExports;

interface

Uses Winapi.Windows, System.SysUtils, Vcl.Forms, System.Classes, Vcl.Graphics,

     dxCore,

     untTLibCartoesFuncoes, untTMagazineLuizaFuncoes, untILibCartoesWrapper,
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
Uses untMagazineLuizaBaixaRecebiveisMkt;

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

  If Not Assigned(untTMagazineLuizaFuncoes.VS_FuncoesExternas) Then
    untTMagazineLuizaFuncoes.VS_FuncoesExternas := TLibCartoesFactory.Get;

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

  TMagazineLuizaFuncoes.FExisteCampoLiberacaoTransferencia := TMagazineLuizaFuncoes.CampoExiste('MOVCAR', 'MCA_TRFLIB');
  TLibCartoesFuncoes.FExisteCampoLiberacaoTransferencia := TMagazineLuizaFuncoes.FExisteCampoLiberacaoTransferencia;
End;

procedure VerificaEstruturaTabelas; StdCall;
Begin
  TMagazineLuizaFuncoes.VerificaEstrutraTabelas(True);
  TMagazineLuizaFuncoes.VerificaEstrutraTabelas(False);
End;

procedure pAtualizaObjetoTelasAbertas(ATelaAbertas: ITelasAbertas); StdCall;
Begin
  If Not Assigned(untLibCartoesTelasAbertas.objTelasAbertas) Then
    untLibCartoesTelasAbertas.objTelasAbertas := ATelaAbertas;
End;

procedure ImportarCartoesArquivo(AAplicacao: HWND; APastaAutcom: String; ANomeEmpresa: String); StdCall;
Begin
  TMagazineLuizaFuncoes.ImportarCartoesArquivo(AAplicacao,
                                               APastaAutcom,
                                               ANomeEmpresa);
End;

procedure SetStyleAutcom(AModoClassico: Boolean); StdCall;
Begin
  untTMagazineLuizaFuncoes.VS_AutcomModoClassico := AModoClassico;
  TMagazineLuizaFuncoes.CarregaEstiloAutcom;
End;

procedure BaixarRecebiveisMktArquivo; StdCall;
  Var
    LBaixarRecebiveisMagazineLuiza: TfrmMagazineLuizaBaixaRecebiveisMkt;

    LTextoTrava: String;
Begin
  LTextoTrava := 'BAIXA_RECEBIVEIS_MKT_MAGAZINE_LUIZA_ARQUIVOS';

  If Not VS_FuncoesExternas.fILock_Unlock(LTextoTrava, True, False) Then
  Begin
    TMagazineLuizaFuncoes.fMensagem('ATENÇÃO', 'A rotina de baixa de recebíveis do MAGAZINE LUIZA está sendo utilizada por outra estação: ' +
                                                VS_FuncoesExternas.fIGetHostLock(LTextoTrava), ['&OK'], 1);
    Exit;
  End;

  TMagazineLuizaFuncoes.pCriarFormularios(TfrmMagazineLuizaBaixaRecebiveisMkt, LBaixarRecebiveisMagazineLuiza);
  Try
    LBaixarRecebiveisMagazineLuiza.ShowModal;
  Finally
    VS_FuncoesExternas.fILock_Unlock(LTextoTrava, False);

    FreeAndNil(LBaixarRecebiveisMagazineLuiza);
  End;
End;

Initialization
  FdxInitialize := False;

Finalization
  If FdxInitialize Then
    dxFinalize;

end.
