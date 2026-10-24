unit untCuritibaXML;

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
  TCuritibaXML = class

    private

    public
      class procedure pRetornaCDSPreenchido(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil);
      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil);

  end;

implementation

{ TCuritibaXML }

class procedure TCuritibaXML.pRetornaCDSPreenchido(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil);
var
  strEnderPrestador,
  strEnderTomador : String;
begin

  cdsNFS.Append;

  cdsNFS.FieldByName('PSVIM').AsString    := RetornaTexto(strXML, '<InscricaoPrestador>', '</InscricaoPrestador>');
  cdsNFS.FieldByName('NUMNFS').AsString   := RetornaTexto(strXML, '<NumeroNFe>', '</NumeroNFe>');
  cdsNFS.FieldByName('CODVER').AsString   := RetornaTexto(strXML, '<CodigoVerificacao>', '</CodigoVerificacao>');
  cdsNFS.FieldByName('DTAEMI').AsString   := Copy(RetornaTexto(strXML, '<DataEmissaoRPS>', '</DataEmissaoRPS>'),9,2)+'/'+
                                             Copy(RetornaTexto(strXML, '<DataEmissaoRPS>', '</DataEmissaoRPS>'),6,2)+'/'+
                                             Copy(RetornaTexto(strXML, '<DataEmissaoRPS>', '</DataEmissaoRPS>'),1,4);
  cdsNFS.FieldByName('SERRPS').AsString   := RetornaTexto(strXML, '<SerieRPS>', '</SerieRPS>');
  cdsNFS.FieldByName('NUMRPS').AsString   := RetornaTexto(strXML, '<NumeroRPS>', '</NumeroRPS>');
  cdsNFS.FieldByName('TPORPS').AsString   := RetornaTexto(strXML, '<TipoRPS>', '</TipoRPS>');
  cdsNFS.FieldByName('EMIRPS').AsString   := Copy(RetornaTexto(strXML, '<DataEmissaoRPS>', '</DataEmissaoRPS>'),9,2)+'/'+
                                             Copy(RetornaTexto(strXML, '<DataEmissaoRPS>', '</DataEmissaoRPS>'),6,2)+'/'+
                                             Copy(RetornaTexto(strXML, '<DataEmissaoRPS>', '</DataEmissaoRPS>'),1,4);
  cdsNFS.FieldByName('PSVCNPJ').AsString  := RetornaTexto(strXML, '<CPFCNPJPrestador><CNPJ>', '</CNPJ>');
  cdsNFS.FieldByName('PSVRAZAO').AsString := RetornaTexto(strXML, '<RazaoSocialPrestador>', '</RazaoSocialPrestador>');
  strEnderPrestador := RetornaTexto(strXML, '<EnderecoPrestador>', '</EnderecoPrestador>');
  cdsNFS.FieldByName('PSVEND').AsString   := RetornaTexto(strEnderPrestador, '<Logradouro>', '</Logradouro>');
  cdsNFS.FieldByName('PSVNUM').AsString   := RetornaTexto(strEnderPrestador, '<NumeroEndereco>', '</NumeroEndereco>');
  cdsNFS.FieldByName('PSVBAI').AsString   := RetornaTexto(strEnderPrestador, '<Bairro>', '</Bairro>');
  cdsNFS.FieldByName('PSVCID').AsString   := RetornaTexto(strEnderPrestador, '<Cidade>', '</Cidade>');
  cdsNFS.FieldByName('PSVCEP').AsString   := IfThen(Length(Trim(RetornaTexto(strEnderPrestador, '<CEP>', '</CEP>')))=7, '0'+Trim(RetornaTexto(strEnderPrestador, '<CEP>', '</CEP>')), RetornaTexto(strEnderPrestador, '<CEP>', '</CEP>'));
  cdsNFS.FieldByName('STATUS').AsString   := RetornaTexto(strXML, '<StatusNFe>', '</StatusNFe>');
  cdsNFS.FieldByName('TRINFE').AsString   := RetornaTexto(strXML, '<TributacaoNFe>', '</TributacaoNFe>');
  cdsNFS.FieldByName('VLRSER').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorServicos>', '</ValorServicos>'),'.',','), 0);
  cdsNFS.FieldByName('VALCRE').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorCredito>', '</ValorCredito>'),'.',','), 0);
  cdsNFS.FieldByName('VLRDED').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorDeducoes>', '</ValorDeducoes>'),'.',','), 0);
  cdsNFS.FieldByName('CODSER').AsString   := RetornaTexto(strXML, '<CodigoServico>', '</CodigoServico>');
  cdsNFS.FieldByName('ALISER').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<AliquotaServicos>', '</AliquotaServicos>'),'.',','), 0);
  cdsNFS.FieldByName('ISSRET').AsString   := RetornaTexto(strXML, '<ISSRetido>', '</ISSRetido>');
  if Length(fTiraCaracEspeciaisPonto(RetornaTexto(strXML, '<CPFCNPJTomador><CNPJ>', '</CNPJ>')))=14 then
    cdsNFS.FieldByName('TOMCNPJ').AsString  := RetornaTexto(strXML, '<CPFCNPJTomador><CNPJ>', '</CNPJ>');
  if Length(fTiraCaracEspeciaisPonto(RetornaTexto(strXML, '<CPFCNPJTomador><CPF>', '</CPF>')))=11 then
    cdsNFS.FieldByName('TOMCNPJ').AsString  := RetornaTexto(strXML, '<CPFCNPJTomador><CPF>', '</CPF>');
  cdsNFS.FieldByName('TOMIE').AsString    := RetornaTexto(strXML, '<InscricaoEstadualTomador>', '</InscricaoEstadualTomador>');
  cdsNFS.FieldByName('TOMRAZAO').AsString := RetornaTexto(strXML, '<RazaoSocialTomador>', '</RazaoSocialTomador>');
  strEnderTomador := RetornaTexto(strXML, '<EnderecoTomador>', '</EnderecoTomador>');
  cdsNFS.FieldByName('TOMEND').AsString   := RetornaTexto(strEnderTomador, '<Logradouro>', '</Logradouro>');
  cdsNFS.FieldByName('TOMNUM').AsString   := RetornaTexto(strEnderTomador, '<NumeroEndereco>', '</NumeroEndereco>');
  cdsNFS.FieldByName('TOMBAI').AsString   := RetornaTexto(strEnderTomador, '<Bairro>', '</Bairro>');
  cdsNFS.FieldByName('TOMCID').AsString   := RetornaTexto(strEnderTomador, '<Cidade>', '</Cidade>');
  cdsNFS.FieldByName('TOMCEP').AsString   := IfThen(Length(Trim(RetornaTexto(strEnderPrestador, '<CEP>', '</CEP>')))=7, '0'+Trim(RetornaTexto(strEnderPrestador, '<CEP>', '</CEP>')), RetornaTexto(strEnderPrestador, '<CEP>', '</CEP>'));
  cdsNFS.FieldByName('TOMEMA').AsString   := RetornaTexto(strXML, '<EmailTomador>', '</EmailTomador>');
  cdsNFS.FieldByName('DISSER').AsString   := RetornaTexto(strXML, '<Discriminacao>', '</Discriminacao>');
  cdsNFS.FieldByName('LOCMUN').AsString   := 'SÃO PAULO';
  cdsNFS.FieldByName('LOC_UF').AsString   := 'SP';
  cdsNFS.Post;
