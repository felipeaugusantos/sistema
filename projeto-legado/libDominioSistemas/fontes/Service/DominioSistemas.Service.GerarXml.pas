unit DominioSistemas.Service.GerarXml;

interface

uses
  Data.DB ;

type
  TGerarXml = class
  private
    class function fXmlIsNfe(const AXmlOri: String): Boolean ;
  public
    class function fComplementoEntrada(const ADataSet: TDataSet; const AXmlOri: String): string;
    class function fXmlServico(const ADataSet: TDataSet; const ANotaCancelada: Boolean): string;
    class function fXmlCancelamentoNfe(const ADataSet: TDataSet; const AXmlOri: String): string;
  end ;

implementation

uses
  DominioSistemas.Core.Utils, XMLIntf, XMLDoc, System.SysUtils, System.StrUtils ;

{ TGerarXml }

class function TGerarXml.fComplementoEntrada(const ADataSet: TDataSet;
  const AXmlOri: String): string;
var
  LXMLDoc: IXMLDocument;
  LRootNode, LDetNode, LProdNode, LImpostoNode: IXMLNode;
  LICMSNode, LPISNode, LCOFINSNode, LICMSCstNode, LPISAliqNode, LCOFINSAliqNode: IXMLNode;
  LChaveNfe: string;
  LNumeroItem: Integer ;
  LPrimeiraLinhaXml: String ;
