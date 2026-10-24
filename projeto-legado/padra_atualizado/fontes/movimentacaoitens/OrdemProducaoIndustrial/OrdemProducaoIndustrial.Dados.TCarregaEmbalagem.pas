unit OrdemProducaoIndustrial.Dados.TCarregaEmbalagem;

interface

uses
  Classes,
  SysUtils,
  System.Generics.Collections,
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}
  Uni,
  untFuncoesSimples,
{$ENDIF}
  OrdemProducaoIndustrial.TEmbalagem,
  OrdemProducaoIndustrial.Tipos;

Type
  TCarregaEmbalagem = class
    private
      FQuery         : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery{$ENDIF};
    public
      constructor Create;
      destructor Destroy; override;

      procedure pAlimentaListaEmbalagensCadastro(strAutoIncremGERCOM : String; lstEmbalagens : TObjectList<TEmbalagem>);
      procedure pAlimentaListaEmbalagensOrdemProducao(strAutoIncremORDGER, strCodigoItem: String; lstEmbalagens: TObjectList<TEmbalagem>);
  End;

implementation

{ TCarregaEmbalagem }

constructor TCarregaEmbalagem.Create;
begin
  FQuery := fCriaQuery;
end;

destructor TCarregaEmbalagem.Destroy;
begin
{$IFNDEF LINUX}
  FreeAndNil(FQuery);
{$ENDIF}
  inherited;
end;

procedure TCarregaEmbalagem.pAlimentaListaEmbalagensCadastro(strAutoIncremGERCOM : String; lstEmbalagens : TObjectList<TEmbalagem>);
var
  objEmbalagem : TEmbalagem;
begin
  FQuery.Close;
  FQuery.SQL.Clear;

  FQuery.SQL.Add('SELECT                                                   ');
  FQuery.SQL.Add('  I.ITE_CODITE             AS CODIGO_PRODUTO,            ');
  FQuery.SQL.Add('  I.ITE_DESITE             AS DESCRICAO_PRODUTO,         ');
  FQuery.SQL.Add('  IFNULL(I.ITE_PESOIT, 0)  AS PESO_PRODUTO,              ');
  FQuery.SQL.Add('  IFNULL(G.ITE_PRECUS, 0)  AS CUSTO_PRODUTO,             ');
  FQuery.SQL.Add('  IFNULL(G.ITE_PREMED, 0)  AS PRECO_MEDIO,               ');
  FQuery.SQL.Add('  IFNULL(UNI_ITEFRA, "S")  AS UNIDADE_FRACIONADA,        ');
  FQuery.SQL.Add('  DCO_QTDITE               AS QUANTIDADE                 ');
  FQuery.SQL.Add('FROM                                                     ');
  FQuery.SQL.Add('  DETCOM                                                 ');
  FQuery.SQL.Add('  INNER JOIN CADITE I ON I.ITE_CODITE = DCO_CODITE       ');
  FQuery.SQL.Add('  INNER JOIN CADUNI   ON UNI_CODUNI = I.ITE_CODUNI       ');
  FQuery.SQL.Add('  INNER JOIN ITEGER G ON G.ITE_CODITE = DCO_CODITE       ');
  FQuery.SQL.Add('                     AND G.ITE_CODEMP = :CODIGO_EMPRESA  ');
  FQuery.SQL.Add('WHERE DCO_SEQGER = :SEQUENCIAL_COMPOSICAO                ');
  FQuery.SQL.Add('ORDER BY DCO_SEQUEN                                      ');

  FQuery.ParamByName('SEQUENCIAL_COMPOSICAO').AsString := strAutoIncremGERCOM;
  FQuery.ParamByName('CODIGO_EMPRESA').AsString := VS_strCodEmp;
  FQuery.Open;

  FQuery.First;
  while not FQuery.Eof do
  begin
    objEmbalagem := TEmbalagem.Create(fStrToTipoArredondamentoComposicao(fCfgSis('COMFRA', varString)), FQuery.FieldByName('UNIDADE_FRACIONADA').AsString = 'S');
    objEmbalagem.strCodigo := FQuery.FieldByName('CODIGO_PRODUTO').AsString;
    objEmbalagem.strDescricao :=  FQuery.FieldByName('DESCRICAO_PRODUTO').AsString;
    objEmbalagem.fltCusto := FQuery.FieldByName('CUSTO_PRODUTO').AsFloat;
    objEmbalagem.fltPeso := FQuery.FieldByName('PESO_PRODUTO').AsFloat;
    objEmbalagem.fltQuantidade := FQuery.FieldByName('QUANTIDADE').AsFloat;
    objEmbalagem.fltPrcMedio := FQuery.FieldByName('PRECO_MEDIO').AsFloat;
    If objEmbalagem.fltPrcMedio = 0 Then
      objEmbalagem.fltPrcMedio := objEmbalagem.fltCusto;

    lstEmbalagens.Add(objEmbalagem);
    FQuery.Next;
  end;

  FQuery.Close;
