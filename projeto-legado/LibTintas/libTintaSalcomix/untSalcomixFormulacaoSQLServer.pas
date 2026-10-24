unit untSalcomixFormulacaoSQLServer;

interface

uses
  untAbstractTintaSQLServer, untIConfTinta, SysUtils,
  ADODB, StrUtils, Uni, Forms, Classes, DB, untBaseAutomotiva, untAutcomTintaFactory, untIDicionario;

Type
  TSalcomixFormulacaoSQLServer = Class(TAbstractTintaSQLServer)
  public
    function fCalculaFormulacao(fltVolume:Double;
      tpsTipoPreparo: TTipoPreparoTinta): TFormulaTintasSQLServer; override;
    function fExecutarProcedureCalculoFormula(fltVolume:Double;
      tpsTipoPreparo: TTipoPreparoTinta): TADOQuery; override;
    function fFormulaDiluida(tpsTipoPreparo: TTipoPreparoTinta): Boolean; override;
    function fFormulaResina325(tpsTipoPreparo: TTipoPreparoTinta): Boolean; override;
  End;

Type
  TSalcomixSQLServerFactory = Class(TInterfacedObject)
  private
    class var DicFormulas: IDicionario;
    class function GetDicFormulas(): IDicionario;
    class function GetChaveProcedureCalculoFormula(const strIdCor: String; const blnFgFormulaPPU, blnResina325: Boolean;
      const fltVolume: Double): String;
    class function GetNewProcedureCalculoFormula(const strIdCor:String; const blnFgFormulaPPU, blnResina325: Boolean;
      const fltVolume: Double): TADOQuery;
    class procedure Limpar;
  protected
    class function GetConexao(): TADOConnection;
    class function GetNomeTinta():String;
  public
    class function GetProcedureCalculoFormula(const strIdCor:String; const blnFgFormulaPPU, blnResina325: Boolean;
      const fltVolume: Double): TADOQuery;
  End;


implementation

uses
  untStrUtils, untFuncoesGenerica;

{ TSalcomixFormulacaoSQLServer }

function TSalcomixFormulacaoSQLServer.fCalculaFormulacao(fltVolume: Double;
  tpsTipoPreparo: TTipoPreparoTinta): TFormulaTintasSQLServer;
Var
  qryFormula: TADOQuery;
  objBase: TBaseAutomotiva;
  strCampoQtd: String;
begin
  Result := Nil;

  Try
    Try

      qryFormula := fExecutarProcedureCalculoFormula(fltVolume, tpsTipoPreparo);

      If Not Assigned(qryFormula) Then
        Exit;

      Result := TFormulaTintasSQLServer.Create;

      If Pos('S850', strLinha) <= 0 Then
        tpsTipoPreparo := tpsConcentrado;

      If fFormulaDiluida(tpsTipoPreparo) Then
        strCampoQtd := 'QT_ITEM_PPU_GRAMA'
      Else
        strCampoQtd := 'QT_ITEM_GRAMA';

      While Not (qryFormula.Eof) Do
      Begin
        If (qryFormula.FieldByName(strCampoQtd).AsFloat > 0) And
          (qryFormula.FieldByName('DS_ITEM_COMERCIAL').AsString <> 'TOTAL') Then
        Begin
          objBase := TBaseAutomotiva.Create(Nil);
          objBase.CodigoBase      := qryFormula.FieldByName('DS_CODIGO_ITEM').AsString;
          objBase.LinhaBase       := strLinha;
          objBase.Embalagem       := qryFormula.FieldByName('VL_VOLUME').AsFloat;
          objBase.PesoEspecifico  := qryFormula.FieldByName('VL_PESO_ESPECIFICO').AsFloat;

          If fFormulaDiluida(tpsTipoPreparo) Then
            objBase.QuantidadeDiluido := qryFormula.FieldByName(strCampoQtd).AsFloat
          Else
            objBase.QuantidadeConcentrado := qryFormula.FieldByName(strCampoQtd).AsFloat;

          If (fFormulaDiluida(tpsTipoPreparo)) And TStrUtils.fEmptyStr(objBase.CodigoBase) Then
            objBase.CodigoBase := 'THRAPID';

          Result.lstBases.Add(objBase);
        End;
        qryFormula.Next;
      End;

    Except
      On E: Exception Do
      Begin
        Raise;
      End;
    End;
  Finally

  End;

end;

function TSalcomixFormulacaoSQLServer.fExecutarProcedureCalculoFormula(
  fltVolume: Double; tpsTipoPreparo: TTipoPreparoTinta): TADOQuery;
Var
  blnFgFormulaPPU: Boolean;
  blnFgResina325: Boolean;
begin
  blnFgFormulaPPU := TAutcomTintaFactory.Get.IIF(Pos('S850', strLinha) > 0, TAutcomTintaFactory.Get.IIF(fFormulaDiluida(tpsTipoPreparo), True, False), False);
  blnFgResina325 := TAutcomTintaFactory.Get.IIF(fFormulaResina325(tpsTipoPreparo), True, False);

  Result := TSalcomixSQLServerFactory.GetProcedureCalculoFormula(strIdCor, blnFgFormulaPPU, blnFgResina325, fltVolume * 1000);
end;

function TSalcomixFormulacaoSQLServer.fFormulaDiluida(
  tpsTipoPreparo: TTipoPreparoTinta): Boolean;
begin
  Result := (tpsTipoPreparo = tpsDiluido);
end;

function TSalcomixFormulacaoSQLServer.fFormulaResina325(
  tpsTipoPreparo: TTipoPreparoTinta): Boolean;
