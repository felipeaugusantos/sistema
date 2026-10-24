unit untRcxTLiberacaoDeCaixas;

interface

Uses System.Classes, System.SysUtils, Data.DB, WinApi.Windows, Vcl.Controls,
     untLiberacao, Uni, UniClientDataset, untTBanTrf, System.Generics.Collections,
     System.StrUtils;

Type
  TFiltrosTelaLiberacao = record
    DataInicial,
    DataFinal: TDateTime;

    CodigoCaixa,
    Operador,
    Empresas: String;

    Fechamento,
    Status: Integer;
  end;

Type
  TDadosTRFLIB = record
    MovimentacaoBancaria,
    MotivoRecusa,
    MovimentacaoBancariaDebito,
    MovimentacaoBancariaCredito,
    AutoIncremCaixa: String;

    ValorAjuste: Double;
  end;

Type
  TLiberacaoDeCaixas = class

  private
    FTolerancia: Double;

    FUsaControleDivergencias: Boolean;

    FLiberacao: TLiberacao;

    FExibeDinheiro,
    FExibeCartao,
    FExibeChequeAVista,
    FExibeChequePre,
    FExibeOrdemPagamento,
    FExibeDivergencia: Boolean;

    FRcxCon: Integer;

    function RealizaLiberacaoDeTolerancia(ANovoValorAjuste: Double;
                                          ACodigoCaixa: String): Boolean;

    function GravarTabelaTRFLIB(ADataset: TDataset;
                                AStatus: String;
                                ADadosTrfLib: TDadosTrfLib): Boolean;

    function RetornaMovimentacaoBancariaLancamento(ADataset: TDataset): TUniClientDataSet;

    function RetornaMovimentacaoBancariaDivergencia(ADataset: TDataset): TUniClientDataSet;

    function LiberaMovimentacaoBancaria(AMovimentacaoBancaria,
                                        ACodigoEmpresa: String): Boolean;

    function LiberaDocumentosVinculados(ADataset: TDataset): Boolean;

    function PedePortadorParaTransacao(ADataset: TDataset): String;

    function DigitarMotivoRecusa(ADataset: TDataset): String;

    function InserirRegistroMovBan(ADataSetMovimentacaoBancaria: TDataset;
                                   ATipoLancamento,
                                   AModalidade: String;
                                   ADescricao: String = '';
                                   ANovoPortador: String = ''): String;

    function InserirRegistroCadRcxx(ADataset: TDataSet;
                                    AHistorico: String;
                                    ADivergencia: Boolean = False): String;
  public
    constructor Create;

    property ExibeDinheiro: Boolean read FExibeDinheiro;
    property ExibeCartao: Boolean read FExibeCartao;
    property ExibeChequeAVista: Boolean read FExibeChequeAVista;
    property ExibeChequePre: Boolean read FExibeChequePre;
    property ExibeOrdemPagamento: Boolean read FExibeOrdemPagamento;
    property ExibeDivergencia: Boolean read FExibeDivergencia;

    function RetornaSQLTransferencias(AFiltros: TFiltrosTelaLiberacao): String;
    function RetornaSQLLancamentos(AFiltros: TFiltrosTelaLiberacao): String;

    function RetornaSQLTransferenciasFechamento(AAutoIncremFechamento: String): String;

    function AceitarModalidadeVinculada(ADataset: TDataset): Boolean;

    function AceitarModalidadePortador(ADataset: TDataset): Boolean;

    function AceitarModalidadeDivergencia(ADataset: TDataset): Boolean;

    function RecusarModalidade(ADataset: TDataset): Boolean;

    function RecusarModalidadeDivergencia(ADataset: TDataset): Boolean;

    function AjustarValorDivergenciaCaixa(ADataset: TDataset): Boolean;
  End;

implementation
Uses untFuncoesSimples, untRcxSelecionaPortadorLiberacao, untMovBan,
     untRcxTResumoDeCaixa, untRcxDigitaMotivoRecusaLiberacao, untCadRcxx,
     untFuncoes, untLogMca, untLogChq, untLogBan;
{ TLiberacaoDeCaixas }

function TLiberacaoDeCaixas.AceitarModalidadeDivergencia(
  ADataset: TDataset): Boolean;
  Var
    LTipoTransacao,
    LPortadorSelecionado,
    LMovimentacaoBancariaDebito,
    LMovimentacaoBancariaCredito: String;

    LDataSetMovimentacaoBancaria: TUniClientDataset;

    LDadosTrfLib: TDadosTrfLib;
begin
  Try
    LDataSetMovimentacaoBancaria := RetornaMovimentacaoBancariaDivergencia(ADataset);

    LPortadorSelecionado := PedePortadorParaTransacao(ADataset);

    Result := Not LPortadorSelecionado.IsEmpty;
    If Not Result Then
      Exit;

    LMovimentacaoBancariaDebito := '';
    LMovimentacaoBancariaCredito := '';

    LTipoTransacao := 'C';
    If ADataset.FieldByName('VALOR').AsFloat < 0 Then
    Begin
      LTipoTransacao := 'D';

      If fMensagem('ATENÇÃO', 'Essa operação gerará um débito de ' + FormatFloat(',0.00', Abs(ADataset.FieldByName('VALOR').AsFloat)) +
                              ' no portador ' + LPortadorSelecionado + '-' + fRetNomPortador(LPortadorSelecionado) + '.' + #13 +
                              'Deseja continuar?', ['&Sim', '&Não']) = 2 Then
        Exit(False);
    End;

    fStartTransaction;

    If Result Then
    Begin
      If LTipoTransacao = 'D' Then
        LMovimentacaoBancariaDebito := InserirRegistroMovBan(LDataSetMovimentacaoBancaria,
                                                             'D',
                                                             ADataset.FieldByName('MODALIDADE').AsString,
                                                             'LANÇ. DECORRENTE A DIV. ACEITA PELO CAIXA',
                                                             LPortadorSelecionado)
      Else
        LMovimentacaoBancariaCredito := InserirRegistroMovBan(LDataSetMovimentacaoBancaria,
                                                              'C',
                                                              ADataset.FieldByName('MODALIDADE').AsString,
                                                              'LANÇ. DECORRENTE A DIV. ACEITA PELO CAIXA',
                                                              LPortadorSelecionado);

      LDadosTrfLib.MotivoRecusa := '';
      LDadosTrfLib.ValorAjuste := 0.00;
      LDadosTrfLib.MovimentacaoBancariaDebito := LMovimentacaoBancariaDebito;
      LDadosTrfLib.MovimentacaoBancariaCredito := LMovimentacaoBancariaCredito;

      Result := GravarTabelaTrfLib(ADataset,
                                   'LIBERADO',
                                   LDadosTrfLib);
    End;

    If Result Then
    Begin
      fCommit;

      ADataset.Edit;
      ADataset.FieldByName('RCX_STATUS').AsString := 'LIBERADO';
      ADataset.FieldByName('TRF_OPELIB').AsString := strLoginUsuarioLogado + '-' + fRetNomeOperador(strLoginUsuarioLogado);
      ADataset.FieldByName('TRF_DTALIB').AsDateTime := untFuncoesSimples.fRetDtaHraServidor;
      ADataset.Post;

      fMensagem('ATENÇÃO', 'Aceite da modalidade ' + ADataset.FieldByName('MODALIDADE').AsString +
                           ' realizada com sucesso.', ['&Ok']);
    End
    Else
      fRollBack;

    FreeAndNil(LDataSetMovimentacaoBancaria);
  Except
    On E: Exception Do
    Begin
      fRollBack;

      Raise Exception.Create('Ocorreu um erro ao aceitar a modalidade ' + ADataset.FieldByName('MODALIDADE').AsString + '.' + #13 +
                             'Erro gerado: ' + E.Message);
    End;
  End;
end;

function TLiberacaoDeCaixas.AceitarModalidadePortador(
  ADataset: TDataset): Boolean;
  Var
    LPortadorSelecionado,
    LMovimentacaoBancariaDebito,
    LMovimentacaoBancariaCredito: String;

    LDataSetMovimentacaoBancaria: TUniClientDataset;

    LDadosTrfLib: TDadosTrfLib;
