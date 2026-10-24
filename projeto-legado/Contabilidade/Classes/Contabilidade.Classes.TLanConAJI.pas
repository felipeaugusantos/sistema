unit Contabilidade.Classes.TLanConAJI;

interface

uses Contabilidade.Classes.TGerLanCon, Uni, cxProgressBar, Classes, Data.DB,
  UniClientDataSet, Contabilidade.Interfaces, Vcl.StdCtrls;

type
  TLanConAJI = Class(TInterfacedObject, ITipLanCon)
  private
    qryDados : TUniQuery;
    Generico : TLanConGenerico;
    pgbProgresso : TcxProgressBar;
    recParCon: TParametrosConsulta;
    lblGravando : TLabel;
    FExisteCampoIncFis : boolean;
    procedure pSetaTextoProgresso(pgbProgresso: TcxProgressBar; strTexto: String);
    function fgetSQLAJI: string;
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
  untFuncoesSimples, SysUtils, StrUtils, Contabilidade.Funcoes, Forms,
  Contabilidade.Classes.TTrataIncDoc;

{ TLanConAJI }

constructor TLanConAJI.Create(strTipLan: String; pgbProgresso: TcxProgressBar;
  recParCon: TParametrosConsulta);
begin
  lblGravando := Nil;
  qryDados := fCriaQuery(Nil);
  qryDados.CachedUpdates := True;
  qryDados.Options.SetFieldsReadOnly := False;
  Generico := TLanConGenerico.Create(qryDados, strTipLan, recParCon);
  if fCampoExiste('AJUICM','AJU_INCFIS') then
    Self.FExisteCampoIncFis := true
  else
    Self.FExisteCampoIncFis := false;
  Self.pgbProgresso := pgbProgresso;
  Self.recParCon := recParCon;
end;

destructor TLanConAJI.Destroy;
begin
  lblGravando := Nil;
  FreeAndNil(Generico);
  FreeAndNil(qryDados);
  inherited;
end;

function TLanConAJI.fCarregaDados: Boolean;
begin
  qryDados.Close;
  qryDados.SQL.Clear;
  qryDados.SQL.Add( fgetSQLAJI );
  pSetaParametrosGerLanCon(recParCon, qryDados);
  qryDados.Open;
  Result := (Not qryDados.IsEmpty);
end;

function TLanConAJI.fDeletaLanCon: Boolean;
begin
  Result := Generico.fDeletaLanCon;
end;

function TLanConAJI.fEfetuaLancamentos: Boolean;
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
    pSetaTextoProgresso(pgbProgresso, IIF(Generico.blnPreValidar, 'Pré-Validando', 'Gerando') + ' Lançamentos: "AJI": ' + IntToStr(qryDados.RecNo) + ' / ' + IntToStr(intRecCount));

    strPagame := '';
    strCodEve := '';
    strPlaCta := '';
    strFormaPagto := '';

    Generico.pGravaLancto('VLRICMS', DES_VALOR_ICMS, strPlaCta, strFormaPagto, strCodEve, strPagame, qryDados.FieldByName('ORIGEM').AsString);

    qryDados.Next;
  End;

  Result := True;
end;

function TLanConAJI.fEfetuaLancamentosPreValidacao: Boolean;
begin
  result := Generico.fEfetuaLancamentosPreValidacao(Self) ;
end;

function TLanConAJI.fgetSQLAJI: string;
  var
    strSQL : String;
