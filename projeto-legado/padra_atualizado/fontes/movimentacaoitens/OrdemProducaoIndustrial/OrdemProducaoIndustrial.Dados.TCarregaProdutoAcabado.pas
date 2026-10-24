unit OrdemProducaoIndustrial.Dados.TCarregaProdutoAcabado;

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

  OrdemProducaoIndustrial.TFiltroProduto,
  OrdemProducaoIndustrial.TProdutoAcabado,
  OrdemProducaoIndustrial.Dados.TCarregaEmbalagem,
  OrdemProducaoIndustrial.Tipos;

Type
  TCarregaProdutoAcabado = class
    private
      FQuery            : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery{$ENDIF};
      FFiltroProduto    : TFiltroProduto;
      FCarregaEmbalagem : TCarregaEmbalagem;

      FPesoReal         : double;
    public
      property fltPesoReal: double               read FPesoReal            write FPesoReal;
      property objFiltroProduto : TFiltroProduto read FFiltroProduto       write FFiltroProduto;

      constructor Create;
      destructor Destroy; override;

      procedure pAlimentaListaProdutoAcabadoCadastro(strCodigoProdutoGranel, strCodigoCor : String; lstProdutosAcabados : TObjectList<TProdutoAcabado>);
      procedure pAlimentaListaProdutoAcabadoOrdemProducao(strAutoincremORDGER : String; lstProdutosAcabados : TObjectList<TProdutoAcabado>);
  End;

implementation

{ TCarregaProdutoAcabado }

constructor TCarregaProdutoAcabado.Create;
begin
  FPesoReal := 0;
  FQuery := fCriaQuery;
  FFiltroProduto := TFiltroProduto.Create;
  FCarregaEmbalagem := TCarregaEmbalagem.Create;
end;

destructor TCarregaProdutoAcabado.Destroy;
begin
 {$IFNDEF LINUX}
  FreeAndNil(FQuery);
 {$ENDIF}
  FreeAndNil(FFiltroProduto);
  FreeAndNil(FCarregaEmbalagem);
  inherited;
end;

procedure TCarregaProdutoAcabado.pAlimentaListaProdutoAcabadoCadastro(strCodigoProdutoGranel, strCodigoCor : String; lstProdutosAcabados : TObjectList<TProdutoAcabado>);
var
  objProdutoAcabado : TProdutoAcabado;
