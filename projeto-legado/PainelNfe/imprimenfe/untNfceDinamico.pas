unit untNfceDinamico;

{
  Impressao dinamica da NFC-e 80 mm (provedor CUPOM_FISCAL): XML autorizado como
  fonte principal e a consulta da rotina (@DOC) como apoio.
}

interface

uses
{$IF Defined(LINUX)}
  FMX.frxClass, FMX.frxDBSet,
{$ELSE}
  frxClass, frxDBSet,
{$IFEND}
  SysUtils, Classes, Variants, DB, Contnrs, XMLIntf,
  untUniClientDataSet, untNfsDinamico;

const
  // provedor reservado (criado pelo script 004)
  cstProvedorCupomFiscal = 'CUPOM_FISCAL';
  // dataset de itens (CDS_NOMCDS = CDS_NOMFRX = UserName usado pelo fr3)
  cstCdsItensNFCe = 'frxNFce';
  // dataset das variaveis
  cstCdsCabecalhoNFCe = 'Cabecalho';
  // funcoes (FLD_FUNC) da NFC-e - lista do editor (untImpNfdFields)
  cstFuncoesNFCe: array[0..21] of String = ('SEDEST', 'NOMEEMP', 'ENDEMP', 'CODPROMO',
    'CNPJCPF', 'CEP', 'FONE', 'CHAVE4', 'DATA', 'HORA', 'DATAHORA(dd/mm/yyyy hh:nn:ss)',
    'DTAEMI', 'CONDPAG', 'MODALIDADES', 'VALORESMOD', 'TROCO', 'TROCO(TEXTO)', 'TPAGDESC',
    'INFCOMPL', 'TRIBUTOS', 'REIMPRESSAO', 'ENTRADA(NETPOINTS)');

type
  // dados da nota informados por TImpressaoNFCe (nao e dono do dsDoc nem do relatorio)
  TNfceDinEntrada = class
  public
    strProvedor: String;
    strXml: String;
    strAcesso: String;
    strCodEmp: String;
    strNumDoc: String;
    strEspDoc: String;
    strSerie: String;
    dsDoc: TDataSet;         // consulta da rotina (qryTmp) = fonte @DOC
    frxReport: TfrxReport;   // relatorio ja carregado (existencia de objetos/variaveis)
    blnReimpressao: Boolean;
    // valores calculados pela rotina (uma vez por nota)
    strInfCplDoc: String;
    strModalidadesDoc: String;
    strValoresDoc: String;
    strCarConPag: String;
    strParcelasCartao: String;
    strDescrCartao: String;
    strIdePro: String;
    strDocsCred: String;
    strSldCred: String;
    strDtaVen: String;
    intQtdNps: Integer;
    intQtdSelos: Integer;
    fltCashBack: Double;
    lstErros: TStrings;      // opcional (teste): recebe tambem os erros gravados na LOGERR
    constructor Create;
  end;

  TNfceDinContexto = class(TNfdContexto)
  private
    FEntrada: TNfceDinEntrada;
    FblnPrmOk: Boolean;
    FstrPrmItens, FstrPrmPagto, FstrPrmInfCpl: String;
    procedure pCarregaParametros;
    function fNo(const ACaminho: String): IXMLNode;
    function fXml(const ACaminho: String): String;
    function fTemDest: Boolean;
    function fObjetoExiste(const ANome: String): Boolean;
    function fVariavelExiste(const ANome: String): Boolean;
    function fCampoDoc(const ANome: String): TField;
    function fModalidadesXml(AValores: Boolean): String;
    function fTributos(const AInfAdFisco: String): String;
  public
    constructor Create(AEntrada: TNfceDinEntrada);
    function fPrm(const ANome: String): String;
    function fMarcador(const ANome: String; out AValor: Variant): Boolean; override;
    function fDataSetDoc(const ANome: String): TDataSet; override;
    function fAplicaFuncao(const AFuncao: String; AParams: TStrings; const AValor: Variant;
      AEncontrado: Boolean; AField: TField; const ANoRegistro: IXMLNode; AIndice: Integer): Boolean; override;
    procedure pGravaErro(const AOrigem, AMensagem: String); override;
    function fChaveAcesso: String; override;
    function fCaminhoBase(const ANomCds, ACamBas: String): String; override;
    function fLigaXmlDriverDoc(const ANomCds: String): Boolean; override;
    function fNormalizaChave(const AColuna: String; const AValor: Variant): Variant; override;
    function fAceitaVariavel(const ANome: String): Boolean; override;
  end;

  TNfceDinamico = class
  private
    FEntrada: TNfceDinEntrada;
    FContexto: TNfceDinContexto;
    FlstNomes: TStringList;   // CDS_NOMCDS, na ordem de CDS_ORDEM
    FlstCampos: TObjectList;  // um TObjectList (de TNfdCampo) por dataset
    FlstFrx: TObjectList;     // TfrxDBDataset (dono)
    FlstCds: TObjectList;     // TUniClientDataSet (dono)
    FarrDefs: array of TNfdDefCds;
    FXmlDoc: IXMLDocument;
    FReport: TfrxReport;      // so referencia (o dono e TImpressaoNFCe)
    procedure pLiberaDataSets;
  public
    constructor Create(AEntrada: TNfceDinEntrada);
    destructor Destroy; override;
    class function fDisponivel(const AProvedor: String): Boolean;
    // estrutura ANTES da carga do fr3 (as bandas ligam pelo nome do dataset)
    procedure pCriarEstrutura(AReport: TfrxReport);
    // preenchimento DEPOIS da carga do fr3 (datasets e variaveis)
    procedure pPreencher;
    function fDataSet(const ANome: String): TUniClientDataSet;
    // comparador do editor (rotina antiga x nova)
    class procedure pFotografa(ADataSet: TDataSet; AReport: TfrxReport; AFoto: TStrings);
    class procedure pComparar(AFotoAntiga, AFotoNova, AResultado: TStrings; out ANaoEsperadas: Integer);
  end;

implementation

uses
{$IF Defined(UNIDAC)}
  Uni,
{$ELSE}
  ZDataset,
{$IFEND}
  StrUtils, XMLDoc, ACBrUtil, untUtil;

type
  TQueryNfceDin = {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};

