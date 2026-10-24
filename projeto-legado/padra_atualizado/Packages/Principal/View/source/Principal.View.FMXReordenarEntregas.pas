unit Principal.View.FMXReordenarEntregas;

{ Reordenacao manual das entregas de um romaneio, aberta pelo Painel de Entregas.

  A tela nao acessa banco: recebe o romaneio com os documentos ja carregados e
  devolve a nova ordem. Quem aplica (AlteraOrdemEntrega + AtualizaRota) e o
  painel. }

interface

uses
  System.SysUtils, System.StrUtils, System.Math, System.Types, System.UITypes, System.Classes,
  System.Generics.Collections, System.Generics.Defaults,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListBox,
  TaEntregue.Romaneios.Interfaces;

type
  TMudancaOrdem = record
    AutoIncrem   : String;
    OrdemAnterior: String;
    OrdemNova    : String;
  end;

  TLinhaEntrega = record
    Item          : TListBoxItem;
    recCartao     : TRectangle;
    IndiceDocumento: Integer;
    OrdemOriginal : Integer;
    OrdemNova     : Integer;
    lblPosicao    : TLabel;
    lblMudanca    : TLabel;
    btnSubir      : TSpeedButton;
    btnDescer     : TSpeedButton;
  end;

  TfmxReordenarEntregas = class(TForm)
    recFundoBranco: TRectangle;
    lblTitulo: TLabel;
    lblSubtitulo: TLabel;
    layRodape: TLayout;
    layBotoes: TLayout;
    btnRestaurar: TSpeedButton;
    btnCancelar: TSpeedButton;
    btnConfirmar: TSpeedButton;
    recFundoCinza: TRectangle;
    lstEntregas: TListBox;
    lblCabecalhoLivres: TLabel;
    Line1: TLine;
    Line2: TLine;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnRestaurarClick(Sender: TObject);
  private
    FRomaneio        : IRomaneio;
    FLinhas          : TArray<TLinhaEntrega>;
    FSlotsLivres     : TArray<Integer>;
    FPrimeiroLivre   : Integer;
    FMudancas        : TArray<TMudancaOrdem>;
    FBarraRolagem    : TRectangle;
    FTmrBarraRolagem : TTimer;
    FArrastandoBarra : Boolean;
    FPegaBarra       : Single;

    procedure MontarLista;
    procedure AdicionarCabecalho(const ATexto: String);
    procedure AdicionarLinha(const AIndiceDocumento: Integer; const ATravada: Boolean);
    function CriarLabel(const AParent: TFmxObject; const AAlign: TAlignLayout;
      const ALargura: Single; const ATexto: String): TLabel;
    function CriarBotaoSeta(const AParent: TFmxObject; const ATexto: String;
      const ATag: Integer; const AOnClick: TNotifyEvent): TSpeedButton;
    procedure Renumerar;
    procedure MoverPara(const AItem: TListBoxItem; const ANovoIndice: Integer);
    procedure btnSubirClick(Sender: TObject);
    procedure btnDescerClick(Sender: TObject);
    procedure lstEntregasDragChange(SourceItem, DestItem: TListBoxItem; var Allow: Boolean);
    procedure lstEntregasChange(Sender: TObject);
    procedure lstEntregasApplyStyleLookup(Sender: TObject);
    procedure AtualizarDestaque;
    procedure CriarBarraRolagem;
    procedure AtualizarBarraRolagem;
    procedure AgendarBarraRolagem;
    procedure tmrBarraRolagemTimer(Sender: TObject);
    procedure CartaoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure DefinirHitTestCartoes(const AAtivo: Boolean);
    procedure lstEntregasViewportPositionChange(Sender: TObject;
      const OldViewportPosition, NewViewportPosition: TPointF;
      const ContentSizeChanged: Boolean);
    procedure lstEntregasResize(Sender: TObject);
    procedure BarraMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure BarraMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure BarraMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure BarraMouseEnter(Sender: TObject);
    procedure BarraMouseLeave(Sender: TObject);
    function CriarCartao(const AItem: TListBoxItem): TRectangle;
    function ItemLivre(const AItem: TListBoxItem): Boolean;
    function Alterou: Boolean;
    function DescricaoCliente(const ADocumento: IDocumento): String;
    procedure FecharCom(const AResultado: TModalResult);

    class function OrdemDoDocumento(const ADocumento: IDocumento): Integer; static;
    class function SituacaoTravada(const ADocumento: IDocumento): String; static;
  public
    RunningInTSPlus: Boolean;

    class function EntregaLivre(const ADocumento: IDocumento): Boolean; static;
    { AMotivo vem preenchido quando o retorno e False. }
    class function PodeReordenar(const ARomaneio: IRomaneio; out AMotivo: String): Boolean; static;
    { Aplica em memoria (AlteraOrdemEntrega) sobre os documentos ja recarregados.
      False, sem alterar nada, se alguma entrega movida deixou de estar livre ou
      mudou de numero desde que a tela foi aberta. }
    class function AplicarMudancas(const ARomaneio: IRomaneio;
      const AMudancas: TArray<TMudancaOrdem>): Boolean; static;

    property Romaneio: IRomaneio read FRomaneio write FRomaneio;
    { So as entregas que mudaram de numero; valido apenas com ModalResult = mrOk. }
    property Mudancas: TArray<TMudancaOrdem> read FMudancas;
  end;

