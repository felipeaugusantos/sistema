
unit untTConfirmaCartoes;

interface

Uses Forms,System.SysUtils,cxProgressBar,untIDataset,System.Generics.Collections,
     untFuncoesSimples, untConstantes,System.StrUtils,Uni, Data.DB, untLancPendentesConfirmacao,
     TipoConciliadora.Classes;

Type
  TConfirmaCartoes = Class
  Private
    FConciliadora: String;
    FDataInicial: TDateTime;
    FDataFinal: TDateTime;
    FNsu: String;
    FAutorizacao: String;
    FSimilares: Boolean;
    FParcela: String;
    FValorBruto: Double;
    FAutoIncremCartao: String;
    FExtrato: TUniQuery;
    FTipoConciliadora: TTipoConciliadora;
    FCampoEstabelecimento: String;

    function RetornaSQLResumoBandeiraExtrato:String;
    function RetornaSQLTotalizadorStatus:String;
    function RetornaFiltroSQLExtrato:String;
    function RetornaSQLExtratoVendas:String;
    function RetornaSQLCartoes:String;
    function RetornaSQLExtratosComVendasPendentes:String;
    procedure RetornaChavesConciliacao(Var ANsu: String;
                                       Var AAutorizacao: String;
                                       Var ADataTransacao: String);

    function ProcurandoCartoesParaVincular(pgbProgresso: TcxProgressBar): Boolean;
    function ConfirmarCartoesRelacionados(pgbProgresso: TcxProgressBar): Boolean;
    procedure ConfirmarCartao(AExtrato: String);

    function TemDivergenciaNoValorBruto(AValorBruto: Double): Boolean;
    function TemDivergenciaNaTaxa(ATaxaCartao: Double; ATaxaOperadora: Double; AValorBruto: Double): Boolean;
    function RetornaValorTolerancia(ACodEmp: String): Double;

    procedure AtualizarStatusParaConfirmado(AExtrato:String; ACartao: String);
    procedure AtualizarStatusParaSimilares(AExtrato:String);
    procedure AtualizarStatusParaIgnorado(AExtrato:String);
    procedure AtualizarStatusParaNaoRelacionado(AExtrato:String);
    procedure AtualizarStatusParaDivergenciaValorBruto(AExtrato:String);
    procedure AtualizarStatusParaDivergenciaNaTaxa(AExtrato:String);
    function  RetornaSubSelectCfgSis: String;
    procedure SetConciliadora(const Value: String);
    procedure SetTipoConciliadora(const Value: TTipoConciliadora);
  Public
    FLancamentosSelecionados: TLancamentoPendentes;

    constructor Create;
    destructor Destroy; override;

    procedure ConsultaResumoBandeiraExtrato(AQuery: TUniQuery);
    procedure ConsultaExtratoVenda(AQuery: TUniQuery);
    procedure ProcessaExtratoParaVincular;
    procedure ProcessaExtratoParaConfirmar;
    function RelacionarLancamentoExtrato: Boolean;
    procedure DesvincularLancamentoExtrato;
    procedure IgnorarLancamento;
    procedure RecomporLancamento;


    procedure ConsultaCartoesParaVincular(AQuery: TUniQuery);
    procedure ConsultaCartoesConfirmados(AQuery: TUniQuery);
    procedure ConsultaCartoesSimilaresParaVincular(AQuery: TUniQuery);
    procedure ConsultaCartaoParaVincular(AQuery: TUniQuery);
    procedure ConsultaTotalizadorPorStatus(AQuery: TUniQuery);

    procedure ConsultaVendasParaConfirmarPorPeriodo(AQuery: TUniQuery);
    procedure ConsultaExtratosComVendasPendentes(AQuery: TUniQuery);

    property Conciliadora:            String                Read FConciliadora              Write SetConciliadora;
    property DataInicial:             TDateTime             Read FDataInicial               Write FDataInicial;
    property DataFinal:               TDateTime             Read FDataFinal                 Write FDataFinal;
    property Nsu:                     String                Read FNsu                       Write FNsu;
    property Autorizacao:             String                Read FAutorizacao               Write FAutorizacao;
    property Parcela:                 String                Read FParcela                   Write FParcela;
    property ValorBruto:              Double                Read FValorBruto                Write FValorBruto;
    property Similares:               Boolean               Read FSimilares                 Write FSimilares;
    property Extrato:                 TUniQuery             Read FExtrato                   Write FExtrato;
    property AutoIncremCartao:        String                Read FAutoIncremCartao          Write FAutoIncremCartao;
    property TipoConciliadora:        TTipoConciliadora     Read FTipoConciliadora          Write SetTipoConciliadora;
  End;

implementation

Uses untFuncoes;

{ TConfirmaCartoes }

procedure TConfirmaCartoes.ConsultaCartoesParaVincular(AQuery: TUniQuery);
begin
  Try
    AQuery.Close;
    AQuery.SQL.Clear;
    AQuery.SQL.Text := RetornaSQLCartoes;
    AQuery.SQL.Text := AQuery.SQL.Text +
                       'WHERE MCA_DTACUP IN ('+FLancamentosSelecionados.DataTransacao+')' +
                       '  AND EXT_SEQMCA IS NULL ';
    AQuery.Open;

    If Not AQuery.IsEmpty Then
      pSetaClient(AQuery);

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

