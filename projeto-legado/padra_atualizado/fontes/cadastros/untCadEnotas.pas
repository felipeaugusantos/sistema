unit untCadEnotas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, IdHTTP, JSON, IdURI, IdSSLOpenSSL, IdAuthentication, IdMultipartFormData,
  Vcl.ComCtrls, Vcl.Mask, Vcl.DBCtrls, DBEditFocus, EditFocus, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxCheckBox, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxImageComboBox,
  DB, Uni, StrUtils, MaskUtils, cxButtons, MaskEditFocus;

type

  TMetodo = (mGet, mPost, mDelete);

  TRetornoIntegracaoCitel = class
    private
      FCodigo: String;
      FMensagem: String;
    public
      property strCodigo: String    read FCodigo     write FCodigo;
      property strMensagem: String  read FMensagem   write FMensagem;
    end;

  TNfeApiWS = class
    private
      FlibApiClient: Cardinal;

      fExecuteAuth2:      function(AMetodo, AUrl, AJsonEnvio, AToken, AContentType, AFormDataField, AFormDataFieldValue, AFormDataFile, AFormDataFilePath, AProxyServer, AProxyPort, AProxyUsername, AProxyPassword: WideString; ABytes: TBytes; out AJsonRetorno: WideString): Integer; stdcall;
      fGetJsonValue:      function(AJsonString, AChave: WideString): WideString; stdcall;
      fGetJsonArrayValue: function(AJsonString, AChaveArr, AChave: WideString; AIndex: Integer): WideString; stdcall;
      fGetToken:          function(ACnpjEmitente: WideString; AChavePublica: TStringList; AUnixTimestamp: Int64): WideString; stdcall;

      function fParseResponse(const AMetodo: TMetodo; const AStatus: Integer; AJson: WideString): TRetornoIntegracaoCitel;
    public
      constructor Create;
      destructor Destroy; override;
      function NfeEnviaRecebeDados(AMetodo: TMetodo; AUrl, AComando, AToken, AJson, AContentType: WideString; ABytes: TBytes;
                                   AFormDataField, AFormDataFieldValue, AFormDataFile, AFormDataFilePath,
                                   AProxyServer, AProxyPort, AProxyUsername, AProxyPassword: WideString;
                                   var ARetorno: String): TRetornoIntegracaoCitel;
    end;

  TRetornoEnotas = class
    private
      FCodigo: String;
      FMensagem: String;
      FRetorno: WideString;
    public
      property strCodigo: String      read FCodigo   write FCodigo;
      property strMensagem: String    read FMensagem write FMensagem;
      property strRetorno: WideString read FRetorno  write FRetorno;
    end;


  TIdentificacao = class
    public
      strId: String;
      strCnpj: String;
      strInscricaoMunicipal: String;
      strInscricaoEstadual: String;
      strRazaoSocial: String;
      strNomeFantasia: String;
      strOptanteSimplesNacional: String;
      strEmiteNFSeNacional: String;
      strEmail: String;
      strEnviarEmailCliente: String;
      strTelefoneComercial: String;
      strIncentivadorCultural: String;
      strStatus: String;
      strDadosObrigatoriosPreenchidos: String;
    end;

  TEndereco = class
    public
      strCodigoIbgeUf: String;
      strCodigoIbgeCidade: String;
      strPais: String;
      strUf: String;
      strCidade: String;
      strLogradouro: String;
      strNumero: String;
      strComplemento: String;
      strBairro: String;
      strCep: String;
    end;

  TDadosMunicipais = class
    public
      strRegimeEspecialTributacao: String;
      strCodigoServicoMunicipal: String;
      strItemListaServicoLC116: String;
      strCnae: String;
      strAliquotaIss: String;
      strDescricaoServico: String;
      strReceitaBrutaAcumulada: String;
      strAnexoEnquadramentoSimplesNacional: String;
      dtaDataInicioAtividadeSimplesNacional: TDateTime;
    end;

  TConfiguracoesNFSeHomologacao = class
    public
      strSequencialNFe: String;
      strSerieNFe: String;
      strSequencialLoteNFe: String;
      strUsuarioAcessoProvedor: String;
      strSenhaAcessoProvedor: String;
      strTokenAcessoProvedor: String;
    end;

  TConfiguracoesNFSeProducao = class
    public
      strSequencialNFe: String;
      strSerieNFe: String;
      strSequencialLoteNFe: String;
      strUsuarioAcessoProvedor: String;
      strSenhaAcessoProvedor: String;
      strTokenAcessoProvedor: String;
    end;

  TEmissaoNFeProdutoProducao = class
    public
      strSequencialNFe: String;
      strSerieNFe: String;
      strSequencialLoteNFe: String;
    end;

  TEmissaoNFeProdutoHomolocacao = class
    public
      strSequencialNFe: String;
      strSerieNFe: String;
      strSequencialLoteNFe: String;
    end;

  TEmissaoNFeConsumidorProducao = class
    public
      strSequencialNFe: String;
      strSerieNFe: String;
      strCscId: String;
      strCscCodigo: String;
    end;

  TEmissaoNFeConsumidorHomologacao = class
    public
      strSequencialNFe: String;
      strSerieNFe: String;
      strCscId: String;
      strCscCodigo: String;
    end;

  TCertificadoDigital = class
    public
      strNome: String;
      strDataVencimento: String;
    end;

  TValorPercentualTributosFederal = class
    public
      strPercentualTotalFederal: String;
      strPercentualTotalEstadual: String;
      strPercentualTotalMunicipal: String;
    end;

  TApiEnotas = class
    private
      WSCitel: TNfeApiWS;

      FApiKey: WideString;
      FProxyServer: String;
      FProxyPort: String;
      FProxyUsername: String;
      FProxyPassword: String;
      FCodigoEmpresa: String;

      FIdentificacao: TIdentificacao;
      FEndereco: TEndereco;
      FDadosMunicipais: TDadosMunicipais;
      FConfiguracoesNFSeHomologacao: TConfiguracoesNFSeHomologacao;
      FConfiguracoesNFSeProducao: TConfiguracoesNFSeProducao;
      FEmissaoNFeProdutoProducao: TEmissaoNFeProdutoProducao;
      FEmissaoNFeProdutoHomolocacao: TEmissaoNFeProdutoHomolocacao;
      FEmissaoNFeConsumidorProducao: TEmissaoNFeConsumidorProducao;
      FEmissaoNFeConsumidorHomologacao: TEmissaoNFeConsumidorHomologacao;
      FCertificadoDigital: TCertificadoDigital;
      FValorPercentualTributosFederal: TValorPercentualTributosFederal;

      function fWSEnviaRecebeDados(AMetodo: TMetodo; AComando, AJson, AFormDataField, AFormDataFieldValue, AFormDataFile, AFormDataFilePath: WideString): TRetornoEnotas;
      function fWSProcessaErro(AError: EIdHTTPProtocolException; AJson: TStringStream): TRetornoEnotas;
      function fDateToStr(const dta: TDateTime): String;
      function fStrToDate(const dta: String): TDateTime;
      function fPreparaCampo(ACampo: String; AAspas: Boolean): String;
      function fPreparaRegistro(AEmpresaId: String=''):WideString;
      function fConsultaCnpj(ACnpj: String): TRetornoEnotas;
      function fCarregaEmpresa(AJson: WideString):Boolean;
      function fCadastraEmpresa: TRetornoEnotas;
      function fAlteraEmpresa(AEmpresaId: String): TRetornoEnotas;
      function fHabilitaEmpresa(AEmpresaId: String): TRetornoEnotas;
      function fDesabilitaEmpresa(AEmpresaId: String): TRetornoEnotas;
      function fVinculaLogotipo(AEmpresaId, ALogoPath: String): TRetornoEnotas;
      function fVinculaCertificadoDigital(AEmpresaId, ACertificadoPath, ACertificadoSenha: String): TRetornoEnotas;
      function fRetornaApiKey: String;
      function fGetJsonValue(const AJsonObj: TJSONObject; const AChave: String): String;
      procedure pCarregaConfiguracoes;
    public
      constructor Create;
      destructor Destroy; override;
      property Identificacao: TIdentificacao Read FIdentificacao Write FIdentificacao;
      property Endereco: TEndereco Read FEndereco Write FEndereco;
      property DadosMunicipais: TDadosMunicipais Read FDadosMunicipais Write FDadosMunicipais;
      property ConfiguracoesNFSeHomologacao: TConfiguracoesNFSeHomologacao Read FConfiguracoesNFSeHomologacao Write FConfiguracoesNFSeHomologacao;
      property ConfiguracoesNFSeProducao: TConfiguracoesNFSeProducao Read FConfiguracoesNFSeProducao Write FConfiguracoesNFSeProducao;
      property EmissaoNFeProdutoProducao: TEmissaoNFeProdutoProducao Read FEmissaoNFeProdutoProducao Write FEmissaoNFeProdutoProducao;
      property EmissaoNFeProdutoHomolocacao: TEmissaoNFeProdutoHomolocacao Read FEmissaoNFeProdutoHomolocacao Write FEmissaoNFeProdutoHomolocacao;
      property EmissaoNFeConsumidorProducao: TEmissaoNFeConsumidorProducao Read FEmissaoNFeConsumidorProducao Write FEmissaoNFeConsumidorProducao;
      property EmissaoNFeConsumidorHomologacao: TEmissaoNFeConsumidorHomologacao Read FEmissaoNFeConsumidorHomologacao Write FEmissaoNFeConsumidorHomologacao;
      property CertificadoDigital: TCertificadoDigital Read FCertificadoDigital Write FCertificadoDigital;
      property ValorPercentualTributosFederal: TValorPercentualTributosFederal Read FValorPercentualTributosFederal Write FValorPercentualTributosFederal;
    end;

