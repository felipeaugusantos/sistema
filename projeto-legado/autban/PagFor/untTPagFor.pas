{******************************************************************}
{* PARA ADICIONAR UM NOVO BANCO, VERIFICA AS FUNCÇÕES ESPECÍFICAS *}
{***************************************************************AJ*}
unit untTPagFor;

interface
{$WARN UNIT_PLATFORM OFF}

Uses Classes, untFuncoesSimples, Uni, System.SysUtils, StrUtils, Windows, Forms,
     untFuncAutban, untFuncoesBoleto, untFuncoes, untLogCtp, Variants,
     UniClientDataSet, frxClass, FileCtrl, DateUtils, untCfgRel, Data.DB,
     untTiposPagFor, System.Generics.Collections, untGravando, untTRegPGI;

Type
  TPagFor = class

  private
    FstrCodBco,
    FstrNomBco,
    FstrConfig: String;

    FlstArquiv: TStringList;
    FcdsNaoGra: TuniClientDataSet;
    strNumDup : String;

    qryRetCTP,
    qryConsultaGen: TUniQuery;

    strSQL,
    strNomEmp,
    strDtaRem,
    strHorRem,
    strDtaVen,
    strDtaEmi,
    strCgcEmp,
    strCgcFor,
    strCodAge,
    strDigAge,
    strConCor,
    strDigCnt,
    strCodCar,
    strDigCar,
    strEndEmp,
    strNumEmp,
    strComEmp,
    strCidEmp,
    strCepEmp,
    strEstEmp,
    strDtaPag,
    strAutInc,
    strAvisoTED,
    strCodCon,
    LCompromisso,
    LTransmissao,
    LOperacaoConta,

    strHeader ,
    strHeaderLot,
    strTransacao,
    strTraillerLot,
    strTrailler    : String;

    intTipIns,
    intTipInsFor,
    intCodSeq1,
    intCodSeqGer,
    intTotLot      : Integer;
    fltValPag1     : Double;
    txtTexto       : TextFile;
    strNovCodEmp,
    strCodRem      : String;
    blnRemLoc      : Boolean;
    qryRemessa     : TUniQuery;

    lstArqNaoGravados: TStringList;

    intIndLot      : Integer;

    strFilePath : String;

    FListaRequisicoesAPI: TList<TRequisicaoRegistroAPI>;

    procedure pApagaRetCTP(strCodBco: String; ABancoAPI: Boolean);

    function fRetEmpresa: String;
    function fEhPagamentoSalarial: Boolean;

    {***************************************}
    {* FUNÇÕES ESPECÍFICAS PARA CADA BANCO *}
    {************************************AJ*}
    function fRetLayoutHeader: String;
    function fRetLayoutHeaderLoteO: String;
    function fRetLayoutHeaderLote1: String;
    function fDigitoVerificadordaConta: String;
    function fDigitoVerificadordaAgConta: String;
    function InscricaoDoFavorecido: String;
    function fGetZeroOuBranco: String;
    function fGetConvenio(ALote: Boolean = False): String;
    function fGetSeqRemessa: String;
    function fGetVersaoLayoutHeaderArquivo: String;
    function fGetDensidadeGravacao:String;
    function fGet223a224: String;
    function fGetTipoPagamento: String;
    function fGetFormaPagamento: String;
    function fGetTipoPagamentoConcessionaria: String;
    function fGetFormaPagamentoConcessionária: String;
    function fGetTipoServico: String;
    function fRetDadosAdicionais(intTam: Integer): String;
    function fRetTipAvalista: String;
    function fRetCgcAvalista: String;
    function fRetNomAvalista: String;
    function fGetContaCorrente:String;

    procedure pGravaLogCtp(strCodBco, strAutoIncrem : String);

    {******************************}
    {* IMPORTAÇÃO ARQUIVO RETORNO *}
    {***************************AJ*}
    procedure pMostraDupNaoBaixa(lstArqNaoGravados: TStringList; blnImpDes: Boolean = True);
    procedure pMostraArqNaoBaixa(strNomBan: String);

    {**********************}
    {* GERAÇÃO DO ARQUIVO *}
    {*******************AJ*}
    procedure pHeaderArquivo;

    procedure pHeaderLote(blnBanDif: Boolean);
    procedure pSegmentoJ;
    procedure pTrailerLote;

    procedure pHeaderLoteON(ATipoPagamento, AFormaPagamento: String; AConcessionaria: Boolean);
    procedure pSegmentoO;
    procedure pSegmentoW;

    procedure pHeaderLoteABC(blnBancoDiferente: Boolean; APagamentoSalarial : Boolean = False);
    procedure pSegmentoA(blnBancoDiferente : Boolean);
    procedure pSegmentoD;
    procedure pSegmentoB;

    procedure pTrailerArquivo;
    function fRetCodMovRemDetJ: String;
    function fRetLayoutLoteABC: String;
  public
    frxReportJ,
    frxReportM: TfrxReport;

    constructor Create;

    function fImportaPagFor(lstArquiv: TStringList; strCodBco, strNomBco: String;
                            var cdsNaoGra: TUniClientDataSet;  strConfig: String = ''): Boolean;
    function fExportaPagFor(lstArquiv: TStringList; strCodBco, strNomBco, strConfig: String): Boolean;

    function RetornaSQLExportacao(ACodigoBanco : String = ''; ATipoRegistro : String = ''): String;
    function RetornaSQLExportacaoDeposito(ACodigoBanco : String = ''; ATipoRegistro : String = ''): String;

    procedure pImportaPagForFebraban;
    procedure pExportaPagForFebraban;

    procedure pApagaCadPgi(strCodBco: String; ATipoRegistro : String = '');

    procedure GravaLogCtpDuplicatas(AListaDuplicatas: TStringList;
                                    ADescricao,
                                    ANomeFormulario: String);

    function ValidarPagamentosAPI(ACodigoBanco: String;
                                  AListaDuplicatas: TList<TPagForRetorno>;
                                  var cdsNaoGra: TUniClientDataSet;
                                  AGravando: TfrmGravando): Boolean;

    procedure GravaRegistrosRegPGI;

    class function EnviaDuplicatasRemessaAPI(ACodigoBanco,
                                             ACarteira: String): Boolean;

    class function RetornaObjetoAPI(ACodigoBanco,
                                    ACarteira: String): TObject;

    property ListaRequisicoesAPI: TList<TRequisicaoRegistroAPI> read FListaRequisicoesAPI write FListaRequisicoesAPI;
End;

implementation
Uses untModuloRetCtp, untArqNaoGravados, untTPagForBancoDoBrasilAPI;

{ TPagFor }

constructor TPagFor.Create;
begin
  lstArqNaoGravados := TStringList.Create;
end;

class function TPagFor.EnviaDuplicatasRemessaAPI(ACodigoBanco,
  ACarteira: String): Boolean;
  Var
    LPagForBanco: TObject;

    LGravando: TfrmGravando;
begin
  Result := False;

  LPagForBanco := TObject.Create;

  pCriarFormularios(TfrmGravando, LGravando);
  Try
    If ACodigoBanco = '001' Then
    Begin
      LPagForBanco := TPagForBancoDoBrasilAPI.Create(ACarteira) As TPagForBancoDoBrasilAPI;

      LGravando.fExecutarAcao := TPagForBancoDoBrasilAPI(LPagForBanco).ExportaRemessaAoBanco;
      LGravando.ShowModal;

      Result := LGravando.blnConfirma;
    End;
  Finally
    FreeAndNil(LGravando);
    FreeAndNil(LPagForBanco);
  End;
end;

function TPagFor.fDigitoVerificadordaAgConta: String;
begin
  Case StrToInt(FstrCodBco) Of
    1  : Result := '0';
    104: Result := ' ';
    341: Result := strDigCnt;
    748: Result := ' ';
  End;
end;

function TPagFor.fRetCodMovRemDetJ: String;
begin
  Case StrToInt(FstrCodBco) Of
    1  : Result := '00';
    104: Result := '  ';
    341: Result := '00';
    748: Result := '01';
  End;
end;

function TPagFor.fRetLayoutLoteABC: String;
begin
  Case StrToInt(FstrCodBco) Of
    1  : Result := '043';
    104: Result := '043';
    341: Result := '040';
    748: Result := '042';
  End;
end;

function TPagFor.fDigitoVerificadordaConta: String;
begin
  Case StrToInt(FstrCodBco) Of
    1  : Result := strDigCnt;
    104: Result := strDigCnt;
    341: Result := ' ';
    748: Result := strDigCnt;
  End;
end;

function TPagFor.fRetDadosAdicionais(intTam: Integer): String;
begin
  Case StrToInt(FstrCodBco) Of
    1  : Result := fPadL('', intTam, '0');
    104: Result := fPadL('', intTam, ' ');
    341: Result := fPadL('', intTam, ' ');
    748: Result := fPadL('', intTam, ' ');
  End;
end;

function TPagFor.fRetTipAvalista: String;
begin
  Case StrToInt(FstrCodBco) Of
    1  : Result := '0';
    104: Result := IntToStr(intTipIns);
    341: Result := IntToStr(intTipIns);
    748: Result := IntToStr(intTipIns);
  End;
end;

procedure TPagFor.GravaLogCtpDuplicatas(AListaDuplicatas: TStringList;
  ADescricao, ANomeFormulario: String);
  Var
    LAutoIncrem: String;
begin
  fStartTransaction;
  Try
    For LAutoIncrem In AListaDuplicatas Do
      untLogCtp.GravaLogCtp(LAutoIncrem,
                            ADescricao,
                            ANomeFormulario);

    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;

      Exception.Create('Ocorreu um erro ao gravar o Log do Contas a Pagar, mas as duplicatas foram enviadas ao banco.' + #13 +
                       'Erro gerado: ' + E.Message);
    End;
  End;
end;

procedure TPagFor.GravaRegistrosRegPGI;
  Var
    LRequisicao: TRequisicaoRegistroAPI;

    LContador: Integer;
begin
  If Not Assigned(FListaRequisicoesAPI) Then
    Exit;

  If FListaRequisicoesAPI.Count = 0 Then
    Exit;

  Try
    Try
      LContador := 0;

      For LRequisicao In FListaRequisicoesAPI Do
      Begin
        If Not fInTransaction Then
          fStartTransaction;

        TRegPGI.GravarRequisicaoReqistroAPI(LRequisicao);

        Inc(LContador);

        If LContador >= 30 Then
        Begin
          LContador := 0;

          fCommit;
        End;
      End;

      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;

        pMensagensErro('Ocorreu um erro ao gravar o log das requisições. ' + #13 +
                       'Erro gerado: ' + E.Message, '[TPagFor.GravaRegistrosRegPGI]');
      End;
    End;
  Finally
    FreeAndNil(FListaRequisicoesAPI);
  End;
end;

function TPagFor.InscricaoDoFavorecido: String;
begin
  Case StrToInt(FstrCodBco) Of
    1  : Result := ' ';
    104: Result := ' ';
    341: Result := fPadL(qryRemessa.FieldByName('NUMINS').AsString, 14, '0');
    748: Result := fPadL(qryRemessa.FieldByName('NUMINS').AsString, 14, '0');
  End;
end;

function TPagFor.fRetCgcAvalista: String;
begin
  Case StrToInt(FstrCodBco) Of
    1  : Result := '';
    104: Result := '0' + strCgcEmp;
    341: Result := '0' + strCgcEmp;
    748: Result := '0' + strCgcEmp;
  End;
end;

function TPagFor.fRetNomAvalista: String;
begin
  Case StrToInt(FstrCodBco) Of
    1  : Result := '';
    104: Result := fTiraCaracEspeciais(strNomEmp);
    341: Result := strNomEmp;
    748: Result := fTiraCaracEspeciais(strNomEmp);
  End;
end;

function TPagFor.fEhPagamentoSalarial: Boolean;
begin
  Result := (Not fEmptyStr(qryRemessa.FieldByName('CODFUN').AsString));
end;

function TPagFor.fExportaPagFor(lstArquiv: TStringList;
  strCodBco, strNomBco, strConfig: String): Boolean;
begin
  Result := False;

  If (fEmptyStr(strCodBco)) Or (lstArquiv.Count <= 0) Then
    Exit;

  If fMensagem('','Deseja gerar o arquivo de remessa do Contas a Pagar?',['&Sim','&Não']) = 2 Then
    Exit;

  FlstArquiv := lstArquiv;
  FstrCodBco := strCodBco;
  FstrNomBco := strNomBco;
  FstrConfig := strConfig;

  If strCodBco = '001' Then
    TfrmGravando.fExecutarModal(pExportaPagForFebraban, 'Aguarde... Exportado arquivo Contas a Pagar (BB).', '')
  Else If strCodBco = '104' Then
    TfrmGravando.fExecutarModal(pExportaPagForFebraban, 'Aguarde... Exportado arquivo Contas a Pagar (Caixa Federal).', '')
  Else If strCodBco = '341' Then
    TfrmGravando.fExecutarModal(pExportaPagForFebraban, 'Aguarde... Exportado arquivo Contas a Pagar (Itaú).', '')
  Else If strCodBco = '748' Then
    TfrmGravando.fExecutarModal(pExportaPagForFebraban, 'Aguarde... Exportado arquivo Contas a Pagar (Sicredi).', '');


  Result := True;
