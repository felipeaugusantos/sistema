unit untNfsDinamico;

{
  Motor da impressao dinamica: monta os datasets e as variaveis do fr3 a partir
  das tabelas IMPNFE_CDS, IMPNFE_FLD e IMPNFE_VAR.
}

interface

uses
{$IF Defined(UNIDAC)}
  Uni,
{$ELSE}
  ZConnection, ZDataset,
{$IFEND}
  SysUtils, Classes, Variants, StrUtils, DB,
  XMLIntf, XMLDoc,
{$IF Defined(LINUX)}
  FMX.frxClass,
{$ELSE}
  frxClass,
{$IFEND}
  Contnrs, untUniClientDataSet, untUtil;

type
  // Contexto do documento (NF-e/NFC-e): marcadores VS_*, fonte @DOC, FLD_FUNC e
  // CDS_POSPRC. Nao e dono dos datasets.
  TNfdContexto = class
  private
    FDataSets: TStringList;
    FNoRaiz: IXMLNode;
  public
    constructor Create;
    destructor Destroy; override;
    procedure pRegistraDataSet(const ANomCds, ANomFrx: String; ACds: TUniClientDataSet);
    function fDataSetPorNome(const ANome: String): TUniClientDataSet;
    function fMarcador(const ANome: String; out AValor: Variant): Boolean; virtual;
    function fDataSetDoc(const ANome: String): TDataSet; virtual;
    function fAplicaFuncao(const AFuncao: String; AParams: TStrings; const AValor: Variant;
      AEncontrado: Boolean; AField: TField; const ANoRegistro: IXMLNode; AIndice: Integer): Boolean; virtual;
    procedure pPosProcessa(const APosPrc: String; ACds: TUniClientDataSet); virtual;
    procedure pGravaErro(const AOrigem, AMensagem: String); virtual;
    function fChaveAcesso: String; virtual;
    function fCaminhoBase(const ANomCds, ACamBas: String): String; virtual;
    function fLigaXmlDriverDoc(const ANomCds: String): Boolean; virtual;
    function fNormalizaChave(const AColuna: String; const AValor: Variant): Variant; virtual;
    function fAceitaVariavel(const ANome: String): Boolean; virtual;
    property NoRaiz: IXMLNode read FNoRaiz write FNoRaiz;
  end;

  TNfdCampo = class
  public
    strNome, strTipo, strCaminh, strCamAux, strColSel, strAjuste, strFunc, strDefaul: String;
    blnDefaulNulo: Boolean;
  end;

  TNfdDefCds = record
    strNomCds, strNomFrx, strOrigem, strSelect, strCamBas, strChvSel,
    strCondic, strRegVaz, strPosPrc: String;
  end;

  TNfsDinamico = class
  private
    class function fLocalName(const ANode: IXMLNode): String;
    class function fBuscaFilho(const ANode: IXMLNode; const ANomeLocal: String): IXMLNode;
    class function fResolveValor(const ANoRaiz: IXMLNode; const ACaminho: String;
      out AEncontrado: Boolean): String;
    class function fAplicaAjuste(const AAjuste, AValor, AAcesso, ACodEmp: String): String;
    class procedure pResolveTipoCampo(const ATipo: String; out ADataType: TFieldType;
      out ASize: Integer);
    class procedure pAtribuiValorCampo(AField: TField; const AValor: String);
    class function fCarregaCds(const AProvedor, ANomCds: String; out AOrigem, ASelect: String): Boolean;
    class procedure pMontarPorXml(var cds: TUniClientDataSet; const AProvedor, ANomCds: String;
      const AXML, AAcesso, ACodEmp: String);
    class procedure pMontarPorBanco(var cds: TUniClientDataSet; const ASelect,
      AAcesso, ACodEmp: String);
    class function fSubstituiMarcadores(const ASql: String; ACds: TUniClientDataSet;
      AFields: TStrings): String;
    class function fExecEscalarVar(const ASelect: String; ACds: TUniClientDataSet;
      const AAcesso, ACodEmp, ANumDoc, AEspDoc: String; out AAchou: Boolean): String;
    class function fAplicaFuncVar(const AFunc, AValor: String): String;
  public
    class function fExisteProvedor(const AProvedor: String): Boolean;
    class function fXmlObrigatorio(const AProvedor, AAcesso: String; out ADescricao: String): String;
    class procedure pGravaLogDin(const ADescri, AAcesso, AMensagem: String;
      const AErro: String = ''; ADiario: Boolean = False);
    class procedure pMontarCds(var cds: TUniClientDataSet; const AProvedor, ANomCds: String;
      const AXML, AAcesso, ACodEmp: String);
    // AContexto opcional (NF-e/NFC-e): habilita o VAR_CDS
    class procedure pCarregaVariaveis(AReport: TfrxReport; const AProvedor: String;
      ACds: TUniClientDataSet; const AAcesso, ACodEmp, ANumDoc, AEspDoc: String;
      AContexto: TNfdContexto = nil);

    class function fModeloNovoDisponivel: Boolean;
    class procedure pListaVariaveis(AReport: TfrxReport; const AProvedor: String; ALista: TStrings);
    class procedure pNomesCds(const AProvedor: String; ALista: TStrings);
    class procedure pAddDadosTeste(const ANomCds: String; AFonte: TDataSet; ADestino: TStrings);
    class procedure pCarregaDefCds(const AProvedor, ANomCds: String; out ADef: TNfdDefCds);
    class procedure pCarregaCampos(const AProvedor, ANomCds: String; ACampos: TObjectList);
    class procedure pCriarEstruturaDin(ACds: TUniClientDataSet; const ADef: TNfdDefCds;
      ACampos: TObjectList; AContexto: TNfdContexto);
    class procedure pPreencherDin(ACds: TUniClientDataSet; const ADef: TNfdDefCds;
      ACampos: TObjectList; const ANoRaiz: IXMLNode; AContexto: TNfdContexto);
    class procedure pMontarPorBancoDin(ACds: TUniClientDataSet; const ADef: TNfdDefCds;
      AContexto: TNfdContexto);
  end;

implementation

type
  TQueryDin = {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};

{ TNfsDinamico }

class function TNfsDinamico.fLocalName(const ANode: IXMLNode): String;
var
  intPos: Integer;
begin
  Result := '';
  if ANode = nil then
    Exit;

  Result := ANode.LocalName;
  if Result = '' then
  begin
    Result := ANode.NodeName;
    intPos := Pos(':', Result);
    if intPos > 0 then
      Result := Copy(Result, intPos + 1, MaxInt);
  end;
end;

class function TNfsDinamico.fBuscaFilho(const ANode: IXMLNode;
  const ANomeLocal: String): IXMLNode;
var
  i: Integer;
begin
  Result := nil;
  if (ANode = nil) or (not ANode.HasChildNodes) then
    Exit;

  for i := 0 to ANode.ChildNodes.Count - 1 do
  begin
    if SameText(fLocalName(ANode.ChildNodes[i]), ANomeLocal) then
    begin
      Result := ANode.ChildNodes[i];
      Exit;
    end;
  end;
end;

class function TNfsDinamico.fResolveValor(const ANoRaiz: IXMLNode;
  const ACaminho: String; out AEncontrado: Boolean): String;
var
  strResto, strSeg: String;
  noAtual, noFilho: IXMLNode;
  intPos: Integer;
  blnPrimeiro: Boolean;
begin
  Result := '';
  AEncontrado := False;

  if (ANoRaiz = nil) or fEmptyStr(ACaminho) then
    Exit;

  strResto := ACaminho;
  noAtual := ANoRaiz;
  blnPrimeiro := True;

  while strResto <> '' do
  begin
    intPos := Pos('.', strResto);
    if intPos > 0 then
    begin
      strSeg := Copy(strResto, 1, intPos - 1);
      strResto := Copy(strResto, intPos + 1, MaxInt);
    end
    else
    begin
      strSeg := strResto;
      strResto := '';
    end;

    if strSeg = '' then
      Continue;

    // o ultimo segmento pode ser um atributo do no atual (ex.: NFSe.infNFSe.@Id)
    if strSeg[1] = '@' then
    begin
      if strResto <> '' then
        Exit;
      strSeg := Copy(strSeg, 2, MaxInt);
      if noAtual.HasAttribute(strSeg) then
      begin
        AEncontrado := True;
        Result := VarToStr(noAtual.Attributes[strSeg]);
      end;
      Exit;
    end;

    if blnPrimeiro then
    begin
      blnPrimeiro := False;
      // o primeiro segmento pode ser o proprio elemento raiz ou ja um filho dele
      if not SameText(fLocalName(noAtual), strSeg) then
      begin
        noFilho := fBuscaFilho(noAtual, strSeg);
        if noFilho = nil then
          Exit;
        noAtual := noFilho;
      end;
    end
    else
    begin
      noFilho := fBuscaFilho(noAtual, strSeg);
      if noFilho = nil then
        Exit;
      noAtual := noFilho;
    end;
  end;

  if noAtual <> nil then
  begin
    AEncontrado := True;
    try
      Result := noAtual.Text;
    except
      Result := '';
    end;
  end;
end;

class function TNfsDinamico.fAplicaAjuste(const AAjuste, AValor, AAcesso, ACodEmp: String): String;
var
  qry: TQueryDin;
  strSql: String;
begin
  Result := AValor;
  if fEmptyStr(AAjuste) then
    Exit;

  // seguranca: somente um comando (os valores vao sempre parametrizados)
  if Pos(';', AAjuste) > 0 then
    raise Exception.CreateFmt('Ajuste invalido (comando multiplo) em IMPNFE_FLD: %s', [AAjuste]);

  strSql := AAjuste;
  strSql := StringReplace(strSql, 'VS_VALOR',  ':VALOR',  [rfReplaceAll, rfIgnoreCase]);
  strSql := StringReplace(strSql, 'VS_ACESSO', ':ACESSO', [rfReplaceAll, rfIgnoreCase]);
  strSql := StringReplace(strSql, 'VS_CODEMP', ':CODEMP', [rfReplaceAll, rfIgnoreCase]);

  qry := fCriaQuery(nil);
  try
    qry.SQL.Text := 'SELECT ' + strSql + ' AS RES';
    if qry.FindParam('VALOR')  <> nil then qry.ParamByName('VALOR').AsString  := AValor;
    if qry.FindParam('ACESSO') <> nil then qry.ParamByName('ACESSO').AsString := AAcesso;
    if qry.FindParam('CODEMP') <> nil then qry.ParamByName('CODEMP').AsString := ACodEmp;
    qry.Open;
    if not qry.IsEmpty then
      Result := qry.FieldByName('RES').AsString;
    qry.Close;
  finally
    FreeAndNil(qry);
  end;
end;

class procedure TNfsDinamico.pResolveTipoCampo(const ATipo: String;
  out ADataType: TFieldType; out ASize: Integer);
var
  s, sBase, sNum: String;
  p1, p2: Integer;
