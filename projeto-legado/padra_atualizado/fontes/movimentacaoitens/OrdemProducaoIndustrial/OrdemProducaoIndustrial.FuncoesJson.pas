unit OrdemProducaoIndustrial.FuncoesJson;

interface

uses
  Classes,
  Uni,
  SysUtils,
  System.Generics.Collections,
  REST.Json,
  Data.DB,

  untFuncoesSimples,
  OrdemProducaoIndustrial.TOrdemProducao,
  OrdemProducaoIndustrial.Tipos,
  OrdemProducaoIndustrial.Dados.TCarregaCorrecao,
  OrdemProducaoIndustrial.Dados.TCarregaMateriaPrima,
  OrdemProducaoIndustrial.Dados.TCarregaProdutoAcabado,
  OrdemProducaoIndustrial.TFiltroProduto;

  function fGetTOrdemProducaoFromDataBase(strAutoincremORDGER : String; objFiltroProdutoAcabado : TFiltroProduto = nil) : TOrdemProducao;
  procedure pSalvaOrdemProducaoJson(strAutoincremORDGER : String; objOrdemProducao : TOrdemProducao);
  function fGetTOrdemProducaoFromOPJSON(strAutoincremORDGER : String; objFiltroProdutoAcabado :  TFiltroProduto = nil) : TOrdemProducao;
  procedure pSetaOperadorBaixaOrdemProducao(objOrdemProducao: TOrdemProducao);

implementation

function fGetTOrdemProducaoFromDataBase(strAutoincremORDGER : String; objFiltroProdutoAcabado : TFiltroProduto = nil) : TOrdemProducao;
var
  qryOrdemProducao : TUniQuery;

  objCarregaMateriaPrima : TCarregaMateriaPrima;
  objCarregaProdutoAcabado : TCarregaProdutoAcabado;
  objCarregaCorrecao : TCarregaCorrecao;
