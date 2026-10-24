unit Faturamento.Connections.Functions;

interface
{$WARN SYMBOL_PLATFORM OFF}

Uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE }
  Controls, Forms, Windows, Graphics, Messages, Dialogs, Buttons,
  Consts, Mask, StdCtrls, DBCtrls, Aurelius.Types.Nullable,
  ExtCtrls, ComCtrls, MMSystem, Grids, Menus, RLTypes,
{$ENDIF LINUX}
  Core.Funcoes,
  Shared.Functions.Conexao.UniDac,
  Classes, Uni, SysUtils, StrUtils,
  IniFiles,
  DB, DBClient,

  Variants, Math,
  DateUtils, MaskUtils, Contnrs, TypInfo,

  System.Types,
  System.Generics.Collections,
  untDicionarioResultadoQuerySimples,
  Shared.Functions.DataSet,
  Shared.Functions.Funcoes.Faturamento,
  untTypesSistema;

type
  TStringArrayTabela = array of string;

  function fCriaQueryFat(AOwner: TComponent = Nil; Conexao: TUniConnection = nil): TUniQuery;

  function fCriarQueryFat(strSQL: String; AOwner: TComponent = nil): TUniQuery;

  function fCampoTabelaFat(strCampo : String;
                        strNomTab: String;
                        arrCampoChave: Array Of String;
                        arrValorChave: Array Of Variant;
                        blnSempreLerBanco: Boolean = True;
                        strOrderBy: String = '';
                        Conexao: TUniConnection = Nil;
                        blnUsarMax: Boolean = False): Variant;

  function fCampoTabelaArray(arrCampos: Array Of String;
                             strNomTab: String;
                             arrCampoChave: Array Of String;
                             arrValorChave: Array Of Variant;
                             blnSempreLerBanco: Boolean = True;
                             strOrderBy: String = '';
                             Conexao: TUniConnection = Nil;
                             blnUsarMax: Boolean = False): IMyCampoTabela;

  function RetornarSelectCampoTabela(arrCampos: Array Of String;
                                     strNomTab: String;
                                     arrCampoChave: Array Of String;
                                     arrValorChave: Array Of Variant;
                                     strOrderBy: String = '';
                                     blnUsarMax: Boolean = False): String;

  function ExecutarSelectSempreLendoDoBanco(ASelectCompleto: String;
    arrCampos: Array Of String; arrCampoChave: Array Of String;
    arrValorChave: Array Of Variant; Conexao: TUniConnection): IMyCampoTabela;

  function RetornarCamposQueNaoEstaoEmCache(arrCampos: Array Of String;
                                            strNomTab: String;
                                            arrCampoChave: Array Of String;
                                            arrValorChave: Array Of Variant;
                                            strOrderBy: String = '';
                                            Conexao: TUniConnection = Nil;
                                            blnUsarMax: Boolean = False): TStringArrayTabela;

   function AdicionarCamposSemCache(arrCampos: Array Of String;
                                    strNomTab: String;
                                    arrCampoChave: Array Of String;
                                    arrValorChave: Array Of Variant;
                                    strOrderBy: String = '';
                                    Conexao: TUniConnection = Nil;
                                    blnUsarMax: Boolean = False): Boolean;

   function RetornarCamposEmCache(arrCampos: Array Of String;
                                  strNomTab: String;
                                  arrCampoChave: Array Of String;
                                  arrValorChave: Array Of Variant;
                                  strOrderBy: String = '';
                                  Conexao: TUniConnection = Nil;
                                  blnUsarMax: Boolean = False): IMyCampoTabela; //TMatrizCamposTabela;

   function fAdicionaResultadoICampoTabela(arrResultado: TMatrizCamposTabela): IMyCampoTabela;


  function SempreLerDoBanco(arrCampos: Array Of String;
                            strNomTab: String;
                            arrCampoChave: Array Of String;
                            arrValorChave: Array Of Variant;
                            strOrderBy: String = '';
                            Conexao: TUniConnection = Nil;
                            blnUsarMax: Boolean = False): IMyCampoTabela;

  function SempreLerDoCache(arrCampos: Array Of String;
                            strNomTab: String;
                            arrCampoChave: Array Of String;
                            arrValorChave: Array Of Variant;
                            strOrderBy: String = '';
                            Conexao: TUniConnection = Nil;
                            blnUsarMax: Boolean = False): IMyCampoTabela;

  function ExecutarQueryEmCache(qryGen: TUniQuery): IMyCampoTabela;

  procedure QueryPreencherParametros(var qryAuxGen: TUniQuery;
                                     ASelect: String;
                                     arrCampoChave: Array Of String;
                                     arrValorChave: Array Of Variant);

  function RetornarCampoChaveDiferente(const intCont: Integer; const arrCampoChave: Array Of String): String;
  function RetornarCampoChaveLocate(const intCont: Integer; const arrCampoChave: Array Of String): String;
  function EncontrouCaracter(const strCaracter: String): Boolean;
  function fCampoExisteFat(const strTabela, strCampo: String; Conexao: TUniConnection; blnUsarCache: Boolean = False): Boolean;

  function fTabelaExisteFat(strNomeTabela: String; Conexao: TUniConnection = Nil; blnUsarCache: Boolean = False): Boolean;

  function RetornarTamanhoDoCampoNumeroDoDocumentoFat(Conexao : TUniConnection) : Integer;

  function fTemAliqEcfFat(const fltAliquota: Double; const strPatIni: String; Conexao: TUniConnection): Boolean;