type
  TfrmCadEnotas = class(TfrmPai)
    pgcDados: TPageControl;
    tbsIdentificacao: TTabSheet;
    tbsDadosMunicipais: TTabSheet;
    tbsLocalizacao: TTabSheet;
    tbsCertificadoDigital: TTabSheet;
    edtRazaoSocial: TEditFocus;
    lblRazao: TLabel;
    Label1: TLabel;
    edtNomeFantasia: TEditFocus;
    Label2: TLabel;
    edtCnpj: TEditFocus;
    Label3: TLabel;
    edtInscMunicipal: TEditFocus;
    Label4: TLabel;
    edtInscrEstadual: TEditFocus;
    Label5: TLabel;
    edtEmail: TEditFocus;
    Label6: TLabel;
    edtTelefone: TEditFocus;
    chkSimplesNacional: TcxCheckBox;
    Label7: TLabel;
    edtCodigoServicoMunicipal: TEditFocus;
    Label8: TLabel;
    edtAliquotaISS: TEditFocus;
    Label9: TLabel;
    edtDescricaoServico: TEditFocus;
    Label10: TLabel;
    edtCNAE: TEditFocus;
    edtRegimeEspecial: TcxImageComboBox;
    Label11: TLabel;
    chkIncentivadorCultural: TcxCheckBox;
    Label12: TLabel;
    edtUF: TEditFocus;
    Label13: TLabel;
    edtCidade: TEditFocus;
    Label14: TLabel;
    edtCep: TEditFocus;
    Label15: TLabel;
    edtLogradouro: TEditFocus;
    Label16: TLabel;
    edtNumero: TEditFocus;
    edtComplemento: TEditFocus;
    Label17: TLabel;
    Label18: TLabel;
    edtBairro: TEditFocus;
    Label19: TLabel;
    edtCertificadoNome: TEditFocus;
    Label20: TLabel;
    edtCertificadoValidade: TEditFocus;
    pnlSituacao: TPanel;
    Label21: TLabel;
    edtIdentificacao: TEditFocus;
    chkEnviaEmailCliente: TcxCheckBox;
    Label22: TLabel;
    edtItemListaServico: TEditFocus;
    btnAlterar: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnCancelar: TBitBtnLocked;
    btnHabilitar: TBitBtnLocked;
    btnDesabilitar: TBitBtnLocked;
    FileOpenCertificadoPFX: TFileOpenDialog;
    FileOpenLogotipo: TFileOpenDialog;
    btnCertificado: TBitBtnLocked;
    btnLogotipo: TBitBtnLocked;
    btnAtualizaRazaoSocial: TcxButton;
    btnAtualizaNomeFantasia: TcxButton;
    btnAtualizaInscMunicipal: TcxButton;
    btnAtualizaInscrEstadual: TcxButton;
    btnAtualizaEmail: TcxButton;
    btnAtualizaTelefone: TcxButton;
    btnAtualizaCnae: TcxButton;
    btnAtualizaUF: TcxButton;
    btnAtualizaCidade: TcxButton;
    btnAtualizaCep: TcxButton;
    Logradouro: TcxButton;
    btnAtualizaNumero: TcxButton;
    btnAtualizaComplemento: TcxButton;
    btnAtualizaBairro: TcxButton;
    btnAtualizaSimplesNacional: TcxButton;
    btnAtualizaAliquotaISS: TcxButton;
    lblReceitaBruta: TLabel;
    lblEnqSimples: TLabel;
    lblDtaAtivSimples: TLabel;
    edtReceitaBrutaAcumulada: TEditFocus;
    edtAnexoEnquadramentoSimplesNacional: TEditFocus;
    edtDataInicioAtividadeSimplesNacional: TMaskEditFocus;
    chkEmiteNFSeNacional: TcxCheckBox;
    edtPercentualTotalFederal: TEditFocus;
    lblPercentualTotalFederal: TLabel;
    edtPercentualTotalEstadual: TEditFocus;
    lblPercentualTotalEstadual: TLabel;
    lblPercentualTotalMunicipal: TLabel;
    edtPercentualTotalMunicipal: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnHabilitarClick(Sender: TObject);
    procedure btnDesabilitarClick(Sender: TObject);
    procedure btnCertificadoClick(Sender: TObject);
    procedure btnLogotipoClick(Sender: TObject);
    procedure btnAtualizaRazaoSocialClick(Sender: TObject);
    procedure btnAtualizaNomeFantasiaClick(Sender: TObject);
    procedure btnAtualizaInscMunicipalClick(Sender: TObject);
    procedure btnAtualizaInscrEstadualClick(Sender: TObject);
    procedure btnAtualizaEmailClick(Sender: TObject);
    procedure btnAtualizaTelefoneClick(Sender: TObject);
    procedure btnAtualizaSimplesNacionalClick(Sender: TObject);
    procedure btnAtualizaAliquotaISSClick(Sender: TObject);
    procedure btnAtualizaCnaeClick(Sender: TObject);
    procedure btnAtualizaUFClick(Sender: TObject);
    procedure btnAtualizaCidadeClick(Sender: TObject);
    procedure btnAtualizaCepClick(Sender: TObject);
    procedure LogradouroClick(Sender: TObject);
    procedure btnAtualizaNumeroClick(Sender: TObject);
    procedure btnAtualizaComplementoClick(Sender: TObject);
    procedure btnAtualizaBairroClick(Sender: TObject);
    procedure edtRegimeEspecialPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  private
    { Private declarations }
    FApiEnotas: TApiEnotas;
    FRetorno: TRetornoEnotas;
    FPathEnotas: String;
    FCodigoServicoMunicipal: String;
    FItemListaServicoLC116: String;
    FDescricaoServico: String;
    FCertificadoPath: String;
    FCertificadoSenha: String;
    FLogoPath: String;
    procedure pLimpaTela;
    procedure pCarregaTela;
    procedure pAjustaCampos;
    procedure pComparaCampos;
    procedure pHabilitaCampos(AEnabled: Boolean);
    procedure pCarregaServico;
    procedure pAtualizaConfiguracao(ACodigoEmpresa, AEmpresaId: String);
    procedure pPreparaInclusao;
    procedure pPreparandoExibicao;
    procedure pAtualizaRegistros;
    procedure pCadastraEmpresa;
    procedure pAlteraEmpresa;
    procedure pHabilitaEmpresa;
    procedure pDesabilitaEmpresa;
    procedure pVinculaCertificadoDigital;
    procedure pVinculaLogotipo;
    procedure pValidaRetorno;
    procedure pAtualizaCodigoIBGE;
    procedure pAtualizaCertificadoDigital;
    function fCarregaCertificadoDigital: Boolean;
    function fCarregaLogotipo: Boolean;
    function fCamposIncompletos: Boolean;
  public
    { Public declarations }
    FCodigoEmpresa: String;
    FCnpj: String;
    FInscricaoMunicipal: String;
    FInscricaoEstadual: String;
    FRazaoSocial: String;
    FNomeFantasia: String;
    FEmail: String;
    FTelefoneComercial: String;

    FCnae: String;

    FCodigoCidade: String;
    FCodigoIbgeUf: String;
    FCodigoIbgeCidade: String;
    FUf: String;
    FCidade: String;
    FLogradouro: String;
    FNumero: String;
    FComplemento: String;
    FBairro: String;
    FCep: String;

    FExisteInclusaoDeLogotipo: Boolean;
    FExisteInclusaoDeCertificado: Boolean;
    FExibeMensagem: Boolean;

    procedure pEnotasAtualizaCertificadoDigital;
  end;

implementation

uses
  untFuncoesSimples, untFuncoesImagem, untTypesSistema, untGravando, untFuncoesGenerica;

{$R *.dfm}

constructor TApiEnotas.Create;
begin
  WSCitel := TNfeApiWS.Create;

  FIdentificacao                   := TIdentificacao.Create;
  FEndereco                        := TEndereco.Create;
  FDadosMunicipais                 := TDadosMunicipais.Create;
  FConfiguracoesNFSeHomologacao    := TConfiguracoesNFSeHomologacao.Create;
  FConfiguracoesNFSeProducao       := TConfiguracoesNFSeProducao.Create;
  FEmissaoNFeProdutoProducao       := TEmissaoNFeProdutoProducao.Create;
  FEmissaoNFeProdutoHomolocacao    := TEmissaoNFeProdutoHomolocacao.Create;
  FEmissaoNFeConsumidorProducao    := TEmissaoNFeConsumidorProducao.Create;
  FEmissaoNFeConsumidorHomologacao := TEmissaoNFeConsumidorHomologacao.Create;
  FCertificadoDigital              := TCertificadoDigital.Create;
  FValorPercentualTributosFederal  := TValorPercentualTributosFederal.Create;
end;

destructor TApiEnotas.Destroy;
begin
  FreeAndNil(WSCitel);
  FreeAndNil(FIdentificacao);
  FreeAndNil(FEndereco);
  FreeAndNil(FDadosMunicipais);
  FreeAndNil(FConfiguracoesNFSeHomologacao);
  FreeAndNil(FConfiguracoesNFSeProducao);
  FreeAndNil(FEmissaoNFeProdutoProducao);
  FreeAndNil(FEmissaoNFeProdutoHomolocacao);
  FreeAndNil(FEmissaoNFeConsumidorProducao);
  FreeAndNil(FEmissaoNFeConsumidorHomologacao);
  FreeAndNil(FCertificadoDigital);
  FreeAndNil(FValorPercentualTributosFederal);

  inherited;
end;

function TApiEnotas.fRetornaApiKey: String;
begin
  Result := fCfgSis('KEYENO', varString, FCodigoEmpresa);

  If fConteudoEncriptado(Result) Then
  Begin
    Result := fDecriptar(Result);
  End;
end;

procedure TApiEnotas.pCarregaConfiguracoes;
begin
  FApiKey := fRetornaApiKey;

  If fCfgSis('HPXENO', varBoolean, FCodigoEmpresa) Then
  Begin
    FProxyServer   := fCfgSis('EPXENO', varString, FCodigoEmpresa);
    FProxyPort     := fCfgSis('PPXENO', varString, FCodigoEmpresa);
    FProxyUsername := fCfgSis('UPXENO', varString, FCodigoEmpresa);
    FProxyPassword := fCfgSis('SPXENO', varString, FCodigoEmpresa);
  End
end;

function TApiEnotas.fWSProcessaErro(AError: EIdHTTPProtocolException; AJson: TStringStream): TRetornoEnotas;
var
  LJsonObject: TJSONObject;
  LJsonRetorno: String;
begin
  Result := TRetornoEnotas.Create;

  LJsonRetorno := AError.ErrorMessage;
  LJsonRetorno := AnsiReplaceStr(LJsonRetorno, '[', '');
  LJsonRetorno := AnsiReplaceStr(LJsonRetorno, ']', '');

  Try
    LJsonObject := TJSONObject.ParseJSONValue(LJsonRetorno) as TJSONObject;
  Except

  End;

  Try
    If Assigned(LJsonObject) Then
    Begin
      Result.strCodigo   := LJsonObject.GetValue('codigo').Value;
      Result.strMensagem := LJsonObject.GetValue('mensagem').Value;
    End
    Else
    Begin
      Result.strCodigo   := IntToStr(AError.ErrorCode);
      Result.strMensagem := AError.ErrorMessage;

      If Length(Result.strMensagem) > 200 Then
      Begin
        Result.strMensagem := 'Não foi possível conectar na API do eNotas.';
      End;
    End;

    Result.strRetorno  := AJson.DataString;
  Finally
    FreeAndNil(LJsonObject);
  End;
end;

function TApiEnotas.fWSEnviaRecebeDados(AMetodo: TMetodo; AComando: WideString; AJson, AFormDataField, AFormDataFieldValue, AFormDataFile, AFormDataFilePath: WideString): TRetornoEnotas;
var
  LUrl: String;
  LJson: TStringStream;
  LRetornoCitel: TRetornoIntegracaoCitel;
  LContentType: WideString;
  LBytes: TBytes;
  LArquivo: String;
begin
  Result := TRetornoEnotas.Create;

  pCarregaConfiguracoes;

  LJson := TStringStream.Create(AJson, TEncoding.UTF8);

  Try
    LUrl := 'https://api.enotasgw.com.br/v1/';

    LContentType := 'application/json';

    LRetornoCitel := WSCitel.NfeEnviaRecebeDados(AMetodo, LUrl, AComando, 'Basic ' + FApiKey, AJson, LContentType, LBytes, AFormDataField, AFormDataFieldValue, AFormDataFile, AFormDataFilePath,
                                                 FProxyServer, FProxyPort, FProxyUsername, FProxyPassword, LArquivo);

    Result.strCodigo   := LRetornoCitel.strCodigo;
    Result.strMensagem := LRetornoCitel.strMensagem;
    Result.strRetorno  := LArquivo;

  Except
    On E: EIdHTTPProtocolException Do
    Begin
      Result := fWSProcessaErro(E, LJson);
    End;

    on E: Exception do
    Begin
      Result.strCodigo   := '400';
      Result.strMensagem := E.Message;

    End;
  End;
