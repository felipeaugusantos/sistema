unit untCalculoPisCofins;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core, untFuncoesGenerica,
{$ELSE}
  Controls, untFuncoesSimples,
{$ENDIF}
  Uni,
  Classes,
  untTypesSistema,
  Faturamento.Connections.Functions,
  Shared.Functions.DataSet;

Type
  TResultPisCofins = Record
    strCstPis   : String;
    dblBasePis  : Double;
    dblValorPis : Double;
    dblAlqPis   : Double;
    strNatRecPis: String;

    strCstCof   : String;
    dblBaseCof  : Double;
    dblValorCof : Double;
    dblAlqCof   : Double;
    strNatRecCof: String;

    stlLogDocs  : TStringList;

    blnResult: Boolean;
    blnCarregadoPelaCFG_SUFIPC: Boolean;
  End;

Type
  TCalculoPisCofins = class(TObject)
  private
    FBeneficioREIDI : String;
    FCodEmbarcacao  : String;
    stlLogDocs: TStringList;
    dicCacheCfg: TDicionario;

    function fUmCentavo(fltVal: Double; fltBase: Double): Double;
    function fSimples(strFornecedor: String): Boolean;
    function fZonaFranca(strCliente: String): Boolean;
    function fClienteBeneficioReidi(strCliente: String): Boolean;
    function fCfgSisInterna(strCamCfg: String; varTipVar: TVarType = varString; strCodEmp: String = '') : Variant;
    function fNcmTemBeneficioRecap(strCodCli, strClaIpi: String): Boolean;
    function fEhEntradaTranferencia(strClaFis: String): Boolean;
    function fDrawbackEmbarcacao: Boolean;
  public

    strMsgErro: String;
    blnGerarException: Boolean;

    Function fCalculoPisCofins( strEmp, strCodIte, strClaFis, strCodSit, strCodFor, strSimPau, strOpcDoc: String;
                                dblTotIte, dblDesconto, dblIpi, dblValRet, dblValFrete, dblDespAce, dbValIcm, dbValFcp: Double;
                                strTipfc, strIncPis,
                                strSitP_C, strMenP_C : String;
                                dtaDtaEnt: TDate;
                                strCodEmpTransf: String = '';
                                blnEhOperacaoDeTransferencia: Boolean = False;
                                blnBFut49 : Boolean = False;
                                strEntRet : string = '';
                                strEntFut : string = '';
                                strMotFut : string = '';
                                strClaIpi : string = '';
                                blnRetornaAliquota: Boolean = False;
                                CST_XML: string = '';
                                VALICMS_XML: Double = -1;
                                XMLCstPis: String = '';
                                XmlCstCofins: string = '';
                                XmlAliqPis: Double = 0;
                                XmlAliqCofins: Double = 0;
                                fltDifal : Double = 0): TResultPisCofins;

    Procedure pCalculaAlqPisCof(strClafis, strCodSit, strIncPis, strSitP_C, strMenP_C: String;
                                Var fltAlqPis, fltAlqCof: Double);

    Procedure pAddLog(strLog: String);
    constructor Create();
    destructor Destroy; override;
    property strBeneficioREIDI: String read FBeneficioREIDI write FBeneficioREIDI;
    property strCodEmbarcacao: String read FCodEmbarcacao write FCodEmbarcacao;
end;

implementation

uses SysUtils, StrUtils, Variants, Math, untConstantes, Data.DB,
  untConfiguracoesSUFIPC;

constructor TCalculoPisCofins.Create();
begin
  inherited Create();

  blnGerarException := False;
  strMsgErro := '';
  FBeneficioREIDI := '';
  FCodEmbarcacao := '';

  stlLogDocs := TStringList.Create;
  dicCacheCfg := TDicionario.Create;
end;

destructor TCalculoPisCofins.Destroy;
begin
  FreeAndNil(stlLogDocs);
  FreeAndNil(dicCacheCfg);
  
  inherited Destroy;
end;

Procedure TCalculoPisCofins.pCalculaAlqPisCof(strClafis, strCodSit, strIncPis, strSitP_C, strMenP_C: String; Var fltAlqPis, fltAlqCof: Double);
  Var
    strCstPis: String;
Begin
  fltAlqPis := 0;
  fltAlqCof := 0;

  If Not fCfgSisInterna('UTIABR',varBoolean) Then
  Begin
    strCstPis   := fRetCstPisCofins(strClafis, strCodSit, strIncPis, strSitP_C, strMenP_C);

    If (strCstPis = '01') or (strCstPis = '50') Then
    Begin
      fltAlqPis   := fCfgSisInterna('ALPISP', varDouble);
      fltAlqCof   := fCfgSisInterna('ALCOFP', varDouble);
    End
  End;

End;

function TCalculoPisCofins.fClienteBeneficioReidi(strCliente: String): Boolean;
begin
  If (Not fEmptyStr(FBeneficioREIDI)) Then
    Exit(FBeneficioREIDI = 'S');

  Result := False;

  If fEmptyStr(strCliente) Then
    Exit;

  Result := fCampoTabela('CLI_BENREI', 'CADCLI', ['CLI_CODCLI'], [strCliente], False) = 'S';