begin
  Try
    LDataSetMovimentacaoBancaria := RetornaMovimentacaoBancariaLancamento(ADataset);

    LPortadorSelecionado := PedePortadorParaTransacao(ADataset);

    Result := Not LPortadorSelecionado.IsEmpty;
    If Not Result Then
      Exit;

    LMovimentacaoBancariaDebito := '';
    LMovimentacaoBancariaCredito := '';

    fStartTransaction;

    If Result Then
    Begin
      Result := LiberaMovimentacaoBancaria(LDataSetMovimentacaoBancaria.FieldByName('CTB_SEQLAN').AsString,
                                           LDataSetMovimentacaoBancaria.FieldByName('CTB_CODEMP').AsString);

      If Not Result Then
        Raise Exception.Create('Não foi possível encontrar a Movimentação Bancária da transferência.');

      If LDataSetMovimentacaoBancaria.FieldByName('CTB_CODPOR').AsString <> LPortadorSelecionado Then
      Begin
        //Débito no portador original
        LMovimentacaoBancariaDebito := InserirRegistroMovBan(LDataSetMovimentacaoBancaria,
                                                             'D',
                                                             ADataset.FieldByName('MODALIDADE').AsString,
                                                             'TF LIBERAÇÃO CAIXA (' + LeftStr(ADataset.FieldByName('MODALIDADE').AsString, 3).ToUpper + ') - [PORTADOR]');

        //Crédito no Novo Portador
        LMovimentacaoBancariaCredito := InserirRegistroMovBan(LDataSetMovimentacaoBancaria,
                                                              'C',
                                                              ADataset.FieldByName('MODALIDADE').AsString,
                                                              'TF LIBERAÇÃO CAIXA (' + LeftStr(ADataset.FieldByName('MODALIDADE').AsString, 3).ToUpper + ') - [PORTADOR]',
                                                              LPortadorSelecionado);
      End;

      LDadosTrfLib.MovimentacaoBancaria := LDataSetMovimentacaoBancaria.FieldByName('CTB_SEQLAN').AsString;
      LDadosTrfLib.MotivoRecusa := '';
      LDadosTrfLib.ValorAjuste := 0.00;
      LDadosTrfLib.MovimentacaoBancariaDebito := LMovimentacaoBancariaDebito;
      LDadosTrfLib.MovimentacaoBancariaCredito := LMovimentacaoBancariaCredito;

      Result := GravarTabelaTrfLib(ADataset,
                                   'LIBERADO',
                                   LDadosTrfLib);
    End;

    If Result Then
    Begin
      fCommit;

      ADataset.Edit;
      ADataset.FieldByName('RCX_STATUS').AsString := 'LIBERADO';
      ADataset.FieldByName('TRF_OPELIB').AsString := strLoginUsuarioLogado + '-' + fRetNomeOperador(strLoginUsuarioLogado);
      ADataset.FieldByName('TRF_DTALIB').AsDateTime := untFuncoesSimples.fRetDtaHraServidor;
      ADataset.Post;

      fMensagem('ATENÇÃO', 'Aceite da modalidade ' + ADataset.FieldByName('MODALIDADE').AsString +
                           ' realizada com sucesso.', ['&Ok']);
    End
    Else
      fRollBack;

    FreeAndNil(LDataSetMovimentacaoBancaria);
  Except
    On E: Exception Do
    Begin
      fRollBack;

      Raise Exception.Create('Ocorreu um erro ao aceitar a modalidade ' + ADataset.FieldByName('MODALIDADE').AsString + '.' + #13 +
                             'Erro gerado: ' + E.Message);
    End;
  End;
end;

function TLiberacaoDeCaixas.AceitarModalidadeVinculada(
  ADataset: TDataset): Boolean;
  Var
    LMovimentacaoBancaria: String;

    LDadosTrfLib: TDadosTrfLib;
begin
  Try
    LMovimentacaoBancaria := RetornaMovimentacaoBancariaLancamento(ADataset).FieldByName('CTB_SEQLAN').AsString;

    LDadosTrfLib.MovimentacaoBancaria := LMovimentacaoBancaria;
    LDadosTrfLib.MotivoRecusa := '';
    LDadosTrfLib.ValorAjuste := 0.00;

    fStartTransaction;

    Result := GravarTabelaTRFLIB(ADataset,
                                 'LIBERADO',
                                 LDadosTrfLib);

    If Result Then
    Begin
      Result := LiberaMovimentacaoBancaria(LMovimentacaoBancaria,
                                           ADataset.FieldByName('RCX_CODEMP').AsString);

      If Not Result Then
        Raise Exception.Create('Não foi possível encontrar a Movimentação Bancária da transferência.')
      Else
        Result := LiberaDocumentosVinculados(ADataset);
    End;

    If Result Then
    Begin
      fCommit;

      ADataset.Edit;
      ADataset.FieldByName('RCX_STATUS').AsString := 'LIBERADO';
      ADataset.FieldByName('TRF_OPELIB').AsString := strLoginUsuarioLogado + '-' + fRetNomeOperador(strLoginUsuarioLogado);
      ADataset.FieldByName('TRF_DTALIB').AsDateTime := untFuncoesSimples.fRetDtaHraServidor;
      ADataset.Post;

      fMensagem('ATENÇÃO', 'Aceite da modalidade ' + ADataset.FieldByName('MODALIDADE').AsString +
                           ' realizada com sucesso.', ['&Ok']);
    End
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollBack;

      Raise Exception.Create('Ocorreu um erro ao aceitar a modalidade ' + ADataset.FieldByName('MODALIDADE').AsString + '.' + #13 +
                             'Erro gerado: ' + E.Message);
    End;
  End;
end;

function TLiberacaoDeCaixas.AjustarValorDivergenciaCaixa(
  ADataset: TDataset): Boolean;
  Var
    LAutoIncremCaixa: String;

    LDadosTrfLib: TDadosTrfLib;
begin
  Result := True;

  If Abs(ADataset.FieldByName('VALOR').AsFloat) > FTolerancia Then
    Result := RealizaLiberacaoDeTolerancia(ADataset.FieldByName('VALOR').AsFloat,
                                           ADataset.FieldByName('RCX_CODCAX').AsString);

  If Not Result Then
    Exit;

  Try
    FRcxCon := StrToInt(fRetRcxCon);

    fStartTransaction;

    If Result Then
    Begin
      //Crédito no Caixa do Retorno do Valor
      LAutoIncremCaixa := InserirRegistroCadRcxx(ADataset,
                                                 'AJUSTE DIF. LIBERADA NO CAIXA FEC. ' + FormatDateTime('dd/mm', ADataset.FieldByName('RCX_DTACAD').AsDateTime) +
                                                 ' OPE.: ' + strLoginUsuarioLogado);

      LDadosTrfLib.MovimentacaoBancaria := '';
      LDadosTrfLib.ValorAjuste := ADataset.FieldByName('VALOR').AsFloat * (-1);
      LDadosTrfLib.AutoIncremCaixa := LAutoIncremCaixa;

      Result := GravarTabelaTrfLib(ADataset,
                                   'AJUSTADO',
                                   LDadosTrfLib);
    End;

    If Result Then
    Begin
      fCommit;

      ADataset.Edit;
      ADataset.FieldByName('RCX_STATUS').AsString := 'AJUSTADO';
      ADataset.FieldByName('TRF_OPELIB').AsString := strLoginUsuarioLogado + '-' + fRetNomeOperador(strLoginUsuarioLogado);
      ADataset.FieldByName('TRF_DTALIB').AsDateTime := untFuncoesSimples.fRetDtaHraServidor;
      ADataset.Post;

      fMensagem('ATENÇÃO', 'Ajuste da modalidade ' + ADataset.FieldByName('MODALIDADE').AsString +
                           ' realizada com sucesso.', ['&Ok']);
    End
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollBack;

      Raise Exception.Create('Ocorreu um erro ao ajustar a modalidade ' + ADataset.FieldByName('MODALIDADE').AsString + '.' + #13 +
                             'Erro gerado: ' + E.Message);
    End;
  End;
