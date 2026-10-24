unit untDisparaEmailAutEnt;

interface

uses
  Uni,
  Data.DB,
  System.Classes,
  untTypesSistema,
  System.SysUtils;

resourcestring
  sqlFixedCon = 'SELECT                                                       '+
                '    CFG_SENEMA AS SENHA,                                     '+
                '    CFG_EMAIL_ AS EMAIL,                                     '+
                '    CFG_EMALOG AS LOGIN,                                     '+
                '    CFG_REMETE AS REMETE,                                    '+
                '    CFG_ASSB64 AS IMGASS,                                    '+
                '    CFG_ASSTXT AS TXTASS,                                    '+
                '    PRV_CODPRV AS CODPRV,                                    '+
                '    PRV_PORPRV AS PORSMT,                                    '+
                '    PRV_URSMTP AS SERSMT,                                    '+
                '    PRV_PTIMAP AS PORIMA,                                    '+
                '    PRV_URIMAP AS SERIMA,                                    '+
                '    PRV_LIMARQ AS LIMARQ,                                    '+
                '    PRV_SSLSAI AS SSLSAI,                                    '+
                '    PRV_SSLENT AS SSLENT                                     '+
                '  FROM                                                       '+
                '    EMASAI                                                   '+
                '    INNER JOIN CFGEMA ON CFG_SEQGER = EMASAI.AUTOINCREM      '+
                '    INNER JOIN CADPRV ON PRV_CODPRV = CFG_CODPRV             '+
                ' WHERE                                                       '+
                '    EMA_CODIGO = "%s" AND                                    '+
                '    EMA_CODGRU = "%s" AND                                    '+
                '    EMA_CODEMP = "%s" AND                                    '+
                '    EMA_ENTSAI = "E"                                         ';

  sqlUserConn = 'SELECT                                                       '+
                '    OPE_PRVSEN AS SENHA,                                     '+
                '    OPE_E_MAIL AS EMAIL,                                     '+
                '    OPE_EMALOG AS LOGIN,                                     '+
                '    OPE_E_NOME AS REMETE,                                    '+
                '    PRV_CODPRV AS CODPRV,                                    '+
                '    PRV_PORPRV AS PORSMT,                                    '+
                '    PRV_URSMTP AS SERSMT,                                    '+
                '    PRV_PTIMAP AS PORIMA,                                    '+
                '    PRV_URIMAP AS SERIMA,                                    '+
                '    PRV_LIMARQ AS LIMARQ,                                    '+
                '    PRV_SSLSAI AS SSLSAI,                                    '+
                '    PRV_SSLENT AS SSLENT,                                    '+
                '    ASS_IMGB64 AS IMGASS,                                    '+
                '    ASS_TEXTO_ AS TXTASS                                     '+
                '  FROM                                                       '+
                '    CADOPE O                                                 '+
                '    INNER JOIN CADPRV C ON C.PRV_CODPRV = O.OPE_CODPRV       '+
                '    LEFT  JOIN OPEASS A ON A.ASS_CODOPE = O.OPE_CODOPE       '+
                '  WHERE O.OPE_CODOPE = "%s"                                  ';

  sqlEmprConn = 'SELECT                                                       '+
                '    EML_PRVSEN AS SENHA,                                     '+
                '    EML_E_MAIL AS EMAIL,                                     '+
                '    EML_EMALOG AS LOGIN,                                     '+
                '    EML_E_NOME AS REMETE,                                    '+
                '    PRV_CODPRV AS CODPRV,                                    '+
                '    PRV_PORPRV AS PORSMT,                                    '+
                '    PRV_URSMTP AS SERSMT,                                    '+
                '    PRV_PTIMAP AS PORIMA,                                    '+
                '    PRV_URIMAP AS SERIMA,                                    '+
                '    PRV_LIMARQ AS LIMARQ,                                    '+
                '    PRV_SSLSAI AS SSLSAI,                                    '+
                '    PRV_SSLENT AS SSLENT,                                    '+
                '    EML_IMGB64 AS IMGASS,                                    '+
                '    EML_TEXTO_ AS TXTASS                                     '+
                '  FROM                                                       '+
                '    OPEEML O                                                 '+
                '    INNER JOIN CADPRV C ON C.PRV_CODPRV = O.EML_CODPRV       '+
                '  WHERE O.EML_CODOPE = "%s"                                  '+
                '    AND O.EML_CODEMP = "%s"                                  ';

  sqlModEmail = 'SELECT                                                       '+
                '    MOD_ASSUNT,                                              '+
                '    MOD_MODELO,                                              '+
                '    MODEMA.AUTOINCREM                                        '+
                '  FROM                                                       '+
                '    EMASAI                                                   '+
                '    INNER JOIN MODEMA ON MOD_SEQGER = EMASAI.AUTOINCREM      '+
                ' WHERE                                                       '+
                '    EMA_CODIGO = "%s" AND                                    '+
                '    EMA_CODGRU = "%s" AND                                    '+
                '    EMA_CODEMP = "%s" AND                                    '+
                '    EMA_ENTSAI = "E"                                         ';

  sqlFollowUp = 'SELECT                                                       '+
                '    P.PCG_NUMPED AS PEDCOM,                                  '+
                '    P.PCG_ESPDOC AS ESPCOM,                                  '+
                '    CONCAT(P.PCG_CODEMP,"-",COM.EMP_NOMEMP) AS EMPCOM,       '+
                '    IF(IFNULL(P.PCG_EMPDES,"") = "", "",                     '+
                '       CONCAT(P.PCG_EMPDES,"-",DES.EMP_NOMEMP)) AS EMPDES,   '+
                '    P.PCG_TOTGER AS TOTCOM,                                  '+
                '    P.PCG_DTAPED AS DTAEMI,                                  '+
                '    P.PCG_DTAENT AS DTAENT,                                  '+
                '    P.PCG_CODFOR AS CODFOR,                                  '+
                '    C.FOR_NOMFOR AS RAZFOR,                                  '+
                '    C.FOR_NOMFAN AS FANFOR,                                  '+
                '    C.FOR_C_G_C_ AS CGCFOR,                                  '+
                '    C.FOR_EMAIL_ AS EMAIL_,                                  '+
                '    (SELECT COUNT(1)                                         '+
                '       FROM PEDELE PD                                        '+
                '      WHERE PD.PEL_NUMDOC = P.PCG_NUMPED                     '+
                '        AND PD.PEL_ESPDOC = P.PCG_ESPDOC                     '+
                '        AND PD.PEL_CODEMP = P.PCG_CODEMP                     '+
                '    ) AS QTDXML                                              '+
                '  FROM                                                       '+
                '    PCMGER P                                                 '+
                '    INNER JOIN CADFOR C ON C.FOR_CODFOR = P.PCG_CODFOR       '+
                '    INNER JOIN CADEMP COM ON COM.EMP_CODEMP = P.PCG_CODEMP   '+
                '    LEFT JOIN CADEMP DES ON DES.EMP_CODEMP = P.PCG_EMPDES    '+
                '    LEFT JOIN (SELECT                                        '+
                '                   E.AUTOINCREM,                             '+
                '                   E.EMA_NUMPED,                             '+
                '                   E.EMA_CODEMP,                             '+
                '                   E.EMA_ESPDOC                              '+
                '                 FROM EMAPCM E                               '+
                '                 JOIN EMASAI S ON S.AUTOINCREM = E.EMA_SEQEMA'+
                '                WHERE S.EMA_ENTSAI = "E"                     '+
                '                  AND S.EMA_CODGRU = "%s"                    '+
                '                  AND S.EMA_CODIGO = "%s"                    '+
                '               ) E ON E.EMA_NUMPED = P.PCG_NUMPED            '+
                '                  AND E.EMA_CODEMP = P.PCG_CODEMP            '+
                '                  AND E.EMA_ESPDOC = P.PCG_ESPDOC            '+
                '  WHERE %s                                                   '+
                '    AND P.PCG_CODEMP = "%s"                                  '+
                '    AND IFNULL(E.AUTOINCREM, "") = ""                        '+
                '    AND P.PCG_BAIXAD = 0                                     '+
                '    AND P.PCG_ESPDOC = "PD"                                  '+
                '  HAVING QTDXML = 0                                          ';

  sqlImgModel = 'SELECT                                                       '+
                '  IMG_NOMIMG AS NOMIMG,                                      '+
                '  IMG_IMAGEM AS IMAGEM,                                      '+
                '  IMG_IMGB64 AS IMGB64                                       '+
                'FROM                                                         '+
                '  IMGMOD                                                     '+
                'WHERE                                                        '+
                '  IMG_SEQGER = :SEQGER                                       ';

  sqlUpdModel = 'UPDATE MODEMA SET MOD_MODELO = :MODELO WHERE AUTOINCREM =    '+
                ':AUTINC                                                      ';

  sqlInsLogEnv= 'INSERT INTO EMAPCM (AUTOINCREM, EMA_SEQEMA, EMA_CODEMP,      '+
                ' EMA_NUMPED, EMA_ESPDOC, EMA_CODFOR, EMA_DTAENV, EMA_HORENV) '+
                'VALUES(:AUTINC, :SEQEMA, :CODEMP, :NUMPED, :ESPDOC, :CODFOR, '+
                ' :DTAENV, :HORENV)';

  ecpCfgNotFound = 'Configuração para envio de e-mail não encontrada';


  sqlUpdPedCompraEmail =  ' UPDATE '+
                          '   PCMGER '+
                          ' SET '+
                          '   PCG_DTAMAI = :DTAMAI, '+
                          '   PCG_HORMAI = :HORMAI, '+
                          '   PCG_OPEMAI = :OPEMAI, '+
                          '   PCG_NOMMAI = :NOMMAI, '+
                          '   PCG_DESMAI = :DESMAI  '+
                          ' WHERE '+
                          '   PCG_NUMPED = :NUMPED AND '+
                          '   PCG_ESPDOC = :ESPDOC AND '+
                          '   PCG_CODFOR = :CODFOR AND '+
                          '   PCG_CODEMP = :CODEMP ';

