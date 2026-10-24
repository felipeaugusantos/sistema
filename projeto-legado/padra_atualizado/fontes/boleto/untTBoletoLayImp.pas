unit untTBoletoLayImp;

interface

uses Classes, SysUtils, frxClass, frxDBSet, System.Generics.Collections, Uni,
     UniClientDataSet, DB, untFuncoesSimples, untFuncoesGenerica,
     System.Variants, XMLIntf, XMLDoc;

Type

  TBoletoLayImp = class
    protected
      function  fGetConteudoTag(AXml, ATag : String) : String;
      function  fGetNodeXML(ANodeName : String; ANode: IXMLNode; var ANodePaginaReport : IXMLNode) : Boolean;
      procedure pConcatenarLayoutImpressao(ALayoutImpressao : String; var AFastReport : TfrxReport);
      procedure pSetTagMasterDataNaLayImp(var ALayoutImpressao : String);
    public
      procedure pLoadLayoutImpressao(var AFastReport : TfrxReport);
  end;

implementation

{ TBoletoLayImp }

function TBoletoLayImp.fGetConteudoTag(AXml, ATag: String): String;
var
  SNodeGeral : IXMLNode;
  SXML       : IXMLDocument;
  SXMLTexto  : String;

  function fPesquisaXML(var ANode: IXMLNode; ATag: string) : Boolean;
  var
    SIdx, SIdy : integer;
    SNodeTmp   : IXMLNode;
    SChildNode : IXMLNode;
  begin
    Result := False;
    for SIdx := 0 to ANode.ChildNodes.Count - 1 do
    begin
      SNodeTmp := ANode.ChildNodes[SIdx];

      if SNodeTmp.Attributes['Name'] = null then
        continue;

      if SameText(SNodeTmp.Attributes['Name'], ATag) then
      begin
        Result := True;
        for SIdy := 0 to SNodeTmp.ChildNodes.Count - 1 do
        begin
          SChildNode := SNodeTmp.ChildNodes[SIdy];
          SXMLTexto  := SXMLTexto + SChildNode.XML;
        end;
         Exit;
      end
      else if SNodeTmp.ChildNodes.Count > 0 then
      begin
         Result := fPesquisaXML(SNodeTmp, ATag);
         if Result then
            Exit;
      end;
    end;
  end;


begin
  try
    SXML        := LoadXMLData(AXml);
    SXML.Active := True;
    SNodeGeral  := SXML.DocumentElement;

    if fPesquisaXML(SNodeGeral, ATag)  then
      Result := SXMLTexto
    else
      Result := '';
  finally
  end;
end;

function TBoletoLayImp.fGetNodeXML(ANodeName: String; ANode: IXMLNode; var ANodePaginaReport: IXMLNode): Boolean;
var
  SIdx       : integer;
  SNodeTmp   : IXMLNode;
begin
  Result := False;

  if ANode.NodeName = ANodeName then
    begin
      ANodePaginaReport := ANode;
      Exit(True);
    end;

  for SIdx := 0 to ANode.ChildNodes.Count - 1 do
  begin
    SNodeTmp := ANode.ChildNodes[SIdx];

    if SNodeTmp.NodeName = ANodeName then
    begin
      ANodePaginaReport := SNodeTmp;
      Exit(True);
    end
    else if SNodeTmp.ChildNodes.Count > 0 then
    begin
      if fGetNodeXML(ANodeName, SNodeTmp, ANodePaginaReport) then
        Exit(True);
    end;
  end;
end;

procedure TBoletoLayImp.pConcatenarLayoutImpressao(ALayoutImpressao: String; var AFastReport: TfrxReport);
var SStream             : TStringStream;
    SQuery              : TUniQuery;
    SStreamLoad         : TStream;
    SXML                : IXMLDocument;
    SXmlParaTroca       : String;
begin
  SStream     := TStringStream.Create;
  SStreamLoad := TStream.Create;
  SQuery      := fCriaQuery();

  try
    AFastReport.SaveToStream(SStream);

    SXML := LoadXMLData(SStream.DataString);

    SXmlParaTroca := fGetConteudoTag(SXML.XML.Text, 'Page3');

    SXML.XML.Text := StringReplace(SXML.XML.Text, SXmlParaTroca, ALayoutImpressao,[rfReplaceAll]);

    SQuery.SQL.Text := 'SELECT * FROM LAYIMP WHERE FALSE';
    SQuery.Open;
    SQuery.Insert;
    SQuery.FieldByName('LAY_RELFR3').AsString := SXML.XML.Text;
    SStreamLoad := SQuery.CreateBlobStream(SQuery.FieldByName('LAY_RELFR3'), bmRead);
    AFastReport.LoadFromStream(SStreamLoad);

    SQuery.Cancel;
  finally
    FreeAndNil(SStream);
    FreeAndNil(SStreamLoad);
    FreeAndNil(SQuery);
  end;

end;

