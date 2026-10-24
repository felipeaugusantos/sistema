unit Shared.Core;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, System.Classes, untTypesSistema,
  untDicionarioResultadoQuerySimples,
{$ELSE }
  untFuncoesSimples, UniClientDataSet, cxProgressBar,
  Shared.Functions.Conexao.UniDac,
{$ENDIF LINUX}
  Uni, Math, Data.DB,
  Shared.Functions.Core, Faturamento.Connections.Functions,
  Faturamento.Interfaces.Conexao, Shared.Functions.DataSet, Core.Funcoes,
  System.SysUtils, Shared.Functions.Types, Shared.Functions.Configuracoes;

type
  TFunctionsCore = class(TInterfacedObject, IFunctionsCore)
  private
    function fCriarQuery(const ASQL: String): TUniQuery; overload;
  public
    function fCampoTabela(arrCampos: Array Of String;
                          strNomTab: String;
                          arrCampoChave: Array Of String;
                          arrValorChave: Array Of Variant;
                          blnSempreLerBanco: Boolean = True;
                          strOrderBy: String = '';
                          blnUsarMax: Boolean = False): IMyCampoTabela;
    function fCampoTabelaDados(ASQL: String; AParametros: ArrOfString; AValores: ArrOfVariant): IMyCampoTabela; overload;
    function fCampoTabelaDados(ASQL: String): IMyCampoTabela; overload;
    function fCampoExiste(const strTabela, strCampo: String; const blnUsarCache : Boolean = False): Boolean;
    function fTabelaExiste(const ANomeTabela: String; const blnUsarCache : Boolean = False) : Boolean;
    function RetornarTamanhoDoCampoNumeroDoDocumento: Integer;
    function fTemAliqEcf(fltAliquota: Double; const strPatIni: String): Boolean;
    function fMskDigitos(intDigitos: Integer): String;
    function fCriarQuery(): IMyQuery; overload;
    function fFormataFloat(fltNumero: Double; intDecimais: Integer): Double;
    function fStrToFloat(strValor: String): Double; overload;
    function fStrToFloat(strValorUnico: String; fltDefault: Real): Double; overload;
    function IfThen(lTest: Boolean; vExpr1, vExpr2: Double): Double;
    function fEmptyStr(strString: String; blnTiraCaracEspecial: Boolean): Boolean;
    function IIF(lTest:Boolean; vExpr1,vExpr2:Variant):Variant;
    function fRetAutoIncrem(strNomeTabela, strCodEmp : String) : String;
    function fCodigoDaEmpresa : String;
    function fRetPrecisaoMargemItem: Integer;
    function fArqIni(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String; strNomArq: String = ''):String;
    function fFloatToSQL(fltValor: Double): String;
    function IfFloatZero(fltValor, fltDefault: Double): Double;
    class function New(): IFunctionsCore;
  end;

 {$IFDEF LINUX}
  function fArqIni(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String; strNomArq: String = ''):String;

  function fTamCodIte: Integer;

  function fCriaQuery(AOwner: TComponent = nil): TUniQuery; overload;
  function fCriaQuery(AOwner: TComponent; AConnection: TUniConnection): TUniQuery; overload;
  function fCriarQuery(ASQL: string; AOwner: TComponent = nil): TUniQuery;

  procedure pMensagensErro(AMsg, ALocal: string);
  procedure pMensagemOk(AMsg: string);

  function fPergunta(strMensagem: String; blnDefSim: Boolean = True): Boolean;

  function fMensagem(strTitulo: String; strTexto: String; arrOpcoes: Array Of String; intFocoBotao: Integer = 1): Integer;
  function fMensagemTabela(strTitulo: String; strTitCol: String; arrMensagem: TStringArray; strTexto: String; arrOpcoes: Array Of String; intFocoBotao: Integer = 1): Integer;

  function fChamaTelaGravando(fExecutarAcao: TFunctionFormGravando; strTitulo: String = ''): Boolean;

  function fExecutarModal(const prcGen: TGenericProcedure; const strTexto, strChave: string): Boolean; overload;
  function fExecutarModal(const prcGen: TReferenceProcedure; const strTexto, strChave: string): Boolean; overload;

  procedure pInfoStatusGravacao(pgbStatus: TcxProgressBar; strInformacao: String; intMax: Integer = 0);
  procedure pStepStatusGravacao(pgbStatus: TcxProgressBar; strInformacao: String='');

  procedure pInformacao(strInfo: String; pgbStatus: TcxProgressBar);
  procedure pProgresso(intProgresso: Integer; intMaximo: Integer; pgbStatus: TcxProgressBar);

  function ExecutarQueryEmCache(qryGen: TUniQuery): IMyCampoTabela;
 {$ENDIF}

