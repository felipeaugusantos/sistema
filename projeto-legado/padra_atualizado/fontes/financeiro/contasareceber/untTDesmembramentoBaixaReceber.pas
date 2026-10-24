unit untTDesmembramentoBaixaReceber;

interface

uses
  Classes, SysUtils, Generics.Collections, DateUtils, Math, Generics.Defaults,
  Uni, DB, Variants, untFuncoesSimples, System.StrUtils, untLogCtr, untcadrec;

type
  TModalidadePagamento = (mpDinheiro, mpCartao, mpChequePre, mpChequeAvista, mpOrdem, mpCreditoUtilizado);

const
  ModalidadeCampos: array[TModalidadePagamento] of string = (
    'CTR_DINHEI',       // mpDinheiro
    'CTR_CARTAO',       // mpCartao
    'CTR_CHQPRE',       // mpChequePre
    'CTR_CHQAVI',       // mpChequeAvista
    'CTR_ORDPAG',       // mpOrdem
    'CTR_DINHEI'        // mpCreditoUtilizado
  );

type
  TDuplicata = class
  private
    FAutoincremDuplicata: string;
    FNumeroDuplicata,
    FParcela,
    FEspecie,
    FCodigoEmpresa,
    FCodigoCliente: String;
    FValorRecebido: Double;
    FDataVencimento: TDate;
    FJuros: Double;
    FVFrete: Double;
    FDesconto: Double;
    FDespesaCobranca: Double;
    FSequencialBaixaInicial: Integer;
    FSequencialControleBaixa: Integer;
    FEmpresaBaixa: String;
    FDataBaixa: TDate;
    FDataRecebimento: TDate;
    FPortadorBaixa : String;
    FSequencialLancamentoBancario: String;
  public
    constructor Create(const AAutoincremDuplicata: string;
                             AValorRecebido,
                             AJuros,
                             ADesconto,
                             ADespesaCobranca: Double;
                             ADataVencimento: TDate;
                             ASequencialBaixaInicial: Integer;
                             ASequencialControleBaixa: Integer;
                             AEmpresaBaixa: String;
                             ADataBaixa: TDate;
                             ADataRecebimento: TDate;
                             AVFrete: Double;
                             ANumeroDuplicata,
                             AParcela,
                             AEspecie,
                             ACodigoEmpresa,
                             ACodigoCliente,
                             APortadorBaixa: String;
                             ASequencialLancamentoBancario: String);

    property AutoincremDuplicata: string read FAutoincremDuplicata;
    property NumeroDuplicata: string read FNumeroDuplicata;
    property Parcela: string read FParcela;
    property Especie: string read FEspecie;
    property CodigoEmpresa: string read FCodigoEmpresa;
    property CodigoCliente: string read FCodigoCliente;
    property ValorRecebido: Double read FValorRecebido;
    property DataVencimento: TDate read FDataVencimento;
    property Juros: Double read FJuros;
    property Desconto: Double read FDesconto;
    property DespesaCobranca: Double read FDespesaCobranca;
    property ValorFrete: Double Read FVFrete;
    property SequencialBaixaInicial: Integer read FSequencialBaixaInicial;
    property SequencialControleBaixa: Integer read FSequencialControleBaixa write FSequencialControleBaixa;
    property EmpresaBaixa: String read FEmpresaBaixa write FEmpresaBaixa;
    property DataBaixa: TDate read FDataBaixa write FDataBaixa;
    property DataRecebimento: TDate read FDataRecebimento write FDataRecebimento;
    property PortadorBaixa : String read FPortadorBaixa write FPortadorBaixa;
    property SequencialLancamentoBancario: String read FSequencialLancamentoBancario;
  end;

  TRegistroBaixa = class
  private
    FSequencialBaixa: Integer;
    FAutoincremDuplicata: string;
    FCampoModalidade: string;
    FValorRecebido: Double;
    FCreditoDinheiro: Double;
    FCreditoCartao: Double;
    FCreditoChequePre: Double;
    FCreditoChequeAvista: Double;
    FCreditoOrdem: Double;
    FJuros: Double;
    FVFrete: Double;
    FDesconto: Double;
    FDespesaCobranca: Double;
    FValorOriginal: Double;
    FSequencialControleBaixa: Integer;
    FEmpresaBaixa: String;
    FDataBaixa: TDate;
    FDataRecebimento: TDate;
    FPortadorBaixa : String;
    FSequencialLancamentoBancario: String;
  public
    constructor Create;
    property SequencialBaixa: Integer read FSequencialBaixa write FSequencialBaixa;
    property AutoincremDuplicata: string read FAutoincremDuplicata write FAutoincremDuplicata;
    property ValorRecebido: Double read FValorRecebido write FValorRecebido;
    property CreditoCartao: Double read FCreditoCartao write FCreditoCartao;
    property CreditoDinheiro: Double read FCreditoDinheiro write FCreditoDinheiro;
    property CreditoChequePre: Double read FCreditoChequePre write FCreditoChequePre;
    property CreditoChequeAvista: Double read FCreditoChequeAvista write FCreditoChequeAvista;
    property CreditoOrdem: Double read FCreditoOrdem write FCreditoOrdem;
    property Juros: Double read FJuros write FJuros;
    property ValorFrete: Double Read FVFrete Write FVFrete;
    property Desconto: Double read FDesconto write FDesconto;
    property DespesaCobranca: Double read FDespesaCobranca write FDespesaCobranca;
    property ValorOriginal: Double read FValorOriginal write FValorOriginal;
    property CampoModalidade: String read FCampoModalidade write FCampoModalidade;
    property SequencialControleBaixa: Integer read FSequencialControleBaixa write FSequencialControleBaixa;
    property EmpresaBaixa: String read FEmpresaBaixa write FEmpresaBaixa;
    property DataBaixa: TDate read FDataBaixa write FDataBaixa;
    property DataRecebimento: TDate read FDataRecebimento write FDataRecebimento;
    property PortadorBaixa : String read FPortadorBaixa write FPortadorBaixa;
    property SequencialLancamentoBancario: String read FSequencialLancamentoBancario write FSequencialLancamentoBancario;
  end;

  TDesmembraBaixaReceber = class
  private
    FDuplicatas: TList<TDuplicata>;
    FBaixas: TList<TRegistroBaixa>;
    FPortadorTF: String;
    FValorTotalCreditoGerado: Double;

    FCamposCadRec,
    FCamposNovoCadRec,
    FParametrosNovoCadRec: String;

    FCamposNovoBanctr,
    FParametrosNovoBanctr: String;

    procedure GeraListaDeCamposBANCTR;
    procedure GeraListaDeCamposCADREC;

    function ObterValorTotalCreditos: Double;
    function ObterDuplicatasPositivas: TList<TDuplicata>;
    function ObterDuplicatasCredito: TList<TDuplicata>;
    procedure OrdenarDuplicatasPorDataValor;
    procedure AjustarArredondamentoBaixas;
    function CriarListaModalidades(ADinheiro, ACartao, AChequePre, AChequeAvista, AOrdem, ACredito: Double): TList<TModalidadePagamento>;
    procedure ProcessarBaixaDuplicata(ADuplicata: TDuplicata; AModalidades: TList<TModalidadePagamento>; var ASaldos: array of Double);
    procedure AplicarModalidade(ABaixa: TRegistroBaixa;
                                AModalidade: TModalidadePagamento;
                                AValorAplicar: Double;
                            var ASaldoModalidade: Double;
                                ADuplicata: TDuplicata);
    function RetornaDuplicata(const AAutoincremDuplicata: string; ASequencialLancamentoBancario: string): TDuplicata;
    procedure DesmembrarDuplicatas;
    procedure AtualizarDuplicataBaixaPrincipal(ABaixa: TRegistroBaixa);
    procedure InserirDuplicataBaixaParcial(ABaixa: TRegistroBaixa);

    procedure AtualizarCreditoGerado(ACreditoGerado: String; AValorCredito: Double);
    procedure InserirCreditoGerado(ACreditoGerado: String; AValorCredito: Double);

    function RetornaDadosDuplicataReplicacao(ADuplicata: String): TUniQuery;
    function RetornaPortadorDaBaixa(ABaixa: TRegistroBaixa; ADefault: String): Variant;
    procedure DesmembrarCreditoGerado(ACreditoDinheiro,
                                      ACreditoCartao,
                                      ACreditoChequePre,
                                      ACreditoChequeAvista,
                                      ACreditoOrdem: Double);
    function RetornaAutoincremCreditoGerado: String;

    // Métodos para BANCTR
    procedure DesmembrarBanCtr;
    procedure AtualizarBanctrBaixaPrincipal(ABaixa: TRegistroBaixa);
    procedure InserirBanctrBaixaParcial(ABaixa: TRegistroBaixa);

  public
    constructor Create;
    destructor Destroy; override;
    procedure AdicionarDuplicata(const AAutoincremDuplicata: string; ASequencialLancamentoBancario: string = '');
    procedure ProcessarDesmembramentos(ADinheiro,
                                       ACartao,
                                       AChequePre,
                                       AChequeAvista,
                                       AOrdem: Double;
                                       APortadorTF: String = '';
                                       AValorTotalCreditoGerado: Double = 0);
    function ObterRegistrosBaixa: TList<TRegistroBaixa>;
    procedure ApagarDesmembramentoAnterior(ASequencialControleBaixa: Integer; AEmpresaBaixa: string; ADataRecebimento: TDate);
    property Duplicatas: TList<TDuplicata> read FDuplicatas;
    property Baixas: TList<TRegistroBaixa> read FBaixas;
  end;

