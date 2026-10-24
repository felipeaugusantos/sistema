unit untNFSe;

interface

uses
  Vcl.Forms,
  System.Classes,
  System.StrUtils,
  System.SysUtils,
  System.Variants,
  System.DateUtils,
  untFuncoesSimples,
  XMLDoc,
  XMLIntf,
  untXMLNFSePadrao;
type

  INFSe = interface;

  INFSe = interface
  ['{9B27DBE7-6AE2-4B8A-AE91-40D49C32887B}']
    function fXMLToSchema(strPai: String; objNodeLista: IXMLNodeList): String; overload;
    function fXMLToSchema: INFSe; overload;
    function fSchemaToMD5: String; overload;
    function fSchemaMD5(var strSchemaMD5: String): INFSe; overload;
    function fSchema(var strSchema: String): INFSe; overload;
    function fSchema: String; overload;
    function fLoadFromFile(strFileName: String): INFSe;
    function fLayout(AstrLayout: String) : INFSe;
    function fXMLToText: String;
    function fCampo(strNomeCampo: String): INFSe; overload;
    function fValor: Currency; overload;
    function fData: TDate;
    function fTexto: String;
    function LayoutTipo: TXMLNFSeLayoutTipo;
  End;

  TNFSe = class(TInterfacedObject, INFSe)
  private
    FstrXML: String;
    FvarCampo: Variant;
    FobjXML: IXMLDocument;
    FstrSchema: String;
    FstrSchemaMD5: String;
    FobjLayout: TStrings;
    FstrFormato: String;
    FenuLayoutTipo: TXMLNFSeLayoutTipo;
    function fXMLToSchema(strPai: String; objNodeLista: IXMLNodeList): String; overload;
    function fConverterData(strData: String; strFormato: String): TDateTime;
    function fTipoCampo(oleCampo: OleVariant): String;
    function fXMLStrToDateTimeDef(strData: String): TDateTime;
    function fDetectarLayout(ANode: IXMLNode): TXMLNFSeLayoutTipo;
    function fCampoLayoutPadrao(strNomeCampo: String): String;
  public
    function fXMLToSchema: INFSe; overload;
    function fSchemaToMD5: String; overload;
    function fSchemaMD5(var strSchemaMD5: String): INFSe; overload;
    function fSchema(var strSchema: String): INFSe; overload;
    function fSchema: String; overload;
    function fLoadFromFile(strFileName: String): INFSe;
    function fLayout(AstrLayout: String) : INFSe;
    function fXMLToText: String;
    function fCampo(strNomeCampo: String): INFSe; overload;
    function fValor: Currency; overload;
    function fData: TDate;
    function fTexto: String;
    class function fNovo: INFSe;
    constructor Create;
    destructor Destroy; override;
    function LayoutTipo: TXMLNFSeLayoutTipo;
  End;



implementation

{ TNFSe }

constructor TNFSe.Create;
begin
  FobjXML := TXMLDocument.Create(Application);
  FobjLayout := TStringList.Create;
  FenuLayoutTipo := ltDesconhecido;
end;

destructor TNFSe.Destroy;
begin
  If Assigned(FobjLayout) Then
    FreeAndNil(FobjLayout);
  inherited;
end;

function TNFSe.fSchema: String;
begin
  Result := fstrSchema;
end;
function TNFSe.fSchemaMD5(var strSchemaMD5: String): INFSe;
begin
  Result := Self;
  strSchemaMD5 := FstrSchemaMD5;
end;

function TNFSe.fSchemaToMD5: String;
begin
  Result := FstrSchemaMD5;
end;

function TNFSe.fTexto: String;
begin
  Result := '';
  If Not VarIsNull(FvarCampo) Then
    Result := VarToStrDef(FvarCampo,'');
end;

function TNFSe.fValor: Currency;
begin
  Result := 0;
  If Not VarIsNull(FvarCampo) Then
    Result := VarToStrDef(FvarCampo,'0')
      .Replace('.',',')
      .ToExtended();
end;

//
function TNFSe.fXMLToSchema: INFSe;
begin
  Result := Self;
  FstrXML := '';
  fstrSchema := fXMLToSchema('',FobjXML.ChildNodes);
  FstrSchemaMD5 := GetMD5(fstrSchema);
end;

function TNFSe.fXMLToText: String;
begin
  Result := FobjXML.XML.Text;
end;

function TNFSe.LayoutTipo: TXMLNFSeLayoutTipo;
begin
  Result := FenuLayoutTipo;
