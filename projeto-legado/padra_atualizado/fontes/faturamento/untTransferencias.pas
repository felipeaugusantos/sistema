unit untTransferencias;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  Forms, untFuncFat, untFuncoesSimples,
{$ENDIF}
  Classes, SysUtils, strUtils, Uni, untITransferencias,
  untTypesSistema,
  MaskUtils, Variants;

type
  TTransferencias = class(TInterfacedObject, ITransferencias)
  private
    FCodCndCadCli,
    FConPagCadCli,
    FCodFpgCadCli: String;
    {$IFNDEF LINUX}
    fatVenda: TFatVenda;
    {$ENDIF}
    dicRetorno: TDicionario;
    function fGetDicionario: TDicionario;
    function fGetNumeroTE: String;
  public
    strNum_TE : String;

    constructor Create;
    destructor Destroy; override;

    procedure pSetaDadosCliente(strCodCli, strCodVen: String);
    procedure pSetaProdutoAcabado(fltQtdIte: Double);
    procedure pSetaDadosIniciais(blnCriaTmp: Boolean = True);

    function fGeraTransferencia(strEspDoc: String = 'TE'; blnTEAutomatica: Boolean = False): Boolean;
  end;

implementation

uses
{$IFDEF LINUX}
  untFuncoesGenerica,
{$ELSE}
  untFuncoes, untDuplicatas, untGravando,
{$ENDIF}
  untTMatrizSaldosColorantes, untFuncFatTypes, untFuncTinta;

{ TTransferencias }

constructor TTransferencias.Create;
begin
  inherited Create;
  FCodCndCadCli := '';
  FConPagCadCli := '';
  FCodFpgCadCli := '';
end;

destructor TTransferencias.Destroy;
begin
  inherited Destroy;
end;

{$IFDEF LINUX}
function TTransferencias.fGeraTransferencia(strEspDoc: String = 'TE'; blnTEAutomatica: Boolean = False): Boolean;
begin
  raise Exception.Create('TTransferencias.fGeraTransferencia não possui implementacao para compilacao linux');
end;
{$ELSE}
function TTransferencias.fGeraTransferencia(strEspDoc: String = 'TE'; blnTEAutomatica: Boolean = False): Boolean;

    procedure pAcertaDadosCondicaoPagamento(fatVenda: TFatVenda);
      Var
        qryAux: TUniQuery;
    begin
      If (fEmptyStr(fatVenda.strCodCnd)) Then
        Exit;
      qryAux := fCriaQuery(Nil);
      With qryAux Do
      Begin
        SQL.Add('SELECT * FROM CADCND WHERE CND_CODIGO = :CODCND');
        ParamByName('CODCND').AsString := fatVenda.strCodCnd;
        Open;
        fatVenda.strDesCnd := FieldByName('CND_DESCRI').AsString;
        fatVenda.fltDMVCnd := FieldByName('CND_DESMAX').AsFloat;
        fatVenda.fltDMGCnd := FieldByName('CND_DESMGE').AsFloat;
        fatVenda.fltDMSCnd := FieldByName('CND_DESMSU').AsFloat;
        fatVenda.fltTxJCnd := FieldByName('CND_TXJURO').AsFloat;
        fatVenda.strCAbDes := FieldByName('CND_ABADES').AsString;
        fatVenda.strTipFor := FieldByName('CND_TIPFOR').AsString;
        fatVenda.strAbDeCc := FieldByName('CND_ABDECC').AsString;
        fatVenda.strJurPro := FieldByName('CND_JURPRO').AsString;
        fatVenda.strCndTbP := FieldByName('CND_TABPRE').AsString;
        fatVenda.strCndTpm := FieldByName('CND_PRETAB').AsString;
      End;
      FreeAndNil(qryAux);
    end;

  Var
    fltTotDup: Double;
    strNomeVendedor: string;
    frmGravando: TfrmGravando;