end;

constructor TLiberacaoDeCaixas.Create;
  Var
    LDireitos: String;
begin
  FTolerancia := fCfgSis('RCXTOL', varDouble);
  FUsaControleDivergencias := fCfgSis('RCXDIV', varBoolean);

  FLiberacao := TLiberacao.Create;

  FExibeDinheiro := fVerificaDirEspecificos(LDireitos, strLoginUsuarioLogado, 'VISMODDINLIBCAX');
  FExibeCartao := fVerificaDirEspecificos(LDireitos, strLoginUsuarioLogado, 'VISMODCARLIBCAX');
  FExibeChequeAVista := fVerificaDirEspecificos(LDireitos, strLoginUsuarioLogado, 'VISMODCHVLIBCAX');
  FExibeChequePre := fVerificaDirEspecificos(LDireitos, strLoginUsuarioLogado, 'VISMODCHPLIBCAX');
  FExibeOrdemPagamento := fVerificaDirEspecificos(LDireitos, strLoginUsuarioLogado, 'VISMODORDLIBCAX');
  FExibeDivergencia := fVerificaDirEspecificos(LDireitos, strLoginUsuarioLogado, 'VISDIVLIBCAX');
end;

function TLiberacaoDeCaixas.DigitarMotivoRecusa(ADataset: TDataset): String;
  Var
    LDigitaMotivoRecusaLiberacao: TfrmRcxDigitaMotivoRecusaLiberacao;
begin
  Result := '';

  Try
    pCriarFormularios(TfrmRcxDigitaMotivoRecusaLiberacao, LDigitaMotivoRecusaLiberacao);
    LDigitaMotivoRecusaLiberacao.Modalidade := ADataset.FieldByName('MODALIDADE').AsString;
    LDigitaMotivoRecusaLiberacao.Valor := ADataset.FieldByName('VALOR').AsFloat;

    LDigitaMotivoRecusaLiberacao.ShowModal;

    If LDigitaMotivoRecusaLiberacao.ModalResult = mrOk Then
      Result := LDigitaMotivoRecusaLiberacao.edtMotivoRecusa.Text;
  Finally
    FreeAndNil(LDigitaMotivoRecusaLiberacao);
  End;
end;

function TLiberacaoDeCaixas.GravarTabelaTrfLib(ADataset: TDataset;
                                               AStatus: String;
                                               ADadosTrfLib: TDadosTrfLib): Boolean;
  Var
    LGravacao: TUniQuery;
begin
  Try
    LGravacao := fCriaQuery;
    LGravacao.SQL.Text := 'SELECT * FROM LIBTRF ' +
                          'WHERE TRF_SEQRCX="' + ADataset.FieldByName('AUTOINCREM').AsString + '" ' +
                          '  AND TRF_OPERCX="' + ADataset.FieldByName('RCX_CODOPE').AsString + '" ' +
                          '  AND TRF_MODALI="' + ADataset.FieldByName('MODALIDADE').AsString + '" ';

    LGravacao.Open;
    If LGravacao.IsEmpty Then
    Begin
      LGravacao.Append;
      LGravacao.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LIBTRF', VS_strCodEmp);
    End
    Else
      LGravacao.Edit;

    LGravacao.FieldByName('TRF_SEQRCX').AsString := ADataset.FieldByName('AUTOINCREM').AsString;
    LGravacao.FieldByName('TRF_OPERCX').AsString := ADataset.FieldByName('RCX_CODOPE').AsString;
    LGravacao.FieldByName('TRF_MODALI').AsString := ADataset.FieldByName('MODALIDADE').AsString;

    If Not ADadosTrfLib.MovimentacaoBancaria.IsEmpty Then
      LGravacao.FieldByName('TRF_DOCBAN').AsString := ADadosTrfLib.MovimentacaoBancaria;

    LGravacao.FieldByName('TRF_VALTRF').AsFloat := ADataset.FieldByName('VALOR').AsFloat;
    LGravacao.FieldByName('REF_VALAJU').AsFloat := ADadosTrfLib.ValorAjuste;
    LGravacao.FieldByName('TRF_STATUS').AsString := AStatus;
    LGravacao.FieldByName('TRF_OPELIB').AsString := strLoginUsuarioLogado;
    LGravacao.FieldByName('TRF_DTALIB').AsDateTime := untFuncoesSimples.fRetDtaHraServidor;

    If Not ADadosTrfLib.MotivoRecusa.IsEmpty Then
      LGravacao.FieldByName('TRF_MOTIVO').AsString := ADadosTrfLib.MotivoRecusa;

    If Not ADadosTrfLib.MovimentacaoBancariaDebito.IsEmpty Then
      LGravacao.FieldByName('TRF_BANDEB').AsString := ADadosTrfLib.MovimentacaoBancariaDebito;

    If Not ADadosTrfLib.MovimentacaoBancariaCredito.IsEmpty Then
      LGravacao.FieldByName('TRF_BANCRE').AsString := ADadosTrfLib.MovimentacaoBancariaCredito;

    If Not ADadosTrfLib.AutoIncremCaixa.IsEmpty Then
      LGravacao.FieldByName('TRF_RCXLAN').AsString := ADadosTrfLib.AutoIncremCaixa;

    LGravacao.Post;

    Result := True;
  Finally
    FreeAndNil(LGravacao);
  End;
end;

function TLiberacaoDeCaixas.InserirRegistroCadRcxx(ADataset: TDataSet;
  AHistorico: String; ADivergencia: Boolean = False): String;
  Var
    LDinheiro,
    LOrdemPagamento,
    LMultiplicacao: Double;

    LEspecie: String;

    LDataCaixa: TDateTime;
begin
  LDinheiro := 0;
  LOrdemPagamento := 0;
  LMultiplicacao := -1;

  If ADataset.FieldByName('MODALIDADE').AsString = 'Ordem Pag.' Then
    LOrdemPagamento := ADataset.FieldByName('VALOR').AsFloat
  Else
    LDinheiro := ADataset.FieldByName('VALOR').AsFloat;

  LEspecie := 'LC';
  If Not ADivergencia THen
  Begin
    If ADataset.FieldByName('VALOR').AsFloat > 0 Then
      LEspecie := 'LD';
  End
  Else
  Begin
    If ADataset.FieldByName('VALOR').AsFloat < 0 Then
      LEspecie := 'LD';

    LMultiplicacao := 1;
  End;

  TResumoDeCaixa.Create('C').fNecessitaFecharCaixa(False,
                                                   LDataCaixa,
                                                   ADataset.FieldByName('RCX_CODCAX').AsString,
                                                   False,
                                                   ADataset.FieldByName('RCX_CODEMP').AsString);

  Try
    Result := '';

    If Not fGravaCadRcx(Result,                                                       //autoincrem
                        '',                                                           //Código do Cliente
                        ADataset.FieldByName('RCX_CODOPE').AsString,                  //Operador
                        '',                                                           //Documento
                        LEspecie,                                                     //Espécie
                        ADataset.FieldByName('RCX_CODEMP').AsString,                  //Empresa
                        LDataCaixa,                                                   //Data de Cadastro
                        fTime(),                                                      //Hora de Cadastro
                        '',                                                           //Duplicata {**Req. 97805**20/04/2018**WS**}
                        '',                                                           //Parcela   {**Req. 97805**20/04/2018**WS**}
                        AHistorico,                                                   //Descrição
                        '',                                                           //Juros / Dessconto
                        '',                                                           //Identificação de Fechamento
                        '',                                                           //Forma de Pagamento
                        ADataset.FieldByName('VALOR').AsFloat * LMultiplicacao,       //Valor do Documento
                        0.00,                                                         //Desconto Recebido
                        0.00,                                                         //Juros Recebido
                        LDinheiro * LMultiplicacao,                                   //Valor em dinheiro
                        0.00,                                                         //Valor em Cheque à Vista
                        0.00,                                                         //Valor em Cheque Pré
                        0.00,                                                         //Valor em Cartão
                        LOrdemPagamento * LMultiplicacao,                             //Valor em Ordem de Pagamento
                        0.00,                                                         //Valor de Crédito de Cliente
                        0.00,                                                         //Valor em Financiamento
                        0.0,                                                          //Valor em outras modalidades
                        0.0,                                                          //Valor de venda a prazo
                        '',                                                           //Num. do Romaneio
                        FRcxCon,                                                      //Sequencial de Controle
                        0,                                                            //Sequencial de Baixa (Duplicata)
                        fCfgSisL('SQFCRX'),                                           //Sequencial de Fechamento parcial de caixa
                        ADataset.FieldByName('RCX_CODEMP').AsString,                  //Empresa da duplicata
                        '',                                                           //Motivo do desconto
                        1,                                                            //Identificação do Caixa
                        0.00,
                        0.00,
                        0.00,
                        0.00,
                        0.00,
                        'N',
                        '',
                        ADataset.FieldByName('RCX_CODCAX').AsString,
                        '',
                        0.00,
                        False,
                        0.00,
                        '',
                        0,
                        'N') Then                                                     //Recebido por Pix
      Raise Exception.Create('Não foi possível gravar o registro no caixa.');
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

