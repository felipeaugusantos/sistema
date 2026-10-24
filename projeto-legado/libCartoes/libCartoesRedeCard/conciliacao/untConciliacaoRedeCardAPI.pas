unit untConciliacaoRedeCardAPI;

interface

Uses System.Classes, Vcl.Forms, System.Types, System.Sysutils, System.StrUtils,
     System.Variants, Data.DB, System.Math, System.Generics.Collections,

     Uni, UniClientDataSet, cxProgressBar, frxClass, frxDBSet,

     untRedeCardConciliacaoCartoes, untLibCartoesInterfacesTipos,
     untTRedeCardFuncoes, untTLibCartoesMovCar;

type

  TConciliacaoRedeCardAPI = class(TConciliacaoCartoes)
  private
    FCdsRegistrosMovimento : TUniClientDataSet; //Registros Movimentação cartão
    FCdsRegistrosPagamento : TUniClientDataSet; //Registros Conciliação Financeira
    FCdsRegistrosAjuste    : TUniClientDataSet; //Registros Ajustes
    LTolerancia: Double;
    SFiltroEstabelecimento : String;
    FConciliaPorRV : String;
    FUtilizaCashback: Boolean;
    FAjustesUnbookUtilizados: TList<TItensRelatorioCartoes>;

    class var FUtilizaConfirmacaoDeCartoes: String;

    procedure pCalculaPeriodoFiltro(ACdsBase : TUniClientDataSet);
    procedure pCriaDataSets;
    procedure pFiltraAjustesRedeCardAPI;

    function fGetTipoDeOperacao(ACodigoModalidade : String; ATotalParcelas : Integer) : String;
    function fProcessaRegistrosDebitoCredito(pgbStatus: TcxProgressBar): Boolean;
    function FinalizandoConciliacao(pgbStatus: TcxProgressBar): Boolean;
    function TemRegistrosImportados : Boolean;
    function Reabrir(AConfirma: Boolean): Boolean;
    function ConciliouRegistros: Boolean;
    procedure ValidaCartaoEncontrado(Var ABusca : Boolean;
                                     Var ADivergenciaCartao : String;
                                     AClient: TUniClientDataSet);
    procedure ValidaCartaoMarcado(Var ADivergenciaCartao : String);
    function PagamentoCashback(AIdPagamento, AEstabelecimento: String; AValorPagamento: Double): Boolean;
    procedure GerarAjusteCashback;
    function RetornaSqlVendas:String;
    function RetornaFiltroSqlVendas(APrefixo: String = ''):String;
    function RetornaTipoRegistro:String;
    function FiltraAjusteDeVendas(pgbStatus: TcxProgressBar): Boolean;
    function CartaoFazParteDessePagamento(Var AValorLiquidoPago:Double):Boolean;
    function RetornaValorLiquidoParcela: Double;
    function RetornaValorBrutoParcela: Double;
    function MarcarVendaComoConciliada: Boolean;
    procedure AjustaValorRecebidoComCancelamentoDeVendas;
    function RetornaInAutorizacaoFiltrar: String;
    function RetornaInNsuFiltrar: String;

    procedure AjustaTipoRegistroParaCartoesZerados(var ARegistroRelatorio: TItensRelatorioCartoes);
    procedure AjustaTipoRegistroParaVendaCancelada(var ARegistroRelatorio: TItensRelatorioCartoes);
    function ExisteAjusteDaVendaCancelada(ARegistroRelatorio: TItensRelatorioCartoes): Boolean;

    procedure FiltraCartoesBaixados;

    function fConciliaRedeCardAPI(pgbStatus: TcxProgressBar): Boolean;
  public
    function fConciliaCartoes: Boolean; override;
    Class procedure AtualizaConciliacaoPagamentoRedeCardAPI(ABaixa: Boolean; ACartao: TUniClientDataSet);
    Class procedure AtualizaConciliacaoAjustesRedeCardAPI(ABaixa: Boolean; ACartao: TUniClientDataSet);
    Class procedure MarcarAjusteVendaComoConciliado(ABaixa: Boolean; ACartao: TUniClientDataSet);
    Class procedure MarcarAjusteCashBackComoConciliado(ABaixa: Boolean; ACartao: TUniClientDataSet);
  end;

implementation

Uses untLibCartoesGravando, untLibCartoesFiltroInconsistencias,
     untTImportaVendasRedeCardOnline;

{ TConciliacaoRedeCardAPI }

function TConciliacaoRedeCardAPI.fConciliaRedeCardAPI(pgbStatus: TcxProgressBar): Boolean;
Var
  strStatus    : String;
  prcScroll    : TprcScroll;
  blnVazio     : Boolean;
  LImportaVendasRedeCardOnline : TImportaVendasRedeCardOnline;
begin
  LImportaVendasRedeCardOnline := Nil;
  FAjustesUnbookUtilizados := TList<TItensRelatorioCartoes>.Create;
  Try
    Try
      Result       := False;
      blnInconsist := False;
      FFiltrarAutorizacaoNSU := True;

      TForm(pgbStatus.Owner).Visible := False;

      strRcxTcc := VS_FuncoesExternas.fICfgSis('RCXTCC');

      FUtilizaConfirmacaoDeCartoes := TRedeCardFuncoes.fTabelaExiste('EXTMCA').ToString;
      FUtilizaCashback := TRedeCardFuncoes.fTabelaExiste('RED_CASHBK');
      FConciliaPorRV := VS_FuncoesExternas.fICfgSis('CONCRV');

      Application.ProcessMessages;

      strStatus   := '';

      objConcil.TabelaConciliacao           := 'RED_APPGTO';
      objConcil.CampoEstabelecimento        := 'RED_NUM_PV';
      objConcil.NomeConciliacao             := 'RedeCard API';
      objConcil.CampoValorBruto             := 'RED_VALPAR';
      objConcil.CampoValorLiquido           := 'RED_VALLIQ';
      objConcil.CampoCodigoAutorizacao      := 'RED_CODAUT';
      objConcil.CampoNumeroNSU              := 'RED_NUMNSU';
      objConcil.CampoDataTransacaoVenda     := 'RED_DTA_RV';
      objConcil.CampoDataRecebimento        := 'RED_DTAPAG';
      objConcil.CampoNumeroParcela          := 'RED_NUMPAR';
      objConcil.CampoTotalParcelas          := 'RED_TOTPAR';
      objConcil.CampoNumeroCartao           := '';
      objConcil.CampoTipoRegistro           := '';
      objConcil.CampoTipoTransacao          := '';
      objConcil.CfgEstabelecimentos         := 'CFG_REDEST';
      objConcil.CfgPortadorAjustes          := 'REDPOR';
      objConcil.CfgPlanoDeContasAjustes     := 'REDCTA';
      objConcil.CfgFornecedorAjustes        := 'REDFOR';
      objConcil.strEventoCancelamentoAjuste := 'REDEVE';
      objConcil.CfgVlrTolerancia            := 'REDTOL';
      objConcil.CodigoEmpresaFixaParaBaixa  := VS_FuncoesExternas.fICfgSis('REDEMP');

      If Not fDigPeriodo Then
        Exit;

      TForm(pgbStatus.Owner).Visible := True;
      pgbStatus.Visible := False;

      SFiltroEstabelecimento := fRetPesqPonVen(0);

      LImportaVendasRedeCardOnline := TImportaVendasRedeCardOnline.Create(dtaDtaIni,dtaDtaFim,SFiltroEstabelecimento);
      LImportaVendasRedeCardOnline.ImportacaoDasVendasFaltantes;

      TRedeCardFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Filtrando registros para conciliação.', False);
      pCriaDataSets;
      blnVazio := (FCdsRegistrosPagamento.IsEmpty  or FCdsRegistrosMovimento.IsEmpty);

      If blnVazio Then
      Begin
        TRedeCardFuncoes.fMensagem('ATENÇÃO', 'Nenhum registro foi importado para o período selecionado.', ['&Ok']);
        blnReabre := True;
        Exit;
      End;

      //Data para filtrar o MOVCAR dos baixados
      If Assigned(lstDtaCad) Then
        FreeAndNil(lstDtaCad);

      lstDtaCad := TStringList.Create;
      pCalculaPeriodoFiltro(FCdsRegistrosMovimento);

      FInAutorizacaoFiltrar := RetornaInAutorizacaoFiltrar;
      FInNsuFiltrar := RetornaInNsuFiltrar;

      TRedeCardFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Filtrando cartões.', False);
      pFiltraCartoes;

      TRedeCardFuncoes.pDisableControls(cdsBaiCar, prcScroll);

      FRelatorioConciliacao := TRelatorioConciliacao.Create(VS_FuncoesExternas.fIRetOperadorLogado,
                                                            'REDECARD API',
                                                            'CONCILIACAO',
                                                            RetornaFiltrosdigitados,
                                                            TRedeCardFuncoes.RetornaDataHoraServidor,
                                                            TRedeCardFuncoes.RetornaHoraServidor);

      //Filtrandos Ajustes
      pFiltraAjustesRedeCardAPI;

      //Selecionando cartões já baixados/cadastrados no período
      TRedeCardFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Filtrando cartões baixados.', False);
      FiltraCartoesBaixados;

      CarregaIndicesBusca;

      pgbStatus.Visible := True;
      If Not FCdsRegistrosMovimento.IsEmpty Then
      Begin
        TRedeCardFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Selecionando ajuste(s) da(s) venda(s) (REDECARD Online).', False);
        FiltraAjusteDeVendas(pgbStatus);

        TRedeCardFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Selecionando registros de débito/crédito (REDECARD Online).', False);
        fProcessaRegistrosDebitoCredito(pgbStatus);
      End;

      cdsBaiCar.Filter   := 'MCA_MARDES=' + QuotedStr('M');
      cdsBaiCar.Filtered := True;

      blnInconsist := False;

      TRedeCardFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Gravando registros do relatório (REDECARD Online).', False);
      GravarRegistrosRelatorio(pgbStatus);

      TForm(pgbStatus.Owner).Visible := False;

      If blnInconsist Then
        TRedeCardFuncoes.fMensagem('','Foram encontradas inconsistências na importação dos arquivos!',['&OK']);

      Result := FinalizandoConciliacao(pgbStatus);

      TRedeCardFuncoes.pEnableControls(cdsBaiCar, prcScroll);
    Except
      On E: Exception Do
      Begin
        Result := False;
        VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmBaixaCartoes.pConciliaRedeCardAPI]');
      End;
    End;
  Finally
    TRedeCardFuncoes.FreeAndNilDatasets(FCdsRegistrosPagamento);
    TRedeCardFuncoes.FreeAndNilDatasets(FCdsRegistrosMovimento);
    TRedeCardFuncoes.FreeAndNilDatasets(FCdsRegistrosAjuste);
    TRedeCardFuncoes.FreeAndNilDatasets(cdsAjustes);

    If Assigned(LImportaVendasRedeCardOnline) Then
      FreeAndNil(LImportaVendasRedeCardOnline);

    If Assigned(FAjustesUnbookUtilizados) Then
      FreeAndNil(FAjustesUnbookUtilizados);
  End;
end;

procedure TConciliacaoRedeCardAPI.AjustaTipoRegistroParaCartoesZerados(
  var ARegistroRelatorio: TItensRelatorioCartoes);
begin
  If TRedeCardFuncoes.fFormataFloat(ARegistroRelatorio.ValorLiquido, 2) <> 0 Then
    Exit;

  If Not ARegistroRelatorio.TipoDoRegistro.Equals('INCONSISTENCIA') Then
    Exit;

  ARegistroRelatorio.TipoDoRegistro := 'AJUSTES';
  ARegistroRelatorio.Descricao := 'Cancelamentos/Ajustes';
  ARegistroRelatorio.DescricaoAjuste := 'Cartão com valor zerado';
  ARegistroRelatorio.SomarNoTotal := 'N';
end;

