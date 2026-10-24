unit untBoleto;

interface

uses Classes, UniClientDataSet, Uni, untFuncoesSimples, Data.DB, untTypesSistema,
     untDisparaEmailAut, untFuncoesBoleto, untTBoletoCarne, untDisparaSMSAut,untTBancoDoBrasilAPI,
     untTBancoCredisisAPI, XMLDoc, untTBancoSicrediAPI, untTBoleto1Via_Comprovante,
     untTBancoItauAPI, untTBancoSicoobAPI, untTBancoSantanderAPI, untTBancoSafraAPI,
     untTBancoBradescoAPI;

Type
  TDupCtr = TDuplicataCtr;

  TBoleto = class(TComponent)
  Private
    FCodCar : Integer;
    FBcoIni : String;
    FValExt2: String;
    FCepCli : String;
    FMens02 : String;
    FMens01 : String;
    FValExt : String;
    FNosNum : String;
    FNumDig : String;
    FCgcCli : String;
    FValMor : Double;
    FCodBco : String;
    FCodPor : String;
    FDtaAtu : String;
    FPerMul : String;
    FDesCtr : Double;
    FMulta_ : Double;
    FValDes : Double;
    FBraCrr : String;
    FCodCli : String;
    FNomCli : String;
    FCidCli : String;
    FEstCli : String;
    FEndCli : String;
    FInsEst : String;
    FUltPar : String;
    FBB_Crr : String;
    FConCrr : String;
    FAltImp : Boolean;

    FobjStatusEmailAutomatico: TStatusDisparaEmail;

    cpuCampos: TCamposUso;
    qryConCli: TUniQuery;
    qryConRec: TUniQuery;
    qryConTot: TUniQuery;
    qryCfgRel: TUniQuery;

    blnFaturamento: Boolean;
    strNomImp     : String;
    strNomFrm     : String;
    strNomeTabela : String;

    {API COBRANÇA BANCO DO BRASIL REQ: 191511 MT}
    LBancoDoBrasilApi: TBancoDoBrasilAPI;

    LBancoCredisisApi: TBancoCredisisAPI;

    LBancoSicrediApi: TBancoSicrediAPI;

    FBancoItauApi: TBancoItauAPI;

    LBancoSafraApi: TBancoSafraAPI;
    FBancoSicoobApi: TBancoSicoobAPI;

    FBancoSantanderApi: TBancoSantanderAPI;

    FBancoBradescoApi: TBancoBradescoAPI;

    FBoletoCarneBuilder : TBoletoCarneBuilder;
    FBoleto1ViaBuilder : TBoleto1Via_ComprovanteBuilder;

    procedure pInicializaCamposUso;
    procedure pAtualizaCamposUso(ctrDup: TDupCtr);
    function GetHtmlContent(const ANomeCliente: string): string;
    procedure pAtribuiCamposUso;
    procedure pFinalizaCamposUso;

    procedure pUpdateCadRec(ctrDup: TDupCtr);

    function fSelectNossoNumeroAnterior(ctrDup: TDupCtr): String;
    function fNossoNumeroAnterior(ctrDup: TDupCtr; blnManterPortador: Boolean): String;
    function fRetNumCartReimpressao(strCartei: String): Integer;
    function fRetornaEmailCliente(cdsBoleto: TDataset): String;
    function fVerificaEmailAutmatico(objDuplicata: TDuplicataCtr): Boolean;

  public
    blnEditaEmail,
    blnEtiCob: Boolean;
    blnPortadorAlterado: Boolean;

    Constructor Create(Owner: TComponent; strNomeTabela: String; blnFaturamento: Boolean); reintroduce;
    Destructor Destroy; Override;

    function fImprimir(cdsBoletos: TUniClientDataSet; arrCtrDup: TArrDupCtr;
      strBancoAnterior: String; blnBolPdf, blnEnvEml, blnEmaAut: Boolean;
      out AEnviouEmail: Boolean; out AEnviouSMS: Boolean; out AEnviouWpp: Boolean;
      blnReimp: Boolean = False; blnReimpParcial: Boolean = False;
      strCartei: String = ''; strPerMor: String = ''; strPerMul: String = '';
      strNomImpBol: String = ''; strOrdCampo: string = ''; strOrdTipo : string = '';
      blnEnvioAutmaticoEmail: Boolean = False; AGeraBoleto: Boolean = False): Boolean;

    class function fGetProvedorEnvioEmailAutomatico(objDuplicata: TDuplicataCtr): String;

    class function fImprimirBoletos(objArrDupCtr: TArrDupCtr; blnFaturamento: Boolean = False;
      blnPergunta: Boolean = False; strTextoPergunta: String = ''; strNomeForm: String = '';
      strNomImpBol: String = ''; strWhereBol: String = ''): Boolean;

    class function fGetSQLBoletos(blnReimpressaoBoleto: Boolean = False; AGerarBoleto:Boolean = False): String;

    class function fEnviarEmailBoletoAutomatico(objArrDupCtr: TArrDupCtr;
                                                objStatusBoleto: TStatusDisparaEmail;
                                                out AEnviouEmail: Boolean;
                                                out AEnviouSMS: Boolean;
                                                out AEnviouWPP: Boolean): Boolean;

    class function fChaveLockImpressaoBoletos(): String;

    class function RetornaCodigoModeloSMSAutomatico(AStatus: TStatusDisparaEmail): String;

    function RetornaSelectLinkDoBoleto: String;

    class function ExisteCarteiraDaDuplicataCadastrada(ACarteira: String): Boolean;

    procedure ReimpressaoBoletoBancoCredisisAPI( Var LBancoApi : TBancoCredisisAPI; strAutoIncrem : String );

    class function fReimpressaoPDFBoleto(objArrDupCtr: TArrDupCtr): Boolean;

    function RetornaPastaBoletos(ACodigoEmpresaDuplicata: String; ABoletoCarne: Boolean; ABoleto1Via: Boolean): String;
  published
    property strCodBco  : String  read FCodBco  write FCodBco;
    property fltValMor  : Double  read FValMor  write FValMor;
    property fltValDes  : Double  read FValDes  write FValDes;
    property strCodPor  : String  read FCodPor  write FCodPor;
    property strNosNum  : String  read FNosNum  write FNosNum;
    property strNumDig  : String  read FNumDig  write FNumDig;
    property strValExt  : String  read FValExt  write FValExt;
    property strValExt2 : String  read FValExt2 write FValExt2;
    property intCodCar  : Integer read FCodCar  write FCodCar;
    property strBcoIni  : String  read FBcoIni  write FBcoIni;
    property strMens01  : String  read FMens01  write FMens01;
    property strMens02  : String  read FMens02  write FMens02;
    property strCliCgc  : String  read FCgcCli  write FCgcCli;
    property strCliCep  : String  read FCepCli  write FCepCli;
    property strDtaAtu  : String  read FDtaAtu  write FDtaAtu;
    property fltDesCtr  : Double  read FDesCtr  write FDesCtr;
    property fltMulta_  : Double  read FMulta_  write FMulta_;
    property strPerMul  : String  read FPerMul  write FPerMul;
    property strBraCrr  : String  read FBraCrr  write FBraCrr;
    property strCodCli  : String  read FCodCli  write FCodCli;
    property strNomCli  : String  read FNomCli  write FNomCli;
    property strCidCli  : String  read FCidCli  write FCidCli;
    property strEstCli  : String  read FEstCli  write FEstCli;
    property strEndCli  : String  read FEndCli  write FEndCli;
    property strInsEst  : String  read FInsEst  write FInsEst;
    property strUltPar  : String  read FUltPar  write FUltPar;
    property strBB_Crr  : String  read FBB_Crr  write FBB_Crr;
    property strConCrr  : String  read FConCrr  write FConCrr;
    property blnAltImp  : Boolean read FAltImp  write FAltImp;

    property objStatusEmailAutomatico: TStatusDisparaEmail read FobjStatusEmailAutomatico write FobjStatusEmailAutomatico;
  Private
    function RetornaLinkPixCitelValido(const ADuplicata: TDataSet): String;
  End;

implementation

uses SysUtils, Forms, StrUtils, untCfgRel, untCadRec,
  untFuncoes, untValorPorExtenso,
  untTEnvioEmail, untFuncAutban, WinApi.Windows, System.DateUtils;

{ TBoleto }

constructor TBoleto.Create(Owner: TComponent;  strNomeTabela: String; blnFaturamento: Boolean);
begin
  inherited Create(Owner);
  Self.strNomeTabela  := strNomeTabela;
  Self.blnFaturamento := blnFaturamento;

  qryConCli := fCriaQuery(Self);
  qryConRec := fCriaQuery(Self);
  qryConTot := fCriaQuery(Self);
  qryCfgRel := fCriaQuery(Self);

  FBoletoCarneBuilder := TBoletoCarneBuilder.Create;
  FBoleto1ViaBuilder  := TBoleto1Via_ComprovanteBuilder.Create;

  pInicializaCamposUso;
end;

destructor TBoleto.Destroy;
begin
  pFinalizaCamposUso;
  FreeAndNil(FBoletoCarneBuilder);
  FreeAndNil(FBoleto1ViaBuilder);
  If Assigned(LBancoDoBrasilApi) Then
    FreeAndNil(LBancoDoBrasilApi);

  If Assigned(LBancoCredisisApi) Then
    FreeAndNil(LBancoCredisisApi);

  If Assigned(LBancoSicrediApi) Then
    FreeAndNil(LBancoSicrediApi);

  If Assigned(FBancoItauApi) Then
    FreeAndNil(FBancoItauApi);

  If Assigned(FBancoSantanderApi) Then
    FreeAndNil(FBancoSantanderApi);

  If Assigned(FBancoSicoobApi) Then
    FreeAndNil(FBancoSicoobApi);

  If Assigned(LRetornoRegistroBoletoApi) Then
    LRetornoRegistroBoletoApi := Nil;

  If Assigned(LBancoSafraApi) Then
    FreeAndNil(LBancoSafraApi);

  If Assigned(FBancoBradescoApi) Then
    FreeAndNil(FBancoBradescoApi);

  inherited;
end;

procedure TBoleto.ReimpressaoBoletoBancoCredisisAPI( Var LBancoApi : TBancoCredisisAPI; strAutoIncrem : String );
  Var
    FXmlRet : TXMLDocument;
begin

   FXmlRet := TXMLDocument.Create(Self);

   LBancoApi.ReimpressaoDeBoleto(strAutoIncrem, FXmlRet);

End;

