unit untTBancoCredisisAPI;

interface

Uses Classes, SysUtils, IPPeerClient, IPPeerCommon,
     REST.Json, System.Json, untConstantes, System.Net.URLClient, IdIOHandler,
     IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent,
     IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, Vcl.StdCtrls, Forms,
     System.Generics.Collections, UniClientDataSet, DB, Uni, untGravando,
     untFuncoesSimples, IdCoder, IdCoder3to4, IdCoderMIME,untTRegBol,StrUtils,
     DateUtils,untFuncAutban,Winapi.Windows,untFuncoesBoleto,REST.Types, REST.Client,
     untTypesSistema,XMLDoc, XMLIntf, untfuncoes;

Type
  TDetalhamento = Record
    ValorPago,
    ValorCreditado,
    ValorIOF,
    ValorTarifa: String;
  End;

Type
  TRetornoPesquisaBancoCredisisApi = class
  private
    function GetNossoNumero: String;
    function DataRegistroAsDate: String;
    function DataMovimentoAsDate: String;
    function DataVencimentoAsDate: String;
    function DataCreditoAsDate: String;
    function ValorPagoCedente:String;
  public
    BoletoNumeroBoletoBB,
    BoletoEstadoTituloCobranca,
    BoletoDataRegistro,
    BoletoDataVencimento,
    BoletoDataMovimento,
    BoletoValorOriginal,
    BoletoValorAtual,
    BoletoValorPago,
    BoletoContrato,
    BoletoCarteiraConvenio,
    BoletoVariacaoCarteiraConvenio,
    BoletoCodigoEstadoTituloCobranca,
    BoletoDataCredito,
    ValorDesconto,
    ValorJuros,
    NomeDoArquivo: String;
    FDetalhamento : TDetalhamento;
    Property NossoNumero            : String  Read GetNossoNumero        Write BoletoNumeroBoletoBB;
    Property ABoletoDataRegistro    : String  Read DataRegistroAsDate    Write BoletoDataRegistro;
    Property ABoletoDataVencimento  : String  Read DataVencimentoAsDate  Write BoletoDataVencimento;
    Property ABoletoDataMovimento   : String  Read DataMovimentoAsDate   Write BoletoDataMovimento;
    Property ABoletoDataCredito     : String  Read DataCreditoAsDate     Write BoletoDataCredito;
    Property ABoletoValorPago       : String  Read ValorPagoCedente      Write BoletoValorPago;
  end;


Type
  TDadosCarteira = class
  private
    LHomologacao : Boolean;
    LCarteiraBanco,
    LEmpresaCarteira,
    LLinkApi,
    LCodCarteira,
    LConvenio,
    LContaCorrente,
    LAgencia,
    LQtdDiasProtesto,
    LTipoDiasProtesto,
    LObservacao1,
    LObservacao2,
    LObservacao3,
    LObservacao4,
    LObservacao5,
    LPercenMulta,
    LTipoMulta,
    LTipoJuros,
    LAceite,
    LPastaBancoCredisis,
    LToken,
    LAmbiente,
    LTipoCobranca,
    LSacadorAval,
    LTipoTitulo,
    LOrgaoNegativador,
    LNomeBen,
    LEndBen,
    LBaiBen,
    LCompBen,
    LCidBen,
    LEstBen,
    LCepBen,
    LNumBen,
    LCnpjBen : String;
  end;

Type
  TBancoCredisisAPI = class(TObject)
  private
    FProtocoloSSL: TIdSSLIOHandlerSocketOpenSSL;
    LRequisicao: TidHTTP;
    LDadosCarteira : TDadosCarteira;
    LPercentualMulta,
    LPercentualMora: Double;
    LFaturamento: Boolean;
    FTentarNovamente: Boolean;
    LNossoNumeroCancelamento : String;
    LCancelarRegistro : Boolean;
    LDuplicataCancelamento: String;

    ListaRequisicaoRegistroBoleto : TList<TRequisicaoRegistroBoleto>;
    LRetornoBancoCredisisAPI: TRetornoBoletoBancoCredisis;

    FErros: TStringList;
    FErroNoXml : Boolean;

    procedure OnWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure CriarComponenteRequisicao;
    procedure CriarProtocoloSSL;
    procedure DefinirURL;
    Function ExecuteRest(AMetodo, AUrl : String; AXml: String; out ARetorno: String): Integer;
    procedure CarregaDadosCarteira(ACarteira: String);
    function RetornaDadosDaRequisicao(ADadosDuplicata, ADadosCliente: TDataset;ANosNum:String): String;
    function RetornaDadosDaRequisicaoConsulta(ADataIni, ADataFim : String): String;
    function RetornaCampoDecimalJSON(AValor: String): String;
    function RetornaValorString(AValor: String; ATamanho: Integer = 0): String;
    procedure Aguarde(msecs: Integer);
    procedure AguardeCincoSegundos;
    function RetornaXmlRegistroBoleto(AAutoIncrem: String): String;
    function EncontrarXmlRegistroBoleto(AAutoIncrem: String): String;
    procedure AtualizaDadosExportacaoRemessa(ACadRec: TDataSet);
    function fGetTagXML(ATag, AXML: String): String;
    Function fWhileNode(ANode: IXmlNode; NomeNode :String): Boolean;
    Function MontaCorpo(ADadosDuplicata,ADadosCliente: TDataset) : String;
    Function GeraAvalista : String;
    Function GeraPagador(ADadosCliente: TDataset) : String;
    Function GeraDadosDocumentoDoBoleto(ADadosDuplicata,ADadosCliente: TDataset) : String;
    Function GeraInstrucao : String;
    Function GeraMulta(ADadosDuplicata : TDataset) : String;
    Function GeraProtesto(ADadosDuplicata: TDataset) : String;
    Function GeraJuros(ADadosDuplicata: TDataset) : String;
    Function GeraDescontos(ADadosDuplicata: TDataset) : String;
    Function GeraTipoEnvioOrgaoNegativador : String;
    Function Gera_PeriodoOperacoesConsulta(ADataIni, ADataFim : String) : String;
    Function fProcurarElemento(ElementoPai: IXMLNode; strNome: String): IXMLNode;
    function fVerificaSeRetornouErroXml( LDocumento : TXMLDocument; Var msgErro : String ): Boolean;

    function fRetornaContatoEmail(ADadosCliente : TDataset): String;
    Procedure pRetornaContatoPagador(ADadosCliente : TDataset; var VarContato : String; var VarTipoContato : String);

    function RetornaTextoErroTratado(AErro: String): String;
  public
    constructor Create(ACarteira: String);
    Destructor Destroy; Override;

    function CadastrarNovoBoleto(ADadosDuplicata, ADadosCliente: TDataSet; Var ANosNum: String; tDocXml : TXMLDocument): TRetornoBoletoBancoCredisis; //TRetornoBoletoBancoDoBrasil;
    procedure ReimpressaoDeBoleto(AAutoIncrem: String; tDocXml : TXMLDocument);
    procedure GravarDadosRequisicaoRegistroBoleto;

    function ConsultaBoletosPorPeriodo(ADataInicial,
                                       ADataFinal: String;
                                       AProgresso: TfrmGravando; tDocXml : TXMLDocument): TList<TRetornoPesquisaBancoCredisisApi>;
    function VerificaSeADuplicataExisteCadrec(ABoleto: TRetornoPesquisaBancoCredisisApi; out ADuplicata: TDuplicataCtr): Boolean;
    function fRetornaCarteiraBoleto(ABoleto: TRetornoPesquisaBancoCredisisApi): String;

    property PercentualMulta  : Double    Read LPercentualMulta  Write LPercentualMulta;
    property PercentualMora   : Double    Read LPercentualMora   Write LPercentualMora;
    property Faturamento      : Boolean   Read LFaturamento      Write LFaturamento;
    property TentarNovamente  : Boolean   Read FTentarNovamente  Write FTentarNovamente;
    property CancelarRegistro : Boolean   Read LCancelarRegistro Write LCancelarRegistro;
    property ErroNoXml        : Boolean   Read FErroNoXml        Write FErroNoXml;

    property NossoNumeroCancelamento  : String    Read LNossoNumeroCancelamento Write LNossoNumeroCancelamento;
    property DuplicataCancelamento    : String    Read LDuplicataCancelamento   Write LDuplicataCancelamento;

    property RetornoBancoCredisisAPI  : TRetornoBoletoBancoCredisis Read  LRetornoBancoCredisisAPI  Write LRetornoBancoCredisisAPI;

  End;

  //**********************************************************
  // Informados no layout, porem não funciona;               *
  // 'http://ws-homologacao.credisiscobranca.com.br/?wsdl';  *
  // 'http://ws.credisiscobranca.com.br/?wsdl';              *
  //**********************************************************

