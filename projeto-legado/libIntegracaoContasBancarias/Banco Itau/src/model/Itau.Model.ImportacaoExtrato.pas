unit Itau.Model.ImportacaoExtrato;

interface

uses
  System.SysUtils, System.Classes, Uni, DBAccess,
  Itau.Model.LancamentoExtrato;

type
  TExtratoItau = class
  private
    FQuery: TUniQuery;
    function RetornaSqlReplaceExtItau: String;
    function RetornaSqlInsertExtban: String;
    procedure SalvarNaExtban(ALancamento: TLancamentoExtrato);
    function RetornaHistoricoLancamento(ALancamento: TLancamentoExtrato):String;
  public
    constructor Create;
    destructor Destroy; override;
    procedure SalvarLancamento(ALancamento: TLancamentoExtrato);
    function LancamentoJaExisteNaExtban(ALancamento: TLancamentoExtrato): Boolean;
  end;

implementation

uses
  untTLibContasBancariasFuncoes,
  System.Math,
  System.StrUtils;

{ TExtratoItau }

constructor TExtratoItau.Create;
begin
  inherited Create;
  FQuery := VS_FuncoesExternas.fICriaQuery;
end;

destructor TExtratoItau.Destroy;
begin
  FQuery.Free;
  inherited;
end;

function TExtratoItau.LancamentoJaExisteNaExtban(ALancamento: TLancamentoExtrato): Boolean;
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
      '  AND EXT_HISTOR = :EXT_HISTOR ' +
      '  AND EXT_CREDEB = :EXT_CREDEB ' +
      '  AND EXT_VALLAN = :EXT_VALLAN ';

    FQuery.ParamByName('EXT_CODBCO').AsString := '341';
    FQuery.ParamByName('EXT_AGENCI').AsString := ALancamento.Agencia;
    FQuery.ParamByName('EXT_CODCTA').AsString := ALancamento.Conta + '-' + ALancamento.DigitoConta;

    FQuery.ParamByName('EXT_DTALAN').Clear;
    if ALancamento.DataEvento <> 0 then
      FQuery.ParamByName('EXT_DTALAN').AsDate := ALancamento.DataContabil;

    FQuery.ParamByName('EXT_CODPOR').AsString := Copy(ALancamento.ContaBancaria.Portador, 1, 5);

    FQuery.ParamByName('EXT_HISTOR').AsString := RetornaHistoricoLancamento(ALancamento);

    FQuery.ParamByName('EXT_CREDEB').AsString := ALancamento.Operacao;
    FQuery.ParamByName('EXT_VALLAN').AsFloat := Abs(ALancamento.ValorLancamento);

    FQuery.Open;
    Result := (FQuery.FieldByName('TOTAL').AsInteger > 0);
    FQuery.Close;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TExtratoItau.SalvarLancamento(ALancamento: TLancamentoExtrato);
