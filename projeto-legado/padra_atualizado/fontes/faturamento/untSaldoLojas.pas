unit untSaldoLojas;

interface

Uses
  Uni, Classes,
  DB,
  untZClient,
  untIFatEntregaFutura,
  untTFatEntregaFutura,
  untTFatReservaSaldo,
  untIFatReservaSaldo;

Type
  TRecSaldos = Record
    fltEstFis,
    fltSalGar,
    fltSalPed,
    fltSalEnd,
    fltSalOrd,
    fltEntPre,
    fltEntFal,
    fltEntAgu,
    fltSalDis,
    fltTraEst,
    fltSalExt,
    fltQtPdBf,
    fltSDPdBf,
    fltEstEnv,
    fltEstRec,
    fltSalCmp,
    fltPedFil: Double;
  End;

  TSaldoLojas = Class
  Private

    blnBEFTRG: Boolean;

    Function fSQLojas: String;
    Function fSQLSimilares: String;

  Public
    qrySimilares,
    qrySaldos: TZClient;

    constructor Create(Owner: TComponent); Reintroduce;

    Destructor  Destroy; Override;

    Procedure pCarregaSaldos(strCodIte, strCodSim, strCodEmp: String; fltCnvML: Double; blnAtualizaSimilares: Boolean; stlVendidos: TStringList; strTabPre: String='1'; fltDescMax: Double=0);

    procedure pCalculaSaldos(dtsConsulta: TDataSet;
                             Var recSaldos,
                                 recSaldosML  : TRecSaldos;
                                 fltSaldo     : Double;
                                 strEmpresa,
                                 strEmpIte,
                                 strCodIte    : String;
                                 fltCnvML     : Double;
                                 blnEntFut,
                                 blnPedCorte,
                                 blnOrdPro    : Boolean;
                                 intCalSal    : Integer;
                                 strNumLote   : String = '');

  End;

  TEmbalagens = Class(TZClient)
  Private

    function fGetSQLIteEmb(strTabPre: String): String;

  Public

    constructor Create(Owner: TComponent); Reintroduce;

    Destructor  Destroy; Override;

    procedure pAbreIteEmb(strTabPre, strCodIte: String);

  End;


implementation

Uses
  SysUtils,
  untFuncoesSimples,
  untSaldoPedidoCompra;

constructor TSaldoLojas.Create(Owner: TComponent);
Begin
  Inherited Create;

  qrySaldos    := TZClient.Create(Nil);
  qrySimilares := TZClient.Create(Nil);

  qrySaldos.qryQuery.SQL.Text    := fSQLojas;
  qrySimilares.qryQuery.SQL.Text := fSQLSimilares;

  blnBEFTRG := fCfgSis('BEFTRG', VarBoolean);
End;

Destructor TSaldoLojas.Destroy;
Begin
  inherited Destroy;

  FreeAndNil(qrySaldos);
  FreeAndNil(qrySimilares);
End;

Function TSaldoLojas.fSQLojas: String;
  Var
    strSQL: String;
    strEmpresas: String;
