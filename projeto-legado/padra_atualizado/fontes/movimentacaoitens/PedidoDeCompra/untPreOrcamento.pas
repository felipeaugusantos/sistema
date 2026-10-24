unit untPreOrcamento;

interface

Uses
  Classes, SysUtils, Controls, DB,
  untFuncoesSimples, untZClient, Uni,
  untTypesSistema, untConstantes,
  CxProgressBar,
  untFuncoesPedidoSimples, variants, untFuncoesConsulta;

Type
  TTipoConsulta = (ticCompra, ticSatelites, ticSimilares);

  TEscreveTotalizadores = procedure of object;

  TTotalizadoresMarcado = record
    qtdNivelGiroA: Double;
    qtdNivelGiroB: Double;
    qtdNivelGiroC: Double;
    qtdCriticidaX: Double;
    qtdCriticidaY: Double;
    qtdCriticidaZ: Double;
    qtdItensSelec: Double;


    fltTotalPedidoSelecionado: Double;
    fltTotalQtdSel: Double;
    fltTotalMetSel: Double;
    fltTotalLitSel: Double;
    fltTotalKilSel: Double;
  End;

  TPreOrcamento = Class(TZClient)
    Private
      strFRMPCM,
      strSimPau,
      FCodFor: String;
      FDesAdi: Double;
      blnTemDare,
      FblnMarca: Boolean;
      cdsMarcados: TZClient;
      cdsTotUnidade: TZClient;

      Function fSQLItens(strCodFor, strEmpHub, strCodIte, strCodSim, strCodMar, strCodDep, strLinGru, strFilEmp: String; ticConsulta: TTipoConsulta; blnConsiderarProdSobEnc: Boolean): String;
      Function fSQLDesmarcaItens(strCodFor, strEmpHub, strCodIte, strCodSim, strCodMar, strCodDep, strLinGru, strFilEmp: String; ticConsulta: TTipoConsulta; blnConsiderarProdSobEnc: Boolean): String;
      Function fRetMaxMeses(strCodFor, strEmpHub, strCodIte, strCodSim: String; ticConsulta: TTipoConsulta): Integer;
      Function fSQLCabecOrc: String;

      Procedure pMontaNomeMeses;

      Procedure pCarregaDadosFornecedor(strCodFor: String);

      Procedure pBeforePost(dataSet: TDataSet);

      Function fCarregaCabecalhoOrcamento(strCodFor: String): Boolean;

      Function fRecalculaDescontoItensPrg(prgProgresso: TCxProgressBar): Boolean;

      function fMarcaDesmarcaTodos(prgProgresso: TCxProgressBar): Boolean;
      function fSintetizaUnidade(prgProgresso: TCxProgressBar): Boolean;


      function fValField(strNomField: String): Variant;
      procedure pCalculaTotalizador;

    Public

      TotalizadoresMarcado: TTotalizadoresMarcado;

      intCarPag: Integer;

      stlMeses: TStringList;

      blnGlobal,
      blnUsaDia,
      blnZonaFranca: Boolean;

      intMeses,
      intDecUni: Integer;

      cdsCabecOrc: TZClient;

      pEscreveTotalizadores: TEscreveTotalizadores;

      ParametrosCalcImpostos: TParametrosCalculoImposto;

      function fQtdItensMarcados: Integer;
      constructor Create(Owner: TComponent); Reintroduce; Overload;
      function fGetSQLMarcados: String;
      function fGetTotUnidades: String;
      Destructor Destroy; override;

      Class Function fDescricaoTipoPasta(tipConsulta: TTipoConsulta): String;

      Function fCarregaItens(strCodFor, strEmpHub, strCodIte, strCodSim, strCodMar, strCodDep: String; ticConsulta: TTipoConsulta; blnDesmarcaItens: Boolean = True; blnConsiderarProdSobEnc: Boolean = False; strLinGru: String = ''; strFilEmp: String = ''): Boolean;

      Procedure pRecalculaDescontoItens(fltDesAdi: Double);

      procedure pMarcaDesmarcaTodos(blnMarca: Boolean = False);
      procedure pMarcaDesmarca();
      procedure pTrataCdsMarcado(intMarcado: integer; strCodIte: String; strCodEmp: String);
      procedure objPreOrcamento;
      procedure pRecalculaValoresNivelGiroCriticidadeEQuantidades;

      procedure pReinciaTotalizador;

      procedure pFiltrarComSugestao(blnSemSugestao: Boolean);
      procedure pMostraResumoUnidades;

    End;

    const
    cMarcado = 1;
    cDesmarcado = 0;


implementation

Uses
  Math,
  Forms,
  untGravando,
  untPastaCompra, untTotalUnidades;



constructor TPreOrcamento.Create(Owner: TComponent);
Begin


  Inherited Create(Owner, '');

  cdsMarcados := TZClient.Create(Self, fGetSQLMarcados);
  cdsTotUnidade := TZClient.Create(Self, fGetTotUnidades);
  cdsTotUnidade.fLeDados('TPreOrcamento.Create');
  cdsTotUnidade.IndexFieldNames := 'UNI_CODUNI';

  Try
    cdsTotUnidade.qryQuery.Connection.ExecSQL('ALTER TABLE PRE_ORCAMENTO ADD PRIMARY KEY ( `PRE_CODITE`, `PRE_CODEMP`, `PRE_CODFOR` );');
  Except
    {se der erro esta ok, quer dizer que a chave ja existe}
  End;



  cdsMarcados.pCriaSoma('NivelGiroA', 'tot_NivelGiroA');
  cdsMarcados.pCriaSoma('NivelGiroB', 'tot_NivelGiroB');
  cdsMarcados.pCriaSoma('NivelGiroC', 'tot_NivelGiroC');
  cdsMarcados.pCriaSoma('CriticidaX', 'Tot_CriticidaX');
  cdsMarcados.pCriaSoma('CriticidaY', 'Tot_CriticidaY');
  cdsMarcados.pCriaSoma('CriticidaZ', 'Tot_CriticidaZ');
  cdsMarcados.pCriaSoma('TotalPedidoSelecionado', 'Tot_TotalPedidoSelecionado');
  cdsMarcados.pCriaSoma('TotalQtdSel', 'Tot_TotalQtdSel');
  cdsMarcados.pCriaSoma('TotalMetSel', 'Tot_TotalMetSel');
  cdsMarcados.pCriaSoma('TotalLitSel', 'Tot_TotalLitSel');
  cdsMarcados.pCriaSoma('TotalKilSel', 'Tot_TotalKilSel');


  cdsMarcados.fLeDados('TPreOrcamento.Create');

  cdsMarcados.IndexFieldNames := 'CODITE;CODEMP';
  intDecUni := fCfgSis('DECUNI', varInteger);

  strFRMPCM := fCfgSis('FRMPCM');

  blnGlobal  := fCfgSis('TIPPAS') = '2';

  blnZonaFranca := fEhEstadoRegraZonaFranca(fCadEmp('ESTADO'));

  stlMeses  := TStringList.Create;

  intMeses  := 3;

  pMontaNomeMeses;

  cdsCabecOrc := TZClient.Create(Self, fSQLCabecOrc);

  pReinciaTotalizador;

