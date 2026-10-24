unit Contabilidade.OutrosFechamentos.Funcoes;

interface

uses
  untTypesSistema, DateUtils ;

type
  TTiposFechamentos = (tfEstoque, tfFinanceiro, tfFiscal) ;
  TOutrosFechamentos = class
  private
    class function fGravaFechamentoFinanceiro(const AarrEmpSel: TConsultasArray; const AdtaFechamento: TDateTime): Boolean ;
    class function fGravaFechamentoFiscal(const AarrEmpSel: TConsultasArray; const AdtaFechamento: TDateTime): Boolean ;
    class function fGravaFechamentoEstoque(const AarrEmpSel: TConsultasArray; const AdtaFechamento: TDateTime): Boolean ;

    class function fDeletaFechamentoFinanceiro(const AstrCodEmp: String; AdtaFechamento: TDateTime): Boolean ;
    class function fDeletaFechamentoFiscal(const AstrCodEmp: String; AdtaFechamento: TDateTime): Boolean ;
    class function fDeletaFechamentoEstoque(const AstrCodEmp: String; AdtaFechamento: TDateTime): Boolean ;
    class function fTemFecMesInterno(const AstrCodEmp: String; const AdtaFechamento: TDateTime): Boolean ;
    class function fPodeVincularFechamento(const ATipo: TTiposFechamentos): Boolean ;
    class function fFecCnt: Boolean ;
  public
    class function fGravaFechamento(const AarrEmpSel: TConsultasArray; const AdtaFechamento: TDateTime; var AstrMsgErro: String): Boolean ;
    class function fDeletaFechamento(const AstrCodEmp: String; const AdtaFechamento: TDateTime; var AstrMsgErro: String): Boolean ;
    class function fPodeDeletarFechamento(const AstrCodEmp: String; const AdtaFechamento: TDateTime): Boolean ; overload ;
    class function fPodeDeletarFechamento(const AstrCodEmp: String; const AintMes, AintAno: Integer): Boolean ; overload ;
    class function fTemFecMes(const AstrCodEmp: String; const AdtaFechamento: TDateTime): Boolean ; overload ;
    class function fTemFecMes(const AstrCodEmp: String; const AintMes, AintAno: Integer): Boolean ; overload ;
    class function fContabilidadeLigada: Boolean ;
  end ;

implementation

uses
  untFechamentoFinanceiro, untFechamentoEstoque, untFechamentoFiscal, SysUtils,
  UniClientDataSet, UniDataSetProvider, untZClient, untFuncoesSimples, DB, Uni ;

const
   ERRO_FINANCEIRO = 'fechamento financeiro' ;
   ERRO_FISCAL     = 'fechamento fiscal' ;
   ERRO_ESTOQUE    = 'fechamento estoque' ;

  class function TOutrosFechamentos.fGravaFechamentoFinanceiro(const AarrEmpSel: TConsultasArray; const AdtaFechamento: TDateTime): Boolean ;
  var
    LobjFechamento: TFechamentoFinanceiro;
    LcdsUltimoFechamento: TUniClientDataSet;
    LdspUltimoFechamento: TUniDataSetProvider;
    LintCnt: Integer ;
  begin
    if not fPodeVincularFechamento(tfFinanceiro) then
      Exit(True) ;

    LobjFechamento := TFechamentoFinanceiro.Create(Nil,'Contabilidade.OutrosFechamentos.Funcoes');
    LcdsUltimoFechamento := TUniClientDataSet.Create(Nil);
    LdspUltimoFechamento := TUniDataSetProvider.Create(Nil);
    try
      LobjFechamento.Contabilidade := True ;

      if not LobjFechamento.CarregaUltimos24Fechamentos(LcdsUltimoFechamento, LdspUltimoFechamento, Nil) then
        Exit(False);

      LcdsUltimoFechamento.IndexFieldNames := 'FEC_CODEMP;FEC_DTAREF' ;

      for LintCnt := Low(AarrEmpSel) to High(AarrEmpSel) do
      begin
        if LcdsUltimoFechamento.FindKey([AarrEmpSel[LintCnt].strCodigo, AdtaFechamento]) then
          Continue ;

        LobjFechamento.IncluiFechamento(AarrEmpSel[LintCnt].strCodigo, AdtaFechamento) ;
      end ;

      Result := True ;
    finally
      FreeAndNil(LobjFechamento) ;
      FreeAndNil(LcdsUltimoFechamento) ;
      FreeAndNil(LdspUltimoFechamento) ;
    end ;
  end ;

  class function TOutrosFechamentos.fGravaFechamentoFiscal(const AarrEmpSel: TConsultasArray; const AdtaFechamento: TDateTime): Boolean ;
  var
    LobjFechamento: TFechamentoFiscal;
    LcdsUltimos24: TZClient;
    LintCnt: Integer ;
  begin
    if not fPodeVincularFechamento(tfFiscal) then
      Exit(True) ;

    LcdsUltimos24 := Nil ;
    LobjFechamento := TFechamentoFiscal.Create(Nil);
    try
      LobjFechamento.Contabilidade := True ;

      if not LobjFechamento.fCarregaUltimos24 then
        Exit(False);

      LcdsUltimos24 := LobjFechamento.cdsUltimos24 ;
      LcdsUltimos24.IndexFieldNames := 'FEC_CODEMP;FEC_DTAREF' ;

      for LintCnt := Low(AarrEmpSel) to High(AarrEmpSel) do
      begin
        if LcdsUltimos24.FindKey([AarrEmpSel[LintCnt].strCodigo, AdtaFechamento]) then
          Continue ;

        LobjFechamento.fIncluiFechamento(AarrEmpSel[LintCnt].strCodigo, AdtaFechamento) ;
      end ;

      Result := True ;

    finally
      if Assigned(LcdsUltimos24) then
        FreeAndNil(LcdsUltimos24) ;

      LobjFechamento.cdsUltimos24 := nil;

      FreeAndNil(LobjFechamento) ;
    end ;
  end ;