end;

function TApiEnotas.fGetJsonValue(const AJsonObj: TJSONObject; const AChave: String): String;
Var
  LJsonVal: TJSONValue;
begin
  Result := '';

  If not Assigned(AJsonObj) Then
    Exit;

  Try
    LJsonVal := AJsonObj.GetValue(AChave);

    If Assigned(LJsonVal) Then
    Begin
      Result := LJsonVal.Value;
    End;
  Except

  End;
end;

function TApiEnotas.fCarregaEmpresa(AJson: WideString): Boolean;
var
  LDocumento: TJSONObject;
  LRegistro: TJSONObject;
  LEndereco: TJSONObject;
  LConfiguracoesNFSeHomologacao: TJSONObject;
  LConfiguracoesNFSeProducao: TJSONObject;
  LCertificadoDigital: TJSONObject;
  LMetadados: TJSONObject;
  LValorPercentualTributosFederal: TJSONObject;
  LArray: TJsonArray;
  LContador: Integer;
begin
  Result := False;

  Try
    LDocumento := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(AJson), 0) as TJSONObject;
  Except

  End;

  try
    LArray := LDocumento.Get('data').JsonValue as TJSONArray;

    for LContador := 0 to LArray.Count - 1 do
    begin
      LRegistro := LArray.Items[LContador] as TJSONObject;

      Identificacao.strId                           := fGetJsonValue(LRegistro,'id');
      Identificacao.strCnpj                         := fGetJsonValue(LRegistro,'cnpj');
      Identificacao.strInscricaoMunicipal           := fGetJsonValue(LRegistro,'inscricaoMunicipal');
      Identificacao.strInscricaoEstadual            := fGetJsonValue(LRegistro,'inscricaoEstadual');
      Identificacao.strRazaoSocial                  := fGetJsonValue(LRegistro,'razaoSocial');
      Identificacao.strNomeFantasia                 := fGetJsonValue(LRegistro,'nomeFantasia');
      Identificacao.strEmiteNFSeNacional            := fGetJsonValue(LRegistro,'emiteNFSeNacional');
      Identificacao.strOptanteSimplesNacional       := fGetJsonValue(LRegistro,'optanteSimplesNacional');
      Identificacao.strEmail                        := fGetJsonValue(LRegistro,'email');
      Identificacao.strEnviarEmailCliente           := fGetJsonValue(LRegistro,'enviarEmailCliente');
      Identificacao.strTelefoneComercial            := fGetJsonValue(LRegistro,'telefoneComercial');
      Identificacao.strIncentivadorCultural         := fGetJsonValue(LRegistro,'incentivadorCultural');
      Identificacao.strStatus                       := fGetJsonValue(LRegistro,'status');
      Identificacao.strDadosObrigatoriosPreenchidos := fGetJsonValue(LRegistro,'dadosObrigatoriosPreenchidos');

      DadosMunicipais.strRegimeEspecialTributacao   := fGetJsonValue(LRegistro,'regimeEspecialTributacao');
      DadosMunicipais.strCodigoServicoMunicipal     := fGetJsonValue(LRegistro,'codigoServicoMunicipal');
      DadosMunicipais.strItemListaServicoLC116      := fGetJsonValue(LRegistro,'itemListaServicoLC116');
      DadosMunicipais.strCnae                       := fGetJsonValue(LRegistro,'cnae');
      DadosMunicipais.strAliquotaIss                := fGetJsonValue(LRegistro,'aliquotaIss');
      DadosMunicipais.strDescricaoServico           := fGetJsonValue(LRegistro,'descricaoServico');

      If pos(DadosMunicipais.strRegimeEspecialTributacao, '5_6_7_') > 0 Then
      Begin
        DadosMunicipais.strReceitaBrutaAcumulada              := fGetJsonValue(LRegistro,'receitaBrutaAcumulada');
        DadosMunicipais.strAnexoEnquadramentoSimplesNacional  := fGetJsonValue(LRegistro,'anexoEnquadramentoSimplesNacional');
        DadosMunicipais.dtaDataInicioAtividadeSimplesNacional := fStrToDate(fGetJsonValue(LRegistro,'dataInicioAtividadeSimplesNacional'));
      End;

      LEndereco := LRegistro.GetValue('endereco') as TJSONObject;

      If Assigned(LEndereco) Then
      Begin
        Endereco.strCodigoIbgeUf     := fGetJsonValue(LEndereco,'codigoIbgeUf');
        Endereco.strCodigoIbgeCidade := fGetJsonValue(LEndereco,'codigoIbgeCidade');
        Endereco.strPais             := fGetJsonValue(LEndereco,'pais');
        Endereco.strUf               := fGetJsonValue(LEndereco,'uf');
        Endereco.strCidade           := fGetJsonValue(LEndereco,'cidade');
        Endereco.strLogradouro       := fGetJsonValue(LEndereco,'logradouro');
        Endereco.strNumero           := fGetJsonValue(LEndereco,'numero');
        Endereco.strComplemento      := fGetJsonValue(LEndereco,'complemento');
        Endereco.strBairro           := fGetJsonValue(LEndereco,'bairro');
        Endereco.strCep              := fGetJsonValue(LEndereco,'cep');
      End;

      LConfiguracoesNFSeHomologacao := LRegistro.GetValue('configuracoesNFSeHomologacao') as TJSONObject;

      If Assigned(LConfiguracoesNFSeHomologacao) Then
      Begin
        ConfiguracoesNFSeHomologacao.strSequencialNFe         := fGetJsonValue(LConfiguracoesNFSeHomologacao,'sequencialNFe');
        ConfiguracoesNFSeHomologacao.strSerieNFe              := fGetJsonValue(LConfiguracoesNFSeHomologacao,'serieNFe');
        ConfiguracoesNFSeHomologacao.strSequencialLoteNFe     := fGetJsonValue(LConfiguracoesNFSeHomologacao,'sequencialLoteNFe');
        ConfiguracoesNFSeHomologacao.strUsuarioAcessoProvedor := fGetJsonValue(LConfiguracoesNFSeHomologacao,'usuarioAcessoProvedor');
        ConfiguracoesNFSeHomologacao.strSenhaAcessoProvedor   := fCfgSis('SAPENO', varString, FCodigoEmpresa);
        ConfiguracoesNFSeHomologacao.strTokenAcessoProvedor   := fGetJsonValue(LConfiguracoesNFSeHomologacao,'tokenAcessoProvedor');
      End;

      LConfiguracoesNFSeProducao := LRegistro.GetValue('configuracoesNFSeProducao') as TJSONObject;

      If Assigned(LConfiguracoesNFSeProducao) Then
      Begin
        ConfiguracoesNFSeProducao.strSequencialNFe         := fGetJsonValue(LConfiguracoesNFSeProducao,'sequencialNFe');
        ConfiguracoesNFSeProducao.strSerieNFe              := fGetJsonValue(LConfiguracoesNFSeProducao,'serieNFe');
        ConfiguracoesNFSeProducao.strSequencialLoteNFe     := fGetJsonValue(LConfiguracoesNFSeProducao,'sequencialLoteNFe');
        ConfiguracoesNFSeProducao.strUsuarioAcessoProvedor := fGetJsonValue(LConfiguracoesNFSeProducao,'usuarioAcessoProvedor');
        ConfiguracoesNFSeProducao.strSenhaAcessoProvedor   := fCfgSis('SAPENO', varString, FCodigoEmpresa);
        ConfiguracoesNFSeProducao.strTokenAcessoProvedor   := fGetJsonValue(LConfiguracoesNFSeProducao,'tokenAcessoProvedor');
      End;

      LCertificadoDigital := LRegistro.GetValue('certificadoDigital') as TJSONObject;

      If Assigned(LCertificadoDigital) Then
      Begin
        CertificadoDigital.strNome           := fGetJsonValue(LCertificadoDigital,'nome');
        CertificadoDigital.strDataVencimento := fGetJsonValue(LCertificadoDigital,'dataVencimento');
      End;

      LMetadados := LRegistro.GetValue('metadados') as TJSONObject;

      If Assigned(LMetadados) Then
      Begin
        LValorPercentualTributosFederal := LMetadados.GetValue('valorPercentualTributosFederal') as TJSONObject;

        If Assigned(LValorPercentualTributosFederal) Then
        Begin
          ValorPercentualTributosFederal.strPercentualTotalFederal   := fGetJsonValue(LValorPercentualTributosFederal,'PercentualTotalFederal');
          ValorPercentualTributosFederal.strPercentualTotalEstadual  := fGetJsonValue(LValorPercentualTributosFederal,'PercentualTotalEstadual');
          ValorPercentualTributosFederal.strPercentualTotalMunicipal := fGetJsonValue(LValorPercentualTributosFederal,'PercentualTotalMunicipal');
        End;
      End;

      Result := True;
    end;
  finally
    FreeAndNil(LDocumento);
  end;
end;

// https://api.enotasgw.com.br/v1/empresas
function TApiEnotas.fConsultaCnpj(ACnpj: String): TRetornoEnotas;
var
  LComando: WideString;
begin
  LComando := 'empresas?pageNumber=0&pageSize=5&searchBy=CNPJ&searchTerm='+ACnpj;

  Result := fWSEnviaRecebeDados(mGet, LComando, '', '', '', '', '');
end;

function TApiEnotas.fDateToStr(const dta: TDateTime): String;
begin
  Result := FormatDateTime('yyyy-mm-dd"T"00:00:00"Z"', dta);
end;

function TApiEnotas.fStrToDate(const dta: String): TDateTime;
var
  LData, LDia, LMes, LAno: String;
begin
  LAno  := Copy(dta, 1, 4);
  LMes  := Copy(dta, 6, 2);
  LDia  := Copy(dta, 9, 2);
  LData := LDia + '/' + LMes + '/' + LAno;

  Try
    Result := StrToDate(LData);
  Except
    Result := 0;
  End;

end;

function TApiEnotas.fPreparaCampo(ACampo: String; AAspas: Boolean): String;
begin
  Result := ACampo;

  If ACampo.IsEmpty Then
  Begin
    Result := 'null';
    Exit;
  End;

  If UpperCase(ACampo) = 'NULL' Then
  Begin
    Result := 'null';
    Exit;
  End;

  If AAspas Then
  Begin
    Result := '"' + ACampo + '"';
  End;
end;

function TApiEnotas.fPreparaRegistro(AEmpresaId: String):WideString;
var
  strIdentificacao: String;
  strEndereco: String;
  strDadosMunicipais: String;
  strConfiguracoesNFSeHomologacao: String;
  strConfiguracoesNFSeProducao: String;
  strEmissaoNFeProduto: String;
  strEmissaoNFeConsumidor: String;
  strValorPercentualTributosFederal: String;
  LId: String;