procedure TConfirmaCartoes.ConsultaCartoesConfirmados(AQuery: TUniQuery);
begin
  Try
    AQuery.Close;
    AQuery.SQL.Clear;
    AQuery.SQL.Text := RetornaSQLCartoes;
    AQuery.SQL.Text := AQuery.SQL.Text +
                       'WHERE MOVCAR.AUTOINCREM = :AUTOINC';

    AQuery.ParamByName('AUTOINC').AsString := FAutoIncremCartao;

    AQuery.Open;

    If Not AQuery.IsEmpty Then
      pSetaClient(AQuery);

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

procedure TConfirmaCartoes.AtualizarStatusParaDivergenciaNaTaxa(AExtrato: String);
  Var
    LDivValorTaxa : TUniQuery;
begin

  If FExtrato.FieldByName('EXT_STATUS').AsString.Equals('T') Then
    Exit;

  Try
    Try
      LDivValorTaxa := untFuncoes.CriarQueryDLL;
      LDivValorTaxa.Close;
      LDivValorTaxa.SQL.Clear;
      LDivValorTaxa.SQL.Text := 'UPDATE                        '+
                                 '  EXTMCA                     '+
                                 'SET                          '+
                                 '  EXT_STATUS = "T",          '+
                                 '  EXT_SEQMCA = NULL,         '+
                                 '  EXT_DTACON = NULL,         '+
                                 '  EXT_OPECON = NULL          '+
                                 ' WHERE AUTOINCREM = :AUTINC  ';

      LDivValorTaxa.ParamByName('AUTINC').AsString := AExtrato;
      LDivValorTaxa.ExecSQL;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LDivValorTaxa);
  End;
end;

procedure TConfirmaCartoes.AtualizarStatusParaDivergenciaValorBruto(AExtrato: String);
  Var
    LDivValorBruto : TUniQuery;
begin

  If FExtrato.FieldByName('EXT_STATUS').AsString.Equals('B') Then
    Exit;

  Try
    Try
      LDivValorBruto := untFuncoes.CriarQueryDLL;
      LDivValorBruto.Close;
      LDivValorBruto.SQL.Clear;
      LDivValorBruto.SQL.Text := 'UPDATE                       '+
                                 '  EXTMCA                     '+
                                 'SET                          '+
                                 '  EXT_STATUS = "B",          '+
                                 '  EXT_SEQMCA = NULL,         '+
                                 '  EXT_DTACON = NULL,         '+
                                 '  EXT_OPECON = NULL          '+
                                 ' WHERE AUTOINCREM = :AUTINC  ';

      LDivValorBruto.ParamByName('AUTINC').AsString := AExtrato;
      LDivValorBruto.ExecSQL;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LDivValorBruto);
  End;
end;

procedure TConfirmaCartoes.AtualizarStatusParaIgnorado(AExtrato: String);
  Var
    LIgnorado : TUniQuery;
begin

  If FExtrato.FieldByName('EXT_STATUS').AsString.Equals('I') Then
    Exit;

  Try
    Try
      LIgnorado := untFuncoes.CriarQueryDLL;
      LIgnorado.Close;
      LIgnorado.SQL.Clear;
      LIgnorado.SQL.Text := 'UPDATE                            '+
                                 '  EXTMCA                     '+
                                 'SET                          '+
                                 '  EXT_STATUS = "I",          '+
                                 '  EXT_SEQMCA = NULL,         '+
                                 '  EXT_DTACON = NULL,         '+
                                 '  EXT_OPECON = NULL          '+
                                 ' WHERE AUTOINCREM = :AUTINC  ';

      LIgnorado.ParamByName('AUTINC').AsString := AExtrato;
      LIgnorado.ExecSQL;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LIgnorado);
  End;
end;

procedure TConfirmaCartoes.AtualizarStatusParaNaoRelacionado(AExtrato: String);
  Var
    LNaoRelacionar : TUniQuery;
begin

  If FExtrato.FieldByName('EXT_STATUS').AsString.Equals('N') Then
    Exit;

  Try
    Try
      LNaoRelacionar := untFuncoes.CriarQueryDLL;
      LNaoRelacionar.Close;
      LNaoRelacionar.SQL.Clear;
      LNaoRelacionar.SQL.Text := 'UPDATE                       '+
                                 '  EXTMCA                     '+
                                 'SET                          '+
                                 '  EXT_STATUS = "N",          '+
                                 '  EXT_SEQMCA = NULL,         '+
                                 '  EXT_DTACON = NULL,         '+
                                 '  EXT_OPECON = NULL          '+
                                 ' WHERE AUTOINCREM = :AUTINC  ';

      LNaoRelacionar.ParamByName('AUTINC').AsString := AExtrato;
      LNaoRelacionar.ExecSQL;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LNaoRelacionar);
  End;
end;

procedure TConfirmaCartoes.AtualizarStatusParaConfirmado(AExtrato,
  ACartao: String);
  Var
    LConfirmar : TUniQuery;
