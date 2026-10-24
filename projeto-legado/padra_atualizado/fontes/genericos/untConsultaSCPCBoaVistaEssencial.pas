unit untConsultaSCPCBoaVistaEssencial;

interface

uses
   Classes, XMLDoc, XMLIntf, System.SysUtils, System.Rtti, System.StrUtils,
   System.Generics.Collections, idHTTP, IdSSLOpenSSL, EditFocus, untConsultaSCPC,
   untQckConsultaSCPC, frxClass, UniClientDataSet, Data.DB, untConstantes,
   untFuncoesGenerica,Forms,Winapi.Windows,untGravando;


type
  TConsultaSCPCBoaVistaEssencial = class(TConsultaSCPC)
  private
    FHandleRequisicoes: THandle;
    IndyExecute :  function (const AMetodo, AUrl : String; ABody: String; out ARetorno: String): Integer; stdcall;
    FXmlRetorno: TXMLDocument;
    FLogin: String;
    FSenha: String;
    FAmbiente : String;
    FUrl: String;
    FLoginAutomatico: Boolean;
    FRetorno : String;
    FQtdChequeSemFundo : Integer;
    FQtdProtesto : Integer;
    FTipoCredito : String;
    FDefineRiscoPositivo: Boolean;
    FDocumento : String;
    FSucesso : Boolean;
    function fConsultaServico(strDocumento: String): Boolean;
    function DefineRiscoPositivo(ACnpj: String): Boolean;
    function AcertaEssencialPositivo(ACpf: String): Boolean;
    Procedure DefineAmbiente;
    procedure CarregaDllIndy;
    procedure ConverterXmlParaTexto(XMLNode: IXMLNode);
    function RetornaTextoFormatado(XMLNode: IXMLNode): String;
    function SepararPalavras(XMLNode: IXMLNode): String; Overload;
    function SepararPalavras(AText: String): String;Overload;
    procedure CalculaTotais(XMLNode: IXMLNode);
    function CorrigirOrtografia(AText: String): String;
    function Center(AText: String; ASize: Integer = 87): String;
    function RetornaTipoCredito: String;
    procedure RealizarConsulta;
  protected
    function fGetMsgErro: String; override;
    function fGetRelatorio: String; override;
    function fGetQtdProtestos: Integer; override;
    function fGetQtdCheques: Integer; override;
  public
    constructor Create(AOwner: TComponent); reintroduce;
    destructor Destroy; override;
    function fRealizarConsulta(strDocumento, strNomeEmpresa, strCidade, strUF: String; blnSCPCAutomatico: Boolean): Boolean; override;
    procedure pSaveToFile(Const strFileName: String); override;
  end;

implementation

uses untFuncoes, untFuncoesSimples;

{ TConsultaSCPCBoaVistaEssencial }

function TConsultaSCPCBoaVistaEssencial.Center(AText: String;ASize: Integer = 87): String;
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

procedure TConsultaSCPCBoaVistaEssencial.ConverterXmlParaTexto(XMLNode: IXMLNode);
 var
  NodeText : string;
  I : Integer;
begin

  if XMLNode.NodeType <> ntElement then
    Exit;

  CalculaTotais(XMLNode);

  NodeText := RetornaTextoFormatado(XMLNode);

  If Not XMLNode.IsTextElement And XMLNode.HasChildNodes Then
  Begin
    FRetorno := FRetorno + '---------------------------------------------------------------------------------------' + #13#10;
    FRetorno := FRetorno + Center(AnsiUpperCase(NodeText),87) + #13#10;
    FRetorno := FRetorno + '---------------------------------------------------------------------------------------' + #13#10;
  End Else FRetorno := FRetorno + NodeText + #13#10;


  If XMLNode.HasChildNodes then
  Begin
    for I := 0 to XMLNode.ChildNodes.Count - 1 do
    Begin
      ConverterXmlParaTexto(XMLNode.ChildNodes[I]);
    End;
  End;

end;


function TConsultaSCPCBoaVistaEssencial.CorrigirOrtografia(
  AText: String): String;
begin
  Result := AText;

  If AText.Equals('DefinePositivoRisco') Then Result := 'Define Risco Positivo'
  Else If AText.Equals('Identificacao basico') Then Result := 'Identificação basica'
  Else If AText.Equals('Localizacao basico') Then Result := 'Localização basica'
  Else If AText.Equals('Valor Acomulado') Then Result := 'Valor Acumulado'
  Else If AText.Equals('Cheque devolvido informado usuario') Then Result := 'Cheque devolvido informado pelo usuario';