procedure TConciliacaoRedeCardAPI.AjustaTipoRegistroParaVendaCancelada(
  var ARegistroRelatorio: TItensRelatorioCartoes);
  Var
    LEmpresaConfiguracao: String;
begin
  If Not ARegistroRelatorio.TipoDoRegistro.Equals('INCONSISTENCIA') Then
    Exit;

  LEmpresaConfiguracao := TRedeCardFuncoes.IIF(TRedeCardFuncoes.fEmptyStr(ARegistroRelatorio.CodigoEmpresa),
                                               VS_FuncoesExternas.fIRetEmpresaLogada,
                                               ARegistroRelatorio.CodigoEmpresa);
  If Not TRedeCardFuncoes.fEmptyStr(objConcil.CodigoEmpresaFixaParaBaixa) Then
    LEmpresaConfiguracao := objConcil.CodigoEmpresaFixaParaBaixa;

  If Not VS_FuncoesExternas.fICfgSis('REDVCA', varBoolean, LEmpresaConfiguracao) Then
    Exit;

  If FCdsRegistrosMovimento.FieldByName('STATUS').AsString.Equals('UNBOOK') And
     (FCdsRegistrosMovimento.FieldByName('VP_RED_CONCIL').AsInteger = 1) Then
  Begin
    ARegistroRelatorio.Descricao := 'Cartão já foi baixado através de conciliação automática';
    Exit;
  End;

  If Not ExisteAjusteDaVendaCancelada(ARegistroRelatorio) Then
    Exit;

  ARegistroRelatorio.TipoDoRegistro := 'AJUSTES';
  ARegistroRelatorio.Descricao := 'Cancelamentos/Ajustes';
  ARegistroRelatorio.TipoCartao := 'CANCELAMENTOS/AJUSTES';
  ARegistroRelatorio.DescricaoAjuste := 'VENDA CANCELADA';
  ARegistroRelatorio.CodigoEmpresa := LEmpresaConfiguracao;
  ARegistroRelatorio.Conciliado := FCdsRegistrosMovimento.FieldByName('VP_RED_CONCIL').AsInteger;

  ARegistroRelatorio.RegistroIncompleto := 'N';
  If FBaixarAjustes Then
  Begin
    ARegistroRelatorio.RegistroIncompleto := ConfiguracoesAjustesEstaoIncompletas(LEmpresaConfiguracao);

    GravarRegistroDeAjusteParaConciliacao(ARegistroRelatorio);
  End;
end;

function TConciliacaoRedeCardAPI.ExisteAjusteDaVendaCancelada(
  ARegistroRelatorio: TItensRelatorioCartoes): Boolean;
  Var
    LAjuste: TItensRelatorioCartoes;
begin
  Result := False;

  LTolerancia := RetornaValorTolerancia(ARegistroRelatorio.CodigoEmpresa);

  For LAjuste In FListaRegistrosRelatorio Do
  Begin
    If Not LAjuste.DescricaoAjuste.Equals('UNBOOK') Then
      Continue;

    If FAjustesUnbookUtilizados.Contains(LAjuste) Then
      Continue;

    If Not LAjuste.CodigoEstabelecimento.Equals(ARegistroRelatorio.CodigoEstabelecimento) Then
      Continue;

    If Not LAjuste.Parcela.Equals(ARegistroRelatorio.Parcela) Then
      Continue;

    If Not LAjuste.NumeroNSU.Equals(ARegistroRelatorio.NumeroNSU) Then
    Begin
      If ARegistroRelatorio.CodigoAutorizacao.Equals('000000') Then
        Continue;

      If Not LAjuste.CodigoAutorizacao.Equals(ARegistroRelatorio.CodigoAutorizacao) Then
        Continue;
    End;

    If Not fBetween(TRedeCardFuncoes.fFormataFloat(LAjuste.ValorBruto + ARegistroRelatorio.ValorBruto, 2), -LTolerancia, LTolerancia) Then
      Continue;

    If Not fBetween(TRedeCardFuncoes.fFormataFloat(LAjuste.ValorLiquido + ARegistroRelatorio.ValorLiquido, 2), -LTolerancia, LTolerancia) Then
      Continue;

    FAjustesUnbookUtilizados.Add(LAjuste);

    Exit(True);
  End;
end;

class procedure TConciliacaoRedeCardAPI.AtualizaConciliacaoAjustesRedeCardAPI(
  ABaixa: Boolean; ACartao: TUniClientDataSet);
  Var
    LSQLAjuste: String;
    LConcil : TUniQuery;
begin
  LConcil := Nil;
  Try
    LConcil := VS_FuncoesExternas.fICriaQuery;

    If Concat(ACartao.FieldByName('CLI_NOMCLI').AsString,
              ACartao.FieldByName('MCA_CODCLI').AsString).Equals('UNBOOK00000000') Then
    Begin
      MarcarAjusteVendaComoConciliado(ABaixa,ACartao);
      Exit;
    End;

    If Concat(ACartao.FieldByName('CLI_NOMCLI').AsString,
              ACartao.FieldByName('MCA_CODCLI').AsString).Equals('CASHBACK00000000') Then
    Begin
      MarcarAjusteCashBackComoConciliado(ABaixa,ACartao);
      Exit;
    End;

    If Concat(ACartao.FieldByName('CLI_NOMCLI').AsString,
              ACartao.FieldByName('MCA_CODCLI').AsString).Equals('VENDA CANCELADA00000000') Then
    Begin
      AtualizaConciliacaoPagamentoRedeCardAPI(ABaixa, ACartao);
      Exit;
    End;

    LSQLAjuste :=     'UPDATE                 '+
                      '  RED_APAJUS           '+
                      'SET                    '+
                      '  RED_CONCIL = :CONCIL '+
                      'WHERE RED_CONCIL = :FILCON  '+
                      '  AND RED_NUM_PV = :NUM_PV  '+
                      '  AND RED_DTAPAG = :DTAPAG  '+
                      '  AND RED_VALAJU = :VALAJU  ';
    LConcil.Close;
    LConcil.Sql.Clear;
    LConcil.Sql.Add(LSQLAjuste);

    LConcil.ParamByName('CONCIL').AsInteger := TRedeCardFuncoes.IIF(ABaixa, 1, 0);
    LConcil.ParamByName('FILCON').AsInteger := TRedeCardFuncoes.IIF(ABaixa, 0, 1);
    LConcil.ParamByName('NUM_PV').Value     := ACartao.FieldByName('MCA_ESTABE').AsString;
    LConcil.ParamByName('DTAPAG').Value     := ACartao.FieldByName('MCA_DTAREC').Value;
    LConcil.ParamByName('VALAJU').AsFloat   := (ACartao.FieldByName('MCA_VALTOT').AsFloat * -1);

    LConcil.ExecSQL;
  Finally
    TRedeCardFuncoes.FreeAndNilDatasets(LConcil);
  End;
end;

class procedure TConciliacaoRedeCardAPI.AtualizaConciliacaoPagamentoRedeCardAPI(ABaixa: Boolean; ACartao: TUniClientDataSet);
  Var
    LSQLPagamento : String;
    LConcil : TUniQuery;
begin
  LConcil := Nil;
  Try
    LConcil := VS_FuncoesExternas.fICriaQuery;
    LSQLPagamento :=  'UPDATE                                            ' +
                      '  RED_APPGTO PG                                   ' +
                      '  LEFT JOIN RED_APVPGO VPG                        ' +
                      '    ON VPG.RED_NUM_PV = PG.RED_NUM_PV             ' +
                      '    AND VPG.RED_NUM_RV = PG.RED_NUM_RV            ' +
                      '    AND (                                         ' +
                      '      (VPG.RED_VEN_RV = PG.RED_DTAPAG)            ' +
                      '      OR (VPG.RED_PAG_ID = PG.RED_PAG_ID)         ' +
                      '    )                                             ' +

                      '     SET PG.RED_CONCIL  = :CONCIL,                ' +
                      '         VPG.RED_CONCIL = :CONCIL                 ' +

                      'WHERE (                                           ' +
                      '    (VPG.RED_CODAUT = :NUMCCD)                    ' +
                      '    OR (                                          ' +
                      '      VPG.RED_NUMNSU = RIGHT(                     ' +
                      '        :NUMNSU,                                  ' +
                      '        LENGTH(VPG.RED_NUMNSU)                    ' +
                      '      )                                           ' +
                      '    )                                             ' +
                      '  )                                               ' +
                      '  AND VPG.RED_NUMPAR = :NUMPAR                    ' +
                      '  AND VPG.RED_DTAVEN = :DTA_RV                    ' +
                      '  AND VPG.RED_CONCIL = :FILCON                    ' +
                      '  AND PG.RED_DTAPAG  = :DTAPAG                    ' +
                      '  AND PG.RED_CONCIL  = :FILCON                    ' ;

      If ABaixa Then
        LSQLPagamento := LSQLPagamento + '  AND VPG.RED_NUM_PV = :NUM_PV ' ;

      LConcil.Close;
      LConcil.Sql.Clear;
      LConcil.Sql.Add(LSQLPagamento);

      LConcil.ParamByName('NUMCCD').AsString   := ACartao.FieldByName('MCA_NUMCCD').AsString;
      LConcil.ParamByName('NUMNSU').AsString   := ACartao.FieldByName('MCA_NUMNSU').AsString;
      LConcil.ParamByName('NUMPAR').Value      := IntToStr(TRedeCardFuncoes.fGetPosLetraAlfa(ACartao.FieldByName('PARDUP').AsString));
      LConcil.ParamByName('DTA_RV').AsDateTime := ACartao.FieldByName('MCA_DTACUP').AsDateTime;
      LConcil.ParamByName('DTAPAG').AsDateTime := ACartao.FieldByName('MCA_DTAREC').AsDateTime;
      LConcil.ParamByName('FILCON').AsInteger  := TRedeCardFuncoes.IIF(ABaixa, 0, 1);
      LConcil.ParamByName('CONCIL').AsInteger  := TRedeCardFuncoes.IIF(ABaixa, 1, 0);

      If ABaixa Then
        LConcil.ParamByName('NUM_PV').Value    := ACartao.FieldByName('MCA_ESTABE').AsString;

    LConcil.ExecSQL;

    If (LConcil.RowsAffected = 0) Then
    Begin
      LSQLPagamento :=  'UPDATE                                             ' +
                        '  RED_APPGTO PG                                    ' +
                        'LEFT JOIN RED_APVPAR VP                            ' +
                        '  ON VP.RED_NUM_PV = PG.RED_NUM_PV                 ' +
                        '  AND VP.RED_NUM_RV = PG.RED_NUM_RV                ' +
                        '  AND VP.RED_VEN_RV = PG.RED_DTAPAG                ' +
                        'LEFT JOIN RED_APVEND V                             ' +
                        '  ON VP.RED_NUM_PV = V.RED_NUM_PV                  ' +
                        '  AND VP.RED_NUM_RV = V.RED_NUM_RV                 ' +
                        '  AND VP.RED_DTA_RV = V.RED_DTA_RV                 ' +

                        '     SET VP.RED_CONCIL  = :CONCIL,                 ' +
                        '         PG.RED_CONCIL  = :CONCIL                  ' +

                        '                                                   ' +
                        '  WHERE (                                          ' +
                        '  (V.RED_CODAUT = :NUMCCD)                         ' +
                        '  OR (                                             ' +
                        '    V.RED_NUMNSU = RIGHT(                          ' +
                        '      :NUMNSU,                                     ' +
                        '      LENGTH(V.RED_NUMNSU)                         ' +
                        '    )                                              ' +
                        '  )                                                ' +
                        ')                                                  ' +
                        ' AND VP.RED_NUMPAR = :NUMPAR                       ' +
                        ' AND VP.RED_DTA_RV = :DTA_RV                       ' +
                        ' AND VP.RED_CONCIL = :FILCON                       ' +
                        ' AND PG.RED_DTAPAG = :DTAPAG                       ' +
                        ' AND PG.RED_CONCIL = :FILCON                       ' ;

      If ABaixa Then
        LSQLPagamento := LSQLPagamento + ' AND VP.RED_NUM_PV = :NUM_PV ' ;

      LConcil.Close;
      LConcil.Sql.Clear;
      LConcil.Sql.Add(LSQLPagamento);

      LConcil.ParamByName('NUMCCD').AsString   := ACartao.FieldByName('MCA_NUMCCD').AsString;
      LConcil.ParamByName('NUMNSU').AsString   := ACartao.FieldByName('MCA_NUMNSU').AsString;
      LConcil.ParamByName('NUMPAR').Value      := IntToStr(TRedeCardFuncoes.fGetPosLetraAlfa(ACartao.FieldByName('PARDUP').AsString));
      LConcil.ParamByName('DTA_RV').AsDateTime := ACartao.FieldByName('MCA_DTACUP').AsDateTime;
      LConcil.ParamByName('DTAPAG').AsDateTime := ACartao.FieldByName('MCA_DTAREC').AsDateTime;
      LConcil.ParamByName('FILCON').AsInteger  := TRedeCardFuncoes.IIF(ABaixa, 0, 1);
      LConcil.ParamByName('CONCIL').AsInteger  := TRedeCardFuncoes.IIF(ABaixa, 1, 0);

      If ABaixa Then
        LConcil.ParamByName('NUM_PV').Value    := ACartao.FieldByName('MCA_ESTABE').AsString;

      LConcil.ExecSQL;
    End;

    If FUtilizaConfirmacaoDeCartoes.IsEmpty Then
      FUtilizaConfirmacaoDeCartoes := TRedeCardFuncoes.fTabelaExiste('EXTMCA').ToString;

    If Not FUtilizaConfirmacaoDeCartoes.ToLower.Equals('true') Then
      Exit;

    If ABaixa Then
      TLibCartoesMovCar.AtualizarConciliacaoConfirmacaoCartao(ACartao.FieldByName('MCA_NUMNSU').AsString,
                                                              ACartao.FieldByName('MCA_NUMCCD').AsString,
                                                              ACartao.FieldByName('PARDUP').AsString,
                                                              'REDECARD',
                                                              ACartao.FieldByName('MCA_DTACUP').AsDateTime)
    Else
      TLibCartoesMovCar.LimparConciliacaoConfirmacaoCartao(ACartao.FieldByName('MCA_NUMNSU').AsString,
                                                           ACartao.FieldByName('MCA_NUMCCD').AsString,
                                                           ACartao.FieldByName('PARDUP').AsString,
                                                           'REDECARD',
                                                           ACartao.FieldByName('MCA_DTACUP').AsDateTime);
  Finally
    TRedeCardFuncoes.FreeAndNilDatasets(LConcil);
  End;