var
  fmxReordenarEntregas: TfmxReordenarEntregas;

implementation

{$R *.fmx}

const
  { Mesma altura e fonte da linha da grade de documentos do painel
    (TframeGridDocumentosLinha), para as duas telas se lerem igual. }
  ALTURA_LINHA     = 40;
  ALTURA_CABECALHO = 30;
  TAMANHO_FONTE    = 11;
  { Menor que o resto da linha para caber em duas linhas no cartao de 35. }
  TAMANHO_FONTE_CLIENTE = 10;

  COR_DESTAQUE     = $FF3D8BD8;

  LARGURA_BARRA       = 6;
  ALTURA_MINIMA_BARRA = 30;
  { Sobre o fundo #E8E8E8, abaixo de ~0.5 o cinza praticamente some. }
  OPACIDADE_BARRA       = 0.6;
  OPACIDADE_BARRA_ATIVA = 0.85;

  CHAR_ALCA    = #$2261;
  CHAR_SUBIR   = #$25B2;
  CHAR_DESCER  = #$25BC;
  CHAR_SETA    = #$2192;

{ Uma entrega so pode mudar de lugar enquanto o motorista nao chegou nela.
  Iniciada, baixada ou com ocorrencia de nao entrega fica onde esta: a de
  andamento porque o motorista ja esta indo para ela, as demais porque ja
  aconteceram. }
class function TfmxReordenarEntregas.EntregaLivre(const ADocumento: IDocumento): Boolean;
begin
  Result := ADocumento.DocumentoDeEntrega and
            (ADocumento.StatusDocumento = rmNaoIniciado);
end;

class function TfmxReordenarEntregas.PodeReordenar(const ARomaneio: IRomaneio;
  out AMotivo: String): Boolean;
Var
  LDocumento: IDocumento;
  LQtdLivres: Integer;
begin
  AMotivo := '';

  If ARomaneio.Cancelado Then
  Begin
    AMotivo := 'Este romaneio est'#225' cancelado.';
    Exit(False);
  End;

  LQtdLivres := 0;
  For LDocumento in ARomaneio.Documentos do
    If EntregaLivre(LDocumento) Then
      Inc(LQtdLivres);

  If (LQtdLivres < 2) Then
  Begin
    AMotivo := 'Para reordenar, o romaneio precisa ter ao menos duas entregas '+
               'ainda n'#227'o iniciadas.';
    Exit(False);
  End;

  Result := True;
end;

{ A tela abre sobre os documentos que o painel ja tinha em memoria, sem ir ao
  banco, entao eles podem estar velhos. A conferencia e feita aqui, ja sobre a
  lista recarregada, e por AUTOINCREM: depois de CarregaDocumentos o indice nao
  identifica mais o documento. }
class function TfmxReordenarEntregas.AplicarMudancas(const ARomaneio: IRomaneio;
  const AMudancas: TArray<TMudancaOrdem>): Boolean;
Var
  LDocumentos: TDictionary<String, IDocumento>;
  LDocumento : IDocumento;
  LMudanca   : TMudancaOrdem;
begin
  Result := False;

  If (Length(AMudancas) = 0) Then
    Exit;

  LDocumentos := TDictionary<String, IDocumento>.Create;
  Try
    For LDocumento in ARomaneio.Documentos do
      LDocumentos.AddOrSetValue(LDocumento.AutoIncrem, LDocumento);

    For LMudanca in AMudancas do
    Begin
      If (Not LDocumentos.TryGetValue(LMudanca.AutoIncrem, LDocumento)) Then
        Exit;

      If (Not EntregaLivre(LDocumento)) or (LDocumento.RotaOrdem <> LMudanca.OrdemAnterior) Then
        Exit;
    End;

    For LMudanca in AMudancas do
      LDocumentos[LMudanca.AutoIncrem].AlteraOrdemEntrega(LMudanca.OrdemNova);
  Finally
    FreeAndNil(LDocumentos);
  End;

  Result := True;
end;

class function TfmxReordenarEntregas.OrdemDoDocumento(const ADocumento: IDocumento): Integer;
begin
  Result := StrToIntDef(ADocumento.RotaOrdem, 0);
end;

class function TfmxReordenarEntregas.SituacaoTravada(const ADocumento: IDocumento): String;
begin
  Case ADocumento.StatusDocumento of
    rmACaminho   : Result := 'EM ANDAMENTO';
    rmFinalizado : Result := 'CONCLU'#205'DA';
    rmNaoEntregue: Result := 'N'#195'O ENTREGUE';
  Else
    Result := '';
  End;
end;

procedure TfmxReordenarEntregas.FormCreate(Sender: TObject);
begin
  lstEntregas.AllowDrag          := True;
  lstEntregas.OnDragChange       := lstEntregasDragChange;
  lstEntregas.OnChange           := lstEntregasChange;
  lstEntregas.OnApplyStyleLookup := lstEntregasApplyStyleLookup;

  CriarBarraRolagem;
end;

{ Barra de rolagem minimalista: so o indicador que se arrasta, sem trilho nem
  setas. A nativa e escondida (a roda do mouse continua rolando, ela nao depende
  da barra). O indicador fica na sobra a direita da lista, entao nao cobre os
  cartoes. }
procedure TfmxReordenarEntregas.CriarBarraRolagem;
begin
  lstEntregas.ShowScrollBars          := False;
  lstEntregas.OnViewportPositionChange := lstEntregasViewportPositionChange;
  lstEntregas.OnResize                := lstEntregasResize;

  FBarraRolagem := TRectangle.Create(Self);
  FBarraRolagem.Parent       := recFundoCinza;
  FBarraRolagem.Width        := LARGURA_BARRA;
  FBarraRolagem.XRadius      := LARGURA_BARRA / 2;
  FBarraRolagem.YRadius      := LARGURA_BARRA / 2;
  FBarraRolagem.Fill.Color   := TAlphaColors.Gray;
  FBarraRolagem.Stroke.Kind  := TBrushKind.None;
  FBarraRolagem.Opacity      := OPACIDADE_BARRA;
  FBarraRolagem.AutoCapture  := True;
  FBarraRolagem.Visible      := False;
  FBarraRolagem.OnMouseDown  := BarraMouseDown;
  FBarraRolagem.OnMouseMove  := BarraMouseMove;
  FBarraRolagem.OnMouseUp    := BarraMouseUp;
  FBarraRolagem.OnMouseEnter := BarraMouseEnter;
  FBarraRolagem.OnMouseLeave := BarraMouseLeave;

  FTmrBarraRolagem := TTimer.Create(Self);
  FTmrBarraRolagem.Enabled  := False;
  FTmrBarraRolagem.Interval := 30;
  FTmrBarraRolagem.OnTimer  := tmrBarraRolagemTimer;
end;

{ A lista so aplica o estilo e calcula o tamanho do conteudo na primeira
  pintura, e o aviso de conteudo alterado chega no meio dela: mexer na barra ali
  nao redesenha a tela ate o proximo evento (a barra so aparecia ao rolar). Por
  isso a atualizacao por mudanca de tamanho e adiada para fora da pintura. }
procedure TfmxReordenarEntregas.AgendarBarraRolagem;
begin
  If (Not Assigned(FTmrBarraRolagem)) Then
    Exit;

  FTmrBarraRolagem.Enabled := False;
  FTmrBarraRolagem.Enabled := True;
end;

procedure TfmxReordenarEntregas.tmrBarraRolagemTimer(Sender: TObject);
begin
  FTmrBarraRolagem.Enabled := False;
  AtualizarBarraRolagem;
end;

procedure TfmxReordenarEntregas.AtualizarBarraRolagem;
Var
  LAlturaVisivel : Single;
  LAlturaConteudo: Single;
  LRolagemMaxima : Single;
  LAlturaBarra   : Single;
begin
  If (Not Assigned(FBarraRolagem)) Then
    Exit;

  LAlturaVisivel  := lstEntregas.Height;
  LAlturaConteudo := lstEntregas.ContentBounds.Height;
  LRolagemMaxima  := LAlturaConteudo - LAlturaVisivel;

  FBarraRolagem.Visible := (LRolagemMaxima > 1);
  If (Not FBarraRolagem.Visible) Then
    Exit;

  LAlturaBarra := Max(ALTURA_MINIMA_BARRA, LAlturaVisivel * LAlturaVisivel / LAlturaConteudo);

  FBarraRolagem.Height     := LAlturaBarra;
  FBarraRolagem.Position.X := lstEntregas.Position.X + lstEntregas.Width +
                              (lstEntregas.Margins.Right - LARGURA_BARRA) / 2;
  FBarraRolagem.Position.Y := lstEntregas.Position.Y + (LAlturaVisivel - LAlturaBarra) *
                              EnsureRange(lstEntregas.ViewportPosition.Y / LRolagemMaxima, 0, 1);
  FBarraRolagem.BringToFront;
end;

procedure TfmxReordenarEntregas.lstEntregasViewportPositionChange(Sender: TObject;
  const OldViewportPosition, NewViewportPosition: TPointF;
  const ContentSizeChanged: Boolean);
begin
  If ContentSizeChanged Then
    AgendarBarraRolagem
  Else
    AtualizarBarraRolagem;
end;

procedure TfmxReordenarEntregas.lstEntregasResize(Sender: TObject);
begin
  AgendarBarraRolagem;
end;

procedure TfmxReordenarEntregas.BarraMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  If (Button <> TMouseButton.mbLeft) Then
    Exit;

  FArrastandoBarra := True;
  FPegaBarra       := Y;
end;

procedure TfmxReordenarEntregas.BarraMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Single);
Var
  LTopo         : Single;
  LCurso        : Single;
  LRolagemMaxima: Single;
