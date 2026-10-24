unit untProvSimpliss;

interface

uses
{$IF Defined(LINUX)}
  Uni,
  System.JSON,
  NFe.Modulo,
  FMX.frxClass,
  FMX.frxBarcode,
  FMX.frxDBSet,
  FMX.frxDelphiZXingQRCode,
  FMX.frxDesgn,
  FMX.frxExportPDF,
  untUniClientDataSet,
{$ELSE}
  Windows, Messages, Graphics,
  Controls, Forms, frxClass, ComCtrls, StdCtrls, ExtCtrls,
  {$IF Defined(UNIDAC)}
    UniClientDataSet, Uni, MySQLUniProvider, UniProvider,
  {$ELSE}
   ZConnection, ZDataset, ZDbcIntfs,
  {$IFEND}
  {$IFDEF VER300}
    System.JSON, System.UITypes,
  {$ENDIF}
  DBCtrls, MemDS, Dialogs,
  frxBarcode, frxDBSet, frxDelphiZXingQRCode, frxDesgn,
  untUniClientDataSet,
{$IFEND}
  SysUtils, Variants, Classes, StrUtils,
  DB, DBClient, untConexaoBD, XMLIntf, XMLDoc, untUtil;

type
  TProvSimpliss = class

    private

    public
      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS, cdsItens: TUniClientDataSet; strXML, strCidadeNFSe: string);

  end;

implementation

class procedure TProvSimpliss.pRetornaCDSPreenchidoComENotas(var cdsNFS, cdsItens: TUniClientDataSet; strXML, strCidadeNFSe: string);
var
  strDadosPrestador,
  strDadosTomador,
  strDadosServico,
  strDadosOrgaoGerador,
  strDadosRPS,
  strDadosRPSXML,
  strDadosValoresNfse,
  strDataEmissao,
  strDataRPS : String;
