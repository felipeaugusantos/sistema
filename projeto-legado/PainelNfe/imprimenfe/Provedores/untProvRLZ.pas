unit untProvRLZ;

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
  TProvRLZ = class
    public
      class procedure pRetornaCDSPreenchido(var cdsNFS,  cdsItens: TUniClientDataSet; strXML: string; strNumDoc: string);
  end;
implementation

{ TProvRLZ }

class procedure TProvRLZ.pRetornaCDSPreenchido(var cdsNFS,  cdsItens: TUniClientDataSet; strXML: string; strNumDoc: string);

  function fTrataXml(strXML: String): String;
  begin
    Result := ReplaceStr(strXML, '>n', '>');
    Result := Trim(Result);
  End;

var
  XmlDoc : IXMLDocument;

  XmlNodePrincipal,
  XmlNodeServico,
  XmlNodePrestador,
  XmlNodeTomador,
  XmlNodeIncidencia,
  XmlNodePrestacao : IXMLNode;

  intInicio,
  intFinal : integer;

begin
  xmlDoc := TXMLDocument.Create(Application);

  xmlDoc.LoadFromXML(fTrataXml(strXML));
  xmlDoc.Active := True;

  XmlNodePrincipal  := XmlDoc.ChildNodes['nota'];
  XmlNodeServico    := XmlNodePrincipal.ChildNodes['servicos'].ChildNodes['servico'];
  XmlNodePrestador  := XmlNodePrincipal.ChildNodes['prestador'];
  XmlNodeTomador    := XmlNodePrincipal.ChildNodes['tomador'];
  XmlNodeIncidencia := XmlNodePrincipal.ChildNodes['localincidencia'];
  XmlNodePrestacao  := XmlNodePrincipal.ChildNodes['localprestacao'];

  cdsNFS.Append;
  // Dados da NFS
  cdsNFS.FieldByName('NUMNFS').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('numero'));
  cdsNFS.FieldByName('CODVER').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('codigoverificacao'));
  cdsNFS.FieldByName('DTAHRA').AsString := '';
  cdsNFS.FieldByName('DTAEMI').AsString := Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('data')),9,2)+'/'+
                                           Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('data')),6,2)+'/'+
                                           Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('data')),1,4);

  cdsNFS.FieldByName('NUMRPS').AsString := fRetNumeroRps(strNumDoc);
  cdsNFS.FieldByName('SERRPS').AsString := '';

  cdsNFS.FieldByName('EMIOSN').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['optantesimples']);
  cdsNFS.FieldByName('RESPTRIB').AsString := '';
  cdsNFS.FieldByName('EMIICC').AsString   := '';
  cdsNFS.FieldByName('COMPET').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('mes'))+'/'+
                                             fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('exercicio'));

  cdsNFS.FieldByName('OUTINF').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['mensagem']);
  cdsNFS.FieldByName('ORGMUN').AsString   := '';
  cdsNFS.FieldByName('ORG_UF').AsString   := '';
  cdsNFS.FieldByName('SITUAC').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['situacao']);
  cdsNFS.FieldByName('_LINK_').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['url']);

  //Valores
  cdsNFS.FieldByName('BSCISS').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['basecalculo']));
  cdsNFS.FieldByName('VLRLIQ').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['valor']));
  cdsNFS.FieldByName('VLRDED').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['deducao']));
  cdsNFS.FieldByName('VLRCRE').AsFloat  := 0;

  //Valores Serviço
  cdsNFS.FieldByName('VALINS').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['valorinss']));
  cdsNFS.FieldByName('VLRSER').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['valor']));
  cdsNFS.FieldByName('ISS_RET').AsString := iif(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['retido'])='Nao','2','1');
  cdsNFS.FieldByName('DESCONC').AsFloat  := 0;
  cdsNFS.FieldByName('DESCONI').AsFloat  := 0;
  cdsNFS.FieldByName('VALPIS').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['valorpis']));
  cdsNFS.FieldByName('VALCOF').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['valorcofins']));
  cdsNFS.FieldByName('VALIRR').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['valorirrf']));
  cdsNFS.FieldByName('VALCSL').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['valorcsll']));
  cdsNFS.FieldByName('OUT_RET').AsFloat  := 0;
  cdsNFS.FieldByName('VLRISS').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['valorimposto']));
  cdsNFS.FieldByName('ALIISS').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodeServico.ChildNodes['aliquota']));

  cdsNFS.FieldByName('VLRLIQ').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['valor'])) -
                                           fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['valorpis'])) -
                                           fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['valorcofins'])) -
                                           fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['valorirrf'])) -
                                           fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['valorcsll']));
  if cdsNFS.FieldByName('ISS_RET').AsString = '1' then
    cdsNFS.FieldByName('VLRLIQ').AsFloat := cdsNFS.FieldByName('VLRLIQ').AsFloat -
                                            fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['valorimposto']));
  //Informações de Serviço
  cdsNFS.FieldByName('CODSER').AsString := fRetornaValorTagXml(XmlNodeServico.ChildNodes['codigoservico']);
  cdsNFS.FieldByName('DESSER').AsString := fRetDescClassificacaoServico(fStrZero(AnsiReplaceStr(cdsNFS.FieldByName('CODSER').AsString, '.', ''),4));

  cdsNFS.FieldByName('CDCNAE').AsString := '';
  cdsNFS.FieldByName('CODTRI').AsString := '';
  intInicio := Pos('Informacoes:', fRetornaValorTagXml(XmlNodeServico.ChildNodes['atividade']))-1;
  intFinal  := Length(fRetornaValorTagXml(XmlNodeServico.ChildNodes['atividade']));
  cdsNFS.FieldByName('DISCRI').AsString := Copy(fRetornaValorTagXml(XmlNodeServico.ChildNodes['atividade']),
                                                1, intInicio);
  cdsNFS.FieldByName('OUTINF').AsString := Copy(fRetornaValorTagXml(XmlNodeServico.ChildNodes['atividade']),
                                           intInicio, intFinal );
  cdsNFS.FieldByName('MUNPRE').AsString := fRetornaValorTagXml(XmlNodePrestacao.ChildNodes['cidade'])+'/'+
                                           fRetornaValorTagXml(XmlNodePrestacao.ChildNodes['uf']);
  cdsNFS.FieldByName('EXIISS').AsString := '';
  cdsNFS.FieldByName('MUNINC').AsString := fRetornaValorTagXml(XmlNodeIncidencia.ChildNodes['cidade'])+'/'+
                                           fRetornaValorTagXml(XmlNodeIncidencia.ChildNodes['uf']);

  //Prestador
  cdsNFS.FieldByName('PSVCNPJ').AsString  := fRetornaValorTagXml(XmlNodePrestador.ChildNodes.FindNode('cpfcnpj'));
  cdsNFS.FieldByName('PSVDOC_').AsString  := fRetornaValorTagXml(XmlNodePrestador.ChildNodes.FindNode('cpfcnpj'));
  cdsNFS.FieldByName('PSVIM').AsString    := fRetornaValorTagXml(XmlNodePrestador.ChildNodes.FindNode('inscricao'));
  cdsNFS.FieldByName('PSVRAZAO').AsString := fRetornaValorTagXml(XmlNodePrestador.ChildNodes.FindNode('nome'));
  cdsNFS.FieldByName('PSVFANT').AsString  := fRetornaValorTagXml(XmlNodePrestador.ChildNodes.FindNode('nome'));
  cdsNFS.FieldByName('PSVEND').AsString   := fRetornaValorTagXml(XmlNodePrestador.ChildNodes.FindNode('endereco'));
  cdsNFS.FieldByName('PSVNUM').AsString   := fRetornaValorTagXml(XmlNodePrestador.ChildNodes.FindNode('numero'));
  cdsNFS.FieldByName('PSVCOMPL').AsString := fRetornaValorTagXml(XmlNodePrestador.ChildNodes.FindNode('complemento'));
  cdsNFS.FieldByName('PSVBAIR').AsString  := fRetornaValorTagXml(XmlNodePrestador.ChildNodes.FindNode('bairro'));
  cdsNFS.FieldByName('PSVMUN').AsString   := fRetornaValorTagXml(XmlNodePrestador.ChildNodes.FindNode('cidade'));
  cdsNFS.FieldByName('PSVUF').AsString    := fRetornaValorTagXml(XmlNodePrestador.ChildNodes.FindNode('uf'));
  cdsNFS.FieldByName('PSVCEP').AsString   := StringReplace(fRetornaValorTagXml(XmlNodePrestador.ChildNodes.FindNode('cep')), '-', '', [rfReplaceAll]);
  cdsNFS.FieldByName('PSVFONE').AsString  := '';
  cdsNFS.FieldByName('PSVEMAIL').AsString := '';

  //Tomador
  cdsNFS.FieldByName('TMSCNPJ').AsString  := fRetornaValorTagXml(XmlNodeTomador.ChildNodes.FindNode('cpfcnpj'));
  cdsNFS.FieldByName('TMSIM').AsString    := fRetornaValorTagXml(XmlNodeTomador.ChildNodes.FindNode('inscricao'));
  cdsNFS.FieldByName('TMSRAZAO').AsString := fRetornaValorTagXml(XmlNodeTomador.ChildNodes.FindNode('nome'));
  cdsNFS.FieldByName('TMSFANTA').AsString := fRetornaValorTagXml(XmlNodeTomador.ChildNodes.FindNode('nome'));
  cdsNFS.FieldByName('TMSEND').AsString   := fRetornaValorTagXml(XmlNodeTomador.ChildNodes.FindNode('endereco'));
  cdsNFS.FieldByName('TMSNUM').AsString   := fRetornaValorTagXml(XmlNodeTomador.ChildNodes.FindNode('numero'));
  cdsNFS.FieldByName('TMSCOMPL').AsString := fRetornaValorTagXml(XmlNodeTomador.ChildNodes.FindNode('complemento'));
  cdsNFS.FieldByName('TMSBAIR').AsString  := fRetornaValorTagXml(XmlNodeTomador.ChildNodes.FindNode('bairro'));
  cdsNFS.FieldByName('TMSMUN').AsString   := fRetornaValorTagXml(XmlNodeTomador.ChildNodes.FindNode('cidade'));
  cdsNFS.FieldByName('TMSUF').AsString    := fRetornaValorTagXml(XmlNodeTomador.ChildNodes.FindNode('uf'));
  cdsNFS.FieldByName('TMSCEP').AsString   := StringReplace(fRetornaValorTagXml(XmlNodeTomador.ChildNodes.FindNode('cep')), '-', '', [rfReplaceAll]);
  cdsNFS.FieldByName('TMSFONE').AsString  := '';
  cdsNFS.FieldByName('TMSEMAIL').AsString := '';

  cdsNFS.Post;

  if cdsItens.isEmpty then
  begin
    cdsItens.Insert;
    cdsItens.FieldByName('CODSER').asString := fRetornaValorTagXml(XmlNodeServico.ChildNodes['codigoservico']);
    cdsItens.FieldByName('ITEDES').asString := Copy(fRetornaValorTagXml(XmlNodeServico.ChildNodes['atividade']),
                                                    1, intInicio);
    cdsItens.FieldByName('VLRUNT').asFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodeServico.ChildNodes['valor']));
    cdsItens.FieldByName('ITEQTD').asFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodeServico.ChildNodes['quantidade']));
    cdsItens.FieldByName('VLRSRV').asFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodeServico.ChildNodes['total']));
    cdsItens.FieldByName('ALIISS').asFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodeServico.ChildNodes['aliquota']));
    cdsItens.Post;
  end;

end;

end.
