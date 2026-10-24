unit untRepositorioConfiguracoesLibCartoes;

interface

uses
  System.SysUtils, System.Classes, System.StrUtils, System.Variants,
  System.Generics.Collections, Vcl.Controls,

  cxEdit, cxEditRepositoryItems, cxClasses, cxRadioGroup, cxContainer,
  cxTextEdit,

  untLibCartoesTiposCompartilhados, untLibCartoesCadEstabelecimentos;

type
  TdtmRepositorioConfiguracoesLibCartoes = class(TDataModule)
    cxRepositorioCartoes: TcxEditRepository;
    libCartoesrdgSimNao: TcxEditRepositoryRadioGroupItem;
    libCartoesedtTextoSemCase: TcxEditRepositoryTextItem;
    libCartoesedtSenha: TcxEditRepositoryTextItem;
    libCartoesedtToleranciaConciliacao: TcxEditRepositoryCurrencyItem;
    libCartoesedtTexto_Tam20: TcxEditRepositoryTextItem;
    libCartoesbtnCadEstabelecimentosCartoes: TcxEditRepositoryButtonItem;
    libCartoesedtTexto_Tam10: TcxEditRepositoryTextItem;
    libCartoesedtValorInteiro: TcxEditRepositoryCurrencyItem;
    libCartoesrdgVersaoImpPagarMe: TcxEditRepositoryRadioGroupItem;
    libCartoesbtnCadIDRecebedorPagarMe: TcxEditRepositoryButtonItem;
    libCartoesbtnCadChavesAutorizacaoPagarMe: TcxEditRepositoryButtonItem;
    procedure libCartoesedtTexto_Tam20PropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  private
    procedure CarregaPropertiesSimNao(var AItemCOnfiguracao: TLibCartoesCfgProperties);
    procedure CarregaPropertiesSenha(var AItemCOnfiguracao: TLibCartoesCfgProperties);
    procedure CarregaPropertiesDecimalByName(var AItemCOnfiguracao: TLibCartoesCfgProperties);
    procedure CarregaPropertiesTamanho20(var AItemCOnfiguracao: TLibCartoesCfgProperties);
    procedure CarregaPropertiesTamanho10(var AItemCOnfiguracao: TLibCartoesCfgProperties);
    procedure CarregaPropertiesBotoes(var AItemCOnfiguracao: TLibCartoesCfgProperties);
    procedure CarregaPropertiesVersaoPagarMe(var AItemCOnfiguracao: TLibCartoesCfgProperties);
    { Private declarations }
  public
    procedure CarregaTipoConfiguracao(var AItemCOnfiguracao: TLibCartoesCfgProperties);
    procedure CarregaPropertiesPeloTipoConfiguracao(var AItemCOnfiguracao: TLibCartoesCfgProperties);
    { Public declarations }
  end;

  Const
    TIPO_SIMNAO: Array Of String = ['libCartoesrdgSimNao', 'libCartoesrdgVersaoImpPagarMe']; //RadioGroup Simples
    TIPO_SENHA: Array Of String = ['libCartoesedtSenha'];
    TIPO_VALOR_DECIMAL: Array Of String = ['libCartoesedtToleranciaConciliacao', 'libCartoesedtValorInteiro'];
    TEXTO_TAMANHO_20: Array Of String = ['libCartoesedtTexto_Tam20'];
    TEXTO_TAMANHO_10: Array Of String = ['libCartoesedtTexto_Tam10'];
    TIPO_ESTABELECIMENTOS: Array Of String = ['libCartoesbtnCadEstabelecimentosCartoes', 'libCartoesbtnCadIDRecebedorPagarMe', 'libCartoesbtnCadChavesAutorizacaoPagarMe'];

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdtmRepositorioConfiguracoesLibCartoes }

procedure TdtmRepositorioConfiguracoesLibCartoes.CarregaPropertiesBotoes(
  var AItemCOnfiguracao: TLibCartoesCfgProperties);
  Var
    LItensBotoes: Integer;

    LNovoItem: TItensButtons;

    LConfiguracao: TcxEditRepositoryButtonItem;
begin
  Case AItemCOnfiguracao.TipoConfiguracao Of
    tpcCadIDRecebedoresPagarMe: LConfiguracao := libCartoesbtnCadIDRecebedorPagarMe;
    tpcCadChavesAutorizacaoPagarMe: LConfiguracao := libCartoesbtnCadChavesAutorizacaoPagarMe;
    Else LConfiguracao := libCartoesbtnCadEstabelecimentosCartoes;
  End;

  AItemConfiguracao.ApenasLeitura := LConfiguracao.Properties.ReadOnly;
  AItemConfiguracao.EventosBotoes := LConfiguracao.Properties.OnButtonClick;

  Case LConfiguracao.Properties.ViewStyle Of
    vsButtonsAutoWidth: AItemConfiguracao.ViewStyle := tpvsButtonsAutoWidth;
    vsNormal: AItemConfiguracao.ViewStyle := tpvsNormal;
    vsHideCursor: AItemConfiguracao.ViewStyle := tpvsHideCursor;
    vsButtonsOnly: AItemConfiguracao.ViewStyle := tpvsButtonsOnly;
  End;

  AItemConfiguracao.ItensBotoes := TList<TItensButtons>.Create;

  For LItensBotoes := 0 To LConfiguracao.Properties.Buttons.Count - 1 Do
  Begin
    LNovoItem := TItensButtons.Create;
    LNovoItem.Texto := LConfiguracao.Properties.Buttons[LItensBotoes].Caption;

    AItemConfiguracao.ItensBotoes.Add(LNovoItem);
  End;
