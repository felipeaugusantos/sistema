{******************************************}
{* REPOSITORY DO CADPAG.                  *}
{* LOCAL DAS FUNCOES DO CADPAG QUE TEM    *}
{* INTERAÇÃO COM A CAMADA DE PERSISTÊNCIA *}
{*17/06/2015****************************AF*}
unit untTCadPagRepository;

interface

uses untTCadPag, Aurelius.Criteria.Base, System.Generics.Collections, System.SysUtils,
  Aurelius.Criteria.Linq, untObjectManager, untFieldFiltros, Classes, Aurelius.Types.Nullable,
  System.Generics.Defaults;

Type
  {**********************************************}
  {* CLASSE RESPONSÁVEL PELOS FILTROS QUE SERÃO *}
  {* EXECUTADOS NA BUSCA DOS DADOS              *}
  {*17/06/2015********************************AF*}
  TFiltros = class sealed
  Public
    strDup   : TFieldFiltros<String>;
    strPar   : TFieldFiltros<String>;
    strEmp   : TFieldFiltros<String>;
    strFor   : TFieldFiltros<String>;
    strSer   : TFieldFiltros<String>;
    intSeqBai: TFieldFiltros<Integer>;
    intSeqCon: TFieldFiltros<Integer>;
    strEmpBai: TFieldFiltros<String>;
    strAutInc: TFieldFiltros<String>;
    dtaDtaBai: TFieldFiltros<TDateTime>;

    blnBaixado: Boolean;
    blnResCai : Boolean;

    Constructor Create;
  End;

  TCadPagRepository = class
  Private

    blnCriouObj: Boolean;
    FOrderSeqBaiDesc: IComparer<TCadPag>;

    function fFiltrar<E: class>(Filter: TFiltros): TCriteria;
    function fExecuta(Filter: TFiltros; Refreshing: Boolean = False): TCadPag;
    function fExecutaList(Filter: TFiltros): TList<TCadPag>;

    procedure pOrderListSeqBaiDesc;
    function fGetMsgEstorno(strNumDup, strSeqBai, strParcel, strCodEmp: String;
      dtaDtaPag: TDateTime; fltValPag: Double): String;
  Public
    procedure pDeletar(ADup: TCadPag);
    function fAtualizar(ADup: TCadPag; strDescri, strNomFrm: String): Boolean;
    procedure pEstornaDuplicataSimples(ADup: TCadPag; strNomFrm: String);
    procedure pEstornaDuplicataParcial(ADup: TCadPag; strNomFrm: String);
    procedure pGravaDelCadPag(ADup: TCadPag; strForm: String);

    procedure pGravaCadPag(ADup: TCadPag; strDescri, strNomFrm: String);

    function fRetDuplicatasBaixadas(blnResCai: Boolean; intSeqCon: Integer; strEmpBai: String): TList<TCadPag>; Overload;
    function fRetDuplicatasBaixadas(blnResCai: Boolean; intSeqCon: Integer; strEmpBai: String; ADataBaixa: TDateTime): TList<TCadPag>; Overload;
    function fRetDuplicatasBaixadas(ADup: TCadPag; blnResCai: Boolean): TList<TCadPag>; Overload;
    function fRetDuplicatasBaixadas(strNumDup, strParcel, strCodEmp, strCodFor, strSerie_: String; blnResCai: Boolean): TList<TCadPag>; Overload;

    function fRetDuplicataBaixada(ADup: TCadPag; blnResCai: Boolean): TCadPag; Overload;
    function fRetDuplicataBaixada(strNumDup, strParcel: String; intSeqBai: Integer; strCodEmp, strCodFor, strSerie_: String; blnResCai: Boolean): TCadPag; Overload;

    function fRetDuplicatas(blnResCai: Boolean; intSeqCon: Integer; strEmpBai: String): TList<TCadPag>; Overload;
    function fRetDuplicatas(strNumDup, strCodEmp, strCodFor, strSerie_: String): TList<TCadPag>; Overload;

    function fRetDuplicata(strNumDup, strParcel: String; intSeqBai: Integer; strCodEmp, strCodFor, strSerie_: String): TCadPag; Overload;
    function fRetDuplicata(strAutInc: String): TCadPag; Overload;

    function fTemDuplicataPosteriorBaixada(ADup: TCadPag): Boolean;

    Constructor Create;
    Destructor Destroy; Override;

    property orderSeqBaiDesc: IComparer<TCadPag> Read FOrderSeqBaiDesc Write FOrderSeqBaiDesc;
  End;

