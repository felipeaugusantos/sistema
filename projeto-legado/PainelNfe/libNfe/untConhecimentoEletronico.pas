unit untConhecimentoEletronico;

interface

//uses untInterfaces, System.Contnrs, System.Classes;
uses
{$IFDEF LINUX}
{$ELSE}
  Controls,
{$ENDIF}
  untInterfaces, Contnrs, Classes;

Type
  TTomador = class(TObject)
  private
    FTomadorServico: string;
    FCPFCNPJ: string;
    FInscricaoEstadual: string;
    FRazaoSocialNome: string;
    FNomeFantasia: string;
    FTelefone: string;
    FLogradouro: string;
    FNumero: string;
    FComplemento: string;
    FBairro: string;
    FCodIBGE: string;
    FCEP: string;
    FCodPais: string;
    FEmail: string;
    FIndicador: string;
  public
    constructor create();

    property strTomadorServico    : string Read FTomadorServico    Write FTomadorServico;
    property strCPFCNPJ           : string Read FCPFCNPJ           Write FCPFCNPJ;
    property strInscricaoEstadual : string Read FInscricaoEstadual Write FInscricaoEstadual;
    property strRazaoSocialNome   : string Read FRazaoSocialNome   Write FRazaoSocialNome;
    property strNomeFantasia      : string Read FNomeFantasia      Write FNomeFantasia;
    property strTelefone          : string Read FTelefone          Write FTelefone;
    property strLogradouro        : string Read FLogradouro        Write FLogradouro;
    property strNumero            : string Read FNumero            Write FNumero;
    property strComplemento       : string Read FComplemento       Write FComplemento;
    property strBairro            : string Read FBairro            Write FBairro;
    property strCodIBGE           : string Read FCodIBGE           Write FCodIBGE;
    property strCEP               : string Read FCEP               Write FCEP;
    property strCodPais           : string Read FCodPais           Write FCodPais;
    property strEmail             : string Read FEmail             Write FEmail;
    property strIndicador         : string Read FIndicador         Write FIndicador;
  end;

Type
  TRemetente = class(TObject)
  private
    FCPFCNPJ: string;
    FInscricaoEstadual: string;
    FRazaoSocialNome: string;
    FNomeFantasia: string;
    FTelefone: string;
    FLogradouro: string;
    FNumero: string;
    FComplemento: string;
    FBairro: string;
    FCodIBGE: string;
    FCEP: string;
    FCodPais: string;
    FEmail: string;
  public
    constructor create();

    property strCPFCNPJ           : string Read FCPFCNPJ           Write FCPFCNPJ;
    property strInscricaoEstadual : string Read FInscricaoEstadual Write FInscricaoEstadual;
    property strRazaoSocialNome   : string Read FRazaoSocialNome   Write FRazaoSocialNome;
    property strNomeFantasia      : string Read FNomeFantasia      Write FNomeFantasia;
    property strTelefone          : string Read FTelefone          Write FTelefone;
    property strLogradouro        : string Read FLogradouro        Write FLogradouro;
    property strNumero            : string Read FNumero            Write FNumero;
    property strComplemento       : string Read FComplemento       Write FComplemento;
    property strBairro            : string Read FBairro            Write FBairro;
    property strCodIBGE           : string Read FCodIBGE           Write FCodIBGE;
    property strCEP               : string Read FCEP               Write FCEP;
    property strCodPais           : string Read FCodPais           Write FCodPais;
    property strEmail             : string Read FEmail             Write FEmail;
  end;

Type
  TDestinatario = class(TObject)
  private
    FCPFCNPJ: string;
    FInscricaoEstadual: string;
    FRazaoSocialNome: string;
    FTelefone: string;
    FSuframa: string;
    FLogradouro: string;
    FNumero: string;
    FComplemento: string;
    FBairro: string;
    FCodIBGE: string;
    FCEP: string;
    FCodPais: string;
    FEmail: string;
  public
    constructor create();

    property strCPFCNPJ           : string Read FCPFCNPJ           Write FCPFCNPJ;
    property strInscricaoEstadual : string Read FInscricaoEstadual Write FInscricaoEstadual;
    property strRazaoSocialNome   : string Read FRazaoSocialNome   Write FRazaoSocialNome;
    property strTelefone          : string Read FTelefone          Write FTelefone;
    property strSuframa           : string Read FSuframa           Write FSuframa;
    property strLogradouro        : string Read FLogradouro        Write FLogradouro;
    property strNumero            : string Read FNumero            Write FNumero;
    property strComplemento       : string Read FComplemento       Write FComplemento;
    property strBairro            : string Read FBairro            Write FBairro;
    property strCodIBGE           : string Read FCodIBGE           Write FCodIBGE;
    property strCEP               : string Read FCEP               Write FCEP;
    property strCodPais           : string Read FCodPais           Write FCodPais;
    property strEmail             : string Read FEmail             Write FEmail;
  end;