Begin
  strSQL := '';

  If fCfgSis('UPSEML', varBoolean) Then
    strSQL := strSQL + 'SELECT * FROM ( ';

  strSQL := strSQL + ' SELECT   ';
  strSQL := strSQL + '   ITE_CODEMP AS CODEMP,  ';

  If fCfgSis('UPSEML', varBoolean) Then
    strSQL := strSQL + 'IF(ITE_CODEMP = ' + VS_strCodEmp + ', 0, IF(EPS_EMPSAI =  ITE_CODEMP, 1, 2)) AS LISREG,';

  strSQL := strSQL + '  (IFNULL(ITE_SALDOS + IF(IFNULL(:CNV_ML, 0) > 0, IFNULL(ITE_SAL_ML, 0) / :CNV_ML, 0), 0) ';

  If (Not blnBEFTRG) Or fUsaQtdPendenteEntregaFutura(True, '', True) Then
  Begin
    strSQL := strSQL + '    + IFNULL(ITE_QTEF_A, 0) ';
    strSQL := strSQL + '    + IFNULL(ITE_QTEF_F, 0) ';
    strSQL := strSQL + '    + IFNULL(ITE_QTEF_P, 0) ';
    strSQL := strSQL + '    + IFNULL(ITE_QTPDBF, 0) ';
  End;

  strSQL := strSQL + '   ) AS SALFIS, ';

  strSQL := strSQL + '   IFNULL(ITE_SALDOS + IF(IFNULL(:CNV_ML, 0) > 0, IFNULL(ITE_SAL_ML, 0) / :CNV_ML, 0), 0) ';

  strSQL := strSQL + '      + IFNULL(ITE_QTPDBF, 0) ';                            // SALDO FÍSICO PEDIDO DE BAIXA DE ENTREGA FUTURA

  strSQL := strSQL + '      - (IFNULL(ITE_QTPD_V, 0) + IFNULL(ITE_QTPD_F, 0)) ';  // PEDIDO
  strSQL := strSQL + '      - IFNULL(ITE_SALREG, 0) ';                            // GARANTIA

  If (fCfgSis('MOVFUL', varString) <> '2') Then
    strSQL := strSQL + '      - IF((ITE_SALEXT < 0) OR (ITE_SALEXT IS NULL), 0, ITE_SALEXT) '; // EXTERNO

  strSQL := strSQL + '      - IFNULL(ITE_QTPD_P, 0) ';                            // ORDEM PRODUÇÃO
  strSQL := strSQL + '      - IFNULL(ITE_QTPD_E, 0) ';                            // ENDEREÇAMENTO
  strSQL := strSQL + '      - IFNULL(ITE_SDPDBF, 0) ';                            // RESERVADO PEDIDO DE BAIXA DE ENTREGA FUTURA

  Case fCfgSis('CALSAL', varInteger) Of
    1:  Begin
          strSQL := strSQL +                            ' + IFNULL(ITE_QTEF_A, 0)';
          strSQL := strSQL +                            ' + IFNULL(ITE_QTEF_F, 0)';
          strSQL := strSQL +                            ' + IFNULL(ITE_QTEF_P, 0)';
        End;

    2:  ;

    3:  Begin
          strSQL := strSQL +                            ' + IFNULL(ITE_QTEF_F, 0)';
        End;

    4:  Begin
          strSQL := strSQL +                            ' + IFNULL(ITE_QTEF_A, 0)';
          strSQL := strSQL +                            ' + IFNULL(ITE_QTEF_P, 0)';
        End;

    5:  Begin
          strSQL := strSQL +                            ' + IFNULL(ITE_QTEF_A, 0)';
          strSQL := strSQL +                            ' + IFNULL(ITE_QTEF_F, 0)';
        End;
  End;

  strSQL := strSQL + ' AS SALDIS ';

  If fCfgSis('UPSEML', varBoolean) Then
  Begin
    strSQL := strSQL + ', ';

    strSQL := strSQL + ' (SELECT SUM(IFNULL(ITE_SALDOS + IF(IFNULL(:CNV_ML, 0) > 0, IFNULL(ITE_SAL_ML, 0) / :CNV_ML, 0), 0) ';

    strSQL := strSQL + '      + IFNULL(ITE_QTPDBF, 0) ';                            // SALDO FÍSICO PEDIDO DE BAIXA DE ENTREGA FUTURA

    strSQL := strSQL + '      - (IFNULL(ITE_QTPD_V, 0) + IFNULL(ITE_QTPD_F, 0)) ';  // PEDIDO
    strSQL := strSQL + '      - IFNULL(ITE_SALREG, 0) ';                            // GARANTIA

    If (fCfgSis('MOVFUL', varString) <> '2') Then
      strSQL := strSQL + '      - IF((ITE_SALEXT < 0) OR (ITE_SALEXT IS NULL), 0, ITE_SALEXT) '; // EXTERNO

    strSQL := strSQL + '      - IFNULL(ITE_QTPD_P, 0) ';                            // ORDEM PRODUÇÃO
    strSQL := strSQL + '      - IFNULL(ITE_QTPD_E, 0) ';                            // ENDEREÇAMENTO
    strSQL := strSQL + '      - IFNULL(ITE_SDPDBF, 0) ';                            // RESERVADO PEDIDO DE BAIXA DE ENTREGA FUTURA

    Case fCfgSis('CALSAL', varInteger) Of
      1:  Begin
            strSQL := strSQL +                            ' + IFNULL(ITE_QTEF_A, 0)';
            strSQL := strSQL +                            ' + IFNULL(ITE_QTEF_F, 0)';
            strSQL := strSQL +                            ' + IFNULL(ITE_QTEF_P, 0)';
          End;

      2:  ;

      3:  Begin
            strSQL := strSQL +                            ' + IFNULL(ITE_QTEF_F, 0)';
          End;

      4:  Begin
            strSQL := strSQL +                            ' + IFNULL(ITE_QTEF_A, 0)';
            strSQL := strSQL +                            ' + IFNULL(ITE_QTEF_P, 0)';
          End;

      5:  Begin
            strSQL := strSQL +                            ' + IFNULL(ITE_QTEF_A, 0)';
            strSQL := strSQL +                            ' + IFNULL(ITE_QTEF_F, 0)';
          End;
    End;

    strSQL := strSQL + ' ) ';
    strSQL := strSQL + ' FROM ITEGER IG ';
    strSQL := strSQL + ' WHERE IG.ITE_CODITE = ITEGER.ITE_CODITE ';
    strSQL := strSQL + '   AND IG.ITE_CODEMP IN (SELECT EPS_EMPSAI FROM CADEPS WHERE EPS_CODEMP = ' +QuotedStr(VS_StrCodEmp) + ')';
    strSQL := strSQL + ' ) AS SALCMP';
  End;

  strSQL := strSQL + ' FROM     ';
  strSQL := strSQL + '   ITEGER ';

  If fCfgSis('UPSEML', varBoolean) Then
    strSQL := strSQL + ' LEFT JOIN CADEPS ON CADEPS.EPS_CODEMP = ' + VS_strCodEmp + ' AND EPS_EMPSAI = ITE_CODEMP ';

  strSQL := strSQL + ' WHERE    ';
  strSQL := strSQL + '   ITE_CODITE = :CODITE ';
  strEmpresas := fRetEmpEstUsuario(strLoginUsuarioLogado);
  If Not fEmptyStr(strEmpresas) Then
    strSQL := strSQL + ' AND ITE_CODEMP IN (' +  fRetStrToSQLIn(strEmpresas) + ') '
  Else
    strSQL := strSQL + ' AND ITE_CODEMP = "" ';

  If fCfgSis('UPSEML', varBoolean) Then
    strSQL := strSQL + 'ORDER BY LISREG, EPS_ORDEM_ DESC, CODEMP ) TMP '
  Else
    strSQL := strSQL + ' ORDER BY ITE_CODEMP ';

  Result := strSQL;
