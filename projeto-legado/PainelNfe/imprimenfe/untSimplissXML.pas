unit untSimplissXML;

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
  TSimplissXML = class

    private

    public

      class procedure pCarregaNodListaNfse( xmlItens: TXMLDocument );
      class procedure pCarregaNodCompNfse( NodListaNfse: IXMLNode; strCidadeNFSe: string );
      class procedure pCarregaNodNfse( NodCompNfse: IXMLNode );
      class procedure pCarregaNodInfNfse( NodNfse: IXMLNode );
      class procedure pCarregaNodDeclaracaoPrestacaoServico( NodInfNfse: IXMLNode );
      class procedure pCarregaNodInfDeclaracaoPrestacaoServico( NodDeclaracaoPrestacaoServico: IXMLNode );

      class procedure pCarregaNodServico( NodInfNfse: IXMLNode );
      class procedure pCarregaNodRpsServico( NodRPS: IXMLNode );
      class procedure pCarregaNodItensServico( NodServico: IXMLNode );

      class procedure pRetornaCDSPreenchido(var cdsNFS, cdsItens: TUniClientDataSet; strXML, strCidadeNFSe: string);
      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS, cdsItens: TUniClientDataSet; strXML, strCidadeNFSe: string);

     {$IF Defined(VER300) or Defined(VER330)}
      class procedure pCarregaJSONNfse(var cdsNFS, cdsItens: TUniClientDataSet; strNfse, strCidadeNFSe : string );
     {$IFEND}

  end;

var

      nodListaNfse,
      nodCompNfse,
      nodNfse,
      nodInfNfse,
      nodDeclaracaoPrestacaoServico,
      nodInfDeclaracaoPrestacaoServico,
      nodRPS,
      nodServico,
      nodItensServico : IXMLNode;

implementation

{ TGissOnlineXML }

{$IF Defined(VER300) or Defined(VER330)}
class procedure TSimplissXML.pCarregaJSONNfse( var cdsNFS, cdsItens: TUniClientDataSet; strNfse, strCidadeNFSe : string );
var
  jValue: TJSONValue;
  jObj, jObjNfse, jObjRPS, jObjItensNfse, jObjValores: TJSONObject;
  jObjPrestador, jObjPrestadorEndereco, jObjPrestadorContato: TJSONObject;
  jObjTomador, jObjTomadorEndereco, jObjTomadorContato: TJSONObject;
  jArrayItensNfse: TJSONArray;
  k, m: Integer;
