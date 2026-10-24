unit Contabilidade.Classes.TImportacaoDadosContabeisTspCoa;

interface

uses Uni, cxProgressBar, Classes, Data.DB, System.Generics.Collections,
     Contabilidade.Classes.TImportacaoDadosContabeis,
     Contabilidade.Interfaces, UniClientDataSet;

type
  TDadosValidacaoTspCoa = record
    ACompet : string;
    ACodemp : string;
    APlaant : string;
    AIndsit : string;
    AVallan : Double ;
    APlanov : string;
  end;

  TDictPendenciasTspCoa = TDictionary<String, TList<String>> ;

  TImportacaoDadosContabeisTspCoa = Class(TImportacaoDadosContabeisBase)
  private
    FarrTspCoa : array of TTspCoaInfo ;
    function fConverteEstruturaParaValidacao(const AArr: array of TTspCoaInfo):TList<TDadosValidacaoTspCoa> ;
  protected
    procedure pCarregaInfoColunas; override;
    function fGetSqlInsert:string; override;
    function fGetNomeTabela: string; override;
  public
    function fCarregaDadosPlanilha(const AprocErros: TErroContabilProc): boolean; override;
    function fPersisteDados:boolean; override;
    procedure pApagaDados;
  End;

  TValidaProcessoTspCoa = class
  private
    class function fVaiSobreporDados(const ADadosValidacao: TList<TDadosValidacaoTspCoa>): Boolean;
    class procedure pValidaPlanoContasExiste(const ADadosValidacao: TList<TDadosValidacaoTspCoa>;
                                             var AdictMensagens: TDictPendenciasTspCoa;
                                             AcdsPlanco: TUniClientDataSet) ;
    class procedure pValidaPlanoContasNaPlaini(const ADadosValidacao: TList<TDadosValidacaoTspCoa>;
                                               var AdictMensagens: TDictPendenciasTspCoa;
                                                   AcdsPlaini: TUniClientDataSet); overload ;
    class procedure pValidaOutros(const ADadosValidacao: TList<TDadosValidacaoTspCoa>;
                                  var AdictMensagens: TDictPendenciasTspCoa) ;
    class procedure pMostraMensagens(const AArrMensagens: TDictPendenciasTspCoa; const AprocErros: TErroContabilProc) ;
    class function fMascaraCompetencia(const AstrCompet: String): String ;
    class procedure pValidaPlanoContasNaPlainiInterno(const ADadosValidacao: TList<TDadosValidacaoTspCoa>;
                                                      var   AdictMensagens: TDictPendenciasTspCoa;
                                                      AcdsPlaini: TUniClientDataSet);
    class function fCarregaPlaini(const ADadosValidacao: TList<TDadosValidacaoTspCoa>): TUniClientDataSet;
    class function fCarregaPlanco: TUniClientDataSet;
    class function fMontaChaveDicionarioValidacao(const AInfo: TDadosValidacaoTspCoa): String ;
    class procedure pAddOrReplaceDicionarioValidacao(const AstrMensagem: String;
                                                     const AInfo: TDadosValidacaoTspCoa;
                                                     var AdictMensagens: TDictPendenciasTspCoa) ;
    class procedure pValidaPlanoContasNaPlainiSaldo(const ADadosValidacao: TList<TDadosValidacaoTspCoa>;
                                                    var   AdictMensagens: TDictPendenciasTspCoa;
                                                    AcdsPlaini: TUniClientDataSet);
  public
    class function fValida(const ADadosValidacao: TList<TDadosValidacaoTspCoa>; const AprocErros: TErroContabilProc): Boolean;
    class procedure pValidaPlanoContasNaPlaini(const AstrCodEmp, AstrCompet, AstrContaContabil: String; var AstrMensagem: String); overload ;
  end ;

implementation

uses SysUtils, untFuncoesSimples, Vcl.Forms, Vcl.StdCtrls, strUtils,
     Contabilidade.Funcoes, System.Types,
     Contabilidade.Classes.TValidaContasContabeis, Math;

{ TImportacaoDadosContabeisTspCoa }

function TImportacaoDadosContabeisTspCoa.fGetNomeTabela: string;
begin
  Result := 'TSPCOA';
end;

function TImportacaoDadosContabeisTspCoa.fCarregaDadosPlanilha(
  const AprocErros: TErroContabilProc): boolean;
