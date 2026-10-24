unit untLogDes;

interface

uses SysUtils, Classes, Uni;

Type
  TLogDes = class(TObject)
    private
      FCodOpe: String;
      FDtaEnt: TDateTime;
      FHorEnt: TDateTime;
      FNumDoc: String;
      FEspDOc: String;
      FCodEmp: String;
      FIdePro: String;
      FCodIte: String;
      FDesOri: String;
      FDesNov: String;
    public
      procedure pSalvar;

      property strCodOpe: String    Read FCodOpe Write FCodOpe;
      property dtaDtaEnt: TDateTime Read FDtaEnt Write FDtaEnt;
      property horHorEnt: TDateTime Read FHorEnt Write FHorEnt;
      property strNumDoc: String    Read FNumDoc Write FNumDoc;
      property strEspDOc: String    Read FEspDOc Write FEspDOc;
      property strCodEmp: String    Read FCodEmp Write FCodEmp;
      property strIdePro: String    Read FIdePro Write FIdePro;
      property strCodIte: String    Read FCodIte Write FCodIte;
      property strDesOri: String    Read FDesOri Write FDesOri;
      property strDesNov: String    Read FDesNov Write FDesNov;
End;

implementation

uses untFuncoesSimples;

{ TLogDes }

procedure TLogDes.pSalvar;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('INSERT INTO ');
  qryAux.SQL.Add('  LOGDES ');
  qryAux.SQL.Add('( ');
  qryAux.SQL.Add('  LOG_CODOPE, ');
  qryAux.SQL.Add('  LOG_DTAENT, ');
  qryAux.SQL.Add('  LOG_HORENT, ');
  qryAux.SQL.Add('  LOG_NUMDOC, ');
  qryAux.SQL.Add('  LOG_ESPDOC, ');
  qryAux.SQL.Add('  LOG_CODEMP, ');
  qryAux.SQL.Add('  LOG_IDEPRO, ');
  qryAux.SQL.Add('  LOG_CODITE, ');
  qryAux.SQL.Add('  LOG_DESORI, ');
  qryAux.SQL.Add('  LOG_DESNOV, ');
  qryAux.SQL.Add('  AUTOINCREM ');
  qryAux.SQL.Add(') VALUES ( ');
  qryAux.SQL.Add('  :CODOPE, ');
  qryAux.SQL.Add('  :DTAENT, ');
  qryAux.SQL.Add('  :HORENT, ');
  qryAux.SQL.Add('  :NUMDOC, ');
  qryAux.SQL.Add('  :ESPDOC, ');
  qryAux.SQL.Add('  :CODEMP, ');
  qryAux.SQL.Add('  :IDEPRO, ');
  qryAux.SQL.Add('  :CODITE, ');
  qryAux.SQL.Add('  :DESORI, ');
  qryAux.SQL.Add('  :DESNOV, ');
  qryAux.SQL.Add('  :AUTINC) ');

  qryAux.ParamByName('CODOPE').AsString   := strCodOpe;
  qryAux.ParamByName('DTAENT').AsDateTime := dtaDtaEnt;
  qryAux.ParamByName('HORENT').AsDateTime := horHorEnt;
  qryAux.ParamByName('NUMDOC').AsString   := strNumDoc;
  qryAux.ParamByName('ESPDOC').AsString   := strEspDoc;
  qryAux.ParamByName('CODEMP').AsString   := strCodEmp;
  qryAux.ParamByName('IDEPRO').AsString   := strIdePro;
  qryAux.ParamByName('CODITE').AsString   := strCodIte;
  qryAux.ParamByName('DESORI').AsString   := strDesOri;
  qryAux.ParamByName('DESNOV').AsString   := strDesNov;
  qryAux.ParamByName('AUTINC').AsString   := fRetAutoIncrem('LOGDES', VS_strCodEmp);
  qryAux.ExecSQL;

  FreeAndNil(qryAux);
end;

end.
