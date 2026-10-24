unit untXMLNFSePadrao;

interface

uses
  System.StrUtils, System.SysUtils, System.TypInfo, System.Rtti, Xml.XMLIntf;

type
  TXMLNFSeLayoutTipo = (ltDesconhecido, ltNacional_V1, ltNacional_V1_1, ltABRASF_V1, ltABRASF_V2, ltABRASF_V2_04, ltConfigurado);

  TTipoCampo = (
    tcDesconhecido,
    FIS_FORCLI,
    FIS_CGCDES,
    FIS_SERIE_,
    FIS_NUMDOC,
    FIS_DTAENT,
    FIS_VLCON1,
    FIS_HISTOR,
    FIS_CDSERV,
    FIS_ACESSO,
    // Impostos e Retenções
    FIS_BASISS,
    FIS_ALQISS,
    FIS_VALISS,
    FIS_REIRRF,
    FIS_RETPIS,
    FIS_RETCOF,
    FIS_RECSLL,
    FIS_REINSS,
    FIS_ALQPIS,
    FIS_BASPIS,
    FIS_ALQCOF,
    FIS_BASCOF,
    // Reforma Tributária (IBS / CBS)
    REF_CODCST,
    REF_CLATRI,
    REF_BASCAL,
    REF_CBSALQ,
    REF_CBSALE,
    REF_CBSVAL,
    REF_IBSUFA,
    REF_IBSUFE,
    REF_IBSUFV,
    REF_IBSMNA,
    REF_IBSMNE,
    REF_IBSMNV,
    REF_VALIBS,
    REF_VALOPE,
    FIS_TRISSQ, // Tipo retenção ISSQN
    FIS_TRPIS_, // Tipo retenção PIS
    FIS_TRCOFI, // Tipo retenção COFINS
    FIS_TRIRRF, // Tipo retenção IRRF
    FIS_TRCSLL, // Tipo retenção CSLL
    FIS_TRINSS, // Tipo retenção INSS/CP
    FIS_TOTRET, // Total Retenção
    FIS_VLSERV,  // Valor Serviço
    FIS_NUMDPS,  // Numero DPS
    FIS_SERDPS,  // Serie DPS
    FIS_FORFIS
    ,FIS_TRPICO   // Tipo retencao PIS/COFINS - Padrao Nacional (tpRetPisCofins)
  );

  TXMLNFSePadrao = class
  private
    FenuXMLNFSeLayoutTipo: TXMLNFSeLayoutTipo;
    function fLayoutNacional_V1_1(const ACampo: TTipoCampo): string;
    function fLayoutABRASF_V1(const ACampo: TTipoCampo): string;
    function fLayoutABRASF_V2(const ACampo: TTipoCampo): string;
    function fLayoutNacional_V1(const ACampo: TTipoCampo): string;
    function fIdentificarCampo<T>(const AValue: string): T;
    function fBuscarNo(ANode: IXMLNode; const ANome: String): IXMLNode;
    function fLayoutABRASF_V2_04(const ACampo: TTipoCampo): string;
  public
    function fDetectarLayout(ANode: IXMLNode): TXMLNFSeLayoutTipo;
    function fCampo(AstrNomeCampo: String): String;
    function fXMLNFSeLayoutTipo(AXMLNFSeLayoutTipo: TXMLNFSeLayoutTipo): TXMLNFSePadrao;
  end;

implementation

{ TXMLNFSePadrao }

function TXMLNFSePadrao.fCampo(AstrNomeCampo: String): String;
Var
  LenuTipoCampo: TTipoCampo;
begin
  Result := '';
  LenuTipoCampo := fIdentificarCampo<TTipoCampo>(AstrNomeCampo);

  case FenuXMLNFSeLayoutTipo of
    ltNacional_V1:   Result := fLayoutNacional_V1(LenuTipoCampo);
    ltNacional_V1_1: Result := fLayoutNacional_V1_1(LenuTipoCampo); // Agora aponta para a função correta
    ltABRASF_V1:     Result := fLayoutABRASF_V1(LenuTipoCampo);
    ltABRASF_V2:     Result := fLayoutABRASF_V2(LenuTipoCampo);
    ltABRASF_V2_04:  Result := fLayoutABRASF_V2_04(LenuTipoCampo);
  end;