implementation

{ TDuplicata }

constructor TDuplicata.Create(const AAutoincremDuplicata: string;
                                    AValorRecebido,
                                    AJuros,
                                    ADesconto,
                                    ADespesaCobranca: Double;
                                    ADataVencimento: TDate;
                                    ASequencialBaixaInicial: Integer;
                                    ASequencialControleBaixa: Integer;
                                    AEmpresaBaixa: String;
                                    ADataBaixa: TDate;
                                    ADataRecebimento: TDate;
                                    AVFrete: Double;
                                    ANumeroDuplicata,
                                    AParcela,
                                    AEspecie,
                                    ACodigoEmpresa,
                                    ACodigoCliente,
                                    APortadorBaixa: String;
                                    ASequencialLancamentoBancario: String);
begin
  FAutoincremDuplicata := AAutoincremDuplicata;
  FNumeroDuplicata := ANumeroDuplicata;
  FParcela := AParcela;
  FEspecie := AEspecie;
  FCodigoEmpresa := ACodigoEmpresa;
  FCodigoCliente :=  ACodigoCliente;
  FValorRecebido := RoundTo(AValorRecebido, -2);
  FJuros := RoundTo(AJuros, -2);
  FDesconto := RoundTo(ADesconto, -2);
  FDespesaCobranca := RoundTo(ADespesaCobranca, -2);
  FVFrete := RoundTo(AVFrete, -2);
  FDataVencimento := ADataVencimento;
  FSequencialBaixaInicial := ASequencialBaixaInicial;
  FSequencialControleBaixa := ASequencialControleBaixa;
  FEmpresaBaixa := AEmpresaBaixa;
  FDataBaixa := ADataBaixa;
  FDataRecebimento := ADataRecebimento;
  FPortadorBaixa := APortadorBaixa;
  FSequencialLancamentoBancario := ASequencialLancamentoBancario;
end;

{ TRegistroBaixa }

constructor TRegistroBaixa.Create;
begin
  FSequencialBaixa := 0;
  FAutoincremDuplicata := '';
  FValorRecebido := 0;
  FCreditoCartao := 0;
  FCreditoChequePre := 0;
  FCreditoDinheiro := 0;
  FCreditoChequeAvista := 0;
  FCreditoOrdem := 0;
  FJuros := 0;
  FVFrete := 0;
  FDesconto := 0;
  FDespesaCobranca := 0;
  FPortadorBaixa := '';
  FSequencialLancamentoBancario := '';
end;

{ TDesmembraBaixaReceber }

constructor TDesmembraBaixaReceber.Create;
begin
  FDuplicatas := TList<TDuplicata>.Create;
  FBaixas := TList<TRegistroBaixa>.Create;
end;

destructor TDesmembraBaixaReceber.Destroy;
var
  LDuplicata: TDuplicata;
  LBaixa: TRegistroBaixa;
begin
  // Libera memória das duplicatas
  for LDuplicata in FDuplicatas do
    LDuplicata.Free;
  FDuplicatas.Free;
  // Libera memória das baixas
  for LBaixa in FBaixas do
    LBaixa.Free;
  FBaixas.Free;
  inherited;
end;

procedure TDesmembraBaixaReceber.GeraListaDeCamposBANCTR;
Var
  LConsulta: TUniQuery;
  LCampo: TField;
Begin
  If Not FCamposNovoBanctr.IsEmpty Then
    Exit;

  Try
    LConsulta := fCriaQuery();
    LConsulta.Close;
    LConsulta.SQL.Clear;
    LConsulta.SQL.Add('SELECT * FROM BANCTR WHERE FALSE');
    LConsulta.Open;

    FCamposNovoBanctr := '';
    FParametrosNovoBanctr := '';

    For LCampo In LConsulta.Fields Do
    Begin
      FCamposNovoBanctr := FCamposNovoBanctr + LCampo.FieldName + ',';
      FParametrosNovoBanctr := FParametrosNovoBanctr + ':' + LCampo.FieldName + ',';
    End;

    FCamposNovoBanctr := LeftStr(FCamposNovoBanctr, FCamposNovoBanctr.Length - 1);
    FParametrosNovoBanctr := LeftStr(FParametrosNovoBanctr, FParametrosNovoBanctr.Length - 1);

  Finally
    FreeAndNil(LConsulta);
  End;
End;


procedure TDesmembraBaixaReceber.GeraListaDeCamposCADREC;
  Var
    LConsulta: TUniQuery;

    LCampo: TField;
Begin
  If Not FCamposNovoCadRec.IsEmpty Then
    Exit;

  Try
    LConsulta := fCriaQuery();
    LConsulta.Close;
    LConsulta.SQL.Clear;
    LConsulta.SQL.Add('SELECT * FROM CADREC WHERE FALSE');
    LConsulta.Open;

    FCamposNovoCadrec := '';
    FParametrosNovoCadrec := '';
    FCamposCadRec := '';

    For LCampo In LConsulta.Fields Do
    Begin
      FCamposNovoCadrec := FCamposNovoCadrec + LCampo.FieldName + ',';
      FParametrosNovoCadrec := FParametrosNovoCadrec + ':' + LCampo.FieldName + ',';

      FCamposCadRec := FCamposCadRec + LCampo.FieldName + ',';
    End;

    FCamposNovoCadrec := LeftStr(FCamposNovoCadrec, FCamposNovoCadrec.Length - 1);
    FParametrosNovoCadrec := LeftStr(FParametrosNovoCadrec, FParametrosNovoCadrec.Length - 1);

    FCamposCadRec := LeftStr(FCamposCadRec, FCamposCadRec.Length - 1);
  Finally
    FreeAndNil(LConsulta);
  End;
End;

procedure TDesmembraBaixaReceber.InserirCreditoGerado(ACreditoGerado: String; AValorCredito: Double);
  Var
    LInsert: TUniQuery;
    LReplicacao: TUniQuery;
    LCampo: TField;
begin
  LInsert := fCriaQuery(Nil);

  Try
    LReplicacao := RetornaDadosDuplicataReplicacao(ACreditoGerado);

    LInsert.Close;
    LInsert.SQL.Clear;
    LInsert.SQL.Text := 'INSERT INTO CADREC (' + FCamposNovoCadRec + ') ' +
                                   ' VALUES (' + FParametrosNovoCadrec + ') ';

    For LCampo In LReplicacao.Fields Do
      LInsert.ParamByName(LCampo.FieldName).Value := LCampo.Value;

    LInsert.ParamByName('CTR_VALDUP').AsFloat    := AValorCredito;
    LInsert.ParamByName('CTR_VALORI').AsFloat    := AValorCredito;
    LInsert.ParamByName('CTR_GRVORI').AsFloat    := AValorCredito;

    LInsert.ParamByName('CTR_NUMDUP').AsString   := fRetSequencial('PROCCO', VS_strCodEmp, fTamDocCadRec);
    LInsert.ParamByName('AUTOINCREM').AsString   := fRetAutoIncrem('CADREC', VS_strCodEmp);

    LInsert.ExecSQL;

    untLogCtr.GravaLogCtr(LInsert.ParamByName('AUTOINCREM').AsString,
                         'INCLUSÃO - BAIXA DESMEMBRADA',
                         'untTDesmembramentoBaixaReceber',
                         '',
                         FBaixas.Last.SequencialControleBaixa);

  Finally
    FreeAndNil(LInsert);
    FreeAndNil(LReplicacao);
  End;

end;

procedure TDesmembraBaixaReceber.InserirDuplicataBaixaParcial(ABaixa: TRegistroBaixa);
  Var
    LInsert: TUniQuery;
    LReplicacao: TUniQuery;
    LCampo: TField;
