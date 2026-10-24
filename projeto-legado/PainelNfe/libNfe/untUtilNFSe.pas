unit untUtilNFSe;

interface

uses Classes, SysUtils, StrUtils, untConstantesNFe, untConfigNFE, untINterfaces;

Type
  TNFSeXML = class
    private
      fonteDados: IFonteDados;

      dadosGerais: TDadosGerais;
      dadosEmitente: TDadosEmitente;
      TotalServico: TTotalServico;
      lstItens: TList;
      strDiscriminacaoServico : String;

      function fGetIbgeLocalServico: String;
      function fAjustaCNAE(const strCNAE: String): String;
      function fLimpaCaracteresInvalidos(strTexto: String): String;
      function fNumerico(fltValor: Double; intDecimais: Integer): String;
      function fRemoverCaracteresInvalidosXML(const AValue: String): String;
      function fData(const dta: TDateTime): String;
      function fDataHora(const dta: TDateTime): String;
      function fRetornarMensagem: String;
      procedure pAdicionarServicosXML(stlArquivo: TStringList);
      procedure pMontaLinhaDescricaoServicos(dadosItem: TDadosItem; var strDesSer: String);
    public
      procedure pGerarXML(ANumeroNSe, ANumeroRPS, ASerieRPS, AChaveAcesso: String);
      constructor Create(fonteDados: IFonteDados; lstItens: TList; TotalServico: TTotalServico);
    end;

function fGetNaturezaOperacao(objConfig: TConfiguracoesNFE; dadosGerais: TDadosGerais;
  dadosEmitente: TDadosEmitente): String;

function fGetRegimeEspecial(objConfig: TConfiguracoesNFE; dadosGerais: TDadosGerais;
  dadosEmitente: TDadosEmitente): String;

implementation

uses untUtil;

function fGetNaturezaOperacao(objConfig: TConfiguracoesNFE; dadosGerais: TDadosGerais;
  dadosEmitente: TDadosEmitente): String;
begin
  If (objConfigInterna.strNtOpNS = '1') Or
     (dadosGerais.strCodIbgeEntrega = dadosEmitente.strCodIbge) Then
  Begin
    Result := '1' // Tributação no Município
  End
  Else
    Result := '2'; // Tributação fora do Município

  //CS FERRAMENTAS
  If (objConfigInterna.strEmpNFSe = 'PREFEITURA DE SOROCABA') Then
    Result := 'A'; //"A" - SEM DEDUCAO

  If (objConfigInterna.strEmpNFSe = 'PREFEITURA DE CAMPO LARGO') Then
    Result := '0'; //"A" - SEM DEDUCAO

  If not fEmptyStr(dadosGerais.strNaturezaServico) Then
    Result := dadosGerais.strNaturezaServico; // Informado no cadastro do cliente
end;

function fGetRegimeEspecial(objConfig: TConfiguracoesNFE; dadosGerais: TDadosGerais;
  dadosEmitente: TDadosEmitente): String;
begin
  Result := objConfigInterna.strReEsTr;
  
  //CS FERRAMENTAS
  If (objConfigInterna.strEmpNFSe = 'PREFEITURA DE SOROCABA') Then
  Begin
    If fSimplesPaulista(dadosGerais, dadosEmitente) Then
      Result := 'H'
    Else
      Result := 'T'; //"T" - TRIBUTAVEL
  End;
end;

{ TNFSeXML }

constructor TNFSeXML.Create(fonteDados: IFonteDados; lstItens: TList; TotalServico: TTotalServico);
begin
  Self.fonteDados    := fonteDados;
  Self.dadosGerais   := fonteDados.fDadosGerais;
  Self.dadosEmitente := fonteDados.fDadosEmitente;
  Self.lstItens      := lstItens;
  Self.TotalServico  := TotalServico;
end;

function TNFSeXML.fGetIbgeLocalServico: String;
begin
  If fGetNaturezaOperacao(objConfig, dadosGerais, dadosEmitente) = '1' Then
    Result := dadosEmitente.strCodIbge
  Else
    Result := dadosGerais.strCodIbgeEntrega;

  //CS FERRAMENTAS
  If (objConfigInterna.strEmpNFSe = 'PREFEITURA DE SOROCABA') Then
    Result := dadosEmitente.strCodIbge;