const
  cstVariaveisNFCe: array[0..41] of String = ('PROFIS', 'CODDIV', 'NOMDIV', 'NOMEMP',
    'NMEFAN', 'CNPJ', 'IE', 'IM', 'ENDEMP', 'CEPEMP', 'TELEMP', 'TELEM2', 'NUMDOC',
    'SERIE_', 'DTAEMI', 'ACESSO', 'PROTOC', 'DPROTO', 'NOMVEN', 'INF_COMPLEMENTAR',
    'CONDICAO_PAGAMENTO', 'MODALIDADES', 'VALORES_MOD', 'HOMEPA', 'DTAVEN',
    'PARCELAS_CARTAO', 'TOTAL_TRIBUTOS', 'TROCO_', 'QTDNPS', 'QTDSELOS', 'VENCSH',
    'PTOVEN', 'PTOSLD', 'DOCSCRED', 'SLDCRED', 'MSGNFC', 'IDEPRO', 'FN1VEN', 'FN2VEN',
    'EMAVEN', 'MensagemReimpressao', 'DESCRICAO_CARTAO');

  cstObjetosNFCe: array[0..2] of String = ('rllConsumidor', 'rllCliCon', 'rllEnderecoConsulta');

  // divergencias esperadas entre a rotina antiga (cadastro) e a nova (XML)
  cstEsperadas = ';R.DESITE;R.DESORI;R.CGCCON;R.NOMCON;R.NOMFAN;R.BAICON;R.CEPCON;' +
    'R.TELCON;R.CELCON;R.IESCON;R.ENDERE;R.ENDNUM;R.ENDCOM;R.ESTCON;R.CIDCON;' +
    'V.NUMDOC;V.SERIE_;V.TOTAL_TRIBUTOS;V.MODALIDADES;V.VALORES_MOD;' +
    'O.rllConsumidor;O.rllCliCon;';

{ auxiliares }

function fLocalNameNfce(const ANo: IXMLNode): String;
var
  intPos: Integer;
begin
  Result := '';
  if ANo = nil then
    Exit;
  Result := ANo.LocalName;
  if Result = '' then
  begin
    Result := ANo.NodeName;
    intPos := Pos(':', Result);
    if intPos > 0 then
      Result := Copy(Result, intPos + 1, MaxInt);
  end;
end;

function fFilhoNfce(const ANo: IXMLNode; const ANome: String): IXMLNode;
var
  i: Integer;
begin
  Result := nil;
  if (ANo = nil) or (not ANo.HasChildNodes) then
    Exit;
  for i := 0 to ANo.ChildNodes.Count - 1 do
    if (ANo.ChildNodes[i].NodeType = ntElement) and SameText(fLocalNameNfce(ANo.ChildNodes[i]), ANome) then
    begin
      Result := ANo.ChildNodes[i];
      Exit;
    end;
end;

function fNavegaNfce(const ANo: IXMLNode; const ACaminho: String): IXMLNode;
var
  strResto, strSeg: String;
  intPos: Integer;
  blnPrimeiro: Boolean;
begin
  // dot-path por nome local; o primeiro segmento pode ser o proprio no ou um filho
  Result := nil;
  if (ANo = nil) or (Trim(ACaminho) = '') then
    Exit;
  Result := ANo;
  strResto := Trim(ACaminho);
  blnPrimeiro := True;
  while (strResto <> '') and (Result <> nil) do
  begin
    intPos := Pos('.', strResto);
    if intPos > 0 then
    begin
      strSeg := Trim(Copy(strResto, 1, intPos - 1));
      strResto := Copy(strResto, intPos + 1, MaxInt);
    end
    else
    begin
      strSeg := Trim(strResto);
      strResto := '';
    end;
    if strSeg = '' then
      Continue;
    if blnPrimeiro and SameText(fLocalNameNfce(Result), strSeg) then
    begin
      blnPrimeiro := False;
      Continue;
    end;
    blnPrimeiro := False;
    Result := fFilhoNfce(Result, strSeg);
  end;
end;

function fTextoNoNfce(const ANo: IXMLNode): String;
begin
  Result := '';
  if ANo = nil then
    Exit;
  try
    Result := Trim(ANo.Text);
  except
    Result := '';
  end;
end;

function fTextoVar(const AValor: Variant): String;
begin
  if VarIsNull(AValor) or VarIsEmpty(AValor) then
    Result := ''
  else
    Result := VarToStr(AValor);
end;

function fXmlParaFloatNfce(const AValor: String): Double;
var
  strValor: String;
  extValor: Extended;
  intCod: Integer;
begin
  // XML usa '.' como decimal; Val nao depende das configuracoes regionais
  Result := 0;
  strValor := Trim(AValor);
  if strValor = '' then
    Exit;
  Val(strValor, extValor, intCod);
  if intCod = 0 then
    Result := extValor;
end;

function fValorFloatNfce(const AValor: Variant): Double;
begin
  Result := 0;
  if VarIsNull(AValor) or VarIsEmpty(AValor) then
    Exit;
  if VarIsStr(AValor) then
    Result := fXmlParaFloatNfce(VarToStr(AValor))
  else
    Result := AValor;
end;

function fDataHoraNfce(const AValor: Variant): TDateTime;
var
  strValor: String;
  intAno, intMes, intDia, intHor, intMin, intSeg: Integer;
  dtaData: TDateTime;
begin
  // data/hora do XML sem fuso (como o ACBr) ou ja tipada (@DOC)
  Result := 0;
  if VarIsNull(AValor) or VarIsEmpty(AValor) then
    Exit;
  if not VarIsStr(AValor) then
  begin
    try
      Result := VarToDateTime(AValor);
    except
      Result := 0;
    end;
    Exit;
  end;

  strValor := Trim(VarToStr(AValor));
  if (Length(strValor) < 10) or (strValor[5] <> '-') then
  begin
    Result := StrToDateTimeDef(strValor, 0);
    Exit;
  end;
  intAno := StrToIntDef(Copy(strValor, 1, 4), 0);
  intMes := StrToIntDef(Copy(strValor, 6, 2), 0);
  intDia := StrToIntDef(Copy(strValor, 9, 2), 0);
  if not TryEncodeDate(intAno, intMes, intDia, dtaData) then
    Exit;
  Result := dtaData;
  if Length(strValor) >= 19 then
  begin
    intHor := StrToIntDef(Copy(strValor, 12, 2), 0);
    intMin := StrToIntDef(Copy(strValor, 15, 2), 0);
    intSeg := StrToIntDef(Copy(strValor, 18, 2), 0);
    if (intHor < 24) and (intMin < 60) and (intSeg < 60) then
      Result := Result + EncodeTime(intHor, intMin, intSeg, 0);
  end;
end;

function fSoDigitosNfce(const AValor: String): String;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(AValor) do
    if (AValor[i] >= '0') and (AValor[i] <= '9') then
      Result := Result + AValor[i];
end;

procedure pAtribuiNfce(AField: TField; const AValor: Variant);
var
  dtaValor: TDateTime;