end;

function TConciliacaoRedeCardAPI.CartaoFazParteDessePagamento(
  var AValorLiquidoPago: Double): Boolean;
begin
  Result := True;

  If FCdsRegistrosMovimento.FieldByName('STATUS').AsString.Equals('UNBOOK') Then
    Exit;

  AValorLiquidoPago := TRedeCardFuncoes.fFormataFloat(AValorLiquidoPago - RetornaValorLiquidoParcela,2);
  If (AValorLiquidoPago < -0.01999) Then
  Begin
    If (TRedeCardFuncoes.fFormataFloat((AValorLiquidoPago + FCdsRegistrosPagamento.FieldByName('AJUSTE_DEBITADO').AsFloat),2) < -0.01999) Then
      Result := False;
  End;
end;

function TConciliacaoRedeCardAPI.ConciliouRegistros: Boolean;
  Var
    LFilterAnt: String;
begin
  LFilterAnt := cdsBaiCar.Filter;

  Try
    cdsBaiCar.Filter := 'MCA_MARDES=''M'' ';
    cdsBaiCar.Filtered := True;

    Result := Not cdsBaiCar.IsEmpty;
  Finally
    cdsBaiCar.Filter := LFilterAnt;
    cdsBaiCar.Filtered := True;
  End;
end;

function TConciliacaoRedeCardAPI.fConciliaCartoes: Boolean;
begin
  Result := TRedeCardFuncoes.ExecutaAguarde(fConciliaRedeCardAPI, 'Aguarde... Iniciando conciliação RedeCard Online.');
end;

function TConciliacaoRedeCardAPI.fGetTipoDeOperacao(ACodigoModalidade : String; ATotalParcelas : Integer): String;
begin
  Result := '';
  If (ACodigoModalidade = 'DEB') Then
    Result := 'DÉBITO'
  Else If (ACodigoModalidade = 'CRE')Then
    Result := TRedeCardFuncoes.IIF(ATotalParcelas > 1, 'CRÉDITO PARCELADO', 'CRÉDITO ROTATIVO')
  Else If (ACodigoModalidade = 'ANT')  Then
    Result := 'ANTECIPAÇÃO';
end;

function TConciliacaoRedeCardAPI.FiltraAjusteDeVendas(pgbStatus: TcxProgressBar): Boolean;
  Var
    LEmpresaConfiguracao: String;

    LRegistroRelatorio: TItensRelatorioCartoes;
begin
  Result := True;
  Try
    FCdsRegistrosMovimento.Filtered := False;
    FCdsRegistrosMovimento.Filter := ' STATUS = '+ QuotedStr('UNBOOK') +
                                     ' AND VP_RED_CONCIL <> 1';
    FCdsRegistrosMovimento.Filtered := True;

    FCdsRegistrosMovimento.First;
    While Not FCdsRegistrosMovimento.Eof Do
    Begin
      LEmpresaConfiguracao := TRedeCardFuncoes.IIF(TRedeCardFuncoes.fEmptyStr(FCdsRegistrosMovimento.FieldByName('EMP_CODEMP').AsString),
                                                   VS_FuncoesExternas.fIRetEmpresaLogada,
                                                   FCdsRegistrosMovimento.FieldByName('EMP_CODEMP').AsString);
      If Not TRedeCardFuncoes.fEmptyStr(objConcil.CodigoEmpresaFixaParaBaixa) Then
        LEmpresaConfiguracao := objConcil.CodigoEmpresaFixaParaBaixa;

      LRegistroRelatorio := TItensRelatorioCartoes.Create;

      LRegistroRelatorio.ValorBruto := TRedeCardFuncoes.fFormataFloat(FCdsRegistrosMovimento.FieldByName('VP_RED_VALPAR').Value * -1, 2);
      LRegistroRelatorio.ValorLiquido := TRedeCardFuncoes.fFormataFloat(FCdsRegistrosMovimento.FieldByName('VP_RED_LIQPAR').Value * -1, 2);

      LRegistroRelatorio.Descricao := 'Cancelamentos/Ajustes';
      LRegistroRelatorio.TipoDoRegistro := 'AJUSTES';
      LRegistroRelatorio.TipoCartao := 'CANCELAMENTOS/AJUSTES';
      LRegistroRelatorio.DescricaoAjuste := UpperCase(FCdsRegistrosMovimento.FieldByName('STATUS').Value);

      LRegistroRelatorio.CodigoEmpresa := LEmpresaConfiguracao;
      LRegistroRelatorio.CodigoEstabelecimento := FCdsRegistrosMovimento.FieldByName('VP_RED_NUM_PV').AsString;
      LRegistroRelatorio.NumeroNSU := TRedeCardFuncoes.fStrZero(Trim(RightStr(FCdsRegistrosMovimento.FieldByName('VP_RED_NUMNSU').AsString, 14)), 14);
      LRegistroRelatorio.NumeroCartao := FCdsRegistrosMovimento.FieldByName('V_RED_NUMCAR').Value;
      LRegistroRelatorio.Parcela := TRedeCardFuncoes.fStrZero(FCdsRegistrosMovimento.FieldByName('VP_RED_NUMPAR').AsString,2);
      LRegistroRelatorio.TotalParcelas := TRedeCardFuncoes.fStrZero(FCdsRegistrosMovimento.FieldByName('V_RED_TOTPAR').AsString,2);
      LRegistroRelatorio.CodigoAutorizacao := TRedeCardFuncoes.fStrZero(FCdsRegistrosMovimento.FieldByName('V_RED_CODAUT').AsString,6);

      LRegistroRelatorio.DataVenda := FCdsRegistrosMovimento.FieldByName('V_RED_DTAVEN').AsDateTime;
      LRegistroRelatorio.DataPagamento := FCdsRegistrosMovimento.FieldByName('VP_RED_DTAPAG').AsDateTime;
      LRegistroRelatorio.DataVencimento := FCdsRegistrosMovimento.FieldByName('VP_RED_VEN_RV').AsDateTime;

      LRegistroRelatorio.Conciliado := FCdsRegistrosMovimento.FieldByName('VP_RED_CONCIL').AsInteger;

      LRegistroRelatorio.RegistroIncompleto := 'N';
      If FBaixarAjustes Then
      Begin
        LRegistroRelatorio.RegistroIncompleto := ConfiguracoesAjustesEstaoIncompletas(LEmpresaConfiguracao);

        GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio);
      End;

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      FCdsRegistrosMovimento.Next;
    End;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

procedure TConciliacaoRedeCardAPI.FiltraCartoesBaixados;
begin
  pFiltraCartoesBaixados(False);
end;

function TConciliacaoRedeCardAPI.FinalizandoConciliacao(pgbStatus: TcxProgressBar): Boolean;
begin
  Result := False;

  Try
    If TemRegistrosImportados Then
      Result := GeraRelatorioConciliacao(objConcil.NomeConciliacao, pgbStatus);

    If Assigned(FCdsRegistrosAjuste) Then
    Begin
      FCdsRegistrosAjuste.Filter   := 'RED_CONCIL = 0';
      FCdsRegistrosAjuste.Filtered := True;
    End;

    blnReabre := Reabrir(Result);

    If Result Then
    Begin

      Result := ConciliouRegistros;

      If Not Result Then
        TRedeCardFuncoes.fMensagem('ATENÇÃO','Nenhum pagamento foi conciliado no período selecionado!',['&OK'])
      Else
        TRedeCardFuncoes.fMensagem('AVISO','Conciliação da REDECARD Online realizada com sucesso.',['&OK']);
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmBaixaCartoes.FinalizandoConciliacao]');
    End;
  End;
end;


function TConciliacaoRedeCardAPI.fProcessaRegistrosDebitoCredito(pgbStatus: TcxProgressBar) : Boolean;
Var strParcel                : String;
    strNumNsu                : String;
    strCodEmp                : String;
    dtaDtaCad                : TDateTime;
    strNumAut                : String;
    blnBusca                 : Boolean;
    blnSemReg                : Boolean;
    STipoOperacao            : String;
    LDivergenciaCartao       : String;
    LValorLiquidoPago        : Double;
    LNumCCD                  : String;
    LTaxaAntecipacao         : Double;
    LLiquidoConciliado       : Double;

    LRegistroRelatorio: TItensRelatorioCartoes;

    LNomeArquivo,
    LChaveConciliacao: String;
