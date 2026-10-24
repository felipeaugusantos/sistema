unit untMovSba;

interface

uses
  SysUtils, Classes, DB,   Uni,
  Variants;

function fGravaMovSba(strCodEmp,
                      strCodIte,
                      strCodOpe: String;
                      fltSaldos,
                      fltSal_ML: Double;
                      dtaDtaBal: TDateTime;
                      fltSalBal,
                      fltSMlBal: Double;
                      dtaDtaEnt,
                      tmeHorEnt,
                      dtaNdtBal: TDateTime;
                      fltNsaBal,
                      fltNMLBal: Double): Boolean;

implementation

uses untFuncoesSimples;

function fGravaMovSba(strCodEmp,
                      strCodIte,
                      strCodOpe: String;
                      fltSaldos,
                      fltSal_ML: Double;
                      dtaDtaBal: TDateTime;
                      fltSalBal,
                      fltSMlBal: Double;
                      dtaDtaEnt,
                      tmeHorEnt,
                      dtaNdtBal: TDateTime;
                      fltNsaBal,
                      fltNMLBal: Double): Boolean;
  Var
    strSQL: String;
    qryGenSba: TUniQuery;

begin
  qryGenSba := fCriaQuery(nil);

  strSQL := '';
  strSQL := strSQL + 'INSERT INTO ';
  strSQL := strSQL + '  MOVSBA ( ';
  strSQL := strSQL + '  SBA_CODITE, ';
  strSQL := strSQL + '  SBA_CODEMP, ';
  strSQL := strSQL + '  SBA_CODOPE, ';
  strSQL := strSQL + '  SBA_SALDOS, ';
  strSQL := strSQL + '  SBA_SAL_ML, ';
  strSQL := strSQL + '  SBA_DTABAL, ';
  strSQL := strSQL + '  SBA_SALBAL, ';
  strSQL := strSQL + '  SBA_ML_BAL, ';
  strSQL := strSQL + '  SBA_DTAENT, ';
  strSQL := strSQL + '  SBA_HORENT, ';
  strSQL := strSQL + '  SBA_NDTBAL, ';
  strSQL := strSQL + '  SBA_NSABAL, ';
  strSQL := strSQL + '  SBA_NMLBAL, ';
  strSQL := strSQL + '  AUTOINCREM) ';

  strSQL := strSQL + 'VALUES ( ';
  strSQL := strSQL + '  :CODITE, ';
  strSQL := strSQL + '  :CODEMP, ';
  strSQL := strSQL + '  :CODOPE, ';
  strSQL := strSQL + '  :SALDOS, ';
  strSQL := strSQL + '  :SAL_ML, ';
  strSQL := strSQL + '  :DTABAL, ';
  strSQL := strSQL + '  :SALBAL, ';
  strSQL := strSQL + '  :SMLBAL, ';
  strSQL := strSQL + '  :DTAENT, ';
  strSQL := strSQL + '  :HORENT, ';
  strSQL := strSQL + '  :NDTBAL, '; //Data de Balanço Anterior
  strSQL := strSQL + '  :NSABAL, '; //Saldo de Balanço Anterior
  strSQL := strSQL + '  :NMLBAL, '; //Saldo de Balanço ML Anterior
  strSQL := strSQL + '  :AUTINC) ';

  Try
    With qryGenSba Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString   := strCodEmp;
      ParamByName('CODITE').AsString   := strCodIte;
      ParamByName('CODOPE').AsString   := strCodOpe;
      ParamByName('SALDOS').AsFloat    := fltSaldos;
      ParamByName('SAL_ML').AsFloat    := fltSal_ML;
      ParamByName('DTABAL').AsDateTime := dtaDtaBal;
      ParamByName('SALBAL').AsFloat    := fltSalBal;
      ParamByName('SMLBAL').AsFloat    := fltSMlBal;
      ParamByName('DTAENT').AsDateTime := dtaDtaEnt;
      ParamByName('HORENT').AsDateTime := tmeHorEnt;

      If dtaNdtBal = 0 Then
        ParamByName('NDTBAL').Value := Null
      Else
        ParamByName('NDTBAL').AsDateTime := dtaNdtBal;

      If fltNsaBal = 0 Then
      Begin
        ParamByName('NSABAL').Value := Null;
        ParamByName('NMLBAL').Value := Null;
      End Else
      Begin
        ParamByName('NSABAL').AsFloat    := fltNsaBal;
        ParamByName('NMLBAL').AsFloat    := fltNMLBal;
      End;

      ParamByName('AUTINC').AsString  := fRetAutoIncrem('MOVSBA', strCodEmp);
      ExecSQL;
      Close;
      Result := True;
    End;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;

  FreeAndNil(qryGenSba);
end;

end.
