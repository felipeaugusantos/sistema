unit Services.Core.Settings;

interface

uses System.SysUtils, System.StrUtils, System.Generics.COllections,
  System.Classes, System.Variants, Services.Core.Types;

type
  TPermissoesAcesso = class
    private
      FUsuarios: TDictionary<String, TObject>;
      class var FInstance: TPermissoesAcesso;
      function fCarregarAcessosUsuario(strCodOpe: String): TStringList;
    protected
      constructor Create;
    public
      destructor Destroy; override;
      class function GetInstance(): TPermissoesAcesso;
      function fVerificaAcesso(strNomeForm, strCodOpe: String): Boolean;
      procedure pLimpar;
  end;

function fEhAdministrador(strCodOpe: String): Boolean;

function fConfiguracaoExiste(strCodCfg: string; strCodEmp: string = ''): boolean;

function fVerificaAcessoSistema(strNomeForm: String; strCodOpe: String = ''): Boolean;

function fPermiteEmissaoEspecie(strEspecie: String; strCodEmp: String = ''): Boolean;

procedure pEsvaziaArrayCfgDes;

function fCfgSis(strCamCfg: String; varTipVar: TVarType = varString;
  strCodEmp: String = ''): Variant;

function fCfgSisExist(strCamCfg: String; strCodEmp: String): Boolean;

function fCfgSisL(strCamCfg: String; varTipVar: TVarType = varString;
  strCodEmp: String = ''; dicCfgSis: TDictionary<String, String> = Nil)
  : Variant;

function fAtuCfgSis(strCamCfg: String; strValCfg: String;
  strCodEmp: String = ''): Boolean;

procedure pCriarCfgSis(strCodCfg: String; strDesCfg: String; strGruCfg: String; strValCfg: String);

function fUsaImpostoFonteIBPT: Boolean;

function fUsaRotinaWMS(strCodEmp: String = ''): Boolean;

function fUsaOndaSeparacaoAgrupamento(): Boolean;

function fSolicitaDigDuplicAdiantamentoPedido: Boolean;

function fUsaRotinaExpedicaoConferenciaRetiraCaixa(): Boolean;

function fUsaQtdPendenteEntregaFutura(blnConsiderarCfgCalSal: Boolean = True; strEmpSalRes : String = ''): Boolean;

function fReservaSaldoPedidosBaixaEntregaFutura: Boolean;

function fRetEmpresaMatrizDoGrupo(strCodEmp: String): String;

function GetIniFile(): String;
function ReadIniFile(ASection, AIdenty, ADefault, AFile: String): String;
function WriteIniFile(ASection, AIdenty, ADefault, AFile: String): String;

procedure pDefinirEmpresa(ACodEmp: string = '');
procedure pDefinirUsuario;
procedure pIniciarVariaveis;
procedure pAtuTabPrc;

function fCfgExpedicaoParcialHabilitada: Boolean;

function VS_strCodEmp(): String;

procedure pSetaEmpresaLogada(AValue: string);
procedure pSetaEmpresaCalculandoImpostos(AValue: string);