begin
  Try
    Try
      LConfirmar := untFuncoes.CriarQueryDLL;
      LConfirmar.Close;
      LConfirmar.SQL.Clear;
      LConfirmar.SQL.Text := 'UPDATE                      '+
                              '  EXTMCA                    '+
                              'SET                         '+
                              '  EXT_STATUS = "C",         '+
                              '  EXT_DTACON = :DTACON,     '+
                              '  EXT_OPECON = :OPECON,     '+
                              '  EXT_SEQMCA = :SEQMCA      '+
                              'WHERE AUTOINCREM = :AUTINC  ';

      LConfirmar.ParamByName('SEQMCA').AsString  := ACartao;
      LConfirmar.ParamByName('AUTINC').AsString  := AExtrato;
      LConfirmar.ParamByName('DTACON').AsDateTime := VS_Date;
      LConfirmar.ParamByName('OPECON').AsString   := strLoginUsuarioLogado;
      LConfirmar.ExecSQL;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LConfirmar);
  End;
end;

procedure TConfirmaCartoes.AtualizarStatusParaSimilares(AExtrato: String);
  Var
    LSimilares : TUniQuery;
begin

  If FExtrato.FieldByName('EXT_STATUS').AsString.Equals('S') Then
    Exit;

  Try
    Try
      LSimilares := untFuncoes.CriarQueryDLL;
      LSimilares.Close;
      LSimilares.SQL.Clear;
      LSimilares.SQL.Text := 'UPDATE                       '+
                             '  EXTMCA                     '+
                             'SET                          '+
                             '  EXT_STATUS = "S",          '+
                             '  EXT_SEQMCA = NULL,         '+
                             '  EXT_DTACON = NULL,         '+
                             '  EXT_OPECON = NULL          '+
                              'WHERE AUTOINCREM = :AUTINC  ';

      LSimilares.ParamByName('AUTINC').AsString := AExtrato;
      LSimilares.ExecSQL;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LSimilares);
  End;
end;

procedure TConfirmaCartoes.ConsultaTotalizadorPorStatus(AQuery: TUniQuery);
Begin
  Try

    AQuery.Close;
    AQuery.SQL.Clear;
    AQuery.SQL.Text := RetornaSQLTotalizadorStatus;
    AQuery.SQL.Text := AQuery.SQL.Text +
                      ' WHERE EXT_NOMCON = :NOMCON  '+
                      '   AND EXT_DTACLO IS NULL    '+
                      RetornaFiltroSQLExtrato  ;

    AQuery.ParamByName('NOMCON').AsString   := FConciliadora;


    AQuery.Open;

    If Not AQuery.IsEmpty Then
    Begin
      pSetaClient(AQuery);

      AQuery.Edit;
      AQuery.FieldByName('TOTAL_EXTRATO').AsFloat :=  AQuery.FieldByName('TOTAL_CONFIRMADOS').AsFloat +
                                                      AQuery.FieldByName('TOTAL_DIV_TAXA').AsFloat +
                                                      AQuery.FieldByName('TOTAL_DIV_BRUTO').AsFloat +
                                                      AQuery.FieldByName('TOTAL_IGNORADOS').AsFloat +
                                                      AQuery.FieldByName('TOTAL_NAO_CONFIRMADOS').AsFloat +
                                                      AQuery.FieldByName('TOTAL_SIMILARES').AsFloat;

      AQuery.FieldByName('QUANTIDADE_EXTRATO').AsInteger :=  AQuery.FieldByName('QUANTIDADE_CONFIRMADOS').AsInteger +
                                                             AQuery.FieldByName('QUANTIDADE_DIV_TAXA').AsInteger +
                                                             AQuery.FieldByName('QUANTIDADE_DIV_BRUTO').AsInteger +
                                                             AQuery.FieldByName('QUANTIDADE_IGNORADOS').AsInteger +
                                                             AQuery.FieldByName('QUANTIDADE_NAO_CONFIRMADOS').AsInteger +
                                                             AQuery.FieldByName('QUANTIDADE_SIMILARES').AsInteger;

      AQuery.Post;
    End;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
End;

procedure TConfirmaCartoes.ConfirmarCartao(AExtrato: String);
  Var
    LConfirmar : TUniQuery;
begin

  Try
    Try
      LConfirmar := untFuncoes.CriarQueryDLL;
      LConfirmar.Close;
      LConfirmar.SQL.Clear;
      LConfirmar.SQL.Text := 'UPDATE                       '+
                             '  EXTMCA                     '+
                             'SET                          '+
                             '  EXT_STATUS = "C",          '+
                             '  EXT_DTACON = :DTACON,      '+
                             '  EXT_OPECON = :OPECON       '+
                              'WHERE AUTOINCREM = :AUTINC  ';

      LConfirmar.ParamByName('AUTINC').AsString := AExtrato;
      LConfirmar.ParamByName('DTACON').AsDateTime := VS_Date;
      LConfirmar.ParamByName('OPECON').AsString := strLoginUsuarioLogado;

      LConfirmar.ExecSQL;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LConfirmar);
  End;
end;