End;

Function TSaldoLojas.fSQLSimilares: String;

  Function fGetSQLSaldoCompartilhado: String;
  begin
    Result := '';
    Result := Result + ' (SELECT SUM(IFNULL(ITE_SALDOS + IF(IFNULL(ITE_CNV_ML, 0) > 0, IFNULL(ITE_SAL_ML, 0) / ITE_CNV_ML, 0), 0) ';

    Result := Result + '      + IFNULL(ITE_QTPDBF, 0) ';                            // SALDO FÍSICO PEDIDO DE BAIXA DE ENTREGA FUTURA

    Result := Result + '      - (IFNULL(ITE_QTPD_V, 0) + IFNULL(ITE_QTPD_F, 0)) ';  // PEDIDO
    Result := Result + '      - IFNULL(ITE_SALREG, 0) ';                            // GARANTIA

    If (fCfgSis('MOVFUL', varString) <> '2') Then
      Result := Result + '      - IF((ITE_SALEXT < 0) OR (ITE_SALEXT IS NULL), 0, ITE_SALEXT) '; // EXTERNO

    Result := Result + '      - IFNULL(ITE_QTPD_P, 0) ';                            // ORDEM PRODUÇÃO
    Result := Result + '      - IFNULL(ITE_QTPD_E, 0) ';                            // ENDEREÇAMENTO
    Result := Result + '      - IFNULL(ITE_SDPDBF, 0) ';                            // RESERVADO PEDIDO DE BAIXA DE ENTREGA FUTURA

    Case fCfgSis('CALSAL', varInteger) Of
      1:  Begin
            Result := Result +                            ' + IFNULL(ITE_QTEF_A, 0)';
            Result := Result +                            ' + IFNULL(ITE_QTEF_F, 0)';
            Result := Result +                            ' + IFNULL(ITE_QTEF_P, 0)';
          End;

      2:  ;

      3:  Begin
            Result := Result +                            ' + IFNULL(ITE_QTEF_F, 0)';
          End;

      4:  Begin
            Result := Result +                            ' + IFNULL(ITE_QTEF_A, 0)';
            Result := Result +                            ' + IFNULL(ITE_QTEF_P, 0)';
          End;

      5:  Begin
            Result := Result +                            ' + IFNULL(ITE_QTEF_A, 0)';
            Result := Result +                            ' + IFNULL(ITE_QTEF_F, 0)';
          End;
    End;

    Result := Result + ' ) ';
    Result := Result + ' FROM ITEGER IG ';
    Result := Result + ' WHERE IG.ITE_CODITE = G.ITE_CODITE ';
    Result := Result + '   AND IG.ITE_CODEMP IN (SELECT EPS_EMPSAI FROM CADEPS WHERE EPS_CODEMP = ' +QuotedStr(VS_StrCodEmp) + ')';
    Result := Result + ' )';
  end;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT   ';
  strSQL := strSQL + '   C.ITE_CODITE,  ';
  strSQL := strSQL + '   CAST(IF(LOCATE(C.ITE_CODITE, :LISTA) > 0, 1, NULL) AS UNSIGNED) AS VENDIDO, ';
  strSQL := strSQL + '   C.ITE_CODSIM AS CODSIM,  ';
  strSQL := strSQL + '   C.ITE_CODITE AS CODITE,  ';
  strSQL := strSQL + '   C.ITE_DESITE AS DESITE,  ';
  strSQL := strSQL + '     UNI_SIGUNI AS SIGUNI,  ';
  strSQL := strSQL + '     MAR_DESMAR AS DESMAR,  ';

  If (fCfgSis('EXCODF', varInteger) = 1) Then
    strSQL := strSQL + '     ITE_CODFAB AS FABRIC,  '
  Else
    strSQL := strSQL + '     ITE_FABRIC AS FABRIC,  ';

  strSQL := strSQL + '     ITE_REFERE AS REFERE,  ';

  strSQL := strSQL + '   CASE :TABPRE ';
  strSQL := strSQL + '       WHEN "1" THEN (ITE_PREVE1 - (ITE_PREVE1 * :DESMAX / 100)) ';
  strSQL := strSQL + '       WHEN "2" THEN (ITE_PREVE2 - (ITE_PREVE2 * :DESMAX / 100)) ';
  strSQL := strSQL + '       WHEN "3" THEN (ITE_PREVE3 - (ITE_PREVE3 * :DESMAX / 100)) ';
  strSQL := strSQL + '       WHEN "4" THEN (ITE_PREVE4 - (ITE_PREVE4 * :DESMAX / 100)) ';
  strSQL := strSQL + '       WHEN "5" THEN (ITE_PREVE5 - (ITE_PREVE5 * :DESMAX / 100)) ';
  strSQL := strSQL + '       WHEN "6" THEN (ITE_PREVE6 - (ITE_PREVE6 * :DESMAX / 100)) ';
  strSQL := strSQL + '       WHEN "7" THEN (ITE_PREVE7 - (ITE_PREVE7 * :DESMAX / 100)) ';
  strSQL := strSQL + '   END AS PREVEN, ';

  strSQL := strSQL + '     ITE_SALDOS AS SALDOS,  ';
  strSQL := strSQL + '     ITE_SAL_ML AS SAL_ML,  ';
  strSQL := strSQL + '     ITE_CNV_ML AS CNV_ML,  ';
  strSQL := strSQL + '     ITE_LOCFIS AS LOCFIS,  ';

  strSQL := strSQL + '   (SELECT COUNT(AUTOINCREM) ';
  strSQL := strSQL + '      FROM FATDOR ';
  strSQL := strSQL + '    WHERE FDO_ESPDOC = "OR" ';
  strSQL := strSQL + '      AND FDO_JAFATU = 0 ';
  strSQL := strSQL + '      AND FDO_CODITE = G.ITE_CODITE ';
  strSQL := strSQL + '      AND FDO_CODEMP = G.ITE_CODEMP) AS ORCPEN, ';

  strSQL := strSQL + '    (SELECT ';
  strSQL := strSQL + '       COUNT(GMT.AUTOINCREM) AS EST ';
  strSQL := strSQL + '     FROM ';
  strSQL := strSQL + '       GERMAT GMT ';
  strSQL := strSQL + '     WHERE ';
  strSQL := strSQL + '       C.ITE_CODITE = GMT.GMT_CODITE ) AS ESTRUT, ';

  strSQL := strSQL + fSQLQuantidadePendenteCompra('C.ITE_CODITE', '', False, True) + ' AS PEDCOM, ';

  If fCfgSis('UPSEML', varBoolean) Then
  Begin
    strSQL := strSQL + fGetSQLSaldoCompartilhado + 'AS SALCMP, ';
  End;

  strSQL := strSQL + '   IFNULL(ITE_SALDOS + IF(IFNULL(ITE_CNV_ML, 0) > 0, IFNULL(ITE_SAL_ML, 0) / ITE_CNV_ML, 0), 0) ';

  strSQL := strSQL + '      + IFNULL(ITE_QTPDBF, 0) ';                            // SALDO FÍSICO PEDIDO DE BAIXA DE ENTREGA FUTURA

  strSQL := strSQL + '      - (IFNULL(ITE_QTPD_V, 0) + IFNULL(ITE_QTPD_F, 0)) ';  // PEDIDO
  strSQL := strSQL + '      - IFNULL(ITE_SALREG, 0) ';                            // GARANTIA

  If (fCfgSis('MOVFUL', varString) <> '2') Then
    strSQL := strSQL + '      - IF((ITE_SALEXT < 0) OR (ITE_SALEXT IS NULL), 0, ITE_SALEXT) '; // EXTERNO

  strSQL := strSQL + '      - IFNULL(ITE_QTPD_P, 0) ';                            // ORDEM PRODUÇÃO
  strSQL := strSQL + '      - IFNULL(ITE_QTPD_E, 0) ';                            // ENDEREÇAMENTO
  strSQL := strSQL + '      - IFNULL(ITE_SDPDBF, 0) ';                            // RESERVADO PEDIDO DE BAIXA DE ENTREGA FUTURA

  Case fCfgSis('CALSAL', varInteger) Of
    1:  Begin
          strSQL := strSQL +                            ' + IFNULL(ITE_QTEF_A, 0)';
          strSQL := strSQL +                            ' + IFNULL(ITE_QTEF_F, 0)';
          strSQL := strSQL +                            ' + IFNULL(ITE_QTEF_P, 0)';
        End;

    2:  ;

    3:  Begin
          strSQL := strSQL +                            ' + IFNULL(ITE_QTEF_F, 0)';
        End;

    4:  Begin
          strSQL := strSQL +                            ' + IFNULL(ITE_QTEF_A, 0)';
          strSQL := strSQL +                            ' + IFNULL(ITE_QTEF_P, 0)';
        End;

    5:  Begin
          strSQL := strSQL +                            ' + IFNULL(ITE_QTEF_A, 0)';
          strSQL := strSQL +                            ' + IFNULL(ITE_QTEF_F, 0)';
        End;
  End;

  strSQL := strSQL + ' AS SALDIS ';

  strSQL := strSQL + ' FROM     ';
  strSQL := strSQL + '   CADITE C ';
  strSQL := strSQL + '   INNER JOIN ITEGER G ON G.ITE_CODITE = C.ITE_CODITE AND G.ITE_CODEMP = :CODEMP ';
  strSQL := strSQL + '   INNER JOIN CADUNI   ON UNI_CODUNI = C.ITE_CODUNI ';
  strSQL := strSQL + '   INNER JOIN CADMAR   ON MAR_CODMAR = C.ITE_CODMAR ';
  strSQL := strSQL + ' WHERE    ';
  strSQL := strSQL + '       C.ITE_CODITE <> :CODITE ';
  strSQL := strSQL + '   AND C.ITE_CODSIM = :CODSIM ';

  If fCfgSis('PANITE', VarBoolean) Then
    strSQL := strSQL + '   AND C.ITE_ITEATI = "S" ';

  Result := strSQL;
