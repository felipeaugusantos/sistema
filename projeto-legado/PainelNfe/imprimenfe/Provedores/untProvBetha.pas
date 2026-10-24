unit untProvBetha;

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
  TProvBetha = class
    private
    public

      class function fRetDiscriminacaoServico( strItem: String ): String;
      class procedure pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string);


  end;

implementation

{ TProvBetha }

class function TProvBetha.fRetDiscriminacaoServico(strItem: String): String;
var
  strDiscriminacao: string;
  intLaco: integer;
begin
  result := '';
  if fEmptyStr(strItem) then
    exit;
  //{[[Descricao=TROCA DE COMPONENTES MONO.nRealizado do capacitor 2200uf/35V. Verificacao geral e testes.][ItemServico=1402][Quantidade=1][ValorUnitario=45][ValorServico=45][ValorBaseCalculo=45][Aliquota=5][Deducoes=0][DescontoIncondicionado=0]]}
  for intLaco := 14 to Length(strItem)-1 do
  begin
    if (Copy(strItem,intLaco,1) <> ']') then
    begin
      strDiscriminacao := strDiscriminacao + Copy(strItem,intLaco,1) ;
    end
    else
    begin
      break;
    end;
  end;
  result := strDiscriminacao;
end;

class procedure TProvBetha.pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string);
var
  XmlDoc : IXMLDocument;

  XmlNodePrincipal,
  XmlNodeInfDecPresServ,
  XmlNodeInfDecPresServServ,
  XmlNodeDecPresServValServ: IXMLNode;

