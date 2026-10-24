unit LalaMove.Errors;

interface

type
  TLalamoveErrorItem = class
  private
    Fid: string;
    Fmessage: string;
  public
    property id: string read Fid write Fid;
    property message: string read Fmessage write Fmessage;
  end;

  TLalamoveErrorResponse = class
  private
    Ferrors: TArray<TLalamoveErrorItem>;
  public
    property errors: TArray<TLalamoveErrorItem> read FErrors write Ferrors;
  end;

implementation

end.