end;

function TCalculoPisCofins.fDrawbackEmbarcacao: Boolean;
begin
  Result := (Not fEmptyStr(FCodEmbarcacao)) And
            (fCfgSisInterna('CADEMB', varString) = 'S') And
            (fCampoTabela('EMB_DRABCK', 'CADEMB', ['AUTOINCREM'], [FCodEmbarcacao]) = 'S');
end;

function TCalculoPisCofins.fEhEntradaTranferencia(strClaFis: String): Boolean;
var qryConsulta: TUniQuery;
begin
  Result := false;
  If fEmptyStr(strClaFis) Then
    Exit;
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.Sql.Add('SELECT LOCATE("'+copy(strClaFis, 2 , 3)+'", CONCAT(RIGHT(IFNULL(EMP_CLATE1, ""), 3),"_",');
    qryConsulta.Sql.Add('                            RIGHT(IFNULL(EMP_CLATE2, ""), 3),"_",');
    qryConsulta.Sql.Add('                            RIGHT(IFNULL(EMP_CLATE3, ""), 3),"_",');
    qryConsulta.Sql.Add('                            RIGHT(IFNULL(EMP_CETDFT, ""), 3),"_",');
    qryConsulta.Sql.Add('                            RIGHT(IFNULL(EMP_CETDFC, ""), 3),"_",');
    qryConsulta.Sql.Add('                            RIGHT(IFNULL(EMP_CETDFS, ""), 3))) AS  TRANSF');
    qryConsulta.Sql.Add('  FROM CADEMP');
    qryConsulta.Sql.Add(' WHERE EMP_CODEMP = "' + VS_StrCodEmp + '"');
    qryConsulta.Open;

    If qryConsulta.IsEmpty then
      Exit;


    Result := qryConsulta.FieldByName('TRANSF').AsInteger = 1;

  Finally
    FreeAndNil(qryConsulta)
  End;

end;

Function TCalculoPisCofins.fCalculoPisCofins( strEmp, strCodIte, strClaFis, strCodSit, strCodFor, strSimPau, strOpcDoc: String;
                                dblTotIte, dblDesconto, dblIpi, dblValRet, dblValFrete, dblDespAce, dbValIcm, dbValFcp: Double;
                                strTipfc, strIncPis,
                                strSitP_C, strMenP_C : String;
                                dtaDtaEnt: TDate;
                                strCodEmpTransf: String = '';
                                blnEhOperacaoDeTransferencia: Boolean = False;
                                blnBFut49 : Boolean = False;
                                strEntRet : string = '';
                                strEntFut : string = '';
                                strMotFut : string = '';
                                strClaIpi : string = '';
                                blnRetornaAliquota: Boolean = False;
                                CST_XML: string = '';
                                VALICMS_XML: Double = -1;
                                XMLCstPis: String = '';
                                XmlCstCofins: string = '';
                                XmlAliqPis: Double = 0;
                                XmlAliqCofins: Double = 0;
                                fltDifal : Double = 0): TResultPisCofins;

Const
  PIS: String = 'PIS';     // PISSAI  PISENT;
  COFINS: String = 'COF';  // COFSAI  COFSENT;
  SAIDA: String = 'SAI';
  ENTRADA: String = 'ENT';
  IGNORANDO_VIGENCIA: Boolean = False;


