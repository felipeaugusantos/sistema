unit untProvIPM;

interface

uses
{$IF Defined(LINUX)}
  untUniClientDataSet,
{$ELSE}
  {$IF Defined(UNIDAC)}
    UniClientDataSet, Uni, MySQLUniProvider, UniProvider,
  {$ELSE}
   ZConnection, ZDataset, ZDbcIntfs,
  {$IFEND}
  Windows, Messages, Graphics, Controls, Forms,
  ComCtrls, StdCtrls, ExtCtrls, DBCtrls, MemDS, Dialogs,
  frxClass, frxBarcode, frxDBSet, frxDelphiZXingQRCode,
  frxDesgn, untUniClientDataSet,
{$IFEND}
  SysUtils, Variants, Classes, StrUtils, untConexaoBD,
  untUtil, XMLIntf, XMLDoc, DB, DBClient;

type
  TProvIPM = class
    public
      class procedure pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string);

  end;

type
  TProvIPMV2 = class
    public
      class procedure pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string);
  end;

type
  TProvIPMVReforma = class
    public
      class function FindNode(const ANode: IXMLNode; const ANodeName: string): IXMLNode;
      class procedure pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string);
  end;

implementation

{ TProvIPM }

class procedure TProvIPM.pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet;
  strXML: string);
var
  XmlDoc : IXMLDocument;

  XmlNodePrincipal,
  XmlNodeValoresNfse,
  XmlNodePrestador,
  XmlNodePrestadorEndereco,
  XmlNodePrestadorContato,
  XmlNodeTomador,
  XmlNodeTomadorEndereco,
  XmlNodeTomadorContato,
  XmlNodeTomadorIdentificador,
  XmlNodeInfDecPresServ,
  XmlNodeInfDecPresServServ,
  XmlNodeDecPresServValServ,
  XmlNodeDecPresServRps : IXMLNode;

