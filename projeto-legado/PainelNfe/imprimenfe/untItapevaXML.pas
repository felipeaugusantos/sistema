unit untItapevaXML;

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
  untUtil, XMLIntf, XMLDoc, DB, DBClient, untBragancaPaulistaXML;

type
  TItapevaXML = class

    private

    public
      class procedure pRetornaCDSPreenchido(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil);
      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil);

  end;

implementation

{ TItapevaXML }

class procedure TItapevaXML.pRetornaCDSPreenchido(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil);
begin

  cdsNFS.Append;

  cdsNFS.FieldByName('NUMNFS').AsString   := RetornaTexto(strXML, '<NumNf>', '</NumNf>');
  cdsNFS.FieldByName('CODVER').AsString   := RetornaTexto(strXML, '<CodVernf>', '</CodVernf>');
  cdsNFS.FieldByName('DTAEMI').AsString   := Copy(RetornaTexto(strXML, '<DtHrGerNf>', '</DtHrGerNf>'),1,2)+'/'+
                                             Copy(RetornaTexto(strXML, '<DtHrGerNf>', '</DtHrGerNf>'),4,2)+'/'+
                                             Copy(RetornaTexto(strXML, '<DtHrGerNf>', '</DtHrGerNf>'),7,4);
  cdsNFS.FieldByName('DTHRCA').AsString   := Copy(RetornaTexto(strXML, '<DtHrGerNf>', '</DtHrGerNf>'),12,8);

  cdsNFS.FieldByName('NUMRPS').AsString   := RetornaTexto(strXML, '<NumRps>', '</NumRps>');
  cdsNFS.FieldByName('SERRPS').AsString   := RetornaTexto(strXML, '<SerRps>', '</SerRps>');
  cdsNFS.FieldByName('TPORPS').AsString   := '';
  cdsNFS.FieldByName('EMIRPS').AsString   := RetornaTexto(strXML, '<DtEmiRps>', '</DtEmiRps>');
  cdsNFS.FieldByName('STATUS').AsString   := '';

  cdsNFS.FieldByName('PSVIM').AsString    := '';
  cdsNFS.FieldByName('PSVCNPJ').AsString  := RetornaTexto(strXML, '<CpfCnpjPre>', '</CpfCnpjPre>');

  cdsNFS.FieldByName('PSVEND').AsString   := RetornaTexto(strXML, '<LogPre>', '</LogPre>');
  cdsNFS.FieldByName('PSVNUM').AsString   := RetornaTexto(strXML, '<NumEndPre>', '</NumEndPre>');
  cdsNFS.FieldByName('PSVBAI').AsString   := RetornaTexto(strXML, '<BairroPre>', '</BairroPre>');
  cdsNFS.FieldByName('PSVCID').AsString   := RetornaTexto(strXML, '<MunPre>', '</MunPre>');
  cdsNFS.FieldByName('PSVUF').AsString    := RetornaTexto(strXML, '<SiglaUFPre>', '</SiglaUFPre>');;
  cdsNFS.FieldByName('PSVCEP').AsString   := RetornaTexto(strXML, '<CepPre>', '</CepPre>');

  cdsNFS.FieldByName('LOCMUN').AsString   := '';
  cdsNFS.FieldByName('LOC_UF').AsString   := '';

  cdsNFS.FieldByName('TOMCNPJ').AsString  := RetornaTexto(strXML, '<CpfCnpjTom>', '</CpfCnpjTom>');
  cdsNFS.FieldByName('TOMIE').AsString    := '';
  cdsNFS.FieldByName('TOMRAZAO').AsString := RetornaTexto(strXML, '<RazSocTom>', '</RazSocTom>');
  cdsNFS.FieldByName('TOMEND').AsString   := RetornaTexto(strXML, '<LogTom>', '</LogTom>');
  cdsNFS.FieldByName('TOMNUM').AsString   := RetornaTexto(strXML, '<NumEndTom>', '</NumEndTom>');
  cdsNFS.FieldByName('TOMBAI').AsString   := RetornaTexto(strXML, '<BairroTom>', '</BairroTom>');
  cdsNFS.FieldByName('TOMCID').AsString   := RetornaTexto(strXML, '<MunTom>', '</MunTom>');
  cdsNFS.FieldByName('TOMUF').AsString    := RetornaTexto(strXML, '<SiglaUFTom>', '</SiglaUFTom>');
  cdsNFS.FieldByName('TOMCEP').AsString   := RetornaTexto(strXML, '<CepTom>', '</CepTom>');
  cdsNFS.FieldByName('TOMEMA').AsString   := RetornaTexto(strXML, '<EMailTom>', '</EMailTom>');

  cdsNFS.FieldByName('DISSER').AsString   := RetornaTexto(strXML, '<DiscrSrv>', '</DiscrSrv>');
  cdsNFS.FieldByName('CODSER').AsString   := RetornaTexto(strXML, '<CodSrv>', '</CodSrv>');

  cdsNFS.FieldByName('VLRSER').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<VlBasCalc>', '</VlBasCalc>'),'.',','), 0);
  cdsNFS.FieldByName('ALISER').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<AlqIss>', '</AlqIss>'),'.',','), 0);
  cdsNFS.FieldByName('VALINS').AsFloat    := 0;
  cdsNFS.FieldByName('VALIRR').AsFloat    := 0;
  cdsNFS.FieldByName('VALCSL').AsFloat    := 0;
  cdsNFS.FieldByName('VALCOF').AsFloat    := 0;
  cdsNFS.FieldByName('VALPIS').AsFloat    := 0;
  cdsNFS.FieldByName('VLRISS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<VlIss>', '</VlIss>'),'.',','), 0);
  cdsNFS.FieldByName('ISSRET').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<VlIssRet>', '</VlIssRet>'),'.',','), 0);
  cdsNFS.FieldByName('VLRLIQ').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<VlNFS>', '</VlNFS>'),'.',','), 0);

  cdsNFS.Post;

end;

class procedure TItapevaXML.pRetornaCDSPreenchidoComENotas(
  var cdsNFS: TUniClientDataSet; strXML, strCidadeNFSe: string;
  cdsItens: TUniClientDataSet);
begin

  TBragancaPaulistaXML.pRetornaCDSPreenchidoComENotas(cdsNFS, strXML);

end;

end.
