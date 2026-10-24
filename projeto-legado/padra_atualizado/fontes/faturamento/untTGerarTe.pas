unit untTGerarTe;

interface

uses Classes, SysUtils, strUtils, Forms, Uni, untIGerarTe,
     untFuncFat, untFuncoesSimples, MaskUtils, Variants,
     untFuncFatTypes, untTypesSistema;

type
  TGerarTe = class(TInterfacedObject, IGerarTE)
  private

    FDevolucaoAutomatizadaParaDocumentosDeOutrasEmpresas : Boolean;

    FCodCndCadCli,
    FConPagCadCli,
    FCodFpgCadCli : String;
    fatVenda      : TFatVenda;

    function fGetNumeroTE: String;
    procedure pAcertaDadosCondicaoPagamento;
    procedure pCarregaItem(strCodIte : String; var qryItem : TUniQuery);
    function fRetPrvTin(const strOpcPre : String) : Double;

  public

    strNum_TE : String;

    constructor Create(blnEhDevolucaoAutomatizadaParaDocumentosDeOutrasEmpresas : Boolean = False);
    destructor Destroy; override;

    procedure pSetaDadosCliente(strCodCli, strCodVen: String);
    procedure pSetaProdutos(arrMatrizItensParam : TMatrizFechamento);

    procedure pSetaDadosIniciais;

    function fGeraTransferencia(strEspDoc: String = 'TE'): Boolean;
  end;

implementation

uses untFuncoes, untTMatrizSaldosColorantes, untFuncTinta, untGravando,
  untDuplicatas;

{ TGerarTe }

constructor TGerarTe.Create(blnEhDevolucaoAutomatizadaParaDocumentosDeOutrasEmpresas : Boolean = False);
begin

  FDevolucaoAutomatizadaParaDocumentosDeOutrasEmpresas := blnEhDevolucaoAutomatizadaParaDocumentosDeOutrasEmpresas;

  FCodCndCadCli := '';
  FConPagCadCli := '';
  FCodFpgCadCli := '';

end;

destructor TGerarTe.Destroy;
begin
  inherited;
end;

function TGerarTe.fGeraTransferencia(strEspDoc: String = 'TE'): Boolean;
  Var
    fltTotDup: Double;
begin

  If Not fatVenda.blnCliFil Then
  Begin
    Result := False;
    Exit;
  End;

  fatVenda.pCarregaAliquotasRetencao;
  fatVenda.blnFecharForm := False;

  pAcertaDadosCondicaoPagamento;
  fatVenda.fltPorDes     := fatVenda.fltPorDesTmp;
  fatVenda.strEspDoc     := strEspDoc; //'TE';

  fatVenda.strConPag := '01000';

  fatVenda.strMen001 := '';
  fatVenda.strMen002 := '';

  If FDevolucaoAutomatizadaParaDocumentosDeOutrasEmpresas Then
  Begin
    fatVenda.strMen001 := MEN001_TRANSF_REF_DEV_AUT_DOCS_OUT_EMP;
    fatVenda.strMen002 := 'Documento gerado para ajuste de estoque';
  End;

  If (fCfgSis('CNPDFM', varBoolean)) Then
  Begin
    fatVenda.strCodFpg := Self.FCodFpgCadCli;
    If (fCfgSis('USACND', varBoolean)) Then
    Begin
      fatVenda.strCodCnd := Self.FCodCndCadCli;
      fatVenda.strConPag := fCampoTabela('CND_CNDPAG', 'CADCND', ['CND_CODIGO'], [fatVenda.strCodCnd]);
      If (fatVenda.strCodFpg.IsEmpty) Then
        fatVenda.strCodFpg := fCampoTabela('CND_CODFPG', 'CADCND', ['CND_CODIGO'], [fatVenda.strCodCnd]);
    End
    Else
    Begin
      fatVenda.strConPag := Self.FConPagCadCli;
    End;
  End;

  fatVenda.pPreencheMatrizFechamento;
  fatVenda.pCalculaPesBruLiq;
  fatVenda.pCalculaTotGer(False, False);
  fatVenda.pDestacaRetencoes;
  fatVenda.pRetemImpostosNoDescontoEspecial;
  fatVenda.pCalculaTotGer;

  fatVenda.strDesCla   := fRetDesCla(fatVenda.strClaFis);

  fatVenda.pCalculaTotalParaCadRec;

  fltTotDup := fatVenda.fltTotCadRec;
  If (fltTotDup < 0) Then
    fltTotDup := 0;

  fDigDuplic(fatVenda.arrDuplicata, fatVenda.strConPag, 0, fltTotDup, False, False, False, VS_Date, False);

  fatVenda.pRateiaValores;

  If (fatVenda.fltValFre = 0) Then
    fatVenda.strTipFre := '9';

  Try

    pCriarFormularios(TfrmGravando, frmGravando);

    frmGravando.strChave      := 'FATVENDAS';
    frmGravando.fExecutarAcao := fatVenda.fGravaArquivos;
    frmGravando.ShowModal;

    Result    := frmGravando.blnConfirma;
    strNum_TE := fatVenda.strNumDoc;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

  If Assigned(frmGravando) Then
    pFreeAndNil(frmGravando);

end;

function TGerarTe.fGetNumeroTE: String;
begin
  Result := strNum_TE;
end;

function TGerarTe.fRetPrvTin(const strOpcPre : String): Double;
begin

  If (strOpcPre = 'VE1') Then
    Result := fatVenda.fltPreVe1

  Else If (strOpcPre = 'VE2') Then
    Result := fatVenda.fltPreVe2

  Else If (strOpcPre = 'VE3') Then
    Result := fatVenda.fltPreVe3

  Else If (strOpcPre = 'VE4') Then
    Result := fatVenda.fltPreVe4

  Else If (strOpcPre = 'VE5') Then
    Result := fatVenda.fltPreVe5

  Else If (strOpcPre = 'VE6') Then
    Result := fatVenda.fltPreVe6

  Else If (strOpcPre = 'VE7') Then
    Result := fatVenda.fltPreVe7

  Else
    Result := fatVenda.fltPreCus;

