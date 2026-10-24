unit Contabilidade.Classes.TLanConCOS;

interface

uses Contabilidade.Classes.TGerLanCon, Uni, cxProgressBar, Classes, Data.DB, UniClientDataSet,
     Contabilidade.Interfaces;

type
  TLanConCOS = Class(TInterfacedObject, ITipLanCon)
  private
    qryDados : TUniQuery;
    Generico : TLanConGenerico;
    pgbProgresso : TcxProgressBar;
    recParCon: TParametrosConsulta;
    FUsaCampoVenCom : boolean;
    recValBan : TValidacoesDeBanco;
    FblnAtivaPlanoContasCoeCos : Boolean ;
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

uses Forms, SysUtils, StrUtils, untFuncoesSimples, Contabilidade.Funcoes,
Contabilidade.Classes.TTrataIncDoc;

{ TLanConCOS }

constructor TLanConCOS.Create(strTipLan: String; pgbProgresso: TcxProgressBar;
  recParCon: TParametrosConsulta);
begin
  qryDados := fCriaQuery(Nil);
  Generico := TLanConGenerico.Create(qryDados, strTipLan, recParCon);
  Generico.FblnMostraWarningGeracaoMovimento := False;
  Self.pgbProgresso := pgbProgresso;
  Self.recParCon := recParCon;
  FUsaCampoVenCom := fCampoExiste('CADFIS', 'FIS_VENCOM');
  FillChar(recValBan, SizeOf(recValBan), #0);
  recValBan.FUsaCampoAbfCon := fCampoExiste('CADITE', 'ITE_ABFCON');
  recValBan.FUsaCampoNatCfo := fCampoExiste('AUXMOV', 'AUX_NATCFO');
  recValBan.FUsaCampoCalMed := fCampoExiste('CADFIS', 'FIS_CALMED');
  FblnAtivaPlanoContasCoeCos := fAtivaPlanoContasCoeCos = 'S' ;
end;

destructor TLanConCOS.Destroy;
begin
  FreeAndNil(Generico);
  FreeAndNil(qryDados);
  inherited;
end;

function TLanConCOS.fCarregaDados: Boolean;
  Var
    strSQL : String;
begin
  if (not FUsaCampoVenCom) then
  begin
    strSQL := '';
    strSQL := strSQL + ' SELECT DISTINCT FIS_CLFSC1 AS CLAFIS, FIS_DTAENT AS DTAENT, FIS_NUMDOC AS NUMDOC, ';
    strSQL := strSQL + '        FIS_ESPDOC AS ESPDOC, FIS_CODEMP AS CODEMP, ';
    strSQL := strSQL + '        IFNULL(FIS_VLCON1, 0) + IFNULL(FIS_VLCON2, 0) + IFNULL(FIS_VLCON3, 0) + IFNULL(FIS_VLCON4, 0) + IFNULL(FIS_VLCON5, 0) AS VLRCON, ';
    strSQL := strSQL + '        FIS_VLRIC1 AS VALICM, FIS_TOTPIS AS VALPIS, FIS_TOTCOF AS VALCOF, ';
    strSQL := strSQL + '        IF(FIS_TIP_FC = "C", CLI_NOMCLI, FOR_NOMFOR) AS NOME, ';
    strSQL := strSQL + '        IF(FIS_TIP_FC = "C", CLI_C_G_C_, FOR_C_G_C_) AS CNPJ, ';

    if (recValBan.FUsaCampoNatCfo) then
      strSQL := strSQL + '      A1.AUX_NATCFO AS NATCFO, ';

    strSQL := strSQL + '        FIS_TIP_FC AS TIPO_CLIENTE_FORNECEDOR, ';
    strSQL := strSQL + '        IF(FIS_TIP_FC = "C", IFNULL(NCO_CODCLI, CLI_CODCLI), IFNULL(NCO_CODFOR, FOR_CODFOR)) AS CODIGO_CLIENTE_FORNECEDOR, ';
    strSQL := strSQL + '        IF(FIS_TIP_FC = "C", IFNULL(CLINCO.NCO_CODCON, CLI_PLANCO), IFNULL(FORNCO.NCO_CODCON, FOR_PLANCO)) AS PLANCO, ';
    strSQL := strSQL + '        ' + fValorLiquidoEntradaLivro(1) + ' + ' + fValorLiquidoEntradaLivro(2, False, False, False) + ' + ' + fValorLiquidoEntradaLivro(3, False, False, False) + ' + ' + fValorLiquidoEntradaLivro(4, False, False, False) + ' + ' + fValorLiquidoEntradaLivro(5, False, False, False) + ' AS LIQENT, ';
    strSQL := strSQL + '        CADFIS.AUTOINCREM AS FISINC ';
    strSQL := strSQL + '   FROM CADFIS ';
    strSQL := strSQL + '   LEFT JOIN RECTNF    ON CADFIS.AUTOINCREM = RECTNF.REC_CTESEQ ';
    strSQL := strSQL + '   LEFT JOIN MOVGER G1 ON RECTNF.REC_MOVSEQ = G1.AUTOINCREM ';

    if (recValBan.FUsaCampoNatCfo) then
      strSQL := strSQL + ' LEFT JOIN AUXMOV A1 ON A1.AUX_SEQGER = G1.AUTOINCREM ';

    strSQL := strSQL + '   LEFT JOIN CONFRE    ON CADFIS.AUTOINCREM = CONFRE.CON_SEQFIS ';
    strSQL := strSQL + '   LEFT JOIN MOVGER G2 ON CONFRE.CON_SEQGER = G2.AUTOINCREM ';
    strSQL := strSQL + '   LEFT JOIN CADCLI ON CLI_CODCLI = FIS_FORCLI ';
    strSQL := strSQL + '   LEFT JOIN CADFOR ON FOR_CODFOR = FIS_FORCLI ';
    strSQL := strSQL + '   LEFT JOIN CLINCO ON CLINCO.NCO_CODCLI = CLI_CODCLI ';
    strSQL := strSQL + '                   AND CLINCO.NCO_CODEMP = FIS_CODEMP ';
    strSQL := strSQL + '   LEFT JOIN FORNCO ON FORNCO.NCO_CODFOR = FOR_CODFOR ';
    strSQL := strSQL + '                   AND FORNCO.NCO_CODEMP = FIS_CODEMP ';
    strSQL := strSQL + '  WHERE FIS_ESPDOC = "CT" ';
    strSQL := strSQL + '    AND G2.GER_CLAFIS IS NULL '; // ** ATENÇÃO, OS SELECT DE COE E COS SÃO IDÊNTICOS, COM EXCEÇÃO DESSA LINHA

    If Not fEmptyStr(recParCon.strCodEmp) Then
      strSQL := strSQL + '  AND FIS_CODEMP = :CODEMP ';

    if (recParCon.dtaDtaIni > 0) then
      strSQL := strSQL + '    AND FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

    strSql := strSql + TTrataIncDocContabil
                        .New
                        .fColunaIncDoc('CADFIS.AUTOINCREM')
                        .fIncDoc(recParCon.strIncDoc)
                        .fArrIncDoc(recParCon.arrIncDoc)
                        .fQuerySql(Nil)
                        .fExecute ;

  end
  else
    strSQL := fgetSQLConhecimentoFrete(CONHECIMENTO_TIPO_VENDA, recParCon, recValBan);

  qryDados.Close;
  qryDados.SQL.Clear;
  qryDados.SQL.Add(strSQL);

  If Not fEmptyStr(recParCon.strCodEmp) Then
    qryDados.ParamByName('CODEMP').AsString := recParCon.strCodEmp;

  if (recParCon.dtaDtaIni > 0) then
  begin
    qryDados.ParamByName('DTAINI').AsDate := recParCon.dtaDtaIni;
    qryDados.ParamByName('DTAFIN').AsDate := recParCon.dtaDtaFin;
  end;

  if (not fEmptyStr(recParCon.strIncDoc)) and (Length(recParCon.arrIncDoc)=0) then
    qryDados.ParamByName('INCDOC').AsString := recParCon.strIncDoc;

  qryDados.Open;
  Result := (Not qryDados.IsEmpty);
end;

function TLanConCOS.fDeletaLanCon: Boolean;
begin
  Result := Generico.fDeletaLanCon;
end;

function TLanConCOS.fEfetuaLancamentos: Boolean;
  var
    strNatCfo : string;
    LcdsVerica: TUniClientDataSet ;
    LstrPlaCta: String ;
    LstrCodEve: String ;
    LCdsDados: TUniClientDataSet;
begin
  pgbProgresso.Properties.Max := qryDados.RecordCount;

  qryDados.First;
  While Not qryDados.Eof Do
  Begin
    pgbProgresso.Position := qryDados.RecNo;
    Application.ProcessMessages;

    strNatCfo := '';
    if Assigned(qryDados.FindField('NATCFO')) then
      strNatCfo := qryDados.FieldByName('NATCFO').AsString;

    LstrPlaCta := '' ;
    if (FblnAtivaPlanoContasCoeCos) and Assigned(qryDados.FindField('CTA_PLANCO')) then
      LstrPlaCta := qryDados.FieldByName('CTA_PLANCO').AsString ;

    LstrCodEve := '';
    if Assigned(qryDados.FindField('CODEVE')) then
      LstrCodEve := qryDados.FieldByName('CODEVE').AsString ;

    Generico.pGravaLancto('VLRCON', 'Vr.Contábil', LstrPlaCta, '', LstrCodEve, '', '', strNatCfo);
    Generico.pGravaLancto('VALICM', 'Vr.ICMS', LstrPlaCta, '', LstrCodEve, '', '', strNatCfo);
    Generico.pGravaLancto('VALPIS', 'Vr.PIS', LstrPlaCta, '', LstrCodEve, '', '', strNatCfo);
    Generico.pGravaLancto('VALCOF', 'Vr.COFINS', LstrPlaCta, '', LstrCodEve, '', '', strNatCfo);
    Generico.pGravaLancto('LIQENT', DES_VALOR_LIQUIDO_ENTRADA, LstrPlaCta, '', LstrCodEve, '', '', strNatCfo);

    qryDados.Next;
  End;

  if FUsaCampoVenCom then
  begin
    LcdsVerica := fCarregaCTCadFis(recParCon, recValBan, CONHECIMENTO_TIPO_VENDA) ;
    if Assigned(LcdsVerica) then
    begin
      try

        qryDados.BeforeScroll := nil ;
        qryDados.DisableControls ;
        try
          LCdsDados := fCriaClientDatset(qryDados);
          try
            LCdsDados.IndexFieldNames := 'FISINC';
            LcdsVerica.First ;
            while not LcdsVerica.Eof do
            begin
              if not LCdsDados.FindKey([LcdsVerica.FieldByName('FISINC').AsString]) then
              begin
                Generico.pAdicionarWarning('Conhecimento de transporte não importado por XML (COS)',
                                         LcdsVerica,
                                         '',
                                         '[Número Documento: ' + LcdsVerica.FieldByName('FIS_NUMDOC').AsString + '/Empresa: ' + LcdsVerica.FieldByName('FIS_CODEMP').AsString + ']',
                                         Generico.strTipoLancamento,
                                         '',
                                         '',
                                         '',
                                         False
                                         );
              end ;
              LcdsVerica.Next ;
            end ;

          finally
            FreeAndNil(LCdsDados);
          end;
        finally
          qryDados.EnableControls ;
          qryDados.BeforeScroll := Generico.pBeforeScroll ;
        end ;

      finally
        FreeAndNil(LcdsVerica) ;
      end ;
    end ;
  end ;

  Result := True;
end;

function TLanConCOS.fEfetuaLancamentosPreValidacao: Boolean;
begin
  result := Generico.fEfetuaLancamentosPreValidacao(Self) ;
end;

function TLanConCOS.fTemParametrosConfigurados: Boolean;
begin
  Result := Generico.fTemParametrosConfigurados;
end;

function TLanConCOS.GetListaErros: TUniClientDataSet;
begin
  Result := Generico.listaErros;
end;

procedure TLanConCOS.pMensagemConclusao;
begin
  fMensagem('ATENÇÃO!', 'Conhecimento de Saída Concluída!', ['&OK']);
end;

procedure TLanConCOS.pSetaPreValidacao(const Value: Boolean);
begin
  Generico.blnPreValidar := Value;
end;

procedure TLanConCOS.pSetaPreValidacao(Value: Boolean; objValida: IValidaContaContabil; const AblnLancarEmPreValidar: boolean = False);
begin
  Generico.blnPreValidar := Value;
  Generico.objValida := objValida;
  Generico.LancarEmPreValidar := AblnLancarEmPreValidar ;
end;

procedure TLanConCOS.pVerificaSeLancouLanCon;
begin
  generico.pVerificaSeLancouLanCon;
end;

end.