type
  TEntryGroup  = (egFollowUp = 1, egPedidoCompra = 2);

  TOptFollowUp = (ofuFirstNotification = 1,  //Primeira notificação ...
                  ofuSecondNotification,
                  ofuFirstNotice,            //Primeiro aviso ...
                  ofuSecondNotice,
                  ofuThirdNotice);
  TOptPedidoCompra = (opcIncluscaoEmail);

  TPedidosCompra = record
    FNumeroPedidoCompra: String;
    FCodigoEmpresa: String;
    FCodigoEmpresaDestino: String;
  End;

   TArrPedidosCompra = array of TPedidosCompra;



  TEntryGroupHelper  = record helper for TEntryGroup
    function fGetCode: String;
    function fIsActive: Boolean;
    function fGetDescription: String;
  end;

  TOptFollowUpHelper = record helper for TOptFollowUp
  private
    function fGetDays: Integer;
    function fGetWhereNotify: String;
    function fGetFieldValue(strFieldName: String): Variant;
  public
    function fGetSQL: String;
    function fGetCode: String;
    function fIsActive: Boolean;
    function fGetCodEma: String;
    function fGetSQLModel: String;
    function fGetSQLConfig: String;
    function fGetDescription: String;
  end;

  TOptPedidoCompraHelper = record helper for TOptPedidoCompra
  private
    function fGetFieldValue(strFieldName: String): Variant;
  public
    function fGetSQL(ACodigoFornecedor: String; AEspcieDocumento: string; ANumped: String; ACodemp: String): String;
    function fGetCode: String;
    function fIsActive: Boolean;
    function fAnexaPDF: Boolean;
    function fAnexaXLS: Boolean;
    function fGetCodEma: String;
    function fGetSQLModel: String;
    function fGetSQLConfig(AOperador: String): String;
    function fGetDescription: String;
    function fGetChavePdf: String;
  End;

  TEmaAutEnt = class(TComponent)
  private
    qryGen  : TUniQuery;
    FSenha  : String;
    FArquiv : String;
    FImgCor : String;
    FSerSmt : String;
    FLogin  : String;
    FSSLSai : Boolean;
    FPorIma : Integer;
    FLimArq : Integer;
    FRemete : String;
    FImaAss : TMemoryStream;
    FTxtAss : String;
    FCodPrv : Integer;
    FPorSmt : Integer;
    FEmail  : String;
    FSSLEnt : Boolean;
    FSerIma : String;
    FImgAss : Boolean;

    FAssunt: String;
    FModelo: String;

    function fIsLoadData: Boolean;
    function fGetContentEmail(Const strModel: String): String;

    procedure pSetMaskFields;
    procedure pInsertLog(strSeqEma: String; blnAtualizaPedidoDeCompra: Boolean = False; strEmailDestinatario: String = ''; strCodOperador: string = '');
    procedure pLoadData(Const strSQL: String);
    procedure pLoadModel(Const strSQL: String);
    procedure pLoadConfig(Const strSQL: String);
    procedure pSendAutomaticEmail(strSeqEma: String; strArquivos: string = ''; blnAtualizaPedidoDeCompra: Boolean = False; strCodOperador: string = '');
    procedure pLoadEmailSignature(Const strBase64: String);
    procedure pUpdateModelEmail(Const strSeqGer: String);
    procedure pCreateImagesModelEmail(Const strSeqGer: String; Var strPatImg: String);
    function fMontaArrAquivos(Arquivos: String): TStringArray;
  public
    constructor Create(Owner: TComponent); override;
    destructor  Destroy; override;

    class procedure pDispatchAutomaticEmails;
    class procedure pDispatchAutomaticEmailsPedidoCompra(AOperador: String; ACodigoFornecedor: String; AEspcieDocumento: string; ANumped: String; ACodemp: String; AArquivos: string; blnAtualizaPedidoDeCompra: Boolean = False);

  end;