begin
  try
    FQuery.SQL.Text := RetornaSqlReplaceExtItau;

    FQuery.ParamByName('EXT_NUMAGE').AsString := ALancamento.Agencia;
    FQuery.ParamByName('EXT_NUMCCA').AsString := ALancamento.Conta;
    FQuery.ParamByName('EXT_DV_CCA').AsString := ALancamento.DigitoConta;

    FQuery.ParamByName('EXT_ID_EVE').AsString := ALancamento.IdEvento;
    FQuery.ParamByName('EXT_CREDEB').AsString := ALancamento.Operacao;
    FQuery.ParamByName('EXT_DTACON').Clear;

    FQuery.ParamByName('EXT_DTACON').AsString := '0000-00-00';
    if ALancamento.DataContabil <> 0 then
      FQuery.ParamByName('EXT_DTACON').AsDateTime := ALancamento.DataContabil;

    FQuery.ParamByName('EXT_CODHIS').AsString := ALancamento.CodigoHistorico;
    FQuery.ParamByName('EXT_VALLAN').AsFloat := Abs(ALancamento.ValorLancamento);

    FQuery.ParamByName('EXT_TIPEVE').AsString := ALancamento.TipoEvento;
    FQuery.ParamByName('EXT_ESTONO').AsBoolean := ALancamento.Estorno;

    FQuery.ParamByName('EXT_DTAEVE').Clear;
    if ALancamento.DataEvento <> 0 then
      FQuery.ParamByName('EXT_DTAEVE').AsDateTime := ALancamento.DataEvento;

    // Histórico
    FQuery.ParamByName('EXT_DESRES').AsString := ALancamento.DescricaoResumida;
    FQuery.ParamByName('EXT_DESCOM').AsString := ALancamento.DescricaoCompleta;
    FQuery.ParamByName('EXT_TIPMOE').AsString := ALancamento.Moeda;

    // Contrapartida
    FQuery.ParamByName('EXT_TIP_CP').AsString := ALancamento.TipoContrapartida;
    FQuery.ParamByName('EXT_ISPB_CP').AsString := ALancamento.ISPBContrapartida;
    FQuery.ParamByName('EXT_AGE_CP').AsString := ALancamento.AgenciaContrapartida;
    FQuery.ParamByName('EXT_CCA_CP').AsString := ALancamento.ContaContrapartida;
    FQuery.ParamByName('EXT_DVC_CP').AsString := ALancamento.DigitoContaContrapartida;
    FQuery.ParamByName('EXT_NOM_CP').AsString := ALancamento.NomeContrapartida;
    FQuery.ParamByName('EXT_DOC_CP').AsString := ALancamento.DocumentoContrapartida;
    FQuery.ParamByName('EXT_TDC_CP').AsString := ALancamento.TipoPessoaContrapartida;

    // Origem
    FQuery.ParamByName('EXT_ID_ORI').AsString := ALancamento.IdentificadorOrigem;
    FQuery.ParamByName('EXT_OPEORI').AsString := ALancamento.OperacaoOrigem;
    FQuery.ParamByName('EXT_CANORI').AsString := ALancamento.CanalOrigem;
    FQuery.ParamByName('EXT_TIPHIS').AsString := ALancamento.TipoHistorico;

    // Campos de importação
    FQuery.ParamByName('EXT_OPEIMP').AsString := ALancamento.OperadorImportacao;
    FQuery.ParamByName('EXT_DTAIMP').AsDate := ALancamento.DataImportacao;
    FQuery.ParamByName('EXT_HORIMP').AsTime := ALancamento.HoraDaImportacao;
    FQuery.ParamByName('EXT_URLIMP').AsString := ALancamento.UrlImportacao;

    FQuery.ExecSQL;

    SalvarNaExtban(ALancamento);
  except
    on E: Exception do
      raise Exception.Create('Erro ao salvar lançamento Itaú: ' + E.Message);
  end;
end;

procedure TExtratoItau.SalvarNaExtban(ALancamento: TLancamentoExtrato);
begin
  If ALancamento.ContaBancaria.Portador.IsEmpty Then
    Exit;

  If not SameText(ALancamento.TipoEvento, 'lancamento') Then
    Exit;

  ALancamento.ContaBancaria.QuantidadeDeMovimentacoes := ALancamento.ContaBancaria.QuantidadeDeMovimentacoes + 1;

  If LancamentoJaExisteNaExtban(ALancamento) Then
    Exit;

  try
    FQuery.SQL.Text := RetornaSqlInsertExtban;
    FQuery.ParamByName('AUTOINCREM').AsString :=  VS_FuncoesExternas.fIRetAutoIncrem('EXTBAN', VS_FuncoesExternas.fIRetEmpresaLogada);

    FQuery.ParamByName('EXT_AGENCI').AsString := ALancamento.Agencia;
    FQuery.ParamByName('EXT_ARQIMP').AsString := ALancamento.UrlImportacao;
    FQuery.ParamByName('EXT_CODBCO').AsString := '341';
    FQuery.ParamByName('EXT_CODCTA').AsString := ALancamento.Conta + '-' + ALancamento.DigitoConta;
    FQuery.ParamByName('EXT_CODEMP').AsString := VS_FuncoesExternas.fIRetEmpresaLogada;
    FQuery.ParamByName('EXT_CODPOR').AsString := Copy(ALancamento.ContaBancaria.Portador, 1, 5);
    FQuery.ParamByName('EXT_CREDEB').AsString := ALancamento.Operacao.ToUpper;
    FQuery.ParamByName('EXT_DTACON').Clear;
    FQuery.ParamByName('EXT_DTAIMP').AsDate := ALancamento.DataImportacao;

    FQuery.ParamByName('EXT_DTALAN').Clear;
    if ALancamento.DataEvento <> 0 then
      FQuery.ParamByName('EXT_DTALAN').AsDate := ALancamento.DataContabil;

    FQuery.ParamByName('EXT_HISTOR').AsString := RetornaHistoricoLancamento(ALancamento);

    FQuery.ParamByName('EXT_HORCON').Clear;
    FQuery.ParamByName('EXT_OPECON').Clear;
    FQuery.ParamByName('EXT_OPEIMP').AsString := ALancamento.OperadorImportacao;
    FQuery.ParamByName('EXT_SITUAC').AsString := 'N';
    FQuery.ParamByName('EXT_TIPIMP').AsString := 'A';

    FQuery.ParamByName('EXT_VALLAN').AsFloat := Abs(ALancamento.ValorLancamento);
    FQuery.ParamByName('EXT_DOCOFX').AsString := ALancamento.IdEvento;
    FQuery.ParamByName('EXT_HORIMP').AsTime := ALancamento.HoraDaImportacao;

    FQuery.ExecSQL;

  except
    on E: Exception do
      raise Exception.Create('Erro ao salvar na EXTBAN: ' + E.Message);
  end;
