unit untConciliaRecebiveisShopeePayOrderAll;

interface

Uses System.Classes, Vcl.Forms, System.Types, System.Sysutils, System.StrUtils,
     System.Variants, Data.DB, Vcl.Graphics, System.DateUtils,

     Uni, UniClientDataSet, cxProgressBar,

     untTShopeeFuncoes, untTLibCartoesMovCar, untLibCartoesInterfacesTipos,
     untShopeeConciliaRecebiveis;

type

  TConciliaRecebiveisShopeePayOrderAll = class(TConciliaRecebiveisMkt)
  private
    FCdsRegistrosPagamento : TUniClientDataSet; //Registros Conciliação Financeira
    FCdsRegistrosAjuste    : TUniClientDataSet; //Registros Ajustes (POR ENQUANTO NÃO LANÇA AJUSTE)

    FListaDePedidos: String;
    FCartaoShopee: String;

    FUtilizaImportacaoPorEmpresa: Boolean;

    FAutoIncremRelatorio: Integer;

    procedure pCriaDataSets;

    function RetornaListaDePedidos: String;

    procedure pFiltraCartoesShopeePay;
    function fBuscaCartaoShopeePay: Boolean;

    procedure pFiltraCartoesBaixadosShopeePay;
    function fBuscaCartaoBaixadoShopeePay: Boolean;

    procedure FreeAndNilCds(Var AClientDataSet: TUniClientDataSet);
    function TemRegistrosImportados : Boolean;
    function fEmpresaSQL:String;
    procedure LimparMemoria(Var AIncRegistros: Integer);
    procedure ValidaCartaoEncontrado(Var ABusca : Boolean;
                                     Var ADivergenciaCartao : String;
                                     Var AClient: TUniClientDataSet;
                                     Var AValorFrete:Double;
                                     Var ATaxaShopee:Double);

    function fProcessaRegistrosDebitoCredito(pgbStatus: TcxProgressBar): Boolean;
    function fConciliaShopeePay : Boolean;
  public
     constructor Create; overload;

    function fConciliaCartoes: Boolean; override;

    function RetornaEmpresaFiltrada: String;

    Class  procedure AtualizaConciliacaoPagamentoShopeePay(ABaixa: Boolean; ACartao: TUniClientDataSet);

    property AutoIncremRelatorio: Integer Read FAutoIncremRelatorio;
    property UtilizaImportacaoPorEmpresa: Boolean read FUtilizaImportacaoPorEmpresa;
  end;

implementation

{ TConciliaRecebiveisShopeePayOrderAll }

function TConciliaRecebiveisShopeePayOrderAll.fConciliaShopeePay: Boolean;
Var strStatus    : String;
    blnVazio     : Boolean;
