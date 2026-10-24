unit Contabilidade.Classes.TLanConGNR;

interface

uses Contabilidade.Classes.TGerLanCon, Uni, cxProgressBar, Classes, Data.DB,
  UniClientDataSet, Contabilidade.Interfaces, Vcl.StdCtrls;

type
  TLanConGNR = Class(TInterfacedObject, ITipLanCon)
  private
    qryDados : TUniQuery;
    Generico : TLanConGenerico;
    pgbProgresso : TcxProgressBar;
    recParCon: TParametrosConsulta;
    lblGravando : TLabel;
    FstrCentroCustoDefault : String ;
    procedure pSetaTextoProgresso(pgbProgresso: TcxProgressBar; strTexto: String);
    function fgetSQLGNRE: string;
    function fProgressoAtivo: boolean;
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

uses
  untFuncoesSimples, SysUtils, Contabilidade.Funcoes, Forms,
  Contabilidade.Classes.TEventoContabil, Contabilidade.Classes.TTrataIncDoc;

{ TLanConGNR }

constructor TLanConGNR.Create(strTipLan: String; pgbProgresso: TcxProgressBar;
  recParCon: TParametrosConsulta);
begin
  lblGravando := Nil;
  qryDados := fCriaQuery(Nil);
  qryDados.CachedUpdates := True;
  qryDados.Options.SetFieldsReadOnly := False;
  Generico := TLanConGenerico.Create(qryDados, strTipLan, recParCon);
  Self.pgbProgresso := pgbProgresso;
  Self.recParCon := recParCon;
  FstrCentroCustoDefault := fCentroCustoDefaultCntDespRecCus ;
end;

destructor TLanConGNR.Destroy;
begin
  lblGravando := Nil;
  FreeAndNil(Generico);
  FreeAndNil(qryDados);
  inherited;
end;

function TLanConGNR.fCarregaDados: Boolean;
begin
  qryDados.Close;
  qryDados.SQL.Clear;
  qryDados.SQL.Add( fgetSQLGNRE );
  pSetaParametrosGerLanCon(recParCon, qryDados);
  qryDados.Open;
  Result := (Not qryDados.IsEmpty);
end;

function TLanConGNR.fDeletaLanCon: Boolean;
begin
  Result := Generico.fDeletaLanCon;
end;

function TLanConGNR.fEfetuaLancamentos: Boolean;
  Var
    intRecCount : Integer;
    strPagame : String;
    strPlaCta : String;
    strCodEve: string;
    strFormaPagto : string;
begin
  intRecCount := qryDados.RecordCount;
  pgbProgresso.Properties.Max := intRecCount;

  qryDados.First;
  While Not qryDados.Eof Do
  Begin
    pgbProgresso.Position := qryDados.RecNo;
    pSetaTextoProgresso(pgbProgresso, IIF(Generico.blnPreValidar, 'Pré-Validando', 'Gerando') + ' Lançamentos: "GNR": ' + IntToStr(qryDados.RecNo) + ' / ' + IntToStr(intRecCount));

    strPagame := '';
    strCodEve := TFactoryEventoContabil.New.fConfiguraEvento(qryDados.FieldByName('GNR_CODEVE').AsString).fConsultaEvento(FstrCentroCustoDefault);
    strPlaCta := qryDados.FieldByName('CTA_PLANCO').AsString;
    strFormaPagto := '';

    Generico.pGravaLancto('VLRGNRE', DES_VALOR_GNRE, strPlaCta, strFormaPagto, strCodEve, strPagame, '');

    qryDados.Next;
  End;

  Result := True;
end;

function TLanConGNR.fEfetuaLancamentosPreValidacao: Boolean;
begin
  result := Generico.fEfetuaLancamentosPreValidacao(Self) ;
end;

function TLanConGNR.fgetSQLGNRE: string;
  var
    strSQL : String;
