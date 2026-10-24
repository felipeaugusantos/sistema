unit Garantia.TValidacaoEspelhoXML;

interface

uses
  Classes,
  SysUtils,
  System.Generics.Collections,
  System.Variants,
  Data.DB,
  vcl.Graphics,

  untObjectListHelper,
  Garantia.TItemValidacaoEspelhoXML,
  Garantia.TItemNotaRecebimentoCliente,
  Garantia.TValidacaoNotaRecebimentoCliente,
  Garantia.TCdsValidacaoEspelhoXML;

Type

  TValidacaoEspelhoXML = class
    private
      FItens: TObjectListHelper<TItemValidacaoEspelhoXML>;
      FEspelho: TDataSet;
      FXML: TDataSet;
      FCdsItens: TCdsValidacaoEspelhoXML;
    public
      Const
        COR_FUNDO_ERRO = $00CCCCFF;
        COR_FONTE_XML = $00710000;
        COR_FONTE_ESPELHO = $00005900;

        PARAMETRO_XML = 'AUTOINCREM_GERELE';
        PARAMETRO_AD = 'CODIGO_AD';

      property lstItens: TObjectListHelper<TItemValidacaoEspelhoXML> read FItens write FItens;
      property dtsEspelho : TDataSet read FEspelho write FEspelho;
      property dtsXML : TDataSet read FXML write FXML;
      property cdsItens : TCdsValidacaoEspelhoXML read FCdsItens write FCdsItens;

      procedure pCarregaItens();
      procedure pCarregaXML(objXml: TItemNotaRecebimentoCliente);
      procedure pCarregaEspelho(objEspelho: TItemNotaRecebimentoCliente);
      procedure pAlimentaCdsItens;
      procedure pAdicionaItemCds(i : Integer; objItem: TItemNotaRecebimentoCliente; objValidacao: TValidacaoNotaRecebimentoCliente);

      function fRetornaItemListaEspelho(strCodigoItem: String): TItemValidacaoEspelhoXML;
      function fRetornaCorFundoCelula( corFundo : TColor; varValidacao : Variant ) : TColor;
      function fRetornaCorFonteCelula(varTipo: Variant): TColor;
      function fRetornaSQLXml : String;
      function fRetornaSQLEspelho: String;
      function fExisteDivergencia : Boolean;

      constructor Create();
      destructor Destroy(); override;

  End;

implementation

{ TValidacaoEspelhoXML }

constructor TValidacaoEspelhoXML.Create;
begin
  FItens := TObjectListHelper<TItemValidacaoEspelhoXML>.Create();
  FCdsItens := TCdsValidacaoEspelhoXML.Create(nil);
end;

destructor TValidacaoEspelhoXML.Destroy;
begin
  FreeAndNil(FItens);
  FreeAndNil(FCdsItens);
  inherited;
end;

procedure TValidacaoEspelhoXML.pCarregaXML(objXml : TItemNotaRecebimentoCliente);
begin

  objXml.strCodigo := dtsXML.FieldByName('DET_CODITE').AsString;
  objXml.strCodigoFabrica := dtsXML.FieldByName('ITE_CODFAB').AsString;
  objXml.strDescricao := dtsXML.FieldByName('ITE_DESITE').AsString;
  objXml.strReferencia := dtsXML.FieldByName('ITE_REFERE').AsString;
  objXml.strSiglaUnidade := dtsXML.FieldByName('UNI_SIGUNI').AsString;

  objXml.fltValorBruto := dtsXML.FieldByName('I11_VPROD').AsFloat;
  objXml.fltQuantidade := dtsXML.FieldByName('I10_QCOM').AsFloat;

  objXml.fltBaseCalculoICMS := dtsXML.FieldByName('N15_VBC').AsFloat;
  objXml.fltAliquotaICMS := dtsXML.FieldByName('N16_PICMS').AsFloat;
  objXml.fltValorICMS := dtsXML.FieldByName('N17_VICMS').AsFloat;

  objXml.fltBaseCalculoSubstituicaoTributaria := dtsXML.FieldByName('N21_VBCST').AsFloat;
  objXml.fltValorSubstituicaoTributaria := dtsXML.FieldByName('N23_VICMSST').AsFloat;

  objXml.fltBaseCalculoIPI := dtsXML.FieldByName('O10_VBC').AsFloat;
  objXml.fltAliquotaIPI := dtsXML.FieldByName('O13_PIPI').AsFloat;
  objXml.fltValorIPI := dtsXML.FieldByName('O14_VIPI').AsFloat;

  objXml.strClassificacaoFiscal := dtsXML.FieldByName('I08_CFOP').AsString;
  objXML.strCST := dtsXML.FieldByName('DET_CSTXML').AsString;
  objXML.fltDesconto := dtsXML.FieldByName('I17_VDESC').AsFloat;

  objXML.fltBaseCalculoFundoCombatePobrezaST := dtsXML.FieldByName('N23A_VBCFCPST').AsFloat;
  objXML.fltAliquotaFundoCombatePobrezaST := dtsXML.FieldByName('N23B_PFCPST').AsFloat;
  objXML.fltValorFundoCombatePobrezaST := dtsXML.FieldByName('N23D_FCPST').AsFloat;

  objXML.fltBaseCalculoFundoCombatePobreza := dtsXML.FieldByName('N17A_VBCFCP').AsFloat;
  objXML.fltAliquotaFundoCombatePobreza := dtsXML.FieldByName('N17B_PFCP').AsFloat;
  objXML.fltValorFundoCombatePobreza := dtsXML.FieldByName('N17C_VFCP').AsFloat;