implementation

{ TFunctionsCore }


function TFunctionsCore.fCampoExiste(const strTabela, strCampo: String; const blnUsarCache : Boolean = False): Boolean;
begin
  result := fCampoExisteFat(strTabela, strCampo, objConexao.Conexao, blnUsarCache);
end;

function TFunctionsCore.fCampoTabela(arrCampos: Array of String;
  strNomTab: String; arrCampoChave: Array of String;
  arrValorChave: Array of Variant; blnSempreLerBanco: Boolean = True;
  strOrderBy: String = ''; blnUsarMax: Boolean = False): IMyCampoTabela;
var
  LConexao: TUniConnection;
begin
  LConexao := objConexao.Conexao;

  Result := fCampoTabelaArray(arrCampos,
                              strNomTab,
                              arrCampoChave,
                              arrValorChave,
                              blnSempreLerBanco,
                              strOrderBy,
                              LConexao,
                              blnUsarMax);
end;

function TFunctionsCore.fCampoTabelaDados(ASQL: String): IMyCampoTabela;
var
  LQuery: TUniQuery;
begin
  LQuery := fCriarQuery(ASQL);
  Try
    Result := ExecutarQueryEmCache(LQuery);
  Finally
    FreeAndNil(LQuery);
  End;
end;

function TFunctionsCore.fCriarQuery: IMyQuery;
begin
  Result := objDataSet.CreateQuery;
end;

function TFunctionsCore.fCriarQuery(const ASQL: String): TUniQuery;
begin
  Result := fCriaQueryFat(Nil, objConexao.Conexao);
  If Assigned(Result.Connection) Then
    Result.Tag := Result.Connection.Tag;
  Result.SQL.Clear;
  Result.SQL.Add(ASQL);
end;

function TFunctionsCore.fCampoTabelaDados(ASQL: String;
  AParametros: ArrOfString; AValores: ArrOfVariant): IMyCampoTabela;
var
  LQuery: TUniQuery;
  LContador: Integer;
begin
  LQuery := fCriarQuery(ASQL);

  Try
    for LContador := 0 to Length(AParametros) - 1 do
      LQuery.ParamByName(String(AParametros[LContador])).Value := AValores[LContador];

    Result := ExecutarQueryEmCache(LQuery);
  Finally
    FreeAndNil(LQuery);
  End;
end;

function TFunctionsCore.fFormataFloat(fltNumero: Double;
  intDecimais: Integer): Double;
begin
{$IFDEF LINUX}
  Result := Services.Core.Utils.fFormataFloat(fltNumero, intDecimais);
{$ELSE}
  Result := untFuncoesSimples.fFormataFloat(fltNumero, intDecimais);
{$ENDIF}
end;

function TFunctionsCore.fStrToFloat(strValor: String): Double;
begin
{$IFDEF LINUX}
  Result := Services.Core.Utils.fStrToFloat(strValor);
{$ELSE}
  Result := untFuncoesSimples.fStrToFloat(strValor);
{$ENDIF}
end;

function TFunctionsCore.fTabelaExiste(const ANomeTabela: String; const blnUsarCache : Boolean = False): Boolean;
begin
  result := fTabelaExisteFat(ANomeTabela, objConexao.Conexao, blnUsarCache);
end;

function TFunctionsCore.fTemAliqEcf(fltAliquota: Double;
  const strPatIni: String): Boolean;
var
  LConexao: TUniConnection;
begin
  LConexao := objConexao.Conexao;

  Result := fTemAliqEcfFat(fltAliquota, strPatIni, LConexao);
end;

class function TFunctionsCore.New: IFunctionsCore;
begin
  Result := Self.Create;
end;

function TFunctionsCore.RetornarTamanhoDoCampoNumeroDoDocumento: Integer;
begin
  Result := RetornarTamanhoDoCampoNumeroDoDocumentoFat(objConexao.Conexao);
end;

function TFunctionsCore.IfFloatZero(fltValor, fltDefault: Double): Double;
begin
{$IFDEF LINUX}
  Result := Services.Core.Utils.IfFloatZero(fltValor, fltDefault);
{$ELSE}
  Result := untFuncoesSimples.IfFloatZero(fltValor, fltDefault);
{$ENDIF}
end;

function TFunctionsCore.fFloatToSQL(fltValor: Double): String;
begin
{$IFDEF LINUX}
  Result := Services.Core.Utils.fFloatToSQL(fltValor);
{$ELSE}
  Result := untFuncoesSimples.fFloatToSQL(fltValor);
{$ENDIF}
end;

