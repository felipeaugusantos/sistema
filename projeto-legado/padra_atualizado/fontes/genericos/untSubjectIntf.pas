unit untSubjectIntf;

interface

type

  IObserver_ = interface
    ['{2DB4B7F2-14F9-44C4-8F34-C65E7DBE336E}']
    procedure pUpdate(const Parameters: array of String; AVisualizarProgresso: Boolean = True);
  end;

  ISubject_ = interface
    ['{1B3F3594-3514-4165-BAF0-50CC848C497A}']
    procedure pAddObserver(Observer: IObserver_);
    procedure pDeleteObserver(Observer: IObserver_);
    procedure pNotify(const Parameters: array of String; AVisualizarProgresso: Boolean = True);
  end;

implementation

end.