implementation

uses untFuncoesSimples, untUtilRepository, untDelRepository, untLogCtp;

{ TCadPagRepository }

constructor TCadPagRepository.Create;
begin
  blnCriouObj := False;
  frwk := fCriaObjManager(blnCriouObj);

  pOrderListSeqBaiDesc;
end;

destructor TCadPagRepository.Destroy;
begin
  If blnCriouObj Then
    FreeAndNil(frwk);
  inherited;
end;

function TCadPagRepository.fAtualizar(ADup: TCadPag; strDescri,
  strNomFrm: String): Boolean;
begin
  Try
    frwk.objDBManager.Update(ADup);
    pGravaLogCtp(ADup, strDescri, strNomFrm);
    Result := True;
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create('Ocorreu um erro ao gravar a parcela. ' + sLineBreak + 'Erro gerado: ' + E.Message);
    End;
  End;
end;

{*********************************************}
{* EXECUÇÃO DE UM SELECT QUE RETORNA APENAS  *}
{* UM OBJETO(CASO RETORNE MAIS DE UM ELE     *}
{* PEGA O PRIMEIRO REGISTRO)                 *}
{*17/06/2015*******************************AF*}
function TCadPagRepository.fExecuta(Filter: TFiltros; Refreshing: Boolean = False): TCadPag;
  Var
    lstPag: TList<TCadPag>;
    Criteria: TCriteria;
begin
  Criteria := fFiltrar<TCadPag>(Filter);

  if Refreshing then
    Criteria.Refreshing;

  lstPag := Criteria.List<TCadPag>;

  If (Not Assigned(lstPag)) Or (lstPag.Count <= 0) Then
    Result := Nil
  Else
  Begin
    Result := lstPag[0];
    frwk.objDBManager.Refresh(Result);
  End;
end;

{*********************************************}
{* EXECUÇÃO DE UM SELECT QUE RETORNA UMA     *}
{* LISTA DE OBJETOS                          *}
{*17/06/2015*******************************AF*}
function TCadPagRepository.fExecutaList(Filter: TFiltros): TList<TCadPag>;
begin
  Result := fFiltrar<TCadPag>(Filter).List<TCadPag>;
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
{*17/06/2015************************************************AF*}
function TCadPagRepository.fFiltrar<E>(Filter: TFiltros): TCriteria;
  Var
    ACriteria: TCriteria;