Const
  arrParms : Array [0..11] Of String[1] = ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L');

var
  FLock: TTrackedCriticalSection;
  FCacheMyCampoTabela: TDictionary<string, IMyCampoTabela>;
  FCacheTabelaExiste: TDictionary<string, Boolean>;
  FCacheCampoExiste: TDictionary<string, Boolean>;

implementation

uses  System.UITypes;

function fTabelaExisteFat(strNomeTabela: String; Conexao: TUniConnection = Nil; blnUsarCache: Boolean = False): Boolean;
  Var
    qryAux: TUniQuery;
Begin
  If (TCoreFuncoes.fEmptyStr(strNomeTabela)) Then
  Begin
    Result := False;
    Exit;
  End;
  FLock.SafeEnter('fTabelaExisteFat');
  try
    if blnUsarCache then
      if FCacheTabelaExiste.ContainsKey(strNomeTabela) then
        Exit(FCacheTabelaExiste[strNomeTabela]);
    qryAux := fCriaQueryFat(Nil, Conexao);
    Try
      Try
        qryAux.Close;
        qryAux.SQL.Text := 'SELECT "TAB" AS TABELA_EXISTE FROM ' + strNomeTabela + ' WHERE FALSE';
        qryAux.Open;
        Result := True;
        qryAux.Close;
      Except
        Result := False;
      End;
      if blnUsarCache then
        FCacheTabelaExiste.AddOrSetValue(strNomeTabela, Result);
    Finally
      FreeAndNil(qryAux);
    End;
  Finally
    FLock.Leave;
  End;
End;

function RetornarTamanhoDoCampoNumeroDoDocumentoFat(Conexao : TUniConnection) : Integer;
var
  qryAux: TUniQuery;
Begin
  if Conexao = nil then
    Conexao := TUniConnection(objDataSet.GetConObj);

  Result := 6;
  qryAux := fCriaQueryFat(Nil, Conexao);
  qryAux.SQL.Text := 'DESC MOVGER';
  qryAux.Open;

  While (Not qryAux.Eof) Do
  Begin
    If qryAux.FieldByName('Field').AsString = 'GER_NUMDOC' Then
    Begin
      If UpperCase(qryAux.FieldByName('Type').AsString) = 'VARCHAR(6)' Then
        Result := 6
      Else
        Result := 12;
      Break;
    End;

    qryAux.Next;
  End;

  FreeAndNil(qryAux);
end;


function fCriaQueryFat(AOwner: TComponent = Nil; Conexao: TUniConnection = nil): TUniQuery;
Begin
  if Conexao = nil then
    Conexao := TUniConnection(objDataSet.GetConObj);
  Result := TUniQuery.Create(AOwner);
  Result.Connection := Conexao;
  If Assigned(Result.Connection) Then
    Result.Tag := Result.Connection.Tag;
  Result.Options.RequiredFields := False;
End;

function IfEmptyStrFat(strValor, strDefault: String): String;
begin
  Result := strValor;
  If TCoreFuncoes.fEmptyStr(Result) Then
    Result := strDefault;
end;

