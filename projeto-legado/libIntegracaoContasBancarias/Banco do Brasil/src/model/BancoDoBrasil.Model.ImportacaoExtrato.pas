unit BancoDoBrasil.Model.ImportacaoExtrato;

interface

uses
  System.SysUtils, System.Classes, Uni, DBAccess,
  BancoDoBrasil.Model.LancamentoExtrato;

type
  TExtratoBancoDoBrasil = class
  private
    FQuery: TUniQuery;
    FExisteCampoIdTransacao: Boolean;

    function RetornaSqlReplaceExtBcoBbr: String;
    function RetornaHistoricoCompleto(const ALancamento: TLancamentoExtrato): String;
    function RetornaSqlInsertExtban: String;
    procedure SalvarNaExtban(ALancamento: TLancamentoExtrato);
    function RetornaCampoIdTransacaoSeExiste(AEhParametro: Boolean = False): String;
  public
    constructor Create;
    destructor Destroy; override;
    procedure SalvarLancamento(ALancamento: TLancamentoExtrato);
    function LancamentoJaExisteNaExtban(ALancamento: TLancamentoExtrato): Boolean;
  end;

implementation

uses untTLibContasBancariasFuncoes;

{ TExtratoBancoDoBrasil }

constructor TExtratoBancoDoBrasil.Create;
begin
  inherited Create;
  FQuery := VS_FuncoesExternas.fICriaQuery;
  FExisteCampoIdTransacao := TLibContaBancariaFuncoes.CampoExiste('EXTBAN', 'EXT_ID_TRA') and
                             TLibContaBancariaFuncoes.CampoExiste('EXT_BCOBBR', 'EXT_ID_TRA');
end;

destructor TExtratoBancoDoBrasil.Destroy;
begin
  FQuery.Free;
  inherited;
end;

function TExtratoBancoDoBrasil.LancamentoJaExisteNaExtban(ALancamento: TLancamentoExtrato): Boolean;
begin
  try
    FQuery.SQL.Text :=
      'SELECT COUNT(*) AS TOTAL ' +
      'FROM EXTBAN ' +
      'WHERE EXT_CODBCO = :EXT_CODBCO ' +
      '  AND EXT_AGENCI = :EXT_AGENCI ' +
      '  AND EXT_CODCTA = :EXT_CODCTA ' +
      '  AND EXT_DTALAN = :EXT_DTALAN ' +
      '  AND EXT_CODPOR = :EXT_CODPOR ' +
      '  AND EXT_DOCOFX = :EXT_DOCOFX ' +
      '  AND EXT_HISTOR = :EXT_HISTOR ' +
      '  AND EXT_CREDEB = :EXT_CREDEB ' +
      '  AND EXT_VALLAN = :EXT_VALLAN ';

    if FExisteCampoIdTransacao then
      FQuery.SQL.Text := FQuery.SQL.Text + '  AND EXT_ID_TRA = :EXT_ID_TRA ';

    FQuery.ParamByName('EXT_CODBCO').AsString := '001';
    FQuery.ParamByName('EXT_AGENCI').AsString := ALancamento.Agencia;
    FQuery.ParamByName('EXT_CODCTA').AsString := ALancamento.Conta;

    FQuery.ParamByName('EXT_DTALAN').Clear;
    if ALancamento.DataLancamento <> 0 then
      FQuery.ParamByName('EXT_DTALAN').AsDate := ALancamento.DataLancamento;

    FQuery.ParamByName('EXT_CODPOR').AsString := Copy(ALancamento.ContaBancaria.Portador, 1, 5);
    FQuery.ParamByName('EXT_HISTOR').AsString := RetornaHistoricoCompleto(ALancamento);
    FQuery.ParamByName('EXT_CREDEB').AsString := ALancamento.IndicadorSinalLancamento.ToUpper;
    FQuery.ParamByName('EXT_VALLAN').AsFloat  := ALancamento.ValorLancamento;
    FQuery.ParamByName('EXT_DOCOFX').AsString := ALancamento.NumeroDocumento.ToString;

    if FExisteCampoIdTransacao then
    begin
      FQuery.ParamByName('EXT_ID_TRA').AsString := ALancamento.TextoIdentificadorUnicoTransacao;
      if FQuery.ParamByName('EXT_ID_TRA').AsString.IsEmpty then
        FQuery.ParamByName('EXT_ID_TRA').Clear;
    end;

    FQuery.Open;

    Result := (FQuery.FieldByName('TOTAL').AsInteger > 0);

    FQuery.Close;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