Var
  objDados: IMyCampoTabela;
  bln_Zerar, blnZonFra, blnBenRei, blnFilialSimples: Boolean;
  blnForFil: boolean;
  strTabItem: String;
  strCSTCredito,
  strCSTDebito: String;
  strCliNatRec: String;
  RecCfgPisCofinsSuframa: TRecCfgPisCofinsSuframa;
  blnEhCFOPEntradaDeTransferencia: Boolean;

  procedure pCarregaDados(strTipoAbrevi, strEntraSaida: String; blnConsiderarVigencia: Boolean=True);
    Var
      strSQL: String;
      qryTbl : TUniQuery;

  Begin
    qryTbl := fCriaQuery;

    strSQL := ' SELECT @TABABF.* FROM @TABABF INNER JOIN ' +strTabItem+ ' ON (ITE_ABF@TIPABF = APC_CODAPC) ' +
              ' WHERE LOCATE(:CLAFIS, APC_CFO@ENTSAI) > 0 AND ITE_CODITE = :CODITE '+IIF(strTabItem = 'ITEGER', ' AND ITE_CODEMP = :CODEMP ', '');
    If blnConsiderarVigencia Then
      strSQL := strSQL + ' AND ((APC_VIGENC >= :DTAMOV) OR (APC_VIGENC < "2000-01-01")) ORDER BY APC_VIGENC DESC ';

    strSQL := AnsiReplaceStr(strSQL,'@TABABF', strTipoAbrevi + strEntraSaida);
    strSQL := AnsiReplaceStr(strSQL,'@TIPABF', strTipoAbrevi);
    strSQL := AnsiReplaceStr(strSQL,'@ENTSAI', strEntraSaida);

    qryTbl.Close;
    qryTbl.SQL.Clear;
    qryTbl.SQL.Add(strSQL);
    qryTbl.ParamByName('CLAFIS').AsString := strClafis;
    qryTbl.ParamByName('CODITE').AsString := strCodIte;
    If qryTbl.FindParam('DTAMOV') <> Nil Then
      qryTbl.ParamByName('DTAMOV').AsDate := dtaDtaEnt;
    If qryTbl.FindParam('CODEMP') <> Nil Then
      qryTbl.ParamByName('CODEMP').AsString := strEmp;

    objDados := ExecutarQueryEmCache(qryTbl);

    FreeAndNil(qryTbl);
  End;

  function fDeveSomarFrete(AStrClaFis: String; ACfopTransferencia: Boolean): Boolean;
  begin
    Result := False;
    If (AStrClaFis >= '5000') then
      Exit(fCfgSisInterna('FREDEB', varBoolean));
    If (AStrClaFis  < '5000') Then
    Begin
      If ACfopTransferencia Then
        Exit(fCfgSisInterna('FRECRT', varBoolean))
      Else
        Exit(fCfgSisInterna('FRECRE', varBoolean))
    End;
  End;


  Procedure pAjustaTotIte;
  Var
    blnDevolucao: Boolean;
      blnCst_x10_x60_x70_ICMDCD: Boolean;
      blnCst_x10_x60_x70_entrada: Boolean;
  Begin
    blnDevolucao := Pos(strClaFis, '1201_1202_1203_1204_ 2201_2202_2203_2204') > 0;
    blnEhCFOPEntradaDeTransferencia := False;
    If blnForFil Then
      blnEhCFOPEntradaDeTransferencia := fEhEntradaTranferencia(strClaFis);


    If fCfgSisInterna('INCDES',varBoolean) Then
      dblTotIte := dblTotIte - dblDesconto;

    If fCfgSisInterna(IIf(strClaFis >= '5000', 'IPIDEB', 'IPICRE'), varBoolean) Then
      dblTotIte := dblTotIte + dblIpi;

    If fCfgSisInterna(IIf(strClaFis >= '5000', 'STDEB_', 'STCRE_'), varBoolean) Then
      dblTotIte := dblTotIte + dblValRet;

    If fDeveSomarFrete(strClaFis, blnEhCFOPEntradaDeTransferencia) Then
      dblTotIte := dblTotIte + dblValFrete;

    If fCfgSisInterna(IIf(strClaFis >= '5000', 'DESDEB', 'DESCRE'), varBoolean) Then
      dblTotIte := dblTotIte + dblDespAce;

    strCSTCredito :=  fTransform(fCfgSisInterna('ICMDCD',varString), 2, '_');
    strCSTDebito  :=  fTransform(fCfgSisInterna('ICMDDB',varString), 2, '_');

    blnCst_x10_x60_x70_ICMDCD := (Pos('10', strCSTCredito) > 0) Or
                                 (Pos('60', strCSTCredito) > 0) Or
                                 (Pos('70', strCSTCredito) > 0);
    blnCst_x10_x60_x70_entrada := (Pos(Copy(strCodSit, 2,2), '_10_60_70') > 0);

    blnCst_x10_x60_x70_entrada := blnCst_x10_x60_x70_ICMDCD And         // NA CONFGIURAÇÃO TEM ST
                                  blnCst_x10_x60_x70_entrada And        // ITEM COM CST DE ST
                                  (Pos(Copy(strCodSit, 2,2), strCSTCredito) > 0);  // CST DO ITEM ESTÁ NA CONFIGURAÇÃO CFG_ICMDCD


    If (strClaFis < '5000') And //SE FOR OPERACAO DE ENTRADA,
       (Pos(strClaFis, fCfgSis('CLACOM')) > 0) And //CFOP DE COMPRA
       (fCfgSis('ICMCRE') = 'S') And //[CFG_ICMCRE]Deduzir ICMS dos produtos tributados ( x00, x20 ) da base de cálculo do CRÉDITO ? = 'S'
       blnCst_x10_x60_x70_entrada And
       (VALICMS_XML > 0) Then//PARA OS PRODUTOS COM x10, CASO ESTEJA INFORMADO NA [CFG_ICMDCD]
      dblTotIte := dblTotIte - VALICMS_XML



    Else If (blnDevolucao) And (fCfgSisInterna('ICMCDV', varBoolean)) Then
    Begin
      If  ((Pos(Copy(strCodSit, 2,2), '20') > 0) Or (Pos(Copy(strCodSit, 2,2), '00') > 0)) Then
        dblTotIte := dblTotIte - dbValIcm - fltDifal;
    End
    Else If (not blnBenRei) And fEmptyStr(strBeneficioREIDI) And fCfgSisInterna(IIf(strClaFis >= '5000', 'ICMDEB', 'ICMCRE'), varBoolean) Then
    Begin

      if IIf(strClaFis >= '5000', (Pos(Copy(strCodSit, 2,2), strCSTDebito) > 0), //Debito
                                  (Pos(Copy(strCodSit, 2,2), strCSTCredito) > 0))  Then //Credito
      begin
        dblTotIte := dblTotIte - dbValIcm;
        If (strClaFis >= '5000') Then
          dblTotIte := dblTotIte - fltDifal;
      end;
    End;

    If ((fCfgSisInterna('FCPBPC', varString) = 'S') And (Pos(LeftStr(strClaFis, 1), '1_5_') > 0)) Or
       ((fCfgSisInterna('FCPBPC', varString) = 'T') And (Pos(LeftStr(strClaFis, 1), '1_2_5_6_') > 0)) Then
    Begin
      if IIf(strClaFis >= '5000', (Pos(Copy(strCodSit, 2,2), strCSTDebito) > 0), //Debito
                                  (Pos(Copy(strCodSit, 2,2), strCSTCredito) > 0))  Then //Credito
        dblTotIte := dblTotIte - dbValFcp;
    End;
  End;

  procedure pZerarValoresZonaFranca;
  Begin
    Result.dblBasePis   := 0;
    Result.dblAlqPis    := 0;
    Result.dblValorPis  := 0;

    Result.dblBaseCof   := 0;
    Result.dblAlqCof    := 0;
    Result.dblValorCof  := 0;
  End;