class function TOutrosFechamentos.fPodeDeletarFechamento(
  const AstrCodEmp: String; const AintMes, AintAno: Integer): Boolean;
var
  LdtaFechamento: TDateTime ;
begin
  LdtaFechamento :=  DateOf(EndOfAMonth(AintAno, AintMes)) ;
  Result := Self.fPodeDeletarFechamento(AstrCodEmp, LdtaFechamento) ;
end;

class function TOutrosFechamentos.fPodeVincularFechamento(
  const ATipo: TTiposFechamentos): Boolean;
begin
  Result := False ;

  if not Self.fFecCnt then
    Exit ;

  case ATipo of
    tfEstoque:    Result := fTabelaExiste('CADFEC') ;
    tfFinanceiro: Result := fTabelaExiste('FECFIN') ;
    tfFiscal:     Result := fTabelaExiste('FECFIS') ;
  end ;
end;

class function TOutrosFechamentos.fTemFecMes(const AstrCodEmp: String;
  const AdtaFechamento: TDateTime): Boolean;
begin
  Result := False ;

  if not Self.fContabilidadeLigada then
    Exit ;

  Result := fTemFecMesInterno(AstrCodEmp, AdtaFechamento) ;
end;

class function TOutrosFechamentos.fTemFecMes(const AstrCodEmp: String;
  const AintMes, AintAno: Integer): Boolean;
var
  LdtaFechamento: TDateTime ;
begin
  LdtaFechamento :=  DateOf(EndOfAMonth(AintAno, AintMes)) ;

  Result := Self.fTemFecMes(AstrCodEmp, LdtaFechamento) ;
end;

class function TOutrosFechamentos.fTemFecMesInterno(const AstrCodEmp: String;
  const AdtaFechamento: TDateTime): Boolean;
var
  LqryConsulta: TUniQuery ;
begin
  LqryConsulta := fCriaQuery() ;
  try
    LqryConsulta.Close ;
    LqryConsulta.SQL.Clear ;
    LqryConsulta.SQL.Add(' SELECT AUTOINCREM FROM FECMES WHERE MES_MESDTA = :MESDTA AND MES_CODEMP = :CODEMP ') ;
    LqryConsulta.ParamByName('MESDTA').AsDate := AdtaFechamento ;
    LqryConsulta.ParamByName('CODEMP').AsString := AstrCodEmp ;
    LqryConsulta.Open ;

    Result := not LqryConsulta.IsEmpty ;

  finally
    FreeAndNil(LqryConsulta) ;
  end ;
end;

class function TOutrosFechamentos.fPodeDeletarFechamento(
  const AstrCodEmp: String; const AdtaFechamento: TDateTime): Boolean;
begin
  Result := True ;

  if not Self.fContabilidadeLigada then
    Exit ;

  Result := not fTemFecMesInterno(AstrCodEmp, AdtaFechamento) ;

  if not Result then
    pMensagemOk('A Exclusão desse Fechamento não poderá ser realizado, ' +
                'em razão do mesmo corresponder a um Fechamento Contábil. '+#13+#10+
                'Para a Exclusão desse Fechamento, deverá ser realizada a Exclusão do Fechamento Contábil do período.'+#13+#10+
                'Empresa: '+ AstrCodEmp + #13+#10+
                'Fechamento: '+ DateToStr(AdtaFechamento) );

end;

class function TOutrosFechamentos.fContabilidadeLigada: Boolean;
begin
  if not fTabelaExiste('FECMES') then
    Exit(False) ;

  Result := (fCfgSis('UTICON', varString) = 'S') and Self.fFecCnt ;
end;

class function TOutrosFechamentos.fDeletaFechamento(const AstrCodEmp: String;
  const AdtaFechamento: TDateTime; var AstrMsgErro: String): Boolean;
begin
  Result := False ;

  if not fDeletaFechamentoFinanceiro(AstrCodEmp, AdtaFechamento) then
  begin
    AstrMsgErro := ERRO_FINANCEIRO ;
    Exit ;
  end ;

  if not fDeletaFechamentoFiscal(AstrCodEmp, AdtaFechamento) then
  begin
    AstrMsgErro := ERRO_FISCAL ;
    Exit ;
  end ;

  if not fDeletaFechamentoEstoque(AstrCodEmp, AdtaFechamento) then
  begin
    AstrMsgErro := ERRO_ESTOQUE ;
    Exit ;
  end ;

  Result := True ;
