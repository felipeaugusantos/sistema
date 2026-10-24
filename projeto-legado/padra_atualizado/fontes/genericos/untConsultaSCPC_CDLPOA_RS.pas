unit unTConsultaSCPC_CDLPOA_RS;

interface

uses
   Classes, XMLDoc, XMLIntf, System.SysUtils, System.Rtti, System.StrUtils,
   System.Generics.Collections, idHTTP, IdSSLOpenSSL, EditFocus, untConsultaSCPC,
   untQckConsultaSCPC, frxClass, UniClientDataSet, Data.DB, untConstantes,
   untFuncoesGenerica,Forms,Winapi.Windows,untGravando,HTTPSend,synautil,blcksock;


type
  TConsultaSCPC_CDLPOA_RS = class(TConsultaSCPC)
  private
    FHandleRequisicoes: THandle;
    FXmlRetorno: TXMLDocument;
    FAmbiente : String;

    FCodSCPC : String;
    FCodAssociado : String;
    FCodigoFilial : String;
    FSenha : String;

    FUrl: String;
    FLoginAutomatico: Boolean;
    FRetorno : String;
    FQtdChequeSemFundo : Integer;
    FQtdProtesto : Integer;
    FDefineRiscoPositivo: Boolean;
    FDocumento : String;
    FSucesso : Boolean;
    FConsulta : String; //endpoint;
    FTipoConsulta : String;
    FNome : String;

    FHTTPSend: THTTPSend;

    function fConsultaServico(strDocumento: String): Boolean;
    function DefineRiscoPositivo(ACnpj: String): Boolean;
    function DefineNegocioPositivo(ACnpj: String): Boolean;
    function DefineLimitePositivo(ACnpj: String): Boolean;

    function ConsultaFamiliaPositivo(ACpf: String): Boolean;
    function ConsultaRedePositivo(ACpf: String): Boolean;
    Procedure DefineAmbiente;
    procedure CriaPathArquivos;
    procedure ConverterXmlParaTexto(XMLNode: IXMLNode);
    function RetornaTextoFormatado(XMLNode: IXMLNode): String;
    function SepararPalavras(XMLNode: IXMLNode): String; Overload;
    function CorrigirOrtografia(AText: String): String;
    function Center(AText: String; ASize: Integer = 87): String;
    function fProcurarElemento(ElementoPai: IXMLNode; strNome: String): IXMLNode;
    function fVerificaSeRetornouErroXml( LDocumento : TXMLDocument; Var msgErro : String ): Boolean;
    function RetornaTextoErroTratado(AErro: String): String;
    function fVerificaSeRetornouExcecao( LDocumento : TXMLDocument; Var msgErro : String ): Boolean;
    function fWhileNode(ANode: IXmlNode; NomeNode :String): Boolean;

    procedure RealizarConsulta;
    procedure CriarComponentesRequisicao;
    function CorrigirOrtografia_Complementares(AText: String): String;
    function CorrigirOrtografia_Credito(AText: String): String;
    function CorrigirOrtografia_DadosConsulta(AText: String): String;
    function CorrigirOrtografia_DadoseLogradouros(AText: String): String;
    function CorrigirOrtografia_DadosPJ(AText: String): String;
    function CorrigirOrtografia_DadosScore(AText: String): String;
    function CorrigirOrtografia_DescricaoJuridica(AText: String): String;
    function CorrigirOrtografia_Pessoais(AText: String): String;
    function CorrigirOrtografia_Pontuacao(AText: String): String;
    function CorrigirOrtografia_Resumos(AText: String): String;
    function CorrigirOrtografia_TipoDocumento(AText: String): String;
  protected
    function fGetMsgErro: String; override;
    function fGetRelatorio: String; override;
    function fGetQtdProtestos: Integer; override;
    function fGetQtdCheques: Integer; override;
  public
    constructor Create(AOwner: TComponent); reintroduce;
    destructor Destroy; override;
    function fRealizarConsulta(strDocumento, strNomeEmpresa, strCidade, strUF: String; blnSCPCAutomatico: Boolean): Boolean; overload; override;
    function fRealizarConsulta(strDocumento, strNomeEmpresa, strCidade, strUF: String; blnSCPCAutomatico: Boolean; strConsulta: String; strTipoConsulta: String): Boolean; overload; override;
    procedure pSaveToFile(Const strFileName: String); override;
  end;

const
  Const_SOAP_ATTRIBUTTES = 'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"'+
                           ' xmlns:xsd="http://www.w3.org/2001/XMLSchema"'+
                           ' xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"';

implementation

uses untFuncoes, untFuncoesSimples;

{ TConsultaSCPC_CDLPOA_RS }


procedure TConsultaSCPC_CDLPOA_RS.CriarComponentesRequisicao;
begin
  FHTTPSend :=THTTPSend.Create;
  FHTTPSend.MimeType := 'text/xml; charset="utf-8"';
  FHTTPSend.UserAgent := 'Mozilla/5.0';
  FHTTPSend.Protocol  := '1.1';
  FHTTPSend.KeepAlive := True;

  FHTTPSend.Sock.SSL.SSLType:= LT_TLSv1_2;

  FHTTPSend.Sock.SetTimeout( 90000 );
  FHTTPSend.Sock.ConnectionTimeout   := 90000;
  FHTTPSend.Sock.InterPacketTimeout  := False;
  FHTTPSend.Sock.NonblockSendTimeout := 90000;
  FHTTPSend.Sock.SocksTimeout        := 90000;
  FHTTPSend.Sock.HTTPTunnelTimeout   := 90000;
  FHTTPSend.Sock.SocksType := TSocksType.ST_Socks4;
end;

function TConsultaSCPC_CDLPOA_RS.Center(AText: String;ASize: Integer = 87): String;
  Var
    LAux: Integer;
    LTextoCentralizado: String;
begin
  Result := AText;

  If (ASize > Length(AText)) then
  begin
    LAux := Trunc((ASize - Length(AText))/ 2);
    LTextoCentralizado := StringOfchar(' ',LAux) + AText + stringOfchar(' ',LAux);

    If (Length(LTextoCentralizado) < ASize) then
      LTextoCentralizado := LTextoCentralizado+' ';

    Result := LTextoCentralizado;
  end;

end;

procedure TConsultaSCPC_CDLPOA_RS.ConverterXmlParaTexto(XMLNode: IXMLNode);
 var
  NodeText : string;
  I : Integer;
begin

  If XMLNode.NodeType <> ntElement Then
     Exit;

  NodeText := RetornaTextoFormatado(XMLNode);

  If Not XMLNode.IsTextElement And XMLNode.HasChildNodes Then
  Begin
    if (XMLNode.NodeName <> 'soap:Envelope') And (XMLNode.NodeName <> 'soap:Body') And (XMLNode.NodeName <> 'ConsultaFamiliaPositivoResponse') And (XMLNode.NodeName <> 'ConsultaFamiliaPositivoResult') And
       (XMLNode.NodeName <> 'ConsultaDefineRiscoPositivoResponse') And (XMLNode.NodeName <> 'ConsultaDefineRiscoPositivoResult')
    And(XMLNode.NodeName <> 'ConsultaDefineLimitePositivoResponse') And (XMLNode.NodeName <> 'ConsultaDefineLimitePositivoResult')
    And(XMLNode.NodeName <> 'ConsultaDefineNegocioPositivoResponse') And (XMLNode.NodeName <> 'ConsultaDefineNegocioPositivoResult')
    Then
    Begin
      FRetorno := FRetorno + '---------------------------------------------------------------------------------------' + #13#10;
      FRetorno := FRetorno + Center(AnsiUpperCase(NodeText),87) + #13#10;
      FRetorno := FRetorno + '---------------------------------------------------------------------------------------' + #13#10;
    End;
  End
  Else
  Begin
    If (XMLNode.NodeName <> 'tamanhoRegistro') And (XMLNode.NodeName <> 'tipoRegistro') Then
        FRetorno := FRetorno + NodeText + #13#10;
  End;

  If XMLNode.HasChildNodes then
  Begin
    for I := 0 to XMLNode.ChildNodes.Count - 1 do
    Begin
      ConverterXmlParaTexto(XMLNode.ChildNodes[I]);
    End;
  End;