begin
  If Not fatVenda.blnCliFil Then
  Begin
    Result := False;
    Exit;
  End;

  Try
    strNomeVendedor := '';
    fatVenda.pCarregaAliquotasRetencao;
    fatVenda.blnFecharForm := False;
    fatVenda.blnGerandoTEAutomatica := blnTEAutomatica;

    pAcertaDadosCondicaoPagamento(fatVenda);
    fatVenda.fltPorDes     := fatVenda.fltPorDesTmp;
    fatVenda.strEspDoc     := strEspDoc; //'TE';

    fatVenda.strConPag := '01000';

    if not fEmptyStr(IfNull(dicRetorno['numdoc_pfl'], '')) then
    begin
      if not fEmptyStr(IfNull(dicRetorno['codven_pfl'], '')) then
        strNomeVendedor := fRetNomVendRep(dicRetorno['codven_pfl']);

      fatVenda.strMen001 := 'TRANSF.REF. ' +
                            IfNull(dicRetorno['numdoc_pfl'], '') + '-' +
                            IfNull(dicRetorno['espdoc_pfl'], '') + '-' +
                            IfNull(dicRetorno['codemp_pfl'], '') + ' - VEND: ' +
                            IfNull(dicRetorno['codven_pfl'], '') + '-' + strNomeVendedor;
    end;

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

    Result := True;
    Repeat
      fStartTransaction;

      pCriarFormularios(TfrmGravando, frmGravando);
      Try
        Try
          frmGravando.strChave      := 'FATVENDAS';
          frmGravando.fExecutarAcao := fatVenda.fGravaArquivos;
          frmGravando.ShowModal;
          Result                    := frmGravando.blnConfirma;
          strNum_TE                 := fatVenda.strNumDoc;
        Except
          On E: Exception Do
          Begin
            Result := False;
            pMensagensErro(E.Message, '');
          End;
        End;
      Finally
        pFreeAndNil(frmGravando);
      End;

      If (Not Result) Then
        Abort;

      If Result Then
        fCommit
      Else
      Begin
        Result := False;
        fRollBack;
      End;
    Until (Result);
  Except
    On E: EAbort Do
    Begin
      Result := False;
      fRollBack;
      fMensagem('ATENÇÃO!', 'Houve um problema na gravação. Pressione [ENTER] para continuar.', ['&Ok']);
    End;

    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '');
      fMensagem('ATENÇÃO!', 'Houve um problema na gravação. Pressione [ENTER] para continuar.', ['&Ok']);
    End;
  End;
end;
{$ENDIF}

function TTransferencias.fGetDicionario: TDicionario;
begin
  Result := dicRetorno;
end;

function TTransferencias.fGetNumeroTE: String;
begin
  Result := strNum_TE;
end;

{$IFDEF LINUX}
procedure TTransferencias.pSetaDadosCliente(strCodCli, strCodVen: String);
begin
  raise Exception.Create('TTransferencias.pSetaDadosCliente não possui implementacao para compilacao linux');
end;
{$ELSE}
procedure TTransferencias.pSetaDadosCliente(strCodCli, strCodVen: String);
  Var
    strSQL   : String;
    qryCadCli: TUniQuery;
