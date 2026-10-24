unit untDocIT;

interface

uses Classes, StrUtils, SysUtils, frxClass, frxDBSet, UniClientDataSet, Controls,
  untTypesSistema, untLeDocumento, untFuncoesSimples, untZClient, Uni,
  System.Variants;

Type

  TLeDocumentoIT = Class(TLeDocumento)
  private
    cdsCadIte: TZClient;

    function fGetSQLGer: String;
    Function fInsereClientGer: Boolean;
    Function fGetOper_Solicitou_Imprimiu(strCodIte : String) : String;
    function fRetNomeDepartamentoOperador(strCodOpe: String): String;
  Public
    constructor Create(Owner: TComponent); Override;
    Destructor  Destroy; Override;

    Function fMontaClients(cdsDadosExternosMovGer: TZClient = nil; cdsDadosExternosMovDet: TZClient = nil): Boolean; Override;
    Function fRetornaPrecoPromocao :Double;
  End;

implementation

uses untConstantes, Data.DB, Math, untCadPro;

{ TLeDocumentoIT }

function TLeDocumentoIT.fRetornaPrecoPromocao :Double;
Var
  fltPreCus,
  fltPreVen,
  fltComVar,
  fltComAta,
  fltComDis,
  fltQtdDis,
  fltDesF07 :Double;

  blnParticiona,
  blnPromo :Boolean;
  strComPro: String;
  strCodPro: String;
Begin
  If (fRetornaPrecosPromocao(cdsCadIte.FieldByName('CODITE').AsString,
                          '', //strCodCli,
                          VS_Date,
                          1,
                          0,
                          0,
                          0, //intPraMedio,
                          fltPreCus,
                          fltPreVen,
                          fltComVar,
                          fltComAta,
                          fltComDis,
                          fltQtdDis,
                          fltDesF07,
                          strComPro,
                          strCodPro,
                          blnParticiona,
                          blnPromo,
                          '',
                          '',
                          '',
                          '',
                          False)) Then
  Begin
    Result := fltPreVen;
  End
  Else Result := 0.0000;
End;

function TLeDocumentoIT.fGetOper_Solicitou_Imprimiu(strCodIte : String) : String;
var
  qryOpe : TUniQuery;
begin

  Result := '';

  If fCfgSis('UTCSEA', varString) <> 'N' Then
  Begin

    qryOpe := fCriaQuery;

    try

      {
       Identifica quem solicitou/imprimiu o item (separação avulsa),
       Na tabela de controle de separação! Que é gravada somente quando
       a configuração "UTCSEA" esta habilitada!.
      }
      qryOpe.Close;
      qryOpe.SQL.Clear;
      qryOpe.SQL.Add('SELECT                         ');
      qryOpe.SQL.Add('  CSP_OPEIMP                   ');
      qryOpe.SQL.Add('FROM                           ');
      qryOpe.SQL.Add('  CONSEP                       ');
      qryOpe.SQL.Add('WHERE                          ');
      qryOpe.SQL.Add('  CSP_DTAIMP = CURRENT_DATE AND');
      qryOpe.SQL.Add('  CSP_CODITE = :CODITE         ');
      qryOpe.SQL.Add('ORDER BY                       ');
      qryOpe.SQL.Add('  CSP_HRAIMP DESC              ');
      qryOpe.SQL.Add('LIMIT 1                        ');

      qryOpe.ParamByName('CODITE').AsString := strCodIte;

      qryOpe.Open;

      If Not qryOpe.IsEmpty Then
        Result := qryOpe.FieldByName('CSP_OPEIMP').AsString;

    finally
      FreeAndNil(qryOpe);
    end;

  End
  Else
    Result := strLoginUsuarioLogado; {Se não for impressão por senha, retorna usuário logado!}

end;

function TLeDocumentoIT.fGetSQLGer: String;
  Var
    strIT: String;
    intIndex: Integer;