end;



function TConsultaSCPC_CDLPOA_RS.CorrigirOrtografia(AText: String): String;
begin
  Result := AText;

  Result := CorrigirOrtografia_DescricaoJuridica(AText);
  Result := CorrigirOrtografia_DadosPJ(Result);
  Result := CorrigirOrtografia_TipoDocumento(Result);
  Result := CorrigirOrtografia_DadosConsulta(Result);
  Result := CorrigirOrtografia_Credito(Result);
  Result := CorrigirOrtografia_Pontuacao(Result);
  Result := CorrigirOrtografia_DadoseLogradouros(Result);
  Result := CorrigirOrtografia_DadosScore(Result);
  Result := CorrigirOrtografia_Pessoais(Result);
  Result := CorrigirOrtografia_Complementares(Result);
  Result := CorrigirOrtografia_Resumos(Result);
End;

function TConsultaSCPC_CDLPOA_RS.CorrigirOrtografia_Resumos(
  AText: String): String;
Begin
  Result := AText;

  //resumos
       If AText.Equals('Resumo de acoes civeis') Then Result := 'Resumo de ações civeis'
  Else If AText.Equals('Relacao de acoes civeis') Then Result := 'Relação de ações civeis'
  Else If AText.Equals('Resumo ocorrencias de debitos') Then Result := 'Resumo de ocorrências de débitos';
End;

function TConsultaSCPC_CDLPOA_RS.CorrigirOrtografia_Complementares(
  AText: String): String;
Begin
  Result := AText;

  //complementares
       If AText.Equals('Informacoes complementares') Then Result := 'Informações complementares'
  Else If AText.Equals('Debitos') Then Result := 'Débitos'
  Else If AText.Equals('Participacoes do documento consultado') Then Result := 'Participacões do documento consultado'
  Else If AText.Equals('Relacao falencia recuperacao judicial') Then Result := 'Relação de falência de recuperação judicial'
  Else If AText.Equals('Identificacao') Then Result := 'Identificação'
  Else If AText.Equals('Documento') Then Result := 'Documento'
  Else If AText.Equals('Nome') Then Result := 'Nome'
  Else If AText.Equals('NomeMae') Then Result := 'Nome da Mãe'
  Else If AText.Equals('DataNascimento') Then Result := 'Data de nascimento';
End;

function TConsultaSCPC_CDLPOA_RS.CorrigirOrtografia_Pessoais(
  AText: String): String;
Begin
  Result := AText;

  // pessoais
       If AText.Equals('NumeroRG') Then Result := 'Número do RG'
  Else If AText.Equals('OrgaoEmissor') Then Result := 'Orgão emissor'
  Else If AText.Equals('UnidadeFedarativaRG') Then Result := 'Unidade federativa RG'
  Else If AText.Equals('DataEmissaoRG') Then Result := 'Data de Emissão RG'
  Else If AText.Equals('SexoConsultado') Then Result := 'Sexo Consultado'
  Else If AText.Equals('CidadeNascimento') Then Result := 'Cidade de nascimento'
  Else If AText.Equals('EstadoCivil') Then Result := 'Estado Civil'
  Else If AText.Equals('NumeroDependentes') Then Result := 'Número de dependentes'
  Else If AText.Equals('GrauInstrucao') Then Result := 'Grau de Instrução'
  Else If AText.Equals('SituacaoReceita') Then Result := 'Situação Receita';
End;

function TConsultaSCPC_CDLPOA_RS.CorrigirOrtografia_DadoseLogradouros(
  AText: String): String;
Begin
  Result := AText;

  // logrdouro
       If AText.Equals('DataAtualizacao') Then Result := 'Data de Atualizacao'
  Else If AText.Equals('RegiaoCpf') Then Result := 'Região do Cpf'
  Else If AText.Equals('TituloEleitor') Then Result := 'Título de eleitor'
  Else If AText.Equals('TipoLogradouro') Then Result := 'Tipo do logradouro'
  Else If AText.Equals('NomeLogradouro') Then Result := 'Nome do logradouro'
  Else If AText.Equals('NumeroLogradouro') Then Result := 'Número do logradouro'
  Else If AText.Equals('Complemento') Then Result := 'Complemento'
  Else If AText.Equals('UnidadeFederativa') Then Result := 'Unidade federativa'
  Else If AText.Equals('Texto2') Then Result := 'Texto 2'
  Else If AText.Equals('Score classificacao varios modelos') Then Result := 'Score classificação vários modelos';
End;

function TConsultaSCPC_CDLPOA_RS.CorrigirOrtografia_DadosScore(
  AText: String): String;
Begin
  Result := AText;

  // score
       If AText.Equals('TipoScore') Then Result := 'Tipo score'
  Else If AText.Equals('PlanoExecucao') Then Result := 'Plano de execução'
  Else If AText.Equals('ModeloPlano') Then Result := 'Modelo de plano'
  Else If AText.Equals('NomePlano') Then Result := 'Nome do plano'
  Else If AText.Equals('ModeloScore') Then Result := 'Modelo de score'
  Else If AText.Equals('NomeScore') Then Result := 'Nome do score'
  Else If AText.Equals('ClassificacaoNumerica') Then Result := 'Classificação númerica'
  Else If AText.Equals('ClassificacaoAlfabetica') Then Result := 'Classificação alfabética'
  Else If AText.Equals('CodigoNaturezaModelo') Then Result := 'Código natureza modelo'
  Else If AText.Equals('DescricaoNatureza') Then Result := 'Descrição natureza';
End;

function TConsultaSCPC_CDLPOA_RS.CorrigirOrtografia_Pontuacao(
  AText: String): String;
Begin
  Result := AText;

  // pontuacao
       If AText.Equals('Painel controle positivo') Then Result := 'Painel controle positivo'
  Else If AText.Equals('Indicadores positivos_comportamento_pagamento') Then Result := 'Indicadores positivos comportamento pagamento'
  Else If AText.Equals('Nota pontualidade') Then Result := 'Nota pontualidade'
  Else If AText.Equals('Operacoes parceladas') Then Result := 'Operações parceladas'
  Else If AText.Equals('Cartao credito') Then Result := 'Cartão crédito'
  Else If AText.Equals('Nota comportamento fatura em atraso') Then Result := 'Nota comportamento fatura em atraso'
  Else If AText.Equals('Nota comportamento adiantamento de pagamento') Then Result := 'Nota comportamento adiantamento de pagamento'
  Else If AText.Equals('Indicadores positivos comportamento consumo') Then Result := 'Indicadores positivos comportamento consumo'
  Else If AText.Equals('Pontuacao comprometimento') Then Result := 'Pontuação comprometimento'
  Else If AText.Equals('Item painel controle') Then Result := 'Item painel controle';
End;

function TConsultaSCPC_CDLPOA_RS.CorrigirOrtografia_Credito(
  AText: String): String;
