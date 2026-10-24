unit untGlasuritSqlServerFactory;

interface

uses
  ADODB, untFuncoesSimples, SysUtils, StrUtils;

type
  TGlasuritSqlServerFactory = class(TInterfacedObject)
  private
    class var dicFormulas: TDicionario;
    class var conBancoGlasurit: TADOConnection;
    class function GetDicFormulas: TDicionario;
    class function GetChaveProcedureCalculoFormula(const strIdCor: string; const blnFgFormulaPPU, blnFgResina325: Boolean;
      const fltVolume: Double): string;
    class function GetNewProcedureCalculoFormula(const strIdCor: string; const blnFgFormulaPPU, blnFgResina325: Boolean;
      const fltVolume: Double): TADOQuery;
    class function GetConexao: TADOConnection;
    class procedure Limpar;
  public
    class function GetProcedureCalculoFormula(const strIdCor: string; const blnFgFormulaPPU, blnFgResina325: Boolean;
      const fltVolume: Double): TADOQuery;
  end;

implementation

uses
  untGravando, System.Classes, untIConfTinta, untTintaMaquina;

{ TGlasuritSqlServerFactory }

class function TGlasuritSqlServerFactory.GetChaveProcedureCalculoFormula(const strIdCor: string; const blnFgFormulaPPU,
  blnFgResina325: Boolean; const fltVolume: Double): string;
begin
  Result := GetMD5(strIdCor) +
    GetMD5(BoolToStr(blnFgFormulaPPU, True)) +
    GetMD5(BoolToStr(blnFgResina325, True)) +
    GetMD5(FloatToStr(fltVolume));
  Result := GetMD5(Result)
end;

class function TGlasuritSqlServerFactory.GetConexao: TADOConnection;
var
  strConect: String;
  strSenha: String;
  strUsuario: String;
  strDatabase: String;
  strHost: String;
  conf: IConfTinta;
begin
  if not Assigned(conBancoGlasurit) then
  begin
    conf        := fGetConfTinta('GLA');
    strSenha    := conf.fGet('SENSQS');
    strUsuario  := conf.fGet('USUSQS');
    strDatabase := conf.fGet('DATSQS');
    strHost     := conf.fGet('HOSSQS');

    strConect := 'Provider=SQLOLEDB.1;Password=SENHA;Persist Security Info=True;User ID=USUARIO;Initial Catalog=DATABASE;Data Source=LOCALHOST';
    strConect := AnsiReplaceStr(strConect, 'SENHA', strSenha);
    strConect := AnsiReplaceStr(strConect, 'USUARIO', strUsuario);
    strConect := AnsiReplaceStr(strConect, 'DATABASE', strDatabase);
    strConect := AnsiReplaceStr(strConect, 'LOCALHOST', strHost);

    conBancoGlasurit := TADOConnection.Create(Nil);
    conBancoGlasurit.LoginPrompt := False;
    conBancoGlasurit.Provider := 'SQLOLEDB.1';
    conBancoGlasurit.ConnectionString := strConect;
  end;

  Result := conBancoGlasurit;  
end;

class function TGlasuritSqlServerFactory.GetDicFormulas: TDicionario;
begin
  if not Assigned(dicFormulas) then
    dicFormulas := TDicionario.Create;

  Result := dicFormulas;
end;

class function TGlasuritSqlServerFactory.GetNewProcedureCalculoFormula(const strIdCor: string; const blnFgFormulaPPU,
  blnFgResina325: Boolean; const fltVolume: Double): TADOQuery;
var
  sprFormula: TADOStoredProc;
begin
  sprFormula := Nil;
  Result := Nil;

  Try
    Try
      sprFormula := TADOStoredProc.Create(GetConexao);
      sprFormula.Connection := GetConexao;
      sprFormula.ProcedureName := 'PRC_INT_CALCULA_FORMULA_COM_FLAG';
      sprFormula.Prepared := True;

      Try
        sprFormula.Parameters.Refresh;
      Except
        on E: Exception do
        begin
          fMensagem('','Não foi possível fazer a integração com o sistema Glasurit. Verificar Configurações!', ['&Ok']);
          Exit;
        end;
      End;

      if Not sprFormula.Parameters.Refresh then
      begin
        fMensagem('','Não foi possível fazer a integração com o sistema Glasurit. Verificar Configurações!', ['&Ok']);
        Exit;
      end;

      sprFormula.Parameters.ParamByName('@ID_COR').Value := strIdCor;
      sprFormula.Parameters.ParamByName('@FG_FORMULAPPU').Value := blnFgFormulaPPU;
      sprFormula.Parameters.ParamByName('@FG_RESINA325').Value := blnFgResina325;
      sprFormula.Parameters.ParamByName('@VL_ML').Value := fltVolume;

      TfrmGravando.fExecutarModal(sprFormula.Open, 'Aguardando sistema Glasurit...', 'TFormulaSalcomix');

      Result := TADOQuery.Create(GetConexao);
      Result.Recordset := sprFormula.Recordset;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(sprFormula) then FreeAndNil(sprFormula);
  End;
end;

class function TGlasuritSqlServerFactory.GetProcedureCalculoFormula(const strIdCor: string; const blnFgFormulaPPU, blnFgResina325: Boolean;
  const fltVolume: Double): TADOQuery;
var
  strChave: string;
begin
  strChave := GetChaveProcedureCalculoFormula(strIdCor, blnFgFormulaPPU, blnFgResina325, fltVolume);
  Result := GetDicFormulas.RetornaObjeto(strChave) as TADOQuery;

  if not Assigned(Result) then
  begin
    Result := GetNewProcedureCalculoFormula(strIdCor, blnFgFormulaPPU, blnFgResina325, fltVolume);
    GetDicFormulas.AdicionarObjeto(strChave, Result);
  end;

  if Assigned(Result) then
    Result.First;
end;

class procedure TGlasuritSqlServerFactory.Limpar;
var
  strChave: string;
begin
  for strChave in dicFormulas.Chaves do
  begin
    dicFormulas.RetornaObjeto(strChave).Free;
    dicFormulas.Remove(strChave);
  end;
end;

initialization
  TGlasuritSqlServerFactory.dicFormulas := nil;
  TGlasuritSqlServerFactory.conBancoGlasurit := nil;

finalization;
  if Assigned(TGlasuritSqlServerFactory.dicFormulas) then
  begin
    TGlasuritSqlServerFactory.Limpar;
    FreeAndNil(TGlasuritSqlServerFactory.dicFormulas);
  end;

  if Assigned(TGlasuritSqlServerFactory.conBancoGlasurit) then FreeAndNil(TGlasuritSqlServerFactory.conBancoGlasurit);
end.