var
  intConLin : integer ;
  intUltimo : integer ;
  intQtdLinhas : integer ;
  LDadosValidacao: TList<TDadosValidacaoTspCoa> ;
begin
  pSetaTextoProgresso(pgbProgresso, 'Lendo Planilha: Transf. Saldos Plano Contas');
  result := False ;
  if not fValidaCabecalho then
    exit ;

  if not fQtdLinhas(intQtdLinhas) then
    exit ;

  pgbProgresso.Properties.Max := intQtdLinhas-1;

  SetLength(FarrTspCoa,0);
  For intConLin := fIndicePrimeiroRegistro To intQtdLinhas-1 Do
  Begin
    pgbProgresso.Position := intConLin;
    Application.ProcessMessages;

    SetLength(FarrTspCoa,Length(FarrTspCoa)+1);
    intUltimo := High(FarrTspCoa) ;
    FarrTspCoa[intUltimo].strCOA_COMPET := copy(fRetSomenteNumeros(fGetDadosCelula(0, intConLin, tdcStr)), 1, 6);
    FarrTspCoa[intUltimo].strCOA_CODEMP := copy(fGetDadosCelula(1, intConLin, tdcStr), 1, 3) ;
    FarrTspCoa[intUltimo].strCOA_PLAANT := copy(fGetDadosCelula(2, intConLin, tdcStr), 1, 40) ;
    FarrTspCoa[intUltimo].strCOA_INDSIT := copy(UpperCase(fGetDadosCelula(3, intConLin, tdcStr)), 1, 1) ;
    FarrTspCoa[intUltimo].fltCOA_VALLAN := fGetDadosCelula(4, intConLin, tdcFloat) ;
    FarrTspCoa[intUltimo].strCOA_PLANOV := copy(fSemMascaraPlaNco(fGetDadosCelula(5, intConLin, tdcStr)), 1, 20) ;
  End;

  if not FblnIgnorarErrosImportacao then
  begin
    if FMensagemErroDadosContabeis.fTemMensagemErro then
    begin
      if not FblnImportacaoOrquestrada then
        FMensagemErroDadosContabeis.pMostraMensagemErro(True) ;
      exit ;
    end;
  end;

  ///valida as informações carregadas no array
  LDadosValidacao := fConverteEstruturaParaValidacao(FarrTspCoa) ;
  try

    if not TValidaProcessoTspCoa.fValida(LDadosValidacao, AprocErros) then
      exit ;

  finally
    FreeAndNil(LDadosValidacao) ;
  end;

  result := True ;
end;


function TImportacaoDadosContabeisTspCoa.fConverteEstruturaParaValidacao(
  const AArr: array of TTspCoaInfo): TList<TDadosValidacaoTspCoa>;
var
  LintCnt: Integer ;
  LregItem: TDadosValidacaoTspCoa;