end;

procedure TdtmRepositorioConfiguracoesLibCartoes.CarregaPropertiesDecimalByName(
  var AItemCOnfiguracao: TLibCartoesCfgProperties);
  Var
    LComponente: TcxEditRepositoryCurrencyItem;
begin
  LComponente := TcxEditRepositoryCurrencyItem(cxRepositorioCartoes.ItemByName(AItemCOnfiguracao.Nome));

  AItemCOnfiguracao.CasasDecimais := LComponente.Properties.DecimalPlaces;
  AItemCOnfiguracao.EditFormat := LComponente.Properties.EditFormat;
  AItemCOnfiguracao.DisplayFormat := LComponente.Properties.DisplayFormat;
  AItemCOnfiguracao.UsarSeparadorMilhar := LComponente.Properties.UseThousandSeparator;
end;

procedure TdtmRepositorioConfiguracoesLibCartoes.CarregaPropertiesPeloTipoConfiguracao(
  var AItemCOnfiguracao: TLibCartoesCfgProperties);
begin
  Case AItemCOnfiguracao.TipoConfiguracao Of
    tpcSimNao: CarregaPropertiesSimNao(AItemConfiguracao);
    tpcSenha: CarregaPropertiesSenha(AItemConfiguracao);
    tpcValorDecimal, tpcValorToleranciaCartao: CarregaPropertiesDecimalByName(AItemConfiguracao);
    tpcTexto_Tam20: CarregaPropertiesTamanho20(AItemConfiguracao);
    tpcTexto_Tam10: CarregaPropertiesTamanho10(AItemConfiguracao);
    tpcCadEstabelecimentos, tpcCadIDRecebedoresPagarMe, tpcCadChavesAutorizacaoPagarMe: CarregaPropertiesBotoes(AItemConfiguracao);
    tpcVersaoPagarMe: CarregaPropertiesVersaoPagarMe(AItemConfiguracao);
  End;
end;

procedure TdtmRepositorioConfiguracoesLibCartoes.CarregaPropertiesSenha(
  var AItemCOnfiguracao: TLibCartoesCfgProperties);
begin
  AItemConfiguracao.TamanhoMaximo := libCartoesedtSenha.Properties.MaxLength;
  AItemConfiguracao.CaracterPassword := libCartoesedtSenha.Properties.PasswordChar;
end;

procedure TdtmRepositorioConfiguracoesLibCartoes.CarregaPropertiesSimNao(
  var AItemCOnfiguracao: TLibCartoesCfgProperties);
  Var
    LItensRadio: Integer;

    LNovoItem: TItensRadioGroup;
begin
  AItemConfiguracao.CaptionCfg := libCartoesrdgSimNao.Properties.DefaultCaption;
  AItemConfiguracao.ValorDefault := libCartoesrdgSimNao.Properties.DefaultValue;
  AItemConfiguracao.Colunas := libCartoesrdgSimNao.Properties.Columns;

  AItemConfiguracao.ItensRadioGroup := TList<TItensRadioGroup>.Create;

  For LItensRadio := 0 To libCartoesrdgSimNao.Properties.Items.Count - 1 Do
  Begin
    LNovoItem := TItensRadioGroup.Create;
    LNovoItem.Texto := libCartoesrdgSimNao.Properties.Items[LItensRadio].Caption;
    LNovoItem.Valor := VarToStr(libCartoesrdgSimNao.Properties.Items[LItensRadio].Value);

    AItemConfiguracao.ItensRadioGroup.Add(LNovoItem);
  End;
end;

procedure TdtmRepositorioConfiguracoesLibCartoes.CarregaPropertiesTamanho10(
  var AItemCOnfiguracao: TLibCartoesCfgProperties);
begin
  AItemCOnfiguracao.TamanhoMaximo := libCartoesedtTexto_Tam10.Properties.MaxLength;
  AItemCOnfiguracao.TipoCaracter := Ord(libCartoesedtTexto_Tam10.Properties.CharCase);
  AItemCOnfiguracao.RealizarValidacaoOnEnter := libCartoesedtTexto_Tam10.Properties.ValidateOnEnter;
  AItemCOnfiguracao.Eventos := libCartoesedtTexto_Tam10.PropertiesEvents;

  If AItemCOnfiguracao.RealizarValidacaoOnEnter Then
    AItemCOnfiguracao.EventosValidacao := libCartoesedtTexto_Tam10.Properties.OnValidate;
