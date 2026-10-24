{******************************************}
{* REPOSITORY DO CADREC.                  *}
{* LOCAL DAS FUNCOES DO CADREC QUE TEM    *}
{* INTERAÇÃO COM A CAMADA DE PERSISTÊNCIA *}
{*07/08/2015****************************AF*}
unit untTCadRecRepository;

interface

uses untTCadRec, Aurelius.Criteria.Base, System.Generics.Collections, System.SysUtils,
  Aurelius.Criteria.Linq, untObjectManager, untFieldFiltros, Classes, Aurelius.Types.Nullable,
  Aurelius.Criteria.Projections;

Type
  TTipoData = (tdEnvio, tdVencimento, tdImpressao, tdCadastro);

  {**********************************************}
  {* CLASSE RESPONSÁVEL PELOS FILTROS QUE SERÃO *}
  {* EXECUTADOS NA BUSCA DOS DADOS              *}
  {*07/08/2015********************************AF*}
  TFiltros = class sealed
  Public
    dtaDtaRec   : TFieldFiltros<TDateTime>;
    dtaDtaEnvIni: TFieldFiltros<TDateTime>;
    dtaDtaEnvFin: TFieldFiltros<TDateTime>;
    dtaDtaVenIni: TFieldFiltros<TDateTime>;
    dtaDtaVenFin: TFieldFiltros<TDateTime>;
    dtaDtaCadIni: TFieldFiltros<TDateTime>;
    dtaDtaCadFin: TFieldFiltros<TDateTime>;
    dtaDtaBolIni: TFieldFiltros<TDateTime>;
    dtaDtaBolFin: TFieldFiltros<TDateTime>;
    strCodCli   : TFieldFiltros<String>;
    strCodBco   : TFieldFiltros<String>;
    strAutInc   : TFieldFiltros<String>;
    strNumDup   : TFieldFiltros<String>;
    strEspDoc   : TFieldFiltros<String>;
    strCodEmp   : TFieldFiltros<String>;
    strParcel   : TFieldFiltros<String>;
    strBcoBol   : TFieldFiltros<String>;
    intSeqBai   : TFieldFiltros<Integer>;
    strEmpAcesso: TFieldFiltros<String>;
    blnBaixado  : Boolean;

    Constructor Create;
  End;

  TCadRecRepository = class
  Private
    blnCriouObj: Boolean;

    function fFiltrar<E: class>(Filter: TFiltros): TCriteria;
    function fExecuta(Filter: TFiltros): TCadRec;
    function fExecutaList(Filter: TFiltros): TList<TCadRec>;

    function fFilterDuplicatasComRemessa(strCodCli, strCodEmp,
      strCodBco: String; dtaDtaIni, dtaDtaFin: TDateTime;
      tipDta: TTipoData; strEmpAce: String=''): TFiltros;

    function FilterDuplicatasComMercantil(ACodCli, ACodEmp, AEspDoc: String;
                                          ADtaIni, ADtaFin: TDateTime;
                                          AtipDta: TTipoData;
                                          AEmpAce: String=''): TFiltros;

  Public

    function fRetSomaDuplicatasComRemessa(strCodCli, strCodEmp,
      strCodBco: String; dtaDtaIni, dtaDtaFin: TDateTime; tipDta: TTipoData;
      Var fltValDup: Double; strEmpAce: String=''): Boolean;

    function fRetSomaDuplicatasComRemessaMercantil(strCodCli,
                                                   strCodEmp,
                                                   strEspDoc: String;
                                                   dtaDtaIni,
                                                   dtaDtaFin: TDateTime;
                                                   tipDta: TTipoData;
                                               Var fltValDup: Double;
                                                   strEmpAce: String=''): Boolean;

    function fRetDuplicatasComRemessa(strCodCli, strCodEmp, strCodBco:
      String; dtaDtaIni, dtaDtaFin: TDateTime;
      tipDta: TTipoData; strEmpAce: String=''): TList<TCadRec>;

    function RetornaDuplicatasComMercantil(ACodCli, ACodEmp, AEspDoc: String;
                                           ADtaIni, ADtaFin: TDateTime;
                                           AtipDta: TTipoData;
                                           AEmpAce: String=''): TList<TCadRec>;

    function fRetDuplicata(strAutInc: String): TCadRec; overload;
    function fRetDuplicata(strNumDup, strEspDoc, strCodCli, strCodEmp: String; strParcel: String = 'A'; intSeqBai: Integer = 0): TCadRec; overload;
    function fRetDuplicatasBaixadas(strNumDup, strEspDoc, strCodCli, strCodEmp: String; strParcel: String = ''): TList<TCadRec>;

    procedure pAtualizar; overload;
    procedure pGravar(ACadRec: TCadRec);
    procedure pAtualizar(ACadRec: TCadRec); overload;
    procedure pExcluir(ACadRec: TCadRec);

    procedure pGravaDel(ACadRec: TCadRec; strForm: String);

    Constructor Create;
    Destructor Destroy; Override;
  End;


