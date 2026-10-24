unit untProvPronim;

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
  TProvPronim = class

    private

    public
      class procedure pRetornaCDSPreenchido(var cdsNFS : TUniClientDataSet; strXML: string);

  end;

implementation
{ TProvPronim }

class procedure TProvPronim.pRetornaCDSPreenchido(
  var cdsNFS: TUniClientDataSet; strXML: string);
  function fQuebraDeLinhaOutInf(AOutInf: String): String;
  var
    strOutInfReplace,
    strOutInf: String;
  begin
    Result := EmptyStr;

    If fEmptyStr(AOutInf) Then
      Exit;

    strOutInfReplace := AOutInf;
    strOutInf        := strOutInfReplace;
    Case Pos('Lei', strOutInf) Of
     0, -1: Begin
              strOutInf        := EmptyStr;
              strOutInfReplace := Copy(strOutInfReplace, 1, Length(strOutInfReplace));
            End;
      Else
      Begin
        strOutInf := Copy(strOutInf, Pos('Lei', strOutInf), Length(strOutInf));
        strOutInfReplace := Copy(strOutInfReplace, 1, Pos('Lei', strOutInfReplace)-1);
      End;
    End;

    strOutInfReplace := StringReplace(strOutInfReplace, 'n', sLineBreak, [rfReplaceAll]);
    Result := strOutInfReplace + strOutInf;
  end;

var
  XmlDoc : IXMLDocument;