End;

Destructor TPreOrcamento.Destroy;
Begin
  FreeAndNil(cdsMarcados);
  FreeAndNil(cdsTotUnidade);
  Inherited;

  FreeAndNil(stlMeses);
End;

Class Function TPreOrcamento.fDescricaoTipoPasta(tipConsulta: TTipoConsulta): String;
Begin
  Case tipConsulta Of
    ticSatelites: Result := 'Satelites';
    ticSimilares: Result := 'Sililares';
    Else          Result := 'Compra';
  End;
End;

function TPreOrcamento.fGetTotUnidades: String;
begin
   Result := '';
   Result := Result + ' SELECT  UNI_CODUNI , UNI_SIGUNI, UNI_KILLIT, 0.0000 AS KILLIT, 0.0000 AS  METRAG';
   Result := Result + ' FROM CADUNI WHERE FALSE';
End;

function TPreOrcamento.fGetSQLMarcados: String;
begin
   Result := '';
   Result := Result + 'SELECT ';
   Result := Result + ' CAST("" AS CHAR(7)) AS CODITE,';
   Result := Result + ' CAST("" AS CHAR(7)) AS CODEMP,';
   Result := Result + ' 0 AS NivelGiroA,';
   Result := Result + ' 0 AS NivelGiroB,';
   Result := Result + ' 0 AS NivelGiroC,';
   Result := Result + ' 0 AS CriticidaX,';
   Result := Result + ' 0 AS CriticidaY,';
   Result := Result + ' 0 AS CriticidaZ,';
   Result := Result + ' 0.0000 AS TotalPedidoSelecionado,';
   Result := Result + ' 0.0000 AS TotalQtdSel,';
   Result := Result + ' 0.0000 AS TotalMetSel,';
   Result := Result + ' 0.0000 AS TotalLitSel,';
   Result := Result + ' 0.0000 AS TotalKilSel,';
   Result := Result + ' UNI_CODUNI,';
   Result := Result + ' UNI_SIGUNI,';
   Result := Result + ' UNI_KILLIT ';

   Result := Result + ' FROM CADEMP, CADUNI  WHERE FALSE';
end;

function TPreOrcamento.fMarcaDesmarcaTodos(prgProgresso: TCxProgressBar): Boolean;
var recNo: Integer;

begin
  inherited;

  RecNo := Self.RecNo;
  Self.DisableControls;
  Try
    Self.First;
    While not Self.EoF do
    Begin
      Try
        If Not fCfgSis('MARZER', varBoolean) Then
          If FblnMarca  And (Self.FieldByName('PRE_QTDITE').AsInteger = 0) Then
            Continue;
        Self.Edit;
        Self.FieldByName('MARDES').AsInteger := IIf(FblnMarca, cMarcado, cDesmarcado);
        Self.Post;
      Finally
        Self.Next;
      End;
    End;
    Result := True;
  Finally
    Self.RecNo := RecNo;
    Self.EnableControls;
  End;
end;

function TPreOrcamento.fQtdItensMarcados: Integer;
begin
  Self.Filtered := False;
  Self.Filter := 'MARDES = ' + IntToStr(cMarcado);
  Self.Filtered := True;
  Result := Self.RecordCount;
  Self.Filtered := False;
end;

Procedure TPreOrcamento.pMontaNomeMeses;
  Var
    dtaData: TDateTime;
    intContador: Integer;
Begin
  dtaData := VS_Date;

  For intContador := 0 To 12 Do
  Begin
    stlMeses.Add(FormatDateTime('MM/YYYY', dtaData));

    dtaData := IncMonth(dtaData, -1);
  End;
End;

procedure TPreOrcamento.pMostraResumoUnidades;
  var
    frmGravando: TfrmGravando;
begin
  TfrmGravando.fExecuta(fSintetizaUnidade, frmGravando, 'Calculando Totais por Unidade, aguarde...');


  TfrmTotalUnidades.pChamaTela(cdsTotUnidade);
end;

Function TPreOrcamento.fSQLDesmarcaItens(strCodFor, strEmpHub, strCodIte, strCodSim, strCodMar, strCodDep, strLinGru, strFilEmp: String; ticConsulta: TTipoConsulta; blnConsiderarProdSobEnc: Boolean): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' UPDATE ';
  strSQL := strSQL + '                            ';

  Case ticConsulta Of
    ticSimilares: strSQL := strSQL + ' PRE_SIMILARES      ';

    ticSatelites: If blnGlobal Then
                    strSQL := strSQL + ' PRE_ORCAMENTO_SATELITES '
                  Else
                    strSQL := strSQL + ' PRE_ORCAMENTO      ';

    Else          strSQL := strSQL + '     PRE_ORCAMENTO  ';
  End;

  strSQL := strSQL + '     INNER JOIN CADITE C ON PRE_CODITE = C.ITE_CODITE  ';

  strSQL := strSQL + '     INNER JOIN ITEGER G ON G.ITE_CODITE = C.ITE_CODITE  ';
  strSQL := strSQL + '                        AND G.ITE_CODEMP =   PRE_CODEMP  ';

  If fCfgSis('SITPRO', varBoolean) Then
  Begin
    If fCfgSis('SITEMP') = '1' Then
      strSQL := strSQL + '     LEFT JOIN SITPRO ON SIT_CODIGO = C.ITE_SITPRO  '
    Else
      strSQL := strSQL + '     LEFT JOIN SITPRO ON SIT_CODIGO = G.ITE_SITPRO  ';
  End;

  If ticConsulta = ticSimilares Then
    strSQL := strSQL + '     INNER JOIN CADMAR ON MAR_CODMAR = C.ITE_CODMAR  ';

  strSQL := strSQL + '     LEFT JOIN EMPBAN ON BAN_CODBAN = PRE_CODBAN ';

  strSQL := strSQL + '     SET MARDES = 0 ';

  strSQL := strSQL + '   WHERE TRUE                       ';
  If fCfgSis('SITPRO', varBoolean) Then
    strSQL := strSQL + '   AND IFNULL(SIT_PASCMP, "S") = "S" ';

  If strCodMar <> '' Then
    strSQL := strSQL + ' AND C.ITE_CODMAR = "' + strCodMar + '" ';

  If strCodMar <> '' Then
    strSQL := strSQL + ' AND C.ITE_CODMAR = "' + strCodMar + '" ';

  If strCodDep <> '' Then
    strSQL := strSQL + ' AND C.ITE_CODDEP = "' + strCodDep + '" ';

  Case ticConsulta Of
    ticSatelites: Begin
                    strSQL := strSQL + '    AND PRE_CODFOR = ' + QuotedStr(strCodFor);

                    If Not blnGlobal Then
                      strSQL := strSQL + '    AND PRE_TIPEMP IN (2, 3)    ';

                    strSQL := strSQL + '    AND PRE_EMPHUB = ' + QuotedStr(strEmpHub);
                    strSQL := strSQL + '    AND PRE_CODITE = ' + QuotedStr(strCodIte);
                  End;

    ticCompra   : Begin
                    strSQL := strSQL + '    AND PRE_CODFOR = ' + QuotedStr(strCodFor);
                  End;

    ticSimilares: Begin
                    strSQL := strSQL + '    AND PRE_CODSIM = ' + QuotedStr(strCodSim);
                  End;
  End;

  If Not blnConsiderarProdSobEnc Then
    strSQL := strSQL + ' AND G.ITE_SOBENC = "N"';

  If strLinGru <> '' Then
     strSQL := strSQL + strLinGru;

  If strFilEmp <> '' Then
     strSQL := strSQL + strFilEmp;

  Result := strSQL;
