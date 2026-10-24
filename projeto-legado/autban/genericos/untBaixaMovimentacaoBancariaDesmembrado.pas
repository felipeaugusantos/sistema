unit untBaixaMovimentacaoBancariaDesmembrado;

interface

uses
  Generics.Collections, untLogBan;

type
  TFunctionGravaMovBan = function(
    ACodCta, ACodPor, ACodOpe: String;
    ADtaLan: TDateTime;
    ANumDoc, ACreDeb, ACodEmp: String;
    AValLan: Double;
    AHist01, AHist02, ACodCli, ACodFor, ANumDup: String;
    ASeqBai: Integer;
    AParcel, AEmpDup, ASerie, ASeqLan, ACodEve: String;
    ALogBan: TList<TLogBan>;
    ACompet: String;
    APagCon: Integer; const AAutoIncMovBan: String = ''): String of object;

  TDuplicataDesmembrada = record
  private
    FNumero: string;
    FFornecedor: string;
    FSerie: string;
    FEmpresa: string;
    FParcela: string;
    FHistorico2: string;
    FHistorico1: string;
    FCompetencia: string;
  public
    property Numero: string read FNumero write FNumero;
    property Parcela: string read FParcela write FParcela;
    property Fornecedor: string read FFornecedor write FFornecedor;
    property Empresa: string read FEmpresa write FEmpresa;
    property Serie: string read FSerie write FSerie;
    property Historico1: string read FHistorico1 write FHistorico1;
    property Historico2: string read FHistorico2 write FHistorico2;
    property Competencia: string read FCompetencia write FCompetencia;
  end;

  TDesmembramentoDuplicata = record
  private
    FPercentual: Double;
    FDebitoCredito: string;
    FPlanoContas: string;
    FEmpresa: string;
    FCentroCusto: string;
  end;

  TDesmembramentosDuplicata = class(TList<TDesmembramentoDuplicata>)
  private
    FDuplicata: TDuplicataDesmembrada;
    FValorBaixa: Double;
    FDataLancamento: TDatetime;
    FOperadorBaixa: string;
    FPortadorBaixa: string;
    FEmpresaBaixa: string;
    FSequenciaConciliacao: Integer;
    FHistoricoBaixa: string;
    FSaldoDesmembramento: Double;

    function CalcularValorDesmembrado(
      ADesmembramento: TDesmembramentoDuplicata;
      AUltimoRegistro: Boolean;
      out ACreditoDebito: String): Double;
  public
    class function RetornarDemembramentosDeDuplicata(ADuplicata: TDuplicataDesmembrada): TDesmembramentosDuplicata;
    function GerarMovBanParaCadaDesmembramento(AFunctionGravaMovBan: TFunctionGravaMovBan): string;

    property DataLancamento: TDatetime read FDataLancamento write FDataLancamento;
    property ValorBaixa: Double read FValorBaixa write FValorBaixa;
    property PortadorBaixa: string read FPortadorBaixa write FPortadorBaixa;
    property OperadorBaixa: string read FOperadorBaixa write FOperadorBaixa;
    property EmpresaBaixa: string read FEmpresaBaixa write FEmpresaBaixa;
    property HistoricoBaixa: string read FHistoricoBaixa write FHistoricoBaixa;
    property SequenciaConciliacao: Integer read FSequenciaConciliacao write FSequenciaConciliacao;
  end;

implementation

uses
  System.SysUtils, untFuncoesSimples, Uni, untTBanCtpRepository, untCadPag,
  Data.DB;

class function TDesmembramentosDuplicata.RetornarDemembramentosDeDuplicata(
  ADuplicata: TDuplicataDesmembrada): TDesmembramentosDuplicata;
var
  LDesmembramento: TDesmembramentoDuplicata;
  LConsulta: TUniQuery;
