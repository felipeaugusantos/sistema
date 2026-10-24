unit untSignature;

interface

uses
  SysUtils, Classes,  untConversao, untConsts;

type

  { TSignature }

  TSignature = class(TPersistent)
  private
    FURI: String;
    FDigestValue: String;
    FSignatureValue: String;
    FX509Certificate: String;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
  published
    property URI: String             read FURI             write FURI;
    property DigestValue: String     read FDigestValue     write FDigestValue;
    property SignatureValue: String  read FSignatureValue  write FSignatureValue;
    property X509Certificate: String read FX509Certificate write FX509Certificate;
  end;

implementation

{ TSignature }

constructor TSignature.Create;
begin
end;

destructor TSignature.Destroy;
begin
  inherited;
end;

procedure TSignature.Clear;
begin
  FURI             := '';
  FDigestValue     := '';
  FSignatureValue  := '';
  FX509Certificate := '';
end;


procedure TSignature.Assign(Source: TPersistent);
begin
  if Source is TSignature then
  begin
    URI := TSignature(Source).URI;
    DigestValue := TSignature(Source).DigestValue;
    SignatureValue := TSignature(Source).SignatureValue;
    X509Certificate := TSignature(Source).X509Certificate;
  end
  else
    inherited; 
end;

end.