End;

Function TPreOrcamento.fSQLItens(strCodFor, strEmpHub, strCodIte, strCodSim, strCodMar, strCodDep, strLinGru, strFilEmp: String; ticConsulta: TTipoConsulta; blnConsiderarProdSobEnc: Boolean): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT              ';
  strSQL := strSQL + '   PRE_PONGER,       ';
  strSQL := strSQL + '   PRE_QESTPP,       ';
  strSQL := strSQL + '   PRE_CODBAN,       ';
  strSQL := strSQL + '   PRE_DESBAN,       ';
  strSQL := strSQL + '   PRE_CODEMP,       ';
  strSQL := strSQL + '   PRE_EMPHUB,       ';
  strSQL := strSQL + '   PRE_CODFOR,       ';
  strSQL := strSQL + '   PRE_SIGEMP,       ';
  strSQL := strSQL + '   PRE_CODITE,       ';
  strSQL := strSQL + '   PRE_CODSIM,       ';

  strSQL := strSQL + '   C.ITE_REFERE AS PRE_REFERE, ';
  strSQL := strSQL + '   ITE_DESITE AS PRE_DESITE, ';
  strSQL := strSQL + '   ITE_APLICA AS PRE_APLICA, ';

  strSQL := strSQL + '   G.ITE_PRECUS, ';
  strSQL := strSQL + '   C.ITE_INCPIS, ';

  strSQL := strSQL + '   PRE_MLTCOM,       ';
  strSQL := strSQL + '   PRE_NIVGIR,  ';
  strSQL := strSQL + '   ITE_NIVCRI, ';
  strSQL := strSQL + '   CONCAT(PRE_NIVGIR, " ", G.ITE_NIVCRI) AS  PRE_CRIGIR,  ';
  strSQL := strSQL + '   PRE_ESTTOT,       ';
  strSQL := strSQL + '   PRE_ESTDIS,       ';
  strSQL := strSQL + '   PRE_PEDCOM,       ';

  strSQL := strSQL + '   PRE_USAMES,       ';
  strSQL := strSQL + '   PRE_MESGIR,       ';
  strSQL := strSQL + '   PRE_DIAGIR,       ';

  strSQL := strSQL + '   PRE_MEDMES,       ';
  strSQL := strSQL + '   PRE_VMES00,       ';
  strSQL := strSQL + '   PRE_VMES01,       ';
  strSQL := strSQL + '   PRE_VMES02,       ';
  strSQL := strSQL + '   PRE_VMES03,       ';
  strSQL := strSQL + '   PRE_VMES04,       ';
  strSQL := strSQL + '   PRE_VMES05,       ';
  strSQL := strSQL + '   PRE_VMES06,       ';
  strSQL := strSQL + '   PRE_VMES07,       ';
  strSQL := strSQL + '   PRE_VMES08,       ';
  strSQL := strSQL + '   PRE_VMES09,       ';
  strSQL := strSQL + '   PRE_VMES10,       ';
  strSQL := strSQL + '   PRE_VMES11,       ';
  strSQL := strSQL + '   PRE_VMES12,       ';

  strSQL := strSQL + '   PRE_ESTMIN,       ';
  strSQL := strSQL + '   PRE_ESTMAX,       ';
  strSQL := strSQL + '   PRE_NECCOM,       ';
  strSQL := strSQL + '   PRE_NECAJU,       ';
  strSQL := strSQL + '   PRE_QTDITE,       ';
  strSQL := strSQL + '   PRE_VENDIA,       ';
  strSQL := strSQL + '   MARDES,      ';


  strSQL := strSQL + '   ITE_CODBAR, ';
  strSQL := strSQL + '   ITE_LOCFIS, ';
  strSQL := strSQL + '   ITE_FORULT, ';
  strSQL := strSQL + '   FOR_NOMFOR, ';

  strSQL := strSQL + '   CAST(IF(PRE_MEDMES > 0, (IFNULL(PRE_ESTDIS, 0) + IFNULL(PRE_PEDCOM, 0)) / (PRE_MEDMES / 30), NULL) AS DECIMAL(12,2))              AS PRE_DIAEST, ';
  strSQL := strSQL + '   CAST(IF(PRE_MEDMES > 0, (IFNULL(PRE_ESTDIS, 0) + IFNULL(PRE_PEDCOM, 0) + IFNULL(PRE_QTDITE, 0)) / (PRE_MEDMES / 30), NULL) AS DECIMAL(12,2)) AS PRE_DIASUG, ';
  strSQL := strSQL + '   CAST(IF(PRE_MEDMES > 0, IFNULL(PRE_ESTDIS, 0) / (PRE_MEDMES / 30), NULL) AS DECIMAL(12,2)) AS PRE_DESTRE, ';

  strSQL := strSQL + '   PRE_ANTIGO, ';
  strSQL := strSQL + '   PRE_PONPED, ';
  strSQL := strSQL + '   PRE_PONPED, ';


  strSQL := strSQL + '   1 AS PRE_INDIPP,  ';
  strSQL := strSQL + '   PRE_COMPEN,  ';
  strSQL := strSQL + '   PRE_MEDMEN,  ';

  strSQL := strSQL + '   PRE_VALUNI,  ';
  strSQL := strSQL + '   PRE_PERDES,  ';
  strSQL := strSQL + '   PRE_UNILIQ,  ';
  strSQL := strSQL + '   PRE_TOTITE,  ';
  strSQL := strSQL + '   0 AS ITE_VALFRE,  ';
  strSQL := strSQL + '   0 AS ITE_DESACE,  ';

  strSQL := strSQL + '   PRE_IPIENT,  ';
  strSQL := strSQL + '   PRE_TOTIPI,  ';
  strSQL := strSQL + '   PRE_TOTSUB,  ';
  strSQL := strSQL + '   PRE_PERSUB,  ';
  strSQL := strSQL + '   PRE_BASSUB,  ';

  strSQL := strSQL + '   PRE_PERFCP,  ';
  strSQL := strSQL + '   PRE_SUBFCP,  ';

  strSQL := strSQL + '   PRE_TOTSUB,  ';
  strSQL := strSQL + '   PRE_BASICM,  ';
  strSQL := strSQL + '   PRE_ALQICM,  ';
  strSQL := strSQL + '   PRE_VALICM,  ';
  strSQL := strSQL + '   PRE_VALTOT,  ';

  strSQL := strSQL + '   ITE_CICMDE,  ';
  strSQL := strSQL + '   ITE_CDPIOP,  ';
  strSQL := strSQL + '   ITE_DIDIOP,  ';

  strSQL := strSQL + '   CFGSIS.SIS_VALCFG AS CFG_LITGAL, ';
  strSQL := strSQL + '   C.ITE_FATCMP, ';
  strSQL := strSQL + '   UNI_METFAT, ';
  strSQL := strSQL + '   UNI_KILLIT, ';
  strSQL := strSQL + '   UNI_CODUNI, ';
  strSQL := strSQL + '   UNI_SIGUNI, ';
  strSQL := strSQL + '   CADUNI.UNI_PESLIT, ';

  strSQL := strSQL + '   IF(CADUNI.UNI_KILLIT = "K", ( PRE_QTDITE * CADUNI.UNI_PESLIT / IF(CFGSIS.SIS_VALCFG = "L", 1, 3.600)), 0) AS TOTKIL,   ';
  strSQL := strSQL + '   IF(CADUNI.UNI_KILLIT = "L", ( PRE_QTDITE * CADUNI.UNI_PESLIT / IF(CFGSIS.SIS_VALCFG = "L", 1, 3.600)), 0) AS TOTLIT,   ';
  strSQL := strSQL + '   IF(CADUNI.UNI_METFAT = "S", ( PRE_QTDITE * C.ITE_FATCMP), 0) AS TOTMET,    ';

  If blnGlobal And (ticConsulta = ticCompra) Then
  Begin
    strSQL := strSQL + '  PO.ITE_DTAULT,  '; // DATA DA ÚLTIMA COMPRA
    strSQL := strSQL + '  PO.ITE_DTAUVE,  '; // DATA DA ÚLTIMA VENDA
    strSQL := strSQL + '  IFNULL(PO.ITE_QTDUCO,0) AS ITE_QTDUCO,  ';
    strSQL := strSQL + '  PO.ITE_PREULT, ';
    strSQL := strSQL + '  PO.ITE_IMPULT, ';
  End Else
  Begin
    strSQL := strSQL + '   G.ITE_DTAULT,  '; // DATA DA ÚLTIMA COMPRA
    strSQL := strSQL + '   G.ITE_DTAUVE,  '; // DATA DA ÚLTIMA VENDA
    strSQL := strSQL + '   IFNULL(G.ITE_QTDUCO,0) AS ITE_QTDUCO,  ';
    strSQL := strSQL + '   G.ITE_PREULT,  ';
    strSQL := strSQL + '   G.ITE_IMPULT, ';
  End;

  strSQL := strSQL + '   ITE_SALEXT,  ';

  If ticConsulta = ticSimilares Then
    strSQL := strSQL + '   MAR_DESMAR,  ';

  strSQL := strSQL + '   BAN_CORBAN,   ';

  strSQL := strSQL + '   IF ( PRE_MEDMEN = 0 AND IFNULL (PRE_ESTDIS, 0) > PRE_ESTMAX, "Sim", "Não" ) AS ESTEXCESSO  ';

  strSQL := strSQL + '   FROM                         ';

  Case ticConsulta Of
    ticSimilares: strSQL := strSQL + ' PRE_SIMILARES PO     ';

    ticSatelites: If blnGlobal Then
                    strSQL := strSQL + ' PRE_ORCAMENTO_SATELITES PO '
                  Else
                    strSQL := strSQL + ' PRE_ORCAMENTO PO     ';

    Else          strSQL := strSQL + '     PRE_ORCAMENTO PO ';
  End;

  strSQL := strSQL + '     INNER JOIN CADITE C ON PRE_CODITE = C.ITE_CODITE  ';

  strSQL := strSQL + '     INNER JOIN ITEGER G ON G.ITE_CODITE = C.ITE_CODITE  ';
  strSQL := strSQL + '                        AND G.ITE_CODEMP =   PRE_CODEMP  ';

  strSQL := strSQL + '  INNER JOIN CFGSIS ON SIS_CODCFG  = "CFG_LITGAL" AND SIS_CODEMP = PRE_CODEMP ';
  strSQL := strSQL + '  LEFT JOIN CADUNI ON UNI_CODUNI = C.ITE_UNICOM ';


  strSQL := strSQL + '     INNER JOIN CADFOR ON FOR_CODFOR = PRE_CODFOR  ';

  If fCfgSis('SITPRO', varBoolean) Then
  Begin
    If fCfgSis('SITEMP') = '1' Then
      strSQL := strSQL + '     LEFT JOIN SITPRO ON SIT_CODIGO = C.ITE_SITPRO  '
    Else
      strSQL := strSQL + '     LEFT JOIN SITPRO ON SIT_CODIGO = G.ITE_SITPRO  ';
  End;

  If ticConsulta = ticSimilares Then
    strSQL := strSQL + '     INNER JOIN CADMAR ON MAR_CODMAR = C.ITE_CODMAR  ';

  strSQL := strSQL + '     LEFT JOIN EMPBAN ON BAN_CODBAN = PRE_CODBAN ';

  strSQL := strSQL + '   WHERE TRUE                       ';

  If fCfgSis('SITPRO', varBoolean) Then
    strSQL := strSQL + '   AND IFNULL(SIT_PASCMP, "S") = "S" ';

  If strCodMar <> '' Then
    strSQL := strSQL + ' AND C.ITE_CODMAR = "' + strCodMar + '" ';

  If strCodDep <> '' Then
    strSQL := strSQL + ' AND C.ITE_CODDEP = "' + strCodDep + '" ';

  Case ticConsulta Of
    ticSatelites: Begin
                    strSQL := strSQL + '    AND PRE_CODFOR = ' + QuotedStr(strCodFor);

                    If Not blnGlobal Then
                      strSQL := strSQL + '    AND PRE_TIPEMP IN (2, 3)    ';

                    strSQL := strSQL + '    AND PRE_EMPHUB = ' + QuotedStr(strEmpHub);
                    strSQL := strSQL + '    AND PRE_CODITE = ' + QuotedStr(strCodIte);
                  End;

    ticCompra   : Begin
                    strSQL := strSQL + '    AND PRE_CODFOR = ' + QuotedStr(strCodFor);
                  End;

    ticSimilares: Begin
                    strSQL := strSQL + '    AND PRE_CODSIM = ' + QuotedStr(strCodSim);
                  End;


  End;

  If Not blnConsiderarProdSobEnc Then
    strSQL := strSQL + ' AND G.ITE_SOBENC = "N"';

  If strLinGru <> '' Then
     strSQL := strSQL + strLinGru;

  If strFilEmp <> '' Then
     strSQL := strSQL + strFilEmp;

  Result := strSQL;
