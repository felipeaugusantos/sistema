unit untTPixDao;

interface

Uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, untTypesSistema,
{$ELSE }
  UniClientDataSet,
{$ENDIF}
  untTiposPix, Uni, System.SysUtils, System.Classes, Data.DB, System.Variants;

Type
  TPixDao = class
  private
    function RetornaListaPedidosPix(AEmpresaPix,
                                    ATxIdPix: String): String;

    function RetornaListaDuplicatasPix(AEmpresaPix,
                                       ATxIdPix: String;
                                       var ADuplicatasAutoIncrem: TStringList): String;

    function RetornaCamposConsultaBase: String;

    procedure GravaValorCampoString(var ADataset: TUniQuery;
                                    ANomeCampo,
                                    AValorCampo: String);

    class procedure InserirRegistroCONPIX_EXE(AEmpresaFisica,
                                              ANomeMaquina,
                                              ANomeUsuario: String;
                                              AUltimaExecucao: TDateTime);

    function RegistroJaEstaNaMOVPIX(ADadosRetorno: TDadosRetornoPixConsulta;
                                    ACodigoEmpresa: String): Boolean;
  public
    function InserirCobrancaPixAVista(ADadosRetorno: TDadosRetornoPixAVista;
                                      ANomeFormulario: String): Boolean;

    function InserirCobrancaPixRecebida(var ADadosRetorno: TDadosRetornoPixConsulta;
                                        ANomeFormulario: String;
                                        ARegistroCaixa: Boolean;
                                        AOperador: String;
                                        AEmpresaCaixa: String = ''): Boolean;

    procedure ApagaPixAtivosExpirados(AListaAutoIncremAtivos: TStringList;
                                      ANomeFormulario: String;
                                      out APedidosExpirados: TStringList;
                                      out ADuplicatasExpiradas: TStringList;
                                      out ADuplicatasExpiradasAutoIncrem: TStringList);

    procedure AtualizaDadosRetornoConcluidoPix(ARegistroPix: TDadosRetornoPixConsulta;
                                               ASeqConBaixa: Integer;
                                               ANomeFormulario: String;
                                               APixNaTela: Boolean;
                                               AOperador: String = '');

    procedure AtualizaDadosRetornoDevolucaoPix(ARegistroDevolucaoPix: TDadosRetornoPixDevolucao;
                                               AAutoIncrem,
                                               ANomeFormulario: String;
                                               AOperador: String = '');

    function RetornaDataPixAtivoMaisAntigo: TDateTime;

    function RetornaListaDePixConsulta(AEmpresa: String; ATxId: string = '';
                                       AIgnorarPixTela: Boolean = False): TUniClientDataset;
    function RetornaListaDePixConsultaTemporaria(AEmpresa: String; ATxId: string = ''): TUniClientDataset;
    function RetornaListaDePixConsultaTemporariaPago(AEmpresa: String; ATxId: string = ''): TUniClientDataset;

    function RetornaStatusDoPixAtualizado(AAutoIncremMovPix: String): String;

    function VerificaSeOPixEstaAbertoNaTela(AAutoIncremMovPix: String): Boolean;

    function RetornaListaDeOperadoresMensagens: TUniClientDataset;

    function RetornaPortadorChavePix(AAutoIncremChavePix: String): String;

    function RetornaDatasetContasBancariasComCertificadosAVencerVencidos: TUniClientDataset;

    procedure VerificaPagamentoNoAmbienteDeTestes(var ARegistro: TDadosRetornoPixConsulta);

    class procedure CorrigeParaDataZulu(var ADadosRetorno: TDadosRetornoPixConsulta);

    class procedure ExcluirRegistroDoPix(AEmpresaDoPix,
                                         ATxIdPix,
                                         ANomeFormulario,
                                         ADescricao: String;
                                         AStatusPix: String = '';
                                         ARetornoStatus: String = '');

    class procedure LimparPixDosPedidos(AEmpresaDoPix,
                                        ATxIdPix: String);

    class procedure LimparPixDasDuplicatas(AEmpresaDoPix,
                                           ATxIdPix,
                                           ANomeFormulario: String);

    class function RetornaDadosPedidoPix(ATxId,
                                         ACodigoEmpresa: String): TUniClientDataSet;

    class function RetornaOperadorLancamentoPix(ATxId,
                                                ACodigoEmpresa: String): string;

    class function RetornaPortadorTransitorioLancamentoPix(ATxId,
                                                           ACodigoEmpresa: String): string;

    class function RetornaDadosDoPix(ATxId,
                                     ACodigoEmpresa: String): TUniClientDataSet; overload;

    class function RetornaDadosDoPix(AAutoIncremMovPix: String): TUniClientDataSet; overload;

    class function RetornaStatusSePedidoPossuirPix(AEmpresaPix,
                                                   ATxIdPix: String): String; overload;

    class function RetornaStatusSePedidoPossuirPix(ANumeroPedido,
                                                   AEspecie,
                                                   ACodigoEmpresa: String): String; overload;

    class function RetornaDadosPixParaGerarCCOperador(ACodigoOperador: String): TUniClientDataSet;

    class function PixGeradoEmPedidosDesmembrados(AEmpresaPix,
                                                  ATxIdPix: String): Boolean; overload;

    class function PixGeradoEmPedidosDesmembrados(AEmpresaPix,
                                                  ATxIdPix: String;
                                                  out AListaPedidos: String): Boolean; overload;

    class function PixGeradoParaVariasDuplicatas(AEmpresaPix,
                                                 ATxIdPix: String;
                                                 out AListaDuplicatas: String): Boolean;

    class function VerificaSePossuiChavePixSelecionada: Boolean;

    class function ExistemChavesPixCadastradas: Boolean;

    class function ExistemCobrancasPixAtivas: Boolean;

    class function ExistemDuplicatasComChavePixSemRegistro: Boolean;

    class procedure AdicionarRegistroNaTabelaPixTel(AAutoIncremMOVPIX: String);

    class procedure ApagarRegistroNaTabelaPixTel(AAutoIncremMovPix: String;
                                                 APixNaTela: Boolean);

    class function EmpresaCentralizadoraDasConsultasPix: String;

    class function ChavePixPossuiChavesDeAutorizacao(AAutoIncremChavePix: String): Boolean;

    class function PortadorPossuiChavesPixVinculadas(APortador: String): Boolean;

    class function RetornaChavePixDoPortador(APortador: String): String;

    class function RetornaBancoDaChavePix(AAutoIncremChavePix: String): String;

    class function RegistroDoPixAtivoEExpirado(AAutoincrem: String): Boolean;

    class function RetornaEmpresasComChavePixConfigurada(AAutoIncremChavePix: String): String;

    class function ChavePixUtilizaShipay(AAutoIncremChavePix: String): String;

    class function RetornaAutoIncremChavePixDoCaixa(ACodigoCaixa: String): String;

    class function EquipamentoJaExecutouOMonitorDeRecebimentosPix(ANomeMaquina,
                                                                  ANomeUsuario,
                                                                  AEmpresaFisica: String;
                                                                  ATempoExecucao: Integer): Boolean;

    class function PixExpiradoMaisDeUmDeterminadoPeriodo(APixAtivoMonitor: TDataset;
                                                         ATempoMinimoExpiracao: Integer;
                                                         ATabelaMonitoramento: Boolean): Boolean;
  end;

implementation

Uses untFuncoesSimples, untTLogMpx, untAdiantamentoCLiente, System.StrUtils,
     untLogCtr, System.DateUtils;

{ TPixDao }

class procedure TPixDao.AdicionarRegistroNaTabelaPixTel(AAutoIncremMOVPIX: String);
begin
  fStartTransaction;
  fExecutaSQL('REPLACE INTO PIXTEL (AUTOINCREM, MPX_ULTREQ) VALUES ' +
              '  ("' + AAutoIncremMOVPIX + '", CURRENT_TIMESTAMP)');
  fCommit;
end;

procedure TPixDao.ApagaPixAtivosExpirados(AListaAutoIncremAtivos: TStringList;
                                          ANomeFormulario: String;
                                          out APedidosExpirados: TStringList;
                                          out ADuplicatasExpiradas: TStringList;
                                          out ADuplicatasExpiradasAutoIncrem: TStringList);
  Var
    LConsulta,
    LAtualiza: TUniQuery;

    LPixNaTela: Boolean;

    LValidaDuplicatas: Boolean;
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
                          '  AND M.MPX_STATUS IN (' + STATUS_PIX_ATIVO_SQL + ') ' +
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

      TLogMpx.GravaLogMpx(LConsulta.FieldByName('AUTOINCREM').AsString,
                          'EXCLUSÃO PIX EXPIRADO',
                          ANomeFormulario);

      fVerificaIntegridade(ANomeFormulario, 'MOVPIX', LConsulta, True);

      LPixNaTela := Not fEmptyStr(fCampoTabela('IFNULL(AUTOINCREM, "")', 'PIXTEL', ['AUTOINCREM'], [LConsulta.FieldByName('AUTOINCREM').AsString]));
      ApagarRegistroNaTabelaPixTel(LConsulta.FieldByName('AUTOINCREM').AsString,
                                   LPixNaTela);

      LConsulta.Delete;
    End;
    fCommit;
  Finally
    FreeAndNil(LConsulta);
    FreeAndNil(LAtualiza);
  End;
end;

class procedure TPixDao.ApagarRegistroNaTabelaPixTel(AAutoIncremMovPix: String;
                                                     APixNaTela: Boolean);
  Var
    LExclui: TUniQuery;
begin
  If Not APixNaTela Then
    Exit;

  LExclui := Nil;
  Try
    LExclui := fCriaQuery;
    LExclui.SQL.Text := 'DELETE FROM PIXTEL WHERE AUTOINCREM="' + AAutoIncremMovPix + '"';
    LExclui.ExecSQL;
  Finally
    FreeAndNilDatasets(LExclui);
  End;
end;

procedure TPixDao.AtualizaDadosRetornoConcluidoPix(
  ARegistroPix: TDadosRetornoPixConsulta; ASeqConBaixa: Integer;
  ANomeFormulario: String; APixNaTela: Boolean; AOperador: String = '');
  Var
    LAtualiza: TUniQuery;