end;

procedure TValidacaoEspelhoXML.pAlimentaCdsItens;
var
  objItem : TItemValidacaoEspelhoXML;
  i : Integer;
begin
  i := 1;
  for objItem in FItens do
  begin
    pAdicionaItemCds(i, objItem.objItemXML, objItem.objValidacao);
    pAdicionaItemCds(i, objItem.objItemEspelho, objItem.objValidacao);
    inc(i);
  end;
end;

procedure TValidacaoEspelhoXML.pAdicionaItemCds(i : Integer; objItem : TItemNotaRecebimentoCliente; objValidacao : TValidacaoNotaRecebimentoCliente);
begin
  FCdsItens.Insert;

  FCdsItens.FieldByName('TIPO').AsInteger := objItem.intTipo;
  FCdsItens.FieldByName('CODIGO_PRODUTO').AsString := objItem.strCodigo;
  FCdsItens.FieldByName('CODIGO_FABRICA').AsString := objItem.strCodigoFabrica;
  FCdsItens.FieldByName('DESCRICAO_PRODUTO').AsString := objItem.strDescricao;
  FCdsItens.FieldByName('REFERENCIA').AsString := objItem.strReferencia;
  FCdsItens.FieldByName('SIGLA_UNIDADE').AsString := objItem.strSiglaUnidade;

  FCdsItens.FieldByName('VALOR_BRUTO').AsFloat := objItem.fltValorBruto;
  FCdsItens.FieldByName('QUANTIDADE').AsFloat := objItem.fltQuantidade;

  FCdsItens.FieldByName('BASE_ICMS').AsFloat := objItem.fltBaseCalculoICMS;
  FCdsItens.FieldByName('ALIQUOTA_ICMS').AsFloat := objItem.fltAliquotaICMS;
  FCdsItens.FieldByName('VALOR_ICMS').AsFloat := objItem.fltValorICMS;

  FCdsItens.FieldByName('BASE_SUBSTITUICAO_TRIBUTARIA').AsFloat := objItem.fltBaseCalculoSubstituicaoTributaria;
  FCdsItens.FieldByName('VALOR_SUBSTITUICAO_TRIBUTARIA').AsFloat := objItem.fltValorSubstituicaoTributaria;

  FCdsItens.FieldByName('BASE_IPI').AsFloat := objItem.fltBaseCalculoIPI;
  FCdsItens.FieldByName('ALIQUOTA_IPI').AsFloat := objItem.fltAliquotaIPI;
  FCdsItens.FieldByName('VALOR_IPI').AsFloat := objItem.fltValorIPI;

  FCdsItens.FieldByName('CLASSIFICACAO_FISCAL').AsString := objItem.strClassificacaoFiscal;
  FCdsItens.FieldByName('SEQUENCIAL').AsInteger := i;
  FCdsItens.FieldByName('CST').AsString := objItem.strCST;
  FCdsItens.FieldByName('DESCONTO').AsFloat := objItem.fltDesconto;

  FCdsItens.FieldByName('BASE_FUNDO_COMBATE_POBREZA_ST').AsFloat := objItem.fltBaseCalculoFundoCombatePobrezaST;
  FCdsItens.FieldByName('ALIQUOTA_FUNDO_COMBATE_POBREZA_ST').AsFloat := objItem.fltAliquotaFundoCombatePobrezaST;
  FCdsItens.FieldByName('VALOR_FUNDO_COMBATE_POBREZA_ST').AsFloat := objItem.fltValorFundoCombatePobrezaST;

  FCdsItens.FieldByName('BASE_FUNDO_COMBATE_POBREZA').AsFloat := objItem.fltBaseCalculoFundoCombatePobreza;
  FCdsItens.FieldByName('ALIQUOTA_FUNDO_COMBATE_POBREZA').AsFloat := objItem.fltAliquotaFundoCombatePobreza;
  FCdsItens.FieldByName('VALOR_FUNDO_COMBATE_POBREZA').AsFloat := objItem.fltValorFundoCombatePobreza;

  FCdsItens.FieldByName('VALIDACAO_DESCRICAO').AsBoolean := objValidacao.blnDescricao;
  FCdsItens.FieldByName('VALIDACAO_VALOR_BRUTO').AsBoolean := objValidacao.blnValorBruto;
  FCdsItens.FieldByName('VALIDACAO_QUANTIDADE').AsBoolean := objValidacao.blnQuantidade;

  FCdsItens.FieldByName('VALIDACAO_BASE_ICMS').AsBoolean := objValidacao.blnBaseCalculoICMS;
  FCdsItens.FieldByName('VALIDACAO_ALIQUOTA_ICMS').AsBoolean := objValidacao.blnAliquotaICMS;
  FCdsItens.FieldByName('VALIDACAO_VALOR_ICMS').AsBoolean := objValidacao.blnValorICMS;

  FCdsItens.FieldByName('VALIDACAO_BASE_SUBSTITUICAO_TRIBUTARIA').AsBoolean := objValidacao.blnBaseCalculoSubstituicaoTributaria;
  FCdsItens.FieldByName('VALIDACAO_VALOR_SUBSTITUICAO_TRIBUTARIA').AsBoolean := objValidacao.blnValorSubstituicaoTributaria;

  FCdsItens.FieldByName('VALIDACAO_BASE_IPI').AsBoolean := objValidacao.blnBaseCalculoIPI;
  FCdsItens.FieldByName('VALIDACAO_ALIQUOTA_IPI').AsBoolean := objValidacao.blnAliquotaIPI;
  FCdsItens.FieldByName('VALIDACAO_VALOR_IPI').AsBoolean := objValidacao.blnValorIPI;

  FCdsItens.FieldByName('VALIDACAO_CST').AsBoolean := objValidacao.blnCST;
  FCdsItens.FieldByName('VALIDACAO_DESCONTO').AsBoolean := objValidacao.blnDesconto;

  FCdsItens.FieldByName('VALIDACAO_BASE_FUNDO_COMBATE_POBREZA_ST').AsBoolean := objValidacao.blnBaseCalculoFundoCombatePobrezaST;
  FCdsItens.FieldByName('VALIDACAO_ALIQUOTA_FUNDO_COMBATE_POBREZA_ST').AsBoolean := objValidacao.blnAliquotaFundoCombatePobrezaST;
  FCdsItens.FieldByName('VALIDACAO_VALOR_FUNDO_COMBATE_POBREZA_ST').AsBoolean := objValidacao.blnValorFundoCombatePobrezaST;

  FCdsItens.FieldByName('VALIDACAO_BASE_FUNDO_COMBATE_POBREZA').AsBoolean := objValidacao.blnBaseCalculoFundoCombatePobreza;
  FCdsItens.FieldByName('VALIDACAO_ALIQUOTA_FUNDO_COMBATE_POBREZA').AsBoolean := objValidacao.blnAliquotaFundoCombatePobreza;
  FCdsItens.FieldByName('VALIDACAO_VALOR_FUNDO_COMBATE_POBREZA').AsBoolean := objValidacao.blnValorFundoCombatePobreza;

  FCdsItens.FieldByName('VALIDACAO_CLASSIFICACAO_FISCAL').AsBoolean := objValidacao.blnClassificacaoFiscal;
  FCdsItens.FieldByName('VALIDO').AsBoolean := not objValidacao.fExisteInconscistencia;

  FCdsItens.Post;