end;

class function TOutrosFechamentos.fDeletaFechamentoEstoque(
  const AstrCodEmp: String; AdtaFechamento: TDateTime): Boolean;
var
  LobjFechamento: TFechamentoEstoque;
  LintMes, LintAno: Integer ;
begin
  if not fPodeVincularFechamento(tfEstoque) then
    Exit(True) ;

  LobjFechamento := TFechamentoEstoque.Create(Nil);
  try
    LobjFechamento.Contabilidade := True ;
    LintMes := MonthOf(AdtaFechamento) ;
    LintAno := YearOf(AdtaFechamento) ;
    Result := LobjFechamento.fExcluiFechamento(AstrCodEmp, LintAno, LintMes) ;
  finally
    FreeAndNil(LobjFechamento) ;
  end ;
end;

class function TOutrosFechamentos.fDeletaFechamentoFinanceiro(
  const AstrCodEmp: String; AdtaFechamento: TDateTime): Boolean;
var
  LobjFechamento: TFechamentoFinanceiro;
begin
  if not fPodeVincularFechamento(tfFinanceiro) then
    Exit(True) ;

  LobjFechamento := TFechamentoFinanceiro.Create(Nil,'Contabilidade.OutrosFechamentos.Funcoes') ;
  try
    LobjFechamento.Contabilidade := True ;
    Result := LobjFechamento.ExcluiFechamento(AstrCodEmp, AdtaFechamento) ;
  finally
    FreeAndNil(LobjFechamento) ;
  end ;
end;

class function TOutrosFechamentos.fDeletaFechamentoFiscal(
  const AstrCodEmp: String; AdtaFechamento: TDateTime): Boolean;
var
  LobjFechamento: TFechamentoFiscal;
begin
  if not fPodeVincularFechamento(tfFiscal) then
    Exit(True) ;

  LobjFechamento := TFechamentoFiscal.Create(Nil) ;
  try
    LobjFechamento.Contabilidade := True ;
    Result := LobjFechamento.fExcluiFechamento(AstrCodEmp, AdtaFechamento) ;
  finally
    FreeAndNil(LobjFechamento) ;
  end ;
end;

class function TOutrosFechamentos.fFecCnt: Boolean;
begin
  Result := fCfgSis('FECCNT', varString) = 'S' ;
end;

class function TOutrosFechamentos.fGravaFechamento(
  const AarrEmpSel: TConsultasArray; const AdtaFechamento: TDateTime; var AstrMsgErro: String): Boolean;
begin
  Result := False ;

  if not fGravaFechamentoFinanceiro(AarrEmpSel, AdtaFechamento) then
  begin
    AstrMsgErro := ERRO_FINANCEIRO ;
    Exit ;
  end ;

  if not fGravaFechamentoFiscal(AarrEmpSel, AdtaFechamento) then
  begin
    AstrMsgErro := ERRO_FISCAL ;
    Exit ;
  end ;

  if not fGravaFechamentoEstoque(AarrEmpSel, AdtaFechamento) then
  begin
    AstrMsgErro := ERRO_ESTOQUE ;
    Exit ;
  end ;

  Result := True ;
end;

class function TOutrosFechamentos.fGravaFechamentoEstoque(const AarrEmpSel: TConsultasArray; const AdtaFechamento: TDateTime): Boolean ;
  var
    LobjFechamento: TFechamentoEstoque;
    LcdsUltimos24: TZClient;
    LintCnt: Integer ;
    LintMes, LintAno: Integer ;
  begin
    if not fPodeVincularFechamento(tfEstoque) then
      Exit(True) ;

    LcdsUltimos24 := Nil ;
    LobjFechamento := TFechamentoEstoque.Create(Nil);
    try
      LobjFechamento.Contabilidade := True ;

      if not LobjFechamento.fCarregaUltimos24 then
        Exit(False);

      LintMes := MonthOf(AdtaFechamento) ;
      LintAno := YearOf(AdtaFechamento) ;

      LcdsUltimos24 := LobjFechamento.cdsUltimos24 ;
      LcdsUltimos24.IndexFieldNames := 'FEC_CODEMP;FEC_ANOREF;FEC_MESREF' ;

      for LintCnt := Low(AarrEmpSel) to High(AarrEmpSel) do
      begin
        if LcdsUltimos24.FindKey([AarrEmpSel[LintCnt].strCodigo, LintAno, LintMes]) then
          Continue ;

        LobjFechamento.fIncluiFechamento(AarrEmpSel[LintCnt].strCodigo, LintAno, LintMes) ;
      end ;

      Result := True ;

    finally
      if Assigned(LcdsUltimos24) then
        FreeAndNil(LcdsUltimos24) ;

      LobjFechamento.cdsUltimos24 := nil;

      FreeAndNil(LobjFechamento) ;
    end ;
  end ;

end.
