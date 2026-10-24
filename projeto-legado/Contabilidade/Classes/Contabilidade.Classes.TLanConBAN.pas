unit Contabilidade.Classes.TLanConBAN;

interface

uses Contabilidade.Classes.TGerLanCon, Uni, cxProgressBar, Classes, Data.DB, UniClientDataSet,
     Contabilidade.Interfaces;

type
  TLanConBAN = Class(TInterfacedObject, ITipLanCon)
  private
    qryDados : TUniQuery;
    Generico : TLanConGenerico;
    pgbProgresso : TcxProgressBar;
    recParCon: TParametrosConsulta;
    blnAplicarFiltroContraPartida : boolean;
    cdsCtrAgg: TUniClientDataSet;
    cdsCtpAgg: TUniClientDataSet;
    fltValLan: Double;
    fltDifLan: Double;
    fltRatLan: Double;
    strBANInc: string;
    function fCarregaDadosCadRecValorAgrupado(
      recParams: TParametrosConsulta): boolean;
    function fCarregaDadosCadPagValorAgrupado(
      recParams: TParametrosConsulta): boolean;
    function fGetCadRecPagValorAgrupado(const strAutoInc, strTipo:string):double ;
    function fTrataValorProporcional(const fltValorProporcional:double):double ;
    procedure pSomarValores;
    procedure pZerarValores;
    procedure pAlterarValores;
    function fRetornaFormaPagtoPeloHistoricoTRF(const AHistorico, AOrigem: string):string ;
    function fEhOrdemPagamento(const AstrHistorico: String): Boolean ;
  public
    function fCarregaDados: Boolean;
    function fEfetuaLancamentos: Boolean;
    procedure pMensagemConclusao;
    function fTemParametrosConfigurados: Boolean;
    function fDeletaLanCon: Boolean;
    function GetListaErros: TUniClientDataSet;
    procedure pSetaPreValidacao(Value: Boolean; objValida: IValidaContaContabil; const AblnLancarEmPreValidar: boolean = False); overload ;
    procedure pSetaPreValidacao(const Value: Boolean); overload ;
    constructor Create(strTipLan: String; pgbProgresso: TcxProgressBar; recParCon: TParametrosConsulta);
    destructor Destroy; override;
    procedure pVerificaSeLancouLanCon;
    function fEfetuaLancamentosPreValidacao: Boolean;
  End;

implementation

uses Forms, SysUtils, StrUtils, untFuncoesSimples, Contabilidade.Funcoes, Contabilidade.SQL,
Contabilidade.Classes.TTrataIncDoc;

{ TLanConBAN }

constructor TLanConBAN.Create(strTipLan: String; pgbProgresso: TcxProgressBar; recParCon: TParametrosConsulta);
begin
  qryDados := fCriaQuery(Nil);
  qryDados.CachedUpdates := True;
  qryDados.Options.SetFieldsReadOnly := False;
  Generico := TLanConGenerico.Create(qryDados, strTipLan, recParCon);
  Self.pgbProgresso := pgbProgresso;
  Self.recParCon := recParCon;
  blnAplicarFiltroContraPartida := (fConfiguracaoExiste('MOVBAN'));
  if (blnAplicarFiltroContraPartida) then
    blnAplicarFiltroContraPartida := (fCfgSis('MOVBAN', varBoolean));
end;

destructor TLanConBAN.Destroy;
begin
  FreeAndNil(Generico);
  FreeAndNil(qryDados);
  inherited;
end;

function TLanConBAN.fCarregaDados: Boolean;
begin
  qryDados.Close;
  qryDados.SQL.Clear;
  qryDados.SQL.Add( fGetSQLMovimentoBancario(recParCon.strCodEmp, blnAplicarFiltroContraPartida, recParCon.strIncDoc, recParCon.arrIncDoc, recParCon.dtaDtaIni > 0) );

  pSetaParametrosGerLanCon(recParCon, qryDados);

  qryDados.Open;
  fCarregaDadosCadRecValorAgrupado(recParCon) ;
  fCarregaDadosCadPagValorAgrupado(recParCon) ;

  Result := (Not qryDados.IsEmpty);
end;

function TLanConBAN.fDeletaLanCon: Boolean;
begin
  Result := Generico.fDeletaLanCon;
end;