begin
  FQuery.Close;
  FQuery.SQL.Clear;

  FQuery.SQL.Add('SELECT                                                                ');
  FQuery.SQL.Add('  ITE_CODITE              AS CODIGO_PRODUTO,                          ');
  FQuery.SQL.Add('  ITE_DESITE              AS DESCRICAO_PRODUTO,                       ');
  FQuery.SQL.Add('  ITE_CODCOR              AS CODIGO_CORCOR,                           ');
  FQuery.SQL.Add('  ITE_CODCOM              AS CODIGO_COMPOSICAO,                       ');
  FQuery.SQL.Add('  GERCOM.AUTOINCREM       AS AUTOINCREM_COMPOSICAO,                   ');
  FQuery.SQL.Add('  GCO_DESCOM              AS DESCRICAO_COMPOSICAO,                    ');
  FQuery.SQL.Add('  IFNULL(UNI_KILLIT, "K") AS KILO_LITRO,                              ');
  FQuery.SQL.Add('  IFNULL(UNI_PESLIT, 0)   AS PESO_VOLUME                              ');
  FQuery.SQL.Add('FROM                                                                  ');
  FQuery.SQL.Add('  CADITE                                                              ');
  FQuery.SQL.Add('  INNER JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI                        ');
  FQuery.SQL.Add('  LEFT  JOIN GERCOM ON GCO_CODCOM = ITE_CODCOM                        ');
  FQuery.SQL.Add('WHERE ITE_CODPAG = :CODIGO_PRODUTO_GRANEL                             ');
  FQuery.SQL.Add('  AND ITE_CODCOR = :CODIGO_COR                                        ');

  If Not fEmptyStr(FFiltroProduto.strCodigo) Then
    FQuery.SQL.Add(' AND ITE_CODITE IN (' + FFiltroProduto.strCodigo + ')               ');

  If Not fEmptyStr(FFiltroProduto.strLinhaGrupo) Then
    FQuery.SQL.Add(' AND ITE_CODGRU IN (' + FFiltroProduto.strLinhaGrupo + ')           ');

  If Not fEmptyStr(FFiltroProduto.strCodigoDepartamento) Then
    FQuery.SQL.Add(' AND ITE_CODDEP IN (' + FFiltroProduto.strCodigoDepartamento + ')   ');

  If Not fEmptyStr(FFiltroProduto.strCodigoMarca) Then
    FQuery.SQL.Add(' AND ITE_CODMAR IN (' + FFiltroProduto.strCodigoMarca + ')   ');

  If Not fEmptyStr(FFiltroProduto.strReferencia) Then
    FQuery.SQL.Add(' AND ITE_REFERE = ' + QuotedStr(FFiltroProduto.strReferencia)        );

  If (FFiltroProduto.blnApenasAtivo) Then
    FQuery.SQL.Add(' AND ITE_ITEATI = "S"                                               ');

  FQuery.SQL.Add('ORDER BY  ITE_CODITE                                                  ');

  FQuery.ParamByName('CODIGO_PRODUTO_GRANEL').AsString := strCodigoProdutoGranel;
  FQuery.ParamByName('CODIGO_COR').AsString := strCodigoCor;

  FQuery.Open;

  FQuery.First;
  while not FQuery.Eof do
  begin
    objProdutoAcabado := TProdutoAcabado.Create;
    objProdutoAcabado.strCodigo := FQuery.FieldByName('CODIGO_PRODUTO').AsString;
    objProdutoAcabado.strDescricao := FQuery.FieldByName('DESCRICAO_PRODUTO').AsString;
    objProdutoAcabado.enuMedidaUnidade := fStrToTipoMedidaUnidade(FQuery.FieldByName('KILO_LITRO').AsString);
    objProdutoAcabado.fltPesoLitro := FQuery.FieldByName('PESO_VOLUME').AsFloat;
    objProdutoAcabado.fltPesoReal := FPesoReal;

    if FQuery.FieldByName('AUTOINCREM_COMPOSICAO').AsString <> '' then
    begin
      objProdutoAcabado.objComposicao.strCodigo := FQuery.FieldByName('CODIGO_COMPOSICAO').AsString;
      objProdutoAcabado.objComposicao.strDescricao := FQuery.FieldByName('DESCRICAO_COMPOSICAO').AsString;
      FCarregaEmbalagem.pAlimentaListaEmbalagensCadastro(FQuery.FieldByName('AUTOINCREM_COMPOSICAO').AsString, objProdutoAcabado.objComposicao.lstEmbalagens);
    end;

    lstProdutosAcabados.add(objProdutoAcabado);
    FQuery.Next;
  end;

end;

procedure TCarregaProdutoAcabado.pAlimentaListaProdutoAcabadoOrdemProducao(strAutoincremORDGER: String; lstProdutosAcabados: TObjectList<TProdutoAcabado>);
var
  objProdutoAcabado : TProdutoAcabado;
