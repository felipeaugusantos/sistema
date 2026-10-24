unit ImportaVendasPagarMe.Classes;

interface

uses System.SysUtils, System.Generics.Collections, System.Classes, Vcl.Forms,
     System.StrUtils,

     cxProgressBar, Uni,

     ImportaVendasCartao.Interfaces, untTExtratoConfirmaCartoes,
     untTLibCartoesFuncoes, untLibCartoesConstantes;

type
  TImportaVendasPagarMe = class(TInterfacedObject, IImportacaoVendasCartao)
  private
    FDataInicial:        TDateTime;
    FDataFinal:          TDateTime;
    FExtratoVendas:      TList<TDadosVendas>;
    FImportou:           Boolean;
    FConfiguaracaoChaveApi: String;
    function  RetornaSQLVendas: String;
    procedure ChamaImportacao;
    procedure PreencheParametroData(AQuery: TUniQuery);
    procedure PreencheDadosVenda(var ADadosVenda: TDadosVendas; AQuery: TUniQuery);
  public
    constructor Create;
    destructor Destroy; override;
    class function New: IImportacaoVendasCartao;
    function  DataInicial(AValue: TDateTime): IImportacaoVendasCartao; overload;
    function  DataInicial: TDateTime; overload;
    function  DataFinal(AValue: TDateTime): IImportacaoVendasCartao; overload;
    function  DataFinal: TDateTime; overload;
    function  ExtratoVendas: TList<TDadosVendas>;
    procedure ImportarVendasCartao;
    function  GerarExtratoVendasImportadas(pgbProgresso: TcxProgressBar): Boolean;
    function  Importou: Boolean;
  end;

implementation

{ TImportaVendasPagarMe }

uses System.DateUtils;

constructor TImportaVendasPagarMe.Create;
begin
  FExtratoVendas := TList<TDadosVendas>.Create;
  FImportou := False;
  FConfiguaracaoChaveApi := '"CFG_PGMKEY"';
end;

function TImportaVendasPagarMe.DataFinal(
  AValue: TDateTime): IImportacaoVendasCartao;
begin
  Result := Self;
  FDataFinal := AValue;
end;

function TImportaVendasPagarMe.DataFinal: TDateTime;
begin
  Result := FDataFinal;
end;

function TImportaVendasPagarMe.DataInicial: TDateTime;
begin
  Result := FDataInicial;
end;

function TImportaVendasPagarMe.DataInicial(
  AValue: TDateTime): IImportacaoVendasCartao;
begin
  Result := Self;
  FDataInicial := AValue;
end;

destructor TImportaVendasPagarMe.Destroy;
begin
  inherited;
end;

function TImportaVendasPagarMe.ExtratoVendas: TList<TDadosVendas>;
begin
  Result := FExtratoVendas;
end;

function TImportaVendasPagarMe.GerarExtratoVendasImportadas(pgbProgresso: TcxProgressBar): Boolean;
var
  LQuery:       TUniQuery;
  LDadosVendas: TDadosVendas;
begin
  Result := True;
  LQuery := VS_FuncoesExternas.fICriaQuery;
  FExtratoVendas.Clear;

  try
    LQuery.SQL.Text := RetornaSQLVendas;
    PreencheParametroData(LQuery);
    LQuery.Open;
    LQuery.First;

    pgbProgresso.Position := 0;
    pgbProgresso.Properties.Max := LQuery.RecordCount;

    while not LQuery.EOF do
    begin
      PreencheDadosVenda(LDadosVendas, LQuery);
      FExtratoVendas.Add(LDadosVendas);
      LQuery.Next;
      TLibCartoesFuncoes.pStepStatusGravacao(pgbProgresso);
    end;
  except
    On E: Exception do
      raise Exception.Create('Problemas ao gerar extrato das vendas importadas. ' +
                             E.Message);
  end;
end;

procedure TImportaVendasPagarMe.ImportarVendasCartao;
begin
  ChamaImportacao;
end;

function TImportaVendasPagarMe.Importou: Boolean;
begin
  Result := FImportou;
end;

class function TImportaVendasPagarMe.New: IImportacaoVendasCartao;
begin
 Result := Self.Create;
end;

procedure TImportaVendasPagarMe.ChamaImportacao;
begin
  untLibCartoesConstantes.MenuImportacaoCartoes.Find('Importação Pagar.Me').Click;
  If Assigned(TLibCartoesFuncoes.FDadosImportacaoConfirmacao) Then
  Begin
    FImportou := TLibCartoesFuncoes.FDadosImportacaoConfirmacao.ImportouVendas;
    FDataInicial := TLibCartoesFuncoes.FDadosImportacaoConfirmacao.DataInicial;
    FDataFinal   := TLibCartoesFuncoes.FDadosImportacaoConfirmacao.DataFinal;
  End;
end;

procedure TImportaVendasPagarMe.PreencheDadosVenda(var ADadosVenda: TDadosVendas;
 AQuery: TUniQuery);
var
  LAutorizacao,
  LNsu,
  LBandeira: String;
  LNumPar: Integer;
const
  CREDITO = 'credit_card';
  DEBITO = 'debit_card';