end;

function TXMLNFSePadrao.fDetectarLayout(ANode: IXMLNode): TXMLNFSeLayoutTipo;
var
  NS, Versao: string;
  LNodeInfNfse: IXMLNode;
  LVersaoInfNfse: String;
  Root: IXMLNode;
begin
  FenuXMLNFSeLayoutTipo := ltDesconhecido;

  if Assigned(ANode) then
  begin
    Root := ANode.OwnerDocument.DocumentElement;
    NS := LowerCase(Root.NamespaceURI);

    // Captura o atributo 'versao' da tag raiz
    if Root.HasAttribute('versao') then
      Versao := Root.Attributes['versao']
    else
      Versao := '1.00'; // Default caso não encontre

    // 1. Detecção do Padrão Nacional (Sefin)
    if ContainsText(NS, 'sped.fazenda.gov.br') then
    begin
      if (Versao = '1.01') or (Versao = '1.1') then
        FenuXMLNFSeLayoutTipo := ltNacional_V1_1
      else
        FenuXMLNFSeLayoutTipo := ltNacional_V1;
    end

    // 2. Detecção do Padrão ABRASF
    else if ContainsText(NS, 'abrasf.org.br') or Assigned(Root.ChildNodes.FindNode('ListaNfse')) then
    begin
      // Versão pode estar em <Nfse versao="X.YY"> (2.03/2.04) ou <InfNfse versao="...">
      LNodeInfNfse  := fBuscarNo(Root, 'Nfse');
      LVersaoInfNfse := '';
      if Assigned(LNodeInfNfse) and LNodeInfNfse.HasAttribute('versao') then
        LVersaoInfNfse := LNodeInfNfse.Attributes['versao'];

      if LVersaoInfNfse = '' then
      begin
        LNodeInfNfse := fBuscarNo(Root, 'InfNfse');
        if Assigned(LNodeInfNfse) and LNodeInfNfse.HasAttribute('versao') then
          LVersaoInfNfse := LNodeInfNfse.Attributes['versao'];
      end;

      // 2.03 e 2.04 possuem envelope DeclaracaoPrestacaoServico/InfDeclaracaoPrestacaoServico
      if (LVersaoInfNfse = '2.04') or
         (LVersaoInfNfse = '2.03') or
         Assigned(fBuscarNo(Root, 'InfDeclaracaoPrestacaoServico')) then
        FenuXMLNFSeLayoutTipo := ltABRASF_V2_04
      else if LVersaoInfNfse.StartsWith('2') or
              Assigned(fBuscarNo(Root, 'ValoresNfse')) then
        FenuXMLNFSeLayoutTipo := ltABRASF_V2
      else
        FenuXMLNFSeLayoutTipo := ltABRASF_V1;
    end
    else
      FenuXMLNFSeLayoutTipo := ltConfigurado;
  end;

  Result := FenuXMLNFSeLayoutTipo;
end;

function TXMLNFSePadrao.fIdentificarCampo<T>(const AValue: string): T;
var
  Index: Integer;
begin
  Index := GetEnumValue(TypeInfo(T), AValue.ToUpper);
  if Index <> -1 then
    Result := TValue.FromOrdinal(TypeInfo(T), Index).AsType<T>
  else
    Result := Default(T);
end;