function TLiberacaoDeCaixas.InserirRegistroMovBan(
  ADataSetMovimentacaoBancaria: TDataset; ATipoLancamento, AModalidade,
  ADescricao, ANovoPortador: String): String;
  Var
    LBanTrf: TBanTrfDS;

    LListaBanTrf: TList<TLogBanDS>;

    LPortadorDescricao: String;
begin
  If ANovoPortador.IsEmpty Then
    ANovoPortador := ADataSetMovimentacaoBancaria.FieldByName('CTB_CODPOR').AsString;

  Try
    LPortadorDescricao := ANovoPortador + '-' + fRetNomPortador(ANovoPortador);

    LBanTrf := TBanTrfDS.Create;
    LBanTrf.strCodOpe := strLoginUsuarioLogado;
    LBanTrf.strCodEmp := ADataSetMovimentacaoBancaria.FieldByName('CTB_CODEMP').AsString;
    LBanTrf.strDescri := ADescricao.Replace('[PORTADOR]', LPortadorDescricao);
    LBanTrf.fltValDoc := fFormataFloat(ADataSetMovimentacaoBancaria.FieldByName('CTB_VALLAN').AsFloat, 2);
    LBanTrf.fltDinRec := 0.00;
    LBanTrf.fltChqAvi := 0.00;
    LBanTrf.fltChqPre := 0.00;
    LBanTrf.fltCarRec := 0.00;
    LBanTrf.fltOrdRec := 0.00;
    LBanTrf.fltValFin := 0.00;

    If MatchStr(AModalidade, ['Divergência', 'Dinheiro']) Then
      LBanTrf.fltDinRec := fFormataFloat(ADataSetMovimentacaoBancaria.FieldByName('CTB_VALLAN').AsFloat, 2)
    Else If MatchStr(AModalidade, ['Ordem Pag.']) Then
      LBanTrf.fltOrdRec := fFormataFloat(ADataSetMovimentacaoBancaria.FieldByName('CTB_VALLAN').AsFloat, 2)
    Else If MatchStr(AModalidade, ['Cartão']) Then
      LBanTrf.fltCarRec := fFormataFloat(ADataSetMovimentacaoBancaria.FieldByName('CTB_VALLAN').AsFloat, 2)
    Else If MatchStr(AModalidade, ['Chqeue a Vista']) Then
      LBanTrf.fltChqAvi := fFormataFloat(ADataSetMovimentacaoBancaria.FieldByName('CTB_VALLAN').AsFloat, 2)
    Else If MatchStr(AModalidade, ['Chqeue Pré']) Then
      LBanTrf.fltChqPre := fFormataFloat(ADataSetMovimentacaoBancaria.FieldByName('CTB_VALLAN').AsFloat, 2);

    LListaBanTrf := TList<TLogBanDS>.Create;
    LListaBanTrf.Add(LBanTrf);

    {*******************************************}
    {* REALIZA GRAVAÇÃO DO MOVBAN              *}
    {****************************************AF*}
    Result := fGravaMovBan(ADataSetMovimentacaoBancaria.FieldByName('CTB_CODCTA').AsString, // Centro de Custo
                           ANovoPortador,                                                   // Portador da Baixa
                           strLoginUsuarioLogado,                                           // Operador da Baixa
                           VS_Date,                                                         // Data do Lançamento
                           fTime(),                                                         // Hora do Lançamento
                           '',                                                              // Numero do Documento
                           ATipoLancamento,                                                // Credito / Debito
                           ADataSetMovimentacaoBancaria.FieldByName('CTB_CODEMP').AsString,// Empresa da Baixa
                           ADataSetMovimentacaoBancaria.FieldByName('CTB_VALLAN').AsFloat, // Valor Do Lançamento
                           LBanTrf.strDescri,                                              // Histórico 1
                           '',                                                             // Histórico 2
                           '',                                                             // Cliente da Duplicata
                           '',                                                             // Fornecedor da Duplicata
                           '',                                                             // Número da Duplicata
                           0,                                                              // Sequencial de Baixa
                           'A',                                                            // Parcela da Duplicata
                           ADataSetMovimentacaoBancaria.FieldByName('CTB_CODEMP').AsString,// Empresa da Duplicata
                           '',                                                             // Série
                           '',                                                             // Codigo do Evento
                           '',                                                             // Documento da Baixa
                           Nil,                                                            // Log Bancário
                           0,                                                             // Sequencial de Transf.
                           0,
                           '',
                           '',
                           '',
                           '',
                           '',
                           '',
                           1,
                           True,
                           LListaBanTrf,
                           '',
                           'S');

    FreeAndNil(LBanTrf);
    FreeAndNil(LListaBanTrf);

    If Result.IsEmpty Then
      Raise Exception.Create('Ocorreu um erro na gravação do MOVBAN da transferência da Liberação de Caixas!');
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

function TLiberacaoDeCaixas.LiberaDocumentosVinculados(
  ADataset: TDataset): Boolean;
  Var
    LLiberacao: TUniQuery;

    LSQL,
    LCampo: String;
begin
  LSQL := 'SELECT AUTOINCREM, MCA_TRFLIB FROM MOVCAR ' +
          'WHERE MCA_EMPRCX="' + ADataset.FieldByName('RCX_CODEMP').AsString + '" ' +
          '  AND MCA_SEQTRF=' + ADataset.FieldByName('RCX_SEQCON').AsString +
          '  AND MCA_CODCAX="' + ADataset.FieldByName('RCX_CODCAX').AsString + '" ';

  LCampo := 'MCA_TRFLIB';

  If MatchStr(ADataset.FieldByName('MODALIDADE').AsString, ['Cheque a Vista', 'Cheque Pré']) Then
  Begin
    LSQL := 'SELECT AUTOINCREM, CHQ_TRFLIB FROM CADCHQ ' +
            'WHERE CHQ_EMPRCX="' + ADataset.FieldByName('RCX_CODEMP').AsString + '" ' +
            '  AND CHQ_SEQTRF=' + ADataset.FieldByName('RCX_SEQCON').AsString +
            '  AND CHQ_CODCAX="' + ADataset.FieldByName('RCX_CODCAX').AsString + '" ';

    If ADataset.FieldByName('MODALIDADE').AsString = 'Cheque a Vista' Then
      LSQL := LSQL + '  AND CHQ_DTACAD=CHQ_DTAVEN'
    Else
      LSQL := LSQL + '  AND CHQ_DTACAD<>CHQ_DTAVEN';

    LCampo := 'CHQ_TRFLIB';
  End;

  Try
    LLiberacao := fCriaQuery;
    LLiberacao.SQL.Text := LSQL;

    LLiberacao.Open;

    While Not LLiberacao.Eof Do
    Begin
      LLiberacao.Edit;
      LLiberacao.FieldByName(LCampo).AsString := 'S';
      LLiberacao.Post;

      If MatchStr(ADataset.FieldByName('MODALIDADE').AsString, ['Cheque a Vista', 'Cheque Pré']) Then
        untLogChq.GravaLogChq(LLiberacao.FieldByName('AUTOINCREM').AsString,
                             'ACEITE LIBERAÇÃO DE CAIXAS',
                             'frmRcxLiberacaoDeCaixas')
      Else
        untLogMca.GravaLogMca(LLiberacao.FieldByName('AUTOINCREM').AsString,
                             'ACEITE LIBERAÇÃO DE CAIXAS',
                             'frmRcxLiberacaoDeCaixas');

      LLiberacao.Next;
    End;

    Result := True;
  Finally
    FreeAndNil(LLiberacao);
  End;
