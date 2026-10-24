unit untTubaraoXML;

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
  TTubaraoXML = class

    private

    public
      class procedure pCarregaNodDadosNfseResposta(XmlDoc: TXMLDocument);
      class procedure pCarregaNodDadosNfse(NodDadosNfseResposta: IXMLNode);
      class procedure pCarregaNodPrestador(NodDadosNfse: IXMLNode);
      class procedure pCarregaNodTomador(NodDadosNfse: IXMLNode);
      class procedure pCarregaNodServicos(NodDadosNfse: IXMLNode);
      class procedure pCarregaNodValores(NodDadosNfse: IXMLNode);

      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS, cdsItens: TUniClientDataSet; strXML: string);
  end;

var
  nodDadosNfseResposta,
  nodDadosNfse,
  nodPrestador,
  nodTomador,
  nodServicos,
  nodValores  : IXMLNode;

implementation

class procedure TTubaraoXML.pCarregaNodDadosNfseResposta(XmlDoc: TXMLDocument);
begin
  nodDadosNfseResposta := XmlDoc.DocumentElement;
end;

class procedure TTubaraoXML.pCarregaNodDadosNfse(NodDadosNfseResposta: IXMLNode);
begin
  If ( NodDadosNfseResposta <> nil ) Then
  Begin
    nodDadosNfse := NodDadosNfseResposta.childNodes.FindNode('DadosNfse');
  End;
end;

class procedure TTubaraoXML.pCarregaNodPrestador(NodDadosNfse: IXMLNode);
begin
  If ( NodDadosNfse <> nil ) Then
  Begin
    nodPrestador := NodDadosNfse.childNodes.FindNode('Prestador');
  End;
end;

class procedure TTubaraoXML.pCarregaNodTomador(NodDadosNfse: IXMLNode);
begin
  If ( NodDadosNfse <> nil ) Then
  Begin
    nodTomador := NodDadosNfse.childNodes.FindNode('Tomador');
  End;
end;

class procedure TTubaraoXML.pCarregaNodServicos(NodDadosNfse: IXMLNode);
begin
  If ( NodDadosNfse <> nil ) Then
  Begin
    nodServicos := NodDadosNfse.childNodes.FindNode('Servicos');
  End;
end;

class procedure TTubaraoXML.pCarregaNodValores(NodDadosNfse: IXMLNode);
begin
  If ( NodDadosNfse <> nil ) Then
  Begin
    nodValores := NodDadosNfse.childNodes.FindNode('Valores');
  End;
end;

class procedure TTubaraoXML.pRetornaCDSPreenchidoComENotas(var cdsNFS, cdsItens: TUniClientDataSet; strXML: string);
var
  xmlDoc : TXMLDocument;