function TLanConBAN.fEfetuaLancamentos: Boolean;
var
  strEveNec: String;
  fltValorProporcionalAgrupado : double ;
  strFormaPagamento : string ;
begin
  pgbProgresso.Properties.Max := qryDados.RecordCount;
  strEveNec := fRetornaEventosNaoExportar;
  strBANInc := '';

  qryDados.BeforeScroll := nil ;
  try
    qryDados.First;
    While Not qryDados.Eof Do
    Begin
      if (qryDados.FieldByName('CTB_ORIGEM').AsString = 'CTP')
         or (qryDados.FieldByName('CTB_ORIGEM').AsString = 'CTR') then
      begin
        fltValorProporcionalAgrupado := fTrataValorProporcional(fGetCadRecPagValorAgrupado(qryDados.FieldByName('INCCTRCTP').AsString, qryDados.FieldByName('CTB_ORIGEM').AsString)) ;
        qryDados.Edit ;
        qryDados.FieldByName('VALLAN').AsFloat := qryDados.FieldByName('VALLAN').AsFloat * (fTrataValorProporcional(qryDados.FieldByName('VALOR_PROPORCIONAL').AsFloat)/fltValorProporcionalAgrupado) ;
        qryDados.post ;
      end;
      qryDados.Next;
    End;

    qryDados.First;
    While Not qryDados.Eof Do
    Begin
      pgbProgresso.Position := qryDados.RecNo;
      Application.ProcessMessages;

      if (not fEmptyStr(strEveNec)) and (not qryDados.FieldByName('CTB_CODEVE').IsNull)
         and (Pos(qryDados.FieldByName('CTB_CODEVE').AsString, strEveNec) > 0) then
      begin
        Generico.pAdicionarWarning(fNormalizaWarningGenerico(Generico.strTipoLancamento, 'Evento com o código '+qryDados.FieldByName('CTB_CODEVE').AsString+' configurado para não ser exportado na CFG_EVENEC!'), qryDados);
        qryDados.Next;
        Continue;
      end;

      fltValLan   := qryDados.FieldByName('VLLAN2').AsFloat;

      if qryDados.FieldByName('BANINC').AsString <> strBANInc then
      begin
        strBANInc := qryDados.FieldByName('BANINC').AsString;
        pZerarValores;
      end;
      pSomarValores;

      qryDados.Next;
      if (qryDados.FieldByName('BANINC').AsString <> strBANInc) or (qryDados.Eof) then
      begin
        if not qryDados.Eof then
          qryDados.Prior;

        fltDifLan := fltValLan - fltRatLan;

        if fltDifLan <> 0 then
        begin
          pAlterarValores;
        end;
      end
      else
      begin
        qryDados.Prior;
      end;

      strFormaPagamento := fRetornaFormaPagtoPeloHistoricoTRF(qryDados.FieldByName('CTB_HIST01').AsString, qryDados.FieldByName('CTB_ORIGEM').AsString) ;

      Generico.pGravaLancto('VALLAN', 'Vr.Lançamento', qryDados.FieldByName('CTA_PLANCO').AsString, strFormaPagamento, qryDados.FieldByName('CTB_CODEVE').AsString, qryDados.FieldByName('TIPO_PAGAMENTO').AsString, qryDados.FieldByName('CTB_ORIGEM').AsString);

      qryDados.Next;
    End;
  finally
    qryDados.BeforeScroll := Generico.pBeforeScroll ;
  end;

  //////valida o credito - debito = resultado zero pelo evento pBeforeScroll
  qryDados.First;
  while not qryDados.Eof do
  begin
    qryDados.Next;
  end;

  Result := True;
end;

function TLanConBAN.fEfetuaLancamentosPreValidacao: Boolean;
begin
  result := Generico.fEfetuaLancamentosPreValidacao(Self) ;
end;

function TLanConBAN.fEhOrdemPagamento(const AstrHistorico: String): Boolean;
begin
  Result := True ;

  if pos('(OP)',UpperCase(AstrHistorico)) > 0 then
    Exit ;

  if pos('(ORD)',UpperCase(AstrHistorico)) > 0 then
    Exit ;

  if pos('(OP-PIX)',UpperCase(AstrHistorico)) > 0 then
    Exit ;

  Result := False ;
end;

