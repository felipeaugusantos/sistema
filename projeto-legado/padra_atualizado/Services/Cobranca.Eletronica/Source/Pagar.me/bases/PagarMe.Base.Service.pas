unit PagarMe.Base.Service;

interface

uses
  CobrancaEletronica.Base.Service;

type
  TBaseServicePagarMe = class(TBaseServiceCobrancaEletronica)
  protected
    procedure pLoadConnection; override;
    procedure pValidaResposta; override;

  end;

implementation

uses
  CobrancaEletronica.Lib.Types, PagarMe.Lib.Connection, PagarMe.Lib.Validate;

{ TControllerPagarMe }

procedure TBaseServicePagarMe.pLoadConnection;
begin
  ConfigurarRest := TConnectionPagarMe.fConfigurar;
  Api            := API_PAGARME;

  inherited;
end;

procedure TBaseServicePagarMe.pValidaResposta;
begin
  inherited;
end;

end.