var
  strLoginUsuarioLogado: String;
  strEmpAcessoUsuarioLogado: String;
  strListIdGerEle: TStringList;
  HandleDllTinta: THandle;
  VS_strCliFil: String;
  VS_strHabilitarCRM: Boolean;
  VS_strUsaTmq: String;
  VS_strTipExp: String;
  VS_strTRADES: String;
  VS_strTabPrc: String;
  VS_strTabVen: String;
  VS_strTabFat: String;
  VS_strCfoIPI: String;
  VS_strClaCom: String;
  VS_strClaVen: String;
  VS_strClaDev: String;
  VS_strClaDVC: String;
  VS_strClaNfo: String;
  VS_strClaNOE: String;
  VS_strCla_UC: String;
  VS_strClaRGF: String;
  VS_strClaRGR: String;
  VS_strNaoCab: String;
  VS_strClaGir: String;
  VS_strEspGir: String;
  VS_strLockMonitorAudit: String;
  VS_strLockMonitorStatus: String;
  VS_strLockMonitorEntregaFutura: String;
  VS_strLockMonitorReservaItem: String;
  VS_strLockProdutosAcabadosIndustrial: String;
  VS_strLockMonitorEnviaRegFusion: String;
  VS_strLockMonitorRomaneioIntegFusion: String;
  VS_strTabelaErro: String;
  VS_blnPreAltViaTrigger: Boolean;
  VS_strCreCGC: String;
  VS_intConEst: Integer;
  VS_intConAcu: Integer;
  VS_blnGravaLogTransacao: Boolean;
  VS_blnNotificaSaldoAbaixMinimo: Boolean;
  VS_intTamPrecoIteger: Integer;
  VS_intTamPrecoItepro: Integer;
  VS_ArrCfgSisDes: TArray<String>;
  VS_EmpCfgSisDes: String;
  Vs_strTpAbreDes : String;
  VS_strTxjCni: String;
  VS_strZfmCst: String;
  VS_strEmpPrd: String;
  VS_strClaT01: String;
  VS_strClaT02: String;
  VS_strClaT03: String;
  VS_strClaT04: String;
  VS_strClaID1: String;
  VS_strClaID2: String;
  VS_strClaID3: String;
  VS_strCSTT01: String;
  VS_strCSTT02: String;
  VS_strCSTT03: String;
  VS_strUltimaMensagem: String;{ TODO : remover variavel global }
  VS_intOPCROM: String;

var
  fCriarConfiguracoes: TfCriarConfiguracoes;

const
  consChavesCript: string = 'CFG_CITPSP;CFG_SENPDS;CFG_SENWBL';
  STR_SQL_NAO_REPLICAR = '/* SQL_NAO_REPLICAR */';
  SIGLA_DISPARO_API = '/* REQUEST AUTOMATICO DE API */';
  cnsNomeIdxGrid: String = '_IDXGRD_';
  LOG_ADM = '999';
  TOLERANCIA_DIFERENCA_EXPEDICAO_PARCIAL = 0.05;
  NO_TIME_LIMIT = 0;
  spIdLockProdAcabadosIndustrial = 'PRODUTOS_ACABADOS_INDUSTRIAL_%s';
  spIdRecebiveisAlpe = 'RECEBIVEIS_ALPE_%s';
  spAttemptsLockAlpe = 10;
  spIdCalculoRota = 'CALCULO_ROTA_%s';
  spAttemptsLockCalculoRota = 10;
  spIdPesquisaSatisfacaoTracksale = 'PESQUISA_SATISFACAO_TRACKSALE_%s';
  spAttemptsLockPesquisaSatisfacaoTracksale = 10;
  spIdGestorEquipeContele = 'GESTOR_EQUIPE_CONTELE_%s';
  spAttemptsLockGestorEquipeContele = 10;
  spIdGestorComissaoProfissional = 'ENVIA_COMISSAO_PROFISSIONAL_%s';
  spAttemptsLockComissaoProfissional = 10;
  spIdGestorBoschFun = 'BOSCHFUN_%s';
  spAttemptsLockBoschFun = 10;
  spIdIntelipost = 'INTELIPOST_%s';
  spAttemptsLockIntelipost = 10;
  spIdCatalogoFraga = 'CATALOGO_FRAGA_%';
  spAttemptsLockCatalogoFraga = 10;
  spIdDataFrete = 'DATAFRETE_%s';
  spAttemptsLockDataFrete = 10;

var
  dicConfiguracoes: TDictionary<String, String>;

implementation

uses Services.Core.Connection.Manager, Services.Core.Connection.Interfaces,
  Services.Core.Utils, System.IOUtils, System.IniFiles;

var
  FMREW: TMultiReadExclusiveWriteSynchronizer;
  FEmpresaLogada: string;
  FEmpresaCalculandoImpostos: string;

{ TCoreSettings }

procedure pDefinirEmpresa(ACodEmp: string = '');
begin
  if not fEmptyStr(ACodEmp) then
  begin
    pSetaEmpresaLogada(ACodEmp);
    Exit;
  end;
  if fEmptyStr(GetParamValue('-e')) Then
    Raise Exception.Create('Nao foi informado o codigo da empresa "-e"!');
  pSetaEmpresaLogada(GetParamValue('-e'));
end;