Begin
  Result := AText;

  // credito
       If AText.Equals('Descricao') Then Result := 'Descrição'
  Else If AText.Equals('Cartao credito cheque especial e outros rotativos') Then Result := 'Cartão crédito cheque especial e outros rotativos'
  Else If AText.Equals('Nota comportamento contratos recentes') Then Result := 'Nota comportamento contratos recentes'
  Else If AText.Equals('Status consumidor') Then Result := 'Status consumidor'
  Else If AText.Equals('Mensagem_registro') Then Result := 'Mensagem registro'
  Else If AText.Equals('Telefone vinculado documento informado') Then Result := 'Telefone vinculado documento informado'
  Else If AText.Equals('endereco') Then Result := 'Endereço'
  Else If AText.Equals('Resumo consultas anteriores') Then Result := 'Resumo consultas anteriores'
  Else If AText.Equals('TipoDocumento') Then Result := 'Tipo documento'
  Else If AText.Equals('NumeroDocumento') Then Result := 'Número documento';
End;

function TConsultaSCPC_CDLPOA_RS.CorrigirOrtografia_DadosConsulta(
  AText: String): String;
Begin
  Result := AText;

  // dados consulta
       If AText.Equals('TotalDeConsultas') Then Result := 'Total de Consultas'
  Else If AText.Equals('PeriodoInicial') Then Result := 'Período Inicial'
  Else If AText.Equals('PeriodoFinal') Then Result := 'Período Final'
  Else If AText.Equals('TotalUltimoMes') Then Result := 'Total último mês'
  Else If AText.Equals('Periodo') Then Result := 'Período'
  Else If AText.Equals('TotalPenultimoMes') Then Result := 'Total penúltimo mês'
  Else If AText.Equals('PeriodoPenultimoMes') Then Result := 'Período penúltimo mês'
  Else If AText.Equals('TotalAntePenultimoMes') Then Result := 'Total antepenultimo mês'
  Else If AText.Equals('Relacao consultas anteriores credito segmento') Then Result := 'Relação consultas anteriores credito segmento';
End;

function TConsultaSCPC_CDLPOA_RS.CorrigirOrtografia_TipoDocumento(
  AText: String): String;
Begin
  Result := AText;

  // tipo documento
       If AText.Equals('TipoDocumento') Then Result := 'Tipo Documento'
  Else If AText.Equals('TipoOcorrencia') Then Result := 'Tipo Ocorrência'
  Else If AText.Equals('RamoAtividade') Then Result := 'Ramo Atividade'
  Else If AText.Equals('DescricaoRamo') Then Result := 'Descrição ramo'
  Else If AText.Equals('DescricaoGrupo') Then Result := 'Descrição grupo'
  Else If AText.Equals('DescricaoSegmento') Then Result := 'Descrição Segmento'
  Else If AText.Equals('Decisao') Then Result := 'Decisão'
  Else If AText.Equals('TipoDocumento') Then Result := 'Tipo documento'
  Else If AText.Equals('Score') Then Result := 'Score'
  Else If AText.Equals('Aprova') Then Result := 'Aprova';
End;

function TConsultaSCPC_CDLPOA_RS.CorrigirOrtografia_DadosPJ(
  AText: String): String;
Begin
  Result := AText;

  // dados PJ
       If AText.Equals('DefinePositivoRisco') Then Result := 'Define Risco Positivo'
  Else If AText.Equals('DefineLimitePositivo') Then Result := 'Define Limite Positivo'
  Else If AText.Equals('DefineNegocioPositivo') Then Result := 'Define Negocio Positivo'
  Else If AText.Equals('Razao social') Then Result := 'Razão social'
  Else If AText.Equals('Situacao cnpj') Then Result := 'Situação cnpj'
  Else If AText.Equals('Data situacao cnpj') Then Result := 'Data situação cnpj'
  Else If AText.Equals('Inscricao estadual') Then Result := 'Inscrição estadual'
  Else If AText.Equals('Uf inscricao estadual') Then Result := 'UF Inscrição estadual'
  Else If AText.Equals('Data fundacao') Then Result := 'Data fundação'
  Else If AText.Equals('Codigo natureza juridica') Then Result := 'Código natureza jurídica'
  Else If AText.Equals('Natureza juridica') Then Result := 'Natureza jurídica';
End;

function TConsultaSCPC_CDLPOA_RS.CorrigirOrtografia_DescricaoJuridica(
  AText: String): String;
Begin
  Result := AText;

  // descricoes juridica
       If AText.Equals('Classificacao numerica') Then Result := 'Classificação numérica'
  Else If AText.Equals('Classificacao alfabetica') Then Result := 'Classificação alfabética'
  Else If AText.Equals('Pendencias restricoes') Then Result := 'Pendências restrições'
  Else If AText.Equals('Demais informacoes') Then Result := 'Demais informações'
  Else If AText.Equals('Historico periodo') Then Result := 'Histórico período'
  Else If AText.Equals('Historico periodo pontuacao') Then Result := 'Histórico período pontuação'
  Else If AText.Equals('Pontuacao') Then Result := 'Pontuação'
  Else If AText.Equals('Pontuacao mensal') Then Result := 'Pontuação mensal'
  Else If AText.Equals('Lista credito') Then Result := 'Lista crédito'
  Else If AText.Equals('Credito') Then Result := 'Crédito';
end;

constructor TConsultaSCPC_CDLPOA_RS.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  CriaPathArquivos;

  FXmlRetorno   := TXMLDocument.Create(Self);

  FCodSCPC      := fCfgSis('CDLSPC'); // CODIGO SCPC
  FCodAssociado := fCfgSis('CDLASS'); // CODIGO DO ASSOCIADO
  FCodigoFilial := fCfgSis('CDLFIL'); // CODIGO FILIAL
  FSenha        := fCfgSis('CDLSEN'); // SENHA CDL

  FLoginAutomatico := False;
  FDocumento := '';
  FSucesso := False;
end;

function TConsultaSCPC_CDLPOA_RS.ConsultaFamiliaPositivo(ACpf: String): Boolean;
  Var
    strXML : String;
    sTipoConsulta,
    sTipoCredito : String;
    LFDataResp, LFDataReq: TMemoryStream;
    LResposta: String;
    strMsgErro : String;