begin
  Try
    LAtualiza := fCriaQuery;
    Try
      LAtualiza.SQL.Text := 'UPDATE MOVPIX SET ' +
                            'MPX_STATUS=:STATUS, ' +
                            'MPX_SEQCON=:SEQCON, ' +
                            'MPX_DTAREC=:DTAREC, ' +
                            'MPX_HORREC=:HORREC, ' +
                            'MPX_DTABAI=:DTABAI, ' +
                            'MPX_VALREC=:VALREC, ' +
                            'MPX_PORBAI=:PORBAI, ' +
                            'MPX_CTABAI=:CTABAI, ' +
                            'MPX_DOCBAI=:DOCBAI, ' +
                            'MPX_END_ID=:END_ID, ' +
                            'MPX_INFPAG=:INFPAG, ' +
                            'MPX_NOMPAG=:NOMPAG, ' +
                            'MPX_DOCPAG=:DOCPAG, ' +
                            'MPX_ARRPAG=:ARRPAG, ' +
                            'MPX_OPEBAI=:OPEBAI, ' +
                            'MPX_RESCAI=:RESCAI, ' +
                            'MPX_DTATRA=:DTATRA, ' +
                            'MPX_SEQTRF=:SEQTRF, ' +
                            'MPX_F11ORI=:F11ORI ' +
                            'WHERE AUTOINCREM=:AUTOINC';

      CorrigeParaDataZulu(ARegistroPix);

      LAtualiza.ParamByName('STATUS').AsString := ARegistroPix.Status;
      LAtualiza.ParamByName('SEQCON').AsInteger := ASeqConBaixa;
      LAtualiza.ParamByName('DTAREC').AsDateTime := ARegistroPix.DataPagamento;
      LAtualiza.ParamByName('HORREC').AsDateTime := ARegistroPix.DataPagamento;
      LAtualiza.ParamByName('DTABAI').AsDateTime := fRetDataServidor;
      LAtualiza.ParamByName('VALREC').AsFloat := ARegistroPix.ValorPago;
      LAtualiza.ParamByName('PORBAI').AsString := ARegistroPix.CodigoPortador;

      LAtualiza.ParamByName('CTABAI').AsString := ARegistroPix.PlanoDeContas;
      If LAtualiza.ParamByName('CTABAI').AsString.IsEmpty Then
      Begin
        LAtualiza.ParamByName('CTABAI').AsString := fCfgSis('CTAPIX', varString, ARegistroPix.CodigoEmpresa);
        If LAtualiza.ParamByName('CTABAI').AsString.IsEmpty Then
          LAtualiza.ParamByName('CTABAI').AsString := fCfgSis('CTAAVI', varString, ARegistroPix.CodigoEmpresa);
      End;

      LAtualiza.ParamByName('DOCBAI').Clear;
      If Not ARegistroPix.MovbanBaixa.IsEmpty Then
        LAtualiza.ParamByName('DOCBAI').AsString := ARegistroPix.MovbanBaixa;

      LAtualiza.ParamByName('END_ID').AsString := ARegistroPix.EndToEndId;
      LAtualiza.ParamByName('INFPAG').AsString := ARegistroPix.InformacaoPagador;
      LAtualiza.ParamByName('NOMPAG').AsString := ARegistroPix.NomePagador;
      LAtualiza.ParamByName('DOCPAG').AsString := ARegistroPix.CPFCNPJPagador;

      If Not ARegistroPix.NomeDevedor.IsEmpty Then
      Begin
        If (ARegistroPix.NomePagador.IsEmpty) Then
        Begin
          LAtualiza.ParamByName('NOMPAG').AsString := ARegistroPix.NomeDevedor;
          LAtualiza.ParamByName('DOCPAG').AsString := ARegistroPix.CPFCNPJDevedor;
        End;
      End;

      LAtualiza.ParamByName('ARRPAG').AsString := ARegistroPix.JsonChavePix;

      LAtualiza.ParamByName('RESCAI').AsInteger := 0;
      LAtualiza.ParamByName('SEQTRF').Clear;
      LAtualiza.ParamByName('DTATRA').Clear;
      If ARegistroPix.SeqConTransferencia > 0 Then
      Begin
        LAtualiza.ParamByName('RESCAI').AsInteger := 1;
        LAtualiza.ParamByName('DTATRA').AsDateTime := VS_Date;
        LAtualiza.ParamByName('SEQTRF').AsInteger := ARegistroPix.SeqConTransferencia;
      End;

      LAtualiza.ParamByName('OPEBAI').AsString := strLoginUsuarioLogado;
      If Not AOperador.IsEmpty Then
        LAtualiza.ParamByName('OPEBAI').AsString := AOperador;

      LAtualiza.ParamByName('F11ORI').AsString := 'N';
      If Not ARegistroPix.RecebidoPeloF11.IsEmpty Then
        LAtualiza.ParamByName('F11ORI').AsString := ARegistroPix.RecebidoPeloF11;

      LAtualiza.ParamByName('AUTOINC').AsString := ARegistroPix.AutoIncremMovPix;

      LAtualiza.ExecSQL;

      TLogMpx.GravaLogMpx(ARegistroPix.AutoIncremMovPix,
                          'BAIXA PIX',
                          ANomeFormulario);

      ApagarRegistroNaTabelaPixTel(ARegistroPix.AutoIncremMovPix,
                                   APixNaTela);
    Except
      On E: Exception Do
        Raise Exception.Create('Ocorreu um erro ao baixar o Pix.' + #13 +
                               'Erro gerado: ' + E.Message);
    End;
  Finally
    FreeAndNil(LAtualiza);
  End;
end;

procedure TPixDao.AtualizaDadosRetornoDevolucaoPix(
  ARegistroDevolucaoPix: TDadosRetornoPixDevolucao; AAutoIncrem, ANomeFormulario,
  AOperador: String);
  Var
    LAtualiza: TUniQuery;
begin
  Try
    LAtualiza := fCriaQuery;
    Try
      LAtualiza.SQL.Text := 'UPDATE MOVPIX SET ' +
                            'MPX_PIXDEV="S",     ' +
                            'MPX_STATUS=:STATUS, ' +
                            'MPX_DTADEV=:DTADEV, ' +
                            'MPX_HORDEV=:HORDEV, ' +
                            'MPX_JSODEV=:JSODEV, ' +
                            'MPX_VALDEV=:VALDEV, ' +
                            'MPX_DEV_ID=:DEV_ID, ' +
                            'MPX_RTR_ID=:RTR_ID, ' +
                            'MPX_MOTDEV=:MOTDEV, ' +
                            'MPX_OPEDEV=:OPEDEV  ' +
                            'WHERE AUTOINCREM=:AUTOINC';

      LAtualiza.ParamByName('STATUS').AsString := ARegistroDevolucaoPix.Status;
      LAtualiza.ParamByName('DTADEV').AsDateTime := ARegistroDevolucaoPix.DataDevolucao;
      LAtualiza.ParamByName('HORDEV').AsDateTime := ARegistroDevolucaoPix.DataDevolucao;
      LAtualiza.ParamByName('JSODEV').AsString := ARegistroDevolucaoPix.JsonRetorno;
      LAtualiza.ParamByName('VALDEV').AsFloat := ARegistroDevolucaoPix.Valor;
      LAtualiza.ParamByName('DEV_ID').AsString := ARegistroDevolucaoPix.Id;
      LAtualiza.ParamByName('RTR_ID').AsString := ARegistroDevolucaoPix.rtrId;
      LAtualiza.ParamByName('MOTDEV').AsString := ARegistroDevolucaoPix.Motivo;

      LAtualiza.ParamByName('OPEDEV').AsString := strLoginUsuarioLogado;
      If Not AOperador.IsEmpty Then
        LAtualiza.ParamByName('OPEDEV').AsString := AOperador;

      LAtualiza.ParamByName('AUTOINC').AsString := AAutoIncrem;

      LAtualiza.ExecSQL;

      TLogMpx.GravaLogMpx(AAutoIncrem,
                          'DEVOLUCAO PIX',
                          ANomeFormulario);
    Except
      On E: Exception Do
        Raise Exception.Create('Ocorreu um erro ao devolver o Pix.' + #13 +
                               'Erro gerado: ' + E.Message);
    End;
  Finally
    FreeAndNil(LAtualiza);
  End;
end;

class function TPixDao.ChavePixPossuiChavesDeAutorizacao(
  AAutoIncremChavePix: String): Boolean;
  Var
    LConsulta: TUniQuery;

    LProducao: String;

    LValidaCertificado,
    LValidaAPPBB,
    LValidaClientIdSecret,
    LValidaBasic: Boolean;
begin
  Try
    Result := True;

    LConsulta := fCriaQuery;

    LConsulta.SQL.Text := 'SELECT C.CCA_AUTPIX, C.CCA_APPPIX, C.CCA_CODBCO, ' +
                          '       C.CCA_CLI_ID, C.CCA_CLISEC, ' +
                          '       IFNULL(IF(C.CCA_CODBCO = "033", NULL, C.CCA_ARQCRT), C.CCA_ARQPFX) AS CERTIFICADO, ' +
                          '       C.CCA_USASHP ' +
                          'FROM CCAPIX P ' +
                          'JOIN CADCCA C ON C.AUTOINCREM=P.PIX_SEQCCA ' +
                          'WHERE P.AUTOINCREM="' + AAutoIncremChavePix + '"';
    LConsulta.Open;

    LProducao := IIF(fCfgSis('HOMPIX', varBoolean), 'N', 'S');

    LValidaCertificado := Not MatchStr(LConsulta.FieldByName('CCA_CODBCO').AsString, ['001']);
    LValidaAPPBB := MatchStr(LConsulta.FieldByName('CCA_CODBCO').AsString, ['001']);
    LValidaClientIdSecret := MatchStr(LConsulta.FieldByName('CCA_CODBCO').AsString, ['341', '756']);
    LValidaBasic := MatchStr(LConsulta.FieldByName('CCA_CODBCO').AsString, ['237', '748', '001', '033']);

    If LConsulta.FieldByName('CCA_USASHP').AsString = 'S' Then
    Begin
      LValidaCertificado := False;
      LValidaAPPBB := True;
      LValidaClientIdSecret := True;
      LValidaBasic := False;
    End;

    If LValidaAPPBB Then
      Result := Not LConsulta.FieldByName('CCA_APPPIX').AsString.IsEmpty;

    If Not Result Then
      Exit;

    If LValidaClientIdSecret Then
    Begin
      Result := Not LConsulta.FieldByName('CCA_CLI_ID').AsString.IsEmpty;
      If Result Then
        Result := Not LConsulta.FieldByName('CCA_CLISEC').AsString.IsEmpty;
    End;

    If Not Result Then
      Exit;

    If LValidaCertificado Then
    Begin
      If Not MatchStr(Concat(LConsulta.FieldByName('CCA_CODBCO').AsString, LProducao), ['033N']) Then
        Result := Not LConsulta.FieldByName('CERTIFICADO').AsString.IsEmpty;
    End;

    If Not Result Then
      Exit;

    If LValidaBasic Then
      Result := Not LConsulta.FieldByName('CCA_AUTPIX').AsString.IsEmpty;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