end;

procedure TGerarTe.pAcertaDadosCondicaoPagamento;
  Var
    qryAux: TUniQuery;
begin

  If (fEmptyStr(fatVenda.strCodCnd)) Then
    Exit;

  qryAux := fCriaQuery(Nil);

  Try
    qryAux.SQL.Add('SELECT * FROM CADCND WHERE CND_CODIGO = :CODCND');
    qryAux.ParamByName('CODCND').AsString := fatVenda.strCodCnd;
    qryAux.Open;
    fatVenda.strDesCnd := qryAux.FieldByName('CND_DESCRI').AsString;
    fatVenda.fltDMVCnd := qryAux.FieldByName('CND_DESMAX').AsFloat;
    fatVenda.fltDMGCnd := qryAux.FieldByName('CND_DESMGE').AsFloat;
    fatVenda.fltDMSCnd := qryAux.FieldByName('CND_DESMSU').AsFloat;
    fatVenda.fltTxJCnd := qryAux.FieldByName('CND_TXJURO').AsFloat;
    fatVenda.strCAbDes := qryAux.FieldByName('CND_ABADES').AsString;
    fatVenda.strTipFor := qryAux.FieldByName('CND_TIPFOR').AsString;
    fatVenda.strAbDeCc := qryAux.FieldByName('CND_ABDECC').AsString;
    fatVenda.strJurPro := qryAux.FieldByName('CND_JURPRO').AsString;
    fatVenda.strCndTbP := qryAux.FieldByName('CND_TABPRE').AsString;
    fatVenda.strCndTpm := qryAux.FieldByName('CND_PRETAB').AsString;
  Finally
    FreeAndNil(qryAux);
  End;

end;

procedure TGerarTe.pCarregaItem(strCodIte: String; var qryItem: TUniQuery);
  var
    strSQL : String;
begin

  If Not Assigned(qryItem) Then
    qryItem := fCriaQuery(Nil);

  strSQL  := '';
  strSQL  := strSQL + 'SELECT          ';
  strSQL  := strSQL + '  C.ITE_CODITE, ';
  strSQL  := strSQL + '  C.ITE_CODGRU, ';
  strSQL  := strSQL + '  C.ITE_DESFAB, ';
  strSQL  := strSQL + '  C.ITE_CODUNI, ';
  strSQL  := strSQL + '  C.ITE_CODMAR, ';
  strSQL  := strSQL + '  C.ITE_CODFOR, ';
  strSQL  := strSQL + '  C.ITE_COMLUB, ';
  strSQL  := strSQL + '  G.ITE_IPISAI, ';
  strSQL  := strSQL + '  G.ITE_DESMAX, ';
  strSQL  := strSQL + '  G.ITE_OUTVAL, ';
  strSQL  := strSQL + '  G.ITE_ICMSAI, ';
  strSQL  := strSQL + '  G.ITE_IMPFED, ';
  strSQL  := strSQL + '  G.ITE_DESOPE, ';
  strSQL  := strSQL + '  G.ITE_COMTB1, ';
  strSQL  := strSQL + '  G.ITE_COMTB2, ';
  strSQL  := strSQL + '  G.ITE_COMTB3, ';
  strSQL  := strSQL + '  G.ITE_COMTB4, ';
  strSQL  := strSQL + '  G.ITE_COMTB5, ';
  strSQL  := strSQL + '  G.ITE_COMTB6, ';
  strSQL  := strSQL + '  G.ITE_COMTB7, ';
  strSQL  := strSQL + '  G.ITE_PREVE1, ';
  strSQL  := strSQL + '  G.ITE_PREVE2, ';
  strSQL  := strSQL + '  G.ITE_PREVE3, ';
  strSQL  := strSQL + '  G.ITE_PREVE4, ';
  strSQL  := strSQL + '  G.ITE_PREVE5, ';
  strSQL  := strSQL + '  G.ITE_PREVE6, ';
  strSQL  := strSQL + '  G.ITE_PREVE7, ';
  strSQL  := strSQL + '  G.ITE_PRECUS, ';
  strSQL  := strSQL + '  C.ITE_INCPIS, ';
  strSQL  := strSQL + '  G.ITE_COMVAR, ';
  strSQL  := strSQL + '  G.ITE_COMATA, ';
  strSQL  := strSQL + '  G.ITE_COMDIS, ';
  strSQL  := strSQL + '  G.ITE_PREULT, ';
  strSQL  := strSQL + '  G.ITE_IMPULT, ';
  strSQL  := strSQL + '  G.ITE_PREMED, ';
  strSQL  := strSQL + '  C.ITE_CLAIPI, ';
  strSQL  := strSQL + '  C.ITE_EXCIPI, ';

  If fCfgSis('TIPABF') = '1' Then
    strSQL  := strSQL + '  C.ITE_CODABF, '
  Else
    strSQL  := strSQL + '  G.ITE_CODABF, ';

  strSQL  := strSQL + '  C.ITE_PESOIT, ';
  strSQL  := strSQL + '  C.ITE_PESLIQ, ';
  strSQL  := strSQL + '  C.ITE_CODFAB, ';
  strSQL  := strSQL + '  G.ITE_MARMIN, ';
  strSQL  := strSQL + '  G.ITE_MARMSG, ';
  strSQL  := strSQL + '  G.ITE_MARMGE, ';

  strSQL  := strSQL + '  G.ITE_DESMVM, ';
  strSQL  := strSQL + '  G.ITE_DESMSM, ';
  strSQL  := strSQL + '  G.ITE_DESMGM, ';

  strSQL  := strSQL + '  G.ITE_MARMMV, ';
  strSQL  := strSQL + '  G.ITE_MARMMS, ';
  strSQL  := strSQL + '  G.ITE_MARMMG, ';

  strSQL  := strSQL + '  C.ITE_CODMAR, ';
  strSQL  := strSQL + '  C.ITE_EMBALA, ';
  strSQL  := strSQL + '  G.ITE_PRECOM, ';
  strSQL  := strSQL + '  G.ITE_QTPPRO, ';
  strSQL  := strSQL + '  C.ITE_OBRCPF, ';
  strSQL  := strSQL + '  G.ITE_OUTVAL, ';
  strSQL  := strSQL + '  G.ITE_DESOPE, ';
  strSQL  := strSQL + '  G.ITE_DESMGE, ';
  strSQL  := strSQL + '  G.ITE_DESMSU, ';
  strSQL  := strSQL + '  G.ITE_IPIENT, ';
  strSQL  := strSQL + '  G.ITE_IMPDIR, ';
  strSQL  := strSQL + '  G.ITE_FREENT, ';
  strSQL  := strSQL + '  G.ITE_LOCFIS, ';
  strSQL  := strSQL + '  C.ITE_CODBAR, ';
  strSQL  := strSQL + '  C.ITE_DESITE, ';
  strSQL  := strSQL + '  C.ITE_REFERE, ';
  strSQL  := strSQL + '  G.ITE_SALDOS  ';
  strSQL  := strSQL + 'FROM            ';
  strSQL  := strSQL + '  CADITE C      ';
  strSQL  := strSQL + '  INNER JOIN ITEGER G ON G.ITE_CODITE = C.ITE_CODITE AND ';
  strSQL  := strSQL + '                         G.ITE_CODEMP = :CODEMP          ';
  strSQL  := strSQL + 'WHERE           ';
  strSQL  := strSQL + '  C.ITE_CODITE = :CODITE ';

  qryItem.Close;
  qryItem.SQL.Clear;
  qryItem.SQL.Text := strSQL;
  qryItem.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryItem.ParamByName('CODITE').AsString := strCodIte;
  qryItem.Open;

