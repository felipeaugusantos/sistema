unit untReformaTributariaTipos;

interface

Uses
  System.SysUtils, System.JSON, Data.DB, System.Generics.Collections;

Const
  REFTRIB_STATUS_CALCULADO        = 'CALCULADO';
  REFTRIB_STATUS_ENTRADA_INVALIDA = 'ENTRADA_INVALIDA';
  REFTRIB_STATUS_NAO_APLICAVEL    = 'NAO_APLICAVEL';
  REFTRIB_STATUS_SEM_REGRA        = 'SEM_REGRA';

  REFTRIB_CODIGO_JSON_INVALIDO        = 'JSON_INVALIDO';
  REFTRIB_CODIGO_CAMPO_OBRIGATORIO    = 'CAMPO_OBRIGATORIO';
  REFTRIB_CODIGO_OPERACAO_FORA_ESCOPO = 'OPERACAO_FORA_ESCOPO';
  REFTRIB_CODIGO_REGRA_NAO_ENCONTRADA = 'REGRA_NAO_ENCONTRADA';

Type
  TRefTribCabecalho = Record
    strTipoPessoa       : String;
    strCodigoPessoa     : String;
    strTipoOperacao     : String;
    strCidadeEntrega    : String;
    strCfopsDocumento   : String;
    strVendaPresencial  : String;
    strEspecieDocumento : String;
  End;

  TRefTribItem = Record
    strIdItem              : String;
    strEmpresa             : String;
    strEntregaRetira       : String;
    strCodigoItem          : String;
    strCfop                : String;
    strReferenciaDevolucao : String;
    strOrigemReferencia    : String;
    fltValorItem           : Double;
    fltValorContabil       : Double;
    fltDesconto            : Double;
    fltFrete               : Double;
    fltDespesaAcessoria    : Double;
    fltValorIcms           : Double;
    fltValorPis            : Double;
    fltValorCofins         : Double;
    fltValorFcp            : Double;
    fltValorDifal          : Double;
  End;

  TRefTribRetorno = Record
    intPosicao  : Integer;
    strIdItem   : String;
    strStatus   : String;
    strCodigo   : String;
    strMensagem : String;
    strCodCst : String;
    strClaTri : String;
    fltValOpe : Double;
    fltBasCal : Double;
    fltCbsAlr : Double;
    fltCbsAlq : Double;
    fltCbsVal : Double;
    fltCbsAld : Double;
    fltCbsVld : Double;
    fltCbsVlt : Double;
    fltCbsAle : Double;
    fltIbsUfr : Double;
    fltIbsUfa : Double;
    fltIbsUfv : Double;
    fltIbsUfd : Double;
    fltIbsUvd : Double;
    fltIbsUft : Double;
    fltIbsUfe : Double;
    fltIbsMnr : Double;
    fltIbsMna : Double;
    fltIbsMnv : Double;
    fltIbsMnd : Double;
    fltIbsMvd : Double;
    fltIbsMnt : Double;
    fltIbsMne : Double;
    fltValIbs : Double;
    strSelCst : String;
    strSelCla : String;
    fltSelBas : Double;
    fltSelAlq : Double;
    fltSelVal : Double;
    strTriReg : String;
    strCrePre : String;
    strMonofa : String;
    strVerTri : String;
    fltAliqis : Double;
    Function Calculado : Boolean;
    Function BaseCBS : Double;
    Function ValorCBS : Double;
    Function AliquotaCBS : Double;
    Function BaseIBS : Double;
    Function ValorIBS : Double;
    Function AliquotaIBS : Double;
    Function BaseIS : Double;
    Function ValorIS : Double;
    Function AliquotaIS : Double;
    Function TotalNovosImpostos : Double;
  End;

  TArrRefTribItem = Array Of TRefTribItem;
  TArrRefTribRetorno = Array Of TRefTribRetorno;

  TRefTribCacheEntrada = Record
    recRetorno  : TRefTribRetorno;
    dtaValidade : TDateTime;
  End;

  { A procedure calcula cada item so a partir do cabecalho e do proprio item
    (id_item apenas ecoa), entao o resultado e reaproveitavel por item. Ela le
    cadastros (CADITE, CADNCM, ABFRTE, CADCID...), por isso a entrada expira. }
  TRefTribCache = class
  private
    class var FEntradas : TDictionary<String, TRefTribCacheEntrada>;
    class constructor Create;
    class destructor Destroy;
  public
    class function fChaveItem(const strChaveCabecalho : String; const recItem : TRefTribItem) : String;
    class function fObter(const strChave : String; out recRetorno : TRefTribRetorno; const dtaAgora : TDateTime = 0) : Boolean;
    class procedure pGuardar(const strChave : String; const recRetorno : TRefTribRetorno; const dtaAgora : TDateTime = 0);
    class procedure pLimpar;
    class function fQuantidade : Integer;
  end;

  Function fRefTribJsonCabecalho(const recCabecalho : TRefTribCabecalho; const strCfopDocumentos : String) : TJSONObject;
  Function fRefTribJsonItem(const recItem : TRefTribItem) : TJSONObject;
  Function fRefTribJsonItens(const arrItens : TArrRefTribItem) : TJSONArray;
  Function fRefTribMapearRetorno(const dtsRetorno : TDataSet) : TArrRefTribRetorno;
  Function fRefTribOrigemReferencia(const strTabelaDetalhe : String) : String;

