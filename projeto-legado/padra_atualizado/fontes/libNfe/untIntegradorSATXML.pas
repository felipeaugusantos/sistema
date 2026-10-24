unit untIntegradorSATXML;

interface

uses Classes, XMLDoc, XMLIntf, SysUtils, untInterfacesIntegradorSAT;

type
  TIntegradorSATXML = Class
  private
  public
    function fGerarXML(strNomeMetodo: String; strNumeroControle: String; ParamIntegrador: TParametrosIntegrador; strComponente: String; ParamConstrutor: TParametrosIntegrador): String;
    function fIdentificarRetorno(intNumeroSessao: Integer; strXMLMsg: String): Boolean;
    function fProcessaRespostaErro(strXMLMsg: String): String;
    function fProcessaRespostaSucesso(strXMLMsg: String; strTagResposta: String = 'Resposta'): String;
    function fProcessaRespostaSolicitacaoPagamento(strXMLMsg: String): TrecVFPeRespostaSolicitacaoPagto;
    function fProcessaRespostaPagamentoRealizado(strXMLMsg: String): TrecVFPeRespostaPagtoRealizado;
  End;

implementation

{ TIntegradorSATXML }

uses untIntegradorSATLOG, untUtil;

function TIntegradorSATXML.fGerarXML(strNomeMetodo: String; strNumeroControle: String; ParamIntegrador: TParametrosIntegrador; strComponente: String; ParamConstrutor: TParametrosIntegrador): String;
  Var
    XMLDocument: IXMLDocument;
    XMLNodeIdentificador : IXMLNode;
    XMLNodeComponente : IXMLNode;
    XMLNodeMetodo : IXMLNode;
    intCnt : Integer;
begin
  XMLDocument := TXMLDocument.Create(nil);
  Try
    XMLDocument.Active := True;

    //XMLDocument.Version := '1.0';
    //XMLDocument.Encoding := 'utf-8';
    //XMLDocument.StandAlone := 'yes';

    XMLDocument.DocumentElement := XMLDocument.CreateNode('Integrador', ntElement, '');
    XMLNodeIdentificador := XMLDocument.DocumentElement.AddChild('Identificador');
    XMLNodeComponente := XMLDocument.DocumentElement.AddChild('Componente');
    XMLNodeComponente.Attributes['Nome'] := strComponente;

    XMLNodeIdentificador.AddChild('Valor').Text := strNumeroControle;

    XMLNodeMetodo := XMLNodeComponente.AddChild('Metodo');
    XMLNodeMetodo.Attributes['Nome'] := strNomeMetodo;

    If Length(ParamConstrutor) > 0 Then
    Begin
      With XMLNodeMetodo.AddChild('Construtor') Do
      Begin
        With AddChild('Parametros') Do
        Begin
          For intCnt := Low(ParamConstrutor) To High(ParamConstrutor) Do
          Begin
            With AddChild('Parametro') Do
            Begin
              AddChild('Nome').Text := ParamConstrutor[intCnt].strNome;

              If ParamConstrutor[intCnt].blnCData Then
                AddChild('Valor').DOMNode.appendChild(XMLDocument.DOMDocument.createCDATASection(String(ParamConstrutor[intCnt].strValor)))
              Else
                AddChild('Valor').Text := String(ParamConstrutor[intCnt].strValor);
            End;
          End;
        End;
      End;
    End;

    With XMLNodeMetodo.AddChild('Parametros') Do
    Begin
      For intCnt := Low(ParamIntegrador) To High(ParamIntegrador) Do
      Begin
        With AddChild('Parametro') Do
        Begin
          AddChild('Nome').Text := ParamIntegrador[intCnt].strNome;

          If ParamIntegrador[intCnt].blnCData Then
            AddChild('Valor').DOMNode.appendChild(XMLDocument.DOMDocument.createCDATASection(String(ParamIntegrador[intCnt].strValor)))
          Else
            AddChild('Valor').Text := String(ParamIntegrador[intCnt].strValor);
        End;
      End;
    End;

    Result := fConverteXMLtoUTF8(XMLDocument.XML.Text);

    TIntegradorSATLOG.pLog(XMLDocument.XML, 'fGerarXML');
  Finally
    XMLDocument := Nil;
  End;
end;

function TIntegradorSATXML.fIdentificarRetorno(intNumeroSessao: Integer; strXMLMsg: String): Boolean;
  Var
    XMLDocument : IXMLDocument;
    XMLNodeResp : IXMLNode;
    XMLNode : IXMLNode;
    intCnt : Integer;