implementation

uses
  Vcl.Forms,
  untConstantes,
  untTEnvioEmail,
  System.StrUtils,
  untImagemBase64,
  System.DateUtils,
  untFuncoesSimples,
  untFuncoesGenerica;

{ TEntryGroupHelper }

function TEntryGroupHelper.fGetCode: String;
begin
  Result := fStrZero(Ord(Self), 3);
end;

function TEntryGroupHelper.fGetDescription: String;
begin
  Case Self Of
    egFollowUp:
      Result := 'Follow-up de compras';
    egPedidoCompra:
      Result := 'Pedido de Compra';
  End;
end;

function TEntryGroupHelper.fIsActive: Boolean;
begin
  Case Self Of
    egFollowUp:
      Result := (fCfgSis('FOLCOM', varString) = 'S');
    Else
      Result := True;
  End;
end;

{ TOptFollowUpHelper }

function TOptFollowUpHelper.fGetCode: String;
begin
  Result := fStrZero(Ord(Self), 3);
end;

function TOptFollowUpHelper.fGetCodEma: String;
begin
  Result := Self.fGetFieldValue('AUTOINCREM');
end;

function TOptFollowUpHelper.fGetDays: Integer;
begin
  Result := Self.fGetFieldValue('EMA_QTDIAS');
end;

function TOptFollowUpHelper.fGetDescription: String;
begin
  Case Self Of
    ofuFirstNotification:
      Result := 'Primeira notificação depois de emitido o pedido de compra';
    ofuSecondNotification:
      Result := 'Segunda notificação depois de emitido o pedido de compra';
    ofuFirstNotice:
      Result := 'Primeiro aviso antes de vencer a entrega';
    ofuSecondNotice:
      Result := 'Segundo  aviso antes de vencer a entrega';
    ofuThirdNotice:
      Result := 'Terceiro aviso antes de vencer a entrega';
  End;
end;