const
  C_URL                  = 'https://credisiscobranca.com.br/v2/ws?wsdl';
  //C_URL_HOM              = 'http://ws-homologacao.credisiscobranca.com.br/?wsdl';

  Const_SOAP_ATTRIBUTTES = 'xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" '+
                           'xmlns:urn="urn:CredisisBoletoInterface" xmlns:urn1="urn:CredisisBoletoInterface-CredisisWebService"';

implementation

{ TBancoCredisisAPI }

function TBancoCredisisAPI.fProcurarElemento(ElementoPai: IXMLNode; strNome: String): IXMLNode;
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

function TBancoCredisisAPI.fWhileNode(ANode: IXmlNode; NomeNode :String): Boolean;
begin
  Result := False;

  If not Assigned(ANode) Then
     Exit;

  If not (ANode.GetNodeName = NomeNode) Then
     Exit;

  Result := True;
end;

Function TBancoCredisisAPI.Gera_PeriodoOperacoesConsulta(ADataIni, ADataFim : String) : String;
 Var
     Texto : String;
begin
   if ((ADataIni <> '') And (ADataFim <> '')) then
   begin
      Texto := '';
      Texto := Texto + ' <periodo>';
      Texto := Texto + '    <inicio>' + ADataIni + '</inicio>';
      Texto := Texto + '    <fim>' + ADataFim + '</fim>';
      Texto := Texto + '    <tipo>baixa_manual</tipo>';
      Texto := Texto + ' </periodo>';
      Texto := Texto + ' <operacoes>';
      Texto := Texto + '    <item>BAIXA</item>';
      Texto := Texto + '    <item>BAIXA_MANUAL</item>';
      Texto := Texto + ' </operacoes>';
      Result := Texto;
   end;
end;

Function TBancoCredisisAPI.MontaCorpo(ADadosDuplicata,ADadosCliente: TDataset) : String;
 Var
     strBody : String;
Begin
     strBody := '';
     strBody := strBody + GeraAvalista;
     strBody := strBody + GeraPagador(ADadosCliente);
     strBody := strBody + GeraDadosDocumentoDoBoleto(ADadosDuplicata,ADadosCliente);
     strBody := strBody + GeraProtesto(ADadosDuplicata);
     strBody := strBody + GeraTipoEnvioOrgaoNegativador;
     strBody := strBody + GeraInstrucao;
     strBody := strBody + GeraMulta(ADadosDuplicata);
     strBody := strBody + GeraJuros(ADadosDuplicata);
     strBody := strBody + GeraDescontos(ADadosDuplicata);

     Result := strBody;
End;

Function TBancoCredisisAPI.GeraAvalista : String;
 Var
     Texto : String;
begin
   if (Not fEmptyStr(LDadosCarteira.LSacadorAval)) And (LDadosCarteira.LSacadorAval = 'S') then
   begin

      Texto := '';
      Texto := Texto + '<avalista>';
      Texto := Texto + '    <nome>'+fTiraCaracEspeciais(LDadosCarteira.LNomeBen)+'</nome>';
      Texto := Texto + '    <nomeFantasia>'+fTiraCaracEspeciais(LDadosCarteira.LNomeBen)+'</nomeFantasia>';
      Texto := Texto + '    <cpfCnpj>'+fTiraCaracEspeciais(LDadosCarteira.LCnpjBen,true,true,true,true,true,true)+'</cpfCnpj>';
    //Texto := Texto + '    <cpfCnpj>'+fTiraCaracEspeciais( LDadosCarteira.LCnpjBen )+'</cpfCnpj>'; //para verificações de erro.
      Texto := Texto + '    <identidade></identidade>';
      Texto := Texto + '    <dataNascimento></dataNascimento>';
      Texto := Texto + '    <endereco>';
      Texto := Texto + '      <endereco>'+(LDadosCarteira.LEndBen)+'</endereco>';
      Texto := Texto + '      <bairro>'+fTiraCaracEspeciais(LDadosCarteira.LBaiBen)+'</bairro>';
      Texto := Texto + '      <complemento></complemento>';
      Texto := Texto + '      <cep>'+fTiraCaracEspeciais(LDadosCarteira.LCepBen)+'</cep>';
      Texto := Texto + '      <cidade>'+fTiraCaracEspeciais(LDadosCarteira.LCidBen)+'</cidade>';
      Texto := Texto + '      <uf>'+LDadosCarteira.LEstBen+'</uf>';
      Texto := Texto + '      <numero>'+LDadosCarteira.LNumBen+'</numero>';
      Texto := Texto + '    </endereco>';
    //Texto := Texto + '    <contatos>';
    //Texto := Texto + '      <item>';
    //Texto := Texto + '         <contato></contato>';
    //Texto := Texto + '         <tipoContato></tipoContato>';
    //Texto := Texto + '      </item>';
    //Texto := Texto + '    </contatos>';
      Texto := Texto + '</avalista>';

      Result := Texto;
   end;
end;

function TBancoCredisisAPI.fRetornaContatoEmail(ADadosCliente : TDataset): String;
Begin
   Result := '';

   If (Not fEmptyStr(ADadosCliente.FieldByName('CLI_EMCOB1').AsString)) Then
       Result := ADadosCliente.FieldByName('CLI_EMCOB1').AsString
   Else
   If (Not fEmptyStr(ADadosCliente.FieldByName('CLI_EMCOB2').AsString)) Then
       Result := ADadosCliente.FieldByName('CLI_EMCOB2').AsString
   Else
   If (Not fEmptyStr(ADadosCliente.FieldByName('CLI_EMAIL_').AsString)) Then
       Result := ADadosCliente.FieldByName('CLI_EMAIL_').AsString;

End;

Procedure TBancoCredisisAPI.pRetornaContatoPagador(ADadosCliente : TDataset; var VarContato : String; var VarTipoContato : String);
Begin

  If Not fEmptyStr(ADadosCliente.FieldByName('CLI_CELULA').AsString) Then
  Begin
     VarContato     := ADadosCliente.FieldByName('CLI_CELULA').AsString;
     VarTipoContato := '3'; //CELULAR
  End
  Else
  If Not fEmptyStr(ADadosCliente.FieldByName('CLI_FONE01').AsString) Then
  Begin
     VarContato     := ADadosCliente.FieldByName('CLI_FONE01').AsString;
     VarTipoContato := '2'; //COMERCIAL
  End
  Else
  If Not fEmptyStr(ADadosCliente.FieldByName('CLI_FONE02').AsString) Then
  Begin
     VarContato     := ADadosCliente.FieldByName('CLI_FONE02').AsString;
     VarTipoContato := '2'; //COMERCIAL
  End
  Else
  If (Not fEmptyStr(ADadosCliente.FieldByName('CLI_EMAIL_').AsString)) Or
     (Not fEmptyStr(ADadosCliente.FieldByName('CLI_EMCOB1').AsString)) Or
     (Not fEmptyStr(ADadosCliente.FieldByName('CLI_EMCOB2').AsString)) Then
  Begin

     VarContato     := fRetornaContatoEmail(ADadosCliente);
     VarTipoContato := '4';

  End;

  If fEmptyStr(VarContato) Then
  Begin
     VarContato     := '99999999999';
     VarTipoContato := '3'; //CELULAR
  End;

End;

Function TBancoCredisisAPI.GeraPagador(ADadosCliente : TDataset) : String;
 Var
     Texto : String;
     vContato : String;
     vTipocontato  : String;

     LNomeFantasia: String;
begin
  if Assigned(ADadosCliente) then
  Begin
     if Not (ADadosCliente.IsEmpty) then
     begin

        pRetornaContatoPagador(ADadosCliente, vContato, vTipocontato);

        Texto := '';
        Texto := Texto + '<pagador>';
        Texto := Texto + '  <nome>'+ fTiraCaracEspeciais(ADadosCliente.FieldByName('CLI_NOMCLI').AsString) +'</nome>';
        //Texto := Texto + '  <nome></nome>';  //desabilitar a linha acima e habilitar essa para teste de erro no envio da solicitação;

        LNomeFantasia := fTiraCaracEspeciais(ADadosCliente.FieldByName('CLI_FANSOB').AsString);
        If LNomeFantasia.IsEmpty Then
          LNomeFantasia := fTiraCaracEspeciais(ADadosCliente.FieldByName('CLI_NOMCLI').AsString);

        Texto := Texto + '   <nomeFantasia>'+ LNomeFantasia +'</nomeFantasia>'; //opcional

        Texto := Texto + '   <cpfCnpj>'+ ADadosCliente.FieldByName('CLI_C_G_C_').AsString +'</cpfCnpj>';
        Texto := Texto + '   <identidade></identidade>';         //Opcional
        Texto := Texto + '   <dataNascimento></dataNascimento>'; //opcional
        Texto := Texto + '   <endereco>';
        Texto := Texto + '      <endereco>'+ fTiraCaracEspeciais(ADadosCliente.FieldByName('CLI_ENDERE').AsString) +'</endereco>';
        Texto := Texto + '      <bairro>'+ fTiraCaracEspeciais(ADadosCliente.FieldByName('CLI_BAIRRO').AsString) +'</bairro>';
        Texto := Texto + '      <complemento></complemento>';    //opcional
        Texto := Texto + '      <cep>'+ ADadosCliente.FieldByName('CLI_C_E_P_').AsString +'</cep>';
        Texto := Texto + '      <cidade>'+ fTiraCaracEspeciais(ADadosCliente.FieldByName('CID_NOMCID').AsString) +'</cidade>';
        Texto := Texto + '      <uf>'+ ADadosCliente.FieldByName('CID_ESTADO').AsString +'</uf>';
        Texto := Texto + '      <numero>'+ ADadosCliente.FieldByName('CLI_ENDNUM').AsString +'</numero>';
        Texto := Texto + '   </endereco>';
        Texto := Texto + '   <contatos>';
        Texto := Texto + '      <item>';
        Texto := Texto + '         <contato>'+ vContato +'</contato>';
        Texto := Texto + '         <tipoContato>'+ vTipocontato +'</tipoContato>';
        Texto := Texto + '      </item>';
        Texto := Texto + '   </contatos>';
        Texto := Texto + '</pagador>';

        Result := Texto;

     end;
  End;