begin
  Result := False;
  XMLDocument := TXMLDocument.Create(nil);
  Try
    Try
      XMLDocument.Active := True;
      XMLDocument.LoadFromXML( WideString(strXMLMsg) );

      XMLNodeResp := XMLDocument.DocumentElement;

      If (XMLNodeResp <> Nil) Then
      Begin
        For intCnt := 0 To XMLNodeResp.ChildNodes.Count-1 Do
        Begin
          XMLNode := XMLNodeResp.ChildNodes[intCnt];
          If (XMLNode <> Nil) Then
          Begin
            If SameText(XMLNode.NodeName, 'Identificador') Then
            Begin
              If (XMLNode.ChildNodes.Count > 0) And (XMLNode.ChildNodes[0] <> Nil) Then
                Result := XMLNode.ChildNodes[0].NodeValue = intNumeroSessao;

              Break;
            End;
          End;
        End;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
      End;
    End;
  Finally
    XMLDocument := Nil;
  End;
end;

function TIntegradorSATXML.fProcessaRespostaErro(strXMLMsg: String): String;
  Var
    XMLDocument : IXMLDocument;
    XMLNodeResp : IXMLNode;
    XMLNode : IXMLNode;
    intCnt : Integer;
    intCnt2 : Integer;
    blnPegaResposta : Boolean;
begin
  Result := '';
  blnPegaResposta := False;
  XMLDocument := TXMLDocument.Create(nil);
  Try
    Try
      XMLDocument.Active := True;
      XMLDocument.LoadFromXML( WideString(strXMLMsg) );

      XMLNodeResp := XMLDocument.DocumentElement;

      If (XMLNodeResp <> Nil) Then
      Begin
        For intCnt := 0 To XMLNodeResp.ChildNodes.Count-1 Do
        Begin
          XMLNode := XMLNodeResp.ChildNodes[intCnt];
          If (XMLNode <> Nil) Then
          Begin
            If SameText(XMLNode.NodeName, 'Erro') And (XMLNode.ChildNodes.Count > 0) Then
            Begin
              For intCnt2 := 0 To XMLNode.ChildNodes.Count-1 Do
              Begin
                If (XMLNode.ChildNodes[intCnt2] <> Nil) Then
                  Result := Result + XMLNode.ChildNodes[intCnt2].NodeName + ': ' + XMLNode.ChildNodes[intCnt2].NodeValue + sLineBreak;
              End;

              Break;
            End
            Else If (SameText(XMLNode.NodeName, 'IntegradorResposta')) And (XMLNode.ChildNodes.Count > 0) And
                    (XMLNode.ChildNodes[0] <> Nil) And (XMLNode.ChildNodes[0].NodeName = 'Codigo') And
                    (XMLNode.ChildNodes[0].NodeValue = 'EE') Then
            Begin

              For intCnt2 := 0 To XMLNode.ChildNodes.Count-1 Do
              Begin
                If (XMLNode.ChildNodes[intCnt2] <> Nil) Then
                  Result := Result + XMLNode.ChildNodes[intCnt2].NodeName + ': ' + XMLNode.ChildNodes[intCnt2].NodeValue + sLineBreak;
              End;

              blnPegaResposta := True;
            End
            Else If (blnPegaResposta) And (SameText(XMLNode.NodeName, 'Resposta')) And (XMLNode.ChildNodes.Count > 0) And
                    (XMLNode.ChildNodes[0] <> Nil) Then
            Begin
              Result := Result + XMLNode.ChildNodes[0].NodeName + ': ' + XMLNode.ChildNodes[0].NodeValue + sLineBreak;

              Break;
            End;
          End;
        End;
      End;
    Except
      On E: Exception Do
        raise Exception.Create(E.Message);
    End;
  Finally
    XMLDocument := Nil;
  End;
end;

function TIntegradorSATXML.fProcessaRespostaPagamentoRealizado(strXMLMsg: String): TrecVFPeRespostaPagtoRealizado;
  Var
    XMLDocument : IXMLDocument;
    XMLNodeResp : IXMLNode;
    XMLNode : IXMLNode;
    intCnt : Integer;
    blnPegaResposta : Boolean;
    intCnt2 : Integer;
