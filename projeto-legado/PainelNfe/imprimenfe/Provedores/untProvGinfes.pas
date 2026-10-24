unit untProvGinfes;

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
  TProvGinfes = class
    private
    public
      class procedure pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string);
  end;

type
  TProvGinfesV4 = class
    private
    public
      class procedure pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string; strCidNfse: string = '');
  end;

type
  TProvGinfesReforma = class
    private
    public
      class procedure pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string; strCidNfse: string = '');
  end;

implementation

{ TProvGinfes }

class procedure TProvGinfes.pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet;
  strXML: string);
var
  NoInfNfse   : IXMLDocument;
  NoPrincipal : IXMLNode;
  NoTcIBSCBSTotal : IXMLNode;

begin
  NoInfNfse := TXMLDocument.Create(Application);

  NoInfNfse.LoadFromXML(strXML);
  NoInfNfse.Active := True;
  NoPrincipal := NoInfNfse.ChildNodes['NFSE']
                          .ChildNodes['Nfse'];
  NoTcIBSCBSTotal := NoInfNfse.ChildNodes['NFSE']
                              .ChildNodes['TcIBSCBSTotal'];
  cdsNFS.Append;

  try
    //DADOS DA NOTA FISCAO DE SERVIÇO ELETRÔNICA E RPS

    cdsNFS.FieldByName('NUMNFS').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes['IdentificacaoNfse'].ChildNodes['ns3:Numero']);
    cdsNFS.FieldByName('CODVER').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes['IdentificacaoNfse'].ChildNodes['ns3:CodigoVerificacao']);
    cdsNFS.FieldByName('DTAHRA').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:DataEmissao']);
    cdsNFS.FieldByName('DTAEMI').AsString := Copy(fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:DataEmissao']),9,2)+'/'+
                                             Copy(fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:DataEmissao']),6,2)+'/'+
                                             Copy(fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:DataEmissao']),1,4);

    cdsNFS.FieldByName('NUMRPS').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:IdentificacaoRps'].ChildNodes['ns3:Numero']);
    cdsNFS.FieldByName('SERRPS').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:IdentificacaoRps'].ChildNodes['ns3:Serie']);
    cdsNFS.FieldByName('TPORPS').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:IdentificacaoRps'].ChildNodes['ns3:Tipo']);

    cdsNFS.FieldByName('EMIRPS').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:DataEmissaoRps']);
    cdsNFS.FieldByName('NATOPE').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:NaturezaOperacao']);
    cdsNFS.FieldByName('CODRET').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:RegimeEspecialTributacao']);
    cdsNFS.FieldByName('EMIOSN').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:OptanteSimplesNacional']);
    cdsNFS.FieldByName('EMIICC').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:IncetivadorCultural']);
    cdsNFS.FieldByName('COMPET').AsString := Copy(fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:Competencia']),1,10);

    //SERVIÇOS

    cdsNFS.FieldByName('VLRSER').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:Servico'].ChildNodes['ns3:Valores'].ChildNodes['ns3:ValorServicos']));
    cdsNFS.FieldByName('ISS_RET').AsFloat := fStrToFloatDef(fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:Servico'].ChildNodes['ns3:Valores'].ChildNodes['ns3:IssRetido']));
    cdsNFS.FieldByName('VLRISS').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:Servico'].ChildNodes['ns3:Valores'].ChildNodes['ns3:ValorIss']));
    cdsNFS.FieldByName('BSCISS').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:Servico'].ChildNodes['ns3:Valores'].ChildNodes['ns3:BaseCalculo']));
    cdsNFS.FieldByName('ALIISS').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:Servico'].ChildNodes['ns3:Valores'].ChildNodes['ns3:Aliquota']))*100;
    cdsNFS.FieldByName('VLISSR').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:Servico'].ChildNodes['ns3:Valores'].ChildNodes['ns3:ValorIssRetido']));

    cdsNFS.FieldByName('VALPIS').AsFloat := fStrToFloatDef(fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:Servico'].ChildNodes['ns3:Valores'].ChildNodes['ns3:ValorPis']));
    cdsNFS.FieldByName('VALCOF').AsFloat := fStrToFloatDef(fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:Servico'].ChildNodes['ns3:Valores'].ChildNodes['ns3:ValorCofins']));
    cdsNFS.FieldByName('VALIRR').AsFloat := fStrToFloatDef(fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:Servico'].ChildNodes['ns3:Valores'].ChildNodes['ns3:ValorIr']));
    cdsNFS.FieldByName('VALINS').AsFloat := fStrToFloatDef(fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:Servico'].ChildNodes['ns3:Valores'].ChildNodes['ns3:ValorInss']));
    cdsNFS.FieldByName('VALCSL').AsFloat := fStrToFloatDef(fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:Servico'].ChildNodes['ns3:Valores'].ChildNodes['ns3:ValorCsll']));
    cdsNFS.FieldByName('VLRLIQ').AsFloat := fStrToFloatDef(fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:Servico'].ChildNodes['ns3:Valores'].ChildNodes['ns3:ValorLiquidoNfse']));
    cdsNFS.FieldByName('VLRDED').AsFloat := fStrToFloatDef(fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:Servico'].ChildNodes['ns3:Valores'].ChildNodes['ns3:ValorDeducoes']));

    cdsNFS.FieldByName('CODSER').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:Servico'].ChildNodes['ns3:ItemListaServico']);
    cdsNFS.FieldByName('CODTRI').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:Servico'].ChildNodes['ns3:CodigoTributacaoMunicipio']);
    cdsNFS.FieldByName('DISCRI').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:Servico'].ChildNodes['ns3:Discriminacao']);
    cdsNFS.FieldByName('CODMUN').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:Servico'].ChildNodes['ns3:MunicipioPrestacaoServico']);

    //PRESTADOR DO SERVIÇO

    cdsNFS.FieldByName('PSVCNPJ').AsString  := fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:PrestadorServico'].ChildNodes['ns3:IdentificacaoPrestador'].ChildNodes['ns3:Cnpj']);
    cdsNFS.FieldByName('PSVIM').AsString    := fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:PrestadorServico'].ChildNodes['ns3:IdentificacaoPrestador'].ChildNodes['ns3:InscricaoMunicipal']);
    cdsNFS.FieldByName('PSVRAZAO').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:PrestadorServico'].ChildNodes['ns3:RazaoSocial']);
    cdsNFS.FieldByName('PSVEND').AsString   := fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:PrestadorServico'].ChildNodes['ns3:Endereco'].ChildNodes['ns3:Endereco']);
    cdsNFS.FieldByName('PSVNUM').AsString   := fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:PrestadorServico'].ChildNodes['ns3:Endereco'].ChildNodes['ns3:Numero']);
    cdsNFS.FieldByName('PSVBAIR').AsString  := fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:PrestadorServico'].ChildNodes['ns3:Endereco'].ChildNodes['ns3:Bairro']);
    cdsNFS.FieldByName('PSVMUN').AsString   := fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:PrestadorServico'].ChildNodes['ns3:Endereco'].ChildNodes['ns3:CodigoMunicipio']);
    cdsNFS.FieldByName('PSVUF').AsString    := fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:PrestadorServico'].ChildNodes['ns3:Endereco'].ChildNodes['ns3:Uf']);
    cdsNFS.FieldByName('PSVCEP').AsString   := fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:PrestadorServico'].ChildNodes['ns3:Endereco'].ChildNodes['ns3:Cep']);
    cdsNFS.FieldByName('PSVFONE').AsString  := fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:PrestadorServico'].ChildNodes['ns3:Contato'].ChildNodes['ns3:Telefone']);
    cdsNFS.FieldByName('PSVEMAIL').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:PrestadorServico'].ChildNodes['ns3:Contato'].ChildNodes['ns3:Email']);

    //TOMADOR DO SERVIÇO

    cdsNFS.FieldByName('TMSCNPJ').AsString := Iif(fEmptyStr(fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:TomadorServico'].ChildNodes['ns3:IdentificacaoTomador'].ChildNodes['ns3:CpfCnpj'].ChildNodes['ns3:Cnpj'])),
                                                            fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:TomadorServico'].ChildNodes['ns3:IdentificacaoTomador'].ChildNodes['ns3:CpfCnpj'].ChildNodes['ns3:Cpf']),
                                                            fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:TomadorServico'].ChildNodes['ns3:IdentificacaoTomador'].ChildNodes['ns3:CpfCnpj'].ChildNodes['ns3:Cnpj']));

    cdsNFS.FieldByName('TMSRAZAO').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:TomadorServico'].ChildNodes['ns3:RazaoSocial']);
    cdsNFS.FieldByName('TMSEND').AsString   := fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:TomadorServico'].ChildNodes['ns3:Endereco'].ChildNodes['ns3:Endereco']);
    cdsNFS.FieldByName('TMSNUM').AsString   := fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:TomadorServico'].ChildNodes['ns3:Endereco'].ChildNodes['ns3:Numero']);
    cdsNFS.FieldByName('TMSBAIR').AsString  := fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:TomadorServico'].ChildNodes['ns3:Endereco'].ChildNodes['ns3:Bairro']);
    cdsNFS.FieldByName('TMSMUN').AsString   := fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:TomadorServico'].ChildNodes['ns3:Endereco'].ChildNodes['ns3:CodigoMunicipio']);
    cdsNFS.FieldByName('TMSUF').AsString    := fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:TomadorServico'].ChildNodes['ns3:Endereco'].ChildNodes['ns3:Uf']);
    cdsNFS.FieldByName('TMSCEP').AsString   := fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:TomadorServico'].ChildNodes['ns3:Endereco'].ChildNodes['ns3:Cep']);
    cdsNFS.FieldByName('TMSFONE').AsString  := fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:TomadorServico'].ChildNodes['ns3:Contato'].ChildNodes['ns3:Telefone']);
    cdsNFS.FieldByName('TMSEMAIL').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:TomadorServico'].ChildNodes['ns3:Contato'].ChildNodes['ns3:Email']);

    // ORGÃO GERADOR

    cdsNFS.FieldByName('ORGMUN').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:OrgaoGerador'].ChildNodes['ns3:CodigoMunicipio']);
    cdsNFS.FieldByName('ORG_UF').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes['ns3:OrgaoGerador'].ChildNodes['ns3:Uf']);

    // CONSTRUÇÃO CIVIL
    cdsNFS.FieldByName('CODOBR').AsString := '';
    cdsNFS.FieldByName('CODART').AsString := '';

    // REFORMA TRIBUTÁRIA
    if Assigned(NoTcIBSCBSTotal) then
    begin
      cdsNFS.FieldByName('IBSTot').asFloat := fStrToFloatDef(fRetornaValorTagXml(NoTcIBSCBSTotal.ChildNodes['totCIBS'].ChildNodes['gIBS'].ChildNodes['vIBSTot']));
      cdsNFS.FieldByName('gCBS_vCBS').asFloat := fStrToFloatDef(fRetornaValorTagXml(NoTcIBSCBSTotal.ChildNodes['totCIBS'].ChildNodes['gCBS'].ChildNodes['vCBS']));
    end;
    cdsNFS.Post;
  except
    cdsNFS.Cancel;
    raise;
  end;
end;

{ TProvGinfesV4 }

class procedure TProvGinfesV4.pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string; strCidNfse: string = '');
var
  NoInfNfse   : IXMLDocument;
  NoPrincipal : IXMLNode;
  strPrefixo  : string;
begin

  if ( strCidNfse = 'PREFEITURA DE FORTALEZA-CE' ) then
    strPrefixo := ''
  else
    strPrefixo := 'ns4:';

  NoInfNfse := TXMLDocument.Create(Application);

  NoInfNfse.LoadFromXML(strXML);
  NoInfNfse.Active := True;
  NoPrincipal := NoInfNfse.ChildNodes[strPrefixo+'Nfse'];

  cdsNFS.Append;

  try
    //DADOS DA NOTA FISCAO DE SERVIÇO ELETRÔNICA E RPS

    cdsNFS.FieldByName('NFSEID').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'ChaveAcesso']);
    cdsNFS.FieldByName('NUMNFS').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'Numero']);
    cdsNFS.FieldByName('CODVER').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'CodigoVerificacao']);
    cdsNFS.FieldByName('DTAHRA').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'DataEmissao']);
    cdsNFS.FieldByName('DTAEMI').AsString := Copy(fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'DataEmissao']),9,2)+'/'+
                                             Copy(fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'DataEmissao']),6,2)+'/'+
                                             Copy(fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'DataEmissao']),1,4);

    cdsNFS.FieldByName('NUMRPS').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'IdentificacaoRps'].ChildNodes[strPrefixo+'Numero']);
    cdsNFS.FieldByName('SERRPS').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'IdentificacaoRps'].ChildNodes[strPrefixo+'Serie']);
    cdsNFS.FieldByName('TPORPS').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'IdentificacaoRps'].ChildNodes[strPrefixo+'Tipo']);

    cdsNFS.FieldByName('EMIRPS').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'DataEmissaoRps']);
    cdsNFS.FieldByName('NATOPE').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'NaturezaOperacao']);
    cdsNFS.FieldByName('CODRET').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'RegimeEspecialTributacao']);
    cdsNFS.FieldByName('EMIOSN').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'OptanteSimplesNacional']);
    cdsNFS.FieldByName('EMIICC').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'IncetivadorCultural']);
    cdsNFS.FieldByName('COMPET').AsString := Copy(fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'Competencia']),1,10);

    //SERVIÇOS

    cdsNFS.FieldByName('VLRSER').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'Servico'].ChildNodes[strPrefixo+'Valores'].ChildNodes[strPrefixo+'ValorServicos']));
    cdsNFS.FieldByName('ISS_RET').AsFloat := fStrToFloatDef(fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'Servico'].ChildNodes[strPrefixo+'Valores'].ChildNodes[strPrefixo+'IssRetido']));
    cdsNFS.FieldByName('VLRISS').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'Servico'].ChildNodes[strPrefixo+'Valores'].ChildNodes[strPrefixo+'ValorIss']));
    cdsNFS.FieldByName('BSCISS').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'Servico'].ChildNodes[strPrefixo+'Valores'].ChildNodes[strPrefixo+'BaseCalculo']));
    cdsNFS.FieldByName('ALIISS').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'Servico'].ChildNodes[strPrefixo+'Valores'].ChildNodes[strPrefixo+'Aliquota']));

    cdsNFS.FieldByName('VALPIS').AsFloat := fStrToFloatDef(fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'Servico'].ChildNodes[strPrefixo+'Valores'].ChildNodes[strPrefixo+'ValorPis']));
    cdsNFS.FieldByName('VALCOF').AsFloat := fStrToFloatDef(fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'Servico'].ChildNodes[strPrefixo+'Valores'].ChildNodes[strPrefixo+'ValorCofins']));
    cdsNFS.FieldByName('VALIRR').AsFloat := fStrToFloatDef(fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'Servico'].ChildNodes[strPrefixo+'Valores'].ChildNodes[strPrefixo+'ValorIr']));
    cdsNFS.FieldByName('VALINS').AsFloat := fStrToFloatDef(fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'Servico'].ChildNodes[strPrefixo+'Valores'].ChildNodes[strPrefixo+'ValorInss']));
    cdsNFS.FieldByName('VALCSL').AsFloat := fStrToFloatDef(fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'Servico'].ChildNodes[strPrefixo+'Valores'].ChildNodes[strPrefixo+'ValorCsll']));
    cdsNFS.FieldByName('VLRLIQ').AsFloat := fStrToFloatDef(fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'Servico'].ChildNodes[strPrefixo+'Valores'].ChildNodes[strPrefixo+'ValorLiquidoNfse']));
    cdsNFS.FieldByName('VLRDED').AsFloat := fStrToFloatDef(fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'Servico'].ChildNodes[strPrefixo+'Valores'].ChildNodes[strPrefixo+'ValorDeducoes']));

    cdsNFS.FieldByName('CODSER').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'Servico'].ChildNodes[strPrefixo+'ItemListaServico']);
    cdsNFS.FieldByName('CODTRI').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'Servico'].ChildNodes[strPrefixo+'CodigoTributacaoMunicipio']);
    cdsNFS.FieldByName('DISCRI').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'Servico'].ChildNodes[strPrefixo+'Discriminacao']);
    cdsNFS.FieldByName('CODMUN').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'Servico'].ChildNodes[strPrefixo+'CodigoMunicipio']);

    //PRESTADOR DO SERVIÇO

    cdsNFS.FieldByName('PSVCNPJ').AsString  := fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'PrestadorServico'].ChildNodes[strPrefixo+'IdentificacaoPrestador'].ChildNodes[strPrefixo+'Cnpj']);
    cdsNFS.FieldByName('PSVIM').AsString    := fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'PrestadorServico'].ChildNodes[strPrefixo+'IdentificacaoPrestador'].ChildNodes[strPrefixo+'InscricaoMunicipal']);
    cdsNFS.FieldByName('PSVRAZAO').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'PrestadorServico'].ChildNodes[strPrefixo+'RazaoSocial']);
    cdsNFS.FieldByName('PSVEND').AsString   := fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'PrestadorServico'].ChildNodes[strPrefixo+'Endereco'].ChildNodes[strPrefixo+'Endereco']);
    cdsNFS.FieldByName('PSVNUM').AsString   := fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'PrestadorServico'].ChildNodes[strPrefixo+'Endereco'].ChildNodes[strPrefixo+'Numero']);
    cdsNFS.FieldByName('PSVBAIR').AsString  := fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'PrestadorServico'].ChildNodes[strPrefixo+'Endereco'].ChildNodes[strPrefixo+'Bairro']);
    cdsNFS.FieldByName('PSVUF').AsString    := fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'PrestadorServico'].ChildNodes[strPrefixo+'Endereco'].ChildNodes[strPrefixo+'Uf']);
    cdsNFS.FieldByName('PSVCEP').AsString   := fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'PrestadorServico'].ChildNodes[strPrefixo+'Endereco'].ChildNodes[strPrefixo+'Cep']);
    cdsNFS.FieldByName('PSVFONE').AsString  := fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'PrestadorServico'].ChildNodes[strPrefixo+'Contato'].ChildNodes[strPrefixo+'Telefone']);
    cdsNFS.FieldByName('PSVEMAIL').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'PrestadorServico'].ChildNodes[strPrefixo+'Contato'].ChildNodes[strPrefixo+'Email']);

    //TOMADOR DO SERVIÇO

    cdsNFS.FieldByName('TMSCNPJ').AsString := Iif(fEmptyStr(fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'TomadorServico'].ChildNodes[strPrefixo+'IdentificacaoTomador'].ChildNodes[strPrefixo+'CpfCnpj'].ChildNodes[strPrefixo+'Cnpj'])),
                                                            fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'TomadorServico'].ChildNodes[strPrefixo+'IdentificacaoTomador'].ChildNodes[strPrefixo+'CpfCnpj'].ChildNodes[strPrefixo+'Cpf']),
                                                            fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'TomadorServico'].ChildNodes[strPrefixo+'IdentificacaoTomador'].ChildNodes[strPrefixo+'CpfCnpj'].ChildNodes[strPrefixo+'Cnpj']));

    cdsNFS.FieldByName('TMSRAZAO').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'TomadorServico'].ChildNodes[strPrefixo+'RazaoSocial']);
    cdsNFS.FieldByName('TMSEND').AsString   := fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'TomadorServico'].ChildNodes[strPrefixo+'Endereco'].ChildNodes[strPrefixo+'Endereco']);
    cdsNFS.FieldByName('TMSNUM').AsString   := fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'TomadorServico'].ChildNodes[strPrefixo+'Endereco'].ChildNodes[strPrefixo+'Numero']);
    cdsNFS.FieldByName('TMSBAIR').AsString  := fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'TomadorServico'].ChildNodes[strPrefixo+'Endereco'].ChildNodes[strPrefixo+'Bairro']);
    cdsNFS.FieldByName('TMSUF').AsString    := fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'TomadorServico'].ChildNodes[strPrefixo+'Endereco'].ChildNodes[strPrefixo+'Uf']);
    cdsNFS.FieldByName('TMSCEP').AsString   := fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'TomadorServico'].ChildNodes[strPrefixo+'Endereco'].ChildNodes[strPrefixo+'Cep']);
    cdsNFS.FieldByName('TMSFONE').AsString  := fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'TomadorServico'].ChildNodes[strPrefixo+'Contato'].ChildNodes[strPrefixo+'Telefone']);
    cdsNFS.FieldByName('TMSEMAIL').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'TomadorServico'].ChildNodes[strPrefixo+'Contato'].ChildNodes[strPrefixo+'Email']);

    // ORGÃO GERADOR

    cdsNFS.FieldByName('ORGMUN').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'OrgaoGerador'].ChildNodes[strPrefixo+'CodigoMunicipio']);
    cdsNFS.FieldByName('ORG_UF').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'OrgaoGerador'].ChildNodes[strPrefixo+'Uf']);

    // CONSTRUÇÃO CIVIL
    cdsNFS.FieldByName('CODOBR').AsString := '';
    cdsNFS.FieldByName('CODART').AsString := '';

    if strCidNfse = 'PREFEITURA DE FORTALEZA-CE' then
    begin
      cdsNFS.FieldByName('PSVMUN').AsString := '';
      cdsNFS.FieldByName('TMSMUN').AsString := '';
    end
    else
    begin
      cdsNFS.FieldByName('TMSMUN').AsString   := fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'TomadorServico'].ChildNodes[strPrefixo+'Endereco'].ChildNodes[strPrefixo+'CodigoMunicipio']);
      cdsNFS.FieldByName('PSVMUN').AsString   := fRetornaValorTagXml(NoPrincipal.ChildNodes[strPrefixo+'InfNfse'].ChildNodes[strPrefixo+'PrestadorServico'].ChildNodes[strPrefixo+'Endereco'].ChildNodes[strPrefixo+'CodigoMunicipio']);
    end;

    cdsNFS.Post;
  except
    cdsNFS.Cancel;
    raise;
  end;