begin
  LInsert := fCriaQuery(Nil);
  LReplicacao := fCriaQuery(Nil);

  Try
    LReplicacao := RetornaDadosDuplicataReplicacao(ABaixa.AutoincremDuplicata);

    LInsert.Close;
    LInsert.SQL.Clear;
    LInsert.SQL.Text := 'INSERT INTO CADREC (' + FCamposNovoCadRec + ') ' +
                                   ' VALUES (' + FParametrosNovoCadrec + ') ';

    For LCampo In LReplicacao.Fields Do
      LInsert.ParamByName(LCampo.FieldName).Value := LCampo.Value;

    LInsert.ParamByName('CTR_DINHEI').AsFloat    := 0;
    LInsert.ParamByName('CTR_CARTAO').AsFloat    := 0;
    LInsert.ParamByName('CTR_CHQAVI').AsFloat    := 0;
    LInsert.ParamByName('CTR_CHQPRE').AsFloat    := 0;
    LInsert.ParamByName('CTR_CREDIT').AsFloat    := 0;
    LInsert.ParamByName('CTR_ORDPAG').AsFloat    := 0;
    LInsert.ParamByName('CTR_VLCRED').AsFloat    := 0;

    LInsert.ParamByName(ABaixa.CampoModalidade).AsFloat := ABaixa.ValorRecebido;

    LInsert.ParamByName('CTR_PORBAI').Value      := RetornaPortadorDaBaixa(ABaixa, ABaixa.PortadorBaixa);
    LInsert.ParamByName('CTR_VALORI').AsFloat    := ABaixa.ValorOriginal;
    LInsert.ParamByName('CTR_VALREC').AsFloat    := ABaixa.ValorRecebido;
    LInsert.ParamByName('CTR_VALDUP').AsFloat    := 0;
    LInsert.ParamByName('CTR_VALJUR').AsFloat    := ABaixa.Juros;
    LInsert.ParamByName('CTR_VALFRE').AsFloat    := ABaixa.ValorFrete;
    LInsert.ParamByName('CTR_VALDES').AsFloat    := ABaixa.Desconto;
    LInsert.ParamByName('CTR_VALCOB').AsFloat    := ABaixa.DespesaCobranca;
    LInsert.ParamByName('CTR_SEQBAI').AsInteger  := ABaixa.SequencialBaixa;

    LInsert.ParamByName('CTR_CREDIN').AsFloat := ABaixa.CreditoDinheiro;
    LInsert.ParamByName('CTR_CRECAR').AsFloat := ABaixa.CreditoCartao;
    LInsert.ParamByName('CTR_CRECHP').AsFloat := ABaixa.CreditoChequePre;
    LInsert.ParamByName('CTR_CRECHV').AsFloat := ABaixa.CreditoChequeAvista;
    LInsert.ParamByName('CTR_CREORD').AsFloat := ABaixa.CreditoOrdem;

    LInsert.ParamByName('AUTOINCREM').AsString   := fRetAutoIncrem('CADREC', VS_strCodEmp);
    LInsert.ExecSQL;

    untLogCtr.GravaLogCtr(LInsert.ParamByName('AUTOINCREM').AsString,
                         'INCLUSÃO - BAIXA DESMEMBRADA',
                         'untTDesmembramentoBaixaReceber');

  Finally
    FreeAndNil(LInsert);
    FreeAndNil(LReplicacao);
  End;

end;

procedure TDesmembraBaixaReceber.AdicionarDuplicata(const AAutoincremDuplicata: string; ASequencialLancamentoBancario: string = '');
begin
  FDuplicatas.Add(RetornaDuplicata(AAutoincremDuplicata,ASequencialLancamentoBancario));
end;

function TDesmembraBaixaReceber.RetornaAutoincremCreditoGerado: String;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery(Nil);
  Try
    LConsulta.Close;
    LConsulta.SQL.Clear;
    LConsulta.SQL.Text := 'SELECT                                     '+
                          '  C.AUTOINCREM                             '+
                          'FROM                                       '+
                          '  LOGCTR L                                 '+
                          '  JOIN CADREC C                            '+
                          '    ON C.CTR_NUMDUP = L.CTR_NUMDUP         '+
                          '    AND C.CTR_PARCEL = L.CTR_PARCEL        '+
                          '    AND C.CTR_ESPDOC = L.CTR_ESPDOC        '+
                          '    AND C.CTR_CODEMP = L.CTR_CODEMP        '+
                          '    AND C.CTR_CODCLI = L.CTR_CODCLI        '+
                          'WHERE L.CTR_SEQCON = :SEQCON               '+
                          '  AND L.CTR_VALORI < 0                     '+
                          '  AND L.CTR_DTACAD IN (:DTABAI, :DTAREC)   '+
                          '  AND L.CTR_CODEMP = :EMPBAI               '+
                          '  AND L.CTR_DTAREC IS NULL                 ';

    LConsulta.ParamByName('SEQCON').AsInteger := FBaixas.Last.SequencialControleBaixa;
    LConsulta.ParamByName('DTABAI').AsDateTime := FBaixas.Last.DataBaixa;
    LConsulta.ParamByName('DTAREC').AsDateTime := FBaixas.Last.DataRecebimento;
    LConsulta.ParamByName('EMPBAI').AsString := FBaixas.Last.EmpresaBaixa;
    LConsulta.Open;

    Result := LConsulta.FieldByName('AUTOINCREM').AsString;

  Finally
    FreeAndNil(LConsulta);
  End;

end;

function TDesmembraBaixaReceber.RetornaDadosDuplicataReplicacao(
  ADuplicata: String): TUniQuery;
begin
  Result := fCriaQuery(Nil);
  Result.Close;
  Result.SQL.Clear;
  Result.SQL.Text := 'SELECT * FROM CADREC WHERE AUTOINCREM = :AUTOINCREM';
  Result.ParamByName('AUTOINCREM').AsString := ADuplicata;
  Result.Open;
end;

function TDesmembraBaixaReceber.RetornaDuplicata(const AAutoincremDuplicata: string; ASequencialLancamentoBancario : String): TDuplicata;
  Var
    LConsulta: TUniQuery;
begin
  Result := Nil;

  LConsulta := fCriaQuery(Nil);
  LConsulta.SQL.Clear;
  LConsulta.SQL.Text := 'SELECT                                      '+
                        '  A.AUTOINCREM,                             '+
                        '  A.CTR_NUMDUP,                             '+
                        '  A.CTR_PARCEL,                             '+
                        '  A.CTR_ESPDOC,                             '+
                        '  A.CTR_CODCLI,                             '+
                        '  A.CTR_CODEMP,                             '+
                        '  A.CTR_VALREC,                             '+
                        '  A.CTR_DTAVEN,                             '+
                        '  A.CTR_VALJUR,                             '+
                        '  A.CTR_VALDES,                             '+
                        '  A.CTR_VALCOB,                             '+
                        '  A.CTR_SEQBAI,                             '+
                        '  A.CTR_SEQCON,                             '+
                        '  A.CTR_EMPBAI,                             '+
                        '  A.CTR_DTABAI,                             '+
                        '  A.CTR_DTAREC,                             '+
                        '  A.CTR_VALFRE,                             '+
                        '  A.CTR_PORBAI                              '+
                        'FROM                                        '+
                        '  CADREC A                                  '+
                        'WHERE A.AUTOINCREM = :AUTOINCREM            ';

  LConsulta.ParamByName('AUTOINCREM').AsString := AAutoincremDuplicata;
  LConsulta.Open;
  LConsulta.First;

  try
    if not LConsulta.IsEmpty then
    begin
      Result := TDuplicata.Create(LConsulta.FieldByName('AUTOINCREM').AsString,
                                  LConsulta.FieldByName('CTR_VALREC').AsFloat,
                                  LConsulta.FieldByName('CTR_VALJUR').AsFloat,
                                  LConsulta.FieldByName('CTR_VALDES').AsFloat,
                                  LConsulta.FieldByName('CTR_VALCOB').AsFloat,
                                  LConsulta.FieldByName('CTR_DTAVEN').AsDateTime,
                                  LConsulta.FieldByName('CTR_SEQBAI').AsInteger,
                                  LConsulta.FieldByName('CTR_SEQCON').AsInteger,
                                  LConsulta.FieldByName('CTR_EMPBAI').AsString,
                                  LConsulta.FieldByName('CTR_DTABAI').AsDateTime,
                                  LConsulta.FieldByName('CTR_DTAREC').AsDateTime,
                                  LConsulta.FieldByName('CTR_VALFRE').AsFloat,
                                  LConsulta.FieldByName('CTR_NUMDUP').AsString,
                                  LConsulta.FieldByName('CTR_PARCEL').AsString,
                                  LConsulta.FieldByName('CTR_ESPDOC').AsString,
                                  LConsulta.FieldByName('CTR_CODEMP').AsString,
                                  LConsulta.FieldByName('CTR_CODCLI').AsString,
                                  LConsulta.FieldByName('CTR_PORBAI').AsString,
                                  ASequencialLancamentoBancario);
    end
    else
      raise Exception.CreateFmt('Duplicata %s não encontrada na CADREC', [AAutoincremDuplicata]);
  finally
    LConsulta.Close;
    FreeAndNil(LConsulta);
  end;
