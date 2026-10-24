{******************************************}
{* REPOSITORY DO CADCHQ.                  *}
{* LOCAL DAS FUNCOES DO CADCHQ QUE TEM    *}
{* INTERAÇÃO COM A CAMADA DE PERSISTÊNCIA *}
{*23/07/2015****************************AF*}
unit untTCadChqRepository;

interface

uses untTCadChq, Aurelius.Criteria.Base, System.Generics.Collections, System.SysUtils,
  Aurelius.Criteria.Linq, untObjectManager, untFieldFiltros, Classes, Aurelius.Types.Nullable;

Type
  {**********************************************}
  {* CLASSE RESPONSÁVEL PELOS FILTROS QUE SERÃO *}
  {* EXECUTADOS NA BUSCA DOS DADOS              *}
  {*23/07/2015********************************AF*}
  TFiltros = class sealed
  Public
    intSeqRCH: TFieldFiltros<Integer>;
    strEmpRCH: TFieldFiltros<String>;
    strCodBco: TFieldFiltros<String>;
    strNumAge: TFieldFiltros<String>;
    strConCor: TFieldFiltros<String>;
    strNumChq: TFieldFiltros<String>;
    intSeqTrf: TFieldFiltros<Integer>;
    intSeqCon: TFieldFiltros<Integer>;
    strCodEmp: TFieldFiltros<String>;
    dteDtaCus: TFieldFiltros<TDate>;
    dteDtaDep: TFieldFiltros<TDate>;

    Constructor Create;
  End;

  TCadChqRepository = class
  Private

    blnCriouObj: Boolean;

    function fFiltrar<E: class>(Filter: TFiltros): TCriteria;
    function fExecuta(Filter: TFiltros): TCadChq;
    function fExecutaList(Filter: TFiltros): TList<TCadChq>;

  Public

    procedure pGravaLog(AChq: TCadChq; strDescri: String); Overload;
    procedure pGravaLog(strCodBco, strNumAge, strConCor, strNumChq, strDescri: String); Overload;
    procedure pGravaLog(intSeqTrf: Integer; strCodEmp, strDescri: String); Overload;
    procedure pEstornaRepasseCheques(intSeqRCH: Integer; strEmpRCH: String);

    function fGetCheque(strCodBco, strNumAge, strConCor, strNumChq: String): TCadChq;
    function fGetCheques(intSeqCon: Integer; strCodEmp: String): TList<TCadChq>;
    function fRetornaChequesTransferidos(intSeqTrf: Integer; strCodEmp: String): TList<TCadChq>;
    function fRetornaChequesRepassados(intSeqRCH: Integer; strEmpRCH: String): TList<TCadChq>;
    function fRetornaChequesEmCustodia(): TList<TCadChq>;

    procedure pGravar(ACadChq: TCadChq);
    procedure pAtualizar(ACadChq: TCadChq);
    procedure pExcluir(ACadChq: TCadChq);
    procedure pGravaDel(ACadChq: TCadChq);

    Constructor Create;
    Destructor Destroy; Override;
  End;

implementation

{ TCadChqRepository }

uses untFuncoesSimples, untUtilRepository, untDelRepository, Forms, System.DateUtils;

constructor TCadChqRepository.Create;
begin
  blnCriouObj := False;
  frwk := fCriaObjManager(blnCriouObj);
end;

destructor TCadChqRepository.Destroy;
begin
  If blnCriouObj Then FreeAndNil(frwk);
  inherited;
end;

{*********************************************}
{* EXECUÇÃO DE UM SELECT QUE RETORNA APENAS  *}
{* UM OBJETO(CASO RETORNE MAIS DE UM ELE     *}
{* PEGA O PRIMEIRO REGISTRO)                 *}
{*23/07/2015*******************************AF*}
function TCadChqRepository.fExecuta(Filter: TFiltros): TCadChq;
Var
    lstChq: TList<TCadChq>;
