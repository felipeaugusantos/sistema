unit DominioSistemas.Core.ConsultaInterface;

interface

uses
  DominioSistemas.Core.ApiClientInterface ;

type
  TInfoAtivacao = record
    accountantOfficeName: String;
    accountantOfficeNationalIdentity: String;
    clientName: String;
    clientNationalIdentity: String;
  end ;

  IConsultaProtocolo = interface
    ['{A638FDFC-713E-4E2F-8579-2E418FE4818A}']
    function fProcessamento(const AApi: IApiClient; const AProtocolo: String): String;
  end ;

  IConsultaAtivacao = interface
    ['{B85631D9-3F64-443F-AF4F-33AA256348AF}']
    function fInformacao(const AApi: IApiClient): TInfoAtivacao;
    function fGerarIntegrationKeyApp(const AApi: IApiClient): String ;
  end ;

  IConsultaFactory = interface
    ['{1C688502-CC77-433B-95B8-2DCE254FE3C6}']
    function fProtocolo: IConsultaProtocolo;
    function fAtivacao: IConsultaAtivacao;
  end ;

implementation

end.