begin

  strDadosPrestador    := RetornaTexto(strXML, '<PrestadorServico>', '</PrestadorServico>');
  strDadosTomador      := RetornaTexto(strXML, '<TomadorServico>', '</TomadorServico>');
  strDadosServico      := RetornaTexto(strXML, '<Servico>', '</Servico>');
  strDadosOrgaoGerador := RetornaTexto(strXML, '<OrgaoGerador>', '</OrgaoGerador>');
  strDadosRPS          := RetornaTexto(strXML, '<Rps>', '</Rps>');
  strDadosRPSXML       := RetornaTexto(strXML, '<IdentificacaoRps>', '</IdentificacaoRps>');
  strDadosValoresNfse  := RetornaTexto(strDadosServico, '<Valores>', '</Valores>');

  cdsNFS.Append;
  try

    strDataEmissao := Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),9,2)+'/'+
                      Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),6,2)+'/'+
                      Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),1,4);

    strDataRPS := Copy(RetornaTexto(strXML, '<DataEmissaoRps>', '</DataEmissaoRps>'),9,2)+'/'+
                  Copy(RetornaTexto(strXML, '<DataEmissaoRps>', '</DataEmissaoRps>'),6,2)+'/'+
                  Copy(RetornaTexto(strXML, '<DataEmissaoRps>', '</DataEmissaoRps>'),1,4);

    cdsNFS.FieldByName('NUMNFS').AsString := RetornaTexto(strXML, '<Numero>', '</Numero>');
    cdsNFS.FieldByName('CODVER').AsString := RetornaTexto(strXML, '<CodigoVerificacao>', '</CodigoVerificacao>');
    cdsNFS.FieldByName('DTAHRA').AsString := Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'), 12, 8);
    cdsNFS.FieldByName('DTAEMI').AsString := iif( strDataEmissao = '//', '', strDataEmissao);
    cdsNFS.FieldByName('NUMRPS').AsString := iif(RetornaTexto(strDadosRPS, '<Numero>', '</Numero>')='', RetornaTexto(strDadosRPSXML, '<Numero>', '</Numero>'), RetornaTexto(strDadosRPS, '<Numero>', '</Numero>'));
    cdsNFS.FieldByName('SERRPS').AsString := iif(RetornaTexto(strDadosRPS, '<Serie>', '</Serie>')='', RetornaTexto(strDadosRPSXML, '<Serie>', '</Serie>'), RetornaTexto(strDadosRPS, '<Serie>', '</Serie>'));
    cdsNFS.FieldByName('TPORPS').AsString := iif(RetornaTexto(strDadosRPS, '<Tipo>', '</Tipo>')='', RetornaTexto(strDadosRPSXML, '<Tipo>', '</Tipo>'), RetornaTexto(strDadosRPS, '<Tipo>', '</Tipo>'));
    cdsNFS.FieldByName('EMIRPS').AsString := iif( strDataRPS = '//', '', strDataRPS);
    cdsNFS.FieldByName('NATOPE').AsString := RetornaTexto(strXML, '<NaturezaOperacao>', '</NaturezaOperacao>');
    cdsNFS.FieldByName('CODRET').AsString := RetornaTexto(strXML, '<RegimeEspecialTributacao>', '</RegimeEspecialTributacao>');
    cdsNFS.FieldByName('EMIOSN').AsString := RetornaTexto(strXML, '<OptanteSimplesNacional>', '</OptanteSimplesNacional>');
    cdsNFS.FieldByName('EMIICC').AsString := RetornaTexto(strXML, '<IncentivadorCultural>', '</IncentivadorCultural>');
    cdsNFS.FieldByName('COMPET').AsString := Copy(RetornaTexto(strXML, '<Competencia>', '</Competencia>'),1,10);
    cdsNFS.FieldByName('OUTINF').AsString := RetornaTexto(strXML, '<OutrasInformacoes>', '</OutrasInformacoes>');

    cdsNFS.FieldByName('PSVCNPJ').AsString  := RetornaTexto(strDadosPrestador, '<Cnpj>', '</Cnpj>');
    cdsNFS.FieldByName('PSVIM').AsString    := RetornaTexto(strDadosPrestador, '<InscricaoMunicipal>', '</InscricaoMunicipal>');
    cdsNFS.FieldByName('PSVRAZAO').AsString := StringReplace(RetornaTexto(strDadosPrestador, '<RazaoSocial>', '</RazaoSocial>'), '&amp;', '&', [rfReplaceAll]);
    cdsNFS.FieldByName('PSVFANT').AsString  := StringReplace(RetornaTexto(strDadosPrestador, '<NomeFantasia>', '</NomeFantasia>'), '&amp;', '&', [rfReplaceAll]);
    cdsNFS.FieldByName('PSVEND').AsString   := RetornaTexto(strDadosPrestador, '<Endereco><Endereco>', '</Endereco>');
    cdsNFS.FieldByName('PSVNUM').AsString   := RetornaTexto(strDadosPrestador, '<Numero>', '</Numero>');
    cdsNFS.FieldByName('PSVCOMPL').AsString := RetornaTexto(strDadosPrestador, '<Complemento>', '</Complemento>');
    cdsNFS.FieldByName('PSVBAIR').AsString  := RetornaTexto(strDadosPrestador, '<Bairro>', '</Bairro>');
    cdsNFS.FieldByName('PSVMUN').AsString   := RetornaTexto(strDadosPrestador, '<CodigoMunicipio>', '</CodigoMunicipio>');
    cdsNFS.FieldByName('PSVUF').AsString    := RetornaTexto(strDadosPrestador, '<Uf>', '</Uf>');
    cdsNFS.FieldByName('PSVCEP').AsString   := RetornaTexto(strDadosPrestador, '<Cep>', '</Cep>');
    cdsNFS.FieldByName('PSVFONE').AsString  := RetornaTexto(strDadosPrestador, '<Contato><Telefone>', '</Telefone>');
    cdsNFS.FieldByName('PSVEMAIL').AsString := RetornaTexto(strDadosPrestador, '<Email>', '</Email>');

    cdsNFS.FieldByName('TMSCNPJ').AsString  := Iif(fEmptyStr(RetornaTexto(strDadosTomador, '<Cnpj>', '</Cnpj>')),
                                                             RetornaTexto(strDadosTomador, '<Cpf>', '</Cpf>'),
                                                             RetornaTexto(strDadosTomador, '<Cnpj>', '</Cnpj>'));
    cdsNFS.FieldByName('TMSIM').AsString    := RetornaTexto(strDadosTomador, '<InscricaoMunicipal>', '</InscricaoMunicipal>');
    cdsNFS.FieldByName('TMSRAZAO').AsString := AnsiReplaceStr(RetornaTexto(strDadosTomador, '<RazaoSocial>', '</RazaoSocial>'), '&amp;', '&');
    cdsNFS.FieldByName('TMSEND').AsString   := RetornaTexto(strDadosTomador, '<Endereco><Endereco>', '</Endereco>');
    cdsNFS.FieldByName('TMSNUM').AsString   := RetornaTexto(strDadosTomador, '<Numero>', '</Numero>');
    cdsNFS.FieldByName('TMSCOMPL').AsString := RetornaTexto(strDadosTomador, '<Complemento>', '</Complemento>');
    cdsNFS.FieldByName('TMSBAIR').AsString  := RetornaTexto(strDadosTomador, '<Bairro>', '</Bairro>');
    cdsNFS.FieldByName('TMSMUN').AsString   := RetornaTexto(strDadosTomador, '<CodigoMunicipio>', '</CodigoMunicipio>');
    cdsNFS.FieldByName('TMSUF').AsString    := RetornaTexto(strDadosTomador, '<Uf>', '</Uf>');
    cdsNFS.FieldByName('TMSCEP').AsString   := RetornaTexto(strDadosTomador, '<Cep>', '</Cep>');
    cdsNFS.FieldByName('TMSFONE').AsString  := RetornaTexto(strDadosTomador, '<Contato><Telefone>', '</Telefone>');
    cdsNFS.FieldByName('TMSEMAIL').AsString := RetornaTexto(strDadosTomador, '<Email>', '</Email>');

    cdsNFS.FieldByName('VLRDED').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDadosServico, '<ValorDeducoes>', '</ValorDeducoes>'),'.',','), 0);
    cdsNFS.FieldByName('VLRSER').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDadosServico, '<ValorServicos>', '</ValorServicos>'),'.',','), 0);
    cdsNFS.FieldByName('VLRIR_').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDadosServico, '<ValorIr>', '</ValorIr>'),'.',','), 0);
    cdsNFS.FieldByName('ISS_RET').AsFloat   := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDadosServico, '<IssRetido>', '</IssRetido>'),'.',','), 0);
    cdsNFS.FieldByName('VLRISS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDadosValoresNfse, '<ValorIss>', '</ValorIss>'),'.',','), 0);
    cdsNFS.FieldByName('BSCISS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDadosValoresNfse, '<BaseCalculo>', '</BaseCalculo>'),'.',','), 0);
    cdsNFS.FieldByName('ALIISS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDadosValoresNfse, '<Aliquota>', '</Aliquota>'),'.',','), 0);
    cdsNFS.FieldByName('VLRLIQ').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDadosValoresNfse, '<ValorLiquidoNfse>', '</ValorLiquidoNfse>'),'.',','), 0);
    cdsNFS.FieldByName('CODSER').AsString   := RetornaTexto(strDadosServico, '<ItemListaServico>', '</ItemListaServico>');
    cdsNFS.FieldByName('CDCNAE').AsString   := RetornaTexto(strDadosServico, '<CodigoCnae>', '</CodigoCnae>');
    cdsNFS.FieldByName('CNAEFI').AsString   := RetornaTexto(strDadosServico, '<CodigoCnae>', '</CodigoCnae>');
    cdsNFS.FieldByName('CODTRI').AsString   := RetornaTexto(strDadosServico, '<CodigoTributacaoMunicipio>', '</CodigoTributacaoMunicipio>');
    cdsNFS.FieldByName('DISCRI').AsString   := RetornaTexto(strDadosServico, '<Discriminacao>', '</Discriminacao>');
    cdsNFS.FieldByName('CODMUN').AsString   := RetornaTexto(strDadosServico, '<CodigoMunicipio>', '</CodigoMunicipio>');
    cdsNFS.FieldByName('ITEDESC').AsString  := RetornaTexto(strDadosServico, '<Descricao>', '</Descricao>');
    cdsNFS.FieldByName('ITEQTD').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDadosServico, '<Quantidade>', '</Quantidade>'),'.',','), 0);
    cdsNFS.FieldByName('ITEVLU').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDadosServico, '<ValorUnitario>', '</ValorUnitario>'),'.',','), 0);

    cdsNFS.FieldByName('ORGMUN').AsString   := RetornaTexto(strDadosOrgaoGerador, '<CodigoMunicipio>', '</CodigoMunicipio>');
    cdsNFS.FieldByName('ORG_UF').AsString   := RetornaTexto(strDadosOrgaoGerador, '<Uf>', '</Uf>');
    cdsNFS.Post;
  except
    cdsNFS.Cancel;
    raise;
  end;

  cdsItens.Append;
  try
    cdsItens.FieldByName('NUMNFS').AsString := RetornaTexto(strXML, '<Numero>', '</Numero>');
    cdsItens.FieldByName('ITEDES').AsString := RetornaTexto(strDadosServico, '<Descricao>', '</Descricao>');
    cdsItens.FieldByName('ITEQTD').AsFloat  := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDadosServico, '<Quantidade>', '</Quantidade>'),'.',','), 0);
    cdsItens.FieldByName('VLRUNT').AsFloat  := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDadosServico, '<ValorUnitario>', '</ValorUnitario>'),'.',','), 0);
    cdsItens.FieldByName('VLRTOT').AsFloat  := (StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDadosServico, '<Quantidade>', '</Quantidade>'),'.',','), 0) * StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDadosServico, '<ValorUnitario>', '</ValorUnitario>'),'.',','), 0));
    cdsItens.Post;
  except
    cdsItens.Cancel;
    raise;
  end;

end;

end.