end;

procedure TdtmRepositorioConfiguracoesLibCartoes.CarregaPropertiesTamanho20(
  var AItemCOnfiguracao: TLibCartoesCfgProperties);
begin
  AItemCOnfiguracao.TamanhoMaximo := libCartoesedtTexto_Tam20.Properties.MaxLength;
  AItemCOnfiguracao.TipoCaracter := Ord(libCartoesedtTexto_Tam20.Properties.CharCase);
  AItemCOnfiguracao.RealizarValidacaoOnEnter := libCartoesedtTexto_Tam20.Properties.ValidateOnEnter;
  AItemCOnfiguracao.Eventos := libCartoesedtTexto_Tam20.PropertiesEvents;

  If AItemCOnfiguracao.RealizarValidacaoOnEnter Then
    AItemCOnfiguracao.EventosValidacao := libCartoesedtTexto_Tam20.Properties.OnValidate;
end;

procedure TdtmRepositorioConfiguracoesLibCartoes.CarregaPropertiesVersaoPagarMe(
  var AItemCOnfiguracao: TLibCartoesCfgProperties);
  Var
    LItensRadio: Integer;

    LNovoItem: TItensRadioGroup;
begin
  AItemConfiguracao.CaptionCfg := libCartoesrdgVersaoImpPagarMe.Properties.DefaultCaption;
  AItemConfiguracao.ValorDefault := libCartoesrdgVersaoImpPagarMe.Properties.DefaultValue;
  AItemConfiguracao.Colunas := libCartoesrdgVersaoImpPagarMe.Properties.Columns;

  AItemConfiguracao.ItensRadioGroup := TList<TItensRadioGroup>.Create;

  For LItensRadio := 0 To libCartoesrdgVersaoImpPagarMe.Properties.Items.Count - 1 Do
  Begin
    LNovoItem := TItensRadioGroup.Create;
    LNovoItem.Texto := libCartoesrdgVersaoImpPagarMe.Properties.Items[LItensRadio].Caption;
    LNovoItem.Valor := VarToStr(libCartoesrdgVersaoImpPagarMe.Properties.Items[LItensRadio].Value);

    AItemConfiguracao.ItensRadioGroup.Add(LNovoItem);
  End;
end;

procedure TdtmRepositorioConfiguracoesLibCartoes.CarregaTipoConfiguracao(
  var AItemConfiguracao: TLibCartoesCfgProperties);
begin
  If MatchStr(AItemConfiguracao.Nome, TIPO_SIMNAO) Then
  Begin
    AItemConfiguracao.TipoConfiguracao := tpcSimNao;

    If AItemConfiguracao.Nome.Equals('libCartoesrdgVersaoImpPagarMe') Then
      AItemConfiguracao.TipoConfiguracao := tpcVersaoPagarMe;
  End
  Else If MatchStr(AItemConfiguracao.Nome, TIPO_SENHA) Then
    AItemConfiguracao.TipoConfiguracao := tpcSenha
  Else If MatchStr(AItemConfiguracao.Nome, TIPO_VALOR_DECIMAL) Then
    AItemConfiguracao.TipoConfiguracao := tpcValorDecimal
  Else If MatchStr(AItemConfiguracao.Nome, TEXTO_TAMANHO_20) Then
    AItemConfiguracao.TipoConfiguracao := tpcTexto_Tam20
  Else If MatchStr(AItemConfiguracao.Nome, TEXTO_TAMANHO_10) Then
    AItemConfiguracao.TipoConfiguracao := tpcTexto_Tam10
  Else If MatchStr(AItemConfiguracao.Nome, TIPO_ESTABELECIMENTOS) Then
  Begin
    AItemConfiguracao.TipoConfiguracao := tpcCadEstabelecimentos;
    If AItemConfiguracao.Nome.Equals('libCartoesbtnCadIDRecebedorPagarMe') Then
      AItemConfiguracao.TipoConfiguracao := tpcCadIDRecebedoresPagarMe
    Else If AItemConfiguracao.Nome.Equals('libCartoesbtnCadChavesAutorizacaoPagarMe') Then
      AItemConfiguracao.TipoConfiguracao := tpcCadChavesAutorizacaoPagarMe;
  End
  Else
    AItemConfiguracao.TipoConfiguracao := tpcTextoSemCase;
end;

procedure TdtmRepositorioConfiguracoesLibCartoes.libCartoesedtTexto_Tam20PropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
  Const
    ValidChars : String = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  Var
    intCont: Integer;
    Resultado: String;
    Entrada: String;
begin
  Resultado := '';
  Entrada := DisplayValue;
  For intCont := 1 To Length(Entrada) Do
  Begin
    If Pos(Entrada[intCont], ValidChars) > 0 Then
      Resultado := Resultado + Entrada[intCont];
  End;
  DisplayValue := Resultado;
end;

end.