end;

function TPagFor.fGet223a224: String;
begin
  Case StrToInt(FstrCodBco) Of
    1  : Result := '  ';
    104: Result := '01';
    341: Result := '  ';
    748: Result := '  ';
  End;
end;

function TPagFor.fGetContaCorrente: String;
begin
  Case StrToInt(FstrCodBco) Of
    1  : Result := strConCor;
    104:Begin
          If (Length(strConCor) <= 8) Then
          Begin
            Result := fPadL(LOperacaoConta, 004, '0') + // Operação conta
                      fPadL(strConCor     , 008, '0') ; // Conta corrente
          End
           Else
             Result := strConCor;
        End;
    341: Result := strConCor;
    748: Result := strConCor;
  End;
end;

function TPagFor.fGetConvenio(ALote: Boolean = False): String;
begin
  Case StrToInt(FstrCodBco) Of
    1  : Begin
           If (Length(strCodCon) <= 9) Then
           Begin
             Result := fPadL   (strCodCon , 009, '0') + //Convênio de pagamento, completando com zeros à esquerda
                       fPadR   ('0126'    , 004, '0') +
                       fPadR   (' '       , 005, ' ') +
                       fPadR   (' '       , 002, ' ') ;
           End
           Else
             Result := strCodCon;
         End;

    104: Begin
           If (Length(strCodCon) <= 6) And Not ALote Then
           Begin
             Result := fPadL   (strCodCon   , 006,'0') + // 33 - 38 Convênio de pagamento, completando com zeros à esquerda
                       fPadL   (LTransmissao, 002,'0') + // 39 - 40 CÓD. INFORMADO PELO BANCO
                       fPadL   ('P'         , 001)     + // 41 - 41 "T" = TESTE / "P"= PRODUÇÃO
                       fPadL   (' '         , 001)     + // 42 - 42 PREENCHER COM ESPAÇOS
                       fPadL   (' '         , 003,' ') + // 43 - 45 PREENCHER COM ESPAÇOS
                       fPadL   ('0'         , 004,'0');  // 46 - 49 NÚMERO DE VERSÃO
           End
           Else If (Length(strCodCon) <= 6) And ALote Then
           Begin
             Result := fPadL   (strCodCon   , 006,'0')+ // 033 - 038 Convênio de pagamento, completando com zeros à esquerda
                       fPadL   ('01'        , 002)    + // 39 - 40 PAGAMENTO A FORNECEDOR
                       fPadL   (LCompromisso, 004,'0')+ // 41 - 44 CÓDIGO DE COMPROMISSO
                       fPadL   (LTransmissao, 002,' ')+ // 45 - 46 PARÂMETRO DE TRANSMISSÃO
                       fPadL   (' '         , 006,' '); // 47 - 52 PREENCHER COM ESPAÇOS
           End
           Else
             Result := strCodCon;
         End;

    341: Result := strCodCon;
    748: Result := strCodCon;
  End;
end;

function TPagFor.fGetDensidadeGravacao: String;
begin
  Case StrToInt(FstrCodBco) Of
    1  : Result :='0';
    104: Result :='01600';
    341: Result :='0';
    748: Result :='01600';
  End;
end;

function TPagFor.fGetFormaPagamento: String;
begin
  Case StrToInt(FstrCodBco) Of
    1  : Result := '11';
    104: Result := '91';
    341: Result := '91';
    748: Result := '11';
  End;
end;

function TPagFor.fGetFormaPagamentoConcessionária: String;
begin
  Case StrToInt(FstrCodBco) Of
    1  : Result :='11';
    104: Result :='11';
    341: Result :='13';
    748: Result :='11';
  End;
end;

function TPagFor.fGetSeqRemessa: String;
begin
  Case StrToInt(FstrCodBco) Of
    1  : Result := strCodRem;
    104: Result := strCodRem;
    341: Result :='0';
    748: Result := strCodRem;
  End;
end;

function TPagFor.fGetTipoPagamento: String;
begin
  Case StrToInt(FstrCodBco) Of
    1  : Result :='98';
    104: Result :='22';
    341: Result :='22';
    748: Result :='22';
  End;
end;

function TPagFor.fGetTipoPagamentoConcessionaria: String;
begin
  Case StrToInt(FstrCodBco) Of
    1  : Result :='98';
    104: Result :='98';
    341: Result :='20';
    748: Result :='22';
  End;
end;

function TPagFor.fGetTipoServico: String;
begin
  Case StrToInt(FstrCodBco) Of
    1  : Result :='98';
    104: Result :='20';
    341: Result :='20';
    748: Result :='03';
  End;
end;

function TPagFor.fGetVersaoLayoutHeaderArquivo: String;
begin
  Case StrToInt(FstrCodBco) Of
    1  : Result :='0';
    104: Result :='080';
    341: Result :='0';
    748: Result :='082';
  End;
end;

function TPagFor.fGetZeroOuBranco: String;
begin
  Case StrToInt(FstrCodBco) Of
    1  : Result :='0';
    104: Result :=' ';
    341: Result :=' ';
    748: Result :=' ';
  End;
end;

function TPagFor.fImportaPagFor(lstArquiv: TStringList;
  strCodBco, strNomBco: String; var cdsNaoGra: TuniClientDataSet; strConfig: String = ''): Boolean;
begin
  Result := False;

  If (fEmptyStr(strCodBco)) Or (lstArquiv.Count <= 0) Then
    Exit;

  cdsNaoGra.CreateDataSet;
  cdsNaoGra.Open;
  cdsNaoGra.EmptyDataSet;

  FlstArquiv := lstArquiv;
  FstrCodBco := strCodBco;
  FstrNomBco := strNomBco;
  FcdsNaoGra := cdsNaoGra;
  FstrConfig := strConfig;

  Case StrToInt(strCodBco) Of
      1: TfrmGravando.fExecutarModal(pImportaPagForFebraban, 'Aguarde... Importando arquivos Contas a Pagar (BB).', '');
    341: TfrmGravando.fExecutarModal(pImportaPagForFebraban, 'Aguarde... Importando arquivos Contas a Pagar (Itaú).', '');
    748: TfrmGravando.fExecutarModal(pImportaPagForFebraban, 'Aguarde... Importando arquivos Contas a Pagar (Sicredi).', '');
    756: TfrmGravando.fExecutarModal(pImportaPagForFebraban, 'Aguarde... Importando arquivos Contas a Pagar (Sicoob).', '');
  End;

  Result := True;
end;

procedure TPagFor.pApagaCadPgi(strCodBco: String; ATipoRegistro : String = '');
  Var
    strSQL   : String;
    qryRelDel: TUniQuery;
begin
  strSQL := 'DELETE FROM CADPGI WHERE PGI_BCOPGG IS NULL AND PGI_CODBCO = "' + strCodBco + '"';
  if MatchStr(strCodBco, ['001']) then
  begin
    if not FEmptyStr(ATipoRegistro) then
    begin
      strSQL := strSQL + ' AND PGI_CARTEI = "' + ATipoRegistro + '"';
    end;
  end;

  qryRelDel := fCriaQuery(Nil);
  Try
    qryRelDel.SQL.tEXT := strSQL;
    qryRelDel.ExecSQL;
  Finally
    qryRelDel.Close;
    FreeAndNil(qryRelDel);
  End;
end;

procedure TPagFor.pApagaRetCTP(strCodBco: String; ABancoAPI: Boolean);
  Var
    strSQL   : String;
    qryRelDel: TUniQuery;
begin
  strSQL := 'DELETE FROM RETCTP WHERE RET_BCOPGG IS NULL AND RET_CODBCO = ' + QuotedStr(strCodBco);

  If ABancoAPI Then
    strSQL := strSQL + ' AND RET_TIPLAY="API" '
  Else
    strSQL := strSQL + ' AND RET_TIPLAY IS NULL ';

  qryRelDel := fCriaQuery(Nil);
  Try
    qryRelDel.SQL.Text := strSQL;
    qryRelDel.ExecSQL;
  Finally
    qryRelDel.Close;
    FreeAndNil(qryRelDel);
  End;
end;

procedure TPagFor.pExportaPagForFebraban;
  Var
    strSQLDep: String;
    blnGerArq: Boolean;
    qryForPgt: TUniQuery;
    SIdx : Integer;
begin
  strNomEmp   := fRetNomeEmpresa(VS_strCodEmp);
  strCodAge   := fGetBancoConfig(0, FstrConfig, 'CODAGEN', '');
  strDigAge   := fGetBancoConfig(0, FstrConfig, 'DIGAGEN', '');
  strConCor   := fGetBancoConfig(0, FstrConfig, 'NUMCTAC', '');
  strDigCnt   := fGetBancoConfig(0, FstrConfig, 'DIGCTAC', '');
  strCodCar   := fGetBancoConfig(0, FstrConfig, 'NUMCART', '');
  strDigCar   := fGetBancoConfig(0, FstrConfig, 'CODCART', '');
  strCodCon   := fGetBancoConfig(0, FstrConfig, 'CONVENI', '');
  strCodRem   := fStrZero(fAtuCodSeq(FstrConfig, 'PROXNUM'), 6);
  strDtaRem   := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yyyy',VS_Date);
  strHorRem   := FormatDateTime('hh',fTime()) + FormatDateTime('mm',fTime()) + FormatDateTime('ss',fTime());
  blnRemLoc   := Not( fGetBancoConfig(0, 'CONFIGCTA' + FstrCodBco, 'RELOCAL', '') = 'N' );
  strAvisoTed := fGetBancoConfig(0, FstrConfig, 'AVISOFA', '');
  intTotLot   := 0;

  LCompromisso     := fGetBancoConfig(0, FstrConfig, 'CODCOMPROMI', '');
  LTransmissao     := fGetBancoConfig(0, FstrConfig, 'CODPARTRAN', '');
  LOperacaoConta   := fGetBancoConfig(0, FstrConfig, 'OPERCONTA', '');
  //*************************************************//
  // VERIFICA SE EXISTE A CONFIGURACAO PARA A GERA-  //
  // CAO DE REMESSA PARA TODAS AS EMPRESAS OU SOMEN- //
  // TE PARA A EMPRESA ATUAL(LOCAL)                  //
  //**********************************************ED*//
  strNovCodEmp := VS_strCodEmp;

  If Not( blnRemLoc ) Then
    strNovCodEmp := fRetEmpresa;

  strNomEmp := fRetNomeEmpresa(strNovCodEmp);


  //*************************************************//
  // SE OCORRER ALGUM ERRO AO RETORNAR O NOME DA     //
  // EMPRESA, ENTAO DA A MENSAGEM E SKIP A EXPORT.   //
  //**********************************************ED*//
  If fEmptyStr( strNomEmp ) Then
  Begin
    fMensagem('','Erro ao localizar o nome da empresa responsável pela remessa!',['&Sim','&Não']);
    Exit;
  End;

  Try
    fStartTransaction;

    qryConsultaGen := fCriaQuery(qryConsultaGen);

    strSQL := '';
    strSQL := strSQL + 'SELECT                                        ';
    strSQL := strSQL + '  *                                           ';
    strSQL := strSQL + 'FROM                                          ';
    strSQL := strSQL + '  CADEMP                                      ';
    strSQL := strSQL + '  LEFT JOIN CADCID ON CID_CODCID = EMP_CODCID ';
    strSQL := strSQL + 'WHERE                                         ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP                        ';

    With qryConsultaGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      strCgcEmp := FieldByName('EMP_C_G_C_').AsString;
      strEndEmp := FieldByName('EMP_ENDERE').AsString;
      strNumEmp := FieldByName('EMP_ENDNUM').AsString;
      strComEmp := FieldByName('EMP_ENDCMP').AsString;
      strCidEmp := FieldByName('CID_NOMCID').AsString;
      strCepEmp := fTiraCaracEspeciais(FieldByName('EMP_C_E_P_').AsString);
      strEstEmp := FieldByName('CID_ESTADO').AsString;
      Close;
    End;

    If Length(strCgcEmp) > 11 Then
      intTipIns := 2
    Else
      intTipIns := 1;


    qryRemessa := fCriaQuery(Nil);
    qryRemessa.UniDirectional := False;

    strSQL := RetornaSQLExportacao(FstrCodBco, 'CNAB');

    strSQLDep := RetornaSQLExportacaoDeposito(FstrCodBco, 'CNAB');

    qryForPgt := fCriaQuery(Nil);
    qryForPgt.SQL.Text := strSQLDep;
    qryForPgt.ParamByName('CODBCO').AsString    := FstrCodBco;
    qryForPgt.ParamByName('FORMAPGTO').AsString := 'DEP';
    qryForPgt.Open;

    qryRemessa.SQL.Text := strSQL;
    qryRemessa.ParamByName('CODBCO').AsString := FstrCodBco;
    qryRemessa.Open;

    If Not qryRemessa.IsEmpty Then
    Begin
      blnGerArq := True;
      If (Not qryForPgt.IsEmpty) Then
      Begin
        If fEmptyStr (strAvisoTed) Then
        Begin
          blnGerArq := False;
          fRollBack;
          fMensagem('','Existem inconsistências nas configurações de "Dados de Depósito" na carteira do banco selecionado. Portanto, o arquivo de remessa não será exportado!',['&O K']);
        End;
      End;

      If blnGerArq Then
      Begin
        AssignFile(txtTexto, FlstArquiv[0]);
        strFilePath := FlstArquiv[0];
        Rewrite(txtTexto);

        pHeaderArquivo;

        intCodSeqGer:=0;
        intIndLot   := 0;
        intCodSeq1  := 0;

        {****************************}
        {* BOLETOS - DO MESMO BANCO *}
        {*************************AJ*}
        pHeaderLote(False);
        pSegmentoJ;
        pTrailerLote;

        intCodSeqGer:= intCodSeqGer + intCodSeq1;
        intCodSeq1  := 0;

        {******************************}
        {* BOLETOS - DE OUTROS BANCOS *}
        {***************************AJ*}
        pHeaderLote(True);
        pSegmentoJ;
        pTrailerLote;

        intCodSeqGer:= intCodSeqGer + intCodSeq1;
        intCodSeq1  := 0;

        {****************************************}
        {* CONCESSIONÁRIAS - AGUA, LUZ, TRIBUTOS*}
        {*************************************AJ*}
        pHeaderLoteON(fGetTipoPagamentoConcessionaria,fGetFormaPagamentoConcessionária, True);
        pSegmentoO;
        pTrailerLote;

        intCodSeqGer:= intCodSeqGer + intCodSeq1;
        intCodSeq1  := 0;

        {********}
        {* GNRE *}
        {********}
        pHeaderLoteON(fGetTipoPagamento,fGetFormaPagamento, False);
        pSegmentoO;
        pTrailerLote;

        intCodSeqGer:= intCodSeqGer + intCodSeq1;
        intCodSeq1  := 0;

        {******************************}
        {* TED/DOC/FOLHA              *}
        {***************************AJ*}
        for SIdx := 1 to 2 do
        begin
          {***********************************************}
          {*EXECUTA DUAS VEZES. A PRIMEIRA PARA TED\DOCS *}
          {*PARA O MESMO BANCO E A SEGUNDA PARA OUTROS   *}
          {********************************************GD*}
          pHeaderLoteABC(IIF(SIdx = 1, True, False));
          pSegmentoA(IIF(SIdx = 1, True, False));
          pTrailerLote;

          intCodSeqGer:= intCodSeqGer + intCodSeq1;
          intCodSeq1  := 0;
        end;

        {PAGAMENTO SALARIAL MT}
        If MatchStr(FstrCodBco,['001','341']) Then
        Begin
          For SIdx := 1 to 2 do
          begin
            pHeaderLoteABC(IIF(SIdx = 1, True, False),True);
            pSegmentoA(IIF(SIdx = 1, True, False));
            pTrailerLote;

            intCodSeqGer:= intCodSeqGer + intCodSeq1;
            intCodSeq1  := 0;
          end;
        End;

        pTrailerArquivo;

        CloseFile(txtTexto);

        pApagaCadPgi(FstrCodBco, 'CNAB');

        pBackupCnfBco;

        If fCommit then
          fMensagem('','O arquivo de remessa foi gerado com sucesso!' + #13 +
                    'Arquivo Gerado: ' + FlstArquiv[0], ['&O K']);
      End;
    End
    Else
    Begin
      fRollBack;
      fMensagem('','Nenhum registro foi encontrado para gerar o arquivo!',['&O K']);
    End;

    FreeAndNil(qryRemessa);
    FreeAndNil(qryConsultaGen);
  Except
    On E: Exception Do
    Begin
      fRollBack;

      While FileExists(strFilePath) do
        DeleteFile(PWideChar(strFilePath));

      FreeAndNil(qryRemessa);
      FreeAndNil(qryConsultaGen);
      pMensagensErro(E.Message,  '[untTPagFor.fExportaPagFor]','Ocorreu um erro durante a exportação do arquivo. Para tentar novamente por favor fechar o sistema.');
    End;
  End;
