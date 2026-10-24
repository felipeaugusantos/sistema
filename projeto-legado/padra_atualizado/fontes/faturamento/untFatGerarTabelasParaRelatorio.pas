unit untFatGerarTabelasParaRelatorio;

interface

Uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE }
  Forms,
  cxProgressbar,
{$ENDIF}
  DB,
  SysUtils,
  Uni,
  Classes,
  untIFatEntregaFutura,
  untTFatEntregaFutura,
  untTFatReservaSaldo,
  untIFatReservaSaldo,
  System.Generics.Collections;

Type
  TCacheSaldosIteger = class
  Private
    FDicValor: TDictionary<String,Double>;
    procedure pAdicionarProdutoCacheIteger(ACodIte, ACodEmp: String);
  Public
    constructor Create;
    destructor Destroy; override;
    function fValorCampo(ATipoReserva: TTipoReservaSaldo; ACodIte, ACodEmp: String): Double; overload;
    function fValorCampo(ATipoEF: TTipoEntregaFutura; ACodIte, ACodEmp: String): Double; overload;
  end;

Type
  TFatGerarTabelasParaRelatorio = Class
  Private
    FQryProdutos: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
    FPedidosCorte: Boolean;
   {$IFNDEF LINUX}
    FProgressStatus: TCxProgressbar;
   {$ENDIF}
    FCacheSaldosIteger: TCacheSaldosIteger;

    procedure pProgressStatus(APos, AMax: Integer);

    function fSaldoEmML(): Boolean;

    function fGerarTemporariaReserva( ATipoReserva: TTipoReservaSaldo;
                                      AEmpresa,
                                      AEmpIte,
                                      ACodIte: String;
                                      AConverterML,
                                      APedCorte: Boolean;
                                      ANomeTabela: String ;
                                      ASomenteEstrutura: Boolean ): String;

    function fGerarTemporariaPendentesEF( ATipoEF: TTipoEntregaFutura;
                                          ACodIte,
                                          AEmpresa: String;
                                          AConverterML: Boolean;
                                          ANomeTabela: String ;
                                          ASomenteEstrutura: Boolean ): String;

    function fProcessarItensEGerarTabela(ATipoEF: TTipoEntregaFutura; ATabela: String = ''): String; overload;
    function fProcessarItensEGerarTabela(ATipoReserva: TTipoReservaSaldo; ATabela: String = ''): String; overload;

    function fProdutoTemQuantidade(ATipoReserva: TTipoReservaSaldo;
                                   ACodIte,
                                   ACodEmp: String): Boolean; overload;

    function fProdutoTemQuantidade(ATipoEF: TTipoEntregaFutura;
                                   ACodIte,
                                   ACodEmp: String): Boolean; overload;

  Public
    constructor Create(AQueryProdutos: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX}{$IFNDEF LINUX}; AProgressStatus: TCxProgressbar = nil{$ENDIF});
    destructor Destroy; override;

    function fTabelaReservadoGarantia(ATabela: String = ''): string;
    function fTabelaReservadoExterno(ATabela: String = ''): string;
    function fTabelaReservadoPedidoVenda(ATabela: String = ''): string;
    function fTabelaReservadoPedidoBaixaEntregaFuturaReservSaldo(ATabela: String = ''): string;
    function fTabelaReservadoPedidoBaixaEntregaFuturaSaldoFisico(ATabela: String = ''): string;
    function fTabelaReservadoEnderecamento(ATabela: String = ''): string;
    function fTabelaReservadoOrdemProducao(ATabela: String = ''): string;

    function fTabelaTransferenciasEmAndamento(ATabela: String = ''): string;

    function fTabelaEntregaFuturaPrevisao(ATabela: String = ''): string;
    function fTabelaEntregaFuturaFaltaProduto(ATabela: String = ''): string;
    function fTabelaEntregaFuturaAguandandoCliente(ATabela: String = ''): string;
  End;

implementation

{$IFNDEF LINUX}
uses untFuncoesSimples;
{$ENDIF}

constructor TFatGerarTabelasParaRelatorio.Create(AQueryProdutos: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX}{$IFNDEF LINUX}; AProgressStatus: TCxProgressbar = nil{$ENDIF});
begin
  FQryProdutos := AQueryProdutos;
  FPedidosCorte := False;
 {$IFNDEF LINUX}
  FProgressStatus := AProgressStatus;
 {$ENDIF}
  FCacheSaldosIteger := TCacheSaldosIteger.Create;