function TOptFollowUpHelper.fGetFieldValue(strFieldName: String): Variant;
begin
  Result := fCampoTabela(strFieldName,
                         'EMASAI',
                         ['EMA_CODIGO', 'EMA_ENTSAI', 'EMA_CODGRU', 'EMA_CODEMP'],
                         [Self.fGetCode(), 'E', egFollowUp.fGetCode(), VS_strCodEmp]);
end;

function TOptFollowUpHelper.fGetSQL: String;
begin
  Result := Format(sqlFollowUp, [egFollowUp.fGetCode(),
                                 Self.fGetCode(),
                                 Self.fGetWhereNotify(),
                                 VS_strCodEmp]);
end;

function TOptFollowUpHelper.fGetSQLConfig: String;
begin
  If (Self.fGetFieldValue('EMA_PROENV') = 'F') Then
  Begin
    Result := Format(sqlFixedCon, [Self.fGetCode(),
                                   egFollowUp.fGetCode(),
                                   VS_strCodEmp]);
  End
  Else
  Begin
    If (fCfgSis('EMLEMP', varBoolean)) Then
      Result := Format(sqlEmprConn, [strLoginUsuarioLogado, VS_strCodEmp])
    Else
      Result := Format(sqlUserConn, [strLoginUsuarioLogado]);
  End;
end;

function TOptFollowUpHelper.fGetSQLModel: String;
begin
  Result := Format(sqlModEmail, [Self.fGetCode(),
                                 egFollowUp.fGetCode(),
                                 VS_strCodEmp]);
end;

function TOptFollowUpHelper.fGetWhereNotify: String;
var
  LQtDays: Integer;
begin
  LQtDays := Self.fGetDays();

  Case Self Of
    ofuFirstNotification,
    ofuSecondNotification:
      Result := Format('DATEDIFF(%s, P.PCG_DTAPED) >= %d AND ' +
                       'DATEDIFF(%s, P.PCG_DTAPED) <= %d',
                       [fDateSql(VS_Date), LQtDays, fDateSql(VS_Date), LQtDays+3]);
    ofuFirstNotice,
    ofuSecondNotice,
    ofuThirdNotice:
      Result := Format('(DATEDIFF(P.PCG_DTAENT, %s) <= %d AND ' +
                       ' DATEDIFF(P.PCG_DTAENT, %s) >= %d)',
                       [fDateSql(VS_Date), LQtDays, fDateSql(VS_Date), LQtDays-3]);
    Else
      Result := 'FALSE';
  End;
end;

function TOptFollowUpHelper.fIsActive: Boolean;
begin
  Result := (Self.fGetFieldValue('EMA_STATUS') = 'A');
end;

{ TEmaAutEnt }

constructor TEmaAutEnt.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  qryGen  := fCriaQuery(nil);

  FSenha  := '';
  FEmail  := '';
  FLogin  := '';
  FCodPrv := 0;
  FPorSmt := 0;
  FSerSmt := '';
  FPorIma := 0;
  FSerIma := '';
  FLimArq := 0;
  FImgAss := False;
  FTxtAss := '';
  FRemete := '';
  FSSLSai := False;
  FSSLEnt := False;

  FImaAss := TMemoryStream.Create;
end;

destructor TEmaAutEnt.Destroy;
begin
  FreeAndNil(qryGen);
  FImaAss.Free;

  inherited Destroy;
end;

function TEmaAutEnt.fGetContentEmail(const strModel: String): String;
var
  i: Integer;
begin
  pSetMaskFields();
  Result := strModel;

  For i := 0 To Pred(qryGen.Fields.Count) Do
    Result := AnsiReplaceStr(Result, Concat('<<', qryGen.Fields[i].FieldName, '>>'), qryGen.Fields[i].DisplayText);
end;

function TEmaAutEnt.fIsLoadData: Boolean;
begin
  Result := (qryGen.Active And (Not qryGen.IsEmpty));
end;

function TEmaAutEnt.fMontaArrAquivos(Arquivos: String): TStringArray;
var lstArquivos: TStringList;
    i: integer;
begin
  lstArquivos := TStringList.Create();
  Result := [];
  Try
    lstArquivos.Delimiter := ';';
    lstArquivos.StrictDelimiter := True;
    lstArquivos.DelimitedText:= Arquivos;
    For i := 0 To  lstArquivos.Count -1 do
    Begin
      If lstArquivos[i] <> '' Then
        Result := Result + [lstArquivos[i]];
    End;
  Finally
    FreeAndNil(lstArquivos);
  End;
end;

procedure TEmaAutEnt.pLoadConfig(const strSQL: String);
var
  qryCfg: TUniQuery;
