{******************************************************}
{* UNIT : OBJETO ESPELHO DE NOTA USADO PARA IMPRESSAO *}
{* DO ESPELHO DE NOTA AUTCOM/DLL DE REL.ESTOQUE       *}
{* AUTCOM:(ENTRADA DE MERCADORIAS CAIXA 1 E 2)        *}
{***************************************************JC*}

unit untEspelhoNota;

interface

uses classes, untFuncoesSimples, Uni, SysUtils, StrUtils,
     frxClass, frxDMpClass, Dialogs, UniClientDataSet, Variants,
     untGnre, untEntFreConLista, untEntVendor, untEntFreCon, untPcmGer,
     untEntOutrasDespesas, ComboBoxFocus, untTypesSistema, Vcl.StdCtrls;

  Type TEspNota = Class(TComponent)
  Private

    procedure pAjustaRelatorio(Var frxRel: TfrxReport; strDtaIni, strDtaFin: String; intOpc: Integer; blnEfetua: Boolean; blnQtdCmp: Boolean; strTabPre: String; blnDevolu: boolean);
    Procedure pMontaGNRE(intOpcao: Integer; frmQckEspelhoNota: Pointer; frxRel: TfrxReport; objGnre: TGnre);
    Procedure pAtualizaPisCofinsEntrada;

    function fsql_TOTITE_VARIACAO_COM_IMPOSTOS: String;
    function fsql_TOTITE_VARIACAO_COM_IMPOSTOS_OPC2: String;
    function fsql_TOTITE_ENT_VARIACAO_COM_IMPOSTOS: String;
    function fsql_TOTITE_ENT_VARIACAO_COM_IMPOSTOS_OPC2: String;

    function fRetPedCom(strPedidos: String; Var strConPag2: String): String;

    function fUtilizaConferenciaParaEntrada: String;

    function fRetornaPedidosOpcao3(strPedidos: String): String;
    function fRetornaFiltroPedidosOpcao3(strPedidos: String): String;

  Public
    intOpcUnit: Integer;
    blnDedFre  : Boolean;
    strDestino : String;
    strTipImp  : String;
    strNomImp  : String;
    strImpMarca: String;
    strTipCalc : String;
    strOrdenar : String;
    strOrdenarProd: String;
    intVisualiz: Integer;
    qryEspNota : TUniQuery;
    frxRel     : TfrxReport;
    arrParcelas: TParcelasArray;
    strCodOpe  : String;
    strNomOpe  : String;
    intOpcVariacao: Integer;
    intOpcCfop : Integer; // 0 - Todos CFOP'S | 1 - Apenas CFOP de Entrada | 2 - CFOPS de Bonificação (1910 e 2910)
    blnImpPre  : Boolean;
    fltIcmAnt  : Double;
    dtaIcmAnt  : TDateTime;
    blnPrecoCustoCadastro: Boolean;
    strCodPro, strCodFornec, strGruCmp: String;
    arrProduto, arrFornec, arrGruCmp : TConsultasArray;
    edtProduto, edtFornec, edtGruCmp : TObject;
    intModFre: Integer;

    strPedidos : String;

    objLisFre: TFreConLista;
    objVendor: TEntVendor;
    objOutDes: TEntOutrasDespesas;

    function fRetVendorDigitacao: String;
    function fRetICMAntDigitacao: String;
    function fRetOutrasDespesasDigitacao: String;
    function fRetSomaConhecimento: Double;
    function fCondPagtoConhecimentoFrete: String;
    function fDuplicatasConhecimentoFrete(strNumDoc, strEspDoc, strSerie, strCodFor: String): String;

    function fMontaRelEspNotEnt(intOpc: Integer;
                                strDtaIni,
                                strDtaFin,
                                strCodEmp,
                                strCodFor,
                                strNumDoc,
                                strEspDoc,
                                strSerie,
                                strCndPag,
                                strOrdIte,
                                strDtaEnt,
                                strDtaDoc,
                                strGruCmp : String;
                                blnEfetua: Boolean;
                                objGnre  : TGnre = Nil;
                                blnTransf: Boolean = True;
                                blnCancel: Boolean = False;
                                blnPreVen: Boolean = False;
                                strTabPre: String  = '';
                                objLisFre: TFreConLista = Nil;
                                objVendor: TEntVendor = Nil;
                                objOutDes: TEntOutrasDespesas = Nil;
                                blnVariacao: Boolean = False;
                                blnQtdCmp: Boolean = False;
                                cmbComCus: TComboBoxFocus = nil;
                                blnDevolu: Boolean = False;
                                blnObsCom: Boolean = False): Boolean;

  Constructor Create(Owner : TComponent); Reintroduce;
  Destructor Destroy; Reintroduce;
  procedure pZerarParcelas;
  End;

implementation

uses DB, untQckEspelhoNota, untConstantes, untFuncoesGenerica,  untCalculoPisCofins,
  untFuncoesConsulta;

Constructor TEspNota.Create(Owner : TComponent);
begin
  inherited Create(Owner);
  qryEspNota     := fCriaQuery(Self);
  intOpcVariacao := 0;
  intOpcCfop     := 0;
  fltIcmAnt      := 0;
  blnDedFre      := fCfgSis('DEDFRE', varBoolean);
  strPedidos     := '';

  objLisFre := Nil;
  objVendor := Nil;
  objOutDes := Nil;
end;

Procedure TEspNota.pMontaGNRE(intOpcao: Integer; frmQckEspelhoNota: Pointer; frxRel: TfrxReport; objGnre: TGnre);
Begin
  With TfrmQckEspelhoNota(frmQckEspelhoNota) Do
  Begin
    If (intOpcao <> 1) And Assigned(objGnre) And (Not fEmptyStr(objGnre.strValGnr)) Then
    Begin
      cdsGNRE.Insert;
      cdsGNRE.FieldByName('GNR_NUMGNR').AsString := '';
      cdsGNRE.FieldByName('GNR_VALGNR').AsFloat  := fStrToFloat(objGnre.strValGnr);
      cdsGNRE.FieldByName('GNR_DTAVEN').AsString := objGnre.strDtaVen;
      If Assigned(edtFornec) Then
        cdsGNRE.FieldByName('GNR_CODFOR').AsString := strCodFornec
      else
        cdsGNRE.FieldByName('GNR_CODFOR').AsString := objGnre.strCodFor + ' - ' + objGnre.strNomFor;
      cdsGNRE.Post;
    End;

    frxRel.FindObject('ChildGNRE').Visible := Not cdsGNRE.IsEmpty;
  End;
End;

procedure TEspNota.pZerarParcelas;
begin
  SetLength(arrParcelas, 0);
end;

destructor TEspNota.Destroy;
begin
  FreeAndNil(qryEspNota);
  inherited Destroy;
end;

Procedure TEspNota.pAtualizaPisCofinsEntrada;
  Var
    qryEntMer,
    qryUpDate: TUniQuery;
    calPosCof: TCalculoPisCofins;
    fltAlqPis, fltAlqCof: Double;
Begin
  qryEntMer := fCriaQuery;
  qryUpDate := fCriaQuery;

  calPosCof := TCalculoPisCofins.Create;

  With qryUpDate, SQL Do
  Begin
    Add('UPDATE TMP_ENTMER SET   ');
    Add('  ENT_PERPIS = :PERPIS, ');
    Add('  ENT_PERCOF = :PERCOF  ');
    Add('WHERE                   ');
    Add('  AUTOINCREM = :AUTINC  ');
  End;

  With qryEntMer, SQL Do
  Begin
    Add('SELECT');
    Add('  ENT_CLAFIS, ');
    Add('  ENT_CODFIS, ');
    Add('  ENT_INCPIS, ');
    Add('  AUTOINCREM  ');
    Add('FROM ');
    Add('  TMP_ENTMER ');
    Open;

    While Not Eof Do
    Begin
      calPosCof.pCalculaAlqPisCof(FieldByName('ENT_CLAFIS').AsString,
                                  FieldByName('ENT_CODFIS').AsString,
                                  FieldByName('ENT_INCPIS').AsString,
                                  'T', '',
                                  fltAlqPis, fltAlqCof);

      qryUpDate.Close;
      qryUpDate.ParamByName('PERPIS').AsFloat  := fltAlqPis;
      qryUpDate.ParamByName('PERCOF').AsFloat  := fltAlqCof;
      qryUpDate.ParamByName('AUTINC').AsString := FieldByName('AUTOINCREM').AsString;

      qryUpDate.ExecSQL;

      Next;
    End;
  End;

  FreeAndNil(calPosCof);
  FreeAndNil(qryEntMer);
End;

function TEspNota.fsql_TOTITE_VARIACAO_COM_IMPOSTOS: String;
Begin
  Result := ' (';

  Result := Result + ' (D.DET_TOTITE - D.DET_DESESP) ';

  If fCfgSis('ULTPIS', varBoolean) Then
    Result := Result + '  * (1 - ((T.DET_ALQPIS + T.DET_ALQCOF) / 100)) ';

  Result := Result + ' + D.DET_VALIPI + IFNULL(T.DET_VAEIPI, 0) + D.DET_TOTFRE ';
  Result := Result + ' + (D.DET_VALRET * IF(D.DET_VALRET > 0 AND (IF(D.DET_CODFOR IN (' + fRetStrToSQLIn(fRetForFilialTodos) + '), IFNULL(CON_ULTPIS, "N"), "' + fCfgSis('ULTPIS') + '") = "S") AND "' + fCfgSis('DPCSTU') + '" = "S" AND "' + fCfgSis('ENTPIS') + '" = "S" AND D.DET_INCPIS = "S", (1 -(T.DET_ALQPIS + T.DET_ALQCOF )/100), 1)) ';
  Result := Result + ' + IFNULL(T.DET_VAERET, 0) + IFNULL(T.DET_ICMANT, 0) + IFNULL(T.DET_VFCPST,0) ';

  If fCfgSis('DEDICM', varBoolean) Then
    Result := Result + ' - (DET_VALICM + IFNULL(ICD_VALFCP, 0))';

  Result := Result + ') ';
End;

function TEspNota.fsql_TOTITE_VARIACAO_COM_IMPOSTOS_OPC2: String;
Begin
  Result := ' (' + fsql_TOTITE_VARIACAO_COM_IMPOSTOS + ' + IFNULL(T.DET_CONFRE, 0) + IFNULL(T.DET_VENDOR, 0) + IFNULL(T.DET_OUTDES, 0) + IFNULL(DET_VLGNRE, 0) ) ';
End;

function TEspNota.fUtilizaConferenciaParaEntrada: String;
begin
  Result := 'FALSE';

  If Not fCfgSis('USACON', varBoolean) Then
    Exit;

  If Pos(fCfgSis('CONFME'), '1_3_') <= 0 Then
    Exit;

  Result := 'TRUE';
end;

function TEspNota.fsql_TOTITE_ENT_VARIACAO_COM_IMPOSTOS: String;
Begin
  Result := ' (';

  Result := Result + ' (ENT_TOTITE - ENT_DESESP) ';

  If fCfgSis('ULTPIS', varBoolean) Then
    Result := Result + '  * (1 - ((ENT_PERPIS + ENT_PERCOF) / 100)) ';

  Result := Result + ' + ENT_VALIPI  + IFNULL(ENT_VAEIPI, 0) + ENT_VALFRE ';
  Result := Result + ' + (ENT_VALRET * IF(ENT_VALRET > 0 AND (IF(' + IIF(Assigned(edtFornec), 'F.FOR_CODFOR', ':CODFOR') + ' IN (' + fRetStrToSQLIn(fRetForFilialTodos) + '), IFNULL(CON_ULTPIS, "N"), "' + fCfgSis('ULTPIS') + '") = "S") AND "' + fCfgSis('DPCSTU') + '" = "S" AND "' + fCfgSis('ENTPIS') + '" = "S" AND ENT_INCPIS = "S", (1 -(ENT_PERPIS + ENT_PERCOF )/100), 1)) ';
  Result := Result + ' + ENT_VALANT + IFNULL(ENT_VAERET, 0) + IFNULL(ENT_VFCPST,0) ';

  If fCfgSis('DEDICM', varBoolean) Then
    Result := Result + ' - (ENT_VALICM + IFNULL(ENT_VALFCP, 0)) ';

  Result := Result + ') ';
End;

function TEspNota.fsql_TOTITE_ENT_VARIACAO_COM_IMPOSTOS_OPC2: String;
Begin
  Result := ' (' + fsql_TOTITE_ENT_VARIACAO_COM_IMPOSTOS + ' + IFNULL(ENT_FRECON, 0) + IFNULL(ENT_FRERPA, 0) + IFNULL(ENT_VENDOR, 0)   + IFNULL(ENT_OUTDES, 0)   + IFNULL(ENT_VALGNR, 0)) ';
End;

function TEspNota.fRetornaFiltroPedidosOpcao3(strPedidos: String): String;
begin
  Result := fRetornaPedidosOpcao3(strPedidos);

  If Not fEmptyStr(Result) Then
    Exit;

  Result := '= ENT_NUMPED';