end;

function TDesmembraBaixaReceber.RetornaPortadorDaBaixa(ABaixa: TRegistroBaixa; ADefault: String): Variant;
begin
  Result := ADefault;

  If ABaixa.CampoModalidade = ModalidadeCampos[mpOrdem] then
  begin
    if Not fEmptyStr(FPortadorTF) Then
      Result := FPortadorTF;
  end;

  if fEmptyStr(Result) Then
    Result := Null;
end;


function TDesmembraBaixaReceber.ObterValorTotalCreditos: Double;
var
  LDuplicata: TDuplicata;
begin
  // Calcula o valor total das duplicatas com valores negativos (créditos)
  Result := 0;
  for LDuplicata in FDuplicatas do
    if LDuplicata.ValorRecebido < 0 then
      Result := Result + LDuplicata.ValorRecebido;
  Result := RoundTo(Result, -2);
end;

function TDesmembraBaixaReceber.ObterDuplicatasPositivas: TList<TDuplicata>;
var
  LDuplicata: TDuplicata;
begin
  // Cria uma lista contendo apenas duplicatas com valores positivos
  Result := TList<TDuplicata>.Create;
  for LDuplicata in FDuplicatas do
    if LDuplicata.ValorRecebido > 0 then
      Result.Add(LDuplicata);
end;

function TDesmembraBaixaReceber.ObterDuplicatasCredito: TList<TDuplicata>;
var
  LDuplicata: TDuplicata;
begin
  // Cria uma lista contendo apenas duplicatas com valores negativos (créditos)
  Result := TList<TDuplicata>.Create;
  for LDuplicata in FDuplicatas do
    if LDuplicata.ValorRecebido < 0 then
      Result.Add(LDuplicata);
end;

procedure TDesmembraBaixaReceber.OrdenarDuplicatasPorDataValor;
begin
  // Ordena as duplicatas por data de vencimento e, em caso de empate, por valor
  FDuplicatas.Sort(TComparer<TDuplicata>.Construct(
    function(const LEsquerda, LDireita: TDuplicata): Integer
    begin
      if LEsquerda.DataVencimento < LDireita.DataVencimento then
        Result := -1
      else if LEsquerda.DataVencimento > LDireita.DataVencimento then
        Result := 1
      else if LEsquerda.ValorRecebido < LDireita.ValorRecebido then
        Result := -1
      else if LEsquerda.ValorRecebido > LDireita.ValorRecebido then
        Result := 1
      else
        Result := 0;
    end));
end;

function TDesmembraBaixaReceber.CriarListaModalidades(ADinheiro, ACartao, AChequePre, AChequeAvista, AOrdem, ACredito: Double): TList<TModalidadePagamento>;
var
  LModalidadesValores: TList<TModalidadePagamento>;
  LValores: TDictionary<TModalidadePagamento, Double>;
  LModalidade: TModalidadePagamento;
begin
  // Cria uma lista ordenada de modalidades de pagamento com valores maiores que zero
  LModalidadesValores := TList<TModalidadePagamento>.Create;
  LValores := TDictionary<TModalidadePagamento, Double>.Create;
  try
    // Mapeia modalidades aos seus valores, arredondando para duas casas decimais
    LValores.AddOrSetValue(mpDinheiro, RoundTo(ADinheiro, -2));
    LValores.AddOrSetValue(mpCartao, RoundTo(ACartao, -2));
    LValores.AddOrSetValue(mpChequePre, RoundTo(AChequePre, -2));
    LValores.AddOrSetValue(mpChequeAvista, RoundTo(AChequeAvista, -2));
    LValores.AddOrSetValue(mpOrdem, RoundTo(AOrdem, -2));
    LValores.AddOrSetValue(mpCreditoUtilizado, RoundTo(ACredito, -2));

    // Adiciona modalidades com valores maiores que zero à lista
    for LModalidade in LValores.Keys do
      if LValores[LModalidade] > 0 then
        LModalidadesValores.Add(LModalidade);

    // Ordena por valor decrescente, com mpCreditoUtilizado no topo
    LModalidadesValores.Sort(TComparer<TModalidadePagamento>.Construct(
      function(const LEsquerda, LDireita: TModalidadePagamento): Integer
      begin
        if LEsquerda = LDireita then
          Exit(0);
        if LEsquerda = mpCreditoUtilizado then
          Exit(-1);
        if LDireita = mpCreditoUtilizado then
          Exit(1);
        Result := CompareValue(LValores[LDireita], LValores[LEsquerda]);
      end));

    Result := LModalidadesValores;
  except
    LModalidadesValores.Free;
    LValores.Free;
    raise;
  end;
  LValores.Free;
end;

procedure TDesmembraBaixaReceber.AplicarModalidade(ABaixa: TRegistroBaixa;
                                                   AModalidade: TModalidadePagamento;
                                                   AValorAplicar: Double;
                                               var ASaldoModalidade: Double;
                                                   ADuplicata: TDuplicata);
var
  LProporcao: Double;
begin
  // Calcula a proporção do valor aplicado em relação ao valor da duplicata
  LProporcao := 0;
  if Abs(ADuplicata.ValorRecebido) > 0.01 then
    LProporcao := AValorAplicar / ADuplicata.ValorRecebido;

  ABaixa.ValorRecebido := AValorAplicar;
  ABaixa.CampoModalidade := ModalidadeCampos[AModalidade];

  // Aplica juros e desconto proporcionalmente
  ABaixa.Juros := RoundTo(ADuplicata.Juros * LProporcao, -2);
  ABaixa.Desconto := RoundTo(ADuplicata.Desconto * LProporcao, -2);
  ABaixa.DespesaCobranca := RoundTo(ADuplicata.DespesaCobranca * LProporcao, -2);
  ABaixa.ValorOriginal := RoundTo(ABaixa.ValorRecebido - ABaixa.Juros - ABaixa.DespesaCobranca + ABaixa.Desconto,-2);
  ABaixa.ValorFrete := RoundTo(ADuplicata.ValorFrete * LProporcao, -2);

  ABaixa.SequencialControleBaixa := ADuplicata.SequencialControleBaixa;
  ABaixa.EmpresaBaixa := ADuplicata.EmpresaBaixa;
  ABaixa.DataRecebimento := ADuplicata.DataRecebimento;
  ABaixa.DataBaixa := ADuplicata.DataBaixa;
  ABaixa.PortadorBaixa := ADuplicata.PortadorBaixa;
  ABaixa.SequencialLancamentoBancario := ADuplicata.SequencialLancamentoBancario;

  // Atualiza o saldo da modalidade subtraindo o valor aplicado
  ASaldoModalidade := RoundTo(ASaldoModalidade - AValorAplicar, -2);
end;

procedure TDesmembraBaixaReceber.AtualizarCreditoGerado(ACreditoGerado: String; AValorCredito: Double);
  Var
    LUpdate: TUniQuery;
begin
  LUpdate := fCriaQuery(Nil);
  Try
    Try
      LUpdate.Close;
      LUpdate.SQL.Clear;
      LUpdate.SQL.Text := 'SELECT * FROM CADREC WHERE AUTOINCREM = :AUTOINCREM';
      LUpdate.ParamByName('AUTOINCREM').AsString := ACreditoGerado;
      LUpdate.Open;

      LUpdate.Edit;
      LUpdate.FieldByName('CTR_VALDUP').AsFloat    := AValorCredito;
      LUpdate.FieldByName('CTR_VALORI').AsFloat    := AValorCredito;
      LUpdate.FieldByName('CTR_GRVORI').AsFloat    := AValorCredito;
      LUpdate.Post;

      untLogCtr.GravaLogCtr(ACreditoGerado,
                           'ALTERAÇÃO - BAIXA DESMEMBRADA',
                           'untTDesmembramentoBaixaReceber');

    Except
    On E: Exception Do
      Begin
        Raise;
      End;
    End;
  Finally
    FreeAndNil(LUpdate);
  End;