end;

function TLiberacaoDeCaixas.LiberaMovimentacaoBancaria(
  AMovimentacaoBancaria, ACodigoEmpresa: String): Boolean;
  Var
    LAtualiza: TUniQuery;
begin
  LAtualiza := fCriaQuery;

  Try
    LAtualiza.SQL.Text := 'UPDATE MOVBAN ' +
                          'SET CTB_TRFLIB="S" ' +
                          'WHERE CTB_SEQLAN="' + AMovimentacaoBancaria + '" ' +
                          '  AND CTB_CODEMP="' + ACodigoEmpresa + '"';

    LAtualiza.ExecSQL;

    Result := LAtualiza.RowsAffected > 0;
  Finally
    FreeAndNil(LAtualiza);
  End;
end;

function TLiberacaoDeCaixas.PedePortadorParaTransacao(
  ADataset: TDataset): String;
  Var
    LSelecionaPortadorLiberacao: TfrmRcxSelecionaPortadorLiberacao;
begin
  Result := '';

  Try
    pCriarFormularios(TfrmRcxSelecionaPortadorLiberacao, LSelecionaPortadorLiberacao);
    LSelecionaPortadorLiberacao.Modalidade := ADataset.FieldByName('MODALIDADE').AsString;
    LSelecionaPortadorLiberacao.Valor := ADataset.FieldByName('VALOR').AsFloat;
    LSelecionaPortadorLiberacao.EmpresaLancamento := ADataset.FieldByName('RCX_CODEMP').AsString;

    LSelecionaPortadorLiberacao.ShowModal;

    If LSelecionaPortadorLiberacao.ModalResult = mrOk Then
      Result := LSelecionaPortadorLiberacao.edtCodigoPortador.Text;
  Finally
    FreeAndNil(LSelecionaPortadorLiberacao);
  End;
end;

function TLiberacaoDeCaixas.RealizaLiberacaoDeTolerancia(ANovoValorAjuste: Double;
                                                         ACodigoCaixa: String): Boolean;
begin
  Result := True;

  If Not FUsaControleDivergencias Then
    Exit;

  FLiberacao.Clear;
  FLiberacao.objMsgLibera.pAddTexto('Permitir ajustar o fechamento de caixa com divergência de valores.');
  FLiberacao.objMsgLibera.pAddTexto('Liberação de Caixas.');
  FLiberacao.objMsgLibera.pAddTexto('Código do caixa: ' + ACodigoCaixa);
  FLiberacao.objMsgLibera.pAddTexto('');
  FLiberacao.objMsgRemota.pAddTexto('Lançamento de acerto: ' + FormatFloat(',0.00', ANovoValorAjuste * (-1)));

  FLiberacao.strDirAce := 'LIBLANRCXDIV';
  FLiberacao.strMsgSen := 'Permitir ajustar o fechamento de caixa com divergência de valores.';
  FLiberacao.strCodOpe := strLoginUsuarioLogado;
  FLiberacao.strCodDig := strLoginUsuarioLogado;

  Result := FLiberacao.fLibera;
end;

function TLiberacaoDeCaixas.RecusarModalidade(ADataset: TDataset): Boolean;
  Var
    LMotivoRecusa,
    LAutoIncremCaixa,
    LMovimentacaoBancariaDebito: String;

    LDataSetMovimentacaoBancaria: TUniClientDataset;

    LDadosTrfLib: TDadosTrfLib;
begin
  Try
    LDataSetMovimentacaoBancaria := RetornaMovimentacaoBancariaLancamento(ADataset);

    LMotivoRecusa := DigitarMotivoRecusa(ADataset);

    Result := Not LMotivoRecusa.IsEmpty;
    If Not Result Then
      Exit;

    LMovimentacaoBancariaDebito := '';

    FRcxCon := StrToInt(fRetRcxCon);

    fStartTransaction;

    If Result Then
    Begin
      Result := LiberaMovimentacaoBancaria(LDataSetMovimentacaoBancaria.FieldByName('CTB_SEQLAN').AsString,
                                           LDataSetMovimentacaoBancaria.FieldByName('CTB_CODEMP').AsString);

      If Not Result Then
        Raise Exception.Create('Não foi possível encontrar a Movimentação Bancária da transferência.');

      //Débito no portador original
      LMovimentacaoBancariaDebito := InserirRegistroMovBan(LDataSetMovimentacaoBancaria,
                                                           'D',
                                                           ADataset.FieldByName('MODALIDADE').AsString,
                                                           'TF RECUSA CAIXA (' + LeftStr(ADataset.FieldByName('MODALIDADE').AsString, 3).ToUpper + ') - [PORTADOR]');

      //Crédito no Caixa do Retorno do Valor
      LAutoIncremCaixa := InserirRegistroCadRcxx(ADataset,
                                                 'TF ' + FormatDateTime('dd/mm', ADataset.FieldByName('RCX_DTACAD').AsDateTime) + ' RECUSADA- ' + LMotivoRecusa);

      LDadosTrfLib.MovimentacaoBancaria := LDataSetMovimentacaoBancaria.FieldByName('CTB_SEQLAN').AsString;
      LDadosTrfLib.MotivoRecusa := LMotivoRecusa;
      LDadosTrfLib.ValorAjuste := 0.00;
      LDadosTrfLib.MovimentacaoBancariaDebito := LMovimentacaoBancariaDebito;
      LDadosTrfLib.AutoIncremCaixa := LAutoIncremCaixa;

      Result := GravarTabelaTrfLib(ADataset,
                                   'RECUSADO',
                                   LDadosTrfLib);
    End;

    If Result Then
    Begin
      fCommit;

      ADataset.Edit;
      ADataset.FieldByName('RCX_STATUS').AsString := 'RECUSADO';
      ADataset.FieldByName('TRF_OPELIB').AsString := strLoginUsuarioLogado + '-' + fRetNomeOperador(strLoginUsuarioLogado);
      ADataset.FieldByName('TRF_DTALIB').AsDateTime := untFuncoesSimples.fRetDtaHraServidor;
      ADataset.FieldByName('TRF_MOTIVO').AsString := LMotivoRecusa;
      ADataset.Post;

      fMensagem('ATENÇÃO', 'Recusa da modalidade ' + ADataset.FieldByName('MODALIDADE').AsString +
                           ' realizada com sucesso.', ['&Ok']);
    End
    Else
      fRollBack;

    FreeAndNil(LDataSetMovimentacaoBancaria);
  Except
    On E: Exception Do
    Begin
      fRollBack;

      Raise Exception.Create('Ocorreu um erro ao recusar a modalidade ' + ADataset.FieldByName('MODALIDADE').AsString + '.' + #13 +
                             'Erro gerado: ' + E.Message);
    End;
  End;
end;

function TLiberacaoDeCaixas.RecusarModalidadeDivergencia(
  ADataset: TDataset): Boolean;
  Var
    LMotivoRecusa,
    LAutoIncremCaixa: String;

    LDadosTrfLib: TDadosTrfLib;
