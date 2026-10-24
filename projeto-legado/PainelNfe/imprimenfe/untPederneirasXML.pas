unit untPederneirasXML;

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
  TPederneirasXML = class

    private

    public

      class procedure pCarregaNonfe( strXML: string; var XmlDoc : IXMLDocument; var Nonfe : IXMLNode);
      class procedure pCarregaNoNotaFiscal( var Nonfe : IXMLNode; var NoNotaFiscal : IXMLNode);
      class procedure pCarregaNoNfeCabecalho( var NoNotaFiscal : IXMLNode; var NoNfeCabecario : IXMLNode);
      class procedure pCarregaNoDadosPrestador( var NoNotaFiscal : IXMLNode; var NoDadosPrestador : IXMLNode);
      class procedure pCarregaNoDadosTomador( var NoNotaFiscal : IXMLNode; var NoDadosTomador : IXMLNode);
      class procedure pCarregaNoLocalServico( var NoNotaFiscal : IXMLNode; var NoLocalServico : IXMLNode);
      class procedure pCarregaNoDetalhesServico( var NoNotaFiscal : IXMLNode; var NoDetalhesServico : IXMLNode);
      class procedure pCarregaNoTotais( var NoNotaFiscal : IXMLNode; var NoTotais : IXMLNode);
      class procedure pCarregaNoNfeRodape( var NoNotaFiscal : IXMLNode; var NoNfeRodape : IXMLNode);

      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS: TUniClientDataSet; strXML: string);
      class procedure pRetornaCDSPreenchidoComENotasTXT(var cdsNFS: TUniClientDataSet; strXML: string);

  end;

implementation

{ TItabiraXML }

class procedure TPederneirasXML.pCarregaNoDadosPrestador(var NoNotaFiscal,
  NoDadosPrestador: IXMLNode);
begin
  If not ( NoNotaFiscal = nil ) Then
  Begin
    NoDadosPrestador := NoNotaFiscal.childNodes.FindNode('DadosPrestador');
    if not (NoDadosPrestador = nil ) then
      NoDadosPrestador.ChildNodes.First;
  End;
end;

class procedure TPederneirasXML.pCarregaNoDadosTomador(var NoNotaFiscal,
  NoDadosTomador: IXMLNode);
begin
  If not ( NoNotaFiscal = nil ) Then
  Begin
    NoDadosTomador := NoNotaFiscal.childNodes.FindNode('DadosTomador');
    if not (NoDadosTomador = nil ) then
      NoDadosTomador.ChildNodes.First;
  End;
end;

class procedure TPederneirasXML.pCarregaNoDetalhesServico(var NoNotaFiscal,
  NoDetalhesServico: IXMLNode);
begin
  If not ( NoNotaFiscal = nil ) Then
  Begin
    NoDetalhesServico := NoNotaFiscal.childNodes.FindNode('DetalhesServico');
    if not (NoDetalhesServico = nil ) then
      NoDetalhesServico.ChildNodes.First;
  End;
end;

class procedure TPederneirasXML.pCarregaNoLocalServico(var NoNotaFiscal,
  NoLocalServico: IXMLNode);
begin
  If not ( NoNotaFiscal = nil ) Then
  Begin
    NoLocalServico := NoNotaFiscal.childNodes.FindNode('localServico');
    if not (NoLocalServico = nil ) then
      NoLocalServico.ChildNodes.First;
  End;
end;

class procedure TPederneirasXML.pCarregaNonfe( strXML: string; var XmlDoc : IXMLDocument; var Nonfe : IXMLNode);
begin

  XmlDoc := TXMLDocument.Create(Application);
  XmlDoc.LoadFromXML(strXML);
  XmlDoc.Active := True;

  Nonfe := XmlDoc.DocumentElement;

end;

class procedure TPederneirasXML.pCarregaNoNfeCabecalho(var NoNotaFiscal,
  NoNfeCabecario: IXMLNode);
begin
  If not ( NoNotaFiscal = nil ) Then
  Begin
    NoNfeCabecario := NoNotaFiscal.childNodes.FindNode('NfeCabecario');
    if not (NoNfeCabecario = nil ) then
      NoNfeCabecario.ChildNodes.First;
  End;
end;

class procedure TPederneirasXML.pCarregaNoNfeRodape(var NoNotaFiscal,
  NoNfeRodape: IXMLNode);
begin
  If not ( NoNotaFiscal = nil ) Then
  Begin
    NoNfeRodape := NoNotaFiscal.childNodes.FindNode('NfeRodape');
    if not (NoNfeRodape = nil ) then
      NoNfeRodape.ChildNodes.First;
  End;