end;

procedure TDesmembraBaixaReceber.AtualizarDuplicataBaixaPrincipal(ABaixa: TRegistroBaixa);
  Var
    LUpdate: TUniQuery;
begin
  LUpdate := fCriaQuery(Nil);
  Try
    Try
      LUpdate.Close;
      LUpdate.SQL.Clear;
      LUpdate.SQL.Text := 'SELECT * FROM CADREC WHERE AUTOINCREM = :AUTOINCREM';
      LUpdate.ParamByName('AUTOINCREM').AsString := ABaixa.AutoincremDuplicata;
      LUpdate.Open;

      LUpdate.Edit;
      LUpdate.FieldByName('CTR_DINHEI').AsFloat    := 0;
      LUpdate.FieldByName('CTR_CARTAO').AsFloat    := 0;
      LUpdate.FieldByName('CTR_CHQAVI').AsFloat    := 0;
      LUpdate.FieldByName('CTR_CHQPRE').AsFloat    := 0;
      LUpdate.FieldByName('CTR_CREDIT').AsFloat    := 0;
      LUpdate.FieldByName('CTR_ORDPAG').AsFloat    := 0;
      LUpdate.FieldByName('CTR_VLCRED').AsFloat    := 0;

      LUpdate.FieldByName(ABaixa.CampoModalidade).AsFloat := ABaixa.ValorRecebido;
      LUpdate.FieldByName('CTR_PORBAI').Value   := RetornaPortadorDaBaixa(ABaixa, ABaixa.PortadorBaixa);
      //LUpdate.FieldByName('CTR_VALANT').AsFloat    := ABaixa.ValorOriginal;
      LUpdate.FieldByName('CTR_VALORI').AsFloat    := ABaixa.ValorOriginal;
      LUpdate.FieldByName('CTR_VALREC').AsFloat    := ABaixa.ValorRecebido;
      LUpdate.FieldByName('CTR_VALDUP').AsFloat    := 0;
      LUpdate.FieldByName('CTR_VALJUR').AsFloat    := ABaixa.Juros;
      LUpdate.FieldByName('CTR_VALDES').AsFloat    := ABaixa.Desconto;
      LUpdate.FieldByName('CTR_VALCOB').AsFloat    := ABaixa.DespesaCobranca;
      LUpdate.FieldByName('CTR_VALFRE').AsFloat    := ABaixa.ValorFrete;

      LUpdate.FieldByName('CTR_CREDIN').AsFloat := ABaixa.CreditoDinheiro;
      LUpdate.FieldByName('CTR_CRECAR').AsFloat := ABaixa.CreditoCartao;
      LUpdate.FieldByName('CTR_CRECHP').AsFloat := ABaixa.CreditoChequePre;
      LUpdate.FieldByName('CTR_CRECHV').AsFloat := ABaixa.CreditoChequeAvista;
      LUpdate.FieldByName('CTR_CREORD').AsFloat := ABaixa.CreditoOrdem;

      LUpdate.Post;

      untLogCtr.GravaLogCtr(ABaixa.AutoincremDuplicata,
                           'ALTERAÇÃO - BAIXA DESMEMBRADA',
                           'untTDesmembramentoBaixaReceber');

    Except
    On E: Exception Do
      Begin
        Raise;
      End;
    End;
  Finally
    FreeAndNil(LUpdate);
  End;
end;

procedure TDesmembraBaixaReceber.ProcessarBaixaDuplicata(ADuplicata: TDuplicata; AModalidades: TList<TModalidadePagamento>;
  var ASaldos: array of Double);
var
  LBaixa: TRegistroBaixa;
  LModalidade: TModalidadePagamento;
  LValorAplicar: Double;
  LValorDuplicataRestante: Double;
  LBaixasDuplicata: TList<TRegistroBaixa>;
  LModalidadeToSaldo: TDictionary<TModalidadePagamento, Integer>;
  LSequencialBaixa: Integer;
  LMaiorSequencialBaixa: Integer;
begin
  // Processa a baixa de uma duplicata, aplicando as modalidades de pagamento disponíveis
  if ADuplicata.ValorRecebido <= 0 then
    Exit;

  LSequencialBaixa := ADuplicata.SequencialBaixaInicial;
  LBaixasDuplicata := TList<TRegistroBaixa>.Create;
  LModalidadeToSaldo := TDictionary<TModalidadePagamento, Integer>.Create;

  LMaiorSequencialBaixa := fRetSeqBaiCadRec(ADuplicata.NumeroDuplicata,
                                            ADuplicata.Parcela,
                                            ADuplicata.CodigoEmpresa,
                                            ADuplicata.Especie,
                                            ADuplicata.CodigoCliente);

  try
    // Mapeia modalidades aos índices dos saldos
    LModalidadeToSaldo.Add(mpDinheiro, 0);
    LModalidadeToSaldo.Add(mpCartao, 1);
    LModalidadeToSaldo.Add(mpChequePre, 2);
    LModalidadeToSaldo.Add(mpChequeAvista, 3);
    LModalidadeToSaldo.Add(mpOrdem, 4);
    LModalidadeToSaldo.Add(mpCreditoUtilizado, 5);

    LValorDuplicataRestante := RoundTo(ADuplicata.ValorRecebido, -2);

    // Aplica cada modalidade de pagamento até cobrir o valor da duplicata
    for LModalidade in AModalidades do
    begin
      if not LModalidadeToSaldo.ContainsKey(LModalidade) then
        Continue;

      LValorAplicar := Min(ASaldos[LModalidadeToSaldo[LModalidade]], LValorDuplicataRestante);

      if LValorAplicar > 0 then
      begin
        LBaixa := TRegistroBaixa.Create;
        LBaixa.SequencialBaixa := LSequencialBaixa;
        LBaixa.AutoincremDuplicata := ADuplicata.AutoincremDuplicata;

        AplicarModalidade(LBaixa,
                          LModalidade,
                          RoundTo(LValorAplicar, -2),
                          ASaldos[LModalidadeToSaldo[LModalidade]],
                          ADuplicata);

        LBaixasDuplicata.Add(LBaixa);

        LValorDuplicataRestante := RoundTo(LValorDuplicataRestante - LValorAplicar, -2);

        If LSequencialBaixa < LMaiorSequencialBaixa Then
          LSequencialBaixa := LMaiorSequencialBaixa;

        Inc(LSequencialBaixa);

        if LValorDuplicataRestante <= 0 then
          Break;
      end;
    end;

    // Adiciona as baixas criadas à lista principal
    for LBaixa in LBaixasDuplicata do
      FBaixas.Add(LBaixa);

  finally
    LBaixasDuplicata.Free;
    LModalidadeToSaldo.Free;
  end;
end;

procedure TDesmembraBaixaReceber.AjustarArredondamentoBaixas;
var
  LDuplicata: TDuplicata;
  LBaixa: TRegistroBaixa;
  LBaixasDuplicata: TList<TRegistroBaixa>;
  LUltimaBaixa: TRegistroBaixa;
  LSomaValorRecebido: Double;
  LSomaJuros: Double;
  LSomaDesconto: Double;
  LSomaDespesaCobranca: Double;
  LSomaValorOriginal: Double;
  LSomaFreteOriginal: Double;
  LDiferencaValorRecebido: Double;
  LDiferencaJuros: Double;
  LDiferencaDesconto: Double;
  LDiferencaDespesaCobranca: Double;
  LDiferencaValorOriginal: Double;
  LDiferencaValorFrete: Double;