function TXMLNFSePadrao.fLayoutNacional_V1_1(const ACampo: TTipoCampo): string;
begin
  case ACampo of
    // Dados de Identificação da Nota
    FIS_ACESSO: Result := 'infNFSe;Id';
    FIS_NUMDOC: Result := 'infNFSe;nNFSe';
    FIS_DTAENT: Result := 'infNFSe;dhProc';

    // Emitente (Prestador)
    FIS_FORCLI: Result := 'infNFSe;emit;CNPJ';
    FIS_FORFIS: Result := 'infNFSe;emit;CPF';

    // Tomador (Cliente)
    FIS_CGCDES: Result := 'infNFSe;DPS;infDPS;toma;CNPJ';

    // Serviço
    //FIS_SERIE_: Result := 'infNFSe;DPS;infDPS;serie';
    FIS_CDSERV: Result := 'infNFSe;DPS;infDPS;serv;cServ;cTribNac';
    FIS_HISTOR: Result := 'infNFSe;DPS;infDPS;serv;cServ;xDescServ';

    // Valores de ISS
    FIS_BASISS: Result := 'infNFSe;valores;vBC';
    FIS_ALQISS: Result := 'infNFSe;valores;pAliqAplic';
    FIS_VALISS: Result := 'infNFSe;valores;vISSQN';
    FIS_VLCON1: Result := 'infNFSe;valores;vLiq';

    // Retenções Federais
    FIS_REIRRF: Result := 'infNFSe;DPS;infDPS;valores;trib;tribFed;vRetIRRF';
    FIS_RECSLL: Result := 'infNFSe;DPS;infDPS;valores;trib;tribFed;vRetCSLL';
    FIS_REINSS: Result := 'infNFSe;DPS;infDPS;valores;trib;tribFed;vRetCP';

    // PIS e COFINS
    FIS_RETPIS: Result := 'infNFSe;DPS;infDPS;valores;trib;tribFed;piscofins;vPis';
    FIS_RETCOF: Result := 'infNFSe;DPS;infDPS;valores;trib;tribFed;piscofins;vCofins';
    FIS_ALQPIS: Result := 'infNFSe;DPS;infDPS;valores;trib;tribFed;piscofins;pAliqPis';
    FIS_ALQCOF: Result := 'infNFSe;DPS;infDPS;valores;trib;tribFed;piscofins;pAliqCofins';
    FIS_BASPIS: Result := 'infNFSe;DPS;infDPS;valores;trib;tribFed;piscofins;vBCPisCofins';
    FIS_BASCOF: Result := 'infNFSe;DPS;infDPS;valores;trib;tribFed;piscofins;vBCPisCofins';

    // Reforma Tributária — IBS/CBS (mesma hierarquia do V1)
    REF_CODCST: Result := 'infNFSe;DPS;infDPS;IBSCBS;valores;trib;gIBSCBS;CST';
    REF_CLATRI: Result := 'infNFSe;DPS;infDPS;IBSCBS;valores;trib;gIBSCBS;cClassTrib';
    REF_BASCAL: Result := 'infNFSe;IBSCBS;valores;vBC';
    REF_CBSALQ: Result := 'infNFSe;IBSCBS;valores;fed;pCBS';
    REF_CBSALE: Result := 'infNFSe;IBSCBS;valores;fed;pAliqEfetCBS';
    REF_CBSVAL: Result := 'infNFSe;IBSCBS;totCIBS;gCBS;vCBS';
    REF_IBSUFA: Result := 'infNFSe;IBSCBS;valores;uf;pIBSUF';
    REF_IBSUFE: Result := 'infNFSe;IBSCBS;valores;uf;pAliqEfetUF';
    REF_IBSUFV: Result := 'infNFSe;IBSCBS;totCIBS;gIBS;gIBSUFTot;vIBSUF';
    REF_IBSMNA: Result := 'infNFSe;IBSCBS;valores;mun;pIBSMun';
    REF_IBSMNE: Result := 'infNFSe;IBSCBS;valores;mun;pAliqEfetMun';
    REF_IBSMNV: Result := 'infNFSe;IBSCBS;totCIBS;gIBS;gIBSMunTot;vIBSMun';
    REF_VALIBS: Result := 'infNFSe;IBSCBS;totCIBS;gIBS;vIBSTot';
    REF_VALOPE: Result := 'infNFSe;valores;vLiq';
    FIS_TOTRET: Result := 'infNFSe;valores;vTotalRet';

    FIS_TRISSQ: Result := 'infNFSe;DPS;infDPS;valores;trib;tribMun;tpRetISSQN';
    FIS_TRPIS_: Result := 'infNFSe;DPS;infDPS;valores;trib;tribFed;piscofins;tpRetPis';
    FIS_TRCOFI: Result := 'infNFSe;DPS;infDPS;valores;trib;tribFed;piscofins;tpRetCofins';
    FIS_TRPICO: Result := 'infNFSe;DPS;infDPS;valores;trib;tribFed;piscofins;tpRetPisCofins';
    FIS_TRIRRF: Result := 'infNFSe;DPS;infDPS;valores;trib;tribFed;tpRetIRRF';
    FIS_TRCSLL: Result := 'infNFSe;DPS;infDPS;valores;trib;tribFed;tpRetCSLL';
    FIS_TRINSS: Result := 'infNFSe;DPS;infDPS;valores;trib;tribFed;tpRetCP';
    FIS_VLSERV: Result := 'infNFSe;DPS;infDPS;valores;vServPrest;vServ';

    FIS_NUMDPS: Result := 'infNFSe;DPS;infDPS;nDPS';
    FIS_SERDPS: Result := 'infNFSe;DPS;infDPS;serie';
  else
    Result := '';
  end;
