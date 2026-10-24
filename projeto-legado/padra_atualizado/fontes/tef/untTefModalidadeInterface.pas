unit untTefModalidadeInterface;

interface

uses Classes, Vcl.Forms, Vcl.Controls, System.Generics.Collections,
     BitBtnLockedIncrem ;

const
  ALGORIX = '00193' ;
  BANRISUL = '00021' ;

type
  TCartaoCreditoModalidades = (ccmAVista, ccmParcAdm, ccmParcLoja) ;
  TStrInfoCartaoCreditoModalidades = array[TCartaoCreditoModalidades] of String ;
  TBlnInfoCartaoCreditoModalidades = array[TCartaoCreditoModalidades] of Boolean ;

  TChaveValorModalidade = class
  private
    FstrChave: String ;
    FstrValor: String ;
  public
    property Chave: String read FstrChave write FstrChave ;
    property Valor: String read FstrValor write FstrValor ;
  end;

  TprocModalidadesOnClick = procedure(Sender: TObject) Of Object;
  TProcOnKeyPressOpcoes = procedure(Sender: TObject;  var Key: Char) Of Object;

  IInfoCartaoCreditoModalidade = interface
    ['{EE73CF4E-3C09-4C84-AB2E-AD3DFE420126}']
    function fGetDescricaoReduzida(Index: TCartaoCreditoModalidades): String ;
    function fGetDescricaoCompleta(Index: TCartaoCreditoModalidades): String ;
    function fGetModalidadeCodigo(Index: TCartaoCreditoModalidades): String ;
    function fGetModalidadeVisivel(Index: TCartaoCreditoModalidades): Boolean ;
    property DescricaoReduzida[Index: TCartaoCreditoModalidades]: String read fGetDescricaoReduzida ;
    property DescricaoCompleta[Index: TCartaoCreditoModalidades]: String read fGetDescricaoCompleta ;
    property ModalidadeCodigo[Index: TCartaoCreditoModalidades] : String read fGetModalidadeCodigo  ;
    property ModalidadeVisivel[Index: TCartaoCreditoModalidades]: Boolean read fGetModalidadeVisivel ;
  end ;

  IOpcoesModalidadeDinamica = interface ;

  IModalidadeDinamica = interface
    ['{C72B2015-2A37-452A-A49D-BCA7302D9750}']
    function fMontaTelaModalidade(const AstrModalidades: String): IModalidadeDinamica ;
    function fMontaTelaOpcoes(const AstrModalidades: String; var AstrTextoComplementar: String): IOpcoesModalidadeDinamica ;
    function fSetOwner(Aowner: TComponent): IModalidadeDinamica ;
    function fSetBotaoModelo(ABotao: TComponent): IModalidadeDinamica ;
    function fForm(AFormulario: TForm): IModalidadeDinamica ; overload ;
    function fForm: TForm ; overload ;
    function fModalidadeCarregada: Boolean ;
    procedure pKeyPressModalidade(const AchrTecla: Char) ;
    function fSetOnClickModalidade(AprocOnClick: TprocModalidadesOnClick): IModalidadeDinamica ;
    procedure pHabilitaBotoesModalidade(const AblnHabilitar: Boolean) ;
    function fOpcoesOwner(Aowner: TComponent): IModalidadeDinamica ; overload ;
    function fOpcoesOwner: TComponent ; overload ;
    function fOnKeyPressOpcoes(AprocOnKeyPress: TProcOnKeyPressOpcoes): IModalidadeDinamica ; overload ;
    function fOnKeyPressOpcoes: TProcOnKeyPressOpcoes ; overload ;
    function fOnClickConfirmarOpcoes(AprocOnClickConfirmar: TprocModalidadesOnClick): IModalidadeDinamica ; overload ;
    function fOnClickConfirmarOpcoes: TprocModalidadesOnClick ; overload ;
    function fOnClickEncerrarOpcoes(AprocOnClickEncerrar: TprocModalidadesOnClick): IModalidadeDinamica ; overload ;
    function fOnClickEncerrarOpcoes: TprocModalidadesOnClick ; overload ;
    function fValor(AfltValor: Double): IModalidadeDinamica ; overload ;
    function fValor: Double ; overload ;
    function fEditsOpcoes(AlstEdits: TList<TWinControl>): IModalidadeDinamica ; overload ;
    function fEditsOpcoes(): TList<TWinControl>; overload ;
    function fBotoesModalidades(ADictBotoes: TObjectDictionary<TChaveValorModalidade, TBitBtnLocked>): IModalidadeDinamica ; overload ;
    function fBotoesModalidades(): TObjectDictionary<TChaveValorModalidade, TBitBtnLocked>; overload ;
  end ;

  IOpcoesModalidadeDinamica = interface
    ['{3230E339-DABD-404C-B3C3-D80DA05A897B}']
    function fMontaOpcoesTela(var AstrTextoComplementar: String): IOpcoesModalidadeDinamica ;
    function fSetOwner(Aowner: TComponent): IOpcoesModalidadeDinamica ;
    function fSetModalidade(AobjModalidade: IModalidadeDinamica): IOpcoesModalidadeDinamica ;
    function fPrimeiroControlFoco: TComponent ;
    function fValidaCamposInformados(Var AobjControlFoco: TWinControl; Var AstrMensagem: String): Boolean ;
    function fEnviaDadosInformados: Boolean ;
    function fModalidadeEscolhida: String ; overload ;
    function fModalidadeEscolhida(AstrModalidade: String): IOpcoesModalidadeDinamica ; overload ;
    function fListaEdits: TList<TWinControl> ;
    function fBotaoConfirmar: TComponent ;
    function fBotaoCancelar: TComponent ;
  end ;

implementation

end.