Type
  TValoresPrestacaoServico = class(TObject)
  private
    FTipoCTE: string;
    FNroItem: string;
    FNomeComponente: string;
    FValor: Double;
  public
    constructor Create();

    property strTipoCTE        : string Read FTipoCTE        Write FTipoCTE       ;
    property strNroItem        : string Read FNroItem        Write FNroItem       ;
    property strNomeComponente : string Read FNomeComponente Write FNomeComponente;
    property fltValor          : Double Read FValor          Write FValor         ;
  end;

Type
  TInformacoesImpostos = class(TObject)
  private
    FTipoCTE: string;
    FClassificacaoTS: string;
    FPercentualReducaoBC: Double;
    FValorBCIcms: Double;
    FAliquotaICMS: Double;
    FValorICMS: Double;
    FValorCredito: Double;
  public
    constructor Create();

    property strTipoCTE             : string Read FTipoCTE             Write FTipoCTE            ;
    property strClassificacaoTS     : string Read FClassificacaoTS     Write FClassificacaoTS    ;
    property fltPercentualReducaoBC : Double Read FPercentualReducaoBC Write FPercentualReducaoBC;
    property fltValorBCIcms         : Double Read FValorBCIcms         Write FValorBCIcms        ;
    property fltAliquotaICMS        : Double Read FAliquotaICMS        Write FAliquotaICMS       ;
    property fltValorICMS           : Double Read FValorICMS           Write FValorICMS          ;
    property fltValorCredito        : Double Read FValorCredito        Write FValorCredito       ;
  end;

Type
  TInformacoesCarga = class(TObject)
  private
    FValorTotal           : Double;
    FProdutoPredominante  : string;
    FOutrasCaracteristicas: string;
    FValorCargaAverbacao  : Double;
  public
    constructor Create();

    property fltValorTotal           : Double Read FValorTotal            Write FValorTotal           ;
    property strProdutoPredominante  : string Read FProdutoPredominante   Write FProdutoPredominante  ;
    property strOutrasCaracteristicas: string Read FOutrasCaracteristicas Write FOutrasCaracteristicas;
    property fltValorCargaAverbacao  : Double Read FValorCargaAverbacao   Write FValorCargaAverbacao  ;
  end;

Type
  TInformacoesQtdeCarga = class(TObject)
  private
    FCodUnidadeMedida: string;
    FTipoMedida: string;
    FQuantidade: Double;
  public
    constructor Create(strCodUnidade, strTipoMedida: string; fltQtde: Double);

    property strCodUnidadeMedida : string read FCodUnidadeMedida;
    property strTipoMedida       : string read FTipoMedida;
    property fltQuantidade       : Double read FQuantidade;
  end;

Type
  TInformacoesNFe = Class(TObject)
  private
    FChaveAcessoNFe: string;
    FPinSuframa: string;
    FDataPrevisaoEntrega: TDate;
  public
    constructor Create(strChave, strPinSuframa: string; dtaPrevisaoEntrega: TDate);

    property strChaveAcessoNFe      : string Read FChaveAcessoNFe;
    property strPinSuframa          : string Read FPinSuframa;
    property dtaDataPrevisaoEntrega : TDate  Read FDataPrevisaoEntrega;
  end;

Type
  TInformacoesServicoPrestado = class(TObject)
  private
    FDescricaoServico: string;
    FQtdeCargas: Double;
  public
    constructor Create();

    property strDescricaoServico : string Read FDescricaoServico Write FDescricaoServico;
    property fltQtdeCargas       : Double Read FQtdeCargas       Write FQtdeCargas      ;
  end;

Type
  TInformacoesRodoviario = class(TObject)
  private
    FRegistroNacionalANTT: string;
  public
    constructor Create();

    property strRegistroNacionalANTT : string Read FRegistroNacionalANTT Write FRegistroNacionalANTT;
  end;

