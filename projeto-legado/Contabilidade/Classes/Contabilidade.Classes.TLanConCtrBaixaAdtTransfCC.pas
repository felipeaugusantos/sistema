unit Contabilidade.Classes.TLanConCtrBaixaAdtTransfCC;

interface

uses Contabilidade.Classes.TGerLanCon, Uni, cxProgressBar, Classes, Data.DB,
  UniClientDataSet, Contabilidade.Interfaces, Vcl.StdCtrls, Contabilidade.SQL;

type
  TLanConCtrBaixaAdtTransfCC = Class(TInterfacedObject, ITipLanCon)
  private
    qryDados : TUniQuery;
    Generico : TLanConGenerico;
    pgbProgresso : TcxProgressBar;
    recParCon: TParametrosConsulta;
    lblGravando : TLabel;
    procedure pSetaTextoProgresso(pgbProgresso: TcxProgressBar; strTexto: String);
    function fGetSQLMovimentoAdtTransfCreditoCliente(
      recParams: TParamsContasReceber): string;
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

{ TLanConCtrBaixaAdtTransfCC }

constructor TLanConCtrBaixaAdtTransfCC.Create(strTipLan: String; pgbProgresso: TcxProgressBar;
  recParCon: TParametrosConsulta);
begin
  lblGravando := Nil;
  qryDados := fCriaQuery(Nil);
  qryDados.CachedUpdates := True;
  qryDados.Options.SetFieldsReadOnly := False;
  Generico := TLanConGenerico.Create(qryDados, strTipLan, recParCon);
  Self.pgbProgresso := pgbProgresso;
  Self.recParCon := recParCon;
end;

destructor TLanConCtrBaixaAdtTransfCC.Destroy;
begin
  lblGravando := Nil;
  FreeAndNil(Generico);
  FreeAndNil(qryDados);
  inherited;
end;

function TLanConCtrBaixaAdtTransfCC.fCarregaDados: Boolean;
Var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.strCodEmp := recParCon.strCodEmp;
  recParams.dtaDtaIni := recParCon.dtaDtaIni;
  recParams.dtaDtaFin := recParCon.dtaDtaFin;
  recParams.strIncDoc := recParCon.strIncDoc;
  recParams.arrIncDoc := recParCon.arrIncDoc;
  qryDados.Close;
  qryDados.SQL.Clear;
  qryDados.SQL.Add( fGetSQLMovimentoAdtTransfCreditoCliente(recParams) );
  pSetaParametrosGerLanCon(recParCon, qryDados);
  qryDados.Open;

  Result := (Not qryDados.IsEmpty);
end;