procedure pDefinirUsuario;
begin
  strLoginUsuarioLogado := LOG_ADM;
  If (Not fEmptyStr(fCampoTabela('OPE_NOMOPE', 'CADOPE', ['OPE_CODOPE'],
    [fCfgSis('OPEAUT')]))) Then
    strLoginUsuarioLogado := fCfgSis('OPEAUT');
  strEmpAcessoUsuarioLogado := fRetEmpAcessoUsuario(strLoginUsuarioLogado);
end;

procedure pIniciarVariaveis;
begin
  VS_strHabilitarCRM := ((ReadIniFile('GERAL', 'CRM', '', GetIniFile) = 'S') And
    (fCfgSis('UTICRM', varBoolean)));

  VS_strCliFil := fRetClientesFilial;
  VS_strUsaTmq := fCfgSis('USATMQ');
  VS_strTipExp := fCfgSis('TIPEXP', varString);
  VS_strTRADES := fCfgSis('TRADES', varString);
  VS_strTabPrc := fCfgSis('TABPRC');
  VS_strTabVen := fCfgSis('TABVEN');
  VS_strTabFat := fCfgSis('TABFAT');
  VS_strCfoIPI := fTransform(fCfgSis('CFOIPI'), 4);
  VS_strClaCom := fTransform(fCfgSis('CLACOM'), 4);
  VS_strClaVen := fTransform(fCfgSis('CLAVEN'), 4);
  VS_strClaDev := fTransform(fCfgSis('CLADEV'), 4);
  VS_strClaDVC := fTransform(fCfgSis('CLADVC'), 4);
  VS_strClaNfo := fTransform(fCfgSis('CLANFO'), 4);
  VS_strClaNOE := fTransform(fCfgSis('CLANOE'), 4);
  VS_strCla_UC := fCfgSis('CLA_UC');
  VS_strClaRGF := fTransform(fCfgSis('CLARGF'), 4);
  VS_strClaRGR := fTransform(fCfgSis('CLARGR'), 4);
  VS_strNaoCab := fTransform(fCfgSis('NAOCAB'), 2);
  VS_strClaGir := fTransform(fCfgSis('CLAGIR'), 4);
  VS_strEspGir := fTransform(fCfgSis('ESPGIR'), 2);
  VS_strCliFil := fRetClientesFilial;
  VS_strCreCGC := fTransform(fCfgSis('CRECGC'), 3);
  VS_intConEst := fCfgSis('CONEST', varInteger);
  VS_intConAcu := fCfgSis('CONACU', varInteger);
  VS_strZfmCst := fTransform(fCfgSis('ZFMCST'), 1);
  VS_strTxjCni := ReadIniFile('GERAL', 'TXJCNI', '', GetIniFile);

  {*****************************************}
  {* VS_strEmpPrd: ESSA CONFIGURAÇÃO DEVE  *}
  {* SER MANTIDA EM VARIÁVEL.              *}
  {**************************************MV*}
  VS_strEmpPrd := fCfgSis('EMPPRD');
  If fEmptyStr(VS_strEmpPrd) Then
    If Not fCfgSis('OPRFLJ', varBoolean) Then
      VS_strEmpPrd := VS_strCodEmp;

  If Length(VS_strTabPrc) < 7 Then
    VS_strTabPrc := VS_strTabPrc + StringOfChar('N',7-Length(VS_strTabPrc));

  If Length(VS_strTabVen) < 7 Then
    VS_strTabVen := VS_strTabVen + StringOfChar('N',7-Length(VS_strTabVen));

  If Length(VS_strTabFat) < 7 Then
    VS_strTabFat := VS_strTabFat + StringOfChar('N',7-Length(VS_strTabFat));

  VS_intOPCROM := fCfgSis('OPCROM', varInteger); 

  fTamCodIte;
  fTamDocCadRec;
  fRetPrecisaoMargemItem;
end;

procedure pAtuTabPrc;
begin
  VS_strTabPrc     := fCfgSis('TABPRC');
  If Length(VS_strTabPrc) < 7 Then
    VS_strTabPrc := VS_strTabPrc + StringOfChar('N',7-Length(VS_strTabPrc));
end;