Begin
  strIT := '';
  strIT := strIT + 'SELECT SQL_NO_CACHE  ';

  strIT := strIT + '  :OPEIMP AS OPEIMP, ';
  strIT := strIT + '  :NOMOPE AS NOMOPE, ';
  strIT := strIT + '  :DEPOPE AS DEPOPE, ';
  strIT := strIT + '  :QTDSEP AS QTDSEP, ';

  strIT := strIT + '  ITE_APLICA AS APLICA, ';

  strIT := strIT + '  (SELECT GROUP_CONCAT(DISTINCT(LOT.LOT_LOCFIS))) AS LOCLOT, ';

  strIT := strIT + '  ITE_CODBAR AS CODBAR, ';
  strIT := strIT + '  ITE_CODGRU AS CODGRU, ';
  strIT := strIT + '  I.ITE_CODITE AS CODITE, ';
  strIT := strIT + '  (SELECT GROUP_CONCAT(CADSEM.SEM_CODSEM) ';
  strIT := strIT + '  FROM CADSEM ';
  strIT := strIT + '  WHERE CADSEM.SEM_CODITE = I.ITE_CODITE) AS CODSEM,';

  For intIndex := 0 To 9 Do
  Begin
    strIT := strIT + ' ( SELECT ITB_QTDEMB                         ';
    strIT := strIT + '   FROM ITEEMB                               ';
    strIT := strIT + '   WHERE ITB_CODITE = I.ITE_CODITE      ';
    strIT := strIT + '     AND ITB_CODEMP = I.ITE_CODEMP      ';
    strIT := strIT + '   ORDER BY ITB_QTDEMB DESC                  ';
    strIT := strIT + '   LIMIT '+ IntToStr(intIndex) +',1) AS QTDEM'+ IntToStr(intIndex) + ', ';

    strIT := strIT + ' ( SELECT ITB_DESCON                         ';
    strIT := strIT + '   FROM ITEEMB                               ';
    strIT := strIT + '   WHERE ITB_CODITE = I.ITE_CODITE      ';
    strIT := strIT + '     AND ITB_CODEMP = I.ITE_CODEMP      ';
    strIT := strIT + '   ORDER BY ITB_QTDEMB DESC                  ';
    strIT := strIT + '   LIMIT '+ IntToStr(intIndex) +',1) AS DESCO'+ IntToStr(intIndex) + ', ';

    strIT := strIT + ' ( SELECT ITB_TABPRE                         ';
    strIT := strIT + '   FROM ITEEMB                               ';
    strIT := strIT + '   WHERE ITB_CODITE = I.ITE_CODITE      ';
    strIT := strIT + '     AND ITB_CODEMP = I.ITE_CODEMP      ';
    strIT := strIT + '   ORDER BY ITB_QTDEMB DESC                  ';
    strIT := strIT + '   LIMIT '+ IntToStr(intIndex) +',1) AS TABPR'+ IntToStr(intIndex) + ', ';
  End;

  strIT := strIT + '  COALESCE(B.BAR_DESCRI, "") AS DESEMB ,';
  strIT := strIT + '  ITE_DESFEC AS DESFEC, ';
  strIT := strIT + '  ITE_DESITE AS DESITE, ';
  strIT := strIT + '  ITE_DESSIM AS DESSIM, ';
  strIT := strIT + '  ITE_EMBALA AS EMBALA, ';
  strIT := strIT + '  ITE_EMBFEC AS EMBFEC, ';
  strIT := strIT + '  IF(IFNULL(B.BAR_PREVEN, 0) =  0, 0.00, B.BAR_PREVEN) AS EMBPRE, ';
  strIT := strIT + '  EMP_C_G_C_ AS EMPCGC, ';
  strIT := strIT + '  EMP_NOMEMP AS NOMEMP, ';
  strIT := strIT + '  "" AS ESPDOC, ';
  strIT := strIT + '  ITE_CODFAB AS CODFAB, ';
  strIT := strIT + '  CONCAT(I.ITE_CODFAB, " ", CADMAR.MAR_DESMAR) AS FABMAR,  ';
  strIT := strIT + '  EMP_FONDA1 AS FONDA1,  ';
  strIT := strIT + '  EMP_FONDA2 AS FONDA2,  ';

  For intIndex := 1 To 7 Do
  Begin
    If fCfgSis('IMPPAG', varInteger) = 1 Then
    Begin
      //Internacional
      strIT := strIT + ' ITE_PREVE' + IntToStr(intIndex) + ' * IFNULL(ABF_PEIMPG, 0) /100 AS IBPIT' + IntToStr(intIndex) + ' ,';
      //Federal
      strIT := strIT + ' ITE_PREVE' + IntToStr(intIndex) + ' * IFNULL(ABF_PEIMPG, 0) /100 AS IBPFT' + IntToStr(intIndex) + ' ,';
      //Estadual
      strIT := strIT + ' ITE_PREVE' + IntToStr(intIndex) + ' * IFNULL(ABF_PEIMPG, 0) /100 AS IBPET' + IntToStr(intIndex) + ' ,';
      //Municipal
      strIT := strIT + ' ITE_PREVE' + IntToStr(intIndex) + ' * IFNULL(ABF_PEIMPG, 0) /100 AS IBPMT' + IntToStr(intIndex) + ' ,';
    End
    Else
    Begin
      //Internacional
      strIT := strIT + ' ITE_PREVE' + IntToStr(intIndex) + ' * IFNULL(IBP_ALQIMP, 0) /100 AS IBPIT' + IntToStr(intIndex) + ', ';
      //Federal
      strIT := strIT + ' ITE_PREVE' + IntToStr(intIndex) + ' * IFNULL(IBP_ALQNAC, 0) /100 AS IBPFT' + IntToStr(intIndex) + ', ';
      //Estadual
      strIT := strIT + ' ITE_PREVE' + IntToStr(intIndex) + ' * IFNULL(IBP_ALQEST, 0) /100 AS IBPET' + IntToStr(intIndex) + ', ';
      //Municipal
      strIT := strIT + ' ITE_PREVE' + IntToStr(intIndex) + ' * IFNULL(IBP_ALQMUN, 0) /100 AS IBPMT' + IntToStr(intIndex) + ', ';
    End;
  End;

  strIT := strIT + '  "" AS INFADI, ';
  strIT := strIT + '  ITE_LOCFIS AS LOCFIS, ';
  strIT := strIT + '  ITE_LOCSUP AS LOCSUP, ';
  strIT := strIT + '  "" AS LOTECR, ';
  strIT := strIT + '  CADMAR.MAR_DESMAR AS DESMAR, ';
  strIT := strIT + '  "" AS MOTBAI, ';
  strIT := strIT + '  "" AS NUMDOC, ';
  strIT := strIT + '  "" AS OBSREF, ';
  strIT := strIT + '  ITE_PREVE1 AS PREVE1, ';
  strIT := strIT + '  ITE_PREVE2 AS PREVE2, ';
  strIT := strIT + '  ITE_PREVE3 AS PREVE3, ';
  strIT := strIT + '  ITE_PREVE4 AS PREVE4, ';
  strIT := strIT + '  ITE_PREVE5 AS PREVE5, ';
  strIT := strIT + '  ITE_PREVE6 AS PREVE6, ';
  strIT := strIT + '  ITE_PREVE7 AS PREVE7, ';
  strIT := strIT + '  "" AS PREVIS, ';
  strIT := strIT + '  0.00 AS PROMOC, ';

  For intIndex := 0 To 9 Do
  Begin
    strIT := strIT + ' ( SELECT ITB_QTDEMB                         ';
    strIT := strIT + '   FROM ITEEMB                               ';
    strIT := strIT + '   WHERE ITB_CODITE = I.ITE_CODITE      ';
    strIT := strIT + '     AND ITB_CODEMP = I.ITE_CODEMP      ';
    strIT := strIT + '   ORDER BY ITB_QTDEMB DESC                  ';
    strIT := strIT + '   LIMIT '+ IntToStr(intIndex) +',1) AS QTDEM'+ IntToStr(intIndex) + ', ';

    strIT := strIT + ' ( SELECT ITB_DESCON                         ';
    strIT := strIT + '   FROM ITEEMB                               ';
    strIT := strIT + '   WHERE ITB_CODITE = I.ITE_CODITE      ';
    strIT := strIT + '     AND ITB_CODEMP = I.ITE_CODEMP      ';
    strIT := strIT + '   ORDER BY ITB_QTDEMB DESC                  ';
    strIT := strIT + '   LIMIT '+ IntToStr(intIndex) +',1) AS DESCO'+ IntToStr(intIndex) + ', ';

    strIT := strIT + ' ( SELECT ITB_TABPRE                         ';
    strIT := strIT + '   FROM ITEEMB                               ';
    strIT := strIT + '   WHERE ITB_CODITE = I.ITE_CODITE      ';
    strIT := strIT + '     AND ITB_CODEMP = I.ITE_CODEMP      ';
    strIT := strIT + '   ORDER BY ITB_QTDEMB DESC                  ';
    strIT := strIT + '   LIMIT '+ IntToStr(intIndex) +',1) AS TABPR'+ IntToStr(intIndex) + ', ';
  End;

  strIT := strIT + '  I.ITE_QTDETI AS QTDETI, ';
  strIT := strIT + '  "" AS QTDPAR, ';  // Qtd de Parcelas
  strIT := strIT + '  ITE_REFERE AS REFERE, ';
  strIT := strIT + '  ITE_SALDOS AS SALDOS, ';
  strIT := strIT + '  ITE_TABEMF AS TABEMF, ';

  strIT := strIT + '  UNI_SIGUNI AS SIGUNI, ';
  strIT := strIT + '  "" AS VALITE, ';
  strIT := strIT + '  "" AS VALVIS, ';

  {Localizações Adicionais}
  If fCfgSis('CADLOC', varBoolean) Then
  Begin
    strIT := strIT + ' (SELECT                                 ';
    strIT := strIT + '    GROUP_CONCAT(CADLOC.LOC_DESCRI)      ';
    strIT := strIT + '  FROM                                   ';
    strIT := strIT + '    LOCFIS                               ';
    strIT := strIT + '    INNER JOIN CADLOC ON (CADLOC.LOC_CODLOC = LOCFIS.LOC_LOCFIS AND ';
    strIT := strIT + '                          CADLOC.LOC_CODEMP = LOCFIS.LOC_CODEMP)    ';
    strIT := strIT + '  WHERE                                  ';
    strIT := strIT + '    LOCFIS.LOC_CODITE = I.ITE_CODITE AND ';
    strIT := strIT + '    LOCFIS.LOC_CODEMP = :CODEMP      AND ';
    strIT := strIT + '    CADLOC.LOC_ATIVO_ <> "N") AS LOCADI,  ';
  End
  Else
  Begin
    strIT := strIT + ' (SELECT                                 ';
    strIT := strIT + '    GROUP_CONCAT(LOC_LOCFIS)             ';
    strIT := strIT + '  FROM                                   ';
    strIT := strIT + '    LOCFIS                               ';
    strIT := strIT + '  WHERE                                  ';
    strIT := strIT + '    LOC_CODITE = I.ITE_CODITE AND        ';
    strIT := strIT + '    LOC_CODEMP = :CODEMP) AS LOCADI, ';
  End;


  strIT := strIT + ' (SELECT  GROUP_CONCAT(IFNULL(I2.ITE_CODITE, ""))  FROM CADITE AS I2 WHERE I2.ITE_CODSIM = I.ITE_CODSIM) AS CODSIM, ';
  strIT := strIT + ' (SELECT  CLI_CODCLI FROM CADCLI WHERE CLI_CODCLI = :CODCLI) AS CODCLI, ';
  strIT := strIT + ' (SELECT  CLI_NOMCLI FROM CADCLI WHERE CLI_CODCLI = :CODCLI) AS NOMCLI, ';

  strIT := strIT + '  ITE_MSGLV1 AS MSGLV1 ';

  strIT := strIT + '  FROM ';
  strIT := strIT + '  CADITE I ';
  strIT := strIT + '  LEFT JOIN ITEGER G ';
  strIT := strIT + '  ON I.ITE_CODITE = G.ITE_CODITE ';
  strIT := strIT + '  AND G.ITE_CODEMP = :CODEMP ';

  strIT := strIT + '  LEFT JOIN ITEBAR B ';
  strIT := strIT + '  ON B.BAR_CODITE = I.ITE_CODITE ';
  strIT := strIT + '  AND B.BAR_CODEMP = :CODEMP ';

  strIT := strIT + '  LEFT JOIN CADEMP E ';
  strIT := strIT + '  ON E.EMP_CODEMP = :CODEMP ';

  strIT := strIT + '  LEFT JOIN CADIBP IBPT ';
  strIT := strIT + '  ON ((IBP_N_C_M_ = I.ITE_CLAIPI) OR (IBP_N_C_M_ = LEFT(I.ITE_CLAIPI, 4)) OR (IBP_N_C_M_ = LEFT(I.ITE_CLAIPI, 2))) ';

  strIT := strIT + '  LEFT JOIN CADUNI ';
  strIT := strIT + '  ON UNI_CODUNI = I.ITE_CODUNI ';

  strIT := strIT + '  LEFT JOIN ABFICM ON ABF_CODABF = I.ITE_CODABF ';

  strIT := strIT + '  LEFT JOIN CADMAR ON CADMAR.MAR_CODMAR = I.ITE_CODMAR ';

  strIT := strIT + '  LEFT JOIN CADLOT LOT ON G.ITE_CODITE = LOT.LOT_CODITE ';
  strIT := strIT + '  AND G.ITE_CODEMP = LOT.LOT_CODEMP ';
  strIT := strIT + '  AND IFNULL(LOT.LOT_LOCFIS,"") <> "" ';

  strIT := strIT + 'WHERE ';

  strIT := strIT + '  I.ITE_CODITE = :CODITE AND ';
  strIT := strIT + '  G.ITE_CODEMP = :CODEMP     ';

  strIT := strIT + '  LIMIT 1 ';

  Result := strIT;
