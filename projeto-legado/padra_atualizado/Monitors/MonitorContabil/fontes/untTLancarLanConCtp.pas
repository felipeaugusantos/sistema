unit untTLancarLanConCtp;

interface

uses untIContabilidade, Contabilidade.Classes.TDadosAbertura;

type
  TLancarLanConCtp = Class(TInterfacedObject, ILancarLanCon)
  private
    FParams: IParametrosGeracaoLanCon;
    FDadosAbertura : TDadosAbertura;
    procedure CarregaDadosAbertura;
  public
    constructor Create(AParams: IParametrosGeracaoLanCon);
    destructor Destroy; override;
    class function New(AParams: IParametrosGeracaoLanCon): ILancarLanCon;
    procedure Execute;
  end;

implementation

uses
  Contabilidade.Interfaces, untFuncoesSimples, Contabilidade.Classes.TGeradorContabil, Data.DB,
  untTFactoryUpdateLogCon, untTParametrosUpdateLogCon, System.Generics.Collections,
  untContabilidadeConstantes, Contabilidade.Funcoes, Classes, SysUtils,
  Contabilidade.Classes.TTrataIncDoc, Uni;

{ TLancarLanConCtp }

procedure TLancarLanConCtp.CarregaDadosAbertura;
begin
  FDadosAbertura.dtaDataInicial := 0;
  FDadosAbertura.dtaDataFinal := 0;
  FDadosAbertura.empresa.strCodigo := '';
  FDadosAbertura.empresa.strDescricao := '';
  FDadosAbertura.strIncrementoCadPag := FParams.IncDoc;
  FDadosAbertura.arrIncDoc := FParams.ArrIncDoc ;
  FDadosAbertura.dtaLanRobo := FParams.DtaLan ;
  FDadosAbertura.strEmpRobo := FParams.EmpLan ;
  FDadosAbertura.progresso := nil;
  FDadosAbertura.lblDescricaoProgresso := nil;
  FDadosAbertura.strTipoExportacao := FParams.TipLan;
  FDadosAbertura.blnProvisao := (FParams.TipLan = TIPO_CONTAS_PAGAR_PROVISAO);
  FDadosAbertura.blnModoRobo := True;
  FDadosAbertura.intModoLancto := FParams.ModLan;
  if fConfiguracaoExiste('EXUCCP') then
    FDadosAbertura.blnExportaUsoConsumo := fCfgSis('EXUCCP', varBoolean);
  FDadosAbertura.blnUsaCheckListComplemento := fTabelaExiste('CMPPAR');
  FDadosAbertura.blnConSeqParExiste := fCampoExiste('PARCON', 'CON_SEQPAR');
  FDadosAbertura.blnCON_PAGANT := fCampoExiste('PARCON', 'CON_PAGANT');
  if (FDadosAbertura.blnCON_PAGANT) then
  begin
    FDadosAbertura.blnParametrizouPagamentoAntecipadoAvulso := fCampoTabelaParcon('COUNT(*)', ['CON_PAGANT', 'CON_PAGAME'], ['Sim', 'Pagamentos Avulsos'], True) > 0;
    FDadosAbertura.blnParametrizouPagamentoAntecipadoFatura := fCampoTabelaParcon('COUNT(*)', ['CON_PAGANT', 'CON_PAGAME'], ['Sim', 'Pagamentos Fatura'], True) > 0;
  end
  else
  begin
    FDadosAbertura.blnParametrizouPagamentoAntecipadoAvulso := False;
    FDadosAbertura.blnParametrizouPagamentoAntecipadoFatura := False;
  end;
end;

constructor TLancarLanConCtp.Create(AParams: IParametrosGeracaoLanCon);
begin
  FParams := AParams;
  FDadosAbertura := TDadosAbertura.Create;
end;

destructor TLancarLanConCtp.Destroy;
begin
  FDadosAbertura.Free;
  inherited;
end;

procedure TLancarLanConCtp.Execute;
  var
    gerador: TGeradorContabil;
    lista: TList<IParametrosUpdateLogCon>;
    dsErros, dsWarning : TDataSet ;
    strFiltrosExcecao : String ;
    LlstConLogProcessada: TStringList ;
    LarrIncDoc: TArrIncDoc ;
    LintCnt: Integer ;
    LintAuxAutoIncConLog: Integer ;
    LqryConsulta: TUniQuery ;