function TLanConBAN.fGetCadRecPagValorAgrupado(const strAutoInc,
  strTipo: string): double;
begin
  result := 1 ;
  if strTipo = 'CTR' then
  begin
    if cdsCtrAgg.FindKey([strAutoInc]) then
    begin
      result := cdsCtrAgg.FieldByName('VAL_PROPORCIONAL').AsFloat ;
    end;
  end
  else if strTipo = 'CTP' then
  begin
    if cdsCtpAgg.FindKey([strAutoInc]) then
    begin
      result := cdsCtpAgg.FieldByName('VAL_PROPORCIONAL').AsFloat ;
    end;
  end;
end;

function TLanConBAN.fRetornaFormaPagtoPeloHistoricoTRF(
  const AHistorico, AOrigem: string): string;
begin
  result := '' ;
  if AOrigem <> 'TRF' then
  begin
    exit ;
  end;

  if pos('TF CAIXA',UpperCase(AHistorico)) > 0  then
  begin
    if pos('(DIN)',UpperCase(AHistorico)) > 0 then
    begin
      result := FPG_DINHEIRO ;
    end
    else if pos('(CHV)',UpperCase(AHistorico)) > 0 then
    begin
      result := FPG_CHEQUE_VISTA ;
    end
    else if pos('(CHP)',UpperCase(AHistorico)) > 0 then
    begin
      result := FPG_CHEQUE_PRE ;
    end
    else if pos('(CAR)',UpperCase(AHistorico)) > 0 then
    begin
      result := FPG_CARTAO ;
    end
    else if fEhOrdemPagamento(AHistorico) then
    begin
      result := FPG_ORDPAG ;
    end
    else if pos('(FIN)',UpperCase(AHistorico)) > 0 then
    begin
      result := FPG_FINANCIAMENTO ;
    end;
  end;
end;

function TLanConBAN.fTemParametrosConfigurados: Boolean;
begin
  Result := Generico.fTemParametrosConfigurados;
end;

function TLanConBAN.fTrataValorProporcional(
  const fltValorProporcional: double): double;
begin
  result := 1 ;
  if fltValorProporcional <> 0.00 then
  begin
    result := fltValorProporcional ;
  end;
end;

function TLanConBAN.GetListaErros: TUniClientDataSet;
begin
  Result := Generico.listaErros;
end;

procedure TLanConBAN.pMensagemConclusao;
begin
  fMensagem('ATENÇÃO!', 'Movimentação Bancária Concluída!', ['&OK']);
end;

procedure TLanConBAN.pSetaPreValidacao(Value: Boolean; objValida: IValidaContaContabil; const AblnLancarEmPreValidar: boolean = False);
begin
  Generico.blnPreValidar := Value;
  Generico.objValida := objValida;
  Generico.LancarEmPreValidar := AblnLancarEmPreValidar ;
end;

procedure TLanConBAN.pVerificaSeLancouLanCon;
begin
  generico.pVerificaSeLancouLanCon;
end;

function TLanConBAN.fCarregaDadosCadPagValorAgrupado(
  recParams: TParametrosConsulta): boolean;
Var
  qryAgg : TUniQuery;