begin
  Result := nil;

  LConsulta := fCriaQuery;
  try
    LConsulta.SQL.Add(
      'SELECT '+
        'CTP_FATCAL, '+
        'CTP_DEBCRE, '+
        'CTP_CODCTA, '+
        'CTP_CODEMP, '+
        'CTP_CODEVE  '+
      'FROM '+
        'CTPDET '+
      'WHERE '+
        'CTP_NUMDUP = :CTP_NUMDUP AND '+
        'CTP_PARCEL = :CTP_PARCEL AND '+
        'CTP_CODFOR = :CTP_CODFOR AND '+
        'CTP_EMPORI = :CTP_EMPORI AND '+
        'IFNULL(CTP_SERIE_,"") = :CTP_SERIE_ ');

    LConsulta.ParamByName('CTP_NUMDUP').AsString := ADuplicata.FNumero;
    LConsulta.ParamByName('CTP_PARCEL').AsString := ADuplicata.FParcela;
    LConsulta.ParamByName('CTP_CODFOR').AsString := ADuplicata.FFornecedor;
    LConsulta.ParamByName('CTP_EMPORI').AsString := ADuplicata.FEmpresa;
    LConsulta.ParamByName('CTP_SERIE_').AsString := ADuplicata.FSerie;
    LConsulta.Open;

    if LConsulta.IsEmpty then
      Exit;

    Result := TDesmembramentosDuplicata.Create;
    Result.FDuplicata := ADuplicata;

    while not LConsulta.Eof do
    begin
      LDesmembramento.FPercentual := LConsulta.FieldByName('CTP_FATCAL').AsFloat;
      LDesmembramento.FDebitoCredito := LConsulta.FieldByName('CTP_DEBCRE').AsString;
      LDesmembramento.FPlanoContas := LConsulta.FieldByName('CTP_CODCTA').AsString;
      LDesmembramento.FEmpresa := LConsulta.FieldByName('CTP_CODEMP').AsString;
      LDesmembramento.FCentroCusto := LConsulta.FieldByName('CTP_CODEVE').AsString;

      Result.Add(LDesmembramento);
      LConsulta.Next;
    end;
  finally
    LConsulta.Free;
  end;
end;

function TDesmembramentosDuplicata.CalcularValorDesmembrado(
  ADesmembramento: TDesmembramentoDuplicata;
  AUltimoRegistro: Boolean;
  out ACreditoDebito: string): Double;
begin
  Result := FValorBaixa * ADesmembramento.FPercentual;

  if ADesmembramento.FDebitoCredito = 'D' then
    Result := (Result * -1);

  Result := fFormataFloat(Result, 2);

  FSaldoDesmembramento := FSaldoDesmembramento + Result;

  if (AUltimoRegistro) and (FSaldoDesmembramento <> FValorBaixa) then
    Result := FValorBaixa - (FSaldoDesmembramento - Result);

  ACreditoDebito := 'D';

  if (Result < 0) Then
  begin
    Result := Result * -1;
    ACreditoDebito := 'C';
  end;
end;

function TDesmembramentosDuplicata.GerarMovBanParaCadaDesmembramento(
  AFunctionGravaMovBan: TFunctionGravaMovBan): string;
var
  LDesmembramento: TDesmembramentoDuplicata;
  LIndex,
  LSequenciaBaixa: Integer;
  LValorDesmembrado: Double;
  LBanCtpRepository: TBanCtpRepository;
  LCreditoDebito: String;
  LUltimoRegistro: Boolean;
begin
  Result := '';
  FSaldoDesmembramento := 0;

  for LIndex:=0 to Count-1 do
  begin
    LDesmembramento := Items[LIndex];

    LSequenciaBaixa := untCadPag.fRetSeqBaiCadPag(
      FDuplicata.FNumero,
      FDuplicata.FParcela,
      FDuplicata.FEmpresa,
      FDuplicata.FFornecedor,
      FDuplicata.FSerie);

    LCreditoDebito := '';
    LUltimoRegistro := LIndex = (Count-1);
    LValorDesmembrado := CalcularValorDesmembrado(LDesmembramento, LUltimoRegistro, LCreditoDebito);

    LBanCtpRepository := TBanCtpRepository.Create;
    try
      LBanCtpRepository.pClear;
      LBanCtpRepository.fAdd(
        FDuplicata.FNumero,
        FDuplicata.FParcela,
        FDuplicata.FSerie,
        FDuplicata.FEmpresa,
        FDuplicata.FFornecedor,
        FDuplicata.Historico1,
        FDuplicata.Historico2,
        LDesmembramento.FPlanoContas,
        VS_StrCodEmp,
        LSequenciaBaixa,
        LValorDesmembrado,
        LValorDesmembrado,
        0,
        0,
        0);

      Result := AFunctionGravaMovBan(
        LDesmembramento.FPlanoContas,
        FPortadorBaixa,
        FOperadorBaixa,
        FDataLancamento,
        FDuplicata.FNumero,
        LCreditoDebito,
        FEmpresaBaixa,
        LValorDesmembrado,
        FHistoricoBaixa,
        '',
        '',
        FDuplicata.FFornecedor,
        FDuplicata.FNumero,
        LSequenciaBaixa,
        FDuplicata.FParcela,
        LDesmembramento.FEmpresa,
        FDuplicata.FSerie,
        '',
        LDesmembramento.FCentroCusto,
        LBanCtpRepository.fGetList,
        FDuplicata.FCompetencia,
        FSequenciaConciliacao);
    finally
      FreeAndNil(LBanCtpRepository);
    end;
  end;
end;

end.