begin
  lstChq := fFiltrar<TCadChq>(Filter).List<TCadChq>;
  If (Not Assigned(lstChq)) Or (lstChq.Count <= 0) Then
    Result := Nil
  Else Result := lstChq[0];
end;

{*********************************************}
{* EXECUÇÃO DE UM SELECT QUE RETORNA UMA     *}
{* LISTA DE OBJETOS                          *}
{*23/07/2015*******************************AF*}
function TCadChqRepository.fExecutaList(Filter: TFiltros): TList<TCadChq>;
begin
  Result := fFiltrar<TCadChq>(Filter).List<TCadChq>;
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
{*23/07/2015************************************************AF*}
function TCadChqRepository.fFiltrar<E>(Filter: TFiltros): TCriteria;
  Var
    ACriteria: TCriteria;
begin
  ACriteria := frwk.objDBManager.CreateCriteria<E>;


  If Not fEmptyStr(Filter.strCodBco) Then
  Begin
    Case Filter.strCodBco.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FCHQ_CODBCO'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FCHQ_CODBCO'));
      Else ACriteria.Add(TLinq.Eq('FCHQ_CODBCO', Filter.strCodBco));
    End;
  End;

  If Not fEmptyStr(Filter.strNumAge) Then
  Begin
    Case Filter.strNumAge.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FCHQ_NUMAGE'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FCHQ_NUMAGE'));
      Else ACriteria.Add(TLinq.Eq('FCHQ_NUMAGE', Filter.strNumAge));
    End;
  End;

  If Not fEmptyStr(Filter.strConCor) Then
  Begin
    Case Filter.strConCor.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FCHQ_CONCOR'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FCHQ_CONCOR'));
      Else ACriteria.Add(TLinq.Eq('FCHQ_CONCOR', Filter.strConCor));
    End;
  End;

  If Not fEmptyStr(Filter.strNumChq) Then
  Begin
    Case Filter.strNumChq.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FCHQ_NUMCHQ'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FCHQ_NUMCHQ'));
      Else ACriteria.Add(TLinq.Eq('FCHQ_NUMCHQ', Filter.strNumChq));
    End;
  End;

  If Not fEmptyStr(Filter.strEmpRCH) Then
  Begin
    Case Filter.strEmpRCH.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FCHQ_EMPRCH'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FCHQ_EMPRCH'));
      Else ACriteria.Add(TLinq.Eq('FCHQ_EMPRCH', Filter.strEmpRCH));
    End;
  End;

  If (Filter.intSeqRCH.Value > 0) Then
  Begin
    Case Filter.intSeqRCH.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FCHQ_SEQRCH'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FCHQ_SEQRCH'));
      opcDiferente: ACriteria.Add(TLinq.Lt('FCHQ_SEQRCH', Filter.intSeqRCH) Or
                                  TLinq.Gt('FCHQ_SEQRCH', Filter.intSeqRCH));
      Else ACriteria.Add(TLinq.Eq('FCHQ_SEQRCH', Filter.intSeqRCH));
    End;
  End;

  If (Filter.intSeqTrf.Value > 0) Then
  Begin
    Case Filter.intSeqTrf.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FCHQ_SEQTRF'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FCHQ_SEQTRF'));
      opcDiferente: ACriteria.Add(TLinq.Lt('FCHQ_SEQTRF', Filter.intSeqTrf) Or
                                  TLinq.Gt('FCHQ_SEQTRF', Filter.intSeqTrf));
      Else ACriteria.Add(TLinq.Eq('FCHQ_SEQTRF', Filter.intSeqTrf));
    End;
  End;

  If (Filter.intSeqCon.Value > 0) Then
  Begin
    Case Filter.intSeqCon.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FCHQ_SEQCON'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FCHQ_SEQCON'));
      opcDiferente: ACriteria.Add(TLinq.Lt('FCHQ_SEQCON', Filter.intSeqCon) Or
                                  TLinq.Gt('FCHQ_SEQCON', Filter.intSeqCon));
      Else ACriteria.Add(TLinq.Eq('FCHQ_SEQCON', Filter.intSeqCon));
    End;
  End;

  If Not fEmptyStr(Filter.strCodEmp) Then
  Begin
    Case Filter.strCodEmp.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FCHQ_CODEMP'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FCHQ_CODEMP'));
      Else ACriteria.Add(TLinq.Eq('FCHQ_CODEMP', Filter.strCodEmp));
    End;
  End;

  If (Filter.dteDtaCus.Value > 0) Or (Filter.dteDtaCus.Opcao <> opcNada) Then
  Begin
    Case Filter.dteDtaCus.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FCHQ_DTACUS'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FCHQ_DTACUS'));
      Else ACriteria.Add(TLinq.Eq('FCHQ_DTACUS', Filter.dteDtaCus));
    End;
  End;

  If (Filter.dteDtaDep.Value > 0) Or (Filter.dteDtaDep.Opcao <> opcNada) Then
  Begin
    Case Filter.dteDtaDep.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FCHQ_DTADEP'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FCHQ_DTADEP'));
      Else ACriteria.Add(TLinq.Eq('FCHQ_DTADEP', Filter.dteDtaDep));
    End;
  End;

  Result := ACriteria;