end;

Function TBancoCredisisAPI.GeraDadosDocumentoDoBoleto(ADadosDuplicata,ADadosCliente: TDataset) : String;
 Var
     Texto : String;
begin

    if Assigned(ADadosDuplicata) then
    Begin
       if Not (ADadosDuplicata.IsEmpty) then
       begin

          Texto := '';
          Texto := Texto + '<documento>'+ Trim(UpperCase(ADadosDuplicata.FieldByName('CTR_NUMDUP').AsString +
                                                         ADadosDuplicata.FieldByName('CTR_PARCEL').AsString)) +'</documento>';
          Texto := Texto + '<dataEmissao>'+FormatDateTime('YYYY-MM-DD', ADadosDuplicata.FieldByName('CTR_DTACAD').AsDateTime)+'</dataEmissao>';
          Texto := Texto + '<dataVencimento>'+FormatDateTime('YYYY-MM-DD', ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime)+'</dataVencimento>';
          Texto := Texto + '<dataLimitePagamento>'+FormatDateTime('YYYY-MM-DD', ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime)+'</dataLimitePagamento>';
          Texto := Texto + '<valor>'+RetornaCampoDecimalJSON(ADadosDuplicata.FieldByName('CTR_VALDUP').AsString)+'</valor>';
          Texto := Texto + '<quantidadeParcelas>1</quantidadeParcelas>';
          Texto := Texto + '<intervaloParcela>1</intervaloParcela>';
          Texto := Texto + '<layout>default</layout>';
          Texto := Texto + '<formato>pdf</formato>';
          Texto := Texto + '<codigoEspecie>'+Leftstr(LDadosCarteira.LTipoTitulo,2)+'</codigoEspecie>';

          Result := Texto;

       End;
    End;

End;

Function TBancoCredisisAPI.GeraTipoEnvioOrgaoNegativador : String;
 Var
     Texto : String;
begin

   Result := '';
   If Not fEmptyStr(LDadosCarteira.LOrgaoNegativador) Then
   begin
      Texto := '';
      Texto := Texto + '<tipoEnvio>' + LDadosCarteira.LOrgaoNegativador + '</tipoEnvio>';
      Result := Texto;
   End;

End;

Function TBancoCredisisAPI.GeraInstrucao : String;
 Var
     Texto : String;
     strInst : String;
begin

   Result := '';
   If Not fEmptystr(LDadosCarteira.LObservacao1) Then
   begin
      strInst := RetornaValorString(UpperCase(Copy(Trim(LDadosCarteira.LObservacao1 +' '+LDadosCarteira.LObservacao2 +' '+
                                                        LDadosCarteira.LObservacao3 +' '+LDadosCarteira.LObservacao4 +' '+
                                                        LDadosCarteira.LObservacao5),0,300)));

      Texto := '';
      Texto := Texto + '<instrucao>' + strInst + '</instrucao>';

      Result := Texto;
   End;

End;

Function TBancoCredisisAPI.GeraMulta(ADadosDuplicata : TDataSet) : String;
Var Texto : String;
    strTipo : String;
    LValorMulta : Double;
    strValorMulta : String;
begin
    Result := '';

    if Not ADadosDuplicata.IsEmpty  then
    Begin

        if  (Self.LPercentualMulta > 0 ) Then
        Begin

            If Self.LPercentualMulta = 0 Then
               Self.LPercentualMulta := fStrToFloat(LDadosCarteira.LPercenMulta);

            If LDadosCarteira.LTipoMulta = '1' Then //fixo
               LValorMulta := Self.LPercentualMulta
            Else // Percentual
               LValorMulta := fFormataFloat( Self.LPercentualMulta, 2);
               //LValorMulta := fFormataFloat(ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat * (Self.LPercentualMulta/100), 2);

            If (LValorMulta > 0) Then
            Begin
              strTipo := LDadosCarteira.LTipoMulta;
              strValorMulta := RetornaCampoDecimalJSON(LValorMulta.ToString);
            End
            Else
              strTipo := '3';

            Texto := '';
            Texto := Texto + '<multa>';
            Texto := Texto + '   <valor>'+strValorMulta+'</valor>';
            Texto := Texto + '   <carencia>';
            Texto := Texto + '      <tipo>2</tipo>';
            Texto := Texto + '      <dias>0</dias>';
            Texto := Texto + '   </carencia>';
            Texto := Texto + '   <tipo>'+strTipo+'</tipo>';
            Texto := Texto + '</multa>';

            result := Texto;

        End;
    End;

end;

Function TBancoCredisisAPI.GeraProtesto(ADadosDuplicata: TDataset) : String;
 Var Texto : String;
begin
    Result := '';
    if Not (ADadosDuplicata.IsEmpty) then
    Begin
        Texto := '';
        Texto := Texto + '<protesto>';
        Texto := Texto + '   <tipo>'+ LDadosCarteira.LTipoDiasProtesto +'</tipo>';
        Texto := Texto + '   <dias>'+ LDadosCarteira.LQtdDiasProtesto +'</dias>';
        Texto := Texto + '</protesto>';

        result := Texto;
    End;
end;

Function TBancoCredisisAPI.GeraJuros(ADadosDuplicata: TDataset) : String;
Var Texto : String;
    strTipo : String;
    LValorMora : Double;
    strValormora : String;
begin
    result := '';

    If Not (ADadosDuplicata.IsEmpty) then
    Begin
        if ( Self.LPercentualMora > 0 ) then //and ( Titulos.DataMoraJuros > 0) then
        Begin

           strTipo := '0';
           LValorMora := 0;

           If LDadosCarteira.LTipoJuros = '1' Then //fixo
              LValorMora := Self.LPercentualMora
           Else //Percentual
              LValorMora := fFormataFloat( (Self.LPercentualMora * 30), 2);
              //LValorMora := fFormataFloat(ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat * (Self.LPercentualMora/100), 2);

           If (LValorMora > 0) Then
           Begin
             strTipo := LDadosCarteira.LTipoJuros;
             strValormora := RetornaCampoDecimalJSON(LValorMora.ToString);
           End
           Else
             strTipo := '3'; //Isento;

           Texto := '';
           Texto := Texto + '<juros>';
           Texto := Texto + '   <valor>'+strValormora+'</valor>';
           Texto := Texto + '   <carencia>';
           Texto := Texto + '      <tipo>2</tipo>';
           Texto := Texto + '      <dias>0</dias>';
           Texto := Texto + '   </carencia>';
           Texto := Texto + '   <tipo>'+strTipo+'</tipo>';
           Texto := Texto + '</juros>';

           result := Texto;

        End;
    End;

end;

Function TBancoCredisisAPI.GeraDescontos(ADadosDuplicata: TDataset) : String;
Var Texto : String;
    strTipo : String;
    LDataExpiracao : TDateTime;
    strValorDes : String;
begin

    if Not ADadosDuplicata.IsEmpty then
    Begin
        strTipo := '0';
        Texto := '';
        LDataExpiracao := 0;

        if ( ADadosDuplicata.FieldByName('CTR_DESSUJ').AsFloat > 0 ) then
        Begin

            If ADadosDuplicata.FieldByName('CTR_DESSUJ').AsFloat > 0 Then
            Begin
              LDataExpiracao := (ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime -  ADadosDuplicata.FieldByName('CTR_QTDDAV').AsInteger);
              strTipo := '1'; // valor fixo
              strValorDes := RetornaCampoDecimalJSON(fFormataFloat(ADadosDuplicata.FieldByName('CTR_DESSUJ').AsFloat,2).ToString);
            End
            Else
              strTipo := '3';

            Texto := Texto + '<desconto1>';
            Texto := Texto + '   <valor>'+strValorDes+'</valor>';
            Texto := Texto + '   <data>'+FormatDateTime('YYYY-MM-DD', LDataExpiracao)+'</data>';
            Texto := Texto + '   <tipo>'+strTipo+'</tipo>';
            Texto := Texto + '</desconto1>';

        End;

