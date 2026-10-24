unit untValidaCaracteres;

interface

uses System.Character, System.SysUtils;

Type
  TTipoCharValida = set of(tcvLetra, tcvNumero, tcvSimbolo);

  TValidaCaracteres = class
  private
    FLetra,
    FNumero,
    FSimbolo: Boolean;
    procedure pValidaCaracteresIndividuais(ATexto: String);
    procedure pMotivo(Var AStrFalha: String);
  public
    class function fValida(TipoCharValida: TTipoCharValida; Texto: String; var strFalha: string): Boolean;
  end;

implementation

{ TValidaCaracteres }

class function TValidaCaracteres.fValida(TipoCharValida: TTipoCharValida; Texto: String; var strFalha: string): Boolean;
  var ValidaCaracteres : TValidaCaracteres;
begin
  ValidaCaracteres := TValidaCaracteres.Create;
  Try
    ValidaCaracteres.FLetra  := Not(tcvLetra in TipoCharValida);
    ValidaCaracteres.FNumero := Not(tcvNumero in TipoCharValida);
    ValidaCaracteres.FSimbolo:= Not(tcvSimbolo in TipoCharValida);
    ValidaCaracteres.pValidaCaracteresIndividuais(Texto);
    Result := ValidaCaracteres.FLetra and ValidaCaracteres.FNumero and ValidaCaracteres.FSimbolo;
    //Se Não validar escreve o motivo
    If Not Result Then
      ValidaCaracteres.pMotivo(strFalha);
  Finally
    FreeAndNil(ValidaCaracteres);
  End;
end;

procedure TValidaCaracteres.pMotivo(var AStrFalha: String);
begin
  if (not FLetra) And (Not FNumero) And (Not FSimbolo) Then
    AStrFalha := 'É preciso informar letra, número e caracter especial'
  Else
  begin
    AStrFalha := 'É preciso informar ';
    If Not FLetra Then
      AStrFalha := AStrFalha  + 'letra e ';
    If Not FNumero Then
      AStrFalha := AStrFalha  + 'número e ';
    If Not FSimbolo Then
      AStrFalha := AStrFalha  + 'caracter especial e ';
    AStrFalha := Copy(AStrFalha, 0, Length(AStrFalha) -3) + '.';
  End;
end;

procedure TValidaCaracteres.pValidaCaracteresIndividuais(ATexto: String);
  var
    Index: integer;
begin
  For Index := 1 To Length(ATexto) do
  Begin
    If Not FLetra   Then FLetra := ATexto[Index].IsLetter;
    If Not FNumero  Then FNumero := ATexto[Index].IsNumber;
    If Not FSimbolo Then FSimbolo := (Not ATexto[Index].IsLetter) And (Not ATexto[Index].IsNumber);
  End;

end;

end.