begin
  Try
    LMotivoRecusa := DigitarMotivoRecusa(ADataset);

    Result := Not LMotivoRecusa.IsEmpty;
    If Not Result Then
      Exit;

    FRcxCon := StrToInt(fRetRcxCon);

    fStartTransaction;

    If Result Then
    Begin
      //Crédito no Caixa do Retorno do Valor
      LAutoIncremCaixa := InserirRegistroCadRcxx(ADataset,
                                                 'DIV ' + FormatDateTime('dd/mm', ADataset.FieldByName('RCX_DTACAD').AsDateTime) + ' RECUSADA- ' + LMotivoRecusa,
                                                 True);

      LDadosTrfLib.MovimentacaoBancaria := '';
      LDadosTrfLib.MotivoRecusa := LMotivoRecusa;
      LDadosTrfLib.ValorAjuste := 0.00;
      LDadosTrfLib.AutoIncremCaixa := LAutoIncremCaixa;

      Result := GravarTabelaTrfLib(ADataset,
                                   'RECUSADO',
                                   LDadosTrfLib);
    End;

    If Result Then
    Begin
      fCommit;

      ADataset.Edit;
      ADataset.FieldByName('RCX_STATUS').AsString := 'RECUSADO';
      ADataset.FieldByName('TRF_OPELIB').AsString := strLoginUsuarioLogado + '-' + fRetNomeOperador(strLoginUsuarioLogado);
      ADataset.FieldByName('TRF_DTALIB').AsDateTime := untFuncoesSimples.fRetDtaHraServidor;
      ADataset.FieldByName('TRF_MOTIVO').AsString := LMotivoRecusa;
      ADataset.Post;

      fMensagem('ATENÇÃO', 'Recusa da modalidade ' + ADataset.FieldByName('MODALIDADE').AsString +
                           ' realizada com sucesso.', ['&Ok']);
    End
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollBack;

      Raise Exception.Create('Ocorreu um erro ao recusar a modalidade ' + ADataset.FieldByName('MODALIDADE').AsString + '.' + #13 +
                             'Erro gerado: ' + E.Message);
    End;
  End;
end;

function TLiberacaoDeCaixas.RetornaMovimentacaoBancariaDivergencia(
  ADataset: TDataset): TUniClientDataSet;
  Var
    LConsulta: TUniQuery;
begin
  Try
    LConsulta := fCriarQuery('SELECT * FROM MOVBAN WHERE FALSE');
    LConsulta.Open;

    Result := fCriaClientDatSet(LConsulta);
    Result.Open;

    Result.Append;
    Result.FieldByName('CTB_VALLAN').AsFloat := Abs(ADataset.FieldByName('VALOR').AsFloat);
    Result.FieldByName('CTB_CODCTA').AsString := fConverteCentroCusto(fCfgSis('CTATRA'));
    Result.FieldByName('CTB_CODEMP').AsString := ADataset.FieldByName('RCX_CODEMP').AsString;
    Result.Post;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

function TLiberacaoDeCaixas.RetornaMovimentacaoBancariaLancamento(
  ADataset: TDataset): TUniClientDataSet;
  Var
    LConsulta: TUniQuery;

    LTextoModalidade: String;
begin
  LConsulta := fCriaQuery;

  LTextoModalidade := '"TF CAIXA%%(DIN)%"';
  If ADataset.FieldByName('MODALIDADE').AsString = 'Cheque a Vista' Then
    LTextoModalidade := '"TF CAIXA%%(CHV)%"'
  Else If ADataset.FieldByName('MODALIDADE').AsString = 'Cheque Pré' Then
    LTextoModalidade := '"TF CAIXA%%(CHP)%"'
  Else If ADataset.FieldByName('MODALIDADE').AsString = 'Cartão' Then
    LTextoModalidade := '"TF CAIXA%%(CAR)%"'
  Else If ADataset.FieldByName('MODALIDADE').AsString = 'Ordem Pag.' Then
    LTextoModalidade := '"TF CAIXA%%(OP%) %" OR CTB_HIST01 LIKE "TF CAIXA%%(ORD%) %"';

  Try
    LConsulta.SQL.Text := 'SELECT ' +
                          '  * ' +
                          'FROM MOVBAN ' +
                          'WHERE CTB_CODEMP = "' + ADataset.FieldByName('RCX_CODEMP').AsString + '" ' +
                          '  AND CTB_SEQTRF = ' + ADataset.FieldByName('RCX_SEQCON').AsString + ' ' +
                          '  AND CTB_CODOPE = "' + ADataset.FieldByName('RCX_CODOPE').AsString + '" ' +
                          '  AND CTB_DTALAN >= "' + FormatDateTime('yyyy/mm/dd', ADataset.FieldByName('RCX_DTACAD').AsDateTime) + '" ' +
                          '  AND (CTB_HIST01 LIKE ' + LTextoModalidade + ' )' +
                          'ORDER BY CTB_DTALAN ' +
                          'LIMIT 1 ';

    LConsulta.Open;

    Result := fCriaClientDatSet(LConsulta);
    Result.First;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

function TLiberacaoDeCaixas.RetornaSQLLancamentos(
  AFiltros: TFiltrosTelaLiberacao): String;
begin
  Result := 'SELECT X.*,                 ' +
            '  "D" AS RCX_MARDES,        ' +
            ' 0    AS RCX_QTDSEL,        ' +
            ' 0.00 AS RCX_DOCSEL,        ' +
            ' 0.00 AS RCX_DIVSEL,        ' +
            ' CONCAT(C.CAX_CODCAX, "-",  ' +
            '  C.CAX_DESCRI) AS CAIXA,   ' +
            ' CONCAT(O.OPE_CODOPE, "-",  ' +
            '  O.OPE_NOMOPE) AS OPERADOR,' +
            ' IF(RCX_OPELIB IS NOT NULL, ' +
            ' "LIBERADO", "PENDENTE") AS ' +
            '          RCX_STATUS,       ' +
            ' CONCAT(E.EMP_CODEMP, "-", E.EMP_NOMEMP) AS EMPRESA, ' +
            ' 0.00 AS RCX_VALTRA         ' +
            'FROM CADRCXX X              ' +
            'JOIN CADEMP E ON E.EMP_CODEMP=X.RCX_CODEMP ' +
            'LEFT JOIN CADCAX C ON C.CAX_CODCAX=X.RCX_CODCAX ' +
            '                  AND C.CAX_CODEMP=X.RCX_CODEMP ' +
            'LEFT JOIN CADOPE O ON O.OPE_CODOPE=X.RCX_CODOPE ' +
            'WHERE X.RCX_ESPDOC = "FC"   ' +
            '  AND X.RCX_CODEMP IN (' + AFiltros.Empresas + ') ' +
            '  AND RCX_DTACAD BETWEEN "' + FormatDateTime('yyyy-mm-dd', AFiltros.DataInicial) + '" ' +
            '                     AND "' + FormatDateTime('yyyy-mm-dd', AFiltros.DataFinal) + '" ';

  If Not AFiltros.Operador.IsEmpty Then
    Result := Result + '  AND RCX_CODOPE = "' + AFiltros.Operador + '" ';

  If Not AFiltros.CodigoCaixa.IsEmpty Then
    Result := Result + '  AND RCX_CODCAX = "' + AFiltros.CodigoCaixa + '" '
  Else
    Result := Result + '  AND RCX_CODCAX IS NOT NULL ';

  Case AFiltros.Fechamento Of
    0: Result := Result + ' AND RCX_VALDIV=0.00 ';
    1: Result := Result + ' AND RCX_VALDIV>0.00 ';
    2: Result := Result + ' AND RCX_VALDIV<0.00 ';
  End;

  Case AFiltros.Status Of
    0: Result := Result + ' AND RCX_OPELIB IS NOT NULL ';
    1: Result := Result + ' AND RCX_OPELIB IS NULL     ';
  End;

  Result := Result + ' ORDER BY RCX_DTACAD, RCX_DTAGRV ';
end;

function TLiberacaoDeCaixas.RetornaSQLTransferencias(AFiltros: TFiltrosTelaLiberacao): String;
  Var
    LSQLPadrao,
    LSQLSemPix,

    LSQLDinheiro,
    LSQLCartao,
    LSQLChequeAVista,
    LSQLChequePre,
    LSQLOrdemPagamento,
    LSQLDivergencia: String;
