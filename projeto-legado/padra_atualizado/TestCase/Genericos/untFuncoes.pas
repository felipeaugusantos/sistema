unit untFuncoes;

interface
{$WARN SYMBOL_PLATFORM OFF}

Uses
  Classes, Uni, Controls, SysUtils, StrUtils, Forms, Windows,
  IniFiles, Graphics, Messages, Dialogs, Buttons, StdCtrls, DBCtrls,
  Mask, DB, Consts, DBClient, untPrincipal,
  Aurelius.Types.Nullable, untICfgSis,

  Variants, ExtCtrls, ComCtrls, MMSystem,
  Grids, Menus, Math,
  RLTypes, DateUtils, MaskUtils, Contnrs, TypInfo,

  UniClientDataSet,
  Types, UniDataSetProvider, IdHashMessageDigest;


Type
  TObjectVariant = Class(TObject)
    varValor: Variant;
  public
    Constructor Create(valor: Variant);
  End;

  TDicionario = class
    private
      lstChaves: TStringList;
      lstValores: TObjectList;
    protected
      function BuscaChave(strChave: String): Integer;
    public
      constructor Create;
      destructor Destroy; override;
      procedure Adicionar(strChave: String; Valor: Variant);
      procedure AdicionarObjeto(strChave: String; Valor: TObject);
      procedure Remove(strChave: String);
      procedure Limpar;
      procedure LimparObjetos;
      function Retorna(strChave: String): Variant;
      function RetornaObjeto(strChave: String): TObject;

      function Chaves: TStringList;

      property Items[Index: String]: Variant read Retorna write Adicionar; default;
End;

Type
  TDicResultadoQuerySimples = class
    private
      FResultados: TDicionario;
      class var Finstance: TDicResultadoQuerySimples;
      function GetKey(qry: TUniQuery): String;
      function GetResult(Index: TUniQuery): Variant;
      procedure SetResult(Index: TUniQuery; const Value: Variant);
      constructor Create;
    public
      Destructor Destroy; override;
      class function fGetInstance(): TDicResultadoQuerySimples;
      class procedure Limpar;
      class function fExecQuery(qryExec: TUniQuery): Variant;
  end;


Type
  TCfgSis = class(TInterfacedObject, ICfgSis)
  public
    function fICfgSis(strCamCfg: String; varTipVar: TVarType = varString; strCodEmp: String = ''): Variant;
  end;

  function fGetValorConfiguracao(strCamCfg: String; varTipVar: TVarType = varString; strCodEmp: String = ''): Variant;

  function fTiraCaracEspeciaisPonto(strTexto: String): String;

  procedure pExecutarProgresso(ACount, AAtual : Integer);

  function IIF(lTest:Boolean; vExpr1,vExpr2:Variant):Variant; overload;
  function IIF(lTest:Boolean; vExpr1,vExpr2:Nullable<String>):String; overload;
  function IIF(lTest:Boolean; vExpr1,vExpr2:Nullable<Integer>):Integer; overload;



  function fTiraCaracEspeciais(strTexto      : String;
                               blnUsaLista   : Boolean = True;
                               blnTiraEspacos: Boolean = False;
                               blnTiraPontos : Boolean = False;
                               blnTiraDoisPts: Boolean = False;
                               blnTiraTab    : Boolean = False;
                               blnTiraVirgula: Boolean = True): String;

  function fStrZero(Zeros:string;Quant:integer):String; overload;
  function fStrZero(Zeros:Integer;Quant:integer):String; overload;
  function fStrZero(Zeros:Int64; Quant:integer): String; overload;
  function fStrZero(Zeros: Nullable<Integer>;Quant:integer):String; overload;
  function fStrZero(Zeros: Nullable<String>;Quant:integer):String; overload;

  Function fRetEmpresaMatrizDoGrupo(strCodEmp: String): String;

	function fCrypt(strSenha: String): String;
  function fCfgSis(strCamCfg: String; varTipVar: TVarType = varString; strCodEmp: String = '') : Variant;
  function fCfgSisL(strCamCfg: String;  varTipVar: TVarType = varString; strCodEmp: String = '';
                     dicCfgSis: TDicionario = Nil): Variant;
