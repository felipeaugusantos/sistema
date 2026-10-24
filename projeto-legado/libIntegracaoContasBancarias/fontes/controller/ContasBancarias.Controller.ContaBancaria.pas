unit ContasBancarias.Controller.ContaBancaria;

interface

uses
  System.Generics.Collections, System.SysUtils, System.StrUtils,System.DateUtils,Uni, DB,
  ContasBancarias.Model.ContaBancaria,untTLibContasBancariasFuncoes,
  ContasBancarias.Model.CredenciaisAutenticacao,

  BancoDoBrasil.Controller.ImportacaoExtrato,
  Itau.Controller.ImportacaoExtrato;

type
  TImportacaoExtratoController = class
  private
    FConsultaSaldo: Boolean;
    FListaContas: TList<TContaBancaria>;
    function GetTotalContas: Integer;
    function GetSaldoTotal: Currency;
    function NomeBancoPorCodigo(ACodigoBanco: string): string;
    function TipoContaDescricao(ATipoConta: string): string;
    procedure ImportaExtratoBancoDoBrasil(AConta: TContaBancaria);
    procedure ImportaExtratoItau(AConta: TContaBancaria);
    procedure ConsultarSaldoBancoDoBrasil(out AConta: TContaBancaria);
    procedure ConsultarSaldoItau(out AConta: TContaBancaria);
    function RetornaSQLConsultaContasBancarias: String;
  public
    constructor Create(AConsultaSaldo: Boolean);
    destructor Destroy; override;

    procedure CarregarContasBanco;
    procedure ImportarExtrato(AConta: TContaBancaria);
    procedure ConsultarSaldo(out AConta: TContaBancaria);
    function RetornaDataUltimaImportacao(AConta: TContaBancaria): TDateTime;

    property ListaContas: TList<TContaBancaria> read FListaContas;
    property TotalContas: Integer read GetTotalContas;
    property SaldoTotal: Currency read GetSaldoTotal;
  end;

implementation

{ TImportacaoExtratoController }

function TImportacaoExtratoController.RetornaDataUltimaImportacao(AConta: TContaBancaria): TDateTime;
  Var
    LConsulta: TUniQuery;
begin
  Result := 0;
  LConsulta := VS_FuncoesExternas.fICriaQuery;

  try
    LConsulta.SQL.Text :=
      'SELECT MAX(EXT_DTALAN) AS ULTIMA_IMPORTACAO ' +
      'FROM EXTBAN ' +
      'WHERE EXT_CODBCO = :EXT_CODBCO ' +
      '  AND EXT_AGENCI = :EXT_AGENCI ' +
      '  AND EXT_CODCTA = :EXT_CODCTA ' +
      '  AND EXT_CODPOR = :EXT_CODPOR ' ;

    try
      LConsulta.ParamByName('EXT_CODBCO').AsString := FormatFloat('000', AConta.CodigoBanco);
      LConsulta.ParamByName('EXT_AGENCI').AsString := AConta.Agencia;
      LConsulta.ParamByName('EXT_CODCTA').AsString := AConta.NumeroConta;
      LConsulta.ParamByName('EXT_CODPOR').AsString := Copy(AConta.Portador, 1, 5);
      LConsulta.Open;

      Result := LConsulta.FieldByName('ULTIMA_IMPORTACAO').AsDateTime;
    except
      on E: Exception do
      begin
        raise Exception.Create(E.Message);
      end;
    end;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

procedure TImportacaoExtratoController.ConsultarSaldo(out AConta: TContaBancaria);
begin
  case AConta.CodigoBanco of
    001: ConsultarSaldoBancoDoBrasil(AConta);
    341: ConsultarSaldoItau(AConta);
  end;
end;

procedure TImportacaoExtratoController.ConsultarSaldoBancoDoBrasil(out AConta: TContaBancaria);
  Var
    LImportacaoExtratoBancoDoBrasil : TImportacaoExtratoBancoDoBrasil;
