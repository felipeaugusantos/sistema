unit untTambauXML;

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
  TTambauXML = class

    private

    public

      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS: TUniClientDataSet; strXML: string);

  end;

implementation

{ TTambauXML }

class procedure TTambauXML.pRetornaCDSPreenchidoComENotas(var cdsNFS: TUniClientDataSet; strXML: string);
begin

  cdsNFS.Append;
  // Dados da NFS
  cdsNFS.FieldByName('NUMNFS').AsString := RetornaTexto(strXML, '<COD>', '</COD>');
  cdsNFS.FieldByName('CODVER').AsString := RetornaTexto(strXML, '<RPS>', '</RPS>');
  cdsNFS.FieldByName('DTAEMI').AsString := RetornaTexto(strXML, '<DATA>', '</DATA>');
  cdsNFS.FieldByName('DTAHRA').AsString := RetornaTexto(strXML, '<HORA>', '</HORA>');
  cdsNFS.FieldByName('LOCSER').ASString := RetornaTexto(strXML, '<LOCALSERV>', '</LOCALSERV>');
  cdsNFS.FieldByName('UFFORA').ASString := RetornaTexto(strXML, '<UFFORA>', '</UFFORA>');
  cdsNFS.FieldByName('MUNFOR').ASString := RetornaTexto(strXML, '<MUNICIPIOFORA>', '</MUNICIPIOFORA>');
  cdsNFS.FieldByName('DTAVEN').AsString := RetornaTexto(strXML, '<DATAVENCIMENTO>', '</DATAVENCIMENTO>');

  cdsNFS.FieldByName('SERRPS').AsString := RetornaTexto(strXML, '<SERIECOD>', '</SERIECOD>');
  cdsNFS.FieldByName('TPORPS').AsString := '';
  cdsNFS.FieldByName('EMIRPS').AsString := '';
  cdsNFS.FieldByName('NATOPE').AsString := '';
  cdsNFS.FieldByName('CODRET').AsString := '';
  cdsNFS.FieldByName('EMIOSN').AsString := RetornaTexto(strXML, '<SITDESC>', '</SITDESC>');
  cdsNFS.FieldByName('EMIICC').AsString := '';
  cdsNFS.FieldByName('COMPET').AsString := RetornaTexto(strXML, '<DATA>', '</DATA>')+' '+
                                           RetornaTexto(strXML, '<HORA>', '</HORA>');
  cdsNFS.FieldByName('OUTINF').AsString := StringReplace(RetornaTexto(strXML, '<OBSSERVICO>', '</OBSSERVICO>'), '&lt;o:p&gt;&lt;/o:p&gt;&lt;/p&gt;', EmptyStr, [rfReplaceAll]);
  cdsNFS.FieldByName('OUTINF').AsString := StringReplace(cdsNFS.FieldByName('OUTINF').AsString, 'class=&quot;MsoNormal&quot;', EmptyStr, [rfReplaceAll]);
  cdsNFS.FieldByName('OUTINF').AsString := StringReplace(cdsNFS.FieldByName('OUTINF').AsString, '&amp;nbsp;', EmptyStr, [rfReplaceAll]);
  cdsNFS.FieldByName('OUTINF').AsString := StringReplace(cdsNFS.FieldByName('OUTINF').AsString, '&lt;p', EmptyStr, [rfReplaceAll]);
  cdsNFS.FieldByName('OUTINF').AsString := StringReplace(cdsNFS.FieldByName('OUTINF').AsString, '&lt;br /&gt;', EmptyStr, [rfReplaceAll]);
  cdsNFS.FieldByName('OUTINF').AsString := StringReplace(cdsNFS.FieldByName('OUTINF').AsString, '&gt;', '', [rfReplaceAll]);
  cdsNFS.FieldByName('_LINK_').AsString := RetornaTexto(strXML, '<LINK>', '</LINK>');

  //Valores
  cdsNFS.FieldByName('VLRSER').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<VALORTOTALSERVICOS>', '</VALORTOTALSERVICOS>'),'.',','), 0);
  cdsNFS.FieldByName('ISS_RET').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<RETIDO>', '</RETIDO>'),'.',','), 0);
  cdsNFS.FieldByName('VLRISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<IMPOSTO>', '</IMPOSTO>'),'.',','), 0);
  cdsNFS.FieldByName('BSCISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<BASECALC>', '</BASECALC>'),'.',','), 0);
  cdsNFS.FieldByName('ALIISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ALIQUOTA>', '</ALIQUOTA>'),'.',','), 0);
  cdsNFS.FieldByName('CODSER').AsString := RetornaTexto(strXML, '<ATIVCOD>', '</ATIVCOD>');
  cdsNFS.FieldByName('DESSER').AsString := RetornaTexto(strXML, '<ATIVDESC>', '</ATIVDESC>');
  cdsNFS.FieldByName('VALPIS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<PIS>', '</PIS>'),'.',','), 0);
  cdsNFS.FieldByName('VALCOF').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<COFINS>', '</COFINS>'),'.',','), 0);
  cdsNFS.FieldByName('VLRINS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<INSS>', '</INSS>'),'.',','), 0);
  cdsNFS.FieldByName('VLRIR_').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<IR>', '</IR>'),'.',','), 0);
  cdsNFS.FieldByName('VLRCSL').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<CSLL>', '</CSLL>'),'.',','), 0);
  cdsNFS.FieldByName('OUT_RET').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<OUT_RET>', '</OUT_RET>'),'.',','), 0);
  cdsNFS.FieldByName('OUTTRI').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<OUTROSTRIBUTOS>', '</OUTROSTRIBUTOS>'),'.',','), 0);
  cdsNFS.FieldByName('VLRCID').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<CIDE>', '</CIDE>'),'.',','), 0);
  cdsNFS.FieldByName('VLRIOF').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<IOF>', '</IOF>'),'.',','), 0);
  cdsNFS.FieldByName('VLRIPI').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<IPI>', '</IPI>'),'.',','), 0);
  cdsNFS.FieldByName('VLRICM').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ICMS>', '</ICMS>'),'.',','), 0);
  cdsNFS.FieldByName('CDCNAE').AsString := '';
  cdsNFS.FieldByName('CODTRI').AsString := '';
  cdsNFS.FieldByName('DISCRI').AsString := RetornaTexto(strXML, '<DESCRICAO>', '</DESCRICAO>');
  cdsNFS.FieldByName('CODMUN').AsString := '';
  cdsNFS.FieldByName('ITEDESC').AsString := RetornaTexto(strXML, '<DESCRICAO>', '</DESCRICAO>');

  cdsNFS.FieldByName('ITEQTD').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<QUANTIDADE>', '</QUANTIDADE>'),'.',','), 0);
  cdsNFS.FieldByName('ITEVLU').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<VALOR>', '</VALOR>'),'.',','), 0);
  cdsNFS.FieldByName('VLRLIQ').AsFloat := StrToFloatDef(FormatFloat('#,##0.00', cdsNFS.FieldByName('ITEQTD').AsFloat * cdsNFS.FieldByName('ITEVLU').AsFloat), 0);
  //Prestador
  cdsNFS.FieldByName('PSVCNPJ').AsString := RetornaTexto(strXML, '<PRESTCPFCNPJ>', '</PRESTCPFCNPJ>');
  cdsNFS.FieldByName('PSVCDMO').AsString := RetornaTexto(strXML, '<PRESTCODMOBILIARIO>', '</PRESTCODMOBILIARIO>');
  cdsNFS.FieldByName('PSVIM').AsString := RetornaTexto(strXML, '<PRESTINSCRICAOMUN>', '</PRESTINSCRICAOMUN>');
  cdsNFS.FieldByName('PSVRAZAO').AsString := RetornaTexto(strXML, '<PRESTNOMERAZAO>', '</PRESTNOMERAZAO>');
  cdsNFS.FieldByName('PSVFANT').AsString := '';
  cdsNFS.FieldByName('PSVEND').AsString := RetornaTexto(strXML, '<PRESTPREFIXODESC>', '</PRESTPREFIXODESC>')+' '+
                                           RetornaTexto(strXML, '<PRESTLOGDESC>', '</PRESTLOGDESC>');
  cdsNFS.FieldByName('PSVNUM').AsString := RetornaTexto(strXML, '<PRESTNUMERO>', '</PRESTNUMERO>');
  cdsNFS.FieldByName('PSVCOMPL').AsString := '';
  cdsNFS.FieldByName('PSVBAIR').AsString := RetornaTexto(strXML, '<PRESTBAIRRODESC>', '</PRESTBAIRRODESC>');
  cdsNFS.FieldByName('PSVMUN').AsString := RetornaTexto(strXML, '<PRESTMUNICIPIOCOD>', '</PRESTMUNICIPIOCOD>');
  cdsNFS.FieldByName('PSVUF').AsString := RetornaTexto(strXML, '<PRESTMUNICIPIOUF>', '</PRESTMUNICIPIOUF>');
  cdsNFS.FieldByName('PSVCEP').AsString := RetornaTexto(strXML, '<PRESTCEP>', '</PRESTCEP>');

  cdsNFS.FieldByName('PSVFONE').AsString := RetornaTexto(strXML, '<TelefonePrestado>', '</TelefonePrestado>');
  cdsNFS.FieldByName('PSVEMAIL').AsString := RetornaTexto(strXML, '<EmailPrestador>', '</EmailPrestador>');
  //Tomador
  cdsNFS.FieldByName('TMSCNPJ').AsString := RetornaTexto(strXML, '<TOMCPFCNPJ>', '</TOMCPFCNPJ>');
  cdsNFS.FieldByName('TMSIE').AsString := RetornaTexto(strXML, '<TOMRGIE>', '</TOMRGIE>');
  cdsNFS.FieldByName('TMSCDMO').AsString := RetornaTexto(strXML, '<TOMCODMOBILIARIO>', '</TOMCODMOBILIARIO>');
  cdsNFS.FieldByName('TMSIM').AsString := '';
  cdsNFS.FieldByName('TMSRAZAO').AsString := RetornaTexto(strXML, '<TOMNOMERAZAO>', '</TOMNOMERAZAO>');
  cdsNFS.FieldByName('TMSFANTA').AsString := '';
  cdsNFS.FieldByName('TMSEND').AsString := RetornaTexto(strXML, '<TOMPREFIXODESC>', '</TOMPREFIXODESC>')+' '+
                                           RetornaTexto(strXML, '<TOMLOGDESC>', '</TOMLOGDESC>');
  cdsNFS.FieldByName('TMSNUM').AsString := RetornaTexto(strXML, '<TOMNUMERO>', '</TOMNUMERO>');
  cdsNFS.FieldByName('TMSCOMPL').AsString := '';
  cdsNFS.FieldByName('TMSBAIR').AsString := RetornaTexto(strXML, '<TOMBAIRRODESC>', '</TOMBAIRRODESC>');
  cdsNFS.FieldByName('TMSMUN').AsString := RetornaTexto(strXML, '<TOMMUNICIPIOCOD>', '</TOMMUNICIPIOCOD>');
  cdsNFS.FieldByName('TMSUF').AsString := RetornaTexto(strXML, '<TOMMUNICIPIOUF>', '</TOMMUNICIPIOUF>');
  cdsNFS.FieldByName('TMSCEP').AsString := RetornaTexto(strXML, '<TOMCEP>', '</TOMCEP>');
  cdsNFS.FieldByName('TMSFONE').AsString := RetornaTexto(strXML, '<TelefoneTomador>', '</TelefoneTomador>');
  cdsNFS.FieldByName('TMSEMAIL').AsString := RetornaTexto(strXML, '<EmailTomador>', '</EmailTomador>');

  cdsNFS.FieldByName('DEDMAT').AsString := RetornaTexto(strXML, '<DEDMATERIAIS>', '</DEDMATERIAIS>');

  cdsNFS.Post;

end;

end.
