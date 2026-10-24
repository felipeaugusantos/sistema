unit untRecalculoSeqCombo;

interface

uses
  SysUtils,
  Generics.Collections;

type
  TSeqCombo = class
    public
      strDocumento: String;
      intSeqCom: Integer;
      intSeqComNovo: Integer;
end;

type
  IRecalculoSeqComboController = interface
    ['{B8207699-1B94-4303-ADDC-B50F58F57B70}']
    procedure pClear();
    function fRecalculaSeqCom(const strDocumento: String; const intSeqCom: Integer):Integer;
end;

type
  TRecalculoSeqComboController = class(TInterfacedObject, IRecalculoSeqComboController)
    private
      FintSeqCom: Integer;
      FLista: TObjectList<TSeqCombo>;

      function fProximoSeqCom():Integer;
    public
      constructor Create();
      destructor Destroy(); override;

      procedure pClear();


      function fRecalculaSeqCom(const strDocumento: String; const intSeqCom: Integer):Integer;

      class function fNew():IRecalculoSeqComboController;
end;

implementation

{ TRecalculoSeqComboController }

constructor TRecalculoSeqComboController.Create;
begin
  FLista := TObjectList<TSeqCombo>.Create(True);
  Self.pClear;
end;

destructor TRecalculoSeqComboController.Destroy;
begin
  FreeAndNil(FLista);
  inherited;
end;

function TRecalculoSeqComboController.fRecalculaSeqCom(const strDocumento: String; const intSeqCom: Integer): Integer;
var
  intIndex: Integer;
  objSeqCom: TSeqCombo;
begin
  Result := intSeqCom;

  If (intSeqCom <= 0) Then
    Exit;

  For intIndex := 0 To Pred(FLista.Count) Do
  Begin
    If (FLista[intIndex].strDocumento = strDocumento) And (FLista[intIndex].intSeqCom = intSeqCom) Then
    Begin
      Result := FLista[intIndex].intSeqComNovo;
      Exit;
    End;
  End;

  objSeqCom := TSeqCombo.Create;
  objSeqCom.strDocumento  := strDocumento;
  objSeqCom.intSeqCom     := intSeqCom;
  objSeqCom.intSeqComNovo := Self.fProximoSeqCom;

  FLista.Add(objSeqCom);

  Result := objSeqCom.intSeqComNovo;
end;

class function TRecalculoSeqComboController.fNew: IRecalculoSeqComboController;
begin
  Result := TRecalculoSeqComboController.Create();
end;

function TRecalculoSeqComboController.fProximoSeqCom: Integer;
begin
  FintSeqCom := FintSeqCom + 1;
  Result := FintSeqCom;
end;

procedure TRecalculoSeqComboController.pClear;
begin
  FLista.Clear;
  FintSeqCom := 0;
end;

end.