begin

  if (strCidadeNFSe='PREFEITURA DE TUBARÃO-SC') then
  begin
    try

      jValue := TJSONObject.ParseJSONValue(TEncoding.ANSI.GetBytes(strNfse), 0);

      if jValue = nil then
      begin
      {$IF Defined(LINUX)}
        Writeln('Arquivo JSON inválido.');
      {$ELSE}
        MessageDlg('Arquivo JSON inválido.', mtInformation, [mbOK], 0);
      {$IFEND}
      end
      else if jValue is TJSONObject then
      begin
        jObj := jValue as TJSONObject;
        jObjNfse := jObj.Get('DadosNfse').JsonValue as TJSONObject;

        // Pegar os dados principais da Nfse
        cdsNFS.Append;
        cdsNFS.FieldByName('NUMNFS').AsString := jObjNfse.Get('NumeroNfse').JsonValue.Value;
        cdsNFS.FieldByName('CODVER').AsString := jObjNfse.Get('CodigoValidacao').JsonValue.Value;
        cdsNFS.FieldByName('ASSPRE').AsString := '';
        cdsNFS.FieldByName('DTAHRA').AsString := '';
        cdsNFS.FieldByName('DTAEMI').AsString := Copy(jObjNfse.Get('DataEmissao').JsonValue.Value,9,2)+'/'+
                                                 Copy(jObjNfse.Get('DataEmissao').JsonValue.Value,6,2)+'/'+
                                                 Copy(jObjNfse.Get('DataEmissao').JsonValue.Value,1,4);
        cdsNFS.FieldByName('COMPET').AsString := Copy(jObjNfse.Get('Competencia').JsonValue.Value,5,2)+'/'+
                                                 Copy(jObjNfse.Get('Competencia').JsonValue.Value,1,4);
        cdsNFS.FieldByName('OUTINF').AsString := jObjNfse.Get('Observacoes').JsonValue.Value;

        // Pegar os dados do prestador
        jObjPrestador := jObjNfse.Get('Prestador').JsonValue as TJSONObject;
        cdsNFS.FieldByName('PSVCNPJ').AsString  := jObjPrestador.Get('Cnpj').JsonValue.Value;
        cdsNFS.FieldByName('PSVIM').AsString    := jObjPrestador.Get('InscricaoMunicipal').JsonValue.Value;
        cdsNFS.FieldByName('PSVRAZAO').AsString := jObjPrestador.Get('RazaoSocial').JsonValue.Value;
        cdsNFS.FieldByName('PSVFANT').AsString  := jObjPrestador.Get('NomeFantasia').JsonValue.Value;

        // Pegar os dados do prestador - endereço
        jObjPrestadorEndereco := jObjPrestador.Get('Endereco').JsonValue as TJSONObject;
        cdsNFS.FieldByName('PSVEND').AsString   := jObjPrestadorEndereco.Get('Logradouro').JsonValue.Value;
        cdsNFS.FieldByName('PSVNUM').AsString   := jObjPrestadorEndereco.Get('Numero').JsonValue.Value;
        cdsNFS.FieldByName('PSVCOMPL').AsString := jObjPrestadorEndereco.Get('Complemento').JsonValue.Value;
        cdsNFS.FieldByName('PSVBAIR').AsString  := jObjPrestadorEndereco.Get('Bairro').JsonValue.Value;
        cdsNFS.FieldByName('PSVCEP').AsString   := jObjPrestadorEndereco.Get('Cep').JsonValue.Value;
        cdsNFS.FieldByName('PSVUF').AsString    := fCampoTabela('CID_ESTADO', 'CADCID', ['CID_COIBGE'], [jObjPrestadorEndereco.Get('Municipio').JsonValue.Value]);
        cdsNFS.FieldByName('PSVMUN').AsString   := jObjPrestadorEndereco.Get('Municipio').JsonValue.Value;

        // Pegar os dados do prestador - contato
        jObjPrestadorContato := jObjPrestador.Get('Contato').JsonValue as TJSONObject;
        cdsNFS.FieldByName('PSVFONE').AsString  := jObjPrestadorContato.Get('Telefone').JsonValue.Value;
        cdsNFS.FieldByName('PSVEMAIL').AsString := jObjPrestadorContato.Get('Email').JsonValue.Value;

        // Pegar os dados do tomador
        jObjTomador := jObjNfse.Get('Tomador').JsonValue as TJSONObject;
        cdsNFS.FieldByName('TMSCNPJ').AsString  := jObjTomador.Get('NrDocumento').JsonValue.Value;
        cdsNFS.FieldByName('TMSIM').AsString    := '';
        cdsNFS.FieldByName('TMSRAZAO').AsString := jObjTomador.Get('RazaoSocial').JsonValue.Value;

        // Pegar os dados do tomador - endereço
        jObjTomadorEndereco := jObjTomador.Get('Endereco').JsonValue as TJSONObject;
        cdsNFS.FieldByName('TMSEND').AsString   := jObjTomadorEndereco.Get('Logradouro').JsonValue.Value;
        cdsNFS.FieldByName('TMSNUM').AsString   := jObjTomadorEndereco.Get('Numero').JsonValue.Value;
        cdsNFS.FieldByName('TMSCOMPL').AsString := jObjTomadorEndereco.Get('Complemento').JsonValue.Value;
        cdsNFS.FieldByName('TMSBAIR').AsString  := jObjTomadorEndereco.Get('Bairro').JsonValue.Value;
        cdsNFS.FieldByName('TMSCEP').AsString   := jObjTomadorEndereco.Get('Cep').JsonValue.Value;
        cdsNFS.FieldByName('TMSUF').AsString    := fCampoTabela('CID_ESTADO', 'CADCID', ['CID_COIBGE'], [jObjTomadorEndereco.Get('Municipio').JsonValue.Value]);
        cdsNFS.FieldByName('TMSMUN').AsString   := jObjTomadorEndereco.Get('Municipio').JsonValue.Value;

        // Pegar os dados do tomador - contato
        jObjTomadorContato := jObjTomador.Get('Contato').JsonValue as TJSONObject;
        cdsNFS.FieldByName('TMSFONE').AsString  := jObjTomadorContato.Get('Telefone').JsonValue.Value;
        cdsNFS.FieldByName('TMSEMAIL').AsString := jObjTomadorContato.Get('Email').JsonValue.Value;

        // Pegar os dados do RPS
        jObjRps := jObjNfse.Get('Rps').JsonValue as TJSONObject;
        cdsNFS.FieldByName('NUMRPS').AsString := jObjRps.Get('Numero').JsonValue.Value;
        cdsNFS.FieldByName('SERRPS').AsString := jObjRps.Get('Serie').JsonValue.Value;
        cdsNFS.FieldByName('TPORPS').AsString := jObjRps.Get('Tipo').JsonValue.Value;
        cdsNFS.FieldByName('EMIRPS').AsString := Copy(jObjRps.Get('DataEmissao').JsonValue.Value,9,2)+'/'+
                                                 Copy(jObjRps.Get('DataEmissao').JsonValue.Value,6,2)+'/'+
                                                 Copy(jObjRps.Get('DataEmissao').JsonValue.Value,1,4);

        // Pegar os dados dos Valores
        jObjValores := jObjNfse.Get('Valores').JsonValue as TJSONObject;
        cdsNFS.FieldByName('VLRSER').AsFloat  := StrToFloatDef(AnsiReplaceStr(jObjValores.Get('ValorServicos').JsonValue.Value,'.',','), 0);
        cdsNFS.FieldByName('ISS_RET').AsFloat := 0;
        cdsNFS.FieldByName('VLRISS').AsFloat  := StrToFloatDef(AnsiReplaceStr(jObjValores.Get('ValorIss').JsonValue.Value,'.',','), 0);
        cdsNFS.FieldByName('BSCISS').AsFloat  := StrToFloatDef(AnsiReplaceStr(jObjValores.Get('BaseCalculo').JsonValue.Value,'.',','), 0);
        cdsNFS.FieldByName('ALIISS').AsFloat  := StrToFloatDef(AnsiReplaceStr(jObjValores.Get('Aliquota').JsonValue.Value,'.',','), 0);
        cdsNFS.FieldByName('VLRLIQ').AsFloat  := StrToFloatDef(AnsiReplaceStr(jObjValores.Get('ValorLiquidoNota').JsonValue.Value,'.',','), 0);

        //Campos a serem verificados
        cdsNFS.FieldByName('NATOPE').AsString := '1';
        cdsNFS.FieldByName('CODRET').AsString := '';
        cdsNFS.FieldByName('EMIOSN').AsString := '';
        cdsNFS.FieldByName('EMIICC').AsString := '';

        cdsNFS.FieldByName('CODSER').AsString := '';
        cdsNFS.FieldByName('CDCNAE').AsString := '';
        cdsNFS.FieldByName('CODTRI').AsString := '';
        cdsNFS.FieldByName('DISCRI').AsString := '';
        cdsNFS.FieldByName('CODMUN').AsString := '';

        cdsNFS.FieldByName('ORGMUN').AsString := '';
        cdsNFS.FieldByName('ORG_UF').AsString := '';

        cdsNFS.Post;

        // Pegar os dados dos serviços
        jArrayItensNfse := jObjNfse.Get('Servicos').JsonValue as TJSONArray;
        for k := 0 to jArrayItensNfse.Count - 1 do
        begin
          jObjItensNfse := jArrayItensNfse.Items[k] as TJSONObject;
          cdsItens.Append;
          cdsItens.FieldByName('NUMNFS').AsString := jObjNfse.Get('NumeroNfse').JsonValue.Value;
          cdsItens.FieldByName('ITEDES').AsString := jObjItensNfse.Get('Descricao').JsonValue.Value;
          cdsItens.FieldByName('ITEQTD').AsFloat  := StrToFloatDef(AnsiReplaceStr(jObjItensNfse.Get('ValorUnitario').JsonValue.Value,'.',','), 0);
          cdsItens.FieldByName('VLRUNT').AsFloat  := StrToFloatDef(AnsiReplaceStr(jObjValores.Get('ValorServicos').JsonValue.Value,'.',','), 0);
          cdsItens.FieldByName('VLRTOT').AsFloat  := StrToFloatDef(AnsiReplaceStr(jObjValores.Get('ValorServicos').JsonValue.Value,'.',','), 0);
          cdsItens.Post;
        end;

      end;
    finally
      FreeAndNil(jValue);
    end;
  end;
