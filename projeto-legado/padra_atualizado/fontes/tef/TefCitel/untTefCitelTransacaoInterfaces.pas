unit untTefCitelTransacaoInterfaces;

interface

uses
  System.SysUtils, System.Generics.Collections;

type
  TTransacaoTefStatus = (stGenerico, stPendente, stCancelada, stConfirmada, stEstorno, stCancelamentoPendente, stConfirmacaoPendente);

  TTransacaoTefDados = record
    DtaHra: TDateTime; //dt_administradora
    NumNsu: string; //nsu
    NsuHos: string; //nsu_host
    TipTrn: string; //"TEF" fixo
    InfTrn: string; //cod_servico (calc) credito a vista, parc, debito...
    Status: TTransacaoTefStatus; //status_mensagem, situacao_mensagem (calc)
    Estado: string; //status_mensagem, situacao_mensagem (calc)
    ValTrn: Double; //valor
    CodSit: string; //situacao_mensagem
    CodEst: string; //cod_estabelecimento
    CodLoj: string;
    CodCli: string;
    NumPdv: string; // os três primeiros digitos do NSU
    QtdPar: Integer; //qtd_parcelas (scope)
    CodAut: string; //cod_autorizacao (scope)
    NomRed: String; //cod_rede (calc) (scope)-- é convertido para o nome da rede
    CodRed: string; //codigo numerico da rede
    NomBan: string; //cod_bandeira (calc) //scope  //produto //sitef
    NumCar: string; //(scope) //documento sitef
    Contro: string;
    Versao: string;
  end;

  TTransacaoTefDadosLista = TList<TTransacaoTefDados>;

  TTransacaoTefBuscaParam = record
    CodSit: String;
    CodLoj: String;
    NumNsu: String;
    DtaTrn: TDate;
    NumCar: String;
    CodAut: String;
    ValTrn: Double;
  end;

  TTransacaoTefBuscaTipo = (tbTodas, tbPendentes, tbEspecifica);

  ITransacaoTefRepository = interface
    ['{2E060F3A-C98F-40A6-BF39-EEF4F4355A1D}']
    function fBuscarTransacao(AParam: TTransacaoTefBuscaParam): TTransacaoTefDados;
    function fBuscarTransacoesPorData(const ADate: TDate): TTransacaoTefDadosLista;
    function fBuscarTransacoesPendentes(const ADateFrom, ADateTo: TDate): TTransacaoTefDadosLista;
    function fCancelarTransacaoPendente(const ATrn: TTransacaoTefDados): Boolean;
    function fConfirmarTransacaoPendente(const ATrn: TTransacaoTefDados): Boolean;
  end;

  ITransacaoTefViewControls = interface
    ['{7699DA94-178F-4445-B10A-139F09CB8725}']
    function fColunasGrid: TArray<string>;
    function fDiasLimiteBusca: Integer;
    function fTiposBuscaPermitidos: TArray<TTransacaoTefBuscaTipo>;
    function fParamsBusca(const ATipo: TTransacaoTefBuscaTipo): TArray<string>;
  end;

  ITransacaoTefFactory = interface
    ['{472DCCD4-B189-47CD-90DD-1A0BEF237C9A}']
    function fRepository: ITransacaoTefRepository;
    function fViewControls: ITransacaoTefViewControls;
  end;

  TTrasacaoTefException = class(Exception);
  TTrasacaoTefCredenciaisException = class(TTrasacaoTefException);
  TTrasacaoTefParseException = class(TTrasacaoTefException);
  TTransacaoTefRequestException = class(TTrasacaoTefException);
  TTrasacaoTefResponseException = class(TTrasacaoTefException);
  TTrasacaoTefNotFoundException = class(TTrasacaoTefResponseException);

implementation

end.