end;

constructor TConsultaSCPCBoaVistaEssencial.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  CarregaDllIndy;

  FXmlRetorno := TXMLDocument.Create(Self);
  FLogin := fCfgSis('LOGBVE');
  FSenha := fCfgSis('SENBVE');
  FLoginAutomatico := False;
  FDocumento := '';
  FSucesso := False;
end;

function TConsultaSCPCBoaVistaEssencial.AcertaEssencialPositivo(ACpf: String): Boolean;
  Var
    xmlEnvio: IXMLDocument;
    LStatus : Integer;
    LCaminhoSaveXml : String;
    LRetorno: String;
begin
  Result := False;

  Try
    Try
      xmlEnvio := TXMLDocument.Create(Self);
      xmlEnvio.Active := True;
      xmlEnvio.Version := '1.0';
      xmlEnvio.Encoding := 'UTF-8';
      xmlEnvio.StandAlone := 'yes';
      xmlEnvio.DocumentElement := xmlEnvio.CreateElement('acertaPositivoContratoEntrada', 'http://boavistaservicos.com.br/familia/acerta/positivo/pf');
      xmlEnvio.DocumentElement.AddChild('usuario').Text := FLogin;
      xmlEnvio.DocumentElement.AddChild('senha').Text   := FSenha;
      xmlEnvio.DocumentElement.AddChild('cpf').Text     := ACpf;
      xmlEnvio.DocumentElement.AddChild('tipoCredito').Text := RetornaTipoCredito;

      LCaminhoSaveXml := ExtractFilePath(Application.ExeName) + 'BOA VISTA SCPC\' + ACpf + '.xml';
      xmlEnvio.SaveToFile(LCaminhoSaveXml);


      LStatus := IndyExecute('POST',FUrl,LCaminhoSaveXml,LRetorno);
       //LStatus := 200;

      If LStatus = 200 Then
      Begin
        //FXmlRetorno.LoadFromFile('C:\Users\matheus.alacrino\Desktop\testeboavista.xml');
        FXmlRetorno.LoadFromXML(LRetorno);
        Result := True;
      End;

    Except
      On E:EIdHTTPProtocolException Do
      Begin
         Raise Exception.Create('Ocorreu um erro ao realizar a consulta na API do Boa Vista.' + #13 +
                                'Verifique se as chaves de autenticação da conta estão liberadas para utilização no ambiente de ' +
                                 FAmbiente + '.' + ' Erro:' + E.ErrorMessage);
      End;

      On E: Exception Do
      Begin
        Raise Exception.Create('Ocorreu um erro ao realizar a consulta na API do Boa Vista.' + #13 +
                                'Verifique se as chaves de autenticação da conta estão liberadas para utilização no ambiente de ' +
                                 FAmbiente + '.' + ' Erro:' + E.Message);
      End;

    End;

  Finally

    If FileExists(LCaminhoSaveXml) Then
      System.SysUtils.DeleteFile(LCaminhoSaveXml);
  End;
end;

procedure TConsultaSCPCBoaVistaEssencial.CalculaTotais(
  XMLNode: IXMLNode);
begin

  If Not XMLNode.IsTextElement Then
    Exit;

  If (Pos(XMLNode.NodeName,'total_cheques_sem_fundos') > 0) Then
    FQtdChequeSemFundo := XMLNode.NodeValue;

  If (Pos(XMLNode.NodeName,'total_protestos') > 0) Then
    FQtdProtesto := XMLNode.NodeValue;
end;

procedure TConsultaSCPCBoaVistaEssencial.CarregaDllIndy;
  Var
    LCaminhoDll : String;
    LPastaSaveXml: String;
begin
  LCaminhoDll := ExtractFilePath(Application.ExeName) + 'IndyHttpBoaVista.dll';

  If Not FileExists(LCaminhoDll) Then
    Raise Exception.Create('O arquivo ' + LCaminhoDll + ' não foi encontrado na pasta do AUTCOM. Operação cancelada!');

  FHandleRequisicoes := LoadLibrary(PChar(LCaminhoDll));
  IndyExecute := GetProcAddress(FHandleRequisicoes, 'Execute');


  LPastaSaveXml := ExtractFilePath(Application.ExeName)+ 'BOA VISTA SCPC\';
  If Not DirectoryExists(LPastaSaveXml) Then
    CreateDir(ExtractFilePath(LPastaSaveXml));