end;

destructor TFatGerarTabelasParaRelatorio.Destroy;
begin
  FreeAndNil(FCacheSaldosIteger);
  inherited;
end;

function TFatGerarTabelasParaRelatorio.fGerarTemporariaPendentesEF( ATipoEF: TTipoEntregaFutura;
                                                                    ACodIte,
                                                                    AEmpresa: String;
                                                                    AConverterML: Boolean;
                                                                    ANomeTabela: String;
                                                                    ASomenteEstrutura: Boolean ): String;
begin
  Result := TEntregaFutura.New(
                 TParamEF.New()
                   .CodIte(ACodIte)
                   .CodEmp(AEmpresa)
                   .Faturamento(True)
                   .TipoEF(ATipoEF)
                   .TipoTE(tteNenhuma)
                   .ConverteML(AConverterML)
                 ).fGetTabelaDocumentos(ANomeTabela, ASomenteEstrutura);
end;

function TFatGerarTabelasParaRelatorio.fGerarTemporariaReserva( ATipoReserva: TTipoReservaSaldo;
                                                                AEmpresa,
                                                                AEmpIte,
                                                                ACodIte: String;
                                                                AConverterML,
                                                                APedCorte: Boolean;
                                                                ANomeTabela: String;
                                                                ASomenteEstrutura: Boolean ): String;
Var
  LParametrosReserva: IReservaParametros;
begin
  LParametrosReserva := TReservaParametros.New
                          .EmpresaItem(AEmpIte)
                          .CodigoItem(ACodIte)
                          .CodEmpresa(AEmpresa)
                          .TipoReserva(ATipoReserva)
                          .ConverterML(AConverterML)
                          .DesconsideraPedidosCorte(Not APedCorte);

  If ATipoReserva In [trsPedidoVenda, trsTransferencia] Then
    LParametrosReserva.DesconsideraPedidosEnderecamento(True);

  Result := TSaldoReservado.New(LParametrosReserva).fGetTabelaDocumentos(ANomeTabela, ASomenteEstrutura);
end;

function TFatGerarTabelasParaRelatorio.fProcessarItensEGerarTabela(ATipoEF: TTipoEntregaFutura; ATabela: String = ''): String;
begin
  Result := ATabela;

  If FQryProdutos.IsEmpty Then
  Begin
    Result := fGerarTemporariaPendentesEF(ATipoEF,
                                          FQryProdutos.FieldByName('CODITE').AsString,
                                          FQryProdutos.FieldByName('CODEMP').AsString,
                                          fSaldoEmML(),
                                          Result,
                                          True {Somente estrutura});
    Exit;
  End;

  FQryProdutos.First;
  While Not FQryProdutos.Eof Do
  Begin
    pProgressStatus(FQryProdutos.RecNo, FQryProdutos.RecordCount);
    If fEmptyStr(Result) Or
       fProdutoTemQuantidade(ATipoEF,
                             FQryProdutos.FieldByName('CODITE').AsString,
                             FQryProdutos.FieldByName('CODEMP').AsString) Then
    Begin
      Result := fGerarTemporariaPendentesEF(ATipoEF,
                                            FQryProdutos.FieldByName('CODITE').AsString,
                                            FQryProdutos.FieldByName('CODEMP').AsString,
                                            fSaldoEmML(),
                                            Result,
                                            False);
    End;
    FQryProdutos.Next;
  End;
end;

