unit untCruzDasAlmasXML;

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
  TCruzDasAlmasXML = class
    private
    public

      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS : TUniClientDataSet; strXML: string);

    end;
implementation

{ TCruzDasAlmasXML }

class procedure TCruzDasAlmasXML.pRetornaCDSPreenchidoComENotas(var cdsNFS: TUniClientDataSet; strXML: string);
begin
  cdsNFS.Append;

  cdsNFS.FieldByName('PSVMUN').AsString   := RetornaTexto(strXML, '<CodigoMunicipio>', '</CodigoMunicipio>');
  cdsNFS.FieldByName('PSVCODUF').AsString := RetornaTexto(strXML, '<CodigoUF>', '</CodigoUF>');
  cdsNFS.FieldByName('IDNTFIS').AsString  := RetornaTexto(strXML, '<IDNotaFiscal>', '</IDNotaFiscal>');

  cdsNFS.FieldByName('PSVRAZAO').AsString := RetornaTexto(strXML, '<RazaoSocial>', '</RazaoSocial>');
  cdsNFS.FieldByName('PSVEND').AsString   := RetornaTexto(strXML, '<Endereco>', '</Endereco>');
  cdsNFS.FieldByName('PSVCOMPL').AsString := RetornaTexto(strXML, '<Complemento>', '</Complemento>');
  cdsNFS.FieldByName('PSVCEP').AsString   := RetornaTexto(strXML, '<CEP>', '</CEP>');
  cdsNFS.FieldByName('PSVBAIR').AsString  := RetornaTexto(strXML, '<Bairro>', '</Bairro>');
  cdsNFS.FieldByName('PSVCID').AsString   := RetornaTexto(strXML, '<Cidade>', '</Cidade>');
  cdsNFS.FieldByName('PSVUF').AsString    := RetornaTexto(strXML, '<UF>', '</UF>');
  cdsNFS.FieldByName('PSVFONE').AsString  := RetornaTexto(strXML, '<Fone>', '</Fone>');
  cdsNFS.FieldByName('PSVEMAIL').AsString := RetornaTexto(strXML, '<Email>', '</Email>');
  cdsNFS.FieldByName('PSVCNPJ').AsString  := RetornaTexto(strXML, '<CNPJCPF>', '</CNPJCPF>');
  cdsNFS.FieldByName('PSVIM').AsString    := RetornaTexto(strXML, '<InscricaoMunicipal>', '</InscricaoMunicipal>');
  cdsNFS.FieldByName('IEPRES').AsString   := RetornaTexto(strXML, '<InscEstadualRG>', '</InscEstadualRG>');
  cdsNFS.FieldByName('PSFANT').AsString   := '';

  cdsNFS.FieldByName('TMSRAZAO').AsString := RetornaTexto(strXML, '<RazaoNomeTomador>', '</RazaoNomeTomador>');
  cdsNFS.FieldByName('TMSEND').AsString   := RetornaTexto(strXML, '<EnderecoTomador>', '</EnderecoTomador>');
  cdsNFS.FieldByName('TMSCEP').AsString   := RetornaTexto(strXML, '<CEPTomador>', '</CEPTomador>');
  cdsNFS.FieldByName('TMSBAIR').AsString  := RetornaTexto(strXML, '<BairroTomador>', '</BairroTomador>');
  cdsNFS.FieldByName('TMSMUNIC').AsString := RetornaTexto(strXML, '<CidadeTomador>', '</CidadeTomador>');
  cdsNFS.FieldByName('TMSUF').AsString    := RetornaTexto(strXML, '<UFTomador>', '</UFTomador>');
  cdsNFS.FieldByName('TMSFONE').AsString  := RetornaTexto(strXML, '<FoneTomador>', '</FoneTomador>');
  cdsNFS.FieldByName('TMSEMAIL').AsString := RetornaTexto(strXML, '<EmailTomador>', '</EmailTomador>');
  cdsNFS.FieldByName('TMSCNPJ').AsString  := RetornaTexto(strXML, '<CNPJCPFTomador>', '</CNPJCPFTomador>');
  cdsNFS.FieldByName('TMSIM').AsString    := RetornaTexto(strXML, '<InscricaoMunicipalTomador>', '</InscricaoMunicipalTomador>');
  cdsNFS.FieldByName('TOMIE').AsString    := RetornaTexto(strXML, '<InscricaoEstadualRGTomador>', '</InscricaoEstadualRGTomador>');


  cdsNFS.FieldByName('NUMNFS').AsString   := RetornaTexto(strXML, '<NumeroNF>', '</NumeroNF>');
  cdsNFS.FieldByName('STATUS').AsString   := RetornaTexto(strXML, '<Status>', '</Status>');

  cdsNFS.FieldByName('VLRLIQ').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorLiquido>', '</ValorLiquido>'),'.',','), 0);
  cdsNFS.FieldByName('VALTOT').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorTotal>', '</ValorTotal>'),'.',','), 0);
  cdsNFS.FieldByName('VALRET').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorRetencoes>', '</ValorRetencoes>'),'.',','), 0);

  cdsNFS.FieldByName('LOCPAG').AsString   := RetornaTexto(strXML, '<LocalPgto>', '</LocalPgto>');
  cdsNFS.FieldByName('FRMPAG').AsString   := RetornaTexto(strXML, '<FormadePagamento>', '</FormadePagamento>');

  cdsNFS.FieldByName('DTAHRA').AsString   := Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),10,8);
  cdsNFS.FieldByName('DTAEMI').AsString   := Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),3,1)+'/'+
                                           Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),1,1)+'/'+
                                           Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),5,4);

  cdsNFS.FieldByName('VALIRR').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorIRRF>', '</ValorIRRF>'),'.',','), 0);
  cdsNFS.FieldByName('VALPIS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorPIS>', '</ValorPIS>'),'.',','), 0);
  cdsNFS.FieldByName('VALCOF').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorCOFINS>', '</ValorCOFINS>'),'.',','), 0);
  cdsNFS.FieldByName('VALCSL').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorCSLL>', '</ValorCSLL>'),'.',','), 0);
  cdsNFS.FieldByName('VALINS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorINSS>', '</ValorINSS>'),'.',','), 0);
  cdsNFS.FieldByName('IMPDEV').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorISSDevido>', '</ValorISSDevido>'),'.',','), 0);
  cdsNFS.FieldByName('IMPRET').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorISSRetido>', '</ValorISSRetido>'),'.',','), 0);

  cdsNFS.FieldByName('CODVER').AsString   := RetornaTexto(strXML, '<AssinaturaDigital>', '</AssinaturaDigital>');

  cdsNFS.FieldByName('OBSERV').AsString   := RetornaTexto(strXML, '<Observacoes>', '</Observacoes>');

  cdsNFS.FieldByName('DTAVEN').AsString   := Copy(RetornaTexto(strXML, '<DataVencimentoFatura >', '</DataVencimentoFatura >'),9,2)+'/'+
                                           Copy(RetornaTexto(strXML, '<DataVencimentoFatura >', '</DataVencimentoFatura >'),6,2)+'/'+
                                           Copy(RetornaTexto(strXML, '<DataVencimentoFatura >', '</DataVencimentoFatura >'),1,4);

  cdsNFS.FieldByName('VLRDED').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorDeducaoBase>', '</ValorDeducaoBase>'),'.',','), 0);

  cdsNFS.FieldByName('IDNTFIS').AsString  := RetornaTexto(strXML, '<IDNotaFiscal>', '</IDNotaFiscal>');
  cdsNFS.FieldByName('CODSER').AsString   := '1401';
  cdsNFS.FieldByName('DISSER').AsString   := '';
  cdsNFS.FieldByName('ITEQTD').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<Quantidade>', '</Quantidade>'),'.',','), 0);
  cdsNFS.FieldByName('ITEVLU').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorUnitario>', '</ValorUnitario>'),'.',','), 0);
  cdsNFS.FieldByName('VALDED').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<Deducao>', '</Deducao>'),'.',','), 0);
  cdsNFS.FieldByName('VALTOT').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorTotalServicos>', '</ValorTotalServicos>'),'.',','), 0);

  cdsNFS.Post;
end;

end.
