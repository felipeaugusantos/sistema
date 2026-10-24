unit untTefModalidadeImpl;

interface

uses untTefModalidadeInterface, Classes, System.Generics.Collections,
     BitBtnLockedIncrem, Vcl.Forms, Vcl.ExtCtrls, Vcl.StdCtrls,
     CurrencyEditFocus, EditFocus, cxDateUtils, cxMaskEdit,
     cxDropDownEdit, cxCalendar, Vcl.Controls  ;

type
  TInfoCartaoCreditoModalidadeDefault = class(TInterfacedObject, IInfoCartaoCreditoModalidade)
  private
    FarrDescricaoReduzida: TStrInfoCartaoCreditoModalidades ;
    FarrDescricaoCompleta: TStrInfoCartaoCreditoModalidades ;
    FarrModalidadeCodigo: TStrInfoCartaoCreditoModalidades ;
    FarrModalidadeVisivel: TBlnInfoCartaoCreditoModalidades ;
    function fGetDescricaoReduzida(Index: TCartaoCreditoModalidades): String ;
    function fGetDescricaoCompleta(Index: TCartaoCreditoModalidades): String ;
    function fGetModalidadeCodigo(Index: TCartaoCreditoModalidades): String ;
    function fGetModalidadeVisivel(Index: TCartaoCreditoModalidades): Boolean ;
  public
    constructor Create ;
    class function fNew:IInfoCartaoCreditoModalidade ;
    property DescricaoReduzida[Index: TCartaoCreditoModalidades]: String read fGetDescricaoReduzida ;
    property DescricaoCompleta[Index: TCartaoCreditoModalidades]: String read fGetDescricaoCompleta ;
    property ModalidadeCodigo[Index: TCartaoCreditoModalidades] : String read fGetModalidadeCodigo  ;
    property ModalidadeVisivel[Index: TCartaoCreditoModalidades]: Boolean read fGetModalidadeVisivel ;
  end ;

  TInfoCartaoCreditoModalidadeAlgorix = class(TInterfacedObject, IInfoCartaoCreditoModalidade)
  private
    FarrDescricaoReduzida: TStrInfoCartaoCreditoModalidades ;
    FarrDescricaoCompleta: TStrInfoCartaoCreditoModalidades ;
    FarrModalidadeCodigo: TStrInfoCartaoCreditoModalidades ;
    FarrModalidadeVisivel: TBlnInfoCartaoCreditoModalidades ;
    function fGetDescricaoReduzida(Index: TCartaoCreditoModalidades): String ;
    function fGetDescricaoCompleta(Index: TCartaoCreditoModalidades): String ;
    function fGetModalidadeCodigo(Index: TCartaoCreditoModalidades): String ;
    function fGetModalidadeVisivel(Index: TCartaoCreditoModalidades): Boolean ;
  public
    constructor Create ;
    class function fNew:IInfoCartaoCreditoModalidade ;
    property DescricaoReduzida[Index: TCartaoCreditoModalidades]: String read fGetDescricaoReduzida ;
    property DescricaoCompleta[Index: TCartaoCreditoModalidades]: String read fGetDescricaoCompleta ;
    property ModalidadeCodigo[Index: TCartaoCreditoModalidades] : String read fGetModalidadeCodigo  ;
    property ModalidadeVisivel[Index: TCartaoCreditoModalidades]: Boolean read fGetModalidadeVisivel ;
  end ;

  TModalidadeDinamicaDebitoBanrisul = class(TInterfacedObject, IModalidadeDinamica)
  private
    FlstEdits: TList<TWinControl> ;
    FfltValor: Double ;
    Fowner: TComponent ;
    FownerOpcoes: TComponent ;
    FfrmForm: TForm ;
    FBotaoModelo: TComponent ;
    FprocOnClick: TprocModalidadesOnClick ;
    FprocOnKeyPress: TProcOnKeyPressOpcoes ;
    FprocOnClickConfirmar: TprocModalidadesOnClick ;
    FprocOnClickEncerrar: TprocModalidadesOnClick ;
    FdictBotoes: TObjectDictionary<TChaveValorModalidade, TBitBtnLocked> ;
    FobjOpcaoSelecionada: IOpcoesModalidadeDinamica ;
    procedure pProcessaModalidades(const AstrModalidades: String) ;
    procedure pMontaBotoesModalidades ;
    function fAjustaAcentuacao(const AstrValor: String): String ;
  public
    constructor Create ;
    class function fNew:IModalidadeDinamica ;
    function fMontaTelaModalidade(const AstrModalidades: String): IModalidadeDinamica ;
    function fMontaTelaOpcoes(const AstrModalidades: String; var AstrTextoComplementar: String): IOpcoesModalidadeDinamica ;
    function fOpcoesByModalidade(const AstrModalidades: String): IOpcoesModalidadeDinamica ;
    function fSetOwner(AOwner: TComponent): IModalidadeDinamica ;
    function fSetBotaoModelo(ABotao: TComponent): IModalidadeDinamica ;
    function fSetOnClickModalidade(AprocOnClick: TprocModalidadesOnClick): IModalidadeDinamica ;
    function fOnKeyPressOpcoes(AprocOnKeyPress: TProcOnKeyPressOpcoes): IModalidadeDinamica ; overload ;
    function fOnKeyPressOpcoes: TProcOnKeyPressOpcoes ; overload ;
    function fOnClickConfirmarOpcoes(AprocOnClickConfirmar: TprocModalidadesOnClick): IModalidadeDinamica ; overload ;
    function fOnClickConfirmarOpcoes: TprocModalidadesOnClick ; overload ;
    function fOnClickEncerrarOpcoes(AprocOnClickEncerrar: TprocModalidadesOnClick): IModalidadeDinamica ; overload ;
    function fOnClickEncerrarOpcoes: TprocModalidadesOnClick ; overload ;
    function fModalidadeCarregada: Boolean ;
    function fForm(AFormulario: TForm): IModalidadeDinamica ; overload ;
    function fForm: TForm ; overload ;
    procedure pKeyPressModalidade(const AchrTecla: Char) ;
    procedure pHabilitaBotoesModalidade(const AblnHabilitar: Boolean) ;
    function fOpcoesOwner(Aowner: TComponent): IModalidadeDinamica ; overload ;
    function fOpcoesOwner: TComponent ; overload ;
    function fValor(AfltValor: Double): IModalidadeDinamica ; overload ;
    function fValor: Double ; overload ;
    function fEditsOpcoes(AlstEdits: TList<TWinControl>): IModalidadeDinamica ; overload ;
    function fEditsOpcoes(): TList<TWinControl>; overload ;
    function fBotoesModalidades(ADictBotoes: TObjectDictionary<TChaveValorModalidade, TBitBtnLocked>): IModalidadeDinamica ; overload ;
    function fBotoesModalidades(): TObjectDictionary<TChaveValorModalidade, TBitBtnLocked>; overload ;
  end ;

  TBaseOpcoesModalidadeDinamica = class(TInterfacedObject, IOpcoesModalidadeDinamica)
  private
    procedure pEscondeControlsOwner ;
  protected
    FstrModalidadeEscolhida: String ;
    Fowner: TComponent ;
    FModalidade: IModalidadeDinamica ;
    FpnlOpcoes: TPanel ;
    FbtnConfirmar: TBitBtnLocked ;
    FbtnCancelar: TBitBtnLocked ;
    FedtValor: TCurrencyEditFocus ;
    FlblValor: TLabel ;
    FPrimeiroControl: TComponent ;
    function fValidaCamposInformados(Var AobjControlFoco: TWinControl; Var AstrMensagem: String): Boolean; virtual ;
    function fEnviaDadosInformados: Boolean; virtual ;
  public
    constructor Create ; virtual ; abstract;
    class function fNew:IOpcoesModalidadeDinamica ; virtual ;
    function fMontaOpcoesTela(var AstrTextoComplementar: String): IOpcoesModalidadeDinamica ; virtual ;
    function fSetOwner(Aowner: TComponent): IOpcoesModalidadeDinamica ;
    function fSetModalidade(AobjModalidade: IModalidadeDinamica): IOpcoesModalidadeDinamica ;
    function fPrimeiroControlFoco: TComponent ;
    function fModalidadeEscolhida: String ; overload ;
    function fModalidadeEscolhida(AstrModalidade: String): IOpcoesModalidadeDinamica ; overload ;
    function fListaEdits: TList<TWinControl> ;
    function fBotaoConfirmar: TComponent ;
    function fBotaoCancelar: TComponent ;
  end ;

  TOpcoesBanrisulDebitoPreDatado = class(TBaseOpcoesModalidadeDinamica)
  private
    FlblDataPre: TLabel ;
    FedtDataPre: TcxDateEdit ;
  public
    constructor Create ; reintroduce; virtual;
    class function fNew:IOpcoesModalidadeDinamica ; override ;
    function fMontaOpcoesTela(var AstrTextoComplementar: String): IOpcoesModalidadeDinamica ; override ;
    function fValidaCamposInformados(Var AobjControlFoco: TWinControl; Var AstrMensagem: String): Boolean; override  ;
    function fEnviaDadosInformados: Boolean ; override ;
  end ;

  TOpcoesBanrisulDebitoParcelado = class(TBaseOpcoesModalidadeDinamica)
  private
    FlblNumParcelas: TLabel ;
    FedtNumParcelas: TEditFocus ;
    //FlblMesFechado: TLabel ;
    //FedtMesFechado: TEditFocus ;
    FlblDataPrimeiraParc: TLabel ;
    FlblIntervaloEntreParcelas: TLabel ;
    FedtIntervaloEntreParcelas: TEditFocus ;
    FintPrimParcAvista: Integer ;
    FedtDataPrimeiraParc: TcxDateEdit ;
    procedure pEdtIntervaloEntreParcelasChange(Sender: TObject) ;
  public
    constructor Create ; reintroduce; virtual;
    class function fNew:IOpcoesModalidadeDinamica ; override ;
    function fMontaOpcoesTela(var AstrTextoComplementar: String): IOpcoesModalidadeDinamica ; override ;
    function fValidaCamposInformados(Var AobjControlFoco: TWinControl; Var AstrMensagem: String): Boolean; override  ;
    function fEnviaDadosInformados: Boolean ; override ;
  end ;

  TOpcoesBanrisulDebitoCredito1Minuto = class(TBaseOpcoesModalidadeDinamica, IOpcoesModalidadeDinamica)
  private
    FlblNumParcelas: TLabel ;
    FedtNumParcelas: TEditFocus ;
  public
    constructor Create ; reintroduce; virtual;
    class function fNew:IOpcoesModalidadeDinamica ; override ;
    function fMontaOpcoesTela(var AstrTextoComplementar: String): IOpcoesModalidadeDinamica ; override ;
    function fValidaCamposInformados(Var AobjControlFoco: TWinControl; Var AstrMensagem: String): Boolean; override  ;
    function fEnviaDadosInformados: Boolean ; override ;
  end ;