end;

function TEspNota.fRetornaPedidosOpcao3(strPedidos: String): String;
 Var
    intContador: Integer;
    sltPedidos: TStringList;
begin
  Result := '';
  sltPedidos      := TStringList.Create;
  sltPedidos.Text := strPedidos;

  Try
    For intContador := 0 To sltPedidos.Count - 1 Do
    Begin
      If intContador > 0 Then
      Begin
        Result := Result + ',';
      End;

      Result := Result + LeftStr(sltPedidos[intContador], Length(sltPedidos[intContador]) - 3);
    End;

    If Not fEmptyStr(Result) Then
      Result := 'IN ( ' + Result + ')';
  Finally
    FreeAndNil(sltPedidos);
  End;
end;

function TEspNota.fRetPedCom(strPedidos: String; Var strConPag2: String): String;
  Var
    intContador: Integer;
    sltPedidos: TStringList;
Begin
  Result     := '';
  strConPag2 := '';

  sltPedidos      := TStringList.Create;
  sltPedidos.Text := strPedidos;

  For intContador := 0 To sltPedidos.Count - 1 Do
  Begin
    Result := Result + LeftStr(sltPedidos[intContador], Length(sltPedidos[intContador]) - 3) + '-' + RightStr(sltPedidos[intContador], 3);

    strConPag2 := strConPag2 + fFormataCondPag(fCampoTabela('PCG_CONPAG', 'PCMGER', ['PCG_NUMPED', 'PCG_CODEMP'], [LeftStr(sltPedidos[intContador], Length(sltPedidos[intContador]) - 3),
                                                                                                   RightStr(sltPedidos[intContador], 3)]));

    If intContador < sltPedidos.Count - 1 Then
    Begin
      Result     := Result + ',';
      strConPag2 := strConPag2 + ',';
    End;
  End;

  FreeAndNil(sltPedidos);
End;

function TEspNota.fMontaRelEspNotEnt(intOpc: Integer;
                                     strDtaIni,
                                     strDtaFin,
                                     strCodEmp,
                                     strCodFor,
                                     strNumDoc,
                                     strEspDoc,
                                     strSerie,
                                     strCndPag,
                                     strOrdIte,
                                     strDtaEnt,
                                     strDtaDoc,
                                     strGruCmp : String;
                                     blnEfetua: Boolean;
                                     objGnre  : TGnre = Nil;
                                     blnTransf: Boolean = True;
                                     blnCancel: Boolean = False;
                                     blnPreVen: Boolean = False;
                                     strTabPre: String  = '';
                                     objLisFre: TFreConLista = Nil;
                                     objVendor: TEntVendor = Nil;
                                     objOutDes: TEntOutrasDespesas = Nil;
                                     blnVariacao: Boolean = False;
                                     blnQtdCmp: Boolean = False;
                                     cmbComCus: TComboBoxFocus = nil;
                                     blnDevolu: Boolean = False;
                                     blnObsCom: Boolean = False): Boolean;

  Const
    SQL_SOMA_BASE_ICMS_LIVRO  = 'IFNULL(FISDOC.FIS_BASIC1, 0) + IFNULL(FISDOC.FIS_BASIC2, 0) + IFNULL(FISDOC.FIS_BASIC3, 0) + IFNULL(FISDOC.FIS_BASIC4, 0) + IFNULL(FISDOC.FIS_BASIC5, 0)';
    SQL_SOMA_VALOR_ICMS_LIVRO = 'IFNULL(FISDOC.FIS_VLRIC1, 0) + IFNULL(FISDOC.FIS_VLRIC2, 0) + IFNULL(FISDOC.FIS_VLRIC3, 0) + IFNULL(FISDOC.FIS_VLRIC4, 0) + IFNULL(FISDOC.FIS_VLRIC5, 0)';

  Var
    strSQL    : String;
    strClaFis : String;
    qryAux    : TUniQuery;
    FPais     : TPais;
    strPreCus : String;
    intCorre  : Integer;
    strConPag2,
    strPreUni,
    strTotIte,
    strDesEsp: String;
    frmQckEspelhoNota : TfrmQckEspelhoNota;

  function fSQLQtd: String;
  begin
    If intOpc = 1 Then
      Result := ' DET_QTDITE '
    Else
    Begin
      If (fCfgSis('CNVEMB') <> 'N') Then
        Result := '(ENT_QTDITE * IF(IFNULL(ENT_EMBALA, 0) <= 0, 1, ENT_EMBALA)) '
      Else
        Result := 'ENT_QTDITE ';
    End;
  end;

begin
  inherited;

  Result := True;

  FPais := fSetaPais;

  Self.objLisFre := objLisFre;
  Self.objVendor := objVendor;
  Self.objOutDes := objOutDes;