{       if ( Titulos.ValorDesconto2 > 0 ) then
        Begin
            case Titulos.CodigoDesconto of
               cdSemDesconto : iTipo := 3;
               cdValorFixo   : iTipo := 2;
            end;
            if iTipo = 0 then
             iTipo := 1;

            Texto := Texto + '<desconto2>';
            Texto := Texto + '   <valor>0</valor>';
            Texto := Texto + '   <data></data>';
            Texto := Texto + '   <tipo>3</tipo>';
            Texto := Texto + '</desconto2>';

        End;
        if ( Titulos.ValorDesconto3 > 0 ) then
        Begin
            case Titulos.CodigoDesconto of
               cdSemDesconto : iTipo := 3;
               cdValorFixo   : iTipo := 2;
            end;
            if iTipo = 0 then
             iTipo := 1;

            Texto := Texto + '<desconto3>';
            Texto := Texto + '   <valor>0</valor>';
            Texto := Texto + '   <data></data>';
            Texto := Texto + '   <tipo>3</tipo>';
            Texto := Texto + '</desconto3>';

        End;
}

        result := Texto;

    End;

end;

procedure TBancoCredisisAPI.Aguarde(msecs: Integer);
  var
    FirstTickCount: LongInt;
begin
  FirstTickCount := GetTickCount;
  repeat
    Application.ProcessMessages;
  until ((LongInt(GetTickCount) - LongInt(FirstTickCount)) >= LongInt(msecs));
end;

procedure TBancoCredisisAPI.AguardeCincoSegundos;
begin
  Aguarde(5000);
end;

procedure TBancoCredisisAPI.AtualizaDadosExportacaoRemessa(ACadRec: TDataSet);
  Var
    LCadRec: TUniQuery;
    LSql: String;
begin
  Try
    LCadRec := fCriaQuery(Nil);

    LSql := LSql + 'UPDATE    ';
    LSql := LSql + '  CADREC  ';
    LSql := LSql + 'SET ';
    LSql := LSql + '  CTR_BCOENV = :CODBCO, ';
    LSql := LSql + '  CTR_DTAENV = ' + fCurrentDate;
    LSql := LSql + 'WHERE ';
    LSql := LSql + '  CTR_NUMDUP = :NUMDUP AND ';
    LSql := LSql + '  CTR_PARCEL = :PARCEL AND ';
    LSql := LSql + '  CTR_ESPDOC = :ESPDOC AND ';
    LSql := LSql + '  CTR_CODEMP = :CODEMP AND ';
    LSql := LSql + '  CTR_CODCLI = :CODCLI AND ';
    LSql := LSql + '  CTR_SEQBAI = 0 ';

    Try
      LCadRec.Close;
      LCadRec.Sql.Clear;
      LCadRec.Sql.Add(LSql);
      LCadRec.ParamByName('CODBCO').AsString := '097';

      LCadRec.ParamByName('NUMDUP').AsString := ACadRec.FieldByName('CTR_NUMDUP').AsString;
      LCadRec.ParamByName('PARCEL').AsString := ACadRec.FieldByName('CTR_PARCEL').AsString;
      LCadRec.ParamByName('ESPDOC').AsString := ACadRec.FieldByName('CTR_ESPDOC').AsString;
      LCadRec.ParamByName('CODEMP').AsString := ACadRec.FieldByName('CTR_CODEMP').AsString;
      LCadRec.ParamByName('CODCLI').AsString := ACadRec.FieldByName('CTR_CODCLI').AsString;
      LCadRec.ExecSQL;
    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  Finally
    FreeAndNil(LCadRec);
  End;
end;

function TBancoCredisisAPI.CadastrarNovoBoleto(ADadosDuplicata,ADadosCliente: TDataSet; Var ANosNum: String; tDocXml : TXMLDocument): TRetornoBoletoBancoCredisis;
  Var
    LDadosRequisicao: String;
    LRetornoPost_: String;

    LRequisicaoRegistroBoleto : TRequisicaoRegistroBoleto;
    LXml,
    LListXML,
    LListRetXML : TStringList;

    LStatus : Integer;

    LNodTitulosItem : IXmlNode;
    LNodTitulo      : IXmlNode;

    strMsgErro : String;

begin
  Self.FTentarNovamente := True;
  Result := TRetornoBoletoBancoCredisis.Create;
  LRequisicaoRegistroBoleto := TRequisicaoRegistroBoleto.Create;

  LXml := TStringList.Create;
  LListXML    := TStringList.Create;
  LListRetXML := TStringList.Create;

  LRequisicaoRegistroBoleto.LCartei :=  LDadosCarteira.LCarteiraBanco + '-' +  LDadosCarteira.LEmpresaCarteira;
  LRequisicaoRegistroBoleto.LCodBco := '097';
  LRequisicaoRegistroBoleto.LLocImp := IIF(Self.LFaturamento,'FAT','CTR');

  LDadosRequisicao := RetornaDadosDaRequisicao(ADadosDuplicata, ADadosCliente, ANosNum);
  LRequisicaoRegistroBoleto.LJsoEnv := LDadosRequisicao;
  LRequisicaoRegistroBoleto.LDuplic := ADadosDuplicata.FieldByName('AUTOINCREM').AsString;
  LRequisicaoRegistroBoleto.LLnkApi := LDadosCarteira.LLinkApi; //C_URL;

  Try
    Try
      LXml.LoadFromFile(LDadosRequisicao);
      LRequisicaoRegistroBoleto.FRequisicao := LXml.Text;

      LStatus := ExecuteRest('POST', LRequisicaoRegistroBoleto.LLnkApi, LDadosRequisicao, LRetornoPost_);

      If LStatus <> 0 Then
      Begin
        // Grava retorno do post e abre carregando em uma stringlist para não dar o problema.
        LListRetXML.append( LRetornoPost_ );
        LListRetXML.savetofile(LDadosCarteira.LPastaBancoCredisis + 'Retorno_RequisicaoCadastrarBoleto.xml');
        LListXML.LoadFromFile(LDadosCarteira.LPastaBancoCredisis + 'Retorno_RequisicaoCadastrarBoleto.xml');

        tDocXml.Active := False;
        tDocXml.xml    := LListXML;
        tDocXml.Active := true;
      End
      Else
         Raise Exception.Create(LRetornoPost_);

      If LStatus <> 200 Then
      Begin
         If fVerificaSeRetornouErroXml( tDocXml, strMsgErro ) Then
            Raise Exception.Create('Status: ' + LStatus.ToString + ' Erro: ' + strMsgErro);
      End;

      Self.FTentarNovamente := False;

      LRequisicaoRegistroBoleto.LJsoRec := LRetornoPost_;

      self.FErroNoXml := False;

      // If para verificar se foi retorno 200 porem retornou algum erro
      If Not fVerificaSeRetornouErroXml( tDocXml, strMsgErro ) Then
      Begin

         LNodTitulosItem := fProcurarElemento(tDocXml.Node, 'item');

         LNodTitulo := fProcurarElemento(LNodTitulosItem, 'item');

         If Assigned(LNodTitulo) Then
         Begin
            Result.nossoNumero    := fGetValorXml(LNodTitulo, 'nossonumero');
            Result.linhaDigitavel := fGetValorXml(LNodTitulo, 'linhaDigitavel');
            Result.codigoDeBarras := fGetValorXml(LNodTitulo, 'codigoBarras');
         End;

         AtualizaDadosExportacaoRemessa(ADadosDuplicata);

      End
      Else
      Begin
        self.FErroNoXml := True;
        Self.TentarNovamente := False;

        If Not strMsgErro.IsEmpty Then
          Raise Exception.Create(strMsgErro);
      End;

    Except

      On E: Exception Do
      Begin
        LRequisicaoRegistroBoleto.LExcept := E.Message;

        If Not self.FErroNoXml Then
          TfrmGravando.fExecutarModalA(AguardeCincoSegundos,'Falha na comunicação, Nova tentativa em 5 segundos.', '');

        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    Begin

      // Para gravar o erro no reg_ecept, quando vier erro no xml gerado;
      If self.FErroNoXml Then
         LRequisicaoRegistroBoleto.LExcept := LRetornoPost_;

      ListaRequisicaoRegistroBoleto.Add(LRequisicaoRegistroBoleto);
      If Assigned(LXml) Then
         FreeAndNil(LXml);

      If Assigned(LListXML) Then
         FreeAndNil(LListXML);

      If Assigned(LListRetXML) Then
         FreeAndNil(LListRetXML);
    End;
  End;