begin
  blnPegaResposta := False;
  FillChar(Result, SizeOf(Result), #0);
  Result.strXML := strXMLMsg;
  XMLDocument := TXMLDocument.Create(nil);
  Try
    Try
      XMLDocument.Active := True;
      XMLDocument.LoadFromXML( WideString(strXMLMsg) );

      XMLNodeResp := XMLDocument.DocumentElement;

      If (XMLNodeResp <> Nil) Then
      Begin
        For intCnt := 0 To XMLNodeResp.ChildNodes.Count-1 Do
        Begin
          XMLNode := XMLNodeResp.ChildNodes[intCnt];
          If (XMLNode <> Nil) Then
          Begin
            If (SameText(XMLNode.NodeName, 'IntegradorResposta')) And (XMLNode.ChildNodes.Count > 0) And
               (XMLNode.ChildNodes[0] <> Nil) And (XMLNode.ChildNodes[0].NodeName = 'Codigo') And
               ((XMLNode.ChildNodes[0].NodeValue = INT_SAT_ARQUIVO_PROCESSADO) Or
                (XMLNode.ChildNodes[0].NodeValue = INT_SAT_ARQUIVO_COM_ERRO)) Then
            Begin
              blnPegaResposta := True;
            End
            Else If (blnPegaResposta) And (SameText(XMLNode.NodeName, 'Resposta')) And (XMLNode.ChildNodes.Count > 0) And
                    (XMLNode.ChildNodes[0] <> Nil) Then
            Begin
              For intCnt2 := 0 To XMLNode.ChildNodes.Count-1 Do
              Begin
                If (XMLNode.ChildNodes[intCnt2].NodeName = 'CodigoAutorizacao') Then
                Begin
                  Result.strCodigoAutorizacao := XMLNode.ChildNodes[intCnt2].NodeValue;

                  If (Length(fRetSomenteNumeros(Trim(Result.strCodigoAutorizacao))) <> Length(Trim(Result.strCodigoAutorizacao))) Then
                    Break;
                End
                Else If (XMLNode.ChildNodes[intCnt2].NodeName = 'Bin') Then
                  Result.strBin := XMLNode.ChildNodes[intCnt2].NodeValue
                Else If (XMLNode.ChildNodes[intCnt2].NodeName = 'DonoCartao') Then
                  Result.strDonoCartao := XMLNode.ChildNodes[intCnt2].NodeValue
                Else If (XMLNode.ChildNodes[intCnt2].NodeName = 'DataExpiracao') Then
                  Result.strDataExpiracao := XMLNode.ChildNodes[intCnt2].NodeValue
                Else If (XMLNode.ChildNodes[intCnt2].NodeName = 'InstituicaoFinanceira') Then
                  Result.strInstituicaoFinanceira := XMLNode.ChildNodes[intCnt2].NodeValue
                Else If (XMLNode.ChildNodes[intCnt2].NodeName = 'Parcelas') Then
                  Result.strParcelas := XMLNode.ChildNodes[intCnt2].NodeValue
                Else If (XMLNode.ChildNodes[intCnt2].NodeName = 'UltimosQuatroDigitos') Then
                  Result.strUltimosQuatroDigitos := XMLNode.ChildNodes[intCnt2].NodeValue
                Else If (XMLNode.ChildNodes[intCnt2].NodeName = 'CodigoPagamento') Then
                  Result.strCodigoPagamento := XMLNode.ChildNodes[intCnt2].NodeValue
                Else If (XMLNode.ChildNodes[intCnt2].NodeName = 'ValorPagamento') Then
                  Result.strValorPagamento := XMLNode.ChildNodes[intCnt2].NodeValue
                Else If (XMLNode.ChildNodes[intCnt2].NodeName = 'IdFila') Then
                  Result.strIdFila := XMLNode.ChildNodes[intCnt2].NodeValue // strCodPagto = IdFila
                Else If (XMLNode.ChildNodes[intCnt2].NodeName = 'Tipo') Then
                  Result.strTipo := XMLNode.ChildNodes[intCnt2].NodeValue;
              End;
            End;
          End;
        End;
      End;

      If (fEmptyStr(Result.strCodigoAutorizacao)) Then
      Begin
        Result.strCodigoAutorizacao := 'Não obteve a resposta correta do integrador: ' + slineBreak + WideString(strXMLMsg)
      End;
    Except
      On E: Exception Do
        raise Exception.Create(E.Message);
    End;
  Finally
    XMLDocument := Nil;
  End;
end;

function TIntegradorSATXML.fProcessaRespostaSolicitacaoPagamento(strXMLMsg: String): TrecVFPeRespostaSolicitacaoPagto;
  Var
    XMLDocument : IXMLDocument;
    XMLNodeResp : IXMLNode;
    XMLNode : IXMLNode;
    intCnt : Integer;
    intCnt2 : Integer;
    blnPegaResposta : Boolean;
begin
  blnPegaResposta := False;
  FillChar(Result, SizeOf(Result), #0);
  XMLDocument := TXMLDocument.Create(nil);
  Try
    Try
      XMLDocument.Active := True;
      XMLDocument.LoadFromXML( WideString(strXMLMsg) );

      XMLNodeResp := XMLDocument.DocumentElement;

      If (XMLNodeResp <> Nil) Then
      Begin
        For intCnt := 0 To XMLNodeResp.ChildNodes.Count-1 Do
        Begin
          XMLNode := XMLNodeResp.ChildNodes[intCnt];
          If (XMLNode <> Nil) Then
          Begin
            If (SameText(XMLNode.NodeName, 'IntegradorResposta')) And (XMLNode.ChildNodes.Count > 0) And
               (XMLNode.ChildNodes[0] <> Nil) And (XMLNode.ChildNodes[0].NodeName = 'Codigo') And
               ((XMLNode.ChildNodes[0].NodeValue = INT_SAT_ARQUIVO_PROCESSADO) Or
                (XMLNode.ChildNodes[0].NodeValue = INT_SAT_ARQUIVO_COM_ERRO)) Then
            Begin
              blnPegaResposta := True;
            End
            Else If (blnPegaResposta) And (SameText(XMLNode.NodeName, 'Resposta')) And (XMLNode.ChildNodes.Count > 0) And
                    (XMLNode.ChildNodes[0] <> Nil) Then
            Begin
              For intCnt2 := 0 To XMLNode.ChildNodes.Count-1 Do
              Begin
                If (XMLNode.ChildNodes[intCnt2].NodeName = 'IdPagamento') Then
                  Result.intIdPagamento := StrToIntDef(XMLNode.ChildNodes[intCnt2].NodeValue, 0)
                Else If (XMLNode.ChildNodes[intCnt2].NodeName = 'Mensagem') Then
                  Result.strMensagem := Trim(XMLNode.ChildNodes[intCnt2].NodeValue);
              End;
            End;
          End;
        End;
      End;

      If (Result.intIdPagamento <= 0) Then
      Begin
        If (fEmptyStr(Result.strMensagem)) Then
          Result.strMensagem := 'Não obteve a resposta correta do integrador: ' + slineBreak + WideString(strXMLMsg)
        Else
          Result.strMensagem := Result.strMensagem + sLineBreak + 'Não obteve a resposta correta do integrador: ' + slineBreak + WideString(strXMLMsg);
      End;
    Except
      On E: Exception Do
        raise Exception.Create(E.Message);
    End;
  Finally
    XMLDocument := Nil;
  End;
end;

function TIntegradorSATXML.fProcessaRespostaSucesso(strXMLMsg: String; strTagResposta: String = 'Resposta'): String;
  Var
    XMLDocument : IXMLDocument;
    XMLNodeResp : IXMLNode;
    XMLNode : IXMLNode;
    intCnt : Integer;
    blnPegaResposta : Boolean;
begin
  Result := '';
  blnPegaResposta := False;
  XMLDocument := TXMLDocument.Create(nil);
  Try
    Try
      XMLDocument.Active := True;
      XMLDocument.LoadFromXML( WideString(strXMLMsg) );

      XMLNodeResp := XMLDocument.DocumentElement;

      If (XMLNodeResp <> Nil) Then
      Begin
        For intCnt := 0 To XMLNodeResp.ChildNodes.Count-1 Do
        Begin
          XMLNode := XMLNodeResp.ChildNodes[intCnt];
          If (XMLNode <> Nil) Then
          Begin
            If (SameText(XMLNode.NodeName, 'IntegradorResposta')) And (XMLNode.ChildNodes.Count > 0) And
                    (XMLNode.ChildNodes[0] <> Nil) And (XMLNode.ChildNodes[0].NodeName = 'Codigo') And
                    (XMLNode.ChildNodes[0].NodeValue = INT_SAT_ARQUIVO_PROCESSADO) Then
            Begin
              blnPegaResposta := True;
            End
            Else If (blnPegaResposta) And (SameText(XMLNode.NodeName, strTagResposta)) And (XMLNode.ChildNodes.Count > 0) And
                    (XMLNode.ChildNodes[0] <> Nil) Then
            Begin
              Result := XMLNode.ChildNodes[0].NodeValue;
              Break;
            End;
          End;
        End;
      End;

      If (fEmptyStr(Result)) Then
        Raise Exception.Create('Não obteve a resposta correta do integrador: ' + slineBreak +
                               WideString(strXMLMsg));
    Except
      On E: Exception Do
        raise Exception.Create(E.Message);
    End;
  Finally
    XMLDocument := Nil;
  End;
end;

end.