end;

procedure TCarregaEmbalagem.pAlimentaListaEmbalagensOrdemProducao(strAutoIncremORDGER, strCodigoItem : String; lstEmbalagens : TObjectList<TEmbalagem>);
var
  objEmbalagem : TEmbalagem;
begin
  FQuery.Close;
  FQuery.SQL.Clear;

  FQuery.SQL.Add('SELECT                                                 ');
  FQuery.SQL.Add('  ITE_CODITE            AS CODIGO_PRODUTO,             ');
  FQuery.SQL.Add('  ITE_DESITE            AS DESCRICAO_PRODUTO,          ');
  FQuery.SQL.Add('  IFNULL(ITE_PESOIT, 0) AS PESO_PRODUTO,               ');
  FQuery.SQL.Add('  ODC_VLRCUS            AS CUSTO_PRODUTO,              ');
  FQuery.SQL.Add('  UNI_ITEFRA            AS UNIDADE_FRACIONADA,         ');
  FQuery.SQL.Add('  ODC_QTDITE            AS QUANTIDADE                  ');
  FQuery.SQL.Add('FROM                                                   ');
  FQuery.SQL.Add('  ORDDET                                               ');
  FQuery.SQL.Add('  INNER JOIN ORDCOM ON ODC_SEQDET = ORDDET.AUTOINCREM  ');
  FQuery.SQL.Add('  INNER JOIN CADITE ON ITE_CODITE = ODC_CODITE         ');
  FQuery.SQL.Add('  INNER JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI         ');
  FQuery.SQL.Add('WHERE ORD_SEQGER = :SEQUENCIAL_ORDEM_PRODUCAO          ');
  FQuery.SQL.Add('  AND ORD_CODITE = :CODIGO_PRODUTO                     ');

  FQuery.ParamByName('SEQUENCIAL_ORDEM_PRODUCAO').AsString := strAutoIncremORDGER;
  FQuery.ParamByName('CODIGO_PRODUTO').AsString := strCodigoItem;
  FQuery.Open;

  FQuery.First;
  while not FQuery.Eof do
  begin
    objEmbalagem := TEmbalagem.Create(fStrToTipoArredondamentoComposicao(fCfgSis('COMFRA', varString)), FQuery.FieldByName('UNIDADE_FRACIONADA').AsString = 'S');
    objEmbalagem.strCodigo := FQuery.FieldByName('CODIGO_PRODUTO').AsString;
    objEmbalagem.strDescricao := FQuery.FieldByName('DESCRICAO_PRODUTO').AsString;
    objEmbalagem.fltCusto := FQuery.FieldByName('CUSTO_PRODUTO').AsFloat;
    objEmbalagem.fltPeso := FQuery.FieldByName('PESO_PRODUTO').AsFloat;
    objEmbalagem.fltQuantidade := FQuery.FieldByName('QUANTIDADE').AsFloat;

    lstEmbalagens.Add(objEmbalagem);
    FQuery.Next;
  end;

  FQuery.Close;
end;

end.

