unit untGovernadorValadaresXML;

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
  TGovernadorValadaresXML = class

    private

    public

      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS: TUniClientDataSet; strXML: string);

  end;

implementation

{ TGovernadorValadaresXML }

class procedure TGovernadorValadaresXML.pRetornaCDSPreenchidoComENotas(var cdsNFS: TUniClientDataSet; strXML: string);
begin

  cdsNFS.Append;
  // Dados da NFS
  cdsNFS.FieldByName('NUMNFS').AsString := RetornaTexto(strXML, '<NumeroNFe>', '</NumeroNFe>');
  cdsNFS.FieldByName('SERIE').AsString  := RetornaTexto(strXML, '<SerieNFe>', '</SerieNFe>');
  cdsNFS.FieldByName('CODVER').AsString := RetornaTexto(strXML, '<CodigoVerificacao>', '</CodigoVerificacao>');
  cdsNFS.FieldByName('DTAEMI').AsString := Copy(RetornaTexto(strXML, '<DataEmissaoNFe>', '</DataEmissaoNFe>'),9,2)+'/'+
                                           Copy(RetornaTexto(strXML, '<DataEmissaoNFe>', '</DataEmissaoNFe>'),6,2)+'/'+
                                           Copy(RetornaTexto(strXML, '<DataEmissaoNFe>', '</DataEmissaoNFe>'),1,4);

  cdsNFS.FieldByName('SERRPS').AsString := '';
  cdsNFS.FieldByName('TPORPS').AsString := '';
  cdsNFS.FieldByName('EMIRPS').AsString := '';
  cdsNFS.FieldByName('NATOPE').AsString := '';
  cdsNFS.FieldByName('CODRET').AsString := '';
  cdsNFS.FieldByName('EMIOSN').AsString := RetornaTexto(strXML, '<OpcaoSimples>', '</OpcaoSimples>');
  cdsNFS.FieldByName('EMIICC').AsString := '';
  cdsNFS.FieldByName('COMPET').AsString := Copy(RetornaTexto(strXML, '<DataEmissaoNFe>', '</DataEmissaoNFe>'),9,2)+'/'+
                                           Copy(RetornaTexto(strXML, '<DataEmissaoNFe>', '</DataEmissaoNFe>'),6,2)+'/'+
                                           Copy(RetornaTexto(strXML, '<DataEmissaoNFe>', '</DataEmissaoNFe>'),1,4);
  cdsNFS.FieldByName('OUTINF').AsString := '';
  cdsNFS.FieldByName('ORGMUN').AsString := '';
  cdsNFS.FieldByName('ORG_UF').AsString := RetornaTexto(strXML, '<EnderecoPrestador>', '</EnderecoPrestador>');
  cdsNFS.FieldByName('_LINK_').AsString := '';

  //Valores
  cdsNFS.FieldByName('VLRSER').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorServicos>', '</ValorServicos>'),'.',','), 0);
  cdsNFS.FieldByName('ISS_RET').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ISSRetido>', '</ISSRetido>'),'.',','), 0);
  cdsNFS.FieldByName('VLRISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorISS>', '</ValorISS>'),'.',','), 0);
  cdsNFS.FieldByName('BSCISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorBase>', '</ValorBase>'),'.',','), 0);
  cdsNFS.FieldByName('ALIISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<AliquotaServicos>', '</AliquotaServicos>'),'.',','), 0);
  cdsNFS.FieldByName('VLRLIQ').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorServicos>', '</ValorServicos>'),'.',','), 0);
  cdsNFS.FieldByName('CODSER').AsString := RetornaTexto(strXML, '<CodigoServico>', '</CodigoServico>');
  cdsNFS.FieldByName('CDCNAE').AsString := '';
  cdsNFS.FieldByName('CODTRI').AsString := '';
  cdsNFS.FieldByName('DISCRI').AsString := RetornaTexto(strXML, '<Discriminacao>', '</Discriminacao>');
  cdsNFS.FieldByName('CODMUN').AsString := '';
  cdsNFS.FieldByName('ITEDESC').AsString := '';
  cdsNFS.FieldByName('ITEQTD').AsFloat := 0;
  cdsNFS.FieldByName('ITEVLU').AsFloat := 0;
  //Prestador
  cdsNFS.FieldByName('PSVCNPJ').AsString := RetornaTexto(strXML, '<CNPJ>', '</CNPJ>');
  cdsNFS.FieldByName('PSVIM').AsString := RetornaTexto(strXML, '<InscricaoPrestador>', '</InscricaoPrestador>');
  cdsNFS.FieldByName('PSVRAZAO').AsString := RetornaTexto(strXML, '<RazaoSocialPrestador>', '</RazaoSocialPrestador>');
  cdsNFS.FieldByName('PSVFANT').AsString := '';
  cdsNFS.FieldByName('PSVEND').AsString := RetornaTexto(strXML, '<Logradouro>', '</Logradouro>');
  cdsNFS.FieldByName('PSVNUM').AsString := RetornaTexto(strXML, '<NumeroEndereco>', '</NumeroEndereco>');
  cdsNFS.FieldByName('PSVCOMPL').AsString := '';
  cdsNFS.FieldByName('PSVBAIR').AsString := RetornaTexto(strXML, '<Bairro>', '</Bairro>');
  cdsNFS.FieldByName('PSVMUN').AsString := RetornaTexto(strXML, '<Cidade>', '</Cidade>');
  cdsNFS.FieldByName('PSVUF').AsString := RetornaTexto(strXML, '<UF>', '</UF>');
  cdsNFS.FieldByName('PSVCEP').AsString := RetornaTexto(strXML, '<CEP>', '</CEP>');
  cdsNFS.FieldByName('PSVFONE').AsString := RetornaTexto(strXML, '<TelefonePrestado>', '</TelefonePrestado>');
  cdsNFS.FieldByName('PSVEMAIL').AsString := RetornaTexto(strXML, '<EmailPrestador>', '</EmailPrestador>');
  //Tomador
  cdsNFS.FieldByName('TMSCNPJ').AsString := Iif(fEmptyStr(RetornaTexto(strXML, '<CNPJ>', '</CNPJ>')),
                                                          RetornaTexto(strXML, '<CPF>', '</CPF>'),
                                                          RetornaTexto(strXML, '<CNPJ>', '</CNPJ>'));
  cdsNFS.FieldByName('TMSIM').AsString := '';
  cdsNFS.FieldByName('TMSRAZAO').AsString := RetornaTexto(strXML, '<RazaoSocialTomador>', '</RazaoSocialTomador>');
  cdsNFS.FieldByName('TMSFANTA').AsString := '';
  cdsNFS.FieldByName('TMSEND').AsString := RetornaTexto(strXML, '<Logradouro>', '</Logradouro>');
  cdsNFS.FieldByName('TMSNUM').AsString := RetornaTexto(strXML, '<NumeroEndereco>', '</NumeroEndereco>');
  cdsNFS.FieldByName('TMSCOMPL').AsString := '';
  cdsNFS.FieldByName('TMSBAIR').AsString := RetornaTexto(strXML, '<Bairro>', '</Bairro>');
  cdsNFS.FieldByName('TMSMUN').AsString := RetornaTexto(strXML, '<Cidade>', '</Cidade>');
  cdsNFS.FieldByName('TMSUF').AsString := RetornaTexto(strXML, '<UF>', '</UF>');
  cdsNFS.FieldByName('TMSCEP').AsString := RetornaTexto(strXML, '<CEP>', '</CEP>');
  cdsNFS.FieldByName('TMSFONE').AsString := RetornaTexto(strXML, '<TelefoneTomador>', '</TelefoneTomador>');
  cdsNFS.FieldByName('TMSEMAIL').AsString := RetornaTexto(strXML, '<EmailTomador>', '</EmailTomador>');

  cdsNFS.Post;

end;


end.