begin
  Result := False;
  Try
    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := FCdsRegistrosPagamento.RecordCount;

    FCdsRegistrosPagamento.First;
    While Not FCdsRegistrosPagamento.Eof Do
    Begin

      If AnsiUpperCase(FCdsRegistrosPagamento.FieldByName('STATUS_PAGAMENTO').AsString).Equals('SUSPENDED') Then
      Begin
        FCdsRegistrosPagamento.Next;
        Continue;
      End;

      TRedeCardFuncoes.pStepStatusGravacao(pgbStatus);
      LNomeArquivo := '[RedeCard API] - Data de Importação: ' +
                      FormatDateTime('dd/mm/yyyy',FCdsRegistrosPagamento.FieldByName('RED_DTAIMP').AsDateTime);

      FTextoInconsistencia := '';
      LDivergenciaCartao := '';
      LLiquidoConciliado := 0;

      FCdsRegistrosMovimento.Filtered := False;
      FCdsRegistrosMovimento.Filter := 'V_RED_NUM_PV  = ' + QuotedStr(FCdsRegistrosPagamento.FieldByName('RED_NUM_PV').AsString)+ ' AND ' +
                                       'V_RED_NUM_RV  = ' + QuotedStr(FCdsRegistrosPagamento.FieldByName('RED_NUM_RV').AsString);

      if not FConciliaPorRV.Equals('S') then
      begin
        FCdsRegistrosMovimento.Filter := FCdsRegistrosMovimento.Filter +
                        ' AND V_RED_PAG_ID  = ' + QuotedStr(FCdsRegistrosPagamento.FieldByName('RED_PAG_ID').AsString);
      end;

      FCdsRegistrosMovimento.Filtered := True;

      AjustaValorRecebidoComCancelamentoDeVendas;

      FCdsRegistrosMovimento.First;

      blnSemReg := FCdsRegistrosMovimento.IsEmpty;

      LValorLiquidoPago := TRedeCardFuncoes.IIF(FCdsRegistrosPagamento.FieldByName('RED_TIPREG').AsString.Equals('ANT'),
                                                FCdsRegistrosPagamento.FieldByName('RED_VALBRU').AsFloat,
                                                FCdsRegistrosPagamento.FieldByName('RED_VALLIQ').AsFloat);

      While Not FCdsRegistrosMovimento.Eof Do
      Begin

        If FCdsRegistrosMovimento.FieldByName('VP_CONCILIADA').AsString.Equals('S') Then
        Begin
          FCdsRegistrosMovimento.Next; // venda já conciliada em outro pagamento
          Continue;
        End;


        If Not CartaoFazParteDessePagamento(LValorLiquidoPago) Then
        Begin
          Break;   // conciliou todo valor pago
        End;

        LRegistroRelatorio := TItensRelatorioCartoes.Create;

        LTaxaAntecipacao := 0;
        If (FCdsRegistrosPagamento.FieldByName('RED_TIPREG').AsString.Equals('ANT') And
           Not FCdsRegistrosMovimento.FieldByName('STATUS').AsString.Equals('UNBOOK')) Then
          LTaxaAntecipacao := TRedeCardFuncoes.fFormataFloat(((RetornaValorLiquidoParcela * FCdsRegistrosPagamento.FieldByName('RED_VALDES').AsFloat)/
                                                                                            FCdsRegistrosPagamento.FieldByName('RED_VALBRU').AsFloat),2);

        {* Parcela desagendada (UNBOOK) não faz parte do valor pago (RED_VALLIQ). Somada aqui, o acerto
           da taxa logo abaixo jogava o valor dela na taxa de antecipação do último cartão do pagamento. *}
        If Not FCdsRegistrosMovimento.FieldByName('STATUS').AsString.Equals('UNBOOK') Then
          LLiquidoConciliado := LLiquidoConciliado + TRedeCardFuncoes.fFormataFloat(RetornaValorLiquidoParcela - LTaxaAntecipacao,2);

        If (LValorLiquidoPago <= 0) And (LTaxaAntecipacao > 0) Then
        Begin
          LTaxaAntecipacao := TRedeCardFuncoes.fFormataFloat(LTaxaAntecipacao + (LLiquidoConciliado - FCdsRegistrosPagamento.FieldByName('RED_VALLIQ').AsFloat),2);
        End;

        STipoOperacao := fGetTipoDeOperacao(RetornaTipoRegistro,
                                            FCdsRegistrosMovimento.FieldByName('V_RED_TOTPAR').Value);

        strParcel := TRedeCardFuncoes.fGetLetraAlfa(StrtoInt(LeftStr(FCdsRegistrosMovimento.FieldByName('VP_RED_NUMPAR').AsString , 2)));
        FTextoInconsistencia := '';
        strNumNsu := TRedeCardFuncoes.fStrZero(Trim(RightStr(FCdsRegistrosMovimento.FieldByName('VP_RED_NUMNSU').AsString, 14)), 14);
        strNumAut := FCdsRegistrosMovimento.FieldByName('V_RED_CODAUT').AsString;
        dtaDtaCad := FCdsRegistrosMovimento.FieldByName('VP_RED_DTA_RV').Value;
        strCodEmp := FCdsRegistrosMovimento.FieldByName('EMP_CODEMP').AsString;

        {********************}
        {* NOVA CONCILIAÇÃO *}
        {*****************GD*}

        LNumCCD := TRedeCardFuncoes.IIF((strNumAut = '0'),'',TRedeCardFuncoes.fStrZero(strNumAut, 6));

        If LNumCCD = '000000' Then
          LNumCCD := '';

        LChaveConciliacao := 'APR_' + FCdsRegistrosMovimento.FieldByName('VP_RED_NUM_PV').AsString + '_' +
                             FCdsRegistrosMovimento.FieldByName('VP_RED_NUMNSU').Value + '_' +
                             strParcel + '_' +
                             cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                             FormatDateTime('yyyy-mm-dd', FCdsRegistrosPagamento.FieldByName('RED_DTAPAG').Value);

        blnBusca := fBuscaCartao(LNumCCD,
                                 strNumNsu,
                                 strCodEmp,
                                 strParcel,
                                 dtaDtaCad);

        LDivergenciaCartao := '';
        ValidaCartaoEncontrado(blnBusca,LDivergenciaCartao,FCdsRegistrosMovimento);

        If (blnBusca) Then
        Begin
          MarcarCartaoEncontradoAPI(TRedeCardFuncoes.fFormataFloat(RetornaValorLiquidoParcela - LTaxaAntecipacao,2),
                                    RetornaTipoRegistro.Equals('ANT'),
                                    LRegistroRelatorio,
                                    LChaveConciliacao,
                                    FCdsRegistrosPagamento.FieldByName('RED_DTAPAG').AsDateTime,
                                    FCdsRegistrosMovimento,
                                    0,
                                    FCdsRegistrosMovimento.FieldByName('TAXA_ANTECIPACAO_FLEX').AsFloat);

          If Not FCdsRegistrosPagamento.FieldByName('PORTADOR_GRAVAME').AsString.IsEmpty Then
          Begin
            cdsBaiCar.Edit;
            cdsBaiCar.FieldByName('PORTADOR_GRAVAME').AsString := FCdsRegistrosPagamento.FieldByName('PORTADOR_GRAVAME').AsString;
            cdsBaiCar.FieldByName('CAR_PORBAI').AsString       := FCdsRegistrosPagamento.FieldByName('PORTADOR_GRAVAME').AsString;
            cdsBaiCar.FieldByName('CAR_PORTAX').AsString       := FCdsRegistrosPagamento.FieldByName('PORTADOR_GRAVAME').AsString;
            cdsBaiCar.Post;
          End;

          ValidaCartaoMarcado(LDivergenciaCartao);
        End
        Else
        Begin
          //verifica se está cadastrado ou já foi baixado no período
          cdsBaixad.First;
          blnBusca := fBuscaCartaoBaixado(LNumCCD,
                                          strNumNsu,
                                          strCodEmp,
                                          strParcel,
                                          dtaDtaCad,
                                          True,
                                          RetornaValorBrutoParcela);

          FTextoInconsistencia := TRedeCardFuncoes.IIF(blnBusca,
                                                       'Cartão já foi baixado',
                                                       'Registro do arquivo não encontrado nos lançamentos do sistema');
        End;

        //Grava inconsistência se houver
        FTextoInconsistencia := TRedeCardFuncoes.IIF(TRedeCardFuncoes.fEmptyStr(LDivergenciaCartao),FTextoInconsistencia,LDivergenciaCartao);

        {Gerando registro do relatório}
        FTextoInconsistencia := RetornaTextoInconsistenciaAtualizado(FTextoInconsistencia);
        If Not FTextoInconsistencia.IsEmpty Then
        Begin
          LRegistroRelatorio.Descricao := FTextoInconsistencia;
          LRegistroRelatorio.SomarNoTotal := 'N';
          If Not FTextoInconsistencia.Equals(RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa) Then
          Begin
            LRegistroRelatorio.TipoDoRegistro := 'INCONSISTENCIA';
            LRegistroRelatorio.SomarNoTotal := 'S';
          End;
        End;
        LRegistroRelatorio.NomeArquivo := LNomeArquivo;
        LRegistroRelatorio.CodigoEstabelecimento := FCdsRegistrosMovimento.FieldByName('VP_RED_NUM_PV').AsString;
        LRegistroRelatorio.CodigoEmpresa := strCodEmp;
        LRegistroRelatorio.NumeroNSU := TRedeCardFuncoes.fStrZero(Trim(RightStr(strNumNsu, 14)), 14);
        LRegistroRelatorio.CodigoAutorizacao := TRedeCardFuncoes.fStrZero(Trim(RightStr(LNumCCD, 6)), 6);
        LRegistroRelatorio.ResumoVenda := FCdsRegistrosMovimento.FieldByName('VP_RED_NUM_RV').AsString;
        LRegistroRelatorio.NumeroCartao := FCdsRegistrosMovimento.FieldByName('V_RED_NUMCAR').AsString;

        LRegistroRelatorio.TipoCartao := STipoOperacao;

        LRegistroRelatorio.Parcela := TRedeCardFuncoes.fStrZero(FCdsRegistrosMovimento.FieldByName('VP_RED_NUMPAR').AsString, 2);
        LRegistroRelatorio.TotalParcelas := TRedeCardFuncoes.fStrZero(FCdsRegistrosMovimento.FieldByName('V_RED_TOTPAR').AsString, 2);
        LRegistroRelatorio.DataPagamento := FCdsRegistrosMovimento.FieldByName('VP_RED_DTAPAG').AsDateTime;
        LRegistroRelatorio.DataVenda := dtaDtaCad;
        LRegistroRelatorio.DataVencimento := FCdsRegistrosMovimento.FieldByName('VP_RED_VEN_RV').AsDateTime;

        LRegistroRelatorio.ValorBruto := RetornaValorBrutoParcela;
        LRegistroRelatorio.ValorLiquido := TRedeCardFuncoes.fFormataFloat(RetornaValorLiquidoParcela - LTaxaAntecipacao,2);

        AjustaTipoRegistroParaCartoesZerados(LRegistroRelatorio);

        If Not blnBusca Then
        Begin
          If LDivergenciaCartao.IsEmpty Then
            AjustaTipoRegistroParaVendaCancelada(LRegistroRelatorio);
        End;

        LRegistroRelatorio.DescricaoBandeira := fRetNomBandeira(LRegistroRelatorio.NumeroCartao);

        LRegistroRelatorio.CodigoBandeira := cdsBaicar.FieldByName('CAR_CODBAN').AsString;
        LRegistroRelatorio.PercentualTaxa := TRedeCardFuncoes.fFormataFloat(cdsBaicar.FieldByName('CAR_PERDES').AsFloat, 2);
        If TRedeCardFuncoes.RetornaValorCfg('CFG_VLDTAX').Equals('2') Then
          LRegistroRelatorio.PercentualTaxa := TRedeCardFuncoes.fFormataFloat(cdsBaicar.FieldByName('TAXA_ADM_ORIGINAL').AsFloat, 2);

        FListaRegistrosRelatorio.Add(LRegistroRelatorio);

        If LRegistroRelatorio.TipoCartao.Equals('AJUSTE DE PARCELA') Then
          GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio);

        If MarcarVendaComoConciliada Then
        Begin
          FCdsRegistrosMovimento.Edit;
          FCdsRegistrosMovimento.FieldByName('VP_CONCILIADA').AsString := 'S'; // vinculado a um pagamento
          FCdsRegistrosMovimento.Post;

          FCdsRegistrosMovimento.Next;
        End;

      End;

      If blnSemReg Then
      Begin
        If PagamentoCashback(FCdsRegistrosPagamento.FieldByName('RED_PAG_ID').AsString,
                             FCdsRegistrosPagamento.FieldByName('RED_NUM_PV').AsString,
                             FCdsRegistrosPagamento.FieldByName('RED_VALLIQ').AsFloat) Then
        Begin
          GerarAjusteCashback;
          FCdsRegistrosPagamento.Next;
          Continue;
        End;

        LRegistroRelatorio := TItensRelatorioCartoes.Create;

        LRegistroRelatorio.NomeArquivo := LNomeArquivo;
        LRegistroRelatorio.TipoDoRegistro := 'FALTANDO';
        LRegistroRelatorio.CodigoEstabelecimento := FCdsRegistrosPagamento.FieldByName('RED_NUM_PV').AsString;
        LRegistroRelatorio.ResumoVenda := FCdsRegistrosPagamento.FieldByName('RED_NUM_RV').AsString;
        LRegistroRelatorio.DataVenda := FCdsRegistrosPagamento.FieldByName('RED_DTAPAG').AsDateTime;
        LRegistroRelatorio.DataPagamento := FCdsRegistrosPagamento.FieldByName('RED_DTAPAG').AsDateTime;
        LRegistroRelatorio.ValorLiquido := FCdsRegistrosPagamento.FieldByName('RED_VALLIQ').AsFloat;
        LRegistroRelatorio.ValorBruto := FCdsRegistrosPagamento.FieldByName('RED_VALLIQ').AsFloat;
        LRegistroRelatorio.Parcela := EmptyStr;
        LRegistroRelatorio.TotalParcelas := EmptyStr;
        LRegistroRelatorio.RegistroIncompleto := 'S';

        FListaRegistrosRelatorio.Add(LRegistroRelatorio);
      End;

      FCdsRegistrosPagamento.Next;
    End;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Raise;
    End;
  End;