begin
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   CADEMP.EMP_CODEMP AS CODEMP, ';
  strSQL := strSQL + '   CADEMP.EMP_NOMEMP AS NOMEMP, ';
  strSQL := strSQL + '   LAST_DAY(STR_TO_DATE(CONCAT("01/",AJU_MESANO), "%d/%m/%Y")) AS DTAENT, ';
  strSQL := strSQL + '   LAST_DAY(STR_TO_DATE(CONCAT("01/",AJU_MESANO), "%d/%m/%Y")) AS DTACAD, ';
  strSQL := strSQL + '   F.FIS_NUMDOC AS NUMDOC, ';
  strSQL := strSQL + '   F.FIS_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '   F.FIS_TIP_FC AS TIPO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + '   IF(F.FIS_TIP_FC = "C", IFNULL(NCO_CODCLI, CLI_CODCLI), IFNULL(NCO_CODFOR, FOR_CODFOR)) AS CODIGO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + '   IF(FIS_TIP_FC = "C", CLI_NOMCLI, FOR_NOMFOR) AS NOME, ';
  strSQL := strSQL + '   IF(FIS_TIP_FC = "C", CLI_C_G_C_, FOR_C_G_C_) AS CNPJ, ';
  strSQL := strSQL + '   IF(FIS_TIP_FC = "C", IFNULL(CLINCO.NCO_CODCON, CLI_PLANCO), IFNULL(FORNCO.NCO_CODCON, FOR_PLANCO)) AS PLANCO, ';
  strSQL := strSQL + '   LPAD(AJUSTE.AJU_TIPAJU, 3, "0")  AS ORIGEM, ';
  strSQL := strSQL + '   CAST(NULL AS CHAR(1)) AS PLAPOR, ';
  strSQL := strSQL + '   CAST(NULL AS CHAR(1)) AS CLAFIS, ';
  strSQL := strSQL + '   I.AJU_OBSERV AS OBSERVACAO, ';
  strSQL := strSQL + '   "AJUICM" AS TABELA, ';
  strSQL := strSQL + '   I.AUTOINCREM AJUINC, ';
  strSQL := strSQL + '   I.AJU_NUMNOT AS NOTAFISCAL, ';
  strSQL := strSQL + '   I.AJU_VALAJU AS VLRICMS ';
  strSQL := strSQL + ' FROM AJUICM I ';
  strSQL := strSQL + ' LEFT JOIN AJUSTE ON AJUSTE.AJU_CODAJU = I.AJU_CODAJU ';
  strSQL := strSQL + ' INNER JOIN CADFIS AS F ';

  if FExisteCampoIncFis then
  begin
    strSQL := strSQL + '   ON F.AUTOINCREM = I.AJU_INCFIS ';
    strSQL := strSQL + '   AND F.FIS_ESPDOC = "NF" ';
  end
  else
  begin
    strSQL := strSQL + '    ON F.FIS_NUMDOC = SUBSTRING(I.AJU_NUMNOT, 1, 12) ';
    strSQL := strSQL + '   AND F.FIS_ESPDOC = "NF" ';
    strSQL := strSQL + '   AND F.FIS_CODEMP = I.AJU_CODEMP ';
    strSQL := strSQL + '   AND DATE_FORMAT(F.FIS_DTAENT, "%m/%Y") = I.AJU_MESANO ';
  end;

  strSQL := strSQL + ' LEFT JOIN CADEMP ON I.AJU_CODEMP = CADEMP.EMP_CODEMP ';
  strSQL := strSQL + ' LEFT JOIN CADCLI ON CLI_CODCLI = FIS_FORCLI AND F.FIS_TIP_FC = "C" ';
  strSQL := strSQL + ' LEFT JOIN CADFOR ON FOR_CODFOR = FIS_FORCLI AND F.FIS_TIP_FC = "F" ';
  strSQL := strSQL + ' LEFT JOIN CLINCO ON CLINCO.NCO_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + '                  AND CLINCO.NCO_CODEMP = FIS_CODEMP ';
  strSQL := strSQL + ' LEFT JOIN FORNCO ON FORNCO.NCO_CODFOR = FOR_CODFOR  ';
  strSQL := strSQL + '                  AND FORNCO.NCO_CODEMP = FIS_CODEMP ';
  strSQL := strSQL + ' WHERE AJUSTE.AJU_ENVAPU = "S" ';

  If (Not recParCon.strCodEmp.IsEmpty) Then
    strSQL := strSQL + '  AND I.AJU_CODEMP = :CODEMP ';

  if (recParCon.dtaDtaIni > 0) then
    strSQL := strSQL + '  AND LAST_DAY(STR_TO_DATE(CONCAT("01/",AJU_MESANO), "%d/%m/%Y")) BETWEEN :DTAINI AND :DTAFIN ';

  strSql := strSql + TTrataIncDocContabil
                      .New
                      // Req. 470760: o LANCON guarda NUMDOC+ESPDOC+CODEMP (TChaveDocInterprete), nao o AUTOINCREM.
                      .fColunaIncDoc(IfThen(recParCon.blnReprocessaErros,
                                            'CONCAT(F.FIS_NUMDOC, F.FIS_ESPDOC, CADEMP.EMP_CODEMP)',
                                            'I.AUTOINCREM'))
                      .fIncDoc(recParCon.strIncDoc)
                      .fArrIncDoc(recParCon.arrIncDoc)
                      .fQuerySql(Nil)
                      .fExecute ;

  strSQL := strSQL + '  ORDER BY I.AUTOINCREM ';

  Result := strSQL;
end;

function TLanConAJI.fTemParametrosConfigurados: Boolean;
begin
  Result := Generico.fTemParametrosConfigurados;
end;

function TLanConAJI.GetListaErros: TUniClientDataSet;
begin
  Result := Generico.listaErros;
end;

procedure TLanConAJI.pMensagemConclusao;
begin
  fMensagem('ATENÇÃO!', 'Ajuste/Estorno ICMS Concluído!', ['&OK']);
end;

procedure TLanConAJI.pSetaPreValidacao(Value: Boolean;
  objValida: IValidaContaContabil; const AblnLancarEmPreValidar: boolean = False);
begin
  Generico.blnPreValidar := Value;
  Generico.objValida := objValida;
  Generico.LancarEmPreValidar := AblnLancarEmPreValidar ;
end;

procedure TLanConAJI.pSetaPreValidacao(const Value: Boolean);
begin
  Generico.blnPreValidar := Value;
end;

procedure TLanConAJI.pSetaTextoProgresso(pgbProgresso: TcxProgressBar;
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

procedure TLanConAJI.pVerificaSeLancouLanCon;
begin
  Generico.pVerificaSeLancouLanCon;
end;

end.