begin
  If AEmpresaId.IsEmpty Then
    LId := 'null'
  Else
    LId := AEmpresaId;

  strIdentificacao :=
    '  "id": '+fPreparaCampo(Lid, True)+', '+
    '  "cnpj": '+fPreparaCampo(fRetSomenteNumeros(Identificacao.strCnpj), True)+', '+
    '  "inscricaoMunicipal": '+fPreparaCampo(fRetSomenteNumeros(Identificacao.strInscricaoMunicipal), True)+', '+
    '  "inscricaoEstadual": '+fPreparaCampo(fRetSomenteNumeros(Identificacao.strInscricaoEstadual), True)+', '+
    '  "razaoSocial": '+fPreparaCampo(Identificacao.strRazaoSocial, True)+', '+
    '  "nomeFantasia": '+fPreparaCampo(Identificacao.strNomeFantasia, True)+', '+
    '  "emiteNFSeNacional": '+fPreparaCampo(Identificacao.strEmiteNFSeNacional, False)+', '+
    '  "optanteSimplesNacional": '+fPreparaCampo(Identificacao.strOptanteSimplesNacional, False)+', '+
    '  "email": '+fPreparaCampo(Identificacao.strEmail, True)+', '+
    '  "enviarEmailCliente": '+fPreparaCampo(Identificacao.strEnviarEmailCliente, False)+', '+
    '  "telefoneComercial": '+fPreparaCampo(fRetSomenteNumeros(Identificacao.strTelefoneComercial), True)+', '+
    '  "incentivadorCultural": '+fPreparaCampo(Identificacao.strIncentivadorCultural, False)+', ';

  strEndereco :=
    '  "endereco": { '+
    '    "codigoIbgeUf": '+fPreparaCampo(Endereco.strCodigoIbgeUf, False)+', '+
    '    "codigoIbgeCidade": '+fPreparaCampo(Endereco.strCodigoIbgeCidade, False)+', '+
    '    "pais": "Brasil", '+
    '    "uf": '+fPreparaCampo(Endereco.strUf, True)+', '+
    '    "cidade": '+fPreparaCampo(Endereco.strCidade, True)+', '+
    '    "logradouro": '+fPreparaCampo(Endereco.strLogradouro, True)+', '+
    '    "numero": '+fPreparaCampo(Endereco.strNumero, True)+', '+
    '    "complemento": '+fPreparaCampo(Endereco.strComplemento, True)+', '+
    '    "bairro": '+fPreparaCampo(Endereco.strBairro, True)+', '+
    '    "cep": '+fPreparaCampo(fRetSomenteNumeros(Endereco.strCep), True)+
    '  }, ';

  strDadosMunicipais :=
    '  "regimeEspecialTributacao": '+fPreparaCampo(DadosMunicipais.strRegimeEspecialTributacao, True)+', '+
    '  "codigoServicoMunicipal": '+fPreparaCampo(DadosMunicipais.strCodigoServicoMunicipal, True)+', '+
    '  "itemListaServicoLC116": '+fPreparaCampo(DadosMunicipais.strItemListaServicoLC116, True)+', '+
    '  "cnae": '+fPreparaCampo(DadosMunicipais.strCnae, True)+', '+
    '  "aliquotaIss": '+fPreparaCampo(DadosMunicipais.strAliquotaIss, False)+', '+
    '  "descricaoServico": '+fPreparaCampo(DadosMunicipais.strDescricaoServico, True)+', ';

  If pos(DadosMunicipais.strRegimeEspecialTributacao, '5_6_7_') > 0 Then
  Begin
    strDadosMunicipais := strDadosMunicipais +
      '  "receitaBrutaAcumulada": '+fPreparaCampo(DadosMunicipais.strReceitaBrutaAcumulada, False)+', '+
      '  "anexoEnquadramentoSimplesNacional": '+fPreparaCampo(DadosMunicipais.strAnexoEnquadramentoSimplesNacional, True)+', '+
      '  "dataInicioAtividadeSimplesNacional": "'+fDateToStr(DadosMunicipais.dtaDataInicioAtividadeSimplesNacional)+'", ';
  End;

  strConfiguracoesNFSeHomologacao :=
    '  "configuracoesNFSeHomologacao": { '+
    '    "sequencialNFe": '+fPreparaCampo(ConfiguracoesNFSeHomologacao.strSequencialNFe, False)+', '+
    '    "serieNFe": '+fPreparaCampo(ConfiguracoesNFSeHomologacao.strSerieNFe, True)+', '+
    '    "sequencialLoteNFe": '+fPreparaCampo(ConfiguracoesNFSeHomologacao.strSequencialLoteNFe, False)+', '+
    '    "usuarioAcessoProvedor": '+fPreparaCampo(ConfiguracoesNFSeHomologacao.strUsuarioAcessoProvedor, True)+', '+
    '    "SenhaAcessoProvedor": '+fPreparaCampo(ConfiguracoesNFSeHomologacao.strSenhaAcessoProvedor, True)+', '+
    '    "tokenAcessoProvedor": '+fPreparaCampo(ConfiguracoesNFSeHomologacao.strTokenAcessoProvedor, True)+
    '  }, ';

  strConfiguracoesNFSeProducao :=
    '  "configuracoesNFSeProducao": { '+
    '    "sequencialNFe": '+fPreparaCampo(ConfiguracoesNFSeProducao.strSequencialNFe, False)+', '+
    '    "serieNFe": '+fPreparaCampo(ConfiguracoesNFSeProducao.strSerieNFe, True)+', '+
    '    "sequencialLoteNFe": '+fPreparaCampo(ConfiguracoesNFSeProducao.strSequencialLoteNFe, False)+', '+
    '    "usuarioAcessoProvedor": '+fPreparaCampo(ConfiguracoesNFSeProducao.strUsuarioAcessoProvedor, True)+', '+
    '    "senhaAcessoProvedor": '+fPreparaCampo(ConfiguracoesNFSeProducao.strSenhaAcessoProvedor, True)+', '+
    '    "tokenAcessoProvedor": '+fPreparaCampo(ConfiguracoesNFSeProducao.strTokenAcessoProvedor, True)+
    '  }, ';

  strEmissaoNFeProduto :=
    '   "emissaoNFeProduto":{ '+
    '      "ambienteProducao":{ '+
    '         "sequencialNFe": '+fPreparaCampo(EmissaoNFeProdutoProducao.strSequencialNFe, False)+', '+
    '         "serieNFe": '+fPreparaCampo(EmissaoNFeProdutoProducao.strSerieNFe, True)+', '+
    '         "sequencialLoteNFe":'+fPreparaCampo(EmissaoNFeProdutoProducao.strSequencialLoteNFe, False)+' '+
    '      }, '+
    '      "ambienteHomologacao":{ '+
    '         "sequencialNFe":'+fPreparaCampo(EmissaoNFeProdutoHomolocacao.strSequencialNFe, False)+', '+
    '         "serieNFe":'+fPreparaCampo(EmissaoNFeProdutoHomolocacao.strSerieNFe, True)+', '+
    '         "sequencialLoteNFe":'+fPreparaCampo(EmissaoNFeProdutoHomolocacao.strSequencialLoteNFe, False)+' '+
    '      } '+
    '   }, ';

  strEmissaoNFeConsumidor :=
    '   "emissaoNFeConsumidor":{ '+
    '      "ambienteProducao":{ '+
    '         "sequencialNFe":'+fPreparaCampo(EmissaoNFeConsumidorProducao.strSequencialNFe, False)+', '+
    '         "serieNFe":'+fPreparaCampo(EmissaoNFeConsumidorProducao.strSerieNFe, True)+', '+
    '         "csc":{ '+
    '            "id":'+fPreparaCampo(EmissaoNFeConsumidorProducao.strCscId, True)+', '+
    '            "codigo":'+fPreparaCampo(EmissaoNFeConsumidorProducao.strCscCodigo, True)+' '+
    '         } '+
    '      }, '+
    '      "ambienteHomologacao":{ '+
    '         "sequencialNFe":'+fPreparaCampo(EmissaoNFeConsumidorHomologacao.strSequencialNFe, False)+', '+
    '         "serieNFe":'+fPreparaCampo(EmissaoNFeConsumidorHomologacao.strSerieNFe, True)+', '+
    '         "csc":{ '+
    '            "id":'+fPreparaCampo(EmissaoNFeConsumidorHomologacao.strCscId, True)+', '+
    '            "codigo":'+fPreparaCampo(EmissaoNFeConsumidorHomologacao.strCscCodigo, True)+' '+
    '         } '+
    '      } '+
    '   }, ';

  strValorPercentualTributosFederal :=
    '   "metadados": { '+
    '     "valorPercentualTributosFederal": { '+
    '       "PercentualTotalFederal":'+fPreparaCampo(ValorPercentualTributosFederal.strPercentualTotalFederal, False)+', '+
    '       "PercentualTotalEstadual":'+fPreparaCampo(ValorPercentualTributosFederal.strPercentualTotalEstadual, False)+', '+
    '       "PercentualTotalMunicipal":'+fPreparaCampo(ValorPercentualTributosFederal.strPercentualTotalMunicipal, False)+' '+
    '     } '+
    '   } ';

  Result := '{'+ strIdentificacao + strEndereco + strDadosMunicipais + strConfiguracoesNFSeHomologacao + strConfiguracoesNFSeProducao + strEmissaoNFeProduto + strEmissaoNFeConsumidor + strValorPercentualTributosFederal + '}';
end;

// https://api.enotasgw.com.br/v1/empresas
function TApiEnotas.fCadastraEmpresa: TRetornoEnotas;
var
  LComando: WideString;
  LJson: WideString;
begin
  LJson := fPreparaRegistro;

  LComando := 'empresas';

  Result := fWSEnviaRecebeDados(mPost, LComando, LJson, '', '', '', '');
end;

// https://api.enotasgw.com.br/v1/empresas
function TApiEnotas.fAlteraEmpresa(AEmpresaId: String): TRetornoEnotas;
var
  LComando: WideString;
  LJson: WideString;
begin
  LJson := fPreparaRegistro(AEmpresaId);

  LComando := 'empresas';

  Result := fWSEnviaRecebeDados(mPost, LComando, LJson, '', '', '', '');
end;

//https://api.enotasgw.com.br/v1/empresas/{empresaId}/habilitar
function TApiEnotas.fHabilitaEmpresa(AEmpresaId: String): TRetornoEnotas;
var
  LComando: WideString;
begin
  LComando := 'empresas/' + AEmpresaId + '/habilitar';

  Result := fWSEnviaRecebeDados(mPost, LComando, '', '', '', '', '');
end;

// https://api.enotasgw.com.br/v1/empresas/{empresaId}/desabilitar
function TApiEnotas.fDesabilitaEmpresa(AEmpresaId: String): TRetornoEnotas;
var
  LComando: WideString;
begin
  LComando := 'empresas/' + AEmpresaId + '/desabilitar';

  Result := fWSEnviaRecebeDados(mPost, LComando, '', '', '', '', '');
end;

// https://api.enotasgw.com.br/v1/empresas/{empresaId}/certificadoDigital
function TApiEnotas.fVinculaCertificadoDigital(AEmpresaId, ACertificadoPath, ACertificadoSenha: String): TRetornoEnotas;
var
  LComando: WideString;
begin
  LComando := 'empresas/' + AEmpresaId + '/certificadoDigital';

  Result := fWSEnviaRecebeDados(mPost, LComando, '', 'senha', ACertificadoSenha, 'arquivo', ACertificadoPath);
end;

// https://api.enotasgw.com.br/v1/empresas/{empresaId}/logo
function TApiEnotas.fVinculaLogotipo(AEmpresaId, ALogoPath: String): TRetornoEnotas;
var
  LComando: WideString;
begin
  LComando := 'empresas/' + AEmpresaId + '/logo';

  Result := fWSEnviaRecebeDados(mPost, LComando, '', '', '', 'logotipo', ALogoPath);