end;

procedure TConciliacaoRedeCardAPI.GerarAjusteCashback;
  Var
    LEmpresaConfiguracao: String;

    LRegistroRelatorio: TItensRelatorioCartoes;
begin
  Try

    LEmpresaConfiguracao := TRedeCardFuncoes.IIF(TRedeCardFuncoes.fEmptyStr(FCdsRegistrosPagamento.FieldByName('EMP_CODEMP').AsString),
                                                 VS_FuncoesExternas.fIRetEmpresaLogada,
                                                 FCdsRegistrosPagamento.FieldByName('EMP_CODEMP').AsString);

    If Not TRedeCardFuncoes.fEmptyStr(objConcil.CodigoEmpresaFixaParaBaixa) Then
      LEmpresaConfiguracao := objConcil.CodigoEmpresaFixaParaBaixa;

    LRegistroRelatorio := TItensRelatorioCartoes.Create;

    LRegistroRelatorio.ValorBruto := TRedeCardFuncoes.fFormataFloat(FCdsRegistrosPagamento.FieldByName('RED_VALBRU').Value, 2);
    LRegistroRelatorio.ValorLiquido := TRedeCardFuncoes.fFormataFloat(FCdsRegistrosPagamento.FieldByName('RED_VALLIQ').Value, 2);

    LRegistroRelatorio.Descricao := 'Cancelamentos/Ajustes';
    LRegistroRelatorio.TipoDoRegistro := 'AJUSTES';
    LRegistroRelatorio.TipoCartao := 'CANCELAMENTOS/AJUSTES';
    LRegistroRelatorio.DescricaoAjuste := 'CASHBACK';

    LRegistroRelatorio.CodigoEmpresa := LEmpresaConfiguracao;
    LRegistroRelatorio.CodigoEstabelecimento := FCdsRegistrosPagamento.FieldByName('RED_NUM_PV').AsString;
    LRegistroRelatorio.NumeroNSU := FCdsRegistrosPagamento.FieldByName('RED_NUM_RV').AsString;
    LRegistroRelatorio.NumeroCartao := FCdsRegistrosPagamento.FieldByName('RED_PAG_ID').AsString;
    LRegistroRelatorio.Parcela := '01';
    LRegistroRelatorio.TotalParcelas := '01';
    LRegistroRelatorio.CodigoAutorizacao :=  TRedeCardFuncoes.fStrZero(FCdsRegistrosPagamento.FieldByName('RED_NUMORD').AsString,6);

    LRegistroRelatorio.DataVenda := FCdsRegistrosPagamento.FieldByName('RED_DTAPAG').AsDateTime;
    LRegistroRelatorio.DataPagamento := FCdsRegistrosPagamento.FieldByName('RED_DTAPAG').AsDateTime;
    LRegistroRelatorio.DataVencimento := FCdsRegistrosPagamento.FieldByName('RED_DTAPAG').AsDateTime;

    LRegistroRelatorio.Conciliado := FCdsRegistrosPagamento.FieldByName('RED_CONCIL').AsInteger;

    LRegistroRelatorio.RegistroIncompleto := 'N';
    If FBaixarAjustes Then
    Begin
      LRegistroRelatorio.RegistroIncompleto := ConfiguracoesAjustesEstaoIncompletas(LEmpresaConfiguracao);

      GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio);
    End;

    FListaRegistrosRelatorio.Add(LRegistroRelatorio);

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

class procedure TConciliacaoRedeCardAPI.MarcarAjusteCashBackComoConciliado(
  ABaixa: Boolean; ACartao: TUniClientDataSet);
  Var
    LSQLAjuste: String;
    LConcil : TUniQuery;
begin
  LConcil := VS_FuncoesExternas.fICriaQuery;
  Try
    LSQLAjuste :=  'UPDATE                           '+
                   '  RED_APPGTO                     '+
                   'SET                              '+
                   ' RED_CONCIL = :CONCIL            '+
                   ' WHERE RED_DTAPAG = :DTAPAG      '+
                   '   AND RED_VALLIQ = :VALLIQ      '+
                   '   AND RED_NUM_RV = RIGHT(:NUM_RV, LENGTH(RED_NUM_RV))  ';

    If ABaixa Then
      LSQLAjuste := LSQLAjuste + '  AND RED_NUM_PV = :NUM_PV ' ;

    Try
      LConcil.Close;
      LConcil.Sql.Clear;
      LConcil.Sql.Add(LSQLAjuste);

      LConcil.ParamByName('DTAPAG').AsDateTime   := ACartao.FieldByName('MCA_DTAREC').AsDateTime;
      LConcil.ParamByName('NUM_RV').AsString   := ACartao.FieldByName('MCA_NUMNSU').AsString;
      LConcil.ParamByName('VALLIQ').AsFloat   := ACartao.FieldByName('MCA_VALSTA').AsFloat;
      LConcil.ParamByName('CONCIL').AsInteger  := TRedeCardFuncoes.IIF(ABaixa, 1, 0);

      If ABaixa Then
        LConcil.ParamByName('NUM_PV').Value  := ACartao.FieldByName('MCA_ESTABE').AsString;

      LConcil.ExecSQL;
    Except
      On E : Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  Finally
    FreeAndNil(LConcil);
  End;
end;


Class procedure TConciliacaoRedeCardAPI.MarcarAjusteVendaComoConciliado(
  ABaixa: Boolean; ACartao: TUniClientDataSet);
  Var
    LSQLAjuste: String;
    LConcil : TUniQuery;
begin
  LConcil := VS_FuncoesExternas.fICriaQuery;
  Try
    LSQLAjuste :=  'UPDATE                                                 '+
                   '  RED_APVPGO                                           '+
                   'SET                                                    '+
                   '  RED_CONCIL = :CONCIL                                 '+
                   'WHERE (                                                '+
                   '    (RED_CODAUT = :NUMCCD)                             '+
                   '    OR (                                               '+
                   '      RED_NUMNSU = RIGHT(:NUMNSU, LENGTH(RED_NUMNSU))  '+
                   '    )                                                  '+
                   '  )                                                    '+
                   '  AND RED_NUMPAR = :NUMPAR                             '+
                   '  AND RED_DTAVEN = :DTA_RV                             '+
                   '  AND RED_CONCIL = :FILCON                             '+
                   '  AND RED_STATUS IN ("UNBOOK")                         ';

    If ABaixa Then
      LSQLAjuste := LSQLAjuste + '  AND RED_NUM_PV = :NUM_PV ' ;

    Try
      LConcil.Close;
      LConcil.Sql.Clear;
      LConcil.Sql.Add(LSQLAjuste);

      LConcil.ParamByName('NUMCCD').AsString   := ACartao.FieldByName('MCA_NUMCCD').AsString;
      LConcil.ParamByName('NUMNSU').AsString   := ACartao.FieldByName('MCA_NUMNSU').AsString;
      LConcil.ParamByName('NUMPAR').Value      := IntToStr(TRedeCardFuncoes.fGetPosLetraAlfa(ACartao.FieldByName('PARDUP').AsString));
      LConcil.ParamByName('DTA_RV').AsDateTime := ACartao.FieldByName('MCA_DTACUP').AsDateTime;
      LConcil.ParamByName('FILCON').AsInteger  := TRedeCardFuncoes.IIF(ABaixa, 0, 1);
      LConcil.ParamByName('CONCIL').AsInteger  := TRedeCardFuncoes.IIF(ABaixa, 1, 0);

      If ABaixa Then
        LConcil.ParamByName('NUM_PV').Value  := ACartao.FieldByName('MCA_ESTABE').AsString;

      LConcil.ExecSQL;
    Except
      On E : Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  Finally
    FreeAndNil(LConcil);
  End;
end;

function TConciliacaoRedeCardAPI.MarcarVendaComoConciliada: Boolean;
begin
  Result := True;

  If FCdsRegistrosMovimento.FieldByName('PAGAMENTO_UNICO').AsString = 'S' Then
  Begin
    If Not (FCdsRegistrosMovimento.FieldByName('VP_RED_NUMPAR').AsInteger = FCdsRegistrosMovimento.FieldByName('V_RED_TOTPAR').AsInteger ) Then
    Begin
      Result := False;
      FCdsRegistrosMovimento.Edit;
      FCdsRegistrosMovimento.FieldByName('VP_RED_NUMPAR').AsInteger := FCdsRegistrosMovimento.FieldByName('VP_RED_NUMPAR').AsInteger + 1;
      FCdsRegistrosMovimento.Post;
    End;
  End;

end;

procedure TConciliacaoRedeCardAPI.pCalculaPeriodoFiltro(ACdsBase : TUniClientDataSet);
begin
  If (Assigned(ACdsBase)) And (Not ACdsBase.IsEmpty) Then
  Begin
    ACdsBase.IndexFieldNames := 'VP_RED_DTA_RV';
    ACdsBase.First;

    If dtaDtaIni > ACdsBase.FieldByName('VP_RED_DTA_RV').Value Then
      dtaDtaIni := ACdsBase.FieldByName('VP_RED_DTA_RV').Value;

    While Not ACdsBase.Eof Do
    Begin
      If lstDtaCad.IndexOf(FormatDateTime('yyyy-mm-dd', ACdsBase.FieldByName('VP_RED_DTA_RV').Value)) < 0 Then
        lstDtaCad.Add(FormatDateTime('yyyy-mm-dd', ACdsBase.FieldByName('VP_RED_DTA_RV').Value));

      ACdsBase.Next;
    End;
    ACdsBase.Last;

    If dtaDtaFim < ACdsBase.FieldByName('VP_RED_DTA_RV').Value Then
      dtaDtaFim := ACdsBase.FieldByName('VP_RED_DTA_RV').Value;
  End;

end;

procedure TConciliacaoRedeCardAPI.pCriaDataSets;
  Var
    LQueryPagamento,
    LQueryMovimento,
    LQueryAjustes : TUniQuery;