class function TPixDao.ChavePixUtilizaShipay(
  AAutoIncremChavePix: String): String;
  Var
    LConsulta: TUniQuery;
begin
  Try
    LConsulta := fCriaQuery;

    LConsulta.SQL.Text := 'SELECT C.* ' +
                          'FROM CCAPIX P ' +
                          'JOIN CADCCA C ON C.AUTOINCREM=P.PIX_SEQCCA ' +
                          'WHERE P.AUTOINCREM="' + AAutoIncremChavePix + '"';
    LConsulta.Open;

    Result := 'N';
    If LConsulta.FindField('CCA_USASHP') <> Nil Then
      Result := LConsulta.FieldByName('CCA_USASHP').AsString;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

class procedure TPixDao.CorrigeParaDataZulu(
  var ADadosRetorno: TDadosRetornoPixConsulta);
  Var
    LCodigoBanco: String;
begin
  If ADadosRetorno.UtilizaShipay  = 'S' Then
  Begin
    ADadosRetorno.DataCriacao := IncHour(ADadosRetorno.DataCriacao, -PegaTimeZoneServidor);

    If Not ADadosRetorno.DataPagamentoString.IsEmpty Then
      ADadosRetorno.DataPagamento := IncHour(ADadosRetorno.DataPagamento, -PegaTimeZoneServidor);

    Exit;
  End;

  LCodigoBanco := RetornaBancoDaChavePix(ADadosRetorno.AutoIncremChavePix);

  If MatchStr(LCodigoBanco, ['001', '341']) Then
    Exit;

  If MatchStr(LCodigoBanco, ['237', '748', '756']) Then
  Begin
    If RightStr(ADadosRetorno.DataCriacaoString, 1) = 'Z' Then
      ADadosRetorno.DataCriacao := IncHour(ADadosRetorno.DataCriacao, -PegaTimeZoneServidor);

    ADadosRetorno.DataCriacaoString := ADadosRetorno.DataCriacaoString.Replace('Z', EmptyStr);
  End;

  If ADadosRetorno.DataPagamentoString.IsEmpty Then
    Exit;

  If MatchStr(LCodigoBanco, ['237', '748', '756', '033']) Then
  Begin
    If RightStr(ADadosRetorno.DataPagamentoString, 1) = 'Z' Then
      ADadosRetorno.DataPagamento := IncHour(ADadosRetorno.DataPagamento, -PegaTimeZoneServidor);

    ADadosRetorno.DataPagamentoString := ADadosRetorno.DataPagamentoString.Replace('Z', EmptyStr);
  End;
end;

class function TPixDao.EmpresaCentralizadoraDasConsultasPix: String;
  Var
    LConsulta: TUniQuery;
begin
  Try
    LConsulta := fCriaQuery;

    LConsulta.SQL.Text := 'SELECT EMP_CODEMP FROM CADEMP WHERE EMP_CONPIX="S"';
    LConsulta.Open;

    Result := LConsulta.FieldByName('EMP_CODEMP').AsString;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

class function TPixDao.EquipamentoJaExecutouOMonitorDeRecebimentosPix(
  ANomeMaquina, ANomeUsuario, AEmpresaFisica: String;
  ATempoExecucao: Integer): Boolean;
  Var
    LDataHora: TDateTime;

    LConsulta: TUniQuery;
begin
  Try
    LDataHora := fCampoTabela('CURRENT_TIMESTAMP', '', [], []);

    LConsulta := fCriaQuery;
    Try
      LConsulta.SQL.Text := 'SELECT * FROM CONPIX_EXE ' +
                            'WHERE EXE_EMPFIS=:EMPFIS ' +
                            '  AND EXE_NOMMAQ=:NOMMAQ ' +
                            '  AND EXE_NOMUSU=:NOMUSU ';

      LConsulta.ParamByName('EMPFIS').AsString := AEmpresaFisica;
      LConsulta.ParamByName('NOMMAQ').AsString := ANomeMaquina;
      LConsulta.ParamByName('NOMUSU').AsString := ANomeUsuario;

      LConsulta.Open;

      Result := Not LConsulta.IsEmpty;

      If Result Then
      Begin
        Result := IncMilliSecond(LConsulta.FieldByName('EXE_ULTEXE').AsDateTime, ATempoExecucao - 15000) > LDataHora;

        If Result Then
          Exit;
      End;

      fStartTransaction;

      If Not LConsulta.IsEmpty Then
        LConsulta.Delete;

      InserirRegistroCONPIX_EXE(AEmpresaFisica,
                                ANomeMaquina,
                                ANomeUsuario,
                                LDataHora);
      fCommit;
    Finally
      FreeAndNil(LConsulta);
    End;
  Except
    Raise;  //não deve parar a rotina
  End;
end;

class procedure TPixDao.ExcluirRegistroDoPix(AEmpresaDoPix, ATxIdPix, ANomeFormulario, ADescricao: String;
 AStatusPix: String = ''; ARetornoStatus: String = '');
  Var
    LConsulta: TUniQuery;

    LPixNaTela: Boolean;
begin
  Try
    If ATxIdPix.IsEmpty Then
      Exit;

    LConsulta := fCriaQuery;

    LConsulta.SQL.Text := 'SELECT * FROM MOVPIX WHERE ' +
                          '  MPX_CODEMP=:CODEMP AND ' +
                          '  MPX_TX_ID_=:TX_ID_ ';

    LConsulta.ParambyName('CODEMP').AsString := AEmpresaDoPix;
    LConsulta.ParambyName('TX_ID_').AsString := ATxIdPix;

    LConsulta.Open;

    If Not ARetornoStatus.IsEmpty Then
    Begin
      LConsulta.Edit;
      LConsulta.FieldByName('MPX_STATUS').AsString := AStatusPix;
      LConsulta.FieldByName('MPX_JSOREC').AsString := ARetornoStatus;
      LConsulta.Post;
    End;

    TLogMpx.GravaLogMpx(LConsulta.FieldByName('AUTOINCREM').AsString,
                        ADescricao,
                        ANomeFormulario);

    fVerificaIntegridade(ANomeFormulario, 'MOVPIX', LConsulta, True);

    LPixNaTela := Not fEmptyStr(fCampoTabela('IFNULL(AUTOINCREM, "")', 'PIXTEL', ['AUTOINCREM'], [LConsulta.FieldByName('AUTOINCREM').AsString]));

    ApagarRegistroNaTabelaPixTel(LConsulta.FieldByName('AUTOINCREM').AsString,
                                 LPixNaTela);

    LConsulta.Delete;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

class function TPixDao.ExistemChavesPixCadastradas: Boolean;
  Var
    LConsulta: TUniQuery;
begin
  Try
    LConsulta := fCriaQuery;

    LConsulta.SQL.Text := 'SELECT IFNULL(COUNT(AUTOINCREM), 0) AS TOTAL FROM CCAPIX';
    LConsulta.Open;

    Result := Not LConsulta.IsEmpty;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

class function TPixDao.ExistemCobrancasPixAtivas: Boolean;
  Var
    LConsulta: TUniQuery;

    LEmpresa: String;
begin
    LEmpresa := EmpresaCentralizadoraDasConsultasPix;
    If LEmpresa.IsEmpty Then
      LEmpresa := ' AND MPX_EMPFIS="' + fRetEmpresaFisica + '" '
    Else
      LEmpresa := '';

  Try
    LConsulta := fCriaQuery;

    LConsulta.SQL.Text := 'SELECT AUTOINCREM ' +
                          'FROM MOVPIX ' +
                          'WHERE MPX_STATUS IN (' + STATUS_PIX_ATIVO_SQL + ') ' +
                          LEmpresa;
    LConsulta.Open;

    Result := Not LConsulta.IsEmpty;

  Finally
    FreeAndNil(LConsulta);
  End;
end;

class function TPixDao.ExistemDuplicatasComChavePixSemRegistro: Boolean;
  Var
    LConsulta: TUniQuery;

    LEmpresa: String;
begin
    LEmpresa := EmpresaCentralizadoraDasConsultasPix;
    If LEmpresa.IsEmpty Then
      LEmpresa := ' AND CTR_EMPPIX="' + fRetEmpresaFisica + '" '
    Else
      LEmpresa := '';

  Try
    LConsulta := fCriaQuery;

    LConsulta.SQL.Text := 'SELECT AUTOINCREM ' +
                          'FROM CADREC ' +
                          'WHERE (CTR_EMPPIX IS NOT NULL AND CTR_TX_PIX IS NOT NULL) ' +
                          '  AND CTR_DTAREC IS NULL ' +
                          LEmpresa +
                          '  AND (SELECT IFNULL(COUNT(AUTOINCREM), 0) ' +
                          '       FROM MOVPIX ' +
                          '       WHERE MPX_CODEMP = CTR_EMPPIX ' +
                          '         AND MPX_TX_ID_ = CTR_TX_PIX) = 0 ';
    LConsulta.Open;

    Result := Not LConsulta.IsEmpty;

  Finally
    FreeAndNil(LConsulta);
  End;
end;

procedure TPixDao.GravaValorCampoString(var ADataset: TUniQuery; ANomeCampo,
  AValorCampo: String);
