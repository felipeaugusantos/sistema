unit untTLockMonitorEnvioBoleto;

interface

uses Uni, Classes, strUtils, System.SysUtils, untFuncoesSimples;

Type

  TLock = class(TComponent)
    private
      FTravas: TStringList;

    public

      Constructor Create; reintroduce;
      Destructor Destroy; override;

      function fLock_Unlock(strChave: String; blnTravar: Boolean;
                            blnLoopTravamento: Boolean = True;
                            blnHourGlass: Boolean = False;
                            strCon_Id: String = '';
                            blnMostraMsgTravamento: Boolean = True;
                            strOrigem: String = ''): Boolean;

      procedure pDestravarTodos;
      procedure pAdicionaTrava(strChave: String);

      procedure DestravarListaDuplicatas(AChaves: TStringList);
  End;

implementation

{ TLock }


constructor TLock.Create;
begin
  FTravas := TStringList.Create;
end;

procedure TLock.DestravarListaDuplicatas(AChaves: TStringList);
  Var
    LDuplicata: String;
begin
  If AChaves.Count = 0 Then
    Exit;

  For LDuplicata In AChaves Do
  Begin
    untFuncoesSimples.fLock_Unlock(LDuplicata, False, False);

    If FTravas.IndexOf(LDuplicata) >= 0 Then
      FTravas.Delete(FTravas.IndexOf(LDuplicata));
  End;
end;

destructor TLock.Destroy;
begin
  pDestravarTodos;
  FreeAndNil(FTravas);
end;

procedure TLock.pAdicionaTrava(strChave: String);
begin
  FTravas.Add(strChave);
end;

procedure TLock.pDestravarTodos;
var
  intInd: Integer;
begin
  If FTravas.Count  > 0 Then
  Begin
    For intInd := 0 To FTravas.Count   -1 Do
    Begin
      untFuncoesSimples.fLock_Unlock(FTravas[intInd], False, False);
    End;
    FTravas.Clear;
  End;
end;

function TLock.fLock_Unlock(strChave: String; blnTravar: Boolean;
                            blnLoopTravamento: Boolean = True;
                            blnHourGlass: Boolean = False;
                            strCon_Id: String = '';
                            blnMostraMsgTravamento: Boolean = True;
                            strOrigem: String = ''): Boolean;
var
  intInd: Integer;
begin

  If fEmptyStr(strChave) Then Exit(False);

  If Not Assigned(Self) Then
    Self := TLock.Create;

  Result := untFuncoesSimples.fLock_Unlock(strChave, blnTravar, blnLoopTravamento, blnHourGlass,
                                           strCon_Id, blnMostraMsgTravamento, strOrigem);

  If Result Then
  Begin
    If blnTravar Then
      FTravas.Add(strChave)
    Else
    Begin
      intInd := FTravas.IndexOf(strChave);
      If intInd >= 0 Then
        FTravas.Delete(intInd);
    End;
  End;
end;

end.
