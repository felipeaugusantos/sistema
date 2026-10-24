unit untCajuruXML;

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
  TCajuruXML = class

    private

    public
      class procedure pRetornaCDSPreenchido(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil);
      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil);

  end;

implementation

{ TCajuruXML }

class procedure TCajuruXML.pRetornaCDSPreenchido(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil);
var
  strReg20Item : String;
  NoInfNfse : IXMLDocument;
  dtDataVenIss : TDate;
  wDia, wMes, wAno : Word;

begin
  NoInfNfse := TXMLDocument.Create(Application);

  NoInfNfse.LoadFromXML(strXML);
  NoInfNfse.Active := True;
  cdsNFS.Append;
  strReg20Item := RetornaTexto(strXML, '<Reg20Item>', '</Reg20Item>');

  dtDataVenIss := StrToDate(NoInfNfse.ChildNodes['SDT_ConsultaNotasProtocoloOut.XML_Notas.Reg20Item'].ChildNodes['DtEmiRps'].Text);
  DecodeDate(dtDataVenIss, wAno, wMes, wDia);
  If wMes = 12 Then
  Begin
    dtDataVenIss := EncodeDate(wAno + 1, 01, 15);
  End
  Else
  Begin
    dtDataVenIss := EncodeDate(wAno, wMes + 1, 15);
  End;

  cdsNFS.FieldByName('DTVENISS').AsString    := DateToStr(dtDataVenIss);
  cdsNFS.FieldByName('PSVIM').AsString    := '';
  cdsNFS.FieldByName('NUMNFS').AsString   := NoInfNfse.ChildNodes['SDT_ConsultaNotasProtocoloOut.XML_Notas.Reg20Item'].ChildNodes['NumNf'].Text;
  cdsNFS.FieldByName('SERNFE').AsString   := NoInfNfse.ChildNodes['SDT_ConsultaNotasProtocoloOut.XML_Notas.Reg20Item'].ChildNodes['SerNf'].Text;
  cdsNFS.FieldByName('CODVER').AsString   := NoInfNfse.ChildNodes['SDT_ConsultaNotasProtocoloOut.XML_Notas.Reg20Item'].ChildNodes['CodVernf'].Text;
  cdsNFS.FieldByName('DTAEMI').AsString   := NoInfNfse.ChildNodes['SDT_ConsultaNotasProtocoloOut.XML_Notas.Reg20Item'].ChildNodes['DtHrGerNf'].Text;
  cdsNFS.FieldByName('SERRPS').AsString   := NoInfNfse.ChildNodes['SDT_ConsultaNotasProtocoloOut.XML_Notas.Reg20Item'].ChildNodes['SerRps'].Text;
  cdsNFS.FieldByName('NUMRPS').AsString   := NoInfNfse.ChildNodes['SDT_ConsultaNotasProtocoloOut.XML_Notas.Reg20Item'].ChildNodes['NumRps'].Text;
  cdsNFS.FieldByName('TPORPS').AsString   := '';
  cdsNFS.FieldByName('EMIRPS').AsString   := NoInfNfse.ChildNodes['SDT_ConsultaNotasProtocoloOut.XML_Notas.Reg20Item'].ChildNodes['DtEmiRps'].Text;

  cdsNFS.FieldByName('DISCRDED').AsString  := NoInfNfse.ChildNodes['SDT_ConsultaNotasProtocoloOut.XML_Notas.Reg20Item'].ChildNodes['DiscrDed'].Text;
  cdsNFS.FieldByName('PSVCNPJ').AsString  := NoInfNfse.ChildNodes['SDT_ConsultaNotasProtocoloOut.XML_Notas.Reg20Item'].ChildNodes['CpfCnpjPre'].Text;
  cdsNFS.FieldByName('PSVRAZAO').AsString := NoInfNfse.ChildNodes['SDT_ConsultaNotasProtocoloOut.XML_Notas.Reg20Item'].ChildNodes['RazSocPre'].Text;
  cdsNFS.FieldByName('PSVEND').AsString   := NoInfNfse.ChildNodes['SDT_ConsultaNotasProtocoloOut.XML_Notas.Reg20Item'].ChildNodes['LogPre'].Text;
  cdsNFS.FieldByName('PSVNUM').AsString   := NoInfNfse.ChildNodes['SDT_ConsultaNotasProtocoloOut.XML_Notas.Reg20Item'].ChildNodes['NumEndPre'].Text;
  cdsNFS.FieldByName('PSVBAI').AsString   := NoInfNfse.ChildNodes['SDT_ConsultaNotasProtocoloOut.XML_Notas.Reg20Item'].ChildNodes['BairroPre'].Text;
  cdsNFS.FieldByName('PSVCID').AsString   := NoInfNfse.ChildNodes['SDT_ConsultaNotasProtocoloOut.XML_Notas.Reg20Item'].ChildNodes['MunPre'].Text;
  cdsNFS.FieldByName('PSVCEP').AsString   := NoInfNfse.ChildNodes['SDT_ConsultaNotasProtocoloOut.XML_Notas.Reg20Item'].ChildNodes['CepPre'].Text;
  cdsNFS.FieldByName('PSVUF').AsString    := NoInfNfse.ChildNodes['SDT_ConsultaNotasProtocoloOut.XML_Notas.Reg20Item'].ChildNodes['SiglaUFPre'].Text;
  cdsNFS.FieldByName('STATUS').AsString   := '';

  cdsNFS.FieldByName('TRINFE').AsString   := NoInfNfse.ChildNodes['SDT_ConsultaNotasProtocoloOut.XML_Notas.Reg20Item'].ChildNodes['TipoTribPre'].Text;
  cdsNFS.FieldByName('VLRSER').AsFloat    := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['SDT_ConsultaNotasProtocoloOut.XML_Notas.Reg20Item'].ChildNodes['VlNFS'].Text,'.',','), 0);
  cdsNFS.FieldByName('VLRDED').AsFloat    := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['SDT_ConsultaNotasProtocoloOut.XML_Notas.Reg20Item'].ChildNodes['VlNFS'].Text,'.',','), 0);

  cdsNFS.FieldByName('CODSER').AsString   := Copy(NoInfNfse.ChildNodes['SDT_ConsultaNotasProtocoloOut.XML_Notas.Reg20Item'].ChildNodes['CodSrv'].Text,1,2)+
                                             Copy(NoInfNfse.ChildNodes['SDT_ConsultaNotasProtocoloOut.XML_Notas.Reg20Item'].ChildNodes['CodSrv'].Text,4,2);

  cdsNFS.FieldByName('ALISER').AsFloat    := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['SDT_ConsultaNotasProtocoloOut.XML_Notas.Reg20Item'].ChildNodes['AlqIss'].Text,'.',','), 0);
  cdsNFS.FieldByName('ISSRET').AsFloat    := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['SDT_ConsultaNotasProtocoloOut.XML_Notas.Reg20Item'].ChildNodes['VlIssRet'].Text,'.',','), 0);
  cdsNFS.FieldByName('TOMCNPJ').AsString  := NoInfNfse.ChildNodes['SDT_ConsultaNotasProtocoloOut.XML_Notas.Reg20Item'].ChildNodes['CpfCnpjTom'].Text;
  cdsNFS.FieldByName('TOMIE').AsString    := '';
  cdsNFS.FieldByName('TOMRAZAO').AsString := NoInfNfse.ChildNodes['SDT_ConsultaNotasProtocoloOut.XML_Notas.Reg20Item'].ChildNodes['RazSocTom'].Text;
  cdsNFS.FieldByName('TOMEND').AsString   := NoInfNfse.ChildNodes['SDT_ConsultaNotasProtocoloOut.XML_Notas.Reg20Item'].ChildNodes['LogTom'].Text;
  cdsNFS.FieldByName('TOMNUM').AsString   := NoInfNfse.ChildNodes['SDT_ConsultaNotasProtocoloOut.XML_Notas.Reg20Item'].ChildNodes['NumEndTom'].Text;
  cdsNFS.FieldByName('TOMBAI').AsString   := NoInfNfse.ChildNodes['SDT_ConsultaNotasProtocoloOut.XML_Notas.Reg20Item'].ChildNodes['BairroTom'].Text;
  cdsNFS.FieldByName('TOMCID').AsString   := NoInfNfse.ChildNodes['SDT_ConsultaNotasProtocoloOut.XML_Notas.Reg20Item'].ChildNodes['MunTom'].Text;
  cdsNFS.FieldByName('TOMCEP').AsString   := NoInfNfse.ChildNodes['SDT_ConsultaNotasProtocoloOut.XML_Notas.Reg20Item'].ChildNodes['CepTom'].Text;
  cdsNFS.FieldByName('TOMUF').AsString   := NoInfNfse.ChildNodes['SDT_ConsultaNotasProtocoloOut.XML_Notas.Reg20Item'].ChildNodes['SiglaUFTom'].Text;
  cdsNFS.FieldByName('TOMEMA').AsString   := NoInfNfse.ChildNodes['SDT_ConsultaNotasProtocoloOut.XML_Notas.Reg20Item'].ChildNodes['EMailTom'].Text;
  cdsNFS.FieldByName('DISSER').AsString   := NoInfNfse.ChildNodes['SDT_ConsultaNotasProtocoloOut.XML_Notas.Reg20Item'].ChildNodes['DiscrSrv'].Text;

  cdsNFS.FieldByName('LOCPRE').AsString   := NoInfNfse.ChildNodes['SDT_ConsultaNotasProtocoloOut.XML_Notas.Reg20Item'].ChildNodes['LogLocPre'].Text;
  cdsNFS.FieldByName('LOCNUM').AsString   := NoInfNfse.ChildNodes['SDT_ConsultaNotasProtocoloOut.XML_Notas.Reg20Item'].ChildNodes['NumEndLocPre'].Text;
  cdsNFS.FieldByName('LOCCPL').AsString   := '';
  cdsNFS.FieldByName('LOCBAI').AsString   := NoInfNfse.ChildNodes['SDT_ConsultaNotasProtocoloOut.XML_Notas.Reg20Item'].ChildNodes['BairroLocPre'].Text;
  cdsNFS.FieldByName('LOCMUN').AsString   := NoInfNfse.ChildNodes['SDT_ConsultaNotasProtocoloOut.XML_Notas.Reg20Item'].ChildNodes['MunLocPre'].Text;
  cdsNFS.FieldByName('LOC_UF').AsString   := NoInfNfse.ChildNodes['SDT_ConsultaNotasProtocoloOut.XML_Notas.Reg20Item'].ChildNodes['SiglaUFLocpre'].Text;
  cdsNFS.FieldByName('LOCCEP').AsString   := NoInfNfse.ChildNodes['SDT_ConsultaNotasProtocoloOut.XML_Notas.Reg20Item'].ChildNodes['CepLocPre'].Text;

  cdsNFS.Post;

