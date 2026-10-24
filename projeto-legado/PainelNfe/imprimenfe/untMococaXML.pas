unit untMococaXML;

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
  TMococaXML = class

    private

    public
      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil);

  end;

implementation

{ TMococaXML }


{ TMococaXML }

class procedure TMococaXML.pRetornaCDSPreenchidoComENotas(
  var cdsNFS: TUniClientDataSet; strXML, strCidadeNFSe: string;
  cdsItens: TUniClientDataSet);
begin

  cdsNFS.Append;
  cdsNFS.FieldByName('PSVIM').AsString    := '';
  cdsNFS.FieldByName('NUMNFS').AsString   := RetornaTexto(strXML, '<NumNf>', '</NumNf>');
  cdsNFS.FieldByName('SERNFE').AsString   := RetornaTexto(strXML, '<SerNf>', '</SerNf>');
  cdsNFS.FieldByName('CODVER').AsString   := RetornaTexto(strXML, '<CodVernf>', '</CodVernf>');
  cdsNFS.FieldByName('DTAEMI').AsString   := RetornaTexto(strXML, '<DtHrGerNf>', '</DtHrGerNf>');
  cdsNFS.FieldByName('SERRPS').AsString   := RetornaTexto(strXML, '<SerRps>', '</SerRps>');
  cdsNFS.FieldByName('NUMRPS').AsString   := RetornaTexto(strXML, '<NumRps>', '</NumRps>');
  cdsNFS.FieldByName('TPORPS').AsString   := '';
  cdsNFS.FieldByName('EMIRPS').AsString   := RetornaTexto(strXML, '<DtEmiRps>', '</DtEmiRps>');

  cdsNFS.FieldByName('DISCRDED').AsString  := RetornaTexto(strXML, '<DiscrDed>', '</DiscrDed>');
  cdsNFS.FieldByName('PSVCNPJ').AsString  := RetornaTexto(strXML, '<CpfCnpjPre>', '</CpfCnpjPre>');
  cdsNFS.FieldByName('PSVRAZAO').AsString := RetornaTexto(strXML, '<RazSocPre>', '</RazSocPre>');
  cdsNFS.FieldByName('PSVEND').AsString   := RetornaTexto(strXML, '<LogPre>', '</LogPre>');
  cdsNFS.FieldByName('PSVNUM').AsString   := RetornaTexto(strXML, '<NumEndPre>', '</NumEndPre>');
  cdsNFS.FieldByName('PSVBAI').AsString   := RetornaTexto(strXML, '<BairroPre>', '</BairroPre>');
  cdsNFS.FieldByName('PSVCPL').AsString   := RetornaTexto(strXML, '<ComplEndPre>', '</ComplEndPre>');
  cdsNFS.FieldByName('PSVCID').AsString   := RetornaTexto(strXML, '<MunPre>', '</MunPre>');
  cdsNFS.FieldByName('PSVCEP').AsString   := RetornaTexto(strXML, '<CepPre>', '</CepPre>');
  cdsNFS.FieldByName('PSVUF').AsString    := RetornaTexto(strXML, '<SiglaUFPre>', '</SiglaUFPre>');
  cdsNFS.FieldByName('STATUS').AsString   := '';

  cdsNFS.FieldByName('TRINFE').AsString   := RetornaTexto(strXML, '<TipoTribPre>', '</TipoTribPre>');
  cdsNFS.FieldByName('VLRSER').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<VlNFS>', '</VlNFS>'),'.',','), 0);
  cdsNFS.FieldByName('VLRDED').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<VlNFS>', '</VlNFS>'),'.',','), 0);

  cdsNFS.FieldByName('CODSER').AsString   := Copy(RetornaTexto(strXML, '<CodSrv>', '</CodSrv>'),1,2)+
                                             Copy(RetornaTexto(strXML, '<CodSrv>', '</CodSrv>'),4,2);

  cdsNFS.FieldByName('ALISER').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<AlqIss>', '</AlqIss>'),'.',','), 0);
  cdsNFS.FieldByName('ISSRET').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<VlIssRet>', '</VlIssRet>'),'.',','), 0);
  cdsNFS.FieldByName('TOMCNPJ').AsString  := RetornaTexto(strXML, '<CpfCnpjTom>', '</CpfCnpjTom>');
  cdsNFS.FieldByName('TOMIE').AsString    := '';
  cdsNFS.FieldByName('TOMRAZAO').AsString := RetornaTexto(strXML, '<RazSocTom>', '</RazSocTom>');
  cdsNFS.FieldByName('TOMEND').AsString   := RetornaTexto(strXML, '<LogTom>', '</LogTom>');
  cdsNFS.FieldByName('TOMNUM').AsString   := RetornaTexto(strXML, '<NumEndTom>', '</NumEndTom>');
  cdsNFS.FieldByName('TOMBAI').AsString   := RetornaTexto(strXML, '<BairroTom>', '</BairroTom>');
  cdsNFS.FieldByName('TOMCID').AsString   := RetornaTexto(strXML, '<MunTom>', '</MunTom>');
  cdsNFS.FieldByName('TOMCEP').AsString   := RetornaTexto(strXML, '<CepTom>', '</CepTom>');
  cdsNFS.FieldByName('TOMUF').AsString    := RetornaTexto(strXML, '<SiglaUFTom>', '</SiglaUFTom>');
  cdsNFS.FieldByName('TOMEMA').AsString   := RetornaTexto(strXML, '<EMailTom>', '</EMailTom>');
  cdsNFS.FieldByName('DISSER').AsString   := '';

  cdsNFS.FieldByName('LOCPRE').AsString   := RetornaTexto(strXML, '<LogLocPre>', '</LogLocPre>');
  cdsNFS.FieldByName('LOCNUM').AsString   := RetornaTexto(strXML, '<NumEndLocPre>', '</NumEndLocPre>');
  cdsNFS.FieldByName('LOCCPL').AsString   := RetornaTexto(strXML, '<ComplEndLocPre>', '</ComplEndLocPre>');
  cdsNFS.FieldByName('LOCBAI').AsString   := RetornaTexto(strXML, '<BairroLocPre>', '</BairroLocPre>');
  cdsNFS.FieldByName('LOCMUN').AsString   := RetornaTexto(strXML, '<MunLocPre>', '</MunLocPre>');
  cdsNFS.FieldByName('LOC_UF').AsString   := RetornaTexto(strXML, '<SiglaUFLocpre>', '</SiglaUFLocpre>');
  cdsNFS.FieldByName('LOCCEP').AsString   := RetornaTexto(strXML, '<CepLocPre>', '</CepLocPre>');

  cdsNFS.Post;

end;

end.