end;

function TXMLNFSePadrao.fLayoutABRASF_V2(const ACampo: TTipoCampo): string;
begin
  case ACampo of
    FIS_FORCLI: Result := 'InfNfse;PrestadorServico;IdentificacaoPrestador;Cnpj';
    FIS_FORFIS: Result := 'InfNfse;PrestadorServico;IdentificacaoPrestador;Cpf';
    FIS_CGCDES: Result := 'InfNfse;TomadorServico;IdentificacaoTomador;Cnpj';
    FIS_SERIE_: Result := 'InfNfse;Serie';
    FIS_NUMDOC: Result := 'InfNfse;Numero';
    FIS_DTAENT: Result := 'InfNfse;DataEmissao';
    FIS_VLCON1: Result := 'InfNfse;ValoresNfse;ValorLiquidoNfse';
    FIS_VLSERV: Result := 'InfNfse;Servico;Valores;ValorServicos';
    FIS_HISTOR: Result := 'InfNfse;Servico;Discriminacao';
    FIS_CDSERV: Result := 'InfNfse;Servico;ItemListaServico';
    // Tags diretamente em ValoresNfse para V2
    FIS_BASISS: Result := 'InfNfse;ValoresNfse;BaseCalculo';
    FIS_ALQISS: Result := 'InfNfse;ValoresNfse;Aliquota';
    FIS_VALISS: Result := 'InfNfse;ValoresNfse;ValorIss';
    FIS_REIRRF: Result := 'InfNfse;ValoresNfse;ValorIr';
    FIS_RETPIS: Result := 'InfNfse;ValoresNfse;ValorPis';
    FIS_RETCOF: Result := 'InfNfse;ValoresNfse;ValorCofins';
    FIS_RECSLL: Result := 'InfNfse;ValoresNfse;ValorCsll';
    FIS_REINSS: Result := 'InfNfse;ValoresNfse;ValorInss';
    FIS_ALQPIS: Result := 'InfNfse;ValoresNfse;AliquotaPis';
    FIS_BASPIS: Result := 'InfNfse;ValoresNfse;BaseCalculo';
    FIS_ALQCOF: Result := 'InfNfse;ValoresNfse;AliquotaCofins';
    FIS_BASCOF: Result := 'InfNfse;ValoresNfse;BaseCalculo';
    else Result := '';
  end;
end;