begin
  Try
    Result       := False;
    PossuiInconsistencia := False;

    strRcxTcc := VS_FuncoesExternas.fICfgSis('RCXTCC');

    Application.ProcessMessages;

    strStatus   := '';

    objConcil.strTabCon                   := 'SHO_SHPGTO';
    objConcil.strCamCon                   := 'SHO_CODEST';
    objConcil.strNomCon                   := 'SHOPEE';
    objConcil.strValBru                   := 'SHO_VALBRU';
    objConcil.strValLiq                   := 'SHO_VALLIQ';
    objConcil.strCodAut                   := 'SHO_ID_PED';
    objConcil.strConfPr                   := 'SHOPOR';
    objConcil.strConfCt                   := 'SHOCTA';
    objConcil.strConfFo                   := 'SHOFOR';
    objConcil.strEventoCancelamentoAjuste := 'SHOEVE';
    objConcil.strConfEs := 'Shopee';

    If Not CarregaFiltrosParaBaixaRecebiveis(DataInicioPeriodo,
                                             DataFinalPeriodo,
                                             EmpresasPeriodo) Then
      Exit(False);

    TShopeeFuncoes.AguardeExecutarModalA(pCriaDataSets,'Aguarde... Filtrando registros.','');
    blnVazio := ((FCdsRegistrosPagamento.IsEmpty));

    If blnVazio Then
    Begin
      VS_FuncoesExternas.fIMensagem('ATENÇÃO', 'Nenhum registro foi importado para o período selecionado.', ['&Ok']);
      blnReabre := True;
      Exit(False);
    End;

    TShopeeFuncoes.AguardeExecutarModalA(pFiltraCartoesShopeePay,'Aguarde... Filtrando cartões Shopee.','');

    //Selecionando cartões já baixados/cadastrados no período
    TShopeeFuncoes.AguardeExecutarModalA(pFiltraCartoesBaixadosShopeePay,'Aguarde... Filtrando cartões Shopee baixados.','');

    cdsBaiCar.Filter   := 'MCA_MARDES <> ' + QuotedStr('M');
    cdsBaiCar.Filtered := True;

    If Not FCdsRegistrosPagamento.IsEmpty Then
      TShopeeFuncoes.ExecutaAguarde(fProcessaRegistrosDebitoCredito, 'Aguarde... Processando registros (' + objConcil.strNomCon + ').');

    cdsBaiCar.Filter   := 'MCA_MARDES=' + QuotedStr('M');
    cdsBaiCar.Filtered := True;

    PossuiInconsistencia := False;

    If Not TryStrToInt(FRelatorioConciliacao.AutoIncremRelatorio, FAutoIncremRelatorio) Then
      FAutoIncremRelatorio := 0;

    TShopeeFuncoes.ExecutaAguarde(GravarRegistrosRelatorio, 'Aguarde... Gravando registros do relatório (' + objConcil.strNomCon + ').');

  Except
    On E: Exception Do
    Begin
      Result := False;
      VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmBaixaCartoes.pConciliaShopeePay]');
    End;
  End;

  FreeAndNilCds(FCdsRegistrosPagamento);
  FreeAndNilCds(FCdsRegistrosAjuste);
end;

function TConciliaRecebiveisShopeePayOrderAll.fEmpresaSQL: String;
begin
  Result := Concat('"', VS_FuncoesExternas.fIRetEmpresaLogada ,'"');

  If FUtilizaImportacaoPorEmpresa Then
  Begin
    Result := Concat(' IFNULL(SHO_CODEMP,',Result,') ');
  End;
end;

class procedure TConciliaRecebiveisShopeePayOrderAll.AtualizaConciliacaoPagamentoShopeePay(ABaixa: Boolean; ACartao: TUniClientDataSet);
  Var
    LSQLPagamento : String;
    LConcil : TUniQuery;
begin

  Try
    LConcil := VS_FuncoesExternas.fICriaQuery;

    LSQLPagamento := ' UPDATE                    '+
                     '   SHO_PDPGTO              '+
                     ' SET                       '+
                     '   SHO_CONCIL = :CONCIL      '+
                     ' WHERE SHO_ID_PED = :NUMCCD  '+
                     '   AND SHO_CONCIL = :FILCON  ';

    Try
      LConcil.Close;
      LConcil.Sql.Clear;
      LConcil.Sql.Add(LSQLPagamento);

      LConcil.ParamByName('NUMCCD').AsString   := ACartao.FieldByName('MCA_NUMCCD').AsString;
      LConcil.ParamByName('FILCON').AsInteger  := TShopeeFuncoes.IIF(ABaixa, 0, 1);
      LConcil.ParamByName('CONCIL').AsInteger  := TShopeeFuncoes.IIF(ABaixa, 1, 0);

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

constructor TConciliaRecebiveisShopeePayOrderAll.Create;
begin
  FUtilizaImportacaoPorEmpresa := VS_FuncoesExternas.fICfgSis('SHOEMP',varBoolean);
end;

function TConciliaRecebiveisShopeePayOrderAll.fConciliaCartoes: Boolean;
begin
  Result := fConciliaShopeePay;
end;

