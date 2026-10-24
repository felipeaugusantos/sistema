unit untLiberacaoFactory;

interface

Uses untILiberacao, System.Classes;

  Procedure pSetLiberacao(objLiberacao : ILiberacao); stdcall;

Type
  TLiberacaoFactory = Class
  Private
    Class var Liberacao : ILiberacao;
  Public
    Class Procedure pSetLiberacao(objLiberacao : ILiberacao);
    Class Function fGetLiberacao : ILiberacao;
  End;

implementation


Procedure pSetLiberacao(objLiberacao : ILiberacao);
Begin
  TLiberacaoFactory.pSetLiberacao(objLiberacao);
End;

{ TLiberacaoFactory }

class function TLiberacaoFactory.fGetLiberacao: ILiberacao;
var
  LiberacaoClass: TClass;
  objLiberacao: TObject;
begin
  If Not Assigned(Liberacao) Then
  Begin
    LiberacaoClass := FindClass('TLiberacao');
    objLiberacao := LiberacaoClass.Create;
    If objLiberacao.GetInterfaceEntry(ILiberacao) <> nil Then
    begin
      objLiberacao.GetInterface(ILiberacao, Liberacao);

      //cria objetos
      Liberacao.InicializaObjeto;
    end;
  End;

  Result := Liberacao;
end;

class procedure TLiberacaoFactory.pSetLiberacao(objLiberacao: ILiberacao);
begin
  Liberacao := objLiberacao;
end;

initialization

  TLiberacaoFactory.Liberacao := nil;

end.
