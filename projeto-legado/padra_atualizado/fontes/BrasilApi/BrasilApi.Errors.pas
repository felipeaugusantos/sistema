unit BrasilApi.Errors;

interface

type
  TBrasilApiCnpjError = class
  private
    Fname: string;
    Fmessage: string;
    Ftype: string;
  public
    property name: string read Fname write Fname;
    property &message: string read Fmessage write Fmessage;
    property &type: string read Ftype write Ftype;
  End;

implementation

end.