begin
  LQueryPagamento := Nil;
  LQueryMovimento := Nil;
  LQueryAjustes := Nil;

  Try
    LQueryPagamento := VS_FuncoesExternas.fICriaQuery;

    //CONCILIAÇÃO FINANCEIRA
    LQueryPagamento.SQL.Text := ' SELECT               '+
                                '      SUM(P.RED_VALBRU) AS RED_VALBRU,     '+
                                '      SUM(P.RED_VALBRU - P.RED_VALDES) AS RED_VALLIQ, '+
                                '      P.RED_NUM_PV,     '+
                                '      EMP_CODEMP,       '+
                                '      P.RED_NUMORD,     '+
                                '      P.RED_CONCIL,     '+
                                '      P.RED_NUM_RV,     '+
                                '      P.RED_DTAPAG,     '+
                                '      P.RED_DTAIMP,     '+
                                '  SUM(P.RED_VALDES) AS RED_VALDES,     '+
                                '      P.RED_TIPREG,     '+
                                '      P.RED_PAG_ID,     '+
                                '      IF(COUNT(0) > 1 AND COUNT(DISTINCT P.RED_VALBRU) = 1 AND COUNT(DISTINCT P.RED_VALDES) = 1, "S", "N") AS PAGAMENTO_DIVIDIDO, ';
    If FPossuiCampoCCA_CCAGRA Then
    Begin
      LQueryPagamento.SQL.Add('      POR_CODPOR AS PORTADOR_GRAVAME, ');
      LQueryPagamento.SQL.Add('      DIR.RED_STATUS AS STATUS_PAGAMENTO, ');

      LQueryPagamento.SQL.Add('(SELECT                                                                                           '+
                              '  SUM(A.RED_VALAJU)                                                                               '+
                              'FROM                                                                                              '+
                              '  RED_APAJUS A                                                                                    '+
                              'WHERE A.RED_DOCNUM = DIR.RED_NUMDOC                                                               '+
                              '  AND A.RED_DTAPAG = DIR.RED_DTAPAG                                                               '+
                              '  AND TRIM(LEADING 0 FROM A.RED_NUM_PV) = TRIM(LEADING 0 FROM DIR.RED_NUM_PV)) AS AJUSTE_DEBITADO ');
    End
    Else
    Begin
      LQueryPagamento.SQL.Add('      NULL AS PORTADOR_GRAVAME, ');
      LQueryPagamento.SQL.Add('      NULL AS STATUS_PAGAMENTO, ');
      LQueryPagamento.SQL.Add('      0.00 AS AJUSTE_DEBITADO ');
    End;

    LQueryPagamento.SQL.Add('   FROM RED_APPGTO P    '+
                            '      LEFT JOIN CFGSIS                                   '+
                            '        ON LOCATE(TRIM(LEADING 0 FROM P.RED_NUM_PV), TRIM(LEADING 0 FROM SIS_VALCFG)) > 0  '+
                            '        AND SIS_CODCFG IN ("CFG_REDEST", "CFG_REDECO")   '+
                            '      LEFT JOIN CADEMP                                   '+
                            '        ON SIS_CODEMP = EMP_CODEMP                       ');

    If FPossuiCampoCCA_CCAGRA Then
      LQueryPagamento.SQL.Add('      LEFT JOIN RED_PGODIR DIR                                                      '+
                              '        ON DIR.RED_DTAPAG = P.RED_DTAPAG                                            '+
                              '        AND DIR.RED_PAG_ID = P.RED_PAG_ID                                           '+
                              '        AND DIR.RED_STATUS IN("PAID","SUSPENDED")                                   '+
                              '        AND TRIM(LEADING 0 FROM DIR.RED_NUM_PV) = TRIM(LEADING 0 FROM P.RED_NUM_PV) '+
                              '      LEFT JOIN CADCCA                                                              '+
                              '        ON CCA_CODCTA = LEFT(RED_NUMCON, LENGTH(CCA_CODCTA))                        '+
                              '        AND CCA_DIGCTA = RIGHT(RED_NUMCON, LENGTH(CCA_DIGCTA))                      '+
                              '        AND TRIM(LEADING 0 FROM CCA_AGENCI) = TRIM(LEADING 0 FROM RED_CODAGE)       '+
                              '        AND TRIM(LEADING 0 FROM CCA_CODBCO) = TRIM(LEADING 0 FROM RED_CODBCO)       '+
                              '        AND CCA_CCAGRA = "S"                                                        '+
                              '      LEFT JOIN CADPOR                                                              '+
                              '        ON POR_CCAAUT = CADCCA.AUTOINCREM                                           ');

    LQueryPagamento.SQL.Add(' WHERE P.RED_DTAPAG BETWEEN :DTAINI AND :DTAFIM                                     ');

    if not TRedeCardFuncoes.fEmptyStr(SFiltroEstabelecimento) then
      LQueryPagamento.SQL.Text := LQueryPagamento.SQL.Text +
                                  StringReplace(SFiltroEstabelecimento,objConcil.CampoEstabelecimento,'P.'+objConcil.CampoEstabelecimento,[rfReplaceAll]);

    LQueryPagamento.SQL.Text := LQueryPagamento.SQL.Text +
                                ' GROUP BY P.RED_NUM_PV,   '+
                                '          P.RED_NUM_RV,   '+
                                '          P.RED_DTAPAG,   '+
                                '          P.RED_TIPREG    ';

    if not FConciliaPorRV.Equals('S') then
    begin
      LQueryPagamento.SQL.Text := LQueryPagamento.SQL.Text +
                                '         ,P.RED_PAG_ID    ';
    end;

    LQueryPagamento.SQL.Text := LQueryPagamento.SQL.Text +
                                '   ORDER BY P.RED_NUMORD  ';

    LQueryPagamento.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaIni);
    LQueryPagamento.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaFim);
    LQueryPagamento.Open;
    FCdsRegistrosPagamento := TRedeCardFuncoes.CriarClientDataSet(LQueryPagamento);
    FCdsRegistrosPagamento.Open;
    Application.ProcessMessages;

    //DEBITOS E CREDITOS
    LQueryMovimento := VS_FuncoesExternas.fICriaQuery;
    LQueryMovimento.SQL.Text := RetornaSqlVendas;
    LQueryMovimento.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaIni);
    LQueryMovimento.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaFim);
    LQueryMovimento.Open;
    FCdsRegistrosMovimento := TRedeCardFuncoes.CriarClientDataSet(LQueryMovimento);
    FCdsRegistrosMovimento.Open;
    Application.ProcessMessages;

    //AJUSTES
    LQueryAjustes := VS_FuncoesExternas.fICriaQuery;
    LQueryAjustes.SQL.Text := ' SELECT                                                              '+
                              '    *                                                                '+
                              '   FROM RED_APAJUS                                                   '+
                              '   LEFT JOIN CFGSIS C ON LOCATE(TRIM(LEADING 0 FROM RED_NUM_PV), TRIM(LEADING 0 FROM SIS_VALCFG)) > 0 '+
                              '                     AND C.SIS_CODCFG IN ("CFG_REDEST","CFG_REDECO") '+
                              '   LEFT JOIN CADEMP E ON C.SIS_CODEMP = E.EMP_CODEMP                 '+
                              ' WHERE  RED_CONCIL = 0                                               '+
                              ' AND RED_VALAJU <> 0                                                 '+
                              ' AND RED_DTAPAG BETWEEN :DTAINI AND :DTAFIM                          '+
                              ' AND LENGTH(RED_NUMDEB) >= 7                                         ';

    if not TRedeCardFuncoes.fEmptyStr(SFiltroEstabelecimento) then
      LQueryAjustes.SQL.Text := LQueryAjustes.SQL.Text +
                                StringReplace(SFiltroEstabelecimento,
                                              objConcil.CampoEstabelecimento,
                                              objConcil.CampoEstabelecimento,
                                              [rfReplaceAll]);

    LQueryAjustes.SQL.Text := LQueryAjustes.SQL.Text   +
                             ' GROUP BY RED_VALAJU,   '+
                             '   RED_VALPAG,          '+
                             '   RED_DTA_RV,          '+
                             '   RED_NUMPED,          '+
                             '   RED_DTAEXP,          '+
                             '   RED_NUM_RV,          '+
                             '   RED_NUMDEB           ';

    LQueryAjustes.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaIni);
    LQueryAjustes.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaFim);

    LQueryAjustes.Open;
    FCdsRegistrosAjuste := TRedeCardFuncoes.CriarClientDataSet(LQueryAjustes);
    FCdsRegistrosAjuste.Open;
    Application.ProcessMessages;
  Finally
    TRedeCardFuncoes.FreeAndNilDatasets(LQueryPagamento);
    TRedeCardFuncoes.FreeAndNilDatasets(LQueryMovimento);
    TRedeCardFuncoes.FreeAndNilDatasets(LQueryAjustes);

    VS_FuncoesExternas.pITrimAppMemorySize;
  End;
end;

procedure TConciliacaoRedeCardAPI.pFiltraAjustesRedeCardAPI;
  Var
    LEmpresaConfiguracao: String;

    LRegistroRelatorio: TItensRelatorioCartoes;
begin
  Try
    FCdsRegistrosAjuste.First;
    While Not FCdsRegistrosAjuste.Eof Do
    Begin
      LEmpresaConfiguracao := TRedeCardFuncoes.IIF(TRedeCardFuncoes.fEmptyStr(FCdsRegistrosAjuste.FieldByName('EMP_CODEMP').AsString),
                                                   VS_FuncoesExternas.fIRetEmpresaLogada,
                                                   FCdsRegistrosAjuste.FieldByName('EMP_CODEMP').AsString);
      If Not TRedeCardFuncoes.fEmptyStr(objConcil.CodigoEmpresaFixaParaBaixa) Then
        LEmpresaConfiguracao := objConcil.CodigoEmpresaFixaParaBaixa;

      LRegistroRelatorio := TItensRelatorioCartoes.Create;

      LRegistroRelatorio.ValorBruto := TRedeCardFuncoes.fFormataFloat(FCdsRegistrosAjuste.FieldByName('RED_VALAJU').Value * -1, 2);
      LRegistroRelatorio.ValorLiquido := TRedeCardFuncoes.fFormataFloat(FCdsRegistrosAjuste.FieldByName('RED_VALAJU').Value * -1, 2);

      LRegistroRelatorio.Descricao := 'Cancelamentos/Ajustes';
      LRegistroRelatorio.TipoDoRegistro := 'AJUSTES';
      LRegistroRelatorio.TipoCartao := 'CANCELAMENTOS/AJUSTES';
      LRegistroRelatorio.DescricaoAjuste := UpperCase(FCdsRegistrosAjuste.FieldByName('RED_DESAJU').Value);

      LRegistroRelatorio.CodigoEmpresa := LEmpresaConfiguracao;
      LRegistroRelatorio.CodigoEstabelecimento := FCdsRegistrosAjuste.FieldByName('RED_NUM_PV').AsString;
      LRegistroRelatorio.NumeroNSU := EmptyStr;
      LRegistroRelatorio.NumeroCartao := EmptyStr;
      LRegistroRelatorio.Parcela := '01';
      LRegistroRelatorio.TotalParcelas := '01';
      LRegistroRelatorio.CodigoAutorizacao := TRedeCardFuncoes.fStrZero('0', 6);

      LRegistroRelatorio.DataVenda := FCdsRegistrosAjuste.FieldByName('RED_DTAPAG').Value;
      LRegistroRelatorio.DataPagamento := FCdsRegistrosAjuste.FieldByName('RED_DTAPAG').Value;
      LRegistroRelatorio.DataVencimento := FCdsRegistrosAjuste.FieldByName('RED_DTAPAG').Value;

      LRegistroRelatorio.Conciliado := FCdsRegistrosAjuste.FieldByName('RED_CONCIL').AsInteger;
      LRegistroRelatorio.NomeArquivo := '[RedeCard Online] - Data de Importação: ' +
                                        FormatDateTime('dd/mm/yyyy',FCdsRegistrosAjuste.FieldByName('RED_DTAIMP').AsDateTime);

      LRegistroRelatorio.RegistroIncompleto := 'N';
      If FBaixarAjustes Then
      Begin
        LRegistroRelatorio.RegistroIncompleto := ConfiguracoesAjustesEstaoIncompletas(LEmpresaConfiguracao);

        GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio);
      End;

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      FCdsRegistrosAjuste.Next;
    End;

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