function GetIniFile(): String;
begin
  Result := TPath.Combine(GetCurrentDir, 'opcoes.ini');
  Result := ReadIniFile('GERAL', 'CONF_BD', Result, Result);
end;

function ReadIniFile(ASection, AIdenty, ADefault, AFile: String): String;
var
  LFile: TIniFile;
begin
  LFile := TIniFile.Create(AFile, TEncoding.ANSI);
  Try
    Result := LFile.ReadString(ASection, AIdenty, ADefault);
  Finally
    LFile.Free;
  End;
end;

function WriteIniFile(ASection, AIdenty, ADefault, AFile: String): String;
var
  LFile: TIniFile;
begin
  LFile := TIniFile.Create(AFile, TEncoding.ANSI);
  Try
    LFile.WriteString(ASection, AIdenty, ADefault);
    Result := LFile.ReadString(ASection, AIdenty, ADefault);
  Finally
    LFile.Free;
  End;
end;

function fRetEmpresaMatrizDoGrupo(strCodEmp: String): String;
Var
  LQuery: IQuery;
begin
  Result := '';

  If strCodEmp.IsEmpty Then
    Exit;

  LQuery := objConnectionsManager.CurrentConnection.CreateQuery;

  LQuery.SQL.Text := 'SELECT EMP_CODMAT FROM CADEMP WHERE EMP_CODEMP = ' +
    strCodEmp.QuotedString;

  LQuery.Open;

  Result := LQuery.FieldByName('EMP_CODMAT').AsString;
end;

function fUsaRotinaExpedicaoConferenciaRetiraCaixa(): Boolean;
begin
  If Not fCfgSis('LOCRET', varBoolean) Then
    Exit(False);

  If Not fCfgSis('EXRETC', varBoolean) Then
    Exit(False);

  If VS_strTipExp <> '4' Then
    Exit(False);

  Result := True;
end;

function fUsaQtdPendenteEntregaFutura(blnConsiderarCfgCalSal: Boolean = True; strEmpSalRes : String = ''): Boolean;
begin
  {*********************************************************************}
  {* AO MUDAR AS CONDIÇÕES QUE DEIXA ESSA FUNÇÃO TRUE ADEQUAR A FUNÇÃO *}
  {* fRetSQLBaseadoNaCfgEmpOri EM untFatMostraEstoqueEmp               *}
  {******************************************************************VA*}
  Result := fCfgSis('ENTFUT', varBoolean, strEmpSalRes) And (Not fCfgSis('BEFTRG', VarBoolean));
  If blnConsiderarCfgCalSal Then
    Result := Result And MatchStr(fCfgSis('CALSAL'), ['1', '3', '4', '5']);
end;

function fReservaSaldoPedidosBaixaEntregaFutura: Boolean;
begin
  Result := (Not fUsaRotinaWMS()) And (Not fCfgSis('BEFTRG', varBoolean)) And (fCfgSis('CALSAL') <> 2);

  Result := Result And fCfgSis('UTIEFU', varBoolean);//A REMOVER
end;

function fUsaImpostoFonteIBPT: Boolean;
Begin
  Result := fCfgSis('IMPPAG', VarInteger) = 2;
End;

function fUsaRotinaWMS(strCodEmp: String = ''): Boolean;
begin
  If strCodEmp.IsEmpty Then
    strCodEmp := VS_strCodEmp;

  Result := (fCfgSis('UTIWMS', varString, strCodEmp) = 'S') And
  // Utilizar WMS ( Sistema de Gerênciamento de Armazém ) = SIM.
    (fCfgSis('CTLEST', varString, strCodEmp) = '1') And
  // Tipo de controle de sub-estoque na mesma loja = POR LOTE.
    (fCfgSis('CADLOC', varString, strCodEmp) = 'S') And
  // Utilizar cadastro de localizações físicas? = SIM.
    (fCfgSis('CONFME', varString, strCodEmp) = '1') And
  // Realizar Conferência para Entrada de Mercadorias através: = PRE-NOTA.
    (fCfgSis('USACON', varString, strCodEmp) = 'S') And
  // Utilizar Conferência para Entrada de Mercadorias? = SIM.
    ((fCfgSis('TIPEXP', varString, strCodEmp) = '3') Or
    // Expedição = FATURAMENTO DEPOIS DA EXPEDICAO OU
    (fCfgSis('TIPEXP', varString, strCodEmp) = '4') Or
    // PEDIDO NÃO SERÁ FATURADO
    (fCfgSis('TIPEXP', varString, strCodEmp) = '5')); // PRÉ-ROMANEIO

