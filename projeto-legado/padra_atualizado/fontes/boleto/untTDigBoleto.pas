unit untTDigBoleto;

interface

uses untQckBancos, Uni, SysUtils, Classes, frxClass, frxDBSet, RLTypes,
     untTypesSistema, UniClientDataSet, Data.DB, Windows, Forms, untZClient,
     untCfgRel, EditFocus;

Type
  TInfoDuplicatasMercantil = Record
    FEmailCli: String;
    FArqDupMer: String;
    FCodCli: String;
End;

TarrInfoDupMer = Array of TInfoDuplicatasMercantil;

Type
  TDadosTelaDigBoleto = record
    blnReimp,
    blnReimpParcial,
    blnPortadorAlterado,
    blnFaturamento,
    blnFaturadorAutomatico,
    blnEnvEml,
    blnBolPdf,
    blnConfirma,
    blnEnvMai,
    blnEtiCob,
    blnDupMercantil,
    blnEditaEmail,
    blnAltImp,
    blnEnvioAutmaticoEmail,
    blnEmissaoAutomatica,
    blnPreview,
    blnEmaAut,
    blnDeveImprimir,
    blnEnviarSMSBoleto,
    blnEnviarWPPBoleto,
    blnExpediMult,
    blnBoletoOriginal : Boolean;

    cdsBoletos: TUniClientDataSet;

    strCodBco,
    strOrdCampo,
    strOrdTipo,
    strRetBco,
    strChave,
    strMorDia,
    strCartei,
    strCodPor,
    strNosNum,
    strPerMul,
    strTipBol,
    strMens01,
    strMens02,
    strBraCrr,
    strBB_Crr,
    strConCrr,
    strEspDoc,
    strCodCli,
    strBancoAnterior,
    strEmpresaImpressao: String;

    fltValMor,
    fltPerMul: Double;

    intRetCar,
    intRetCarAnt: Integer;

    strTipoRelatorio,
    strOrdenacaoCampos,
    strOrdenacaoTipo,
    strFormulario      : String;

    fltPercentualMulta,
    fltPercentualMora : Double;
  end;


Type
  TDigBoleto = class
  private
    frxDuplicataMercantil: TfrxReport;

    frxRelatorio,
    frxDupAgrupadas,
    frxItensMercantil,
    frxEmpresaMercantil,
    frxRelatorioDups: TfrxDBDataset;

    frxGen: TfrxUserDataSet;

    cdsRelatorio: TUniCLientDataSet;
    cdsAgQuebra : TUniClientDataSet;
    //cdsDupsRel  : TUniCLientDataSet;

    intQtdImp: Integer;
    strArquivoFr3: String;

    strCtrEmp: String;

    qryDupAgrupadas: TZClient;
    LItensMercantil: TUniQuery;
    LEmpresaMercantil: TUniQuery;
    LParcelasDocto : TUniQuery;
    FInfoDupMer: TarrInfoDupMer;

    frmQckBancos: TfrmQckBancos;

    Function fSqlCadCli(strEmpresaImpressao: String): String;
    Function fSqlCadCliEmail(): String;
    Function fSqlEmpresa: String;

    function fDuplicataMercantilImpressoraLaser(blnGerPdf: Boolean = False; blnEnvEmail: Boolean = False; blnEditorEmail: Boolean = False; blnImprimir: Boolean = False): Boolean;
    function fCarregaDupAgrupadas(strNumDup, strEspecie, strCodEmp: String; strCodCli: String): Boolean;
    function fCarregaDupAgrupadasNaoImpressas(strNumDup, strEspecie, strCodEmp: String; intJaImpressas: Integer; strCodCli: String = ''): Boolean;
    function fCarregaInfoLayoutMercantil(strNumDup,
                                         strCodEmp,
                                         strEspdoc,
                                         strCodCli,
                                         strPrccid,
                                         strPrcest,
                                         strNomCid,
                                         strEstado,
                                         strParcel: String;
                                         intPerDpo: Double = 0 ): Boolean ;

    function fGravaBancoBoleto(strNumDup,strParcel,strCodCli,strCodEmp,strEspDoc:String):Boolean;
    function fMontaUpdate(strNumDup, strParcel, strCodCli, strCodEmp, strEspDoc:String):String;
    function frxDuplicataMerecantilUserFunction(const MethodName: String;
                                                var Params: Variant): Variant;
    procedure frxGenGetValue(const VarName: String;
                             var Value: Variant);

    function fLoadLayoutReport(strTipoRelatorio: String): Boolean;
    procedure pCriaCdsRelatorio(cdsBoletos: TDataSet);
    procedure ClearObjetos;
    procedure CarregaItensMercantil(ANumDoc,AEspDoc,ACodCli,ACodEmp:String);
    procedure PreparadaImpressaoMercantilItens;
    Function fCarregaItensMercantilImp(ANumDoc,AEspDoc,ACodCli,ACodEmp:String) : Boolean;
    Function fCarregaParcelasReferentesADocumento(ANumDoc,AEspDoc,ACodCli,ACodEmp:String) : Boolean;
    Function fGetMensagensMOVGER(ANumDoc, AEspDoc, ACodCli, ACodEmp, AParcel: String): String;
    Function fVerificaSeTemItemPedido() : Boolean;
    procedure CriarListaClientes(Var AClientes:TStringList; ADuplicatas: TDataSet);
  public
    recCamposDigBoleto: TDadosTelaDigBoleto;
    FClientes: TStringList;

    constructor Create;
    destructor Free;
    Destructor Destroy; Override;

    function fRetornaDupMercMatric: String;
    function fImprimirDuplicataMercantil(blnGerPdf: Boolean = False; blnEnvEmail: Boolean = False; blnEditorEmail: Boolean = False; blnImprimir: Boolean = False): Boolean;
    function fPegaNossoNumero(qryConBco: TDataSet; strCodBco, strRetBco, strEmpresaImpressao: String; intRetCar: Integer): string;
  end;

implementation

uses
  untFuncoesSimples, untCadRec, StrUtils, untValorPorExtenso, untFuncoesBoleto, frxExportPDF, untTEnvioEmail;

{ TDigBoleto }

procedure TDigBoleto.ClearObjetos;
begin
  // esses objetos devem ser liberados da memoria antes do liberar a frmQckBancos
  Try
    If Assigned(Self.frxRelatorio) Then
      FreeAndNil(Self.frxRelatorio);

    If Assigned(Self.frxDupAgrupadas) Then
      FreeAndNil(Self.frxDupAgrupadas);

    If Assigned(Self.frxDuplicataMercantil) Then
      FreeAndNil(Self.frxDuplicataMercantil);

    If Assigned(Self.frxRelatorioDups) Then
      FreeAndNil(Self.frxRelatorioDups);

    If Assigned(Self.frxGen) Then
      FreeAndNil(Self.frxGen);

    If Assigned(Self.frmQckBancos) Then
      FreeAndNil(Self.frmQckBancos);
  Except
    On E : Exception Do
    Begin
      // para não parar a impressão
    End;
  End;
end;

procedure TDigBoleto.CarregaItensMercantil(ANumDoc,AEspDoc,ACodCli,ACodEmp:String);
  Var
    SqlItens: String;
begin
  SqlItens := '';

  SqlItens := ' SELECT                                                                       '+
                   IntToStr(intQtdImp) + ' AS QUANTIDADE_VIAS,                               '+
              '    CTR_DTACAD AS DATA_CADASTRO,                                              '+
              '    CTR_DTAVEN AS DATA_VENCIMENTO,                                            '+
              '    COUNT(DET_CODITE) AS QTDITENSPEDIDO,                                      '+
              '    UPPER(CONCAT(IFNULL(CLI_ENDERE,""), ", ", IFNULL(CLI_ENDNUM,""), ", ",    '+
              '           IFNULL(CLI_BAIRRO,""), " - " , IFNULL(CID_NOMCID,""), "/",         '+
              '           IFNULL(CID_ESTADO,""))) AS ENDERECO_CLIENTE,                       '+
              '    CLI_CODCLI AS CODCLIENTE,                                                 '+
              '    CLI_NOMCLI AS NOMECLIENTE,                                                '+
              '    IFNULL(FPG_DESCRI,"OUTRAS") AS FORMAPAGAMENTO,                            '+
              '    IFNULL(DET_SERIE_,CTR_PARCEL) AS SERIE,                                   '+
              '    IFNULL(IFNULL(DET_NUM_PD,DET_NUMDOC),CTR_NUMDUP) AS NUMPEDIDO,            '+
              '    IFNULL(DET_CODVEN,CTR_CODVEN) AS CODVENDEDOR,                             '+
              '    OPE_NOMOPE AS NOMVENDEDOR,                                                '+
              '    IFNULL(DET_NUMDOC,CTR_NUMDUP) AS NUMDOCUMENTO,                            '+
              '    DET_CODITE AS CODITEM,                                                    '+
              '    DET_DESCRI AS DESCRICAOITEM,                                              '+
              '    UNI_DESUNI AS UNIDADE,                                                    '+
              '    IF(LEFT(DET_CLAFIS,1) < 5, -DET_QTDITE,DET_QTDITE) AS QTDEITEM,           '+
              '    IF(LEFT(DET_CLAFIS,1) < 5, -DET_UNITAR,DET_UNITAR) AS UNITARIOITEM,       '+
              '    IF(LEFT(DET_CLAFIS,1) < 5, -DET_UNIORI,DET_UNIORI) AS UNIORIITEM,         '+
              '    IFNULL(IF(LEFT(DET_CLAFIS,1) < 5, -DET_TOTITE,DET_TOTITE),                '+
              '    (CTR_VALDUP - CTR_DESSUJ + CTR_JURSUJ + CTR_DESCOB)) AS TOTALITEM,        '+
              '    IF(LEFT(DET_CLAFIS,1) < 5, -DET_DESESP,DET_DESESP) AS TOTALDESESP,        '+
              '    IF(LEFT(DET_CLAFIS,1) < 5, -DET_DESCON,DET_DESCON) AS DESCONTOITEM,       '+
              '    IF(LEFT(DET_CLAFIS,1) < 5, -DET_TOTFRE,DET_TOTFRE) AS TOTALFRETE,         '+
              '    IFNULL(IF(IF(LEFT(DET_CLAFIS,1) < 5, -DET_TOTITE,DET_TOTITE) >            '+
              '      (IF(LEFT(DET_CLAFIS,1) < 5, -DET_QTDITE,DET_QTDITE) *                   '+
              '       IF(LEFT(DET_CLAFIS,1) < 5, -DET_UNIORI,DET_UNIORI)),                   '+
              '       IF(LEFT(DET_CLAFIS,1) < 5, -DET_TOTITE,DET_TOTITE),                    '+
              '      (IF(LEFT(DET_CLAFIS,1) < 5, -DET_QTDITE,DET_QTDITE) *                   '+
              '       IF(LEFT(DET_CLAFIS,1) < 5, -DET_UNIORI,DET_UNIORI))                    '+
              '    ),CTR_VALDUP) AS TOTALBRUTO,                                              '+
              '    IFNULL(IF(((IF(LEFT(DET_CLAFIS,1) < 5, -DET_QTDITE,DET_QTDITE) *          '+
              '         IF(LEFT(DET_CLAFIS,1) < 5, -DET_UNIORI,DET_UNIORI)) -                '+
              '         IF(LEFT(DET_CLAFIS,1) < 5, -DET_TOTITE,DET_TOTITE) )                 '+
              '    < 0,0.0,                                                                  '+
              '   ((IF(LEFT(DET_CLAFIS,1) < 5, -DET_QTDITE,DET_QTDITE) *                     '+
              '     IF(LEFT(DET_CLAFIS,1) < 5, -DET_UNIORI,DET_UNIORI)) -                    '+
              '     IF(LEFT(DET_CLAFIS,1) < 5, -DET_TOTITE,DET_TOTITE) )                     '+
              '   ),IF((CTR_VALDUP - CTR_DESSUJ + CTR_JURSUJ + CTR_DESCOB < CTR_VALDUP),     '+
              '     CTR_DESSUJ,0.0)) AS TOTALDESCONTO                                        '+
              ' FROM                                                                         '+
              '   CADREC                                                                     '+
              ' LEFT JOIN MOVDET                                                             '+
              '   ON CTR_NUMDUP = DET_NUMDOC                                                 '+
              '   AND CTR_ESPDOC = DET_ESPDOC                                                '+
              '   AND CTR_CODCLI = DET_CODCLI                                                '+
              '   AND CTR_CODEMP = DET_CODEMP                                                '+
              'LEFT JOIN CADFPG ON FPG_CODIGO = DET_CODFPG                                   '+
              'LEFT JOIN CADUNI ON UNI_CODUNI = DET_UNIDAD                                   '+
              'LEFT JOIN CADOPE ON OPE_CODOPE = IFNULL(DET_CODVEN,CTR_CODVEN)                '+
              'LEFT JOIN CADCLI ON CLI_CODCLI = IFNULL(DET_CODCLI,CTR_CODCLI)                '+
              'LEFT JOIN CADCID ON CID_CODCID = CLI_CODCID                                   '+
              'WHERE  CTR_NUMDUP = :NUMDUP                                                   '+
              '   AND CTR_ESPDOC = :ESPDOC                                                   '+
              '   AND CTR_CODCLI = :CODCLI                                                   '+
              '   AND CTR_CODEMP = :CODEMP                                                   '+
              ' GROUP BY MOVDET.AUTOINCREM                                                   ';
  Try
    LItensMercantil.Close;
    LItensMercantil.Sql.Clear;
    LItensMercantil.Sql.Add(SqlItens);
    LItensMercantil.ParamByName('NUMDUP').AsString := ANumDoc;
    LItensMercantil.ParamByName('ESPDOC').AsString := AEspDoc;
    LItensMercantil.ParamByName('CODCLI').AsString := ACodCli;
    LItensMercantil.ParamByName('CODEMP').AsString := ACodEmp;
    LItensMercantil.Open;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TDigBoleto.CarregaItensMercantil]');
    End;
  End;
