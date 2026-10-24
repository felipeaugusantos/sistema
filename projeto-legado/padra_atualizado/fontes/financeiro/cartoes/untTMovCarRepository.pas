unit untTMovCarRepository;

interface

uses untTMovCar, Aurelius.Criteria.Base, System.Generics.Collections, System.SysUtils,
  Aurelius.Criteria.Linq, untObjectManager, untFieldFiltros, Classes, untLogMca,
  Aurelius.Types.Nullable;

type

  TFiltros = class sealed
  Public
    intSeqCon: TFieldFiltros<Integer>;
    strCodEmp: TFieldFiltros<String>;
    strAutInc: TFieldFiltros<String>;
    strNumDup: TFieldFiltros<String>;
    strCodCli: TFieldFiltros<String>;
    dtaDtaCad: TFieldFiltros<TDate>;
    strEmpRcx: TFieldFiltros<String>;

    FOrderByDescParcela: Boolean;

    Constructor Create;
  End;

  TMovCarRepository = class
  Private

    blnCriouObj: Boolean;

    function fFiltrar<E: class>(Filter: TFiltros): TCriteria;
    function fExecuta(Filter: TFiltros): TMovCar;
    function fExecutaList(Filter: TFiltros): TList<TMovCar>;

  Public
    Constructor Create;
    Destructor Destroy; Override;

    function fGetMovCars(intSeqCon: Integer; strCodEmp: String): TList<TMovCar>; Overload;
    function fGetMovCars(strNumDup, strCodCli, strCodEmp: String; dtaDtaCad: TDate; AOrderByDescParcela : Boolean = False): TList<TMovCar>; Overload;
    function fGetMovCarsRcx(intSeqCon: Integer; strEmpRcx: String): TList<TMovCar>;
    function fRetCartao(strAutInc: String): TMovCar;

    function fGravar(AMovCar: TMovCar; strDescri, strForm: String): Boolean;
    function fAtualizar(AMovCar: TMovCar; strDescri, strNomFrm: String): Boolean;
    function fBaixaCartao(AMovCar: TMovCar; strDescri, strNomFrm: String): Boolean;
    procedure pRefresh(AMovCar: TMovCar);
    procedure pExcluir(AMovCar: TMovCar; strNomFrm: String);
    procedure pGravaDel(AMovCar: TMovCar);
    procedure pGravaLog(AMovCar: TMovCar; strDescri, strForm: String);
  End;

implementation

{ TFiltros }

uses untFuncoesSimples, untDelRepository, untUtilRepository, Forms, System.DateUtils;

constructor TFiltros.Create;
begin
  inherited;
  intSeqCon := 0;
  strCodEmp := '';
end;

{ TMovCarRepository }

constructor TMovCarRepository.Create;
begin
  blnCriouObj := False;
  frwk := fCriaObjManager(blnCriouObj);
end;

destructor TMovCarRepository.Destroy;
begin
  If blnCriouObj Then
    FreeAndNil(frwk);
  inherited;
end;

{function TMovCarRepository.fExecuta(Filter: TFiltros): TMovCar;
Var
  ACrit: TCriteria;
  lstCar: TList<TMovCar>;
begin
  ACrit := fFiltrar<TMovCar>(Filter);
  lstCar := ACrit.List<TMovCar>;
  If (Not Assigned(lstCar)) Or (lstCar.Count <= 0) Then
    Result := Nil
  Else
    Result := lstCar[0];
end;}

function TMovCarRepository.fExecuta(Filter: TFiltros): TMovCar;
  Var
    lstMca: TList<TMovCar>;
begin
  lstMca := fFiltrar<TMovCar>(Filter).List<TMovCar>;

  If (Not Assigned(lstMca)) Or (lstMca.Count <= 0) Then
    Result := Nil
  Else
    Result := lstMca[0];
end;

function TMovCarRepository.fExecutaList(Filter: TFiltros): TList<TMovCar>;
begin
  Result := fFiltrar<TMovCar>(Filter).List<TMovCar>;
end;