end;

class procedure TCajuruXML.pRetornaCDSPreenchidoComENotas(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil);
var
  strReg20Item: String;
  dtDataVenIss : TDate;
  wDia, wMes, wAno : Word;
begin

  cdsNFS.Append;
  strReg20Item := RetornaTexto(strXML, '<Reg20Item>', '</Reg20Item>');

  dtDataVenIss := StrToDate(RetornaTexto(strXML, '<DtEmiRps>', '</DtEmiRps>'));
  DecodeDate(dtDataVenIss, wAno, wMes, wDia);
  If wMes = 12 Then
  Begin
    dtDataVenIss := EncodeDate(wAno + 1, 01, 15);
  End
  Else
  Begin
    dtDataVenIss := EncodeDate(wAno, wMes + 1, 15);
  End;

  cdsNFS.FieldByName('DTVENISS').AsString    := DateToStr(dtDataVenIss);
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
  cdsNFS.FieldByName('DISSER').AsString   := RetornaTexto(strXML, '<DiscrSrv>', '</DiscrSrv>');

  cdsNFS.FieldByName('LOCPRE').AsString   := RetornaTexto(strXML, '<LogLocPre>', '</LogLocPre>');
  cdsNFS.FieldByName('LOCNUM').AsString   := RetornaTexto(strXML, '<NumEndLocPre>', '</NumEndLocPre>');
  cdsNFS.FieldByName('LOCCPL').AsString   := '';
  cdsNFS.FieldByName('LOCBAI').AsString   := RetornaTexto(strXML, '<BairroLocPre>', '</BairroLocPre>');
  cdsNFS.FieldByName('LOCMUN').AsString   := RetornaTexto(strXML, '<MunLocPre>', '</MunLocPre>');
  cdsNFS.FieldByName('LOC_UF').AsString   := RetornaTexto(strXML, '<SiglaUFLocpre>', '</SiglaUFLocpre>');
  cdsNFS.FieldByName('LOCCEP').AsString   := RetornaTexto(strXML, '<CepLocPre>', '</CepLocPre>');

  cdsNFS.Post;

end;

end.