function fInfoCartaoCreditoModalidade(const AstrCodRed: String): IInfoCartaoCreditoModalidade;
function fModalidadeDinamicaByRede(const AstrCodRed: String): IModalidadeDinamica ;

implementation

uses SysUtils, strUtils, Types, Dialogs, Winapi.Windows, untFuncoesSimples,
     untTefCitelUtil, math, DateUtils ;

function fValidaParcelas(
  AintQtdParc: Integer): Boolean;
begin
  Result := True;

  if AintQtdParc < 2 then
    Result := False;

  if AintQtdParc > 99 then
    Result := False;
end;

function fInfoCartaoCreditoModalidade(const AstrCodRed: String): IInfoCartaoCreditoModalidade;
begin
  if AstrCodRed = ALGORIX then
  begin
    Result := TInfoCartaoCreditoModalidadeAlgorix.fNew ;
  end
  else
  begin
    Result := TInfoCartaoCreditoModalidadeDefault.fNew ;
  end ;
end ;

function fModalidadeDinamicaByRede(const AstrCodRed: String): IModalidadeDinamica ;
begin
  if AstrCodRed =  BANRISUL then
  begin
    result := TModalidadeDinamicaDebitoBanrisul.fNew ;
  end
  else
  begin
    result := Nil ;
  end ;
end ;

{ TInfoCartaoCreditoModalidadeDefault }

constructor TInfoCartaoCreditoModalidadeDefault.Create;
begin
  FarrDescricaoCompleta[ccmAVista]   := 'Selecionado crédito à vista' ;
  FarrDescricaoCompleta[ccmParcAdm]  := 'Crédito parcelado COM juros pela administradora' ;
  FarrDescricaoCompleta[ccmParcLoja] := 'Crédito parcelado pelo estabelecimento' ;

  FarrDescricaoReduzida[ccmAVista]   := '1 - À Vista          ' ;
  FarrDescricaoReduzida[ccmParcAdm]  := '2 - Parcelado Adm    ' ;
  FarrDescricaoReduzida[ccmParcLoja] := '3 - Parcelado Estab  ' ;

  FarrModalidadeCodigo[ccmAVista]    := '1' ;
  FarrModalidadeCodigo[ccmParcAdm]   := '3' ;
  FarrModalidadeCodigo[ccmParcLoja]  := '2' ;

  FarrModalidadeVisivel[ccmAVista]   := True ;
  FarrModalidadeVisivel[ccmParcAdm]  := True ;
  FarrModalidadeVisivel[ccmParcLoja] := True ;