begin

  If Assigned(cdsCtpAgg) Then
    FreeAndNil(cdsCtpAgg);

  qryAgg := fCriaQuery(nil);
  Try
    qryAgg.Close;
    qryAgg.SQL.Clear;
    qryAgg.SQL.Add(' SELECT CTP.AUTOINCREM, ');
    qryAgg.SQL.Add('         COALESCE(SUM( ');
    qryAgg.SQL.Add('  	       ((COALESCE(AGR.CTP_VALDUP,0.00)*100/(COALESCE((SELECT SUM(COALESCE(CTP_VALDUP, 0.00)) FROM DUPAGP WHERE CTP_NUMAGR = AGR.CTP_NUMAGR'+' AND CTP_EMPAGR = AGR.CTP_EMPAGR AND CTP_CODFOR = AGR.CTP_CODFOR),1)))/100) ');
    qryAgg.SQL.Add('   	            ),1)    AS VAL_PROPORCIONAL ');
    qryAgg.SQL.Add('  FROM MOVBAN ');
    qryAgg.SQL.Add('       INNER JOIN CADPAG CTP ON CTP.CTP_CODFOR = MOVBAN.CTB_CODFOR ');
    qryAgg.SQL.Add('                   AND CTP.CTP_NUMDUP = MOVBAN.CTB_NUMDUP ');
    qryAgg.SQL.Add('                   AND CTP.CTP_PARCEL = MOVBAN.CTB_PARCEL ');
    qryAgg.SQL.Add('                   AND CTP.CTP_CODEMP = MOVBAN.CTB_EMPDUP ');
    qryAgg.SQL.Add('                   AND COALESCE(CTP.CTP_SERIE_,"") = COALESCE(MOVBAN.CTB_SERIE_, "") ');
    qryAgg.SQL.Add('                   AND CTP.CTP_SEQBAI = "0" ');
    qryAgg.SQL.Add('                   AND MOVBAN.CTB_ORIGEM = "CTP" ');
    qryAgg.SQL.Add('       LEFT JOIN DUPAGP AGR ON AGR.CTP_NUMAGR = CTP.CTP_NUMDUP ');
    qryAgg.SQL.Add('                   AND AGR.CTP_EMPAGR = CTP.CTP_CODEMP ');
    qryAgg.SQL.Add('                   AND AGR.CTP_CODFOR = CTP.CTP_CODFOR ');
    qryAgg.SQL.Add('                   AND AGR.CTP_PARCEL = CTP.CTP_PARCEL ');
    qryAgg.SQL.Add(' WHERE TRUE ');

    TTrataIncDocContabil
      .New
      .fColunaIncDoc('MOVBAN.AUTOINCREM')
      .fIncDoc(recParCon.strIncDoc)
      .fArrIncDoc(recParCon.arrIncDoc)
      .fQuerySql(qryAgg)
      .fExecute ;

    if (blnAplicarFiltroContraPartida) then
      qryAgg.SQL.Add('  AND CTB_GERCON = 1 ');

    If (Not recParams.strCodEmp.IsEmpty) Then
      qryAgg.SQL.Add('  AND CTB_CODEMP = :CODEMP ');

    if (recParams.dtaDtaIni > 0) then
      qryAgg.SQL.Add('  AND CTB_DTALAN BETWEEN :DTAINI AND :DTAFIN ');

    pSetaParametrosGerLanCon(recParams, qryAgg);

    qryAgg.SQL.Add(' GROUP BY CTP.AUTOINCREM');
    qryAgg.Open ;

    cdsCtpAgg := fCriaClientDatset(qryAgg, false);
    cdsCtpAgg.IndexFieldNames := 'AUTOINCREM' ;
    cdsCtpAgg.Open;

    Result := True;
  Finally
    FreeAndNil(qryAgg);
  End;
end;

function TLanConBAN.fCarregaDadosCadRecValorAgrupado(recParams: TParametrosConsulta): boolean;
Var
  qryAgg : TUniQuery;