end;

function TNFSe.fLayout(AstrLayout: String) : INFSe;
begin
  Result := Self;
  FobjLayout.Text := AstrLayout;
end;

function TNFSe.fLoadFromFile(strFileName: String): INFSe;
begin
  Result := Self;
  If Not FileExists(strFileName) Then
    raise Exception.Create('Erro ao localizar arquivo ' +  strFileName);
  FobjXML.LoadFromFile(strFileName);
  FenuLayoutTipo := fDetectarLayout(FobjXML.DocumentElement);
End;

function TNFSe.fDetectarLayout(ANode: IXMLNode): TXMLNFSeLayoutTipo;
Var
  LobjXMLNFSePadrao: TXMLNFSePadrao;
Begin
  LObjXMLNFSePadrao := TXMLNFSePadrao.Create;
  Try
    Result := LObjXMLNFSePadrao.fDetectarLayout(ANode);
  Finally
    LObjXMLNFSePadrao.Free;
  End;
End;

function TNFSe.fXMLToSchema(strPai: String; objNodeLista: IXMLNodeList): String;
var
  intNodeLista,
  intNodeAtributo: Integer;
  strNoTexto: String;
  strNodeName: String;
  objXMLNode: IXMLNode;
begin
  For intNodeLista := 0 To objNodeLista.Count -1 Do
  Begin
    objXMLNode := objNodeLista.Get(intNodeLista);

    strNodeName := objNodeLista.Get(intNodeLista).GetNodeName;

    if strNodeName =  '#text' then
      Continue;

    strNoTexto := strNodeName;
    If Not strPai.IsEmpty Then
      strNoTexto := strPai + ';' + strNodeName;

    If (objNodeLista.Get(intNodeLista).ChildNodes.Count = 1) Then
      If (objNodeLista.Get(intNodeLista).ChildNodes.Get(0).NodeName = '#text') Then
        strNoTexto := strNoTexto +  fTipoCampo(objNodeLista.Get(intNodeLista).ChildNodes.Get(0).NodeValue);
    Result := Result + strNoTexto + ';' + #13;

    For intNodeAtributo := 0 To objNodeLista.Get(intNodeLista).AttributeNodes.Count -1 Do
    Begin
      objXMLNode := objNodeLista.Get(intNodeLista).AttributeNodes.Get(intNodeAtributo);
      Result := Result + strNoTexto + ';' + objXMLNode.GetNodeName +  fTipoCampo(objXMLNode.NodeValue)  + #13;
    End;

    FstrXML := FstrXML+ Result;
    If objNodeLista.Get(intNodeLista).ChildNodes.Count > 0 Then
        Result := fXMLToSchema(strNoTexto, objNodeLista.Get(intNodeLista).ChildNodes) ;

  End;
End;

function TNFSe.fTipoCampo(oleCampo: OleVariant): String;
Var
  strValor: String;
Begin
  {
   I - INTEIRO
   S - 'TEXTO
   F - VALOR
   D - DATA
  }
  strValor := VarToStrDef(oleCampo,'');
  If StrToCurrDef(strValor.Replace('.',','),-1) <> -1 Then
    Result := '|N'
  Else If AnsiIndexStr(strValor.ToUpper,['FALSE','TRUE']) <> -1 Then
    Result := '|B'
  Else If (fXMLStrToDateTimeDef(strValor) <> 0) Then
    Result := '|D'
  Else If (strValor <> '') Then
    Result := '|S';
End;

function TNFSe.fCampoLayoutPadrao(strNomeCampo: String): String;
Var
  LObjXMLNFSePadrao: TXMLNFSePadrao;
Begin
  LObjXMLNFSePadrao := TXMLNFSePadrao.Create;
  Try
    Result := LObjXMLNFSePadrao
      .fXMLNFSeLayoutTipo(FenuLayoutTipo)
      .fCampo(strNomeCampo);
  Finally
    LObjXMLNFSePadrao.Free;
  End;
End;

function TNFSe.fCampo(strNomeCampo: String): INFSe;
var
  objNode: IXMLNode;
  strCampo: String;
  arrCampos: TArray<String>;
