unit OrdemProducaoIndustrial.Dados.TCarregaCorrecao;

interface

uses
  Classes,
  Uni,
  SysUtils,
  System.Generics.Collections,

  untFuncoesSimples,
  OrdemProducaoIndustrial.TCorrecao;

Type
  TCarregaCorrecao = class
    private
      FQuery         : TUniQuery;
    public
      constructor Create;
      destructor Destroy; override;

      procedure pAlimentaListaCorrecaoProducao(strAutoIncremORDGER: String; lstCorrecoes: TObjectList<TCorrecao>);
  End;

implementation

{ TCarregaCorrecao }

constructor TCarregaCorrecao.Create;
begin
  FQuery := fCriaQuery(nil);
end;

destructor TCarregaCorrecao.Destroy;
begin
  FreeAndNil(FQuery);
  inherited;
end;

procedure TCarregaCorrecao.pAlimentaListaCorrecaoProducao(strAutoIncremORDGER : String; lstCorrecoes : TObjectList<TCorrecao>);
var
  objCorrecao : TCorrecao;
begin
  FQuery.Close;
  FQuery.SQL.Clear;

  FQuery.SQL.Add(' SELECT                                             ');
  FQuery.SQL.Add('     ODM_ITESUB AS CODIGO_PRODUTO,                  ');
  FQuery.SQL.Add('   F.ITE_DESITE AS DESCRICAO_PRODUTO,               ');
  FQuery.SQL.Add('  (T.DET_TOTCUS / T.DET_QTDITE) AS CUSTO_PRODUTO,   ');
  FQuery.SQL.Add('   I.ITE_PREMED AS PRECO_MEDIO,                     ');
  FQuery.SQL.Add('     ODM_QTDITE AS QUANTIDADE                       ');
  FQuery.SQL.Add(' FROM ORDMAT                                        ');
  FQuery.SQL.Add('   INNER JOIN ORDGER G ON G.AUTOINCREM = ODM_SEQGER ');
  FQuery.SQL.Add('   INNER JOIN MOVDET T ON T.AUTOINCREM = ODM_SEQDET ');
  FQuery.SQL.Add('   INNER JOIN CADITE F ON F.ITE_CODITE = ODM_ITESUB ');
  FQuery.SQL.Add('   INNER JOIN ITEGER I ON I.ITE_CODITE = ODM_ITESUB ');
  FQuery.SQL.Add('                      AND I.ITE_CODEMP = ORD_CODEMP ');
  FQuery.SQL.Add(' WHERE ODM_SEQGER = :SEQUENCIAL_ORDEM_PRODUCAO      ');
  FQuery.SQL.Add('   AND ODM_TIPOMP = "COR"                           ');
  FQuery.SQL.Add('   AND ODM_QTDITE <> 0                              ');

  FQuery.ParamByName('SEQUENCIAL_ORDEM_PRODUCAO').AsString := strAutoIncremORDGER;
  FQuery.Open;

  FQuery.First;
  while not FQuery.Eof do
  begin
    objCorrecao := TCorrecao.Create;
    objCorrecao.strCodigo := FQuery.FieldByName('CODIGO_PRODUTO').AsString;
    objCorrecao.strDescricao :=  FQuery.FieldByName('DESCRICAO_PRODUTO').AsString;
    objCorrecao.fltCusto := FQuery.FieldByName('CUSTO_PRODUTO').AsFloat;
    objCorrecao.fltQuantidade := FQuery.FieldByName('QUANTIDADE').AsFloat;
    objCorrecao.fltPrcMedio := FQuery.FieldByName('PRECO_MEDIO').AsFloat;
    If objCorrecao.fltPrcMedio = 0 Then
      objCorrecao.fltPrcMedio := objCorrecao.fltCusto;

    lstCorrecoes.Add(objCorrecao);
    FQuery.Next;
  end;

  FQuery.Close;
end;

end.