end;

procedure TfrmCadEnotas.pHabilitaCampos(AEnabled: Boolean);
var
  LContador: Integer;
begin
  For LContador := 0 To Self.ComponentCount -1 Do
  Begin
    If (Self.Components[LContador] Is TEditFocus) Then
    Begin
      If (Self.Components[LContador] As TEditFocus).Tag = 99 Then
      Begin
        (Self.Components[LContador] As TEditFocus).Enabled := AEnabled;
      End;
    End;
  End;

  For LContador := 0 To Self.ComponentCount -1 Do
  Begin
    If (Self.Components[LContador] Is TcxButton) Then
    Begin
      (Self.Components[LContador] As TcxButton).Enabled := AEnabled;
    End;
  End;

  chkSimplesNacional.Enabled      := False;
  edtRegimeEspecial.Enabled       := AEnabled;
  chkEnviaEmailCliente.Enabled    := AEnabled;
  chkEmiteNFSeNacional.Enabled    := AEnabled;
  chkIncentivadorCultural.Enabled := AEnabled;
  edtDataInicioAtividadeSimplesNacional.Enabled := AEnabled;

  btnAlterar.Enabled     := not AEnabled;
  btnGravar.Enabled      := AEnabled;
  btnCancelar.Enabled    := AEnabled;
  btnCertificado.Enabled := not AEnabled;
  btnLogotipo.Enabled    := not AEnabled;

  If fEmptyStr(edtIdentificacao.Text) Then
  Begin
    btnHabilitar.Enabled   := False;
    btnDesabilitar.Enabled := False;
    btnCertificado.Enabled := False;
    btnLogotipo.Enabled    := False;
  End;

  If (edtRegimeEspecial.ItemIndex < 5) Then
  Begin
    edtReceitaBrutaAcumulada.Enabled := False;
    edtAnexoEnquadramentoSimplesNacional.Enabled  := False;
    edtDataInicioAtividadeSimplesNacional.Enabled := False;
  End;

  If not fCfgSis('USASER', varBoolean, FCodigoEmpresa) Then
  Begin
    edtCodigoServicoMunicipal.Enabled   := False;
    edtAliquotaISS.Enabled              := False;
    edtDescricaoServico.Enabled         := False;
    edtItemListaServico.Enabled         := False;
    edtRegimeEspecial.Enabled           := False;
    chkEmiteNFSeNacional.Enabled        := False;
    chkIncentivadorCultural.Enabled     := False;
    edtReceitaBrutaAcumulada.Enabled    := False;
    edtPercentualTotalFederal.Enabled   := False;
    edtPercentualTotalEstadual.Enabled  := False;
    edtPercentualTotalMunicipal.Enabled := False;
    edtAnexoEnquadramentoSimplesNacional.Enabled  := False;
    edtDataInicioAtividadeSimplesNacional.Enabled := False;
  End;

  If Assigned(FApiEnotas) Then
  Begin
    If FApiEnotas.Identificacao.strStatus = 'Habilitada' Then
    Begin
      btnHabilitar.Enabled   := False;
      btnDesabilitar.Enabled := not AEnabled;
    End
    Else
    Begin
      btnHabilitar.Enabled   := not AEnabled;
      btnDesabilitar.Enabled := False;
    End;
  End;

  btnLogotipo.Visible    := not FExisteInclusaoDeLogotipo;
  btnCertificado.Visible := not FExisteInclusaoDeCertificado;
end;

procedure TfrmCadEnotas.pLimpaTela;
var
  LContador: Integer;
begin
  pgcDados.ActivePage := tbsIdentificacao;

  For LContador := 0 To Self.ComponentCount -1 Do
  Begin
    If (Self.Components[LContador] Is TEditFocus) Then
    Begin
      (Self.Components[LContador] As TEditFocus).Clear;
    End;
  End;

  chkSimplesNacional.Checked      := False;
  chkEnviaEmailCliente.Checked    := False;
  chkEmiteNFSeNacional.Checked    := False;
  chkIncentivadorCultural.Checked := False;
end;

procedure TfrmCadEnotas.pAjustaCampos;
var
  LContador: Integer;
begin
  For LContador := 0 To Self.ComponentCount -1 Do
  Begin
    If (Self.Components[LContador] Is TEditFocus) Then
    Begin
      If UpperCase((Self.Components[LContador] As TEditFocus).Text) = 'NULL' Then
        (Self.Components[LContador] As TEditFocus).Clear;
    End;
  End;
end;

procedure TfrmCadEnotas.pComparaCampos;
begin
  If Assigned(FApiEnotas) Then
  Begin
    btnAtualizaRazaoSocial.Visible     := (fTrimAll(edtRazaoSocial.Text)   <> fTrimAll(FRazaoSocial));
    btnAtualizaNomeFantasia.Visible    := (fTrimAll(edtNomeFantasia.Text)  <> fTrimAll(FNomeFantasia));
    btnAtualizaInscMunicipal.Visible   := (fTrimAll(edtInscMunicipal.Text) <> fTrimAll(FInscricaoMunicipal));
    btnAtualizaInscrEstadual.Visible   := (fTrimAll(edtInscrEstadual.Text) <> fTrimAll(FInscricaoEstadual));
    btnAtualizaEmail.Visible           := (fTrimAll(edtEmail.Text)         <> fTrimAll(FEmail));
    btnAtualizaTelefone.Visible        := (fTrimAll(edtTelefone.Text)      <> fTrimAll(FormatMaskText('(99) 9999-9999;0;', FTelefoneComercial)));
    btnAtualizaSimplesNacional.Visible := (chkSimplesNacional.Checked      <> fCfgSis('SIMPAU', varBoolean, FCodigoEmpresa));

    btnAtualizaUF.Visible              := (fTrimAll(edtUF.Text)          <> fTrimAll(FUf));
    btnAtualizaCidade.Visible          := (fTrimAll(fRemoveAcento(edtCidade.Text)) <> fTrimAll(fRemoveAcento(FCidade)));
    btnAtualizaCep.Visible             := (fTrimAll(edtCep.Text)         <> fTrimAll(FormatMaskText('99999-999;0;', FCep)));
    Logradouro.Visible                 := (fTrimAll(edtLogradouro.Text)  <> fTrimAll(FLogradouro));
    btnAtualizaNumero.Visible          := (fTrimAll(edtNumero.Text)      <> fTrimAll(FNumero));
    btnAtualizaComplemento.Visible     := (fTrimAll(edtComplemento.Text) <> fTrimAll(FComplemento));
    btnAtualizaBairro.Visible          := (fTrimAll(edtBairro.Text)      <> fTrimAll(FBairro));

    btnAtualizaCnae.Visible            := (fTrimAll(edtCNAE.Text)        <> fTrimAll(FCnae));

    If fCfgSis('USASER', varBoolean, FCodigoEmpresa) Then
    Begin
      btnAtualizaAliquotaISS.Visible := (edtAliquotaISS.Text <> AnsiReplaceStr(fCfgSis('PERISS', varString, FCodigoEmpresa), '.', ','));
    End;
  End;
end;

function TfrmCadEnotas.fCamposIncompletos: Boolean;
var
  LContador: Integer;
begin
  Result := False;

  If fCfgSis('USASER', varBoolean, FCodigoEmpresa) Then
  Begin
    For LContador := 0 To Self.ComponentCount -1 Do
    Begin
      If (Self.Components[LContador] Is TEditFocus) Then
      Begin
        If not ((Self.Components[LContador] As TEditFocus).Tag = 99) Then
          Continue;

        If not (Self.Components[LContador] As TEditFocus).Enabled Then
          Continue;

        If fEmptyStr(fTiraCaracEspeciais((Self.Components[LContador] As TEditFocus).Text)) Then
        Begin
          Result := True;
          Exit;
        End
      End;

      If (Self.Components[LContador] Is TMaskEditFocus) Then
      Begin
        If not ((Self.Components[LContador] As TMaskEditFocus).Tag = 99) Then
          Continue;

        If not (Self.Components[LContador] As TMaskEditFocus).Enabled Then
          Continue;

        If fEmptyStr(fTiraCaracEspeciais((Self.Components[LContador] As TMaskEditFocus).Text)) Then
        Begin
          Result := True;
          Exit;
        End
      End;
    End;
  End;

  pnlSituacao.Caption := 'Cadastro ' + IIF(Result, 'Incompleto','Completo');
end;

procedure TfrmCadEnotas.pCarregaTela;
begin
  If Assigned(FApiEnotas) Then
  Begin
    edtIdentificacao.Text := FApiEnotas.Identificacao.strId;
    edtCnpj.Text          := FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_G_C_), FApiEnotas.Identificacao.strCnpj);
    edtInscMunicipal.Text := FApiEnotas.Identificacao.strInscricaoMunicipal;
    edtInscrEstadual.Text := FApiEnotas.Identificacao.strInscricaoEstadual;
    edtRazaoSocial.Text   := FApiEnotas.Identificacao.strRazaoSocial;
    edtNomeFantasia.Text  := FApiEnotas.Identificacao.strNomeFantasia;
    edtEmail.Text         := FApiEnotas.Identificacao.strEmail;
    edtTelefone.Text      := FormatMaskText('(99) 9999-9999;0;', FApiEnotas.Identificacao.strTelefoneComercial);

    chkSimplesNacional.Checked      := IIF(FApiEnotas.Identificacao.strOptanteSimplesNacional = 'true', True, False);
    chkEnviaEmailCliente.Checked    := IIF(FApiEnotas.Identificacao.strEnviarEmailCliente     = 'true', True, False);
    chkEmiteNFSeNacional.Checked    := IIF(FApiEnotas.Identificacao.strEmiteNFSeNacional      = 'true', True, False);
    chkIncentivadorCultural.Checked := IIF(FApiEnotas.Identificacao.strIncentivadorCultural   = 'true', True, False);

    edtRegimeEspecial.ItemIndex    := StrToIntDef(FApiEnotas.DadosMunicipais.strRegimeEspecialTributacao, 0);
    edtCodigoServicoMunicipal.Text := FApiEnotas.DadosMunicipais.strCodigoServicoMunicipal;
    edtItemListaServico.Text       := FApiEnotas.DadosMunicipais.strItemListaServicoLC116;
    edtCnae.Text                   := FApiEnotas.DadosMunicipais.strCnae;
    edtAliquotaISS.Text            := FApiEnotas.DadosMunicipais.strAliquotaIss;
    edtDescricaoServico.Text       := FApiEnotas.DadosMunicipais.strDescricaoServico;

    If edtRegimeEspecial.ItemIndex in [5,6,7] Then
    Begin
      edtReceitaBrutaAcumulada.Text              := FormatFloat('0.00', StrToFloatDef(FApiEnotas.DadosMunicipais.strReceitaBrutaAcumulada, 0));
      edtAnexoEnquadramentoSimplesNacional.Text  := FApiEnotas.DadosMunicipais.strAnexoEnquadramentoSimplesNacional;
      edtDataInicioAtividadeSimplesNacional.Text := DateToStr(FApiEnotas.DadosMunicipais.dtaDataInicioAtividadeSimplesNacional);
    End;

    edtUF.Text          := FApiEnotas.Endereco.strUf;
    edtCidade.Text      := FApiEnotas.Endereco.strCidade;
    edtLogradouro.Text  := FApiEnotas.Endereco.strLogradouro;
    edtNumero.Text      := FApiEnotas.Endereco.strNumero;
    edtComplemento.Text := FApiEnotas.Endereco.strComplemento;
    edtBairro.Text      := FApiEnotas.Endereco.strBairro;
    edtCep.Text         := FormatMaskText('99999-999;0;', FApiEnotas.Endereco.strCep);

    edtCertificadoNome.Text     := FApiEnotas.CertificadoDigital.strNome;
    edtCertificadoValidade.Text := FApiEnotas.CertificadoDigital.strDataVencimento;

    edtPercentualTotalFederal.Text   := FApiEnotas.ValorPercentualTributosFederal.strPercentualTotalFederal;
    edtPercentualTotalEstadual.Text  := FApiEnotas.ValorPercentualTributosFederal.strPercentualTotalEstadual;
    edtPercentualTotalMunicipal.Text := FApiEnotas.ValorPercentualTributosFederal.strPercentualTotalMunicipal;

    edtPercentualTotalFederal.Text   := IIF(fEmptyStr(edtPercentualTotalFederal.Text), '0', edtPercentualTotalFederal.Text);
    edtPercentualTotalEstadual.Text  := IIF(fEmptyStr(edtPercentualTotalEstadual.Text), '0', edtPercentualTotalEstadual.Text);
    edtPercentualTotalMunicipal.Text := IIF(fEmptyStr(edtPercentualTotalMunicipal.Text), '0', edtPercentualTotalMunicipal.Text);

    pnlSituacao.Caption := IIF(FApiEnotas.Identificacao.strDadosObrigatoriosPreenchidos = 'true', 'Tudo certo para você começar a emitir!',
                                                                                                  'Estão faltando informações ou estão incorretas');

    If FApiEnotas.Identificacao.strStatus = 'Habilitada' Then
    Begin
      btnHabilitar.Enabled   := False;
      btnDesabilitar.Enabled := True;
    End
    Else
    Begin
      btnHabilitar.Enabled   := True;
      btnDesabilitar.Enabled := False;
    End;

    pAjustaCampos;
    pComparaCampos;
  End;
