unit untRedeCardExports;

interface

Uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics,

     dxCore,

     untTRedeCardFuncoes, untILibCartoesWrapper, untILibCartoesFactory,
     untLibCartoesTelasAbertas, untLibCartoesInterfacesTipos, untTLibCartoesFuncoes,
     untConciliacaoRedeCard, untConciliacaoRedeCardAPI;

procedure dxInitialize; StdCall;

procedure dxFinalize; StdCall;

procedure InicializaObjetoLibCartoes(AObjetoLibCartoes: ILibCartoes); StdCall;

procedure VerificaEstruturaTabelas; StdCall;

procedure pAtualizaObjetoTelasAbertas(ATelaAbertas: ITelasAbertas); StdCall;

procedure ImportarCartoesArquivo(AAplicacao: HWND; APastaAutcom: String; ANomeEmpresa: String); StdCall;

procedure ImportarCartoesAPI(AAplicacao: HWND; ANomeEmpresa: String); StdCall;

procedure SetStyleAutcom(AModoClassico: Boolean); StdCall;

procedure AntecipacaoCartoes(AAplicacao: HWND; ANomeEmpresa: String); StdCall;

procedure ConciliacaoCartoesArquivo; StdCall;

procedure ConciliacaoCartoesApi; StdCall;

function GetDadosFiltroImportacaoAPI: TDadosImportacaoConfirmacao; StdCall;

Var
  FdxInitialize: Boolean;

implementation

Uses untAntecipacaoRedeCard, untRedeCardBaixaCartoes;

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

  If Not Assigned(untTRedeCardFuncoes.VS_FuncoesExternas) Then
    untTRedeCardFuncoes.VS_FuncoesExternas := TLibCartoesFactory.Get;

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

  TRedeCardFuncoes.FExisteCampoLiberacaoTransferencia := TRedeCardFuncoes.CampoExiste('MOVCAR', 'MCA_TRFLIB');
  TLibCartoesFuncoes.FExisteCampoLiberacaoTransferencia := TRedeCardFuncoes.FExisteCampoLiberacaoTransferencia;
End;

procedure VerificaEstruturaTabelas; StdCall;
Begin
  TRedeCardFuncoes.VerificaEstrutraTabelas(True);
  TRedeCardFuncoes.VerificaEstrutraTabelas(False);
End;

procedure pAtualizaObjetoTelasAbertas(ATelaAbertas: ITelasAbertas); StdCall;
Begin
  If Not Assigned(untLibCartoesTelasAbertas.objTelasAbertas) Then
    untLibCartoesTelasAbertas.objTelasAbertas := ATelaAbertas;
End;

procedure ImportarCartoesArquivo(AAplicacao: HWND; APastaAutcom: String; ANomeEmpresa: String); StdCall;
Begin
  TRedeCardFuncoes.ImportarCartoesArquivo(AAplicacao,
                                          APastaAutcom,
                                          ANomeEmpresa);
End;

procedure ImportarCartoesAPI(AAplicacao: HWND; ANomeEmpresa: String); StdCall;
Begin
  TRedeCardFuncoes.ImportarCartoesAPI(AAplicacao,
                                      ANomeEmpresa);
End;

procedure SetStyleAutcom(AModoClassico: Boolean); StdCall;
Begin
  untTRedeCardFuncoes.VS_AutcomModoClassico := AModoClassico;
  TRedeCardFuncoes.CarregaEstiloAutcom;
End;

procedure AntecipacaoCartoes(AAplicacao: HWND; ANomeEmpresa: String); StdCall;
  Var
    LAntecipacaoRedeCard : TfrmAntecipacaoRedeCard;
Begin
  Try
    TRedeCardFuncoes.pCriarFormularios(TfrmAntecipacaoRedeCard,LAntecipacaoRedeCard);
    LAntecipacaoRedeCard.Aplicacao := AAplicacao;
    LAntecipacaoRedeCard.ShowModal;
  Finally
    FreeAndNil(LAntecipacaoRedeCard);
  End;
End;

procedure ConciliacaoCartoesArquivo; StdCall;
  Var
    LConciliacaoCartoes: TConcilRedeCard;

    blnReabre : Boolean;

    frmRedeCardBaixaCartoes: TfrmRedeCardBaixaCartoes;

    LTextoTrava: String;