begin

  xmlDoc := TXMLDocument.Create(Application);

  try
    xmlDoc.LoadFromXML(strXML);
    xmlDoc.Active := True;

    pCarregaNodDadosNfseResposta( xmlDoc );
    pCarregaNodDadosNfse( nodDadosNfseResposta );
    pCarregaNodPrestador(nodDadosNfse);
    pCarregaNodTomador(nodDadosNfse);
    pCarregaNodServicos(nodDadosNfse);
    pCarregaNodValores(nodDadosNfse);

    cdsNFS.Append;

    cdsNFS.FieldByName('NUMNFS').AsString := nodDadosNfse.ChildNodes['NumeroNfse'].Text;
    cdsNFS.FieldByName('CODVER').AsString := nodDadosNfse.ChildNodes['CodigoValidacao'].Text;
    cdsNFS.FieldByName('DTAHRA').AsString := Copy(nodDadosNfse.ChildNodes['DataEmissao'].Text, 12, 8);
    cdsNFS.FieldByName('DTAEMI').AsString := Copy(nodDadosNfse.ChildNodes['DataEmissao'].Text,9,2)+'/'+
                                             Copy(nodDadosNfse.ChildNodes['DataEmissao'].Text,6,2)+'/'+
                                             Copy(nodDadosNfse.ChildNodes['DataEmissao'].Text,1,4);
    cdsNFS.FieldByName('NUMRPS').AsString := '';
    cdsNFS.FieldByName('SERRPS').AsString := '';
    cdsNFS.FieldByName('TPORPS').AsString := '';
    cdsNFS.FieldByName('EMIRPS').AsString := '';
    cdsNFS.FieldByName('NATOPE').AsString := '1';
    cdsNFS.FieldByName('CODRET').AsString := '';
    cdsNFS.FieldByName('EMIOSN').AsString := '';
    cdsNFS.FieldByName('EMIICC').AsString := '';
    cdsNFS.FieldByName('COMPET').AsString := nodDadosNfse.ChildNodes['Competencia'].Text;
    cdsNFS.FieldByName('OUTINF').AsString := nodDadosNfse.ChildNodes['Observacoes'].Text;

    cdsNFS.FieldByName('PSVCNPJ').AsString  := '';
    cdsNFS.FieldByName('PSVIM').AsString    := nodPrestador.ChildNodes['InscricaoMunicipal'].Text;
    cdsNFS.FieldByName('IEPRES').AsString   := '';
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

    cdsNFS.FieldByName('TMSCNPJ').AsString  := nodTomador.ChildNodes['NrDocumento'].Text;
    cdsNFS.FieldByName('TMSIM').AsString    := '';
    cdsNFS.FieldByName('TMSRAZAO').AsString := nodTomador.ChildNodes['RazaoSocial'].Text;
    cdsNFS.FieldByName('TMSEND').AsString   := nodTomador.childNodes.FindNode('Endereco').ChildNodes['Logradouro'].Text;
    cdsNFS.FieldByName('TMSNUM').AsString   := nodTomador.childNodes.FindNode('Endereco').ChildNodes['Numero'].Text;
    cdsNFS.FieldByName('TMSCOMPL').AsString := nodTomador.childNodes.FindNode('Endereco').ChildNodes['Complemento'].Text;
    cdsNFS.FieldByName('TMSBAIR').AsString  := nodTomador.childNodes.FindNode('Endereco').ChildNodes['Bairro'].Text;
    cdsNFS.FieldByName('TMSMUN').AsString   := nodTomador.childNodes.FindNode('Endereco').ChildNodes['Municipio'].Text;
    cdsNFS.FieldByName('TMSUF').AsString    := '';
    cdsNFS.FieldByName('TMSCEP').AsString   := nodTomador.childNodes.FindNode('Endereco').ChildNodes['Cep'].Text;
    cdsNFS.FieldByName('TMSFONE').AsString  := nodTomador.childNodes.FindNode('Contato').ChildNodes['Telefone'].Text;
    cdsNFS.FieldByName('TMSEMAIL').AsString := nodTomador.childNodes.FindNode('Contato').ChildNodes['Email'].Text;

    cdsNFS.FieldByName('VLRSER').AsFloat    := StrToFloatDef(AnsiReplaceStr(nodValores.ChildNodes['ValorServicos'].Text,'.',','), 0);

    cdsNFS.FieldByName('ISSRET').AsString   := nodDadosNfse.ChildNodes['IssRetido'].Text;
    If (cdsNFS.FieldByName('ISSRET').AsString = 'N') Then
      cdsNFS.FieldByName('ISS_RET').AsFloat := 2
    else
      cdsNFS.FieldByName('ISS_RET').AsFloat := 1;

    cdsNFS.FieldByName('VLRISS').AsFloat    := StrToFloatDef(AnsiReplaceStr(nodValores.ChildNodes['ValorIss'].Text,'.',','), 0);
    cdsNFS.FieldByName('BSCISS').AsFloat    := StrToFloatDef(AnsiReplaceStr(nodValores.ChildNodes['BaseCalculo'].Text,'.',','), 0);
    cdsNFS.FieldByName('ALIISS').AsFloat    := StrToFloatDef(AnsiReplaceStr(nodValores.ChildNodes['Aliquota'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRLIQ').AsFloat    := StrToFloatDef(AnsiReplaceStr(nodValores.ChildNodes['ValorLiquidoNota'].Text,'.',','), 0);
    cdsNFS.FieldByName('CODSER').AsString   := '';
    cdsNFS.FieldByName('CDCNAE').AsString   := '';
    cdsNFS.FieldByName('CNAEFI').AsString   := '';
    cdsNFS.FieldByName('CODTRI').AsString   := '';
    cdsNFS.FieldByName('DISCRI').AsString   := '';//RetornaTexto(strDadosServico, '<Discriminacao>', '</Discriminacao>');
    cdsNFS.FieldByName('CODMUN').AsString   := nodDadosNfse.ChildNodes['MunicipioPrestacao'].Text;
    cdsNFS.FieldByName('ITEDESC').AsString  := nodServicos.childNodes.FindNode('Servico').ChildNodes['Descricao'].Text;;
    cdsNFS.FieldByName('ITEQTD').AsFloat    := StrToFloatDef(AnsiReplaceStr(nodServicos.childNodes.FindNode('Servico').ChildNodes['Quantidade'].Text,'.',','), 0);
    cdsNFS.FieldByName('ITEVLU').AsFloat    := StrToFloatDef(AnsiReplaceStr(nodServicos.childNodes.FindNode('Servico').ChildNodes['ValorUnitario'].Text,'.',','), 0);

    cdsNFS.FieldByName('ORGMUN').AsString   := fCampoTabela('CID_NOMCID', 'CADCID', ['CID_COIBGE'], [nodDadosNfse.ChildNodes['MunicipioPrestacao'].Text]);
    cdsNFS.FieldByName('ORG_UF').AsString   := fCampoTabela('CID_ESTADO', 'CADCID', ['CID_COIBGE'], [nodDadosNfse.ChildNodes['MunicipioPrestacao'].Text]);

    cdsNFS.Post;

    If (Assigned(cdsItens)) Then
    Begin
      cdsItens.Append;
      cdsItens.FieldByName('NUMNFS').AsString := cdsNFS.FieldByName('NUMNFS').AsString;
      cdsItens.FieldByName('ITEDES').AsString := nodServicos.childNodes.FindNode('Servico').ChildNodes['Descricao'].Text;
      cdsItens.FieldByName('ITEQTD').AsFloat  := StrToFloatDef(AnsiReplaceStr(nodServicos.childNodes.FindNode('Servico').ChildNodes['Quantidade'].Text,'.',','), 0);
      cdsItens.FieldByName('VLRUNT').AsFloat  := StrToFloatDef(AnsiReplaceStr(nodServicos.childNodes.FindNode('Servico').ChildNodes['ValorUnitario'].Text,'.',','), 0);
      cdsItens.FieldByName('VLRTOT').AsFloat  := cdsItens.FieldByName('ITEQTD').AsFloat * cdsItens.FieldByName('VLRUNT').AsFloat;
      cdsItens.Post;
    End;

  finally
    FreeAndNil(xmlDoc);
  end;
end;

end.