end;
{$IFEND}

class procedure TSimplissXML.pCarregaNodCompNfse(NodListaNfse: IXMLNode; strCidadeNFSe: string);
var
  NoCompl : string;
begin

  NoCompl     := 'CompNfse';
  if (strCidadeNFSe='PREFEITURA DE TUBARÃO-SC') then
    NoCompl     := 'ComplNfse';

  If not ( NodListaNfse = nil ) Then
  Begin
    nodCompNfse := nodListaNfse.childNodes.FindNode(NoCompl);
    nodCompNfse.ChildNodes.First;
  End;
end;

class procedure TSimplissXML.pCarregaNodNfse( NodCompNfse: IXMLNode );
begin
  If not ( NodCompNfse = nil ) Then
  Begin
    nodNfse := nodCompNfse.childNodes.FindNode('Nfse');
    nodNfse.ChildNodes.First;
  End;
end;

class procedure TSimplissXML.pCarregaNodDeclaracaoPrestacaoServico(
  NodInfNfse: IXMLNode);
begin
  If not ( NodInfNfse = nil ) Then
  Begin
    nodDeclaracaoPrestacaoServico := nodInfNfse.ChildNodes.FindNode('DeclaracaoPrestacaoServico');
    nodDeclaracaoPrestacaoServico.ChildNodes.First;
  End;
