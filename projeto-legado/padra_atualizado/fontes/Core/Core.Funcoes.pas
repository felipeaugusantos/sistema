unit Core.Funcoes;

interface

uses System.SysUtils, System.StrUtils, Data.DB, IdHashMessageDigest, System.IniFiles,
  System.Classes;

type
  TCoreFuncoes = class
  public
    class procedure pSetaClient(cdsClient: TDataSet);
    class function fEmptyStr(strString : String; blnTiraCaracEspecial: Boolean = False) : Boolean;
    class function fTiraCaracEspeciais(strTexto      : String;
                                       blnUsaLista   : Boolean = True;
                                       blnTiraEspacos: Boolean = False;
                                       blnTiraPontos : Boolean = False;
                                       blnTiraDoisPts: Boolean = False;
                                       blnTiraTab    : Boolean = False;
                                       blnTiraVirgula: Boolean = True;
                                       blnTiraAbreviacaoNumero: Boolean = False;
                                       strCaracterePersonalizado: String = ''): String;
    class function fTiraEnter(strTexto: String): String;
    class function fTiraEspacos(strTexto: String): String;
    class function fTrocaCaracter(strTexto: String; chrFrom, chrTo: Char): String;
    class function GetMD5(const strTexto: string): string;
    class function fArqIniLocal(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String; strNomArq: String = ''): String;
    class procedure pAddFieldDefs(Client: TDataSet; Name: string; DataType: TFieldType; Size: Integer); overload;
    class procedure pAddFieldDefs(Client: TDataSet; Name: string; DataType: TFieldType); overload;
  end;

implementation

class function TCoreFuncoes.fArqIniLocal(ReadWrite: Integer; NomChave, NomSecao,
  Conteudo, strNomArq: String): String;
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

class function TCoreFuncoes.fEmptyStr(strString: String;
  blnTiraCaracEspecial: Boolean): Boolean;
begin
  Result := False;

  If strString.IsEmpty Then
    Exit(True);

  If blnTiraCaracEspecial Then
    strString := fTiraCaracEspeciais(strString, True, True, True, True, True);

  strString := fTiraEnter(strString);

  If fTiraEspacos(strString) <> '' Then
    Exit;
  
  Result := True;
end;

class function TCoreFuncoes.fTiraCaracEspeciais(strTexto: String; blnUsaLista,
  blnTiraEspacos, blnTiraPontos, blnTiraDoisPts, blnTiraTab,
  blnTiraVirgula: Boolean; blnTiraAbreviacaoNumero: Boolean;
  strCaracterePersonalizado: String): String;
  Var
    strLista: String;
    intContador: Integer;
    intPosicao: Integer;
    strCaracNorm: String;
    strCaracEsp: String;
begin
  If blnUsaLista Then
    strLista := '/\-_+#,;<>|*ªº°&"''()%$¨@!?§={}[]´`^~¹²³£¢Ø¡'
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

  If (blnTiraAbreviacaoNumero) Then
    strLista := strLista + 'º°';

  If (Not fEmptyStr(strCaracterePersonalizado)) Then
    strLista := strLista + strCaracterePersonalizado;

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

class function TCoreFuncoes.fTiraEnter(strTexto: String): String;
begin
  Result := strTexto;
  Result := fTrocaCaracter(Result, #13, ' ');
  Result := fTrocaCaracter(Result, #10, ' ');
  Result := Trim(Result);
end;

class function TCoreFuncoes.fTiraEspacos(strTexto: String): String;
begin
  Result := fTrocaCaracter(strTexto, ' ', #0);
end;

class function TCoreFuncoes.fTrocaCaracter(strTexto: String; chrFrom,
  chrTo: Char): String;
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

class function TCoreFuncoes.GetMD5(const strTexto: string): string;
  var
    idHash128: TIdHashMessageDigest5;
begin
  idHash128 := TIdHashMessageDigest5.Create;
  Try
    Result := idHash128.HashStringAsHex(strTexto);
  Finally
    FreeAndNil(idHash128);
  End;
end;

class procedure TCoreFuncoes.pAddFieldDefs(Client: TDataSet; Name: string; DataType: TFieldType;
  Size: Integer);
var
  intCount: Integer;
Begin
  Client.FieldDefs.AddFieldDef;
  intCount := Client.FieldDefs.Count -1;
  Client.FieldDefs[intCount].Name        := Name;
  Client.FieldDefs[intCount].DataType    := DataType;
  Client.FieldDefs[intCount].Size        := Size;
end;

class procedure TCoreFuncoes.pAddFieldDefs(Client: TDataSet; Name: string;
  DataType: TFieldType);
var
  intCount: Integer;
Begin
  Client.FieldDefs.AddFieldDef;
  intCount := Client.FieldDefs.Count -1;
  Client.FieldDefs[intCount].Name        := Name;
  Client.FieldDefs[intCount].DataType    := DataType;
end;

class procedure TCoreFuncoes.pSetaClient(cdsClient: TDataSet);
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

end.