(*  If Assigned(cmbComCus) And blnPreVen And (intOpcVariacao <> 2) Then
    strPreCus := 'IFNULL(' + fRetornaComposicao(cmbComCus.Items.Strings[cmbComCus.ItemIndex]) + ',0) / ' + fSQLQtd; *)

    strPreCus := '';

    strClaFis := '';
    If intOpc In [2,3] Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE GROUP_CONCAT(DISTINCT DC.ENT_CLAFIS,"-",FO.NAT_DESCRI) AS CLAFIS ';
      strSQL := strSQL + '  FROM TMP_ENTMER DC, NATCFO FO ';
      strSQL := strSQL + ' WHERE DC.ENT_CLAFIS = FO.NAT_CODCFO ';
      qryAux := fCriaQuery(Nil);
      qryAux.SQL.Add(strSQL);
      qryAux.Open;
      strClaFis := QuotedStr(qryAux.FieldByName('CLAFIS').AsString);
      qryAux.Close;
      FreeAndNil(qryAux);
    End;

    blnPrecoCustoCadastro := False;

    Case intOpc Of
    1:
      Begin
        {******************************************************}
        {* OPÇÃO RELATORIO DE ESTOQUE     REL.ESPELHO DE NOTA *}
        {***************************************************JC*}
        Case intOpcUnit Of
          1:   Begin
                 strPreUni := ' ((D.DET_TOTITE - D.DET_DESESP) / D.DET_QTDITE) ';
                 strTotIte := ' (D.DET_TOTITE - D.DET_DESESP) ';
                 strDesEsp := ' 0 ';
               End;
          Else Begin
                 strPreUni := ' D.DET_UNITAR ';
                 strTotIte := ' D.DET_TOTITE ';
                 strDesEsp := ' D.DET_DESESP ';
               End;
        End;

        Result := False;

        strSQL := '';
        strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
        strSQL := strSQL + '  CONCAT(IFNULL(D.DET_NUMDOC,""),IFNULL(D.DET_ESPDOC,""),IFNULL(D.DET_SERIE_,""),IFNULL(D.DET_CODFOR,"")) AS QUEBRA, ';//CAMPO PARA QUEBRA NO RELATORIO
        strSQL := strSQL + '  D.AUTOINCREM AS AUTINC, ';
        strSQL := strSQL + '  MOVGER.AUTOINCREM AS AUTGER, ';
        strSQL := strSQL + '  D.DET_CODEMP AS CODEMP, ';
        strSQL := strSQL + '  D.DET_NUMDOC AS NUMDOC, '; //NUMERO DO DOCUMENTO
        strSQL := strSQL + '  D.DET_ESPDOC AS ESPDOC, '; //ESPECIE DO DOCUMENTO
        strSQL := strSQL + '  D.DET_SERIE_ AS SERIE_, '; //SERIE DO DOCUMENTO
        strSQL := strSQL + '  D.DET_CODFOR AS CODFOR, '; //CODIGO DO FORNECEDOR
        strSQL := strSQL + '  F.FOR_NOMFOR AS NOMFOR, '; //NOME DO FORNECEDOR
        strSQL := strSQL + '  D.DET_CODVEN AS CODVEN, '; //CODIGO DO OPERADOR
        strSQL := strSQL + '  O.OPE_NOMOPE AS NOMVEN, '; //NOME DO OPERADOR
        strSQL := strSQL + '  IF(F.FOR_CGCCPF IS NULL OR F.FOR_CGCCPF = "", 0, F.FOR_CGCCPF) AS CGCCPF, '; //CNPJ OU CPF TIPO
        strSQL := strSQL + '  F.FOR_C_G_C_ AS _C_G_C, '; //CNPJ PU CPF NUMERO
        strSQL := strSQL + '  D.DET_DTAENT AS DTAENT, '; //DATA DE ENTRADA
        strSQL := strSQL + '  D.DET_DTADOC AS DTADOC, '; //DATA DO DOCUMENTO
        strSQL := strSQL + '  D.DET_CONPAG AS CONPAG, '; //COND. PAGAMENTO
        strSQL := strSQL + '  MOVGER.GER_TIPFRE AS MODFRE, ';  //modalidade de frete

        If intOpcVariacao = 0 Then
        Begin

          If (FPais <> opcParaguai) Then
          Begin
            strSQL := strSQL + strPreUni + ' AS UNITAR, '; //VALOR UNITARIO DO ITEM
            strSQL := strSQL + strTotIte + ' AS TOTITE, '; //TOTAL DOS ITEMS
          End
          Else
          Begin
            strSQL := strSQL + '  IFNULL(IF(D.DET_TAXCAM IS NOT NULL, (' + strPreUni + '/D.DET_TAXCAM), ' + strPreUni + '),0) AS UNITAR, '; //VALOR UNITARIO DO ITEM
            strSQL := strSQL + '  IFNULL(IF(D.DET_TAXCAM IS NOT NULL, (' + strTotIte + '/D.DET_TAXCAM), ' + strTotIte + '),0) AS TOTITE, '; //TOTAL DOS ITEMS
          End;

          strSQL := strSQL + '  G.ITE_PRECOM AS PRECOM, '; //PREÇO DE COMPRA
        End
        Else
        Begin
          If intOpcVariacao = 2 Then
          Begin
            strSQL := strSQL + '  ROUND((' + fSql_TOTITE_VARIACAO_COM_IMPOSTOS_OPC2 + ')/D.DET_QTDITE, 2) AS UNITAR, '; //VALOR UNITARIO DO ITEM
            strSQL := strSQL + '  (' + fSql_TOTITE_VARIACAO_COM_IMPOSTOS_OPC2 + ') AS TOTITE, '; //TOTAL DOS ITEMS
          End Else
          Begin
            strSQL := strSQL + '  ROUND((' + fSql_TOTITE_VARIACAO_COM_IMPOSTOS + ')/D.DET_QTDITE, 2) AS UNITAR, '; //VALOR UNITARIO DO ITEM
            strSQL := strSQL + '  (' + fSql_TOTITE_VARIACAO_COM_IMPOSTOS + ') AS TOTITE, '; //TOTAL DOS ITEMS
          End;

          strSQL := strSQL + '  G.ITE_IMPULT AS PRECOM, '; //PREÇO DE COMPRA
        End;

        If (FPais <> opcParaguai) Then
        Begin
          strSQL := strSQL + strPreUni + ' AS UNITAR_IMP, '; //VALOR UNITARIO DO ITEM
          strSQL := strSQL + strTotIte + ' AS TOTITE_IMP, '; //TOTAL DOS ITEMS
        End
        Else
        Begin
          strSQL := strSQL + '  IFNULL(IF(D.DET_TAXCAM IS NOT NULL, (' + strPreUni + '/D.DET_TAXCAM), ' + strPreUni + '),0) AS UNITAR_IMP, '; //VALOR UNITARIO DO ITEM
          strSQL := strSQL + '  IFNULL(IF(D.DET_TAXCAM IS NOT NULL, (' + strTotIte + '/D.DET_TAXCAM), ' + strTotIte + '),0) AS TOTITE_IMP, '; //TOTAL DOS ITEMS
        End;

        If (FPais <> opcParaguai) Then
        Begin
          strSQL := strSQL + '  (D.DET_VALIPI + IFNULL(T.DET_VAEIPI,0)) AS VALIPI , '; //TOTAL IPI
          strSQL := strSQL + '  (D.DET_VALRET + IFNULL(T.DET_VAERET,0)) AS VALRET, '; //TOTAL SUBST.
          strSQL := strSQL + '  D.DET_TOTFRE AS TOTFRE, '; //FRETE
          strSQL := strSQL + '  D.DET_DESACE AS DESACE, '; //DESPESAS ACESSORIAS
          strSQL := strSQL + strDesEsp + ' AS DESESP, '; //TOTAL DE DESCONTO

          If intOpcVariacao = 2 Then
            strSQL := strSQL + '  D.DET_VLRCON + IFNULL(T.DET_CONFRE, 0) + IFNULL(T.DET_VENDOR, 0) + IFNULL(T.DET_OUTDES, 0) + IFNULL(DET_VLGNRE, 0) AS VLRCON, ' //TOTAL DOS ITEMS C/ IMPOSTO
          Else
            strSQL := strSQL + '  D.DET_VLRCON AS VLRCON, '; //TOTAL DOS ITEMS C/ IMPOSTO
        End
        Else
        Begin
          strSQL := strSQL + '  IFNULL(IF(D.DET_TAXCAM IS NOT NULL, ((D.DET_VALIPI + IFNULL(T.DET_VAEIPI,0))/D.DET_TAXCAM), (D.DET_VALIPI + IFNULL(T.DET_VAEIPI,0))),0) AS VALIPI, '; //TOTAL IPI
          strSQL := strSQL + '  IFNULL(IF(D.DET_TAXCAM IS NOT NULL, ((D.DET_VALRET + IFNULL(T.DET_VAERET,0))/D.DET_TAXCAM), (D.DET_VALRET + IFNULL(T.DET_VAERET,0))),0) AS VALRET, '; //TOTAL SUBST.
          strSQL := strSQL + '  IFNULL(IF(D.DET_TAXCAM IS NOT NULL, (D.DET_TOTFRE/D.DET_TAXCAM), D.DET_TOTFRE),0) AS TOTFRE, '; //TOTAL DE FRETE
          strSQL := strSQL + '  IFNULL(IF(D.DET_TAXCAM IS NOT NULL, (D.DET_DESACE/D.DET_TAXCAM), D.DET_DESACE),0) AS DESACE, '; //DESPESAS ACESSORIAS
          strSQL := strSQL + '  IFNULL(IF(D.DET_TAXCAM IS NOT NULL, (' + strDesEsp + '/D.DET_TAXCAM), ' + strDesEsp + '),0) AS DESESP, '; //TOTAL DE DESCONTO
          strSQL := strSQL + '  IFNULL(IF(D.DET_TAXCAM IS NOT NULL, (D.DET_VLRCON/D.DET_TAXCAM), D.DET_VLRCON),0) AS VLRCON, '; //TOTAL DOS ITEMS C/ IMPOSTO
        End;

        strSQL := strSQL + '  T.DET_CONFRE AS FRECON,     ';
        strSQL := strSQL + '  T.DET_VAFRAN AS VAFRAN,     ';

        strSQL := strSQL + strTotIte + ' AS TOTITE_TOT, '; //TOTAL DOS ITEMS PARA O TOTALIZADOR GERAL
        strSQL := strSQL +  ' T.DET_VFCPST AS VFCPST, ';
        strSQL := strSQL + '  D.DET_VLRCON AS VLRCON_TOT, '; //TOTAL DOS ITEMS C/ IMPOSTO PARA O TOTALIZADOR GREAL

        strSQL := strSQL + '  D.DET_DESCRI AS DESITE, ';//DESCRICAO DO ITEM
        strSQL := strSQL + '  I.ITE_REFERE AS REFERE, '; //REFERENCIA DO ITEM
        strSQL := strSQL + '  I.ITE_CODFAB AS CODFAB, '; //CÓDIGO DE FÁBRICA DO ITEM
        strSQL := strSQL + '  D.DET_CODITE AS CODITE, '; //CODIGO DO ITEM

        strSQL := strSQL + '  IFNULL(LOT_NUMLOT, D.DET_NUMLOT) AS NUMLOT, '; //LOTE DO ITEM

        strSQL := strSQL + '  I.ITE_CODGRU AS CODGRU, '; //CODIGO DO GRUPO
        strSQL := strSQL + '  U.UNI_SIGUNI AS UNIDAD, '; //SIGLA DA UNIDADE
        strSQL := strSQL + '  D.DET_CODMAR AS CODMAR, '; //CODIGO DA MARCA

        If (FPais <> opcParaguai) Then
        Begin
          strSQL := strSQL + '  D.DET_BASICM AS BASICM, '; //BC. ICMS
          strSQL := strSQL + '  D.DET_VALICM AS VALICM, '; //VR. ICMS
          strSQL := strSQL + '  IFNULL(D.DET_BASRET,0) + IFNULL(T.DET_BAERET,0) AS BASRET, '; //BC. SUBST.
          strSQL := strSQL + '  D.DET_BASIPI + IFNULL(T.DET_BAEIPI, 0) AS BASIPI, '; //BC. IPI
          strSQL := strSQL + '  D.DET_ALQICM AS ALQICM, '; //ALQ. ICMS
          strSQL := strSQL + '  IF(IFNULL(D.DET_ALQIPI, 0) = 0, T.DET_ALEIPI, D.DET_ALQIPI) AS ALQIPI, '; //ALQ. IPI
        End
        Else
        Begin
          strSQL := strSQL + '  IFNULL(IF(D.DET_TAXCAM IS NOT NULL, (D.DET_BASICM/D.DET_TAXCAM), D.DET_BASICM),0) AS BASICM, '; //BC. ICMS
          strSQL := strSQL + '  IFNULL(IF(D.DET_TAXCAM IS NOT NULL, (D.DET_VALICM/D.DET_TAXCAM), D.DET_VALICM),0) AS VALICM, '; //VR. ICMS
          strSQL := strSQL + '  IFNULL(IF(D.DET_TAXCAM IS NOT NULL, (D.DET_BASRET/D.DET_TAXCAM), D.DET_BASRET),0) AS BASRET, '; //BC. SUBST.
          strSQL := strSQL + '  IFNULL(IF(D.DET_TAXCAM IS NOT NULL, ((D.DET_BASIPI + IFNULL(T.DET_BAEIPI, 0)) /D.DET_TAXCAM), D.DET_BASIPI + IFNULL(T.DET_BAEIPI, 0)),0) AS BASIPI, '; //BC. IPI
          strSQL := strSQL + '  IFNULL(IF(D.DET_TAXCAM IS NOT NULL, (D.DET_ALQICM/D.DET_TAXCAM), D.DET_ALQICM),0) AS ALQICM, '; //ALQ. ICMS
          strSQL := strSQL + '  IFNULL(IF(D.DET_TAXCAM IS NOT NULL, (IF(IFNULL(D.DET_ALQIPI, 0) = 0, T.DET_ALEIPI, D.DET_ALQIPI)/D.DET_TAXCAM), IF(IFNULL(D.DET_ALQIPI, 0) = 0, T.DET_ALEIPI, D.DET_ALQIPI)),0) AS ALQIPI, '; //ALQ. IPI
        End;

        strSQL := strSQL + '  M.MAR_DESMAR AS DESMAR, '; //DESCRICAO DA MARCA
        strSQL := strSQL + '  D.DET_QTDITE AS QTDITE,  '; //QUANTIDADE DE ITENS
        strSQL := strSQL + '  G.ITE_DESF01 AS DESF01, '; //DESCONTO
        strSQL := strSQL + '  G.ITE_DESF02 AS DESF02, '; //DESCONTO
        strSQL := strSQL + '  G.ITE_DESF03 AS DESF03, '; //DESCONTO
        strSQL := strSQL + '  G.ITE_DESF04 AS DESF04, '; //DESCONTO
        strSQL := strSQL + '  G.ITE_DESF05 AS DESF05, '; //DESCONTO
        strSQL := strSQL + '  G.ITE_DESF06 AS DESF06, '; //DESCONTO
        strSQL := strSQL + '  G.ITE_ACRFIN AS ACRFIN, '; //ACRESCIMO FINANCEIRO
        strSQL := strSQL + '  IF(IFNULL(DET_NUMLOT, "") = "", G.ITE_LOCFIS, LOT_LOCFIS) AS LOCFIS, '; //LOCALIZACAO FISICA

        strSQL := strSQL + '  D.DET_CODFIS AS CODFIS, '; //COD. FIS.

        If not fEmptyStr(strTabPre) Then
        Begin
          strSQL := strSQL + '  G.ITE_PREVE' + strTabPre + ' AS PREVEN, ';
          strSQL := strSQL + '  G.ITE_MARBR' + strTabPre + ' AS MARBRU, ';
        End;

        If blnPreVen And (strTabPre <> '') Then
        Begin
          If intOpcVariacao = 2 Then
            strSQL := strSQL + '  ROUND((' + fSql_TOTITE_VARIACAO_COM_IMPOSTOS_OPC2 + ')/D.DET_QTDITE, 2) AS PRECUS, ' //VALOR UNITARIO DO ITEM
          Else
          If not fEmptyStr(strPreCus) Then
            strSQL := strSQL + strPreCus + ' AS PRECUS, '
          Else Begin
            strSQL := strSQL + '  G.ITE_PRECUS AS PRECUS, ';
            blnPrecoCustoCadastro := True;
          End;

          strSQL := strSQL + '  G.ITE_ICMSAI AS ICMSAI, ';
          strSQL := strSQL + '  G.ITE_IMPFED AS IMPFED, ';
          strSQL := strSQL + '  G.ITE_DESOPE AS DESOPE, ';
          strSQL := strSQL + '  G.ITE_OUTVAL AS OUTVAL, ';
        End;

        If blnQtdCmp And (strTabPre <> '') Then
        Begin

          strSQL := strSQL + 'IFNULL(     ';

          strSQL := strSQL + '     IF( ';

          strSQL := strSQL + '           IF(' + fUtilizaConferenciaParaEntrada + ', DET_AUTELE IS NULL, TRUE), ';

          strSQL := strSQL + '           IFNULL( ';
          strSQL := strSQL + '                   (SELECT SUM(BAI_QTDPED) * IF( (PCD_EMBALA IS NULL) OR (PCD_EMBALA = 0), 1, PCD_EMBALA ) ';
          strSQL := strSQL + '                      FROM BAIPED ';
          strSQL := strSQL + '                     INNER JOIN PCMDET PD ON PD.AUTOINCREM = BAI_AUTPED ';
          strSQL := strSQL + '                     INNER JOIN PCMGER PG ON PG.PCG_NUMPED = PD.PCD_NUMPED ';
          strSQL := strSQL + '                                         AND PG.PCG_CODEMP = PD.PCD_CODEMP ';
          strSQL := strSQL + '                                         AND PG.PCG_ESPDOC = "PD" ';
          strSQL := strSQL + '                                         AND PG.PCG_NUMCTN = 0 ';
          strSQL := strSQL + '                     WHERE BAI_AUTDET = D.AUTOINCREM GROUP BY BAIPED.BAI_AUTDET), ';

          strSQL := strSQL + '                   (SELECT PCD_QTDITE * IF( (PCD_EMBALA IS NULL) OR (PCD_EMBALA = 0), 1, PCD_EMBALA ) ';
          strSQL := strSQL + '                      FROM PCMDET ';
          strSQL := strSQL + '                     WHERE PCD_NUMPED = D.DET_PEDCOM  ';
          strSQL := strSQL + '                       AND PCD_CODITE = D.DET_CODITE  ';
          strSQL := strSQL + '                       AND PCD_CODEMP = D.DET_EMPCOM) ';
          strSQL := strSQL + '                 ), ';

          strSQL := strSQL + '           (SELECT SUM(DEF_QTDITE) FROM DEFBAI WHERE DEF_AUTELE = DET_AUTELE)';

          strSQL := strSQL + '        ) ';

          strSQL := strSQL + '   , 0) AS QTDCMP, ';  // QUANTIDADE DO PRODUTO NO PEDIDO DE COMPRA

          If not fEmptyStr(strPreCus) Then
            strSQL := strSQL + strPreCus + ' AS PRECUS, '
          Else Begin
            strSQL := strSQL + '  G.ITE_PRECUS AS PRECUS, ';
            blnPrecoCustoCadastro := True;
          End;

          strSQL := strSQL + '  G.ITE_ICMSAI AS ICMSAI, ';
          strSQL := strSQL + '  G.ITE_IMPFED AS IMPFED, ';
          strSQL := strSQL + '  G.ITE_DESOPE AS DESOPE, ';
          strSQL := strSQL + '  G.ITE_OUTVAL AS OUTVAL, ';
          strSQL := strSQL + '  G.ITE_PREVE' + strTabPre + ' AS PREVEN, ';
          strSQL := strSQL + '  G.ITE_MARBR' + strTabPre + ' AS MARBRU, ';
        End;

        strSQL := strSQL + '  IF((GER_NATOPE <> ""),                                                           ';
        strSQL := strSQL + '          CONCAT(GER_CLAFIS,"-",GER_NATOPE),                                       ';
        strSQL := strSQL + '          (SELECT GROUP_CONCAT(DISTINCT DC.DET_CLAFIS,"-", IFNULL(NAT_DESCRI, "")) ';
        strSQL := strSQL + '            FROM MOVDET DC ';
        strSQL := strSQL + '            LEFT JOIN CADCFO FO ON DC.DET_CLAFIS = FO.CFO_CODCFO ';
        strSQL := strSQL + '            LEFT JOIN NATCFO    ON    NAT_CODCFO = FO.CFO_CODCFO ';
        strSQL := strSQL + '           WHERE DC.DET_SEQGER = D.DET_SEQGER ';
        strSQL := strSQL + '           GROUP BY ';
        strSQL := strSQL + '                 DC.DET_SEQGER)) AS CLAFIS, ';

        If (FPais <> opcParaguai) Then
          strSQL := strSQL + '  (' + strPreUni + '/IF(G.ITE_PRECOM IS NULL OR G.ITE_PRECOM = 0, ' + strPreUni + ', G.ITE_PRECOM) - 1) * 100 AS VARIAC, '
        Else
        Begin
          strSQL := strSQL + '  IFNULL(IF(D.DET_TAXCAM IS NOT NULL, (((' + strPreUni + '/IF(G.ITE_PRECOM IS NULL OR G.ITE_PRECOM = 0, ' + strPreUni + ', G.ITE_PRECOM) - 1) * 100)/D.DET_TAXCAM), ';
          strSQL := strSQL + '                               ((' + strPreUni + '/IF(G.ITE_PRECOM IS NULL OR G.ITE_PRECOM = 0, ' + strPreUni + ', G.ITE_PRECOM) - 1) * 100) ), 0) AS VARIAC, ';
        End;

        strSQL := strSQL + '  IFNULL( ';
        strSQL := strSQL + '    IF(IFNULL(DET_AUTELE, "") = "", ';
        strSQL := strSQL + '        (SELECT (PCD_UNITAR * (1 - IFNULL(PCD_DESUNI, 0) / 100)  ';
        strSQL := strSQL + '                             * (1 - IFNULL(PCD_DESUN2, 0) / 100) ';
        strSQL := strSQL + '                             * (1 - IFNULL(PCD_DESUN3, 0) / 100) ';
        strSQL := strSQL + '                             * (1 - IFNULL(PCD_DESUN4, 0) / 100) ';
        strSQL := strSQL + '                             * (1 - IFNULL(PCD_DESUN5, 0) / 100) ';
        strSQL := strSQL + '                             * (1 - IFNULL(PCD_DESUN6, 0) / 100) ';
        strSQL := strSQL + '       ) / IF((PCD_EMBALA IS NULL) OR (PCD_EMBALA = 0), 1, PCD_EMBALA) ';

        strSQL := strSQL + '         FROM PCMDET ';
        strSQL := strSQL + '         WHERE PCD_NUMPED = D.DET_PEDCOM AND ';
        strSQL := strSQL + '               PCD_CODITE = D.DET_CODITE AND ';
        strSQL := strSQL + '               PCD_CODEMP = D.DET_EMPCOM LIMIT 1), ';

        strSQL := strSQL + '                IFNULL( ';
        strSQL := strSQL + '                         (SELECT SUM(BAI_QTDPED * (( PCD_UNITAR * (1 - IFNULL(PCD_DESUNI, 0) / 100) * (1 - IFNULL(PCD_DESUN2, 0) / 100) ) / IF( IFNULL(PCD_EMBALA, 0) = 0, 1, PCD_EMBALA ) ) ) / SUM(BAI_QTDPED) ';
        strSQL := strSQL + '         FROM BAIPED ';
        strSQL := strSQL + '         INNER JOIN PCMDET PF ON BAI_AUTPED = PF.AUTOINCREM  WHERE BAI_AUTDET = D.AUTOINCREM), ';
        strSQL := strSQL + '                (SELECT SUM(DEF_QTDITE * ((PCD_UNITAR * (1 - IFNULL(PCD_DESUNI, 0) / 100) * (1 - IFNULL(PCD_DESUN2, 0)/100)) / IF(IFNULL(PCD_EMBALA, 0) = 0, 1 , PCD_EMBALA)) ) / SUM(DEF_QTDITE) ';
        strSQL := strSQL + '                 FROM DEFBAI ';
        strSQL := strSQL + '                 INNER JOIN PCMDET PF ON DEF_AUTPCD = PF.AUTOINCREM ';
        strSQL := strSQL + '                 WHERE DEF_AUTELE = DET_AUTELE))), ';
        strSQL := strSQL + '         0) AS UNIPED, ';  // VALOR UNITARIO DO PEDIDO DE COMPRA

        strSQL := strSQL + '  CAST("" AS CHAR(255)) AS CONPAG2, ';  // COND. PAGTO DO PEDIDO DE COMPRA - PESQUISADO PELO CAMPO PEDCOM NA HORA DA IMPRESSÃO

        strSQL := strSQL + '  IF(DET_AUTELE IS NULL,  ';

        strSQL := strSQL + '    IFNULL((SELECT GROUP_CONCAT(DISTINCT CONCAT(PCD_NUMPED, "-", PCD_CODEMP)) ';
        strSQL := strSQL + '            FROM   PCMDET ';

        strSQL := strSQL + '            INNER JOIN MOVDET DX ON  ';
        strSQL := strSQL + '                   PCD_NUMPED = DX.DET_PEDCOM AND ';
        strSQL := strSQL + '                   PCD_CODITE = DX.DET_CODITE AND ';
        strSQL := strSQL + '                   PCD_CODEMP = DX.DET_EMPCOM     ';

        strSQL := strSQL + '             WHERE DX.DET_SEQGER = D.DET_SEQGER),""), ';

        strSQL := strSQL + 'IFNULL( ';
        strSQL := strSQL + '          (SELECT GROUP_CONCAT(DISTINCT CONCAT(PG.PCG_NUMPED, "-", PG.PCG_CODEMP)) ';
        strSQL := strSQL + '             FROM BAIPED ';
        strSQL := strSQL + '            INNER JOIN PCMDET PD ON PD.AUTOINCREM = BAI_AUTPED ';
        strSQL := strSQL + '            INNER JOIN PCMGER PG ON PG.PCG_NUMPED = PD.PCD_NUMPED ';
        strSQL := strSQL + '                                AND PG.PCG_CODEMP = PD.PCD_CODEMP ';
        strSQL := strSQL + '                                AND PG.PCG_ESPDOC = "PD" ';
        strSQL := strSQL + '                                AND PG.PCG_NUMCTN = 0 ';
        strSQL := strSQL + '             WHERE BAI_AUTDET = D.AUTOINCREM), ';
        strSQL := strSQL + '             (SELECT GROUP_CONCAT(DISTINCT CONCAT(PG.PCG_NUMPED, "-", PG.PCG_CODEMP)) ';
        strSQL := strSQL + '                 FROM DEFBAI ';
        strSQL := strSQL + '                 INNER JOIN PCMGER PG ON PG.AUTOINCREM = DEF_AUTPCG ';
        strSQL := strSQL + '                 WHERE DEF_GERELE = (SELECT DE.DET_SEQGER FROM DETELE DE WHERE DE.AUTOINCREM = DET_AUTELE))) ';
        strSQL := strSQL + '             ) AS PEDCOM, ';

        strSQL := strSQL + '  IF(FISDOC.FIS_BASIC1 IS NULL, MOVGER.GER_BASICM, ' + SQL_SOMA_BASE_ICMS_LIVRO + ') AS GER_BASICM, ';
        strSQL := strSQL + '  IF(FISDOC.FIS_VLRIC1 IS NULL, MOVGER.GER_TOTICM, ' + SQL_SOMA_VALOR_ICMS_LIVRO + ') AS GER_TOTICM, ';

        strSQL := strSQL + '  GER_TOTPRO AS GERVLR, ';

        strSQL := strSQL + '  I.ITE_CLAIPI AS CLAIPI, ';

        strSQL := strSQL + '  CONCAT(PCG_OBSPD1, IF((PCG_OBSPD1 <> "") AND (PCG_OBSPD2 <> ""), " - ", ""), PCG_OBSPD2, IF(((PCG_OBSPD1 <> "") OR (PCG_OBSPD2 <> "")) AND (PCG_OBSPD3 <> ""), " - ", ""), PCG_OBSPD3) AS PCGOBS, ';

        strSQL := strSQL + '  IF(DET_AUTELE IS NULL,   ';
        strSQL := strSQL + '     IFNULL(               ';
        strSQL := strSQL + '             (SELECT GROUP_CONCAT(DISTINCT CONCAT(PCD_NUMPED, "-", PCD_CODEMP)) ';
        strSQL := strSQL + '                FROM PCMDET ';
        strSQL := strSQL + '               INNER JOIN MOVDET DX ON  ';
        strSQL := strSQL + '                     PCD_NUMPED = DX.DET_PEDCOM AND ';
        strSQL := strSQL + '                     PCD_CODITE = DX.DET_CODITE AND ';
        strSQL := strSQL + '                     PCD_CODEMP = DX.DET_EMPCOM     ';
        strSQL := strSQL + '               WHERE DX.DET_SEQGER = D.DET_SEQGER),""), ';
        strSQL := strSQL + '     IFNULL( ';
        strSQL := strSQL + '             (SELECT GROUP_CONCAT(DISTINCT CONCAT(PG.PCG_NUMPED, "-", PG.PCG_CODEMP)) ';
        strSQL := strSQL + '                FROM BAIPED                                                           ';
        strSQL := strSQL + '               INNER JOIN PCMDET PD ON PD.AUTOINCREM = BAI_AUTPED                     ';
        strSQL := strSQL + '               INNER JOIN PCMGER PG ON PG.PCG_NUMPED = PD.PCD_NUMPED                  ';
        strSQL := strSQL + '                                   AND PG.PCG_CODEMP = PD.PCD_CODEMP                  ';
        strSQL := strSQL + '                                   AND PG.PCG_ESPDOC = "PD"                           ';
        strSQL := strSQL + '                                   AND PG.PCG_NUMCTN = 0                              ';
        strSQL := strSQL + '                JOIN MOVDET MD ON MD.AUTOINCREM = BAI_AUTDET                          ';
        strSQL := strSQL + '   	           WHERE MD.DET_SEQGER = D.DET_SEQGER                                     ';
        strSQL := strSQL + '  	           /* GROUP BY BAI_AUTDET ORDER BY COUNT(*) DESC LIMIT 1 */),             ';
        strSQL := strSQL + '  	         (SELECT GROUP_CONCAT(DISTINCT CONCAT(PG.PCG_NUMPED, "-", PG.PCG_CODEMP)) ';
        strSQL := strSQL + '                FROM DEFBAI  ';
        strSQL := strSQL + '               INNER JOIN PCMGER PG ON PG.AUTOINCREM = DEF_AUTPCG ';
        strSQL := strSQL + '               WHERE DEF_GERELE = (SELECT DE.DET_SEQGER FROM DETELE DE WHERE DE.AUTOINCREM = DET_AUTELE))) ';
        strSQL := strSQL + '    ) AS PEDCOMDOC                                                            ';

        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  MOVDET D ';
        strSQL := strSQL + '  LEFT JOIN MOVICD ON MOVICD.ICD_SEQGER = D.AUTOINCREM ';
        strSQL := strSQL + '  LEFT JOIN CADITE I ON D.DET_CODITE = I.ITE_CODITE ';
        strSQL := strSQL + '  LEFT JOIN CADMAR M ON I.ITE_CODMAR = M.MAR_CODMAR ';
        strSQL := strSQL + '  LEFT JOIN CADFOR F ON D.DET_CODFOR = F.FOR_CODFOR ';
        strSQL := strSQL + '  LEFT JOIN CADOPE O ON D.DET_CODVEN = O.OPE_CODOPE ';
        strSQL := strSQL + '  LEFT JOIN ITEGER G ON D.DET_CODITE = G.ITE_CODITE AND D.DET_CODEMP = G.ITE_CODEMP ';
        strSQL := strSQL + '  LEFT JOIN CADUNI U ON D.DET_UNIDAD = U.UNI_CODUNI ';

        strSQL := strSQL + '  LEFT JOIN MOVGER ON D.DET_SEQGER  = MOVGER.AUTOINCREM ';

        strSQL := strSQL + '  LEFT JOIN CADLOT ON LOT_CODITE = DET_CODITE AND ';
        strSQL := strSQL + '                      LOT_CODEMP = DET_CODEMP AND ';
        strSQL := strSQL + '                      LOT_NUMLOT = IF((DET_NUMLOT = "A DEFINIR") AND ';
        strSQL := strSQL + '                                      ((SELECT TA.AUX_SEQDOR FROM AUXMOV AS TA WHERE TA.AUX_SEQDOR = MOVGER.AUTOINCREM LIMIT 1) IS NOT NULL), ';

        strSQL := strSQL + '                                      (SELECT TAD.DET_NUMLOT FROM AUXMOV AS TA ';
        strSQL := strSQL + '                                       INNER JOIN MOVDET TAD ON TAD.DET_SEQGER = TA.AUX_SEQGER AND TAD.DET_CLAFIS < 5000 ';
        strSQL := strSQL + '                                       WHERE TA.AUX_SEQDOR = MOVGER.AUTOINCREM AND TAD.DET_CODITE = D.DET_CODITE  ';
        strSQL := strSQL + '                                       AND TAD.DET_CODEMP = D.DET_CODEMP  LIMIT 1), ';

        strSQL := strSQL + '                                       DET_NUMLOT) ';

        strSQL := strSQL + '  LEFT JOIN AUXMOV ON AUX_SEQGER = MOVGER.AUTOINCREM ';

        strSQL := strSQL + '  LEFT JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ';

        strSQL := strSQL + '  LEFT JOIN CADFIS FISDOC ON FISDOC.FIS_NUMDOC = MOVGER.GER_NUMDOC AND ';
        strSQL := strSQL + '                             FISDOC.FIS_ESPDOC = MOVGER.GER_ESPDOC AND ';
        strSQL := strSQL + '                             FISDOC.FIS_CODEMP = MOVGER.GER_CODEMP AND ';
        strSQL := strSQL + '                             FISDOC.FIS_FORCLI = MOVGER.GER_CODFOR AND ';
        strSQL := strSQL + '                             IFNULL(FISDOC.FIS_SERIE_, "") = IFNULL(MOVGER.GER_SERIE_, "") AND ';
        strSQL := strSQL + '                             FISDOC.FIS_ENTSAI = "E" ';

        strSQL := strSQL + '  LEFT JOIN PCMDET ON D.DET_NUMDOC = PCMDET.PCD_DOCEMI ';
        strSQL := strSQL + '                  AND D.DET_ESPDOC = PCMDET.PCD_ESPEMI ';
        strSQL := strSQL + '                  AND D.DET_CODEMP = PCMDET.PCD_CODEMP ';
        strSQL := strSQL + '                  AND D.DET_CODITE = PCMDET.PCD_CODITE ';
        strSQL := strSQL + '                  AND D.DET_SERIE_ = PCMDET.PCD_SEREMI ';
        strSQL := strSQL + '  LEFT JOIN PCMGER ON PCMDET.PCD_NUMPED = PCMGER.PCG_NUMPED ';
        strSQL := strSQL + '                  AND PCMDET.PCD_ESPDOC = PCMGER.PCG_ESPDOC ';
        strSQL := strSQL + '                  AND PCMDET.PCD_CODEMP = PCMGER.PCG_CODEMP ';
        strSQL := strSQL + '                  AND PCMDET.PCD_CODFOR = PCMGER.PCG_CODFOR ';

        strSQL := strSQL + '  LEFT JOIN CADEMP ON D.DET_CODFOR = EMP_FORFIL ';
        strSQL := strSQL + '  LEFT JOIN CONEMP ON EMP_CODEMP = CON_EMPORI   ';
        strSQL := strSQL + '                  AND CON_EMPDES = :EMPLOG      ';

        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  D.DET_TIP_FC = "F" AND ';
        strSQL := strSQL + '  IFNULL(GER_ORIDOC,"") NOT IN ("V", "D") ';

        If Assigned(edtGruCmp) Then
          strSQL := strSQL + fStrLocate(edtGruCmp, arrGruCmp, 'I.ITE_GRUCMP', 'GRUCMP')
        Else
        If Not fEmptyStr(strGruCmp) Then
          strSQL := strSQL + '  AND I.ITE_GRUCMP = :GRUCMP ';

        If Not fEmptyStr(fTiraCaracEspeciais(strDtaIni)) Then
          strSQL := strSQL + '  AND D.DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

        If Not fEmptyStr(strCodEmp) Then
          strSQL := strSQL + '  AND DET_CODEMP = :CODEMP '
        Else
          strSQL := strSQL + ' AND DET_CODEMP IN (' + fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ')';

        If Assigned(edtFornec) Then
          strSQL  := strSQL   + fSQLIn(edtFornec, arrFornec, 'D.DET_CODFOR', 'CODFOR')
        else
          If Not fEmptyStr(strCodFor) Then
            strSQL := strSQL + '  AND DET_CODFOR = :CODFOR ';

        If Not fEmptyStr(strNumDoc) Then
          strSQL := strSQL + '  AND DET_NUMDOC = :NUMDOC ';

        If Not fEmptyStr(strEspDoc) Then
          strSQL := strSQL + '  AND DET_ESPDOC = :ESPDOC ';

        If (Not fEmptyStr(strSerie)) Or blnCancel Then
          strSQL := strSQL + '  AND IFNULL(DET_SERIE_, "") = :SERIE_ ';

        If Not blnTransf Then
          strSQL := strSQL + '  AND DET_CODFOR NOT IN (' + fRetStrToSQLIn(fRetForFilialTodos) + ') ';

        Case intOpcCfop Of
          1 : strSQL := strSQL + '  AND LOCATE(GER_CLAFIS,' + QuotedStr(VS_strClaCom) + ') > 0 ';
          2 : strSQL := strSQL + '  AND LOCATE(GER_CLAFIS, "1910_2910_" ) > 0 ';
        End;
        If Assigned(edtProduto) Then
          strSQL  := strSQL   + fSQLIn(edtProduto, arrProduto, 'G.ITE_CODITE', 'CODITE');

        strSQL  := strSQL   + ' GROUP BY D.AUTOINCREM ';

        strSQL := strSQL + ' ORDER BY ';

        If strOrdenar = 'D' Then
          strSQL := strSQL + '   DTAENT, ';

        strSQL := strSQL + '   CODFOR, ';
        strSQL := strSQL + '   NUMDOC, ';
        strSQL := strSQL + '   ESPDOC, ';
        strSQL := strSQL + '   SERIE_, ';

        If strOrdenarProd = 'G' Then
          strSQL := strSQL + '   AUTINC '
        Else
          strSQL := strSQL + '   DESITE ';

        With qryEspNota Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);

          ParamByName('EMPLOG').AsString := VS_strCodEmp;

          If Not fEmptyStr(fTiraCaracEspeciais(strDtaIni)) Then
          Begin
            ParamByName('DTAINI').AsDate   := StrToDate(strDtaIni);
            ParamByName('DTAFIN').AsDate   := StrToDate(strDtaFin);
          End;

          If Not fEmptyStr(strCodEmp) Then
            ParamByName('CODEMP').AsString := strCodEmp;

          If Assigned(edtFornec) Then
             pSetaParam(TEdit(edtFornec).Text, arrFornec, strCodFornec, 'CODFOR', qryEspNota)
          else
            If Not fEmptyStr(strCodFor) Then
              ParamByName('CODFOR').AsString := strCodFor;

          If Not fEmptyStr(strNumDoc) Then
            ParamByName('NUMDOC').AsString := strNumDoc;

          If Not fEmptyStr(strEspDoc) Then
            ParamByName('ESPDOC').AsString := strEspDoc;

          If (Not fEmptyStr(strSerie)) Or blnCancel Then
            ParamByName('SERIE_').AsString := strSerie;

          If Assigned(edtProduto) Then
             pSetaParam(TEdit(edtProduto).Text, arrProduto, strCodPro, 'CODITE', qryEspNota);

          If Params.FindParam('PEDCOM') <> Nil Then
          Begin
            ParamByName('PEDCOM').AsString  := fRetPedCom(strPedidos, strConPag2);
            ParamByName('CONPAG2').AsString := strConPag2;
          End;

          If Assigned(edtGruCmp) Then
            pSetaParam(TEdit(edtGruCmp).Text, arrGruCmp, strGruCmp, 'GRUCMP', qryEspNota)
          Else
          If Not fEmptyStr(strGruCmp) Then
            ParamByName('GRUCMP').AsString := strGruCmp;

          Open;

          If Not IsEmpty Then
          Begin
            frmQckEspelhoNota := TfrmQckEspelhoNota.Create(self);

            If Not Assigned(objLisFre) Then
              objLisFre := TFreConLista.Create(Self, False, False);

            frmQckEspelhoNota.objLisFre              := objLisFre;
            frmQckEspelhoNota.frxDBConFre.DataSource := objLisFre.dtsSource;

            frmQckEspelhoNota.intOpc         := intOpc;
            frmQckEspelhoNota.frxRelatorio.DataSet := qryEspNota;
            frmQckEspelhoNota.strTipCalc     := strTipCalc;
            frmQckEspelhoNota.strTipImp      := strTipImp;
            frmQckEspelhoNota.intOpcSelec    := intOpc;
            frmQckEspelhoNota.strCodEmp      := strCodEmp;
            frmQckEspelhoNota.strFrase       := IIF(intOpcVariacao=1, ' * (Valores de IPI E ST apenas informativos)', '');
            frmQckEspelhoNota.intOpcVariacao := intOpcVariacao;
            frmQckEspelhoNota.objEspNot      := Self;

            {******************************************************}
            {* DEFINE SE O RELATORIO É MATRICIAL OU JATO DE TINTA *}
            {***************************************************JC*}
            If SameText(strTipImp, 'M') Then
            Begin
              If (blnPreVen And (strTabPre <> '')) Or
                 (blnQtdCmp And (strTabPre <> '')) Then
                frxRel := frmQckEspelhoNota.frxRelEspelhoComPrecosM
              Else
                frxRel := frmQckEspelhoNota.frxRelEspelhoNotaM;
            End
            Else
            Begin
              If (blnPreVen And (strTabPre <> '')) Or
                 (blnQtdCmp And (strTabPre <> '')) Then
                frxRel := frmQckEspelhoNota.frxRelEspelhoComPrecosJ
              Else
                frxRel := frmQckEspelhoNota.frxRelEspelhoNotaJ;
              frxRel.DotMatrixReport           := False;
              frxRel.PrintOptions.PrintMode    := pmScale;
              frxRel.PrintOptions.PrintOnSheet := 9;
            End;

            If intOpcUnit = 1 Then
            Begin
              frxRel.FindObject('mmoTitDocDesEsp').Visible  := False;
              frxRel.FindObject('mmoDocDesEsp').Visible     := False;
              frxRel.FindObject('mmoTitForDesEsp').Visible  := False;
              frxRel.FindObject('mmoForDesEsp').Visible     := False;
              frxRel.FindObject('mmoTitTotDesEsp').Visible  := False;
              frxRel.FindObject('mmoTotDesEsp').Visible     := False;
            End;

            frxRel.Script.Variables['blnVariacao'] := blnVariacao;

            If intOpc = 1 Then
            Begin
              TfrxMemoView(frxRel.FindObject('rlbBasIcm')).Memo.Clear;
              TfrxMemoView(frxRel.FindObject('rlbBasIcm')).Memo.Add('[frxRelatorio."GER_BASICM"]');

              TfrxMemoView(frxRel.FindObject('rlbBasIcmFor')).Memo.Clear;
              TfrxMemoView(frxRel.FindObject('rlbBasIcmFor')).Memo.Add('[fltBasIcmFor]');

              TfrxMemoView(frxRel.FindObject('rlbBasIcmTot')).Memo.Clear;
              TfrxMemoView(frxRel.FindObject('rlbBasIcmTot')).Memo.Add('[fltBasIcmTot]');

              TfrxMemoView(frxRel.FindObject('rlbValIcm')).Memo.Clear;
              TfrxMemoView(frxRel.FindObject('rlbValIcm')).Memo.Add('[frxRelatorio."GER_TOTICM"]');

              TfrxMemoView(frxRel.FindObject('rlbValIcmFor')).Memo.Clear;
              TfrxMemoView(frxRel.FindObject('rlbValIcmFor')).Memo.Add('[fltValIcmFor]');

              TfrxMemoView(frxRel.FindObject('rlbValIcmTot')).Memo.Clear;
              TfrxMemoView(frxRel.FindObject('rlbValIcmTot')).Memo.Add('[fltValIcmTot]');

              TfrxMemoView(frxRel.FindObject('rllPedCom')).Memo.Clear;
              TfrxMemoView(frxRel.FindObject('rllPedCom')).Memo.Add('Pedido de Compra: [<frxRelatorio."PEDCOMDOC">]');
            End;

            pAjustaRelatorio(frxRel, strDtaIni, strDtaFin, intOpc, blnEfetua, blnQtdCmp, strTabPre, blnDevolu);

            TfrxDMPMemoView(frxRel.FindObject('rllMensagemRodape')).Visible := (intOpc in [2,3]);

            if blnObsCom then
            begin
              TfrxMemoView(frxRel.FindObject('mmoPcgObs')).Visible := True;
              TfrxMasterData(frxRel.FindObject('rlbDetGrupo')).Height := TfrxMemoView(frxRel.FindObject('mmoPcgObs')).Height * 2;
            end
            else
            begin
              TfrxMemoView(frxRel.FindObject('mmoPcgObs')).Visible := False;
              TfrxMasterData(frxRel.FindObject('rlbDetGrupo')).Height := TfrxMemoView(frxRel.FindObject('mmoPcgObs')).Height;
            end;

            frxRel.Script.Variables['blnDedFre'] := blnDedFre;

            If strDestino = 'V' Then
              pPreviewReport('frmRelEspNotaEnt', 'Espelho de nota de entrada', frxRel)
            Else If frxRel.PrepareReport Then
            Begin
              frxRel.PrintOptions.Printer := strNomImp;
              frxRel.PrintOptions.ShowDialog := strNomImp.IsEmpty;
              pPrintReport('frmRelEspNotaEnt', 'Espelho de nota de entrada', strNomImp, frxRel);
            End;

            pDestroiModulo(frmQckEspelhoNota);

            Result := True;

            FreeAndNil(objLisFre);
          End;

        End;
      End;


    3:
      Begin
        Case intOpcUnit Of
          1:   Begin
                 strPreUni := ' ((ENT_TOTITE - ENT_DESESP) / ENT_QTDITE) ';
                 strTotIte := ' (ENT_TOTITE - ENT_DESESP) ';
                 strDesEsp := ' 0 ';
               End;
          Else Begin
                 strPreUni := ' ENT_UNITAR ';
                 strTotIte := ' ENT_TOTITE ';
                 strDesEsp := ' ENT_DESESP ';
               End;
        End;

        For intCorre := Low(ARR_CFG_COMP_CUSTO_CAMPOS) to High(ARR_CFG_COMP_CUSTO_CAMPOS) Do
        Begin
          strPreCus := ReplaceStr(strPreCus, ARR_CFG_COMP_CUSTO_CAMPOS[intCorre], ARR_CFG_COMP_CUSTO_CAMPOS_ESPELHO[intCorre]  );
        End;

        If Assigned(objVendor) Then
          objVendor.fRateiaVendor;

        If Assigned(objOutDes) Then
          If Not objOutDes.blnRateioManual Then
            objOutDes.fRateiaOutrasDespesas;

        {******************************************************}
        {* OPÇÃO ESPELHO DA NOTA ENTRADA DADOS FISCAIS RESUMO *}
        {***************************************************JC*}

        Result := False;

        strSQL := '';
        strSQL := strSQL + 'SELECT ';
        strSQL := strSQL + '  "" AS AUTGER, ';
        strSQL := strSQL + '  CONCAT('+QuotedStr(strNumDoc+strEspDoc+strSerie)+', ' + IIF(Assigned(edtFornec), 'F.FOR_CODFOR', QuotedStr(strCodFor)) + ') AS QUEBRA, ';//CAMPO PARA QUEBRA NO RELATORIO
        strSQL := strSQL + '  :NUMDOC AS NUMDOC, '; //NUMERO DO DOCUMENTO
        strSQL := strSQL + '  FOR_NOMFOR AS NOMFOR, '; //NOME DO FORNECEDOR
        strSQL := strSQL + '  IF(FOR_CGCCPF IS NULL OR FOR_CGCCPF = "", 0, FOR_CGCCPF) AS CGCCPF, '; //CNPJ OU CPF TIPO
        strSQL := strSQL + '  FOR_C_G_C_ AS _C_G_C, '; //CNPJ PU CPF NUMERO

        strSQL := strSQL + '  :CODEMP AS CODEMP, '; //EMPRESA DO DOCUMENTO strCodEmp
        strSQL := strSQL + '  :ESPDOC AS ESPDOC, '; //ESPECIE DO DOCUMENTO QuotedStr(strEspDoc)
        strSQL := strSQL + '  :SERIE_ AS SERIE_, '; //SERIE DO DOCUMENTO QuotedStr(strSerie)
        strSQL := strSQL + IIF(Assigned(edtFornec), 'F.FOR_CODFOR', ':CODFOR') + ' AS CODFOR, '; //CODIGO DO FORNECEDOR QuotedStr(strCodFor)
        strSQL := strSQL + '  CAST(:DTAENT AS DATE) AS DTAENT, '; //DATA DE ENTRADA dtaDtaEnt)
        strSQL := strSQL + '  CAST(:DTADOC AS DATE) AS DTADOC, '; //DATA DO DOCUMENTO dtaDtaDoc)
        strSQL := strSQL + '  :CONPAG AS CONPAG, '; //COND. PAGAMENTO QuotedStr(mskCndPag.Text)
        strSQL := strSQL + '  ' + QuotedStr(strCodOpe) + ' AS CODVEN, '; //CODIGO DO OPERADOR
        strSQL := strSQL + '  ' + QuotedStr(strNomOpe) + ' AS NOMVEN, '; //NOME DO OPERADOR

        If intOpcVariacao = 0 Then
        Begin
        //  strSQL := strSQL + '  ROUND(' + strTotIte + '/ ' + fSQLQtd + ' ,4) AS UNITAR, '; //VALOR UNITARIO DO ITEM

          strSQL := strSQL +   strPreUni + ' / IF(ENT_EMBALA IS NULL OR ENT_EMBALA = 0, 1, ENT_EMBALA) AS UNITAR, '; //VALOR UNITARIO DO ITEM
          strSQL := strSQL +   strTotIte + ' AS TOTITE, '; //TOTAL DOS ITEMS
          strSQL := strSQL + '  G.ITE_PRECOM AS PRECOM, '; //PREÇO DE COMPRA
        End
        Else
        Begin
          If intOpcVariacao = 2 Then
          Begin
            strSQL := strSQL + '  ROUND((' + fSql_TOTITE_ENT_VARIACAO_COM_IMPOSTOS_OPC2 + ')/' + fSQLQtd + ', 4) AS UNITAR, '; //VALOR UNITARIO DO ITEM
            strSQL := strSQL + '  (' + fSql_TOTITE_ENT_VARIACAO_COM_IMPOSTOS_OPC2 + ') AS TOTITE, '; //TOTAL DOS ITEMS
          End Else
          Begin
            strSQL := strSQL + '  ROUND((' + fSql_TOTITE_ENT_VARIACAO_COM_IMPOSTOS + ')/' + fSQLQtd + ', 2) AS UNITAR, '; //VALOR UNITARIO DO ITEM
            strSQL := strSQL + '  (' + fSql_TOTITE_ENT_VARIACAO_COM_IMPOSTOS + ') AS TOTITE, '; //TOTAL DOS ITEMS
          End;
          strSQL := strSQL + '  G.ITE_IMPULT AS PRECOM, '; //PREÇO DE COMPRA
        End;

        strSQL := strSQL + '  ROUND(' + strTotIte + ' / ' + fSQLQtd + ' ,4) AS UNITAR_IMP, '; //VALOR UNITARIO DO ITEM
        strSQL := strSQL + strTotIte + ' AS TOTITE_IMP, '; //TOTAL DOS ITEMS

        strSQL := strSQL + '  ENT_VALIPI + IFNULL(ENT_VAEIPI, 0) AS VALIPI, '; //TOTAL IPI
        strSQL := strSQL + '  ENT_VALRET + IFNULL(ENT_VAERET, 0) AS VALRET, '; //TOTAL SUBST.
        strSQL := strSQL + '  ENT_VALFRE AS TOTFRE, '; //TOTAL DE FRETE
        strSQL := strSQL + '  ENT_DESACE AS DESACE, '; //DESPESAS ACESSORIAS
        strSQL := strSQL + strDesEsp + ' AS DESESP, '; //TOTAL DE DESCONTO

        If intOpcVariacao = 2 Then
          strSQL := strSQL + '  ENT_VLRCON + IFNULL(ENT_FRECON, 0) + IFNULL(ENT_FRERPA, 0) + IFNULL(ENT_VENDOR, 0) + IFNULL(ENT_OUTDES, 0) + IFNULL(ENT_VALGNR, 0) AS VLRCON, ' //TOTAL DOS ITEMS C/ IMPOSTO
        Else
          strSQL := strSQL + '  ENT_VLRCON AS VLRCON, '; //TOTAL DOS ITEMS C/ IMPOSTO

        strSQL := strSQL + '  ENT_FRECON AS FRECON,     ';
        strSQL := strSQL + '  ENT_FRERPA AS FRERPA,     ';
        strSQL := strSQL + '  ENT_VAFRAN AS VAFRAN,     ';

        strSQL := strSQL + strTotIte + ' AS TOTITE_TOT, '; //TOTAL DOS ITEMS PARA O TOTALIZADOR GERAL
        strSQL := strSQL +  ' ENT_VFCPST AS VFCPST, ';
        strSQL := strSQL + '  ENT_VLRCON AS VLRCON_TOT, '; //TOTAL DOS ITEMS PARA O TOTALIZADOR GERAL C/ IMPOSTO

        strSQL := strSQL + '  ENT_DESITE AS DESITE, '; //DESCRICAO DO ITEM
        strSQL := strSQL + '  ENT_REFERE AS REFERE, '; //REFERENCIA DO ITEM
        strSQL := strSQL + '  ENT_CODITE AS CODITE, '; //CODIGO DO ITEM
        strSQL := strSQL + '  ENT_NUMLOT AS NUMLOT, '; //LOTE DO ITEM
        strSQL := strSQL + '  ENT_CODGRU AS CODGRU, '; //CODIGO DO GRUPO
        strSQL := strSQL + '  U.UNI_SIGUNI AS UNIDAD, '; //SIGLA DA UNIDADE
        strSQL := strSQL + '  ENT_CODUNI AS UNIDAD, '; //CODIGO DA UNIDADE
        strSQL := strSQL + '  I.ITE_CODMAR AS CODMAR, '; //CODIGO DA MARCA
        strSQL := strSQL + '  I.ITE_CODFAB AS CODFAB, '; //CÓDIGO DE FÁBRICA DO ITEM
        strSQL := strSQL + '  MAR_DESMAR AS DESMAR, '; //DESCRICAO DA MARCA
        strSQL := strSQL + '  ' + fSQLQtd + ' AS QTDITE, '; //QUANTIDADE DE ITENS
        strSQL := strSQL + '  G.ITE_DESF01 AS DESF01, '; //DESCONTO
        strSQL := strSQL + '  G.ITE_DESF02 AS DESF02, '; //DESCONTO
        strSQL := strSQL + '  G.ITE_DESF03 AS DESF03, '; //DESCONTO
        strSQL := strSQL + '  G.ITE_DESF04 AS DESF04, '; //DESCONTO
        strSQL := strSQL + '  G.ITE_DESF05 AS DESF05, '; //DESCONTO
        strSQL := strSQL + '  G.ITE_DESF06 AS DESF06, '; //DESCONTO
        strSQL := strSQL + '  G.ITE_ACRFIN AS ACRFIN, '; //ACRESCIMO FINANCEIRO
        strSQL := strSQL + '  IF(IFNULL(ENT_NUMLOT, "") = "", G.ITE_LOCFIS, LOT_LOCFIS) AS LOCFIS, '; //LOCALIZACAO FISICA
        strSQL := strSQL + '  ENT_BASICM AS BASICM, '; //BC. ICMS
        strSQL := strSQL + '  ENT_VALICM AS VALICM, '; //VR. ICMS
        strSQL := strSQL + '  IFNULL(ENT_BASRET,0) + IFNULL(ENT_BAERET,0) AS BASRET, '; //BC. SUBST.
        strSQL := strSQL + '  ENT_BASIPI + IFNULL(ENT_BAEIPI, 0) AS BASIPI, '; //BC. IPI
        strSQL := strSQL + '  ENT_ALQIPI + IFNULL(ENT_ALEIPI, 0) AS ALQIPI, '; //ALQ. IPI
        strSQL := strSQL + '  ENT_ALQICM AS ALQICM, '; //ALQ. ICMS
        strSQL := strSQL + '  ENT_CODFIS AS CODFIS, '; //COD. FIS.

        If not fEmptyStr(strTabPre) Then
        Begin
          strSQL := strSQL + '  G.ITE_PREVE' + strTabPre + ' AS PREVEN, ';
          strSQL := strSQL + '  G.ITE_MARBR' + strTabPre + ' AS MARBRU, ';
        End;
        
        If blnPreVen And (strTabPre <> '') Then
        Begin
          If intOpcVariacao = 2 Then
            strSQL := strSQL + '  ROUND((' + fSql_TOTITE_ENT_VARIACAO_COM_IMPOSTOS_OPC2 + ')/' + fSQLQtd + ', 2) AS PRECUS, ' //VALOR UNITARIO DO ITEM
          Else
          If not fEmptyStr(strPreCus) Then
            strSQL := strSQL + strPreCus + ' AS PRECUS, '
          Else Begin
            strSQL := strSQL + '  G.ITE_PRECUS AS PRECUS, ';
            blnPrecoCustoCadastro := True;
          End;

          strSQL := strSQL + '  G.ITE_ICMSAI AS ICMSAI, ';
          strSQL := strSQL + '  G.ITE_IMPFED AS IMPFED, ';
          strSQL := strSQL + '  G.ITE_DESOPE AS DESOPE, ';
          strSQL := strSQL + '  G.ITE_OUTVAL AS OUTVAL, ';
        End;

        If blnQtdCmp And (strTabPre <> '') Then
        Begin
          strSQL := strSQL + '  IFNULL((SELECT SUM(PCD_QTDITE * IF((PCD_EMBALA IS NULL) OR (PCD_EMBALA = 0), 1, PCD_EMBALA)) ';
          strSQL := strSQL + '          FROM PCMDET ';
          strSQL := strSQL + '          WHERE PCD_NUMPED ' + fRetornaFiltroPedidosOpcao3(strPedidos) + ' AND ';
          strSQL := strSQL + '                PCD_CODITE = ENT_CODITE AND ';
          strSQL := strSQL + '                PCD_CODEMP = ENT_CODEMP LIMIT 1),0) AS QTDCMP, ';  // QUANTIDADE DO PRODUTO NO PEDIDO DE COMPRA

          If not fEmptyStr(strPreCus) Then
            strSQL := strSQL + strPreCus + ' AS PRECUS, '
          Else Begin
            strSQL := strSQL + '  G.ITE_PRECUS AS PRECUS, ';
            blnPrecoCustoCadastro := True;
          End;

          strSQL := strSQL + '  G.ITE_ICMSAI AS ICMSAI, ';
          strSQL := strSQL + '  G.ITE_IMPFED AS IMPFED, ';
          strSQL := strSQL + '  G.ITE_DESOPE AS DESOPE, ';
          strSQL := strSQL + '  G.ITE_OUTVAL AS OUTVAL, ';
          strSQL := strSQL + '  G.ITE_PREVE' + strTabPre + ' AS PREVEN, ';
          strSQL := strSQL + '  G.ITE_MARBR' + strTabPre + ' AS MARBRU, ';
        End;

        strSQL := strSQL + QuotedStr(strClaFis) + ' AS CLAFIS, ';

        strSQL := strSQL + '  ""         AS SEQGER, ';
        strSQL := strSQL + '  (' + strPreUni + '/IF(G.ITE_PRECOM IS NULL OR G.ITE_PRECOM = 0, ' + strPreUni + ', G.ITE_PRECOM) - 1) * 100 AS VARIAC, ';

        strSQL := strSQL + '  IFNULL(                          ';
        strSQL := strSQL + '    IF(IFNULL(ENT_DETELE, "") = "",    ';

        strSQL := strSQL + '        (SELECT (PCD_UNITAR ';
        strSQL := strSQL + '                    * (1 - IFNULL(PCD_DESUNI, 0) / 100) ';
        strSQL := strSQL + '                    * (1 - IFNULL(PCD_DESUN2, 0) / 100) ';
        strSQL := strSQL + '                    * (1 - IFNULL(PCD_DESUN3, 0) / 100) ';
        strSQL := strSQL + '                    * (1 - IFNULL(PCD_DESUN4, 0) / 100) ';
        strSQL := strSQL + '                    * (1 - IFNULL(PCD_DESUN5, 0) / 100) ';
        strSQL := strSQL + '                    * (1 - IFNULL(PCD_DESUN6, 0) / 100) ';
        strSQL := strSQL + '          ) / IF(IFNULL(PCD_EMBALA, 0) = 0, 1 , PCD_EMBALA) ';

        strSQL := strSQL + '         FROM PCMDET ';
        strSQL := strSQL + '         WHERE PCD_NUMPED = ENT_NUMPED AND ';
        strSQL := strSQL + '               PCD_CODITE = ENT_CODITE AND ';
        strSQL := strSQL + '               PCD_CODEMP = ENT_CODEMP LIMIT 1), ';

        strSQL := strSQL + '        (SELECT SUM(DEF_QTDITE * ((PCD_UNITAR * (1 - IFNULL(PCD_DESUNI, 0) / 100) * (1 - IFNULL(PCD_DESUN2, 0)/100)) / IF(IFNULL(PCD_EMBALA, 0) = 0, 1 , PCD_EMBALA)) ) / SUM(DEF_QTDITE) ';
        strSQL := strSQL + '         FROM DEFBAI ';
        strSQL := strSQL + '         INNER JOIN PCMDET PF ON DEF_AUTPCD = PF.AUTOINCREM ';
        strSQL := strSQL + '         WHERE DEF_AUTELE = ENT_DETELE)), ';

        strSQL := strSQL + '         0) AS UNIPED, ';  // VALOR UNITARIO DO PEDIDO DE COMPRA

        strSQL := strSQL + '  :CONPAG2 AS CONPAG2, ';
        strSQL := strSQL + '  :PEDCOM  AS PEDCOM, ';
        strSQL := strSQL + '  :PEDCOM  AS PEDCOMDOC, ';
        strSQL := strSQL + '  ' + IntToStr(intModFre) + ' AS MODFRE, ';

        strSQL := strSQL + '  0.00 AS GER_BASICM, ';
        strSQL := strSQL + '  0.00 AS GER_TOTICM, ';

        strSQL := strSQL + '  0.00 AS GERVLR, ';

        strSQL := strSQL + '  ENT_CLAIPI AS CLAIPI, ';

        strSQL := strSQL + '  IFNULL((SELECT CONCAT(PCG_OBSPD1, IF((PCG_OBSPD1 <> "") AND (PCG_OBSPD2 <> ""), " - ", ""), PCG_OBSPD2, IF(((PCG_OBSPD1 <> "") OR (PCG_OBSPD2 <> "")) AND (PCG_OBSPD3 <> ""), " - ", ""), PCG_OBSPD3) ';
        strSQL := strSQL + '          FROM PCMDET ';
        strSQL := strSQL + '  LEFT JOIN PCMGER ON PCMDET.PCD_NUMPED = PCMGER.PCG_NUMPED ';
        strSQL := strSQL + '                  AND PCMDET.PCD_ESPDOC = PCMGER.PCG_ESPDOC ';
        strSQL := strSQL + '                  AND PCMDET.PCD_CODEMP = PCMGER.PCG_CODEMP ';
        strSQL := strSQL + '                  AND PCMDET.PCD_CODFOR = PCMGER.PCG_CODFOR ';
        strSQL := strSQL + '          WHERE PCD_NUMPED = ENT_NUMPED AND ';
        strSQL := strSQL + '                PCD_CODITE = ENT_CODITE AND ';
        strSQL := strSQL + '                PCD_CODEMP = ENT_CODEMP LIMIT 1),"") AS PCGOBS ';

        strSQL := strSQL + 'FROM                   ';
        strSQL := strSQL + '  TMP_ENTMER           ';
        strSQL := strSQL + 'INNER JOIN CADITE I ON ENT_CODITE = I.ITE_CODITE  ';

        If Assigned(edtFornec) Then
          strSQL := strSQL + 'INNER JOIN CADFOR F ON (TRUE ' + fStrLocate(edtFornec, arrFornec, 'F.FOR_CODFOR', 'CODFOR')
        else
          strSQL := strSQL + 'INNER JOIN CADFOR ON :CODFOR = FOR_CODFOR         ';

        strSQL := strSQL + 'INNER JOIN ITEGER G ON I.ITE_CODITE = G.ITE_CODITE AND G.ITE_CODEMP = :CODEMP ';
        strSQL := strSQL + 'INNER JOIN CADUNI U ON ENT_CODUNI = U.UNI_CODUNI  ';
        strSQL := strSQL + 'INNER JOIN CADMAR ON ITE_CODMAR = MAR_CODMAR      ';
        strSQL := strSQL + 'LEFT JOIN CADLOT ON LOT_CODITE = ENT_CODITE AND   ';
        strSQL := strSQL + '                    LOT_CODEMP = ENT_CODEMP AND   ';
        strSQL := strSQL + '                    LOT_NUMLOT = ENT_NUMLOT       ';
        If Assigned(edtProduto) Then
           strSQL     := strSQL   + fStrLocate(edtProduto, arrProduto, 'G.ITE_CODITE', 'CODITE');

        strSQL := strSQL + '  LEFT JOIN CADEMP ON ' + IIF(Assigned(edtFornec), 'F.FOR_CODFOR', ':CODFOR') + ' = EMP_FORFIL ';
        strSQL := strSQL + '  LEFT JOIN CONEMP ON EMP_CODEMP = CON_EMPORI   ';
        strSQL := strSQL + '                  AND CON_EMPDES = :EMPLOG      ';

        strSQL := strSQL + ' WHERE TRUE ';

        Case intOpcCfop of
          1 : strSQL := strSQL + ' AND  LOCATE(ENT_CLAFIS,' + QuotedStr(VS_strClaCom) + ') > 0 ';
          2 : strSQL := strSQL + ' AND  LOCATE(ENT_CLAFIS, "1910_2910_" ) > 0 ';
        End;

        If Assigned(edtGruCmp) Then
          strSQL := strSQL + fStrLocate(edtGruCmp, arrGruCmp, 'I.ITE_GRUCMP','GRUCMP')
        Else
          If not fEmptyStr(strGruCmp) Then
          strSQL := strSQL + '  AND I.ITE_GRUCMP = :GRUCMP ';

        strSQL := strSQL + ' ORDER BY ';
        If fEmptyStr(strOrdIte) Then
        Begin
          If strOrdenar = 'D' Then
            strSQL := strSQL + '   DTAENT, ';

          strSQL := strSQL + '   CODFOR, ';
          strSQL := strSQL + '   NUMDOC, ';
          strSQL := strSQL + '   ESPDOC,  ';

        If strOrdenarProd = 'G' Then
          strSQL := strSQL + '   TMP_ENTMER.AUTOINCREM '
        Else
          strSQL := strSQL + '   DESITE ';
        End
        Else
          strSQL := strSQL + strOrdIte;

        If (Pos('ENT_PERPIS', strPreCus) > 0) Or (Pos('ENT_PERCOF', strPreCus) > 0) Then
          pAtualizaPisCofinsEntrada;

        With qryEspNota Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);

          ParamByName('EMPLOG').AsString := VS_strCodEmp;

          ParamByName('CODEMP').AsString := strCodEmp;
          ParamByName('ESPDOC').AsString := strEspDoc;
          ParamByName('SERIE_').AsString := strSerie;

          If Assigned(edtFornec) Then
            pSetaParam(TEdit(edtFornec).Text, arrFornec, strCodFornec, 'CODFOR', qryEspNota)
          else
            ParamByName('CODFOR').AsString := strCodFor;

          ParamByName('DTAENT').AsDate   := StrToDate(strDtaEnt);
          ParamByName('DTADOC').AsDate   := StrToDate(strDtaDoc);
          ParamByName('CONPAG').AsString := strCndPag;
          ParamByName('NUMDOC').AsString := strNumDoc;

          If Assigned(edtProduto) Then
             pSetaParam(TEdit(edtProduto).Text, arrProduto, strCodPro, 'CODITE', qryEspNota);

          If Assigned(edtGruCmp) Then
            pSetaParam(TEdit(edtGruCmp).Text, arrGruCmp, strGruCmp, 'GRUCMP', qryEspNota)
          Else
          If Not fEmptyStr(strGruCmp) Then
            ParamByName('GRUCMP').AsString := strGruCmp;

          If Params.FindParam('PEDCOM') <> Nil Then
          Begin
            ParamByName('PEDCOM').AsString  := fRetPedCom(strPedidos, strConPag2);
            ParamByName('CONPAG2').AsString := strConPag2;
          End;

          Open;
        End;

        If Not qryEspNota.IsEmpty Then
        Begin
          Try
            frmQckEspelhoNota := TfrmQckEspelhoNota.Create(self);

            frmQckEspelhoNota.intOpc         := intOpc;

            frmQckEspelhoNota.objLisFre      := objLisFre;
            frmQckEspelhoNota.frxDBConFre.DataSource := objLisFre.dtsSource;

            frmQckEspelhoNota.objVendor      := objVendor;
            frmQckEspelhoNota.objOutDes      := objOutDes;
            frmQckEspelhoNota.frxRelatorio.DataSet := qryEspNota;
            frmQckEspelhoNota.strTipCalc     := strTipCalc;
            frmQckEspelhoNota.strTipImp      := fCfgSis('TIPIMP');
            frmQckEspelhoNota.arrParcelas    := arrParcelas;
            frmQckEspelhoNota.strCodEmp      := strCodEmp;
            frmQckEspelhoNota.strFrase       := IIF(intOpcVariacao=1, ' * (Valores de IPI E ST apenas informativos)', '');
            frmQckEspelhoNota.intOpcVariacao := intOpcVariacao;
            frmQckEspelhoNota.objEspNot      := Self;

            {******************************************************}
            {* DEFINE SE O RELATORIO É MATRICIAL OU JATO DE TINTA *}
            {***************************************************JC*}
            If (strTipImp = 'M') Then
            Begin
              If (blnPreVen And (strTabPre <> '')) Or
                 (blnQtdCmp And (strTabPre <> '')) Then
                frxRel := frmQckEspelhoNota.frxRelEspelhoComPrecosM
              Else
                frxRel := frmQckEspelhoNota.frxRelEspelhoNotaM;
            End
            Else
            Begin
              If (blnPreVen And (strTabPre <> '')) Or
                 (blnQtdCmp And (strTabPre <> '')) Then
                frxRel := frmQckEspelhoNota.frxRelEspelhoComPrecosJ
              Else
                frxRel := frmQckEspelhoNota.frxRelEspelhoNotaJ;
              frxRel.DotMatrixReport           := False;
              frxRel.PrintOptions.PrintMode    := pmScale;
              frxRel.PrintOptions.PrintOnSheet := 9;
            End;

            If intOpcUnit = 1 Then
            Begin
              frxRel.FindObject('mmoTitDocDesEsp').Visible  := False;
              frxRel.FindObject('mmoDocDesEsp').Visible     := False;
              frxRel.FindObject('mmoTitForDesEsp').Visible  := False;
              frxRel.FindObject('mmoForDesEsp').Visible     := False;
              frxRel.FindObject('mmoTitTotDesEsp').Visible  := False;
              frxRel.FindObject('mmoTotDesEsp').Visible     := False;
            End;

            pMontaGNRE(intOpc, frmQckEspelhoNota, frxRel, objGnre);

            TfrxGroupFooter(frxRel.FindObject('GroupFooterFor')).Visible := False;
            TfrxReportSummary(frxRel.FindObject('rlbTotGeral')).Visible  := False;;

            pAjustaRelatorio(frxRel, strDtaEnt, strDtaDoc, intOpc, blnEfetua, blnQtdCmp, strTabPre, blnDevolu);

            frxRel.Script.Variables['blnVariacao'] := blnVariacao;

            TfrxDMPMemoView(frxRel.FindObject('rllMensagemRodape')).Visible := (intOpc in [2,3]);

            if blnObsCom then
            begin
              TfrxMemoView(frxRel.FindObject('mmoPcgObs')).Visible := True;
              TfrxMasterData(frxRel.FindObject('rlbDetGrupo')).Height := TfrxMemoView(frxRel.FindObject('mmoPcgObs')).Height * 2;
            end
            else
            begin
              TfrxMemoView(frxRel.FindObject('mmoPcgObs')).Visible := False;
              TfrxMasterData(frxRel.FindObject('rlbDetGrupo')).Height := TfrxMemoView(frxRel.FindObject('mmoPcgObs')).Height;
            end;

            frxRel.Script.Variables['blnDedFre'] := blnDedFre;

            If strDestino = 'V' Then
              pPreviewReport('frmRelEspNotaEnt', 'Espelho de nota de entrada', frxRel)
            Else If frxRel.PrepareReport Then
            Begin
              frxRel.PrintOptions.Printer := strNomImp;
              frxRel.PrintOptions.ShowDialog := strNomImp.IsEmpty;
              pPrintReport('frmRelEspNotaEnt', 'Espelho de nota de entrada', strNomImp, frxRel);
            End;

            Result := True;

          Finally
            pFreeAndNil(frmQckEspelhoNota);
          End;

        End;

      End;

    End;