end;

procedure TPagFor.pHeaderArquivo;
  Var
    LDadosAdicionais : String;
begin
  {******************************}
  {* HEADER DO ARQUIVO => Reg 0 *}
  {***************************AJ*}

  If (Copy(FstrCodBco,1,3) <> '104') Then
    LDadosAdicionais :=  fRetDadosAdicionais(15)
  Else
    LDadosAdicionais := '000' + fRetDadosAdicionais(12);

  strHeader := '';
  strHeader := fPadR   (Copy(FstrCodBco,1,3), 003)            + //001 - 003
               fPadR   ('0000'              , 004)            + //004 - 007
               fStrZero('0'                 , 001)            + //008 - 008
               fPadL   (' '                 , 006)            + //009 - 014
               fPadR   (fRetLayoutHeader    , 003)            + //015 - 017
               fPadR   (IntToStr(intTipIns) , 001)            + //018 - 018
               fPadL   (strCgcEmp           , 014, '0')       + //019 - 032
               fPadR   (fGetConvenio        , 020)            + //033 - 052
               fPadL   (strCodAge           , 005, '0')       + //053 - 057
               fPadR   (strDigAge           , 001)            + //058 - 058
               fPadL   (fGetContaCorrente   , 012, '0')       + //059 - 070
               fPadR   (fDigitoVerificadordaConta, 001)       + //071 - 071
               fPadL   (fDigitoVerificadordaAgConta, 001)     + //072 - 072
               fPadR   (fTiraCaracEspeciais(strNomEmp), 030, ' ') + //073 - 102
               fPadR   (FstrNomBco          , 030, ' ')       + //103 - 132
               fPadR   (' '                 , 010)            + //133 - 142
               fPadR   ('1'                 , 001)            + //143 - 143
               fPadR   (strDtaRem           , 008)            + //144 - 151
               fPadR   (strHorRem           , 006)            + //152 - 157
               fStrZero(fGetSeqRemessa      , 006)            + //158 - 163
               fStrZero(fGetVersaoLayoutHeaderArquivo, 003)   + //164 - 166
               fStrZero(fGetDensidadeGravacao        , 005)   + //167 - 171
               fPadR   (' '                 , 054)            + //172 - 225
               LDadosAdicionais;                                //226 - 240

  {*******************************}
  {* ESCREVE O HEADER DO ARQUIVO *}
  {****************************AJ*}
  Writeln(txtTexto,strHeader);
end;

procedure TPagFor.pHeaderLote(blnBanDif: Boolean);
begin
  qryRemessa.Filtered := False;
  qryRemessa.Filter   := ' CODBAN ' +
                         IIF(blnBanDif, ' <> ', ' = ') +
                         QuotedStr(Copy(FstrCodBco,1,3)) +
                         ' AND ((PGI_Q_GUIA = "") OR (PGI_Q_GUIA IS NULL)) '+
                         ' AND PGI_TIPPAG IN ("","1") AND FORMAPAGTO <> ' + QuotedStr('DEP') + ' AND CODFUN IS NULL ';

  qryRemessa.Filtered := True;

  If Not qryRemessa.IsEmpty Then
  Begin
    Inc(intTotLot);
    {***************************************************}
    {* HEADER DO LOTE (TÍTULOS) => REG 1 => SEGMENTO J *}
    {************************************************AJ*}
    Inc(intIndLot);
    strHeaderLot := '';
    strHeaderLot := fPadR   (Copy(FstrCodBco,1,3)  , 003)      + //001 - 003
                    fPadR   (fStrZero(intIndLot,4) , 004)      + //004 - 007
                    fPadR   ('1'                   , 001)      + //008 - 008
                    fPadL   ('C'                   , 001)      + //009 - 009
                    fPadR   (fGetTipoServico       , 002)      + //010 - 011
                    fPadR   (IIF(blnBanDif,
                                 '31', '30')       , 002)      + //012 - 013
                    fPadR   (fRetLayoutHeaderLote1 , 003)      + //014 - 016
                    fPadL   (' '                   , 001)      + //017 - 017
                    fPadR   (IntToStr(intTipIns)   , 001)      + //018 - 018
                    fPadL   (strCgcEmp             , 014, '0') + //019 - 032
                    fPadR   (fGetConvenio(True)    , 020)      + //033 - 052
                    fPadL   (strCodAge             , 005, '0') + //053 - 057
                    fPadR   (strDigAge             , 001)      + //058 - 058
                    fPadL   (fGetContaCorrente     , 012, '0') + //059 - 070
                    fPadR   (fDigitoVerificadordaConta, 001)   + //071 - 071
                    fPadL   (fDigitoVerificadordaAgConta, 001) + //072 - 072
                    fPadR   (fTiraCaracEspeciais(strNomEmp), 030, ' ') + //073 - 102
                    fPadL   (' '                   , 030)      + //103 - 132
                    fPadL   (' '                   , 010)      + //133 - 142
                    fPadR   (fTiraCaracEspeciais(strEndEmp), 030, ' ') + //143 - 172
                    fPadL   (fTiraCaracEspeciais(strNumEmp), 005, '0') + //173 - 177
                    fPadR   (strComEmp             , 015, ' ') + //178 - 192
                    fPadR   (fTiraCaracEspeciais(strCidEmp), 020, ' ') + //193 - 212
                    fPadL   (strCepEmp             , 008, '0') + //213 - 220
                    fPadR   (strEstEmp             , 002, ' ') + //221 - 222
                    fPadR   (' '                   , 008)      + //223 - 230
                    fRetDadosAdicionais(10);                     //231 - 240

    {****************************}
    {* ESCREVE O HEADER DO LOTE *}
    {*************************AJ*}
    Writeln(txtTexto,strHeaderLot);
  End;
end;

procedure TPagFor.pHeaderLoteABC(blnBancoDiferente: Boolean; APagamentoSalarial : Boolean = False);
  Var
    LTipoServico : String;