begin
  Result := TList<TDadosValidacaoTspCoa>.Create;
  for LintCnt := Low(AArr) to High(AArr) do
  begin
    FillChar(LregItem, sizeOf(LregItem), #0);
    LregItem.ACompet := AArr[LintCnt].strCOA_COMPET;
    LregItem.ACodemp := AArr[LintCnt].strCOA_CODEMP;
    LregItem.APlaant := AArr[LintCnt].strCOA_PLAANT;
    LregItem.AIndsit := AArr[LintCnt].strCOA_INDSIT;
    LregItem.AVallan := AArr[LintCnt].fltCOA_VALLAN;
    LregItem.APlanov := AArr[LintCnt].strCOA_PLANOV;
    Result.Add(LregItem);
  end;
end;

function TImportacaoDadosContabeisTspCoa.fGetSqlInsert: string;
begin
  result := 'INSERT INTO TSPCOA ' ;
  result := result + '(AUTOINCREM, ' ;
  result := result + ' COA_CODIGO, ' ;
  result := result + ' COA_CODEMP, ' ;
  result := result + ' COA_COMPET, ' ;
  result := result + ' COA_PLAANT, ' ;
  result := result + ' COA_PLANOV, ' ;
  result := result + ' COA_VALLAN, ' ;
  result := result + ' COA_INDSIT) ' ;
  result := result + 'VALUES ' ;
  result := result + '(:AUTOINCREM, ' ;
  result := result + ' :CODIGO, ' ;
  result := result + ' :CODEMP, ' ;
  result := result + ' :COMPET, ' ;
  result := result + ' :PLAANT, ' ;
  result := result + ' :PLANOV, ' ;
  result := result + ' :VALLAN, ' ;
  result := result + ' :INDSIT); ' ;
end;

function TImportacaoDadosContabeisTspCoa.fPersisteDados: boolean;
var
  intCnt : integer ;
  strAutoInc : string ;
  strMensagemErro : string ;
  blnAbortado : boolean ;
begin
  result := false ;
  blnAbortado := False ;
  pSetaTextoProgresso(pgbProgresso, 'Gravando Registros: Transf. Saldos Plano Contas');
  pgbProgresso.Properties.Max := Length(FarrTspCoa);

  pStartTransactionImportacao ;

  try
    pApagaDados ;

    FqryExec.Close ;
    FqryExec.SQL.Clear ;
    FqryExec.SQL.Text := fGetSqlInsert ;
    for intCnt := Low(FarrTspCoa) to High(FarrTspCoa) do
    begin
      try
        pgbProgresso.Position := intCnt+1;
        Application.ProcessMessages;
        //ignora a linha caso tenha dado problema na validação da planilha
        if not FMensagemErroDadosContabeis.fTemLinhaComErro(intCnt) then
        begin
          strAutoInc := fRetAutoIncrem('TSPCOA', VS_strCodEmp) ;
          FqryExec.ParamByName('AUTOINCREM').AsString := strAutoInc;
          FqryExec.ParamByName('CODIGO').AsString := fAtualizaProCod('TSPCOA', 'COA_CODIGO');
          FqryExec.ParamByName('CODEMP').AsString := FarrTspCoa[intCnt].strCOA_CODEMP ;
          FqryExec.ParamByName('COMPET').AsString := FarrTspCoa[intCnt].strCOA_COMPET ;
          FqryExec.ParamByName('PLAANT').AsString := FarrTspCoa[intCnt].strCOA_PLAANT ;
          FqryExec.ParamByName('PLANOV').AsString := FarrTspCoa[intCnt].strCOA_PLANOV ;
          FqryExec.ParamByName('VALLAN').AsFloat := FarrTspCoa[intCnt].fltCOA_VALLAN ;
          FqryExec.ParamByName('INDSIT').AsString := FarrTspCoa[intCnt].strCOA_INDSIT ;
          FqryExec.ExecSQL ;
        end;
      except
        on E1: Exception Do
        begin
          strMensagemErro := 'Problemas ao importar a linha '+inttostr(intCnt+2)+', erro: '+E1.Message ;
          if not FblnIgnorarErrosImportacao then
          begin
            blnAbortado := True ;
            raise Exception.Create(strMensagemErro);
          end
          else
          begin
            blnAbortado := False ;
            FMensagemErroDadosContabeis.pRegistraMensagemErro(strMensagemErro) ;
          end;
        end;
      end;
    end;

    pCommitImportacao ;

  Except
    On E2: Exception Do
    Begin
      pRollbackImportacao ;
      FMensagemErroDadosContabeis.pRegistraMensagemErro(E2.Message) ;
    End;
  End;

  if FMensagemErroDadosContabeis.fTemMensagemErro then
  begin
    FMensagemErroDadosContabeis.pMostraMensagemErro(blnAbortado, FblnImportacaoOrquestrada) ;
    exit ;
  end;

  pMensagemSucesso ;

  result := true ;
end;

procedure TImportacaoDadosContabeisTspCoa.pApagaDados;
var
  LlstEmpresaCompetencia: TStringList ;
  LstrEmpresaCompetencia: String ;
  LintCnt: Integer ;
  LarrEmpresaCompetencia: TStringDynArray ;
  LstrCodEmp, LstrCompet: String ;
  LqryConsulta: TUniQuery ;
begin
  LlstEmpresaCompetencia := TStringList.Create ;
  try
    LlstEmpresaCompetencia.Sorted := True ;
    for LintCnt := Low(FarrTspCoa) to High(FarrTspCoa) do
    begin
      LstrEmpresaCompetencia := FarrTspCoa[LintCnt].strCOA_CODEMP + ';' + FarrTspCoa[LintCnt].strCOA_COMPET ;
      if LlstEmpresaCompetencia.IndexOf(LstrEmpresaCompetencia) = -1 then
        LlstEmpresaCompetencia.Add(LstrEmpresaCompetencia) ;
    end ;

    LqryConsulta := fCriaQuery ;
    try
      LqryConsulta.Close ;
      LqryConsulta.SQL.Clear ;
      LqryConsulta.SQL.Add('DELETE FROM TSPCOA WHERE COA_CODEMP = :CODEMP AND COA_COMPET = :COMPET') ;

      for LintCnt := 0 to LlstEmpresaCompetencia.Count-1 do
      begin
        LarrEmpresaCompetencia := SplitString(LlstEmpresaCompetencia.Strings[LintCnt], ';') ;
        LstrCodEmp := LarrEmpresaCompetencia[0] ;
        LstrCompet := LarrEmpresaCompetencia[1] ;

        LqryConsulta.Close ;
        LqryConsulta.ParamByName('CODEMP').AsString := LstrCodEmp ;
        LqryConsulta.ParamByName('COMPET').AsString := LstrCompet ;
        LqryConsulta.ExecSQL ;
      end ;
    finally
      FreeAndNil(LqryConsulta) ;
    end ;
  finally
    FreeAndNil(LlstEmpresaCompetencia) ;
  end ;
end;

procedure TImportacaoDadosContabeisTspCoa.pCarregaInfoColunas;
begin
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('COMPETÊNCIA*', True)) ;
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('EMPRESA*', True)) ;
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CONTA ANALÍTICA DO PLANO DE CONTAS ANTERIOR*', True)) ;
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('D/C*', True)) ;
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('VALOR', False)) ;
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CONTA ANALÍTICA DO PLANO DE CONTAS NOVO*', True)) ;
end;