End;

function TPreOrcamento.fValField(strNomField: String): Variant;
begin
  Result := Self.FieldByName(strNomField).Value;
  If Result = null Then
  Begin
    Case Self.FieldByName(strNomField).DataType of
      ftFloat: Result := 0;
      ftInteger: Result := 0;
    Else
      Result := '';
    End
  End;
end;

procedure TPreOrcamento.objPreOrcamento;
begin

end;

Function TPreOrcamento.fRetMaxMeses(strCodFor, strEmpHub, strCodIte, strCodSim: String; ticConsulta: TTipoConsulta): Integer;
  Var
    strSQL: String;
    qryMes: TUniQuery;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT                        ';
  strSQL := strSQL + '   MAX(PRE_MESGIR) AS MESGIR,  ';
  strSQL := strSQL + '   SUM(IF(PRE_USAMES = "N", 1, 0)) AS USADIA  ';
  strSQL := strSQL + ' FROM                          ';

  Case ticConsulta Of
    ticSimilares: strSQL := strSQL + ' PRE_SIMILARES      ';

    ticSatelites: If blnGlobal Then
                    strSQL := strSQL + ' PRE_ORCAMENTO_SATELITES '
                  Else
                    strSQL := strSQL + ' PRE_ORCAMENTO      ';

    Else          strSQL := strSQL + '     PRE_ORCAMENTO  ';
  End;

  strSQL := strSQL + ' WHERE                        ';

  Case ticConsulta Of
    ticSatelites: Begin
                    strSQL := strSQL + '    PRE_CODFOR = ' + QuotedStr(strCodFor);
                 //   strSQL := strSQL + '    AND PRE_NECPRI > 0          ';

                    If Not blnGlobal Then
                      strSQL := strSQL + '    AND PRE_TIPEMP IN (2, 3)    ';

                    strSQL := strSQL + '    AND PRE_EMPHUB = ' + QuotedStr(strEmpHub);
                    strSQL := strSQL + '    AND PRE_CODITE = ' + QuotedStr(strCodIte);
                  End;

    ticCompra   : Begin
                    strSQL := strSQL + '    PRE_CODFOR = ' + QuotedStr(strCodFor);
                   // strSQL := strSQL + '    AND PRE_NECAJU > 0          ';
                  End;

    ticSimilares: Begin
                    strSQL := strSQL + '    PRE_CODSIM = ' + QuotedStr(strCodSim);
                  End;
  End;

  qryMes := fCriaQuery;
  qryMes.SQL.Text := strSQL;

  qryMes.Open;

  Result := qryMes.FieldByName('MESGIR').AsInteger;

  blnUsaDia := qryMes.FieldByName('USADIA').AsInteger > 0;

  FreeAndNil(qryMes);