function TMovCarRepository.fFiltrar<E>(Filter: TFiltros): TCriteria;
Var
  ACriteria: TCriteria;
begin
  ACriteria := frwk.objDBManager.CreateCriteria<E>;

  If Filter.intSeqCon.Value > 0 Then
    ACriteria.Add(TLinq.Eq('FintSeqCon', Filter.intSeqCon));

  If Not fEmptyStr(Filter.strCodEmp.Value) Then
    ACriteria.Add(TLinq.Eq('FstrCodEmp', Filter.strCodEmp));

  If Not fEmptyStr(Filter.strEmpRcx.Value) Then
    ACriteria.Add(TLinq.Eq('FstrEmpRcx', Filter.strEmpRcx));

  If Not fEmptyStr(Filter.strAutInc) Then
    ACriteria.Add(TLinq.Eq('FstrAutoIncrem', Filter.strAutInc));

  If Not fEmptyStr(Filter.strNumDup.Value) Then
    ACriteria.Add(TLinq.Eq('FstrNumDup', Filter.strNumDup));

  If Not fEmptyStr(Filter.strCodCli.Value) Then
    ACriteria.Add(TLinq.Eq('FstrCodCli', Filter.strCodCli));

  If Filter.dtaDtaCad.Value > 0 Then
    ACriteria.Add(TLinq.Eq('FdteDtaCad', Filter.dtaDtaCad));

  If Filter.FOrderByDescParcela Then
    ACriteria.OrderItems.Add(TOrder.Asc('FstrParcel'));

  Result := ACriteria;
end;

function TMovCarRepository.fGetMovCars(strNumDup, strCodCli, strCodEmp: String;
  dtaDtaCad: TDate; AOrderByDescParcela : Boolean = False): TList<TMovCar>;
Var
  Filter: TFiltros;
begin
  Filter := TFiltros.Create;
  Try
    Filter.strNumDup := strNumDup;
    Filter.strCodEmp := strCodEmp;
    Filter.strCodCli := strCodCli;
    Filter.dtaDtaCad := dtaDtaCad;
    Filter.FOrderByDescParcela := AOrderByDescParcela;

    Result := fExecutaList(Filter);
  Finally
    FreeAndNil(Filter);
  End;
end;

function TMovCarRepository.fGetMovCars(intSeqCon: Integer;
  strCodEmp: String): TList<TMovCar>;
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

function TMovCarRepository.fGetMovCarsRcx(intSeqCon: Integer;
  strEmpRcx: String): TList<TMovCar>;
Var
  Filter: TFiltros;
begin
  Filter := TFiltros.Create;
  Try
    Filter.intSeqCon := intSeqCon;
    Filter.strEmpRcx := strEmpRcx;

    Result := fExecutaList(Filter);
  Finally
    FreeAndNil(Filter);
  End;
end;

procedure TMovCarRepository.pRefresh(AMovCar: TMovCar);
begin
  frwk.objDBManager.Refresh(AMovCar);
end;