{ TValidaProcessoTspCoa }

class function TValidaProcessoTspCoa.fValida(
  const ADadosValidacao: TList<TDadosValidacaoTspCoa>;
  const AprocErros: TErroContabilProc): boolean;
var
  LdictMensagens: TDictPendenciasTspCoa ;
  LcdsPlaini: TUniClientDataSet ;
  LcdsPlanco: TUniClientDataSet ;
begin
  Result := False ;

  if not fVaiSobreporDados(ADadosValidacao) then
    Exit ;

  LcdsPlaini := fCarregaPlaini(ADadosValidacao) ;
  if not Assigned(LcdsPlaini) then
    Exit ;

  LcdsPlanco := fCarregaPlanco ;
  if not Assigned(LcdsPlanco) then
    Exit ;

  LdictMensagens := TDictPendenciasTspCoa.Create();
  try
    pValidaPlanoContasExiste(ADadosValidacao, LdictMensagens, LcdsPlanco) ;
    pValidaOutros(ADadosValidacao, LdictMensagens) ;
    pValidaPlanoContasNaPlaini(ADadosValidacao, LdictMensagens, LcdsPlaini) ;
    pValidaPlanoContasNaPlainiSaldo(ADadosValidacao, LdictMensagens, LcdsPlaini) ;

    if LdictMensagens.Count > 0 then
    begin
      pMostraMensagens(LdictMensagens, AprocErros) ;
      exit ;
    end ;

  finally
    FreeAndNil(LdictMensagens) ;
    FreeAndNil(LcdsPlaini) ;
  end ;

  Result := True ;
end;

class procedure TValidaProcessoTspCoa.pAddOrReplaceDicionarioValidacao(
  const AstrMensagem: String; const AInfo: TDadosValidacaoTspCoa;
  var AdictMensagens: TDictPendenciasTspCoa);
var
  LstrChaveMensagem: String ;
  LArrMensagens: TList<string> ;
begin
  LstrChaveMensagem := fMontaChaveDicionarioValidacao(AInfo) ;
  if not AdictMensagens.ContainsKey(LstrChaveMensagem) then
  begin
    LArrMensagens := TList<string>.Create;
    LArrMensagens.Add(AstrMensagem) ;
    AdictMensagens.Add(LstrChaveMensagem, LArrMensagens);
  end
  else
  begin
    LArrMensagens := AdictMensagens.Items[LstrChaveMensagem] ;
    if LArrMensagens.IndexOf(AstrMensagem) < 0 then
      LArrMensagens.Add(AstrMensagem) ;
  end ;
end;