end;

procedure TBancoCredisisAPI.CarregaDadosCarteira(ACarteira: String);
begin
  LDadosCarteira := TDadosCarteira.Create;
  LDadosCarteira.LCarteiraBanco   := LeftStr(ACarteira,14);
  LDadosCarteira.LEmpresaCarteira := RightStr(ACarteira, 3);

  LDadosCarteira.LAgencia             := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'CODAGEN'      ,'',LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LContaCorrente       := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'NUMCTAC'      ,'',LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LAceite              := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'PROACEI'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LConvenio            := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'CODCONV'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LCodCarteira         := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'NUMCART'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LQtdDiasProtesto     := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'DIAPROT'      ,'0', LDadosCarteira.LEmpresaCarteira);

  LDadosCarteira.LObservacao1         := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'OBSERV1'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LObservacao2         := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'OBSERV2'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LObservacao3         := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'OBSERV3'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LObservacao4         := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'OBSERV4'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LObservacao5         := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'OBSERV5'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LPercenMulta         := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'PERMULT'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LTipoCobranca        := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'TIPO_COBRANCA','', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LToken               := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'TOKEN',        '', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LSacadorAval         := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'SACAVAL',      '', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LAmbiente            := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'TPAMBIENTE',   '', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LTipoTitulo          := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'TPTITULO',     '', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LTipoDiasProtesto    := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'TPDIAPROT'    ,'0', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LTipoMulta           := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'TPMULTA'      ,'0', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LTipoJuros           := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'TPJUROS'      ,'0', LDadosCarteira.LEmpresaCarteira);

  LDadosCarteira.LOrgaoNegativador    := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'ORGAONEGAT'   ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LNomeBen             := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'NOMEBEN'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LEndBen              := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'ENDEBEN'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LBaiBen              := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'BAIRBEN'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LCompBen             := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'COMPBEN'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LCidBen              := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'CIDABEN'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LEstBen              := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'ESTABEN'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LCepBen              := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'CEP_BEN'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LNumBen              := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'NUM_BEN'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LCnpjBen             := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'CNPJBEN'      ,'', LDadosCarteira.LEmpresaCarteira);

  LDadosCarteira.LHomologacao         := (LeftStr(LDadosCarteira.LAmbiente,1) = '1'); //(LeftStr(LDadosCarteira.LKeyUser,2) = 'd2');

  LDadosCarteira.LPastaBancoCredisis := ExtractFilePath(Application.ExeName)+ 'API_COBRANCA_CREDISIS\';
  If Not DirectoryExists(LDadosCarteira.LPastaBancoCredisis) Then
    CreateDir(ExtractFilePath(LDadosCarteira.LPastaBancoCredisis));
end;

Function TBancoCredisisAPI.fVerificaSeRetornouErroXml( LDocumento : TXMLDocument; Var msgErro : String ): Boolean;
  Var
      LNodErro : IXmlNode;
      nodItem  : IXmlNode;
      nodRec   : IXmlNode;
      strMessage : String;
      LErroInstabilidade : String;
Begin

   Result := False;

   LErroInstabilidade := 'Ocorreu um erro não identificado no servidor do banco. Tente novamente mais tarde! ';

   Try
     LNodErro := fProcurarElemento(LDocumento.Node, 'erros');

     If Assigned(LNodErro) Then
     Begin

        While fWhileNode(LNodErro,'erros') Do
        Begin
          nodItem := fProcurarElemento(LNodErro, 'item');

          If Assigned(nodItem) Then
          Begin

            //nodRec := LNodTitulo.ChildNodes.FindNode('code');
            //teste := nodRec.NodeValue;

            nodRec := nodItem.ChildNodes.FindNode('message');
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
   Except
     msgErro := LErroInstabilidade;
     Result := True;
   End;

End;

function TBancoCredisisAPI.ConsultaBoletosPorPeriodo(ADataInicial,ADataFinal: String;
  AProgresso: TfrmGravando; tDocXml : TXMLDocument): TList<TRetornoPesquisaBancoCredisisApi>;
  Var
    LDadosBoleto: TRetornoPesquisaBancoCredisisApi;
    LStatus : Integer;

    LDadosRequisicao: String;
    LXml,
    LListXML,
    LListRetXML : TStringList;
    LRetornoConsulta: String;

    LNodTitulosItem : IXmlNode;
    LNodTitulo      : IXmlNode;
    LNodOperacao    : IXmlNode;
    LNodOperacoesItem : IXmlNode;

    strMsgErro : String;

    LCodigoBanco : String;
begin

  Try
      LXml        := TStringList.Create;
      LListXML    := TStringList.Create;
      LListRetXML := TStringList.Create;

      LCodigoBanco := '097API';

      Result := TList<TRetornoPesquisaBancoCredisisApi>.Create;

      Try

        LDadosRequisicao := RetornaDadosDaRequisicaoConsulta(ADataInicial,ADataFinal);
        LXml.LoadFromFile(LDadosRequisicao);

        LStatus := ExecuteRest('POST', LDadosCarteira.LLinkApi, LDadosRequisicao, LRetornoConsulta);

        If LStatus <> 0 Then
        Begin
          //Grava retorno da consulta e abre carregando em uma stringlist para não dar o problema.
          LListRetXML.append( LRetornoConsulta );
          LListRetXML.savetofile(LDadosCarteira.LPastaBancoCredisis + 'Retorno_RequisicaoConsulta.xml');
          LListXML.LoadFromFile(LDadosCarteira.LPastaBancoCredisis + 'Retorno_RequisicaoConsulta.xml');

          tDocXml.Active := False;
          tDocXml.xml    := LListXML;
          tDocXml.Active := true;
        End
        Else
          Raise Exception.Create(LRetornoConsulta);

        If LStatus <> 200 Then
        Begin
           If fVerificaSeRetornouErroXml( tDocXml, strMsgErro ) Then
              Raise Exception.Create('Status: ' + LStatus.ToString + ' Erro: ' + strMsgErro);
        End;

        If Not fVerificaSeRetornouErroXml( tDocXml, strMsgErro ) Then
        Begin

          //Percorrer os registros encontrados;
          LNodTitulosItem := fProcurarElemento(tDocXml.Node, 'item');

          While fWhileNode(LNodTitulosItem,'item') Do
          Begin
            LNodTitulo := fProcurarElemento(LNodTitulosItem, 'item');

            If Assigned(LNodTitulo) Then
            Begin

               LDadosBoleto := TRetornoPesquisaBancoCredisisApi.Create;

               LDadosBoleto.NomeDoArquivo              := Concat('[',LCodigoBanco,'] ',ADataInicial.Replace('.','/'),' - ',ADataFinal.Replace('.','/'));

               LDadosBoleto.BoletoNumeroBoletoBB       := fGetValorXml(LNodTitulo, 'nossonumero');
               LDadosBoleto.BoletoEstadoTituloCobranca := fGetValorXml(LNodTitulo, 'aberto');

               LDadosBoleto.BoletoDataRegistro         := fGetValorXml(LNodTitulo, 'dataEmissao', varDate);
               LDadosBoleto.BoletoDataVencimento       := fGetValorXml(LNodTitulo, 'dataVencimento', varDate);
               LDadosBoleto.BoletoValorOriginal        := fGetValorXml(LNodTitulo, 'valor',varDouble);
               LDadosBoleto.BoletoValorAtual           := fGetValorXml(LNodTitulo, 'valor',varDouble);

               // *** Percorrer os registros de operacoes encontrados ***
               LNodOperacao := fProcurarElemento(LNodTitulo, 'operacoes');
               LNodOperacoesItem := fProcurarElemento(LNodOperacao, 'item');

               While fWhileNode(LNodOperacoesItem,'item') Do
               Begin

                 If MatchStr( UpperCase(fGetValorXml(LNodOperacoesItem, 'operacao')), ['BAIXA_MANUAL','BAIXA']) Then
                 Begin
                    LDadosBoleto.BoletoValorPago     := fGetValorXml(LNodOperacoesItem, 'valor',varDouble);
                    LDadosBoleto.BoletoDataCredito   := fGetValorXml(LNodOperacoesItem, 'dataHora', varDate);
                    LDadosBoleto.BoletoDataMovimento := fGetValorXml(LNodOperacoesItem, 'dataHora', varDate);

                    LDadosBoleto.BoletoCodigoEstadoTituloCobranca := '06';
                 End;

                 LNodOperacoesItem := LNodOperacoesItem.NextSibling;
               End;

               If (fStrToFloat(LDadosBoleto.BoletoValorPago) > fStrToFloat(LDadosBoleto.BoletoValorOriginal)) Then
                  LDadosBoleto.valorJuros := (fStrToFloat(LDadosBoleto.BoletoValorPago) - fStrToFloat(LDadosBoleto.BoletoValorOriginal)).ToString;

               If (fStrToFloat(LDadosBoleto.BoletoValorOriginal) < fStrToFloat(LDadosBoleto.BoletoValorOriginal)) Then
                  LDadosBoleto.valorDesconto := (fStrToFloat(LDadosBoleto.BoletoValorOriginal) - fStrToFloat(LDadosBoleto.BoletoValorPago)).ToString;

               Result.Add(LDadosBoleto) ;
               Application.ProcessMessages;

            End;

            LNodTitulosItem := LNodTitulosItem.NextSibling;
          End;

        End;

      Except

        On E: Exception Do
        Begin
          Raise Exception.Create(E.Message);
        End;

      End;

  Finally
    FreeAndNil(LXml);
    FreeAndNil(LListXML);
    FreeAndNil(LListRetXML);

    If FileExists( LDadosCarteira.LPastaBancoCredisis + 'Retorno_RequisicaoConsulta.xml' ) Then
       System.SysUtils.DeleteFile(LDadosCarteira.LPastaBancoCredisis + 'Retorno_RequisicaoConsulta.xml');

  End;