begin
  qryCfg := fCriaQuery(nil);

  Try
    Try
      qryCfg.SQL.Add(strSQL);
      qryCfg.Open;

      If qryCfg.IsEmpty Then
        Raise Exception.Create(ecpCfgNotFound);

      FSenha  := CriptografarSenhaEmail(qryCfg.FieldByName('SENHA').AsString);
      FEmail  := qryCfg.FieldByName('EMAIL').AsString;
      FLogin  := qryCfg.FieldByName('LOGIN').AsString;
      FRemete := qryCfg.FieldByName('REMETE').AsString;

      FCodPrv := qryCfg.FieldByName('CODPRV').AsInteger;
      FPorSmt := qryCfg.FieldByName('PORSMT').AsInteger;
      FSerSmt := qryCfg.FieldByName('SERSMT').AsString;
      FPorIma := qryCfg.FieldByName('PORIMA').AsInteger;
      FSerIma := qryCfg.FieldByName('SERIMA').AsString;
      FLimArq := qryCfg.FieldByName('LIMARQ').AsInteger;
      FImgAss := (Not (fEmptyStr(qryCfg.FieldByName('IMGASS').AsString)));
      FTxtAss := AnsiReplaceStr(qryCfg.FieldByName('TXTASS').AsString, STRING_QUEBRA, STRING_ENTER);

      FSSLSai := (qryCfg.FieldByName('SSLSAI').AsString = 'S');
      FSSLEnt := (qryCfg.FieldByName('SSLENT').AsString = 'S');

      If (FImgAss) Then
        pLoadEmailSignature(qryCfg.FieldByName('IMGASS').AsString);
    Except
      on E: Exception Do
        Raise Exception.Create(Concat(E.Message, ' - [TEmaAutEnt.pLoadConfig]'));
    End;
  Finally
    FreeAndNil(qryCfg);
  End;
end;

procedure TEmaAutEnt.pLoadData(const strSQL: String);
begin
  Try
    qryGen.Close();
    qryGen.SQL.Clear();
    qryGen.SQL.Add(strSQL);
    qryGen.Open();
  Except
    on E: Exception Do
      Raise Exception.Create(Concat(E.Message, ' - [TEmaAutEnt.pLoadData]'));
  End;
end;

procedure TEmaAutEnt.pLoadEmailSignature(Const strBase64: String);
var
  tmpImg: TBytesStream;
begin
  FImaAss.Clear();
  tmpImg := TBytesStream.Create(nil);
  fStreamFromBase64(strBase64, tmpImg);

  Try
    If (tmpImg.Size > 0) Then
    Begin
      tmpImg.SaveToStream(FImaAss);
      FImaAss.Seek(0, soFromBeginning);
    End;
  Finally
    tmpImg.Free;
  End;
end;

procedure TEmaAutEnt.pLoadModel(const strSQL: String);
var
  qryMod: TUniQuery;
begin
  qryMod := fCriaQuery(Self);

  Try
    Try
      qryMod.SQL.Add(strSQL);
      qryMod.Open();

      FAssunt := qryMod.FieldByName('MOD_ASSUNT').AsString;
      FModelo := qryMod.FieldByName('MOD_MODELO').AsString;
      FModelo := AnsiReplaceStr(FModelo, '&lt;&lt;', '<<');
      FModelo := AnsiReplaceStr(FModelo, '&gt;&gt;', '>>');

      pCreateImagesModelEmail(qryMod.FieldByName('AUTOINCREM').AsString, FImgCor);
    Except
    on E: Exception Do
      Raise Exception.Create(Concat(E.Message, ' - [TEmaAutEnt.pLoadModel]'));
    End;
  Finally
    FreeAndNil(qryMod);
  End;
end;

procedure TEmaAutEnt.pSendAutomaticEmail(strSeqEma: String; strArquivos: string = ''; blnAtualizaPedidoDeCompra: Boolean = False; strCodOperador: string = '');
var
  arrArquivos: TStringArray;
  arrDestinatarios    : TStringArray;
  strEmailDestinatario: String;
begin
  qryGen.First;
  If strArquivos <> '' Then
    arrArquivos := fMontaArrAquivos(strArquivos);


  While Not qryGen.Eof Do
  Begin
    Application.ProcessMessages;
    If (fEmptyStr(qryGen.FieldByName('EMAIL_').AsString)) Or
       (Not fEmailValido(qryGen.FieldByName('EMAIL_').AsString, False)) Then
    Begin
      qryGen.Next;
      Continue;
    End;

    Try
      strEmailDestinatario := qryGen.FieldByName('EMAIL_').AsString;
      pCriarArrayAnexosEDestinatarios(FArquiv, strEmailDestinatario, arrDestinatarios, arrArquivos);

      If TEnvioEmail.EnviarEmail(Nil, strLoginUsuarioLogado, fGetContentEmail(FAssunt),
                                 arrDestinatarios, [], [], [fGetContentEmail(FModelo)],
                                 arrArquivos, False, False,
                                 fRetAutoIncrem('EMAENV', VS_strCodEmp),
                                 fRetAutoIncrem('CONOPE', VS_strCodEmp),
                                 StrToInt64(fAtualizaProCod('EMAENV', '')),
                                 True, FSenha, FEmail, FLogin, FRemete, FCodPrv, FPorSmt,
                                 FPorIma, FSerSmt, FSerIma, FLimArq, FImgAss, FTxtAss,
                                 FImaAss, fRetNomeOperador(strLoginUsuarioLogado),
                                 FImgCor, FSSLSai, FSSLEnt,'S','N','',qryGen.FieldByName('CODFOR').AsString) Then
      Begin
        pInsertLog(strSeqEma, blnAtualizaPedidoDeCompra, strEmailDestinatario, strCodOperador);
      End;
    Except
      On E: Exception Do
        Raise Exception.Create(Concat(E.Message, ' - [TEmaAutEnt.pSendAutomaticEmail]'));
    End;

    qryGen.Next;
  End;
end;