end;

function fUsaOndaSeparacaoAgrupamento(): Boolean;
begin

  Result := False;

  If Not fCfgSis('ONDAGR', varBoolean) Then
    Exit;

  Result := True;

end;

function fSolicitaDigDuplicAdiantamentoPedido: Boolean;
begin
  Result := False;

  If Not fCfgSis('DUPORP', varBoolean) Then
    Exit;

  If Not fCfgSis('DUPADT', varBoolean) Then
    Exit;

  Result := True;
end;

function fEhAdministrador(strCodOpe: String): Boolean;
Begin
  Result := SameText('999', strCodOpe) Or
            SameText('998', strCodOpe) Or
            SameText('997', strCodOpe);
End;

function fConfiguracaoExiste(strCodCfg: string; strCodEmp: string = ''): boolean;
begin
  if fEmptyStr(strCodEmp) then
    strCodEmp := VS_strCodEmp;

  Result := (fCampoTabela('COUNT(*)', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_' + strCodCfg, strCodEmp], False) > 0);
end;

function fCfgSis(strCamCfg: String; varTipVar: TVarType;
  strCodEmp: String): Variant;
Begin
  If SameText('EMPMAT', strCamCfg) Then
  Begin
    Result := '';

    If fCfgSisL('INFMAT', varBoolean) Then
      Result := fRetEmpresaMatrizDoGrupo(VS_strCodEmp);

    If String(Result).IsEmpty Then
      Result := fCfgSisL(strCamCfg, varTipVar, strCodEmp, dicConfiguracoes);

  End

  Else If Pos(strCamCfg,
    'CFG_ATPVMB-CFG_ATPVM2-CFG_ATPVM3-CFG_ATPVM4-CFG_ATPVM5-CFG_ATPVM6-CFG_ATPVM7-CFG_VENMAR')
    > 0 Then
  Begin

    If fCfgSisL('BLOPRE', varBoolean, strCodEmp, dicConfiguracoes) Then
    begin

      If Pos(strCamCfg,
        'CFG_ATPVMB-CFG_ATPVM2-CFG_ATPVM3-CFG_ATPVM4-CFG_ATPVM5-CFG_ATPVM6-CFG_ATPVM7')
        > 0 Then
        Result := 'M'
      Else
        Result := 2;

    End
    Else
    Begin

      Result := fCfgSisL(strCamCfg, varTipVar, strCodEmp, dicConfiguracoes);

    End;

  End
  Else
  Begin
    Result := fCfgSisL(strCamCfg, varTipVar, strCodEmp, dicConfiguracoes);
  End;
end;

function fCfgSisL(strCamCfg: String; varTipVar: TVarType = varString;
  strCodEmp: String = ''; dicCfgSis: TDictionary<String, String> = Nil)
  : Variant;
Var
  qryGenCfg: IQuery;
  strValCfg: String;
  strSQL: String;
  strAux: String;
  varValue: Variant;
  strCodEmpCfg: String;

  procedure pSetaEmpresaCfg;
  begin
    strCodEmpCfg := '';

    If (Not fEmptyStr(strCodEmp)) Then
    Begin
      strCodEmpCfg := strCodEmp;
    End
    Else
    Begin
      //CFGARR...

      If (Not fEmptyStr(VS_EmpCfgSisDes)) Then
      Begin
        If (AnsiMatchStr(strCamCfg, VS_ArrCfgSisDes)) Then
          strCodEmpCfg := VS_EmpCfgSisDes;
      End

     //...CFGARR
    End;

    If fEmptyStr(strCodEmpCfg) Then
      strCodEmpCfg := VS_strCodEmp;
  End;

begin
  pSetaEmpresaCfg;
  Try
    qryGenCfg := Nil;

    If Not strCamCfg.IsEmpty Then
    Begin
      If strCodEmpCfg.IsEmpty Then
        strCodEmpCfg := VS_strCodEmp;

      varValue := Null;
      If Assigned(dicCfgSis) Then
      Begin
        FMREW.BeginRead;
        Try
          If dicCfgSis.ContainsKey(strCamCfg + strCodEmpCfg) Then
            varValue := dicCfgSis[strCamCfg + strCodEmpCfg];
        Finally
          FMREW.EndRead;
        End;
      End;

      if VarIsNull(varValue) Then
      Begin
        qryGenCfg := objConnectionsManager.CurrentConnection.CreateQuery();

        strSQL := '';
        strSQL := strSQL + ' SELECT  SQL_NO_CACHE       ';
        strSQL := strSQL + '   SIS_CODCFG,              ';
        strSQL := strSQL + '   SIS_VALCFG              ';
        strSQL := strSQL + ' FROM                       ';
        strSQL := strSQL + '   CFGSIS                   ';
        strSQL := strSQL + ' WHERE                      ';
        strSQL := strSQL + '   SIS_CODEMP = :CODEMP AND ';
        strSQL := strSQL + '   SIS_CODCFG = :CODCFG     ';

        With qryGenCfg Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);

          ParamByName('CODEMP').Value := strCodEmpCfg;
          ParamByName('CODCFG').Value := 'CFG_' + strCamCfg;
          Open;

          If IsEmpty Then
            If (Not Assigned(fCriarConfiguracoes)) Or
               (not fCriarConfiguracoes('CFG_' + strCamCfg, strCodEmpCfg)) Then
              Raise Exception.Create('A configuração ( ' + 'CFG_' + strCamCfg + ' ) não existe na empresa ' + strCodEmpCfg + '.');

          If IsEmpty Then
          Begin
            Close;
            Open;
          End;

          { ********************************************************** }
          { * VALIDAÇÃO PARA TESTAR SE JÁ É UMA CHAVE CRIPTROGRAFADA * }
          { ********************************************************VA }
          varValue := FieldByName('SIS_VALCFG').AsString;
          If Pos(FieldByName('SIS_CODCFG').AsString, consChavesCript) > 0 Then
          Begin
            strAux := fDecrypt(varValue);
            If fCrypt(strAux) = varValue Then
              varValue := fDecrypt(varValue)
          End;
        End;
      End;

      If Assigned(dicCfgSis) Then
      Begin
        FMREW.BeginWrite;
        try
          dicCfgSis.AddOrSetValue(strCamCfg + strCodEmpCfg, varValue);
        finally
          FMREW.EndWrite;
        end;
      End;

      strValCfg := varValue;

      Case varTipVar Of
        varString:
          Result := strValCfg;

        varInteger, varSmallint, varSingle, varByte, varShortInt, varInt64:
          Begin
            Try
              If strValCfg.IsEmpty Then
                Result := 0
              Else
                Result := strToInt(strValCfg);
            Except
              Result := 0;
            End;
          End;

        varDouble, varCurrency:
          Begin
            Try
              If strValCfg.IsEmpty Then
                Result := 0.00
              Else
                Result := fStrToFloat(AnsiReplaceStr(strValCfg, '.', ','));
            Except
              Result := 0.00;
            End;
          End;

        varDate:
          Begin
            Try
              If strValCfg.IsEmpty Then
                Result := 0
              Else
                Result := strToDate(strValCfg);
            Except
              Result := 0;
            End;
          End;

        varBoolean:
          Begin
            Try
              If strValCfg.IsEmpty Then
                Result := False
              Else If Pos(strValCfg, 'S_N_') > 0 Then
                Result := StrToBool(IfThen(strValCfg = 'S', 'True', 'False'))

              Else If Pos(strValCfg, '0_1_') > 0 Then
                Result := StrToBool(IfThen(strValCfg = '1', 'True', 'False'))
              Else
                Result := (Length(strValCfg) > 0) And
                  CharInSet(strValCfg[1], ['T', 't', 'Y', 'y']);

            Except
              Result := False;
            End;

          End;

      Else
        Result := strValCfg;

      End;

    End;

  Finally

  End;

end;

function fCfgSisExist(strCamCfg: String; strCodEmp: String): Boolean;
var
  LstrRetorno: String ;
begin
  LstrRetorno := fCampoTabela('SIS_CODCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_'+strCamCfg, strCodEmp]) ;
  Result := not fEmptyStr(LstrRetorno) ;