begin
  // valor resolvido (texto do XML ou coluna do @DOC) no tipo do campo
  if AField = nil then
    Exit;
  if VarIsNull(AValor) or VarIsEmpty(AValor) then
  begin
    if AField.DataType in [ftString, ftWideString, ftFixedChar, ftMemo, ftWideMemo] then
      AField.AsString := ''
    else
      AField.Clear;
    Exit;
  end;
  case AField.DataType of
    ftFloat, ftCurrency, ftBCD, ftFMTBcd:
      AField.AsFloat := fValorFloatNfce(AValor);
    ftInteger, ftSmallint, ftWord, ftLargeint:
      if VarIsStr(AValor) then
        AField.AsInteger := StrToIntDef(Trim(VarToStr(AValor)), 0)
      else
        AField.AsInteger := AValor;
    ftDate, ftTime, ftDateTime:
      begin
        dtaValor := fDataHoraNfce(AValor);
        if dtaValor = 0 then
          AField.Clear
        else
          AField.AsDateTime := dtaValor;
      end;
  else
    AField.AsString := VarToStr(AValor);
  end;
end;

function fDescricaoTPag(const ATPag, AXPag: String): String;
var
  intTPag: Integer;
begin
  // tabela de meios de pagamento da NFC-e (tPag), em maiusculas e sem acentos
  intTPag := StrToIntDef(Trim(ATPag), -1);
  case intTPag of
    1: Result := 'DINHEIRO';
    2: Result := 'CHEQUE';
    3: Result := 'CARTAO DE CREDITO';
    4: Result := 'CARTAO DE DEBITO';
    5: Result := 'CREDITO LOJA';
    10: Result := 'VALE ALIMENTACAO';
    11: Result := 'VALE REFEICAO';
    12: Result := 'VALE PRESENTE';
    13: Result := 'VALE COMBUSTIVEL';
    15: Result := 'BOLETO BANCARIO';
    16: Result := 'DEPOSITO BANCARIO';
    17: Result := 'PIX';
    18: Result := 'TRANSFERENCIA BANCARIA';
    19: Result := 'PROGRAMA DE FIDELIDADE';
    20: Result := 'PIX';
    21: Result := 'CREDITO EM LOJA';
    22: Result := 'PAGAMENTO ELETRONICO';
    90: Result := 'SEM PAGAMENTO';
  else
    Result := 'OUTROS';
  end;
  if (intTPag = 99) and (Trim(AXPag) <> '') then
    Result := UpperCase(Trim(AXPag));
end;

{ TNfceDinEntrada }

constructor TNfceDinEntrada.Create;
begin
  inherited Create;
  strProvedor := cstProvedorCupomFiscal;
  dsDoc := nil;
  frxReport := nil;
  lstErros := nil;
end;

{ TNfceDinContexto }

constructor TNfceDinContexto.Create(AEntrada: TNfceDinEntrada);
begin
  inherited Create;
  FEntrada := AEntrada;
  FblnPrmOk := False;
end;

procedure TNfceDinContexto.pCarregaParametros;
var
  qry: TQueryNfceDin;
  strNome, strValor: String;
begin
  // parametros do provedor (IMPNFE_VAR origem F): lidos uma vez; ausente/invalido = padrao
  FblnPrmOk := True;
  FstrPrmItens := 'XML';
  FstrPrmPagto := 'XML';
  FstrPrmInfCpl := 'DOC';

  qry := fCriaQuery(nil);
  try
    try
      qry.SQL.Text :=
        'SELECT VAR_NOME, VAR_DEFAUL FROM IMPNFE_VAR ' +
        'WHERE VAR_CODPRV = :PRV AND VAR_NOME IN (''PRM_ITENS'', ''PRM_PAGTO'', ''PRM_INFCPL'')';
      qry.ParamByName('PRV').AsString := FEntrada.strProvedor;
      qry.Open;
      while not qry.Eof do
      begin
        strNome := UpperCase(Trim(qry.FieldByName('VAR_NOME').AsString));
        strValor := UpperCase(Trim(qry.FieldByName('VAR_DEFAUL').AsString));
        if (strValor = 'XML') or (strValor = 'DOC') then
        begin
          if strNome = 'PRM_ITENS' then
            FstrPrmItens := strValor
          else if strNome = 'PRM_PAGTO' then
            FstrPrmPagto := strValor
          else if strNome = 'PRM_INFCPL' then
            FstrPrmInfCpl := strValor;
        end;
        qry.Next;
      end;
      qry.Close;
    except
      on E: Exception do
        pGravaErro('Parametros do provedor ' + FEntrada.strProvedor, E.Message);
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function TNfceDinContexto.fPrm(const ANome: String): String;
begin
  if not FblnPrmOk then
    pCarregaParametros;
  if ANome = 'PRM_ITENS' then
    Result := FstrPrmItens
  else if ANome = 'PRM_PAGTO' then
    Result := FstrPrmPagto
  else if ANome = 'PRM_INFCPL' then
    Result := FstrPrmInfCpl
  else
    Result := '';
end;

function TNfceDinContexto.fNo(const ACaminho: String): IXMLNode;
begin
  Result := fNavegaNfce(NoRaiz, ACaminho);
end;

function TNfceDinContexto.fXml(const ACaminho: String): String;
begin
  Result := fTextoNoNfce(fNo(ACaminho));
end;

function TNfceDinContexto.fTemDest: Boolean;
begin
  Result := fNo('NFe.infNFe.dest') <> nil;
end;

function TNfceDinContexto.fObjetoExiste(const ANome: String): Boolean;
begin
  Result := (FEntrada.frxReport <> nil) and (FEntrada.frxReport.FindObject(ANome) <> nil);
end;

function TNfceDinContexto.fVariavelExiste(const ANome: String): Boolean;
var
  varValor: Variant;
begin
  // mesma verificacao da rotina (fVariavelExiste de TImpressaoNFCe.Imprimir)
  Result := FEntrada.frxReport <> nil;
  if not Result then
    Exit;
  try
    varValor := FEntrada.frxReport.Script.Variables[ANome];
  except
    Result := False;
  end;
end;

function TNfceDinContexto.fCampoDoc(const ANome: String): TField;
begin
  // coluna do registro corrente da consulta da rotina (@DOC)
  Result := nil;
  if (FEntrada.dsDoc <> nil) and FEntrada.dsDoc.Active and (not FEntrada.dsDoc.IsEmpty) then
    Result := FEntrada.dsDoc.FindField(ANome);
end;

function TNfceDinContexto.fModalidadesXml(AValores: Boolean): String;
var
  noPag, noDet, noCard: IXMLNode;
  lstDesc, lstVal: TStringList;
  i: Integer;
  strTPag, strDesc: String;
  fltValor: Double;