begin
  qryCadCli := fCriaQuery(Nil);

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
  strSQL := strSQL + '   CLI_DESZON AS DESZON, ';

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
  With qryCadCli Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCLI').AsString := fatVenda.strCodCli;
    Open;

    Self.FCodCndCadCli := FieldByName('CODCND_SUGEST').AsString;
    Self.FConPagCadCli := FieldByName('CONPAG_SUGEST').AsString;
    Self.FCodFpgCadCli := FieldByName('CODFPG_SUGEST').AsString;

    fatVenda.strCliNom     := FieldByName('CLINOM').AsString;                       //         - Nome
    fatVenda.strCliOri     := FieldByName('CLIORI').AsString;                       //         - Nome Original
    fatVenda.strCliEnd     := FieldByName('ENDERE').AsString;                       //         - Endereco
    fatVenda.strCliNum     := FieldByName('ENDNUM').AsString;                       //         - Numero
    fatVenda.strCliBai     := FieldByName('BAIRRO').AsString;                       //         - Bairro
    fatVenda.strCliCep     := FieldByName('C_E_P_').AsString;                       //         - Cep
    fatVenda.strCodCid     := FieldByName('CODCID').AsString;                       //         - Cód. Cidade
    fatVenda.strCliCid     := fRetNomCidade(FieldByName('CODCID').AsString, 0);     //         - Cidade
    fatVenda.strCliEst     := fRetNomCidade(FieldByName('CODCID').AsString, 1);     //         - Estado
    fatVenda.strCliTel     := FieldByName('FONE01').AsString;                       //         - Telefone
    fatVenda.strCli_Rg     := FieldByName('NUM_RG').AsString;                       //         - RG
    fatVenda.strCliCgc     := fTiraCaracEspeciais(FieldByName('C_G_C_').AsString);  //         - CNPJ
    fatVenda.strCliCgc     := AnsiReplaceStr(fatVenda.strCliCgc, '.', '');          //
    fatVenda.intCgcCpf     := FieldByName('CGCCPF').AsInteger;                      //         - CGC/CPF
    fatVenda.strCliIes     := FieldByName('I_E_S_').AsString;                       //         - Ins.Estadual
    fatVenda.strCliImp     := FieldByName('I_M_P_').AsString;                       //         - Insc. Municipal Produtor
    fatVenda.strProRur     := FieldByName('PRORUR').AsString;                       //         - Produtor Rural
    fatVenda.strMicEmp     := FieldByName('MICEMP').AsString;                       //         - MEI-Micro Empreendedor Individual
    fatVenda.strRetPCo     := FieldbyName('RETPCO').AsString;                       //         - Retenção de Pis e Cofins
    fatVenda.strRetIrf     := FieldbyName('RETIRF').AsString;                       //         - Retenção de IRPF
    fatVenda.strRetIss     := FieldbyName('RETISS').AsString;                       //         - Retenção de ISS
    fatVenda.strCliOrg     := FieldByName('ORGPUB').AsString;                       //         - Orgao Publico
    fatVenda.strDesPis     := FieldByName('DESPIS').AsString;                       //         - Orgao Publico
    fatVenda.strOrPuRD     := FieldbyName('ORPURD').AsString;                       //         - Tipo de Desconto (Rateio / Desconto)
    fatVenda.strCalIcm     := FieldbyName('CALICM').AsString;                       //         - Calcula Desconto de ICMS (Orgão Public)
    fatVenda.strZonFra     := FieldByName('ZONFRA').AsString;                       //         - Zona Francade Manaus
    fatVenda.strDesZon     := FieldByName('DESZON').AsString;                       //         - Cliente Zona Franca com desconto especial
    fatVenda.strCliCon     := FieldByName('CONSUM').AsString;                       //         - Consumidor Final (S/N)
    fatVenda.blnCliFil     := fatVenda.fClienteFilialVenda(FieldByName('CODCLI').AsString); // - Cliente Filial
    fatVenda.fltFat_TE     := fatVenda.recDadCli.fltFat_TE;
    fatVenda.strTEPREV     := fatVenda.recDadCli.strTEPREV;

    If Assigned(dicRetorno) Then
    Begin
      dicRetorno['usaprecus'] := (fatVenda.blnCliFil) And (fatVenda.strTEPREV = 'CUS');
    End;

    If (fCfgSis('TBPSUG') = '0') Then
    Begin
      fatVenda.strTabPre := FieldByName('TABPRE').AsString;

      If fEmptyStr(fatVenda.strTabPre) And fCfgSis('HIETAB', VarBoolean) Then
        fatVenda.strTabPre := fCampoTabela('OPE_TABPRE', 'CADOPE', ['OPE_CODOPE'], [fatVenda.strCodVen], False);

      If (fEmptyStr(fatVenda.strTabPre)) Then
        If (Not fEmptyStr(fCfgSis('TBPRPD', varString))) Then
          fatVenda.strTabPre := fCfgSis('TBPRPD', varString);
    End
    Else
      fatVenda.strTabPre := fCfgSis('TBPSUG');                                      // Tabela de Preço

    fatVenda.strCodVen     := strCodVen;                                            // Vendedor      - Codigo
    fatVenda.strCodRep     := FieldByName('CODREP').AsString;
    fatVenda.strCodDig     := strLoginUsuarioLogado;
    fatVenda.strNomVen     := fRetNomVendRep(FieldByName('CODVEN').AsString);       // Vendedor      - Nome
    fatVenda.strCliEma     := FieldByName('EMAIL_').AsString;                       // Email
    fatVenda.strCliEm2     := FieldByName('EMAIL2').AsString;                       // Email 2
    fatVenda.strEndEnt     := FieldByName('ENDENT').AsString;
    fatVenda.strBaiEnt     := FieldByName('BAIENT').AsString;
    fatVenda.strCepEnt     := FormatMaskText('99999-999;0;_', FieldByName('CEPENT').AsString);
    fatVenda.strCidEnt     := fRetNomCidade(FieldByName('CIDENT').AsString);
    fatVenda.strEstEnt     := fRetNomCidade(FieldByName('CIDENT').AsString, 1);
    fatVenda.strRefEnt     := FieldByName('REFENT').AsString;
    fatVenda.strCliAti     := FieldByName('CODATI').AsString;                       // Atividade
    fatVenda.blnConstr     := (fAtividadeConstrutora(FieldByName('CODATI').AsString)); // Cliente Construtora?
    fatVenda.strEndCob     := FieldByName('ENDCOB').AsString;
    fatVenda.strBaiCob     := FieldByName('BAICOB').AsString;
    fatVenda.strCepCob     := FormatMaskText('99999-999;0;_', FieldByName('CEPCOB').AsString);
    fatVenda.strCidCob     := fRetNomCidade(FieldByName('CIDCOB').AsString);
    fatVenda.strEstCob     := fRetNomCidade(FieldByName('CIDCOB').AsString, 1);
    fatVenda.fltRedIcmsCli := FieldByName('REDICM').AsFloat;

    fatVenda.pProcessarDespesasOperacionaisComplementar(FieldByName('DESOPE').AsFloat);

    fatVenda.strCliPer     := FieldByName('PERMUT').AsString;
    Close;
  End;
  FreeAndNil(qryCadCli);
  fatVenda.pAtualizaClassTransferencias;