end;

function TInfoCartaoCreditoModalidadeDefault.fGetDescricaoCompleta(
  Index: TCartaoCreditoModalidades): String;
begin
  Result := FarrDescricaoCompleta[Index] ;
end;

function TInfoCartaoCreditoModalidadeDefault.fGetDescricaoReduzida(
  Index: TCartaoCreditoModalidades): String;
begin
  Result := FarrDescricaoReduzida[Index] ;
end;

function TInfoCartaoCreditoModalidadeDefault.fGetModalidadeCodigo(
  Index: TCartaoCreditoModalidades): String;
begin
  Result := FarrModalidadeCodigo[Index] ;
end;

function TInfoCartaoCreditoModalidadeDefault.fGetModalidadeVisivel(
  Index: TCartaoCreditoModalidades): Boolean;
begin
  Result := FarrModalidadeVisivel[Index] ;
end;

class function TInfoCartaoCreditoModalidadeDefault.fNew: IInfoCartaoCreditoModalidade;
begin
  Result := TInfoCartaoCreditoModalidadeDefault.Create ;
end;

{ TInfoCartaoCreditoModalidadeAlgorix }

constructor TInfoCartaoCreditoModalidadeAlgorix.Create;
begin
  FarrDescricaoCompleta[ccmAVista]   := 'Selecionado crédito à vista' ;
  FarrDescricaoCompleta[ccmParcAdm]  := '' ;
  FarrDescricaoCompleta[ccmParcLoja] := 'Crédito parcelado pelo estabelecimento' ;

  FarrDescricaoReduzida[ccmAVista]   := '1 - À Vista          ' ;
  FarrDescricaoReduzida[ccmParcAdm]  := '' ;
  FarrDescricaoReduzida[ccmParcLoja] := '3 - Parcelado Estab  ' ;

  FarrModalidadeCodigo[ccmAVista]    := '1' ;
  FarrModalidadeCodigo[ccmParcAdm]   := '' ;
  FarrModalidadeCodigo[ccmParcLoja]  := '3' ;

  FarrModalidadeVisivel[ccmAVista]   := True ;
  FarrModalidadeVisivel[ccmParcAdm]  := False ;
  FarrModalidadeVisivel[ccmParcLoja] := True ;
end;

function TInfoCartaoCreditoModalidadeAlgorix.fGetDescricaoCompleta(
  Index: TCartaoCreditoModalidades): String;
begin
  Result := FarrDescricaoCompleta[Index] ;
end;

function TInfoCartaoCreditoModalidadeAlgorix.fGetDescricaoReduzida(
  Index: TCartaoCreditoModalidades): String;
begin
  Result := FarrDescricaoReduzida[Index] ;
end;

function TInfoCartaoCreditoModalidadeAlgorix.fGetModalidadeCodigo(
  Index: TCartaoCreditoModalidades): String;
begin
  Result := FarrModalidadeCodigo[Index] ;
end;

function TInfoCartaoCreditoModalidadeAlgorix.fGetModalidadeVisivel(
  Index: TCartaoCreditoModalidades): Boolean;
begin
  Result := FarrModalidadeVisivel[Index] ;
end;

class function TInfoCartaoCreditoModalidadeAlgorix.fNew: IInfoCartaoCreditoModalidade;
begin
  Result := TInfoCartaoCreditoModalidadeAlgorix.Create ;
end;

{ TModalidadeDinamicaDebitoBanrisul }

constructor TModalidadeDinamicaDebitoBanrisul.Create;
begin
  Fowner := Nil ;
  FownerOpcoes := Nil ;
  FBotaoModelo := Nil ;
  FprocOnClick := Nil ;
  FprocOnKeyPress := Nil ;
  FobjOpcaoSelecionada := Nil ;
  FprocOnClickConfirmar := Nil ;
  FprocOnClickEncerrar := Nil ;
end;

function TModalidadeDinamicaDebitoBanrisul.fAjustaAcentuacao(
  const AstrValor: String): String;
const
   SEM_ACENTUACAO : array [1..5] of string = ('a vista', 'pre-datado', 'credito um minuto', 'parcelado primeiro a vista', 'parcelado sem entrada') ;
   COM_ACENTUACAO : array [1..5] of string = ('À Vista', 'Pré-Datado', 'Crédito Um Minuto', 'Parc. 1ª à Vista', 'Parc. Sem Entrada') ;
var
  LintCnt: Integer ;
begin
  result := AstrValor ;
  for LintCnt := Low(SEM_ACENTUACAO) to High(SEM_ACENTUACAO) do
  begin
    if SEM_ACENTUACAO[LintCnt] = Trim(LowerCase(AstrValor)) then
    begin
      result := COM_ACENTUACAO[LintCnt] ;
      break ;
    end
  end ;
end;

function TModalidadeDinamicaDebitoBanrisul.fBotoesModalidades(
  ADictBotoes: TObjectDictionary<TChaveValorModalidade, TBitBtnLocked>): IModalidadeDinamica;
begin
  Result := Self ;
  FdictBotoes := ADictBotoes ;
end;

function TModalidadeDinamicaDebitoBanrisul.fBotoesModalidades: TObjectDictionary<TChaveValorModalidade, TBitBtnLocked>;
begin
  Result := FdictBotoes ;
end;

function TModalidadeDinamicaDebitoBanrisul.fEditsOpcoes(
  AlstEdits: TList<TWinControl>): IModalidadeDinamica;
begin
  Result := Self ;
  FlstEdits := AlstEdits ;
end;

function TModalidadeDinamicaDebitoBanrisul.fEditsOpcoes: TList<TWinControl>;
begin
  Result := FlstEdits ;
end;

function TModalidadeDinamicaDebitoBanrisul.fModalidadeCarregada: Boolean;
var
  LprItens: TPair<TChaveValorModalidade, TBitBtnLocked> ;
  LblnFlag: Boolean ;