begin

  xmlDoc := TXMLDocument.Create(Application);

  xmlDoc.LoadFromXML(strXML);
  xmlDoc.Active := True;

  cdsNFS.Append;

  //DADOS DA NOTA FISCAO DE SERVIÇO ELETRÔNICA E RPS
  cdsNFS.FieldByName('NUMNFS').AsString   := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Numero'].Text;
  cdsNFS.FieldByName('CODVER').AsString   := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['CodigoVerificacao'].Text;

  cdsNFS.FieldByName('DTAHRA').AsString   := Copy(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,12,8);
  cdsNFS.FieldByName('DTAEMI').AsString   := Copy(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,9,2)+'/'+
                                             Copy(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,6,2)+'/'+
                                             Copy(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,1,4);
  cdsNFS.FieldByName('COMPET').AsString   := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text;

  cdsNFS.FieldByName('NUMRPS').AsString   := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].
                                             ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Numero'].Text;
  cdsNFS.FieldByName('SERRPS').AsString   := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].
                                             ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Serie'].Text;
  cdsNFS.FieldByName('TPORPS').AsString   := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].
                                             ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Tipo'].Text;
  cdsNFS.FieldByName('NATOPE').AsString   := '';

  cdsNFS.FieldByName('DTAVEN').AsString   := Copy(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Competencia'].Text,9,2)+'/'+
                                             Copy(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Competencia'].Text,6,2)+'/'+
                                             Copy(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Competencia'].Text,1,4);

  // Serviços
  cdsNFS.FieldByName('VLRSER').AsFloat    := fStrToFloatDef(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].
                                             ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorServicos'].Text);
  cdsNFS.FieldByName('VLRDED').AsFloat    := fStrToFloatDef(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].
                                             ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorDeducoes'].Text);
  cdsNFS.FieldByName('VALPIS').AsFloat    := fStrToFloatDef(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].
                                             ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorPis'].Text);
  cdsNFS.FieldByName('VALCOF').AsFloat    := fStrToFloatDef(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].
                                             ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorCofins'].Text);
  cdsNFS.FieldByName('VALINS').AsFloat    := fStrToFloatDef(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].
                                             ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorInss'].Text);
  cdsNFS.FieldByName('VALIRR').AsFloat    := fStrToFloatDef(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].
                                             ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorIr'].Text);
  cdsNFS.FieldByName('VALCSL').AsFloat    := fStrToFloatDef(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].
                                             ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorCsll'].Text);
  cdsNFS.FieldByName('VLRISS').AsFloat    := fStrToFloatDef(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].
                                             ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorIss'].Text);
  cdsNFS.FieldByName('BSCISS').AsFloat    := fStrToFloatDef(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['ValoresNfse'].ChildNodes['BaseCalculo'].Text);
  cdsNFS.FieldByName('ALIISS').AsFloat    := fStrToFloatDef(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['ValoresNfse'].ChildNodes['Aliquota'].Text);
  cdsNFS.FieldByName('VLRLIQ').AsFloat    := 0;
  cdsNFS.FieldByName('DESCONI').AsFloat   := fStrToFloatDef(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].
                                             ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['DescontoIncondicionado'].Text);
  cdsNFS.FieldByName('VLISSR').AsFloat    := fStrToFloatDef(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].
                                             ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorIssRetido'].Text);
  cdsNFS.FieldByName('ISS_RET').AsFloat   := fStrToFloatDef(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].
                                             ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['IssRetido'].Text);
  cdsNFS.FieldByName('OUT_RET').AsFloat   := 0;

  cdsNFS.FieldByName('CODSER').AsString   := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].
                                             ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['ItemListaServico'].Text;
  cdsNFS.FieldByName('CODTRI').AsString   := '';
  cdsNFS.FieldByName('DISCRI').AsString   := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].
                                             ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Discriminacao'].Text;
  cdsNFS.FieldByName('CODMUN').AsString   := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].
                                             ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['CodigoMunicipio'].Text;
  cdsNFS.FieldByName('CDCNAE').AsString   := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].
                                             ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['CodigoCnae'].Text;
  // Prestador
  cdsNFS.FieldByName('PSVCNPJ').AsString  := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['IdentificacaoPrestador'].ChildNodes['Cnpj'].Text;
  cdsNFS.FieldByName('PSVIM').AsString    := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['IdentificacaoPrestador'].ChildNodes['InscricaoMunicipal'].Text;
  cdsNFS.FieldByName('PSVRAZAO').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['RazaoSocial'].Text;

  cdsNFS.FieldByName('PSVEND').AsString   := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
  cdsNFS.FieldByName('PSVNUM').AsString   := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Numero'].Text;
  cdsNFS.FieldByName('PSVBAIR').AsString  := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
  cdsNFS.FieldByName('PSVMUN').AsString   := '';
  cdsNFS.FieldByName('PSVUF').AsString    := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Uf'].Text;
  cdsNFS.FieldByName('PSVCEP').AsString   := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Cep'].Text;
  cdsNFS.FieldByName('PSVFONE').AsString  := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Telefone'].Text;
  cdsNFS.FieldByName('PSVEMAIL').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Email'].Text;
  cdsNFS.FieldByName('PSVCOMPL').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Complemento'].Text;

  // Tomador
  cdsNFS.FieldByName('TMSCNPJ').AsString  := Iif(fEmptyStr(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].
                                                           ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text),
                                                           xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].
                                                           ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cpf'].Text,
                                                           xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].
                                                           ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text);

  cdsNFS.FieldByName('TMSRAZAO').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].
                                             ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['RazaoSocial'].Text;
  cdsNFS.FieldByName('TMSEND').AsString   := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].
                                             ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
  cdsNFS.FieldByName('TMSNUM').AsString   := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].
                                             ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Numero'].Text;
  cdsNFS.FieldByName('TMSBAIR').AsString  := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].
                                             ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
  cdsNFS.FieldByName('TMSMUN').AsString   := '';
  cdsNFS.FieldByName('TMSUF').AsString    := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].
                                             ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Uf'].Text;
  cdsNFS.FieldByName('TMSCEP').AsString   := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].
                                             ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Cep'].Text;

  cdsNFS.FieldByName('TMSEMAIL').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].
                                             ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Contato'].ChildNodes['Email'].Text;
  cdsNFS.FieldByName('TMSFONE').AsString  := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].
                                             ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Contato'].ChildNodes['Telefone'].Text;
  cdsNFS.FieldByName('TMSIM').AsString    := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].
                                             ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['InscricaoMunicipal'].Text;
  cdsNFS.FieldByName('TMSCOMPL').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].
                                             ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Complemento'].Text;
   // Orgão Gerador
  cdsNFS.FieldByName('ORGMUN').AsString   := '';
  cdsNFS.FieldByName('ORG_UF').AsString   := '';
  cdsNFS.FieldByName('OUTINF').AsString   := '';

  cdsNFS.Post;

end;

end.
