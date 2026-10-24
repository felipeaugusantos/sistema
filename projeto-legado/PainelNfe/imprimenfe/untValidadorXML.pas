unit untValidadorXML;

interface

uses
{$IF Defined(LINUX)}
  untUniClientDataSet, Uni, untLogDanfe,
{$ELSE}
  Graphics, DBCtrls, Controls, Forms, ComCtrls, StdCtrls, ExtCtrls,
  {$IF Defined(UNIDAC)}
    UniClientDataSet, Uni, MySQLUniProvider, UniProvider, untLogDanfe,
  {$ELSE}
   ZConnection, ZDataset, ZDbcIntfs,
  {$IFEND}
  Windows, Messages,
{$IFEND}
  SysUtils, Variants, Classes,  DateUtils,
  StrUtils, DB, MemDS, untConexaoBD, untUtil,
  NfeApiWSBean, untConfigNFE;

type
  TValidadorXML = class
  private
    ConexaoBD : TConexaoBD;
    FNumDoc: String;
    FEspDoc: String;
    FCodEmp: String;
    FSerie_: String;
    FAcesso: String;
    FArqXml: String;

    procedure pCarregaConfiguracoes;
    function fAbreDocumento(var ACodigoEmpresa, ANFComp: string; const AChaveAcesso: String): Boolean;
    function fExisteXmlNfe(AChaveAcesso: String): Boolean;
    function fValidaXML(var AArqXml: String): Boolean;
    function fDocumentoCompleto(AExisteXmlNfe, AExisteArqXml: Boolean): Boolean;
    function fRetornoOK(resultadoFit: TWSNfeFitRetorno): Boolean;
    function fRetornaIdNfeFit(ACodEmp, ANumDoc, ASerie, AEspDoc: String): String;
    function fNumDocEnvio(ANumDoc: String): String;
    function fRetornaXML: String;
    procedure pSalvarXML(AChaveAcesso, AXML: string);
  public
    constructor Create;
    destructor Destroy; override;
    function fExisteXML(var ACodigoEmpresa, AArqXml, ANFComp: String; const AChaveAcesso: String): Boolean;
  end;

  var
    objConfig: TConfiguracoesNFE;
    objConfigProxy: TConfiguracaoProxy;

implementation

uses
{$IF Defined(LINUX)}
  NFe.Modulo, untModuloReplicacao;
{$ELSE}
  untModulo, {$IF Defined(UNIDAC)} untModuloReplicacao, Vcl.Printers {$ELSE} untModuloReplicacaoZeos {$IFEND};
{$IFEND}

{ TValidadorXML }

constructor TValidadorXML.Create;
begin
  ConexaoBD := TConexaoBD.Create(frmModulo.Database);

  FNumDoc := '';
  FEspDoc := '';
  FCodEmp := '';
  FSerie_ := '';
  FAcesso := '';
  FArqXml := '';
end;

destructor TValidadorXML.Destroy;
begin
  ConexaoBD.Free;
end;

procedure TValidadorXML.pCarregaConfiguracoes;
begin
  objConfig := TConfiguracoesNFE.Create;

  objConfig.strFitLicenca       := ConexaoBD.CarregarCFGSIS('CITLIC');
  objConfig.strFitUsuario       := ConexaoBD.CarregarCFGSIS('CITUSU');
  objConfig.strFitSenha         := ConexaoBD.CarregarCFGSIS('CITSEN');
  objConfig.strFitUrlWebService := ConexaoBD.CarregarCFGSIS('CITURL');

  objConfigProxy.strFitUsuarioProxy := ConexaoBD.CarregarCFGSIS('CITUSP');
  objConfigProxy.strFitSenhaProxy   := ConexaoBD.CarregarCFGSIS('CITPSP');
  objConfigProxy.strFitProxy        := ConexaoBD.CarregarCFGSIS('CITPRX');
  objConfigProxy.strFitProxyByPass  := ConexaoBD.CarregarCFGSIS('CITPBP');
end;