begin
  If ADataset.FindField(ANomeCampo) = Nil Then
    Exit;

  ADataset.FieldByName(ANomeCampo).Value := Null;
  If Not AValorCampo.IsEmpty Then
    ADataset.FieldByName(ANomeCampo).AsString := AValorCampo;
end;

function TPixDao.InserirCobrancaPixAVista(
  ADadosRetorno: TDadosRetornoPixAVista; ANomeFormulario: String): Boolean;
  Var
    LDatasetInserir: TUniQuery;

    LAutoIncrem: String;
begin
  Try
    LDatasetInserir := fCriarQuery('SELECT * FROM MOVPIX WHERE FALSE');
    LDatasetInserir.Open;

    LAutoIncrem := ADadosRetorno.AutoIncremMovPix;
    If LAutoIncrem.IsEmpty Then
      LAutoIncrem := fRetAutoIncrem('MOVPIX', VS_strCodEmp);

    LDatasetInserir.Insert;
    LDatasetInserir.FieldByName('AUTOINCREM').AsString := LAutoIncrem;
    LDatasetInserir.FieldByName('MPX_DTACAD').AsDateTime := fRetDataServidor;
    LDatasetInserir.FieldByName('MPX_HORCAD').AsDateTime := fRetHoraServidor;
    LDatasetInserir.FieldByName('MPX_DTAHOR').AsDateTime := LDatasetInserir.FieldByName('MPX_DTACAD').AsDateTime +
                                                            LDatasetInserir.FieldByName('MPX_HORCAD').AsDateTime;
    LDatasetInserir.FieldByName('MPX_EXPIRA').AsString := ADadosRetorno.Expiracao;
    LDatasetInserir.FieldByName('MPX_CODEMP').AsString := VS_strCodEmp;
    LDatasetInserir.FieldByName('MPX_EMPFIS').AsString := fRetEmpresaFisica;
    LDatasetInserir.FieldByName('MPX_STATUS').AsString := ADadosRetorno.Status;
    LDatasetInserir.FieldByName('MPX_TX_ID_').AsString := ADadosRetorno.TxId;
    LDatasetInserir.FieldByName('MPX_LOCALI').AsString := ADadosRetorno.LinkQrCode;
    LDatasetInserir.FieldByName('MPX_QRCODE').AsString := ADadosRetorno.TextoQrCode;
    LDatasetInserir.FieldByName('MPX_REVISA').AsString := ADadosRetorno.Revisao;
    LDatasetInserir.FieldByName('MPX_VALPIX').AsFloat := fFormataFloat(ADadosRetorno.Valor, 2);

    LDatasetInserir.FieldByName('MPX_CHAPIX').AsString := ADadosRetorno.ChavePix;
    If ADadosRetorno.ChavePix.IsEmpty Then
      LDatasetInserir.FieldByName('MPX_CHAPIX').AsString := fCampoTabela('PIX_CHAVE_', 'CCAPIX', ['AUTOINCREM'], [ADadosRetorno.AutoIncremChavePix]);

    LDatasetInserir.FieldByName('MPX_SEQPIX').AsString := ADadosRetorno.AutoIncremChavePix;
    LDatasetInserir.FieldByName('MPX_JSOREC').AsString := ADadosRetorno.JsonRetorno;
    LDatasetInserir.FieldByName('MPX_JSOENV').AsString := ADadosRetorno.JsonRequisicao
                                                                       .Replace('"pix_dict_key": ""', '"pix_dict_key": "' + LDatasetInserir.FieldByName('MPX_CHAPIX').AsString + '"');
    LDatasetInserir.FieldByName('MPX_CODOPE').AsString := strLoginUsuarioLogado;
    LDatasetInserir.FieldByName('MPX_CRIADO').AsString := ADadosRetorno.CriadoPelo;

    If Not ADadosRetorno.SolicitacaoPagador.IsEmpty Then
      LDatasetInserir.FieldByName('MPX_SOLPAG').AsString := ADadosRetorno.SolicitacaoPagador;

    If Not ADadosRetorno.NomeDevedor.IsEmpty Then
    Begin
      LDatasetInserir.FieldByName('MPX_NOMDEV').AsString := ADadosRetorno.NomeDevedor;
      LDatasetInserir.FieldByName('MPX_DOCDEV').AsString := ADadosRetorno.CPFCNPJDevedor;
    End;

    If Not ADadosRetorno.InformacoesAdicionais.IsEmpty Then
      LDatasetInserir.FieldByName('MPX_INFADC').AsString := ADadosRetorno.InformacoesAdicionais;

    If Not ADadosRetorno.OrderRef.IsEmpty Then
      LDatasetInserir.FieldByName('MPX_ORDREF').AsString := ADadosRetorno.OrderRef;

    If ADadosRetorno.UtilizaShipay = 'S' Then
    Begin
      LDatasetInserir.FieldByName('MPX_USASHP').AsString := 'S';

      LDatasetInserir.FieldByName('MPX_JSOENV').AsString := ADadosRetorno.JsonRequisicao.Replace('[ORDREF]', ADadosRetorno.OrderRef);
    End;

    LDatasetInserir.FieldByName('MPX_LNKCIT').AsString := ADadosRetorno.LinkCitel;

    GravaValorCampoString(LDatasetInserir, 'MPX_CHA_CC', ADadosRetorno.ChaveParaCreditoCliente);

    LDatasetInserir.Post;

    FreeAndNil(LDatasetInserir);

    TLogMpx.GravaLogMpx(LAutoIncrem,
                        'INCLUSÃO PIX A VISTA',
                        ANomeFormulario);

    Result := True;
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao inserir um novo Pix a vista.' + #13 +
                             'Erro gerado: ' + E.Message);
  End;
end;

function TPixDao.InserirCobrancaPixRecebida(
  var ADadosRetorno: TDadosRetornoPixConsulta; ANomeFormulario: String;
  ARegistroCaixa: Boolean; AOperador: String; AEmpresaCaixa: String = ''): Boolean;
  Var
    LDatasetInserir: TUniQuery;

    LEmpresaCaixa,
    LAutoIncrem: String;
begin
  Try
    ADadosRetorno.CodigoPortador := RetornaPortadorChavePix(ADadosRetorno.AutoIncremChavePix);

    LEmpresaCaixa := VS_strCodEmp;
    If Not AEmpresaCaixa.IsEmpty Then
      LEmpresaCaixa := AEmpresaCaixa;

    If RegistroJaEstaNaMOVPIX(ADadosRetorno, LEmpresaCaixa) Then
      Exit(False);

    LDatasetInserir := fCriarQuery('SELECT * FROM MOVPIX WHERE FALSE');
    LDatasetInserir.Open;

    LAutoIncrem := ADadosRetorno.AutoIncremMovPix;
    If LAutoIncrem.IsEmpty Then
      LAutoIncrem := fRetAutoIncrem('MOVPIX', LEmpresaCaixa);

    CorrigeParaDataZulu(ADadosRetorno);

    LDatasetInserir.Insert;
    LDatasetInserir.FieldByName('AUTOINCREM').AsString := LAutoIncrem;
    LDatasetInserir.FieldByName('MPX_DTACAD').AsDateTime := ADadosRetorno.DataCriacao;
    LDatasetInserir.FieldByName('MPX_HORCAD').AsDateTime := ADadosRetorno.DataCriacao;
    LDatasetInserir.FieldByName('MPX_DTAHOR').AsDateTime := LDatasetInserir.FieldByName('MPX_DTACAD').AsDateTime +
                                                            LDatasetInserir.FieldByName('MPX_HORCAD').AsDateTime;
    LDatasetInserir.FieldByName('MPX_EXPIRA').AsString := ADadosRetorno.Expiracao;
    LDatasetInserir.FieldByName('MPX_CODEMP').AsString := LEmpresaCaixa;
    LDatasetInserir.FieldByName('MPX_EMPFIS').AsString := fRetEmpresaFisica;
    LDatasetInserir.FieldByName('MPX_STATUS').AsString := ADadosRetorno.Status;
    LDatasetInserir.FieldByName('MPX_TX_ID_').AsString := ADadosRetorno.TxId;
    LDatasetInserir.FieldByName('MPX_LOCALI').AsString := ADadosRetorno.LinkQrCode;
    LDatasetInserir.FieldByName('MPX_QRCODE').AsString := ADadosRetorno.TextoQrCode;
    LDatasetInserir.FieldByName('MPX_REVISA').AsString := ADadosRetorno.Revisao;
    LDatasetInserir.FieldByName('MPX_VALPIX').AsFloat := fFormataFloat(ADadosRetorno.Valor, 2);

    LDatasetInserir.FieldByName('MPX_CHAPIX').AsString := ADadosRetorno.ChavePix;
    If ADadosRetorno.ChavePix.IsEmpty Then
      LDatasetInserir.FieldByName('MPX_CHAPIX').AsString := fCampoTabela('PIX_CHAVE_', 'CCAPIX', ['AUTOINCREM'], [ADadosRetorno.AutoIncremChavePix]);

    LDatasetInserir.FieldByName('MPX_SEQPIX').AsString := ADadosRetorno.AutoIncremChavePix;
    LDatasetInserir.FieldByName('MPX_JSOREC').AsString := ADadosRetorno.JsonRetorno;
    LDatasetInserir.FieldByName('MPX_JSOENV').AsString := ADadosRetorno.JsonRequisicao
                                                                       .Replace('"pix_dict_key": ""', '"pix_dict_key": "' + LDatasetInserir.FieldByName('MPX_CHAPIX').AsString + '"');

    LDatasetInserir.FieldByName('MPX_CODOPE').AsString := strLoginUsuarioLogado;
    If Not ADadosRetorno.CodigoOperadorRobo.IsEmpty Then
      LDatasetInserir.FieldByName('MPX_CODOPE').AsString := ADadosRetorno.CodigoOperadorRobo;

    If Not ADadosRetorno.SolicitacaoPagador.IsEmpty Then
      LDatasetInserir.FieldByName('MPX_SOLPAG').AsString := ADadosRetorno.SolicitacaoPagador;

    If Not ADadosRetorno.InformacoesAdicionais.IsEmpty Then
      LDatasetInserir.FieldByName('MPX_INFADC').AsString := ADadosRetorno.InformacoesAdicionais;

    LDatasetInserir.FieldByName('MPX_RESCAI').AsInteger := 0;
    If ARegistroCaixa Then
      LDatasetInserir.FieldByName('MPX_RESCAI').AsInteger := 1;

    LDatasetInserir.FieldByName('MPX_SEQCON').AsInteger := ADadosRetorno.SeqConRecebimento;
    LDatasetInserir.FieldByName('MPX_DTAREC').AsDateTime := ADadosRetorno.DataPagamento;
    LDatasetInserir.FieldByName('MPX_HORREC').AsDateTime := ADadosRetorno.DataPagamento;
    LDatasetInserir.FieldByName('MPX_DTABAI').AsDateTime := fRetDataServidor;
    LDatasetInserir.FieldByName('MPX_VALREC').AsFloat := ADadosRetorno.ValorPago;
    LDatasetInserir.FieldByName('MPX_PORBAI').AsString := RetornaPortadorChavePix(ADadosRetorno.AutoIncremChavePix);
    LDatasetInserir.FieldByName('MPX_CTABAI').AsString := ADadosRetorno.PlanoDeContas;

    LDatasetInserir.FieldByName('MPX_END_ID').AsString := ADadosRetorno.EndToEndId;
    LDatasetInserir.FieldByName('MPX_INFPAG').AsString := ADadosRetorno.InformacaoPagador;
    LDatasetInserir.FieldByName('MPX_NOMPAG').AsString := ADadosRetorno.NomePagador;
    LDatasetInserir.FieldByName('MPX_DOCPAG').AsString := ADadosRetorno.CPFCNPJPagador;

    If Not ADadosRetorno.NomeDevedor.IsEmpty Then
    Begin
      LDatasetInserir.FieldByName('MPX_NOMDEV').AsString := ADadosRetorno.NomeDevedor;
      LDatasetInserir.FieldByName('MPX_DOCDEV').AsString := ADadosRetorno.CPFCNPJDevedor;

      If (ADadosRetorno.NomePagador.IsEmpty) Then
      Begin
        LDatasetInserir.FieldByName('MPX_NOMPAG').AsString := ADadosRetorno.NomeDevedor;
        LDatasetInserir.FieldByName('MPX_DOCPAG').AsString := ADadosRetorno.CPFCNPJDevedor;
      End;
    End;

    LDatasetInserir.FieldByName('MPX_ARRPAG').AsString := ADadosRetorno.JsonChavePix;
    LDatasetInserir.FieldByName('MPX_F11ORI').AsString := ADadosRetorno.RecebidoPeloF11;
    LDatasetInserir.FieldByName('MPX_CRIADO').AsString := ADadosRetorno.CriadoPelo;

    LDatasetInserir.FieldByName('MPX_OPEBAI').AsString := strLoginUsuarioLogado;
    If Not AOperador.IsEmpty Then
      LDatasetInserir.FieldByName('MPX_OPEBAI').AsString := AOperador;

    If ARegistroCaixa Then
    Begin
      LDatasetInserir.FieldByName('MPX_DTATRA').AsDateTime := VS_Date;
      LDatasetInserir.FieldByName('MPX_SEQTRF').AsInteger := ADadosRetorno.SeqConTransferencia;
    End;

    If Not ADadosRetorno.OrderRef.IsEmpty Then
      LDatasetInserir.FieldByName('MPX_ORDREF').AsString := ADadosRetorno.OrderRef;

    If ADadosRetorno.UtilizaShipay = 'S' Then
    Begin
      LDatasetInserir.FieldByName('MPX_USASHP').AsString := 'S';

      LDatasetInserir.FieldByName('MPX_JSOENV').AsString := ADadosRetorno.JsonRequisicao.Replace('[ORDREF]', ADadosRetorno.OrderRef);
    End;

    LDatasetInserir.FieldByName('MPX_LNKCIT').AsString := ADadosRetorno.LinkCitel;

    ADadosRetorno.AutoIncremMovPix := LAutoIncrem;

    LDatasetInserir.Post;

    FreeAndNil(LDatasetInserir);

    TLogMpx.GravaLogMpx(LAutoIncrem,
                        'INCLUSÃO PIX A VISTA RECEBIDO',
                        ANomeFormulario,
                        AOperador);

    Result := True;
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao inserir um novo Pix a vista recebido.' + #13 +
                             'Erro gerado: ' + E.Message);
  End;