procedure TExtratoBancoDoBrasil.SalvarLancamento(ALancamento: TLancamentoExtrato);
  Var
    LHistorico: String;
begin
  try
    FQuery.SQL.Text := RetornaSqlReplaceExtBcoBbr;

    FQuery.ParamByName('EXT_NUMAGE').AsString := ALancamento.Agencia;
    FQuery.ParamByName('EXT_NUMCTA').AsString := ALancamento.Conta;
    FQuery.ParamByName('EXT_TIPLAN').AsString := ALancamento.IndicadorTipoLancamento;

    FQuery.ParamByName('EXT_DTALAN').Clear;
    if ALancamento.DataLancamento <> 0 then
      FQuery.ParamByName('EXT_DTALAN').AsDate := ALancamento.DataLancamento;

    FQuery.ParamByName('EXT_DTAMOV').Clear;
    if ALancamento.DataMovimento <> 0 then
      FQuery.ParamByName('EXT_DTAMOV').AsDate := ALancamento.DataMovimento;

    FQuery.ParamByName('EXT_AGEORI').AsString := ALancamento.CodigoAgenciaOrigem.ToString;
    FQuery.ParamByName('EXT_NUMLOT').AsInteger := ALancamento.NumeroLote;
    FQuery.ParamByName('EXT_NUMDOC').AsLargeInt := ALancamento.NumeroDocumento;
    FQuery.ParamByName('EXT_CODHIS').AsInteger := ALancamento.CodigoHistorico;

    LHistorico := ALancamento.TextoDescricaoHistorico;
    If Not LHistorico.IsEmpty Then
      LHistorico := LHistorico + ' - ';

    LHistorico := LHistorico + ALancamento.TextoDescricaoSubHistorico;
    FQuery.ParamByName('EXT_DESHIS').AsString := LHistorico;

    FQuery.ParamByName('EXT_VALLAN').AsFloat := ALancamento.ValorLancamento;
    FQuery.ParamByName('EXT_CREDEB').AsString := ALancamento.IndicadorSinalLancamento;
    FQuery.ParamByName('EXT_HISCOM').AsString := ALancamento.TextoInformacaoComplementar;
    FQuery.ParamByName('EXT_DOC_PF').AsString := ALancamento.NumeroCpfCnpjContrapartida;
    FQuery.ParamByName('EXT_TIPDOC').AsString := ALancamento.IndicadorTipoPessoaContrapartida;
    FQuery.ParamByName('EXT_BCO_CP').AsString := FormatFloat('000', ALancamento.CodigoBancoContrapartida);
    FQuery.ParamByName('EXT_AGE_CP').AsString := ALancamento.CodigoAgenciaContrapartida.ToString;
    FQuery.ParamByName('EXT_CTA_CP').AsString := ALancamento.NumeroContaContrapartida;
    FQuery.ParamByName('EXT_DVC_CP').AsString := ALancamento.TextoDvContaContrapartida;

    FQuery.ParamByName('EXT_OPEIMP').AsString := ALancamento.OperadorImportacao;
    FQuery.ParamByName('EXT_DTAIMP').AsDate := ALancamento.DataImportacao;
    FQuery.ParamByName('EXT_HORIMP').AsTime := ALancamento.HoraDaImportacao;
    FQuery.ParamByName('EXT_URLIMP').AsString := ALancamento.UrlImportacao;

    if FExisteCampoIdTransacao then
    begin
      FQuery.ParamByName('EXT_ID_TRA').AsString := ALancamento.TextoIdentificadorUnicoTransacao;
      If FQuery.ParamByName('EXT_ID_TRA').AsString.IsEmpty then
        FQuery.ParamByName('EXT_ID_TRA').Clear;
    end;

    FQuery.ExecSQL;

    SalvarNaExtban(ALancamento);
  except
    on E: Exception do
      raise Exception.Create('Erro ao salvar lançamento: ' + E.Message);
  end;
end;