function TValidadorXML.fAbreDocumento(var ACodigoEmpresa, ANFComp: string; const AChaveAcesso: String): Boolean;
var
  qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryAux := fCriaQuery(nil);
  Try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT * FROM ( ');

    qryAux.SQL.Add('SELECT ');
    qryAux.SQL.Add('  FIS_NUMDOC,');
    qryAux.SQL.Add('  FIS_ESPDOC,');
    qryAux.SQL.Add('  FIS_CODEMP,');
    qryAux.SQL.Add('  FIS_SERIE_,');
    qryAux.SQL.Add('  FIS_ACESSO,');
    qryAux.SQL.Add('  FIS_NFCOMP,');
    qryAux.SQL.Add('  NFE_ARQXML ');
    qryAux.SQL.Add(' FROM ');
    qryAux.SQL.Add('   CADFIS F ');
    qryAux.SQL.Add('    INNER JOIN LOGNFE N ON F.FIS_ACESSO = N.NFE_ACESSO ');
    qryAux.SQL.Add('     LEFT JOIN XMLNFE X ON F.FIS_ACESSO = X.NFE_ACESSO ');
    qryAux.SQL.Add('WHERE FIS_ACESSO = :ACESSO ');

    If fTabelaExiste('NFEIMP') Then
    Begin
      qryAux.SQL.Add('UNION ALL ');

      qryAux.SQL.Add('SELECT ');
      qryAux.SQL.Add('  FIS_NUMDOC,');
      qryAux.SQL.Add('  FIS_ESPDOC,');
      qryAux.SQL.Add('  FIS_CODEMP,');
      qryAux.SQL.Add('  FIS_SERIE_,');
      qryAux.SQL.Add('  FIS_ACESSO,');
      qryAux.SQL.Add('  FIS_NFCOMP,');
      qryAux.SQL.Add('  X.NFE_ARQXML ');
      qryAux.SQL.Add(' FROM ');
      qryAux.SQL.Add('   CADFIS F ');
      qryAux.SQL.Add('    INNER JOIN NFEIMP N ON F.FIS_ACESSO = N.NFE_ACESSO ');
      qryAux.SQL.Add('     LEFT JOIN XMLNFE X ON F.FIS_ACESSO = X.NFE_ACESSO ');
      qryAux.SQL.Add('WHERE FIS_ACESSO = :ACESSO ');
    End;

    qryAux.SQL.Add(') AS NFE_DADOS ');

    qryAux.ParamByName('ACESSO').AsString := AChaveAcesso;
    qryAux.Open;

    Result := (Not qryAux.IsEmpty);

    If Result Then
    Begin
      FNumDoc := qryAux.FieldByName('FIS_NUMDOC').AsString;
      FEspDoc := qryAux.FieldByName('FIS_ESPDOC').AsString;
      FCodEmp := qryAux.FieldByName('FIS_CODEMP').AsString;
      FSerie_ := qryAux.FieldByName('FIS_SERIE_').AsString;
      FAcesso := qryAux.FieldByName('FIS_ACESSO').AsString;
      ANFComp := qryAux.FieldByName('FIS_NFCOMP').AsString;
      FArqXml := qryAux.FieldByName('NFE_ARQXML').AsString;

      If ACodigoEmpresa <> FCodEmp Then
      Begin
        ACodigoEmpresa := FCodEmp;
        ConexaoBD.pSetaEmpresa(ACodigoEmpresa);
      End;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TValidadorXML.fExisteXmlNfe(AChaveAcesso: String): Boolean;
var
  qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  pLogImp('TValidadorXML.fExisteXmlNfe > '+AChaveAcesso);

  Result := (Not fEmptyStr(FArqXml));

  If (Not Result) Then
  Begin
    qryAux := fCriaQuery(nil);
    Try
      Try
        qryAux.Close;
        qryAux.SQL.Clear;

        qryAux.SQL.Add('SELECT NFE_ARQXML FROM XMLNFE ');
        qryAux.SQL.Add(' WHERE NFE_ACESSO = :ACESSO   ');
        qryAux.ParamByName('ACESSO').AsString := AChaveAcesso;
        qryAux.Open;

        If qryAux.IsEmpty And fCampoExiste('NFEIMP', 'NFE_STATUS') Then
        Begin
          qryAux.Close;
          qryAux.SQL.Clear;

          qryAux.SQL.Add('SELECT NFE_ARQXML FROM NFEIMP ');
          qryAux.SQL.Add(' WHERE NFE_ACESSO = :ACESSO   ');
          qryAux.SQL.Add('   AND NFE_STATUS = "AT"      ');
          qryAux.ParamByName('ACESSO').AsString := AChaveAcesso;
          qryAux.Open;
        End;

        Result := (Not qryAux.IsEmpty);

        If Result Then
          FArqXml := qryAux.FieldByName('NFE_ARQXML').AsString;
      Except
        On E: Exception Do
        Begin
         {$IF Defined(LINUX)}
          Writeln(E.Message);
         {$ENDIF}
          pLogImp(E.Message);
        End;
      End;
    Finally
      FreeAndNil(qryAux);
    End;
  End;

  pLogImp('TValidadorXML.fExisteXmlNfe < = ' + IIF(Result, 'True', 'False'));
end;

function TValidadorXML.fRetornaIdNfeFit(ACodEmp, ANumDoc, ASerie, AEspDoc: String): String;
begin
  If AEspDoc = 'IF' Then
  Begin
    Result :=  '88' + ACodEmp+fStrZero(RightStr(ANumDoc,9),9)+ASerie;
  End
  Else
    Result := ACodEmp+fStrZero(ANumDoc,9)+ASerie;
end;

function TValidadorXML.fNumDocEnvio(ANumDoc: String): String;
begin
  Result := RightStr(ANumDoc, 9);
end;

procedure TValidadorXML.pSalvarXML(AChaveAcesso, AXML: string);
Var
  qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryAux := fCriaQuery(Nil);
  Try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT COUNT(*) AS QTD FROM XMLNFE ');
    qryAux.SQL.Add('WHERE NFE_ACESSO = :CHAVE ');
    qryAux.ParamByName('CHAVE').AsString := AChaveAcesso;
    qryAux.Open;

    If qryAux.FieldByName('QTD').AsInteger = 0 Then
    Begin
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('INSERT INTO XMLNFE SET NFE_ARQXML = :XML, NFE_ACESSO = :CHAVE ');
      qryAux.ParamByName('CHAVE').AsString := AChaveAcesso;
      qryAux.ParamByName('XML').AsString := AnsiReplaceStr(AnsiReplaceStr(AXML, #13#10, ' '), #10, ' ');
      qryAux.ExecSQL;
    End
    Else
    Begin
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('UPDATE XMLNFE SET NFE_ARQXML = :XML ');
      qryAux.SQL.Add('WHERE NFE_ACESSO = :CHAVE ');
      qryAux.ParamByName('CHAVE').AsString := AChaveAcesso;
      qryAux.ParamByName('XML').AsString := AnsiReplaceStr(AnsiReplaceStr(AXML, #13#10, ' '), #10, ' ');
      qryAux.ExecSQL;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TValidadorXML.fRetornoOK(resultadoFit: TWSNfeFitRetorno): Boolean;
Var
  intStatus: Integer ;
begin
  If AnsiStartsText('NFE-RET-ENVIO-DPEC', resultadoFit.Texto) Then
  Begin
    intStatus := StrToIntDef(fGetValorLinha(resultadoFit.Texto, '|', 3), -1);
  End
  Else If AnsiStartsText('NFE-RET-CONS-SIT', resultadoFit.Texto) Then
  Begin
    intStatus := StrToIntDef(fGetValorLinha(resultadoFit.Texto, '|', 10), -1);
  End
  Else
  Begin
    intStatus := StrToIntDef(fGetValorLinha(resultadoFit.Texto, '|', 8), -1);
  End;

  Result := (intStatus in [100, 150, 155]);
end;

function TValidadorXML.fRetornaXML: String;
var
  fitWrapper: TWSNFeFitWrapper;
  retornoFit: TWSNfeFitRetorno;
  strIdNota: String;
begin
  pLogImp('TValidadorXML.fRetornaXML >');

  fitWrapper := TWSNFeFitWrapper.Create;
  fitWrapper.modeEnvSoap := fGetModeEnvSoap(ConexaoBD.CarregarCFGSIS('MDEVAR'));
  Try
    fitWrapper.pSetaConfiguracoes(objConfig, objConfigProxy);

    If (FEspDoc = 'IF') Then
    Begin
      strIdNota := fRetornaIdNfeFit(FCodEmp, fNumDocEnvio(FNumDoc), FSerie_, FEspDoc);
      retornoFit := fitWrapper.fConsultaSituacaoId(strIdNota+'|65' );
    End
    Else
    Begin
      retornoFit := fitWrapper.fConsultaSituacaoId(fNumDocEnvio(FNumDoc), FSerie_, FCodEmp);
    End;

    If fRetornoOK(retornoFit) Then
    Begin
      strIdNota := fRetornaIdNfeFit(FCodEmp, fNumDocEnvio(FNumDoc), FSerie_, FEspDoc);

      Result := fitWrapper.fDownloadXml(FAcesso, strIdNota, fNumDocEnvio(FNumDoc), FEspDoc);
    End;

  Finally
    FreeAndNil(fitWrapper);
    If Assigned(retornoFit) Then
      FreeAndNil(retornoFit);
  End;
  pLogImp('TValidadorXML.fRetornaXML <');
end;

function TValidadorXML.fDocumentoCompleto(AExisteXmlNfe, AExisteArqXml: Boolean): Boolean;
begin
  Result := False;

  If not AExisteXmlNfe Then
    Exit;

  If not AExisteArqXml Then
    Exit;

  Result := True;
end;

function TValidadorXML.fValidaXML(var AArqXml: String): Boolean;
var
  LExisteXmlNfe: Boolean;
  LExisteArqXml: Boolean;
  LArqXml: String;
begin
  If (FEspDoc = 'IF') Then
  Begin
    If (ConexaoBD.fUsaSat) Or (ConexaoBD.CarregarCFGSIS('USAOFF') = 'S') Then
    Begin
      Result := True;
      Exit;
    End;
  End;

  LExisteXmlNfe := (fExisteXmlNfe(FAcesso));
  LExisteArqXml := (Not fEmptyStr(FArqXml));

  Result := fDocumentoCompleto(LExisteXmlNfe, LExisteArqXml);

  If Result Then
  Begin
    AArqXml := FArqXml;
  End
  Else
  Begin
    pCarregaConfiguracoes;

    LArqXml := fRetornaXML;

    Result := (Not fEmptyStr(LArqXml));

    If Result Then
    Begin
      pSalvarXML(FAcesso, LArqXml);
      AArqXml := LArqXml;
    End;
  End;
end;

function TValidadorXML.fExisteXML(var ACodigoEmpresa, AArqXml, ANFComp: String; const AChaveAcesso: String): Boolean;
const
  TIMEOUT = 120;
var
  LBegin: TDateTime;
begin
  Result := False;
  pLogImp('TValidadorXML.fExisteXml > ' + Format('Buscando chave de acesso %s no Livro Fiscal.', [AChaveAcesso]));

  Try
    AArqXml := '';
    ANFComp := '';

    If (AChaveAcesso = EmptyStr) Then
      Exit;

    Try
      ConexaoBD.pSetaEmpresa(ACodigoEmpresa);
      LBegin := nOw();
      Repeat
       {$IFDEF UNIDAC}
        objLogDanfe.strChaAce := AChaveAcesso;
       {$ENDIF}
        Result := fAbreDocumento(ACodigoEmpresa, ANFComp, AChaveAcesso);
        If Not Result Then
        Begin
          pLogImp('TValidadorXML.fExisteXml > ' + Format('Chave de acesso %s ainda não encontrada no Livro Fiscal.', [AChaveAcesso]));
          Sleep(2000);
        End;
        If SecondsBetween(nOw(), LBegin) >= TIMEOUT Then
          Break;
      Until Result;
      If Result Then
        Result := fValidaXML(AArqXml);
    Except
      Result := False;
    End;
  Finally
    pLogImp('TValidadorXML.fExisteXml < Documento completo LOGNFE/XMLNFE/CADFIS = '+ IIF(Result, 'True', 'False'));
  End;
end;

end.
