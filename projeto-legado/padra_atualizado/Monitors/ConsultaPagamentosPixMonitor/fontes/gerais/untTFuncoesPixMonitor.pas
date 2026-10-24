{$WARN SYMBOL_PLATFORM OFF}
unit untTFuncoesPixMonitor;

interface

Uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core, untTypesSistema,
{$ELSE}
  UniClientDataset, Vcl.Forms, WinApi.Windows,
{$ENDIF}
  untAdiantamentoCliente,
  untTiposPix, untTPixDao, System.Classes, untIIntegracaoPixCitel,
  untTIntegracaoPixCitel, untFuncoesSimples, System.SysUtils,
  System.StrUtils, untMsgInterna, System.Variants, untFuncoes, Uni,
  untTFuncoesAuxiliaresPix, Data.DB, System.Generics.Collections;

Type
  TFuncoesPixMonitor = class
    {$IFNDEF LINUX}
    class var FHandlePixCitel: THandle;
    class var FPixCitel: IIntegracaoPixCitel;
    {$ENDIF}
  private
    class var FMsgRpx: String;
    class var FOperadoresMensagens: TUniClientDataSet;
    class var FTxIdJaGravadoLogErrPix404: TStringList;

    class function ValidacaoParaRealizarConsulta(ARegistro: TDadosRetornoPixConsulta;
                                                 ADatasetRegistro: TUniClientDataset;
                                                 APixDao: TPixDao;
                                                 const AIgnorarPixTela: Boolean = False): Boolean;
    class function ValidacaoParaRealizarConsultaTemporaria(ARegistro: TDadosRetornoPixConsulta;
                                                           ADatasetRegistro: TUniClientDataset;
                                                           APixDao: TPixDao): Boolean;

    class procedure EnviaMensagemPagamentoOperadores(ARegistro: TDadosRetornoPixConsulta;
                                                     AGravouAdiantamento: Boolean);

    class procedure EnviaMensagemPagamentoOperadoresCTR(ARegistro: TDadosRetornoPixConsulta);

    class procedure EnviaMensagemPagamentoOperadorTemporaria(ARegistro: TDadosRetornoPixConsulta;
                                                             ACodigoOperador: String;
                                                             ADuplicataExcluida: Boolean = False);

    class procedure EnviaMensagemPixExpiradosOperadores(var APedidosExpirados: TStringList);

    class procedure EnviaMensagemPixExpiradosOperadoresCTR(var ADuplicatasExpiradas: TStringList);

    class procedure GravaLogCTRExpirados(var ADuplicatasExpiradasAutoincrem: TStringList);

    class procedure LimparCADRECComPixExcluidoEmVersoesAnterioresDoMonitor;

    class function PixFoiGeradoPorPedido(ADataset: TUniClientDataset): Boolean;

    class procedure VerificaPagamentoNoAmbienteDeTestes(var ARegistro: TDadosRetornoPixConsulta);

    class procedure ApagaPixAtivosExpirados(AListaAutoIncremAtivos: TStringList;
                                            ANomeFormulario: String;
                                            out APedidosExpirados: TStringList;
                                            out ADuplicatasExpiradas: TStringList;
                                            out ADuplicatasExpiradasAutoIncrem: TStringList;
                                            var AListaPixRemovidoAPI: TList<TPixRemovidoAPI>);

    class procedure ApagaPixAtivosExpiradosTemporaria(AListaAutoIncremAtivos: TStringList;
                                                      var AListaPixRemovidoAPI: TList<TPixRemovidoAPI>);

    class function RetornaListaPedidosPix(AEmpresaPix,
                                          ATxIdPix: String): String;

    class function RetornaListaDuplicatasPix(AEmpresaPix,
                                             ATxIdPix: String;
                                             var ADuplicatasAutoIncrem: TStringList): String;

    class procedure RealizaLiberacaoDePedidosComPixPago(AEmpresaDoPix,
                                                        ATxIdPix,
                                                        ACodigoOperador: String);

    class procedure AtualizaStatusCobrancaParaRemovida(ARegistroPix: TUniClientDataSet;
                                                       ARequisicaoPix: IRequisicoesPix;
                                                       var AListaPixRemovidoAPI: TList<TPixRemovidoAPI>);
    class procedure AtualizaStatusCobrancaParaRemovidaTemporaria(ARegistroPix: TUniClientDataSet;
                                                                 ARequisicaoPix: IRequisicoesPix;
                                                                 var AListaPixRemovidoAPI: TList<TPixRemovidoAPI>);

    class function VerificaSeCampoExisteNaMovPix(ANomeCampo: String): Boolean;

    class function RegistroDoPixAtivoEExpirado(AAutoincrem: String): Boolean;
    class function RegistroDoPixAtivoEExpiradoTemporaria(AAutoincrem: String): Boolean;

    class function RetornaBancoDaChavePix(AAutoIncremChavePix: String): String;

    class function DeveGravarLogErrPix(ARetornoErro: String;
                                       AGravouLogErro: Boolean;
                                       AJsonErro: String): Boolean;

    class function RemoveRegistroPorBancoAoRetornarErro404(AMensagemErro,
                                                           ATxIdPix: String;
                                                           APixAtivo: TDataset;
                                                           var AListaPixApagar: TStringList;
                                                           ATemporaria: Boolean): Boolean;

    class procedure AtualizaStatusDelMonitorPixPagoParaDevolvido(ADatasetDel: TDataset);

    class function RetornaTxIdDaPesquisa(ADataset: TDataset): String;
    class function RetornaTxIdDaPesquisaTemporaria(ADataset: TDataset): String;

    class procedure RemoverCobrancasExpiradasEmCasoDeErrosNaAPI(APixAtivo: TDataset;
                                                                ATemporaria: Boolean;
                                                                AGravarOErro: Boolean);
  public
    class procedure ExecutarRotinasConsultaAtivasMonitorPix(ATxId: string = '';
                                                            AIgnorarPixTela: Boolean = False);
    class procedure ExecutarRotinasConsultaTemporariasAtivasMonitorPix(ATxId: string = '');
    class procedure ExecutarRotinasConsultaTemporariasPagasMonitorPix(ATxId: string = '');

    {$IFNDEF LINUX}
    class procedure CarregaLibIntegracaoPixCitel;
    {$ENDIF}

    class procedure GravarLogErr_Pix(ADescricao, ARelatorio: String);

    class procedure ResetaTxIdJaGravadoLogErrPix404;
  end;

Const
  TEMPO_MINIMO_EXPIRACAO_REMOVER_404: Integer = 864000; //10 dias
  TEMPO_MINIMO_REMOCAO_COBRANCA_EXPIRADA: Integer = 1296000; //15 dias

{$IFDEF LINUX}
procedure InicializaIntegracaoPixCitel(AIntegracaoPixCitel: IIntegracaoPixCitel); stdcall; External 'libIntegracaoPixCitel.so';
function CriaObjetoRequisicoesPixEmpresa(AAutoIncremPix, AEmpresaChave: String): IRequisicoesPix; stdcall; External 'libIntegracaoPixCitel.so';
{$ELSE}
Var
  InicializaIntegracaoPixCitel: procedure(AIntegracaoPixCitel: IIntegracaoPixCitel); stdcall;// External 'libIntegracaoPixCitel.dll' delayed;
  CriaObjetoRequisicoesPixEmpresa: function(AAutoIncremPix, AEmpresaChave: String): IRequisicoesPix; stdcall;// External 'libIntegracaoPixCitel.dll' delayed;
{$ENDIF}

implementation

Uses untTContasAReceberPix, untLogCtr, untTLogMpx;

class procedure TFuncoesPixMonitor.ApagaPixAtivosExpirados(AListaAutoIncremAtivos: TStringList;
                                                           ANomeFormulario: String;
                                                           out APedidosExpirados: TStringList;
                                                           out ADuplicatasExpiradas: TStringList;
                                                           out ADuplicatasExpiradasAutoIncrem: TStringList;
                                                           var AListaPixRemovidoAPI: TList<TPixRemovidoAPI>);
  Var
    LConsulta,
    LAtualiza: TUniQuery;

    LPixNaTela: Boolean;

    LGravouLog,
    LValidaDuplicatas: Boolean;

    LPixRemovidoAPI: TPixRemovidoAPI;
begin
  LConsulta := fCriaQuery;
  LAtualiza := fCriaQuery;

  APedidosExpirados := TStringList.Create;
  ADuplicatasExpiradas := TStringList.Create;
  ADuplicatasExpiradasAutoIncrem := TStringList.Create;
  Try
    If AListaAutoIncremAtivos.Count <= 0 THen
      Exit;

    LConsulta.SQL.Text := 'SELECT M.*    ' +
                          'FROM MOVPIX M ' +
                          'WHERE M.MPX_DTAHOR <= DATE_ADD(CURRENT_TIMESTAMP, INTERVAL (M.MPX_EXPIRA + 21600) * - 1 SECOND) ' +
                          '  AND M.MPX_STATUS IN ("ATIVA", "ATIVACC", "pending", "pendingv", "pendingvCC", "ACTIVE", "ACTIVECC") ' +
                          ' AND M.AUTOINCREM IN (' + AListaAutoIncremAtivos.CommaText + ')';

    LConsulta.Open;

    fStartTransaction;
    While Not LConsulta.Eof Do
    Begin
      LValidaDuplicatas := LConsulta.FindField('MPX_CRIADO') <> Nil;
      If LValidaDuplicatas Then
        LValidaDuplicatas := LConsulta.FindField('MPX_CRIADO').AsString = 'FINANCEIRO';

      LAtualiza.Close;

      If Not LValidaDuplicatas Then
      Begin
        APedidosExpirados.Add(RetornaListaPedidosPix(LConsulta.FieldByName('MPX_CODEMP').AsString,
                                                     LConsulta.FieldByName('MPX_TX_ID_').AsString));


        LAtualiza.SQL.Text := 'UPDATE EXTGOR SET FGO_TX_PIX=NULL, FGO_EMPPIX=NULL ' +
                              'WHERE FGO_EMPPIX="' + LConsulta.FieldByName('MPX_CODEMP').AsString + '" ' +
                              '  AND FGO_TX_PIX="' + LConsulta.FieldByName('MPX_TX_ID_').AsString + '" ';
        LAtualiza.ExecSQL;
      End
      Else
      Begin
        ADuplicatasExpiradas.Add(RetornaListaDuplicatasPix(LConsulta.FieldByName('MPX_CODEMP').AsString,
                                                           LConsulta.FieldByName('MPX_TX_ID_').AsString,
                                                           ADuplicatasExpiradasAutoIncrem));

        LAtualiza.SQL.Text := 'UPDATE CADREC SET CTR_TX_PIX=NULL, CTR_EMPPIX=NULL, CTR_PIXTIP=NULL, ' +
                              '                  CTR_PIXREC=NULL, CTR_PIXJUR=NULL, CTR_PIXDES=NULL, ' +
                              '                  CTR_PIXCOB=NULL, CTR_PIXCOR=NULL                   ' +
                              'WHERE CTR_EMPPIX="' + LConsulta.FieldByName('MPX_CODEMP').AsString + '" ' +
                              '  AND CTR_TX_PIX="' + LConsulta.FieldByName('MPX_TX_ID_').AsString + '" ';
         LAtualiza.ExecSQL;
      End;

      LGravouLog := False;

      If Assigned(AListaPixRemovidoAPI) Then
      Begin
        For LPixRemovidoAPI In AListaPixRemovidoAPI Do
        Begin
          If LPixRemovidoAPI.AutoIncrem = LConsulta.FieldByName('AUTOINCREM').AsString Then
          Begin
            LConsulta.Edit;
            LConsulta.FieldByName('MPX_STATUS').AsString := 'REMOVIDA_PELO_USUARIO_RECEBEDOR';
            LConsulta.FieldByName('MPX_JSOREC').AsString := LPixRemovidoAPI.JsonRecebido;
            LConsulta.Post;

            TLogMpx.GravaLogMpx(LConsulta.FieldByName('AUTOINCREM').AsString,
                                'EXCLUSÃO PIX EXPIRADO',
                                ANomeFormulario);

            LGravouLog := True;

            Break;
          End;
        End;
      End;

      If Not LGravouLog Then
        TLogMpx.GravaLogMpx(LConsulta.FieldByName('AUTOINCREM').AsString,
                            'EXCLUSÃO PIX EXPIRADO',
                            ANomeFormulario);

      fVerificaIntegridade(ANomeFormulario, 'MOVPIX', LConsulta, True);

      LPixNaTela := Not fEmptyStr(fCampoTabela('IFNULL(AUTOINCREM, "")', 'PIXTEL', ['AUTOINCREM'], [LConsulta.FieldByName('AUTOINCREM').AsString]));
      TPixDao.ApagarRegistroNaTabelaPixTel(LConsulta.FieldByName('AUTOINCREM').AsString,
                                           LPixNaTela);

      LConsulta.Delete;
    End;
    fCommit;
  Finally
    FreeAndNil(LConsulta);
    FreeAndNil(LAtualiza);
  End;