implementation

Uses
  System.DateUtils;

{ Todo valor numerico vai ao JSON com ponto decimal e duas casas, porque o
  FormatSettings local usa virgula e quebraria o JSON. Duas casas bastam: o
  faturamento ja arredonda para 2 antes de persistir, embora valor_pis e
  valor_cofins sejam DECIMAL(65,30) na funcao SQL. }
Function fRefTribNumero(const fltValor : Double) : TJSONNumber;
  Var
    recFormato : TFormatSettings;
begin
  recFormato := TFormatSettings.Invariant;
  Result     := TJSONNumber.Create(FormatFloat('0.00', fltValor, recFormato));
end;

{ TJSONString.Create, e nao AddPair(chave, string): nesta RTL o overload de string
  NAO cria o par quando o valor e vazio, e o campo sumiria do payload. }
Function fRefTribTextoJson(const strValor : String) : TJSONString;
begin
  Result := TJSONString.Create(strValor);
end;

Function fRefTribJsonCabecalho(const recCabecalho : TRefTribCabecalho; const strCfopDocumentos : String) : TJSONObject;
begin
  Result := TJSONObject.Create;
  Try
    Result.AddPair('tipo_operacao',     fRefTribTextoJson(recCabecalho.strTipoOperacao));
    Result.AddPair('especie_documento', fRefTribTextoJson(recCabecalho.strEspecieDocumento));
    Result.AddPair('tipo_pessoa',       fRefTribTextoJson(recCabecalho.strTipoPessoa));
    Result.AddPair('codigo_pessoa',     fRefTribTextoJson(recCabecalho.strCodigoPessoa));
    Result.AddPair('venda_presencial',  fRefTribTextoJson(recCabecalho.strVendaPresencial));
    Result.AddPair('cidade_entrega',    fRefTribTextoJson(recCabecalho.strCidadeEntrega));
    Result.AddPair('cfops_documento',   fRefTribTextoJson(strCfopDocumentos));
  Except
    FreeAndNil(Result);
    Raise;
  End;
end;

Function fRefTribJsonItem(const recItem : TRefTribItem) : TJSONObject;
begin
  Result := TJSONObject.Create;
  Try
    Result.AddPair('id_item',              fRefTribTextoJson(recItem.strIdItem));
    Result.AddPair('empresa',              fRefTribTextoJson(recItem.strEmpresa));
    Result.AddPair('entrega_retira',       fRefTribTextoJson(recItem.strEntregaRetira));
    Result.AddPair('codigo_item',          fRefTribTextoJson(recItem.strCodigoItem));
    Result.AddPair('cfop',                 fRefTribTextoJson(recItem.strCfop));
    Result.AddPair('referencia_devolucao', fRefTribTextoJson(recItem.strReferenciaDevolucao));
    Result.AddPair('origem_referencia',    fRefTribTextoJson(recItem.strOrigemReferencia));
    Result.AddPair('valor_item',           fRefTribNumero(recItem.fltValorItem));
    Result.AddPair('valor_contabil',       fRefTribNumero(recItem.fltValorContabil));
    Result.AddPair('desconto',             fRefTribNumero(recItem.fltDesconto));
    Result.AddPair('frete',                fRefTribNumero(recItem.fltFrete));
    Result.AddPair('despesa_acessoria',    fRefTribNumero(recItem.fltDespesaAcessoria));
    Result.AddPair('valor_icms',           fRefTribNumero(recItem.fltValorIcms));
    Result.AddPair('valor_pis',            fRefTribNumero(recItem.fltValorPis));
    Result.AddPair('valor_cofins',         fRefTribNumero(recItem.fltValorCofins));
    Result.AddPair('valor_fcp',            fRefTribNumero(recItem.fltValorFcp));
    Result.AddPair('valor_difal',          fRefTribNumero(recItem.fltValorDifal));
  Except
    FreeAndNil(Result);
    Raise;
  End;