end;

class procedure TPixDao.InserirRegistroCONPIX_EXE(AEmpresaFisica, ANomeMaquina,
  ANomeUsuario: String; AUltimaExecucao: TDateTime);
  Var
    LInserir: TUniQuery;
begin
  Try
    LInserir := fCriaQuery;
    LInserir.SQL.Text := 'REPLACE INTO CONPIX_EXE ( ' +
                         '   EXE_EMPFIS, EXE_NOMMAQ, EXE_NOMUSU, EXE_ULTEXE) VALUES (' +
                         '   :EMPFIS, :NOMMAQ, :NOMUSU, :ULTEXE)';

    LInserir.ParamByName('EMPFIS').AsString := AEmpresaFisica;
    LInserir.ParamByName('NOMMAQ').AsString := ANomeMaquina;
    LInserir.ParamByName('NOMUSU').AsString := ANomeUsuario;
    LInserir.ParamByName('ULTEXE').AsDateTime := AUltimaExecucao;
    LInserir.ExecSQL;

    FreeAndNil(LInserir);
  Except
    Raise;   //não deve parar a rotina
  End;
end;

class procedure TPixDao.LimparPixDasDuplicatas(AEmpresaDoPix,
                                               ATxIdPix,
                                               ANomeFormulario: String);
  Var
    LConsulta,
    LLimparPix: TUniQuery;
begin
  Try
    LConsulta := fCriaQuery;

    LConsulta.SQL.Text := 'SELECT AUTOINCREM FROM CADREC ' +
                          'WHERE CTR_EMPPIX=:EMPPIX ' +
                          '  AND CTR_TX_PIX=:TX_PIX ';

    LConsulta.ParamByName('EMPPIX').AsString := AEmpresaDoPix;
    LConsulta.ParamByName('TX_PIX').AsString := ATxIdPix;
    LConsulta.Open;

    LLimparPix := fCriaQuery;

    If LConsulta.IsEmpty Then
      Exit;

    LLimparPix.SQL.Text := 'UPDATE CADREC            ' +
                           '   SET CTR_EMPPIX=NULL,  ' +
                           '       CTR_TX_PIX=NULL,  ' +
                           '       CTR_PIXTIP=NULL,  ' +
                           '       CTR_PIXREC=NULL,  ' +
                           '       CTR_PIXJUR=NULL,  ' +
                           '       CTR_PIXDES=NULL,  ' +
                           '       CTR_PIXCOB=NULL,  ' +
                           '       CTR_PIXCOR=NULL   ' +
                           'WHERE CTR_EMPPIX=:EMPPIX ' +
                           '  AND CTR_TX_PIX=:TX_PIX ';

    LLimparPix.ParamByName('EMPPIX').AsString := AEmpresaDoPix;
    LLimparPix.ParamByName('TX_PIX').AsString := ATxIdPix;

    LLimparPix.ExecSQL;

    While Not LConsulta.Eof Do
    Begin
      untLogCtr.GravaLogCtr(LConsulta.FieldByName('AUTOINCREM').AsString,
                            'EXCLUSÃO PIX DUPLICATA',
                            ANomeFormulario);

      LConsulta.Next;
    End;
  Finally
    FreeAndNil(LLimparPix);
    FreeAndNil(LConsulta);
  End;
end;

class procedure TPixDao.LimparPixDosPedidos(AEmpresaDoPix, ATxIdPix: String);
  Var
    LLimparPix: TUniQuery;
begin
  Try
    LLimparPix := fCriaQuery;

    LLimparPix.SQL.Text := 'UPDATE EXTGOR            ' +
                           '   SET FGO_EMPPIX=NULL,  ' +
                           '       FGO_TX_PIX=NULL   ' +
                           'WHERE FGO_EMPPIX=:EMPPIX ' +
                           '  AND FGO_TX_PIX=:TX_PIX ';

    LLimparPix.ParamByName('EMPPIX').AsString := AEmpresaDoPix;
    LLimparPix.ParamByName('TX_PIX').AsString := ATxIdpIX;

    LLimparPix.ExecSQL;
  Finally
    FreeAndNil(LLimparPix);
  End;
end;

class function TPixDao.PixExpiradoMaisDeUmDeterminadoPeriodo(
  APixAtivoMonitor: TDataset; ATempoMinimoExpiracao: Integer;
  ATabelaMonitoramento: Boolean): Boolean;
  Var
    LDataHoraDeveRemover: TDateTime;

    LExpiracaoSegundos: Integer;

    LCampoDataHoraCriacao,
    LCampoExpiracao: String;
begin
  LCampoDataHoraCriacao := 'MPX_DTAHOR';
  LCampoExpiracao := 'MPX_EXPIRA';
  If ATabelaMonitoramento Then
  Begin
    LCampoDataHoraCriacao := 'LOG_DTACAD';
    LCampoExpiracao := 'LOG_EXPIRA';
  End;

  If Not TryStrToInt(APixAtivoMonitor.FieldByName(LCampoExpiracao).AsString, LExpiracaoSegundos) Then
    LExpiracaoSegundos := 0;

  If LExpiracaoSegundos = 0 Then
    LExpiracaoSegundos := 86400;

  LDataHoraDeveRemover := IncSecond(APixAtivoMonitor.FieldByName(LCampoDataHoraCriacao).AsDateTime,
                                    LExpiracaoSegundos + ATempoMinimoExpiracao);

  Result := fRetDtaHraServidor > LDataHoraDeveRemover;
end;

class function TPixDao.PixGeradoEmPedidosDesmembrados(AEmpresaPix,
  ATxIdPix: String; out AListaPedidos: String): Boolean;
  Var
    LConsulta: TUniQuery;