begin
  LSQLPadrao := 'SELECT X.RCX_SEQCON, ' +
                '       X.RCX_CODOPE, ' +
                '       X.RCX_DTACAD, ' +
                '       X.RCX_CODEMP, ' +
                '       X.RCX_CODCAX, ' +
                '       X.AUTOINCREM, ' +
                '       [TEXTO_MODALIDADE] AS MODALIDADE, ' +
                '       SUM([CAMPO_MODALIDADE]) AS VALOR, ' +
                '       MIN(X.RCX_DTAGRV) AS RCX_DTAGRV, ' +
                ' IF(T.TRF_STATUS IS NOT NULL, ' +
                ' T.TRF_STATUS, "PENDENTE") AS ' +
                '          RCX_STATUS, ' +
                ' IF(T.TRF_STATUS IS NOT NULL, ' +
                ' CONCAT(T.TRF_OPELIB, "-", OL.OPE_NOMOPE), NULL) AS ' +
                '          TRF_OPELIB, ' +
                ' T.TRF_DTALIB, ' +
                ' T.TRF_MOTIVO, ' +
                ' 0.00 AS RCX_VALTRA, ' +
                ' 0.00 AS VALORSELECIONADO, ' +
                ' CAST(" " AS CHAR(20)) AS AUTOINCREM_FEC, ' +
                ' " " AS BOTAO ' +
                'FROM CADRCXX X ' +
                'LEFT JOIN CADCAX C ON C.CAX_CODCAX=X.RCX_CODCAX ' +
                '                  AND C.CAX_CODEMP=X.RCX_CODEMP ' +
                'LEFT JOIN CADOPE O ON O.OPE_CODOPE=X.RCX_CODOPE ' +
                'LEFT JOIN LIBTRF T ON T.TRF_SEQRCX=X.AUTOINCREM ' +
                '                  AND T.TRF_OPERCX=X.RCX_CODOPE ' +
                '                  AND T.TRF_MODALI=[TEXTO_MODALIDADE] ' +
                'LEFT JOIN CADOPE OL ON OL.OPE_CODOPE=T.TRF_OPELIB ';

  Result := LSQLPadrao.Replace('[TEXTO_MODALIDADE]', '"Nenhum"')
                      .Replace('[CAMPO_MODALIDADE]', 'RCX_DINREC') + ' WHERE FALSE ';

  LSQLPadrao := LSQLPadrao + 'WHERE RCX_DTACAD BETWEEN "' + FormatDateTime('yyyy-mm-dd', AFiltros.DataInicial) + '" ' +
                             '  AND "' + FormatDateTime('yyyy-mm-dd', AFiltros.DataFinal) + '" ' +
                             '  AND X.RCX_ESPDOC = "TF"   ' +
                             '  AND X.RCX_CODEMP IN (' + AFiltros.Empresas + ') ' +
                             '  AND X.RCX_LANFEC = "S" ' +
                             '  AND [CAMPO_MODALIDADE] < 0 ' +
                             '  AND X.RCX_TFCANC="N" [SEM_PIX]';

  LSQLSemPix := '  AND (X.RCX_RECPIX = "N" OR ' +
                '      (SELECT COUNT(AUTOINCREM) ' +
                '       FROM MOVPIX M ' +
                '       WHERE M.MPX_CODEMP=X.RCX_CODEMP ' +
                '         AND M.MPX_DTAREC=X.RCX_DTACAD ' +
                '         AND M.MPX_SEQTRF=X.RCX_SEQCON) = 0) ';

  If Not AFiltros.CodigoCaixa.IsEmpty Then
    LSQLPadrao := LSQLPadrao + '  AND RCX_CODCAX = "' + AFiltros.CodigoCaixa + '" '
  Else
    LSQLPadrao := LSQLPadrao + '  AND RCX_CODCAX IS NOT NULL ';

  Case AFiltros.Status Of
    0: LSQLPadrao := LSQLPadrao + ' AND T.TRF_STATUS IS NOT NULL ';
    1: LSQLPadrao := LSQLPadrao + ' AND T.TRF_STATUS IS NULL     ';
  End;

  LSQLPadrao := LSQLPadrao + 'GROUP BY X.RCX_SEQCON, ' +
                             '         X.RCX_CODOPE, ' +
                             '         X.RCX_DTACAD, ' +
                             '         X.RCX_CODEMP, ' +
                             '         X.RCX_CODCAX  ';

  LSQLDinheiro := ' UNION ALL ' +
                  LSQLPadrao.Replace('[TEXTO_MODALIDADE]', '"Dinheiro"')
                            .Replace('[CAMPO_MODALIDADE]', 'X.RCX_DINREC');

  LSQLCartao := ' UNION ALL ' +
                LSQLPadrao.Replace('[TEXTO_MODALIDADE]', '"Cartão"')
                          .Replace('[CAMPO_MODALIDADE]', 'X.RCX_CARREC');

  LSQLChequeAVista := ' UNION ALL ' +
                      LSQLPadrao.Replace('[TEXTO_MODALIDADE]', '"Cheque a Vista"')
                                .Replace('[CAMPO_MODALIDADE]', 'X.RCX_CHQAVI');

  LSQLChequePre := ' UNION ALL ' +
                   LSQLPadrao.Replace('[TEXTO_MODALIDADE]', '"Cheque Pré"')
                             .Replace('[CAMPO_MODALIDADE]', 'X.RCX_CHQPRE');

  LSQLOrdemPagamento := ' UNION ALL ' +
                        LSQLPadrao.Replace('[TEXTO_MODALIDADE]', '"Ordem Pag."')
                                  .Replace('[CAMPO_MODALIDADE]', 'X.RCX_ORDREC')
                                  .Replace('[SEM_PIX]', LSQLSemPix);

  LSQLDivergencia := ' UNION ALL ' +
                     LSQLPadrao.Replace('[TEXTO_MODALIDADE]', '"Divergência"')
                               .Replace('[CAMPO_MODALIDADE] < 0', '[CAMPO_MODALIDADE] <> 0')
                               .Replace('[CAMPO_MODALIDADE]', 'X.RCX_VALDIV')
                               .Replace('X.RCX_ESPDOC = "TF"', 'X.RCX_ESPDOC = "FC"')
                               .Replace('AND X.RCX_LANFEC = "S"', EmptyStr)
                               .Replace('CAST(" " AS CHAR(20)) AS AUTOINCREM_FEC', 'X.AUTOINCREM AS AUTOINCREM_FEC')
                               .Replace('GROUP BY X.RCX_SEQCON', 'GROUP BY X.AUTOINCREM');

  If FExibeDinheiro Then
    Result := Result + LSQLDinheiro;

  If FExibeCartao Then
    Result := Result + LSQLCartao;

  If FExibeChequeAVista Then
    Result := Result + LSQLChequeAVista;

  If FExibeChequePre Then
    Result := Result + LSQLChequePre;

  If FExibeOrdemPagamento Then
    Result := Result + LSQLOrdemPagamento;

  If FExibeDivergencia Then
    Result := Result + LSQLDivergencia;

  Result := Result + ' ORDER BY RCX_DTAGRV, ' +
                     '          RCX_SEQCON, ' +
                     '          RCX_DTACAD, ' +
                     '          RCX_CODEMP, ' +
                     '          RCX_CODCAX, ' +
                     '          RCX_CODOPE, ' +
                     '          MODALIDADE  ';

  Result := Result.Replace('[SEM_PIX]', EmptyStr);
end;

function TLiberacaoDeCaixas.RetornaSQLTransferenciasFechamento(
  AAutoIncremFechamento: String): String;
  Var
    LFechamentos: TUniQuery;

    LSQLPadrao,
    LSQLSemPix,

    LSQLDinheiro,
    LSQLCartao,
    LSQLChequeAVista,
    LSQLChequePre,
    LSQLOrdemPagamento,
    LSQLDivergencia: String;