begin
  Result := (tpsTipoPreparo = tpsResina325);
end;

{ TSalcomixSQLServerFactory }

class function TSalcomixSQLServerFactory.GetChaveProcedureCalculoFormula(
  const strIdCor: String; const blnFgFormulaPPU, blnResina325: Boolean;
  const fltVolume: Double): String;
begin
  Result := GetMD5(strIdCor) +
    GetMD5(BoolToStr(blnFgFormulaPPU, True)) +
    GetMD5(BoolToStr(blnResina325, True)) +
    GetMD5(FloatToStr(fltVolume));
  Result := GetMD5(Result);
end;



class function TSalcomixSQLServerFactory.GetConexao: TADOConnection;
Var
  strConect,
  strSenha,
  strDatabase,
  strHost,
  strUsuario: String;
  Conf: IConfTinta;
begin
  Conf := TAutcomTintaFactory.Get.fGetConfTinta('SAL');

  strSenha     := conf.fGet('SENSQS');
  strUsuario   := conf.fGet('USUSQS');
  strDataBase  := conf.fGet('DATSQS');
  strHost      := conf.fGet('HOSSQS');

  strConect := 'Provider=SQLOLEDB.1;Password=SENHA;Persist Security Info=True;User ID=USUARIO;Initial Catalog=DATABASE;Data Source=LOCALHOST';
  strConect := AnsiReplaceStr(strConect, 'SENHA', strSenha);
  strConect := AnsiReplaceStr(strConect, 'USUARIO', strUsuario);
  strConect := AnsiReplaceStr(strConect, 'DATABASE', strDatabase);
  strConect := AnsiReplaceStr(strConect, 'LOCALHOST', strHost);

  Result := TADOConnection.Create(Nil);
  Result.LoginPrompt := False;
  Result.Provider := 'SQLOLEDB.1';
  Result.ConnectionString := strConect;
end;

class function TSalcomixSQLServerFactory.GetDicFormulas: IDicionario;
begin
  If Not Assigned(DicFormulas) Then
    DicFormulas := TAutcomTintaFactory.Get.GetDicionario;

  Result := DicFormulas;
end;

class function TSalcomixSQLServerFactory.GetNomeTinta: String;
begin
  Result := 'Salcomix';
end;

class function TSalcomixSQLServerFactory.GetNewProcedureCalculoFormula(
  const strIdCor:String; const blnFgFormulaPPU, blnResina325: Boolean;
  const fltVolume: Double): TADOQuery;
Var
  sprFormulas : TADOStoredProc;
begin
  sprFormulas := Nil;
  Result := Nil;
  Try
    Try
      sprFormulas := TADOStoredProc.Create(GetConexao);
      sprFormulas.Connection := GetConexao;
      sprFormulas.ProcedureName := 'PRC_INT_CALCULA_FORMULA_COM_FLAG';
      sprFormulas.Prepared := True;

      Try
        sprFormulas.Parameters.Refresh;
      Except
        On E: Exception Do
        Begin
          TAutcomTintaFactory.Get.fMensagem('', 'Não foi possivel fazer a integração com o sistema ' + GetNomeTinta + '. Verificar Configurações!', ['&Ok']);
          Exit;
        End;
      End;

      If Not sprFormulas.Parameters.Refresh Then
      Begin
        TAutcomTintaFactory.Get.fMensagem('', 'Não foi possivel fazer a integração com o sistema ' + GetNomeTinta + '. Verificar Configurações!', ['&Ok']);
        Exit;
      End;

      sprFormulas.Parameters.ParamByName('@ID_COR').Value := strIdCor;
      sprFormulas.Parameters.ParamByName('@FG_FORMULAPPU').Value := blnFgFormulaPPU;
      sprFormulas.Parameters.ParamByName('@FG_RESINA325').Value := blnResina325;
      sprFormulas.Parameters.ParamByName('@VL_ML').Value := fltVolume;
      sprFormulas.Open;

      Result := TADOQuery.Create(GetConexao);
      Result.Recordset := sprFormulas.Recordset;
    Except
      On E: Exception Do
      Begin
        Raise;
      End;

    End;
  Finally
    If Assigned(sprFormulas) Then FreeAndNil(sprFormulas);
  End;
end;


class function TSalcomixSQLServerFactory.GetProcedureCalculoFormula(
  const strIdCor: String; const blnFgFormulaPPU, blnResina325: Boolean;
  const fltVolume: Double): TADOQuery;
Var
  strChave: String;
begin
  strChave := GetChaveProcedureCalculoFormula(strIdCor, blnFgFormulaPPU, blnResina325, fltVolume);
  Result := GetDicFormulas.RetornaObjeto(strChave) as TADOQuery;

  If Not Assigned(Result) Then
  Begin
    Result := GetNewProcedureCalculoFormula(strIdCor, blnFgFormulaPPU, blnResina325, fltVolume);
    GetDicFormulas.AdicionarObjeto(strChave, Result);
  End;

  If Assigned(Result) Then
    Result.First;
end;

class procedure TSalcomixSQLServerFactory.Limpar;
Var
  strChave: String;
begin
  For strChave in DicFormulas.Chaves Do
  Begin
    dicFormulas.RetornaObjeto(strChave);
    dicFormulas.Remove(strChave);
  End;
end;

initialization
  TSalcomixSQLServerFactory.DicFormulas := Nil;

finalization;
  If Assigned(TSalcomixSQLServerFactory.DicFormulas) Then
  Begin
    TSalcomixSQLServerFactory.Limpar;
    FreeAndNil(TSalcomixSQLServerFactory.DicFormulas);
  End;

end.