function TConciliacaoRedeCardAPI.Reabrir(AConfirma: Boolean): Boolean;
begin
  Result := Not AConfirma;
end;

function TConciliacaoRedeCardAPI.RetornaFiltroSqlVendas(APrefixo: String): String;
begin
  If Not TRedeCardFuncoes.fEmptyStr(SFiltroEstabelecimento) then
    Result := Result + StringReplace(SFiltroEstabelecimento,objConcil.CampoEstabelecimento, 'VP.'+objConcil.CampoEstabelecimento, [rfReplaceAll]);

  // AGRUPAR PQ PODE TER X PAGAMENTOS PARA O MESMO RESUMO DE VENDA
  Result :=  Result + '  GROUP BY PG.RED_NUM_PV,PG.RED_NUM_RV,PG.RED_DTAPAG,    '+
                      '           VP.RED_NUMNSU ,V.RED_CODAUT, VP.RED_NUMPAR    ';

  If Not TRedeCardFuncoes.fEmptyStr(APrefixo) Then
    Result :=  StringReplace(Result,'V.',APrefixo, [rfReplaceAll]);

end;

function TConciliacaoRedeCardAPI.RetornaInAutorizacaoFiltrar: String;
  Var
    LValor: String;
begin
  Result := '""';

  FCdsRegistrosMovimento.First;
  While Not FCdsRegistrosMovimento.Eof Do
  Begin
    LValor := '"' + TRedeCardFuncoes.fStrZero(FCdsRegistrosMovimento.FieldByName('V_RED_CODAUT').AsString, 6) + '"';

    If Pos(LValor, Result) > 0 Then
    Begin
      FCdsRegistrosMovimento.Next;
      Continue;
    End;

    Result := Result + ',' + LValor;

    If FCdsRegistrosMovimento.FieldByName('V_RED_CODAUT').AsString.Length < 6 Then
    Begin
      LValor := '"' + FCdsRegistrosMovimento.FieldByName('V_RED_CODAUT').AsString + '"';

      If Result.Contains(LValor) Then
      Begin
        FCdsRegistrosMovimento.Next;
        Continue;
      End;

      Result := Result + ',' + LValor;
    End;

    FCdsRegistrosMovimento.Next;
  End;

  FCdsRegistrosMovimento.First;
end;

function TConciliacaoRedeCardAPI.RetornaInNsuFiltrar: String;
   Var
    LValor: String;
begin
  Result := '""';

  FCdsRegistrosMovimento.First;
  While Not FCdsRegistrosMovimento.Eof Do
  Begin
    LValor := '"' + TRedeCardFuncoes.fStrZero(FCdsRegistrosMovimento.FieldByName('VP_RED_NUMNSU').AsString, 14) + '"';

    If Pos(LValor, Result) > 0 Then
    Begin
      FCdsRegistrosMovimento.Next;
      Continue;
    End;

    Result := Result + ',' + LValor;

    FCdsRegistrosMovimento.Next;
  End;

  FCdsRegistrosMovimento.First;
end;

function TConciliacaoRedeCardAPI.RetornaSqlVendas: String;
begin

  Result := 'SELECT * FROM (            '+
            '    SELECT                 '+
            '     "N" AS VP_CONCILIADA, '+
            '      EMP_CODEMP,          '+
            '      EMP_NOMEMP,          '+
            '      PG.RED_PAG_ID AS V_RED_PAG_ID, '+
            '      V.RED_NUM_PV AS V_RED_NUM_PV,     '+
            '      V.RED_NUM_RV AS V_RED_NUM_RV,     '+
            '      V.RED_TIPREG AS V_RED_TIPREG,     '+
            '      V.RED_TOTPAR AS V_RED_TOTPAR,     '+
            '      V.RED_DTAVEN AS V_RED_DTAVEN,     '+
            '      VP.RED_VEN_RV AS VP_RED_VEN_RV,   '+
            '      CAST( IFNULL(VP.RED_NUMPAR,"0") AS DECIMAL) AS VP_RED_NUMPAR,   '+
            '      VP.RED_NUMNSU AS VP_RED_NUMNSU,   '+
            '      TRIM(LEADING 0 FROM V.RED_CODAUT) AS V_RED_CODAUT,     '+
            '      VP.RED_DTA_RV AS VP_RED_DTA_RV,   '+
            '      VP.RED_NUM_PV AS VP_RED_NUM_PV,   '+
            '      VP.RED_NUM_RV AS VP_RED_NUM_RV,   '+
            '      VP.RED_LIQPAR AS VP_RED_LIQPAR,   '+
            '     (VP.RED_BRU_RO/VP.RED_TOTPAR) AS VP_RED_VALPAR,   '+
            '      VP.RED_VALPAR AS VP_RED_BRUPAR,    '+
            '      VP.RED_CONCIL AS VP_RED_CONCIL,   '+
            '      PG.RED_DTAPAG AS VP_RED_DTAPAG,   '+
            ' ROUND(((VP.RED_VALDES - VP.RED_VALMDR) / VP.RED_VALPAR) * 100, 2) AS TAXA_ANTECIPACAO_FLEX, '+
            '      IF(V.RED_E_FLEX = "S", "S", "N") AS FLAG_FLEX_API, ' +
            '      V.RED_NUMCAR AS V_RED_NUMCAR,     '+
            '      "PAID" AS STATUS,                 '+
            '      IF((CAST(IFNULL(VP.RED_TOTPAR, "0") AS DECIMAL) > 1)                  '+
            '          AND (VP.RED_BRU_RO = VP.RED_VALPAR),"S","N") AS PAGAMENTO_UNICO   '+
            '    FROM                                                 '+
            '      RED_APVPAR VP                                      '+
            '      INNER JOIN RED_APVEND V                            '+
            '        ON VP.RED_NUM_PV = V.RED_NUM_PV                  '+
            '        AND VP.RED_NUM_RV = V.RED_NUM_RV                 '+
            '        AND VP.RED_NUMNSU = V.RED_NUMNSU                 '+
            '        AND VP.RED_DTAVEN = V.RED_DTAVEN                 '+
            '      INNER JOIN RED_APPGTO PG                           '+
            '        ON VP.RED_NUM_PV = PG.RED_NUM_PV                 '+
            '        AND VP.RED_NUM_RV = PG.RED_NUM_RV                '+
            '        AND VP.RED_VEN_RV = PG.RED_DTAPAG                '+
            '      LEFT JOIN CFGSIS                                   '+
            '        ON LOCATE(TRIM(LEADING 0 FROM VP.RED_NUM_PV), TRIM(LEADING 0 FROM SIS_VALCFG)) > 0  '+
            '        AND SIS_CODCFG IN ("CFG_REDEST", "CFG_REDECO")   '+
            '      LEFT JOIN CADEMP                                   '+
            '        ON SIS_CODEMP = EMP_CODEMP                       '+
            '    WHERE  PG.RED_DTAPAG BETWEEN :DTAINI AND :DTAFIM     '+
            RetornaFiltroSqlVendas;

  Result := Result + 'UNION ALL';

  Result := Result +
            '    SELECT                 '+
            '     "N" AS VP_CONCILIADA, '+
            '      EMP_CODEMP,          '+
            '      EMP_NOMEMP,          '+
            '      VP.RED_PAG_ID AS V_RED_PAG_ID,     '+
            '      VP.RED_NUM_PV AS V_RED_NUM_PV,     '+
            '      VP.RED_NUM_RV AS V_RED_NUM_RV,     '+
            '      LEFT(VP.RED_TIPREG,3) AS V_RED_TIPREG,     '+
            '      VP.RED_TOTPAR AS V_RED_TOTPAR,     '+
            '      VP.RED_DTAVEN AS V_RED_DTAVEN,     '+
            '      VP.RED_VEN_RV AS VP_RED_VEN_RV,    '+
            '      CAST( IFNULL(VP.RED_NUMPAR,"0") AS DECIMAL)  AS VP_RED_NUMPAR,   '+
            '      VP.RED_NUMNSU AS VP_RED_NUMNSU,    '+
            '      TRIM(LEADING 0 FROM VP.RED_CODAUT) AS V_RED_CODAUT,     '+
            '      VP.RED_DTAVEN AS VP_RED_DTA_RV,    '+
            '      VP.RED_NUM_PV AS VP_RED_NUM_PV,    '+
            '      VP.RED_NUM_RV AS VP_RED_NUM_RV,    '+
            '      IF(VP.RED_ALTVLR = "true", IF(VP.RED_VALLIQ > 0, VP.RED_VALLIQ, VP.RED_LIQPAR), VP.RED_LIQPAR) AS VP_RED_LIQPAR,    ';

  if FConciliaPorRV.Equals('S') then
  begin
      Result := Result +
            '      IF(VP.RED_VALBRU > 0.00,VP.RED_VALBRU,VP.RED_BRUPAR) AS VP_RED_VALPAR,    ';
  end
  else
  begin
      {* Venda com alteração de valor: o bruto pago é o efetivo (RED_VALBRU), não o
         original (RED_BRUPAR) - mesmo tratamento que VP_RED_LIQPAR faz acima.
         Registro UNBOOK chega com RED_VALBRU = 0, daí o recuo para RED_BRUPAR.
         Fora da alteração de valor nada muda: segue o recuo que já existia aqui. *}
      Result := Result +
            '      IF(VP.RED_ALTVLR = "true", IF(VP.RED_VALBRU > 0, VP.RED_VALBRU, VP.RED_BRUPAR), IF(VP.RED_BRUPAR > 0, VP.RED_BRUPAR, VP.RED_VALBRU)) AS VP_RED_VALPAR,    ';
  end;

  Result := Result +
            '      VP.RED_BRUPAR AS VP_RED_BRUPAR,    '+
            '      VP.RED_CONCIL AS VP_RED_CONCIL,    '+
            '      PG.RED_DTAPAG AS VP_RED_DTAPAG,    '+
            ' ROUND(((VP.RED_VALDES - VP.RED_VALMDR) / VP.RED_VALBRU) * 100, 2) AS TAXA_ANTECIPACAO_FLEX, '+
            '      IF(VP.RED_TAXFLE > 0, "S", "N") AS FLAG_FLEX_API, '+
            '      VP.RED_NUMCAR AS V_RED_NUMCAR,     '+
            '      VP.RED_STATUS AS STATUS,            '+
            '      IF((CAST(IFNULL(VP.RED_TOTPAR, "0") AS DECIMAL) > 1)                  '+
            '          AND (VP.RED_BRU_RO = VP.RED_BRUPAR),"S","N") AS PAGAMENTO_UNICO   '+
            '    FROM                                                 '+
            '      RED_APVPGO VP                                      '+
            '      INNER JOIN RED_APPGTO PG                           '+
            '        ON VP.RED_NUM_PV = PG.RED_NUM_PV                 '+
            '        AND VP.RED_NUM_RV = PG.RED_NUM_RV                '+
            '        AND ( (VP.RED_VEN_RV = PG.RED_DTAPAG)  OR  (VP.RED_PAG_ID = PG.RED_PAG_ID)  )  '+
            '      LEFT JOIN CFGSIS                                   '+
            '        ON LOCATE(TRIM(LEADING 0 FROM VP.RED_NUM_PV), TRIM(LEADING 0 FROM SIS_VALCFG)) > 0  '+
            '        AND SIS_CODCFG IN ("CFG_REDEST", "CFG_REDECO")   '+
            '      LEFT JOIN CADEMP                                   '+
            '        ON SIS_CODEMP = EMP_CODEMP                       '+
            '    WHERE  PG.RED_DTAPAG BETWEEN :DTAINI AND :DTAFIM     '+
            '           AND VP.RED_STATUS IN ("PAID","ANTICIPATED","SCHEDULLED","UNBOOK")  '+
            RetornaFiltroSqlVendas('VP.')                              +
            ') VENDAS                                                 '+
            'GROUP BY VP_RED_NUM_PV,                                  '+
            '  VP_RED_NUM_RV,                                         '+
            '  VP_RED_DTAPAG,                                         '+
            '  VP_RED_NUMNSU,                                         '+
            '  VP_RED_NUMPAR                                          '+
            'ORDER BY VP_RED_NUMPAR                                   ';


