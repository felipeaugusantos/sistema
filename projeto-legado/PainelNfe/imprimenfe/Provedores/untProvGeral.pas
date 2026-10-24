unit untProvGeral;

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
  TProvGeral = class

    private
    public
      class procedure pRetornaCDSPreenchido(var cdsNFS : TUniClientDataSet; strXML: string;
        strNumDoc, strCodEmp, strEspDoc: string; cdsItens : TUniClientDataSet=nil; ATipoNFS: TTipoNFS = nfsXML;
        strCidNfse: String = '');
    end;

implementation

class procedure TProvGeral.pRetornaCDSPreenchido(var cdsNFS : TUniClientDataSet; strXML: string;
  strNumDoc, strCodEmp, strEspDoc: string; cdsItens : TUniClientDataSet=nil; ATipoNFS: TTipoNFS = nfsXML;
  strCidNfse: String = '');

    function fTrataTagXml(strTag: String): String;
    Begin
      Result := ReplaceStr(strTag, '<![CDATA[', '');
      Result := ReplaceStr(Result, 'R$', '');
      Result := ReplaceStr(Result, ']]>', '');
      Result := Trim(Result);
    End;
var
  xmlDoc: TXMLDocument;

  strInfNfse,
  strPrestadorServico,
  strOrgaoGerador,
  strRPS,
  strServico,
  strTomador,
  strDocTomador,
  strDataEmissao: String;