end;

function TEspNota.fRetVendorDigitacao: String;
Begin
  Result := '';

  If Not Assigned(objVendor) Then
    Exit;

  If Not objVendor.blnGravar Then
    Exit;

  If objVendor.fltValVen > 0 Then
  Begin
    Result := 'Plano de Contas: ' + fFormataCCusto(objVendor.strCodCta) + '-' + fRetDescCentroCusto(objVendor.strCodCta) + #13#10;

    Result :=  Result +
               'Fornecedor: ' + objVendor.strCodFor + '-' + fRetNomFornecedor(objVendor.strCodFor) +
               '   Valor: ' + FormatFloat('#0.00', objVendor.fltValVen) +
               '   Cond. Pagamento: ' + fFormataCondPag(objVendor.strCndPag);
  End;
End;

function TEspNota.fRetICMAntDigitacao: String;
  Var
    fltAntFre : Double;
Begin
  Result := '';

  If fltIcmAnt > 0 Then
  Begin
    Result := fCfgSis('ANTFOR') + '-' + fRetNomFornecedor(fCfgSis('ANTFOR')) +
              '   Valor: ' + FormatFloat('#0.00', fltIcmAnt) +
              '   Vencimento: ' + FormatDateTime('DD/MM/YYYY', dtaIcmAnt);
  End;

  If Assigned(objLisFre) Then
    fltAntFre := objLisFre.fltAntIcT
  Else
    fltAntFre := 0;

  if fltAntFre > 0 Then
  Begin
    If not fEmptyStr(Result) Then
      Result := Result + #13#10;

    Result := Result + fCfgSis('ANTFOR') + '-' + fRetNomFornecedor(fCfgSis('ANTFOR')) +
              '   Valor: ' + FormatFloat('#0.00', fltAntFre) +
              '   Vencimento: ' + FormatDateTime('DD/MM/YYYY', fProximoVencimentoIcmAnt(fCfgSis('ANTVEN', varInteger), VS_Date));
  End;