procedure TEmaAutEnt.pSetMaskFields;
begin
  If Assigned(qryGen.FindField('TOTCOM')) Then
    TFloatField(qryGen.FieldByName('TOTCOM')).DisplayFormat := fMskDigitos(2);

  If Assigned(qryGen.FindField('CGCFOR')) Then
  Begin
    If (Length(qryGen.FieldByName('CGCFOR').AsString) < 14) Then
      TStringField(qryGen.FieldByName('CGCFOR')).EditMask := fRetMascaraC_G_C_(fSetaPais, C_P_F_)
    Else
      TStringField(qryGen.FieldByName('CGCFOR')).EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_);
  End;
end;

procedure TEmaAutEnt.pUpdateModelEmail(const strSeqGer: String);
var
  qryTemp: TUniQuery;
begin
  qryTemp := fCriaQuery(Nil);

  Try
    With qryTemp Do Begin
      SQL.Add(sqlUpdModel);
      ParamByName('AUTINC').AsString := strSeqGer;
      ParamByName('MODELO').AsString := FModelo;
      ExecSQL();
    End;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

procedure TEmaAutEnt.pCreateImagesModelEmail(Const strSeqGer: String;
  var strPatImg: String);
var
  qryImg: TUniQuery;
  strPasImg, strModelo, strOldPath, strNewPath: String;
  blnAtualizarModelo: Boolean;
  i, intPosIni, intPosFim: Integer;
  tmpImg: TBytesStream;
begin
  qryImg := fCriaQuery(Nil);

  Try
    tmpImg := TBytesStream.Create(nil);
    strPatImg := '';
    strPasImg := ExtractFilePath(Application.ExeName) + PASTA_IMAGEM_EMAIL_AUT + '\';
    strModelo := FModelo;
    blnAtualizarModelo := False;

    If (Not DirectoryExists(strPasImg)) Then
      MkDir(strPasImg);

    With qryImg Do
    Begin
      SQL.Add(sqlImgModel);
      ParamByName('SEQGER').AsString := strSeqGer;
      Open;

      While Not Eof Do
      Begin
        If (Not FileExists(strPasImg + FieldByName('NOMIMG').AsString)) Then
        Begin
          If FieldByName('IMAGEM').isNull Then
          Begin
            fStreamFromBase64(FieldByName('IMGB64').AsString, tmpImg);
            If (tmpImg.Size > 0) Then
              tmpImg.SaveToFile(strPasImg + FieldByName('NOMIMG').AsString);
          End
          Else
            TBlobField(FieldByName('IMAGEM')).SaveToFile(strPasImg + FieldByName('NOMIMG').AsString);
        End;

        If (fEmptyStr(strPatImg)) Then
          strPatImg := strPasImg + FieldByName('NOMIMG').AsString
        Else
          strPatImg := strPatImg + ';' + strPasImg + FieldByName('NOMIMG').AsString;

        If (Pos(strPasImg + FieldByName('NOMIMG').AsString, FModelo) <= 0) Then
        Begin
          intPosIni := 0;
          intPosFim := Pos(FieldByName('NOMIMG').AsString, strModelo) +
                           Length(FieldByName('NOMIMG').AsString);

          For i := intPosFim DownTo 0 Do
          Begin
            If (strModelo[i] = '<') Then
            Begin
              intPosIni := i;
              Break;
            End;
          End;

          For i := intPosFim To Length(strModelo) - 1 Do
          Begin
            If (strModelo[i] = '>') Then Begin
              intPosFim := i;
              Break;
            End;
          End;

          If (intPosIni > 0) And (intPosFim > 0) Then
          Begin
            strOldPath := Copy(strModelo, intPosIni, intPosFim - intPosIni + 1);
            strNewPath := strOldPath;

            intPosIni := Pos('src="', strNewPath) + 5;
            intPosFim := Pos(FieldByName('NOMIMG').AsString, strNewPath) +
                           Length(FieldByName('NOMIMG').AsString);

            strNewPath := AnsiReplaceStr(strNewPath,
                                         Copy(strNewPath, intPosIni, intPosFim - intPosIni),
                                         strPasImg + FieldByName('NOMIMG').AsString);

            FModelo := AnsiReplaceStr(FModelo,
                                      strOldPath,
                                      strNewPath);

            If (Not blnAtualizarModelo) Then
              blnAtualizarModelo := True;
          End;
        End;

        Next;
      End;

      If (blnAtualizarModelo) Then
        pUpdateModelEmail(strSeqGer);
    End;

  Finally
    FreeAndNil(qryImg);
    FreeAndNil(tmpImg);
  End;
end;

class procedure TEmaAutEnt.pDispatchAutomaticEmailsPedidoCompra(AOperador: String; ACodigoFornecedor: String; AEspcieDocumento: string; ANumped: String; ACodemp: String; AArquivos: string; blnAtualizaPedidoDeCompra: Boolean = False);
var
  LInstance: TEmaAutEnt;