function TConfirmaCartoes.ConfirmarCartoesRelacionados(
  pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := True;

  Try
    pgbProgresso.Position := 0;
    pgbProgresso.Properties.Max := FExtrato.RecordCount;

    FExtrato.First;
    While Not FExtrato.Eof Do
    Begin
      ConfirmarCartao(FExtrato.FieldByName('AUTOINCREM').AsString);
      FExtrato.Next;
      pStep(pgbProgresso);
    End;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

procedure TConfirmaCartoes.ConsultaCartaoParaVincular(
  AQuery: TUniQuery);
begin
  Try
    AQuery.Close;
    AQuery.SQL.Clear;
    AQuery.SQL.Text := RetornaSQLCartoes;
    AQuery.SQL.Text := AQuery.SQL.Text +
                       'WHERE MCA_DTACUP BETWEEN :DTAINI AND :DTAFIN           '+
                       '  AND ((MCA_NUMCCD = :NUMCCD AND MCA_NUMCCD <> "") OR  '+
                       '       (MCA_NUMNSU = :NUMNSU AND MCA_NUMNSU <> "") OR  '+
                       '       (LEFT(RIGHT(MCA_NUMPOK, 9),6) = :NUMCCD AND MCA_NUMPOK <> ""))       '+
                       '   AND MCA_PARCEL = :PARCEL                            '+
                       '   AND EXT_SEQMCA IS NULL                              ';

    AQuery.ParamByName('DTAINI').AsDateTime := FDataInicial;
    AQuery.ParamByName('DTAFIN').AsDateTime := FDataFinal;
    AQuery.ParamByName('NUMCCD').AsString   := FAutorizacao;
    AQuery.ParamByName('NUMNSU').AsString   := FNsu;
    AQuery.ParamByName('PARCEL').AsString   := FParcela;
    AQuery.Open;

    If Not AQuery.IsEmpty Then
      pSetaClient(AQuery);

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

procedure TConfirmaCartoes.ConsultaCartoesSimilaresParaVincular(
  AQuery: TUniQuery);
Begin
  Try
    AQuery.Close;
    AQuery.SQL.Clear;
    AQuery.SQL.Text := RetornaSQLCartoes;

    AQuery.SQL.Text := AQuery.SQL.Text +
                         'WHERE MCA_DTACUP BETWEEN :DTAINI AND :DTAFIN    '+
                          ' AND EXT_SEQMCA IS NULL                        ';

    AQuery.ParamByName('DTAINI').AsDateTime := FDataInicial;
    AQuery.ParamByName('DTAFIN').AsDateTime := FDataFinal;

    AQuery.Open;

    If Not AQuery.IsEmpty Then
      pSetaClient(AQuery);

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;

End;

procedure TConfirmaCartoes.ConsultaExtratosComVendasPendentes(AQuery: TUniQuery);
begin
  Try
    AQuery.Close;
    AQuery.SQL.Clear;
    AQuery.SQL.Text := RetornaSQLExtratosComVendasPendentes;
    AQuery.Open;

    If Not AQuery.IsEmpty Then
      pSetaClient(AQuery);

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

procedure TConfirmaCartoes.ConsultaExtratoVenda(AQuery: TUniQuery);
begin

  Try
    AQuery.Close;
    AQuery.SQL.Clear;
    AQuery.SQL.Text := RetornaSQLExtratoVendas;
    AQuery.SQL.Text := AQuery.SQL.Text +
                       ' WHERE EXT_NOMCON = :NOMCON  '+
                       '   AND EXT_DTACLO IS NULL    '+
                       RetornaFiltroSQLExtrato        +
                       ' GROUP BY EXTMCA.AUTOINCREM  ';

    AQuery.ParamByName('NOMCON').AsString   := FConciliadora;
    AQuery.Open;

    If Not AQuery.IsEmpty Then
      pSetaClient(AQuery);

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

procedure TConfirmaCartoes.ConsultaResumoBandeiraExtrato(AQuery: TUniQuery);
begin
  Try
    AQuery.Close;
    AQuery.SQL.Clear;
    AQuery.SQL.Text := RetornaSQLResumoBandeiraExtrato;
    AQuery.ParamByName('NOMCON').AsString   := FConciliadora;
    AQuery.Open;

    If Not AQuery.IsEmpty Then
      pSetaClient(AQuery);

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

procedure TConfirmaCartoes.ConsultaVendasParaConfirmarPorPeriodo(
  AQuery: TUniQuery);
  Var
    LSql: String;
begin
  LSql := RetornaSQLExtratoVendas +
          ' WHERE EXT_NOMCON = :NOMCON  '+
          '   AND EXT_DTACLO IS NULL    '+
          '   AND EXT_DTACUP BETWEEN :DTAINI AND :DTAFIN ';

  If Not FLancamentosSelecionados.Estabelecimento.IsEmpty Then
   LSql := LSql + '   AND EXT_NUM_PV IN ('+FLancamentosSelecionados.Estabelecimento+')';

  Try
    AQuery.Close;
    AQuery.SQL.Clear;
    AQuery.SQL.Text := LSql;
    AQuery.ParamByName('NOMCON').AsString   := FConciliadora;
    AQuery.ParamByName('DTAINI').AsDateTime := FDataInicial;
    AQuery.ParamByName('DTAFIN').AsDateTime := FDataFinal;
    AQuery.Open;

    If Not AQuery.IsEmpty Then
      pSetaClient(AQuery);

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

constructor TConfirmaCartoes.Create;
begin
  FCampoEstabelecimento := 'EXT_NUM_PV';
end;

destructor TConfirmaCartoes.Destroy;
begin

  inherited;
end;

procedure TConfirmaCartoes.DesvincularLancamentoExtrato;
begin
  AtualizarStatusParaNaoRelacionado(FExtrato.FieldByName('AUTOINCREM').AsString);
end;

procedure TConfirmaCartoes.IgnorarLancamento;
begin
  AtualizarStatusParaIgnorado(FExtrato.FieldByName('AUTOINCREM').AsString);
end;

procedure TConfirmaCartoes.ProcessaExtratoParaConfirmar;
begin
  Try
    If FExtrato.IsEmpty Then
      Exit;

    ExecutaAguarde(ConfirmarCartoesRelacionados,'Aguarde... Confirmando Lançamentos.');
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

procedure TConfirmaCartoes.ProcessaExtratoParaVincular;
Begin
  Try
    If FExtrato.IsEmpty Then
      Exit;

    ExecutaAguarde(ProcurandoCartoesParaVincular,'Aguarde... Vinculando Extrato.');
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
End;

function TConfirmaCartoes.ProcurandoCartoesParaVincular(pgbProgresso: TcxProgressBar): Boolean;
  Var
    LNsu,
    LAutorizacao,
    LDataTransacao: String;

    LMovCar: TUniQuery;
    LRecNo: Integer;
begin
  Result := True;
  LRecNo := 0;

  Try
    LMovCar := untFuncoes.CriarQueryDLL;
    RetornaChavesConciliacao(LNsu,LAutorizacao,LDataTransacao);

    Try
      LMovCar.Close;
      LMovCar.Sql.Clear;
      LMovCar.Sql.Text := RetornaSQLCartoes;
      LMovCar.SQL.Text := LMovCar.SQL.Text +
                         'WHERE  MCA_DTACUP IN( '+ LDataTransacao + ')                          '+
                         ' AND ((MCA_NUMCCD IN( '+ LAutorizacao   + ') AND MCA_NUMCCD <> "") OR '+
                         '      (MCA_NUMNSU IN( '+ LNsu +') AND MCA_NUMNSU <> "" )           OR '+
                         '      (LEFT(RIGHT(MCA_NUMPOK, 9),6) IN (' + LAutorizacao + ')         '+
                         '       AND IFNULL(MCA_NUMPOK,"") <> ""))                              '+
                         ' AND EXT_SEQMCA IS NULL                                               ';
      LMovCar.Open;

      If LMovCar.IsEmpty Then
        Exit;

      LRecNo := FExtrato.RecNo;
      FExtrato.DisableControls;
      FExtrato.First;

      pgbProgresso.Position := 0;
      pgbProgresso.Properties.Max := FExtrato.RecordCount;

      While Not FExtrato.Eof Do
      Begin

        If MatchStr(FExtrato.FieldByName('EXT_STATUS').AsString,['I','C']) Then
        Begin
          FExtrato.Next;
          pStep(pgbProgresso);
          Continue;
        End;


        LMovCar.Filtered := False;
        LMovCar.Filter :=
            'MCA_DTACUP = ' + QuotedStr(FExtrato.FieldByName('EXT_DTACUP').AsString) + ' AND ' +
            'MCA_PARCEL = ' + QuotedStr(FExtrato.FieldByName('EXT_PARCEL').AsString) + ' AND ' +
            '(' +
                '(MCA_NUMCCD = ' + QuotedStr(FExtrato.FieldByName('EXT_CODAUT').AsString) + ' AND MCA_NUMCCD <> "") OR ' +
                '(MCA_NUMNSU = ' + QuotedStr(FExtrato.FieldByName('EXT_NUMNSU').AsString) + ' AND MCA_NUMNSU <> "") OR ' +
                '(NUMPOK = '     + QuotedStr(FExtrato.FieldByName('EXT_CODAUT').AsString) + ' AND MCA_NUMPOK <> "")' +
            ')';

        LMovCar.Filtered := True;
        LMovCar.First;

        If Not LMovCar.IsEmpty Then
        Begin

          If (LMovCar.RecordCount > 1) Then
          Begin
            AtualizarStatusParaSimilares(FExtrato.FieldByName('AUTOINCREM').AsString);
          End

          Else If TemDivergenciaNoValorBruto(LMovCar.FieldByName('MCA_VALSTA').AsFloat) Then
          Begin
            AtualizarStatusParaDivergenciaValorBruto(FExtrato.FieldByName('AUTOINCREM').AsString);
          End

          Else If TemDivergenciaNaTaxa(LMovCar.FieldByName('MCA_PERCAR').AsFloat,
                                       LMovCar.FieldByName('CAR_PERDES').AsFloat,
                                       LMovCar.FieldByName('MCA_VALSTA').AsFloat) Then
          Begin
            AtualizarStatusParaDivergenciaNaTaxa(FExtrato.FieldByName('AUTOINCREM').AsString);
          End

          Else
          Begin
            AtualizarStatusParaConfirmado(FExtrato.FieldByName('AUTOINCREM').AsString,
                                            LMovCar.FieldByName('AUTOINCREM').AsString);
          End;


        End
        Else
          AtualizarStatusParaNaoRelacionado(FExtrato.FieldByName('AUTOINCREM').AsString);

        FExtrato.Next;
        pStep(pgbProgresso);
      End;

      FExtrato.Refresh;
    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LMovCar);
    FExtrato.RecNo := LRecNo;
    FExtrato.EnableControls;
  End;