begin
  Result.blnCarregadoPelaCFG_SUFIPC := False;

  try
    If fCfgSisInterna('TPABPC',varString) = '1' Then
      strTabItem := 'CADITE'
    Else
      strTabItem := 'ITEGER';

    Result.blnResult := True;

    Result.strCstPis    := '';
    Result.dblBasePis   := 0;
    Result.dblAlqPis    := 0;
    Result.dblValorPis  := 0;
    Result.strNatRecPis := '';

    Result.strCstCof    := '';
    Result.dblBaseCof   := 0;
    Result.dblAlqCof    := 0;
    Result.dblValorCof  := 0;
    Result.strNatRecCof := '';

    // Drawback prevalece sobre qualquer outra regra de PIS/COFINS
    If fDrawbackEmbarcacao Then
    Begin
      Result.strCstPis := '09';
      Result.strCstCof := '09';
      Exit;
    End;

    blnForFil := False;

    If strTipfc = 'C' Then
    Begin
      blnZonFra := fZonaFranca(strCodFor);
      blnBenRei := fClienteBeneficioReidi(strCodFor);
    End
    Else
    Begin
      blnZonFra := False;
      blnBenRei := False;
      blnForFil := fFornecedorFilial(strCodFor);
    End;

    If (strCodEmpTransf <> '') And (fCfgSisInterna('SIMPAU', varBoolean, strCodEmpTransf)) And
       ((blnEhOperacaoDeTransferencia) Or (Not fCfgSisInterna('UTIABR',varBoolean))) Then
      blnFilialSimples := True
    Else
      blnFilialSimples := False;

    {******************************************************************}
    {* QUANDO FOR SIMPLES PAULISTA, DEIXAR O CST DE PIS E COFINS = 49 *}
    {* SOLICITAÇÃO REF AO REQUISITO 28229 - VALEC                     *}
    {***************************************************************FC*}
    If (strSimPau = 'S') Then
    Begin
      Result.strCstPis := '49';
      Result.strCstCof := '49';
    End;

    If blnBenRei Then
    Begin
      strCliNatRec := fCampoTabela('CLI_NATREC', 'CADCLI', ['CLI_CODCLI'], [strCodFor], False);

      Result.strNatRecPis := strCliNatRec;
      Result.strNatRecCof := strCliNatRec;

      If strClaFis >= '5000' Then
      Begin
        Result.strCstPis := IfEmptyStr(fCfgSisInterna('CSBRSA', varString), '09');
        Result.strCstCof := IfEmptyStr(fCfgSisInterna('CSBRSA', varString), '09');
      End
      Else
      Begin
        Result.strCstPis := IfEmptyStr(fCfgSisInterna('CSBREN', varString), '72');
        Result.strCstCof := IfEmptyStr(fCfgSisInterna('CSBREN', varString), '72');
      End;

      Exit;
    End;

    bln_Zerar := (Pos(strOpcDoc, 'CO_MF') > 0) Or ((blnZonFra) And (Not fCfgSisInterna('UTIABR',varBoolean)));

    {****************************************************************************}
    {* CASO ESTEJA FAZENDO UMA CONFIRMAÇÃO DE CUPOM E ESTÁ PARA ZERAR ICMS/IPI, *}
    {* SE ESTIVER UTILIZANDO O CADASTRO DE ABREVIAÇÃO DE PIS/COFINS, IRÁ PEGAR  *}
    {* O CST DE PIS/COFINS DA ABREVIAÇÃO.                                       *}
    {*************************************************************************PZ*}
    If (Not bln_Zerar) And ((strOpcDoc = 'CI') And (fCfgSisInterna('ZERCIF', varBoolean))) Then
    Begin
      bln_Zerar := True;

      If (fCfgSisInterna('UTIABR',varBoolean)) Then
      Begin
        pCarregaDados(PIS, SAIDA);

        If (Not fEmptyStr(objDados.FieldByName('APC_CSTSAI'))) Then
          Result.strCstPis := objDados.FieldByName('APC_CSTSAI');

        pCarregaDados(COFINS, SAIDA);

        If (Not fEmptyStr(objDados.FieldByName('APC_CSTSAI'))) Then
          Result.strCstCof := objDados.FieldByName('APC_CSTSAI');
      End;
    End;

    {****************************************************************************}
    {* QUANDO CFOP 5999 OU 1999, NÃO FAZ NENHUM CÁLCULO DE PIS/COF - 22/11/2012 *}
    {*************************************************************************RN*}
    If (bln_Zerar) Or (strClaFis = '5999') Or (strClaFis = '1999') Then
      Exit;

    {******************************************}
    {* UTILIZAR ABREVIAÇÃO DE PIS E COFINS    *}
    {* QUANDO SIM USA VALORES DA ABREVIAÇÃO,  *}
    {* SENAO USA PROGRAMA CONVERTE.           *}
    {***************************************NC*}
    If Not(fCfgSisInterna('UTIABR',varBoolean)) Then
    Begin
      If (blnBFut49) Then
      Begin
        Result.strCstPis := '49';
        Result.strCstCof := '49';
      End
      Else
      Begin
        Result.strCstPis   := fRetCstPisCofins(strClafis, strCodSit, strIncPis, strSitP_C, strMenP_C, True);
        Result.strCstCof   := fRetCstPisCofins(strClafis, strCodSit, strIncPis, strSitP_C, strMenP_C, True);
      End;

      If (Result.strCstPis = '01') or (Result.strCstPis = '50') Then
      Begin
        pAjustaTotIte;

        Result.dblAlqPis   := fCfgSisInterna('ALPISP', varDouble);
        Result.dblBasePis  := dblTotIte;
        Result.dblValorPis := fFormataFloat(fUmCentavo(Result.dblBasePis * Result.dblAlqPis / 100, Result.dblBasePis),2);

        Result.dblAlqCof   := fCfgSisInterna('ALCOFP', varDouble);
        Result.dblBasecOF  := dblTotIte;
        Result.dblValorCof := fFormataFloat(fUmCentavo(Result.dblBaseCof * Result.dblAlqCof / 100, Result.dblBaseCof),2);
      End
      Else
      Begin
        Result.dblAlqPis   := 0;
        Result.dblBasePis  := 0;
        Result.dblValorPis := 0;
        Result.dblAlqCof   := 0;
        Result.dblBaseCof  := 0;
        Result.dblValorCof := 0;
      End;
      Exit;
    End;

    If strClaFis >= '5000' Then
    Begin
      If ((strTipfc = 'F') And (fSimples(strCodFor)) or (blnFilialSimples)) And
         (Not fEmptyStr(fCfgSisInterna('CSTSAI',varString))) Then
      Begin
        Result.strCstPis    := fCfgSisInterna('CSTSAI',varString);
        Result.dblBasePis   := 0;
        Result.dblAlqPis    := 0;
        Result.dblValorPis  := 0;
        Result.strNatRecPis := fCfgSisInterna('NATSAI',varString);
        Result.strCstCof    := fCfgSisInterna('CSTSAI',varString);
        Result.dblBaseCof   := 0;
        Result.dblAlqCof    := 0;
        Result.dblValorCof  := 0;
        Result.strNatRecCof := fCfgSisInterna('NATSAI',varString);
      End
      Else
      Begin
        pAjustaTotIte;

        pCarregaDados(PIS, SAIDA);

        If (fEmptyStr(objDados.FieldByName('APC_CSTSAI'))) Then
        Begin
          pCarregaDados(PIS, SAIDA, IGNORANDO_VIGENCIA);
        End;

        If (Not fEmptyStr(objDados.FieldByName('APC_CSTSAI'))) Then
        Begin
          If (blnBFut49) Then
            Result.strCstPis  := '49'
          Else
            Result.strCstPis  := objDados.FieldByName('APC_CSTSAI');

          Result.dblBasePis   := objDados.FieldByName('APC_BASSAI').AsFloat * dblTotIte / 100;
          Result.dblAlqPis    := objDados.FieldByName('APC_ALQSAI');
          Result.dblValorPis  := Result.dblBasePis * Result.dblAlqPis / 100;
          Result.dblValorPis  := fUmCentavo(Result.dblValorPis, objDados.FieldByName('APC_BASSAI'));
          Result.strNatRecPis := objDados.FieldByName('APC_MOTISE');
        End
        Else
        Begin
          If Not fEhItemServico(strCodIte) Then
          Begin
            strMsgErro :=  'Abreviação de PIS não configurada.'+ #13+#10 +
                           'Favor verificar cadastros de abreviação e produto.'+ #13+#10 +
                           'CFOP PIS SAÍDA: ' + strClafis + #13+#10 +
                           'PRODUTO: ' + strCodIte;

            Result.blnResult := False;

            If blnGerarException Or fInTransaction() Then
              Raise Exception.Create(strMsgErro)
            Else
              pMensagemOk(strMsgErro);

            Exit;
          End;
        End;

        pCarregaDados(COFINS, SAIDA);

        If (fEmptyStr(objDados.FieldByName('APC_CSTSAI'))) Then
        Begin
          pCarregaDados(COFINS, SAIDA, IGNORANDO_VIGENCIA);
        End;

        If (Not fEmptyStr(objDados.FieldByName('APC_CSTSAI'))) Then
        Begin
          If (blnBFut49) Then
            Result.strCstCof  := '49'
          Else
            Result.strCstCof  := objDados.FieldByName('APC_CSTSAI');

          Result.dblBaseCof   := objDados.FieldByName('APC_BASSAI').AsFloat * dblTotIte / 100;
          Result.dblAlqCof    := objDados.FieldByName('APC_ALQSAI');
          Result.dblValorCof  := Result.dblBaseCof * Result.dblAlqCof / 100;
          Result.dblValorCof  := fUmCentavo(Result.dblValorCof, objDados.FieldByName('APC_BASSAI'));
          Result.strNatRecCof := objDados.FieldByName('APC_MOTISE');
        End
        Else
        Begin
          If Not fEhItemServico(strCodIte) Then
          Begin
            strMsgErro := 'Abreviação de COFINS não configurada.'+ #13+#10 +
                          'Favor verificar cadastros de abreviação e produto.'+ #13+#10 +
                          'CFOP COFINS SAÍDA: ' + strClafis + #13+#10 +
                          'PRODUTO: ' + strCodIte;

            Result.blnResult := False;

            If blnGerarException Or fInTransaction() Then
              Raise Exception.Create(strMsgErro)
            Else
              fMensagem('ATENÇÃO', strMsgErro, ['&OK']);

            Exit;
          End
        End;
      End;

      If fCfgSisInterna('BFUT49', varBoolean) Then
      begin
        If Pos('922', strClaFis) > 0 Then
        Begin
          If (strEntRet <> 'R') And (strEntFut = 'S')And (strMotFut <> 'F') then
          begin
             Result.strCSTPis := '01';
             Result.strCSTCof := '01';
          end
          else
          If (strEntRet <> 'R') And (strEntFut = 'S')And (strMotFut = 'F') then
          begin
             Result.strCSTPis   := '49';
             Result.dblBasePis  := 0;
             Result.dblAlqPis   := 0;
             Result.dblValorPis := 0;

             Result.strCSTCof   := '49';
             Result.dblBaseCof  := 0;
             Result.dblAlqCof   := 0;
             Result.dblValorCof := 0;
          end;
        end
        else
        If ((Pos('117', strClaFis) > 0) Or (Pos('116', strClaFis) > 0)) Then
        Begin
          If (strEntRet <> 'R') And (strEntFut = 'S')And (strMotFut <> 'F') then
          begin
             Result.strCSTPis   := '49';
             Result.dblBasePis  := 0;
             Result.dblAlqPis   := 0;
             Result.dblValorPis := 0;

             Result.strCSTCof   := '49';
             Result.dblBaseCof  := 0;
             Result.dblAlqCof   := 0;
             Result.dblValorCof := 0;
          end
          else
          If (strEntRet <> 'R') And (strEntFut = 'S')And (strMotFut = 'F') then
          begin
             Result.strCSTPis := '01';
             Result.strCSTCof := '01';

             Result.dblAlqPis   := fCfgSisInterna('ALPISP', varDouble);
             Result.dblBasePis  := dblTotIte;
             Result.dblValorPis := fFormataFloat(fUmCentavo(Result.dblBasePis * Result.dblAlqPis / 100, Result.dblBasePis),2);

             Result.dblAlqCof   := fCfgSisInterna('ALCOFP', varDouble);
             Result.dblBaseCof  := dblTotIte;
             Result.dblValorCof := fFormataFloat(fUmCentavo(Result.dblBaseCof * Result.dblAlqCof / 100, Result.dblBaseCof),2);
          end;
        end;
      end;

    End
    Else
    Begin
      If ((blnFilialSimples)) And
         (Not fEmptyStr(fCfgSisInterna('CSTENT',varString))) Then
      Begin
        Result.strCstPis    := fCfgSisInterna('CSTENT',varString);
        Result.dblBasePis   := 0;
        Result.dblAlqPis    := 0;
        Result.dblValorPis  := 0;
        Result.strNatRecPis := '';
        Result.strCstCof    := fCfgSisInterna('CSTENT',varString);
        Result.dblBaseCof   := 0;
        Result.dblAlqCof    := 0;
        Result.dblValorCof  := 0;
        Result.strNatRecCof := '';
      End
      Else
      Begin
        pAjustaTotIte;

        RecCfgPisCofinsSuframa.pGetValue(VS_StrCodEmp);
        If fEhEstadoRegraZonaFranca(fCadEmp('ESTADO')) and  (XMLCstPis = '01') and (XmlAliqPis > 0) And (RecCfgPisCofinsSuframa.blnTemConfiguracao) Then
        Begin
          Result.strCstPis   := RecCfgPisCofinsSuframa.PIS_CST;
          Result.dblBasePis  := RecCfgPisCofinsSuframa.PIS_BASE * dblTotIte / 100;
          Result.dblAlqPis   := RecCfgPisCofinsSuframa.PIS_ALIQUOTA;
          Result.dblValorPis := Result.dblBasePis * Result.dblAlqPis / 100;
          Result.dblValorPis := fUmCentavo(Result.dblValorPis, Result.dblBasePis);
          Result.blnCarregadoPelaCFG_SUFIPC := True;
        End
        Else
        Begin
          pCarregaDados(PIS, ENTRADA);

          If (fEmptyStr(objDados.FieldByName('APC_CSTENT'))) Then
          Begin
            pCarregaDados(PIS, ENTRADA, IGNORANDO_VIGENCIA);
          End;

          If (Not fEmptyStr(objDados.FieldByName('APC_CSTENT'))) Then
          Begin
            Result.strCstPis   := objDados.FieldByName('APC_CSTENT');
            Result.dblBasePis  := objDados.FieldByName('APC_BASENT').AsFloat * dblTotIte / 100;
            Result.dblAlqPis   := objDados.FieldByName('APC_ALQENT');
            Result.dblValorPis := Result.dblBasePis * Result.dblAlqPis / 100;
            Result.dblValorPis := fUmCentavo(Result.dblValorPis, objDados.FieldByName('APC_BASENT'));
          End
          Else
          Begin
            If Not fEhItemServico(strCodIte, True) Then
            Begin
              strMsgErro := 'Abreviação de PIS não configurada.'+ #13+#10 +
                            'Favor verificar cadastros de abreviação e produto.'+ #13+#10 +
                            'CFOP PIS ENTRADA: ' + strClafis + #13+#10 +
                            'PRODUTO: ' + strCodIte;

              Result.blnResult := False;

              If blnGerarException Or fInTransaction() Then
                Raise Exception.Create(strMsgErro)
              Else
                pMensagemOk(strMsgErro);

              Exit;
            End;
          End;
        End;

        If fEhEstadoRegraZonaFranca(fCadEmp('ESTADO')) and  (XMLCstCofins = '01') and (XmlAliqCofins > 0) And (RecCfgPisCofinsSuframa.blnTemConfiguracao) Then
        begin
          Result.strCstCof   := RecCfgPisCofinsSuframa.COFINS_CST;
          Result.dblBaseCof  := RecCfgPisCofinsSuframa.COFINS_BASE * dblTotIte / 100;
          Result.dblAlqCof   := RecCfgPisCofinsSuframa.COFINS_ALIQUOTA;
          Result.dblValorCof := Result.dblBaseCof * Result.dblAlqCof / 100;
          Result.dblValorCof := fUmCentavo(Result.dblValorCof, Result.dblBaseCof);
          Result.blnCarregadoPelaCFG_SUFIPC := True;

        End
        Else
        begin

          pCarregaDados(COFINS, ENTRADA);

          If (fEmptyStr(objDados.FieldByName('APC_CSTENT'))) Then
          Begin
            pCarregaDados(COFINS, ENTRADA, IGNORANDO_VIGENCIA);
          End;

          If (Not fEmptyStr(objDados.FieldByName('APC_CSTENT'))) Then
          Begin
            Result.strCstCof   := objDados.FieldByName('APC_CSTENT');
            Result.dblBaseCof  := objDados.FieldByName('APC_BASENT').AsFloat * dblTotIte / 100;
            Result.dblAlqCof   := objDados.FieldByName('APC_ALQENT');
            Result.dblValorCof := Result.dblBaseCof * Result.dblAlqCof / 100;
            Result.dblValorCof := fUmCentavo(Result.dblValorCof, objDados.FieldByName('APC_BASENT'));
          End
          Else
          Begin
            If Not fEhItemServico(strCodIte, True) Then
            Begin
              strMsgErro :=  'Abreviação de COFINS não configurada.'+ #13+#10 +
                             'Favor verificar cadastros de abreviação e produto.'+ #13+#10 +
                             'CFOP COFINS ENTRADA: ' + strClafis+ #13+#10 +
                             'PRODUTO: ' + strCodIte;

              Result.blnResult := False;

              If blnGerarException Or fInTransaction() Then
                Raise Exception.Create(strMsgErro)
              Else
                fMensagem('ATENÇÃO', strMsgErro, ['&OK']);

              Exit;
            End;
          End;
        End;
      End;
    End;

    if (strSitP_C = 'T') And (strTipfc = 'C') and (fNcmTemBeneficioRecap(strCodFor, strClaIpi)) then
      strSitP_C := 'S';

    If (strSitP_C = 'D') And (Pos(strCodSit, CST_DIFERE_PIS_COFINS) > 0) Then
    Begin

      If Result.strCstPis = '07' Then
        Result.strCstPis := '09';

      If Result.strCstCof = '07' Then
        Result.strCstCof := '09';
    End;

    Case AnsiIndexStr(UpperCase(strSitP_C), ['I','S','Z']) of
      0 : Begin
            Result.strCstPis := IIf(strClaFis >= '5000', '07', '71');
            Result.strCstCof := IIf(strClaFis >= '5000', '07', '71');

            Result.dblBasePis := 0;
            Result.dblAlqPis := 0;
            Result.dblValorPis := 0;

            Result.dblBaseCof := 0;
            Result.dblAlqCof := 0;
            Result.dblValorCof := 0;

          End;
      1 : Begin
            Result.strCstPis := IIf(strClaFis >= '5000', '09', '72');
            Result.strCstCof := IIf(strClaFis >= '5000', '09', '72');

            Result.dblBasePis := 0;
            Result.dblAlqPis := 0;
            Result.dblValorPis := 0;

            Result.dblBaseCof := 0;
            Result.dblAlqCof := 0;
            Result.dblValorCof := 0;

          End;
      2 : Begin
            Result.strCstPis := IIf(strClaFis >= '5000', '06', '73');
            Result.strCstCof := IIf(strClaFis >= '5000', '06', '73');

            Result.dblBasePis := 0;
            Result.dblAlqPis := 0;
            Result.dblValorPis := 0;

            Result.dblBaseCof := 0;
            Result.dblAlqCof := 0;
            Result.dblValorCof := 0;

          End;
    End;

    If (blnZonFra) And (not blnRetornaAliquota) Then
      pZerarValoresZonaFranca;
  finally

  end;