begin
  LblnFlag := False ;

  if not Assigned(FdictBotoes) then
    Exit(LblnFlag) ;

  for LprItens in FdictBotoes do
  begin
    if Assigned(LprItens.Value) then
    begin
      LblnFlag := True ;
      Break ;
    end ;
  end ;
  Result := LblnFlag ;
end;

function TModalidadeDinamicaDebitoBanrisul.fMontaTelaModalidade(
  const AstrModalidades: String): IModalidadeDinamica;
begin
  result := Self ;
  pProcessaModalidades(AstrModalidades);
  pMontaBotoesModalidades ;
end;

class function TModalidadeDinamicaDebitoBanrisul.fNew: IModalidadeDinamica;
begin
  Result := TModalidadeDinamicaDebitoBanrisul.Create ;
end;

function TModalidadeDinamicaDebitoBanrisul.fOpcoesOwner(
  Aowner: TComponent): IModalidadeDinamica;
begin
  result := Self ;
  FownerOpcoes := Aowner ;
end;

function TModalidadeDinamicaDebitoBanrisul.fOnKeyPressOpcoes(
  AprocOnKeyPress: TProcOnKeyPressOpcoes): IModalidadeDinamica;
begin
  result := Self ;
  FprocOnKeyPress := AprocOnKeyPress ;
end;

function TModalidadeDinamicaDebitoBanrisul.fOnClickConfirmarOpcoes(
  AprocOnClickConfirmar: TprocModalidadesOnClick): IModalidadeDinamica;
begin
  result := Self ;
  FprocOnClickConfirmar := AprocOnClickConfirmar ;
end;

function TModalidadeDinamicaDebitoBanrisul.fOnClickConfirmarOpcoes: TprocModalidadesOnClick;
begin
  Result := FprocOnClickConfirmar ;
end;

function TModalidadeDinamicaDebitoBanrisul.fOnClickEncerrarOpcoes(
  AprocOnClickEncerrar: TprocModalidadesOnClick): IModalidadeDinamica;
begin
  result := Self ;
  FprocOnClickEncerrar := AprocOnClickEncerrar ;
end;

function TModalidadeDinamicaDebitoBanrisul.fOnClickEncerrarOpcoes: TprocModalidadesOnClick;
begin
  result := FprocOnClickEncerrar ;
end;

function TModalidadeDinamicaDebitoBanrisul.fOnKeyPressOpcoes: TProcOnKeyPressOpcoes;
begin
  Result := FprocOnKeyPress ;
end;

function TModalidadeDinamicaDebitoBanrisul.fOpcoesByModalidade(
  const AstrModalidades: String): IOpcoesModalidadeDinamica;
begin
  Result := Nil ;
  if AstrModalidades = '2' then
    Result := TOpcoesBanrisulDebitoPreDatado.fNew
  else if AstrModalidades = '3' then
    Result := TOpcoesBanrisulDebitoParcelado.fNew
  else if AstrModalidades = '4' then
    Result := TOpcoesBanrisulDebitoCredito1Minuto.fNew ;
end;

function TModalidadeDinamicaDebitoBanrisul.fOpcoesOwner: TComponent;
begin
  result := FownerOpcoes ;
end;

function TModalidadeDinamicaDebitoBanrisul.fSetBotaoModelo(
  ABotao: TComponent): IModalidadeDinamica;
begin
  FBotaoModelo := ABotao ;
  result := Self ;
end;

function TModalidadeDinamicaDebitoBanrisul.fForm(
  AFormulario: TForm): IModalidadeDinamica;
begin
  FfrmForm := AFormulario ;
  result := Self ;
end;

function TModalidadeDinamicaDebitoBanrisul.fForm: TForm;
begin
  Result := FfrmForm ;
end;

function TModalidadeDinamicaDebitoBanrisul.fSetOnClickModalidade(
  AprocOnClick: TprocModalidadesOnClick): IModalidadeDinamica;
begin
  result := Self ;
  FprocOnClick := AprocOnClick ;
end;

function TModalidadeDinamicaDebitoBanrisul.fSetOwner(
  AOwner: TComponent): IModalidadeDinamica;
begin
  Fowner := AOwner ;
  result := Self ;
end;

function TModalidadeDinamicaDebitoBanrisul.fValor(
  AfltValor: Double): IModalidadeDinamica;
begin
  FfltValor := AfltValor ;
  Result := Self ;
end;

function TModalidadeDinamicaDebitoBanrisul.fValor: Double;
begin
  Result := FfltValor ;
end;

procedure TModalidadeDinamicaDebitoBanrisul.pHabilitaBotoesModalidade(
  const AblnHabilitar: Boolean);
var
  LprItens: TPair<TChaveValorModalidade, TBitBtnLocked> ;
begin
  for LprItens in FdictBotoes do
  begin
    LprItens.Value.Enabled := AblnHabilitar ;
  end ;
end;

procedure TModalidadeDinamicaDebitoBanrisul.pKeyPressModalidade(
  const AchrTecla: Char);
var
  LbtnRunTime: TBitBtnLocked ;
  LedtEdit: TWinControl ;
  LblnFocado: Boolean ;
  LprItens: TPair<TChaveValorModalidade, TBitBtnLocked> ;
begin
  // botões de confirma e cancela das opções
  if Assigned(FobjOpcaoSelecionada) then
  begin
    LblnFocado := False ;
    for LedtEdit in FobjOpcaoSelecionada.fListaEdits do
    begin
      if LedtEdit.Focused then
      begin
        LblnFocado := True ;
        Break ;
      end ;
    end ;
    if not LblnFocado then
    begin
      if AchrTecla = '1' then
        TBitBtnLocked(FobjOpcaoSelecionada.fBotaoConfirmar).Click ;
      if AchrTecla = '9' then
        TBitBtnLocked(FobjOpcaoSelecionada.fBotaoCancelar).Click ;
    end ;
    exit ;
  end ;


  for LprItens in FdictBotoes do
  begin
    if LprItens.Key.Chave = AchrTecla then
    begin
      LbtnRunTime := LprItens.Value ;

      if not LbtnRunTime.Visible then
        Exit ;

      if Not LbtnRunTime.Enabled then
        Exit ;

      LbtnRunTime.Click ;
    end ;
  end ;

  if AchrTecla = '9' then
  begin
    if Assigned(FBotaoModelo) then
      TBitBtnLocked(FBotaoModelo).Click ;
  end ;

end;