//  function fAtuCfgSis(strCamCfg: String; strValCfg: String; strCodEmp: String = ''; segConex: TUniConnection = Nil) : Boolean;
	function fstrEspaco(Str:String;Tamanho:Integer;intPos:Integer = 1):String;
	function fDecrypt(strSenha: String): String;
  function fStrToFloat(strValorUnico: String; fltDefault : real = 0): Double;
  function fCriaQuery(AOwner: TComponent = Nil; Conexao: TUniConnection = nil): TUniQuery;
  function fArqIni(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String; strNomArq: String = ''):String;


  function fTiraEnter(strTexto: String): String;
  function fTiraEspacos(strTexto: String): String;
  function fTrocaCaracter(strTexto: String; chrFrom, chrTo: Char): String;

  function fEmptyStr(strString : String; blnTiraCaracEspecial: Boolean = False) : Boolean;

  {*****************************************}
  {* VERIFICA OS DIREITOS ESPECIFICOS      *}
  {**************************************AF*}


  function fArqIniLocal(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String; strNomArq: String = ''):String;
  function fCriarQuery(strSQL: String; AOwner: TComponent = nil): TUniQuery;

  function fRetornarNomeEmpresa(strCodEmp : String) : String;

  function fCampoTabela(strCampo : String;
                        strNomTab: String;
                        arrCampoChave: Array Of String;
                        arrValorChave: Array Of Variant;
                        blnSempreLerBanco: Boolean = True;
                        strOrderBy: String = '';
                        Conexao: TUniConnection = Nil;
                        blnUsarMax: Boolean = False): Variant;

  Procedure pSetaClient(cdsClient: TDataSet);
  function fTransform(strConteudo: String; intStep: Shortint; strChar: String = '_'): String;

  function RetonarIndexOpcoesSelecionadas(AOpcao : String) : Integer;

  function fFormataFloat(fltNumero: Double; intDecimais: Integer): Double;
  function fFormataFloatInterna(fltNumero: Double; intDecimais: Integer): Double;
  function fRoundFiveUp(fltValue: Double; intDigits: Integer): Double;
  function ValidarClienteFilial(const ACodigoCliente, AClientesFiliais: string): Boolean;
  function AjustarValorString(const AValor: string): string;
  function CompararValores(const AValor1, AValor2: double; const ADigitos: integer = 2; const APercentualDiferenca: String = '0,01'): boolean;
  function fMskDigitos(intDigitos: Integer): String;
  function fExisteMovICD(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
  function fRetornarLimiteRegistros : String;
  function GetMD5(const strTexto: string): string;
  function fTamNumDoc: Integer;
  Function fCodificaChaveNota(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodFor: String): String;
  Procedure pDecodificaChaveNota(strChave: String; Var strNumDoc, strEspDoc, strCodEmp, strSerie, strCodFor: String);
  function ValidarPararProcessamento: boolean;

  function Empty(const AValue, AValueDefault: String): String;

  Const
    STR_CHAR_SENHA = 'ABCDEFGHIJKLMNOPQRSTUVWYXZ 1234567890/:_*#';
    CONS_CHAVES_CRIPT: String = 'CFG_CITPSP;CFG_SENPDS';
    CFG_VALIDAR_IMG: String = 'CFG_PATLOG_';
  Var

  dicConfiguracoes: TDicionario;


implementation

uses  System.UITypes, untModulo;


{ TUltConsultas }
Function fCodificaChaveNota(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodFor: String): String;
Begin
  Result := strNumDoc + strEspDoc + strCodEmp + fstrEspaco(strSerie, 3) + strCodFor;
End;


function fstrEspaco(Str:String;Tamanho:Integer;intPos:Integer = 1):String;
Var
	I:integer;
Begin
  Case intPos Of
  	1:For I := Length(Str) To Tamanho -1 Do
		  	Str:= Str + ' ';
    2:For I := Length(Str) To Tamanho -1 Do
    		Str := ' ' + Str;
  End;
  fStrEspaco := Str;
End;

{*****************************}
{* DESCRIPTA UMA STRING      *}
{**************************DV*}
function fDecrypt(strSenha: String): String;
	Var
  	intCol,intCl1 : Integer;
begin
  Result := '';
  If fEmptyStr(strSenha) Then
  	Result := fstrEspaco(strSenha,Length(strSenha));

  For intCol := Length(strSenha) Downto 1 Do
  Begin
  	intCl1 := Pos(MidStr(strSenha,intCol,1),'‘’›œž¨­àáâãäåæçèéêëìíîïðñþò÷üôøýöùúûÅÀ£#');
    Result := Result + MidStr(STR_CHAR_SENHA, intCl1,1);
  End;
end;

{************************************}
{* TRANSFORMA STRING PARA DOUBLE    *}
{* QUANDO USAVA (S)TRTOFLOAT EM UM     *}
{* VALOR DE MILHAR EX 1.005,23      *}
{* OCORRIA ERRO POR CAUSA DO .      *}
{*********************************AF*}
function fStrToFloat(strValorUnico: String; fltDefault : real = 0): Double;
Begin
  Result := strToFloatDef(AnsiReplaceStr(strValorUnico,'.',''),fltDefault);
End;


function fTrocaCaracter(strTexto: String; chrFrom, chrTo: Char): String;
  Var
    c: Char;
begin
  Result := '';
  for c in strTexto do
    if (c <> chrFrom) then
      Result := Result + c
    Else If chrTo <> #0 Then
      Result := Result + chrTo;
end;

function fTiraEnter(strTexto: String): String;
begin
  Result := strTexto;
  Result := fTrocaCaracter(Result, #13, ' ');
  Result := fTrocaCaracter(Result, #10, ' ');
  Result := Trim(Result);
end;

function fTiraEspacos(strTexto: String): String;
begin
  Result := fTrocaCaracter(strTexto, ' ', #0);
end;

{**************************************}
{*  VERIFICA SE UMA STRING ESTA VAZIA *}
{***********************************MV*}
function fEmptyStr(strString : String; blnTiraCaracEspecial: Boolean = False) : Boolean;
begin
  If blnTiraCaracEspecial Then
    strString := fTiraCaracEspeciais(strString, True, True, True, True, True);

  Result := False;
  strString := fTiraEnter(strString);

  If fTiraEspacos(strString) = '' Then
    Result := True;
end;

{**************************************}
{* CRIA UMA QUERYNOVA PARA SER USADA  *}
{* PS. ATE QUE ENFIM ALGUEM FEZ ISSO  *}
{***********************************AF*}
function fCriaQuery(AOwner: TComponent = Nil; Conexao: TUniConnection = nil): TUniQuery;
Begin

  Result := TUniQuery.Create(AOwner);

  If Assigned(Conexao) Then
    Result.Connection := Conexao
  Else
    Result.Connection := frmModulo.Database;

  Result.Options.RequiredFields := False;

End;

{**********************************************************}
{* Lê/Grava dados no arquivo de Configuracao (Opcoes.ini) *}
{*******************************************************DV*}
function fArqIni(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String; strNomArq: String = ''):String;
	Var
		iniArqIni : TIniFile;
begin
  If (fEmptyStr(strNomArq)) Then
    strNomArq := 'opcoes.ini';

  iniArqIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + strNomArq);
  Try
    Case ReadWrite of
	    0: Result := iniArqIni.ReadString(NomChave,NomSecao,Conteudo);
	    1: iniArqIni.WriteString(NomChave,NomSecao,Conteudo);
    End;
  Finally
	  iniArqIni.Free;
  End;
end;


{**********************************************************}
{* Lê/Grava dados no arquivo de Configuracao Local        *}
{*******************************************************MA*}
function fArqIniLocal(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String; strNomArq: String = ''):String;
	Var
		iniArqIni : TIniFile;
begin
  If (fEmptyStr(strNomArq)) Then
    strNomArq := 'opcoes_local.ini';

  iniArqIni := TIniFile.Create(strNomArq);
  Try
    Case ReadWrite of
	    0: Result := iniArqIni.ReadString(NomChave,NomSecao,Conteudo);
	    1: iniArqIni.WriteString(NomChave,NomSecao,Conteudo);
    End;
  Finally
	  iniArqIni.Free;
  End;
end;


{*****************************}
{* CRIPTA UMA STRING         *}
{**************************DV*}
function fCrypt(strSenha: String): String;
	Var
  	intCol,intCl1 : Integer;
begin
	Result := '';
  If fEmptyStr(strSenha) Then
  	Result := fstrEspaco(strSenha,Length(strSenha));

  For intCol := Length(strSenha) Downto 1 Do
  Begin
  	intCl1 := Pos(MidStr(strSenha,intCol,1), STR_CHAR_SENHA);
    Result := Result + MidStr('‘’›œž¨­àáâãäåæçèéêëìíîïðñþò÷üôøýöùúûÅÀ£#',intCl1,1);
  End;
end;

Function fRetEmpresaMatrizDoGrupo(strCodEmp: String): String;
Begin
  Result := fCampoTabela('EMP_CODMAT', 'CADEMP', ['EMP_CODEMP'], [strCodEmp]);
End;

{***************************************}
{* Insere Zeros à frente de uma string *}
{************************************DV*}
function fStrZero(Zeros:string;Quant:integer):String;
Var
	I,Tamanho:integer;
	Aux: string;
begin
  Tamanho := Length(Zeros);
  Aux := Zeros;
  Zeros:='';
  For I := 1 To Tamanho Do
	If Aux[i] <> ',' Then
	  Zeros := Zeros + Aux[i];

  Tamanho := Length(Zeros);
  Aux := Zeros;
  Zeros:='';
  for I:=1 to Quant-Tamanho do
  Zeros:=Zeros + '0';
  Aux := Zeros + Aux;
  fStrZero := Aux;
end;

{***************************************}
{* Insere Zeros à frente de uma string *}
{************************************MA*}
function fStrZero(Zeros:Integer;Quant:integer):String;
begin
  fStrZero := fStrZero(IntToStr(Zeros),Quant);
end;

function fStrZero(Zeros:Int64; Quant:integer): String;
begin
  fStrZero := fStrZero(IntToStr(Zeros),Quant);
end;

function fStrZero(Zeros: Nullable<Integer>;Quant:integer):String;
  Var
    intAux: Integer;
Begin
  If Zeros.HasValue Then intAux := Zeros.Value
  Else intAux := 0;
  Result := fStrZero(IntToStr(intAux),Quant);
End;

function fStrZero(Zeros: Nullable<String>;Quant:integer):String;
  Var
    strAux: String;
Begin
  If Zeros.HasValue Then strAux := Zeros.Value
  Else strAux := '0';
  Result := fStrZero(strAux,Quant);
End;

function fGetValorConfiguracao(strCamCfg: String; varTipVar: TVarType = varString; strCodEmp: String = ''): Variant;
begin
  Result := fCfgSis(strCamCfg, varTipVar, frmModulo.FCodEmp);
end;

function fTiraCaracEspeciaisPonto(strTexto: String): String;
  Var
    strLista: String;
    intContador: Integer;
    intPosicao: Integer;
    strCaracNorm: String;
    strCaracEsp: String;
begin
  strLista := '/\-_+#,;<>():.';

  strCaracNorm := 'aeiouaeiouaeiouaoaeiouAEIOUAEIOUAEIOUAOAEIOU';
  strCaracEsp  := 'àèìòùáéíóúâêîôûãõäëïöüÀÈÌÒÙÁÉÍÓÚÂÊÎÔÛÃÕÄËÏÖÜ';

  Result := '';
  For intContador := 1 To Length(strTexto) Do
  Begin
    intPosicao := Pos(strTexto[intContador], strCaracEsp);
    If intPosicao > 0 Then
      Result := Result + strCaracNorm[intPosicao]

    Else If Pos(strTexto[intContador], strLista) <= 0 Then
      Result := Result + strTexto[intContador];

  End;

end;

function IIF(lTest:Boolean; vExpr1,vExpr2:Variant):Variant;
begin
   if lTest then
     Result := vExpr1
   else
     Result := vExpr2
end;

function IIF(lTest:Boolean; vExpr1,vExpr2:Nullable<String>):String;
Begin

  If lTest then
  Begin
    If vExpr1.HasValue Then Result := vExpr1
    Else Result := '';
  End
  Else
  Begin
    If vExpr2.HasValue Then Result := vExpr2
    Else Result := '';
  End;

End;

function IIF(lTest:Boolean; vExpr1,vExpr2:Nullable<Integer>):Integer;
Begin

  If lTest then
  Begin
    If vExpr1.HasValue Then Result := vExpr1
    Else Result := 0;
  End
  Else
  Begin
    If vExpr2.HasValue Then Result := vExpr2
    Else Result := 0;
  End;

End;

{*****************************************}
{* RETIRA CARACTERES ESPECIAIS DE UMA    *}
{* STRING                                *}
{**************************************MV*}
function fTiraCaracEspeciais(strTexto      : String;
                             blnUsaLista   : Boolean = True;
                             blnTiraEspacos: Boolean = False;
                             blnTiraPontos : Boolean = False;
                             blnTiraDoisPts: Boolean = False;
                             blnTiraTab    : Boolean = False;
                             blnTiraVirgula: Boolean = True): String;
  Var
    strLista: String;
    intContador: Integer;
    intPosicao: Integer;
    strCaracNorm: String;
    strCaracEsp: String;
begin
  If blnUsaLista Then
    strLista := '/\-_+#,;<>|*ªº°&"''()%$¨@!?§={}[]´`^~¹²³£¢Ø'
  Else
    strLista := EmptyStr;

  If (blnTiraEspacos) Then
    strLista := strLista + ' ';

  If (blnTiraPontos) Then
    strLista := strLista + '.';

  If (blnTiraDoisPts) Then
    strLista := strLista + ':';

  If (blnTiraTab) Then
    strLista := strLista + #9;

  If (Not blnTiraVirgula) Then
    strLista := AnsiReplaceStr(strLista, ',', '');

  strCaracNorm := 'aeiouaeiouaeiouaoaeioucAEIOUAEIOUAEIOUAOAEIOUC';
  strCaracEsp  := 'àèìòùáéíóúâêîôûãõäëïöüçÀÈÌÒÙÁÉÍÓÚÂÊÎÔÛÃÕÄËÏÖÜÇ';

  Result := '';
  For intContador := 1 To Length(strTexto) Do
  Begin
    intPosicao := Pos(strTexto[intContador], strCaracEsp);
    If intPosicao > 0 Then
      Result := Result + strCaracNorm[intPosicao]

    Else If Pos(strTexto[intContador], strLista) <= 0 Then
      Result := Result + strTexto[intContador];

  End;

end;

function fRetPathSeImagemValida(strPathImg: String): String;
  Var
   Img: TImage;
begin
  Result := strPathImg;

  If (Not fEmptyStr(Result)) And (FileExists(Result)) Then
  Begin
    Try
      Img := TImage.Create(Nil);
      Try
        Img.Picture.LoadFromFile(strPathImg);
      Finally
        FreeAndNil(Img);
      End;
    Except
      Result := '';
    End;
  End;
end;

function fCfgSisL(strCamCfg: String;  varTipVar: TVarType = varString; strCodEmp: String = '';
                  dicCfgSis: TDicionario = Nil): Variant;
  Var
    qryGenCfg: TUniQuery;
    strValCfg: String;
    strSQL   : String;
    strRes   : String;
    strAux   : String;
begin
  Try
    qryGenCfg := Nil;

    If Not fEmptyStr(strCamCfg) Then
    Begin

      If (Not Assigned(dicCfgSis)) Or (dicCfgSis[strCamCfg + strCodEmp] = Null) Then
      Begin
        qryGenCfg := fCriaQuery;

        strSQL := '';
        strSQL := strSQL + ' SELECT  SQL_NO_CACHE       ';
        strSQL := strSQL + '   SIS_CODCFG,              ';
        strSQL := strSQL + '   SIS_VALCFG              ';
        strSQL := strSQL + ' FROM                       ';
        strSQL := strSQL + '   CFGSIS                   ';
        strSQL := strSQL + ' WHERE                      ';
        strSQL := strSQL + '   SIS_CODEMP = :CODEMP AND ';
        strSQL := strSQL + '   SIS_CODCFG = :CODCFG     ';

        With qryGenCfg Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);

          ParamByName('CODEMP').Value := strCodEmp;
          ParamByName('CODCFG').Value := 'CFG_' + strCamCfg;
          Open;

          If IsEmpty Then
          Begin
            Close;
            Open;
          End;

          {**********************************************************}
          {* VALIDAÇÃO PARA TESTAR SE JÁ É UMA CHAVE CRIPTROGRAFADA *}
          {********************************************************VA}
          strRes := FieldByName('SIS_VALCFG').AsString;

          If Pos(FieldByName('SIS_CODCFG').AsString, CONS_CHAVES_CRIPT) > 0 Then
          Begin
            strAux:=fDecrypt(strRes);

            If fCrypt(strAux) = strRes Then
              strRes := fDecrypt(strRes)
          End
          Else If Pos(FieldByName('SIS_CODCFG').AsString, CFG_VALIDAR_IMG) > 0 Then
          Begin
            strRes := fRetPathSeImagemValida(strRes);
          End;

          If Assigned(dicCfgSis) Then
          Begin
            dicCfgSis[strCamCfg + strCodEmp] := strRes;
          End;

        End;
      End;

      If Assigned(dicCfgSis) Then
        strValCfg := dicCfgSis[strCamCfg + strCodEmp]
      Else
        strValCfg := strRes;

      Case varTipVar Of
        varString : Result := strValCfg;

        varInteger, varSmallint, varSingle, varByte, varShortInt, varInt64:
                    Begin
                      Try
                        If fEmptyStr(strValCfg) Then
                          Result := 0
                        Else
                          Result := strToInt(strValCfg);
                      Except
                        Result := 0;
                      End;
                    End;

        varDouble, varCurrency:
                    Begin
                      Try
                        If fEmptyStr(strValCfg) Then
                          Result := 0.00
                        Else
                          Result := fStrToFloat(AnsiReplaceStr(strValCfg, '.', ','));
                      Except
                        Result := 0.00;
                      End;
                    End;

        varDate:
                    Begin
                      Try
                        If fEmptyStr(strValCfg) Then
                          Result := 0
                        Else
                          Result := strToDate(strValCfg);
                      Except
                        Result := 0;
                      End;
                    End;

        varBoolean:
                   Begin
                     Try
                       If fEmptyStr(strValCfg) Then
                         Result := False
                       Else If Pos(strValCfg, 'S_N_') > 0 Then
                         Result := StrToBool(IfThen(strValCfg = 'S', 'True', 'False'))

                       Else If Pos(strValCfg, '0_1_') > 0  Then
                         Result := StrToBool(IfThen(strValCfg = '1', 'True', 'False'))
                       Else
                         Result := (Length(strValCfg) > 0) And CharInSet(strValCfg[1], ['T', 't', 'Y', 'y']);

                     Except
                       Result := False;
                     End;

                   End;

        Else
          Result := strValCfg;

      End;

    End;

  Finally
    If Assigned(qryGenCfg) Then
      FreeAndNil(qryGenCfg);
  End;

end;


function fCfgSis(strCamCfg: String; varTipVar: TVarType = varString; strCodEmp: String = ''): Variant;
Begin
  If SameText('EMPMAT', strCamCfg) Then
  Begin
    Result := '';

    If fCfgSisL('INFMAT', varBoolean) Then
      Result := fRetEmpresaMatrizDoGrupo(strCodEmp);

    If fEmptyStr(Result) Then
      Result := fCfgSisL(strCamCfg, varTipVar, strCodEmp, dicConfiguracoes);

  End

  Else If Pos(strCamCfg, 'CFG_ATPVMB-CFG_ATPVM2-CFG_ATPVM3-CFG_ATPVM4-CFG_ATPVM5-CFG_ATPVM6-CFG_ATPVM7-CFG_VENMAR') > 0 Then
  Begin

    If fCfgSisL('BLOPRE', varBoolean, strCodEmp, dicConfiguracoes) Then
    begin

      If Pos(strCamCfg, 'CFG_ATPVMB-CFG_ATPVM2-CFG_ATPVM3-CFG_ATPVM4-CFG_ATPVM5-CFG_ATPVM6-CFG_ATPVM7') > 0 Then
        Result := 'M'
      Else
        Result := 2;

    End Else
    Begin

      Result := fCfgSisL(strCamCfg, varTipVar, strCodEmp, dicConfiguracoes);

    End;

  End Else
  Begin
    Result := fCfgSisL(strCamCfg, varTipVar, strCodEmp, dicConfiguracoes);

    If SameText('CORZEB', strCamCfg) And fEmptyStr(Result) Then
      Result := clWhite;
  End;
End;

//function fAtuCfgSis(strCamCfg: String; strValCfg: String; strCodEmp: String = ''; segConex: TUniConnection = Nil) : Boolean;
//  Var
//    qryGenCfg: TUniQuery;
//
//begin
//  Try
//    Result := True;
//
//    If Not fEmptyStr(strCamCfg) Then
//    Begin
//      qryGenCfg := fCriaQuery(Nil, segConex);
//
//      With qryGenCfg Do
//      Begin
//        Close;
//        SQL.Clear;
//        SQL.Add('UPDATE                     ');
//        SQL.Add('  CFGSIS                   ');
//        SQL.Add('SET                        ');
//        SQL.Add('  SIS_VALCFG = :VALCFG     ');
//        SQL.Add('WHERE                      ');
//        SQL.Add('  SIS_CODEMP = :CODEMP AND ');
//        SQL.Add('  SIS_CODCFG = :CODCFG     ');
//
//        Try
//          ParamByName('CODEMP').Value := strCodEmp;
//          ParamByName('CODCFG').Value := 'CFG_' + strCamCfg;
//          ParamByName('VALCFG').Value := strValCfg;
//
//          ExecSQL;
//        Except
//          On E: Exception Do
//          Begin
//            Raise Exception.Create('Não consegui atualizar o proximo sequencial de ' + strCamCfg + ' em CFGSIS. Tente novamente!');
//          End;
//        End;
//
//      End;
//
//    End;
//
//  Finally
//    FreeAndNil(qryGenCfg);
//  End;
//
//end;


{ TDicionario }

procedure TDicionario.Adicionar(strChave: String; Valor: Variant);
  Var
    intPos: Integer;
begin
  intPos := BuscaChave(strChave);

  If intPos = -1 Then
  Begin
    lstChaves.Add(strChave);
    lstValores.Add(TObjectVariant.Create(Valor));
  End
  Else
    lstValores[intPos] := TObjectVariant.Create(Valor);
end;

procedure TDicionario.AdicionarObjeto(strChave: String; Valor: TObject);
  Var
    intPos: Integer;
begin
  intPos := BuscaChave(strChave);

  If intPos = -1 Then
  Begin
    lstChaves.Add(strChave);
    lstValores.Add(Valor);
  End
  Else
  Begin
    lstValores[intPos] := Valor;
  End;
end;

function TDicionario.BuscaChave(strChave: String): Integer;
  Var
    intContador: Integer;
begin

  Result := -1;

  For intContador := 0 To lstChaves.Count -1 Do
  Begin
    If (lstChaves[intContador] = strChave) Then
    Begin
      Result := intContador;
      Break;
    End;
  End;
end;

constructor TDicionario.Create;
begin
  inherited Create;

  lstChaves  := TStringList.Create;
  lstValores := TObjectList.Create(False);
end;

destructor TDicionario.Destroy;
begin
  Limpar;

  FreeAndNil(lstChaves);
  FreeAndNil(lstValores);

  inherited;
end;

procedure TDicionario.Limpar;
  Var
    intCont: Integer;
    obj: TObject;
begin
  For intCont := 0 To lstValores.Count -1 Do
  Begin
    If Assigned(lstValores[intCont]) And
      (lstValores[intCont] Is TObjectVariant) Then
    Begin
      obj := lstValores[intCont];
      FreeAndNil(obj);
    End;
  End;

  lstChaves.Clear;
  lstValores.Clear;
end;

procedure TDicionario.LimparObjetos;
  Var
    intObj: Integer;
begin
  For intObj := 0 To lstChaves.Count -1 Do
  Begin
    If Assigned(RetornaObjeto(lstChaves[intObj])) Then
      TObject(RetornaObjeto(lstChaves[intObj])).Destroy;
    lstValores[intObj] := nil;
  End;
end;

procedure TDicionario.Remove(strChave: String);
  Var
    intPos: Integer;
begin

  intPos := BuscaChave(strChave);
  If (intPos > -1) Then
  Begin
    lstChaves.Delete(intPos);
    lstValores.Delete(intPos);
  End;

end;

function TDicionario.Retorna(strChave: String): Variant;
  Var
    intPos: Integer;
begin
  Result := Null;
  intPos := BuscaChave(strChave);

  If intPos > -1 Then
    Result := TObjectVariant(lstValores[intPos]).varValor;
end;

function TDicionario.RetornaObjeto(strChave: String): TObject;
  Var
    intPos: Integer;
begin

  Result := Nil;
  intPos := BuscaChave(strChave);

  If intPos > -1 Then
  Begin
    Result := lstValores[intPos];
  End;
end;

function TDicionario.Chaves: TStringList;
begin
  Result := lstChaves;
end;

{ TDicResultadoQuerySimples }

constructor TDicResultadoQuerySimples.Create;
begin
  FResultados := TDicionario.Create;
end;

destructor TDicResultadoQuerySimples.Destroy;
begin
  FreeAndNil(FResultados);
  inherited;
end;

class function TDicResultadoQuerySimples.fExecQuery(qryExec: TUniQuery): Variant;
Var
  objDic: TDicResultadoQuerySimples;
begin
  objDic := fGetInstance();

  If objDic.FResultados.Chaves.IndexOf(objDic.GetKey(qryExec)) > -1 Then
  Begin
    Result := objDic.GetResult(qryExec);
  End
  Else
  Begin
    With qryExec Do
    Begin
      Open;
      Result := Fields[0].Value;

      Case Fields[0].DataType Of
        ftString : Result := Fields[0].AsString;
        ftMemo   : Result := Fields[0].AsString;
        ftFloat  : Result := Fields[0].AsFloat;
        ftInteger: Result := Fields[0].AsInteger;
        ftBoolean: Result := Fields[0].AsBoolean;
        ftDate   : Result := Fields[0].AsDateTime;
        ftTime   : Result := Fields[0].AsDateTime;
      End;

      objDic.SetResult(qryExec, Result);
      Close;
    End;
  End;
end;

class function TDicResultadoQuerySimples.fGetInstance: TDicResultadoQuerySimples;
begin
  if Not Assigned(Finstance) Then
    Finstance := TDicResultadoQuerySimples.Create();

  Result := Finstance;
end;

function TDicResultadoQuerySimples.GetKey(qry: TUniQuery): String;
  Var
    i: Integer;
begin
  Result := qry.SQL.Text;
  For i := 0 To qry.ParamCount -1 Do
    Result := AnsiReplaceStr(Result, ':' + qry.Params[i].Name, qry.Params[i].AsString);
 // Result := GetMD5(Result);
end;

function TDicResultadoQuerySimples.GetResult(Index: TUniQuery): Variant;
begin
  Result := FResultados[GetKey(Index)];
end;

class procedure TDicResultadoQuerySimples.Limpar;
begin
  fGetInstance().FResultados.Limpar;
end;

procedure TDicResultadoQuerySimples.SetResult(Index: TUniQuery; const Value: Variant);
begin
  FResultados[GetKey(Index)] := Value;
end;



function fTiraCaracEspeciaisParenteses(strTexto: String): String;
  Var
    strLista: String;
    intContador: Integer;
    intPosicao: Integer;
    strCaracNorm: String;
    strCaracEsp: String;
begin
  strLista := '/\-_+#,;<>():';

  strCaracNorm := 'aeiouaeiouaeiouaoaeiouAEIOUAEIOUAEIOUAOAEIOU';
  strCaracEsp  := 'àèìòùáéíóúâêîôûãõäëïöüÀÈÌÒÙÁÉÍÓÚÂÊÎÔÛÃÕÄËÏÖÜ';

  Result := '';
  For intContador := 1 To Length(strTexto) Do
  Begin
    intPosicao := Pos(strTexto[intContador], strCaracEsp);
    If intPosicao > 0 Then
      Result := Result + strCaracNorm[intPosicao]

    Else If Pos(strTexto[intContador], strLista) <= 0 Then
      Result := Result + strTexto[intContador];

  End;

end;

function IfNull(varValor, varDefault: Variant): Variant;
begin
	Result := varValor;
	If (Result = Null) Then
		Result := varDefault;
end;

function IfEmptyStr(strValor, strDefault: String): String;
begin
  Result := strValor;
  If fEmptyStr(Result) Then
    Result := strDefault;
end;

{*********************************************}
{* FUNCAO PARA CRIAR QUERY E RETER OS CAMPOS *}
{******************************************PH*}
function fCriarQuery(strSQL: String; AOwner: TComponent = nil): TUniQuery;
  Var
    intCont: Integer;
begin
  Result := fCriaQuery(AOwner);
  Result.SQL.Text := strSQL;
  Result.Open;
  Result.Close;

  For intCont := 0 To Result.FieldDefs.Count - 1 Do
  Begin
    Result.FieldDefs[intCont].CreateField(Result);
  End;
end;


function fRetornarNomeEmpresa(strCodEmp : String) : String;
Var
  qryGen: TUniQuery;
Begin
  Try
    qryGen := fCriaQuery(Nil);
    qryGen.SQL.Text := 'SELECT EMP_NOMFAN '+
                       '  FROM CADEMP '+
                       ' WHERE EMP_CODEMP = :CODEMP ';
    qryGen.ParamByName('CODEMP').AsString := strCodEmp;
    qryGen.Open;

    Result := qryGen.Fields[0].AsString;
  Finally
    FreeAndNil(qryGen);
  End;

end;

function fCampoTabela(strCampo : String;
                      strNomTab: String;
                      arrCampoChave: Array Of String;
                      arrValorChave: Array Of Variant;
                      blnSempreLerBanco: Boolean = True;
                      strOrderBy: String = '';
                      Conexao: TUniConnection = Nil;
                      blnUsarMax: Boolean = False): Variant;
  Const
    arrParms : Array [0..11] Of String[1] = ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L');

  Var
    intCont  : Integer;
    strSQL   : String;
    qryGenGer: TUniQuery;
Begin
  Try
    qryGenGer := fCriaQuery(nil, Conexao);

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';

    if blnUsarMax then
    begin
      strSQL := strSQL + '  MAX(' + strCampo + ') ';
    end
    else
    begin
    strSQL := strSQL + '  ' + strCampo + ' ';
    end;

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ' + strNomTab + ' ';
    strSQL := strSQL + 'WHERE ';

    For intCont := 0 To Length(arrCampoChave) -1 Do
    Begin
      If Pos('<>', arrCampoChave[intCont]) > 0 Then
        strSQL := strSQL + '  ' + arrCampoChave[intCont] + ' :' + String(arrParms[intCont]) + ' AND '
      Else
        strSQL := strSQL + '  ' + arrCampoChave[intCont] + ' = :' + String(arrParms[intCont]) + ' AND ';
    End;

    strSQL := strSQL + '  TRUE  ';

    If Not fEmptyStr(strOrderBy) Then
      strSQL := strSQL + ' ORDER BY ' + strOrderBy;

    strSQL := strSQL + ' LIMIT 1 ';

    With qryGenGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      For intCont := 0 To Length(arrCampoChave) -1 Do
        ParamByName(String(arrParms[intCont])).Value := arrValorChave[intCont];


      If (Not blnSempreLerBanco) Then
      Begin
        Result := TDicResultadoQuerySimples.fExecQuery(qryGenGer);
      End
      Else
      Begin
        Open;

        Result := Fields[0].Value;

        {*******************************************}
        {* EXECUTA UM CAST PARA NAO RETORNAR NULL  *}
        {****************************************JC*}
        Case Fields[0].DataType Of
          ftString : Result := Fields[0].AsString;
          ftMemo   : Result := Fields[0].AsString;
          ftFloat  : Result := Fields[0].AsFloat;
          ftInteger: Result := Fields[0].AsInteger;
          ftBoolean: Result := Fields[0].AsBoolean;
          ftDate   : Result := Fields[0].AsDateTime;
          ftTime   : Result := Fields[0].AsDateTime;
        End;
      End;

    End;

  Except
    On E: Exception Do
    Begin
      ShowMessage('Ocorreu o seguinte erro ao executar a função "fCampoTabela" :' +#13#10 + E.Message);
    End;
  End;

  FreeAndNil(qryGenGer);

End;


procedure pExecutarProgresso(ACount, AAtual : Integer);
begin
  Principal.gProcesso.MinValue := 0;
  Principal.gProcesso.MaxValue := ACount;
  Principal.gProcesso.Progress := AAtual;

  If (ACount = AAtual) Then
    Principal.gProcesso.Progress := 0;

  Application.ProcessMessages;
end;


{ TObjectVariant }
constructor TObjectVariant.Create(valor: Variant);
begin
  varValor := valor;
end;


function fExecutaValCfg(strSQL, strEmp: String): String;
  Var
    qryTemp: TUniQuery;
begin
  qryTemp := fCriaQuery(Nil);
  If Pos('CFGSIS',strSQL) > 0 Then
  Begin
    qryTemp.SQL.Add(strSQL + ' AND SIS_CODEMP = :CODEMP');
    qryTemp.ParamByName('CODEMP').AsString := strEmp;
  End Else
  Begin
    qryTemp.SQL.Add(strSQL);
  End;

  qryTemp.Open;
  Result := qryTemp.Fields[0].AsString;
  qryTemp.Close;
  FreeAndNil(qryTemp);
end;

{ TCfgSis }

function TCfgSis.fICfgSis(strCamCfg: String; varTipVar: TVarType; strCodEmp: String): Variant;
begin
  Result := fCfgSis(strCamCfg, varTipVar, strCodEmp);
end;


function RetonarIndexOpcoesSelecionadas(AOpcao : String) : Integer;
begin
  Result := AnsiIndexStr(AOpcao , ['IPI', 'ICMSST', 'ICMSEFETIVO', 'DIFALFCP', 'CFOP', 'PRECOCUSTO', 'MARGEMVENDA']);
end;


Procedure pSetaClient(cdsClient: TDataSet);
  Var
    intContador: Integer;
Begin
  With cdsClient Do
  For intContador := 0 To Fields.Count - 1 Do
  Begin
    If Fields[intContador].ReadOnly Then
      Fields[intContador].ProviderFlags := Fields[intContador].ProviderFlags - [pfInWhere, pfInUpdate];
    Fields[intContador].ReadOnly := False;
    Fields[intContador].Required := False;
  End;
End;

function fFormataFloat(fltNumero: Double; intDecimais: Integer): Double;
begin
  Result := fFormataFloatInterna(fltNumero, intDecimais);
end;

function ValidarClienteFilial(const ACodigoCliente, AClientesFiliais: string): Boolean;
begin
  Result := Pos(ACodigoCliente, AClientesFiliais) > 0;
end;

function fRoundFiveUp(fltValue: Double; intDigits: Integer): Double;
var
  intDig: Integer;
  strVal: String;
  i : Integer;
begin

  strVal := FloatToStr(fltValue);
  intDig := Pos({$IF Defined(VER250) Or Defined(VER270) OR Defined(VER280) OR Defined(VER300)} FormatSettings.DecimalSeparator {$ELSE} DecimalSeparator {$IFEND}, strVal);

  If intDig > 0 Then
    intDig := Length(MidStr(strVal, intDig + 1, Length(strVal) - intDig));

  for i := 1 to (intDig - intDigits) do
  begin

    If (intDig > 0) And (intDig > intDigits) And (strVal[Length(strVal)] = '5') Then
    Begin
      strVal[Length(strVal)] := '6';
    End;

    strVal := FloatToStr(fStrToFloat(FloatToStrF(fStrToFloat(strVal), ffFixed, 12, intDig - i)));

  End;

  Result := fStrToFloat(strVal);

end;

function fFormataFloatInterna(fltNumero: Double; intDecimais: Integer): Double;
  Var
    intDig: Integer;
    strVal: String;
begin
  strVal := FloatToStr(fltNumero);

  {*******************************}
  {* SE O VALOR POSSUIR DECIMAIS *}
  {****************************JC*}
  If Pos(FormatSettings.DecimalSeparator, strVal) > 0 Then
  Begin
    intDig := Length(strVal) - Pos(FormatSettings.DecimalSeparator, strVal);

    {*********************************************************************************}
    {* SUBSTITUI O ULTIMO DIGITO DE "5" PARA "6" FORCANDO O ARREDONDAMENTO PARA CIMA *}
    {******************************************************************************JC*}
    If (intDig > 0) And (intDig > intDecimais) And (strVal[Length(strVal)] = '5') Then
    Begin
      strVal[Length(strVal)] := '6';
    End;
  End;

  {************************************************************}
  {* CONTINUA FORMATANDO IGUAL ERA COM A FUNCAO fFormataFloat *}
  {*********************************************************JC*}
  Result := fStrToFloat(FloatToStrF(fStrToFloat(strVal), ffFixed, 12, intDecimais));
end;

function AjustarValorString(const AValor: string): string;
begin
  result := AnsiReplaceStr(AValor, ',', '.');
end;

{*****************************************}
{* RETORNA MASCARA PARA A FUNÇÃO         *}
{* 'FormatFloat'                         *}
{**************************************MV*}
function fMskDigitos(intDigitos: Integer): String;
  Var
    intContador: Integer;
    strMsk1, strMsk2: String;
begin
  strMsk1 := '#,##';
  strMsk2 := '0.';

  If (intDigitos = 0) Then
    intDigitos := 2;

  For intContador := 1 To intDigitos Do
  Begin
    strMsk2 := strMsk2 + '0';
  End;

  Result := strMsk1 + strMsk2;

end;

function CompararValores(const AValor1, AValor2: double; const ADigitos: integer = 2; const APercentualDiferenca: String = '0,01'): boolean;
var
  LValor1Formatado: Double;
  LValor2Formatado: Double;
  LValor1: string;
  LValor2: string;
  LDiferenca: Double;
begin
  LValor1Formatado := fRoundFiveUp(AValor1, ADigitos);
  LValor2Formatado := fRoundFiveUp(AValor2, ADigitos);

  LValor1 := FormatFloat(fMskDigitos(ADigitos), LValor1Formatado);
  LValor2 := FormatFloat(fMskDigitos(ADigitos), LValor2Formatado);

  LValor1Formatado := fStrToFloat(LValor1);
  LValor2Formatado := fStrToFloat(LValor2);

  LDiferenca := fRoundFiveUp(Abs(fRoundFiveUp(LValor1Formatado, ADigitos) - fRoundFiveUp(LValor2Formatado, ADigitos)), ADigitos);
  result := LDiferenca <= fStrToFloat(APercentualDiferenca);
end;

function fRetornarLimiteRegistros: String;
Var
  LQuantidade: String;
begin
  Result := '';

  LQuantidade := fArqIni(0,'GERAL','QUANTIDADE_MAXIMA_DE_REGISTROS_PROCESSAR','');

  If LQuantidade <> '' Then
    Result := ' LIMIT ' + LQuantidade;
end;


function fExisteMovICD(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
Var
  strSQL: String;
  qryAux: TUniQuery;
begin
  Try
    qryAux := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ICD_PERFCP FROM MOVICD ';
    strSQL := strSQL + 'INNER JOIN MOVDET ON MOVICD.ICD_SEQGER = MOVDET.AUTOINCREM ';
    strSQL := strSQL + 'WHERE DET_NUMDOC = :NUMDOC ';
    strSQL := strSQL + '  AND DET_ESPDOC = :ESPDOC ';
    strSQL := strSQL + '  AND DET_CODEMP = :CODEMP ';
    strSQL := strSQL + 'LIMIT 1 ';

    With qryAux Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;
      Result := (FieldByName('ICD_PERFCP').AsFloat > 0);
      Close;
    End;

  Finally
    FreeAndNil(qryAux);
  End;
end;

function fTransform(strConteudo: String; intStep: Shortint; strChar: String = '_'): String;
  Var
    strAux       : String;
    intPosicao   : Integer;
begin
  strAux := '';

  intPosicao := 1;
  While intPosicao < Length(strConteudo) Do
  Begin
    strAux := strAux + Copy(strConteudo, intPosicao, intStep) + strChar;
    Inc(intPosicao, intStep);
  End;

  Result := strAux;
end;

function GetMD5(const strTexto: string): string;
var
  idHash128: TIdHashMessageDigest5;
begin
  Try
    Try
      idHash128 := TIdHashMessageDigest5.Create;
      Result := idHash128.HashStringAsHex(strTexto);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(idHash128) then FreeAndNil(idHash128);
  End;
end;

function fTamNumDoc: Integer;
var qryAux: TUniQuery;
Begin
  Result := 6;
  qryAux := fCriaQuery();
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
End;

Procedure pDecodificaChaveNota(strChave: String; Var strNumDoc, strEspDoc, strCodEmp, strSerie, strCodFor: String);
  Var
    intTamNumDoc: Integer;
Begin
  intTamNumDoc := fTamNumDoc;
  strNumDoc := LeftStr(strChave, intTamNumDoc);
  strSerie  := Trim(Copy(strChave, intTamNumDoc + 6, 3));
  strCodFor := RightStr(strChave, 8);
  strCodEmp := Copy(strChave, intTamNumDoc + 3, 3);
  strEspDoc := Copy(strChave, intTamNumDoc + 1, 2);
End;

function Empty(const AValue, AValueDefault: String): String;
begin
  If (AValue = EmptyStr) Then
  Begin
    Result := AValueDefault;
    Exit;
  End;

  Result := AValue;
end;

function ValidarPararProcessamento: boolean;
begin
  result := frmModulo.FPararProcessamento;
end;

initialization
  EnableUniSQL := False;
  dicConfiguracoes := TDicionario.Create;
finalization
  FreeAndNil(dicConfiguracoes);
end.