begin
  If (ATipoNFS = nfsXML)
   And (strCidNfse = 'PREFEITURA DE PONTE NOVA-MG') Then
  Begin
    cdsNFS.Append;

    // Cabeçalho;
    cdsNFS.FieldByName('NUMNFS').AsString := fTrataTagXml(RetornaTexto(strXML, '<Numero>', '</Numero>'));
    cdsNFS.FieldByName('SERIE').AsString  := 'NFS';
    cdsNFS.FieldByName('CODVER').AsString := fTrataTagXml(RetornaTexto(strXML, '<CodigoVerificacao>', '</CodigoVerificacao>'));

    strDataEmissao := fTrataTagXml(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'));
    cdsNFS.FieldByName('DTAHRA').AsString := Copy(strDataEmissao, 12,8);
    cdsNFS.FieldByName('DTAEMI').AsString := Copy(strDataEmissao, 9,2)+'/'+Copy(strDataEmissao, 6,2)+'/'+Copy(strDataEmissao, 1,4);

    cdsNFS.FieldByName('NUMRPS').AsString := fTrataTagXml(RetornaTexto(strXML, '<NumeroRps>', '</NumeroRps>'));

    cdsNFS.FieldByName('NATOPE').AsString := fTrataTagXml(RetornaTexto(strXML, '<NaturezaOperacao>', '</NaturezaOperacao>'));
    cdsNFS.FieldByName('CODRET').AsString := fTrataTagXml(RetornaTexto(strXML, '<RegimeEspecialTributacao>', '</RegimeEspecialTributacao>'));
    cdsNFS.FieldByName('EMIOSN').AsString := fTrataTagXml(RetornaTexto(strXML, '<OptanteSimplesNacional>', '</OptanteSimplesNacional>'));
    cdsNFS.FieldByName('EMIICC').AsString := fTrataTagXml(RetornaTexto(strXML, '<IncentivadorCultural>', '</IncentivadorCultural>'));
    cdsNFS.FieldByName('COMPET').AsString := fTrataTagXml(RetornaTexto(strXML, '<Competencia>', '</Competencia>'));
    cdsNFS.FieldByName('NFSSUB').AsString := fTrataTagXml(RetornaTexto(strXML, '<NfseSubstituida>', '</NfseSubstituida>'));
    cdsNFS.FieldByName('OUTINF').AsString := fTrataTagXml(RetornaTexto(strXML, '<OutrasInformacoes>', '</OutrasInformacoes>'));

    // Serviço
    cdsNFS.FieldByName('CODSER').AsString := fTrataTagXml(RetornaTexto(strXML, '<ItemListaServico>', '</ItemListaServico>'));
    cdsNFS.FieldByName('CDCNAE').AsString := fTrataTagXml(RetornaTexto(strXML, '<CodigoCNAE>', '</CodigoCNAE>'));
    cdsNFS.FieldByName('DISCRI').AsString := fTrataTagXml(RetornaTexto(strXML, '<Discriminacao>', '</Discriminacao>'));
    cdsNFS.FieldByName('MUNPRE').AsString := fTrataTagXml(RetornaTexto(strXML, '<MunicipioPrestacaoServico>', '</MunicipioPrestacaoServico>'));

    // Tributação
    cdsNFS.FieldByName('VLRSER').AsFloat  := fStrToFloatDef(fTrataTagXml(RetornaTexto(strXML, '<ValorServicos>', '</ValorServicos>')));
    cdsNFS.FieldByName('VLRDED').AsFloat  := fStrToFloatDef(fTrataTagXml(RetornaTexto(strXML, '<ValorDeducoes>', '</ValorDeducoes>')));
    cdsNFS.FieldByName('VLRPIS').AsFloat  := fStrToFloatDef(fTrataTagXml(RetornaTexto(strXML, '<ValorPIS>', '</ValorPIS>')));
    cdsNFS.FieldByName('VLRCOF').AsFloat  := fStrToFloatDef(fTrataTagXml(RetornaTexto(strXML, '<ValorCOFINS>', '</ValorCOFINS>')));
    cdsNFS.FieldByName('VLRINS').AsFloat  := fStrToFloatDef(fTrataTagXml(RetornaTexto(strXML, '<ValorINSS>', '</ValorINSS>')));
    cdsNFS.FieldByName('VLRIR_').AsFloat  := fStrToFloatDef(fTrataTagXml(RetornaTexto(strXML, '<ValorIR>', '</ValorIR>')));
    cdsNFS.FieldByName('VLRCSL').AsFloat  := fStrToFloatDef(fTrataTagXml(RetornaTexto(strXML, '<ValorCSLL>', '</ValorCSLL>')));
    cdsNFS.FieldByName('ISS_RET').AsFloat := fStrToFloatDef(fTrataTagXml(RetornaTexto(strXML, '<ValorISSRetido>', '</ValorISSRetido>')));
    cdsNFS.FieldByName('OUT_RET').AsFloat := fStrToFloatDef(fTrataTagXml(RetornaTexto(strXML, '<OutrasRetencoes>', '</OutrasRetencoes>')));
    cdsNFS.FieldByName('BSCISS').AsFloat  := fStrToFloatDef(fTrataTagXml(RetornaTexto(strXML, '<BaseCalculo>', '</BaseCalculo>')));
    cdsNFS.FieldByName('ALIISS').AsFloat  := fStrToFloatDef(fTrataTagXml(RetornaTexto(strXML, '<AliquotaServicos>', '</AliquotaServicos>')));
    cdsNFS.FieldByName('VLRLIQ').AsFloat  := fStrToFloatDef(fTrataTagXml(RetornaTexto(strXML, '<ValorLiquidoNFSe>', '</ValorLiquidoNFSe>')));
    cdsNFS.FieldByName('VLRISS').AsFloat  := fStrToFloatDef(fTrataTagXml(RetornaTexto(strXML, '<ValorISSRetido>', '</ValorISSRetido>')));
    cdsNFS.FieldByName('DESCONC').AsFloat := fStrToFloatDef(fTrataTagXml(RetornaTexto(strXML, '<ValorDescontoCondicionado>', '</ValorDescontoCondicionado>')));
    cdsNFS.FieldByName('DESCONI').AsFloat := fStrToFloatDef(fTrataTagXml(RetornaTexto(strXML, '<ValorDescontoIncondicionado>', '</ValorDescontoIncondicionado>')));

    // Prestador
    strPrestadorServico := RetornaTexto(strXML, '<PrestadorServico>', '</PrestadorServico>');
    cdsNFS.FieldByName('PSVCNPJ').AsString  := fTrataTagXml(RetornaTexto(strPrestadorServico, '<CNPJ>', '</CNPJ>'));
    cdsNFS.FieldByName('PSVIM').AsString    := fTrataTagXml(RetornaTexto(strPrestadorServico, '<InscricaoMunicipal>', '</InscricaoMunicipal>'));
    cdsNFS.FieldByName('PSVRAZAO').AsString := fTrataTagXml(RetornaTexto(strPrestadorServico, '<RazaoSocial>', '</RazaoSocial>'));
    cdsNFS.FieldByName('PSVFANT').AsString  := fTrataTagXml(RetornaTexto(strPrestadorServico, '<NomeFantasia>', '</NomeFantasia>'));

    // Endereço Prestador
    cdsNFS.FieldByName('PSVEND').AsString   := fTrataTagXml(RetornaTexto(strPrestadorServico, '<Endereco>', '</Endereco>'));
    cdsNFS.FieldByName('PSVNUM').AsString   := fTrataTagXml(RetornaTexto(strPrestadorServico, '<Numero>', '</Numero>'));
    cdsNFS.FieldByName('PSVCOMPL').AsString := fTrataTagXml(RetornaTexto(strPrestadorServico, '<Complemento>', '</Complemento>'));
    cdsNFS.FieldByName('PSVBAIR').AsString  := fTrataTagXml(RetornaTexto(strPrestadorServico, '<Bairro>', '</Bairro>'));
    cdsNFS.FieldByName('PSVMUN').AsString   := '';
    cdsNFS.FieldByName('PSVUF').AsString    := fTrataTagXml(RetornaTexto(strPrestadorServico, '<Uf>', '</Uf>'));
    cdsNFS.FieldByName('PSVCEP').AsString   := fTrataTagXml(RetornaTexto(strPrestadorServico, '<Cep>', '</Cep>'));

    //Contato Prestador
    cdsNFS.FieldByName('PSVFONE').AsString  := fTrataTagXml(RetornaTexto(strPrestadorServico, '<Telefone>', '</Telefone>'));
    cdsNFS.FieldByName('PSVEMAIL').AsString := fTrataTagXml(RetornaTexto(strPrestadorServico, '<Email>', '</Email>'));

    // Tomador
    strTomador := RetornaTexto(strXML, '<TomadorServico>', '</TomadorServico>');
    cdsNFS.FieldByName('TMSCNPJ').AsString  := fTrataTagXml(RetornaTexto(strTomador, '<CpfCnpj>', '</CpfCnpj>'));
    cdsNFS.FieldByName('TMSRAZAO').AsString := fTrataTagXml(RetornaTexto(strTomador, '<RazaoSocial>', '</RazaoSocial>'));
    cdsNFS.FieldByName('TMSIM').AsString    := fTrataTagXml(RetornaTexto(strTomador, '<InscricaoMunicipal>', '</InscricaoMunicipal>'));

    //Endereço Tomador
    cdsNFS.FieldByName('TMSEND').AsString   := fTrataTagXml(ReplaceStr(RetornaTexto(strTomador, '<Endereco>', '</Endereco>'), '<Endereco>', ''));

    cdsNFS.FieldByName('TMSNUM').AsString   := fTrataTagXml(RetornaTexto(strTomador, '<Numero>', '</Numero>'));
    cdsNFS.FieldByName('TMSCOMPL').AsString := fTrataTagXml(RetornaTexto(strTomador, '<Complemento>', '</Complemento>'));
    cdsNFS.FieldByName('TMSBAIR').AsString  := fTrataTagXml(RetornaTexto(strTomador, '<Bairro>', '</Bairro>'));
    cdsNFS.FieldByName('TMSMUN').AsString   := fTrataTagXml(RetornaTexto(strTomador, '<CodigoMunicipio>', '</CodigoMunicipio>'));
    cdsNFS.FieldByName('TMSUF').AsString    := fTrataTagXml(RetornaTexto(strTomador, '<Uf>', '</Uf>'));
    cdsNFS.FieldByName('TMSCEP').AsString   := fTrataTagXml(RetornaTexto(strTomador, '<Cep>', '</Cep>'));

    // Contato Tomador
    cdsNFS.FieldByName('TMSFONE').AsString  := fTrataTagXml(RetornaTexto(strTomador, '<Telefone>', '</Telefone>'));
    cdsNFS.FieldByName('TMSEMAIL').AsString := fTrataTagXml(RetornaTexto(strTomador, '<Email>', '</Email>'));

    // Emissor
    strOrgaoGerador := RetornaTexto(strXML, '<OrgaoGerador>', '</OrgaoGerador>');
    cdsNFS.FieldByName('ORGMUN').AsString   := fTrataTagXml(RetornaTexto(strOrgaoGerador, '<CodigoMunicipio>', '</CodigoMunicipio>'));
    cdsNFS.FieldByName('ORG_UF').AsString   := fTrataTagXml(RetornaTexto(strOrgaoGerador, '<Uf>', '</Uf>'));
    cdsNFS.FieldByName('RESPTRIB').AsString := 'P';
    cdsNFS.Post;

  End
  Else If (ATipoNFS = nfsXML) Then
  Begin
    xmlDoc := TXMLDocument.Create(Application);
    try
      xmlDoc.LoadFromXML(strXML);
      xmlDoc.Active := True;

      cdsNFS.Append;

      cdsNFS.FieldByName('NUMNFS').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Numero'].Text;
      cdsNFS.FieldByName('SERIE').AsString  := 'NFS';
      cdsNFS.FieldByName('CODVER').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['CodigoVerificacao'].Text;
      cdsNFS.FieldByName('DTAHRA').AsString := Copy(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text, 12, 8);
      cdsNFS.FieldByName('DTAEMI').AsString := Copy(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,9,2)+'/'+
                                               Copy(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,6,2)+'/'+
                                               Copy(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,1,4);
      cdsNFS.FieldByName('NUMRPS').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Numero'].Text;
      cdsNFS.FieldByName('SERRPS').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Serie'].Text;
      cdsNFS.FieldByName('TPORPS').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Tipo'].Text;
      cdsNFS.FieldByName('EMIRPS').AsString := Copy(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['DataEmissao'].Text,9,2)+'/'+
                                               Copy(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['DataEmissao'].Text,6,2)+'/'+
                                               Copy(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['DataEmissao'].Text,1,4)+' '+
                                               Copy(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['DataEmissao'].Text,12,8);
      cdsNFS.FieldByName('NATOPE').AsString := '';
      cdsNFS.FieldByName('CODRET').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['RegimeEspecialTributacao'].Text;
      cdsNFS.FieldByName('EMIOSN').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['OptanteSimplesNacional'].Text;
      cdsNFS.FieldByName('EMIICC').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['IncentivoFiscal'].Text;
      cdsNFS.FieldByName('COMPET').AsString := Copy(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Competencia'].Text,1,10);
      cdsNFS.FieldByName('NFSSUB').AsString := '';
      cdsNFS.FieldByName('OUTINF').AsString := '';
      cdsNFS.FieldByName('CODSER').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['ItemListaServico'].Text;
      cdsNFS.FieldByName('CDCNAE').AsString := '';
      cdsNFS.FieldByName('CODTRI').AsString := '';
      cdsNFS.FieldByName('DISCRI').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Discriminacao'].Text;
      cdsNFS.FieldByName('MUNPRE').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['CodigoMunicipio'].Text;
      cdsNFS.FieldByName('VLRSER').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorServicos'].Text,'.',','), 0);
      cdsNFS.FieldByName('VLRDED').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorDeducoes'].Text,'.',','), 0);
      cdsNFS.FieldByName('VLRPIS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorPis'].Text,'.',','), 0);
      cdsNFS.FieldByName('VLRCOF').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorCofins'].Text,'.',','), 0);
      cdsNFS.FieldByName('VLRINS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorInss'].Text,'.',','), 0);
      cdsNFS.FieldByName('VLRIR_').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorIr'].Text,'.',','), 0);
      cdsNFS.FieldByName('VLRCSL').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorCsll'].Text,'.',','), 0);
      cdsNFS.FieldByName('ISS_RET').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['IssRetido'].Text,'.',','), 0);
      cdsNFS.FieldByName('MUNINC').AsString  := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['MunicipioIncidencia'].Text;
      cdsNFS.FieldByName('OUT_RET').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['OutrasRetencoes'].Text,'.',','), 0);
      cdsNFS.FieldByName('BSCISS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['ValoresNfse'].ChildNodes['BaseCalculo'].Text,'.',','), 0);
      cdsNFS.FieldByName('ALIISS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['ValoresNfse'].ChildNodes['Aliquota'].Text,'.',','), 0);
      cdsNFS.FieldByName('VLRLIQ').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['ValoresNfse'].ChildNodes['ValorLiquidoNfse'].Text,'.',','), 0);
      cdsNFS.FieldByName('VLRISS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['ValoresNfse'].ChildNodes['ValorIss'].Text,'.',','), 0);
      cdsNFS.FieldByName('DESCONC').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['DescontoCondicionado'].Text,'.',','), 0);
      cdsNFS.FieldByName('DESCONI').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['DescontoIncondicionado'].Text,'.',','), 0);
      cdsNFS.FieldByName('PSVCNPJ').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['IdentificacaoPrestador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text;
      cdsNFS.FieldByName('PSVIM').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['IdentificacaoPrestador'].ChildNodes['InscricaoMunicipal'].Text;
      cdsNFS.FieldByName('IEPRES').AsString := '';
      cdsNFS.FieldByName('PSVRAZAO').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['RazaoSocial'].Text;
      cdsNFS.FieldByName('PSVFANT').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['NomeFantasia'].Text;
      cdsNFS.FieldByName('PSVEND').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
      cdsNFS.FieldByName('PSVNUM').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Numero'].Text;
      cdsNFS.FieldByName('PSVCOMPL').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Complemento'].Text;
      cdsNFS.FieldByName('PSVBAIR').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
      cdsNFS.FieldByName('PSVMUN').AsString := '';
      cdsNFS.FieldByName('PSVUF').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Uf'].Text;
      cdsNFS.FieldByName('PSVCEP').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Cep'].Text;
      cdsNFS.FieldByName('PSVFONE').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Telefone'].Text;
      cdsNFS.FieldByName('PSVEMAIL').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Email'].Text;
      cdsNFS.FieldByName('TMSCNPJ').AsString := Iif(fEmptyStr(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cpf'].Text),
                                                              xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text,
                                                              xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cpf'].Text);
      cdsNFS.FieldByName('TMSRAZAO').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['RazaoSocial'].Text;
      cdsNFS.FieldByName('TMSIM').AsString := '';
      cdsNFS.FieldByName('TMSEND').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
      cdsNFS.FieldByName('TMSNUM').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['Endereco'].ChildNodes['Numero'].Text;
      cdsNFS.FieldByName('TMSCOMPL').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['Endereco'].ChildNodes['Complemento'].Text;
      cdsNFS.FieldByName('TMSBAIR').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
      cdsNFS.FieldByName('TMSMUN').AsString := '';
      cdsNFS.FieldByName('TMSUF').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['Endereco'].ChildNodes['Uf'].Text;
      cdsNFS.FieldByName('TMSCEP').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['Endereco'].ChildNodes['Cep'].Text;
      cdsNFS.FieldByName('TMSFONE').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['Contato'].ChildNodes['Telefone'].Text;
      cdsNFS.FieldByName('TMSEMAIL').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['Contato'].ChildNodes['Email'].Text;
      cdsNFS.FieldByName('ORGMUN').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['OrgaoGerador'].ChildNodes['CodigoMunicipio'].Text;
      cdsNFS.FieldByName('ORG_UF').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['OrgaoGerador'].ChildNodes['Uf'].Text;
      cdsNFS.FieldByName('RESPTRIB').AsString := 'P';
      cdsNFS.FieldByName('OBSERV').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['observacoes'].Text;
      cdsNFS.Post;

      cdsItens.Append;
      cdsItens.FieldByName('NUMNFS').AsString := cdsNFS.FieldByName('NUMNFS').AsString;
      cdsItens.FieldByName('ITEDES').AsString := xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Discriminacao'].Text;
      cdsItens.FieldByName('ITEQTD').AsFloat  := 1;
      cdsItens.FieldByName('VLRUNT').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorServicos'].Text,'.',','), 0);
      cdsItens.FieldByName('VLRTOT').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['EnviarLoteRpsSincronoResposta'].ChildNodes['ListaNfse'].ChildNodes['CompNfse'].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorServicos'].Text,'.',','), 0);
      cdsItens.Post;

    finally
        FreeAndNil(xmlDoc);
    end;
  End;

  if (ATipoNFS = nfsTXT) then
  begin

      strInfNfse          := RetornaTexto(strXML,     '<InfNfse>'         , '</InfNfse>');
      strPrestadorServico := RetornaTexto(strInfNfse, '<PrestadorServico>', '</PrestadorServico>');
      strOrgaoGerador     := RetornaTexto(strInfNfse, '<OrgaoGerador>'    , '</OrgaoGerador>');
      strRPS              := RetornaTexto(strInfNfse, '<Rps>'             , '</Rps>');
      strServico          := RetornaTexto(strInfNfse, '<Servico>'         , '</Servico>');
      strTomador          := RetornaTexto(strInfNfse, '<Tomador>'         , '</Tomador>');
      strDocTomador       := RetornaTexto(strTomador, '<CpfCnpj>'         , '</CpfCnpj>');

      cdsNFS.Append;

      cdsNFS.FieldByName('NUMNFS').AsString   := RetornaTexto(strInfNfse, '<Numero>', '</Numero>');
      cdsNFS.FieldByName('SERIE').AsString    := 'NFS';
      cdsNFS.FieldByName('CODVER').AsString   := RetornaTexto(strInfNfse, '<CodigoVerificacao>', '</CodigoVerificacao>');
      cdsNFS.FieldByName('DTAHRA').AsString   := Copy(RetornaTexto(strInfNfse, '<DataEmissao>', '</DataEmissao>'), 12, 8);
      cdsNFS.FieldByName('DTAEMI').AsString   := Copy(RetornaTexto(strInfNfse, '<DataEmissao>', '</DataEmissao>'),9,2)+'/'+
                                                 Copy(RetornaTexto(strInfNfse, '<DataEmissao>', '</DataEmissao>'),6,2)+'/'+
                                                 Copy(RetornaTexto(strInfNfse, '<DataEmissao>', '</DataEmissao>'),1,4);
      cdsNFS.FieldByName('NUMRPS').AsString   := RetornaTexto(strRPS, '<Numero>', '</Numero>');
      cdsNFS.FieldByName('SERRPS').AsString   := RetornaTexto(strRPS, '<Serie>', '</Serie>');
      cdsNFS.FieldByName('TPORPS').AsString   := RetornaTexto(strRPS, '<Tipo>', '</Tipo>');
      cdsNFS.FieldByName('EMIRPS').AsString   := Copy(RetornaTexto(strRPS, '<DataEmissao>', '</DataEmissao>'),9,2)+'/'+
                                                 Copy(RetornaTexto(strRPS, '<DataEmissao>', '</DataEmissao>'),6,2)+'/'+
                                                 Copy(RetornaTexto(strRPS, '<DataEmissao>', '</DataEmissao>'),1,4)+' '+
                                                 Copy(RetornaTexto(strRPS, '<DataEmissao>', '</DataEmissao>'),12,8);
      cdsNFS.FieldByName('NATOPE').AsString   := '';
      cdsNFS.FieldByName('CODRET').AsString   := RetornaTexto(strInfNfse, '<RegimeEspecialTributacao>', '</RegimeEspecialTributacao>');
      cdsNFS.FieldByName('EMIOSN').AsString   := RetornaTexto(strInfNfse, '<OptanteSimplesNacional>', '</OptanteSimplesNacional>');
      cdsNFS.FieldByName('EMIICC').AsString   := RetornaTexto(strInfNfse, '<IncentivoFiscal>', '</IncentivoFiscal>');
      cdsNFS.FieldByName('COMPET').AsString   := Copy(RetornaTexto(strInfNfse, '<Competencia>', '</Competencia>'),1,10);
      cdsNFS.FieldByName('NFSSUB').AsString   := '';
      cdsNFS.FieldByName('OUTINF').AsString   := '';
      cdsNFS.FieldByName('CODSER').AsString   := RetornaTexto(strServico, '<ItemListaServico>', '</ItemListaServico>');
      cdsNFS.FieldByName('CDCNAE').AsString   := '';
      cdsNFS.FieldByName('CODTRI').AsString   := '';
      cdsNFS.FieldByName('DISCRI').AsString   := RetornaTexto(strServico, '<Discriminacao>', '</Discriminacao>');
      cdsNFS.FieldByName('MUNPRE').AsString   := RetornaTexto(strServico, '<CodigoMunicipio>', '</CodigoMunicipio>');
      cdsNFS.FieldByName('VLRSER').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorServicos>', '</ValorServicos>'),'.',','), 0);
      cdsNFS.FieldByName('VLRDED').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorDeducoes>', '</ValorDeducoes>'),'.',','), 0);
      cdsNFS.FieldByName('VLRPIS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorPis>', '</ValorPis>'),'.',','), 0);
      cdsNFS.FieldByName('VLRCOF').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorCofins>', '</ValorCofins>'),'.',','), 0);
      cdsNFS.FieldByName('VLRINS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorInss>', '</ValorInss>'),'.',','), 0);
      cdsNFS.FieldByName('VLRIR_').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorIr>', '</ValorIr>'),'.',','), 0);
      cdsNFS.FieldByName('VLRCSL').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorCsll>', '</ValorCsll>'),'.',','), 0);
      cdsNFS.FieldByName('ISS_RET').AsFloat   := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<IssRetido>', '</IssRetido>'),'.',','), 0);
      cdsNFS.FieldByName('MUNINC').AsString   := RetornaTexto(strServico, '<MunicipioIncidencia>', '</MunicipioIncidencia>');
      cdsNFS.FieldByName('OUT_RET').AsFloat   := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<OutrasRetencoes>', '</OutrasRetencoes>'),'.',','), 0);
      cdsNFS.FieldByName('BSCISS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strInfNfse, '<BaseCalculo>', '</BaseCalculo>'),'.',','), 0);
      cdsNFS.FieldByName('ALIISS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strInfNfse, '<Aliquota>', '</Aliquota>'),'.',','), 0);
      cdsNFS.FieldByName('VLRLIQ').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strInfNfse, '<ValorLiquidoNfse>', '</ValorLiquidoNfse>'),'.',','), 0);
      cdsNFS.FieldByName('VLRISS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strInfNfse, '<ValorIss>', '</ValorIss>'),'.',','), 0);
      cdsNFS.FieldByName('DESCONC').AsFloat   := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<DescontoCondicionado>', '</DescontoCondicionado>'),'.',','), 0);
      cdsNFS.FieldByName('DESCONI').AsFloat   := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<DescontoIncondicionado>', '</DescontoIncondicionado>'),'.',','), 0);
      cdsNFS.FieldByName('PSVCNPJ').AsString  := RetornaTexto(strPrestadorServico, '<Cnpj>', '</Cnpj>');
      cdsNFS.FieldByName('PSVIM').AsString    := RetornaTexto(strPrestadorServico, '<InscricaoMunicipal>', '</InscricaoMunicipal>');
      cdsNFS.FieldByName('IEPRES').AsString   := '';
      cdsNFS.FieldByName('PSVRAZAO').AsString := RetornaTexto(strPrestadorServico, '<RazaoSocial>', '</RazaoSocial>');
      cdsNFS.FieldByName('PSVFANT').AsString  := RetornaTexto(strPrestadorServico, '<NomeFantasia>', '</NomeFantasia>');
      cdsNFS.FieldByName('PSVEND').AsString   := RetornaTexto(Copy(RetornaTexto(strPrestadorServico,'<Endereco>','</Endereco>'),
                                                                   pos('<Endereco>', RetornaTexto(strPrestadorServico, '<Endereco>', '</Endereco>')),
                                                                   length(RetornaTexto(strPrestadorServico, '<Endereco>', '</Endereco>')) -
                                                                   pos('<Endereco>', RetornaTexto(strPrestadorServico, '<Endereco>', '</Endereco>'))
                                                                   ) +  '</Endereco>', '<Endereco>', '</Endereco>');
      cdsNFS.FieldByName('PSVNUM').AsString   := RetornaTexto(strPrestadorServico, '<Numero>', '</Numero>');
      cdsNFS.FieldByName('PSVCOMPL').AsString := RetornaTexto(strPrestadorServico, '<Complemento>', '</Complemento>');
      cdsNFS.FieldByName('PSVBAIR').AsString  := RetornaTexto(strPrestadorServico, '<Bairro>', '</Bairro>');
      cdsNFS.FieldByName('PSVMUN').AsString   := RetornaTexto(strPrestadorServico, '<CodigoMunicipio>', '</CodigoMunicipio>');
      cdsNFS.FieldByName('PSVUF').AsString    := RetornaTexto(strPrestadorServico, '<Uf>', '</Uf>');
      cdsNFS.FieldByName('PSVCEP').AsString   := RetornaTexto(strPrestadorServico, '<Cep>', '</Cep>');
      cdsNFS.FieldByName('PSVFONE').AsString  := RetornaTexto(strPrestadorServico, '<Telefone>', '</Telefone>');
      cdsNFS.FieldByName('PSVEMAIL').AsString := RetornaTexto(strPrestadorServico, '<Email>', '</Email>');
      cdsNFS.FieldByName('TMSCNPJ').AsString  := Iif(fEmptyStr(RetornaTexto(strDocTomador, '<Cpf>', '</Cpf>')), RetornaTexto(strDocTomador, '<Cnpj>', '</Cnpj>'), RetornaTexto(strDocTomador, '<Cpf>', '</Cpf>'));
      cdsNFS.FieldByName('TMSRAZAO').AsString := RetornaTexto(strTomador, '<RazaoSocial>', '</RazaoSocial>');
      cdsNFS.FieldByName('TMSIM').AsString    := '';
      cdsNFS.FieldByName('TMSEND').AsString   := RetornaTexto(Copy(RetornaTexto(strTomador,'<Endereco>','</Endereco>'),
                                                                   pos('<Endereco>', RetornaTexto(strTomador, '<Endereco>', '</Endereco>')),
                                                                   length(RetornaTexto(strTomador, '<Endereco>', '</Endereco>')) -
                                                                   pos('<Endereco>', RetornaTexto(strTomador, '<Endereco>', '</Endereco>'))
                                                                   ) +  '</Endereco>', '<Endereco>', '</Endereco>');
      cdsNFS.FieldByName('TMSNUM').AsString   := RetornaTexto(strTomador, '<Numero>', '</Numero>');
      cdsNFS.FieldByName('TMSCOMPL').AsString := RetornaTexto(strTomador, '<Complemento>', '</Complemento>');
      cdsNFS.FieldByName('TMSBAIR').AsString  := RetornaTexto(strTomador, '<Bairro>', '</Bairro>');
      cdsNFS.FieldByName('TMSMUN').AsString   := RetornaTexto(strTomador, '<CodigoMunicipio>', '</CodigoMunicipio>');
      cdsNFS.FieldByName('TMSUF').AsString    := RetornaTexto(strTomador, '<Uf>', '</Uf>');
      cdsNFS.FieldByName('TMSCEP').AsString   := RetornaTexto(strTomador, '<Cep>', '</Cep>');
      cdsNFS.FieldByName('TMSFONE').AsString  := RetornaTexto(strTomador, '<Telefone>', '</Telefone>');
      cdsNFS.FieldByName('TMSEMAIL').AsString := RetornaTexto(strTomador, '<Email>', '</Email>');
      cdsNFS.FieldByName('ORGMUN').AsString   := RetornaTexto(strOrgaoGerador, '<CodigoMunicipio>', '</CodigoMunicipio>');
      cdsNFS.FieldByName('ORG_UF').AsString   := RetornaTexto(strOrgaoGerador, '<Uf>', '</Uf>');
      cdsNFS.FieldByName('RESPTRIB').AsString := 'P';

      cdsNFS.Post;

      cdsItens.Append;
      cdsItens.FieldByName('NUMNFS').AsString := cdsNFS.FieldByName('NUMNFS').AsString;
      cdsItens.FieldByName('ITEDES').AsString := RetornaTexto(strServico, '<Discriminacao>', '</Discriminacao>');
      cdsItens.FieldByName('ITEQTD').AsFloat  := 1;
      cdsItens.FieldByName('VLRUNT').AsFloat  := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorServicos>', '</ValorServicos>'),'.',','), 0);
      cdsItens.FieldByName('VLRTOT').AsFloat  := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorServicos>', '</ValorServicos>'),'.',','), 0);
      cdsItens.Post;

  end;

  if (ATipoNFS = nfsJSON) then
  begin

  end;

 end;

end.