begin
  LTipoServico := '20';
  qryRemessa.Filtered := False;
  qryRemessa.Filter   := ' CODBAN = ' + QuotedStr(Copy(FstrCodBco, 1, 3)) +
                         ' AND FORMAPAGTO = ' + QuotedStr('DEP') +
                         ' AND CODBCO ' + IIF(blnBancoDiferente, ' <> ', ' = ') + QuotedStr(Copy(FstrCodBco, 1, 3)) +
                         ' AND ((PGI_Q_GUIA = '''') OR (PGI_Q_GUIA IS NULL)) ';

  If MatchStr(FstrCodBco,['001','341']) Then
  Begin
    qryRemessa.Filter := qryRemessa.Filter + IIF(APagamentoSalarial,' AND CODFUN <> ""',' AND CODFUN = ""');
    LTipoServico := IIF(APagamentoSalarial,'30','20');
  End;

  qryRemessa.Filtered := True;
  If Not qryRemessa.IsEmpty Then
  Begin
    {*********************************************************************}
    {* HEADER DO LOTE (Pagamento através de crédito em conta, cheque, OP, }
    {* DOC, TED ou pagamento com autenticação) => REG 1 => SEGMENTO ABC  *}
    {******************************************************************AJ*}
    Inc(intTotLot);
    Inc(intIndLot);
    strHeaderLot := '';
    strHeaderLot := fPadR(Copy(FstrCodBco,1,3)                , 003)      + //001 - 003 - CÓD. DO BANCO
                    fPadR(fStrZero(intIndLot,4)               , 004)      + //004 - 007 - LOTE DO SERVIÇO
                    fPadR('1'                                 , 001)      + //008 - 008 - TIPO DE REGISTRO
                    fPadL('C'                                 , 001)      + //009 - 009 - TIPO DE OPERAÇÃO
                    fPadR(LTipoServico                        , 002)      + //010 - 011 - TIPO DO SERVIÇO
                    fPadR(IIF(blnBancoDiferente, '41', '01')  , 002)      + //012 - 013 - FORMA DE LANÇAMENTO
                    fPadR(fRetLayoutLoteABC                   , 003)      + //014 - 016 - Nº DA VERSÃO DO LAYOUT DO LOTE
                    fPadL(' '                                 , 001)      + //017 - 017 - USO EXCLUSIVO FEBRABAN
                    fPadR(IntToStr(intTipIns)                 , 001)      + //018 - 018 - TIPO DE INSCRIÇÃO DA EMPRESA
                    fPadL(strCgcEmp                           , 014, '0') ; //019 - 032 - Nº DE INSCRIÇÃO DA EMPRESA

    if FstrCodBco = '341' then
    begin
      strHeaderLot := strHeaderLot +
        fPadR('1707', 004) + //033 - 036 - IDENTIFICAÇÃO DO LANÇAMENTO
        fPadL(' '   , 016) ; //037 - 052 - COMPLEMENTO DE REGISTRO
    end
    else
      strHeaderLot := strHeaderLot + fPadR(fGetConvenio, 020); //033 - 052 - CÓD. DO CONVÊNIO NO BANCO

    strHeaderLot := strHeaderLot +
                    fPadL(strCodAge                                              , 005, '0') + //053 - 057 - AG. MANTENEDORA DA CONTA
                    fPadR(IIF(FstrCodBco = '341', ' ', strDigAge)                , 001)      + //058 - 058 - DIG. BERIFICADOR DA AGÊNCIA
                    fPadL(fGetContaCorrente                                      , 012, '0') + //059 - 070 - Nº DA CONTA CORRENTE
                    fPadR(IIF(FstrCodBco = '341', ' ', fDigitoVerificadordaConta), 001)      + //071 - 071 - DIGITO VERIFICADOR DA CONTA
                    fPadL(fDigitoVerificadordaAgConta                            , 001)      + //072 - 072 - DIGITO VERIFICADOR DA AG/CONTA
                    fPadR(fTiraCaracEspeciais(strNomEmp)                                              , 030, ' ') + //073 - 102 - NOME DA EMPRESA
                    fPadL(' '                                                    , 040)      + //103 - 142 - MENSAGEM
                    fPadR(fTiraCaracEspeciais(strEndEmp)                                              , 030, ' ') + //143 - 172 - NOME DA RUA, AV, PÇA, ETC
                    fPadL(fTiraCaracEspeciais(strNumEmp)                                             , 005, '0') + //173 - 177 - Nº DO LOCAL
                    fPadR(fTiraCaracEspeciais(strComEmp)                                              , 015, ' ') + //178 - 192 - CASA, APTO, SALA, ETC
                    fPadR(fTiraCaracEspeciais(strCidEmp)                                              , 020, ' ') + //193 - 212 - NOME DA CIDADE
                    fPadL(strCepEmp                                              , 008, '0') + //213 - 220 - CEP + COMPLEMENTO DO CEP
                    fPadR(strEstEmp                                              , 002, ' ') + //221 - 222 - SIGLA DO ESTADO
                    fPadR(fGet223a224                                            , 002)      + //223 - 224 - INDICATIVO DE FORMA DE PAGAMENTO DO SERVIÇO
                    fPadR(' '                                                    , 006)      + //225 - 230 - USO EXCLUSIVO FEBRABAN
                    fPadR(fGetZeroOuBranco                                       , 010,fGetZeroOuBranco);       //231 - 240 - CPDIGO DAS OCORRÊNCIAS P/ RETORNO

    {****************************}
    {* ESCREVE O HEADER DO LOTE *}
    {*************************AJ*}
    Writeln(txtTexto,strHeaderLot);
  End;
end;

procedure TPagFor.pHeaderLoteON(ATipoPagamento, AFormaPagamento: String; AConcessionaria: Boolean);
begin
  qryRemessa.Filtered := False;
  qryRemessa.Filter   := ' CODBAN <> ' + QuotedStr(Copy(FstrCodBco, 1, 3)) +
                         IIF(AConcessionaria, ' AND PGI_TIPPAG = 3 ', ' AND PGI_TIPPAG NOT IN ("","1","3") ' ) +
                         ' AND (FORMAPAGTO <> ' + QuotedStr('DEP') +
                         ' OR ((PGI_Q_GUIA <> '''') OR (PGI_Q_GUIA IS NOT NULL))) ';

  qryRemessa.Filtered := True;

  If Not qryRemessa.IsEmpty Then
  Begin
    Inc(intTotLot);

    {********************************************************************************************************}
    {* HEADER DO LOTE (Pagamento de Concessionárias e tributos com código de barras) => REG 1 => SEGMENTO O *}
    {*****************************************************************************************************AJ*}
    Inc(intIndLot);
    strHeaderLot := '';
    If FstrCodBco <> '001' Then
      strHeaderLot := fPadR   (Copy(FstrCodBco,1,3)       , 003)      + //001 - 003
                      fPadR   (fStrZero(intIndLot,4)      , 004)      + //004 - 007
                      fPadR   ('1'                        , 001)      + //008 - 008
                      fPadL   ('C'                        , 001)      + //009 - 009
                      fPadR   (ATipoPagamento             , 002)      + //010 - 011
                      fPadR   (AFormaPagamento            , 002)      + //012 - 013
                      fPadR   (fRetLayoutHeaderLoteO      , 003)      + //014 - 016
                      fPadL   (' '                        , 001)      + //017 - 017
                      fPadR   (IntToStr(intTipIns)        , 001)      + //018 - 018
                      fPadL   (strCgcEmp                  , 014, '0') + //019 - 032
                      fPadR   (fGetConvenio(True)         , 020)      + //033 - 052
                      fPadL   (strCodAge                  , 005, '0') + //053 - 057
                      fPadR   (strDigAge                  , 001)      + //058 - 058
                      fPadL   (fGetContaCorrente          , 012, '0') + //059 - 070
                      fPadR   (fDigitoVerificadordaConta  , 001)      + //071 - 071
                      fPadL   (fDigitoVerificadordaAgConta, 001)      + //072 - 072
                      fPadR   (strNomEmp                  , 030, ' ') + //073 - 102
                      fPadL   (' '                        , 040)      + //103 - 142
                      fPadR   (strEndEmp                  , 030, ' ') + //143 - 172
                      fPadL   (strNumEmp                  , 005, '0') + //173 - 177
                      fPadR   (strComEmp                  , 015, ' ') + //178 - 192
                      fPadR   (strCidEmp                  , 020, ' ') + //193 - 212
                      fPadL   (strCepEmp                  , 008, '0') + //213 - 220
                      fPadR   (strEstEmp                  , 002, ' ') + //221 - 222
                      fPadR   (' '                        , 002)      + //223 - 224
                      fPadR   (' '                        , 008)      + //225 - 230
                      fPadR   (' '                        , 008)       //231 - 240

      Else
        strHeaderLot := fPadR   (Copy(FstrCodBco,1,3)       , 003)      + //001 - 003
                        fPadR   (fStrZero(intIndLot,4)      , 004)      + //004 - 007
                        fPadR   ('1'                        , 001)      + //008 - 008
                        fPadL   ('C'                        , 001)      + //009 - 009
                        fPadR   (ATipoPagamento             , 002)      + //010 - 011
                        fPadR   (AFormaPagamento            , 002)      + //012 - 013
                        fPadR   (fRetLayoutHeaderLoteO      , 003)      + //014 - 016
                        fPadL   (' '                        , 001)      + //017 - 017
                        fPadR   (IntToStr(intTipIns)        , 001)      + //018 - 018
                        fPadL   (strCgcEmp                  , 014, '0') + //019 - 032
                        fPadR   (fGetConvenio               , 020)      + //033 - 052
                        fPadL   (strCodAge                  , 005, '0') + //053 - 057
                        fPadR   (strDigAge                  , 001)      + //058 - 058
                        fPadL   (fGetContaCorrente          , 012, '0') + //059 - 070
                        fPadR   (fDigitoVerificadordaConta  , 001)      + //071 - 071
                        fPadL   (fDigitoVerificadordaAgConta, 001)      + //072 - 072
                        fPadR   (strNomEmp                  , 030, ' ') + //073 - 102
                        fPadL   (' '                        , 040)      + //103 - 142
                        fPadR   (strEndEmp                  , 030, ' ') + //143 - 172
                        fPadL   (strNumEmp                  , 005, '0') + //173 - 177
                        fPadR   (strComEmp                  , 015, ' ') + //178 - 192
                        fPadR   (strCidEmp                  , 020, ' ') + //193 - 212
                        fPadL   (strCepEmp                  , 008, '0') + //213 - 220
                        fPadR   (strEstEmp                  , 002, ' ') + //221 - 222
                        fPadR   (' '                        , 002)      + //223 - 224
                        fPadR   (' '                        , 006)      + //225 - 230
                        fPadR   ('0'                        , 010,'0');       //231 - 240

      {******************************}
      {* ESCREVE O HEADER DO LOTE O *}
      {***************************AJ*}
      Writeln(txtTexto,strHeaderLot);
  End;
end;

procedure TPagFor.pImportaPagForFebraban;
  Var
    blnExiste  : Boolean;
    intContador: Integer;
    txtTexto   : TextFile;
    strLinha,
    strCodFor,
    strBcoFav,
    strDtaOco,
    strDesCon,
    strValDup,
    strValPag,
    strJurMor,
    strCodOco,
    strMotOco,
    strParcel,
    strSeqBai,
    strSerie_,
    strVenCtp,
    strNomArq,
    LCodigoDeBarras : String;
    dtaDtaArq  : TDateTime;
