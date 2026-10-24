unit untCriciumaXML;

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
  TCriciumaXML = class
    private
    public

      class function fRetDiscriminacaoServico( strItem: String ): String;
      class procedure pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string);
      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil);

  end;

implementation

{ TCriciumaXML }

class function TCriciumaXML.fRetDiscriminacaoServico(strItem: String): String;
var
  strDiscriminacao: string;
  intLaco: integer;
begin
  result := '';
  if fEmptyStr(strItem) then
    exit;
  //{[[Descricao=REMOCAO/INSTALACAO][ItemServico=1401][Quantidade=1][ValorUnitario=10][ValorServico=10][ValorBaseCalculo=10][Aliquota=4][DescontoCondicionado=0][DescontoIncondicionado=0]]}
  for intLaco := 14 to Length(strItem)-1 do
  begin
    if (Copy(strItem,intLaco,1) <> ']') then
    begin
      strDiscriminacao := strDiscriminacao + Copy(strItem,intLaco,1) ;
    end
    else
    begin
      break;
    end;
  end;
  result := strDiscriminacao;
end;

class procedure TCriciumaXML.pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string);
var
  xmlDoc : TXMLDocument;
begin

  xmlDoc := TXMLDocument.Create(Application);

  try
    xmlDoc.LoadFromXML(strXML);
    xmlDoc.Active := True;

    cdsNFS.Append;

    cdsNFS.FieldByName('NUMRPS').AsString := xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Numero'].Text;
    cdsNFS.FieldByName('NUMNFS').AsString := fStrZero(xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Numero'].Text, 8);
    cdsNFS.FieldByName('DTAEMI').AsString := Copy(xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,9,2)+'/'+
                                             Copy(xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,6,2)+'/'+
                                             Copy(xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,1,4);
    cdsNFS.FieldByName('DTAHRA').AsString := Copy(xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,12,19);
    cdsNFS.FieldByName('CODVER').AsString := xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['CodigoVerificacao'].Text;

    cdsNFS.FieldByName('PSVCNPJ').AsString := xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['IdentificacaoPrestador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text;
    cdsNFS.FieldByName('PSVIM').AsString := xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['IdentificacaoPrestador'].ChildNodes['InscricaoMunicipal'].Text;
    cdsNFS.FieldByName('PSVRAZAO').AsString := xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['RazaoSocial'].Text;
    cdsNFS.FieldByName('PSVFANT').AsString := '';
    cdsNFS.FieldByName('PSVEND').AsString := xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
    cdsNFS.FieldByName('PSVNUM').AsString := xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Numero'].Text;
    cdsNFS.FieldByName('PSVCOMPL').AsString := xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Complemento'].Text;
    cdsNFS.FieldByName('PSVBAIR').AsString := xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
    cdsNFS.FieldByName('PSVMUN').AsString := xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio'].Text;
    cdsNFS.FieldByName('PSVUF').AsString := xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Uf'].Text;
    cdsNFS.FieldByName('PSVCEP').AsString := xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Cep'].Text;
    cdsNFS.FieldByName('PSVFONE').AsString := xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Telefone'].Text;
    cdsNFS.FieldByName('PSVEMAIL').AsString := '';

    cdsNFS.FieldByName('TMSCNPJ').AsString := Iif(fEmptyStr(xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cpf'].Text),
                                                            xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text,
                                                            xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cpf'].Text);
    cdsNFS.FieldByName('TMSIM').AsString := '';
    cdsNFS.FieldByName('TMSRAZAO').AsString := xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['RazaoSocial'].Text;
    cdsNFS.FieldByName('TMSEND').AsString := xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
    cdsNFS.FieldByName('TMSNUM').AsString := xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Numero'].Text;
    cdsNFS.FieldByName('TMSCOMPL').AsString := '';
    cdsNFS.FieldByName('TMSBAIR').AsString := xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
    cdsNFS.FieldByName('TMSMUN').AsString := xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio'].Text;
    cdsNFS.FieldByName('TMSUF').AsString := xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Uf'].Text;
    cdsNFS.FieldByName('TMSCEP').AsString := xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Cep'].Text;
    cdsNFS.FieldByName('TMSFONE').AsString := xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Contato'].ChildNodes['Telefone'].Text;
    cdsNFS.FieldByName('TMSEMAIL').AsString := xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Contato'].ChildNodes['Email'].Text;

    cdsNFS.FieldByName('DISCRI').AsString := fRetDiscriminacaoServico(xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Discriminacao'].Text);
    cdsNFS.FieldByName('VLRSER').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorServicos'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRISS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['ValoresNfse'].ChildNodes['ValorIss'].Text,'.',','), 0);
    cdsNFS.FieldByName('BSCISS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['ValoresNfse'].ChildNodes['BaseCalculo'].Text,'.',','), 0);
    cdsNFS.FieldByName('ALIISS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['ValoresNfse'].ChildNodes['Aliquota'].Text,'.',','), 0);

    cdsNFS.FieldByName('VALPIS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorPis'].Text,'.',','), 0);
    cdsNFS.FieldByName('VALCOF').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorCofins'].Text,'.',','), 0);
    cdsNFS.FieldByName('VALIRR').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorIr'].Text,'.',','), 0);
    cdsNFS.FieldByName('VALINS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorInss'].Text,'.',','), 0);
    cdsNFS.FieldByName('VALCSL').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorCsll'].Text,'.',','), 0);
    cdsNFS.FieldByName('OUT_RET').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['OutrasRetencoes'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRLIQ').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['ValoresNfse'].ChildNodes['ValorLiquidoNfse'].Text,'.',','), 0);
    cdsNFS.FieldByName('DESCONC').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['DescontoCondicionado'].Text,'.',','), 0);
    cdsNFS.FieldByName('DESCONI').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['DescontoIncondicionado'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRDED').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorDeducoes'].Text,'.',','), 0);

    cdsNFS.FieldByName('NATOPE').AsString := '';
    cdsNFS.FieldByName('MUNPRE').AsString := xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['DescontoIncondicionado'].Text;
    cdsNFS.FieldByName('OUTINF').AsString := xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['OutrasInformacoes'].Text;

    cdsNFS.FieldByName('NUMPAR').AsString := xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['CondicaoPagamento'].ChildNodes['Parcelas'].ChildNodes['Parcela'].Text;
    if xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['CondicaoPagamento'].ChildNodes['Condicao'].Text = '1' then
      cdsNFS.FieldByName('VENCTO').AsString := 'À VISTA'
    else
      cdsNFS.FieldByName('VENCTO').AsString := xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['CondicaoPagamento'].ChildNodes['Condicao'].Text;
    cdsNFS.FieldByName('VALPAR').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['ConsultarNfseRpsResposta'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['CondicaoPagamento'].ChildNodes['Parcelas'].ChildNodes['Valor'].Text,'.',','), 0);

    cdsNFS.Post;

  finally
    FreeAndNil(xmlDoc);
  end;