end;

procedure TGerarTe.pSetaDadosCliente(strCodCli, strCodVen: String);
  Var
    strSQL   : String;
    qryCadCli: TUniQuery;
begin

  fatVenda.strCodCli := strCodCli;

  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   CLI_CODCLI AS CODCLI, ';
  strSQL := strSQL + '   CLI_NOMCLI AS CLIORI, ';
  strSQL := strSQL + '   CLI_I_M_P_ AS I_M_P_, ';
  strSQL := strSQL + '   CLI_PRORUR AS PRORUR, ';
  strSQL := strSQL + '   CLI_MICEMP AS MICEMP, ';
  strSQL := strSQL + '   CLI_ORGPUB AS ORGPUB, ';
  strSQL := strSQL + '   CLI_DESPIS AS DESPIS, ';
  strSQL := strSQL + '   CLI_ZONFRA AS ZONFRA, ';
  strSQL := strSQL + '   CLI_CONSUM AS CONSUM, ';
  strSQL := strSQL + '   CLI_TABPRE AS TABPRE, ';
  strSQL := strSQL + '   CLI_CODVEN AS CODVEN, ';
  strSQL := strSQL + '   CLI_CODREP AS CODREP, ';
  strSQL := strSQL + '   CLI_ORPURD AS ORPURD, ';
  strSQL := strSQL + '   CLI_CALICM AS CALICM, ';
  strSQL := strSQL + '   CLI_ZONFRA AS ZONFRA, ';

  if (fCfgSis('SIMPAU', varBoolean) and fCfgSis('RETIMP', varBoolean)) then
  begin
    strSQL := strSQL + '   "N" AS RETPCO, ';
    strSQL := strSQL + '   "N" AS RETIRF, ';
  end
  else
  begin
    strSQL := strSQL + '   CLI_RETPCO AS RETPCO, ';
    strSQL := strSQL + '   CLI_RETIRF AS RETIRF, ';
  end;

  strSQL := strSQL + '   CLI_RETISS AS RETISS, ';
  strSQL := strSQL + '   CLI_EMAIL3 AS EMAIL_, ';
  strSQL := strSQL + '   CLI_EMAIL2 AS EMAIL2, ';
  strSQL := strSQL + '   ETC_ENDENT AS ENDENT, ';
  strSQL := strSQL + '   ETC_BAIENT AS BAIENT, ';
  strSQL := strSQL + '   ETC_CEPENT AS CEPENT, ';
  strSQL := strSQL + '   ETC_CIDENT AS CIDENT, ';
  strSQL := strSQL + '   ETC_REFENT AS REFENT, ';
  strSQL := strSQL + '   CLI_ENDCOB AS ENDCOB, ';
  strSQL := strSQL + '   CLI_BAICOB AS BAICOB, ';
  strSQL := strSQL + '   CLI_CEPCOB AS CEPCOB, ';
  strSQL := strSQL + '   CLI_CIDCOB AS CIDCOB, ';
  strSQL := strSQL + '   CLI_DIFERI AS DIFERI, ';
  strSQL := strSQL + '   IF(IFNULL(ETC_COBISS,"") = "", CLI_COBISS, ETC_COBISS) AS COBISS, ';
  strSQL := strSQL + '   IF(IFNULL(ETC_CODOBR,"") = "", CLI_CODOBR, ETC_CODOBR) AS CODOBR, ';
  strSQL := strSQL + '   IF(IFNULL(ETC_CODART,"") = "", CLI_CODART, ETC_CODART) AS CODART, ';
  strSQL := strSQL + '   IF(IFNULL(ETC_CODCNO,"") = "", CLI_CODCNO, ETC_CODCNO) AS CODCNO, ';
  strSQL := strSQL + '   IF(IFNULL(ETC_INSIMO,"") = "", CLI_INSIMO, ETC_INSIMO) AS INSIMO, ';
  strSQL := strSQL + '   IF(IFNULL(ETC_CODCIB,"") = "", CLI_CODCIB, ETC_CODCIB) AS CODCIB, ';
  strSQL := strSQL + '   CLI_DIF_ST AS DIF_ST, ';
  strSQL := strSQL + '   CLI_SITP_C AS SITP_C, ';
  strSQL := strSQL + '   CLI_MENP_C AS MENP_C, ';
  strSQL := strSQL + '   CLI_REDICM AS REDICM, ';
  strSQL := strSQL + '   CLI_DESOPE AS DESOPE, ';
  strSQL := strSQL + '   CLI_CODATI AS CODATI, ';
  strSQL := strSQL + '   CLI_CGCCPF AS CGCCPF, ';
  strSQL := strSQL + '   CLI_NOMCLI AS CLINOM, ';
  strSQL := strSQL + '   IF(IFNULL(CLI_ENDCOM, "") = "", CLI_ENDERE, CONCAT(" ", CLI_ENDCOM)) AS ENDERE, ';
  strSQL := strSQL + '   IF(CLI_ENDNUM IS NULL,"",CLI_ENDNUM)                                 AS ENDNUM, ';
  strSQL := strSQL + '   CLI_BAIRRO AS BAIRRO, ';
  strSQL := strSQL + '   CLI_CODCID AS CODCID, ';
  strSQL := strSQL + '   CLI_C_E_P_ AS C_E_P_, ';
  strSQL := strSQL + '   CLI_FONE01 AS FONE01, ';
  strSQL := strSQL + '   CLI_NUMR_G AS NUM_RG, ';
  strSQL := strSQL + '   CLI_C_G_C_ AS C_G_C_, ';
  strSQL := strSQL + '   CLI_I_E_S_ AS I_E_S_, ';
  strSQL := strSQL + '   CLI_NOMCLI AS NOMCLI, ';
  strSQL := strSQL + '   CLI_PERMUT AS PERMUT, ';
  strSQL := strSQL + '   (SELECT CND_CODCND FROM CLICND WHERE CND_SUGEST = "S" AND CND_CODCLI=CLI_CODCLI LIMIT 1) AS CODCND_SUGEST, ';
  strSQL := strSQL + '   (SELECT CND_CNDPAG FROM CLICND WHERE CND_SUGEST = "S" AND CND_CODCLI=CLI_CODCLI LIMIT 1) AS CONPAG_SUGEST, ';
  strSQL := strSQL + '   CLI_CODFPG AS CODFPG_SUGEST ';
  strSQL := strSQL + ' FROM                    ';
  strSQL := strSQL + '   CADCLI                ';
  strSQL := strSQL + '   LEFT JOIN ENTCLI ON ETC_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + ' WHERE                   ';
  strSQL := strSQL + '   CLI_CODCLI = :CODCLI  ';

  qryCadCli := fCriaQuery(Nil);

  Try
    qryCadCli.Close;
    qryCadCli.SQL.Clear;
    qryCadCli.SQL.Add(strSQL);
    qryCadCli.ParamByName('CODCLI').AsString := fatVenda.strCodCli;
    qryCadCli.Open;

    Self.FCodCndCadCli := qryCadCli.FieldByName('CODCND_SUGEST').AsString;
    Self.FConPagCadCli := qryCadCli.FieldByName('CONPAG_SUGEST').AsString;
    Self.FCodFpgCadCli := qryCadCli.FieldByName('CODFPG_SUGEST').AsString;

    fatVenda.strCliNom     := qryCadCli.FieldByName('CLINOM').AsString;                       //         - Nome
    fatVenda.strCliOri     := qryCadCli.FieldByName('CLIORI').AsString;                       //         - Nome Original
    fatVenda.strCliEnd     := qryCadCli.FieldByName('ENDERE').AsString;                       //         - Endereco
    fatVenda.strCliNum     := qryCadCli.FieldByName('ENDNUM').AsString;                       //         - Numero
    fatVenda.strCliBai     := qryCadCli.FieldByName('BAIRRO').AsString;                       //         - Bairro
    fatVenda.strCliCep     := qryCadCli.FieldByName('C_E_P_').AsString;                       //         - Cep
    fatVenda.strCodCid     := qryCadCli.FieldByName('CODCID').AsString;                       //         - Cód. Cidade
    fatVenda.strCliCid     := fRetNomCidade(qryCadCli.FieldByName('CODCID').AsString, 0);     //         - Cidade
    fatVenda.strCliEst     := fRetNomCidade(qryCadCli.FieldByName('CODCID').AsString, 1);     //         - Estado
    fatVenda.strCliTel     := qryCadCli.FieldByName('FONE01').AsString;                       //         - Telefone
    fatVenda.strCli_Rg     := qryCadCli.FieldByName('NUM_RG').AsString;                       //         - RG
    fatVenda.strCliCgc     := fTiraCaracEspeciais(qryCadCli.FieldByName('C_G_C_').AsString);  //         - CNPJ
    fatVenda.strCliCgc     := AnsiReplaceStr(fatVenda.strCliCgc, '.', '');          //
    fatVenda.intCgcCpf     := qryCadCli.FieldByName('CGCCPF').AsInteger;                      //         - CGC/CPF
    fatVenda.strCliIes     := qryCadCli.FieldByName('I_E_S_').AsString;                       //         - Ins.Estadual
    fatVenda.strCliImp     := qryCadCli.FieldByName('I_M_P_').AsString;                       //         - Insc. Municipal Produtor
    fatVenda.strProRur     := qryCadCli.FieldByName('PRORUR').AsString;                       //         - Produtor Rural
    fatVenda.strMicEmp     := qryCadCli.FieldByName('MICEMP').AsString;                       //         - MEI-Micro Empreendedor Individual
    fatVenda.strRetPCo     := qryCadCli.FieldbyName('RETPCO').AsString;                       //         - Retenção de Pis e Cofins
    fatVenda.strRetIrf     := qryCadCli.FieldbyName('RETIRF').AsString;                       //         - Retenção de IRPF
    fatVenda.strRetIss     := qryCadCli.FieldbyName('RETISS').AsString;                       //         - Retenção de ISS
    fatVenda.strCliOrg     := qryCadCli.FieldByName('ORGPUB').AsString;                       //         - Orgao Publico
    fatVenda.strDesPis     := qryCadCli.FieldByName('DESPIS').AsString;                       //         - Orgao Publico
    fatVenda.strOrPuRD     := qryCadCli.FieldbyName('ORPURD').AsString;                       //         - Tipo de Desconto (Rateio / Desconto)
    fatVenda.strCalIcm     := qryCadCli.FieldbyName('CALICM').AsString;                       //         - Calcula Desconto de ICMS (Orgão Public)
    fatVenda.strZonFra     := qryCadCli.FieldByName('ZONFRA').AsString;                       //         - Zona Francade Manaus
    fatVenda.strCliCon     := qryCadCli.FieldByName('CONSUM').AsString;                       //         - Consumidor Final (S/N)
    fatVenda.blnCliFil     := fatVenda.fClienteFilialVenda(qryCadCli.FieldByName('CODCLI').AsString); // - Cliente Filial
    fatVenda.fltFat_TE     := fatVenda.recDadCli.fltFat_TE;
    fatVenda.strTEPREV     := fatVenda.recDadCli.strTEPREV;

    If (fCfgSis('TBPSUG') = '0') Then
    Begin
      If (fEmptyStr(qryCadCli.FieldByName('TABPRE').AsString)) Then
      Begin
        If (Not fEmptyStr(fCfgSis('TBPRPD', varString))) Then
          fatVenda.strTabPre := fCfgSis('TBPRPD', varString);
      End
      Else
        fatVenda.strTabPre := qryCadCli.FieldByName('TABPRE').AsString;
    End
    Else
      fatVenda.strTabPre := fCfgSis('TBPSUG');                                      // Tabela de Preço

    fatVenda.strCodVen     := strCodVen;                                            // Vendedor      - Codigo
    fatVenda.strCodRep     := qryCadCli.FieldByName('CODREP').AsString;
    fatVenda.strCodDig     := strLoginUsuarioLogado;
    fatVenda.strNomVen     := fRetNomVendRep(qryCadCli.FieldByName('CODVEN').AsString);       // Vendedor      - Nome
    fatVenda.strCliEma     := qryCadCli.FieldByName('EMAIL_').AsString;                       // Email
    fatVenda.strCliEm2     := qryCadCli.FieldByName('EMAIL2').AsString;                       // Email 2
    fatVenda.strEndEnt     := qryCadCli.FieldByName('ENDENT').AsString;
    fatVenda.strBaiEnt     := qryCadCli.FieldByName('BAIENT').AsString;
    fatVenda.strCepEnt     := FormatMaskText('99999-999;0;_', qryCadCli.FieldByName('CEPENT').AsString);
    fatVenda.strCidEnt     := fRetNomCidade(qryCadCli.FieldByName('CIDENT').AsString);
    fatVenda.strEstEnt     := fRetNomCidade(qryCadCli.FieldByName('CIDENT').AsString, 1);
    fatVenda.strRefEnt     := qryCadCli.FieldByName('REFENT').AsString;
    fatVenda.strCliAti     := qryCadCli.FieldByName('CODATI').AsString;                       // Atividade
    fatVenda.blnConstr     := (fAtividadeConstrutora(qryCadCli.FieldByName('CODATI').AsString)); // Cliente Construtora?
    fatVenda.strEndCob     := qryCadCli.FieldByName('ENDCOB').AsString;
    fatVenda.strBaiCob     := qryCadCli.FieldByName('BAICOB').AsString;
    fatVenda.strCepCob     := FormatMaskText('99999-999;0;_', qryCadCli.FieldByName('CEPCOB').AsString);
    fatVenda.strCidCob     := fRetNomCidade(qryCadCli.FieldByName('CIDCOB').AsString);
    fatVenda.strEstCob     := fRetNomCidade(qryCadCli.FieldByName('CIDCOB').AsString, 1);
    fatVenda.fltRedIcmsCli := qryCadCli.FieldByName('REDICM').AsFloat;

    fatVenda.pProcessarDespesasOperacionaisComplementar(qryCadCli.FieldByName('DESOPE').AsFloat);
    fatVenda.strCliPer     := qryCadCli.FieldByName('PERMUT').AsString;
    qryCadCli.Close;

  Finally
    FreeAndNil(qryCadCli);
  End;

  fatVenda.pAtualizaClassTransferencias;