procedure TModalidadeDinamicaDebitoBanrisul.pMontaBotoesModalidades;
var
  LprItem: TChaveValorModalidade ;
  LbtnRunTime: TBitBtnLocked ;
  LintProximoTop: integer ;
  LintCnt: Integer ;
  LintTamanhoUtilPanel: Integer ;
  LintTamanhoRealBotao: Integer ;

  LlstModalidades: TList<TChaveValorModalidade> ;
  LprItens: TPair<TChaveValorModalidade, TBitBtnLocked> ;
begin
  LintProximoTop := 0 ;

  LlstModalidades := TList<TChaveValorModalidade>.Create ;
  try
    for LprItens in FdictBotoes do
    begin
      LlstModalidades.Add(LprItens.Key) ;
    end ;

    for LintCnt := 0 to FfrmForm.ComponentCount-1 do
    begin
      if FfrmForm.Components[LintCnt] is TBitBtnLocked then
      begin
        if TBitBtnLocked(FfrmForm.Components[LintCnt]).Parent = FOwner then
        begin
          if FfrmForm.Components[LintCnt].Name <> FBotaoModelo.Name then
          begin
            TBitBtnLocked(FfrmForm.Components[LintCnt]).Visible := False ;
          end ;
        end ;
      end ;
    end ;

    LintTamanhoRealBotao := TBitBtnLocked(FBotaoModelo).Height + TBitBtnLocked(FBotaoModelo).Spacing + TBitBtnLocked(FBotaoModelo).Margins.Top ;
    for LintCnt := LlstModalidades.Count-1 downto 0 do
    begin
      LprItem := LlstModalidades.Items[LintCnt] ;
      LbtnRunTime := TBitBtnLocked.Create(FfrmForm);
      LbtnRunTime.Parent := TWinControl(FOwner) ;
      /// aplica o modelo
      LbtnRunTime.Align := AlTop ;
      LbtnRunTime.AlignWithMargins := TBitBtnLocked(FBotaoModelo).AlignWithMargins ;
      LbtnRunTime.Cursor := TBitBtnLocked(FBotaoModelo).Cursor ;
      LbtnRunTime.Spacing := TBitBtnLocked(FBotaoModelo).Spacing ;
      LbtnRunTime.Left := TBitBtnLocked(FBotaoModelo).Left ;
      LbtnRunTime.Width := TBitBtnLocked(FBotaoModelo).Width ;
      LbtnRunTime.Height := TBitBtnLocked(FBotaoModelo).Height ;
      LbtnRunTime.Font := TBitBtnLocked(FBotaoModelo).Font ;
      LbtnRunTime.Caption := copy(IntToStr(LintCnt+1) + ' - ' + fAjustaAcentuacao(LprItem.Valor) + StringOfChar(' ', 100), 1, 21) ;
      LbtnRunTime.Tag := StrToInt(LprItem.Chave) ;
      LbtnRunTime.OnClick := FprocOnClick ;
      FdictBotoes.Items[LprItem] := LbtnRunTime ;
      LintProximoTop := LintProximoTop + LintTamanhoRealBotao ;
    end ;

    // redimenciona o form.
    LintTamanhoUtilPanel := 148 - LintTamanhoRealBotao ;
    if LintTamanhoUtilPanel < LintProximoTop then
      FfrmForm.Height := FfrmForm.Height + abs(LintProximoTop-LintTamanhoUtilPanel) ;
  finally
    FreeAndNil(LlstModalidades) ;
  end ;
end;

function TModalidadeDinamicaDebitoBanrisul.fMontaTelaOpcoes(
  const AstrModalidades: String; var AstrTextoComplementar: String): IOpcoesModalidadeDinamica;
begin
  Result := fOpcoesByModalidade(AstrModalidades) ;
  if not Assigned(Result) then
    Exit ;

  Result.fSetOwner(FownerOpcoes)
    .fSetModalidade(Self)
    .fMontaOpcoesTela(AstrTextoComplementar)
    .fModalidadeEscolhida(AstrModalidades) ;

  FobjOpcaoSelecionada := Result ;
end;

procedure TModalidadeDinamicaDebitoBanrisul.pProcessaModalidades(const AstrModalidades: String);
var
  LlstRetornoModalidades: TStringDynArray ;
  LlstChaveValor: TStringDynArray ;
  LstrModalidade: String ;
  LrecItem: TChaveValorModalidade ;
begin
  LlstRetornoModalidades := SplitString(AstrModalidades, ';') ;
  for LstrModalidade in LlstRetornoModalidades do
  begin
    if Pos(':', LstrModalidade) > 0 then
    begin
      LlstChaveValor := SplitString(LstrModalidade, ':') ;
      LrecItem := TChaveValorModalidade.Create ;
      LrecItem.Chave := LlstChaveValor[0] ;
      LrecItem.Valor := LlstChaveValor[1] ;
      FdictBotoes.Add(LrecItem, Nil);
    end ;
  end ;
end;

{ TBaseOpcoesModalidadeDinamica }

function TBaseOpcoesModalidadeDinamica.fBotaoCancelar: TComponent;
begin
  Result := FbtnCancelar ;
end;

function TBaseOpcoesModalidadeDinamica.fBotaoConfirmar: TComponent;
begin
  Result := FbtnConfirmar ;
end;

function TBaseOpcoesModalidadeDinamica.fEnviaDadosInformados: Boolean;
begin
  Result := True ; // será sobrescrito na classe filha
end;

function TBaseOpcoesModalidadeDinamica.fListaEdits: TList<TWinControl>;
begin
  Result := FModalidade.fEditsOpcoes ;
end;

function TBaseOpcoesModalidadeDinamica.fModalidadeEscolhida: String;
begin
  Result := FstrModalidadeEscolhida ;
end;

function TBaseOpcoesModalidadeDinamica.fModalidadeEscolhida(
  AstrModalidade: String): IOpcoesModalidadeDinamica;
begin
  Result := Self ;
  FstrModalidadeEscolhida := AstrModalidade ;
end;

function TBaseOpcoesModalidadeDinamica.fMontaOpcoesTela(var AstrTextoComplementar: String): IOpcoesModalidadeDinamica;
var
  LfrmForm: TForm ;
  LpnlRodape: TPanel ;
  LprocOnClickConfirmar: TprocModalidadesOnClick ;
  LprocOnClickEncerrar: TprocModalidadesOnClick ;
  LfltValor: Double ;