begin
  strSQL := strSQL + '  SELECT CADGNR.GNR_CODEMP AS CODEMP, ';
  strSQL := strSQL + '        CADGNR.GNR_DTAGNR AS DTAENT, ';
  strSQL := strSQL + '        CADGNR.GNR_DTAENT AS DTACAD, ';
  strSQL := strSQL + '        CADGNR.GNR_NUMDOC AS NUMDOC, ';
  strSQL := strSQL + '        CADGNR.GNR_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '        FOR_NOMFOR AS NOME, ';
  strSQL := strSQL + '        FOR_C_G_C_ AS CNPJ, ';
  strSQL := strSQL + '        CAST("F" AS CHAR(1)) AS TIPO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + '        FOR_CODFOR AS CODIGO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + '        IFNULL(FORNCO.NCO_CODCON, FOR_PLANCO) AS PLANCO, ';
  strSQL := strSQL + '        CAST("" AS CHAR(1)) AS PLAPOR, ';
  strSQL := strSQL + '        CAST("" AS CHAR(1)) AS CLAFIS, ';
  strSQL := strSQL + '        CADCTA.CTA_PLANCO AS CTA_PLANCO, ';
  strSQL := strSQL + '        CAST("" AS CHAR(1)) AS PARCEL, ';
  strSQL := strSQL + '        CADGNR.AUTOINCREM AS SEQGER, ';
  strSQL := strSQL + '        EMP_NOMEMP AS NOMEMP, ';
  strSQL := strSQL + '        CADGNR.GNR_VALGNR AS VLRGNRE, ';
  strSQL := strSQL + '        CADGNR.GNR_CODCTA AS CODCTA, ';
  strSQL := strSQL + '        CAST("CADGNR" AS CHAR(6)) AS TABELA, ';
  strSQL := strSQL + '        CADGNR.GNR_CODEVE, ';
  strSQL := strSQL + '        CADPAG.CTP_HIST01 AS HIST01, ';
  strSQL := strSQL + '        CADPAG.CTP_HISBAI AS HISBAI';
  strSQL := strSQL + '   FROM CADGNR ';
  strSQL := strSQL + '   JOIN CADEMP ON CADGNR.GNR_CODEMP = EMP_CODEMP ';
  strSQL := strSQL + '   LEFT JOIN CADFOR ON FOR_CODFOR = CADGNR.GNR_CODFOR ';
  strSQL := strSQL + '   LEFT JOIN CADCTA ON CTA_CODCTA = CADGNR.GNR_CODCTA ';
  strSQL := strSQL + '   LEFT JOIN FORNCO ON FORNCO.NCO_CODFOR = FOR_CODFOR ';
  strSQL := strSQL + '                     AND FORNCO.NCO_CODEMP = CADGNR.GNR_CODEMP ';
  strSQL := strSQL + '   LEFT JOIN CADPAG ON CADGNR.GNR_NUMDOC = CADPAG.CTP_NUMDUP ';
  strSQL := strSQL + '                     AND CADGNR.GNR_FORDOC = CADPAG.CTP_CODFOR ';
  strSQL := strSQL + '                     AND CADGNR.GNR_CODEMP = CADPAG.CTP_CODEMP ';
  strSQL := strSQL + '                     AND CADGNR.GNR_SERIE_ = CADPAG.CTP_SERIE_ ';
  strSQL := strSQL + '                     AND CADPAG.CTP_PARCEL = "A" ';
  strSQL := strSQL + '                     AND CADPAG.CTP_SEQBAI = 0 ';
  strSQL := strSQL + '   WHERE TRUE  ';

  If (Not recParCon.strCodEmp.IsEmpty) Then
    strSQL := strSQL + '  AND CADGNR.GNR_CODEMP = :CODEMP ';

  if (recParCon.dtaDtaIni > 0) then
    strSQL := strSQL + '  AND CADGNR.GNR_DTAGNR BETWEEN :DTAINI AND :DTAFIN ';

  strSql := strSql + TTrataIncDocContabil
                      .New
                      .fColunaIncDoc('CADGNR.AUTOINCREM')
                      .fIncDoc(recParCon.strIncDoc)
                      .fArrIncDoc(recParCon.arrIncDoc)
                      .fQuerySql(Nil)
                      .fExecute ;

  strSQL := strSQL + '  ORDER BY CADGNR.AUTOINCREM ';

  Result := strSQL;
end;

function TLanConGNR.fTemParametrosConfigurados: Boolean;
begin
  Result := Generico.fTemParametrosConfigurados;
end;

function TLanConGNR.GetListaErros: TUniClientDataSet;
begin
  Result := Generico.listaErros;
end;

procedure TLanConGNR.pMensagemConclusao;
begin
  fMensagem('ATENÇÃO!', 'GNRE Concluído!', ['&OK']);
end;

procedure TLanConGNR.pSetaPreValidacao(Value: Boolean;
  objValida: IValidaContaContabil; const AblnLancarEmPreValidar: boolean = False);
begin
  Generico.blnPreValidar := Value;
  Generico.objValida := objValida;
  Generico.LancarEmPreValidar := AblnLancarEmPreValidar ;
end;

function TLanConGNR.fProgressoAtivo: boolean;
begin
  Result := False;

  if (not Assigned(pgbProgresso)) Then
    Exit;

  if (not Assigned(pgbProgresso.Parent)) then
    Exit;

  if (GetParentForm(pgbProgresso).FindComponent('lblGravando') = Nil) then
    Exit;

  Result := True;
end;

procedure TLanConGNR.pSetaPreValidacao(const Value: Boolean);
begin
  Generico.blnPreValidar := Value;
end;

procedure TLanConGNR.pSetaTextoProgresso(pgbProgresso: TcxProgressBar;
  strTexto: String);
begin
  if assigned(lblGravando) then
    lblGravando.Caption := strTexto
  else if fProgressoAtivo Then
  Begin
    lblGravando := TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando'));
    lblGravando.Caption := strTexto;
  End;
  Application.ProcessMessages;
end;

procedure TLanConGNR.pVerificaSeLancouLanCon;
begin
  Generico.pVerificaSeLancouLanCon;
end;

end.
