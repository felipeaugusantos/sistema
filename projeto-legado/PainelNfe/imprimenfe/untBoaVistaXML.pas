unit untBoaVistaXML;

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
  TBoaVistaXML = class

    private

    public

      class procedure pCarregaNoPrincipal( strXML : string );
      class procedure pCarregaNoInfNfse( NoElemento: IXMLNode );
      class procedure pCarregaNoDeclaracaoPrestacaoServico( NoInfNfse : IXMLNode );
      class procedure pCarregaNoInfDeclaracaoPrestacaoServico( NoDeclaracaoPrestacaoServico : IXMLNode );

      class procedure pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string);
      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS: TUniClientDataSet; strXML: string);

  end;

var
  XmlDoc : IXMLDocument;
  NoElemento,
  NoInfNfse,
  NoDeclaracaoPrestacaoServico,
  NoInfDeclaracaoPrestacaoServico,
  NoRps : IXMLNode;

const
  ns2 = 'http://www.abrasf.org.br/nfse.xsd';

implementation

{ TBoaVistaXML }

class procedure TBoaVistaXML.pCarregaNoPrincipal( strXML : string );
begin

  XmlDoc := TXMLDocument.Create(Application);
  XmlDoc.LoadFromXML(strXML);
  XmlDoc.Active := True;

  NoElemento := XmlDoc.DocumentElement;

end;

class procedure TBoaVistaXML.pCarregaNoInfNfse( NoElemento: IXMLNode );
begin
  If not ( NoElemento = nil ) Then
  Begin
    NoInfNfse := NoElemento.childNodes.FindNode('infNFSe');
    NoInfNfse.ChildNodes.First;
  End;
end;

class procedure TBoaVistaXML.pCarregaNoDeclaracaoPrestacaoServico( NoInfNfse: IXMLNode );
begin
  If not ( NoInfNfse = nil ) Then
  Begin
    NoDeclaracaoPrestacaoServico := NoInfNfse.childNodes.FindNode('DPS');
    NoDeclaracaoPrestacaoServico.ChildNodes.First;
  End;
end;

class procedure TBoaVistaXML.pCarregaNoInfDeclaracaoPrestacaoServico( NoDeclaracaoPrestacaoServico: IXMLNode );
begin
  If not ( NoDeclaracaoPrestacaoServico = nil ) Then
  Begin
    NoInfDeclaracaoPrestacaoServico := NoDeclaracaoPrestacaoServico.childNodes.FindNode('infDPS');
    NoInfDeclaracaoPrestacaoServico.ChildNodes.First;
  End;
end;

class procedure TBoaVistaXML.pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string);
begin
  //
end;

