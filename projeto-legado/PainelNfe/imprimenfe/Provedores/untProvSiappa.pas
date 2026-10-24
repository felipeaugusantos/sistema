unit untProvSiappa;

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
  TProvSiappa = class
    public
      class procedure pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string);
  end;
implementation

{ TProvSiappa }

class procedure TProvSiappa.pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet;
  strXML: string);
var
  XmlDoc : IXMLDocument;
  XmlNodePrincipal,
  XmlNodeReg_NFS_E: IXMLNode;

begin
  xmlDoc := TXMLDocument.Create(Application);

  xmlDoc.LoadFromXML(strXML);
  xmlDoc.Active := True;

  XmlNodePrincipal := XmlDoc.ChildNodes['NFS_E_XML'].ChildNodes['Detalhes_NFS_e'];
  XmlNodeReg_NFS_E := XmlNodePrincipal.ChildNodes['Reg_NFS_E'];

  cdsNFS.Append;
  // Dados da NFS
  cdsNFS.FieldByName('NUMNFS').AsString   := fRetornaValorTagXml(XmlNodeReg_NFS_E.ChildNodes.FindNode('NFS_E_NRO'));
  cdsNFS.FieldByName('CODVER').AsString   := fRetornaValorTagXml(XmlNodeReg_NFS_E.ChildNodes.FindNode('NFS_E_COD_VALIDACAO'));
  cdsNFS.FieldByName('DTAHRA').AsString   := Copy(fRetornaValorTagXml(XmlNodeReg_NFS_E.ChildNodes.FindNode('NFS_E_DATA_HORA_CAD')), 12, 08);
  cdsNFS.FieldByName('DTAEMI').AsString   := Copy(fRetornaValorTagXml(XmlNodeReg_NFS_E.ChildNodes.FindNode('NFS_E_DATA_HORA_CAD')), 01, 10);
  cdsNFS.FieldByName('NUMRPS').AsString   := '';
  cdsNFS.FieldByName('SERRPS').AsString   := '';
  cdsNFS.FieldByName('TPORPS').AsString   := '';
  cdsNFS.FieldByName('EMIRPS').AsString   := '';
  cdsNFS.FieldByName('EMIOSN').AsString   := '';
  cdsNFS.FieldByName('RESPTRIB').AsString := '';
  cdsNFS.FieldByName('EMIICC').AsString   := '';
  cdsNFS.FieldByName('COMPET').AsString   := Copy(fRetornaValorTagXml(XmlNodeReg_NFS_E.ChildNodes.FindNode('NFS_E_DATA_HORA_CAD')),04,07);
  cdsNFS.FieldByName('OUTINF').AsString   := fRetornaValorTagXml(XmlNodeReg_NFS_E.ChildNodes.FindNode('NFS_E_DES_RES'));
  cdsNFS.FieldByName('ORGMUN').AsString   := '';
  cdsNFS.FieldByName('ORG_UF').AsString   := '';

  //Valores
  cdsNFS.FieldByName('BSCISS').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodeReg_NFS_E.ChildNodes['NFS_E_VLR_BRUTO']));
  cdsNFS.FieldByName('VLRLIQ').AsFloat  := 0;
  cdsNFS.FieldByName('VLRDED').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodeReg_NFS_E.ChildNodes['NFS_E_VLR_DED']));

  //Valores Serviço
  cdsNFS.FieldByName('VLRSER').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodeReg_NFS_E.ChildNodes['NFS_E_VLR_BRUTO']));
  cdsNFS.FieldByName('ISS_RET').AsString := '';
  cdsNFS.FieldByName('DESCONC').AsFloat  := 0;
  cdsNFS.FieldByName('DESCONI').AsFloat  := 0;
  cdsNFS.FieldByName('VALINS').AsFloat   := 0;
  cdsNFS.FieldByName('VALPIS').AsFloat   := 0;
  cdsNFS.FieldByName('VALCOF').AsFloat   := 0;
  cdsNFS.FieldByName('VALIRR').AsFloat   := 0;
  cdsNFS.FieldByName('VALCSL').AsFloat   := 0;
  cdsNFS.FieldByName('OUT_RET').AsFloat  := 0;
  cdsNFS.FieldByName('VLRISS').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodeReg_NFS_E.ChildNodes['NFS_E_VLR_ISSQN']));
  cdsNFS.FieldByName('ALIISS').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodeReg_NFS_E.ChildNodes['NFS_E_ALQ_APL']));

  //Informações de Serviço
  cdsNFS.FieldByName('CODSER').AsString := fRetornaValorTagXml(XmlNodeReg_NFS_E.ChildNodes.FindNode('NFS_E_ATV_COD'));
  cdsNFS.FieldByName('DESSER').AsString := fRetDescClassificacaoServico(fStrZero(AnsiReplaceStr(cdsNFS.FieldByName('CODSER').AsString, '.', ''),4));
  cdsNFS.FieldByName('CDCNAE').AsString := '';
  cdsNFS.FieldByName('CODTRI').AsString := '';
  cdsNFS.FieldByName('DISCRI').AsString := fRetornaValorTagXml(XmlNodeReg_NFS_E.ChildNodes.FindNode('NFS_E_DES_DET'));
  cdsNFS.FieldByName('CODMUN').AsString := '';
  cdsNFS.FieldByName('EXIISS').AsString := '';
  cdsNFS.FieldByName('MUNINC').AsString := '';

  //Prestador
  cdsNFS.FieldByName('PSVCNPJ').AsString  := '';
  cdsNFS.FieldByName('PSVIM').AsString    := '';
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

  //Tomador
  cdsNFS.FieldByName('TMSCNPJ').AsString  := IIF(fRetornaValorTagXml(XmlNodeReg_NFS_E.ChildNodes.FindNode('NFS_E_TOM_NAT'))='F',
                                                 fRetornaValorTagXml(XmlNodeReg_NFS_E.ChildNodes.FindNode('NFS_E_TOM_CPF_CNPJ')),
                                                 fRetornaValorTagXml(XmlNodeReg_NFS_E.ChildNodes.FindNode('NFS_E_TOM_CPF_CNPJ')));
  cdsNFS.FieldByName('TMSIM').AsString    := fRetornaValorTagXml(XmlNodeReg_NFS_E.ChildNodes.FindNode('NFS_E_TOM_NAT'));
  cdsNFS.FieldByName('TMSRAZAO').AsString := fRetornaValorTagXml(XmlNodeReg_NFS_E.ChildNodes.FindNode('NFS_E_TOM_NOME_RSO'));
  cdsNFS.FieldByName('TMSFANTA').AsString := fRetornaValorTagXml(XmlNodeReg_NFS_E.ChildNodes.FindNode('NFS_E_TOM_NOME_RSO'));
  cdsNFS.FieldByName('TMSEND').AsString   := fRetornaValorTagXml(XmlNodeReg_NFS_E.ChildNodes.FindNode('NFS_E_TOM_END_LOG'));
  cdsNFS.FieldByName('TMSNUM').AsString   := fRetornaValorTagXml(XmlNodeReg_NFS_E.ChildNodes.FindNode('NFS_E_TOM_END_NRO'));
  cdsNFS.FieldByName('TMSCOMPL').AsString := fRetornaValorTagXml(XmlNodeReg_NFS_E.ChildNodes.FindNode('NFS_E_TOM_END_COM'));
  cdsNFS.FieldByName('TMSBAIR').AsString  := fRetornaValorTagXml(XmlNodeReg_NFS_E.ChildNodes.FindNode('NFS_E_TOM_END_BAI'));
  cdsNFS.FieldByName('TMSMUN').AsString   := fRetornaValorTagXml(XmlNodeReg_NFS_E.ChildNodes.FindNode('NFS_E_TOM_END_CID'));
  cdsNFS.FieldByName('TMSUF').AsString    := fRetornaValorTagXml(XmlNodeReg_NFS_E.ChildNodes.FindNode('NFS_E_TOM_END_UF'));
  cdsNFS.FieldByName('TMSCEP').AsString   := fRetornaValorTagXml(XmlNodeReg_NFS_E.ChildNodes.FindNode('NFS_E_TOM_END_CEP'));
  cdsNFS.FieldByName('TMSFONE').AsString  := fRetornaValorTagXml(XmlNodeReg_NFS_E.ChildNodes.FindNode('NFS_E_TOM_FONE_FAX_01'));
  cdsNFS.FieldByName('TMSEMAIL').AsString := fRetornaValorTagXml(XmlNodeReg_NFS_E.ChildNodes.FindNode('NFS_E_TOM_E_MAIL'));

  cdsNFS.Post;
end;

end.
