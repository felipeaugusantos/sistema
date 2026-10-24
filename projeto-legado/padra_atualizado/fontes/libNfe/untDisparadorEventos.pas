unit untDisparadorEventos;

interface

uses
{$IFDEF LINUX}
{$ELSE}
  Windows,
  Forms,
  Dialogs,
{$ENDIF}
  SysUtils, Classes, Contnrs, untInterfaces, StrUtils;

Type
  TEventObject = class
    private
      evento: TNotifyEvent;
  End;

  TDisparadorEventos = class(TInterfacedObject, IDisparadorEventos)
    private
      eventos: TStringList;

      constructor Create;
      function GetLista(nomeClasse: String): TObjectList;
      function fNomeClasse(classe: TClass): String;

      class procedure Inicializa;
      class procedure Finaliza;

    protected
      function _AddRef: Integer; stdcall;
      function _Release: Integer; stdcall;
    public
      
      procedure RegistrarEvento(classe: TClass; evento: TNotifyEvent);
      procedure EnviarMensagem(classe: TClass; valor: TObject);
      procedure RemoverEvento(classe: TClass; evento: TNotifyEvent);
      destructor Destroy; override;

      class function GetDisparador: TDisparadorEventos;
  End;

Var
  ___VS_DISPARADOR: TDisparadorEventos;

implementation

{ TDisparadorEventos }

constructor TDisparadorEventos.Create;
begin
  eventos := TStringList.Create;
end;

destructor TDisparadorEventos.Destroy;
  Var
    indice: Integer;
    obj: TObject;
begin
  For indice := 0 To eventos.Count -1 Do
  Begin
    obj := TObject(eventos.Objects[indice]);
    FreeAndNil(obj);
  End;
  FreeAndNil(eventos);
  inherited;
end;

procedure TDisparadorEventos.EnviarMensagem(classe: TClass; valor: TObject);
  Var
    lstEventos: TObjectList;
    indice: Integer;
begin
  lstEventos := GetLista(fNomeClasse(classe));
  For indice := 0 To lstEventos.Count -1 Do
  Begin
    TEventObject(lstEventos[indice]).evento(valor);
  End;
end;

class procedure TDisparadorEventos.Finaliza;
begin
  FreeAndNil(___VS_DISPARADOR);
end;

function TDisparadorEventos.fNomeClasse(classe: TClass): String;
begin
{$IFDEF LINUX}
  Result := classe.ClassName + '_' + RightStr('0000000000' + IntToStr(TThread.CurrentThread.ThreadID), 10);
{$ELSE}
  Result := classe.ClassName + '_' + RightStr('0000000000' + IntToStr(GetCurrentThreadId), 10);
{$ENDIF}
end;

procedure TDisparadorEventos.RegistrarEvento(classe: TClass;
  evento: TNotifyEvent);
  Var
    evtObj: TEventObject;
    lstEventos: TObjectList;
    indice: Integer;
begin
  lstEventos := GetLista(fNomeClasse(classe));
  For indice := 0 To lstEventos.Count-1 Do
  Begin
    evtObj := TEventObject(lstEventos[indice]);
    If (TMethod(evtObj.evento).Code = TMethod(evento).Code) And
       (TMethod(evtObj.evento).Data = TMethod(evento).Data) Then
    Begin
      Exit;
    End;
  End;

  evtObj := TEventObject.Create;
  evtObj.evento := evento;
  lstEventos.Add(evtObj);
end;

procedure TDisparadorEventos.RemoverEvento(classe: TClass;
  evento: TNotifyEvent);
  Var
    lstEventos: TObjectList;
    indice: Integer;
    evtObj: TEventObject;
begin
  lstEventos := GetLista(fNomeClasse(classe));

  For indice := 0 To lstEventos.Count-1 Do
  Begin
    evtObj := TEventObject(lstEventos[indice]);
    If (TMethod(evtObj.evento).Code = TMethod(evento).Code) And
       (TMethod(evtObj.evento).Data = TMethod(evento).Data) Then
    Begin
      lstEventos.Delete(indice);
      Break;
    End;
  End;
end;

function TDisparadorEventos._AddRef: Integer;
begin
  Result := 0;
end;

function TDisparadorEventos._Release: Integer;
begin
  Result := 0;
end;

class function TDisparadorEventos.GetDisparador: TDisparadorEventos;
begin
  If Not Assigned(___VS_DISPARADOR) Then
  Begin
    ___VS_DISPARADOR := TDisparadorEventos.Create;
  End;

  Result := ___VS_DISPARADOR;
end;

function TDisparadorEventos.GetLista(nomeClasse: String): TObjectList;
  Var
    intIndice: Integer;
begin
  intIndice := eventos.IndexOf(nomeClasse);
  If intIndice >= 0 Then
  Begin
    Result := TObjectList(eventos.Objects[intIndice]);
  End
  Else
  Begin
    Result := TObjectList.Create;
    eventos.AddObject(nomeClasse, Result);
  End;
end;

class procedure TDisparadorEventos.Inicializa;
begin
  ___VS_DISPARADOR := Nil;
end;

initialization
  TDisparadorEventos.Inicializa;

finalization
  TDisparadorEventos.Finaliza

end.