begin
  If (Not FArrastandoBarra) Then
    Exit;

  LCurso         := lstEntregas.Height - FBarraRolagem.Height;
  LRolagemMaxima := lstEntregas.ContentBounds.Height - lstEntregas.Height;
  If (LCurso <= 0) or (LRolagemMaxima <= 0) Then
    Exit;

  { Y vem nas coordenadas da propria barra, que anda junto com o arrasto: somar
    a posicao dela da o ponteiro no pai, e descontar onde ela foi pega evita o
    salto no primeiro movimento. }
  LTopo := FBarraRolagem.Position.Y + Y - FPegaBarra - lstEntregas.Position.Y;
  LTopo := EnsureRange(LTopo, 0, LCurso);

  lstEntregas.ViewportPosition := TPointF.Create(0, LTopo / LCurso * LRolagemMaxima);
end;

procedure TfmxReordenarEntregas.BarraMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  FArrastandoBarra := False;

  If (Not FBarraRolagem.IsMouseOver) Then
    FBarraRolagem.Opacity := OPACIDADE_BARRA;
end;

procedure TfmxReordenarEntregas.BarraMouseEnter(Sender: TObject);
begin
  FBarraRolagem.Opacity := OPACIDADE_BARRA_ATIVA;
end;

procedure TfmxReordenarEntregas.BarraMouseLeave(Sender: TObject);
begin
  If (Not FArrastandoBarra) Then
    FBarraRolagem.Opacity := OPACIDADE_BARRA;