end;
{$ENDIF}

{$IFDEF LINUX}
procedure TTransferencias.pSetaProdutoAcabado(fltQtdIte: Double);
begin
  raise Exception.Create('TTransferencias.pSetaProdutoAcabado não possui implementacao para compilacao linux');
end;
{$ELSE}
procedure TTransferencias.pSetaProdutoAcabado(fltQtdIte: Double);
  Var
    qryItem     : TUniQuery;
    strSQL      : String;
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
    fltPreVen   : Double;
    fltFatTin   : Double;
    fltPrcTin   : Double;
    fltPrvTin   : Double;
    fltPreEmb   : Double;
    fltEmbala   : Double;
    fltVolPro   : Double;
    fltFatAce   : Double;
    fltPorDil   : Double;
    fltPorCat   : Double;
    intQtdEmb   : Integer;
    intLazQua   : Integer;
    blnProAca   : Boolean;
    recForTin   : TForTin;
    recMadeira  : TDadosMadeira;   

    procedure pCarregaItem;
    begin
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
      With qryItem Do
      Begin
        Close;
        SQL.Clear;
        SQL.Text := strSQL;
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('CODITE').AsString := dicRetorno['codite'];
        Open;
      End;
    end;

    procedure pLimpaVariaveisReferentesAoProduto;
    begin
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
      intLazQua               := 0;
      intQtdEmb               := 0;
      fltEmbala               := 0.0;
      fltPreEmb               := 0.0;
      fltPrvTin               := 0.0;
      fltPrcTin               := 0.0;
      fltFatTin               := 0.0;
      fltVolPro               := 0.0;
      fltFatAce               := 0.0;
      blnProAca               := False;
      fatVenda.strIdePro      := 'NOR';
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
    end;