function TLanConCtrBaixaAdtTransfCC.fGetSQLMovimentoAdtTransfCreditoCliente(recParams: TParamsContasReceber): string;
  Var
    strSQL : String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT (IFNULL(CTR.CTR_GRVORI, 0))*-1 AS CTR_VALDUP, ';

  strSQL := strSQL + '        CTR.CTR_CODEMP AS CODEMP, ';
  strSQL := strSQL + '        CTR.CTR_DTACAD AS DTAENT, CTR.CTR_DTACAD AS DTACAD, ';
  strSQL := strSQL + '        CTR.CTR_NUMDUP AS NUMDOC, ';
  strSQL := strSQL + '        CTR.CTR_CODEMP, ';
  strSQL := strSQL + '        CTR.CTR_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '        CLI_NOMCLI AS NOME, ';
  strSQL := strSQL + '        CLI_C_G_C_ AS CNPJ, ';
  strSQL := strSQL + '        "C" AS TIPO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + '        IFNULL(NCO_CODCLI, CLI_CODCLI) AS CODIGO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + '        IFNULL(CLINCO.NCO_CODCON, CLI_PLANCO) AS PLANCO, ';
  strSQL := strSQL + '        IFNULL(PORNCO.NCO_CODCON, PORTIT.POR_PLANCO) AS PLAPOR, ';
  strSQL := strSQL + '        IFNULL(PORNCO.NCO_CODPOR, PORTIT.POR_CODPOR) AS CODIGO_PORTADOR, ';
  strSQL := strSQL + '        "" AS CLAFIS, ';

  strSQL := strSQL + ' IFNULL(PORTIT.POR_EXPAUT, "S") AS POR_EXPAUT, ';
  strSQL := strSQL + ' IFNULL(CTANCO.NCO_CODCON, CTABAI.CTA_PLANCO) AS CTA_PLANCO, ';
  strSQL := strSQL + ' IFNULL(CTANCO.NCO_CODCTA, CTABAI.CTA_CODCTA) AS CODIGO_PLANO_CONTA_BAIXA, ';
  strSQL := strSQL + ' "Pagamentos Avulsos" AS TIPO_PAGAMENTO, ';
  strSQL := strSQL + ' CTR.CTR_PARCEL AS PARCEL, ';
  strSQL := strSQL + ' IFNULL(CTANCO2.NCO_CODCON, CADCTA2.CTA_PLANCO) AS CODCTA, ';
  strSQL := strSQL + ' IFNULL(CTANCO2.NCO_CODCTA, CADCTA2.CTA_CODCTA) AS CODIGO_PLANO_CONTA, ';
  strSQL := strSQL + ' "" AS CHQ_NUMCHQ, ';
  strSQL := strSQL + '    CTR.AUTOINCREM AS CTRINC, ';
  strSQL := strSQL + ' IFNULL(CTR.CTR_NUMDUP,"") AS DOCORI, ';
  strSQL := strSQL + ' IFNULL(CTR.CTR_ESPDOC,"") AS ESPORI,  ';
  strSQL := strSQL + ' CTR.CTR_CODEVE AS CODEVE, ';
  strSQL := strSQL + '    EMP_NOMEMP AS NOMEMP, CTR.CTR_HIST01 AS HIST01, "CADREC" AS TABELA, ';
  strSQL := strSQL + '   PORTIT.POR_CODPOR AS CODIGO_PORTADOR_TIT, ';
  strSQL := strSQL + ' CAST(0.00 AS DECIMAL(14,2)) AS CTR_DINHEI, ';
  strSQL := strSQL + ' CAST(0.00 AS DECIMAL(14,2)) AS CTR_CHQPRE, ';
  strSQL := strSQL + ' CAST(0.00 AS DECIMAL(14,2)) AS CTR_CHQAVI, ';
  strSQL := strSQL + ' CAST(0.00 AS DECIMAL(14,2)) AS CTR_CARTAO, ';
  strSQL := strSQL + ' CAST(0.00 AS DECIMAL(14,2)) AS CTR_ORDPAG, ';
  strSQL := strSQL + ' CAST("" AS CHAR(20)) AS CONTA_BANDEIRA, ' ;
  strSQL := strSQL + ' CAST("" AS CHAR(20)) AS CODIGO_BANDEIRA, ' ;
  strSQL := strSQL + ' CTR.CTR_ADTCLI, ' ;
  strSQL := strSQL + ' ABS(CTR.CTR_GRVORI) AS CTR_CREDIT, ' ;
  strSQL := strSQL + ' CTR.CTR_SEQBAI AS SEQBAI ' ;
  strSQL := strSQL + '   FROM CADREC CTR ';
  strSQL := strSQL + '   JOIN CADEMP ON CTR.CTR_CODEMP = EMP_CODEMP ';
  strSQL := strSQL + '   LEFT JOIN CADCLI ON CLI_CODCLI = CTR.CTR_CODCLI ';
  strSQL := strSQL + '   LEFT JOIN CADCID ON CID_CODCID = CLI_CODCID ';
  strSQL := strSQL + '   LEFT JOIN CADCTA CTABAI ON CTABAI.CTA_CODCTA = CTR.CTR_CTABAI ';

  strSQL := strSQL + '  LEFT JOIN CADPOR PORTIT ON CTR.CTR_CODPOR = PORTIT.POR_CODPOR ';

  strSQL := strSQL + '  LEFT JOIN CLINCO ON CLINCO.NCO_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + '                  AND CLINCO.NCO_CODEMP = CTR.CTR_CODEMP ';

  strSQL := strSQL + '   LEFT JOIN PORNCO ON PORNCO.NCO_CODPOR = PORTIT.POR_CODPOR ';
  strSQL := strSQL + '                   AND PORNCO.NCO_CODEMP = CTR.CTR_CODEMP ';

  strSQL := strSQL + '   LEFT JOIN CTANCO ON CTANCO.NCO_CODCTA = CTABAI.CTA_CODCTA ';
  strSQL := strSQL + '                   AND CTANCO.NCO_CODEMP = CTR.CTR_CODEMP ';

  //Buscar Contas Contábeis do Título
  strSQL := strSQL + '   LEFT JOIN CTANCO CTANCO2 ON CTANCO2.NCO_CODCTA = CTR.CTR_CODCTA ';
  strSQL := strSQL + '                           AND CTANCO2.NCO_CODEMP = CTR.CTR_CODEMP ';
  strSQL := strSQL + '   LEFT JOIN CADCTA CADCTA2 ON CADCTA2.CTA_CODCTA = CTR.CTR_CODCTA ';

  strSQL := strSQL + '  WHERE TRUE ';

  strSQL := strSQL + TTrataIncDocContabil
                        .New
                        .fColunaIncDoc('CTR.AUTOINCREM')
                        .fIncDoc(recParams.strIncDoc)
                        .fArrIncDoc(recParams.arrIncDoc)
                        .fQuerySql(Nil)
                        .fExecute ;

  If (Not recParams.strCodEmp.IsEmpty) Then
    strSQL := strSQL + '  AND CTR.CTR_CODEMP = :CODEMP ';

  strSQL := strSQL + '  AND CTR.CTR_ESPDOC = "CC" ';
  strSQL := strSQL + '  AND CTR.CTR_GRVORI < 0.0 ';
  strSQL := strSQL + '  AND CTR.CTR_SEQBAI = 0 ';
  strSQL := strSQL + '  AND CTR.CTR_ADTCLI = "S" ';

  If (recParams.dtaDtaIni > 0) then
    strSQL := strSQL + '  AND CTR.CTR_DTACAD BETWEEN :DTAINI AND :DTAFIN ';

  Result := strSQL;
