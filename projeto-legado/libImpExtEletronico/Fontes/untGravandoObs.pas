unit untGravandoObs;

interface

Uses untSubjectIntf, Classes, SysUtils, untGravando, Forms, Controls, ShlObj,  COMOBJ, SHELLAPI;

type
   TGravandoObs = class(TInterfacedObject, IObserver_)
   private
     { private declarations }
     FGravando: TfrmGravando;

   protected
     { protected declarations }
   public
     { public declarations }
     constructor Create(); overload;
     destructor Destroy; override;

     procedure  pUpdate(const Parameters: array of String);
   end;                                                    

implementation

{ TGravandoObs }

constructor TGravandoObs.Create;
begin
  inherited Create();

  FGravando  := TfrmGravando.Create(nil);
end;

destructor TGravandoObs.Destroy;
begin
  If Assigned(FGravando) then
    FreeAndNil(FGravando);

  inherited;
end;

procedure TGravandoObs.pUpdate(const Parameters: array of String);
begin

  if Length(Parameters) > 0 then
  begin
    if Assigned(FGravando) then
      FGravando.Show;

    if Parameters[0] = 'TProgressBar' then
    begin
      if not FGravando.pgbStatus.Visible then
        FGravando.pgbStatus.Visible := True;

      if StrToInt(Parameters[1]) > 0 then
      begin
        with FGravando do
        begin
          pgbStatus.Max := StrToInt(Parameters[1]);
          if Parameters[2] <> '' then
             lblGravando.Caption :=  Parameters[2];

          if Parameters[3] <> '' then
          begin
            pgbStatus.Position := StrToInt(Parameters[3]);
            Update;
          end
          else
            pgbStatus.Position := 0;
        end;
      end;
    end
    Else If (Parameters[0] = '') Then
    Begin
      FGravando.pgbStatus.Visible := False;
      if Parameters[2] <> '' then
        FGravando.lblGravando.Caption :=  Parameters[2];
    End
    Else If (Parameters[0] = 'Esconder') Then
    begin
      FGravando.Hide;
    end;
  end;
end;

end.