begin
  Result := Self;
  FvarCampo := Null;
  FstrFormato := '';

  if fEmptyStr(strNomeCampo) then
    Exit;

  case FenuLayoutTipo of
    ltDesconhecido: strNomeCampo := '';
    ltConfigurado:  strNomeCampo := FobjLayout.Values[strNomeCampo];
  else
    strNomeCampo := fCampoLayoutPadrao(strNomeCampo);
  end;

  if fEmptyStr(strNomeCampo) then Exit;

  arrCampos := strNomeCampo.Split(['|']);
  strNomeCampo := arrCampos[0];
  if Length(arrCampos) > 1 then
    FstrFormato := arrCampos[1];

  if not Assigned(FobjXML) or not Assigned(FobjXML.DocumentElement) then
    Exit;

  objNode := FobjXML.DocumentElement;
  arrCampos := strNomeCampo.Split([';']);

  for strCampo in arrCampos do
  begin
    if not Assigned(objNode) then
      Break;

    if objNode.HasAttribute(strCampo) then
    begin
      FvarCampo := objNode.Attributes[strCampo];
      Exit;
    end;

    objNode := objNode.ChildNodes.FindNode(strCampo);

    if not Assigned(objNode) then
      Break;
  end;

  if Assigned(objNode) then
  begin
    if not VarIsNull(objNode.NodeValue) and not VarIsEmpty(objNode.NodeValue) then
      FvarCampo := objNode.NodeValue;
  end;
end;

function TNFSe.fData: TDate;
begin
  Result := 0;
  If Not VarIsNull(FvarCampo) Then
    Result := fConverterData(VarToStrDef(FvarCampo,'0'),FstrFormato);
end;

function TNFSe.fConverterData(strData: String; strFormato: String): TDateTime;
Var
  dtaDataHora: TDateTime;
  strHora: String;

  intPosSegundoIni,
  intPosSegundoFin,
  intPosMinutoIni,
  intPosMinutoFin,
  intPosHoraIni,
  intPosHoraFin,

  intPosDiaIni,
  intPosDiaFin,
  intPosMesIni,
  intPosMesFin,
  intPosAnoIni,
  intPosAnoFin: Integer;
Begin
  Result := 0;

  if fEmptyStr(strData) then
    Exit;

  If TryISO8601ToDate(StringReplace(strData,'T',' ',[]), dtaDataHora) Then
    Exit(dtaDataHora);

  If TryStrToDateTime(strData, dtaDataHora) Then
    Exit(dtaDataHora);

  strFormato := strFormato.ToUpper;

  intPosSegundoIni := strFormato.IndexOf('S') + 1;
  intPosSegundoFin := strFormato.CountChar('S');

  intPosMinutoIni := strFormato.IndexOf('N') + 1;
  intPosMinutoFin := strFormato.CountChar('N');

  intPosHoraIni := strFormato.IndexOf('H') +1;
  intPosHoraFin := strFormato.CountChar('H');

  intPosDiaIni := strFormato.IndexOf('D') + 1;
  intPosDiaFin := strFormato.CountChar('D');

  intPosMesIni := strFormato.IndexOf('M') + 1;
  intPosMesFin := strFormato.CountChar('M');

  intPosAnoIni := strFormato.IndexOf('Y') +1;
  intPosAnoFin := strFormato.CountChar('Y');

  strData := Copy(strData,intPosDiaIni, intPosDiaFin) +
    '/' + Copy(strData,intPosMesIni, intPosMesFin) +
    '/' + Copy(strData,intPosAnoIni, intPosAnoFin);


  strHora := IfThen(intPosHoraIni > 0, Copy(strData,intPosHoraIni, intPosHoraFin), '00');
  strHora := strHora + ':' + IfThen(intPosHoraIni > 0, Copy(strData,intPosMinutoIni, intPosMinutoFin), '00');
  strHora := strHora + ':' + IfThen(intPosHoraIni > 0, Copy(strData,intPosSegundoIni, intPosSegundoFin), '00');

  TryStrToDateTime(strData + ' ' + strHora, dtaDataHora);

  If TDate(dtaDataHora)<> 0 Then
    Result := dtaDataHora;
End;

class function TNFSe.fNovo: INFSe;
begin
  Result := TNFSe.Create;
end;


function TNFSe.fSchema(var strSchema: String): INFSe;
begin
  Result := Self;
  strSchema := FstrSchema;
end;

function TNFSe.fXMLStrToDateTimeDef(strData: String): TDateTime;
Begin
  Result := fConverterData(strData, 'yyyy-mm-dd hh:nn:ss');
  If Result = 0 Then
    Result := fConverterData(strData, 'dd/mm/yyyy hh:nn:ss');
End;

end.
