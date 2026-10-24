unit untGlasuritSQLServer;

interface

uses SysUtils, ADODB,  StrUtils, Uni, Forms, Classes,
  untFuncEspecificas, DB;

Type
  TTipoPreparoGlasurit = (tpsConcentrado, tpsDiluido);

Type
  TFormulaGlasuritSQLServer = class(TObject)
  private
    lstBases: TList;
    function GetBase(Index: Integer): TBaseAutomotiva;
    function GetCount: Integer;
  public
    constructor Create;
    destructor Destroy; Override;
    property Base[Index: Integer]: TBaseAutomotiva Read GetBase;
    property Count: Integer Read GetCount;
  end;

Type
  TGlasuritSQLServer = class(TObject)
    constructor Create(strIdCor: String; strLinha: String);
    destructor Destroy; override;

    function fCalculaFormulacao(fltVolume: Double;
      tpsTipoDePreparo: TTipoPreparoGlasurit): TFormulaGlasuritSQLServer;
  private
    strIdCor: String;
    strLinha: String;
    function fExecutaProcedureCalculoFormula(fltVolume: Double;
      tpsTipoDePreparo: TTipoPreparoGlasurit): TADOQuery;
    function fFormulaDiluida(tpsTipoPreparo: TTipoPreparoGlasurit): Boolean;
  end;

implementation

uses
  untGlasuritSqlServerFactory,untFuncoesSimples;

constructor TGlasuritSQLServer.Create(strIdCor: String; strLinha: String);
begin
  Self.strIdCor := strIdCor;
  Self.strLinha := strLinha;

end;

function TGlasuritSQLServer.fCalculaFormulacao(fltVolume: Double;
  tpsTipoDePreparo: TTipoPreparoGlasurit): TFormulaGlasuritSQLServer;
var
  qryFormula: TADOQuery;
  objBase: TBaseAutomotiva;
  strCampoQtd: String;
begin
   Result := Nil;

  Try
    Try
      qryFormula := fExecutaProcedureCalculoFormula(fltVolume, tpsTipoDePreparo);

      if Not Assigned(qryFormula) then
      Begin
        Result := Nil;
        Exit;
      End;

      Result := TFormulaGlasuritSQLServer.Create;

      If Pos(strLinha,'55_90_35_30_') <= 0 Then
        tpsTipoDePreparo := tpsConcentrado;

      If fFormulaDiluida(tpsTipoDePreparo) Then
        strCampoQtd := 'QT_ITEM_PPU_GRAMA'
      Else
        strCampoQtd := 'QT_ITEM_GRAMA';

      While (Not qryFormula.Eof) Do
      Begin
        If (qryFormula.FieldByName(strCampoQtd).AsFloat > 0)                 And
           (qryFormula.FieldByName('DS_ITEM_COMERCIAL').AsString <> 'TOTAL') Then
        Begin
          objBase := TBaseAutomotiva.Create(Nil);
          objBase.strCodBas := Trim(qryFormula.FieldByName('DS_CODIGO_ITEM').AsString);
          objBase.strLinBas := strLinha;
          objBase.fltEmbala := qryFormula.FieldByName('VL_VOLUME').AsFloat;
          objBase.fltPesEsp := qryFormula.FieldByName('VL_PESO_ESPECIFICO').AsFloat;

          If fFormulaDiluida(tpsTipoDePreparo) Then
            objBase.fltQtdDil := qryFormula.FieldByName(strCampoQtd).AsFloat
          Else
            objBase.fltQtdCon := qryFormula.FieldByName(strCampoQtd).AsFloat;

          If (fFormulaDiluida(tpsTipoDePreparo)) And (fEmptyStr(objBase.strCodBas)) Then
          Begin
            objBase.strCodBas := 'TH 2255';
          End;

          Result.lstBases.Add(objBase);
        End;

        qryFormula.Next;
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
//    if Assigned(qryFormula) then FreeAndNil(qryFormula);
//    if Assigned(objBase) then FreeAndNil(objBase);
  End;
end;

function TGlasuritSQLServer.fExecutaProcedureCalculoFormula(fltVolume: Double;
  tpsTipoDePreparo: TTipoPreparoGlasurit): TADOQuery;
var
  blnFgFormulaPPU: Boolean;
  blnFgResina325: Boolean;
begin
  blnFgFormulaPPU := IIF(Pos(strLinha,'55_90_35_30_') > 0,IIF(fFormulaDiluida(tpsTipoDePreparo),True,False),False); //IIF(fFormulaDiluida(tpsTipoDePreparo), True, False);
  blnFgResina325 := False;
  Result := TGlasuritSqlServerFactory.GetProcedureCalculoFormula(strIdCor, blnFgFormulaPPU, blnFgResina325, fltVolume * 1000);
end;

function TGlasuritSQLServer.fFormulaDiluida(tpsTipoPreparo: TTipoPreparoGlasurit): Boolean;
begin
  Result := (tpsTipoPreparo = tpsDiluido)
end;

destructor TGlasuritSQLServer.Destroy;
begin
  inherited;
end;

{ TFormulaGlasuritSQLServer }

constructor TFormulaGlasuritSQLServer.Create;
begin
  lstBases := TList.Create;
end;

destructor TFormulaGlasuritSQLServer.Destroy;
  Var
    obj: TObject;
    ptn: Pointer;
begin
  For ptn In lstBases Do
  Begin
    obj := TObject(ptn);
    FreeAndNil(obj);
  End;
  
  lstBases.Clear;
  FreeAndNil(lstBases);
  inherited;
end;

function TFormulaGlasuritSQLServer.GetBase(Index: Integer): TBaseAutomotiva;
begin
  Result := TBaseAutomotiva(lstBases[Index]);
end;

function TFormulaGlasuritSQLServer.GetCount: Integer;
begin
  Result := lstBases.Count;
end;

end.