function TBoleto.fImprimir(cdsBoletos: TUniClientDataSet;
                            arrCtrDup: TArrDupCtr;
                            strBancoAnterior: String;
                            blnBolPdf,
                            blnEnvEml,
                            blnEmaAut: Boolean;
                            out AEnviouEmail: Boolean;
                            out AEnviouSMS: Boolean;
                            out AEnviouWpp: Boolean;
                            blnReimp: Boolean = False;
                            blnReimpParcial: Boolean = False;
                            strCartei: String = '';
                            strPerMor: String = '';
                            strPerMul: String = '';
                            strNomImpBol: String = '';
                            strOrdCampo: string = '';
                            strOrdTipo : string = '';
                           blnEnvioAutmaticoEmail: Boolean = False;
                           AGeraBoleto: Boolean = False): Boolean;
  Var
    blnConfirma    : Boolean;
    blnBolPdfV     : Boolean;
    blnEnvMaiV     : Boolean;
    blnDupMercantil: Boolean;
    strTipBol      : String;
    strReimpr      : String;
    strPathBol     : String;
    strNosNumNovo  : String;
    strNosNumReimpr: String;
    strPortadorAnt : String;
    strEmailCli    : String;
    strNum_PD      : String;
    strEmp_PD      : String;
    qryGen         : TUniQuery;
    intCont        : Integer;
    intContCli     : Integer;
    stlClientes    : TStringList;
    arrArquivos,
    arrDestinatarios: TStringArray;

    strTpIden      : String;
    objDadosEmail  : TDadosDisparaEmail;
    objDadosSMS    : TDadosDisparaSMS;
    objDadosWPP    : TDadosDisparaSMS;
    thrSincEmail   : TThreadSincronizaEmails;
    strArqBoletos  : String;
    ACorpoMensagem : TStringArray;
    strCorpo: String;

    ABoletoCarne: Boolean;
    ABoleto1Via: Boolean;

    stlBoletosRealocados : TStringList;
    iArr : Integer;
    blnMsg : Boolean;

    strArqBoletosWppEma: String;
    strBoleto: String;
    arrBoletos: TArray<String>;
    recArquivos: TArray<TRecArquivosGatilhos>;

  procedure pProcessarClientesCtrDup;
    Var i: Integer;
  begin
    If (Length(arrCtrDup) = 0) Then
      Exit;

    stlClientes.Clear();
    stlClientes.Add(arrCtrDup[0].strCodCli);

    For i := 1 To Length(arrCtrDup) - 1 Do
      If (stlClientes.IndexOf(arrCtrDup[i].strCodCli) = -1) Then
        stlClientes.Add(arrCtrDup[i].strCodCli);
  end;

  function fRetornaCdsPortadorAut(intTip : Integer; ACodGru, ACodCfg, ACodEmp : String ): TUniClientDataSet;
  Var
      LQryPor  : TUniQuery;
      strSqlEmail,
      strSqlSMS,
      strSqlWhatsapp : String;
  Begin

    Try

      LQryPor   := fCriaQuery;

      If intTip = 0 Then //email
      Begin
         strSqlEmail := '';
         strSqlEmail := strSqlEmail + ' SELECT PORAEN.AEN_CODPOR FROM EMASAI ';
         strSqlEmail := strSqlEmail + '  INNER JOIN PORAEN  ON EMASAI.EMA_CODGRU = PORAEN.AEN_CODGRU ';
         strSqlEmail := strSqlEmail + '                    AND EMASAI.EMA_CODIGO = PORAEN.AEN_CODCFG ';
         strSqlEmail := strSqlEmail + '                    AND EMASAI.EMA_CODEMP = PORAEN.AEN_CODEMP ';
         strSqlEmail := strSqlEmail + '  WHERE PORAEN.AEN_CODGRU = :CODGRU ';
         strSqlEmail := strSqlEmail + '    AND PORAEN.AEN_CODCFG = :CODCFG ';
         strSqlEmail := strSqlEmail + '    AND PORAEN.AEN_CODEMP = :CODEMP ';
         strSqlEmail := strSqlEmail + '    AND PORAEN.AEN_CODTIP = 0       ';
         strSqlEmail := strSqlEmail + '    AND EMASAI.EMA_STATUS = ''A''   ';

         LQryPor.SQL.Text := strSqlEmail
      End
      Else
      If intTip = 1 Then //sms
      Begin
         strSqlSMS := '';
         strSqlSMS := strSqlSMS + ' SELECT PORAEN.AEN_CODPOR FROM SMSSAI ';
         strSqlSMS := strSqlSMS + '  INNER JOIN PORAEN  ON SMSSAI.SMS_CODGRU = PORAEN.AEN_CODGRU ';
         strSqlSMS := strSqlSMS + '                    AND SMSSAI.SMS_CODIGO = PORAEN.AEN_CODCFG ';
         strSqlSMS := strSqlSMS + '                    AND SMSSAI.SMS_CODEMP = PORAEN.AEN_CODEMP ';
         strSqlSMS := strSqlSMS + ' WHERE PORAEN.AEN_CODGRU    = :CODGRU ';
         strSqlSMS := strSqlSMS + '    AND   PORAEN.AEN_CODCFG = :CODCFG ';
         strSqlSMS := strSqlSMS + '    AND   PORAEN.AEN_CODEMP = :CODEMP ';
         strSqlSMS := strSqlSMS + '    AND   PORAEN.AEN_CODTIP = 1       ';
         strSqlSMS := strSqlSMS + '    AND   SMSSAI.SMS_STATUS = ''A''   ';

         LQryPor.SQL.Text := strSqlSMS;
      End
      Else
      If intTip = 2 Then //Whatsapp
      Begin
         strSqlWhatsapp := '';
         strSqlWhatsapp := strSqlWhatsapp + ' SELECT PORAEN.AEN_CODPOR FROM WPPSAI ';
         strSqlWhatsapp := strSqlWhatsapp + '  INNER JOIN PORAEN  ON WPPSAI.WPP_CODGRU = PORAEN.AEN_CODGRU ';
         strSqlWhatsapp := strSqlWhatsapp + '                    AND WPPSAI.WPP_CODIGO = PORAEN.AEN_CODCFG ';
         strSqlWhatsapp := strSqlWhatsapp + '                    AND WPPSAI.WPP_CODEMP = PORAEN.AEN_CODEMP ';
         strSqlWhatsapp := strSqlWhatsapp + ' WHERE PORAEN.AEN_CODGRU    = :CODGRU ';
         strSqlWhatsapp := strSqlWhatsapp + '    AND   PORAEN.AEN_CODCFG = :CODCFG ';
         strSqlWhatsapp := strSqlWhatsapp + '    AND   PORAEN.AEN_CODEMP = :CODEMP ';
         strSqlWhatsapp := strSqlWhatsapp + '    AND   PORAEN.AEN_CODTIP = 1       ';
         strSqlWhatsapp := strSqlWhatsapp + '    AND   WPPSAI.WPP_STATUS = ''A''   ';

         LQryPor.SQL.Text := strSqlWhatsapp;
      End;

      LQryPor.Parambyname('CODGRU').value := ACodGru;
      LQryPor.Parambyname('CODCFG').value := ACodCfg;
      LQryPor.Parambyname('CODEMP').value := ACodEmp;
      LQryPor.Open;

      Result := fCriaClientDatSet(LQryPor);

    Finally
      FreeAndNil(LQryPor);
    End;

  End;


  function fRetornaAutoIncremDups() : String;
  Var Str : String;
      intContador : Integer;
  Begin

    Str := '';
    For intContador := 0 To Length(arrCtrDup) -1 Do
      Str := Str + '"' + arrCtrDup[intContador].strAutoIn + '"' +
                         IIF(intContador < Length(arrCtrDup) - 1, ',', ' ');

    Result := Str;

  End;


  function pCarregaTabelaDupEmail( strCodCli : string) : TArrDupTabelaEmail;
   Var qryDadosDups : TUniQuery;
       StrSQL : String;
       arrDupT: TArrDupTabelaEmail;
  Begin

    qryDadosDups := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT                                              ';
    strSQL := strSQL + '  R.*                                               ';
    strSQL := strSQL + 'FROM                                                ';
    strSQL := strSQL + '  CADREC R                                          ';
    strSQL := strSQL + 'WHERE R.CTR_CODCLI = :CODCLI                        ';
    strSQL := strSQL + '  AND                                               ';
    strSQL := strSQL + '     R.AUTOINCREM IN (' + fRetornaAutoIncremDups +  ') ';

    qryDadosDups.SQL.Clear;
    qryDadosDups.SQL.Add(strSQL);
    qryDadosDups.ParamByName('CODCLI').AsString := strCodCli;
    qryDadosDups.Open;

    SetLength(arrDupT,0);

    qryDadosDups.First;
    While Not qryDadosDups.Eof Do
    Begin
      SetLength(arrDupT,Length(arrDupT)+1);
      arrDupT[Length(arrDupT)-1].strNumDoc := qryDadosDups.FieldByName('CTR_NUMDUP').AsString;//NRODUP
      arrDupT[Length(arrDupT)-1].strParcel := qryDadosDups.FieldByName('CTR_PARCEL').AsString;//PARDUP
      arrDupT[Length(arrDupT)-1].strEspDoc := qryDadosDups.FieldByName('CTR_ESPDOC').AsString;
      arrDupT[Length(arrDupT)-1].strCodEmp := qryDadosDups.FieldByName('CTR_CODEMP').AsString;
      arrDupT[Length(arrDupT)-1].strCodCli := qryDadosDups.FieldByName('CTR_CODCLI').AsString;
      arrDupT[Length(arrDupT)-1].dtaDtaCad := qryDadosDups.FieldByName('CTR_DTACAD').AsDatetime;
      arrDupT[Length(arrDupT)-1].dtaDtaVen := qryDadosDups.FieldByName('CTR_DTAVEN').AsDatetime;
      arrDupT[Length(arrDupT)-1].fltVlrDup := qryDadosDups.FieldByName('CTR_VALDUP').AsFloat;
      arrDupT[Length(arrDupT)-1].strAutoIn := qryDadosDups.FieldByName('AUTOINCREM').AsString;
      arrDupT[Length(arrDupT)-1].intSeqBai := qryDadosDups.FieldByName('CTR_SEQBAI').AsInteger;
      arrDupT[Length(arrDupT)-1].strLinDig := qryDadosDups.FieldByName('CTR_LINDIG').AsString;

     Application.ProcessMessages;

     qryDadosDups.Next;
    End;

    Result := arrDupT;

    FreeAndNil(qryDadosDups);

  End;