class procedure TValidaProcessoTspCoa.pMostraMensagens(
  const AArrMensagens: TDictPendenciasTspCoa;
  const AprocErros: TErroContabilProc);
var
  LobjMensagens: TValidaContaContabil ;
  LregDoc: TContaErro ;
  LPair: TPair<string, TList<String>> ;
  LstrItem: String ;
begin
  LobjMensagens := TValidaContaContabil.Create ;
  try
    for LPair in AArrMensagens do
    begin
      for LstrItem in LPair.Value do
      begin
        LregDoc.strChaveDocumento := LPair.Key ;
        LregDoc.strMotivo := LstrItem ;
        LregDoc.strWarning := 'N' ;
        LobjMensagens.pAddErro(LregDoc, Nil);
      end ;
    end;

    if Assigned(AprocErros) then
      AprocErros(LobjMensagens.DataSet) ;

  finally
    FreeAndNil(LobjMensagens) ;
  end;
end;

class procedure TValidaProcessoTspCoa.pValidaOutros(
  const ADadosValidacao: TList<TDadosValidacaoTspCoa>;
  var AdictMensagens: TDictPendenciasTspCoa);
var
  LintCnt: Integer ;
  LstrValorMensagem: String ;
  LstrMes: String ;
begin

  for LintCnt := 0 to ADadosValidacao.Count-1 do
  begin
    if Length(ADadosValidacao[LintCnt].ACompet) <> 6 then
    begin
      LstrValorMensagem := 'Competência deve ter 6 digitos numéricos (MM/AAAA), verifique essa situação' ;
      pAddOrReplaceDicionarioValidacao(LstrValorMensagem, ADadosValidacao[LintCnt], AdictMensagens) ;
    end ;

    LstrMes := LeftStr(ADadosValidacao[LintCnt].ACompet, 2) ;
    if (StrToIntDef(LstrMes, 0) <= 0) or (StrToIntDef(LstrMes, 0) > 12) then
    begin
      LstrValorMensagem := 'Mês ['+LstrMes+'] competência inválido, verifique essa situação' ;
      pAddOrReplaceDicionarioValidacao(LstrValorMensagem, ADadosValidacao[LintCnt], AdictMensagens) ;
    end ;

  end ;
end;

class procedure TValidaProcessoTspCoa.pValidaPlanoContasExiste(
  const ADadosValidacao: TList<TDadosValidacaoTspCoa>;
  var AdictMensagens: TDictPendenciasTspCoa; AcdsPlanco: TUniClientDataSet);
var
  LintCnt: Integer ;
  LstrValorMensagem: String ;
begin

  for LintCnt := 0 to ADadosValidacao.Count-1 do
  begin
    if not AcdsPlanco.FindKey([ADadosValidacao[LintCnt].APlanov]) then
    begin
      LstrValorMensagem := 'Plano de contas não cadastrado, verifique essa situação' ;
      pAddOrReplaceDicionarioValidacao(LstrValorMensagem, ADadosValidacao[LintCnt], AdictMensagens) ;
    end ;
  end ;
end;

class procedure TValidaProcessoTspCoa.pValidaPlanoContasNaPlaini(
  const AstrCodEmp, AstrCompet, AstrContaContabil: String;
  var AstrMensagem: String);
var
  LDadosValidacao: TList<TDadosValidacaoTspCoa> ;
  LItemValidacao: TDadosValidacaoTspCoa ;
  LdictMensagens: TDictPendenciasTspCoa ;
  LstrMsg: TList<String> ;
  LstrItem: String ;
  LcdsPlaini: TUniClientDataSet ;