begin
    Result := False;

    Try
      CriarComponentesRequisicao;

      sTipoConsulta := FTipoConsulta; //'CPC';
      sTipoCredito  := 'CD';

      strXML := '';
      strXML := strXML + '<?xml version="1.0" encoding="utf-8"?>';
      strXML := strXML + '<soap:Envelope ' + Const_SOAP_ATTRIBUTTES + '>';
      strXML := strXML + ' <soap:Body>';
      strXML := strXML + '   <ConsultaFamiliaPositivo xmlns="http://sis.spcrs.org.br/webservices/FamiliaPositivo/">';
      strXML := strXML + '     <codigoEntidade>'+FCodSCPC+'</codigoEntidade>';
      strXML := strXML + '     <codigoAssociado>'+FCodAssociado+'</codigoAssociado>';
      strXML := strXML + '     <codigoFilial>'+FCodigoFilial+'</codigoFilial>';
      strXML := strXML + '     <senhaAcesso>'+FSenha+'</senhaAcesso>';
      strXML := strXML + '     <documento>'+ACpf+'</documento>';
      strXML := strXML + '     <tipoCredito>'+sTipoCredito+'</tipoCredito>';
      strXML := strXML + '     <tipoConsulta>'+sTipoConsulta+'</tipoConsulta>';
      strXML := strXML + '     <tipoConsultaCheque></tipoConsultaCheque>';
      strXML := strXML + '     <banco></banco>';
      strXML := strXML + '     <agencia></agencia>';
      strXML := strXML + '     <contaCorrente></contaCorrente>';
      strXML := strXML + '     <digitoContaCorrente></digitoContaCorrente>';
      strXML := strXML + '     <numeroCheque></numeroCheque>';
      strXML := strXML + '     <digitoNumeroCheque></digitoNumeroCheque>';
      strXML := strXML + '     <totalCheques></totalCheques>';
      strXML := strXML + '     <dataCheque></dataCheque>';
      strXML := strXML + '     <valor></valor>';
      strXML := strXML + '     <cmc7Posicao1></cmc7Posicao1>';
      strXML := strXML + '     <cmc7Posicao2></cmc7Posicao2>';
      strXML := strXML + '     <cmc7Posicao3></cmc7Posicao3>';
      strXML := strXML + '   </ConsultaFamiliaPositivo>';
      strXML := strXML + ' </soap:Body>';
      strXML := strXML + '</soap:Envelope>';

      Try
        LFDataReq := TMemoryStream.Create;
        WriteStrToStream(LFDataReq, AnsiString(UTF8Encode(strXML)));
        FHTTPSend.Document.LoadFromStream(LFDataReq);
      Finally
        FreeAndNil(LFDataReq);
      End;

      If FHTTPSend.HTTPMethod('POST', FUrl) Then
      Begin
        LFDataResp := TMemoryStream.Create;
        LFDataResp.LoadFromStream(FHTTPSend.Document);

        LFDataResp.Position := 0;
        LResposta := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));
      End;

      If FHTTPSend.ResultCode = 200 Then
      Begin
         //FXmlRetorno.LoadFromFile('C:\Users\tiago.ferreira2\Documents\Autpas\Arquivos Bancos\POA\RETORNO_POA.xml');

         FXmlRetorno.LoadFromXML(LResposta);

         If fVerificaSeRetornouErroXml( FXmlRetorno, strMsgErro ) Then
            Raise Exception.Create('Status: ' + inttostr(FHTTPSend.ResultCode) + ' Erro: ' + strMsgErro)
         Else
            Result := True;
      End;

      If FHTTPSend.ResultCode <> 200 Then
      Begin
         FXmlRetorno.LoadFromXML(LResposta);
         Raise Exception.Create(LResposta);
      End;

    Except

      On E: Exception Do
      Begin

         If FHTTPSend.ResultCode = 200 Then
         Begin
            Raise Exception.Create('Ocorreu um erro ao realizar a consulta na API CDL POA(RS).' + #13 +
                                   'Ambiente:' + FAmbiente + '.' + #13 +
                                   E.Message);
         End
         Else
         If FHTTPSend.ResultCode = 400 Then
         Begin
            Raise Exception.Create('Ocorreu um erro ao realizar a consulta na API CDL POA(RS), a requisição está incorreta.' + #13 +
                                   'Ambiente:' + FAmbiente + '.');
                                   // + #13 + ' Erro:' + E.ErrorMessage);
         End
         Else
         If FHTTPSend.ResultCode = 401 Then
         Begin
            Raise Exception.Create('Ocorreu um erro ao realizar a consulta na API CDL POA(RS).' + #13 +
                                   'Verifique se as chaves de autenticação da conta estão corretas e se estão liberadas para utilização no ambiente de ' +
                                    FAmbiente + '.'); //+ ' Erro:' + E.Message
         End
         Else
         Begin
            Raise Exception.Create('Ocorreu um erro ao realizar a consulta na API CDL POA(RS).' + #13 +
                                   'Verifique se as chaves de autenticação da conta estão corretas e se estão liberadas para utilização no ambiente de ' +
                                    FAmbiente + '.' + #13 +
                                    'Mensagem Erro:' + IIF ( fVerificaSeRetornouExcecao(FXmlRetorno,strMsgErro), strMsgErro, E.Message ) ); //+ ' Erro:' + E.Message

         End;

         Application.ProcessMessages;

      End;

    End;

end;

function TConsultaSCPC_CDLPOA_RS.ConsultaRedePositivo(ACpf: String): Boolean;
  Var
    strXML : String;
    sTipoCredito : String;
    LFDataResp, LFDataReq: TMemoryStream;
    LResposta: String;
    strMsgErro : String;
begin
    Result := False;

    Try
      CriarComponentesRequisicao;

      sTipoCredito  := 'CD';

      strXML := '';
      strXML := strXML + '<?xml version="1.0" encoding="utf-8"?>';
      strXML := strXML + '<soap:Envelope ' + Const_SOAP_ATTRIBUTTES + '>';
      strXML := strXML + ' <soap:Body>';
      strXML := strXML + '   <ConsultaRedePositivo xmlns="http://sis.spcrs.org.br/webservices/FamiliaPositivo/">';
      strXML := strXML + '     <CodigoCDL>'+FCodSCPC+'</CodigoCDL>';
      strXML := strXML + '     <CodigoAssociado>'+FCodAssociado+'</CodigoAssociado>';
      strXML := strXML + '     <CodigoFilial>'+FCodigoFilial+'</CodigoFilial>';
      strXML := strXML + '     <Senha>'+FSenha+'</Senha>';
      strXML := strXML + '     <NomeUsuario>'+FNome+'</NomeUsuario>';
      strXML := strXML + '     <CPF>'+ACpf+'</CPF>';
      strXML := strXML + '     <TipoCredito>'+sTipoCredito+'</TipoCredito>';
      strXML := strXML + '     <DDD>0</DDD>';
      strXML := strXML + '     <Telefone>0</Telefone>';
      strXML := strXML + '     <CEPOrigem>0</CEPOrigem>';
      strXML := strXML + '     <OrigemInformacoes></OrigemInformacoes>';
      strXML := strXML + '     <TipoCheque>CS</TipoCheque>';
      strXML := strXML + '     <CMC71>0</CMC71> ';
      strXML := strXML + '     <CMC72>0</CMC72> ';
      strXML := strXML + '     <CMC73>0</CMC73> ';
      strXML := strXML + '     <banco>0</banco>';
      strXML := strXML + '     <agencia>0</agencia>';
      strXML := strXML + '     <contaCorrente>0</contaCorrente>';
      strXML := strXML + '     <digitoContaCorrente>0</digitoContaCorrente>';
      strXML := strXML + '     <Cheque>0</Cheque>';
      strXML := strXML + '     <digitoCheque>0</digitoCheque>';
      strXML := strXML + '     <dataCheque>0</dataCheque>';
      strXML := strXML + '     <Quantidade>0</Quantidade>';
      strXML := strXML + '     <ValorCheque>0</ValorCheque>';
      strXML := strXML + '   </ConsultaRedePositivo>';
      strXML := strXML + ' </soap:Body>';
      strXML := strXML + '</soap:Envelope>';

      Try
        LFDataReq := TMemoryStream.Create;
        WriteStrToStream(LFDataReq, AnsiString(UTF8Encode(strXML)));
        FHTTPSend.Document.LoadFromStream(LFDataReq);
      Finally
        FreeAndNil(LFDataReq);
      End;

      If FHTTPSend.HTTPMethod('POST', FUrl) Then
      Begin
        LFDataResp := TMemoryStream.Create;
        LFDataResp.LoadFromStream(FHTTPSend.Document);

        LFDataResp.Position := 0;
        LResposta := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));
      End;

      If FHTTPSend.ResultCode = 200 Then
      Begin
         //FXmlRetorno.LoadFromFile('C:\Users\tiago.ferreira2\Documents\Autpas\Arquivos Bancos\POA\RETORNO_POA.xml');

         FXmlRetorno.LoadFromXML(LResposta);

         If fVerificaSeRetornouErroXml( FXmlRetorno, strMsgErro ) Then
            Raise Exception.Create('Status: ' + inttostr(FHTTPSend.ResultCode) + ' Erro: ' + strMsgErro)
         Else
            Result := True;
      End;

      If FHTTPSend.ResultCode <> 200 Then
      Begin
         FXmlRetorno.LoadFromXML(LResposta);
         Raise Exception.Create(LResposta);
      End;

    Except

      On E: Exception Do
      Begin

         If FHTTPSend.ResultCode = 200 Then
         Begin
            Raise Exception.Create('Ocorreu um erro ao realizar a consulta na API CDL POA(RS).' + #13 +
                                   'Ambiente:' + FAmbiente + '.' + #13 +
                                   E.Message);
         End
         Else
         If FHTTPSend.ResultCode = 400 Then
         Begin
            Raise Exception.Create('Ocorreu um erro ao realizar a consulta na API CDL POA(RS), a requisição está incorreta.' + #13 +
                                   'Ambiente:' + FAmbiente + '.');
                                   // + #13 + ' Erro:' + E.ErrorMessage);
         End
         Else
         If FHTTPSend.ResultCode = 401 Then
         Begin
            Raise Exception.Create('Ocorreu um erro ao realizar a consulta na API CDL POA(RS).' + #13 +
                                   'Verifique se as chaves de autenticação da conta estão corretas e se estão liberadas para utilização no ambiente de ' +
                                    FAmbiente + '.'); //+ ' Erro:' + E.Message
         End
         Else
         Begin
            Raise Exception.Create('Ocorreu um erro ao realizar a consulta na API CDL POA(RS).' + #13 +
                                   'Verifique se as chaves de autenticação da conta estão corretas e se estão liberadas para utilização no ambiente de ' +
                                    FAmbiente + '.' + #13 +
                                    'Mensagem Erro:' + IIF ( fVerificaSeRetornouExcecao(FXmlRetorno,strMsgErro), strMsgErro, E.Message ) ); //+ ' Erro:' + E.Message

         End;

         Application.ProcessMessages;

      End;

    End;