end;

constructor TBancoCredisisAPI.Create(ACarteira: String);
begin
  CarregaDadosCarteira(ACarteira);
  CriarProtocoloSSL;
  CriarComponenteRequisicao;
  DefinirURL;
  ListaRequisicaoRegistroBoleto := TList<TRequisicaoRegistroBoleto>.Create;
  LRetornoBancoCredisisAPI := TRetornoBoletoBancoCredisis.Create;
  FErros := TStringList.Create;
end;

procedure TBancoCredisisAPI.CriarComponenteRequisicao;
begin
  LRequisicao := TIdHTTP.Create(Nil);
  LRequisicao.IOHandler := FProtocoloSSL;
  LRequisicao.Request.Connection := 'keep-alive';
  LRequisicao.Request.ContentType := 'text/xml';
  LRequisicao.Response.KeepAlive := True;
  LRequisicao.HTTPOptions := [];
  LRequisicao.OnWork := OnWork;

  LRequisicao.HandleRedirects := True;
end;

procedure TBancoCredisisAPI.CriarProtocoloSSL;
begin
  FProtocoloSSL := TIdSSLIOHandlerSocketOpenSSL.Create(Application);
  FProtocoloSSL.SSLOptions.Mode        := sslmUnassigned;
  FProtocoloSSL.SSLOptions.Method      := sslvTLSv1_2;
  FProtocoloSSL.SSLOptions.SSLVersions := [sslvTLSv1_2];
end;

procedure TBancoCredisisAPI.DefinirURL;
begin
  LDadosCarteira.LLinkApi := C_URL; //IIF(LDadosCarteira.LHomologacao,C_URL_HOM, C_URL);
end;

Function TBancoCredisisAPI.ExecuteRest(AMetodo, AUrl : String; AXml: String; out ARetorno: String): Integer;
 Var
     Retornostr : String;
begin

  result := 0;

  Try

    If UpperCase(AMetodo).Equals('POST') Then
       ARetorno := LRequisicao.Post(Aurl, Axml);

    Result := LRequisicao.ResponseCode;
  Except
    On E: Exception Do
    Begin
      ARetorno := Concat('Erro: ',E.Message);
    End;

    On E :EIdHTTPProtocolException Do
    Begin
      retornostr := LRequisicao.ResponseText;
    End;

  End;

End;

destructor TBancoCredisisAPI.Destroy;
begin
  GravarDadosRequisicaoRegistroBoleto;
  FreeAndNil(ListaRequisicaoRegistroBoleto);
  FreeAndNil(LRequisicao);
  FreeAndNil(FProtocoloSSL);
  FreeAndNil(LRetornoBancoCredisisAPI);

  inherited;
end;

function TBancoCredisisAPI.EncontrarXmlRegistroBoleto(AAutoIncrem: String): String;
  Var
    LRegBol : TUniQuery;
    LNumDupCadRec : String;
    LNosNumCadRec : String;
    LDtaVenCadRec : String;
    LJsonRetorno: TJSONObject;
    LXmlRetorno,
    LXmlRecebidoAPI: String;

    LDtaVen : TDatetime;
    LDtaVenStr : string;

    strDocumento,
    strDataVenc,
    strNosNum : String;
begin
  Result := '';

  strDocumento := '';
  strDataVenc  := '';
  strNosNum    := '';
  LDtaVenStr   := '';

  Try
    LRegBol := fCriaQuery(Nil);
    Try
      LRegBol.Close;
      LRegBol.Sql.Text := 'SELECT                             '+
                          '  REG_JSOENV,                      '+
                          '  REG_JSOREC                       '+
                          'FROM                               '+
                          '  REGBOL WHERE REG_CODBCO = "097"  '+
                          '  AND REG_DUPLIC = :DUPLIC         '+
                          '  AND REG_EXCEPT IS NULL           '+
                          '  AND REG_JSOREC IS NOT NULL       '+
                          'ORDER BY REG_DTAREG DESC,          '+
                          '  REG_HRAREG DESC                  ';

      LRegBol.ParamByName('DUPLIC').AsString := AAutoIncrem;
      LRegBol.Open;

      LNumDupCadRec := fCampoTabela('CTR_NUMDUP', 'CADREC', ['AUTOINCREM'], [AAutoIncrem], False);
      LNosNumCadRec := fCampoTabela('CTR_NOSNUM', 'CADREC', ['AUTOINCREM'], [AAutoIncrem], False);
      LDtaVenCadRec := fCampoTabela('CTR_DTAVEN', 'CADREC', ['AUTOINCREM'], [AAutoIncrem], False);

      LDtaVen := StrToDateTime(LDtaVenCadRec);

      LDtaVenStr := FormatDateTime('YYYY-MM-DD', LDtaVen);

      LRegBol.First;
      While Not LRegBol.Eof Do
      Begin
        LXmlRecebidoAPI := '';

        LXmlRetorno := LRegBol.FieldByName('REG_JSOENV').AsString;

        strDocumento := fGetTagXML('documento',LXmlRetorno);
        strDocumento := LeftStr(strDocumento,12);
        strDataVenc  := fGetTagXML('dataVencimento',LXmlRetorno);

        If strDocumento.Equals(LNumDupCadRec) Then
        Begin

          strNosNum := '';

          LXmlRecebidoAPI := LRegBol.FieldByName('REG_JSOREC').AsString;

          strNosNum := fGetTagXML('nossonumero',LXmlRecebidoAPI);

          If strNosNum.Equals(LNosNumCadRec) Then
          Begin

            If strDataVenc.Equals(LDtaVenStr.Replace('/','.')) Then
            Begin
              Result := LRegBol.FieldByName('REG_JSOREC').AsString;
              Break;
            End;

          End;

        End;

        LRegBol.Next;
      End;
    Except
      On E : Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LRegBol);
    FreeAndNil(LJsonRetorno);
  End;

end;

procedure TBancoCredisisAPI.GravarDadosRequisicaoRegistroBoleto;
  Var
    LRequisicaoRegistroBoleto : TRequisicaoRegistroBoleto;
begin
  If Assigned(ListaRequisicaoRegistroBoleto) Then
  Begin
    If ListaRequisicaoRegistroBoleto.Count > 0 Then
    Begin
      // GRAVA DADOS DAS REQUISIÇÕES
      For LRequisicaoRegistroBoleto In ListaRequisicaoRegistroBoleto Do
      Begin
        TRegBol.GravarRequisicaoReqistroBoleto(LRequisicaoRegistroBoleto);
      End;

      // APAGA DA PASTA JSON CRIADOS PARA REGISTRO DO BOLETO.
      For LRequisicaoRegistroBoleto In ListaRequisicaoRegistroBoleto Do
      Begin
        If FileExists(LRequisicaoRegistroBoleto.LJsoEnv) Then
        Begin
          System.SysUtils.DeleteFile(LRequisicaoRegistroBoleto.LJsoEnv);
        End;

        If FileExists(LDadosCarteira.LPastaBancoCredisis + 'Retorno_RequisicaoCadastrarBoleto.xml') Then
        Begin
          System.SysUtils.DeleteFile(LDadosCarteira.LPastaBancoCredisis + 'Retorno_RequisicaoCadastrarBoleto.xml');
        End;

      End;

      ListaRequisicaoRegistroBoleto.Clear;
    End;
  End;

  //Verifica se existe arquivo criado para consulta de boletos e apaga;
  If FileExists( LDadosCarteira.LPastaBancoCredisis + 'Retorno_RequisicaoConsulta.xml' ) Then
     System.SysUtils.DeleteFile(LDadosCarteira.LPastaBancoCredisis + 'Retorno_RequisicaoConsulta.xml');

  //Verifica se existe arquivo criado para consulta de boletos e apaga;
  If FileExists( LDadosCarteira.LPastaBancoCredisis + 'Retorno_RequisicaoReimpressaoBoleto.xml' ) Then
     System.SysUtils.DeleteFile(LDadosCarteira.LPastaBancoCredisis + 'Retorno_RequisicaoReimpressaoBoleto.xml');

  If FileExists( LDadosCarteira.LPastaBancoCredisis + 'RequisicaoConsulta.xml' ) Then
     System.SysUtils.DeleteFile(LDadosCarteira.LPastaBancoCredisis + 'RequisicaoConsulta.xml');