begin

  xmlDoc := TXMLDocument.Create(Application);

  xmlDoc.LoadFromXML(strXML);
  xmlDoc.Active := True;

  XmlNodePrincipal            := XmlDoc.ChildNodes['Nfse']
                                       .ChildNodes['InfNfse'];
  XmlNodeValoresNfse          := XmlNodePrincipal.ChildNodes['ValoresNfse'];
  XmlNodeInfDecPresServ       := XmlNodePrincipal.ChildNodes['DeclaracaoPrestacaoServico']
                                                 .ChildNodes['InfDeclaracaoPrestacaoServico'];
  XmlNodeInfDecPresServServ   := XmlNodeInfDecPresServ.ChildNodes['Servico'];
  XmlNodeDecPresServValServ   := XmlNodeInfDecPresServServ.ChildNodes['Valores'];
  XmlNodeDecPresServRps       := XmlNodeInfDecPresServ.ChildNodes['Rps'].ChildNodes['IdentificacaoRps'];
  XmlNodePrestador            := XmlNodePrincipal.ChildNodes['PrestadorServico'];
  XmlNodePrestadorEndereco    := XmlNodePrestador.ChildNodes['Endereco'];
  XmlNodePrestadorContato     := XmlNodePrestador.ChildNodes['Contato'];
  XmlNodeTomador              := XmlNodeInfDecPresServ.ChildNodes['TomadorServico'];
  XmlNodeTomadorEndereco      := XmlNodeTomador.ChildNodes['Endereco'];
  XmlNodeTomadorContato       := XmlNodeTomador.ChildNodes['Contato'];
  XmlNodeTomadorIdentificador := XmlNodeTomador.ChildNodes['IdentificacaoTomador']
                                               .ChildNodes['CpfCnpj'];

  cdsNFS.Append;
  // Dados da NFS
  cdsNFS.FieldByName('NUMNFS').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('Numero'));
  cdsNFS.FieldByName('SERIE').AsString  := '';
  cdsNFS.FieldByName('CODVER').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('CodigoVerificacao'));
  cdsNFS.FieldByName('DTAEMI').AsString := Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DataEmissao')),9,2)+'/'+
                                           Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DataEmissao')),6,2)+'/'+
                                           Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DataEmissao')),1,4);
  cdsNFS.FieldByName('DTAHRA').AsString := Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DataEmissao')),12,8);
  cdsNFS.FieldByName('NUMRPS').AsString := fRetornaValorTagXml(XmlNodeDecPresServRps.ChildNodes.FindNode('Numero'));
  cdsNFS.FieldByName('SERRPS').AsString := fRetornaValorTagXml(XmlNodeDecPresServRps.ChildNodes.FindNode('Serie'));
  cdsNFS.FieldByName('TPORPS').AsString := fRetornaValorTagXml(XmlNodeDecPresServRps.ChildNodes.FindNode('Tipo'));
  cdsNFS.FieldByName('EMIRPS').AsString := Copy(fRetornaValorTagXml(XmlNodeDecPresServRps.ChildNodes.FindNode('DataEmissao')),9,2)+'/'+
                                           Copy(fRetornaValorTagXml(XmlNodeDecPresServRps.ChildNodes.FindNode('DataEmissao')),6,2)+'/'+
                                           Copy(fRetornaValorTagXml(XmlNodeDecPresServRps.ChildNodes.FindNode('DataEmissao')),1,4);
  cdsNFS.FieldByName('NATOPE').AsString := '';
  cdsNFS.FieldByName('CODRET').AsString := '';
  cdsNFS.FieldByName('EMIOSN').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes.FindNode('OptanteSimplesNacional'));
  cdsNFS.FieldByName('EMIICC').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes.FindNode('IncentivoFiscal'));
  cdsNFS.FieldByName('COMPET').AsString := Copy(fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes.FindNode('Competencia')),9,2)+'/'+
                                           Copy(fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes.FindNode('Competencia')),6,2)+'/'+
                                           Copy(fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes.FindNode('Competencia')),1,4);
  cdsNFS.FieldByName('OUTINF').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('OutrasInformacoes'));
  cdsNFS.FieldByName('ORGMUN').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('CodigoMunicipio'));
  cdsNFS.FieldByName('ORG_UF').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('Uf'));
  cdsNFS.FieldByName('_LINK_').AsString := '';

  //Valores
  cdsNFS.FieldByName('VLRSER').AsFloat   := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeDecPresServValServ.ChildNodes.FindNode('ValorServicos')),'.',','), 0);
  cdsNFS.FieldByName('ISS_RET').AsFloat  := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeInfDecPresServServ.ChildNodes.FindNode('IssRetido')),'.',','), 0);
  cdsNFS.FieldByName('VLRISS').AsFloat   := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeValoresNfse.ChildNodes.FindNode('ValorIss')),'.',','), 0);
  cdsNFS.FieldByName('BSCISS').AsFloat   := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeValoresNfse.ChildNodes.FindNode('BaseCalculo')),'.',','), 0);
  cdsNFS.FieldByName('ALIISS').AsFloat   := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeValoresNfse.ChildNodes.FindNode('Aliquota')),'.',','), 0);
  cdsNFS.FieldByName('VLRLIQ').AsFloat   := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeValoresNfse.ChildNodes.FindNode('ValorLiquidoNfse')),'.',','), 0);
  cdsNFS.FieldByName('CODSER').AsString  := fRetornaValorTagXml(XmlNodeInfDecPresServServ.ChildNodes.FindNode('ItemListaServico'));
  cdsNFS.FieldByName('CDCNAE').AsString  := fRetornaValorTagXml(XmlNodeInfDecPresServServ.ChildNodes.FindNode('CodigoCnae'));
  cdsNFS.FieldByName('CODTRI').AsString  := '';
  cdsNFS.FieldByName('DISCRI').AsString  := fRetornaValorTagXml(XmlNodeInfDecPresServServ.ChildNodes.FindNode('Discriminacao'));
  cdsNFS.FieldByName('CODMUN').AsString  := fRetornaValorTagXml(XmlNodeInfDecPresServServ.ChildNodes.FindNode('CodigoMunicipio'));
  cdsNFS.FieldByName('ITEDESC').AsString := '';
  cdsNFS.FieldByName('ITEQTD').AsFloat   := 0;
  cdsNFS.FieldByName('ITEVLU').AsFloat   := 0;

  //Prestador
  cdsNFS.FieldByName('PSVCNPJ').AsString  := '';
  cdsNFS.FieldByName('PSVIM').AsString    := '';
  cdsNFS.FieldByName('PSVRAZAO').AsString := fRetornaValorTagXml(XmlNodePrestador.ChildNodes.FindNode('RazaoSocial'));
  cdsNFS.FieldByName('PSVFANT').AsString  := fRetornaValorTagXml(XmlNodePrestador.ChildNodes.FindNode('NomeFantasia'));
  cdsNFS.FieldByName('PSVEND').AsString   := fRetornaValorTagXml(XmlNodePrestadorEndereco.ChildNodes.FindNode('Endereco'));
  cdsNFS.FieldByName('PSVNUM').AsString   := fRetornaValorTagXml(XmlNodePrestadorEndereco.ChildNodes.FindNode('Numero'));
  cdsNFS.FieldByName('PSVCOMPL').AsString := fRetornaValorTagXml(XmlNodePrestadorEndereco.ChildNodes.FindNode('Complemento'));
  cdsNFS.FieldByName('PSVBAIR').AsString  := fRetornaValorTagXml(XmlNodePrestadorEndereco.ChildNodes.FindNode('Bairro'));
  cdsNFS.FieldByName('PSVMUN').AsString   := fRetornaValorTagXml(XmlNodePrestadorEndereco.ChildNodes.FindNode('CodigoMunicipio'));
  cdsNFS.FieldByName('PSVUF').AsString    := fRetornaValorTagXml(XmlNodePrestadorEndereco.ChildNodes.FindNode('Uf'));
  cdsNFS.FieldByName('PSVCEP').AsString   := fRetornaValorTagXml(XmlNodePrestadorEndereco.ChildNodes.FindNode('Cep'));
  cdsNFS.FieldByName('PSVFONE').AsString  := fRetornaValorTagXml(XmlNodePrestadorContato.ChildNodes.FindNode('Telefone'));
  cdsNFS.FieldByName('PSVEMAIL').AsString := fRetornaValorTagXml(XmlNodePrestadorContato.ChildNodes.FindNode('Email'));
  //Tomador
  cdsNFS.FieldByName('TMSCNPJ').AsString  := iif( fRetornaValorTagXml(XmlNodeTomadorIdentificador.ChildNodes.FindNode('Cpf')) = '',
                                                  fRetornaValorTagXml(XmlNodeTomadorIdentificador.ChildNodes.FindNode('Cnpj')),
                                                  fRetornaValorTagXml(XmlNodeTomadorIdentificador.ChildNodes.FindNode('Cpf')));
  cdsNFS.FieldByName('TMSIM').AsString    := '';
  cdsNFS.FieldByName('TMSRAZAO').AsString := fRetornaValorTagXml(XmlNodeTomador.ChildNodes.FindNode('RazaoSocial'));
  cdsNFS.FieldByName('TMSFANTA').AsString := '';
  cdsNFS.FieldByName('TMSEND').AsString   := fRetornaValorTagXml(XmlNodeTomadorEndereco.ChildNodes.FindNode('Endereco'));
  cdsNFS.FieldByName('TMSNUM').AsString   := fRetornaValorTagXml(XmlNodeTomadorEndereco.ChildNodes.FindNode('Numero'));
  cdsNFS.FieldByName('TMSCOMPL').AsString := fRetornaValorTagXml(XmlNodeTomadorEndereco.ChildNodes.FindNode('Complemento'));
  cdsNFS.FieldByName('TMSBAIR').AsString  := fRetornaValorTagXml(XmlNodeTomadorEndereco.ChildNodes.FindNode('Bairro'));
  cdsNFS.FieldByName('TMSMUN').AsString   := fRetornaValorTagXml(XmlNodeTomadorEndereco.ChildNodes.FindNode('CodigoMunicipio'));
  cdsNFS.FieldByName('TMSUF').AsString    := fRetornaValorTagXml(XmlNodeTomadorEndereco.ChildNodes.FindNode('Uf'));
  cdsNFS.FieldByName('TMSCEP').AsString   := fRetornaValorTagXml(XmlNodeTomadorEndereco.ChildNodes.FindNode('Cep'));
  cdsNFS.FieldByName('TMSFONE').AsString  := fRetornaValorTagXml(XmlNodeTomadorContato.ChildNodes.FindNode('Telefone'));
  cdsNFS.FieldByName('TMSEMAIL').AsString := fRetornaValorTagXml(XmlNodeTomadorContato.ChildNodes.FindNode('Email'));

  cdsNFS.Post;