function TFunctionsCore.fMskDigitos(intDigitos: Integer): String;
begin
{$IFDEF LINUX}
  Result := Services.Core.Utils.fMskDigitos(intDigitos);
{$ELSE}
  Result := untFuncoesSimples.fMskDigitos(intDigitos);
{$ENDIF}
end;

function TFunctionsCore.fRetAutoIncrem(strNomeTabela, strCodEmp : String): String;
begin
{$IFDEF LINUX}
  Result := Services.Core.Connection.Manager.fRetAutoIncrem(strNomeTabela, strCodEmp);
{$ELSE}
  Result := untFuncoesSimples.fRetAutoIncrem(strNomeTabela, strCodEmp);
{$ENDIF}
end;

function TFunctionsCore.fRetPrecisaoMargemItem: Integer;
begin
{$IFDEF LINUX}
  Result := Services.Core.Connection.Manager.fRetPrecisaoMargemItem;
{$ELSE}
  Result := untFuncoesSimples.fRetPrecisaoMargemItem;
{$ENDIF}
end;

function TFunctionsCore.fStrToFloat(strValorUnico: String;
  fltDefault: real): Double;
begin
{$IFDEF LINUX}
  Result := Services.Core.Utils.fStrToFloat(strValorUnico, fltDefault);
{$ELSE}
  Result := untFuncoesSimples.fStrToFloat(strValorUnico, fltDefault);
{$ENDIF}
end;

function TFunctionsCore.IfThen(lTest: Boolean; vExpr1, vExpr2: Double): Double;
begin
  Result := System.Math.IfThen(lTest, vExpr1, vExpr2);
end;

function TFunctionsCore.IIF(lTest: Boolean; vExpr1, vExpr2: Variant): Variant;
begin
{$IFDEF LINUX}
  Result := Services.Core.Utils.IIF(lTest, vExpr1, vExpr2);
{$ELSE}
  Result := untFuncoesSimples.IIF(lTest, vExpr1, vExpr2);
{$ENDIF}
end;

function TFunctionsCore.fArqIni(ReadWrite: Integer; NomChave, NomSecao, Conteudo,
  strNomArq: String): String;
begin
{$IFDEF LINUX}
  If Services.Core.Utils.fEmptyStr(strNomArq) Then
    strNomArq := Services.Core.Settings.GetIniFile;
  case ReadWrite of
    0:
      Services.Core.Settings.ReadIniFile(NomSecao, NomChave, Conteudo,
        strNomArq);
    1:
      Services.Core.Settings.WriteIniFile(NomSecao, NomChave, Conteudo,
        strNomArq);
  end;
{$ELSE}
  Result := untFuncoesSimples.fArqIni(ReadWrite, NomChave, NomSecao, Conteudo,strNomArq);
{$ENDIF}
end;

function TFunctionsCore.fCodigoDaEmpresa: String;
begin
{$IFDEF LINUX}
  Result := Services.Core.Settings.VS_strCodEmp;
{$ELSE}
  Result := untFuncoesSimples.VS_strCodEmp;
{$ENDIF}
end;

function TFunctionsCore.fEmptyStr(strString: String;
  blnTiraCaracEspecial: Boolean): Boolean;
begin
  Result := TCoreFuncoes.fEmptyStr(strString, blnTiraCaracEspecial);
end;

{$IFDEF LINUX}
function fArqIni(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String; strNomArq: String = ''):String;
begin
  If (fEmptyStr(strNomArq)) Then
    strNomArq := GetIniFile;
  Case ReadWrite of
    0: Result := ReadIniFile(NomChave,NomSecao,Conteudo, strNomArq);
    1: Result := WriteIniFile(NomChave,NomSecao,Conteudo, strNomArq);
  End;
end;

function fCriaQuery(AOwner: TComponent = nil): TUniQuery;
begin
  Result := TUniQuery(Services.Core.Connection.Manager.fCriaQueryObject(AOwner));
end;

function fCriaQuery(AOwner: TComponent; AConnection: TUniConnection): TUniQuery;
var
  LQuery: TUniQuery;
begin
  if AConnection = nil then
  begin
    Result := fCriaQuery(AOwner);
    Exit;
  end;
  LQuery := TUniQuery.Create(AOwner);
  LQuery.Connection := AConnection;
  LQuery.Options.RequiredFields := False;
  LQuery.Tag := AConnection.Tag;
  Result := LQuery;
end;

function fCriarQuery(ASQL: string; AOwner: TComponent): TUniQuery;
Var
  intCont: Integer;
begin
  Result := TUniQuery(Services.Core.Connection.Manager.fCriaQueryObject(AOwner));
  Result.SQL.Add(ASQL);
  Result.Open;
  Result.Close;
  For intCont := 0 To Result.FieldDefs.Count - 1 Do
    Result.FieldDefs[intCont].CreateField(Result);