begin
  LNumPar         := StrToIntDef(AQuery.FieldByName('PGM_NUMPAR').AsString, 1);
  LBandeira       := TLibCartoesFuncoes.RetornaNomeBandeira(AQuery.FieldByName('PGM_NUMCAR').AsString);

  if not (AQuery.FieldByName('PGM_METPAG').AsString.Equals(CREDITO) or
          AQuery.FieldByName('PGM_METPAG').AsString.Equals(DEBITO)) then
  begin
    LAutorizacao    := RightStr(Trim(AQuery.FieldByName('PGM_NUMPOK').AsString), 6);
    LNsu            := TLibCartoesFuncoes.fStrZero(LAutorizacao, 14);
    LBandeira       := AQuery.FieldByName('PGM_METPAG').AsString.ToUpper;
  end
  else
  begin
    LAutorizacao    := Trim(RightStr(AQuery.FieldByName('PGM_CODAUT').AsString, 6));
    LNsu            := TLibCartoesFuncoes.fStrZero(Trim(RightStr(AQuery.FieldByName('PGM_NUMNSU').AsString, 14)), 14);
  end;

  ADadosVenda.Estabelecimento := AQuery.FieldByName('PGM_KEYAPI').AsString;
  ADadosVenda.Autorizacao     := LAutorizacao;
  ADadosVenda.Nsu             := LNsu;
  ADadosVenda.Parcela         := TLibCartoesFuncoes.fGetLetraAlfa(LNumPar);
  ADadosVenda.Cartao          := AQuery.FieldByName('PGM_NUMCAR').AsString;
  ADadosVenda.Bandeira        := LBandeira;
  ADadosVenda.Status          := 'N';
  ADadosVenda.Operador        := VS_FuncoesExternas.fIRetOperadorLogado;
  ADadosVenda.NomeOperadora   := 'PAGAR.ME';

  ADadosVenda.DataTransacao   := StrToDateTime(AQuery.FieldByName('PGM_DTAPAG').AsString);
  ADadosVenda.DataVencimento  := StrToDateTime(AQuery.FieldByName('PGM_DTAVEN').AsString);
  ADadosVenda.DataImportacao  := VS_FuncoesExternas.fIGetVS_Date;

  ADadosVenda.ValorBruto      := AQuery.FieldByName('PGM_BRUPAR').AsFloat;
  ADadosVenda.ValorTaxa       := AQuery.FieldByName('PGM_TAXPAR').AsFloat;
  ADadosVenda.ValorLiquido    := AQuery.FieldByName('LIQPAR').AsFloat;
end;

procedure TImportaVendasPagarMe.PreencheParametroData(AQuery: TUniQuery);
begin
  AQuery.ParamByName('DTAINI').AsDateTime := FDataInicial;
  AQuery.ParamByName('DTAFIN').AsDateTime := FDataFinal;
end;

function TImportaVendasPagarMe.RetornaSQLVendas: String;
begin
  Result := 'SELECT                                                          ' +
            '  REC.PGM_ID_REC,                                               ' +
            '  COB.PGM_ID_COB,                                               ' +
            '  COB.PGM_GATWAY,                                               ' +
            '  COB.PGM_NUMPAR,                                               ' +
            '  COB.PGM_BRUPAR,                                               ' +
            '  REC.PGM_TAXPAR,                                               ' +
            '  (COB.PGM_BRUPAR - REC.PGM_TAXPAR) AS LIQPAR,                  ' +
            '  REC.PGM_TAXPAR,                                               ' +
            '  REC.PGM_TAXANT,                                               ' +
            '  REC.PGM_TAXFRA,                                               ' +
            '  COB.PGM_DTAPAG,                                               ' +
            '  REC.PGM_DTAVEN,                                               ' +
            '  COB.PGM_METPAG,                                               ' +
            '  COB.PGM_KEYAPI,                                               ' +
            '  SIS_CODEMP,                                                   ' +
            '  COB.PGM_CODAUT,                                               ' +
            '  COB.PGM_NUMNSU,                                               ' +
            '  COB.PGM_NUMPOK,                                               ' +
            '  COB.PGM_NUMCAR                                                ' +
            'FROM                                                            ' +
            '  PGM_PMCOBR AS COB                                             ' +
            '  INNER JOIN PGM_PMRECE AS REC                                  ' +
            '    ON (COB.PGM_ID_COB = REC.PGM_ID_COB                         ' +
            '        AND COB.PGM_NUMPAR = REC.PGM_NUMPAR                     ' +
            '        AND IFNULL(REC.PGM_ID_COB, "") <> ""                    ' +
            '        AND COB.PGM_KEYAPI = REC.PGM_KEYAPI)                    ' +
            '  LEFT JOIN                                                     ' +
            '    (SELECT                                                     ' +
            '      SIS_CODCFG,                                               ' +
            '      SIS_VALCFG,                                               ' +
            '      SIS_CODEMP                                                ' +
            '    FROM                                                        ' +
            '      CFGSIS                                                    ' +
            '    WHERE SIS_CODCFG = '+ FConfiguaracaoChaveApi + ' AND        ' +
            '          IFNULL(SIS_VALCFG, "") <> ""                          ' +
            '    GROUP BY SIS_VALCFG                                         ' +
            '    ORDER BY SIS_CODEMP) AS CFGSIS                              ' +
            '    ON SIS_VALCFG = COB.PGM_KEYAPI                              ' +
            'WHERE REC.PGM_TIPREC = "credit" AND                             ' +
            '      COB.PGM_STATUS = "paid"   AND                             ' +
            '      REC.PGM_DTACAD BETWEEN :DTAINI AND :DTAFIN                ' +
            'GROUP BY COB.PGM_ID_COB, COB.PGM_NUMPAR                         ' +
            'ORDER BY COB.PGM_ID_COB, COB.PGM_NUMPAR                         ';
end;

end.
