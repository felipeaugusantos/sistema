unit untGovDigitalXML;

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
  TGovDigitalXML = class

    private

    public
      class procedure pRetornaCDSPreenchido(var cdsNFS : TUniClientDataSet; cdsItens : TUniClientDataSet=nil; strXML: string='');

    end;

implementation

class procedure TGovDigitalXML.pRetornaCDSPreenchido(var cdsNFS : TUniClientDataSet; cdsItens : TUniClientDataSet=nil; strXML: string='');
var
  xmlDoc : TXMLDocument;
begin
  xmlDoc := TXMLDocument.Create(Application);
  try
    xmlDoc.LoadFromXML(strXML);
    xmlDoc.Active := True;

    cdsNFS.Append;

    cdsNFS.FieldByName('NUMNFS').AsString := xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['numero'].Text;
    cdsNFS.FieldByName('SERIE').AsString  := xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['serie'].Text;
    cdsNFS.FieldByName('CODVER').AsString := xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['senha'].Text;
    cdsNFS.FieldByName('DTAHRA').AsString := Copy(xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['prestacao'].Text, 12, 8);
    cdsNFS.FieldByName('DTAEMI').AsString := Copy(xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['prestacao'].Text,9,2)+'/'+
                                             Copy(xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['prestacao'].Text,6,2)+'/'+
                                              Copy(xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['prestacao'].Text,1,4);
    cdsNFS.FieldByName('CODSER').AsString := xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['atividade'].Text;
    cdsNFS.FieldByName('OUTINF').AsString := xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['obs'].Text;
    cdsNFS.FieldByName('EXIGIB').AsString := xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['exigibilidade'].Text;
    cdsNFS.FieldByName('NUMRPS').AsString := '';
    cdsNFS.FieldByName('SERRPS').AsString := '';
    cdsNFS.FieldByName('TPORPS').AsString := '';
    cdsNFS.FieldByName('EMIRPS').AsString := '';
    cdsNFS.FieldByName('NATOPE').AsString := '';
    cdsNFS.FieldByName('CODRET').AsString := '';
    cdsNFS.FieldByName('EMIOSN').AsString := '';
    cdsNFS.FieldByName('EMIICC').AsString := '';
    cdsNFS.FieldByName('COMPET').AsString := '';
    cdsNFS.FieldByName('NFSSUB').AsString := '';

    cdsNFS.FieldByName('CDCNAE').AsString := '';
    cdsNFS.FieldByName('CODTRI').AsString := '';

    cdsNFS.FieldByName('DISCRI').AsString := xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['itens'].ChildNodes['itens'].ChildNodes['descricao'].text;
    cdsNFS.FieldByName('MUNINC').AsString := xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['municipioIncidencia'].Text;
    cdsNFS.FieldByName('MUNPRE').AsString := xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['prestador'].ChildNodes['municipio'].Text;

    cdsNFS.FieldByName('BSCISS').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['valorBase'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRSER').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['valorTotal'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRDED').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['deducoes'].Text,'.',','), 0);
    cdsNFS.FieldByName('ISS_RET').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['retido'].Text,'.',','), 0);
    cdsNFS.FieldByName('ALIISS').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['aliquota'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRLIQ').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['valorLiquido'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRISS').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['valorImposto'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRPIS').AsFloat  := 0;
    cdsNFS.FieldByName('VLRCOF').AsFloat  := 0;
    cdsNFS.FieldByName('VLRINS').AsFloat  := 0;
    cdsNFS.FieldByName('VLRIR_').AsFloat  := 0;
    cdsNFS.FieldByName('VLRCSL').AsFloat  := 0;
    cdsNFS.FieldByName('OUT_RET').AsFloat := 0;
    cdsNFS.FieldByName('DESCONC').AsFloat := 0;
    cdsNFS.FieldByName('DESCONI').AsFloat := 0;

    cdsNFS.FieldByName('PSVCNPJ').AsString  := xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['prestador'].ChildNodes['documento'].Text;
    cdsNFS.FieldByName('PSVIM').AsString    := '';
    cdsNFS.FieldByName('IEPRES').AsString   := xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['prestador'].ChildNodes['inscEst'].Text;
    cdsNFS.FieldByName('PSVRAZAO').AsString := xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['prestador'].ChildNodes['nome'].Text;
    cdsNFS.FieldByName('PSVFANT').AsString  := xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['prestador'].ChildNodes['nome'].Text;
    cdsNFS.FieldByName('PSVEND').AsString   := xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['prestador'].ChildNodes['logradouro'].Text;
    cdsNFS.FieldByName('PSVNUM').AsString   := xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['prestador'].ChildNodes['numero'].Text;
    cdsNFS.FieldByName('PSVCOMPL').AsString := xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['prestador'].ChildNodes['complemento'].Text;
    cdsNFS.FieldByName('PSVBAIR').AsString  := xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['prestador'].ChildNodes['bairro'].Text;
    cdsNFS.FieldByName('PSVMUN').AsString   := xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['prestador'].ChildNodes['municipio'].Text;
    cdsNFS.FieldByName('PSVUF').AsString    := xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['prestador'].ChildNodes['estado'].Text;
    cdsNFS.FieldByName('PSVCEP').AsString   := xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['prestador'].ChildNodes['cep'].Text;
    cdsNFS.FieldByName('PSVFONE').AsString  := '';
    cdsNFS.FieldByName('PSVEMAIL').AsString := xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['prestador'].ChildNodes['email'].Text;

    cdsNFS.FieldByName('TMSCNPJ').AsString  := xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['tomador'].ChildNodes['documento'].Text;
    cdsNFS.FieldByName('TMSRAZAO').AsString := xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['tomador'].ChildNodes['nome'].Text;
    cdsNFS.FieldByName('TMSIM').AsString    := '';
    cdsNFS.FieldByName('TMSIE').AsString    := xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['tomador'].ChildNodes['inscEst'].Text;
    cdsNFS.FieldByName('TMSEND').AsString   := xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['tomador'].ChildNodes['logradouro'].Text;
    cdsNFS.FieldByName('TMSNUM').AsString   := xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['tomador'].ChildNodes['numero'].Text;
    cdsNFS.FieldByName('TMSCOMPL').AsString := xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['tomador'].ChildNodes['complemento'].Text;
    cdsNFS.FieldByName('TMSBAIR').AsString  := xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['tomador'].ChildNodes['bairro'].Text;
    cdsNFS.FieldByName('TMSMUN').AsString   := xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['tomador'].ChildNodes['municipio'].Text;
    cdsNFS.FieldByName('TMSUF').AsString    := xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['tomador'].ChildNodes['estado'].Text;
    cdsNFS.FieldByName('TMSCEP').AsString   := xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['tomador'].ChildNodes['cep'].Text;
    cdsNFS.FieldByName('TMSFONE').AsString  := xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['tomador'].ChildNodes['telefone'].Text;
    cdsNFS.FieldByName('TMSEMAIL').AsString := xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['tomador'].ChildNodes['email'].Text;

    cdsNFS.FieldByName('ORGMUN').AsString := '';
    cdsNFS.FieldByName('ORG_UF').AsString := '';

    cdsNFS.FieldByName('RESPTRIB').AsString := '';

    cdsNFS.Post;

    cdsItens.Append;
    cdsItens.FieldByName('NUMNFS').AsString := xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['numero'].Text;
    cdsItens.FieldByName('ITEDES').AsString := xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['itens'].ChildNodes['item'].ChildNodes['descricao'].text;
    cdsItens.FieldByName('ITEQTD').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['itens'].ChildNodes['item'].ChildNodes['quantidade'].text,'.',','), 0);
    cdsItens.FieldByName('VLRUNT').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['itens'].ChildNodes['item'].ChildNodes['valorUn'].text,'.',','), 0);
    cdsItens.FieldByName('VLRTOT').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['GovDigital'].ChildNodes['emissao'].ChildNodes['nf-e'].ChildNodes['itens'].ChildNodes['item'].ChildNodes['valor'].text,'.',','), 0);
    cdsItens.Post;

  finally
      FreeAndNil(xmlDoc);
  end;

end;

end.