begin
  qryOrdemProducao := fCriaQuery(nil);
  try
    Result := nil;
    qryOrdemProducao.SQL.Add('SELECT SQL_NO_CACHE                                       ');
    qryOrdemProducao.SQL.Add('  ITE_CODITE        AS CODIGO_PRODUTO_GRANEL,             ');
    qryOrdemProducao.SQL.Add('  ITE_DESITE        AS DESCRICAO_PRODUTO_GRANEL,          ');
    qryOrdemProducao.SQL.Add('  ORD_CODORD        AS CODIGO_ORDEM_PRODUCAO,             ');
    qryOrdemProducao.SQL.Add('  ORD_CODCOR        AS CODIGO_COR,                        ');
    qryOrdemProducao.SQL.Add('  COR_DESCOR        AS DESCRICAO_COR,                     ');
    qryOrdemProducao.SQL.Add('  ORD_DTACAD        AS DATA_CADASTRO,                     ');
    qryOrdemProducao.SQL.Add('  ORD_DTABAI        AS DATA_BAIXA,                        ');
    qryOrdemProducao.SQL.Add('  ORD_CODOPE        AS CODIGO_OPERADOR,                   ');
    qryOrdemProducao.SQL.Add('  OPE_NOMOPE        AS NOME_OPERADOR,                     ');
    qryOrdemProducao.SQL.Add('  ORD_PESREA        AS PESO_REAL,                         ');
    qryOrdemProducao.SQL.Add('  UNI_KILLIT        AS TIPO_MEDIDA                        ');
    qryOrdemProducao.SQL.Add('FROM                                                      ');
    qryOrdemProducao.SQL.Add('  ORDGER                                                  ');
    qryOrdemProducao.SQL.Add('  INNER JOIN CADITE GR  ON GR.ITE_CODITE = ORD_CODITE     ');
    qryOrdemProducao.SQL.Add('  INNER JOIN CADUNI UGR ON UGR.UNI_CODUNI = GR.ITE_CODUNI ');
    qryOrdemProducao.SQL.Add('  INNER JOIN CADCOR     ON COR_CODCOR = ORD_CODCOR        ');
    qryOrdemProducao.SQL.Add('  LEFT JOIN CADOPE      ON ORD_CODOPE = OPE_CODOPE        ');
    qryOrdemProducao.SQL.Add('WHERE ORDGER.AUTOINCREM = :SEQUENCIAL_ORDEM_PRODUCAO      ');

    qryOrdemProducao.ParamByName('SEQUENCIAL_ORDEM_PRODUCAO').AsString := strAutoincremORDGER;
    qryOrdemProducao.Open;

    if not qryOrdemProducao.isEmpty then
    begin
      Result := TOrdemProducao.Create;
      try
        objCarregaMateriaPrima := TCarregaMateriaPrima.Create;
        objCarregaProdutoAcabado := TCarregaProdutoAcabado.Create;
        objCarregaCorrecao := TCarregaCorrecao.Create;
        try
          Result.strAutoincrem := strAutoincremORDGER;
          Result.strCodigo := qryOrdemProducao.FieldByName('CODIGO_ORDEM_PRODUCAO').AsString;
          Result.dtaDataCadastro := qryOrdemProducao.FieldByName('DATA_CADASTRO').AsDateTime;
          Result.dtaDataBaixa := qryOrdemProducao.FieldByName('DATA_BAIXA').AsDateTime;
          Result.strCodigoOperador := qryOrdemProducao.FieldByName('CODIGO_OPERADOR').AsString;
          Result.strNomeOperador := qryOrdemProducao.FieldByName('NOME_OPERADOR').AsString;

          Result.objFormula.objProdutoGranel.strCodigo := qryOrdemProducao.FieldByName('CODIGO_PRODUTO_GRANEL').AsString;
          Result.objFormula.objProdutoGranel.strDescricao := qryOrdemProducao.FieldByName('DESCRICAO_PRODUTO_GRANEL').AsString;
          Result.objFormula.objProdutoGranel.enuMedidaUnidade := fStrToTipoMedidaUnidade(qryOrdemProducao.FieldByName('TIPO_MEDIDA').AsString);
          Result.objFormula.fltPesoReal := qryOrdemProducao.FieldByName('PESO_REAL').AsFloat;

          Result.objFormula.objCor.strCodigo := qryOrdemProducao.FieldByName('CODIGO_COR').AsString;
          Result.objFormula.objCor.strDescricao := qryOrdemProducao.FieldByName('DESCRICAO_COR').AsString;

          objCarregaMateriaPrima.pAlimentaListaMateriaPrimaOrdemProducao(Result.strAutoincrem, Result.objFormula.lstMateriasPrimas);
          objCarregaCorrecao.pAlimentaListaCorrecaoProducao(Result.strAutoincrem, Result.lstCorrecoes);

          objCarregaProdutoAcabado.fltPesoReal := Result.objFormula.fltPesoReal;

          if Assigned(objFiltroProdutoAcabado) then
            objCarregaProdutoAcabado.objFiltroProduto.pClonaObjeto(objFiltroProdutoAcabado);

          objCarregaProdutoAcabado.pAlimentaListaProdutoAcabadoOrdemProducao(Result.strAutoincrem, Result.lstProdutosAcabados);
        finally
          FreeAndNil(objCarregaMateriaPrima);
          FreeAndNil(objCarregaProdutoAcabado);
          FreeAndNil(objCarregaCorrecao);
        end;
      except
        FreeAndNil(Result);
      end;
    end;

  finally
    FreeAndNil(qryOrdemProducao);
  end;
end;

procedure pSetaOperadorBaixaOrdemProducao(objOrdemProducao: TOrdemProducao);
var
  qryOrdemProducao : TUniQuery;

