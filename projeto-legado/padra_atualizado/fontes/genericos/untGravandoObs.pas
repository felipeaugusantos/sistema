unit untGravandoObs;

interface

Uses untSubjectIntf, Classes, SysUtils, untGravando, Forms, Controls, ShlObj,  COMOBJ, SHELLAPI,
     untTypesSistema;

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

     procedure  pUpdate(const Parameters: array of String; AVisualizarProgresso: Boolean = True);
   end;                                                    

implementation

{ TGravandoObs }

constructor TGravandoObs.Create;
begin
  inherited Create();

  FGravando  := TfrmGravando.Create(nil);
  FGravando.lblGravando.Caption := 'Aguarde...';
  FGravando.OnClose := nil;

  VS_ExibirMensagemAguarde := True;
end;

destructor TGravandoObs.Destroy;
begin
  If Assigned(FGravando) then
    FreeAndNil(FGravando);

  inherited;
end;

procedure TGravandoObs.pUpdate(const Parameters: array of String; AVisualizarProgresso: Boolean = True);
begin
  if AVisualizarProgresso then
    FGravando.pgbStatus.Visible := True
  else
    FGravando.pgbStatus.Visible := False;

  if Length(Parameters) > 0 then
  begin
    if Parameters[0] = 'TcxProgressBar' then
    begin
      if StrToInt(Parameters[1]) > 0 then
      begin
        with FGravando do
        begin
          pgbStatus.Properties.Max := StrToInt(Parameters[1]);
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
    Else If (Parameters[0] = 'Esconder') Then
      FGravando.Hide
    Else If (Parameters[0] = '') Then
    Begin
      FGravando.pgbStatus.Visible := False;
      if Parameters[2] <> '' then
        FGravando.lblGravando.Caption :=  Parameters[2];
    End;

    if Assigned(FGravando) then
    Begin
      VS_ExibirMensagemAguarde := True;

      FGravando.Show;
    End;
  end;
end;

end.