end;

class procedure TFuncoesPixMonitor.ApagaPixAtivosExpiradosTemporaria(
  AListaAutoIncremAtivos: TStringList;
  var AListaPixRemovidoAPI: TList<TPixRemovidoAPI>);
  Var
    LConsulta,
    LAtualiza: TUniQuery;

    LPixRemovidoAPI: TPixRemovidoAPI;
begin
  LConsulta := fCriaQuery;
  LAtualiza := fCriaQuery;

  Try
    If AListaAutoIncremAtivos.Count <= 0 THen
      Exit;

    LConsulta.SQL.Text := 'SELECT M.*    ' +
                          'FROM MONPIX_LOG M ' +
                          'WHERE M.LOG_DTACAD <= DATE_ADD(CURRENT_TIMESTAMP, INTERVAL (IFNULL(M.LOG_EXPIRA, 86400) + 3600) * - 1 SECOND) ' +
                          '  AND M.LOG_STATUS IN ("ATIVA", "ATIVACC", "pending", "pendingv", "pendingvCC", "cancelled", ' +
                          '                       "REMOVIDA_PELO_USUARIO_RECEBEDOR", "REMOVIDA_PELO_PSP", "ACTIVE", "ACTIVECC") ' +
                          ' AND M.AUTOINCREM IN ("' + AListaAutoIncremAtivos.CommaText.Replace(',', '","') + '")';

    LConsulta.Open;

    fStartTransaction;
    While Not LConsulta.Eof Do
    Begin
      If Assigned(AListaPixRemovidoAPI) Then
      Begin
        For LPixRemovidoAPI In AListaPixRemovidoAPI Do
        Begin
          If LPixRemovidoAPI.AutoIncrem = LConsulta.FieldByName('AUTOINCREM').AsString Then
          Begin
            LConsulta.Edit;
            LConsulta.FieldByName('LOG_STATUS').AsString := 'REMOVIDA_PELO_USUARIO_RECEBEDOR';
            LConsulta.FieldByName('LOG_JSOREC').AsString := LPixRemovidoAPI.JsonRecebido;
            LConsulta.FieldByName('LOG_DTACON').AsDateTime := untFuncoesSimples.fRetornaDataHoraServidor;
            LConsulta.Post;

            Break;
          End;
        End;
      End;

      fVerificaIntegridade('untTFuncoesPixMonitor',
                           'MONPIX_LOG',
                           LConsulta,
                           True,
                           False,
                           'REMOVIDO PIX EXPIRADO (MONITOR)',
                           strLoginUsuarioLogado);

      LConsulta.Delete;
    End;
    fCommit;
  Finally
    FreeAndNil(LConsulta);
    FreeAndNil(LAtualiza);
  End;

end;

class procedure TFuncoesPixMonitor.AtualizaStatusCobrancaParaRemovida(
  ARegistroPix: TUniClientDataSet;
  ARequisicaoPix: IRequisicoesPix; var AListaPixRemovidoAPI: TList<TPixRemovidoAPI>);
  Var
    LErro,
    LRequisicaoJson,
    LRetornoJson: String;

    LPixRemovido: TPixRemovidoAPI;
begin
  Try
    If AListaPixRemovidoAPI = Nil Then
      AListaPixRemovidoAPI := TList<TPixRemovidoAPI>.Create;

    If Not VerificaSeCampoExisteNaMovPix('MPX_PIXDEV') Then
      Exit;

    If Not RegistroDoPixAtivoEExpirado(ARegistroPix.FieldByName('AUTOINCREM').AsString) Then
      Exit;

    LRequisicaoJson := '{"status": "REMOVIDA_PELO_USUARIO_RECEBEDOR", ' +
                       ' "valor": {' +
                       '  "original": "0.00"} ' +
                       '}';

    LRetornoJson := ARequisicaoPix.AlterarCobranca(LRequisicaoJson,
                                                   ARegistroPix.FieldByName('MPX_TX_ID_').AsString);

    LErro := TFuncoesPix.RetornaMensagemErroRequisicao(LRetornoJson);
    If Not LErro.IsEmpty Then
      Raise Exception.Create(LErro);

    LPixRemovido := TPixRemovidoAPI.Create;
    LPixRemovido.AutoIncrem := ARegistroPix.FieldByName('AUTOINCREM').AsString;
    LPixRemovido.JsonRecebido := LRetornoJson;
    AListaPixRemovidoAPI.Add(LPixRemovido);
  Except
    //o erro é gravado dentro da lib
  End;
end;

class procedure TFuncoesPixMonitor.AtualizaStatusCobrancaParaRemovidaTemporaria(
  ARegistroPix: TUniClientDataSet; ARequisicaoPix: IRequisicoesPix;
  var AListaPixRemovidoAPI: TList<TPixRemovidoAPI>);
  Var
    LErro,
    LRequisicaoJson,
    LRetornoJson: String;

    LPixRemovido: TPixRemovidoAPI;
begin
  Try
    If AListaPixRemovidoAPI = Nil Then
      AListaPixRemovidoAPI := TList<TPixRemovidoAPI>.Create;

    If MatchStr(RetornaBancoDaChavePix(ARegistroPix.FieldByName('LOG_SEQPIX').AsString), ['033']) Then
      Exit;

    If Not RegistroDoPixAtivoEExpiradoTemporaria(ARegistroPix.FieldByName('INCLOG').AsString) Then
      Exit;

    LRequisicaoJson := '{"status": "REMOVIDA_PELO_USUARIO_RECEBEDOR", ' +
                       ' "valor": {' +
                       '  "original": "0.00"} ' +
                       '}';

    LRetornoJson := ARequisicaoPix.AlterarCobranca(LRequisicaoJson,
                                                   ARegistroPix.FieldByName('LOG_TX_ID_').AsString);

    LErro := TFuncoesPix.RetornaMensagemErroRequisicao(LRetornoJson);
    If Not LErro.IsEmpty Then
      Raise Exception.Create(LErro);

    LPixRemovido := TPixRemovidoAPI.Create;
    LPixRemovido.AutoIncrem := ARegistroPix.FieldByName('INCLOG').AsString;
    LPixRemovido.JsonRecebido := LRetornoJson;
    AListaPixRemovidoAPI.Add(LPixRemovido);
  Except
    //o erro é gravado dentro da lib
  End;
end;

class procedure TFuncoesPixMonitor.AtualizaStatusDelMonitorPixPagoParaDevolvido(
  ADatasetDel: TDataset);
  Var
    LAtualiza: TUniQuery;
begin
  If ADatasetDel.IsEmpty Then
    Exit;

  LAtualiza := fCriaQuery;

  Try
    Try
      fStartTransaction;

      LAtualiza.SQL.Text := 'UPDATE DEL_MONPIX_LOG SET LOG_STATUS="DEVOLVIDO" WHERE AUTOINCREM="' + ADatasetDel.FieldByname('INCLOG').AsString + '"';
      LAtualiza.ExecSQL;

      fCommit;
    Except
      fRollback;
    End;
  Finally
    FreeAndNil(LAtualiza);
  End;
end;

{$IFNDEF LINUX}
class procedure TFuncoesPixMonitor.CarregaLibIntegracaoPixCitel;
  Var
    LCaminhoDll: String;
begin
  If FHandlePixCitel <> 0 Then
    Exit;

  Try
    LCaminhoDll := ExtractFilePath(Application.ExeName) + 'libIntegracaoPixCitel.dll';

    If Not FileExists(LCaminhoDll) Then
      Raise Exception.Create('O arquivo ' + LCaminhoDll + ' não foi encontrado na pasta do AUTCOM. Operação cancelada!');

    FHandlePixCitel := SafeLoadLibrary(PChar(LCaminhoDll));

    FPixCitel := TIntegracaoPixCitel.Create;
    InicializaIntegracaoPixCitel := GetProcAddress(FHandlePixCitel, pChar('InicializaIntegracaoPixCitel'));
    InicializaIntegracaoPixCitel(FPixCitel);

    CriaObjetoRequisicoesPixEmpresa := GetProcAddress(FHandlePixCitel, pChar('CriaObjetoRequisicoesPixEmpresa'));
  Except
    Raise;
  End;
end;
{$ENDIF}

class function TFuncoesPixMonitor.DeveGravarLogErrPix(
  ARetornoErro: String; AGravouLogErro: Boolean; AJsonErro: String): Boolean;
begin
  Result := Pos('o certificado PFX instalado.', ARetornoErro) = 0;
  If Not Result Then
    Exit;

  Result := Pos('versão do Windows 8.1 ou superior.', ARetornoErro) = 0;
  If Not Result Then
    Exit;

  Result := Pos('ERRO_REQUISICAO-', AJsonErro) <= 0;
  If Not Result Then
    Result := Not AGravouLogErro;
end;

class procedure TFuncoesPixMonitor.EnviaMensagemPagamentoOperadores(
  ARegistro: TDadosRetornoPixConsulta; AGravouAdiantamento: Boolean);
  Var
    LMensagemInterna: TMsgInterna;
begin
  If Not AGravouAdiantamento Then
    Exit;

  Try
    LMensagemInterna := TMsgInterna.Create(Nil);

    Try
      fStartTransaction;
      FOperadoresMensagens.First;
      While Not FOperadoresMensagens.Eof Do
      Begin

        If FMsgRpx = 'A' Then
        Begin
          If Pos(ARegistro.CodigoEmpresa, fRetEmpAcessoUsuario(FOperadoresMensagens.FieldByName('OPE_CODOPE').AsString)) <= 0 Then
          Begin
            FOperadoresMensagens.Next;
            Continue;
          End;
        End;

        LMensagemInterna.fEnviaMensagem('Pagamento do Pix recebido referente ao pedido ' + ARegistro.NumeroDoPedido,
                                        'Pix recebido ' + #13 +
                                          'Pedido: ' + ARegistro.NumeroDoPedido + #13 +
                                          'Cliente: ' + ARegistro.CodigoDoCliente + '-' + fRetNomCliente(ARegistro.CodigoDoCliente) + #13 +
                                          'Data Pagamento: ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', ARegistro.DataPagamento) + #13 +
                                          'Valor Recebido: ' + FormatFloat(',0.00', ARegistro.ValorPago),
                                        strLoginUsuarioLogado,
                                        FOperadoresMensagens.FieldByName('OPE_CODOPE').AsString,
                                        'N',
                                        NullAsStringValue);

        FOperadoresMensagens.Next;
      End;
      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;

        Raise Exception.Create('Ocorreu um erro ao enviar a mensagem de recebimentos Pix aos operadores.' + #13 +
                               'Erro gerado: ' + E.Message);
      End;
    End;
  Finally
    FreeAndNil(LMensagemInterna);
  End;
