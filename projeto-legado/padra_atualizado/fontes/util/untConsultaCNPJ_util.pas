{************************************************************************}
{* Funções utilizadas na consulta do CNPJ no portal da Receita Federal. *}
{* Adaptado do projeto ACBr (https://projetoacbr.com.br)                *}
{* ACBrConsultaCNPJ, ACBrSocket e ACBrUtil                              *}
{************************************************************************}

unit untConsultaCNPJ_util;

interface

uses
  Classes, SysUtils, StrUtils;

function fFindInList(SL: TStringList; search: String): String;
procedure pRemoveEmptyLines(SL: TStringList);
function fIsAbsoluteURL(const URL: String): Boolean;
function fGetUrlBasePath(const URL: String): String;
function fLerCampo(Texto: TStringList; NomeCampo: String): String;
function fStripHTML(const AHTMLString: String): String;
function fVerificaErros(const str: String): String;

implementation

{ Busca e retorna um elemento da lista }
function fFindInList(SL: TStringList; search: String): String;
  Var
    s: String;
begin
  Result := '';
  For s In SL Do
  Begin
    If Pos(search, s) > 0 Then
    Begin
      Result := Trim(Copy(s, Length(search) +1, Length(s)));
      Exit;
    End;
  End;
end;

{ Remove linhas em branco da lista }
procedure pRemoveEmptyLines(SL: TStringList);
  Var
    i: Integer;
begin
  For i := SL.Count -1 DownTo 0 Do
  Begin
    If Trim(SL[i]) = '' Then
      SL.Delete(i);
  End;
end;

{ Valida se a url é absoluta (false se relativa) }
function fIsAbsoluteURL(const URL: String): Boolean;
  Const
    protocolos: Array[0..2] Of String = ('http','https','ftp');
  Var
    i: Integer;
begin
  Result := False;
  If Pos('//', URL) = 1 Then
  Begin
    Result := True;
    Exit;
  End;

  If Pos('/', URL) = 1 Then
  Begin
    Result := False;
    Exit;
  End;

  If Pos('www.', URL) = 1 Then
  Begin
    Result := True;
    Exit;
  End;

  For i := Low(protocolos) To High(protocolos) Do
  Begin
    If Pos(AnsiUpperCase(protocolos[i]) +'://', AnsiUpperCase(URL)) = 1 Then
    Begin
      Result := True;
      Exit;
    End;
  End;
end;

{ Retorna a url base }
function fGetUrlBasePath(const URL: String): String;
begin
  Result := Copy(URL, 1, LastDelimiter('/', URL));
end;

{ Retorna e remove um elemento da lista }
function fLerCampo(Texto: TStringList; NomeCampo: String): String;
  Var
    i: Integer;
    linha: String;
begin
  Result := '';
  For i := 0 To Texto.Count -1 Do
  Begin
    linha := Trim(Texto[i]);
    If AnsiUpperCase(linha) = AnsiUpperCase(NomeCampo) Then
    Begin
      Result := StringReplace(Trim(Texto[i+1]), '&nbsp;', ' ', [rfReplaceAll]);
      Texto.Delete(i);
      Break;
    End;
  End;

  Result := AnsiReplaceStr(Result, '*', '');
end;

{ Localiza uma Tag dentro de uma string, iniciando a busca em PosIni.               }
{ Se encontrar uma Tag, retorna a mesma em ATag, e a posição inicial dela em PosTag }
procedure fAcharProximaTag(const ABinaryString: AnsiString;
  const PostIni: Integer; var ATag: AnsiString; var PosTag: Integer);
  Var
    PosTagAux, FimTag, LenTag: Integer;
begin
  ATag := '';
  PosTag := PosEx('<', String(ABinaryString), PostIni);

  If PosTag > 0 Then
  Begin
    PosTagAux := PosEx('<', String(ABinaryString), PosTag +1); //verificando se a tag é inválida
    FimTag    := PosEx('>', String(ABinaryString), PosTag +1);
    If FimTag = 0 Then  //tag não fechada?
    Begin
      PosTag := 0;
      Exit;
    End;

    While (PosTagAux > 0) And (PosTagAux < FimTag) Do //achou duas aberturas, ex: <<e>
    Begin
      PosTag    := PosTagAux;
      PosTagAux := PosEx('<', String(ABinaryString), PosTag +1);
    End;

    LenTag := FimTag - PosTag +1;
    ATag   := AnsiString(AnsiLowerCase(Copy(String(ABinaryString), PosTag, LenTag)));
  end;
end;

{ Remove todas as TAGS de HTML de uma string, retornando a string alterada }
function fStripHTML(const AHTMLString: String): String;
  Var
    ATag, VHTMLString: AnsiString;
    PosTag, LenTag: Integer;
begin
  VHTMLString := AnsiString(AHTMLString);
  ATag   := '';
  PosTag := 0;

  fAcharProximaTag(VHTMLString, 1, ATag, PosTag);
  While ATag <> '' Do
  Begin
    LenTag := Length(ATag);
    Delete(VHTMLString, PosTag, LenTag);

    ATag := '';
    fAcharProximaTag(VHTMLString, PosTag, ATag, PosTag);
  End;

  Result := String(VHTMLString);
end;

{ Trata e retorna possíveis erros na consulta do CNPJ }
function fVerificaErros(const str: String): String;
begin
  Result := '';

  If Pos('Imagem com os caracteres anti robô', str) > 0 Then
  Begin
    Result := 'O captcha digitado está incorreto, tente novamente.';
    Exit;
  End;

  If Pos('Erro na Consulta', str) > 0 Then
  Begin
    Result := 'Erro na consulta, atualize o captcha e tente novamente.';
    Exit;
  End;

  If Pos('Não existe no Cadastro de Pessoas Jurídicas o número de CNPJ informado', str) > 0 Then
  Begin
    Result := 'Não existe no Cadastro de Pessoas Jurídicas o número de CNPJ informado.'+ sLineBreak +
              'Verifique se o mesmo foi digitado corretamente e tente novamente.';
    Exit;
  End;

  If Pos('No momento não podemos atender a sua solicitação', str) > 0 Then
  Begin
    Result := 'Erro no site da Receita Federal. Por favor, tente novamente mais tarde.';
    Exit;
  End;
end;

end.