end;

constructor TDigBoleto.Create;
begin
  pCriarFormularios(TfrmQckBancos, frmQckBancos);
  frxDuplicataMercantil := frmQckBancos.frxDuplicataMercantil;
  frxRelatorio := frmQckBancos.frxRelatorio;
  frxDupAgrupadas := frmQckBancos.frxDupAgrupadas;

  frxItensMercantil := frmQckBancos.frxItensMercantil;
  frxEmpresaMercantil := frmQckBancos.frxEmpresaMercantil;

  frxRelatorioDups := frmQckBancos.frxRelatorioDups;

  frxGen := frmQckBancos.frxGen;

  frxDuplicataMercantil.OnUserFunction := frxDuplicataMerecantilUserFunction;
  frxGen.OnGetValue := frxGenGetValue;

  frxDuplicataMercantil.AddFunction('function fRetExtensoNumero(Value : String): String');
  frxDuplicataMercantil.AddFunction('function fCarregaDupAgrupadas(strNumDup, strEspecie, strCodEmp: String): Boolean; strCodCli: String');
  frxDuplicataMercantil.AddFunction('function fCarregaDupAgrupadasNaoImpressas(strNumDup, strEspecie, strCodEmp: String; intJaImpressas: Integer; strCodCli: String = ''''): Boolean');
  frxDuplicataMercantil.AddFunction('function fRetNumParcela(strNumDoc: String): String;');
  frxDuplicataMercantil.AddFunction('function fQtdParcelas(strNumDup, strCodEmp, strEspDoc, strCodCli: String): Integer;');
  frxDuplicataMercantil.AddFunction('function fCarregaInfoLayoutMercantil(strNumDup,strCodEmp,strEspdoc,strCodCli,strPrccid,strPrcest,strNomCid,strEstado,strParcel: String, intPerDpo: Double = 0): Boolean ;');

  frxDuplicataMercantil.AddFunction('function fCarregaItensMercantilImp(ANumDoc,AEspDoc,ACodCli,ACodEmp:String) : Boolean;');
  frxDuplicataMercantil.AddFunction('function fCarregaParcelasReferentesADocumento(ANumDoc,AEspDoc,ACodCli,ACodEmp:String) : Boolean;');
  frxDuplicataMercantil.AddFunction('function fGetMensagensMOVGER(ANumDoc, AEspDoc, ACodCli, ACodEmp, AParcel: String): String;');
  recCamposDigBoleto.blnEnviarSMSBoleto := False;
end;

procedure TDigBoleto.CriarListaClientes(var AClientes: TStringList;
  ADuplicatas: TDataSet);
  Var
    LRecNo: Integer;
    LCodigoCliente: String;
begin
  If Assigned(AClientes) Then
    Exit;

  If Not Assigned(ADuplicatas) Then
    Exit;

  If ADuplicatas.IsEmpty Then
    Exit;

  LRecNo  := ADuplicatas.RecNo;
  Try
    AClientes := TStringList.Create;
    Try
      ADuplicatas.First;
      While Not ADuplicatas.Eof Do
      Begin
        LCodigoCliente := ADuplicatas.FieldByName('CTR_CODCLI').AsString;

        If (AClientes.IndexOf(LCodigoCliente) = -1) Then
          AClientes.Add(LCodigoCliente);

        ADuplicatas.Next;
        Application.ProcessMessages;
      End;
    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    ADuplicatas.RecNo := LRecNo;
  End;

end;

function TDigBoleto.fImprimirDuplicataMercantil(blnGerPdf: Boolean = False; blnEnvEmail: Boolean = False; blnEditorEmail: Boolean = False; blnImprimir: Boolean = False): Boolean;
Var
  LPersonalizado : Boolean;
begin
  Result := True;

  LPersonalizado := fLoadLayoutReport(recCamposDigBoleto.strTipoRelatorio);

  If Not LPersonalizado Then
    strArquivoFr3 := fRetornaDupMercMatric;

  If (Assigned(frxDuplicataMercantil.FindObject('lblConfAgr'))) Then
      TfrxMemoView(frxDuplicataMercantil.FindObject('lblConfAgr')).Text := ' ';

  If fEmptyStr(strArquivoFr3) Then
  begin
    If (recCamposDigBoleto.strTipoRelatorio = 'M') And Not LPersonalizado Then
    Begin
      fMensagem('ATENÇÃO', 'Para impressão Matricial, deve conter um Layout ' + #13 + 'no diretório do AUTCOM\Fr3. ' + #13 +
                           'Com nome de duplic_matricial_formulario_esp.fr3 ou duplic_matricial_formulario_esp_des.fr3', ['&OK']);
      Exit;
    end;
  end;

  If (Not blnGerPdf) Then
  Begin
    If (fCfgSis('VIAMER', varBoolean)) Then
    Begin
      intQtdImp := fGetMenu('Qtd. Vias', ['1 Via', '2 Vias', '3 Vias', '4 Vias'], 1);

      intQtdImp := intQtdImp;
    End
    Else
    Begin
      If fCfgSis('QTDVME', varInteger) > 0 Then
        intQtdImp := fCfgSis('QTDVME', varInteger);
    End;

    Result := fDuplicataMercantilImpressoraLaser(blnGerPdf, blnEnvEmail, blnEditorEmail, blnImprimir)
  End
  Else
  Begin
    intQtdImp := 1;
    Result := fDuplicataMercantilImpressoraLaser(blnGerPdf, blnEnvEmail, blnEditorEmail, blnImprimir);
  End;
end;

function TDigBoleto.fLoadLayoutReport(strTipoRelatorio: String): Boolean;
  Var
    mmsLoad: TStream;
    FLayImp: TUniQuery;
Begin
  Result := False;

  Try
    Try
      FLayImp := fCriarQuery('SELECT * FROM   ' +
                             '  LAYIMP        ' +
                             'WHERE           ' +
                             '  LAY_TIPLAY = "' + strTipoRelatorio + '" AND ' +
                             '  LAY_CODEMP = "' + VS_strCodEmp + '" AND ' +
                             '  LAY_CODLAY = "MERCTR" ' +
                             'ORDER BY          ' +
                             '  LAY_DTAALT DESC,' +
                             '  LAY_HORALT DESC ' +
                             'LIMIT 1           ');



      FLayImp.Open;

      If Not FLayImp.IsEmpty Then
      Begin
        Result := True;
        mmsLoad := FLayImp.CreateBlobStream(FLayImp.FieldByName('LAY_RELFR3'), bmRead);
        frxDuplicataMercantil.LoadFromStream(mmsLoad);
        FreeAndNil(mmsLoad);
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[fLoadReport]');
      End;

    End;

  Finally
    If Assigned(FLayImp) Then
      FreeAndNil(FLayImp);
  End;

End;

function TDigBoleto.fRetornaDupMercMatric: String;
begin
  Result := ExtractFilePath(Application.ExeName) + 'Fr3\' + 'duplic_matricial_formulario_esp.fr3';

  If Not FileExists(Result) Then
    Result := ExtractFilePath(Application.ExeName) + 'Fr3\' + 'duplic_matricial_formulario_esp_des.fr3';

  If Not FileExists(Result) Then
    Result := '';
end;

function TDigBoleto.fDuplicataMercantilImpressoraLaser(blnGerPdf: Boolean = False; blnEnvEmail: Boolean = False; blnEditorEmail: Boolean = False; blnImprimir: Boolean = False): Boolean;
Var
  i        : Integer;
  intCont  : Integer;
  intCont2 : Integer;
  intTotReg: Integer;
  qryCadCli: TUniQuery;
  qryCadEmp: TUniQuery;
  qryCliEml: TUniQuery;
  intRecNo : Integer;
  strNomFil: String;
  strTipImp: String;
  blnTemAgr: Boolean;
  blnTemNumPed: Boolean;
  blnTemItensPed: Boolean;
  qryCfgRel: TUniQuery;
  frxPDFExport: TfrxPDFExport;
  FMora: String;
  FSmbOem: String;
  IContador,
  IClientes: Integer;
  FEnviarEmail: TDadosEnvioEmail;
  arrDestinatarios, arrArquivos: TStringArray;
  FEmail, FCodCli, FArqCli: String;
  LLoop: Integer;
  LFiltroCliente: String;
Const
  intMaxAg : Integer = 19;
Begin
  blnTemAgr := False;
  intRecNo  := 0;
  LLoop := 0;
  LFiltroCliente := '';

  Try
    Result := False;
    qryCadCli := fCriaQuery;
    qryCadEmp := fCriaQuery;
    qryCliEml := fCriaQuery;
    frxPdfExport := TfrxPDFExport.Create(Nil);
    LItensMercantil   := fCriaQuery(Nil);
    LEmpresaMercantil := fCriaQuery(Nil);
    CriarListaClientes(FClientes,recCamposDigBoleto.cdsBoletos);

    If Not blnEnvEmail Then
      LLoop := FClientes.Count - 1;

    For IClientes := LLoop To FClientes.Count - 1 Do
    Begin
      blnTemNumPed := False;
      frxDuplicataMercantil.Variables.Clear;
      qryCadCli.SQL.Text := fSqlCadCli(recCamposDigBoleto.strEmpresaImpressao);
      qryCliEml.SQL.Text := fSqlCadCliEmail;
      qryCadEmp.SQL.Text := fSqlEmpresa;

      qryDupAgrupadas :=  TZClient.Create(Nil);
      frxDupAgrupadas.DataSet := qryDupAgrupadas;

      LParcelasDocto     := fCriaQuery(Nil);
      frxRelatorioDups.DataSet := LParcelasDocto;

      If blnEnvEmail Then
        LFiltroCliente := ' AND CTR_CODCLI = ' + QuotedStr(FClientes[IClientes]);

      intRecNo := recCamposDigBoleto.cdsBoletos.RecNo;
      recCamposDigBoleto.cdsBoletos.DisableControls;
      recCamposDigBoleto.cdsBoletos.Filter := 'CTR_MARDES = ' + QuotedStr('M') + ' AND CTR_ESPDOC = ' + QuotedStr('AG') + LFiltroCliente;
      recCamposDigBoleto.cdsBoletos.Filtered := True;

      blnTemAgr := (Not recCamposDigBoleto.cdsBoletos.IsEmpty) And (fCfgSis('MDDPAG', varBoolean, recCamposDigBoleto.strEmpresaImpressao));
      If (Assigned(frxDuplicataMercantil.FindObject('lblConfAgr'))) Then
        TfrxMemoView(frxDuplicataMercantil.FindObject('lblConfAgr')).Text := IIF(blnTemAgr, '1', '0');

      recCamposDigBoleto.cdsBoletos.Filtered := False;
      recCamposDigBoleto.cdsBoletos.Filter := 'CTR_MARDES = ' + QuotedStr('M') + LFiltroCliente;
      recCamposDigBoleto.cdsBoletos.Filtered := True;

      {layout personalizado com itens Req: 209052 MT}
      PreparadaImpressaoMercantilItens;

      SetLength(FInfoDupMer, 1);
      blnTemItensPed := (fVerificaSeTemItemPedido() and (recCamposDigBoleto.blnReimp=False));

      pCriaCdsRelatorio(recCamposDigBoleto.cdsBoletos);

      pOrdenaDataSet(recCamposDigBoleto.cdsBoletos, recCamposDigBoleto.strOrdenacaoCampos, recCamposDigBoleto.strOrdenacaoTipo);

      If blnTemAgr Then
      Begin
        cdsAgQuebra := TUniClientDataSet.Create(Nil);
        cdsAgQuebra.Data := cdsRelatorio.Data;
        cdsAgQuebra.Open;
      End;

      {***********************************}
      { Imprimir várias vias da duplicata }
      {********************************RV*}
      recCamposDigBoleto.cdsBoletos.First;
      While Not recCamposDigBoleto.cdsBoletos.Eof Do
      Begin
        {**********************************}
        { PEGA EMPRESA DA DUPLICATA        }
        {*******************************JB*}
        qryCadEmp.Close;
        qryCadEmp.ParamByName('CODEMP').AsString := recCamposDigBoleto.cdsBoletos.FieldByName('CTR_CODEMP').asString;
        qryCadEmp.Open;

        cdsRelatorio.DisableControls;

        If qryCadCli.ParamByName('CODCLI').AsString <> recCamposDigBoleto.cdsBoletos.FieldByName('CTR_CODCLI').AsString Then
        Begin
          qryCadCli.Close;
          qryCadCli.ParamByName('CODCLI').AsString := recCamposDigBoleto.cdsBoletos.FieldByName('CTR_CODCLI').AsString;
          qryCadCli.Open;
        End;

        If qryCliEml.ParamByName('CODCLI').AsString <> recCamposDigBoleto.cdsBoletos.FieldByName('CTR_CODCLI').AsString Then
        Begin
          qryCliEml.Close;
          qryCliEml.ParamByName('CODCLI').AsString := recCamposDigBoleto.cdsBoletos.FieldByName('CTR_CODCLI').AsString;
          qryCliEml.Open;
        End;

        If (blnGerPdf) Then
        Begin
          If Not DirectoryExists(ExtractFilePath(Application.ExeName) + 'Duplicatas Mercantil') Then
            CreateDir(ExtractFilePath(Application.ExeName) + 'Duplicatas Mercantil');


          frxPDFExport.FileName := recCamposDigBoleto.cdsBoletos.Fields.FieldByName('CTR_NUMDUP').AsString + '.pdf';
          frxPDFExport.DefaultPath := ExtractFilePath(Application.ExeName) + 'Duplicatas Mercantil';
          frxPDFExport.ShowDialog := False;
          frxPDFExport.ShowProgress := False;

          If blnEnvEmail Then
          Begin
            FEmail := fRetornaEmailCliente(qryCliEml);
            FCodCli := qryCliEml.ParamByName('CODCLI').AsString;
            FArqCli := ExtractFilePath(Application.ExeName) + 'Duplicatas Mercantil' + '\' + frxPDFExport.FileName;
          End;
        End;

        For i := 1 To intQtdImp Do
        Begin
          If Not blnTemAgr Then
          Begin
            cdsRelatorio.Append;

            For intCont := 0 To recCamposDigBoleto.cdsBoletos.Fields.Count -1 Do
              cdsRelatorio.Fields[intCont].Value := recCamposDigBoleto.cdsBoletos.Fields[intCont].Value;

            For intCont := 0 To qryCadCli.Fields.Count -1 Do
              cdsRelatorio.FieldByName(qryCadCli.Fields[intCont].FieldName).Value := qryCadCli.Fields[intCont].Value;

            For intCont := 0 To qryCadEmp.Fields.Count -1 Do
              cdsRelatorio.FieldByName(qryCadEmp.Fields[intCont].FieldName).Value := qryCadEmp.Fields[intCont].Value;

            if (recCamposDigBoleto.cdsBoletos.Fields.FieldByName('CTR_ESPDOC').AsString = 'NS') then
              cdsRelatorio.FieldByName('TEXTOR').Value := StringReplace(
                                                            cdsRelatorio.FieldByName('TEXTOR').Value,
                                                            'DUPLICATA DE VENDA MERCANTIL',
                                                            'DUPLICATA DE PRESTAÇÃO DE SERVIÇO',
                                                            [rfIgnoreCase]);

            cdsRelatorio.Post;
          End
          Else
          Begin

            If (recCamposDigBoleto.cdsBoletos.Fields.FieldByName('CTR_ESPDOC').AsString = 'AG') And
               (FileExists(strArquivoFr3) And fCfgSis('MDDPAG', varBoolean, recCamposDigBoleto.strEmpresaImpressao)) Then
            Begin

              If fCarregaDupAgrupadas(recCamposDigBoleto.cdsBoletos.Fields.FieldByName('NRODUP').AsString,
                                      recCamposDigBoleto.cdsBoletos.Fields.FieldByName('CTR_ESPDOC').AsString,
                                      recCamposDigBoleto.cdsBoletos.Fields.FieldByName('CTR_CODEMP').AsString,
                                      recCamposDigBoleto.cdsBoletos.Fields.FieldByName('CTR_CODCLI').AsString) Then
              Begin
                intTotReg := 1;

                For intCont2 := 1 To qryDupAgrupadas.RecordCount Do
                Begin
                  If (intTotReg >= intMaxAg)                  And
                     (intCont2 < qryDupAgrupadas.RecordCount) Then
                  Begin
                    cdsAgQuebra.Append;

                    cdsAgQuebra.FieldByName('CTR_VALDUP').AsFloat    := 0;
                    cdsAgQuebra.FieldByName('CTR_NUMDUP').AsString   := recCamposDigBoleto.cdsBoletos.Fields.FieldByName('CTR_NUMDUP').AsString;
                    cdsAgQuebra.FieldByName('NRODUP').AsString       := recCamposDigBoleto.cdsBoletos.Fields.FieldByName('NRODUP').AsString;
                    cdsAgQuebra.FieldByName('CTR_DTACAD').AsDateTime := recCamposDigBoleto.cdsBoletos.Fields.FieldByName('CTR_DTACAD').AsDateTime;
                    cdsAgQuebra.FieldByName('CTR_DTAVEN').AsDateTime := recCamposDigBoleto.cdsBoletos.Fields.FieldByName('CTR_DTAVEN').AsDateTime;
                    cdsAgQuebra.FieldByName('CTR_ESPDOC').AsString   := recCamposDigBoleto.cdsBoletos.Fields.FieldByName('CTR_ESPDOC').AsString;
                    cdsAgQuebra.FieldByName('CTR_CODEMP').AsString   := recCamposDigBoleto.cdsBoletos.Fields.FieldByName('CTR_CODEMP').AsString;
                    cdsAgQuebra.FieldByName('CTR_PARCEL').AsString   := recCamposDigBoleto.cdsBoletos.Fields.FieldByName('CTR_PARCEL').AsString;
                    cdsAgQuebra.FieldByName('CTR_CODCLI').AsString   := recCamposDigBoleto.cdsBoletos.Fields.FieldByName('CTR_CODCLI').AsString;
                    cdsAgQuebra.FieldByName('CLI_NOMCLI').AsString   := qryCadCli.FieldByName('NOMCLI').AsString;
                    cdsAgQuebra.FieldByName('NOMCLI').AsString       := qryCadCli.FieldByName('NOMCLI').AsString;
                    cdsAgQuebra.FieldByName('ENDERE').AsString       := qryCadCli.FieldByName('ENDERE').AsString;
                    cdsAgQuebra.FieldByName('BAIRRO').AsString       := qryCadCli.FieldByName('BAIRRO').AsString;
                    cdsAgQuebra.FieldByName('CIDADE').AsString       := qryCadCli.FieldByName('CIDADE').AsString;
                    cdsAgQuebra.FieldByName('ESTADO').AsString       := qryCadCli.FieldByName('ESTADO').AsString;
                    cdsAgQuebra.FieldByName('PRCCID').AsString       := qryCadCli.FieldByName('PRCCID').AsString;
                    cdsAgQuebra.FieldByName('PRCEST').AsString       := qryCadCli.FieldByName('PRCEST').AsString;
                    cdsAgQuebra.FieldByName('C_E_P_').AsString       := qryCadCli.FieldByName('C_E_P_').AsString;
                    cdsAgQuebra.FieldByName('C_G_C_').AsString       := qryCadCli.FieldByName('C_G_C_').AsString;
                    cdsAgQuebra.FieldByName('I_E_S_').AsString       := qryCadCli.FieldByName('I_E_S_').AsString;
                    cdsAgQuebra.FieldByName('EMAIL_').AsString       := qryCadCli.FieldByName('EMAIL_').AsString;

                    cdsAgQuebra.FieldByName('EMP_NOMEMP').AsString   := qryCadEmp.FieldByName('EMP_NOMEMP').AsString;
                    cdsAgQuebra.FieldByName('EMP_ENDERE').AsString   := qryCadEmp.FieldByName('EMP_ENDERE').AsString;
                    cdsAgQuebra.FieldByName('EMP_ENDNUM').AsString   := qryCadEmp.FieldByName('EMP_ENDNUM').AsString;
                    cdsAgQuebra.FieldByName('EMP_C_E_P_').AsString   := qryCadEmp.FieldByName('EMP_C_E_P_').AsString;
                    cdsAgQuebra.FieldByName('EMP_BAIRRO').AsString   := qryCadEmp.FieldByName('EMP_BAIRRO').AsString;
                    cdsAgQuebra.FieldByName('CID_NOMCID').AsString   := qryCadEmp.FieldByName('CID_NOMCID').AsString;
                    cdsAgQuebra.FieldByName('CID_ESTADO').AsString   := qryCadEmp.FieldByName('CID_ESTADO').AsString;
                    cdsAgQuebra.FieldByName('EMP_C_G_C_').AsString   := qryCadEmp.FieldByName('EMP_C_G_C_').AsString;
                    cdsAgQuebra.FieldByName('EMP_I_E_S_').AsString   := qryCadEmp.FieldByName('EMP_I_E_S_').AsString;
                    cdsAgQuebra.FieldByName('EMP_FONE01').AsString   := qryCadEmp.FieldByName('EMP_FONE01').AsString;
                    cdsAgQuebra.FieldByName('EMP_EMAIL_').AsString   := qryCadEmp.FieldByName('EMP_EMAIL_').AsString;

                    cdsAgQuebra.Post;

                    intTotReg := 1;
                  End
                  Else
                  If intCont2 = qryDupAgrupadas.RecordCount Then
                  Begin
                    cdsAgQuebra.Append;

                    cdsAgQuebra.FieldByName('CTR_VALDUP').AsFloat    := recCamposDigBoleto.cdsBoletos.Fields.FieldByName('CTR_VALDUP').AsFloat;
                    cdsAgQuebra.FieldByName('CTR_NUMDUP').AsString   := recCamposDigBoleto.cdsBoletos.Fields.FieldByName('CTR_NUMDUP').AsString;
                    cdsAgQuebra.FieldByName('NRODUP').AsString       := recCamposDigBoleto.cdsBoletos.Fields.FieldByName('NRODUP').AsString;
                    cdsAgQuebra.FieldByName('CTR_DTACAD').AsDateTime := recCamposDigBoleto.cdsBoletos.Fields.FieldByName('CTR_DTACAD').AsDateTime;
                    cdsAgQuebra.FieldByName('CTR_DTAVEN').AsDateTime := recCamposDigBoleto.cdsBoletos.Fields.FieldByName('CTR_DTAVEN').AsDateTime;
                    cdsAgQuebra.FieldByName('CTR_ESPDOC').AsString   := recCamposDigBoleto.cdsBoletos.Fields.FieldByName('CTR_ESPDOC').AsString;
                    cdsAgQuebra.FieldByName('CTR_CODEMP').AsString   := recCamposDigBoleto.cdsBoletos.Fields.FieldByName('CTR_CODEMP').AsString;
                    cdsAgQuebra.FieldByName('CTR_PARCEL').AsString   := recCamposDigBoleto.cdsBoletos.Fields.FieldByName('CTR_PARCEL').AsString;
                    cdsAgQuebra.FieldByName('CTR_CODCLI').AsString   := recCamposDigBoleto.cdsBoletos.Fields.FieldByName('CTR_CODCLI').AsString;
                    cdsAgQuebra.FieldByName('CLI_NOMCLI').AsString   := qryCadCli.FieldByName('NOMCLI').AsString;
                    cdsAgQuebra.FieldByName('NOMCLI').AsString       := qryCadCli.FieldByName('NOMCLI').AsString;
                    cdsAgQuebra.FieldByName('ENDERE').AsString       := qryCadCli.FieldByName('ENDERE').AsString;
                    cdsAgQuebra.FieldByName('BAIRRO').AsString       := qryCadCli.FieldByName('BAIRRO').AsString;
                    cdsAgQuebra.FieldByName('CIDADE').AsString       := qryCadCli.FieldByName('CIDADE').AsString;
                    cdsAgQuebra.FieldByName('ESTADO').AsString       := qryCadCli.FieldByName('ESTADO').AsString;
                    cdsAgQuebra.FieldByName('PRCCID').AsString       := qryCadCli.FieldByName('PRCCID').AsString;
                    cdsAgQuebra.FieldByName('PRCEST').AsString       := qryCadCli.FieldByName('PRCEST').AsString;
                    cdsAgQuebra.FieldByName('C_E_P_').AsString       := qryCadCli.FieldByName('C_E_P_').AsString;
                    cdsAgQuebra.FieldByName('C_G_C_').AsString       := qryCadCli.FieldByName('C_G_C_').AsString;
                    cdsAgQuebra.FieldByName('I_E_S_').AsString       := qryCadCli.FieldByName('I_E_S_').AsString;
                    cdsAgQuebra.FieldByName('EMAIL_').AsString       := qryCadCli.FieldByName('EMAIL_').AsString;

                    cdsAgQuebra.FieldByName('EMP_NOMEMP').AsString   := qryCadEmp.FieldByName('EMP_NOMEMP').AsString;
                    cdsAgQuebra.FieldByName('EMP_ENDERE').AsString   := qryCadEmp.FieldByName('EMP_ENDERE').AsString;
                    cdsAgQuebra.FieldByName('EMP_ENDNUM').AsString   := qryCadEmp.FieldByName('EMP_ENDNUM').AsString;
                    cdsAgQuebra.FieldByName('EMP_C_E_P_').AsString   := qryCadEmp.FieldByName('EMP_C_E_P_').AsString;
                    cdsAgQuebra.FieldByName('EMP_BAIRRO').AsString   := qryCadEmp.FieldByName('EMP_BAIRRO').AsString;
                    cdsAgQuebra.FieldByName('CID_NOMCID').AsString   := qryCadEmp.FieldByName('CID_NOMCID').AsString;
                    cdsAgQuebra.FieldByName('CID_ESTADO').AsString   := qryCadEmp.FieldByName('CID_ESTADO').AsString;
                    cdsAgQuebra.FieldByName('EMP_C_G_C_').AsString   := qryCadEmp.FieldByName('EMP_C_G_C_').AsString;
                    cdsAgQuebra.FieldByName('EMP_I_E_S_').AsString   := qryCadEmp.FieldByName('EMP_I_E_S_').AsString;
                    cdsAgQuebra.FieldByName('EMP_FONE01').AsString   := qryCadEmp.FieldByName('EMP_FONE01').AsString;
                    cdsAgQuebra.FieldByName('EMP_EMAIL_').AsString   := qryCadEmp.FieldByName('EMP_EMAIL_').AsString;

                    cdsAgQuebra.Post;
                  End;

                  Inc(intTotReg);

                End;
              End;

            End
            Else
            Begin

              cdsAgQuebra.Append;

              For intCont := 0 To recCamposDigBoleto.cdsBoletos.Fields.Count -1 Do
                cdsAgQuebra.Fields[intCont].Value := recCamposDigBoleto.cdsBoletos.Fields[intCont].Value;

              For intCont := 0 To qryCadCli.Fields.Count -1 Do
                cdsAgQuebra.FieldByName(qryCadCli.Fields[intCont].FieldName).Value := qryCadCli.Fields[intCont].Value;

              For intCont := 0 To qryCadEmp.Fields.Count -1 Do
                cdsAgQuebra.FieldByName(qryCadEmp.Fields[intCont].FieldName).Value := qryCadEmp.Fields[intCont].Value;

              cdsAgQuebra.Post;
            End;

            If Not FileExists(strArquivoFr3) Then
              strArquivoFr3 := '';

          End;
        End;

        cdsRelatorio.EnableControls;
        recCamposDigBoleto.cdsBoletos.Next;
      End;

      If Not blnTemAgr Then
      begin
        {*********************************************}
        {** Aqui é verificado se existe na pesquisa **}
        {** o Campo "NUMPED" - Nro do Pedido        **}
        {****************Req. 100649**16/04/2018**WS**}
        For intCont := 0 To cdsRelatorio.Fields.Count -1 Do
          If cdsRelatorio.Fields[intCont].FieldName = 'NUMPED' Then
            blnTemNumPed := True;

        cdsRelatorio.First;
        frxRelatorio.DataSet := cdsRelatorio;
      end
      Else
      Begin
        cdsAgQuebra.First;
        pOrdenaDataSet(cdsAgQuebra, recCamposDigBoleto.strOrdenacaoCampos + 'CTR_ESPDOC;CTR_NUMDUP', recCamposDigBoleto.strOrdenacaoTipo);
        frxRelatorio.DataSet := cdsAgQuebra;
      End;

      Try
        frxDuplicataMercantil.Script.Variables['PRACAPAGAMENTO'] := fCfgSis('PRAPAG', varString, recCamposDigBoleto.strEmpresaImpressao);
        frxDuplicataMercantil.Script.Variables['PONTUALIDADE']   := fCfgSis('DESPON', varString, recCamposDigBoleto.strEmpresaImpressao);
        FMora := fPadL(FloatToStr(fFormataFloat((frxRelatorio.DataSet.Fields.FieldByName('CTR_VALDUP').AsFloat * recCamposDigBoleto.fltPercentualMora) / 100.0, 02) * 100), 14, '0');
        frxDuplicataMercantil.Script.Variables['MORA'] :=  FormatFloat('R$ #,##0.00', StrToCurr(Trim(Copy(FMora, 1,12) + ',' + Copy(FMora, 13,02))));
        frxDuplicataMercantil.Script.Variables['DUPLIC']:= frxRelatorio.DataSet.FieldByName('NRODUP').AsString +'-'+frxRelatorio.DataSet.FieldByName('CTR_PARCEL').AsString;

        frxDuplicataMercantil.Script.Variables['TEMITENS'] := IIF(blnTemItensPed,'S','N');
        frxDuplicataMercantil.Script.Variables['QVIAS']    := intToStr(intQtdImp);

        If FileExists(strArquivoFr3) Then
        Begin
          frxDuplicataMercantil.LoadFromFile(strArquivoFr3);
          strTipImp := 'M';

          {*******************************************************************}
          {** Aqui é verificado se existe no .FR3 o objeto de Nro de Pedido **}
          {** e se não existir o campo NUMPED ou CFG_IPDMER = 'N'           **}
          {** ou é Agrupamento então desabilita o objeto de Nro de Pedido   **}
          {**************************************Req. 100649**16/04/2018**WS**}
          If (Assigned(frxDuplicataMercantil.FindObject('DMPNroPed'))) And
             ((Not fCfgSis('IPDMER', varBoolean, recCamposDigBoleto.strEmpresaImpressao)) Or (blnTemAgr) Or (Not blnTemNumPed)) Then
          Begin
              frxDuplicataMercantil.FindObject('DMPNroPed').Visible := False;
              frxDuplicataMercantil.FindObject('DMPPePed').Visible  := False;
          End;
        End;

        qryCfgRel := fCriaQuery;
        pCarregaConfImpr(qryCfgRel, recCamposDigBoleto.strFormulario);

        If Not blnGerPdf Then
          fPreImpressao(qryCfgRel, strNomFil, strTipImp, False);

        If (strTipImp <> 'M') Then
        Begin
          If FileExists(fCfgSis('PATLOG', varString, recCamposDigBoleto.strEmpresaImpressao)) and
             (Assigned(frxDuplicataMercantil.FindObject('imgImagem'))) Then
          Begin
            TfrxPictureView(frxDuplicataMercantil.FindObject('imgImagem')).Picture.LoadFromFile(fCfgSis('PATLOG'));

            If(Assigned(frxDuplicataMercantil.FindObject('imgImagem2'))) Then
              TfrxPictureView(frxDuplicataMercantil.FindObject('imgImagem2')).Picture.LoadFromFile(fCfgSis('PATLOG'));
          End
          Else
          If FileExists(fCfgSis('IMGBOL', varString, recCamposDigBoleto.strEmpresaImpressao)) and
             (Assigned(frxDuplicataMercantil.FindObject('imgImagem'))) Then
          Begin
            TfrxPictureView(frxDuplicataMercantil.FindObject('imgImagem')).Picture.LoadFromFile(fCfgSis('IMGBOL'));

            If(Assigned(frxDuplicataMercantil.FindObject('imgImagem2'))) Then
              TfrxPictureView(frxDuplicataMercantil.FindObject('imgImagem2')).Picture.LoadFromFile(fCfgSis('IMGBOL'));
          End;

          frxDuplicataMercantil.Script.Variables['JURDIA']       := FloatToStrF((cdsRelatorio.FieldByName('CTR_VALDUP').AsFloat * recCamposDigBoleto.fltPercentualMulta) / 100, ffFixed,12,2);
          frxDuplicataMercantil.Script.Variables['QTDEVIAS']     := intQtdImp;
          //frxDuplicata.Script.Variables['IMPAR'] := IIF(intQtdImp mod 2 = 0, '0', '1');
        End;

        If Assigned(frxDuplicataMercantil.FindObject('Memo20')) Then
          TfrxMemoView(frxDuplicataMercantil.FindObject('Memo20')).Text := 'DUPLICATA MERCANTIL';
        If Assigned(frxDuplicataMercantil.FindObject('Memo2')) Then
          TfrxMemoView(frxDuplicataMercantil.FindObject('Memo2')).Text  := 'DUPLICATA MERCANTIL';

        If (Assigned(frxDuplicataMercantil.FindObject('DMPMemo7'))) Then
          TfrxMemoView(frxDuplicataMercantil.FindObject('DMPMemo7')).Text := '';

        If (Not fEmptyStr(fCfgSis('IMGBOL', varString, recCamposDigBoleto.strEmpresaImpressao))) And
           (FileExists(fCfgSis('IMGBOL', varString, recCamposDigBoleto.strEmpresaImpressao))) And
           (Assigned(frxDuplicataMercantil.FindObject('imgLogo'))) Then
          TfrxPictureView(frxDuplicataMercantil.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('IMGBOL', varString, recCamposDigBoleto.strEmpresaImpressao));

        frxDuplicataMercantil.PrintOptions.Printer := AnsiReplaceStr(strNomFil,'\\' + fRetNomeRede + '\', '');
        frxDuplicataMercantil.PrintOptions.ShowDialog := fEmptyStr(frxDuplicataMercantil.PrintOptions.Printer);

        If blnGerPdf Then
        Begin
          If frxDuplicataMercantil.PrepareReport Then
            frxDuplicataMercantil.Export(frxPDFExport);

          If (blnEnvEmail) Then
          Begin
            FInfoDupMer[0].FArqDupMer := FArqCli;
            FInfoDupMer[0].FEmailCli  := FEmail;
            FInfoDupMer[0].FCodCli    := FCodCli;
            SetLength(FInfoDupMer, Length(FInfoDupMer) + 1);
          End;
        End
        Else If frxDuplicataMercantil.PrintOptions.ShowDialog Then
          pPreviewReport(recCamposDigBoleto.strFormulario, 'Duplicata Mercantil', frxDuplicataMercantil)
        Else If frxDuplicataMercantil.PrepareReport Then
        Begin
          pPrintReport(recCamposDigBoleto.strFormulario, 'Duplicata Mercantil', strNomFil, frxDuplicataMercantil);
        End;

        recCamposDigBoleto.cdsBoletos.First;
        while not recCamposDigBoleto.cdsBoletos.Eof do
        begin
          If Not (recCamposDigBoleto.cdsBoletos.IsEmpty) And
                 (recCamposDigBoleto.cdsBoletos.FieldByName('CTR_BOLETO').AsString = 'Não') Then
          begin
            fGravaBancoBoleto(recCamposDigBoleto.cdsBoletos.FieldByName('NRODUP').AsString,
                              recCamposDigBoleto.cdsBoletos.FieldByName('PARDUP').AsString,
                              recCamposDigBoleto.cdsBoletos.FieldByName('CTR_CODCLI').AsString,
                              recCamposDigBoleto.cdsBoletos.FieldByName('CTR_CODEMP').AsString,
                              recCamposDigBoleto.cdsBoletos.FieldByName('CTR_ESPDOC').AsString);
          end;

          {****************}
          {* GRAVA LOGCTR *}
          {*************JS*}
          If (blnImprimir) Then
          Begin
            untCadRec.pGravaLogCtr(recCamposDigBoleto.cdsBoletos.FieldByName('AUTOINCREM').AsString,
                                  IIF(recCamposDigBoleto.cdsBoletos.FieldByName('CTR_BOLETO').AsString = 'Não', 'IMPRESSÃO DE DUPLICATA MERCANTIL', 'REIMPRESSÃO DE DUPLICATA MERCANTIL'),
                                  recCamposDigBoleto.strFormulario);
          End;

          recCamposDigBoleto.cdsBoletos.Next;
        end;
      Finally
        If Assigned(qryCfgRel) Then
          FreeAndNil(qryCfgRel);
      End;

      If (blnEnvEmail) Then
      Begin
        FEnviarEmail := TDadosEnvioEmail.Create;
        FSmbOem := fCfgSis('MSBOEM', varString);

        For IContador := Low(FInfoDupMer) To High(FInfoDupMer) Do
        Begin
          If Not fEmptyStr(FInfoDupMer[IContador].FEmailCli) Then
          Begin
            pCriarArrayAnexosEDestinatarios(FInfoDupMer[IContador].FArqDupMer, FInfoDupMer[IContador].FEmailCli, arrDestinatarios, arrArquivos);
            FEnviarEmail.AOwner := Nil;
            FEnviarEmail.ACodOperador := strLoginUsuarioLogado;
            FEnviarEmail.AAssunto :=  'Duplicata Mercantil';
            FEnviarEmail.APara :=  arrDestinatarios;
            FEnviarEmail.ACorpoMensagem :=  ['Segue duplicatas em anexo.', FSmbOem];
            FEnviarEmail.AAnexos := arrArquivos;

            If blnEditorEmail Then
              FEnviarEmail.AAbrirEditor := True
            Else
              FEnviarEmail.AAbrirEditor := False;

            FEnviarEmail.blnVizualizar := blnEditorEmail;
            FEnviarEmail.AExibirMensagemConfirmacaoEnvio := (IContador = High(FInfoDupMer));
            TEnvioEmail.EnviarEmail(FEnviarEmail);
            strArqBoletos := '';
          End;
        End;
      End;
    End;
    Result := True;
  Finally
    recCamposDigBoleto.cdsBoletos.Filtered := False;
    recCamposDigBoleto.cdsBoletos.RecNo := intRecNo;
    recCamposDigBoleto.cdsBoletos.EnableControls;
    FreeAndNil(qryCadCli);
    FreeAndNil(qryCliEml);

    If Assigned(qryDupAgrupadas) Then
      FreeAndNil(qryDupAgrupadas);

    If blnTemAgr Then
     FreeAndNil(cdsAgQuebra);

    If Assigned(frxPDFExport) Then
      FreeAndNil(frxPDFExport);

    SetLength(FInfoDupMer, 0);
  End;
End;

procedure TDigBoleto.pCriaCdsRelatorio(cdsBoletos: TDataSet);
  Var
    intCont: Integer;
Begin
  cdsRelatorio := TUniClientDataSet.Create(Nil);

  For intCont := 0 To cdsBoletos.Fields.Count -1 Do
  Begin
    With cdsRelatorio.FieldDefs.AddFieldDef Do
    Begin
      Name     := cdsBoletos.Fields[intCont].FieldName;
      DataType := cdsBoletos.Fields[intCont].DataType;
      Size     := cdsBoletos.Fields[intCont].Size;
      Required := False;
    End;
  End;

  With cdsRelatorio.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ENDERE';
    DataType := ftString;
    Size     := 300;
    Required := False;
  End;

  With cdsRelatorio.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'BAIRRO';
    DataType := ftString;
    Size     := 60;
    Required := False;
  End;

  With cdsRelatorio.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'C_E_P_';
    DataType := ftString;
    Size     := 30;
    Required := False;
  End;

  With cdsRelatorio.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'C_G_C_';
    DataType := ftString;
    Size     := 50;
    Required := False;
  End;

  With cdsRelatorio.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'I_E_S_';
    DataType := ftString;
    Size     := 50;
    Required := False;
  End;

  With cdsRelatorio.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CIDADE';
    DataType := ftString;
    Size     := 100;
    Required := False;
  End;

  With cdsRelatorio.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ESTADO';
    DataType := ftString;
    Size     := 2;
    Required := False;
  End;

  With cdsRelatorio.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'TEXTOR';
    DataType := ftMemo;
    Size     := 2;
    Required := False;
  End;

  With cdsRelatorio.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'FONE01';
    DataType := ftString;
    Size     := 20;
    Required := False;
  End;

  With cdsRelatorio.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CLICGC';
    DataType := ftString;
    Size     := 20;
    Required := False;
  End;

  With cdsRelatorio.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODCLI';
    DataType := ftString;
    Size     := 08;
    Required := False;
  End;

  With cdsRelatorio.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'NOMCLI';
    DataType := ftString;
    Size     := 50;
    Required := False;
  End;

  With cdsRelatorio.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'EMAIL_';
    DataType := ftString;
    Size     := 255;
    Required := False;
  End;

  With cdsRelatorio.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'PRCCID';
    DataType := ftString;
    Size     := 100;
    Required := False;
  End;

  With cdsRelatorio.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'PRCEST';
    DataType := ftString;
    Size     := 2;
    Required := False;
  End;

  With cdsRelatorio.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'EMP_NOMEMP';
    DataType := ftString;
    Size     := 50;
    Required := False;
  End;

  With cdsRelatorio.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'EMP_ENDERE';
    DataType := ftString;
    Size     := 50;
    Required := False;
  End;

  With cdsRelatorio.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'EMP_ENDNUM';
    DataType := ftString;
    Size     := 10;
    Required := False;
  End;

  With cdsRelatorio.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'EMP_C_E_P_';
    DataType := ftString;
    Size     := 30;
    Required := False;
  End;

  With cdsRelatorio.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'EMP_BAIRRO';
    DataType := ftString;
    Size     := 30;
    Required := False;
  End;

  With cdsRelatorio.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CID_NOMCID';
    DataType := ftString;
    Size     := 30;
    Required := False;
  End;

  With cdsRelatorio.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CID_ESTADO';
    DataType := ftString;
    Size     := 2;
    Required := False;
  End;

  With cdsRelatorio.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'EMP_C_G_C_';
    DataType := ftString;
    Size     := 50;
    Required := False;
  End;

  With cdsRelatorio.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'EMP_I_E_S_';
    DataType := ftString;
    Size     := 50;
    Required := False;
  End;

  With cdsRelatorio.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'EMP_FONE01';
    DataType := ftString;
    Size     := 20;
    Required := False;
  End;

  With cdsRelatorio.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'EMP_EMAIL_';
    DataType := ftString;
    Size     := 100;
    Required := False;
  End;

  cdsRelatorio.CreateDataSet;
  cdsRelatorio.Open;
End;

destructor TDigBoleto.Free;
begin
  ClearObjetos;
end;

destructor TDigBoleto.Destroy;
begin
  inherited;
  ClearObjetos;
end;

function TDigBoleto.fCarregaDupAgrupadas(strNumDup, strEspecie, strCodEmp: String; strCodCli: String): Boolean;
Begin
  Result := fCarregaDupAgrupadasNaoImpressas(strNumDup, strEspecie, strCodEmp, 0, strCodCli);
End;

function TDigBoleto.fCarregaDupAgrupadasNaoImpressas(strNumDup, strEspecie, strCodEmp: String; intJaImpressas: Integer; strCodCli: String = ''): Boolean;
  Var
    strSQL : string;
    intCont: Integer;
begin
  Result := False;

  qryDupAgrupadas.Close;

  If strEspecie <> 'AG' Then
    Exit;

  If Not fCfgSis('MDDPAG', varBoolean, recCamposDigBoleto.strEmpresaImpressao) Then
    Exit;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CTR_NUMDUP, ';
  strSQL := strSQL + '  CTR_PARCEL, ';
  strSQL := strSQL + '  CTR_ESPDOC, ';
  strSQL := strSQL + '  CTR_CODEMP, ';
  strSQL := strSQL + '  CTR_DTACAD, ';
  strSQL := strSQL + '  CTR_DTAVEN, ';
  strSQL := strSQL + '  CTR_VALORI, ';
  strSQL := strSQL + '  CTR_VALDUP, ';
  strSQL := strSQL + '  CTR_VALDUP + CTR_VALJUR AS CTR_VALCOR ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  DUPAGR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CTR_NUMAGR = :NUMAGR AND ';
  strSQL := strSQL + '  CTR_EMPAGR = :EMPAGR     ';
  If (Not fEmptyStr(strCodCli)) Then
    strSQL := strSQL + '  AND CTR_CODCLI = :CODCLI ';
  strSQL := strSQL + 'ORDER BY  ';
  strSQL := strSQL + '  CTR_DTACAD, ';
  strSQL := strSQL + '  CTR_ESPDOC, ';
  strSQL := strSQL + '  CTR_NUMDUP  ';

  With qryDupAgrupadas, qryQuery, SQL Do
  Begin
    Close;
    Clear;
    Add(strSql);
    ParamByName('NUMAGR').AsString := strNumDup;
    ParamByName('EMPAGR').AsString := strCodEmp;
    If (Not fEmptyStr(strCodCli)) Then
      ParamByName('CODCLI').AsString := strCodCli;
    Open;
  End;

  With qryDupAgrupadas Do
  Begin
    pSetProvider;

    Open;

    For intCont := 1 To intJaImpressas Do
      qryDupAgrupadas.Delete;

    Result := Not IsEmpty;
  End;

end;

function TDigBoleto.fGetMensagensMOVGER(ANumDoc, AEspDoc, ACodCli, ACodEmp,
  AParcel: String): String;
var
  LMensagens: TUniQuery;
  LSQL : String;
  LMsgRetorno : String;
begin
  Try
    LMsgRetorno := '';
    Result := LMsgRetorno;
    LSQL := '';
    LSQL := LSQL + ' SELECT                                 ';
    LSQL := LSQL + '   MG.GER_MEN001, MG.GER_MEN002         ';
    LSQL := LSQL + ' FROM                                   ';
    LSQL := LSQL + '   CADREC AS CR                         ';
    LSQL := LSQL + '   JOIN MOVGER AS MG                    ';
    LSQL := LSQL + '     ON CR.CTR_NUMDUP = MG.GER_NUMDOC   ';
    LSQL := LSQL + '     AND CR.CTR_ESPDOC = MG.GER_ESPDOC  ';
    LSQL := LSQL + '     AND CR.CTR_CODEMP = MG.GER_CODEMP  ';
    LSQL := LSQL + ' WHERE CR.CTR_CODCLI = :CODCLI          ';
    LSQL := LSQL + '   AND CR.CTR_ESPDOC = :ESPDOC          ';
    LSQL := LSQL + '   AND CR.CTR_NUMDUP = :NUMDOC          ';
    LSQL := LSQL + '   AND CR.CTR_PARCEL = :PARCEL          ';

    try
      LMensagens := fCriaQuery(Nil);
      With LMensagens Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(LSQL);
        ParamByName('CODCLI').AsString := ACodCli;
        ParamByName('ESPDOC').AsString := AEspDoc;
        ParamByName('NUMDOC').AsString := ANumDoc;
        ParamByName('PARCEL').AsString := AParcel;
        Open;
      End;

      if LMensagens.FieldByName('GER_MEN001').AsString <> '' then
        LMsgRetorno := LMensagens.FieldByName('GER_MEN001').AsString;

      if LMensagens.FieldByName('GER_MEN002').AsString <> '' then
      begin
        if LMsgRetorno <> '' then
          LMsgRetorno := LMsgRetorno + ' | ';
        LMsgRetorno := LMsgRetorno + LMensagens.FieldByName('GER_MEN002').AsString;
      end;

    finally
      Result :=  LMsgRetorno;
      FreeAndNil(LMensagens);
    end;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TDigBoleto.fGetMensagensMOVGER]');
    End;
  End;
end;

function TDigBoleto.fGravaBancoBoleto(strNumDup, strParcel, strCodCli,
  strCodEmp, strEspDoc: String): Boolean;
  Var
    qryUpdate: TUniQuery;
    strSQL: String;
begin
  Result := True;

  Try

    qryUpdate := fCriaQuery;

    strSQL := fMontaUpdate(strNumDup,strParcel,strCodCli,strCodEmp,strEspDoc);

    With qryUpdate Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSql;
    End;

    FreeAndNil(qryUpdate);

  Except
    On E: Exception Do
    Begin
			pMensagensErro(E.Message,'[TDigBoleto.fGravaBancoBoleto]');
      FreeAndNil(qryUpdate);
      Result := False;
    End;
  End;
end;

function TDigBoleto.fMontaUpdate(strNumDup,
                                 strParcel,
                                 strCodCli,
                                 strCodEmp,
                                 strEspDoc:String):String;
var
  strPorMer: String;
Begin
  strPorMer := fCfgSis('PORMER', varString, recCamposDigBoleto.strEmpresaImpressao);

  Result := '';
  Result := Result + ' UPDATE ';
  Result := Result + ' CADREC ';
  Result := Result + '    SET ';
  Result := Result + '        CTR_BCOBOL = "999", ';
  Result := Result + '        CTR_DTABOL = ' + fCurrentDate;

  If Not fEmptyStr(strPorMer) Then
    Result := Result + ' , CTR_CODPOR = ' + QuotedStr(strPorMer);

  Result := Result + '  WHERE CTR_NUMDUP = ' + QuotedStr(strNumDup);
  Result := Result + '    AND CTR_PARCEL = ' + QuotedStr(strParcel);
  Result := Result + '    AND CTR_CODCLI = ' + QuotedStr(strCodCli);
  Result := Result + '    AND CTR_CODEMP = ' + QuotedStr(strCodEmp);
  Result := Result + '    AND CTR_ESPDOC = ' + QuotedStr(strEspDoc);
End;

Function TDigBoleto.fSqlCadCli(strEmpresaImpressao: String): String;
Begin
  Result := '';
  Result := Result + 'SELECT SQL_NO_CACHE ';

  Result := Result + '  CLI_FONE01 AS FONE01, ';
  Result := Result + '  CLI_CODCLI AS CODCLI, ';
  Result := Result + '  CLI_NOMCLI AS NOMCLI, ';
  Result := Result + '  CLI_C_G_C_ AS CLICGC, ';
  Result := Result + '  CLI_EMAIL_ AS EMAIL_, ';

  If fCfgSis('ENDDUP', varBoolean, strEmpresaImpressao) Then
  Begin
    Result := Result + '  CONCAT(CLI_ENDERE, IF(CLI_ENDNUM = "" OR CLI_ENDNUM IS NULL,"",CONCAT("-",CLI_ENDNUM) ), IFNULL(CLI_ENDCOM,"")) AS ENDERE, ';
    Result := Result + '  CLI_BAIRRO AS BAIRRO, ';
    Result := Result + '  IF (LENGTH(CLI_C_E_P_) = 8, CONCAT(SUBSTRING(CLI_C_E_P_,1,5),"-", ';
    Result := Result + '                                     SUBSTRING(CLI_C_E_P_,6,3)), CLI_C_E_P_) AS C_E_P_, ';
    Result := Result + '  C2.CID_NOMCID AS CIDADE, ';
    Result := Result + '  C2.CID_ESTADO AS ESTADO, ';
  End
  Else
  Begin
    Result := Result + '  IF((CLI_ENDCOB = "" OR CLI_ENDCOB IS NULL), CONCAT(CLI_ENDERE, IF(CLI_ENDNUM = "" OR CLI_ENDNUM IS NULL,"",CONCAT("-",CLI_ENDNUM) ), IFNULL(CLI_ENDCOM,"")), CLI_ENDCOB) AS ENDERE, ';
    Result := Result + '  IF((CLI_BAICOB = "" OR CLI_BAICOB IS NULL), CLI_BAIRRO, CLI_BAICOB) AS BAIRRO, ';
    Result := Result + '  IF((CLI_CEPCOB = "" OR CLI_CEPCOB IS NULL), IF (LENGTH(CLI_C_E_P_) = 8, CONCAT(SUBSTRING(CLI_C_E_P_,1,5),"-", ';
    Result := Result + '                                                                          SUBSTRING(CLI_C_E_P_,6,3)), CLI_C_E_P_), ';
    Result := Result + '                                              IF (LENGTH(CLI_C_E_P_) = 8, CONCAT(SUBSTRING(CLI_CEPCOB,1,5),"-", ';
    Result := Result + '                                                                          SUBSTRING(CLI_CEPCOB,6,3)), CLI_CEPCOB)) AS C_E_P_, ';
    Result := Result + '  IF((C1.CID_NOMCID = "" OR C1.CID_NOMCID IS NULL), C2.CID_NOMCID, C1.CID_NOMCID) AS CIDADE, ';
    Result := Result + '  IF((C1.CID_ESTADO = "" OR C1.CID_ESTADO IS NULL), C2.CID_ESTADO, C1.CID_ESTADO) AS ESTADO, ';
  End;
  Result := Result + '  IF((C1.CID_NOMCID = "" OR C1.CID_NOMCID IS NULL), C2.CID_NOMCID, C1.CID_NOMCID) AS PRCCID, ';
  Result := Result + '  IF((C1.CID_ESTADO = "" OR C1.CID_ESTADO IS NULL), C2.CID_ESTADO, C1.CID_ESTADO) AS PRCEST, ';

  Result := Result + '  IF (LENGTH(CLI_C_G_C_) <= 11, CONCAT("", SUBSTRING(CLI_C_G_C_,1,3),".", ';
  Result := Result + '                                           SUBSTRING(CLI_C_G_C_,4,3),".", ';
  Result := Result + '                                           SUBSTRING(CLI_C_G_C_,7,3),"-", ';
  Result := Result + '                                           SUBSTRING(CLI_C_G_C_,10,2)),   ';
  Result := Result + '  IF (LENGTH(CLI_C_G_C_) > 11, CONCAT("", SUBSTRING(CLI_C_G_C_,1,2),".", ';
  Result := Result + '                                  				SUBSTRING(CLI_C_G_C_,3,3),".", ';
  Result := Result + '                              						SUBSTRING(CLI_C_G_C_,6,3),"/", ';
  Result := Result + '                               						SUBSTRING(CLI_C_G_C_,9,4),"-", ';
  Result := Result + '                               						SUBSTRING(CLI_C_G_C_,13,2)),CLI_C_G_C_)) AS C_G_C_, ';

  Result := Result + '  IF (LENGTH(CLI_I_E_S_) = 12, CONCAT(SUBSTRING(CLI_I_E_S_,1,3),".", ';
  Result := Result + '                                      SUBSTRING(CLI_I_E_S_,4,3),".", ';
  Result := Result + '                                      SUBSTRING(CLI_I_E_S_,7,3),".", ';
  Result := Result + '                                      SUBSTRING(CLI_I_E_S_,10,3)), CLI_I_E_S_) AS I_E_S_ ';

  Result := Result + 'FROM ';
  Result := Result + '  CADCLI ';
  Result := Result + '  LEFT  JOIN CADCID AS C1 ON CLI_CIDCOB = C1.CID_CODCID ';
  Result := Result + '  INNER JOIN CADCID AS C2 ON CLI_CODCID = C2.CID_CODCID ';
  Result := Result + 'WHERE ';
  Result := Result + '  CLI_CODCLI = :CODCLI ';
End;

function TDigBoleto.fSqlCadCliEmail: String;
begin
  Result := '';
  Result := Result + '  SELECT CADCLI.*   ';
  Result := Result + 'FROM ';
  Result := Result + '  CADCLI ';
  Result := Result + '  LEFT  JOIN CADCID AS C1 ON CLI_CIDCOB = C1.CID_CODCID ';
  Result := Result + '  INNER JOIN CADCID AS C2 ON CLI_CODCID = C2.CID_CODCID ';
  Result := Result + 'WHERE ';
  Result := Result + '  CLI_CODCLI = :CODCLI ';
end;

function TDigBoleto.fSqlEmpresa: String;
Begin
  Result := '';
  Result := Result + 'SELECT EMP_NOMEMP, ';
  Result := Result + '       IF (LENGTH(EMP_C_G_C_) <= 11, CONCAT("CPF : ", SUBSTRING(EMP_C_G_C_,1,3),".", ';
  Result := Result + '                                                      SUBSTRING(EMP_C_G_C_,4,3),".", ';
  Result := Result + '                                                      SUBSTRING(EMP_C_G_C_,7,3),"-", ';
  Result := Result + '                                                      SUBSTRING(EMP_C_G_C_,10,2)),   ';
  Result := Result + '       IF (LENGTH(EMP_C_G_C_) > 11, CONCAT("CNPJ : ", SUBSTRING(EMP_C_G_C_,1,2),".", ';
  Result := Result + '                                     						     SUBSTRING(EMP_C_G_C_,3,3),".", ';
  Result := Result + '                                     						     SUBSTRING(EMP_C_G_C_,6,3),"/", ';
  Result := Result + '                                     						     SUBSTRING(EMP_C_G_C_,9,4),"-", ';
  Result := Result + '                                      						     SUBSTRING(EMP_C_G_C_,13,2)),EMP_C_G_C_)) AS EMP_C_G_C_, ';
  Result := Result + '       EMP_ENDERE, EMP_C_E_P_, EMP_I_E_S_, EMP_BAIRRO, EMP_ENDNUM, ';
  Result := Result + '       EMP_FONE01, EMP_EMAIL_, CID_NOMCID, CID_ESTADO, ';
  Result := Result + 'CONCAT("Reconheço(emos) a exatidão desta DUPLICATA DE VENDA MERCANTIL, na importância acima, ';
  Result := Result + 'que pagarei(emos) à ", EMP_NOMEMP, " ou a sua ordem na praça e vencimentos acima indicados.") AS TEXTOR ';
  Result := Result + 'FROM CADEMP ';
  Result := Result + 'INNER JOIN CADCID ON EMP_CODCID = CID_CODCID ';
  Result := Result + 'WHERE EMP_CODEMP = :CODEMP ';
end;

function TDigBoleto.frxDuplicataMerecantilUserFunction(const MethodName: String;
  var Params: Variant): Variant;
begin
  inherited;
  If MethodName = 'FRETEXTENSONUMERO' Then
    Result := UpperCase(fRetExtensoNumero(Params[0]));

  If SameText(MethodName, 'fCarregaDupAgrupadas') Then
    Result := fCarregaDupAgrupadas(Params[0], Params[1], Params[2], Params[3]);

  If SameText(MethodName, 'fCarregaDupAgrupadasNaoImpressas') Then
    Result := fCarregaDupAgrupadasNaoImpressas(Params[0], Params[1], Params[2], Params[3], Params[4]);

  If SameText(MethodName, 'fRetNumParcela') Then
    Result := fRetNumParcela(Params[0]);

  If SameText(MethodName, 'fQtdParcelas') Then
    Result := fQtdParcelas(Params[0], Params[1], Params[2], Params[3]);

  If SameText(MethodName, 'fCarregaInfoLayoutMercantil') Then
    Result := fCarregaInfoLayoutMercantil(Params[0],Params[1],Params[2],Params[3],Params[4],Params[5],Params[6],Params[7],Params[8],Params[9]) ;

  If SameText(MethodName, 'fCarregaItensMercantilImp') Then
    Result := fCarregaItensMercantilImp(Params[0],Params[1],Params[2],Params[3]);

  If SameText(MethodName, 'fCarregaParcelasReferentesADocumento') Then
    Result := fCarregaParcelasReferentesADocumento(Params[0],Params[1],Params[2],Params[3]);

  If SameText(MethodName, 'fGetMensagensMOVGER') Then
    Result := fGetMensagensMOVGER(Params[0],Params[1],Params[2],Params[3],Params[4]);
end;

procedure TDigBoleto.frxGenGetValue(const VarName: String;
  var Value: Variant);
  Var
    qryCadEmp: TUniQuery;
begin
  inherited;
  Try
    qryCadEmp := fCriaQuery;

    With qryCadEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT ');
      SQL.Add('  EMP_NOMEMP NOMEMP, ');

      SQL.Add('  IF (LENGTH(EMP_C_G_C_) <= 11, CONCAT("CPF : ",SUBSTRING(EMP_C_G_C_,1,3),".", ');
      SQL.Add('                                                SUBSTRING(EMP_C_G_C_,4,3),".", ');
      SQL.Add('                                                SUBSTRING(EMP_C_G_C_,7,3),"-", ');
      SQL.Add('                                                SUBSTRING(EMP_C_G_C_,10,2)),   ');
      SQL.Add('  IF (LENGTH(EMP_C_G_C_) > 11, CONCAT("CNPJ : ",SUBSTRING(EMP_C_G_C_,1,2),".", ');
      SQL.Add('                               						     SUBSTRING(EMP_C_G_C_,3,3),".", ');
      SQL.Add('                                						     SUBSTRING(EMP_C_G_C_,6,3),"/", ');
      SQL.Add('                               						     SUBSTRING(EMP_C_G_C_,9,4),"-", ');
      SQL.Add('                               						     SUBSTRING(EMP_C_G_C_,13,2)),EMP_C_G_C_)) C_G_C_, ');

      SQL.Add('  EMP_ENDERE ENDERE, ');
      SQL.Add('  EMP_C_E_P_ C_E_P_, ');
      SQL.Add('  EMP_I_E_S_ I_E_S_,  ');
      SQL.Add('  EMP_BAIRRO BAIRRO,  ');
      SQL.Add('  EMP_ENDNUM ENDNUM,  ');
      SQL.Add('  EMP_ENDCMP ENDCMP,  ');
      SQL.Add('  EMP_FONE01 FONE01,  ');
      SQL.Add('  EMP_EMAIL_ EMAIL_,  ');
      SQL.Add('  CID_NOMCID CIDADE,  ');
      SQL.Add('  CID_ESTADO ESTADO  ');
      SQL.Add('FROM ');
      SQL.Add('  CADEMP ');
      SQL.Add('  INNER JOIN CADCID ON EMP_CODCID = CID_CODCID ');
      SQL.Add('WHERE ');
      SQL.Add('  EMP_CODEMP = :CODEMP ');
      ParamByName('CODEMP').AsString := strCtrEmp;
      Open;

      If VarName = 'EMP_NOMEMP' Then
        Value := FieldByName('NOMEMP').AsString

      Else If VarName = 'EMP_C_G_C_' Then
        Value := FieldByName('C_G_C_').AsString

      Else If VarName = 'EMP_ENDERE' Then
        Value := FieldByName('ENDERE').AsString

      Else If VarName = 'EMP_C_E_P_' Then
        Value := FieldByName('C_E_P_').AsString

      Else If VarName = 'EMP_I_E_S_' Then
        Value := FieldByName('I_E_S_').AsString

      Else If VarName = 'CID_NOMCID' Then
        Value := FieldByName('CIDADE').AsString

      Else If VarName = 'CID_ESTADO' Then
        Value := FieldByName('ESTADO').AsString

      Else If VarName = 'EMP_BAIRRO' Then
        Value := FieldByName('BAIRRO').AsString

      Else If VarName = 'EMP_ENDNUM' Then
        Value := FieldByName('ENDNUM').AsString

      Else If VarName = 'EMP_ENDCMP' Then
        Value := FieldByName('ENDCMP').AsString

      Else If VarName = 'EMP_FONE01' Then
        Value := FieldByName('FONE01').AsString

      Else If VarName = 'EMP_EMAIL_' Then
        Value := FieldByName('EMAIL_').AsString

      Else If VarName = 'REL_NOMREL' Then
        Value := recCamposDigBoleto.strFormulario;

      Close;
    End;

  Finally
    FreeAndNil(qryCadEmp);
  End;
end;

function TDigBoleto.fCarregaInfoLayoutMercantil(strNumDup,
                                                strCodEmp,
                                                strEspdoc,
                                                strCodCli,
                                                strPrccid,
                                                strPrcest,
                                                strNomCid,
                                                strEstado,
                                                strParcel: String;
                                                intPerDpo: Double = 0 ): Boolean ;
begin
  If Assigned(frxDuplicataMercantil.FindObject('lblPontualidade')) Then
  Begin
    TfrxMemoView(frxDuplicataMercantil.FindObject('lblPontualidade')).Memo.Text := '';
    If (fCfgSis('DESPON') = 'S') And (intPerDpo > 0) Then
      TfrxMemoView(frxDuplicataMercantil.FindObject('lblPontualidade')).Memo.Text := 'Desconto na pontualidade de ' + FormatFloat('#,##0.00', intPerDpo) + '%';
  End;

  If Assigned(frxDuplicataMercantil.FindObject('memParcela')) Then
  Begin
   TfrxMemoView(frxDuplicataMercantil.FindObject('memParcela')).Memo.Text := 'Parcela ' + fRetNumParcela(strParcel) + ' de ' +
                                                                                          IntToStr(fQtdParcelas(Copy(strNumDup, 1, Length(strNumDup) - 1),
                                                                                                                strCodEmp,
                                                                                                                strEspdoc,
                                                                                                                strCodCli)) + ': ';
  End;

  If Assigned(frxDuplicataMercantil.FindObject('Memo40')) Then
  Begin
    If (fCfgSis('PRAPAG') = '1') Then
      TfrxMemoView(frxDuplicataMercantil.FindObject('Memo40')).Memo.Text := strPrccid + ' - ' + strPrcest
    Else
      TfrxMemoView(frxDuplicataMercantil.FindObject('Memo40')).Memo.Text := strNomCid + ' - ' + strEstado ;
  end;
  Result:= True;
end;

procedure TDigBoleto.PreparadaImpressaoMercantilItens;
begin
  Try
    frxItensMercantil.DataSet := LItensMercantil;
    frxEmpresaMercantil.DataSet := LEmpresaMercantil;
    CarregaItensMercantil(recCamposDigBoleto.cdsBoletos.Fields.FieldByName('NRODUP').AsString,
                          recCamposDigBoleto.cdsBoletos.Fields.FieldByName('CTR_ESPDOC').AsString,
                          recCamposDigBoleto.cdsBoletos.Fields.FieldByName('CTR_CODCLI').AsString,
                          recCamposDigBoleto.cdsBoletos.Fields.FieldByName('CTR_CODEMP').AsString);
    fCadEmp('NOMEMP', LEmpresaMercantil);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TDigBoleto.PreparadaImpressaoMercantilItens]');
    End;
  End;
end;

function TDigBoleto.fPegaNossoNumero(qryConBco: TDataSet; strCodBco, strRetBco, strEmpresaImpressao: String; intRetCar: Integer): string;
  var
    strNum: String;
begin
  If strCodBco = '001' Then
  Begin
    strNum := fCfgSis('NOSNUM', varString, strEmpresaImpressao);

    If (fEmptyStr(strNum)) Or (strNum = '1') Then
      Result := fStrZero(qryConBco.FieldByName('BCO_PRONUM').AsString,11)
    Else
      Result := fStrZero(qryConBco.FieldByName('BCO_PRONU7').AsString,11);
  End
  Else If MatchStr(strCodBco, ['104', '041', '756']) Then
  Begin

    If fEmptyStr(fGetBancoConfig(0, 'CONFIG' + strRetBco + '-' + IntToStr(intRetCar), 'NUMNOSS', '')) Or
       (fGetBancoConfig(0, 'CONFIG' + strRetBco + '-' + IntToStr(intRetCar), 'NUMNOSS', '') = '1') Then
      Result := fStrZero(qryConBco.FieldByName('BCO_PRONUM').AsString,11)
    Else
      Result := fStrZero(qryConBco.FieldByName('BCO_PRONU7').AsString,11);

  End

  Else If MatchStr(strCodBco, ['707', '964', '988']) Then
    Result := fStrZero(qryConBco.FieldByName('BCO_PRONUM').AsString,8)

  Else If (strCodBco = '637') Then
  Begin
    If strRetBco = '637LP444p' Then
       Result := fStrZero(RightStr(qryConBco.FieldByName('BCO_PRONUM').AsString,10),10)
    Else
       Result := fStrZero(qryConBco.FieldByName('BCO_PRONUM').AsString,12)
  End

  Else If (strCodBco = '274') And (strRetBco = '274LP400p') Then
  Begin
       Result := fStrZero(qryConBco.FieldByName('BCO_PRONUM').AsString,12)
  End

  Else If (strCodBco = '246') Then
  Begin

    If fEmptyStr(fGetBancoConfig(0, 'CONFIG' + strRetBco + '-' + IntToStr(intRetCar), 'NUMNOSS', '')) Or
       (fGetBancoConfig(0, 'CONFIG' + strRetBco + '-' + IntToStr(intRetCar), 'NUMNOSS', '') = '1') Then
      Result := fStrZero(qryConBco.FieldByName('BCO_PRONUM').AsString,10)
    Else
      Result := fStrZero(qryConBco.FieldByName('BCO_PRONU7').AsString,10);

  End

  Else If (strCodBco = '756') Then
  Begin

    If fEmptyStr(fGetBancoConfig(0, 'CONFIG' + strRetBco + '-' + IntToStr(intRetCar), 'NUMNOSS', '')) Or
       (fGetBancoConfig(0, 'CONFIG' + strRetBco + '-' + IntToStr(intRetCar), 'NUMNOSS', '') = '1') Then
      Result := fStrZero(qryConBco.FieldByName('BCO_PRONUM').AsString,7)
    Else
      Result := fStrZero(qryConBco.FieldByName('BCO_PRONU7').AsString,7);

  End

  Else If (strCodBco = '906') Then
  Begin

    If fEmptyStr(fGetBancoConfig(0, 'CONFIG' + strRetBco + '-' + IntToStr(intRetCar), 'NUMNOSS', '')) Or
       (fGetBancoConfig(0, 'CONFIG' + strRetBco + '-' + IntToStr(intRetCar), 'NUMNOSS', '') = '1') Then
      Result := fStrZero(qryConBco.FieldByName('BCO_PRONUM').AsString,11)
    Else
      Result := fStrZero(qryConBco.FieldByName('BCO_PRONU7').AsString,11);

  End

  Else If (strCodBco = '208') Then
    Result := fStrZero(qryConBco.FieldByName('BCO_PRONUM').AsString,11)

  Else If (strCodBco = '364') Then  //MF: 284963 - 24/07/23 - GERENCIANET
    Result := fStrZero(qryConBco.FieldByName('BCO_PRONUM').AsString,10)

  Else
    Result := fStrZero(qryConBco.FieldByName('BCO_PRONUM').AsString,11);
end;

Function TDigBoleto.fCarregaItensMercantilImp(ANumDoc,AEspDoc,ACodCli,ACodEmp:String) : Boolean;
  Var
    SqlItens: String;
begin
  SqlItens := '';

  SqlItens := ' SELECT                                                                       '+
              '    1 AS QUANTIDADE_VIAS,                                                     '+
              '    CTR_DTACAD AS DATA_CADASTRO,                                              '+
              '    CTR_DTAVEN AS DATA_VENCIMENTO,                                            '+
              '    COUNT(DET_CODITE) AS QTDITENSPEDIDO,                                      '+
              '    UPPER(CONCAT(IFNULL(CLI_ENDERE,""), ", ", IFNULL(CLI_ENDNUM,""), ", ",    '+
              '           IFNULL(CLI_BAIRRO,""), " - " , IFNULL(CID_NOMCID,""), "/",         '+
              '           IFNULL(CID_ESTADO,""))) AS ENDERECO_CLIENTE,                       '+
              '    CLI_CODCLI AS CODCLIENTE,                                                 '+
              '    CLI_NOMCLI AS NOMECLIENTE,                                                '+
              '    IFNULL(FPG_DESCRI,"OUTRAS") AS FORMAPAGAMENTO,                            '+
              '    IFNULL(DET_SERIE_,CTR_PARCEL) AS SERIE,                                   '+
              '    IFNULL(IFNULL(DET_NUM_PD,DET_NUMDOC),CTR_NUMDUP) AS NUMPEDIDO,            '+
              '    IFNULL(DET_CODVEN,CTR_CODVEN) AS CODVENDEDOR,                             '+
              '    OPE_NOMOPE AS NOMVENDEDOR,                                                '+
              '    IFNULL(DET_NUMDOC,CTR_NUMDUP) AS NUMDOCUMENTO,                            '+
              '    DET_CODITE AS CODITEM,                                                    '+
              '    DET_DESCRI AS DESCRICAOITEM,                                              '+
              '    UNI_DESUNI AS UNIDADE,                                                    '+
              '    IF(LEFT(DET_CLAFIS,1) < 5, -DET_QTDITE,DET_QTDITE) AS QTDEITEM,           '+
              '    IF(LEFT(DET_CLAFIS,1) < 5, -DET_UNITAR,DET_UNITAR) AS UNITARIOITEM,       '+
              '    IF(LEFT(DET_CLAFIS,1) < 5, -DET_UNIORI,DET_UNIORI) AS UNIORIITEM,         '+
              '    IFNULL(IF(LEFT(DET_CLAFIS,1) < 5, -DET_TOTITE,DET_TOTITE),                '+
              '    SUM(CTR_VALDUP - CTR_DESSUJ + CTR_JURSUJ + CTR_DESCOB)) AS TOTALITEM,     '+
              '    IF(LEFT(DET_CLAFIS,1) < 5, -DET_DESESP,DET_DESESP) AS TOTALDESESP,        '+
              '    IF(LEFT(DET_CLAFIS,1) < 5, -DET_DESCON,DET_DESCON) AS DESCONTOITEM,       '+
              '    IF(LEFT(DET_CLAFIS,1) < 5, -DET_TOTFRE,DET_TOTFRE) AS TOTALFRETE,         '+
              '    IFNULL(IF(IF(LEFT(DET_CLAFIS,1) < 5, -DET_TOTITE,DET_TOTITE) >            '+
              '      (IF(LEFT(DET_CLAFIS,1) < 5, -DET_QTDITE,DET_QTDITE) *                   '+
              '       IF(LEFT(DET_CLAFIS,1) < 5, -DET_UNIORI,DET_UNIORI)),                   '+
              '       IF(LEFT(DET_CLAFIS,1) < 5, -DET_TOTITE,DET_TOTITE),                    '+
              '      (IF(LEFT(DET_CLAFIS,1) < 5, -DET_QTDITE,DET_QTDITE) *                   '+
              '       IF(LEFT(DET_CLAFIS,1) < 5, -DET_UNIORI,DET_UNIORI))                    '+
              '    ),SUM(CTR_VALDUP)) AS TOTALBRUTO,                                         '+
              '    IFNULL(IF(((IF(LEFT(DET_CLAFIS,1) < 5, -DET_QTDITE,DET_QTDITE) *          '+
              '         IF(LEFT(DET_CLAFIS,1) < 5, -DET_UNIORI,DET_UNIORI)) -                '+
              '         IF(LEFT(DET_CLAFIS,1) < 5, -DET_TOTITE,DET_TOTITE) )                 '+
              '    < 0,0.0,                                                                  '+
              '   ((IF(LEFT(DET_CLAFIS,1) < 5, -DET_QTDITE,DET_QTDITE) *                     '+
              '     IF(LEFT(DET_CLAFIS,1) < 5, -DET_UNIORI,DET_UNIORI)) -                    '+
              '     IF(LEFT(DET_CLAFIS,1) < 5, -DET_TOTITE,DET_TOTITE) )                     '+
              '   ),IF((CTR_VALDUP - CTR_DESSUJ + CTR_JURSUJ + CTR_DESCOB < CTR_VALDUP),     '+
              '     SUM(CTR_DESSUJ),0.0)) AS TOTALDESCONTO                                   '+
              ' FROM                                                                         '+
              '   CADREC                                                                     '+
              ' LEFT JOIN MOVDET                                                             '+
              '   ON CTR_NUMDUP = DET_NUMDOC                                                 '+
              '   AND CTR_ESPDOC = DET_ESPDOC                                                '+
              '   AND CTR_CODCLI = DET_CODCLI                                                '+
              '   AND CTR_CODEMP = DET_CODEMP                                                '+
              'LEFT JOIN CADFPG ON FPG_CODIGO = DET_CODFPG                                   '+
              'LEFT JOIN CADUNI ON UNI_CODUNI = DET_UNIDAD                                   '+
              'LEFT JOIN CADOPE ON OPE_CODOPE = IFNULL(DET_CODVEN,CTR_CODVEN)                '+
              'LEFT JOIN CADCLI ON CLI_CODCLI = IFNULL(DET_CODCLI,CTR_CODCLI)                '+
              'LEFT JOIN CADCID ON CID_CODCID = CLI_CODCID                                   '+
              'WHERE  CTR_NUMDUP = :NUMDUP                                                   '+
              '   AND CTR_ESPDOC = :ESPDOC                                                   '+
              '   AND CTR_CODCLI = :CODCLI                                                   '+
              '   AND CTR_CODEMP = :CODEMP                                                   '+
              ' GROUP BY MOVDET.AUTOINCREM                                                   ';
  Try
    LItensMercantil.Close;
    LItensMercantil.Sql.Clear;
    LItensMercantil.Sql.Add(SqlItens);
    LItensMercantil.ParamByName('NUMDUP').AsString := ANumDoc;
    LItensMercantil.ParamByName('ESPDOC').AsString := AEspDoc;
    LItensMercantil.ParamByName('CODCLI').AsString := ACodCli;
    LItensMercantil.ParamByName('CODEMP').AsString := ACodEmp;
    LItensMercantil.Open;

    result := Not LItensMercantil.IsEmpty;
  Except
    On E: Exception Do
    Begin
      result := False;
      pMensagensErro(E.Message, '[TDigBoleto.fCarregaItensMercantilImp]');
    End;
  End;
end;

Function TDigBoleto.fCarregaParcelasReferentesADocumento(ANumDoc,AEspDoc,ACodCli,ACodEmp:String) : Boolean;
  Var
    SqlDups: String;
begin
  SqlDups := '';

  SqlDups := ' SELECT '+
             '   CONCAT(CTR_NUMDUP, CTR_PARCEL) AS CTR_NUMDUP, '+
             '   CTR_DTAVEN, '+
             '   CTR_VALDUP  '+
             ' FROM  '+
             '   CADREC      '+
             ' WHERE CTR_NUMDUP = :NUMDUP '+
             '   AND CTR_ESPDOC = :ESPDOC '+
             '   AND CTR_CODCLI = :CODCLI '+
             '   AND CTR_CODEMP = :CODEMP ';
  Try
    LParcelasDocto.Close;
    LParcelasDocto.Sql.Clear;
    LParcelasDocto.Sql.Add(SqlDups);
    LParcelasDocto.ParamByName('NUMDUP').AsString := ANumDoc;
    LParcelasDocto.ParamByName('ESPDOC').AsString := AEspDoc;
    LParcelasDocto.ParamByName('CODCLI').AsString := ACodCli;
    LParcelasDocto.ParamByName('CODEMP').AsString := ACodEmp;
    LParcelasDocto.Open;

    result := Not LParcelasDocto.IsEmpty;
  Except
    On E: Exception Do
    Begin
      result := False;
      pMensagensErro(E.Message, '[TDigBoleto.fCarregaParcelasReferentesADocumento]');
    End;
  End;

End;

Function TDigBoleto.fVerificaSeTemItemPedido() : Boolean;
Begin
  Result := True;

  If Not LItensMercantil.IsEmpty Then
  Begin
     If (LItensMercantil.Recordcount = 1) And (fEmptyStr(LItensMercantil.FieldByName('CODITEM').AsString)) Then
        Result := False
  End
  Else
     Result := False;

End;

end.
