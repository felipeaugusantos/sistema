unit untAbastecimentoDepositoDevolucaoEntradaMercadoria;

interface

uses
 Classes, Uni, Data.DB, System.Generics.Collections, Shared.Functions.DataSet,
 System.SysUtils, System.StrUtils, untFuncFatTypes, untFuncFat, untFatAltEmpFatPedido,
 System.Variants, untFuncoesSimples, UniClientDataSet, untFuncoes, untPesqAux,
 untEmissaoNotaEspecial;

type
  TAbastecimentoDepositoDevolucaoEntradaMercadoria = class
    private
      FAutIncDocumentoDevolucao: String;
      FEmpresaAbastecimento: String;
      FCodCnd: String;
      FFatVenda: TFatVenda;
      procedure pCarregaFatVendas;
      procedure pCarregaVendedor;
      procedure pCarregaCondicao;
      function fRotinaVendeMadeiraOuVidroOuMetroLinear: Boolean;
    public
      constructor Create(AAutIncDocDev, AEmpresaAbastecimento, ACodCnd: String);
      destructor Destroy; override;
      procedure pTransfereEstoqueDevolucaoNotaEntrada;
  end;

implementation

{ TAbastecimentoDepositoDevolucaoEntradaMercadoria }

constructor TAbastecimentoDepositoDevolucaoEntradaMercadoria.Create(
  AAutIncDocDev, AEmpresaAbastecimento, ACodCnd: String);
begin
  FAutIncDocumentoDevolucao := AAutIncDocDev;
  FEmpresaAbastecimento := AEmpresaAbastecimento;
  FCodCnd := ACodCnd;

  FFatVenda := TFatVenda.CreateInstance('VN');
  pCriarCdsVenda(FFatVenda);
end;

destructor TAbastecimentoDepositoDevolucaoEntradaMercadoria.Destroy;
begin
  pFreeCdsVenda;
  FreeAndNil(FFatVenda);
  inherited;
end;

function TAbastecimentoDepositoDevolucaoEntradaMercadoria.fRotinaVendeMadeiraOuVidroOuMetroLinear: Boolean;
begin
  Result := False;

  If (fCfgSis('VENMAD', varBoolean)) Then
    Exit(True);

  If (fCfgSis('VENVID', varBoolean)) Then
    Exit(True);

  If (fCfgSis('VENMTL', varBoolean)) Then
    Exit(True);
end;

procedure TAbastecimentoDepositoDevolucaoEntradaMercadoria.pCarregaCondicao;
var
  LConCnd: TUniQuery;
begin
  LConCnd := fCriaQuery(FFatVenda);

  try
    pPesquisaCadCnd(LConCnd, LConCnd, FFatVenda.strCodCnd);
    If (Not LConCnd.IsEmpty) Then
    Begin
      FFatVenda.strCodCnd := LConCnd.FieldByName('CND_CODIGO').AsString;
      FFatVenda.strDesCnd := LConCnd.FieldByName('CND_DESCRI').AsString;
      FFatVenda.pAtualizaInformacoesCondPagamento(LConCnd);
    End;
  finally
    FreeAndNil(LConCnd);
  end;
end;

procedure TAbastecimentoDepositoDevolucaoEntradaMercadoria.pCarregaFatVendas;
var
  objNotaDevolucao: IMyCampoTabela;
  strSQL: String;
  strPreIte,
  strTePrev: String;
  qryGenGer: TUniQuery;
  strTabela: String;
  strMovMad: String;
  strTabela2:String;
  blnAvisarOperadorVendaComPrecoCusto : Boolean;