end;

procedure TfrmCadEnotas.pAtualizaRegistros;
begin
  If Assigned(FApiEnotas) Then
  Begin
    FApiEnotas.Identificacao.strCnpj               := edtCnpj.Text;
    FApiEnotas.Identificacao.strInscricaoMunicipal := edtInscMunicipal.Text;
    FApiEnotas.Identificacao.strInscricaoEstadual  := edtInscrEstadual.Text;
    FApiEnotas.Identificacao.strRazaoSocial        := edtRazaoSocial.Text;
    FApiEnotas.Identificacao.strNomeFantasia       := edtNomeFantasia.Text;
    FApiEnotas.Identificacao.strEmail              := edtEmail.Text;
    FApiEnotas.Identificacao.strTelefoneComercial  := edtTelefone.Text;

    FApiEnotas.Identificacao.strOptanteSimplesNacional := IIF(chkSimplesNacional.Checked,      'true','false');
    FApiEnotas.Identificacao.strEnviarEmailCliente     := IIF(chkEnviaEmailCliente.Checked,    'true','false');
    FApiEnotas.Identificacao.strEmiteNFSeNacional      := IIF(chkEmiteNFSeNacional.Checked,    'true','false');
    FApiEnotas.Identificacao.strIncentivadorCultural   := IIF(chkIncentivadorCultural.Checked, 'true','false');

    FApiEnotas.DadosMunicipais.strRegimeEspecialTributacao := IntToStr(edtRegimeEspecial.ItemIndex);
    FApiEnotas.DadosMunicipais.strCodigoServicoMunicipal   := edtCodigoServicoMunicipal.Text;
    FApiEnotas.DadosMunicipais.strItemListaServicoLC116    := edtItemListaServico.Text;
    FApiEnotas.DadosMunicipais.strCnae                     := edtCnae.Text;
    FApiEnotas.DadosMunicipais.strAliquotaIss              := AnsiReplaceStr(edtAliquotaISS.Text, ',','.');
    FApiEnotas.DadosMunicipais.strDescricaoServico         := edtDescricaoServico.Text;

    If pos(FApiEnotas.DadosMunicipais.strRegimeEspecialTributacao, '5_6_7_') > 0 Then
    Begin
      FApiEnotas.DadosMunicipais.strReceitaBrutaAcumulada              := AnsiReplaceStr(edtReceitaBrutaAcumulada.Text, ',','.');
      FApiEnotas.DadosMunicipais.strAnexoEnquadramentoSimplesNacional  := edtAnexoEnquadramentoSimplesNacional.Text;
      FApiEnotas.DadosMunicipais.dtaDataInicioAtividadeSimplesNacional := StrToDate(edtDataInicioAtividadeSimplesNacional.Text);
    End;

    FApiEnotas.Endereco.strUf          := edtUF.Text;
    FApiEnotas.Endereco.strCidade      := edtCidade.Text;
    FApiEnotas.Endereco.strLogradouro  := edtLogradouro.Text;
    FApiEnotas.Endereco.strNumero      := edtNumero.Text;
    FApiEnotas.Endereco.strComplemento := edtComplemento.Text;
    FApiEnotas.Endereco.strBairro      := edtBairro.Text;
    FApiEnotas.Endereco.strCep         := edtCep.Text;

    FApiEnotas.ConfiguracoesNFSeHomologacao.strSequencialNFe         := fRetiraZerosEsquerda(fCfgSis('PRO_NS', varString, FCodigoEmpresa));
    FApiEnotas.ConfiguracoesNFSeHomologacao.strSerieNFe              := fCfgSis('SERNFS', varString, FCodigoEmpresa);
    FApiEnotas.ConfiguracoesNFSeHomologacao.strSequencialLoteNFe     := '1';
    FApiEnotas.ConfiguracoesNFSeHomologacao.strUsuarioAcessoProvedor := fCfgSis('UAPENO', varString, FCodigoEmpresa);
    FApiEnotas.ConfiguracoesNFSeHomologacao.strSenhaAcessoProvedor   := fCfgSis('SAPENO', varString, FCodigoEmpresa);
    FApiEnotas.ConfiguracoesNFSeHomologacao.strTokenAcessoProvedor   := fCfgSis('TKNENO', varString, FCodigoEmpresa);

    FApiEnotas.ConfiguracoesNFSeProducao.strSequencialNFe            := fRetiraZerosEsquerda(fCfgSis('PRO_NS', varString, FCodigoEmpresa));
    FApiEnotas.ConfiguracoesNFSeProducao.strSerieNFe                 := fCfgSis('SERNFS', varString, FCodigoEmpresa);
    FApiEnotas.ConfiguracoesNFSeProducao.strSequencialLoteNFe        := '1';
    FApiEnotas.ConfiguracoesNFSeProducao.strUsuarioAcessoProvedor    := fCfgSis('UAPENO', varString, FCodigoEmpresa);
    FApiEnotas.ConfiguracoesNFSeProducao.strSenhaAcessoProvedor      := fCfgSis('SAPENO', varString, FCodigoEmpresa);
    FApiEnotas.ConfiguracoesNFSeProducao.strTokenAcessoProvedor      := fCfgSis('TKNENO', varString, FCodigoEmpresa);

    FApiEnotas.EmissaoNFeProdutoProducao.strSequencialNFe            := fRetiraZerosEsquerda(fCfgSis('PRO_NF', varString, FCodigoEmpresa));
    FApiEnotas.EmissaoNFeProdutoProducao.strSerieNFe                 := fCfgSis('SERFSC', varString, FCodigoEmpresa);
    FApiEnotas.EmissaoNFeProdutoProducao.strSequencialLoteNFe        := '1';

    FApiEnotas.EmissaoNFeProdutoHomolocacao.strSequencialNFe         := fRetiraZerosEsquerda(fCfgSis('PRO_NF', varString, FCodigoEmpresa));
    FApiEnotas.EmissaoNFeProdutoHomolocacao.strSerieNFe              := fCfgSis('SERFSC', varString, FCodigoEmpresa);
    FApiEnotas.EmissaoNFeProdutoHomolocacao.strSequencialLoteNFe     := '1';

    FApiEnotas.EmissaoNFeConsumidorProducao.strSequencialNFe         := fRetiraZerosEsquerda(fCfgSis('PRO_IF', varString, FCodigoEmpresa));
    FApiEnotas.EmissaoNFeConsumidorProducao.strSerieNFe              := fCfgSis('SERNFC', varString, FCodigoEmpresa);
    FApiEnotas.EmissaoNFeConsumidorProducao.strCscId                 := fCfgSis('CSC_ID', varString, FCodigoEmpresa);
    FApiEnotas.EmissaoNFeConsumidorProducao.strCscCodigo             := fCfgSis('CSC_CD', varString, FCodigoEmpresa);

    FApiEnotas.EmissaoNFeConsumidorHomologacao.strSequencialNFe      := fRetiraZerosEsquerda(fCfgSis('PRO_IF', varString, FCodigoEmpresa));
    FApiEnotas.EmissaoNFeConsumidorHomologacao.strSerieNFe           := fCfgSis('SERNFC', varString, FCodigoEmpresa);
    FApiEnotas.EmissaoNFeConsumidorHomologacao.strCscId              := fCfgSis('CSC_ID', varString, FCodigoEmpresa);
    FApiEnotas.EmissaoNFeConsumidorHomologacao.strCscCodigo          := fCfgSis('CSC_CD', varString, FCodigoEmpresa);

    FApiEnotas.ValorPercentualTributosFederal.strPercentualTotalFederal   := AnsiReplaceStr(edtPercentualTotalFederal.Text,   ',','.');
    FApiEnotas.ValorPercentualTributosFederal.strPercentualTotalEstadual  := AnsiReplaceStr(edtPercentualTotalEstadual.Text,  ',','.');
    FApiEnotas.ValorPercentualTributosFederal.strPercentualTotalMunicipal := AnsiReplaceStr(edtPercentualTotalMunicipal.Text, ',','.');
  End;
end;

procedure TfrmCadEnotas.pCarregaServico;
var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;

  Try
    qryAux.SQL.Text := 'SELECT SER_TRIMUN, SER_CDLSSE, SER_DESSER FROM CADSER WHERE SER_ATIVO_ = "S" ORDER BY SER_CODSER ASC LIMIT 1';
    qryAux.Open;

    If not qryAux.IsEmpty Then
    Begin
      FDescricaoServico       := qryAux.FieldByName('SER_DESSER').AsString;
      FCodigoServicoMunicipal := qryAux.FieldByName('SER_TRIMUN').AsString;
      FItemListaServicoLC116  := qryAux.FieldByName('SER_CDLSSE').AsString;
    End;

  Finally
    FreeAndNil(qryAux);
  End;

end;

procedure TfrmCadEnotas.pAtualizaConfiguracao(ACodigoEmpresa, AEmpresaId: String);
var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;

  Try
    qryAux.SQL.Text := 'UPDATE CFGSIS SET SIS_VALCFG = :VALCFG WHERE SIS_CODCFG = "CFG_EMPENO" AND SIS_CODEMP = :CODEMP ';

    If not fEmptyStr(AEmpresaId) Then
      qryAux.ParamByName('VALCFG').AsString := AEmpresaId;

    qryAux.ParamByName('CODEMP').AsString := ACodigoEmpresa;
    qryAux.ExecSQL;

  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmCadEnotas.pPreparaInclusao;