end;

procedure TConsultaSCPC_CDLPOA_RS.CriaPathArquivos;
  Var
    LPastaSaveXml: String;
begin
  LPastaSaveXml := ExtractFilePath(Application.ExeName)+ 'CDL POA RS SCPC\';
  If Not DirectoryExists(LPastaSaveXml) Then
    CreateDir(ExtractFilePath(LPastaSaveXml));
end;

procedure TConsultaSCPC_CDLPOA_RS.DefineAmbiente;
begin

  If FDefineRiscoPositivo Then
  Begin
    FAmbiente := 'Produção';
    FUrl := 'https://sis.spcrs.org.br/webservices/DefinePositivo/Consulta.asmx';

    If fCfgSis('CDLHOM',varBoolean) Then
    Begin
      FAmbiente := 'Homologação';

      FUrl := 'https://homologacao.scpcrs.org.br/webservices/definepositivo/consulta.asmx';
    End;

  End
  Else
  Begin

    FAmbiente := 'Produção';
    FUrl := 'https://sis.spcrs.org.br/webservices/FamiliaPositivo/Consulta.asmx';

    If fCfgSis('CDLHOM',varBoolean) Then
    Begin
      FAmbiente := 'Homologação';

      FUrl := 'https://homologacao.scpcrs.org.br/webservices/FamiliaPositivo/Consulta.asmx';
    End;

  End;

end;

function TConsultaSCPC_CDLPOA_RS.DefineRiscoPositivo(ACnpj: String): Boolean;
  Var
    strXML : String;
    LFDataResp, LFDataReq: TMemoryStream;
    LResposta: String;
    strMsgErro : String;
begin
  Result := False;

  Try
    CriarComponentesRequisicao;

    strXML := '';
    strXML := strXML + '<?xml version="1.0" encoding="utf-8"?>';
    strXML := strXML + '<soap:Envelope ' + Const_SOAP_ATTRIBUTTES + '>';
    strXML := strXML + ' <soap:Body>';
    strXML := strXML + '   <ConsultaDefineRiscoPositivo xmlns="http://tempuri.org/">';
    strXML := strXML + '     <codigoCDL>'+FCodSCPC+'</codigoCDL>';
    strXML := strXML + '     <codigoAssociado>'+FCodAssociado+'</codigoAssociado>';
    strXML := strXML + '     <codigoFilial>'+FCodigoFilial+'</codigoFilial>';
    strXML := strXML + '     <senha>'+FSenha+'</senha>';
    strXML := strXML + '     <CNPJ>'+ACnpj+'</CNPJ>';
    strXML := strXML + '     <quadroSocial>false</quadroSocial>';
    strXML := strXML + '     <participacoes>false</participacoes>';
    strXML := strXML + '     <quadroSocialRestricao>false</quadroSocialRestricao>';
    strXML := strXML + '     <participacoesRestricao>false</participacoesRestricao>';
    strXML := strXML + '     <decisao>false</decisao>';
    strXML := strXML + '     <faturamentoPresumido>false</faturamentoPresumido>';
    strXML := strXML + '     <limiteCredito>false</limiteCredito>';
    strXML := strXML + '     <anvisa>false</anvisa>';
    strXML := strXML + '     <empresasMesmoEndereco>false</empresasMesmoEndereco>';
    strXML := strXML + '     <folhaChequeInferior>false</folhaChequeInferior>';
    strXML := strXML + '     <folhaChequeSuperior>false</folhaChequeSuperior>';
    strXML := strXML + '     <banco></banco>';
    strXML := strXML + '     <agencia></agencia>';
    strXML := strXML + '     <contaCorrente></contaCorrente>';
    strXML := strXML + '     <digitoContaCorrente></digitoContaCorrente>';
    strXML := strXML + '     <numeroCheque></numeroCheque>';
    strXML := strXML + '     <digitoCheque></digitoCheque>';
    strXML := strXML + '     <quantidadeCheques></quantidadeCheques>';
    strXML := strXML + '     <valorCheque></valorCheque>';
    strXML := strXML + '     <dataCheque></dataCheque>';
    strXML := strXML + '     <CMC7Campo1></CMC7Campo1>';
    strXML := strXML + '     <CMC7Campo2></CMC7Campo2>';
    strXML := strXML + '     <CMC7Campo3></CMC7Campo3>';
    strXML := strXML + '   </ConsultaDefineRiscoPositivo>';
    strXML := strXML + ' </soap:Body>';
    strXML := strXML + '</soap:Envelope>';

    Try
      LFDataReq := TMemoryStream.Create;
      WriteStrToStream(LFDataReq, AnsiString(UTF8Encode(strXML)));
      FHTTPSend.Document.LoadFromStream(LFDataReq);
    Finally
      FreeAndNil(LFDataReq);
    End;

    If FHTTPSend.HTTPMethod('POST', FUrl) Then
    Begin
      LFDataResp := TMemoryStream.Create;
      LFDataResp.LoadFromStream(FHTTPSend.Document);

      LFDataResp.Position := 0;
      LResposta := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));
    End;

    If FHTTPSend.ResultCode = 200 Then
    Begin
       //FXmlRetorno.LoadFromFile('C:\Users\tiago.ferreira2\Documents\Autpas\Arquivos Bancos\POA\PJ_RETORNO.xml');

       FXmlRetorno.LoadFromXML(LResposta);

       If fVerificaSeRetornouErroXml( FXmlRetorno, strMsgErro ) Then
          Raise Exception.Create('Status: ' + inttostr(FHTTPSend.ResultCode) + ' Erro: ' + strMsgErro)
       Else
          Result := True;
    End;

    If FHTTPSend.ResultCode <> 200 Then
    Begin
       FXmlRetorno.LoadFromXML(LResposta);
       Raise Exception.Create(LResposta);
    End;

  Except

    On E: Exception Do
    Begin

       If FHTTPSend.ResultCode = 200 Then
       Begin
          Raise Exception.Create('Ocorreu um erro ao realizar a consulta na API CDL POA(RS).' + #13 +
                                 'Ambiente:' + FAmbiente + '.' + #13 +
                                 E.Message);
       End
       Else
       If FHTTPSend.ResultCode = 400 Then
       Begin
          Raise Exception.Create('Ocorreu um erro ao realizar a consulta na API CDL POA(RS), a requisição está incorreta.' + #13 +
                                 'Ambiente:' + FAmbiente + '.' + #13 +
                                 ' Erro:' + E.Message);
       End
       Else
       If FHTTPSend.ResultCode = 401 Then
       Begin
          Raise Exception.Create('Ocorreu um erro ao realizar a consulta na API CDL POA(RS).' + #13 +
                                 'Verifique se as chaves de autenticação da conta estão corretas e se estão liberadas para utilização no ambiente de ' +
                                  FAmbiente + '.'); //+ ' Erro:' + E.Message
       End
       Else
       Begin
          Raise Exception.Create('Ocorreu um erro ao realizar a consulta na API CDL POA(RS).' + #13 +
                                 'Verifique se as chaves de autenticação da conta estão corretas e se estão liberadas para utilização no ambiente de ' +
                                  FAmbiente + '.' + #13 +
                                  'Mensagem Erro:' + IIF ( fVerificaSeRetornouExcecao(FXmlRetorno,strMsgErro), strMsgErro, E.Message ) ); //+ ' Erro:' + E.Message

       End;

       Application.ProcessMessages;

    End;

  End;