End;

function TEspNota.fRetOutrasDespesasDigitacao: String;
Begin
  Result := '';

  If Not Assigned(objOutDes) Then
    Exit;

  If (objOutDes.fltValOut + objOutDes.fltValRPA) = 0 Then
    Exit;

  Result := objOutDes.fRetOutrasDespesasDigitacao;

End;

function TEspNota.fRetSomaConhecimento: Double;
Begin

  If Not Assigned(objLisFre) Then
  Begin
    Result := 0;
    Exit;
  End;

  Result := objLisFre.FieldByName('VALCON').AsFloat;

  If blnDedFre Then
    Result := Result - objLisFre.FieldByName('VALICM').AsFloat;
end;

function TEspNota.fCondPagtoConhecimentoFrete: String;
begin

  If Not Assigned(objLisFre) Then
  Begin
    Result := '';
    Exit;
  End;

  Result := objLisFre.FieldByName('CONPAG').AsString;
end;

function TEspNota.fDuplicatasConhecimentoFrete(strNumDoc, strEspDoc, strSerie, strCodFor: String): String;
  Var
    intContador: Integer;
    strClaFis  : String;
    objFreCon: TFreCon;
    arrDuplicata: TarrDuplicata;
Begin
  pZeraDigDuplic(arrDuplicata);
  Result := '';

  objFreCon := objLisFre.fRetConhecimento(strNumDoc, strEspDoc, strSerie, strCodFor);

  If Not Assigned(objFreCon) Then
    Exit;

  With objFreCon Do
  Begin
    strClaFis := '1101';

    If (fCfgSis('ENTCTP', varBoolean))    And
       (Pos(strClaFis, VS_strClaCom) > 0) And
       (fFornecedorGravaCtp(strCodTra))   Then
    Begin
      pMontaDuplicatasFrete(arrDuplicata);

      For intContador := Low(arrDuplicata) To High(arrDuplicata) Do
        With arrDuplicata[intContador] Do
        If curValor > 0 Then
          Result := Result + fStrZero(strNumDoc, 12) + '-' +
                      strSequen + '-' + strSerie_ + '   ' +
                     dtaDtaVen + '   ' +
                     FormatFloat('#0.00', curValor) + '  --  ';

      If Not fEmptyStr(Result) Then
      Begin
        Result := 'Plano de Contas : ' + fFormataCCusto(strCodCta) + '-' + fRetDescCentroCusto(strCodCta) + #13#10 + 'Duplicatas: ' + Result;
      End;
    End;
  End;

  Result := Trim(Result);
