unit untTaboaoDaSerraXML;

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
  TTaboaoDaSerraXML = class

    private

    public
      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil);

  end;

implementation

{ TTaboaoDaSerraXML }

class procedure TTaboaoDaSerraXML.pRetornaCDSPreenchidoComENotas(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil);
begin

  cdsNFS.Append;
  cdsNFS.FieldByName('PSVIM').AsString    := '';
  cdsNFS.FieldByName('NUMNFS').AsString   := RetornaTexto(strXML, '<NumNf xmlns="NFe">', '</NumNf>');
  cdsNFS.FieldByName('SERNFE').AsString   := RetornaTexto(strXML, '<SerNf xmlns="NFe">', '</SerNf>');
  cdsNFS.FieldByName('CODVER').AsString   := RetornaTexto(strXML, '<CodVernf xmlns="NFe">', '</CodVernf>');
  cdsNFS.FieldByName('DTAEMI').AsString   := RetornaTexto(strXML, '<DtHrGerNf xmlns="NFe">', '</DtHrGerNf>');
  cdsNFS.FieldByName('SERRPS').AsString   := RetornaTexto(strXML, '<SerRps xmlns="NFe">', '</SerRps>');
  cdsNFS.FieldByName('NUMRPS').AsString   := RetornaTexto(strXML, '<NumRps xmlns="NFe">', '</NumRps>');
  cdsNFS.FieldByName('TPORPS').AsString   := '';
  cdsNFS.FieldByName('EMIRPS').AsString   := RetornaTexto(strXML, '<DtEmiRps xmlns="NFe">', '</DtEmiRps>');

  cdsNFS.FieldByName('DISCRDED').AsString  := RetornaTexto(strXML, '<DiscrDed xmlns="NFe">', '</DiscrDed>');
  cdsNFS.FieldByName('PSVCNPJ').AsString  := RetornaTexto(strXML, '<CpfCnpjPre xmlns="NFe">', '</CpfCnpjPre>');
  cdsNFS.FieldByName('PSVRAZAO').AsString := RetornaTexto(strXML, '<RazSocPre xmlns="NFe">', '</RazSocPre>');
  cdsNFS.FieldByName('PSVEND').AsString   := RetornaTexto(strXML, '<LogPre xmlns="NFe">', '</LogPre>');
  cdsNFS.FieldByName('PSVNUM').AsString   := RetornaTexto(strXML, '<NumEndPre xmlns="NFe">', '</NumEndPre>');
  cdsNFS.FieldByName('PSVBAI').AsString   := RetornaTexto(strXML, '<BairroPre xmlns="NFe">', '</BairroPre>');
  cdsNFS.FieldByName('PSVCID').AsString   := RetornaTexto(strXML, '<MunPre xmlns="NFe">', '</MunPre>');
  cdsNFS.FieldByName('PSVCEP').AsString   := RetornaTexto(strXML, '<CepPre xmlns="NFe">', '</CepPre>');
  cdsNFS.FieldByName('PSVUF').AsString    := RetornaTexto(strXML, '<SiglaUFPre xmlns="NFe">', '</SiglaUFPre>');
  cdsNFS.FieldByName('PSVCOMPL').AsString := RetornaTexto(strXML, '<ComplEndPre xmlns="NFe">', '</ComplEndPre>');
  cdsNFS.FieldByName('PSVEMAIL').AsString := RetornaTexto(strXML, '<EmailPre xmlns="NFe">', '</EmailPre>');

  cdsNFS.FieldByName('TRINFE').AsString   := RetornaTexto(strXML, '<TipoTribPre xmlns="NFe">', '</TipoTribPre>');
  cdsNFS.FieldByName('VLRSER').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<VlNFS xmlns="NFe">', '</VlNFS>'),'.',','), 0);
  cdsNFS.FieldByName('VLRDED').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<VlNFS xmlns="NFe">', '</VlNFS>'),'.',','), 0);

  cdsNFS.FieldByName('CODSER').AsString   := Copy(RetornaTexto(strXML, '<CodSrv xmlns="NFe">', '</CodSrv>'),1,2)+
                                             Copy(RetornaTexto(strXML, '<CodSrv xmlns="NFe">', '</CodSrv>'),4,2);

  cdsNFS.FieldByName('ISSRET').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<VlIssRet xmlns="NFe">', '</VlIssRet>'),'.',','), 0);
  cdsNFS.FieldByName('ALISER').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<AlqIss xmlns="NFe">', '</AlqIss>'),'.',','), 0);
  cdsNFS.FieldByName('ISSRET').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<VlIssRet xmlns="NFe">', '</VlIssRet>'),'.',','), 0);
  cdsNFS.FieldByName('TOMCNPJ').AsString  := RetornaTexto(strXML, '<CpfCnpjTom xmlns="NFe">', '</CpfCnpjTom>');
  cdsNFS.FieldByName('TOMIE').AsString    := '';
  cdsNFS.FieldByName('TOMRAZAO').AsString := RetornaTexto(strXML, '<RazSocTom xmlns="NFe">', '</RazSocTom>');
  cdsNFS.FieldByName('TOMEND').AsString   := RetornaTexto(strXML, '<LogTom xmlns="NFe">', '</LogTom>');
  cdsNFS.FieldByName('TOMNUM').AsString   := RetornaTexto(strXML, '<NumEndTom xmlns="NFe">', '</NumEndTom>');
  cdsNFS.FieldByName('TOMBAI').AsString   := RetornaTexto(strXML, '<BairroTom xmlns="NFe">', '</BairroTom>');
  cdsNFS.FieldByName('TOMCID').AsString   := RetornaTexto(strXML, '<MunTom xmlns="NFe">', '</MunTom>');
  cdsNFS.FieldByName('TOMCEP').AsString   := RetornaTexto(strXML, '<CepTom xmlns="NFe">', '</CepTom>');
  cdsNFS.FieldByName('TOMUF').AsString    := RetornaTexto(strXML, '<SiglaUFTom xmlns="NFe">', '</SiglaUFTom>');
  cdsNFS.FieldByName('TOMEMA').AsString   := RetornaTexto(strXML, '<EMailTom xmlns="NFe">', '</EMailTom>');
  cdsNFS.FieldByName('DISSER').AsString   := RetornaTexto(strXML, '<DiscrSrv xmlns="NFe">', '</DiscrSrv>');

  cdsNFS.FieldByName('LOCPRE').AsString   := RetornaTexto(strXML, '<LogLocPre xmlns="NFe">', '</LogLocPre>');
  cdsNFS.FieldByName('LOCNUM').AsString   := RetornaTexto(strXML, '<NumEndLocPre xmlns="NFe">', '</NumEndLocPre>');
  cdsNFS.FieldByName('LOCCPL').AsString   := '';
  cdsNFS.FieldByName('LOCBAI').AsString   := RetornaTexto(strXML, '<BairroLocPre xmlns="NFe">', '</BairroLocPre>');
  cdsNFS.FieldByName('LOCMUN').AsString   := RetornaTexto(strXML, '<MunLocPre xmlns="NFe">', '</MunLocPre>');
  cdsNFS.FieldByName('LOC_UF').AsString   := RetornaTexto(strXML, '<SiglaUFLocpre xmlns="NFe">', '</SiglaUFLocpre>');
  cdsNFS.FieldByName('LOCCEP').AsString   := RetornaTexto(strXML, '<CepLocPre xmlns="NFe">', '</CepLocPre>');

  cdsNFS.Post;

end;

end.