begin
  AstrMensagem := '' ;
  LcdsPlaini := Nil ;

  LDadosValidacao := TList<TDadosValidacaoTspCoa>.Create ;
  LdictMensagens := TDictPendenciasTspCoa.Create ;
  try
    FillChar(LItemValidacao, SizeOf(LItemValidacao), #0);
    LItemValidacao.ACompet := AstrCompet ;
    LItemValidacao.ACodemp := AstrCodEmp ;
    LItemValidacao.APlanov := AstrContaContabil ;

    LDadosValidacao.Add(LItemValidacao) ;
    LcdsPlaini := fCarregaPlaini(LDadosValidacao) ;

    pValidaPlanoContasNaPlainiInterno(LDadosValidacao, LdictMensagens, LcdsPlaini) ;

    if LdictMensagens.Count > 0 then
      for LstrMsg in LdictMensagens.Values do
      begin
        for LstrItem in LstrMsg do
        begin
          AstrMensagem := LstrItem ;
          Exit ;
        end ;
      End ;

  finally
    FreeAndNil(LDadosValidacao) ;
    FreeAndNil(LdictMensagens) ;
    if Assigned(LcdsPlaini) then
      FreeAndNil(LcdsPlaini) ;
  end ;
end;

class procedure TValidaProcessoTspCoa.pValidaPlanoContasNaPlainiInterno(
  const ADadosValidacao: TList<TDadosValidacaoTspCoa>;
  var AdictMensagens: TDictPendenciasTspCoa;
      AcdsPlaini: TUniClientDataSet);
var
  LintCnt: Integer ;
  LstrValorMensagem: String ;
begin

  for LintCnt := 0 to ADadosValidacao.Count-1 do
  begin
    if not AcdsPlaini.FindKey([ADadosValidacao[LintCnt].APlanov,
                               StrToInt(RightStr(ADadosValidacao[LintCnt].ACompet, 4)),
                               ADadosValidacao[LintCnt].ACodemp]) then
    begin
      LstrValorMensagem := 'Não existe Saldos Iniciais para essa Empresa, para a Competência informada, verifique essa situação' ;
      pAddOrReplaceDicionarioValidacao(LstrValorMensagem, ADadosValidacao[LintCnt], AdictMensagens) ;
    end ;
  end ;

end;

class procedure TValidaProcessoTspCoa.pValidaPlanoContasNaPlainiSaldo(
  const ADadosValidacao: TList<TDadosValidacaoTspCoa>;
  var AdictMensagens: TDictPendenciasTspCoa; AcdsPlaini: TUniClientDataSet);
var
  LdictTotalPorConta: TDictionary<String,Double> ;
  LintCnt: Integer ;
  LstrChaveDict: String ;
  LstrValorMensagem: String ;
  LfltValor: Double ;
  LstrValorPlanilha, LstrValorPlaini: String ;
begin
  LdictTotalPorConta := TDictionary<String,Double>.Create ;
  try
    for LintCnt := 0 to ADadosValidacao.Count-1 do
    begin
      LstrChaveDict := ADadosValidacao[LintCnt].APlanov + ';' +
                       RightStr(ADadosValidacao[LintCnt].ACompet, 4) + ';' +
                       ADadosValidacao[LintCnt].ACodemp ;

      if not LdictTotalPorConta.ContainsKey(LstrChaveDict) then
        LdictTotalPorConta.Add(LstrChaveDict, 0.00);

      LfltValor := IfThen(ADadosValidacao[LintCnt].AIndsit = 'C', -ADadosValidacao[LintCnt].AVallan, ADadosValidacao[LintCnt].AVallan) ;
      LdictTotalPorConta.Items[LstrChaveDict] := LdictTotalPorConta.Items[LstrChaveDict] + fFormataFloat(LfltValor, 2) ;
    end ;


    for LintCnt := 0 to ADadosValidacao.Count-1 do
    begin

      if AcdsPlaini.FindKey([ADadosValidacao[LintCnt].APlanov,
                                 StrToInt(RightStr(ADadosValidacao[LintCnt].ACompet, 4)),
                                 ADadosValidacao[LintCnt].ACodemp]) then
      begin

        LstrChaveDict := ADadosValidacao[LintCnt].APlanov + ';' +
                         RightStr(ADadosValidacao[LintCnt].ACompet, 4) + ';' +
                         ADadosValidacao[LintCnt].ACodemp ;

        LfltValor := IfThen(AcdsPlaini.FieldByName('INI_CREDEB').AsString = 'C', -AcdsPlaini.FieldByName('INI_SALINI').AsFloat, AcdsPlaini.FieldByName('INI_SALINI').AsFloat) ;
        if fFormataFloat(LdictTotalPorConta.Items[LstrChaveDict], 2) <> fFormataFloat(LfltValor, 2) then
        begin
          LstrValorPlanilha := FormatFloat('#,##0.00', Abs(LdictTotalPorConta.Items[LstrChaveDict]) ) + IfThen(LdictTotalPorConta.Items[LstrChaveDict] < 0.00, 'C', 'D') ;
          LstrValorPlaini := FormatFloat('#,##0.00', Abs(LfltValor) ) + IfThen(LfltValor < 0.00, 'C', 'D') ;
          LstrValorMensagem := 'Divergência entre os valores da Planilha(' + LstrValorPlanilha + ') e Plaini(' + LstrValorPlaini + '), verifique essa situação' ;
          pAddOrReplaceDicionarioValidacao(LstrValorMensagem, ADadosValidacao[LintCnt], AdictMensagens) ;
        end ;

      end ;

    end ;

  finally
    FreeAndNil(LdictTotalPorConta) ;
  end ;
end;

class procedure TValidaProcessoTspCoa.pValidaPlanoContasNaPlaini(
  const ADadosValidacao: TList<TDadosValidacaoTspCoa>;
  var AdictMensagens: TDictPendenciasTspCoa;
      AcdsPlaini: TUniClientDataSet);
begin
  pValidaPlanoContasNaPlainiInterno(ADadosValidacao, AdictMensagens, AcdsPlaini) ;
end;

class function TValidaProcessoTspCoa.fCarregaPlaini(
  const ADadosValidacao: TList<TDadosValidacaoTspCoa>): TUniClientDataSet;
var
  LlstEmpresaCompetencia: TStringList ;
  LstrEmpresaCompetencia: String ;
  LintCnt: Integer ;
  LarrEmpresaCompetencia: TStringDynArray ;
  LstrCodEmp, LstrCompet: String ;
  LqryPlaini: TUniQuery ;
  LcdsPlaini: TUniClientDataSet ;
begin
  Result := Nil ;
  LlstEmpresaCompetencia := TStringList.Create ;
  try
    LlstEmpresaCompetencia.Sorted := True ;
    for LintCnt := 0 to ADadosValidacao.Count-1 do
    begin
      LstrEmpresaCompetencia := ADadosValidacao[LintCnt].ACodemp + ';' + RightStr(ADadosValidacao[LintCnt].ACompet, 4) ;
      if LlstEmpresaCompetencia.IndexOf(LstrEmpresaCompetencia) = -1 then
        LlstEmpresaCompetencia.Add(LstrEmpresaCompetencia) ;
    end ;

    LstrCodEmp := '' ;
    LstrCompet := '' ;
    for LintCnt := 0 to LlstEmpresaCompetencia.Count-1 do
    begin
      LarrEmpresaCompetencia := SplitString(LlstEmpresaCompetencia.Strings[LintCnt], ';') ;
      LstrCodEmp := LstrCodEmp + IfThen(fEmptyStr(LstrCodEmp), fQuotedStr(LarrEmpresaCompetencia[0]), ',' + fQuotedStr(LarrEmpresaCompetencia[0])) ;
      LstrCompet := LstrCompet + IfThen(fEmptyStr(LstrCompet), LarrEmpresaCompetencia[1], ',' + LarrEmpresaCompetencia[1]) ;
    end ;

    if not fEmptyStr(LstrCodEmp) then
    begin

      LqryPlaini := fCriaQuery() ;
      try
        LqryPlaini.Close ;
        LqryPlaini.SQL.Clear ;
        LqryPlaini.SQL.Add('SELECT INI_CODCON, INI_EXERCI, INI_CODEMP, INI_SALINI, INI_CREDEB FROM PLAINI ') ;
        LqryPlaini.SQL.Add('WHERE INI_CODEMP IN (' + LstrCodEmp + ') AND INI_EXERCI IN (' + LstrCompet + ') ') ;
        LqryPlaini.Open ;

        LcdsPlaini := fCriaClientDatset(LqryPlaini) ;

        LcdsPlaini.IndexFieldNames := 'INI_CODCON;INI_EXERCI;INI_CODEMP' ;

        Result := LcdsPlaini ;

      finally
        FreeAndNil(LqryPlaini) ;
      end ;

    end ;

  finally
    FreeAndNil(LlstEmpresaCompetencia) ;
  end ;

end;

class function TValidaProcessoTspCoa.fCarregaPlanco: TUniClientDataSet;
var
  LqryPlanco: TUniQuery ;
begin

  LqryPlanco := fCriaQuery() ;
  try
    LqryPlanco.Close ;
    LqryPlanco.SQL.Clear ;
    LqryPlanco.SQL.Add(' SELECT DISTINCT NCO_CODCON') ;
    LqryPlanco.SQL.Add(' FROM PLANCO') ;
    LqryPlanco.SQL.Add(' WHERE CURRENT_DATE BETWEEN COALESCE(NCO_DTAINI, CAST("2000-01-01" AS DATE)) AND COALESCE(NCO_DTAFIN, CAST("9999-01-01" AS DATE)) ') ;
    LqryPlanco.Open ;

    Result := fCriaClientDatset(LqryPlanco) ;

    Result.IndexFieldNames := 'NCO_CODCON' ;

  finally
    FreeAndNil(LqryPlanco) ;
  end ;
end;

class function TValidaProcessoTspCoa.fMascaraCompetencia(
  const AstrCompet: String): String;
begin
  Result := LeftStr(AstrCompet, 2) + '-' + RightStr(AstrCompet, 4) ;
end;

class function TValidaProcessoTspCoa.fMontaChaveDicionarioValidacao(
  const AInfo: TDadosValidacaoTspCoa): String;
begin
  Result :=  'Conta/Empresa/Exercicio:' + AInfo.APlanov + '/' + AInfo.ACodemp + '/' + RightStr(AInfo.ACompet, 4) ;
end;

class function TValidaProcessoTspCoa.fVaiSobreporDados(
  const ADadosValidacao: TList<TDadosValidacaoTspCoa>): Boolean;
var
  LlstEmpresaCompetencia: TStringList ;
  LstrEmpresaCompetencia: String ;
  LintCnt: Integer ;
  LarrEmpresaCompetencia: TStringDynArray ;
  LstrCodEmp, LstrCompet: String ;
  LqryConsulta: TUniQuery ;
  LblnPerguntaSobrepor: Boolean ;
begin
  Result := False ;
  LblnPerguntaSobrepor := False ;
  LlstEmpresaCompetencia := TStringList.Create ;
  try
    LlstEmpresaCompetencia.Sorted := True ;
    for LintCnt := 0 to ADadosValidacao.Count-1 do
    begin
      LstrEmpresaCompetencia := ADadosValidacao[LintCnt].ACodemp + ';' + ADadosValidacao[LintCnt].ACompet ;
      if LlstEmpresaCompetencia.IndexOf(LstrEmpresaCompetencia) = -1 then
        LlstEmpresaCompetencia.Add(LstrEmpresaCompetencia) ;
    end ;

    LqryConsulta := fCriaQuery ;
    try
      LqryConsulta.Close ;
      LqryConsulta.SQL.Clear ;
      LqryConsulta.SQL.Add('SELECT COUNT(*) AS CNT FROM TSPCOA WHERE COA_CODEMP = :CODEMP AND COA_COMPET = :COMPET') ;

      for LintCnt := 0 to LlstEmpresaCompetencia.Count-1 do
      begin
        LarrEmpresaCompetencia := SplitString(LlstEmpresaCompetencia.Strings[LintCnt], ';') ;
        LstrCodEmp := LarrEmpresaCompetencia[0] ;
        LstrCompet := LarrEmpresaCompetencia[1] ;

        LqryConsulta.Close ;
        LqryConsulta.ParamByName('CODEMP').AsString := LstrCodEmp ;
        LqryConsulta.ParamByName('COMPET').AsString := LstrCompet ;
        LqryConsulta.Open ;

        if LqryConsulta.FieldByName('CNT').AsInteger > 0 then
        begin
          LblnPerguntaSobrepor := True ;
          Break
        end ;

      end ;

      if LblnPerguntaSobrepor then
      begin

        if fMensagem('ATENÇÃO!', 'Existem saldos de plano de contas anterior '+#13+#10+
                                 'vinculados ao plano de contas atual '+#13+#10+
                                 'para a empresa e competência ('+LstrCodEmp+'/'+fMascaraCompetencia(LstrCompet)+') informados,'+#13+#10+
                                 'se prosseguir todos os dados serão sobrepostos.'+#13+#10+
                                 'Deseja prosseguir com a sobreposição dos dados?', ['&Sim', '&Não'], 1) = 2 then
        begin
          Exit;
        end;

      end ;


    finally
      FreeAndNil(LqryConsulta) ;
    end ;
  finally
    FreeAndNil(LlstEmpresaCompetencia) ;
  end ;
  Result := True ;
end;

end.
