unit untConciliaRecebiveisB2W;

interface

Uses System.Classes, Vcl.Forms, System.Types, System.Sysutils, System.StrUtils,
     System.Variants, Data.DB, Vcl.Graphics, System.Generics.Collections,
     System.DateUtils,

     Uni, UniClientDataSet, cxProgressBar,

     untTB2WFuncoes, untTLibCartoesMovCar, untLibCartoesInterfacesTipos,
     untB2WConciliaRecebiveis, untB2WTipos;


type TConcilB2W =  class(TConciliaRecebiveisMkt)
  private
    FCondicaoAjustes,
    FPeriodoFiltro,
    FListaDePedidos,
    FCartoesParaConciliacao : string;

    FListaArquivos: TStringList;

    FListaRegistrosConciliar,
    FListaRegistrosAjustesAgrupados  : TStringList;

    FAutoIncremRelatorio: Integer;

    procedure pFiltraCartoesB2W;
    procedure pFiltraCancelamentosB2W(var prgStatus: TcxProgressBar);
    procedure pFiltraCartoesBaixadosB2W;

    function GravaAjusteParaRegistrosCancelados(pgbStatus: TcxProgressBar): Boolean;

    function ExistemRegistrosImportados: Boolean;
    function AgruparERemoverRegistgrosDeFretesEAjustes: Boolean;
    function RetornaSQLConciliacao: String;
    function RetornaNomeArquivosConciliacao: String;

    function RegistroCancelado: Boolean;
    function fBuscaCartaoB2W: Boolean;
    function fBuscaCartaoBaixadoB2W: Boolean;
    function RetornaListaDePedidos: String;

    function fProcessaB2WPag(pgbStatus: TcxProgressBar = Nil): Boolean;

    function fConciliaB2W(prgStatus: TcxProgressBar): Boolean;

  public
    constructor Create; overload;
    destructor Destroy; override;

    function fConciliaCartoes(prgStatus: TcxProgressBar): Boolean; override;

    function RetornaEmpresaFiltrada: String;

    property AutoIncremRelatorio: Integer Read FAutoIncremRelatorio;
    property ListaRegistrosConciliar: TStringList read FListaRegistrosConciliar;
    property NomeArquivosConciliacao: String Read RetornaNomeArquivosConciliacao;
  protected

  end;

Const
  INICAM = 'B2W_';
  NOMTAB = 'B2W_B2PGTO';

implementation


