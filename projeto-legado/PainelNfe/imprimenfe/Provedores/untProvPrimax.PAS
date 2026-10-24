unit untProvPrimax;

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
  TProvPrimax = class
    private
    public

      class procedure pRetornaCDSPreenchido(var cdsNFS, cdsItens, cdsFaturas: TUniClientDataSet; strXML: string);

  end;

implementation

{ TProvPrimax }

class procedure TProvPrimax.pRetornaCDSPreenchido(var cdsNFS, cdsItens, cdsFaturas: TUniClientDataSet; strXML: string);
var
  XmlDoc : IXMLDocument;
  XmlNodePrincipal : IXMLNode;
  intOrdem : integer;

begin
  xmlDoc := TXMLDocument.Create(Application);
  xmlDoc.LoadFromXML(strXML);
  xmlDoc.Active := True;

  XmlNodePrincipal := XmlDoc.ChildNodes['ArqNfe']
                            .ChildNodes['NfeControle'];

  cdsNFS.Append;

  cdsNFS.FieldByName('PSVCNPJ').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('EmitenteCNPJ'));
  cdsNFS.FieldByName('NUMNFS').AsString   := fPadL(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('NfeNumero')), 8, '0');
  cdsNFS.FieldByName('DTAEMI').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('NfeData'));
  cdsNFS.FieldByName('HRANFS').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('NfeHora'));
  cdsNFS.FieldByName('CODVER').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('NfeAutenticacao'));
  cdsNFS.FieldByName('COMPET').AsString   := Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('NfeData')),4,2)+'/'+
                                             Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('NfeData')),7,4) ;
  //Destinatário
  cdsNFS.FieldByName('TMSCNPJ').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DestinatarioCpf'));
  cdsNFS.FieldByName('TMSIM').AsString    := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DestinatarioInscMun'));
  cdsNFS.FieldByName('TMSIE').AsString    := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DestinatarioInscEst'));
  cdsNFS.FieldByName('TMSRAZAO').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DestinatarioRSocial'));
  cdsNFS.FieldByName('TMSEND').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DestinatarioEndereco'));
  cdsNFS.FieldByName('TMSNUM').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DestinatarioNumero'));
  cdsNFS.FieldByName('TMSCOMPL').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DestinatarioComplemento'));
  cdsNFS.FieldByName('TMSBAIR').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DestinatarioBairro'));
  cdsNFS.FieldByName('PSVMUN').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DestinatarioCidade'));
  cdsNFS.FieldByName('TMSUF').AsString    := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DestinatarioEstado'));
  cdsNFS.FieldByName('TMSCEP').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DestinatarioCep'));

  //Valores
  cdsNFS.FieldByName('VLRSER').AsFloat    := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('NfeValor')),'.',','), 0);
  cdsNFS.FieldByName('VLRISS').AsFloat    := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('NfeValIss')),'.',','), 0);
  cdsNFS.FieldByName('ISS_RET').AsFloat   := IIF(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('NfeRetida'))='SIM', 1, 2);
  cdsNFS.FieldByName('DESCONI').AsFloat   := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('NfeValDescIncondicional')),'.',','), 0);
  cdsNFS.FieldByName('DESCONC').AsFloat   := 0;
  cdsNFS.FieldByName('DESCOUT').AsFloat   := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('NfeValDescOutros')),'.',','), 0);
  cdsNFS.FieldByName('VALPIS').AsFloat    := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('NfeValPis')),'.',','), 0);
  cdsNFS.FieldByName('BC_PIS').AsFloat    := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('NfeBaseCalcPis')),'.',','), 0);
  cdsNFS.FieldByName('ALQPIS').AsFloat    := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('NfeAliqPis')),'.',','), 0);
  cdsNFS.FieldByName('VALCOF').AsFloat    := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('NfeValCofins')),'.',','), 0);
  cdsNFS.FieldByName('BCCOFI').AsFloat    := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('NfeBaseCalcCofins')),'.',','), 0);
  cdsNFS.FieldByName('ALQCOF').AsFloat    := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('NfeAliqCofins')),'.',','), 0);
  cdsNFS.FieldByName('VALCSL').AsFloat    := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('NfeValCsll')),'.',','), 0);
  cdsNFS.FieldByName('BCCSLL').AsFloat    := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('NfeBaseCalcCsll')),'.',','), 0);
  cdsNFS.FieldByName('ALQCSL').AsFloat    := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('NfeAliqCsll')),'.',','), 0);
  cdsNFS.FieldByName('VALINS').AsFloat    := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('NfeValInss')),'.',','), 0);
  cdsNFS.FieldByName('BCINSS').AsFloat    := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('NfeBaseCalcInss')),'.',','), 0);
  cdsNFS.FieldByName('ALQINS').AsFloat    := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('NfeAliqInss')),'.',','), 0);
  cdsNFS.FieldByName('VALIRR').AsFloat    := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('NfeValIrrf')),'.',','), 0);
  cdsNFS.FieldByName('BCIRRF').AsFloat    := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('NfeBaseCalcIrrf')),'.',','), 0);
  cdsNFS.FieldByName('ALQIRR').AsFloat    := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('NfeAliqIrrf')),'.',','), 0);

  //Serviço
  cdsNFS.FieldByName('CODSER').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('NfeItemServ1'));
  cdsNFS.FieldByName('DISCRI').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('NfeDescricaoServicos'));
  cdsNFS.FieldByName('OUTINF').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('NfeObservacoes'));
  cdsNFS.FieldByName('ALIISS').AsFloat    := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('NfeAliqServ1')),'.',','), 0);
  cdsNFS.Post;

  //Itens
  if Assigned(cdsItens) then
  begin
    For intOrdem := 1 to 8 do
    begin
      cdsItens.Append;
      cdsItens.FieldByName('NUMNFS').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('NfeNumero'));
      cdsItens.FieldByName('CODSER').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('NfeItemServ'+IntToStr(intOrdem)));
      cdsItens.FieldByName('ALIISS').AsFloat  := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('NfeAliqServ'+IntToStr(intOrdem))),'.',','), 0);
      cdsItens.FieldByName('VLRSRV').AsFloat  := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('NfeValServ'+IntToStr(intOrdem))),'.',','), 0);
      cdsItens.Post;
    end;
  end;

  //Faturas
  if Assigned(cdsFaturas) then
  begin
    For intOrdem := 1 to 6 do
    begin
      cdsFaturas.Append;
      cdsFaturas.FieldByName('NUMNFS').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('NfeNumero'));
      cdsFaturas.FieldByName('FATNUM').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('NfeNumFatura'+IntToStr(intOrdem)));
      cdsFaturas.FieldByName('DTAVEN').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('NfeDatFatura'+IntToStr(intOrdem)));
      cdsFaturas.FieldByName('VALFAT').AsFloat  := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('NfeValFatura'+IntToStr(intOrdem))),'.',','), 0);
      cdsFaturas.Post;
    end;
  end;

end;

end.