end;

class procedure TFuncoesPixMonitor.EnviaMensagemPagamentoOperadoresCTR(
  ARegistro: TDadosRetornoPixConsulta);
  Var
    LMensagemInterna: TMsgInterna;
begin
  Try
    LMensagemInterna := TMsgInterna.Create(Nil);

    Try
      fStartTransaction;
      FOperadoresMensagens.First;
      While Not FOperadoresMensagens.Eof Do
      Begin
        If FMsgRpx = 'A' Then
        Begin
          If Pos(ARegistro.CodigoEmpresa, fRetEmpAcessoUsuario(FOperadoresMensagens.FieldByName('OPE_CODOPE').AsString)) <= 0 Then
          Begin
            FOperadoresMensagens.Next;
            Continue;
          End;
        End;

        If ARegistro.ChaveParaCreditoCliente.IsEmpty Then
          LMensagemInterna.fEnviaMensagem('Recebimento do Pix referente a duplicatas',
                                          'Duplicata(s): ' +
                                            ARegistro.NumeroDasDuplicatas + #13 +
                                            'Cliente: ' + ARegistro.CodigoDoCliente + '-' + fRetNomCliente(ARegistro.CodigoDoCliente) + #13 +
                                            'Data Pagamento: ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', ARegistro.DataPagamento) + #13 +
                                            'Valor Recebido: ' + FormatFloat(',0.00', ARegistro.ValorPago),
                                          strLoginUsuarioLogado,
                                          FOperadoresMensagens.FieldByName('OPE_CODOPE').AsString,
                                          'N',
                                          NullAsStringValue)
        Else
          LMensagemInterna.fEnviaMensagem('Recebimento do Pix para geração de crédito ao cliente',
                                          'Duplicata: ' +
                                          LeftStr(ARegistro.ChaveParaCreditoCliente, 12) + 'A' + Copy(ARegistro.ChaveParaCreditoCliente, 13, 7) + #13 +
                                            'Cliente: ' + Copy(ARegistro.ChaveParaCreditoCliente, 21, 8) + '-' + fRetNomCliente(Copy(ARegistro.ChaveParaCreditoCliente, 21, 8)) + #13 +
                                            'Data Pagamento: ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', ARegistro.DataPagamento) + #13 +
                                            'Valor Recebido: ' + FormatFloat(',0.00', ARegistro.ValorPago),
                                          strLoginUsuarioLogado,
                                          FOperadoresMensagens.FieldByName('OPE_CODOPE').AsString,
                                          'N',
                                          NullAsStringValue);

        FOperadoresMensagens.Next;
      End;
      fCommit;

      If ARegistro.TxBolCadRec.Trim.IsEmpty Then
        Exit;

      fStartTransaction;

      LMensagemInterna.fEnviaMensagem('ATENÇÃO: Recebimento do Pix QR Code referente a duplicatas com boleto híbrido',
                                      'Duplicata(s): ' +
                                        ARegistro.NumeroDasDuplicatas + #13 +
                                        'Cliente: ' + ARegistro.CodigoDoCliente + '-' + fRetNomCliente(ARegistro.CodigoDoCliente) + #13 +
                                        'Data Pagamento: ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', ARegistro.DataPagamento) + #13 +
                                        'Valor Recebido: ' + FormatFloat(',0.00', ARegistro.ValorPago) + #13 + #13 +
                                        'Alguma ou todas as duplicatas vinculadas a esse Pix QR Qrcode recebido possui ' +
                                        'dados de boleto híbrido (Código de Barras + Pix) vinculado. ' + #13 +
                                        'O pagamento desse Pix QR Code não tem víncuilo ao boleto junto ao banco. Portanto, não realiza a baixa automática do boleto.' + #13 +
                                        'É necessário tomar as medidas necessárias para a baixa do(s) título(s) junto ao banco, caso ainda não esteja(m) baixado(s).',
                                      strLoginUsuarioLogado,
                                      ARegistro.CodigoOperadorMovPix,
                                      'N',
                                      NullAsStringValue);
      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;

        Raise Exception.Create('Ocorreu um erro ao enviar a mensagem de recebimentos Pix aos operadores.' + #13 +
                               'Erro gerado: ' + E.Message);
      End;
    End;
  Finally
    FreeAndNil(LMensagemInterna);
  End;
end;

class procedure TFuncoesPixMonitor.EnviaMensagemPagamentoOperadorTemporaria(
  ARegistro: TDadosRetornoPixConsulta; ACodigoOperador: String; ADuplicataExcluida: Boolean = False);
  Var
    LMensagemInterna: TMsgInterna;
begin
  If FMsgRpx = 'A' Then
  Begin
    If Pos(ARegistro.CodigoEmpresa, fRetEmpAcessoUsuario(ACodigoOperador)) <= 0 Then
      Exit;
  End;

  Try
    LMensagemInterna := TMsgInterna.Create(Nil);

    Try
      fStartTransaction;

      If Not ADuplicataExcluida Then
        LMensagemInterna.fEnviaMensagem('Recebimento do Pix gerado e não realizada a gravação',
                                        'Foi realizado um recebimento de uma cobrança Pix gerada na tela, mas não foi feito o cancelamento no banco ' +
                                        'nem a gravação do registro.' + #13 + #13 +
                                        'Dados do Pix: ' + #13 +
                                        'Data Pagamento: ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', ARegistro.DataPagamento) + #13 +
                                        'Valor Recebido: ' + FormatFloat(',0.00', ARegistro.ValorPago) + #13 +
                                        'Dados Pagador: ' + ARegistro.NomePagador + ' - ' + ARegistro.CPFCNPJPagador + #13 +
                                        'Mensagem Cobrança: ' + ARegistro.SolicitacaoPagador + #13 +
                                        '----------------------------------------------------------------------------------' + #13 +
                                        'Vá em Relação de Documentos com Pix Gerados e selecione a opção [CTRL+F12 - Gerar CC Pix Recebido]',
                                        strLoginUsuarioLogado,
                                        ACodigoOperador,
                                        'N',
                                        NullAsStringValue)
      Else
        LMensagemInterna.fEnviaMensagem('Recebimento do Pix gerado de documentos excluídos',
                                        'Foi realizado um recebimento de uma cobrança Pix gerada pela Baixa de Contas a Receber, mas esse documento ' +
                                        'não está mais gravado no Autcom.' + #13 + #13 +
                                        'Dados do Pix: ' + #13 +
                                        'Data Pagamento: ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', ARegistro.DataPagamento) + #13 +
                                        'Valor Recebido: ' + FormatFloat(',0.00', ARegistro.ValorPago) + #13 +
                                        'Dados Pagador: ' + ARegistro.NomePagador + ' - ' + ARegistro.CPFCNPJPagador + #13 +
                                        'Mensagem Cobrança: ' + ARegistro.SolicitacaoPagador + #13 +
                                        '----------------------------------------------------------------------------------' + #13 +
                                        'Vá em Relação de Documentos com Pix Gerados e selecione a opção [CTRL+F12 - Gerar CC Pix Recebido]',
                                        strLoginUsuarioLogado,
                                        ACodigoOperador,
                                        'N',
                                        NullAsStringValue);

      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;

        Raise Exception.Create('Ocorreu um erro ao enviar a mensagem de recebimentos Pix aos operadores.' + #13 +
                               'Erro gerado: ' + E.Message);
      End;
    End;
  Finally
    FreeAndNil(LMensagemInterna);
  End;
end;

class procedure TFuncoesPixMonitor.EnviaMensagemPixExpiradosOperadores(
  var APedidosExpirados: TStringList);
  Var
    LMensagemInterna: TMsgInterna;

    LPedidos: String;
begin
  Try
    LMensagemInterna := TMsgInterna.Create(Nil);

    If APedidosExpirados.Count <= 0 Then
      Exit;

    Try
      fStartTransaction;
      FOperadoresMensagens.First;
      While Not FOperadoresMensagens.Eof Do
      Begin
        For LPedidos in APedidosExpirados Do
        Begin
          LMensagemInterna.fEnviaMensagem('Pix expirado e removido referente ao(s) pedido(s) ' + LPedidos,
                                          'Pix expirado e removido referente ao(s) pedido(s) ' + LPedidos,
                                          strLoginUsuarioLogado,
                                          FOperadoresMensagens.FieldByName('OPE_CODOPE').AsString,
                                          'N',
                                          NullAsStringValue);
        End;

        FOperadoresMensagens.Next;
      End;
      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;

        Raise Exception.Create('Ocorreu um erro ao enviar a mensagem de Pix expirados aos operadores.' + #13 +
                               'Erro gerado: ' + E.Message);
      End;
    End;
  Finally
    FreeAndNil(LMensagemInterna);
    FreeAndNil(APedidosExpirados);
  End;
end;

class procedure TFuncoesPixMonitor.EnviaMensagemPixExpiradosOperadoresCTR(var ADuplicatasExpiradas: TStringList);
  Var
    LMensagemInterna: TMsgInterna;

    LDuplicatas: String;
begin
  Try
    LMensagemInterna := TMsgInterna.Create(Nil);

    If ADuplicatasExpiradas.Count <= 0 Then
      Exit;

    Try
      fStartTransaction;
      FOperadoresMensagens.First;
      While Not FOperadoresMensagens.Eof Do
      Begin
        For LDuplicatas in ADuplicatasExpiradas Do
        Begin
          If Not LDuplicatas.IsEmpty Then
            LMensagemInterna.fEnviaMensagem('Pix expirado e removido referente a baixa de duplicatas',
                                            'Pix expirado e removido referente a(s) duplicatas(s) ' + LDuplicatas,
                                            strLoginUsuarioLogado,
                                            FOperadoresMensagens.FieldByName('OPE_CODOPE').AsString,
                                            'N',
                                            NullAsStringValue)
          Else
            LMensagemInterna.fEnviaMensagem('Pix expirado e removido',
                                            'Pix expirado e removido sem documento vinculado.',
                                            strLoginUsuarioLogado,
                                            FOperadoresMensagens.FieldByName('OPE_CODOPE').AsString,
                                            'N',
                                            NullAsStringValue);
        End;

        FOperadoresMensagens.Next;
      End;
      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;

        Raise Exception.Create('Ocorreu um erro ao enviar a mensagem de Pix expirados aos operadores.' + #13 +
                               'Erro gerado: ' + E.Message);
      End;
    End;
  Finally
    FreeAndNil(LMensagemInterna);
    FreeAndNil(ADuplicatasExpiradas);
  End;
End;