begin
  // mesmo formato de pCarregaModalidadesPagamento (cartao: TEF se tpIntegra = 1, senao POS)
  Result := '';
  noPag := fNo('NFe.infNFe.pag');
  if noPag = nil then
    Exit;

  lstDesc := TStringList.Create;
  lstVal := TStringList.Create;
  try
    for i := 0 to noPag.ChildNodes.Count - 1 do
    begin
      noDet := noPag.ChildNodes[i];
      if (noDet.NodeType <> ntElement) or (not SameText(fLocalNameNfce(noDet), 'detPag')) then
        Continue;
      fltValor := fXmlParaFloatNfce(fTextoNoNfce(fFilhoNfce(noDet, 'vPag')));
      if fltValor <= 0 then
        Continue;
      strTPag := fTextoNoNfce(fFilhoNfce(noDet, 'tPag'));
      strDesc := fDescricaoTPag(strTPag, fTextoNoNfce(fFilhoNfce(noDet, 'xPag')));
      if (strTPag = '03') or (strTPag = '04') then
      begin
        noCard := fFilhoNfce(noDet, 'card');
        if fTextoNoNfce(fFilhoNfce(noCard, 'tpIntegra')) = '1' then
          strDesc := strDesc + ' (TEF)'
        else
          strDesc := strDesc + ' (POS)';
      end;
      lstDesc.Add(strDesc + ':');
      lstVal.Add(FloatToStrF(fltValor, ffNumber, 12, 2));
    end;

    for i := 0 to lstDesc.Count - 1 do
    begin
      if FEntrada.strEspDoc = 'IF' then
      begin
        if i > 0 then
          Result := Result + #13#10;
        if AValores then
          Result := Result + lstVal[i]
        else
          Result := Result + lstDesc[i];
      end
      else if AValores then
      begin
        if i > 0 then
          Result := Result + ' ';
        Result := Result + lstVal[i];
      end
      else
        Result := Result + lstDesc[i] + ' ' + lstVal[i] + ' ';
    end;
  finally
    FreeAndNil(lstVal);
    FreeAndNil(lstDesc);
  end;
end;

function TNfceDinContexto.fTributos(const AInfAdFisco: String): String;

  function fValorAntes(const APalavra: String; out AAchou: Boolean): Double;
  var
    intPos, intFim: Integer;
    strNum: String;
  begin
    // valor imediatamente antes da palavra (ex.: "R$ 29,40 Federal")
    Result := 0;
    AAchou := False;
    intPos := Pos(UpperCase(APalavra), UpperCase(AInfAdFisco));
    if intPos <= 1 then
      Exit;
    intFim := intPos - 1;
    while (intFim > 0) and (AInfAdFisco[intFim] = ' ') do
      Dec(intFim);
    intPos := intFim;
    while (intPos > 0) and (((AInfAdFisco[intPos] >= '0') and (AInfAdFisco[intPos] <= '9')) or
          (AInfAdFisco[intPos] = '.') or (AInfAdFisco[intPos] = ',')) do
      Dec(intPos);
    strNum := Copy(AInfAdFisco, intPos + 1, intFim - intPos);
    if strNum = '' then
      Exit;
    // formato brasileiro: milhar "." e decimal ","
    strNum := StringReplace(strNum, '.', '', [rfReplaceAll]);
    strNum := StringReplace(strNum, ',', '.', [rfReplaceAll]);
    Result := fXmlParaFloatNfce(strNum);
    AAchou := True;
  end;

var
  fltFed, fltEst, fltMun: Double;
  blnFed, blnEst, blnMun: Boolean;
  fldImp: TField;
begin
  // infAdFisco no formato da rotina; sem o padrao esperado, usa o @DOC
  fltFed := fValorAntes('Federal', blnFed);
  fltEst := fValorAntes('Estadual', blnEst);
  fltMun := fValorAntes('Municipal', blnMun);

  if not (blnFed or blnEst or blnMun) then
  begin
    fltFed := 0;
    fltEst := 0;
    fltMun := 0;
    fldImp := fCampoDoc('FEDIMP');
    if fldImp <> nil then
      fltFed := fldImp.AsFloat;
    fldImp := fCampoDoc('ESTIMP');
    if fldImp <> nil then
      fltEst := fldImp.AsFloat;
    fldImp := fCampoDoc('MUNIMP');
    if fldImp <> nil then
      fltMun := fldImp.AsFloat;
    if StrToIntDef(fCfgSis('IMPPAG', FEntrada.strCodEmp), 0) = 1 then
    begin
      fldImp := fCampoDoc('IMPPAG');
      if fldImp <> nil then
        Result := FloatToStrF(fldImp.AsFloat, ffNumber, 12, 2)
      else
        Result := FloatToStrF(0, ffNumber, 12, 2);
      Exit;
    end;
  end
  else if StrToIntDef(fCfgSis('IMPPAG', FEntrada.strCodEmp), 0) = 1 then
  begin
    Result := FloatToStrF(fltFed + fltEst + fltMun, ffNumber, 12, 2);
    Exit;
  end;

  if fltFed + fltEst + fltMun = 0 then
  begin
    Result := '0,00';
    Exit;
  end;

  Result := '';
  if fltFed <> 0 then
    Result := Result + FloatToStrF(fltFed, ffNumber, 12, 2) + ' Fed';
  if fltEst <> 0 then
    Result := Result + '/' + FloatToStrF(fltEst, ffNumber, 12, 2) + ' Est';
  if fltMun <> 0 then
    Result := Result + '/' + FloatToStrF(fltMun, ffNumber, 12, 2) + ' Mun';
  Result := Result + '/ Fonte:IBPT.';
end;

function TNfceDinContexto.fMarcador(const ANome: String; out AValor: Variant): Boolean;
begin
  Result := True;
  AValor := Null;
  if ANome = 'ACESSO' then AValor := FEntrada.strAcesso
  else if ANome = 'CODEMP' then AValor := FEntrada.strCodEmp
  else if ANome = 'NUMDOC' then AValor := FEntrada.strNumDoc
  else if ANome = 'ESPDOC' then AValor := FEntrada.strEspDoc
  else if ANome = 'SERIE' then AValor := FEntrada.strSerie
  else if ANome = 'REIMPRESSAO' then AValor := IfThen(FEntrada.blnReimpressao, 'S', 'N')
  else if ANome = 'TEMDEST' then AValor := IfThen(fTemDest, 'S', 'N')
  else if (ANome = 'PRM_ITENS') or (ANome = 'PRM_PAGTO') or (ANome = 'PRM_INFCPL') then
    AValor := fPrm(ANome)
  else
    Result := False;
end;

function TNfceDinContexto.fDataSetDoc(const ANome: String): TDataSet;
begin
  Result := nil;
  if SameText(Trim(ANome), '@DOC') then
    Result := FEntrada.dsDoc;
end;

