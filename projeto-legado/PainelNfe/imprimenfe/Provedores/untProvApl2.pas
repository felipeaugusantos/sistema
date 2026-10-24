unit untProvApl2;

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
  TProvApl2 = class
    public
      class procedure pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string);
  end;
implementation

{ TProvApl2 }

class procedure TProvApl2.pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet;
  strXML: string);

  function fTrataXml(strXML: String): String;
  begin
    Result := ReplaceStr(strXML, '>n', '>');
    Result := Trim(Result);
  End;

var
  XmlDoc : IXMLDocument;

  XmlNodePrincipal,
  XmlNodePrestador,
  XmlNodeEndPrestador,
  XmlNodeTomador,
  XmlNodeEndTomador,
  XmlNodeInformacoes,
  XmlNodeRPS,
  XMLNodeAtividade,
  XmlNodeURL : IXMLNode;

  fltTgVlNfsIss,
  fltTgVlNfsAli: Double;

  strInformacoes: string;

  iNode: integer;

begin
  xmlDoc := TXMLDocument.Create(Application);

  xmlDoc.LoadFromXML(fTrataXml(strXML));
  xmlDoc.Active := True;

  XmlNodeURL          := XmlDoc.ChildNodes['Retorno'];
  XmlNodePrincipal    := XmlDoc.ChildNodes['Retorno'].ChildNodes['Nota'];
  XmlNodePrestador    := XmlNodePrincipal.ChildNodes['Prestador'];
  XmlNodeEndPrestador := XmlNodePrestador.ChildNodes['Endereco'];
  XmlNodeTomador      := XmlNodePrincipal.ChildNodes['Tomador'];
  XmlNodeEndTomador   := XmlNodeTomador.ChildNodes['Endereco'];
  XmlNodeInformacoes  := XmlNodePrincipal.ChildNodes['Informacoes'];
  XmlNodeRPS          := XmlNodePrincipal.ChildNodes['RPS'];
  XMLNodeAtividade    := XmlNodePrestador.ChildNodes['Atividade'];

  cdsNFS.Append;
  // Dados da NFS
  cdsNFS.FieldByName('NUMNFS').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('Numero'));
  cdsNFS.FieldByName('CODVER').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('CodigoValidacao'));
  cdsNFS.FieldByName('DTAHRA').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('EmissaoHora'));
  cdsNFS.FieldByName('DTAEMI').AsString := Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('EmissaoData')),9,2)+'/'+
                                           Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('EmissaoData')),6,2)+'/'+
                                           Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('EmissaoData')),1,4);

  cdsNFS.FieldByName('NUMRPS').AsString := fRetornaValorTagXml(XmlNodeRPS.ChildNodes.FindNode('Numero'));
  cdsNFS.FieldByName('SERRPS').AsString := '';
  if Assigned(XmlNodeRPS.ChildNodes.FindNode('EmissaoData')) then
    cdsNFS.FieldByName('EMIRPS').AsString := fRetornaValorTagXml(XmlNodeRPS.ChildNodes.FindNode('EmissaoData'));

  cdsNFS.FieldByName('EMIOSN').AsString   := '';
  cdsNFS.FieldByName('RESPTRIB').AsString := '';
  cdsNFS.FieldByName('EMIICC').AsString   := '';
  cdsNFS.FieldByName('COMPET').AsString   := '';

  cdsNFS.FieldByName('ORGMUN').AsString   := '';
  cdsNFS.FieldByName('ORG_UF').AsString   := '';
  cdsNFS.FieldByName('SITUAC').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['situacao']);
  cdsNFS.FieldByName('_LINK_').AsString   := fRetornaValorTagXml(XmlNodeURL.ChildNodes['url']);

  //Valores
  cdsNFS.FieldByName('BSCISS').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['BaseDeCalculo']));
  cdsNFS.FieldByName('VLRLIQ').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ValorTotal']));
  cdsNFS.FieldByName('VLRDED').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ValorDeducao']));
  cdsNFS.FieldByName('VLRCRE').AsFloat  := 0;

  //Valores Serviço
  cdsNFS.FieldByName('VALINS').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['RetencaoINSS']));
  cdsNFS.FieldByName('VLRSER').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ValorTotal']));
  cdsNFS.FieldByName('ISS_RET').AsString := iif(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['retido'])='Nao','2','1');
  cdsNFS.FieldByName('DESCONC').AsFloat  := 0;
  cdsNFS.FieldByName('DESCONI').AsFloat  := 0;
  cdsNFS.FieldByName('VALPIS').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ValorPIS']));
  cdsNFS.FieldByName('VALCOF').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ValorCOFINS']));
  cdsNFS.FieldByName('VALIRR').AsFloat   := 0;
  cdsNFS.FieldByName('VALCSL').AsFloat   := 0;
  cdsNFS.FieldByName('OUT_RET').AsFloat  := 0;
  cdsNFS.FieldByName('VLRISS').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ValorISS']));
  cdsNFS.FieldByName('ALIISS').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['Aliquota']));

  //Informações de Serviço
  cdsNFS.FieldByName('CODSER').AsString := fRetornaValorTagXml(XMLNodeAtividade.ChildNodes['Codigo']);
  cdsNFS.FieldByName('DESSER').AsString := fRetornaValorTagXml(XMLNodeAtividade.ChildNodes['Descricao']);

  cdsNFS.FieldByName('CDCNAE').AsString := '';
  cdsNFS.FieldByName('CODTRI').AsString := '';
  cdsNFS.FieldByName('DISCRI').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['Descricao']);
  cdsNFS.FieldByName('MUNPRE').AsString := '';
  cdsNFS.FieldByName('EXIISS').AsString := '';
  cdsNFS.FieldByName('MUNINC').AsString := '';

  //Prestador
  cdsNFS.FieldByName('PSVCNPJ').AsString  := fRetornaValorTagXml(XmlNodePrestador.ChildNodes.FindNode('Inscricao'));
  cdsNFS.FieldByName('PSVDOC_').AsString  := fRetornaValorTagXml(XmlNodePrestador.ChildNodes.FindNode('Inscricao'));
  cdsNFS.FieldByName('PSVIM').AsString    := fRetornaValorTagXml(XmlNodePrestador.ChildNodes.FindNode('InscricaoMunicipal'));
  cdsNFS.FieldByName('PSVRAZAO').AsString := fRetornaValorTagXml(XmlNodePrestador.ChildNodes.FindNode('RazaoSocial'));
  cdsNFS.FieldByName('PSVFANT').AsString  := fRetornaValorTagXml(XmlNodePrestador.ChildNodes.FindNode('NomeFantasia'));
  cdsNFS.FieldByName('PSVEND').AsString   := fRetornaValorTagXml(XmlNodeEndPrestador.ChildNodes.FindNode('Logradouro'));
  cdsNFS.FieldByName('PSVNUM').AsString   := fRetornaValorTagXml(XmlNodeEndPrestador.ChildNodes.FindNode('Numero'));
  cdsNFS.FieldByName('PSVCOMPL').AsString := fRetornaValorTagXml(XmlNodeEndPrestador.ChildNodes.FindNode('Complemento'));
  cdsNFS.FieldByName('PSVBAIR').AsString  := fRetornaValorTagXml(XmlNodeEndPrestador.ChildNodes.FindNode('Bairro'));
  cdsNFS.FieldByName('PSVMUN').AsString   := fRetornaValorTagXml(XmlNodeEndPrestador.ChildNodes.FindNode('Cidade'));
  cdsNFS.FieldByName('PSVUF').AsString    := fRetornaValorTagXml(XmlNodeEndPrestador.ChildNodes.FindNode('Estado'));
  cdsNFS.FieldByName('PSVCEP').AsString   := fRetornaValorTagXml(XmlNodeEndPrestador.ChildNodes.FindNode('Cep'));
  cdsNFS.FieldByName('PSVFONE').AsString  := '';
  cdsNFS.FieldByName('PSVEMAIL').AsString := '';

  //Tomador
  cdsNFS.FieldByName('TMSCNPJ').AsString  := fRetornaValorTagXml(XmlNodeTomador.ChildNodes.FindNode('Inscricao'));
  cdsNFS.FieldByName('TMSIM').AsString    := fRetornaValorTagXml(XmlNodeTomador.ChildNodes.FindNode('InscricaoMunicipal'));
  cdsNFS.FieldByName('TMSRAZAO').AsString := fRetornaValorTagXml(XmlNodeTomador.ChildNodes.FindNode('Nome'));
  cdsNFS.FieldByName('TMSFANTA').AsString := fRetornaValorTagXml(XmlNodeTomador.ChildNodes.FindNode('Nome'));
  cdsNFS.FieldByName('TMSEND').AsString   := fRetornaValorTagXml(XmlNodeEndTomador.ChildNodes.FindNode('Logradouro'));
  cdsNFS.FieldByName('TMSNUM').AsString   := fRetornaValorTagXml(XmlNodeEndTomador.ChildNodes.FindNode('Numero'));
  cdsNFS.FieldByName('TMSCOMPL').AsString := fRetornaValorTagXml(XmlNodeEndTomador.ChildNodes.FindNode('Complemento'));
  cdsNFS.FieldByName('TMSBAIR').AsString  := fRetornaValorTagXml(XmlNodeEndTomador.ChildNodes.FindNode('Bairro'));
  cdsNFS.FieldByName('TMSMUN').AsString   := fRetornaValorTagXml(XmlNodeEndTomador.ChildNodes.FindNode('Cidade'));
  cdsNFS.FieldByName('TMSUF').AsString    := fRetornaValorTagXml(XmlNodeEndTomador.ChildNodes.FindNode('Estado'));
  cdsNFS.FieldByName('TMSCEP').AsString   := fRetornaValorTagXml(XmlNodeEndTomador.ChildNodes.FindNode('Cep'));
  cdsNFS.FieldByName('TMSFONE').AsString  := '';
  cdsNFS.FieldByName('TMSEMAIL').AsString := fRetornaValorTagXml(XmlNodeTomador.ChildNodes.FindNode('Email'));

  strInformacoes := '';
  for iNode := 0 to XmlNodeInformacoes.ChildNodes.Count - 1 do
    strInformacoes := strInformacoes + fRetornaValorTagXml(XmlNodeInformacoes.ChildNodes[iNode]) + sLineBreak;

  cdsNFS.FieldByName('OUTINF').AsString := strInformacoes;

  cdsNFS.Post;

end;

end.