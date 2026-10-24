unit untIssnetOnlineXML;

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
  TIssnetOnlineXML = class

    private

    public

      class procedure pRetornaCDSPreenchido(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil);
      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil);

  end;

implementation

{ TGissOnlineXML }

class procedure TIssnetOnlineXML.pRetornaCDSPreenchido(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil);
var
  xmlDoc,
  xmlItens : TXMLDocument;
begin

  if (strCidadeNFSe = 'PREFEITURA DE RIBEIRÃO PRETO') Or
     (strCidadeNFSe = 'PREFEITURA DE GUARULHOS-SP') then
  begin

    xmlDoc := TXMLDocument.Create(Application);

    try
      xmlDoc.LoadFromXML(strXML);
      xmlDoc.Active := True;

      cdsNFS.Append;

      cdsNFS.FieldByName('NUMNFS').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Numero'].Text;
      cdsNFS.FieldByName('CODVER').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['CodigoVerificacao'].Text;
      cdsNFS.FieldByName('DTAHRA').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text;
      cdsNFS.FieldByName('DTAEMI').AsString := Copy(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,9,2)+'/'+
                                               Copy(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,6,2)+'/'+
                                               Copy(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,1,4)+' '+
                                               Copy(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,12,8);
      cdsNFS.FieldByName('NUMRPS').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['IdentificacaoRps'].ChildNodes['Numero'].Text;
      cdsNFS.FieldByName('SERRPS').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['IdentificacaoRps'].ChildNodes['Serie'].Text;
      cdsNFS.FieldByName('TPORPS').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['IdentificacaoRps'].ChildNodes['Tipo'].Text;
      cdsNFS.FieldByName('EMIRPS').AsString := Copy(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissaoRps'].Text,9,2)+'/'+
                                               Copy(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissaoRps'].Text,6,2)+'/'+
                                               Copy(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissaoRps'].Text,1,4)+' '+
                                               Copy(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissaoRps'].Text,12,8);
      cdsNFS.FieldByName('NATOPE').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['NaturezaOperacao'].Text;
      cdsNFS.FieldByName('CODRET').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['RegimeEspecialTributacao'].Text;
      cdsNFS.FieldByName('EMIOSN').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['OptanteSimplesNacional'].Text;
      cdsNFS.FieldByName('EMIICC').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['IncentivadorCultural'].Text;
      cdsNFS.FieldByName('COMPET').AsString := Copy(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Competencia'].Text,1,10);
      cdsNFS.FieldByName('NFSSUB').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['NfseSubstituida'].Text;
      cdsNFS.FieldByName('OUTINF').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['OutrasInformacoes'].Text;
      cdsNFS.FieldByName('CODSER').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['ItemListaServico'].Text;
      cdsNFS.FieldByName('CDCNAE').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['CodigoCnae'].Text;
      cdsNFS.FieldByName('CODTRI').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['CodigoTributacaoMunicipio'].Text;
      cdsNFS.FieldByName('DISCRI').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Discriminacao'].Text;
      cdsNFS.FieldByName('MUNPRE').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['MunicipioPrestacaoServico'].Text;
      cdsNFS.FieldByName('VLRSER').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorServicos'].Text,'.',','), 0);
      cdsNFS.FieldByName('VLRDED').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorDeducoes'].Text,'.',','), 0);
      cdsNFS.FieldByName('VLRPIS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorPis'].Text,'.',','), 0);
      cdsNFS.FieldByName('VLRCOF').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorCofins'].Text,'.',','), 0);
      cdsNFS.FieldByName('VLRINS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorInss'].Text,'.',','), 0);
      cdsNFS.FieldByName('VLRIR_').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorIr'].Text,'.',','), 0);
      cdsNFS.FieldByName('VLRCSL').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorCsll'].Text,'.',','), 0);
      cdsNFS.FieldByName('ISS_RET').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['IssRetido'].Text;
      cdsNFS.FieldByName('OUT_RET').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['OutrasRetencoes'].Text,'.',','), 0);
      cdsNFS.FieldByName('BSCISS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['BaseCalculo'].Text,'.',','), 0);
      cdsNFS.FieldByName('ALIISS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['Aliquota'].Text,'.',','), 0);
      cdsNFS.FieldByName('VLRLIQ').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorLiquidoNfse'].Text,'.',','), 0);
      cdsNFS.FieldByName('VLRISS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorIss'].Text,'.',','), 0);
      cdsNFS.FieldByName('DESCONC').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['DescontoCondicionado'].Text,'.',','), 0);
      cdsNFS.FieldByName('DESCONI').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['DescontoIncondicionado'].Text,'.',','), 0);

      cdsNFS.FieldByName('PSVCNPJ').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['IdentificacaoPrestador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text;
      if fEmptyStr(cdsNFS.FieldByName('PSVCNPJ').AsString) then
        cdsNFS.FieldByName('PSVCNPJ').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['IdentificacaoPrestador'].ChildNodes['Cnpj'].Text;

      cdsNFS.FieldByName('PSVIM').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['IdentificacaoPrestador'].ChildNodes['InscricaoMunicipal'].Text;

      cdsNFS.FieldByName('PSVRAZAO').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['IdentificacaoPrestador'].ChildNodes['RazaoSocial'].Text;
      if fEmptyStr(cdsNFS.FieldByName('PSVRAZAO').AsString) then
        cdsNFS.FieldByName('PSVRAZAO').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['RazaoSocial'].Text;
      cdsNFS.FieldByName('PSVFANT').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['NomeFantasia'].Text;
      cdsNFS.FieldByName('PSVEND').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
      cdsNFS.FieldByName('PSVNUM').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Numero'].Text;
      cdsNFS.FieldByName('PSVCOMPL').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Complemento'].Text;
      cdsNFS.FieldByName('PSVBAIR').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
      cdsNFS.FieldByName('PSVMUN').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Cidade'].Text;
      cdsNFS.FieldByName('PSVUF').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Estado'].Text;
      cdsNFS.FieldByName('PSVCEP').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Cep'].Text;
      cdsNFS.FieldByName('PSVFONE').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Telefone'].Text;
      cdsNFS.FieldByName('PSVEMAIL').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Email'].Text;

      cdsNFS.FieldByName('TMSCNPJ').AsString := Iif(fEmptyStr(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text),
                                                              xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cpf'].Text,
                                                              xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text);

      cdsNFS.FieldByName('TMSIM').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['InscricaoMunicipal'].Text;

      cdsNFS.FieldByName('TMSRAZAO').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['RazaoSocial'].Text;
      cdsNFS.FieldByName('TMSEND').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
      cdsNFS.FieldByName('TMSNUM').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Numero'].Text;
      cdsNFS.FieldByName('TMSCOMPL').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Complemento'].Text;
      cdsNFS.FieldByName('TMSBAIR').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
      cdsNFS.FieldByName('TMSMUN').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Cidade'].Text;
      cdsNFS.FieldByName('TMSUF').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Estado'].Text;
      cdsNFS.FieldByName('TMSCEP').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Cep'].Text;
      cdsNFS.FieldByName('TMSFONE').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Contato'].ChildNodes['Telefone'].Text;
      cdsNFS.FieldByName('TMSEMAIL').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Contato'].ChildNodes['Email'].Text;

      cdsNFS.FieldByName('ORGMUN').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['OrgaoGerador'].ChildNodes['CodigoMunicipio'].Text;
      cdsNFS.FieldByName('ORG_UF').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['OrgaoGerador'].ChildNodes['Uf'].Text;

      cdsNFS.Post;

    finally
      FreeAndNil(xmlDoc);
    end;

  end;

  if (strCidadeNFSe='PREFEITURA DE ITAQUAQUECETUBA-SP') then
  begin

    xmlDoc := TXMLDocument.Create(Application);

    try

      xmlDoc.LoadFromXML(strXML);
      xmlDoc.Active := True;

      cdsNFS.Append;

      if (Copy(strXML, 2, 24)='ConsultarLoteRpsResposta') then //Nova Estrutura do XML da FIT
      begin

        cdsNFS.FieldByName('NUMNFS').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Numero'].Text;
        cdsNFS.FieldByName('CODVER').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['CodigoVerificacao'].Text;
        cdsNFS.FieldByName('DTAHRA').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text;
        cdsNFS.FieldByName('DTAEMI').AsString := Copy(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,9,2)+'/'+
                                                 Copy(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,6,2)+'/'+
                                                 Copy(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,1,4);
        cdsNFS.FieldByName('NUMRPS').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['IdentificacaoRps'].ChildNodes['Numero'].Text;
        cdsNFS.FieldByName('SERRPS').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['IdentificacaoRps'].ChildNodes['Serie'].Text;
        cdsNFS.FieldByName('TPORPS').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['IdentificacaoRps'].ChildNodes['Tipo'].Text;
        cdsNFS.FieldByName('EMIRPS').AsString := Copy(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissaoRps'].Text,9,2)+'/'+
                                                 Copy(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissaoRps'].Text,6,2)+'/'+
                                                 Copy(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissaoRps'].Text,1,4)+' '+
                                                 Copy(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissaoRps'].Text,12,8);
        cdsNFS.FieldByName('NATOPE').AsString := '';
        cdsNFS.FieldByName('CODRET').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['RegimeEspecialTributacao'].Text;
        cdsNFS.FieldByName('EMIOSN').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['OptanteSimplesNacional'].Text;
        cdsNFS.FieldByName('EMIICC').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['IncentivadorCultural'].Text;
        cdsNFS.FieldByName('COMPET').AsString := Copy(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Competencia'].Text,9,2)+'/'+
                                                 Copy(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Competencia'].Text,6,2)+'/'+
                                                 Copy(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Competencia'].Text,1,4);
        cdsNFS.FieldByName('NFSSUB').AsString := '';
        cdsNFS.FieldByName('OUTINF').AsString := '';
        cdsNFS.FieldByName('CODSER').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['ItemListaServico'].Text;
        cdsNFS.FieldByName('CDCNAE').AsString := '';
        cdsNFS.FieldByName('CODTRI').AsString := '';
        cdsNFS.FieldByName('DISCRI').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Discriminacao'].Text;
        cdsNFS.FieldByName('MUNPRE').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['CodigoMunicipio'].Text;
        cdsNFS.FieldByName('VLRSER').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorServicos'].Text,'.',','), 0);
        cdsNFS.FieldByName('VLRDED').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorDeducoes'].Text,'.',','), 0);
        cdsNFS.FieldByName('VLRPIS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorPis'].Text,'.',','), 0);
        cdsNFS.FieldByName('VLRCOF').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorCofins'].Text,'.',','), 0);
        cdsNFS.FieldByName('VLRINS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorIns'].Text,'.',','), 0);
        cdsNFS.FieldByName('VLRIR_').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorIr'].Text,'.',','), 0);
        cdsNFS.FieldByName('VLRCSL').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorCsll'].Text,'.',','), 0);
        cdsNFS.FieldByName('ISS_RET').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Servico'].ChildNodes['IssRetido'].Text;
        cdsNFS.FieldByName('OUT_RET').AsFloat := 0;
        cdsNFS.FieldByName('BSCISS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorServicos'].Text,'.',','), 0);
        cdsNFS.FieldByName('ALIISS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['Aliquota'].Text,'.',','), 0);
        cdsNFS.FieldByName('VLRLIQ').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorLiquidoNfse'].Text,'.',','), 0);
        cdsNFS.FieldByName('VLRISS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorIss'].Text,'.',','), 0);
        cdsNFS.FieldByName('DESCONC').AsFloat := 0;
        cdsNFS.FieldByName('DESCONI').AsFloat := 0;
        cdsNFS.FieldByName('PSVCNPJ').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['IdentificacaoPrestador'].ChildNodes['Cnpj'].Text;
        cdsNFS.FieldByName('PSVIM').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['IdentificacaoPrestador'].ChildNodes['InscricaoMunicipal'].Text;
        cdsNFS.FieldByName('PSVRAZAO').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['RazaoSocial'].Text;
        cdsNFS.FieldByName('PSVFANT').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['RazaoSocial'].Text;
        cdsNFS.FieldByName('PSVEND').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
        cdsNFS.FieldByName('PSVNUM').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Numero'].Text;
        cdsNFS.FieldByName('PSVCOMPL').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Complemento'].Text;
        cdsNFS.FieldByName('PSVBAIR').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
        cdsNFS.FieldByName('PSVMUN').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio'].Text;
        cdsNFS.FieldByName('PSVUF').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['UF'].Text;
        cdsNFS.FieldByName('PSVCEP').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['CEP'].Text;
        cdsNFS.FieldByName('PSVFONE').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Telefone'].Text;
        cdsNFS.FieldByName('PSVEMAIL').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Email'].Text;
        cdsNFS.FieldByName('TMSCNPJ').AsString := Iif(fEmptyStr(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cpf'].Text),
                                                                xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text,
                                                                xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cpf'].Text);
        cdsNFS.FieldByName('TMSRAZAO').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['RazaoSocial'].Text;
        cdsNFS.FieldByName('TMSIM').AsString := '';
        cdsNFS.FieldByName('TMSEND').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
        cdsNFS.FieldByName('TMSNUM').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Numero'].Text;
        cdsNFS.FieldByName('TMSCOMPL').AsString := '';
        cdsNFS.FieldByName('TMSBAIR').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
        cdsNFS.FieldByName('TMSMUN').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio'].Text;
        cdsNFS.FieldByName('TMSUF').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Uf'].Text;
        cdsNFS.FieldByName('TMSCEP').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Cep'].Text;
        cdsNFS.FieldByName('TMSFONE').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Contato'].ChildNodes['Telefone'].Text;
        cdsNFS.FieldByName('TMSEMAIL').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Contato'].ChildNodes['Email'].Text;
        cdsNFS.FieldByName('ORGMUN').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['OrgaoGerador'].ChildNodes['CodigoMunicipio'].Text;
        cdsNFS.FieldByName('ORG_UF').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['OrgaoGerador'].ChildNodes['Uf'].Text;

        cdsNFS.Post;

        cdsItens.Append;
        cdsItens.FieldByName('NUMNFS').AsString := cdsNFS.FieldByName('NUMNFS').AsString;
        cdsItens.FieldByName('ITEDES').AsString := xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Discriminacao'].Text;
        cdsItens.FieldByName('ITEQTD').AsFloat  := 1;
        cdsItens.FieldByName('VLRUNT').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorServicos'].Text,'.',','), 0);
        cdsItens.FieldByName('VLRTOT').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarLoteRpsResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorServicos'].Text,'.',','), 0);
        cdsItens.Post;

      end
      else  // Estrutura Inicial do XML da FIT
      begin

        cdsNFS.FieldByName('NUMNFS').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Numero'].Text;
        cdsNFS.FieldByName('CODVER').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['CodigoVerificacao'].Text;
        cdsNFS.FieldByName('DTAHRA').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text;
        cdsNFS.FieldByName('DTAEMI').AsString := Copy(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,9,2)+'/'+
                                                 Copy(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,6,2)+'/'+
                                                 Copy(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,1,4);
        cdsNFS.FieldByName('NUMRPS').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Numero'].Text;
        cdsNFS.FieldByName('SERRPS').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Serie'].Text;
        cdsNFS.FieldByName('TPORPS').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Tipo'].Text;
        cdsNFS.FieldByName('EMIRPS').AsString := Copy(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['DataEmissao'].Text,9,2)+'/'+
                                                 Copy(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['DataEmissao'].Text,6,2)+'/'+
                                                 Copy(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['DataEmissao'].Text,1,4)+' '+
                                                 Copy(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['DataEmissao'].Text,12,8);
        cdsNFS.FieldByName('NATOPE').AsString := '';
        cdsNFS.FieldByName('CODRET').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['RegimeEspecialTributacao'].Text;
        cdsNFS.FieldByName('EMIOSN').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['OptanteSimplesNacional'].Text;
        cdsNFS.FieldByName('EMIICC').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['IncentivoFiscal'].Text;
        cdsNFS.FieldByName('COMPET').AsString := Copy(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Competencia'].Text,1,10);
        cdsNFS.FieldByName('NFSSUB').AsString := '';
        cdsNFS.FieldByName('OUTINF').AsString := '';
        cdsNFS.FieldByName('CODSER').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['ItemListaServico'].Text;
        cdsNFS.FieldByName('CDCNAE').AsString := '';
        cdsNFS.FieldByName('CODTRI').AsString := '';
        cdsNFS.FieldByName('DISCRI').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Discriminacao'].Text;
        cdsNFS.FieldByName('MUNPRE').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['CodigoMunicipio'].Text;
        cdsNFS.FieldByName('VLRSER').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorServicos'].Text,'.',','), 0);
        cdsNFS.FieldByName('VLRDED').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorDeducoes'].Text,'.',','), 0);
        cdsNFS.FieldByName('VLRPIS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorPis'].Text,'.',','), 0);
        cdsNFS.FieldByName('VLRCOF').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorCofins'].Text,'.',','), 0);
        cdsNFS.FieldByName('VLRINS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorIns'].Text,'.',','), 0);
        cdsNFS.FieldByName('VLRIR_').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorIr'].Text,'.',','), 0);
        cdsNFS.FieldByName('VLRCSL').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorCsll'].Text,'.',','), 0);
        cdsNFS.FieldByName('ISS_RET').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['IssRetido'].Text;
        cdsNFS.FieldByName('OUT_RET').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['OutrasRetencoes'].Text,'.',','), 0);
        cdsNFS.FieldByName('BSCISS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['ValoresNfse'].ChildNodes['BaseCalculo'].Text,'.',','), 0);
        cdsNFS.FieldByName('ALIISS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['ValoresNfse'].ChildNodes['Aliquota'].Text,'.',','), 0);
        cdsNFS.FieldByName('VLRLIQ').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['ValoresNfse'].ChildNodes['ValorLiquidoNfse'].Text,'.',','), 0);
        cdsNFS.FieldByName('VLRISS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['ValoresNfse'].ChildNodes['ValorIss'].Text,'.',','), 0);
        cdsNFS.FieldByName('DESCONC').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['DescontoCondicionado'].Text,'.',','), 0);
        cdsNFS.FieldByName('DESCONI').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['DescontoIncondicionado'].Text,'.',','), 0);
        cdsNFS.FieldByName('PSVCNPJ').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['IdentificacaoPrestador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text;
        cdsNFS.FieldByName('PSVIM').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['IdentificacaoPrestador'].ChildNodes['InscricaoMunicipal'].Text;
        cdsNFS.FieldByName('PSVRAZAO').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['RazaoSocial'].Text;
        cdsNFS.FieldByName('PSVFANT').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['NomeFantasia'].Text;
        cdsNFS.FieldByName('PSVEND').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
        cdsNFS.FieldByName('PSVNUM').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Numero'].Text;
        cdsNFS.FieldByName('PSVCOMPL').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Complemento'].Text;
        cdsNFS.FieldByName('PSVBAIR').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
        cdsNFS.FieldByName('PSVMUN').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio'].Text;
        cdsNFS.FieldByName('PSVUF').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['UF'].Text;
        cdsNFS.FieldByName('PSVCEP').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['CEP'].Text;
        cdsNFS.FieldByName('PSVFONE').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Telefone'].Text;
        cdsNFS.FieldByName('PSVEMAIL').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Email'].Text;
        cdsNFS.FieldByName('TMSCNPJ').AsString := Iif(fEmptyStr(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cpf'].Text),
                                                                xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text,
                                                                xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cpf'].Text);
        cdsNFS.FieldByName('TMSRAZAO').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['RazaoSocial'].Text;
        cdsNFS.FieldByName('TMSIM').AsString := '';
        cdsNFS.FieldByName('TMSEND').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
        cdsNFS.FieldByName('TMSNUM').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['Endereco'].ChildNodes['Numero'].Text;
        cdsNFS.FieldByName('TMSCOMPL').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['Endereco'].ChildNodes['Complemento'].Text;
        cdsNFS.FieldByName('TMSBAIR').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
        cdsNFS.FieldByName('TMSMUN').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio'].Text;
        cdsNFS.FieldByName('TMSUF').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['Endereco'].ChildNodes['Uf'].Text;
        cdsNFS.FieldByName('TMSCEP').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['Endereco'].ChildNodes['Cep'].Text;
        cdsNFS.FieldByName('TMSFONE').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['Contato'].ChildNodes['Telefone'].Text;
        cdsNFS.FieldByName('TMSEMAIL').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['Contato'].ChildNodes['Email'].Text;
        cdsNFS.FieldByName('ORGMUN').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['OrgaoGerador'].ChildNodes['CodigoMunicipio'].Text;
        cdsNFS.FieldByName('ORG_UF').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['OrgaoGerador'].ChildNodes['Uf'].Text;

        cdsNFS.Post;

        cdsItens.Append;
        cdsItens.FieldByName('NUMNFS').AsString := cdsNFS.FieldByName('NUMNFS').AsString;
        cdsItens.FieldByName('ITEDES').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Discriminacao'].Text;
        cdsItens.FieldByName('ITEQTD').AsFloat  := 1;
        cdsItens.FieldByName('VLRUNT').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorServicos'].Text,'.',','), 0);
        cdsItens.FieldByName('VLRTOT').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorServicos'].Text,'.',','), 0);
        cdsItens.Post;


      end

    finally
      FreeAndNil(xmlDoc);
    end;

  end;

end;

class procedure TIssnetOnlineXML.pRetornaCDSPreenchidoComENotas(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil);
var
  strRPS,
  strDadosRPS,
  strDadosPrestador,
  strEndPrestador,
  strCnpjPrestador,
  strDadosTomador,
  strEndTomador,
  strDetalhesDoServico,
  strOrgaoGerador,
  strPrefixo,
  strParcela,
  strDiscriminacaoServico : String;
  intInicioEnd,
  intFinalEnd: Integer;
begin

  if (strCidadeNFSe = 'PREFEITURA DE RIBEIRÃO PRETO') then
  begin
    if Pos( 'tc:', strXML ) > 0 then
      strPrefixo   := 'tc:'
    else
      strPrefixo   := '';
    intInicioEnd := 14;
    intFinalEnd  := 13;
  end
  else if (strCidadeNFSe = 'PREFEITURA DE GUARULHOS-SP') then
  begin
    strPrefixo   := 'ns4:';
    intInicioEnd := 15;
    intFinalEnd  := 14;
  end
  else if (strCidadeNFSe = 'PREFEITURA DE AGUAÍ-SP') then
  begin
    strPrefixo   := '';
    intInicioEnd := 15;
    intFinalEnd  := 14;
  end;

  cdsNFS.Append;

  cdsNFS.FieldByName('NUMNFS').AsString := RetornaTexto(strXML, '<'+strPrefixo+'Numero>', '</'+strPrefixo+'Numero>');
  cdsNFS.FieldByName('CODVER').AsString := RetornaTexto(strXML, '<'+strPrefixo+'CodigoVerificacao>', '</'+strPrefixo+'CodigoVerificacao>');
  cdsNFS.FieldByName('DTAHRA').AsString := Copy(RetornaTexto(strXML, '<'+strPrefixo+'DataEmissao>', '</'+strPrefixo+'DataEmissao>'), 12, 8);
  cdsNFS.FieldByName('DTAEMI').AsString := Copy(RetornaTexto(strXML, '<'+strPrefixo+'DataEmissao>', '</'+strPrefixo+'DataEmissao>'), 9, 2)+'/'+
                                           Copy(RetornaTexto(strXML, '<'+strPrefixo+'DataEmissao>', '</'+strPrefixo+'DataEmissao>'), 6, 2)+'/'+
                                           Copy(RetornaTexto(strXML, '<'+strPrefixo+'DataEmissao>', '</'+strPrefixo+'DataEmissao>'), 1, 4);

  strDadosRPS := RetornaTexto(strXML, '<'+strPrefixo+'IdentificacaoRps>', '</'+strPrefixo+'IdentificacaoRps>');
  strRPS := RetornaTexto(strXML, '<'+strPrefixo+'Rps>', '</'+strPrefixo+'Rps>');
  cdsNFS.FieldByName('NUMRPS').AsString := RetornaTexto(strDadosRPS, '<'+strPrefixo+'Numero>', '</'+strPrefixo+'Numero>');
  cdsNFS.FieldByName('SERRPS').AsString := RetornaTexto(strDadosRPS, '<'+strPrefixo+'Serie>', '</'+strPrefixo+'Serie>');
  cdsNFS.FieldByName('TPORPS').AsString := RetornaTexto(strDadosRPS, '<'+strPrefixo+'Tipo>', '</'+strPrefixo+'Tipo>');
  if ( strPrefixo = '') then
  begin
    cdsNFS.FieldByName('EMIRPS').AsString := Copy(RetornaTexto(strRPS, '<'+strPrefixo+'DataEmissao>', '</'+strPrefixo+'DataEmissao>'), 9, 2)+'/'+
                                             Copy(RetornaTexto(strRPS, '<'+strPrefixo+'DataEmissao>', '</'+strPrefixo+'DataEmissao>'), 6, 2)+'/'+
                                             Copy(RetornaTexto(strRPS, '<'+strPrefixo+'DataEmissao>', '</'+strPrefixo+'DataEmissao>'), 1, 4);
    cdsNFS.FieldByName('NATOPE').AsString := '1';
  end
  else
  begin
    cdsNFS.FieldByName('EMIRPS').AsString := Copy(RetornaTexto(strXML, '<'+strPrefixo+'DataEmissaoRps>', '</'+strPrefixo+'DataEmissaoRps>'), 9, 2)+'/'+
                                             Copy(RetornaTexto(strXML, '<'+strPrefixo+'DataEmissaoRps>', '</'+strPrefixo+'DataEmissaoRps>'), 6, 2)+'/'+
                                             Copy(RetornaTexto(strXML, '<'+strPrefixo+'DataEmissaoRps>', '</'+strPrefixo+'DataEmissaoRps>'), 1, 4);
    cdsNFS.FieldByName('NATOPE').AsString := RetornaTexto(strXML, '<'+strPrefixo+'NaturezaOperacao>', '</'+strPrefixo+'NaturezaOperacao>');
  end;

  cdsNFS.FieldByName('CODRET').AsString := RetornaTexto(strXML, '<'+strPrefixo+'RegimeEspecialTributacao>', '</'+strPrefixo+'RegimeEspecialTributacao>');
  cdsNFS.FieldByName('EMIOSN').AsString := RetornaTexto(strXML, '<'+strPrefixo+'OptanteSimplesNacional>', '</'+strPrefixo+'OptanteSimplesNacional>');
  cdsNFS.FieldByName('EMIICC').AsString := RetornaTexto(strXML, '<'+strPrefixo+'IncentivadorCultural>', '</'+strPrefixo+'IncentivadorCultural>');
  cdsNFS.FieldByName('COMPET').AsString := RetornaTexto(strXML, '<'+strPrefixo+'Competencia>', '</'+strPrefixo+'Competencia>');
  cdsNFS.FieldByName('NFSSUB').AsString := '';
  cdsNFS.FieldByName('OUTINF').AsString := RetornaTexto(strXML, '<'+strPrefixo+'OutrasInformacoes>', '</'+strPrefixo+'OutrasInformacoes>');

  strDetalhesDoServico := RetornaTexto(strXML, '<'+strPrefixo+'Servico>', '</'+strPrefixo+'Servico>');
  cdsNFS.FieldByName('CODSER').AsString := RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+'ItemListaServico>', '</'+strPrefixo+'ItemListaServico>');
  cdsNFS.FieldByName('CDCNAE').AsString := RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+'CodigoCnae>', '</'+strPrefixo+'CodigoCnae>');
  cdsNFS.FieldByName('CODTRI').AsString := RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+'CodigoTributacaoMunicipio>', '</'+strPrefixo+'CodigoTributacaoMunicipio>');
  cdsNFS.FieldByName('DISCRI').AsString := RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+'Discriminacao>', '</'+strPrefixo+'Discriminacao>');
  cdsNFS.FieldByName('MUNPRE').AsString := RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+'MunicipioPrestacaoServico>', '</'+strPrefixo+'MunicipioPrestacaoServico>');
  cdsNFS.FieldByName('VLRSER').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+'ValorServicos>', '</'+strPrefixo+'ValorServicos>'),'.',','), 0);
  cdsNFS.FieldByName('VLRDED').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+'ValorDeducoes>', '</'+strPrefixo+'ValorDeducoes>'),'.',','), 0);
  cdsNFS.FieldByName('VLRPIS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+'ValorPis>', '</'+strPrefixo+'ValorPis>'),'.',','), 0);
  cdsNFS.FieldByName('VLRCOF').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+'ValorCofins>', '</'+strPrefixo+'ValorCofins>'),'.',','), 0);
  cdsNFS.FieldByName('VLRINS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+'ValorInss>', '</'+strPrefixo+'ValorInss>'),'.',','), 0);
  cdsNFS.FieldByName('VLRIR_').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+'ValorIr>', '</'+strPrefixo+'ValorIr>'),'.',','), 0);
  cdsNFS.FieldByName('VLRCSL').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+'ValorCsll>', '</'+strPrefixo+'ValorCsll>'),'.',','), 0);
  cdsNFS.FieldByName('VALPIS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+'ValorPis>', '</'+strPrefixo+'ValorPis>'),'.',','), 0);
  cdsNFS.FieldByName('VALCOF').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+'ValorCofins>', '</'+strPrefixo+'ValorCofins>'),'.',','), 0);
  cdsNFS.FieldByName('VALINS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+'ValorInss>', '</'+strPrefixo+'ValorInss>'),'.',','), 0);
  cdsNFS.FieldByName('VALIRR').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+'ValorIr>', '</'+strPrefixo+'ValorIr>'),'.',','), 0);
  cdsNFS.FieldByName('VALCSL').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+'ValorCsll>', '</'+strPrefixo+'ValorCsll>'),'.',','), 0);
  cdsNFS.FieldByName('ISS_RET').AsString := RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+'IssRetido>', '</'+strPrefixo+'IssRetido>');
  cdsNFS.FieldByName('OUT_RET').AsFloat := 0;
  cdsNFS.FieldByName('BSCISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+'BaseCalculo>', '</'+strPrefixo+'BaseCalculo>'),'.',','), 0);
  if ( strPrefixo = '') then
  begin
    cdsNFS.FieldByName('ALIISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<'+strPrefixo+'Aliquota>', '</'+strPrefixo+'Aliquota>'),'.',','), 0);
    cdsNFS.FieldByName('VLRLIQ').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<'+strPrefixo+'ValorLiquidoNfse>', '</'+strPrefixo+'ValorLiquidoNfse>'),'.',','), 0);
    cdsNFS.FieldByName('VLRISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<'+strPrefixo+'ValorIss>', '</'+strPrefixo+'ValorIss>'),'.',','), 0);
    If RetornaTexto(strXML, '<'+strPrefixo+'IssRetido>', '</'+strPrefixo+'IssRetido>') = '1' then
      cdsNFS.FieldByName('VLISSR').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<'+strPrefixo+'ValorIssRetido>', '</'+strPrefixo+'ValorIssRetido>'),'.',','), 0)
    else
      cdsNFS.FieldByName('VLISSR').AsFloat := 0;
  end
  else
  begin
    cdsNFS.FieldByName('ALIISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+'Aliquota>', '</'+strPrefixo+'Aliquota>'),'.',','), 0);
    cdsNFS.FieldByName('VLRLIQ').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+'ValorLiquidoNfse>', '</'+strPrefixo+'ValorLiquidoNfse>'),'.',','), 0);
    cdsNFS.FieldByName('VLRISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+'ValorIss>', '</'+strPrefixo+'ValorIss>'),'.',','), 0);
    If RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+'IssRetido>', '</'+strPrefixo+'IssRetido>') = '1' then
      cdsNFS.FieldByName('VLISSR').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+'ValorIssRetido>', '</'+strPrefixo+'ValorIssRetido>'),'.',','), 0)
    Else
      cdsNFS.FieldByName('VLISSR').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+'ValorIss>', '</'+strPrefixo+'ValorIss>'),'.',','), 0);
  end;

  cdsNFS.FieldByName('DESCONC').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+'DescontoCondicionado>', '</'+strPrefixo+'DescontoCondicionado>'),'.',','), 0);
  cdsNFS.FieldByName('DESCONI').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+'DescontoIncondicionado>', '</'+strPrefixo+'DescontoIncondicionado>'),'.',','), 0);

  strDadosPrestador := RetornaTexto(strXML, '<'+strPrefixo+'PrestadorServico>', '</'+strPrefixo+'PrestadorServico>');
  strEndPrestador := RetornaTexto(strDadosPrestador, '<'+strPrefixo+'Endereco>', '<'+strPrefixo+'Contato>');
  strCnpjPrestador := RetornaTexto(strXML, '<'+strPrefixo+'Prestador>', '</'+strPrefixo+'Prestador>');

  cdsNFS.FieldByName('PSVCNPJ').AsString := RetornaTexto(strCnpjPrestador, '<'+strPrefixo+'Cnpj>', '</'+strPrefixo+'Cnpj>');
  cdsNFS.FieldByName('PSVIM').AsString := RetornaTexto(strCnpjPrestador, '<'+strPrefixo+'InscricaoMunicipal>', '</'+strPrefixo+'InscricaoMunicipal>');
  cdsNFS.FieldByName('PSVRAZAO').AsString := RetornaTexto(strDadosPrestador, '<'+strPrefixo+'RazaoSocial>', '</'+strPrefixo+'RazaoSocial>');
  cdsNFS.FieldByName('PSVFANT').AsString := '';
  cdsNFS.FieldByName('PSVEND').AsString := RetornaTexto(strEndPrestador, '<'+strPrefixo+'Endereco>', '</'+strPrefixo+'Endereco>');
  cdsNFS.FieldByName('PSVNUM').AsString := RetornaTexto(strDadosPrestador, '<'+strPrefixo+'Numero>', '</'+strPrefixo+'Numero>');
  cdsNFS.FieldByName('PSVCOMPL').AsString := RetornaTexto(strDadosPrestador, '<'+strPrefixo+'Complemento>', '</'+strPrefixo+'Complemento>');
  cdsNFS.FieldByName('PSVBAIR').AsString := RetornaTexto(strDadosPrestador, '<'+strPrefixo+'Bairro>', '</'+strPrefixo+'Bairro>');
  cdsNFS.FieldByName('PSVMUN').AsString := RetornaTexto(strDadosPrestador, '<'+strPrefixo+'Cidade>', '</'+strPrefixo+'Cidade>');
  cdsNFS.FieldByName('PSVUF').AsString := RetornaTexto(strDadosPrestador, '<'+strPrefixo+'Uf>', '</'+strPrefixo+'Uf>');
  cdsNFS.FieldByName('PSVCEP').AsString := RetornaTexto(strDadosPrestador, '<'+strPrefixo+'Cep>', '</'+strPrefixo+'Cep>');
  cdsNFS.FieldByName('PSVFONE').AsString := RetornaTexto(strDadosPrestador, '<'+strPrefixo+'Telefone>', '</'+strPrefixo+'Telefone>');
  cdsNFS.FieldByName('PSVEMAIL').AsString := RetornaTexto(strDadosPrestador, '<'+strPrefixo+'Email>', '</'+strPrefixo+'Email>');

  strDadosTomador := RetornaTexto(strXML, '<'+strPrefixo+'TomadorServico>', '</'+strPrefixo+'TomadorServico>');
  strEndTomador := RetornaTexto(strDadosTomador, '<'+strPrefixo+'Endereco>', '<'+strPrefixo+'Contato>');
  if fEmptyStr(strEndTomador) then
    strEndTomador := RetornaTexto(strDadosTomador, '<'+strPrefixo+'Endereco>', '<'+strPrefixo+'Contato/>');

  cdsNFS.FieldByName('TMSCNPJ').AsString := iif(RetornaTexto(strDadosTomador, '<'+strPrefixo+'Cnpj>', '</'+strPrefixo+'Cnpj>') = '',
                                                RetornaTexto(strDadosTomador, '<'+strPrefixo+'Cpf>', '</'+strPrefixo+'Cpf>'),
                                                RetornaTexto(strDadosTomador, '<'+strPrefixo+'Cnpj>', '</'+strPrefixo+'Cnpj>'));
  cdsNFS.FieldByName('TMSIM').AsString := '';
  cdsNFS.FieldByName('TMSRAZAO').AsString := RetornaTexto(strDadosTomador, '<'+strPrefixo+'RazaoSocial>', '</'+strPrefixo+'RazaoSocial>');
  cdsNFS.FieldByName('TMSEND').AsString := RetornaTexto(strEndTomador, '<'+strPrefixo+'Endereco>', '</'+strPrefixo+'Endereco>');
  cdsNFS.FieldByName('TMSNUM').AsString := RetornaTexto(strDadosTomador, '<'+strPrefixo+'Numero>', '</'+strPrefixo+'Numero>');
  cdsNFS.FieldByName('TMSCOMPL').AsString := RetornaTexto(strDadosTomador, '<'+strPrefixo+'Complemento>', '</'+strPrefixo+'Complemento>');
  cdsNFS.FieldByName('TMSBAIR').AsString := RetornaTexto(strDadosTomador, '<'+strPrefixo+'Bairro>', '</'+strPrefixo+'Bairro>');
  cdsNFS.FieldByName('TMSMUN').AsString := RetornaTexto(strDadosTomador, '<'+strPrefixo+'Cidade>', '</'+strPrefixo+'Cidade>');
  cdsNFS.FieldByName('TMSUF').AsString := RetornaTexto(strDadosTomador, '<'+strPrefixo+'Estado>', '</'+strPrefixo+'Estado>');
  cdsNFS.FieldByName('TMSCEP').AsString := RetornaTexto(strDadosTomador, '<'+strPrefixo+'Cep>', '</'+strPrefixo+'Cep>');
  cdsNFS.FieldByName('TMSFONE').AsString := RetornaTexto(strDadosTomador, '<'+strPrefixo+'Telefone>', '</'+strPrefixo+'Telefone>');
  cdsNFS.FieldByName('TMSEMAIL').AsString := RetornaTexto(strDadosTomador, '<'+strPrefixo+'Email>', '</'+strPrefixo+'Email>');

  strOrgaoGerador := RetornaTexto(strXML, '<'+strPrefixo+'OrgaoGerador>', '</'+strPrefixo+'OrgaoGerador>');
  cdsNFS.FieldByName('ORGMUN').AsString := RetornaTexto(strOrgaoGerador, '<'+strPrefixo+'CodigoMunicipio>', '</'+strPrefixo+'CodigoMunicipio>');
  cdsNFS.FieldByName('MUNINC').AsString := RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+'MunicipioIncidencia>', '</'+strPrefixo+'MunicipioIncidencia>');
  cdsNFS.FieldByName('EXIGIB').AsString := RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+'ExigibilidadeISS>', '</'+strPrefixo+'ExigibilidadeISS>');
  cdsNFS.FieldByName('ORG_UF').AsString := RetornaTexto(strOrgaoGerador, '<'+strPrefixo+'Uf>', '</'+strPrefixo+'Uf>');
  cdsNFS.FieldByName('INFCOM').AsString := '';
  cdsNFS.FieldByName('CD_NBS').AsString := RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+'CodigoNbs>', '</'+strPrefixo+'CodigoNbs>');
  cdsNFS.Post;

  if (strCidadeNFSe = 'PREFEITURA DE AGUAÍ-SP') then
  begin

    strDiscriminacaoServico := RetornaTexto(strXML, '<'+strPrefixo+'Discriminacao>', '</'+strPrefixo+'Discriminacao>');

    cdsItens.Insert;
    cdsItens.FieldByName('CODSER').asString := RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+'ItemListaServico>', '</'+strPrefixo+'ItemListaServico>');
    cdsItens.FieldByName('ITEDES').asString := RetornaTexto(strDiscriminacaoServico, '[Descricao=', ']');
    cdsItens.FieldByName('VLRUNT').asFloat  := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDiscriminacaoServico, '][ValorUnitario=', '][ValorServico='),'.',','), 0);
    cdsItens.FieldByName('ITEQTD').asFloat  := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDiscriminacaoServico, '][Quantidade=', '][ValorUnitario='),'.',','), 0);
    cdsItens.FieldByName('VLRSRV').asFloat  := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+'ValorServicos>', '</'+strPrefixo+'ValorServicos>'),'.',','), 0);
    cdsItens.FieldByName('BASCAL').asFloat  := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+'BaseCalculo>', '</'+strPrefixo+'BaseCalculo>'),'.',','), 0);
    cdsItens.FieldByName('ALIISS').asFloat  := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<'+strPrefixo+'Aliquota>', '</'+strPrefixo+'Aliquota>'),'.',','), 0);
    cdsItens.FieldByName('VLRISS').asFloat  := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<'+strPrefixo+'ValorIss>', '</'+strPrefixo+'ValorIss>'),'.',','), 0);
    cdsItens.Post;
  end;

end;

end.