begin
  ADataType := ftString;
  ASize := 255;

  s := Trim(LowerCase(ATipo));
  if s = '' then
    Exit;

  sBase := s;

  p1 := Pos('(', s);
  if p1 > 0 then
  begin
    sBase := Trim(Copy(s, 1, p1 - 1));
    p2 := Pos(')', s);
    if p2 > p1 then
    begin
      sNum := Copy(s, p1 + 1, p2 - p1 - 1);
      if Pos(',', sNum) > 0 then
        sNum := Copy(sNum, 1, Pos(',', sNum) - 1);
      ASize := StrToIntDef(Trim(sNum), ASize);
    end;
  end;

  if (sBase = 'varchar') or (sBase = 'nvarchar') or (sBase = 'char') or (sBase = 'string') then
    ADataType := ftString
  else if (sBase = 'memo') or (sBase = 'text') or (sBase = 'longtext') or (sBase = 'clob') then
  begin
    ADataType := ftMemo;
    ASize := 0;
  end
  else if (sBase = 'int') or (sBase = 'integer') or (sBase = 'smallint') or
          (sBase = 'bigint') or (sBase = 'tinyint') then
  begin
    ADataType := ftInteger;
    ASize := 0;
  end
  else if (sBase = 'float') or (sBase = 'double') or (sBase = 'real') or
          (sBase = 'decimal') or (sBase = 'numeric') or (sBase = 'money') or
          (sBase = 'currency') then
  begin
    ADataType := ftFloat;
    ASize := 0;
  end
  else
    ADataType := ftString;
end;

class procedure TNfsDinamico.pAtribuiValorCampo(AField: TField; const AValor: String);
begin
  if AField = nil then
    Exit;

  case AField.DataType of
    ftFloat, ftCurrency, ftBCD, ftFMTBcd:
      AField.AsFloat := fStrToFloatDef(AValor);
    ftInteger, ftSmallint, ftWord, ftLargeint:
      AField.AsInteger := StrToIntDef(AValor, 0);
  else
    AField.AsString := AValor;
  end;
end;

class function TNfsDinamico.fExisteProvedor(const AProvedor: String): Boolean;
var
  qry: TQueryDin;
begin
  // qualquer falha (ex.: tabelas ainda nao criadas) devolve False: segue a rotina antiga
  Result := False;
  qry := fCriaQuery(nil);
  try
    try
      qry.SQL.Text :=
        'SELECT c.CDS_CODPRV FROM IMPNFE_CDS c ' +
        'WHERE c.CDS_CODPRV = :PRV LIMIT 1';
      qry.ParamByName('PRV').AsString := AProvedor;
      qry.Open;
      Result := not qry.IsEmpty;
      qry.Close;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

class function TNfsDinamico.fXmlObrigatorio(const AProvedor, AAcesso: String; out ADescricao: String): String;
var
  qry: TQueryDin;