function TXMLNFSePadrao.fLayoutNacional_V1(const ACampo: TTipoCampo): string;
begin
  case ACampo of
    // Dados Básicos
    FIS_FORCLI: Result := 'infNFSe;emit;CNPJ';
    FIS_FORFIS: Result := 'infNFSe;emit;CPF';
    FIS_CGCDES: Result := 'infNFSe;DPS;infDPS;toma;CNPJ';
    //FIS_SERIE_: Result := 'infNFSe;DPS;infDPS;serie';
    FIS_NUMDOC: Result := 'infNFSe;nNFSe';
    FIS_DTAENT: Result := 'infNFSe;dhProc';
    FIS_VLCON1: Result := 'infNFSe;valores;vLiq';
    FIS_HISTOR: Result := 'infNFSe;DPS;infDPS;serv;cServ;xDescServ';
    FIS_CDSERV: Result := 'infNFSe;DPS;infDPS;serv;cServ;cTribNac';
    FIS_ACESSO: Result := 'infNFSe;Id';

    // ISS e Retenções Federais (Corrigido PIS/COFINS)
    FIS_BASISS: Result := 'infNFSe;valores;vBC';
    FIS_ALQISS: Result := 'infNFSe;valores;pAliqAplic';
    FIS_VALISS: Result := 'infNFSe;valores;vISSQN';

    FIS_REIRRF: Result := 'infNFSe;DPS;infDPS;valores;trib;tribFed;vRetIRRF';
    FIS_RETPIS: Result := 'infNFSe;DPS;infDPS;valores;trib;tribFed;piscofins;vPis';
    FIS_RETCOF: Result := 'infNFSe;DPS;infDPS;valores;trib;tribFed;piscofins;vCofins';
    FIS_RECSLL: Result := 'infNFSe;DPS;infDPS;valores;trib;tribFed;vRetCSLL';
    FIS_REINSS: Result := 'infNFSe;DPS;infDPS;valores;trib;tribFed;vRetCP';
    FIS_ALQPIS: Result := 'infNFSe;DPS;infDPS;valores;trib;tribFed;piscofins;pAliqPis';
    FIS_BASPIS: Result := 'infNFSe;DPS;infDPS;valores;trib;tribFed;piscofins;vBCPisCofins';
    FIS_ALQCOF: Result := 'infNFSe;DPS;infDPS;valores;trib;tribFed;piscofins;pAliqCofins';
    FIS_BASCOF: Result := 'infNFSe;DPS;infDPS;valores;trib;tribFed;piscofins;vBCPisCofins';

    // Reforma Tributária (IBS/CBS) - Ajustado conforme hierarquia do Padrão Nacional
    REF_CODCST: Result := 'infNFSe;DPS;infDPS;IBSCBS;valores;trib;gIBSCBS;CST';
    REF_CLATRI: Result := 'infNFSe;DPS;infDPS;IBSCBS;valores;trib;gIBSCBS;cClassTrib';
    REF_BASCAL: Result := 'infNFSe;IBSCBS;valores;vBC';
    REF_CBSALQ: Result := 'infNFSe;IBSCBS;valores;fed;pCBS';
    REF_CBSALE: Result := 'infNFSe;IBSCBS;valores;fed;pAliqEfetCBS';
    REF_CBSVAL: Result := 'infNFSe;IBSCBS;totCIBS;gCBS;vCBS';
    REF_IBSUFA: Result := 'infNFSe;IBSCBS;valores;uf;pIBSUF';
    REF_IBSUFE: Result := 'infNFSe;IBSCBS;valores;uf;pAliqEfetUF';
    REF_IBSUFV: Result := 'infNFSe;IBSCBS;totCIBS;gIBS;gIBSUFTot;vIBSUF';
    REF_IBSMNA: Result := 'infNFSe;IBSCBS;valores;mun;pIBSMun';
    REF_IBSMNE: Result := 'infNFSe;IBSCBS;valores;mun;pAliqEfetMun';
    REF_IBSMNV: Result := 'infNFSe;IBSCBS;totCIBS;gIBS;gIBSMunTot;vIBSMun';
    REF_VALIBS: Result := 'infNFSe;IBSCBS;totCIBS;gIBS;vIBSTot';
    REF_VALOPE: Result := 'infNFSe;valores;vLiq';
    FIS_TOTRET: Result := 'infNFSe;valores;vTotalRet';

    FIS_TRISSQ: Result := 'infNFSe;DPS;infDPS;valores;trib;tribMun;tpRetISSQN';
    FIS_TRPIS_: Result := 'infNFSe;DPS;infDPS;valores;trib;tribFed;piscofins;tpRetPis';
    FIS_TRCOFI: Result := 'infNFSe;DPS;infDPS;valores;trib;tribFed;piscofins;tpRetCofins';
    FIS_TRPICO: Result := 'infNFSe;DPS;infDPS;valores;trib;tribFed;piscofins;tpRetPisCofins';
    FIS_TRIRRF: Result := 'infNFSe;DPS;infDPS;valores;trib;tribFed;tpRetIRRF';
    FIS_TRCSLL: Result := 'infNFSe;DPS;infDPS;valores;trib;tribFed;tpRetCSLL';
    FIS_TRINSS: Result := 'infNFSe;DPS;infDPS;valores;trib;tribFed;tpRetCP';
    FIS_VLSERV: Result := 'infNFSe;DPS;infDPS;valores;vServPrest;vServ';

    FIS_NUMDPS: Result := 'infNFSe;DPS;infDPS;nDPS';
    FIS_SERDPS: Result := 'infNFSe;DPS;infDPS;serie';
  else
    Result := '';
  end;