type
  TPartilhaCTe = class(TObject)
  private
    FValorBaseCalculoIcmsUfDestino: Double;
    FAliquotaIcmsInternaUfDestino: Double;
    FAliquotaIcmsInterestadual: Double;
    FValorIcmsPartilhaTermino: Double;
    FValorIcmsPartilhaInicio: Double;
    FAliquotaFcp: Double;
    FValorFcpDestino: Double;
  public
    constructor Create();

    property fltValorBaseCalculoIcmsUfDestino : Double  read FValorBaseCalculoIcmsUfDestino write FValorBaseCalculoIcmsUfDestino;
    property fltAliquotaIcmsInternaUfDestino  : Double  read FAliquotaIcmsInternaUfDestino  write FAliquotaIcmsInternaUfDestino ;
    property fltAliquotaIcmsInterestadual     : Double  read FAliquotaIcmsInterestadual     write FAliquotaIcmsInterestadual    ;
    property fltValorIcmsPartilhaTermino      : Double  read FValorIcmsPartilhaTermino      write FValorIcmsPartilhaTermino     ;
    property fltValorIcmsPartilhaInicio       : Double  read FValorIcmsPartilhaInicio       write FValorIcmsPartilhaInicio      ;
    property fltAliquotaFcp                   : Double  read FAliquotaFcp                   write FAliquotaFcp                  ;
    property fltValorFcpDestino               : Double  read FValorFcpDestino               write FValorFcpDestino              ;
  end;