end;

function TExtratoItau.RetornaSqlReplaceExtItau: string;
begin
  Result :=
    'REPLACE INTO EXT_BCITAU (' +
    '    EXT_NUMAGE, EXT_NUMCCA, EXT_DV_CCA, ' +
    '    EXT_ID_EVE, EXT_TIPEVE, EXT_CREDEB, EXT_ESTONO, ' +
    '    EXT_DTAEVE, EXT_DTACON, ' +
    '    EXT_CODHIS, EXT_DESRES, EXT_DESCOM, ' +
    '    EXT_VALLAN, EXT_TIPMOE, ' +
    '    EXT_TIP_CP, EXT_ISPB_CP, ' +
    '    EXT_AGE_CP, EXT_CCA_CP, EXT_DVC_CP, ' +
    '    EXT_NOM_CP, EXT_DOC_CP, EXT_TDC_CP, ' +
    '    EXT_ID_ORI, EXT_OPEORI, EXT_CANORI, EXT_TIPHIS, ' +
    '    EXT_OPEIMP, EXT_DTAIMP, EXT_HORIMP, EXT_URLIMP' +
    ') VALUES (' +
    '    :EXT_NUMAGE, :EXT_NUMCCA, :EXT_DV_CCA, ' +
    '    :EXT_ID_EVE, :EXT_TIPEVE, :EXT_CREDEB, :EXT_ESTONO, ' +
    '    :EXT_DTAEVE, :EXT_DTACON, ' +
    '    :EXT_CODHIS, :EXT_DESRES, :EXT_DESCOM, ' +
    '    :EXT_VALLAN, :EXT_TIPMOE, ' +
    '    :EXT_TIP_CP, :EXT_ISPB_CP, ' +
    '    :EXT_AGE_CP, :EXT_CCA_CP, :EXT_DVC_CP, ' +
    '    :EXT_NOM_CP, :EXT_DOC_CP, :EXT_TDC_CP, ' +
    '    :EXT_ID_ORI, :EXT_OPEORI, :EXT_CANORI, :EXT_TIPHIS, ' +
    '    :EXT_OPEIMP, :EXT_DTAIMP, :EXT_HORIMP, :EXT_URLIMP' +
    ')';
end;

function TExtratoItau.RetornaHistoricoLancamento(
  ALancamento: TLancamentoExtrato): String;
begin
  Result := ALancamento.DescricaoCompleta;

  If Not ALancamento.TipoHistorico.IsEmpty Then
   Result := Result + ' - ' + ALancamento.TipoHistorico ;

  If UpperCase(ALancamento.Operacao).Equals('C') Then
    Result := Concat(ALancamento.DescricaoCompleta, ' ',
                     ALancamento.NomeContrapartida, ' ',
                     ALancamento.DocumentoContrapartida);

  Result := AnsiUpperCase(Result);
end;

function TExtratoItau.RetornaSqlInsertExtban: string;
begin
  Result :=
    'INSERT INTO EXTBAN (' +
    '    AUTOINCREM, EXT_AGENCI, EXT_ARQIMP, EXT_AUTORI, ' +
    '    EXT_CODBCO, EXT_CODCTA, EXT_CODEMP, EXT_CODPOR, ' +
    '    EXT_CREDEB, EXT_DTACON, EXT_DTAIMP, EXT_DTALAN, ' +
    '    EXT_HISTOR, EXT_HORCON, EXT_OPECON, EXT_OPEIMP, ' +
    '    EXT_SITUAC, EXT_TIPIMP, EXT_VALLAN, EXT_DOCOFX, EXT_HORIMP' +
    ') VALUES (' +
    '    :AUTOINCREM, :EXT_AGENCI, :EXT_ARQIMP, :EXT_AUTORI, ' +
    '    :EXT_CODBCO, :EXT_CODCTA, :EXT_CODEMP, :EXT_CODPOR, ' +
    '    :EXT_CREDEB, :EXT_DTACON, :EXT_DTAIMP, :EXT_DTALAN, ' +
    '    :EXT_HISTOR, :EXT_HORCON, :EXT_OPECON, :EXT_OPEIMP, ' +
    '    :EXT_SITUAC, :EXT_TIPIMP, :EXT_VALLAN, :EXT_DOCOFX, :EXT_HORIMP' +
    ')';
end;

end.