end;

procedure TConfirmaCartoes.RecomporLancamento;
begin
  AtualizarStatusParaNaoRelacionado(FExtrato.FieldByName('AUTOINCREM').AsString);
end;

function TConfirmaCartoes.RelacionarLancamentoExtrato: Boolean;
  Var
    LMovCar: TUniQuery;
begin
  Result := False;

  Try
    LMovCar := untFuncoes.CriarQueryDLL;

    Try
      LMovCar.Close;
      LMovCar.Sql.Clear;
      LMovCar.Sql.Text := RetornaSQLCartoes;
      LMovCar.SQL.Text := LMovCar.SQL.Text +
                         ' WHERE MOVCAR.AUTOINCREM = :AUTOINC '+
                         '  AND EXT_SEQMCA IS NULL            ';

      LMovCar.ParamByName('AUTOINC').AsString := FAutoIncremCartao;
      LMovCar.Open;


      If FExtrato.FieldByName('EXT_STATUS').AsString.Equals('I') Then
      Begin
        fMensagem('ATENÇÃO', 'Lançamentos ignorados não podem ser vinculados!', ['&O k']);
        Exit;
      End;

      If FExtrato.FieldByName('EXT_STATUS').AsString.Equals('C') Then
      Begin
        fMensagem('ATENÇÃO', 'Lançamentos confirmados não podem ser vinculados!', ['&O k']);
        Exit;
      End;

      If LMovCar.FieldByName('MCA_DTACUP').AsDateTime <> FExtrato.FieldByName('EXT_DTACUP').AsDateTime Then
      Begin
        fMensagem('ATENÇÃO', 'A Data de Transação do cartão deve ser igual ao do lançamento no extrato para realizar o vínculo!', ['&O k']);
        Exit;
      End;

      If (LMovCar.FieldByName('MCA_NUMCCD').AsString <> FExtrato.FieldByName('EXT_CODAUT').AsString) And
         (LMovCar.FieldByName('MCA_NUMNSU').AsString <> FExtrato.FieldByName('EXT_NUMNSU').AsString) Then
      Begin
        fMensagem('ATENÇÃO', 'O Número de Liberação e/ou o NSU devem ser iguais ao do lançamento no extrato para realizar o vínculo!', ['&O k']);
        Exit;
      End;

      If LMovCar.FieldByName('MCA_PARCEL').AsString <> FExtrato.FieldByName('EXT_PARCEL').AsString Then
      Begin
        fMensagem('ATENÇÃO', 'A parcela do cartão deve ser igual ao do lançamento no extrato para realizar o vínculo!', ['&O k']);
        Exit;
      End;

      If TemDivergenciaNoValorBruto(LMovCar.FieldByName('MCA_VALSTA').AsFloat) Then
      Begin
        fMensagem('ATENÇÃO', 'A o valor bruto do cartão deve ser igual ao do lançamento no extrato para realizar o vínculo!', ['&O k']);
        Exit;
      End;

      AtualizarStatusParaConfirmado(FExtrato.FieldByName('AUTOINCREM').AsString,LMovCar.FieldByName('AUTOINCREM').AsString);
      Result := True;
    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LMovCar);
  End;