end;

class procedure TSimplissXML.pCarregaNodInfDeclaracaoPrestacaoServico(
  NodDeclaracaoPrestacaoServico: IXMLNode);
begin
  If not ( NodDeclaracaoPrestacaoServico = nil ) Then
  Begin
    nodInfDeclaracaoPrestacaoServico := NodDeclaracaoPrestacaoServico.ChildNodes.FindNode('InfDeclaracaoPrestacaoServico');
    nodInfDeclaracaoPrestacaoServico.ChildNodes.First;
  End;
end;

class procedure TSimplissXML.pCarregaNodInfNfse( NodNfse: IXMLNode );
begin
  If not ( NodNfse = nil ) Then
  Begin
    nodInfNfse := nodNfse.ChildNodes.FindNode('InfNfse');
    nodInfNfse.ChildNodes.First;
  End;
end;

class procedure TSimplissXML.pCarregaNodServico( NodInfNfse: IXMLNode );
begin
  If not ( NodInfNfse = nil ) Then
  Begin
    nodServico := nodInfNfse.ChildNodes.FindNode('Servico');
    nodServico.ChildNodes.First;
  End;
end;

class procedure TSimplissXML.pCarregaNodRpsServico( NodRps: IXMLNode );
begin
  If not ( NodRps = nil ) Then
  Begin
    nodServico := nodRps.ChildNodes.FindNode('Servico');
    nodServico.ChildNodes.First;
  End;
end;

class procedure TSimplissXML.pRetornaCDSPreenchido(var cdsNFS, cdsItens: TUniClientDataSet; strXML, strCidadeNFSe: string);
var
  NoPrincipal,
  NoCompl : string;
  xmlDoc,
  xmlItens : TXMLDocument;