end;

function TNFSeXML.fAjustaCNAE(const strCNAE: String): String;
begin
  Result := strCNAE;

  If (objConfigInterna.strEmpNFSe = 'PREFEITURA DE SERTAOZINHO') Then
  begin
    Result := '';
    Exit;
  end;

  If fEmptyStr(Result) then
    Result := dadosEmitente.strCNAEFiscal;
end;

function TNFSeXML.fLimpaCaracteresInvalidos(strTexto: String): String;
begin
  Result := strTexto;
  Result := AnsiReplaceStr(Result, '"', '');
  Result := AnsiReplaceStr(Result, '''', '');
  Result := AnsiReplaceStr(Result, '&', '');
end;

function TNFSeXML.fNumerico(fltValor: Double; intDecimais: Integer): String;
begin
  Result := FloatToStrF(fltValor, ffNumber, 12, intDecimais);
  Result := AnsiReplaceStr(Result, '.', '');
  Result := AnsiReplaceStr(Result, ',', '.');
end;

procedure TNFSeXML.pMontaLinhaDescricaoServicos(dadosItem: TDadosItem; var strDesSer: String);
begin
  If (Not fEmptyStr(strDesSer)) Then
    strDesSer := strDesSer + ' | ';

  If (objConfigInterna.strTpNfCr = J_A_MASSA_CONCRETO) Then
    strDesSer := strDesSer + dadosItem.strDesIte + ' R$ ' + FormatFloat('###,###,##0.00', dadosItem.fltUnitar)
  Else
    strDesSer := strDesSer + dadosItem.strDesIte;

end;

function TNFSeXML.fRemoverCaracteresInvalidosXML(const AValue: String): String;
begin
  Result := AValue;

  If (StartsStr('"', Result)) And (EndsStr('"', Result)) Then
  Begin
    Result := Copy(Result, 2, Length(Result));
    Result := Copy(Result, 1, Pred(Length(Result)));
  End;

  Result := AnsiReplaceStr(Result, '\', '');
end;

function TNFSeXML.fData(const dta: TDateTime): String;
begin
  Result := FormatDateTime('yyyy-mm-dd', dta);
end;

function TNFSeXML.fDataHora(const dta: TDateTime): String;
begin
  Result := FormatDateTime('yyyy-mm-dd"T"hh:nn:ss"Z"', dta);
end;

function TNFSeXML.fRetornarMensagem: String;
begin
  Result := '';

  If Not fEmptyStr(Self.dadosGerais.strMen001) then
    Result := Result + ' ' + Self.dadosGerais.strMen001;

  If Not fEmptyStr(Self.dadosGerais.strMen002) then
    Result := Result + ' ' + Self.dadosGerais.strMen002;

  If Not fEmptyStr(Self.dadosGerais.strMen003) then
    Result := Result + ' ' + Self.dadosGerais.strMen003;

  If Not fEmptyStr(Self.dadosGerais.strMen004) then
    Result := Result + ' ' + Self.dadosGerais.strMen004;

  If Not fEmptyStr(Self.dadosGerais.strMen005) then
    Result := Result + ' ' + Self.dadosGerais.strMen005;

end;

procedure TNFSeXML.pAdicionarServicosXML(stlArquivo: TStringList);
Var
  strDesSer,
  strCodSLC,
  strTriMun,
  strCNAE: String;
  intCont: Integer;
  dadosItem: TDadosItem;

begin
  If (Not Assigned(lstItens)) Then
    Exit;

  strDesSer := '';
  strCodSLC := '';
  strTriMun := '';
  strCNAE   := '';

  For intCont := 0 To lstItens.Count-1 Do
  Begin
    dadosItem := TDadosItem(lstItens[intCont]);

    If fEmptyStr(strCodSLC) Then strCodSLC := dadosItem.strCodSLC;
    If fEmptyStr(strTriMun) Then strTriMun := dadosItem.strTriMun;

    If (fEmptyStr(strCNAE)) And
       (Not fEmptyStr(dadosItem.strCnaeFiscal)) And
       (fCfgSisFonte(fonteDados, 'CNAESV') = 'S') Then
      strCNAE := dadosItem.strCnaeFiscal;

    If dadosGerais.strOpcDoc = 'CF' Then
    Begin
      If Pos(dadosItem.strDesIte, strDesSer) <=0 Then
      Begin
        pMontaLinhaDescricaoServicos(dadosItem, strDesSer);
      End;
    End
    Else
    Begin
      pMontaLinhaDescricaoServicos(dadosItem, strDesSer);
    End;
  End;

  If Not fEmptyStr(dadosGerais.strDisSer) Then
    strDiscriminacaoServico := AnsiReplaceStr(dadosGerais.strDisSer, '<<csq>>', ' ')
  Else
    strDiscriminacaoServico := '';

  strDiscriminacaoServico := fTiraCaracEspeciais(strDiscriminacaoServico, False);
  strDiscriminacaoServico := AnsiReplaceStr(AnsiReplaceStr(strDiscriminacaoServico, #13, ' | '), #10, '');

  strCNAE := fAjustaCNAE(strCNAE);

  stlArquivo.Add('                     <Servico> ');
  stlArquivo.Add('                        <Valores> ');
  stlArquivo.Add('                           <ValorServicos>'+fNumerico(dadosGerais.fltTotSer, 2)+'</ValorServicos> ');
  stlArquivo.Add('                           <ValorDeducoes>'+fNumerico(TotalServico.fltValDed, 2)+'</ValorDeducoes> ');
  stlArquivo.Add('                           <ValorPis>'+IIF(objConfigInterna.strEmpNFSe = 'PREFEITURA DE ARARAS', fNumerico(0, 2), fNumerico(dadosGerais.fltPisRet, 2))+'</ValorPis> ');
  stlArquivo.Add('                           <ValorCofins>'+IIF(objConfigInterna.strEmpNFSe = 'PREFEITURA DE ARARAS', fNumerico(0, 2), fNumerico(dadosGerais.fltCofRet, 2))+'</ValorCofins> ');
  stlArquivo.Add('                           <ValorInss>'+fNumerico(dadosGerais.fltVlSgSo, 2)+'</ValorInss> ');
  stlArquivo.Add('                           <ValorIr>'+fNumerico(dadosGerais.fltIrfRet, 2)+'</ValorIr> ');
  stlArquivo.Add('                           <ValorCsll>'+fNumerico(dadosGerais.fltCslRet, 2)+'</ValorCsll> ');
  stlArquivo.Add('                           <OutrasRetencoes>.00</OutrasRetencoes> ');
  stlArquivo.Add('                           <ValorIss>'+fNumerico(TotalServico.fltValIss, StrToIntDef(fCfgSisFonte(FonteDados, 'ENODEC'), 2))+'</ValorIss> ');
  stlArquivo.Add('                           <Aliquota>'+fNumerico(TotalServico.fltPerIss, StrToIntDef(fCfgSisFonte(FonteDados, 'ENODEC'), 2))+'</Aliquota> ');
  stlArquivo.Add('                           <DescontoIncondicionado>.00</DescontoIncondicionado> ');
  stlArquivo.Add('                           <DescontoCondicionado>.00</DescontoCondicionado> ');
  stlArquivo.Add('                        </Valores> ');
  stlArquivo.Add('                        <IssRetido>'+fNumerico(TotalServico.fltIssRet, 2)+'</IssRetido> ');
  stlArquivo.Add('                        <ItemListaServico>'+fLimpaCaracteresInvalidos(strCodSLC)+'</ItemListaServico> ');
  stlArquivo.Add('                        <Discriminacao>'+fLimpaCaracteresInvalidos(IIF(not fEmptyStr(strDiscriminacaoServico), strDiscriminacaoServico, strDesSer))+'</Discriminacao> ');
  stlArquivo.Add('                        <CodigoMunicipio>'+fLimpaCaracteresInvalidos(fGetIbgeLocalServico)+'</CodigoMunicipio> ');
  stlArquivo.Add('                        <CodigoPais /> ');
  stlArquivo.Add('                        <ExigibilidadeISS>1</ExigibilidadeISS> ');
  stlArquivo.Add('                        <MunicipioIncidencia>'+fLimpaCaracteresInvalidos(fGetIbgeLocalServico)+'</MunicipioIncidencia> ');
  stlArquivo.Add('                     </Servico> ');

end;

procedure TNFSeXML.pGerarXML(ANumeroNSe, ANumeroRPS, ASerieRPS, AChaveAcesso: String);
var
  stlArquivo: TStringList;
begin
  stlArquivo := TStringList.Create;

  Try
    stlArquivo.Add('<?xml version="1.0" encoding="UTF-8"?> ');
    stlArquivo.Add('<EnviarLoteRpsSincronoResposta> ');
    stlArquivo.Add('   <NumeroLote></NumeroLote> ');
    stlArquivo.Add('   <DataRecebimento></DataRecebimento> ');
    stlArquivo.Add('   <Protocolo></Protocolo> ');
    stlArquivo.Add('   <ListaNfse> ');
    stlArquivo.Add('      <CompNfse> ');
    stlArquivo.Add('         <Nfse> ');
    stlArquivo.Add('            <InfNfse> ');
    stlArquivo.Add('               <Numero>'+ANumeroNSe+'</Numero> ');
    stlArquivo.Add('               <CodigoVerificacao></CodigoVerificacao> ');
    stlArquivo.Add('               <DataEmissao>'+fDataHora(nOw())+'</DataEmissao> ');
    stlArquivo.Add('               <ValoresNfse> ');
    stlArquivo.Add('                  <BaseCalculo>'+fNumerico(dadosGerais.fltTotSer, 2)+'</BaseCalculo> ');
    stlArquivo.Add('                  <Aliquota>'+fNumerico(TotalServico.fltPerIss, StrToIntDef(fCfgSisFonte(Self.FonteDados, 'ENODEC'), 2))+'</Aliquota> ');
    stlArquivo.Add('                  <ValorIss>'+fNumerico(TotalServico.fltValIss, StrToIntDef(fCfgSisFonte(Self.FonteDados, 'ENODEC'), 2))+'</ValorIss> ');
    stlArquivo.Add('                  <ValorLiquidoNfse>'+fNumerico(dadosGerais.fltTotSer, 2)+'</ValorLiquidoNfse> ');
    stlArquivo.Add('               </ValoresNfse> ');
    stlArquivo.Add('               <PrestadorServico> ');
    stlArquivo.Add('                  <IdentificacaoPrestador> ');
    stlArquivo.Add('                     <CpfCnpj> ');
    stlArquivo.Add('                        <Cnpj>'+fLimpaCaracteresInvalidos(dadosEmitente.strCnpj)+'</Cnpj> ');
    stlArquivo.Add('                     </CpfCnpj> ');
    stlArquivo.Add('                     <InscricaoMunicipal>'+fLimpaCaracteresInvalidos(dadosEmitente.strInscricaoMunicipal)+'</InscricaoMunicipal> ');
    stlArquivo.Add('                  </IdentificacaoPrestador> ');
    stlArquivo.Add('                  <RazaoSocial>'+fLimpaCaracteresInvalidos(dadosEmitente.strRazao)+'</RazaoSocial> ');
    stlArquivo.Add('                  <NomeFantasia>'+fLimpaCaracteresInvalidos(dadosEmitente.strRazao)+'</NomeFantasia> ');
    stlArquivo.Add('                  <Endereco> ');
    stlArquivo.Add('                     <Endereco>'+fLimpaCaracteresInvalidos(dadosEmitente.strEndereco)+'</Endereco> ');
    stlArquivo.Add('                     <Numero>'+fLimpaCaracteresInvalidos(dadosEmitente.strNumeroEnd)+'</Numero> ');
    stlArquivo.Add('                     <Complemento>'+fLimpaCaracteresInvalidos(dadosEmitente.strComplementoEnd)+'</Complemento> ');
    stlArquivo.Add('                     <Bairro>'+fLimpaCaracteresInvalidos(dadosEmitente.strBairro)+'</Bairro> ');
    stlArquivo.Add('                     <CodigoMunicipio>'+fLimpaCaracteresInvalidos(dadosEmitente.strCodIbge)+'</CodigoMunicipio> ');
    stlArquivo.Add('                     <Uf>'+fLimpaCaracteresInvalidos(dadosEmitente.strEstado)+'</Uf> ');
    stlArquivo.Add('                     <CodigoPais /> ');
    stlArquivo.Add('                     <Cep>'+fLimpaCaracteresInvalidos(dadosEmitente.strCep)+'</Cep> ');
    stlArquivo.Add('                  </Endereco> ');
    stlArquivo.Add('                  <Contato> ');
    stlArquivo.Add('                     <Telefone>'+fLimpaCaracteresInvalidos(dadosEmitente.strTelefone)+'</Telefone> ');
    stlArquivo.Add('                     <Email>'+fLimpaCaracteresInvalidos(dadosEmitente.strEMail)+'</Email> ');
    stlArquivo.Add('                  </Contato> ');
    stlArquivo.Add('               </PrestadorServico> ');
    stlArquivo.Add('               <OrgaoGerador> ');
    stlArquivo.Add('                  <CodigoMunicipio>'+fLimpaCaracteresInvalidos(dadosEmitente.strCodIbge)+'</CodigoMunicipio> ');
    stlArquivo.Add('                  <Uf /> ');
    stlArquivo.Add('               </OrgaoGerador> ');
    stlArquivo.Add('               <DeclaracaoPrestacaoServico> ');
    stlArquivo.Add('                  <InfDeclaracaoPrestacaoServico> ');
    stlArquivo.Add('                     <Rps> ');
    stlArquivo.Add('                        <IdentificacaoRps> ');
    stlArquivo.Add('                           <Numero>'+IIF(fEmptyStr(dadosGerais.strNumeroRpsSubstituto), ANumeroRPS, dadosGerais.strNumeroRpsSubstituto)+'</Numero> ');
    stlArquivo.Add('                           <Serie>'+ASerieRPS+'</Serie> ');
    stlArquivo.Add('                           <Tipo>1</Tipo> ');
    stlArquivo.Add('                        </IdentificacaoRps> ');
    stlArquivo.Add('                        <DataEmissao>'+fDataHora(nOw())+'</DataEmissao> ');
    stlArquivo.Add('                        <Status>1</Status> ');
    stlArquivo.Add('                     </Rps> ');
    stlArquivo.Add('                     <Competencia>'+fData(nOw())+'</Competencia> ');

    pAdicionarServicosXML(stlArquivo);

    stlArquivo.Add('                     <Prestador> ');
    stlArquivo.Add('                        <CpfCnpj> ');

    If (Length(dadosEmitente.strCnpj) = 14) Then
      stlArquivo.Add('                           <Cnpj>'+fLimpaCaracteresInvalidos(dadosEmitente.strCnpj)+'</Cnpj> ')
    Else
      stlArquivo.Add('                           <Cpf>'+fLimpaCaracteresInvalidos(dadosEmitente.strCnpj)+'</Cpf> ');

    stlArquivo.Add('                        </CpfCnpj> ');
    stlArquivo.Add('                        <InscricaoMunicipal>'+fLimpaCaracteresInvalidos(dadosEmitente.strInscricaoMunicipal)+'</InscricaoMunicipal> ');
    stlArquivo.Add('                     </Prestador> ');
    stlArquivo.Add('                     <Tomador> ');
    stlArquivo.Add('                        <IdentificacaoTomador> ');
    stlArquivo.Add('                           <CpfCnpj> ');

    If (Length(dadosGerais.strCnpj) = 14) Then
      stlArquivo.Add('                           <Cnpj>'+fLimpaCaracteresInvalidos(dadosGerais.strCnpj)+'</Cnpj> ')
    Else
      stlArquivo.Add('                           <Cpf>'+fLimpaCaracteresInvalidos(dadosGerais.strCnpj)+'</Cpf> ');

    stlArquivo.Add('                           </CpfCnpj> ');
    stlArquivo.Add('                           <RazaoSocial>'+fLimpaCaracteresInvalidos(dadosGerais.strNomCli)+'</RazaoSocial> ');
    stlArquivo.Add('                           <Endereco> ');
    stlArquivo.Add('                              <Endereco>'+fLimpaCaracteresInvalidos(dadosGerais.strLogradouro)+'</Endereco> ');
    stlArquivo.Add('                              <Numero>'+fLimpaCaracteresInvalidos(dadosGerais.strNumeroEnd)+'</Numero> ');
    stlArquivo.Add('                              <Complemento>'+fLimpaCaracteresInvalidos(dadosGerais.strComplementoEnd)+'</Complemento> ');
    stlArquivo.Add('                              <Bairro>'+fLimpaCaracteresInvalidos(dadosGerais.strBairro)+'</Bairro> ');
    stlArquivo.Add('                              <CodigoMunicipio>'+dadosGerais.strCodIbge+'</CodigoMunicipio> ');
    stlArquivo.Add('                              <Uf>'+fLimpaCaracteresInvalidos(dadosGerais.strEstado)+'</Uf> ');
    stlArquivo.Add('                              <CodigoPais /> ');
    stlArquivo.Add('                              <Cep>'+dadosGerais.strCEP+'</Cep> ');
    stlArquivo.Add('                           </Endereco> ');
    stlArquivo.Add('                           <Contato> ');
    stlArquivo.Add('                              <Telefone>'+dadosGerais.strTelefone+'</Telefone> ');
    stlArquivo.Add('                              <Email>'+fApenasUmEmail(dadosGerais.strEmail)+'</Email> ');
    stlArquivo.Add('                           </Contato> ');
    stlArquivo.Add('                        </IdentificacaoTomador> ');
    stlArquivo.Add('                     </Tomador> ');
    stlArquivo.Add('                     <Intermediario> ');
    stlArquivo.Add('                        <IdentificacaoIntermediario> ');
    stlArquivo.Add('                           <InscricaoMunicipal /> ');
    stlArquivo.Add('                        </IdentificacaoIntermediario> ');
    stlArquivo.Add('                        <RazaoSocial /> ');
    stlArquivo.Add('                     </Intermediario> ');
    stlArquivo.Add('                     <ConstrucaoCivil> ');
    stlArquivo.Add('                        <CodigoObra>'+dadosGerais.strCodObr+'</CodigoObra> ');
    stlArquivo.Add('                        <Art>'+dadosGerais.strCodArt+'</Art> ');
    stlArquivo.Add('                     </ConstrucaoCivil> ');
    stlArquivo.Add('                     <RegimeEspecialTributacao></RegimeEspecialTributacao> ');
    stlArquivo.Add('                     <OptanteSimplesNacional></OptanteSimplesNacional> ');
    stlArquivo.Add('                     <IncentivoFiscal></IncentivoFiscal> ');
    stlArquivo.Add('                  </InfDeclaracaoPrestacaoServico> ');
    stlArquivo.Add('               </DeclaracaoPrestacaoServico> ');
    stlArquivo.Add('               <observacoes>'+fRetornarMensagem+'</observacoes> ');
    stlArquivo.Add('               <XmlOriginal><![CDATA[XML_ORIGINAL]]></XmlOriginal> ');
    stlArquivo.Add('            </InfNfse> ');
    stlArquivo.Add('         </Nfse> ');
    stlArquivo.Add('      </CompNfse> ');
    stlArquivo.Add('   </ListaNfse> ');
    stlArquivo.Add('</EnviarLoteRpsSincronoResposta> ');

    If (Not fEmptyStr(AChaveAcesso)) Then
      Self.fonteDados.pSalvarXMLNFeBD(AChaveAcesso, fRemoverCaracteresInvalidosXML(stlArquivo.text));

  Finally
    FreeAndNil(stlArquivo);
  End;

end;

end.
