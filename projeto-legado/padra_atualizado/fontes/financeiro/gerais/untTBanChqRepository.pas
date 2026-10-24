unit untTBanChqRepository;

interface

uses untTBanChq, SysUtils, System.Generics.Collections, System.Generics.Defaults,
     untLogBan, Aurelius.Criteria.Base, untObjectManager, untFieldFiltros, Aurelius.Criteria.Linq;

type
  TBanChqRepository = class(TLogBanRepository)
  Private
    FListBanChq: TList<TLogBan>;
    FOrderCodempAgenciaContaNumerocheque: IComparer<TBanChq>;
    procedure pOrderCodempAgenciaContaNumerocheque;

    function fFiltrar<E: class>(Filter: TFiltros): TCriteria;
    function fExecuta(Filter: TFiltros): TBanChq;

  Public
    function fAdd(strCodBco,
                  strNumAge,
                  strConCor,
                  strNumChq,
                  strCodCli,
                  strNomEmi,
                  strHist01,
                  strHist02,
                  strCodEmp,
                  strCodFor: String;
                  fltValChq: Double): Integer; reintroduce;
    function fGetList: TList<TLogBan>; override;
    function fGetBanChq(strSeqLan : String) : TBanChq;
    procedure pMerge(arrListLogban: array of TList<TLogBan>); override;
    procedure pClear; override;
    Constructor Create;
    Destructor Destroy; Override;
    property orderCodempAgenciaContaNumerocheque: IComparer<TBanChq> read FOrderCodempAgenciaContaNumerocheque write FOrderCodempAgenciaContaNumerocheque;
  End;

implementation

uses untFuncoesSimples, Aurelius.Types.Nullable;

{ TBanChqRepository }

constructor TBanChqRepository.Create;
begin
  FListBanChq := TList<TLogBan>.Create;
  pOrderCodempAgenciaContaNumerocheque;
end;

destructor TBanChqRepository.Destroy;
begin
  FreeAndNil(FListBanChq);
  inherited;
end;

function TBanChqRepository.fAdd(strCodBco,
                                strNumAge,
                                strConCor,
                                strNumChq,
                                strCodCli,
                                strNomEmi,
                                strHist01,
                                strHist02,
                                strCodEmp,
                                strCodFor: String;
                                fltValChq: Double): Integer;
  Var
    objBanChq : TBanChq;
begin
  objBanChq := TBanChq.Create;
  objBanChq.strNumAge := strNumAge;
  objBanChq.strConCor := strConCor;
  objBanChq.strNumChq := strNumChq;
  objBanChq.fltValChq := fltValChq;
  objBanChq.strNomEmi := strNomEmi;
  objBanChq.strHist01 := strHist01;
  objBanChq.strHist02 := strHist02;

  If Not fEmptyStr(strCodCli) Then
    objBanChq.strCodCli := strCodCli
  Else
    objBanChq.strCodCli := SNULL;

  If Not fEmptyStr(strCodBco) Then
    objBanChq.strCodBco := strCodBco
  Else
    objBanChq.strCodBco := SNULL;

  If Not fEmptyStr(strCodEmp) Then
    objBanChq.strCodEmp := strCodEmp
  Else
    objBanChq.strCodEmp := SNULL;

  If Not fEmptyStr(strCodFor) Then
    objBanChq.strCodFor := strCodFor
  Else
    objBanChq.strCodFor := SNULL;

  Result := FListBanChq.Add(objBanChq);
end;

function TBanChqRepository.fExecuta(Filter: TFiltros): TBanChq;
Var
  lstBanChq: TList<TBanChq>;
begin
  lstBanChq := fFiltrar<TBanChq>(Filter).List<TBanChq>;

  If (Not Assigned(lstBanChq)) Or (lstBanChq.Count <= 0) Then
    Result := Nil
  Else
    Result := lstBanChq[0];
end;

function TBanChqRepository.fFiltrar<E>(Filter: TFiltros): TCriteria;
Var
  ACriteria: TCriteria;
begin

  ACriteria := frwk.objDBManager.CreateCriteria<E>;

  If Not fEmptyStr(Filter.strSeqLan.Value) Then
  Begin

    Case Filter.strSeqLan.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FCTB_SEQLAN'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FCTB_SEQLAN'));
    Else
      ACriteria.Add(TLinq.Eq('FCTB_SEQLAN', Filter.strSeqLan));

    End;
  End;

  Result := ACriteria;

end;

function TBanChqRepository.fGetBanChq(strSeqLan : String) : TBanChq;
Var
  Filter: TFiltros;
begin
  Filter := TFiltros.Create;
  Filter.strSeqLan := strSeqLan;

  Result := fExecuta(Filter);
  FreeAndNil(Filter);
end;

function TBanChqRepository.fGetList: TList<TLogBan>;
begin
  Result := FListBanChq;
end;

procedure TBanChqRepository.pMerge(arrListLogban: array of TList<TLogBan>);
  Var
    intCnt1 : Integer;
    intCnt2 : Integer;
begin
  For intCnt1 := Low(arrListLogban) To High(arrListLogban) Do
  Begin
    For intCnt2 := 0 To arrListLogban[intCnt1].Count -1 Do
    Begin
      FListBanChq.Insert(0, arrListLogban[intCnt1].Items[intCnt2]);
      //FListBanChq.Add( arrListLogban[intCnt1].Items[intCnt2] );
    End;
  End;
end;

procedure TBanChqRepository.pOrderCodempAgenciaContaNumerocheque;
begin
  FOrderCodempAgenciaContaNumerocheque := TComparer<TBanChq>.Construct(TComparison<TBanChq>(
                      function(const R, L: TBanChq): integer
                      Begin
                        Result := CompareText(R.strCodEmp, L.strCodEmp);
                        If Result = 0 Then Result := CompareText(R.strNumAge, L.strNumAge);
                        If Result = 0 Then Result := CompareText(R.strConCor, L.strConCor);
                        If Result = 0 Then Result := CompareText(R.strNumChq, L.strNumChq);
                      End));
end;

procedure TBanChqRepository.pClear;
begin
  FListBanChq.Clear;
end;

end.