end;

class procedure TCriciumaXML.pRetornaCDSPreenchidoComENotas(
  var cdsNFS: TUniClientDataSet; strXML, strCidadeNFSe: string;
  cdsItens: TUniClientDataSet);
var
  strIdentificacaoRps,
  strServico,
  strPrestador,
  strTomadorServico,
  strOrgaoGerador : string;
begin
  //DADOS DA NOTA FISCAO DE SERVIÇO ELETRÔNICA E RPS

  cdsNFS.Append;

  strIdentificacaoRps := RetornaTexto(strXML, '<IdentificacaoRps>', '</IdentificacaoRps>');
  cdsNFS.FieldByName('NUMRPS').AsString     := RetornaTexto(strIdentificacaoRps, '<Numero>', '</Numero>');
  cdsNFS.FieldByName('SERRPS').AsString     := RetornaTexto(strIdentificacaoRps, '<Serie>', '</Serie>');
  cdsNFS.FieldByName('CODVER').AsString     := RetornaTexto(strXML, '<CodigoVerificacao>', '</CodigoVerificacao>');
  cdsNFS.FieldByName('NUMNFS').AsString     := RetornaTexto(strXML, '<Numero>', '</Numero>');

  cdsNFS.FieldByName('DTAHRA').AsString     := Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),12,8);
  cdsNFS.FieldByName('DTAEMI').AsString     := Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),9,2)+'/'+
                                               Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),6,2)+'/'+
                                               Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),1,4)+' '+
                                               cdsNFS.FieldByName('DTAHRA').AsString;

  strPrestador := RetornaTexto(strXML, '<PrestadorServico>', '</PrestadorServico>');
  cdsNFS.FieldByName('PSVCNPJ').AsString    := Iif(fEmptyStr(RetornaTexto(strPrestador, '<Cnpj>', '</Cnpj>')),
                                                             RetornaTexto(strPrestador, '<Cpf>', '</Cpf>'),
                                                             RetornaTexto(strPrestador, '<Cnpj>', '</Cnpj>'));

  cdsNFS.FieldByName('PSVIM').AsString      := RetornaTexto(strPrestador, '<InscricaoMunicipal>', '</InscricaoMunicipal>');
  cdsNFS.FieldByName('PSVRAZAO').AsString   := RetornaTexto(strPrestador, '<RazaoSocial>', '</RazaoSocial>');
  cdsNFS.FieldByName('PSVFANT').AsString    := RetornaTexto(strPrestador, '<RazaoSocial>', '</RazaoSocial>');
  cdsNFS.FieldByName('PSVEND').AsString     := RetornaTexto(strPrestador, '<Endereco>', '</Endereco>');
  cdsNFS.FieldByName('PSVNUM').AsString     := RetornaTexto(strPrestador, '<Numero>', '</Numero>');
  cdsNFS.FieldByName('PSVCOMPL').AsString   := RetornaTexto(strPrestador, '<Complemento>', '</Complemento>');
  cdsNFS.FieldByName('PSVBAIR').AsString    := RetornaTexto(strPrestador, '<Bairro>', '</Bairro>');
  cdsNFS.FieldByName('PSVMUN').AsString     := RetornaTexto(strPrestador, '<CodigoMunicipio>', '</CodigoMunicipio>');
  cdsNFS.FieldByName('PSVUF').AsString      := RetornaTexto(strPrestador, '<Uf>', '</Uf>');
  cdsNFS.FieldByName('PSVCEP').AsString     := RetornaTexto(strPrestador, '<Cep>', '</Cep>');
  cdsNFS.FieldByName('PSVFONE').AsString    := RetornaTexto(strPrestador, '<Telefone>', '</Telefone>');
  cdsNFS.FieldByName('PSVEMAIL').AsString   := '';


  strTomadorServico := RetornaTexto(strXML, '<TomadorServico>', '</TomadorServico>');
  if fEmptyStr(strTomadorServico) then
    strTomadorServico := RetornaTexto(strXML, '<Tomador>', '</Tomador>');
  cdsNFS.FieldByName('TMSIM').AsString      := '';

  cdsNFS.FieldByName('TMSCNPJ').AsString    := Iif(fEmptyStr(RetornaTexto(strTomadorServico, '<Cnpj>', '</Cnpj>')),
                                                             RetornaTexto(strTomadorServico, '<Cpf>', '</Cpf>'),
                                                             RetornaTexto(strTomadorServico, '<Cnpj>', '</Cnpj>'));

  cdsNFS.FieldByName('TMSRAZAO').AsString   := RetornaTexto(strTomadorServico, '<RazaoSocial>', '</RazaoSocial>');
  cdsNFS.FieldByName('TMSEND').AsString     := RetornaTexto(strTomadorServico, '<Endereco>', '</Endereco>');
  cdsNFS.FieldByName('TMSNUM').AsString     := RetornaTexto(strTomadorServico, '<Numero>', '</Numero>');
  cdsNFS.FieldByName('TMSCOMPL').AsString   := '';
  cdsNFS.FieldByName('TMSBAIR').AsString    := RetornaTexto(strTomadorServico, '<Bairro>', '</Bairro>');
  cdsNFS.FieldByName('TMSMUN').AsString     := RetornaTexto(strTomadorServico, '<CodigoMunicipio>', '</CodigoMunicipio>');
  cdsNFS.FieldByName('TMSUF').AsString      := RetornaTexto(strTomadorServico, '<Uf>', '</Uf>');
  cdsNFS.FieldByName('TMSCEP').AsString     := RetornaTexto(strTomadorServico, '<Cep>', '</Cep>');
  cdsNFS.FieldByName('TMSFONE').AsString    := RetornaTexto(strTomadorServico, '<Telefone>', '</Telefone>');
  cdsNFS.FieldByName('TMSEMAIL').AsString   := RetornaTexto(strTomadorServico, '<Email>', '</Email>');

  cdsNFS.FieldByName('DISCRI').AsString     := fRetDiscriminacaoServico(RetornaTexto(strXML, '<Discriminacao>', '</Discriminacao>'));

  strServico := RetornaTexto(strXML, '<Servico>', '</Servico>');
  cdsNFS.FieldByName('CODSER').asString     := RetornaTexto(strServico, '<ItemListaServico>', '</ItemListaServico>');
  cdsNFS.FieldByName('VLRSER').AsFloat      := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorServicos>', '</ValorServicos>'),'.',','), 0);
  cdsNFS.FieldByName('VLRISS').AsFloat      := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorIss>', '</ValorIss>'),'.',','), 0);
  cdsNFS.FieldByName('BSCISS').AsFloat      := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<BaseCalculo>', '</BaseCalculo>'),'.',','), 0);
  cdsNFS.FieldByName('ALIISS').AsFloat      := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<Aliquota>', '</Aliquota>'),'.',','), 0);
  cdsNFS.FieldByName('VALPIS').AsFloat      := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorPis>', '</ValorPis>'),'.',','), 0);
  cdsNFS.FieldByName('VALCOF').AsFloat      := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorCofins>', '</ValorCofins>'),'.',','), 0);
  cdsNFS.FieldByName('VALIRR').AsFloat      := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorIr>', '</ValorIr>'),'.',','), 0);
  cdsNFS.FieldByName('VALINS').AsFloat      := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorInss>', '</ValorInss>'),'.',','), 0);
  cdsNFS.FieldByName('VALCSL').AsFloat      := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorCsll>', '</ValorCsll>'),'.',','), 0);
  cdsNFS.FieldByName('OUT_RET').AsFloat     := 0.00;
  cdsNFS.FieldByName('VLRLIQ').AsFloat      := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorServicos>', '</ValorServicos>'),'.',','), 0);
  cdsNFS.FieldByName('DESCONC').AsFloat     := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<DescontoCondicionado>', '</DescontoCondicionado>'),'.',','), 0);
  cdsNFS.FieldByName('DESCONI').AsFloat     := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<DescontoIncondicionado>', '</DescontoIncondicionado>'),'.',','), 0);
  cdsNFS.FieldByName('VLRDED').AsFloat      := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorDeducoes>', '</ValorDeducoes>'),'.',','), 0);

  cdsNFS.FieldByName('NATOPE').AsString     := RetornaTexto(strXML, '<NaturezaOperacao>', '</NaturezaOperacao>');

  strOrgaoGerador := RetornaTexto(strXML, '<NaturezaOperacao>', '</NaturezaOperacao>');
  cdsNFS.FieldByName('MUNPRE').AsString     := RetornaTexto(strOrgaoGerador, '<CodigoMunicipio>', '</CodigoMunicipio>');
  cdsNFS.FieldByName('OUTINF').AsString     := RetornaTexto(strXML, '<OutrasInformacoes>', '</OutrasInformacoes>');

  cdsNFS.FieldByName('NUMPAR').AsString     := '';
  cdsNFS.FieldByName('VENCTO').AsString     := '';
  cdsNFS.FieldByName('VALPAR').AsFloat      := 0.00;

  cdsNFS.Post;
end;

end.