End;

Function TPreOrcamento.fCarregaItens(strCodFor, strEmpHub, strCodIte, strCodSim, strCodMar, strCodDep : String; ticConsulta: TTipoConsulta; blnDesmarcaItens: Boolean = True; blnConsiderarProdSobEnc: Boolean = False; strLinGru: String = ''; strFilEmp: String = ''): Boolean;
Begin
  Try
    intMeses := fRetMaxMeses(strCodFor, strEmpHub, strCodIte, strCodSim, ticConsulta);

    If blnDesmarcaItens Then
    Begin
      Self.qryQuery.SQL.Text := fSQLDesmarcaItens(strCodFor, strEmpHub, strCodIte, strCodSim, strCodMar, strCodDep, strLinGru, strFilEmp, ticConsulta, blnConsiderarProdSobEnc);
      Self.qryQuery.ExecSQL;
    End;

    Self.qryQuery.SQL.Text := fSQLItens(strCodFor, strEmpHub, strCodIte, strCodSim, strCodMar, strCodDep, strLinGru, strFilEmp, ticConsulta, blnConsiderarProdSobEnc);


    Result := Self.fLeDados('TPreOrcamento.fCarregaItens', True, 'Aguarde, carregando itens...');

    ParametrosCalcImpostos.pSetaParametros(Self.FieldByName('ITE_CICMDE').AsString,
                                           Self.FieldByName('ITE_CDPIOP').AsString,
                                           Self.FieldByName('ITE_DIDIOP').AsString);
    ParametrosCalcImpostos.Param_Fornecedor.pCarregaConfiguracoes(strCodFor);

    If Result And (ticConsulta = ticCompra) Then
      Result := fCarregaCabecalhoOrcamento(strCodFor);

    Self.BeforePost := pBeforePost;

    Self.pAlinhaCampoCentro('PRE_SIGEMP');
    Self.pAlinhaCampoCentro('PRE_COMPEN');
    Self.pAlinhaCampoCentro('PRE_INDIPP');
    Self.pAlinhaCampoCentro('PRE_NIVGIR');
    Self.pAlinhaCampoCentro('PRE_CODITE');
    Self.pAlinhaCampoCentro('PRE_ANTIGO');

    Self.pAlinhaCampoCentro('ITE_DTAULT');  // DATA DA ÚLTIMA COMPRA
    Self.pAlinhaCampoCentro('ITE_DTAUVE');  // DATA DA ÚLTIMA VENDA


  Except
    on E: Exception do
    Begin
      pMensagensErro(E.Message, '[TPreOrcamento.fCarregaItens]');
      Result := False;
    End;
  End;
End;

Procedure TPreOrcamento.pBeforePost(dataSet: TDataSet);
  Var
    fltBasIcm,
    fltAlqIcm,
    fltValIcm,
    fltBaseST,
    fltDesPis,
    fltPerFCP,
    fltSubFCP,
    fltAlqIPI,
    fltBasIPI,
    fltValIPI,
    fltTotDar,
    fltAliquotaSub: Double;
    strCodSit,
    strCodSitOrigem: String;