begin
  LInstance := TEmaAutEnt.Create(nil);
  Try
    Application.ProcessMessages;
    Try
      If Not egPedidoCompra.fIsActive() Then
        Exit;
      Try
        If Not opcIncluscaoEmail.fIsActive() Then
          Exit;

        LInstance.pLoadData(opcIncluscaoEmail.fGetSQL(ACodigoFornecedor, AEspcieDocumento, ANumped, ACodemp));

        If LInstance.fIsLoadData() Then
        Begin
          LInstance.pLoadConfig(opcIncluscaoEmail.fGetSQLConfig(AOperador));
          LInstance.pLoadModel(opcIncluscaoEmail.fGetSQLModel());
          LInstance.pSendAutomaticEmail(opcIncluscaoEmail.fGetCodEma(), AArquivos, blnAtualizaPedidoDeCompra, AOperador);
        End;
      Except
        On E: Exception Do
          pGravarErro(True, E.Message, fRetornaStack());
      End;
    Except
      On E: Exception Do
        pGravarErro(True, E.Message, fRetornaStack());
    End;
  Finally
    FreeAndNil(LInstance);
  End;
End;

class procedure TEmaAutEnt.pDispatchAutomaticEmails;
var
  egItem: TEntryGroup;
  ofuItem: TOptFollowUp;
  LInstance: TEmaAutEnt;
begin
  LInstance := TEmaAutEnt.Create(nil);

  Try
    For egItem := Low(TEntryGroup) To High(TEntryGroup) Do
    Begin
      Application.ProcessMessages;
      Try
        If Not egItem.fIsActive() Then
          Continue;

        Case egItem Of
          egFollowUp:
            Begin
              For ofuItem := Low(TOptFollowUp) To High(TOptFollowUp) Do
              Begin
                Application.ProcessMessages;
                Try
                  If Not ofuItem.fIsActive() Then
                    Continue;

                  LInstance.pLoadData(ofuItem.fGetSQL());

                  If LInstance.fIsLoadData() Then
                  Begin
                    LInstance.pLoadConfig(ofuItem.fGetSQLConfig());
                    LInstance.pLoadModel(ofuItem.fGetSQLModel());
                    LInstance.pSendAutomaticEmail(ofuItem.fGetCodEma());
                  End;
                Except
                  On E: Exception Do
                    pGravarErro(True, E.Message, fRetornaStack());
                End;
              End;
            End;
        End;
      Except
        On E: Exception Do
          pGravarErro(True, E.Message, fRetornaStack());
      End;
    End;
  Finally
    FreeAndNil(LInstance);
  End;
end;

procedure TEmaAutEnt.pInsertLog(strSeqEma: String; blnAtualizaPedidoDeCompra: Boolean = False; strEmailDestinatario: String = ''; strCodOperador: string = '');
var
  qryIns: TUniQuery;
begin
  If qryGen.IsEmpty Then
    Exit;

  qryIns := fCriaQuery(Self);

  Try
    Try
      qryIns.SQL.Add(sqlInsLogEnv);
      qryIns.ParamByName('AUTINC').AsString   := fRetAutoIncrem('EMAPCM', VS_strCodEmp);
      qryIns.ParamByName('SEQEMA').AsString   := strSeqEma;
      qryIns.ParamByName('CODEMP').AsString   := VS_strCodEmp;
      qryIns.ParamByName('NUMPED').AsString   := qryGen.FieldByName('PEDCOM').AsString;
      qryIns.ParamByName('ESPDOC').AsString   := qryGen.FieldByName('ESPCOM').AsString;
      qryIns.ParamByName('CODFOR').AsString   := qryGen.FieldByName('CODFOR').AsString;
      qryIns.ParamByName('DTAENV').AsDateTime := VS_Date;
      qryIns.ParamByName('HORENV').AsTime     := fTime();

      qryIns.ExecSQL;

      If blnAtualizaPedidoDeCompra Then
      Begin
        qryIns.Close;
        qryIns.SQL.Clear;
        qryIns.SQL.Add(sqlUpdPedCompraEmail);
        qryIns.ParamByName('DTAMAI').AsDateTime := VS_Date;
        qryIns.ParamByName('HORMAI').AsTime := fTime();

        if fEmptyStr(strCodOperador) Then
          qryIns.ParamByName('OPEMAI').Clear
        Else
          qryIns.ParamByName('OPEMAI').AsString := strCodOperador;

        //Quando é envio automatico não tem o destinário
        qryIns.ParamByName('NOMMAI').Clear;

        qryIns.ParamByName('DESMAI').AsString := qryGen.FieldByName('EMAIL_').AsString;
        qryIns.ParamByName('NUMPED').AsString := qryGen.FieldByName('PEDCOM').AsString;
        qryIns.ParamByName('ESPDOC').AsString := qryGen.FieldByName('ESPCOM').AsString;
        qryIns.ParamByName('CODEMP').AsString := qryGen.FieldByName('CODEMP').AsString;
        qryIns.ParamByName('CODFOR').AsString := qryGen.FieldByName('CODFOR').AsString;
        qryIns.ExecSQL;
      End;

    Except
      On E: Exception Do
        Raise Exception.Create(Concat(E.Message, ' - [TEmaAutEnt.pInsertLog]'));
    End;
  Finally
    FreeAndNil(qryIns);
  End;
end;

{ TOptPedidoCompraHelper }

function TOptPedidoCompraHelper.fAnexaPDF: Boolean;
var strAutInc: string;
begin
  strAutInc := Self.fGetFieldValue('AUTOINCREM');
  Result := fCampoTabela('MOD_ENVDOC',
                         'MODEMA',
                         ['MOD_SEQGER'],
                         [strAutInc]) = 'S';


end;