function TNfceDinContexto.fAplicaFuncao(const AFuncao: String; AParams: TStrings; const AValor: Variant;
  AEncontrado: Boolean; AField: TField; const ANoRegistro: IXMLNode; AIndice: Integer): Boolean;
var
  strValor, strAux, strNome: String;
  dtaValor: TDateTime;
  fltValor: Double;
  fldDoc: TField;
  noAux: IXMLNode;

  function fParam(AIdx: Integer): String;
  begin
    Result := '';
    if (AParams <> nil) and (AIdx < AParams.Count) then
      Result := AParams[AIdx];
  end;

begin
  Result := True;
  strValor := fTextoVar(AValor);

  { ------------------------------ formatacao ------------------------------ }
  if AFuncao = 'CNPJCPF' then
    AField.AsString := fFormataCpfCgc(strValor)
  else if AFuncao = 'CEP' then
    AField.AsString := fFormataCEP(AnsiReplaceStr(strValor, '-', ''))
  else if AFuncao = 'FONE' then
    AField.AsString := fFormataFone(strValor)
  else if AFuncao = 'CHAVE4' then
    AField.AsString := fTransform(fSoDigitosNfce(strValor), 4, ' ')
  else if AFuncao = 'DATA' then
  begin
    dtaValor := fDataHoraNfce(AValor);
    if dtaValor = 0 then
      AField.Clear
    else
      AField.AsDateTime := Trunc(dtaValor);
  end
  else if AFuncao = 'HORA' then
  begin
    dtaValor := fDataHoraNfce(AValor);
    if dtaValor = 0 then
      AField.Clear
    else
      AField.AsDateTime := Frac(dtaValor);
  end
  else if AFuncao = 'DATAHORA' then
  begin
    dtaValor := fDataHoraNfce(AValor);
    if dtaValor = 0 then
      AField.AsString := ''
    else
      AField.AsString := FormatDateTime(IfThen(fParam(0) <> '', fParam(0), 'dd/mm/yyyy hh:nn:ss'), dtaValor);
  end
  else if AFuncao = 'DTAEMI' then
  begin
    // dhEmi do XML; sem ele, DTAENT + HORENT do @DOC (como a rotina)
    dtaValor := fDataHoraNfce(AValor);
    if dtaValor <> 0 then
      AField.AsString := FormatDateTime('dd/mm/yyyy', dtaValor) + ' ' + FormatDateTime('hh:mm:ss', dtaValor)
    else if (fCampoDoc('DTAENT') <> nil) and (fCampoDoc('HORENT') <> nil) then
      AField.AsString := FormatDateTime('dd/mm/yyyy', fCampoDoc('DTAENT').AsDateTime) + ' ' +
        FormatDateTime('hh:mm:ss', fCampoDoc('HORENT').AsDateTime)
    else
      AField.AsString := '';
  end

  { -------------------------------- emitente -------------------------------- }
  else if AFuncao = 'NOMEEMP' then
  begin
    // CFG_RSNFNC = 'F': nome fantasia (como a consulta da rotina)
    strAux := '';
    if fCfgSis('RSNFNC', FEntrada.strCodEmp) = 'F' then
      strAux := fXml('NFe.infNFe.emit.xFant');
    if strAux = '' then
      strAux := strValor;
    AField.AsString := strAux;
  end
  else if AFuncao = 'ENDEMP' then
  begin
    // mesmo texto da consulta: ENDERE, ENDNUM, BAIRRO - CIDADE/UF
    noAux := fNo('NFe.infNFe.emit.enderEmit');
    if (noAux <> nil) and (fTextoNoNfce(fFilhoNfce(noAux, 'xLgr')) <> '') then
      AField.AsString := fTextoNoNfce(fFilhoNfce(noAux, 'xLgr')) + ', ' +
        fTextoNoNfce(fFilhoNfce(noAux, 'nro')) + ', ' +
        fTextoNoNfce(fFilhoNfce(noAux, 'xBairro')) + ' - ' +
        fTextoNoNfce(fFilhoNfce(noAux, 'xMun')) + '/' +
        fTextoNoNfce(fFilhoNfce(noAux, 'UF'))
    else
      AField.AsString := strValor;
  end

  { ------------------------------- consumidor ------------------------------- }
  else if AFuncao = 'SEDEST' then
  begin
    // sem <dest> no XML: consumidor nao identificado (sem fallback)
    if fTemDest then
      pAtribuiNfce(AField, AValor)
    else
      pAtribuiNfce(AField, Null);
  end

  { -------------------------------- itens --------------------------------- }
  else if AFuncao = 'CODPROMO' then
  begin
    // CFG_NFEPRO = 'S': item em promocao com "*" antes do codigo (como a consulta)
    strAux := strValor;
    if (fCfgSis('NFEPRO', FEntrada.strCodEmp) = 'S') and (AField.DataSet <> nil) and
       (AField.DataSet.FindField('PROMOC') <> nil) and
       (AField.DataSet.FieldByName('PROMOC').AsString = 'S') and (Copy(strAux, 1, 1) <> '*') then
      strAux := '*' + strAux;
    AField.AsString := strAux;
  end

  { ------------------------------- pagamento ------------------------------- }
  else if AFuncao = 'CONDPAG' then
  begin
    if fStatusCndPag(strValor) = A_VISTA then
      AField.AsString := 'A VISTA'
    else
      AField.AsString := fFormataCondPag(strValor);
  end
  else if AFuncao = 'MODALIDADES' then
  begin
    if fPrm('PRM_PAGTO') = 'DOC' then
      AField.AsString := FEntrada.strModalidadesDoc
    else
      AField.AsString := fModalidadesXml(False);
  end
  else if AFuncao = 'VALORESMOD' then
  begin
    if fPrm('PRM_PAGTO') = 'DOC' then
      AField.AsString := FEntrada.strValoresDoc
    else
      AField.AsString := fModalidadesXml(True);
  end
  else if AFuncao = 'TROCO' then
  begin
    // vTroco do XML quando existir (PRM_PAGTO = XML); senao a coluna do @DOC (AUX_TROCO_)
    fltValor := fValorFloatNfce(AValor);
    if (fPrm('PRM_PAGTO') = 'XML') and (fNo('NFe.infNFe.pag.vTroco') <> nil) then
      fltValor := fXmlParaFloatNfce(fXml('NFe.infNFe.pag.vTroco'));
    if UpperCase(fParam(0)) = 'TEXTO' then
      AField.AsString := FloatToStrF(fltValor, ffNumber, 12, 2)
    else
      AField.AsFloat := fltValor;
  end
  else if AFuncao = 'TPAGDESC' then
    AField.AsString := fDescricaoTPag(strValor, fTextoNoNfce(fFilhoNfce(ANoRegistro, 'xPag')))

  { --------------------------- textos da nota --------------------------- }
  else if AFuncao = 'INFCOMPL' then
  begin
    strAux := '';
    if fPrm('PRM_INFCPL') = 'XML' then
    begin
      strAux := Trim(strValor);
      if Copy(strAux, Length(strAux), 1) = '#' then
        strAux := Trim(Copy(strAux, 1, Length(strAux) - 1));
    end;
    if strAux = '' then
      strAux := FEntrada.strInfCplDoc;
    AField.AsString := strAux;
  end
  else if AFuncao = 'TRIBUTOS' then
    AField.AsString := fTributos(strValor)
  else if AFuncao = 'REIMPRESSAO' then
    AField.AsString := IfThen(FEntrada.blnReimpressao, '*** SEGUNDA VIA ***', '')
  else if AFuncao = 'CFG' then
    AField.AsString := fCfgSis(fParam(0), FEntrada.strCodEmp) + fParam(1)

  { ------------------ valores calculados pela rotina (Delphi) ------------------ }
  else if AFuncao = 'ENTRADA' then
  begin
    strNome := UpperCase(fParam(0));
    if strNome = 'NETPOINTS' then AField.AsString := IntToStr(FEntrada.intQtdNps)
    else if strNome = 'SELOS' then AField.AsString := IntToStr(FEntrada.intQtdSelos)
    else if strNome = 'CASHBACK' then AField.AsString := FloatToStrF(FEntrada.fltCashBack, ffNumber, 12, 2)
    else if strNome = 'DOCSCRED' then AField.AsString := FEntrada.strDocsCred
    else if strNome = 'SLDCRED' then AField.AsString := FEntrada.strSldCred
    else if strNome = 'IDEPRO' then AField.AsString := FEntrada.strIdePro
    else if strNome = 'PARCELAS' then AField.AsString := FEntrada.strParcelasCartao
    else if strNome = 'DESCRCARTAO' then AField.AsString := FEntrada.strDescrCartao
    else if strNome = 'CARCONPAG' then AField.AsString := FEntrada.strCarConPag
    else if strNome = 'DTAVEN' then AField.AsString := FEntrada.strDtaVen
    else if strNome = 'MODALIDADES' then AField.AsString := FEntrada.strModalidadesDoc
    else if strNome = 'VALORES' then AField.AsString := FEntrada.strValoresDoc
    else if strNome = 'INFCPL' then AField.AsString := FEntrada.strInfCplDoc
    else
      Result := False;
  end
  else if AFuncao = 'DOC' then
  begin
    // coluna do @DOC pelo nome (ex.: campo que nao existe no XML nem no registro)
    fldDoc := fCampoDoc(fParam(0));
    if fldDoc <> nil then
      pAtribuiNfce(AField, fldDoc.Value)
    else
      pAtribuiNfce(AField, Null);
  end
  else
    Result := False;