begin
  If Assigned(FApiEnotas) Then
  Begin
    pCarregaServico;

    FApiEnotas.Identificacao.strCnpj                    := FCnpj;
    FApiEnotas.Identificacao.strInscricaoMunicipal      := FInscricaoMunicipal;
    FApiEnotas.Identificacao.strInscricaoEstadual       := FInscricaoEstadual;
    FApiEnotas.Identificacao.strRazaoSocial             := FRazaoSocial;
    FApiEnotas.Identificacao.strNomeFantasia            := FNomeFantasia;
    FApiEnotas.Identificacao.strEmail                   := FEmail;
    FApiEnotas.Identificacao.strTelefoneComercial       := FTelefoneComercial;
    FApiEnotas.Identificacao.strOptanteSimplesNacional  := IIF(fCfgSis('SIMPAU', varBoolean, FCodigoEmpresa), 'true', 'false');

    FApiEnotas.Identificacao.strEmiteNFSeNacional       := 'false';
    FApiEnotas.Identificacao.strEnviarEmailCliente      := 'false';
    FApiEnotas.Identificacao.strIncentivadorCultural    := 'false';

    FApiEnotas.DadosMunicipais.strRegimeEspecialTributacao := '0';
    FApiEnotas.DadosMunicipais.strCodigoServicoMunicipal   := '';
    FApiEnotas.DadosMunicipais.strItemListaServicoLC116    := '';
    FApiEnotas.DadosMunicipais.strCnae                     := FCnae;
    FApiEnotas.DadosMunicipais.strAliquotaIss              := AnsiReplaceStr(fCfgSis('PERISS', varString, FCodigoEmpresa), ',', '.');
    FApiEnotas.DadosMunicipais.strDescricaoServico         := '';

    FApiEnotas.Endereco.strCodigoIbgeUf     := FCodigoIbgeUf;
    FApiEnotas.Endereco.strCodigoIbgeCidade := FCodigoIbgeCidade;
    FApiEnotas.Endereco.strPais             := 'Brasil';
    FApiEnotas.Endereco.strUf               := FUf;
    FApiEnotas.Endereco.strCidade           := FCidade;
    FApiEnotas.Endereco.strLogradouro       := FLogradouro;
    FApiEnotas.Endereco.strNumero           := FNumero;
    FApiEnotas.Endereco.strComplemento      := FComplemento;
    FApiEnotas.Endereco.strBairro           := FBairro;
    FApiEnotas.Endereco.strCep              := FCep;
  End;
end;

procedure TfrmCadEnotas.FormCreate(Sender: TObject);
begin
  inherited;

  FExibeMensagem := True;

  FApiEnotas := TApiEnotas.Create;

  FPathEnotas := ExtractFileDir(Application.ExeName) + '\eNotas';

  If Not DirectoryExists(FPathEnotas) Then
  Begin
    CreateDir(FPathEnotas);
  End;
end;

procedure TfrmCadEnotas.FormDestroy(Sender: TObject);
begin
  inherited;
  If Assigned(FApiEnotas) Then
  Begin
    FreeAndNil(FApiEnotas);
  End;
end;

procedure TfrmCadEnotas.pAtualizaCertificadoDigital;
begin
  If Assigned(FApiEnotas) Then
  Begin
    FApiEnotas.FCodigoEmpresa := Self.FCodigoEmpresa;

    FRetorno := FApiEnotas.fConsultaCnpj(FCnpj);

    If FRetorno.strCodigo = '200' Then
    Begin
      If FApiEnotas.fCarregaEmpresa(FRetorno.strRetorno) Then
      Begin
        If fCarregaCertificadoDigital Then
          FRetorno := FApiEnotas.fVinculaCertificadoDigital(FApiEnotas.Identificacao.strId, FCertificadoPath, FCertificadoSenha);
      End;
    End;
  End;
end;

procedure TfrmCadEnotas.pEnotasAtualizaCertificadoDigital;
begin
  FRetorno := TRetornoEnotas.Create;

  FExisteInclusaoDeCertificado := True;

  Try
    TfrmGravando.fExecutarModalA(pAtualizaCertificadoDigital, 'Atualizando Certificado Digital no eNotas . . .', '');

    pValidaRetorno;

  Finally
    If Assigned(FRetorno) Then
      FreeAndNil(FRetorno);
  End;
end;

procedure TfrmCadEnotas.pPreparandoExibicao;
begin
  pLimpaTela;

  If Assigned(FApiEnotas) Then
  Begin
    FApiEnotas.FCodigoEmpresa := Self.FCodigoEmpresa;

    FRetorno := FApiEnotas.fConsultaCnpj(FCnpj);

    If FRetorno.strCodigo = '200' Then
    Begin
      If not FApiEnotas.fCarregaEmpresa(FRetorno.strRetorno) Then
        pPreparaInclusao;

      pCarregaTela;

      pAtualizaConfiguracao(FCodigoEmpresa, edtIdentificacao.Text);

      pHabilitaCampos(False);
    End;
  End;
end;

procedure TfrmCadEnotas.FormShow(Sender: TObject);
begin
  inherited;

  FRetorno := TRetornoEnotas.Create;

  Try
    TfrmGravando.fExecutarModalA(pPreparandoExibicao, 'Consultando empresa no eNotas . . .', '');

    If not (FRetorno.strCodigo = '200') Then
    Begin
      pValidaRetorno;
      Exit;
    End;

  Finally
    If Assigned(FRetorno) Then
      FreeAndNil(FRetorno);
  End;

  If fEmptyStr(edtIdentificacao.Text) Then
    btnAlterar.Click;
end;

procedure TfrmCadEnotas.pHabilitaEmpresa;
begin
  If Assigned(FApiEnotas) Then
  Begin
    FRetorno := FApiEnotas.fHabilitaEmpresa(edtIdentificacao.Text);

    If FRetorno.strCodigo = '200' Then
    Begin
      pPreparandoExibicao;
    End;
  End;
end;

procedure TfrmCadEnotas.pDesabilitaEmpresa;
begin
  If Assigned(FApiEnotas) Then
  Begin
    FRetorno := FApiEnotas.fDesabilitaEmpresa(edtIdentificacao.Text);

    If FRetorno.strCodigo = '200' Then
    Begin
      pPreparandoExibicao;
    End;
  End;
end;

function TfrmCadEnotas.fCarregaCertificadoDigital: Boolean;
var
  LAux: TUniQuery;
begin
  Result := False;

  If not FExisteInclusaoDeCertificado Then
    Exit;

  LAux := fCriaQuery;

  Try
    LAux.SQL.Add('SELECT CER_ARQPFX, CER_SENHA_ FROM CADCER ');
    LAux.SQL.Add('WHERE CER_CODEMP = :CODEMP');
    LAux.ParamByName('CODEMP').AsString := FCodigoEmpresa;
    LAux.Open;

    If not LAux.IsEmpty Then
    Begin
      FCertificadoPath  := FPathEnotas + '\' + FCodigoEmpresa + '_CERTIFIDO.PFX';
      FCertificadoSenha := fDecriptar(LAux.FieldByName('CER_SENHA_').AsString);

      DeleteFile(FCertificadoPath);
      TBlobField(LAux.FieldByName('CER_ARQPFX')).SaveToFile(FCertificadoPath);

      Result := True;
    End;
  Finally
    FreeAndNil(LAux);
  End;
end;

function TfrmCadEnotas.fCarregaLogotipo: Boolean;
var
  LPicture: TPicture;
begin
  Result := False;

  If not FExisteInclusaoDeLogotipo Then
    Exit;

  LPicture := TPicture.Create;

  Try
    If (fCarregaImagemEmpresa(FCodigoEmpresa, LPicture) = riOk) Then
    Begin
      FLogoPath := FPathEnotas + '\' + FCodigoEmpresa + '_LOGO.JPG';

      DeleteFile(FLogoPath);
      LPicture.SaveToFile(FLogoPath);

      Result := True;
    End;
  Finally
    FreeAndNil(LPicture);
  End;
end;

procedure TfrmCadEnotas.pVinculaCertificadoDigital;
begin
  If Assigned(FApiEnotas) Then
  Begin
    FRetorno := FApiEnotas.fVinculaCertificadoDigital(edtIdentificacao.Text, FCertificadoPath, FCertificadoSenha);
  End;
end;

procedure TfrmCadEnotas.pVinculaLogotipo;
begin
  If Assigned(FApiEnotas) Then
  Begin
    FRetorno := FApiEnotas.fVinculaLogotipo(edtIdentificacao.Text, FLogoPath);
  End;
end;

procedure TfrmCadEnotas.pCadastraEmpresa;
begin
  If Assigned(FApiEnotas) Then
  Begin
    If Assigned(FRetorno) Then
      FreeAndNil(FRetorno);

    FRetorno := TRetornoEnotas.Create;

    FRetorno := FApiEnotas.fCadastraEmpresa;

    If FRetorno.strCodigo = '200' Then
    Begin
      // Carrega a empresa cadastrada
      pPreparandoExibicao;

      // Envia o certificado caso existir
      If fCarregaCertificadoDigital Then
        FRetorno := FApiEnotas.fVinculaCertificadoDigital(edtIdentificacao.Text, FCertificadoPath, FCertificadoSenha);

      If not (FRetorno.strCodigo = '200') Then
        Exit;

      // Envia o logotipo caso existir
      If fCarregaLogotipo Then
        FRetorno := FApiEnotas.fVinculaLogotipo(edtIdentificacao.Text, FLogoPath);
    End;
  End;
end;

procedure TfrmCadEnotas.pAlteraEmpresa;
begin
  If Assigned(FApiEnotas) Then
  Begin
    If Assigned(FRetorno) Then
      FreeAndNil(FRetorno);

    FRetorno := TRetornoEnotas.Create;

    FRetorno := FApiEnotas.fAlteraEmpresa(edtIdentificacao.Text);

    If FRetorno.strCodigo = '200' Then
    Begin
      // Carrega a empresa cadastrada
      pPreparandoExibicao;

      // Envia o certificado caso existir
      If fCarregaCertificadoDigital Then
        FRetorno := FApiEnotas.fVinculaCertificadoDigital(edtIdentificacao.Text, FCertificadoPath, FCertificadoSenha);

      If not (FRetorno.strCodigo = '200') Then
        Exit;

      // Envia o logotipo caso existir
      If fCarregaLogotipo Then
        FRetorno := FApiEnotas.fVinculaLogotipo(edtIdentificacao.Text, FLogoPath);
    End;
  End;
end;

procedure TfrmCadEnotas.pValidaRetorno;
var
  LRetorno: TStringList;
  LArquivo: String;
begin
  If Assigned(FRetorno) Then
  Begin
    LRetorno := TStringList.Create;
    Try
      If FRetorno.strCodigo = '200' Then
      Begin
        If FExibeMensagem Then
        Begin
          fMensagem('eNotas', 'Processo realizado com sucesso!', ['&Ok']);
        End;

        exit;
      end;

      If Pos(FRetorno.strCodigo, '400_401_403_500') > 0 Then
      Begin
        btnAlterar.Enabled     := False;
        btnGravar.Enabled      := False;
        btnCancelar.Enabled    := False;
        btnHabilitar.Enabled   := False;
        btnDesabilitar.Enabled := False;
        btnLogotipo.Enabled    := False;
        btnCertificado.Enabled := False;
      End;

      fMensagem('eNotas', 'Ocorreu um erro no processamento!'+#13+
                          FRetorno.strCodigo+' - '+FRetorno.strMensagem, ['&Ok']);

      LArquivo := FPathEnotas + '\'+ FCodigoEmpresa +'_eNotasJSON.txt';
      DeleteFile(LArquivo);

      If not fEmptyStr(FRetorno.strRetorno) Then
      Begin
        LRetorno.Text := FRetorno.strRetorno;
        LRetorno.SaveToFile(LArquivo);
      End;

    Finally
      FreeAndNil(LRetorno);
      FreeAndNil(FRetorno);
    End;
  End;