function TConciliaRecebiveisShopeePayOrderAll.fProcessaRegistrosDebitoCredito(pgbStatus: TcxProgressBar) : Boolean;
  Var
    strParcel                : String;
    strNumNsu                : String;
    strCodEmp                : String;
    intLimpMem               : Integer;
    strNumAut                : String;
    blnBusca                 : Boolean;
    STipoOperacao            : String;
    LDivergenciaCartao       : String;
    LValorFrete : Double;
    LTaxaShopee : Double;

    LChaveConciliacao: String;

    LRegistroRelatorio: TItensRelatorioCartoes;
begin

  Try
    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := FCdsRegistrosPagamento.RecordCount;
    intLimpMem := 0;

    FRelatorioConciliacao := TRelatorioConciliacao.Create(VS_FuncoesExternas.fIRetOperadorLogado,
                                                          'SHOPEE',
                                                          'CONCILIACAO',
                                                          RetornaFiltrosdigitados,
                                                          TShopeeFuncoes.RetornaDataHoraServidor,
                                                          TShopeeFuncoes.RetornaHoraServidor);

    FCdsRegistrosPagamento.First;
    While Not FCdsRegistrosPagamento.Eof Do
    Begin
      TShopeeFuncoes.pStepStatusGravacao(pgbStatus);
      FTextoInconsistencia := '';
      LDivergenciaCartao := '';
      LimparMemoria(intLimpMem);
      LValorFrete := 0;
      LTaxaShopee := 0;

      LRegistroRelatorio := TItensRelatorioCartoes.Create;

      STipoOperacao := 'CRÉDITO ROTATIVO';

      strParcel := 'A';
      FTextoInconsistencia := '';
      strNumNsu := '00000000000000';
      strNumAut := FCdsRegistrosPagamento.FieldByName('SHO_ID_PED').AsString;
      strCodEmp := FCdsRegistrosPagamento.FieldByName('EMP_CODEMP').AsString;

      blnBusca := fBuscaCartaoShopeePay;

      LDivergenciaCartao := '';
      ValidaCartaoEncontrado(blnBusca,LDivergenciaCartao,FCdsRegistrosPagamento,LValorFrete,LTaxaShopee);

      If (blnBusca) Then
      Begin
        LChaveConciliacao := 'SHO_' +  FCdsRegistrosPagamento.FieldByName('SHO_ID_PED').Value + '_' +
                               strParcel + '_' +
                               cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                               FormatDateTime('yyyy-mm-dd', FCdsRegistrosPagamento.FieldByName('SHO_DTAPAG').Value);

        {MarcarCartaoEncontradoArquivo(FCdsRegistrosPagamento.FieldByName('SHO_VALBRU').AsFloat,
                                      FCdsRegistrosPagamento.FieldByName('SHO_VALLIQ').Value,
                                      LRegistroRelatorio,
                                      LChaveConciliacao,
                                      cdsConCar,
                                      LValorFrete,
                                      Abs(cdsConCar.FieldByName('REGISTROAJUSTE').AsFloat),
                                      Abs(LTaxaShopee),
                                      Abs(cdsConCar.FieldByName('CUPOMDESCONTO').AsFloat));}
      End
      Else
      Begin
        //verifica se está cadastrado ou já foi baixado no período
        cdsBaixad.First;
        blnBusca := fBuscaCartaoBaixadoShopeePay;

        FTextoInconsistencia := 'Vendas não encontradas nos lançamentos do sistema';
        If blnBusca Then
        Begin
          FTextoInconsistencia := 'Vendas já foram baixadas';
          LRegistroRelatorio.InconsistenciaConciliada := 'S';
          LRegistroRelatorio.Conciliado := 1;
        End;
      End;

      {Gerando registro do relatório}
      FTextoInconsistencia := RetornaTextoInconsistenciaAtualizado(FTextoInconsistencia);
      If Not FTextoInconsistencia.IsEmpty Then
      Begin
        LRegistroRelatorio.Descricao := FTextoInconsistencia;
        If Not LRegistroRelatorio.InconsistenciaConciliada.Equals('S') Then
          LRegistroRelatorio.TipoDoRegistro := 'INCONSISTENCIA';
      End;
      LRegistroRelatorio.NomeArquivo := cdsConCar.FieldByName('SHO_NOMARQ').AsString;
      LRegistroRelatorio.CodigoEstabelecimento := FCdsRegistrosPagamento.FieldByName('EMP_CODEMP').AsString;
      LRegistroRelatorio.CodigoEmpresa := FCdsRegistrosPagamento.FieldByName('EMP_CODEMP').AsString;
      LRegistroRelatorio.NumeroNSU := FCdsRegistrosPagamento.FieldByName('SHO_ID_PED').AsString;
      LRegistroRelatorio.CodigoAutorizacao := FCdsRegistrosPagamento.FieldByName('SHO_ID_PED').AsString;
      LRegistroRelatorio.ResumoVenda := '00000000';
      LRegistroRelatorio.NumeroCartao := 'SHOPEE';

      LRegistroRelatorio.TipoCartao := STipoOperacao;

      LRegistroRelatorio.Parcela := '01';
      LRegistroRelatorio.TotalParcelas := '01';
      LRegistroRelatorio.DataPagamento := FCdsRegistrosPagamento.FieldByName('SHO_DTAPAG').Value;
      LRegistroRelatorio.DataVenda := FCdsRegistrosPagamento.FieldByName('SHO_DTAPAG').Value;
      LRegistroRelatorio.DataVencimento := FCdsRegistrosPagamento.FieldByName('SHO_DTAPAG').Value;

      LRegistroRelatorio.ValorBruto := FCdsRegistrosPagamento.FieldByName('SHO_VALBRU').AsFloat;

      LRegistroRelatorio.ValorLiquido := FCdsRegistrosPagamento.FieldByName('SHO_VALLIQ').Value;
      LRegistroRelatorio.ValorTaxas := LTaxaShopee;
      LRegistroRelatorio.ValorFrete := LValorFrete;
      LRegistroRelatorio.ValorAjustes := 0;
      LRegistroRelatorio.ValorCupom := Abs(cdsConCar.FieldByName('CUPOMDESCONTO').AsFloat);

      LRegistroRelatorio.DescricaoBandeira := 'DIVERSAS';

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      FCdsRegistrosPagamento.Next;
    End;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
      Result := False;
    End;
  End;