end;

function TXMLNFSePadrao.fXMLNFSeLayoutTipo(
  AXMLNFSeLayoutTipo: TXMLNFSeLayoutTipo): TXMLNFSePadrao;
begin
  Result := Self;
  FenuXMLNFSeLayoutTipo :=  AXMLNFSeLayoutTipo;
end;

function TXMLNFSePadrao.fBuscarNo(ANode: IXMLNode; const ANome: String): IXMLNode;
var
  i: Integer;
begin
  Result := nil;
  if not Assigned(ANode) then Exit;
  if ANode.NodeName = ANome then
    Exit(ANode);
  for i := 0 to ANode.ChildNodes.Count - 1 do
  begin
    Result := fBuscarNo(ANode.ChildNodes[i], ANome);
    if Assigned(Result) then Exit;
  end;
end;

function TXMLNFSePadrao.fLayoutABRASF_V1(const ACampo: TTipoCampo): string;
begin
  case ACampo of
    FIS_FORCLI: Result := 'InfNfse;PrestadorServico;IdentificacaoPrestador;Cnpj';
    FIS_FORFIS: Result := 'InfNfse;PrestadorServico;IdentificacaoPrestador;Cpf';
    FIS_CGCDES: Result := 'InfNfse;TomadorServico;IdentificacaoTomador;Cnpj';
    FIS_SERIE_: Result := 'InfNfse;Serie';
    FIS_NUMDOC: Result := 'InfNfse;Numero';
    FIS_DTAENT: Result := 'InfNfse;DataEmissao';
    FIS_VLCON1: Result := 'InfNfse;Servico;Valores;ValorLiquidoNfse';
    FIS_VLSERV: Result := 'InfNfse;Servico;Valores;ValorServicos';
    FIS_HISTOR: Result := 'InfNfse;Servico;Discriminacao';
    FIS_CDSERV: Result := 'InfNfse;Servico;ItemListaServico';
    // Tags em Valores para V1
    FIS_BASISS: Result := 'InfNfse;Servico;Valores;BaseCalculo';
    FIS_ALQISS: Result := 'InfNfse;Servico;Valores;Aliquota';
    FIS_VALISS: Result := 'InfNfse;Servico;Valores;ValorIss';
    FIS_REIRRF: Result := 'InfNfse;Servico;Valores;ValorIr';
    FIS_RETPIS: Result := 'InfNfse;Servico;Valores;ValorPis';
    FIS_RETCOF: Result := 'InfNfse;Servico;Valores;ValorCofins';
    FIS_RECSLL: Result := 'InfNfse;Servico;Valores;ValorCsll';
    FIS_REINSS: Result := 'InfNfse;Servico;Valores;ValorInss';
    FIS_ALQPIS: Result := 'InfNfse;Servico;Valores;AliquotaPis';
    FIS_BASPIS: Result := 'InfNfse;Servico;Valores;BaseCalculo';
    FIS_ALQCOF: Result := 'InfNfse;Servico;Valores;AliquotaCofins';
    FIS_BASCOF: Result := 'InfNfse;Servico;Valores;BaseCalculo';
    else Result := '';
  end;