End;

procedure TEspNota.pAjustaRelatorio(Var frxRel: TfrxReport; strDtaIni, strDtaFin: String; intOpc: Integer; blnEfetua: Boolean; blnQtdCmp: Boolean; strTabPre: String; blnDevolu: boolean);
  Var
    fltWidth: Double;

begin

  If Not fEmptyStr(fTiraCaracEspeciais(strDtaIni)) Then
    frxRel.Script.Variables['PERIODO'] := 'REFERENTE AO PERIODO DE ' + FormatDateTime('dd/MM/yyyy', StrToDate(strDtaIni)) + ' A ' + FormatDateTime('dd/MM/yyyy', StrToDate(strDtaFin))
  Else
    frxRel.Script.Variables['PERIODO'] := '';

  frxRel.Script.Variables['strImpMarca'] := strImpMarca;
  frxRel.Script.Variables['strTipCalc']  := strTipCalc;
  frxRel.Script.Variables['intOpcSelec'] := intOpc;
  frxRel.Script.Variables['intVisualiz'] := intVisualiz;
  frxRel.Script.Variables['intOpcVariacao'] := intOpcVariacao;
  frxRel.Script.Variables['blnPrecoCustoCadastro'] := blnPrecoCustoCadastro;

  If SameText(strImpMarca,'M') And (intVisualiz In [0,1]) And (Not blnImpPre) Then
  Begin
    TfrxMemoView(frxRel.FindObject('rllMarca')).Visible   := True;
    TfrxMemoView(frxRel.FindObject('rdbMarca')).Visible   := True;
    TfrxMemoView(frxRel.FindObject('rllMarca')).Text      := 'MARCA';
    TfrxMemoView(frxRel.FindObject('rdbMarca')).DataField := 'DESMAR';
   End
  Else If SameText(strImpMarca,'R') And (Not blnImpPre) Then
  Begin
    TfrxMemoView(frxRel.FindObject('rllMarca')).Visible   := True;
    TfrxMemoView(frxRel.FindObject('rdbMarca')).Visible   := True;
    TfrxMemoView(frxRel.FindObject('rllMarca')).Text      := 'REFERENCIA';
    TfrxMemoView(frxRel.FindObject('rdbMarca')).DataField := 'REFERE';
  End
  Else If SameText(strImpMarca,'') Then
  Begin
    TfrxMemoView(frxRel.FindObject('rllMarca')).Visible   := False;
    TfrxMemoView(frxRel.FindObject('rdbMarca')).Visible   := False;
  End;

  If Not TfrxMemoView(frxRel.FindObject('rdbMarca')).Visible Then
    TfrxMemoView(frxRel.FindObject('mmoCodIte')).Width  := TfrxMemoView(frxRel.FindObject('mmoCodIte')).Width +
                                                           TfrxMemoView(frxRel.FindObject('rdbMarca')).Width;

  Case intVisualiz Of
    0: Begin
         TfrxMemoView(frxRel.FindObject('rllLocFis')).Text      := 'LOC.FIS.';
         TfrxMemoView(frxRel.FindObject('rdbLocFis')).DataField := 'LOCFIS';
       End;

    1: Begin
         TfrxMemoView(frxRel.FindObject('rllLocFis')).Text       := 'PED.COM.';
         TfrxMemoView(frxRel.FindObject('rdbLocFis')).DataField  := 'PEDCOM';
       End;

    2: Begin
         TfrxMemoView(frxRel.FindObject('rllLocFis')).Text      := 'COD.FAB.';
         TfrxMemoView(frxRel.FindObject('rdbLocFis')).DataField := 'CODFAB';
       End;

    3: Begin
         TfrxMemoView(frxRel.FindObject('rllLocFis')).Text       := 'NCM';
         TfrxMemoView(frxRel.FindObject('rdbLocFis')).DataField  := 'CLAIPI';
       End;

  End;

  If blnQtdCmp And (strTabPre <> '') Then
  Begin
    TfrxMemoView(frxRel.FindObject('rllPreVen')).Visible := False;
    TfrxMemoView(frxRel.FindObject('rlbPreVen')).Visible := False;
    TfrxMemoView(frxRel.FindObject('rllQtdCmp')).Visible := True;
    TfrxMemoView(frxRel.FindObject('rdbQtdCmp')).Visible := True;
    fltWidth := TfrxMemoView(frxRel.FindObject('rllPreVen')).Width;

    TfrxMemoView(frxRel.FindObject('rllOrdPag')).Left    := TfrxMemoView(frxRel.FindObject('rllOrdPag')).Left + fltWidth;
    TfrxMemoView(frxRel.FindObject('rdbOrdPag')).Left    := TfrxMemoView(frxRel.FindObject('rllOrdPag')).Left;

    TfrxMemoView(frxRel.FindObject('rllTotOrdPag')).Left := TfrxMemoView(frxRel.FindObject('rllTotOrdPag')).Left + fltWidth;
    TfrxMemoView(frxRel.FindObject('rdbTotOrdPag')).Left := TfrxMemoView(frxRel.FindObject('rllTotOrdPag')).Left;

    TfrxMemoView(frxRel.FindObject('rllTotal')).Left     := TfrxMemoView(frxRel.FindObject('rllTotal')).Left + fltWidth;
    TfrxMemoView(frxRel.FindObject('rdbTotal')).Left     := TfrxMemoView(frxRel.FindObject('rllTotal')).Left;

    TfrxMemoView(frxRel.FindObject('rllVariacao')).Left  := TfrxMemoView(frxRel.FindObject('rllVariacao')).Left + fltWidth;

    If frxRel.FindObject('linVariacao') <> Nil Then
      TfrxMemoView(frxRel.FindObject('linVariacao')).Left  := TfrxMemoView(frxRel.FindObject('linVariacao')).Left + fltWidth;
      
    TfrxMemoView(frxRel.FindObject('rdbValPer')).Left    := TfrxMemoView(frxRel.FindObject('rdbValPer')).Left + fltWidth;
    TfrxMemoView(frxRel.FindObject('rdbValor')).Left     := TfrxMemoView(frxRel.FindObject('rdbValor')).Left + fltWidth;

    TfrxMemoView(frxRel.FindObject('rllAlqIpi')).Left    := TfrxMemoView(frxRel.FindObject('rllAlqIpi')).Left + fltWidth;
    TfrxMemoView(frxRel.FindObject('rdbAlqIpi')).Left    := TfrxMemoView(frxRel.FindObject('rllAlqIpi')).Left;

  End;
  If blnDevolu Then
    frxRel.Script.Variables['NOMREL'] := 'RELATORIO DE ESEPLHO DA NOTA DE DEVOLUÇÃO (ENTRADA)'
  Else If blnEfetua Then
    frxRel.Script.Variables['NOMREL'] := 'RELATORIO DE ESPELHO DA NOTA DE ENTRADA EFETUADA'
  Else
    frxRel.Script.Variables['NOMREL'] := 'RELATORIO DE ESPELHO DA NOTA DE ENTRADA NAO EFETUADA';

end;


end.
