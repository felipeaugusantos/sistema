unit untProvMemory;

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
  TProvMemory = class
    public
      class procedure pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string);
  end;
implementation

{ TProvMemory }

class procedure TProvMemory.pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet;
  strXML: string);

  function fTrataXml(strXML: String): String;
  begin
    Result := ReplaceStr(strXML, '>n', '>');
    Result := Trim(Result);
  End;

var
  XmlDoc : IXMLDocument;

  XmlNodePrincipal,
  XmlNodeServico,
  XmlNodeValores,
  XmlNodePrestador,
  XmlNodeIdtPrestador,
  XmlNodeCttPrestador,
  XmlNodeEndPrestador,
  XmlNodeTomador,
  XmlNodeIdtTomador,
  XmlNodeCttTomador,
  XmlNodeEndTomador : IXMLNode;

begin
  xmlDoc := TXMLDocument.Create(Application);

  xmlDoc.LoadFromXML(fTrataXml(strXML));
  xmlDoc.Active := True;

  XmlNodePrincipal    := XmlDoc.ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'];
  XmlNodeServico      := XmlNodePrincipal.ChildNodes['Servico'];
  XmlNodeValores      := XmlNodeServico.ChildNodes['Valores'];
  XmlNodePrestador    := XmlNodePrincipal.ChildNodes['PrestadorServico'];
  XmlNodeIdtPrestador := XmlNodePrestador.ChildNodes['IdentificacaoPrestador'];
  XmlNodeCttPrestador := XmlNodePrestador.ChildNodes['Contato'];
  XmlNodeEndPrestador := XmlNodePrestador.ChildNodes['Endereco'];
  XmlNodeTomador      := XmlNodePrincipal.ChildNodes['TomadorServico'];
  XmlNodeIdtTomador   := XmlNodeTomador.ChildNodes['IdentificacaoTomador'];
  XmlNodeCttTomador   := XmlNodeTomador.ChildNodes['Contato'];
  XmlNodeEndTomador   := XmlNodeTomador.ChildNodes['Endereco'];

  cdsNFS.Append;
  // Dados da NFS
  cdsNFS.FieldByName('NUMNFS').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('Numero'));
  cdsNFS.FieldByName('CODVER').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('CodigoVerificacao'));
  cdsNFS.FieldByName('DTAHRA').AsString := Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DataEmissao')),12,8);
  cdsNFS.FieldByName('DTAEMI').AsString := Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DataEmissao')),1,10);

  cdsNFS.FieldByName('NUMRPS').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('NumeroRps'));
  cdsNFS.FieldByName('SERRPS').AsString := '';
  if Assigned(XmlNodePrincipal.ChildNodes.FindNode('DataEmissaoRps')) then
    cdsNFS.FieldByName('EMIRPS').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DataEmissaoRps'));

  cdsNFS.FieldByName('EMIOSN').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('OptanteSimplesNacional'));
  cdsNFS.FieldByName('RESPTRIB').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('OptanteSimplesNacional'));
  cdsNFS.FieldByName('EMIICC').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('IncentivadorCultural'));
  cdsNFS.FieldByName('COMPET').AsString   := Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('Competencia')),1,4)+'/'+
                                             Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('Competencia')),5,1);

  cdsNFS.FieldByName('ORGMUN').AsString   := '';
  cdsNFS.FieldByName('ORG_UF').AsString   := '';
  cdsNFS.FieldByName('SITUAC').AsString   := '';
  cdsNFS.FieldByName('_LINK_').AsString   := '';

  //Valores
  cdsNFS.FieldByName('BSCISS').AsFloat  := fStrToFloatDef(StringReplace(fRetornaValorTagXml(XmlNodeValores.ChildNodes.FindNode('BaseCalculo')),'R$','', [rfReplaceAll]));
  cdsNFS.FieldByName('VLRLIQ').AsFloat  := fStrToFloatDef(StringReplace(fRetornaValorTagXml(XmlNodeValores.ChildNodes.FindNode('ValorLiquidoNFSe')),'R$','', [rfReplaceAll]));
  cdsNFS.FieldByName('VLRDED').AsFloat  := fStrToFloatDef(StringReplace(fRetornaValorTagXml(XmlNodeValores.ChildNodes.FindNode('ValorDeducoes')),'R$','', [rfReplaceAll]));
  cdsNFS.FieldByName('VLRCRE').AsFloat  := 0;

  //Valores Serviço
  cdsNFS.FieldByName('VALINS').AsFloat   := fStrToFloatDef(StringReplace(fRetornaValorTagXml(XmlNodeValores.ChildNodes.FindNode('ValorINSS')),'R$','', [rfReplaceAll]));
  cdsNFS.FieldByName('VLRSER').AsFloat   := fStrToFloatDef(StringReplace(fRetornaValorTagXml(XmlNodeValores.ChildNodes.FindNode('ValorServicos')),'R$','', [rfReplaceAll]));
  cdsNFS.FieldByName('ISS_RET').AsString := fRetornaValorTagXml(XmlNodeValores.ChildNodes.FindNode('ISSRetido'));
  cdsNFS.FieldByName('DESCONC').AsFloat  := fStrToFloatDef(StringReplace(fRetornaValorTagXml(XmlNodeValores.ChildNodes.FindNode('ValorDescontoCondicionado')),'R$','', [rfReplaceAll]));
  cdsNFS.FieldByName('DESCONI').AsFloat  := fStrToFloatDef(StringReplace(fRetornaValorTagXml(XmlNodeValores.ChildNodes.FindNode('ValorDescontoIncondicionado')),'R$','', [rfReplaceAll]));
  cdsNFS.FieldByName('VALPIS').AsFloat   := fStrToFloatDef(StringReplace(fRetornaValorTagXml(XmlNodeValores.ChildNodes.FindNode('ValorPIS')),'R$','', [rfReplaceAll]));
  cdsNFS.FieldByName('VALCOF').AsFloat   := fStrToFloatDef(StringReplace(fRetornaValorTagXml(XmlNodeValores.ChildNodes.FindNode('ValorCOFINS')),'R$','', [rfReplaceAll]));
  cdsNFS.FieldByName('VALIRR').AsFloat   := fStrToFloatDef(StringReplace(fRetornaValorTagXml(XmlNodeValores.ChildNodes.FindNode('ValorIR')),'R$','', [rfReplaceAll]));
  cdsNFS.FieldByName('VALCSL').AsFloat   := fStrToFloatDef(StringReplace(fRetornaValorTagXml(XmlNodeValores.ChildNodes.FindNode('ValorCSLL')),'R$','', [rfReplaceAll]));
  cdsNFS.FieldByName('OUT_RET').AsFloat  := fStrToFloatDef(StringReplace(fRetornaValorTagXml(XmlNodeValores.ChildNodes.FindNode('OutrasRetencoes')),'R$','', [rfReplaceAll]));
  cdsNFS.FieldByName('VLRISS').AsFloat   := fStrToFloatDef(StringReplace(fRetornaValorTagXml(XmlNodeValores.ChildNodes.FindNode('ValorISS')),'R$','', [rfReplaceAll]));
  cdsNFS.FieldByName('ALIISS').AsFloat   := fStrToFloatDef(StringReplace(fRetornaValorTagXml(XmlNodeValores.ChildNodes.FindNode('AliquotaServicos')),'R$','', [rfReplaceAll]));

  //Informações de Serviço
  cdsNFS.FieldByName('CODSER').AsString := fRetornaValorTagXml(XmlNodeServico.ChildNodes.FindNode('CodigoTributacaoMunicipio'));
  cdsNFS.FieldByName('DESSER').AsString := fRetDescClassificacaoServico(fRetornaValorTagXml(XmlNodeServico.ChildNodes.FindNode('CodigoTributacaoMunicipio')));

  cdsNFS.FieldByName('CDCNAE').AsString := fRetornaValorTagXml(XmlNodeServico.ChildNodes.FindNode('CodigoCNAE'));
  cdsNFS.FieldByName('CODTRI').AsString := '';
  cdsNFS.FieldByName('DISCRI').AsString := fRetornaValorTagXml(XmlNodeServico.ChildNodes.FindNode('Discriminacao'));
  cdsNFS.FieldByName('MUNPRE').AsString := fRetornaValorTagXml(XmlNodeServico.ChildNodes.FindNode('MunicipioPrestacaoServico'))+'-'+
                                           fRetornaValorTagXml(XmlNodeServico.ChildNodes.FindNode('DescricaoMunicipio'))+'-'+
                                           fRetornaValorTagXml(XmlNodeServico.ChildNodes.FindNode('UfMunicipio'));
  cdsNFS.FieldByName('EXIISS').AsString := '';
  cdsNFS.FieldByName('MUNINC').AsString := '';

  //Prestador
  cdsNFS.FieldByName('PSVCNPJ').AsString  := fRetornaValorTagXml(XmlNodeIdtPrestador.ChildNodes.FindNode('CNPJ'));
  cdsNFS.FieldByName('PSVDOC_').AsString  := fRetornaValorTagXml(XmlNodeIdtPrestador.ChildNodes.FindNode('CNPJ'));
  cdsNFS.FieldByName('PSVIM').AsString    := fRetornaValorTagXml(XmlNodeIdtPrestador.ChildNodes.FindNode('InscricaoMunicipal'));
  cdsNFS.FieldByName('PSVRAZAO').AsString := fRetornaValorTagXml(XmlNodePrestador.ChildNodes.FindNode('RazaoSocial'));
  cdsNFS.FieldByName('PSVFANT').AsString  := fRetornaValorTagXml(XmlNodePrestador.ChildNodes.FindNode('NomeFantasia'));
  cdsNFS.FieldByName('PSVEND').AsString   := fRetornaValorTagXml(XmlNodeEndPrestador.ChildNodes.FindNode('Endereco'));
  cdsNFS.FieldByName('PSVNUM').AsString   := fRetornaValorTagXml(XmlNodeEndPrestador.ChildNodes.FindNode('Numero'));
  cdsNFS.FieldByName('PSVCOMPL').AsString := fRetornaValorTagXml(XmlNodeEndPrestador.ChildNodes.FindNode('Complemento'));
  cdsNFS.FieldByName('PSVBAIR').AsString  := fRetornaValorTagXml(XmlNodeEndPrestador.ChildNodes.FindNode('Bairro'));
  cdsNFS.FieldByName('PSVMUN').AsString   := fRetornaValorTagXml(XmlNodeEndPrestador.ChildNodes.FindNode('DescricaoMunicipio'));
  cdsNFS.FieldByName('PSVUF').AsString    := fRetornaValorTagXml(XmlNodeEndPrestador.ChildNodes.FindNode('Uf'));
  cdsNFS.FieldByName('PSVCEP').AsString   := fRetornaValorTagXml(XmlNodeEndPrestador.ChildNodes.FindNode('Cep'));
  cdsNFS.FieldByName('PSVFONE').AsString  := fRetornaValorTagXml(XmlNodeCttPrestador.ChildNodes.FindNode('Telefone'));
  cdsNFS.FieldByName('PSVEMAIL').AsString := fRetornaValorTagXml(XmlNodeCttPrestador.ChildNodes.FindNode('Email'));

  //Tomador
  cdsNFS.FieldByName('TMSCNPJ').AsString  := fRetornaValorTagXml(XmlNodeIdtTomador.ChildNodes.FindNode('CpfCnpj'));
  cdsNFS.FieldByName('TMSIM').AsString    := fRetornaValorTagXml(XmlNodeIdtTomador.ChildNodes.FindNode('InscricaoMunicipal'));
  cdsNFS.FieldByName('TMSIE').AsString    := fRetornaValorTagXml(XmlNodeIdtTomador.ChildNodes.FindNode('InscricaoEstadual'));
  cdsNFS.FieldByName('TMSRAZAO').AsString := fRetornaValorTagXml(XmlNodeTomador.ChildNodes.FindNode('RazaoSocial'));
  cdsNFS.FieldByName('TMSFANTA').AsString := fRetornaValorTagXml(XmlNodeTomador.ChildNodes.FindNode('RazaoSocial'));
  cdsNFS.FieldByName('TMSEND').AsString   := fRetornaValorTagXml(XmlNodeEndTomador.ChildNodes.FindNode('Endereco'));
  cdsNFS.FieldByName('TMSNUM').AsString   := fRetornaValorTagXml(XmlNodeEndTomador.ChildNodes.FindNode('Numero'));
  cdsNFS.FieldByName('TMSCOMPL').AsString := fRetornaValorTagXml(XmlNodeEndTomador.ChildNodes.FindNode('Complemento'));
  cdsNFS.FieldByName('TMSBAIR').AsString  := fRetornaValorTagXml(XmlNodeEndTomador.ChildNodes.FindNode('Bairro'));
  cdsNFS.FieldByName('TMSMUN').AsString   := fRetornaValorTagXml(XmlNodeEndTomador.ChildNodes.FindNode('DescricaoMunicipio'));
  cdsNFS.FieldByName('TMSUF').AsString    := fRetornaValorTagXml(XmlNodeEndTomador.ChildNodes.FindNode('Uf'));
  cdsNFS.FieldByName('TMSCEP').AsString   := fRetornaValorTagXml(XmlNodeEndTomador.ChildNodes.FindNode('Cep'));
  cdsNFS.FieldByName('TMSFONE').AsString  := fRetornaValorTagXml(XmlNodeCttTomador.ChildNodes.FindNode('Telefone'));
  cdsNFS.FieldByName('TMSEMAIL').AsString := fRetornaValorTagXml(XmlNodeCttTomador.ChildNodes.FindNode('Email'));

  cdsNFS.Post;

end;

end.