begin
  // Processa cada duplicata
  for LDuplicata in FDuplicatas do
  begin
    LBaixasDuplicata := TList<TRegistroBaixa>.Create;
    try
      // Agrupa baixas correspondentes à duplicata
      for LBaixa in FBaixas do
        if LBaixa.AutoincremDuplicata = LDuplicata.AutoincremDuplicata then
          LBaixasDuplicata.Add(LBaixa);

      if LBaixasDuplicata.Count = 0 then
        Continue;

      LSomaValorRecebido := 0;
      LSomaJuros := 0;
      LSomaDesconto := 0;
      LSomaDespesaCobranca := 0;
      LSomaValorOriginal := 0;
      LSomaFreteOriginal := 0;

      For LBaixa in LBaixasDuplicata do
      begin
        LSomaValorRecebido := RoundTo(LSomaValorRecebido + LBaixa.ValorRecebido, -2);
        LSomaJuros := RoundTo(LSomaJuros + LBaixa.Juros, -2);
        LSomaDesconto := RoundTo(LSomaDesconto + LBaixa.Desconto, -2);
        LSomaDespesaCobranca := RoundTo(LSomaDespesaCobranca + LBaixa.DespesaCobranca, -2);
        LSomaValorOriginal := RoundTo(LSomaValorOriginal + LBaixa.ValorOriginal, -2);
        LSomaFreteOriginal := RoundTo(LSomaFreteOriginal + LBaixa.ValorFrete, -2);
      End;

      LUltimaBaixa := LBaixasDuplicata.Last;

      // Calcula diferenças entre duplicata e somas das baixas
      LDiferencaValorRecebido := RoundTo(LDuplicata.ValorRecebido - LSomaValorRecebido, -2);
      LDiferencaJuros := RoundTo(LDuplicata.Juros - LSomaJuros, -2);
      LDiferencaDesconto := RoundTo(LDuplicata.Desconto - LSomaDesconto, -2);
      LDiferencaDespesaCobranca := RoundTo(LDuplicata.DespesaCobranca - LSomaDespesaCobranca, -2);
      LDiferencaValorOriginal := RoundTo((LDuplicata.ValorRecebido - LDuplicata.DespesaCobranca - LDuplicata.Juros + LDuplicata.Desconto) - LSomaValorOriginal, -2);
      LDiferencaValorFrete :=  RoundTo(LDuplicata.ValorFrete - LSomaFreteOriginal, -2);

      // Se houver alguma diferença por conta dos arredondamentos joga pro ultimo sequencial de baixa
      LUltimaBaixa.ValorRecebido := RoundTo(LUltimaBaixa.ValorRecebido + LDiferencaValorRecebido, -2);
      LUltimaBaixa.Juros := RoundTo(LUltimaBaixa.Juros + LDiferencaJuros, -2);
      LUltimaBaixa.Desconto := RoundTo(LUltimaBaixa.Desconto + LDiferencaDesconto, -2);
      LUltimaBaixa.DespesaCobranca := RoundTo(LUltimaBaixa.DespesaCobranca + LDiferencaDespesaCobranca, -2);
      LUltimaBaixa.ValorOriginal := RoundTo(LUltimaBaixa.ValorOriginal + LDiferencaValorOriginal, -2);
      LUltimaBaixa.ValorFrete := RoundTo(LUltimaBaixa.ValorFrete + LDiferencaValorFrete, -2);

    finally
      LBaixasDuplicata.Free;
    end;
  end;
end;

procedure TDesmembraBaixaReceber.ProcessarDesmembramentos(ADinheiro,
                                                          ACartao,
                                                          AChequePre,
                                                          AChequeAvista,
                                                          AOrdem: Double;
                                                          APortadorTF: String = '';
                                                          AValorTotalCreditoGerado: Double = 0);
var
  LModalidades: TList<TModalidadePagamento>;
  LDuplicatasPositivas: TList<TDuplicata>;
  LDuplicatasCredito: TList<TDuplicata>;
  LDuplicata: TDuplicata;
  LSaldos: array[0..5] of Double;
  LCreditoDisponivel: Double;
  LBaixa: TRegistroBaixa;
begin
  FPortadorTF := APortadorTF;
  FValorTotalCreditoGerado := AValorTotalCreditoGerado;

  // Inicializa os saldos das modalidades de pagamento
  LSaldos[0] := RoundTo(ADinheiro, -2);
  LSaldos[1] := RoundTo(ACartao, -2);
  LSaldos[2] := RoundTo(AChequePre, -2);
  LSaldos[3] := RoundTo(AChequeAvista, -2);
  LSaldos[4] := RoundTo(AOrdem, -2);
  LSaldos[5] := RoundTo(Abs(ObterValorTotalCreditos), -2);

  LCreditoDisponivel := LSaldos[5];
  FBaixas.Clear;

  // Cria a lista de modalidades de pagamento disponíveis
  LModalidades := CriarListaModalidades(ADinheiro, ACartao, AChequePre, AChequeAvista, AOrdem, LCreditoDisponivel);

  try
    // Ordena duplicatas por data e valor
    OrdenarDuplicatasPorDataValor;

    // Obtém listas de duplicatas positivas e de crédito
    LDuplicatasPositivas := ObterDuplicatasPositivas;
    LDuplicatasCredito := ObterDuplicatasCredito;

    try
      // Processa a baixa de cada duplicata positiva
      for LDuplicata in LDuplicatasPositivas do
      begin
        ProcessarBaixaDuplicata(LDuplicata, LModalidades, LSaldos);
      end;

      // Atualiza os valores de crédito na última baixa
      If (AValorTotalCreditoGerado > 0) Then
      Begin
        LBaixa := FBaixas.Last;
        LBaixa.CreditoDinheiro := LSaldos[0];
        LBaixa.CreditoCartao := LSaldos[1];
        LBaixa.CreditoChequePre := LSaldos[2];
        LBaixa.CreditoChequeAvista := LSaldos[3];
        LBaixa.CreditoOrdem := LSaldos[4];

        DesmembrarCreditoGerado(LBaixa.CreditoDinheiro,
                               LBaixa.CreditoCartao,
                               LBaixa.CreditoChequePre,
                               LBaixa.CreditoChequeAvista,
                               LBaixa.CreditoOrdem);

      End;

      AjustarArredondamentoBaixas;

      DesmembrarDuplicatas;      // Desmembra a CADREC
      DesmembrarBanctr;          // Desmembra a BANCTR

    finally
      LDuplicatasPositivas.Free;
      LDuplicatasCredito.Free;
    end;
  finally
    LModalidades.Free;
  end;
end;

function TDesmembraBaixaReceber.ObterRegistrosBaixa: TList<TRegistroBaixa>;
begin
  // Retorna a lista de registros de baixa
  Result := FBaixas;
end;


procedure TDesmembraBaixaReceber.DesmembrarCreditoGerado(ACreditoDinheiro,
  ACreditoCartao, ACreditoChequePre, ACreditoChequeAvista,
  ACreditoOrdem: Double);
  Var
    LModalidades: TList<TModalidadePagamento>;
    LModalidade: TModalidadePagamento;
    LCreditoGerado: String;
    LAlterar: Boolean;
    LValorCreditoAplicar: Double;
begin
  LModalidades := CriarListaModalidades(ACreditoDinheiro, ACreditoCartao, ACreditoChequePre, ACreditoChequeAvista, ACreditoOrdem, 0);
  LAlterar := True;
  LValorCreditoAplicar := 0;

  Try
    If LModalidades.Count = 1 Then
      Exit;

    GeraListaDeCamposCADREC;

    LCreditoGerado := RetornaAutoincremCreditoGerado;

    For LModalidade in LModalidades do
    begin

      case LModalidade of
        mpDinheiro: LValorCreditoAplicar := FBaixas.Last.CreditoDinheiro;
        mpCartao: LValorCreditoAplicar := FBaixas.Last.CreditoCartao;
        mpChequePre: LValorCreditoAplicar := FBaixas.Last.CreditoChequePre;
        mpChequeAvista: LValorCreditoAplicar := FBaixas.Last.CreditoChequeAvista;
        mpOrdem: LValorCreditoAplicar := FBaixas.Last.CreditoOrdem ;
      end;

      If LAlterar Then
      Begin
        AtualizarCreditoGerado(LCreditoGerado,-LValorCreditoAplicar);
        LAlterar := False;
        Continue;
      End;

      InserirCreditoGerado(LCreditoGerado, -LValorCreditoAplicar);
    end;

  Finally
    LModalidades.Free;
  End;
end;

procedure TDesmembraBaixaReceber.DesmembrarDuplicatas;
var
  LBaixa: TRegistroBaixa;
  LDuplicataBaixas: TDictionary<string, TList<TRegistroBaixa>>;
  LAutoincremDuplicata: string;
  LBaixasGrupo: TList<TRegistroBaixa>;
  LPrimeiraBaixa: TRegistroBaixa;
  LBaixaSubsequente: TRegistroBaixa;