begin
  FQuery.Close;
  FQuery.SQL.Clear;

  FQuery.SQL.Add('SELECT                                                                ');
  FQuery.SQL.Add('  ITE_CODITE              AS CODIGO_PRODUTO,                          ');
  FQuery.SQL.Add('  ITE_DESITE              AS DESCRICAO_PRODUTO,                       ');
  FQuery.SQL.Add('  ITE_CODCOR              AS CODIGO_CORCOR,                           ');
  FQuery.SQL.Add('  ITE_CODCOM              AS CODIGO_COMPOSICAO,                       ');
  FQuery.SQL.Add('  GERCOM.AUTOINCREM       AS AUTOINCREM_COMPOSICAO,                   ');
  FQuery.SQL.Add('  GCO_DESCOM              AS DESCRICAO_COMPOSICAO,                    ');
  FQuery.SQL.Add('  IFNULL(UNI_KILLIT, "K") AS KILO_LITRO,                              ');
  FQuery.SQL.Add('  IFNULL(UNI_PESLIT, 0)   AS PESO_VOLUME,                             ');
  FQuery.SQL.Add('  IFNULL(ORD_QTDPRO, 0)   AS QUANTIDADE_PRODUZIDA,                    ');
  FQuery.SQL.Add('  IFNULL(ORD_QTDENV, 0)   AS QUANTIDADE_ENVASADA                      ');
  FQuery.SQL.Add('FROM                                                                  ');
  FQuery.SQL.Add('  ORDDET                                                              ');
  FQuery.SQL.Add('  INNER JOIN CADITE ON ITE_CODITE = ORD_CODITE                        ');
  FQuery.SQL.Add('  INNER JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI                        ');
  FQuery.SQL.Add('  LEFT  JOIN GERCOM ON GCO_CODCOM = ITE_CODCOM                        ');
  FQuery.SQL.Add('WHERE ORD_SEQGER = :SEQUENCIAL_ORDEM_PRODUCAO                         ');

  If Not fEmptyStr(FFiltroProduto.strCodigo) Then
    FQuery.SQL.Add(' AND ITE_CODITE IN (' + FFiltroProduto.strCodigo + ')               ');

  If Not fEmptyStr(FFiltroProduto.strLinhaGrupo) Then
    FQuery.SQL.Add(' AND ITE_CODGRU IN (' + FFiltroProduto.strLinhaGrupo + ')           ');

  If Not fEmptyStr(FFiltroProduto.strCodigoDepartamento) Then
    FQuery.SQL.Add(' AND ITE_CODDEP IN (' + FFiltroProduto.strCodigoDepartamento + ')   ');

  If Not fEmptyStr(FFiltroProduto.strCodigoMarca) Then
    FQuery.SQL.Add(' AND ITE_CODMAR IN (' + FFiltroProduto.strCodigoMarca + ')   ');

  If Not fEmptyStr(FFiltroProduto.strReferencia) Then
    FQuery.SQL.Add(' AND ITE_REFERE = ' + QuotedStr(FFiltroProduto.strReferencia)        );

  If (FFiltroProduto.blnApenasAtivo) Then
    FQuery.SQL.Add(' AND ITE_ITEATI = "S"                                               ');

  FQuery.SQL.Add('ORDER BY  ITE_CODITE                                                  ');

  FQuery.ParamByName('SEQUENCIAL_ORDEM_PRODUCAO').AsString := strAutoincremORDGER;

  FQuery.Open;

  FQuery.First;
  while not FQuery.Eof do
  begin
    objProdutoAcabado := TProdutoAcabado.Create;
    objProdutoAcabado.strCodigo := FQuery.FieldByName('CODIGO_PRODUTO').AsString;
    objProdutoAcabado.strDescricao := FQuery.FieldByName('DESCRICAO_PRODUTO').AsString;
    objProdutoAcabado.enuMedidaUnidade := fStrToTipoMedidaUnidade(FQuery.FieldByName('KILO_LITRO').AsString);
    objProdutoAcabado.fltPesoLitro := FQuery.FieldByName('PESO_VOLUME').AsFloat;
    objProdutoAcabado.fltQuantidadeProduzida := FQuery.FieldByName('QUANTIDADE_PRODUZIDA').AsFloat;
    objProdutoAcabado.fltQuantidadeEnvasada := FQuery.FieldByName('QUANTIDADE_ENVASADA').AsFloat;
    objProdutoAcabado.fltPesoReal := FPesoReal;

    objProdutoAcabado.objComposicao.strCodigo := FQuery.FieldByName('CODIGO_COMPOSICAO').AsString;
    objProdutoAcabado.objComposicao.strDescricao := FQuery.FieldByName('DESCRICAO_COMPOSICAO').AsString;
    FCarregaEmbalagem.pAlimentaListaEmbalagensOrdemProducao(strAutoincremORDGER, objProdutoAcabado.strCodigo, objProdutoAcabado.objComposicao.lstEmbalagens);

    lstProdutosAcabados.add(objProdutoAcabado);
    FQuery.Next;
  end;

end;

end.