end;

{ O destaque de selecao do estilo e desenhado atras dos itens e apareceria so
  na sobra das margens do cartao. Ele e apagado e a selecao passa a ser a borda
  do proprio cartao (AtualizarDestaque). }
procedure TfmxReordenarEntregas.lstEntregasApplyStyleLookup(Sender: TObject);
Var
  LSelecao: TFmxObject;
begin
  LSelecao := lstEntregas.FindStyleResource('selection');
  If (LSelecao is TControl) Then
    TControl(LSelecao).Opacity := 0;

  LSelecao := lstEntregas.FindStyleResource('focusedselection');
  If (LSelecao is TControl) Then
    TControl(LSelecao).Opacity := 0;
end;

procedure TfmxReordenarEntregas.lstEntregasChange(Sender: TObject);
begin
  AtualizarDestaque;
end;

procedure TfmxReordenarEntregas.AtualizarDestaque;
Var
  LLinha: TLinhaEntrega;
begin
  For LLinha in FLinhas do
    If (LLinha.Item.IsSelected) Then
      LLinha.recCartao.Stroke.Kind := TBrushKind.Solid
    Else
      LLinha.recCartao.Stroke.Kind := TBrushKind.None;
end;

procedure TfmxReordenarEntregas.FormShow(Sender: TObject);
begin
  lblTitulo.Text := 'REORDENAR ENTREGAS - ROMANEIO ' + FRomaneio.NumeroRomaneio;
  MontarLista;
end;

function TfmxReordenarEntregas.DescricaoCliente(const ADocumento: IDocumento): String;
Var
  LNome: String;
begin
  LNome := ADocumento.Cliente.NomeCliente;

  Result := Format('%s  (%s - %s/%s)', [LNome,
                                        ADocumento.EnderecoEntrega.Bairro,
                                        ADocumento.EnderecoEntrega.Cidade,
                                        ADocumento.EnderecoEntrega.Uf]);
end;

{ Travadas no topo e livres embaixo, cada grupo na ordem de hoje. Documento que
  nao e de entrega nao aparece: AtualizaRota tambem o ignora. }