begin
  LImportacaoExtratoBancoDoBrasil := TImportacaoExtratoBancoDoBrasil.Create(AConta);
  Try
    LImportacaoExtratoBancoDoBrasil.ConsultarSaldo;
  Finally
    FreeAndNil(LImportacaoExtratoBancoDoBrasil);
  End;
end;

procedure TImportacaoExtratoController.ConsultarSaldoItau(
  out AConta: TContaBancaria);
  Var
    LImportacaoExtratoItau : TImportacaoExtratoItau;
begin
  LImportacaoExtratoItau := TImportacaoExtratoItau.Create(AConta);
  Try
    LImportacaoExtratoItau.ConsultarSaldo;
  Finally
    FreeAndNil(LImportacaoExtratoItau);
  End;
end;

constructor TImportacaoExtratoController.Create(AConsultaSaldo: Boolean);
begin
  FListaContas := TList<TContaBancaria>.Create;
  FConsultaSaldo := AConsultaSaldo;
end;

destructor TImportacaoExtratoController.Destroy;
  Var
    LContaBancaria: TContaBancaria;
begin
  try
    for LContaBancaria in FListaContas do
      LContaBancaria.LimparCredenciaisAutenticacao;
  finally
    FListaContas.Free;
  end;

  inherited;
end;

procedure TImportacaoExtratoController.CarregarContasBanco;
var
  LConsulta: TUniQuery;
  LConta: TContaBancaria;
  LCredenciaisAutenticacao: TCredenciaisAutenticacao;
  LPortador: String;
begin
  FListaContas.Clear;
  LConsulta := VS_FuncoesExternas.fICriaQuery;

  try
    LConsulta.Close;
    LConsulta.SQL.Text :=  RetornaSQLConsultaContasBancarias;
    LConsulta.Open;

    if not LConsulta.IsEmpty then
    begin
      LConsulta.First;

      While not LConsulta.Eof Do
      begin
        LCredenciaisAutenticacao := TCredenciaisAutenticacao.Create;
        LCredenciaisAutenticacao.Limpar;
        LCredenciaisAutenticacao.BuscarPorID(LConsulta.FieldByName('CCA_AUTCCA').AsString);
        LPortador := '';

        If Not LConsulta.FieldByName('POR_CODPOR').AsString.IsEmpty Then
          LPortador := Concat(LConsulta.FieldByName('POR_CODPOR').AsString,' - ', LConsulta.FieldByName('POR_NOMPOR').AsString);

        If Not FConsultaSaldo Then
        Begin
          If Not LConsulta.FieldByName('POR_CONOFX').AsString.Equals('S') Then
          Begin
            LConsulta.Next;
            Continue;
          End;
        End;

        LConta := TContaBancaria.Create;
        LConta.Inicializar(
          StrToIntDef(LConsulta.FieldByName('CCA_CODBCO').AsString, 0),
          NomeBancoPorCodigo(LConsulta.FieldByName('CCA_CODBCO').AsString),
          LConsulta.FieldByName('CCA_AGENCI').AsString,
          LConsulta.FieldByName('CCA_CODCTA').AsString,
          LConsulta.FieldByName('CCA_DIGCTA').AsString,
          TipoContaDescricao(LConsulta.FieldByName('CCA_TIPCON').AsString),
          0.00,
          LConsulta.FieldByName('DATA_IMPORTACAO').AsDateTime,
          LPortador,
          LCredenciaisAutenticacao
        );

        FListaContas.Add(LConta);
        LConsulta.Next;
      end;
    end;

  finally
    if Assigned(LConsulta) then
      LConsulta.Free;
  end;
end;

function TImportacaoExtratoController.NomeBancoPorCodigo(ACodigoBanco: string): string;
begin
  case StrToIntDef(ACodigoBanco, 0) of
    001: Result := 'Banco do Brasil';
    341: Result := 'Itaú';
    else Result := 'Banco ' + ACodigoBanco;
  end;
end;