end;

function fTamCodIte: Integer;
begin
  Result := Services.Core.Connection.Manager.fTamCodIte;
end;

procedure pMensagensErro(AMsg, ALocal: string);
var
  LMsg: string;
  LTrace: string;
begin
  LMsg := Format('%s - [%s]', [AMsg, ALocal]);
  LTrace := GetStackTrace;
  WriteLog(LMsg);
  WriteLog(LTrace);
  pGravarErro(True, LMsg, LTrace);
  Raise Exception.Create(LMsg);
end;

procedure pMensagemOk(AMsg: string);
begin
  WriteLog(AMsg);
end;

function fPergunta(strMensagem: String; blnDefSim: Boolean = True): Boolean; Overload;
Begin
  Result := fMensagem('', strMensagem, ['&Sim', '&Não'], IIF(blnDefSim, 1, 2)) = 1;
End;

procedure pInfoStatusGravacao(pgbStatus: TcxProgressBar; strInformacao: String; intMax: Integer = 0);
begin
  if strInformacao <> '' then
    WriteLog(strInformacao);
end;

procedure pStepStatusGravacao(pgbStatus: TcxProgressBar; strInformacao: String='');
begin
  if strInformacao <> '' then
    WriteLog(strInformacao);
end;

function fMensagemTabela(strTitulo: String; strTitCol: String; arrMensagem: TStringArray; strTexto: String; arrOpcoes: Array Of String; intFocoBotao: Integer = 1): Integer;
var
  intPosicao: Integer;
begin
  If (Length(arrOpcoes) = 2)   And
     (Trim(arrOpcoes[0]) = '') And
     (Trim(arrOpcoes[1]) = '') Then
  Begin
    arrOpcoes[0] := '&Sim';
    arrOpcoes[1] := '&Não';
  End;

  WriteLog(StringOfChar('-', 100));
  WriteLog(strTitulo);
  WriteLog(StringOfChar('-', 100));
  WriteLog(strTexto);
  WriteLog(StringOfChar('-', 100));

  for intPosicao := 0 to Length( arrOpcoes )-1 do
    if Succ(intPosicao) = intFocoBotao then
      WriteLog('[   ] ' + strTexto)
    else
      WriteLog('[ X ] ' + strTexto);

  WriteLog(StringOfChar('-', 100));

  Result := intFocoBotao;
end;

function fMensagem(strTitulo: String; strTexto: String; arrOpcoes:
  Array Of String; intFocoBotao: Integer = 1): Integer;
var
  intPosicao: Integer;
begin
  If (Length(arrOpcoes) = 2)   And
     (Trim(arrOpcoes[0]) = '') And
     (Trim(arrOpcoes[1]) = '') Then
  Begin
    arrOpcoes[0] := '&Sim';
    arrOpcoes[1] := '&Não';
  End;

  WriteLog(StringOfChar('-', 100));
  WriteLog(strTitulo);
  WriteLog(StringOfChar('-', 100));
  WriteLog(strTexto);
  WriteLog(StringOfChar('-', 100));

  for intPosicao := 0 to Length( arrOpcoes )-1 do
    if Succ(intPosicao) = intFocoBotao then
      WriteLog('[   ] ' + strTexto)
    else
      WriteLog('[ X ] ' + strTexto);

  WriteLog(StringOfChar('-', 100));

  Result := intFocoBotao;
end;

function fChamaTelaGravando(fExecutarAcao: TFunctionFormGravando; strTitulo: String = ''): Boolean;
begin
  WriteLog(strTitulo);
  Result := fExecutarAcao(nil);
end;

function fExecutarModal(const prcGen: TGenericProcedure; const strTexto, strChave: string): Boolean; overload;
begin
  WriteLog(strTexto);
  prcGen();
  Result := True;
end;

function fExecutarModal(const prcGen: TReferenceProcedure; const strTexto, strChave: string): Boolean; overload;
begin
  WriteLog(strTexto);
  prcGen();
  Result := True;
end;

function ExecutarQueryEmCache(qryGen: TUniQuery): IMyCampoTabela;
begin
  Result := fAdicionaResultadoICampoTabela(TDicResultadoQuerySimples.fExecQueryCampos(qryGen));
end;

procedure pInformacao(strInfo: String; pgbStatus: TcxProgressBar);
begin
  if strInfo <> '' then
    WriteLog(strInfo);
end;

procedure pProgresso(intProgresso: Integer; intMaximo: Integer; pgbStatus: TcxProgressBar);
begin
  //do nothing
end;

{$ENDIF}

initialization

SetObjCore(TFunctionsCore.New());

end.
