unit untModelEntrega;

interface

type
  TModelEntrega = class
  private
    FidItemCarga: string;
    FidEmpresa: string;
    Flatitude: string;
    FordemEntrega: integer;
    FcpfMotorista: string;
    Flongitude: string;
    Fstatus: string;
    Flicenca: string;
    FdataUltimaOcorrencia: TDateTime;
    FidEntrega: string;
    function getdataUltimaOcorrencia: TDateTime;
  public
    property idEntrega: string read FidEntrega write FidEntrega;
    property idEmpresa: string read FidEmpresa write FidEmpresa;
    property idItemCarga: string read FidItemCarga write FidItemCarga;
    property licenca: string read Flicenca write Flicenca;
    property cpfMotorista: string read FcpfMotorista write FcpfMotorista;
    property status: string read Fstatus write Fstatus;
    property ordemEntrega: integer read FordemEntrega write FordemEntrega;
//    property recebedor:
//    property observacoes:
    property dataUltimaOcorrencia: TDateTime read getdataUltimaOcorrencia write FdataUltimaOcorrencia;
    property latitude: string read Flatitude write Flatitude;
    property longitude: string read Flongitude write Flongitude;
//    property idRomaneio
  end;

  TModelOcorrencia = class
  private
    FdataHora: TDateTime;
    FnomeResponsavel: string;
    Fdescricao: string;
    Flicenca: string;
    FdataInclusao: TDateTime;
    FidEntrega: string;
    FidOcorencia: string;
    FidResponsavel: string;
    Ftipo: string;
    function getdataHora: TDateTime;
    function getdataInclusao: TDateTime;
  public
    property idOcorencia: string read FidOcorencia write FidOcorencia;
    property licenca: string read Flicenca write Flicenca;
    property idEntrega: string read FidEntrega write FidEntrega;
    property dataHora: TDateTime read getdataHora write FdataHora;
    property tipo: string read Ftipo write Ftipo;
    property descricao: string read Fdescricao write Fdescricao;
    property idResponsavel: string read FidResponsavel write FidResponsavel;
    property nomeResponsavel: string read FnomeResponsavel write FnomeResponsavel;
    property dataInclusao: TDateTime read getdataInclusao write FdataInclusao;
//    "payload": "{\"entrega_pendente\":2,\"realizadas\":1,\"queue\":0,\"id_device\":\"ca8f4810-9a04-1e0b-8664-810405281308\"}"
  end;

  TModelMotorista = class
  private
    Femail: string;
    FvalidadeCnh: TDateTime;
    Fcnh: string;
    Fcpf: string;
    Fstatus: string;
    FidMotorista: string;
    FdataCadastro: TDateTime;
    Fnome: string;
    Fcelular: string;
    function getdataCadastro: TDateTime;
    function getvalidadeCnh: TDateTime;
  public
    property idMotorista: string read FidMotorista write FidMotorista;
    property nome: string read Fnome write Fnome;
    property cpf: string read Fcpf write Fcpf;
    property cnh: string read Fcnh write Fcnh;
    property validadeCnh: TDateTime read getvalidadeCnh write FvalidadeCnh;
    property dataCadastro: TDateTime read getdataCadastro write FdataCadastro;
    property status: string read Fstatus write Fstatus;
    property celular: string read Fcelular write Fcelular;
    property email: string read Femail write Femail;
//    property senha: string read Fsenha write Fsenha;
//    property configuracoes: string read Fconfiguracoes write Fconfiguracoes;
  end;

  TModelDocumento = class
  private
    FidOcorrencia: string;
    Flicenca: string;
    FidEntrega: string;
    Ftipo: string;
    FidFoto: string;
  public
    property idFoto: string read FidFoto write FidFoto;
    property licenca: string read Flicenca write Flicenca;
    property idEntrega: string read FidEntrega write FidEntrega;
    property tipo: string read Ftipo write Ftipo;
//    property descricao: string read Fdescricao write Fdescricao;
    property idOcorrencia: string read FidOcorrencia write FidOcorrencia;
  end;

  TModelOcorrencias = TArray<TModelOcorrencia>;
  TModelDocumentos = TArray<TModelDocumento>;

  TModelEntregaCargaItem = class
  private
    Fmotorista: TModelMotorista;
    Fdocumentos: TModelDocumentos;
    Fentrega: TModelEntrega;
    Focorrencias: TModelOcorrencias;
  public
    property entrega: TModelEntrega read Fentrega write Fentrega;
    property ocorrencias: TModelOcorrencias read Focorrencias write Focorrencias;
    property motorista: TModelMotorista read Fmotorista write Fmotorista;
//    property licenca
//    property idCargaItemCliente
//    property imagens
    property documentos: TModelDocumentos read Fdocumentos write Fdocumentos;
  end;

  TModelEntregasCargaItem = TArray<TModelEntregaCargaItem>;

implementation

uses
  DateUtils,
  WinApi.Windows;

{ TModelEntrega }

function GetTimeZone: Integer;
var
  TimeZone: TTimeZoneInformation;
begin
  GetTimeZoneInformation(TimeZone);
  Result := TimeZone.Bias div -60;
end;

function TModelEntrega.getdataUltimaOcorrencia: TDateTime;
begin
  Result := FdataUltimaOcorrencia;
  if Result <> 0 then
    Result := IncHour(Result, GetTimeZone);
end;

{ TModelOcorrencia }

function TModelOcorrencia.getdataHora: TDateTime;
begin
  Result := FdataHora;
  if Result <> 0 then
    Result := IncHour(Result, GetTimeZone);
end;

function TModelOcorrencia.getdataInclusao: TDateTime;
begin
  Result := FdataInclusao;
  if Result <> 0 then
    Result := IncHour(Result, GetTimeZone);
end;

{ TModelMotorista }

function TModelMotorista.getdataCadastro: TDateTime;
begin
  Result := FdataCadastro;
  if Result <> 0 then
    Result := IncHour(Result, GetTimeZone);
end;

function TModelMotorista.getvalidadeCnh: TDateTime;
begin
  Result := FvalidadeCnh;
  if Result <> 0 then
    Result := IncHour(Result, GetTimeZone);
end;

end.