begin
  Result := False;

  blnEnvMaiV          := False;
  blnPortadorAlterado := False;
  blnDupMercantil     := False;
  blnEditaEmail       := False;

  stlBoletosRealocados := TStringList.Create();

  blnMsg := False;

  cdsBoletos.First;

  ABoletoCarne := fCfgSis('NOVLAY') = 'C';
  ABoleto1Via  := fCfgSis('NOVLAY') = 'U';

  if (Not blnFaturamento) And (Not blnEnvioAutmaticoEmail) And Not (fCfgSis('GRVBOL') = '2')  then
    thrSincEmail    := TThreadSincronizaEmails.Create
  Else
    thrSincEmail    := nil;

  //cdsBoletos.IndexFieldNames := 'AUTOINCREM'; //Necessario para utilizar o metodo FindKey
  stlClientes := TStringList.Create();

  Try

    FCodBco     := cdsBoletos.FieldByName('CTR_BCOBOL').AsString;
    FCodPor     := cdsBoletos.FieldByName('CTR_CODPOR').AsString;
    FValMor     := fCfgSis('TAXDIA', varDouble);
    FNosNum     := cdsBoletos.FieldByName('CTR_NOSNUM').AsString;
    FMens01     := '';
    FMens02     := '';

    FBcoIni := Copy(cdsBoletos.FieldByName('CTR_CARTEI').AsString, 7, Length(cdsBoletos.FieldByName('CTR_CARTEI').AsString));
    FBcoIni := Copy(FBcoIni, 1, Pos('-', FBcoIni)-1);

    FCodCar     := fRetNumCartReimpressao(cdsBoletos.FieldByName('CTR_CARTEI').AsString);

    FPerMul   := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'PERMULT', '');
    If Not fEmptyStr(FPerMul) Then
      FMulta_ := fStrToFloat(FPerMul);

    FBraCrr := '';
    If (FCodBco = '422') Or
       (FCodBco = '090') Then
      FBraCrr := fGetBancoConfig(0, 'CONFIG' + FBcoIni + '-' + cdsBoletos.FieldByName('CTR_CARTEI').AsString, 'CORBRAD', '');


    FBB_Crr := '';
    FConCrr := '';
    If FCodBco = '756_240p' Then
    Begin
      FBB_Crr := fGetBancoConfig(0, 'CONFIG756_240p-' + cdsBoletos.FieldByName('CTR_CARTEI').AsString, 'USACRR_', '');
      FConCrr := fGetBancoConfig(0, 'CONFIG756_240p-' + cdsBoletos.FieldByName('CTR_CARTEI').AsString, 'CONVCRR', '');
    End;

    FAltImp := False;

    blnConfirma := True;
  Except
    On E: Exception Do
    Begin
      pGravarErro(True, E.Message + ' [TBoleto.fImprimir]');
      blnConfirma := False;
    End;
  End;

  If (blnDupMercantil) or (Pos(FCodBco, '999_888_') > 0) Then
    Exit;

  If blnConfirma Then
  Begin
    strNomImp := strNomImpBol;
    strNomFrm := IIF(blnFaturamento, 'frmFatVendas_BOLETO', 'frmImpBoletoIndiv');

    if FCodBco <> '778' then
      strTipBol := 'J';

    blnBolPdfV := True;

    If (FBcoIni = '001API') Then
      LBancoDoBrasilApi := TBancoDoBrasilAPI.Create('CONFIG' + strBcoIni + '-' + IntToStr(intCodCar) +'-'+ VS_strCodEmp);

    If (FBcoIni = '097API') Then
      LBancoCredisisApi := TBancoCredisisAPI.Create('CONFIG' + strBcoIni + '-' + IntToStr(intCodCar) +'-'+ VS_strCodEmp);

    If (FBcoIni = '748API') Then
      LBancoSicrediApi := TBancoSicrediAPI.Create('CONFIG' + strBcoIni + '-' + IntToStr(intCodCar) +'-'+ VS_strCodEmp);

    If (FBcoIni = '341API') Then
      FBancoItauApi := TBancoItauAPI.Create('CONFIG' + strBcoIni + '-' + IntToStr(intCodCar) +'-'+ VS_strCodEmp);

    If (FBcoIni = '756API') Then
      FBancoSicoobApi := TBancoSicoobAPI.Create('CONFIG' + strBcoIni + '-' + IntToStr(intCodCar) +'-'+ VS_strCodEmp);

    If (FBcoIni = '033API') Then
      FBancoSantanderApi := TBancoSantanderAPI.Create('CONFIG' + strBcoIni + '-' + IntToStr(intCodCar) +'-'+ VS_strCodEmp);

    If (FBcoIni = '422API') Then
      LBancoSafraApi := TBancoSafraAPI.Create('CONFIG' + strBcoIni + '-' + IntToStr(intCodCar) +'-'+ VS_strCodEmp);

    If (FBcoIni = '237API') Then
      FBancoBradescoApi := TBancoBradescoAPI.Create('CONFIG' + strBcoIni + '-' + IntToStr(intCodCar) +'-'+ VS_strCodEmp);

    pProcessarClientesCtrDup();

    For intContCli := 0 To stlClientes.Count - 1 Do
    Begin
      strEmailCli   := '';
      strArqBoletos := '';

      SetLength(ACorpoMensagem, 1);
      ACorpoMensagem[0] := 'Segue(m) relação do(s) boleto(s) em anexo: ';

      For intCont := 0 To Length(arrCtrDup)-1 Do
      Begin
        If (stlClientes[intContCli] <> arrCtrDup[intCont].strCodCli) Then
          Continue;

        pAtualizaCamposUso(arrCtrDup[intCont]);

        blnConfirma := Not fDuplicataCtrBaixada(qryConRec.FieldByName('CTR_NUMDUP').AsString,
                                                qryConRec.FieldByName('CTR_PARCEL').AsString,
                                                qryConRec.FieldByName('CTR_ESPDOC').AsString,
                                                qryConRec.FieldByName('CTR_CODEMP').AsString,
                                                qryConRec.FieldByName('CTR_CODCLI').AsString,
                                                qryConRec.FieldByName('CTR_SEQBAI').AsInteger);

        If Not blnConfirma Then
        Begin
          fStartTransaction;
          untCadRec.pGravaLogCtr(qryConRec.FieldByName('AUTOINCREM').AsString,
                                 'TENTATIVA ENVIO AUTOMÁTICO DE E-MAIL DUP BAIXADA',
                                 'untBoletos');
          fCommit;

          Continue;
        End;

        If FCodBco <> '778' Then
        Begin

          Try
            strReimpr := 'N';

            If (Not fEmptyStr(qryConRec.FieldByName('CTR_NOSNUM').AsString)) Then
              strPortadorAnt := qryConRec.FieldByName('CTR_CODPOR').AsString;

            If ( fCfgSis('DESPON', varBoolean)       ) And
               (qryConRec.FieldByName('CTR_PERDPO').AsFloat > 0) Then
            Begin
              If qryConRec.FieldByName('CTR_QTDDAV').AsInteger > 0 Then
                FMens01 := 'CONCEDER DESCONTO DE ' + FormatFloat('#,##0.00', qryConRec.FieldByName('CTR_PERDPO').AsFloat) + '% SE PAGO ATE ' +
                           DateToStr(qryConRec.FieldByName('CTR_DTAVEN').AsDateTime - qryConRec.FieldByName('CTR_QTDDAV').AsInteger) + '.'
              Else
                FMens01 := 'CONCEDER DESCONTO DE ' + FormatFloat('#,##0.00', qryConRec.FieldByName('CTR_PERDPO').AsFloat) +
                           '% SE PAGO ATE O VENCIMENTO.';
            End
            Else If fCfgSis('DESPON', varBoolean) Then
              FMens01 := '';

            FDesCtr := qryConRec.FieldByName('CTR_DESSUJ').AsFloat;

            If (Not fEmptyStr(qryConRec.FieldByName('CTR_NOSNUM').AsString)) And (qryConRec.FieldByName('CTR_BCOBOL').AsString = FCodBco) And Not (FAltImp) Then
            Begin
              if not (fRetNumCartReimpressao(qryConRec.FieldByName('CTR_CARTEI').AsString) = FCodCar) then
              begin
                fGravaNumCart(FCodBco,
                              IIF(fEmptyStr(strPortadorAnt), FCodPor, strPortadorAnt),
                              FNosNum,
                              FNumDig,
                              Nil,
                              @arrCtrDup[intCont],
                              FBcoIni,
                              FCodCar,
                              FBB_Crr,
                              FValMor,
                              fStrToFloat(FPerMul));
              end;

              strNosNumReimpr := fNossoNumeroAnterior(arrCtrDup[intCont], FCodPor = qryConRec.FieldByName('CTR_CODPOR').AsString);
              strReimpr := 'S';

              If FCodBco = '077' Then
                strLinhaDigitavelAPI := qryConRec.FieldByName('CTR_LINDIG').AsString;

              If MatchStr(FBcoIni, ['001API']) Then
              Begin
                LBancoDoBrasilApi.ReimpressaoDeBoleto(qryConRec.FieldByName('AUTOINCREM').AsString);
                TRetornoBoletoBancoDoBrasil(LRetornoRegistroBoletoApi) := LBancoDoBrasilApi.RetornoBandoDoBrasilAPI;
              End;

              If MatchStr(FBcoIni, ['097API']) Then
              Begin
                //LBancoCredisisApi.ReimpressaoDeBoleto(qryConRec.FieldByName('AUTOINCREM').AsString);
                ReimpressaoBoletoBancoCredisisAPI( LBancoCredisisApi, qryConRec.FieldByName('AUTOINCREM').AsString );
                TRetornoBoletoBancoCredisis(LRetornoRegistroBoletoApi) := LBancoCredisisApi.RetornoBancoCredisisAPI;
              End;

              If MatchStr(FBcoIni, ['748API']) Then
              Begin
                LBancoSicrediApi.ReimpressaoDeBoleto(qryConRec.FieldByName('AUTOINCREM').AsString );
                TRetornoBoletoBancoSicredi(LRetornoRegistroBoletoApi) := LBancoSicrediApi.RetornoBancoSicrediAPI;
              End;

              If MatchStr(FBcoIni, ['341API']) Then
              Begin
                FBancoItauApi.ReimpressaoDeBoleto(qryConRec.FieldByName('AUTOINCREM').AsString );
                TRetornoBoletoItau(LRetornoRegistroBoletoApi) := FBancoItauApi.RetornoBancoItauAPI;
              End;

              If MatchStr(FBcoIni, ['756API']) Then
              Begin
                FBancoSicoobApi.ReimpressaoDeBoleto(qryConRec.FieldByName('AUTOINCREM').AsString );
                TRetornoBoletoSicoob(LRetornoRegistroBoletoApi) := FBancoSicoobApi.RetornoBancoSicoobAPI;
              End;

              If MatchStr(FBcoIni, ['033API']) Then
              Begin
                FBancoSantanderApi.ReimpressaoDeBoleto(qryConRec.FieldByName('AUTOINCREM').AsString );
                TRetornoBoletoSantander(LRetornoRegistroBoletoApi) := FBancoSantanderApi.RetornoBancoSAntanderAPI;
              End;

              If MatchStr(FBcoIni, ['422API']) Then
              Begin
                LBancoSafraApi.ReimpressaoDeBoleto(qryConRec.FieldByName('AUTOINCREM').AsString );
                TRetornoBoletoBancoSafra(LRetornoRegistroBoletoApi) := LBancoSafraApi.RetornoBancoSafraAPI;
              End;

              If MatchStr(FBcoIni, ['237API']) Then
              Begin
                FBancoBradescoApi.ReimpressaoDeBoleto(qryConRec.FieldByName('AUTOINCREM').AsString);
                TRetornoBoletoBradesco(LRetornoRegistroBoletoApi) := FBancoBradescoApi.RetornoBancoBradescoAPI;
              End;

            End
            Else
            Begin
              qryGen := fCriaQuery(Self);

              fStartTransaction;

              {************************************************}
              {* TRAVA A TABELA CADBCO PARA PEGAR NOSSONUMERO *}
              {*********************************************AF*}
              qryGen.SQL.Add('SELECT * FROM CADBCO WHERE BCO_CODBCO = :CODBCO FOR UPDATE');
              qryGen.ParamByName('CODBCO').AsString := FCodBco;
              qryGen.Open;

              strNosNumNovo := fRetNossoNumeroDisponivel(FCodBco, FNosNum, FBcoIni, FCodCar, VS_strCodEmp);
              strNosNumNovo := fCalcNossoNumero(FCodBco, strNosNumNovo, FBcoIni, FCodCar, VS_strCodEmp);

              If fEmptyStr(strNosNumNovo) Then
              Begin
                If FCodBco = '104' Then
                Begin
                  If (fGetBancoConfig(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'NUMCART', '') = '12')   And
                     (fGetBancoConfig(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'SISCOB', '') = 'SIGCB') Then
                  Begin
                    fLock_Unlock(fChaveLockImpressaoBoletos, False);
                    Exit;
                  End;
                End;

                Raise Exception.Create('Não foi possível determinar o nosso número. Por favor, verifique.')
              End
              Else
                FNosNum := strNosNumNovo;

              strTpIden := fGetBancoConfig(0,'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar),'TPIDENT', '5');
              If (strTpIden = '4') Then
                FNumDig := fCalcDigito(FCodBco, IntToStr(StrToInt64(strNosNumNovo)), FBcoIni, FCodCar, qryConRec.FieldByName('CTR_DTAVEN').AsString)
              Else
                FNumDig := fCalcDigito(FCodBco, IntToStr(StrToInt64(strNosNumNovo)), FBcoIni, FCodCar, VS_strCodEmp);

              qryGen.Close;
              FreeAndNil(qryGen);
            End;

            {******************}
            {* TRAVA O LCKATC *}
            {***************AF*}
            While (Not blnEnvioAutmaticoEmail) And
                  (Not fLock_Unlock(fChaveLockImpressaoBoletos, True, True, Not blnEnvioAutmaticoEmail, '', ((Not blnEnvioAutmaticoEmail) And (Not AGeraBoleto )))) Do
              Application.ProcessMessages;

            if strReimpr <> 'S' then
            begin
              If Not fGravaNumBco(FCodBco,
                                   {************************************************}
                                   {* VERIFICAÇÃO DE PORTADOR COMENTADA POR NÃO    *}
                                   {* ESTAR GRAVANDO O ULTIMO PORTADOR DO BOLETO.  *}
                                   {* AO ALTERAR O PORTADOR E O BANCO DO BOLETO NA *}
                                   {* REIMPRESSÃO, ATUALIZAR BANCO E PORTADOR.     *}
                                   {*RQ: 31709 **********************************BB*}
                                   //IIF(fEmptyStr(strPortadorAnt), FCodPor, strPortadorAnt),
                                    FCodPor,
                                    FNosNum,
                                    FNumDig,
                                    qryConRec,
                                    @arrCtrDup[intCont],
                                    FBcoIni,
                                    FCodCar,
                                    FBB_Crr,
                                    FValMor,
                                    fStrToFloat(FPerMul),
                                    '',
                                    '',
                                    '',
                                    FMens01,
                                    FMens02) Then
              begin
                Raise Exception.Create('Não foi possível fazer a gravação do Nosso Número no Contas a receber! Tente Novamente!');
              end;
            end;

            blnConfirma := fGeraBoletoLaser(FCodBco,
                                            cpuCampos,
                                            FValMor,
                                            IIF(fEmptyStr(strNosNumReimpr), FNosNum, strNosNumReimpr),
                                            FNumDig,
                                            fCadEmp('NOMEMP'),
                                            fCadEmp('C_G_C_'),
                                            FBcoIni,
                                            FCodCar,
                                            strArqBoletos,
                                            FBoletoCarneBuilder,
                                            FBoleto1ViaBuilder,
                                            FMens01,
                                            FMens02,
                                            strReimpr,
                                            strPathBol,
                                            blnBolPdfV,
                                            FBraCrr,
                                            FBB_Crr,
                                            FConCrr,
                                            strNomFrm,
                                            strNomImpBol,
                                            FMulta_,
                                            False,
                                            arrCtrDup[intCont].blnAvisoAutomaticoEmail,
                                            '',
                                            '',
                                            True,
                                            '',
                                            fCfgSis('BOLORI', varBoolean));

            If blnConfirma Then
            begin
              SetLength(ACorpoMensagem, Length(ACorpoMensagem)+1);
              ACorpoMensagem[Length(ACorpoMensagem)-1] := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');

              If (Not AEnviouEmail) Or (Not AEnviouWpp) Then
                fGravaDtaBoletoImpresso(qryConRec);

              If AGeraBoleto Then
              Begin
                If Not ABoletoCarne Then
                Begin
                  GravarPDFBoleto(AnsiReplaceStr(cpuCampos['CADREC->AUTOINCREM'], #39, ''),
                                ExtractFilePath(Application.ExeName) + 'Boletos\' + AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '') + '.pdf');
                End;
              End;

              {******************************************************}
              {*COMMITA NESTE PONTO SE O TIPO DE BOLETO NÃO É CARNE,*}
              {*DO CONTRARIO DEVE COMMITAR SOMENTE APOS A IMPRESSÃO *}
              {*DO CARNE                                            *}
              {***************************************************GD*}
              if (Not ABoletoCarne) And (Not ABoleto1Via) then
                fCommit;

              {****************}
              {* GRAVA LOGCTR *}
              {*************JS*}
              If (Not AEnviouEmail) Or (Not AEnviouWpp) Then
              Begin
                fStartTransaction;
                untCadRec.pGravaLogCtr(qryConRec.FieldByName('AUTOINCREM').AsString, IIF(strReimpr = 'N', 'IMPRESSÃO DE BOLETO', 'REIMPRESSÃO DE BOLETO'), 'untBoletos');
                fCommit;
              End;

              If (Not blnEnvioAutmaticoEmail) Then
                fLock_Unlock(fChaveLockImpressaoBoletos, False);
            end
            ELSE
            BEGIN
              fRollBack;
              If (Not blnEnvioAutmaticoEmail) Then
                fLock_Unlock(fChaveLockImpressaoBoletos, False);

              pGravarErro(True, 'Não foi possível imprimir o boleto selecionado. ' + #13 +
                                'Duplicata:' + Concat(qryConRec.FieldByName('CTR_NUMDUP').AsString,
                                                      qryConRec.FieldByName('CTR_PARCEL').AsString, '-',
                                                      qryConRec.FieldByName('CTR_ESPDOC').AsString, '-',
                                                      qryConRec.FieldByName('CTR_CODEMP').AsString, '-',
                                                      qryConRec.FieldByName('CTR_CODCLI').AsString) );
              Exit;
            END;

            If strReimpr = 'N' Then
              If Not fEmptyStr(FNosNum) Then
                FNosNum := IntToStr(StrToInt64(FNosNum)+1);

            strReimpr := 'N';
            strNosNumReimpr := '';

          Except
            On E: Exception Do
            Begin
              fRollBack;
              If (Not blnEnvioAutmaticoEmail) Then
                fLock_Unlock(fChaveLockImpressaoBoletos, False);
              pGravarErro(True, E.Message + '[TBoleto.pImprimir]', fRetornaStack);
              Exit;
            End;
          End;

        End;

        If (fCfgSis('GRVBOL') = '2') And (Not ABoletoCarne) And (Not ABoleto1Via) Then
        Begin
           GravaPDFPorEmpresa( AnsiReplaceStr(cpuCampos['CADREC->AUTOINCREM'], #39, ''),
                               ExtractFilePath(Application.ExeName) + 'Boletos\' + AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '') + '.pdf');

           stlBoletosRealocados.Add( AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '') + '.pdf' );
        End;

      End;

      if  (ABoletoCarne) And Not MatchStr(strBcoIni, ['077','748API','021']) then
      begin
        try
          if FBoletoCarneBuilder.fImprimiBoletoCarne(False, strNomFrm, strNomImp, False, blnEnvioAutmaticoEmail, True) then
          begin
            strArqBoletos := FBoletoCarneBuilder.fGetListaArquivosGerados;

            If AGeraBoleto Then
            Begin
              GravarPDFBoletosCarne(arrCtrDup,
                                   ExtractFilePath(Application.ExeName) + 'Boletos\');

              Try
                RenameFile(ExtractFilePath(Application.ExeName) + 'Boletos\' + arrCtrDup[0].strNumDup + '.pdf',
                           ExtractFilePath(Application.ExeName) + 'Boletos\' + arrCtrDup[0].strNumDup + arrCtrDup[0].strParcel+'.pdf');
              Except
               // não faz nada
              End;
            End;


            fCommit;
          end
          else
          begin
            fRollBack;

            If (Not blnEnvioAutmaticoEmail) Then
              fLock_Unlock(fChaveLockImpressaoBoletos, False);

            pGravarErro(True, 'Não foi possível imprimir o(s) boleto(s) selecionado(s).' + #13 +
                                'Duplicata:' + Concat(qryConRec.FieldByName('CTR_NUMDUP').AsString,
                                                      qryConRec.FieldByName('CTR_PARCEL').AsString, '-',
                                                      qryConRec.FieldByName('CTR_ESPDOC').AsString, '-',
                                                      qryConRec.FieldByName('CTR_CODEMP').AsString, '-',
                                                      qryConRec.FieldByName('CTR_CODCLI').AsString) );
            Exit;
          end;

        Except
          On E: Exception Do
          Begin
            fRollBack;

            If (Not blnEnvioAutmaticoEmail) Then
              fLock_Unlock(fChaveLockImpressaoBoletos, False);

            pGravarErro(True, E.Message + '[TBoleto.pImprimir]');
            Exit;
          End;
        End;
      end
      else
      if (ABoleto1Via) And (FCodBco <> '077') then
      begin
        try
          if FBoleto1ViaBuilder.fImprimiBoleto1Via(False, strNomFrm, strNomImp, False, blnEnvioAutmaticoEmail) then
          begin
            strArqBoletos := FBoleto1ViaBuilder.fGetListaArquivosGerados;

            fCommit;
          end
          else
          begin
            fRollBack;

            If (Not blnEnvioAutmaticoEmail) Then
              fLock_Unlock(fChaveLockImpressaoBoletos, False);

            pGravarErro(True, 'Não foi possível imprimir o(s) boleto(s) selecionado(s).' + #13 +
                                'Duplicata:' + Concat(qryConRec.FieldByName('CTR_NUMDUP').AsString,
                                                      qryConRec.FieldByName('CTR_PARCEL').AsString, '-',
                                                      qryConRec.FieldByName('CTR_ESPDOC').AsString, '-',
                                                      qryConRec.FieldByName('CTR_CODEMP').AsString, '-',
                                                      qryConRec.FieldByName('CTR_CODCLI').AsString) );
            Exit;
          end;

        Except
          On E: Exception Do
          Begin
            fRollBack;

            If (Not blnEnvioAutmaticoEmail) Then
              fLock_Unlock(fChaveLockImpressaoBoletos, False);

            pGravarErro(True, E.Message + '[TBoleto.pImprimir]');
            Exit;
          End;
        End;
      end
      else
        strArqBoletos := LeftStr(strArqBoletos, Length(strArqBoletos)-1);

      strArqBoletos := strArqBoletos.Replace(ExtractFilePath(Application.ExeName) + 'Boletos\',
                                               RetornaPastaBoletos(qryConRec.FieldByName('CTR_CODEMP').AsString,
                                                                   ABoletoCarne, ABoleto1Via));

      Result := blnConfirma;

      strEmailCli := '';
      If (blnEnvMaiV) Or (blnEmaAut) Then
        strEmailCli := fRetornaEmailCliente(qryConCli);

      If (Result) And (Not fEmptyStr(strArqBoletos)) And (blnEnvMaiV Or blnEmaAut) Then
      Begin
        If (blnEmaAut) Then
        Begin
          Result := False;

          If (Not AEnviouWpp) Then
          Begin
            objDadosWPP.strNumDoc         := qryConRec.FieldByName('CTR_NUMDUP').AsString;
            objDadosWPP.strCodCli         := qryConRec.FieldByName('CTR_CODCLI').AsString;
            objDadosWPP.strEspDoc         := qryConRec.FieldByName('CTR_ESPDOC').AsString;
            objDadosWPP.strCodEmp         := qryConRec.FieldByName('CTR_CODEMP').AsString;
            objDadosWPP.strNumOrc         := strNum_PD;
            objDadosWPP.strEspOrc         := IfThen(fEmptyStr(strNum_PD), '', 'PD');
            objDadosWPP.strEmpOri         := strEmp_PD;
            objDadosWPP.strCelula         := qryConCli.FieldByName('CLI_CELULA').AsString;
            objDadosWPP.strLinhaDigitavel := qryConRec.FieldByName('CTR_LINDIG').AsString;
            objDadosWPP.strDtaEmi         := FormatDateTime('dd/mm/yy', qryConRec.FieldByName('CTR_DTACAD').AsDateTime);
            objDadosWPP.strValDup         := FormatFloat( '#,##0.00', qryConRec.FieldByName('CTR_VALDUP').AsFloat);
            objDadosWPP.strParcel         := qryConRec.FieldByName('CTR_PARCEL').AsString;
            objDadosWPP.strDtaVen         := FormatDateTime('dd/mm/yy', qryConRec.FieldByName('CTR_DTAVEN').AsDateTime);
            objDadosWPP.strLinkDoBoleto   := qryConRec.FieldByName('LINK_DO_BOLETO').AsString;

            objDadosWPP.QRCodePix    := RetornaLinkPixCitelValido(qryConRec);
            If objDadosWPP.QRCodePix.IsEmpty Then
              objDadosWPP.QRCodePix := qryConRec.FieldByName('CTR_QRCODE').AsString;

            SetLength(recArquivos, 0);

            If ((fCfgSis('NOVLAY') <> 'C') And (fCfgSis('NOVLAY') <> 'U')) Or (fCodBco = '077') Then
            Begin
              if blnEnvioAutmaticoEmail then
              begin
                strBoleto := RetornaPastaBoletos(qryConRec.FieldByName('CTR_CODEMP').AsString,
                                                 ABoletoCarne, ABoleto1Via) + qryConRec.FieldByName('CTR_NUMDUP').AsString +
                                                                 qryConRec.FieldByName('CTR_PARCEL').AsString + '.pdf';

                SetLength(recArquivos, Length(recArquivos)+1);
                recArquivos[High(recArquivos)] := TRecArquivosGatilhos.Create('BOLETO_'+ExtractFileName(strBoleto).Replace(ExtractFileExt(ExtractFileName(strBoleto)), EmptyStr)+'-'+qryConRec.FieldByName('CTR_ESPDOC').AsString,
                                                                              strBoleto,
                                                                              EmptyStr);
              end
              else
              begin
                arrBoletos := strArqBoletos.Split([',']);
                for strBoleto in arrBoletos do
                begin
                  SetLength(recArquivos, Length(recArquivos)+1);
                  recArquivos[High(recArquivos)] := TRecArquivosGatilhos.Create('BOLETO_'+ExtractFileName(strBoleto).Replace(ExtractFileExt(ExtractFileName(strBoleto)), EmptyStr)+'-'+qryConRec.FieldByName('CTR_ESPDOC').AsString,
                                                                                strBoleto,
                                                                                EmptyStr);
                end;
              end;

              objDadosWPP.RecArquivos := recArquivos;
            end
            else
            begin
              arrBoletos := strArqBoletos.Split([',']);
              for strBoleto in arrBoletos do
              begin
                SetLength(recArquivos, Length(recArquivos)+1);
                recArquivos[High(recArquivos)] := TRecArquivosGatilhos.Create('BOLETO_'+ExtractFileName(strBoleto).Replace(ExtractFileExt(ExtractFileName(strBoleto)), EmptyStr)+'-'+qryConRec.FieldByName('CTR_ESPDOC').AsString,
                                                                              strBoleto,
                                                                              EmptyStr);
              end;

              objDadosWPP.RecArquivos := recArquivos;
            end;

            AEnviouWpp := fDisparaWhatsAppBoletoAutomatico(objDadosWPP,
                                                           IIF(blnEnvioAutmaticoEmail, 'AC', 'BO'),
                                                           objStatusEmailAutomatico);

            Result := AEnviouWpp;
          End;

          If (Not AEnviouEmail) Then
          Begin
            pRetNumeroPedidoVenda(qryConRec.FieldByName('CTR_NUMDUP').AsString,
                                  qryConRec.FieldByName('CTR_ESPDOC').AsString,
                                  qryConRec.FieldByName('CTR_CODEMP').AsString,
                                  qryConRec.FieldByName('CTR_CODCLI').AsString,
                                  strNum_PD,
                                  strEmp_PD);

            objDadosEmail.strNumDoc         := qryConRec.FieldByName('CTR_NUMDUP').AsString;
            objDadosEmail.strCodCli         := qryConRec.FieldByName('CTR_CODCLI').AsString;
            objDadosEmail.strEspDoc         := qryConRec.FieldByName('CTR_ESPDOC').AsString;
            objDadosEmail.strCodEmp         := qryConRec.FieldByName('CTR_CODEMP').AsString;
            objDadosEmail.strNumOrc         := strNum_PD;
            objDadosEmail.strEspOrc         := IfThen(fEmptyStr(strNum_PD), '', 'PD');
            objDadosEmail.strEmpOri         := strEmp_PD;

            objDadosWPP.DiasVencimento := Abs(DaysBetween(VS_Date, qryConRec.FieldByName('CTR_DTAVEN').AsDateTime)).ToString;

            If ((fCfgSis('NOVLAY') <> 'C') And (fCfgSis('NOVLAY') <> 'U')) Or (fCodBco = '077') Then
              strArqBoletosWppEma := IfThen(blnEnvioAutmaticoEmail,
                                            RetornaPastaBoletos(qryConRec.FieldByName('CTR_CODEMP').AsString,
                                                                ABoletoCarne, ABoleto1Via) + qryConRec.FieldByName('CTR_NUMDUP').AsString +
                                                                                qryConRec.FieldByName('CTR_PARCEL').AsString + '.pdf',
                                            strArqBoletos)
            Else
              strArqBoletosWppEma := strArqBoletos;

            arrBoletos := strArqBoletosWppEma.Split([',']);
            for strBoleto in arrBoletos do
            begin
              SetLength(recArquivos, Length(recArquivos)+1);
              recArquivos[High(recArquivos)] := TRecArquivosGatilhos.Create('BOLETO_'+ExtractFileName(strBoleto).Replace(ExtractFileExt(ExtractFileName(strBoleto)), EmptyStr)+'-'+qryConRec.FieldByName('CTR_ESPDOC').AsString,
                                                                            strBoleto,
                                                                            EmptyStr);
            end;

            objDadosEmail.RecArquivos := recArquivos;

            objDadosEmail.strEmailCli       := strEmailCli;
            objDadosEmail.strLinhaDigitavel := qryConRec.FieldByName('CTR_LINDIG').AsString;
            objDadosEmail.strDtaEmi         := DateToStr(qryConRec.FieldByName('CTR_DTACAD').AsDateTime);
            objDadosEmail.strValDup         := FormatFloat( 'R$ #,##0.00', qryConRec.FieldByName('CTR_VALDUP').AsFloat);
            objDadosEmail.strParcel         := qryConRec.FieldByName('CTR_PARCEL').AsString;
            objDadosEmail.strDtaVen         := DateToStr(qryConRec.FieldByName('CTR_DTAVEN').AsDateTime);

            if (fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [qryConRec.FieldByName('CTR_CODCLI').AsString], False) = 'S')
            And ((fCfgSis('NOVLAY') = 'C') Or (fCfgSis('NOVLAY') = 'P') Or (fCfgSis('NOVLAY') = 'U')) Then
            begin

              blnMsg := (fCfgSis('NOVLAY') = 'C') Or (fCfgSis('NOVLAY') = 'U');

              If Not blnMsg Then
                blnMsg := (fCfgSis('NOVLAY') = 'P') And (MatchStr(fCodBco, ['001','001D7','756','099','341','748','033','033B','237','104','104D7', '084']));

              If blnMsg Then
              Begin
                 strCorpo := strCorpo + '<p>Para abrir a sua fatura é necessário digitar os 5 primeiros números do CPF ou CNPJ do titular da assinatura.</p>';
                 strCorpo := strCorpo + '<p>Exemplo: CPF: 123.45.789-00 ==> digitar: 12345</p>';
                 strCorpo := strCorpo + '<p>* os números do exemplo acima são fictícios.</p>';
                 objDadosEmail.strCorpoAdicional := strCorpo;
              End;

            end;

            If Length(qryConRec.FieldByName('CTR_LINDIG').AsString) = 48 Then
              objDadosEmail.CorpoEmailFixo := GetHtmlContent(qryConCli.FieldByName('CLI_NOMCLI').AsString);

            objDadosEmail.arrDupTabela      := pCarregaTabelaDupEmail( qryConRec.FieldByName('CTR_CODCLI').AsString );

            objDadosEmail.QRCodePix    := qryConRec.FieldByName('CTR_QRCODE').AsString;
            objDadosEmail.LinkCitelPix := RetornaLinkPixCitelValido(qryConRec);

            objDadosEmail.DiasVencimento := Abs(DaysBetween(VS_Date, qryConRec.FieldByName('CTR_DTAVEN').AsDateTime)).ToString;

            AEnviouEmail := fDisparaEmailBoletoAutomatico(objDadosEmail,
                                                          IIF(blnEnvioAutmaticoEmail, 'AC', 'BO'),
                                                          objStatusEmailAutomatico, blnEnvioAutmaticoEmail);
            If Not Result Then
            Result := AEnviouEmail;
          End;

          If (Not AEnviouSMS) Then
          Begin
            objDadosSMS.strNumDoc         := qryConRec.FieldByName('CTR_NUMDUP').AsString;
            objDadosSMS.strCodCli         := qryConRec.FieldByName('CTR_CODCLI').AsString;
            objDadosSMS.strEspDoc         := qryConRec.FieldByName('CTR_ESPDOC').AsString;
            objDadosSMS.strCodEmp         := qryConRec.FieldByName('CTR_CODEMP').AsString;
            objDadosSMS.strNumOrc         := strNum_PD;
            objDadosSMS.strEspOrc         := IfThen(fEmptyStr(strNum_PD), '', 'PD');
            objDadosSMS.strEmpOri         := strEmp_PD;
            objDadosSMS.strCelula         := qryConCli.FieldByName('CLI_CELULA').AsString;
            objDadosSMS.strLinhaDigitavel := qryConRec.FieldByName('CTR_LINDIG').AsString;
            objDadosSMS.strDtaEmi         := FormatDateTime('dd/mm/yy', qryConRec.FieldByName('CTR_DTACAD').AsDateTime);
            objDadosSMS.strValDup         := FormatFloat( '#,##0.00', qryConRec.FieldByName('CTR_VALDUP').AsFloat);
            objDadosSMS.strParcel         := qryConRec.FieldByName('CTR_PARCEL').AsString;
            objDadosSMS.strDtaVen         := FormatDateTime('dd/mm/yy', qryConRec.FieldByName('CTR_DTAVEN').AsDateTime);
            objDadosSMS.strLinkDoBoleto   := qryConRec.FieldByName('LINK_DO_BOLETO').AsString;

            objDadosSMS.QRCodePix    := RetornaLinkPixCitelValido(qryConRec);
            If objDadosSMS.QRCodePix.IsEmpty Then
              objDadosSMS.QRCodePix := qryConRec.FieldByName('CTR_QRCODE').AsString;

            objDadosSMS.DiasVencimento := Abs(DaysBetween(VS_Date, qryConRec.FieldByName('CTR_DTAVEN').AsDateTime)).ToString;

            AEnviouSMS := fDisparaSMSBoletoAutomatico(objDadosSMS,
                                      IIF(blnEnvioAutmaticoEmail, 'AC', 'BO'),
                                      objStatusEmailAutomatico);

            If Not Result Then
              Result := AEnviouSMS;
          End;
        End
        Else
        Begin
          pCriarArrayAnexosEDestinatarios(strArqBoletos, strEmailCli, arrDestinatarios, arrArquivos);
          TEnvioEmail.EnviarEmailSemMensagemConfirmacao(Self,
                                                        strLoginUsuarioLogado,
                                                        'Boleto(s)',
                                                        arrDestinatarios,
                                                        [],
                                                        [],
                                                        ACorpoMensagem,
                                                        arrArquivos,
                                                        blnEditaEmail,
                                                        thrSincEmail,
                                                        True);
        End;
      End;

      //Grava boletos carne por empresa
      If (fCfgSis('GRVBOL') = '2') And ((ABoletoCarne) or (ABoleto1Via)) Then
      Begin
         GravarPDFPorEmpresaBoletosCarne(arrCtrDup, ExtractFilePath(Application.ExeName) + 'Boletos\');
         For iArr := 0 To Length(arrCtrDup) - 1 Do
             stlBoletosRealocados.Add( arrCtrDup[iArr].strNumDup + '.pdf' );
      End;

    End;

    //Remove boletos realocados por empresa
    If (fCfgSis('GRVBOL') = '2') And (stlBoletosRealocados <> Nil) Then
       RemovePDFRealocadosPorEmpresa(stlBoletosRealocados);

    If (Assigned(stlBoletosRealocados)) Then
        FreeAndNil(stlBoletosRealocados);

    pBackupCnfBco;

  End;

  //Inicia thread que vai salvar os arquivos dos email's enviados na pasta
  //EmailTemp, e vai sincronizar a pasta enviados no servidor caso use IMAP
  //Essa rotina foi isolada para melhorar o desempenho da mesma
  //que estava muito lenta - KP.110123
  if Assigned(thrSincEmail) then
  Begin
    if thrSincEmail.QuantidadeEmails > 0 then
    begin
      thrSincEmail.Start;

      TListaThreadsSincronizaEmails.GetInstance.pAdicionar(thrSincEmail);
    end;
  End;

  If (Assigned(stlClientes)) Then
    FreeAndNil(stlClientes);

end;

function TBoleto.RetornaPastaBoletos(ACodigoEmpresaDuplicata: String; ABoletoCarne: Boolean; ABoleto1Via: Boolean): String;
begin
  Result := ExtractFilePath(Application.ExeName) + 'Boletos\';

  If (ABoletoCarne or ABoleto1Via) THen
    Exit;

  If fCfgSis('GRVBOL', varString) = '2' Then
    Result := ExtractFilePath(Application.ExeName) + 'Boletos_' + ACodigoEmpresaDuplicata + '\';
end;

function TBoleto.RetornaSelectLinkDoBoleto: String;
  Var
    LConfBoleto: String;
begin
  LConfBoleto := fCfgSis('LNKBOL');

  If LConfBoleto.IsEmpty Then
    Exit('"" AS LINK_DO_BOLETO');

  Result := 'CONCAT("' + LConfBoleto + '", ' +
            'TO_BASE64(              ' +
            'CONCAT(                 ' +
            '       CTR_NUMDUP, "|", ' +
            '       CTR_ESPDOC, "|", ' +
            '       CTR_PARCEL, "|", ' +
            '       CTR_CODEMP, "|", ' +
            '       CTR_CODCLI, "|", ' +
            'UPPER(                  ' +
            '      MD5(              ' +
            '          CONCAT(       ' +
            '       CTR_NUMDUP, "|", ' +
            '       CTR_ESPDOC, "|", ' +
            '       CTR_PARCEL, "|", ' +
            '       CTR_CODEMP, "|", ' +
            '       CTR_CODCLI, "|", ' +
            ' "CITEL_BOLETO_@_13347" ' +
            ' ) ) ) )  ) )           ' +
            ' AS LINK_DO_BOLETO      ';
end;

procedure TBoleto.pUpdateCadRec(ctrDup: TDupCtr);
  Var
    qryUpdateCtr: TUniQuery;
begin

  Try
    qryUpdateCtr := fCriaQuery(Self);

    With qryUpdateCtr Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' UPDATE ' + strNomeTabela);
      SQL.Add('    SET CTR_CODPOR = ' + QuotedStr(FCodPor));
      SQL.Add('  WHERE CTR_NUMDUP = ' + QuotedStr(ctrDup.strNumDup));
      SQL.Add('    AND CTR_PARCEL = ' + QuotedStr(ctrDup.strParcel));
      SQL.Add('    AND CTR_CODCLI = ' + QuotedStr(ctrDup.strCodCli));
      SQL.Add('    AND CTR_CODEMP = ' + QuotedStr(ctrDup.strCodEmp));
      SQL.Add('    AND CTR_ESPDOC = ' + QuotedStr(ctrDup.strEspDoc));
      ExecSQL;
    End;

    FreeAndNil(qryUpdateCtr);
  Except
    On E: Exception Do
    Begin
      FreeAndNil(qryUpdateCtr);
      Raise Exception.Create('Erro ao Atualizar Portador e Banco do Boleto da Duplicata a ser Reimpressa - [pUpdateCadRec] !' + #13#10 + E.Message);
    End;
  End;

end;

class function TBoleto.RetornaCodigoModeloSMSAutomatico(
  AStatus: TStatusDisparaEmail): String;
begin
  Result := EmptyStr;
  Case AStatus Of
    sta2DiasVencer: Result := '001';
    sta3DiasVencido: Result := '002';
    sta5DiasVencido: Result := '003';
    sta1DiaVencer: Result := '004';
    sta3DiasVencer: Result := '005';
    sta4DiasVencer: Result := '006';
    sta5DiasVencer: Result := '007';
    sta1DiaVencido: Result := '008';
    sta2DiasVencido: Result := '009';
    sta4DiasVencido: Result := '010';
    sta8DiasVencido: Result := '011';
    sta6DiasVencido: Result := '012';
    sta7DiasVencido: Result := '013';
    sta9DiasVencido: Result := '014';
    sta10DiasVencido: Result := '015';
    sta6DiasVencer: Result := '016';
    sta7DiasVencer: Result := '018';
    sta8DiasVencer: Result := '019';
    sta9DiasVencer: Result := '020';
    sta10DiasVencer: Result := '021';
    sta30DiasVencido: Result := '022';
  End;
end;

class function TBoleto.ExisteCarteiraDaDuplicataCadastrada(
  ACarteira: String): Boolean;
begin
  Result := Trim(fGetBancoConfig(0, ACarteira, 'RESPONS', '')) <> '';
end;

function TBoleto.fSelectNossoNumeroAnterior(ctrDup: TDupCtr): String;
  Var
    qrySelectCtr: TUniQuery;
begin

  Result := '';

  Try
    qrySelectCtr := fCriaQuery(Self);

    With qrySelectCtr Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT CTR_NOSNUM ');
      SQL.Add('   FROM '+ strNomeTabela);
      SQL.Add('  WHERE CTR_NUMDUP = ' + QuotedStr(ctrDup.strNumDup));
      SQL.Add('    AND CTR_PARCEL = ' + QuotedStr(ctrDup.strParcel));
      SQL.Add('    AND CTR_ESPDOC = ' + QuotedStr(ctrDup.strEspDoc));
      SQL.Add('    AND CTR_CODEMP = ' + QuotedStr(ctrDup.strCodEmp));
      SQL.Add('    AND CTR_CODCLI = ' + QuotedStr(ctrDup.strCodCli));
      SQL.Add('    AND CTR_SEQBAI = 0 ');
      Open;

      Result := FieldByName('CTR_NOSNUM').AsString;
    End;

  Finally
    FreeAndNil(qrySelectCtr);
  End;

end;

function TBoleto.fVerificaEmailAutmatico(objDuplicata: TDuplicataCtr): Boolean;
  Var
    objEmaAut: TEmaAut;
begin
  Try
    objEmaAut := TEmaAut.Create(Nil);
    If objDuplicata.blnAvisoAutomaticoEmail Then
    Begin
      objEmaAut.FOpcDoc := 'AC';
      objEmaAut.FCodGru := objDuplicata.strCodigoGrupo;
      objEmaAut.FCodigo := objDuplicata.strCodigoEmail;
    End
    Else
      objEmaAut.FOpcDoc := 'BO';

    Result := objEmaAut.fTemEmailAtivo;
  Finally
    FreeAndNil(objEmaAut);
  End;
end;

class function TBoleto.fChaveLockImpressaoBoletos: String;
begin
  Result := 'BOLETO_IMPRESSAO_' + fRetEmpresaFisica;
end;

function TBoleto.RetornaLinkPixCitelValido(const ADuplicata: TDataSet): String;
  Var
    LCarteira: String;

    LDiasValidade: Integer;
begin
  Result := ADuplicata.FieldByName('CTR_LNKCIT').AsString;

  LCarteira := ADuplicata.FieldByName('CTR_CARTEI').AsString;

  If Result.IsEmpty Or (Copy(LCarteira, 1, 13) <> 'CONFIG756API-') Then
    Exit;

  LDiasValidade := StrToIntDef(fGetBancoConfig(0,
                                               Copy(LCarteira, 1, 14),
                                               'DIALIMR',
                                               '0',
                                               Copy(LCarteira, Length(LCarteira) - 2, 3)), 0);

  If Trunc(fRetDtaHraServidor) > Trunc(ADuplicata.FieldByName('CTR_DTAVEN').AsDateTime) + LDiasValidade Then
    Result := EmptyStr;
end;

class function TBoleto.fEnviarEmailBoletoAutomatico(objArrDupCtr: TArrDupCtr;
                                                    objStatusBoleto: TStatusDisparaEmail;
                                                    out AEnviouEmail: Boolean;
                                                    out AEnviouSMS: Boolean;
                                                    out AEnviouWPP: Boolean): Boolean;
  Var
    objBoleto   : TBoleto;
    blnEmaAut   : Boolean;
    qryGenCtr   : TUniQuery;
    cdsBoleto   : TUniClientDataSet;
    intConta_   : Integer;
    strAutInc   : String;

    LSMSAutomatico: TSMSAut;
Begin
  Result := False;

  If Length(objArrDupCtr) > 0 Then
  Begin
    qryGenCtr := fCriaQuery;

    Try
      strAutInc := '';

      For intConta_ := 0 To Length(objArrDupCtr)-1 Do
        strAutInc := strAutInc + objArrDupCtr[intConta_].strAutoIn + '", "';

      strAutInc := '"'+ strAutInc;
      strAutInc := Copy(strAutInc, 1, Length(strAutInc)-3);

      qryGenCtr.Close;
      qryGenCtr.SQL.Clear;
      qryGenCtr.SQL.Text := fGetSQLBoletos(objArrDupCtr[0].blnAvisoAutomaticoEmail);
      qryGenCtr.SQL.Text := StringReplace(qryGenCtr.SQL.Text, 'AUTINC', strAutInc, []);
      qryGenCtr.Open;

      If Not ExisteCarteiraDaDuplicataCadastrada(qryGenCtr.FieldByName('CTR_CARTEI').AsString) Then
      Begin
        FreeAndNil(qryGenCtr);

        AEnviouEmail := False;
        AEnviouSMS := False;
        AEnviouWPP := False;

        Exit;
      End;

      objBoleto := TBoleto.Create(Nil, 'CADREC', False);
      cdsBoleto := fCriaClientDatset(qryGenCtr);

      blnEmaAut := False;
      If Not AEnviouEmail Then
        blnEmaAut := objBoleto.fVerificaEmailAutmatico(objArrDupCtr[0]);

      If Not blnEmaAut Then
      Begin
        LSMSAutomatico := TSMSAut.Create(Nil);

        LSMSAutomatico.FOpcDoc := 'AC';
        LSMSAutomatico.FCodigo := RetornaCodigoModeloSMSAutomatico(objStatusBoleto);

        blnEmaAut := LSMSAutomatico.fTemModeloAtivo;

        if not blnEmaAut then
        begin
          LSMSAutomatico.FWhatsapp := True;
          blnEmaAut := LSMSAutomatico.fTemModeloAtivo;
        end;

        FreeAndNil(LSMSAutomatico);
      End;

      objBoleto.objStatusEmailAutomatico := objStatusBoleto;

      Result := blnEmaAut;

      If blnEmaAut Then
      Begin
        Application.ProcessMessages;
        Result := objBoleto.fImprimir(cdsBoleto,
                            objArrDupCtr,
                            cdsBoleto.FieldByName('CTR_BCOBOL').AsString,
                            True,
                            True,
                            blnEmaAut,
                            AEnviouEmail,
                            AEnviouSMS,
                            AEnviouWpp,
                            objArrDupCtr[0].blnAvisoAutomaticoEmail,
                            False,
                            cdsBoleto.FieldByName('CTR_CARTEI').AsString,
                            '',
                            '',
                            '',
                            '',
                            '',
                            True);
      End;

    Except
      
    End;

    If Assigned(cdsBoleto) Then
      FreeAndNil(cdsBoleto);

    If Assigned(objBoleto) Then
      FreeAndNil(objBoleto);

    FreeAndNil(qryGenCtr);
  End;
end;

class function TBoleto.fReimpressaoPDFBoleto(
  objArrDupCtr: TArrDupCtr): Boolean;
Var
  objBoleto   : TBoleto;
  blnEmaAut   : Boolean;
  qryGenCtr   : TUniQuery;
  cdsBoleto   : TUniClientDataSet;
  intConta_   : Integer;
  strAutInc   : String;
  AEnviouEmail: Boolean;
  AEnviouSMS: Boolean;
  AEnviouWpp: Boolean;
  blnReimpressao: Boolean;
Begin
  Result := False;

  AEnviouEmail := False;
  AEnviouSMS := False;
  blnReimpressao := True;
  blnEmaAut := False;

  If Length(objArrDupCtr) <= 0 Then
    Exit;

  qryGenCtr := fCriaQuery;
  Try
    strAutInc := '';

    For intConta_ := 0 To Length(objArrDupCtr)-1 Do
      strAutInc := strAutInc + objArrDupCtr[intConta_].strAutoIn + '", "';

    strAutInc := '"'+ strAutInc;
    strAutInc := Copy(strAutInc, 1, Length(strAutInc)-3);

    qryGenCtr.Close;
    qryGenCtr.SQL.Clear;
    qryGenCtr.SQL.Text := fGetSQLBoletos(blnReimpressao);
    qryGenCtr.SQL.Text := StringReplace(qryGenCtr.SQL.Text, 'AUTINC', strAutInc, []);
    qryGenCtr.Open;

    If Not ExisteCarteiraDaDuplicataCadastrada(qryGenCtr.FieldByName('CTR_CARTEI').AsString) Then
    Begin
      FreeAndNil(qryGenCtr);
      Exit;
    End;

    objBoleto := TBoleto.Create(Nil, 'CADREC', False);
    cdsBoleto := fCriaClientDatset(qryGenCtr);

    Result := objBoleto.fImprimir(cdsBoleto,
                        objArrDupCtr,
                        cdsBoleto.FieldByName('CTR_BCOBOL').AsString,
                        True,
                        True,
                        blnEmaAut,
                        AEnviouEmail,
                        AEnviouSMS,
                        AEnviouWpp,
                        blnReimpressao,
                        False,
                        cdsBoleto.FieldByName('CTR_CARTEI').AsString,
                        '',
                        '',
                        '',
                        '',
                        '',
                        True);

  Finally
    If Assigned(cdsBoleto) Then
      FreeAndNil(cdsBoleto);

    If Assigned(objBoleto) Then
      FreeAndNil(objBoleto);

    If Assigned(objBoleto) Then
      FreeAndNil(qryGenCtr);
  End;
end;

class function TBoleto.fGetProvedorEnvioEmailAutomatico(objDuplicata: TDuplicataCtr): String;
begin
  If objDuplicata.blnAvisoAutomaticoEmail Then
    Result := TEmaAut.fGetProvedor('AC', objDuplicata.strCodigoGrupo, objDuplicata.strCodigoEmail)
  Else
    Result := TEmaAut.fGetProvedor('BO', '', '');
end;

class function TBoleto.fGetSQLBoletos(blnReimpressaoBoleto: Boolean = False; AGerarBoleto:Boolean = False): String;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  R.AUTOINCREM, ';
  strSQL := strSQL + '  R.CTR_NUMDUP AS NRODUP, ';
  strSQL := strSQL + '  R.CTR_PARCEL AS PARDUP, ';
  strSQL := strSQL + '  CONCAT(R.CTR_NUMDUP, R.CTR_PARCEL) AS CTR_NUMDUP, ';
  strSQL := strSQL + '  R.CTR_CODEMP, ';
  strSQL := strSQL + '  R.CTR_ESPDOC, ';
  strSQL := strSQL + '  R.CTR_DTAVEN, ';
  strSQL := strSQL + '  R.CTR_DTACAD, ';
  strSQL := strSQL + '  IF((R.CTR_NOSNUM IS NOT NULL) OR ' +
                     '     (R.CTR_DTAENV IS NOT NULL) OR ' +
                     '     (R.CTR_BCOBOL = "999" AND R.CTR_DTABOL IS NOT NULL), "Sim", "Não") ' +
                     '  AS CTR_BOLETO, ';
  strSQL := strSQL + '  R.CTR_VALDUP, ';
  strSQL := strSQL + '  R.CTR_DESSUJ, ';
  strSQL := strSQL + '  R.CTR_JURSUJ, ';
  strSQL := strSQL + '  R.CTR_DESCOB, ';
  strSQL := strSQL + '  0.0000 AS CTR_VALCOR, ';
  strSQL := strSQL + '  R.CTR_CODCLI, ';
  strSQL := strSQL + '  CLI_NOMCLI, ';
  strSQL := strSQL + '  CLI_EMAIL_, ';
  strSQL := strSQL + '  R.CTR_CODPOR, ';
  strSQL := strSQL + '  POR_NOMPOR, ';
  strSQL := strSQL + '  R.CTR_NOSNUM, ';
  strSQL := strSQL + '  R.CTR_HIST01, ';
  strSQL := strSQL + '  R.CTR_HIST02, ';
  strSQL := strSQL + '  R.CTR_OBSAG1, ';
  strSQL := strSQL + '  R.CTR_OBSAG2, ';
  strSQL := strSQL + '  R.CTR_OBSAG3, ';
  strSQL := strSQL + '  R.CTR_PERDPO, ';
  strSQL := strSQL + '  R.CTR_QTDDAV, ';
  strSQL := strSQL + '  R.CTR_CARTEI, ';
  strSQL := strSQL + '  R.CTR_PERMOR, ';
  strSQL := strSQL + '  R.CTR_PERMUL, ';
  strSQL := strSQL + '  R.CTR_DTAENV, ';
  strSQL := strSQL + '  R.CTR_DTABOL, ';
  strSQL := strSQL + '  R.CTR_SEQBAI, ';
  strSQL := strSQL + '  R.CTR_PARCEL, ';
  strSQL := strSQL + '  R.CTR_LINDIG, ';
  strSQL := strSQL + '  R.CTR_VALORI, ';
  strSQL := strSQL + '  IFNULL(R.CTR_BCOBOL, "") AS CTR_BCOBOL, ';
  strSQL := strSQL + '  IF(R.CTR_NOSNUM IS NOT NULL OR R.CTR_DTAENV IS NOT NULL, CONCAT(R.CTR_BCOBOL, "-", R.CTR_CARTEI), R.CTR_BCOBOL) AS CTR_CHAVE, ';
  strSQL := strSQL + '  CLI_C_G_C_, ';
  strSQL := strSQL + '  "M" AS CTR_MARDES, ';
  strSQL := strSQL + '  "N" AS CTR_VNCALT, ';
  strSQL := strSQL + '  R.CTR_JURSUJ AS CTR_JSJBKP, ';
  strSQL := strSQL + '  R.CTR_DTAVEN AS CTR_DTVBKP, ';
  strSQL := strSQL + '  "" AS NUMPED, ';
  strSQL := strSQL + '  R.CTR_OBSV01 AS CTR_OBSV01, ';
  strSQL := strSQL + '  R.CTR_OBSV02 AS CTR_OBSV02  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADREC R ';
  strSQL := strSQL + '  JOIN CADCLI      ON R.CTR_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + '  LEFT JOIN CADPOR ON R.CTR_CODPOR = POR_CODPOR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  R.CTR_DTAREC IS NULL   AND ';
  strSQL := strSQL + '  R.CTR_VALDUP > 0       AND ';
  strSQL := strSQL + '  R.AUTOINCREM IN (AUTINC) AND ';

  If blnReimpressaoBoleto Then
    strSQL := strSQL + '  (R.CTR_NOSNUM IS NOT NULL AND (R.CTR_BCOBOL IS NOT NULL AND R.CTR_BCOBOL NOT IN ("", "999"))) '
  Else If AGerarBoleto Then
    strSQL := strSQL + '  (R.CTR_NOSNUM IS NOT NULL AND R.CTR_DTAENV IS NOT NULL) '
  Else
    strSQL := strSQL + '  (R.CTR_NOSNUM IS NULL  AND R.CTR_DTAENV IS NULL AND COALESCE(R.CTR_BCOBOL, "") <> "999") ';

  Result := strSQL;
end;

class function TBoleto.fImprimirBoletos(objArrDupCtr: TArrDupCtr;
  blnFaturamento, blnPergunta: Boolean; strTextoPergunta, strNomeForm,
  strNomImpBol, strWhereBol: String): Boolean;
Var
  objBoleto: TBoleto;
  blnEmaAut,
  blnImpBoleto: Boolean;
  qryGenCtr: TUniQuery;
  cdsBoleto: TUniClientDataSet;
  intConta_: Integer;
  strAutInc: String;

  LEnviouEmail,
  LEnviouSMS,
  LEnviouWpp: Boolean;
Begin
  Result       := False;
  blnImpBoleto := False;

  If Length(objArrDupCtr) > 0 Then
  Begin
    If blnImpBoleto Then
    Begin
      qryGenCtr := fCriaQuery;

      Try
        strAutInc := '';

        For intConta_ := 0 To Length(objArrDupCtr)-1 Do
          strAutInc := strAutInc + objArrDupCtr[intConta_].strAutoIn + '", "';

        strAutInc := '"'+ strAutInc;
        strAutInc := Copy(strAutInc, 1, Length(strAutInc)-3);

        With qryGenCtr Do
        Begin
          Close;
          SQL.Clear;
          SQL.Text := fGetSQLBoletos(objArrDupCtr[0].blnAvisoAutomaticoEmail);
          SQL.Text := StringReplace(SQL.Text, 'AUTINC', strAutInc, []);
          Open;
        End;

        objBoleto := TBoleto.Create(Nil, 'CADREC', blnFaturamento);
        cdsBoleto := fCriaClientDatset(qryGenCtr);

        blnEmaAut := objBoleto.fVerificaEmailAutmatico(objArrDupCtr[0]);

        objBoleto.fImprimir(cdsBoleto,
                            objArrDupCtr,
                            '',
                            True,
                            True,
                            blnEmaAut,
                            LEnviouEmail,
                            LEnviouSMS,
                            LEnviouWpp,
                            objArrDupCtr[0].blnAvisoAutomaticoEmail,
                            False,
                            '',
                            '',
                            '');

        Result := True;
      Except
        On e: Exception Do
          pMensagensErro(E.Message, '[untFuncoes.fImprimirBoletos]');
      End;

      If Assigned(cdsBoleto) Then
        FreeAndNil(cdsBoleto);

      If Assigned(objBoleto) Then
        FreeAndNil(objBoleto);

      FreeAndNil(qryGenCtr);
    End;
  End;
End;

function TBoleto.fNossoNumeroAnterior(ctrDup: TDupCtr; blnManterPortador: Boolean): String;
begin
  If Not blnManterPortador and blnPortadorAlterado Then
    pUpdateCadRec(ctrDup);
  Result := fSelectNossoNumeroAnterior(ctrDup);
end;

{*************************************************************}
{* RETORNA O NÚMERO DA CARTEIRA EM QUE O BOLETO FOI IMPRESSO *}
{*REQ-25848-23/01/2015*************************************JU*}
function TBoleto.fRetNumCartReimpressao(strCartei: String): Integer;
  Var
    intCont: Integer;
begin

  Result := 0;

  For intCont := 1 To Length(strCartei) Do
  Begin
    If Copy(strCartei, intCont, 1) = '-' Then
    Begin
      Result := StrToInt(Copy(strCartei, intCont + 1, 1));
      Break;
    End;
  End;

end;

function TBoleto.fRetornaEmailCliente(cdsBoleto: TDataset): String;
begin
  If Not fEmptyStr(cdsBoleto.FieldByName('CLI_EMCOB1').AsString) Then
    Result := cdsBoleto.FieldByName('CLI_EMCOB1').AsString
  Else
  If Not fEmptyStr(cdsBoleto.FieldByName('CLI_EMCOB2').AsString) Then
    Result := cdsBoleto.FieldByName('CLI_EMCOB2').AsString
  Else
  If Not fEmptyStr(cdsBoleto.FieldByName('CLI_EMAIL_').AsString) Then
    Result := cdsBoleto.FieldByName('CLI_EMAIL_').AsString
  Else
  If Not fEmptyStr(cdsBoleto.FieldByName('CLI_EMAIL2').AsString) Then
    Result := cdsBoleto.FieldByName('CLI_EMAIL2').AsString
  Else
    Result := '';

  If (Not fEmptyStr(cdsBoleto.FieldByName('CLI_EMAIL3').AsString)) Then Begin
    If (Not fEmptyStr(Result)) Then
      Result := Result + '; ' + cdsBoleto.FieldByName('CLI_EMAIL3').AsString
    Else
      Result := cdsBoleto.FieldByName('CLI_EMAIL3').AsString;
  End;

  Result := AnsiReplaceStr(Result, ';;', ';');
end;

{*****************************************}
{* INICIALIZA QUERIES COMS SEUS SELECTS  *}
{**************************************AF*}
procedure TBoleto.pInicializaCamposUso;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT                                                ';
  strSQL := strSQL + '  C.*,                                                ';
  strSQL := strSQL + '  D1.CID_NOMCID AS CID_NOMCID,                        ';
  strSQL := strSQL + '  D1.CID_ESTADO AS CID_ESTADO,                        ';
  strSQL := strSQL + '  D2.CID_NOMCID AS CID_CIDCOB,                        ';
  strSQL := strSQL + '  D2.CID_ESTADO AS CID_ESTCOB,                        ';
  strSQL := strSQL + '  D3.CID_NOMCID AS CID_CIDENT,                        ';
  strSQL := strSQL + '  D3.CID_ESTADO AS CID_ESTENT                         ';
  strSQL := strSQL + 'FROM                                                  ';
  strSQL := strSQL + '  CADCLI AS C                                         ';
  strSQL := strSQL + '  JOIN CADCID     D1  ON C.CLI_CODCID = D1.CID_CODCID ';
  strSQL := strSQL + '  LEFT JOIN CADCID D2 ON C.CLI_CIDCOB = D2.CID_CODCID ';
  strSQL := strSQL + '  LEFT JOIN CADCID D3 ON C.CLI_CIDENT = D3.CID_CODCID ';
  strSQL := strSQL + 'WHERE                                                 ';
  strSQL := strSQL + '  C.CLI_CODCLI = :CODCLI                              ';

  qryConCli.SQL.Clear;
  qryConCli.SQL.Add(strSQL);
  qryConCli.Open;

  strSQL := '';
  strSQL := strSQL + 'SELECT                                              ';
  strSQL := strSQL + '  R.*,                                              ';
  strSQL := strSQL + RetornaSelectLinkDoBoleto + ',                       ';
  strSQL := strSQL + '  O.OPE_NOMOPE AS OPE_NOMOPE,                       ';
  strSQL := strSQL + '  P.POR_NOMPOR AS POR_NOMPOR                        ';
  strSQL := strSQL + 'FROM                                                ';
  strSQL := strSQL + strNomeTabela + ' R                                  ';
  strSQL := strSQL + '  JOIN CADOPE O ON R.CTR_CODVEN = O.OPE_CODOPE      ';
  strSQL := strSQL + '  LEFT JOIN CADPOR P ON R.CTR_CODPOR = P.POR_CODPOR ';
  strSQL := strSQL + 'WHERE                                               ';
  strSQL := strSQL + '  R.CTR_NUMDUP = :NUMDUP AND                        ';
  strSQL := strSQL + '  R.CTR_PARCEL = :PARCEL AND                        ';
  strSQL := strSQL + '  R.CTR_ESPDOC = :ESPDOC AND                        ';
  strSQL := strSQL + '  R.CTR_CODEMP = :CODEMP AND                        ';
  strSQL := strSQL + '  R.CTR_CODCLI = :CODCLI AND                        ';
  strSQL := strSQL + '  R.CTR_SEQBAI = 0                                  ';

  qryConRec.SQL.Clear;
  qryConRec.SQL.Add(strSQL);
  qryConRec.Open;

  strSQL := '';
  strSQL := strSQL + 'SELECT                          ';
  strSQL := strSQL + '  SUM(CTR_VALDUP) AS CTR_TOTDUP ';
  strSQL := strSQL + 'FROM                            ';
  strSQL := strSQL + '  CADREC                        ';
  strSQL := strSQL + 'WHERE                           ';
  strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND      ';
  strSQL := strSQL + '  CTR_PARCEL = :PARCEL AND      ';
  strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND      ';
  strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND      ';
  strSQL := strSQL + '  CTR_CODCLI = :CODCLI          ';

  qryConTot.SQL.Clear;
  qryConTot.SQL.Add(strSQL);
  qryConTot.Open;

  pAtribuiCamposUso;
end;

{*****************************************}
{* ATUALIZA AS TABELAS ENVOLVIDAS NO PRO-*}
{* CESSO DE IMPRESSÃO DOS BOLETOS        *}
{**************************************AF*}
procedure TBoleto.pAtualizaCamposUso(ctrDup: TDupCtr);
begin

  With qryConCli Do
  Begin
    Close;
    ParamByName('CODCLI').AsString := ctrDup.strCodCli;
    Open;
  End;

  With qryConRec Do
  Begin
    Close;
    ParamByName('NUMDUP').AsString := ctrDup.strNumDup;
    ParamByName('PARCEL').AsString := ctrDup.strParcel;
    ParamByName('ESPDOC').AsString := ctrDup.strEspDoc;
    ParamByName('CODEMP').AsString := ctrDup.strCodEmp;
    ParamByName('CODCLI').AsString := ctrDup.strCodCli;
    Open;
  End;

  With qryConTot Do
  Begin
    Close;
    ParamByName('NUMDUP').AsString := ctrDup.strNumDup;
    ParamByName('PARCEL').AsString := ctrDup.strParcel;
    ParamByName('ESPDOC').AsString := ctrDup.strEspDoc;
    ParamByName('CODEMP').AsString := ctrDup.strCodEmp;
    ParamByName('CODCLI').AsString := ctrDup.strCodCli;
    Open;
  End;

  pFinalizaCamposUso;
  pAtribuiCamposUso;
end;

procedure TBoleto.pAtribuiCamposUso;
  Var
    strExtenso: String;
begin
  If Assigned(cpuCampos) Then
    FreeAndNil(cpuCampos);

  cpuCampos := TCamposUso.Create;
  cpuCampos.AdicionaCampos(qryConCli, 'CADCLI');
  cpuCampos.AdicionaCampos(qryConRec, 'CADREC');
  cpuCampos.AdicionaCampos(qryConTot, 'CADREC');


  FCodCli := qryConCli.FieldByName('CLI_CODCLI').AsString;
  FNomCli := qryConCli.FieldByName('CLI_NOMCLI').AsString;
  FInsEst := qryConCli.FieldByName('CLI_I_E_S_').AsString;

  If (Length(AnsiReplaceStr(qryConCli.FieldByName('CLI_C_G_C_').AsString, '.', '')) = 11) Then
    FCgcCli := Copy(qryConCli.FieldByName('CLI_C_G_C_').AsString,1,3) + '.' +
               Copy(qryConCli.FieldByName('CLI_C_G_C_').AsString,4,3) + '.' +
               Copy(qryConCli.FieldByName('CLI_C_G_C_').AsString,7,3) + '-' +
               Copy(qryConCli.FieldByName('CLI_C_G_C_').AsString,10,2)
  Else
    FCgcCli := Copy(qryConCli.FieldByName('CLI_C_G_C_').AsString,1,2) + '.' +
               Copy(qryConCli.FieldByName('CLI_C_G_C_').AsString,3,3) + '.' +
               Copy(qryConCli.FieldByName('CLI_C_G_C_').AsString,6,3) + '/' +
               Copy(qryConCli.FieldByName('CLI_C_G_C_').AsString,9,4) + '-' +
               Copy(qryConCli.FieldByName('CLI_C_G_C_').AsString,13,2);

  If (qryConCli.FieldByName('CLI_ENDCOB').IsNull) Or (qryConCli.FieldByName('CLI_ENDCOB').AsString = '') Then
    FEndCli := qryConCli.FieldByName('CLI_ENDERE').AsString + ', ' + qryConCli.FieldByName('CLI_ENDNUM').AsString
  Else
    FEndCli := qryConCli.FieldByName('CLI_ENDCOB').AsString;

  If (qryConCli.FieldByName('CLI_ENDCOB').IsNull) Or (qryConCli.FieldByName('CLI_ENDCOB').AsString = '') Then
    FCidCli := qryConCli.FieldByName('CID_NOMCID').AsString
  Else
    FCidCli := qryConCli.FieldByName('CID_CIDCOB').AsString;

  If (qryConCli.FieldByName('CLI_ENDCOB').IsNull) Or (qryConCli.FieldByName('CLI_ENDCOB').AsString = '') Then
    FEstCli := qryConCli.FieldByName('CID_ESTADO').AsString
  Else
    FEstCli := qryConCli.FieldByName('CID_ESTCOB').AsString;

  {***********************************************************}
  {* GUARDO O CEP DO CLIENTE PARA PODER FORMATA-LO NO CNFBOL *}
  {********************************************************AC*}

  If qryConCli.FieldByName('CLI_ENDCOB').AsString = '' Then
    FCepCli := Copy(qryConCli.FieldByName('CLI_C_E_P_').AsString,1,5) + '-' + Copy(qryConCli.FieldByName('CLI_C_E_P_').AsString,6,3)
  Else FCepCli := Copy(qryConCli.FieldByName('CLI_CEPCOB').AsString,1,5) + '-' + Copy(qryConCli.FieldByName('CLI_CEPCOB').AsString,6,3);

  If qryConRec.FieldByName('CTR_VALDUP').AsString <> '' Then
  Begin
    strExtenso := fRetExtensoNumero(AnsiReplaceStr(qryConRec.FieldByName('CTR_VALDUP').AsString,'-',''));
    FValExt  := AnsiUpperCase(Copy(strExtenso,1,50));
    FValExt2 := AnsiUpperCase(Copy(strExtenso,50,100));
  End;

  FValDes := qryConRec.FieldByName('CTR_VALDES').AsFloat;
//  FUltPar := fRetUltimaParcela(qryConRec.FieldByName('CTR_CODCLI').AsString, qryConRec.FieldByName('CTR_CODEMP').AsString,
//                                 qryConRec.FieldByName('CTR_NUMDUP').AsString, qryConRec.FieldByName('CTR_ESPDOC').AsString);


end;

procedure TBoleto.pFinalizaCamposUso;
begin
  If cpuCampos <> Nil Then
    FreeAndNil(cpuCampos);
end;

{procedure TBoleto.pImprimeMatricial;
  Var
    strSQL     : String;
    intLinhaAtu: Integer;
    intLinha   : Integer;
    qryCnfBol: TUniQuery;
begin

  Try
    intLinhaAtu := 1;
    intLinha    := 0;

    *****************************************
    * CHAMA AS CONFIGURAÇÕES DE IMPRESSÃO   *
    **************************************AF*
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CNFBOL ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CNF_CODBCO = :CODBCO AND ';
    strSQL := strSQL + '  CNF_CODEMP = :CODEMP ';
    strSQL := strSQL + 'ORDER BY ';
    strSQL := strSQL + '  CNF_CODBCO, CNF_IDENTI, CNF_LINIMP, CNF_COLIMP ';

    qryCnfBol := fCriaQuery(Self);
    With qryCnfBol Do
    Begin
      Close;
      SQL.Add(strSQL);
      ParamByName('CODBCO').AsString := FCodBco;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      First;

      While Not Eof Do
      Begin
        pI_Linhas(Self, cpuCampos, intLinhaAtu, intLinha, strNomImp, qryCnfBol);
      End;
      Close;
    End;
    FreeAndNil(qryCnfBol);

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;}


function TBoleto.GetHtmlContent(const ANomeCliente: string): string;
begin
  Result :=
    '<html lang="pt-BR">' +
    '<body style="font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #eaf4fc; color: #333;">' +
    '  <div style="max-width: 600px; margin: 20px auto; padding: 20px; background-color: #ffffff; border-radius: 8px; box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); border-left: 6px solid #4ea6e8;">' +
    '    <div style="text-align: center; padding-bottom: 20px;">' +
    '      <h1 style="color: #4ea6e8; font-size: 1.8em;">Reemissão de Boletos - Nova Regra</h1>' +
    '    </div>' +
    '    <p style="line-height: 1.6; margin: 10px 0;">Olá, <span style="color: #4ea6e8; font-weight: bold;">'+ANomeCliente+'</span>!</p>' +
    '    <p style="line-height: 1.6; margin: 10px 0;">Esperamos que esteja tudo bem com você.</p>' +
    '    <p style="line-height: 1.6; margin: 10px 0;">Estamos entrando em contato para informar que, devido a uma atualização nas diretrizes bancárias (FEBRABAN), todos os boletos com vencimento a '+
    'partir de <span style="color: #4ea6e8; font-weight: bold;">22/02/2025</span> precisarão ser reemitidos. Para garantir o correto processamento do seu pagamento, o boleto foi atualizado.</p>' +
    '    <p style="line-height: 1.6; margin: 10px 0;"><span style="color: #4ea6e8; font-weight: bold;">Importante:</span> Este não é um boleto clonado ou fraudulento! O boleto anexo é a versão corrigida, '+
    'e está de acordo com as novas normas bancárias. Pedimos que desconsidere o boleto anterior e '+
    'utilize este novo documento para efetuar o pagamento, pois o boleto anterior está com a linha digitável inválida.</p>' +
    '    <p style="line-height: 1.6; margin: 10px 0;"><span style="color: #4ea6e8; font-weight: bold;">Segue abaixo um resumo das alterações para esclarecer qualquer dúvida:</span></p>' +
    '    <p style="line-height: 1.6; margin: 10px 0;">O Fator Vencimento é um referencial numérico de 4 dígitos, que aparece no código de barras do boleto de cobrança e indica quantos dias se passaram '+
    'desde uma data base até a data de vencimento do pagamento.</p>' +
    '    <p style="line-height: 1.6; margin: 10px 0;">Esse número é importante para que os bancos possam processar os pagamentos corretamente.</p>' +
    '    <p style="line-height: 1.6; margin: 10px 0;">O fator “9999” nos títulos se refere a data de vencimento de 21/02/2025, encerrará seu ciclo de utilização, sendo assim, deverá retornar ao Fator 1000 em 22/02/2025.</p>' +
    '    <div style="margin: 20px 0;">' +
    '      <table style="width: 100%; border-collapse: collapse; font-size: 0.9em;">' +
    '        <thead>' +
    '          <tr>' +
    '            <th style="padding: 10px; text-align: left; background-color: #4ea6e8; color: white; border: 1px solid #ddd;">Data de Vencimento</th>' +
    '            <th style="padding: 10px; text-align: left; background-color: #4ea6e8; color: white; border: 1px solid #ddd;">Fator de Vencimento Atual</th>' +
    '            <th style="padding: 10px; text-align: left; background-color: #4ea6e8; color: white; border: 1px solid #ddd;">Fator de Vencimento Após 22/02/2025</th>' +
    '          </tr>' +
    '        </thead>' +
    '        <tbody>' +
    '          <tr>' +
    '            <td style="padding: 10px; text-align: left; border: 1px solid #ddd;">21/02/2025</td>' +
    '            <td style="padding: 10px; text-align: left; border: 1px solid #ddd;">9999</td>' +
    '            <td style="padding: 10px; text-align: left; border: 1px solid #ddd;">-</td>' +
    '          </tr>' +
    '          <tr>' +
    '            <td style="padding: 10px; text-align: left; border: 1px solid #ddd;">22/02/2025</td>' +
    '            <td style="padding: 10px; text-align: left; border: 1px solid #ddd;">-</td>' +
    '            <td style="padding: 10px; text-align: left; border: 1px solid #ddd;">1000</td>' +
    '          </tr>' +
    '          <tr>' +
    '            <td style="padding: 10px; text-align: left; border: 1px solid #ddd;">23/02/2025</td>' +
    '            <td style="padding: 10px; text-align: left; border: 1px solid #ddd;">-</td>' +
    '            <td style="padding: 10px; text-align: left; border: 1px solid #ddd;">1001</td>' +
    '          </tr>' +
    '          <tr>' +
    '            <td style="padding: 10px; text-align: left; border: 1px solid #ddd;">24/02/2025</td>' +
    '            <td style="padding: 10px; text-align: left; border: 1px solid #ddd;">-</td>' +
    '            <td style="padding: 10px; text-align: left; border: 1px solid #ddd;">1002</td>' +
    '          </tr>' +
    '        </tbody>' +
    '      </table>' +
    '    </div>' +
    '    <p style="line-height: 1.6; margin: 10px 0;">Agradecemos muito a sua compreensão e pedimos desculpas por qualquer inconveniente que isso '+
    'possa ter causado. Sabemos o quanto isso pode ser frustrante, mas estamos trabalhando para que tudo seja processado de forma rápida e eficiente.</p>' +
    '    <p style="line-height: 1.6; margin: 10px 0;">Se tiver qualquer dúvida, nossa equipe está à disposição para ajudá-lo.</p>' +
    '    <div style="text-align: center; font-size: 0.9em; color: #666; margin-top: 20px;">' +
    '      <p>Atenciosamente,</p>' +
    '    </div>' +
    '  </div>' +
    '</body>' +
    '</html>';

end;


end.