begin
  ACriteria := frwk.objDBManager.CreateCriteria<E>;

  If Not fEmptyStr(Filter.strDup.Value) Then
  Begin
    Case Filter.strDup.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FNUMDUP'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FNUMDUP'));
      Else ACriteria.Add(TLinq.Eq('FNUMDUP', Filter.strDup));
    End;
  End;

  If Not fEmptyStr(Filter.strPar) Then
  Begin
    Case Filter.strPar.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FPARCEL'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FPARCEL'));
      Else ACriteria.Add(TLinq.Eq('FPARCEL', Filter.strPar));
    End;
  End;

  If Not fEmptyStr(Filter.strEmp) Then
  Begin
    Case Filter.strEmp.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FCODEMP'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FCODEMP'));
      Else ACriteria.Add(TLinq.Eq('FCODEMP', Filter.strEmp));
    End;
  End;

  If Not fEmptyStr(Filter.strFor) Then
  Begin
    Case Filter.strFor.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FCODFOR'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FCODFOR'));
      Else ACriteria.Add(TLinq.Eq('FCODFOR', Filter.strFor));
    End;
  End;

  If Not fEmptyStr(Filter.strEmpBai) Then
  Begin
    Case Filter.strEmpBai.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FEMPBAI'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FEMPBAI'));
      Else ACriteria.Add(TLinq.Eq('FEMPBAI', Filter.strEmpBai));
    End;
  End;

  If (Filter.intSeqCon.Value > 0) Then
  Begin
    Case Filter.intSeqCon.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FSEQCON'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FSEQCON'));
      opcDiferente: ACriteria.Add(TLinq.Lt('FSEQCON', Filter.intSeqCon) Or
                                  TLinq.Gt('FSEQCON', Filter.intSeqCon));
      Else ACriteria.Add(TLinq.Eq('FSEQCON', Filter.intSeqCon));
    End;
  End;

  If Not fEmptyStr(Filter.strSer) Then
  Begin
    Case Filter.strSer.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FSERIE_') Or TLinq.Eq('FSERIE_',''));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FSERIE_'));
      Else ACriteria.Add(TLinq.Eq('FSERIE_', Filter.strSer));
    End;
  End;

  If (Filter.intSeqBai.Value > -1) Then
  Begin
    Case Filter.intSeqBai.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FSEQBAI'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FSEQBAI'));
      opcDiferente: ACriteria.Add(TLinq.Lt('FSEQBAI', Filter.intSeqBai) Or
                                  TLinq.Gt('FSEQBAI', Filter.intSeqBai));
      opcMaiorQue : ACriteria.Add(TLinq.Gt('FSEQBAI', Filter.intSeqBai));
      Else ACriteria.Add(TLinq.Eq('FSEQBAI', Filter.intSeqBai));
    End;
  End;

  If (Filter.dtaDtaBai.Value > 0) Then
  Begin
    Case Filter.dtaDtaBai.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FDTABAI'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FDTABAI'));
      opcDiferente: ACriteria.Add(TLinq.Lt('FDTABAI', Filter.dtaDtaBai) Or
                                  TLinq.Gt('FDTABAI', Filter.dtaDtaBai));
      Else ACriteria.Add(TLinq.Eq('FDTABAI', Filter.dtaDtaBai));
    End;
  End;

  If Not fEmptyStr(Filter.strAutInc) Then
    ACriteria.Add(TLinq.Eq('FAutInc', Filter.strAutInc));
  If Filter.blnBaixado Then
    ACriteria.Add(TLinq.IsNotNull('FDTAPAG'));
  If Filter.blnResCai  Then
    ACriteria.Add(TLinq.Eq('FRESCAI',1));

  Result := ACriteria;
end;

{*********************************************}
{* RETORNA DUPLICATAS BAIXADAS FILTRANDO O   *}
{* SEQCON, EMPBAI E SE FOR > ZERO O RESCAI   *}
{*17/06/2015*******************************AF*}
function TCadPagRepository.fRetDuplicatasBaixadas(blnResCai: Boolean;
  intSeqCon: Integer; strEmpBai: String): TList<TCadPag>;
  Var
    Filter: TFiltros;
begin
  Filter := TFiltros.Create;
  Filter.intSeqCon  := intSeqCon;
  Filter.strEmpBai  := strEmpBai;
  Filter.blnResCai  := blnResCai;
  Filter.blnBaixado := True;

  Result := fExecutaList(Filter);
  FreeAndNil(Filter);
end;

{*********************************************}
{* RETORNA UMA LISTA DE DUPLICATAS BAIXADAS  *}
{* A PARTIR DE UMA DUPLICATA (SEM SEQBAI)    *}
{*17/06/2015*******************************AF*}
function TCadPagRepository.fRetDuplicatasBaixadas(ADup: TCadPag; blnResCai: Boolean): TList<TCadPag>;
begin
  Result := fRetDuplicatasBaixadas(ADup.strNumDup, ADup.strParcel, ADup.strCodEmp,
    ADup.objCodFor.FOR_CODFOR, ADup.strSerie, blnResCai);
end;

