unit Contabilidade.Classes.ApuracaoLucroRealLalurLacs;

interface

uses Data.DB, MemDS, DBAccess, Uni, Contabilidade.Interfaces, cxProgressBar,
     Datasnap.DBClient, UniClientDataSet, System.Generics.Collections,
     cxDropDownEdit, Classes ;

type
  TDadosAPUPRE = record
    strAUTOINCREM: string ;
    dtaPRE_DTAINI: TDateTime ;
    dtaPRE_DTAFIN: TDateTime ;
    fltPRE_VRANRE: double ;
    fltPRE_VRLAIR: double ;
    strPRE_CODEMP: string ;
    strPRE_CODPRE: string ;
  end;

  TDadosAPUARE = record
    strAUTOINCREM: string ;
    strARE_CODVRE: string ;
    dtaARE_DTALAN: TDate ;
    intARE_HISPAD: integer ;
    strARE_HISTOR: string ;
    strARE_EMPLAN: string ;
    fltARE_VALLAN: double ;
    strARE_CODCON: string ;
    strARE_TPLACO: string ;
    strARE_CREDEB: string ;
  end;

  TDadosAPUCDE = record
    strAUTOINCREM: string ;
    strCDE_CODCRE: string ;
    fltCDE_OPEANT: double ;
    strCDE_CTACON: string ;
    strCDE_TIPSLD: string ;
    fltCDE_VALLAN: double ;
  end;

  TarrDadosAPUCDE = array of TDadosAPUCDE ;

  TDadosAPUCRE = record
    strAUTOINCREM: string ;
    strCRE_CODVRE: string ;
    fltCRE_PERMAX: double ;
    strCRE_LANCAR: string ;
    regCRE_APUCDE: TarrDadosAPUCDE ;
  end;

  TValoresApuracao = record
    fltLucroAntes: double ;
    fltAdicoes: double ;
    fltExclusoes: double ;
    fltBcAntesCompensacao: double ;
    fltCompensacaoBCNegativa: double ;
    fltBaseCalculo: double ;
    strLancarCompensacao: string ;
  end;

  procedure pCarregaApuracao(var AQryApuracao: TUniQuery);
  function fValidaRegistroSelecionado(const AQryApuracao: TUniQuery): Boolean;
  function fIncluiAlteraApuracao(var ABlnModoIncluir: boolean; const AQryApuracao: TUniQuery): Boolean;
  function fPersisteApuracao(const ARegDados: TDadosAPUPRE; var AStrCodPre: string): boolean;
  function fExcluiApuracao(const AStrAutoInc: string): boolean ;
  function fValidarExercicioInformado(const AStrExercicio, AStrCodEmp: string; var AftForma: TFormaTributacao; var AecEncerramento: TEncerramentoContabil): boolean;
  function fPeriodoJaCadastrado(const AStrAutoInc: string; const AStrCodEmp: string; const ADtaPeriodoFinal: TDateTime): boolean;
  function fPersisteApuracaoAjustes(const ARegDados: TDadosAPUARE): boolean;
  procedure pCarregaDadosAjustes(var AQryAjuste: TUniQuery; const AStrCodigo: string; const ADtaIni, ADtaFin: TDateTime; const AllTipo: TLacsLalur; const AecEncerramento: TEncerramentoContabil; const AstrCodEmp: String);
  function fPersisteApuracaoCompensacao(const ARegDados: TDadosAPUCRE; const ADtaLancamento: TDateTime; const AllTipo: TLacsLalur; AdictValores: TDictionary<String, double>; const AstrCodEmp: String): boolean;
  function fPersisteApuracaoValores(const ARegValores: TValoresApuracao; const AStrCodigo: string; const AllTipo: TLacsLalur; const ADtaLancamento: TDateTime; const AecEncerramento: TEncerramentoContabil; const AstrContaControladaBaseNegativa, AstrCodEmp: string):boolean ;
  function fRetornaEncerramentoContabil(const AStrCodEmp, aStrExercicio: string):TEncerramentoContabil ;
  function fRetornaEmpresaMatrizFilial(const AStrCodEmp: string): string ;
  function fGerarAjustes(const AStrCodigo: string; const ADtaIni, ADtaFin: TDateTime; AllTipo: TLacsLalur; APgbProgresso: TcxProgressBar; const AecEncerramento: TEncerramentoContabil; const AstrCodEmp: String): Boolean ;
  function fValidaRegistroSelecionadoAjustes(const AQryApuracao: TUniQuery): Boolean;
  function fExcluiApuracaoAjustes(const AStrAutoInc: string): boolean;
  function fPodeAlterar(const AQryApuracao: TUniQuery): boolean;
  function fCarregaHistoricoPadrao(const ACodigo: string; const AstrCodEmp: string = ''):string ;
  procedure pAtualizaInfoNaturezaAjuste(const AStrConta, AStrTpLaCo: string; var AStrCodAju, AStrDesAju, AStrTipAju: string);
  function fContaContabilJaCadastrada(const AStrAutoInc: string; const AStrCodAjuste, AStrCodConta: string): boolean;
  function fConfiguraAjustes(const AStrCodigoApuracaoLalur, AStrCodigoApuracaoLacs: string; const AllTipo: TLacsLalur; const ADtaVigenciaInicial, ADtaVigenciaFinal: TDateTime; const AecEncerramento: TEncerramentoContabil; const AstrCodEmp: String): boolean;
  function fConfiguraCompensacao(const AStrCodigoApuracao: string; const AllTipo: TLacsLalur; const AFltAntesCompBaseNegativa: double; const ADtaVigenciaInicial, ADtaVigenciaFinal: TDateTime; const AstrCodEmp: String): boolean ;
  function fCarregaApuracao(const AStrCodPre: string; const AllTipo: TLacsLalur; var ACdsApuracao: TUniClientDataSet): string;
  function fIncluirApuracao(const AStrCodPre: string; const AllTipo: TLacsLalur): boolean;
  procedure pProcessaCalculosApuracao(const AStrCodPre: string; const AllTipo: TLacsLalur; var ARegValores: TValoresApuracao; var ACdsResumoAdicoes, ACdsResumoExclusoes, ACdsCompensacoes: TUniClientDataSet; const AecEncerramento: TEncerramentoContabil; const AstrCodEmp: String);
  procedure pResumoAdicaoExclusao( var ACdsResumo: TUniClientDataSet; const AQryApuracao: TUniQuery);
  procedure pCriaEstruturaResumoApuracao(var ACdsResumoAdicoes, ACdsResumoExclusoes, ACdsCompensacoes: TUniClientDataSet);
  procedure pCarregaCompensacao(var AqryApucre: TUniQuery; const AStrCodigo: string);
  procedure pRetornaSaldoCompesacao(const AdtaVigenciaInicial: TDateTime; const AllTipo: TLacsLalur; var AfltOperacionalOuBaseNegativa, AfltNaoOperacional: double; const AstrCodEmp: String);
  procedure pCarregaQueryOperacional(var AqryConsulta: TUniquery;const AllTipo: TLacsLalur) ;
  procedure pCarregaQueryNaoOperacional(var AqryConsulta: TUniquery;const AllTipo: TLacsLalur) ;
  function fCalculaCompensacaoBcNegativa(const AfltPercentual, AfltBCAntesCompensacao, AfltOPEANT: double): double ;
  procedure pRetornaResumoCompesacao(const AdtaVigenciaInicial: TDateTime; const AllTipo: TLacsLalur; var AcdsRetornoOperacional, AcdsRetornoNaoOperacional: TUniClientDataSet; const AstrCodEmp: String);
  procedure pCriaEstruturaACompensar(var AcdsCompensacoes: TUniClientDataSet);
  function fLancaCompensacaoDebito(const AstrCodVre, AstrLancar: string; const AdictValores: TDictionary<String, double>; const ADtaLancamento: TDateTime; const AllTipo: TLacsLalur; const AstrCodEmp: String):boolean;
  procedure pCarregaACompensarInformado(var AcdsCompensacoes: TUniClientDataSet; const AstrAutoIncCompensacao: string);
  function fRetornaContaControladaBCNegativa(const AblnPodeLancar: boolean; const AllTipo: TLacsLalur):string ;
  function fEstornaCompensacao(const AstrCRE_CODVRE: string):boolean ;
  function fAcumulaSaldoCompensacao(const AstrCredDeb: string; const AfltSaldo, AfltValLan: double):double ;
  procedure pAjustaPeriodoEncerramento(const AStrExercicio: string; const AecEncerramento: TEncerramentoContabil; var AedtPeriodo: TcxComboBox);
  procedure pPeriodoEncerramento(const AStrExercicio: string; const AecEncerramento: TEncerramentoContabil; var AlstPeriodo: TStrings) ;
  procedure pLimparPeriodoEncerramento(var AedtPeriodo: TcxComboBox);
  procedure pLimparInstanciasPeriodoEncerramento(var AlstPeriodo: TStrings) ;
  function fRetornaProximoCodigoCTACON:string ;
  function fCarregaResultadoAntesContribuicaoSocial(const AstrCodEmp: String; const AdtaIni, AdtaFin: TDateTime): Double ;


implementation

uses untFuncoesSimples, Contabilidade.View.ApuracaoLucroRealLalurLacsAlterar,
     System.SysUtils, DateUtils, Vcl.Controls, Contabilidade.View.ApuracaoLucroRealLalurLacsApuracao,
     Variants, Vcl.Forms, Contabilidade.View.ApuracaoLucroRealLalurLacsAjustes, Contabilidade.View.ApuracaoLucroRealLalurLacsCompensacao,
     Contabilidade.View.ApuracaoLucroRealLalurLacsCompensacaoMult, Contabilidade.View.ApuracaoLucroRealLalurLacsPesqCtaCon,
     Contabilidade.View.ContasControladas, Contabilidade.Funcoes.ImpostoRenda, Contabilidade.Funcoes, strUtils;

function fMontaStringSqlResultadoAntesContribuicaoSocial(const AstrColuna, AstrDigito: String; AintTamDig: Integer; AstrStringSql: String): String;
begin
  Result := AstrStringSql ;
  if AintTamDig > 0 then
  begin
    Result := Result + IfThen(Trim(Result) = '', '', ' OR ') + ' SUBSTR(' + AstrColuna + ', 1, ' + IntToStr(AintTamDig) + ') = "' + AstrDigito + '" ' ;
  end ;
end ;

function fCarregaResultadoAntesContribuicaoSocial(const AstrCodEmp: String; const AdtaIni, AdtaFin: TDateTime): Double ;
var
  LqryCarrega: TUniQuery ;
  LstrDigCus, LstrDigRec, LstrDigDes: String ;
  LintTamanhoDigCus, LintTamanhoDigRec, LintTamanhoDigDes: Integer ;
  LstrStringCredito, LstrStringDebito: String ;
  LStrEmpresas: String ;
begin
  LstrDigCus := Trim(fCfgDigcus) ;
  LstrDigRec := Trim(fCfgDigRec) ;
  LstrDigDes := Trim(fCfgDigDes) ;
  LintTamanhoDigCus := Length(LstrDigCus) ;
  LintTamanhoDigRec := Length(LstrDigRec) ;
  LintTamanhoDigDes := Length(LstrDigDes) ;

  LstrStringCredito := '' ;
  LstrStringCredito := fMontaStringSqlResultadoAntesContribuicaoSocial('CON_CONCRE', LstrDigCus, LintTamanhoDigCus, LstrStringCredito) ;
  LstrStringCredito := fMontaStringSqlResultadoAntesContribuicaoSocial('CON_CONCRE', LstrDigRec, LintTamanhoDigRec, LstrStringCredito) ;
  LstrStringCredito := fMontaStringSqlResultadoAntesContribuicaoSocial('CON_CONCRE', LstrDigDes, LintTamanhoDigDes, LstrStringCredito) ;
  LstrStringCredito := LstrStringCredito + IfThen(Trim(LstrStringCredito) = '', 'TRUE', '') ;

  LstrStringDebito := '' ;
  LstrStringDebito := fMontaStringSqlResultadoAntesContribuicaoSocial('CON_CONDEB', LstrDigCus, LintTamanhoDigCus, LstrStringDebito) ;
  LstrStringDebito := fMontaStringSqlResultadoAntesContribuicaoSocial('CON_CONDEB', LstrDigRec, LintTamanhoDigRec, LstrStringDebito) ;
  LstrStringDebito := fMontaStringSqlResultadoAntesContribuicaoSocial('CON_CONDEB', LstrDigDes, LintTamanhoDigDes, LstrStringDebito) ;
  LstrStringDebito := LstrStringDebito + IfThen(Trim(LstrStringDebito) = '', 'TRUE', '') ;

  LqryCarrega := fCriaQuery() ;
  try

    LStrEmpresas := fRetornaEmpresaMatrizFilial(AstrCodEmp) ;

    LqryCarrega.Close ;
    LqryCarrega.SQL.Clear ;
    LqryCarrega.SQL.Add(' SELECT SUM(COALESCE(DEBITO, 0.00)+COALESCE(CREDITO, 0.00)) AS VALOR FROM ( ') ;
    LqryCarrega.SQL.Add(' 	SELECT CON_CONCRE, CON_CONDEB, CON_VALLAN, ') ;
    LqryCarrega.SQL.Add(' 	       CASE WHEN ' + LstrStringCredito + ' THEN CON_VALLAN ELSE 0.00 END AS CREDITO, ') ;
    LqryCarrega.SQL.Add(' 	       CASE WHEN ' + LstrStringDebito + ' THEN -CON_VALLAN ELSE 0.00 END AS DEBITO ') ;
    LqryCarrega.SQL.Add(' 	FROM LANCON ') ;
    LqryCarrega.SQL.Add(' 	WHERE LANCON.CON_TIPLAN <> "FEC" ') ;
    LqryCarrega.SQL.Add(' 		AND CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ') ;
    LqryCarrega.SQL.Add(' 		AND CON_EMPLAN IN (' + LStrEmpresas + ') ') ;
    LqryCarrega.SQL.Add(' ) AS SEL ') ;
    LqryCarrega.ParamByName('DTAINI').AsDateTime := AdtaIni ;
    LqryCarrega.ParamByName('DTAFIN').AsDateTime := AdtaFin ;
    LqryCarrega.Open ;

    Result := LqryCarrega.FieldByName('VALOR').AsFloat ;

  finally
    FreeAndNil(LqryCarrega) ;
  end ;
end ;

function fRetornaProximoCodigoCTACON:string ;
var
  LqryProxCodigo: TUniQuery ;
begin
  LqryProxCodigo := fCriaQuery() ;
  try
    LqryProxCodigo.Close ;
    LqryProxCodigo.SQL.Clear ;
    LqryProxCodigo.SQL.Add('SELECT LPAD(CAST(CAST(COALESCE(MAX(CTA_CODCON), "0") AS SIGNED)+1 AS CHAR(5)), 5, "0") AS CTA_CODCON FROM CTACON') ;
    LqryProxCodigo.Open ;
    result := LqryProxCodigo.Fields.Fields[0].AsString ;
  finally
    FreeAndNil(LqryProxCodigo) ;
  end ;
end ;

procedure pCarregaApuracao(var AQryApuracao: TUniQuery);
begin
  AQryApuracao.Close ;
  AQryApuracao.SQL.Clear ;
  AQryApuracao.SQL.Add(' SELECT APUPRE.PRE_CODPRE, APUPRE.PRE_DTAINI, APUPRE.PRE_DTAFIN, APUPRE.PRE_CODEMP, CADEMP.EMP_NOMEMP, APUPRE.AUTOINCREM, APUPRE.PRE_VRANRE, APUPRE.PRE_VRLAIR ') ;
  AQryApuracao.SQL.Add(' FROM APUPRE INNER JOIN CADEMP ON APUPRE.PRE_CODEMP = CADEMP.EMP_CODEMP ') ;
  AQryApuracao.SQL.Add(' ORDER BY PRE_DTAINI, PRE_DTAFIN ') ;
  AQryApuracao.Open ;
