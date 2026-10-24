unit untAncoraIdentification;

interface

uses
  untAncoraBase;

type
  TAncoraIdentification = class;
  TAncoraIdentificationSecurity = class;
  TAncoraIdentificationService = class;

  TAncoraIdentification = class(TAncoraJson)
  private
    FSecurity: TAncoraIdentificationSecurity;
    FService: TAncoraIdentificationService;
  public
    constructor Create;
    destructor Destroy; override;

    property Security: TAncoraIdentificationSecurity read FSecurity write FSecurity;
    property Service: TAncoraIdentificationService read FService write FService;
  end;

  TAncoraIdentificationSecurity = class
  private
    FToken: string;
  public
    property Token: string read FToken write FToken;
  end;

  TAncoraIdentificationService = class
  private
    FName: string;
    FVersion: string;
  public
    property Name: string read FName write FName;
    property Version: string read FVersion write FVersion;
  end;

implementation

{ TAncoraIdentification }

constructor TAncoraIdentification.Create;
begin
  FSecurity := TAncoraIdentificationSecurity.Create;
  FService := TAncoraIdentificationService.Create;
end;

destructor TAncoraIdentification.Destroy;
begin
  FSecurity.Free;
  FService.Free;
  inherited;
end;

end.
