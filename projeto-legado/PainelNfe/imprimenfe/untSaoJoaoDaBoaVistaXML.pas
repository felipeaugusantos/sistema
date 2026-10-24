unit untSaoJoaoDaBoaVistaXML;

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
  TSaoJoaoDaBoaVistaXML = class
    private
    public

      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS : TUniClientDataSet; strXML: string);

    end;
implementation

{ TSaoJoaoDaBoaVistaXML }

class procedure TSaoJoaoDaBoaVistaXML.pRetornaCDSPreenchidoComENotas(
  var cdsNFS: TUniClientDataSet; strXML: string);
var
  PrestadorServico,
  TomadorServico: String;
  NoInfNfse : IXMLDocument;
  vCHANFS : Variant;
begin

    NoInfNfse := TXMLDocument.Create(Application);
     cdsNFS.Append;

    try
      NoInfNfse.LoadFromXML(strXML);
      NoInfNfse.Active := True;

      vCHANFS := NoInfNfse.ChildNodes['nfse'].ChildNodes.FindNode('ConsultaNfse').Attributes['NumeroNfse'];
      cdsNFS.FieldByName('NUMNFS').AsString := vCHANFS;

      cdsNFS.FieldByName('CODVER').AsString := RetornaTexto(strXML, '<NumeroVerificacao>', '</NumeroVerificacao>');
      cdsNFS.FieldByName('DTAHRA').AsString := Copy(RetornaTexto(strXML, '<HoraEmissao>', '</HoraEmissao>'),1,8);
      cdsNFS.FieldByName('DTAEMI').AsString := Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),1,3)+
                                             Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),4,3)+
                                             Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),7,4);
      cdsNFS.FieldByName('NUMRPS').AsString := RetornaTexto(strXML, '<NumeroRps>', '</NumeroRps>');
      cdsNFS.FieldByName('SERRPS').AsString := RetornaTexto(strXML, '<SerieRps>', '</SerieRps>');

      PrestadorServico := RetornaTexto(strXML, '<PrestadorServico>', '</PrestadorServico>');
      cdsNFS.FieldByName('PSVCNPJ').AsString := RetornaTexto(PrestadorServico, '<CnpjCpf>', '</CnpjCpf>');
      cdsNFS.FieldByName('PSVIM').AsString := RetornaTexto(PrestadorServico, '<InscricaoMunicipal>', '</InscricaoMunicipal>');
      cdsNFS.FieldByName('PSVRAZAO').AsString := RetornaTexto(PrestadorServico, '<RazaoSocialNome>', '</RazaoSocialNome>');
      cdsNFS.FieldByName('PSVEND').AsString := RetornaTexto(PrestadorServico, '<Endereco>', '</Endereco>');
      cdsNFS.FieldByName('PSVNUM').AsString := RetornaTexto(PrestadorServico, '<Numero>', '</Numero>');
      cdsNFS.FieldByName('PSVBAIR').AsString := RetornaTexto(PrestadorServico, '<Bairro>', '</Bairro>');
      cdsNFS.FieldByName('PSVCEP').AsString := RetornaTexto(PrestadorServico, '<Cep>', '</Cep>');
      cdsNFS.FieldByName('PSVMUN').AsString := RetornaTexto(PrestadorServico, '<Cidade>', '</Cidade>');
      cdsNFS.FieldByName('PSVUF').AsString := RetornaTexto(PrestadorServico, '<Uf>', '</Uf>');
      cdsNFS.FieldByName('PSVCOMPL').AsString := RetornaTexto(PrestadorServico, '<Complemento>', '</Complemento>');
      cdsNFS.FieldByName('PSVEMAIL').AsString := RetornaTexto(PrestadorServico, '<Email>', '</Email>');
      cdsNFS.FieldByName('PSVFONE').AsString := RetornaTexto(PrestadorServico, '<Telefone>', '</Telefone>');
      cdsNFS.FieldByName('CIDPRE').AsString := RetornaTexto(PrestadorServico, '<CodigoIbgeCidadePrestacao>', '</CodigoIbgeCidadePrestacao>');

      TomadorServico := RetornaTexto(strXML, '<TomadorServico>', '</TomadorServico>');
      cdsNFS.FieldByName('TMSRAZAO').AsString := RetornaTexto(TomadorServico, '<RazaoSocialNome>', '</RazaoSocialNome>');
      cdsNFS.FieldByName('TMSCNPJ').AsString := RetornaTexto(TomadorServico, '<CnpjCpf>', '</CnpjCpf>');
      cdsNFS.FieldByName('TMSPAIS').AsString := RetornaTexto(TomadorServico, '<Pais>', '</Pais>');
      cdsNFS.FieldByName('TMSUF').AsString := RetornaTexto(TomadorServico, '<Uf>', '</Uf>');
      cdsNFS.FieldByName('TMSMUN').AsString := RetornaTexto(TomadorServico, '<Cidade>', '</Cidade>');
      cdsNFS.FieldByName('TMSEND').AsString := RetornaTexto(TomadorServico, '<Logradouro>', '</Logradouro>');
      cdsNFS.FieldByName('TMSNUM').AsString := RetornaTexto(TomadorServico, '<Numero>', '</Numero>');
      cdsNFS.FieldByName('TMSBAIR').AsString := RetornaTexto(TomadorServico, '<Bairro>', '</Bairro>');
      cdsNFS.FieldByName('TMSCEP').AsString := RetornaTexto(TomadorServico, '<CodigoPostal>', '</CodigoPostal>');
      cdsNFS.FieldByName('TMSIBGE').AsString := RetornaTexto(TomadorServico, '<CodigoIbgeCidadeTomador>', '</CodigoIbgeCidadeTomador>');
      cdsNFS.FieldByName('TMSEMAIL').AsString := RetornaTexto(TomadorServico, '<Email>', '</Email>');
      cdsNFS.FieldByName('TMSFONE').AsString := RetornaTexto(TomadorServico, '<Telefone>', '</Telefone>');
      cdsNFS.FieldByName('TMSCOMPL').AsString := RetornaTexto(TomadorServico, '<Complemento>', '</Complemento>');


      cdsNFS.FieldByName('DISCRI').AsString := RetornaTexto(strXML, '<DiscriminacaoServico>', '</DiscriminacaoServico>');
      cdsNFS.FieldByName('VLRSER').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorNfse>', '</ValorNfse>'),'.',','), 0);
      cdsNFS.FieldByName('CODSER').AsString := RetornaTexto(strXML, '<CodigoAtividade>', '</CodigoAtividade>');
      cdsNFS.FieldByName('VALINS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorInss>', '</ValorInss>'),'.',','), 0);
      cdsNFS.FieldByName('VALIRR').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorIrrf>', '</ValorIrrf>'),'.',','), 0);
      cdsNFS.FieldByName('VALCSL').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorIsll>', '</ValorIsll>'),'.',','), 0);
      cdsNFS.FieldByName('VALPIS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorPis>', '</ValorPis>'),'.',','), 0);
      cdsNFS.FieldByName('VALCOF').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorCofins>', '</ValorCofins>'),'.',','), 0);
      cdsNFS.FieldByName('BSCISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorBaseCalculo>', '</ValorBaseCalculo>'),'.',','), 0);
      cdsNFS.FieldByName('ALIISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<Aliquota>', '</Aliquota>'),'.',','), 0);
      cdsNFS.FieldByName('VLRISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorIss>', '</ValorIss>'),'.',','), 0);
      cdsNFS.FieldByName('VLRLIQ').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorLiquidoNfse>', '</ValorLiquidoNfse>'),'.',','), 0);
      cdsNFS.FieldByName('ISSPAG').AsString := RetornaTexto(strXML, '<IssPagoTomadorServico>', '</IssPagoTomadorServico>');


      cdsNFS.Post;
    Finally

    end;

  end;

end.
