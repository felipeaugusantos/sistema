unit untProvIssNet;

interface

uses
{$IF Defined(LINUX)}
  untUniClientDataSet, Uni,
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
  TProvIssNet = class
    public
      class procedure pRetDadosVeiculo(var cdsNFS: TUniClientDataSet; strNumDoc, strCodEmp, strEspDoc: string);
      class procedure pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string; strNumDoc, strCodEmp, strEspDoc: string);
  end;
implementation

{ TProvIssNet }

class procedure TProvIssNet.pRetDadosVeiculo(var cdsNFS: TUniClientDataSet; strNumDoc, strCodEmp, strEspDoc: string);
var
  qryVeiculo: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryVeiculo := fCriaQuery;

  try
    qryVeiculo.Close;
    qryVeiculo.SQL.Clear;
    qryVeiculo.SQL.Add('SELECT                                                      ');
    qryVeiculo.SQL.Add('  CADVEI.VEI_PLAVEI AS PLAVEI,                              ');
    qryVeiculo.SQL.Add('  CADVEI.VEI_DESVEI AS DESVEI,                              ');
    qryVeiculo.SQL.Add('  CADVEI.VEI_KMATUA AS KM_VEI,                              ');
    qryVeiculo.SQL.Add('  MARVEI.MAR_DESMAR AS DESMAR,                              ');
    qryVeiculo.SQL.Add('  MODVEI.MOD_DESMOD AS DESMOD,                              ');
    qryVeiculo.SQL.Add('  CADVEI.VEI_ANOVEI AS ANOVEI,                              ');
    qryVeiculo.SQL.Add('  CORVEI.COR_DESCOR AS DESCOR,                              ');
    qryVeiculo.SQL.Add('  CADVEI.VEI_NUMVEI AS NUMVEI                               ');
    qryVeiculo.SQL.Add('FROM MOVDET                                                 ');
    qryVeiculo.SQL.Add('  LEFT JOIN FATDOR ON DET_NUM_PD = FDO_NUMDOC               ');
    qryVeiculo.SQL.Add('                  AND DET_ESP_PD = FDO_ESPDOC               ');
    qryVeiculo.SQL.Add('                  AND DET_EMP_PD = FDO_CODEMP               ');
    qryVeiculo.SQL.Add('                  AND DET_CODITE = FDO_CODITE               ');
    qryVeiculo.SQL.Add('                  AND DET_IND_PD = FDO_SEQIND               ');
    qryVeiculo.SQL.Add('  LEFT JOIN FATGOR ON FDO_SEQGER = FATGOR.AUTOINCREM        ');
    qryVeiculo.SQL.Add('  LEFT JOIN EXTGOR ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ');
    qryVeiculo.SQL.Add('  LEFT JOIN CADVEI ON EXTGOR.FGO_PLAVEI = CADVEI.VEI_PLAVEI ');
    qryVeiculo.SQL.Add('  LEFT JOIN MODVEI ON CADVEI.VEI_CODMOD = MODVEI.MOD_CODMOD ');
    qryVeiculo.SQL.Add('  LEFT JOIN CORVEI ON CADVEI.VEI_CODCOR = CORVEI.COR_CODCOR ');
    qryVeiculo.SQL.Add('  LEFT JOIN MARVEI ON CADVEI.VEI_CODMAR = MARVEI.MAR_CODMAR ');
    qryVeiculo.SQL.Add('WHERE TRUE                                                  ');
    qryVeiculo.SQL.Add('  AND DET_NUMDOC = :NUMDOC                                  ');
    qryVeiculo.SQL.Add('  AND DET_ESPDOC = :ESPDOC                                  ');
    qryVeiculo.SQL.Add('  AND DET_CODEMP = :CODEMP                                  ');
    qryVeiculo.SQL.Add('  LIMIT 1;                                                  ');

    qryVeiculo.ParamByName('CODEMP').AsString := strCodEmp;
    qryVeiculo.ParamByName('ESPDOC').AsString := strEspDoc;
    qryVeiculo.ParamByName('NUMDOC').AsString := Format('%.12d', [StrToIntDef(strNumDoc, 0)]);

    qryVeiculo.Open;

    if (not qryVeiculo.IsEmpty) then
    begin
      cdsNFS.FieldByName('PLAVEI').AsString  := qryVeiculo.FieldByName('PLAVEI').AsString;
      cdsNFS.FieldByName('DESVEI').AsString  := qryVeiculo.FieldByName('DESVEI').AsString;
      cdsNFS.FieldByName('KM_VEI').AsInteger := qryVeiculo.FieldByName('KM_VEI').AsInteger;
      cdsNFS.FieldByName('DESMAR').AsString  := qryVeiculo.FieldByName('DESMAR').AsString;
      cdsNFS.FieldByName('DESMOD').AsString  := qryVeiculo.FieldByName('DESMOD').AsString;
      cdsNFS.FieldByName('ANOVEI').AsString  := qryVeiculo.FieldByName('ANOVEI').AsString;
      cdsNFS.FieldByName('DESCOR').AsString  := qryVeiculo.FieldByName('DESCOR').AsString;
      cdsNFS.FieldByName('NUMVEI').AsString  := qryVeiculo.FieldByName('NUMVEI').AsString;
    end;
  finally
    FreeAndNil(qryVeiculo);
  end;