function TOptPedidoCompraHelper.fAnexaXLS: Boolean;
var strAutInc: string;
begin
  strAutInc := Self.fGetFieldValue('AUTOINCREM');
  Result := fCampoTabela('MOD_ENVXLS',
                         'MODEMA',
                         ['MOD_SEQGER'],
                         [strAutInc]) = 'S';


end;

function TOptPedidoCompraHelper.fGetChavePdf: String;
begin
  Result := 'INC';
end;

function TOptPedidoCompraHelper.fGetCode: String;
begin
  Result := fStrZero(Ord(Self), 3);
end;

function TOptPedidoCompraHelper.fGetCodEma: String;
begin
  Result := Self.fGetFieldValue('AUTOINCREM');
end;

function TOptPedidoCompraHelper.fGetDescription: String;
begin
  Result := 'Montagem do Email';
end;

function TOptPedidoCompraHelper.fGetFieldValue(strFieldName: String): Variant;
begin
  Result := fCampoTabela(strFieldName,
                         'EMASAI',
                         ['EMA_CODIGO', 'EMA_ENTSAI', 'EMA_CODGRU', 'EMA_CODEMP'],
                         [Self.fGetCode(), 'E', egPedidoCompra.fGetCode(), VS_strCodEmp]);

end;

function TOptPedidoCompraHelper.fGetSQL(ACodigoFornecedor: String; AEspcieDocumento: string; ANumped: String; ACodemp: String): String;
begin
  Result := '';
  Result := Result + 'SELECT                                                       ';
  Result := Result + '    P.PCG_NUMPED AS PEDCOM,                                  ';
  Result := Result + '    P.PCG_ESPDOC AS ESPCOM,                                  ';
  Result := Result + '    P.PCG_CODEMP AS CODEMP,                                  ';
  Result := Result + '    CONCAT(P.PCG_CODEMP,"-",COM.EMP_NOMEMP) AS EMPCOM,       ';
  Result := Result + '    IF(IFNULL(P.PCG_EMPDES,"") = "", "",                     ';
  Result := Result + '       CONCAT(P.PCG_EMPDES,"-",DES.EMP_NOMEMP)) AS EMPDES,   ';
  Result := Result + '    P.PCG_TOTGER AS TOTCOM,                                  ';
  Result := Result + '    P.PCG_DTAPED AS DTAEMI,                                  ';
  Result := Result + '    P.PCG_DTAENT AS DTAENT,                                  ';
  Result := Result + '    P.PCG_CODFOR AS CODFOR,                                  ';
  Result := Result + '    C.FOR_NOMFOR AS RAZFOR,                                  ';
  Result := Result + '    C.FOR_NOMFAN AS FANFOR,                                  ';
  Result := Result + '    C.FOR_C_G_C_ AS CGCFOR,                                  ';
  Result := Result + '    IF(IFNULL(FOR_EMAPED, "") = "", C.FOR_EMAIL_, FOR_EMAPED) AS EMAIL_, ';
  Result := Result + '    (SELECT COUNT(1)                                         ';
  Result := Result + '       FROM PEDELE PD                                        ';
  Result := Result + '      WHERE PD.PEL_NUMDOC = P.PCG_NUMPED                     ';
  Result := Result + '        AND PD.PEL_ESPDOC = P.PCG_ESPDOC                     ';
  Result := Result + '        AND PD.PEL_CODEMP = P.PCG_CODEMP                     ';
  Result := Result + '    ) AS QTDXML                                              ';
  Result := Result + '  FROM                                                       ';
  Result := Result + '    PCMGER P                                                 ';
  Result := Result + '    INNER JOIN CADFOR C ON C.FOR_CODFOR = P.PCG_CODFOR       ';
  Result := Result + '    INNER JOIN CADEMP COM ON COM.EMP_CODEMP = P.PCG_CODEMP   ';
  Result := Result + '    LEFT JOIN CADEMP DES ON DES.EMP_CODEMP = P.PCG_EMPDES    ';
  Result := Result + '    WHERE P.PCG_NUMCTN = 0 ';
  Result := Result + '      AND P.PCG_NUMPED = "'+ANumped+'" ';
  Result := Result + '      AND P.PCG_ESPDOC = "'+AEspcieDocumento+'" ';
  Result := Result + '      AND P.PCG_CODEMP = "'+ACodemp+'" ';
  Result := Result + '      AND P.PCG_CODFOR = "'+ACodigoFornecedor+'" ';

end;

function TOptPedidoCompraHelper.fGetSQLConfig(AOperador: String): String;
begin
  If (Self.fGetFieldValue('EMA_PROENV') = 'F') Then
  Begin
    Result := Format(sqlFixedCon, [Self.fGetCode(),
                                   egPedidoCompra.fGetCode(),
                                   VS_strCodEmp]);
  End
  Else
  Begin
    If (fCfgSis('EMLEMP', varBoolean)) Then
      Result := Format(sqlEmprConn, [AOperador, VS_strCodEmp])
    Else
      Result := Format(sqlUserConn, [AOperador]);
  End;

end;

function TOptPedidoCompraHelper.fGetSQLModel: String;
begin
  Result := Format(sqlModEmail, [Self.fGetCode(),
                                 egPedidoCompra.fGetCode(),
                                 VS_strCodEmp]);

end;

function TOptPedidoCompraHelper.fIsActive: Boolean;
begin
  Result := (Self.fGetFieldValue('EMA_STATUS') = 'A');

end;

end.
