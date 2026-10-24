unit untImportaXMLTerceiros;

interface

uses
{$IFDEF LINUX}
  NFe.Utils,
  NFe.Modulo,
{$ELSE}
  untUtil,
  untModulo,
  Windows,
{$ENDIF}
  Variants,
  SysUtils,
  Classes,
  Forms,
  Math,
  StrUtils,
  DateUtils,
  DB,
  untConfigNFE,
  {$IF Defined(UNIDAC)}
    Uni, UniSQLMonitor, MemDS, DBAccess
  {$ELSE}
    ZConnection, ZDataset
  {$IFEND}
  ,XMLDoc
  ,XMLIntf
  ,untRegistrarTarefa
  ,untInterfaces
  ,SyncObjs
  ,IdHTTP
  ,IdMultipartFormData
  ,IdHashMessageDigest
  ,IdSSLOpenSSLHeaders
  ,IdComponent
  ,IdSSLOpenSSL
  ,IdGlobal;

  const
    cnsCancelado = 'C';
    cnsIgnorados = 'I';
    cnsArqSemNom = '<ASN>';
    cnsSeparador = '/*SEP_XML*/';

  type
    TEmit = record
      CNPJ       : string;  // CNPJ do emitente
      xNome      : string;  // Razão social
      xFant      : string;  // Nome fantasia
    end;

    TProd = record
      nItem      : Integer;
      cProd      : string;  // Código interno do produto ou serviço
      cEAN       : string;  // GTIN/EAN comercial
      xProd      : string;  // Descrição do produto ou serviço

      uCom       : string;  // Unidade comercial
      qCom       : Double;  // Quantidade comercial
      vUnCom     : Double;  // Valor unitário comercial
      vProd      : Double;  // Valor total bruto do produto
    end;

    TDet = Array Of TProd;

    TNFe = record
      vNFTot : Double;
      Emit   : TEmit;
      Det    : TDet;
    end;

  type
    TImportaXMLTerceiros = class
  private
    Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND};

    FlibApiClient: Cardinal;

    FXMLStreamBck: TMemoryStream;
    FSavArqBucket: Boolean;
    FPrxCliBucket: String;
    FChvCliBucket: String;
    FUrlCitBucket: String;
    FCitLicBucket: String;

    FPeriodo     : Integer;
    FValCfgDfeTer: String;
    FValCfgCteTer: String;
    FBaixaCteToma: String;
    FTipoDownLoad: String;
    FNFePat: String;
    FCTePat: String;
    FCNPJProprios: String;
    FBaixaCTe: Boolean;
    FBaixaNFe: Boolean;
    FTarefa: TRegistrarTarefa;
    FXMLCache: TStringList;

     //...BLOCO REFERENTE AO BUCKET (SOMENTE NAS VERSÕES SUPERIORES) [INÍCIO]

    {$IF Defined(UNIDAC)}
    GetTokenPrefix: function (const APrefixoCliente: String;
                              const AChavePublica: WideString;
                              const AUnixTimestamp: Int64;
                              const APathLibREST: String;
                              Buffer: PChar;
                              BufferSize: Integer): Integer; stdcall;

    function fRetornaTimeStampEmMilisegundos: Int64;
    function fObterAutorizacaoBucket: string;
    function fEnviarArquivoBucket(const ANomArq: String; ATipDFe: TTipDFe): string;
    function fObterArquivoBucket(const AUrlBkt: string): TBytesStream;
    function fArquivoSalvoBucket(const AUrlBkt: string): Boolean;
    {$IFEND}

    //...BLOCO REFERENTE AO BUCKET (SOMENTE NAS VERSÕES SUPERIORES) [FINAL]

    function fAmbienteHomologacao: Boolean;
    function fNoInicialXML(const AXMLDoc: IXMLDocument; ATipDFe: TTipDFe): IXMLNode;
    function fTemNoInicial(const AXML: WideString; ATipDFe: TTipDFe): Boolean;
    function fCNPJEmitente(const AXML: WideString; ATipDFe: TTipDFe): String;
    function fDocumentoProprio(const AXML: WideString; ATipDFe: TTipDFe): Boolean;
    function fCTeOndeEmpresaEhTomador(const AXML: WideString): Boolean;
    function fExisteChaveDeAcessoNaGerEle(const AChaAce: String): Boolean;
    function fExisteChaveDeAcessoCteNaCadFis(const AChaAce: String): Boolean;
    function fXMLPrincipalJaSalvo(const AChaAce: String; ATipDFe: TTipDFe): Boolean;
    function fXMLEventoJaSalvo(const AChaAce, AEvento: String): Boolean;
    function fRetornaDiretorioBase: String;
    function fNomArqComPath(const AChaAce: String; ATipDFe: TTipDFe; ASulfixo: String=''): String;
    function fCriaDirNFe: String;
    function fCriaDirCTe: String;
    procedure pAtualizaStatusDfeTer(const AChaAce, AStatus: String);
    procedure pAtualizaEventoDfeTer(const AChaAce, AEvento: String; AUpdEve: TStringList=Nil);
    procedure pAtualizaConfiguracao(ACodCfg, AValCfg: String);
    procedure pGravaChaveDeAcessoDeTerceiro(const AChaAce: String; ADtaDoc: TDateTime; ANomArq: String; ATipDFe: TTipDFe);
    procedure pGravaDetalhamentoXML(const AChaAce, ANomArq: String; ATipDFe: TTipDFe);
    procedure pExcluirIgnorados(const ADtaDoc: TDateTime; var ALstChv: TStringList);
    function fParserXMLCte(const AXML: WideString): WideString;
    procedure pInitXMLCache;
    procedure pFreeXMLCache;
    procedure pRemoveXMLCacheByKey(const AKey: string; var ALstChv: TStringList);
    procedure pStoreXMLCache(const AKey, AXML: string);
    function fGetXMLCacheByKey(const AKey: string): string;
    procedure pGeraArquivoXML(const AXML: TStringList; ANomeArquivo: String; AintIdx: Integer=-1; AChaAce: String=''; ASeqEve: String=''; AUpdEve: TStringList=Nil);
    procedure pSplitText(const ATtext, ADelimited: WideString; var aLst: TStringList);
    procedure pDeleteFile(const ANomeArquivo: String);
    function fArquivoValido(const ANomeArquivo: String): Boolean;
    procedure pLimpaXMLStreamBck;
    function fGravaEmPastaLocal: Boolean;
    function fFazEnvioParaBucket: Boolean;
    function fEnviandoExclusivamenteParaBucket: Boolean;

  public
    constructor Create(ATarefa: TRegistrarTarefa);
    destructor Destroy; override;
    procedure Executar;
  end;

Var
  CSGetToken: TCriticalSection;

implementation

{ TImportaXMLTerceiros }

uses untLibNfe, untDicSis;

function fRetirarEspacosExtras(const psTexto: string): string;
  const
    cDouble = '  ';
    cOne = ' ';
begin
  Result := psTexto;
  While Pos(cDouble, Result) > 0 Do
    Result := StringReplace(Result, cDouble, cOne, [rfReplaceAll]);
end;

function fNodeValueStr(xmlNo: IXMLNode): String;
Begin
  Result := '';

  If Assigned(xmlNo) Then
    If (xmlNo.NodeValue <> Null) Then
      Result := xmlNo.NodeValue;
End;

function fNodeValueFlt(xmlNo: IXMLNode): Double;
Begin
  Result := 0;

  If Assigned(xmlNo) Then
    If (xmlNo.NodeValue <> Null) Then
      Result := fStrToFloat(AnsiReplaceStr(xmlNo.NodeValue, '.', ','));
End;

function fFindNodeInsensitive(ParentNode: IXMLNode; const NodeName: string): IXMLNode;
Var
  intIdx: Integer;
  LChild: IXMLNode;
begin
  Result := Nil;
  If ParentNode = Nil Then
    Exit;

  If AnsiUpperCase(ParentNode.NodeName) = AnsiUpperCase(NodeName) Then
  Begin
    Result := ParentNode;
    Exit;
  End;

  For intIdx := 0 To ParentNode.ChildNodes.Count - 1 Do
  Begin
    LChild := ParentNode.ChildNodes[intIdx];
    Result := fFindNodeInsensitive(LChild, NodeName);
    If (Result <> Nil) Then
    Begin
      Break;
    End;
  End;
end;

function fXMLComEvento(const AXML: WideString; ATipDFe: TTipDFe): Boolean;
begin
  Result := Pos(AnsiUpperCase('<procEvento'+IIF(ATipDFe=NFe, 'NFe','CTe')), AnsiUpperCase(fRetirarEspacosExtras(AXML))) > 0;
end;

procedure AddTextToStringList(const AText: string; AList: TStringList);
var
  P, Start: PChar;
  Linha: string;