Begin
  With DataSet Do
  Begin
    fltBaseST := 0;
    fltBasIcm := 0;
    fltAlqIcm := 0;
    fltValIcm := 0;

    ParametrosCalcImpostos.pSetaParametros(FieldByName('ITE_CICMDE').AsString,
                                           FieldByName('ITE_CDPIOP').AsString,
                                           FieldByName('ITE_DIDIOP').AsString);
    If Not fCfgSis('MARZER', varBoolean) Then
      If FieldByName('MARDES').AsInteger = cMarcado Then
        If FieldByName('PRE_QTDITE').AsFloat <= 0 Then
          FieldByName('MARDES').AsInteger := cDesmarcado;

    FieldByName('PRE_UNILIQ').AsFloat := RoundTo(FieldByName('PRE_VALUNI').AsFloat * (1 - FieldByName('PRE_PERDES').AsFloat / 100), -2);
    fltAlqIPI := FieldByName('PRE_IPIENT').AsFloat;
    fltBasIPI := FieldByName('PRE_TOTITE').AsFloat;

    FieldByName('PRE_COMPEN').AsInteger := IIF(FieldByName('PRE_ESTTOT').AsFloat <= FieldByName('PRE_QTDITE').AsFloat, 1, 0);

    FieldByName('PRE_TOTITE').AsFloat := RoundTo(FieldByName('PRE_UNILIQ').AsFloat * FieldByName('PRE_QTDITE').AsFloat, -2);


    If FieldByName('PRE_TOTITE').AsFloat > 0 Then
    Begin
      If FieldByName('PRE_CODFOR').AsString <> FCodFor Then
        pCarregaDadosFornecedor(FieldByName('PRE_CODFOR').AsString);

      FieldByName('PRE_TOTSUB').AsFloat := fCalcularSubstituicaoProduto(FieldByName('PRE_CODFOR').AsString,                        // strCodFor
                                                                        fRetornaAbreviacaoItem(FieldByName('PRE_CODITE').AsString),// strCodAbf
                                                                        FieldByName('PRE_TOTITE').AsFloat,                         // fltTotIte

                                                                        0, // Frete
                                                                        0, // DesAce

                                                                        strFRMPCM,                                                 // strFrmPcm

                                                                        'S', // Frete ST
                                                                        'S', // DesAce ST

                                                                        blnZonaFranca,                                             // blnZonaFranca
                                                                        FieldByName('ITE_INCPIS').AsString = 'S',                  // blnIncPis

                                                                        strSimPau = 'S',                                           // blnFornecSimples

                                                                        blnTemDare,
                                                                        fltAlqIPI,
                                                                        False,
                                                                        fltBasIcm,                                                 // var fltBasIcm
                                                                        fltAlqIcm,                                                 // var fltAlqIcm
                                                                        fltValIcm,                                                 // var fltValIcm
                                                                        fltBaseST,                                                 // var fltBaseST
                                                                        fltDesPis,                                                 // var fltDesPis
                                                                        fltBasIPI,
                                                                        fltValIPI,
                                                                        fltPerFCP,
                                                                        fltSubFCP,
                                                                        fltTotDar,
                                                                        strCodSit,
                                                                        strCodSitOrigem,                                                 // var strCodSit
                                                                        fltAliquotaSub,                                            // var fltAliquotaSub
                                                                        ParametrosCalcImpostos)
    End Else
    Begin
      FieldByName('PRE_TOTSUB').AsFloat := 0;
      fltValIPI := RoundTo(fltBasIpi * (fltAlqIPI / 100), -2);
    end;

    FieldByName('PRE_TOTIPI').AsFloat := fltValIPI;

    FieldByName('PRE_BASSUB').AsFloat := fltBaseST;
    FieldByName('PRE_BASICM').AsFloat := fltBasIcm;
    FieldByName('PRE_ALQICM').AsFloat := fltAlqIcm;
    FieldByName('PRE_VALICM').AsFloat := fltValIcm;

    FieldByName('PRE_PERSUB').AsFloat := fltAliquotaSub;
    FieldByName('PRE_PERFCP').AsFloat := fltPerFCP;
    FieldByName('PRE_SUBFCP').AsFloat := fltSubFCP;

    FieldByName('PRE_VALTOT').AsFloat := FieldByName('PRE_TOTITE').AsFloat +
                                         FieldByName('PRE_TOTIPI').AsFloat +
                                         FieldByName('PRE_SUBFCP').AsFloat +
                                         FieldByName('PRE_TOTSUB').AsFloat;

    If FieldByName('PRE_MEDMES').AsFloat > 0 Then
    Begin
      FieldByName('PRE_DIAEST').AsFloat := (FieldByName('PRE_ESTDIS').AsFloat + FieldByName('PRE_PEDCOM').AsFloat) / (FieldByName('PRE_MEDMES').AsFloat / 30);
      FieldByName('PRE_DIASUG').AsFloat := (FieldByName('PRE_QTDITE').AsFloat + FieldByName('PRE_ESTDIS').AsFloat + FieldByName('PRE_PEDCOM').AsFloat) / (FieldByName('PRE_MEDMES').AsFloat / 30);
    End;

    pRecalculaValoresNivelGiroCriticidadeEQuantidades;
    pTrataCDSMarcado(DataSet.FieldByName('MARDES').AsInteger, DataSet.FieldByName('PRE_CODITE').AsString, DataSet.FieldByName('PRE_CODEMP').AsString);
    If Assigned(pEscreveTotalizadores) Then
    Begin
      pCalculaTotalizador;
      pEscreveTotalizadores;
    End;

  End;
End;

procedure TPreOrcamento.pFiltrarComSugestao(blnSemSugestao: Boolean);
begin
  If blnSemSugestao Then
    Self.Filtered := False
  Else
  Begin
    Self.Filtered := False;
    Self.Filter   := 'PRE_NECAJU > 0';
    Self.Filtered := True;
  End
End;

procedure TPreOrcamento.pMarcaDesmarca();
begin
  If Not fCfgSis('MARZER', varBoolean) Then
    If (FieldByName('MARDES').AsInteger =  0) And (Self.FieldByName('PRE_QTDITE').AsInteger = 0) Then
      Exit;
  Self.Edit;
  Self.FieldByName('MARDES').AsInteger := IIf(FieldByName('MARDES').AsInteger = 1, cDesmarcado, cMarcado);
  Self.Post;
end;

procedure TPreOrcamento.pMarcaDesmarcaTodos(blnMarca: Boolean);
  var
    frmGravando: TfrmGravando;