{*********************************************}
{* FUNCAO PARA CRIAR QUERY E RETER OS CAMPOS *}
{******************************************PH*}
function fCriarQueryFat(strSQL: String; AOwner: TComponent = nil): TUniQuery;
  Var
    intCont: Integer;
begin
  Result := fCriaQueryFat(AOwner);
  Result.SQL.Text := strSQL;
  Result.Open;
  Result.Close;

  For intCont := 0 To Result.FieldDefs.Count - 1 Do
  Begin
    Result.FieldDefs[intCont].CreateField(Result);
  End;
end;


function fCampoTabelafat(strCampo : String;
                         strNomTab: String;
                         arrCampoChave: Array Of String;
                         arrValorChave: Array Of Variant;
                         blnSempreLerBanco: Boolean = True;
                         strOrderBy: String = '';
                         Conexao: TUniConnection = Nil;
                         blnUsarMax: Boolean = False): Variant;

var
  LResultado: IMyCampoTabela;
Begin
  if Conexao = nil then
    Conexao := TUniConnection(objDataSet.GetConObj);

  LResultado := fCampoTabelaArray([strCampo],
                                  strNomTab,
                                  arrCampoChave,
                                  arrValorChave,
                                  blnSempreLerBanco,
                                  strOrderBy,
                                  Conexao,
                                  blnUsarMax);

  Result := LResultado.Fields(0);
End;

function GetMyCampoTabelaKey(arrCampos: Array Of String;
                             strNomTab: String;
                             arrCampoChave: Array Of String;
                             arrValorChave: Array Of Variant;
                             strOrderBy: String = '';
                             Conexao: TUniConnection = Nil;
                             blnUsarMax: Boolean = False): string;
var
  LStr: string;
begin
  Result := EmptyStr;

  for LStr in arrCampos do
    Result := Result + '-' + LStr;

  Result := Result + '-' + strNomTab;

  for LStr in arrCampoChave do
    Result := Result + '-' + LStr;

  for LStr in arrValorChave do
    Result := Result + '-' + LStr;

  Result := Result + '-' + strOrderBy;

  if Assigned(Conexao) then
    Result := Result + '-' + Conexao.Tag.ToString;

  if blnUsarMax then
    Result := Result + '-' + 'MAX';

  Result := TCoreFuncoes.GetMD5(Result);
end;

function fCampoTabelaArray(arrCampos: Array Of String;
                           strNomTab: String;
                           arrCampoChave: Array Of String;
                           arrValorChave: Array Of Variant;
                           blnSempreLerBanco: Boolean = True;
                           strOrderBy: String = '';
                           Conexao: TUniConnection = Nil;
                           blnUsarMax: Boolean = False): IMyCampoTabela;
var
  LInstance: IMyCampoTabela;
  LKey: string;
Begin
  if Conexao = nil then
    Conexao := TUniConnection(objDataSet.GetConObj);

  If blnSempreLerBanco Then
  Begin
    Result := SempreLerDoBanco(arrCampos, strNomTab, arrCampoChave, arrValorChave, strOrderBy, Conexao, blnUsarMax);
    Exit;
  End;

  LKey := GetMyCampoTabelaKey(arrCampos, strNomTab, arrCampoChave, arrValorChave, strOrderBy, Conexao, blnUsarMax);
  
  if not FCacheMyCampoTabela.TryGetValue(LKey, LInstance) then
  begin    
    LInstance := SempreLerDoCache(arrCampos, strNomTab, arrCampoChave, arrValorChave, strOrderBy, Conexao, blnUsarMax);
    FCacheMyCampoTabela.AddOrSetValue(LKey, LInstance);
  end;

  Result := LInstance;
end;

function RetornarSelectCampoTabela(arrCampos: Array Of String;
                                strNomTab: String;
                                arrCampoChave: Array Of String;
                                arrValorChave: Array Of Variant;
                                strOrderBy: String = '';
                                blnUsarMax: Boolean = False): String;

var
  intCampos: Integer;
  intCont: Integer;
const
  VIRGULA = ', ';