{*********************************************}
{* RETORNA UMA DUPLICATA ESPECÍFICA A PARTIR *}
{* DO AUTOINCREM                             *}
{*17/06/2015*******************************AF*}
function TCadPagRepository.fRetDuplicata(strAutInc: String): TCadPag;
  Var
    Filter: TFiltros;
    lstPag: TList<TCadPag>;
begin
  Filter := TFiltros.Create;
  Filter.strAutInc := strAutInc;

  lstPag := fFiltrar<TCadPag>(Filter).List<TCadPag>;

  If (Not Assigned(lstPag)) Or (lstPag.Count <= 0) Then
    Result := Nil
  Else
    Result := lstPag[0];

  FreeAndNil(Filter);
end;

{*********************************************}
{* RETORNA UMA DUPLICATA ESPECÍFICA BAIXADA  *}
{* A PARTIR DE UMA OUTRA. (VAI RETORNAR ELA  *}
{* MESMA. É ÚTIL PARA RECEBER ELA ATUALIZADA *}
{* PARA VER SE ELA JÁ FOI ESTORNADA)         *}
{*17/06/2015*******************************AF*}
function TCadPagRepository.fRetDuplicataBaixada(ADup: TCadPag;
  blnResCai: Boolean): TCadPag;
begin
  Result := fRetDuplicataBaixada(ADup.strNumDup, ADup.strParcel, ADup.intSeqBai,
    ADup.strCodEmp, ADup.objCodFor.FOR_CODFOR, ADup.strSerie, blnResCai);
end;

{*********************************************}
{* RETORNA UMA DUPLICATA ESPECÍFICA BAIXADA  *}
{* A PARTIR DA CHAVE                         *}
{*17/06/2015*******************************AF*}
function TCadPagRepository.fRetDuplicataBaixada(strNumDup, strParcel: String; intSeqBai: Integer;
  strCodEmp, strCodFor, strSerie_: String; blnResCai: Boolean): TCadPag;
  Var
    Filter: TFiltros;
begin
  Filter := TFiltros.Create;
  Filter.strDup     := strNumDup;
  Filter.strPar     := strParcel;
  Filter.intSeqBai  := intSeqBai;
  Filter.strEmp     := strCodEmp;
  Filter.strFor     := strCodFor;

  Filter.strSer     := strSerie_;
  If fEmptyStr(strSerie_) Then
    Filter.strSer.Opcao := opcIsNull;

  Filter.blnBaixado := True;
  Filter.blnResCai  := blnResCai;

  Result := fExecuta(Filter);
  FreeAndNil(Filter);
end;

{*********************************************}
{* RETORNA UMA LISTA DE DUPLICATAS FILTRANDO *}
{* O SEQCON, EMPBAI E SE FOR > ZERO O RESCAI *}
{*17/06/2015*******************************AF*}
function TCadPagRepository.fRetDuplicatas(blnResCai: Boolean;
  intSeqCon: Integer; strEmpBai: String): TList<TCadPag>;
  Var
    Filter: TFiltros;
begin
  Filter := TFiltros.Create;
  Filter.intSeqCon  := intSeqCon;
  Filter.strEmpBai  := strEmpBai;
  Filter.blnResCai  := blnResCai;

  Result := fExecutaList(Filter);
  FreeAndNil(Filter);
end;

{*********************************************}
{* RETORNA UMA LISTA DE DUPLICATAS A PARTIR  *}
{* DO NUMDUP, CODEMP, CODFOR E SERIE         *}
{*29/01/2020*******************************RP*}
function TCadPagRepository.fRetDuplicatas(strNumDup, strCodEmp, strCodFor,
  strSerie_: String): TList<TCadPag>;
  Var
    Filter: TFiltros;
begin
  Filter := TFiltros.Create;
  Filter.strDup := strNumDup;
  Filter.strEmp := strCodEmp;
  Filter.strFor := strCodFor;
  Filter.strSer := strSerie_;

  Result := fExecutaList(Filter);
  FreeAndNil(Filter);
end;