end;

function TConsultaSCPC_CDLPOA_RS.DefineNegocioPositivo(ACnpj: String): Boolean;
  Var
    strXML : String;
    LFDataResp, LFDataReq: TMemoryStream;
    LResposta: String;
    strMsgErro : String;
begin
  Result := False;

  Try
    CriarComponentesRequisicao;

    strXML := '';                                      //
    strXML := strXML + '<?xml version="1.0" encoding="UTF-8"?>';
    strXML := strXML + '<soap:Envelope ' + Const_SOAP_ATTRIBUTTES + '>';
    strXML := strXML + ' <soap:Body>';
    strXML := strXML + '   <ConsultaDefineNegocioPositivo xmlns="http://tempuri.org/">';
    strXML := strXML + '    <codigoCDL>'+FCodSCPC+'</codigoCDL>';
    strXML := strXML + '    <codigoAssociado>'+FCodAssociado+'</codigoAssociado>';
    strXML := strXML + '    <codigoFilial>'+FCodigoFilial+'</codigoFilial>';
    strXML := strXML + '    <senha>'+FSenha+'</senha>';
    strXML := strXML + '    <CNPJ>'+ACnpj+'</CNPJ>';
    strXML := strXML + '    <quadroSocialRestricao>false</quadroSocialRestricao>';
    strXML := strXML + '    <participacoesRestricao>false</participacoesRestricao>';
    strXML := strXML + '    <faturamentoPresumido>false</faturamentoPresumido>';
    strXML := strXML + '    <limiteCredito>false</limiteCredito>';
    strXML := strXML + '    <anvisa>false</anvisa>';
    strXML := strXML + '    <empresasMesmoEndereco>false</empresasMesmoEndereco>';
    strXML := strXML + '    <folhaChequeInferior>false</folhaChequeInferior>';
    strXML := strXML + '    <folhaChequeSuperior>false</folhaChequeSuperior>';
    strXML := strXML + '    <banco></banco>';
    strXML := strXML + '    <agencia></agencia>';
    strXML := strXML + '    <contaCorrente></contaCorrente>';
    strXML := strXML + '    <digitoContaCorrente></digitoContaCorrente>';
    strXML := strXML + '    <numeroCheque></numeroCheque>';
    strXML := strXML + '    <digitoCheque></digitoCheque>';
    strXML := strXML + '    <quantidadeCheques></quantidadeCheques>';
    strXML := strXML + '    <valorCheque></valorCheque>';
    strXML := strXML + '    <dataCheque></dataCheque>';
    strXML := strXML + '    <CMC7Campo1></CMC7Campo1>';
    strXML := strXML + '    <CMC7Campo2></CMC7Campo2>';
    strXML := strXML + '    <CMC7Campo3></CMC7Campo3>';
    strXML := strXML + '   </ConsultaDefineNegocioPositivo>';
    strXML := strXML + ' </soap:Body>';
    strXML := strXML + '</soap:Envelope>';

    Try
      LFDataReq := TMemoryStream.Create;
      WriteStrToStream(LFDataReq, AnsiString(UTF8Encode(strXML)));
      FHTTPSend.Document.LoadFromStream(LFDataReq);
    Finally
      FreeAndNil(LFDataReq);
    End;

    If FHTTPSend.HTTPMethod('POST', FUrl) Then
    Begin
      LFDataResp := TMemoryStream.Create;
      LFDataResp.LoadFromStream(FHTTPSend.Document);

      LFDataResp.Position := 0;
      LResposta := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));
    End;

    If FHTTPSend.ResultCode = 200 Then
    Begin
       //FXmlRetorno.LoadFromFile('C:\Users\tiago.ferreira2\Documents\Autpas\Arquivos Bancos\POA\PJ_RETORNO.xml');

       FXmlRetorno.LoadFromXML(LResposta);

       If fVerificaSeRetornouErroXml( FXmlRetorno, strMsgErro ) Then
          Raise Exception.Create('Status: ' + inttostr(FHTTPSend.ResultCode) + ' Erro: ' + strMsgErro)
       Else
          Result := True;
    End;

    If FHTTPSend.ResultCode <> 200 Then
    Begin
       FXmlRetorno.LoadFromXML(LResposta);
       Raise Exception.Create(LResposta);
    End;

  Except

    On E: Exception Do
    Begin

       If FHTTPSend.ResultCode = 200 Then
       Begin
          Raise Exception.Create('Ocorreu um erro ao realizar a consulta na API CDL POA(RS).' + #13 +
                                 'Ambiente:' + FAmbiente + '.' + #13 +
                                 E.Message);
       End
       Else
       If FHTTPSend.ResultCode = 400 Then
       Begin
          Raise Exception.Create('Ocorreu um erro ao realizar a consulta na API CDL POA(RS), a requisição está incorreta.' + #13 +
                                 'Ambiente:' + FAmbiente + '.' + #13 +
                                 ' Erro:' + E.Message);
       End
       Else
       If FHTTPSend.ResultCode = 401 Then
       Begin
          Raise Exception.Create('Ocorreu um erro ao realizar a consulta na API CDL POA(RS).' + #13 +
                                 'Verifique se as chaves de autenticação da conta estão corretas e se estão liberadas para utilização no ambiente de ' +
                                  FAmbiente + '.'); //+ ' Erro:' + E.Message
       End
       Else
       Begin
          Raise Exception.Create('Ocorreu um erro ao realizar a consulta na API CDL POA(RS).' + #13 +
                                 'Verifique se as chaves de autenticação da conta estão corretas e se estão liberadas para utilização no ambiente de ' +
                                  FAmbiente + '.' + #13 +
                                  'Mensagem Erro:' + IIF ( fVerificaSeRetornouExcecao(FXmlRetorno,strMsgErro), strMsgErro, E.Message ) ); //+ ' Erro:' + E.Message

       End;

       Application.ProcessMessages;

    End;

  End;

end;