begin
  // vazio ou coluna inexistente = sem validacao; falha na leitura registra e segue sem validar
  Result := '';
  ADescricao := '';
  if not fCampoExiste('IMPNFE_PRV', 'PRV_XMLOBR') then
    Exit;

  qry := fCriaQuery(nil);
  try
    try
      qry.SQL.Text :=
        'SELECT p.PRV_XMLOBR, p.PRV_DESCRI FROM IMPNFE_PRV p ' +
        'WHERE p.PRV_NOME = :PRV';
      qry.ParamByName('PRV').AsString := AProvedor;
      qry.Open;
      if not qry.IsEmpty then
      begin
        Result := Trim(qry.FieldByName('PRV_XMLOBR').AsString);
        ADescricao := Trim(qry.FieldByName('PRV_DESCRI').AsString);
      end;
      qry.Close;
    except
      on E: Exception do
      begin
        Result := '';
        ADescricao := '';
        pGravaLogDin('Aviso NfeImpressao NFS Dinamico', AAcesso,
          'Falha ao ler o PRV_XMLOBR do provedor ' + AProvedor + ': a validacao do layout do XML foi ignorada.',
          E.ClassName + ': ' + E.Message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

class procedure TNfsDinamico.pGravaLogDin(const ADescri, AAcesso, AMensagem: String;
  const AErro: String; ADiario: Boolean);
var
  strRel: String;
begin
  strRel := AMensagem;
  if Trim(AAcesso) <> '' then
    strRel := 'Chave de Acesso: ' + AAcesso + sLineBreak + strRel;
  if AErro <> '' then
    strRel := strRel + sLineBreak +
      '--------------------------------------------------------------' + sLineBreak + AErro;

  try
    pGravaLogErr(ADescri, strRel, ADiario);
  except
    on E: Exception do
    begin
      try
        pLogImp('Falha ao gravar a LOGERR (' + ADescri + '): ' + E.Message + ' | ' +
          StringReplace(strRel, sLineBreak, ' | ', [rfReplaceAll]));
      except
      end;
    end;
  end;
end;

class function TNfsDinamico.fCarregaCds(const AProvedor, ANomCds: String; out AOrigem, ASelect: String): Boolean;
var
  qry: TQueryDin;
begin
  Result := False;
  AOrigem := 'X';
  ASelect := '';

  qry := fCriaQuery(nil);
  try
    qry.SQL.Text :=
      'SELECT CDS_ORIGEM, CDS_SELECT FROM IMPNFE_CDS ' +
      'WHERE CDS_CODPRV = :PRV AND CDS_NOMCDS = :CDS';
    qry.ParamByName('PRV').AsString := AProvedor;
    qry.ParamByName('CDS').AsString := ANomCds;
    qry.Open;
    if not qry.IsEmpty then
    begin
      AOrigem := UpperCase(Trim(qry.FieldByName('CDS_ORIGEM').AsString));
      if AOrigem = '' then
        AOrigem := 'X';
      ASelect := qry.FieldByName('CDS_SELECT').AsString;
      Result := True;
    end;
    qry.Close;
  finally
    FreeAndNil(qry);
  end;
end;

class procedure TNfsDinamico.pMontarPorXml(var cds: TUniClientDataSet; const AProvedor, ANomCds: String;
  const AXML, AAcesso, ACodEmp: String);
var
  qryFld: TQueryDin;
  XmlDoc: IXMLDocument;
  noRaiz: IXMLNode;
  fld: TField;
  intTam: Integer;
  ftTipo: TFieldType;
  strNome, strCaminho, strCamAux, strAjuste, strDefault, strValor: String;
  blnAchou: Boolean;
begin
  XmlDoc := TXMLDocument.Create(nil);
  XmlDoc.LoadFromXML(AXML);
  XmlDoc.Active := True;
  noRaiz := XmlDoc.DocumentElement;

  qryFld := fCriaQuery(nil);
  try
    qryFld.SQL.Text :=
      'SELECT FLD_NOME, FLD_TIPO, FLD_CAMINH, FLD_CAMAUX, FLD_AJUSTE, FLD_DEFAUL ' +
      'FROM IMPNFE_FLD WHERE FLD_CODPRV = :PRV AND FLD_CODCDS = :CDS ORDER BY FLD_NOME';
    qryFld.ParamByName('PRV').AsString := AProvedor;
    qryFld.ParamByName('CDS').AsString := ANomCds;
    qryFld.Open;

    if cds.Active then
      cds.Close;
    cds.FieldDefs.Clear;

    while not qryFld.Eof do
    begin
      strNome := qryFld.FieldByName('FLD_NOME').AsString;
      if (strNome <> '') and (cds.FieldDefs.IndexOf(strNome) < 0) then
      begin
        pResolveTipoCampo(qryFld.FieldByName('FLD_TIPO').AsString, ftTipo, intTam);
        with cds.FieldDefs.AddFieldDef do
        begin
          Name := strNome;
          DataType := ftTipo;
          if intTam > 0 then
            Size := intTam;
        end;
      end;
      qryFld.Next;
    end;

    if cds.FieldDefs.Count = 0 then
      raise Exception.Create('Dataset dinamico (origem XML) sem campos definidos em IMPNFE_FLD.');

    cds.CreateDataSet;

    qryFld.First;
    cds.Append;
    try
      while not qryFld.Eof do
      begin
        strNome    := qryFld.FieldByName('FLD_NOME').AsString;
        strCaminho := qryFld.FieldByName('FLD_CAMINH').AsString;
        strCamAux  := qryFld.FieldByName('FLD_CAMAUX').AsString;
        strAjuste  := qryFld.FieldByName('FLD_AJUSTE').AsString;
        strDefault := qryFld.FieldByName('FLD_DEFAUL').AsString;

        fld := cds.FindField(strNome);
        if fld <> nil then
        begin
          strValor := '';
          blnAchou := False;
          if strCaminho <> '' then
            strValor := fResolveValor(noRaiz, strCaminho, blnAchou);

          // no 2 (caminho auxiliar): so quando o no 1 nao existe ou vem vazio
          if ((not blnAchou) or (strValor = '')) and (strCamAux <> '') then
            strValor := fResolveValor(noRaiz, strCamAux, blnAchou);

          if strAjuste <> '' then
          begin
            // ajuste e autoritativo: recebe VS_VALOR (do XML), VS_ACESSO e VS_CODEMP
            try
              strValor := fAplicaAjuste(strAjuste, strValor, AAcesso, ACodEmp);
            except
              on E: Exception do
                raise Exception.Create('Ajuste do campo ' + ANomCds + '.' + strNome + ': ' + E.Message);
            end;
          end
          else if (not blnAchou) or (strValor = '') then
            strValor := strDefault;

          pAtribuiValorCampo(fld, strValor);
        end;

        qryFld.Next;
      end;

      cds.Post;
    except
      cds.Cancel;
      raise;
    end;
  finally
    FreeAndNil(qryFld);
  end;
end;

class procedure TNfsDinamico.pMontarPorBanco(var cds: TUniClientDataSet;
  const ASelect, AAcesso, ACodEmp: String);
var
  qry: TQueryDin;
  strSql: String;
  i: Integer;
begin
  if fEmptyStr(ASelect) then
    raise Exception.Create('Dataset dinamico (origem Banco) sem SELECT definido (CDS_SELECT).');

  strSql := ASelect;
  strSql := StringReplace(strSql, 'VS_VALOR',  ':VALOR',  [rfReplaceAll, rfIgnoreCase]);
  strSql := StringReplace(strSql, 'VS_ACESSO', ':ACESSO', [rfReplaceAll, rfIgnoreCase]);
  strSql := StringReplace(strSql, 'VS_CODEMP', ':CODEMP', [rfReplaceAll, rfIgnoreCase]);

  qry := fCriaQuery(nil);
  try
    qry.SQL.Text := strSql;
    if qry.FindParam('VALOR')  <> nil then qry.ParamByName('VALOR').AsString  := '';
    if qry.FindParam('ACESSO') <> nil then qry.ParamByName('ACESSO').AsString := AAcesso;
    if qry.FindParam('CODEMP') <> nil then qry.ParamByName('CODEMP').AsString := ACodEmp;
    qry.Open;

    if cds.Active then
      cds.Close;
    cds.FieldDefs.Clear;

    for i := 0 to qry.FieldCount - 1 do
    begin
      with cds.FieldDefs.AddFieldDef do
      begin
        Name := qry.Fields[i].FieldName;
        case qry.Fields[i].DataType of
          ftString, ftWideString, ftFixedChar, ftFixedWideChar:
            begin
              DataType := ftString;
              Size := qry.Fields[i].Size;
              if Size <= 0 then
                Size := 255;
            end;
          ftSmallint, ftInteger, ftWord, ftLargeint, ftAutoInc:
            DataType := ftInteger;
          ftFloat, ftCurrency, ftBCD, ftFMTBcd:
            DataType := ftFloat;
          ftDate, ftTime, ftDateTime, ftTimeStamp:
            DataType := ftDateTime;
          ftMemo, ftWideMemo, ftFmtMemo:
            DataType := ftMemo;
          ftBoolean:
            DataType := ftBoolean;
        else
          begin
            DataType := ftString;
            Size := 255;
          end;
        end;
      end;
    end;

    if cds.FieldDefs.Count = 0 then
      raise Exception.Create('Dataset dinamico (origem Banco): o SELECT nao retornou colunas.');

    cds.CreateDataSet;

    qry.First;
    while not qry.Eof do
    begin
      cds.Append;
      for i := 0 to qry.FieldCount - 1 do
        cds.FieldByName(qry.Fields[i].FieldName).Value := qry.Fields[i].Value;
      cds.Post;
      qry.Next;
    end;
    cds.First;

    qry.Close;
  finally
    FreeAndNil(qry);
  end;
end;

class procedure TNfsDinamico.pMontarCds(var cds: TUniClientDataSet; const AProvedor, ANomCds: String;
  const AXML, AAcesso, ACodEmp: String);
var
  strOrigem, strSelect: String;
begin
  if not fCarregaCds(AProvedor, ANomCds, strOrigem, strSelect) then
    raise Exception.CreateFmt('CDS dinamico nao encontrado (provedor=%s, cds=%s).', [AProvedor, ANomCds]);

  if strOrigem = 'B' then
    pMontarPorBanco(cds, strSelect, AAcesso, ACodEmp)
  else
    pMontarPorXml(cds, AProvedor, ANomCds, AXML, AAcesso, ACodEmp);
end;

class function TNfsDinamico.fSubstituiMarcadores(const ASql: String;
  ACds: TUniClientDataSet; AFields: TStrings): String;

  function EhIdent(c: Char): Boolean;
  begin
    Result := ((c >= 'A') and (c <= 'Z')) or
              ((c >= 'a') and (c <= 'z')) or
              ((c >= '0') and (c <= '9')) or (c = '_');
  end;

var
  i, j, len: Integer;
  strToken, strUp: String;
begin
  Result := '';
  len := Length(ASql);
  i := 1;
  while i <= len do
  begin
    if (i + 2 <= len) and (UpperCase(Copy(ASql, i, 3)) = 'VS_') then
    begin
      j := i + 3;
      strToken := '';
      while (j <= len) and EhIdent(ASql[j]) do
      begin
        strToken := strToken + ASql[j];
        Inc(j);
      end;
      strUp := UpperCase(strToken);
      if strUp = 'ACESSO' then
        Result := Result + ':ACESSO'
      else if strUp = 'CODEMP' then
        Result := Result + ':CODEMP'
      else if strUp = 'VALOR' then
        Result := Result + ':VALOR'
      else if strUp = 'NUMDOC' then
        Result := Result + ':NUMDOC'
      else if strUp = 'ESPDOC' then
        Result := Result + ':ESPDOC'
      else if (ACds <> nil) and (ACds.FindField(strToken) <> nil) then
      begin
        Result := Result + ':P_' + strUp;
        if AFields.IndexOf(strToken) < 0 then
          AFields.Add(strToken);
      end
      else
        Result := Result + 'VS_' + strToken;
      i := j;
    end
    else
    begin
      Result := Result + ASql[i];
      Inc(i);
    end;
  end;
end;

class function TNfsDinamico.fExecEscalarVar(const ASelect: String;
  ACds: TUniClientDataSet; const AAcesso, ACodEmp, ANumDoc, AEspDoc: String; out AAchou: Boolean): String;
var
  qry: TQueryDin;
  lstFields: TStringList;
  strSql, strParam: String;
  k: Integer;
  fld: TField;
begin
  Result := '';
  AAchou := False;
  if fEmptyStr(ASelect) then
    Exit;

  // seguranca: somente um comando (valores vao sempre parametrizados)
  if Pos(';', ASelect) > 0 then
    raise Exception.CreateFmt('Select de variavel invalido (comando multiplo): %s', [ASelect]);

  lstFields := TStringList.Create;
  qry := fCriaQuery(nil);
  try
    strSql := fSubstituiMarcadores(ASelect, ACds, lstFields);
    qry.SQL.Text := strSql;

    if qry.FindParam('ACESSO') <> nil then qry.ParamByName('ACESSO').AsString := AAcesso;
    if qry.FindParam('CODEMP') <> nil then qry.ParamByName('CODEMP').AsString := ACodEmp;
    if qry.FindParam('VALOR')  <> nil then qry.ParamByName('VALOR').AsString  := '';
    if qry.FindParam('NUMDOC') <> nil then qry.ParamByName('NUMDOC').AsString := ANumDoc;
    if qry.FindParam('ESPDOC') <> nil then qry.ParamByName('ESPDOC').AsString := AEspDoc;

    for k := 0 to lstFields.Count - 1 do
    begin
      strParam := 'P_' + UpperCase(lstFields[k]);
      if qry.FindParam(strParam) = nil then
        Continue;
      fld := ACds.FieldByName(lstFields[k]);
      case fld.DataType of
        ftFloat, ftCurrency, ftBCD, ftFMTBcd:
          qry.ParamByName(strParam).AsFloat := fld.AsFloat;
        ftInteger, ftSmallint, ftWord, ftLargeint:
          qry.ParamByName(strParam).AsInteger := fld.AsInteger;
      else
        qry.ParamByName(strParam).AsString := fld.AsString;
      end;
    end;

    qry.Open;
    if not qry.IsEmpty then
    begin
      AAchou := True;
      Result := qry.Fields[0].AsString;
    end;
    qry.Close;
  finally
    FreeAndNil(qry);
    FreeAndNil(lstFields);
  end;
end;

class function TNfsDinamico.fAplicaFuncVar(const AFunc, AValor: String): String;
var
  strFunc: String;
begin
  Result := AValor;
  strFunc := UpperCase(Trim(AFunc));
  if strFunc = '' then
    Exit;
  if strFunc = 'CPFCNPJ' then
    Result := fFormataCpfCgc(AValor)
  else if strFunc = 'CEP' then
    Result := fFormataCEP(AValor)
  else if strFunc = 'FONE' then
    Result := fFormataFone(AValor)
  else if strFunc = 'UPPER' then
    Result := UpperCase(AValor);
end;

class procedure TNfsDinamico.pCarregaVariaveis(AReport: TfrxReport;
  const AProvedor: String; ACds: TUniClientDataSet; const AAcesso, ACodEmp, ANumDoc, AEspDoc: String;
  AContexto: TNfdContexto);
var
  qry: TQueryDin;
  strNome, strOrigem, strCampo, strSelect, strTipo, strFormato,
  strFunc, strDefault, strValor, strCdsVar: String;
  blnAchou, blnNum, blnTemVarCds: Boolean;
  cdsVar: TUniClientDataSet;
begin
  if AReport = nil then
    Exit;

  blnTemVarCds := (AContexto <> nil) and fCampoExiste('IMPNFE_VAR', 'VAR_CDS');

  qry := fCriaQuery(nil);
  try
    qry.SQL.Text :=
      'SELECT v.VAR_NOME, v.VAR_ORIGEM, v.VAR_CAMPO, v.VAR_SELECT, v.VAR_TIPO, ' +
      '       v.VAR_FORMAT, v.VAR_FUNC, v.VAR_DEFAUL ' +
      IfThen(blnTemVarCds, '       , v.VAR_CDS ', '') +
      'FROM IMPNFE_VAR v ' +
      'WHERE v.VAR_CODPRV = :PRV ' +
      'ORDER BY v.VAR_ORDEM, v.VAR_NOME';
    qry.ParamByName('PRV').AsString := AProvedor;
    qry.Open;

    while not qry.Eof do
    begin
      strNome    := Trim(qry.FieldByName('VAR_NOME').AsString);
      strOrigem  := UpperCase(Trim(qry.FieldByName('VAR_ORIGEM').AsString));
      strCampo   := Trim(qry.FieldByName('VAR_CAMPO').AsString);
      strSelect  := qry.FieldByName('VAR_SELECT').AsString;
      strTipo    := UpperCase(Trim(qry.FieldByName('VAR_TIPO').AsString));
      strFormato := Trim(qry.FieldByName('VAR_FORMAT').AsString);
      strFunc    := qry.FieldByName('VAR_FUNC').AsString;
      strDefault := qry.FieldByName('VAR_DEFAUL').AsString;

      strCdsVar := '';
      if blnTemVarCds then
        strCdsVar := Trim(qry.FieldByName('VAR_CDS').AsString);

      cdsVar := ACds;
      if strCdsVar <> '' then
        cdsVar := AContexto.fDataSetPorNome(strCdsVar);

      if strNome = '' then
      begin
        qry.Next;
        Continue;
      end;

      // o contexto pode recusar a variavel (ex.: PRM_* da NFC-e)
      if (AContexto <> nil) and (not AContexto.fAceitaVariavel(strNome)) then
      begin
        qry.Next;
        Continue;
      end;

      if strFormato = '' then
        strFormato := '#,##0.00';
      blnNum := (strTipo = 'NUM');

      strValor := '';
      blnAchou := False;

      try
        if strOrigem = 'F' then
        begin
          strValor := strDefault;
          blnAchou := True;
        end
        else if strOrigem = 'S' then
        begin
          strValor := fExecEscalarVar(strSelect, cdsVar, AAcesso, ACodEmp, ANumDoc, AEspDoc, blnAchou);
          if blnNum and blnAchou and (strValor <> '') then
            strValor := FormatFloat(strFormato, fStrToFloatDef(strValor));
        end
        else
        begin
          if (cdsVar <> nil) and cdsVar.Active and (cdsVar.FindField(strCampo) <> nil) then
          begin
            blnAchou := True;
            if blnNum then
              strValor := FormatFloat(strFormato, cdsVar.FieldByName(strCampo).AsFloat)
            else
              strValor := cdsVar.FieldByName(strCampo).AsString;
          end;
        end;

        // fallback para o default (evita erro/variavel indefinida no fr3)
        if (not blnAchou) or ((strValor = '') and (not blnNum)) then
          strValor := strDefault;

        if not blnNum then
          strValor := fAplicaFuncVar(strFunc, strValor);

        AReport.Script.Variables[strNome] := strValor;
      except
        // invisibilidade: nunca deixa a carga de variaveis quebrar a impressao
        try
          AReport.Script.Variables[strNome] := strDefault;
        except
        end;
      end;

      qry.Next;
    end;
    qry.Close;
  finally
    FreeAndNil(qry);
  end;
end;

{ Modelo novo (NF-e/NFC-e): valor do campo = XML > apoio > ajuste > funcao > default }

type
  TNfdParam = class
  public
    strNome: String;
    varValor: Variant;
  end;

  TNfdVarArray  = array of Variant;
  TNfdIntArray  = array of Integer;
  TNfdBoolArray = array of Boolean;

const
  cstLoteDin = 200; // registros por SELECT ... UNION ALL (ajuste / condicao)

{ TNfdContexto }

constructor TNfdContexto.Create;
begin
  inherited Create;
  FDataSets := TStringList.Create;
end;

destructor TNfdContexto.Destroy;
begin
  FNoRaiz := nil;
  FreeAndNil(FDataSets);
  inherited;
end;

procedure TNfdContexto.pRegistraDataSet(const ANomCds, ANomFrx: String; ACds: TUniClientDataSet);
begin
  if Trim(ANomCds) <> '' then
    FDataSets.AddObject(UpperCase(Trim(ANomCds)), ACds);
  if (Trim(ANomFrx) <> '') and (not SameText(Trim(ANomFrx), Trim(ANomCds))) then
    FDataSets.AddObject(UpperCase(Trim(ANomFrx)), ACds);
end;

function TNfdContexto.fDataSetPorNome(const ANome: String): TUniClientDataSet;
var
  intIdx: Integer;
begin
  Result := nil;
  intIdx := FDataSets.IndexOf(UpperCase(Trim(ANome)));
  if intIdx >= 0 then
    Result := TUniClientDataSet(FDataSets.Objects[intIdx]);
end;

function TNfdContexto.fMarcador(const ANome: String; out AValor: Variant): Boolean;
begin
  AValor := Null;
  Result := False;
end;

function TNfdContexto.fDataSetDoc(const ANome: String): TDataSet;
begin
  Result := nil;
end;

function TNfdContexto.fAplicaFuncao(const AFuncao: String; AParams: TStrings; const AValor: Variant;
  AEncontrado: Boolean; AField: TField; const ANoRegistro: IXMLNode; AIndice: Integer): Boolean;
begin
  Result := False;
end;

procedure TNfdContexto.pPosProcessa(const APosPrc: String; ACds: TUniClientDataSet);
begin
end;

procedure TNfdContexto.pGravaErro(const AOrigem, AMensagem: String);
begin
  // a gravacao do log nunca pode derrubar a impressao
  TNfsDinamico.pGravaLogDin('Erro NfeImpressao Dinamico', fChaveAcesso, AOrigem + sLineBreak + AMensagem);
end;

function TNfdContexto.fChaveAcesso: String;
begin
  Result := '';
end;

function TNfdContexto.fCaminhoBase(const ANomCds, ACamBas: String): String;
begin
  Result := ACamBas;
end;

function TNfdContexto.fLigaXmlDriverDoc(const ANomCds: String): Boolean;
begin
  Result := True;
end;

function TNfdContexto.fNormalizaChave(const AColuna: String; const AValor: Variant): Variant;
begin
  Result := AValor;
end;

function TNfdContexto.fAceitaVariavel(const ANome: String): Boolean;
begin
  Result := True;
end;

{ auxiliares do modelo novo }

function fXmlParaFloatDin(const AValor: String): Extended;
var
  strValor: String;
  intCod: Integer;
begin
  // Val: o XML usa '.' como decimal, independente da configuracao regional
  strValor := Trim(AValor);
  if (Pos(',', strValor) > 0) and (Pos('.', strValor) = 0) then
    strValor := StringReplace(strValor, ',', '.', [rfReplaceAll]);
  Val(strValor, Result, intCod);
  if intCod <> 0 then
    Result := 0;
end;

function fXmlParaDataHoraDin(const AValor: String): TDateTime;
var
  strValor: String;
  intAno, intMes, intDia, intHor, intMin, intSeg: Integer;
begin
  // mesma leitura do ACBr (TLeitor.rCampo tcDat/tcDatHor): ignora o fuso horario
  Result := 0;
  strValor := Trim(AValor);
  if Length(strValor) < 10 then
    Exit;
  intAno := StrToIntDef(Copy(strValor, 1, 4), 0);
  intMes := StrToIntDef(Copy(strValor, 6, 2), 0);
  intDia := StrToIntDef(Copy(strValor, 9, 2), 0);
  if not TryEncodeDate(intAno, intMes, intDia, Result) then
  begin
    Result := 0;
    Exit;
  end;
  if Length(strValor) >= 19 then
  begin
    intHor := StrToIntDef(Copy(strValor, 12, 2), 0);
    intMin := StrToIntDef(Copy(strValor, 15, 2), 0);
    intSeg := StrToIntDef(Copy(strValor, 18, 2), 0);
    if (intHor < 24) and (intMin < 60) and (intSeg < 60) then
      Result := Result + EncodeTime(intHor, intMin, intSeg, 0);
  end;
end;

function fValorCampoDin(AField: TField): Variant;
begin
  if (AField = nil) or AField.IsNull then
  begin
    Result := Null;
    Exit;
  end;
  case AField.DataType of
    ftFloat, ftCurrency, ftBCD, ftFMTBcd:
      Result := AField.AsFloat;
    ftInteger, ftSmallint, ftWord, ftLargeint, ftAutoInc:
      Result := AField.AsInteger;
    ftBoolean:
      Result := AField.AsBoolean;
    ftDate, ftTime, ftDateTime:
      Result := AField.AsDateTime;
  else
    Result := AField.AsString;
  end;
end;

procedure pAtribuiVariantDin(AField: TField; const AValor: Variant);
var
  strValor: String;
begin
  if AField = nil then
    Exit;

  if VarIsNull(AValor) or VarIsEmpty(AValor) then
  begin
    AField.Clear;
    Exit;
  end;

  case AField.DataType of
    ftFloat, ftCurrency, ftBCD, ftFMTBcd:
      if VarIsStr(AValor) then
        AField.AsFloat := fXmlParaFloatDin(VarToStr(AValor))
      else
        AField.AsFloat := AValor;
    ftInteger, ftSmallint, ftWord, ftLargeint:
      if VarIsStr(AValor) then
        AField.AsInteger := StrToIntDef(Trim(VarToStr(AValor)), 0)
      else
        AField.AsInteger := AValor;
    ftBoolean:
      if VarIsStr(AValor) then
      begin
        strValor := UpperCase(Trim(VarToStr(AValor)));
        AField.AsBoolean := (strValor = 'S') or (strValor = '1') or (strValor = 'T') or (strValor = 'TRUE');
      end
      else
        AField.AsBoolean := AValor;
    ftDate, ftTime, ftDateTime:
      if VarIsStr(AValor) then
      begin
        if Trim(VarToStr(AValor)) = '' then
          AField.Clear
        else
          AField.AsDateTime := fXmlParaDataHoraDin(VarToStr(AValor));
      end
      else
        AField.AsDateTime := VarToDateTime(AValor);
  else
    AField.AsString := VarToStr(AValor);
  end;
end;

function fVerdadeiroDin(const AValor: Variant): Boolean;
var
  strValor: String;
begin
  Result := False;
  if VarIsNull(AValor) or VarIsEmpty(AValor) then
    Exit;
  if VarIsStr(AValor) then
  begin
    strValor := UpperCase(Trim(VarToStr(AValor)));
    Result := (strValor <> '') and (strValor <> '0') and (strValor <> 'N') and (strValor <> 'FALSE');
  end
  else if VarType(AValor) = varBoolean then
    Result := AValor
  else
    Result := (AValor <> 0);
end;

procedure pDivideDin(const ATexto: String; const ASeparador: Char; ALista: TStrings);
var
  strResto, strItem: String;
  intPos: Integer;
begin
  ALista.Clear;
  strResto := ATexto;
  while strResto <> '' do
  begin
    intPos := Pos(ASeparador, strResto);
    if intPos > 0 then
    begin
      strItem := Copy(strResto, 1, intPos - 1);
      strResto := Copy(strResto, intPos + 1, MaxInt);
    end
    else
    begin
      strItem := strResto;
      strResto := '';
    end;
    if Trim(strItem) <> '' then
      ALista.Add(Trim(strItem));
  end;
end;

procedure pDivideFuncDin(const AFuncao: String; out ANome: String; AParams: TStrings);
var
  intIni, intFim: Integer;
begin
  // FUNCAO  ou  FUNCAO(param1;param2)
  AParams.Clear;
  ANome := Trim(AFuncao);
  intIni := Pos('(', ANome);
  if intIni > 0 then
  begin
    intFim := LastDelimiter(')', ANome);
    if intFim < intIni then
      intFim := Length(ANome) + 1;
    pDivideDin(Copy(ANome, intIni + 1, intFim - intIni - 1), ';', AParams);
    ANome := Trim(Copy(ANome, 1, intIni - 1));
  end;
  ANome := UpperCase(ANome);
end;

function fPrimeiroElementoDin(const ANo: IXMLNode): IXMLNode;
var
  i: Integer;
begin
  Result := nil;
  if (ANo = nil) or (not ANo.HasChildNodes) then
    Exit;
  for i := 0 to ANo.ChildNodes.Count - 1 do
    if ANo.ChildNodes[i].NodeType = ntElement then
    begin
      Result := ANo.ChildNodes[i];
      Exit;
    end;
end;

function fNavegaDin(const ANoRaiz: IXMLNode; const ACaminho: String; out AAtributo: String): IXMLNode;
var
  strResto, strSeg: String;
  noAtual, noFilho: IXMLNode;
  intPos: Integer;
  blnPrimeiro: Boolean;
begin
  // dot-path por nome local; o ultimo segmento pode ser atributo (@Id)
  Result := nil;
  AAtributo := '';
  if (ANoRaiz = nil) or (Trim(ACaminho) = '') then
    Exit;

  strResto := Trim(ACaminho);
  noAtual := ANoRaiz;
  blnPrimeiro := True;
  while strResto <> '' do
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

    if strSeg[1] = '@' then
    begin
      if Trim(strResto) <> '' then
        Exit;
      AAtributo := Copy(strSeg, 2, MaxInt);
      Break;
    end;

    if blnPrimeiro and SameText(TNfsDinamico.fLocalName(noAtual), strSeg) then
    begin
      blnPrimeiro := False;
      Continue;
    end;
    blnPrimeiro := False;

    // '*' = primeiro elemento filho (ex.: imposto.ICMS.*.vBC, o grupo varia pelo CST)
    if strSeg = '*' then
      noFilho := fPrimeiroElementoDin(noAtual)
    else
      noFilho := TNfsDinamico.fBuscaFilho(noAtual, strSeg);
    if noFilho = nil then
      Exit;
    noAtual := noFilho;
  end;
  Result := noAtual;
end;

function fValorNoDin(const ANo: IXMLNode; const ACaminho: String; out AEncontrado: Boolean): String;
var
  noAlvo: IXMLNode;
  strAtributo: String;
begin
  Result := '';
  AEncontrado := False;
  noAlvo := fNavegaDin(ANo, ACaminho, strAtributo);
  if noAlvo = nil then
    Exit;

  if strAtributo <> '' then
  begin
    if noAlvo.HasAttribute(strAtributo) then
    begin
      AEncontrado := True;
      Result := Trim(VarToStr(noAlvo.Attributes[strAtributo]));
    end;
  end
  else
  begin
    AEncontrado := True;
    try
      // como o leitor do ACBr: conteudo da tag com trim
      Result := Trim(noAlvo.Text);
    except
      Result := '';
    end;
  end;
end;

function fValorXmlDin(const ANoRegistro, ANoRaiz: IXMLNode; const ACaminho: String;
  out AEncontrado: Boolean): String;
begin
  // "/caminho" = a partir da raiz do documento
  if Copy(Trim(ACaminho), 1, 1) = '/' then
    Result := fValorNoDin(ANoRaiz, Copy(Trim(ACaminho), 2, MaxInt), AEncontrado)
  else
    Result := fValorNoDin(ANoRegistro, ACaminho, AEncontrado);
end;

procedure pColetaNosUmDin(const ANoRaiz: IXMLNode; const ACamBas: String; ANos: TInterfaceList);
var
  strCaminho, strPai, strFilho, strAtributo: String;
  noPai: IXMLNode;
  intPos, i: Integer;
begin
  strCaminho := Trim(ACamBas);
  strAtributo := '';
  intPos := LastDelimiter('.', strCaminho);
  if intPos > 0 then
  begin
    strPai := Copy(strCaminho, 1, intPos - 1);
    strFilho := Trim(Copy(strCaminho, intPos + 1, MaxInt));
    noPai := fNavegaDin(ANoRaiz, strPai, strAtributo);
  end
  else
  begin
    strFilho := strCaminho;
    noPai := ANoRaiz;
  end;

  if (noPai = nil) or (strAtributo <> '') or (strFilho = '') then
    Exit;

  for i := 0 to noPai.ChildNodes.Count - 1 do
    if SameText(TNfsDinamico.fLocalName(noPai.ChildNodes[i]), strFilho) then
      ANos.Add(noPai.ChildNodes[i]);
end;

procedure pColetaNosDin(const ANoRaiz: IXMLNode; const ACamBas: String; ANos: TInterfaceList);
var
  strResto, strAlt: String;
  intPos: Integer;
begin
  // alternativas separadas por "|": vale a primeira que tiver nos
  strResto := ACamBas;
  while (ANos.Count = 0) and (Trim(strResto) <> '') do
  begin
    intPos := Pos('|', strResto);
    if intPos > 0 then
    begin
      strAlt := Copy(strResto, 1, intPos - 1);
      strResto := Copy(strResto, intPos + 1, MaxInt);
    end
    else
    begin
      strAlt := strResto;
      strResto := '';
    end;
    if Trim(strAlt) <> '' then
      pColetaNosUmDin(ANoRaiz, strAlt, ANos);
  end;
end;

function fNoDaListaDin(ANos: TInterfaceList; AIndice: Integer): IXMLNode;
begin
  Result := nil;
  if (AIndice >= 0) and (AIndice < ANos.Count) and (ANos[AIndice] <> nil) then
    Result := ANos[AIndice] as IXMLNode;
end;

procedure pAddParamDin(AParams: TObjectList; const ANome: String; const AValor: Variant);
var
  i: Integer;
  prm: TNfdParam;
begin
  for i := 0 to AParams.Count - 1 do
    if SameText(TNfdParam(AParams[i]).strNome, ANome) then
      Exit;
  prm := TNfdParam.Create;
  AParams.Add(prm);
  prm.strNome := ANome;
  prm.varValor := AValor;
end;

procedure pSetParamDin(AParam: TParam; const AValor: Variant);
begin
  if AParam = nil then
    Exit;
  if VarIsNull(AValor) or VarIsEmpty(AValor) then
  begin
    AParam.DataType := ftString;
    AParam.Clear;
    Exit;
  end;
  case VarType(AValor) of
    varSingle, varDouble, varCurrency:
      AParam.AsFloat := AValor;
    varSmallint, varInteger, varShortInt, varByte, varWord, varLongWord:
      AParam.AsInteger := AValor;
    varInt64:
      AParam.AsFloat := AValor;
    varDate:
      AParam.AsDateTime := AValor;
    varBoolean:
      AParam.AsBoolean := AValor;
  else
    AParam.AsString := VarToStr(AValor);
  end;
end;

procedure pAplicaParamsDin(AQry: TQueryDin; AParams: TObjectList);
var
  i: Integer;
  prm: TNfdParam;
begin
  for i := 0 to AParams.Count - 1 do
  begin
    prm := TNfdParam(AParams[i]);
    if AQry.FindParam(prm.strNome) <> nil then
      pSetParamDin(AQry.ParamByName(prm.strNome), prm.varValor);
  end;
end;

function fMontaSqlDin(const ASql, ASufixo: String; ACds: TUniClientDataSet; AContexto: TNfdContexto;
  AIndice: Integer; const AValor: Variant; AParams: TObjectList): String;

  function EhIdent(c: Char): Boolean;
  begin
    Result := ((c >= 'A') and (c <= 'Z')) or
              ((c >= 'a') and (c <= 'z')) or
              ((c >= '0') and (c <= '9')) or (c = '_');
  end;

var
  i, j, intLen, intSep: Integer;
  strToken, strUp, strParam, strCampo: String;
  cdsOutro: TUniClientDataSet;
  varValor: Variant;
begin
  // marcadores VS_* viram parametros (nada e concatenado)
  Result := '';
  intLen := Length(ASql);
  i := 1;
  while i <= intLen do
  begin
    if (i + 2 <= intLen) and (UpperCase(Copy(ASql, i, 3)) = 'VS_') and
       ((i = 1) or (not EhIdent(ASql[i - 1]))) then
    begin
      j := i + 3;
      strToken := '';
      while (j <= intLen) and EhIdent(ASql[j]) do
      begin
        strToken := strToken + ASql[j];
        Inc(j);
      end;
      strUp := UpperCase(strToken);
      intSep := Pos('__', strToken);

      if strUp = 'VALOR' then
      begin
        strParam := 'V' + ASufixo;
        if VarIsNull(AValor) or VarIsEmpty(AValor) then
          pAddParamDin(AParams, strParam, '')
        else
          pAddParamDin(AParams, strParam, AValor);
        Result := Result + ':' + strParam;
      end
      else if strUp = 'NITEM' then
      begin
        strParam := 'N' + ASufixo;
        pAddParamDin(AParams, strParam, AIndice);
        Result := Result + ':' + strParam;
      end
      else if (intSep > 1) and (AContexto <> nil) then
      begin
        cdsOutro := AContexto.fDataSetPorNome(Copy(strToken, 1, intSep - 1));
        strCampo := Copy(strToken, intSep + 2, MaxInt);
        if (cdsOutro <> nil) and cdsOutro.Active and (cdsOutro.FindField(strCampo) <> nil) then
        begin
          strParam := 'D_' + strUp + ASufixo;
          pAddParamDin(AParams, strParam, fValorCampoDin(cdsOutro.FieldByName(strCampo)));
          Result := Result + ':' + strParam;
        end
        else
          Result := Result + 'VS_' + strToken;
      end
      else if (ACds <> nil) and ACds.Active and (ACds.FindField(strToken) <> nil) then
      begin
        strParam := 'P_' + strUp + ASufixo;
        pAddParamDin(AParams, strParam, fValorCampoDin(ACds.FieldByName(strToken)));
        Result := Result + ':' + strParam;
      end
      else if (AContexto <> nil) and AContexto.fMarcador(strUp, varValor) then
      begin
        strParam := 'M_' + strUp + ASufixo;
        pAddParamDin(AParams, strParam, varValor);
        Result := Result + ':' + strParam;
      end
      else
        Result := Result + 'VS_' + strToken;
      i := j;
    end
    else
    begin
      Result := Result + ASql[i];
      Inc(i);
    end;
  end;
end;

function fAbreSelectDin(const ASql: String; AContexto: TNfdContexto): TQueryDin;
var
  lstParams: TObjectList;
begin
  // seguranca: somente um comando (os valores vao sempre parametrizados)
  if Pos(';', ASql) > 0 then
    raise Exception.CreateFmt('SELECT dinamico invalido (comando multiplo): %s', [ASql]);

  Result := fCriaQuery(nil);
  try
    lstParams := TObjectList.Create(True);
    try
      Result.SQL.Text := fMontaSqlDin(ASql, '', nil, AContexto, 0, '', lstParams);
      pAplicaParamsDin(Result, lstParams);
    finally
      FreeAndNil(lstParams);
    end;
    Result.Open;
  except
    FreeAndNil(Result);
    raise;
  end;
end;

procedure pExecLoteDin(const AExpr: String; ACds: TUniClientDataSet; AContexto: TNfdContexto;
  const ARecNos, AIndices: TNfdIntArray; const AValores: TNfdVarArray; var AResultados: TNfdVarArray);
var
  qry: TQueryDin;
  lstParams: TObjectList;
  strSql, strExpr: String;
  intIni, intFim, k: Integer;
begin
  // uma expressao por registro, em lote (UNION ALL)
  SetLength(AResultados, Length(ARecNos));
  for k := 0 to High(AResultados) do
    AResultados[k] := Null;
  if Length(ARecNos) = 0 then
    Exit;

  if Pos(';', AExpr) > 0 then
    raise Exception.CreateFmt('Expressao dinamica invalida (comando multiplo): %s', [AExpr]);

  intIni := 0;
  while intIni <= High(ARecNos) do
  begin
    intFim := intIni + cstLoteDin - 1;
    if intFim > High(ARecNos) then
      intFim := High(ARecNos);

    lstParams := TObjectList.Create(True);
    try
      qry := fCriaQuery(nil);
      try
        strSql := '';
        for k := intIni to intFim do
        begin
          if (ACds <> nil) and ACds.Active and (ARecNos[k] > 0) then
            ACds.RecNo := ARecNos[k];
          strExpr := fMontaSqlDin(AExpr, '_' + IntToStr(k), ACds, AContexto, AIndices[k], AValores[k], lstParams);
          if strSql <> '' then
            strSql := strSql + ' UNION ALL ';
          // expressao em linhas proprias: aceita texto multilinha e comentario "--" no fim
          strSql := strSql + 'SELECT ' + IntToStr(k) + ' AS IDX, (' + sLineBreak +
            strExpr + sLineBreak + ') AS RES';
        end;

        qry.SQL.Text := strSql;
        pAplicaParamsDin(qry, lstParams);
        qry.Open;
        while not qry.Eof do
        begin
          k := qry.FieldByName('IDX').AsInteger;
          if (k >= 0) and (k <= High(AResultados)) then
            AResultados[k] := qry.FieldByName('RES').Value;
          qry.Next;
        end;
        qry.Close;
      finally
        FreeAndNil(qry);
      end;
    finally
      FreeAndNil(lstParams);
    end;

    intIni := intFim + 1;
  end;
end;

function fLigaApoioDin(ADs: TDataSet; const AChvSel: String; const ANo: IXMLNode; AIndice: Integer): Integer;
var
  lstPares: TStringList;
  strCols, strOrigem: String;
  varChaves: Variant;
  intIni, i, intQtd: Integer;
  blnAchou: Boolean;
begin
  // sem achar com todas as chaves, descarta a primeira e tenta de novo (como o Locate)
  Result := 0;
  if (ADs = nil) or (not ADs.Active) or ADs.IsEmpty then
    Exit;

  if Trim(AChvSel) = '' then
  begin
    ADs.First;
    Result := ADs.RecNo;
    Exit;
  end;

  lstPares := TStringList.Create;
  try
    pDivideDin(AChvSel, ';', lstPares);
    intQtd := lstPares.Count;
    for intIni := 0 to intQtd - 1 do
    begin
      strCols := '';
      varChaves := VarArrayCreate([0, intQtd - intIni - 1], varVariant);
      for i := intIni to intQtd - 1 do
      begin
        if strCols <> '' then
          strCols := strCols + ';';
        strCols := strCols + Trim(lstPares.Names[i]);
        strOrigem := Trim(lstPares.ValueFromIndex[i]);
        if SameText(strOrigem, '#NITEM') then
          varChaves[i - intIni] := AIndice
        else
          varChaves[i - intIni] := fValorNoDin(ANo, strOrigem, blnAchou);
      end;

      ADs.First;
      if intQtd - intIni = 1 then
        blnAchou := ADs.Locate(strCols, varChaves[0], [])
      else
        blnAchou := ADs.Locate(strCols, varChaves, []);

      if blnAchou then
      begin
        Result := ADs.RecNo;
        Exit;
      end;
    end;
  finally
    FreeAndNil(lstPares);
  end;
end;

{ ligacao por ocorrencia (+OCOR): a k-esima ocorrencia no XML liga a k-esima linha com o mesmo valor }

function fEhOcorDin(const AChvSel: String): Boolean;
begin
  Result := Pos('+OCOR', UpperCase(AChvSel)) > 0;
end;

procedure pParseOcorDin(const AChvSel: String; out AColuna, AOrigem, AOrdem: String);
var
  strResto: String;
  intPos, intIni, intFim: Integer;
begin
  AColuna := '';
  AOrigem := '';
  AOrdem := '';
  strResto := Trim(AChvSel);
  intPos := Pos('=', strResto);
  if intPos <= 1 then
    Exit;
  AColuna := Trim(Copy(strResto, 1, intPos - 1));
  strResto := Copy(strResto, intPos + 1, MaxInt);
  intPos := Pos('+OCOR', UpperCase(strResto));
  if intPos <= 0 then
    Exit;
  AOrigem := Trim(Copy(strResto, 1, intPos - 1));
  strResto := Copy(strResto, intPos + 5, MaxInt);
  intIni := Pos('(', strResto);
  intFim := Pos(')', strResto);
  if (intIni > 0) and (intFim > intIni) then
    AOrdem := Trim(Copy(strResto, intIni + 1, intFim - intIni - 1));
end;

function fChaveOcorDin(const AValor: Variant; const AColuna: String; AContexto: TNfdContexto): String;
begin
  if AContexto <> nil then
    Result := Trim(VarToStr(AContexto.fNormalizaChave(AColuna, AValor)))
  else
    Result := Trim(VarToStr(AValor));
end;

procedure pContaOcorDin(ACont: TStringList; const AValor: String; out AOcor: Integer);
var
  intIdx: Integer;
begin
  intIdx := ACont.IndexOf(AValor);
  if intIdx < 0 then
    intIdx := ACont.AddObject(AValor, TObject(0));
  AOcor := Integer(ACont.Objects[intIdx]) + 1;
  ACont.Objects[intIdx] := TObject(AOcor);
end;

procedure pChavesOcorDsDin(ADs: TDataSet; const AColuna, AOrdem: String; AContexto: TNfdContexto;
  AChaves: TStringList);
var
  lstOrdem, lstCont: TStringList;
  fldCol, fldOrd: TField;
  intRecOri, i, intOcor: Integer;
  strValor: String;
begin
  // chave "valor#k" de cada linha; Objects = RecNo da linha
  AChaves.Clear;
  AChaves.CaseSensitive := True;
  if (ADs = nil) or (not ADs.Active) or ADs.IsEmpty then
    Exit;
  fldCol := ADs.FindField(AColuna);
  if fldCol = nil then
    Exit;
  fldOrd := nil;
  if AOrdem <> '' then
    fldOrd := ADs.FindField(AOrdem);

  lstOrdem := TStringList.Create;
  lstCont := TStringList.Create;
  intRecOri := ADs.RecNo;
  try
    lstCont.CaseSensitive := True;
    ADs.First;
    while not ADs.Eof do
    begin
      if fldOrd <> nil then
        lstOrdem.AddObject(FormatFloat('000000000000000000.000000', fldOrd.AsFloat) + '#' +
          FormatFloat('0000000000', ADs.RecNo), TObject(ADs.RecNo))
      else
        lstOrdem.AddObject(FormatFloat('0000000000', ADs.RecNo), TObject(ADs.RecNo));
      ADs.Next;
    end;
    lstOrdem.Sort;

    for i := 0 to lstOrdem.Count - 1 do
    begin
      ADs.RecNo := Integer(lstOrdem.Objects[i]);
      strValor := fChaveOcorDin(fValorCampoDin(fldCol), AColuna, AContexto);
      pContaOcorDin(lstCont, strValor, intOcor);
      AChaves.AddObject(strValor + '#' + IntToStr(intOcor), lstOrdem.Objects[i]);
    end;
  finally
    if intRecOri > 0 then
      ADs.RecNo := intRecOri;
    FreeAndNil(lstCont);
    FreeAndNil(lstOrdem);
  end;
end;

procedure pChavesOcorNosDin(ANos: TInterfaceList; const AColuna, AOrigem: String; AContexto: TNfdContexto;
  AChaves: TStringList);
var
  lstCont: TStringList;
  i, intOcor: Integer;
  strValor: String;
  blnAchou: Boolean;
begin
  // chave "valor#k" de cada no, na ordem do documento; Objects = indice na lista
  AChaves.Clear;
  AChaves.CaseSensitive := True;
  lstCont := TStringList.Create;
  try
    lstCont.CaseSensitive := True;
    for i := 0 to ANos.Count - 1 do
    begin
      if fNoDaListaDin(ANos, i) = nil then
        Continue;
      strValor := fChaveOcorDin(fValorNoDin(fNoDaListaDin(ANos, i), AOrigem, blnAchou), AColuna, AContexto);
      pContaOcorDin(lstCont, strValor, intOcor);
      AChaves.AddObject(strValor + '#' + IntToStr(intOcor), TObject(i));
    end;
  finally
    FreeAndNil(lstCont);
  end;
end;

procedure pLigaApoioOcorDin(ADs: TDataSet; const AChvSel: String; ANos: TInterfaceList;
  var ARecApoio: TNfdIntArray; AContexto: TNfdContexto);
var
  lstDs, lstXml: TStringList;
  strColuna, strOrigem, strOrdem: String;
  i, intIdx, intReg: Integer;
begin
  pParseOcorDin(AChvSel, strColuna, strOrigem, strOrdem);
  if (strColuna = '') or (strOrigem = '') then
    Exit;
  lstDs := TStringList.Create;
  lstXml := TStringList.Create;
  try
    pChavesOcorDsDin(ADs, strColuna, strOrdem, AContexto, lstDs);
    pChavesOcorNosDin(ANos, strColuna, strOrigem, AContexto, lstXml);
    for i := 0 to lstXml.Count - 1 do
    begin
      intIdx := lstDs.IndexOf(lstXml[i]);
      intReg := Integer(lstXml.Objects[i]);
      if (intIdx >= 0) and (intReg >= 0) and (intReg <= High(ARecApoio)) then
        ARecApoio[intReg] := Integer(lstDs.Objects[intIdx]);
    end;
  finally
    FreeAndNil(lstXml);
    FreeAndNil(lstDs);
  end;
end;

procedure pLigaNosOcorDin(ADs: TDataSet; const AChvSel: String; const ANoRaiz: IXMLNode;
  const ACamBas: String; ANos: TInterfaceList; AContexto: TNfdContexto);
var
  lstXmlNos: TInterfaceList;
  lstDs, lstXml: TStringList;
  strColuna, strOrigem, strOrdem: String;
  i, intIdx, intReg: Integer;
begin
  // registros do @DOC (linha r = RecNo r + 1): cada linha recebe o no XML com a mesma chave
  pParseOcorDin(AChvSel, strColuna, strOrigem, strOrdem);
  if (strColuna = '') or (strOrigem = '') then
    Exit;
  lstXmlNos := TInterfaceList.Create;
  lstDs := TStringList.Create;
  lstXml := TStringList.Create;
  try
    pColetaNosDin(ANoRaiz, ACamBas, lstXmlNos);
    pChavesOcorDsDin(ADs, strColuna, strOrdem, AContexto, lstDs);
    pChavesOcorNosDin(lstXmlNos, strColuna, strOrigem, AContexto, lstXml);
    for i := 0 to lstDs.Count - 1 do
    begin
      intIdx := lstXml.IndexOf(lstDs[i]);
      intReg := Integer(lstDs.Objects[i]) - 1;
      if (intIdx >= 0) and (intReg >= 0) and (intReg < ANos.Count) then
        ANos[intReg] := fNoDaListaDin(lstXmlNos, Integer(lstXml.Objects[intIdx]));
    end;
  finally
    FreeAndNil(lstXml);
    FreeAndNil(lstDs);
    FreeAndNil(lstXmlNos);
  end;
end;

procedure pResolveTipoCampoDin(const ATipo: String; out ADataType: TFieldType; out ASize: Integer);
var
  strTipo, strBase, strNum: String;
  intIni, intFim: Integer;
begin
  strTipo := Trim(LowerCase(ATipo));
  strBase := strTipo;
  strNum := '';
  intIni := Pos('(', strTipo);
  if intIni > 0 then
  begin
    strBase := Trim(Copy(strTipo, 1, intIni - 1));
    intFim := Pos(')', strTipo);
    if intFim > intIni then
      strNum := Trim(Copy(strTipo, intIni + 1, intFim - intIni - 1));
  end;

  if (strBase = 'boolean') or (strBase = 'bool') then
  begin
    ADataType := ftBoolean;
    ASize := 0;
  end
  else if (strBase = 'datetime') or (strBase = 'date') or (strBase = 'timestamp') then
  begin
    ADataType := ftDateTime;
    ASize := 0;
  end
  else if strBase = 'blob' then
  begin
    ADataType := ftBlob;
    ASize := StrToIntDef(strNum, 0);
  end
  else if strBase = 'graphic' then
  begin
    ADataType := ftGraphic;
    ASize := StrToIntDef(strNum, 0);
  end
  else
    TNfsDinamico.pResolveTipoCampo(ATipo, ADataType, ASize);
end;

class procedure TNfsDinamico.pNomesCds(const AProvedor: String; ALista: TStrings);
var
  qry: TQueryDin;
begin
  ALista.Clear;
  qry := fCriaQuery(nil);
  try
    qry.SQL.Text :=
      'SELECT CDS_NOMCDS FROM IMPNFE_CDS WHERE CDS_CODPRV = :PRV ' +
      IfThen(fModeloNovoDisponivel, 'ORDER BY CDS_ORDEM, CDS_NOMCDS', 'ORDER BY CDS_NOMCDS');
    qry.ParamByName('PRV').AsString := AProvedor;
    qry.Open;
    while not qry.Eof do
    begin
      ALista.Add(qry.FieldByName('CDS_NOMCDS').AsString);
      qry.Next;
    end;
    qry.Close;
  finally
    FreeAndNil(qry);
  end;
end;

class procedure TNfsDinamico.pAddDadosTeste(const ANomCds: String; AFonte: TDataSet; ADestino: TStrings);
var
  cds: TUniClientDataSet;
begin
  cds := TUniClientDataSet.Create(nil);
  ADestino.AddObject(ANomCds, cds);
  if (AFonte is TUniClientDataSet) and AFonte.Active then
  begin
    cds.Data := TUniClientDataSet(AFonte).Data;
    cds.IndexFieldNames := TUniClientDataSet(AFonte).IndexFieldNames;
  end;
end;

class procedure TNfsDinamico.pListaVariaveis(AReport: TfrxReport; const AProvedor: String; ALista: TStrings);

  function fUmaLinha(const ATexto: String): String;
  begin
    Result := StringReplace(ATexto, #13#10, ' | ', [rfReplaceAll]);
    Result := StringReplace(Result, #13, ' | ', [rfReplaceAll]);
    Result := StringReplace(Result, #10, ' | ', [rfReplaceAll]);
    Result := Trim(StringReplace(Result, #9, ' ', [rfReplaceAll]));
  end;

var
  qry: TQueryDin;
  blnTemVarCds: Boolean;
  strNome, strOrigem, strDescr, strCds, strValor: String;
  varValor: Variant;
begin
  ALista.Clear;
  if AReport = nil then
    Exit;

  blnTemVarCds := fCampoExiste('IMPNFE_VAR', 'VAR_CDS');

  qry := fCriaQuery(nil);
  try
    qry.SQL.Text :=
      'SELECT v.VAR_NOME, v.VAR_ORIGEM, v.VAR_CAMPO, v.VAR_SELECT ' +
      IfThen(blnTemVarCds, ', v.VAR_CDS ', '') +
      'FROM IMPNFE_VAR v ' +
      'WHERE v.VAR_CODPRV = :PRV ' +
      'ORDER BY v.VAR_ORDEM, v.VAR_NOME';
    qry.ParamByName('PRV').AsString := AProvedor;
    qry.Open;

    while not qry.Eof do
    begin
      strNome := Trim(qry.FieldByName('VAR_NOME').AsString);
      if strNome <> '' then
      begin
        strOrigem := UpperCase(Trim(qry.FieldByName('VAR_ORIGEM').AsString));
        if strOrigem = 'F' then
          strDescr := 'F - Fixo'
        else if strOrigem = 'S' then
          strDescr := 'S - ' + fUmaLinha(qry.FieldByName('VAR_SELECT').AsString)
        else
        begin
          strCds := '';
          if blnTemVarCds then
            strCds := Trim(qry.FieldByName('VAR_CDS').AsString);
          if strCds <> '' then
            strCds := strCds + '.';
          strDescr := 'C - ' + strCds + Trim(qry.FieldByName('VAR_CAMPO').AsString);
        end;

        strValor := '(nao carregada no relatorio)';
        try
          varValor := AReport.Script.Variables[strNome];
          if not (VarIsNull(varValor) or VarIsEmpty(varValor)) then
            strValor := fUmaLinha(VarToStr(varValor));
        except
          on E: Exception do
            strValor := '(erro: ' + E.Message + ')';
        end;

        ALista.Add(strNome + #9 + strDescr + #9 + strValor);
      end;
      qry.Next;
    end;
    qry.Close;
  finally
    FreeAndNil(qry);
  end;
end;

class function TNfsDinamico.fModeloNovoDisponivel: Boolean;
begin
  // qualquer falha = modelo novo indisponivel
  try
    Result := fCampoExiste('IMPNFE_CDS', 'CDS_CAMBAS') and
              fCampoExiste('IMPNFE_CDS', 'CDS_CHVSEL') and
              fCampoExiste('IMPNFE_CDS', 'CDS_CONDIC') and
              fCampoExiste('IMPNFE_CDS', 'CDS_REGVAZ') and
              fCampoExiste('IMPNFE_CDS', 'CDS_POSPRC') and
              fCampoExiste('IMPNFE_CDS', 'CDS_ORDEM') and
              fCampoExiste('IMPNFE_FLD', 'FLD_COLSEL') and
              fCampoExiste('IMPNFE_FLD', 'FLD_FUNC') and
              fCampoExiste('IMPNFE_FLD', 'FLD_ORDEM');
  except
    Result := False;
  end;
end;

class procedure TNfsDinamico.pCarregaDefCds(const AProvedor, ANomCds: String; out ADef: TNfdDefCds);
var
  qry: TQueryDin;
begin
  ADef.strNomCds := ANomCds;
  ADef.strNomFrx := '';
  ADef.strOrigem := 'X';
  ADef.strSelect := '';
  ADef.strCamBas := '';
  ADef.strChvSel := '';
  ADef.strCondic := '';
  ADef.strRegVaz := '';
  ADef.strPosPrc := '';

  qry := fCriaQuery(nil);
  try
    qry.SQL.Text :=
      'SELECT CDS_NOMFRX, CDS_ORIGEM, CDS_SELECT, CDS_CAMBAS, CDS_CHVSEL, ' +
      '       CDS_CONDIC, CDS_REGVAZ, CDS_POSPRC ' +
      'FROM IMPNFE_CDS WHERE CDS_CODPRV = :PRV AND CDS_NOMCDS = :CDS';
    qry.ParamByName('PRV').AsString := AProvedor;
    qry.ParamByName('CDS').AsString := ANomCds;
    qry.Open;
    if qry.IsEmpty then
      raise Exception.CreateFmt('CDS dinamico nao encontrado (provedor=%s, cds=%s).', [AProvedor, ANomCds]);

    ADef.strNomFrx := Trim(qry.FieldByName('CDS_NOMFRX').AsString);
    ADef.strOrigem := UpperCase(Trim(qry.FieldByName('CDS_ORIGEM').AsString));
    if ADef.strOrigem = '' then
      ADef.strOrigem := 'X';
    ADef.strSelect := qry.FieldByName('CDS_SELECT').AsString;
    ADef.strCamBas := Trim(qry.FieldByName('CDS_CAMBAS').AsString);
    ADef.strChvSel := Trim(qry.FieldByName('CDS_CHVSEL').AsString);
    ADef.strCondic := qry.FieldByName('CDS_CONDIC').AsString;
    ADef.strRegVaz := UpperCase(Trim(qry.FieldByName('CDS_REGVAZ').AsString));
    ADef.strPosPrc := UpperCase(Trim(qry.FieldByName('CDS_POSPRC').AsString));
    qry.Close;
  finally
    FreeAndNil(qry);
  end;
end;

class procedure TNfsDinamico.pCarregaCampos(const AProvedor, ANomCds: String; ACampos: TObjectList);
var
  qry: TQueryDin;
  cmp: TNfdCampo;
begin
  ACampos.Clear;
  qry := fCriaQuery(nil);
  try
    qry.SQL.Text :=
      'SELECT FLD_NOME, FLD_TIPO, FLD_CAMINH, FLD_CAMAUX, FLD_COLSEL, FLD_AJUSTE, ' +
      '       FLD_FUNC, FLD_DEFAUL ' +
      'FROM IMPNFE_FLD WHERE FLD_CODPRV = :PRV AND FLD_CODCDS = :CDS ' +
      'ORDER BY FLD_ORDEM, FLD_NOME';
    qry.ParamByName('PRV').AsString := AProvedor;
    qry.ParamByName('CDS').AsString := ANomCds;
    qry.Open;
    while not qry.Eof do
    begin
      cmp := TNfdCampo.Create;
      ACampos.Add(cmp);
      cmp.strNome       := Trim(qry.FieldByName('FLD_NOME').AsString);
      cmp.strTipo       := qry.FieldByName('FLD_TIPO').AsString;
      cmp.strCaminh     := Trim(qry.FieldByName('FLD_CAMINH').AsString);
      cmp.strCamAux     := Trim(qry.FieldByName('FLD_CAMAUX').AsString);
      cmp.strColSel     := Trim(qry.FieldByName('FLD_COLSEL').AsString);
      cmp.strAjuste     := qry.FieldByName('FLD_AJUSTE').AsString;
      cmp.strFunc       := Trim(qry.FieldByName('FLD_FUNC').AsString);
      cmp.strDefaul     := qry.FieldByName('FLD_DEFAUL').AsString;
      cmp.blnDefaulNulo := qry.FieldByName('FLD_DEFAUL').IsNull;
      qry.Next;
    end;
    qry.Close;
  finally
    FreeAndNil(qry);
  end;
end;

class procedure TNfsDinamico.pCriarEstruturaDin(ACds: TUniClientDataSet; const ADef: TNfdDefCds;
  ACampos: TObjectList; AContexto: TNfdContexto);
var
  i, intTam: Integer;
  ftTipo: TFieldType;
  cmp: TNfdCampo;
  fdDef: TFieldDef;
begin
  if ACds.Active then
    ACds.Close;
  ACds.FieldDefs.Clear;

  for i := 0 to ACampos.Count - 1 do
  begin
    cmp := TNfdCampo(ACampos[i]);
    if cmp.strNome = '' then
      Continue;

    // nome repetido: ignora o campo e registra o erro
    if ACds.FieldDefs.IndexOf(cmp.strNome) >= 0 then
    begin
      if AContexto <> nil then
        AContexto.pGravaErro('Dataset dinamico ' + ADef.strNomCds, 'Campo duplicado ignorado: ' + cmp.strNome);
      Continue;
    end;

    pResolveTipoCampoDin(cmp.strTipo, ftTipo, intTam);
    fdDef := ACds.FieldDefs.AddFieldDef;
    fdDef.Name := cmp.strNome;
    fdDef.DataType := ftTipo;
    if intTam > 0 then
      fdDef.Size := intTam;
  end;

  // sem campos: o dataset fica fechado (como Eventos/Inutilizacao no ACBr)
  if ACds.FieldDefs.Count > 0 then
  begin
    ACds.CreateDataSet;
    ACds.LogChanges := False;
  end;
end;

class procedure TNfsDinamico.pPreencherDin(ACds: TUniClientDataSet; const ADef: TNfdDefCds;
  ACampos: TObjectList; const ANoRaiz: IXMLNode; AContexto: TNfdContexto);
var
  lstNos: TInterfaceList;
  lstFuncPar: TStringList;
  qryApoio: TQueryDin;
  dsApoio: TDataSet;
  arrRecApoio, arrRecNos, arrIndices: TNfdIntArray;
  arrValores, arrResult: TNfdVarArray;
  arrAchou: TNfdBoolArray;
  intQtd, r, c, intRecApoioOri, intRecDriverOri: Integer;
  cmp: TNfdCampo;
  fld: TField;
  strValor, strFunc, strCamBas: String;
  blnAchou, blnTratou, blnAjusteOk, blnErroFunc, blnErroAtrib: Boolean;
  dsDriver: TDataSet;
begin
  if not ACds.Active then
    Exit;

  if AContexto <> nil then
    AContexto.NoRaiz := ANoRaiz;

  lstNos := TInterfaceList.Create;
  try
    // 1) registros ("@DOC" = um registro por linha da fonte de contexto)
    strCamBas := ADef.strCamBas;
    if AContexto <> nil then
      strCamBas := Trim(AContexto.fCaminhoBase(ADef.strNomCds, strCamBas));
    dsDriver := nil;
    if Copy(strCamBas, 1, 1) = '@' then
    begin
      if AContexto <> nil then
        dsDriver := AContexto.fDataSetDoc(strCamBas);
      if (dsDriver <> nil) and dsDriver.Active and (not dsDriver.IsEmpty) then
      begin
        intRecDriverOri := dsDriver.RecNo;
        dsDriver.First;
        while not dsDriver.Eof do
        begin
          lstNos.Add(nil);
          dsDriver.Next;
        end;
        if intRecDriverOri > 0 then
          dsDriver.RecNo := intRecDriverOri;
      end;
    end
    else if strCamBas <> '' then
      pColetaNosDin(ANoRaiz, strCamBas, lstNos)
    else
      lstNos.Add(ANoRaiz);

    intQtd := lstNos.Count;
    SetLength(arrIndices, intQtd);
    for r := 0 to intQtd - 1 do
      arrIndices[r] := r + 1;

    // registro com defaults quando nao ha nenhum no (ex.: duplicata "em branco")
    if (intQtd = 0) and (ADef.strRegVaz = 'S') then
    begin
      lstNos.Add(nil);
      intQtd := 1;
      SetLength(arrIndices, 1);
      arrIndices[0] := 0;
    end;

    for r := 0 to intQtd - 1 do
    begin
      ACds.Append;
      ACds.Post;
    end;

    SetLength(arrRecNos, intQtd);
    for r := 0 to intQtd - 1 do
      arrRecNos[r] := r + 1;

    // 2) SELECT de apoio (uma execucao) ou @DOC, e ligacao de cada registro
    qryApoio := nil;
    dsApoio := nil;
    intRecApoioOri := 0;
    lstFuncPar := TStringList.Create;
    try
      if (dsDriver = nil) and (Trim(ADef.strSelect) <> '') then
      begin
        if Copy(Trim(ADef.strSelect), 1, 1) = '@' then
        begin
          if AContexto <> nil then
            dsApoio := AContexto.fDataSetDoc(Trim(ADef.strSelect));
        end
        else
        begin
          qryApoio := fAbreSelectDin(ADef.strSelect, AContexto);
          dsApoio := qryApoio;
        end;
      end;

      SetLength(arrRecApoio, intQtd);
      for r := 0 to intQtd - 1 do
        arrRecApoio[r] := 0;
      if dsDriver <> nil then
      begin
        dsApoio := dsDriver;
        if dsApoio.Active then
          intRecApoioOri := dsApoio.RecNo;
        for r := 0 to intQtd - 1 do
          if arrIndices[r] > 0 then
            arrRecApoio[r] := r + 1;
        if (ADef.strCamBas <> '') and (Copy(ADef.strCamBas, 1, 1) <> '@') and
           fEhOcorDin(ADef.strChvSel) and (AContexto <> nil) and
           AContexto.fLigaXmlDriverDoc(ADef.strNomCds) then
          pLigaNosOcorDin(dsDriver, ADef.strChvSel, ANoRaiz, ADef.strCamBas, lstNos, AContexto);
      end
      else if (dsApoio <> nil) and dsApoio.Active then
      begin
        intRecApoioOri := dsApoio.RecNo;
        if fEhOcorDin(ADef.strChvSel) then
          pLigaApoioOcorDin(dsApoio, ADef.strChvSel, lstNos, arrRecApoio, AContexto)
        else
          for r := 0 to intQtd - 1 do
            arrRecApoio[r] := fLigaApoioDin(dsApoio, ADef.strChvSel, fNoDaListaDin(lstNos, r), arrIndices[r]);
      end;

      // 3) campos, na ordem do cadastro (um campo pode usar os anteriores via VS_<campo>)
      SetLength(arrValores, intQtd);
      SetLength(arrAchou, intQtd);
      for c := 0 to ACampos.Count - 1 do
      begin
        cmp := TNfdCampo(ACampos[c]);
        if (cmp.strNome = '') or (ACds.FindField(cmp.strNome) = nil) then
          Continue;

        // 3a) valor base: XML (no 1 / no 2) e coluna do SELECT de apoio
        for r := 0 to intQtd - 1 do
        begin
          arrValores[r] := Null;
          strValor := '';
          blnAchou := False;
          if cmp.strCaminh <> '' then
            strValor := fValorXmlDin(fNoDaListaDin(lstNos, r), ANoRaiz, cmp.strCaminh, blnAchou);
          if ((not blnAchou) or (strValor = '')) and (cmp.strCamAux <> '') then
            strValor := fValorXmlDin(fNoDaListaDin(lstNos, r), ANoRaiz, cmp.strCamAux, blnAchou);
          if blnAchou then
            arrValores[r] := strValor;

          if ((not blnAchou) or (strValor = '')) and (cmp.strColSel <> '') and
             (dsApoio <> nil) and (arrRecApoio[r] > 0) and (dsApoio.FindField(cmp.strColSel) <> nil) then
          begin
            dsApoio.RecNo := arrRecApoio[r];
            if not dsApoio.FieldByName(cmp.strColSel).IsNull then
            begin
              arrValores[r] := fValorCampoDin(dsApoio.FieldByName(cmp.strColSel));
              blnAchou := True;
            end;
          end;
          arrAchou[r] := blnAchou;
        end;

        // 3b) ajuste (autoritativo), em lote
        blnAjusteOk := False;
        if Trim(cmp.strAjuste) <> '' then
        begin
          try
            pExecLoteDin(cmp.strAjuste, ACds, AContexto, arrRecNos, arrIndices, arrValores, arrResult);
            for r := 0 to intQtd - 1 do
            begin
              arrValores[r] := arrResult[r];
              arrAchou[r] := True;
            end;
            blnAjusteOk := True;
          except
            on E: Exception do
            begin
              if AContexto <> nil then
                AContexto.pGravaErro('Ajuste do campo ' + ADef.strNomCds + '.' + cmp.strNome, E.Message);
              for r := 0 to intQtd - 1 do
                arrAchou[r] := False;
            end;
          end;
        end;

        // 3c) funcao (autoritativa) ou valor / default, registro a registro
        pDivideFuncDin(cmp.strFunc, strFunc, lstFuncPar);
        blnErroFunc := False;
        blnErroAtrib := False;
        for r := 0 to intQtd - 1 do
        begin
          ACds.RecNo := arrRecNos[r];
          if (dsApoio <> nil) and dsApoio.Active and (arrRecApoio[r] > 0) then
            dsApoio.RecNo := arrRecApoio[r];
          fld := ACds.FieldByName(cmp.strNome);
          ACds.Edit;
          try
            blnTratou := False;
            if (strFunc <> '') and (AContexto <> nil) and (not blnErroFunc) then
            begin
              try
                blnTratou := AContexto.fAplicaFuncao(strFunc, lstFuncPar, arrValores[r], arrAchou[r],
                  fld, fNoDaListaDin(lstNos, r), arrIndices[r]);
                if not blnTratou then
                begin
                  blnErroFunc := True;
                  AContexto.pGravaErro('Campo ' + ADef.strNomCds + '.' + cmp.strNome,
                    'Funcao desconhecida: ' + cmp.strFunc);
                end;
              except
                on E: Exception do
                begin
                  blnTratou := False;
                  if not blnErroFunc then
                    AContexto.pGravaErro('Funcao ' + cmp.strFunc + ' do campo ' + ADef.strNomCds + '.' + cmp.strNome, E.Message);
                  blnErroFunc := True;
                end;
              end;
            end;

            if not blnTratou then
            begin
              try
                if blnAjusteOk or (arrAchou[r] and (VarToStr(arrValores[r]) <> '')) then
                  pAtribuiVariantDin(fld, arrValores[r])
                else if cmp.blnDefaulNulo then
                  fld.Clear
                else
                  pAtribuiVariantDin(fld, cmp.strDefaul);
              except
                on E: Exception do
                begin
                  if (not blnErroAtrib) and (AContexto <> nil) then
                    AContexto.pGravaErro('Campo ' + ADef.strNomCds + '.' + cmp.strNome, E.Message);
                  blnErroAtrib := True;
                  fld.Clear;
                end;
              end;
            end;
            ACds.Post;
          except
            ACds.Cancel;
            raise;
          end;
        end;
      end;

      // 4) condicao de existencia do registro (em lote): 0/nulo descarta
      if Trim(ADef.strCondic) <> '' then
      begin
        for r := 0 to intQtd - 1 do
          arrValores[r] := '';
        pExecLoteDin(ADef.strCondic, ACds, AContexto, arrRecNos, arrIndices, arrValores, arrResult);
        for r := intQtd - 1 downto 0 do
          if not fVerdadeiroDin(arrResult[r]) then
          begin
            ACds.RecNo := arrRecNos[r];
            ACds.Delete;
          end;
      end;
    finally
      if (qryApoio = nil) and (dsApoio <> nil) and dsApoio.Active and (intRecApoioOri > 0) then
        dsApoio.RecNo := intRecApoioOri;
      FreeAndNil(qryApoio);
      FreeAndNil(lstFuncPar);
    end;

    // 5) cursor no ultimo registro (como o ACBr apos os Append/Post) e pos-processamento
    if not ACds.IsEmpty then
      ACds.Last;
    if (ADef.strPosPrc <> '') and (AContexto <> nil) then
      AContexto.pPosProcessa(ADef.strPosPrc, ACds);
  finally
    FreeAndNil(lstNos);
  end;
end;

class procedure TNfsDinamico.pMontarPorBancoDin(ACds: TUniClientDataSet; const ADef: TNfdDefCds;
  AContexto: TNfdContexto);
var
  qry: TQueryDin;
  i: Integer;
  fdDef: TFieldDef;
begin
  if ACds.Active then
    ACds.Close;
  ACds.FieldDefs.Clear;

  // sem SELECT: dataset sem campos, fechado (ex.: Eventos/Inutilizacao)
  if Trim(ADef.strSelect) = '' then
    Exit;

  qry := fAbreSelectDin(ADef.strSelect, AContexto);
  try
    for i := 0 to qry.FieldCount - 1 do
    begin
      fdDef := ACds.FieldDefs.AddFieldDef;
      fdDef.Name := qry.Fields[i].FieldName;
      case qry.Fields[i].DataType of
        ftString, ftWideString, ftFixedChar, ftFixedWideChar:
          begin
            fdDef.DataType := ftString;
            fdDef.Size := qry.Fields[i].Size;
            if fdDef.Size <= 0 then
              fdDef.Size := 255;
          end;
        ftSmallint, ftInteger, ftWord, ftLargeint, ftAutoInc:
          fdDef.DataType := ftInteger;
        ftFloat, ftCurrency, ftBCD, ftFMTBcd:
          fdDef.DataType := ftFloat;
        ftDate, ftTime, ftDateTime, ftTimeStamp:
          fdDef.DataType := ftDateTime;
        ftMemo, ftWideMemo, ftFmtMemo:
          fdDef.DataType := ftMemo;
        ftBoolean:
          fdDef.DataType := ftBoolean;
        ftBlob, ftGraphic:
          fdDef.DataType := ftBlob;
      else
        begin
          fdDef.DataType := ftString;
          fdDef.Size := 255;
        end;
      end;
    end;

    if ACds.FieldDefs.Count = 0 then
      Exit;

    ACds.CreateDataSet;
    ACds.LogChanges := False;

    qry.First;
    while not qry.Eof do
    begin
      ACds.Append;
      for i := 0 to qry.FieldCount - 1 do
        ACds.FieldByName(qry.Fields[i].FieldName).Value := qry.Fields[i].Value;
      ACds.Post;
      qry.Next;
    end;
    ACds.First;
    qry.Close;
  finally
    FreeAndNil(qry);
  end;
end;

end.