begin
  objNotaDevolucao := fCampoTabela(['GER_NUMDOC','GER_ESPDOC','GER_CODEMP','GER_CODCLI'],'MOVGER',['AUTOINCREM'],[FAutIncDocumentoDevolucao],False);

  qryGenGer := fCriaQuery(FFatVenda);

  try
    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   CADCLI.*,   ';
    strSQL := strSQL + '   GER_NUMDOC, ';
    strSQL := strSQL + '   GER_ESPDOC, ';
    strSQL := strSQL + '   GER_CODEMP, ';
    strSQL := strSQL + '   GER_CODCLI, ';
    strSQL := strSQL + '   GER_CONPAG, ';
    strSQL := strSQL + '   GER_CONSUM, ';
    strSQL := strSQL + '   GER_TABPRE, ';
    strSQL := strSQL + '   IF( GER_NOMCON IS NULL, CLI_NOMCLI, GER_NOMCON) AS GER_NOMCLI, ';
    strSQL := strSQL + '   IF( GER_ENDCON IS NULL, CLI_ENDERE, GER_ENDCON) AS GER_ENDCLI, ';
    strSQL := strSQL + '   IF( GER_ENDCON IS NULL, CLI_ENDNUM, "") AS GER_ENDNUM, ';
    strSQL := strSQL + '   IF( GER_BAICON IS NULL, CLI_BAIRRO, GER_BAICON) AS GER_BAICLI, ';
    strSQL := strSQL + '   IF( GER_CEPCON IS NULL, CLI_C_E_P_, GER_CEPCON) AS GER_CEPCLI, ';
    strSQL := strSQL + '   IF( GER_CIDCON IS NULL, CLI_CODCID, GER_CIDCON) AS GER_CIDCLI, ';
    strSQL := strSQL + '   CID_NOMCID AS GER_NOMCID, ';
    strSQL := strSQL + '   IF( GER_ESTCON IS NULL, CID_ESTADO, GER_ESTCON) AS GER_ESTCLI, ';
    strSQL := strSQL + '   IF( GER_TELCON IS NULL, CLI_FONE01, GER_TELCON) AS GER_TELCLI, ';
    strSQL := strSQL + '   IF( AUX_NASCON IS NULL, CLI_NASCIM, AUX_NASCON) AS AUX_NASCON, ';
    strSQL := strSQL + '   IF( GER_CGCCPF IS NULL, CLI_CGCCPF, GER_CGCCPF) AS GER_CGCCPF, ';
    strSQL := strSQL + '   IF( GER_CGCCON IS NULL, CLI_C_G_C_, GER_CGCCON) AS GER_CGCCLI, ';
    strSQL := strSQL + '   IF( GER_IESCON IS NULL, CLI_I_E_S_, GER_IESCON) AS GER_IESCLI, ';
    strSQL := strSQL + '   IF( GER_R_GCON IS NULL, CLI_NUMR_G, GER_R_GCON) AS GER_R_GCLI, ';
    strSQL := strSQL + '   GER_CODFPG, ';
    strSQL := strSQL + '   GER_CODCND, ';
    strSQL := strSQL + '   GER_CODVEN, ';
    strSQL := strSQL + '   GER_CODDIG, ';
    strSQL := strSQL + '   GER_MEN001, ';
    strSQL := strSQL + '   GER_MEN002, ';
    strSQL := strSQL + '   GER_MEN003, ';
    strSQL := strSQL + '   GER_MEN004, ';
    strSQL := strSQL + '   GER_MEN005, ';
    strSQL := strSQL + '   GER_TIPFRE, ';
    strSQL := strSQL + '   GER_TOTFRE, ';
    strSQL := strSQL + '   GER_DESACE, ';
    strSQL := strSQL + '   GER_DTAENT, ';
    strSQL := strSQL + '   GER_CODTRA, ';
    strSQL := strSQL + '   GER_VOLUME, ';
    strSQL := strSQL + '   GER_ESPECI, ';
    strSQL := strSQL + '   GER_DESESP ';
    strSQL := strSQL + '  FROM MOVGER  ';
    strSQL := strSQL + '  JOIN CADCLI ON CLI_CODCLI = GER_CODCLI ';
    strSQL := strSQL + '  JOIN CADCID ON IF(GER_CIDCON IS NULL, CLI_CODCID, GER_CIDCON) = CID_CODCID ';
    strSQL := strSQL + '  LEFT JOIN AUXMOV ON AUX_SEQGER = MOVGER.AUTOINCREM ';
    strSQL := strSQL + ' WHERE GER_NUMDOC = :NUMDOC ';
    strSQL := strSQL + '   AND GER_ESPDOC = :ESPDOC ';
    strSQL := strSQL + '   AND GER_CODEMP = :CODEMP ';

    strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(strSQL,'MOVGER','NOTGER'), 'AUXMOV', 'AUXNOT') + ' LIMIT 1 ';

    qryGenGer.Close;
    qryGenGer.SQL.Clear;
    qryGenGer.SQL.Add(strSQL);
    qryGenGer.ParamByName('NUMDOC').AsString := objNotaDevolucao.FieldByName('GER_NUMDOC').AsString;
    qryGenGer.ParamByName('ESPDOC').AsString := objNotaDevolucao.FieldByName('GER_ESPDOC').AsString;
    qryGenGer.ParamByName('CODEMP').AsString := objNotaDevolucao.FieldByName('GER_CODEMP').AsString;
    qryGenGer.Open;

    FFatVenda.strCodCli := qryGenGer.FieldByName('GER_CODCLI').AsString;
    FFatVenda.strNumDoc := objNotaDevolucao.FieldByName('GER_NUMDOC').AsString;
    FFatVenda.strEspDoc := objNotaDevolucao.FieldByName('GER_ESPDOC').AsString;
    FFatVenda.strEmpDoc := objNotaDevolucao.FieldByName('GER_CODEMP').AsString;
    FFatVenda.strCodCnd := FCodCnd;
    FFatVenda.strConPag := fCampoTabela('CND_CNDPAG', 'CADCND', ['CND_CODIGO'], [FCodCnd], False);
    FFatVenda.strCodFpg := fCampoTabela('CND_CODFPG', 'CADCND', ['CND_CODIGO'], [FCodCnd], False);


    pCarregaCondicao;


    FFatVenda.strMen001 := qryGenGer.FieldByName('GER_MEN001').AsString;
    FFatVenda.strMen002 := qryGenGer.FieldByName('GER_MEN002').AsString;
    FFatVenda.strMen003 := qryGenGer.FieldByName('GER_MEN003').AsString;
    FFatVenda.strMen004 := qryGenGer.FieldByName('GER_MEN004').AsString;
    FFatVenda.strMen005 := qryGenGer.FieldByName('GER_MEN005').AsString;

    FFatVenda.strTipFre := qryGenGer.FieldByName('GER_TIPFRE').AsString;
    FFatVenda.fltValFre := qryGenGer.FieldByName('GER_TOTFRE').AsFloat;
    FFatVenda.strCodTra := qryGenGer.FieldByName('GER_CODTRA').AsString;

    FFatVenda.intQtdTra := qryGenGer.FieldByName('GER_VOLUME').AsInteger;
    FFatVenda.strEspTra := qryGenGer.FieldByName('GER_ESPECI').AsString;

    If fEmptyStr(FFatVenda.strCodTra) Then
      FFatVenda.strCodTra := fCfgSis('TRASUG');

    If fEmptyStr(FFatVenda.strTipFre) Then
      FFatVenda.strTipFre := '1';

    FFatVenda.strTabPre := qryGenGer.FieldByName('GER_TABPRE').AsString;

    FFatVenda.strCodDig := qryGenGer.FieldByName('GER_CODDIG').AsString;
    FFatVenda.strCodVen := qryGenGer.FieldByName('GER_CODVEN').AsString;
    pCarregaVendedor;

    FFatVenda.strCliNom := qryGenGer.FieldByName('GER_NOMCLI').AsString;
    FFatVenda.strCliOri := qryGenGer.FieldByName('GER_NOMCLI').AsString;
    FFatVenda.strCliEnd := qryGenGer.FieldByName('GER_ENDCLI').AsString;
    FFatVenda.strCliNum := qryGenGer.FieldByName('GER_ENDNUM').AsString;
    FFatVenda.strCliBai := qryGenGer.FieldByName('GER_BAICLI').AsString;
    FFatVenda.strCliCep := qryGenGer.FieldByName('GER_CEPCLI').AsString;
    FFatVenda.strCodCid := qryGenGer.FieldByName('GER_CIDCLI').AsString;
    FFatVenda.strCliCid := qryGenGer.FieldByName('GER_NOMCID').AsString;
    FFatVenda.strCliEst := qryGenGer.FieldByName('GER_ESTCLI').AsString;
    FFatVenda.strCliTel := qryGenGer.FieldByName('GER_TELCLI').AsString;
    FFatVenda.dtaNasCon := qryGenGer.FieldByName('AUX_NASCON').AsDateTime;
    FFatVenda.strCliCgc := qryGenGer.FieldByName('GER_CGCCLI').AsString;
    FFatVenda.intCgcCpf := qryGenGer.FieldByName('GER_CGCCPF').AsInteger;
    FFatVenda.strCliIes := qryGenGer.FieldByName('GER_IESCLI').AsString;
    FFatVenda.strCli_Rg := qryGenGer.FieldByName('GER_R_GCLI').AsString;

    FFatVenda.strCliEma := qryGenGer.FieldByName('CLI_EMAIL3').AsString;                   //         - Email NFe
    FFatVenda.strCliEm2 := qryGenGer.FieldByName('CLI_EMAIL2').AsString;                   //         - Email 2
    FFatVenda.strCluFid := qryGenGer.FieldByName('CLI_CLUFID').AsString;                   //         - Clube Fidelidade
    FFatVenda.strCliFid := qryGenGer.FieldByName('CLI_CLIFID').AsString;                   //         - Cliente Fidelidade

    FFatVenda.strCliAti := qryGenGer.FieldByName('CLI_CODATI').AsString;                   //         - Atividade
    FFatVenda.blnConstr := fAtividadeConstrutora(qryGenGer.FieldByName('CLI_CODATI').AsString); // Cliente construtora ????
    FFatVenda.strObserv := qryGenGer.FieldByName('CLI_OBSERV').AsString;                   //         - Observações
    FFatVenda.strCliDAc := qryGenGer.FieldByName('CLI_CODEAC').AsString;                   //         - Cobrar despesas acessórias do cliente


    FFatVenda.strEndCob := qryGenGer.FieldByName('CLI_ENDCOB').AsString;
    FFatVenda.strBaiCob := qryGenGer.FieldByName('CLI_BAICOB').AsString;
    FFatVenda.strCepCob := qryGenGer.FieldByName('CLI_CEPCOB').AsString;
    FFatVenda.strCidCob := fRetNomCidade(qryGenGer.FieldByName('CLI_CIDCOB').AsString);
    FFatVenda.strEstCob := fRetNomCidade(qryGenGer.FieldByName('CLI_CIDCOB').AsString, 1);

    FFatVenda.strDiferi := qryGenGer.FieldByName('CLI_DIFERI').AsString;
    FFatVenda.fltRedIcmsCli := qryGenGer.FieldByName('CLI_REDICM').AsFloat;

    If fCfgSis('CLIDOP', VarBoolean) Then
      FFatVenda.fltDesOpeCli  := qryGenGer.FieldByName('CLI_DESOPE').AsFloat;

    FFatVenda.fltDescProfissional := fRetDescontoCliente(FFatVenda.strCodCli);
    FFatVenda.fltDescFidelidade   := fRetDescontoFidelidade(FFatVenda.strCodCli);

    FFatVenda.strCliImp := qryGenGer.FieldByName('CLI_I_M_P_').AsString;                   //         - Insc. Municipal Produtor
    FFatVenda.strProRur := qryGenGer.FieldByName('CLI_PRORUR').AsString;                   //         - Produtor Rural
    FFatVenda.strMicEmp := qryGenGer.FieldByName('CLI_MICEMP').AsString;                   //         - MEI-Micro Empreendedor Individual
    FFatVenda.strCliOrg := qryGenGer.FieldByName('CLI_ORGPUB').AsString;                   //         - Orgao Publico
    FFatVenda.strDesPis := qryGenGer.FieldByName('CLI_DESPIS').AsString;                   //         - Orgao Publico
    FFatVenda.strZonFra := qryGenGer.FieldByName('CLI_ZONFRA').AsString;                   //         - Zona Franca de Manaus
    FFatVenda.strCodZfm := qryGenGer.FieldByName('CLI_SUFRAM').AsString;                   //         - Código Sufram
    FFatVenda.blnCliExportacaoIndireta := qryGenGer.FieldByName('CLI_EXPIND').AsString = 'S';  //     - Cliente Exportação Indireta
    FFatVenda.strCodReg := qryGenGer.FieldByName('CLI_CODREG').AsString;                   //         - Código da Região
    FFatVenda.strDesReg := fRetDesRegiao(qryGenGer.FieldByName('CLI_CODREG').AsString);    //         - Descrição da Região
    FFatVenda.strCliCon := qryGenGer.FieldByName('GER_CONSUM').AsString;                   //         - Consumidor Final (S/N)

    FFatVenda.strCodRep := qryGenGer.FieldByName('CLI_CODREP').AsString;                   //         - Código do Representante
    FFatVenda.strNomRep := fRetNomVendRep(qryGenGer.FieldByName('CLI_CODREP').AsString);   //         - Nome do Representante

    if (fCfgSis('SIMPAU', varBoolean) and fCfgSis('RETIMP', varBoolean)) then
    begin
      FFatVenda.strRetPCo := 'N';                                                              //         - Retenção de Pis e Cofins
      FFatVenda.strRetIrf := 'N';                                                              //         - Retenção de IRPF
      FFatVenda.strCDesPI := 'N';                                                              //         - Retenção de Pis e Cofins
    end
    else
    begin
      FFatVenda.strRetPCo := qryGenGer.FieldByName('CLI_RETPCO').AsString;                   //         - Retenção de Pis e Cofins
      FFatVenda.strRetIrf := qryGenGer.FieldByName('CLI_RETIRF').AsString;                   //         - Retenção de IRPF
      FFatVenda.strCDesPI := qryGenGer.FieldByName('CLI_CDESPI').AsString;                   //         - Retenção de Pis e Cofins
    end;

    FFatVenda.strSitIPI := qryGenGer.FieldByName('CLI_SITIPI').AsString;                   //         - Isento de IPI
    FFatVenda.strEnqIPI := qryGenGer.FieldByName('CLI_ENQIPI').AsString;                   //         - Enquadramento do IPI
    FFatVenda.strMenIPI := qryGenGer.FieldByName('CLI_MENIPI').AsString;                   //         - Mensagem do IPI
    FFatVenda.strRetIss := qryGenGer.FieldByName('CLI_RETISS').AsString;                   //         - Retenção de ISS
    FFatVenda.strOrPuRD := qryGenGer.FieldByName('CLI_ORPURD').AsString;                   //         - Tipo de Desconto (Rateio / Desconto)
    FFatVenda.strCalIcm := qryGenGer.FieldByName('CLI_CALICM').AsString;                   //         - Calcula Desconto de ICMS (Orgão Public)
    FFatVenda.strSegSoc := qryGenGer.FieldByName('CLI_SEGSOC').AsString;                   //         - Seguridade Social

    FFatVenda.strPerEmp := qryGenGer.FieldByName('CLI_PEREMP').AsString;                   //         - Permite Emprestimo

    FFatVenda.pCarregaAliquotasRetencao;


    FFatVenda.blnCliFil := FFatVenda.fClienteFilialVenda(qryGenGer.FieldByName('CLI_CODCLI').AsString);
    FFatVenda.fltFat_TE := FFatVenda.recDadCli.fltFat_TE;
    FFatVenda.strTEPREV := FFatVenda.recDadCli.strTEPREV;

    If (FFatVenda.blnCliFil) Then
    Begin
      FFatVenda.pAtualizaClassTransferencias;
    End;

    strTePrev := fGetTEPREV(VS_strCodEmp, qryGenGer.FieldByName('CLI_CODCLI').AsString);
    If SameText(strTePrev, 'IMP') Then
      strPreIte := 'ITE_IMPULT'
    Else If SameText(strTePrev, 'SIC') Then
      strPreIte := 'ITE_MEDSIC'
    Else
      strPreIte := 'ITE_PRE' + strTePrev;

    strTabela := 'MOVDET';
    strMovMad := 'MOVMAD';
    strTabela2:= 'MOVTRI';

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  DET_CODITE, ';
    strSQL := strSQL + '  DET_CODEMP, ';
    strSQL := strSQL + '  DET_ESTADO, ';
    strSQL := strSQL + '  DET_UNITAR, ';
    strSQL := strSQL + '  DET_TOTCUS, ';
    strSQL := strSQL + '  DET_TOTCU2, ';
    strSQL := strSQL + '  DET_DESESP, ';


    strSQL := strSQL + '  DET_TOTULT, ';
    strSQL := strSQL + '  DET_IMPULT, ';
    strSQL := strSQL + '  DET_TOTMED, ';
    strSQL := strSQL + '  DET_TOTCUS - (IFNULL(ITE_VALFRE, 0) * DET_QTDITE) AS DET_CUSFRE, ';

    strSQL := strSQL + '  DET_QTDITE, ';

    If fRotinaVendeMadeiraOuVidroOuMetroLinear Then
    Begin
      strSQL := strSQL + '  DET_COMPEC, ';
      strSQL := strSQL + '  DET_LARPEC, ';
      strSQL := strSQL + '  DET_ESPPEC, ';

      strSQL := strSQL + '  DET_APAREL, ';
      strSQL := strSQL + '  DET_PERAPA, ';
      strSQL := strSQL + '  DET_BENEFI, ';
      strSQL := strSQL + '  DET_PERBEN, ';
    End;

    strSQL := strSQL + '  DET_TABPRE, ';

    strSQL := strSQL + '  DET_INCPIS, ';
    strSQL := strSQL + '  DET_IDEPRO, ';
    strSQL := strSQL + '  DET_DESCRI, ';
    strSQL := strSQL + '  DET_UNIDAD, ';
    strSQL := strSQL + '  DET_CODMAR, ';
    strSQL := strSQL + '  DET_FORITE, ';
    strSQL := strSQL + '  DET_REFERE, ';
    strSQL := strSQL + '  DET_DESCON, ';
    strSQL := strSQL + '  DET_TOTPES, ';
    strSQL := strSQL + '  DET_NUMLOT, ';
    strSQL := strSQL + '  DET_CODDIV, ';
    strSQL := strSQL + '  DET_CODVE2, ';
    strSQL := strSQL + '  DET_ENTFUT, ';
    strSQL := strSQL + '  DET_MOTFUT, ';
    strSQL := strSQL + '  DET_DTAFUT, ';
    strSQL := strSQL + '  ITE_CODGRU, ';
    strSQL := strSQL + '  UNI_ITEFRA, ';
    strSQL := strSQL + '  DET_CODACA, ';
    strSQL := strSQL + '  DET_EMPACA, ';
    strSQL := strSQL + '  DET_PROACA, ';
    strSQL := strSQL + '  DET_NUM_PD, ';
    strSQL := strSQL + '  DET_ESP_PD, ';
    strSQL := strSQL + '  DET_EMP_PD  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ' + strTabela + ' D ';
    strSQL := strSQL + 'JOIN CADITE ON ITE_CODITE = DET_CODITE ';
    strSQL := strSQL + 'LEFT JOIN CADUNI ON UNI_CODUNI = DET_UNIDAD ';
    strSQL := strSQL + ' INNER JOIN ITEGER G ON G.ITE_CODITE = DET_CODITE AND G.ITE_CODEMP = DET_CODEMP ';

    strSQL := strSQL + 'LEFT JOIN ' + strTabela2 + ' T ON T.DET_SEQGER = D.AUTOINCREM ';

    If fRotinaVendeMadeiraOuVidroOuMetroLinear Then
      strSQL := strSQL + ' LEFT JOIN ' + strMovMad + ' M ON M.DET_SEQGER = D.AUTOINCREM  ';

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  DET_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  DET_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  DET_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  DET_CODCLI = :CODCLI     ';


    strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strSQL,'MOVDET','NOTDET'),'MOVMAD','NOTMAD'),'MOVTRI', 'NOTTRI');

    qryGenGer.Close;
    qryGenGer.SQL.Clear;
    qryGenGer.SQL.Add(strSQL);
    qryGenGer.ParamByName('NUMDOC').AsString := objNotaDevolucao.FieldByName('GER_NUMDOC').AsString;
    qryGenGer.ParamByName('ESPDOC').AsString := objNotaDevolucao.FieldByName('GER_ESPDOC').AsString;
    qryGenGer.ParamByName('CODEMP').AsString := objNotaDevolucao.FieldByName('GER_CODEMP').AsString;
    qryGenGer.ParamByName('CODCLI').AsString := objNotaDevolucao.FieldByName('GER_CODCLI').AsString;
    qryGenGer.Open;

    TEmissaoNotaEspecial.pCarregaItensNotaEspecial(FFatVenda, qryGenGer, blnAvisarOperadorVendaComPrecoCusto);
  finally
    FreeAndNil(qryGenGer);
  end;