begin
  if FBaixas.Count = 0 then
    Exit;

  GeraListaDeCamposCADREC;

  // Inicializa dicionário para agrupar baixas pelo autoincrem da duplicata
  LDuplicataBaixas := TDictionary<string, TList<TRegistroBaixa>>.Create;
  try
    // Agrupa baixas por duplicata
    for LBaixa in FBaixas do
    begin
      if not LDuplicataBaixas.ContainsKey(LBaixa.AutoincremDuplicata) then
        LDuplicataBaixas.Add(LBaixa.AutoincremDuplicata, TList<TRegistroBaixa>.Create);
      LDuplicataBaixas[LBaixa.AutoincremDuplicata].Add(LBaixa);
    end;

    // Processa cada grupo de baixas
    for LAutoincremDuplicata in LDuplicataBaixas.Keys do
    begin
      LBaixasGrupo := LDuplicataBaixas[LAutoincremDuplicata];

      // Ordena as baixas do grupo por SequencialBaixa
      LBaixasGrupo.Sort(TComparer<TRegistroBaixa>.Construct(
        function(const Esquerda, Direita: TRegistroBaixa): Integer
        begin
          Result := Esquerda.SequencialBaixa - Direita.SequencialBaixa;
        end));

      if LBaixasGrupo.Count > 0 then
      begin
        // Obtém a primeira baixa do grupo (menor SequencialBaixa)
        LPrimeiraBaixa := LBaixasGrupo[0];
        AtualizarDuplicataBaixaPrincipal(LPrimeiraBaixa);

        for LBaixaSubsequente in LBaixasGrupo do
        begin
          if LBaixaSubsequente <> LPrimeiraBaixa then
          begin
            InserirDuplicataBaixaParcial(LBaixaSubsequente);
          end;
        end;
      end;
    end;
  finally
    for LBaixasGrupo in LDuplicataBaixas.Values do
      LBaixasGrupo.Free;
    LDuplicataBaixas.Free;
  end;
end;

procedure TDesmembraBaixaReceber.ApagarDesmembramentoAnterior(ASequencialControleBaixa: Integer; AEmpresaBaixa: string; ADataRecebimento: TDate);
var
  LConsulta: TUniQuery;
  LDelete: TUniQuery;
  LUpdate: TUniQuery;
  LDuplicatas: TDictionary<string, Integer>;
  LChaveDuplicata: string;
  LAutoincrem: string;
begin
  // Inicializa objetos
  LConsulta := fCriaQuery(nil);
  LDelete := fCriaQuery(nil);
  LUpdate := fCriaQuery(nil);
  LDuplicatas := TDictionary<string, Integer>.Create;
  try
    // Busca registros participantes da baixa
    LConsulta.Close;
    LConsulta.SQL.Text := 'SELECT                        '+
                          '  AUTOINCREM,                 '+
                          '  CTR_NUMDUP,                 '+
                          '  CTR_PARCEL,                 '+
                          '  CTR_ESPDOC,                 '+
                          '  CTR_CODCLI,                 '+
                          '  CTR_CODEMP,                 '+
                          '  CTR_SEQBAI,                 '+
                          '  CTR_VALREC,                 '+
                          '  CTR_VALJUR,                 '+
                          '  CTR_VALDES,                 '+
                          '  CTR_VALORI,                 '+
                          '  CTR_VALFRE                  '+
                          'FROM                          '+
                          '  CADREC                      '+
                          'WHERE CTR_SEQCON = :SEQCON    '+
                          '  AND CTR_EMPBAI = :EMPBAI    '+
                          '  AND CTR_DTAREC = :DTAREC    '+
                          'ORDER BY CTR_NUMDUP,          '+
                          '  CTR_PARCEL,                 '+
                          '  CTR_ESPDOC,                 '+
                          '  CTR_CODCLI,                 '+
                          '  CTR_CODEMP,                 '+
                          '  CTR_SEQBAI                  ';

    LConsulta.ParamByName('SEQCON').AsInteger := ASequencialControleBaixa;
    LConsulta.ParamByName('EMPBAI').AsString := AEmpresaBaixa;
    LConsulta.ParamByName('DTAREC').AsDateTime := ADataRecebimento;
    LConsulta.Open;

    LConsulta.First;

    // Identifica o menor CTR_SEQBAI para cada duplicata
    while not LConsulta.Eof do
    begin
      LChaveDuplicata := Format('%s|%s|%s|%s|%s', [
        LConsulta.FieldByName('CTR_NUMDUP').AsString,
        LConsulta.FieldByName('CTR_PARCEL').AsString,
        LConsulta.FieldByName('CTR_ESPDOC').AsString,
        LConsulta.FieldByName('CTR_CODCLI').AsString,
        LConsulta.FieldByName('CTR_CODEMP').AsString
      ]);

      if not LDuplicatas.ContainsKey(LChaveDuplicata) then
        LDuplicatas.Add(LChaveDuplicata, LConsulta.FieldByName('CTR_SEQBAI').AsInteger)
      else if LConsulta.FieldByName('CTR_SEQBAI').AsInteger < LDuplicatas[LChaveDuplicata] then
        LDuplicatas[LChaveDuplicata] := LConsulta.FieldByName('CTR_SEQBAI').AsInteger;
      LConsulta.Next;
    end;

    // Exclui registros com CTR_SEQBAI maior que o menor
    LConsulta.First;
    while not LConsulta.Eof do
    begin
      LAutoincrem := LConsulta.FieldByName('AUTOINCREM').AsString;
      LChaveDuplicata := Format('%s|%s|%s|%s|%s', [
        LConsulta.FieldByName('CTR_NUMDUP').AsString,
        LConsulta.FieldByName('CTR_PARCEL').AsString,
        LConsulta.FieldByName('CTR_ESPDOC').AsString,
        LConsulta.FieldByName('CTR_CODCLI').AsString,
        LConsulta.FieldByName('CTR_CODEMP').AsString
      ]);

      if LConsulta.FieldByName('CTR_SEQBAI').AsInteger > LDuplicatas[LChaveDuplicata] then
      begin
        // Exclui o registro
        LDelete.Close;
        LDelete.SQL.Text := 'SELECT * FROM CADREC WHERE AUTOINCREM = :AUTOINCREM';
        LDelete.ParamByName('AUTOINCREM').AsString := LAutoincrem;
        LDelete.Open;

        // Atualiza o registro
        LUpdate.Close;
        LUpdate.SQL.Text := 'UPDATE CADREC '+
                            ' SET CTR_VALREC = CTR_VALREC + :VALREC_EXC, '+
                            '     CTR_VALJUR = CTR_VALJUR + :VALJUR_EXC, '+
                            '     CTR_VALDES = CTR_VALDES + :VALDES_EXC, '+
                            '     CTR_VALORI = CTR_VALORI + :VALORI_EXC, '+
                            '     CTR_VALFRE = CTR_VALFRE + :VALFRE_EXC  '+
                            'WHERE CTR_NUMDUP = :NUMDUP '+
                            '  AND CTR_PARCEL = :PARCEL '+
                            '  AND CTR_ESPDOC = :ESPDOC '+
                            '  AND CTR_CODCLI = :CODCLI '+
                            '  AND CTR_CODEMP = :CODEMP '+
                            '  AND CTR_SEQBAI = :SEQBAI ';

        LUpdate.ParamByName('NUMDUP').AsString := LConsulta.FieldByName('CTR_NUMDUP').AsString;
        LUpdate.ParamByName('PARCEL').AsString := LConsulta.FieldByName('CTR_PARCEL').AsString;
        LUpdate.ParamByName('ESPDOC').AsString := LConsulta.FieldByName('CTR_ESPDOC').AsString;
        LUpdate.ParamByName('CODCLI').AsString := LConsulta.FieldByName('CTR_CODCLI').AsString;
        LUpdate.ParamByName('CODEMP').AsString := LConsulta.FieldByName('CTR_CODEMP').AsString;
        LUpdate.ParamByName('SEQBAI').AsInteger := LDuplicatas[LChaveDuplicata];

        LUpdate.ParamByName('VALREC_EXC').AsFloat := LConsulta.FieldByName('CTR_VALREC').AsFloat;
        LUpdate.ParamByName('VALJUR_EXC').AsFloat := LConsulta.FieldByName('CTR_VALJUR').AsFloat;
        LUpdate.ParamByName('VALDES_EXC').AsFloat := LConsulta.FieldByName('CTR_VALDES').AsFloat;
        LUpdate.ParamByName('VALORI_EXC').AsFloat := LConsulta.FieldByName('CTR_VALORI').AsFloat;
        LUpdate.ParamByName('VALFRE_EXC').AsFloat := LConsulta.FieldByName('CTR_VALFRE').AsFloat;

        LUpdate.ExecSql;

        fApagaDuplicataContasReceber(LDelete,
                                     'untTDesmembramentoBaixaReceber',
                                     'EXCLUSÃO - DESMEMBRAMENTO ANTERIOR');
      end;
      LConsulta.Next;
    end;
  finally
    // Libera recursos
    LConsulta.Free;
    LDelete.Free;
    LUpdate.Free;
    LDuplicatas.Free;
  end;
end;

{ Métodos para BANCTR }