begin
  if (AList = nil) then
    Exit;

  AList.BeginUpdate;
  try
    if AText = '' then
      Exit;

    P := PChar(AText);
    Start := P;

    while P^ <> #0 do
    begin
      // quebra por #13 e/ou #10
      if (P^ = #13) or (P^ = #10) then
      begin
        SetString(Linha, Start, P - Start);
        AList.Add(Linha);

        // pular múltiplos #13/#10 (CR+LF)
        repeat
          Inc(P);
        {$IF CompilerVersion >= 20.0} // Delphi 2009 ou superior
        until not CharInSet(P^, [#13, #10]);
        {$ELSE} // Delphi 2007 ou anterior
        until not (P^ in [#13, #10]);
        {$IFEND}

        Start := P;
        Continue;
      end;
      Inc(P);
    end;

    // última linha (sem CR/LF no final)
    if P > Start then
    begin
      SetString(Linha, Start, P - Start);
      AList.Add(Linha);
    end;

  finally
    AList.EndUpdate;
  end;
end;

function HtmlDecodeUniversal(const S: string): string;
{$IF CompilerVersion >= 20.0} // Delphi 2009+
var
  i, L: Integer;
  sb: TStringBuilder;
begin
  Result := '';
  L := Length(S);
  if L = 0 then
    Exit;

  sb := TStringBuilder.Create(L);
  try
    i := 1;
    while i <= L do
    begin
      if S[i] = '&' then
      begin
        if (i + 3 <= L) and (Copy(S, i, 4) = '&lt;')   then begin sb.Append('<');  Inc(i,4); Continue; end;
        if (i + 3 <= L) and (Copy(S, i, 4) = '&gt;')   then begin sb.Append('>');  Inc(i,4); Continue; end;
        if (i + 4 <= L) and (Copy(S, i, 5) = '&amp;')  then begin sb.Append('&');  Inc(i,5); Continue; end;
        if (i + 5 <= L) and (Copy(S, i, 6) = '&quot;') then begin sb.Append('"');  Inc(i,6); Continue; end;
        if (i + 5 <= L) and (Copy(S, i, 6) = '&apos;') then begin sb.Append(''''); Inc(i,6); Continue; end;
      end;
      sb.Append(S[i]);
      Inc(i);
    end;
    Result := sb.ToString;
  finally
    sb.Free;
  end;
end;
{$ELSE}
// Delphi 7 / 2007 — versão simplificada (menos rápida, mas compatível)
begin
  Result := S;
  Result := StringReplace(Result, '&lt;',  '<',   [rfReplaceAll]);
  Result := StringReplace(Result, '&gt;',  '>',   [rfReplaceAll]);
  Result := StringReplace(Result, '&amp;', '&',   [rfReplaceAll]);
  Result := StringReplace(Result, '&quot;', '"',  [rfReplaceAll]);
  Result := StringReplace(Result, '&apos;', '''', [rfReplaceAll]);
end;
{$IFEND}

{$IF CompilerVersion < 20.0} // Delphi 7, 2007 etc.
function SameText(const S1, S2: string): Boolean;
begin
  Result := AnsiCompareText(S1, S2) = 0;
end;
{$IFEND}

function fStreamToStringUTF8(AStream: TStream): WideString;
var
  Buffer: AnsiString;
begin
  AStream.Position := 0;

  SetLength(Buffer, AStream.Size);

  if AStream.Size > 0 then
    AStream.ReadBuffer(Buffer[1], AStream.Size);

  {$IF RTLVersion >= 20}
    // D2009+: AnsiString carrega codepage do sistema (CP1252 em pt-BR).
    // Marcamos os bytes como UTF-8 ANTES de decodificar, senão a atribuição
    // implícita faz uma conversão CP1252 -> UTF-8 sobre bytes que JÁ são
    // UTF-8, destruindo os acentos (era o que gerava o "whitespace not
    // allowed" no MSXML).
    SetCodePage(RawByteString(Buffer), CP_UTF8, False);
    Result := UTF8ToWideString(Buffer);
  {$ELSE}
    // D2007 (RTLVersion 18.5): não existe codepage em AnsiString, o cast
    // do código antigo era inócuo. UTF8Decode -> WideString, atribuição
    // volta para AnsiString conforme locale do app (limitação pré-existente
    // do build D2007, fora do escopo deste ajuste).
     Result := UTF8Decode(Buffer);
  {$IFEND}
end;

function fFileToStringUTF8(const ANomArq: String): WideString;
var
  FS: TFileStream;
begin
  FS := TFileStream.Create(ANomArq, fmOpenRead or fmShareDenyNone);
  try
    Result := fStreamToStringUTF8(FS);
  finally
    FS.Free;
  end;
end;

function RemoveDeclaracaoXMLVersion(const AXmlEnvelope: WideString): WideString;

  function EhEspacoEmBrancoXML(C: WideChar): Boolean;
  begin
    // Whitespace conforme XML 1.0 §2.3, mais BOM/NBSP defensivos
    Result := (C = #$09) or (C = #$0A) or (C = #$0D) or (C = #$20) or
              (C = #$FEFF) or (C = #$00A0);
  end;

  procedure RemoverEspacosEmBrancoIniciais(var S: WideString);
  var
    I: Integer;
  begin
    I := 1;
    while (I <= Length(S)) and EhEspacoEmBrancoXML(S[I]) do
      Inc(I);
    if I > 1 then
      Delete(S, 1, I - 1);
  end;

  procedure RemoverDeclaracoesXML(var S: WideString);
  const
    cnsXmlDecl = '<?xml';
  var
    P1, P2, PVersion, LTam: Integer;
    LBusca: WideString;
  begin
    // Cópia lower-case criada uma vez e mantida sincronizada com S
    // aplicando o mesmo Delete nas duas strings.
    LBusca := AnsiLowerCase(S);
    P1 := 1;

    while P1 <= Length(S) do
    begin
      P1 := PosEx(cnsXmlDecl, LBusca, P1);

      if P1 <= 0 then
        Break;

      if P1 + Length(cnsXmlDecl) > Length(S) then
        Break;

      // Só age se REALMENTE encontrou "<?xml" seguido de whitespace.
      // Isso descarta "<?xml-stylesheet ...?>" (o char seguinte é '-').
      if not EhEspacoEmBrancoXML(S[P1 + Length(cnsXmlDecl)]) then
      begin
        Inc(P1);
        Continue;
      end;

      // Localiza o fechamento "?>". Se não houver, declaração malformada -
      // não mexe; deixa o parser reclamar com mensagem clara.
      P2 := PosEx('?>', LBusca, P1);
      if P2 <= 0 then
        Break;

      // Confirma que é a declaração XML (contém "version") e não outro PI.
      PVersion := PosEx('version', LBusca, P1);
      if (PVersion <= 0) or (PVersion > P2) then
      begin
        Inc(P1);
        Continue;
      end;

      LTam := (P2 - P1) + 2;

      // Remove EXATAMENTE da abertura '<' até o '>' da declaração.
      Delete(S,      P1, LTam);
      Delete(LBusca, P1, LTam);
      // P1 permanece: a próxima busca começa na mesma posição.
    end;
  end;

begin
  Result := AXmlEnvelope;

  // (1) Remove BOMs + qualquer whitespace/NBSP no início.
  //     Cobre BOM duplicado e Trim que não pega #$FEFF/#$00A0.
  RemoverEspacosEmBrancoIniciais(Result);

  // (2) Remove declarações XML, inclusive as existentes entre documentos internos.
  RemoverDeclaracoesXML(Result);

  // (3) Consome whitespace/BOM residual entre o prolog e o root.
  RemoverEspacosEmBrancoIniciais(Result);
end;

function IsInArray(const Value: string; const Arr: array of string): Boolean;
var
  intIdx: Integer;
begin
  Result := False;
  for intIdx := Low(Arr) to High(Arr) do
  begin
    if SameText(Value, Arr[intIdx]) then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

function fReturnaXMLPuro(const AXmlEnvelope: WideString): WideString;
  Const
    cstCDATAIni: WideString = '<![CDATA[';
    cstCDATAFin: WideString = ']]>';
begin
  Result := AXmlEnvelope;

  if Pos(cstCDATAIni, Result) > 0 then
  begin
    Result := StringReplace(Result, cstCDATAIni, '', []);
    Result := StringReplace(Result, cstCDATAFin, '', []);
  end;

  Result := HtmlDecodeUniversal(Result);

  Result := RemoveDeclaracaoXMLVersion(Result);
end;

function fLoadSmartReturnXML(const AXMLEnvelope, ANoPai: WideString;
  const arrNosIgnorados: array of string;
  const arrNosIncluidos: array of string): IXMLDocument;
var
  LXML: WideString;
  NodePai, NodeFilho: IXMLNode;
  LXMLDocument: IXMLDocument;
  intIdx: Integer;
  blnIgnora: Boolean;
begin
  LXML := fReturnaXMLPuro(AXMLEnvelope);

  LXMLDocument := TXMLDocument.Create(nil);
  LXMLDocument.Options := [doNodeAutoCreate, doNodeAutoIndent];
  LXMLDocument.LoadFromXML(LXML);
  LXMLDocument.Active := True;

  LXML := '';

  // Aplica filtros de exclusão/inclusão
  NodePai := LXMLDocument.DocumentElement;
  if Assigned(NodePai) and NodePai.HasChildNodes then
  begin
    intIdx := 0;
    while intIdx < NodePai.ChildNodes.Count do
    begin
      NodeFilho := NodePai.ChildNodes[intIdx];
      blnIgnora := False;

      if Length(arrNosIncluidos) > 0 then
        blnIgnora := not IsInArray(NodeFilho.NodeName, arrNosIncluidos)
      else if Length(arrNosIgnorados) > 0 then
        blnIgnora := IsInArray(NodeFilho.NodeName, arrNosIgnorados);

      if blnIgnora then
        NodePai.ChildNodes.Delete(intIdx)
      else
        Inc(intIdx);
    end;
  end;

  Result := LXMLDocument;
end;

function fDiretorioValido(const strPat: String): Boolean;
begin
  Result := DirectoryExists(strPat);
end;

function fXMLCancelado(const AXML: WideString): Boolean;
  Var
    LXML: String;
begin
  LXML := AnsiUpperCase(fRetirarEspacosExtras(AXML));

  Result := Pos(AnsiUpperCase('<tpEvento>110111</tpEvento>'), LXML) > 0;
  If (Not Result) Then
    Result := Pos(AnsiUpperCase('<tpEvento>110112</tpEvento>'), LXML) > 0;
end;

function NodeAsText(const Node: IXMLNode): string;
  Var
    intIdx: Integer;
begin
  Result := '';
  if not Assigned(Node) then
    Exit;

  if Node.IsTextElement then
  begin
    Result := Node.Text;
    Exit;
  end;

  for intIdx := 0 to Node.ChildNodes.Count - 1 do
  begin
    case Node.ChildNodes[intIdx].NodeType of
      ntText,
      ntCData: Result := Result + Node.ChildNodes[intIdx].NodeValue;
    else
      Result := Result + Node.ChildNodes[intIdx].XML;
    end;
  end;

  if (Result = '') and (Node.NodeValue <> null) then
    Result := VarToStr(Node.NodeValue);
end;

procedure TImportaXMLTerceiros.pExcluirIgnorados(const ADtaDoc: TDateTime; var ALstChv: TStringList);
  Var
    qryGen : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  If fCampoExiste('DFETER', 'DFE_TIPDFE') And
     fCampoExiste('DFETER', 'DFE_STATUS') And
     fCampoExiste('DFETER', 'DFE_CODEMP') Then
  Begin
    qryGen := fCriaQuery(nil, Banco);
    Try
      qryGen.Close;
      qryGen.SQL.Text := ' SELECT DFE_ACESSO FROM DFETER '+
                         '  WHERE DFE_TIPDFE = "CTe"     '+
                         '    AND DFE_STATUS = "I"       '+
                         '    AND DFE_CODEMP = :CODEMP   '+
                         '    AND DFE_DTADOC = :DTADOC   ';
      qryGen.ParamByName('CODEMP').AsString   := VS_strCodEmp;
      qryGen.ParamByName('DTADOC').AsDateTime := ADtaDoc;
      qryGen.Open;

      qryGen.First;
      While Not qryGen.Eof Do
      Begin
        pRemoveXMLCacheByKey(qryGen.Fields[0].Text, ALstChv);

        qryGen.Next;
      End;
    Finally
      FreeAndNil(qryGen);
    End;
  End;
end;

function TImportaXMLTerceiros.fParserXMLCte(const AXML: WideString): WideString;
  Var
    LXMLDocument: IXMLDocument;
    LNodeSpedDocumentoFiscal,
    LNodeDocumentoFiscal,
    LNodeXML,
    LNodeChave: IXMLNode;
    intPos: Integer;
    strTag: WideString;
    LXML: WideString;
    LXMLAux: WideString;
    LChaAce: String;
begin
  Result := '';

  Try
    LXML := AXML;

    strTag := '<spedDocumentoFiscal>';
    intPos := Pos(strTag, LXML);
    If intPos > 0 Then
    Begin
      LXML := Copy(LXML, intPos, Length(LXML));
      strTag := '</spedDocumentoFiscal>';
      intPos := Pos(strTag, LXML);
      If intPos > 0 Then
        LXML := Copy(LXML, 1, intPos - 1);
      LXML := LXML + '</spedDocumentoFiscal>';
    End;

    LXMLDocument := fLoadSmartReturnXML(LXML, 'spedDocumentoFiscal', ['CD_STATUS','DM_TIPO_DOCUMENTO','DT_CONTABIL','ID_DOCUMENTO_FISCAL','NM_ARQUIVO'], []);

    LXML := '';

    LNodeSpedDocumentoFiscal := LXMLDocument.DocumentElement;

    If Assigned(LNodeSpedDocumentoFiscal) Then
      LNodeDocumentoFiscal := LNodeSpedDocumentoFiscal.ChildNodes.FindNode('documentoFiscal');

    While (Assigned(LNodeDocumentoFiscal)) And (LNodeDocumentoFiscal.GetNodeName = 'documentoFiscal') Do
    Begin
      LNodeChave := LNodeDocumentoFiscal.ChildNodes.FindNode('NR_CHAVE_ACESSO');

      If (Not Assigned(LNodeChave)) Then
      Begin
        LNodeDocumentoFiscal := LNodeDocumentoFiscal.NextSibling;
        Continue;
      End;

      LXML := '';
      LChaAce  := LNodeChave.Text;
      LNodeXML := LNodeDocumentoFiscal.ChildNodes.FindNode('XML');
      While (Assigned(LNodeXML)) And (LNodeXML.GetNodeName = 'XML') Do
      Begin
        LXMLAux := NodeAsText(LNodeXML);
        LXMLAux := StringReplace(LXMLAux, '<XML>',  '', [rfReplaceAll]);
        LXMLAux := StringReplace(LXMLAux, '</XML>', '', [rfReplaceAll]);

        LXML := LXMLAux + IIF(LXML <> '', cnsSeparador, '') + LXML;

        LNodeXML := LNodeXML.NextSibling;
      End;

      Result := Result + LChaAce + #13;

      If (LXML <> '') Then
        pStoreXMLCache(LChaAce, Trim(LXML));

      LNodeDocumentoFiscal := LNodeDocumentoFiscal.NextSibling;
    End;
  Finally
    LXMLDocument             := Nil;
    LNodeSpedDocumentoFiscal := Nil;
    LNodeDocumentoFiscal     := Nil;
    LNodeXML                 := Nil;
    LNodeChave               := Nil;
  End;
end;

function TImportaXMLTerceiros.fAmbienteHomologacao: Boolean;
  Var
    strUrl: String;
begin
  strUrl := AnsiLowerCase(fCfgSisPainel('CITURL'));

            //SOVOS
  Result := (Pos('ws.hom',  strUrl) > 0)
         Or (Pos('hom.dfe', strUrl) > 0)

            //CITEL
         Or (Pos('nfe-hom', strUrl) > 0)
         Or (Pos('hom.cit', strUrl) > 0)

            //GERAL
         Or (Pos('homolog', strUrl) > 0)
end;

procedure TImportaXMLTerceiros.pInitXMLCache;
begin
  If Not Assigned(FXMLCache) Then
    FXMLCache := TStringList.Create;
end;

procedure TImportaXMLTerceiros.pFreeXMLCache;
var
  intIdx: Integer;
begin
  If Assigned(FXMLCache) Then
  Begin
    For intIdx := 0 To FXMLCache.Count - 1 Do
      TObject(FXMLCache.Objects[intIdx]).Free;
    FreeAndNil(FXMLCache);
  End;
end;

procedure TImportaXMLTerceiros.pRemoveXMLCacheByKey(const AKey: string; var ALstChv: TStringList);
var
  Idx: Integer;
begin
  Idx := ALstChv.IndexOf(AKey);
  If Idx >= 0 Then
  Begin
    ALstChv.Delete(Idx);
  End;

  If Not Assigned(FXMLCache) Then
    Exit;

  Idx := FXMLCache.IndexOf(AKey);
  If Idx >= 0 Then
  Begin
    TObject(FXMLCache.Objects[Idx]).Free;
    FXMLCache.Delete(Idx);
  End;
end;

procedure TImportaXMLTerceiros.pStoreXMLCache(const AKey, AXML: string);
var
  Idx: Integer;
  Stream: TStringStream;
begin
  If Not Assigned(FXMLCache) Then
    pInitXMLCache;

  Idx := FXMLCache.IndexOf(AKey);
  If Idx >= 0 Then
  Begin
    Stream := TStringStream(FXMLCache.Objects[Idx]);
    Stream.Size := 0;
    Stream.WriteString(AXML);
  End
  Else
  Begin
    Stream := TStringStream.Create(AXML);
    FXMLCache.AddObject(AKey, Stream);
  End;
end;

function TImportaXMLTerceiros.fGetXMLCacheByKey(const AKey: string): string;
var
  Idx: Integer;
  Stream: TStringStream;
begin
  Result := '';

  If Not Assigned(FXMLCache) Then
    Exit;

  Idx := FXMLCache.IndexOf(AKey);
  If Idx >= 0 Then
  Begin
    Stream := TStringStream(FXMLCache.Objects[Idx]);
    Result := Stream.DataString;
  End;
end;

procedure TImportaXMLTerceiros.pGeraArquivoXML(const AXML: TStringList; ANomeArquivo: String; AintIdx: Integer=-1; AChaAce: String=''; ASeqEve: String=''; AUpdEve: TStringList=Nil);
  Var
    LXML: TStringList;
    LAux: String;
    LArquivoEventos: Boolean;
begin
  If Assigned(FXMLStreamBck) Then
    FXMLStreamBck.Clear;

  LAux := LeftStr(ANomeArquivo, Length(ANomeArquivo) - 4);

  If (FileExists(LAux+'.imp')) Or (FileExists(LAux+'.canc')) Then
    Exit;

  LArquivoEventos := (AChaAce <> '') And (ASeqEve <> '');

  If LArquivoEventos Then
    If fXMLEventoJaSalvo(AChaAce, ASeqEve) Then
      Exit;

  LXML := TStringList.Create;

  If (AintIdx <> -1) Then
    LXML.Text := AXML[AintIdx]
  Else
    LXML.Text := AXML.Text;

  Try
    If Assigned(FXMLStreamBck) Then
    Begin
      {$IF RTLVersion >= 28}
      LXML.SaveToStream(FXMLStreamBck, TEncoding.UTF8);
      {$ELSE}
      LXML.Text := UTF8Encode(LXML.Text);
      LXML.SaveToStream(FXMLStreamBck);
      {$IFEND}
      FXMLStreamBck.Position := 0;
    End
    Else
    Begin
      {$IF RTLVersion >= 28}
      LXML.SaveToFile(ANomeArquivo, TEncoding.UTF8);
      {$ELSE}
      LXML.Text := UTF8Encode(LXML.Text);
      LXML.SaveToFile(ANomeArquivo);
      {$IFEND}
    End;
  Finally
    FreeAndNil(LXML);

    If LArquivoEventos Then
      If fArquivoValido(ANomeArquivo) Then
        pAtualizaEventoDfeTer(AChaAce, ASeqEve, AUpdEve);
  End;
end;

function TImportaXMLTerceiros.fNoInicialXML(const AXMLDoc: IXMLDocument; ATipDFe: TTipDFe): IXMLNode;
Begin
  Result := AXMLDoc.Node.ChildNodes.FindNode(IIF(ATipDFe=NFe, 'nfeProc', 'cteProc'));

  If Not Assigned(Result) Then
    Result := AXMLDoc.Node.ChildNodes.FindNode('NFeList');
end;

function TImportaXMLTerceiros.fTemNoInicial(const AXML: WideString; ATipDFe: TTipDFe): Boolean;
  Var
    LXMLDocument: IXMLDocument;
    LXMLNo: IXMLNode;
Begin
  Result := False;

  LXMLDocument := TXMLDocument.Create(Nil);
  Try
    Try
      LXMLDocument.LoadFromXML(AXML);

      LXMLNo := fNoInicialXML(LXMLDocument, ATipDFe);
      Result := Assigned(LXMLNo);
    Except
      On E: Exception Do
        pLogImp(IIF(ATipDFe=NFe, 'NFe','CTe')+ ' > Erro em fTemNoInicial > ' + E.Message + ' ' + AXML);
    End;
  Finally
    LXMLDocument := Nil;
    LXMLNo       := Nil;
  End;
end;

function TImportaXMLTerceiros.fCNPJEmitente(const AXML: WideString; ATipDFe: TTipDFe): String;
  Var
    LXMLDocument: IXMLDocument;
    LXMLNo: IXMLNode;
Begin
  Result := '';

  LXMLDocument := TXMLDocument.Create(Nil);
  Try
    Try
      LXMLDocument.LoadFromXML(AXML);

      LXMLNo := fNoInicialXML(LXMLDocument, ATipDFe);

      If Assigned(LXMLNo) Then
      Begin
        LXMLNo := fFindNodeInsensitive(LXMLNo, IIF(ATipDFe=NFe, 'NFe','CTe'));
        LXMLNo := fFindNodeInsensitive(LXMLNo, IIF(ATipDFe=NFe, 'infNFe', 'infCTe'));
        LXMLNo := fFindNodeInsensitive(LXMLNo, 'emit');
        LXMLNo := fFindNodeInsensitive(LXMLNo, 'CNPJ');

        If Assigned(LXMLNo) Then
          Result := fNodeValueStr(LXMLNo);
      End;
    Except
      On E: Exception Do
        pLogImp(IIF(ATipDFe=NFe, 'NFe','CTe')+ ' > Erro em fCNPJEmitente > ' + E.Message + ' ' + AXML);
    End;
  Finally
    LXMLDocument := Nil;
    LXMLNo       := Nil;
  End;
End;

function TImportaXMLTerceiros.fCTeOndeEmpresaEhTomador(const AXML: WideString): Boolean;
  Var
    LXMLDocument: IXMLDocument;
    LXMLNo: IXMLNode;
Begin
  Result := True;

  LXMLDocument := TXMLDocument.Create(Nil);
  Try
    Try
      LXMLDocument.LoadFromXML(AXML);

      LXMLNo := fNoInicialXML(LXMLDocument, CTe);

      If Assigned(LXMLNo) Then
      begin
        LXMLNo := fFindNodeInsensitive(LXMLNo, 'CTe');
        LXMLNo := fFindNodeInsensitive(LXMLNo, 'infCTe');

        If Assigned(LXMLNo) Then
          Result := False;

        LXMLNo := fFindNodeInsensitive(LXMLNo, 'toma3');
        LXMLNo := fFindNodeInsensitive(LXMLNo, 'toma');

        If Assigned(LXMLNo) Then
          Result := (Pos(fNodeValueStr(LXMLNo), '0_3_') > 0);
      end;
    Except
      On E: Exception Do
        pLogImp('CTe > Erro em fCTeOndeEmpresaEhTomador > ' + E.Message + ' ' + AXML);
    End;
  Finally
    LXMLDocument := Nil;
    LXMLNo       := Nil;
  End;
end;

procedure TImportaXMLTerceiros.pAtualizaStatusDfeTer(const AChaAce, AStatus: String);
  Var
    qryGen : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  If fCampoExiste('DFETER', 'DFE_STATUS') Then
  Begin
    qryGen := fCriaQuery(nil, Banco);
    Try
      qryGen.Close;
      qryGen.SQL.Text := 'UPDATE DFETER SET DFE_STATUS = :STATUS WHERE DFE_ACESSO = :CHAACE;';
      qryGen.ParamByName('CHAACE').AsString := AChaAce;
      qryGen.ParamByName('STATUS').AsString := AStatus;
      qryGen.ExecSQL;
    Finally
      FreeAndNil(qryGen);
    End;
  End;
end;

procedure TImportaXMLTerceiros.pAtualizaEventoDfeTer(const AChaAce, AEvento: String; AUpdEve: TStringList=Nil);
  Var
    qryGen : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    LEvento: String;

    function fTemUpdate: Boolean;
    begin
      Result := (AChaAce <> '') And (AEvento <> '');
      If (Not Result) Then
      Begin
        If Assigned(AUpdEve) Then
          Result := AUpdEve.Count > 0;
      End;
    end;
begin
  If (Not fTemUpdate) Then
    Exit;

  If fCampoExiste('DFETER', 'DFE_EVENTO') Then
  Begin
    LEvento := AEvento+'_';

    qryGen := fCriaQuery(nil, Banco);
    Try
      qryGen.Close;
      If (AChaAce <> '') And (AEvento <> '') Then
      Begin
        qryGen.SQL.Text := 'UPDATE DFETER '+
                           '   SET DFE_EVENTO = CONCAT(REPLACE(IFNULL(DFE_EVENTO, ""), "'+LEvento+'", ""), "'+LEvento+'") ' +
                           'WHERE DFE_ACESSO = "'+AChaAce+'";';
        qryGen.ExecSQL;

        If Assigned(AUpdEve) Then
        Begin
          If (qryGen.RowsAffected = 0) Then
            AUpdEve.Add(qryGen.SQL.Text);
        End;
      End
      Else
      Begin
        qryGen.SQL.Text := AUpdEve.Text;
        qryGen.ExecSQL;
      End;
    Finally
      FreeAndNil(qryGen);
    End;
  End;
end;

procedure TImportaXMLTerceiros.pAtualizaConfiguracao(ACodCfg, AValCfg: String);
var
  qryGen: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  If fEnviandoExclusivamenteParaBucket Then
    Exit;

  qryGen := fCriaQuery(nil, Banco);
  Try
    If (Pos('CFG_', ACodCfg) = 0) Then
      ACodCfg := 'CFG_'+ACodCfg ;

    qryGen.SQL.Clear;
    qryGen.SQL.Add('UPDATE CFGSIS ');
    qryGen.SQL.Add('   SET SIS_VALCFG = :VALCFG ');
    qryGen.SQL.Add(' WHERE SIS_CODCFG = :CODCFG ');
    qryGen.SQL.Add('   AND SIS_CODEMP = :CODEMP ');
    qryGen.ParamByName('VALCFG').AsString := AValCfg;
    qryGen.ParamByName('CODCFG').AsString := ACodCfg;
    qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryGen.ExecSQL;
  Finally
    FreeAndNil(qryGen);
  End;
end;

constructor TImportaXMLTerceiros.Create(ATarefa: TRegistrarTarefa);
  Var
    LEnviarParaBucket: Boolean;
begin
  inherited Create;
  FTarefa := ATarefa;
  Banco := frmModulo.Database;

  FXMLCache := TStringList.Create;

  FBaixaCTe := False;
  FBaixaNFe := False;

  FSavArqBucket := False;
  FChvCliBucket := '';
  FPrxCliBucket := '';
  FUrlCitBucket := '';
  FCitLicBucket := '';
  FTipoDownLoad := '1'; //1 = Somente (NFe/CTe) de Fornecedores Externos
  FBaixaCteToma := 'N';
  FXMLStreamBck := Nil;

  LEnviarParaBucket := False;
  If fExisteConfiguracao('BKTDFE') Then
    LEnviarParaBucket := (fCfgSisPainel('BKTDFE') = 'S');

  If fTabelaExiste('DFETER', Banco) Then
  Begin
    {$IF Defined(UNIDAC)}
    If (LEnviarParaBucket) And (Not fAmbienteHomologacao) Then
    Begin
      If (Not fCampoExiste('DFETER', 'DFE_URLBKT')) Then
      Begin
        pGravaLogErr('PainelNFE', '[ImportaXMLTerceiros]'+#13+'DFETER->DFE_URLBKT não existe!');
        Exit;
      End;

      If (fEmptyStr(fCfgSisPainel('CLICHP'))) Then
      Begin
        pGravaLogErr('PainelNFE', '[ImportaXMLTerceiros]'+#13+'CFG_CLICHP, precisa ser configurada!');
        Exit;
      End;

      If (fEmptyStr(fCfgSisPainel('CLIPFX'))) Then
      Begin
        pGravaLogErr('PainelNFE', '[ImportaXMLTerceiros]'+#13+'CFG_CLIPFX, precisa ser configurada!');
        Exit;
      End;

      If (fEmptyStr(fCfgSisPainel('URLBKT'))) Then
      Begin
        pGravaLogErr('PainelNFE', '[ImportaXMLTerceiros]'+#13+'CFG_URLBKT, precisa ser configurada!');
        Exit;
      End;

      FlibApiClient := LoadLibrary(PChar('api.client.dll'));

      If (FlibApiClient = 0) Then
      Begin
        pGravaLogErr('PainelNFE', '[ImportaXMLTerceiros]'+#13+'Biblioteca "api.client.dll" não encontrada!');
        Exit;
      End;

      @GetTokenPrefix := GetProcAddress(FlibApiClient, PChar('GetTokenPrefix'));
      If Not Assigned(GetTokenPrefix) Then
      Begin
        pGravaLogErr('PainelNFE', '[ImportaXMLTerceiros]'+#13+'Função GetTokenPrefix não está disponível!');
        Exit;
      End;

      FChvCliBucket := fCfgSisPainel('CLICHP');
      FPrxCliBucket := fCfgSisPainel('CLIPFX');
      FUrlCitBucket := fCfgSisPainel('URLBKT');
      FCitLicBucket := fCfgSisPainel('CITLIC');
      FSavArqBucket := True;
    End;
    {$IFEND}

    FCNPJProprios := fCampoTabela('GROUP_CONCAT(DISTINCT EMP_C_G_C_ SEPARATOR "_")', 'CADEMP', [], [], Banco);

    If fExisteConfiguracao('CTETER') Then
      FValCfgCteTer := fCfgSisPainel('CTETER');

    If fExisteConfiguracao('DFETER') Then
      FValCfgDfeTer := fCfgSisPainel('DFETER');

    FPeriodo := 7;
    Try
      If fExisteConfiguracao('DFEDIA') Then
        FPeriodo := StrToInt(IfEmptyStr(fCfgSisPainel('DFEDIA'), '7'));
      If FPeriodo <= 0 Then
       FPeriodo := 7;
    Except
      FPeriodo := 7;
    End;

    FBaixaCTe := fCfgAtiva(FValCfgCteTer);
    FBaixaNFe := fCfgAtiva(FValCfgDfeTer);

    If fExisteConfiguracao('DFEPRP') Then
      FTipoDownLoad := IfEmptyStr(fCfgSisPainel('DFEPRP'), '1');

    If fExisteConfiguracao('CTETOM') Then
      FBaixaCteToma := IfEmptyStr(fCfgSisPainel('CTETOM'), 'N');

    FNFePat := fCriaDirNFe;
    FCTePat := fCriaDirCTe;
  End;
end;

destructor TImportaXMLTerceiros.Destroy;
begin
  If (FlibApiClient <> 0) Then
  Begin
    FreeLibrary(FlibApiClient);
    FlibApiClient := 0;
  End;

  pFreeXMLCache;

  inherited;
end;

procedure TImportaXMLTerceiros.pSplitText(const ATtext, ADelimited: WideString; var aLst: TStringList);
var
  P, Start: Integer;
  SepLen: Integer;
begin
  if aLst = nil then
    aLst := TStringList.Create
  else
    aLst.Clear;

  if (ATtext = '') then
    Exit;

  if (ADelimited = '') then
  begin
    aLst.Add(ATtext);
    Exit;
  end;

  SepLen := Length(ADelimited);
  Start := 1;

  repeat
    P := Pos(ADelimited, Copy(ATtext, Start, MaxInt));
    if P > 0 then
    begin
      aLst.Add(Copy(ATtext, Start, P - 1));
      Start := Start + P - 1 + SepLen;
    end
    else
    begin
      aLst.Add(Copy(ATtext, Start, MaxInt));
      Break;
    end;
  until False;
end;

procedure TImportaXMLTerceiros.pDeleteFile(const ANomeArquivo: String);
begin
  If FileExists(ANomeArquivo) Then
    DeleteFile(ANomeArquivo);
end;

function TImportaXMLTerceiros.fEnviandoExclusivamenteParaBucket: Boolean;
begin
  Result := Assigned(FXMLStreamBck);
end;

function TImportaXMLTerceiros.fFazEnvioParaBucket: Boolean;
begin
  Result := FSavArqBucket;
end;

function TImportaXMLTerceiros.fArquivoValido(const ANomeArquivo: String): Boolean;
begin
  Result := (FileExists(ANomeArquivo)) Or (Assigned(FXMLStreamBck) And (FXMLStreamBck.Size > 0));
end;

function TImportaXMLTerceiros.fGravaEmPastaLocal: Boolean;
begin
  Result := (fDiretorioValido(FNFePat)) Or
            (fDiretorioValido(FCTePat));
end;

procedure TImportaXMLTerceiros.pLimpaXMLStreamBck;
begin
  If fGravaEmPastaLocal Then
    FTarefa.blnOculInfo := False;

  If Assigned(FXMLStreamBck) Then
    FreeAndNil(FXMLStreamBck);
end;

procedure TImportaXMLTerceiros.Executar;
Var
  LLstChv: TStringList;
  LLstExc: TStringList;
  LNSU,
  LPeriodo: Integer;
  LdtaDoc : TDateTime;
  ImportaXMLTerceiros: IImportaXMLTerceirosArquivosService;
  objConfigSovos: TConfiguracoesNFE;
  strValCfgMDEVAR: string;
  LStatus: string;
  LMsgAux: string;
  LServico: string;
  LCodEmpFit: string;
  LListTemp: string;
  LEntradaRealizada: Boolean;
  LEntradaRealizadaMasEnviaParaBucket: Boolean;

  procedure pSalvaNFeTerceiros(AChaAce:String; ADtaDoc: TDateTime);
  var
    LUpdEve,
    LXmlNFe: TStringList;
    LSeqEve,
    LXMLPrincipal,
    LNomeArquivo: String;
    LIdx,
    LIncEve: Integer;
    blnSalvaCancel,
    blnSalvaEvento,
    blnSalvaAllCan,
    blnSalvaCanEnt: Boolean;
  begin
    If fEmptyStr(AChaAce) Then
      Exit;

    If Length(AChaAce) > 44 Then
      Exit;

    LNomeArquivo := fNomArqComPath(AChaAce, NFe);

    blnSalvaAllCan := Pos('ALLCAN', FValCfgDfeTer) > 0;
    blnSalvaCanEnt := Pos('CANENT', FValCfgDfeTer) > 0;
    blnSalvaEvento := Pos('ALLEVE', FValCfgDfeTer) > 0;
    blnSalvaCancel := False;

    LEntradaRealizadaMasEnviaParaBucket := False;

    LIncEve := 0;
    LXmlNFe := TStringList.Create;
    LUpdEve := TStringList.Create;
    Try
      pSplitText(Trim(ImportaXMLTerceiros.fRetXMLNfe(AChaAce)), cnsSeparador, LXmlNFe);

      For LIdx := 0 To LXmlNFe.Count-1 Do
      Begin
        If fTemNoInicial(LXmlNFe[LIdx], NFe) Then
        Begin
          LXMLPrincipal := LXmlNFe[LIdx];
          Break;
        End;
      End;

      If fDocumentoProprio(LXMLPrincipal, NFe) Then
      Begin
        pDeleteFile(LNomeArquivo);

        Exit;
      End;

      LEntradaRealizada := fExisteChaveDeAcessoNaGerEle(AChaAce);

      For LIdx := 0 To LXmlNFe.Count-1 Do
      Begin
        If (Not fXMLComEvento(LXmlNFe[LIdx], NFe)) Then
          Continue;

        If fXMLCancelado(LXmlNFe[LIdx]) Then
        Begin
          blnSalvaCancel := blnSalvaAllCan;
          If LEntradaRealizada Then
          Begin
            If (Not blnSalvaCancel) And (blnSalvaCanEnt) Then
              blnSalvaCancel := True;

            pAtualizaStatusDfeTer(AChaAce, cnsCancelado);
          End;

          If blnSalvaCancel Then
          Begin
            pGeraArquivoXML(LXmlNFe, fNomArqComPath(AChaAce, NFe, '_cancel'), LIdx, AChaAce, cnsCancelado, LUpdEve);
          End
          Else
          Begin
            pDeleteFile(LNomeArquivo);

            Exit;
          End;
        End
        Else If blnSalvaEvento Then
        Begin
          Inc(LIncEve);
          LSeqEve := IntToStr(LIncEve);
          pGeraArquivoXML(LXmlNFe, fNomArqComPath(AChaAce, NFe, '_evento'+LSeqEve), LIdx, AChaAce, LSeqEve, LUpdEve)
        End;
      End;

      LXmlNFe.Clear;
      LXmlNFe.Add(LXMLPrincipal);

      If LEntradaRealizada Then
      Begin
        pDeleteFile(LNomeArquivo);

        If (fFazEnvioParaBucket) Then
        Begin
          LEntradaRealizadaMasEnviaParaBucket := True;
        End
        Else
        Begin
          Exit;
        End;
      End;

      If fXMLPrincipalJaSalvo(AChaAce, NFe) Then
        Exit;

      If (Length(LXmlNFe.Text) < 100) Then
        Exit;

      pGeraArquivoXML(LXmlNFe, LNomeArquivo);

      If fArquivoValido(LNomeArquivo) Then
      begin
        pAtualizaConfiguracao('XMLPAT', FNFePat);

        pGravaChaveDeAcessoDeTerceiro(AChaAce, ADtaDoc, LNomeArquivo, NFe);

        If blnSalvaCancel Then
          pAtualizaStatusDfeTer(AChaAce, cnsCancelado);

        If blnSalvaEvento Then
          pAtualizaEventoDfeTer('', '', LUpdEve);

        If LEntradaRealizadaMasEnviaParaBucket Then
          pDeleteFile(LNomeArquivo);
      end;
    Finally
      FreeAndNil(LXmlNFe);
      FreeAndNil(LUpdEve);
    End;
  end;

  procedure pSalvaCTeTerceiros(AChaAce:String; ADtaDoc: TDateTime);
  var
    LUpdEve,
    LXmlCTe: TStringList;
    LSeqEve,
    LXMLPrincipal,
    LNomeArquivo: String;
    LIdx,
    LIncEve: Integer;
    blnSalvaCancel,
    blnSalvaEvento,
    blnSalvaAllCan,
    blnSalvaCanEnt,
    blnCTeOndeEmpresaEhTomador: Boolean;
  begin
    If fEmptyStr(AChaAce) Then
      Exit;

    If Length(AChaAce) > 44 Then
      Exit;

    LNomeArquivo := fNomArqComPath(AChaAce, CTe);

    blnSalvaAllCan := Pos('ALLCAN', FValCfgCteTer) > 0;
    blnSalvaCanEnt := Pos('CANENT', FValCfgCteTer) > 0;
    blnSalvaEvento := Pos('ALLEVE', FValCfgCteTer) > 0;
    blnSalvaCancel := False;

    LIncEve := 0;
    LXmlCTe := TStringList.Create;
    LUpdEve := TStringList.Create;
    Try
      pSplitText(Trim(fGetXMLCacheByKey(AChaAce)), cnsSeparador, LXmlCTe);
      If (Trim(LXmlCTe.Text) = '') Then
        pSplitText(Trim(ImportaXMLTerceiros.fRetXMLCTe(AChaAce)), cnsSeparador, LXmlCTe);

      If (FBaixaCteToma = 'S') Then
      Begin
        blnCTeOndeEmpresaEhTomador := True;
        For LIdx := 0 To LXmlCTe.Count-1 Do
        Begin
          blnCTeOndeEmpresaEhTomador := (fCTeOndeEmpresaEhTomador(LXmlCTe[LIdx]));
          If (Not blnCTeOndeEmpresaEhTomador) Then
            Break;
        End;

        If (Not blnCTeOndeEmpresaEhTomador) Then
        Begin
          pGravaChaveDeAcessoDeTerceiro(AChaAce, ADtaDoc, cnsArqSemNom, CTe);
          pAtualizaStatusDfeTer(AChaAce, cnsIgnorados);

          pDeleteFile(LNomeArquivo);

          Exit;
        End;
      End;

      For LIdx := 0 To LXmlCTe.Count-1 Do
      Begin
        If fTemNoInicial(LXmlCTe[LIdx], CTe) Then
        Begin
          LXMLPrincipal := LXmlCTe[LIdx];
          Break;
        End;
      End;

      If fDocumentoProprio(LXMLPrincipal, CTe) Then
      Begin
        pDeleteFile(LNomeArquivo);

        Exit;
      End;

      LEntradaRealizada := fExisteChaveDeAcessoCteNaCadFis(AChaAce);

      For LIdx := 0 To LXmlCTe.Count-1 Do
      Begin
        If (Not fXMLComEvento(LXmlCTe[LIdx], CTe)) Then
          Continue;

        If fXMLCancelado(LXmlCTe[LIdx]) Then
        Begin
          blnSalvaCancel := blnSalvaAllCan;
          If LEntradaRealizada Then
          Begin
            If (Not blnSalvaCancel) And (blnSalvaCanEnt) Then
              blnSalvaCancel := True;

            pAtualizaStatusDfeTer(AChaAce, cnsCancelado);
          End;

          If blnSalvaCancel Then
          Begin
            pGeraArquivoXML(LXmlCTe, fNomArqComPath(AChaAce, CTe, '_cancel'), LIdx, AChaAce, cnsCancelado, LUpdEve);
          End
          Else
          Begin
            pDeleteFile(LNomeArquivo);

            Exit;
          End;
        End
        Else If blnSalvaEvento Then
        Begin
          Inc(LIncEve);
          LSeqEve := IntToStr(LIncEve);
          pGeraArquivoXML(LXmlCTe, fNomArqComPath(AChaAce, CTe, '_evento'+LSeqEve), LIdx, AChaAce, LSeqEve, LUpdEve)
        End;
      End;

      LXmlCTe.Clear;
      LXmlCTe.Add(LXMLPrincipal);

      If LEntradaRealizada Then
      Begin
        pDeleteFile(LNomeArquivo);

        Exit;
      End;

      If fXMLPrincipalJaSalvo(AChaAce, CTe) Then
        Exit;

      If (Length(LXmlCTe.Text) < 100) Then
        Exit;

      pGeraArquivoXML(LXmlCTe, LNomeArquivo);

      If fArquivoValido(LNomeArquivo) Then
      Begin
        pAtualizaConfiguracao('XMLCTE', FCTePat);

        pGravaChaveDeAcessoDeTerceiro(AChaAce, ADtaDoc, LNomeArquivo, CTe);

        If blnSalvaCancel Then
          pAtualizaStatusDfeTer(AChaAce, cnsCancelado);

        If blnSalvaEvento Then
          pAtualizaEventoDfeTer('', '', LUpdEve);
      End;
    Finally
      FreeAndNil(LXmlCTe);
      FreeAndNil(LUpdEve);
    End;
  end;

  procedure pSalvaXML(const ATipDFe: TTipDFe);
    Var
      LPatTip: String;
      LIdx: Integer;
  begin
    LPatTip := IIF(ATipDFe = NFe, FNFePat, FCTePat);

    If (fDiretorioValido(LPatTip)) Or (fEnviandoExclusivamenteParaBucket) Then
    Begin
      LdtaDoc := DateOf(nOw());

      LPeriodo := FPeriodo;//NOS ÚLTIMOS X DIAS

      Repeat
        Try
          pFreeXMLCache;

          LLstChv.Clear;
          LLstChv.Capacity := 0;

          LListTemp := '';

          FTarefa.pSinalizarExecutando;

          If FTarefa.blnBloquear Then
            Break;

          LStatus := FTarefa.strDescricao+ ', consultando '+IIF(ATipDFe = NFe, 'NFe(s)', 'CTe(s)')+' do dia: '+FormatDateTime('dd/mm/yyyy',LdtaDoc);
          FTarefa.pAtualizarInformacao(LStatus);

          If (ATipDFe = NFe) Then
          Begin
            LListTemp := ImportaXMLTerceiros.fRetornaListaChavesAcessoTerceirosPeriodo(LCodEmpFit, LdtaDoc, LdtaDoc);
            LListTemp := StringReplace(LListTemp, cnsSeparador, #13, [rfReplaceAll]);
            AddTextToStringList(LListTemp, LLstChv);
          End
          Else
          Begin
            LNSU := 0;

            LStatus := FTarefa.strDescricao+ ', consultando CTe(s) do dia: '+FormatDateTime('dd/mm/yyyy',LdtaDoc)+' 1 à '+IntToStr((LNSU+1) * 1000);
            FTarefa.pAtualizarInformacao(LStatus);

            LListTemp := ImportaXMLTerceiros.fRetornaListaChavesAcessoCTeTerceirosPeriodo(LCodEmpFit, IntToStr(LNSU), LdtaDoc, LdtaDoc);
            LListTemp := fParserXMLCte(LListTemp);
            AddTextToStringList(LListTemp, LLstChv);

            If (LLstChv.Count >= 1000) Then
            Begin
              Repeat
                Inc(LNSU);
                LListTemp := '';

                FTarefa.pSinalizarExecutando;

                If FTarefa.blnBloquear Then
                  Break;

                LStatus := FTarefa.strDescricao+ ', consultando CTe(s) do dia: '+FormatDateTime('dd/mm/yyyy',LdtaDoc)+' '+IntToStr((LNSU * 1000)+1)+' à '+IntToStr((LNSU+1) * 1000);

                FTarefa.pAtualizarInformacao(LStatus);

                LListTemp := ImportaXMLTerceiros.fRetornaListaChavesAcessoCTeTerceirosPeriodo(LCodEmpFit, IntToStr(LNSU * 1000), LdtaDoc, LdtaDoc);
                LListTemp := fParserXMLCte(LListTemp);
                AddTextToStringList(LListTemp, LLstChv);

              Until (Length(LListTemp) < 44);
            End;

            LListTemp := '';

            pExcluirIgnorados(LdtaDoc, LLstChv);
          End;

          If FTarefa.blnBloquear Then
            Break;

          FTarefa.pAtualizarInformacao(FTarefa.strDescricao);

          LStatus := FTarefa.strDescricao+ ', importando '+IIF(ATipDFe = NFe, 'NFe(s)', 'CTe(s)')+' do dia: '+FormatDateTime('dd/mm/yyyy',LdtaDoc);

          For LIdx := 0 To LLstChv.Count -1 Do
          Begin
            FTarefa.pSinalizarExecutando;

            If FTarefa.blnBloquear Then
              Break;

            FTarefa.pAtualizarInformacao(LStatus +' '+ IntToStr(LIdx+1) +'/'+ IntToStr(LLstChv.Count));

            If (ATipDFe = NFe) Then
              pSalvaNFeTerceiros(LLstChv[LIdx], LdtaDoc)
            Else
              pSalvaCTeTerceiros(LLstChv[LIdx], LdtaDoc);
          End;
        Except
          On E: Exception Do
          Begin
            //LOGA MAS NÃO PARA. TENTA FAZER O DIA SEGUINTE
            LMsgAux := E.Message;

            LMsgAux := AnsiReplaceStr(LMsgAux, #13#10, ' ');
            LMsgAux := AnsiReplaceStr(LMsgAux, #13, ' ');
            LMsgAux := AnsiReplaceStr(LMsgAux, #10, ' ');

            LLstExc.Add(LStatus+' > ('+LMsgAux+')');
          End;
        End;

        LdtaDoc := IncDay(LdtaDoc, -1);

        If (DayOfWeek(LdtaDoc) In [2..6]) Then
          LPeriodo := LPeriodo -1;

      Until LPeriodo <= 0;
    End;
  end;

begin
  If (Not fGravaEmPastaLocal) Then
  Begin
    DeleteFile('ERRO_NFE_IMPORTAR_XML_TERCEIROS.TXT');
    If (Not fFazEnvioParaBucket) Then
      Exit;
  End;

  LLstChv := TStringList.Create;
  LLstExc := TStringList.Create;
  objConfigSovos := Nil;
  Try
    Try
      objConfigSovos := TConfiguracoesNFE.Create;
      objConfigSovos.strFitUrlWebService := fCfgSisPainel('CITURL');
      objConfigSovos.strFitLicenca       := fCfgSisPainel('CITLIC');
      objConfigSovos.strFitUsuario       := fCfgSisPainel('CITUSU');
      objConfigSovos.strFitSenha         := fCfgSisPainel('CITSEN');
      strValCfgMDEVAR := '';
      If fExisteConfiguracao('MDEVAR') Then
        strValCfgMDEVAR := fCfgSisPainel('MDEVAR');

      LCodEmpFit := fRetCodigoEmpresaNaFit;
      LServico   := 'CITEL';
      If (Pos('wsfit',       AnsiLowerCase(objConfigSovos.strFitUrlWebService)) > 0) Or
         (Pos('cloudfiscal', AnsiLowerCase(objConfigSovos.strFitUrlWebService)) > 0) Then
        LServico := 'SOVOS';

      If fExisteConfiguracao('EMP_ID') Then
      Begin
        If (LCodEmpFit = '') Then
          LCodEmpFit := Trim(fCfgSisPainel('EMP_ID'));

        If IfEmptyStr(Trim(fCfgSisPainel('EMP_ID')), LCodEmpFit) <> LCodEmpFit Then
          pGravaLogErr('PainelNFE', '[ImportaXMLTerceiros]'+#13+
                                    'Incoerência entre o identificador da empresa "'+VS_strCodPnlDir+'" na '+LServico+': (CFG_EMP_ID = '+fCfgSisPainel('EMP_ID')+'), (fRetCodigoEmpresaNaFit = '+LCodEmpFit+'). Será usado: '+LCodEmpFit);
      End;

      If (LCodEmpFit = '') Then
      begin
        Exit;
      end;

      ImportaXMLTerceiros := fCriarImportaXMLTerceirosServiceFITConfigurado(objConfigSovos, strValCfgMDEVAR, cnsSeparador);

      pLimpaXMLStreamBck;
      Try
        If (Not FBaixaNFe) Then
        Begin
          If (fFazEnvioParaBucket) Then
          Begin
            //Caso não baixe os XML de terceiros localmente, mas manda para o Bucket, oculta as informações de processamento no PainelNFe
            //e faz tudo em memória para não deixar arquivos temporários. O uso da variavel de memória deve ser usado somente neste caso.
            //Por hora faremos apenas de NFe
            FTarefa.blnOculInfo := True;

            FXMLStreamBck := TMemoryStream.Create;
          End;
        End;

        pSalvaXML(NFe);
      Finally
        pLimpaXMLStreamBck;
      End;

      pLimpaXMLStreamBck;
      Try
        pSalvaXML(CTe);
      Finally
        pLimpaXMLStreamBck;
      End;

    Except
      On E: Exception Do
      Begin
        If (fGravaEmPastaLocal) Then
          pLogarErro(FTarefa.strTarefa, E);
      End;
    End;

    If LLstExc.Count > 0 Then
    Begin
      If (fGravaEmPastaLocal) Then
        pLogarErro(FTarefa.strTarefa, LLstExc.Text);
    End;
  Finally
    If Assigned(LLstChv) Then
      FreeAndNil(LLstChv);

    If Assigned(LLstExc) Then
      FreeAndNil(LLstExc);

    If Assigned(objConfigSovos) Then
      FreeAndNil(objConfigSovos);

    pLimpaXMLStreamBck;
  End;
end;

function TImportaXMLTerceiros.fNomArqComPath(const AChaAce: String; ATipDFe: TTipDFe; ASulfixo: String=''): String;
  Var
    LDirBas: String;
begin
  If (ATipDFe = NFe) Then
    LDirBas := FNFePat
  Else
    LDirBas := FCTePat;

  Result := LDirBas + AChaAce + ASulfixo + '.xml';
end;

function TImportaXMLTerceiros.fRetornaDiretorioBase: String;
  Var
    FStrAux: String;
begin
  Result := '';

  FStrAux := GetParentFolder(Application.ExeName, 2);

  If fEmptyStr(FStrAux) Then
    Exit;

  If (Pos(AnsiLowerCase('homologacao'), AnsiLowerCase(fRemoveAcento(FStrAux))) > 0) Or (fAmbienteHomologacao) Then
  Begin
    pLogImp('Importação de NFe/CTe de Terceiros, não pode funcionar em ambiente de homologação');
    Exit;
  End;

  If (Pos(AnsiLowerCase('autcom'), AnsiLowerCase(fRemoveAcento(FStrAux))) = 0) Then
  Begin
    pLogImp('Importação de NFe/CTe de Terceiros, só pode funcionar dentro de uma pasta que tenha a palavra Autcom');
    Exit;
  End;

  Result := FStrAux;
end;

function TImportaXMLTerceiros.fCriaDirNFe: String;
  Var
    LAux: String;
begin
  Result := '';

  If FBaixaNFe Then
  Begin
    LAux := fRetornaDiretorioBase;

    If (Not fEmptyStr(LAux)) Then
    Begin
      LAux := LAux + 'XML_TERCEIROS\'+VS_strCodEmp+'\';

      If (Not DirectoryExists(LAux)) Then
        ForceDirectories(LAux);

      If (DirectoryExists(LAux) )Then
        Result := LAux
    End;
  End;
end;

function TImportaXMLTerceiros.fCriaDirCTe: String;
  Var
    LAux: String;
begin
  Result := '';

  If FBaixaCTe Then
  Begin
    LAux := fRetornaDiretorioBase;

    If (Not fEmptyStr(LAux)) Then
    Begin
      LAux := LAux + 'CTE_TERCEIROS\'+VS_strCodEmp+'\';

      If (Not DirectoryExists(LAux)) Then
        ForceDirectories(LAux);

      If (DirectoryExists(LAux)) Then
        Result := LAux
    End;
  End;
end;

function TImportaXMLTerceiros.fDocumentoProprio(const AXML: WideString; ATipDFe: TTipDFe): Boolean;
  Var
    LCNPJ: String;
begin
  Result := False;

  If (ATipDFe = NFe) Then
  Begin
    If (Pos(FTipoDownLoad, '2_') > 0) Then //2 = NFe/CTe de Fornecedores Externos + (NFe de Fornecedores Filial)
      Exit;
  End;

  LCNPJ := fCNPJEmitente(AXML, ATipDFe);
  Result := Pos(LCNPJ, FCNPJProprios) > 0;
end;

function TImportaXMLTerceiros.fExisteChaveDeAcessoNaGerEle(const AChaAce: String): Boolean;
var
  qryGen: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryGen := fCriaQuery(nil, Banco);
  Try
    qryGen.Close;
    qryGen.SQL.Text := 'SELECT COUNT(*) FROM GERELE WHERE PR07_CHNFE = :CHAACE';
    qryGen.ParamByName('CHAACE').AsString := AChaAce;
    qryGen.Open;

    Result := (qryGen.Fields[0].AsInteger > 0);

    If (Result) Then
      pLogImp(AChaAce+' de NFe já existe na GERELE');
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TImportaXMLTerceiros.fExisteChaveDeAcessoCteNaCadFis(const AChaAce: String): Boolean;
var
  qryGen: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryGen := fCriaQuery(nil, Banco);
  Try
    qryGen.Close;
    qryGen.SQL.Text := 'SELECT COUNT(*) FROM CADFIS WHERE FIS_ESPDOC = "CT" AND FIS_TIP_FC = "F" AND FIS_ACESSO = :CHAACE';
    qryGen.ParamByName('CHAACE').AsString := AChaAce;
    qryGen.Open;

    Result := (qryGen.Fields[0].AsInteger > 0);

    If (Result) Then
      pLogImp(AChaAce+' de CTe já existe na CADFIS');
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TImportaXMLTerceiros.fXMLPrincipalJaSalvo(const AChaAce: String; ATipDFe: TTipDFe): Boolean;
var
  qryGen: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryGen := fCriaQuery(nil, Banco);
  Try
    qryGen.Close;
    qryGen.SQL.Text := 'SELECT COUNT(*) FROM DFETER WHERE DFE_ACESSO = :CHAACE';
    qryGen.ParamByName('CHAACE').AsString := AChaAce;
    qryGen.Open;

    Result := (qryGen.Fields[0].AsInteger > 0);

    If (Result) Then
      pLogImp(AChaAce+' de '+IIF(ATipDFe = NFe, 'NFe', 'CTe')+' já existe na DFETER');
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TImportaXMLTerceiros.fXMLEventoJaSalvo(const AChaAce, AEvento: String): Boolean;
var
  qryGen: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  LEvento: String;
begin
  Result := False;
  If fCampoExiste('DFETER', 'DFE_EVENTO') Then
  Begin
    LEvento := AEvento+'_';

    qryGen := fCriaQuery(nil, Banco);
    Try
      qryGen.Close;
      qryGen.SQL.Text := 'SELECT DFE_EVENTO FROM DFETER WHERE DFE_ACESSO = :CHAACE';
      qryGen.ParamByName('CHAACE').AsString := AChaAce;
      qryGen.Open;

      Result := (Pos(LEvento, qryGen.Fields[0].AsString) > 0);
    Finally
      FreeAndNil(qryGen);
    End;
  End;
end;

procedure TImportaXMLTerceiros.pGravaChaveDeAcessoDeTerceiro(const AChaAce: String; ADtaDoc: TDateTime; ANomArq: String; ATipDFe: TTipDFe);
var
  qryGen: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  LUrlBkt,
  LColums,
  LValues: String;
begin
  LUrlBkt := '';
  {$IF Defined(UNIDAC)}
  If (ANomArq <> cnsArqSemNom) Then
  Begin
    LUrlBkt := fEnviarArquivoBucket(ANomArq, ATipDFe);

    If (fFazEnvioParaBucket) Then
    Begin
      If (Not fArquivoSalvoBucket(LUrlBkt)) Then
      Begin
        DeleteFile(ANomArq);
        Exit;
      End;
    End;
  End;
  {$IFEND}

  qryGen := fCriaQuery(nil, Banco);
  Try
    qryGen.Close;

    LColums := '';
    LColums := LColums + 'DFE_ACESSO,DFE_DTADOC';
    If fCampoExiste('DFETER', 'DFE_TIPDFE') And fCampoExiste('DFETER', 'DFE_CODEMP') Then
      LColums := LColums + ',DFE_TIPDFE,DFE_CODEMP';
    If fFazEnvioParaBucket And fCampoExiste('DFETER', 'DFE_URLBKT') Then
      LColums := LColums + ',DFE_URLBKT';

    LValues := AnsiReplaceStr(LColums,'DFE_',':DFE_');

    qryGen.SQL.Text := 'REPLACE INTO DFETER ('+LColums+') VALUES ('+LValues+')';

    qryGen.ParamByName('DFE_ACESSO').AsString   := AChaAce;
    qryGen.ParamByName('DFE_DTADOC').AsDateTime := ADtaDoc;

    If Assigned(qryGen.Params.FindParam('DFE_TIPDFE')) Then
      qryGen.ParamByName('DFE_TIPDFE').AsString := IIF(ATipDFe = NFe, 'NFe', 'CTe');

    If Assigned(qryGen.Params.FindParam('DFE_CODEMP')) Then
      qryGen.ParamByName('DFE_CODEMP').AsString := VS_strCodEmp;

    If Assigned(qryGen.Params.FindParam('DFE_URLBKT')) Then
      qryGen.ParamByName('DFE_URLBKT').AsString := LUrlBkt;

    qryGen.ExecSQL;
  Finally
    FreeAndNil(qryGen);
  End;

  If fFazEnvioParaBucket Then
    pGravaDetalhamentoXML(AChaAce, ANomArq, ATipDFe);
end;

procedure TImportaXMLTerceiros.pGravaDetalhamentoXML(const AChaAce, ANomArq: String; ATipDFe: TTipDFe);
var
  LXMLDocument : IXMLDocument;

  LNodeNfeProc : IXMLNode;
  LNodeNFe     : IXMLNode;
  LNodeInfNFe  : IXMLNode;
  LNodeEmit    : IXMLNode;
  LNodeDet     : IXMLNode;
  LNodeTotal   : IXMLNode;
  LNodeProd    : IXMLNode;

  LNFe         : TNFe;
  LProd        : TProd;

  qryGen: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};

  LXML: WideString;

  LSomavNFTot: Boolean;
  
  LColums,
  LValues: String;

  LNItem: Integer;
begin
  If (ATipDFe <> NFe) Then
    Exit;

  If (Not fTabelaExiste('DTLDFE', Banco)) Then
    Exit;

  Try
    LXMLDocument := TXMLDocument.Create(Nil);
    Try
      If fEnviandoExclusivamenteParaBucket Then
        LXML := fStreamToStringUTF8(FXMLStreamBck)
      Else
        LXML := fFileToStringUTF8(ANomArq);

      LXML := RemoveDeclaracaoXMLVersion(LXML);

      LXMLDocument.LoadFromXML(LXML);
      LXMLDocument.Active := True;

      {$IF RTLVersion >= 28}
      LNFe := Default(TNFe);
      {$ELSE}
      FillChar(LNFe, SizeOf(LNFe), #0);
      {$IFEND}

      LNodeNfeProc := LXMLDocument.Node.ChildNodes.FindNode('nfeProc');
      If Assigned(LNodeNfeProc) Then
        LNodeNFe := LNodeNfeProc.ChildNodes.FindNode('NFe')
      Else
        LNodeNFe := LXMLDocument.Node.ChildNodes.FindNode('NFe');

      LNodeInfNFe := fFindNodeInsensitive(LNodeNFe,    'infNFe');
      LNodeEmit   := fFindNodeInsensitive(LNodeInfNFe, 'emit');
      LNodeDet    := fFindNodeInsensitive(LNodeInfNFe, 'det');
      LNodeTotal  := fFindNodeInsensitive(LNodeInfNFe, 'total');

      {$IF RTLVersion >= 28}
      LNFe.Emit := Default(TEmit);
      {$ELSE}
      FillChar(LNFe.Emit, SizeOf(LNFe.Emit), #0);
      {$IFEND}

      LNFe.Emit.CNPJ  := fNodeValueStr(fFindNodeInsensitive(LNodeEmit,  'CNPJ'));
      LNFe.Emit.xNome := fNodeValueStr(fFindNodeInsensitive(LNodeEmit,  'xNome'));
      LNFe.Emit.xFant := fNodeValueStr(fFindNodeInsensitive(LNodeEmit,  'xFant'));
      LNFe.vNFTot     := fNodeValueFlt(fFindNodeInsensitive(LNodeTotal, 'vNFTot'));
      LSomavNFTot := False;
      If RoundTo(LNFe.vNFTot, -2) = 0 Then
        LSomavNFTot := True;

      SetLength(LNFe.Det, 0);
      LNItem := 0;
      While Assigned(LNodeDet) Do
      Begin
        If (LNodeDet.NodeType = ntElement) And SameText(LNodeDet.NodeName, 'det') Then
        Begin
          LNodeProd := fFindNodeInsensitive(LNodeDet, 'prod');

          If (Assigned(LNodeProd)) Then
          Begin
            {$IF RTLVersion >= 28}
            LProd := Default(TProd);
            {$ELSE}
            FillChar(LProd, SizeOf(LProd), #0);
            {$IFEND}

            Inc(LNItem);

            LProd.nItem  := LNItem;

            LProd.cProd  := fNodeValueStr(fFindNodeInsensitive(LNodeProd, 'cProd'));
            LProd.cEAN   := fNodeValueStr(fFindNodeInsensitive(LNodeProd, 'cEAN'));
            LProd.xProd  := fNodeValueStr(fFindNodeInsensitive(LNodeProd, 'xProd'));

            LProd.uCom   := fNodeValueStr(fFindNodeInsensitive(LNodeProd, 'uCom'));
            LProd.qCom   := fNodeValueFlt(fFindNodeInsensitive(LNodeProd, 'qCom'));
            LProd.vUnCom := fNodeValueFlt(fFindNodeInsensitive(LNodeProd, 'vUnCom'));
            LProd.vProd  := fNodeValueFlt(fFindNodeInsensitive(LNodeProd, 'vProd'));

            If LSomavNFTot Then
              LNFe.vNFTot := LNFe.vNFTot + LProd.vProd;               

            SetLength(LNFe.Det, Length(LNFe.Det) + 1);
            LNFe.Det[Length(LNFe.Det) - 1] := LProd;
          End;
        End;

        LNodeDet := LNodeDet.NextSibling;
      End;
    Finally
      LNodeProd    := Nil;
      LNodeTotal   := Nil;
      LNodeDet     := Nil;
      LNodeEmit    := Nil;
      LNodeInfNFe  := Nil;
      LNodeNFe     := Nil;
      LNodeNfeProc := Nil;
      LXMLDocument := Nil;
    End;

    qryGen := fCriaQuery(nil, Banco);
    Try
      qryGen.Close;

      LColums := '';
      LColums := LColums + 'DTL_ACESSO'
                         + ',DTL_CGCEMI'
                         + ',DTL_RZAEMI'
                         + ',DTL_FANEMI'
                         + ',DTL_TOTNFE'
                         + ',DTL_NROITE'
                         + ',DTL_CODITE'
                         + ',DTL_EANITE'
                         + ',DTL_DESITE'
                         + ',DTL_UNDITE'
                         + ',DTL_QTDITE'
                         + ',DTL_UNIITE'
                         + ',DTL_TOTITE';
      LValues := AnsiReplaceStr(LColums,'DTL_',':DTL_');

      qryGen.SQL.Text := 'REPLACE INTO DTLDFE ('+LColums+') VALUES ('+LValues+')';

      For LProd In LNFe.Det Do
      Begin
        qryGen.Close;

        qryGen.ParamByName('DTL_ACESSO').AsString  := AChaAce;

        qryGen.ParamByName('DTL_CGCEMI').AsString  := LNFe.Emit.CNPJ;
        qryGen.ParamByName('DTL_RZAEMI').AsString  := LNFe.Emit.xNome;
        qryGen.ParamByName('DTL_FANEMI').AsString  := LNFe.Emit.xFant;

        qryGen.ParamByName('DTL_TOTNFE').AsFloat   := LNFe.vNFTot;

        qryGen.ParamByName('DTL_NROITE').AsInteger := LProd.nItem;
        qryGen.ParamByName('DTL_CODITE').AsString  := LProd.cProd;
        qryGen.ParamByName('DTL_EANITE').AsString  := LProd.cEAN;
        qryGen.ParamByName('DTL_DESITE').AsString  := LProd.xProd;
        qryGen.ParamByName('DTL_UNDITE').AsString  := LProd.uCom;
        qryGen.ParamByName('DTL_QTDITE').AsFloat   := LProd.qCom;
        qryGen.ParamByName('DTL_UNIITE').AsFloat   := LProd.vUnCom;
        qryGen.ParamByName('DTL_TOTITE').AsFloat   := LProd.vProd;

        qryGen.ExecSQL;
      End;
    Finally
      FreeAndNil(qryGen);
    End;
  Except
    On E: Exception Do
      pGravaLogErr('PainelNFE', '[pGravaDetalhamentoXML]'+#13+
                                AChaAce+#13+
                                LXML+#13+
                                E.Message);
  End;
end;

//BLOCO REFERENTE AO BUCKET (SOMENTE NAS VERSÕES SUPERIORES)...[INÍCIO]

{$IF Defined(UNIDAC)}
function TImportaXMLTerceiros.fRetornaTimeStampEmMilisegundos: Int64;
  Var
    qryGen   : TUniQuery;
begin
  qryGen := fCriaQuery;
  Try
    qryGen.SQL.Text := 'SELECT CAST(UNIX_TIMESTAMP(NOW(3)) * 1000 AS UNSIGNED)';
    qryGen.Open;

    Result := qryGen.Fields[0].AsLargeInt;

    qryGen.Close;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TImportaXMLTerceiros.fObterAutorizacaoBucket: string;
var
  ChavePublica       : TStringList;
  TimestampRequisicao: Int64;
  Buffer             : array[0..2047] of WideChar;
  Retorno            : Integer;
begin
  ChavePublica := TStringList.Create;
  Try
    ChavePublica.Text   := '-----BEGIN PUBLIC KEY-----' + #13 + FChvCliBucket + #13 + '-----END PUBLIC KEY-----';
    TimestampRequisicao := fRetornaTimeStampEmMilisegundos;

    ZeroMemory(@Buffer, SizeOf(Buffer));

    Try
      Retorno := GetTokenPrefix(
                   FPrxCliBucket,
                   ChavePublica.Text,
                   TimestampRequisicao,
                   ExtractFilePath(Application.ExeName),
                   @Buffer,
                   Length(Buffer));

      if Retorno <= 0 then
        raise Exception.Create('Erro ao gerar token na DLL.');

      SetString(Result, Buffer, Retorno);
    Except
      On E: Exception Do
      Begin
        Result := '';
        pGravaLogErr('PainelNFE', '[fObterAutorizacaoBucket]'+#13+E.Message);
      End;
    End;
  Finally
    FreeAndNil(ChavePublica);
  End;
end;

function TImportaXMLTerceiros.fEnviarArquivoBucket(const ANomArq: String; ATipDFe: TTipDFe): string;
var
  RequisicaoHTTP: TIdHTTP;
  ParametrosDados: TIdMultiPartFormDataStream;
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
  RespostaRequisicao,
  LToken,
  LUrlBkt,
  LNomLoc,
  LNomMod,
  LNomArq: String;
begin
  Result := '';

  If (Not fFazEnvioParaBucket) Then
    Exit;

  RequisicaoHTTP  := TIdHTTP.Create(Nil);
  SSLHandler      := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  ParametrosDados := TIdMultiPartFormDataStream.Create;
  Try
    // Protege a chamada ao GetTokenPrefix (DLL não é thread-safe!)
    CSGetToken.Enter;
    Try
      LToken := fObterAutorizacaoBucket;
    Finally
      CSGetToken.Leave;
    End;

    If Length(LToken) = 0 Then
    Begin
      pGravaLogErr('PainelNFE', '[fObterURLDocumento]'+#13+'Token de autorização vazio ou inválido. Não foi possível acessar a API!');
      Exit;
    End;

    RequisicaoHTTP.IOHandler          := SSLHandler;
    RequisicaoHTTP.HTTPOptions        := [];
    RequisicaoHTTP.HandleRedirects    := True;
    RequisicaoHTTP.Request.Connection := 'keep-alive';
    RequisicaoHTTP.Response.KeepAlive := True;
    RequisicaoHTTP.Request.CustomHeaders.Clear;
    RequisicaoHTTP.Request.UserAgent := 'Mozilla/5.0';
    RequisicaoHTTP.Request.CustomHeaders.Values['Authorization'] := LToken;

    If fEnviandoExclusivamenteParaBucket Then
      ParametrosDados.AddFormField('file', 'application/xml', '', FXMLStreamBck, ANomArq)
    Else
      ParametrosDados.AddFile('file', ANomArq, 'application/xml');

    LNomMod := IIF(ATipDFe=NFe, 'XML_TERCEIROS', 'CTE_TERCEIROS');
    LNomLoc := FPrxCliBucket + '_' + LNomMod;
    LNomArq := LNomLoc + '_' + FCitLicBucket + '_' + ExtractFileName(ANomArq);

    Try
      RespostaRequisicao := RequisicaoHTTP.Post(FUrlCitBucket + '/api/document/' + LNomMod + '/' + LNomArq, ParametrosDados);

      LUrlBkt := RequisicaoHTTP.Response.Location;

      If (RequisicaoHTTP.Response.ResponseCode <> 200) Then
      Begin
        pGravaLogErr('PainelNFE', '[fObterURLDocumento]'+#13+IntToStr(RequisicaoHTTP.Response.ResponseCode) + ' - ' + RespostaRequisicao);
        Exit;
      End;
    Except
      On E: Exception Do
      Begin
        If (RequisicaoHTTP.Response.ResponseCode = 500) Then
        Begin
          LUrlBkt := FUrlCitBucket + '/' + LNomLoc + '_' + LNomArq;

          If fArquivoSalvoBucket(LUrlBkt) Then
          Begin
            Result := LUrlBkt;
            Exit;
          End;
        End;

        pGravaLogErr('PainelNFE', '[fObterURLDocumento]'+#13+E.Message);
        Exit;
      End;
    End;

    Result := FUrlCitBucket + '/' + LUrlBkt;
  Finally
    RequisicaoHTTP.Free;
    SSLHandler.Free;
    ParametrosDados.Free;
  End;
end;

function TImportaXMLTerceiros.fObterArquivoBucket(const AUrlBkt: string): TBytesStream;
var
  RequisicaoHTTP: TIdHTTP;
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
  ResponseStream: TMemoryStream;
  LToken: string;
begin
  Result := nil;

  If (Not fFazEnvioParaBucket) Then
    Exit;

  RequisicaoHTTP := TIdHTTP.Create(nil);
  SSLHandler     := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  ResponseStream := TMemoryStream.Create;
  Try
    Try
      CSGetToken.Enter;
      Try
        LToken := fObterAutorizacaoBucket;
      Finally
        CSGetToken.Leave;
      End;

      If Length(LToken) = 0 Then
      Begin
        pGravaLogErr('PainelNFE', '[fObterArquivoBucket]'+#13+'Token de autorização vazio ou inválido. Não foi possível acessar a API!');
        Exit;
      End;

      RequisicaoHTTP.IOHandler         := SSLHandler;
      RequisicaoHTTP.Request.CustomHeaders.Clear;
      RequisicaoHTTP.Request.UserAgent := 'Mozilla/5.0';
      RequisicaoHTTP.Request.CustomHeaders.Values['Authorization'] := LToken;

      Try
        RequisicaoHTTP.Get(AUrlBkt, ResponseStream);
        ResponseStream.Position := 0;

        Result := TBytesStream.Create;
        Result.CopyFrom(ResponseStream, ResponseStream.Size);
        Result.Position := 0;
      Except
        on E: Exception do
          pGravaLogErr('PainelNFE', '[fObterArquivoBucket]'+#13+'Erro ao obter a imagem da API: ' + E.Message);
      End;
    Except
      on E: Exception do
        pGravaLogErr('PainelNFE', '[fObterArquivoBucket]'+#13+'Erro inesperado: ' + E.Message);
    End;
  Finally
    ResponseStream.Free;
    SSLHandler.Free;
    RequisicaoHTTP.Free;
  End;
end;

function TImportaXMLTerceiros.fArquivoSalvoBucket(const AUrlBkt: string): Boolean;
  Var
    objStream : TBytesStream;
begin
  Result := False;
  objStream := Nil;
  Try
    Try
      objStream := fObterArquivoBucket(AUrlBkt);

      If Assigned(objStream) Then
        Result := objStream.Size > 0;
    Except
      Result := False;
    End;
  Finally
    If Assigned(objStream) Then
      objStream.Free;
  End;
end;
 {$IFEND}

 //...BLOCO REFERENTE AO BUCKET (SOMENTE NAS VERSÕES SUPERIORES) [FINAL]

initialization
  CSGetToken := TCriticalSection.Create;

finalization
  CSGetToken.Free;

end.