End;

Procedure TSaldoLojas.pCarregaSaldos(strCodIte, strCodSim, strCodEmp: String; fltCnvML: Double; blnAtualizaSimilares: Boolean; stlVendidos: TStringList; strTabPre: String='1';
                                     fltDescMax: Double=0);
Begin
  qrySaldos.qryQuery.Close;
  qrySaldos.qryQuery.ParamByName('CODITE').AsString := strCodIte;
  qrySaldos.qryQuery.ParamByName('CNV_ML').AsFloat  := fltCnvML;

  qrySaldos.fAbreClient(True, 'TSaldoLojas.pCarregaSaldos');

  if Assigned(qrySaldos.FindField('CODEMP')) then
    qrySaldos.FieldByName('CODEMP').Alignment := taCenter;

  If blnAtualizaSimilares Then
  Begin
    qrySimilares.qryQuery.Close;
    qrySimilares.qryQuery.ParamByName('CODITE').AsString := strCodIte;
    qrySimilares.qryQuery.ParamByName('CODEMP').AsString := strCodEmp;
    qrySimilares.qryQuery.ParamByName('CODSIM').AsString := strCodSim;
    qrySimilares.qryQuery.ParamByName('TABPRE').AsString := strTabPre;
    qrySimilares.qryQuery.ParamByName('DESMAX').AsString := FloatToStr(fltDescMax);

    If Assigned(stlVendidos) Then
      qrySimilares.qryQuery.ParamByName('LISTA').AsString := stlVendidos.CommaText;

    qrySimilares.fAbreClient(True, 'TSaldoLojas.pCarregaSaldos');

    qrySimilares.FieldByName('CODITE').Alignment := taCenter;
    qrySimilares.FieldByName('SIGUNI').Alignment := taCenter;
  End;
