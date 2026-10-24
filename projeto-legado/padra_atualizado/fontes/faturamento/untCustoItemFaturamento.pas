unit untCustoItemFaturamento;

interface

uses System.Generics.Collections, DB;

type
  TParBuscaCusto = record
    strCodIte : String;
    strCodEmp : String;
    strTabPre : String;
  end;

  TRecResulCusto = record
    fltPreCus,
    fltIcmSai,
    fltImpFed,
    fltDesOpe,
    fltOutVal: Double;
  end;

  ICustoItemFaturamento = interface
    ['{0250738B-AD84-490D-A340-2857D99D2B4A}']
    function Get(recParBuscaCusto: TParBuscaCusto)                      : TRecResulCusto; overload;
    function Get(strCodIte, strCodEmp, strTabPre: String)               : TRecResulCusto; overload;
    function Get(strCodIte, strCodEmp, strTabPre: String; Field: TField): TRecResulCusto; overload;
  end;

  TCustoItemFaturamento = Class(TInterfacedObject, ICustoItemFaturamento)
  private

  public
    constructor Create;
    destructor Destroy; override;
    class function New: ICustoItemFaturamento;
    function Get(recParBuscaCusto: TParBuscaCusto)                      : TRecResulCusto; overload;
    function Get(strCodIte, strCodEmp, strTabPre: String)               : TRecResulCusto; overload;
    function Get(strCodIte, strCodEmp, strTabPre: String; Field: TField): TRecResulCusto; overload;
  End;

implementation

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  SysUtils, Uni;

{ TCustoItemFaturamento }

constructor TCustoItemFaturamento.Create;
begin
  inherited;
end;

destructor TCustoItemFaturamento.Destroy;
begin
  inherited;
end;

function TCustoItemFaturamento.Get(strCodIte, strCodEmp, strTabPre: String; Field: TField): TRecResulCusto;
begin

  If (Field.DataSet Is TUniQuery) Then
    Exit(Self.Get(strCodIte, strCodEmp, strTabPre));

  If (Field.FieldName = 'ITE_PRECUS') Then
    Result.fltPreCus := Field.AsFloat
  Else If (Field.FieldName = 'ITE_ICMSAI') Then
    Result.fltIcmSai := Field.AsFloat
  Else If (Field.FieldName = 'ITE_IMPFED') Then
    Result.fltImpFed := Field.AsFloat
  Else If (Field.FieldName = 'ITE_DESOPE') Then
    Result.fltDesOpe := Field.AsFloat
  Else If (Field.FieldName = 'ITE_OUTVAL') Then
    Result.fltOutVal := Field.AsFloat;

end;

function TCustoItemFaturamento.Get(strCodIte, strCodEmp, strTabPre: String): TRecResulCusto;
var
  rec: TParBuscaCusto;
begin
  FillChar(rec, SizeOf(rec), #0);

  if fEmptyStr(strTabPre) then
    strTabPre := '1';

  rec.strCodIte := strCodIte;
  rec.strCodEmp := strCodEmp;
  rec.strTabPre := strTabPre;
  Result := Self.Get(rec);
end;

function TCustoItemFaturamento.Get(recParBuscaCusto: TParBuscaCusto): TRecResulCusto;
var
  strCamTab,
  strCodTab,
  strCodEmp : String;
const
  SEMPRE_LER_BANCO = False;
begin

  FillChar(Result, SizeOf(Result), #0);

  strCodEmp := IIF(recParBuscaCusto.strCodEmp.IsEmpty, VS_strCodEmp, recParBuscaCusto.strCodEmp);

  strCamTab := 'ITE_TABPR' + recParBuscaCusto.strTabPre;
  strCodTab := fCampoTabela(strCamTab, 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [recParBuscaCusto.strCodIte, strCodEmp], SEMPRE_LER_BANCO);

  If strCodTab.IsEmpty Then
    Raise Exception.Create('Atenção: Não foi possível identificar a tabela de preço do item "'+recParBuscaCusto.strCodIte+'" para realização do cálculo de custo.');

  Result.fltPreCus := fCampoTabela('T.ITE_PRECUS / IF(IFNULL(F.ITE_CNVCUS, 0) <= 0, 1, F.ITE_CNVCUS) AS ITE_PRECUS',
                                   'TABDET T INNER JOIN ITEFOR F ON F.ITE_CODTAB = T.ITE_CODTAB AND F.ITE_CODITE = T.ITE_CODITE',
                                  ['T.ITE_CODTAB', 'T.ITE_CODITE', 'T.ITE_CODEMP'], [strCodTab, recParBuscaCusto.strCodIte, strCodEmp], SEMPRE_LER_BANCO);

  Result.fltOutVal := fCampoTabela('DETCUS.DET_OUTVAL / IF(IFNULL(F.ITE_CNVCUS, 0) <= 0, 1, F.ITE_CNVCUS) AS ITE_OUTVAL',
                                   'TABDET T INNER JOIN ITEFOR F ON F.ITE_CODTAB = T.ITE_CODTAB AND F.ITE_CODITE = T.ITE_CODITE ' +
                                   ' INNER JOIN DETCUS ON DETCUS.DET_SEQDET = T.AUTOINCREM',
                                  ['T.ITE_CODTAB', 'T.ITE_CODITE', 'T.ITE_CODEMP'], [strCodTab, recParBuscaCusto.strCodIte, strCodEmp], SEMPRE_LER_BANCO);

  Result.fltIcmSai := fCampoTabela('DET_ICMSAI',
                                   'TABDET T INNER JOIN ITEFOR F ON F.ITE_CODTAB = T.ITE_CODTAB AND F.ITE_CODITE = T.ITE_CODITE ' +
                                   ' INNER JOIN DETCUS ON DETCUS.DET_SEQDET = T.AUTOINCREM',
                                  ['T.ITE_CODTAB', 'T.ITE_CODITE', 'T.ITE_CODEMP'], [strCodTab, recParBuscaCusto.strCodIte, strCodEmp], SEMPRE_LER_BANCO);

  Result.fltImpFed := fCampoTabela('ITE_IMPFED', 'TABDET', ['ITE_CODTAB', 'ITE_CODITE', 'ITE_CODEMP'], [strCodTab, recParBuscaCusto.strCodIte, strCodEmp], SEMPRE_LER_BANCO);
  Result.fltDesOpe := fCampoTabela('DET_DESOPE',
                                   'TABDET T INNER JOIN ITEFOR F ON F.ITE_CODTAB = T.ITE_CODTAB AND F.ITE_CODITE = T.ITE_CODITE ' +
                                   ' INNER JOIN DETCUS ON DETCUS.DET_SEQDET = T.AUTOINCREM',
                                  ['T.ITE_CODTAB', 'T.ITE_CODITE', 'T.ITE_CODEMP'], [strCodTab, recParBuscaCusto.strCodIte, strCodEmp], SEMPRE_LER_BANCO);

end;

class function TCustoItemFaturamento.New: ICustoItemFaturamento;
begin
  Result := Self.Create;
end;

end.
