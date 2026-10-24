unit untProvGiap;

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
  XMLIntf, XMLDoc, DB, DBClient;

type
  TProvGiap = class

    private

    public

      class procedure pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string);

  end;

implementation

uses untUtil;

{ TProvGiap }

class procedure TProvGiap.pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string);
var
  strPrestador,
  strTomador: string;
  strMunPre: String;
begin

  strPrestador := RetornaTexto(strXML, '<PrestadorServico>', '</PrestadorServico>');
  strTomador := RetornaTexto(strXML, '<TomadorServico>', '</TomadorServico>');

  cdsNFS.Append;
  try
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

    strMunPre := RetornaTexto(strXML, '<CodigoIbgeCidadePrestacao>', '</CodigoIbgeCidadePrestacao>');
    try
      cdsNFS.FieldByName('LOCPRE').AsString := UpperCase(fCampoTabela('CONCAT(IBG_NOMMUN," / ",IBG_UF)', 'IBG_CADIBG', ['IBG_CODMUN'], [strMunPre]));
    except
      On E: Exception Do
        pGravaLogErr('NFEImpressão', '[TProvGiap.pRetornaCDSPreenchido]'+#13+E.Message);
    End;

    cdsNFS.Post;
  except
    cdsNFS.Cancel;
    raise;
  end;

end;


end.