procedure TExtratoBancoDoBrasil.SalvarNaExtban(ALancamento: TLancamentoExtrato);
begin

  If ALancamento.ContaBancaria.Portador.IsEmpty Then
    Exit;

  If ALancamento.IndicadorTipoLancamento <> '1' Then
    Exit;

  If (ALancamento.CodigoHistorico = 0) or
     (ALancamento.CodigoHistorico = 999) then
    Exit;

  ALancamento.ContaBancaria.QuantidadeDeMovimentacoes := ALancamento.ContaBancaria.QuantidadeDeMovimentacoes + 1;

  If LancamentoJaExisteNaExtban(ALancamento) Then
    Exit;

  try
    FQuery.SQL.Text := RetornaSqlInsertExtban;

    FQuery.ParamByName('AUTOINCREM').AsString := VS_FuncoesExternas.fIRetAutoIncrem('EXTBAN', VS_FuncoesExternas.fIRetEmpresaLogada);
    FQuery.ParamByName('EXT_AGENCI').AsString := ALancamento.Agencia;
    FQuery.ParamByName('EXT_ARQIMP').AsString := ALancamento.UrlImportacao;
    FQuery.ParamByName('EXT_AUTORI').AsString := ALancamento.OperadorImportacao;
    FQuery.ParamByName('EXT_CODBCO').AsString := '001';
    FQuery.ParamByName('EXT_CODCTA').AsString := ALancamento.Conta;

    FQuery.ParamByName('EXT_CODEMP').AsString := VS_FuncoesExternas.fIRetEmpresaLogada;
    FQuery.ParamByName('EXT_CODPOR').AsString := Copy(ALancamento.ContaBancaria.Portador, 1, 5);

    FQuery.ParamByName('EXT_CREDEB').AsString := ALancamento.IndicadorSinalLancamento.ToUpper;

    FQuery.ParamByName('EXT_DTACON').Clear;
    FQuery.ParamByName('EXT_DTAIMP').AsDate := ALancamento.DataImportacao;

    FQuery.ParamByName('EXT_DTALAN').Clear;
    if ALancamento.DataLancamento <> 0 then
      FQuery.ParamByName('EXT_DTALAN').AsDate := ALancamento.DataLancamento;

    FQuery.ParamByName('EXT_HISTOR').AsString := RetornaHistoricoCompleto(ALancamento);
    FQuery.ParamByName('EXT_HORCON').Clear;
    FQuery.ParamByName('EXT_OPECON').Clear;
    FQuery.ParamByName('EXT_OPEIMP').AsString := ALancamento.OperadorImportacao;
    FQuery.ParamByName('EXT_SITUAC').AsString := 'N';
    FQuery.ParamByName('EXT_TIPIMP').AsString := 'A';

    FQuery.ParamByName('EXT_VALLAN').AsFloat := ALancamento.ValorLancamento;
    FQuery.ParamByName('EXT_DOCOFX').AsString := ALancamento.NumeroDocumento.ToString;
    FQuery.ParamByName('EXT_HORIMP').AsTime := ALancamento.HoraDaImportacao;

    if FExisteCampoIdTransacao then
    begin
      FQuery.ParamByName('EXT_ID_TRA').AsString := ALancamento.TextoIdentificadorUnicoTransacao;
      if FQuery.ParamByName('EXT_ID_TRA').AsString.IsEmpty then
        FQuery.ParamByName('EXT_ID_TRA').Clear;
    end;

    FQuery.ExecSQL;

  except
    on E: Exception do
      raise Exception.Create('Erro ao salvar na tabela EXTBAN: ' + E.Message);
  end;
end;

function TExtratoBancoDoBrasil.RetornaCampoIdTransacaoSeExiste(AEhParametro: Boolean): String;
begin
  if not FExisteCampoIdTransacao then
    Exit('');

  Result := ',';

  if AEhParametro then
    Result := Result + ':';

  Result := Result + 'EXT_ID_TRA';
end;

function TExtratoBancoDoBrasil.RetornaHistoricoCompleto(const ALancamento: TLancamentoExtrato): String;
begin
  Result := ALancamento.TextoDescricaoHistorico;

  if Not ALancamento.TextoDescricaoSubHistorico.IsEmpty then
  begin
    if Not Result.IsEmpty then
      Result := Result + ' - ';

    Result := Result + ALancamento.TextoDescricaoSubHistorico;
  end;

  if Not ALancamento.TextoInformacaoComplementar.IsEmpty then
  begin
    if Not Result.IsEmpty then
      Result := Result + ' - ';

    Result := Result + ALancamento.TextoInformacaoComplementar;
  end;

  Result := AnsiUpperCase(Result);
end;