end;

procedure TConciliaRecebiveisShopeePayOrderAll.FreeAndNilCds(var AClientDataSet: TUniClientDataSet);
begin
  If Assigned(AClientDataSet) Then
    FreeAndNil(AClientDataSet);
end;

procedure TConciliaRecebiveisShopeePayOrderAll.LimparMemoria(var AIncRegistros: Integer);
begin
  If AIncRegistros >= 50 Then
  Begin
    VS_FuncoesExternas.pITrimAppMemorySize;
    AIncRegistros := 0;
  End
  Else
    inc(AIncRegistros);
end;

procedure TConciliaRecebiveisShopeePayOrderAll.pCriaDataSets;
  Var
    SQueryPagamento: TUniQuery;
    LSqlDataPagamento: String;
begin
  SQueryPagamento          := VS_FuncoesExternas.fICriaQuery;
  FCdsRegistrosPagamento   := TUniClientDataSet.Create(Application);
  FCdsRegistrosAjuste      := TUniClientDataSet.Create(Application);

  LSqlDataPagamento := ' IFNULL(                                     '+
                       '   IF(                                       '+
                       '     SHO_SHREPA.SHO_DTAPAG = "0000-00-00",   '+
                       '     NULL,                                   '+
                       '     SHO_SHREPA.SHO_DTAPAG                   '+
                       '   ),                                        '+
                       '   SHO_PDPGTO.SHO_DTAPAG                     '+
                       ' ) ';

  Try

    //CONCILIAÇÃO FINANCEIRA
    SQueryPagamento.Close;
    SQueryPagamento.SQL.Text := 'SELECT                                                                             '+
                                ' (IFNULL(SHO_VALTOT,0) + IFNULL(SHO_DESFRE,0) - IFNULL(SHO_CUPVEN,0) - IFNULL(SHO_TAXCOM,0) - IFNULL(SHO_TAXSER,0) ) AS SHO_VALLIQ,   '+
                                ' (IFNULL(SHO_VALTOT,0) + SUM(IFNULL(SHO_REESHO,0)) - IFNULL(SHO_CUPVEN,0) - (IFNULL(SHO_MOESHO,0)/100)) AS SHO_VALBRU,     '+
                                '  SHO_DESFRE,                                                                      '+
                                '  SHO_ID_PED,                                                                      '+
                                '  SHO_PDPGTO.SHO_NOMARQ AS SHO_NOMARQ,                                             '+
                                   LSqlDataPagamento + ' AS SHO_DTAPAG,    ' +
                                '  SHO_VALTOT AS BRUTO,                                                             ' +
                                '  IFNULL(SHO_TAXCOM, 0) AS SHO_TAXCOM,                                             ' +
                                '  IFNULL(SHO_TAXSER, 0) AS SHO_TAXSER,                                             ' +
                                '  IFNULL(SHO_TAXENC, 0) AS SHO_TAXENC,                                             ' +
                                '  IFNULL(SHO_TOTGLO, 0) AS SHO_TOTGLO,                                             ' +
                                '  IFNULL(SHO_SUBTOT, 0) AS SHO_SUBTOT,                                             ' +
                                '  IFNULL(SHO_FREEST, 0) AS SHO_FREEST,                                             ' +
                                '  IFNULL(SHO_REESHO, 0) AS SHO_REESHO,                                             ' +
                                '  EMP_CODEMP,                                                                      '+
                                '  EMP_NOMEMP                                                                       '+
                                'FROM                                                                               '+
                                '  SHO_PDPGTO                                                                       '+
                                '  LEFT JOIN SHO_SHREPA             '+
                                '   ON SHO_ID_PED = SHO_CODAUT      '+
                                '  LEFT JOIN CADEMP                 '+
                                '    ON EMP_CODEMP = '+ fEmpresaSQL  +
                                'WHERE '+LSqlDataPagamento+' BETWEEN :DTAINI   '+
                                '  AND :DTAFIM                      '+
                                '  AND SHO_STATUS IN("Concluído")   '+
                                '  AND SHO_STADEV IS NULL           '+
                                '  AND SHO_CONCIL = 0               '+
                                  fRetPesqPonVen                    +
                                'GROUP BY SHO_ID_PED                ';


    SQueryPagamento.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaIni);
    SQueryPagamento.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaFim);

    SQueryPagamento.Open;
    FCdsRegistrosPagamento := TShopeeFuncoes.CriarClientDataSet(SQueryPagamento);
    Application.ProcessMessages;

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;

  VS_FuncoesExternas.pITrimAppMemorySize;