end;


function fValidaRegistroSelecionado(const AQryApuracao: TUniQuery): Boolean;
begin
  result := False ;
  if not AQryApuracao.Active then
  begin
    exit ;
  end;

  if AQryApuracao.IsEmpty then
  begin
    fMensagem('ATENÇÃO!', 'Registro não selecionado!', ['&Ok']);
    exit ;
  end;

  result := True ;
end;

function fIncluiAlteraApuracao(var ABlnModoIncluir: boolean; const AQryApuracao: TUniQuery): Boolean;
var
  LfrmApuracaoLucroRealLalurLacsAlterar : TfrmApuracaoLucroRealLalurLacsAlterar ;
  LfrmApuracaoLucroRealLalurLacsApuracao : TfrmApuracaoLucroRealLalurLacsApuracao ;
  LregDados: TDadosAPUPRE ;
  LStrCodPre: string ;
begin
  result := False ;
  pCriarFormularios(TfrmApuracaoLucroRealLalurLacsAlterar, LfrmApuracaoLucroRealLalurLacsAlterar) ;
  try
    if not ABlnModoIncluir then
    begin
      LfrmApuracaoLucroRealLalurLacsAlterar.AutoInc := AQryApuracao.FieldByName('AUTOINCREM').AsString ;
      LfrmApuracaoLucroRealLalurLacsAlterar.edtEmpSel.Text := AQryApuracao.FieldByName('PRE_CODEMP').AsString ;
      LfrmApuracaoLucroRealLalurLacsAlterar.edtNomEmpSel.Text := AQryApuracao.FieldByName('EMP_NOMEMP').AsString ;
      LfrmApuracaoLucroRealLalurLacsAlterar.edtResultadoAntesCS.Value := fCarregaResultadoAntesContribuicaoSocial(
                                                                         AQryApuracao.FieldByName('PRE_CODEMP').AsString,
                                                                         AQryApuracao.FieldByName('PRE_DTAINI').AsDateTime,
                                                                         AQryApuracao.FieldByName('PRE_DTAFIN').AsDateTime) ;
      LfrmApuracaoLucroRealLalurLacsAlterar.edtContribuicaoAntesLAIR.Value := AQryApuracao.FieldByName('PRE_VRLAIR').AsFloat ;
      LfrmApuracaoLucroRealLalurLacsAlterar.edtExercicio.Text := IntToStr(YearOf(AQryApuracao.FieldByName('PRE_DTAINI').AsDateTime)) ;
      LfrmApuracaoLucroRealLalurLacsAlterar.pAjustaDadosPeriodoParaEdicao(AQryApuracao.FieldByName('PRE_DTAINI').AsDateTime, AQryApuracao.FieldByName('PRE_DTAFIN').AsDateTime) ;
      LfrmApuracaoLucroRealLalurLacsAlterar.edtExercicio.Enabled := False ;
      LfrmApuracaoLucroRealLalurLacsAlterar.edtPeriodo.Enabled := False ;
      LfrmApuracaoLucroRealLalurLacsAlterar.edtEmpSel.Enabled := False ;
    end;

    if LfrmApuracaoLucroRealLalurLacsAlterar.ShowModal = mrOk then
    begin
      if ABlnModoIncluir then
      begin
        LregDados.strAUTOINCREM := '' ;
        LregDados.strPRE_CODPRE := '' ;
      end
      else
      begin
        LregDados.strAUTOINCREM := AQryApuracao.FieldByName('AUTOINCREM').AsString ;
        LregDados.strPRE_CODPRE := AQryApuracao.FieldByName('PRE_CODPRE').AsString ;
      end;

      LregDados.dtaPRE_DTAINI := LfrmApuracaoLucroRealLalurLacsAlterar.DataInicioApuracao ;
      LregDados.dtaPRE_DTAFIN := LfrmApuracaoLucroRealLalurLacsAlterar.DataFinalApuracao ;
      LregDados.fltPRE_VRANRE := LfrmApuracaoLucroRealLalurLacsAlterar.edtResultadoAntesCS.Value ;
      LregDados.fltPRE_VRLAIR := LfrmApuracaoLucroRealLalurLacsAlterar.edtContribuicaoAntesLAIR.Value ;
      LregDados.strPRE_CODEMP := LfrmApuracaoLucroRealLalurLacsAlterar.edtEmpSel.Text ;
      Result := fPersisteApuracao(LregDados, LStrCodPre) ;
      ///chama a tela de apuração.
      LfrmApuracaoLucroRealLalurLacsApuracao := TfrmApuracaoLucroRealLalurLacsApuracao.Create(Nil) ;
      try
        LfrmApuracaoLucroRealLalurLacsApuracao.FormaTributacao := LfrmApuracaoLucroRealLalurLacsAlterar.FormaTributacao ;
        LfrmApuracaoLucroRealLalurLacsApuracao.EncerramentoContabil := LfrmApuracaoLucroRealLalurLacsAlterar.EncerramentoContabil ;
        LfrmApuracaoLucroRealLalurLacsApuracao.edtDataInicio.Date := LregDados.dtaPRE_DTAINI ;
        LfrmApuracaoLucroRealLalurLacsApuracao.edtDataFin.Date := LregDados.dtaPRE_DTAFIN ;
        LfrmApuracaoLucroRealLalurLacsApuracao.LucroAntesCssl := LregDados.fltPRE_VRANRE ;
        LfrmApuracaoLucroRealLalurLacsApuracao.LucroAntesIrpj := LregDados.fltPRE_VRLAIR ;
        LfrmApuracaoLucroRealLalurLacsApuracao.CodPre := LStrCodPre ;
        LfrmApuracaoLucroRealLalurLacsApuracao.CodEmp := LfrmApuracaoLucroRealLalurLacsAlterar.edtEmpSel.Text ;
        if LfrmApuracaoLucroRealLalurLacsApuracao.ShowModal = mrOK then
        begin
          //salva a base de calculo e lança as compensações caso tenha.
          fPersisteApuracaoValores(LfrmApuracaoLucroRealLalurLacsApuracao.ValoresLacs,
                                   LfrmApuracaoLucroRealLalurLacsApuracao.CodigoValoresLacs,
                                   llLacs,
                                   LregDados.dtaPRE_DTAFIN,
                                   LfrmApuracaoLucroRealLalurLacsApuracao.EncerramentoContabil,
                                   LfrmApuracaoLucroRealLalurLacsApuracao.ContaControladaBaseNegativaLacs,
                                   LfrmApuracaoLucroRealLalurLacsAlterar.edtEmpSel.Text) ;

          fPersisteApuracaoValores(LfrmApuracaoLucroRealLalurLacsApuracao.ValoresLalur,
                                   LfrmApuracaoLucroRealLalurLacsApuracao.CodigoValoresLalur,
                                   llLalur,
                                   LregDados.dtaPRE_DTAFIN,
                                   LfrmApuracaoLucroRealLalurLacsApuracao.EncerramentoContabil,
                                   LfrmApuracaoLucroRealLalurLacsApuracao.ContaControladaBaseNegativaLalur,
                                   LfrmApuracaoLucroRealLalurLacsAlterar.edtEmpSel.Text) ;
          //
        end;
      finally
        pFreeAndNil(LfrmApuracaoLucroRealLalurLacsApuracao) ;
      end;
      ///
    end;
  finally
    pFreeAndNil(LfrmApuracaoLucroRealLalurLacsAlterar);
  end;
end;

function fPersisteApuracao(const ARegDados: TDadosAPUPRE; var AStrCodPre: string): boolean;
var
  LQryExec: TUniQuery ;
  LstrSql: string ;
begin
  LstrSql := '' ;
  AStrCodPre := '' ;
  fStartTransaction;
  try
    LQryExec := fCriaQuery ;
    try
      LQryExec.Close ;
      LQryExec.SQL.Clear ;
      if fEmptyStr(ARegDados.strAUTOINCREM) then /// incluir
      begin
        LstrSql :=           ' INSERT INTO APUPRE ' ;
        LstrSql := LstrSql + '       (AUTOINCREM, ' ;
        LstrSql := LstrSql + '        PRE_DTAINI, ' ;
        LstrSql := LstrSql + '        PRE_DTAFIN, ' ;
        LstrSql := LstrSql + '        PRE_VRANRE, ' ;
        LstrSql := LstrSql + '        PRE_VRLAIR, ' ;
        LstrSql := LstrSql + '        PRE_CODEMP, ' ;
        LstrSql := LstrSql + '        PRE_CODPRE) VALUES ' ;
        LstrSql := LstrSql + '       (:AUTOINCREM, ' ;
        LstrSql := LstrSql + '        :DTAINI, ' ;
        LstrSql := LstrSql + '        :DTAFIN, ' ;
        LstrSql := LstrSql + '        :VRANRE, ' ;
        LstrSql := LstrSql + '        :VRLAIR, ' ;
        LstrSql := LstrSql + '        :CODEMP, ' ;
        LstrSql := LstrSql + '        :CODPRE) ; ' ;
        LQryExec.SQL.Add(LstrSql) ;
        //gera os codigo
        LQryExec.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('APUPRE', VS_strCodEmp) ;
        AStrCodPre := fAtualizaProCod('APUPRE', 'PRE_CODPRE');
        LQryExec.ParamByName('CODPRE').AsString := AStrCodPre ;
      end
      else /// alterar
      begin
        AStrCodPre := ARegDados.strPRE_CODPRE ;
        LstrSql :=           ' UPDATE APUPRE ' ;
        LstrSql := LstrSql + ' SET PRE_DTAINI = :DTAINI, ' ;
        LstrSql := LstrSql + '     PRE_DTAFIN = :DTAFIN, ' ;
        LstrSql := LstrSql + '     PRE_VRANRE = :VRANRE, ' ;
        LstrSql := LstrSql + '     PRE_VRLAIR = :VRLAIR, ' ;
        LstrSql := LstrSql + '     PRE_CODEMP = :CODEMP, ' ;
        LstrSql := LstrSql + '     PRE_CODPRE = :CODPRE ' ;
        LstrSql := LstrSql + ' WHERE AUTOINCREM = :AUTOINCREM ; ' ;
        LQryExec.SQL.Add(LstrSql) ;
        LQryExec.ParamByName('AUTOINCREM').AsString := ARegDados.strAUTOINCREM ;
        LQryExec.ParamByName('CODPRE').AsString := ARegDados.strPRE_CODPRE ;
      end;
      LQryExec.ParamByName('DTAINI').AsDate := ARegDados.dtaPRE_DTAINI ;
      LQryExec.ParamByName('DTAFIN').AsDate := ARegDados.dtaPRE_DTAFIN ;
      LQryExec.ParamByName('VRANRE').AsFloat := ARegDados.fltPRE_VRANRE ;
      LQryExec.ParamByName('VRLAIR').AsFloat := ARegDados.fltPRE_VRLAIR ;
      LQryExec.ParamByName('CODEMP').AsString := ARegDados.strPRE_CODEMP ;
      LQryExec.ExecSQL ;
    finally
      FreeAndNil(LQryExec) ;
    end;
    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      raise E ;
    End;
  end;
  result := True ;
end;

function fExcluiApuracao(const AStrAutoInc: string): boolean;
var
  LQryExec: TUniQuery ;
  LstrSql: string ;
begin
  LstrSql := '' ;

  fStartTransaction;
  try
    LQryExec := fCriaQuery ;
    try
      LQryExec.Close ;
      LQryExec.SQL.Clear ;
      LstrSql :=           'DELETE FROM SALCCB ' ;
      LstrSql := LstrSql + 'WHERE AUTOINCREM IN ( ' ;
      LstrSql := LstrSql + '  SELECT SAL_CODSAL FROM APUSAL WHERE SAL_CODVRE IN ( ' ;
      LstrSql := LstrSql + '    SELECT AUTOINCREM FROM APUVRE WHERE VRE_CODPRE IN ( ' ;
      LstrSql := LstrSql + '      SELECT PRE_CODPRE FROM APUPRE WHERE AUTOINCREM = :AUTOINCREM ) ) ) ; ' ;
      LQryExec.SQL.Add(LstrSql) ;
      LQryExec.ParamByName('AUTOINCREM').AsString := AStrAutoInc ;
      LQryExec.ExecSQL ;

      LQryExec.Close ;
      LQryExec.SQL.Clear ;
      LstrSql :=           ' DELETE FROM APUPRE ' ;
      LstrSql := LstrSql + ' WHERE AUTOINCREM = :AUTOINCREM ;' ;
      LQryExec.SQL.Add(LstrSql) ;
      LQryExec.ParamByName('AUTOINCREM').AsString := AStrAutoInc ;
      LQryExec.ExecSQL ;
    finally
      FreeAndNil(LQryExec) ;
    end;
    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      raise E ;
    End;
  end;
  result := True ;
end;

function fValidarExercicioInformado(
  const AStrExercicio, AStrCodEmp: string; var AftForma: TFormaTributacao;
  var AecEncerramento: TEncerramentoContabil): boolean;