begin
  inherited;
  CarregaDadosAbertura;

  gerador := TGeradorContabil.create(FDadosAbertura);
  LlstConLogProcessada := TStringList.Create ;
  try
    LlstConLogProcessada.Sorted := True ;
    LarrIncDoc := FParams.ArrIncDoc ;

    gerador.blnValidarContas := False ;
    gerador.pGerar;

    lista := TList<IParametrosUpdateLogCon>.Create;
    LqryConsulta := fCriaQuery() ;
    try

      If (Not gerador.listaErros.IsEmpty) Then
      begin
        dsErros := gerador.listaErros ;
        dsErros.First;
        while not dsErros.Eof do
        begin
          lista.Add(
            TParametrosUpdateLogCon.New
              .Origem(dsErros.FieldByName('ERR_ORIPLA').AsString)
              .Inconsistencia(dsErros.FieldByName('ERR_MOTIVO').AsString)
              .Historico(dsErros.FieldByName('ERR_HISTOR').AsString)
              .DescricaoValor(dsErros.FieldByName('ERR_DESVAL').AsString)
              .NaturezaOperacao(dsErros.FieldByName('ERR_NATOPE').AsString)
              .Processado(PROCESSADO)
              .Status(STATUS_ERRO)
              .Incremento(TTrataConLog
                            .New
                            .fIncDoc(dsErros.FieldByName('ERR_CHVDOC').AsString)
                            .fTipLan(dsErros.FieldByName('ERR_TIPLAN').AsString)
                            .fQuerySql(LqryConsulta)
                            .fArrIncDoc(LarrIncDoc)
                            .fLstProcessado(LlstConLogProcessada)
                            .fRetornaAutoIncConLog)
              .Reenvio(FParams.Reenvio)
          );
          dsErros.Next;
        end;

        TFactoryUpdateLogCon.New
            .Execute(
              lista, ''
            );
        lista.Clear ;
      end ;

      If (Not gerador.listaWarnings.IsEmpty) Then
      begin
        strFiltrosExcecao := gerador.objValida.FiltrosExcecao ;
        dsWarning := gerador.listaWarnings ;
        dsWarning.First;
        while not dsWarning.Eof do
        begin
          LintAuxAutoIncConLog := TTrataConLog
                                  .New
                                  .fIncDoc(dsWarning.FieldByName('ERR_CHVDOC').AsString)
                                  .fTipLan(dsWarning.FieldByName('ERR_TIPLAN').AsString)
                                  .fQuerySql(LqryConsulta)
                                  .fArrIncDoc(LarrIncDoc)
                                  .fRetornaAutoIncConLog ;

          if LlstConLogProcessada.IndexOf(IntToStr(LintAuxAutoIncConLog)) < 0 then
          begin
            lista.Add(
              TParametrosUpdateLogCon.New
                .Origem(dsWarning.FieldByName('ERR_ORIPLA').AsString)
                .Inconsistencia(dsWarning.FieldByName('ERR_MOTIVO').AsString)
                .Historico(dsWarning.FieldByName('ERR_HISTOR').AsString)
                .DescricaoValor(dsWarning.FieldByName('ERR_DESVAL').AsString)
                .NaturezaOperacao(dsWarning.FieldByName('ERR_NATOPE').AsString)
                .Processado(PROCESSADO)
                .Status(STATUS_WARNING)
                .Incremento(TTrataConLog
                              .New
                              .fIncDoc(dsWarning.FieldByName('ERR_CHVDOC').AsString)
                              .fTipLan(dsWarning.FieldByName('ERR_TIPLAN').AsString)
                              .fQuerySql(LqryConsulta)
                              .fArrIncDoc(LarrIncDoc)
                              .fLstProcessado(LlstConLogProcessada)
                              .fRetornaAutoIncConLog)
                .Reenvio(FParams.Reenvio)
            );
          end ;
          dsWarning.Next;
        end;

        if lista.Count > 0 then
          TFactoryUpdateLogCon.New
              .Execute(
                lista, strFiltrosExcecao
              );

        lista.Clear ;
      end ;

      if Length(LarrIncDoc) > 0 then
      begin
        for LintCnt := Low(LarrIncDoc) to High(LarrIncDoc) do
        begin
          if LlstConLogProcessada.IndexOf(IntToStr(LarrIncDoc[LintCnt].ConLog)) < 0 then
          begin
            lista.Add(
              TParametrosUpdateLogCon.New
                .Processado(PROCESSADO)
                .Status(STATUS_OK)
                .Incremento(LarrIncDoc[LintCnt].ConLog)
                .Reenvio(FParams.Reenvio)
            );
          end ;
        end ;

        if lista.Count > 0 then
          TFactoryUpdateLogCon.New
            .Execute(
              lista, ''
              );

        lista.Clear ;
      end;
    finally
      lista.Free;
    end;
  finally
    gerador.Free;
    FreeAndNil(LlstConLogProcessada) ;
    FreeAndNil(LqryConsulta) ;
  end;
end;

class function TLancarLanConCtp.New(
  AParams: IParametrosGeracaoLanCon): ILancarLanCon;
begin
  Result := Self.Create(AParams);
end;

end.
