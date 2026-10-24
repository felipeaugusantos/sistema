unit untBiriguiXML;

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
  TBiriguiXML = class

    private

    public
      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS: TUniClientDataSet; strXML: string; cdsItens: TUniClientDataSet);
  end;
implementation

{ TBiriguiXML }

class procedure TBiriguiXML.pRetornaCDSPreenchidoComENotas(var cdsNFS: TUniClientDataSet; strXML: string; cdsItens: TUniClientDataSet);
begin
  cdsNFS.Append;

  //DADOS DA NOTA FISCAO DE SERVIÇO ELETRÔNICA E RPS
  cdsNFS.FieldByName('NUMNFS').AsString := RetornaTexto(strXML, '<NumeroNota>', '</NumeroNota>');
  cdsNFS.FieldByName('CODVER').AsString := RetornaTexto(strXML, '<ChaveValidacao>', '</ChaveValidacao>');
  cdsNFS.FieldByName('DTAHRA').AsString := Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'), 12, 2) + ':'+
                                           Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'), 15, 2) + ':'+
                                           Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'), 18, 2);
  cdsNFS.FieldByName('DTAEMI').AsString := Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'), 09, 2) + '/'+
                                           Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'), 06, 2) + '/'+
                                           Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'), 01, 4);
  cdsNFS.FieldByName('HRAEMI').AsString := Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'), 12, 2) + ':'+
                                           Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'), 15, 2) + ':'+
                                           Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'), 18, 2);

  cdsNFS.FieldByName('NUMRPS').AsString := RetornaTexto(strXML, '<NumeroRps>', '</NumeroRps>');
  cdsNFS.FieldByName('SERRPS').AsString := '';
  cdsNFS.FieldByName('TPORPS').AsString := '';

  cdsNFS.FieldByName('EMIRPS').AsString := '';
  cdsNFS.FieldByName('NATOPE').AsString := RetornaTexto(strXML, '<NaturezaOperacao>', '</NaturezaOperacao>');
  cdsNFS.FieldByName('CODRET').AsString := '';
  cdsNFS.FieldByName('EMIOSN').AsString := '';
  cdsNFS.FieldByName('EMIICC').AsString := '';
  cdsNFS.FieldByName('COMPET').AsString := Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'), 06, 2) + '/'+
                                           Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'), 01, 4);

  //SERVIÇOS

  cdsNFS.FieldByName('VLRSER').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<BaseCalculo>', '</BaseCalculo>'),'.',','), 0);
  if RetornaTexto(strXML, '<ImpostoRetido>', '</ImpostoRetido>') = 'false' then
    cdsNFS.FieldByName('ISS_RET').AsFloat := 0;
  cdsNFS.FieldByName('VLRISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ISSQNTotal>', '</ISSQNTotal>'),'.',','), 0);
  cdsNFS.FieldByName('BSCISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<BaseCalculo>', '</BaseCalculo>'),'.',','), 0);
  cdsNFS.FieldByName('ALIISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<Aliquota>', '</Aliquota>'),'.',','), 0);
  cdsNFS.FieldByName('VLISSR').AsFloat := 0;
  cdsNFS.FieldByName('VALPIS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<Pis>', '</Pis>'),'.',','), 0);
  cdsNFS.FieldByName('VALCOF').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<Cofins>', '</Cofins>'),'.',','), 0);
  cdsNFS.FieldByName('VALIRR').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<Irrf>', '</Irrf>'),'.',','), 0);
  cdsNFS.FieldByName('VALINS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<Inss>', '</Inss>'),'.',','), 0);
  cdsNFS.FieldByName('VALCSL').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<Csll>', '</Csll>'),'.',','), 0);
  cdsNFS.FieldByName('VLRLIQ').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorTotalNota>', '</ValorTotalNota>'),'.',','), 0);
  cdsNFS.FieldByName('CODSER').AsString := RetornaTexto(strXML, '<Cae>', '</Cae>');
  cdsNFS.FieldByName('CODTRI').AsString := '';
  cdsNFS.FieldByName('DISCRI').AsString := RetornaTexto(strXML, '<Servico>', '</Servico>');
  cdsNFS.FieldByName('CODMUN').AsString := '';
  cdsNFS.FieldByName('OBSERV').AsString := RetornaTexto(strXML, '<Observacao>', '</Observacao>');

  //PRESTADOR DO SERVIÇO
  cdsNFS.FieldByName('PSVCNPJ').AsString  := '';
  cdsNFS.FieldByName('PSVIM').AsString    := '';
  cdsNFS.FieldByName('PSVRAZAO').AsString := RetornaTexto(strXML, '<TimbreContribuinteLinha1>', '</TimbreContribuinteLinha1>');
  cdsNFS.FieldByName('PSVEND').AsString   := RetornaTexto(strXML, '<TimbreContribuinteLinha2>', '</TimbreContribuinteLinha2>');
  cdsNFS.FieldByName('PSVNUM').AsString   := '';
  cdsNFS.FieldByName('PSVBAIR').AsString  := '';
  cdsNFS.FieldByName('PSVMUN').AsString   := RetornaTexto(strXML, '<TimbreContribuinteLinha3>', '</TimbreContribuinteLinha3>');
  cdsNFS.FieldByName('PSVUF').AsString    := '';
  cdsNFS.FieldByName('PSVCEP').AsString   := '';
  cdsNFS.FieldByName('PSVFONE').AsString  := '';
  cdsNFS.FieldByName('PSVEMAIL').AsString := '';
  //TOMADOR DO SERVIÇO
  cdsNFS.FieldByName('TMSCNPJ').AsString  := RetornaTexto(strXML, '<ClienteCNPJCPF>', '</ClienteCNPJCPF>');
  cdsNFS.FieldByName('TMSIM').AsString    := RetornaTexto(strXML, '<ClienteInscricaoMunicipal>', '</ClienteInscricaoMunicipal>');
  cdsNFS.FieldByName('TMSRAZAO').AsString := RetornaTexto(strXML, '<ClienteNomeRazaoSocial>', '</ClienteNomeRazaoSocial>');
  cdsNFS.FieldByName('TMSEND').AsString   := RetornaTexto(strXML, '<ClienteEndereco>', '</ClienteEndereco>');
  cdsNFS.FieldByName('TMSNUM').AsString   := RetornaTexto(strXML, '<ClienteNumeroLogradouro>', '</ClienteNumeroLogradouro>');
  cdsNFS.FieldByName('TMSBAIR').AsString  := RetornaTexto(strXML, '<ClienteBairro>', '</ClienteBairro>');
  cdsNFS.FieldByName('TMSMUN').AsString   := RetornaTexto(strXML, '<ClienteCidade>', '</ClienteCidade>');
  cdsNFS.FieldByName('TMSUF').AsString    := RetornaTexto(strXML, '<ClienteUF>', '</ClienteUF>');
  cdsNFS.FieldByName('TMSCEP').AsString   := RetornaTexto(strXML, '<ClienteCEP>', '</ClienteCEP>');
  cdsNFS.FieldByName('TMSFONE').AsString  := RetornaTexto(strXML, '<ClienteFone>', '</ClienteFone>');
  cdsNFS.FieldByName('TMSEMAIL').AsString := RetornaTexto(strXML, '<ClienteEmail>', '</ClienteEmail>');
  cdsNFS.FieldByName('TMSCOMPL').AsString := '';
  cdsNFS.FieldByName('VALDED').AsFloat := 0;

  // ORGÃO GERADOR
  cdsNFS.FieldByName('ORGMUN').AsString := '';
  cdsNFS.FieldByName('ORG_UF').AsString := '';
  // CONSTRUÇÃO CIVIL
  cdsNFS.FieldByName('CODOBR').AsString := '';
  cdsNFS.FieldByName('CODART').AsString := '';

  cdsNFS.FieldByName('VENCTO').AsString := Copy(RetornaTexto(strXML, '<Vencimento>', '</Vencimento>'), 09, 2) + '/'+
                                           Copy(RetornaTexto(strXML, '<Vencimento>', '</Vencimento>'), 06, 2) + '/'+
                                           Copy(RetornaTexto(strXML, '<Vencimento>', '</Vencimento>'), 01, 4);

  cdsNFS.Post;

  if Assigned(cdsItens) and cdsItens.isEmpty then
  begin
    cdsItens.Append;
    cdsItens.FieldByName('NUMNFS').AsString := RetornaTexto(strXML, '<NumeroNota>', '</NumeroNota>');
    cdsItens.FieldByName('ITEDES').AsString := RetornaTexto(strXML, '<Servico>', '</Servico>');
    cdsItens.FieldByName('ITEQTD').AsFloat  := 1;
    cdsItens.FieldByName('VLRUNT').AsFloat  := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorUnitario>', '</ValorUnitario>'),'.',','), 0);
    cdsItens.FieldByName('VLRTOT').AsFloat  := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorTotal>', '</ValorTotal>'),'.',','), 0);
    cdsItens.Post;
  end;

end;

end.