End;

procedure TSaldoLojas.pCalculaSaldos(dtsConsulta: TDataSet;
                                     Var recSaldos,
                                         recSaldosML  : TRecSaldos;
                                         fltSaldo     : Double;
                                         strEmpresa,
                                         strEmpIte,
                                         strCodIte    : String;
                                         fltCnvML     : Double;
                                         blnEntFut,
                                         blnPedCorte,
                                         blnOrdPro    : Boolean;
                                         intCalSal    : Integer;
                                         strNumLote   : String = '');
Begin
  With recSaldos Do
  Begin
    FillChar(recSaldos,   SizeOf(recSaldos), #0);
    FillChar(recSaldosML, SizeOf(recSaldosML), #0);

    If blnEntFut Then
    Begin
      If Assigned(dtsConsulta) And Assigned(dtsConsulta.FindField('ITE_FUTPRE')) Then
        fltEntPre := dtsConsulta.FieldByName('ITE_FUTPRE').AsFloat
      Else
        fltEntPre := TEntregaFutura.New(
                       TParamEF.New()
                         .CodIte(strCodIte)
                         .CodEmp(strEmpresa)
                         .Faturamento(True)
                       .TipoEF(tefPrevisao)
                       .TipoTE(tteNenhuma)
                       .Lote(strNumLote)
                     ).Total();

      If Assigned(dtsConsulta) And Assigned(dtsConsulta.FindField('ITE_FUTFAL')) Then
        fltEntFal := dtsConsulta.FieldByName('ITE_FUTFAL').AsFloat
      Else
        fltEntFal := TEntregaFutura.New(
                       TParamEF.New()
                         .CodIte(strCodIte)
                         .CodEmp(strEmpresa)
                         .Faturamento(True)
                       .TipoEF(tefFaltaDeProduto)
                       .TipoTE(tteNenhuma)
                       .Lote(strNumLote)
                     ).Total();

      If Assigned(dtsConsulta) And Assigned(dtsConsulta.FindField('ITE_FUTAGU')) Then
        fltEntAgu := dtsConsulta.FieldByName('ITE_FUTAGU').AsFloat
      Else
        fltEntAgu := TEntregaFutura.New(
                       TParamEF.New()
                         .CodIte(strCodIte)
                         .CodEmp(strEmpresa)
                       .Faturamento(True)
                       .TipoEF(tefAguardandoCliente)
                       .TipoTE(tteNenhuma)
                       .Lote(strNumLote)
                     ).Total();

       If Assigned(dtsConsulta) And Assigned(dtsConsulta.FindField('ITE_QTPDBF')) Then
         fltQtPdBf := dtsConsulta.FieldByName('ITE_QTPDBF').AsFloat
       Else
         fltQtPdBf := TSaldoReservado.New(
                        TReservaParametros.New()
                          .EmpresaItem(strEmpIte)
                          .CodigoItem(strCodIte)
                          .CodEmpresa(strEmpresa)
                          .DesconsideraPedidosCorte(Not blnPedCorte)
                        .TipoReserva(trsPedidoBaixaEntregaFuturaSaldoFisico)
                        .ConverterML(False)
                        .NumeroLote(strNumLote)
                      ).fGetQuantidade();
    End;



    If Assigned(dtsConsulta) And Assigned(dtsConsulta.FindField('ITE_SALTRA')) Then
      fltEstEnv := dtsConsulta.FieldByName('ITE_SALTRA').AsFloat
    Else
      fltEstEnv := 0;

    If Assigned(dtsConsulta) And Assigned(dtsConsulta.FindField('SAL_FILNLI')) Then
      fltEstRec := dtsConsulta.FieldByName('SAL_FILNLI').AsFloat + dtsConsulta.FieldByName('SAL_FILLIB').AsFloat
    Else
      fltEstRec := 0;



    If Assigned(dtsConsulta) And Assigned(dtsConsulta.FindField('ITE_SALFIS')) Then
      fltEstFis := dtsConsulta.FieldByName('ITE_SALFIS').AsFloat
    Else
    Begin
      fltEstFis := fltSaldo;

      If (Not blnBEFTRG) Or fUsaQtdPendenteEntregaFutura Then
        fltEstFis := fltEstFis + fltEntPre + fltEntFal + fltEntAgu + fltQtPdBf;
    End;

    If Assigned(dtsConsulta) And Assigned(dtsConsulta.FindField('ITE_SALPED')) Then
      fltSalPed := dtsConsulta.FieldByName('ITE_SALPED').AsFloat
    Else
      fltSalPed := TSaldoReservado.New(
                     TReservaParametros.New()
                       .EmpresaItem(strEmpIte)
                       .CodigoItem(strCodIte)
                       .CodEmpresa(strEmpresa)
                       .DesconsideraPedidosCorte(Not blnPedCorte)
                       .DesconsideraPedidosEnderecamento(True)
                     .TipoReserva(trsPedidoVenda)
                     .ConverterML(False)
                     .NumeroLote(strNumLote)
                   ).fGetQuantidade();

    If Assigned(dtsConsulta) And Assigned(dtsConsulta.FindField('ITE_SALEND')) Then
      fltSalEnd := dtsConsulta.FieldByName('ITE_SALEND').AsFloat
    Else
      fltSalEnd := TSaldoReservado.New(
                     TReservaParametros.New()
                       .EmpresaItem(strEmpIte)
                       .CodigoItem(strCodIte)
                       .CodEmpresa(strEmpresa)
                     .DesconsideraPedidosCorte(Not blnPedCorte)
                     .TipoReserva(trsEnderecamento)
                     .ConverterML(False)
                     .NumeroLote(strNumLote)
                   ).fGetQuantidade();

    If blnOrdPro Then
      If Assigned(dtsConsulta) And Assigned(dtsConsulta.FindField('ITE_SALORD')) Then
        fltSalOrd := dtsConsulta.FieldByName('ITE_SALORD').AsFloat
      Else
        fltSalOrd := TSaldoReservado.New(
                       TReservaParametros.New()
                         .EmpresaItem(strEmpIte)
                         .CodigoItem(strCodIte)
                         .CodEmpresa(strEmpresa)
                         .DesconsideraPedidosCorte(Not blnPedCorte)
                       .TipoReserva(trsOrdemProducao)
                       .ConverterML(False)
                       .NumeroLote(strNumLote)
                     ).fGetQuantidade();

    If Assigned(dtsConsulta) And Assigned(dtsConsulta.FindField('ITE_SALGAR')) Then
      fltSalGar := dtsConsulta.FieldByName('ITE_SALGAR').AsFloat
    Else
      fltSalGar := TSaldoReservado.New(
                     TReservaParametros.New()
                       .EmpresaItem(strEmpIte)
                       .CodigoItem(strCodIte)
                       .CodEmpresa(strEmpresa)
                       .DesconsideraPedidosCorte(Not blnPedCorte)
                     .TipoReserva(trsGarantia)
                     .ConverterML(False)
                     .NumeroLote(strNumLote)
                   ).fGetQuantidade();

    If Assigned(dtsConsulta) And Assigned(dtsConsulta.FindField('ITE_SALEXT')) Then
      fltSalExt := dtsConsulta.FieldByName('ITE_SALEXT').AsFloat
    Else
      fltSalExt := TSaldoReservado.New(
                     TReservaParametros.New()
                       .EmpresaItem(strEmpIte)
                       .CodigoItem(strCodIte)
                       .CodEmpresa(strEmpresa)
                       .DesconsideraPedidosCorte(Not blnPedCorte)
                       .TipoReserva(trsExterno)
                       .ConverterML(False)
                     ).fGetQuantidade();

    If (fltSalExt < 0) Then
      fltSalExt := 0;

    If Assigned(dtsConsulta) And Assigned(dtsConsulta.FindField('ITE_SDPDBF')) Then
      fltSdPdBf := dtsConsulta.FieldByName('ITE_SDPDBF').AsFloat
    Else
      fltSdPdBf := TSaldoReservado.New(
                     TReservaParametros.New()
                       .EmpresaItem(strEmpIte)
                       .CodigoItem(strCodIte)
                       .CodEmpresa(strEmpresa)
                       .DesconsideraPedidosCorte(Not blnPedCorte)
                     .TipoReserva(trsPedidoBaixaEntregaFuturaReservSaldo)
                     .ConverterML(False)
                     .NumeroLote(strNumLote)
                   ).fGetQuantidade();

    If Assigned(dtsConsulta) And Assigned(dtsConsulta.FindField('ITE_SALDIS')) Then
      fltSalDis := dtsConsulta.FieldByName('ITE_SALDIS').AsFloat
    Else
      fltSalDis := fCalculaSaldoDisponivel(intCalSal, fltEstFis, fltSalGar, fltSalPed, fltSalEnd, fltSalOrd,
                                           fltEntPre, fltEntFal, fltEntAgu, fltSalExt, fltSdPdBf);

    If Assigned(dtsConsulta) And Assigned(dtsConsulta.FindField('ITE_TRANSF')) Then
      fltTraEst := dtsConsulta.FieldByName('ITE_TRANSF').AsFloat
    Else
      fltTraEst := TSaldoReservado.New(
                     TReservaParametros.New()
                       .EmpresaItem(strEmpIte)
                       .CodigoItem(strCodIte)
                       .CodEmpresa(strEmpresa)
                       .DesconsideraPedidosCorte(Not blnPedCorte)
                       .TipoReserva(trsTransferencia)
                       .ConverterML(False)
                     ).fGetQuantidade();

    fltPedFil := TSaldoReservado.New(
                   TReservaParametros.New()
                     .EmpresaItem(strEmpIte)
                     .CodigoItem(strCodIte)
                     .CodEmpresa(strEmpresa)
                     .DesconsideraPedidosCorte(Not blnPedCorte)
                     .TipoReserva(trsPedidoVendaFil)
                     .ConverterML(False)
                   ).fGetQuantidade();

    If (fltCnvML > 0) Then
    Begin
      recSaldosML.fltEstFis := fltEstFis * fltCnvML;
      recSaldosML.fltSalGar := fltSalGar * fltCnvML;
      recSaldosML.fltSalPed := fltSalPed * fltCnvML;
      recSaldosML.fltSalEnd := fltSalEnd * fltCnvML;
      recSaldosML.fltSalOrd := fltSalOrd * fltCnvML;
      recSaldosML.fltEntPre := fltEntPre * fltCnvML;
      recSaldosML.fltEntFal := fltEntFal * fltCnvML;
      recSaldosML.fltEntAgu := fltEntAgu * fltCnvML;
      recSaldosML.fltSalDis := fltSalDis * fltCnvML;
      recSaldosML.fltTraEst := fltTraEst * fltCnvML;
      recSaldosML.fltSalExt := fltSalExt * fltCnvML;
      recSaldosML.fltSdPdBf := fltSdPdBf * fltCnvML;
      recSaldosML.fltPedFil := fltPedFil * fltCnvML;
    End

    Else FillChar(recSaldosML, SizeOf(recSaldosML), #0);
  End;

End;

constructor TEmbalagens.Create(Owner: TComponent);
Begin
  Inherited Create(Owner, '');

End;

Destructor TEmbalagens.Destroy;
Begin
  Inherited;

End;

Function TEmbalagens.fGetSQLIteEmb(strTabPre: String): String;
Begin
  Result := '';
  Result := Result + ' SELECT ITB_QTDEMB,                                             ';
  Result := Result + '        ITB_DESCON,                                             ';
  Result := Result + '        IFNULL(ITB_TABPRE,"TODAS") AS ITB_TABPRE,               ';
  Result := Result + '        CASE IF(IFNULL(ITB_TABPRE,"")="","' + IIF(fEmptyStr(strTabPre), '0', strTabPre) + '",ITB_TABPRE) ';
  Result := Result + '          WHEN "0" THEN NULL                                    ';
  Result := Result + '          WHEN "1" THEN (ITE_PREVE1 * ((100-ITB_DESCON) / 100)) ';
  Result := Result + '          WHEN "2" THEN (ITE_PREVE2 * ((100-ITB_DESCON) / 100)) ';
  Result := Result + '          WHEN "3" THEN (ITE_PREVE3 * ((100-ITB_DESCON) / 100)) ';
  Result := Result + '          WHEN "4" THEN (ITE_PREVE4 * ((100-ITB_DESCON) / 100)) ';
  Result := Result + '          WHEN "5" THEN (ITE_PREVE5 * ((100-ITB_DESCON) / 100)) ';
  Result := Result + '          WHEN "6" THEN (ITE_PREVE6 * ((100-ITB_DESCON) / 100)) ';
  Result := Result + '          WHEN "7" THEN (ITE_PREVE7 * ((100-ITB_DESCON) / 100)) ';
  Result := Result + '        END AS UNITAR                                           ';
  Result := Result + ' FROM ITEEMB                                                    ';
  Result := Result + ' INNER JOIN ITEGER ON ITE_CODITE = ITB_CODITE                   ';
  Result := Result + '                  AND ITE_CODEMP = ITB_CODEMP                   ';
  Result := Result + ' WHERE ITB_CODITE = :CODITE                                     ';
  Result := Result + '   AND ITB_CODEMP = :CODEMP                                     ';
  Result := Result + ' ORDER BY ITB_QTDEMB DESC                                       ';
End;

procedure TEmbalagens.pAbreIteEmb(strTabPre, strCodIte: String);
Begin
  qryQuery.Close;
  qryQuery.SQL.Text := fGetSQLIteEmb(strTabPre);
  qryQuery.ParamByName('CODITE').AsString := strCodIte;
  qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;

  fAbreClient(True, 'pAbreIteEmb');

  TFloatField(FieldByName('ITB_DESCON')).DisplayFormat := fMskDigitos(4);
  TFloatField(FieldByName('UNITAR'    )).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  TFloatField(FieldByName('ITB_QTDEMB')).DisplayFormat := IIF(fUnidadeDoProdutoEhFracionaria(strCodIte), fMskDigitos(4), '');
  TFloatField(FieldByName('ITB_QTDEMB')).Alignment     := taCenter;
  TFloatField(FieldByName('ITB_TABPRE')).Alignment     := taCenter;
End;

end.