implementation

uses untFuncoesSimples, untDelRepository, untUtilRepository, Forms, System.DateUtils;

{ TCadRecRepository }

constructor TCadRecRepository.Create;
begin
  blnCriouObj := False;
  frwk := fCriaObjManager(blnCriouObj);
end;

destructor TCadRecRepository.Destroy;
begin
  If blnCriouObj Then FreeAndNil(frwk);
  inherited;
end;

{*********************************************}
{* EXECUÇÃO DE UM SELECT QUE RETORNA APENAS  *}
{* UM OBJETO(CASO RETORNE MAIS DE UM ELE     *}
{* PEGA O PRIMEIRO REGISTRO)                 *}
{*07/08/2015*******************************AF*}
function TCadRecRepository.fExecuta(Filter: TFiltros): TCadRec;
  Var
    lstRec: TList<TCadRec>;
begin
  lstRec := fFiltrar<TCadRec>(Filter).List<TCadRec>;
  If (Not Assigned(lstRec)) Or (lstRec.Count <= 0) Then Result := Nil
  Else
  Begin
    Result := lstRec[0];
    frwk.objDBManager.Refresh(Result);
  End;
  FreeAndNil(lstRec);
end;

{*********************************************}
{* EXECUÇÃO DE UM SELECT QUE RETORNA UMA     *}
{* LISTA DE OBJETOS                          *}
{*07/08/2015*******************************AF*}
function TCadRecRepository.fExecutaList(Filter: TFiltros): TList<TCadRec>;
begin
  Result := fFiltrar<TCadRec>(Filter).List<TCadRec>;
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
{*07/08/2015************************************************AF*}
function TCadRecRepository.fFiltrar<E>(Filter: TFiltros): TCriteria;
  Var
    ACriteria: TCriteria;