begin
  blnReabre := True;

  While blnReabre Do
  Begin
    LTextoTrava := 'CONCILIACAO_BAIXA_CARTOES_REDECARD_ARQUIVOS';

    If Not VS_FuncoesExternas.fILock_Unlock(LTextoTrava, True, False) Then
    Begin
      TRedeCardFuncoes.fMensagem('ATENÇÃO', 'A rotina de baixa/conciliação da operadora REDECARD está sendo utilizada por outra estação: ' +
                                 VS_FuncoesExternas.fIGetHostLock(LTextoTrava), ['&OK'], 1);
      Exit;
    End;

    TRedeCardFuncoes.pCriarFormularios(TfrmRedeCardBaixaCartoes, frmRedeCardBaixaCartoes);

    LConciliacaoCartoes := TConcilRedeCard.Create;

    Try
      VS_FuncoesExternas.pIModificaStatusTimerTemMensagemPrincipal(False);
      LConciliacaoCartoes.strNomCon    := 'REDECARD';

      If LConciliacaoCartoes.fConciliaCartoes Then
      Begin
        LConciliacaoCartoes.cdsBaiCar.Filter := 'MCA_MARDES=''M'' ';
        LConciliacaoCartoes.cdsBaiCar.Filtered := True;

        If Assigned(frmRedeCardBaixaCartoes.cdsBaiCar) Then
          FreeAndNil(frmRedeCardBaixaCartoes.cdsBaiCar);

        frmRedeCardBaixaCartoes.cdsBaiCar := TRedeCardFuncoes.CriarClientDataSet(LConciliacaoCartoes.cdsBaiCar);
        frmRedeCardBaixaCartoes.cdsBaiCar.IndexFieldNames := LConciliacaoCartoes.cdsBaiCar.IndexFieldNames;

        frmRedeCardBaixaCartoes.blnConcil    := True;
        frmRedeCardBaixaCartoes.blnGraAju    := LConciliacaoCartoes.FBaixarAjustes;
        frmRedeCardBaixaCartoes.blnInconsist := LConciliacaoCartoes.blnInconsist;
        frmRedeCardBaixaCartoes.objConcil    := LConciliacaoCartoes.objConcil;

        frmRedeCardBaixaCartoes.DataInicialConciliacao := LConciliacaoCartoes.DataInicialConciliacao;
        frmRedeCardBaixaCartoes.DataFinalConciliacao   := LConciliacaoCartoes.DataFinalConciliacao;
        frmRedeCardBaixaCartoes.ExibirCartoesPendente  := LConciliacaoCartoes.ExibirCartoesPendente;

        frmRedeCardBaixaCartoes.FiltrosRelatorio := LConciliacaoCartoes.FiltrosRelatorio;

        frmRedeCardBaixaCartoes.Caption      := 'Conciliação de Cartão de Crédito (REDECARD)';

        frmRedeCardBaixaCartoes.ShowModal;
      End;

      LConciliacaoCartoes.RemoverRelatorioConciliacao('untConciliacaoRedeCard');

      blnReabre := LConciliacaoCartoes.blnReabre;
    Finally
      VS_FuncoesExternas.pIModificaStatusTimerTemMensagemPrincipal(True);

      FreeAndNil(frmRedeCardBaixaCartoes);
      FreeAndNil(LConciliacaoCartoes);

      TRedeCardFuncoes.DestroiDicionariosCache;

      VS_FuncoesExternas.fILock_Unlock(LTextoTrava, False);

      VS_FuncoesExternas.pITrimAppMemorySize;
    End;
  End;
End;

procedure ConciliacaoCartoesApi; StdCall;
  Var
    LConciliacaoCartoes: TConciliacaoRedeCardAPI;

    blnReabre : Boolean;

    frmRedeCardBaixaCartoes: TfrmRedeCardBaixaCartoes;

    LTextoTrava: String;