procedure TDesmembraBaixaReceber.DesmembrarBanctr;
var
  LBaixa: TRegistroBaixa;
  LDuplicataBaixas: TDictionary<string, TList<TRegistroBaixa>>;
  LAutoincremDuplicata: string;
  LBaixasGrupo: TList<TRegistroBaixa>;
  LPrimeiraBaixa: TRegistroBaixa;
  LBaixaSubsequente: TRegistroBaixa;
begin
  if FBaixas.Count = 0 then
    Exit;

  // Inicializa dicionário para agrupar baixas pelo autoincrem da duplicata
  LDuplicataBaixas := TDictionary<string, TList<TRegistroBaixa>>.Create;
  try
    // Agrupa baixas por duplicata
    for LBaixa in FBaixas do
    begin
      if not LDuplicataBaixas.ContainsKey(LBaixa.AutoincremDuplicata) then
        LDuplicataBaixas.Add(LBaixa.AutoincremDuplicata, TList<TRegistroBaixa>.Create);
      LDuplicataBaixas[LBaixa.AutoincremDuplicata].Add(LBaixa);
    end;

    // Processa cada grupo de baixas
    for LAutoincremDuplicata in LDuplicataBaixas.Keys do
    begin
      LBaixasGrupo := LDuplicataBaixas[LAutoincremDuplicata];

      // Ordena as baixas do grupo por SequencialBaixa
      LBaixasGrupo.Sort(TComparer<TRegistroBaixa>.Construct(
        function(const Esquerda, Direita: TRegistroBaixa): Integer
        begin
          Result := Esquerda.SequencialBaixa - Direita.SequencialBaixa;
        end));

      if LBaixasGrupo.Count > 0 then
      begin
        if LBaixasGrupo[0].SequencialLancamentoBancario.IsEmpty then
          Continue;

        // Obtém a primeira baixa do grupo (menor SequencialBaixa)
        LPrimeiraBaixa := LBaixasGrupo[0];
        AtualizarBanctrBaixaPrincipal(LPrimeiraBaixa);

        for LBaixaSubsequente in LBaixasGrupo do
        begin
          if LBaixaSubsequente <> LPrimeiraBaixa then
          begin
            InserirBanctrBaixaParcial(LBaixaSubsequente);
          end;
        end;
      end;
    end;
  finally
    for LBaixasGrupo in LDuplicataBaixas.Values do
      LBaixasGrupo.Free;
    LDuplicataBaixas.Free;
  end;
end;

procedure TDesmembraBaixaReceber.AtualizarBanctrBaixaPrincipal(ABaixa: TRegistroBaixa);
Var
  LUpdate: TUniQuery;
  LDuplicata: TDuplicata;
  LDuplicataEncontrada: TDuplicata;
begin
  LUpdate := fCriaQuery(Nil);
  Try
    Try
      LDuplicataEncontrada := nil;
      for LDuplicata in FDuplicatas do
      begin
        if LDuplicata.AutoincremDuplicata = ABaixa.AutoincremDuplicata then
        begin
          LDuplicataEncontrada := LDuplicata;
          Break;
        end;
      end;

      if LDuplicataEncontrada = nil then
        Exit;

      if LDuplicataEncontrada.SequencialLancamentoBancario.IsEmpty then
        Exit;

      LUpdate.Close;
      LUpdate.SQL.Clear;
      LUpdate.SQL.Text := 'UPDATE BANCTR SET ' +
                         '  CTR_SEQBAI = :SEQBAI, ' +
                         '  CTR_VALREC = :VALREC, ' +
                         '  CTR_VALJUR = :VALJUR, ' +
                         '  CTR_VALDES = :VALDES ' +
                         'WHERE CTB_SEQLAN = :SEQLAN ' +
                         '  AND CTR_SEQBAI = 0 ' +
                         '  AND CTR_NUMDUP = :NUMDUP ' +
                         '  AND CTR_PARCEL = :PARCEL ' +
                         '  AND CTR_ESPDOC = :ESPDOC ' +
                         '  AND CTR_CODCLI = :CODCLI ' +
                         '  AND CTR_CODEMP = :CODEMP';

      LUpdate.ParamByName('SEQBAI').AsInteger := ABaixa.SequencialBaixa;
      LUpdate.ParamByName('VALREC').AsFloat := ABaixa.ValorRecebido;
      LUpdate.ParamByName('VALJUR').AsFloat := ABaixa.Juros;
      LUpdate.ParamByName('VALDES').AsFloat := ABaixa.Desconto;
      LUpdate.ParamByName('SEQLAN').AsString := LDuplicataEncontrada.SequencialLancamentoBancario;
      LUpdate.ParamByName('NUMDUP').AsString := LDuplicataEncontrada.NumeroDuplicata;
      LUpdate.ParamByName('PARCEL').AsString := LDuplicataEncontrada.Parcela;
      LUpdate.ParamByName('ESPDOC').AsString := LDuplicataEncontrada.Especie;
      LUpdate.ParamByName('CODCLI').AsString := LDuplicataEncontrada.CodigoCliente;
      LUpdate.ParamByName('CODEMP').AsString := LDuplicataEncontrada.CodigoEmpresa;
      LUpdate.ExecSQL;
    Except
      On E: Exception Do
      Begin
        Raise;
      End;
    End;
  Finally
    FreeAndNil(LUpdate);
  End;
end;

procedure TDesmembraBaixaReceber.InserirBanctrBaixaParcial(ABaixa: TRegistroBaixa);
Var
  LInsert: TUniQuery;
  LReplicacao: TUniQuery;
  LCampo: TField;
  LDuplicata: TDuplicata;
  LDuplicataEncontrada: TDuplicata;
begin
  LInsert := fCriaQuery(Nil);
  LReplicacao := fCriaQuery(Nil);

  Try
    LDuplicataEncontrada := nil;

    for LDuplicata in FDuplicatas do
    begin
      if LDuplicata.AutoincremDuplicata = ABaixa.AutoincremDuplicata then
      Begin
        LDuplicataEncontrada := LDuplicata;
        Break;
      End;
    end;

    if LDuplicataEncontrada = nil then
      Exit;

    if LDuplicataEncontrada.SequencialLancamentoBancario.IsEmpty then
      Exit;

    GeraListaDeCamposBANCTR;

    LReplicacao.Close;
    LReplicacao.SQL.Clear;
    LReplicacao.SQL.Text := 'SELECT * FROM BANCTR ' +
                            'WHERE CTB_SEQLAN = :SEQLAN ' +
                            '  AND CTR_NUMDUP = :NUMDUP ' +
                            '  AND CTR_PARCEL = :PARCEL ' +
                            '  AND CTR_ESPDOC = :ESPDOC ' +
                            '  AND CTR_CODCLI = :CODCLI ' +
                            '  AND CTR_CODEMP = :CODEMP';

    LReplicacao.ParamByName('SEQLAN').AsString := LDuplicataEncontrada.SequencialLancamentoBancario;
    LReplicacao.ParamByName('NUMDUP').AsString := LDuplicataEncontrada.NumeroDuplicata;
    LReplicacao.ParamByName('PARCEL').AsString := LDuplicataEncontrada.Parcela;
    LReplicacao.ParamByName('ESPDOC').AsString := LDuplicataEncontrada.Especie;
    LReplicacao.ParamByName('CODCLI').AsString := LDuplicataEncontrada.CodigoCliente;
    LReplicacao.ParamByName('CODEMP').AsString := LDuplicataEncontrada.CodigoEmpresa;
    LReplicacao.Open;

    if LReplicacao.IsEmpty then
      Exit;

    LInsert.Close;
    LInsert.SQL.Clear;
    LInsert.SQL.Text := 'INSERT INTO BANCTR (' + FCamposNovoBanctr + ') ' +
                                   ' VALUES (' + FParametrosNovoBanctr + ') ';

    For LCampo In LReplicacao.Fields Do
      LInsert.ParamByName(LCampo.FieldName).Value := LCampo.Value;

    LInsert.ParamByName('CTR_SEQBAI').AsInteger := ABaixa.SequencialBaixa;
    LInsert.ParamByName('CTR_VALREC').AsFloat := ABaixa.ValorRecebido;
    LInsert.ParamByName('CTR_VALJUR').AsFloat := ABaixa.Juros;
    LInsert.ParamByName('CTR_VALDES').AsFloat := ABaixa.Desconto;

    LInsert.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('BANCTR', VS_strCodEmp);

    LInsert.ExecSQL;

  Finally
    FreeAndNil(LInsert);
    FreeAndNil(LReplicacao);
  End;
end;

end.
