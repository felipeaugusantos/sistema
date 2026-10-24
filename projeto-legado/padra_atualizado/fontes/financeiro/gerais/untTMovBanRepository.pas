{******************************************}
{* REPOSITORY DO MOVBAN.                  *}
{* LOCAL DAS FUNCOES DO MOVBAN QUE TEM    *}
{* INTERAÇÃO COM A CAMADA DE PERSISTÊNCIA *}
{*18/06/2015****************************JU*}
unit untTMovBanRepository;

interface

uses untTMovBan, untTCadPag, Aurelius.Criteria.Base, System.Generics.Collections,
  System.SysUtils, Aurelius.Criteria.Linq, untObjectManager, untFieldFiltros,
  Classes, Uni, untUtilRepository, untTestabilidade, untLogBan,
  Aurelius.Types.Nullable;

Type
  TFiltros = class sealed
  Public
    intPagCon: TFieldFiltros<Integer>;
    strCodEmp: TFieldFiltros<String>;
    strSeqCtp: TFieldFiltros<String>;
    strSeqLan: TFieldFiltros<String>;
    dteDtaLan: TFieldFiltros<TDateTime>;
    intSeqBai: TFieldFiltros<Integer>;
    strCodFor: TFieldFiltros<String>;

    DataBaixa: TFieldFiltros<TDateTime>;
    Constructor Create;
  End;

  TMovBanRepository = class
  Private

    blnCriouObj: Boolean;

    function fFiltrar<E: class>(Filter: TFiltros): TCriteria;
    function fExecuta(Filter: TFiltros): TMovBan;
    function fExecutaList(Filter: TFiltros): TList<TMovBan>;

  Public

    procedure pAtualizar;

    function fRetObjMovBan(APag: TCadPag): TMovBan;
    function fGravaMovBan(AMov: TMovBan): String;
    function fRetDocumentos(intPagCon: Integer; strCodEmp: String; strSeqLan: String = ''): TList<TMovBan>; Overload;
    function fGetDocumentos(intPagCon: Integer; strCodEmp: String;strCodFor: String= ''): TList<TMovBan>; overload;
    function fRetDocumentos(strCodEmp: String; strSeqLan: String): TList<TMovBan>;  Overload;
    function fGetDocumentos(intPagCon: Integer; strCodEmp: String;ADataBaixa: TDateTime;strCodFor: String= ''): TList<TMovBan>; Overload;
    function fRetContraPartida(strSeqCtp, strSeqLan, strCodEmp: String; dteDtaLan: TDateTime): TMovBan;
    function fRetMovimentoBancario(ASequenciaLancamento : string) : TMovBan; Overload;
    function fRetMovimentoBancario(AIntPagCon: Integer; AstrEmpBai, AstrSeqLan: String): TList<TMovBan>; Overload;
    function fRetMovimentoBancario(ASequencialBaixa: Integer): TMovBan; Overload;
    procedure pLimparOrigemPrincipal(ADuplicata: TCadPag; AAdiantamentoPix: Boolean = False); Overload;
    procedure pLimparOrigemPrincipal(AstrSeqCon: String; AAdiantamentoPix: Boolean = False); Overload;
    procedure pLimparOrigemPrincipal(AstrSeqBai: Integer; AAdiantamentoPix: Boolean = False); Overload;
    function fGetOrigem(strOrigem : Nullable<string>; AAdiantamentoPix: Boolean = False):  Nullable<string>;

    Constructor Create;
    Destructor Destroy; Override;
  End;

implementation

uses untFuncoesSimples, untFuncoes, Data.DB;

{ TFiltros }

constructor TFiltros.Create;
begin
  intPagCon := 0;
  strSeqCtp := '';
  strCodEmp := '';
  strSeqLan := '';
end;

{ TMovBanRepository }

constructor TMovBanRepository.Create;
begin
  blnCriouObj := False;
  frwk := fCriaObjManager(blnCriouObj);
end;