end;

procedure TValidacaoEspelhoXML.pCarregaEspelho(objEspelho : TItemNotaRecebimentoCliente);
begin

  objEspelho.strCodigo := dtsEspelho.FieldByName('DET_CODITE').AsString;
  objEspelho.strCodigoFabrica := dtsEspelho.FieldByName('ITE_CODFAB').AsString;
  objEspelho.strDescricao := dtsEspelho.FieldByName('ITE_DESITE').AsString;
  objEspelho.strReferencia := dtsEspelho.FieldByName('ITE_REFERE').AsString;
  objEspelho.strSiglaUnidade := dtsEspelho.FieldByName('UNI_SIGUNI').AsString;

  objEspelho.fltValorBruto := dtsEspelho.FieldByName('DET_TOTITE').AsFloat;
  objEspelho.fltQuantidade := dtsEspelho.FieldByName('DET_QTDITE').AsFloat;

  objEspelho.fltBaseCalculoICMS := dtsEspelho.FieldByName('DET_BASICM').AsFloat;
  objEspelho.fltAliquotaICMS := dtsEspelho.FieldByName('DET_ALQICM').AsFloat;
  objEspelho.fltValorICMS := dtsEspelho.FieldByName('DET_VALICM').AsFloat;

  objEspelho.fltBaseCalculoSubstituicaoTributaria := dtsEspelho.FieldByName('DET_BASRET').AsFloat;
  objEspelho.fltValorSubstituicaoTributaria := dtsEspelho.FieldByName('DET_VALRET').AsFloat;

  objEspelho.fltBaseCalculoIPI := dtsEspelho.FieldByName('DET_BASIPI').AsFloat;
  objEspelho.fltAliquotaIPI := dtsEspelho.FieldByName('DET_ALQIPI').AsFloat;
  objEspelho.fltValorIPI := dtsEspelho.FieldByName('DET_VALIPI').AsFloat;

  objEspelho.strClassificacaoFiscal := dtsEspelho.FieldByName('DET_CLAFIS').AsString;
  objEspelho.strCST := dtsEspelho.FieldByName('DET_CODFIS').AsString;
  objEspelho.fltDesconto := dtsEspelho.FieldByName('DET_DESESP').AsFloat;

  objEspelho.fltBaseCalculoFundoCombatePobrezaST := dtsEspelho.FieldByName('DET_BFCPST').AsFloat;
  objEspelho.fltAliquotaFundoCombatePobrezaST := dtsEspelho.FieldByName('DET_PFCPST').AsFloat;
  objEspelho.fltValorFundoCombatePobrezaST := dtsEspelho.FieldByName('DET_VFCPST').AsFloat;

  objEspelho.fltBaseCalculoFundoCombatePobreza := dtsEspelho.FieldByName('DET_BASFCP').AsFloat;
  objEspelho.fltAliquotaFundoCombatePobreza := dtsEspelho.FieldByName('DET_PERFCP').AsFloat;
  objEspelho.fltValorFundoCombatePobreza := dtsEspelho.FieldByName('DET_VALFCP').AsFloat;