end;

procedure TfrmCadEnotas.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pgcDados.ActivePage := tbsIdentificacao;

  pHabilitaCampos(True);
end;

procedure TfrmCadEnotas.btnGravarClick(Sender: TObject);
begin
  inherited;
  If fCamposIncompletos Then
  Begin
    fMensagem('', 'Cadastro incompleto, verifique!', ['&Ok']);
    Exit;
  End;

  If fMensagem('Aviso', 'Confirma a gravação no eNotas?', ['&Sim', '&Não'], 2) = 1 then
  Begin
    pAtualizaRegistros;

    If fEmptyStr(edtIdentificacao.Text) Then
    Begin
      TfrmGravando.fExecutarModalA(pCadastraEmpresa, 'Cadastrando empresa no eNotas . . .', '');
    End
    Else
    Begin
      TfrmGravando.fExecutarModalA(pAlteraEmpresa, 'Alterando empresa no eNotas . . .', '');
    End;

    pValidaRetorno;
  End;
end;

procedure TfrmCadEnotas.btnCancelarClick(Sender: TObject);
begin
  pLimpaTela;
  pCarregaTela;
  pHabilitaCampos(False);
end;

procedure TfrmCadEnotas.btnHabilitarClick(Sender: TObject);
begin
  If fEmptyStr(edtIdentificacao.Text) Then
  Begin
    fMensagem('', 'Necessário cadastrar a empresa no eNotas!', ['&Ok']);
    exit;
  End;

  TfrmGravando.fExecutarModalA(pHabilitaEmpresa, 'Habilitando empresa no eNotas . . .', '');

  pValidaRetorno;
end;

procedure TfrmCadEnotas.btnDesabilitarClick(Sender: TObject);
begin
  If fEmptyStr(edtIdentificacao.Text) Then
  Begin
    fMensagem('', 'Necessário cadastrar a empresa no eNotas!', ['&Ok']);
    exit;
  End;

  TfrmGravando.fExecutarModalA(pDesabilitaEmpresa, 'Desabilitando empresa no eNotas . . .', '');

  pValidaRetorno;
end;

procedure TfrmCadEnotas.btnCertificadoClick(Sender: TObject);
begin
  If fEmptyStr(edtIdentificacao.Text) Then
  Begin
    fMensagem('', 'Necessário cadastrar a empresa no eNotas!', ['&Ok']);
    exit;
  End;

  If FileOpenCertificadoPFX.Execute Then
  Begin
    FCertificadoPath  := FileOpenCertificadoPFX.FileName;
    FCertificadoSenha := InputBox('Certificado Digital',#31+'Senha','');

    TfrmGravando.fExecutarModalA(pVinculaCertificadoDigital, 'Vinculando logotipo na empresa do eNotas . . .', '');

    pValidaRetorno;
  End;
end;

procedure TfrmCadEnotas.btnLogotipoClick(Sender: TObject);
begin
  If fEmptyStr(edtIdentificacao.Text) Then
  Begin
    fMensagem('', 'Necessário cadastrar a empresa no eNotas!', ['&Ok']);
    exit;
  End;

  If FileOpenLogotipo.Execute Then
  Begin
    FLogoPath := FileOpenLogotipo.FileName;

    TfrmGravando.fExecutarModalA(pVinculaLogotipo, 'Vinculando logotipo na empresa do eNotas . . .', '');

    pValidaRetorno;
  End;
end;

procedure TfrmCadEnotas.edtRegimeEspecialPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
var
  LEnabled: Boolean;
begin
  LEnabled := not (edtRegimeEspecial.ItemIndex < 5);

  edtReceitaBrutaAcumulada.Enabled              := LEnabled;
  edtAnexoEnquadramentoSimplesNacional.Enabled  := LEnabled;
  edtDataInicioAtividadeSimplesNacional.Enabled := LEnabled;
end;

procedure TfrmCadEnotas.pAtualizaCodigoIBGE;
begin
  If Assigned(FApiEnotas) Then
  Begin
    FApiEnotas.Endereco.strCodigoIbgeUf     := fRetornaCodUFIBGE(FCodigoCidade);
    FApiEnotas.Endereco.strCodigoIbgeCidade := fRetornaCodIBGE(FCodigoCidade);
  End;
end;

procedure TfrmCadEnotas.btnAtualizaRazaoSocialClick(Sender: TObject);
begin
  inherited;
  edtRazaoSocial.Text := FRazaoSocial;
end;

procedure TfrmCadEnotas.btnAtualizaNomeFantasiaClick(Sender: TObject);
begin
  inherited;
  edtNomeFantasia.Text := FNomeFantasia;
end;

procedure TfrmCadEnotas.btnAtualizaInscMunicipalClick(Sender: TObject);
begin
  inherited;
  edtInscMunicipal.Text := FInscricaoMunicipal;
end;

procedure TfrmCadEnotas.btnAtualizaInscrEstadualClick(Sender: TObject);
begin
  inherited;
  edtInscrEstadual.Text := FInscricaoEstadual;
end;

procedure TfrmCadEnotas.btnAtualizaEmailClick(Sender: TObject);
begin
  inherited;
  edtEmail.Text := FEmail;
end;

procedure TfrmCadEnotas.btnAtualizaTelefoneClick(Sender: TObject);
begin
  inherited;
  edtTelefone.Text := FormatMaskText('(99) 9999-9999;0;', FTelefoneComercial);
end;

procedure TfrmCadEnotas.btnAtualizaSimplesNacionalClick(Sender: TObject);
begin
  inherited;
  chkSimplesNacional.Checked := fCfgSis('SIMPAU', varBoolean, FCodigoEmpresa);
end;

procedure TfrmCadEnotas.btnAtualizaAliquotaISSClick(Sender: TObject);
begin
  inherited;
  edtAliquotaISS.Text := AnsiReplaceStr(fCfgSis('PERISS', varString, FCodigoEmpresa), '.', ',');
end;

procedure TfrmCadEnotas.btnAtualizaCnaeClick(Sender: TObject);
begin
  inherited;
  edtCNAE.Text := FCnae;
end;

procedure TfrmCadEnotas.btnAtualizaUFClick(Sender: TObject);
begin
  inherited;
  edtUF.Text := FUf;
  pAtualizaCodigoIBGE;
end;

procedure TfrmCadEnotas.btnAtualizaCidadeClick(Sender: TObject);
begin
  inherited;
  edtCidade.Text := FCidade;
  pAtualizaCodigoIBGE;
end;

procedure TfrmCadEnotas.btnAtualizaCepClick(Sender: TObject);
begin
  inherited;
  edtCep.Text := FCep;
  pAtualizaCodigoIBGE;
end;

procedure TfrmCadEnotas.LogradouroClick(Sender: TObject);
begin
  inherited;
  edtLogradouro.Text := FLogradouro;
end;

procedure TfrmCadEnotas.btnAtualizaNumeroClick(Sender: TObject);
begin
  inherited;
  edtNumero.Text := FNumero;
end;

procedure TfrmCadEnotas.btnAtualizaComplementoClick(Sender: TObject);
begin
  inherited;
  edtComplemento.Text := FComplemento;
end;

procedure TfrmCadEnotas.btnAtualizaBairroClick(Sender: TObject);
begin
  inherited;
  edtBairro.Text := FBairro;
end;


{TNfeApiWS}

constructor TNfeApiWS.Create;
begin
  FlibApiClient := LoadLibrary(PChar('api.client.dll'));

  If FlibApiClient = 0 Then
  Begin
    Raise Exception.Create('Biblioteca "api.client.dll" não encontrada!');
  End;

  @fExecuteAuth2      := GetProcAddress(FlibApiClient, PChar('ExecuteAuth2'));
  @fGetJsonValue      := GetProcAddress(FlibApiClient, PChar('GetJsonValue'));
  @fGetJsonArrayValue := GetProcAddress(FlibApiClient, PChar('GetJsonArrayValue'));
  @fGetToken          := GetProcAddress(FlibApiClient, PChar('GetToken'));

end;

destructor TNfeApiWS.Destroy;
begin

  If (FlibApiClient <> 0) Then
  Begin
    FreeLibrary(FlibApiClient);
    FlibApiClient := 0;
  End;

  inherited;
end;

function TNfeApiWS.NfeEnviaRecebeDados(AMetodo: TMetodo; AUrl, AComando, AToken, AJson, AContentType: WideString; ABytes: TBytes;
                                       AFormDataField, AFormDataFieldValue, AFormDataFile, AFormDataFilePath,
                                       AProxyServer, AProxyPort, AProxyUsername, AProxyPassword: WideString;
                                       var ARetorno: String): TRetornoIntegracaoCitel;
var
  LStatus: Integer;
  LMetodo: WideString;
  LResultado: WideString;
  LRetorno: TStringList;
begin

  ARetorno := '';

  Try
    Case AMetodo Of
         mGet: LMetodo := 'GET';
        mPost: LMetodo := 'POST';
      mDelete: LMetodo := 'DELETE';
    End;

    LStatus := fExecuteAuth2(LMetodo, AUrl + AComando, AJson, AToken, AContentType, AFormDataField, AFormDataFieldValue, AFormDataFile, AFormDataFilePath,
                             AProxyServer, AProxyPort, AProxyUsername, AProxyPassword, ABytes, LResultado);

    LRetorno := TStringList.Create;

    If FileExists('ULTIMO_RETORNO_PAINEL_CITEL.TXT') Then
      LRetorno.LoadFromFile('ULTIMO_RETORNO_PAINEL_CITEL.TXT');

    Try
      LRetorno.Add('Metodo: ' + LMetodo + ' - ' + DateTimeToStr(fNow) + #13 + LResultado);

      Try
        LRetorno.SaveToFile('ULTIMO_RETORNO_PAINEL_CITEL.TXT');
      Except

      End;
    Finally
      FreeAndNil(LRetorno);
    End;

    If (AMetodo = mGet) Then
      ARetorno := LResultado;

    Result := fParseResponse(AMetodo, LStatus, LResultado);
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

function TNfeApiWS.fParseResponse(const AMetodo: TMetodo; const AStatus: Integer; AJson: WideString): TRetornoIntegracaoCitel;
begin
  Result := TRetornoIntegracaoCitel.Create();

  Result.strCodigo   := IntToStr(AStatus);
  Result.strMensagem := '';

  If (AMetodo = mGet) Then
    Exit;

  If (AStatus = 200) Then
  Begin
    Result.strMensagem := fGetJsonValue(AJson, 'status');
  End
  Else
  Begin
    Result.strMensagem := fGetJsonValue(AJson, 'message');

    If fEmptyStr(Result.strMensagem) Then
      Result.strMensagem := fGetJsonValue(AJson, 'error');

    If fEmptyStr(Result.strMensagem) Then
      Result.strMensagem := AJson;
  End;
end;

end.