begin
  LPrimeiraLinhaXml := '<?xml version="1.0" encoding="UTF-8"?>' ;

  // Cria o documento XML
  LXMLDoc := TXMLDocument.Create(nil);
  LXMLDoc.Active := True;

  // Cria o nó raiz <tr>
  LRootNode := LXMLDoc.AddChild('tr');

  // Adiciona a tag <LChaveNfe> com o valor da coluna FIS_ACESSO
  LChaveNfe := ADataSet.FieldByName('chaveNfe').AsString;
  LRootNode.AddChild('chaveNfe').Text := LChaveNfe;

  LNumeroItem := 1 ;

  ADataSet.First;
  while not ADataSet.Eof do
  begin
    // Cria o nó <det> para cada item
    LDetNode := LRootNode.AddChild('det');
    LDetNode.Attributes['nItem'] := IntToStr(LNumeroItem);

    // Cria o nó <prod> para os dados do produto
    LProdNode := LDetNode.AddChild('prod');
    LProdNode.AddChild('cProd').Text := ADataSet.FieldByName('cProd').AsString;
    LProdNode.AddChild('cEAN').Text := ADataSet.FieldByName('cEAN').AsString;
    LProdNode.AddChild('xProd').Text := ADataSet.FieldByName('xProd').AsString;
    LProdNode.AddChild('NCM').Text := ADataSet.FieldByName('NCM').AsString;
    LProdNode.AddChild('CFOP').Text := ADataSet.FieldByName('CFOP').AsString;
    LProdNode.AddChild('uCom').Text := ADataSet.FieldByName('uCom').AsString;
    LProdNode.AddChild('qCom').Text := TFuncUtils.fTrataValorDecimal(ADataSet.FieldByName('qCom')) ;
    LProdNode.AddChild('vUnCom').Text := TFuncUtils.fTrataValorDecimal(ADataSet.FieldByName('vUnCom'));
    LProdNode.AddChild('vProd').Text := TFuncUtils.fTrataValorDecimal(ADataSet.FieldByName('vProd'));
    LProdNode.AddChild('cEANTrib').Text := ADataSet.FieldByName('cEANTrib').AsString;
    LProdNode.AddChild('uTrib').Text := ADataSet.FieldByName('uTrib').AsString;
    LProdNode.AddChild('qTrib').Text := TFuncUtils.fTrataValorDecimal(ADataSet.FieldByName('qTrib')) ;
    LProdNode.AddChild('vUnTrib').Text := TFuncUtils.fTrataValorDecimal(ADataSet.FieldByName('vUnTrib'));
    LProdNode.AddChild('vFrete').Text := TFuncUtils.fTrataValorDecimal(ADataSet.FieldByName('vFrete'));
    LProdNode.AddChild('indTot').Text := ADataSet.FieldByName('indTot').AsString;

    // Cria o nó <imposto> com ICMS, PIS e COFINS
    LImpostoNode := LDetNode.AddChild('imposto');

    LImpostoNode.AddChild('vTotTrib').Text := TFuncUtils.fGetXMLValue(AXmlOri, 'NFe/infNFe/det nItem="'+IntToStr(LNumeroItem)+'"/imposto/vTotTrib') ;

    // ICMS
    LICMSNode := LImpostoNode.AddChild('ICMS');
    LICMSCstNode := LICMSNode.AddChild('ICMS' + ADataSet.FieldByName('ICMS_CST').AsString) ;

    LICMSCstNode.AddChild('orig').Text := ADataSet.FieldByName('ICMS_orig').AsString;
    LICMSCstNode.AddChild('CST').Text := ADataSet.FieldByName('ICMS_CST').AsString;
    LICMSCstNode.AddChild('modBC').Text := ADataSet.FieldByName('ICMS_modBC').AsString;
    LICMSCstNode.AddChild('vBC').Text := TFuncUtils.fTrataValorDecimal(ADataSet.FieldByName('ICMS_vBC'));
    LICMSCstNode.AddChild('pICMS').Text := TFuncUtils.fTrataValorDecimal(ADataSet.FieldByName('ICMS_pICMS'));
    LICMSCstNode.AddChild('vICMS').Text := TFuncUtils.fTrataValorDecimal(ADataSet.FieldByName('ICMS_vICMS'));

    // PIS
    LPISNode := LImpostoNode.AddChild('PIS');
    LPISAliqNode := LPISNode.AddChild('PISAliq') ;

    LPISAliqNode.AddChild('CST').Text := ADataSet.FieldByName('PIS_CST').AsString;
    LPISAliqNode.AddChild('vBC').Text := TFuncUtils.fTrataValorDecimal(ADataSet.FieldByName('PIS_vBC'));
    LPISAliqNode.AddChild('pPIS').Text := TFuncUtils.fTrataValorDecimal(ADataSet.FieldByName('PIS_pPIS'));
    LPISAliqNode.AddChild('vPIS').Text := TFuncUtils.fTrataValorDecimal(ADataSet.FieldByName('PIS_vPIS'));

    // COFINS
    LCOFINSNode := LImpostoNode.AddChild('COFINS');
    LCOFINSAliqNode := LCOFINSNode.AddChild('COFINSAliq');

    LCOFINSAliqNode.AddChild('CST').Text := ADataSet.FieldByName('COFINS_CST').AsString;
    LCOFINSAliqNode.AddChild('vBC').Text := TFuncUtils.fTrataValorDecimal(ADataSet.FieldByName('COFINS_vBC'));
    LCOFINSAliqNode.AddChild('pCOFINS').Text := TFuncUtils.fTrataValorDecimal(ADataSet.FieldByName('COFINS_pCOFINS'));
    LCOFINSAliqNode.AddChild('vCOFINS').Text := TFuncUtils.fTrataValorDecimal(ADataSet.FieldByName('COFINS_vCOFINS'));

    LNumeroItem := LNumeroItem + 1 ;
    ADataSet.Next;
  end;

  // Retorna o XML gerado como uma string
  Result := LPrimeiraLinhaXml + #13#10 + LXMLDoc.XML.Text;
end;

class function TGerarXml.fXmlCancelamentoNfe(const ADataSet: TDataSet;
  const AXmlOri: String): string;
var
  LXml: String ;
  LSignature: String ;
  LProtocolo: String ;
  Lx509: String ;
  LCnpjEmit: String ;
  LDataEmissao: String ;
  LCnpjDest: String ;
  LEmailDest: String ;
  LChaveNfe: String ;
  LId: String ;
  LDtaCanc: String ;