end;

function TXMLNFSePadrao.fLayoutABRASF_V2_04(const ACampo: TTipoCampo): string;
const
  BASE_INFNFSE = 'ListaNfse;CompNfse;Nfse;InfNfse';
  BASE_INFDPS  = 'ListaNfse;CompNfse;Nfse;InfNfse;DeclaracaoPrestacaoServico;InfDeclaracaoPrestacaoServico';
  BASE_SERVVAL = 'ListaNfse;CompNfse;Nfse;InfNfse;DeclaracaoPrestacaoServico;InfDeclaracaoPrestacaoServico;Servico;Valores';
begin
  case ACampo of
    FIS_NUMDOC: Result := BASE_INFNFSE + ';Numero';
    FIS_DTAENT: Result := BASE_INFNFSE + ';DataEmissao';
    FIS_ACESSO: Result := BASE_INFNFSE + ';CodigoVerificacao';

    FIS_VLCON1: Result := BASE_INFNFSE + ';ValoresNfse;ValorLiquidoNfse';
    FIS_BASISS: Result := BASE_INFNFSE + ';ValoresNfse;BaseCalculo';
    FIS_ALQISS: Result := BASE_INFNFSE + ';ValoresNfse;Aliquota';
    FIS_VALISS: Result := BASE_INFNFSE + ';ValoresNfse;ValorIss';

    FIS_NUMDPS: Result := BASE_INFDPS + ';Rps;IdentificacaoRps;Numero';
    FIS_SERDPS: Result := BASE_INFDPS + ';Rps;IdentificacaoRps;Serie';
    FIS_SERIE_: Result := BASE_INFDPS + ';Rps;IdentificacaoRps;Serie';

    FIS_FORCLI: Result := BASE_INFDPS + ';Prestador;CpfCnpj;Cnpj';
    FIS_FORFIS: Result := BASE_INFDPS + ';Prestador;CpfCnpj;Cpf';

    FIS_CGCDES: Result := BASE_INFDPS + ';TomadorServico;IdentificacaoTomador;CpfCnpj;Cnpj';

    FIS_HISTOR: Result := BASE_INFDPS + ';Servico;Discriminacao';
    FIS_CDSERV: Result := BASE_INFDPS + ';Servico;ItemListaServico';

    FIS_VLSERV: Result := BASE_SERVVAL + ';ValorServicos';
    FIS_RETPIS: Result := BASE_SERVVAL + ';ValorPis';
    FIS_RETCOF: Result := BASE_SERVVAL + ';ValorCofins';
    FIS_REINSS: Result := BASE_SERVVAL + ';ValorInss';
    FIS_REIRRF: Result := BASE_SERVVAL + ';ValorIr';
    FIS_RECSLL: Result := BASE_SERVVAL + ';ValorCsll';

    FIS_BASPIS: Result := BASE_SERVVAL + ';ValorServicos';
    FIS_BASCOF: Result := BASE_SERVVAL + ';ValorServicos';
  else
    Result := '';
  end;
end;

end.
