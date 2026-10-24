unit untSubjectClass;

interface

Uses untSubjectIntf, Classes, SysUtils;

type
   TSubject = class(TInterfacedObject, ISubject_)
   private
     { private declarations }
     FObservers: TInterfaceList; 

   protected
     { protected declarations }
   public
     { public declarations }
     constructor Create(); overload;
     destructor Destroy; override;

     procedure pAddObserver(Observer: IObserver_);
     procedure pDeleteObserver(Observer: IObserver_);
     procedure pNotify(const Parameters: array of String; AVerProgresso: Boolean = True);
   end;

implementation

{ TSubject }

constructor TSubject.Create;
begin
  inherited Create();
  FObservers := TInterfaceList.Create;
end;

destructor TSubject.Destroy;
begin
  FreeAndNil(FObservers);
  inherited;
end;

procedure TSubject.pAddObserver(Observer: IObserver_);
begin
  FObservers.Add(Observer);
end;

procedure TSubject.pDeleteObserver(Observer: IObserver_);
begin
  FObservers.Remove(Observer);
end;

procedure TSubject.pNotify(const Parameters: array of String; AVerProgresso: Boolean = True);
var 
    i: Integer; 
begin 
  for i := 0 to FObservers.Count - 1 do
    IObserver_(FObservers.Items[i]).pUpdate(Parameters, AVerProgresso);
end;

end.