end;


procedure TConciliaRecebiveisShopeePayOrderAll.pFiltraCartoesBaixadosShopeePay;
  Var
    strSQL   : String;
    qryBaixad: TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT MCA_NUMCCD, MCA_PARCEL, MCA_DTAREC, MCA_NUMNSU, ';
  strSQL := strSQL + ' MCA_NUMDUP, MCA_DTACUP, ';
  strSQL := strSQL + ' MCA_CODEMP, MCA_DTAVEN, MCA_EMPRCX, MCA_CHACON         ';
  strSQL := strSQL + ' FROM MOVCAR                                ';
  strSQL := strSQL + ' WHERE ';

  If Not FCartaoShopee.IsEmpty Then
    strSQL := strSQL + ' MCA_CODCAR IN (' +  TShopeeFuncoes.fRetStrToSQLIn(FCartaoShopee) + ') AND ';

  strSQL := strSQL + ' (MCA_NUMNSU IN (' + FListaDePedidos + ') OR MCA_NUMCCD IN (' + FListaDePedidos + ')) ';
  strSQL := strSQL + ' AND MCA_PARCEL="A" ';
  strSQL := strSQL + ' AND MCA_DTAREC IS NOT NULL ';
  strSQL := strSQL + ' ORDER BY MCA_NUMNSU, MCA_PARCEL,MCA_CODEMP ';

  qryBaixad :=  TShopeeFuncoes.fCriarQuery(strSQL);
  qryBaixad.Open;
  cdsBaixad :=  TShopeeFuncoes.CriarClientDataSet(qryBaixad);
  cdsBaixad.Open;

  cdsBaixad.IndexFieldNames := 'MCA_NUMNSU;MCA_NUMCCD;MCA_PARCEL;MCA_DTACUP;MCA_CODEMP';

  FreeAndNil(qryBaixad);