function TFatGerarTabelasParaRelatorio.fProcessarItensEGerarTabela(ATipoReserva: TTipoReservaSaldo; ATabela: String = ''): String;
begin
  Result := ATabela;

  If FQryProdutos.IsEmpty Then
  Begin
    Result := fGerarTemporariaReserva(ATipoReserva,
                                      FQryProdutos.FieldByName('CODEMP').AsString,
                                      FQryProdutos.FieldByName('CODEMP').AsString,
                                      FQryProdutos.FieldByName('CODITE').AsString,
                                      fSaldoEmML(),
                                      FPedidosCorte,
                                      Result,
                                      True {Somente estrutura});
    Exit;
  End;

  FQryProdutos.First;
  While Not FQryProdutos.Eof Do
  Begin
    pProgressStatus(FQryProdutos.RecNo, FQryProdutos.RecordCount);
    If fEmptyStr(Result) Or
       fProdutoTemQuantidade(ATipoReserva,
                             FQryProdutos.FieldByName('CODITE').AsString,
                             FQryProdutos.FieldByName('CODEMP').AsString) Then
    Begin
      Result := fGerarTemporariaReserva(ATipoReserva,
                                        FQryProdutos.FieldByName('CODEMP').AsString,
                                        FQryProdutos.FieldByName('CODEMP').AsString,
                                        FQryProdutos.FieldByName('CODITE').AsString,
                                        fSaldoEmML(),
                                        FPedidosCorte,
                                        Result,
                                        False);
    End;
    FQryProdutos.Next;
  End;
end;

function TFatGerarTabelasParaRelatorio.fProdutoTemQuantidade(
  ATipoReserva: TTipoReservaSaldo; ACodIte, ACodEmp: String): Boolean;
begin
  If ATipoReserva <> trsPedidoVenda Then
    Result := FCacheSaldosIteger.fValorCampo(ATipoReserva, ACodIte, ACodEmp) <> 0
  Else
    Result := (FCacheSaldosIteger.fValorCampo(trsPedidoVendaCli, ACodIte, ACodEmp) +
               FCacheSaldosIteger.fValorCampo(trsPedidoVendaFil, ACodIte, ACodEmp)) <> 0;
end;

function TFatGerarTabelasParaRelatorio.fProdutoTemQuantidade(
  ATipoEF: TTipoEntregaFutura; ACodIte, ACodEmp: String): Boolean;
begin
  Result := FCacheSaldosIteger.fValorCampo(ATipoEF, ACodIte, ACodEmp) <> 0;
end;

function TFatGerarTabelasParaRelatorio.fSaldoEmML: Boolean;
begin
  Result := (FQryProdutos.FindField('ML_SN') <> Nil) And
            (FQryProdutos.FindField('ML_SN').AsString = 'S');
end;

function TFatGerarTabelasParaRelatorio.fTabelaEntregaFuturaAguandandoCliente(ATabela: String = ''): string;
begin
  Result := fProcessarItensEGerarTabela(tefAguardandoCliente, ATabela);
end;

function TFatGerarTabelasParaRelatorio.fTabelaEntregaFuturaFaltaProduto(ATabela: String = ''): string;
begin
  Result := fProcessarItensEGerarTabela(tefFaltaDeProduto, ATabela);
end;

function TFatGerarTabelasParaRelatorio.fTabelaEntregaFuturaPrevisao(ATabela: String = ''): string;
begin
  Result := fProcessarItensEGerarTabela(tefPrevisao, ATabela);
end;

function TFatGerarTabelasParaRelatorio.fTabelaReservadoEnderecamento(ATabela: String = ''): string;
begin
  Result := fProcessarItensEGerarTabela(trsEnderecamento, ATabela);
end;

function TFatGerarTabelasParaRelatorio.fTabelaReservadoExterno(ATabela: String = ''): string;
begin
  Result := fProcessarItensEGerarTabela(trsExterno, ATabela);
end;

function TFatGerarTabelasParaRelatorio.fTabelaReservadoGarantia(ATabela: String = ''): string;
begin
  Result := fProcessarItensEGerarTabela(trsGarantia, ATabela);
end;

function TFatGerarTabelasParaRelatorio.fTabelaReservadoOrdemProducao(ATabela: String = ''): string;
begin
  Result := fProcessarItensEGerarTabela(trsOrdemProducao, ATabela);
end;

function TFatGerarTabelasParaRelatorio.fTabelaReservadoPedidoVenda(ATabela: String = ''): string;
begin
  Result := fProcessarItensEGerarTabela(trsPedidoVenda, ATabela);
end;

function TFatGerarTabelasParaRelatorio.fTabelaReservadoPedidoBaixaEntregaFuturaReservSaldo(ATabela: String = ''): string;
begin
  Result := fProcessarItensEGerarTabela(trsPedidoBaixaEntregaFuturaReservSaldo, ATabela)
end;