end;

procedure TAbastecimentoDepositoDevolucaoEntradaMercadoria.pCarregaVendedor;
var
  LConOpe: TUniQuery;
begin
  LConOpe := fCriaQuery(FFatVenda);

  try
    pPesquisaCadOpe(LConOpe, LConOpe, FFatVenda.strCodVen);

    FFatVenda.strCodVen := LConOpe.FieldByName('OPE_CODOPE').AsString;
    FFatVenda.strNomVen := LConOpe.FieldByName('OPE_NOMOPE').AsString;
    FFatVenda.fltComVen := LConOpe.FieldByName('OPE_PERCOM').AsFloat;
    FFatVenda.strTipVen := LConOpe.FieldByName('OPE_INTEXT').AsString;
  finally
    FreeAndNil(LConOpe);
  end;
end;

procedure TAbastecimentoDepositoDevolucaoEntradaMercadoria.pTransfereEstoqueDevolucaoNotaEntrada;
begin
  pCarregaFatVendas;
  FFatVenda.pPreencheMatrizFechamento;
  FFatVenda.pCalculaTotGer;
  FFatVenda.blnEhDevolucaoAbastecimentoDeposito := True;
  FFatVenda.blnAbastecimentoDeposito := True;

  TFatTransfEstoqueParaEmpresaFaturamentoPedido.
    New(FFatVenda, FFatVenda.strEmpDoc, FEmpresaAbastecimento, False, FFatVenda.strEspDoc).
      fTransferirEstoqueParaEmpresaFaturamento;
end;

end.