begin
  xmlDoc := TXMLDocument.Create(Application);

  xmlDoc.LoadFromXML(strXML);
  xmlDoc.Active := True;

  XmlNodePrincipal := XmlDoc.ChildNodes['Nfse']
                            .ChildNodes['InfNfse'];

  XmlNodeInfDecPresServ := XmlNodePrincipal.ChildNodes['DeclaracaoPrestacaoServico']
                                           .ChildNodes['InfDeclaracaoPrestacaoServico'];

  XmlNodeInfDecPresServServ := XmlNodeInfDecPresServ.ChildNodes['Servico'];
  XmlNodeDecPresServValServ := XmlNodeInfDecPresServServ.ChildNodes['Valores'];

    cdsNFS.Append;

    cdsNFS.FieldByName('NUMRPS').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes.FindNode('Numero'));
    cdsNFS.FieldByName('SERRPS').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes.FindNode('Serie'));
    cdsNFS.FieldByName('EMIRPS').AsString := Copy(fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Rps'].ChildNodes.FindNode('DataEmissao')),9,2)+'/'+
                                             Copy(fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Rps'].ChildNodes.FindNode('DataEmissao')),6,2)+'/'+
                                             Copy(fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Rps'].ChildNodes.FindNode('DataEmissao')),1,4);
    cdsNFS.FieldByName('NUMNFS').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('Numero'));
    cdsNFS.FieldByName('SERIE').AsString := 'E';
    cdsNFS.FieldByName('DTAEMI').AsString := Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DataEmissao')),9,2)+'/'+
                                             Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DataEmissao')),6,2)+'/'+
                                             Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DataEmissao')),1,4);
    cdsNFS.FieldByName('DTAHRA').AsString := Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DataEmissao')),12,19);
    cdsNFS.FieldByName('COMPET').AsString := Copy(fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes.FindNode('Competencia')),9,2)+'/'+
                                             Copy(fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes.FindNode('Competencia')),6,2)+'/'+
                                             Copy(fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes.FindNode('Competencia')),1,4);
    cdsNFS.FieldByName('CODVER').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('CodigoVerificacao'));
    cdsNFS.FieldByName('OUTINF').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('OutrasInformacoes'));
    cdsNFS.FieldByName('CODSER').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Servico'].ChildNodes.FindNode('ItemListaServico'));
    cdsNFS.FieldByName('CDCNAE').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Servico'].ChildNodes.FindNode('CodigoCnae'));
    cdsNFS.FieldByName('NATOPE').AsString := '';

    cdsNFS.FieldByName('PSVCNPJ').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['IdentificacaoPrestador'].ChildNodes['CpfCnpj'].ChildNodes.FindNode('Cnpj'));
    cdsNFS.FieldByName('PSVIM').AsString    := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['IdentificacaoPrestador'].ChildNodes.FindNode('InscricaoMunicipal'));
    cdsNFS.FieldByName('PSVRAZAO').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes.FindNode('RazaoSocial'));
    cdsNFS.FieldByName('PSVFANT').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes.FindNode('NomeFantasia'));
    cdsNFS.FieldByName('PSVEND').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes.FindNode('Endereco'));
    cdsNFS.FieldByName('PSVNUM').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes.FindNode('Numero'));
    cdsNFS.FieldByName('PSVCOMPL').AsString := '';
    cdsNFS.FieldByName('PSVBAIR').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes.FindNode('Bairro'));
    cdsNFS.FieldByName('PSVMUN').AsString   := '';
    cdsNFS.FieldByName('PSVUF').AsString    := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes.FindNode('Uf'));
    cdsNFS.FieldByName('PSVCEP').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes.FindNode('Cep'));
    cdsNFS.FieldByName('PSVFONE').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes.FindNode('Telefone'));
    cdsNFS.FieldByName('PSVEMAIL').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes.FindNode('Email'));

    cdsNFS.FieldByName('TMSCNPJ').AsString  := Iif(fEmptyStr(fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes.FindNode('Cnpj'))),
                                                             fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes.FindNode('Cpf')),
                                                             fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes.FindNode('Cnpj')));
    cdsNFS.FieldByName('TMSIM').AsString    := '';
    cdsNFS.FieldByName('TMSRAZAO').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Tomador'].ChildNodes.FindNode('RazaoSocial'));
    cdsNFS.FieldByName('TMSEND').AsString   := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes.FindNode('Endereco'));
    cdsNFS.FieldByName('TMSNUM').AsString   := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes.FindNode('Numero'));
    cdsNFS.FieldByName('TMSCOMPL').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes.FindNode('Complemento'));
    cdsNFS.FieldByName('TMSBAIR').AsString  := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes.FindNode('Bairro'));
    cdsNFS.FieldByName('TMSMUN').AsString   := '';
    cdsNFS.FieldByName('TMSUF').AsString    := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes.FindNode('Uf'));
    cdsNFS.FieldByName('TMSCEP').AsString   := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes.FindNode('Cep'));
    cdsNFS.FieldByName('TMSFONE').AsString  := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Tomador'].ChildNodes['Contato'].ChildNodes.FindNode('Telefone'));
    cdsNFS.FieldByName('TMSEMAIL').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Tomador'].ChildNodes['Contato'].ChildNodes.FindNode('Email'));

    cdsNFS.FieldByName('DISCRI').AsString := fRetDiscriminacaoServico(fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Servico'].ChildNodes.FindNode('Discriminacao')));
    cdsNFS.FieldByName('DESSER').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Servico'].ChildNodes.FindNode('Discriminacao'));
    cdsNFS.FieldByName('ISS_RET').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Servico'].ChildNodes.FindNode('IssRetido'));

    cdsNFS.FieldByName('VLRSER').AsFloat  := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes.FindNode('ValorServicos')),'.',','), 0);
    cdsNFS.FieldByName('VLRISS').AsFloat  := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ValoresNfse'].ChildNodes.FindNode('ValorIss')),'.',','), 0);
    cdsNFS.FieldByName('BSCISS').AsFloat  := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ValoresNfse'].ChildNodes.FindNode('BaseCalculo')),'.',','), 0);
    cdsNFS.FieldByName('ALIISS').AsFloat  := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ValoresNfse'].ChildNodes.FindNode('Aliquota')),'.',','), 0);
    cdsNFS.FieldByName('VLRLIQ').AsFloat  := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ValoresNfse'].ChildNodes.FindNode('ValorLiquidoNfse')),'.',','), 0);
    cdsNFS.FieldByName('VALPIS').AsFloat  := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes.FindNode('ValorPis')),'.',','), 0);
    cdsNFS.FieldByName('VALCOF').AsFloat  := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes.FindNode('ValorCofins')),'.',','), 0);
    cdsNFS.FieldByName('VALIRR').AsFloat  := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes.FindNode('ValorIr')),'.',','), 0);
    cdsNFS.FieldByName('VALINS').AsFloat  := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes.FindNode('ValorInss')),'.',','), 0);
    cdsNFS.FieldByName('VALCSL').AsFloat  := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes.FindNode('ValorCsll')),'.',','), 0);
    cdsNFS.FieldByName('DESCONC').AsFloat := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes.FindNode('DescontoCondicionado')),'.',','), 0);
    cdsNFS.FieldByName('DESCONI').AsFloat := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes.FindNode('DescontoIncondicionado')),'.',','), 0);
    cdsNFS.FieldByName('VLRDED').AsFloat  := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes.FindNode('ValorDeducoes')),'.',','), 0);
    cdsNFS.FieldByName('OUT_RET').AsFloat := 0;

    cdsNFS.FieldByName('MUNPRE').AsString := '';
    cdsNFS.Post;

end;

end.