end;

procedure TBancoCredisisAPI.OnWork(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
  Application.ProcessMessages;
end;

procedure TBancoCredisisAPI.ReimpressaoDeBoleto(AAutoIncrem: String; tDocXml : TXMLDocument);
  Var
    LXmlRetorno: String;
    LListRetXML,
    LListXML : TStringList;
    LNodTitulosItem : IXmlNode;
    LNodTitulo      : IXmlNode;

    LCadRec: TUniQuery;
begin
  Try
    LRetornoBancoCredisisAPI := TRetornoBoletoBancoCredisis.Create;
    Try

      LListXML    := TStringList.Create;
      LListRetXML := TStringList.Create;

      LXmlRetorno := RetornaXmlRegistroBoleto(AAutoIncrem);

      If fEmptyStr(LXmlRetorno) Then
      Begin

        LCadRec := fCriaQuery(Nil);
        LCadRec.Close;
        LCadRec.SQL.Clear;
        LCadRec.SQL.Add('SELECT CTR_NOSNUM, CTR_TX_BOL, CTR_QRCODE, CTR_LINDIG ' +
                        'FROM CADREC WHERE AUTOINCREM = :AUTOINC');

        LCadRec.ParamByName('AUTOINC').AsString := AAutoIncrem;
        LCadRec.Open;

        LRetornoBancoCredisisAPI.nossoNumero               := LCadRec.FieldByName('CTR_NOSNUM').AsString;
        LRetornoBancoCredisisAPI.linhaDigitavel            := LCadRec.FieldByName('CTR_LINDIG').AsString;
        LRetornoBancoCredisisAPI.codigoDeBarras            := Copy(LRetornoBancoCredisisAPI.linhaDigitavel, 01, 04) +
                                                              Copy(LRetornoBancoCredisisAPI.linhaDigitavel, 33, 15) +
                                                              Copy(LRetornoBancoCredisisAPI.linhaDigitavel, 05, 05) +
                                                              Copy(LRetornoBancoCredisisAPI.linhaDigitavel, 11, 08) +
                                                              Copy(LRetornoBancoCredisisAPI.linhaDigitavel, 19, 02) +
                                                              Copy(LRetornoBancoCredisisAPI.linhaDigitavel, 22, 10);

        Exit;
      End;

      LListRetXML.append( LXmlRetorno );
      LListRetXML.savetofile(LDadosCarteira.LPastaBancoCredisis + 'Retorno_RequisicaoReimpressaoBoleto.xml');
      LListXML.LoadFromFile(LDadosCarteira.LPastaBancoCredisis + 'Retorno_RequisicaoReimpressaoBoleto.xml');

      tDocXml.Active := False;
      tDocXml.xml    := LListXML;
      tDocXml.Active := true;

      LNodTitulosItem := fProcurarElemento(tDocXml.Node, 'item');

      If Assigned(LNodTitulosItem) Then
      Begin

         LNodTitulo := fProcurarElemento(LNodTitulosItem, 'item');

         If Assigned(LNodTitulo) Then
         Begin
            LRetornoBancoCredisisAPI.nossoNumero    := fGetValorXml(LNodTitulo, 'nossonumero');
            LRetornoBancoCredisisAPI.linhaDigitavel := fGetValorXml(LNodTitulo, 'linhaDigitavel');
            LRetornoBancoCredisisAPI.codigoDeBarras := fGetValorXml(LNodTitulo, 'codigoBarras');
         End;

      End;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally

    If Assigned(LListXML) Then
       FreeAndNil(LListXML);

    If Assigned(LListRetXML) Then
       FreeAndNil(LListRetXML);

    If Assigned(LCadRec) Then
      FreeAndNil(LCadRec);

    If FileExists( LDadosCarteira.LPastaBancoCredisis + 'Retorno_RequisicaoReimpressaoBoleto.xml' ) Then
       System.SysUtils.DeleteFile(LDadosCarteira.LPastaBancoCredisis + 'Retorno_RequisicaoReimpressaoBoleto.xml');

  End;
end;

function TBancoCredisisAPI.RetornaCampoDecimalJSON(AValor: String): String;
begin
  Result := AValor.Replace('.', EmptyStr);
  Result := Result.Replace(',', '.');
end;

function TBancoCredisisAPI.RetornaDadosDaRequisicao(ADadosDuplicata,ADadosCliente: TDataset; ANosNum: String): String;
  Var
    LArquivoXml: TStringList;
    strXML : String;
Begin

  Try

    LArquivoXml := TStringList.Create;

    strXML := '';
    strXML := strXML + '<soapenv:Envelope ' + Const_SOAP_ATTRIBUTTES + '>';
    strXML := strXML + '  <soapenv:Header>';
    strXML := strXML + '    <urn:Chave>';
    strXML := strXML + '      <token>'+ LDadosCarteira.LToken +'</token>';
    strXML := strXML + '      <convenio>'+ LDadosCarteira.LConvenio +'</convenio>';
    strXML := strXML + '    </urn:Chave>';
    strXML := strXML + '  </soapenv:Header>';
    strXML := strXML + '<soapenv:Body>';
    strXML := strXML + '  <urn1:gerarBoleto>';
    strXML := strXML + '    <boleto>';
    //Texto := Texto + '     <layout>'+'default'+'</layout>';
    strXML := strXML + MontaCorpo(ADadosDuplicata,ADadosCliente);
    strXML := strXML + '    </boleto>';
    strXML := strXML + '  </urn1:gerarBoleto>';
    strXML := strXML + '</soapenv:Body>';
    strXML := strXML + '</soapenv:Envelope>';

    LArquivoXml.Append(strXML);

    Result := LDadosCarteira.LPastaBancoCredisis + ADadosDuplicata.FieldByName('CTR_NUMDUP').AsString +
                                                   ADadosDuplicata.FieldByName('CTR_PARCEL').AsString +
                                                   ADadosDuplicata.FieldByName('CTR_ESPDOC').AsString +
                                                   ADadosDuplicata.FieldByName('CTR_CODEMP').AsString +
                                                   ADadosDuplicata.FieldByName('CTR_CODCLI').AsString + '.xml';

    LArquivoXml.SaveToFile(Result);

  Finally
    FreeAndNil(LArquivoXml);
  End;

end;

function TBancoCredisisAPI.RetornaDadosDaRequisicaoConsulta(ADataIni, ADataFim : String): String;
  Var
    LArquivoXml: TStringList;
    strXML : String;
Begin

  Try

    LArquivoXml := TStringList.Create;

    strXML := strXML + '<soapenv:Envelope ' + Const_SOAP_ATTRIBUTTES + '>';
    strXML := strXML + '  <soapenv:Header>';
    strXML := strXML + '    <urn:Chave>';
    strXML := strXML + '      <token>'+ LDadosCarteira.LToken +'</token>';
    strXML := strXML + '      <convenio>'+ LDadosCarteira.LConvenio +'</convenio>';
    strXML := strXML + '    </urn:Chave>';
    strXML := strXML + '  </soapenv:Header>';
    strXML := strXML + '<soapenv:Body>';
    strXML := strXML + '  <urn1:buscarBoletos>';
    strXML := strXML + '    <boleto>';
    strXML := strXML + Gera_PeriodoOperacoesConsulta(ADataIni, ADataFim);
    strXML := strXML + '    </boleto>';
    strXML := strXML + '  </urn1:buscarBoletos>';
    strXML := strXML + '</soapenv:Body>';
    strXML := strXML + '</soapenv:Envelope>';

    LArquivoXml.Append(strXML);

    Result := LDadosCarteira.LPastaBancoCredisis + 'RequisicaoConsulta.xml';

    LArquivoXml.SaveToFile(Result);

  Finally
    FreeAndNil(LArquivoXml);

  End;

end;

function TBancoCredisisAPI.RetornaTextoErroTratado(AErro: String): String;
begin
  Result := AErro;

  If Result.Contains('Field nomeFantasia of Pagador is not valid') Then
    Result := 'O campo Nome Fantasia do cliente da duplicata deve ser preenchido em ' +
              'Principal->Manutenção e Cadastros->Clientes';
end;

function TBancoCredisisAPI.RetornaXmlRegistroBoleto(AAutoIncrem: String): String;
  Var
    LRegBol : TUniQuery;
    LSql: String;
begin
  LRegBol := fCriaQuery(Nil);

  Try
    LSql := 'SELECT                        '+
            '  REG_JSOREC                  '+
            'FROM                          '+
            '  REGBOL                      '+
            'WHERE REG_DUPLIC = :DUPLIC    '+
            '  AND REG_EXCEPT IS NULL      '+
            '  AND REG_JSOREC IS NOT NULL  '+
            'ORDER BY REG_DTAREG DESC,     '+
            '  REG_HRAREG DESC             ';
    Try
      LRegBol.Close;
      LRegBol.SQL.Clear;
      LRegBol.SQL.Add(LSql);
      LRegBol.ParamByName('DUPLIC').AsString := AAutoIncrem;
      LRegBol.Open;
      Result := LRegBol.FieldByName('REG_JSOREC').AsString;

      If fEmptyStr(Result) Or (LRegBol.RecordCount > 1) Then
      Begin
        Result := EncontrarXmlRegistroBoleto(AAutoIncrem);
      End;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  Finally
    FreeAndNil(LRegBol);
  End;
end;

function TBancoCredisisAPI.fGetTagXML(ATag, AXML: String): String;
var LTagIni,
    LTagFin : String;
    LPosIni,
    LPosFin : Integer;
begin
  LTagIni := ATag;
  LTagFin := '/' + ATag;

  If (Pos(LTagIni, AXML) = 0) Then
    Exit;

  If (Pos(LTagFin, AXML) = 0) then
    Exit;

  LPosIni := Pos(LTagIni, AXML) + Length(LTagIni);
  LPosFin := Pos(LTagFin, AXML);
  Result  := Copy(AXML, LPosIni+1, (LPosFin - LPosIni)-2);
end;

function TBancoCredisisAPI.RetornaValorString(AValor: String;
  ATamanho: Integer): String;
begin
  Result := AValor;

  If Result.IsEmpty Then
    Exit;

  If ATamanho > 0 Then
    Result := LeftStr(Result, ATamanho);

  Result := fRemoveAcento(Result);
  Result := fTiraCaracEspeciais(Result);
end;

function TBancoCredisisAPI.VerificaSeADuplicataExisteCadrec(ABoleto: TRetornoPesquisaBancoCredisisApi;out ADuplicata: TDuplicataCtr): Boolean;
  Var
    LPesquisa: TUniQuery;
begin
  ADuplicata.strAutoIn := EmptyStr;
  ADuplicata.strNumDup := EmptyStr;
  ADuplicata.strParcel := EmptyStr;
  ADuplicata.strEspdoc := EmptyStr;
  ADuplicata.strCodEmp := EmptyStr;
  ADuplicata.strCodCli := EmptyStr;

  Try
    LPesquisa := fCriaQuery;
    LPesquisa.SQL.Text := 'SELECT AUTOINCREM, CTR_NUMDUP, CTR_CODEMP,     ' +
                          'CTR_PARCEL, CTR_ESPDOC, CTR_CODCLI, CTR_CARTEI ' +
                          'FROM CADREC                                    ' +
                          'WHERE CTR_NOSNUM=:NOSNUM                       ' +
                          '  AND CTR_BCOENV=:BCOENV                       ' +
                          '  AND CTR_DTAVEN=:DTAVEN                       ' +
                          '  AND CTR_SEQBAI=0                             ';

    LPesquisa.ParamByName('NOSNUM').AsString   := ABoleto.NossoNumero;
    LPesquisa.ParamByName('BCOENV').AsString   := '097';
    LPesquisa.ParamByName('DTAVEN').AsDateTime := StrToDate(ABoleto.ABoletoDataVencimento);

    LPesquisa.Open;

    Result := Not LPesquisa.IsEmpty;
    If Not Result Then
      Exit;

    ADuplicata.strAutoIn := LPesquisa.FieldByName('AUTOINCREM').AsString;
    ADuplicata.strNumDup := LPesquisa.FieldByName('CTR_NUMDUP').AsString;
    ADuplicata.strParcel := LPesquisa.FieldByName('CTR_PARCEL').AsString;
    ADuplicata.strEspdoc := LPesquisa.FieldByName('CTR_ESPDOC').AsString;
    ADuplicata.strCodEmp := LPesquisa.FieldByName('CTR_CODEMP').AsString;
    ADuplicata.strCodCli := LPesquisa.FieldByName('CTR_CODCLI').AsString;

    If LPesquisa.RecordCount > 1 Then
    Begin
      LPesquisa.Filter := 'CTR_CARTEI=' + LDadosCarteira.LCarteiraBanco.QuotedString;
      LPesquisa.Filtered := True;

      If Not LPesquisa.IsEmpty Then
      Begin
        ADuplicata.strAutoIn := LPesquisa.FieldByName('AUTOINCREM').AsString;
        ADuplicata.strNumDup := LPesquisa.FieldByName('CTR_NUMDUP').AsString;
        ADuplicata.strParcel := LPesquisa.FieldByName('CTR_PARCEL').AsString;
        ADuplicata.strEspdoc := LPesquisa.FieldByName('CTR_ESPDOC').AsString;
        ADuplicata.strCodEmp := LPesquisa.FieldByName('CTR_CODEMP').AsString;
        ADuplicata.strCodCli := LPesquisa.FieldByName('CTR_CODCLI').AsString;
      End;
    End;
  Finally
    FreeAndNil(LPesquisa);
  End;
end;

function TBancoCredisisAPI.fRetornaCarteiraBoleto(ABoleto: TRetornoPesquisaBancoCredisisApi): String;
  Var
    LPesquisa, LPesquisa2: TUniQuery;
begin

  Result := '';

  Try
    LPesquisa := fCriaQuery;

    LPesquisa.SQL.Text := 'SELECT AUTOINCREM, CTR_CODCLI, CTR_CARTEI ' +
                          'FROM CADREC                               ' +
                          'WHERE CTR_NOSNUM=:NOSNUM                  ' +
                          '  AND CTR_BCOENV=:BCOENV                  ' +
                          '  AND CTR_DTAVEN=:DTAVEN                  ' +
                          '  AND CTR_SEQBAI=0                        ';

    LPesquisa.ParamByName('NOSNUM').AsString   := ABoleto.NossoNumero;
    LPesquisa.ParamByName('BCOENV').AsString   := '097';
    LPesquisa.ParamByName('DTAVEN').AsDateTime := StrToDate(ABoleto.ABoletoDataVencimento);

    LPesquisa.Open;

    If Not LPesquisa.IsEmpty Then
    Begin

      LPesquisa2 := fCriaQuery;

      LPesquisa2.SQL.Text := 'SELECT SIS_VALCFG FROM CFGBAN WHERE SIS_CHAVE_ = :SISCHAVE AND SIS_CODCFG = ''NUMCART'' ';

      LPesquisa2.ParamByName('SISCHAVE').AsString   := LPesquisa.FieldByName('CTR_CARTEI').AsString;

      LPesquisa2.Open;

      Result := LPesquisa2.FieldByName('SIS_VALCFG').AsString;
    End;

  Finally
    FreeAndNil(LPesquisa);
  End;
end;

{ TRetornoPesquisaBancoDoBrasilApi }

function TRetornoPesquisaBancoCredisisApi.DataCreditoAsDate: String;
begin
  Result := Self.BoletoDataCredito.Replace('.','/');
end;

function TRetornoPesquisaBancoCredisisApi.DataMovimentoAsDate: String;
begin
  Result := Self.BoletoDataMovimento.Replace('.','/');
end;

function TRetornoPesquisaBancoCredisisApi.DataRegistroAsDate: String;
begin
  Result := Self.BoletoDataRegistro.Replace('.','/');
end;

function TRetornoPesquisaBancoCredisisApi.DataVencimentoAsDate: String;
 //Var
 //    dtVenc : String;
begin

 // dtVenc := copy(Self.BoletoDataVencimento,9,2) + '/' + copy(Self.BoletoDataVencimento,6,2) + '/' + copy(Self.BoletoDataVencimento,1,4);

  Result := Self.BoletoDataVencimento.Replace('.','/');

end;

function TRetornoPesquisaBancoCredisisApi.GetNossoNumero: String;
begin
  Result := RightStr(Self.BoletoNumeroBoletoBB,20);
end;

function TRetornoPesquisaBancoCredisisApi.ValorPagoCedente: String;
begin
  Result := Self.FDetalhamento.ValorCreditado;

 If (fStrToFloat(Result) = 0) Then
   Result := Self.BoletoValorPago;
end;

end.