end;

procedure TValidacaoEspelhoXML.pCarregaItens();
var
   objItem : TItemValidacaoEspelhoXML;
begin
  FItens.Clear;

  dtsXML.First;
  while not dtsXML.eof do
  begin
    objItem := TItemValidacaoEspelhoXML.Create();
    pCarregaXML(objItem.objItemXML);
    FItens.Add(objItem);

    dtsXML.Next;
  end;

  dtsEspelho.First;
  while not dtsEspelho.eof do
  begin
    objItem := fRetornaItemListaEspelho(dtsEspelho.FieldByName('DET_CODITE').AsString);
    pCarregaEspelho(objItem.objItemEspelho);

    dtsEspelho.Next;
  end;


  for objItem in FItens do
  begin
    objItem.pNormalizaEspelhoXML;
    objItem.pValidacao;
  end;

end;

function TValidacaoEspelhoXML.fRetornaCorFundoCelula( corFundo : TColor; varValidacao: Variant): TColor;
begin

  if VarType(varValidacao) <> varBoolean then
    raise Exception.Create('O valor da validação deve ser booleano!');

  if varValidacao then
    Result := corFundo
  else
    Result := COR_FUNDO_ERRO;

end;

function TValidacaoEspelhoXML.fExisteDivergencia: Boolean;
begin
  Result := FItens.anyMatch( function ( element : TItemValidacaoEspelhoXML) : boolean
                             begin
                               Result := element.blnExisteInconscistencia;
                             end);
