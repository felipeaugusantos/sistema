unit untDescalvadoXML;

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
  TDescalvadoXML = class

    private

    public
      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='');

  end;

implementation

{ TDescalvadoXML }

class procedure TDescalvadoXML.pRetornaCDSPreenchidoComENotas(
  var cdsNFS: TUniClientDataSet; strXML, strCidadeNFSe: string);
var
  strDadosNota,
  strDadosItens,
  strDadosPrestador,
  strDadosTomador,
  strDados : String;
begin

  cdsNFS.Append;

  strDadosNota := RetornaTexto(strXML, '</itens>', '</nf-e>');

  cdsNFS.FieldByName('NUMNFS').AsString   := RetornaTexto(strDadosNota, '<numero>','</numero>');
  cdsNFS.FieldByName('CODVER').AsString   := RetornaTexto(strDadosNota, '<senha>', '</senha>');
  cdsNFS.FieldByName('SERNFS').AsString   := RetornaTexto(strDadosNota, '<serie>', '</serie>');
  cdsNFS.FieldByName('VLRLIQ').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDadosNota, '<valorLiquido>', '</valorLiquido>'),'.',','), 0);
  cdsNFS.FieldByName('VLRTOT').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDadosNota, '<valorTotal>', '</valorTotal>'),'.',','), 0);
  cdsNFS.FieldByName('VLRBAS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDadosNota, '<valorBase>', '</valorBase>'),'.',','), 0);
  cdsNFS.FieldByName('VLRIMP').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDadosNota, '<valorImposto>', '</valorImposto>'),'.',','), 0);
  cdsNFS.FieldByName('SEROBS').AsString   := RetornaTexto(strDadosNota, '<obs>', '</obs>');
  cdsNFS.FieldByName('DEDUCA').AsString   := RetornaTexto(strDadosNota, '<deducoes>', '</deducoes>');


  strDadosPrestador := RetornaTexto(strXML, '<prestador>', '</prestador>');
  cdsNFS.FieldByName('PSVCNPJ').AsString  := RetornaTexto(strDadosPrestador, '<documento>', '</documento>');
  cdsNFS.FieldByName('PSVRAZAO').AsString := RetornaTexto(strDadosPrestador, '<nome>', '</nome>');
  cdsNFS.FieldByName('PSVEMAIL').AsString := RetornaTexto(strDadosPrestador, '<email>', '</email>');
  cdsNFS.FieldByName('PSVEND').AsString := '';
  cdsNFS.FieldByName('PSVNUM').AsString := '';
  cdsNFS.FieldByName('PSVBAI').AsString := '';
  cdsNFS.FieldByName('PSVCID').AsString := '';
  cdsNFS.FieldByName('PSVCEP').AsString := '';
  cdsNFS.FieldByName('PSVFON').AsString := '';
  cdsNFS.FieldByName('PSVCPL').AsString := '';
  cdsNFS.FieldByName('PSVUF_').AsString := '';
  cdsNFS.FieldByName('PSVIE_').AsString := '';


  strDadosTomador := RetornaTexto(strXML, '<tomador>', '</tomador>');
  cdsNFS.FieldByName('TOMCNPJ').AsString  := RetornaTexto(strDadosTomador, '<documento>', '</documento>');
  cdsNFS.FieldByName('TOMRAZAO').AsString := RetornaTexto(strDadosTomador, '<nome>', '</nome>');
  cdsNFS.FieldByName('TOMEND').AsString   := RetornaTexto(strDadosTomador, '<logradouro>', '</logradouro>');
  cdsNFS.FieldByName('TOMNUM').AsString   := RetornaTexto(strDadosTomador, '<numero>', '</numero>');
  cdsNFS.FieldByName('TOMBAI').AsString   := RetornaTexto(strDadosTomador, '<bairro>', '</bairro>');
  cdsNFS.FieldByName('TOMCID').AsString   := RetornaTexto(strDadosTomador, '<municipio>', '</municipio>');
  cdsNFS.FieldByName('TOMCEP').AsString   := RetornaTexto(strDadosTomador, '<cep>', '</cep>');
  cdsNFS.FieldByName('TOMEMA').AsString   := RetornaTexto(strDadosTomador, '<email>', '</email>');
  cdsNFS.FieldByName('TMSFONE').AsString  := RetornaTexto(strDadosTomador, '<telefone>', '</telefone>');
  cdsNFS.FieldByName('TMSCOMPL').AsString := RetornaTexto(strDadosTomador, '<complemento>', '</complemento>');
  cdsNFS.FieldByName('TOMUF').AsString    := RetornaTexto(strDadosTomador, '<estado>', '</estado>');
  cdsNFS.FieldByName('TMSIE').AsString    := '';

  strDados := RetornaTexto(strXML, '<nf-e>', '<prestador>');
  cdsNFS.FieldByName('DTAEMI').AsString   := RetornaTexto(strDados, '<prestacao>', '</strDados>');
  cdsNFS.FieldByName('DTAVEN').AsString   := RetornaTexto(strDados, '<vencimento>', '</vencimento>');
  cdsNFS.FieldByName('EXIGIB').AsString   := RetornaTexto(strDados, '<exigibilidade>', '</exigibilidade>');
  cdsNFS.FieldByName('ISS_RET').AsString   := RetornaTexto(strDados, '<retido>', '</retido>');
  cdsNFS.FieldByName('MUNINC').AsString   := RetornaTexto(strDados, '<municipioIncidencia>', '</municipioIncidencia>');
  cdsNFS.FieldByName('MUNPRE').AsString   := RetornaTexto(strDados, '<municipioPrestacao>', '</municipioPrestacao>');
  cdsNFS.FieldByName('CODSER').AsString   := RetornaTexto(strDados, '<atividade>', '</atividade>');
  cdsNFS.FieldByName('ALISER').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDados, '<aliquota>', '</aliquota>'),'.',','), 0);
  cdsNFS.FieldByName('DTAEMI').AsString := Copy(RetornaTexto(strDados, '<prestacao>', '</prestacao>'),9,2)+'/'+
                                           Copy(RetornaTexto(strDados, '<prestacao>', '</prestacao>'),6,2)+'/'+
                                           Copy(RetornaTexto(strDados, '<prestacao>', '</prestacao>'),1,4);

  cdsNFS.FieldByName('DTAVEN').AsString := Copy(RetornaTexto(strDados, '<vencimento>', '</vencimento>'),9,2)+'/'+
                                           Copy(RetornaTexto(strDados, '<vencimento>', '</vencimento>'),6,2)+'/'+
                                           Copy(RetornaTexto(strDados, '<vencimento>', '</vencimento>'),1,4);

  strDadosItens := RetornaTexto(strXML, '<itens>', '</itens>');
  cdsNFS.FieldByName('ITEDES').AsString := RetornaTexto(strDadosItens, '<descricao>', '</descricao>');
  cdsNFS.FieldByName('ITEQTD').AsFloat  := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDadosItens, '<quantidade>', '</quantidade>'),'.',','), 0);
  cdsNFS.FieldByName('VLRUNT').AsFloat  := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDadosItens, '<valorUn>', '</valorUn>'),'.',','), 0);
  cdsNFS.FieldByName('ITETOT').AsFloat  := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDadosItens, '<valor>', '</valor>'),'.',','), 0);

  cdsNFS.Post;
end;

end.