begin
  Try
    LFechamentos := fCriaQuery;
    LFechamentos.SQL.Text := 'SELECT X.RCX_DTAGRV AS FECHAMENTO, '+
                             '       X.RCX_CODEMP, ' +
                             '       X.RCX_DTACAD, ' +
                             '       X.RCX_CODCAX, ' +
                             '       (SELECT RCX_DTAGRV ' +
                             '        FROM CADRCXX ' +
                             '        WHERE RCX_DTACAD = X.RCX_DTACAD ' +
                             '          AND RCX_CODEMP = X.RCX_CODEMP ' +
                             '          AND RCX_CODCAX = X.RCX_CODCAX ' +
                             '          AND RCX_ESPDOC = "FC" ' +
                             '          AND RCX_DTAGRV < X.RCX_DTAGRV' +
                             '          ORDER BY RCX_DTAGRV DESC ' +
                             '          LIMIT 1) AS FECHAMENTOANTERIOR ' +
                             'FROM CADRCXX X ' +
                             'WHERE AUTOINCREM="' + AAutoIncremFechamento + '"';
    LFechamentos.Open;


    LSQLPadrao := 'SELECT X.RCX_SEQCON, ' +
                '       X.RCX_CODOPE, ' +
                '       X.RCX_DTACAD, ' +
                '       X.RCX_CODEMP, ' +
                '       X.RCX_CODCAX, ' +
                '       X.AUTOINCREM, ' +
                '       [TEXTO_MODALIDADE] AS MODALIDADE, ' +
                '       SUM([CAMPO_MODALIDADE]) AS VALOR, ' +
                '       MIN(X.RCX_DTAGRV) AS RCX_DTAGRV, ' +
                ' IF(T.TRF_STATUS IS NOT NULL, ' +
                ' T.TRF_STATUS, "PENDENTE") AS ' +
                '          RCX_STATUS, ' +
                ' IF(T.TRF_STATUS IS NOT NULL, ' +
                ' CONCAT(T.TRF_OPELIB, "-", OL.OPE_NOMOPE), NULL) AS ' +
                '          TRF_OPELIB, ' +
                ' T.TRF_DTALIB, ' +
                ' T.TRF_MOTIVO, ' +
                ' 0.00 AS RCX_VALTRA, ' +
                ' 0.00 AS VALORSELECIONADO, ' +
                ' CAST(" " AS CHAR(20)) AS AUTOINCREM_FEC, ' +
                ' " " AS BOTAO ' +
                'FROM CADRCXX X ' +
                'LEFT JOIN CADCAX C ON C.CAX_CODCAX=X.RCX_CODCAX ' +
                '                  AND C.CAX_CODEMP=X.RCX_CODEMP ' +
                'LEFT JOIN CADOPE O ON O.OPE_CODOPE=X.RCX_CODOPE ' +
                'LEFT JOIN LIBTRF T ON T.TRF_SEQRCX=X.AUTOINCREM ' +
                '                  AND T.TRF_OPERCX=X.RCX_CODOPE ' +
                '                  AND T.TRF_MODALI=[TEXTO_MODALIDADE] ' +
                'LEFT JOIN CADOPE OL ON OL.OPE_CODOPE=T.TRF_OPELIB ';

    Result := LSQLPadrao.Replace('[TEXTO_MODALIDADE]', '"Nenhum"')
                        .Replace('[CAMPO_MODALIDADE]', 'RCX_DINREC') + ' WHERE FALSE ';

    LSQLPadrao := LSQLPadrao + 'WHERE RCX_DTACAD="' + FormatDateTime('yyyy-mm-dd', LFechamentos.FieldByName('RCX_DTACAD').AsDateTime) + '" ' +
                               '  AND RCX_DTAGRV BETWEEN "' + FormatDateTime('yyyy-mm-dd hh:mm:ss', LFechamentos.FieldByName('FECHAMENTOANTERIOR').AsDateTime) + '" ' +
                               '                     AND "' + FormatDateTime('yyyy-mm-dd hh:mm:ss', LFechamentos.FieldByName('FECHAMENTO').AsDateTime) + '" ' +
                               '  AND X.RCX_ESPDOC = "TF"   ' +
                               '  AND X.RCX_CODEMP = "' + LFechamentos.FieldByName('RCX_CODEMP').AsString + '" ' +
                               '  AND RCX_CODCAX = "' + LFechamentos.FieldByName('RCX_CODCAX').AsString + '" ' +
                               '  AND X.RCX_LANFEC = "S" ' +
                               '  AND T.TRF_STATUS IS NULL ' +
                               '  AND [CAMPO_MODALIDADE] < 0 ' +
                               '  AND X.RCX_TFCANC="N" [SEM_PIX]';

    LSQLSemPix := '  AND (X.RCX_RECPIX = "N" OR ' +
                  '      (SELECT COUNT(AUTOINCREM) ' +
                  '       FROM MOVPIX M ' +
                  '       WHERE M.MPX_CODEMP=X.RCX_CODEMP ' +
                  '         AND M.MPX_DTAREC=X.RCX_DTACAD ' +
                  '         AND M.MPX_SEQTRF=X.RCX_SEQCON) = 0) ';

    LSQLPadrao := LSQLPadrao + 'GROUP BY X.RCX_SEQCON, ' +
                               '         X.RCX_CODOPE, ' +
                               '         X.RCX_DTACAD, ' +
                               '         X.RCX_CODEMP, ' +
                               '         X.RCX_CODCAX  ';

    LSQLDinheiro := ' UNION ALL ' +
                    LSQLPadrao.Replace('[TEXTO_MODALIDADE]', '"Dinheiro"')
                              .Replace('[CAMPO_MODALIDADE]', 'X.RCX_DINREC');

    LSQLCartao := ' UNION ALL ' +
                  LSQLPadrao.Replace('[TEXTO_MODALIDADE]', '"Cartão"')
                            .Replace('[CAMPO_MODALIDADE]', 'X.RCX_CARREC');

    LSQLChequeAVista := ' UNION ALL ' +
                        LSQLPadrao.Replace('[TEXTO_MODALIDADE]', '"Cheque a Vista"')
                                  .Replace('[CAMPO_MODALIDADE]', 'X.RCX_CHQAVI');

    LSQLChequePre := ' UNION ALL ' +
                     LSQLPadrao.Replace('[TEXTO_MODALIDADE]', '"Cheque Pré"')
                               .Replace('[CAMPO_MODALIDADE]', 'X.RCX_CHQPRE');

    LSQLOrdemPagamento := ' UNION ALL ' +
                          LSQLPadrao.Replace('[TEXTO_MODALIDADE]', '"Ordem Pag."')
                                    .Replace('[CAMPO_MODALIDADE]', 'X.RCX_ORDREC')
                                    .Replace('[SEM_PIX]', LSQLSemPix);

    LSQLDivergencia := ' UNION ALL ' +
                       LSQLPadrao.Replace('[TEXTO_MODALIDADE]', '"Divergência"')
                                 .Replace('[CAMPO_MODALIDADE] < 0', '[CAMPO_MODALIDADE] <> 0')
                                 .Replace('[CAMPO_MODALIDADE]', 'X.RCX_VALDIV')
                                 .Replace('X.RCX_ESPDOC = "TF"', 'X.RCX_ESPDOC = "FC"')
                                 .Replace('AND X.RCX_LANFEC = "S"', EmptyStr)
                                 .Replace('CAST(" " AS CHAR(20)) AS AUTOINCREM_FEC', 'X.AUTOINCREM AS AUTOINCREM_FEC')
                                 .Replace('GROUP BY X.RCX_SEQCON', 'GROUP BY X.AUTOINCREM')
                                 .Replace('[SEM_PIX]', ' AND X.RCX_DTAGRV > "' + FormatDateTime('yyyy-mm-dd hh:mm:ss', LFechamentos.FieldByName('FECHAMENTOANTERIOR').AsDateTime) + '" ');

    Result := Result + LSQLDinheiro +
                       LSQLCartao +
                       LSQLChequeAVista +
                       LSQLChequePre +
                       LSQLOrdemPagamento +
                       LSQLDivergencia;

    Result := Result + ' ORDER BY RCX_DTAGRV, ' +
                       '          RCX_SEQCON, ' +
                       '          RCX_DTACAD, ' +
                       '          RCX_CODEMP, ' +
                       '          RCX_CODCAX, ' +
                       '          RCX_CODOPE, ' +
                       '          MODALIDADE  ';

    Result := Result.Replace('[SEM_PIX]', EmptyStr);
  Finally
    FreeAndNil(LFechamentos);
  End;
end;

end.