function TConsultaSCPC_CDLPOA_RS.DefineLimitePositivo(ACnpj: String): Boolean;
  Var
    strXML : String;
    LFDataResp, LFDataReq: TMemoryStream;
    LResposta: String;
    strMsgErro : String;
begin
  Result := False;

  Try
    CriarComponentesRequisicao;

    strXML := '';
    strXML := strXML + '<?xml version="1.0" encoding="UTF-8"?>';
    strXML := strXML + '<soap:Envelope ' + Const_SOAP_ATTRIBUTTES + '>';
    strXML := strXML + ' <soap:Body>';
    strXML := strXML + '   <ConsultaDefineLimitePositivo xmlns="http://tempuri.org/">';
    strXML := strXML + '     <codigoCDL>'+FCodSCPC+'</codigoCDL>';
    strXML := strXML + '     <codigoAssociado>'+FCodAssociado+'</codigoAssociado>';
    strXML := strXML + '     <codigoFilial>'+FCodigoFilial+'</codigoFilial>';
    strXML := strXML + '     <senha>'+FSenha+'</senha>';
    strXML := strXML + '     <CNPJ>'+ACnpj+'</CNPJ>';
    strXML := strXML + '     <anvisa>false</anvisa>';
    strXML := strXML + '     <empresasMesmoEndereco>false</empresasMesmoEndereco>';
    strXML := strXML + '     <folhaChequeInferior>false</folhaChequeInferior>';
    strXML := strXML + '     <folhaChequeSuperior>false</folhaChequeSuperior>';
    strXML := strXML + '     <banco>0</banco>';
    strXML := strXML + '     <agencia>0</agencia>';
    strXML := strXML + '     <contaCorrente>0</contaCorrente>';
    strXML := strXML + '     <digitoContaCorrente>0</digitoContaCorrente>';
    strXML := strXML + '     <numeroCheque>0</numeroCheque>';
    strXML := strXML + '     <digitoCheque>0</digitoCheque>';
    strXML := strXML + '     <quantidadeCheques>0</quantidadeCheques>';
    strXML := strXML + '     <valorCheque>0</valorCheque>';
    strXML := strXML + '     <dataCheque></dataCheque>';
    strXML := strXML + '     <CMC7Campo1>0</CMC7Campo1>';
    strXML := strXML + '     <CMC7Campo2>0</CMC7Campo2>';
    strXML := strXML + '     <CMC7Campo3>0</CMC7Campo3>';
    strXML := strXML + '   </ConsultaDefineLimitePositivo>';
    strXML := strXML + ' </soap:Body>';
    strXML := strXML + '</soap:Envelope>';

    Try
      LFDataReq := TMemoryStream.Create;
      WriteStrToStream(LFDataReq, AnsiString(UTF8Encode(strXML)));
      FHTTPSend.Document.LoadFromStream(LFDataReq);
    Finally
      FreeAndNil(LFDataReq);
    End;

    If FHTTPSend.HTTPMethod('POST', FUrl) Then
    Begin
      LFDataResp := TMemoryStream.Create;
      LFDataResp.LoadFromStream(FHTTPSend.Document);

      LFDataResp.Position := 0;
      LResposta := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));
    End;

    If FHTTPSend.ResultCode = 200 Then
    Begin
       //FXmlRetorno.LoadFromFile('C:\Users\tiago.ferreira2\Documents\Autpas\Arquivos Bancos\POA\PJ_RETORNO.xml');

       FXmlRetorno.LoadFromXML(LResposta);

       If fVerificaSeRetornouErroXml( FXmlRetorno, strMsgErro ) Then
          Raise Exception.Create('Status: ' + inttostr(FHTTPSend.ResultCode) + ' Erro: ' + strMsgErro)
       Else
          Result := True;
    End;

    If FHTTPSend.ResultCode <> 200 Then
    Begin
       FXmlRetorno.LoadFromXML(LResposta);
       Raise Exception.Create(LResposta);
    End;

  Except

    On E: Exception Do
    Begin

       If FHTTPSend.ResultCode = 200 Then
       Begin
          Raise Exception.Create('Ocorreu um erro ao realizar a consulta na API CDL POA(RS).' + #13 +
                                 'Ambiente:' + FAmbiente + '.' + #13 +
                                 E.Message);
       End
       Else
       If FHTTPSend.ResultCode = 400 Then
       Begin
          Raise Exception.Create('Ocorreu um erro ao realizar a consulta na API CDL POA(RS), a requisição está incorreta.' + #13 +
                                 'Ambiente:' + FAmbiente + '.' + #13 +
                                 ' Erro:' + E.Message);
       End
       Else
       If FHTTPSend.ResultCode = 401 Then
       Begin
          Raise Exception.Create('Ocorreu um erro ao realizar a consulta na API CDL POA(RS).' + #13 +
                                 'Verifique se as chaves de autenticação da conta estão corretas e se estão liberadas para utilização no ambiente de ' +
                                  FAmbiente + '.'); //+ ' Erro:' + E.Message
       End
       Else
       Begin
          Raise Exception.Create('Ocorreu um erro ao realizar a consulta na API CDL POA(RS).' + #13 +
                                 'Verifique se as chaves de autenticação da conta estão corretas e se estão liberadas para utilização no ambiente de ' +
                                  FAmbiente + '.' + #13 +
                                  'Mensagem Erro:' + IIF ( fVerificaSeRetornouExcecao(FXmlRetorno,strMsgErro), strMsgErro, E.Message ) ); //+ ' Erro:' + E.Message

       End;

       Application.ProcessMessages;

    End;

  End;

end;

destructor TConsultaSCPC_CDLPOA_RS.Destroy;
begin

  If FHandleRequisicoes <> 0 Then
  Begin
    FHandleRequisicoes := 0;
    FreeLibrary(FHandleRequisicoes);
  End;

  FreeAndNil(FXmlRetorno);
  inherited;
end;

function TConsultaSCPC_CDLPOA_RS.fConsultaServico(strDocumento: String): Boolean;
begin
  Result := False;

  If Not FLoginAutomatico Then
  Begin
    FCodSCPC      := '';
    FCodAssociado := '';
    FCodigoFilial := '';
    FSenha        := '';
  End;

  FCodSCPC      := fCfgSis('CDLSPC'); // CODIGO SCPC
  FCodAssociado := fCfgSis('CDLASS'); // CODIGO DO ASSOCIADO
  FCodigoFilial := fCfgSis('CDLFIL'); // CODIGO FILIAL
  FSenha        := fCfgSis('CDLSEN'); // SENHA CDL

  If fEmptyStr(FCodigoFilial) Or fEmptyStr(FCodAssociado) Or fEmptyStr(FSenha) Then
  Begin
    If Not fInputQueryTipo('CDL POA RS', 'Cód. SCPC:', FCodSCPC, ttAlfanumerico) Then
      Exit;

    If Not fInputQueryTipo('CDL POA RS', 'Cód. Associado:', FCodAssociado, ttAlfanumerico) Then
      Exit;

    If Not fInputQueryTipo('CDL POA RS', 'Cód. Filial:', FCodigoFilial, ttAlfanumerico) Then
      Exit;

    If Not fInputQueryTipo('CDL POA RS', 'Senha:', FSenha, ttAlfanumerico, '*') Then
      Exit;
  End;

  FDefineRiscoPositivo := (strDocumento.Length > 11);   //> 11:CNPJ; <=11:CPF;

  DefineAmbiente;

  Try

    If FDefineRiscoPositivo Then
    Begin

       If FConsulta = 'Define Risco Positivo' Then
          Result := DefineRiscoPositivo(strDocumento)
       Else
       If FConsulta = 'Define Negócio Positivo' Then
          Result := DefineNegocioPositivo(strDocumento)
       Else
       If FConsulta = 'Define Limite Positivo' Then
          Result := DefineLimitePositivo(strDocumento);

    End
    Else
    Begin

       If FConsulta = 'Familia Positivo' Then
          Result := ConsultaFamiliaPositivo(strDocumento)
       Else
       If FConsulta = 'Rede Positivo' Then
          Result := ConsultaRedePositivo(strDocumento);

    End;

  Except
    On E : Exception Do
    Begin
      pMensagensErro(E.Message, '[TConsultaSCPC_CDLPOA_RS.fConsultaServico]');
      Result := False;
    End;
  End;