end;

Function fRefTribJsonItens(const arrItens : TArrRefTribItem) : TJSONArray;
  Var
    intItem : Integer;
begin
  Result := TJSONArray.Create;
  Try
    For intItem := Low(arrItens) To High(arrItens) Do
      Result.AddElement(fRefTribJsonItem(arrItens[intItem]));
  Except
    FreeAndNil(Result);
    Raise;
  End;
end;

Function TRefTribRetorno.Calculado : Boolean;
begin
  Result := (strStatus = REFTRIB_STATUS_CALCULADO);
end;

function TRefTribRetorno.BaseIS: Double;
begin
  If (Self.fltSelVal = 0) Then
    Exit(0);
  Result := Self.fltBasCal;
end;

Function TRefTribRetorno.ValorIS : Double;
begin
  Result := fltSelVal;
end;

function TRefTribRetorno.AliquotaIS: Double;
begin
  If (Self.fltSelVal = 0) Then
    Exit(0);
  Result := Self.fltAliqis;
end;

function TRefTribRetorno.BaseCBS: Double;
begin
  If (Self.fltCbsVal = 0) Then
    Exit(0);
  Result := Self.fltBasCal;
end;

Function TRefTribRetorno.ValorCBS : Double;
begin
  Result := fltCbsVal;
end;

function TRefTribRetorno.AliquotaCBS: Double;
begin
  If (Self.fltCbsVal = 0) Then
    Exit(0);
  If (Self.fltCbsAle = 0) Then
    Result := Self.fltCbsAlq
  Else
    Result := Self.fltCbsAle;
end;

function TRefTribRetorno.BaseIBS: Double;
begin
  If (Self.fltValIbs = 0) Then
    Exit(0);
  Result := Self.fltBasCal;
end;

Function TRefTribRetorno.ValorIBS : Double;
begin
  Result := fltValIbs;
end;

function TRefTribRetorno.AliquotaIBS: Double;
  Var
    fltAliquota : Double;
begin
  If (Self.fltValIbs = 0) Then
    Exit(0);

  If (Self.fltIbsUfe = 0) Then
    fltAliquota := Self.fltIbsUfa
  Else
    fltAliquota := Self.fltIbsUfe;

  If (Self.fltIbsMne = 0) Then
    fltAliquota := fltAliquota + Self.fltIbsMna
  Else
    fltAliquota := fltAliquota + Self.fltIbsMne;

  Result := fltAliquota;
end;

Function TRefTribRetorno.TotalNovosImpostos : Double;
begin
  Result := fltCbsVal + fltValIbs + fltSelVal;
end;

Function fRefTribTexto(const dtsRetorno : TDataSet; const strCampo : String) : String;
  Var
    fldCampo : TField;
begin
  Result   := '';
  fldCampo := dtsRetorno.FindField(strCampo);

  If Not Assigned(fldCampo) Then
    Exit;

  Result := fldCampo.AsString;

  { A procedure projeta os campos de texto com JSON_UNQUOTE, e JSON_UNQUOTE de um
    JSON null devolve o literal "null" em vez de NULL. Sem isto, RET_MENSAGEM
    chega com a palavra null escrita quando o item foi calculado com sucesso. }
  If SameText(Result, 'null') Then
    Result := '';
end;

Function fRefTribValor(const dtsRetorno : TDataSet; const strCampo : String) : Double;
  Var
    fldCampo   : TField;
    recFormato : TFormatSettings;
begin
  Result   := 0;
  fldCampo := dtsRetorno.FindField(strCampo);

  If (Not Assigned(fldCampo)) Or fldCampo.IsNull Then
    Exit;

  { Coluna que chega como texto: o MySQL manda ponto decimal e o AsFloat de campo
    string cai em StrToFloat com o separador local. A leitura tem que ser
    invariante como a escrita. }
  If (fldCampo.DataType In [ftString, ftWideString, ftMemo, ftWideMemo]) Then
  Begin
    recFormato := TFormatSettings.Invariant;
    Result     := StrToFloatDef(fldCampo.AsString, 0, recFormato);
    Exit;
  End;

  Result := fldCampo.AsFloat;
end;

Function fRefTribMapearRetorno(const dtsRetorno : TDataSet) : TArrRefTribRetorno;
  Var
    recRetorno : TRefTribRetorno;
    intLinha   : Integer;