end;

procedure TNfceDinContexto.pGravaErro(const AOrigem, AMensagem: String);
begin
  inherited;
  if FEntrada.lstErros <> nil then
    FEntrada.lstErros.Add(AOrigem + ': ' + AMensagem);
end;

function TNfceDinContexto.fChaveAcesso: String;
begin
  Result := '';
  if FEntrada <> nil then
    Result := FEntrada.strAcesso;
end;

function TNfceDinContexto.fCaminhoBase(const ANomCds, ACamBas: String): String;
begin
  // PRM_ITENS = DOC: registros e ordem do @DOC (ORDALF / agrupamento CBCODE)
  Result := ACamBas;
  if SameText(Trim(ANomCds), cstCdsItensNFCe) and (fPrm('PRM_ITENS') = 'DOC') then
    Result := '@DOC';
end;

function TNfceDinContexto.fLigaXmlDriverDoc(const ANomCds: String): Boolean;
begin
  // CBCODE = 'S': linhas agrupadas nao correspondem aos det; o item vem do @DOC
  Result := True;
  if not SameText(Trim(ANomCds), cstCdsItensNFCe) then
    Exit;
  try
    Result := fCfgSis('CBCODE', FEntrada.strCodEmp) <> 'S';
  except
    on E: Exception do
      pGravaErro('Configuracao CBCODE', E.Message);
  end;
end;

function TNfceDinContexto.fNormalizaChave(const AColuna: String; const AValor: Variant): Variant;
var
  strValor: String;
begin
  // CFG_NFEPRO: a consulta marca o codigo do item em promocao com "*"
  Result := AValor;
  if SameText(AColuna, 'CODITE') then
  begin
    strValor := Trim(fTextoVar(AValor));
    if Copy(strValor, 1, 1) = '*' then
      strValor := Copy(strValor, 2, MaxInt);
    Result := strValor;
  end;
end;

function TNfceDinContexto.fAceitaVariavel(const ANome: String): Boolean;
var
  strNome: String;
begin
  // PRM_* nao vao para o fr3; as demais so se o objeto existir no fr3
  strNome := UpperCase(Trim(ANome));
  if Copy(strNome, 1, 4) = 'PRM_' then
    Result := False
  else if strNome = 'IM' then
    Result := fVariavelExiste('IM')
  else if strNome = 'DTAVEN' then
    Result := fObjetoExiste('memDtaVen')
  else if strNome = 'PARCELAS_CARTAO' then
    Result := fObjetoExiste('memParcelasCartao')
  else if strNome = 'QTDSELOS' then
    Result := fObjetoExiste('ChdSelos')
  else if strNome = 'VENCSH' then
    Result := fObjetoExiste('ChildCashBack')
  else if (strNome = 'PTOVEN') or (strNome = 'PTOSLD') then
    Result := fObjetoExiste('ChildFidelidade')
  else if (strNome = 'DOCSCRED') or (strNome = 'SLDCRED') then
    Result := fObjetoExiste('rllSaldos')
  else if strNome = 'MENSAGEMREIMPRESSAO' then
    Result := fObjetoExiste('memWatermark')
  else if strNome = 'DESCRICAO_CARTAO' then
    Result := fObjetoExiste('memDescricaoCartao')
  else
    Result := True;
end;

{ TNfceDinamico }

constructor TNfceDinamico.Create(AEntrada: TNfceDinEntrada);
begin
  inherited Create;
  FEntrada := AEntrada;
  FContexto := nil;
  FReport := nil;
  FlstNomes := TStringList.Create;
  FlstCampos := TObjectList.Create(True);
  FlstFrx := TObjectList.Create(True);
  FlstCds := TObjectList.Create(True);
end;

destructor TNfceDinamico.Destroy;
begin
  pLiberaDataSets;
  FreeAndNil(FlstCds);
  FreeAndNil(FlstFrx);
  FreeAndNil(FlstCampos);
  FreeAndNil(FlstNomes);
  FXmlDoc := nil;
  inherited;