begin
  if fXmlIsNfe(AXmlOri) then
  begin
    LSignature := TFuncUtils.fGetXMLValue(AXmlOri, 'NFe/Signature/SignatureValue') ;
    LSignature := StringReplace(LSignature, #$A, '', [rfReplaceAll]) ;
    Lx509 := TFuncUtils.fGetXMLValue(AXmlOri, 'NFe/Signature/KeyInfo/X509Data/X509Certificate') ;
    Lx509 := StringReplace(Lx509, #$A, '', [rfReplaceAll]) ;
    LCnpjEmit := TFuncUtils.fGetXMLValue(AXmlOri, 'NFe/infNFe/emit/CNPJ') ;
    LDataEmissao := TFuncUtils.fGetXMLValue(AXmlOri, 'NFe/infNFe/ide/dhEmi') ;
    LCnpjDest := TFuncUtils.fGetXMLValue(AXmlOri, 'NFe/infNFe/dest/CPF') ;
    LEmailDest := TFuncUtils.fGetXMLValue(AXmlOri, 'NFe/infNFe/dest/email') ;
    LProtocolo := TFuncUtils.fGetXMLValue(AXmlOri, 'protNFe/infProt/nProt') ;
  end
  else //sat
  begin
    LSignature := TFuncUtils.fGetXMLValue(AXmlOri, 'CFe/Signature/SignatureValue') ;
    LSignature := StringReplace(LSignature, #$A, '', [rfReplaceAll]) ;
    Lx509 := TFuncUtils.fGetXMLValue(AXmlOri, 'CFe/Signature/KeyInfo/X509Data/X509Certificate') ;
    Lx509 := StringReplace(Lx509, #$A, '', [rfReplaceAll]) ;
    LCnpjEmit := TFuncUtils.fGetXMLValue(AXmlOri, 'CFe/infCFe/emit/CNPJ') ;
    LDataEmissao := TFuncUtils.fTrataValorDataHora(ADataSet.FieldByName('LOG_DTACAN')) + '-03:00' ;
    LCnpjDest := TFuncUtils.fGetXMLValue(AXmlOri, 'CFe/infCFe/dest/CPF') ;
    LEmailDest := '' ;
    LProtocolo := TFuncUtils.fGetXMLValue(AXmlOri, 'CFe/infCFe/ide/nCFe') ;
  end ;
  LDtaCanc := TFuncUtils.fTrataValorDataHora(ADataSet.FieldByName('LOG_DTACAN')) ;
  LChaveNfe := ADataSet.FieldByName('LOG_ACESSO').AsString ;
  LId := 'ID' + LChaveNfe ;

  LXml := '' ;
  LXml := LXml + '<?xml version="1.0" encoding="UTF-8"?> ' ;
  LXml := LXml + '<procEventoNFe xmlns="http://www.portalfiscal.inf.br/nfe" versao="1.00"> ' ;
  LXml := LXml + '	<evento xmlns="http://www.portalfiscal.inf.br/nfe" versao="1.00"> ' ;
  LXml := LXml + '		<infEvento Id="' + LId + '"> ' ;
  LXml := LXml + '			<cOrgao>35</cOrgao> ' ;
  LXml := LXml + '			<tpAmb>1</tpAmb> ' ;
  LXml := LXml + '			<CNPJ>' + LCnpjEmit + '</CNPJ> ' ;
  LXml := LXml + '			<chNFe>' + LChaveNfe + '</chNFe> ' ;
  LXml := LXml + '			<dhEvento>' + LDataEmissao + '</dhEvento> ' ;
  LXml := LXml + '			<tpEvento>110111</tpEvento> ' ;
  LXml := LXml + '			<nSeqEvento>1</nSeqEvento> ' ;
  LXml := LXml + '			<verEvento>1.00</verEvento> ' ;
  LXml := LXml + '			<detEvento versao="1.00"> ' ;
  LXml := LXml + '				<descEvento>Cancelamento</descEvento> ' ;
  LXml := LXml + '				<nProt>' + LProtocolo + '</nProt> ' ;
  LXml := LXml + '				<xJust>NFE FAT COM ERRO DE DIGITACAO</xJust> ' ;
  LXml := LXml + '			</detEvento> ' ;
  LXml := LXml + '		</infEvento> ' ;
  LXml := LXml + '		<Signature xmlns="http://www.w3.org/2000/09/xmldsig#"> ' ;
  LXml := LXml + '			<SignedInfo> ' ;
  LXml := LXml + '				<CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"/> ' ;
  LXml := LXml + '				<SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1"/> ' ;
  LXml := LXml + '				<Reference URI="#' + LId + '"> ' ;
  LXml := LXml + '					<Transforms> ' ;
  LXml := LXml + '						<Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature"/> ' ;
  LXml := LXml + '						<Transform Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"/> ' ;
  LXml := LXml + '					</Transforms> ' ;
  LXml := LXml + '					<DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1"/> ' ;
  LXml := LXml + '					<DigestValue>3xEKFib4AyyAMDX9BZ5L2XCsMoo=</DigestValue> ' ;
  LXml := LXml + '				</Reference> ' ;
  LXml := LXml + '			</SignedInfo> ' ;
  LXml := LXml + '			<SignatureValue>' + LSignature + '</SignatureValue> ' ;
  LXml := LXml + '			<KeyInfo> ' ;
  LXml := LXml + '				<X509Data> ' ;
  LXml := LXml + '					<X509Certificate>' + Lx509 + '</X509Certificate> ' ;
  LXml := LXml + '				</X509Data> ' ;
  LXml := LXml + '			</KeyInfo> ' ;
  LXml := LXml + '		</Signature> ' ;
  LXml := LXml + '	</evento> ' ;
  LXml := LXml + '	<retEvento versao="1.00" xmlns="http://www.portalfiscal.inf.br/nfe"> ' ;
  LXml := LXml + '		<infEvento> ' ;
  LXml := LXml + '			<tpAmb>1</tpAmb> ' ;
  LXml := LXml + '			<verAplic>SP_EVENTOS_PL_100</verAplic> ' ;
  LXml := LXml + '			<cOrgao>35</cOrgao> ' ;
  LXml := LXml + '			<cStat>135</cStat> ' ;
  LXml := LXml + '			<xMotivo>Evento registrado e vinculado a NF-e</xMotivo> ' ;
  LXml := LXml + '			<chNFe>' + LChaveNfe + '</chNFe> ' ;
  LXml := LXml + '			<tpEvento>110111</tpEvento> ' ;
  LXml := LXml + '			<xEvento>Cancelamento registrado</xEvento> ' ;
  LXml := LXml + '			<nSeqEvento>1</nSeqEvento> ' ;
  LXml := LXml + '			<CNPJDest>' + LCnpjDest + '</CNPJDest> ' ;
  LXml := LXml + '			<emailDest>' + LEmailDest + '</emailDest> ' ;
  LXml := LXml + '			<dhRegEvento>' + LDtaCanc + '-03:00</dhRegEvento> ' ;
  LXml := LXml + '			<nProt>' + LProtocolo + '</nProt> ' ;
  LXml := LXml + '		</infEvento> ' ;
  LXml := LXml + '	</retEvento> ' ;
  LXml := LXml + '</procEventoNFe> ' ;

  Result := LXml ;
end;

class function TGerarXml.fXmlIsNfe(const AXmlOri: String): Boolean;
begin
  Result := Pos('<NFe', AXmlOri) > 0 ;
end;

class function TGerarXml.fXmlServico(const ADataSet: TDataSet; const ANotaCancelada: Boolean): string;
var
  LXMLDoc: IXMLDocument;
  LCompNfseNode, LInfNfseNode: IXMLNode;
  LPrestadorServicoNode, LIdentificacaoPrestadorNode: IXMLNode;
  LContatoNode: IXMLNode;
  LServicoNode, LValoresNode: IXMLNode;
  LTomadorNode, LIdentificacaoTomadorNode: IXMLNode;
  LPrestadorServicoEnderecoNode: IXMLNode;
  LOrgaoGeradorNode: IXMLNode;
  LDeclaracaoPrestacaoServicoNode: IXMLNode;
  LInfDeclaracaoPrestacaoServicoNode: IXMLNode;
  LPrestacaoServicoValoresNode: IXMLNode;
  LPrestadorNode: IXMLNode;
  LEnderecoTomadorNode: IXMLNode;
  LContatoTomadorNode: IXMLNode;
  LCondicaoPagamentoNode: IXMLNode;
  LNfseNode: IXMLNode;
  LNfseCancelamentoNode: IXMLNode;
  LConfirmacaoNode: IXMLNode;
  LPedidoNode: IXMLNode;
  LInfPedidoCancelamento: IXMLNode;
  LIdentificacaoNfse: IXMLNode;
begin
  LXMLDoc := TXMLDocument.Create(nil);
  LXMLDoc.Active := True;
  LXMLDoc.Encoding := 'UTF-8';

  LCompNfseNode := LXMLDoc.AddChild('CompNfse');

  LNfseNode := LCompNfseNode.AddChild('Nfse');
  LNfseNode.SetAttribute('versao', '1.00');

  LInfNfseNode := LNfseNode.AddChild('InfNfse');
  LInfNfseNode.SetAttribute('Id', '');

  LCompNfseNode.SetAttribute('xmlns', 'http://www.abrasf.org.br/nfse.xsd') ;

  LInfNfseNode.AddChild('Numero').Text := ADataSet.FieldByName('Numero').AsString;
  LInfNfseNode.AddChild('CodigoVerificacao').Text := ADataSet.FieldByName('CodigoVerificacao').AsString;
  LInfNfseNode.AddChild('DataEmissao').Text := TFuncUtils.fTrataValorDataHora(ADataSet.FieldByName('DataEmissao')) ;

  LValoresNode := LInfNfseNode.AddChild('ValoresNfse');
  LValoresNode.AddChild('BaseCalculo').Text := TFuncUtils.fTrataValorDecimal(ADataSet.FieldByName('Valores_BaseCalculo'));
  LValoresNode.AddChild('Aliquota').Text := TFuncUtils.fTrataValorDecimal(ADataSet.FieldByName('Valores_Aliquota'));
  LValoresNode.AddChild('ValorIss').Text := TFuncUtils.fTrataValorDecimal(ADataSet.FieldByName('Valores_ValorIss'));
  LValoresNode.AddChild('ValorLiquidoNfse').Text := TFuncUtils.fTrataValorDecimal(ADataSet.FieldByName('Valores_ValorLiquidoNfse'));

  LPrestadorServicoNode := LInfNfseNode.AddChild('PrestadorServico');
  LIdentificacaoPrestadorNode := LPrestadorServicoNode.AddChild('IdentificacaoPrestador');

  LIdentificacaoPrestadorNode.AddChild('CpfCnpj').AddChild('Cnpj').Text := ADataSet.FieldByName('Prestador_CpfCnpj').AsString;
  LIdentificacaoPrestadorNode.AddChild('InscricaoMunicipal').Text := ADataSet.FieldByName('Prestador_InscricaoMunicipal').AsString;

  LPrestadorServicoNode.AddChild('RazaoSocial').Text := ADataSet.FieldByName('Prestador_RazaoSocial').AsString;
  LPrestadorServicoNode.AddChild('NomeFantasia').Text := ADataSet.FieldByName('Prestador_NomeFantasia').AsString;

  LPrestadorServicoEnderecoNode := LPrestadorServicoNode.AddChild('Endereco') ;

  LPrestadorServicoEnderecoNode.AddChild('Endereco').Text := ADataSet.FieldByName('Prestador_Endereco').AsString;
  LPrestadorServicoEnderecoNode.AddChild('Numero').Text := ADataSet.FieldByName('Prestador_Numero').AsString;
  LPrestadorServicoEnderecoNode.AddChild('Complemento').Text := ADataSet.FieldByName('Prestador_Complemento').AsString;
  LPrestadorServicoEnderecoNode.AddChild('Bairro').Text := ADataSet.FieldByName('Prestador_Bairro').AsString;
  LPrestadorServicoEnderecoNode.AddChild('CodigoMunicipio').Text := ADataSet.FieldByName('Prestador_CodigoMunicipio').AsString;
  LPrestadorServicoEnderecoNode.AddChild('CodigoPais').Text := ADataSet.FieldByName('Prestador_CodigoPais').AsString;
  LPrestadorServicoEnderecoNode.AddChild('Cep').Text := ADataSet.FieldByName('Prestador_Cep').AsString;

  LContatoNode := LPrestadorServicoNode.AddChild('Contato');
  LContatoNode.AddChild('Telefone').Text := ADataSet.FieldByName('Prestador_Contato_Telefone').AsString;
  LContatoNode.AddChild('Email').Text := ADataSet.FieldByName('Prestador_Contato_Email').AsString;

  LOrgaoGeradorNode := LInfNfseNode.AddChild('OrgaoGerador') ;
  LOrgaoGeradorNode.AddChild('CodigoMunicipio').Text := ADataSet.FieldByName('OrgaoGerador_CodigoMunicipio').AsString;
  LOrgaoGeradorNode.AddChild('Uf').Text := ADataSet.FieldByName('OrgaoGerador_UfPrestador').AsString;

  LDeclaracaoPrestacaoServicoNode := LInfNfseNode.AddChild('DeclaracaoPrestacaoServico') ;

  LInfDeclaracaoPrestacaoServicoNode := LDeclaracaoPrestacaoServicoNode.AddChild('InfDeclaracaoPrestacaoServico') ;
  LInfDeclaracaoPrestacaoServicoNode.AddChild('Competencia').Text := TFuncUtils.fTrataValorData(ADataSet.FieldByName('Competencia')) ;

  LServicoNode := LInfDeclaracaoPrestacaoServicoNode.AddChild('Servico') ;
  LPrestacaoServicoValoresNode := LServicoNode.AddChild('Valores') ;
  LPrestacaoServicoValoresNode.AddChild('ValorServicos').Text := TFuncUtils.fTrataValorDecimal(ADataSet.FieldByName('ValorServicos'));
  LPrestacaoServicoValoresNode.AddChild('DescontoIncondicionado').Text := TFuncUtils.fTrataValorDecimal(ADataSet.FieldByName('DescontoIncondicionado'));
  LPrestacaoServicoValoresNode.AddChild('ValorDeducoes').Text := TFuncUtils.fTrataValorDecimal(ADataSet.FieldByName('ValorDeducoes'));
  LPrestacaoServicoValoresNode.AddChild('ValorPis').Text := TFuncUtils.fTrataValorDecimal(ADataSet.FieldByName('ValorPis'));
  LPrestacaoServicoValoresNode.AddChild('ValorCofins').Text := TFuncUtils.fTrataValorDecimal(ADataSet.FieldByName('ValorCofins'));
  LPrestacaoServicoValoresNode.AddChild('ValorInss').Text := TFuncUtils.fTrataValorDecimal(ADataSet.FieldByName('ValorInss'));
  LPrestacaoServicoValoresNode.AddChild('ValorIr').Text := TFuncUtils.fTrataValorDecimal(ADataSet.FieldByName('ValorIr'));
  LPrestacaoServicoValoresNode.AddChild('ValorCsll').Text := TFuncUtils.fTrataValorDecimal(ADataSet.FieldByName('ValorCsll'));
  LPrestacaoServicoValoresNode.AddChild('OutrasRetencoes').Text := TFuncUtils.fTrataValorDecimal(ADataSet.FieldByName('OutrasRetencoes'));
  LPrestacaoServicoValoresNode.AddChild('ValorIss').Text := TFuncUtils.fTrataValorDecimal(ADataSet.FieldByName('ValorIss'));
  LPrestacaoServicoValoresNode.AddChild('Aliquota').Text := TFuncUtils.fTrataValorDecimal(ADataSet.FieldByName('Aliquota'));

  LServicoNode.AddChild('IssRetido').Text := ADataSet.FieldByName('IssRetido').AsString;
  LServicoNode.AddChild('ItemListaServico').Text := ADataSet.FieldByName('ItemListaServico').AsString;
  LServicoNode.AddChild('CodigoCnae').Text := ADataSet.FieldByName('CodigoCnae').AsString;
  LServicoNode.AddChild('Discriminacao').Text := ADataSet.FieldByName('Discriminacao').AsString;
  LServicoNode.AddChild('CodigoMunicipio').Text := ADataSet.FieldByName('CodigoMunicipio').AsString;
  LServicoNode.AddChild('CodigoPais').Text := ADataSet.FieldByName('CodigoPais').AsString;
  LServicoNode.AddChild('ExigibilidadeISS').Text := ADataSet.FieldByName('ExigibilidadeISS').AsString;
  LServicoNode.AddChild('MunicipioIncidencia').Text := ADataSet.FieldByName('MunicipioIncidencia').AsString;

  LPrestadorNode := LInfDeclaracaoPrestacaoServicoNode.AddChild('Prestador') ;
  LPrestadorNode.AddChild('CpfCnpj').AddChild('Cnpj').Text := ADataSet.FieldByName('Prestacao_Servico_Prestador_CpfCnpj').AsString ;
  LPrestadorNode.AddChild('InscricaoMunicipal').Text := ADataSet.FieldByName('Prestacao_Servico_Prestador_InscricaoMunicipal').AsString ;

  LTomadorNode := LInfDeclaracaoPrestacaoServicoNode.AddChild('Tomador');
  LIdentificacaoTomadorNode := LTomadorNode.AddChild('IdentificacaoTomador') ;
  LIdentificacaoTomadorNode.AddChild('CpfCnpj').AddChild('Cnpj').Text := ADataSet.FieldByName('Tomador_CpfCnpj').AsString ;

  LTomadorNode.AddChild('RazaoSocial').Text := ADataSet.FieldByName('Tomador_RazaoSocial').AsString;
  LEnderecoTomadorNode := LTomadorNode.AddChild('Endereco') ;

  LEnderecoTomadorNode.AddChild('Endereco').Text := ADataSet.FieldByName('Tomador_Endereco').AsString;
  LEnderecoTomadorNode.AddChild('Numero').Text := ADataSet.FieldByName('Tomador_Numero').AsString;
  LEnderecoTomadorNode.AddChild('Complemento').Text := ADataSet.FieldByName('Tomador_Complemento').AsString;
  LEnderecoTomadorNode.AddChild('Bairro').Text := ADataSet.FieldByName('Tomador_Bairro').AsString;
  LEnderecoTomadorNode.AddChild('CodigoMunicipio').Text := ADataSet.FieldByName('Tomador_CodigoMunicipio').AsString;
  LEnderecoTomadorNode.AddChild('Uf').Text := ADataSet.FieldByName('Tomador_UF').AsString;
  LEnderecoTomadorNode.AddChild('CodigoPais').Text := ADataSet.FieldByName('Tomador_CodigoPais').AsString;
  LEnderecoTomadorNode.AddChild('Cep').Text := ADataSet.FieldByName('Tomador_Cep').AsString;

  LContatoTomadorNode := LTomadorNode.AddChild('Contato') ;
  LContatoTomadorNode.AddChild('Telefone').Text := ADataSet.FieldByName('Contato_Telefone').AsString;
  LContatoTomadorNode.AddChild('Email').Text := ADataSet.FieldByName('Contato_Email').AsString;

  LCondicaoPagamentoNode := LInfDeclaracaoPrestacaoServicoNode.AddChild('CondicaoPagamento') ;
  LCondicaoPagamentoNode.AddChild('CONDICAO').Text := ADataSet.FieldByName('Condicao_Condicao').AsString;
  LCondicaoPagamentoNode.AddChild('QtdParcela').Text := ADataSet.FieldByName('Condicao_QtdParcela').AsString;
  LCondicaoPagamentoNode.AddChild('Parcela').Text := ADataSet.FieldByName('Condicao_Parcela').AsString;
  LCondicaoPagamentoNode.AddChild('DataVencimento').Text := TFuncUtils.fTrataValorData(ADataSet.FieldByName('Condicao_DataVencimento'));
  LCondicaoPagamentoNode.AddChild('Valor').Text := TFuncUtils.fTrataValorDecimal(ADataSet.FieldByName('Condicao_Valor'));

  LInfDeclaracaoPrestacaoServicoNode.AddChild('OptanteSimplesNacional').Text := ADataSet.FieldByName('OptanteSimplesNacional').AsString ;
  LInfDeclaracaoPrestacaoServicoNode.AddChild('IncentivoFiscal').Text := ADataSet.FieldByName('IncentivoFiscal').AsString ;

  if ANotaCancelada then
  begin
    LNfseCancelamentoNode := LCompNfseNode.AddChild('NfseCancelamento');
    LConfirmacaoNode := LNfseCancelamentoNode.AddChild('Confirmacao');
    LPedidoNode := LConfirmacaoNode.AddChild('Pedido');
    LInfPedidoCancelamento := LPedidoNode.AddChild('InfPedidoCancelamento');
    LInfPedidoCancelamento.AddChild('CodigoCancelamento').Text := ADataSet.FieldByName('Cancelamento_Codigo').AsString;
    LIdentificacaoNfse := LInfPedidoCancelamento.AddChild('IdentificacaoNfse') ;
    LIdentificacaoNfse.AddChild('Numero').Text := ADataSet.FieldByName('Numero').AsString ;
    LIdentificacaoNfse.AddChild('CpfCnpj').AddChild('Cnpj').Text := ADataSet.FieldByName('Prestador_CpfCnpj').AsString;
    LIdentificacaoNfse.AddChild('InscricaoMunicipal').Text := ADataSet.FieldByName('Prestador_InscricaoMunicipal').AsString;
    LIdentificacaoNfse.AddChild('CodigoMunicipio').Text := ADataSet.FieldByName('Prestador_CodigoMunicipio').AsString;
    LConfirmacaoNode.AddChild('DataHora').Text := TFuncUtils.fTrataValorDataHora(ADataSet.FieldByName('Cancelamento_Codigo')) ;
  end ;

  Result := LXMLDoc.XML.Text;
  //acerta o XML Manualmente
  Result := ReplaceStr(Result, 'Nfse xmlns=""', 'Nfse') ;
end;

end.