begin
  Result := False;

  AListaPedidos := '';

  If AEmpresaPix.IsEmpty Then
    Exit;

  If ATxIdPix.IsEmpty Then
    Exit;

  Try
    LConsulta := fCriaQuery;

    LConsulta.SQL.Text := 'SELECT F.FGO_NUMDOC, F.FGO_ESPDOC, F.FGO_CODEMP ' +
                          'FROM EXTGOR E ' +
                          'JOIN FATGOR F ON F.AUTOINCREM=E.FGO_SEQFGO ' +
                          'WHERE E.FGO_EMPPIX="' + AEmpresaPix + '" AND ' +
                          '      E.FGO_TX_PIX="' + ATxIdPix + '"';

    LConsulta.Open;

    Result := LConsulta.RecordCount > 1;

    If Result Then
    Begin
      LConsulta.First;
      While Not LConsulta.Eof Do
      Begin
        AListaPedidos := AListaPedidos + LConsulta.FieldByName('FGO_NUMDOC').AsString + '-' +
                                         LConsulta.FieldByName('FGO_ESPDOC').AsString + '-' +
                                         LConsulta.FieldByName('FGO_CODEMP').AsString + ', ';

        LConsulta.Next;
      End;

      AListaPedidos := LeftStr(AListaPedidos, AListaPedidos.Length - 2);
    End;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

class function TPixDao.PixGeradoParaVariasDuplicatas(AEmpresaPix,
  ATxIdPix: String; out AListaDuplicatas: String): Boolean;
  Var
    LConsulta: TUniQuery;
begin
  Result := False;

  AListaDuplicatas := '';

  If AEmpresaPix.IsEmpty Then
    Exit;

  If ATxIdPix.IsEmpty Then
    Exit;

  Try
    LConsulta := fCriaQuery;

    LConsulta.SQL.Text := 'SELECT CTR_NUMDUP, CTR_PARCEL, CTR_ESPDOC, CTR_CODEMP ' +
                          'FROM CADREC ' +
                          'WHERE CTR_EMPPIX="' + AEmpresaPix + '" AND ' +
                          '      CTR_TX_PIX="' + ATxIdPix + '"';

    LConsulta.Open;

    Result := LConsulta.RecordCount > 1;

    If Result Then
    Begin
      LConsulta.First;
      While Not LConsulta.Eof Do
      Begin
        AListaDuplicatas := AListaDuplicatas + LConsulta.FieldByName('CTR_NUMDUP').AsString +
                                               LConsulta.FieldByName('CTR_PARCEL').AsString + '-' +
                                               LConsulta.FieldByName('CTR_ESPDOC').AsString + '-' +
                                               LConsulta.FieldByName('CTR_CODEMP').AsString + ', ';

        If LConsulta.RecNo >= 5 Then
        Begin
          AListaDuplicatas := LeftStr(AListaDuplicatas, AListaDuplicatas.Length - 1) + '...';

          Exit;
        End;

        LConsulta.Next;
      End;

      AListaDuplicatas := LeftStr(AListaDuplicatas, AListaDuplicatas.Length - 2);
    End;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

class function TPixDao.PortadorPossuiChavesPixVinculadas(
  APortador: String): Boolean;
  Var
    LConsulta: TUniQuery;
begin
  Result := False;

  If APortador.IsEmpty Then
    Exit;

  Try
    LConsulta := fCriaQuery;
    LConsulta.SQL.Text := 'SELECT PX.AUTOINCREM ' +
                          'FROM CADPOR P ' +
                          'JOIN CADCCA C ON C.AUTOINCREM=P.POR_CCAAUT ' +
                          'JOIN CCAPIX PX ON PX.PIX_SEQCCA=C.AUTOINCREM ' +
                          'WHERE P.POR_CODPOR="' + APortador + '" ' +
                          '  AND P.POR_CCAAUT IS NOT NULL ' +
                          '  AND PX.PIX_ATIVA_="S" ';

    LConsulta.Open;

    Result := Not LConsulta.IsEmpty;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

class function TPixDao.PixGeradoEmPedidosDesmembrados(AEmpresaPix,
  ATxIdPix: String): Boolean;
  Var
    LConsulta: TUniQuery;
begin
  Result := False;

  If AEmpresaPix.IsEmpty Then
    Exit;

  If ATxIdPix.IsEmpty Then
    Exit;

  Try
    LConsulta := fCriaQuery;

    LConsulta.SQL.Text := 'SELECT IFNULL(COUNT(FGO_SEQFGO), 0) AS PEDIDOS ' +
                          'FROM EXTGOR ' +
                          'WHERE FGO_EMPPIX="' + AEmpresaPix + '" AND ' +
                          '      FGO_TX_PIX="' + ATxIdPix + '"';

    LConsulta.Open;

    Result := LConsulta.FieldByName('PEDIDOS').AsInteger > 1;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

class function TPixDao.RegistroDoPixAtivoEExpirado(
  AAutoincrem: String): Boolean;
  Var
    LConsulta: TUniQuery;
begin
  Try
    LConsulta := fCriaQuery;
    LConsulta.SQL.Text := 'SELECT AUTOINCREM    ' +
                          'FROM MOVPIX M ' +
                          'WHERE M.AUTOINCREM="' + AAutoIncrem + '" ' +
                          '  AND M.MPX_STATUS IN (' + STATUS_PIX_ATIVO_SQL + ') ' +
                          '  AND M.MPX_DTAHOR <= DATE_ADD(CURRENT_TIMESTAMP, INTERVAL (M.MPX_EXPIRA + 21600) * - 1 SECOND) ';

    LConsulta.Open;

    Result := Not LConsulta.IsEmpty;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

function TPixDao.RegistroJaEstaNaMOVPIX(ADadosRetorno: TDadosRetornoPixConsulta;
  ACodigoEmpresa: String): Boolean;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT * ' +
                          'FROM MOVPIX ' +
                          'WHERE MPX_CODEMP=:CODEMP ' +
                          '  AND MPX_TX_ID_=:TX_ID_ ';

    LConsulta.ParamByName('CODEMP').AsString := ACodigoEmpresa;
    LConsulta.ParamByName('TX_ID_').AsString := ADadosRetorno.Txid;

    LConsulta.Open;

    Result := Not LConsulta.IsEmpty;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

class function TPixDao.RetornaAutoIncremChavePixDoCaixa(
  ACodigoCaixa: String): String;
begin
  Result := '';

  If Not ACodigoCaixa.IsEmpty Then
    Result := fCampoTabela('CAX_SEQPIX', 'CADCAX', ['CAX_CODCAX', 'CAX_CODEMP'], [ACodigoCaixa, VS_strCodEmp]);

  If Result.IsEmpty Then
    Result := fCfgSis('CHAPIX');
end;