end;

procedure TConfirmaCartoes.RetornaChavesConciliacao(var ANsu, AAutorizacao, ADataTransacao: String);
  Var
    LValor: String;
    LRecNo: Integer;
begin
  ANsu := '""';
  AAutorizacao := '""';
  ADataTransacao := '""';

  LRecNo := FExtrato.RecNo;
  FExtrato.DisableControls;

  Try
    FExtrato.First;
    While Not FExtrato.Eof Do
    Begin
      LValor := '"' + FExtrato.FieldByName('EXT_NUMNSU').AsString + '"';
      If Not (Pos(LValor, ANsu) > 0) Then
        ANsu := ANsu + ',' + LValor;

      LValor := '"' + FExtrato.FieldByName('EXT_CODAUT').AsString + '"';
      If Not (Pos(LValor, AAutorizacao) > 0) Then
        AAutorizacao := AAutorizacao + ',' + LValor;

      LValor := '"' + FormatDateTime('YYYY-MM-DD', FExtrato.FieldByName('EXT_DTACUP').AsDateTime) + '"';
      If Not (Pos(LValor, ADataTransacao) > 0) Then
        ADataTransacao := ADataTransacao + ',' + LValor;

      FExtrato.Next;
    End;
  Finally
    FExtrato.RecNo := LRecNo;
    FExtrato.EnableControls;
  End;

end;