function TExtratoBancoDoBrasil.RetornaSqlReplaceExtBcoBbr: string;
begin
  Result :=
    'REPLACE INTO EXT_BCOBBR (' +
    '    EXT_NUMAGE,' +
    '    EXT_NUMCTA,' +
    '    EXT_TIPLAN,' +
    '    EXT_DTALAN,' +
    '    EXT_DTAMOV,' +
    '    EXT_AGEORI,' +
    '    EXT_NUMLOT,' +
    '    EXT_NUMDOC,' +
    '    EXT_CODHIS,' +
    '    EXT_DESHIS,' +
    '    EXT_VALLAN,' +
    '    EXT_CREDEB,' +
    '    EXT_HISCOM,' +
    '    EXT_DOC_PF,' +
    '    EXT_TIPDOC,' +
    '    EXT_BCO_CP,' +
    '    EXT_AGE_CP,' +
    '    EXT_CTA_CP,' +
    '    EXT_DVC_CP,' +
    '    EXT_OPEIMP,' +
    '    EXT_DTAIMP,' +
    '    EXT_HORIMP,' +
    '    EXT_URLIMP' +
    RetornaCampoIdTransacaoSeExiste +
    ') VALUES (' +
    '    :EXT_NUMAGE,' +
    '    :EXT_NUMCTA,' +
    '    :EXT_TIPLAN,' +
    '    :EXT_DTALAN,' +
    '    :EXT_DTAMOV,' +
    '    :EXT_AGEORI,' +
    '    :EXT_NUMLOT,' +
    '    :EXT_NUMDOC,' +
    '    :EXT_CODHIS,' +
    '    :EXT_DESHIS,' +
    '    :EXT_VALLAN,' +
    '    :EXT_CREDEB,' +
    '    :EXT_HISCOM,' +
    '    :EXT_DOC_PF,' +
    '    :EXT_TIPDOC,' +
    '    :EXT_BCO_CP,' +
    '    :EXT_AGE_CP,' +
    '    :EXT_CTA_CP,' +
    '    :EXT_DVC_CP,' +
    '    :EXT_OPEIMP,' +
    '    :EXT_DTAIMP,' +
    '    :EXT_HORIMP,' +
    '    :EXT_URLIMP'+
    RetornaCampoIdTransacaoSeExiste(True);

  Result := Result + ')';
end;

function TExtratoBancoDoBrasil.RetornaSqlInsertExtban: string;
begin
  Result :=
    'INSERT INTO EXTBAN (' +
    '    AUTOINCREM,' +
    '    EXT_AGENCI,' +
    '    EXT_ARQIMP,' +
    '    EXT_AUTORI,' +
    '    EXT_CODBCO,' +
    '    EXT_CODCTA,' +
    '    EXT_CODEMP,' +
    '    EXT_CODPOR,' +
    '    EXT_CREDEB,' +
    '    EXT_DTACON,' +
    '    EXT_DTAIMP,' +
    '    EXT_DTALAN,' +
    '    EXT_HISTOR,' +
    '    EXT_HORCON,' +
    '    EXT_OPECON,' +
    '    EXT_OPEIMP,' +
    '    EXT_SITUAC,' +
    '    EXT_TIPIMP,' +
    '    EXT_VALLAN,' +
    '    EXT_DOCOFX,' +
    '    EXT_HORIMP ' +
    RetornaCampoIdTransacaoSeExiste +
    ') VALUES (' +
    '    :AUTOINCREM,' +
    '    :EXT_AGENCI,' +
    '    :EXT_ARQIMP,' +
    '    :EXT_AUTORI,' +
    '    :EXT_CODBCO,' +
    '    :EXT_CODCTA,' +
    '    :EXT_CODEMP,' +
    '    :EXT_CODPOR,' +
    '    :EXT_CREDEB,' +
    '    :EXT_DTACON,' +
    '    :EXT_DTAIMP,' +
    '    :EXT_DTALAN,' +
    '    :EXT_HISTOR,' +
    '    :EXT_HORCON,' +
    '    :EXT_OPECON,' +
    '    :EXT_OPEIMP,' +
    '    :EXT_SITUAC,' +
    '    :EXT_TIPIMP,' +
    '    :EXT_VALLAN,' +
    '    :EXT_DOCOFX,' +
    '    :EXT_HORIMP' +
    RetornaCampoIdTransacaoSeExiste(True) +
    ')';
end;

end.