begin
  qryOrdemProducao := fCriaQuery(nil);
  try
    qryOrdemProducao.SQL.Add('SELECT SQL_NO_CACHE                                       ');
    qryOrdemProducao.SQL.Add('  ORD_CODOPE        AS CODIGO_OPERADOR,                   ');
    qryOrdemProducao.SQL.Add('  ORD_OPEBAI        AS CODIGO_OPEBAIXA,                   ');
    qryOrdemProducao.SQL.Add('  CO.OPE_NOMOPE        AS NOME_OPERADOR,                   ');
    qryOrdemProducao.SQL.Add('  CP.OPE_NOMOPE        AS NOME_OPEBAIXA                   ');
    qryOrdemProducao.SQL.Add('FROM                                                      ');
    qryOrdemProducao.SQL.Add('  ORDGER                                                  ');
    qryOrdemProducao.SQL.Add('  LEFT JOIN CADOPE  CO     ON ORD_CODOPE = CO.OPE_CODOPE  ');
    qryOrdemProducao.SQL.Add('  LEFT JOIN CADOPE  CP     ON ORD_OPEBAI = CP.OPE_CODOPE  ');
    qryOrdemProducao.SQL.Add('WHERE ORDGER.AUTOINCREM = :AUTINC_ORDEM_PRODUCAO          ');

    qryOrdemProducao.ParamByName('AUTINC_ORDEM_PRODUCAO').AsString := objOrdemProducao.strAutoincrem;
    qryOrdemProducao.Open;

    if not qryOrdemProducao.isEmpty then
    begin
      objOrdemProducao.strCodigoOperador := qryOrdemProducao.FieldByName('CODIGO_OPERADOR').AsString;
      objOrdemProducao.strNomeOperador := qryOrdemProducao.FieldByName('NOME_OPERADOR').AsString;
      objOrdemProducao.strCodigoOpeBaixa := qryOrdemProducao.FieldByName('CODIGO_OPEBAIXA').AsString;
      objOrdemProducao.strNomeOpeBaixa := qryOrdemProducao.FieldByName('NOME_OPEBAIXA').AsString;
    end;

  finally
    FreeAndNil(qryOrdemProducao);
  end;
end;

procedure pSalvaOrdemProducaoJson(strAutoincremORDGER : String; objOrdemProducao : TOrdemProducao);
var
  qryOPJSON : TUniQuery;
begin
 qryOPJSON := fCriaQuery(nil);
 try
   qryOPJSON.SQL.Text := 'REPLACE INTO OPJSON SET OPJ_SEQGER = :SEQUENCIAL_ORDEM_PRODUCAO, OPJ_JSON__ = :JSON';
   qryOPJSON.ParamByName('SEQUENCIAL_ORDEM_PRODUCAO').AsString := strAutoincremORDGER;
   qryOPJSON.ParamByName('JSON').AsString := TJson.ObjectToJsonString(objOrdemProducao);
   qryOPJSON.ExecSQL;
 finally
   FreeAndNil(qryOPJSON);
 end;

end;

function fGetTOrdemProducaoFromOPJSON(strAutoincremORDGER : String; objFiltroProdutoAcabado :  TFiltroProduto = nil) : TOrdemProducao;
var
  qryOPJSON : TUniQuery;
begin
  qryOPJSON := fCriaQuery(nil);
  try
    Result := nil;

    qryOPJSON.SQL.Add('SELECT                                             ');
    qryOPJSON.SQL.Add('  OPJ_JSON__                                       ');
    qryOPJSON.SQL.Add('FROM                                               ');
    qryOPJSON.SQL.Add('OPJSON                                             ');
    qryOPJSON.SQL.Add('WHERE OPJ_SEQGER = :SEQUENCIAL_ORDEM_PRODUCAO      ');
    qryOPJSON.SQL.Add('  AND OPJ_JSON__ NOT LIKE :PRODUTOS_ACABADOS_VAZIO ');
    qryOPJSON.ParamByName('SEQUENCIAL_ORDEM_PRODUCAO').AsString := strAutoincremORDGER;
    qryOPJSON.ParamByName('PRODUTOS_ACABADOS_VAZIO').AsString := '%"produtosAcabados":{"ownsObjects":true,"listHelper":[0],"items":[]}%';
    qryOPJSON.Open;

    if not qryOPJSON.isEmpty then
    begin
      try
        Result := TJson.JsonToObject<TOrdemProducao>(qryOPJSON.fieldByName('OPJ_JSON__').AsString);
      except
        Result := nil;
      end;
    end;

    if Result = nil then
    begin
      Result := fGetTOrdemProducaoFromDataBase(strAutoincremORDGER, objFiltroProdutoAcabado);
      pSalvaOrdemProducaoJson(strAutoincremORDGER, Result);
    end
    else
      pSetaOperadorBaixaOrdemProducao(Result);

  finally
    FreeAndNil(qryOPJSON);
  end;
end;

end.
