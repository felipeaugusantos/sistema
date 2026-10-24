unit untTEnquadramento;

interface

type
  TEnquadramento = class
  private
    FEnquadramento: string;
    FCfops: string;
    FCsts: string;
  public
    property strEnquadramento: string read FEnquadramento write FEnquadramento;
    property strCfops: string read FCfops write FCfops;
    property strCsts: string read FCsts write FCsts;
  end;

implementation

end.