end;

class procedure TProvIssNet.pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet;
  strXML: string; strNumDoc, strCodEmp, strEspDoc: string);
var
  XmlDoc : IXMLDocument;

  XmlNodePrincipal,
  XmlNodeInfDecPresServ,
  XmlNodeInfDecPresServServ,
  XmlNodeDecPresServValServ: IXMLNode;

  fltTgVlNfsIss,
  fltTgVlNfsAli: Double;
begin
  xmlDoc := TXMLDocument.Create(Application);

  xmlDoc.LoadFromXML(strXML);
  xmlDoc.Active := True;

  XmlNodePrincipal := XmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'];

  XmlNodeInfDecPresServ := XmlNodePrincipal.ChildNodes['DeclaracaoPrestacaoServico']
                                           .ChildNodes['InfDeclaracaoPrestacaoServico'];

  XmlNodeInfDecPresServServ := XmlNodeInfDecPresServ.ChildNodes['Servico'];
  XmlNodeDecPresServValServ := XmlNodeInfDecPresServServ.ChildNodes['Valores'];

  cdsNFS.Append;
  // Dados da NFS
  cdsNFS.FieldByName('NUMNFS').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('Numero'));
  cdsNFS.FieldByName('CODVER').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('CodigoVerificacao'));
  cdsNFS.FieldByName('DTAHRA').AsString := Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DataEmissao')), 12, 8);
  cdsNFS.FieldByName('DTAEMI').AsString := Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DataEmissao')),9,2)+'/'+
                                           Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DataEmissao')),6,2)+'/'+
                                           Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DataEmissao')),1,4);

  cdsNFS.FieldByName('EMIOSN').AsString   := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['OptanteSimplesNacional']);
  cdsNFS.FieldByName('RESPTRIB').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['RegimeEspecialTributacao']);
  cdsNFS.FieldByName('EMIICC').AsString   := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['IncentivoFiscal']);
  cdsNFS.FieldByName('COMPET').AsString   := Copy(fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes.FindNode('Competencia')),9,2)+'/'+
                                             Copy(fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes.FindNode('Competencia')),6,2)+'/'+
                                             Copy(fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes.FindNode('Competencia')),1,4);

  cdsNFS.FieldByName('OUTINF').AsString   := StringReplace(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['OutrasInformacoes']), '\s\n', ' |', [rfReplaceAll]);
  cdsNFS.FieldByName('ORGMUN').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['OrgaoGerador'].ChildNodes['CodigoMunicipio']);
  cdsNFS.FieldByName('ORG_UF').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['OrgaoGerador'].ChildNodes['Uf']);

  //RPS
  cdsNFS.FieldByName('NUMRPS').AsString   := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Numero']);
  cdsNFS.FieldByName('SERRPS').AsString   := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Serie']);
  cdsNFS.FieldByName('TPORPS').AsString   := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Tipo']);
  cdsNFS.FieldByName('EMIRPS').AsString   := Copy(fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Rps'].ChildNodes['DataEmissao']),9,2)+'/'+
                                             Copy(fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Rps'].ChildNodes['DataEmissao']),6,2)+'/'+
                                             Copy(fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Rps'].ChildNodes['DataEmissao']),1,4);

  //Valores
  cdsNFS.FieldByName('BSCISS').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ValoresNfse'].ChildNodes['BaseCalculo']));
  cdsNFS.FieldByName('VLRLIQ').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ValoresNfse'].ChildNodes['ValorLiquidoNfse']));
  cdsNFS.FieldByName('VLRDED').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodeDecPresServValServ.ChildNodes['ValorDeducoes']));

  //Valores Serviço
  cdsNFS.FieldByName('VALINS').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodeDecPresServValServ.ChildNodes['ValorInss']));
  cdsNFS.FieldByName('VLRSER').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodeDecPresServValServ.ChildNodes['ValorServicos']));
  cdsNFS.FieldByName('ISS_RET').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServServ.ChildNodes['IssRetido']);
  cdsNFS.FieldByName('DESCONC').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodeInfDecPresServServ.ChildNodes['DescontoCondicionado']));
  cdsNFS.FieldByName('DESCONI').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodeInfDecPresServServ.ChildNodes['DescontoIncondicionado']));
  cdsNFS.FieldByName('VALPIS').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodeDecPresServValServ.ChildNodes['ValorPis']));
  cdsNFS.FieldByName('VALCOF').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodeDecPresServValServ.ChildNodes['ValorCofins']));
  cdsNFS.FieldByName('VALIRR').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodeDecPresServValServ.ChildNodes['ValorIr']));
  cdsNFS.FieldByName('VALCSL').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodeDecPresServValServ.ChildNodes['ValorCsll']));
  cdsNFS.FieldByName('OUT_RET').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodeDecPresServValServ.ChildNodes['OutrasRetencoes']));

  fltTgVlNfsIss := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ValoresNfse'].ChildNodes['ValorIss']));
  fltTgVlNfsAli := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ValoresNfse'].ChildNodes['Aliquota']));
  cdsNFS.FieldByName('VLRISS').AsFloat   := IIF(fltTgVlNfsIss = 00.00,
                                               fStrToFloatDef(fRetornaValorTagXml(XmlNodeDecPresServValServ.ChildNodes['ValorIss'])),
                                               fltTgVlNfsIss);

  cdsNFS.FieldByName('ALIISS').AsFloat   := IIF(fltTgVlNfsAli = 00.00,
                                               fStrToFloatDef(fRetornaValorTagXml(XmlNodeDecPresServValServ.ChildNodes['Aliquota'])),
                                               fltTgVlNfsAli);
  //Informações de Serviço
  cdsNFS.FieldByName('CODTRI').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServServ.ChildNodes['CodigoTributacaoMunicipio']);
  cdsNFS.FieldByName('DESSER').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['DescricaoCodigoTributacaoMunicípio']);

  cdsNFS.FieldByName('CODNBS').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServServ.ChildNodes['CodigoNbs']);
  cdsNFS.FieldByName('CDCNAE').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServServ.ChildNodes['CodigoCnae']);
  cdsNFS.FieldByName('CODSER').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServServ.ChildNodes['ItemListaServico']);
  cdsNFS.FieldByName('DISCRI').AsString := StringReplace(fRetornaValorTagXml(XmlNodeInfDecPresServServ.ChildNodes['Discriminacao']), '\s\n', ' |', [rfReplaceAll]);
  cdsNFS.FieldByName('CODMUN').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServServ.ChildNodes['CodigoMunicipio']);
  cdsNFS.FieldByName('EXIISS').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServServ.ChildNodes['ExigibilidadeISS']);
  cdsNFS.FieldByName('MUNINC').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServServ.ChildNodes['MunicipioIncidencia']);


  //Prestador
  cdsNFS.FieldByName('PSVCNPJ').AsString  := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Prestador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj']);
  cdsNFS.FieldByName('PSVIM').AsString    := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Prestador'].ChildNodes['InscricaoMunicipal']);
  cdsNFS.FieldByName('PSVRAZAO').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['RazaoSocial']);
  cdsNFS.FieldByName('PSVFANT').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['NomeFantasia']);
  cdsNFS.FieldByName('PSVEND').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Endereco']);
  cdsNFS.FieldByName('PSVNUM').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Numero']);
  cdsNFS.FieldByName('PSVCOMPL').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Complemento']);
  cdsNFS.FieldByName('PSVBAIR').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Bairro']);
  cdsNFS.FieldByName('PSVMUN').AsString   := '';
  cdsNFS.FieldByName('PSVUF').AsString    := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Uf']);
  cdsNFS.FieldByName('PSVCEP').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Cep']);
  cdsNFS.FieldByName('PSVFONE').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Telefone']);
  cdsNFS.FieldByName('PSVEMAIL').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Email']);

  //Tomador
  cdsNFS.FieldByName('TMSCNPJ').AsString := IIF(fEmptyStr(fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'])),
                                                          fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cpf']),
                                                          fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj']));

  cdsNFS.FieldByName('TMSIM').AsString   := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['InscricaoMunicipal']);

  cdsNFS.FieldByName('TMSRAZAO').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['TomadorServico'].ChildNodes['RazaoSocial']);
  cdsNFS.FieldByName('TMSFANTA').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['TomadorServico'].ChildNodes['NomeFantasia']);
  cdsNFS.FieldByName('TMSEND').AsString   := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Endereco']);
  cdsNFS.FieldByName('TMSNUM').AsString   := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Numero']);
  cdsNFS.FieldByName('TMSCOMPL').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Complemento']);
  cdsNFS.FieldByName('TMSBAIR').AsString  := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Bairro']);
  cdsNFS.FieldByName('TMSMUN').AsString   := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio']);
  cdsNFS.FieldByName('TMSUF').AsString    := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Uf']);
  cdsNFS.FieldByName('TMSCEP').AsString   := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Cep']);
  cdsNFS.FieldByName('TMSFONE').AsString  := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['TomadorServico'].ChildNodes['Contato'].ChildNodes['Telefone']);
  cdsNFS.FieldByName('TMSEMAIL').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['TomadorServico'].ChildNodes['Contato'].ChildNodes['Email']);

  pRetDadosVeiculo(cdsNFS, strNumDoc, strCodEmp, strEspDoc);

  cdsNFS.Post;
end;
end.