end;

function fAtuCfgSis(strCamCfg: String; strValCfg: String;
  strCodEmp: String = ''): Boolean;
Var
  qryGenCfg: IQuery;
begin
  Try
    Result := True;

    If fEmptyStr(strCodEmp) Then
      strCodEmp := VS_strCodEmp;

    If Not fEmptyStr(strCamCfg) Then
    Begin
      qryGenCfg := objConnectionsManager.CurrentConnection.CreateQuery();

      With qryGenCfg Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('UPDATE                     ');
        SQL.Add('  CFGSIS                   ');
        SQL.Add('SET                        ');
        SQL.Add('  SIS_VALCFG = :VALCFG     ');
        SQL.Add('WHERE                      ');
        SQL.Add('  SIS_CODEMP = :CODEMP AND ');
        SQL.Add('  SIS_CODCFG = :CODCFG     ');

        Try
          ParamByName('CODEMP').Value := strCodEmp;
          ParamByName('CODCFG').Value := 'CFG_' + strCamCfg;
          ParamByName('VALCFG').Value := strValCfg;

          ExecSQL;
        Except
          On E: Exception Do
          Begin
            Raise Exception.Create
              ('Não consegui atualizar o proximo sequencial de ' + strCamCfg +
              ' em CFGSIS. Tente novamente!');
          End;
        End;

      End;

    End;

  Finally

  End;

