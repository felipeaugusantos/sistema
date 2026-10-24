unit untLibCartoesTiposCompartilhados;

interface

Uses System.Generics.Collections, Vcl.Controls, Vcl.Menus;

Type
  TTipoConfiguracao = (tpcSimNao, tpcSenha, tpcCadEstabelecimentos,
                       tpcConPortador, tpcConPlanoDeContas, tpcConFornecedor,
                       tpcConCentroDeCustos, tpcTexto_Tam20,
                       tpcValorDecimal, tpcTextoSemCase, tpcConEmpresa,
                       tpcValorToleranciaCartao, tpcTexto_Tam10,
                       tpcValorInteiro, tpcConCartoesMultiSelecao,
                       tpcConEmpresasMultiSelecao, tpcBuscarDiretorio, tpcVersaoPagarMe,
                       tpcCadIDRecebedoresPagarMe, tpcCadChavesAutorizacaoPagarMe);

Type
  TTipoViewStyle = (tpvsButtonsOnly, tpvsButtonsAutoWidth, tpvsHideCursor,
                    tpvsNormal);

Type
  TItensRadioGroup = class
    Texto,
    Valor: String;

    Default: Boolean;
  End;

Type
  TItensButtons = class
    Texto: String;

    OnClick: procedure(Sender: TObject);
  End;

Type
  TLibCartoesCfgProperties = class
    TipoClasse,
    Nome,

    TipoClasseProperties,
    CaptionCfg,

    EditFormat,
    DisplayFormat: String;

    CaracterPassword: Char;

    ValorDefault: Variant;

    TipoCaracter,
    TamanhoMaximo,
    CasasDecimais,
    Colunas: Integer;

    ApenasLeitura,
    UsarSeparadorMilhar,
    RealizarValidacaoOnEnter: Boolean;

    ViewStyle: TTipoViewStyle;

    Eventos: procedure(Sender: TObject) of Object;
    EventosBotoes: procedure(Sender: TObject; AButtonIndex: Integer) of Object;
    EventosValidacao: procedure(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean) of Object;

    TipoConfiguracao: TTipoConfiguracao;

    ItensRadioGroup: TList<TItensRadioGroup>;

    ItensBotoes: TList<TItensButtons>;

    public
      constructor Create;
  end;

  TCustomMenuItemCartoes = class(TMenuItem)
  private
    FProjeto,
    FLibAcesso,
    FLayout: String;
  public
    property Projeto: String Read FProjeto Write FProjeto;
    property LibAcesso: String Read FLibAcesso Write FLibAcesso;
    property Layout: String Read FLayout Write FLayout;
  End;

implementation

constructor TLibCartoesCfgProperties.Create;
Begin
  TamanhoMaximo := 0;
  CasasDecimais := 2;
  TipoCaracter := 0;
  UsarSeparadorMilhar := False;
  RealizarValidacaoOnEnter := False;
  ApenasLeitura := False;
End;

end.