end;

function TLanConCtrBaixaAdtTransfCC.fDeletaLanCon: Boolean;
begin
  Result := True ;
end;

function TLanConCtrBaixaAdtTransfCC.fEfetuaLancamentos: Boolean;
Var
  intRecCount : Integer;
  strPagame : String;
  strPlaCta : String;
  strEveNec: string;
begin
  intRecCount := qryDados.RecordCount;
  pgbProgresso.Properties.Max := intRecCount;
  strEveNec := fRetornaEventosNaoExportar;

  qryDados.First;
  While Not qryDados.Eof Do
  Begin
    pgbProgresso.Position := qryDados.RecNo;
    pSetaTextoProgresso(pgbProgresso, IIF(Generico.blnPreValidar, 'Pré-Validando', 'Gerando') + ' Lançamentos: "CTR": ' + IntToStr(qryDados.RecNo) + ' / ' + IntToStr(intRecCount));

    strPagame := qryDados.FieldByName('TIPO_PAGAMENTO').AsString;

    if (strPagame = 'Pagamentos Avulsos') and (qryDados.FieldByName('POR_EXPAUT').AsString = 'N') then
    begin
      Generico.pAdicionarWarning(fNormalizaWarningGenerico(Generico.strTipoLancamento, 'Portador do título com o código '+qryDados.FieldByName('CODIGO_PORTADOR_TIT').AsString+', configurado para não exportar [Exportar pelo Autsi]!'), qryDados);
      qryDados.Next;
      Continue;
    end;

    if (not fEmptyStr(strEveNec)) and (not qryDados.FieldByName('CODEVE').IsNull)
       and (Pos(qryDados.FieldByName('CODEVE').AsString, strEveNec) > 0) then
    begin
      Generico.pAdicionarWarning(fNormalizaWarningGenerico(Generico.strTipoLancamento, 'Evento com o código '+qryDados.FieldByName('CODEVE').AsString+' configurado para não ser exportado na CFG_EVENEC!'), qryDados);
      qryDados.Next;
      Continue;
    end;

    strPlaCta := qryDados.FieldByName('CTA_PLANCO').AsString;

    Generico.pGravaLancto('CTR_CREDIT', DES_VALOR_RECEBIDO, strPlaCta, FPG_ADIANTAMENTO, qryDados.FieldByName('CODEVE').AsString, strPagame);
    Generico.pGravaLancto('CTR_CREDIT', DES_VALOR_ORIGINAL, strPlaCta, FPG_ADIANTAMENTO, qryDados.FieldByName('CODEVE').AsString, strPagame);

    qryDados.Next;
  End;

  Result := True;
end;

function TLanConCtrBaixaAdtTransfCC.fEfetuaLancamentosPreValidacao: Boolean;
begin
  result := Generico.fEfetuaLancamentosPreValidacao(Self) ;
end;

function TLanConCtrBaixaAdtTransfCC.fTemParametrosConfigurados: Boolean;
begin
  Result := Generico.fTemParametrosConfigurados;
end;

function TLanConCtrBaixaAdtTransfCC.GetListaErros: TUniClientDataSet;
begin
  Result := Generico.listaErros;
end;

procedure TLanConCtrBaixaAdtTransfCC.pMensagemConclusao;
begin
  fMensagem('ATENÇÃO!', 'Contas a Receber Concluído!', ['&OK']);
end;

procedure TLanConCtrBaixaAdtTransfCC.pSetaPreValidacao(const Value: Boolean);
begin
  Generico.blnPreValidar := Value;
end;

procedure TLanConCtrBaixaAdtTransfCC.pSetaPreValidacao(Value: Boolean;
  objValida: IValidaContaContabil; const AblnLancarEmPreValidar: boolean);
begin
  Generico.blnPreValidar := Value;
  Generico.objValida := objValida;
  Generico.LancarEmPreValidar := AblnLancarEmPreValidar ;
end;

procedure TLanConCtrBaixaAdtTransfCC.pSetaTextoProgresso(pgbProgresso: TcxProgressBar;
  strTexto: String);
begin
  if assigned(lblGravando) then
    lblGravando.Caption := strTexto
  else if Assigned(pgbProgresso) And (Assigned(pgbProgresso.Parent)) and (GetParentForm(pgbProgresso).FindComponent('lblGravando') <> Nil) Then
  Begin
    lblGravando := TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando'));
    lblGravando.Caption := strTexto;
  End;
  Application.ProcessMessages;
end;

procedure TLanConCtrBaixaAdtTransfCC.pVerificaSeLancouLanCon;
begin
  Generico.pVerificaSeLancouLanCon ;
end;

end.