begin

  If Assigned(cdsCtrAgg) Then
    FreeAndNil(cdsCtrAgg);

  qryAgg := fCriaQuery(nil);
  Try
    qryAgg.Close;
    qryAgg.SQL.Clear;
    qryAgg.SQL.Add(' SELECT CTR.AUTOINCREM, ');
    qryAgg.SQL.Add('         COALESCE(SUM(IF(AGR2.CTR_NUMDUP IS NOT NULL, ');
    qryAgg.SQL.Add('  	       ((COALESCE(AGR2.CTR_VALDUP,0.00)*100/(COALESCE((SELECT SUM(IF(AGR2.CTR_NUMDUP IS NOT NULL, COALESCE(CTR_VALDUP, 0.00), NULL))'+' FROM DUPAGR WHERE CTR_NUMAGR = AGR.CTR_NUMDUP AND CTR_EMPAGR = AGR.CTR_EMPAGR AND CTR_CODCLI = AGR.CTR_CODCLI),1)))/100)'
                                 +'*((COALESCE(AGR.CTR_VALDUP,0.00)*100/(COALESCE((SELECT SUM(COALESCE(CTR_VALDUP, 0.00)) FROM DUPAGR WHERE CTR_NUMAGR = AGR.CTR_NUMAGR AND CTR_EMPAGR = AGR.CTR_EMPAGR AND CTR_CODCLI = AGR.CTR_CODCLI),1)))/100), ');
    qryAgg.SQL.Add('  	       ((COALESCE(AGR.CTR_VALDUP,0.00)*100/(COALESCE((SELECT SUM(COALESCE(CTR_VALDUP, 0.00)) FROM DUPAGR WHERE CTR_NUMAGR = AGR.CTR_NUMAGR AND CTR_EMPAGR = AGR.CTR_EMPAGR AND CTR_CODCLI = AGR.CTR_CODCLI),1)))/100) ');
    qryAgg.SQL.Add('   	      )),1)    AS VAL_PROPORCIONAL ');
    qryAgg.SQL.Add('  FROM MOVBAN ');
    qryAgg.SQL.Add('       INNER JOIN CADREC AS CTR ON CTR.CTR_CODCLI = MOVBAN.CTB_CODCLI ');
    qryAgg.SQL.Add('                    AND CTR.CTR_NUMDUP = MOVBAN.CTB_NUMDUP ');
    qryAgg.SQL.Add('                    AND CTR.CTR_PARCEL = MOVBAN.CTB_PARCEL ');
    qryAgg.SQL.Add('                    AND CTR.CTR_CODEMP = MOVBAN.CTB_EMPDUP ');
    qryAgg.SQL.Add('                    AND CTR.CTR_SEQBAI = "0" ');
    qryAgg.SQL.Add('                    AND MOVBAN.CTB_ORIGEM = "CTR" ');
    qryAgg.SQL.Add('       INNER JOIN DUPAGR AGR ON AGR.CTR_NUMAGR = CTR.CTR_NUMDUP ');
    qryAgg.SQL.Add('  		   AND AGR.CTR_EMPAGR = CTR.CTR_CODEMP ');
    qryAgg.SQL.Add('  		   AND AGR.CTR_CODCLI = CTR.CTR_CODCLI AND CTR.CTR_ESPDOC = "AG" ');
    qryAgg.SQL.Add('       LEFT JOIN DUPAGR AGR2 ON AGR2.CTR_NUMAGR = AGR.CTR_NUMDUP ');
    qryAgg.SQL.Add('  		   AND AGR2.CTR_EMPAGR = AGR.CTR_CODEMP ');
    qryAgg.SQL.Add('  		   AND AGR2.CTR_CODCLI = AGR.CTR_CODCLI ');
    qryAgg.SQL.Add(' WHERE TRUE ');

    TTrataIncDocContabil
      .New
      .fColunaIncDoc('MOVBAN.AUTOINCREM')
      .fIncDoc(recParCon.strIncDoc)
      .fArrIncDoc(recParCon.arrIncDoc)
      .fQuerySql(qryAgg)
      .fExecute ;

    if (blnAplicarFiltroContraPartida) then
      qryAgg.SQL.Add('  AND CTB_GERCON = 1 ');

    If (Not recParams.strCodEmp.IsEmpty) Then
      qryAgg.SQL.Add('  AND CTB_CODEMP = :CODEMP ');

    if (recParams.dtaDtaIni > 0) then
      qryAgg.SQL.Add('  AND CTB_DTALAN BETWEEN :DTAINI AND :DTAFIN ');

    pSetaParametrosGerLanCon(recParams, qryAgg);

    qryAgg.SQL.Add(' GROUP BY CTR.AUTOINCREM');
    qryAgg.Open ;

    cdsCtrAgg := fCriaClientDatset(qryAgg, false);
    cdsCtrAgg.IndexFieldNames := 'AUTOINCREM' ;
    cdsCtrAgg.Open;

    Result := True;
  Finally
    FreeAndNil(qryAgg);
  End;
end;

procedure TLanConBAN.pZerarValores;
begin
  fltRatLan := 0;
  fltDifLan := 0;
end;

procedure TLanConBAN.pSetaPreValidacao(const Value: Boolean);
begin
  Generico.blnPreValidar := Value;
end;

procedure TLanConBAN.pSomarValores;
begin
  fltRatLan := fltRatLan + qryDados.FieldByName('VALLAN').AsFloat;
end;

procedure TLanConBAN.pAlterarValores;
begin
  qryDados.Edit;
  if (fltDifLan <> 0) then
    qryDados.FieldByName('VALLAN').AsFloat := qryDados.FieldByName('VALLAN').AsFloat + fltDifLan;
  qryDados.Post;
end;



end.