end;


function TConsultaSCPC_CDLPOA_RS.fGetMsgErro: String;
begin
  Result := '';
end;

function TConsultaSCPC_CDLPOA_RS.fGetQtdCheques: Integer;
begin
  Result := FQtdChequeSemFundo;
end;

function TConsultaSCPC_CDLPOA_RS.fGetQtdProtestos: Integer;
begin
  Result := FQtdProtesto;
end;

function TConsultaSCPC_CDLPOA_RS.fGetRelatorio: String;
begin
  FRetorno := '';
  FQtdChequeSemFundo := 0;
  FQtdProtesto:= 0;

  ConverterXmlParaTexto(FXmlRetorno.DocumentElement);
  Result := FRetorno;
end;

function TConsultaSCPC_CDLPOA_RS.fRealizarConsulta(strDocumento, strNomeEmpresa, strCidade, strUF: String; blnSCPCAutomatico: Boolean): Boolean;
begin

   FLoginAutomatico := blnSCPCAutomatico;
   FDocumento :=  strDocumento;
   TfrmGravando.fExecutarModalA(RealizarConsulta,'Aguarde... Realizando consulta.', '');
   Result := FSucesso;
end;

function TConsultaSCPC_CDLPOA_RS.fRealizarConsulta(strDocumento, strNomeEmpresa, strCidade, strUF: String; blnSCPCAutomatico: Boolean; strConsulta: String; strTipoConsulta: String): Boolean;
begin

   FLoginAutomatico := blnSCPCAutomatico;
   FDocumento    := strDocumento;
   FConsulta     := strConsulta;
   FTipoConsulta := strTipoConsulta;
   TfrmGravando.fExecutarModalA(RealizarConsulta,'Aguarde... Realizando consulta.', '');
   Result := FSucesso;
end;

procedure TConsultaSCPC_CDLPOA_RS.pSaveToFile(const strFileName: String);
var
  stlTexto: TStringList;
begin

  If Not DirectoryExists(ExtractFilePath(strFileName)) Then
    fCriaDiretorio(ExtractFilePath(strFileName));

  stlTexto := TStringList.Create;
  stlTexto.Text := Self.fGetRelatorio;
  stlTexto.SaveToFile(strFileName);
  FreeAndNil(stlTexto);

  FXmlRetorno.SaveToFile(AnsiReplaceStr(strFileName,ExtractFileExt(strFileName), '.xml'));

end;


procedure TConsultaSCPC_CDLPOA_RS.RealizarConsulta;
begin
  FSucesso := fConsultaServico(FDocumento);
end;

function TConsultaSCPC_CDLPOA_RS.RetornaTextoFormatado(
  XMLNode: IXMLNode): String;
begin
  Result := SepararPalavras(XMLNode);

  If Pos(':',Result) > 0 Then
    Result := Copy(Result, Pos(':',Result) + 1, Result.Length);

  Result := UpperCase(Copy(Result,1,1)) + Copy(Result,2,Length(Result));

  Result := CorrigirOrtografia(Result);

  If XMLNode.IsTextElement Then
    Result := Result + ': ' + XMLNode.NodeValue;

  If Not XMLNode.HasChildNodes Then
    Result := Result + ': ';

end;

function TConsultaSCPC_CDLPOA_RS.SepararPalavras(
  XMLNode: IXMLNode): String;
begin
  Result := XMLNode.NodeName.Replace('_',' ');
end;

function TConsultaSCPC_CDLPOA_RS.fProcurarElemento(ElementoPai: IXMLNode; strNome: String): IXMLNode;
begin
  If ElementoPai = nil Then
  Begin
    Result := nil;
    Exit;
  End;

  If ElementoPai.LocalName = strNome Then
  Begin
    Result := ElementoPai;
    Exit;
  End;

  Result := fProcurarElemento(ElementoPai.ChildNodes.First, strNome);
  If Result <> nil Then
  Begin
    Exit;
  End;

  Result := fProcurarElemento(ElementoPai.NextSibling, strNome);
  If Result <> nil Then
  Begin
    Exit;
  End;

  Result := nil;
end;

Function TConsultaSCPC_CDLPOA_RS.fVerificaSeRetornouErroXml( LDocumento : TXMLDocument; Var msgErro : String ): Boolean;
  Var
      LNodErro : IXmlNode;
      nodItem  : IXmlNode;
      nodRec   : IXmlNode;
      strMessage : String;
Begin

   Result := False;

   LNodErro := fProcurarElemento(LDocumento.Node, 'ArrayOfMensagem');

   If Assigned(LNodErro) Then
   Begin

      While fWhileNode(LNodErro,'ArrayOfMensagem') Do
      Begin
        nodItem := fProcurarElemento(LNodErro, 'mensagem');

        If Assigned(nodItem) Then
        Begin

          //nodRec := LNodTitulo.ChildNodes.FindNode('code');
          //teste := nodRec.NodeValue;

          nodRec := nodItem.ChildNodes.FindNode('mensagem_erro');
          strMessage := nodRec.NodeValue;

        End;

        LNodErro := LNodErro.NextSibling;
      End;

      If Not fEmptyStr(strMessage) Then
      Begin
         msgErro := RetornaTextoErroTratado(strMessage);
         Result := True;
      End;

   End;

End;

function TConsultaSCPC_CDLPOA_RS.RetornaTextoErroTratado(AErro: String): String;
begin
  Result := AErro;

  If Result.Contains('ORA-20000: Senha informada está incorreta !') Then
     Result := 'A senha informada está incorreta, verifique!';
end;

Function TConsultaSCPC_CDLPOA_RS.fVerificaSeRetornouExcecao( LDocumento : TXMLDocument; Var msgErro : String ): Boolean;
  Var
      LNodErro : IXmlNode;
      nodItem  : IXmlNode;
      strMessage : String;
Begin

   Result := False;

   LNodErro := fProcurarElemento(LDocumento.Node, 'Fault');

   If Assigned(LNodErro) Then
   Begin

      While fWhileNode(LNodErro,'soap:Fault') Do
      Begin
        nodItem := fProcurarElemento(LNodErro, 'faultstring');

        If Assigned(nodItem) Then
        Begin

          //nodRec := LNodTitulo.ChildNodes.FindNode('code');
          //teste := nodRec.NodeValue;

          //nodRec := nodItem.ChildNodes.FindNode('faultstring');
          strMessage := nodItem.NodeValue;

        End;

        LNodErro := LNodErro.NextSibling;
      End;

      If Not fEmptyStr(strMessage) Then
      Begin
         msgErro := strMessage; //RetornaTextoErroTratado(strMessage);
         Result := True;
      End;

   End;

End;

function TConsultaSCPC_CDLPOA_RS.fWhileNode(ANode: IXmlNode; NomeNode :String): Boolean;
begin
  Result := False;

  If not Assigned(ANode) Then
     Exit;

  If not (ANode.GetNodeName = NomeNode) Then
     Exit;

  Result := True;
end;

end.
