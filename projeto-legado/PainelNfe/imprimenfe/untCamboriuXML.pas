unit untCamboriuXML;

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
  TCamboriuXML = class

    private

    public
      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='');

  end;

implementation

{ TCamboriuXML }

class procedure TCamboriuXML.pRetornaCDSPreenchidoComENotas(
  var cdsNFS: TUniClientDataSet; strXML, strCidadeNFSe: string);
var
  strDadosNota,
  strDadosItens,
  strDadosTomador : String;
begin

  cdsNFS.Append;

  strDadosNota := RetornaTexto(strXML, '<Nota>', '</Nota>');

  cdsNFS.FieldByName('NUMNFS').AsString   := RetornaTexto(strDadosNota, '<iNota>','</iNota>');
  cdsNFS.FieldByName('CODREC').AsString   := RetornaTexto(strDadosNota, '<iRecibo>','</iRecibo>');
  cdsNFS.FieldByName('CODVER').AsString   := RetornaTexto(strDadosNota, '<sCodigoVerificador>', '</sCodigoVerificador>');
  cdsNFS.FieldByName('SERNFS').AsString   := RetornaTexto(strDadosNota, '<sSerie>', '</serie>');
  cdsNFS.FieldByName('VLRBAS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDadosNota, '<nValorBaseCalculo>', '</nValorBaseCalculo>'),'.',','), 0);
  cdsNFS.FieldByName('DTAEMI').AsString := Copy(RetornaTexto(strDadosNota, '<dDataEmissao>', '</dDataEmissao>'),9,2)+'/'+
                                           Copy(RetornaTexto(strDadosNota, '<dDataEmissao>', '</dDataEmissao>'),6,2)+'/'+
                                           Copy(RetornaTexto(strDadosNota, '<dDataEmissao>', '</dDataEmissao>'),1,4);


  cdsNFS.FieldByName('PSVCNPJ').AsString  := RetornaTexto(strDadosNota, '<sContribuinte>', '</sContribuinte>');
  cdsNFS.FieldByName('PSVRAZAO').AsString := '';
  cdsNFS.FieldByName('PSVEMAIL').AsString := '';
  cdsNFS.FieldByName('PSVEND').AsString := '';
  cdsNFS.FieldByName('PSVNUM').AsString := '';
  cdsNFS.FieldByName('PSVBAI').AsString := '';
  cdsNFS.FieldByName('PSVCID').AsString := '';
  cdsNFS.FieldByName('PSVCEP').AsString := '';
  cdsNFS.FieldByName('PSVFON').AsString := '';
  cdsNFS.FieldByName('PSVCPL').AsString := '';
  cdsNFS.FieldByName('PSVUF_').AsString := '';
  cdsNFS.FieldByName('PSVIE_').AsString := '';


  strDadosTomador := RetornaTexto(strXML, '<tTomador>', '</tTomador>');
  cdsNFS.FieldByName('TOMCNPJ').AsString  := RetornaTexto(strDadosTomador, '<sCPFTomador>', '</sCPFTomador>');
  cdsNFS.FieldByName('TOMRAZAO').AsString := RetornaTexto(strDadosTomador, '<sNomeTomador>', '</sNomeTomador>');
  cdsNFS.FieldByName('TOMEND').AsString   := RetornaTexto(strDadosTomador, '<sEnderecoTomador>', '</sEnderecoTomador>');
  cdsNFS.FieldByName('TOMCID').AsString   := RetornaTexto(strDadosTomador, '<sCidadeTomador>', '</sCidadeTomador>');
  cdsNFS.FieldByName('TOMEMA').AsString   := RetornaTexto(strDadosTomador, '<sEmailTomador>', '</sEmailTomador>');
  cdsNFS.FieldByName('TOMUF').AsString    := RetornaTexto(strDadosTomador, '<sUfTomador>', '</sUfTomador>');
  cdsNFS.FieldByName('TMSIE').AsString    := '';

  cdsNFS.FieldByName('ALISER').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDadosNota, '<nIrAliquota>', '</nIrAliquota>'),'.',','), 0);
  cdsNFS.FieldByName('VALIRR').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDadosNota, '<nIrValor>', '</nIrValor>'),'.',','), 0);
  cdsNFS.FieldByName('VALPIS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDadosNota, '<nPisPasep>', '</nPisPasep>'),'.',','), 0);
  cdsNFS.FieldByName('VALCOF').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDadosNota, '<nCofins>', '</nCofins>'),'.',','), 0);
  cdsNFS.FieldByName('VALINS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDadosNota, '<nInss>', '</nInss>'),'.',','), 0);
  cdsNFS.FieldByName('VALCSL').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDadosNota, '<nCsll>', '</nCsll>'),'.',','), 0);

  strDadosItens := RetornaTexto(strXML, '<tItens>', '</tItens>');
  cdsNFS.FieldByName('VLRSER').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDadosItens, '<nValorServico>', '</nValorServico>'),'.',','), 0);
  cdsNFS.FieldByName('CODSER').AsString   := RetornaTexto(strDadosItens, '<iServico>', '</iServico>');
  cdsNFS.FieldByName('CDCNAE').AsString   := RetornaTexto(strDadosItens, '<sCNAE>', '</sCNAE>');
  cdsNFS.FieldByName('ITEDES').AsString := RetornaTexto(strDadosItens, '<sDescricao>', '</sDescricao>');
  cdsNFS.FieldByName('VLRISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDadosItens, '<nValorIss>', '</nValorIss>'),'.',','), 0);

  cdsNFS.FieldByName('OUTINF').AsString := RetornaTexto(strDadosNota, '<sObservacao1>', '</sObservacao1>') + ' ' +
                                           RetornaTexto(strDadosNota, '<sObservacao2>', '</sObservacao2>') + ' ' +
                                           RetornaTexto(strDadosNota, '<sObservacao3>', '</sObservacao3>') + ' ' +
                                           RetornaTexto(strDadosNota, '<sObservacao4>', '</sObservacao4>') + ' ' +
                                           RetornaTexto(strDadosNota, '<sObservacao5>', '</sObservacao5>') + ' ' +
                                           RetornaTexto(strDadosNota, '<sObservacao6>', '</sObservacao6>') + ' ' +
                                           RetornaTexto(strDadosNota, '<sObservacao7>', '</sObservacao7>') + ' ' +
                                           RetornaTexto(strDadosNota, '<sObservacao8>', '</sObservacao8>') + ' ' +
                                           RetornaTexto(strDadosNota, '<sObservacao9>', '</sObservacao9>') + ' ' +
                                           RetornaTexto(strDadosNota, '<sObservacao10>', '</sObservacao10>');
  cdsNFS.Post;
end;

end.