function TImportacaoExtratoController.RetornaSQLConsultaContasBancarias: String;
begin
  Result :=   'SELECT                                                                         '+
              '  MAX(                                                                         '+
              '    CASE                                                                       '+
              '      WHEN EXT_DTALAN IS NOT NULL                                              '+
              '      THEN TIMESTAMP(                                                          '+
              '        EXT_DTALAN,                                                            '+
              '        IFNULL(EXT_HORIMP, "00:00:00")                                         '+
              '      )                                                                        '+
              '    END                                                                        '+
              '  ) AS DATA_IMPORTACAO,                                                        '+
              '  CCA_CODBCO,                                                                  '+
              '  CCA_AGENCI,                                                                  '+
              '  CCA_CODCTA,                                                                  '+
              '  CCA_DIGCTA,                                                                  '+
              '  CCA_TIPCON,                                                                  '+
              '  POR_CODPOR,                                                                  '+
              '  POR_NOMPOR,                                                                  '+
              '  POR_CONOFX,                                                                  '+
              '  CCA_AUTCCA                                                                   '+
              'FROM                                                                           '+
              '  CADCCA                                                                       '+
              '  JOIN AUTCCA A                                                                '+
              '    ON A.AUTOINCREM = CCA_AUTCCA                                               '+
              '  LEFT JOIN CADPOR                                                             '+
              '    ON POR_CCAAUT = CADCCA.AUTOINCREM                                          '+
              '  LEFT JOIN EXTBAN                                                             '+
              '    ON LEFT(EXT_CODCTA, LENGTH(CCA_CODCTA)) = CCA_CODCTA                       '+
              '    AND TRIM(LEADING 0 FROM EXT_AGENCI) = TRIM(LEADING 0 FROM CCA_AGENCI)      '+
              '    AND TRIM(LEADING 0 FROM EXT_CODBCO) = TRIM(LEADING 0 FROM CCA_CODBCO)      '+
              'WHERE CCA_CODBCO IN ("001","341")                                              '+
              '  AND IFNULL(AUT_CLISEC,"") <> ""                                              '+
              'GROUP BY CCA_CODCTA,                                                           '+
              '  CCA_AGENCI,                                                                  '+
              '  CCA_CODBCO                                                                   ';
end;

function TImportacaoExtratoController.TipoContaDescricao(ATipoConta: string): string;
begin
  case StrToIntDef(ATipoConta, 0) of
    1: Result := '(Corrente)';
    2: Result := '(Poupança)';
    3: Result := '(Outros)';
  else
    Result := '(' + ATipoConta + ')';
  end;
end;

procedure TImportacaoExtratoController.ImportaExtratoBancoDoBrasil(AConta: TContaBancaria);
  Var
    LImportacaoExtratoBancoDoBrasil : TImportacaoExtratoBancoDoBrasil;
begin
  LImportacaoExtratoBancoDoBrasil := TImportacaoExtratoBancoDoBrasil.Create(AConta);
  Try
    LImportacaoExtratoBancoDoBrasil.Importar;
  Finally
    FreeAndNil(LImportacaoExtratoBancoDoBrasil);
  End;
end;

procedure TImportacaoExtratoController.ImportaExtratoItau(
  AConta: TContaBancaria);
  Var
    LImportacaoExtratoItau : TImportacaoExtratoItau;
begin
  LImportacaoExtratoItau := TImportacaoExtratoItau.Create(AConta);
  Try
    LImportacaoExtratoItau.Importar;
  Finally
    FreeAndNil(LImportacaoExtratoItau);
  End;
end;

procedure TImportacaoExtratoController.ImportarExtrato(AConta: TContaBancaria);
begin
  case AConta.CodigoBanco of
    001: ImportaExtratoBancoDoBrasil(AConta);
    341: ImportaExtratoItau(AConta);
  end;
end;

function TImportacaoExtratoController.GetTotalContas: Integer;
begin
  Result := FListaContas.Count;
end;

function TImportacaoExtratoController.GetSaldoTotal: Currency;
var
  LContador: Integer;
begin
  Result := 0;
  for LContador := 0 to FListaContas.Count - 1 do
    Result := Result + FListaContas[LContador].Saldo;
end;

end.