begin

  if copy(strXML,1,1) = '{' then
  begin //Formato JSON
    {$IF Defined(VER300) or Defined(VER330)}
      pCarregaJSONNfse( cdsNFS, cdsItens, strXML, strCidadeNFSe );
    {$ELSE}
      MessageDlg('Essa versão não realiza o tratamento para arquivos JSON.', mtInformation, [mbOK], 0);
    {$IFEND}
  end
  else
  begin //Formato XML

    xmlDoc := TXMLDocument.Create(Application);

    NoPrincipal := 'consultarLoteRpsResposta';
    NoCompl     := 'CompNfse';

    if (strCidadeNFSe='PREFEITURA DE TUBARÃO-SC') then
    begin
      NoPrincipal := 'consultarNotaResponse';
      NoCompl     := 'ComplNfse';
    end;

    if (strCidadeNFSe='PREFEITURA DE UNAÍ-MG') then
    begin
      NoPrincipal := 'GerarNfseResposta';
      NoCompl     := 'CompNfse';
    end;

    try
      xmlDoc.LoadFromXML(strXML);
      xmlDoc.Active := True;

      cdsNFS.Append;

      cdsNFS.FieldByName('NUMNFS').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Numero'].Text;
      cdsNFS.FieldByName('CODVER').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['CodigoVerificacao'].Text;
      if (strCidadeNFSe='PREFEITURA DE TUBARÃO-SC') then
        cdsNFS.FieldByName('ASSPRE').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['AssinaturaPrestadorTomador'].Text;
      cdsNFS.FieldByName('DTAHRA').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text;
      cdsNFS.FieldByName('DTAEMI').AsString := Copy(xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,9,2)+'/'+
                                               Copy(xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,6,2)+'/'+
                                               Copy(xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,1,4);

      cdsNFS.FieldByName('NUMRPS').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['IdentificacaoRps'].ChildNodes['Numero'].Text;
      cdsNFS.FieldByName('SERRPS').AsString := 'E'; //Segundo o Leandro (FIT)... "tem algumas prefeituras que usam fixo... apesar de mandarmos 001 eles usam essa "E" para sair no PDF
      cdsNFS.FieldByName('TPORPS').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['IdentificacaoRps'].ChildNodes['Tipo'].Text;

      cdsNFS.FieldByName('EMIRPS').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissaoRps'].Text;
      cdsNFS.FieldByName('NATOPE').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['NaturezaOperacao'].Text;
      cdsNFS.FieldByName('CODRET').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['RegimeEspecialTributacao'].Text;
      cdsNFS.FieldByName('EMIOSN').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['OptanteSimplesNacional'].Text;
      cdsNFS.FieldByName('EMIICC').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['IncentivadorCultural'].Text;
      cdsNFS.FieldByName('COMPET').AsString := Copy(xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Competencia'].Text,1,10);
      cdsNFS.FieldByName('OUTINF').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['OutrasInformacoes'].Text;

      cdsNFS.FieldByName('VLRSER').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorServicos'].Text,'.',','), 0);
      cdsNFS.FieldByName('ISS_RET').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['IssRetido'].Text,'.',','), 0);
      cdsNFS.FieldByName('VLRISS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorIss'].Text,'.',','), 0);
      cdsNFS.FieldByName('BSCISS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['BaseCalculo'].Text,'.',','), 0);
      cdsNFS.FieldByName('ALIISS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['Aliquota'].Text,'.',','), 0);
      cdsNFS.FieldByName('VLRLIQ').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorLiquidoNfse'].Text,'.',','), 0);
      cdsNFS.FieldByName('CODSER').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['ItemListaServico'].Text;
      cdsNFS.FieldByName('CDCNAE').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['CodigoCnae'].Text;
      cdsNFS.FieldByName('CODTRI').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['CodigoTributacaoMunicipio'].Text;
      cdsNFS.FieldByName('DISCRI').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Discriminacao'].Text;
      cdsNFS.FieldByName('CODMUN').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['CodigoMunicipio'].Text;
      cdsNFS.FieldByName('ITEDESC').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['ItensServico'].ChildNodes['Descricao'].Text;
      cdsNFS.FieldByName('ITEQTD').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['ItensServico'].ChildNodes['Quantidade'].Text,'.',','), 0);
      cdsNFS.FieldByName('ITEVLU').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['ItensServico'].ChildNodes['ValorUnitario'].Text,'.',','), 0);

      cdsNFS.FieldByName('PSVCNPJ').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['IdentificacaoPrestador'].ChildNodes['Cnpj'].Text;

      cdsNFS.FieldByName('PSVIM').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['IdentificacaoPrestador'].ChildNodes['InscricaoMunicipal'].Text;
      cdsNFS.FieldByName('PSVRAZAO').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['RazaoSocial'].Text;
      cdsNFS.FieldByName('PSVFANT').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['NomeFantasia'].Text;
      cdsNFS.FieldByName('PSVEND').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
      cdsNFS.FieldByName('PSVNUM').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Numero'].Text;
      cdsNFS.FieldByName('PSVCOMPL').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Complemento'].Text;
      cdsNFS.FieldByName('PSVBAIR').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
      cdsNFS.FieldByName('PSVMUN').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio'].Text;
      cdsNFS.FieldByName('PSVUF').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Uf'].Text;
      cdsNFS.FieldByName('PSVCEP').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Cep'].Text;
      cdsNFS.FieldByName('PSVFONE').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Telefone'].Text;
      cdsNFS.FieldByName('PSVEMAIL').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Email'].Text;

      cdsNFS.FieldByName('TMSCNPJ').AsString := Iif(fEmptyStr(xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text),
                                                              xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cpf'].Text,
                                                              xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text);
      cdsNFS.FieldByName('TMSIM').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['InscricaoMunicipal'].Text;
      cdsNFS.FieldByName('TMSRAZAO').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['RazaoSocial'].Text;
      cdsNFS.FieldByName('TMSEND').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
      cdsNFS.FieldByName('TMSNUM').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Numero'].Text;
      cdsNFS.FieldByName('TMSCOMPL').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Complemento'].Text;
      cdsNFS.FieldByName('TMSBAIR').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
      cdsNFS.FieldByName('TMSMUN').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio'].Text;
      cdsNFS.FieldByName('TMSUF').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Uf'].Text;
      cdsNFS.FieldByName('TMSCEP').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Cep'].Text;
      cdsNFS.FieldByName('TMSFONE').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Contato'].ChildNodes['Telefone'].Text;
      cdsNFS.FieldByName('TMSEMAIL').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Contato'].ChildNodes['Email'].Text;

      if (strCidadeNFSe='PREFEITURA DE UNAÍ-MG') then
      begin

        cdsNFS.FieldByName('VLRSER').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorServicos'].Text,'.',','), 0);
        cdsNFS.FieldByName('VLRISS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['ValoresNfse'].ChildNodes['ValorIss'].Text,'.',','), 0);
        cdsNFS.FieldByName('BSCISS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['ValoresNfse'].ChildNodes['BaseCalculo'].Text,'.',','), 0);
        cdsNFS.FieldByName('ALIISS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['ValoresNfse'].ChildNodes['Aliquota'].Text,'.',','), 0);
        cdsNFS.FieldByName('VLRLIQ').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['ValoresNfse'].ChildNodes['ValorLiquidoNfse'].Text,'.',','), 0);

        cdsNFS.FieldByName('CODSER').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['ItemListaServico'].Text;
        cdsNFS.FieldByName('PSVCNPJ').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['IdentificacaoPrestador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text;

        cdsNFS.FieldByName('TMSCNPJ').AsString := Iif(fEmptyStr(xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text),
                                                                xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cpf'].Text,
                                                                xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text);
        cdsNFS.FieldByName('TMSIM').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['InscricaoMunicipal'].Text;
        cdsNFS.FieldByName('TMSRAZAO').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['RazaoSocial'].Text;
        cdsNFS.FieldByName('TMSEND').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
        cdsNFS.FieldByName('TMSNUM').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Numero'].Text;
        cdsNFS.FieldByName('TMSCOMPL').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Complemento'].Text;
        cdsNFS.FieldByName('TMSBAIR').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
        cdsNFS.FieldByName('TMSMUN').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio'].Text;
        cdsNFS.FieldByName('TMSUF').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Uf'].Text;
        cdsNFS.FieldByName('TMSCEP').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Cep'].Text;
        cdsNFS.FieldByName('TMSFONE').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Contato'].ChildNodes['Telefone'].Text;
        cdsNFS.FieldByName('TMSEMAIL').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Contato'].ChildNodes['Email'].Text;
      end;

      if (strCidadeNFSe='PREFEITURA DE TUBARÃO-SC') then
      begin
        cdsNFS.FieldByName('TMSMUN').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['IBGE'].Text;
        cdsNFS.FieldByName('TMSUF').AsString := fCampoTabela('CID_ESTADO', 'CADCID', ['CID_COIBGE'], [xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['IBGE'].Text]);

        cdsNFS.FieldByName('PSVMUN').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['IBGE'].Text;
        cdsNFS.FieldByName('PSVUF').AsString := fCampoTabela('CID_ESTADO', 'CADCID', ['CID_COIBGE'], [xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['IBGE'].Text]);
      end;

      cdsNFS.FieldByName('ORGMUN').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['OrgaoGerador'].ChildNodes['CodigoMunicipio'].Text;
      cdsNFS.FieldByName('ORG_UF').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['OrgaoGerador'].ChildNodes['Uf'].Text;

      cdsNFS.Post;

    finally
      FreeAndNil(xmlDoc);
    end;

    xmlItens := TXMLDocument.Create(Application);

    try

      xmlItens.LoadFromXML(strXML);
      xmlItens.Active := True;

      pCarregaNodListaNfse( xmlItens );

      if not (nodListaNfse = nil) then
      begin
        pCarregaNodCompNfse( nodListaNfse, strCidadeNFSe );

        if ( strCidadeNFSe = 'PREFEITURA DE PIRACICABA' ) then
        begin
          repeat

            pCarregaNodNfse( NodCompNfse );
            pCarregaNodInfNfse( NodNfse );
            pCarregaNodServico( NodInfNfse );
            pCarregaNodItensServico( NodServico );

            repeat

              cdsItens.Append;
              cdsItens.FieldByName('NUMNFS').AsString := cdsNFS.FieldByName('NUMNFS').AsString;
              cdsItens.FieldByName('ITEDES').AsString := nodItensServico.ChildNodes['Descricao'].Text;
              cdsItens.FieldByName('ITEQTD').AsFloat  := StrToFloatDef(AnsiReplaceStr(nodItensServico.ChildNodes['Quantidade'].Text,'.',','), 0);
              cdsItens.FieldByName('VLRUNT').AsFloat  := StrToFloatDef(AnsiReplaceStr(nodItensServico.ChildNodes['ValorUnitario'].Text,'.',','), 0);
              cdsItens.FieldByName('VLRTOT').AsFloat  := (StrToFloatDef(AnsiReplaceStr(nodItensServico.ChildNodes['Quantidade'].Text,'.',','), 0) * StrToFloatDef(AnsiReplaceStr(nodItensServico.ChildNodes['ValorUnitario'].Text,'.',','), 0));
              cdsItens.Post;

              nodItensServico := nodItensServico.NextSibling;

            until nodItensServico = nil;

            nodCompNfse := nodCompNfse.NextSibling;

          until nodCompNfse = nil;
        end;

        if ( strCidadeNFSe = 'PREFEITURA DE TUBARÃO-SC' ) then
        begin
          pCarregaNodNfse( NodCompNfse );
          pCarregaNodInfNfse( NodNfse );
          pCarregaNodServico( NodInfNfse );

          cdsItens.Append;
          cdsItens.FieldByName('NUMNFS').AsString := cdsNFS.FieldByName('NUMNFS').AsString;
          cdsItens.FieldByName('ITEDES').AsString := nodServico.ChildNodes['Discriminacao'].Text;
          cdsItens.FieldByName('ITEQTD').AsFloat  := 1;
          cdsItens.FieldByName('VLRUNT').AsFloat  := StrToFloatDef(AnsiReplaceStr(nodServico.ChildNodes['Valores'].ChildNodes['ValorServicos'].Text,'.',','), 0);
          cdsItens.FieldByName('VLRTOT').AsFloat  := StrToFloatDef(AnsiReplaceStr(nodServico.ChildNodes['Valores'].ChildNodes['ValorServicos'].Text,'.',','), 0);
          cdsItens.Post;
        end;

        if ( strCidadeNFSe = 'PREFEITURA DE UNAÍ-MG' ) then
        begin

          pCarregaNodNfse( NodCompNfse );
          pCarregaNodInfNfse( NodNfse );
          pCarregaNodDeclaracaoPrestacaoServico( nodInfNfse );
          pCarregaNodInfDeclaracaoPrestacaoServico( nodDeclaracaoPrestacaoServico );
          pCarregaNodServico( nodInfDeclaracaoPrestacaoServico );

          cdsItens.Append;
          cdsItens.FieldByName('NUMNFS').AsString := cdsNFS.FieldByName('NUMNFS').AsString;
          cdsItens.FieldByName('ITEDES').AsString := nodServico.ChildNodes['Discriminacao'].Text;
          cdsItens.FieldByName('ITEQTD').AsFloat  := 1;
          cdsItens.FieldByName('VLRUNT').AsFloat  := StrToFloatDef(AnsiReplaceStr(nodServico.ChildNodes['Valores'].ChildNodes['ValorServicos'].Text,'.',','), 0);
          cdsItens.FieldByName('VLRTOT').AsFloat  := StrToFloatDef(AnsiReplaceStr(nodServico.ChildNodes['Valores'].ChildNodes['ValorServicos'].Text,'.',','), 0);
          cdsItens.Post;
        end;

      end;

    Finally
      FreeAndNil(xmlItens);
    End;

  end;

end;

class procedure TSimplissXML.pRetornaCDSPreenchidoComENotas(var cdsNFS, cdsItens: TUniClientDataSet; strXML, strCidadeNFSe: string);
var
  strXMLCorrigido,
  strDadosPrestador,
  strDadosTomador,
  strDadosServico,
  strDadosOrgaoGerador : String;
begin

  strXMLCorrigido      := StringReplace( Copy( strXML, 2, Length(strXML)-2 ), '\"', '"', [rfReplaceAll]);
  strDadosPrestador    := RetornaTexto(strXMLCorrigido, '<PrestadorServico>', '</PrestadorServico>');
  strDadosTomador      := RetornaTexto(strXMLCorrigido, '<TomadorServico>', '</TomadorServico>');
  strDadosServico      := RetornaTexto(strXMLCorrigido, '<Servico>', '</Servico>');
  strDadosOrgaoGerador := RetornaTexto(strXMLCorrigido, '<OrgaoGerador>', '</OrgaoGerador>');

  cdsNFS.Append;

  cdsNFS.FieldByName('NUMNFS').AsString := RetornaTexto(strXMLCorrigido, '<Numero>', '</Numero>');
  cdsNFS.FieldByName('CODVER').AsString := RetornaTexto(strXMLCorrigido, '<CodigoVerificacao>', '</CodigoVerificacao>');
  cdsNFS.FieldByName('DTAHRA').AsString := Copy(RetornaTexto(strXMLCorrigido, '<DataEmissao>', '</DataEmissao>'), 12, 8);
  cdsNFS.FieldByName('DTAEMI').AsString := Copy(RetornaTexto(strXMLCorrigido, '<DataEmissao>', '</DataEmissao>'),9,2)+'/'+
                                           Copy(RetornaTexto(strXMLCorrigido, '<DataEmissao>', '</DataEmissao>'),6,2)+'/'+
                                           Copy(RetornaTexto(strXMLCorrigido, '<DataEmissao>', '</DataEmissao>'),1,4);
  cdsNFS.FieldByName('NUMRPS').AsString := '';
  cdsNFS.FieldByName('SERRPS').AsString := 'E';
  cdsNFS.FieldByName('TPORPS').AsString := '';
  cdsNFS.FieldByName('EMIRPS').AsString := '';
  cdsNFS.FieldByName('NATOPE').AsString := '';
  cdsNFS.FieldByName('CODRET').AsString := RetornaTexto(strXMLCorrigido, '<RegimeEspecialTributacao>', '</RegimeEspecialTributacao>');
  cdsNFS.FieldByName('EMIOSN').AsString := RetornaTexto(strXMLCorrigido, '<OptanteSimplesNacional>', '</OptanteSimplesNacional>');
  cdsNFS.FieldByName('EMIICC').AsString := RetornaTexto(strXMLCorrigido, '<IncentivadorCultural>', '</IncentivadorCultural>');
  cdsNFS.FieldByName('COMPET').AsString := Copy(RetornaTexto(strXMLCorrigido, '<Competencia>', '</Competencia>'),1,10);
  cdsNFS.FieldByName('OUTINF').AsString := RetornaTexto(strXMLCorrigido, '<OutrasInformacoes>', '</OutrasInformacoes>');

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
  cdsNFS.FieldByName('TMSRAZAO').AsString := RetornaTexto(strDadosTomador, '<RazaoSocial>', '</RazaoSocial>');
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
  cdsNFS.FieldByName('VLRISS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDadosServico, '<ValorIss>', '</ValorIss>'),'.',','), 0);
  cdsNFS.FieldByName('BSCISS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDadosServico, '<BaseCalculo>', '</BaseCalculo>'),'.',','), 0);
  cdsNFS.FieldByName('ALIISS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDadosServico, '<Aliquota>', '</Aliquota>'),'.',','), 0);
  cdsNFS.FieldByName('VLRLIQ').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDadosServico, '<ValorLiquidoNfse>', '</ValorLiquidoNfse>'),'.',','), 0);
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

  cdsItens.Append;
  cdsItens.FieldByName('NUMNFS').AsString := RetornaTexto(strXMLCorrigido, '<Numero>', '</Numero>');
  cdsItens.FieldByName('ITEDES').AsString := RetornaTexto(strDadosServico, '<Descricao>', '</Descricao>');
  cdsItens.FieldByName('ITEQTD').AsFloat  := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDadosServico, '<Quantidade>', '</Quantidade>'),'.',','), 0);
  cdsItens.FieldByName('VLRUNT').AsFloat  := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDadosServico, '<ValorUnitario>', '</ValorUnitario>'),'.',','), 0);
  cdsItens.FieldByName('VLRTOT').AsFloat  := (StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDadosServico, '<Quantidade>', '</Quantidade>'),'.',','), 0) * StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDadosServico, '<ValorUnitario>', '</ValorUnitario>'),'.',','), 0));
  cdsItens.Post;

end;

class procedure TSimplissXML.pCarregaNodItensServico( NodServico: IXMLNode );
begin
  If not ( NodServico = nil ) Then
  Begin
    nodItensServico := nodServico.ChildNodes.FindNode('ItensServico');
    nodItensServico.ChildNodes.First;
  End;
end;

class procedure TSimplissXML.pCarregaNodListaNfse(xmlItens: TXMLDocument);
begin
  nodListaNfse := xmlItens.DocumentElement.childNodes.FindNode('ListaNfse');
end;

end.
