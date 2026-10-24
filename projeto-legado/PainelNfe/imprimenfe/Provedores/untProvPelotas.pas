unit untProvPelotas;

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
  TProvPelotas = class

    private

    public

      class procedure pCarregaNoPrincipal( strXML : string; var NoElemento: IXMLNode );
      class procedure pCarregaNoInfNfse( NoElemento: IXMLNode; var NoInfNfse: IXMLNode );
      class procedure pCarregaNoDeclaracaoPrestacaoServico( NoInfNfse: IXMLNode; var NoDeclaracaoPrestacaoServico: IXMLNode );
      class procedure pCarregaNoInfDeclaracaoPrestacaoServico( NoDeclaracaoPrestacaoServico: IXMLNode; var NoInfDeclaracaoPrestacaoServico: IXMLNode );
      class procedure pCarregaNoRps( NoInfDeclaracaoPrestacaoServico: IXMLNode; var NoRps: IXMLNode );
      class procedure pCarregaNoServVal( NoInfDeclaracaoPrestacaoServico: IXMLNode; var NoServVal: IXMLNode);
      class procedure pCarregaNoTomadorServ( NoInfDeclaracaoPrestacaoServico: IXMLNode; var NoTomadorServ: IXMLNode);

      class procedure pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string);

  end;

var
  XmlDoc : IXMLDocument;

implementation

{ TProvPelotas }

class procedure TProvPelotas.pCarregaNoPrincipal( strXML : string; var NoElemento: IXMLNode );
begin

  XmlDoc := TXMLDocument.Create(Application);
  XmlDoc.LoadFromXML(strXML);
  XmlDoc.Active := True;

  NoElemento := XmlDoc.DocumentElement;

end;

class procedure TProvPelotas.pCarregaNoInfNfse( NoElemento: IXMLNode; var NoInfNfse: IXMLNode );
begin
  If not ( NoElemento = nil ) Then
  Begin
    NoInfNfse := NoElemento.childNodes.FindNode('InfNfse');
    If NoInfNfse = nil Then
      Raise Exception.Create('Estrutura XML inválida: InfNfse não encontrado.');
    NoInfNfse.ChildNodes.First;
  End;
end;

class procedure TProvPelotas.pCarregaNoDeclaracaoPrestacaoServico( NoInfNfse: IXMLNode; var NoDeclaracaoPrestacaoServico: IXMLNode );
begin
  If not ( NoInfNfse = nil ) Then
  Begin
    NoDeclaracaoPrestacaoServico := NoInfNfse.childNodes.FindNode('DeclaracaoPrestacaoServico');
    NoDeclaracaoPrestacaoServico.ChildNodes.First;
  End;
end;

class procedure TProvPelotas.pCarregaNoInfDeclaracaoPrestacaoServico( NoDeclaracaoPrestacaoServico: IXMLNode; var NoInfDeclaracaoPrestacaoServico: IXMLNode );
begin
  If not ( NoDeclaracaoPrestacaoServico = nil ) Then
  Begin
    NoInfDeclaracaoPrestacaoServico := NoDeclaracaoPrestacaoServico.childNodes.FindNode('InfDeclaracaoPrestacaoServico');
    NoInfDeclaracaoPrestacaoServico.ChildNodes.First;
  End;
end;

class procedure TProvPelotas.pCarregaNoRps( NoInfDeclaracaoPrestacaoServico: IXMLNode; var NoRps: IXMLNode );
begin
  If not ( NoInfDeclaracaoPrestacaoServico = nil ) Then
  Begin
    NoRps := NoInfDeclaracaoPrestacaoServico.childNodes.FindNode('Rps');
    NoRps.ChildNodes.First;
  End;
end;

class procedure TProvPelotas.pCarregaNoServVal(
  NoInfDeclaracaoPrestacaoServico: IXMLNode; var NoServVal: IXMLNode);
begin
  If not ( NoInfDeclaracaoPrestacaoServico = nil ) Then
  Begin
    NoServVal := NoInfDeclaracaoPrestacaoServico.ChildNodes.FindNode('Servico')
                                                .ChildNodes.FindNode('Valores');
    NoServVal.ChildNodes.First;
  End;
end;

class procedure TProvPelotas.pCarregaNoTomadorServ(
  NoInfDeclaracaoPrestacaoServico: IXMLNode; var NoTomadorServ: IXMLNode);
begin
  If not ( NoInfDeclaracaoPrestacaoServico = nil ) Then
  Begin
    NoTomadorServ := NoInfDeclaracaoPrestacaoServico.ChildNodes.FindNode('Tomador');
    NoTomadorServ.ChildNodes.First;
  End;
end;

class procedure TProvPelotas.pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string);
var
  NoChave,
  NoElemento,
  NoInfNfse,
  NoDeclaracaoPrestacaoServico,
  NoInfDeclaracaoPrestacaoServico,
  NoRps,
  NoServVal,
  NoTomadorServ : IXMLNode;