begin
  Try
    pCarregaItem;

    fltPreVen := dicRetorno['unitar'];
    fatVenda.fltTaxJur := 0;

    If (fatVenda.fAplicaTaxaJuros) Then
    Begin
      If fAplicarTaxaJurosPrecoSugestao Then
      Begin
        fatVenda.fltTaxJur := fatVenda.fGetTaxVprItem(dicRetorno['codite']);
        fltPreVen := fltPreVen + fFormataFloat(fltPreVen * (fatVenda.fGetTaxVprItem(dicRetorno['codite']) / 100.0), 04);
      End;
    End;

    fatVenda.fltUniOri := fltPreVen;
    fatVenda.fltUniVis := dicRetorno['unitar'];

    fatVenda.fltPreCus := dicRetorno['precus'];
    fatVenda.fltPreCu2 := IfNull(dicRetorno['precu2'], dicRetorno['precus']);

    fatVenda.fltComAnt := dicRetorno['precus'];
    fatVenda.fltPreVe1 := IfNull(dicRetorno['preve1'], fatVenda.fltUniVis);
    fatVenda.fltPreVe2 := IfNull(dicRetorno['preve2'], fatVenda.fltUniVis);
    fatVenda.fltPreVe3 := IfNull(dicRetorno['preve3'], fatVenda.fltUniVis);
    fatVenda.fltPreVe4 := IfNull(dicRetorno['preve4'], fatVenda.fltUniVis);
    fatVenda.fltPreVe5 := IfNull(dicRetorno['preve5'], fatVenda.fltUniVis);
    fatVenda.fltPreVe6 := IfNull(dicRetorno['preve6'], fatVenda.fltUniVis);
    fatVenda.fltPreVe7 := IfNull(dicRetorno['preve7'], fatVenda.fltUniVis);

    fltFatTin          := IfNull(dicRetorno['fattin'], 0);
    fltPrcTin          := IfNull(dicRetorno['prctin'], 0);
    fltPrvTin          := IfNull(dicRetorno['prvtin'], 0);

    If (fltPrcTin <= 0) Then
      fltPrcTin := fatVenda.fltPreCus;

    If (fltPrvTin <= 0) Then
      fltPrvTin := fatVenda.fltUniVis;

    If fatVenda.blnCliFil Then
    Begin
      strOpcPre := fatVenda.strTEPREV;

      If (strOpcPre = 'VE1') Then
        fltPrvTin := fatVenda.fltPreVe1

      Else If (strOpcPre = 'VE2') Then
        fltPrvTin := fatVenda.fltPreVe2

      Else If (strOpcPre = 'VE3') Then
        fltPrvTin := fatVenda.fltPreVe3

      Else If (strOpcPre = 'VE4') Then
        fltPrvTin := fatVenda.fltPreVe4

      Else If (strOpcPre = 'VE5') Then
        fltPrvTin := fatVenda.fltPreVe5

      Else If (strOpcPre = 'VE6') Then
        fltPrvTin := fatVenda.fltPreVe6

      Else If (strOpcPre = 'VE7') Then
        fltPrvTin := fatVenda.fltPreVe7

      Else
        fltPrvTin := fatVenda.fltPreCus;

      If (fatVenda.fltFat_TE > 0) Then
        fltPrvTin := fltPrvTin * fatVenda.fltFat_TE;

      fltPreVen := fltPrvTin;
      fatVenda.fltTaxJur := 0.00;

      If (fatVenda.fAplicaTaxaJuros) Then
      Begin
        If fAplicarTaxaJurosPrecoSugestao Then
        Begin
          fatVenda.fltTaxJur := fatVenda.fGetTaxVprItem(dicRetorno['codite']);
          fltPreVen := fltPreVen + fFormataFloat(fltPreVen * (fatVenda.fGetTaxVprItem(dicRetorno['codite']) / 100.0), 04);
        End;
      End;

      If (fltPrvTin > 0) Then
      Begin
        fatVenda.fltUniVis := fltPrvTin;
        fatVenda.fltUniOri := fltPreVen;
      End;
    End;

    strDesCor          := dicRetorno['descor'];
    strIteTin          := dicRetorno['itetin'];
    strCatalize        := dicRetorno['catali'];
    strLinTin          := dicRetorno['linha_'];
    strTipEmb          := dicRetorno['tipemb'];
    intQtdEmb          := dicRetorno['qtdemb'];
    strTipPre          := dicRetorno['tippre'];
    intLazQua          := dicRetorno['lazqua'];
    fltPreEmb          := IfNull(dicRetorno['preemb'], 0);
    fltEmbala          := IfNull(dicRetorno['embala'], 0);
    fatVenda.strCodEmb := IfNull(dicRetorno['iteemb'], '');
    strUnidad          := IIF(dicRetorno['unidad'] = Null, '', dicRetorno['unidad']);
    strMontad          := IfNull(dicRetorno['montad'], '');
    strA_n_o_          := IfNull(dicRetorno['a_n_o_'], '');
    fltVolPro          := IfNull(dicRetorno['volpro'],0);
    fltFatAce          := IfNull(dicRetorno['fatace'], 1.0);
    strNcmTin          := IIF(dicRetorno['ncmemb'] = Null, '', dicRetorno['ncmemb']);
    strCoddil          := IfNull(dicRetorno['coddil'], '');
    fltPorDil          := IfNull(dicRetorno['pordil'], 0.0);
    strDilCon          := IfNull(dicRetorno['dilcon'], '');
    fltPorCat          := IfNull(dicRetorno['porcat'], 0.0);

    recForTin.intModDil        := IfNull(dicRetorno['moddil'], 0);
    recForTin.strTextBase      := IfNull(dicRetorno['texbas'], '');
    recForTin.strTipCor        := IfNull(dicRetorno['tipcor'], '');
    recForTin.Formulas         := TClassMatrizSaldosColorantes(dicRetorno.RetornaObjeto('formul'));
    recForTin.blnTemSaldoVenda := IfNull(dicRetorno['saldocols'], True);
    recForTin.fltQtdMaximoBase := IfNull(dicRetorno['maximoqtdbase'], 0);
    recForTin.strCompB         := IfNull(dicRetorno['complementob'], '');
    recForTin.strUniver        := IfNull(dicRetorno['univer'], '');

    fatVenda.strIdePro := 'NOR';
    blnProAca          := True;
    strCodAca          := dicRetorno['codaca'];
    strEmpAca          := dicRetorno['empaca'];
    strRefere          := '';
    strDesIte          := dicRetorno['desaca'];

    With qryItem Do
    Begin
      fatVenda.pAdicionaRegistroTemporaria(cdsVenda,
                                           Nil,
                                           fatVenda.strIdePro,
                                           FieldByName('ITE_CODGRU').AsString,
                                           FieldByName('ITE_CODITE').AsString,
                                           strDesIte,
                                           strDesIte,
                                           FieldByName('ITE_DESFAB').AsString,
                                           FieldByName('ITE_CODUNI').AsString,
                                           FieldByName('ITE_CODUNI').AsString,
                                           FieldByName('ITE_CODMAR').AsString,
                                           FieldByName('ITE_CODFOR').AsString,
                                           strRefere,
                                           fatVenda.fltUniOri,
                                           fatVenda.fltUniVis,
                                           fltPreVen,
                                           0.0,
                                           0,
                                           fltQtdIte,
                                           fltPreVen * fltQtdIte,
                                           'S',
                                           fatVenda.fltPreCus,
                                           fFormataFloat(fatVenda.fltPreCus * fltQtdIte, 2),
                                           FieldByName('ITE_COMLUB').AsString,
                                           FieldByName('ITE_IPISAI').AsFloat,
                                           FieldByName('ITE_DESMAX').AsFloat,
                                           fatVenda.fltPreVe1,
                                           fatVenda.fltPreVe2,
                                           fatVenda.fltPreVe3,
                                           fatVenda.fltPreVe4,
                                           fatVenda.fltPreVe5,
                                           fatVenda.fltPreVe6,
                                           fatVenda.fltPreVe7,

                                           fCalculaPrecoVenda(2, fatVenda.fltCusIte + FieldByName('ITE_OUTVAL').AsFloat,
                                                                 fltPreVen,
                                                                 0,
                                                                 FieldByName('ITE_ICMSAI').AsFloat,
                                                                 FieldByName('ITE_IMPFED').AsFloat,
                                                                 FieldByName('ITE_DESOPE').AsFloat,
                                                                 FieldByName('ITE_COMTB' + fatVenda.strTabPre).AsFloat,
                                                                 fatVenda.VS_strMARMKP,
                                                                 fCfgSis('PCMPRO'),
                                                                 fCfgSis('DECUNI')),

                                           FieldByName('ITE_SALDOS').AsFloat,
                                           FieldByName('ITE_INCPIS').AsString,
                                           FieldByName('ITE_COMVAR').AsFloat,
                                           FieldByName('ITE_COMATA').AsFloat,
                                           FieldByName('ITE_COMDIS').AsFloat,
                                           '',
                                           '',
                                           '',
                                           0,
                                           0,
                                           '',
                                           fFormataFloat(FieldByName('ITE_PREULT').AsFloat * fltQtdIte, 2),
                                           fFormataFloat(FieldByName('ITE_IMPULT').AsFloat, 2),
                                           fFormataFloat(FieldByName('ITE_PREULT').AsFloat, 2),
                                           FieldByName('ITE_PREMED').AsFloat,
                                           FieldByName('ITE_CLAIPI').AsString,
                                           '',
                                           strIteTin,
                                           strDesCor,
                                           strTipPre,
                                           intLazQua,
                                           strTipEmb,
                                           intQtdEmb,
                                           fltPreEmb,
                                           fltPrvTin,
                                           fltPrcTin,
                                           fltFatTin,
                                           'N',
                                           fatVenda.strCodEmb,
                                           0,
                                           0,
                                           FieldByName('ITE_CODABF').AsString,
                                           FieldByName('ITE_PESOIT').AsFloat,
                                           FieldByName('ITE_PESLIQ').AsFloat,
                                           'N',
                                           fatVenda.fltProPreCus,
                                           fatVenda.fltProPreVen,
                                           fatVenda.fltProComVar,
                                           fatVenda.fltProDesF07,
                                           '',
                                           fatVenda.fRetPerComGrupo(FieldByName('ITE_CODGRU').AsString),
                                           FieldByName('ITE_CODFAB').AsString,
                                           0,
                                           0,
                                           '',
                                           '',
                                           '',
                                           FieldByName('ITE_MARMIN').AsFloat,
                                           FieldByName('ITE_MARMSG').AsFloat,
                                           FieldByName('ITE_MARMGE').AsFloat,
                                           fRetNomMarca(FieldByName('ITE_CODMAR').AsString),
                                           fatVenda.strStatus,
                                           0,
                                           0,
                                           '',
                                           strCatalize,
                                           strLinTin,
                                           FieldByName('ITE_EMBALA').AsFloat,
                                           '',
                                           '',
                                           '',
                                           FieldByName('ITE_PRECOM').AsFloat,
                                           fltPreVen,
                                           FieldByName('ITE_QTPPRO').AsFloat,
                                           '',
                                           '',
                                           FieldByName('ITE_OBRCPF').AsString,
                                           strMontad,
                                           strA_n_o_,
                                           fRetSiglaUnidade(FieldByName('ITE_CODUNI').AsString),
                                           fltVolPro,
                                           cdsVenda.RecNo,
                                           strChaFor,
                                           strCodAca,
                                           strEmpAca,
                                           blnProAca,
                                           '',
                                           '',
                                           '',
                                           FieldByName('ITE_OUTVAL').AsFloat,
                                           FieldByName('ITE_COMTB' + fatVenda.strTabPre).AsFloat,
                                           FieldByName('ITE_DESOPE').AsFloat,
                                           FieldByName('ITE_ICMSAI').AsFloat,
                                           FieldByName('ITE_IMPFED').AsFloat,
                                           FieldByName('ITE_DESMGE').AsFloat,
                                           '',
                                           '',
                                           '',
                                           fatVenda.strTabPre,
                                           FieldByName('ITE_IPIENT').AsFloat,
                                           FieldByName('ITE_FREENT').AsFloat,
                                           strCoddil,
                                           fltPorDil,
                                           strDilCon,
                                           fltPorCat,
                                           '',
                                           '',
                                           'N',
                                           '',
                                           0,
                                           fltQtdIte,
                                           0,
                                           0,
                                           IIF(fCfgSis('IMPDIG') = '1', FieldByName('ITE_IMPDIR').AsString, FieldByName('ITE_IMPDIR').AsString),
                                           FieldByName('ITE_LOCFIS').AsString,
                                           fatVenda.fltPreCu2,
                                           fFormataFloat(fatVenda.fltPreCu2 * fltQtdIte, 2),
                                           fatVenda.fltProComAta,
                                           fatVenda.fltProComDis,
                                           0,
                                           0,
                                           0,
                                           0,
                                           recForTin,
                                           '',
                                           '',
                                           '',
                                           '',
                                           '',
                                           False,
                                           'N',
                                           'NOR',
                                           0,
                                           '',
                                           FieldByName('ITE_CODBAR').AsString,
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
                                           fFormataFloat(FieldByName('ITE_IMPULT').AsFloat * fltQtdIte, 2),
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
                                           FieldByName('ITE_EXCIPI').AsString,
                                           FieldByName('ITE_DESMSU').AsFloat,
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
                                           FieldByName('ITE_DESMVM').AsFloat,
                                           FieldByName('ITE_DESMSM').AsFloat,
                                           FieldByName('ITE_DESMGM').AsFloat,
                                           FieldByName('ITE_MARMMV').AsFloat,
                                           FieldByName('ITE_MARMMS').AsFloat,
                                           FieldByName('ITE_MARMMG').AsFloat);
      pLimpaVariaveisReferentesAoProduto;
    End;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '');
    End;
  End;