function TConcilB2W.AgruparERemoverRegistgrosDeFretesEAjustes: Boolean;
begin

  cdsConCar.Filter := ' B2W_CODAUT=''' + cdsAjustes.FieldByName('B2W_CODAUT').AsString + ''' '+
                      ' AND B2W_TIPREG = ''Venda''  AND B2W_STATUS IN (''Liberado'',''Unlocke'') ';

  cdsConCar.Filtered := True;

  Try
    Result := Not cdsConcar.isEmpty;

    If Result Then
    Begin
      cdsConCar.Edit;
      If MatchStr(cdsAjustes.FieldByName('B2W_TIPREG').AsString,
        ['Comissão_sobre_o_frete', 'Despesa_inicial', 'Cancelamento_de_Comissão_sobre_o_frete']) Then
      Begin
          cdsConCar.FieldByName('REGISTROFRETE').Value := cdsConCar.FieldByName('REGISTROFRETE').Value +
                                                          cdsAjustes.FieldByName('B2W_VALBRU').Value ;

          cdsConCar.FieldByName('B2W_VALLIQ').Value := TB2WFuncoes.fFormataFloat(cdsConCar.FieldByName('B2W_VALLIQ').Value +
                                                       cdsAjustes.FieldByName('B2W_VALBRU').Value,2) ;
      end
      else If MatchStr(cdsAjustes.FieldByName('B2W_TIPREG').AsString,
        ['Comissao', 'Comissao_Cobrada', 'Comissao_Sem_Desbloqueio','Comissão_sobre_o_produto',
        'Tarifa_Adicional','Multa_Comercial', 'Comissao_Ressarcimento_Promocao', 'Comissão_Cobrada']) Then
      begin
        cdsConCar.FieldByName('REGISTROTAXA').Value :=   cdsConCar.FieldByName('REGISTROTAXA').Value + cdsAjustes.FieldByName('B2W_VALBRU').Value ;

        cdsConCar.FieldByName('B2W_VALLIQ').Value := TB2WFuncoes.fFormataFloat(cdsConCar.FieldByName('B2W_VALLIQ').Value +
                                                        cdsAjustes.FieldByName('B2W_VALBRU').Value ,2) ;
      end
      else If  MatchStr(cdsAjustes.FieldByName('B2W_TIPREG').AsString,
        ['Cancelamento_de_Comissão_sobre_o_produto', 'IR', 'Estorno_Comissao', 'Cancelamento_de_Item_de_venda',
        'Estorno_Comissao_Sem_Desbloqueio', 'Antecipacao_Seguro', 'Cancelamento_do_Crédito_de_ressarcimento',
        'Débito','Cancelamento_de_Venda', 'Estorno_Venda']) Then
      begin
        cdsConCar.FieldByName('REGISTROAJUSTE').Value := cdsConCar.FieldByName('REGISTROAJUSTE').Value +  cdsAjustes.FieldByName('B2W_VALBRU').Value ;

        cdsConCar.FieldByName('B2W_VALLIQ').Value := TB2WFuncoes.fFormataFloat(cdsConCar.FieldByName('B2W_VALLIQ').Value +
                                                        cdsAjustes.FieldByName('B2W_VALBRU').Value ,2) ;
      end
      else If MatchStr(cdsAjustes.FieldByName('B2W_TIPREG').AsString,
        ['Credito','Crédito_de_ressarcimento_do_seller_na_ca', 'Ressarcimento_promocao',
          'Complemento','Bonus', 'Bonus_SAC_MKTP', 'Diferenca_credito_desconto']) Then
      begin
        cdsConCar.FieldByName('CUPOMDESCONTO').Value := cdsConCar.FieldByName('CUPOMDESCONTO').Value +  cdsAjustes.FieldByName('B2W_VALBRU').Value;

        cdsConCar.FieldByName('B2W_VALLIQ').Value := TB2WFuncoes.fFormataFloat(cdsConCar.FieldByName('B2W_VALLIQ').Value +
                                                        cdsAjustes.FieldByName('B2W_VALBRU').Value ,2) ;
      end;

      cdsConCar.Post;

      Exit(True);
    End;

  Finally
    cdsConCar.Filter := '';
    cdsConCar.Filtered := False;
  End;
end;

constructor TConcilB2W.Create;
begin
  inherited;
end;

destructor TConcilB2W.Destroy;
begin
  If Assigned(FListaRegistrosConciliar) Then
   FreeAndNil(FListaRegistrosConciliar);
  inherited;
end;

function TConcilB2W.ExistemRegistrosImportados: Boolean;
begin
  Result := FListaRegistrosRelatorio.Count > 0;

  If Not Result Then
    Result := Not cdsAjustes.IsEmpty;

  If Not Result Then
    Result := Not cdsConcar.IsEmpty;
end;

function TConcilB2W.fBuscaCartaoB2W: Boolean;
begin
  Result := cdsBaiCar.Locate('MCA_NUMCCD;PARDUP;MCA_MARDES',
                             VarArrayOf([UpperCase(cdsConCar.FieldByName('B2W_NUMENT').AsString),
                                         'A', 'D']),[]);

  If Not Result Then
    Result := cdsBaiCar.Locate('MCA_NUMNSU;PARDUP;MCA_MARDES',
                                VarArrayOf([UpperCase(TB2WFuncoes.fStrZero(cdsConCar.FieldByName('B2W_NUMENT').AsString, 14)),
                                           'A', 'D']),[]);

  If Not Result Then
    Result := cdsBaiCar.Locate('MCA_NUMCCD;PARDUP;MCA_MARDES',
                              VarArrayOf([UpperCase(cdsConCar.FieldByName(objConcil.CampoCodigoAutorizacao).AsString),
                                         'A', 'D']),[]);

  If Not Result Then
    Result := cdsBaiCar.Locate('NSU_B2W;PARDUP;MCA_MARDES',
                                VarArrayOf([UpperCase(TB2WFuncoes.fStrZero(cdsConCar.FieldByName('B2W_NUMENT').AsString, 14)),
                                           'A', 'D']),[]);

end;

function TConcilB2W.fBuscaCartaoBaixadoB2W: Boolean;
begin

 Result := cdsBaixad.Locate('MCA_NUMCCD;MCA_PARCEL',
                             VarArrayOf([UpperCase(cdsConCar.FieldByName('B2W_CODAUT').AsString),
                                         'A']),[]);

  If Not Result Then
    Result := cdsBaixad.Locate('MCA_NUMNSU;MCA_PARCEL',
                               VarArrayOf([UpperCase(TB2WFuncoes.fStrZero(cdsConCar.FieldByName('B2W_NUMENT').AsString, 14)),
                                         'A']),[]);
end;

function TConcilB2W.fConciliaB2W(prgStatus: TcxProgressBar): Boolean;
Begin
  Result       := False;

  FCartoesParaConciliacao := VS_FuncoesExternas.fICfgSis('B2WCAR', varString, RetornaEmpresaFiltrada);

  If FCartoesParaConciliacao.IsEmpty Then
  Begin
    TB2WFuncoes.fMensagem('ATENÇÃO', 'Para realizar a baixa de recebíveis, deve selecionar os cartões referentes ' +
                                               'a B2W na configuração CFG_B2WCAR.', ['&Ok']);
    Exit;
  End;

  try
    Try
      FListaRegistrosConciliar := TStringList.Create;
      FListaRegistrosAjustesAgrupados := TStringList.Create;

      objConcil.TabelaConciliacao := NOMTAB;
      objConcil.CampoEstabelecimento := INICAM + 'CODEST';
      objConcil.NomeConciliacao := 'B2W';
      objConcil.CfgEstabelecimentos := 'CFG_B2WEST';
      objConcil.CampoValorBruto := INICAM + 'VALBRU';
      objConcil.CampoValorLiquido := INICAM + 'VALLIQ';
      objConcil.CampoCodigoAutorizacao := INICAM + 'CODAUT';
      objConcil.CampoNumeroNSU := INICAM + 'NUMENT';
      objConcil.CampoDataTransacaoVenda := INICAM + 'DTATRA';
      objConcil.CampoNumeroParcela := INICAM + 'NUMPAR';
      objConcil.CampoTotalParcelas := INICAM + 'TOTPAR';
      objConcil.CampoNumeroCartao := INICAM + 'NUMCAR';
      objConcil.CampoDataRecebimento := INICAM + 'DTAPAG';
      objConcil.CampoTipoRegistro := INICAM + 'TIPREG';
      objConcil.CampoTipoTransacao := INICAM + 'STATUS';
      objConcil.CfgPortadorAjustes := 'B2WPOR';
      objConcil.CfgPlanoDeContasAjustes := 'B2WCTA';
      objConcil.CfgFornecedorAjustes := 'B2WFOR';
      objConcil.strEventoCancelamentoAjuste := 'B2WEVE';

      objConcil.strChavePrimaria := 'B2W_TIPREG,B2W_CODEST,B2W_CODAUT,B2W_DTATRA,B2W_DTAPAG,B2W_NUMPAR,B2W_NUMENT';

      If Not CarregaFiltrosParaBaixaRecebiveis(DataInicioPeriodo,
                                                 DataFinalPeriodo,
                                                 EmpresasPeriodo) Then
          Exit(False);


      TB2WFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Selecionando registros para conciliação (B2W)', False);
      Result := fProcessaB2WPag(prgStatus);

      If Result Then
      Begin
        TB2WFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Selecionando registros para conciliação (B2W)', False);
        Result := GravaAjusteParaRegistrosCancelados(prgStatus);
      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmBaixaCartoes.fConcilia' + StringReplace(objConcil.NomeConciliacao, ' ', EmptyStr, []) + ']');
      End;
    End;

    cdsBaiCar.Filter   := 'MCA_MARDES=' + QuotedStr('M');
    cdsBaiCar.Filtered := True;

    PossuiInconsistencia := False;

    If Not TryStrToInt(FRelatorioConciliacao.AutoIncremRelatorio, FAutoIncremRelatorio) Then
      FAutoIncremRelatorio := 0;

    TB2WFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Gravando registros dos relatórios (' + objConcil.NomeConciliacao + ').', False);
    GravarRegistrosRelatorio(prgStatus);
  Finally
    FreeAndNil(FListaRegistrosAjustesAgrupados);
  End;
End;

function TConcilB2W.fConciliaCartoes(prgStatus: TcxProgressBar): Boolean;
begin
  FPeriodoFiltro := EmptyStr;

  Result := fConciliaB2W(prgStatus);
end;

function TConcilB2W.RetornaEmpresaFiltrada: String;
begin
  Result := EmpresasPeriodo[0].strCodigo;
end;

function TConcilB2W.RetornaListaDePedidos: String;
Var
  LSQL: String;

  LConsulta: TUniQuery;
begin
  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LSQL := 'SELECT DISTINCT B2W_CODAUT, B2W_NUMENT FROM B2W_B2PGTO WHERE ' + FPeriodoFiltro;

    LConsulta.SQL.Text := LSQL;
    LConsulta.Open;

    Result := EmptyStr;

    While Not LConsulta.Eof Do
    Begin
      If Not LConsulta.FieldByName('B2W_CODAUT').AsString.IsEmpty Then
        Result := Result + '"' + LConsulta.FieldByName('B2W_CODAUT').AsString + '",';

      If Not LConsulta.FieldByName('B2W_NUMENT').AsString.IsEmpty Then
        Result := Result + '"' + LConsulta.FieldByName('B2W_NUMENT').AsString + '",';

      LConsulta.Next;
    End;

    If Result.IsEmpty Then
      Exit('" "');

    Result := LeftStr(Result, Result.Length - 1);

  Finally
    TB2WFuncoes.FreeAndNilDatasets(LConsulta);
  End;
end;

function TConcilB2W.RetornaNomeArquivosConciliacao: String;
Var
  LNomeArquivo: String;
begin
  Result := EmptyStr;

  If FListaArquivos.Count = 0 Then
    Exit;

  For LNomeArquivo In FListaArquivos Do
    Result := Result + LNomeArquivo + '_';

end;

function TConcilB2W.RetornaSQLConciliacao: String;
begin
  If FPeriodoFiltro.IsEmpty Then
    FPeriodoFiltro := ' B2W_CODEMP IN ("' + FiltrosRelatorio.ListaEmpresas + '") ' +
                      ' AND (B2W_DTAPAG BETWEEN "' + FormatDateTime('yyyy-mm-dd', DataInicioPeriodo) + '" ' +
                      '                     AND "' + FormatDateTime('yyyy-mm-dd', DataFinalPeriodo) + '") ';


  Result := '';
  Result := Result + ' SELECT A.*, EMP_NOMEMP, ';
  Result := Result + ' 0.00 AS REGISTROFRETE,                                    ';
  Result := Result + ' 0.00 AS REGISTROTAXA,                                   ';
  Result := Result + ' 0.00 AS REGISTROAJUSTE,                                   ';
  Result := Result + ' 0.00 AS CUPOMDESCONTO,                                    ';
  Result := Result + ' "N" AS MARCADO                                            ';
  Result := Result + 'FROM B2W_B2PGTO A                                          ';
  Result := Result + '  LEFT JOIN CADEMP ON B2W_CODEMP =EMP_CODEMP                 ';
  Result := Result + ' WHERE                                                      ';

  Result := Result + FPeriodoFiltro +
       ' AND A.B2W_TIPREG IN ("Venda") AND A.B2W_STATUS IN ("Liberado", "Unlocked") '+
       ' AND A.B2W_IMPNOV IN ("S") ORDER BY B2W_TIPREG, B2W_DTAPAG                   ';

end;

function TConcilB2W.RegistroCancelado: Boolean;
begin
  Result := TB2WFuncoes.fFormataFloat(cdsConCar.FieldByName('B2W_VALLIQ').AsFloat, 2) <= 0;

  If Not Result Then
    Exit;
end;

function TConcilB2W.fProcessaB2WPag(pgbStatus: TcxProgressBar): Boolean;
Var
  LBuscaPedido   : Boolean;
  LConsulta: TUniQuery;

  LSQL,
  LChaveConciliacao,
  LRegistroConciliar,
  LTipo: String;

  LRegistroRelatorio: TItensRelatorioCartoes;

  LValorBruto,
  LValorTaxa,
  LValorFrete,
  LValorAjuste,
  LValorLiquido,
  LValorCupom : Double;
begin
  strRcxTcc   := VS_FuncoesExternas.fICfgSis('RCXTCC');

  TB2WFuncoes.FreeAndNilStringLists(FListaArquivos);
  FListaArquivos := TStringList.Create;

  Application.ProcessMessages;

  LConsulta := Nil;
  Try
    Try
      LConsulta := VS_FuncoesExternas.fICriaQuery;
      LConsulta.SQL.Text := 'SHOW TABLES LIKE "' + NOMTAB + '"';
      LConsulta.Open;
      If LConsulta.IsEmpty Then
      Begin
        TB2WFuncoes.fMensagem('ATENÇÃO','Não existem arquivos importados para a conciliação do ' + objConcil.NomeConciliacao + '!',['&OK']);
        Exit(False);
      End;

      LConsulta.Close;
      LConsulta.SQL.Text := RetornaSQLConciliacao;
      LConsulta.Open;
      cdsConCar := TB2WFuncoes.CriarClientDataSet(LConsulta);
      LConsulta.Close;
    Finally
      TB2WFuncoes.FreeAndNilDatasets(LConsulta);
    End;

    FCartoesParaConciliacao := VS_FuncoesExternas.fICfgSis('B2WCAR', varString, RetornaEmpresaFiltrada);

    LSQL :=  INICAM + 'DTAPAG BETWEEN "' + FormatDateTime('yyyy-mm-dd', dtaDtaIni) + '" AND "' + FormatDateTime('yyyy-mm-dd', dtaDtaFim) + '" ';

    pCalculaPeriodoFiltro(INICAM + 'DTATRA');

    FRelatorioConciliacao := TRelatorioConciliacao.Create(VS_FuncoesExternas.fIRetOperadorLogado,
                                                          'B2W',
                                                          'CONCILIACAO',
                                                          RetornaFiltrosdigitados,
                                                          TB2WFuncoes.RetornaDataHoraServidor,
                                                          TB2WFuncoes.RetornaHoraServidor);

    CartoesConciliar := VS_FuncoesExternas.fICfgSis('B2WCAR', varString, RetornaEmpresaFiltrada);


    TB2WFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Filtrando registros.', False);
    pFiltraCartoesB2W;

    FCondicaoAjustes := FPeriodoFiltro +
                        ' AND B2W_TIPREG NOT IN ("Venda") AND B2W_IMPNOV IN ("S") AND B2W_STATUS IN ("Liberado", "Unlocked") ';

    pFiltraCancelamentosB2W(pgbStatus);

    If Not ExistemRegistrosImportados Then
    Begin
      TB2WFuncoes.fMensagem('ATENÇÃO','Não existem arquivos importados no período para a conciliação do ' + objConcil.NomeConciliacao + '!',['&OK']);
      Exit(False);
    End;

    pFiltraCartoesBaixadosB2W;

    TB2WFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Processando lançamentos (' + objConcil.NomeConciliacao + ').', False);
    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := cdsConCar.RecordCount;

    TB2WFuncoes.pStepStatusGravacao(pgbStatus);

    FTextoInconsistencia := EmptyStr;

    If FListaArquivos.IndexOf(cdsConCar.FieldByName('B2W_NOMARQ').AsString) = -1 Then
    FListaArquivos.Add(cdsConCar.FieldByName('B2W_NOMARQ').AsString);


    cdsConCar.First;
    While Not cdsConCar.EOF do
    Begin
      LRegistroRelatorio := TItensRelatorioCartoes.Create;

      TB2WFuncoes.pStepStatusGravacao(pgbStatus);

      FTextoInconsistencia := EmptyStr;

      If TB2WFuncoes.fStrZero(cdsConCar.FieldByName(INICAM + 'TOTPAR').AsString, 2) = '01' Then
        LTipo := 'CRÉDITO ROTATIVO'
      Else
        LTipo := 'CRÉDITO PARCELADO';

      LValorBruto   := cdsConCar.FieldByName(INICAM + 'VALBRU').Value;
      LValorLiquido := cdsConCar.FieldByName(INICAM + 'VALLIQ').Value;
      LValorFrete := TB2WFuncoes.fFormataFloat(Abs(cdsConCar.FieldByName('REGISTROFRETE').AsFloat), 2);
      LValorTaxa := TB2WFuncoes.fFormataFloat(Abs(cdsConCar.FieldByName('REGISTROTAXA').AsFloat), 2);
      LValorCupom := Abs(cdsConCar.FieldByName('CUPOMDESCONTO').AsFloat);
      LValorAjuste := Abs(cdsConCar.FieldByName('REGISTROAJUSTE').AsFloat);

      LBuscaPedido := fBuscaCartaoB2W;

      If LBuscaPedido Then
      Begin
         LChaveConciliacao := INICAM + cdsConCar.FieldByName(INICAM + 'CODAUT').Value + '_' +
                              TB2WFuncoes.fGetLetraAlfa(StrtoInt(IfThen(cdsConCar.FieldByName(INICAM + 'NUMPAR').AsString = '00', '1', cdsConCar.FieldByName(INICAM + 'NUMPAR').AsString))) +
                              '_' + cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                              FormatDateTime('yyyy-mm-dd', cdsConCar.FieldByName(INICAM + 'DTATRA').Value);


          MarcarCartaoEncontradoArquivo(LValorBruto,
                                      LValorLiquido,
                                      LRegistroRelatorio,
                                      LChaveConciliacao,
                                      cdsConCar,
                                      LValorFrete,
                                      LValorAjuste,
                                      Abs(LValorTaxa),
                                      Abs(LValorCupom));


        LRegistroRelatorio.Conciliado := 0;
        If cdsBaiCar.FieldByName('MCA_MARDES').AsString = 'M' Then
        Begin
          If Not FTextoInconsistencia.IsEmpty Then
            LRegistroRelatorio.SomarNoTotal := 'N';

          cdsConCar.Edit;
          cdsConCar.FieldByName('MARCADO').AsString := 'S';
          cdsConCar.Post;

          FListaRegistrosConciliar.Add(fRetornaChaveConciliacao(cdsConCar));

        End;
      End;

      If Not LBuscaPedido Then
      Begin
        If LValorLiquido > 0 Then
          FTextoInconsistencia := 'Vendas não encontradas nos lançamentos do sistema';

        LBuscaPedido := fBuscaCartaoBaixadoB2W;
        If LBuscaPedido Then
        Begin
          FTextoInconsistencia := 'Vendas já foram baixadas';
          LRegistroRelatorio.InconsistenciaConciliada := 'S';
          LRegistroRelatorio.Conciliado := 1;
          LRegistroRelatorio.AutoIncremMovCar := cdsBaixad.FieldByName('AUTOINCREM').AsString;
        End;
      end;

      If RegistroCancelado Then
      Begin
        FreeAndNil(LRegistroRelatorio);
        cdsConCar.Next;

        Continue;
      End;

      FTextoInconsistencia := RetornaTextoInconsistenciaAtualizado(FTextoInconsistencia);
      If Not FTextoInconsistencia.IsEmpty Then
      Begin
        LRegistroRelatorio.Descricao := FTextoInconsistencia;
        If Not LRegistroRelatorio.InconsistenciaConciliada.Equals('S') Then
          LRegistroRelatorio.TipoDoRegistro := 'INCONSISTENCIA';
      End;

      LRegistroRelatorio.NomeArquivo := cdsConCar.FieldByName(INICAM + 'NOMARQ').AsString;

      LRegistroRelatorio.CodigoEstabelecimento := cdsConCar.FieldByName(INICAM + 'CODEST').AsString;

      If (FTextoInconsistencia <> 'Registro do arquivo não encontrado nos lançamentos do sistema') Then
        LRegistroRelatorio.CodigoEmpresa := cdsConCar.FieldByName(INICAM +'CODEMP').AsString ;

      LRegistroRelatorio.NumeroNSU :=cdsConCar.FieldByName('B2W_NUMENT').AsString;
      LRegistroRelatorio.CodigoAutorizacao := cdsConCar.FieldByName(INICAM + 'CODAUT').AsString;
      LRegistroRelatorio.ResumoVenda := cdsConCar.FieldByName(INICAM + 'NUMPED').AsString;
      LRegistroRelatorio.NumeroCartao := cdsConCar.FieldByName(INICAM + 'NUMCAR').AsString;

      LRegistroRelatorio.TipoCartao := LTipo;

      LRegistroRelatorio.Parcela := TB2WFuncoes.fStrZero(cdsConCar.FieldByName(INICAM + 'NUMPAR').AsString, 2);
      LRegistroRelatorio.TotalParcelas := TB2WFuncoes.fStrZero(cdsConCar.FieldByName(INICAM + 'TOTPAR').AsString, 2);


      LRegistroRelatorio.DataPagamento := cdsConCar.FieldByName(INICAM + 'DTAPAG').Value;
      LRegistroRelatorio.DataVenda := cdsConCar.FieldByName(INICAM + 'DTATRA').Value;
      LRegistroRelatorio.DataVencimento := cdsConCar.FieldByName(INICAM + 'DTAPAG').Value;

      LRegistroRelatorio.ValorBruto := LValorBruto;
      LRegistroRelatorio.ValorLiquido := LValorLiquido;

      LRegistroRelatorio.ValorTaxas := LValorTaxa;
      LRegistroRelatorio.ValorFrete := Abs(LValorFrete);
      LRegistroRelatorio.ValorAjustes := Abs(cdsConCar.FieldByName('REGISTROAJUSTE').AsFloat);
      LRegistroRelatorio.ValorCupom := Abs(cdsConCar.FieldByName('CUPOMDESCONTO').AsFloat);
      LRegistroRelatorio.DescricaoBandeira := fRetNomBandeira(LRegistroRelatorio.NumeroCartao);

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      cdsConCar.Next;
    End;

    For LRegistroConciliar In FListaRegistrosAjustesAgrupados Do
      FListaRegistrosConciliar.Add(LRegistroConciliar);
  Finally
    TB2WFuncoes.FreeAndNilDatasets(cdsBaixad);
  End;

  Result := True;
end;

function TConcilB2W.GravaAjusteParaRegistrosCancelados(pgbStatus: TcxProgressBar): Boolean;
 Var
    LFiltroAnterior: String;

    LRegistroRelatorio: TItensRelatorioCartoes;

    LCodigoEmpresa: String;
begin
  Result := True;

  LFiltroAnterior := cdsConCar.Filter;

  Try
    cdsConCar.Filter := 'B2W_VALLIQ < 0 ';
    cdsConCar.Filtered := True;

    pgbStatus.Properties.Max := cdsConCar.RecordCount;
    pgbStatus.Position := 0;

    cdsConCar.First;
    While Not cdsConCar.Eof Do
    Begin
      TB2WFuncoes.pStepStatusGravacao(pgbStatus);

      LRegistroRelatorio := TItensRelatorioCartoes.Create;

      LCodigoEmpresa := cdsConCar.FieldByName(INICAM+'CODEMP').Value;

      {Gerando registro do relatório}
      LRegistroRelatorio.TipoDoRegistro := 'AJUSTES';
      LRegistroRelatorio.Descricao := 'Cancelamentos/Ajustes';
      LRegistroRelatorio.DescricaoAjuste := 'Débito de vendas canceladas - ' + cdsConcar.FieldByName('B2W_NUMENT').AsString;
      LRegistroRelatorio.NomeArquivo := cdsConCar.FieldByName('B2W_NOMARQ').AsString;
      LRegistroRelatorio.CodigoEstabelecimento := LCodigoEmpresa;
      LRegistroRelatorio.CodigoEmpresa := LCodigoEmpresa;
      LRegistroRelatorio.NumeroNSU :=cdsConCar.FieldByName('B2W_NUMENT').AsString;
      LRegistroRelatorio.CodigoAutorizacao := cdsConCar.FieldByName(INICAM + 'CODAUT').AsString;
      LRegistroRelatorio.ResumoVenda := cdsConCar.FieldByName(INICAM + 'NUMPED').AsString;
      LRegistroRelatorio.NumeroCartao := 'B2W';

      LRegistroRelatorio.TipoCartao := 'CANCELAMENTOS/AJUSTES';

      LRegistroRelatorio.Parcela := TB2WFuncoes.fStrZero(cdsConCar.FieldByName('B2W_NUMPAR').AsString, 2);
      LRegistroRelatorio.TotalParcelas := TB2WFuncoes.fStrZero(cdsConCar.FieldByName('B2W_TOTPAR').AsString, 2);
      LRegistroRelatorio.DataPagamento := cdsConCar.FieldByName('B2W_DTAPAG').Value;
      LRegistroRelatorio.DataVenda := cdsConCar.FieldByName('B2W_DTATRA').Value;
      LRegistroRelatorio.DataVencimento := cdsConCar.FieldByName('B2W_DTAPAG').Value;

      LRegistroRelatorio.ValorBruto := cdsConCar.FieldByName('B2W_VALLIQ').Value;
      LRegistroRelatorio.ValorLiquido := cdsConCar.FieldByName('B2W_VALLIQ').Value;

      If LRegistroRelatorio.ValorLiquido > 0 Then
        LRegistroRelatorio.DescricaoAjuste := cdsConCar.FieldByName('B2W_TIPREG').AsString;

      LRegistroRelatorio.ValorTaxas := 0;
      LRegistroRelatorio.ValorFrete := 0;
      LRegistroRelatorio.ValorAjustes := 0;
      LRegistroRelatorio.ValorCupom := 0;

      LRegistroRelatorio.DescricaoBandeira := objConcil.NomeConciliacao;

      LRegistroRelatorio.Conciliado := cdsConCar.FieldByName('B2W_CONCIL').AsInteger;

      GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio, True, cdsConCar);

      FListaRegistrosConciliar.Add(fRetornaChaveConciliacao(cdsConCar));

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      cdsConCar.Next;
    End;
  Finally
    cdsConCar.Filter := LFiltroAnterior;
    cdsConCar.Filtered := Not LFiltroAnterior.IsEmpty;
  End;
end;

procedure TConcilB2W.pFiltraCancelamentosB2W(var prgStatus: TcxProgressBar);
Var
    LSQL,
    LEmpresaConfiguracao: String;

    LConsultaAjustes: TUniQuery;

    LAjusteCredito,
    LSairWhile: Boolean;

    LRegistroRelatorio: TItensRelatorioCartoes;
begin
  TB2WFuncoes.FreeAndNilDatasets(cdsAjustes);

  LConsultaAjustes := Nil;
  Try
    LConsultaAjustes := VS_FuncoesExternas.fICriaQuery;
    LSQL := 'SELECT *, ';
    LSQL := LSQL + '       B2W_TIPREG AS TIPAJU, ';
    LSQL := LSQL + '       IF(B2W_VALLIQ > 0, B2W_VALLIQ, 0) AS AJUCRE, ';
    LSQL := LSQL + '       "N" AS MARCADO, ';
    LSQL := LSQL + '       B2W_CODEMP AS EMPRESA ';
    LSQL := LSQL + ' FROM ' + objConcil.TabelaConciliacao + ' A ';
    LSQL := LSQL + ' WHERE ' + FCondicaoAjustes;

    LSQL := LSQL + ' ORDER BY B2W_CODAUT, B2W_NUMPAR, B2W_TIPREG';

    LConsultaAjustes.SQL.Text := LSQL;
    LConsultaAjustes.Open;

    cdsAjustes := TB2WFuncoes.CriarClientDataSet(LConsultaAjustes);
    cdsAjustes.Open;

    TB2WFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Filtrando e agrupando ajustes.', False);
    prgStatus.Position := 0;
    prgStatus.Properties.Max := cdsAjustes.RecordCount;

    cdsAjustes.First;
    While Not cdsAjustes.Eof Do
    Begin
      TB2WFuncoes.pStepStatusGravacao(prgStatus);

      LSairWhile := cdsAjustes.RecNo = cdsAjustes.RecordCount;
      If AgruparERemoverRegistgrosDeFretesEAjustes Then
      Begin
        FListaRegistrosAjustesAgrupados.Add(fRetornaChaveConciliacao(cdsAjustes));

        cdsAjustes.Delete;

        If LSairWhile Then
          Break;

        Continue;
      End;

      If TB2WFuncoes.fFormataFloat(cdsAjustes.FieldByName('B2W_VALLIQ').AsFloat, 2) = 0.00 Then
      Begin
        cdsAjustes.Next;

        Continue;
      End;

      LRegistroRelatorio := TItensRelatorioCartoes.Create;
      Try
        LAjusteCredito := TB2WFuncoes.fFormataFloat(cdsAjustes.FieldByName('AJUCRE').Value, 2) <> 0;

        LEmpresaConfiguracao := cdsAjustes.FieldByName('EMPRESA').AsString;

        LRegistroRelatorio.ValorBruto := TB2WFuncoes.fFormataFloat(cdsAjustes.FieldByName(objConcil.CampoValorLiquido).AsFloat, 2);
        LRegistroRelatorio.ValorLiquido := TB2WFuncoes.fFormataFloat(cdsAjustes.FieldByName(objConcil.CampoValorLiquido).AsFloat, 2);
        If LAjusteCredito Then
        Begin
          LRegistroRelatorio.ValorBruto := Abs(LRegistroRelatorio.ValorBruto);
          LRegistroRelatorio.ValorLiquido := Abs(LRegistroRelatorio.ValorLiquido);
        End;

        LRegistroRelatorio.Descricao := 'Cancelamentos/Ajustes';
        LRegistroRelatorio.TipoDoRegistro := 'AJUSTES';
        LRegistroRelatorio.TipoCartao := 'CANCELAMENTOS/AJUSTES';
        LRegistroRelatorio.DescricaoAjuste := cdsAjustes.FieldByName('TIPAJU').AsString;

        LRegistroRelatorio.CodigoEmpresa := LEmpresaConfiguracao;
        LRegistroRelatorio.CodigoEstabelecimento := LEmpresaConfiguracao;
        LRegistroRelatorio.NumeroNSU := cdsAjustes.FieldByName(objConcil.CampoNumeroNSU).AsString;
        LRegistroRelatorio.NumeroCartao := cdsAjustes.FieldByName(objConcil.CampoCodigoAutorizacao).AsString;
        LRegistroRelatorio.Parcela := LeftStr(cdsAjustes.FieldByName(objConcil.CampoNumeroParcela).AsString, 2);
        LRegistroRelatorio.TotalParcelas := RightStr(cdsAjustes.FieldByName(objConcil.CampoNumeroParcela).AsString, 2);
        LRegistroRelatorio.CodigoAutorizacao := TB2WFuncoes.fStrZero(cdsAjustes.FieldByName(objConcil.CampoCodigoAutorizacao).AsString, 6);

        LRegistroRelatorio.DataVenda := cdsAjustes.FieldByName(objConcil.CampoDataTransacaoVenda).Value;
        LRegistroRelatorio.DataPagamento := cdsAjustes.FieldByName(objConcil.CampoDataRecebimento).Value;

        LRegistroRelatorio.Conciliado := cdsAjustes.FieldByName('B2W_CONCIL').AsInteger;
        LRegistroRelatorio.NomeArquivo := cdsAjustes.FieldByName('B2W_NOMARQ').AsString;

        LRegistroRelatorio.RegistroIncompleto := 'N';
        LRegistroRelatorio.RegistroIncompleto := ConfiguracoesAjustesEstaoIncompletas(LEmpresaConfiguracao);

        GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio);
      Except
        FreeAndNil(LRegistroRelatorio);
        Raise;
      End;

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      cdsAjustes.Next;
    End;
  Finally
    TB2WFuncoes.FreeAndNilDatasets(LConsultaAjustes);
  End;
end;

procedure TConcilB2W.pFiltraCartoesB2W;
Var
    LSQL: String;

    LConsulta: TUniQuery;
begin
  LSQL := TLibCartoesMovCar.fGetSQLCartoes(objConcil);

  FListaDePedidos := RetornaListaDePedidos;

  LSQL := LSQL + ' AND MCA_CODCAR IN (' + TB2WFuncoes.fRetStrToSQLIn(FCartoesParaConciliacao) + ') ';
  LSQL := LSQL + ' AND (MCA_NUMCCD IN (' + FListaDePedidos + ') OR ';
  LSQL := LSQL + '      MCA_NUMNSU IN (' + FListaDePedidos + ')) ';

  LSQL := LSQL + ' ORDER BY MCA_NUMCCD, MCA_NUMNSU, MCA_PARCEL, MCA_CODEMP) AS TMP ';

  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := LSQL;
    LConsulta.Open;

    cdsBaiCar := TB2WFuncoes.CriarClientDataSet(LConsulta);
    cdsBaiCar.Open;

    cdsBaiCar.IndexFieldNames := 'MCA_NUMCCD;MCA_NUMNSU;MCA_CODEMP;PARDUP;MCA_DTACUP;MCA_NUMDUP';
  Finally
    TB2WFuncoes.FreeAndNilDatasets(LConsulta);
  End;

end;

procedure TConcilB2W.pFiltraCartoesBaixadosB2W;
 Var
    strSQL   : String;
    qryBaixad: TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT IF(IFNULL(MCA_NUMCCD, "") = "", MCA_NUMNSU, MCA_NUMCCD) AS MCA_NUMCCD, ';
  strSQL := strSQL + '        MCA_PARCEL, MCA_DTAREC, MCA_NUMNSU, MCA_VALREC, ';
  strSQL := strSQL + '        AUTOINCREM, MCA_NUMDUP, MCA_DTACUP, MCA_DTAREC, ';
  strSQL := strSQL + '        IFNULL(MCA_ORDEID, MCA_NUMPOK) AS MCA_ORDEID, ';
  strSQL := strSQL + '        MCA_CODEMP, MCA_DTAVEN, MCA_EMPRCX, MCA_CHACON ';
  strSQL := strSQL + ' FROM MOVCAR ';
  strSQL := strSQL + ' WHERE MCA_CODCAR IN (' + TB2WFuncoes.fRetStrToSQLIn(FCartoesParaConciliacao) + ') ';

  strSQL := strSQL + '   AND (MCA_NUMCCD IN (' + FListaDePedidos + ') OR ' +
                     '        MCA_NUMNSU IN (' + FListaDePedidos + '))  ';

  strSQL := strSQL + '   AND MCA_DTAREC IS NOT NULL ';
  strSQL := strSQL + 'ORDER BY MCA_NUMCCD, MCA_PARCEL,MCA_CODEMP ';

  qryBaixad := Nil;
  Try
    qryBaixad := VS_FuncoesExternas.fICriaQuery;
    qryBaixad.SQL.Text := strSQL;
    qryBaixad.Open;
    cdsBaixad := TB2WFuncoes.CriarClientDataSet(qryBaixad);
    cdsBaixad.Open;

    cdsBaixad.IndexFieldNames := 'MCA_NUMCCD;MCA_PARCEL;MCA_DTACUP;MCA_CODEMP';
    cdsBaiCar.IndexFieldNames := 'MCA_NUMCCD;PARDUP;EMPLOC;MCA_DTACUP';
  Finally
    TB2WFuncoes.FreeAndNilDatasets(qryBaixad);
  End;

end;



end.

