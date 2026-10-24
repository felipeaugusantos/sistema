unit untTBanCtrRepository;

interface

uses untTBanCtr, System.Generics.Collections, System.Generics.Defaults,
     System.SysUtils, untLogBan;

Type
  TBanCtrRepository = class(TLogBanRepository)
  Private
    FOrderCodempEspDocNumdupParcelSeqbai: IComparer<TBanCtr>;
    FListBanCtr: TList<TLogBan>;
    procedure pOrderCodempEspDocNumdupParcelSeqbai;
  Public
    function fAdd(strNumDup,
                  strParcel,
                  strEspDoc,
                  strCodEmp,
                  strCodCli,
                  strHist01,
                  strHist02: String;
                  intSeqBai: Integer;
                  fltValRec: Double;
                  fltValJur: Double = 0;
                  fltValDes: Double = 0;
                  fltValPri: Double = 0;
                  strEstorn: String = 'N'): Integer; reintroduce;
    function fGetList: TList<TLogBan>; override;
    procedure pMerge(arrListLogban: array of TList<TLogBan>); override;
    procedure pClear; override;
    Constructor Create;
    Destructor Destroy; Override;
    property orderCodempEspDocNumdupParcelSeqbai: IComparer<TBanCtr> Read FOrderCodempEspDocNumdupParcelSeqbai Write FOrderCodempEspDocNumdupParcelSeqbai;
  End;

implementation

uses untFuncoesSimples, Aurelius.Types.Nullable;

{ TBanCtrRepository }

constructor TBanCtrRepository.Create;
begin
  FListBanCtr := TList<TLogBan>.Create;
  pOrderCodempEspDocNumdupParcelSeqbai;
end;

destructor TBanCtrRepository.Destroy;
begin
  FreeAndNil(FListBanCtr);
  inherited;
end;

function TBanCtrRepository.fAdd(strNumDup,
                                strParcel,
                                strEspDoc,
                                strCodEmp,
                                strCodCli,
                                strHist01,
                                strHist02: String;
                                intSeqBai: Integer;
                                fltValRec: Double;
                                fltValJur: Double = 0;
                                fltValDes: Double = 0;
                                fltValPri: Double = 0;
                                strEstorn: String = 'N'): Integer;
  Var
    objBanCtr : TBanCtr;
begin
  objBanCtr := TBanCtr.Create;
  objBanCtr.strNumDup := strNumDup;
  objBanCtr.strParcel := strParcel;
  objBanCtr.strEspDoc := strEspDoc;

  If Not fEmptyStr(strCodEmp) Then
    objBanCtr.strCodEmp := strCodEmp
  Else
    objBanCtr.strCodEmp := SNULL;

  If Not fEmptyStr(strCodCli) Then
    objBanCtr.strCodCli := strCodCli
  Else
    objBanCtr.strCodCli := SNULL;

  objBanCtr.intSeqBai := intSeqBai;
  objBanCtr.strHist01 := strHist01;
  objBanCtr.strHist02 := strHist02;
  objBanCtr.fltValRec := fltValRec;
  objBanCtr.fltValJur := fltValJur;
  objBanCtr.fltValDes := fltValDes;
  objBanCtr.fltValPri := fltValPri;
  objBanCtr.strEstorn := strEstorn;

  Result := FListBanCtr.Add(objBanCtr);
end;

function TBanCtrRepository.fGetList: TList<TLogBan>;
begin
  Result := FListBanCtr;
end;

procedure TBanCtrRepository.pClear;
begin
  FListBanCtr.Clear;
end;

procedure TBanCtrRepository.pMerge(arrListLogban: array of TList<TLogBan>);
  Var
    intCnt1 : Integer;
    intCnt2 : Integer;
begin
  For intCnt1 := Low(arrListLogban) To High(arrListLogban) Do
  Begin
    For intCnt2 := 0 To arrListLogban[intCnt1].Count -1 Do
    Begin
      FListBanCtr.Add( arrListLogban[intCnt1].Items[intCnt2] );
    End;
  End;
end;

procedure TBanCtrRepository.pOrderCodempEspDocNumdupParcelSeqbai;
begin
  FOrderCodempEspDocNumdupParcelSeqbai := TComparer<TBanCtr>.Construct(TComparison<TBanCtr>(
                      function(const R, L: TBanCtr): integer
                      Begin
                        Result := CompareText(R.strCodEmp, L.strCodEmp);
                        If Result = 0 Then Result := CompareText(R.strEspDoc, L.strEspDoc);
                        If Result = 0 Then Result := CompareText(R.strNumDup, L.strNumDup);
                        If Result = 0 Then Result := CompareText(R.strParcel, L.strParcel);
                        If Result = 0 Then Result := R.intSeqBai.Value - L.intSeqBai.Value;
                      End));
end;

end.