end;

function TCadChqRepository.fGetCheques(intSeqCon: Integer;
  strCodEmp: String): TList<TCadChq>;
Var
  Filter: TFiltros;
begin
  Filter := TFiltros.Create;
  Try
    Filter.intSeqCon := intSeqCon;
    Filter.strCodEmp := strCodEmp;

    Result := fExecutaList(Filter);
  Finally
    FreeAndNil(Filter);
  End;
end;

function TCadChqRepository.fGetCheque(strCodBco, strNumAge, strConCor, strNumChq: String): TCadChq;
  Var
    Filter: TFiltros;
begin
  Filter := TFiltros.Create;
  Filter.strCodBco := strCodBco;
  Filter.strNumAge := strNumAge;
  Filter.strConCor := strConCor;
  Filter.strNumChq := strNumChq;

  Result := fExecuta(Filter);
  FreeAndNil(Filter);
end;

function TCadChqRepository.fRetornaChequesEmCustodia: TList<TCadChq>;
  Var
    Filter: TFiltros;
begin
  Filter := TFiltros.Create;
  Try
    Filter.dteDtaCus.Opcao := opcIsNotNull;
    Filter.dteDtaDep.Opcao := opcIsNull;

    Result := fExecutaList(Filter);
  Finally
    FreeAndNil(Filter);
  End;
end;

function TCadChqRepository.fRetornaChequesRepassados(intSeqRCH: Integer; strEmpRCH: String): TList<TCadChq>;
  Var
    Filter: TFiltros;
begin
  Filter := TFiltros.Create;
  Filter.intSeqRCH  := intSeqRCH;
  Filter.strEmpRCH  := strEmpRCH;

  Result := fExecutaList(Filter);
  FreeAndNil(Filter);
end;

function TCadChqRepository.fRetornaChequesTransferidos(intSeqTrf: Integer; strCodEmp: String): TList<TCadChq>;
  Var
    Filter: TFiltros;
begin
  Filter := TFiltros.Create;
  Filter.intSeqTrf  := intSeqTrf;
  Filter.strCodEmp  := strCodEmp;

  Result := fExecutaList(Filter);
  FreeAndNil(Filter);
end;

procedure TCadChqRepository.pAtualizar(ACadChq: TCadChq);
begin
  frwk.objDBManager.Update(ACadChq);
end;

procedure TCadChqRepository.pEstornaRepasseCheques(intSeqRCH: Integer; strEmpRCH: String);
  Var
    lstChq: TList<TCadChq>;
    objChq: TCadChq;