destructor TMovBanRepository.Destroy;
begin
  If blnCriouObj Then FreeAndNil(frwk);
  inherited;
end;

function TMovBanRepository.fExecuta(Filter: TFiltros): TMovBan;
  Var
    lstBan: TList<TMovBan>;
begin
  lstBan := fFiltrar<TMovBan>(Filter).List<TMovBan>;

  If (Not Assigned(lstBan)) Or (lstBan.Count <= 0) Then Result := Nil
  Else
  begin
    Result := lstBan[0];
    frwk.objDBManager.Refresh(Result);
  end;
end;

{*********************************************}
{* EXECUÇÃO DE UM SELECT QUE RETORNA UMA     *}
{* LISTA DE OBJETOS                          *}
{*25/07/2015*******************************AF*}
function TMovBanRepository.fExecutaList(Filter: TFiltros): TList<TMovBan>;
begin
  Result := fFiltrar<TMovBan>(Filter).List<TMovBan>;
end;

{**************************************************************}
{* FUNÇÃO RESPONSÁVEL PELOS FILTROS.                          *}
{* TODOS OS CAMPOS QUE SÃO TFieldFiltros TEM INTERNAMENTE     *}
{* UM CAMPO OPCAO QUE PODE SER:                               *}
{*  opcDiferente: ACriteria.Add(TLinq.Lt(?) And TLinq.Gt(?)); *}
{*  opcIsNull   : ACriteria.Add(TLinq.IsNull(?);              *}
{*  opcIsNotNull: ACriteria.Add(TLinq.IsNotNull(?);           *}
{*  opcBeetween : ACriteria.Add(TLinq.Le(?) And TLinq.Ge(?)); *}
{*  Else ACriteria.Add(TLinq.Eq(?));                          *}
{*                                                            *}
{* obs: PODE SER CRIADO OUTROS NO FUTURO                      *}
{*25/07/2015************************************************AF*}
function TMovBanRepository.fFiltrar<E>(Filter: TFiltros): TCriteria;
  Var
    ACriteria: TCriteria;
begin
  ACriteria := frwk.objDBManager.CreateCriteria<E>;

  If (Filter.intPagCon.Value > 0) Then
  Begin
    Case Filter.intPagCon.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FCTB_PAGCON'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FCTB_PAGCON'));
      opcDiferente: ACriteria.Add(TLinq.Lt('FCTB_PAGCON', Filter.intPagCon) Or
                                  TLinq.Gt('FCTB_PAGCON', Filter.intPagCon));
      Else ACriteria.Add(TLinq.Eq('FCTB_PAGCON', Filter.intPagCon));
    End;
  End;

  If Not fEmptyStr(Filter.strCodEmp) Then
  Begin
    Case Filter.strCodEmp.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FCTB_CODEMP'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FCTB_CODEMP'));
      Else ACriteria.Add(TLinq.Eq('FCTB_CODEMP', Filter.strCodEmp));
    End;
  End;

  If Not fEmptyStr(Filter.strSeqCtp) Then
  Begin
    Case Filter.strSeqCtp.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FCTB_SEQCTP'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FCTB_SEQCTP'));
      opcDiferente: ACriteria.Add(Not TLinq.Eq('FCTB_SEQCTP', Filter.strSeqCtp))
      Else ACriteria.Add(TLinq.Eq('FCTB_SEQCTP', Filter.strSeqCtp));
    End;
  End;

  If Not fEmptyStr(Filter.strSeqLan) Then
  Begin
    Case Filter.strSeqLan.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FCTB_SEQLAN'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FCTB_SEQLAN'));
      opcDiferente: ACriteria.Add(Not TLinq.Eq('FCTB_SEQLAN', Filter.strSeqLan))
      Else ACriteria.Add(TLinq.Eq('FCTB_SEQLAN', Filter.strSeqLan));
    End;
  End;

  If (Filter.intSeqBai.Value > 0) Then
  Begin
    Case Filter.intSeqBai.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FCTB_SEQBAI'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FCTB_SEQBAI'));
      opcDiferente: ACriteria.Add(TLinq.Lt('FCTB_SEQBAI', Filter.intSeqBai) Or
                                  TLinq.Gt('FCTB_SEQBAI', Filter.intSeqBai));
      Else ACriteria.Add(TLinq.Eq('FCTB_SEQBAI', Filter.intSeqBai));
    End;
  End;

  If (Filter.dteDtaLan.Value > 0) Then
  Begin
    Case Filter.dteDtaLan.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FCTB_DTALAN'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FCTB_DTALAN'));
      opcDiferente: ACriteria.Add(Not TLinq.Eq('FCTB_DTALAN', Filter.dteDtaLan))
      Else ACriteria.Add(TLinq.Eq('FCTB_DTALAN', Filter.dteDtaLan));
    End;
  End;

  If (Filter.DataBaixa.Value > 0) Then
  Begin
    Case Filter.DataBaixa.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FCTB_DTALAN'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FCTB_DTALAN'));
      opcDiferente: ACriteria.Add(Not TLinq.Eq('FCTB_DTALAN', Filter.DataBaixa))
      Else ACriteria.Add(TLinq.GreaterOrEqual('FCTB_DTALAN', Filter.DataBaixa));
    End;

    ACriteria.OrderBy('FCTB_DTALAN');
  End;

  If Not fEmptyStr(Filter.strCodFor) Then
  Begin
    Case Filter.strCodFor.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FCTB_CODFOR'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FCTB_CODFOR'));
      opcDiferente: ACriteria.Add(Not TLinq.Eq('FCTB_CODFOR', Filter.strCodFor))
      Else ACriteria.Add(TLinq.Eq('FCTB_CODFOR', Filter.strCodFor));
    End;
  End;

  Result := ACriteria;