end;

procedure TGerarTe.pSetaProdutos(arrMatrizItensParam: TMatrizFechamento);
Var
  qryItem     : TUniQuery;
  strOpcPre   : String;
  strDesCor   : String;
  strIteTin   : String;
  strCatalize : String;
  strLinTin   : String;
  strTipEmb   : String;
  strTipPre   : String;
  strUnidad   : String;
  strMontad   : String;
  strA_n_o_   : String;
  strNcmTin   : String;
  strCoddil   : String;
  strDilCon   : String;
  strCodAca   : String;
  strEmpAca   : String;
  strRefere   : String;
  strChaFor   : String;
  strDesIte   : String;
  strDesOri   : String;
  fltPreVen   : Double;
  fltFatTin   : Double;
  fltPrcTin   : Double;
  fltPrvTin   : Double;
  fltPreEmb   : Double;
  fltVolPro   : Double;
  fltFatAce   : Double;
  fltPorDil   : Double;
  fltPorCat   : Double;
  fltQtdEmb   : Double;
  intLazQua   : Integer;
  blnProAca   : Boolean;
  recForTin   : TForTin;
  recMadeira  : TDadosMadeira;
  intContador : Integer;
begin

  If Length(arrMatrizItensParam) <= 0 Then
    Raise Exception.Create('Não foi possível carregar os itens para geração da TE!');

  for intContador := 0 to Length(arrMatrizItensParam) -1 do
  begin

    pCarregaItem(arrMatrizItensParam[intContador].strCodIte, qryItem);

    fltPreVen := arrMatrizItensParam[intContador].fltUniTar;
    fatVenda.fltTaxJur := 0;

    If (fatVenda.fAplicaTaxaJuros) And fAplicarTaxaJurosPrecoSugestao Then
    Begin
      fatVenda.fltTaxJur := fatVenda.fGetTaxVprItem(arrMatrizItensParam[intContador].strCodIte);
      fltPreVen := fltPreVen + fFormataFloat(fltPreVen * (fatVenda.fGetTaxVprItem(arrMatrizItensParam[intContador].strCodIte) / 100.0), 04);
    End;

    fatVenda.fltUniOri := fltPreVen;
    fatVenda.fltUniVis := arrMatrizItensParam[intContador].fltUniTar;

    fatVenda.fltPreCus := arrMatrizItensParam[intContador].fltPreCus;
    fatVenda.fltPreCu2 := IfNull(arrMatrizItensParam[intContador].fltPreCu2, arrMatrizItensParam[intContador].fltPreCus);

    fatVenda.fltComAnt := arrMatrizItensParam[intContador].fltPreCus;
    fatVenda.fltPreVe1 := IfNull(arrMatrizItensParam[intContador].fltPreVe1, fatVenda.fltUniVis);
    fatVenda.fltPreVe2 := IfNull(arrMatrizItensParam[intContador].fltPreVe2, fatVenda.fltUniVis);
    fatVenda.fltPreVe3 := IfNull(arrMatrizItensParam[intContador].fltPreVe3, fatVenda.fltUniVis);
    fatVenda.fltPreVe4 := IfNull(arrMatrizItensParam[intContador].fltPreVe4, fatVenda.fltUniVis);
    fatVenda.fltPreVe5 := IfNull(arrMatrizItensParam[intContador].fltPreVe5, fatVenda.fltUniVis);
    fatVenda.fltPreVe6 := IfNull(arrMatrizItensParam[intContador].fltPreVe6, fatVenda.fltUniVis);
    fatVenda.fltPreVe7 := IfNull(arrMatrizItensParam[intContador].fltPreVe7, fatVenda.fltUniVis);

    fltFatTin          := IfNull(arrMatrizItensParam[intContador].fltFatTin, 0);
    fltPrcTin          := IfNull(arrMatrizItensParam[intContador].fltPrcTin, 0);
    fltPrvTin          := IfNull(arrMatrizItensParam[intContador].fltPrvTin, 0);

    If (fltPrcTin <= 0) Then
      fltPrcTin := fatVenda.fltPreCus;

    If (fltPrvTin <= 0) Then
      fltPrvTin := fatVenda.fltUniVis;

    If fatVenda.blnCliFil Then
    Begin

      strOpcPre := fatVenda.strTEPREV;
      fltPrvTin := fRetPrvTin(strOpcPre);

      If (fatVenda.fltFat_TE > 0) Then
        fltPrvTin := fltPrvTin * fatVenda.fltFat_TE;

      fltPreVen := fltPrvTin;
      fatVenda.fltTaxJur := 0.00;

      If (fatVenda.fAplicaTaxaJuros) And fAplicarTaxaJurosPrecoSugestao Then
      Begin
        fatVenda.fltTaxJur := fatVenda.fGetTaxVprItem(arrMatrizItensParam[intContador].strCodIte);
        fltPreVen := fltPreVen + fFormataFloat(fltPreVen * (fatVenda.fGetTaxVprItem(arrMatrizItensParam[intContador].strCodIte) / 100.0), 04);
      End;

      If (fltPrvTin > 0) Then
      Begin
        fatVenda.fltUniVis := fltPrvTin;
        fatVenda.fltUniOri := fltPreVen;
      End;
    End;

    strDesCor          := arrMatrizItensParam[intContador].strDesCor;
    strIteTin          := arrMatrizItensParam[intContador].strIteTin;
    strCatalize        := arrMatrizItensParam[intContador].strCatali;
    strLinTin          := arrMatrizItensParam[intContador].strLinTin;
    strTipEmb          := arrMatrizItensParam[intContador].strTipEmb;
    fltQtdEmb          := arrMatrizItensParam[intContador].fltQtdEmb;
    strTipPre          := arrMatrizItensParam[intContador].strTipPre;
    intLazQua          := arrMatrizItensParam[intContador].intLazQua;
    fltPreEmb          := IfNull(arrMatrizItensParam[intContador].fltPreEmb, 0);
    fatVenda.strCodEmb := IfNull(arrMatrizItensParam[intContador].strIteEmb, '');
    strUnidad          := IIF(arrMatrizItensParam[intContador].strUnidad = Null, '', arrMatrizItensParam[intContador].strUnidad);
    strMontad          := IfNull(arrMatrizItensParam[intContador].strMontad, '');
    strA_n_o_          := IfNull(arrMatrizItensParam[intContador].strA_n_o_, '');
    fltVolPro          := IfNull(arrMatrizItensParam[intContador].fltVolPro,0);
    fltFatAce          := IfNull(arrMatrizItensParam[intContador].fltFatAce, 1.0);
    strNcmTin          := IIF(arrMatrizItensParam[intContador].strNcmTin = Null, '', arrMatrizItensParam[intContador].strNcmTin);
    strCoddil          := IfNull(arrMatrizItensParam[intContador].strCoddil, '');
    fltPorDil          := IfNull(arrMatrizItensParam[intContador].fltPorDil, 0.0);
    strDilCon          := IfNull(arrMatrizItensParam[intContador].strDilCon, '');
    fltPorCat          := IfNull(arrMatrizItensParam[intContador].fltPorCat, 0.0);
    strRefere          := IfNull(arrMatrizItensParam[intContador].strRefere, '');
    strDesIte          := IfNull(arrMatrizItensParam[intContador].strDesIte, '');
    strDesOri          := IfNull(arrMatrizItensParam[intContador].strDesOri, '');

    recForTin.intModDil        := IfNull(arrMatrizItensParam[intContador].recForTin.intModDil, 0);
    recForTin.strTextBase      := IfNull(arrMatrizItensParam[intContador].recForTin.strTextBase, '');
    recForTin.strTipCor        := IfNull(arrMatrizItensParam[intContador].recForTin.strTipCor, '');
    recForTin.blnTemSaldoVenda := arrMatrizItensParam[intContador].recForTin.blnTemSaldoVenda;
    recForTin.fltQtdMaximoBase := IfNull(arrMatrizItensParam[intContador].recForTin.fltQtdMaximoBase, 0);
    recForTin.strCompB         := IfNull(arrMatrizItensParam[intContador].recForTin.strCompB, '');
    recForTin.strUniver        := IfNull(arrMatrizItensParam[intContador].recForTin.strUniver, '');

    blnProAca          := False;
    fatVenda.strIdePro := 'NOR';

    fatVenda.pAdicionaRegistroTemporaria(cdsVenda,
                                         Nil,
                                         fatVenda.strIdePro,
                                         qryItem.FieldByName('ITE_CODGRU').AsString,
                                         qryItem.FieldByName('ITE_CODITE').AsString,
                                         strDesOri,
                                         strDesIte,
                                         qryItem.FieldByName('ITE_DESFAB').AsString,
                                         qryItem.FieldByName('ITE_CODUNI').AsString,
                                         qryItem.FieldByName('ITE_CODUNI').AsString,
                                         qryItem.FieldByName('ITE_CODMAR').AsString,
                                         qryItem.FieldByName('ITE_CODFOR').AsString,
                                         strRefere,
                                         fatVenda.fltUniOri,
                                         fatVenda.fltUniVis,
                                         fltPreVen,
                                         0.0,
                                         0,
                                         arrMatrizItensParam[intContador].fltQtdIte,
                                         fltPreVen * arrMatrizItensParam[intContador].fltQtdIte,
                                         'S',
                                         fatVenda.fltPreCus,
                                         fFormataFloat(fatVenda.fltPreCus * arrMatrizItensParam[intContador].fltQtdIte, 2),
                                         qryItem.FieldByName('ITE_COMLUB').AsString,
                                         qryItem.FieldByName('ITE_IPISAI').AsFloat,
                                         qryItem.FieldByName('ITE_DESMAX').AsFloat,
                                         fatVenda.fltPreVe1,
                                         fatVenda.fltPreVe2,
                                         fatVenda.fltPreVe3,
                                         fatVenda.fltPreVe4,
                                         fatVenda.fltPreVe5,
                                         fatVenda.fltPreVe6,
                                         fatVenda.fltPreVe7,

                                         fCalculaPrecoVenda(2, fatVenda.fltCusIte + qryItem.FieldByName('ITE_OUTVAL').AsFloat,
                                                               fltPreVen,
                                                               0,
                                                               qryItem.FieldByName('ITE_ICMSAI').AsFloat,
                                                               qryItem.FieldByName('ITE_IMPFED').AsFloat,
                                                               qryItem.FieldByName('ITE_DESOPE').AsFloat,
                                                               qryItem.FieldByName('ITE_COMTB' + fatVenda.strTabPre).AsFloat,
                                                               fatVenda.VS_strMARMKP,
                                                               fCfgSis('PCMPRO'),
                                                               fCfgSis('DECUNI')),

                                         qryItem.FieldByName('ITE_SALDOS').AsFloat,
                                         qryItem.FieldByName('ITE_INCPIS').AsString,
                                         qryItem.FieldByName('ITE_COMVAR').AsFloat,
                                         qryItem.FieldByName('ITE_COMATA').AsFloat,
                                         qryItem.FieldByName('ITE_COMDIS').AsFloat,
                                         '',
                                         '',
                                         '',
                                         0,
                                         0,
                                         '',
                                         fFormataFloat(qryItem.FieldByName('ITE_PREULT').AsFloat * arrMatrizItensParam[intContador].fltQtdIte, 2),
                                         fFormataFloat(qryItem.FieldByName('ITE_IMPULT').AsFloat, 2),
                                         fFormataFloat(qryItem.FieldByName('ITE_PREULT').AsFloat, 2),
                                         qryItem.FieldByName('ITE_PREMED').AsFloat,
                                         qryItem.FieldByName('ITE_CLAIPI').AsString,
                                         '',
                                         strIteTin,
                                         strDesCor,
                                         strTipPre,
                                         intLazQua,
                                         strTipEmb,
                                         fltQtdEmb,
                                         fltPreEmb,
                                         fltPrvTin,
                                         fltPrcTin,
                                         fltFatTin,
                                         'N',
                                         fatVenda.strCodEmb,
                                         0,
                                         0,
                                         qryItem.FieldByName('ITE_CODABF').AsString,
                                         qryItem.FieldByName('ITE_PESOIT').AsFloat,
                                         qryItem.FieldByName('ITE_PESLIQ').AsFloat,
                                         'N',
                                         fatVenda.fltProPreCus,
                                         fatVenda.fltProPreVen,
                                         fatVenda.fltProComVar,
                                         fatVenda.fltProDesF07,
                                         '',
                                         fatVenda.fRetPerComGrupo(qryItem.FieldByName('ITE_CODGRU').AsString),
                                         qryItem.FieldByName('ITE_CODFAB').AsString,
                                         0,
                                         0,
                                         '',
                                         '',
                                         '',
                                         qryItem.FieldByName('ITE_MARMIN').AsFloat,
                                         qryItem.FieldByName('ITE_MARMSG').AsFloat,
                                         qryItem.FieldByName('ITE_MARMGE').AsFloat,
                                         fRetNomMarca(qryItem.FieldByName('ITE_CODMAR').AsString),
                                         fatVenda.strStatus,
                                         0,
                                         0,
                                         '',
                                         strCatalize,
                                         strLinTin,
                                         qryItem.FieldByName('ITE_EMBALA').AsFloat,
                                         '',
                                         '',
                                         '',
                                         qryItem.FieldByName('ITE_PRECOM').AsFloat,
                                         fltPreVen,
                                         qryItem.FieldByName('ITE_QTPPRO').AsFloat,
                                         '',
                                         '',
                                         qryItem.FieldByName('ITE_OBRCPF').AsString,
                                         strMontad,
                                         strA_n_o_,
                                         fRetSiglaUnidade(qryItem.FieldByName('ITE_CODUNI').AsString),
                                         fltVolPro,
                                         cdsVenda.RecNo,
                                         strChaFor,
                                         strCodAca,
                                         strEmpAca,
                                         blnProAca,
                                         '',
                                         '',
                                         '',
                                         qryItem.FieldByName('ITE_OUTVAL').AsFloat,
                                         qryItem.FieldByName('ITE_COMTB' + fatVenda.strTabPre).AsFloat,
                                         qryItem.FieldByName('ITE_DESOPE').AsFloat,
                                         qryItem.FieldByName('ITE_ICMSAI').AsFloat,
                                         qryItem.FieldByName('ITE_IMPFED').AsFloat,
                                         qryItem.FieldByName('ITE_DESMGE').AsFloat,
                                         '',
                                         '',
                                         '',
                                         fatVenda.strTabPre,
                                         qryItem.FieldByName('ITE_IPIENT').AsFloat,
                                         qryItem.FieldByName('ITE_FREENT').AsFloat,
                                         strCoddil,
                                         fltPorDil,
                                         strDilCon,
                                         fltPorCat,
                                         '',
                                         '',
                                         'N',
                                         '',
                                         0,
                                         arrMatrizItensParam[intContador].fltQtdIte,
                                         0,
                                         0,
                                         IIF(fCfgSis('IMPDIG') = '1', qryItem.FieldByName('ITE_IMPDIR').AsString, qryItem.FieldByName('ITE_IMPDIR').AsString),
                                         qryItem.FieldByName('ITE_LOCFIS').AsString,
                                         fatVenda.fltPreCu2,
                                         fFormataFloat(fatVenda.fltPreCu2 * arrMatrizItensParam[intContador].fltQtdIte, 2),
                                         fatVenda.fltProComAta,
                                         fatVenda.fltProComDis,
                                         0,
                                         0,
                                         0,
                                         0,
                                         recForTin,
                                         '',
                                         '',
                                         arrMatrizItensParam[intContador].strNumLot,
                                         '',
                                         '',
                                         False,
                                         'N',
                                         'NOR',
                                         0,
                                         '',
                                         qryItem.FieldByName('ITE_CODBAR').AsString,
                                         '',
                                         0,
                                         fatVenda.fltPreLot,
                                         0,
                                         '',
                                         fltFatAce,
                                         True,
                                         '',
                                         '',
                                         '',
                                         0,
                                         fatVenda.fltCusIte,
                                         strNcmTin,
                                         '',
                                         recMadeira,
                                         fFormataFloat(qryItem.FieldByName('ITE_IMPULT').AsFloat * arrMatrizItensParam[intContador].fltQtdIte, 2),
                                         0,
                                         fatVenda.fltTaxJur,
                                         '',
                                         0,
                                         '',
                                         '',
                                         0,
                                         0,
                                         '',
                                         '',
                                         0,
                                         '',
                                         'N',
                                         0,
                                         0,
                                         0,
                                         False,
                                         False,
                                         'N',
                                         '',
                                         0,
                                         0,
                                         '',
                                         'N',
                                         0,
                                         '',
                                         '',
                                         '',
                                         '',
                                         qryItem.FieldByName('ITE_EXCIPI').AsString,
                                         qryItem.FieldByName('ITE_DESMSU').AsFloat,
                                         '',
                                         '',
                                         '',
                                         'S',
                                         'N',
                                         '',
                                         '',
                                         '',
                                         '',
                                         False,
                                         -1,
                                         -1,
                                         'N',
                                         '',
                                         'N',
                                         0,
                                         0,
                                         0,
                                         '',
                                         0,
                                         0,
                                         0,
                                         '',
                                         0,
                                         0,
                                         0,
                                         '',
                                         '',
                                         0,
                                         0,
                                         0,
                                         False,
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         '',
                                         '',
                                         0,
                                         0,
                                         '',
                                         '',
                                         'N',
                                         'N',
                                         '',
                                         0,
                                         0,
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         qryItem.FieldByName('ITE_DESMVM').AsFloat,
                                         qryItem.FieldByName('ITE_DESMSM').AsFloat,
                                         qryItem.FieldByName('ITE_DESMGM').AsFloat,
                                         qryItem.FieldByName('ITE_MARMMV').AsFloat,
                                         qryItem.FieldByName('ITE_MARMMS').AsFloat,
                                         qryItem.FieldByName('ITE_MARMMG').AsFloat);

    strIteTin               := '';
    strChaFor               := '';
    strCodAca               := '';
    strEmpAca               := '';
    strDesCor               := '';
    strCatalize             := '';
    strLinTin               := '';
    strMontad               := '';
    strA_n_o_               := '';
    strNcmTin               := '';
    strTipPre               := '';
    strTipEmb               := '';
    fatVenda.strCodEmb      := '';
    fatVenda.fltPreVe1      := 0.0;
    fatVenda.fltPreVe2      := 0.0;
    fatVenda.fltPreVe3      := 0.0;
    fatVenda.fltPreVe4      := 0.0;
    fatVenda.fltPreVe5      := 0.0;
    fatVenda.fltPreVe6      := 0.0;
    fatVenda.fltPreVe7      := 0.0;
    fatVenda.fltPreLot      := 0.0;
    fatVenda.fltSaldoMatriz := 0.0;

    If Assigned(qryItem) Then
      FreeAndNil(qryItem);

  end;

end;

procedure TGerarTe.pSetaDadosIniciais;
Var
  strIdePro   : String;
  strTabPre   : String;
begin
  fatVenda                := TfatVenda.CreateInstance('TE', Not fInTransaction);
  fatVenda.blnComTansacao := False;
  fatVenda.blnGerarNfePainel := False;

  fatVenda.strOpcDocTrue  := 'TE';
  pCriarCdsVenda(Nil);
  fatVenda.blnVerEstOrc   := False;
  fatVenda.strNomeForm    := 'frmFatVendas';
  fatVenda.fltValMor      := fCfgSis('TAXDIA', varDouble);
  strIdePro               := 'NOR';
  If fEmptyStr(fatVenda.strTabPre) Then
    fatVenda.strTabPre := '1';
  strTabPre               := fatVenda.strTabPre;
end;

end.