end;

procedure TConsultaSCPCBoaVistaEssencial.DefineAmbiente;
begin

  If FDefineRiscoPositivo Then
  Begin
    FAmbiente := 'Produção';
    FUrl := 'https://define.bvsnet.com.br/DefinePositivoXml/servicos/defineRiscoPositivo/v3';

    If fCfgSis('BVHOMO',varBoolean) Then
    Begin
      FAmbiente := 'Homologação';
      FUrl := 'https://definehom.bvsnet.com.br/DefinePositivoXml/servicos/defineRiscoPositivo/v3';
    End;
  End
  Else
  Begin

    FAmbiente := 'Produção';
    FUrl := 'https://acerta.bvsnet.com.br/FamiliaAcertaPositivoPFXmlWeb/essencial/v2';

    If fCfgSis('BVHOMO',varBoolean) Then
    Begin
      FAmbiente := 'Homologação';
      FUrl := 'https://acertahom.bvsnet.com.br/FamiliaAcertaPositivoPFXmlWeb/essencial/v2';
    End;

  End;

end;

function TConsultaSCPCBoaVistaEssencial.DefineRiscoPositivo(ACnpj: String): Boolean;
  Var
    xmlEnvio: IXMLDocument;
    LStatus : Integer;
    LCaminhoSaveXml : String;
    LRetorno: String;
begin
  Result := False;

  Try
    Try
      xmlEnvio := TXMLDocument.Create(Self);
      xmlEnvio.Active := True;
      xmlEnvio.Version := '1.0';
      xmlEnvio.Encoding := 'UTF-8';
      xmlEnvio.StandAlone := 'yes';
      xmlEnvio.DocumentElement := xmlEnvio.CreateElement('defineRiscoPositivoContratoEntradaXml', 'http://boavistaservicos.com.br/define/risco/positivo/entrada');
      xmlEnvio.DocumentElement.AddChild('usuario').Text := FLogin;
      xmlEnvio.DocumentElement.AddChild('senha').Text   := FSenha;
      xmlEnvio.DocumentElement.AddChild('cnpj').Text    := ACnpj;

      LCaminhoSaveXml := ExtractFilePath(Application.ExeName) + 'BOA VISTA SCPC\' + ACnpj + '.xml';
      xmlEnvio.SaveToFile(LCaminhoSaveXml);


      LStatus := IndyExecute('POST',FUrl,LCaminhoSaveXml,LRetorno);
      //LStatus := 200;

      If LStatus = 200 Then
      Begin
        //FXmlRetorno.LoadFromFile('C:\Users\matheus.alacrino\Desktop\testeboavista.xml');
        FXmlRetorno.LoadFromXML(LRetorno);
        Result := True;
      End;

    Except
      On E:EIdHTTPProtocolException Do
      Begin
         Raise Exception.Create('Ocorreu um erro ao realizar a consulta na API do Boa Vista.' + #13 +
                                'Verifique se as chaves de autenticação da conta estão liberadas para utilização no ambiente de ' +
                                 FAmbiente + '.' + ' Erro:' + E.ErrorMessage);
      End;

      On E: Exception Do
      Begin
        Raise Exception.Create('Ocorreu um erro ao realizar a consulta na API do Boa Vista.' + #13 +
                                'Verifique se as chaves de autenticação da conta estão liberadas para utilização no ambiente de ' +
                                 FAmbiente + '.' + ' Erro:' + E.Message);
      End;

    End;

  Finally

    If FileExists(LCaminhoSaveXml) Then
      System.SysUtils.DeleteFile(LCaminhoSaveXml);
  End;
end;

destructor TConsultaSCPCBoaVistaEssencial.Destroy;
begin

  If FHandleRequisicoes <> 0 Then
  Begin
    FHandleRequisicoes := 0;
    FreeLibrary(FHandleRequisicoes);
  End;

  FreeAndNil(FXmlRetorno);
  inherited;
end;