function TConfirmaCartoes.RetornaFiltroSQLExtrato: String;
begin
  Result := ' AND EXT_DTACUP BETWEEN ' + FormatDateTime('YYYY-MM-DD', FDataInicial).QuotedString +
            ' AND ' + FormatDateTime('YYYY-MM-DD', FDataFinal).QuotedString;

  If Not FLancamentosSelecionados.DataTransacao.IsEmpty Then
    Result := ' AND EXT_DTACUP IN ('+FLancamentosSelecionados.DataTransacao+') ';

  If Not FLancamentosSelecionados.Estabelecimento.IsEmpty Then
    Result := Result + '  AND EXT_NUM_PV IN ('+FLancamentosSelecionados.Estabelecimento+')';
end;


function TConfirmaCartoes.RetornaSQLCartoes: String;
begin
  Result := 'SELECT        '+
            '  MOVCAR.*,   '+
            '  LEFT(RIGHT(MCA_NUMPOK, 9), 6) AS NUMPOK, '+
            '  CAR_PERDES  '+
            'FROM          '+
            '  MOVCAR      '+
            'JOIN CADCAR ON CAR_CODCAR = MCA_CODCAR      '+
            'LEFT JOIN EXTMCA ON EXT_SEQMCA = MOVCAR.AUTOINCREM ';
end;


function TConfirmaCartoes.RetornaSQLExtratosComVendasPendentes: String;
begin
  Result := ' SELECT DISTINCT                                             '+
            '    CONCAT(COUNT(E.EXT_NOMCON)," Lançamento(s)") AS QTDREG,  '+
            '    E.EXT_NOMCON AS NOMCON,                                  '+
            '    "N" AS MARCADO,                                          '+
            '    E.EXT_NOMCON AS IMGCON                                   '+
            '  FROM                                                       '+
            '    EXTMCA E                                                 '+
            '  WHERE E.EXT_DTACON IS NULL                                 '+
            '    AND E.EXT_STATUS <> "I"                                  '+
            '  GROUP BY E.EXT_NOMCON                                      ';
end;

function TConfirmaCartoes.RetornaSQLExtratoVendas: String;
begin
  Result := 'SELECT ' +
            '  EXTMCA.AUTOINCREM AS AUTOINCREM, ' +
               FCampoEstabelecimento + ' AS EXT_NUM_PV, '+
            '  EXT_CODAUT, ' +
            '  EXT_NUMNSU, ' +
            '  EXT_PARCEL, ' +
            '  EXT_DTACUP, ' +
            '  EXT_DTAVEN, ' +
            '  EXT_VALBRU, ' +
            '  EXT_VALTAX, ' +
            '  EXT_VALLIQ, ' +
            '  EXT_NUMCAR, ' +
            '  EXT_NOMBAN, ' +
            '  EXT_STATUS, ' +
            '  EXT_OPEIMP, ' +
            '  EXT_DTAIMP, ' +
            '  EXT_NOMCON, ' +
            '  EXT_DTACON, ' +
            '  EXT_OPECON, ' +
            '  EXT_SEQMCA, ' +
            '  EXT_DTACLO, ' +
            '  EXT_HORCLO, ' +
            '  EXT_OPECLO, ' +
            '  EMP_CODEMP  ' +
            'FROM EXTMCA   ' +
            '  LEFT JOIN   ' +
            RetornaSubSelectCfgSis +
            '  ON LOCATE(EXT_NUM_PV, SIS_VALCFG) > 0 ' +
            '  LEFT JOIN CADEMP ' +
            '  ON EMP_CODEMP = SIS_CODEMP ';
end;

function TConfirmaCartoes.RetornaSQLResumoBandeiraExtrato: String;
begin
  Result := 'SELECT                                 '+
            '   CONCAT(                             '+
            '     IFNULL(                           '+
                      FCampoEstabelecimento + ','    +
            '       "000"),                         '+
            '     "-",                              '+
            '     IFNULL(                           '+
            '       EMP_NOMEMP,                     '+
            '       "NÃO EXISTE EMPRESA VINCULADA"  '+
            '     )                                 '+
            '   ) AS ESTABELECIMENTO,               '+
            '   COUNT(EXT_CODAUT) AS QUANTIDADE,    '+
            '   EXT_NOMBAN AS BANDEIRA,             '+
            '   EXT_NOMBAN AS LOGO,                 '+
            '   SUM(EXT_VALBRU) AS TOTAL_BRUTO,     '+
            '   SUM(EXT_VALTAX) AS TOTAL_TAXA,      '+
            '   SUM(EXT_VALLIQ) AS TOTAL_LIQUIDO    '+
            ' FROM                                  '+
            '   EXTMCA                              '+
            '   LEFT JOIN                           '+
                     RetornaSubSelectCfgSis          +
            '     ON LOCATE(EXT_NUM_PV, SIS_VALCFG) > 0          '+
            '   LEFT JOIN CADEMP                    '+
            '     ON EMP_CODEMP = SIS_CODEMP        '+
            ' WHERE EXT_NOMCON = :NOMCON            '+
            '   AND EXT_DTACLO IS NULL              '+
             RetornaFiltroSQLExtrato                 +
            ' GROUP BY EXT_NUM_PV,                  '+
            '   EXT_NOMBAN;                         ';
end;