end;

{*********************************************}
{* CRIA UM MOVBAN A PARTIR DO IDECAI         *}
{*17/06/2015*******************************AF*}
function TMovBanRepository.fRetObjMovBan(APag: TCadPag): TMovBan;
begin
  Result := TMovBan.Create;
end;

procedure TMovBanRepository.pAtualizar;
begin
  frwk.objDBManager.Flush;
end;

{* BUSCA MOVBAN PELO SEQBAI - ADIANTAMENTO *}
procedure TMovBanRepository.pLimparOrigemPrincipal(AstrSeqBai: Integer; AAdiantamentoPix: Boolean = False);
var
  AMovBan: TMovBan;
begin
  AMovBan := fRetMovimentoBancario(AstrSeqBai);

  If AMovBan <> Nil Then
  Begin
    AMovBan.strOrigem := fGetOrigem(AMovBan.strOrigem, AAdiantamentoPix);
    frwk.objDBManager.Flush;
  End;
end;

{* BUSCA MOVBAN PELO SEQCON - MANUTENÇÃO CONTAS A RECEBER *}
procedure TMovBanRepository.pLimparOrigemPrincipal(AstrSeqCon: String; AAdiantamentoPix: Boolean = False);
var
  AMovBan: TMovBan;
begin
  If AstrSeqCon.IsEmpty Then
    Exit;

  AMovBan := fRetMovimentoBancario(AstrSeqCon);

  If AMovBan = Nil Then
    Exit;

  AMovBan.strOrigem := fGetOrigem(AMovBan.strOrigem, AAdiantamentoPix);
  frwk.objDBManager.Flush;
end;

{* BUSCA MOVBAN PELO OBJETO TCADPAG - MANUTENÇÃO CONTAS A PAGAR *}
procedure TMovBanRepository.pLimparOrigemPrincipal(ADuplicata: TCadPag; AAdiantamentoPix: Boolean = False);
var
  AMovBan: TList<TMovBan>;
  ARegistro: TMovBan;