begin
  AstrTextoComplementar := '' ;
  result := Self ;

  if not Assigned(Fowner) then
    Exit ;

  if not Assigned(FModalidade) then
    Exit ;

  pEscondeControlsOwner ;

  LfrmForm := FModalidade.fForm ;
  LprocOnClickConfirmar := FModalidade.fOnClickConfirmarOpcoes ;
  LprocOnClickEncerrar := FModalidade.fOnClickEncerrarOpcoes ;
  LfltValor := FModalidade.fValor ;
  LfrmForm.Height := 291 ;

  FpnlOpcoes := TPanel.Create(LfrmForm);
  FpnlOpcoes.Parent := TWinControl(FOwner);
  FpnlOpcoes.BevelOuter := bvNone ;
  FpnlOpcoes.Align := alClient ;
  FpnlOpcoes.Caption := '' ;

  // valor
  FlblValor := TLabel.Create(LfrmForm) ;
  FlblValor.Parent := FpnlOpcoes ;
  FlblValor.Top := 8 ;
  FlblValor.Left := 68 ;
  FlblValor.Caption := 'Valor:' ;

  FedtValor := TCurrencyEditFocus.Create(LfrmForm) ;
  FedtValor.Parent := FpnlOpcoes ;
  FedtValor.Enabled := False ;
  FedtValor.Left := 104 ;
  FedtValor.Top := 5 ;
  FedtValor.Value := LfltValor ;

  ///rodapé
  LpnlRodape := TPanel.Create(LfrmForm);
  LpnlRodape.Parent := FpnlOpcoes ;
  LpnlRodape.BevelOuter := bvNone ;
  LpnlRodape.Align := alBottom ;
  LpnlRodape.Caption := '' ;
  LpnlRodape.Height := 29 ;

  FbtnConfirmar := TBitBtnLocked.Create(LfrmForm);
  FbtnConfirmar.Parent := LpnlRodape ;
  FbtnConfirmar.OnClick := LprocOnClickConfirmar ;
  FbtnConfirmar.Height := 27 ;
  FbtnConfirmar.Width := 120 ;
  FbtnConfirmar.Caption := '1 - &Confirmar' ;
  FbtnConfirmar.Left := 2 ;
  FbtnConfirmar.Top := 2 ;

  FbtnCancelar := TBitBtnLocked.Create(LfrmForm);
  FbtnCancelar.Parent := LpnlRodape ;
  FbtnCancelar.OnClick := LprocOnClickEncerrar ;
  FbtnCancelar.Height := 27 ;
  FbtnCancelar.Width := 120 ;
  FbtnCancelar.Caption := '9 - Ca&ncelar' ;
  FbtnCancelar.Left := 124 ;
  FbtnCancelar.Top := 2 ;

end;

class function TBaseOpcoesModalidadeDinamica.fNew: IOpcoesModalidadeDinamica;
begin
  Result := Nil ;
end;

function TBaseOpcoesModalidadeDinamica.fPrimeiroControlFoco: TComponent;
begin
  Result := FPrimeiroControl ;
end;

function TBaseOpcoesModalidadeDinamica.fSetModalidade(
  AobjModalidade: IModalidadeDinamica): IOpcoesModalidadeDinamica;
begin
  result := Self ;
  FModalidade := AobjModalidade ;
end;

function TBaseOpcoesModalidadeDinamica.fSetOwner(
  Aowner: TComponent): IOpcoesModalidadeDinamica;
begin
  result := Self ;
  Fowner := Aowner ;
end;

function TBaseOpcoesModalidadeDinamica.fValidaCamposInformados(
  var AobjControlFoco: TWinControl; var AstrMensagem: String): Boolean;
begin
  Result := True ; // será sobrescrito na classe filha
end;

procedure TBaseOpcoesModalidadeDinamica.pEscondeControlsOwner;
var
  LfrmForm: TForm ;
  LintCnt: Integer ;
begin

  LfrmForm := FModalidade.fForm ;

  for LintCnt := 0 to LfrmForm.ComponentCount-1 do
  begin
    if (LfrmForm.Components[LintCnt] is TWinControl) and (TWinControl(LfrmForm.Components[LintCnt]).Parent = FOwner) then
    begin
      TWinControl(LfrmForm.Components[LintCnt]).Visible := False ;
    end ;
  end ;

end;

{ TOpcoesBanrisulDebitoPreDatado }

constructor TOpcoesBanrisulDebitoPreDatado.Create;
begin
  FlblDataPre := Nil ;
  FedtDataPre := Nil ;
end;

function TOpcoesBanrisulDebitoPreDatado.fEnviaDadosInformados: Boolean;
var
  LdtaDataPre: TDate ;
  LfltValor: Double ;
begin
  LdtaDataPre := FedtDataPre.Date ;
  LfltValor := FModalidade.fValor ;

  pInfo21(FstrModalidadeEscolhida);
  pInfo30DebitoPreDatado(LdtaDataPre);
  pinfo34(LfltValor);
  Result := True ;
end;

function TOpcoesBanrisulDebitoPreDatado.fMontaOpcoesTela(var AstrTextoComplementar: String): IOpcoesModalidadeDinamica;
var
  LfrmForm: TForm ;
  LprocOnKeyPress: TProcOnKeyPressOpcoes ;
  LlstEdits: TList<TWinControl> ;
begin
  inherited fMontaOpcoesTela(AstrTextoComplementar);
  result := Self ;

  LfrmForm := FModalidade.fForm ;
  LprocOnKeyPress := FModalidade.fOnKeyPressOpcoes ;
  LlstEdits := FModalidade.fEditsOpcoes ;

  FlblDataPre := TLabel.Create(LfrmForm);
  FlblDataPre.Parent := TWinControl(Fowner) ;
  FlblDataPre.Top := 40 ;
  FlblDataPre.Left := 11 ;
  FlblDataPre.Caption := 'Data Pré-Datado:' ;

  FedtDataPre := TcxDateEdit.Create(LfrmForm);
  FedtDataPre.Parent := TWinControl(Fowner) ;
  FedtDataPre.OnKeyPress := LprocOnKeyPress ;
  LlstEdits.Add(FedtDataPre) ;
  FedtDataPre.Tag := 99 ;
  FedtDataPre.Left := 104 ;
  FedtDataPre.Top := 36 ;
  FedtDataPre.Width := 90 ;
  FedtDataPre.Date := fDataDebitoPreDatadoScope ;
  FPrimeiroControl := FedtDataPre ;

end;

class function TOpcoesBanrisulDebitoPreDatado.fNew: IOpcoesModalidadeDinamica;
begin
  Result := TOpcoesBanrisulDebitoPreDatado.Create ;
end;

function TOpcoesBanrisulDebitoPreDatado.fValidaCamposInformados(
  var AobjControlFoco: TWinControl; var AstrMensagem: String): Boolean;