Type
  TConhecimentoEletronico = class(TInterfacedObject)
  private
    FCodEmp: String;
    FIdReferencia: string;
    FCFOP: string;
    FNaturezaOperacao: string;
    FSerie: string;
    FNumeroConhecimento: String;
    FDataEmissao: TDate;
    FCodIBGEInicioPrestacao: string;
    FCodIBGEFimPrestacao: string;
    FValorPrestacaoServico: double;
    FValoraReceber: double;
    FChaveAcesso: String;

    FTomador: TTomador;
    FIdentificacaoEmitente: TDadosEmitente;
    FInformacoesRemetente: TRemetente;
    FInformacoesDestinarario: TDestinatario;
    FValoresPrestacaoServico: TValoresPrestacaoServico;
    FInformacoesImpostos: TInformacoesImpostos;
    FInformacoesCarga: TInformacoesCarga;
    FInformacoesQtdeCarga: TObjectList;
    FInformacoesNFe: TObjectList;
    FInformacoesServicoPrestado: TInformacoesServicoPrestado;
    FInformacoesRodoviario: TInformacoesRodoviario;
    FIndicadorCTeGlobalizado: string;
    FModeloDocumentoFiscal: string;
    FHoraSaidaEntrada: TTime;
    FRota: string;
    FTipoServico: string;
    FModal: string;
    FTipoCTe: string;
    FDetalhesRetira: string;
    FIndicadorRetira: string;
    FPercAproximadosTributos: Double;
    FPartilha: TPartilhaCTe;
    FTipoImpressao: TTipoImpressao;
    FReformaCST: String;
    FReformaClasTrib: String;
    FReformaBasIBS_CBS: Double;
    FReformaAlqCBS: Double;
    FReformaAlqIBS_UF: Double;
    FReformaAlqIBS_MN: Double;
    FReformaVlrCBS: Double;
    FReformaVlrIBS_UF: Double;
    FReformaVlrIBS_MN: Double;

    function GetCTeInformacoesQtdeCarga(Index: Integer): TInformacoesQtdeCarga;
    function GetQtdCTeInformacoesQtdeCarga: Integer;
    function GetCTeInformacoesNFe(Index: Integer): TInformacoesNFe;
    function GetQtdCTeInformacoesNFe: Integer;
    function GetIdReferencia: string;
  public
    constructor Create(dadosEmitente: TDadosEmitente;
                       tipoImpressao: TTipoImpressao = tiPadrao);

    destructor Destroy; override;

    procedure pAddInformacoesQtdeCarga(InformacoesQtdeCarga   : TInformacoesQtdeCarga);
    procedure pAddInformacoesNFe(InformacoesNFe               : TInformacoesNFe);

    property strCodEmp                   : string read FCodEmp                  write FCodEmp                 ;
    property strIdReferencia             : string read GetIdReferencia;
    property strCFOP                     : string read FCFOP                    write FCFOP                   ;
    property strNaturezaOperacao         : string read FNaturezaOperacao        write FNaturezaOperacao       ;
    property strSerie                    : string read FSerie                   write FSerie                  ;
    property strNumeroConhecimento       : string read FNumeroConhecimento      write FNumeroConhecimento     ;
    property dtaDataEmissao              : TDate  read FDataEmissao             write FDataEmissao            ;
    property hraHoraSaidaEntrada         : TTime  read FHoraSaidaEntrada        write FHoraSaidaEntrada       ;
    property strTipoCTe                  : string read FTipoCTe                 write FTipoCTe                ;
    property strModal                    : string read FModal                   write FModal                  ;
    property strTipoServico              : string read FTipoServico             write FTipoServico            ;
    property strCodIBGEInicioPrestacao   : string read FCodIBGEInicioPrestacao  write FCodIBGEInicioPrestacao ;
    property strCodIBGEFimPrestacao      : string read FCodIBGEFimPrestacao     write FCodIBGEFimPrestacao    ;
    property strIndicadorRetira          : string read FIndicadorRetira         write FIndicadorRetira        ;
    property strDetalhesRetira           : string read FDetalhesRetira          write FDetalhesRetira         ;
    property strRota                     : string read FRota                    write FRota                   ;
    property fltValorPrestacaoServico    : double read FValorPrestacaoServico   write FValorPrestacaoServico  ;
    property fltValoraReceber            : double read FValoraReceber           write FValoraReceber          ;
    property strChaveAcesso              : string read FChaveAcesso             write FChaveAcesso            ;
    property strIndicadorCTeGlobalizado  : string read FIndicadorCTeGlobalizado write FIndicadorCTeGlobalizado;
    property strModeloDocumentoFiscal    : string read FModeloDocumentoFiscal   write FModeloDocumentoFiscal  ;
    property fltPercAproximadosTributos  : Double Read FPercAproximadosTributos write FPercAproximadosTributos;
    property strReformaCST               : string read FReformaCST              write FReformaCST;
    property strReformaClasTrib          : string read FReformaClasTrib         write FReformaClasTrib;
    property fltReformaBasIBS_CBS        : Double read FReformaBasIBS_CBS       write FReformaBasIBS_CBS;
    property fltReformaAlqCBS            : Double read FReformaAlqCBS           write FReformaAlqCBS;
    property fltReformaAlqIBS_UF         : Double read FReformaAlqIBS_UF        write FReformaAlqIBS_UF;
    property fltReformaAlqIBS_MN         : Double read FReformaAlqIBS_MN        write FReformaAlqIBS_MN;
    property fltReformaVlrCBS            : Double read FReformaVlrCBS           write FReformaVlrCBS;
    property fltReformaVlrIBS_UF         : Double read FReformaVlrIBS_UF        write FReformaVlrIBS_UF;
    property fltReformaVlrIBS_MN         : Double read FReformaVlrIBS_MN        write FReformaVlrIBS_MN;

    property Tomador                    : TTomador                    Read FTomador                     Write FTomador;
    property IdentificacaoEmitente      : TDadosEmitente              Read FIdentificacaoEmitente       Write FIdentificacaoEmitente;
    property Remetente                  : TRemetente                  Read FInformacoesRemetente        Write FInformacoesRemetente;
    property Destinatario               : TDestinatario               Read FInformacoesDestinarario     Write FInformacoesDestinarario;
    property ValoresPrestacaoServico    : TValoresPrestacaoServico    Read FValoresPrestacaoServico     Write FValoresPrestacaoServico;
    property InformacoesImpostos        : TInformacoesImpostos        Read FInformacoesImpostos         Write FInformacoesImpostos;
    property InformacoesCarga           : TInformacoesCarga           Read FInformacoesCarga            Write FInformacoesCarga;
    property InformacoesServicoPrestado : TInformacoesServicoPrestado Read FInformacoesServicoPrestado  Write FInformacoesServicoPrestado;
    property InformacoesRodoviario      : TInformacoesRodoviario      Read FInformacoesRodoviario       Write FInformacoesRodoviario;

    property InformacoesQtdeCarga                      : TObjectList                  Read FInformacoesQtdeCarga;
    property CTeInformacoesQtdeCarga[Index : Integer]  : TInformacoesQtdeCarga        Read GetCTeInformacoesQtdeCarga;
    property intQtdCTeInformacoesQtdeCarga             : Integer                      Read GetQtdCTeInformacoesQtdeCarga;

    property InformacoesNFe                            : TObjectList                  Read FInformacoesNFe;
    property CTeInformacoesNFe[Index : Integer]        : TInformacoesNFe              Read GetCTeInformacoesNFe;
    property intQtdInformacoesNFe                      : Integer                      Read GetQtdCTeInformacoesNFe;

    property Partilha                   : TPartilhaCTe                read FPartilha                    Write FPartilha;

    property tipoImpressao: TTipoImpressao Read FTipoImpressao;
  end;