function TConsultaSCPCBoaVistaEssencial.fConsultaServico(strDocumento: String): Boolean;
begin
  Result := False;

  If Not FLoginAutomatico Then
  Begin
    FLogin := '';
    FSenha := '';
  End;

  If fEmptyStr(FLogin) Or fEmptyStr(FSenha) Then
  Begin
    If Not fInputQueryTipo('Boa Vista Serviços', 'Login:', FLogin, ttInteiro) Then
      Exit;

    If Not fInputQueryTipo('Boa Vista Serviços', 'Senha:', FSenha, ttAlfanumerico, '*') Then
      Exit;
  End;

  FTipoCredito := RightStr(strDocumento,1);
  FDefineRiscoPositivo := (strDocumento.Length > 12);

  If Not FDefineRiscoPositivo Then
    strDocumento := Copy(strDocumento,1,strDocumento.Length - 1);

  DefineAmbiente;

  If FDefineRiscoPositivo Then Result := DefineRiscoPositivo(strDocumento)
  Else Result := AcertaEssencialPositivo(strDocumento);

end;


function TConsultaSCPCBoaVistaEssencial.fGetMsgErro: String;
begin
  Result := '';
end;

function TConsultaSCPCBoaVistaEssencial.fGetQtdCheques: Integer;
begin
  Result := FQtdChequeSemFundo;
end;

function TConsultaSCPCBoaVistaEssencial.fGetQtdProtestos: Integer;
begin
  Result := FQtdProtesto;
end;

function TConsultaSCPCBoaVistaEssencial.fGetRelatorio: String;
begin
  FRetorno := '';
  FQtdChequeSemFundo := 0;
  FQtdProtesto:= 0;

  ConverterXmlParaTexto(FXmlRetorno.DocumentElement);
  Result := FRetorno;
end;

function TConsultaSCPCBoaVistaEssencial.fRealizarConsulta(strDocumento, strNomeEmpresa, strCidade, strUF: String; blnSCPCAutomatico: Boolean): Boolean;
begin
  FLoginAutomatico := blnSCPCAutomatico;
  FDocumento :=  strDocumento;
  TfrmGravando.fExecutarModalA(RealizarConsulta,'Aguarde... Realizando consulta.', '');
  Result := FSucesso;
end;


procedure TConsultaSCPCBoaVistaEssencial.pSaveToFile(const strFileName: String);
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


procedure TConsultaSCPCBoaVistaEssencial.RealizarConsulta;
begin
  FSucesso := fConsultaServico(FDocumento);
end;

function TConsultaSCPCBoaVistaEssencial.RetornaTextoFormatado(
  XMLNode: IXMLNode): String;
begin
  Result := SepararPalavras(XMLNode);

  If Pos(':',Result) > 0 Then
    Result := Copy(Result, Pos(':',Result) + 1, Result.Length);

  If XMLNode.IsTextElement Then
    Result := Result + ': ' + XMLNode.NodeValue;

  If Not XMLNode.HasChildNodes Then
    Result := Result + ': ';

  Result := UpperCase(Copy(Result,1,1)) + Copy(Result,2,Length(Result));

  Result := CorrigirOrtografia(Result);
end;

function TConsultaSCPCBoaVistaEssencial.RetornaTipoCredito: String;
begin
  If FTipoCredito.Equals('0') Then Result := 'CD'
  Else If FTipoCredito.Equals('1') Then Result := 'CP'
  Else If FTipoCredito.Equals('2') Then Result := 'CV'
  Else If FTipoCredito.Equals('3') Then Result := 'CC'
  Else If FTipoCredito.Equals('4') Then Result := 'CH'
  Else If FTipoCredito.Equals('5') Then Result := 'OU';
end;

function TConsultaSCPCBoaVistaEssencial.SepararPalavras(AText: String): String;
Var
  I: Integer;
begin
  Result := '';

  If fEmptyStr(AText) Then
    Exit;

  For I := 1 to Length(AText) do
  Begin
    If CharInSet(AText[I], ['A'..'Z']) then
      Result := Result +' '+ AText[I]
    Else
      Result := Result + AText[I];
  End;

End;

function TConsultaSCPCBoaVistaEssencial.SepararPalavras(
  XMLNode: IXMLNode): String;
begin
  Result := XMLNode.NodeName.Replace('_',' ');
  Result := SepararPalavras(Result);
end;

end.