function TConfirmaCartoes.RetornaSQLTotalizadorStatus: String;
begin
  Result := 'SELECT                                                              '+
            '  SUM(IF(EXT_STATUS = "C",EXT_VALLIQ,0)) AS TOTAL_CONFIRMADOS,      '+
            '  SUM(EXT_STATUS = "C") AS QUANTIDADE_CONFIRMADOS,                  '+
            '                                                                    '+
            '  SUM(IF(EXT_STATUS = "T",EXT_VALLIQ,0)) AS TOTAL_DIV_TAXA,         '+
            '  SUM(EXT_STATUS = "T") AS QUANTIDADE_DIV_TAXA,                     '+
            '                                                                    '+
            '  SUM(IF(EXT_STATUS = "B",EXT_VALLIQ,0)) AS TOTAL_DIV_BRUTO,        '+
            '  SUM(EXT_STATUS = "B") AS QUANTIDADE_DIV_BRUTO,                    '+
            '                                                                    '+
            '  SUM(IF(EXT_STATUS = "I",EXT_VALLIQ,0)) AS TOTAL_IGNORADOS,        '+
            '  SUM(EXT_STATUS = "I") AS QUANTIDADE_IGNORADOS,                    '+
            '                                                                    '+
            '  SUM(IF(EXT_STATUS = "N",EXT_VALLIQ,0)) AS TOTAL_NAO_CONFIRMADOS, '+
            '  SUM(EXT_STATUS = "N") AS QUANTIDADE_NAO_CONFIRMADOS,             '+
            '                                                                    '+
            '   SUM(IF(EXT_STATUS = "S",EXT_VALLIQ,0)) AS TOTAL_SIMILARES,       '+
            '   SUM(EXT_STATUS = "S") AS QUANTIDADE_SIMILARES,                   '+
            '                                                                    '+
            '   0.00 AS TOTAL_EXTRATO,                                           '+
            '   0 AS QUANTIDADE_EXTRATO                                          '+
            'FROM                                                                '+
            '  EXTMCA                                                            ';

end;

function TConfirmaCartoes.RetornaSubSelectCfgSis: String;
begin
  Result := '(                                                                  ' +
            '  SELECT                                                           ' +
            '    SIS_CODCFG,                                                    ' +
            '    SIS_VALCFG,                                                    ' +
            '    SIS_CODEMP                                                     ' +
            '  FROM                                                             ' +
            '    CFGSIS                                                         ' +
            '  WHERE                                                            ' +
            '    SIS_CODCFG IN ("CFG_REDEST", "CFG_REDECO", "CFG_PGMKEY")       ' +
            '    AND IFNULL(SIS_VALCFG, "") <> ""                               ' +
            '   GROUP BY SIS_VALCFG                                             ' +
            '   ORDER BY SIS_CODEMP                                             ' +
            ') AS CFGSIS                                                        ';
end;

function TConfirmaCartoes.TemDivergenciaNaTaxa(ATaxaCartao,  ATaxaOperadora, AValorBruto: Double): Boolean;
  Var
    LTaxaValidacao: Double;
    LDiferenca: Double;
begin
  Try
    LTaxaValidacao := ATaxaOperadora;

    If String(fRetornaValorConfiguracao('CFG_VLDTAX',VS_strCodEmp)).Equals('2') Then
      LTaxaValidacao := ATaxaCartao;

    LDiferenca := FExtrato.FieldByName('EXT_VALTAX').AsFloat - fFormataFloat(AValorBruto * (LTaxaValidacao / 100), 2);

    Result := Not fBetween(LDiferenca, -0.039999, 0.0399999);
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

function TConfirmaCartoes.TemDivergenciaNoValorBruto(AValorBruto: Double): Boolean;
  Var
    LDiferenca  : Double;
    LTolerancia : Double;
begin
  Result := False;

  LDiferenca := AValorBruto - FExtrato.FieldByName('EXT_VALBRU').AsFloat;
  LTolerancia := RetornaValorTolerancia(FExtrato.FieldByName('EMP_CODEMP').AsString);

  If Not ((fFormataFloat(LDiferenca, 2) <= LTolerancia) And
          (fFormataFloat(LDiferenca, 2) >= -LTolerancia)) Then
  Begin
    Result := True;
  End;
end;

function TConfirmaCartoes.RetornaValorTolerancia(ACodEmp: String): Double;
begin
  Result := 0;

  If FConciliadora.Equals('REDECARD') Then
  begin
    Result := StrToFloatDef(fRetornaValorConfiguracao('CFG_REDTOL',ACodEmp),0.2999999);
  end
  else if FConciliadora.Equals('PAGAR.ME') then
  begin
    Result := StrToFloatDef(fRetornaValorConfiguracao('CFG_PGMTOL',ACodEmp),0.2999999);
  end;
end;

procedure TConfirmaCartoes.SetConciliadora(const Value: String);
var
  LTipoConciliadora: TTipoConciliadora;
begin
  FConciliadora := Value;
  SetTipoConciliadora(LTipoConciliadora.FromString(FConciliadora));
end;

procedure TConfirmaCartoes.SetTipoConciliadora(const Value: TTipoConciliadora);
begin
  FTipoConciliadora := Value;
  case FTipoConciliadora of
    tcOperadora:
    begin
      FCampoEstabelecimento := 'EXT_NUM_PV';
    end;

    tcMarketPlace:
    begin
      FCampoEstabelecimento := 'EMP_CODEMP';
    end;
  end;
end;

end.
