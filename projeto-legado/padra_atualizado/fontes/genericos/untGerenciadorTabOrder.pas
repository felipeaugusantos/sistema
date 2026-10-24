unit untGerenciadorTabOrder;

interface

uses
  Classes, Controls, Messages, Forms;

type
  { Callback consultado antes de mover o foco. Permite ao form aplicar
    validacao (fValidaCampos) e respeitar flags de controle de navegacao
    (blnMudarFoco do TfrmPai) sem acoplar esta classe a hierarquia de forms. }
  TfunPermiteMudarFoco = function(AobjComponente: TWinControl): Boolean of object;

  { Gerencia a navegacao entre uma lista ordenada de componentes usando duas
    teclas, cada uma interceptada num ponto diferente porque o VCL nao da
    nenhum ponto unico de entrada que sirva pras duas:

    - Enter: intercepta o OnKeyDown de cada componente (pOnKeyDownInterno).
      Sem um botao com Default=True na tela, o Enter chega normalmente no
      OnKeyDown do campo focado.

    - Tab: NUNCA chega no OnKeyDown de um TEdit/TDBEdit comum. O Delphi
      intercepta Tab no nivel do FORM (mensagem CM_DIALOGKEY, dentro de
      TCustomForm.CMDialogKey) e decide a navegacao ali mesmo, usando o
      TabOrder/aninhamento nativo, antes de qualquer OnKeyDown do campo
      rodar. Como os campos desta tela estao aninhados em paineis por
      LINHA (um painel por tipo de campo, com as colunas dentro), nem
      ajustar TabOrder resolveria - a navegacao nativa sempre percorreria
      as colunas de uma linha antes de ir para a proxima linha. A unica
      forma de controlar o Tab e interceptar essa mensagem ANTES do form
      decidir. Isso e feito pendurando o WindowProc do FORM
      (pWindowProcInterno) - um unico objeto interceptado, nao os N campos
      registrados, pra manter o risco contido a essa unica mensagem.

    Nos dois casos, a decisao de mover o foco nasce do proprio evento de
    teclado que esta sendo processado (Key/Shift recebidos pelo OnKeyDown,
    ou GetKeyState consultado de forma sincrona dentro do processamento da
    mensagem CM_DIALOGKEY que representa aquela tecla especificamente - o
    mesmo recurso que TCustomForm.CMDialogKey e TPageControl.CMDialogKey ja
    usam internamente para a mesma decisao). Nunca nasce de um SetFocus
    disparado por logica de negocio em outro momento (ex.: dentro de um
    OnExit) - esse tipo de SetFocus nao corresponde a nenhuma tecla sendo
    processada, entao nao aciona nenhum dos dois caminhos. Isso elimina o
    loop em que o foco era empurrado de volta para frente antes do usuario
    conseguir corrigir o campo.

    Shift+Tab, Ctrl+Tab, Alt+Tab e Shift+Enter nunca sao interceptados -
    seguem o fluxo nativo do Delphi integralmente (TabOrder/aninhamento do
    .dfm para Shift+Tab, troca de aba do PageControl para Ctrl+Tab, troca
    de aplicativo para Alt+Tab). Nao ha navegacao reversa por esta lista:
    pSetFocus recusa mudar o foco enquanto Shift+Tab estao fisicamente
    pressionados (guarda em untFuncoesSimples.pas), entao nao e possivel
    implementar Shift+Tab por coluna atraves do helper de foco obrigatorio
    do projeto.

    No caminho do Enter, quando a tecla NAO e Enter sem modificador, o
    OnKeyDown pre-existente do componente (se houver) e chamado normalmente
    - por exemplo, TfrmPai.pOnKeyDownEdits, que fica atribuido a todo
    TDBEditFocus do form antes desta classe registrar a lista (via
    TfrmPai.FormCreate/pSetaEventos). Quando a tecla E Enter sem
    modificador, esse handler pre-existente NUNCA e chamado: ele dispararia
    seu proprio SelectNext nativo (ordem errada, fora desta lista) e sua
    propria validacao ANTES da decisao desta classe rodar, reabrindo o
    mesmo tipo de corrida que esta classe existe para eliminar. No caminho
    do Tab, a mesma logica vale para o WindowProc original do form: so e
    chamado quando a mensagem nao e "nossa".

    Nao ha wrap-around: avancando a partir do ultimo campo da lista (por
    Tab ou por Enter), dispara evtAoSairDoGrupo (ex.: ir para a proxima
    aba).

    Se funPermiteMudarFoco estiver atribuido e retornar False, o foco nao e
    movido (ex.: validacao falhou) - a tecla e consumida mesmo assim, para
    que nenhuma navegacao nativa mova o foco por cima da validacao.

    O destructor restaura o OnKeyDown de cada componente e o WindowProc do
    form. }
  TGerenciadorTabOrder = class(TObject)
  private type
    TItemTabOrder = record
      objComponente: TWinControl;
      evtOnKeyDown: TKeyEvent;
    end;
  private
    FarrItens: TArray<TItemTabOrder>;
    FfunPermiteMudarFoco: TfunPermiteMudarFoco;
    FevtAoSairDoGrupo: TNotifyEvent;
    FobjForm: TCustomForm;
    FevtWindowProcOriginal: TWndMethod;
    procedure pOnKeyDownInterno(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure pWindowProcInterno(var AMessage: TMessage);
    procedure pAvancar(AobjAtual: TWinControl);
    function fIndiceDo(AobjComp: TWinControl): Integer;
    function fProximoVisivel(AintIndiceAtual: Integer): TWinControl;
  public
    class function fSemModificador: Boolean;
    procedure pRegistrar(const AarrComponentes: array of TWinControl);
    destructor Destroy; override;
    property funPermiteMudarFoco: TfunPermiteMudarFoco read FfunPermiteMudarFoco write FfunPermiteMudarFoco;
    property evtAoSairDoGrupo: TNotifyEvent read FevtAoSairDoGrupo write FevtAoSairDoGrupo;
  end;

implementation

uses
  Windows, untFuncoesSimples;

type
  { Expoe o OnKeyDown (protected em TWinControl) ao codigo desta unit.
    WindowProc, ao contrario, e public em TControl - nao precisa de
    widening. }
  TWinControlAcesso = class(TWinControl);

{ TGerenciadorTabOrder }

{ Verdadeiro quando nenhum modificador (Shift/Ctrl/Alt) esta pressionado no
  instante da chamada. GetKeyState aqui e o mesmo recurso que
  TCustomForm.CMDialogKey e TPageControl.CMDialogKey ja usam internamente
  para decidir a mesma coisa - a chamada acontece de forma sincrona dentro
  do processamento da propria mensagem que representa a tecla, entao
  reflete o estado real daquela tecla especifica, nao um estado
  desatualizado de uma mensagem nao relacionada (era esse o problema da
  versao anterior desta classe, que consultava GetKeyState de dentro de um
  OnExit que podia disparar por outros motivos). }
class function TGerenciadorTabOrder.fSemModificador: Boolean;
begin
  Result := (GetKeyState(VK_SHIFT) >= 0)
        and (GetKeyState(VK_CONTROL) >= 0)
        and (GetKeyState(VK_MENU) >= 0);
end;

procedure TGerenciadorTabOrder.pRegistrar(const AarrComponentes: array of TWinControl);
var
  intI: Integer;
begin
  SetLength(FarrItens, Length(AarrComponentes));
  for intI := 0 to High(AarrComponentes) do
  begin
    FarrItens[intI].objComponente := AarrComponentes[intI];
    FarrItens[intI].evtOnKeyDown  := TWinControlAcesso(AarrComponentes[intI]).OnKeyDown;
    TWinControlAcesso(AarrComponentes[intI]).OnKeyDown := pOnKeyDownInterno;
  end;

  if Length(AarrComponentes) > 0 then
  begin
    FobjForm := GetParentForm(AarrComponentes[0]);
    if Assigned(FobjForm) then
    begin
      FevtWindowProcOriginal := FobjForm.WindowProc;
      FobjForm.WindowProc := pWindowProcInterno;
    end;
  end;
end;

function TGerenciadorTabOrder.fIndiceDo(AobjComp: TWinControl): Integer;
var
  intI: Integer;
begin
  Result := -1;
  for intI := 0 to High(FarrItens) do
    if FarrItens[intI].objComponente = AobjComp then
    begin
      Result := intI;
      Break;
    end;
end;

{ Retorna o proximo componente focavel APOS o indice atual, sem
  wrap-around. CanFocus sobe a cadeia de pais validando Visible e Enabled
  de cada um - campo com Visible = True dentro de container
  oculto/desabilitado e corretamente descartado. Sem proximo componente
  disponivel, retorna nil. }
function TGerenciadorTabOrder.fProximoVisivel(AintIndiceAtual: Integer): TWinControl;
var
  intI: Integer;
begin
  Result := nil;
  for intI := AintIndiceAtual + 1 to High(FarrItens) do
    if FarrItens[intI].objComponente.CanFocus then
    begin
      Result := FarrItens[intI].objComponente;
      Break;
    end;
end;

{ Logica compartilhada pelos dois caminhos (Tab via CM_DIALOGKEY, Enter via
  OnKeyDown), chamada depois que o respectivo chamador ja confirmou que
  AobjAtual esta registrado e que a tecla deve navegar: valida via
  funPermiteMudarFoco e move o foco para o proximo componente focavel da
  lista, ou dispara evtAoSairDoGrupo se AobjAtual for o ultimo. }
procedure TGerenciadorTabOrder.pAvancar(AobjAtual: TWinControl);
var
  intIndice: Integer;
  objProximo: TWinControl;
begin
  intIndice := fIndiceDo(AobjAtual);
  if intIndice < 0 then
    Exit;

  if Assigned(FfunPermiteMudarFoco) and (not FfunPermiteMudarFoco(AobjAtual)) then
    Exit;

  objProximo := fProximoVisivel(intIndice);
  if Assigned(objProximo) then
    pSetFocus(objProximo)
  else if Assigned(FevtAoSairDoGrupo) then
    FevtAoSairDoGrupo(AobjAtual);
end;

procedure TGerenciadorTabOrder.pOnKeyDownInterno(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  intIndice: Integer;
begin
  intIndice := fIndiceDo(TWinControl(Sender));
  if intIndice < 0 then
    Exit;

  if (Key <> VK_RETURN) or (Shift <> []) then
  begin
    if Assigned(FarrItens[intIndice].evtOnKeyDown) then
      FarrItens[intIndice].evtOnKeyDown(Sender, Key, Shift);
    Exit;
  end;

  Key := 0;
  pAvancar(TWinControl(Sender));
end;

{ CM_DIALOGKEY e o unico ponto em que o VCL decide a navegacao nativa do
  Tab num TEdit/TDBEdit comum - ver comentario da classe. So intercepta
  quando o campo ativo do form esta registrado nesta lista e nenhum
  modificador esta pressionado; qualquer outro caso (outro campo com foco,
  Shift/Ctrl/Alt+Tab, qualquer outra mensagem) passa direto pro WindowProc
  original do form, sem alteracao. }
procedure TGerenciadorTabOrder.pWindowProcInterno(var AMessage: TMessage);
var
  objAtivo: TWinControl;
begin
  if (AMessage.Msg = CM_DIALOGKEY) and (TWMKey(AMessage).CharCode = VK_TAB)
  and fSemModificador and Assigned(FobjForm) and Assigned(FobjForm.ActiveControl)
  and (fIndiceDo(FobjForm.ActiveControl) >= 0) then
  begin
    objAtivo := FobjForm.ActiveControl;
    AMessage.Result := 1;
    pAvancar(objAtivo);
    Exit;
  end;

  if Assigned(FevtWindowProcOriginal) then
    FevtWindowProcOriginal(AMessage);
end;

destructor TGerenciadorTabOrder.Destroy;
var
  intI: Integer;
begin
  for intI := 0 to High(FarrItens) do
    TWinControlAcesso(FarrItens[intI].objComponente).OnKeyDown := FarrItens[intI].evtOnKeyDown;
  if Assigned(FobjForm) then
    FobjForm.WindowProc := FevtWindowProcOriginal;
  inherited;
end;

end.
