unit untPinhalzinhoXML;

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
  TPinhalzinhoXML = class

    private

    public

      class function GetNodeValue(ANode: IXMLNode; const APath: string; const ADefault: string = ''): string;
      class function GetNodeFloat(ANode: IXMLNode; const APath: string): Double;
      class procedure pCarregaNoPrincipal( strXML : string );
      class procedure pCarregaNoInfNfse( NoElemento: IXMLNode );
      class procedure pCarregaNoInfDeclaracaoPrestacaoServico( NoDeclaracaoPrestacaoServico : IXMLNode );
      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS, cdsItens: TUniClientDataSet; strXML: string; strCidadeNFSe: string='');

  end;

var
  XmlDoc : IXMLDocument;
  NoElemento,
  NoInfNfse,
  NoDeclaracaoPrestacaoServico,
  NoInfDeclaracaoPrestacaoServico,
  NoRps : IXMLNode;

implementation

{ TPinhalzinhoXML }

class function TPinhalzinhoXML.GetNodeValue(ANode: IXMLNode; const APath: string; const ADefault: string = ''): string;
var
  CurrentNode: IXMLNode;
  NodeNames: TArray<string>;
  I: Integer;
begin
  Result := ADefault;
  if not Assigned(ANode) then Exit;

  NodeNames := APath.Split(['/']);
  CurrentNode := ANode;

  for I := 0 to High(NodeNames) do
  begin
    CurrentNode := CurrentNode.ChildNodes.FindNode(NodeNames[I]);
    if not Assigned(CurrentNode) then Exit;
  end;

  Result := CurrentNode.Text;
end;

class function TPinhalzinhoXML.GetNodeFloat(ANode: IXMLNode; const APath: string): Double;
var
  S: string;
begin
  S := GetNodeValue(ANode, APath, '0');
  S := StringReplace(S, '.', FormatSettings.DecimalSeparator, [rfReplaceAll]);
  S := StringReplace(S, ',', FormatSettings.DecimalSeparator, [rfReplaceAll]);
  Result := fStrToFloatDef(S);
end;

class procedure TPinhalzinhoXML.pCarregaNoPrincipal(strXML: string);
begin
  XmlDoc := TXMLDocument.Create(Application);
  XmlDoc.Options := [doNodeAutoIndent];
  XmlDoc.LoadFromXML(strXML);
  XmlDoc.Active := True;

  NoElemento := XmlDoc.DocumentElement;
end;

class procedure TPinhalzinhoXML.pCarregaNoInfNfse(NoElemento: IXMLNode);
begin
  if Assigned(NoElemento) then
    NoInfNfse := NoElemento.ChildNodes.FindNode('infNFSe');
end;

class procedure TPinhalzinhoXML.pCarregaNoInfDeclaracaoPrestacaoServico(NoDeclaracaoPrestacaoServico: IXMLNode);
begin
  if Assigned(NoDeclaracaoPrestacaoServico) then
    NoInfDeclaracaoPrestacaoServico := NoDeclaracaoPrestacaoServico.ChildNodes.FindNode('infDPS');
end;


class procedure TPinhalzinhoXML.pRetornaCDSPreenchidoComENotas(var cdsNFS, cdsItens: TUniClientDataSet; strXML: string; strCidadeNFSe: string='');
var
  NoDPS, NoInfDPS: IXMLNode;
  NoEmit, NoToma, NoServ, NoValores: IXMLNode;
  DataEmissao, DataDPS, CpfCnpj: string;