begin
  AMovBan := nil;
  Try
    AMovBan := fRetMovimentoBancario(ADuplicata.intSeqCon, ADuplicata.strEmpBai, ADuplicata.strDocBai);

    If AMovBan = Nil Then
      Exit;

    For ARegistro In AMovBan Do
    Begin
      ARegistro.strOrigem := fGetOrigem(ARegistro.strOrigem, AAdiantamentoPix);
      frwk.objDBManager.Flush;
    End;

  Finally
    FreeAndNil(AMovBan);
  End;
end;

function TMovBanRepository.fRetDocumentos(intPagCon: Integer; strCodEmp: String; strSeqLan: String = ''): TList<TMovBan>;
  Var
    Filter: TFiltros;
begin
  Filter := TFiltros.Create;
  Filter.intPagCon := intPagCon;
  Filter.strCodEmp := strCodEmp;
  If Not fEmptyStr(strSeqLan) Then
    Filter.strSeqLan := strSeqLan;

  Result := fExecutaList(Filter);
  FreeAndNil(Filter);
End;

function TMovBanRepository.fRetDocumentos(strCodEmp: String; strSeqLan: String): TList<TMovBan>;
  Var
    Filter: TFiltros;
begin
  Filter := TFiltros.Create;
  Filter.strCodEmp := strCodEmp;
  Filter.strSeqLan := strSeqLan;

  Result := fExecutaList(Filter);
  FreeAndNil(Filter);
End;

function TMovBanRepository.fRetMovimentoBancario(ASequencialBaixa: Integer): TMovBan;
Var
  Filter: TFiltros;
Begin
  Filter := TFiltros.Create;
  try
    Filter.intSeqBai := ASequencialBaixa;
    Result := fExecuta(Filter);
  finally
    FreeAndNil(Filter);
  end;
end;

function TMovBanRepository.fRetMovimentoBancario(ASequenciaLancamento: string): TMovBan;
Var
  Filter: TFiltros;
Begin
  Filter := TFiltros.Create;
  try
    Filter.strSeqLan := ASequenciaLancamento;
    Result := fExecuta(Filter);
  finally
    FreeAndNil(Filter);
  end;
end;

function TMovBanRepository.fRetContraPartida(strSeqCtp, strSeqLan,
  strCodEmp: String; dteDtaLan: TDateTime): TMovBan;
  Var
    Filter: TFiltros;
Begin
  Filter := TFiltros.Create;
  Filter.strSeqCtp := strSeqCtp;
  Filter.strCodEmp := strCodEmp;
  Filter.dteDtaLan := dteDtaLan;

  Filter.strSeqLan := strSeqLan;
  Filter.strSeqLan.Opcao := opcDiferente;

  Result := fExecuta(Filter);
  FreeAndNil(Filter);
End;

function TMovBanRepository.fRetMovimentoBancario(AIntPagCon: Integer; AstrEmpBai, AstrSeqLan: String): TList<TMovBan>;
Var
  Filter: TFiltros;
Begin
  Filter := TFiltros.Create;
  try
    Filter.intPagCon := AIntPagCon;
    Filter.strCodEmp := AstrEmpBai;
    Filter.strSeqLan := AstrSeqLan;
    Result := fExecutaList(Filter);
  finally
    FreeAndNil(Filter);
  end;
end;

function TMovBanRepository.fGravaMovBan(AMov: TMovBan): String;
  Var
    strSQL: String;
    qryConPor: TUniQuery;