begin
  blnReabre := True;

  While blnReabre Do
  Begin
    LTextoTrava := 'CONCILIACAO_BAIXA_CARTOES_REDECARD_API';

    If Not VS_FuncoesExternas.fILock_Unlock(LTextoTrava, True, False) Then
    Begin
      TRedeCardFuncoes.fMensagem('ATENÇÃO', 'A rotina de baixa/conciliação da operadora REDECARD API está sendo utilizada por outra estação: ' +
                                 VS_FuncoesExternas.fIGetHostLock(LTextoTrava), ['&OK'], 1);
      Exit;
    End;

    TRedeCardFuncoes.pCriarFormularios(TfrmRedeCardBaixaCartoes, frmRedeCardBaixaCartoes);

    LConciliacaoCartoes := TConciliacaoRedeCardAPI.Create;

    Try
      VS_FuncoesExternas.pIModificaStatusTimerTemMensagemPrincipal(False);
      LConciliacaoCartoes.strNomCon    := 'REDECARD API';

      If LConciliacaoCartoes.fConciliaCartoes Then
      Begin
        LConciliacaoCartoes.cdsBaiCar.Filter := 'MCA_MARDES=''M'' ';
        LConciliacaoCartoes.cdsBaiCar.Filtered := True;

        If Assigned(frmRedeCardBaixaCartoes.cdsBaiCar) Then
          FreeAndNil(frmRedeCardBaixaCartoes.cdsBaiCar);

        frmRedeCardBaixaCartoes.cdsBaiCar := TRedeCardFuncoes.CriarClientDataSet(LConciliacaoCartoes.cdsBaiCar);
        frmRedeCardBaixaCartoes.cdsBaiCar.IndexFieldNames := LConciliacaoCartoes.cdsBaiCar.IndexFieldNames;

        frmRedeCardBaixaCartoes.blnConcil    := True;
        frmRedeCardBaixaCartoes.blnGraAju    := LConciliacaoCartoes.FBaixarAjustes;
        frmRedeCardBaixaCartoes.blnInconsist := LConciliacaoCartoes.blnInconsist;
        frmRedeCardBaixaCartoes.objConcil    := LConciliacaoCartoes.objConcil;

        frmRedeCardBaixaCartoes.DataInicialConciliacao := LConciliacaoCartoes.DataInicialConciliacao;
        frmRedeCardBaixaCartoes.DataFinalConciliacao   := LConciliacaoCartoes.DataFinalConciliacao;
        frmRedeCardBaixaCartoes.ExibirCartoesPendente  := LConciliacaoCartoes.ExibirCartoesPendente;

        frmRedeCardBaixaCartoes.FiltrosRelatorio := LConciliacaoCartoes.FiltrosRelatorio;

        frmRedeCardBaixaCartoes.Caption      := 'Conciliação de Cartão de Crédito (REDECARD API)';

        frmRedeCardBaixaCartoes.ShowModal;
      End;

      LConciliacaoCartoes.RemoverRelatorioConciliacao('untConciliacaoRedeCardAPI');

      blnReabre := LConciliacaoCartoes.blnReabre;
    Finally
      VS_FuncoesExternas.pIModificaStatusTimerTemMensagemPrincipal(True);

      FreeAndNil(frmRedeCardBaixaCartoes);
      FreeAndNil(LConciliacaoCartoes);

      TRedeCardFuncoes.DestroiDicionariosCache;

      VS_FuncoesExternas.fILock_Unlock(LTextoTrava, False);

      VS_FuncoesExternas.pITrimAppMemorySize;
    End;
  End;
End;

function GetDadosFiltroImportacaoAPI: TDadosImportacaoConfirmacao; StdCall;
  Var
    LObjeto: TDadosImportacaoConfirmacao;
Begin
  LObjeto := Nil;
  Try
    LObjeto := TDadosImportacaoConfirmacao.Create;
    If Assigned(TRedeCardFuncoes.FDadosImportacaoConfirmacao) Then
    Begin
      LObjeto.ImportouVendas := TRedeCardFuncoes.FDadosImportacaoConfirmacao.ImportouVendas;
      LObjeto.ImportouPagamentos := TRedeCardFuncoes.FDadosImportacaoConfirmacao.ImportouPagamentos;
      LObjeto.DataInicial := TRedeCardFuncoes.FDadosImportacaoConfirmacao.DataInicial;
      LObjeto.DataFinal := TRedeCardFuncoes.FDadosImportacaoConfirmacao.DataFinal;
    End;

    Result := TRedeCardFuncoes.ClonarObjeto(LObjeto);
  Finally
    TRedeCardFuncoes.FreeAndNilObjeto(LObjeto);
  End;
End;

Initialization
  FdxInitialize := False;
  TRedeCardFuncoes.FDadosImportacaoConfirmacao := Nil;

Finalization
  If FdxInitialize Then
    dxCore.dxFinalize;

  If Assigned(TLibCartoesFuncoes.FIconeAplicacao) Then
    FreeAndNil(TLibCartoesFuncoes.FIconeAplicacao);

  If Assigned(TRedeCardFuncoes.FDadosImportacaoConfirmacao) Then
    TRedeCardFuncoes.FDadosImportacaoConfirmacao := Nil;

end.