end;

procedure TNfceDinamico.pLiberaDataSets;
begin
  // frxDBDataset antes dos datasets; o contexto so tem referencias
  FlstFrx.Clear;
  FlstCds.Clear;
  FlstCampos.Clear;
  FlstNomes.Clear;
  SetLength(FarrDefs, 0);
  FreeAndNil(FContexto);
end;

class function TNfceDinamico.fDisponivel(const AProvedor: String): Boolean;
begin
  // qualquer falha = False
  try
    Result := TNfsDinamico.fModeloNovoDisponivel and TNfsDinamico.fExisteProvedor(AProvedor);
  except
    Result := False;
  end;
end;

procedure TNfceDinamico.pCriarEstrutura(AReport: TfrxReport);
var
  qry: TQueryNfceDin;
  lstCampos: TObjectList;
  cds: TUniClientDataSet;
  frxDb: TfrxDBDataset;
  i: Integer;
begin
  pLiberaDataSets;
  FReport := AReport;

  // estrutura completa ANTES da carga do fr3 (as bandas ligam pelo nome)
  AReport.DataSets.Clear;
  AReport.EnabledDataSets.Clear;

  FContexto := TNfceDinContexto.Create(FEntrada);

  qry := fCriaQuery(nil);
  try
    qry.SQL.Text :=
      'SELECT CDS_NOMCDS FROM IMPNFE_CDS WHERE CDS_CODPRV = :PRV ' +
      'ORDER BY CDS_ORDEM, CDS_NOMCDS';
    qry.ParamByName('PRV').AsString := FEntrada.strProvedor;
    qry.Open;
    while not qry.Eof do
    begin
      FlstNomes.Add(qry.FieldByName('CDS_NOMCDS').AsString);
      qry.Next;
    end;
    qry.Close;
  finally
    FreeAndNil(qry);
  end;

  if FlstNomes.Count = 0 then
    raise Exception.CreateFmt('Provedor dinamico %s sem datasets (IMPNFE_CDS).', [FEntrada.strProvedor]);

  SetLength(FarrDefs, FlstNomes.Count);
  for i := 0 to FlstNomes.Count - 1 do
  begin
    TNfsDinamico.pCarregaDefCds(FEntrada.strProvedor, FlstNomes[i], FarrDefs[i]);

    lstCampos := TObjectList.Create(True);
    FlstCampos.Add(lstCampos);
    TNfsDinamico.pCarregaCampos(FEntrada.strProvedor, FlstNomes[i], lstCampos);

    cds := TUniClientDataSet.Create(nil);
    FlstCds.Add(cds);
    if FarrDefs[i].strOrigem = 'B' then
      TNfsDinamico.pMontarPorBancoDin(cds, FarrDefs[i], FContexto)
    else
      TNfsDinamico.pCriarEstruturaDin(cds, FarrDefs[i], lstCampos, FContexto);

    frxDb := TfrxDBDataset.Create(nil);
    FlstFrx.Add(frxDb);
    frxDb.Name := 'frxDsNfceDin' + IntToStr(i + 1);
    frxDb.UserName := FarrDefs[i].strNomFrx;
    frxDb.DataSet := cds;
    frxDb.OpenDataSource := False;
    frxDb.CloseDataSource := False;
    frxDb.Enabled := False;
    AReport.DataSets.Add(frxDb);
    AReport.EnabledDataSets.Add(frxDb);

    FContexto.pRegistraDataSet(FarrDefs[i].strNomCds, FarrDefs[i].strNomFrx, cds);
  end;
end;

procedure TNfceDinamico.pPreencher;
var
  i: Integer;
  noRaiz: IXMLNode;
  cds, cdsVar: TUniClientDataSet;
begin
  if FContexto = nil then
    raise Exception.Create('Datasets dinamicos da NFC-e sem estrutura (pCriarEstrutura).');

  // mesmo texto que o ACBr le do XML declarado em UTF-8 (acentos)
  FXmlDoc := nil;
  FXmlDoc := TXMLDocument.Create(nil);
  FXmlDoc.LoadFromXML(String(AnsiString(ConverteXMLtoNativeString(FEntrada.strXml))));
  FXmlDoc.Active := True;
  noRaiz := FXmlDoc.DocumentElement;

  for i := 0 to FlstNomes.Count - 1 do
    if FarrDefs[i].strOrigem <> 'B' then
    begin
      cds := TUniClientDataSet(FlstCds[i]);
      if cds.Active then
      begin
        cds.IndexFieldNames := '';
        cds.EmptyDataSet;
      end;
      TNfsDinamico.pPreencherDin(cds, FarrDefs[i], TObjectList(FlstCampos[i]), noRaiz, FContexto);
      if cds.Active then
        cds.First;
    end;

  // variaveis do fr3: VAR_CDS vazio = Cabecalho; erro registra e segue
  if (FReport <> nil) and (FlstCds.Count > 0) then
  begin
    cdsVar := FContexto.fDataSetPorNome(cstCdsCabecalhoNFCe);
    if cdsVar = nil then
      cdsVar := TUniClientDataSet(FlstCds[0]);
    try
      TNfsDinamico.pCarregaVariaveis(FReport, FEntrada.strProvedor, cdsVar,
        FEntrada.strAcesso, FEntrada.strCodEmp, FEntrada.strNumDoc, FEntrada.strEspDoc, FContexto);
    except
      on E: Exception do
      begin
        // sem as variaveis o cupom sairia incompleto: relanca para voltar a rotina antiga
        FContexto.pGravaErro('Variaveis do provedor ' + FEntrada.strProvedor, E.Message);
        if FEntrada.lstErros = nil then
          raise;
      end;
    end;
  end;
end;

function TNfceDinamico.fDataSet(const ANome: String): TUniClientDataSet;
begin
  Result := nil;
  if FContexto <> nil then
    Result := FContexto.fDataSetPorNome(ANome);
end;

