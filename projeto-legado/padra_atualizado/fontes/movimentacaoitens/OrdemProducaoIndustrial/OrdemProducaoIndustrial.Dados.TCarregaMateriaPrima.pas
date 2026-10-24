unit OrdemProducaoIndustrial.Dados.TCarregaMateriaPrima;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}
  Uni,
  untFuncoesSimples,
{$ENDIF}
  Classes,
  SysUtils,
  System.Generics.Collections,
  OrdemProducaoIndustrial.TMateriaPrima;

Type
  TCarregaMateriaPrima = class
    private
      FQuery: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery{$ENDIF};
    public
      constructor Create;
      destructor Destroy; override;

      procedure pAlimentaListaMateriaPrimaCadastro(strAutoIncremGEIMAT: String; lstMateriasPrimas: TObjectList<TMateriaPrima>);
      procedure pAlimentaListaMateriaPrimaOrdemProducao(strAutoIncremORDGER: String; lstMateriasPrimas: TObjectList<TMateriaPrima>);
  End;

implementation

{ TCarregaMateriaPrima }

constructor TCarregaMateriaPrima.Create;
begin
  FQuery := fCriaQuery;
end;

destructor TCarregaMateriaPrima.Destroy;
begin
 {$IFNDEF LINUX}
  FreeAndNil(FQuery);
 {$ENDIF}
  inherited;
end;

procedure TCarregaMateriaPrima.pAlimentaListaMateriaPrimaCadastro(strAutoIncremGEIMAT : String; lstMateriasPrimas : TObjectList<TMateriaPrima>);
var
  objMateriaPrima : TMateriaPrima;
begin
  FQuery.Close;
  FQuery.SQL.Clear;

  FQuery.SQL.Add('SELECT                                                   ');
  FQuery.SQL.Add('  I.ITE_CODITE             AS CODIGO_PRODUTO,            ');
  FQuery.SQL.Add('  I.ITE_DESITE             AS DESCRICAO_PRODUTO,         ');
  FQuery.SQL.Add('  IFNULL(G.ITE_PRECUS, 0)  AS CUSTO_PRODUTO,             ');
  FQuery.SQL.Add('  IFNULL(G.ITE_PREMED, 0)  AS PRECO_MEDIO,               ');
  FQuery.SQL.Add('  DMT_QTDITE               AS PERCENTUAL                 ');
  FQuery.SQL.Add('FROM                                                     ');
  FQuery.SQL.Add('  DEIMAT                                                 ');
  FQuery.SQL.Add('  INNER JOIN CADITE I ON I.ITE_CODITE = DMT_ITESUB       ');
  FQuery.SQL.Add('  INNER JOIN ITEGER G ON G.ITE_CODITE = DMT_ITESUB       ');
  FQuery.SQL.Add('                     AND G.ITE_CODEMP = :CODIGO_EMPRESA  ');
  FQuery.SQL.Add('WHERE DMT_SEQGER = :SEQUENCIAL_FORMULA                   ');
  FQuery.SQL.Add('ORDER BY DMT_SEQUEN                                      ');

  FQuery.ParamByName('SEQUENCIAL_FORMULA').AsString := strAutoIncremGEIMAT;
  FQuery.ParamByName('CODIGO_EMPRESA').AsString := VS_strCodEmp;
  FQuery.Open;

  FQuery.First;
  while not FQuery.Eof do
  begin
    objMateriaPrima := TMateriaPrima.Create;
    objMateriaPrima.strCodigo := FQuery.FieldByName('CODIGO_PRODUTO').AsString;
    objMateriaPrima.strDescricao :=  FQuery.FieldByName('DESCRICAO_PRODUTO').AsString;
    objMateriaPrima.fltCusto := FQuery.FieldByName('CUSTO_PRODUTO').AsFloat;
    objMateriaPrima.fltPrcMedio := FQuery.FieldByName('PRECO_MEDIO').AsFloat;
    If objMateriaPrima.fltPrcMedio = 0 Then
      objMateriaPrima.fltPrcMedio := objMateriaPrima.fltCusto;
    objMateriaPrima.fltPercentualFormula := FQuery.FieldByName('PERCENTUAL').AsFloat;

    lstMateriasPrimas.Add(objMateriaPrima);
    FQuery.Next;
  end;

  FQuery.Close;
end;

procedure TCarregaMateriaPrima.pAlimentaListaMateriaPrimaOrdemProducao(strAutoIncremORDGER : String; lstMateriasPrimas : TObjectList<TMateriaPrima>);
var
  objMateriaPrima : TMateriaPrima;
begin
  FQuery.Close;
  FQuery.SQL.Clear;

  FQuery.SQL.Add(' SELECT                                           ');
  FQuery.SQL.Add('     ODM_ITESUB AS CODIGO_PRODUTO,                ');
  FQuery.SQL.Add('   F.ITE_DESITE AS DESCRICAO_PRODUTO,             ');
  FQuery.SQL.Add('  (T.DET_TOTCUS / T.DET_QTDITE) AS CUSTO_PRODUTO, ');
  FQuery.SQL.Add('     ODM_QTDITE AS PERCENTUAL                     ');
  FQuery.SQL.Add(' FROM ORDMAT                                      ');
  FQuery.SQL.Add('   INNER JOIN ORDGER G ON G.AUTOINCREM = ODM_SEQGER ');
  FQuery.SQL.Add('   INNER JOIN MOVDET T ON T.AUTOINCREM = ODM_SEQDET ');
  FQuery.SQL.Add('   INNER JOIN CADITE F ON F.ITE_CODITE = ODM_ITESUB ');
  FQuery.SQL.Add(' WHERE ODM_SEQGER = :SEQUENCIAL_ORDEM_PRODUCAO    ');
  FQuery.SQL.Add('   AND ODM_TIPOMP = "FOR"                         ');
  FQuery.SQL.Add('   AND ODM_QTDITE <> 0                            ');

  FQuery.ParamByName('SEQUENCIAL_ORDEM_PRODUCAO').AsString := strAutoIncremORDGER;
  FQuery.Open;

  FQuery.First;
  while not FQuery.Eof do
  begin
    objMateriaPrima := TMateriaPrima.Create;
    objMateriaPrima.strCodigo := FQuery.FieldByName('CODIGO_PRODUTO').AsString;
    objMateriaPrima.strDescricao :=  FQuery.FieldByName('DESCRICAO_PRODUTO').AsString;
    objMateriaPrima.fltCusto := FQuery.FieldByName('CUSTO_PRODUTO').AsFloat;
    objMateriaPrima.fltPercentualFormula := FQuery.FieldByName('PERCENTUAL').AsFloat;

    lstMateriasPrimas.Add(objMateriaPrima);
    FQuery.Next;
  end;

  FQuery.Close;
end;

end.

