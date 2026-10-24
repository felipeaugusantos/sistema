unit untForTagModel;

interface

uses
   Classes,
   SysUtils,
   Generics.Collections;

type
   TForTagModel = class(TPersistent)
   private
      FStrCodFor,
      FStrCodEmp: String;
   public
      constructor Create;
   published
      property strCodFor: String read FStrCodFor write FStrCodFor;
      property strCodEmp: String read FStrCodEmp write FStrCodEmp;
   end;

   TColForTagModel = class(TObjectList<TForTagModel>)
   public
     function fRetorna(intIndex: Integer): TForTagModel;
     procedure pAdiciona(objForTag: TForTagModel);
     function fAdiciona():TForTagModel;
   end;

implementation

constructor TForTagModel.Create;
begin
  Self.FStrCodFor := '';
  Self.FStrCodEmp := '';
end;

function TColForTagModel.fAdiciona: TForTagModel;
begin
  Result := TForTagModel.Create;
  Self.Add(Result);
end;

function TColForTagModel.fRetorna(intIndex: Integer): TForTagModel;
begin
  Result := TForTagModel(Self[intIndex]);
end;

procedure TColForTagModel.pAdiciona(objForTag: TForTagModel);
begin
  Self.Add(objForTag);
end;

end.