begin
  lstChq := fRetornaChequesRepassados(intSeqRCH, strEmpRCH);

  Try
    For objChq In lstChq Do
    Begin

      pGravaLog(objChq, 'ESTORNO DE REPASSE (TCadChqRepository.pEstornaRepasseCheques)');

      If objChq.CHQ_DTADP2.IsNull Then objChq.CHQ_DTADEP := SNull;
      objChq.CHQ_DTADP2 := SNull;
      objChq.CHQ_CODCTA := SNull;
      objChq.CHQ_CODPOR := SNULL;
      objChq.CHQ_CTADEP := SNULL;
      objChq.CHQ_DOCDEP := SNULL;
      objChq.CHQ_FORREP := SNULL;
      objChq.CHQ_DTAREP := SNULL;
      objChq.CHQ_CTADEP := SNULL;
      objChq.CHQ_DOCDEP := SNULL;
      objChq.CHQ_PORDEB := SNULL;
      objChq.CHQ_CTADEB := SNULL;
      objChq.CHQ_OBSREP := SNULL;

      frwk.objDBManager.Flush;
    End;

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;

end;

procedure TCadChqRepository.pExcluir(ACadChq: TCadChq);
begin
  frwk.objDBManager.Remove(ACadChq);
end;

procedure TCadChqRepository.pGravaDel(ACadChq: TCadChq);
var
  objDel: TDelCadChq;
Begin
  objDel := TDelCadChq.Create;

  TUtil.pClone(ACadChq, objDel);
  TGravaDel.pGrava(objDel, frwk);
end;

procedure TCadChqRepository.pGravaLog(intSeqTrf: Integer; strCodEmp, strDescri: String);
  Var
    lstChq: TList<TCadChq>;
    intCon: Integer;
begin

  Try
    lstChq := fRetornaChequesTransferidos(intSeqTrf, strCodEmp);

    If Assigned(lstChq) Then
    Begin
      For intCon := 0 To lstChq.Count -1 Do
        pGravaLog(lstChq[intCon], strDescri);
    End;

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;

end;

procedure TCadChqRepository.pGravar(ACadChq: TCadChq);
begin
  frwk.objDBManager.Save(ACadChq);
end;

procedure TCadChqRepository.pGravaLog(strCodBco, strNumAge, strConCor, strNumChq, strDescri: String);
  Var
    objChq: TCadChq;
begin

  Try
    objChq := fGetCheque(strCodBco, strNumAge, strConCor, strNumChq);
    frwk.objDBManager.Refresh(ObjChq);
    if Assigned(objChq) then
      pGravaLog(objChq, strDescri);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;

end;

procedure TCadChqRepository.pGravaLog(AChq: TCadChq; strDescri: String);
  Var
    objLog: TLogChq;
    SDataExecutavel : TDateTime;
Begin
  FileAge(Application.ExeName, SDataExecutavel);

  objLog := TLogChq.Create;
  TUtil.pClone(AChq, objLog);

  objLog.AUTOINCREM       := fRetAutoIncrem('LOGCHQ', objLog.CHQ_CODEMP);
  objLog.CHQ_DTALOG       := VS_Date;
  objLog.CHQ_HORLOG       := fTime();
  objLog.CHQ_OPELOG       := strLoginUsuarioLogado;
  objLog.CHQ_NOMTAB       := TUtil.fRetTableName(AChq);
  objLog.CHQ_HISLOG       := strDescri;
  objLog.NomeExecutavel   := ExtractFileName(Application.ExeName);
  objLog.DataExecutavel   := SDataExecutavel;
  objLog.HoraExecutavel   := EncodeTime(HourOf(SDataExecutavel),
                                        MinuteOf(SDataExecutavel),
                                        SecondOf(SDataExecutavel),
                                        MilliSecondOf(SDataExecutavel));
  objLog.VersaoExecutavel := fRetornaVersao;

  frwk.objDBManager.Save(objLog);

End;

{ TFiltros }

constructor TFiltros.Create;
begin
  intSeqRCH := 0;
  strEmpRCH := '';
  strCodBco := '';
  strNumAge := '';
  strConCor := '';
  strNumChq := '';
  intSeqTrf := 0;
  intSeqCon := 0;
  strCodEmp := '';
end;

end.