end;

procedure TConciliaRecebiveisShopeePayOrderAll.pFiltraCartoesShopeePay;
  Var
    strSQL: String;
begin
  FCartaoShopee := VS_FuncoesExternas.fICfgSis('SHOCAR');

  FListaDePedidos := RetornaListaDePedidos;

  strSQL := TLibCartoesMovCar.fGetSQLCartoes(objConcil);

  If Not FCartaoShopee.IsEmpty Then
    strSQL := strSQL + ' AND MCA_CODCAR IN (' +  TShopeeFuncoes.fRetStrToSQLIn(FCartaoShopee) + ') ';

  strSQL := strSQL + ' AND (MCA_NUMCCD IN (' + FListaDePedidos + ') OR MCA_NUMNSU IN (' + FListaDePedidos + ')) ';
  strSQL := strSQL + ' AND MCA_PARCEL="A" ';

  strSQL := strSQL + ' ORDER BY MCA_NUMNSU,MCA_NUMCCD,MCA_CODEMP,PARDUP,MCA_DTACUP,MCA_NUMDUP) AS TMP ';

  qryBaiCar :=  TShopeeFuncoes.fCriarQuery(strSQL);
  qryBaiCar.Options.SetFieldsReadOnly := False;
  qryBaiCar.Open;

  cdsBaiCar :=  TShopeeFuncoes.CriarClientDataSet(qryBaiCar);
  cdsBaiCar.IndexFieldNames := 'MCA_NUMNSU;MCA_NUMCCD;MCA_CODEMP;PARDUP;MCA_DTACUP;MCA_NUMDUP';
  cdsBaiCar.Open;

End;

function TConciliaRecebiveisShopeePayOrderAll.fBuscaCartaoShopeePay: Boolean;
begin
  Result := cdsBaiCar.Locate('MCA_NUMCCD;PARDUP;MCA_MARDES',
                              VarArrayOf([AnsiUpperCase(FCdsRegistrosPagamento.FieldByName('SHO_ID_PED').AsString),
                                          'A', 'D']),[]);

  If Not Result Then
     Result := cdsBaiCar.Locate('MCA_NUMNSU;PARDUP;MCA_MARDES',
                                 VarArrayOf([UpperCase(FCdsRegistrosPagamento.FieldByName('SHO_ID_PED').AsString),
                                             'A', 'D']),[]);

end;

function TConciliaRecebiveisShopeePayOrderAll.fBuscaCartaoBaixadoShopeePay: Boolean;
begin
  Result := cdsBaixad.Locate('MCA_NUMCCD;MCA_PARCEL',
                                VarArrayOf([AnsiUpperCase(FCdsRegistrosPagamento.FieldByName('SHO_ID_PED').AsString),
                                            'A']),[]);

  If Not Result Then
     Result := cdsBaixad.Locate('MCA_NUMNSU;MCA_PARCEL',
                                 VarArrayOf([UpperCase(FCdsRegistrosPagamento.FieldByName('SHO_ID_PED').AsString),
                                             'A']),[]);

  blnAutomatica := (Result) And
                   (Not  TShopeeFuncoes.fEmptyStr(cdsBaixad.FieldbyName('MCA_CHACON').AsString));
