unit untSalcomixSQLServer;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
  Shared.Core, untGTinForTipos,
{$ELSE}
  Forms, Controls, ADODB, untFuncoesSimples,
{$ENDIF}
  SysUtils, StrUtils, Uni, Classes, untFuncEspecificas, DB;

Type
  TTipoPreparoSalcomix = (tpsConcentrado, tpsDiluido, tpsResina325);

Type
  TFormulaSalcomixSQLServer = class(TObject)
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
  TSalcomixSQLServer = class(TObject)
    constructor Create(strIdCor: String; strLinha: String);
    destructor Destroy; override;

    function fCalculaFormulacao(fltVolume: Double;
      tpsTipoDePreparo: TTipoPreparoSalcomix): TFormulaSalcomixSQLServer;
  private
    strIdCor: String;
    strLinha: String;
    function fExecutaProcedureCalculoFormula(fltVolume: Double;
      tpsTipoDePreparo: TTipoPreparoSalcomix): TADOQuery;
    function fFormulaDiluida(tpsTipoPreparo: TTipoPreparoSalcomix): Boolean;
   // function fFormulaResina325(tpsTipoPreparo: TTipoPreparoSalcomix): Boolean;
  end;



implementation

uses
  untSalcomixSqlServerFactory;

constructor TSalcomixSQLServer.Create(strIdCor: String; strLinha: String);
begin
  Self.strIdCor := strIdCor;
  Self.strLinha := strLinha;
end;

function TSalcomixSQLServer.fCalculaFormulacao(fltVolume: Double;
  tpsTipoDePreparo: TTipoPreparoSalcomix): TFormulaSalcomixSQLServer;
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
        Exit;
      End;

      Result := TFormulaSalcomixSQLServer.Create;

      If Pos('S850',strLinha) <= 0 Then
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
          objBase.strCodBas := qryFormula.FieldByName('DS_CODIGO_ITEM').AsString;
          objBase.strLinBas := strLinha;
          objBase.fltEmbala := qryFormula.FieldByName('VL_VOLUME').AsFloat;
          objBase.fltPesEsp := qryFormula.FieldByName('VL_PESO_ESPECIFICO').AsFloat;

          If fFormulaDiluida(tpsTipoDePreparo) Then
            objBase.fltQtdDil := qryFormula.FieldByName(strCampoQtd).AsFloat
          Else
            objBase.fltQtdCon := qryFormula.FieldByName(strCampoQtd).AsFloat;

          If (fFormulaDiluida(tpsTipoDePreparo)) And (fEmptyStr(objBase.strCodBas)) Then
          Begin
            objBase.strCodBas := 'THRAPID';
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

function TSalcomixSQLServer.fExecutaProcedureCalculoFormula(fltVolume: Double;
  tpsTipoDePreparo: TTipoPreparoSalcomix): TADOQuery;
//var
//  blnFgFormulaPPU: Boolean;
 // blnFgResina325: Boolean;
begin
 // blnFgFormulaPPU := IIF(Pos('S850',strLinha) > 0,IIF(fFormulaDiluida(tpsTipoDePreparo),True,False),False);
 // blnFgResina325 := IIF(fFormulaResina325(tpsTipoDePreparo), True, False);
  Result :=   Nil//TSalcomixSqlServerFactory.GetProcedureCalculoFormula(strIdCor, blnFgFormulaPPU, blnFgResina325, fltVolume * 1000);
end;

function TSalcomixSQLServer.fFormulaDiluida(tpsTipoPreparo: TTipoPreparoSalcomix): Boolean;
begin
  Result := (tpsTipoPreparo = tpsDiluido)
end;

{function TSalcomixSQLServer.fFormulaResina325(
  tpsTipoPreparo: TTipoPreparoSalcomix): Boolean;
begin
  Result := (tpsTipoPreparo = tpsResina325)
end; }

destructor TSalcomixSQLServer.Destroy;
begin
  inherited;
end;

{ TFormulaSalcomixSQLServer }

constructor TFormulaSalcomixSQLServer.Create;
begin
  lstBases := TList.Create;
end;

destructor TFormulaSalcomixSQLServer.Destroy;
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

function TFormulaSalcomixSQLServer.GetBase(Index: Integer): TBaseAutomotiva;
begin
  Result := TBaseAutomotiva(lstBases[Index]);
end;

function TFormulaSalcomixSQLServer.GetCount: Integer;
begin
  Result := lstBases.Count;
end;

end.