begin

  Try
    {*****************************************************************}
    {* ESTE BLOCO JUNTO COM A QRYCONPOR DEVERÃO SER REMOVIDOS ASSIM  *}
    {* QUE FOREM IMPLEMENTENTADAS A CLASSE TCADPOR E SEU REPOSITÓRIO *}
    {*18/06/2015***************************************************JU*}
    If Not fEmptyStr(AMov.strCodPor) Then
    Begin
      qryConPor := fCriaQuery;

      strSQL := '';
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   POR_DTAINI ';
      strSQL := strSQL + ' FROM CADPOR ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   POR_CODPOR = :CODPOR ';

      With qryConPor Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODPOR').AsString := AMov.strCodPor;
        Open;
      End;

      If (qryConPor.IsEmpty) Or (qryConPor.FieldByName('POR_DTAINI').AsDateTime > AMov.dtaDtaLan) Then
      Begin
        Result := '';
        FreeAndNil(qryConPor);
        Exit;
      End;
    End;

    If AMov.strSeqLan = '' Then
      AMov.strSeqLan := fSeqContaBanco;

    Result := AMov.strSeqLan;
    If AMov.strAutInc = SNull Then
      AMov.strAutInc := fRetAutoIncrem(TUtil.fRetTableName(AMov), AMov.strCodEmp);
    AMov.fltValLan := Abs(AMov.fltValLan);
    frwk.objDBManager.Save(AMov);

    TTestabilidade.fGetTestabilidade.pAdicionarMovimentacaoContaBanco(AMov.strSeqLan,
      AMov.strCodPor, AMov.strCodCta, AMov.dtaDtaLan, AMov.fltValLan);
  Except
    On E: Exception Do
    Begin
      Result := '';
      pMensagensErro(E.Message, '[fGravaMovBan]');
    End;
  End;
                                  {*****************************************************************}
  If Assigned(qryConPor) Then     {* A LIBERAÇÃO DA QRYCONPOR DA MEMÓRIA DEVERÁ SER REMOVIDA ASSIM *}
    FreeAndNil(qryConPor);        {* QUE FOREM IMPLEMENTENTADAS A CLASSE TCADPOR E SEU REPOSITÓRIO *}
                                  {*18/06/2015***************************************************JU*}
end;

function TMovBanRepository.fGetDocumentos(intPagCon: Integer; strCodEmp, strCodFor : String): TList<TMovBan>;
  Var
    Filter: TFiltros;
begin
  Filter := TFiltros.Create;
  Filter.intPagCon := intPagCon;
  Filter.strCodEmp := strCodEmp;
  If fCfgSis('CTP_AS') = 'A' Then
    Filter.strCodFor := strCodFor;
  Result := fExecutaList(Filter);
  FreeAndNil(Filter);
End;

function TMovBanRepository.fGetDocumentos(intPagCon: Integer; strCodEmp: String;
  ADataBaixa: TDateTime; strCodFor: String): TList<TMovBan>;
  Var
    Filter: TFiltros;
begin
  Filter := TFiltros.Create;
  Filter.intPagCon := intPagCon;
  Filter.strCodEmp := strCodEmp;
  If fCfgSis('CTP_AS') = 'A' Then
    Filter.strCodFor := strCodFor;
  Filter.DataBaixa := ADataBaixa;
  Result := fExecutaList(Filter);
  FreeAndNil(Filter);
end;

function TMovBanRepository.fGetOrigem(strOrigem: Nullable<string>; AAdiantamentoPix: Boolean = False):  Nullable<string>;
begin
  If AAdiantamentoPix Then
    Result := strOrigem
  Else
   Result := sNull;

  If fCfgSis('ORIEST', varBoolean) Then
    Exit(sNull);

  If Not AAdiantamentoPix Then
  Begin
    If (strOrigem = 'MCA') Or (strOrigem = 'ECR') Then Result := 'ECR' // ESTORNO DE CARTÃO
    Else If (strOrigem = 'CTR') Or (strOrigem = 'ERC') Then  Result := 'ERC' // ESTORNO DE CONTAS A RECEBER
    Else If (strOrigem = 'ADT') Then  Result := 'ADT' // ESTORNO DE ADIANTAMENTO
    Else If (strOrigem = 'CTP') Or (strOrigem = 'EPG') Then  Result := 'EPG' // ESTORNO DE CONTAS A PAGAR
    Else If (strOrigem = 'ANT') Then  Result := 'ANT';
  End;
end;

end.