class procedure TBoaVistaXML.pRetornaCDSPreenchidoComENotas(var cdsNFS: TUniClientDataSet; strXML: string);
begin

  pCarregaNoPrincipal( strXML );
  pCarregaNoInfNfse( NoElemento );
  pCarregaNoDeclaracaoPrestacaoServico( NoInfNfse );
  pCarregaNoInfDeclaracaoPrestacaoServico( NoDeclaracaoPrestacaoServico );

  cdsNFS.Append;
  // Dados da NFS
  cdsNFS.FieldByName('NUMNFS').AsString := FormatFloat('00000000', StrToFloat(NoInfNfse.ChildNodes.FindNode('nNFSe').Text));
  cdsNFS.FieldByName('SERIE').AsString  := '1';
  cdsNFS.FieldByName('CODVER').AsString := '';
  cdsNFS.FieldByName('DTAHRA').AsString := Copy(NoInfNfse.ChildNodes.FindNode('dhProc').Text, 12, 8);
  cdsNFS.FieldByName('DTAEMI').AsString := Copy(NoInfNfse.ChildNodes.FindNode('dhProc').Text,9,2)+'/'+
                                           Copy(NoInfNfse.ChildNodes.FindNode('dhProc').Text,6,2)+'/'+
                                           Copy(NoInfNfse.ChildNodes.FindNode('dhProc').Text,1,4);
  cdsNFS.FieldByName('NUMRPS').AsString := NoInfNfse.ChildNodes['DPS'].ChildNodes['infDPS'].ChildNodes['nDPS'].Text;
  cdsNFS.FieldByName('SERRPS').AsString := NoInfNfse.ChildNodes['DPS'].ChildNodes['infDPS'].ChildNodes['serie'].Text;
  cdsNFS.FieldByName('TPORPS').AsString := '';
  cdsNFS.FieldByName('EMIRPS').AsString := cdsNFS.FieldByName('DTAEMI').AsString;
  cdsNFS.FieldByName('NATOPE').AsString := '';
  cdsNFS.FieldByName('CODRET').AsString := '';
  cdsNFS.FieldByName('EMIOSN').AsString := NoInfNfse.ChildNodes['DPS'].ChildNodes['infDPS'].ChildNodes['prest'].ChildNodes['regTrib'].ChildNodes['opSimpNac'].Text;
  cdsNFS.FieldByName('EMIICC').AsString := NoInfNfse.ChildNodes['DPS'].ChildNodes['infDPS'].ChildNodes['prest'].ChildNodes['regTrib'].ChildNodes['regEspTrib'].Text;
  cdsNFS.FieldByName('COMPET').AsString := NoInfNfse.ChildNodes['DPS'].ChildNodes['infDPS'].ChildNodes['dCompet'].Text;
  cdsNFS.FieldByName('OUTINF').AsString := '';
  cdsNFS.FieldByName('ORGMUN').AsString := NoInfNfse.ChildNodes['cLocIncid'].Text;
  cdsNFS.FieldByName('ORG_UF').AsString := 'RR';
  cdsNFS.FieldByName('_LINK_').AsString := '';

  //Valores
  cdsNFS.FieldByName('VLRSER').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DPS'].ChildNodes['infDPS'].ChildNodes['valores'].ChildNodes['vServPrest'].ChildNodes['vServ'].Text,'.',','), 0);
  cdsNFS.FieldByName('ISS_RET').AsFloat := 0;
  cdsNFS.FieldByName('VLRISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['valores'].ChildNodes['vISSQN'].Text,'.',','), 0);
  cdsNFS.FieldByName('BSCISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['valores'].ChildNodes['vBC'].Text,'.',','), 0);
  cdsNFS.FieldByName('ALIISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['valores'].ChildNodes['pAliqAplic'].Text,'.',','), 0);
  cdsNFS.FieldByName('VLRLIQ').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['valores'].ChildNodes['vLiq'].Text,'.',','), 0);
  cdsNFS.FieldByName('CODSER').AsString := NoInfNfse.ChildNodes['DPS'].ChildNodes['infDPS'].ChildNodes['serv'].ChildNodes['cServ'].ChildNodes['cTribMun'].Text;
  cdsNFS.FieldByName('CDCNAE').AsString := '';
  cdsNFS.FieldByName('CODTRI').AsString := '';
  cdsNFS.FieldByName('DISCRI').AsString := NoInfNfse.ChildNodes['DPS'].ChildNodes['infDPS'].ChildNodes['serv'].ChildNodes['cServ'].ChildNodes['xDescServ'].Text;
  cdsNFS.FieldByName('CODMUN').AsString := cdsNFS.FieldByName('ORGMUN').AsString;
  cdsNFS.FieldByName('MUNINC').AsString := NoInfNfse.ChildNodes['xLocIncid'].Text;
  cdsNFS.FieldByName('MUNPRE').AsString := cdsNFS.FieldByName('CODMUN').AsString;
  cdsNFS.FieldByName('ITEDESC').AsString := '';
  cdsNFS.FieldByName('ITEQTD').AsFloat := 0;
  cdsNFS.FieldByName('ITEVLU').AsFloat := 0;
  cdsNFS.FieldByName('EXIGIB').AsInteger := 1;
  //Prestador
  cdsNFS.FieldByName('PSVCNPJ').AsString := NoInfNfse.ChildNodes['DPS'].ChildNodes['infDPS'].ChildNodes['prest'].ChildNodes['CNPJ'].Text;
  cdsNFS.FieldByName('PSVIM').AsString := '';
  cdsNFS.FieldByName('PSVRAZAO').AsString := NoInfNfse.ChildNodes['emit'].ChildNodes['xNome'].Text;
  cdsNFS.FieldByName('PSVFANT').AsString := NoInfNfse.ChildNodes['emit'].ChildNodes['xNome'].Text;
  cdsNFS.FieldByName('PSVEND').AsString := NoInfNfse.ChildNodes['emit'].ChildNodes['enderNac'].ChildNodes['xLgr'].Text;
  cdsNFS.FieldByName('PSVNUM').AsString := NoInfNfse.ChildNodes['emit'].ChildNodes['enderNac'].ChildNodes['nro'].Text;
  cdsNFS.FieldByName('PSVCOMPL').AsString := '';
  cdsNFS.FieldByName('PSVBAIR').AsString := NoInfNfse.ChildNodes['emit'].ChildNodes['enderNac'].ChildNodes['xBairro'].Text;
  cdsNFS.FieldByName('PSVMUN').AsString := NoInfNfse.ChildNodes['emit'].ChildNodes['enderNac'].ChildNodes['cMun'].Text;
  cdsNFS.FieldByName('PSVUF').AsString := NoInfNfse.ChildNodes['emit'].ChildNodes['enderNac'].ChildNodes['UF'].Text;
  cdsNFS.FieldByName('PSVCEP').AsString := NoInfNfse.ChildNodes['emit'].ChildNodes['enderNac'].ChildNodes['CEP'].Text;
  cdsNFS.FieldByName('PSVFONE').AsString := NoInfNfse.ChildNodes['emit'].ChildNodes['fone'].Text;
  cdsNFS.FieldByName('PSVEMAIL').AsString := NoInfNfse.ChildNodes['emit'].ChildNodes['email'].Text;
  //Tomador
  cdsNFS.FieldByName('TMSCNPJ').AsString  := iif(fRetornaValorTagXml(NoInfNfse.ChildNodes['DPS'].ChildNodes['infDPS'].ChildNodes['toma'].ChildNodes['CNPJ'])='',
                                                 fRetornaValorTagXml(NoInfNfse.ChildNodes['DPS'].ChildNodes['infDPS'].ChildNodes['toma'].ChildNodes['CPF']),
                                                 fRetornaValorTagXml(NoInfNfse.ChildNodes['DPS'].ChildNodes['infDPS'].ChildNodes['toma'].ChildNodes['CNPJ']));
  cdsNFS.FieldByName('TMSIM').AsString := '';
  cdsNFS.FieldByName('TMSRAZAO').AsString := NoInfNfse.ChildNodes['DPS'].ChildNodes['infDPS'].ChildNodes['toma'].ChildNodes['xNome'].Text;
  cdsNFS.FieldByName('TMSFANTA').AsString := NoInfNfse.ChildNodes['DPS'].ChildNodes['infDPS'].ChildNodes['toma'].ChildNodes['xNome'].Text;
  cdsNFS.FieldByName('TMSEND').AsString := NoInfNfse.ChildNodes['DPS'].ChildNodes['infDPS'].ChildNodes['toma'].ChildNodes['end'].ChildNodes['xLgr'].Text;
  cdsNFS.FieldByName('TMSNUM').AsString := NoInfNfse.ChildNodes['DPS'].ChildNodes['infDPS'].ChildNodes['toma'].ChildNodes['end'].ChildNodes['nro'].Text;
  cdsNFS.FieldByName('TMSCOMPL').AsString := NoInfNfse.ChildNodes['DPS'].ChildNodes['infDPS'].ChildNodes['toma'].ChildNodes['end'].ChildNodes['xCpl'].Text;
  cdsNFS.FieldByName('TMSBAIR').AsString := NoInfNfse.ChildNodes['DPS'].ChildNodes['infDPS'].ChildNodes['toma'].ChildNodes['end'].ChildNodes['xBairro'].Text;
  cdsNFS.FieldByName('TMSMUN').AsString := NoInfNfse.ChildNodes['DPS'].ChildNodes['infDPS'].ChildNodes['toma'].ChildNodes['end'].ChildNodes['endNac'].ChildNodes['cMun'].Text;
  cdsNFS.FieldByName('TMSUF').AsString := '';
  cdsNFS.FieldByName('TMSCEP').AsString := NoInfNfse.ChildNodes['DPS'].ChildNodes['infDPS'].ChildNodes['toma'].ChildNodes['end'].ChildNodes['endNac'].ChildNodes['CEP'].Text;
  cdsNFS.FieldByName('TMSFONE').AsString := NoInfNfse.ChildNodes['DPS'].ChildNodes['infDPS'].ChildNodes['toma'].ChildNodes['fone'].Text;
  cdsNFS.FieldByName('TMSEMAIL').AsString := NoInfNfse.ChildNodes['DPS'].ChildNodes['infDPS'].ChildNodes['toma'].ChildNodes['email'].Text;

  cdsNFS.Post;

end;

end.