begin
  SetLength(Result, 0);

  If (Not Assigned(dtsRetorno)) Or (Not dtsRetorno.Active) Then
    Exit;

  intLinha := 0;
  dtsRetorno.First;
  While Not dtsRetorno.Eof Do
  Begin
    recRetorno := Default(TRefTribRetorno);

    recRetorno.intPosicao  := Trunc(fRefTribValor(dtsRetorno, 'RET_POSICAO'));
    recRetorno.strIdItem   := fRefTribTexto(dtsRetorno, 'RET_ID_ITEM');
    recRetorno.strStatus   := fRefTribTexto(dtsRetorno, 'RET_STATUS');
    recRetorno.strCodigo   := fRefTribTexto(dtsRetorno, 'RET_CODIGO');
    recRetorno.strMensagem := fRefTribTexto(dtsRetorno, 'RET_MENSAGEM');

    recRetorno.strCodCst := fRefTribTexto(dtsRetorno, 'REF_CODCST');
    recRetorno.strClaTri := fRefTribTexto(dtsRetorno, 'REF_CLATRI');
    recRetorno.fltValOpe := fRefTribValor(dtsRetorno, 'REF_VALOPE');
    recRetorno.fltBasCal := fRefTribValor(dtsRetorno, 'REF_BASCAL');// Base de cálculo dos 3 impostos

    recRetorno.fltCbsAlr := fRefTribValor(dtsRetorno, 'REF_CBSALR');
    recRetorno.fltCbsAlq := fRefTribValor(dtsRetorno, 'REF_CBSALQ');// Alíquota bruta do CBS
    recRetorno.fltCbsVal := fRefTribValor(dtsRetorno, 'REF_CBSVAL');
    recRetorno.fltCbsAld := fRefTribValor(dtsRetorno, 'REF_CBSALD');
    recRetorno.fltCbsVld := fRefTribValor(dtsRetorno, 'REF_CBSVLD');
    recRetorno.fltCbsVlt := fRefTribValor(dtsRetorno, 'REF_CBSVLT');
    recRetorno.fltCbsAle := fRefTribValor(dtsRetorno, 'REF_CBSALE');// Alíquota efetiva do CBS ( se houver redução, caso contrário = zero )

    recRetorno.fltIbsUfr := fRefTribValor(dtsRetorno, 'REF_IBSUFR');
    recRetorno.fltIbsUfa := fRefTribValor(dtsRetorno, 'REF_IBSUFA');// Alíquota Bruta de IBS/UF
    recRetorno.fltIbsUfv := fRefTribValor(dtsRetorno, 'REF_IBSUFV');
    recRetorno.fltIbsUfd := fRefTribValor(dtsRetorno, 'REF_IBSUFD');
    recRetorno.fltIbsUvd := fRefTribValor(dtsRetorno, 'REF_IBSUVD');
    recRetorno.fltIbsUft := fRefTribValor(dtsRetorno, 'REF_IBSUFT');
    recRetorno.fltIbsUfe := fRefTribValor(dtsRetorno, 'REF_IBSUFE');// Alíquota efetiva do IBS/UF ( se houver redução, caso contrário = zero )

    recRetorno.fltIbsMnr := fRefTribValor(dtsRetorno, 'REF_IBSMNR');
    recRetorno.fltIbsMna := fRefTribValor(dtsRetorno, 'REF_IBSMNA');// Alíquota Bruta de IBS/Municipal
    recRetorno.fltIbsMnv := fRefTribValor(dtsRetorno, 'REF_IBSMNV');
    recRetorno.fltIbsMnd := fRefTribValor(dtsRetorno, 'REF_IBSMND');
    recRetorno.fltIbsMvd := fRefTribValor(dtsRetorno, 'REF_IBSMVD');
    recRetorno.fltIbsMnt := fRefTribValor(dtsRetorno, 'REF_IBSMNT');
    recRetorno.fltIbsMne := fRefTribValor(dtsRetorno, 'REF_IBSMNE');// Alíquota efetiva do IBS/MUNICIPAL ( se houver redução, caso contrário = zero )

    recRetorno.fltValIbs := fRefTribValor(dtsRetorno, 'REF_VALIBS');

    recRetorno.strSelCst := fRefTribTexto(dtsRetorno, 'REF_SELCST');
    recRetorno.strSelCla := fRefTribTexto(dtsRetorno, 'REF_SELCLA');
    recRetorno.fltSelBas := fRefTribValor(dtsRetorno, 'REF_SELBAS');
    recRetorno.fltSelAlq := fRefTribValor(dtsRetorno, 'REF_SELALQ');
    recRetorno.fltSelVal := fRefTribValor(dtsRetorno, 'REF_SELVAL');

    recRetorno.strTriReg := fRefTribTexto(dtsRetorno, 'REF_TRIREG');
    recRetorno.strCrePre := fRefTribTexto(dtsRetorno, 'REF_CREPRE');
    recRetorno.strMonofa := fRefTribTexto(dtsRetorno, 'REF_MONOFA');
    recRetorno.strVerTri := fRefTribTexto(dtsRetorno, 'REF_VERTRI');

    recRetorno.fltAliqis := fRefTribValor(dtsRetorno, 'REF_ALIQIS');

    SetLength(Result, intLinha + 1);
    Result[intLinha] := recRetorno;

    Inc(intLinha);
    dtsRetorno.Next;
  End;