end;

class procedure TProvIPMV2.pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet;
  strXML: string);

  function fTrataXml(strXML: String): String;
  begin
    Result := ReplaceStr(strXML, '>n',  '>');
    Result := ReplaceStr(Result, '>nt', '>');
    Result := Trim(Result);
  End;

var
  XmlDoc : IXMLDocument;

  XmlNodePrincipal,
  XmlNodenf,
  XmlNodeprestador,
  XmlNodetomador,
  XmlNodeitens : IXMLNode;

begin

  xmlDoc := TXMLDocument.Create(Application);

  xmlDoc.LoadFromXML(fTrataXml(strXML));
  xmlDoc.Active := True;

  XmlNodePrincipal  := XmlDoc.ChildNodes['nfse'];
  XmlNodenf         := XmlNodePrincipal.ChildNodes['nf'];
  XmlNodeprestador  := XmlNodePrincipal.ChildNodes['prestador'];
  XmlNodetomador    := XmlNodePrincipal.ChildNodes['tomador'];
  XmlNodeitens      := XmlNodePrincipal.ChildNodes['itens'].ChildNodes['lista'];

  cdsNFS.Append;
  // Dados da NFS
  cdsNFS.FieldByName('NUMNFS').AsString := fRetornaValorTagXml(XmlNodenf.ChildNodes.FindNode('numero_nfse'));
  cdsNFS.FieldByName('SERIE').AsString  := fRetornaValorTagXml(XmlNodenf.ChildNodes.FindNode('serie_nfse'));
  cdsNFS.FieldByName('CODVER').AsString := fRetornaValorTagXml(XmlNodenf.ChildNodes.FindNode('cod_verificador_autenticidade'));
  cdsNFS.FieldByName('DTAEMI').AsString := fRetornaValorTagXml(XmlNodenf.ChildNodes.FindNode('data_nfse'));
  cdsNFS.FieldByName('DTAHRA').AsString := fRetornaValorTagXml(XmlNodenf.ChildNodes.FindNode('hora_nfse'));
  cdsNFS.FieldByName('NUMRPS').AsString := '';
  cdsNFS.FieldByName('SERRPS').AsString := '';
  cdsNFS.FieldByName('TPORPS').AsString := '';
  cdsNFS.FieldByName('EMIRPS').AsString := '';
  cdsNFS.FieldByName('NATOPE').AsString := '';
  cdsNFS.FieldByName('CODRET').AsString := '';
  cdsNFS.FieldByName('EMIOSN').AsString := '';
  cdsNFS.FieldByName('EMIICC').AsString := '';
  cdsNFS.FieldByName('COMPET').AsString := '';
  cdsNFS.FieldByName('OUTINF').AsString := '';
  cdsNFS.FieldByName('ORGMUN').AsString := '';
  cdsNFS.FieldByName('ORG_UF').AsString := '';
  cdsNFS.FieldByName('_LINK_').AsString := fRetornaValorTagXml(XmlNodenf.ChildNodes.FindNode('link_nfse'));

  //Valores
  cdsNFS.FieldByName('VLRSER').AsFloat   := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodenf.ChildNodes.FindNode('valor_total')),'.',','), 0);
  cdsNFS.FieldByName('ISS_RET').AsFloat  := 0;
  cdsNFS.FieldByName('VLRISS').AsFloat   := ( StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodenf.ChildNodes.FindNode('valor_total')),'.',','), 0) *
                                              StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeitens.ChildNodes.FindNode('aliquota_item_lista_servico')),'.',','), 0) /
                                              100 );
  cdsNFS.FieldByName('BSCISS').AsFloat   := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeitens.ChildNodes.FindNode('valor_tributavel')),'.',','), 0);
  cdsNFS.FieldByName('ALIISS').AsFloat   := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeitens.ChildNodes.FindNode('aliquota_item_lista_servico')),'.',','), 0);
  cdsNFS.FieldByName('VLRLIQ').AsFloat   := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodenf.ChildNodes.FindNode('valor_total')),'.',','), 0);
  cdsNFS.FieldByName('CODSER').AsString  := fRetornaValorTagXml(XmlNodeitens.ChildNodes.FindNode('codigo_item_lista_servico'));
  cdsNFS.FieldByName('CDCNAE').AsString  := Copy(fRetornaValorTagXml(XmlNodeitens.ChildNodes.FindNode('codigo_atividade')), 1, 7);
  cdsNFS.FieldByName('CODTRI').AsString  := '';
  cdsNFS.FieldByName('DISCRI').AsString  := fRetornaValorTagXml(XmlNodeitens.ChildNodes.FindNode('descritivo'));
  cdsNFS.FieldByName('CODMUN').AsString  := '';
  cdsNFS.FieldByName('ITEDESC').AsString := '';
  cdsNFS.FieldByName('ITEQTD').AsFloat   := 0;
  cdsNFS.FieldByName('ITEVLU').AsFloat   := 0;

  //Prestador
  cdsNFS.FieldByName('PSVCNPJ').AsString  := '';
  cdsNFS.FieldByName('PSVIM').AsString    := '';
  cdsNFS.FieldByName('PSVRAZAO').AsString := '';
  cdsNFS.FieldByName('PSVFANT').AsString  := '';
  cdsNFS.FieldByName('PSVEND').AsString   := '';
  cdsNFS.FieldByName('PSVNUM').AsString   := '';
  cdsNFS.FieldByName('PSVCOMPL').AsString := '';
  cdsNFS.FieldByName('PSVBAIR').AsString  := '';
  cdsNFS.FieldByName('PSVMUN').AsString   := '';
  cdsNFS.FieldByName('PSVUF').AsString    := '';
  cdsNFS.FieldByName('PSVCEP').AsString   := '';
  cdsNFS.FieldByName('PSVFONE').AsString  := '';
  cdsNFS.FieldByName('PSVEMAIL').AsString := '';
  //Tomador
  cdsNFS.FieldByName('TMSCNPJ').AsString  := fRetornaValorTagXml(XmlNodetomador.ChildNodes.FindNode('cpfcnpj'));
  cdsNFS.FieldByName('TMSIM').AsString    := '';
  cdsNFS.FieldByName('TMSRAZAO').AsString := fRetornaValorTagXml(XmlNodetomador.ChildNodes.FindNode('nome_razao_social'));
  cdsNFS.FieldByName('TMSFANTA').AsString := fRetornaValorTagXml(XmlNodetomador.ChildNodes.FindNode('sobrenome_nome_fantasia'));
  cdsNFS.FieldByName('TMSEND').AsString   := fRetornaValorTagXml(XmlNodetomador.ChildNodes.FindNode('logradouro'));
  cdsNFS.FieldByName('TMSNUM').AsString   := fRetornaValorTagXml(XmlNodetomador.ChildNodes.FindNode('numero_residencia'));
  cdsNFS.FieldByName('TMSCOMPL').AsString := fRetornaValorTagXml(XmlNodetomador.ChildNodes.FindNode('complemento'));
  cdsNFS.FieldByName('TMSBAIR').AsString  := fRetornaValorTagXml(XmlNodetomador.ChildNodes.FindNode('bairro'));
  cdsNFS.FieldByName('TMSMUN').AsString   := '';
  cdsNFS.FieldByName('TMSUF').AsString    := fRetornaValorTagXml(XmlNodetomador.ChildNodes.FindNode('estado'));
  cdsNFS.FieldByName('TMSCEP').AsString   := fRetornaValorTagXml(XmlNodetomador.ChildNodes.FindNode('cep'));
  cdsNFS.FieldByName('TMSFONE').AsString  := fRetornaValorTagXml(XmlNodetomador.ChildNodes.FindNode('fone_residencial'));
  cdsNFS.FieldByName('TMSEMAIL').AsString := fRetornaValorTagXml(XmlNodetomador.ChildNodes.FindNode('email'));

  cdsNFS.Post;