end;
{$ENDIF}

{$IFDEF LINUX}
procedure TTransferencias.pSetaDadosIniciais(blnCriaTmp: Boolean = True);
begin
  raise Exception.Create('TTransferencias.pSetaDadosIniciais não possui implementacao para compilacao linux');
end;
{$ELSE}
procedure TTransferencias.pSetaDadosIniciais(blnCriaTmp: Boolean = True);
  Var
    strIdePro   : String;
    strTabPre   : String;
    strEmpSalRes: String;
begin
  //pDestroyObjetos;
  fatVenda                := TfatVenda.CreateInstance('TE', blnCriaTmp);
  fatVenda.strOpcDocTrue  := 'TE';
  fatVenda.blnApenasLevantaExcecao := True;
  pCriarCdsVenda(Nil);
  fatVenda.blnVerEstOrc   := False;
  fatVenda.strNomeForm    := 'frmFatVendas';
  fatVenda.fltValMor      := fCfgSis('TAXDIA', varDouble);
  dicRetorno              := TDicionario.Create;
  dicRetorno.Limpar;
  strIdePro               := 'NOR';
  If fEmptyStr(fatVenda.strTabPre) Then
    fatVenda.strTabPre := '1';
  strTabPre               := fatVenda.strTabPre;
  dicRetorno['idepro']    := strIdePro;
  dicRetorno['codemp']    := strEmpSalRes;
  dicRetorno['opcdoc']    := 'TE';
  dicRetorno['tippre']    := '';
  dicRetorno['lazqua']    := 0;
  dicRetorno['tipemb']    := '';
  dicRetorno['qtdemb']    := 0;
  dicRetorno['tabpre']    := strTabPre;
  dicRetorno['linha_']    := '';
  dicRetorno['catali']    := '';
end;
{$ENDIF}

end.