end;

{ TRefTribCache }

Const
  REFTRIB_CACHE_VALIDADE_MINUTOS = 5;
  REFTRIB_CACHE_LIMITE           = 2000;

class constructor TRefTribCache.Create;
begin
  FEntradas := TDictionary<String, TRefTribCacheEntrada>.Create;
end;

class destructor TRefTribCache.Destroy;
begin
  FreeAndNil(FEntradas);
end;

class function TRefTribCache.fChaveItem(const strChaveCabecalho : String; const recItem : TRefTribItem) : String;
  Var
    recChave : TRefTribItem;
    jsnItem  : TJSONObject;
begin
  recChave           := recItem;
  recChave.strIdItem := '';
  jsnItem := fRefTribJsonItem(recChave);
  Try
    Result := strChaveCabecalho + '|' + jsnItem.ToJSON;
  Finally
    FreeAndNil(jsnItem);
  End;
end;

class function TRefTribCache.fObter(const strChave : String; out recRetorno : TRefTribRetorno; const dtaAgora : TDateTime) : Boolean;
  Var
    recEntrada : TRefTribCacheEntrada;
    dtaRef     : TDateTime;
begin
  recRetorno := Default(TRefTribRetorno);
  dtaRef := dtaAgora;
  If (dtaRef = 0) Then
    dtaRef := Now;

  TMonitor.Enter(FEntradas);
  Try
    Result := FEntradas.TryGetValue(strChave, recEntrada);
    If Not Result Then
      Exit;

    If (recEntrada.dtaValidade < dtaRef) Then
    Begin
      FEntradas.Remove(strChave);
      Exit(False);
    End;

    recRetorno := recEntrada.recRetorno;
  Finally
    TMonitor.Exit(FEntradas);
  End;
end;

class procedure TRefTribCache.pGuardar(const strChave : String; const recRetorno : TRefTribRetorno; const dtaAgora : TDateTime);
  Var
    recEntrada : TRefTribCacheEntrada;
    dtaRef     : TDateTime;
begin
  dtaRef := dtaAgora;
  If (dtaRef = 0) Then
    dtaRef := Now;

  recEntrada.recRetorno  := recRetorno;
  recEntrada.dtaValidade := IncMinute(dtaRef, REFTRIB_CACHE_VALIDADE_MINUTOS);

  TMonitor.Enter(FEntradas);
  Try
    If (FEntradas.Count >= REFTRIB_CACHE_LIMITE) Then
      FEntradas.Clear;
    FEntradas.AddOrSetValue(strChave, recEntrada);
  Finally
    TMonitor.Exit(FEntradas);
  End;
end;

class procedure TRefTribCache.pLimpar;
begin
  TMonitor.Enter(FEntradas);
  Try
    FEntradas.Clear;
  Finally
    TMonitor.Exit(FEntradas);
  End;
end;

class function TRefTribCache.fQuantidade : Integer;
begin
  TMonitor.Enter(FEntradas);
  Try
    Result := FEntradas.Count;
  Finally
    TMonitor.Exit(FEntradas);
  End;
end;

{ Tabela REF que estende a tabela de detalhe do item referenciado (strTabDev) }
Function fRefTribOrigemReferencia(const strTabelaDetalhe : String) : String;
begin
  If SameText(strTabelaDetalhe, 'MOVDET') Then
    Result := 'MOVREF'
  Else If SameText(strTabelaDetalhe, 'NOTDET') Then
    Result := 'NOTREF'
  Else If SameText(strTabelaDetalhe, 'FATDOR') Then
    Result := 'FDOREF'
  Else
    Result := '';
end;

end.