begin
  Result := False ;
  if FedtDataPre.Date < VS_Date then
  begin
    AstrMensagem := 'Campo "Data Pré-Datado" inválida!' ;
    AobjControlFoco := FedtDataPre ;
    exit ;
  end ;

  if FedtDataPre.Date = VS_Date then
  begin
    AstrMensagem := 'Campo "Data Pré-Datado" deve ser maior que a data atual!' ;
    AobjControlFoco := FedtDataPre ;
    exit ;
  end ;

  Result := True ;
end;

{ TOpcoesBanrisulDebitoParcelado }

constructor TOpcoesBanrisulDebitoParcelado.Create;
begin
  FlblNumParcelas := Nil ;
  FedtNumParcelas := Nil ;
  //FlblMesFechado := Nil ;
  //FedtMesFechado := Nil ;
  FlblDataPrimeiraParc := Nil ;
  FlblIntervaloEntreParcelas := Nil ;
  FedtIntervaloEntreParcelas := Nil ;
  FedtDataPrimeiraParc := Nil ;
  FintPrimParcAvista := 0 ;
  if fMensagem('ATENÇÃO!', 'Com Entrada?', ['&Sim', '&Não'], 1) = 2 then
  begin
    FintPrimParcAvista := 1 ;
  end;
end;

function TOpcoesBanrisulDebitoParcelado.fEnviaDadosInformados: Boolean;
var
  LfltValor: Double ;
  LintParc: Integer ;
  //LintMesFechado: Integer ;
  LintIntervaloParc: Integer ;
  LdtaPrimParcela: TDate ;
begin
  LintParc := StrToInt(FedtNumParcelas.Text) ;
  //LintMesFechado := StrToInt(FedtMesFechado.Text) ;
  LintIntervaloParc := StrToInt(FedtIntervaloEntreParcelas.Text) ;
  LdtaPrimParcela := FedtDataPrimeiraParc.Date ;

  LfltValor := FModalidade.fValor ;

  pInfo21(FstrModalidadeEscolhida);
  pInfo30DebitoParcelado(LintParc, LintIntervaloParc, FintPrimParcAvista, LdtaPrimParcela) ;
  pinfo34(LfltValor);
  Result := True ;
end;

procedure TOpcoesBanrisulDebitoParcelado.pEdtIntervaloEntreParcelasChange(Sender: TObject) ;
begin
  FedtDataPrimeiraParc.Date := IncDay(VS_Date, StrToIntDef(TEditFocus(Sender).Text, 1)) ;
end ;

function TOpcoesBanrisulDebitoParcelado.fMontaOpcoesTela(var AstrTextoComplementar: String): IOpcoesModalidadeDinamica;
var
  LfrmForm: TForm ;
  LprocOnKeyPress: TProcOnKeyPressOpcoes ;
  LlstEdits: TList<TWinControl> ;
begin
  inherited fMontaOpcoesTela(AstrTextoComplementar);
  result := Self ;

  AstrTextoComplementar := ifthen(FintPrimParcAvista = 0, 'Com Entrada', 'Sem Entrada') ;

  LfrmForm := FModalidade.fForm ;
  LprocOnKeyPress := FModalidade.fOnKeyPressOpcoes ;
  LlstEdits := FModalidade.fEditsOpcoes ;

  FlblValor.Left := 81 ;
  FedtValor.Left := 114 ;

  FlblNumParcelas := TLabel.Create(LfrmForm);
  FlblNumParcelas.Parent := TWinControl(Fowner) ;
  FlblNumParcelas.Left := 35;
  FlblNumParcelas.Top := 40;
  FlblNumParcelas.Caption := 'Número de Parc.:';

  FedtNumParcelas := TEditFocus.Create(LfrmForm);
  FedtNumParcelas.Parent := TWinControl(Fowner) ;
  FedtNumParcelas.OnKeyPress := LprocOnKeyPress ;
  LlstEdits.Add(FedtNumParcelas) ;
  FedtNumParcelas.Tag := 99 ;
  FedtNumParcelas.Left := 124;
  FedtNumParcelas.Top := 36;
  FedtNumParcelas.Width := 43;
  FedtNumParcelas.Height := 21;
  FedtNumParcelas.Alignment := taRightJustify;
  FedtNumParcelas.MaxLength := 2;
  FedtNumParcelas.CompZeros := False;
  FedtNumParcelas.TipoTexto := ttNumerico;
  FedtNumParcelas.Text := '2' ;
  FPrimeiroControl := FedtNumParcelas ;

  FlblIntervaloEntreParcelas := TLabel.Create(LfrmForm);
  FlblIntervaloEntreParcelas.Parent := TWinControl(Fowner) ;
  FlblIntervaloEntreParcelas.Left := 14;
  FlblIntervaloEntreParcelas.Top := 72;
  FlblIntervaloEntreParcelas.Caption := 'Intervalo Entre Parc.:';
  FlblIntervaloEntreParcelas.Visible := FintPrimParcAvista = 0 ;

  FedtIntervaloEntreParcelas := TEditFocus.Create(LfrmForm);
  FedtIntervaloEntreParcelas.Parent := TWinControl(Fowner) ;
  FedtIntervaloEntreParcelas.OnKeyPress := LprocOnKeyPress ;
  LlstEdits.Add(FedtIntervaloEntreParcelas) ;
  FedtIntervaloEntreParcelas.Tag := 99 ;
  FedtIntervaloEntreParcelas.Left := 124;
  FedtIntervaloEntreParcelas.Top := 69;
  FedtIntervaloEntreParcelas.Width := 43;
  FedtIntervaloEntreParcelas.Height := 21;
  FedtIntervaloEntreParcelas.Alignment := taRightJustify;
  FedtIntervaloEntreParcelas.MaxLength := 3;
  FedtIntervaloEntreParcelas.CompZeros := False;
  FedtIntervaloEntreParcelas.TipoTexto := ttNumerico;
  FedtIntervaloEntreParcelas.Text := '30' ;
  FedtIntervaloEntreParcelas.Visible := FintPrimParcAvista = 0 ;

  FlblDataPrimeiraParc := TLabel.Create(LfrmForm);
  FlblDataPrimeiraParc.Parent := TWinControl(Fowner) ;
  FlblDataPrimeiraParc.Left := 37;
  FlblDataPrimeiraParc.Top := 72;
  FlblDataPrimeiraParc.Caption := 'Data 1ª Parcela:';
  FlblDataPrimeiraParc.Visible := FintPrimParcAvista <> 0 ;

  FedtDataPrimeiraParc := TcxDateEdit.Create(LfrmForm);
  FedtDataPrimeiraParc.Parent := TWinControl(Fowner) ;
  FedtDataPrimeiraParc.OnKeyPress := LprocOnKeyPress ;
  LlstEdits.Add(FedtDataPrimeiraParc) ;
  FedtDataPrimeiraParc.Tag := 99 ;
  FedtDataPrimeiraParc.Left := 124 ;
  FedtDataPrimeiraParc.Top := 69 ;
  FedtDataPrimeiraParc.Width := 90 ;
  FedtDataPrimeiraParc.Visible := FintPrimParcAvista <> 0;

  if FedtDataPrimeiraParc.Visible then
    FedtDataPrimeiraParc.Date := IncDay(VS_Date, strtoint(FedtIntervaloEntreParcelas.Text))
  else
    FedtDataPrimeiraParc.Date := VS_Date ;

  FedtIntervaloEntreParcelas.OnChange := pEdtIntervaloEntreParcelasChange ;