begin
  Result := '';
  Result := Result + 'SELECT SQL_NO_CACHE ';

  for intCampos := 0 to Length(arrCampos) - 1 do
  begin
    if blnUsarMax then
      Result := Result + '  MAX(' + arrCampos[intCampos] + ')' + VIRGULA
    else
      Result := Result + '  ' + arrCampos[intCampos] + VIRGULA;
  end;

  Delete(Result, Length(Result) - 1, 1);

  // para atender a seguinte situação: SELECT CURRENT_DATE 
  if (TCoreFuncoes.fEmptyStr(strNomTab)) then
    Exit;

  Result := Result + 'FROM ';
  Result := Result + '  ' + strNomTab + ' ';
  Result := Result + 'WHERE ';

  For intCont := 0 To Length(arrCampoChave) -1 Do
  Begin

    If Pos('<>', arrCampoChave[intCont]) > 0 Then
    Begin
      Result := Result + '  ' + RetornarCampoChaveDiferente(intCont, arrCampoChave);
      Continue;
    End;

    If Pos('LOCATE(', arrCampoChave[intCont]) > 0 Then
    Begin
      Result := Result + '  ' + RetornarCampoChaveLocate(intCont, arrCampoChave);
      Continue;
    End;

    Result := Result + '  ' + arrCampoChave[intCont] + ' = :' + String(arrParms[intCont]) + ' AND ';
  End;

  Result := Result + '  TRUE  ';

  If Not TCoreFuncoes.fEmptyStr(strOrderBy) Then
    Result := Result + ' ORDER BY ' + strOrderBy;

  Result := Result + ' LIMIT 1 ';
end;

function ExecutarSelectSempreLendoDoBanco(ASelectCompleto: String;
    arrCampos: Array Of String; arrCampoChave: Array Of String;
    arrValorChave: Array Of Variant; Conexao: TUniConnection): IMyCampoTabela;

var
  arrMatCamposTabela: TMatrizCamposTabela;
  qryGenGer: TUniQuery;
  intCampos: Integer;