implementation

{ TTomador }

constructor TTomador.create;
begin
  inherited Create;
  Self.FTomadorServico := '';
  Self.FCPFCNPJ := '';
  Self.FInscricaoEstadual := '';
  Self.FRazaoSocialNome := '';
  Self.FNomeFantasia := '';
  Self.FTelefone := '';
  Self.FLogradouro := '';
  Self.FNumero := '';
  Self.FComplemento := '';
  Self.FBairro := '';
  Self.FCodIBGE := '';
  Self.FCEP := '';
  Self.FCodPais := '';
  Self.FEmail := '';
  Self.FIndicador := '';
end;

{ TValoresPrestacaoServico }

constructor TValoresPrestacaoServico.Create;
begin
  inherited Create;
  Self.FTipoCTE := '';
  Self.FNroItem := '';
  Self.FNomeComponente := '';
  Self.FValor := 0;
end;

{ TInformacoesImpostos }

constructor TInformacoesImpostos.Create;
begin
  inherited Create;
  Self.FTipoCTE := '';
  Self.FClassificacaoTS := '';
  Self.FPercentualReducaoBC := 0;
  Self.FValorBCIcms := 0;
  Self.FAliquotaICMS := 0;
  Self.FValorICMS := 0;
  Self.FValorCredito := 0;
end;

{ TInformacoesCarga }

constructor TInformacoesCarga.Create;
begin
  inherited Create;
  Self.FValorTotal := 0;
  Self.FProdutoPredominante := '';
  Self.FOutrasCaracteristicas := '';
  Self.FValorCargaAverbacao := 0;
end;

{ TInformacoesNFe }

constructor TInformacoesNFe.Create(strChave, strPinSuframa: string; dtaPrevisaoEntrega: TDate);
begin
  Self.FChaveAcessoNFe      := strChave;
  Self.FPinSuframa          := strPinSuframa;
  Self.FDataPrevisaoEntrega := dtaPrevisaoEntrega;
end;

{ TInformacoesServicoPrestado }

constructor TInformacoesServicoPrestado.Create;
begin
  inherited Create;
  Self.FDescricaoServico := '';
  Self.FQtdeCargas := 0;
end;

{ TInformacoesRodoviario }

constructor TInformacoesRodoviario.Create;
begin
  inherited Create;
  Self.FRegistroNacionalANTT := '';
end;

{ TInformacoesQtdeCarga }

constructor TInformacoesQtdeCarga.Create(strCodUnidade, strTipoMedida: string; fltQtde: Double);
begin
  Self.FCodUnidadeMedida := strCodUnidade;
  Self.FTipoMedida       := strTipoMedida;
  Self.FQuantidade       := fltQtde;
end;

{ TConhecimentoEletronico }

constructor TConhecimentoEletronico.Create(dadosEmitente: TDadosEmitente; tipoImpressao: TTipoImpressao = tiPadrao);
begin
  inherited Create;

  Self.FCodEmp := '';
  Self.FIdReferencia := '';
  Self.FCFOP := '';
  Self.FNaturezaOperacao := '';
  Self.FSerie := '';
  Self.FNumeroConhecimento := '';
  Self.FDataEmissao := 0;
  Self.FHoraSaidaEntrada := 0;
  Self.FTipoCTe := '';
  Self.FModal := '';
  Self.FTipoServico := '';
  Self.FCodIBGEInicioPrestacao := '';
  Self.FCodIBGEFimPrestacao := '';
  Self.FIndicadorRetira := '';
  Self.FDetalhesRetira := '';
  Self.FRota := '';
  Self.FValorPrestacaoServico := 0;
  Self.FValoraReceber := 0;
  Self.FChaveAcesso := '';
  Self.FIndicadorCTeGlobalizado := '';
  Self.FModeloDocumentoFiscal := '';
  Self.FPercAproximadosTributos := 0;

  Self.FReformaCST       := '';
  Self.FReformaClasTrib  := '';
  Self.FReformaAlqCBS    := 0;
  Self.FReformaAlqIBS_UF := 0;
  Self.FReformaAlqIBS_MN := 0;
  Self.FReformaVlrCBS    := 0;
  Self.FReformaVlrIBS_UF := 0;
  Self.FReformaVlrIBS_MN := 0;

  Self.FTomador := TTomador.create;
  Self.FIdentificacaoEmitente := dadosEmitente;
  Self.FInformacoesRemetente  := TRemetente.create;
  Self.FInformacoesDestinarario := TDestinatario.create;
  Self.FValoresPrestacaoServico := TValoresPrestacaoServico.create;
  Self.FInformacoesImpostos := TInformacoesImpostos.create;
  Self.FInformacoesCarga := TInformacoesCarga.create;
  Self.FInformacoesQtdeCarga := TObjectList.create;
  Self.FInformacoesNFe := TObjectList.create;
  Self.FInformacoesServicoPrestado := TInformacoesServicoPrestado.create;
  Self.FInformacoesRodoviario := TInformacoesRodoviario.create;

  Self.FTipoImpressao := tipoImpressao;