Begin
  FblnMarca := blnMarca;
  TfrmGravando.fExecuta(fMarcaDesmarcaTodos, frmGravando, IIF(FblnMarca, 'Marcando', 'Desmarcando') + ' Itens, aguarde...');
end;

function TPreOrcamento.fSintetizaUnidade(prgProgresso: TCxProgressBar): Boolean;
var codUniAnt: String;
begin
  cdsTotUnidade.EmptyDataSet;
  cdsMarcados.First;
  prgProgresso.Properties.Max := cdsMarcados.RecordCount;
  cdsMarcados.IndexFieldNames := 'UNI_CODUNI';
  codUniAnt := '';
  While not cdsMarcados.Eof Do
  begin
    If codUniAnt <> cdsMarcados.FieldByName('UNI_CODUNI').AsString Then
    Begin
       codUniAnt := cdsMarcados.FieldByName('UNI_CODUNI').AsString;
       cdsTotUnidade.Insert;
       cdsTotUnidade.FieldByName('UNI_CODUNI').AsString := cdsMarcados.FieldByName('UNI_CODUNI').AsString;
       cdsTotUnidade.FieldByName('UNI_SIGUNI').AsString := cdsMarcados.FieldByName('UNI_SIGUNI').AsString;
       cdsTotUnidade.FieldByName('UNI_KILLIT').AsString := cdsMarcados.FieldByName('UNI_KILLIT').AsString;
    End
    Else
       cdsTotUnidade.Edit;
     cdsTotUnidade.FieldByName('KILLIT').AsFloat := cdsTotUnidade.FieldByName('KILLIT').AsFloat +
                                                    cdsMarcados.FieldByName('TotalLitSel').AsFloat +
                                                    cdsMarcados.FieldByName('TotalKilSel').AsFloat;
     cdsTotUnidade.FieldByName('METRAG').AsFloat := cdsTotUnidade.FieldByName('METRAG').AsFloat +
                                                    cdsMarcados.FieldByName('TotalMetSel').AsFloat;
    cdsTotUnidade.Post;
    prgProgresso.Position := prgProgresso.Position + 1;
    Application.ProcessMessages;
    cdsMarcados.Next;

  End;
  Result := True;
  cdsMarcados.IndexFieldNames := 'CODITE;CODEMP';

end;

Function TPreOrcamento.fSQLCabecOrc: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT * FROM GPREOR WHERE PRE_CODFOR = :CODFOR';
  Result := strSQL;
End;

procedure TPreOrcamento.pCalculaTotalizador;
begin
  TotalizadoresMarcado.qtdNivelGiroA := fDoubleAggregate(cdsMarcados, 'tot_NivelGiroA');
  TotalizadoresMarcado.qtdNivelGiroB := fDoubleAggregate(cdsMarcados, 'tot_NivelGiroB');
  TotalizadoresMarcado.qtdNivelGiroC := fDoubleAggregate(cdsMarcados, 'tot_NivelGiroC');
  TotalizadoresMarcado.qtdCriticidaX := fDoubleAggregate(cdsMarcados, 'Tot_CriticidaX');
  TotalizadoresMarcado.qtdCriticidaY := fDoubleAggregate(cdsMarcados, 'Tot_CriticidaY');
  TotalizadoresMarcado.qtdCriticidaZ := fDoubleAggregate(cdsMarcados, 'Tot_CriticidaZ');
  TotalizadoresMarcado.qtdItensSelec := cdsMarcados.RecordCount;
  TotalizadoresMarcado.fltTotalPedidoSelecionado := fDoubleAggregate(cdsMarcados, 'Tot_TotalPedidoSelecionado');
  TotalizadoresMarcado.fltTotalQtdSel := fDoubleAggregate(cdsMarcados, 'Tot_TotalQtdSel');
  TotalizadoresMarcado.fltTotalMetSel := fDoubleAggregate(cdsMarcados, 'Tot_TotalMetSel');
  TotalizadoresMarcado.fltTotalLitSel := fDoubleAggregate(cdsMarcados, 'Tot_TotalLitSel');
  TotalizadoresMarcado.fltTotalKilSel := fDoubleAggregate(cdsMarcados, 'Tot_TotalKilSel');
end;

Procedure TPreOrcamento.pCarregaDadosFornecedor(strCodFor: String);
  Var
    strSQL: String;
    qryCadFor: TUniQuery;
Begin
  qryCadFor := fCriaQuery;

  FCodFor := strCodFor;
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  FOR_SIMPAU, ';
  strSQL := strSQL + '  CID_ESTADO AS FOR_ESTADO ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADFOR ';
  strSQL := strSQL + 'LEFT JOIN CADCID ON FOR_CODCID = CID_CODCID ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  FOR_CODFOR = ' + QuotedStr(strCodFor);

  qryCadFor.SQL.Text := strSQL;
  qryCadFor.Open;

  strSimPau      := qryCadFor.FieldByName('FOR_SIMPAU').AsString;

  blnTemDare     := fEhEmpresaDARE And
                    (Not fEhEstadoRegraZonaFranca(qryCadFor.FieldByName('FOR_ESTADO').AsString));

  FreeAndNil(qryCadFor);
End;

Function TPreOrcamento.fCarregaCabecalhoOrcamento(strCodFor: String): Boolean;
Begin
  Try
    cdsCabecOrc.qryQuery.ParamByName('CODFOR').AsString := strCodFor;

    pCarregaDadosFornecedor(strCodFor);

    Result := cdsCabecOrc.fLeDados('TPreOrcamento.fCarregaCabecalhoOrcamento');

    If Result And cdsCabecOrc.IsEmpty Then
    Begin
      cdsCabecOrc.Insert;
      cdsCabecOrc.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('GPREOR', VS_strCodEmp);
      cdsCabecOrc.FieldByName('PRE_CODFOR').AsString := strCodFor;
      // É POR EMPRESA - TIRAR DÚVIDA
      cdsCabecOrc.FieldByName('PRE_DTAENT').Value := VS_Date + TPastaCompra.fPrazoEntrega(strCodFor, VS_strCodEmp); // Data Entrega

      cdsCabecOrc.FieldByName('PRE_DTAFAT').Value := VS_Date;
      cdsCabecOrc.FieldByName('PRE_CONPAG').Value := fCampoTabela('FOR_CNDPAG', 'CADFOR', ['FOR_CODFOR'], [strCodFor]);  // Cond. Pagamento
      cdsCabecOrc.FieldByName('PRE_DESADI').Value := 0;

      cdsCabecOrc.Post;

      cdsCabecOrc.fSalva;
    End;

    intCarPag := fCampoTabela('FOR_CARPAG', 'CADFOR', ['FOR_CODFOR'], [strCodFor]);

    TDateField(cdsCabecOrc.FieldByName('PRE_DTAENT')).EditMask := '99/99/9999';
    TDateField(cdsCabecOrc.FieldByName('PRE_DTAFAT')).EditMask := '99/99/9999';
    TFloatField(cdsCabecOrc.FieldByName('PRE_DESADI')).DisplayFormat := '#,##0.00';
    TStringField(cdsCabecOrc.FieldByName('PRE_CONPAG')).EditMask := '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999;0;_';
  Except
    on E: Exception do
    Begin
      pMensagensErro(E.Message, '[TPreOrcamento.fCarregaCabecalhoOrcamento]');
      Result := False;
    End;
  End;