end;

class function TOpcoesBanrisulDebitoParcelado.fNew: IOpcoesModalidadeDinamica;
begin
  Result := TOpcoesBanrisulDebitoParcelado.Create ;
end;

function TOpcoesBanrisulDebitoParcelado.fValidaCamposInformados(
  var AobjControlFoco: TWinControl; var AstrMensagem: String): Boolean;
var
  LintQtdParcelas : integer ;
  LintIntervalo : integer ;
begin
  Result := False ;

  LintQtdParcelas := StrToIntDef(FedtNumParcelas.Text,0);
  if not fValidaParcelas(LintQtdParcelas) then
  begin
    AstrMensagem := 'Campo "Número de Parc." inválido. Mínimo 2, máximo 99.' ;
    AobjControlFoco := FedtNumParcelas ;
    Exit;
  end;

  LintIntervalo := StrToIntDef(FedtIntervaloEntreParcelas.Text,0);
  if LintIntervalo = 0 then
  begin
    AstrMensagem := 'Campo "Intervalo Entre Parc." inválido.' ;
    AobjControlFoco := FedtIntervaloEntreParcelas ;
    Exit;
  end;

  //if fEmptyStr(FedtMesFechado.Text) then
  //begin
  //  AstrMensagem := 'Campo "Mês Fechado" não informado!' ;
  //  AobjControlFoco := FedtMesFechado ;
  //  exit ;
  //end ;

  //if not CharInSet(FedtMesFechado.Text[1], ['0', '1']) then
  //begin
  //  AstrMensagem := 'Campo "Mês Fechado" informe, 0-Sim, 1-Não' ;
  //  AobjControlFoco := FedtMesFechado ;
  //  exit ;
  //end ;

  //if (FedtMesFechado.Text = '1') or (FintPrimParcAvista = 1) then
  //begin
  //  if FedtDataPrimeiraParc.Date < VS_Date then
  //  begin
  //    AstrMensagem := 'Campo "Data Primeira Parcela" inválida!' ;
  //    AobjControlFoco := FedtDataPrimeiraParc ;
  //    exit ;
  //  end ;
  //end ;

  Result := True ;
end;

{ TOpcoesBanrisulDebitoCredito1Minuto }

constructor TOpcoesBanrisulDebitoCredito1Minuto.Create;
begin
  FlblNumParcelas := Nil ;
  FedtNumParcelas := Nil ;
end;

function TOpcoesBanrisulDebitoCredito1Minuto.fEnviaDadosInformados: Boolean;
var
  LfltValor: Double ;
  LintParcCdc: Integer ;
begin
  LintParcCdc := StrToInt(FedtNumParcelas.Text) ;
  LfltValor := FModalidade.fValor ;

  pInfo21(FstrModalidadeEscolhida);
  pInfo30DebitoCredito1Minuto(LintParcCdc);
  pinfo34(LfltValor);
  Result := True ;
end;

function TOpcoesBanrisulDebitoCredito1Minuto.fMontaOpcoesTela(var AstrTextoComplementar: String): IOpcoesModalidadeDinamica;
var
  LfrmForm: TForm ;
  LprocOnKeyPress: TProcOnKeyPressOpcoes ;
  LlstEdits: TList<TWinControl> ;
begin
  inherited fMontaOpcoesTela(AstrTextoComplementar);
  result := Self ;

  LfrmForm := FModalidade.fForm ;
  LprocOnKeyPress := FModalidade.fOnKeyPressOpcoes ;
  LlstEdits := FModalidade.fEditsOpcoes ;

  FlblValor.Left := 81 ;
  FedtValor.Left := 114 ;

  FlblNumParcelas := TLabel.Create(LfrmForm);
  FlblNumParcelas.Parent := TWinControl(Fowner) ;
  FlblNumParcelas.Left := 35;
  FlblNumParcelas.Top := 40;
  FlblNumParcelas.Caption := 'Número de Parc.:';

  FedtNumParcelas := TEditFocus.Create(LfrmForm);
  FedtNumParcelas.Parent := TWinControl(Fowner) ;
  FedtNumParcelas.OnKeyPress := LprocOnKeyPress ;
  LlstEdits.Add(FedtNumParcelas) ;
  FedtNumParcelas.Tag := 99 ;
  FedtNumParcelas.Left := 124;
  FedtNumParcelas.Top := 36;
  FedtNumParcelas.Width := 43;
  FedtNumParcelas.Height := 21;
  FedtNumParcelas.Alignment := taRightJustify;
  FedtNumParcelas.MaxLength := 2;
  FedtNumParcelas.CompZeros := False;
  FedtNumParcelas.TipoTexto := ttNumerico;
  FPrimeiroControl := FedtNumParcelas ;

end;

class function TOpcoesBanrisulDebitoCredito1Minuto.fNew: IOpcoesModalidadeDinamica;
begin
  Result := TOpcoesBanrisulDebitoCredito1Minuto.Create ;
end;

function TOpcoesBanrisulDebitoCredito1Minuto.fValidaCamposInformados(
  var AobjControlFoco: TWinControl; var AstrMensagem: String): Boolean;
var
  LintQtdParcelas: integer ;
begin
  Result := False ;

  LintQtdParcelas := StrToIntDef(FedtNumParcelas.Text,0);
  if not fValidaParcelas(LintQtdParcelas) then
  begin
    AstrMensagem := 'Campo "Número de Parc." inválido. Mínimo 2, máximo 99.' ;
    AobjControlFoco := FedtNumParcelas ;
    Exit;
  end;

  Result := True ;
end;

end.