end;

destructor TConhecimentoEletronico.Destroy;
begin
  Self.FTomador.Free;
  Self.FIdentificacaoEmitente.Free;
  Self.FValoresPrestacaoServico.Free;
  Self.FInformacoesImpostos.Free;
  Self.FInformacoesCarga.Free;
  Self.FInformacoesQtdeCarga.Free;
  Self.FInformacoesNFe.Free;
  Self.FInformacoesServicoPrestado.Free;
  Self.FInformacoesRodoviario.Free;
  if Assigned(Self.FPartilha) then
    Self.FPartilha.Free;

  inherited;
end;

function TConhecimentoEletronico.GetCTeInformacoesNFe(Index: Integer): TInformacoesNFe;
begin
  Result := TInformacoesNFe(FInformacoesNFe[Index]);
end;

function TConhecimentoEletronico.GetCTeInformacoesQtdeCarga(Index: Integer): TInformacoesQtdeCarga;
begin
  Result := TInformacoesQtdeCarga(FInformacoesQtdeCarga[Index]);
end;

function TConhecimentoEletronico.GetIdReferencia: string;
begin
  Result := strNumeroConhecimento + strCodEmp;
end;

function TConhecimentoEletronico.GetQtdCTeInformacoesNFe: Integer;
begin
  Result := FInformacoesNFe.Count;
end;

function TConhecimentoEletronico.GetQtdCTeInformacoesQtdeCarga: Integer;
begin
  Result := FInformacoesQtdeCarga.Count;
end;

procedure TConhecimentoEletronico.pAddInformacoesQtdeCarga(InformacoesQtdeCarga: TInformacoesQtdeCarga);
begin
  if (InformacoesQtdeCarga <> Nil) then
    FInformacoesQtdeCarga.Add(InformacoesQtdeCarga);
end;

procedure TConhecimentoEletronico.pAddInformacoesNFe(InformacoesNFe: TInformacoesNFe);
begin
  if (InformacoesNFe <> Nil) then
    FInformacoesNFe.Add(InformacoesNFe);
end;

{ TRemetente }

constructor TRemetente.create;
begin
  inherited Create;

  Self.FCPFCNPJ := '';
  Self.FInscricaoEstadual := '';
  Self.FRazaoSocialNome := '';
  Self.FNomeFantasia := '';
  Self.FTelefone := '';
  Self.FLogradouro := '';
  Self.FNumero := '';
  Self.FComplemento := '';
  Self.FBairro := '';
  Self.FCodIBGE := '';
  Self.FCEP := '';
  Self.FCodPais := '';
  Self.FEmail := '';
end;

{ TDestinatario }

constructor TDestinatario.create;
begin
  inherited Create;

  Self.FCPFCNPJ := '';
  Self.FInscricaoEstadual := '';
  Self.FRazaoSocialNome := '';
  Self.FTelefone := '';
  Self.FSuframa := '';
  Self.FLogradouro := '';
  Self.FNumero := '';
  Self.FComplemento := '';
  Self.FBairro := '';
  Self.FCodIBGE := '';
  Self.FCEP := '';
  Self.FCodPais := '';
  Self.FEmail := '';
end;

{ TPartilhaCTe }

constructor TPartilhaCTe.Create;
begin
  Self.FValorBaseCalculoIcmsUfDestino := 0;
  Self.FAliquotaIcmsInternaUfDestino := 0;
  Self.FAliquotaIcmsInterestadual := 0;
  Self.FValorIcmsPartilhaTermino := 0;
  Self.FValorIcmsPartilhaInicio := 0;
  Self.FAliquotaFcp := 0;
  Self.FValorFcpDestino := 0;
end;

end.