end;

function TConciliacaoRedeCardAPI.RetornaTipoRegistro: String;
begin
  Result := FCdsRegistrosPagamento.FieldByName('RED_TIPREG').AsString;

 If (FCdsRegistrosMovimento.FieldByName('FLAG_FLEX_API').AsString = 'S') Then
    Result := 'ANT';
end;

function TConciliacaoRedeCardAPI.TemRegistrosImportados: Boolean;
begin
  Result := False;
  If (Not FCdsRegistrosPagamento.IsEmpty) Then
    Exit(True)
  Else If (Not FCdsRegistrosAjuste.IsEmpty) Then
    Exit(True);
end;

procedure TConciliacaoRedeCardAPI.ValidaCartaoEncontrado(Var ABusca : Boolean;
                                                         Var ADivergenciaCartao : String;
                                                         AClient: TUniClientDataSet);
  Var
    LDiferenca : Double;
begin
  If Not ABusca Then
    Exit;

  // Valor Bruto
  LDiferenca := TRedeCardFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - RetornaValorBrutoParcela, 2);

  LTolerancia := RetornaValorTolerancia(AClient.FieldByName('EMP_CODEMP').AsString);
  If Not TRedeCardFuncoes.fBetween(LDiferenca, -LTolerancia, LTolerancia) Then
  Begin
    LDiferenca := TRedeCardFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - AClient.FieldByName('VP_RED_BRUPAR').AsFloat, 2);

    If TRedeCardFuncoes.fBetween(LDiferenca, -LTolerancia, LTolerancia) Then
    Begin
      AClient.Edit;
      AClient.FieldByName('VP_RED_VALPAR').AsFloat := AClient.FieldByName('VP_RED_BRUPAR').AsFloat;
      AClient.Post;

      Exit;
    End;

    ADivergenciaCartao := 'Valor do cartão diferente do registrado no sistema ou Autorização/NSU duplicado';
    ABusca := False;
    Exit;
  End;
end;

procedure TConciliacaoRedeCardAPI.ValidaCartaoMarcado(var ADivergenciaCartao: String);
begin
  If Not cdsBaiCar.FieldByName('MCA_MARDES').AsString.Equals('M') Then
    Exit;

  // Taxa Administrativa
  If PossuiDivergenciaEntreATaxaPagaPelaTaxaCadastrada(RetornaValorBrutoParcela,cdsBaiCar) Then
  Begin
    ADivergenciaCartao := RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa;
    Exit;
  end;

end;

function TConciliacaoRedeCardAPI.RetornaValorBrutoParcela: Double;
  Var
    LValorBrutoVenda: Double;
    LDiferenca: Double;
begin

  Result := FCdsRegistrosMovimento.FieldByName('VP_RED_VALPAR').AsFloat;

  If FCdsRegistrosMovimento.FieldByName('PAGAMENTO_UNICO').AsString <> 'S' Then
    Exit;

  Result := RoundTo(FCdsRegistrosMovimento.FieldByName('VP_RED_BRUPAR').AsFloat /
                    FCdsRegistrosMovimento.FieldByName('V_RED_TOTPAR').AsInteger,-2);

  LValorBrutoVenda := FCdsRegistrosMovimento.FieldByName('V_RED_TOTPAR').AsInteger  * Result;

  LDiferenca :=  FCdsRegistrosMovimento.FieldByName('VP_RED_BRUPAR').AsFloat - LValorBrutoVenda;

  {* Se tiver diferença, joga a mesma para a primeira parcela *}
  If (RoundTo(LDiferenca, -2) <> 0) Then
  Begin
    If (FCdsRegistrosMovimento.FieldByName('VP_RED_NUMPAR').AsInteger = 1) Then
    Begin
      Result := RoundTo(Result + LDiferenca, -2);
    End;
  End;
end;

function TConciliacaoRedeCardAPI.RetornaValorLiquidoParcela: Double;
  Var
    LValorLiquidoVenda : Double;
    LDiferenca: Double;
begin
  Result := FCdsRegistrosMovimento.FieldByName('VP_RED_LIQPAR').AsFloat;

  {*
     Pagamento dividido (PAGAMENTO_DIVIDIDO, em pCriaDataSets): a Rede paga o RV em mais
     de uma ordem de crédito e cada ordem repete o bruto e a taxa do RV inteiro, então o
     RED_VALLIQ do pagamento vem multiplicado pelo número de ordens. Aí vale o líquido
     da própria venda.
  *}

  If (FCdsRegistrosMovimento.RecordCount = 1) Then
  begin
    If (FCdsRegistrosPagamento.FieldByName('RED_TIPREG').AsString <> 'ANT') And
       (FCdsRegistrosPagamento.FieldByName('PAGAMENTO_DIVIDIDO').AsString <> 'S') Then
    begin
      Result := FCdsRegistrosPagamento.FieldByName('RED_VALLIQ').AsFloat;
    end;
  end;

  If FCdsRegistrosMovimento.FieldByName('PAGAMENTO_UNICO').AsString <> 'S' Then
    Exit;

  Result := RoundTo(FCdsRegistrosMovimento.FieldByName('VP_RED_LIQPAR').AsFloat /
                    FCdsRegistrosMovimento.FieldByName('V_RED_TOTPAR').AsInteger,-2);

  LValorLiquidoVenda := FCdsRegistrosMovimento.FieldByName('V_RED_TOTPAR').AsInteger *  Result;

  LDiferenca :=  FCdsRegistrosMovimento.FieldByName('VP_RED_LIQPAR').AsFloat - LValorLiquidoVenda;

  {* Se tiver diferença, joga a mesma para a primeira parcela *}
  If (RoundTo(LDiferenca, -2) <> 0) Then
  Begin
    If (FCdsRegistrosMovimento.FieldByName('VP_RED_NUMPAR').AsInteger = 1) Then
    Begin
      Result := RoundTo(Result + LDiferenca, -2);
    End;
  End;

end;

function TConciliacaoRedeCardAPI.PagamentoCashback(AIdPagamento, AEstabelecimento: String; AValorPagamento: Double): Boolean;
  var
    LConsulta: TUniQuery;
begin
  Result := False;

  If Not FUtilizaCashback Then
    Exit;

  If TRedeCardFuncoes.fEmptyStr(AIdPagamento) Or
     TRedeCardFuncoes.fEmptyStr(AEstabelecimento) Then
    Exit(False);

  LConsulta := VS_FuncoesExternas.fICriaQuery;

  Try
    Try
      LConsulta.Close;
      LConsulta.SQL.Clear;
      LConsulta.SQL.Text :=
        'SELECT                           ' +
        ' COUNT(*) AS QTD                 ' +
        'FROM                             ' +
        '  RED_CASHBK                     ' +
        'WHERE                            ' +
        '      RED_PAG_ID = :RED_PAG_ID   ' +
        '  AND RED_NUM_PV = :RED_NUM_PV   ' +
        '  AND RED_VALLIQ = :RED_VALLIQ   ' +
        'LIMIT 1                          ';

      LConsulta.ParamByName('RED_PAG_ID').AsString := AIdPagamento;
      LConsulta.ParamByName('RED_NUM_PV').AsString := AEstabelecimento;
      LConsulta.ParamByName('RED_VALLIQ').AsFloat  := AValorPagamento;
      LConsulta.Open;

      Result := (LConsulta.FieldByName('QTD').AsInteger > 0);
    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  Finally
    FreeAndNil(LConsulta);
  End;
end;

procedure TConciliacaoRedeCardAPI.AjustaValorRecebidoComCancelamentoDeVendas;
Var
  LTotalAjustesCancelamento: Double;
  LTotalVendasValorLiquido: Double;
  LTotalVendasValorBruto: Double;
  LValorLiquidoPago: Double;
  LValorBrutoPago: Double;
  LDiferencaLiquida: Double;
  LEstabelecimentoAtual: String;
  LNumeroRVAtual: String;
begin

  If FCdsRegistrosPagamento.FieldByName('RED_TIPREG').AsString.Equals('ANT') Then
    Exit;

  LTotalAjustesCancelamento := 0;
  LTotalVendasValorLiquido := 0;
  LTotalVendasValorBruto := 0;

  // Obtém os valores do pagamento atual
  LValorLiquidoPago     := FCdsRegistrosPagamento.FieldByName('RED_VALLIQ').AsFloat;
  LValorBrutoPago       := FCdsRegistrosPagamento.FieldByName('RED_VALBRU').AsFloat;
  LEstabelecimentoAtual := FCdsRegistrosPagamento.FieldByName('RED_NUM_PV').AsString;
  LNumeroRVAtual        := FCdsRegistrosPagamento.FieldByName('RED_NUM_RV').AsString;

  // 1. Soma todas as vendas do filtro atual
  FCdsRegistrosMovimento.First;
  While Not FCdsRegistrosMovimento.Eof Do
  Begin
    LTotalVendasValorLiquido := LTotalVendasValorLiquido + RetornaValorLiquidoParcela;
    LTotalVendasValorBruto := LTotalVendasValorBruto + RetornaValorBrutoParcela;
    FCdsRegistrosMovimento.Next;
  End;
  FCdsRegistrosMovimento.First;

  If (TRedeCardFuncoes.fFormataFloat(LValorLiquidoPago,2) = TRedeCardFuncoes.fFormataFloat(LTotalVendasValorLiquido,2)) Then
    Exit;

  // 2. Soma todos os ajustes de cancelamento (RED_CODAJU = 18) para o mesmo estabelecimento e RV
  If Assigned(FCdsRegistrosAjuste) And (Not FCdsRegistrosAjuste.IsEmpty) Then
  Begin
    FCdsRegistrosAjuste.First;
    While Not FCdsRegistrosAjuste.Eof Do
    Begin
      If (FCdsRegistrosAjuste.FieldByName('RED_NUM_PV').AsString = LEstabelecimentoAtual) And
         (FCdsRegistrosAjuste.FieldByName('RED_NUM_RV').AsString = LNumeroRVAtual) And
         (FCdsRegistrosAjuste.FieldByName('RED_CODAJU').AsString = '18') Then
      Begin
        LTotalAjustesCancelamento := LTotalAjustesCancelamento +
                                     FCdsRegistrosAjuste.FieldByName('RED_VALAJU').AsFloat;
      End;
      FCdsRegistrosAjuste.Next;
    End;
    FCdsRegistrosAjuste.First;
  End;

  LDiferencaLiquida := TRedeCardFuncoes.fFormataFloat((LValorLiquidoPago - LTotalVendasValorLiquido),2);

  // 4. Se a diferença for igual ao valor dos ajustes de cancelamento
  If TRedeCardFuncoes.fFormataFloat(Abs(LDiferencaLiquida),2) = TRedeCardFuncoes.fFormataFloat(Abs(LTotalAjustesCancelamento),2)  Then
  Begin
    // Ajusta os valores no dataset de pagamento
    FCdsRegistrosPagamento.Edit;
    FCdsRegistrosPagamento.FieldByName('RED_VALLIQ').AsFloat := TRedeCardFuncoes.fFormataFloat(LValorLiquidoPago + LTotalAjustesCancelamento,2);
    FCdsRegistrosPagamento.FieldByName('RED_VALBRU').AsFloat := TRedeCardFuncoes.fFormataFloat(LValorBrutoPago + LTotalAjustesCancelamento,2);
    FCdsRegistrosPagamento.Post;

  End;
end;

end.