end;

{ TProvGinfesReforma }

class procedure TProvGinfesReforma.pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string; strCidNfse: string = '');
var
  XmlDoc : IXMLDocument;
  XmlNodeDoc, XmlNodePrincipal, XmlNodeValores, XmlNodeServico, XmlNodeIBSCBS, XmlNodeTrib, XmlNodeCpfCnpj,
  XmlNodeIBSCBSValores, XmlNodeGIBSCBS, XmlNodeTcIBSCBSTotal, XmlNodeTotCIBS, XmlNodeGIBS, XmlNodeGCBS : IXMLNode;
  sCnpj, sCpf: string;

  function FindChildByLocalName(ParentNode: IXMLNode; const LocalName: string;
    const NamespaceURI: string = ''): IXMLNode;
  var
    i: Integer;
    Node: IXMLNode;
  begin
    Result := nil;
    if not Assigned(ParentNode) then Exit;
    for i := 0 to ParentNode.ChildNodes.Count - 1 do
    begin
      Node := ParentNode.ChildNodes[i];
      if SameText(Node.LocalName, LocalName) and
         ((NamespaceURI = '') or SameText(Node.NamespaceURI, NamespaceURI)) then
      begin
        Result := Node;
        Exit;
      end;
    end;
  end;

begin

  xmlDoc := TXMLDocument.Create(nil);
  xmlDoc.LoadFromXML(strXML);
  xmlDoc.Active := True;

  XmlNodeDoc := FindChildByLocalName(xmlDoc.Node, 'CompNfse',
    'http://www.ginfes.com.br/servico_consultar_lote_rps_resposta_v03.xsd');

  if Assigned(XmlNodeDoc) then
    XmlNodePrincipal := FindChildByLocalName(XmlNodeDoc, 'Nfse',
      'http://www.ginfes.com.br/tipos_v03.xsd')
  else
    XmlNodePrincipal := FindChildByLocalName(xmlDoc.Node, 'Nfse',
      'http://www.ginfes.com.br/tipos_v03.xsd');

  if not Assigned(XmlNodePrincipal) then
    raise Exception.Create('XML da NFSe não reconhecido: nó Nfse não localizado (nem como raiz, nem aninhado em CompNfse).');

  XmlNodePrincipal := FindChildByLocalName(XmlNodePrincipal, 'InfNfse');
  if not Assigned(XmlNodePrincipal) then
    raise Exception.Create('XML da NFSe não reconhecido: envelope InfNfse ausente.');

  XmlNodeServico := FindChildByLocalName(XmlNodePrincipal, 'Servico');
  if not Assigned(XmlNodeServico) then
    raise Exception.Create('XML da NFSe não reconhecido: envelope Servico ausente.');

  XmlNodeValores := FindChildByLocalName(XmlNodeServico, 'Valores');
  if not Assigned(XmlNodeValores) then
    raise Exception.Create('XML da NFSe não reconhecido: envelope Valores ausente.');

  XmlNodeIBSCBS := XmlNodeValores.ChildNodes.FindNode('ns4:IBSCBS');
  if not Assigned(XmlNodeIBSCBS) then
    raise Exception.Create('XML da NFSe não reconhecido: envelope IBSCBS ausente.');

  cdsNFS.Append;

  try
    //DADOS DA NOTA FISCAO DE SERVIÇO ELETRÔNICA E RPS

    cdsNFS.FieldByName('NFSEID').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('ns4:ChaveAcesso'));
    cdsNFS.FieldByName('NUMNFS').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('ns4:Numero'));
    cdsNFS.FieldByName('CODVER').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:CodigoVerificacao']);
    cdsNFS.FieldByName('DTAHRA').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:DataEmissao']);
    cdsNFS.FieldByName('DTAEMI').AsString := Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:DataEmissao']),9,2)+'/'+
                                             Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:DataEmissao']),6,2)+'/'+
                                             Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:DataEmissao']),1,4);

    cdsNFS.FieldByName('NUMRPS').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:IdentificacaoRps'].ChildNodes['ns4:Numero']);
    cdsNFS.FieldByName('SERRPS').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:IdentificacaoRps'].ChildNodes['ns4:Serie']);
    cdsNFS.FieldByName('TPORPS').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:IdentificacaoRps'].ChildNodes['ns4:Tipo']);

    cdsNFS.FieldByName('EMIRPS').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:DataEmissaoRps']);
    cdsNFS.FieldByName('NATOPE').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:NaturezaOperacao']);
    cdsNFS.FieldByName('CODRET').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:RegimeEspecialTributacao']);
    cdsNFS.FieldByName('EMIOSN').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:OptanteSimplesNacional']);
    cdsNFS.FieldByName('EMIICC').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:IncetivadorCultural']);
    cdsNFS.FieldByName('COMPET').AsString := Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:Competencia']),1,10);

    //SERVIÇOS

    cdsNFS.FieldByName('VLRSER').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:Servico'].ChildNodes['ns4:Valores'].ChildNodes['ns4:ValorServicos']));
    cdsNFS.FieldByName('ISS_RET').AsFloat := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:Servico'].ChildNodes['ns4:Valores'].ChildNodes['ns4:IssRetido']));
    cdsNFS.FieldByName('VLRISS').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:Servico'].ChildNodes['ns4:Valores'].ChildNodes['ns4:ValorIss']));
    cdsNFS.FieldByName('BSCISS').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:Servico'].ChildNodes['ns4:Valores'].ChildNodes['ns4:BaseCalculo']));
    cdsNFS.FieldByName('ALIISS').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:Servico'].ChildNodes['ns4:Valores'].ChildNodes['ns4:Aliquota']));

    cdsNFS.FieldByName('VALPIS').AsFloat := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:Servico'].ChildNodes['ns4:Valores'].ChildNodes['ns4:ValorPis']));
    cdsNFS.FieldByName('VALCOF').AsFloat := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:Servico'].ChildNodes['ns4:Valores'].ChildNodes['ns4:ValorCofins']));
    cdsNFS.FieldByName('VALIRR').AsFloat := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:Servico'].ChildNodes['ns4:Valores'].ChildNodes['ns4:ValorIr']));
    cdsNFS.FieldByName('VALINS').AsFloat := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:Servico'].ChildNodes['ns4:Valores'].ChildNodes['ns4:ValorInss']));
    cdsNFS.FieldByName('VALCSL').AsFloat := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:Servico'].ChildNodes['ns4:Valores'].ChildNodes['ns4:ValorCsll']));
    cdsNFS.FieldByName('VLRLIQ').AsFloat := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:Servico'].ChildNodes['ns4:Valores'].ChildNodes['ns4:ValorLiquidoNfse']));
    cdsNFS.FieldByName('VLRDED').AsFloat := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:Servico'].ChildNodes['ns4:Valores'].ChildNodes['ns4:ValorDeducoes']));

    cdsNFS.FieldByName('CODSER').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:Servico'].ChildNodes['ns4:ItemListaServico']);
    cdsNFS.FieldByName('CODTRI').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:Servico'].ChildNodes['ns4:CodigoTributacaoMunicipio']);
    cdsNFS.FieldByName('DISCRI').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:Servico'].ChildNodes['ns4:Discriminacao']);
    cdsNFS.FieldByName('CODMUN').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:Servico'].ChildNodes['ns4:CodigoMunicipio']);

    //PRESTADOR DO SERVIÇO

    cdsNFS.FieldByName('PSVCNPJ').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:PrestadorServico'].ChildNodes['ns4:IdentificacaoPrestador'].ChildNodes['ns4:Cnpj']);
    cdsNFS.FieldByName('PSVIM').AsString    := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:PrestadorServico'].ChildNodes['ns4:IdentificacaoPrestador'].ChildNodes['ns4:InscricaoMunicipal']);
    cdsNFS.FieldByName('PSVRAZAO').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:PrestadorServico'].ChildNodes['ns4:RazaoSocial']);
    cdsNFS.FieldByName('PSVEND').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:PrestadorServico'].ChildNodes['ns4:Endereco'].ChildNodes['ns4:Endereco']);
    cdsNFS.FieldByName('PSVNUM').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:PrestadorServico'].ChildNodes['ns4:Endereco'].ChildNodes['ns4:Numero']);
    cdsNFS.FieldByName('PSVBAIR').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:PrestadorServico'].ChildNodes['ns4:Endereco'].ChildNodes['ns4:Bairro']);
    cdsNFS.FieldByName('PSVUF').AsString    := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:PrestadorServico'].ChildNodes['ns4:Endereco'].ChildNodes['ns4:Uf']);
    cdsNFS.FieldByName('PSVCEP').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:PrestadorServico'].ChildNodes['ns4:Endereco'].ChildNodes['ns4:Cep']);
    cdsNFS.FieldByName('PSVFONE').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:PrestadorServico'].ChildNodes['ns4:Contato'].ChildNodes['ns4:Telefone']);
    cdsNFS.FieldByName('PSVEMAIL').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:PrestadorServico'].ChildNodes['ns4:Contato'].ChildNodes['ns4:Email']);

    //TOMADOR DO SERVIÇO
    XmlNodeCpfCnpj := FindChildByLocalName(
      FindChildByLocalName(
        FindChildByLocalName(XmlNodePrincipal, 'TomadorServico'), 'IdentificacaoTomador'), 'CpfCnpj');

    sCnpj := fRetornaValorTagXml(FindChildByLocalName(XmlNodeCpfCnpj, 'Cnpj'));
    sCpf  := fRetornaValorTagXml(FindChildByLocalName(XmlNodeCpfCnpj, 'Cpf'));
    if fEmptyStr(sCnpj) then
      cdsNFS.FieldByName('TMSCNPJ').AsString := sCpf
    else
      cdsNFS.FieldByName('TMSCNPJ').AsString := sCnpj;

    cdsNFS.FieldByName('TMSRAZAO').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:TomadorServico'].ChildNodes['ns4:RazaoSocial']);
    cdsNFS.FieldByName('TMSEND').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:TomadorServico'].ChildNodes['ns4:Endereco'].ChildNodes['ns4:Endereco']);
    cdsNFS.FieldByName('TMSNUM').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:TomadorServico'].ChildNodes['ns4:Endereco'].ChildNodes['ns4:Numero']);
    cdsNFS.FieldByName('TMSBAIR').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:TomadorServico'].ChildNodes['ns4:Endereco'].ChildNodes['ns4:Bairro']);
    cdsNFS.FieldByName('TMSUF').AsString    := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:TomadorServico'].ChildNodes['ns4:Endereco'].ChildNodes['ns4:Uf']);
    cdsNFS.FieldByName('TMSCEP').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:TomadorServico'].ChildNodes['ns4:Endereco'].ChildNodes['ns4:Cep']);
    cdsNFS.FieldByName('TMSFONE').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:TomadorServico'].ChildNodes['ns4:Contato'].ChildNodes['ns4:Telefone']);
    cdsNFS.FieldByName('TMSEMAIL').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:TomadorServico'].ChildNodes['ns4:Contato'].ChildNodes['ns4:Email']);

    // ORGÃO GERADOR

    cdsNFS.FieldByName('ORGMUN').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:OrgaoGerador'].ChildNodes['ns4:CodigoMunicipio']);
    cdsNFS.FieldByName('ORG_UF').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:OrgaoGerador'].ChildNodes['ns4:Uf']);

    // CONSTRUÇÃO CIVIL
    cdsNFS.FieldByName('CODOBR').AsString := '';
    cdsNFS.FieldByName('CODART').AsString := '';
    cdsNFS.FieldByName('TMSMUN').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:TomadorServico'].ChildNodes['ns4:Endereco'].ChildNodes['ns4:CodigoMunicipio']);
    cdsNFS.FieldByName('PSVMUN').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ns4:PrestadorServico'].ChildNodes['ns4:Endereco'].ChildNodes['ns4:CodigoMunicipio']);

    if Assigned(XmlNodeIBSCBS) then
    begin
      cdsNFS.FieldByName('IBSCBS_cIndOp').AsString := fRetornaValorTagXml(XmlNodeIBSCBS.ChildNodes.FindNode('ns4:cIndOp'));

      XmlNodeIBSCBSValores := XmlNodeIBSCBS.ChildNodes.FindNode('ns4:valores');
      if Assigned(XmlNodeIBSCBSValores) then
      begin
        cdsNFS.FieldByName('IBSCBS_vBC').AsFloat := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeIBSCBSValores.ChildNodes.FindNode('ns4:vBC')),'.',','), 0);

        XmlNodeTrib := FindChildByLocalName(XmlNodeIBSCBSValores, 'trib');
        if Assigned(XmlNodeTrib) then
        begin
          XmlNodeGIBSCBS := FindChildByLocalName(XmlNodeTrib, 'gIBSCBS');
          if Assigned(XmlNodeGIBSCBS) then
          begin
            cdsNFS.FieldByName('gIBSCBS_CST').AsString        := fRetornaValorTagXml(FindChildByLocalName(XmlNodeGIBSCBS, 'CST'));
            cdsNFS.FieldByName('gIBSCBS_cClassTrib').AsString := fRetornaValorTagXml(FindChildByLocalName(XmlNodeGIBSCBS, 'cClassTrib'));
          end;
        end;

      end;
    end;

    if Assigned(XmlNodeDoc) then
      XmlNodeTcIBSCBSTotal := FindChildByLocalName(XmlNodeDoc, 'TcIBSCBSTotal')
    else
      XmlNodeTcIBSCBSTotal := FindChildByLocalName(xmlDoc.Node, 'TcIBSCBSTotal');

    if Assigned(XmlNodeTcIBSCBSTotal) then
    begin
      XmlNodeTotCIBS := FindChildByLocalName(XmlNodeTcIBSCBSTotal, 'totCIBS');
      if Assigned(XmlNodeTotCIBS) then
      begin
        XmlNodeGIBS := FindChildByLocalName(XmlNodeTotCIBS, 'gIBS');
        if Assigned(XmlNodeGIBS) then
          cdsNFS.FieldByName('vIBSTot').AsFloat := StrToFloatDef(
            AnsiReplaceStr(fRetornaValorTagXml(FindChildByLocalName(XmlNodeGIBS, 'vIBSTot')),'.',','), 0);

        XmlNodeGCBS := FindChildByLocalName(XmlNodeTotCIBS, 'gCBS');
        if Assigned(XmlNodeGCBS) then
          cdsNFS.FieldByName('gCBS_vCBS').AsFloat := StrToFloatDef(
            AnsiReplaceStr(fRetornaValorTagXml(FindChildByLocalName(XmlNodeGCBS, 'vCBS')),'.',','), 0);
      end;
    end;

    cdsNFS.Post;
  except
    cdsNFS.Cancel;
    raise;
  end;

end;

end.