end;

function TCalculoPisCofins.fCfgSisInterna(strCamCfg: String;
  varTipVar: TVarType; strCodEmp: String): Variant;
  Var
    strChave: String;
begin
  strChave := strCamCfg+strCodEmp;
  If dicCacheCfg.Retorna(strChave) = Null Then
  Begin
    dicCacheCfg[strChave] := fCfgSis(strCamCfg,varTipVar,strCodEmp);
  End;

  Result := dicCacheCfg[strChave];
end;

function TCalculoPisCofins.fNcmTemBeneficioRecap(strCodCli, strClaIpi: String): Boolean;
var
  strSQL,
  strRECAP: String;
  qryRECAP: TUniQuery;
begin
  Result := False;

  strRECAP := fCampoTabela('CLI_RECAP_', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);

  if (strRECAP <> 'S') then
    Exit;

  try
    qryRECAP := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT RCP_CODNCM ';
    strSQL := strSQL + ' FROM CADCLI ';
    strSQL := strSQL + ' INNER JOIN CRECAP ON CADCLI.AUTOINCREM = CRECAP.RCP_SEQCLI ';
    strSQL := strSQL + ' WHERE CLI_CODCLI = :CODCLI AND RCP_CODNCM = :CODNCM';

    qryRECAP.SQL.Text := strSQL;
    qryRECAP.ParamByName('CODCLI').AsString := strCodCli;
    qryRECAP.ParamByName('CODNCM').AsString := strClaIpi;
    qryRECAP.Open;

    Result := not qryRECAP.IsEmpty;
  finally
    FreeAndNil(qryRECAP);
  end;
end;

function TCalculoPisCofins.fSimples(strFornecedor: String): Boolean;
begin
  Result := fCampoTabela('FOR_SIMPAU', 'CADFOR', ['FOR_CODFOR'], [strFornecedor], False) = 'S';
end;

function TCalculoPisCofins.fUmCentavo(fltVal, fltBase: Double): Double;
begin
  If (fltBase > 0) And (Frac(fltVal) <> 0) And (RoundTo(fltVal, -2) < RoundTo(0.01, -2)) Then
    Result := 0.01
  Else
    Result := fFormataFloat(fltVal, 2);
end;

function TCalculoPisCofins.fZonaFranca(strCliente: String): Boolean;
begin

  Result := False;

  If fEmptyStr(strCliente) Then
    Exit;

  Result := fCampoTabela('CLI_ZONFRA', 'CADCLI', ['CLI_CODCLI'], [strCliente], False) = 'S';

end;

procedure TCalculoPisCofins.pAddLog(strLog: String);
begin
  If AnsiEndsText('1999', strLog) Or AnsiEndsText('5999', strLog) Then
    Exit;

  stlLogDocs.Sorted := True;
  stlLogDocs.Duplicates := dupIgnore;
  stlLogDocs.Add(strLog);
end;

end.