class function TPixDao.RetornaBancoDaChavePix(
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

function TPixDao.RetornaCamposConsultaBase: String;
  Var
    LConsulta: TUniQuery;
begin
  //Todas as versões do robo
  Result := ' M.AUTOINCREM, M.MPX_TX_ID_, IF(R.AUTOINCREM IS NULL, "N", "S") AS PIXNATELA, ' +
            ' M.MPX_SEQPIX, M.MPX_CODEMP, M.MPX_JSOENV, M.MPX_CODOPE, M.MPX_EXPIRA, M.MPX_DTAHOR, ' +
            ' POR.POR_CODPOR,  ' +
            ' C.CCA_CODBCO ';

  Try
    LConsulta := fCriaQuery;
    LConsulta.SQL.Text := 'SELECT * FROM MOVPIX WHERE FALSE';
    LConsulta.Open;

    If LConsulta.FindField('MPX_CRIADO') <> Nil Then
      Result := Result + ', M.MPX_CRIADO ';

    If LConsulta.FindField('MPX_USASHP') <> Nil Then
      Result := Result + ', M.MPX_USASHP ';

    If LConsulta.FindField('MPX_CHA_CC') <> Nil Then
      Result := Result + ', M.MPX_CHA_CC ';

    If LConsulta.FindField('MPX_ORDREF') <> Nil Then
      Result := Result + ', M.MPX_ORDREF ';
  Finally
    FreeAndNil(LConsulta);
  End;
end;

class function TPixDao.RetornaChavePixDoPortador(APortador: String): String;
  Var
    LConsulta: TUniQuery;
begin
  If APortador.IsEmpty Then
    Exit('');

  Try
    LConsulta := fCriaQuery;
    LConsulta.SQL.Text := 'SELECT PX.AUTOINCREM ' +
                          'FROM CADPOR P ' +
                          'JOIN CADCCA C ON C.AUTOINCREM=P.POR_CCAAUT ' +
                          'JOIN CCAPIX PX ON PX.PIX_SEQCCA=C.AUTOINCREM ' +
                          'WHERE P.POR_CODPOR="' + APortador + '" ' +
                          '  AND PX.PIX_ATIVA_="S" ' +
                          '  LIMIT 1 ';

    LConsulta.Open;

    Result := LConsulta.FieldByName('AUTOINCREM').AsString;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

class function TPixDao.RetornaDadosDoPix(ATxId,
  ACodigoEmpresa: String): TUniClientDataSet;
  Var
    LConsulta: TUniQuery;
begin
  Try
    LConsulta := fCriaQuery;

    LConsulta.SQL.Text := 'SELECT M.AUTOINCREM, ' +
                          '       M.MPX_CODEMP, ' +
                          '       M.MPX_SEQPIX, ' +
                          '       M.MPX_TX_ID_, ' +
                          '       M.MPX_STATUS, ' +
                          '       M.MPX_VALPIX, ' +
                          '       M.MPX_QRCODE, ' +
                          '       M.MPX_JSOENV, ' +
                          '       M.MPX_JSOREC, ' +
                          '       M.MPX_USASHP, ' +
                          '       M.MPX_EXPIRA, ' +
                          '       M.MPX_DTAHOR, ' +
                          '     POR.POR_CODPOR  ' +
                          'FROM MOVPIX M        ' +
                          'JOIN CCAPIX P ON P.AUTOINCREM=M.MPX_SEQPIX ' +
                          'JOIN CADCCA C ON C.AUTOINCREM=P.PIX_SEQCCA ' +
                          'JOIN CADPOR POR ON POR.POR_CCAAUT=C.AUTOINCREM ' +
                          'WHERE M.MPX_CODEMP=:CODEMP ' +
                          '  AND M.MPX_TX_ID_=:TX_ID_ ';

    LConsulta.ParamByName('CODEMP').AsString := ACodigoEmpresa;
    LConsulta.ParamByName('TX_ID_').AsString := ATxId;

    LConsulta.Open;

    Result := fCriaClientDatSet(LConsulta);
  Finally
    FreeAndNil(LConsulta);
  End;
end;

class function TPixDao.RetornaDadosDoPix(
  AAutoIncremMovPix: String): TUniClientDataSet;
Var
    LConsulta: TUniQuery;
begin
  Try
    LConsulta := fCriaQuery;

    LConsulta.SQL.Text := 'SELECT M.*,          ' +
                          '     POR.POR_CODPOR  ' +
                          'FROM MOVPIX M        ' +
                          'JOIN CCAPIX P ON P.AUTOINCREM=M.MPX_SEQPIX ' +
                          'JOIN CADCCA C ON C.AUTOINCREM=P.PIX_SEQCCA ' +
                          'JOIN CADPOR POR ON POR.POR_CCAAUT=C.AUTOINCREM ' +
                          'WHERE M.AUTOINCREM=:AUTINC ';

    LConsulta.ParamByName('AUTINC').AsString := AAutoIncremMovPix;

    LConsulta.Open;

    Result := fCriaClientDatSet(LConsulta);
  Finally
    FreeAndNil(LConsulta);
  End;
end;

class function TPixDao.RetornaDadosPedidoPix(ATxId,
  ACodigoEmpresa: String): TUniClientDataSet;
  Var
    LConsulta: TUniQuery;
begin
  Try
    LConsulta := fCriaQuery;

    LConsulta.SQL.Text := 'SELECT F.FGO_NUMDOC, ' +
                          '       F.FGO_CODEMP, ' +
                          '       F.FGO_ESPDOC, ' +
                          '       F.FGO_CODCLI  ' +
                          'FROM EXTGOR E        ' +
                          'JOIN FATGOR F        ' +
                          '  ON F.AUTOINCREM=E.FGO_SEQFGO ' +
                          'WHERE E.FGO_EMPPIX=:EMPPIX ' +
                          '  AND E.FGO_TX_PIX=:TX_PIX ';

    LConsulta.ParamByName('EMPPIX').AsString := ACodigoEmpresa;
    LConsulta.ParamByName('TX_PIX').AsString := ATxId;

    LConsulta.Open;

    Result := fCriaClientDatSet(LConsulta);
  Finally
    FreeAndNil(LConsulta);
  End;
end;

class function TPixDao.RetornaOperadorLancamentoPix(ATxId, ACodigoEmpresa: String): string;
  const
    FORCA_DE_VENDAS_APP_SALES = '008';
  Var
    LConsulta: TUniQuery;
begin
  Result := strLoginUsuarioLogado;

  if not fCampoExiste('EXTGOR', 'FGO_CODORI') then
    Exit;

  Try
    LConsulta := fCriaQuery;

    LConsulta.SQL.Text := 'SELECT FGO_CODDIG, ' +
                          '       FGO_CODORI  ' +
                          'FROM EXTGOR E      ' +
                          'JOIN FATGOR F      ' +
                          '  ON F.AUTOINCREM=E.FGO_SEQFGO ' +
                          'WHERE E.FGO_EMPPIX=:EMPPIX ' +
                          '  AND E.FGO_TX_PIX=:TX_PIX ';

    LConsulta.ParamByName('EMPPIX').AsString := ACodigoEmpresa;
    LConsulta.ParamByName('TX_PIX').AsString := ATxId;

    LConsulta.Open;

    if LConsulta.FieldByName('FGO_CODDIG').AsString.IsEmpty then
      Exit;

    if LConsulta.FieldByName('FGO_CODORI').AsString.Equals(FORCA_DE_VENDAS_APP_SALES) then
      Result := LConsulta.FieldByName('FGO_CODDIG').AsString;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

class function TPixDao.RetornaPortadorTransitorioLancamentoPix(ATxId, ACodigoEmpresa: String): string;
  const
    FORCA_DE_VENDAS_APP_SALES = '008';
  Var
    LConsulta: TUniQuery;
begin
  Result := EmptyStr;

  if not fCampoExiste('CADOPE', 'OPE_PORAPP') then
    Exit;

  Try
    LConsulta := fCriaQuery;

    LConsulta.SQL.Text := 'SELECT FGO_CODORI, ' +
                          '       OPE_PORAPP  ' +
                          'FROM EXTGOR E      ' +
                          'JOIN FATGOR F      ' +
                          '  ON F.AUTOINCREM=E.FGO_SEQFGO ' +
                          'JOIN CADOPE O      ' +
                          '  ON F.FGO_CODDIG=O.OPE_CODOPE ' +
                          'WHERE E.FGO_EMPPIX=:EMPPIX ' +
                          '  AND E.FGO_TX_PIX=:TX_PIX ';

    LConsulta.ParamByName('EMPPIX').AsString := ACodigoEmpresa;
    LConsulta.ParamByName('TX_PIX').AsString := ATxId;

    LConsulta.Open;

    if LConsulta.FieldByName('FGO_CODORI').AsString.Equals(FORCA_DE_VENDAS_APP_SALES) then
      Result := LConsulta.FieldByName('OPE_PORAPP').AsString;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

class function TPixDao.RetornaDadosPixParaGerarCCOperador(
  ACodigoOperador: String): TUniClientDataSet;
  Var
    LConsulta: TUniQuery;
begin
  Try
    LConsulta := fCriaQuery;

    LConsulta.SQL.Text := 'SELECT * '+
                          'FROM MOVPIX ' +
                          'WHERE MPX_STATUS IN ("CONCLUIDACC", "approvedCC", "PAIDCC") ' +
                          '  AND MPX_CODOPE="' + ACodigoOperador + '"';

    LConsulta.Open;

    Result := fCriaClientDatSet(LConsulta);
    Result.Open;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

function TPixDao.RetornaDataPixAtivoMaisAntigo: TDateTime;
  Var
    LConsulta: TUniQuery;
begin
  Result := 0;

  Try
    LConsulta := fCriaQuery;

    LConsulta.SQL.Text := 'SELECT MIN(MPX_DTAHOR) AS DATAHORA '+
                          'FROM MOVPIX ' +
                          'WHERE MPX_STATUS IN (' + STATUS_PIX_ATIVO_SQL + ')';

    LConsulta.Open;

    If Not LConsulta.FieldByName('DATAHORA').IsNull Then
      Result := LConsulta.FieldByName('DATAHORA').AsDateTime;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

function TPixDao.RetornaDatasetContasBancariasComCertificadosAVencerVencidos: TUniClientDataset;
  Var
    LConsulta: TUniQuery;
begin
  Try
    LConsulta := fCriaQuery;
    LConsulta.SQL.Text := 'SELECT CCA_CODBCO, CCA_AGENCI, CCA_DIGAGE, ' +
                          '       CCA_CODCTA, CCA_DIGCTA, CCA_CODEMP, ' +
                          '       CCA_VALCER ' +
                          'FROM CADCCA ' +
                          'WHERE CCA_VALCER IS NOT NULL ' +
                          '  AND CCA_VALCER BETWEEN :DTAINI AND :DTAFIN ' +
                          'ORDER BY CCA_VALCER';

    LConsulta.ParamByName('DTAINI').AsDateTime := IncDay(fNow, -15);
    LConsulta.ParamByName('DTAFIN').AsDateTime := IncDay(fNow, 20);

    LConsulta.Open;

    Result := fCriaClientDatSet(LConsulta);
  Finally
    FreeAndNil(LConsulta);
  End;
end;

class function TPixDao.RetornaEmpresasComChavePixConfigurada(
  AAutoIncremChavePix: String): String;
  Var
    LConsulta: TUniQuery;
begin
  Result := '';

  If AAutoIncremChavePix.IsEmpty Then
    Exit;

  Try
    LConsulta := fCriaQuery;
    LConsulta.SQL.Text := 'SELECT GROUP_CONCAT(SIS_CODEMP) AS EMPRESAS FROM CFGSIS WHERE SIS_CODCFG="CFG_CHAPIX" AND ' +
                          ' SIS_VALCFG="' + AAutoIncremChavePix + '"';

    LConsulta.Open;

    Result := LConsulta.FieldByName('EMPRESAS').AsString;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

function TPixDao.RetornaListaDeOperadoresMensagens: TUniClientDataset;
  Var
    LConsulta: TUniQuery;
begin
  Try
    LConsulta := fCriaQuery;
    LConsulta.SQL.Text := 'SELECT OPE_CODOPE ' +
                          'FROM CADOPE ' +
                          'WHERE OPE_MSGPIX="S" ';

    LConsulta.Open;

    Result := fCriaClientDatSet(LConsulta);
  Finally
    FreeAndNil(LConsulta);
  End;
end;

function TPixDao.RetornaListaDePixConsulta(AEmpresa: String; ATxId: string;
                                           AIgnorarPixTela: Boolean): TUniClientDataset;
  Var
    LConsulta: TUniQuery;

    LCamposConsulta,
    LPixTela: String;
begin
  Try
    If AEmpresa.IsEmpty Then
      AEmpresa := ' AND M.MPX_EMPFIS="' + fRetEmpresaFisica + '" '
    Else
      AEmpresa := '';

    LPixTela := EmptyStr;
    If Not AIgnorarPixTela Then
      LPixTela := '  AND M.AUTOINCREM NOT IN (' +
                  '      SELECT PIXTEL.AUTOINCREM ' +
                  '      FROM PIXTEL ' +
                  '      WHERE PIXTEL.MPX_ULTREQ > DATE_ADD(CURRENT_TIMESTAMP, INTERVAL -120 SECOND)) ';

    If Not ATxId.IsEmpty Then
      ATxId := ' AND M.MPX_TX_ID_="' + ATxId + '" ';

    LCamposConsulta := RetornaCamposConsultaBase;

    LConsulta := fCriaQuery;
    LConsulta.SQL.Text := 'SELECT ' + LCamposConsulta +
                          'FROM MOVPIX M ' +
                          'LEFT JOIN PIXTEL R ON R.AUTOINCREM=M.AUTOINCREM ' +
                          'JOIN CCAPIX P ON P.AUTOINCREM=M.MPX_SEQPIX ' +
                          'JOIN CADCCA C ON C.AUTOINCREM=P.PIX_SEQCCA ' +
                          'JOIN CADPOR POR ON POR.POR_CCAAUT=C.AUTOINCREM ' +
                          'WHERE M.MPX_STATUS IN (' + STATUS_PIX_ATIVO_SQL + ') ' +
                          AEmpresa +
                          ATxId +
                          LPixTela +
                          'GROUP BY M.AUTOINCREM ' +
                          'ORDER BY M.MPX_EMPFIS, P.AUTOINCREM ';

    LConsulta.Open;

    Result := fCriaClientDatSet(LConsulta);
  Finally
    FreeAndNil(LConsulta);
  End;
end;

function TPixDao.RetornaListaDePixConsultaTemporaria(AEmpresa: String; ATxId: string = ''): TUniClientDataset;
  Var
    LConsulta: TUniQuery;

    LCamposConsulta: String;
begin
  Try
    If AEmpresa.IsEmpty Then
      AEmpresa := ' AND M.LOG_EMPFIS="' + fRetEmpresaFisica + '" '
    Else
      AEmpresa := '';

    If Not ATxId.IsEmpty Then
      ATxId := ' AND M.LOG_TX_ID_="' + ATxId + '" ';

    LCamposConsulta := RetornaCamposConsultaBase;

    LConsulta := fCriaQuery;

    LConsulta.SQL.Text := 'SHOW TABLES LIKE "MONPIX_LOG"';
    LConsulta.Open;
    If LConsulta.IsEmpty Then
      Exit(Nil);

    LConsulta.SQL.Text := 'SELECT *, M.AUTOINCREM AS INCLOG ' +
                          'FROM MONPIX_LOG M ' +
                          'JOIN CCAPIX P ON P.AUTOINCREM=M.LOG_SEQPIX ' +
                          'JOIN CADCCA C ON C.AUTOINCREM=P.PIX_SEQCCA ' +
                          'JOIN CADPOR POR ON POR.POR_CCAAUT=C.AUTOINCREM ' +
                          'WHERE M.LOG_STATUS IN (' + STATUS_PIX_ATIVO_SQL + ') ' +
                          AEmpresa +
                          ATxId +
                          '  AND M.LOG_DTACON < DATE_ADD(CURRENT_TIMESTAMP, INTERVAL -240 SECOND) ' +
                          'ORDER BY M.LOG_EMPFIS, M.LOG_SEQPIX ';

    LConsulta.Open;

    Result := fCriaClientDatSet(LConsulta);
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

function TPixDao.RetornaListaDePixConsultaTemporariaPago(AEmpresa: String; ATxId: string = ''): TUniClientDataset;
  Var
    LConsulta: TUniQuery;

    LCamposConsulta: String;
begin
  Try
    If AEmpresa.IsEmpty Then
      AEmpresa := ' AND M.LOG_EMPFIS="' + fRetEmpresaFisica + '" '
    Else
      AEmpresa := '';

    If Not ATxId.IsEmpty Then
      ATxId := ' AND M.LOG_TX_ID_="' + ATxId + '" ';

    LCamposConsulta := RetornaCamposConsultaBase;

    LConsulta := fCriaQuery;

    LConsulta.SQL.Text := 'SHOW TABLES LIKE "MONPIX_LOG"';
    LConsulta.Open;
    If LConsulta.IsEmpty Then
      Exit(Nil);

    LConsulta.SQL.Text := 'SELECT *, M.AUTOINCREM AS INCLOG ' +
                          'FROM DEL_MONPIX_LOG M ' +
                          'JOIN CCAPIX P ON P.AUTOINCREM=M.LOG_SEQPIX ' +
                          'JOIN CADCCA C ON C.AUTOINCREM=P.PIX_SEQCCA ' +
                          'JOIN CADPOR POR ON POR.POR_CCAAUT=C.AUTOINCREM ' +
                          'WHERE M.LOG_STATUS IN (' + STATUS_PIX_PAGO_SQL + ') ' +
                          '  AND M.MOTDEL = "REMOVIDO POR ESTAR PAGO" ' +
                          AEmpresa +
                          ATxId +
                          '  AND M.LOG_DTACAD BETWEEN DATE_ADD(CURRENT_TIMESTAMP, INTERVAL -3 DAY) AND ' +
                          '                           DATE_ADD(CURRENT_TIMESTAMP, INTERVAL -1 DAY) ' +
                          '  AND (SELECT IFNULL(COUNT(AUTOINCREM), 0) ' +
                          '       FROM MOVPIX ' +
                          '       WHERE MPX_CODEMP=M.LOG_CODEMP ' +
                          '         AND MPX_TX_ID_=M.LOG_TX_ID_) = 0 ' +
                          '  AND (SELECT IFNULL(COUNT(AUTOINCREM), 0) ' +
                          '       FROM DEL_MOVPIX ' +
                          '       WHERE MPX_CODEMP=M.LOG_CODEMP ' +
                          '         AND MPX_TX_ID_=M.LOG_TX_ID_) = 0 ' +
                          'ORDER BY M.LOG_EMPFIS, M.LOG_SEQPIX ';

    LConsulta.Open;

    Result := fCriaClientDatSet(LConsulta);
  Finally
    LConsulta.Close;
    FreeAndNil(LConsulta);
  End;
end;

function TPixDao.RetornaListaDuplicatasPix(AEmpresaPix,
  ATxIdPix: String; var ADuplicatasAutoIncrem: TStringList): String;
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

function TPixDao.RetornaListaPedidosPix(AEmpresaPix, ATxIdPix: String): String;
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

function TPixDao.RetornaPortadorChavePix(AAutoIncremChavePix: String): String;
  Var
    LConsulta: TUniQuery;
begin
  Result := '';

  If AAutoIncremChavePix.IsEmpty Then
    Exit;

  Try
    LConsulta := fCriaQuery;

    LConsulta.SQL.Text := 'SELECT P.POR_CODPOR ' +
                          'FROM CCAPIX C ' +
                          'JOIN CADCCA D ON D.AUTOINCREM=C.PIX_SEQCCA ' +
                          'JOIN CADPOR P ON P.POR_CCAAUT=D.AUTOINCREM ' +
                          'WHERE C.AUTOINCREM="' + AAutoIncremChavePix + '"';
    LConsulta.Open;

    Result := LConsulta.FieldByName('POR_CODPOR').AsString;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

function TPixDao.RetornaStatusDoPixAtualizado(
  AAutoIncremMovPix: String): String;
  Var
    LConsulta: TUniQuery;
begin
  Result := '';

  If AAutoIncremMovPix.IsEmpty Then
    Exit;

  Try
    LConsulta := fCriaQuery;

    LConsulta.SQL.Text := 'SELECT MPX_STATUS FROM MOVPIX WHERE AUTOINCREM="' + AAutoIncremMovPix + '"';
    LConsulta.Open;

    Result := LConsulta.FieldByName('MPX_STATUS').AsString;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

class function TPixDao.RetornaStatusSePedidoPossuirPix(ANumeroPedido, AEspecie,
  ACodigoEmpresa: String): String;
  Var
    LConsulta: TUniQuery;
begin
  Result := '';

  If ANumeroPedido.IsEmpty Then
    Exit;

  Try
    LConsulta := fCriaQuery;

    LConsulta.SQL.Text := 'SELECT M.MPX_STATUS ' +
                          'FROM FATGOR F ' +
                          'JOIN EXTGOR E ON E.FGO_SEQFGO=F.AUTOINCREM ' +
                          'JOIN MOVPIX M ON M.MPX_CODEMP=E.FGO_EMPPIX ' +
                          '             AND M.MPX_TX_ID_=E.FGO_TX_PIX ' +
                          'WHERE F.FGO_NUMDOC="' + ANumeroPedido + '" ' +
                          '  AND F.FGO_ESPDOC="' + AEspecie + '" ' +
                          '  AND F.FGO_CODEMP="' + ACodigoEmpresa + '" ' +
                          '  AND E.FGO_TX_PIX IS NOT NULL ';
    LConsulta.Open;

    Result := LConsulta.FieldByName('MPX_STATUS').AsString;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

procedure TPixDao.VerificaPagamentoNoAmbienteDeTestes(
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

function TPixDao.VerificaSeOPixEstaAbertoNaTela(AAutoIncremMovPix: String): Boolean;
  Var
    LConsulta: TUniQuery;
begin
  Result := True;

  If AAutoIncremMovPix.IsEmpty Then
    Exit;

  Try
    LConsulta := fCriaQuery;

    LConsulta.SQL.Text := 'SELECT AUTOINCREM FROM PIXTEL ' +
                          'WHERE AUTOINCREM="' + AAutoIncremMovPix + '" ' +
                          '  AND MPX_ULTREQ > DATE_ADD(CURRENT_TIMESTAMP, INTERVAL -120 SECOND) ';
    LConsulta.Open;

    Result := Not LConsulta.IsEmpty;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

class function TPixDao.RetornaStatusSePedidoPossuirPix(AEmpresaPix,
  ATxIdPix: String): String;
  Var
    LConsulta: TUniQuery;
begin
  Result := '';

  If AEmpresaPix.IsEmpty Then
    Exit;

  If ATxIdPix.IsEmpty Then
    Exit;

  Try
    LConsulta := fCriaQuery;

    LConsulta.SQL.Text := 'SELECT MPX_STATUS ' +
                          'FROM MOVPIX ' +
                          'WHERE MPX_CODEMP="' + AEmpresaPix + '" AND ' +
                          '      MPX_TX_ID_="' + ATxIdPix + '"';

    LConsulta.Open;

    Result := LConsulta.FieldByName('MPX_STATUS').AsString;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

class function TPixDao.VerificaSePossuiChavePixSelecionada: Boolean;
  Var
    LChavePixConfigurada: String;

    LConsulta: TUniQuery;
begin
  Result := False;

  LChavePixConfigurada := fCfgSis('CHAPIX', varString);

  If LChavePixConfigurada.IsEmpty Then
    Exit;

  Try
    LConsulta := fCriaQuery;

    LConsulta.SQL.Text := 'SELECT PIX_CHAVE_ FROM CCAPIX WHERE AUTOINCREM="' + LChavePixConfigurada + '"';

    LConsulta.Open;

    Result := Not LConsulta.IsEmpty;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

end.