procedure TBoletoLayImp.pLoadLayoutImpressao(var AFastReport: TfrxReport);
var SQuery              : TUniQuery;
    SXMLLayoutImpressao : String;
    SXML                : IXMLDocument;
    SNodePaginaReport   : IXMLNode;
begin
  SQuery      := fCriaQuery();
  try
    SQuery.Close;
    SQuery.SQL.Text := 'SELECT * FROM LAYIMP '+
                       'WHERE LAY_CODEMP = :CODEMP AND '+
                       '      LAY_CODLAY = :CODLAY     '+
                       ' ORDER BY LAY_DTAALT DESC, LAY_HORALT DESC '+
                       ' LIMIT 1 ';
    SQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;
    SQuery.ParamByName('CODLAY').AsString := 'BOLCTR';
    SQuery.Open;
    if SQuery.IsEmpty then
      Exit;

    SXMLLayoutImpressao := SQuery.FieldByName('LAY_RELFR3').AsString;

    {*****************************************************************}
    {*ROTINA QUE VAI VERIFICAR A EXISTENCIA DA TAGA MASTER DATA NO   *}
    {*CONTEUDO PROVENIENTE DA LAYIMP. PELO MESMO SER EXECUTADO DENTRO*}
    {*DE UM SUBREPORT É NECESSÁRIO TER UM MASTER DATA. SE NÃO TIVER  *}
    {*ESSA ROTINA VAI ADICIONAR UM EM TEMPO DE EXECUÇÃO              *}
    {**************************************************************GD*}
    pSetTagMasterDataNaLayImp(SXMLLayoutImpressao);

    SXML              := LoadXMLData(SXMLLayoutImpressao);
    SXML.Active       := True;
    fGetNodeXML('TfrxReportPage', SXML.DocumentElement, SNodePaginaReport);
    if Assigned(SNodePaginaReport) then
    begin
      SXMLLayoutImpressao := fGetConteudoTag(SXMLLayoutImpressao,
                                             SNodePaginaReport.Attributes['Name']);
      pConcatenarLayoutImpressao(SXMLLayoutImpressao, AFastReport);
    end;

    SQuery.Close;
  finally
    FreeAndNil(SQuery);
  end;
end;

procedure TBoletoLayImp.pSetTagMasterDataNaLayImp(var ALayoutImpressao: String);
var SXML                : IXMLDocument;
    SNodePaginaReport,
    SNodeMasterData     : IXMLNode;
    SIdx                : Integer;
    SAltura,
    STop                : String;
begin
  try
    SXML := LoadXMLData(ALayoutImpressao);
    SXML.Active := True;

    if not fGetNodeXML('TfrxReportPage', SXML.DocumentElement, SNodePaginaReport) then
      Exit;

    for SIdx := 0 to SNodePaginaReport.ChildNodes.Count - 1 do
      if SNodePaginaReport.ChildNodes.Nodes[SIdx].NodeName = 'TfrxMasterData' then
        Exit;

    SAltura := '0';
    STop    := '0';
    for SIdx := 0 to SNodePaginaReport.ChildNodes.Count - 1 do
    begin
      if ((SNodePaginaReport.ChildNodes.Nodes[SIdx].NodeName = 'TfrxFooter') and
          (SNodePaginaReport.ChildNodes.Nodes[SIdx].Attributes['Top'] <> null))
          or
         ((SNodePaginaReport.ChildNodes.Nodes[SIdx].Attributes['Top'] <> null) and
          (StrToFloat(SNodePaginaReport.ChildNodes.Nodes[SIdx].Attributes['Top']) > StrToFloat(STop))) then
      begin
        STop := SNodePaginaReport.ChildNodes.Nodes[SIdx].Attributes['Top'];

        if SNodePaginaReport.ChildNodes.Nodes[SIdx].NodeName = 'TfrxFooter' then
        begin
          SAltura := '0';
          SNodePaginaReport.ChildNodes.Nodes[SIdx].Attributes['Top'] :=
          FloatToStr(StrToFloat(SNodePaginaReport.ChildNodes.Nodes[SIdx].Attributes['Top']) + 1);
          Break;
        end
        else
        begin
          if SNodePaginaReport.ChildNodes.Nodes[SIdx].Attributes['Height'] <> null then
            SAltura := SNodePaginaReport.ChildNodes.Nodes[SIdx].Attributes['Height'];
        end;

      end;
    end;

    SNodeMasterData                        := SNodePaginaReport.AddChild('TfrxMasterData');
    SNodeMasterData.Attributes['Top']      := floattostr(strtofloat(SAltura)+strtofloat(STop));
    SNodeMasterData.Attributes['Name']     := 'MasterDataLayImp';
    SNodeMasterData.Attributes['RowCount'] := '1';

    ALayoutImpressao := SXML.XML.Text;

  except on E:Exception do
    Raise Exception.Create(E.Message);
  end;
end;

end.