end;

class procedure TCuritibaXML.pRetornaCDSPreenchidoComENotas(
  var cdsNFS: TUniClientDataSet; strXML, strCidadeNFSe: string;
  cdsItens: TUniClientDataSet);
var
  strDadosPrestador,
  strDadosRPS,
  strServico,
  strDadosTomador : String;
begin

  cdsNFS.Append;

  cdsNFS.FieldByName('NUMNFS').AsString   := RetornaTexto(strXML, '<Numero>', '</Numero>');
  cdsNFS.FieldByName('CODVER').AsString   := RetornaTexto(strXML, '<CodigoVerificacao>', '</CodigoVerificacao>');
  cdsNFS.FieldByName('DTAEMI').AsString   := Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),9,2)+'/'+
                                             Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),6,2)+'/'+
                                             Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),1,4);

  strDadosRPS := RetornaTexto(strXML, '<IdentificacaoRps>', '</IdentificacaoRps>');
  cdsNFS.FieldByName('SERRPS').AsString   := RetornaTexto(strDadosRPS, '<Serie>', '</Serie>');
  cdsNFS.FieldByName('NUMRPS').AsString   := RetornaTexto(strDadosRPS, '<Numero>', '</Numero>');
  cdsNFS.FieldByName('TPORPS').AsString   := RetornaTexto(strDadosRPS, '<Tipo>', '</Tipo>');

  cdsNFS.FieldByName('EMIRPS').AsString   := Copy(RetornaTexto(strXML, '<DataEmissaoRps>', '</DataEmissaoRps>'),9,2)+'/'+
                                             Copy(RetornaTexto(strXML, '<DataEmissaoRps>', '</DataEmissaoRps>'),6,2)+'/'+
                                             Copy(RetornaTexto(strXML, '<DataEmissaoRps>', '</DataEmissaoRps>'),1,4);

  strDadosPrestador := RetornaTexto(strXML, '<PrestadorServico>', '</PrestadorServico>');
  cdsNFS.FieldByName('PSVIM').AsString    := RetornaTexto(strDadosPrestador, '<InscricaoMunicipal>', '</InscricaoMunicipal>');
  cdsNFS.FieldByName('PSVCNPJ').AsString  := RetornaTexto(strDadosPrestador, '<Cnpj>', '</Cnpj>');
  cdsNFS.FieldByName('PSVRAZAO').AsString := RetornaTexto(strDadosPrestador, '<NomeFantasia>', '</NomeFantasia>');


  cdsNFS.FieldByName('PSVEND').AsString   := RetornaTexto(strDadosPrestador, '<Endereco><Endereco>', '</Endereco>');
  cdsNFS.FieldByName('PSVNUM').AsString   := RetornaTexto(strDadosPrestador, '<Numero>', '</Numero>');
  cdsNFS.FieldByName('PSVBAI').AsString   := RetornaTexto(strDadosPrestador, '<Bairro>', '</Bairro>');
  cdsNFS.FieldByName('PSVCID').AsString   := RetornaTexto(strDadosPrestador, '<CodigoMunicipio>', '</CodigoMunicipio>');
  cdsNFS.FieldByName('PSVCEP').AsString   := RetornaTexto(strDadosPrestador, '<Cep>', '</Cep>');

  cdsNFS.FieldByName('STATUS').AsString   := '';
  cdsNFS.FieldByName('TRINFE').AsString   := '';

  strServico := RetornaTexto(strXML, '<Servico>', '</Servico>');
  cdsNFS.FieldByName('VLRSER').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorServicos>', '</ValorServicos>'),'.',','), 0);
  cdsNFS.FieldByName('VLRDED').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorDeducoes>', '</ValorDeducoes>'),'.',','), 0);
  cdsNFS.FieldByName('CODSER').AsString   := RetornaTexto(strServico, '<ItemListaServico>', '</ItemListaServico>');
  cdsNFS.FieldByName('ALISER').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<Aliquota>', '</Aliquota>'),'.',','), 0);
  cdsNFS.FieldByName('ISSRET').AsString   := RetornaTexto(strServico, '<ISSRetido>', '</ISSRetido>');
  cdsNFS.FieldByName('DISSER').AsString   := RetornaTexto(strServico, '<Discriminacao>', '</Discriminacao>');

  strDadosTomador := RetornaTexto(strXML, '<TomadorServico>', '</TomadorServico>');
  if Length(RetornaTexto(strDadosTomador, '<Cnpj>', '</Cnpj>')) > 0 then
    cdsNFS.FieldByName('TOMCNPJ').AsString  := RetornaTexto(strDadosTomador, '<CpfCnpj><Cnpj>', '</Cnpj>')
  else
    cdsNFS.FieldByName('TOMCNPJ').AsString  := RetornaTexto(strDadosTomador, '<CpfCnpj><Cpf>', '</Cpf>');
  cdsNFS.FieldByName('TOMIE').AsString    := RetornaTexto(strDadosTomador, '<IdentificacaoTomador>', '</IdentificacaoTomador>');
  cdsNFS.FieldByName('TOMRAZAO').AsString := RetornaTexto(strDadosTomador, '<RazaoSocial>', '</RazaoSocial>');

  cdsNFS.FieldByName('TOMEND').AsString   := RetornaTexto(strDadosTomador, '<Endereco><Endereco>', '</Endereco>');
  cdsNFS.FieldByName('TOMNUM').AsString   := RetornaTexto(strDadosTomador, '<Numero>', '</Numero>');
  cdsNFS.FieldByName('TOMBAI').AsString   := RetornaTexto(strDadosTomador, '<Bairro>', '</Bairro>');
  cdsNFS.FieldByName('TOMCID').AsString   := RetornaTexto(strDadosTomador, '<CodigoMunicipio>', '</CodigoMunicipio>');
  cdsNFS.FieldByName('TOMCEP').AsString   := RetornaTexto(strDadosTomador, '<Cep>', '</Cep>');
  cdsNFS.FieldByName('TOMEMA').AsString   := RetornaTexto(strDadosTomador, '<Email>', '</Email>');

  cdsNFS.FieldByName('VALCRE').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorCredito>', '</ValorCredito>'),'.',','), 0);
  cdsNFS.FieldByName('LOCMUN').AsString   := 'CURITIBA';
  cdsNFS.FieldByName('LOC_UF').AsString   := 'PR';

  cdsNFS.Post;
end;

end.
