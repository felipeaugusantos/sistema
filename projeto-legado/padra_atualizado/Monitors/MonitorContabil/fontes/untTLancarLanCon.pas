unit untTLancarLanCon;

interface

uses untIContabilidade, Contabilidade.Interfaces, Data.DB;

type
  TLancarLanCon = Class(TInterfacedObject, ILancarLanCon)
  private
    FParams: IParametrosGeracaoLanCon;
    procedure ProcessaLanCon(strTipLan: string; blnPreValidar: boolean; objValida : IValidaContaContabil; recParCon : TParametrosConsulta);
    procedure ProcessaResultados(objValida: IValidaContaContabil);
  public
    constructor Create(AParams: IParametrosGeracaoLanCon);
    class function New(AParams: IParametrosGeracaoLanCon): ILancarLanCon;
    procedure Execute;
  end;

implementation

uses
  Contabilidade.Classes.TGerLanCon, cxProgressBar,
  Contabilidade.Classes.TValidaContasContabeis, SysUtils, untContabilidadeConstantes,
  untTFactoryUpdateLogCon, untTParametrosUpdateLogCon, System.Generics.Collections,
  Contabilidade.Funcoes, Contabilidade.Classes.TTrataIncDoc, Classes, Uni,
  untFuncoesSimples;

{ TLancarLanCon }

constructor TLancarLanCon.Create(AParams: IParametrosGeracaoLanCon);
begin
  FParams := AParams;
end;

procedure TLancarLanCon.Execute;
  var
    recParCon : TParametrosConsulta;
    objValida : IValidaContaContabil;
    arrSiglas : array of string;
    intCnt : integer;
begin
  FillChar(recParCon, SizeOf(recParCon), #0);
  recParCon.strIncDoc := FParams.IncDoc;
  recParCon.strTabela := FParams.Tabela;
  recParCon.blnModoRobo := True;
  recParcon.dtaLanRobo := FParams.DtaLan ;
  recParcon.strEmpRobo := FParams.EmpLan ;
  recParCon.intModoLancto := FParams.ModLan;
  recParCon.arrIncDoc := FParams.ArrIncDoc ;

  if (FParams.TipLan = 'SAI') and (FParams.Tabela = 'CADFIS') then
  begin
    SetLength(arrSiglas, 1);
    arrSiglas[0] := 'SES';
  end
  else if (FParams.TipLan = 'ENT') and (FParams.Tabela = 'CADFIS') then
  begin
    SetLength(arrSiglas, 2);
    arrSiglas[0] := 'OUE';
    arrSiglas[1] := 'SEE';
  end
  else
  begin
    SetLength(arrSiglas, 1);
    arrSiglas[0] := FParams.TipLan;
  end;

  if ('CHQ_'.Contains(FParams.TipLan)) Then
  begin
    recParCon.dtaDtaIni := fDataLanCon(FParams.ArrIncDoc, FParams.TipLan);
    recParCon.dtaDtaFin := recParCon.dtaDtaIni;
    recParCon.intIncConLog := FParams.Incremento ;
  end;

  for intCnt := Low(arrSiglas) to High(arrSiglas) do
  begin
    objValida := TValidaContaContabil.New;
    ProcessaLanCon(arrSiglas[intCnt], True, objValida, recParCon);

    ProcessaResultados(objValida);
  end;
end;

class function TLancarLanCon.New(AParams: IParametrosGeracaoLanCon): ILancarLanCon;
begin
  Result := Self.Create(AParams);
end;

procedure TLancarLanCon.ProcessaLanCon(strTipLan: string; blnPreValidar: boolean; objValida : IValidaContaContabil; recParCon : TParametrosConsulta);
  var
    objGerLanCon : TGerLanCon;
    pgbProgresso : TcxProgressBar;
begin
  pgbProgresso := TcxProgressBar.Create(nil);
  try
    objGerLanCon := TGerLanCon.Create(Nil,
                                      strTipLan,
                                      recParCon,
                                      pgbProgresso,
                                      blnPreValidar,
                                      objValida,
                                      True);
    try
      objGerLanCon.fGerarLancamentos();
    finally
      FreeAndNil(objGerLanCon);
    end;
  finally
    FreeAndNil(pgbProgresso);
  end;
end;

procedure TLancarLanCon.ProcessaResultados(objValida: IValidaContaContabil);
  var
    lista : TList<IParametrosUpdateLogCon>;
    dsErros : TDataSet ;
    dsWarnings : TDataSet ;
    strFiltroExcecao : string ;
    LlstConLogProcessada: TStringList ;
    LarrIncDoc: TArrIncDoc ;
    LintCnt: Integer ;
    LintAuxAutoIncConLog: Integer ;
    LqryConsulta: TUniQuery ;
begin
  lista := TList<IParametrosUpdateLogCon>.Create;
  LlstConLogProcessada := TStringList.Create ;
  LqryConsulta := fCriaQuery() ;
  try
    LlstConLogProcessada.Sorted := True ;
    LarrIncDoc := FParams.ArrIncDoc ;

    dsErros := objValida.DataSet ;
    If (Not dsErros.IsEmpty) Then
    begin
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
                            .fTipLan(dsErros.FieldByName('ERR_TIPLAN').AsString)
                            .fIncDoc(dsErros.FieldByName('ERR_CHVDOC').AsString)
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

    dsWarnings := objValida.DataSetWarnings ;
    If (Not dsWarnings.IsEmpty) Then
    begin
      strFiltroExcecao := objValida.FiltrosExcecao ;
      dsWarnings.First;
      while not dsWarnings.Eof do
      begin
        LintAuxAutoIncConLog := TTrataConLog
                                  .New
                                  .fIncDoc(dsWarnings.FieldByName('ERR_CHVDOC').AsString)
                                  .fArrIncDoc(LarrIncDoc)
                                  .fTipLan(dsWarnings.FieldByName('ERR_TIPLAN').AsString)
                                  .fQuerySql(LqryConsulta)
                                  .fRetornaAutoIncConLog ;

        if LlstConLogProcessada.IndexOf(IntToStr(LintAuxAutoIncConLog)) < 0 then
        begin
          lista.Add(
            TParametrosUpdateLogCon.New
              .Origem(dsWarnings.FieldByName('ERR_ORIPLA').AsString)
              .Inconsistencia(dsWarnings.FieldByName('ERR_MOTIVO').AsString)
              .Historico(dsWarnings.FieldByName('ERR_HISTOR').AsString)
              .DescricaoValor(dsWarnings.FieldByName('ERR_DESVAL').AsString)
              .NaturezaOperacao(dsWarnings.FieldByName('ERR_NATOPE').AsString)
              .Processado(PROCESSADO)
              .Status(STATUS_WARNING)
              .Incremento(TTrataConLog
                              .New
                              .fIncDoc(dsWarnings.FieldByName('ERR_CHVDOC').AsString)
                              .fArrIncDoc(LarrIncDoc)
                              .fLstProcessado(LlstConLogProcessada)
                              .fTipLan(dsWarnings.FieldByName('ERR_TIPLAN').AsString)
                              .fQuerySql(LqryConsulta)
                              .fRetornaAutoIncConLog)
              .Reenvio(FParams.Reenvio)
          );
        end ;

        dsWarnings.Next;
      end;

      if lista.Count > 0 then
        TFactoryUpdateLogCon.New
          .Execute(
            lista, strFiltroExcecao
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
    FreeAndNil(LlstConLogProcessada) ;
    FreeAndNil(LqryConsulta) ;
  end;
end;

end.