class procedure TNfceDinamico.pFotografa(ADataSet: TDataSet; AReport: TfrxReport; AFoto: TStrings);

  function fLimpa(const ATexto: String): String;
  begin
    Result := StringReplace(StringReplace(StringReplace(ATexto, #13, '\r', [rfReplaceAll]),
      #10, '\n', [rfReplaceAll]), #9, ' ', [rfReplaceAll]);
  end;

var
  i, intReg, intRecOri: Integer;
  fldChave: TField;
  strChave, strValor: String;
  varValor: Variant;
  objMemo: TfrxComponent;
begin
  // formato: "R.<CAMPO>|<registro>", "V.<VARIAVEL>" ou "O.<OBJETO>" + TAB + valor
  AFoto.Clear;
  if (ADataSet <> nil) and ADataSet.Active then
  begin
    AFoto.Add('N.REGISTROS' + #9 + IntToStr(ADataSet.RecordCount));
    fldChave := ADataSet.FindField('DET_AUTOINCREM');
    intRecOri := ADataSet.RecNo;
    try
      intReg := 0;
      ADataSet.First;
      while not ADataSet.Eof do
      begin
        Inc(intReg);
        if (fldChave <> nil) and (not fldChave.IsNull) then
          strChave := fldChave.AsString
        else
          strChave := '#' + IntToStr(intReg);
        for i := 0 to ADataSet.FieldCount - 1 do
        begin
          if ADataSet.Fields[i].IsNull then
            strValor := ''
          else if ADataSet.Fields[i].DataType in [ftFloat, ftCurrency, ftBCD, ftFMTBcd] then
            strValor := FormatFloat('0.######', ADataSet.Fields[i].AsFloat)
          else
            strValor := ADataSet.Fields[i].AsString;
          AFoto.Add('R.' + UpperCase(ADataSet.Fields[i].FieldName) + '|' + strChave + #9 + fLimpa(strValor));
        end;
        ADataSet.Next;
      end;
    finally
      if intRecOri > 0 then
        ADataSet.RecNo := intRecOri;
    end;
  end;

  if AReport = nil then
    Exit;

  for i := Low(cstVariaveisNFCe) to High(cstVariaveisNFCe) do
  begin
    try
      varValor := AReport.Script.Variables[cstVariaveisNFCe[i]];
      strValor := fTextoVar(varValor);
    except
      strValor := '<indefinida>';
    end;
    AFoto.Add('V.' + cstVariaveisNFCe[i] + #9 + fLimpa(strValor));
  end;

  for i := Low(cstObjetosNFCe) to High(cstObjetosNFCe) do
  begin
    objMemo := AReport.FindObject(cstObjetosNFCe[i]);
    if objMemo is TfrxMemoView then
      AFoto.Add('O.' + cstObjetosNFCe[i] + #9 + fLimpa(Trim(TfrxMemoView(objMemo).Memo.Text)));
  end;
end;

class procedure TNfceDinamico.pComparar(AFotoAntiga, AFotoNova, AResultado: TStrings; out ANaoEsperadas: Integer);
const
  cstMaxLinhas = 400;
var
  lstAnt, lstNov: TStringList;
  i, intIdx, intEsperadas, intIguais, intSoNova: Integer;
  strChave, strAnt, strNov, strGrupo: String;

  procedure pSepara(AFoto: TStrings; ALista: TStringList);
  var
    k, intTab: Integer;
  begin
    // chaves unicas: "chave" + #1 + "valor"
    ALista.Clear;
    for k := 0 to AFoto.Count - 1 do
    begin
      intTab := Pos(#9, AFoto[k]);
      if intTab > 0 then
        ALista.Add(Copy(AFoto[k], 1, intTab - 1) + #1 + Copy(AFoto[k], intTab + 1, MaxInt))
      else
        ALista.Add(AFoto[k] + #1);
    end;
  end;

  function fDuplicadaDaConsulta(const AGrupo: String): Boolean;
  begin
    // coluna repetida na consulta da rotina (ex.: TOTITE e TOTITE_1): nao e divergencia
    Result := (Length(AGrupo) > 4) and (Copy(AGrupo, Length(AGrupo) - 1, 2) = '_1');
  end;

  function fGrupo(const AChave: String): String;
  var
    intBarra: Integer;
  begin
    // "R.CAMPO|registro" -> "R.CAMPO"
    intBarra := Pos('|', AChave);
    if intBarra > 0 then
      Result := Copy(AChave, 1, intBarra - 1)
    else
      Result := AChave;
  end;

  procedure pDif(const ATexto: String; AEsperada: Boolean);
  begin
    if AEsperada then
      Inc(intEsperadas)
    else
      Inc(ANaoEsperadas);
    if AResultado.Count < cstMaxLinhas then
      AResultado.Add(IfThen(AEsperada, '  [esperada] ', '  [NAO ESPERADA] ') + ATexto)
    else if AResultado.Count = cstMaxLinhas then
      AResultado.Add('  ... (demais divergencias omitidas)');
  end;

begin
  ANaoEsperadas := 0;
  intEsperadas := 0;
  intIguais := 0;
  intSoNova := 0;
  lstAnt := TStringList.Create;
  lstNov := TStringList.Create;
  try
    // os valores de fLimpa nao tem quebra de linha: Values e seguro
    lstAnt.NameValueSeparator := #1;
    lstNov.NameValueSeparator := #1;
    pSepara(AFotoAntiga, lstAnt);
    pSepara(AFotoNova, lstNov);

    for i := 0 to lstAnt.Count - 1 do
    begin
      strChave := lstAnt.Names[i];
      strAnt := lstAnt.ValueFromIndex[i];
      intIdx := lstNov.IndexOfName(strChave);
      strGrupo := fGrupo(strChave);
      if intIdx < 0 then
      begin
        // campo/registro da rotina antiga que nao existe na nova
        if not fDuplicadaDaConsulta(strGrupo) then
          pDif(strChave + ': so na rotina antiga ("' + strAnt + '")', False);
        Continue;
      end;
      strNov := lstNov.ValueFromIndex[intIdx];
      if strAnt = strNov then
        Inc(intIguais)
      else
        pDif(strChave + ': antiga "' + strAnt + '", nova "' + strNov + '"',
          Pos(';' + UpperCase(strGrupo) + ';', UpperCase(cstEsperadas)) > 0);
    end;

    for i := 0 to lstNov.Count - 1 do
      if lstAnt.IndexOfName(lstNov.Names[i]) < 0 then
      begin
        // registro que so existe na rotina nova (ex.: item sem linha no @DOC)
        if Copy(lstNov.Names[i], 1, 2) = 'N.' then
          Continue;
        Inc(intSoNova);
        if Pos('|', lstNov.Names[i]) > 0 then
          pDif(lstNov.Names[i] + ': so na rotina nova ("' + lstNov.ValueFromIndex[i] + '")', False);
      end;

    AResultado.Add(StringOfChar('-', 78));
    AResultado.Add(Format('Iguais: %d | divergencias esperadas (RN07): %d | NAO esperadas: %d',
      [intIguais, intEsperadas, ANaoEsperadas]));
    if intSoNova > 0 then
      AResultado.Add(IntToStr(intSoNova) + ' valor(es) somente na rotina nova (campos novos do cadastro ou registros sem correspondencia).');
  finally
    FreeAndNil(lstNov);
    FreeAndNil(lstAnt);
  end;
end;

end.