End;

Procedure TPreOrcamento.pRecalculaDescontoItens(fltDesAdi: Double);
  Var
    frmGravando: TfrmGravando;
Begin
  FDesAdi := fltDesAdi;

  TfrmGravando.fExecuta(fRecalculaDescontoItensPrg, frmGravando, 'Recalculando orçamento, aguarde...');
End;

procedure TPreOrcamento.pRecalculaValoresNivelGiroCriticidadeEQuantidades;
begin

  Self.FieldByName('TOTKIL').AsFloat := iiF(fValField('UNI_KILLIT') = 'K', (fValField ('PRE_QTDITE') *  fValField('UNI_PESLIT') / IIf(fValField('CFG_LITGAL') = 'L', 1, 3.600)) , 0);
  Self.FieldByName('TOTLIT').AsFloat := iiF(fValField('UNI_KILLIT') = 'L', (fValField ('PRE_QTDITE') *  fValField('UNI_PESLIT') / IIf(fValField('CFG_LITGAL') = 'L', 1, 3.600)) , 0);
  Self.FieldByName('TOTMET').AsFloat := iiF(fValField('UNI_METFAT') = 'S', (fValField ('PRE_QTDITE') *  fValField('ITE_FATCMP')) , 0);

end;

procedure TPreOrcamento.pReinciaTotalizador;
begin
  TotalizadoresMarcado.qtdNivelGiroA := 0;
  TotalizadoresMarcado.qtdNivelGiroB := 0;
  TotalizadoresMarcado.qtdNivelGiroC := 0;
  TotalizadoresMarcado.qtdCriticidaX := 0;
  TotalizadoresMarcado.qtdCriticidaY := 0;
  TotalizadoresMarcado.qtdCriticidaZ := 0;
  TotalizadoresMarcado.qtdItensSelec := 0;

  TotalizadoresMarcado.fltTotalPedidoSelecionado := 0;
  TotalizadoresMarcado.fltTotalQtdSel := 0;
  TotalizadoresMarcado.fltTotalMetSel := 0;
  TotalizadoresMarcado.fltTotalLitSel := 0;
  TotalizadoresMarcado.fltTotalKilSel := 0;

end;

procedure TPreOrcamento.pTrataCdsMarcado(intMarcado: integer; strCodIte: String; strCodEmp: String);
begin
  cdsMarcados.First;
  //Se estiver desmarcado exlui esse registro do cdsMarcado
  If intMarcado = cDesmarcado Then
    If cdsMarcados.Locate('CODITE;CODEMP', varArrayOf([strCodite, strCodEmp]), []) Then
    Begin
      cdsMarcados.Delete;
      Exit;
    End;

  If intMarcado = cMarcado Then
  Begin
    // Se etiver marcado e o item exitir atualiza senão insere
    If cdsMarcados.Locate('CODITE;CODEMP', varArrayOf([strCodite, strCodEmp]), []) Then
      cdsMarcados.Edit
    Else
    begin
      cdsMarcados.Append;
      cdsMarcados.FieldByName('CODITE').AsString := strCodIte;
      cdsMarcados.FieldByName('CODEMP').AsString := strCodEmp;
    End;

    cdsMarcados.FieldByName('NivelGiroA').AsInteger := IIf(Self.FieldByName('PRE_NIVGIR').AsString = 'A', 1, 0);
    cdsMarcados.FieldByName('NivelGiroB').AsInteger := IIf(Self.FieldByName('PRE_NIVGIR').AsString = 'B', 1, 0);
    cdsMarcados.FieldByName('NivelGiroC').AsInteger := IIf(Self.FieldByName('PRE_NIVGIR').AsString = 'C', 1, 0);
    cdsMarcados.FieldByName('CriticidaX').AsInteger := IIf(Self.FieldByName('ITE_NIVCRI').AsString = 'X', 1, 0);
    cdsMarcados.FieldByName('CriticidaY').AsInteger := IIf(Self.FieldByName('ITE_NIVCRI').AsString = 'Y', 1, 0);
    cdsMarcados.FieldByName('CriticidaZ').AsInteger := IIf(Self.FieldByName('ITE_NIVCRI').AsString = 'Z', 1, 0);
    cdsMarcados.FieldByName('TotalPedidoSelecionado').AsFloat := Self.FieldByName('PRE_VALTOT').AsFloat;
    cdsMarcados.FieldByName('TotalQtdSel').AsFloat := Self.FieldByName('PRE_QTDITE').AsFloat;
    cdsMarcados.FieldByName('TotalMetSel').AsFloat := Self.FieldByName('TOTMET').AsFloat;
    cdsMarcados.FieldByName('TotalLitSel').AsFloat := Self.FieldByName('TOTLIT').AsFloat;
    cdsMarcados.FieldByName('TotalKilSel').AsFloat := Self.FieldByName('TOTKIL').AsFloat;

    cdsMarcados.FieldByName('UNI_CODUNI').AsString := Self.FieldByName('UNI_CODUNI').AsString;
    cdsMarcados.FieldByName('UNI_SIGUNI').AsString := Self.FieldByName('UNI_SIGUNI').AsString;
    cdsMarcados.FieldByName('UNI_KILLIT').AsString := Self.FieldByName('UNI_KILLIT').AsString;

    cdsMarcados.Post;
  End;
end;

Function TPreOrcamento.fRecalculaDescontoItensPrg(prgProgresso: TCxProgressBar): Boolean;
  Var
    intRecNo: Integer;
Begin
  Result := True;

  If IsEmpty Then
    Exit;

  DisableControls;

  intRecNo := RecNo;

  Try
    Filter   := 'PRE_QTDITE > 0';
    Filtered := True;

    prgProgresso.Properties.Max := RecordCount;

    First;

    While Not Eof Do
    Begin
      Edit;
      FieldByName('PRE_PERDES').AsFloat := FDesAdi;
      Post;

      Next;

      prgProgresso.Position := prgProgresso.Position + 1;
      Application.ProcessMessages;
    End;

  Finally

    Filtered := False;

    RecNo := intRecNo;

    EnableControls;
  End;

End;

end.