begin
  if Conexao = nil then
    Conexao := TUniConnection(objDataSet.GetConObj);

  Try
    qryGenGer := fCriaQueryFat(nil, Conexao);

    SetLength(arrMatCamposTabela, 0);

    With qryGenGer Do
    Begin

      QueryPreencherParametros(qryGenGer, ASelectCompleto, arrCampoChave, arrValorChave) ;

      Open;

      for intCampos := 0 to Length(arrCampos) - 1 do
      begin
        SetLength(arrMatCamposTabela, Length(arrMatCamposTabela) + 1);

        arrMatCamposTabela[intCampos].Valor := Fields[intCampos].Value;
        {*******************************************}
        {* EXECUTA UM CAST PARA NAO RETORNAR NULL  *}
        {****************************************JC*}
        Case Fields[intCampos].DataType Of
          ftString : arrMatCamposTabela[intCampos].Valor := Fields[intCampos].AsString;
          ftMemo   : arrMatCamposTabela[intCampos].Valor := Fields[intCampos].AsString;
          ftFloat  : arrMatCamposTabela[intCampos].Valor := Fields[intCampos].AsFloat;
          ftInteger: arrMatCamposTabela[intCampos].Valor := Fields[intCampos].AsInteger;
          ftBoolean: arrMatCamposTabela[intCampos].Valor := Fields[intCampos].AsBoolean;
          ftDate   : arrMatCamposTabela[intCampos].Valor := Fields[intCampos].AsDateTime;
          ftTime   : arrMatCamposTabela[intCampos].Valor := Fields[intCampos].AsDateTime;
        End;

        arrMatCamposTabela[intCampos].Nome := Fields[intCampos].FieldName;
      end;

      Result := fAdicionaResultadoICampoTabela(arrMatCamposTabela);
    End;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create('Ocorreu o seguinte erro ao executar a função '+
        '"fCampoTabelaArray.ExecutarSelectSempreLendoDoBanco" :' +#13#10 + E.Message);
    End;
  End;

  FreeAndNil(qryGenGer);
end;

function RetornarCamposQueNaoEstaoEmCache(arrCampos: Array Of String;
                                          strNomTab: String;
                                          arrCampoChave: Array Of String;
                                          arrValorChave: Array Of Variant;
                                          strOrderBy: String = '';
                                          Conexao: TUniConnection = Nil;
                                          blnUsarMax: Boolean = False): TStringArrayTabela;

Var
  objCache: TDicResultadoQuerySimples;
  intCont: Integer;
  qryCache: TUniQuery;
  strSQL: String;
begin
  if Conexao = nil then
    Conexao := TUniConnection(objDataSet.GetConObj);

  objCache := TDicResultadoQuerySimples.fGetInstance();

  SetLength(Result, 0);

  try
    qryCache := fCriaQueryFat(nil, Conexao);

    for intCont := 0 to Length(arrCampos) - 1 do
    begin
      strSQL := RetornarSelectCampoTabela([arrCampos[intCont]], strNomTab, arrCampoChave, arrValorChave, strOrderBy, blnUsarMax);

      With qryCache Do
      Begin
        QueryPreencherParametros(qryCache, strSQL, arrCampoChave, arrValorChave);
      End;

      If Not objCache.fGetDicObjects.ContainsKey(objCache.GetKey(qryCache)) then
      Begin
        SetLength(Result, Length(Result)+1);
        Result[Length(Result)-1] := arrCampos[intCont];
      End;
    end;

  finally
    FreeAndNil(qryCache);
  end;
end;

function AdicionarCamposSemCache(arrCampos: Array Of String;
                                 strNomTab: String;
                                 arrCampoChave: Array Of String;
                                 arrValorChave: Array Of Variant;
                                 strOrderBy: String = '';
                                 Conexao: TUniConnection = Nil;
                                 blnUsarMax: Boolean = False): Boolean;

var
  qrySelect: TUniQuery;
  qryExec: TUniQuery;
  strSQL: String;
  intCont: Integer;
  LResultado: Variant;
  objCache: TDicResultadoQuerySimples;
  LCampo: TObjCampoTabela;
begin
  if Conexao = nil then
    Conexao := TUniConnection(objDataSet.GetConObj);

  Result := True;

  If (Length(arrCampos) <= 0) Then
    Exit;

  objCache := TDicResultadoQuerySimples.fGetInstance();

  Try
    qryExec := fCriaQueryFat(nil, Conexao);
    qrySelect := fCriaQueryFat(nil, Conexao);

    With qrySelect Do
    Begin
      strSQL := RetornarSelectCampoTabela(arrCampos, strNomTab, arrCampoChave, arrValorChave, strOrderBy, blnUsarMax);

      QueryPreencherParametros(qrySelect, strSQL, arrCampoChave, arrValorChave);

      Open;

      for intCont := 0 to Length(arrCampos) - 1 do
      begin

        strSQL := RetornarSelectCampoTabela([arrCampos[intCont]], strNomTab, arrCampoChave, arrValorChave, strOrderBy, blnUsarMax);

        With qryExec Do
        Begin
          QueryPreencherParametros(qryExec, strSQL, arrCampoChave, arrValorChave);
        End;

        LResultado := Fields[intCont].Value;

        Case Fields[intCont].DataType Of
          ftString : LResultado := Fields[intCont].AsString;
          ftMemo   : LResultado := Fields[intCont].AsString;
          ftFloat  : LResultado := Fields[intCont].AsFloat;
          ftInteger: LResultado := Fields[intCont].AsInteger;
          ftBoolean: LResultado := Fields[intCont].AsBoolean;
          ftDate   : LResultado := Fields[intCont].AsDateTime;
          ftTime   : LResultado := Fields[intCont].AsDateTime;
        End;

        LCampo := TObjCampoTabela.Create;

        LCampo.Field.Nome  := Fields[intCont].FieldName;
        LCampo.Field.Valor := LResultado;

        objCache.SetObject(qryExec, LCampo);
      end;

      Close;
    End;
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create('Ocorreu o seguinte erro ao executar a função '+
        '"fCampoTabelaArray.AdicionarCamposSemCache" :' +#13#10 + E.Message);
    End;
  End;

  FreeAndNil(qryExec);
  FreeAndNil(qrySelect);
end;

function RetornarCamposEmCache(arrCampos: Array Of String;
                               strNomTab: String;
                               arrCampoChave: Array Of String;
                               arrValorChave: Array Of Variant;
                               strOrderBy: String = '';
                               Conexao: TUniConnection = Nil;
                               blnUsarMax: Boolean = False): IMyCampoTabela; //TMatrizCamposTabela;

Var
  objDic: TDicResultadoQuerySimples;
  intCont: Integer;
  qryCache: TUniQuery;
  strSQL: String;
  arrResultado: TMatrizCamposTabela;
  objCampos: TObject;
begin
  if Conexao = nil then
    Conexao := TUniConnection(objDataSet.GetConObj);

  objDic := TDicResultadoQuerySimples.fGetInstance();

  SetLength(arrResultado, 0);

  try
    qryCache := fCriaQueryFat(nil, Conexao);

    for intCont := 0 to Length(arrCampos) - 1 do
    begin
      strSQL := RetornarSelectCampoTabela([arrCampos[intCont]], strNomTab, arrCampoChave, arrValorChave, strOrderBy, blnUsarMax);

      With qryCache Do
      Begin
        QueryPreencherParametros(qryCache, strSQL, arrCampoChave, arrValorChave) ;
      End;

      if objDic.fGetDicObjects.TryGetValue(objDic.GetKey(qryCache), objCampos) then
      Begin
        SetLength(arrResultado,  Length(arrResultado) + 1);
        arrResultado[intCont].Nome  := TObjCampoTabela(objCampos).Field.Nome;
        arrResultado[intCont].Valor := TObjCampoTabela(objCampos).Field.Valor;
      End;
    end;

    Result := fAdicionaResultadoICampoTabela(arrResultado);

  finally
    FreeAndNil(qryCache);
  end;
end;

function fAdicionaResultadoICampoTabela(arrResultado: TMatrizCamposTabela): IMyCampoTabela;
var
  LMyCampoTabela: TMyCampoTabela;
  intCont: Integer;
begin
  LMyCampoTabela := TMyCampoTabela.Create;

  for intCont := 0 to Length(arrResultado) - 1 do
  begin
    LMyCampoTabela.Add(arrResultado[intCont].Nome, arrResultado[intCont].Valor);
  end;

  Result := LMyCampoTabela;
end;


function SempreLerDoBanco(arrCampos: Array Of String;
                          strNomTab: String;
                          arrCampoChave: Array Of String;
                          arrValorChave: Array Of Variant;
                          strOrderBy: String = '';
                          Conexao: TUniConnection = Nil;
                          blnUsarMax: Boolean = False): IMyCampoTabela;
  Var
    LSelect: String;
begin
  if Conexao = nil then
    Conexao := TUniConnection(objDataSet.GetConObj);

  LSelect := RetornarSelectCampoTabela(arrCampos, strNomTab, arrCampoChave, arrValorChave, strOrderBy, blnUsarMax);

  Result := ExecutarSelectSempreLendoDoBanco(LSelect, arrCampos, arrCampoChave, arrValorChave, Conexao);
end;

function SempreLerDoCache(arrCampos: Array Of String;
                          strNomTab: String;
                          arrCampoChave: Array Of String;
                          arrValorChave: Array Of Variant;
                          strOrderBy: String = '';
                          Conexao: TUniConnection = Nil;
                          blnUsarMax: Boolean = False): IMyCampoTabela;
  Var
    arrCamposSemCache: TStringArrayTabela; //Array Of String;
begin
  if Conexao = nil then
    Conexao := TUniConnection(objDataSet.GetConObj);

  arrCamposSemCache := RetornarCamposQueNaoEstaoEmCache(arrCampos, strNomTab, arrCampoChave, arrValorChave, strOrderBy, Conexao, blnUsarMax);

  AdicionarCamposSemCache(arrCamposSemCache, strNomTab, arrCampoChave, arrValorChave, strOrderBy, Conexao, blnUsarMax);

  Result := RetornarCamposEmCache(arrCampos, strNomTab, arrCampoChave, arrValorChave, strOrderBy, Conexao, blnUsarMax);
end;

function ExecutarQueryEmCache(qryGen: TUniQuery): IMyCampoTabela;
begin
  Result := fAdicionaResultadoICampoTabela(TDicResultadoQuerySimples.fExecQueryCampos(qryGen));
end;

procedure QueryPreencherParametros(var qryAuxGen: TUniQuery;
                                   ASelect: String;
                                   arrCampoChave: Array Of String;
                                   arrValorChave: Array Of Variant);

var
  intCont: Integer;
begin
  qryAuxGen.Close;
  qryAuxGen.SQL.Clear;
  qryAuxGen.SQL.Add(ASelect);

  For intCont := 0 To Length(arrCampoChave) -1 Do
    qryAuxGen.ParamByName(String(arrParms[intCont])).Value := arrValorChave[intCont];
end;

function RetornarCampoChaveDiferente(const intCont: Integer; const arrCampoChave: Array Of String): String;
begin
  Result := arrCampoChave[intCont] + ' :' + String(arrParms[intCont]) + ' AND ';
end;

function RetornarCampoChaveLocate(const intCont: Integer; const arrCampoChave: Array Of String): String;
var
  strPosParam: String;
  strParamNome: String;

  intTamanho: Integer;
begin
  strParamNome := '';
  strPosParam  := Trim(Copy(arrCampoChave[intCont], Pos(':', arrCampoChave[intCont]), Length(arrCampoChave[intCont])));

  for intTamanho := 1 to strPosParam.Length do
  begin
    if (EncontrouCaracter(strPosParam[intTamanho])) then
      Break;

    strParamNome := strParamNome + strPosParam[intTamanho];
  end;

  strParamNome := Trim(strParamNome);

  Result := AnsiReplaceStr(arrCampoChave[intCont], strParamNome, ' :' + String(arrParms[intCont])) + ' AND ';
end;

function EncontrouCaracter(const strCaracter: String): Boolean;
begin
  Result := True;

  if strCaracter = '' then
    Exit;

  if strCaracter = ',' then
    Exit;

  if strCaracter = ')' then
    Exit;

  Result := False;
end;

function fCampoExisteFat(const strTabela, strCampo: String; Conexao: TUniConnection; blnUsarCache: Boolean = False): Boolean;
  Var
    qryAux: TUniQuery;
begin
  If (TCoreFuncoes.fEmptyStr(strTabela)) Or (TCoreFuncoes.fEmptyStr(strCampo)) Then
  Begin
    Result := False;
    Exit;
  End;
  FLock.SafeEnter('fCampoExisteFat');
  try
    if blnUsarCache then
      if FCacheCampoExiste.ContainsKey(strCampo+strTabela) then
        Exit(FCacheCampoExiste[strCampo+strTabela]);
    qryAux := fCriaQueryFat(Nil, Conexao);
    Try
      Try
        qryAux.Close;
        qryAux.SQL.Text := 'SELECT '+strCampo+' AS CAMPO_EXISTE FROM ' + strTabela + ' WHERE FALSE';
        qryAux.Open;
        Result := True;
        qryAux.Close;
      Except
        Result := False;
      End;
      if blnUsarCache then
        FCacheCampoExiste.AddOrSetValue(strCampo+strTabela, Result);
    Finally
      FreeAndNil(qryAux);
    End;
  finally
    FLock.Leave;
  end;
end;

function fTemAliqEcfFat(const fltAliquota: Double; const strPatIni: String; Conexao: TUniConnection): Boolean;
  Var
    strSQL     : String;
    qryTmpEcf  : TUniQuery;
    //strPatIni  : String;
    strCodEcf  : String;
Begin
  if Conexao = nil then
    Conexao := TUniConnection(objDataSet.GetConObj);

  Try
    Result := False;

    strCodEcf := TCoreFuncoes.fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'IMPRESSORA'   , '', strPatIni + '/opcoes_fiscal.ini' );

    qryTmpEcf := fCriaQueryFat(Nil, Conexao);
    With qryTmpEcf Do
    Begin

      strSql := TFunctionFuncoesFaturamento.GetSelectTemAliquotaEcf;

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODECF').AsString := strCodEcf;
      Open;

      If IsEmpty Then
        Exit;

      First;

      While Not Eof Do
      Begin

        If TFunctionFuncoesFaturamento.ResultadoCamparacaoAliquotaEcf(FieldByName( 'ECF_PERALQ' ).AsFloat, fltAliquota) Then
        Begin
          Result := True;
          Break;
        End;

        Next;
      End;

    End;

  Finally
    FreeAndNil(qryTmpEcf);
  End;
end;

initialization
  EnableUniSQL := False;
  FLock := TTrackedCriticalSection.Create('Faturamento.Connections.Functions.FLock');
  FCacheMyCampoTabela := TDictionary<string, IMyCampoTabela>.Create;
  FCacheTabelaExiste := TDictionary<string, Boolean>.Create;
  FCacheCampoExiste := TDictionary<string, Boolean>.Create;
finalization
  FreeAndNil(FLock);
  FreeAndNil(FCacheMyCampoTabela);
  FreeAndNil(FCacheTabelaExiste);
  FreeAndNil(FCacheCampoExiste);
end.