{*********************************************}
{* RETORNA UMA LISTA DE DUPLICATAS BAIXADAS  *}
{* A PARTIR DA CHAVE (SEM SEQBAI)            *}
{*17/06/2015*******************************AF*}
function TCadPagRepository.fRetDuplicatasBaixadas(strNumDup, strParcel,
  strCodEmp, strCodFor, strSerie_: String; blnResCai: Boolean): TList<TCadPag>;
  Var
    Filter: TFiltros;
begin
  Filter := TFiltros.Create;
  Filter.strDup := strNumDup;
  Filter.strPar := strParcel;
  Filter.strEmp := strCodEmp;
  Filter.strFor := strCodFor;

  Filter.strSer := strSerie_;
  If fEmptyStr(strSerie_) Then
    Filter.strSer.Opcao := opcIsNull;

  Filter.blnBaixado := True;
  Filter.blnResCai  := blnResCai;

  Result := fExecutaList(Filter);
  FreeAndNil(Filter);
end;

function TCadPagRepository.fRetDuplicatasBaixadas(blnResCai: Boolean;
  intSeqCon: Integer; strEmpBai: String; ADataBaixa: TDateTime): TList<TCadPag>;
  Var
    Filter: TFiltros;
begin
  Filter := TFiltros.Create;
  Filter.intSeqCon  := intSeqCon;
  Filter.strEmpBai  := strEmpBai;
  Filter.dtaDtaBai  := ADataBaixa;
  Filter.blnResCai  := blnResCai;
  Filter.blnBaixado := True;

  Result := fExecutaList(Filter);
  FreeAndNil(Filter);
end;

{*********************************************}
{* VERIFICA SE EXISTE ALGUMA DUPLICATA       *}
{* PARCIAL BAIXADA DEPOIS DA QUE ESTÁ SENDO  *}
{* ESTORNADA.                                *}
{*17/06/2015*******************************AF*}
function TCadPagRepository.fTemDuplicataPosteriorBaixada(ADup: TCadPag): Boolean;
  Var
    obj: TCadPag;
    Filter: TFiltros;
Begin

  If ADup.intSeqBai = 0 Then
  Begin
    Result := False;
    Exit;
  End;

  Filter := TFiltros.Create;
  Filter.strDup := ADup.strNumDup;
  Filter.strPar := ADup.strParcel;
  Filter.strEmp := ADup.strCodEmp;
  Filter.strFor := ADup.objCodFor.FOR_CODFOR;

  Filter.strSer := ADup.strSerie;
  If fEmptyStr(ADup.strSerie) Then
    Filter.strSer.Opcao := opcIsNull;

  Filter.intSeqBai.Value := ADup.intSeqBai.Value;
  Filter.intSeqBai.Opcao := opcMaiorQue;

  Filter.intSeqCon.Value := ADup.intSeqCon.Value;
  Filter.intSeqCon.Opcao := opcDiferente;

  obj := fExecuta(Filter);
  Result := Assigned(obj);

  FreeAndNil(Filter);
end;

procedure TCadPagRepository.pOrderListSeqBaiDesc;
begin
  FOrderSeqBaiDesc := TComparer<TCadPag>.Construct(TComparison<TCadPag>(
                      function(const R, L: TCadPag): integer
                      Begin
                        Result := L.intSeqBai.Value - R.intSeqBai.Value;
                      End));
end;

{*********************************************}
{* DELETA UMA DUPLICATA                      *}
{*17/06/2015*******************************AF*}
procedure TCadPagRepository.pDeletar(ADup: TCadPag);
begin
  frwk.objDBManager.Remove(ADup);
end;

function TCadPagRepository.fGetMsgEstorno(strNumDup, strSeqBai, strParcel, strCodEmp: String; dtaDtaPag:TDateTime; fltValPag: Double): String;
begin
  Result := '<<csq>>' + // <<STRING QUEBRA DE LINHA>>
            ' - DUPLICATA ESTORNADA: ' + FormatDateTime('dd/mm/yyyy', fNow()) +
            ' ' + strNumDup + strParcel +
            ' - SEQ: ' + strSeqBai + ' - EMP: ' + strCodEmp +
            ' - DTA. PAG.: ' + FormatDateTime('dd/mm/yyyy', dtaDtaPag) +
            ' - VR. PAG.: '  + FormatFloat('#,##0.00', fltValPag);