end;

function TLeDocumentoIT.fInsereClientGer: Boolean;
begin
  SetLength(arrClients, Succ(Length(arrClients)));
  With arrClients[High(arrClients)] Do
  Begin
    cdsDados := TZClient.Create(Nil, fGetSQLGer);
    frxDados := TfrxDBDataset.Create(Nil);
    frxDados.DataSet := cdsDados;
    frxDados.Name     := 'frxMovger';
    frxDados.UserName := 'frxMovger';
  End;

  With arrClients[High(arrClients)], cdsDados, qryQuery, recDocume Do
  Begin
    ParamByName('CODITE').AsString := recDocume.strCodIte;
    ParamByName('CODEMP').AsString := recDocume.strCodEmp;
    ParamByName('CODCLI').AsString := recDocume.strCodCli;
    ParamByName('QTDSEP').AsFloat  := recDocume.fltQtdSep;

    {Operador que solicitou/imprimiu}
    ParamByName('OPEIMP').AsString := fGetOper_Solicitou_Imprimiu(strCodIte);
    ParamByName('NOMOPE').AsString := fRetNomeOperador(ParamByName('OPEIMP').AsString);
    ParamByName('DEPOPE').AsString := fRetNomeDepartamentoOperador(ParamByName('OPEIMP').AsString);

    Result := fAbreClient(True, 'fInsereClientGer');
  End;
