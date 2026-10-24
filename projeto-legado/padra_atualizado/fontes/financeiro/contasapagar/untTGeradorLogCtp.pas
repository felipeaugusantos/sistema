unit untTGeradorLogCtp;

interface

Uses Classes, untTCadPag, Generics.Collections, SysUtils, untFuncoesSimples;

type TGeradorLogCtp = class(TComponent)
  private
    dicLogCtp: TDictionary<String, TCadPag>;
    procedure pCreateDicLogCtp;
    procedure pDestroyDicLogCtp;

  public
    constructor Create(AOwner: TComponent); Override;
    destructor Destroy; Override;

    function fGravaDicLogCtp: Boolean;
    procedure pAddDicLogCtp(strKey: String; objLogCtp: TCadPag);
end;

implementation

{ TGeradorLogCtp }

constructor TGeradorLogCtp.Create(AOwner: TComponent);
begin
  inherited;
  pCreateDicLogCtp;
end;

procedure TGeradorLogCtp.pCreateDicLogCtp;
begin
  if Not(Assigned(dicLogCtp)) then
  Begin
    Try
      dicLogCtp := TDictionary<String, TCadPag>.Create;
    Except
      On E: Exception Do
      Begin
        pMensagemOk(E.Message + ' [untTGeradorLogCtp.fCreateDicLogCtp] - Falha Ao Criar o Dicionário LogCtp.');
      End;
    End;
  End;
end;

destructor TGeradorLogCtp.Destroy;
begin
  pDestroyDicLogCtp;
  inherited;
end;

procedure TGeradorLogCtp.pAddDicLogCtp(strKey: String; objLogCtp: TCadPag);
begin
  if (Assigned(dicLogCtp)) then
  Begin
    Try
      dicLogCtp.AddOrSetValue(strKey, objLogCtp);
    Except
    On E: Exception Do
      Begin
        pMensagemOk(E.Message + ' [untTGeradorLogCtp.pAddDicLogCtp] - Falha Ao Adicionar Registro no Dicionário LogCtp.');
      End;
    End;
  End;
end;

procedure TGeradorLogCtp.pDestroyDicLogCtp;
begin
  if (Assigned(dicLogCtp)) then
  Begin
    Try
      dicLogCtp.Free;
    Except
    On E: Exception Do
      Begin
        pMensagemOk(E.Message + ' [untTGeradorLogCtp.pDestroyDicLogCtp] - Falha Ao Liberar o Dicionário LogCtp.');
      End;
    End;
  End;
end;

function TGeradorLogCtp.fGravaDicLogCtp: Boolean;
var
  strKey: String;
begin
  Result := False;
  if (Assigned(dicLogCtp)) then
  Begin
    Try
      for strKey in dicLogCtp.Keys do
      Begin
        Result := dicLogCtp.Items[strKey].fGravaLogCtp;
      End;
    Except
    On E: Exception Do
      Begin
        pMensagemOk(E.Message + ' [untTGeradorLogCtp.pGravaDicLogCtp] - Falha Ao Gravar o Dicionário LogCtp.');
      End;
    End;
  End;
end;

end.