begin
  ACriteria := frwk.objDBManager.CreateCriteria<E>;

  If (Filter.dtaDtaRec.Value > 0) Or (Filter.dtaDtaRec.Opcao <> opcNada) Then
  Begin
    Case Filter.dtaDtaRec.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FCTR_DTAREC'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FCTR_DTAREC'));
      Else ACriteria.Add(TLinq.Eq('FCTR_DTAREC', Filter.dtaDtaRec));
    End;
  End;

  If (Filter.dtaDtaEnvIni.Value > 0) Or (Filter.dtaDtaEnvIni.Opcao <> opcNada) Then
  Begin
    Case Filter.dtaDtaEnvIni.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FCTR_DTAENV'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FCTR_DTAENV'));
      opcBetween  : ACriteria.Add(TLinq.Ge('FCTR_DTAENV', Filter.dtaDtaEnvIni) And
                                  TLinq.Le('FCTR_DTAENV', Filter.dtaDtaEnvFin));
      Else ACriteria.Add(TLinq.Eq('FCTR_DTAENV', Filter.dtaDtaEnvIni));
    End;
  End;

  If (Filter.dtaDtaVenIni.Value > 0) Or (Filter.dtaDtaVenIni.Opcao <> opcNada) Then
  Begin
    Case Filter.dtaDtaVenIni.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FCTR_DTAVEN'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FCTR_DTAVEN'));
      opcBetween  : ACriteria.Add(TLinq.Ge('FCTR_DTAVEN', Filter.dtaDtaVenIni) And
                                  TLinq.Le('FCTR_DTAVEN', Filter.dtaDtaVenFin));
      Else ACriteria.Add(TLinq.Eq('FCTR_DTAVEN', Filter.dtaDtaVenIni));
    End;
  End;

  If (Filter.dtaDtaCadIni.Value > 0) Or (Filter.dtaDtaCadIni.Opcao <> opcNada) Then
  Begin
    Case Filter.dtaDtaCadIni.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FCTR_DTACAD'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FCTR_DTACAD'));
      opcBetween  : ACriteria.Add(TLinq.Ge('FCTR_DTACAD', Filter.dtaDtaCadIni) And
                                  TLinq.Le('FCTR_DTACAD', Filter.dtaDtaCadFin));
      Else ACriteria.Add(TLinq.Eq('FCTR_DTACAD', Filter.dtaDtaCadIni));
    End;
  End;

  If (Filter.dtaDtaBolIni.Value > 0) Or (Filter.dtaDtaBolIni.Opcao <> opcNada) Then
  Begin
    Case Filter.dtaDtaBolIni.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FCTR_DTABOL'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FCTR_DTABOL'));
      opcBetween  : ACriteria.Add(TLinq.Ge('FCTR_DTABOL', Filter.dtaDtaBolIni) And
                                  TLinq.Le('FCTR_DTABOL', Filter.dtaDtaBolFin));
      Else ACriteria.Add(TLinq.Eq('FCTR_DTABOL', Filter.dtaDtaBolIni));
    End;
  End;

  {***************************************************************
  *  Validação de Campo com Clausula In                          *
  *  Criado para validação das Empresas que o usuário tem acesso *
  *******************************************************KP*96503*}
  If Not fEmptyStr(Filter.strEmpAcesso.Value) Then
    ACriteria.Add(TLinq['FCTR_CODEMP']._In(fRetStrToSQLArr(Filter.strEmpAcesso.Value)));

  If Not fEmptyStr(Filter.strNumDup.Value) Then
    ACriteria.Add(TLinq.Eq('FCTR_NUMDUP', Filter.strNumDup));
  If Not fEmptyStr(Filter.strEspDoc.Value) Then
    ACriteria.Add(TLinq.Eq('FCTR_ESPDOC', Filter.strEspDoc));
  If ((Not fEmptyStr(Filter.strCodEmp.Value)) And (fEmptyStr(Filter.strEmpAcesso.Value))) Then
    ACriteria.Add(TLinq.Eq('FCTR_CODEMP', Filter.strCodEmp));
  If Not fEmptyStr(Filter.strParcel.Value) Then
    ACriteria.Add(TLinq.Eq('FCTR_PARCEL', Filter.strParcel));
  If Filter.intSeqBai.Value > -1 Then
    ACriteria.Add(TLinq.Eq('FCTR_SEQBAI', Filter.intSeqBai));
  If Not fEmptyStr(Filter.strCodCli.Value) Then
    ACriteria.Add(TLinq.Eq('FCODCLI', Filter.strCodCli));
  If Not fEmptyStr(Filter.strCodBco.Value) Then
    ACriteria.Add(TLinq.Eq('FCTR_BCOENV', Filter.strCodBco));
  If Not fEmptyStr(Filter.strBcoBol.Value) Then
    ACriteria.Add(TLinq.Eq('FCTR_BCOBOL', Filter.strBcoBol));
  If Not fEmptyStr(Filter.strAutInc.Value) Then
    ACriteria.Add(TLinq.Eq('FAUTOINCREM', Filter.strAutInc));

  If Filter.blnBaixado Then
    ACriteria.Add(TLinq.IsNotNull('FCTR_DTABAI'));

  Result := ACriteria;
end;

function TCadRecRepository.FilterDuplicatasComMercantil(ACodCli, ACodEmp, AEspDoc: String;
                                                        ADtaIni, ADtaFin: TDateTime;
                                                        AtipDta: TTipoData;
                                                        AEmpAce: String): TFiltros;
begin
  Result                    := TFiltros.Create;
  Result.dtaDtaRec.Opcao    := opcIsNull;
  Result.dtaDtaCadIni.Opcao := opcIsNotNull;
  Result.dtaDtaBolIni.Opcao := opcIsNotNull;
  Result.strCodCli          := ACodCli;

  If not fEmptyStr(AEmpAce) Then
    Result.strEmpAcesso := AEmpAce
  Else
    Result.strCodEmp := ACodEmp;

  Result.strEspDoc := AEspDoc;
  Result.strBcoBol := '999';

  If ADtaIni > 0 Then
  Begin                             // (tdImpressao, tdVencimento, tdCadastro);
    If AtipDta = tdImpressao Then
    Begin
      Result.dtaDtaBolIni.Value := ADtaIni;
      Result.dtaDtaBolIni.Opcao := opcBetween;
      Result.dtaDtaBolFin       := ADtaFin;
    End
    Else If AtipDta = tdVencimento Then
    Begin
      Result.dtaDtaVenIni.Value := ADtaIni;
      Result.dtaDtaVenIni.Opcao := opcBetween;
      Result.dtaDtaVenFin       := ADtaFin;
    End
    Else If AtipDta = tdCadastro Then
    Begin
      Result.dtaDtaCadIni.Value := ADtaIni;
      Result.dtaDtaCadIni.Opcao := opcBetween;
      Result.dtaDtaCadFin       := ADtaFin;
    End;
  End;