end;

procedure pCriarCfgSis(strCodCfg: String; strDesCfg: String; strGruCfg: String; strValCfg: String);
Var
  qryGen: IQuery;
  strSQL   : String;
Begin
  Try
    strSQL := '';
    strSQL := strSQL + ' SELECT  *                  ';
    strSQL := strSQL + ' FROM                       ';
    strSQL := strSQL + '   CFGSIS                   ';
    strSQL := strSQL + ' WHERE                      ';
    strSQL := strSQL + '   SIS_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '   SIS_CODCFG = :CODCFG     ';

    qryGen := fCriaQuery;
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryGen.ParamByName('CODCFG').AsString := strCodCfg;
    qryGen.Open;

    If qryGen.IsEmpty Then
    Begin
      qryGen.Append;
      qryGen.FieldByName('SIS_CODEMP').AsString := VS_strCodEmp;
      qryGen.FieldByName('SIS_CODCFG').AsString := strCodCfg;
      qryGen.FieldByName('SIS_DESCRI').AsString := strDesCfg;
      qryGen.FieldByName('SIS_VALCFG').AsString := strValCfg;
      qryGen.FieldByName('SIS_GRUCFG').AsString := strGruCfg;
      qryGen.FieldByName('SIS_NUMHLP').AsString := '0';
      qryGen.Post;
    End;

  Finally

  End;
End;

{ TPermissoesAcesso }

constructor TPermissoesAcesso.Create;
begin
  FUsuarios := TDictionary<String, TObject>.Create;
end;

destructor TPermissoesAcesso.Destroy;
begin
  FUsuarios.Clear;
  FUsuarios.Destroy;
  inherited;
end;

function TPermissoesAcesso.fCarregarAcessosUsuario(strCodOpe: String): TStringList;
  Var
    strSQL: String;
    qryGen: IQuery;
begin
  Result := TStringList.Create;
  Result.Sorted := True;
  Result.Duplicates := dupIgnore;

  qryGen := fCriaQuery;

  With qryGen Do
  Begin
    //Carrega direitos de acesso do operador
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  DIR_NOMFRM ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '   DIROPE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '   OPE_CODOPE = :CODOPE ';

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODOPE').AsString := strCodOpe;
    Open;

    First;

    While Not Eof Do
    Begin
      Result.Add(FieldByName('DIR_NOMFRM').AsString);
      Next;
    End;

    //Carrega direitos de acesso do grupo do operador
    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   D.DIR_NOMFRM  ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   DIRGPO D ';
    strSQL := strSQL + '   JOIN CADGPO G ON G.GPO_CODGPO = D.GPO_CODGPO ';
    strSQL := strSQL + '   JOIN OPEGPO O ON O.GPO_CODGPO = G.GPO_CODGPO ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   O.OPE_CODOPE = :CODOPE ';

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODOPE').AsString := strCodOpe;
    Open;

    First;

    While Not Eof Do
    Begin
      Result.Add(FieldByName('DIR_NOMFRM').AsString);
      Next;
    End;
  End;