class procedure TFuncoesPixMonitor.ExecutarRotinasConsultaAtivasMonitorPix(ATxId: string;
                                                                           AIgnorarPixTela: Boolean);
  Var
    LPixDao: TPixDao;

    LPixAtivos: TUniClientDataset;

    LRegistro: TDadosRetornoPixConsulta;

    LRequisicoes: IRequisicoesPix;

    {$IFDEF LINUX}
    LObjetoIntegracao: IIntegracaoPixCitel;
    {$ENDIF}

    LChaveAnterior,
    LErro,
    LRetorno,
    LTxIdPesquisa: String;

    LSeqconAdiantamento: Integer;

    LListaAutoIncremApagar,
    LPedidosExpirados,
    LDuplicatasExpiradas,
    LDuplicatasExpiradasAutoIncrem: TStringList;

    LRcxCon: INteger;

    LListaPixRemovidosAPI: TList<TPixRemovidoAPI>;

    LGravouLogErro: Boolean;
begin
  Try
    FMsgRpx := fCampoTabela('SIS_VALCFG',
                            'CFGSIS',
                            ['SIS_CODCFG', 'SIS_CODEMP'],
                            ['CFG_MSGRPX', VS_strCodEmp]);

    LPixDao := TPixDao.Create;
    LPixAtivos := LPixDao.RetornaListaDePixConsulta(LPixDao.EmpresaCentralizadoraDasConsultasPix, ATxId, AIgnorarPixTela);

   {$IFDEF LINUX}
    If LPixAtivos.IsEmpty And (Not ATxId.IsEmpty) Then
      WriteLog('Nada a processar para o txid ' + ATxId + ': o pix nao entrou na fila de ' +
               'consulta (status fora dos ativos, reserva da PIXTEL, ou vinculo ' +
               'chave/conta/portador ausente).', True);
   {$ENDIF}
    FOperadoresMensagens := LPixDao.RetornaListaDeOperadoresMensagens;
    LListaAutoIncremApagar := TStringList.Create;
    LListaPixRemovidosAPI := nil;
    LRegistro := nil;

    LGravouLogErro := False;

    Try
      LChaveAnterior := '';

      {$IFDEF LINUX}
      LObjetoIntegracao := TIntegracaoPixCitel.Create;
      InicializaIntegracaoPixCitel(LObjetoIntegracao);
      {$ENDIF}

      LPixAtivos.First;

      While Not LPixAtivos.Eof Do
      Begin
        If LChaveAnterior <> LPixAtivos.FieldByName('MPX_SEQPIX').AsString Then
        Begin
          LRequisicoes := CriaObjetoRequisicoesPixEmpresa(LPixAtivos.FieldByName('MPX_SEQPIX').AsString,
                                                          LPixAtivos.FieldByName('MPX_CODEMP').AsString);
          LChaveAnterior := LPixAtivos.FieldByName('MPX_SEQPIX').AsString;
        End;

        Try
          LRequisicoes.SetExecutandoPeloRobo('S');

          LGravouLogErro := True;
        Except
          LGravouLogErro := False;
        End;

        LTxIdPesquisa := RetornaTxIdDaPesquisa(LPixAtivos);

        LRequisicoes.SetIgnorarErro404Robo('N');
        If Assigned(FTxIdJaGravadoLogErrPix404) Then
          If FTxIdJaGravadoLogErrPix404.IndexOf(LTxIdPesquisa) > -1 Then
            LRequisicoes.SetIgnorarErro404Robo('S');

        LRetorno := LRequisicoes.ConsultarPixPorTxId(LTxIdPesquisa,
                                                     True,
                                                     LPixAtivos.FieldByName('MPX_JSOENV').AsString);

        LErro := TFuncoesPix.RetornaMensagemErroRequisicao(LRetorno);
        If Not LErro.IsEmpty Then
        Begin
          If RemoveRegistroPorBancoAoRetornarErro404(LErro,
                                                     LPixAtivos.FieldByName('MPX_TX_ID_').AsString,
                                                     LPixAtivos,
                                                     LListaAutoIncremApagar,
                                                     False) Then
          Begin
            LPixAtivos.Next;
            Continue;
          End
          Else If LeftStr(LErro, 10).Equals('Código 503') Then
          Begin
            Sleep(500);

            LPixAtivos.Next;
            Continue;
          End;

          Raise Exception.Create('ERRO_REQUISICAO-' + LErro);
        End;

        LRegistro := TFuncoesPix.RetornaDadosDoRetornoPixConsulta(LRetorno,
                                                                  LPixAtivos.FieldByName('MPX_JSOENV').AsString);

        If Not ValidacaoParaRealizarConsulta(LRegistro,
                                             LPixAtivos,
                                             LPixDao,
                                             AIgnorarPixTela) Then
        Begin
          LPixAtivos.Next;
          Continue;
        End;

        LRegistro.TxId := LPixAtivos.FieldByName('MPX_TX_ID_').AsString;
        LRegistro.CodigoEmpresa := LPixAtivos.FieldByName('MPX_CODEMP').AsString;
        LRegistro.CodigoPortador := LPixAtivos.FieldByName('POR_CODPOR').AsString;
        LRegistro.AutoIncremMovPix := LPixAtivos.FieldByName('AUTOINCREM').AsString;
        LRegistro.AutoIncremChavePix := LPixAtivos.FieldByName('MPX_SEQPIX').AsString;

        If LPixAtivos.FindField('MPX_CHA_CC') <> Nil Then
          LRegistro.ChaveParaCreditoCliente := LPixAtivos.FieldByName('MPX_CHA_CC').AsString;

        LRegistro.PlanoDeContas := fCfgSis('CTAPIX', varString, LRegistro.CodigoEmpresa);
        If LRegistro.PlanoDeContas.IsEmpty Then
          LRegistro.PlanoDeContas := fCfgSis('CTAAVI', varString, LRegistro.CodigoEmpresa);

        VerificaPagamentoNoAmbienteDeTestes(LRegistro);

        If TFuncoesPix.VerificaPixComStatusConcluidoEComValorPago(LRegistro) Then
        Begin
          If MatchStr(LPixDao.RetornaStatusDoPixAtualizado(LPixAtivos.FieldByName('AUTOINCREM').AsString), STATUS_PIX_PAGO) Then
          Begin
            LPixAtivos.Next;

            Continue;
          End;

          LRcxCon := StrToInt(fRetRcxCon);

          TPixDao.CorrigeParaDataZulu(LRegistro);

          fStartTransaction;

          If PixFoiGeradoPorPedido(LPixAtivos) Then
          Begin
            LSeqconAdiantamento := TAdiantamento.RealizarAdiantamentoClientePix('TFuncoesPixAutcom.ExecutarRotinasMonitorPix',
                                                                                LRegistro,
                                                                                LRcxCon);

            If LSeqconAdiantamento > 0 Then
            Begin
              RealizaLiberacaoDePedidosComPixPago(LRegistro.CodigoEmpresa,
                                                  LRegistro.TxId,
                                                  strLoginUsuarioLogado);

              LPixDao.AtualizaDadosRetornoConcluidoPix(LRegistro,
                                                       LSeqconAdiantamento,
                                                       'TFuncoesPixAutcom.ExecutarRotinasMonitorPix',
                                                       LPixAtivos.FieldByName('PIXNATELA').AsString = 'S');
            End;

            fCommit;

            EnviaMensagemPagamentoOperadores(LRegistro, LSeqconAdiantamento > 0);
          End
          Else
          Begin
            LRegistro.SeqConRecebimento := LRcxCon;
            LRegistro.CodigoOperadorMovPix := LPixAtivos.FieldByName('MPX_CODOPE').AsString;

            If LRegistro.ChaveParaCreditoCliente.IsEmpty Then
            Begin
              Try
                TContasAReceberPix.RealizarBaixaDoContasAReceber(LPixAtivos.FieldByName('MPX_TX_ID_').AsString,
                                                                 LPixAtivos.FieldByName('MPX_CODEMP').AsString,
                                                                 LRegistro);
              Except
                On E: Exception Do
                Begin
                  If E.Message = 'Duplicatas não foram encontradas para realizar a baixa!' Then
                    LRegistro.Status := LRegistro.Status + 'CC'
                  Else
                    Raise E;
                End;
              End;
            End
            Else
              TContasAReceberPix.GerarCreditoDeClientePix(LRegistro);

            LPixDao.AtualizaDadosRetornoConcluidoPix(LRegistro,
                                                     LRegistro.SeqConRecebimento,
                                                     'TFuncoesPixAutcom.ExecutarRotinasMonitorPix',
                                                     LPixAtivos.FieldByName('PIXNATELA').AsString = 'S');

            fCommit;

            If RightStr(LRegistro.Status, 2) <> 'CC' Then
              EnviaMensagemPagamentoOperadoresCTR(LRegistro)
            Else
              EnviaMensagemPagamentoOperadorTemporaria(LRegistro, LPixAtivos.FieldByName('MPX_CODOPE').AsString, True);
          End;
        End
        Else If MatchStr(LRegistro.Status, ['ATIVA', 'REMOVIDA_PELO_PSP', 'REMOVIDA_PELO_USUARIO_RECEBEDOR', 'CONCLUIDA', 'expired', 'ACTIVE']) Then
        Begin
          LListaAutoIncremApagar.Add(LPixAtivos.FieldByName('AUTOINCREM').AsString);

          If LRegistro.Status = 'ATIVA' Then
            AtualizaStatusCobrancaParaRemovida(LPixAtivos,
                                               LRequisicoes,
                                               LListaPixRemovidosAPI)
          Else If RegistroDoPixAtivoEExpirado(LPixAtivos.FieldByName('AUTOINCREM').AsString) Then
            LRequisicoes.RemoverQRCodePixBaseCitel(fRetCGCEmpresa(LPixAtivos.FieldByName('MPX_CODEMP').AsString),
                                                   LPixAtivos.FieldByName('MPX_CODEMP').AsString,
                                                   LPixAtivos.FieldByName('MPX_TX_ID_').AsString,
                                                   False);

        End;

        fLock_Unlock('CONSULTA_RECEBIMENTO_PIX_' + LPixAtivos.FieldByName('MPX_TX_ID_').AsString,
                     False,
                     False,
                     False,
                     '',
                     False,
                     'CONSULTA_RECEBIMENTO_PIX_' + LPixAtivos.FieldByName('MPX_TX_ID_').AsString);

        LPixAtivos.Next;
      End;

      ApagaPixAtivosExpirados(LListaAutoIncremApagar,
                              'TFuncoesPixAutcom.ExecutarRotinasMonitorPix',
                              LPedidosExpirados,
                              LDuplicatasExpiradas,
                              LDuplicatasExpiradasAutoIncrem,
                              LListaPixRemovidosAPI);

      EnviaMensagemPixExpiradosOperadores(LPedidosExpirados);

      GravaLogCTRExpirados(LDuplicatasExpiradasAutoIncrem);
      EnviaMensagemPixExpiradosOperadoresCTR(LDuplicatasExpiradas);

      LimparCADRECComPixExcluidoEmVersoesAnterioresDoMonitor;
    Except
      On E: Exception Do
      Begin
        fRollBack;

        If DeveGravarLogErrPix(LRetorno, LGravouLogErro, E.Message) Then
          GravarLogErr_Pix('Ocorreu um erro ao consultar o Pix no Monitor.' + #13 + E.Message.Replace('ERRO_REQUISICAO-', EmptyStr), fRetornaStack)
        Else
        Begin
         {$IFDEF LINUX}
          WriteLog(e.Message, True);
         {$ENDIF}
        End;

        fLock_Unlock('CONSULTA_RECEBIMENTO_PIX_' + LPixAtivos.FieldByName('MPX_TX_ID_').AsString,
                     False,
                     False,
                     False,
                     '',
                     False,
                     'CONSULTA_RECEBIMENTO_PIX_' + LPixAtivos.FieldByName('MPX_TX_ID_').AsString);

        RemoverCobrancasExpiradasEmCasoDeErrosNaAPI(LPixAtivos, False, Not DeveGravarLogErrPix(LRetorno, LGravouLogErro, E.Message));
      End;
    End;
  Finally
    FreeAndNil(LPixAtivos);
    FreeAndNil(LPixDao);
    FreeAndNil(FOperadoresMensagens);
    FreeAndNil(LListaAutoIncremApagar);

    If Assigned(LRegistro) Then
      FreeAndNil(LRegistro);

    If LListaPixRemovidosAPI <> Nil THen
      FreeAndNil(LListaPixRemovidosAPI);
  End;
end;

class procedure TFuncoesPixMonitor.ExecutarRotinasConsultaTemporariasAtivasMonitorPix(ATxId: string = '');
  Var
    LPixDao: TPixDao;

    LPixAtivos: TUniClientDataset;

    LPixLogExcluir: TUniQuery;

    LRegistro: TDadosRetornoPixConsulta;

    LRequisicoes: IRequisicoesPix;

    {$IFDEF LINUX}
    LObjetoIntegracao: IIntegracaoPixCitel;
    {$ENDIF}

    LChaveAnterior,
    LErro,
    LRetorno,
    LCodigoOperador,
    LTxIdPesquisa: String;

    LGravouLogErro,
    LRegistroInseridoMOVPIX: Boolean;

    LListaAutoIncremApagar: TStringList;

    LRcxCon: INteger;

    LListaPixRemovidosAPI: TList<TPixRemovidoAPI>;
begin
  Try
    LPixDao := TPixDao.Create;
    LListaAutoIncremApagar := TStringList.Create;
    LListaPixRemovidosAPI := nil;
    LRegistro := nil;

    LPixAtivos := LPixDao.RetornaListaDePixConsultaTemporaria(LPixDao.EmpresaCentralizadoraDasConsultasPix, ATxId);

    If LPixAtivos = Nil Then
      Exit;

    LGravouLogErro := False;

    Try
      LChaveAnterior := '';

      {$IFDEF LINUX}
      LObjetoIntegracao := TIntegracaoPixCitel.Create;
      InicializaIntegracaoPixCitel(LObjetoIntegracao);
      {$ENDIF}

      LPixAtivos.First;

      While Not LPixAtivos.Eof Do
      Begin
        If LChaveAnterior <> LPixAtivos.FieldByName('LOG_SEQPIX').AsString Then
        Begin
          LRequisicoes := CriaObjetoRequisicoesPixEmpresa(LPixAtivos.FieldByName('LOG_SEQPIX').AsString,
                                                          LPixAtivos.FieldByName('LOG_CODEMP').AsString);
          LChaveAnterior := LPixAtivos.FieldByName('LOG_SEQPIX').AsString;
        End;

        Try
          LRequisicoes.SetExecutandoPeloRobo('S');

          LGravouLogErro := True;
        Except
          LGravouLogErro := False;
        End;

        LTxIdPesquisa := RetornaTxIdDaPesquisaTemporaria(LPixAtivos);

        LRequisicoes.SetIgnorarErro404Robo('N');
        If Assigned(FTxIdJaGravadoLogErrPix404) Then
          If FTxIdJaGravadoLogErrPix404.IndexOf(LTxIdPesquisa) > -1 Then
            LRequisicoes.SetIgnorarErro404Robo('S');

        LRetorno := LRequisicoes.ConsultarPixPorTxId(LTxIdPesquisa,
                                                     True,
                                                     LPixAtivos.FieldByName('LOG_JSOENV').AsString);

        LErro := TFuncoesPix.RetornaMensagemErroRequisicao(LRetorno);
        If Not LErro.IsEmpty Then
        Begin
          If RemoveRegistroPorBancoAoRetornarErro404(LErro,
                                                     LPixAtivos.FieldByName('LOG_TX_ID_').AsString,
                                                     LPixAtivos,
                                                     LListaAutoIncremApagar,
                                                     True) Then
          Begin
            LPixAtivos.Next;
            Continue;
          End
          Else If LeftStr(LErro, 10).Equals('Código 503') Then
          Begin
            Sleep(500);

            LPixAtivos.Next;
            Continue;
          End;

          Raise Exception.Create('ERRO_REQUISICAO-' + LErro);
        End;

        LRegistro := TFuncoesPix.RetornaDadosDoRetornoPixConsulta(LRetorno,
                                                                  LPixAtivos.FieldByName('LOG_JSOREC').AsString);

        If Not ValidacaoParaRealizarConsultaTemporaria(LRegistro,
                                                       LPixAtivos,
                                                       LPixDao) Then
        Begin
          LPixAtivos.Next;
          Continue;
        End;

        LRegistro.TxId := LPixAtivos.FieldByName('LOG_TX_ID_').AsString;
        LRegistro.CodigoEmpresa := LPixAtivos.FieldByName('LOG_CODEMP').AsString;
        LRegistro.CodigoPortador := LPixDao.RetornaPortadorChavePix(LPixAtivos.FieldByName('LOG_SEQPIX').AsString);
        LRegistro.AutoIncremChavePix := LPixAtivos.FieldByName('LOG_SEQPIX').AsString;
        LRegistro.JSonRequisicao := LPixAtivos.FieldByName('LOG_JSOENV').AsString;
        LRegistro.LinkCitel := LPixAtivos.FieldByName('LOG_LNKCIT').AsString;
        LRegistro.CriadoPelo := 'FINANCEIRO';
        LRegistro.CodigoOperadorRobo := LPixAtivos.FieldByName('LOG_CODOPE').AsString;
        LRegistro.TextoQrCode := LPixAtivos.FieldByName('LOG_QRCODE').AsString;

        LRegistro.PlanoDeContas := fCfgSis('CTAPIX', varString, LRegistro.CodigoEmpresa);
        If LRegistro.PlanoDeContas.IsEmpty Then
          LRegistro.PlanoDeContas := fCfgSis('CTAAVI', varString, LRegistro.CodigoEmpresa);

        VerificaPagamentoNoAmbienteDeTestes(LRegistro);

        If TFuncoesPix.VerificaPixComStatusConcluidoEComValorPago(LRegistro) Then
        Begin
          LPixLogExcluir := fCriaQuery;
          LPixLogExcluir.SQL.Text := 'SELECT * FROM MONPIX_LOG WHERE AUTOINCREM="' + LPixAtivos.FieldByName('INCLOG').AsString + '"';
          LPixLogExcluir.Open;

          LRcxCon := StrToInt(fRetRcxCon);

          TPixDao.CorrigeParaDataZulu(LRegistro);

          fStartTransaction;

          LRegistro.Status := LRegistro.Status + 'CC';
          LRegistro.SeqConRecebimento := LRcxCon;

          LRegistroInseridoMOVPIX := LPixDao.InserirCobrancaPixRecebida(LRegistro,
                                                                        'untTFuncoesPixMonitor',
                                                                        False,
                                                                        strLoginUsuarioLogado,
                                                                        LPixAtivos.FieldByName('LOG_CODEMP').AsString);

          LCodigoOperador := LPixLogExcluir.FieldByName('LOG_CODOPE').AsString;

          fVerificaIntegridade('untTFuncoesPixMonitor',
                               'MONPIX_LOG',
                               LPixLogExcluir,
                               True,
                               False,
                               IIF(LRegistroInseridoMOVPIX ,
                                   'REMOVIDO POR ESTAR PAGO (MONITOR)',
                                   'REMOVIDO POR JÁ ESTAR NA MOVPIX'));

          LPixLogExcluir.Delete;

          FreeAndNil(LPixLogExcluir);

          fCommit;

          If LRegistroInseridoMOVPIX Then
            EnviaMensagemPagamentoOperadorTemporaria(LRegistro, LCodigoOperador);
        End
        Else If MatchStr(LRegistro.Status, ['ATIVA', 'REMOVIDA_PELO_PSP', 'REMOVIDA_PELO_USUARIO_RECEBEDOR', 'CONCLUIDA', 'expired', 'ACTIVE']) Then
        Begin
          LListaAutoIncremApagar.Add(LPixAtivos.FieldByName('INCLOG').AsString);

          If LRegistro.Status = 'ATIVA' Then
            AtualizaStatusCobrancaParaRemovidaTemporaria(LPixAtivos,
                                                         LRequisicoes,
                                                         LListaPixRemovidosAPI)
          Else If RegistroDoPixAtivoEExpiradoTemporaria(LPixAtivos.FieldByName('INCLOG').AsString) Then
            LRequisicoes.RemoverQRCodePixBaseCitel(fRetCGCEmpresa(LPixAtivos.FieldByName('LOG_CODEMP').AsString),
                                                   LPixAtivos.FieldByName('LOG_CODEMP').AsString,
                                                   LPixAtivos.FieldByName('LOG_TX_ID_').AsString,
                                                   False);
        End;

        fLock_Unlock('CONSULTA_RECEBIMENTO_PIX_' + LPixAtivos.FieldByName('LOG_TX_ID_').AsString,
                     False,
                     False,
                     False,
                     '',
                     False,
                     'CONSULTA_RECEBIMENTO_PIX_' + LPixAtivos.FieldByName('LOG_TX_ID_').AsString);

        LPixAtivos.Next;
      End;

      ApagaPixAtivosExpiradosTemporaria(LListaAutoIncremApagar,
                                        LListaPixRemovidosAPI);
    Except
      On E: Exception Do
      Begin
        fRollBack;

        fLock_Unlock('CONSULTA_RECEBIMENTO_PIX_' + LPixAtivos.FieldByName('LOG_TX_ID_').AsString,
                     False,
                     False,
                     False,
                     '',
                     False,
                     'CONSULTA_RECEBIMENTO_PIX_' + LPixAtivos.FieldByName('LOG_TX_ID_').AsString);

        If DeveGravarLogErrPix(LRetorno, LGravouLogErro, E.Message) Then
          GravarLogErr_Pix('Ocorreu um erro ao consultar o Pix no Monitor.' + #13 + E.Message.Replace('ERRO_REQUISICAO-', EmptyStr), fRetornaStack)
        Else
        Begin
         {$IFDEF LINUX}
          WriteLog(e.Message, True);
         {$ENDIF}
        End;

        RemoverCobrancasExpiradasEmCasoDeErrosNaAPI(LPixAtivos, True, Not DeveGravarLogErrPix(LRetorno, LGravouLogErro, E.Message));
      End;
    End;
  Finally
    FreeAndNil(LPixDao);

    If Assigned(LPixAtivos) Then
      FreeAndNil(LPixAtivos);

    If Assigned(LListaAutoIncremApagar) Then
      FreeAndNil(LListaAutoIncremApagar);

    If Assigned(LRegistro) Then
      FreeAndNil(LRegistro);

    If LListaPixRemovidosAPI <> Nil THen
      FreeAndNil(LListaPixRemovidosAPI);
  End;
end;

class procedure TFuncoesPixMonitor.ExecutarRotinasConsultaTemporariasPagasMonitorPix(ATxId: string = '');
  Var
    LPixDao: TPixDao;

    LPixAtivos: TUniClientDataset;

    LRegistro: TDadosRetornoPixConsulta;

    LRequisicoes: IRequisicoesPix;

    {$IFDEF LINUX}
    LObjetoIntegracao: IIntegracaoPixCitel;
    {$ENDIF}

    LChaveAnterior,
    LErro,
    LRetorno,
    LCodigoOperador,
    LTxIdPesquisa: String;

    LGravouLogErro,
    LRegistroInseridoMOVPIX: Boolean;

    LListaAutoIncremApagar: TStringList;

    LRcxCon: INteger;

    LListaPixRemovidosAPI: TList<TPixRemovidoAPI>;
begin
  Try
    LPixDao := TPixDao.Create;
    LListaAutoIncremApagar := TStringList.Create;
    LListaPixRemovidosAPI := nil;
    LRegistro := nil;

    LPixAtivos := LPixDao.RetornaListaDePixConsultaTemporariaPago(LPixDao.EmpresaCentralizadoraDasConsultasPix, ATxId);

    If LPixAtivos = Nil Then
      Exit;

    LGravouLogErro := False;

    Try
      LChaveAnterior := '';

      {$IFDEF LINUX}
      LObjetoIntegracao := TIntegracaoPixCitel.Create;
      InicializaIntegracaoPixCitel(LObjetoIntegracao);
      {$ENDIF}

      LPixAtivos.First;

      While Not LPixAtivos.Eof Do
      Begin
        If LChaveAnterior <> LPixAtivos.FieldByName('LOG_SEQPIX').AsString Then
        Begin
          LRequisicoes := CriaObjetoRequisicoesPixEmpresa(LPixAtivos.FieldByName('LOG_SEQPIX').AsString,
                                                          LPixAtivos.FieldByName('LOG_CODEMP').AsString);
          LChaveAnterior := LPixAtivos.FieldByName('LOG_SEQPIX').AsString;
        End;

        Try
          LRequisicoes.SetExecutandoPeloRobo('S');

          LGravouLogErro := True;
        Except
          LGravouLogErro := False;
        End;

        LTxIdPesquisa := RetornaTxIdDaPesquisaTemporaria(LPixAtivos);

        LRequisicoes.SetIgnorarErro404Robo('N');
        If Assigned(FTxIdJaGravadoLogErrPix404) Then
          If FTxIdJaGravadoLogErrPix404.IndexOf(LTxIdPesquisa) > -1 Then
            LRequisicoes.SetIgnorarErro404Robo('S');

        LRetorno := LRequisicoes.ConsultarPixPorTxId(LTxIdPesquisa,
                                                     True,
                                                     LPixAtivos.FieldByName('LOG_JSOENV').AsString);

        LErro := TFuncoesPix.RetornaMensagemErroRequisicao(LRetorno);
        If Not LErro.IsEmpty Then
        Begin
          If RemoveRegistroPorBancoAoRetornarErro404(LErro,
                                                     LPixAtivos.FieldByName('LOG_TX_ID_').AsString,
                                                     LPixAtivos,
                                                     LListaAutoIncremApagar,
                                                     True) Then
          Begin
            LPixAtivos.Next;
            Continue;
          End
          Else If LeftStr(LErro, 10).Equals('Código 503') Then
          Begin
            Sleep(500);

            LPixAtivos.Next;
            Continue;
          End;

          Raise Exception.Create('ERRO_REQUISICAO-' + LErro);
        End;

        LRegistro := TFuncoesPix.RetornaDadosDoRetornoPixConsulta(LRetorno,
                                                                  LPixAtivos.FieldByName('LOG_JSOREC').AsString);

        If LRegistro = Nil Then
        Begin
          LPixAtivos.Next;
          Continue;
        End;

        If Assigned(LRegistro.DadosDevolucao) Then
        Begin
          If LRegistro.DadosDevolucao.Count > 0 Then
          Begin
            AtualizaStatusDelMonitorPixPagoParaDevolvido(LPixAtivos);

            LPixAtivos.Next;
            Continue;
          End;
        End;

        LRegistro.TxId := LPixAtivos.FieldByName('LOG_TX_ID_').AsString;
        LRegistro.CodigoEmpresa := LPixAtivos.FieldByName('LOG_CODEMP').AsString;
        LRegistro.CodigoPortador := LPixDao.RetornaPortadorChavePix(LPixAtivos.FieldByName('LOG_SEQPIX').AsString);
        LRegistro.AutoIncremChavePix := LPixAtivos.FieldByName('LOG_SEQPIX').AsString;
        LRegistro.JSonRequisicao := LPixAtivos.FieldByName('LOG_JSOENV').AsString;
        LRegistro.LinkCitel := LPixAtivos.FieldByName('LOG_LNKCIT').AsString;
        LRegistro.CriadoPelo := 'FINANCEIRO';
        LRegistro.CodigoOperadorRobo := LPixAtivos.FieldByName('LOG_CODOPE').AsString;
        LRegistro.TextoQrCode := LPixAtivos.FieldByName('LOG_QRCODE').AsString;

        LRegistro.PlanoDeContas := fCfgSis('CTAPIX', varString, LRegistro.CodigoEmpresa);
        If LRegistro.PlanoDeContas.IsEmpty Then
          LRegistro.PlanoDeContas := fCfgSis('CTAAVI', varString, LRegistro.CodigoEmpresa);

        VerificaPagamentoNoAmbienteDeTestes(LRegistro);

        If TFuncoesPix.VerificaPixComStatusConcluidoEComValorPago(LRegistro) Then
        Begin
          LRcxCon := StrToInt(fRetRcxCon);

          TPixDao.CorrigeParaDataZulu(LRegistro);

          fStartTransaction;

          LRegistro.Status := LRegistro.Status + 'CC';
          LRegistro.SeqConRecebimento := LRcxCon;

          LRegistroInseridoMOVPIX := LPixDao.InserirCobrancaPixRecebida(LRegistro,
                                                                        'untTFuncoesPixMonitor',
                                                                        False,
                                                                        strLoginUsuarioLogado,
                                                                        LPixAtivos.FieldByName('LOG_CODEMP').AsString);

          LCodigoOperador := LPixAtivos.FieldByName('LOG_CODOPE').AsString;

          fCommit;

          If LRegistroInseridoMOVPIX Then
            EnviaMensagemPagamentoOperadorTemporaria(LRegistro, LCodigoOperador);
        End;

        fLock_Unlock('CONSULTA_RECEBIMENTO_PIX_' + LPixAtivos.FieldByName('LOG_TX_ID_').AsString,
                     False,
                     False,
                     False,
                     '',
                     False,
                     'CONSULTA_RECEBIMENTO_PIX_' + LPixAtivos.FieldByName('LOG_TX_ID_').AsString);

        LPixAtivos.Next;
      End;

      ApagaPixAtivosExpiradosTemporaria(LListaAutoIncremApagar,
                                        LListaPixRemovidosAPI);
    Except
      On E: Exception Do
      Begin
        fRollBack;

        fLock_Unlock('CONSULTA_RECEBIMENTO_PIX_' + LPixAtivos.FieldByName('LOG_TX_ID_').AsString,
                     False,
                     False,
                     False,
                     '',
                     False,
                     'CONSULTA_RECEBIMENTO_PIX_' + LPixAtivos.FieldByName('LOG_TX_ID_').AsString);

        If DeveGravarLogErrPix(LRetorno, LGravouLogErro, E.Message) Then
          GravarLogErr_Pix('Ocorreu um erro ao consultar o Pix no Monitor.' + #13 + E.Message.Replace('ERRO_REQUISICAO-', EmptyStr), fRetornaStack)
        Else
        Begin
         {$IFDEF LINUX}
          WriteLog(e.Message, True);
         {$ENDIF}
        End;

        RemoverCobrancasExpiradasEmCasoDeErrosNaAPI(LPixAtivos, True, Not DeveGravarLogErrPix(LRetorno, LGravouLogErro, E.Message));
      End;
    End;
  Finally
    FreeAndNil(LPixDao);

    If Assigned(LPixAtivos) Then
      FreeAndNil(LPixAtivos);

    If Assigned(LListaAutoIncremApagar) Then
      FreeAndNil(LListaAutoIncremApagar);

    If Assigned(LRegistro) Then
      FreeAndNil(LRegistro);

    If LListaPixRemovidosAPI <> Nil THen
      FreeAndNil(LListaPixRemovidosAPI);
  End;
end;

class procedure TFuncoesPixMonitor.GravaLogCTRExpirados(
  var ADuplicatasExpiradasAutoincrem: TStringList);
  Var
    LAutoIncrem: String;
begin
  Try
    If ADuplicatasExpiradasAutoincrem.Count <= 0 Then
      Exit;

    Try
      fStartTransaction;
      For LAutoincrem In ADuplicatasExpiradasAutoincrem Do
        untLogCtr.GravaLogCtr(LAutoIncrem,
                              'EXCLUSÃO PIX EXPIRADO',
                              'untTFuncoesPixMonitor.GravaLogCTRExpirados');

      fCommit;
    Except
      On E: Exception Do
        Raise Exception.Create(E.Message);
    End;
  Finally
    FreeAndNil(ADuplicatasExpiradasAutoincrem);
  End;
end;

class procedure TFuncoesPixMonitor.GravarLogErr_Pix(ADescricao,
  ARelatorio: String);
  Var
    LLogErr_Pix: TUniQuery;
begin
 {$IFDEF LINUX}
  WriteLog(ADescricao, True);
 {$ENDIF}

  LLogErr_Pix := fCriaQuery(Nil);
  LLogErr_Pix.SQL.Text := 'SELECT * FROM LOGERR_PIX WHERE FALSE';

  Try
    Try
      LLogErr_Pix.Open;
      LLogErr_Pix.Insert;
      LLogErr_Pix.FieldByName('LOG_CODEMP').AsString   := VS_strCodEmp;
      LLogErr_Pix.FieldByName('LOG_CODOPE').AsString   := strLoginUsuarioLogado;
      LLogErr_Pix.FieldByName('LOG_DTAERR').AsDateTime := fRetDataServidor;
      LLogErr_Pix.FieldByName('LOG_HORERR').AsDateTime := fRetHoraServidor;
      LLogErr_Pix.FieldByName('LOG_DESCRI').AsString   := ADescricao;

      If Not ARelatorio.IsEmpty Then
        LLogErr_Pix.FieldByName('LOG_RELERR').AsString := ARelatorio;

      LLogErr_Pix.Post;
      LLogErr_Pix.Close;
    Except
      //para que o robo finalize, no caso de qualquer problema ao gravar logerr
    End;
  Finally
    FreeAndNil(LLogErr_Pix);
  End;
end;

class procedure TFuncoesPixMonitor.LimparCADRECComPixExcluidoEmVersoesAnterioresDoMonitor;
  Var
    LConsulta,
    LAtualizacao: TUniQuery;
begin
  Try
    LConsulta := fCriaQuery;
    LAtualizacao := fCriaQuery;

    LConsulta.SQL.Text := 'SELECT * FROM CADREC WHERE FALSE';
    LConsulta.Open;

    If LConsulta.FindField('CTR_TX_PIX') = Nil Then
      Exit;

    If LConsulta.FindField('CTR_PIXTIP') = Nil Then
      Exit;

    LConsulta.Close;
    LConsulta.SQL.Text := 'SELECT AUTOINCREM ' +
                          'FROM CADREC ' +
                          'WHERE (CTR_EMPPIX IS NOT NULL AND CTR_TX_PIX IS NOT NULL) ' +
                          '  AND CTR_DTAREC IS NULL ' +
                          '  AND (SELECT IFNULL(COUNT(AUTOINCREM), 0) ' +
                          '       FROM MOVPIX ' +
                          '       WHERE MPX_CODEMP = CTR_EMPPIX ' +
                          '         AND MPX_TX_ID_ = CTR_TX_PIX) = 0 ';

    LConsulta.Open;

    If LConsulta.IsEmpty Then
      Exit;

    fStartTransaction;
    While Not LConsulta.Eof Do
    Begin
      LAtualizacao.Close;
      LAtualizacao.SQL.Text := 'UPDATE CADREC ' +
                               'SET CTR_EMPPIX=NULL, ' +
                               '    CTR_TX_PIX=NULL, ' +
                               '    CTR_PIXTIP=NULL, ' +
                               '    CTR_PIXREC=NULL, ' +
                               '    CTR_PIXJUR=NULL, ' +
                               '    CTR_PIXDES=NULL, ' +
                               '    CTR_PIXCOB=NULL, ' +
                               '    CTR_PIXCOR=NULL  ' +
                               'WHERE AUTOINCREM="' + LConsulta.FieldByName('AUTOINCREM').AsString + '"';

      LAtualizacao.ExecSQL;

      LConsulta.Next;
    End;
    fCommit;
  Finally
    FreeAndNil(LConsulta);
    FreeAndNil(LAtualizacao);
  End;
end;

class function TFuncoesPixMonitor.PixFoiGeradoPorPedido(
  ADataset: TUniClientDataset): Boolean;
begin
  Result := True;

  If ADataset.FindField('MPX_CRIADO') = Nil Then
    Exit;

  Result := ADataset.FieldByName('MPX_CRIADO').AsString <> 'FINANCEIRO';
end;

class function TFuncoesPixMonitor.ValidacaoParaRealizarConsulta(
  ARegistro: TDadosRetornoPixConsulta; ADatasetRegistro: TUniClientDataset;
  APixDao: TPixDao; const AIgnorarPixTela: Boolean): Boolean;
begin
  If ARegistro = Nil Then
    Exit(False);

  If MatchStr(APixDao.RetornaStatusDoPixAtualizado(ADatasetRegistro.FieldByName('AUTOINCREM').AsString), ['CONCLUIDA', '', 'approved']) Then
    Exit(False);

  If (Not AIgnorarPixTela) And
     APixDao.VerificaSeOPixEstaAbertoNaTela(ADatasetRegistro.FieldByName('AUTOINCREM').AsString) Then
    Exit(False);

  Result := fLock_Unlock('CONSULTA_RECEBIMENTO_PIX_' + ADatasetRegistro.FieldByName('MPX_TX_ID_').AsString,
                         True,
                         False,
                         False,
                         '',
                         False);
end;

class function TFuncoesPixMonitor.ValidacaoParaRealizarConsultaTemporaria(
  ARegistro: TDadosRetornoPixConsulta; ADatasetRegistro: TUniClientDataset;
  APixDao: TPixDao): Boolean;
begin
  If ARegistro = Nil Then
    Exit(False);

  Result := fLock_Unlock('CONSULTA_RECEBIMENTO_PIX_' + ADatasetRegistro.FieldByName('LOG_TX_ID_').AsString,
                         True,
                         False,
                         False,
                         '',
                         False);
end;

class procedure TFuncoesPixMonitor.VerificaPagamentoNoAmbienteDeTestes(
  var ARegistro: TDadosRetornoPixConsulta);
  Var
    LConsulta: TUniQuery;
begin
  If MatchStr(ARegistro.Status, STATUS_PIX_PAGO) Then
    Exit;

  If fCfgSis('HOMPIX', varString, ARegistro.CodigoEmpresa) <> 'S' Then
    Exit;

  Try
    Try
      LConsulta := fCriaQuery;

      LConsulta.SQL.Text := 'SHOW TABLES LIKE "TESTE_INTERNO_CONSULTA_PIX"';
      LConsulta.Open;
      If LConsulta.IsEmpty Then
        Exit;

      LConsulta.Close;
      LConsulta.SQL.Text := 'SELECT TXIDPIX FROM TESTE_INTERNO_CONSULTA_PIX ' +
                            'WHERE TXIDPIX="' + ARegistro.TxId + '"';
      LConsulta.Open;

      If Not LConsulta.IsEmpty Then
      Begin
        ARegistro.JsonRetorno := ARegistro.JsonRetorno +
                                 ',"pix": ' +
                                 '[{"endToEndId":"PAGAMENTOFORCADOROBOQRCODE",' +
                                 '"txid":"' + ARegistro.TxId + '",' +
                                 '"valor":"' + ReplaceStr(ReplaceStr(FormatFloat(',0.00', ARegistro.Valor), '.', EmptyStr), ',', '.') + '",' +
                                 '"pagador":{"cnpj":"97441842000110","nome":"TELEFONICA BRASIL S.A."},' +
                                 '"horario":"' + FormatDateTime('yyyy-mm-dd', fNow) + 'T' + FormatDateTime('hh:mm:ss', fNow) + '-03:00"}]}';

        ARegistro.Status := 'CONCLUIDA';
        ARegistro.ValorPago := ARegistro.Valor;
        ARegistro.EndToEndId := 'PAGAMENTOFORCADOROBOQRCODE';
        ARegistro.CPFCNPJPagador := '97441842000110';
        ARegistro.NomePagador := 'TELEFONICA BRASIL S.A.';
        ARegistro.DataPagamento := fNow;
        ARegistro.InformacaoPagador := 'Pagamento forçado para testes';

        LConsulta.Delete;
      End;
    Except
      //não faz nada
    End;
  Finally
    FreeAndNIl(LConsulta);
  End;
end;

class function TFuncoesPixMonitor.VerificaSeCampoExisteNaMovPix(
  ANomeCampo: String): Boolean;
  Var
    LConsulta: TUniQuery;
begin
  Try
    LConsulta := fCriaQuery;

    LConsulta.SQL.Text := 'SELECT * FROM MOVPIX WHERE FALSE';
    LConsulta.Open;

    Result := LConsulta.FindField(ANomeCampo) <> Nil;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

class function TFuncoesPixMonitor.RetornaBancoDaChavePix(
  AAutoIncremChavePix: String): String;
  Var
    LConsulta: TUniQuery;
begin
  Try
    LConsulta := fCriaQuery;
    LConsulta.SQL.Text := 'SELECT CADCCA.CCA_CODBCO ' +
                          ' FROM CCAPIX ' +
                          ' JOIN CADCCA ON CADCCA.AUTOINCREM=CCAPIX.PIX_SEQCCA ' +
                          'WHERE CCAPIX.AUTOINCREM="' + AAutoIncremChavePix + '"';
    LConsulta.Open;

    Result := LConsulta.FieldByName('CCA_CODBCO').AsString;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

class function TFuncoesPixMonitor.RetornaListaDuplicatasPix(AEmpresaPix,
                                                            ATxIdPix: String;
                                                            var ADuplicatasAutoIncrem: TStringList): String;
  Var
    LConsulta: TUniQuery;
begin
  Result := '';

  If ATxIdPix.IsEmpty Then
    Exit;

  Try
    LConsulta := fCriaQuery;

    LConsulta.SQL.Text := 'SELECT CONCAT(R.CTR_NUMDUP,      ' +
                          '              R.CTR_PARCEL, "-", ' +
                          '              R.CTR_ESPDOC, "-", ' +
                          '              R.CTR_CODEMP)      ' +
                          '       AS DUPLICATA,             ' +
                          '       CONCAT(R.CTR_CODCLI, "-", ' +
                          '              C.CLI_NOMCLI)      ' +
                          '       AS CLIENTE,               ' +
                          '       R.AUTOINCREM              ' +
                          'FROM CADREC R ' +
                          'LEFT JOIN CADCLI C ON C.CLI_CODCLI=R.CTR_CODCLI ' +
                          'WHERE R.CTR_EMPPIX="' + AEmpresaPix + '" ' +
                          '  AND R.CTR_TX_PIX="' + ATxIdPix + '" ';

    LConsulta.Open;

    While Not LConsulta.Eof Do
    Begin
      Result := Result + LConsulta.FieldByName('DUPLICATA').AsString + ', ';

      ADuplicatasAutoIncrem.Add(LConsulta.FieldByName('AUTOINCREM').AsString);

      LConsulta.Next;
    End;

    If Not Result.IsEmpty Then
      Result := LeftStr(Result, Result.Length - 2) + #13 +
                'Cliente: ' + LConsulta.FieldByName('CLIENTE').AsString;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

class function  TFuncoesPixMonitor.RetornaListaPedidosPix(AEmpresaPix,
                                                          ATxIdPix: String): String;
  Var
    LConsulta: TUniQuery;
begin
  Result := '';

  If ATxIdPix.IsEmpty Then
    Exit;

  Try
    LConsulta := fCriaQuery;

    LConsulta.SQL.Text := 'SELECT CONCAT(F.FGO_NUMDOC, "-", ' +
                          '              F.FGO_ESPDOC, "-", ' +
                          '              F.FGO_CODEMP, " - Cliente: ", ' +
                          '              F.FGO_CODCLI, "-", ' +
                          '              C.CLI_NOMCLI)      ' +
                          '       AS PEDIDO                 ' +
                          'FROM EXTGOR E ' +
                          'JOIN FATGOR F ON F.AUTOINCREM=E.FGO_SEQFGO ' +
                          'LEFT JOIN CADCLI C ON C.CLI_CODCLI=F.FGO_CODCLI ' +
                          'WHERE E.FGO_EMPPIX="' + AEmpresaPix + '" ' +
                          '  AND E.FGO_TX_PIX="' + ATxIdPix + '" ';

    LConsulta.Open;

    While Not LConsulta.Eof Do
    Begin
      Result := Result + LConsulta.FieldByName('PEDIDO').AsString + ', ';

      LConsulta.Next;
    End;

    If Not Result.IsEmpty Then
      Result := LeftStr(Result, Result.Length - 2);
  Finally
    FreeAndNil(LConsulta);
  End;
end;

class function TFuncoesPixMonitor.RetornaTxIdDaPesquisa(
  ADataset: TDataset): String;
begin
  Result := ADataset.FieldByName('MPX_TX_ID_').AsString;

  If ADataset.FindField('MPX_ORDREF') = Nil Then
    Exit;

  If ADataset.FieldByName('CCA_CODBCO').AsString.Equals('208') Then
    Result := ADataset.FieldByName('MPX_ORDREF').AsString;
end;

class function TFuncoesPixMonitor.RetornaTxIdDaPesquisaTemporaria(
  ADataset: TDataset): String;
begin
  Result := ADataset.FieldByName('LOG_TX_ID_').AsString;

  If ADataset.FieldByName('CCA_CODBCO').AsString.Equals('208') Then
    Result := TFuncoesPix.RetornaDadosDoRetornoPixAVistaBtgPactual(ADataset.FieldByName('LOG_JSOENV').AsString,
                                                                   ADataset.FieldByName('LOG_JSOREC').AsString,
                                                                   ADataset.FieldByName('LOG_SEQPIX').AsString).OrderRef;
end;

class procedure TFuncoesPixMonitor.RealizaLiberacaoDePedidosComPixPago(AEmpresaDoPix,
  ATxIdPix, ACodigoOperador: String);
  Var
    LConsulta,
    LAtualizar: TUniQuery;

    LDataLiberacao: TDateTime;

    LHoraLiberacao: TTime;

    LOperadorRobo: String;
begin
  If fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [AEmpresaDoPix, 'CFG_LIBPIX']) <> 'S' Then
    Exit;

  Try
    LConsulta := fCriaQuery;
    LAtualizar := fCriaQuery;

    LConsulta.SQL.Text := 'SELECT E.FGO_SEQFGO ' +
                          'FROM EXTGOR E ' +
                          'JOIN FATGOR G ON G.AUTOINCREM=E.FGO_SEQFGO ' +
                          'WHERE E.FGO_EMPPIX=:EMPPIX ' +
                          '  AND E.FGO_TX_PIX=:TX_PIX ' +
                          '  AND (G.FGO_LIBERA IS NULL OR ' +
                          '       G.FGO_LIBERA=0) ';

    LConsulta.ParamByName('EMPPIX').AsString := AEmpresaDoPix;
    LConsulta.ParamByName('TX_PIX').AsString := ATxIdPix;

    LConsulta.Open;

    LAtualizar.SQL.Text := 'SELECT G.AUTOINCREM, ' +
                           '       G.FGO_OPELIB, ' +
                           '       G.FGO_DIGLIB, ' +
                           '       G.FGO_DTALIB, ' +
                           '       G.FGO_HORLIB, ' +
                           '       G.FGO_OBSL01, ' +
                           '       G.FGO_OBSL02, ' +
                           '       G.FGO_LIBERA  ' +
                           ' FROM FATGOR G ' +
                           ' WHERE ' +
                           '       G.AUTOINCREM=:AUTINC ';

    LDataLiberacao := fRetDataServidor;
    LHoraLiberacao := fRetHoraServidor;

    LOperadorRobo := fCfgSis('OPEAUT');
    If LOperadorRobo.IsEmpty Then
      LOperadorRobo := 'AUT';

    While Not LConsulta.Eof Do
    Begin
      LAtualizar.Close;
      LAtualizar.ParamByName('AUTINC').AsString := LConsulta.FieldByName('FGO_SEQFGO').AsString;
      LAtualizar.Open;

      LAtualizar.Edit;
      LAtualizar.FieldByName('FGO_LIBERA').AsInteger := 1;
      LAtualizar.FieldByName('FGO_OPELIB').AsString := ACodigoOperador;
      LAtualizar.FieldByName('FGO_DIGLIB').AsString := ACodigoOperador;
      LAtualizar.FieldByName('FGO_DTALIB').AsDateTime := LDataLiberacao;
      LAtualizar.FieldByName('FGO_HORLIB').AsDateTime := LHoraLiberacao;
      LAtualizar.FieldByName('FGO_OBSL01').AsString := 'LIBERADO PELO RECEBIMENTO FEITO POR PIX';

      If ACodigoOperador = LOperadorRobo Then
        LAtualizar.FieldByName('FGO_OBSL02').AsString := 'LIBERAÇÃO FEITA ATRAVÉS DA TAREFA AUTOMÁTICA';

      LAtualizar.Post;

      LConsulta.Next;
    End;
  Finally
    FreeAndNil(LConsulta);
    FreeAndNil(LAtualizar);
  End;
end;

class function TFuncoesPixMonitor.RegistroDoPixAtivoEExpirado(
  AAutoincrem: String): Boolean;
  Var
    LConsulta: TUniQuery;
begin
  Try
    LConsulta := fCriaQuery;
    LConsulta.SQL.Text := 'SELECT AUTOINCREM    ' +
                          'FROM MOVPIX M ' +
                          'WHERE M.AUTOINCREM="' + AAutoIncrem + '" ' +
                          '  AND M.MPX_STATUS IN ("ATIVACC", "ATIVA", "pending", "pendingv", "pendingvCC", "ACTIVE", "ACTIVECC") ' +
                          '  AND M.MPX_DTAHOR <= DATE_ADD(CURRENT_TIMESTAMP, INTERVAL (M.MPX_EXPIRA + 21600) * - 1 SECOND) ';

    LConsulta.Open;

    Result := Not LConsulta.IsEmpty;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

class function TFuncoesPixMonitor.RegistroDoPixAtivoEExpiradoTemporaria(
  AAutoincrem: String): Boolean;
  Var
    LConsulta: TUniQuery;
begin
  Try
    LConsulta := fCriaQuery;
    LConsulta.SQL.Text := 'SELECT AUTOINCREM    ' +
                          'FROM MONPIX_LOG M ' +
                          'WHERE M.AUTOINCREM="' + AAutoIncrem + '" ' +
                          '  AND M.LOG_STATUS IN ("ATIVACC", "ATIVA", "pending", "pendingv", "pendingvCC", "ACTIVE", "ACTIVECC") ' +
                          '  AND M.LOG_DTACAD <= DATE_ADD(CURRENT_TIMESTAMP, INTERVAL (M.LOG_EXPIRA + 3600) * - 1 SECOND) ';

    LConsulta.Open;

    Result := Not LConsulta.IsEmpty;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

class procedure TFuncoesPixMonitor.RemoverCobrancasExpiradasEmCasoDeErrosNaAPI(
  APixAtivo: TDataset; ATemporaria: Boolean; AGravarOErro: Boolean);
  Var
    LDelete,
    LAtualiza: TUniQuery;

    LTabela,
    LCampoAutoIncrem: String;

    LValidaDuplicatas: Boolean;
begin
  If Not Assigned(APixAtivo) Then
    Exit;

  If Not APixAtivo.Active Then
    Exit;

  If APixAtivo.IsEmpty Then
    Exit;

  If Not TPixDao.PixExpiradoMaisDeUmDeterminadoPeriodo(APixAtivo,
                                                       TEMPO_MINIMO_REMOCAO_COBRANCA_EXPIRADA,
                                                       ATemporaria) Then
    Exit;

  LDelete := Nil;
  LAtualiza := Nil;

  LTabela := 'MOVPIX';
  LCampoAutoIncrem := 'AUTOINCREM';
  If ATemporaria Then
  Begin
    LTabela := 'MONPIX_LOG';
    LCampoAutoIncrem := 'INCLOG';
  End;

  fStartTransaction;
  Try
    Try
      LDelete := fCriaQuery;
      LDelete.SQL.Text := 'SELECT * FROM ' + LTabela + ' WHERE AUTOINCREM=:AUTOIN';
      LDelete.ParamByName('AUTOIN').AsString := APixAtivo.FieldByName(LCampoAutoIncrem).AsString;
      LDelete.Open;

      If LDelete.IsEmpty Then
      Begin
        fRollBack;
        Exit;
      End;

      If Not ATemporaria Then
      Begin
        LValidaDuplicatas := APixAtivo.FindField('MPX_CRIADO') <> Nil;
        If LValidaDuplicatas Then
          LValidaDuplicatas := APixAtivo.FindField('MPX_CRIADO').AsString = 'FINANCEIRO';

        LAtualiza := fCriaQuery;

        If Not LValidaDuplicatas Then
        Begin
          LAtualiza.SQL.Text := 'UPDATE EXTGOR SET FGO_TX_PIX=NULL, FGO_EMPPIX=NULL ' +
                                'WHERE FGO_EMPPIX="' + APixAtivo.FieldByName('MPX_CODEMP').AsString + '" ' +
                                '  AND FGO_TX_PIX="' + APixAtivo.FieldByName('MPX_TX_ID_').AsString + '" ';
          LAtualiza.ExecSQL;
        End
        Else
        Begin
          LAtualiza.SQL.Text := 'UPDATE CADREC SET CTR_TX_PIX=NULL, CTR_EMPPIX=NULL, CTR_PIXTIP=NULL, ' +
                                '                  CTR_PIXREC=NULL, CTR_PIXJUR=NULL, CTR_PIXDES=NULL, ' +
                                '                  CTR_PIXCOB=NULL, CTR_PIXCOR=NULL                   ' +
                                'WHERE CTR_EMPPIX="' + APixAtivo.FieldByName('MPX_CODEMP').AsString + '" ' +
                                '  AND CTR_TX_PIX="' + APixAtivo.FieldByName('MPX_TX_ID_').AsString + '" ';
          LAtualiza.ExecSQL;
        End;

        TLogMpx.GravaLogMpx(APixAtivo.FieldByName(LCampoAutoIncrem).AsString,
                            'EXCLUSÃO PIX EXPIRADO',
                            'TFuncoesPixAutcom.ExecutarRotinasMonitorPix');

        fVerificaIntegridade('TFuncoesPixAutcom.ExecutarRotinasMonitorPix',
                             'MOVPIX',
                             LDelete,
                             True);

        TPixDao.ApagarRegistroNaTabelaPixTel(APixAtivo.FieldByName(LCampoAutoIncrem).AsString,
                                             True);
      End
      Else
        fVerificaIntegridade('untTFuncoesPixMonitor',
                             'MONPIX_LOG',
                             LDelete,
                             True,
                             False,
                             'REMOVIDO PIX EXPIRADO (MONITOR)',
                             strLoginUsuarioLogado);

      LDelete.Delete;

      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;

        If AGravarOErro Then
          GravarLogErr_Pix('Erro ao remover Pix Expirado com erro: ' + E.Message, fRetornaStack);
      End;
    End;
  Finally
    FreeAndNilDatasets(LDelete);
    FreeAndNilDatasets(LAtualiza);
  End;
end;

class function TFuncoesPixMonitor.RemoveRegistroPorBancoAoRetornarErro404(
  AMensagemErro, ATxIdPix: String; APixAtivo: TDataset;
  var AListaPixApagar: TStringList; ATemporaria: Boolean): Boolean;
begin
  Result := AMensagemErro.ToUpperInvariant.Contains('CÓDIGO DO RETORNO: 404');
  If Not Result Then
    Exit;

  If TPixDao.PixExpiradoMaisDeUmDeterminadoPeriodo(APixAtivo,
                                                   TEMPO_MINIMO_EXPIRACAO_REMOVER_404,
                                                   ATemporaria) Then
    AListaPixApagar.Add(APixAtivo.FieldByName('AUTOINCREM').AsString)
  Else
  Begin
    If Assigned(FTxIdJaGravadoLogErrPix404) Then
      If FTxIdJaGravadoLogErrPix404.IndexOf(ATxIdPix) = -1 Then
        FTxIdJaGravadoLogErrPix404.Add(ATxIdPix);
  End;

  fLock_Unlock('CONSULTA_RECEBIMENTO_PIX_' + ATxIdPix,
               False,
               False,
               False,
               '',
               False,
               'CONSULTA_RECEBIMENTO_PIX_' + ATxIdPix);
end;

class procedure TFuncoesPixMonitor.ResetaTxIdJaGravadoLogErrPix404;
begin
  If Assigned(FTxIdJaGravadoLogErrPix404) Then
    FreeAndNil(FTxIdJaGravadoLogErrPix404);

  FTxIdJaGravadoLogErrPix404 := TStringList.Create;
  FTxIdJaGravadoLogErrPix404.Duplicates := dupIgnore;
  FTxIdJaGravadoLogErrPix404.Sorted := True;
end;

{$IFNDEF LINUX}
Initialization
  TFuncoesPixMonitor.FHandlePixCitel := 0;
  TFuncoesPixMonitor.FPixCitel := Nil;
  TFuncoesPixMonitor.FTxIdJaGravadoLogErrPix404 := Nil;

Finalization
  If TFuncoesPixMonitor.FPixCitel <> Nil Then
    TFuncoesPixMonitor.FPixCitel := Nil;

  TFuncoesPix.LiberaLibIntegracaoPix(TFuncoesPixMonitor.FHandlePixCitel);

  If Assigned(TFuncoesPixMonitor.FTxIdJaGravadoLogErrPix404) Then
    FreeAndNil(TFuncoesPixMonitor.FTxIdJaGravadoLogErrPix404);
{$ELSE}
Initialization
  TFuncoesPixMonitor.FTxIdJaGravadoLogErrPix404 := Nil;

Finalization
  If Assigned(TFuncoesPixMonitor.FTxIdJaGravadoLogErrPix404) Then
    FreeAndNil(TFuncoesPixMonitor.FTxIdJaGravadoLogErrPix404);
{$ENDIF}

end.