end;

{*********************************************}
{* REALIZA UM ESTORNO PARCIAL E JÁ GRAVA O   *}
{* LOGCTP                                    *}
{*17/06/2015*******************************AF*}
procedure TCadPagRepository.pEstornaDuplicataParcial(ADup: TCadPag; strNomFrm: String);
  Var
    ADupPri: TCadPag;
    strCodFor: String;
    strMsgEstorno    : String;
begin
  ADupPri := fRetDuplicata(ADup.strNumDup, ADup.strParcel, 0, ADup.strCodEmp, ADup.objCodFor.FOR_CODFOR, ADup.strSerie);

  strMsgEstorno := fGetMsgEstorno( ADup.strNumDup,
                                   IntToStr(ADup.intSeqBai),
                                   ADup.strParcel,
                                   ADup.strCodEmp,
                                   ADup.dtaDtaPag,
                                   ADup.fltValPag);

  ADupPri.fltValDup := IIF(IfNull(ADup.fltValAnt, 0) > 0, ADup.fltValAnt, ADupPri.fltValDup + (ADup.fltValPag) - (ADup.fltValJur + ADup.fltJurAnt) - (ADup.fltValMul + ADup.fltMulAnt) + (ADup.fltValDes + ADup.fltDesAnt));
  ADupPri.fltValOri := ADupPri.fltValDup; //ADupPri.fltValDup;
  ADupPri.fltJurSuj := ADup.fltJurAnt;
  ADupPri.fltMulSuj := ADup.fltMulAnt;
  ADupPri.fltDesSuj := ADup.fltDesAnt;
  ADupPri.fltOutEnt := ADup.fltOutEnt;
  ADupPri.fltVendor := ADup.fltVendor;
  ADupPri.dtaDtaBai := SNull;
  ADupPri.strEmpBai := SNull;
  ADupPri.strCtaBai := SNull;
  ADupPri.strPorBai := SNull;
  ADupPri.strDocBai := SNUll;

  //variável para executar o Get no CodFor para gravar o LOGCTP
  strCodFor := ADupPri.objCodFor.FOR_CODFOR;

  If ADup.intSeqBai = 1 Then
    ADupPri.strHisBai := SNull;

  ADupPri.strOpeBai := SNull;
  ADupPri.fltValPag := 0;
  ADupPri.dtaDtaPag := SNull;
  ADupPri.fltValDes := 0;
  ADupPri.intSeqCon := SNull;
  ADupPri.fltValJur := 0;
  ADupPri.fltValMul := 0;
  ADupPri.intRescai := 0;
  ADupPri.strMotEst := ADup.strMotEst;
  ADupPri.strHist01 := Concat(IIF(ADupPri.strHist01.HasValue,ADupPri.strHist01,''), '  ', strMsgEstorno);

  frwk.objDBManager.Flush;
  pGravaLogCtp(ADupPri,'ESTORNO CONTAS A PAGAR - ALTERAÇÃO [pEstornaDuplicataParcial]', strNomFrm);

  pGravaLogCtp(ADup,'ESTORNO CONTAS A PAGAR - EXCLUSÃO [pEstornaDuplicataParcial]', strNomFrm);
  frwk.objDBManager.Remove(ADup);
end;