procedure TfmxReordenarEntregas.MontarLista;
Var
  LDocumentos: TList<IDocumento>;
  LTravadas  : TList<Integer>;
  LLivres    : TList<Integer>;
  LComparador: IComparer<Integer>;
  LIndice    : Integer;
begin
  LDocumentos := FRomaneio.Documentos;

  LComparador := TComparer<Integer>.Construct(
    function(const A, B: Integer): Integer
    begin
      Result := OrdemDoDocumento(LDocumentos[A]) - OrdemDoDocumento(LDocumentos[B]);
      If (Result = 0) Then
        Result := A - B;
    end);

  LTravadas := TList<Integer>.Create;
  LLivres   := TList<Integer>.Create;
  lstEntregas.BeginUpdate;
  Try
    lstEntregas.Clear;
    SetLength(FLinhas, 0);

    For LIndice := 0 to LDocumentos.Count - 1 do
    Begin
      If (Not LDocumentos[LIndice].DocumentoDeEntrega) Then
        Continue;

      If EntregaLivre(LDocumentos[LIndice]) Then
        LLivres.Add(LIndice)
      Else
        LTravadas.Add(LIndice);
    End;

    LTravadas.Sort(LComparador);
    LLivres.Sort(LComparador);

    If (LTravadas.Count > 0) Then
    Begin
      AdicionarCabecalho('CONCLU'#205'DAS OU EM ANDAMENTO - N'#195'O PODEM SER MOVIDAS');
      For LIndice in LTravadas do
        AdicionarLinha(LIndice, True);
    End;

    { O cabecalho das livres fica fora da lista (lblCabecalhoLivres), para nao
      sumir quando a lista rola. }
    FPrimeiroLivre := lstEntregas.Count;

    { Os numeros que as livres ocupam hoje sao os unicos que elas podem trocar
      entre si; a travada mantem o seu. E o que TRomaneio.AtualizaRota grava
      (fSubstituiOrdImp), entao o numero exibido e o numero que vai para o banco. }
    SetLength(FSlotsLivres, LLivres.Count);
    For LIndice := 0 to LLivres.Count - 1 do
    Begin
      FSlotsLivres[LIndice] := OrdemDoDocumento(LDocumentos[LLivres[LIndice]]);
      AdicionarLinha(LLivres[LIndice], False);
    End;
  Finally
    lstEntregas.EndUpdate;
    FreeAndNil(LTravadas);
    FreeAndNil(LLivres);
  End;

  Renumerar;
  AtualizarDestaque;
  AgendarBarraRolagem;
end;

{ Item comum e nao TListBoxGroupHeader: o estilo do cabecalho de grupo desenha
  uma faixa cinza que destoa da lista transparente. Aqui ele imita o titulo de
  coluna da grade de documentos. }
procedure TfmxReordenarEntregas.AdicionarCabecalho(const ATexto: String);
Var
  LCabecalho: TListBoxItem;
  LLabel    : TLabel;
begin
  LCabecalho := TListBoxItem.Create(lstEntregas);
  LCabecalho.Parent     := lstEntregas;
  LCabecalho.Height     := ALTURA_CABECALHO;
  LCabecalho.Text       := '';
  LCabecalho.Selectable := False;
  LCabecalho.Tag        := -1;

  LLabel := CriarLabel(LCabecalho, TAlignLayout.Client, 0, ATexto);
  LLabel.Margins.Left := 10;
  LLabel.Margins.Top  := 6;
  LLabel.Opacity      := 0.6;
  LLabel.StyledSettings := LLabel.StyledSettings - [TStyledSetting.Style];
  LLabel.TextSettings.Font.Style := [TFontStyle.fsBold];
end;

{ Fundo branco com sombra, como recFundoBranco da linha de documentos. A sombra
  e um retangulo deslocado, e nao TShadowEffect: o efeito renderiza um bitmap
  por linha e pesa quando a lista cresce. }
function TfmxReordenarEntregas.CriarCartao(const AItem: TListBoxItem): TRectangle;
Var
  LSombra: TRectangle;
begin
  LSombra := TRectangle.Create(AItem);
  LSombra.Parent         := AItem;
  LSombra.Align          := TAlignLayout.Client;
  LSombra.Margins.Left   := 5;
  LSombra.Margins.Top    := 7;
  LSombra.Margins.Right  := 5;
  LSombra.Margins.Bottom := -2;
  LSombra.XRadius        := 6;
  LSombra.YRadius        := 6;
  LSombra.Fill.Color     := TAlphaColors.Black;
  LSombra.Opacity        := 0.08;
  LSombra.Stroke.Kind    := TBrushKind.None;
  LSombra.HitTest        := False;

  Result := TRectangle.Create(AItem);
  Result.Parent          := AItem;
  Result.Align           := TAlignLayout.Client;
  Result.Margins.Left    := 5;
  Result.Margins.Top     := 5;
  Result.Margins.Right   := 5;
  Result.XRadius         := 6;
  Result.YRadius         := 6;
  Result.Fill.Color      := TAlphaColors.White;
  Result.Stroke.Kind     := TBrushKind.None;
  Result.Stroke.Color    := COR_DESTAQUE;
  Result.Stroke.Thickness:= 1.5;
  Result.HitTest         := False;
end;

function TfmxReordenarEntregas.CriarLabel(const AParent: TFmxObject;
  const AAlign: TAlignLayout; const ALargura: Single; const ATexto: String): TLabel;
begin
  Result := TLabel.Create(AParent);
  Result.Parent  := AParent;
  Result.Align   := AAlign;
  Result.Margins.Left := 6;
  If (ALargura > 0) Then
    Result.Width := ALargura;
  Result.StyledSettings := [TStyledSetting.Family, TStyledSetting.FontColor];
  Result.TextSettings.Font.Size := TAMANHO_FONTE;
  Result.TextSettings.WordWrap := False;
  Result.Text    := ATexto;
end;

function TfmxReordenarEntregas.CriarBotaoSeta(const AParent: TFmxObject;
  const ATexto: String; const ATag: Integer; const AOnClick: TNotifyEvent): TSpeedButton;
begin
  Result := TSpeedButton.Create(AParent);
  Result.Parent  := AParent;
  Result.Width   := 26;
  Result.Margins.Top    := 5;
  Result.Margins.Bottom := 5;
  Result.Text    := ATexto;
  Result.Tag     := ATag;
  Result.OnClick := AOnClick;
end;

procedure TfmxReordenarEntregas.AdicionarLinha(const AIndiceDocumento: Integer;
  const ATravada: Boolean);
Var
  LDocumento: IDocumento;
  LLinha    : TLinhaEntrega;
  LIndice   : Integer;
  LLabel    : TLabel;
  LDireita  : TLayout;
  LBotoes   : TLayout;
begin
  LDocumento := FRomaneio.Documentos[AIndiceDocumento];
  LIndice    := Length(FLinhas);

  LLinha.IndiceDocumento := AIndiceDocumento;
  LLinha.OrdemOriginal   := OrdemDoDocumento(LDocumento);
  LLinha.OrdemNova       := LLinha.OrdemOriginal;
  LLinha.btnSubir        := nil;
  LLinha.btnDescer       := nil;

  LLinha.Item := TListBoxItem.Create(lstEntregas);
  LLinha.Item.Parent := lstEntregas;
  LLinha.Item.Height := ALTURA_LINHA;
  LLinha.Item.Text   := '';
  LLinha.Item.Tag    := LIndice;

  If ATravada Then
  Begin
    LLinha.Item.Selectable := False;
    LLinha.Item.Opacity    := 0.5;
  End;

  LLinha.recCartao := CriarCartao(LLinha.Item);
  If (Not ATravada) Then
  Begin
    LLinha.recCartao.HitTest     := True;
    LLinha.recCartao.Tag         := LIndice;
    LLinha.recCartao.OnMouseDown := CartaoMouseDown;
  End;

  LLabel := CriarLabel(LLinha.recCartao, TAlignLayout.Left, 18, IfThen(ATravada, '', CHAR_ALCA));
  LLabel.TextSettings.HorzAlign := TTextAlign.Center;

  LLinha.lblPosicao := CriarLabel(LLinha.recCartao, TAlignLayout.Left, 24, IntToStr(LLinha.OrdemOriginal));
  LLinha.lblPosicao.StyledSettings := LLinha.lblPosicao.StyledSettings - [TStyledSetting.Style];
  LLinha.lblPosicao.TextSettings.Font.Style := [TFontStyle.fsBold];

  LLabel := CriarLabel(LLinha.recCartao, TAlignLayout.Left, 110,
                       Format('%s-%s-%s', [LDocumento.NumeroDocumento,
                                           LDocumento.EspecieDocumento,
                                           LDocumento.Empresa.CodigoEmpresa]));
  LLabel.TextSettings.Font.Size := TAMANHO_FONTE_CLIENTE;
  LLabel.Margins.Left := 2;

  { Lado direito num layout proprio: com varios Align = Right no mesmo pai a
    posicao depende da ordem de criacao, e as setas tem que ficar coladas na
    borda. Dentro dele so ha um Right (setas) e um Client (situacao/mudanca). }
  LDireita := TLayout.Create(LLinha.recCartao);
  LDireita.Parent := LLinha.recCartao;
  LDireita.Align  := TAlignLayout.Right;
  LDireita.Width  := IfThen(ATravada, 100, 125);

  If (Not ATravada) Then
  Begin
    LBotoes := TLayout.Create(LDireita);
    LBotoes.Parent        := LDireita;
    LBotoes.Align         := TAlignLayout.Right;
    LBotoes.Width         := 55;
    LBotoes.Margins.Right := 3;

    LLinha.btnSubir  := CriarBotaoSeta(LBotoes, CHAR_SUBIR,  LIndice, btnSubirClick);
    LLinha.btnSubir.Align := TAlignLayout.Left;
    LLinha.btnDescer := CriarBotaoSeta(LBotoes, CHAR_DESCER, LIndice, btnDescerClick);
    LLinha.btnDescer.Align := TAlignLayout.Right;
  End;

  LLinha.lblMudanca := CriarLabel(LDireita, TAlignLayout.Client, 0,
                                  IfThen(ATravada, SituacaoTravada(LDocumento), ''));
  LLinha.lblMudanca.TextSettings.HorzAlign := TTextAlign.Trailing;
  LLinha.lblMudanca.StyledSettings := LLinha.lblMudanca.StyledSettings - [TStyledSetting.Style];
  LLinha.lblMudanca.TextSettings.Font.Style := [TFontStyle.fsBold];
  LLinha.lblMudanca.Margins.Right := 6;

  LLabel := CriarLabel(LLinha.recCartao, TAlignLayout.Client, 0, DescricaoCliente(LDocumento));
  LLabel.TextSettings.Font.Size := TAMANHO_FONTE_CLIENTE;
  LLabel.TextSettings.WordWrap  := True;
  LLabel.TextSettings.Trimming  := TTextTrimming.Character;
  LLabel.TextSettings.VertAlign := TTextAlign.Center;
  LLabel.Margins.Top    := 1;
  LLabel.Margins.Bottom := 1;

  SetLength(FLinhas, LIndice + 1);
  FLinhas[LIndice] := LLinha;
end;

{ O TListBox so comeca a arrastar um item que ja estava selecionado antes do
  clique (TCustomListBox.MouseDown guarda o ItemIndex antes de selecionar), o
  que obrigava a dois cliques. O cartao das livres recebe o clique e faz o mesmo
  que TCustomListBox.PerformInternalDrag, sem essa exigencia; o drop continua
  na lista e cai em lstEntregasDragChange. }
procedure TfmxReordenarEntregas.CartaoMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
Var
  LItem  : TListBoxItem;
  LImagem: TBitmap;
begin
  If (Button <> TMouseButton.mbLeft) Then
    Exit;

  LItem := FLinhas[TRectangle(Sender).Tag].Item;
  If (Not ItemLivre(LItem)) or (Not Assigned(lstEntregas.Root)) Then
    Exit;

  lstEntregas.ItemIndex := LItem.Index;
  AtualizarDestaque;

  { Durante o arrasto o cartao nao pode receber o mouse: o alvo do drop e o
    controle sob o cursor, e tem que ser a lista. O DoDragDrop do Windows e
    sincrono, entao ao retornar o arrasto ja terminou. }
  LImagem := LItem.MakeScreenshot;
  DefinirHitTestCartoes(False);
  Try
    lstEntregas.Root.BeginInternalDrag(LItem, LImagem);
  Finally
    DefinirHitTestCartoes(True);
    FreeAndNil(LImagem);
  End;
end;

procedure TfmxReordenarEntregas.DefinirHitTestCartoes(const AAtivo: Boolean);
Var
  LLinha: TLinhaEntrega;
begin
  For LLinha in FLinhas do
    If ItemLivre(LLinha.Item) Then
      LLinha.recCartao.HitTest := AAtivo;
end;

function TfmxReordenarEntregas.ItemLivre(const AItem: TListBoxItem): Boolean;
begin
  Result := Assigned(AItem) and (AItem.Index >= FPrimeiroLivre);
end;

{ A posicao na lista define o numero: a i-esima livre recebe o i-esimo menor
  numero que as livres ja ocupavam. }
procedure TfmxReordenarEntregas.Renumerar;
Var
  LIndiceLista: Integer;
  LItem       : TListBoxItem;
  LPosicao    : Integer;
begin
  For LIndiceLista := FPrimeiroLivre to lstEntregas.Count - 1 do
  Begin
    LItem    := lstEntregas.ItemByIndex(LIndiceLista);
    LPosicao := LIndiceLista - FPrimeiroLivre;

    With FLinhas[LItem.Tag] do
    Begin
      OrdemNova := FSlotsLivres[LPosicao];

      lblPosicao.Text := IntToStr(OrdemNova);
      If (OrdemNova <> OrdemOriginal) Then
        lblMudanca.Text := Format('%d %s %d', [OrdemOriginal, CHAR_SETA, OrdemNova])
      Else
        lblMudanca.Text := '';

      btnSubir.Enabled  := (LIndiceLista > FPrimeiroLivre);
      btnDescer.Enabled := (LIndiceLista < lstEntregas.Count - 1);
    End;
  End;

  btnConfirmar.Enabled := Alterou;
  btnRestaurar.Enabled := btnConfirmar.Enabled;
end;

procedure TfmxReordenarEntregas.MoverPara(const AItem: TListBoxItem;
  const ANovoIndice: Integer);
begin
  If (Not ItemLivre(AItem)) Then
    Exit;

  If (ANovoIndice < FPrimeiroLivre) or (ANovoIndice > lstEntregas.Count - 1) Then
    Exit;

  AItem.Index := ANovoIndice;
  lstEntregas.ItemIndex := AItem.Index;
  Renumerar;
  AtualizarDestaque;
end;

procedure TfmxReordenarEntregas.btnSubirClick(Sender: TObject);
Var
  LItem: TListBoxItem;
begin
  LItem := FLinhas[TSpeedButton(Sender).Tag].Item;
  MoverPara(LItem, LItem.Index - 1);
end;

procedure TfmxReordenarEntregas.btnDescerClick(Sender: TObject);
Var
  LItem: TListBoxItem;
begin
  LItem := FLinhas[TSpeedButton(Sender).Tag].Item;
  MoverPara(LItem, LItem.Index + 1);
end;

{ O TListBox moveria o item sozinho depois deste evento, mas sem renumerar e sem
  respeitar o bloco das travadas. Por isso a troca e feita aqui e o movimento
  padrao e recusado. }
procedure TfmxReordenarEntregas.lstEntregasDragChange(SourceItem,
  DestItem: TListBoxItem; var Allow: Boolean);
begin
  Allow := False;

  If ItemLivre(SourceItem) and ItemLivre(DestItem) and (SourceItem <> DestItem) Then
    MoverPara(SourceItem, DestItem.Index);
end;

function TfmxReordenarEntregas.Alterou: Boolean;
Var
  LLinha: TLinhaEntrega;
begin
  Result := False;

  For LLinha in FLinhas do
    If (LLinha.OrdemNova <> LLinha.OrdemOriginal) Then
      Exit(True);
end;

procedure TfmxReordenarEntregas.FecharCom(const AResultado: TModalResult);
begin
  Self.Tag := 0;
  Close;
  Self.ModalResult := AResultado;
end;

procedure TfmxReordenarEntregas.btnConfirmarClick(Sender: TObject);
Var
  LLinha  : TLinhaEntrega;
  LMudanca: TMudancaOrdem;
begin
  If (Not Alterou) Then
    Exit;

  SetLength(FMudancas, 0);
  For LLinha in FLinhas do
  Begin
    If (LLinha.OrdemNova = LLinha.OrdemOriginal) Then
      Continue;

    LMudanca.AutoIncrem    := FRomaneio.Documentos[LLinha.IndiceDocumento].AutoIncrem;
    LMudanca.OrdemAnterior := FRomaneio.Documentos[LLinha.IndiceDocumento].RotaOrdem;
    LMudanca.OrdemNova     := IntToStr(LLinha.OrdemNova);

    SetLength(FMudancas, Length(FMudancas) + 1);
    FMudancas[High(FMudancas)] := LMudanca;
  End;

  FecharCom(mrOk);
end;

procedure TfmxReordenarEntregas.btnRestaurarClick(Sender: TObject);
begin
  MontarLista;
end;

procedure TfmxReordenarEntregas.btnCancelarClick(Sender: TObject);
begin
  FecharCom(mrCancel);
end;

{ Ctrl + seta fica no form, e nao na lista: a lista nao recebe foco, como a
  grade de documentos, para nao desenhar o realce de foco do estilo. }
procedure TfmxReordenarEntregas.FormKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
Var
  LItem: TListBoxItem;
begin
  If (Key = vkEscape) Then
  Begin
    Key := 0;
    FecharCom(mrCancel);
    Exit;
  End;

  If (Not (ssCtrl in Shift)) or (Not (Key in [vkUp, vkDown])) Then
    Exit;

  LItem := lstEntregas.Selected;
  If (Not Assigned(LItem)) Then
    Exit;

  If (Key = vkUp) Then
    MoverPara(LItem, LItem.Index - 1)
  Else
    MoverPara(LItem, LItem.Index + 1);

  Key := 0;
end;

end.