end;

function TValidacaoEspelhoXML.fRetornaCorFonteCelula( varTipo : Variant ): TColor;
begin
  if VarType(varTipo) <> varInteger then
    raise Exception.Create('O tipo deve ser inteiro!');

  if varTipo = TItemValidacaoEspelhoXML.IDENTIFICADOR_XML then
    Result := COR_FONTE_XML
  else
    Result := COR_FONTE_ESPELHO;

end;

function TValidacaoEspelhoXML.fRetornaItemListaEspelho(strCodigoItem : String) : TItemValidacaoEspelhoXML ;
begin
  Result := FItens.findFirst(function ( element : TItemValidacaoEspelhoXML ) : boolean
                             begin
                               Result := element.objItemXML.strCodigo = strCodigoItem;
                             end);

  if not Assigned(Result) then
  begin
    Result := TItemValidacaoEspelhoXML.Create();
    FItens.Add(Result);
  end;
end;

function TValidacaoEspelhoXML.fRetornaSQLXml: String;
var
 sql : TStringList;
begin
  sql := TStringList.Create();
  try
    sql.Add('SELECT'                                                 );
    sql.Add('  DETELE.*,'                                            );
    sql.Add('  B08_NNF,'                                             );
    sql.Add('  ITE_CODITE,'                                          );
    sql.Add('  ITE_DESITE,'                                          );
    sql.Add('  ITE_REFERE,'                                          );
    sql.Add('  ITE_CODFAB,'                                          );
    sql.Add('  UNI_SIGUNI'                                           );
    sql.Add('FROM'                                                   );
    sql.Add('  DETELE'                                               );
    sql.Add('  INNER JOIN GERELE ON GERELE.AUTOINCREM = DET_SEQGER'  );
    sql.Add('  INNER JOIN CADITE ON ITE_CODITE = DET_CODITE'         );
    sql.Add('  LEFT JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI'          );
    sql.Add('WHERE'                                                  );
    sql.Add('  DET_SEQGER = :'+PARAMETRO_XML                         );

    Result := sql.Text;
  finally
    FreeAndNil(sql);
  end;

end;

function TValidacaoEspelhoXML.fRetornaSQLEspelho: String;
var
 sql : TStringList;
begin
  sql := TStringList.Create();
  try
    sql.Add('SELECT'                                                 );
    sql.Add('  ESPDET.*,'                                            );
    sql.Add('  GER_NUMESP,'                                          );
    sql.Add('  GER_CODCLI,'                                          );
    sql.Add('  MOVDET.DET_VLRCON,'                                   );
    sql.Add('  ITE_CODITE,'                                          );
    sql.Add('  ITE_DESITE,'                                          );
    sql.Add('  ITE_REFERE,'                                          );
    sql.Add('  ITE_CODFAB,'                                          );
    sql.Add('  UNI_SIGUNI'                                           );
    sql.Add('FROM'                                                   );
    sql.Add('  ESPGER'                                               );
    sql.Add('  INNER JOIN ESPDET ON DET_SEQGER = ESPGER.AUTOINCREM'  );
    sql.Add('  INNER JOIN CADITE ON ITE_CODITE = DET_CODITE'         );
    sql.Add('  LEFT JOIN MOVDET ON MOVDET.AUTOINCREM = DET_SEQDET'   );
    sql.Add('  LEFT JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI'          );
    sql.Add('WHERE'                                                  );
    sql.Add('  GER_CODADE = :'+PARAMETRO_AD                          );

    Result := sql.Text;
  finally
    FreeAndNil(sql);
  end;

end;

end.