end;

function TPermissoesAcesso.fVerificaAcesso(strNomeForm, strCodOpe: String): Boolean;
  Var
    objAcessos: TObject;
begin
  if not FUsuarios.TryGetValue(strCodOpe, objAcessos) then
  Begin
    objAcessos := fCarregarAcessosUsuario(strCodOpe);
    FUsuarios.Add(strCodOpe, objAcessos);
  End;
  Result := TStringList(objAcessos).IndexOf(strNomeForm) >= 0;
end;

class function TPermissoesAcesso.GetInstance: TPermissoesAcesso;
begin
  If FInstance = nil Then
    FInstance := TPermissoesAcesso.Create;
  Result := FInstance;
end;

procedure TPermissoesAcesso.pLimpar;
begin
  FUsuarios.Clear;
end;

function fPermiteEmissaoEspecie(strEspecie: String; strCodEmp: String = ''): Boolean;
Const
    ESPECIES_PERMISSIVEIS : String = 'FF_MI_TR_DV_TE_BR_UC_EP_';
Var
  strValCfg: String;
begin
  If fEmptyStr(strEspecie) Then
    Exit(True);

  If (Not ESPECIES_PERMISSIVEIS.Contains(strEspecie)) Then
    Exit(True);

  strValCfg := fCampoTabela('SIS_VALCFG', 'CFGSIS',
                           ['SIS_CODCFG', 'SIS_CODEMP'],
                           ['CFG_PREM' + strEspecie,
                            IIF(Not fEmptyStr(strCodEmp), strCodEmp, VS_strCodEmp)],
                            False);

  If (Not strValCfg.IsEmpty) Then
    Exit(strValCfg = 'S')
  Else
    Result := True;
end;

function fVerificaAcessoSistema(strNomeForm: String; strCodOpe: String = ''): Boolean;
  Var
    strOperador: String;
Begin
  If (Not fEmptyStr(strCodOpe)) Then
    strOperador := strCodOpe
  Else
    strOperador := strLoginUsuarioLogado;

  If (strNomeForm = 'frmLogoff') Or (strNomeForm = 'frmSobre') Then
    Exit(True);

  If fEhAdministrador(strOperador) Then
    Exit(True);

  Result := TPermissoesAcesso.GetInstance.fVerificaAcesso(strNomeForm, strOperador);

  Result := Result Or fEmptyStr(strNomeForm);
End;

procedure pEsvaziaArrayCfgDes;
begin
  VS_ArrCfgSisDes := [];
  VS_EmpCfgSisDes := '';
end;

function fCfgExpedicaoParcialHabilitada: Boolean;
begin
  Result := Pos(fCfgSis('EXPPAR', varString), '_S_P') > 0;
end;

function VS_strCodEmp(): String;
begin
  if not fEmptyStr(FEmpresaCalculandoImpostos) then
    Result := FEmpresaCalculandoImpostos
  else
    Result := FEmpresaLogada;
end;

procedure pSetaEmpresaCalculandoImpostos(AValue: string);
begin
  FEmpresaCalculandoImpostos := AValue;
end;

procedure pSetaEmpresaLogada(AValue: string);
begin
  FEmpresaLogada := AValue;
end;

initialization

fCriarConfiguracoes := nil;

VS_intTamPrecoIteger := 0;
VS_intTamPrecoItepro := 0;

strListIdGerEle := TStringList.Create;

FMREW := TMultiReadExclusiveWriteSynchronizer.Create;
dicConfiguracoes := TDictionary<String, String>.Create;

finalization

FMREW.Free;
dicConfiguracoes.Free;

FreeAndNil(strListIdGerEle);
TPermissoesAcesso.GetInstance.Destroy;

end.