begin
  result := False ;

  if fEmptyStr(AStrCodEmp) then
  begin
    fMensagem('ATENÇÃO!', 'Empresa não informada!', ['&Ok']);
    exit ;
  end ;

  AftForma := fRetornaFormaTributacao(AStrCodEmp, AStrExercicio) ;
  AecEncerramento := fRetornaEncerramentoContabil(AStrCodEmp, AStrExercicio) ;

  if AftForma = ftNada then
  begin
    fMensagem('ATENÇÃO!', 'Forma de tributação não parametrizada para a empresa '+ AStrCodEmp +' no exercício '+ AStrExercicio +'!'+#13+'Faça a parametrização no cadastro de empresas aba contabilidade', ['&Ok']);
    exit ;
  end;

  if (AftForma <> ftLucroRealTrimestral) and (AftForma <> ftLucroRealEstimativaMensal) then
  begin
    fMensagem('ATENÇÃO!', 'Forma de tributação deve ser "Lucro Real (Trimestral)" ou "Lucro Real (Estimativa Mensal)" para a empresa '+ AStrCodEmp +' no exercício '+ AStrExercicio +'!'+#13+'Faça a parametrização no cadastro de empresas aba contabilidade', ['&Ok']);
    exit ;
  end;

  result := True ;
end;

function fPeriodoJaCadastrado(const AStrAutoInc: string; const AStrCodEmp: string; const ADtaPeriodoFinal: TDateTime): boolean;
var
  LStrAutoInc: string ;
begin
  result := False ;
  LStrAutoInc := fCampoTabela('AUTOINCREM', 'APUPRE', ['PRE_DTAFIN', 'PRE_CODEMP'], [ADtaPeriodoFinal, AStrCodEmp]) ;
  if fEmptyStr(LStrAutoInc) then
  begin
    exit ;
  end;

  if LStrAutoInc = AStrAutoInc then
  begin
    Exit ;
  end;

  result := True ;
end;

function fPersisteApuracaoAjustes(const ARegDados: TDadosAPUARE): boolean;
var
  LQryExec: TUniQuery ;
  LstrSql: string ;
begin
  LstrSql := '' ;
  fStartTransaction;
  try
    LQryExec := fCriaQuery ;
    try
      LQryExec.Close ;
      LQryExec.SQL.Clear ;
      if fEmptyStr(ARegDados.strAUTOINCREM) then /// incluir
      begin
        LstrSql :=           ' INSERT INTO APUARE ( ' ;
        LstrSql := LstrSql + ' AUTOINCREM, ' ;
        LstrSql := LstrSql + ' ARE_CODVRE, ' ;
        LstrSql := LstrSql + ' ARE_DTALAN, ' ;
        LstrSql := LstrSql + ' ARE_HISPAD, ' ;
        LstrSql := LstrSql + ' ARE_HISTOR, ' ;
        LstrSql := LstrSql + ' ARE_EMPLAN, ' ;
        LstrSql := LstrSql + ' ARE_VALLAN, ' ;
        LstrSql := LstrSql + ' ARE_CODCON, ' ;
        LstrSql := LstrSql + ' ARE_TPLACO, ' ;
        LstrSql := LstrSql + ' ARE_CREDEB ' ;
        LstrSql := LstrSql + ' ) ' ;
        LstrSql := LstrSql + ' VALUES ( ' ;
        LstrSql := LstrSql + ' :AUTOINCREM, ' ;
        LstrSql := LstrSql + ' :CODVRE, ' ;
        LstrSql := LstrSql + ' :DTALAN, ' ;
        LstrSql := LstrSql + ' :HISPAD, ' ;
        LstrSql := LstrSql + ' :HISTOR, ' ;
        LstrSql := LstrSql + ' :EMPLAN, ' ;
        LstrSql := LstrSql + ' :VALLAN, ' ;
        LstrSql := LstrSql + ' :CODCON, ' ;
        LstrSql := LstrSql + ' :TPLACO, ' ;
        LstrSql := LstrSql + ' :CREDEB ' ;
        LstrSql := LstrSql + ' ) ; ' ;
        LQryExec.SQL.Add(LstrSql) ;
        //gera os codigo
        LQryExec.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('APUARE', VS_strCodEmp) ;
      end
      else /// alterar
      begin
        LstrSql :=           ' UPDATE APUARE SET ' ;
        LstrSql := LstrSql + '  ARE_CODVRE = :CODVRE, ' ;
        LstrSql := LstrSql + '  ARE_DTALAN = :DTALAN, ' ;
        LstrSql := LstrSql + '  ARE_HISPAD = :HISPAD, ' ;
        LstrSql := LstrSql + '  ARE_HISTOR = :HISTOR, ' ;
        LstrSql := LstrSql + '  ARE_EMPLAN = :EMPLAN, ' ;
        LstrSql := LstrSql + '  ARE_VALLAN = :VALLAN, ' ;
        LstrSql := LstrSql + '  ARE_CODCON = :CODCON, ' ;
        LstrSql := LstrSql + '  ARE_TPLACO = :TPLACO, ' ;
        LstrSql := LstrSql + '  ARE_CREDEB = :CREDEB ' ;
        LstrSql := LstrSql + ' WHERE AUTOINCREM = :AUTOINCREM ; ' ;
        LQryExec.SQL.Add(LstrSql) ;
        LQryExec.ParamByName('AUTOINCREM').AsString := ARegDados.strAUTOINCREM ;
      end;
      LQryExec.ParamByName('CODVRE').AsString := ARegDados.strARE_CODVRE ;
      LQryExec.ParamByName('DTALAN').AsDate := ARegDados.dtaARE_DTALAN ;
      LQryExec.ParamByName('HISPAD').Value := iif(ARegDados.intARE_HISPAD = 0, null, ARegDados.intARE_HISPAD)  ;
      LQryExec.ParamByName('HISTOR').AsString := ARegDados.strARE_HISTOR ;
      LQryExec.ParamByName('EMPLAN').AsString := ARegDados.strARE_EMPLAN ;
      LQryExec.ParamByName('VALLAN').AsFloat:= ARegDados.fltARE_VALLAN ;
      LQryExec.ParamByName('CODCON').AsString := ARegDados.strARE_CODCON ;
      LQryExec.ParamByName('TPLACO').AsString := ARegDados.strARE_TPLACO ;
      LQryExec.ParamByName('CREDEB').AsString := ARegDados.strARE_CREDEB ;
      LQryExec.ExecSQL ;
    finally
      FreeAndNil(LQryExec) ;
    end;
    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      raise E ;
    End;
  end;
  result := True ;
end;

procedure pCarregaDadosAjustes(var AQryAjuste: TUniQuery;
                               const AStrCodigo: string;
                               const ADtaIni, ADtaFin: TDateTime;
                               const AllTipo: TLacsLalur;
                               const AecEncerramento: TEncerramentoContabil;
                               const AstrCodEmp: String);
var
  LStrFiltro: string ;
begin
  LStrFiltro := ' AND FALSE ' ;

  if AllTipo = llLacs then
  begin
    LStrFiltro := ' AND NATAJU.NAT_GERLAC = "S" ' ;
  end
  else if AllTipo = llLalur then
  begin
    LStrFiltro := ' AND NATAJU.NAT_GERLAL = "S" ' ;
  end;

  AQryAjuste.Close ;
  AQryAjuste.SQL.Clear ;
  AQryAjuste.SQL.Add(' SELECT ') ;
  AQryAjuste.SQL.Add('   APUARE.AUTOINCREM, ') ;
  AQryAjuste.SQL.Add('   NAT_TIPMOV AS ARE_TIPLAN, ') ;
  AQryAjuste.SQL.Add('   NAT_CODIGO AS ARE_NATAJU, ') ;
  AQryAjuste.SQL.Add('   NAT_DESCRI, ') ;
  AQryAjuste.SQL.Add('   ARE_DTALAN, ') ;
  AQryAjuste.SQL.Add('   ARE_HISPAD, ') ;
  AQryAjuste.SQL.Add('   PAD_DESCRI, ') ;
  AQryAjuste.SQL.Add('   ARE_HISTOR, ') ;
  AQryAjuste.SQL.Add('   ARE_CODCON, ') ;
  AQryAjuste.SQL.Add('   ARE_TPLACO, ') ;
  AQryAjuste.SQL.Add('   NCO_DESCRI, ') ;
  AQryAjuste.SQL.Add('   ARE_VALLAN, ') ;
  AQryAjuste.SQL.Add('   ARE_EMPLAN, ') ;
  AQryAjuste.SQL.Add('   EMP_NOMEMP, ') ;
  AQryAjuste.SQL.Add('   ARE_LANCON, ') ;
  AQryAjuste.SQL.Add('   CONCAT(COALESCE(HISPAD.PAD_DESCRI,""), CASE WHEN COALESCE(ARE_HISPAD,"") = "" THEN "" ELSE " " END, ARE_HISTOR) AS HISTORICO, ') ;
  AQryAjuste.SQL.Add('   APUARE.ARE_CREDEB ') ;
  AQryAjuste.SQL.Add(' FROM ') ;
  AQryAjuste.SQL.Add('   APUARE INNER JOIN PLANCO ON APUARE.ARE_CODCON = PLANCO.NCO_CODCON AND APUARE.ARE_TPLACO = PLANCO.NCO_TPLACO ') ;
  AQryAjuste.SQL.Add('          INNER JOIN CADEMP ON APUARE.ARE_EMPLAN = CADEMP.EMP_CODEMP ') ;
  AQryAjuste.SQL.Add('          INNER JOIN NATAJU ON PLANCO.NCO_NATAJU = NATAJU.NAT_CODIGO ') ;
  AQryAjuste.SQL.Add('          LEFT JOIN HISPAD ON APUARE.ARE_HISPAD = HISPAD.PAD_CODIGO ') ;
  if fCfgHisTpl then
    AQryAjuste.SQL.Add('            AND PAD_TPLACO = EMP_TPLACO ')
  else
    AQryAjuste.SQL.Add('            AND IFNULL(PAD_TPLACO, "") = "" ');
  AQryAjuste.SQL.Add(' WHERE APUARE.ARE_EMPLAN = :EMPLAN AND APUARE.ARE_LANCON IS NULL AND PLANCO.NCO_AJULIQ = "S" ' + LStrFiltro  ) ;
  if AecEncerramento = ecTrimestral then
  begin
    AQryAjuste.SQL.Add(' AND APUARE.ARE_CODVRE = :CODVRE ' ) ;
    AQryAjuste.ParamByName('CODVRE').AsString := AStrCodigo ;
  end
  else if AecEncerramento = ecAnual then
  begin
    AQryAjuste.SQL.Add(' AND APUARE.ARE_CODVRE IN (SELECT APUVRE.AUTOINCREM ' ) ;
    AQryAjuste.SQL.Add('  FROM APUPRE INNER JOIN APUVRE ON APUPRE.PRE_CODPRE = APUVRE.VRE_CODPRE ' ) ;
    AQryAjuste.SQL.Add('  WHERE APUVRE.VRE_TIPLAN = :TIPLAN AND PRE_DTAFIN BETWEEN :DTALAN_INI AND :DTALAN_FIN ) ' ) ;
    AQryAjuste.ParamByName('TIPLAN').AsString := COD_LACS_LALUR[AllTipo] ;
  end;
  AQryAjuste.SQL.Add(' UNION ALL ') ;
  AQryAjuste.SQL.Add(' SELECT ') ;
  AQryAjuste.SQL.Add('   APUARE.AUTOINCREM, ') ;
  AQryAjuste.SQL.Add('   NAT_TIPMOV AS ARE_TIPLAN, ') ;
  AQryAjuste.SQL.Add('   NAT_CODIGO AS ARE_NATAJU, ') ;
  AQryAjuste.SQL.Add('   NAT_DESCRI, ') ;
  AQryAjuste.SQL.Add('   CON_DTALAN AS ARE_DTALAN, ') ;
  AQryAjuste.SQL.Add('   CON_HISPAD AS ARE_HISPAD, ') ;
  AQryAjuste.SQL.Add('   PAD_DESCRI, ') ;
  AQryAjuste.SQL.Add('   CON_HISTOR AS ARE_HISTOR, ') ;
  AQryAjuste.SQL.Add('   CON_CONCRE AS ARE_CODCON, ') ;
  AQryAjuste.SQL.Add('   EMP_TPLACO AS ARE_TPLACO, ') ;
  AQryAjuste.SQL.Add('   NCO_DESCRI, ') ;
  AQryAjuste.SQL.Add('   CON_VALLAN AS ARE_VALLAN, ') ;
  AQryAjuste.SQL.Add('   CON_EMPLAN AS ARE_EMPLAN, ') ;
  AQryAjuste.SQL.Add('   EMP_NOMEMP, ') ;
  AQryAjuste.SQL.Add('   ARE_LANCON, ') ;
  AQryAjuste.SQL.Add('   CONCAT(COALESCE(HISPAD.PAD_DESCRI,""), CASE WHEN COALESCE(CON_HISPAD,"") = "" THEN "" ELSE " " END, CON_HISTOR) AS HISTORICO, ') ;
  AQryAjuste.SQL.Add('   APUARE.ARE_CREDEB ') ;
  AQryAjuste.SQL.Add(' FROM ') ;
  AQryAjuste.SQL.Add('   APUARE INNER JOIN LANCON ON APUARE.ARE_LANCON = LANCON.AUTOINCREM AND APUARE.ARE_CREDEB = "C" ') ;
  AQryAjuste.SQL.Add('          INNER JOIN CADEMP ON LANCON.CON_EMPLAN = CADEMP.EMP_CODEMP ') ;
  AQryAjuste.SQL.Add('          INNER JOIN PLANCO ON LANCON.CON_CONCRE = PLANCO.NCO_CODCON AND CADEMP.EMP_TPLACO = PLANCO.NCO_TPLACO ') ;
  AQryAjuste.SQL.Add('          INNER JOIN NATAJU ON PLANCO.NCO_NATAJU = NATAJU.NAT_CODIGO ') ;
  AQryAjuste.SQL.Add('          LEFT JOIN HISPAD ON LANCON.CON_HISPAD = HISPAD.PAD_CODIGO ') ;
  if fCfgHisTpl then
    AQryAjuste.SQL.Add('            AND PAD_TPLACO = EMP_TPLACO ')
  else
     AQryAjuste.SQL.Add('           AND IFNULL(PAD_TPLACO, "") = "" ');
  AQryAjuste.SQL.Add(' WHERE LANCON.CON_EMPLAN = :EMPLAN AND PLANCO.NCO_AJULIQ = "S" ') ;
  AQryAjuste.SQL.Add('       AND NATAJU.NAT_TIPMOV IN ("A", "E") AND LANCON.CON_TIPLAN <> "FEC" ' + LStrFiltro ) ;
  AQryAjuste.SQL.Add('       AND LANCON.CON_DTALAN BETWEEN :DTALAN_INI AND :DTALAN_FIN ') ;
  if AecEncerramento = ecTrimestral then
  begin
    AQryAjuste.SQL.Add(' AND APUARE.ARE_CODVRE = :CODVRE ' ) ;
    AQryAjuste.ParamByName('CODVRE').AsString := AStrCodigo ;
  end
  else if AecEncerramento = ecAnual then
  begin
    AQryAjuste.SQL.Add(' AND APUARE.ARE_CODVRE IN (SELECT APUVRE.AUTOINCREM ' ) ;
    AQryAjuste.SQL.Add('  FROM APUPRE INNER JOIN APUVRE ON APUPRE.PRE_CODPRE = APUVRE.VRE_CODPRE ' ) ;
    AQryAjuste.SQL.Add('  WHERE APUVRE.VRE_TIPLAN = :TIPLAN AND PRE_DTAFIN BETWEEN :DTALAN_INI AND :DTALAN_FIN ) ' ) ;
    AQryAjuste.ParamByName('TIPLAN').AsString := COD_LACS_LALUR[AllTipo] ;
  end;
  AQryAjuste.SQL.Add(' UNION ALL ') ;
  AQryAjuste.SQL.Add(' SELECT ') ;
  AQryAjuste.SQL.Add('   APUARE.AUTOINCREM, ') ;
  AQryAjuste.SQL.Add('   NAT_TIPMOV AS ARE_TIPLAN, ') ;
  AQryAjuste.SQL.Add('   NAT_CODIGO AS ARE_NATAJU, ') ;
  AQryAjuste.SQL.Add('   NAT_DESCRI, ') ;
  AQryAjuste.SQL.Add('   CON_DTALAN AS ARE_DTALAN, ') ;
  AQryAjuste.SQL.Add('   CON_HISPAD AS ARE_HISPAD, ') ;
  AQryAjuste.SQL.Add('   PAD_DESCRI, ') ;
  AQryAjuste.SQL.Add('   CON_HISTOR AS ARE_HISTOR, ') ;
  AQryAjuste.SQL.Add('   CON_CONDEB AS ARE_CODCON, ') ;
  AQryAjuste.SQL.Add('   EMP_TPLACO AS ARE_TPLACO, ') ;
  AQryAjuste.SQL.Add('   NCO_DESCRI, ') ;
  AQryAjuste.SQL.Add('   CON_VALLAN AS ARE_VALLAN, ') ;
  AQryAjuste.SQL.Add('   CON_EMPLAN AS ARE_EMPLAN, ') ;
  AQryAjuste.SQL.Add('   EMP_NOMEMP, ') ;
  AQryAjuste.SQL.Add('   ARE_LANCON, ') ;
  AQryAjuste.SQL.Add('   CONCAT(COALESCE(HISPAD.PAD_DESCRI,""), CASE WHEN COALESCE(CON_HISPAD,"") = "" THEN "" ELSE " " END, CON_HISTOR) AS HISTORICO, ') ;
  AQryAjuste.SQL.Add('   APUARE.ARE_CREDEB ') ;
  AQryAjuste.SQL.Add(' FROM ') ;
  AQryAjuste.SQL.Add('   APUARE INNER JOIN LANCON ON APUARE.ARE_LANCON = LANCON.AUTOINCREM  AND APUARE.ARE_CREDEB = "D"  ') ;
  AQryAjuste.SQL.Add('          INNER JOIN CADEMP ON LANCON.CON_EMPLAN = CADEMP.EMP_CODEMP ') ;
  AQryAjuste.SQL.Add('          INNER JOIN PLANCO ON LANCON.CON_CONDEB = PLANCO.NCO_CODCON AND CADEMP.EMP_TPLACO = PLANCO.NCO_TPLACO ') ;
  AQryAjuste.SQL.Add('          INNER JOIN NATAJU ON PLANCO.NCO_NATAJU = NATAJU.NAT_CODIGO ') ;
  AQryAjuste.SQL.Add('          LEFT JOIN HISPAD ON LANCON.CON_HISPAD = HISPAD.PAD_CODIGO ') ;
  if fCfgHisTpl then
    AQryAjuste.SQL.Add('            AND PAD_TPLACO = EMP_TPLACO ')
  else
    AQryAjuste.SQL.Add('            AND IFNULL(PAD_TPLACO, "") = "" ');
  AQryAjuste.SQL.Add(' WHERE LANCON.CON_EMPLAN = :EMPLAN AND PLANCO.NCO_AJULIQ = "S" ') ;
  AQryAjuste.SQL.Add('       AND NATAJU.NAT_TIPMOV IN ("A", "E") ') ;
  AQryAjuste.SQL.Add('       AND LANCON.CON_TIPLAN <> "FEC" ' + LStrFiltro ) ;
  AQryAjuste.SQL.Add('       AND LANCON.CON_DTALAN BETWEEN :DTALAN_INI AND :DTALAN_FIN ') ;
  if AecEncerramento = ecTrimestral then
  begin
    AQryAjuste.SQL.Add(' AND APUARE.ARE_CODVRE = :CODVRE ' ) ;
    AQryAjuste.ParamByName('CODVRE').AsString := AStrCodigo ;
  end
  else if AecEncerramento = ecAnual then
  begin
    AQryAjuste.SQL.Add(' AND APUARE.ARE_CODVRE IN (SELECT APUVRE.AUTOINCREM ' ) ;
    AQryAjuste.SQL.Add('  FROM APUPRE INNER JOIN APUVRE ON APUPRE.PRE_CODPRE = APUVRE.VRE_CODPRE ' ) ;
    AQryAjuste.SQL.Add('  WHERE APUVRE.VRE_TIPLAN = :TIPLAN AND PRE_DTAFIN BETWEEN :DTALAN_INI AND :DTALAN_FIN ) ' ) ;
    AQryAjuste.ParamByName('TIPLAN').AsString := COD_LACS_LALUR[AllTipo] ;
  end;
  AQryAjuste.ParamByName('DTALAN_INI').AsDate := ADtaIni ;
  AQryAjuste.ParamByName('DTALAN_FIN').AsDate := ADtaFin ;
  AQryAjuste.ParamByName('EMPLAN').AsString := AstrCodEmp ;
  AQryAjuste.Open ;

end;

function fPersisteApuracaoCompensacao(const ARegDados: TDadosAPUCRE; const ADtaLancamento: TDateTime; const AllTipo: TLacsLalur; AdictValores: TDictionary<String, double>; const AstrCodEmp: String): boolean;
var
  LQryExec: TUniQuery ;
  LstrSql: string ;
  LstrAutoIncApuCre: string ;
  LintCnt: integer ;
begin
  LstrSql := '' ;
  fStartTransaction;
  try
    LQryExec := fCriaQuery ;
    try
      /// exclui
      fEstornaCompensacao(ARegDados.strCRE_CODVRE) ;

      /// incluir
      LQryExec.Close ;
      LQryExec.SQL.Clear ;
      LstrSql :=           ' INSERT INTO APUCRE ( ' ;
      LstrSql := LstrSql + '  AUTOINCREM, ' ;
      LstrSql := LstrSql + '  CRE_CODVRE, ' ;
      LstrSql := LstrSql + '  CRE_PERMAX, ' ;
      LstrSql := LstrSql + '  CRE_LANCAR ' ;
      LstrSql := LstrSql + ' ) ' ;
      LstrSql := LstrSql + ' VALUES ( ' ;
      LstrSql := LstrSql + '  :AUTOINCREM, ' ;
      LstrSql := LstrSql + '  :CODVRE, ' ;
      LstrSql := LstrSql + '  :PERMAX, ' ;
      LstrSql := LstrSql + '  :LANCAR ' ;
      LstrSql := LstrSql + ' ) ; ' ;
      LQryExec.SQL.Add(LstrSql) ;
      //gera os codigo
      LstrAutoIncApuCre := fRetAutoIncrem('APUCRE', VS_strCodEmp) ;
      LQryExec.ParamByName('AUTOINCREM').AsString := LstrAutoIncApuCre ;
      LQryExec.ParamByName('CODVRE').AsString := ARegDados.strCRE_CODVRE ;
      LQryExec.ParamByName('PERMAX').AsFloat := ARegDados.fltCRE_PERMAX ;
      LQryExec.ParamByName('LANCAR').AsString := ARegDados.strCRE_LANCAR ;
      LQryExec.ExecSQL ;
      //lança o detalhe dos saldos das contas controladas
      for LintCnt := Low(ARegDados.regCRE_APUCDE) to High(ARegDados.regCRE_APUCDE) do
      begin
        LstrSql := ' INSERT INTO APUCDE ( ' ;
        LstrSql := LstrSql + '  AUTOINCREM, ' ;
        LstrSql := LstrSql + '  CDE_CODCRE, ' ;
        LstrSql := LstrSql + '  CDE_OPEANT, ' ;
        LstrSql := LstrSql + '  CDE_CTACON, ' ;
        LstrSql := LstrSql + '  CDE_TIPSLD, ' ;
        LstrSql := LstrSql + '  CDE_VALLAN  ' ;
        LstrSql := LstrSql + ' ) ' ;
        LstrSql := LstrSql + ' VALUES ( ' ;
        LstrSql := LstrSql + '  :AUTOINCREM, ' ;
        LstrSql := LstrSql + '  :CODCRE, ' ;
        LstrSql := LstrSql + '  :OPEANT, ' ;
        LstrSql := LstrSql + '  :CTACON, ' ;
        LstrSql := LstrSql + '  :TIPSLD, ' ;
        LstrSql := LstrSql + '  :VALLAN  ' ;
        LstrSql := LstrSql + ' ) ; ' ;
        LQryExec.Close ;
        LQryExec.SQL.Clear ;
        LQryExec.SQL.Add(LstrSql) ;
        LQryExec.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('APUCDE', VS_strCodEmp) ;
        LQryExec.ParamByName('CODCRE').AsString := LstrAutoIncApuCre ;
        LQryExec.ParamByName('OPEANT').AsFloat := ARegDados.regCRE_APUCDE[LintCnt].fltCDE_OPEANT ;
        LQryExec.ParamByName('CTACON').AsString := ARegDados.regCRE_APUCDE[LintCnt].strCDE_CTACON ;
        LQryExec.ParamByName('TIPSLD').AsString := ARegDados.regCRE_APUCDE[LintCnt].strCDE_TIPSLD ;
        LQryExec.ParamByName('VALLAN').AsFloat := ARegDados.regCRE_APUCDE[LintCnt].fltCDE_VALLAN ;
        LQryExec.ExecSQL ;
      end;

      if not fLancaCompensacaoDebito(ARegDados.strCRE_CODVRE,
                                    ARegDados.strCRE_LANCAR,
                                    AdictValores,
                                    ADtaLancamento,
                                    AllTipo,
                                    AstrCodEmp) then
      begin
        fRollBack;
        raise Exception.Create('Problemas ao lançar débitos da compensação') ;
      end;

    finally
      FreeAndNil(LQryExec) ;
    end;
    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      raise E ;
    End;
  end;
  result := True ;
end;

function fPersisteApuracaoValores(const ARegValores: TValoresApuracao;
                                  const AStrCodigo: string;
                                  const AllTipo: TLacsLalur;
                                  const ADtaLancamento: TDateTime;
                                  const AecEncerramento: TEncerramentoContabil;
                                  const AstrContaControladaBaseNegativa, AstrCodEmp: string):boolean ;
var
  LQryExec: TUniQuery ;
  LStrSql: string ;
  LIntCodigo: integer ;
  LBlnPodeLancar: boolean ;
begin
  LStrSql := '' ;

  /// quando é trimestral lança a cada final de periodo, se anual lança somente em dezembro.
  LBlnPodeLancar := (ARegValores.fltBaseCalculo < 0.00) and iif(AecEncerramento = ecTrimestral, True, MonthOf(ADtaLancamento)=12) ;

  fStartTransaction;
  try
    LQryExec := fCriaQuery ;
    try
      LQryExec.Close ;
      LQryExec.SQL.Clear ;
      LStrSql :=           ' UPDATE APUVRE SET ' ;
      LStrSql := LStrSql + '  VRE_VLADIC = :VLADIC, ' ;
      LStrSql := LStrSql + '  VRE_VLEXCL = :VLEXCL, ' ;
      LStrSql := LStrSql + '  VRE_VLBCNG = :VLBCNG, ' ;
      LStrSql := LStrSql + '  VRE_VLCOMP = :VLCOMP, ' ;
      LStrSql := LStrSql + '  VRE_VLRBAS = :VLRBAS ' ;
      LStrSql := LStrSql + ' WHERE AUTOINCREM = :AUTOINCREM ; ' ;
      LQryExec.SQL.Add(LStrSql) ;
      LQryExec.ParamByName('VLADIC').AsFloat := ARegValores.fltAdicoes ;
      LQryExec.ParamByName('VLEXCL').AsFloat := ARegValores.fltExclusoes ;
      LQryExec.ParamByName('VLBCNG').AsFloat := ARegValores.fltBcAntesCompensacao ;
      LQryExec.ParamByName('VLCOMP').AsFloat := ARegValores.fltCompensacaoBCNegativa ;
      LQryExec.ParamByName('VLRBAS').AsFloat := ARegValores.fltBaseCalculo ;
      LQryExec.ParamByName('AUTOINCREM').AsString := AStrCodigo ;
      LQryExec.ExecSQL ;

      ///apaga os lançamentos de saldos para relançar
      LStrSql := 'DELETE FROM SALCCB WHERE AUTOINCREM IN (SELECT SAL_CODSAL FROM APUSAL WHERE SAL_CODVRE = :CODVRE) AND SAL_CREDEB = :CREDEB ' ;
      LQryExec.Close ;
      LQryExec.SQL.Clear ;
      LQryExec.SQL.Add(LStrSql) ;
      LQryExec.ParamByName('CODVRE').AsString := AStrCodigo ;
      LQryExec.ParamByName('CREDEB').AsString := 'C' ;
      LQryExec.ExecSQL ;

      ///faz os lançamentos no controle de saldo
      if LBlnPodeLancar then
      begin
        LStrSql := 'INSERT INTO SALCCB (SAL_CTACON, SAL_DTALAN, SAL_HISTOR, SAL_VALLAN, SAL_CREDEB, SAL_CODEMP) VALUES (:CTACON, :DTALAN, :HISTOR, :VALLAN, :CREDEB, :CODEMP) ;' ;
        LQryExec.Close ;
        LQryExec.SQL.Clear ;
        LQryExec.SQL.Add(LStrSql) ;
        LQryExec.ParamByName('CTACON').AsString := AstrContaControladaBaseNegativa ;
        LQryExec.ParamByName('DTALAN').AsDate := ADtaLancamento ;
        LQryExec.ParamByName('HISTOR').AsString := iif(AllTipo = llLalur, 'Prejuízos Fiscais Operacionais', 'Base de Cálculo Negativa da CSLL') ;
        LQryExec.ParamByName('VALLAN').AsFloat := abs(ARegValores.fltBaseCalculo) ;
        LQryExec.ParamByName('CREDEB').AsString := 'C' ;
        LQryExec.ParamByName('CODEMP').AsString := AstrCodEmp ;
        LQryExec.ExecSQL ;

        LStrSql := 'SELECT MAX(AUTOINCREM) AS CODIGO FROM SALCCB;' ;
        LQryExec.Close ;
        LQryExec.SQL.Clear ;
        LQryExec.SQL.Add(LStrSql) ;
        LQryExec.Open ;
        LIntCodigo := LQryExec.FieldByName('CODIGO').AsInteger ;

        LStrSql := 'INSERT INTO APUSAL (AUTOINCREM, SAL_CODVRE, SAL_CODSAL) VALUES (:AUTOINCREM, :CODVRE, :CODSAL);' ;
        LQryExec.Close ;
        LQryExec.SQL.Clear ;
        LQryExec.SQL.Add(LStrSql) ;
        LQryExec.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('APUSAL', VS_strCodEmp) ;
        LQryExec.ParamByName('CODVRE').AsString := AStrCodigo ;
        LQryExec.ParamByName('CODSAL').AsInteger := LIntCodigo ;
        LQryExec.ExecSQL ;

      end;

    finally
      FreeAndNil(LQryExec) ;
    end;
    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      raise E ;
    End;
  end;
  result := True ;
end;

function fRetornaEncerramentoContabil(const AStrCodEmp, AStrExercicio: string):TEncerramentoContabil ;
var
  LstrRetorno: string ;
begin
  result := ecNada ;
  LstrRetorno := vartostr(fCampoTabela('TRI_ENCERR', 'EPREGT', ['TRI_CODEMP', 'TRI_ANOEXE'], [AStrCodEmp, AStrExercicio])) ;
  if LstrRetorno = 'A' then
  begin
    result := ecAnual ;
  end
  else if LstrRetorno = 'M' then
  begin
    result := ecMensal ;
  end
  else if LstrRetorno = 'T' then
  begin
    result := ecTrimestral ;
  end;
end;

function fGerarAjustes(
  const AStrCodigo: string;
  const ADtaIni, ADtaFin: TDateTime;
  AllTipo: TLacsLalur;
  APgbProgresso: TcxProgressBar;
  const AecEncerramento: TEncerramentoContabil;
  const AstrCodEmp: String): Boolean;
var
  LQrySeleciona: TUniQuery ;
  LQryExec: TUniQuery ;
  LStrFiltro: string ;
  LStrEmpresas: string ;
  LDtaIni, LDtaFin: TDateTime ;
begin
  LStrFiltro := ' AND FALSE ' ;

  if AllTipo = llLacs then
  begin
    LStrFiltro := ' AND NATAJU.NAT_GERLAC = "S" ' ;
  end
  else if AllTipo = llLalur then
  begin
    LStrFiltro := ' AND NATAJU.NAT_GERLAL = "S" ' ;
  end;

  LDtaIni := date ;
  LDtaFin := date ;
  if AecEncerramento = ecTrimestral then
  begin
    LDtaIni := ADtaIni ;
    LDtaFin := ADtaFin ;
  end
  else if AecEncerramento = ecAnual then
  begin
    LDtaIni := EncodeDate(YearOf(ADtaFin), MonthOf(ADtaFin), 1) ;
    LDtaFin := ADtaFin ;
  end;

  LStrEmpresas := fRetornaEmpresaMatrizFilial(AstrCodEmp) ;

  LQrySeleciona := fCriaQuery ;
  LQryExec := fCriaQuery ;
  try
    LQrySeleciona.Close ;
    LQrySeleciona.SQL.Clear ;
    LQrySeleciona.SQL.Add(' SELECT  ') ;
    LQrySeleciona.SQL.Add('   LANCON.AUTOINCREM, ') ;
    LQrySeleciona.SQL.Add('   "C" AS D_C ') ;
    LQrySeleciona.SQL.Add(' FROM ') ;
    LQrySeleciona.SQL.Add('   LANCON  ') ;
    LQrySeleciona.SQL.Add('      INNER JOIN CADEMP ON LANCON.CON_EMPLAN = CADEMP.EMP_CODEMP  ') ;
    LQrySeleciona.SQL.Add('      INNER JOIN PLANCO ON LANCON.CON_CONCRE = PLANCO.NCO_CODCON AND CADEMP.EMP_TPLACO = PLANCO.NCO_TPLACO  ') ;
    LQrySeleciona.SQL.Add('      INNER JOIN NATAJU ON PLANCO.NCO_NATAJU = NATAJU.NAT_CODIGO  ') ;
    LQrySeleciona.SQL.Add('      LEFT JOIN HISPAD  ON LANCON.CON_HISPAD = HISPAD.PAD_CODIGO  ') ;
    if fCfgHisTpl then
      LQrySeleciona.SQL.Add('            AND PAD_TPLACO = EMP_TPLACO ')
    else
      LQrySeleciona.SQL.Add('            AND IFNULL(PAD_TPLACO, "") = "" ');
    LQrySeleciona.SQL.Add(' WHERE ') ;
    LQrySeleciona.SQL.Add('       PLANCO.NCO_AJULIQ = "S"  ') ;
    LQrySeleciona.SQL.Add('   AND NATAJU.NAT_TIPMOV IN ("A", "E")  ') ;
    LQrySeleciona.SQL.Add('   AND LANCON.CON_TIPLAN <> "FEC"  ') ;
    LQrySeleciona.SQL.Add('   ' + LStrFiltro ) ;
    LQrySeleciona.SQL.Add('   AND LANCON.CON_DTALAN BETWEEN :DTALAN_INI AND :DTALAN_FIN ') ;
    LQrySeleciona.SQL.Add('   AND LANCON.CON_EMPLAN IN (' + LStrEmpresas + ') ') ;
    LQrySeleciona.SQL.Add(' UNION ALL ') ;
    LQrySeleciona.SQL.Add(' SELECT  ') ;
    LQrySeleciona.SQL.Add('   LANCON.AUTOINCREM, ') ;
    LQrySeleciona.SQL.Add('   "D" AS D_C ') ;
    LQrySeleciona.SQL.Add(' FROM ') ;
    LQrySeleciona.SQL.Add('   LANCON  ') ;
    LQrySeleciona.SQL.Add('      INNER JOIN CADEMP ON LANCON.CON_EMPLAN = CADEMP.EMP_CODEMP  ') ;
    LQrySeleciona.SQL.Add('      INNER JOIN PLANCO ON LANCON.CON_CONDEB = PLANCO.NCO_CODCON AND CADEMP.EMP_TPLACO = PLANCO.NCO_TPLACO  ') ;
    LQrySeleciona.SQL.Add('      INNER JOIN NATAJU ON PLANCO.NCO_NATAJU = NATAJU.NAT_CODIGO  ') ;
    LQrySeleciona.SQL.Add('      LEFT JOIN HISPAD  ON LANCON.CON_HISPAD = HISPAD.PAD_CODIGO  ') ;
    if fCfgHisTpl then
      LQrySeleciona.SQL.Add('            AND PAD_TPLACO = EMP_TPLACO ')
    else
      LQrySeleciona.SQL.Add('            AND IFNULL(PAD_TPLACO, "") = "" ');
    LQrySeleciona.SQL.Add(' WHERE ') ;
    LQrySeleciona.SQL.Add('       PLANCO.NCO_AJULIQ = "S"  ') ;
    LQrySeleciona.SQL.Add('   AND NATAJU.NAT_TIPMOV IN ("A", "E")  ') ;
    LQrySeleciona.SQL.Add('   AND LANCON.CON_TIPLAN <> "FEC"  ') ;
    LQrySeleciona.SQL.Add('   ' + LStrFiltro ) ;
    LQrySeleciona.SQL.Add('   AND LANCON.CON_DTALAN BETWEEN :DTALAN_INI AND :DTALAN_FIN ') ;
    LQrySeleciona.SQL.Add('   AND LANCON.CON_EMPLAN IN (' + LStrEmpresas + ') ') ;
    LQrySeleciona.ParamByName('DTALAN_INI').AsDate := LDtaIni ;
    LQrySeleciona.ParamByName('DTALAN_FIN').AsDate := LDtaFin ;
    LQrySeleciona.Open ;
    LQrySeleciona.First ;

    APgbProgresso.Properties.Max := LQrySeleciona.RecordCount;

    fStartTransaction;
    try
      ////remove a geração anterior
      LQryExec.Close ;
      LQryExec.SQL.Clear ;
      LQryExec.SQL.Add('DELETE FROM APUARE WHERE ARE_CODVRE = :CODVRE AND ARE_LANCON IS NOT NULL ') ;
      LQryExec.ParamByName('CODVRE').AsString := AStrCodigo ;
      LQryExec.ExecSQL ;

      ///recria os codigos
      while not LQrySeleciona.Eof do
      begin
        APgbProgresso.Position := LQrySeleciona.RecNo;
        Application.ProcessMessages;

        LQryExec.Close ;
        LQryExec.SQL.Clear ;
        LQryExec.SQL.Add(' INSERT INTO APUARE (AUTOINCREM, ARE_CODVRE, ARE_LANCON, ARE_CREDEB) ') ;
        LQryExec.SQL.Add(' VALUES ') ;
        LQryExec.SQL.Add(' (:AUTOINCREM, :CODVRE, :LANCON, :CREDEB); ') ;
        LQryExec.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('APUARE', VS_strCodEmp) ;
        LQryExec.ParamByName('CODVRE').AsString := AStrCodigo ;
        LQryExec.ParamByName('LANCON').AsString := LQrySeleciona.FieldByName('AUTOINCREM').AsString ;
        LQryExec.ParamByName('CREDEB').AsString := LQrySeleciona.FieldByName('D_C').AsString ;
        LQryExec.ExecSQL ;

        LQrySeleciona.Next ;
      end;

      fCommit ;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        raise E ;
      End;
    end;

  finally
    FreeAndNil(LQrySeleciona) ;
    FreeAndNil(LQryExec) ;
  end;

  result := True ;
end;

function fRetornaEmpresaMatrizFilial(const AStrCodEmp: string): string;
var
  LQryConsulta: TUniQuery ;
begin
  Result := fQuotedStr(AStrCodEmp) ;
  LQryConsulta := fCriaQuery() ;
  try
    LQryConsulta.Close ;
    LQryConsulta.SQL.Clear ;
    LQryConsulta.SQL.Add(' SELECT EMP_CODEMP ') ;
    LQryConsulta.SQL.Add(' FROM CADEMP ') ;
    LQryConsulta.SQL.Add(' WHERE SUBSTR(EMP_C_G_C_,1,8) IN (SELECT SUBSTR(EMP_C_G_C_,1,8) FROM CADEMP WHERE EMP_CODEMP = :CODEMP) ') ;
    LQryConsulta.SQL.Add(' ORDER BY EMP_NOMEMP ') ;
    LQryConsulta.ParamByName('CODEMP').AsString := AStrCodEmp ;
    LQryConsulta.Open ;
    if not LQryConsulta.IsEmpty then
    begin
      Result := '' ;
      LQryConsulta.First ;
      while not LQryConsulta.Eof do
      begin
        if fEmptyStr(Result) then
        begin
          Result := fQuotedStr(LQryConsulta.FieldByName('EMP_CODEMP').AsString) ;
        end
        else
        begin
          Result := Result + ',' + fQuotedStr(LQryConsulta.FieldByName('EMP_CODEMP').AsString) ;
        end;
        LQryConsulta.Next ;
      end;
    end;
  finally
    FreeAndNil(LQryConsulta) ;
  end;
end;

function fValidaRegistroSelecionadoAjustes(const AQryApuracao: TUniQuery): Boolean;
begin
  result := False ;
  if not AQryApuracao.Active then
  begin
    exit ;
  end;

  if AQryApuracao.IsEmpty then
  begin
    fMensagem('ATENÇÃO!', 'Registro não selecionado!', ['&Ok']);
    exit ;
  end;

  result := True ;
end;

function fExcluiApuracaoAjustes(const AStrAutoInc: string): boolean;
var
  LQryExec: TUniQuery ;
  LstrSql: string ;
begin
  LstrSql := '' ;

  fStartTransaction;
  try
    LQryExec := fCriaQuery ;
    try
      LQryExec.Close ;
      LQryExec.SQL.Clear ;
      LstrSql :=           ' DELETE FROM APUARE ' ;
      LstrSql := LstrSql + ' WHERE AUTOINCREM = :AUTOINCREM ;' ;
      LQryExec.SQL.Add(LstrSql) ;
      LQryExec.ParamByName('AUTOINCREM').AsString := AStrAutoInc ;
      LQryExec.ExecSQL ;
    finally
      FreeAndNil(LQryExec) ;
    end;
    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      raise E ;
    End;
  end;
  result := True ;
end;

function fPodeAlterar(const AQryApuracao: TUniQuery): boolean;
begin
  Result := fEmptyStr(AQryApuracao.FieldByName('ARE_LANCON').AsString) ;
  if not Result then
  begin
    fMensagem('ATENÇÃO!', 'Não é Possível Alterar Registro Gerado!', ['&Ok']);
  end;
end;

function fCarregaHistoricoPadrao(const ACodigo: string; const AstrCodEmp: string = ''): string;
begin
  result := fRetDescHistoricoPadrao(ACodigo, AstrCodEmp);
end;

procedure pAtualizaInfoNaturezaAjuste(const AStrConta, AStrTpLaCo: string; var AStrCodAju, AStrDesAju, AStrTipAju: string);
var
  LQryConsulta: TUniQuery ;
begin
  LQryConsulta := fCriaQuery ;
  try
    LQryConsulta.Close ;
    LQryConsulta.SQL.Clear ;
    LQryConsulta.SQL.Add(' SELECT NAT_TIPMOV, NAT_CODIGO, NAT_DESCRI ') ;
    LQryConsulta.SQL.Add(' FROM PLANCO INNER JOIN NATAJU ON PLANCO.NCO_NATAJU = NATAJU.NAT_CODIGO ') ;
    LQryConsulta.SQL.Add(' WHERE NCO_CODCON = :CODCON AND NCO_TPLACO = :TPLACO ') ;
    LQryConsulta.ParamByName('CODCON').AsString := AStrConta ;
    LQryConsulta.ParamByName('TPLACO').AsString := AStrTpLaCo ;
    LQryConsulta.Open ;

    AStrCodAju := LQryConsulta.FieldByName('NAT_CODIGO').AsString ;
    AStrDesAju := LQryConsulta.FieldByName('NAT_DESCRI').AsString ;
    AStrTipAju := LQryConsulta.FieldByName('NAT_TIPMOV').AsString ;

  finally
    FreeAndNil(LQryConsulta) ;
  end;
end;

function fContaContabilJaCadastrada(const AStrAutoInc: string; const AStrCodAjuste, AStrCodConta: string): boolean;
var
  LStrAutoInc: string ;
begin
  result := False ;
  LStrAutoInc := fCampoTabela('AUTOINCREM', 'APUARE', ['ARE_CODVRE', 'ARE_CODCON'], [AStrCodAjuste, AStrCodConta]) ;
  if fEmptyStr(LStrAutoInc) then
  begin
    exit ;
  end;

  if LStrAutoInc = AStrAutoInc then
  begin
    Exit ;
  end;

  result := True ;
end;

function fConfiguraAjustes(const AStrCodigoApuracaoLalur, AStrCodigoApuracaoLacs: string; const AllTipo: TLacsLalur; const ADtaVigenciaInicial, ADtaVigenciaFinal: TDateTime; const AecEncerramento: TEncerramentoContabil; const AstrCodEmp: String): boolean;
var
  LfrmApuracaoLucroRealLalurLacsAjustes : TfrmApuracaoLucroRealLalurLacsAjustes ;
begin
  pCriarFormularios(TfrmApuracaoLucroRealLalurLacsAjustes, LfrmApuracaoLucroRealLalurLacsAjustes) ;
  try
    LfrmApuracaoLucroRealLalurLacsAjustes.CodigoApuracaoLalur := AStrCodigoApuracaoLalur ;
    LfrmApuracaoLucroRealLalurLacsAjustes.CodigoApuracaoLacs := AStrCodigoApuracaoLacs ;
    LfrmApuracaoLucroRealLalurLacsAjustes.Tipo := AllTipo ;
    LfrmApuracaoLucroRealLalurLacsAjustes.VigenciaInicial := ADtaVigenciaInicial ;
    LfrmApuracaoLucroRealLalurLacsAjustes.VigenciaFinal := ADtaVigenciaFinal ;
    LfrmApuracaoLucroRealLalurLacsAjustes.EncerramentoContabil := AecEncerramento ;
    LfrmApuracaoLucroRealLalurLacsAjustes.CodEmp := AstrCodEmp  ;
    LfrmApuracaoLucroRealLalurLacsAjustes.ShowModal ;

  finally
    pFreeAndNil(LfrmApuracaoLucroRealLalurLacsAjustes);
  end;
  result := True ;
end;

function fConfiguraCompensacao(
  const AStrCodigoApuracao: string; const AllTipo: TLacsLalur;
  const AFltAntesCompBaseNegativa: double; const ADtaVigenciaInicial,
  ADtaVigenciaFinal: TDateTime; const AstrCodEmp: String): boolean;
var
  LfrmApuracaoLucroRealLalurLacsCompensacao : TfrmApuracaoLucroRealLalurLacsCompensacao ;
  LfrmApuracaoLucroRealLalurLacsCompensacaoMult : TfrmApuracaoLucroRealLalurLacsCompensacaoMult ;
  LRegDados: TDadosAPUCRE ;
  LRegDadosAPUCDE: TDadosAPUCDE ;
  LarrDadosAPUCDE: TarrDadosAPUCDE ;
  LdictValores: TDictionary<String, double> ;
begin
  Result := False ;
  pCriarFormularios(TfrmApuracaoLucroRealLalurLacsCompensacao, LfrmApuracaoLucroRealLalurLacsCompensacao) ;
  LdictValores := TDictionary<String, double>.Create ;
  try
    LfrmApuracaoLucroRealLalurLacsCompensacao.lbBCAntesCompesacao.Caption := iif(AllTipo = llLacs, 'Base de Cálculo antes da Compensação da BC Negativa:', 'Lucro Real Antes da Compensação de Prejuizos:') ;
    LfrmApuracaoLucroRealLalurLacsCompensacao.CodigoApuracao := AStrCodigoApuracao ;
    LfrmApuracaoLucroRealLalurLacsCompensacao.Tipo := AllTipo ;
    LfrmApuracaoLucroRealLalurLacsCompensacao.VigenciaInicial := ADtaVigenciaInicial ;
    LfrmApuracaoLucroRealLalurLacsCompensacao.VigenciaFinal := ADtaVigenciaFinal ;
    LfrmApuracaoLucroRealLalurLacsCompensacao.BaseCalculoAntesCompensacao := AFltAntesCompBaseNegativa ;
    LfrmApuracaoLucroRealLalurLacsCompensacao.CodEmp := AstrCodEmp ;
    if LfrmApuracaoLucroRealLalurLacsCompensacao.ShowModal = mrOK then
    begin
      ///direciona para contas controladas serão feitas as compensações
      pCriarFormularios(TfrmApuracaoLucroRealLalurLacsCompensacaoMult, LfrmApuracaoLucroRealLalurLacsCompensacaoMult) ;
      try
        LfrmApuracaoLucroRealLalurLacsCompensacaoMult.CodEmp := AstrCodEmp ;
        LfrmApuracaoLucroRealLalurLacsCompensacaoMult.Tipo := AllTipo ;
        LfrmApuracaoLucroRealLalurLacsCompensacaoMult.VigenciaInicial := ADtaVigenciaInicial ;
        LfrmApuracaoLucroRealLalurLacsCompensacaoMult.AutoIncCompensacao := LfrmApuracaoLucroRealLalurLacsCompensacao.AutoIncCompensacao ;
        LfrmApuracaoLucroRealLalurLacsCompensacaoMult.ValorACompensar := fCalculaCompensacaoBcNegativa(LfrmApuracaoLucroRealLalurLacsCompensacao.edtPercentualMaximoCompensacao.Value,
                                                                                                       AFltAntesCompBaseNegativa,
                                                                                                       LfrmApuracaoLucroRealLalurLacsCompensacao.edtOperacionalAnteriores.Value) ;
        if LfrmApuracaoLucroRealLalurLacsCompensacaoMult.ShowModal = mrOK then
        begin
          SetLength(LarrDadosAPUCDE, 0);
          ///operacional ou base negativa
          LfrmApuracaoLucroRealLalurLacsCompensacaoMult.CompensacoesOperacionais.First ;
          while not LfrmApuracaoLucroRealLalurLacsCompensacaoMult.CompensacoesOperacionais.Eof do
          begin
            LRegDadosAPUCDE.fltCDE_OPEANT := LfrmApuracaoLucroRealLalurLacsCompensacaoMult.CompensacoesOperacionais.FieldByName('CTA_VLDISP').AsFloat ;
            LRegDadosAPUCDE.fltCDE_VALLAN := LfrmApuracaoLucroRealLalurLacsCompensacaoMult.CompensacoesOperacionais.FieldByName('CTA_VLACOM').AsFloat ;
            LRegDadosAPUCDE.strCDE_CTACON := LfrmApuracaoLucroRealLalurLacsCompensacaoMult.CompensacoesOperacionais.FieldByName('CTA_CODCON').AsString ;
            LRegDadosAPUCDE.strCDE_TIPSLD := COD_PREJUIZO_FISCAL[pjBcNegativaOuOperacional] ;
            SetLength(LarrDadosAPUCDE, Length(LarrDadosAPUCDE)+1);
            LarrDadosAPUCDE[High(LarrDadosAPUCDE)] := LRegDadosAPUCDE ;

            if not LdictValores.ContainsKey(LfrmApuracaoLucroRealLalurLacsCompensacaoMult.CompensacoesOperacionais.FieldByName('CTA_CODCON').AsString) then
            begin
              LdictValores.Add(LfrmApuracaoLucroRealLalurLacsCompensacaoMult.CompensacoesOperacionais.FieldByName('CTA_CODCON').AsString, 0.00);
            end;
            LdictValores.Items[LfrmApuracaoLucroRealLalurLacsCompensacaoMult.CompensacoesOperacionais.FieldByName('CTA_CODCON').AsString] := LdictValores.Items[LfrmApuracaoLucroRealLalurLacsCompensacaoMult.CompensacoesOperacionais.FieldByName('CTA_CODCON').AsString] + LfrmApuracaoLucroRealLalurLacsCompensacaoMult.CompensacoesOperacionais.FieldByName('CTA_VLACOM').AsFloat ;

            LfrmApuracaoLucroRealLalurLacsCompensacaoMult.CompensacoesOperacionais.Next ;
          end;
          ///Não operacional
          LfrmApuracaoLucroRealLalurLacsCompensacaoMult.CompensacoesNaoOperacionais.First ;
          while not LfrmApuracaoLucroRealLalurLacsCompensacaoMult.CompensacoesNaoOperacionais.Eof do
          begin
            LRegDadosAPUCDE.fltCDE_OPEANT := LfrmApuracaoLucroRealLalurLacsCompensacaoMult.CompensacoesNaoOperacionais.FieldByName('CTA_VLDISP').AsFloat ;
            LRegDadosAPUCDE.fltCDE_VALLAN := LfrmApuracaoLucroRealLalurLacsCompensacaoMult.CompensacoesNaoOperacionais.FieldByName('CTA_VLACOM').AsFloat ;
            LRegDadosAPUCDE.strCDE_CTACON := LfrmApuracaoLucroRealLalurLacsCompensacaoMult.CompensacoesNaoOperacionais.FieldByName('CTA_CODCON').AsString ;
            LRegDadosAPUCDE.strCDE_TIPSLD := COD_PREJUIZO_FISCAL[pjNaoOperacional] ;
            SetLength(LarrDadosAPUCDE, Length(LarrDadosAPUCDE)+1);
            LarrDadosAPUCDE[High(LarrDadosAPUCDE)] := LRegDadosAPUCDE ;
            LfrmApuracaoLucroRealLalurLacsCompensacaoMult.CompensacoesNaoOperacionais.Next ;
          end;
          LRegDados.strCRE_CODVRE := LfrmApuracaoLucroRealLalurLacsCompensacao.CodigoApuracao ;
          LRegDados.fltCRE_PERMAX := LfrmApuracaoLucroRealLalurLacsCompensacao.edtPercentualMaximoCompensacao.Value ;
          LRegDados.strCRE_LANCAR := iif(LfrmApuracaoLucroRealLalurLacsCompensacao.chbGerarLancamentoParteB.Checked, '1', '0') ;
          LRegDados.regCRE_APUCDE := LarrDadosAPUCDE ;
          Result := fPersisteApuracaoCompensacao(LRegDados, ADtaVigenciaFinal, AllTipo, LdictValores, AstrCodEmp) ;
        end;
      finally
        pFreeAndNil(LfrmApuracaoLucroRealLalurLacsCompensacaoMult);
      end;
    end;
  finally
    pFreeAndNil(LfrmApuracaoLucroRealLalurLacsCompensacao);
    FreeAndNil(LdictValores) ;
  end;
end;

function fCarregaApuracao(const AStrCodPre: string; const AllTipo: TLacsLalur; var ACdsApuracao: TUniClientDataSet): string;
var
  LQryConsulta: TUniQuery ;
begin
  LQryConsulta := fCriaQuery() ;
  try
    LQryConsulta.Close ;
    LQryConsulta.SQL.Add('SELECT AUTOINCREM FROM APUVRE WHERE VRE_TIPLAN = :TIPLAN AND VRE_CODPRE = :CODPRE ');
    LQryConsulta.ParamByName('TIPLAN').AsString := COD_LACS_LALUR[AllTipo] ;
    LQryConsulta.ParamByName('CODPRE').AsString := AStrCodPre ;
    LQryConsulta.Open ;
    if LQryConsulta.IsEmpty then
    begin
      fIncluirApuracao(AStrCodPre, AllTipo) ;
    end;

    LQryConsulta.Close ;
    LQryConsulta.SQL.Clear ;
    LQryConsulta.SQL.Add(' SELECT ') ;
    LQryConsulta.SQL.Add('   AUTOINCREM, ') ;
    LQryConsulta.SQL.Add('   VRE_CODPRE, ') ;
    LQryConsulta.SQL.Add('   VRE_VLADIC, ') ;
    LQryConsulta.SQL.Add('   VRE_VLEXCL, ') ;
    LQryConsulta.SQL.Add('   VRE_VLBCNG, ') ;
    LQryConsulta.SQL.Add('   VRE_VLCOMP, ') ;
    LQryConsulta.SQL.Add('   VRE_VLRBAS, ') ;
    LQryConsulta.SQL.Add('   VRE_TIPLAN ') ;
    LQryConsulta.SQL.Add(' FROM APUVRE ') ;
    LQryConsulta.SQL.Add(' WHERE VRE_CODPRE = :CODPRE AND VRE_TIPLAN = :TIPLAN ') ;
    LQryConsulta.ParamByName('CODPRE').AsString := AStrCodPre ;
    LQryConsulta.ParamByName('TIPLAN').AsString := COD_LACS_LALUR[AllTipo] ;
    LQryConsulta.Open ;

    if Assigned(ACdsApuracao) then
    begin
      FreeAndNil(ACdsApuracao) ;
    end;

    ACdsApuracao := fCriaClientDatset(LQryConsulta) ;
    result := ACdsApuracao.FieldByName('AUTOINCREM').AsString ;
  finally
    FreeAndNil(LQryConsulta) ;
  end;
end;

function fIncluirApuracao(const AStrCodPre: string; const AllTipo: TLacsLalur): boolean;
var
  LStrInsert: string ;
  LQryExec: TUniQuery ;
begin
  LStrInsert := 'INSERT INTO APUVRE (AUTOINCREM, VRE_CODPRE, VRE_TIPLAN) VALUES (:AUTOINCREM, :CODPRE, :TIPLAN) ;' ;

  LQryExec := fCriaQuery() ;
  try
    fStartTransaction;
    try
      LQryExec.Close ;
      LQryExec.SQL.Clear ;
      LQryExec.SQL.Add(LStrInsert) ;
      LQryExec.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('APUVRE', VS_strCodEmp) ;
      LQryExec.ParamByName('CODPRE').AsString := AStrCodPre ;
      LQryExec.ParamByName('TIPLAN').AsString := COD_LACS_LALUR[AllTipo] ;
      LQryExec.ExecSQL ;
      fCommit ;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        raise E ;
      End;
    end;
  finally
    FreeAndNil(LQryExec) ;
  end;
  result := True ;
end;

procedure pProcessaCalculosApuracao(const AStrCodPre: string; const AllTipo: TLacsLalur; var ARegValores: TValoresApuracao; var ACdsResumoAdicoes, ACdsResumoExclusoes, ACdsCompensacoes: TUniClientDataSet; const AecEncerramento: TEncerramentoContabil; const AstrCodEmp: String);
var
  LQryAdicoesExclusoes: TUniQuery ;
  LQryApupre: TUniQuery ;
  lQryApucre: TUniquery ;
  lQryApucde: TUniquery ;
  LSomaAdicaoCredito, LSomaExclusaoCredito: double ;
  LSomaAdicaoDebito, LSomaExclusaoDebito: double ;
  LAdicao, LExclusao: Double ;
  LfltSomaCompensacaoOperacional: double ;
begin
  // inicializa as variaveis
  ARegValores.fltAdicoes := 0.00 ;
  ARegValores.fltExclusoes := 0.00 ;
  ARegValores.fltBcAntesCompensacao := 0.00 ;
  ARegValores.fltCompensacaoBCNegativa := 0.00 ;
  ARegValores.fltBaseCalculo := 0.00 ;
  ARegValores.strLancarCompensacao := '1' ;
  ACdsResumoAdicoes.EmptyDataSet ;
  ACdsResumoExclusoes.EmptyDataSet ;
  ACdsCompensacoes.EmptyDataSet ;

  LQryAdicoesExclusoes := fCriaQuery() ;
  LQryApupre := fCriaQuery() ;
  LQryApucre := fCriaQuery() ;
  LQryApucde := fCriaQuery() ;
  try
    LQryApupre.Close ;
    LQryApupre.SQL.Clear ;
    LQryApupre.SQL.Add(' SELECT APUPRE.PRE_DTAINI, APUPRE.PRE_DTAFIN, APUVRE.AUTOINCREM ') ;
    LQryApupre.SQL.Add(' FROM APUPRE INNER JOIN APUVRE ON APUPRE.PRE_CODPRE = APUVRE.VRE_CODPRE ') ;
    LQryApupre.SQL.Add(' WHERE APUPRE.PRE_CODPRE = :CODPRE AND APUVRE.VRE_TIPLAN = :TIPLAN ') ;
    LQryApupre.ParamByName('CODPRE').AsString := AStrCodPre ;
    LQryApupre.ParamByName('TIPLAN').AsString := COD_LACS_LALUR[AllTipo] ;
    LQryApupre.Open ;

    pCarregaDadosAjustes(LQryAdicoesExclusoes,
                         LQryApupre.FieldByName('AUTOINCREM').AsString,
                         LQryApupre.FieldByName('PRE_DTAINI').AsDateTime,
                         LQryApupre.FieldByName('PRE_DTAFIN').AsDateTime,
                         AllTipo,
                         AecEncerramento,
                         AstrCodEmp) ;

    LQryApucre.Close ;
    LQryApucre.SQL.Clear ;
    LQryApucre.SQL.Add(' SELECT APUCRE.CRE_PERMAX, ') ;
    LQryApucre.SQL.Add(' APUCRE.AUTOINCREM, ') ;
    LQryApucre.SQL.Add(' APUCRE.CRE_LANCAR ') ;
    LQryApucre.SQL.Add(' FROM APUCRE ') ;
    LQryApucre.SQL.Add(' WHERE APUCRE.CRE_CODVRE = :CODVRE ') ;
    LQryApucre.ParamByName('CODVRE').AsString := LQryApupre.FieldByName('AUTOINCREM').AsString ;
    LQryApucre.Open ;

    LSomaAdicaoCredito := 0.00 ;
    LSomaExclusaoCredito := 0.00 ;
    LSomaAdicaoDebito := 0.00 ;
    LSomaExclusaoDebito := 0.00 ;
    LQryAdicoesExclusoes.DisableControls;
    ACdsResumoAdicoes.DisableControls;
    ACdsResumoExclusoes.DisableControls;
    try
      LQryAdicoesExclusoes.First ;
      while not LQryAdicoesExclusoes.Eof do
      begin
        if LQryAdicoesExclusoes.FieldByName('ARE_TIPLAN').AsString = 'A' then
        begin
          if LQryAdicoesExclusoes.FieldByName('ARE_CREDEB').AsString = 'D' then
            LSomaAdicaoDebito := LSomaAdicaoDebito + LQryAdicoesExclusoes.FieldByName('ARE_VALLAN').AsFloat
          else if LQryAdicoesExclusoes.FieldByName('ARE_CREDEB').AsString = 'C' then
            LSomaAdicaoCredito := LSomaAdicaoCredito + LQryAdicoesExclusoes.FieldByName('ARE_VALLAN').AsFloat ;
          pResumoAdicaoExclusao(ACdsResumoAdicoes, LQryAdicoesExclusoes) ;
        end
        else if LQryAdicoesExclusoes.FieldByName('ARE_TIPLAN').AsString = 'E' then
        begin
          if LQryAdicoesExclusoes.FieldByName('ARE_CREDEB').AsString = 'D' then
            LSomaExclusaoDebito := LSomaExclusaoDebito + LQryAdicoesExclusoes.FieldByName('ARE_VALLAN').AsFloat
          else if LQryAdicoesExclusoes.FieldByName('ARE_CREDEB').AsString = 'C' then
            LSomaExclusaoCredito := LSomaExclusaoCredito + LQryAdicoesExclusoes.FieldByName('ARE_VALLAN').AsFloat ;
          pResumoAdicaoExclusao(ACdsResumoExclusoes, LQryAdicoesExclusoes) ;
        end;
        LQryAdicoesExclusoes.Next ;
      end;
    finally
      LQryAdicoesExclusoes.EnableControls;
      ACdsResumoAdicoes.EnableControls;
      ACdsResumoExclusoes.EnableControls;
    end;

    ///retorno dos calculos
    LAdicao := LSomaAdicaoDebito - LSomaAdicaoCredito ;
    LExclusao := LSomaExclusaoCredito - LSomaExclusaoDebito ;

    ARegValores.fltAdicoes := LAdicao ;
    ARegValores.fltExclusoes := LExclusao ;
    ARegValores.fltBcAntesCompensacao := ARegValores.fltLucroAntes + ARegValores.fltAdicoes - ARegValores.fltExclusoes ;

    ///se valor negativo será feito a exclusão das compensações
    if fFormataFloat(ARegValores.fltBcAntesCompensacao, 2) <= 0.00 then
    begin
      fStartTransaction;
      try
        fEstornaCompensacao(LQryApupre.FieldByName('AUTOINCREM').AsString) ;
        fCommit;
      Except
        On E: Exception Do
        Begin
          fRollBack;
          raise E ;
        End;
      end;
    end;

    LQryApucde.Close ;
    LQryApucde.SQL.Clear ;
    LQryApucde.SQL.Add(' SELECT APUCRE.CRE_CODVRE, CDE_VALLAN, CDE_CTACON, CTACON.CTA_DESCRI ') ;
    LQryApucde.SQL.Add('  FROM APUCRE INNER JOIN APUCDE ON APUCDE.CDE_CODCRE = APUCRE.AUTOINCREM ') ;
    LQryApucde.SQL.Add('              INNER JOIN CTACON ON APUCDE.CDE_CTACON = CTACON.CTA_CODCON ') ;
    LQryApucde.SQL.Add('  WHERE APUCRE.AUTOINCREM = :AUTOINCREM AND COALESCE(CDE_VALLAN, 0.00) <> 0.00 ') ;
    LQryApucde.ParamByName('AUTOINCREM').AsString := LQryApucre.FieldByName('AUTOINCREM').AsString ;
    LQryApucde.Open ;

    LfltSomaCompensacaoOperacional := 0.00 ;
    LQryApucde.First ;
    while not LQryApucde.Eof do
    begin
      LfltSomaCompensacaoOperacional := LfltSomaCompensacaoOperacional + LQryApucde.FieldByName('CDE_VALLAN').AsFloat ;

      ACdsCompensacoes.Append ;
      ACdsCompensacoes.FieldByName('NAT_DESCRI').AsString := LQryApucde.FieldByName('CDE_CTACON').AsString + ' - ' + LQryApucde.FieldByName('CTA_DESCRI').AsString ;
      ACdsCompensacoes.FieldByName('NAT_VALRES').AsFloat := LQryApucde.FieldByName('CDE_VALLAN').AsFloat ;
      ACdsCompensacoes.Post ;

      LQryApucde.Next ;
    end;

    ARegValores.fltCompensacaoBCNegativa := LfltSomaCompensacaoOperacional ;
    ARegValores.strLancarCompensacao := LQryApucre.FieldByName('CRE_LANCAR').AsString ;

    ARegValores.fltBaseCalculo := ARegValores.fltBcAntesCompensacao - ARegValores.fltCompensacaoBCNegativa ;
  finally
    FreeAndNil(LQryAdicoesExclusoes) ;
    FreeAndNil(LQryApupre) ;
    FreeAndNil(LQryApucre) ;
    FreeAndNil(LQryApucde) ;
  end;
end;

procedure pResumoAdicaoExclusao( var ACdsResumo: TUniClientDataSet; const AQryApuracao: TUniQuery);
begin
  if not ACdsResumo.FindKey([AQryApuracao.FieldByName('ARE_NATAJU').AsString, AQryApuracao.FieldByName('ARE_CREDEB').AsString]) then
  begin
    ACdsResumo.Append ;
    ACdsResumo.FieldByName('NAT_CODIGO').AsString := AQryApuracao.FieldByName('ARE_NATAJU').AsString ;
    ACdsResumo.FieldByName('NAT_DESCRI').AsString := AQryApuracao.FieldByName('NAT_DESCRI').AsString ;
    ACdsResumo.FieldByName('NAT_VALRES').AsFloat := AQryApuracao.FieldByName('ARE_VALLAN').AsFloat ;
    ACdsResumo.FieldByName('CREDEB').AsString := AQryApuracao.FieldByName('ARE_CREDEB').AsString ;
    ACdsResumo.Post ;
  end
  else
  begin
    ACdsResumo.Edit ;
    ACdsResumo.FieldByName('NAT_VALRES').AsFloat := ACdsResumo.FieldByName('NAT_VALRES').AsFloat + AQryApuracao.FieldByName('ARE_VALLAN').AsFloat ;
    ACdsResumo.Post ;
  end;
end;

procedure pCriaEstruturaResumoApuracao(var ACdsResumoAdicoes, ACdsResumoExclusoes, ACdsCompensacoes: TUniClientDataSet);
begin
  ACdsResumoAdicoes := fCriaClientDataset('SELECT NAT_CODIGO, NAT_DESCRI, CAST(0.00 AS DECIMAL(14,2)) AS NAT_VALRES, CAST("" AS CHAR(1)) AS CREDEB FROM NATAJU WHERE FALSE ') ;
  ACdsResumoExclusoes := fCriaClientDataset('SELECT NAT_CODIGO, NAT_DESCRI, CAST(0.00 AS DECIMAL(14,2)) AS NAT_VALRES, CAST("" AS CHAR(1)) AS CREDEB FROM NATAJU WHERE FALSE ') ;
  ACdsCompensacoes := fCriaClientDataset('SELECT NAT_CODIGO, NAT_DESCRI, CAST(0.00 AS DECIMAL(14,2)) AS NAT_VALRES FROM NATAJU WHERE FALSE ') ;
  ///indices
  ACdsResumoAdicoes.IndexFieldNames := 'NAT_CODIGO;CREDEB' ;
  ACdsResumoExclusoes.IndexFieldNames := 'NAT_CODIGO;CREDEB' ;
  ACdsCompensacoes.IndexFieldNames := 'NAT_CODIGO' ;
end;

procedure pCarregaCompensacao(var AqryApucre: TUniQuery; const AStrCodigo: string);
begin
  AqryApucre.Close ;
  AqryApucre.SQL.Clear ;
  AqryApucre.SQL.Add('SELECT AUTOINCREM, CRE_PERMAX, CRE_LANCAR FROM APUCRE WHERE CRE_CODVRE = :CODVRE') ;
  AqryApucre.ParamByName('CODVRE').AsString := AStrCodigo ;
  AqryApucre.Open ;
end;

procedure pRetornaSaldoCompesacao(const AdtaVigenciaInicial: TDateTime; const AllTipo: TLacsLalur; var AfltOperacionalOuBaseNegativa, AfltNaoOperacional: double; const AstrCodEmp: String);
var
  LqrySaldos: TUniQuery ;
begin
  AfltOperacionalOuBaseNegativa := 0.00;
  AfltNaoOperacional := 0.00;

  LqrySaldos := fCriaQuery() ;
  try
    ///operacional (lalur) ou base negativa (lacs)
    pCarregaQueryOperacional(LqrySaldos, AllTipo) ;
    LqrySaldos.ParamByName('CODEMP').AsString := AstrCodEmp ;
    LqrySaldos.ParamByName('DTALAN').AsDateTime := AdtaVigenciaInicial ;
    LqrySaldos.Open ;
    LqrySaldos.First ;
    LqrySaldos.DisableControls ;
    try
      while not LqrySaldos.Eof do
      begin
        if LqrySaldos.FieldByName('SAL_CREDEB').AsString = 'C' then
        begin
          AfltOperacionalOuBaseNegativa := AfltOperacionalOuBaseNegativa + fFormataFloat(LqrySaldos.FieldByName('SAL_VALLAN').AsFloat, 2) ;
        end
        else if LqrySaldos.FieldByName('SAL_CREDEB').AsString = 'D' then
        begin
          AfltOperacionalOuBaseNegativa := AfltOperacionalOuBaseNegativa - fFormataFloat(LqrySaldos.FieldByName('SAL_VALLAN').AsFloat, 2) ;
        end;
        LqrySaldos.Next ;
      end;
    finally
      LqrySaldos.EnableControls ;
    end;

    //não operacional (lalur)
    pCarregaQueryNaoOperacional(LqrySaldos, AllTipo) ;
    LqrySaldos.ParamByName('CODEMP').AsString := AstrCodEmp ;
    LqrySaldos.ParamByName('DTALAN').AsDateTime := AdtaVigenciaInicial ;
    LqrySaldos.Open ;
    LqrySaldos.First ;
    LqrySaldos.DisableControls ;
    try
      while not LqrySaldos.Eof do
      begin
        if LqrySaldos.FieldByName('SAL_CREDEB').AsString = 'C' then
        begin
          AfltNaoOperacional := AfltNaoOperacional + fFormataFloat(LqrySaldos.FieldByName('SAL_VALLAN').AsFloat, 2) ;
        end
        else if LqrySaldos.FieldByName('SAL_CREDEB').AsString = 'D' then
        begin
          AfltNaoOperacional := AfltNaoOperacional - fFormataFloat(LqrySaldos.FieldByName('SAL_VALLAN').AsFloat, 2) ;
        end;
        LqrySaldos.Next ;
      end;
    finally
      LqrySaldos.EnableControls ;
    end;
  finally
    FreeAndNil(LqrySaldos) ;
  end;
end;

procedure pCarregaQueryNaoOperacional(var AqryConsulta: TUniquery; const AllTipo: TLacsLalur);
begin
  AqryConsulta.Close ;
  AqryConsulta.SQL.Clear ;
  AqryConsulta.SQL.Add(' SELECT SALCCB.SAL_CTACON, SALCCB.AUTOINCREM, SALCCB.SAL_VALLAN, SALCCB.SAL_CREDEB ') ;
  AqryConsulta.SQL.Add(' FROM SALCCB INNER JOIN CTACON ON SALCCB.SAL_CTACON = CTACON.CTA_CODCON ') ;
  AqryConsulta.SQL.Add(' WHERE SALCCB.SAL_CODEMP = :CODEMP ') ;
  AqryConsulta.SQL.Add('       AND SALCCB.SAL_DTALAN < :DTALAN ') ;
  if AllTipo = llLalur then
  begin
    AqryConsulta.SQL.Add('       AND CTACON.CTA_GRLALU = "S" ') ;
    AqryConsulta.SQL.Add('       AND CTACON.CTA_TBDBLU = :TBDBLU ') ;
    AqryConsulta.ParamByName('TBDBLU').AsString := COD_PREJUIZO_FISCAL_NAO_OPERACIONAL ;
  end
  else
  begin
    AqryConsulta.SQL.Add('       AND FALSE ') ;
  end;
  AqryConsulta.SQL.Add(' ORDER BY SALCCB.SAL_CTACON, SALCCB.SAL_DTALAN, SALCCB.AUTOINCREM ') ;
end;

procedure pCarregaQueryOperacional(var AqryConsulta: TUniquery;const AllTipo: TLacsLalur) ;
begin
  AqryConsulta.Close ;
  AqryConsulta.SQL.Clear ;
  AqryConsulta.SQL.Add(' SELECT SALCCB.SAL_CTACON, SALCCB.AUTOINCREM, SALCCB.SAL_VALLAN, SALCCB.SAL_CREDEB ') ;
  AqryConsulta.SQL.Add(' FROM SALCCB INNER JOIN CTACON ON SALCCB.SAL_CTACON = CTACON.CTA_CODCON ') ;
  AqryConsulta.SQL.Add(' WHERE SALCCB.SAL_CODEMP = :CODEMP ') ;
  AqryConsulta.SQL.Add('       AND SALCCB.SAL_DTALAN < :DTALAN ') ;
  if AllTipo = llLacs then
  begin
    AqryConsulta.SQL.Add('       AND CTACON.CTA_GRLACS = "S" ') ;
    AqryConsulta.SQL.Add('       AND CTACON.CTA_TBDBLA = :TBDBLA ') ;
    AqryConsulta.ParamByName('TBDBLA').AsString := COD_BASE_CALCULO_NEGATIVA_CSLL ;
  end
  else if AllTipo = llLalur then
  begin
    AqryConsulta.SQL.Add('       AND CTACON.CTA_GRLALU = "S" ') ;
    AqryConsulta.SQL.Add('       AND CTACON.CTA_TBDBLU = :TBDBLU ') ;
    AqryConsulta.ParamByName('TBDBLU').AsString := COD_PREJUIZO_FISCAL_OPERACIONAL ;
  end
  else
  begin
    AqryConsulta.SQL.Add('       AND FALSE ') ;
  end;
  AqryConsulta.SQL.Add(' ORDER BY SALCCB.SAL_CTACON, SALCCB.SAL_DTALAN, SALCCB.AUTOINCREM ') ;
end;

function fCalculaCompensacaoBcNegativa(const AfltPercentual, AfltBCAntesCompensacao, AfltOPEANT: double): double ;
var
  LfltCompensacaoBCNegativa: double ;
begin
  LfltCompensacaoBCNegativa := fFormataFloat(AfltBCAntesCompensacao * (AfltPercentual/100), 2) ;
  if AfltOPEANT > LfltCompensacaoBCNegativa then
  begin
    Result := LfltCompensacaoBCNegativa ;
  end
  else
  begin
    Result := AfltOPEANT ;
  end;
end;

procedure pRetornaResumoCompesacao(const AdtaVigenciaInicial: TDateTime; const AllTipo: TLacsLalur; var AcdsRetornoOperacional, AcdsRetornoNaoOperacional: TUniClientDataSet; const AstrCodEmp: String);
var
  LqrySaldos: TUniQuery ;
  LdicContasSaldos: TDictionary<string,double> ;
  LstrCtaCon: string ;
  LpairItem: TPair<string, double>;
begin
  AcdsRetornoOperacional.EmptyDataSet;
  AcdsRetornoNaoOperacional.EmptyDataSet;

  LqrySaldos := fCriaQuery() ;
  LdicContasSaldos := TDictionary<string,double>.Create ;
  try
    ///operacional (lalur) ou base negativa (lacs)
    pCarregaQueryOperacional(LqrySaldos, AllTipo) ;
    LqrySaldos.ParamByName('CODEMP').AsString := AstrCodEmp ;
    LqrySaldos.ParamByName('DTALAN').AsDateTime := AdtaVigenciaInicial ;
    LqrySaldos.Open ;
    LqrySaldos.First ;
    LqrySaldos.DisableControls ;
    try
      while not LqrySaldos.Eof do
      begin
        LstrCtaCon := LqrySaldos.FieldByName('SAL_CTACON').AsString ;
        if not LdicContasSaldos.ContainsKey(LstrCtaCon) then
        begin
          LdicContasSaldos.Add(LstrCtaCon, 0.00);
        end;
        LdicContasSaldos.Items[LstrCtaCon] := fAcumulaSaldoCompensacao(LqrySaldos.FieldByName('SAL_CREDEB').AsString, LdicContasSaldos.Items[LstrCtaCon], LqrySaldos.FieldByName('SAL_VALLAN').AsFloat) ;
        LqrySaldos.Next ;
      end;
    finally
      LqrySaldos.EnableControls ;
    end;

    ///popula o cds
    for LpairItem in LdicContasSaldos do
    begin

      if fFormataFloat(LpairItem.Value,2) = 0.00 then
      begin
        Continue ;
      end;

      AcdsRetornoOperacional.Append ;
      AcdsRetornoOperacional.FieldByName('CTA_CODCON').AsString := LpairItem.Key ;
      AcdsRetornoOperacional.FieldByName('CTA_DESCRI').AsString := LpairItem.Key + ' - ' + fCampoTabela('CTA_DESCRI', 'CTACON', ['CTA_CODCON'], [LpairItem.Key]) ;
      AcdsRetornoOperacional.FieldByName('CTA_VLDISP').AsFloat := fFormataFloat(LpairItem.Value, 2) ;
      AcdsRetornoOperacional.FieldByName('CTA_VLACOM').AsFloat := 0.00 ;
      AcdsRetornoOperacional.FieldByName('CTA_VLRSAL').AsFloat := fFormataFloat(LpairItem.Value, 2) ;
      AcdsRetornoOperacional.Post ;
    end;

    //Não Operacional
    LdicContasSaldos.Clear ;
    LdicContasSaldos.TrimExcess ;
    pCarregaQueryNaoOperacional(LqrySaldos, AllTipo) ;
    LqrySaldos.ParamByName('CODEMP').AsString := AstrCodEmp ;
    LqrySaldos.ParamByName('DTALAN').AsDateTime := AdtaVigenciaInicial ;
    LqrySaldos.Open ;
    LqrySaldos.First ;
    LqrySaldos.DisableControls ;
    try
      while not LqrySaldos.Eof do
      begin
        LstrCtaCon := LqrySaldos.FieldByName('SAL_CTACON').AsString ;
        if not LdicContasSaldos.ContainsKey(LstrCtaCon) then
        begin
          LdicContasSaldos.Add(LstrCtaCon, 0.00);
        end;

        LdicContasSaldos.Items[LstrCtaCon] := fAcumulaSaldoCompensacao(LqrySaldos.FieldByName('SAL_CREDEB').AsString, LdicContasSaldos.Items[LstrCtaCon], LqrySaldos.FieldByName('SAL_VALLAN').AsFloat) ;
        LqrySaldos.Next ;
      end;
    finally
      LqrySaldos.EnableControls ;
    end;

    ///popula o cds
    for LpairItem in LdicContasSaldos do
    begin
      if fFormataFloat(LpairItem.Value,2) = 0.00 then
      begin
        Continue ;
      end;
      AcdsRetornoNaoOperacional.Append ;
      AcdsRetornoNaoOperacional.FieldByName('CTA_CODCON').AsString := LpairItem.Key ;
      AcdsRetornoNaoOperacional.FieldByName('CTA_DESCRI').AsString := LpairItem.Key + ' - ' + fCampoTabela('CTA_DESCRI', 'CTACON', ['CTA_CODCON'], [LpairItem.Key]) ;
      AcdsRetornoNaoOperacional.FieldByName('CTA_VLDISP').AsFloat := fFormataFloat(LpairItem.Value, 2) ;
      AcdsRetornoNaoOperacional.FieldByName('CTA_VLACOM').AsFloat := 0.00 ;
      AcdsRetornoNaoOperacional.FieldByName('CTA_VLRSAL').AsFloat := fFormataFloat(LpairItem.Value, 2) ;
      AcdsRetornoNaoOperacional.Post ;
    end;
  finally
    FreeAndNil(LqrySaldos) ;
    FreeAndNil(LdicContasSaldos) ;
  end;
end;

procedure pCriaEstruturaACompensar(var AcdsCompensacoes: TUniClientDataSet);
begin
  AcdsCompensacoes := fCriaClientDataset('SELECT CTA_CODCON, CTA_DESCRI, CAST(NULL AS DECIMAL(14,2)) AS CTA_VLDISP, CAST(NULL AS DECIMAL(14,2)) AS CTA_VLACOM, CAST(NULL AS DECIMAL(14,2)) AS CTA_VLRSAL FROM CTACON WHERE FALSE ; ') ;
  ///indices
  AcdsCompensacoes.IndexFieldNames := 'CTA_CODCON' ;
end;

function fLancaCompensacaoDebito(const AstrCodVre, AstrLancar: string; const AdictValores: TDictionary<String, double>; const ADtaLancamento: TDateTime; const AllTipo: TLacsLalur; const AstrCodEmp: String):boolean;
var
  LqryExec: TUniQuery ;
  LqryApuSal: TUniQuery ;
  LstrSql: string ;
  LpairItem: TPair<string, double>;
  LintCodigo: integer;
  LecEncerramento: TEncerramentoContabil ;
begin
  LecEncerramento := fRetornaEncerramentoContabil(AstrCodEmp, intTostr(YearOf(ADtaLancamento))) ;
  if LecEncerramento = ecAnual then
  begin
    if ADtaLancamento <> EncodeDate(YearOf(ADtaLancamento),12,31) then
    begin
      result := True ;
      exit ;
    end;
  end;

  LqryExec := fCriaQuery() ;
  LqryApuSal := fCriaQuery() ;
  try

    ///apaga os lançamentos de saldos para relançar
    LstrSql := 'SELECT SAL_CODSAL FROM APUSAL WHERE SAL_CODVRE = :CODVRE ' ;
    LqryApuSal.Close ;
    LqryApuSal.SQL.Clear ;
    LqryApuSal.SQL.Add(LstrSql) ;
    LqryApuSal.ParamByName('CODVRE').AsString := AstrCodVre ;
    LqryApuSal.Open ;
    LqryApuSal.First ;
    while not LqryApuSal.Eof do
    begin

      LstrSql := 'DELETE FROM SALCCB WHERE AUTOINCREM = :AUTOINCREM ' ;
      LqryExec.Close ;
      LqryExec.SQL.Clear ;
      LqryExec.SQL.Add(LstrSql) ;
      LqryExec.ParamByName('AUTOINCREM').AsInteger := LqryApuSal.FieldByName('SAL_CODSAL').AsInteger ;
      LqryExec.ExecSQL ;

      LqryApuSal.Next ;
    end ;


    if (AdictValores.Count > 0) and (AstrLancar = '1') then
    begin

      for LpairItem in AdictValores do
      begin
        if fFormataFloat(LpairItem.Value, 2) = 0.00 then
        begin
          continue ;
        end;

        LstrSql := 'INSERT INTO SALCCB (SAL_CTACON, SAL_DTALAN, SAL_HISTOR, SAL_VALLAN, SAL_CREDEB, SAL_CODEMP) VALUES (:CTACON, :DTALAN, :HISTOR, :VALLAN, :CREDEB, :CODEMP) ;' ;
        LqryExec.Close ;
        LqryExec.SQL.Clear ;
        LqryExec.SQL.Add(LstrSql) ;
        LqryExec.ParamByName('CTACON').AsString := LpairItem.Key ;
        LqryExec.ParamByName('DTALAN').AsDate := ADtaLancamento ;
        LqryExec.ParamByName('HISTOR').AsString := iif(AllTipo = llLalur, 'Compensação de Prejuízos Fiscais Operacionais', 'Compensação da BC Negativa da CSLL') ; ;
        LqryExec.ParamByName('VALLAN').AsFloat := LpairItem.Value ;
        LqryExec.ParamByName('CREDEB').AsString := 'D' ;
        LqryExec.ParamByName('CODEMP').AsString := AstrCodEmp ;
        LqryExec.ExecSQL ;

        LstrSql := 'SELECT MAX(AUTOINCREM) AS CODIGO FROM SALCCB;' ;
        LqryExec.Close ;
        LqryExec.SQL.Clear ;
        LqryExec.SQL.Add(LstrSql) ;
        LqryExec.Open ;
        LintCodigo := LqryExec.FieldByName('CODIGO').AsInteger ;

        LstrSql := 'INSERT INTO APUSAL (AUTOINCREM, SAL_CODVRE, SAL_CODSAL) VALUES (:AUTOINCREM, :CODVRE, :CODSAL);' ;
        LqryExec.Close ;
        LqryExec.SQL.Clear ;
        LqryExec.SQL.Add(LstrSql) ;
        LqryExec.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('APUSAL', VS_strCodEmp) ;
        LqryExec.ParamByName('CODVRE').AsString := AstrCodVre ;
        LqryExec.ParamByName('CODSAL').AsInteger := LIntCodigo ;
        LqryExec.ExecSQL ;
      end;
    end;

  finally
    FreeAndNil(LqryExec) ;
    FreeAndNil(LqryApuSal) ;
  end;

  result := true ;
end;

procedure pCarregaACompensarInformado(var AcdsCompensacoes: TUniClientDataSet; const AstrAutoIncCompensacao: string);
var
  LqryValores: TUniQuery ;
begin
  LqryValores := fCriaQuery ;
  try
    LqryValores.Close ;
    LqryValores.SQL.Clear ;
    LqryValores.SQL.Add(' SELECT APUCRE.CRE_CODVRE, CDE_VALLAN, CDE_CTACON ') ;
    LqryValores.SQL.Add('  FROM APUCRE INNER JOIN APUCDE ON APUCDE.CDE_CODCRE = APUCRE.AUTOINCREM ') ;
    LqryValores.SQL.Add('  WHERE APUCRE.AUTOINCREM = :AUTOINCREM') ;
    LqryValores.ParamByName('AUTOINCREM').AsString := AstrAutoIncCompensacao ;
    LqryValores.Open ;
    LqryValores.First ;
    while not LqryValores.Eof do
    begin
      if AcdsCompensacoes.FindKey([LqryValores.FieldByName('CDE_CTACON').AsString]) then
      begin
        AcdsCompensacoes.Edit ;
        AcdsCompensacoes.FieldByName('CTA_VLACOM').AsFloat := LqryValores.FieldByName('CDE_VALLAN').AsFloat ;
        ///ajusta o saldo restante
        AcdsCompensacoes.FieldByName('CTA_VLRSAL').AsFloat := AcdsCompensacoes.FieldByName('CTA_VLDISP').AsFloat - AcdsCompensacoes.FieldByName('CTA_VLACOM').AsFloat ;
        AcdsCompensacoes.Post ;
      end;
      LqryValores.Next ;
    end;
    AcdsCompensacoes.First ;
  finally
    FreeAndNil(LqryValores) ;
  end;
end;

function fRetornaContaControladaBCNegativa(const AblnPodeLancar: boolean; const AllTipo: TLacsLalur):string ;
var
  LintRetorno: integer ;
  LfrmApuracaoLucroRealLalurLacsPesqCtaCon: TfrmApuracaoLucroRealLalurLacsPesqCtaCon ;
  LfrmCadContasControladas: TfrmCadContasControladas ;
begin
  result := '' ;
  if not AblnPodeLancar then
  begin
    exit ;
  end;

  LintRetorno := fGetMenu(iif(AllTipo = llLacs, 'Base de Cálculo da CSLL Negativa', 'Base de Cálculo do IRPJ Negativa'), ['Utilizar uma conta controlada existente', 'Cadastrar uma nova conta controlada'], 1, True) ;

  if LintRetorno = 1 then
  begin
    pCriarFormularios(TfrmApuracaoLucroRealLalurLacsPesqCtaCon, LfrmApuracaoLucroRealLalurLacsPesqCtaCon) ;
    try
      LfrmApuracaoLucroRealLalurLacsPesqCtaCon.Tipo := AllTipo ;
      if LfrmApuracaoLucroRealLalurLacsPesqCtaCon.ShowModal = mrOK then
      begin
        result := LfrmApuracaoLucroRealLalurLacsPesqCtaCon.CodigoContaControlada ;
      end;
    finally
      pFreeAndNil(LfrmApuracaoLucroRealLalurLacsPesqCtaCon);
    end;
  end
  else if LintRetorno = 2 then
  begin
    pCriarFormularios(TfrmCadContasControladas, LfrmCadContasControladas) ;
    try
      LfrmCadContasControladas.btnPesquisa.Visible := False ;
      LfrmCadContasControladas.Tipo := AllTipo ;
      LfrmCadContasControladas.ShowModal ;
      result := LfrmCadContasControladas.CodigoContaControlada ;
    finally
      pFreeAndNil(LfrmCadContasControladas);
    end;
  end;

end;

function fEstornaCompensacao(const AstrCRE_CODVRE: string):boolean ;
var
  LQryExec: TUniQuery ;
begin
  LQryExec := fCriaQuery ;
  try
    /// exclui
    LQryExec.Close ;
    LQryExec.SQL.Clear ;
    LQryExec.SQL.Add('DELETE FROM APUCRE WHERE CRE_CODVRE = :CODVRE ') ;
    LQryExec.ParamByName('CODVRE').AsString := AstrCRE_CODVRE ;
    LQryExec.ExecSQL ;
  finally
    FreeAndNil(LQryExec) ;
  end;
  result := True ;
end;

function fAcumulaSaldoCompensacao(const AstrCredDeb: string; const AfltSaldo, AfltValLan: double):double ;
begin
  result := 0 ;
  if AstrCredDeb = 'C' then
  begin
    result := AfltSaldo + AfltValLan ;
  end
  else if AstrCredDeb = 'D' then
  begin
    result := AfltSaldo - AfltValLan ;
  end;
end;

procedure pPeriodoEncerramento(const AStrExercicio: string; const AecEncerramento: TEncerramentoContabil; var AlstPeriodo: TStrings) ;
var
  LIntMes: integer ;
  LDictInfoPeriodo: TDictionary<string,TDateTime> ;
begin
  AlstPeriodo.BeginUpdate ;
  try
    if AecEncerramento in [ecMensal, ecAnual] then
    begin
      for LIntMes := 1 to 12 do
      begin
        LDictInfoPeriodo := TDictionary<string,TDateTime>.Create();
        LDictInfoPeriodo.Add('inicio', EncodeDate(strtoint(AStrExercicio), 1, 1)) ; //sempre será do primeiro dia do ano (periodo acumulado)
        LDictInfoPeriodo.Add('final', DateOf(EndOfAMonth(strtoint(AStrExercicio), LIntMes))) ;
        AlstPeriodo.AddObject(fRetMes(LIntMes), LDictInfoPeriodo) ;
      end;
    end
    else if AecEncerramento = ecTrimestral then
    begin
      LDictInfoPeriodo := TDictionary<string,TDateTime>.Create();
      LDictInfoPeriodo.Add('inicio', EncodeDate(strtoint(AStrExercicio), 1, 1)) ;
      LDictInfoPeriodo.Add('final', EncodeDate(strtoint(AStrExercicio), 3, 31)) ;
      AlstPeriodo.AddObject('1º Trimestre', LDictInfoPeriodo) ;

      LDictInfoPeriodo := TDictionary<string,TDateTime>.Create();
      LDictInfoPeriodo.Add('inicio', EncodeDate(strtoint(AStrExercicio), 4, 1)) ;
      LDictInfoPeriodo.Add('final', EncodeDate(strtoint(AStrExercicio), 6, 30)) ;
      AlstPeriodo.AddObject('2º Trimestre', LDictInfoPeriodo) ;

      LDictInfoPeriodo := TDictionary<string,TDateTime>.Create();
      LDictInfoPeriodo.Add('inicio', EncodeDate(strtoint(AStrExercicio), 7, 1)) ;
      LDictInfoPeriodo.Add('final', EncodeDate(strtoint(AStrExercicio), 9, 30)) ;
      AlstPeriodo.AddObject('3º Trimestre', LDictInfoPeriodo) ;

      LDictInfoPeriodo := TDictionary<string,TDateTime>.Create();
      LDictInfoPeriodo.Add('inicio', EncodeDate(strtoint(AStrExercicio), 10, 1)) ;
      LDictInfoPeriodo.Add('final', EncodeDate(strtoint(AStrExercicio), 12, 31)) ;
      AlstPeriodo.AddObject('4º Trimestre', LDictInfoPeriodo) ;
    end;

  finally
    AlstPeriodo.EndUpdate ;
  end;
end;

procedure pAjustaPeriodoEncerramento(const AStrExercicio: string; const AecEncerramento: TEncerramentoContabil; var AedtPeriodo: TcxComboBox);
var
  LlstAux: TStrings ;
  LevtEvento: TNotifyEvent ;
begin
  LevtEvento := AedtPeriodo.Properties.OnChange ;
  AedtPeriodo.Properties.OnChange := Nil ;
  try
    pLimparPeriodoEncerramento(AedtPeriodo) ;

    LlstAux := AedtPeriodo.Properties.Items ;
    pPeriodoEncerramento(AStrExercicio, AecEncerramento, LlstAux) ;
  finally
    AedtPeriodo.Properties.OnChange := LevtEvento ;
  end ;

  AedtPeriodo.ItemIndex := 0 ;
end;

procedure pLimparPeriodoEncerramento(var AedtPeriodo: TcxComboBox);
var
  LlstAux: TStrings ;
  LevtEvento: TNotifyEvent ;
begin
  LevtEvento := AedtPeriodo.Properties.OnChange ;
  AedtPeriodo.Properties.OnChange := Nil ;

  try
    LlstAux := AedtPeriodo.Properties.Items ;
    pLimparInstanciasPeriodoEncerramento(LlstAux) ;
  finally
    AedtPeriodo.Properties.OnChange := LevtEvento ;
  end ;

end;

procedure pLimparInstanciasPeriodoEncerramento(var AlstPeriodo: TStrings) ;
var
  LIntCnt: integer ;
  LObjItem: TObject ;
begin
  for LIntCnt := 0 to AlstPeriodo.Count-1 do
  begin
    if Assigned(AlstPeriodo.Objects[LIntCnt]) then
    begin
      LObjItem := AlstPeriodo.Objects[LIntCnt] ;
      FreeAndNil(LObjItem) ;
    end;
  end;
  AlstPeriodo.Clear ;
end;

end.