begin

  pCarregaNoPrincipal( strXML );
  pCarregaNoInfNfse( NoElemento );

  if not Assigned(NoInfNfse) then
    raise Exception.Create('XML sem elemento infNFSe.');

  // Localiza os nós principais
  NoDPS := NoInfNfse.ChildNodes.FindNode('DPS');
  if Assigned(NoDPS) then
    NoInfDPS := NoDPS.ChildNodes.FindNode('infDPS')
  else
    NoInfDPS := nil;

  NoEmit := NoInfNfse.ChildNodes.FindNode('emit');
  NoValores := NoInfNfse.ChildNodes.FindNode('valores');

  if Assigned(NoInfDPS) then
  begin
    NoToma := NoInfDPS.ChildNodes.FindNode('toma');
    NoServ := NoInfDPS.ChildNodes.FindNode('serv');
  end;

  cdsNFS.Append;
  // Dados da NFS
  cdsNFS.FieldByName('NUMNFS').AsString := GetNodeValue(NoInfNfse, 'nNFSe');
  cdsNFS.FieldByName('CODVER').AsString := GetNodeValue(NoInfNfse, 'cStat');

  DataEmissao := GetNodeValue(NoInfNfse, 'dhProc'); // Ex: 2026-07-17T10:40:57-03:00
  if Length(DataEmissao) >= 10 then
  begin
    cdsNFS.FieldByName('DTAHRA').AsString := Copy(DataEmissao, 12, 8);
    cdsNFS.FieldByName('DTAEMI').AsString := Copy(DataEmissao, 9, 2) + '/' + Copy(DataEmissao, 6, 2) + '/' + Copy(DataEmissao, 1, 4);
  end;

  if Assigned(NoInfDPS) then
  begin
    cdsNFS.FieldByName('NUMRPS').AsString := GetNodeValue(NoInfDPS, 'nDPS');
    cdsNFS.FieldByName('SERRPS').AsString := GetNodeValue(NoInfDPS, 'serie');
    cdsNFS.FieldByName('TPORPS').AsString := '1'; // Padrão DPS

    DataDPS := GetNodeValue(NoInfDPS, 'dhEmi');
    if Length(DataDPS) >= 10 then
      cdsNFS.FieldByName('EMIRPS').AsString := Copy(DataDPS, 9, 2) + '/' + Copy(DataDPS, 6, 2) + '/' + Copy(DataDPS, 1, 4);

    cdsNFS.FieldByName('EMIOSN').AsString := GetNodeValue(NoInfDPS, 'prest/regTrib/opSimpNac');
    cdsNFS.FieldByName('EMIICC').AsString := '';
    cdsNFS.FieldByName('COMPET').AsString := GetNodeValue(NoInfDPS, 'dCompet');
  end;

  cdsNFS.FieldByName('NATOPE').AsString := '';
  cdsNFS.FieldByName('CODRET').AsString := '';
  cdsNFS.FieldByName('OUTINF').AsString := '';
  cdsNFS.FieldByName('ORGMUN').AsString := GetNodeValue(NoInfNfse, 'cLocIncid');
  if Assigned(NoEmit) then
    cdsNFS.FieldByName('ORG_UF').AsString := GetNodeValue(NoEmit, 'enderNac/UF');

  //Valores
  if Assigned(NoInfDPS) then
    cdsNFS.FieldByName('VLRSER').AsFloat := GetNodeFloat(NoInfDPS, 'valores/vServPrest/vServ')
  else
  begin
    if Assigned(NoValores) then
      cdsNFS.FieldByName('VLRSER').AsFloat := GetNodeFloat(NoValores, 'vLiq');
  end;
  if Assigned(NoInfDPS) then
    cdsNFS.FieldByName('ISS_RET').AsFloat := GetNodeFloat(NoInfDPS, 'valores/trib/tribMun/tpRetISSQN');
  if Assigned(NoValores) then
  begin
    cdsNFS.FieldByName('VLRISS').AsFloat  := GetNodeFloat(NoValores, 'vISSQN');
    cdsNFS.FieldByName('BSCISS').AsFloat  := GetNodeFloat(NoValores, 'vBC');
    cdsNFS.FieldByName('ALIISS').AsFloat  := GetNodeFloat(NoValores, 'pAliqAplic');
    cdsNFS.FieldByName('VLRLIQ').AsFloat  := GetNodeFloat(NoValores, 'vLiq');
  end;

  //Dados do Serviço
  if Assigned(NoServ) then
  begin
    cdsNFS.FieldByName('CODSER').AsString := GetNodeValue(NoServ, 'cServ/cTribNac');
    cdsNFS.FieldByName('CDCNAE').AsString := GetNodeValue(NoServ, 'cServ/cNBS');
    cdsNFS.FieldByName('DISCRI').AsString := GetNodeValue(NoServ, 'cServ/xDescServ');
    cdsNFS.FieldByName('CODMUN').AsString := GetNodeValue(NoServ, 'locPrest/cLocPrestacao');
  end;

  cdsNFS.FieldByName('CODTRI').AsString  := '';
  cdsNFS.FieldByName('ITEDESC').AsString := '';
  cdsNFS.FieldByName('ITEQTD').AsFloat  := 0;
  cdsNFS.FieldByName('ITEVLU').AsFloat  := 0;

  //Prestador
  if Assigned(NoEmit) then
  begin
    cdsNFS.FieldByName('PSVCNPJ').AsString  := GetNodeValue(NoEmit, 'CNPJ');
    cdsNFS.FieldByName('PSVIM').AsString    := GetNodeValue(NoEmit, 'IM');
    cdsNFS.FieldByName('PSVRAZAO').AsString := GetNodeValue(NoEmit, 'xNome');
    cdsNFS.FieldByName('PSVFANT').AsString  := GetNodeValue(NoEmit, 'xFant');
    cdsNFS.FieldByName('PSVEND').AsString   := GetNodeValue(NoEmit, 'enderNac/xLgr');
    cdsNFS.FieldByName('PSVNUM').AsString   := GetNodeValue(NoEmit, 'enderNac/nro');
    cdsNFS.FieldByName('PSVCOMPL').AsString := GetNodeValue(NoEmit, 'enderNac/xCpl');
    cdsNFS.FieldByName('PSVBAIR').AsString  := GetNodeValue(NoEmit, 'enderNac/xBairro');
    cdsNFS.FieldByName('PSVMUN').AsString   := GetNodeValue(NoEmit, 'enderNac/cMun');
    cdsNFS.FieldByName('PSVUF').AsString    := GetNodeValue(NoEmit, 'enderNac/UF');
    cdsNFS.FieldByName('PSVCEP').AsString   := GetNodeValue(NoEmit, 'enderNac/CEP');
    cdsNFS.FieldByName('PSVFONE').AsString  := GetNodeValue(NoEmit, 'fone');
    cdsNFS.FieldByName('PSVEMAIL').AsString := GetNodeValue(NoEmit, 'email');
  end;

  //Tomador
  if Assigned(NoToma) then
  begin
    CpfCnpj := GetNodeValue(NoToma, 'CNPJ');
    if CpfCnpj = '' then
      CpfCnpj := GetNodeValue(NoToma, 'CPF');

    cdsNFS.FieldByName('TMSCNPJ').AsString  := CpfCnpj;
    cdsNFS.FieldByName('TMSIM').AsString    := GetNodeValue(NoToma, 'IM');
    cdsNFS.FieldByName('TMSIE').AsString    := '';
    cdsNFS.FieldByName('TMSRAZAO').AsString := GetNodeValue(NoToma, 'xNome');
    cdsNFS.FieldByName('TMSEND').AsString   := GetNodeValue(NoToma, 'end/xLgr');
    cdsNFS.FieldByName('TMSNUM').AsString   := GetNodeValue(NoToma, 'end/nro');
    cdsNFS.FieldByName('TMSCOMPL').AsString := GetNodeValue(NoToma, 'end/xCpl');
    cdsNFS.FieldByName('TMSBAIR').AsString  := GetNodeValue(NoToma, 'end/xBairro');
    cdsNFS.FieldByName('TMSMUN').AsString   := GetNodeValue(NoToma, 'end/endNac/cMun');
    cdsNFS.FieldByName('TMSUF').AsString    := GetNodeValue(NoToma, 'end/endNac/UF');
    cdsNFS.FieldByName('TMSCEP').AsString   := GetNodeValue(NoToma, 'end/endNac/CEP');
    cdsNFS.FieldByName('TMSFONE').AsString  := GetNodeValue(NoToma, 'fone');
    cdsNFS.FieldByName('TMSEMAIL').AsString := GetNodeValue(NoToma, 'email');
  end;

  if Assigned(NoInfDPS) then
  begin
    cdsNFS.FieldByName('EXIGIB').AsInteger := StrToIntDef(GetNodeValue(NoInfDPS, 'valores/trib/tribMun/tribISSQN'), 1);
    cdsNFS.FieldByName('MUNINC').AsString  := GetNodeValue(NoInfDPS, 'cLocEmi');
  end;

  cdsNFS.Post;

  if Assigned(cdsItens) and Assigned(NoServ) then
  begin
    cdsItens.Append;
    cdsItens.FieldByName('NUMNFS').AsString := GetNodeValue(NoInfNfse, 'nNFSe');
    cdsItens.FieldByName('ITEDES').AsString := GetNodeValue(NoServ, 'cServ/xDescServ');
    cdsItens.FieldByName('ITEQTD').AsFloat  := 1;
    cdsItens.FieldByName('VLRUNT').AsFloat  := GetNodeFloat(NoInfDPS, 'valores/vServPrest/vServ');
    cdsItens.FieldByName('VLRTOT').AsFloat  := GetNodeFloat(NoInfDPS, 'valores/vServPrest/vServ');
    cdsItens.Post;
  end;

end;

end.