end;

{ TProvIPMVReforma }

class function TProvIPMVReforma.FindNode(const ANode: IXMLNode; const ANodeName: string): IXMLNode;
var
  I: Integer;
begin
  Result := nil;
  if ANode = nil then Exit;

  if SameText(ANode.NodeName, ANodeName) then
  begin
    Result := ANode;
    Exit;
  end;

  for I := 0 to ANode.ChildNodes.Count - 1 do
  begin
    Result := FindNode(ANode.ChildNodes[I], ANodeName);
    if Result <> nil then
      Exit;
  end;
end;

class procedure TProvIPMVReforma.pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet;
  strXML: string);
var
  XmlDoc : IXMLDocument;
  XmlNfse,
  XmlNodePrincipal,
  XmlNodeValoresNfse,
  XmlNodePrestador,
  XmlNodePrestadorEndereco,
  XmlNodePrestadorContato,
  XmlNodeTomador,
  XmlNodeTomadorEndereco,
  XmlNodeTomadorContato,
  XmlNodeTomadorIdentificador,
  XmlNodeInfDecPresServ,
  XmlNodeDecPresServRps,
  XmlNodeIBSCBSValores,
  XmlNodeIBSCBSValoresuf,
  XmlNodeIBSCBSValoresmun,
  XmlNodeIBSCBSValoresfed,
  XmlNodeIBSCBStotCIBS,
  XmlNodeIBSCBStotCIBSgTribCompraGov,
  XmlNodeIBSCBStotCIBSgIBS,
  XmlNodeIBSCBStotCIBSgCBS : IXMLNode;

