unit untMatrizSaldosColorantesFactory;

interface

uses
  untTMatrizSaldosColorantes, untISaldosColorantes;

type
  TMatrizSaldosColorantesFactory = class(TInterfacedObject)
  public
    class function GetMatriz(const saldos: ISaldosColorantes): TClassMatrizSaldosColorantes;
    class function GetSaldoML(const matrizSaldosColorantes: TClassMatrizSaldosColorantes;
                              const strOpcTrava: String; const strCodEmb: String;
                              const intQtdEmb: Integer; const strDescri: String): Boolean;
  end;

implementation

{ TMatrizSaldosColorantesFactory }

class function TMatrizSaldosColorantesFactory.GetMatriz(
  const saldos: ISaldosColorantes): TClassMatrizSaldosColorantes;
var
  intCont: Integer;
begin
  Result := nil;
  if not Assigned(saldos) then
    Exit;
  
  Result := TClassMatrizSaldosColorantes.Create();
  for intCont := 0 to saldos.Cont - 1 do
  begin
    Result.fAdicionar(saldos[intCont].IDTinta,
      saldos[intCont].DescTinta,
      saldos[intCont].CodIte,
      saldos[intCont].DesIte,
      saldos[intCont].CodCol,
      saldos[intCont].QtdFormula,
//      saldos[intCont].QtdFormOri,
//      saldos[intCont].QtdFormAcu,
//      saldos[intCont].SaldoML,
      saldos[intCont].BasCol,
//      saldos[intCont].EmpPrd);
      saldos[intCont].PesGra,
      saldos[intCont].Embala);
  end;
end;

class function TMatrizSaldosColorantesFactory.GetSaldoML(
  const matrizSaldosColorantes: TClassMatrizSaldosColorantes;
  const strOpcTrava: String; const strCodEmb: String;
  const intQtdEmb: Integer; const strDescri: String): Boolean;
  Var
    intCont: Integer;
begin
  Result := True;

  For intCont := 0 To matrizSaldosColorantes.Count - 1 Do
  Begin
    Result := Result And
      ((matrizSaldosColorantes[intCont].fltQtdFormula > matrizSaldosColorantes[intCont].fltSaldoML)
      And (strOpcTrava = 'N'));
  End;

  If Not Result Then
  Begin
    Result := (strOpcTrava = 'A');
  End;

  If strCodEmb <> '' Then
  Begin
    matrizSaldosColorantes.fAdicionar(2,
                                      'EMBALAGEM',
                                      strCodEmb,
                                      strDescri,
                                      strCodEmb,
                                      intQtdEmb,
                                      EMBALAGEM,
                                      'N',  //Peso em gramas base
                                      0.0); //Embalagem da base
  End;
end;

end.