begin

  pCarregaNoPrincipal( strXML, NoElemento );
  pCarregaNoInfNfse( NoElemento, NoInfNfse );
  pCarregaNoDeclaracaoPrestacaoServico( NoInfNfse, NoDeclaracaoPrestacaoServico );
  pCarregaNoInfDeclaracaoPrestacaoServico( NoDeclaracaoPrestacaoServico, NoInfDeclaracaoPrestacaoServico );
  pCarregaNoRps( NoInfDeclaracaoPrestacaoServico, NoRps );
  pCarregaNoServVal ( NoInfDeclaracaoPrestacaoServico, NoServVal );
  pCarregaNoTomadorServ( NoInfDeclaracaoPrestacaoServico, NoTomadorServ );

  cdsNFS.Append;
  try
    // Dados da NFS
    NoChave := NoInfNfse.ChildNodes.FindNode('ChaveValidacaoADN');
    if Assigned(NoChave) then
      cdsNFS.FieldByName('ChaveNFSeNacional').AsString := NoChave.Text;
    cdsNFS.FieldByName('NUMNFS').AsString := NoInfNfse.ChildNodes.FindNode('Numero').Text;
    cdsNFS.FieldByName('SERIE').AsString  := 'E';
    cdsNFS.FieldByName('CODVER').AsString := NoInfNfse.ChildNodes.FindNode('CodigoVerificacao').Text;
    cdsNFS.FieldByName('DTAHRA').AsString := Copy(NoInfNfse.ChildNodes.FindNode('DataEmissao').Text, 12, 8);
    cdsNFS.FieldByName('DTAEMI').AsString := Copy(NoInfNfse.ChildNodes.FindNode('DataEmissao').Text,9,2)+'/'+
                                             Copy(NoInfNfse.ChildNodes.FindNode('DataEmissao').Text,6,2)+'/'+
                                             Copy(NoInfNfse.ChildNodes.FindNode('DataEmissao').Text,1,4);
    cdsNFS.FieldByName('NUMRPS').AsString := NoRps.ChildNodes['IdentificacaoRps'].ChildNodes['Numero'].Text;
    cdsNFS.FieldByName('SERRPS').AsString := NoRps.ChildNodes['IdentificacaoRps'].ChildNodes['Serie'].Text;
    cdsNFS.FieldByName('TPORPS').AsString := NoRps.ChildNodes['IdentificacaoRps'].ChildNodes['Tipo'].Text;
    cdsNFS.FieldByName('EMIRPS').AsString := Copy(NoRps.ChildNodes['DataEmissao'].Text,9,2)+'/'+
                                             Copy(NoRps.ChildNodes['DataEmissao'].Text,6,2)+'/'+
                                             Copy(NoRps.ChildNodes['DataEmissao'].Text,1,4);
    cdsNFS.FieldByName('NATOPE').AsString := '';
    cdsNFS.FieldByName('CODRET').AsString := '';
    cdsNFS.FieldByName('EMIOSN').AsString := NoInfDeclaracaoPrestacaoServico.ChildNodes['OptanteSimplesNacional'].Text;
    cdsNFS.FieldByName('EMIICC').AsString := NoInfDeclaracaoPrestacaoServico.ChildNodes['IncentivoFiscal'].Text;
    cdsNFS.FieldByName('COMPET').AsString := Copy(NoInfDeclaracaoPrestacaoServico.ChildNodes['Competencia'].Text, 1, 4) +
                                             Copy(NoInfDeclaracaoPrestacaoServico.ChildNodes['Competencia'].Text, 6, 2);
    cdsNFS.FieldByName('OUTINF').AsString := '';
    cdsNFS.FieldByName('ORGMUN').AsString := NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['MunicipioIncidencia'].Text;
    cdsNFS.FieldByName('ORG_UF').AsString := '';
    cdsNFS.FieldByName('_LINK_').AsString := '';

    //Valores
    cdsNFS.FieldByName('VLRSER').AsFloat  := StrToFloatDef(AnsiReplaceStr(NoServVal.ChildNodes['ValorServicos'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRDED').AsFloat  := StrToFloatDef(AnsiReplaceStr(NoServVal.ChildNodes['ValorDeducoes'].Text,'.',','), 0);
    cdsNFS.FieldByName('VALPIS').AsFloat  := StrToFloatDef(AnsiReplaceStr(NoServVal.ChildNodes['ValorPis'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRCOF').AsFloat  := StrToFloatDef(AnsiReplaceStr(NoServVal.ChildNodes['ValorCofins'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRINS').AsFloat  := StrToFloatDef(AnsiReplaceStr(NoServVal.ChildNodes['ValorInss'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRIR_').AsFloat  := StrToFloatDef(AnsiReplaceStr(NoServVal.ChildNodes['ValorIr'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRCSL').AsFloat  := StrToFloatDef(AnsiReplaceStr(NoServVal.ChildNodes['ValorCsll'].Text,'.',','), 0);
    cdsNFS.FieldByName('OUT_RET').AsFloat := StrToFloatDef(AnsiReplaceStr(NoServVal.ChildNodes['OutrasRetencoes'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRISS').AsFloat  := StrToFloatDef(AnsiReplaceStr(NoServVal.ChildNodes['ValorIss'].Text,'.',','), 0);
    cdsNFS.FieldByName('DESCONI').AsFloat := StrToFloatDef(AnsiReplaceStr(NoServVal.ChildNodes['DescontoIncondicionado'].Text,'.',','), 0);
    cdsNFS.FieldByName('DESCONC').AsFloat := StrToFloatDef(AnsiReplaceStr(NoServVal.ChildNodes['DescontoCondicionado'].Text,'.',','), 0);

    cdsNFS.FieldByName('ISS_RET').AsFloat  := StrToFloatDef(AnsiReplaceStr(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['IssRetido'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRISS').AsFloat   := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['ValoresNfse'].ChildNodes['ValorIss'].Text,'.',','), 0);
    cdsNFS.FieldByName('BSCISS').AsFloat   := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['ValoresNfse'].ChildNodes['BaseCalculo'].Text,'.',','), 0);
    cdsNFS.FieldByName('ALIISS').AsFloat   := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['ValoresNfse'].ChildNodes['Aliquota'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRLIQ').AsFloat   := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['ValoresNfse'].ChildNodes['ValorLiquidoNfse'].Text,'.',','), 0);
    cdsNFS.FieldByName('CODSER').AsString  := NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['ItemListaServico'].Text;
    cdsNFS.FieldByName('CDCNAE').AsString  := NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['CodigoCnae'].Text;
    cdsNFS.FieldByName('CODTRI').AsString  := '';
    cdsNFS.FieldByName('DISCRI').AsString  := NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['Discriminacao'].Text;
    cdsNFS.FieldByName('CODMUN').AsString  := NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['CodigoMunicipio'].Text;
    cdsNFS.FieldByName('ITEDESC').AsString := '';
    cdsNFS.FieldByName('ITEQTD').AsFloat   := 0;
    cdsNFS.FieldByName('ITEVLU').AsFloat   := 0;
    cdsNFS.FieldByName('EXIGIB').AsString  := NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['ExigibilidadeISS'].Text;

    //Prestador
    cdsNFS.FieldByName('PSVCNPJ').AsString  := NoInfDeclaracaoPrestacaoServico.ChildNodes['Prestador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text;
    cdsNFS.FieldByName('PSVIM').AsString    := NoInfDeclaracaoPrestacaoServico.ChildNodes['Prestador'].ChildNodes['InscricaoMunicipal'].Text;
    cdsNFS.FieldByName('PSVRAZAO').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['RazaoSocial'].Text;
    cdsNFS.FieldByName('PSVFANT').AsString  := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['NomeFantasia'].Text;
    cdsNFS.FieldByName('PSVEND').AsString   := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
    cdsNFS.FieldByName('PSVNUM').AsString   := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Numero'].Text;
    cdsNFS.FieldByName('PSVCOMPL').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Complemento'].Text;
    cdsNFS.FieldByName('PSVBAIR').AsString  := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
    cdsNFS.FieldByName('PSVMUN').AsString   := '';
    cdsNFS.FieldByName('PSVUF').AsString    := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Uf'].Text;
    cdsNFS.FieldByName('PSVCEP').AsString   := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Cep'].Text;
    cdsNFS.FieldByName('PSVFONE').AsString  := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Telefone'].Text;
    cdsNFS.FieldByName('PSVEMAIL').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Email'].Text;

    //Tomador
    cdsNFS.FieldByName('TMSCNPJ').AsString  := Iif(fEmptyStr(NoTomadorServ.ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text),
                                                             NoTomadorServ.ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cpf'].Text,
                                                             NoTomadorServ.ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text);
    cdsNFS.FieldByName('TMSIM').AsString    := '';
    cdsNFS.FieldByName('TMSRAZAO').AsString := NoTomadorServ.ChildNodes['RazaoSocial'].Text;
    cdsNFS.FieldByName('TMSFANTA').AsString := NoTomadorServ.ChildNodes['NomeFantasia'].Text;
    cdsNFS.FieldByName('TMSEND').AsString   := NoTomadorServ.ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
    cdsNFS.FieldByName('TMSNUM').AsString   := NoTomadorServ.ChildNodes['Endereco'].ChildNodes['Numero'].Text;
    cdsNFS.FieldByName('TMSCOMPL').AsString := NoTomadorServ.ChildNodes['Endereco'].ChildNodes['Complemento'].Text;
    cdsNFS.FieldByName('TMSBAIR').AsString  := NoTomadorServ.ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
    cdsNFS.FieldByName('TMSMUN').AsString   := '';
    cdsNFS.FieldByName('TMSUF').AsString    := NoTomadorServ.ChildNodes['Endereco'].ChildNodes['Uf'].Text;
    cdsNFS.FieldByName('TMSCEP').AsString   := NoTomadorServ.ChildNodes['Endereco'].ChildNodes['Cep'].Text;
    cdsNFS.FieldByName('TMSFONE').AsString  := NoTomadorServ.ChildNodes['Contato'].ChildNodes['Telefone'].Text;
    cdsNFS.FieldByName('TMSEMAIL').AsString := NoTomadorServ.ChildNodes['Contato'].ChildNodes['Email'].Text;

    cdsNFS.Post;
  except
    cdsNFS.Cancel;
    raise;
  end;

end;

end.

