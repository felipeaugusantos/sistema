unit untTBanCtpRepository;

interface

uses untTBanCtp, SysUtils, System.Generics.Collections, System.Generics.Defaults,
     untLogBan;

type
  TBanCtpRepository = class(TLogBanRepository)
  Private
    FListBanCtp: TList<TLogBan>;
    FListBanCtpClone: TList<TLogBan>;
    FOrderCodempNumdupSerieParcelSeqbai: IComparer<TBanCtp>;
    procedure pOrderCodempNumdupSerieParcelSeqbai;
  Public
    function fAdd(strNumDup,
                  strParcel,
                  strSerie_,
                  strCodEmp,
                  strCodFor,
                  strHist01,
                  strHist02,
                  strCodCta,
                  strEmpCta: String;
                  intSeqBai: Integer;
                  fltValPag,
                  fltDinhei,
                  fltChqEmi,
                  fltChqRep,
                  fltOrdPag: Double;
                  fltValJur: Double = 0;
                  fltValMul: Double = 0;
                  fltValDes: Double = 0;
                  fltValPri: Double = 0): Integer; reintroduce;
    function fGetList: TList<TLogBan>; override;
    function fGetListClone: TList<TLogBan>;
    procedure pMerge(arrListLogban: Array Of TList<TLogBan>); override;
    procedure pClear; override;
    Constructor Create;
    Destructor Destroy; Override;
    property orderCodempNumdupSerieParcelSeqbai: IComparer<TBanCtp> read FOrderCodempNumdupSerieParcelSeqbai write FOrderCodempNumdupSerieParcelSeqbai;
  End;

implementation

uses untUtilRepository, untFuncoesSimples, Aurelius.Types.Nullable;

{ TBanCtpRepository }

constructor TBanCtpRepository.Create;
begin
  FListBanCtp := TList<TLogBan>.Create;
  FListBanCtpClone := TList<TLogBan>.Create;
  pOrderCodempNumdupSerieParcelSeqbai;
end;

destructor TBanCtpRepository.Destroy;
begin
  FreeAndNil(FListBanCtp);
  FreeAndNil(FListBanCtpClone);
  inherited;
end;

function TBanCtpRepository.fAdd(strNumDup,
                                strParcel,
                                strSerie_,
                                strCodEmp,
                                strCodFor,
                                strHist01,
                                strHist02,
                                strCodCta,
                                strEmpCta: String;
                                intSeqBai: Integer;
                                fltValPag,
                                fltDinhei,
                                fltChqEmi,
                                fltChqRep,
                                fltOrdPag: Double;
                                fltValJur: Double = 0;
                                fltValMul: Double = 0;
                                fltValDes: Double = 0;
                                fltValPri: Double = 0): Integer;
  Var
    objBanCtp : TBanCtp;
begin
  objBanCtp := TBanCtp.Create;
  objBanCtp.strNumDup := strNumDup;
  objBanCtp.strParcel := strParcel;
  objBanCtp.strSerie_ := strSerie_;

  If Not fEmptyStr(strCodEmp) Then
    objBanCtp.strCodEmp := strCodEmp
  Else
    objBanCtp.strCodEmp := SNULL;

  If Not fEmptyStr(strCodFor) Then
    objBanCtp.strCodFor := strCodFor
  Else
    objBanCtp.strCodFor := SNULL;

  If Not fEmptyStr(strCodCta) Then
    objBanCtp.strCodCta := strCodCta
  Else
    objBanCtp.strCodCta := SNULL;

  If Not fEmptyStr(strEmpCta) Then
    objBanCtp.strEmpCta := strEmpCta
  Else
    objBanCtp.strEmpCta := SNULL;

  objBanCtp.intSeqBai := intSeqBai;
  objBanCtp.strHist01 := strHist01;
  objBanCtp.strHist02 := strHist02;
  objBanCtp.fltValPag := fltValPag;
  objBanCtp.fltDinhei := fltDinhei;
  objBanCtp.fltChqEmi := fltChqEmi;
  objBanCtp.fltChqRep := fltChqRep;
  objBanCtp.fltOrdPag := fltOrdPag;
  objBanCtp.fltValJur := fltValJur;
  objBanCtp.fltValMul := fltValMul;
  objBanCtp.fltValDes := fltValDes;
  objBanCtp.fltValPri := fltValPri;

  Result := FListBanCtp.Add(objBanCtp);
end;

function TBanCtpRepository.fGetList: TList<TLogBan>;
begin
  Result := FListBanCtp;
end;

function TBanCtpRepository.fGetListClone: TList<TLogBan>;
  Var
    objBanCtp : TBanCtp;
    intCnt : Integer;
begin
  FListBanCtpClone.Clear;

  For intCnt := 0 To FListBanCtp.Count -1 Do
  Begin
    objBanCtp := TBanCtp.Create;
    TUtil.pClone(FListBanCtp[intCnt], objBanCtp);
    FListBanCtpClone.Add( objBanCtp );
  End;

  Result := FListBanCtpClone;
end;

procedure TBanCtpRepository.pMerge(arrListLogban: array of TList<TLogBan>);
  Var
    intCnt1 : Integer;
    intCnt2 : Integer;
begin
  For intCnt1 := Low(arrListLogban) To High(arrListLogban) Do
  Begin
    For intCnt2 := 0 To arrListLogban[intCnt1].Count -1 Do
    Begin
      FListBanCtp.Add( arrListLogban[intCnt1].Items[intCnt2] );
    End;
  End;
end;

procedure TBanCtpRepository.pOrderCodempNumdupSerieParcelSeqbai;
begin
  FOrderCodempNumdupSerieParcelSeqbai := TComparer<TBanCtp>.Construct(TComparison<TBanCtp>(
                      function(const R, L: TBanCtp): integer
                      Begin
                        Result := CompareText(R.strCodEmp, L.strCodEmp);
                        If Result = 0 Then Result := CompareText(R.strNumDup, L.strNumDup);
                        If Result = 0 Then Result := CompareText(R.strSerie_, L.strSerie_);
                        If Result = 0 Then Result := CompareText(R.strParcel, L.strParcel);
                        If Result = 0 Then Result := R.intSeqBai.Value - L.intSeqBai.Value;
                      End));
end;

procedure TBanCtpRepository.pClear;
begin
  FListBanCtp.Clear;
end;

end.