end;

function TCadRecRepository.fFilterDuplicatasComRemessa(strCodCli, strCodEmp, strCodBco: String; dtaDtaIni, dtaDtaFin: TDateTime; tipDta: TTipoData; strEmpAce: String=''): TFiltros;
begin
  Result := TFiltros.Create;
  Result.dtaDtaRec.Opcao    := opcIsNull;
  Result.dtaDtaEnvIni.Opcao := opcIsNotNull;
  Result.strCodCli := strCodCli;

  If not fEmptyStr(strEmpAce) Then
    Result.strEmpAcesso := strEmpAce
  Else
    Result.strCodEmp := strCodEmp;

  Result.strCodBco := strCodBco;

  If dtaDtaIni > 0 Then
  Begin
    If tipDta = tdEnvio Then
    Begin
      Result.dtaDtaEnvIni.Value := dtaDtaIni;
      Result.dtaDtaEnvIni.Opcao := opcBetween;
      Result.dtaDtaEnvFin := dtaDtaFin;
    End
    Else If tipDta = tdVencimento Then
    Begin
      Result.dtaDtaVenIni.Value := dtaDtaIni;
      Result.dtaDtaVenIni.Opcao := opcBetween;
      Result.dtaDtaVenFin := dtaDtaFin;
    End
    Else If tipDta = tdCadastro Then
    Begin
      Result.dtaDtaCadIni.Value := dtaDtaIni;
      Result.dtaDtaCadIni.Opcao := opcBetween;
      Result.dtaDtaCadFin := dtaDtaFin;
    End;
  End;

end;

function TCadRecRepository.fRetDuplicata(strAutInc: String): TCadRec;
  Var
    Filter: TFiltros;
begin
  Filter := TFiltros.Create;
  Filter.strAutInc := strAutInc;

  Result := fExecuta(Filter);
  FreeAndNil(Filter);
end;

{****************************}
{* RETORNA DUPLICATAS QUE   *}
{* FORAM GERADAS EM REMESSA *}
{*************************AF*}
function TCadRecRepository.fRetDuplicata(strNumDup, strEspDoc, strCodCli,
  strCodEmp, strParcel: String; intSeqBai: Integer): TCadRec;
  Var
    Filter: TFiltros;
begin
  Filter := TFiltros.Create;
  Try
    Filter.strNumDup := strNumDup;
    Filter.strEspDoc := strEspDoc;
    Filter.strCodCli := strCodCli;
    Filter.strCodEmp := strCodEmp;
    Filter.strParcel := strParcel;
    Filter.intSeqBai := intSeqBai;

    Result := fExecuta(Filter);
  Finally
    FreeAndNil(Filter);
  End;
end;

function TCadRecRepository.fRetDuplicatasBaixadas(strNumDup, strEspDoc,
  strCodCli, strCodEmp, strParcel: String): TList<TCadRec>;
  Var
    Filter: TFiltros;
begin
  Filter := TFiltros.Create;
  Try
    Filter.strNumDup := strNumDup;
    Filter.strEspDoc := strEspDoc;
    Filter.strCodCli := strCodCli;
    Filter.strCodEmp := strCodEmp;
    if not fEmptyStr(strParcel) Then
      Filter.strParcel := strParcel;

    Filter.blnBaixado := True;

    Result := fExecutaList(Filter);
  Finally
    FreeAndNil(Filter);
  End;
end;

function TCadRecRepository.fRetDuplicatasComRemessa(strCodCli, strCodEmp, strCodBco: String; dtaDtaIni, dtaDtaFin: TDateTime; tipDta: TTipoData; strEmpAce: String = ''): TList<TCadRec>;
  Var
    Filter: TFiltros;
begin
  Filter := fFilterDuplicatasComRemessa(strCodCli, strCodEmp, strCodBco, dtaDtaIni, dtaDtaFin, tipDta, strEmpAce);
  Result := fExecutaList(Filter);
  FreeAndNil(Filter);
end;