end;

class procedure TPederneirasXML.pCarregaNoNotaFiscal(var Nonfe,
  NoNotaFiscal: IXMLNode);
begin
  If not ( Nonfe = nil ) Then
  Begin
    NoNotaFiscal := Nonfe.childNodes.FindNode('NotaFiscal');
    if not (NoNotaFiscal = nil ) then
      NoNotaFiscal.ChildNodes.First;
  End;
end;

class procedure TPederneirasXML.pCarregaNoTotais(var NoNotaFiscal,
  NoTotais: IXMLNode);
begin
  If not ( NoNotaFiscal = nil ) Then
  Begin
    NoTotais := NoNotaFiscal.childNodes.FindNode('Totais');
    if not (NoTotais = nil ) then
      NoTotais.ChildNodes.First;
  End;
end;

class procedure TPederneirasXML.pRetornaCDSPreenchidoComENotas(var cdsNFS: TUniClientDataSet; strXML: string);
var
  XmlDoc : IXMLDocument;
  Nonfe,
  NoNotaFiscal,
  NoNFeCabecario,
  NoDadosPrestador,
  NoDadosTomador,
  NoLocalServico,
  NoDetalhesServico,
  NoTotais,
  NoNfeRodape : IXMLNode;
begin

  pCarregaNonfe( strXML, XmlDoc, Nonfe);
  pCarregaNoNotaFiscal( Nonfe, NoNotaFiscal);
  pCarregaNoNfeCabecalho( NoNotaFiscal, NoNfeCabecario);
  pCarregaNoDadosPrestador( NoNotaFiscal, NoDadosPrestador);
  pCarregaNoDadosTomador( NoNotaFiscal, NoDadosTomador);
  pCarregaNoLocalServico( NoNotaFiscal, NoLocalServico);
  pCarregaNoDetalhesServico( NoNotaFiscal, NoDetalhesServico);
  pCarregaNoTotais( NoNotaFiscal, NoTotais);
  pCarregaNoNfeRodape( NoNotaFiscal, NoNfeRodape);

  cdsNFS.Append;
  // Dados da NFS
  cdsNFS.FieldByName('NUMNFS').AsString := NoNfeCabecario.ChildNodes['numeroNota'].Text;
  cdsNFS.FieldByName('SERIE').AsString  := '2';
  cdsNFS.FieldByName('CODVER').AsString := NoNfeCabecario.ChildNodes['codigoAutenticacao'].Text;
  cdsNFS.FieldByName('DTAHRA').AsString := '';
  cdsNFS.FieldByName('DTAEMI').AsString := NoNfeCabecario.ChildNodes['dataEmissao'].Text;
  cdsNFS.FieldByName('NUMRPS').AsString := NoNfeCabecario.ChildNodes['numeroRps'].Text;
  cdsNFS.FieldByName('SERRPS').AsString := '';

  cdsNFS.FieldByName('NATOPE').AsInteger := 0;
  cdsNFS.FieldByName('CODRET').AsInteger := 0;
  cdsNFS.FieldByName('EMIOSN').AsString := NoNfeCabecario.ChildNodes['optIncentivoFiscal'].Text;
  cdsNFS.FieldByName('EMIICC').AsString := '';
  cdsNFS.FieldByName('COMPET').AsString := Copy(NoNfeCabecario.ChildNodes['dataEmissao'].Text,4,2)+'/'+
                                           Copy(NoNfeCabecario.ChildNodes['dataEmissao'].Text,7,4);
  cdsNFS.FieldByName('OUTINF').AsString := NoDetalhesServico.ChildNodes['obs'].Text;
  cdsNFS.FieldByName('ORGMUN').AsString := NoLocalServico.ChildNodes['cidade'].Text;
  cdsNFS.FieldByName('ORG_UF').AsString := NoLocalServico.ChildNodes['uf'].Text;

  //Valores
  cdsNFS.FieldByName('VLRSER').AsFloat := StrToFloatDef(AnsiReplaceStr(NoDetalhesServico.ChildNodes['valorServico'].Text,'.',','), 0);
  cdsNFS.FieldByName('ISS_RET').AsFloat := StrToFloatDef(AnsiReplaceStr(NoDetalhesServico.ChildNodes['issretido'].Text,'.',','), 0);
  cdsNFS.FieldByName('DESCONC').AsFloat := StrToFloatDef(AnsiReplaceStr(NoTotais.ChildNodes['descontoCondicional'].Text,'.',','), 0);
  cdsNFS.FieldByName('DESCONI').AsFloat := StrToFloatDef(AnsiReplaceStr(NoTotais.ChildNodes['descontoIncondicional'].Text,'.',','), 0);
  cdsNFS.FieldByName('VLRISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoTotais.ChildNodes['valorIss'].Text,'.',','), 0);
  cdsNFS.FieldByName('BSCISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoTotais.ChildNodes['baseCalculo'].Text,'.',','), 0);
  cdsNFS.FieldByName('ALIISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoDetalhesServico.ChildNodes['aliquota'].Text,'.',','), 0);
  cdsNFS.FieldByName('VLRLIQ').AsFloat := StrToFloatDef(AnsiReplaceStr(NoTotais.ChildNodes['valorLiquidoNota'].Text,'.',','), 0);
  cdsNFS.FieldByName('VLRDED').AsFloat := StrToFloatDef(AnsiReplaceStr(NoTotais.ChildNodes['valorDeducao'].Text,'.',','), 0);
  cdsNFS.FieldByName('CODSER').AsString := NoDetalhesServico.ChildNodes['codigo'].Text;
  cdsNFS.FieldByName('CDCNAE').AsString := '';
  cdsNFS.FieldByName('CODTRI').AsString := '';
  cdsNFS.FieldByName('DISCRI').AsString := NoDetalhesServico.ChildNodes['descricao'].Text;
  cdsNFS.FieldByName('CODMUN').AsString := '';
  cdsNFS.FieldByName('MUNINC').AsString := NoLocalServico.ChildNodes['cidade'].Text;
  cdsNFS.FieldByName('EXIISS').AsString := '';
  cdsNFS.FieldByName('ITEDESC').AsString := '';
  cdsNFS.FieldByName('ITEQTD').AsFloat := 0;
  cdsNFS.FieldByName('ITEVLU').AsFloat := 0;
  cdsNFS.FieldByName('VLRPIS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoDetalhesServico.ChildNodes['pispasep'].Text,'.',','), 0);
  cdsNFS.FieldByName('VALCOF').AsFloat := StrToFloatDef(AnsiReplaceStr(NoDetalhesServico.ChildNodes['cofins'].Text,'.',','), 0);
  cdsNFS.FieldByName('VALCSL').AsFloat := StrToFloatDef(AnsiReplaceStr(NoDetalhesServico.ChildNodes['csll'].Text,'.',','), 0);
  cdsNFS.FieldByName('VALIRR').AsFloat := StrToFloatDef(AnsiReplaceStr(NoDetalhesServico.ChildNodes['ir'].Text,'.',','), 0);
  cdsNFS.FieldByName('VALINS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoDetalhesServico.ChildNodes['inss'].Text,'.',','), 0);

  //Prestador
  cdsNFS.FieldByName('PSVCNPJ').AsString := NoDadosPrestador.ChildNodes['documento'].Text;
  cdsNFS.FieldByName('PSVIM').AsString := NoDadosPrestador.ChildNodes['im'].Text;
  cdsNFS.FieldByName('PSVRAZAO').AsString := NoDadosPrestador.ChildNodes['razaoSocial'].Text;
  cdsNFS.FieldByName('PSVFANT').AsString := NoDadosPrestador.ChildNodes['razaoSocial'].Text;
  cdsNFS.FieldByName('PSVEND').AsString := NoDadosPrestador.ChildNodes['endereco'].Text+', '+NoDadosPrestador.ChildNodes['numero'].Text;
  cdsNFS.FieldByName('PSVNUM').AsString := NoDadosPrestador.ChildNodes['numero'].Text;
  cdsNFS.FieldByName('PSVCOMPL').AsString := '';
  cdsNFS.FieldByName('PSVBAIR').AsString := NoDadosPrestador.ChildNodes['bairro'].Text;
  cdsNFS.FieldByName('PSVMUN').AsString := NoDadosPrestador.ChildNodes['municipio'].Text;
  cdsNFS.FieldByName('PSVUF').AsString := NoDadosPrestador.ChildNodes['uf'].Text;
  cdsNFS.FieldByName('PSVCEP').AsString := NoDadosPrestador.ChildNodes['cep'].Text;
  cdsNFS.FieldByName('PSVFONE').AsString := NoDadosPrestador.ChildNodes['tel'].Text;
  cdsNFS.FieldByName('PSVEMAIL').AsString := '';
  //Tomador
  cdsNFS.FieldByName('TMSCNPJ').AsString := NoDadosTomador.ChildNodes['documento'].Text;
  cdsNFS.FieldByName('TMSIE').AsString := NoDadosTomador.ChildNodes['ie'].Text;
  cdsNFS.FieldByName('TMSRAZAO').AsString := NoDadosTomador.ChildNodes['razaoSocial'].Text;
  cdsNFS.FieldByName('TMSFANTA').AsString := NoDadosTomador.ChildNodes['razaoSocial'].Text;
  cdsNFS.FieldByName('TMSEND').AsString := NoDadosTomador.ChildNodes['logradouro'].Text+', '+NoDadosTomador.ChildNodes['numero'].Text;
  cdsNFS.FieldByName('TMSNUM').AsString := NoDadosTomador.ChildNodes['numero'].Text;
  cdsNFS.FieldByName('TMSCOMPL').AsString := '';
  cdsNFS.FieldByName('TMSBAIR').AsString := NoDadosTomador.ChildNodes['bairro'].Text;
  cdsNFS.FieldByName('TMSMUN').AsString := NoDadosTomador.ChildNodes['cidade'].Text;
  cdsNFS.FieldByName('TMSUF').AsString := NoDadosTomador.ChildNodes['uf'].Text;
  cdsNFS.FieldByName('TMSCEP').AsString := NoDadosTomador.ChildNodes['cep'].Text;
  cdsNFS.FieldByName('TMSFONE').AsString := '';
  cdsNFS.FieldByName('TMSEMAIL').AsString := '';

  cdsNFS.Post;

end;

class procedure TPederneirasXML.pRetornaCDSPreenchidoComENotasTXT(var cdsNFS: TUniClientDataSet; strXML: string);
var
  strPrestador,
  strTomador: string;
begin

  strPrestador := RetornaTexto(strXML, '<PrestadorServico>', '</PrestadorServico>');
  strTomador := RetornaTexto(strXML, '<TomadorServico>', '</TomadorServico>');

  cdsNFS.Append;
  // Dados da NFS
  cdsNFS.FieldByName('NUMNFS').AsString := RetornaTexto(strXML, '<ConsultaNfse NumeroNfse="', '">');
  cdsNFS.FieldByName('SERIE').AsString  := '2';
  cdsNFS.FieldByName('CODVER').AsString := RetornaTexto(strXML, '<NumeroVerificacao>', '</NumeroVerificacao>');
  cdsNFS.FieldByName('DTAHRA').AsString := RetornaTexto(strXML, '<HoraEmissao>', '</HoraEmissao>');
  cdsNFS.FieldByName('DTAEMI').AsString := RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>');
  cdsNFS.FieldByName('NUMRPS').AsString := RetornaTexto(strXML, '<NumeroRps>', '</NumeroRps>');
  cdsNFS.FieldByName('SERRPS').AsString := RetornaTexto(strXML, '<SerieRps>', '</SerieRps>');

  cdsNFS.FieldByName('NATOPE').AsInteger := 0;
  cdsNFS.FieldByName('CODRET').AsInteger := 0;
  cdsNFS.FieldByName('EMIOSN').AsString := '';
  cdsNFS.FieldByName('EMIICC').AsString := '';
  cdsNFS.FieldByName('COMPET').AsString := Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),4,2)+'/'+
                                           Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),7,4);
  cdsNFS.FieldByName('OUTINF').AsString := '';
  cdsNFS.FieldByName('ORGMUN').AsString := RetornaTexto(strPrestador, '<Cidade>', '</Cidade>');
  cdsNFS.FieldByName('ORG_UF').AsString := RetornaTexto(strPrestador, '<Uf>', '</Uf>');

  //Valores
  cdsNFS.FieldByName('VLRSER').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorNfse>', '</ValorNfse>'),'.',','), 0);
  cdsNFS.FieldByName('ISS_RET').AsFloat := 0;
  cdsNFS.FieldByName('DESCONC').AsFloat := 0;
  cdsNFS.FieldByName('DESCONI').AsFloat := 0;
  cdsNFS.FieldByName('VLRISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorIss>', '</ValorIss>'),'.',','), 0);
  cdsNFS.FieldByName('BSCISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorBaseCalculo>', '</ValorBaseCalculo>'),'.',','), 0);
  cdsNFS.FieldByName('ALIISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<Aliquota>', '</Aliquota>'),'.',','), 0);
  cdsNFS.FieldByName('VLRLIQ').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorLiquidoNfse>', '</ValorLiquidoNfse>'),'.',','), 0);
  cdsNFS.FieldByName('VLRDED').AsFloat := 0;
  cdsNFS.FieldByName('CODSER').AsString := RetornaTexto(strXML, '<ItemListaServicoLC116>', '</ItemListaServicoLC116>');
  cdsNFS.FieldByName('CDCNAE').AsString := '';
  cdsNFS.FieldByName('CODTRI').AsString := '';
  cdsNFS.FieldByName('DISCRI').AsString := RetornaTexto(strXML, '<DiscriminacaoServico>', '</DiscriminacaoServico>');
  cdsNFS.FieldByName('CODMUN').AsString := '';
  cdsNFS.FieldByName('MUNINC').AsString := RetornaTexto(strPrestador, '<Cidade>', '</Cidade>');
  cdsNFS.FieldByName('EXIISS').AsString := '';
  cdsNFS.FieldByName('ITEDESC').AsString := '';
  cdsNFS.FieldByName('ITEQTD').AsFloat := 0;
  cdsNFS.FieldByName('ITEVLU').AsFloat := 0;
  cdsNFS.FieldByName('VLRPIS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorPis>', '</ValorPis>'),'.',','), 0);
  cdsNFS.FieldByName('VALCOF').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorCofins>', '</ValorCofins>'),'.',','), 0);
  cdsNFS.FieldByName('VALCSL').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorIsll>', '</ValorIsll>'),'.',','), 0);
  cdsNFS.FieldByName('VALIRR').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorIrrf>', '</ValorIrrf>'),'.',','), 0);
  cdsNFS.FieldByName('VALINS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorInss>', '</ValorInss>'),'.',','), 0);

  //Prestador
  cdsNFS.FieldByName('PSVCNPJ').AsString := RetornaTexto(strPrestador, '<CnpjCpf>', '</CnpjCpf>');
  cdsNFS.FieldByName('PSVIM').AsString := RetornaTexto(strPrestador, '<InscricaoMunicipal>', '</InscricaoMunicipal>');
  cdsNFS.FieldByName('PSVRAZAO').AsString := RetornaTexto(strPrestador, '<RazaoSocialNome>', '</RazaoSocialNome>');
  cdsNFS.FieldByName('PSVFANT').AsString := '';
  cdsNFS.FieldByName('PSVEND').AsString := RetornaTexto(strPrestador, '<Endereco>', '</Endereco>');
  cdsNFS.FieldByName('PSVNUM').AsString := RetornaTexto(strPrestador, '<Numero>', '</Numero>');
  cdsNFS.FieldByName('PSVCOMPL').AsString := '';
  cdsNFS.FieldByName('PSVBAIR').AsString := RetornaTexto(strPrestador, '<Bairro>', '</Bairro>');
  cdsNFS.FieldByName('PSVMUN').AsString := RetornaTexto(strPrestador, '<Cidade>', '</Cidade>');
  cdsNFS.FieldByName('PSVUF').AsString := RetornaTexto(strPrestador, '<Uf>', '</Uf>');
  cdsNFS.FieldByName('PSVCEP').AsString := RetornaTexto(strPrestador, '<Cep>', '</Cep>');
  cdsNFS.FieldByName('PSVFONE').AsString := '';
  cdsNFS.FieldByName('PSVEMAIL').AsString := '';
  //Tomador
  cdsNFS.FieldByName('TMSCNPJ').AsString := RetornaTexto(strTomador, '<CnpjCpf>', '</CnpjCpf>');
  cdsNFS.FieldByName('TMSIE').AsString := RetornaTexto(strTomador, '<InscricaoEstadual>', '</InscricaoEstadual>');
  cdsNFS.FieldByName('TMSRAZAO').AsString := RetornaTexto(strTomador, '<RazaoSocialNome>', '</RazaoSocialNome>');
  cdsNFS.FieldByName('TMSFANTA').AsString := '';
  cdsNFS.FieldByName('TMSEND').AsString := RetornaTexto(strTomador, '<Logradouro>', '</Logradouro>');
  cdsNFS.FieldByName('TMSNUM').AsString := RetornaTexto(strTomador, '<Numero>', '</Numero>');
  cdsNFS.FieldByName('TMSCOMPL').AsString := RetornaTexto(strTomador, '<Complemento>', '</Complemento>');
  cdsNFS.FieldByName('TMSBAIR').AsString := RetornaTexto(strTomador, '<Bairro>', '</Bairro>');
  cdsNFS.FieldByName('TMSMUN').AsString := RetornaTexto(strTomador, '<Cidade>', '</Cidade>');
  cdsNFS.FieldByName('TMSUF').AsString := RetornaTexto(strTomador, '<Uf>', '</Uf>');
  cdsNFS.FieldByName('TMSCEP').AsString := RetornaTexto(strTomador, '<CodigoPostal>', '</CodigoPostal>');
  cdsNFS.FieldByName('TMSFONE').AsString := '';
  cdsNFS.FieldByName('TMSEMAIL').AsString := RetornaTexto(strTomador, '<Email>', '</Email>');

  cdsNFS.Post;

end;


end.