end;

function TLeDocumentoIT.fMontaClients(cdsDadosExternosMovGer,
  cdsDadosExternosMovDet: TZClient): Boolean;
begin
  inherited;

  Try
    Result := fInsereClientGer;

    cdsCadIte := arrClients[0].cdsDados;

    If (not cdsCadIte.IsEmpty) Then Begin
      cdsCadIte.Edit();
      cdsCadIte.FieldByName('PROMOC').AsFloat := fRetornaPrecoPromocao;
      cdsCadIte.Post();
    End;

    Result := Result And fPreparaImpressaoDocumentos;

    If Result Then pSetaOrdenacao;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fMontaClients]');
    End;
  End;
end;

function TLeDocumentoIT.fRetNomeDepartamentoOperador(strCodOpe: String): String;
var
  strCodDep: String;
Begin
  Result := '';
  strCodDep := '';
  If fEmptyStr(strCodOpe) Then
    Exit;
  strCodDep := fCampoTabela('OPE_CODDEP', 'CADOPE', ['OPE_CODOPE'], [strCodOpe], False);
  if fEmptyStr(strCodDep) then
    Exit;
  Result := strCodDep + ' - ' + fCampoTabela('DEP_DESCRI', 'CADDEP', ['DEP_CODIGO'], [strCodDep], False);
End;

constructor TLeDocumentoIT.Create(Owner: TComponent);
begin
  inherited;
end;

destructor TLeDocumentoIT.Destroy;
begin
  {}
  inherited;
end;

end.