function TMovCarRepository.fAtualizar(AMovCar: TMovCar; strDescri, strNomFrm: String): Boolean;
begin
  Try
    frwk.objDBManager.Update(AMovCar);
    untLogMca.GravaLogMca(AMovCar.strAutoIncrem, strDescri, strNomFrm);
    Result := True;
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create('Ocorreu um erro ao gravar o cartão. ' + #13 + 'Erro gerado: ' + E.Message);
    End;
  End;
end;

function TMovCarRepository.fBaixaCartao(AMovCar: TMovCar; strDescri, strNomFrm: String): Boolean;
begin
  Try
    AMovCar.dtaDtaBai := VS_Date;
    AMovCar.fltValAnt := AMovCar.fltValori;
    AMovCar.fltTaxAnt := AMovCar.fltValTax;
    AMovCar.fltValDup := 0;
    AMovCar.fltPerCar := (AMovCar.fltValSta.Value - AMovCar.fltValRec.Value) / AMovCar.fltValAnt.Value * 100;
    AMovCar.fltValtax := AMovCar.fltValSta.Value - AMovCar.fltValRec.Value;

    If AMovCar.strPorBtx.Value = '' Then
    Begin
      AMovCar.strPorBtx := SNull;
      AMovCar.strCtaBtx := SNull;
      AMovCar.strDocBtx := SNull;
      AMovCar.strForBtx := SNull;
    End;

    If AMovCar.strPorDeb.Value = '' Then
    Begin
      AMovCar.strCtaDeb := SNull;
      AMovCar.strPorDeb := SNull;
      AMovCar.strDocDeb := SNull;
    End;

    If AMovCar.strChaCon = '' Then
      AMovCar.strChaCon := SNull;
    If AMovCar.strEveDeb = '' Then
      AMovCar.strEveDeb := SNull;
    If AMovCar.strCtaAnt = '' Then
    Begin
      AMovCar.strCtaAnt := SNull;
      AMovCar.strDocAnt := SNull;
      AMovCar.fltAntTax := SNull;
    End;

    frwk.objDBManager.Flush;
    untLogMca.GravaLogMca(AMovCar.strAutoIncrem, strDescri, strNomFrm);
    Result := True;
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create('Ocorreu um erro ao baixar o cartão. ' + #13 + 'Erro gerado: ' + E.Message);
    End;
  End;
end;

procedure TMovCarRepository.pExcluir(AMovCar: TMovCar; strNomFrm: String);
begin
  Try
    pGravaDel(AMovCar);
    untLogMca.GravaLogMca(AMovCar.strAutoIncrem, 'EXCLUSÃO', strNomFrm);

    frwk.objDBManager.Remove(AMovCar);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

procedure TMovCarRepository.pGravaDel(AMovCar: TMovCar);
var
  objDel: TDelMovCar;
Begin
  objDel := TDelMovCar.Create;

  TUtil.pClone(AMovCar, objDel);
  TGravaDel.pGrava(objDel, frwk);
end;

function TMovCarRepository.fRetCartao(strAutInc: String): TMovCar;
  Var
    Filter: TFiltros;
begin
  Filter := TFiltros.Create;
  Filter.strAutInc := strAutInc;

  Result := fExecuta(Filter);
  FreeAndNil(Filter);
end;

procedure TMovCarRepository.pGravaLog(AMovCar: TMovCar; strDescri,
  strForm: String);
var
  objLog: TLogMca;
  blnCriouObj: Boolean;
  SDataExecutavel : TDateTime;
Begin
  blnCriouObj := False;

  FileAge(Application.ExeName, SDataExecutavel);

  frwk := fCriaObjManager(blnCriouObj);
  Try
    objLog := TLogMca.Create;
    TUtil.pClone(AMovCar, objLog);

    objLog.strAutoIncrem    := fRetAutoIncrem('LOGCTR', objLog.strCodEmp);
    objLog.dtaDtaLog        := VS_Date;
    objLog.dtaHorLog        := fTime();
    objLog.strOpeLog        := strLoginUsuarioLogado;
    objLog.strDescri        := strDescri;
    objLog.strNomFrm        := strForm;
    objLog.NomeExecutavel   := ExtractFileName(Application.ExeName);
    objLog.DataExecutavel   := SDataExecutavel;
    objLog.HoraExecutavel   := EncodeTime(HourOf(SDataExecutavel),
                                          MinuteOf(SDataExecutavel),
                                          SecondOf(SDataExecutavel),
                                          MilliSecondOf(SDataExecutavel));
    objLog.VersaoExecutavel := fRetornaVersao;

    frwk.objDBManager.Save(objLog);
  Finally
    If blnCriouObj Then
      FreeAndNil(frwk);
  End;
end;

function TMovCarRepository.fGravar(AMovCar: TMovCar; strDescri,
  strForm: String): Boolean;
begin
  Try
    frwk.objDBManager.Save(AMovCar);
    untLogMca.GravaLogMca(AMovCar.strAutoIncrem, strDescri, strForm);
    Result := True;
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create('Ocorreu um erro ao gravar o cartão. ' + #13 + 'Erro gerado: ' + E.Message);
    End;
  End;
end;

end.