begin
  fAbrirTabela(frmModuloRetCtp.qryRetCtp);

  blnExiste := False;

  Try
    For intContador := 0 To FlstArquiv.Count-1 Do
    Begin
      {************************}
      {* PEGA DATA DO ARQUIVO *}
      {*********************AJ*}
      FileAge(FlstArquiv[intContador], dtaDtaArq);

      AssignFile(txtTexto, FlstArquiv[intContador]);
      Reset(txtTexto);
      Readln(txtTexto,strLinha);

      {************************************************}
      {* VERIFICA SE O ARQUIVO É DO BANCO SELECIONADO *}
      {*********************************************AJ*}
      If (Copy(strLinha, 1, 3) <> Copy(FstrCodBco, 1, 3)) Then
      Begin
        CloseFile(txtTexto);
        Continue;
      End;

      While Not Eof(txtTexto) Do
      Begin

        Readln(txtTexto,strLinha);

        {*****************************************}
        {* VERIFICA SE NAO FOR DETALHE ELE PULA  *}
        {**************************************AJ*}
        If (Not (Copy(strLinha,08,01) = '3')) Or
           ((Copy(strLinha,08,01) = '3') And (Copy(strLinha,14,01) = 'J') And
           ((Copy(strLinha,15,05) = ' 0052')Or (Copy(strLinha,15,05) = '00052'))) Or
           (Copy(strLinha,14,01) = 'Z') Then
          Continue;

        If  Concat(Copy(strLinha, 14, 01), Trim(Copy(strLinha,183,20))) = 'B' Then
          Continue;

        strNomArq := FlstArquiv[intContador];

        If (Copy(strLinha, 14, 01) = 'O') then
        Begin
          {*************************************************}
          {* ATRIBUI OS CAMPOS DO TXT NA STRING RESPECTIVA *}
          {**********************************************AJ*}
          strAutInc := IIF(FstrCodBco <> '341', Copy(strLinha,123,20), Copy(strLinha,175,20));
          strNumDup := '';
          strCodEmp := '';
          strCodFor := '';
          strBcoFav := '';
          strNosNum := IIF(FstrCodBco <> '341', Copy(strLinha, 143,20), Copy(strLinha, 216,15));

          strDtaOco := IIF(FstrCodBco <> '341', Copy(strLinha, 100,08), Copy(strLinha, 137,08));

          If Not fEmptyStr(strDtaOco) And (strDtaOco <> '000000') Then
          Begin
            System.Insert('/',strDtaOco,3);
            System.Insert('/',strDtaOco,6);
          End;

          strDtaPag := strDtaOco;

          strDtaVen := IIF(FstrCodBco <> '341', Copy(strLinha,092,08), Copy(strLinha,96,8));

          If Not fEmptyStr(strDtaVen) And (strDtaVen <> '000000') Then
          Begin
            System.Insert('/',strDtaVen,3);
            System.Insert('/',strDtaVen,6);
          End;

          strDesCon := '';
          strValDup := IIF(FstrCodBco <> '341', Copy(strLinha,108,15), Copy(strLinha,122,15));
          strValPag := IIF(FstrCodBco <> '341', Copy(strLinha,108,15), Copy(strLinha,145,15));
          strJurMor := '';
          strCodOco := Copy(strLinha,231,10);
          strMotOco := '';
        End
        Else If (Copy(strLinha, 14, 01) = 'A') then
        Begin
          strAutInc := Copy(strLinha,074,20);
          strNumDup := '';
          strCodEmp := '';
          strCodFor := '';
          strBcoFav := Copy(strLinha,021,03);
          strNosNum := IIF(Not MatchStr(FstrCodBco, ['748', '756']), Copy(strLinha,135,15), Copy(strLinha,135,20)); //MF: 286585 - 01/08/23

          strDtaOco := Copy(strLinha,155,08);

          If Not fEmptyStr(strDtaOco) And (strDtaOco <> '000000') Then
          Begin
            System.Insert('/',strDtaOco,3);
            System.Insert('/',strDtaOco,6);
          End;

          strDtaPag := strDtaOco;

          strDtaVen := Copy(strLinha,094,08);

          If Not fEmptyStr(strDtaVen) And (strDtaVen <> '000000') Then
          Begin
            System.Insert('/',strDtaVen,3);
            System.Insert('/',strDtaVen,6);
          End;

          strDesCon := '';
          strValDup := Copy(strLinha,120,15);
          strValPag := Copy(strLinha,163,15);
          strJurMor := '';
          strCodOco := Copy(strLinha,231,10);
          strMotOco := '';
        End
        Else
        Begin
          {*************************************************}
          {* ATRIBUI OS CAMPOS DO TXT NA STRING RESPECTIVA *}
          {**********************************************AJ*}
          strAutInc := Copy(strLinha,183,20);
          strNumDup := '';
          strCodEmp := '';
          strCodFor := '';
          strBcoFav := Copy(strLinha,018,03);
          strNosNum := Copy(strLinha,216,15);

          strDtaOco := Copy(strLinha,145,08);

          If Not fEmptyStr(strDtaOco) And (strDtaOco <> '000000') Then
          Begin
            System.Insert('/',strDtaOco,3);
            System.Insert('/',strDtaOco,6);
          End;

          strDtaPag := strDtaOco;

          strDtaVen := Copy(strLinha,092,08);

          If Not fEmptyStr(strDtaVen) And (strDtaVen <> '000000') Then
          Begin
            System.Insert('/',strDtaVen,3);
            System.Insert('/',strDtaVen,6);
          End;

          strDesCon := Copy(strLinha,115,15);
          strValDup := Copy(strLinha,100,15);
          strValPag := Copy(strLinha,153,15);
          strJurMor := Copy(strLinha,130,15);
          strCodOco := Copy(strLinha,231,10);
          strMotOco := '';
        End;

        {********************************************}
        {* VERIFICA SE A DUPLICATA EXISTE NO CADREC *}
        {*****************************************AJ*}
        If fVerificaExisteDuplicContasPagar(strAutInc, strCodFor, strNumDup, strParcel, strCodEmp, strSeqBai, strSerie_, strVenCtp, LCodigoDeBarras) Then
        Begin

          If fGetBancoConfig(0, FstrConfig, 'REL_MOTIVO_INCONS', '').Equals('S') Then
          Begin
            If Copy(strLinha,14,01).Equals('J') Then
            Begin
              If Not LCodigoDeBarras.Equals( Copy(strLinha,018,44)) Then
              Begin
                pIncluiOcor(strNosNum, strCodFor, strNumDup, '', strCodEmp,
                            StrToDateDef(strDtaVen, 0), StrToDateDef(strDtaPag, 0),
                            fStrToFloat(strValDup)/100, fStrToFloat(strValPag)/100,
                            FcdsNaoGra, 'DIVERGÊNCIA NO CÓDIGO DE BARRAS');
                Continue;

              End;
            End;
          End;

          If Not blnExiste Then
          Begin
            pApagaRetCTP(FstrCodBco, False);
            qryRetCTP := fCriaQuery(Nil);
            qryRetCTP.SQL.Text := 'SELECT * FROM RETCTP WHERE RET_CODBCO=:CODBCO AND RET_TIPLAY IS NULL';
            qryRetCTP.ParamByName('CODBCO').AsString := FstrCodBco;
            qryRetCTP.Open;
          End;

          pGravaArqBcoContasPagar(strParcel, strNumDup, strCodFor, strCodEmp, strSeqBai, strSerie_,
                                  FstrCodBco, strBcoFav, strNosNum, strCodOco, strMotOco, strValDup,
                                  strDesCon, strJurMor, strValPag, strDtaVen, strDtaPag, FlstArquiv[intContador],
                                  strAutInc, dtaDtaArq, qryRetCTP);

          pGravaLogCtp(FstrCodBco, strAutInc);

          blnExiste := True;

        End
        Else
        Begin
          pIncluiOcor(strNosNum, strCodFor, strNumDup, '', strCodEmp,
                      StrToDateDef(strDtaVen, 0), StrToDateDef(strDtaPag, 0),
                      fStrToFloat(strValDup)/100, fStrToFloat(strValPag)/100,
                      FcdsNaoGra,'DUPLICATAS NÃO ENCONTRADAS');
        End;

      End;// fim do while

      CloseFile(txtTexto);

      If Not fRenomeiaArquivo(FlstArquiv[intContador]) Then
        Exit;

    End;// fim do For

    If Not FcdsNaoGra.IsEmpty Then
      pMostraArqNaoBaixa(FstrNomBco);

    pMostraDupNaoBaixa(lstArqNaoGravados);

    If Not blnExiste Then
    Begin
      fMensagem('ALERTA','Não foi encontrada nenhuma duplicata referente ao Arquivo de Retorno! Portanto ficará em aberto para análise!',['&OK']);
      Exit;
    End;

    fMensagem('','Arquivo de retorno importado com sucesso!',['&OK']);


  Except
    On E: Exception Do
    Begin
      If (Pos('duplicada', LowerCase(E.Message)) > 0) Or
         (Pos('duplicate', LowerCase(E.Message)) > 0) Then
      Begin
        fMensagem('AVISO','Registros duplicados no arquivo: ' + strNomArq + #13+ 'Operação cancelada, Verifique!' , ['&O K']);
        pGravarErro(True,E.Message,fRetornaStack);
        Exit;
      End;

      pMensagensErro('Ocorreu um erro na gravação dos arquivos!' + #13 + E.Message ,'[Gravação do Arquivo de Retorno Contas a Pagar]');
    End;
  End;
end;

procedure TPagFor.pMostraArqNaoBaixa(strNomBan: String);
  Var
    strNomImp,
    strTipImp: String;
    frxReport: TfrxReport;
    qryCfgRel: TUniQuery;
Begin
  FcdsNaoGra.IndexFieldNames := 'MOTIVO;DTAVEN';

  qryCfgRel := fCriaQuery(Nil);
  pCarregaConfImpr(qryCfgRel, 'frmRetBco');
  strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
  strTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;

  If strTipImp = 'M' Then
    frxReport := frxReportM
  Else
  Begin
    frxReport := frxReportJ;
    TfrxMemoView(frxReportJ.FindObject('mmoZebra')).Highlight.Color := fCfgSis('CORZEB');
  End;

  With frxReport Do
  Begin
    Script.Variables['NOMEMP'] := VS_strCodEmp + ' - ' + fRetNomeEmpresa;
    Script.Variables['NOMREL'] := 'DUPLICATAS NÃO ENCONTRADAS - ' + strNomBan;
    pPreviewReport('frmRetBco', 'Duplicatas não encontradas - ' + strNomBan, frxReport);
  End;
end;

procedure TPagFor.pMostraDupNaoBaixa(lstArqNaoGravados: TStringList;
  blnImpDes: Boolean);
  Var
    intContador2: Integer;
Begin

  If lstArqNaoGravados.Count > 0 Then
  Begin
    Try
      pCriarFormularios(TfrmArqNaoGravados,frmArqNaoGravados);
      If blnImpDes Then
      Begin
        frmArqNaoGravados.memResumo.Lines.Add('As Duplicatas abaixo foram encontradas no sistema, porém, estão com a chave de busca duplicada. Necessário realizar a baixa manual. ');
        frmArqNaoGravados.memResumo.Lines.Add('');
      End;

      For intContador2 := 0 To lstArqNaoGravados.Count-1 Do
      Begin
        frmArqNaoGravados.memResumo.Lines.Add(lstArqNaoGravados[intContador2]);
      End;
      frmArqNaoGravados.ShowModal;

    Finally
      FreeAndNil(frmArqNaoGravados);
      lstArqNaoGravados.Clear;
    End;
  End;

end;

procedure TPagFor.pSegmentoA(blnBancoDiferente : Boolean);
  Var
    fltValPag : Double;
    LDigVer : String;
begin
  {************************************************}
  {* REGISTRO DE DETALHE => REG = 3 => SEGMENTO A *}
  {*********************************************AJ*}

  With qryRemessa Do
  Begin
    If IsEmpty Then
      Exit;

    strTransacao := '';
    fltValPag1   := 0;

    If (FstrCodBco <> '001') And (FstrCodBco <> '748') Then
      fltValPag  := FieldByName('PGI_VALPAG').AsFloat
    Else
      fltValPag := 0;

    While Not Eof Do
    Begin
      LDigVer := '';
      Inc(intCodSeq1);

      Application.ProcessMessages;

      strDtaVen := FormatDateTime('dd',FieldByName('PGI_DTAVEN').AsDateTime) +
                   FormatDateTime('mm',FieldByName('PGI_DTAVEN').AsDateTime) +
                   FormatDateTime('yyyy',FieldByName('PGI_DTAVEN').AsDateTime);

      strDtaEmi := FormatDateTime('dd',FieldByName('PGI_DTACAD').AsDateTime) +
                   FormatDateTime('mm',FieldByName('PGI_DTACAD').AsDateTime) +
                   FormatDateTime('yyyy',FieldByName('PGI_DTACAD').AsDateTime);

      strDtaPag := FormatDateTime('dd',FieldByName('PGI_DTAPAG').AsDateTime) +
                   FormatDateTime('mm',FieldByName('PGI_DTAPAG').AsDateTime) +
                   FormatDateTime('yyyy',FieldByName('PGI_DTAPAG').AsDateTime);

      strAutInc := FieldByName('PGI_AUTOIN').AsString;

      fltValPag1 := fltValPag1 + FieldByName('PGI_VALPAG').AsFloat;

      strTransacao := fPadR   (Copy(FstrCodBco,1,3)           , 03)      + //001 - 003 - CÓD. DO BANCO
                      fPadR   (fStrZero(intIndLot,4)          , 04)      + //004 - 007 - LOTE DE SERVIÇO
                      fPadR   ('3'                            , 01)      + //008 - 008 - TIPO DE REGISTRO
                      fPadL   (IntToStr(intCodSeq1)           , 05, '0') + //009 - 013 - Nº SEQUENCIAL DO REGISTRO NO LOTE
                      fPadR   ('A'                            , 01)      + //014 - 014 - CÓD. DE SEGMENTO NO REG. DETALHE
                      fStrZero('0'                            , 01)      + //015 - 015 - TIPO DE MOVIMENTO
                      fStrZero('0'                            , 02)      + //016 - 017 - CÓD. DA INSTRUÇÃO P/ MOVIMENTO
                      fPadR   (FieldByName('CAMCEN').AsString , 03, '0') + //018 - 020 - CÓD. DA CÂMARA CENTRALIZADORA
                      fPadR   (FieldByName('CODBCO').AsString , 03, '0') ; //021 - 023 - CÓD. DO BANCO DO FAVORECIDO

      if Copy(FstrCodBco,1,3) = '341' then
      begin
        LDigVer := IIF(fEmptyStr(FieldByName('DIGVER').AsString),FieldByName('DIGCTA').AsString,FieldByName('DIGVER').AsString);
        if not blnBancoDiferente then
        begin
          strTransacao := strTransacao +
                      fStrZero('0'                            , 01)      + //024 - 024 - COMPLEMENTO DE REGISTRO
                      fPadL   (FieldByName('CODAGE').AsString , 04, '0') + //025 - 028 - AG. MANTENEDORA DA CTA. DO FAVOR.
                      fPadR   (' '                            , 01)      + //029 - 029 - COMPLEMENTO DE REGISTRO
                      fStrZero('0'                            , 06)      + //030 - 035 - COMPLEMENTO DE REGISTRO
                      fPadL   (FieldByName('NUMCTA').AsString , 06, '0') + //036 - 041 - Nº DA CONTA CORRENTE
                      fPadR   (' '                            , 01)      + //042 - 042 - COMPLEMENTO DE REGISTRO
                      fPadL   (LDigVer                        , 01, '0') ; //043 - 043 - DÍGITO VERIFICADOR AG/CONTA
        end
        else
        begin
          strTransacao := strTransacao +
                      fPadL(FieldByName('CODAGE').AsString , 05, '0') + //024 - 028 - AG. MANTENEDORA DA CTA. DO FAVOR.
                      fPadL(' '                            , 01)      + //029 - 029 - COMPLEMENTO DE REGISTRO
                      fPadL(FieldByName('NUMCTA').AsString , 12, '0') + //030 - 041 - Nº DA CONTA CORRENTE
                      fPadL(' '                            , 01)      + //042 - 042 - COMPLEMENTO DE REGISTRO
                      fPadL(LDigVer                        , 01, '0') ; //043 - 043 - DÍGITO VERIFICADOR AG/CONTA
        end;
      end
      else
      strTransacao := strTransacao +
                      fPadL(FieldByName('CODAGE').AsString , 05, '0') + //024 - 028 - AG. MANTENEDORA DA CTA. DO FAVOR.
                      fPadR(FieldByName('DIGAGE').AsString , 01, ' ') + //029 - 029 - DÍGITO VERIFICADOR DA AGÊNCIA
                      fPadL(FieldByName('NUMCTA').AsString , 12, '0') + //030 - 041 - Nº DA CONTA CORRENTE
                      fPadR(FieldByName('DIGCTA').AsString , 01, ' ') + //042 - 042 - DÍGITO VERIFICADOR DA CONTA
                      fPadR(FieldByName('DIGVER').AsString , 01, ' ') ; //043 - 043 - DÍGITO VERIFICADOR AG/CONTA

      strTransacao := strTransacao +
        fPadR      (fTiraCaracEspeciais(FieldByName('FOR_NOMFOR').AsString)                , 30, ' ') + //044 - 073 - NOME DO FAVORECIDO
        fPadL      (strAutInc                                                              , 20, ' ') + //074 - 093 - Nº DO DOCUMENTO ATRIBUIDO P/ EMPRESA
        fPadR      (strDtaPag                                                              , 08)      + //094 - 101 - DATA DO PAGAMENTO
        fPadR      (IIF(Copy(FstrCodBco,1,3) = '341', 'REA', 'BRL')                        , 03)      + //102 - 104 - TIPO DA MOEDA
        fStrZero   ('0'                                                                    , 15)      + //105 - 119 - QUANTIDADE DA MOEDA
        fValNumForm(FieldByName('PGI_VALPAG').AsFloat                                      , 15)      + //120 - 134 - VALOR DO PAGAMENTO
        fPadL      (' '                                                                    , 20)      + //135 - 154 - Nº DO DOCUM. ATRIBUIDO PELO BANCO
        fPadR      (IIF(FstrCodBco <> '001',strDtaPag,'0')                                 , 08,'0')  + //155 - 162 - DATA REAL DA EFETIVAÇÃO DO PAGTO.
        fValNumForm(fltValPag                                                              , 15)      + //163 - 177 - VALOR REAL DA EFETIVAÇÃO DO PAGTO.
        fPadL      (' '                                                                    , 20)      + //178 - 197 - FINALIDADE DETALHE INFORMAÇÃO COMPLEMENTAR P/ HIST. DE C/C
        fPadL      (' '                                                                    , 06)      + //198 - 203 - (*) N? DO DOCUMENTO Nº DO DOC/TED/ OP/ CHEQUE NO RETORNO
        fPadR      (IIF(FstrCodBco <> '748',fTiraCaracEspeciais(InscricaoDoFavorecido), ' '),14)      + //204 - 217 - N? DE INSCRIÇÃO N? DE INSCRIÇÃO DO FAVORECIDO (CPF/CNPJ)
        fPadR      ('01'                                                                   , 02)      + //218 - 219 - COMPL. TIPO SERVIÇO
        fPadR      (FieldByName('PGI_CODTED').AsString                                     , 05)      + //220 - 224 - CÓDIGO FINALIDADE DA TED
        fPadR      (IIF(Copy(FstrCodBco,1,3) = '341', ' ', FieldByName('COMPDES').AsString), 02)      + //225 - 226 - COMPL. FINALIDADE DE PAGAMENTO
        fPadR      (' '                                                                    , 03, ' ') + //227 - 229 - USO EXCLUSIVO DA FEBRABAN
        fPadR      (strAvisoTed                                                            , 01)      + //230 - 230 - AVISO AO FAVORECIDO
        fPadR      (fGetZeroOuBranco                                                       , 10,fGetZeroOuBranco);       //231 - 240 - CÓDIGOS DAS OCORRÊNCIAS P/ RETORNO

      {******************************}
      {* ESCREVE A TRANSACAO NO TXT *}
      {***************************AJ*}
      Writeln(txtTexto,strTransacao);

      If FstrCodBco = '001' then
        pSegmentoB;

      If fEhPagamentoSalarial And (FstrCodBco <> '001') Then
        pSegmentoD;

      {****************}
      {* GRAVA LOGCTP *}
      {*************AJ*}
      untLogCtp.GravaLogCtp(FieldByName('PGI_AUTOIN').AsString,
                            'EXPORTAÇÃO DE ARQUIVO DE REMESSA - CTP - ' + FstrCodBco,
                            'frmExpArqPagFor');

      Next;
    End;

  End;
end;

procedure TPagFor.pSegmentoB;
begin
  {*************************************}
  {* REGISTRO DE DETALHE => SEGMENTO B *}
  {**********************************MT*}

  With qryRemessa Do
  Begin
    If IsEmpty Then
      Exit;

    strTransacao := '';
    Inc(intCodSeq1);

    {*************************************}
    {* REGISTRO DE DETALHE => SEGMENTO B *}
    {**********************************MT*}

    strTransacao := fPadR      (Copy(FstrCodBco,1,3)                    , 03)      + //001 - 003
                    fPadR      (fStrZero(intIndLot,4)                   , 04)      + //004 - 007
                    fPadR      ('3'                                     , 01)      + //008 - 008
                    fPadL      (IntToStr(intCodSeq1)                    , 05, '0') + //009 - 013
                    fPadR      ('B'                                     , 01)      + //014 - 014
                    fPadR      (' '                                     , 03, ' ') + //015 - 017
                    fPadR      (IIF(Length(FieldByName('NUMINS').AsString) > 11,'2','1') , 01)+ //018 - 018
                    fPadL      (FieldByName('NUMINS').AsString          , 14, '0') + //019 - 032
                    fPadR      (' '                                     , 30, ' ') + //033 - 062
                    fStrZero   ('0'                                     , 05)      + //063 - 067
                    fPadR      (' '                                     , 15,' ')  + //068 - 082
                    fPadR      (' '                                     , 15,' ')  + //083 - 097
                    fPadL      (' '                                     , 20,' ')  + //098 - 117
                    fStrZero   ('0'                                     , 05)      + //118 - 122
                    fPadR      (' '                                     , 03,' ')  + //123 - 125
                    fPadR      (' '                                     , 02,' ')  + //126 - 127
                    fStrZero   ('0'                                     , 08)      + //128 - 135
                    fValNumForm(0                                       , 15)      + //136 - 150
                    fValNumForm(0                                       , 15)      + //151 - 165
                    fValNumForm(0                                       , 15)      + //166 - 180
                    fValNumForm(0                                       , 15)      + //181 - 195
                    fValNumForm(0                                       , 15)      + //196 - 210
                    fPadR      (' '                                     , 15,' ')  + //211 - 225
                    fPadR      ('0'                                     , 01)      + //226 - 226
                    fStrZero   ('0'                                     , 06)      + //227 - 232
                    fPadR      (' '                                     , 08,' ');   //233 - 240
    {******************************}
    {* ESCREVE A TRANSACAO NO TXT *}
    {***************************AJ*}
    Writeln(txtTexto,strTransacao);
  End;
end;


procedure TPagFor.pSegmentoD;
var
  wrdAno: Word;
  wrdMes: Word;
  wrdDia: Word;

  strCompetencia: String;
begin
  {************************************************}
  {* REGISTRO DE DETALHE => REG = 3 => SEGMENTO D *}
  {*********************************************AJ*}

  With qryRemessa Do
  Begin

    strTransacao := '';

    Inc(intCodSeq1);

    Application.ProcessMessages;

    DecodeDate(FieldByName('PAG_MESBAS').AsDateTime, wrdAno, wrdMes, wrdDia);
    strCompetencia := fPadL(wrdMes.ToString, 02, '0') + fPadL(wrdAno.ToString, 04, '0');

    strTransacao := fPadR      (Copy(FstrCodBco,1,3)                     , 03)      + //001 - 003 - CÓD. DO BANCO
                    fPadR      (fStrZero(intIndLot,4)                    , 04)      + //004 - 007 - LOTE DE SERVIÇO
                    fPadR      ('3'                                      , 01)      + //008 - 008 - TIPO DE REGISTRO
                    fPadL      (IntToStr(intCodSeq1)                     , 05, '0') + //009 - 013 - Nº SEQUENCIAL DO REGISTRO NO LOTE
                    fPadR      ('D'                                      , 01)      + //014 - 014 - CÓD. DE SEGMENTO NO REG. DETALHE
                    fPadL      (' '                                      , 03)      + //015 - 017 - COMPLEMENTO DE REGISTRO
                    fPadR      (strCompetencia                           , 06)      + //018 - 023 - PERÍODO/COMPETÊNCIA
                    fPadR      (FieldByName('DESCTA').AsString           , 15)      + //024 - 038 - CENTRO DE CUSTO
                    fPadR      (FieldByName('CODFUN').AsString           , 15)      + //039 - 053 - CÓDIGO FUNCIONÁRIO
                    fPadR      (FieldByName('FUNCAO').AsString           , 30)      + //054 - 083 - CARGO DO FUNCIONARIO
                    fStrZero   ('0'                                      , 08)      + //084 - 091 - FERIAS DE
                    fStrZero   ('0'                                      , 08)      + //092 - 099 - FERIAS ATÉ
                    fStrZero   ('0'                                      , 02)      + //100 - 101 - DEPENDENTES I.R.
                    fStrZero   ('0'                                      , 02)      + //102 - 103 - DEPENDENTES S.F.
                    fStrZero   ('0'                                      , 02)      + //104 - 105 - HORAS SEMANAIS
                    fValNumForm(FieldByName('PGI_VALPAG').AsFloat        , 15)      + //106 - 120 - SALÁRIO CONTRIBUIÇÃO
                    fStrZero   ('0'                                      , 15)      + //121 - 135 - F.G.T.S.
                    fValNumForm(FieldByName('TOTCRE').AsFloat            , 15)      + //136 - 150 - VALOR CRÉDITOS
                    fValNumForm(FieldByName('TOTDEB').AsFloat            , 15)      + //151 - 165 - VALOR DÉBITO
                    fValNumForm(FieldByName('PGI_VALPAG').AsFloat        , 15)      + //166 - 180 - VALOR LÍQUIDO
                    fValNumForm(FieldByName('SALBAS').AsFloat            , 15)      + //181 - 195 - VALOR FIXO / BASE
                    fValNumForm(FieldByName('SALBAS').AsFloat            , 15)      + //196 - 210 - BASE DE CÁLCULO I.R.R.F.
                    fValNumForm(FieldByName('SALBAS').AsFloat            , 15)      + //211 - 225 - BASE DE CÁLCULO F.G.T.S.
                    fPadL      ('00'                                     , 02)      + //226 - 227 - PRAZO PARA DISPONIBILIZAÇÃO DO HOLERITE
                    fPadL      (' '                                      , 03)      + //228 - 230 - BRANCOS
                    fPadL      (' '                                      , 10);       //231 - 240 - BRANCOS

    {******************************}
    {* ESCREVE A TRANSACAO NO TXT *}
    {***************************AJ*}
    Writeln(txtTexto,strTransacao);

  End;
end;

procedure TPagFor.pSegmentoJ;
  Var
    LAutoIncrem : String;
begin
  {************************************************}
  {* REGISTRO DE DETALHE => REG = 3 => SEGMENTO J *}
  {*********************************************AJ*}

  With qryRemessa Do
  Begin
    If IsEmpty Then
      Exit;

    strTransacao := '';

    fltValPag1 := 0;

    While Not Eof Do
    Begin
      Inc(intCodSeq1);

      Application.ProcessMessages;

      strDtaVen := FormatDateTime('dd',FieldByName('PGI_DTAVEN').AsDateTime) +
                   FormatDateTime('mm',FieldByName('PGI_DTAVEN').AsDateTime) +
                   FormatDateTime('yyyy',FieldByName('PGI_DTAVEN').AsDateTime);

      strDtaEmi := FormatDateTime('dd',FieldByName('PGI_DTACAD').AsDateTime) +
                   FormatDateTime('mm',FieldByName('PGI_DTACAD').AsDateTime) +
                   FormatDateTime('yyyy',FieldByName('PGI_DTACAD').AsDateTime);

      strDtaPag := FormatDateTime('dd',FieldByName('PGI_DTAPAG').AsDateTime) +
                   FormatDateTime('mm',FieldByName('PGI_DTAPAG').AsDateTime) +
                   FormatDateTime('yyyy',FieldByName('PGI_DTAPAG').AsDateTime);

      strAutInc := FieldByName('PGI_AUTOIN').AsString;

      If FstrCodBco = '104' Then
        LAutoIncrem :=  fPadR(Copy(strAutInc,1,6), 20, ' ')
      Else
        LAutoIncrem :=  fPadL(strAutInc, 20, '0');


      fltValPag1 := fltValPag1 + FieldByName('PGI_VALPAG').AsFloat;

      {*********************************************}
      {* REGISTRO DE DETALHE => REG 3 - SEGMENTO J *}
      {******************************************AJ*}

      strTransacao := fPadR      (Copy(FstrCodBco,1,3)                    , 03)      + //001 - 003
                      fPadR      (fStrZero(intIndLot,4)                   , 04)      + //004 - 007
                      fPadR      ('3'                                     , 01)      + //008 - 008
                      fPadL      (IntToStr(intCodSeq1)                    , 05, '0') + //009 - 013
                      fPadR      ('J'                                     , 01)      + //014 - 014
                      fStrZero   ('0'                                     , 03)      + //015 - 017
                      fPadL      (FieldByName('PGI_CODBAR').AsString      , 44, '0') + //018 - 061
                      fPadR      (fTiraCaracEspeciais(FieldByName('FOR_NOMFOR').AsString), 30, ' ') + //062 - 091
                      fPadR      (strDtaVen                               , 08)      + //092 - 099
                      fValNumForm(FieldByName('PGI_VALDUP').AsFloat       , 15)      + //100 - 114
                      fValNumForm(FieldByName('PGI_VALDES').AsFloat       , 15)      + //115 - 129
                      fStrZero   ('0'                                     , 15)      + //130 - 144
                      fPadR      (strDtaPag                               , 08)      + //145 - 152
                      fValNumForm(FieldByName('PGI_VALPAG').AsFloat       , 15)      + //153 - 167
                      fStrZero   ('0'                                     , 15)      + //168 - 182
                      fPadL      (LAutoIncrem                             , 20)      + //183 - 202
                      fPadL      (' '                                     , 20)      + //203 - 222
                      IIF(Copy(FstrCodBco,1,3) <> '341', fStrZero('09', 02), fPadL(' ',2)) + //223 - 224
                      fPadL      (' '                                     , 06)      + //225 - 230
                      fRetDadosAdicionais(10);                                         //231 - 240

      {******************************}
      {* ESCREVE A TRANSACAO NO TXT *}
      {***************************AJ*}
      Writeln(txtTexto,strTransacao);

      {**********************************************************}
      {* REGISTRO DE DETALHE DA TRANSAÇÃO => REG 3 - SEGMENTO J *}
      {*******************************************************AJ*}

      If Length(FieldByName('NUMINS').AsString) > 11 Then
      begin
        intTipInsFor := 2;
        strCgcFor    := '0' + fPadR(FieldByName('NUMINS').AsString, 14, '0');
      end
      Else
      begin
        intTipInsFor := 1;
        strCgcFor    := '0' + fPadR(FieldByName('NUMINS').AsString, 14, ' ');
      end;

      Inc(intCodSeq1);
      strTransacao := fPadR      (Copy(FstrCodBco,1,3)                     , 03)      + //001 - 003
                      fPadR      (fStrZero(intIndLot,4)                    , 04)      + //004 - 007
                      fPadR      ('3'                                      , 01)      + //008 - 008
                      fPadL      (IntToStr(intCodSeq1)                     , 05, '0') + //009 - 013
                      fPadR      ('J'                                      , 01)      + //014 - 014
                      fPadR      (' '                                      , 01)      + //015 - 015
                      fPadL      (fRetCodMovRemDetJ                        , 02)      + //016 - 017
                      fPadR      ('52'                                     , 02)      + //018 - 019
                      fPadR      (IntToStr(intTipIns)                      , 01)      + //020 - 020
                      fPadL      ('0'+strCgcEmp                            , 15, '0') + //021 - 035
                      fPadR      (fTiraCaracEspeciais(strNomEmp)           , 40, ' ') + //036 - 075
                      fPadR      (IntToStr(intTipInsFor)                   , 01)      + //076 - 076
                      fPadL      (strCgcFor                                , 15, '0') + //077 - 091
                      fPadR      (fTiraCaracEspeciais(FieldByName('FOR_NOMFOR').AsString), 40, ' ') + //092 - 131
                      fStrZero   (fRetTipAvalista                          , 01)      + //132 - 132
                      fPadL      (fRetCgcAvalista                          , 15, '0') + //133 - 147
                      fPadR      (fRetNomAvalista                          , 40)      + //148 - 187
                      fPadL      (' '                                      , 53);       //188 - 240

      {**************************************************}
      {* ESCREVE O REGISTRO DETALHE DA TRANSACAO NO TXT *}
      {***********************************************AJ*}
      Writeln(txtTexto,strTransacao);

      {****************}
      {* GRAVA LOGCTP *}
      {*************AJ*}
      untLogCtp.GravaLogCtp(FieldByName('PGI_AUTOIN').AsString,
                            'EXPORTAÇÃO DE ARQUIVO DE REMESSA - CTP - ' + FstrCodBco,
                            'frmExpArqPagFor');

      Next;
    End;

  End;
end;

procedure TPagFor.pSegmentoO;
var
  ANumeroNota: String;
begin
  With qryRemessa Do
  Begin
    If IsEmpty Then
      Exit;
    strTransacao := '';
    fltValPag1   := 0;

    While Not Eof Do
    Begin
      Inc(intCodSeq1);

      Application.ProcessMessages;

      strDtaVen := FormatDateTime('dd',FieldByName('PGI_DTAVEN').AsDateTime) +
                   FormatDateTime('mm',FieldByName('PGI_DTAVEN').AsDateTime) +
                   FormatDateTime('yyyy',FieldByName('PGI_DTAVEN').AsDateTime);

      strDtaEmi := FormatDateTime('dd',FieldByName('PGI_DTACAD').AsDateTime) +
                   FormatDateTime('mm',FieldByName('PGI_DTACAD').AsDateTime) +
                   FormatDateTime('yyyy',FieldByName('PGI_DTACAD').AsDateTime);

      strDtaPag := FormatDateTime('dd',FieldByName('PGI_DTAPAG').AsDateTime) +
                   FormatDateTime('mm',FieldByName('PGI_DTAPAG').AsDateTime) +
                   FormatDateTime('yyyy',FieldByName('PGI_DTAPAG').AsDateTime);

      strAutInc := FieldByName('PGI_AUTOIN').AsString;

      fltValPag1 := fltValPag1 + FieldByName('PGI_VALPAG').AsFloat;


      strTransacao := fPadR      (Copy(FstrCodBco,1,3)                     , 03)      + //001 - 003 CÓDIGO DO BANCO NA COMPENSAÇÃO
                      fPadR      (fStrZero(intIndLot,4)                    , 04)      + //004 - 007 LOTE DE SERVIÇO
                      fPadR      ('3'                                      , 01)      + //008 - 008 REGISTRO DETALHE DE LOTE
                      fPadL      (IntToStr(intCodSeq1)                     , 05, '0') + //009 - 013 Nº SEQUENCIAL REGISTRO NO LOTE
                      fPadR      ('O'                                      , 01)      + //014 - 014 CÓDIGO SEGMENTO REG. DETALHE
                      fStrZero   ('0'                                      , 03);       //015 - 017 TIPO DE MOVIMENTO

      if FstrCodBco = '341' then
      begin
        if FieldByName('PGI_CODREC').AsString = '100099' then
          ANumeroNota := FieldByName('NUMDOCUMENTO').AsString
        Else
          ANumeroNota := '         ';

        strTransacao := strTransacao +
                        fPadR      (FieldByName('PGI_CODBAR').AsString       , 48, ' ') + //018 - 065 CÓDIGO DE BARRAS
                        fPadR      (FieldByName('FOR_NOMFOR').AsString       , 30, ' ') + //066 - 095 NOME DA CONCESSIONÁRIA / CONTRIBUINTE
                        fPadR      (strDtaVen                                , 08)      + //096 - 103 DATA DO VENCIMENTO(NOMINAL)
                        fPadR      ('REA'                                    , 03)      + //104 - 106 TIPO DE MOEDA
                        fPadL      ('0'                                      , 15, '0') + //107 - 121 QUANTIDADE DE MOEDA
                        fValNumForm(FieldByName('PGI_VALDUP').AsFloat        , 15)      + //122 - 136 VALOR PREVISTO DO PAGAMENTO
                        fPadR      (strDtaPag                                , 08)      + //137 - 144 DATA DO PAGAMENTO
                        fValNumForm(0                                        , 15)      + //145 - 159 VALOR DE EFETIVAÇÃO DO PAGAMENTO
                        fPadL      (' '                                      , 03, ' ') + //160 - 162 COMPLEMENTO DE REGISTRO
                        fPadL      (ANumeroNota                              , 09, '0') + //163 - 171 NÚMERO DA NOTA FISCAL
                        fPadL      (' '                                      , 03, ' ') + //172 - 174 COMPLEMENTO DE REGISTRO
                        fPadL      (strAutInc                                , 20, ' ') + //175 - 194 Nº DOCTO ATRIBUÍDO PELA EMPRESA
                        fPadL      (' '                                      , 21, ' ') + //195 - 215 COMPLEMENTO DE REGISTRO
                        fPadL      (' '                                      , 15, ' ') + //216 - 230 Nº ATRIBUÍDO PELO BANCO
                        fPadL      (' '                                      , 10);       //231 - 240 CÓDIGO DE OCORRÊNCIAS P/ RETORNO
      end
      else
      begin
        strTransacao := strTransacao +
                        fPadL      (FieldByName('PGI_CODBAR').AsString       , 44, '0') + //018 - 061
                        fPadR      (fTiraCaracEspeciais(FieldByName('FOR_NOMFOR').AsString), 30, ' ') + //062 - 091
                        fPadR      (strDtaVen                                , 08)      + //092 - 099
                        fPadR      (strDtaPag                                , 08)      + //100 - 107
                        fValNumForm(FieldByName('PGI_VALDUP').AsFloat        , 15)      + //108 - 122
                        fPadL      (strAutInc                                , 20, ' ') + //123 - 142
                        fPadL      (' '                                      , 20, ' ') + //143 - 162
                        fPadL      (' '                                      , 68)      + //163 - 230
                        fPadL      (fGetZeroOuBranco                         , 10,fGetZeroOuBranco);       //231 - 240
      end;

      {******************************}
      {* ESCREVE A TRANSACAO NO TXT *}
      {***************************AJ*}
      Writeln(txtTexto,strTransacao);

      If (Copy(qryRemessa.FieldByName('PGI_CODBAR').AsString,23,5) = '95523') Then
      Begin
        If FstrCodBco = '001' then
          pSegmentoW;
      End;

      {****************}
      {* GRAVA LOGCTP *}
      {*************AJ*}
      untLogCtp.GravaLogCtp(FieldByName('PGI_AUTOIN').AsString,
                            'EXPORTAÇÃO DE ARQUIVO DE REMESSA - CTP - ' + FstrCodBco,
                            'frmExpArqPagFor');

      Next;
    End;

  End;
end;

procedure TPagFor.pSegmentoW;
var
  wrdAno: Word;
  wrdMes: Word;
  wrdDia: Word;

  strCompetencia: String;
begin
  {*************************************}
  {* REGISTRO DE DETALHE => SEGMENTO W *}
  {**********************************MT*}

  With qryRemessa Do
  Begin
    If IsEmpty Then
      Exit;

    strTransacao := '';
    Inc(intCodSeq1);
    Application.ProcessMessages;
    strAutInc := FieldByName('PGI_AUTOIN').AsString;

    DecodeDate(FieldByName('PAG_MESBAS').AsDateTime, wrdAno, wrdMes, wrdDia);
    strCompetencia := fPadL(wrdMes.ToString, 02, '0') + fPadL(wrdAno.ToString, 04, '0');

    {*************************************}
    {* REGISTRO DE DETALHE => SEGMENTO W *}
    {**********************************MT*}

    strTransacao := fPadR      (Copy(FstrCodBco,1,3)                    , 03)      + //001 - 003
                    fPadR      (fStrZero(intIndLot,4)                   , 04)      + //004 - 007
                    fPadR      ('3'                                     , 01)      + //008 - 008
                    fPadL      (IntToStr(intCodSeq1)                    , 05, '0') + //009 - 013
                    fPadR      ('W'                                     , 01)      + //014 - 014
                    fStrZero   ('1'                                     , 01)      + //015 - 015
                    fStrZero   ('9'                                     , 01)      + //016 - 016
                    fStrZero   (strAutInc                               , 20)      + //017 - 036
                    fStrZero   (strCompetencia                          , 06)      + //037 - 042
                    fStrZero   (strCgcEmp                               , 14)      + //043 - 056
                    fValNumForm(FieldByName('PGI_VALDUP').AsFloat       , 14)      + //057 - 070
                    fValNumForm(FieldByName('PGI_VALDES').AsFloat       , 14)      + //071 - 084
                    fPadL      (' '                                     , 12,' ')  + //085 - 096
                    fValNumForm(0                                       , 14)      + //097 - 110
                    fValNumForm(0                                       , 14)      + //111 - 124
                    fValNumForm(0                                       , 14)      + //125 - 138
                    fValNumForm(0                                       , 14)      + //139 - 152
                    fPadL      (' '                                     , 24,' ')  + //153 - 176
                    fStrZero   ('01'                                    , 02)      + //177 - 178
                    fPadL      (' '                                     , 50,' ')  + //179 - 228
                    fPadL      (' '                                     , 02,' ')  + //129 - 230
                    fPadR      ('0'                                     , 10,'0');   //231 - 240

    {******************************}
    {* ESCREVE A TRANSACAO NO TXT *}
    {***************************AJ*}
    Writeln(txtTexto,strTransacao);
  End;
end;


procedure TPagFor.pTrailerArquivo;
  Var
    L30a35 : String;
begin
  {*******************************}
  {* TRAILER DO ARQUIVO => Reg 9 *}
  {****************************AJ*}
  L30a35 := IIF((Copy(FstrCodBco,1,3) = '341'),' ','0');
  intCodSeqGer:= intCodSeqGer + 2;
  strTrailler := '';
  strTrailler := fPadR   (Copy(FstrCodBco,1,3)  , 003)      + //001 - 003
                 fPadR   ('9999'                , 004)      + //004 - 007
                 fPadR   ('9'                   , 001)      + //008 - 008
                 fPadR   (' '                   , 009)      + //009 - 017
                 fPadL   (IntToStr(intTotLot)   , 006, '0') + //018 - 023
                 fPadL   (IntToStr(intCodSeqGer), 006, '0') + //024 - 029
                 fPadL   (L30a35                , 006, L30a35) + //030 - 035
                 fPadR   (' '                   , 205);       //036 - 240

  {****************************************}
  {* ESCREVE O TRAILLER DO ARQUIVO NO TXT *}
  {*************************************AJ*}
  Writeln(txtTexto,strTrailler);
end;

procedure TPagFor.pTrailerLote;
begin
  {****************************}
  {* TRAILER DO LOTE => Reg 5 *}
  {*************************AJ*}
  If Not qryRemessa.IsEmpty Then
  Begin
    Inc(intCodSeq1);
    Inc(intCodSeq1);
    strTraillerLot := '';
    If FstrCodBco <> '001' Then
      strTraillerLot := fPadR      (Copy(FstrCodBco,1,3) , 003)       + //001 - 003
                        fPadR      (fStrZero(intIndLot,4), 004)       + //004 - 007
                        fPadR      ('5'                  , 001)       + //008 - 008
                        fPadR      (' '                  , 009)       + //009 - 017
                        fPadL      (IntToStr(intCodSeq1) , 006, '0')  + //018 - 023
                        fValNumForm(fltValPag1           , 018)       + //024 - 041
                        fStrZero   ('0'                  , 018)       + //042 - 059
                        fStrZero   ('0'                  , 006)       + //060 - 065
                        fPadR      (' '                  , 175)         //066 - 240
    Else
      strTraillerLot := fPadR      (Copy(FstrCodBco,1,3) , 003)       + //001 - 003
                        fPadR      (fStrZero(intIndLot,4), 004)       + //004 - 007
                        fPadR      ('5'                  , 001)       + //008 - 008
                        fPadR      (' '                  , 009)       + //009 - 017
                        fPadL      (IntToStr(intCodSeq1) , 006, '0')  + //018 - 023
                        fValNumForm(fltValPag1           , 018)       + //024 - 041
                        fStrZero   ('0'                  , 018)       + //042 - 059
                        fStrZero   ('0'                  , 006)       + //060 - 065
                        fPadR      (' '                  , 165)       + //066 - 230
                        fPadR      ('0'                  , 010,'0');    //231 - 240

    {************************************}
    {* ESCREVE O TRAILER DO LOTE NO TXT *}
    {*********************************AJ*}
    Writeln(txtTexto,strTraillerLot);
  End;
end;

class function TPagFor.RetornaObjetoAPI(ACodigoBanco,
  ACarteira: String): TObject;
begin
  Result := TObject.Create;

  If ACodigoBanco = '001' Then
    Result := TPagForBancoDoBrasilAPI.Create(ACarteira);
end;

function TPagFor.RetornaSQLExportacao(ACodigoBanco : String; ATipoRegistro : String): String;
begin
  Result := '';
  Result := Result + 'SELECT                                              ';
  Result := Result + '  B.*,                                              ';
  Result := Result + '  IFNULL(B.PGI_Q_GUIA, "") AS CODIGO_GUIA,          ';
  Result := Result + '  F.FOR_NOMFOR,                                     ';
  Result := Result + '  F.FOR_ENDERE AS ENDERE,                           ';
  Result := Result + '  F.FOR_BAIRRO AS BAIRRO,                           ';
  Result := Result + '  F.FOR_C_E_P_ AS C_E_P_,                           ';
  Result := Result + '  F.FOR_CGCCPF AS CGCCPF,                           ';
  Result := Result + '  F.FOR_C_G_C_ AS NUMINS,                           ';
  Result := Result + '  D.BCF_CAMCEN AS CAMCEN,                           ';
  Result := Result + '  D.BCF_CODBCO AS CODBCO,                           ';
  Result := Result + '  D.BCF_NUMAGE AS CODAGE,                           ';
  Result := Result + '  D.BCF_DIGAGE AS DIGAGE,                           ';
  Result := Result + '  D.BCF_NUMCTA AS NUMCTA,                           ';
  Result := Result + '  D.BCF_DIGCTA AS DIGCTA,                           ';
  Result := Result + '  D.BCF_DIGVER AS DIGVER,                           ';
  Result := Result + '  D.BCF_COMPDES AS COMPDES,                         ';
  Result := Result + '  C.CID_NOMCID AS CIDADE,                           ';
  Result := Result + '  C.CID_ESTADO AS ESTADO,                           ';
  Result := Result + '  B.PGI_FORPGT AS FORMAPAGTO,                       ';
  Result := Result + '  P.CTP_NUMDOC AS NUMDOCUMENTO,                     ';
  Result := Result + '  P.CTP_FORPIX AS AUTOINCREM_FORPIX,                ';
  Result := Result + '  X.PIX_TIPCHV AS TIPCHV_PIX,                        ';
  Result := Result + '  X.PIX_CHAVE_ AS CHAVE_PIX,                        ';
  Result := Result + '  IF(PGI_CODBAR = "", PGI_CODBCO,                   ';
  Result := Result + '                     LEFT(PGI_CODBAR, 3)) AS CODBAN,';
  Result := Result + '  IFNULL(PAG_CODFUN,"") AS CODFUN,                  ';
  Result := Result + '  CTA_DESCTA AS DESCTA,                             ';
  Result := Result + '  FNC_NOMFNC AS FUNCAO,                             ';
  Result := Result + '  SUM(IF(VER_DEBCRE = "C",PAG_VALLAN,0)) TOTCRE,    ';
  Result := Result + '  SUM(IF(VER_DEBCRE = "D",PAG_VALLAN*(-1), 0)) TOTDEB, ';
  Result := Result + '  SUM(IF(VER_SALBAS = "S",PAG_VALLAN,0)) SALBAS,    ';
  Result := Result + '  A.PAG_MESBAS                                      ';
  Result := Result + 'FROM                                                ';
  Result := Result + '  CADPGI B                                          ';
  Result := Result + '  LEFT JOIN CADFOR F ON FOR_CODFOR = PGI_CODFOR     ';
  Result := Result + '  LEFT JOIN CADPAG P ON P.AUTOINCREM = PGI_AUTOIN   ';
  Result := Result + '  LEFT JOIN BCOFOR D ON D.AUTOINCREM = P.CTP_BCOFOR ';
  Result := Result + '  LEFT JOIN FORPIX X ON X.AUTOINCREM = P.CTP_FORPIX ';
  Result := Result + '  LEFT JOIN CADCID C ON C.CID_CODCID = F.FOR_CODCID ';
  Result := Result + '  LEFT JOIN CADCTA G ON G.CTA_CODCTA = P.CTP_CODCTA ';
  Result := Result + '  LEFT JOIN CTRPAG A ON A.PAG_AUTCTP = B.PGI_AUTOIN ';
  Result := Result + '  LEFT JOIN CADFUN E ON E.FUN_CODFUN = A.PAG_CODFUN ';
  Result := Result + '  LEFT JOIN CADFNC N ON N.FNC_CODFNC = E.FUN_FUNATU ';
  Result := Result + '  LEFT JOIN CADVER V ON V.VER_CODVER = A.PAG_CODVER ';
  Result := Result + 'WHERE                                               ';
  Result := Result + '  PGI_BCOPGG IS NULL AND                            ';

  If MatchStr(ACodigoBanco, ['001']) then
  begin
    if not fEmptyStr(ATipoRegistro) Then
    begin
      Result := Result + '  PGI_CARTEI = "' + ATipoRegistro + '" AND      ';
    end;
  end;

  Result := Result + '  PGI_CODBCO = :CODBCO                              ';
  Result := Result + 'GROUP BY B.PGI_AUTOIN                               ';
end;

function TPagFor.RetornaSQLExportacaoDeposito(ACodigoBanco : String; ATipoRegistro : String): String;
begin
  Result := RetornaSQLExportacao(ACodigoBanco, ATipoRegistro) +
            ' AND PGI_FORPGT = :FORMAPGTO LIMIT 1 '
end;

function TPagFor.ValidarPagamentosAPI(ACodigoBanco: String;
  AListaDuplicatas: TList<TPagForRetorno>; var cdsNaoGra: TUniClientDataSet;
  AGravando: TfrmGravando): Boolean;
  Var
    LPagamento: TPagForRetorno;

    LCodigoBarras: String;

    LExiste: Boolean;
begin
  Result := True;

  LExiste := False;

  cdsNaoGra.CreateDataSet;
  cdsNaoGra.Open;
  cdsNaoGra.EmptyDataSet;

  FcdsNaoGra := cdsNaoGra;

  AGravando.lblGravando.Caption := 'Aguarde... Validando pagamentos.';
  pProgresso(0, AListaDuplicatas.Count, AGravando.pgbStatus);

  Try
    fStartTransaction;

    For LPagamento In AListaDuplicatas Do
    Begin
      pStepStatusGravacao(AGravando.pgbStatus);

      If fVerificaExisteDuplicContasPagar(LPagamento.AutoIncremDuplicata,
                                          LPagamento.CodigoFornecedor,
                                          LPagamento.NumeroDuplicata,
                                          LPagamento.ParcelaDuplicata,
                                          LPagamento.EmpresaDuplicata,
                                          LPagamento.SeqBaiDuplicata,
                                          LPagamento.SerieDuplicata,
                                          LPagamento.DataVencimento,
                                          LCodigoBarras) Then
      Begin

        If Not LExiste Then
        Begin
          pApagaRetCTP(ACodigoBanco, True);

          qryRetCTP := fCriaQuery;
          qryRetCTP.SQL.Text := 'SELECT * FROM RETCTP WHERE RET_CODBCO=:CODBCO AND RET_TIPLAY="API"';
          qryRetCTP.ParamByName('CODBCO').AsString := ACodigoBanco;
          qryRetCTP.Open;
        End;

        If ACodigoBanco.Equals('001') Then
        Begin
          If Not LPagamento.NumeroLotePagamento.Equals(fCampoTabela('CTP_NUMLOT', 'CADPAG', ['AUTOINCREM'], [LPagamento.AutoIncremDuplicata])) Then
            Continue;
        End;

        pGravaArqBcoContasPagar(LPagamento.ParcelaDuplicata,
                                LPagamento.NumeroDuplicata,
                                LPagamento.CodigoFornecedor,
                                LPagamento.EmpresaDuplicata,
                                LPagamento.SeqBaiDuplicata,
                                LPagamento.SerieDuplicata,
                                ACodigoBanco,
                                LPagamento.BancoFavorecido,
                                LPagamento.NossoNumero,
                                LPagamento.CodigosOcorrencia,
                                LPagamento.MotivosOcorrencia,
                                LPagamento.ValorDuplicata,
                                LPagamento.ValorDesconto,
                                LPagamento.ValorJuros,
                                LPagamento.ValorPago,
                                LPagamento.DataVencimento,
                                LPagamento.DataPagamento,
                                '',
                                LPagamento.AutoIncremDuplicata,
                                VS_Date,
                                qryRetCTP,
                                'API');

        pGravaLogCtp(ACodigoBanco + ' API', LPagamento.AutoIncremDuplicata);

        LExiste := True;
      End
      Else
        pIncluiOcor(LPagamento.NossoNumero,
                    LPagamento.CodigoFornecedor,
                    LPagamento.NumeroDuplicata,
                    '',
                    LPagamento.EmpresaDuplicata,
                    StrToDateDef(LPagamento.DataVencimento, 0),
                    StrToDateDef(LPagamento.DataPagamento, 0),
                    fStrToFloat(LPagamento.ValorDuplicata)/100,
                    fStrToFloat(LPagamento.ValorPago)/100,
                    FcdsNaoGra,
                    'DUPLICATAS NÃO ENCONTRADAS');
    End;

    fCommit;

    If Not FcdsNaoGra.IsEmpty Then
      pMostraArqNaoBaixa(ACodigoBanco);
  Except
    On E: Exception Do
    Begin
      fRollback;

      Raise;
    End;
  End;

  If Not LExiste Then
  Begin
    fMensagem('ALERTA','Não foi encontrada nenhuma duplicata referente ao período de pagamento digitado!',['&OK']);
    Exit;
  End;

  fMensagem('ATENÇÃO','Importação de pagamentos realizado com sucesso!',['&OK']);
end;

function TPagFor.fRetEmpresa: String;
  Var
    intCount  : Integer;
    arrResult : Array Of String;
    qryCadEmp : TUniQuery;
Begin

  qryCadEmp := fCriaQuery(Nil);
  With qryCadEmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM CADEMP');
    Open;

    SetLength(arrResult, RecordCount);
    intCount := 0;

    While Not Eof Do
    Begin
      arrResult[intCount] := fStrZero(FieldByName('EMP_CODEMP').AsString, 3) + ' - ' + FieldByName('EMP_NOMEMP').AsString;
      Next;
      Inc(intCount);
    End;
  End;


  intCount := 1;

  If Length(arrResult) > 1 Then
    intCount := fGetMenu('Selecione a Empresa', arrResult, 0);


  Result   := LeftStr(arrResult[intCount -1], 3);

  FreeAndNil(qryCadEmp);
end;

function TPagFor.fRetLayoutHeader: String;
begin
  Case StrToInt(FstrCodBco) Of
    1  : Result := '   ';
    104: Result := '   ';
    341: Result := '081';
    748: Result := '   ';
  End;
end;

function TPagFor.fRetLayoutHeaderLote1: String;
begin
  Case StrToInt(FstrCodBco) Of
    1  : Result := '030';
    104: Result := '041';
    341: Result := '030';
    748: Result := '042';
  End;
end;

function TPagFor.fRetLayoutHeaderLoteO: String;
begin
  Case StrToInt(FstrCodBco) Of
    1  : Result := '012';
    104: Result := '030';
    341: Result := '030';
    748: Result := '042';
  End;
end;

procedure TPagFor.pGravaLogCtp(strCodBco, strAutoIncrem: String);
Begin
  {****************}
  {* GRAVA LOGCTP *}
  {*************AJ*}
  untLogCtp.GravaLogCtp(strAutoIncrem,
                        'IMPORTACAO DO ARQUIVO DE RETORNO - ' + strCodBco,
                        'frmRetPagFor');
end;

end.