function TCadRecRepository.fRetSomaDuplicatasComRemessa(strCodCli, strCodEmp,
  strCodBco: String; dtaDtaIni, dtaDtaFin: TDateTime; tipDta: TTipoData;
  Var fltValDup: Double; strEmpAce: String=''): Boolean;
  Var
    Filter: TFiltros;

  function fSoma(Fil: TFiltros): Double;
    Var
      rst: TCriteriaResult;
  Begin
    Result := 0;
    rst := fFiltrar<TCadRec>(Fil).SetProjections(TProjections.ProjectionList
                                 .Add(TProjections.Sum('FCTR_VALDUP').As_('VALDUP'))
                                ).UniqueValue;
    If Assigned(rst) Then
      Result := IfNull(rst.Values['VALDUP'],0);
  End;

begin
  Filter    := fFilterDuplicatasComRemessa(strCodCli, strCodEmp, strCodBco, dtaDtaIni, dtaDtaFin, tipDta, strEmpAce);
  fltValDup := fSoma(Filter);
  Result    := True;
end;

function TCadRecRepository.fRetSomaDuplicatasComRemessaMercantil(strCodCli,
                                                                 strCodEmp,
                                                                 strEspDoc: String;
                                                                 dtaDtaIni,
                                                                 dtaDtaFin: TDateTime;
                                                                 tipDta: TTipoData;
                                                             Var fltValDup: Double;
                                                                 strEmpAce: String): Boolean;
Var
  Filter: TFiltros;

  function fSoma(Fil: TFiltros): Double;
    Var
      rst: TCriteriaResult;
  Begin
    Result := 0;
    rst := fFiltrar<TCadRec>(Fil).SetProjections(TProjections.ProjectionList
                                 .Add(TProjections.Sum('FCTR_VALDUP').As_('VALDUP'))
                                ).UniqueValue;
    If Assigned(rst) Then
      Result := IfNull(rst.Values['VALDUP'],0);
  End;

begin
  Filter := FilterDuplicatasComMercantil(strCodCli, strCodEmp, strEspDoc, dtaDtaIni, dtaDtaFin, tipDta, strEmpAce);
  fltValDup := fSoma(Filter);
  Result    := True;
end;

procedure TCadRecRepository.pAtualizar(ACadRec: TCadRec);
begin
  frwk.objDBManager.Update(ACadRec);
end;

procedure TCadRecRepository.pAtualizar;
begin
  frwk.objDBManager.Flush;
end;

procedure TCadRecRepository.pExcluir(ACadRec: TCadRec);
begin
  frwk.objDBManager.Remove(ACadRec);
end;

procedure TCadRecRepository.pGravaDel(ACadRec: TCadRec; strForm: String);
var
  objDel: TDelCadRec;
Begin
  objDel := TDelCadRec.Create;

  TUtil.pClone(ACadRec, objDel);
  objDel.CTR_NOMFRM := strForm;
  TGravaDel.pGrava(objDel, frwk);
end;

procedure TCadRecRepository.pGravar(ACadRec: TCadRec);
begin
  frwk.objDBManager.Save(ACadRec);
end;

function TCadRecRepository.RetornaDuplicatasComMercantil(ACodCli, ACodEmp, AEspDoc: String;
                                                         ADtaIni, ADtaFin: TDateTime;
                                                         AtipDta: TTipoData;
                                                         AEmpAce: String): TList<TCadRec>;
Var
  Filter: TFiltros;
begin
  Filter := FilterDuplicatasComMercantil(ACodCli, ACodEmp, AEspDoc, ADtaIni, ADtaFin, AtipDta, AEmpAce);
  Result := fExecutaList(Filter);
  FreeAndNil(Filter);
end;

{ TFiltros }

constructor TFiltros.Create;
begin
  dtaDtaRec.Value := 0;
  dtaDtaRec.Opcao := opcNada;

  dtaDtaEnvIni.Value := 0;
  dtaDtaEnvIni.Opcao := opcNada;

  dtaDtaEnvFin.Value := 0;
  dtaDtaEnvFin.Opcao := opcNada;

  dtaDtaVenIni.Value := 0;
  dtaDtaVenIni.Opcao := opcNada;

  dtaDtaVenFin.Value := 0;
  dtaDtaVenFin.Opcao := opcNada;

  dtaDtaCadIni.Value := 0;
  dtaDtaCadFin.Opcao := opcNada;

  dtaDtaBolIni.Value := 0;
  dtaDtaBolFin.Opcao := opcNada;

  strCodCli := '';
  strCodBco := '';
  strAutInc := '';
  strNumDup := '';
  strEspDoc := '';
  strCodEmp := '';
  strParcel := '';
  strBcoBol := '';
  intSeqBai := -1;
  blnBaixado := False;
  strEmpAcesso := '';
end;

end.
