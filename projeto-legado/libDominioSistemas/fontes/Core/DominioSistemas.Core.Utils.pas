unit DominioSistemas.Core.Utils;

interface

uses
  System.Generics.Collections, Xml.XMLDoc, Xml.XMLIntf, Data.DB,
  DominioSistemas.Core.DocumentoInterface ;

type
  TFuncUtils = class
  private
    class function FindNodeWithNamespace(const ANode: IXMLNode; const ANamespace, AName, AAttrName, AValue: string): IXMLNode;
  public
    class function fGerarArquivoXML(const AChaveAcesso, AXMLConteudo: string; const ANomeArquivo: String = 'documento'): string;
    class procedure pApagarArquivosXML(const AXML: TDictionary<String, String>) ;
    class function fCombineURL(const ABaseURL, AResource: string): string;
    class function fGetXMLValue(const AXMLString, APath: string): string;
    class function fRetornaModeloChaveAcesso(const AChaveAcesso: String): string ;
    class function fTrataValorDecimal(const AField: TField): String ;
    class function fTrataValorData(const AField: TField): String ;
    class function fTrataValorDataHora(const AField: TField): String ;
    class function fNotaServicoCancelada(const AParamDoc: TParamDocumento): Boolean ;
  end ;

implementation

uses
  System.SysUtils, System.IOUtils ;

{ TFuncUtils }

class function TFuncUtils.fCombineURL(const ABaseURL, AResource: string): string;
var
  LCleanBase, LCleanRes: string;
begin
  LCleanBase := ABaseURL.Trim;
  LCleanRes := AResource.Trim;

  if LCleanBase.EndsWith('/') then
    LCleanBase := Copy(LCleanBase, 1, Length(LCleanBase) - 1);

  if not LCleanRes.StartsWith('/') then
    LCleanRes := '/' + LCleanRes;

  Result := LCleanBase + LCleanRes;
end;

class function TFuncUtils.fGerarArquivoXML(const AChaveAcesso,
  AXMLConteudo: string; const ANomeArquivo: String = 'documento'): string;
var
  LFileName, LFilePath: string;
begin
  LFileName := Format('%s_%s.xml', [ANomeArquivo, AChaveAcesso]);

  try
    LFilePath := TPath.Combine(TPath.GetTempPath, LFileName);
    TFile.WriteAllText(LFilePath, AXMLConteudo, TEncoding.UTF8);
    Result := LFilePath;
  except
    on E: Exception do
    begin
      LFilePath := TPath.Combine(ExtractFilePath(ParamStr(0)), LFileName);
      TFile.WriteAllText(LFilePath, AXMLConteudo, TEncoding.UTF8);
      Result := LFilePath;
    end;
  end;
end;

class function TFuncUtils.fGetXMLValue(const AXMLString, APath: string): string;
var
  LXMLDoc: IXMLDocument;
  LRootNode, LCurrentNode: IXMLNode;
  LPathParts: TArray<string>;
  LCnt: Integer;
  LNodeName, LAttrName, LAttrValue: string;
begin
  Result := '';

  LXMLDoc := TXMLDocument.Create(nil);
  try
    LXMLDoc.LoadFromXML(AXMLString);
    LXMLDoc.Active := True;

    LRootNode := LXMLDoc.DocumentElement;
    LCurrentNode := LRootNode;

    LPathParts := APath.Split(['/']);

    for LCnt := 0 to High(LPathParts) do
    begin
      if Pos('=', LPathParts[LCnt]) > 0 then
      begin
        LNodeName := Copy(LPathParts[LCnt], 1, Pos(' ', LPathParts[LCnt]) - 1);

        LAttrName := Copy(LPathParts[LCnt], Pos(' ', LPathParts[LCnt]) + 1, Pos('=', LPathParts[LCnt]) - Pos(' ', LPathParts[LCnt]) - 1);  // Nome do atributo
        LAttrValue := Copy(LPathParts[LCnt], Pos('=', LPathParts[LCnt]) + 1, MaxInt);

        if (Length(LAttrValue) > 1) and (LAttrValue[1] = '"') then
          LAttrValue := Copy(LAttrValue, 2, Length(LAttrValue) - 2);

        LCurrentNode := FindNodeWithNamespace(LCurrentNode, '', LNodeName, LAttrName, LAttrValue);
        if not Assigned(LCurrentNode) then
          Break;
      end
      else
      begin
        LCurrentNode := FindNodeWithNamespace(LCurrentNode, '', LPathParts[LCnt], '', '' ) ;
      end;

      if not Assigned(LCurrentNode) then
        Break;
    end;

    if Assigned(LCurrentNode) then
      Result := LCurrentNode.Text;

  except
    on E: Exception do
      Result := '';
  end;
end;

class function TFuncUtils.FindNodeWithNamespace(const ANode: IXMLNode;
  const ANamespace, AName, AAttrName, AValue: string): IXMLNode;
var
  LCnt: Integer;
  LChildNode: IXMLNode;
begin
  Result := nil;

  for LCnt := 0 to ANode.ChildNodes.Count - 1 do
  begin
    LChildNode := ANode.ChildNodes[LCnt];

    if (LChildNode.LocalName = AName) then
    begin
      if AValue = '' then
      begin
        Result := LChildNode;
        Exit;
      end
      else
      begin
        if LChildNode.Attributes[AAttrName] = AValue then
        begin
          Result := LChildNode;
          Exit;
        end;
      end;
    end;
  end;
end;

class function TFuncUtils.fNotaServicoCancelada(
  const AParamDoc: TParamDocumento): Boolean;
begin
  Result := AParamDoc.Status = '03' ;
end;

class function TFuncUtils.fRetornaModeloChaveAcesso(
  const AChaveAcesso: String): string;
begin
  Result := Copy(AChaveAcesso, 21, 2) ;
end;

class function TFuncUtils.fTrataValorData(const AField: TField): String;
begin
  Result := '' ;

  if AField.AsString.Trim.IsEmpty then
    Exit ;

  Result := FormatDateTime('yyyymmdd', AField.AsDateTime) ;
end;

class function TFuncUtils.fTrataValorDataHora(const AField: TField): String;
begin
  Result := '' ;

  if AField.AsString.Trim.IsEmpty then
    Exit ;

  Result := FormatDateTime('yyyy-mm-dd"T"hh:nn:ss', AField.AsDateTime) ;
end;

class function TFuncUtils.fTrataValorDecimal(const AField: TField): String;
var
  LFormatSettings: TFormatSettings;
begin
  Result := '' ;

  if AField.AsString.Trim.IsEmpty then
    Exit ;

  LFormatSettings := TFormatSettings.Create;
  LFormatSettings.DecimalSeparator := '.';

  Result := FormatFloat('0.##########', AField.AsFloat, LFormatSettings) ;
end;

class procedure TFuncUtils.pApagarArquivosXML(const AXML: TDictionary<String, String>);
var
  LKey, LPath: string;
begin
  for LKey in AXML.Keys do
  begin
    LPath := AXML.Items[LKey];
    try
      if TFile.Exists(LPath) then
        TFile.Delete(LPath);
    except
      // Se der erro (arquivo em uso, permissão, etc.), ignora
    end;
  end;
end;

end.