function TFatGerarTabelasParaRelatorio.fTabelaReservadoPedidoBaixaEntregaFuturaSaldoFisico(ATabela: String = ''): string;
begin
  Result := fProcessarItensEGerarTabela(trsPedidoBaixaEntregaFuturaSaldoFisico, ATabela)
end;

function TFatGerarTabelasParaRelatorio.fTabelaTransferenciasEmAndamento(ATabela: String = ''): string;
begin
  Result := fProcessarItensEGerarTabela(trsTransferencia, ATabela);
end;

procedure TFatGerarTabelasParaRelatorio.pProgressStatus(APos, AMax: Integer);
begin
 {$IFNDEF LINUX}
  If Assigned(FProgressStatus) Then
  Begin
    FProgressStatus.Properties.Max := AMax;
    FProgressStatus.Position := APos;
    Application.ProcessMessages;
  End;
 {$ENDIF}
end;

{ TCacheSaldosIteger }

constructor TCacheSaldosIteger.Create;
begin
  FDicValor := TDictionary<String,Double>.Create;
end;

destructor TCacheSaldosIteger.Destroy;
begin
  FreeAndNil(FDicValor);
  inherited;
end;

function TCacheSaldosIteger.fValorCampo(ATipoReserva: TTipoReservaSaldo;
  ACodIte, ACodEmp: String): Double;
begin
  pAdicionarProdutoCacheIteger(ACodIte, ACodEmp);
  Result := FDicValor[Concat(ACodIte, ACodEmp, ATipoReserva.fRetNomeCampo)];
end;

function TCacheSaldosIteger.fValorCampo(ATipoEF: TTipoEntregaFutura; ACodIte,
  ACodEmp: String): Double;
begin
  pAdicionarProdutoCacheIteger(ACodIte, ACodEmp);
  Result := FDicValor[Concat(ACodIte, ACodEmp, ATipoEF.getField)];
end;

procedure TCacheSaldosIteger.pAdicionarProdutoCacheIteger(ACodIte, ACodEmp: String);
var
  LTipoEF: TTipoEntregaFutura;
  LTipoReserva: TTipoReservaSaldo;
  qryIteger: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  if FDicValor.ContainsKey(Concat(ACodIte, ACodEmp)) then
    Exit;

  FDicValor.Add(Concat(ACodIte, ACodEmp),  0);

  qryIteger := fCriaQuery;
  try
    qryIteger.SQL.Clear;
    qryIteger.SQL.Add('SELECT SQL_NO_CACHE ITE_CODITE, ITE_CODEMP ');

    for LTipoEF := Low(TTipoEntregaFutura) to High(TTipoEntregaFutura) do
      if not LTipoEF.getField.IsEmpty And LTipoEF.Update then
        qryIteger.SQL.Add(', ITE_' + LTipoEF.getField);

    for LTipoReserva := Low(TTipoReservaSaldo) to High(TTipoReservaSaldo) do
      if not LTipoReserva.fRetNomeCampo.IsEmpty then
        qryIteger.SQL.Add(', ITE_' + LTipoReserva.fRetNomeCampo);

    qryIteger.SQL.Add('FROM ITEGER WHERE ITE_CODITE = '+ ACodIte.QuotedString);
    qryIteger.SQL.Add(' AND ITE_CODEMP = '+ ACodEmp.QuotedString);
    qryIteger.Open;

    for LTipoEF := Low(TTipoEntregaFutura) to High(TTipoEntregaFutura) do
      if not LTipoEF.getField.IsEmpty And LTipoEF.Update then
        FDicValor.Add(Concat(ACodIte, ACodEmp, LTipoEF.getField),
          qryIteger.FieldByName('ITE_' + LTipoEF.getField).AsFloat);

    for LTipoReserva := Low(TTipoReservaSaldo) to High(TTipoReservaSaldo) do
      if not LTipoReserva.fRetNomeCampo.IsEmpty then
        FDicValor.Add(Concat(ACodIte, ACodEmp, LTipoReserva.fRetNomeCampo),
          qryIteger.FieldByName('ITE_' + LTipoReserva.fRetNomeCampo).AsFloat);
  finally
   {$IFNDEF LINUX}
    FreeAndNil(qryIteger);
   {$ENDIF}
  end;
end;

end.