{*********************************************}
{* REALIZA UM ESTORNO SIMPLES E JÁ GRAVA O   *}
{* LOGCTP                                    *}
{*17/06/2015*******************************AF*}
procedure TCadPagRepository.pEstornaDuplicataSimples(ADup: TCadPag; strNomFrm: String);
begin
  ADup.fltValOri := ADup.fltValPag - ADup.fltValJur - ADup.fltValMul - ADup.fltOutEnt - ADup.fltVendor + ADup.fltValDes;
  ADup.fltValDup := ADup.fltValOri;
  ADup.fltValJur := 0;
  ADup.fltValMul := 0;
  ADup.fltValDes := 0;
  ADup.fltValPag := 0;
  ADup.intRescai := 0;
  ADup.dtaDtaPag := SNull;
  ADup.dtaDtaBai := SNull;
  ADup.strEmpBai := SNull;
  ADup.strPorBai := SNull;

  If Not fTemDuplicataPosteriorBaixada(ADup) Then
    ADup.strHisBai := SNull;

  ADup.strDocBai := SNull;
  ADup.strCtaBai := SNull;
  ADup.intSeqBai := SNull;
  ADup.strOpeBai := SNull;
  ADup.intSeqCon := 0;
  ADup.intRcxCon := 0;
  ADup.fltDinhei := 0;
  ADup.fltChqAvi := 0;
  ADup.fltOrdPag := 0;
  ADup.fltRepChq := 0;
  ADup.strMotEst := ADup.strMotEst;

  pGravaLogCtp(ADup,'ESTORNO CONTAS A PAGAR [pEstornaDuplicataSimples]', strNomFrm);

  frwk.objDBManager.Flush;
end;

{*********************************************}
{* GRAVA O DEL_CADPAG/X                      *}
{*17/06/2015*******************************AF*}
procedure TCadPagRepository.pGravaDelCadPag(ADup: TCadPag; strForm: String);
  Var
    objDel: TDelCadPag;
Begin
  objDel := TDelCadPag.Create;

  TUtil.pClone(ADup, objDel);
  objDel.strNomFrm := strForm;
  TGravaDel.pGrava(objDel, frwk);

  if strForm = 'frmEstornoReceber' then
    pGravaLogCtp(ADup,'EXCLUSÃO CONTAS A PAGAR DE TARIFA [pEstornaContasAPagar]', strForm);
End;

{*********************************************}
{* RETORNA UMA DUPLICATA ESPECÍFICA A PARTIR *}
{* DA CHAVE                                  *}
{*17/06/2015*******************************AF*}
function TCadPagRepository.fRetDuplicata(strNumDup, strParcel: String; intSeqBai: Integer; strCodEmp, strCodFor, strSerie_: String): TCadPag;
  Var
    Filter: TFiltros;
begin
  Filter := TFiltros.Create;
  Filter.strDup := strNumDup;
  Filter.strPar := strParcel;
  Filter.strEmp := strCodEmp;
  Filter.strFor := strCodFor;

  Filter.strSer := strSerie_;
  If fEmptyStr(strSerie_) Then
    Filter.strSer.Opcao := opcIsNull;

  Filter.intSeqBai := intSeqBai;

  Result := fExecuta(Filter, True);
  FreeAndNil(Filter);
end;

{**************************}
{* GRAVA O CONTAS A PAGAR *}
{***********************AJ*}
procedure TCadPagRepository.pGravaCadPag(ADup: TCadPag; strDescri, strNomFrm: String);
begin
  Try

    If fEmptyStr(ADup.strNumDup) Then
      ADup.strNumDup := fRetSequencialCadPag;

    If fEmptyStr(ADup.strAutInc) Then
      ADup.strAutInc := fRetAutoIncrem(TUtil.fRetTableName(ADup), ADup.strCodEmp);

    ADup.strCodOpe := strLoginUsuarioLogado;

    frwk.objDBManager.Save(ADup);

    pGravaLogCtp(ADup, strDescri, strNomFrm);

  Except
    On E: Exception Do
      Raise Exception.Create('Erro ao gravar o contas a pagar.' + #13 + 'Erro: ' + E.Message);
  End;
end;

{ TFiltros }

constructor TFiltros.Create;
begin
  strDup := '';
  strPar := '';
  strEmp := '';
  strFor := '';
  strSer := '';
  intSeqBai := -1;
  intSeqCon := 0;
  strEmpBai := '';
  strAutInc := '';
  blnBaixado:= False;
  blnResCai := False;
end;

end.