end;

function TConciliaRecebiveisShopeePayOrderAll.TemRegistrosImportados: Boolean;
begin
  Result := False;
  If (Not FCdsRegistrosPagamento.IsEmpty) Then
    Exit(True)
  Else If (Not FCdsRegistrosAjuste.IsEmpty) Then
    Exit(True);
end;

procedure TConciliaRecebiveisShopeePayOrderAll.ValidaCartaoEncontrado(Var ABusca : Boolean;
                                                       Var ADivergenciaCartao : String;
                                                       Var AClient: TUniClientDataSet;
                                                       Var AValorFrete:Double;
                                                       Var ATaxaShopee:Double);
  Var
    LDiferenca : Double;

    LCartaoEncontrado: Boolean;
    LValorLiquidoCalculado: Double;
begin
  LCartaoEncontrado := ABusca;

  Try
    If Not ABusca Then
      Exit;


    LValorLiquidoCalculado :=  TShopeeFuncoes.fFormataFloat(((AClient.FieldByName('SHO_SUBTOT').AsFloat +
                               AClient.FieldByName('SHO_REESHO').AsFloat +
                               AClient.FieldByName('SHO_FREEST').AsFloat) -
                              (AClient.FieldByName('SHO_TAXCOM').AsFloat + AClient.FieldByName('SHO_TAXSER').AsFloat)),2);

    LDiferenca :=  TShopeeFuncoes.fFormataFloat((LValorLiquidoCalculado - cdsBaiCar.FieldByName('MCA_VALDUP').AsFloat),2);

    If fBetween( TShopeeFuncoes.fFormataFloat(LDiferenca, 2), -0.02999, 0.02999) Then
    Begin
      If LValorLiquidoCalculado <> AClient.FieldByName('SHO_VALLIQ').AsFloat Then
      Begin
        AClient.Edit;
        AClient.FieldByName('SHO_VALLIQ').AsFloat :=   TShopeeFuncoes.fFormataFloat(LValorLiquidoCalculado,2);
        AClient.Post;
      End;
    End
    Else
    Begin
      LDiferenca :=  TShopeeFuncoes.fFormataFloat(( TShopeeFuncoes.fFormataFloat((LValorLiquidoCalculado - AClient.FieldByName('SHO_FREEST').AsFloat),2) - cdsBaiCar.FieldByName('MCA_VALDUP').AsFloat),2);

      If fBetween( TShopeeFuncoes.fFormataFloat(LDiferenca, 2), -0.02999, 0.02999)  Then
      Begin
        If  TShopeeFuncoes.fFormataFloat((LValorLiquidoCalculado - AClient.FieldByName('SHO_FREEST').AsFloat),2) <> AClient.FieldByName('SHO_VALLIQ').AsFloat Then
        Begin
          AClient.Edit;
          AClient.FieldByName('SHO_VALLIQ').AsFloat :=   TShopeeFuncoes.fFormataFloat((LValorLiquidoCalculado - AClient.FieldByName('SHO_FREEST').AsFloat),2);
          AClient.Post;
        End;
      End;
    End;

    LDiferenca :=  TShopeeFuncoes.fFormataFloat((AClient.FieldByName('SHO_TOTGLO').AsFloat - cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat),2);

    If fBetween( TShopeeFuncoes.fFormataFloat(LDiferenca, 2), -0.02999, 0.02999) Then
    Begin
      If AClient.FieldByName('SHO_TOTGLO').AsFloat <> AClient.FieldByName('SHO_VALBRU').AsFloat Then
      Begin
        AClient.Edit;
        AClient.FieldByName('SHO_VALBRU').AsFloat :=  AClient.FieldByName('SHO_TOTGLO').AsFloat;
        AClient.Post;
      End;
    End;

    LDiferenca :=  TShopeeFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - AClient.FieldByName('SHO_VALBRU').AsFloat,2);

    If Not fBetween( TShopeeFuncoes.fFormataFloat(LDiferenca, 2), -0.02999, 0.02999) Then
    Begin

      LDiferenca :=  TShopeeFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - (AClient.FieldByName('SHO_VALBRU').AsFloat +
                                                                                 AClient.FieldByName('SHO_DESFRE').AsFloat),2);

      If fBetween( TShopeeFuncoes.fFormataFloat(LDiferenca, 2), -0.02999, 0.02999) Then
      Begin
        AClient.Edit;
        AClient.FieldByName('SHO_VALBRU').AsFloat :=   TShopeeFuncoes.fFormataFloat(AClient.FieldByName('SHO_VALBRU').AsFloat + AClient.FieldByName('SHO_DESFRE').AsFloat,2);
        AClient.Post;
        Exit;
      End;

      ADivergenciaCartao := 'Valor do cartão diferente do registrado no sistema ou Autorização/NSU duplicado';
      ABusca := False;
    End;
  Finally
    If Not ABusca Then
    Begin
      If AClient.FieldByName('SHO_VALBRU').AsFloat < AClient.FieldByName('SHO_VALLIQ').AsFloat Then
      Begin
        AClient.Edit;
        AClient.FieldByName('SHO_VALBRU').AsFloat :=   TShopeeFuncoes.fFormataFloat(AClient.FieldByName('BRUTO').AsFloat,2);
        AClient.FieldByName('SHO_VALLIQ').AsFloat :=   TShopeeFuncoes.fFormataFloat(AClient.FieldByName('BRUTO').AsFloat -
                                                                    AClient.FieldByName('SHO_TAXCOM').AsFloat -
                                                                    AClient.FieldByName('SHO_TAXSER').AsFloat -
                                                                    AClient.FieldByName('SHO_TAXENC').AsFloat,2);
        AClient.Post;
      End;

      If LCartaoEncontrado Then
      Begin
       LDiferenca :=  TShopeeFuncoes.fFormataFloat((cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - AClient.FieldByName('BRUTO').AsFloat) +
                                                    (cdsBaiCar.FieldByName('MCA_VALORI').AsFloat - (AClient.FieldByName('BRUTO').AsFloat -
                                                                                                    AClient.FieldByName('SHO_TAXCOM').AsFloat -
                                                                                                    AClient.FieldByName('SHO_TAXSER').AsFloat -
                                                                                                    AClient.FieldByName('SHO_TAXENC').AsFloat)),2);

        If fBetween( TShopeeFuncoes.fFormataFloat(LDiferenca, 2), -0.02999, 0.02999) Then
        Begin
          ADivergenciaCartao := EmptyStr;
          ABusca := True;
        End;
      End;
    End;
  End;
end;

function TConciliaRecebiveisShopeePayOrderAll.RetornaEmpresaFiltrada: String;
begin
  Result := EmptyStr;

  If Length(arrEmpresa) = 0 Then
    Exit;

  Result := arrEmpresa[0].strCodigo;
end;

function TConciliaRecebiveisShopeePayOrderAll.RetornaListaDePedidos: String;
  Var
    LRecNo : Integer;
begin
  LRecNo := FCdsRegistrosPagamento.RecNo;
  FCdsRegistrosPagamento.First;

  While Not FCdsRegistrosPagamento.Eof Do
  Begin
    Result := Result + '"' + FCdsRegistrosPagamento.FieldByName('SHO_ID_PED').AsString + '",';
    FCdsRegistrosPagamento.Next;
  End;

  FCdsRegistrosPagamento.RecNo := LRecNo;

  If Not Result.IsEmpty Then
    Result := LeftStr(Result, Result.Length - 1)
  Else
    Result := '" "';
end;

end.