begin

  xmlDoc := TXMLDocument.Create(Application);

  xmlDoc.LoadFromXML(strXML);
  xmlDoc.Active := True;

  XmlNfse := FindNode(XmlDoc.DocumentElement, 'Nfse');

  If Not Assigned(XmlNfse) Then
    Exit;

  XmlNodePrincipal            := XmlNfse.ChildNodes['InfNfse'];
  XmlNodeInfDecPresServ       := XmlNodePrincipal.ChildNodes['DeclaracaoPrestacaoServico']
                                                 .ChildNodes['InfDeclaracaoPrestacaoServico']
                                                 .ChildNodes['Servico'];
  XmlNodeValoresNfse          := XmlNodeInfDecPresServ.ChildNodes['Valores'];
  XmlNodeDecPresServRps       := XmlNodePrincipal.ChildNodes['DeclaracaoPrestacaoServico']
                                                 .ChildNodes['InfDeclaracaoPrestacaoServico']
                                                 .ChildNodes['Rps']
                                                 .ChildNodes['IdentificacaoRps'];
  XmlNodePrestador            := XmlNodePrincipal.ChildNodes['PrestadorServico'];
  XmlNodePrestadorEndereco    := XmlNodePrestador.ChildNodes['Endereco'];
  XmlNodePrestadorContato     := XmlNodePrestador.ChildNodes['Contato'];
  XmlNodeTomador              := XmlNodePrincipal.ChildNodes['DeclaracaoPrestacaoServico']
                                                 .ChildNodes['InfDeclaracaoPrestacaoServico']
                                                 .ChildNodes['TomadorServico'];
  XmlNodeTomadorEndereco      := XmlNodeTomador.ChildNodes['Endereco'];
  XmlNodeTomadorContato       := XmlNodeTomador.ChildNodes['Contato'];
  XmlNodeTomadorIdentificador := XmlNodeTomador.ChildNodes['IdentificacaoTomador']
                                               .ChildNodes['CpfCnpj'];
  XmlNodeIBSCBSValores        := XmlNodeInfDecPresServ.ChildNodes['IBSCBS']
                                                      .ChildNodes['valores'];
  XmlNodeIBSCBSValoresuf      := XmlNodeIBSCBSValores.ChildNodes['uf'];
  XmlNodeIBSCBSValoresmun     := XmlNodeIBSCBSValores.ChildNodes['mun'];
  XmlNodeIBSCBSValoresfed     := XmlNodeIBSCBSValores.ChildNodes['fed'];
  XmlNodeIBSCBStotCIBS        := XmlNodeInfDecPresServ.ChildNodes['IBSCBS']
                                                      .ChildNodes['totCIBS'];
  XmlNodeIBSCBStotCIBSgTribCompraGov := XmlNodeIBSCBStotCIBS.ChildNodes['gTribCompraGov'];
  XmlNodeIBSCBStotCIBSgIBS           := XmlNodeIBSCBStotCIBS.ChildNodes['gIBS'];
  XmlNodeIBSCBStotCIBSgCBS           := XmlNodeIBSCBStotCIBS.ChildNodes['gCBS'];

  cdsNFS.Append;
  // Dados da NFS
  cdsNFS.FieldByName('NUMNFS').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('Numero'));
  cdsNFS.FieldByName('SERIE').AsString  := '';
  cdsNFS.FieldByName('CODVER').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('CodigoVerificacao'));

  cdsNFS.FieldByName('DTAEMI').AsString := Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DataEmissao')),9,2)+'/'+
                                           Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DataEmissao')),6,2)+'/'+
                                           Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DataEmissao')),1,4);
  cdsNFS.FieldByName('DTAHRA').AsString := Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DataEmissao')),12,8);
  cdsNFS.FieldByName('NUMRPS').AsString := fRetornaValorTagXml(XmlNodeDecPresServRps.ChildNodes.FindNode('Numero'));
  cdsNFS.FieldByName('SERRPS').AsString := fRetornaValorTagXml(XmlNodeDecPresServRps.ChildNodes.FindNode('Serie'));
  cdsNFS.FieldByName('TPORPS').AsString := fRetornaValorTagXml(XmlNodeDecPresServRps.ChildNodes.FindNode('Tipo'));
  cdsNFS.FieldByName('EMIRPS').AsString := Copy(fRetornaValorTagXml(XmlNodeDecPresServRps.ChildNodes.FindNode('DataEmissao')),9,2)+'/'+
                                           Copy(fRetornaValorTagXml(XmlNodeDecPresServRps.ChildNodes.FindNode('DataEmissao')),6,2)+'/'+
                                           Copy(fRetornaValorTagXml(XmlNodeDecPresServRps.ChildNodes.FindNode('DataEmissao')),1,4);
  cdsNFS.FieldByName('NATOPE').AsString := '';
  cdsNFS.FieldByName('CODRET').AsString := '';
  cdsNFS.FieldByName('EMIOSN').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes.FindNode('OptanteSimplesNacional'));
  cdsNFS.FieldByName('EMIICC').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes.FindNode('IncentivoFiscal'));
  cdsNFS.FieldByName('COMPET').AsString := Copy(fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes.FindNode('Competencia')),9,2)+'/'+
                                           Copy(fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes.FindNode('Competencia')),6,2)+'/'+
                                           Copy(fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes.FindNode('Competencia')),1,4);
  cdsNFS.FieldByName('OUTINF').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('OutrasInformacoes'));
  cdsNFS.FieldByName('ORGMUN').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('CodigoMunicipio'));
  cdsNFS.FieldByName('ORG_UF').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('Uf'));
  cdsNFS.FieldByName('_LINK_').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('LinkAutenticidade'));

  //Valores
  cdsNFS.FieldByName('VLRSER').AsFloat   := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeValoresNfse.ChildNodes.FindNode('ValorServicos')),'.',','), 0);
  cdsNFS.FieldByName('ISS_RET').AsFloat  := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeValoresNfse.ChildNodes.FindNode('IssRetido')),'.',','), 0);
  cdsNFS.FieldByName('BSCISS').AsFloat   := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ValoresNfse'].ChildNodes['BaseCalculo']),'.',','), 0);
  cdsNFS.FieldByName('ALIISS').AsFloat   := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ValoresNfse'].ChildNodes['Aliquota']),'.',','), 0);
  cdsNFS.FieldByName('VLRISS').AsFloat   := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ValoresNfse'].ChildNodes['ValorIss']),'.',','), 0);
  cdsNFS.FieldByName('VLRLIQ').AsFloat   := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ValoresNfse'].ChildNodes['ValorLiquidoNfse']),'.',','), 0);
  cdsNFS.FieldByName('CODSER').AsString  := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes.FindNode('ItemListaServico'));
  cdsNFS.FieldByName('CDCNAE').AsString  := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes.FindNode('CodigoCnae'));
  cdsNFS.FieldByName('CODTRI').AsString  := '';
  cdsNFS.FieldByName('DISCRI').AsString  := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes.FindNode('Discriminacao'));
  cdsNFS.FieldByName('CODMUN').AsString  := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes.FindNode('CodigoMunicipio'));
  cdsNFS.FieldByName('ITEDESC').AsString := '';
  cdsNFS.FieldByName('ITEQTD').AsFloat   := 0;
  cdsNFS.FieldByName('ITEVLU').AsFloat   := 0;
  cdsNFS.FieldByName('DESCONI').AsFloat  := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeValoresNfse.ChildNodes.FindNode('DescontoIncondicionado')),'.',','), 0);
  cdsNFS.FieldByName('DESCONC').AsFloat  := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeValoresNfse.ChildNodes.FindNode('DescontoCondicionado')),'.',','), 0);
  cdsNFS.FieldByName('VLRDED').AsFloat   := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeValoresNfse.ChildNodes.FindNode('ValorDeducoes')),'.',','), 0);
  //Prestador
  cdsNFS.FieldByName('PSVCNPJ').AsString  := '';
  cdsNFS.FieldByName('PSVIM').AsString    := '';
  cdsNFS.FieldByName('PSVRAZAO').AsString := fRetornaValorTagXml(XmlNodePrestador.ChildNodes.FindNode('RazaoSocial'));
  cdsNFS.FieldByName('PSVFANT').AsString  := fRetornaValorTagXml(XmlNodePrestador.ChildNodes.FindNode('NomeFantasia'));
  cdsNFS.FieldByName('PSVEND').AsString   := fRetornaValorTagXml(XmlNodePrestadorEndereco.ChildNodes.FindNode('Endereco'));
  cdsNFS.FieldByName('PSVNUM').AsString   := fRetornaValorTagXml(XmlNodePrestadorEndereco.ChildNodes.FindNode('Numero'));
  cdsNFS.FieldByName('PSVCOMPL').AsString := fRetornaValorTagXml(XmlNodePrestadorEndereco.ChildNodes.FindNode('Complemento'));
  cdsNFS.FieldByName('PSVBAIR').AsString  := fRetornaValorTagXml(XmlNodePrestadorEndereco.ChildNodes.FindNode('Bairro'));
  cdsNFS.FieldByName('PSVMUN').AsString   := '';
  cdsNFS.FieldByName('PSVUF').AsString    := '';
  cdsNFS.FieldByName('PSVCEP').AsString   := fRetornaValorTagXml(XmlNodePrestadorEndereco.ChildNodes.FindNode('Cep'));
  cdsNFS.FieldByName('PSVFONE').AsString  := fRetornaValorTagXml(XmlNodePrestadorContato.ChildNodes.FindNode('Telefone'));
  cdsNFS.FieldByName('PSVEMAIL').AsString := fRetornaValorTagXml(XmlNodePrestadorContato.ChildNodes.FindNode('Email'));
  //Tomador
  cdsNFS.FieldByName('TMSCNPJ').AsString  := iif( fRetornaValorTagXml(XmlNodeTomadorIdentificador.ChildNodes.FindNode('Cpf')) = '',
                                                  fRetornaValorTagXml(XmlNodeTomadorIdentificador.ChildNodes.FindNode('Cnpj')),
                                                  fRetornaValorTagXml(XmlNodeTomadorIdentificador.ChildNodes.FindNode('Cpf')));
  cdsNFS.FieldByName('TMSIM').AsString    := '';
  cdsNFS.FieldByName('TMSRAZAO').AsString := fRetornaValorTagXml(XmlNodeTomador.ChildNodes.FindNode('RazaoSocial'));
  cdsNFS.FieldByName('TMSFANTA').AsString := '';
  cdsNFS.FieldByName('TMSEND').AsString   := fRetornaValorTagXml(XmlNodeTomadorEndereco.ChildNodes.FindNode('Endereco'));
  cdsNFS.FieldByName('TMSNUM').AsString   := fRetornaValorTagXml(XmlNodeTomadorEndereco.ChildNodes.FindNode('Numero'));
  cdsNFS.FieldByName('TMSCOMPL').AsString := fRetornaValorTagXml(XmlNodeTomadorEndereco.ChildNodes.FindNode('Complemento'));
  cdsNFS.FieldByName('TMSBAIR').AsString  := fRetornaValorTagXml(XmlNodeTomadorEndereco.ChildNodes.FindNode('Bairro'));
  cdsNFS.FieldByName('TMSMUN').AsString   := '';
  cdsNFS.FieldByName('TMSUF').AsString    := '';
  cdsNFS.FieldByName('TMSCEP').AsString   := fRetornaValorTagXml(XmlNodeTomadorEndereco.ChildNodes.FindNode('Cep'));
  cdsNFS.FieldByName('TMSFONE').AsString  := fRetornaValorTagXml(XmlNodeTomadorContato.ChildNodes.FindNode('Telefone'));
  cdsNFS.FieldByName('TMSEMAIL').AsString := fRetornaValorTagXml(XmlNodeTomadorContato.ChildNodes.FindNode('Email'));
  cdsNFS.FieldByName('CODNBS').AsString   := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes.FindNode('CodigoNbs'));

  cdsNFS.FieldByName('FINNFS').AsString   := 'NFS-e regular';
  cdsNFS.FieldByName('BC____').AsFloat    := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeIBSCBSValores.ChildNodes.FindNode('vBC')),'.',','), 0);

  cdsNFS.FieldByName('IBSUF_').AsFloat      := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeIBSCBSValoresuf.ChildNodes.FindNode('pIBSUF')),'.',','), 0);
  cdsNFS.FieldByName('RedAliqUF').AsFloat  := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeIBSCBSValoresuf.ChildNodes.FindNode('pRedAliqUF')),'.',','), 0);
  cdsNFS.FieldByName('AliqEfetUF').AsFloat := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeIBSCBSValoresuf.ChildNodes.FindNode('pAliqEfetUF')),'.',','), 0);

  cdsNFS.FieldByName('IBSMun').AsFloat      := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeIBSCBSValoresmun.ChildNodes.FindNode('pIBSMun')),'.',','), 0);
  cdsNFS.FieldByName('RedAliqMun').AsFloat  := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeIBSCBSValoresmun.ChildNodes.FindNode('pRedAliqMun')),'.',','), 0);
  cdsNFS.FieldByName('AliqEfetMun').AsFloat := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeIBSCBSValoresmun.ChildNodes.FindNode('pAliqEfetMun')),'.',','), 0);

  cdsNFS.FieldByName('CBS___').AsFloat      := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeIBSCBSValoresfed.ChildNodes.FindNode('pCBS')),'.',','), 0);
  cdsNFS.FieldByName('RedAliqCBS').AsFloat  := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeIBSCBSValoresfed.ChildNodes.FindNode('pRedAliqCBS')),'.',','), 0);
  cdsNFS.FieldByName('AliqEfetCBS').AsFloat := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeIBSCBSValoresfed.ChildNodes.FindNode('pAliqEfetCBS')),'.',','), 0);

  cdsNFS.FieldByName('TotNF_').AsFloat                 := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeIBSCBStotCIBS.ChildNodes.FindNode('vTotNF')),'.',','), 0);
  cdsNFS.FieldByName('gTribCompraGov_pIBSUF').AsFloat  := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeIBSCBStotCIBSgTribCompraGov.ChildNodes.FindNode('pIBSUF')),'.',','), 0);
  cdsNFS.FieldByName('gTribCompraGov_vIBSUF').AsFloat  := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeIBSCBStotCIBSgTribCompraGov.ChildNodes.FindNode('vIBSUF')),'.',','), 0);
  cdsNFS.FieldByName('gTribCompraGov_pIBSMun').AsFloat := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeIBSCBStotCIBSgTribCompraGov.ChildNodes.FindNode('pIBSMun')),'.',','), 0);
  cdsNFS.FieldByName('gTribCompraGov_vIBSMun').AsFloat := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeIBSCBStotCIBSgTribCompraGov.ChildNodes.FindNode('vIBSMun')),'.',','), 0);
  cdsNFS.FieldByName('gTribCompraGov_pCBS').AsFloat    := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeIBSCBStotCIBSgTribCompraGov.ChildNodes.FindNode('pCBS')),'.',','), 0);
  cdsNFS.FieldByName('gTribCompraGov_vCBS').AsFloat    := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeIBSCBStotCIBSgTribCompraGov.ChildNodes.FindNode('vCBS')),'.',','), 0);

  cdsNFS.FieldByName('IBSTot').AsFloat            := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeIBSCBStotCIBSgIBS.ChildNodes.FindNode('vIBSTot')),'.',','), 0);
  cdsNFS.FieldByName('gIBS_pCredPresIBS').AsFloat := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeIBSCBStotCIBSgIBS.ChildNodes.FindNode('pCredPresIBS')),'.',','), 0);
  cdsNFS.FieldByName('gIBS_vCredPresIBS').AsFloat := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeIBSCBStotCIBSgIBS.ChildNodes.FindNode('vCredPresIBS')),'.',','), 0);
  cdsNFS.FieldByName('gIBS_vDifUF').AsFloat       := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeIBSCBStotCIBSgIBS.ChildNodes.FindNode('vDifUF')),'.',','), 0);
  cdsNFS.FieldByName('gIBS_vIBSUF').AsFloat       := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeIBSCBStotCIBSgIBS.ChildNodes.FindNode('vIBSUF')),'.',','), 0);
  cdsNFS.FieldByName('gIBS_vDifMun').AsFloat      := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeIBSCBStotCIBSgIBS.ChildNodes.FindNode('vDifMun')),'.',','), 0);
  cdsNFS.FieldByName('gIBS_vIBSMun').AsFloat      := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeIBSCBStotCIBSgIBS.ChildNodes.FindNode('vIBSMun')),'.',','), 0);

  cdsNFS.FieldByName('gCBS_pCredPresCBS').AsFloat := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeIBSCBStotCIBSgCBS.ChildNodes.FindNode('pCredPresCBS')),'.',','), 0);
  cdsNFS.FieldByName('gCBS_vCredPresCBS').AsFloat := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeIBSCBStotCIBSgCBS.ChildNodes.FindNode('vCredPresCBS')),'.',','), 0);
  cdsNFS.FieldByName('gCBS_vDifCBS').AsFloat      := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeIBSCBStotCIBSgCBS.ChildNodes.FindNode('vDifCBS')),'.',','), 0);
  cdsNFS.FieldByName('gCBS_vCBS').AsFloat         := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeIBSCBStotCIBSgCBS.ChildNodes.FindNode('vCBS')),'.',','), 0);
  cdsNFS.FieldByName('ChaveNFSeNacional').AsString := Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('OutrasInformacoes')), Length(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('OutrasInformacoes')))-49, 50);

  cdsNFS.Post;

end;

end.
