unit Reforma.View.Hospedeira;

// Form sem borda, filho do HWND que o host entrega. Existe por causa do foco: um controle da DLL
// sem TForm pai nunca dispara OnEnter/OnExit (o VCL da DLL nao ve nenhum form ao redor), e toda a
// validacao das abas roda em OnExit. O form tambem acompanha o tamanho da aba do host.
//
// Teclado: Tab e Enter dos controles da DLL chegam primeiro ao laco de mensagens do exe, cujo VCL
// so conhece o form do host. Sem tratamento, o Tab navega pelo ActiveControl do host (pula para
// fora da aba) e o Enter nao faz nada. Por isso um gancho WH_GETMESSAGE (ver fGancho) resolve as
// duas teclas aqui dentro, como TfrmPai.pOnKeyDownEdits/pProximoControle fazem no cadastro.
//
// Roda do mouse: o WM_MOUSEWHEEL vai para a janela com foco, que quase sempre e do host (os campos da aba 2 ficam
// desabilitados fora da edicao), e o TScrollBox do Seattle nao rola com a roda. O mesmo gancho rola a caixa da DLL
// que esta debaixo do cursor (fTratarRoda).

interface

uses
  Winapi.Windows, Winapi.Messages, System.Classes, System.SysUtils, Vcl.Controls, Vcl.Forms;

const
  // Postada quando um campo da DLL perde o foco para um controle do host (ver fGanchoFoco).
  WM_REFORMA_CONFIRMAR = WM_USER + 701;

type
  TformHospedeira = class(TForm)
  strict private
    FPaiHandle: NativeUInt;
    // Algum controle da DLL recebeu o foco e ainda nao foi confirmado (OnExit).
    FPendente: Boolean;
    FConfirmando: Boolean;
    FAoConfirmar: TProc;
    procedure pAssinarPai;
    procedure WMReformaConfirmar(var Mensagem: TMessage); message WM_REFORMA_CONFIRMAR;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DoDestroy; override;
  public
    constructor CriarNaJanela(const PaiHandle: NativeUInt);
    // Ajusta o form ao tamanho atual da janela do host.
    procedure AcompanharPai;
    // O VCL da DLL so dispara OnExit ao mover o foco entre controles do proprio form. Quando o foco vai
    // para um controle do host, o gancho de foco (fGanchoFoco) percebe e chama isto; o host tambem chama
    // antes de gravar ou trocar de aba. Sem campo pendente nao faz nada.
    procedure ConfirmarEdicao;
    // Chamados pelo gancho de foco quando um controle deste form ganha ou perde o foco.
    procedure FocoEntrou;
    procedure FocoSaiu(const Novo: HWND);
    // Passa o foco ao proximo (ou anterior) controle na ordem de tab, sem sair do form.
    procedure Avancar(const Origem: TWinControl; const Adiante: Boolean);
    // Roda no fim de ConfirmarEdicao. Celula de grid em edicao nao tem OnExit quando o foco vai para
    // o host: o frame do grid fecha o editor e aplica a edicao por aqui.
    property AoConfirmar: TProc read FAoConfirmar write FAoConfirmar;
  end;

// Solta ganchos e subclasses que ainda existam; sem efeito se ja estiver tudo limpo. Roda no fim de
// pReformaFinalizar e na finalization (DLL descarregada sem Finalizar).
procedure pLiberarGanchos;

implementation

uses
  Vcl.StdCtrls, cxVGrid;

const
  PROP_FORM = 'ReformaHospedeiraForm';
  PROP_PROC = 'ReformaHospedeiraProc';

var
  GGancho: HHOOK;
  GGanchoFoco: HHOOK;
  GFormsAtivos: Integer;
  // Janelas do host subclassificadas por fRespostaPai: a finalization as devolve.
  GPais: array of HWND;

// Atalhos que trocam a aba de precos (Ctrl+1 a Ctrl+4 e Ctrl+PgUp/PgDn). Quem trata e o cadastro (FormShortCut):
// aqui a tecla so precisa seguir para o laco do exe, em vez de ser entregue ao campo.
function fAtalhoAba(const Mensagem: TMsg): Boolean;
begin
  Result := False;
  if (Mensagem.message <> WM_KEYDOWN) and (Mensagem.message <> WM_KEYUP) then
    Exit;
  if (GetKeyState(VK_CONTROL) >= 0) or (GetKeyState(VK_SHIFT) < 0) or (GetKeyState(VK_MENU) < 0) then
    Exit;
  Result := ((Mensagem.wParam >= Ord('1')) and (Mensagem.wParam <= Ord('4'))) or
    (Mensagem.wParam = VK_NEXT) or (Mensagem.wParam = VK_PRIOR);
end;

// O editor aberto numa celula de TcxDBVerticalGrid e um TcxCustomInnerTextEdit, que herda de TCustomEdit:
// sem esta checagem o ramo de Enter de campo solto o trataria como edit comum.
function fDentroDeGrid(Controle: TWinControl): Boolean;
begin
  Result := False;
  while Assigned(Controle) do
  begin
    if Controle is TcxCustomVerticalGrid then
      Exit(True);
    Controle := Controle.Parent;
  end;
end;

// Devolve True quando a tecla foi consumida. So age em controle que pertence a um TformHospedeira.
function fTratarTecla(var Mensagem: TMsg): Boolean;
var
  Controle: TWinControl;
  Formulario: TCustomForm;
begin
  Result := False;
  Controle := FindControl(Mensagem.hwnd);
  if Controle = nil then
    Exit;
  Formulario := GetParentForm(Controle, False);
  if not (Formulario is TformHospedeira) then
    Exit;

  if fAtalhoAba(Mensagem) then
    Exit;

  // Dentro do grid, Enter e Tab sao do proprio grid (proxima linha; na ultima linha editavel, o
  // OnKeyDown do grid passa para o proximo - mesmo fluxo da aba 1). A tecla vai crua para o
  // controle, como o laco do exe entregaria. Ctrl+Tab, Esc e F1..F24 seguem o caminho de sempre.
  if fDentroDeGrid(Controle) and
     ((Mensagem.message = WM_KEYDOWN) or (Mensagem.message = WM_KEYUP) or (Mensagem.message = WM_CHAR)) and
     (Mensagem.wParam <> VK_ESCAPE) and
     not ((Mensagem.message <> WM_CHAR) and (Mensagem.wParam >= VK_F1) and (Mensagem.wParam <= VK_F24)) and
     not ((Mensagem.wParam = VK_TAB) and (GetKeyState(VK_CONTROL) < 0)) then
  begin
    if Mensagem.message = WM_KEYDOWN then
      TranslateMessage(Mensagem);
    SendMessage(Mensagem.hwnd, Mensagem.message, Mensagem.wParam, Mensagem.lParam);
    Result := True;
    Exit;
  end;

  if (Mensagem.message = WM_KEYDOWN) and (Mensagem.wParam = VK_TAB) then
  begin
    // Ctrl+Tab e do PageControl do host: nao interceptar.
    if GetKeyState(VK_CONTROL) < 0 then
      Exit;
    TformHospedeira(Formulario).Avancar(Controle, GetKeyState(VK_SHIFT) >= 0);
    Result := True;
  end
  else if (Mensagem.message = WM_KEYDOWN) and (Mensagem.wParam = VK_RETURN) and
    ((Controle is TCustomEdit) or (Controle is TCustomCheckBox)) then
  begin
    // Mesmo que pProximoControle do cadastro: a validacao roda no OnExit do campo que perde o foco.
    TformHospedeira(Formulario).Avancar(Controle, True);
    Result := True;
  end
  else if (Mensagem.message = WM_CHAR) or
    ((Mensagem.wParam <> VK_ESCAPE) and not ((Mensagem.wParam >= VK_F1) and (Mensagem.wParam <= VK_F24)) and
    (Mensagem.wParam <> VK_TAB) and ((Mensagem.message = WM_KEYDOWN) or (Mensagem.message = WM_KEYUP))) then
  begin
    // Se a mensagem seguisse para o laco do exe, o VCL do host a trataria como tecla da aba dele e
    // um "5" digitado no campo trocaria a pagina do cadastro. Entrega direto ao campo da DLL.
    if Mensagem.message = WM_KEYDOWN then
      TranslateMessage(Mensagem);
    SendMessage(Mensagem.hwnd, Mensagem.message, Mensagem.wParam, Mensagem.lParam);
    Result := True;
  end;
end;

// Roda do mouse sobre um TScrollBox de um TformHospedeira (aba 2): rola a caixa e devolve True. O grid vertical
// (aba 3 dos 150.x) rola sozinho e fica de fora. Teste de 2026-10-15: a aba 2 nao rolava com a roda em 1920x1080.
function fTratarRoda(const Mensagem: TMsg): Boolean;
const
  // Altura de uma linha de campo nas abas: cada linha da roda (Mouse.WheelScrollLines) anda uma linha de campo.
  ALTURA_LINHA = 22;
var
  Ponto: TPoint;
  Controle: TWinControl;
  Caixa: TScrollBox;
  Delta: Integer;
  Linhas: Integer;
begin
  Result := False;
  Ponto.X := SmallInt(LoWord(Mensagem.lParam));
  Ponto.Y := SmallInt(HiWord(Mensagem.lParam));
  Controle := FindControl(WindowFromPoint(Ponto));
  if (Controle = nil) or not (GetParentForm(Controle, False) is TformHospedeira) or fDentroDeGrid(Controle) then
    Exit;

  while Assigned(Controle) and not (Controle is TScrollBox) do
    Controle := Controle.Parent;
  if not Assigned(Controle) then
    Exit;
  Caixa := TScrollBox(Controle);
  if not Caixa.VertScrollBar.Visible or (Caixa.VertScrollBar.Range <= Caixa.ClientHeight) then
    Exit;

  Delta := SmallInt(HiWord(Mensagem.wParam));
  Linhas := Mouse.WheelScrollLines;
  if Linhas <= 0 then
    Linhas := 3;
  Caixa.VertScrollBar.Position := Caixa.VertScrollBar.Position - (Delta * Linhas * ALTURA_LINHA) div WHEEL_DELTA;
  Result := True;
end;

// O gancho ve a mensagem antes de Application.IsKeyMsg do exe. Trocar por WM_NULL impede que o
// VCL do host (dono do foco "oficial") tambem trate a tecla.
function fGancho(Codigo: Integer; WParam: WPARAM; LParam: LPARAM): LRESULT; stdcall;
var
  Mensagem: PMsg;
begin
  if (Codigo = HC_ACTION) and (WParam = PM_REMOVE) then
  begin
    Mensagem := PMsg(LParam);
    if (Mensagem.message >= WM_KEYFIRST) and (Mensagem.message <= WM_CHAR) and fTratarTecla(Mensagem^) then
      Mensagem.message := WM_NULL
    else if (Mensagem.message = WM_MOUSEWHEEL) and fTratarRoda(Mensagem^) then
      Mensagem.message := WM_NULL;
  end;
  Result := CallNextHookEx(GGancho, Codigo, WParam, LParam);
end;

// O VCL da DLL nao percebe o foco indo para um controle do host; quem avisa e o Windows (WM_KILLFOCUS).
// O gancho ve a mensagem depois de tratada e repassa ao form da DLL dono do controle.
function fGanchoFoco(Codigo: Integer; WParam: WPARAM; LParam: LPARAM): LRESULT; stdcall;
var
  Retorno: PCWPRetStruct;
  Controle: TWinControl;
  Formulario: TCustomForm;
begin
  if Codigo = HC_ACTION then
  begin
    Retorno := PCWPRetStruct(LParam);
    if (Retorno.message = WM_KILLFOCUS) or (Retorno.message = WM_SETFOCUS) then
    begin
      Controle := FindControl(Retorno.hwnd);
      if Assigned(Controle) then
      begin
        Formulario := GetParentForm(Controle, False);
        if Formulario is TformHospedeira then
        begin
          if Retorno.message = WM_SETFOCUS then
            TformHospedeira(Formulario).FocoEntrou
          else
            TformHospedeira(Formulario).FocoSaiu(HWND(Retorno.wParam));
        end;
      end;
    end;
  end;
  Result := CallNextHookEx(GGanchoFoco, Codigo, WParam, LParam);
end;

// Substitui a WndProc da janela do host (SetWindowLongPtr) so para ouvir WM_SIZE. SetWindowSubclass
// foi descartado: dentro do exe real ele devolve False e o form da DLL nunca acompanhava o tamanho.
function fRespostaPai(Janela: HWND; Mensagem: UINT; WParam: WPARAM; LParam: LPARAM): LRESULT; stdcall;
var
  Antiga: Pointer;
  Forma: TformHospedeira;
begin
  Antiga := Pointer(GetProp(Janela, PROP_PROC));
  Result := CallWindowProc(Antiga, Janela, Mensagem, WParam, LParam);
  if Mensagem = WM_SIZE then
  begin
    Forma := TformHospedeira(GetProp(Janela, PROP_FORM));
    if Forma <> nil then
      Forma.AcompanharPai;
  end
  else if Mensagem = WM_NCDESTROY then
  begin
    // A janela do host morre antes da DLL: solta o que foi pendurado nela.
    SetWindowLongPtr(Janela, GWLP_WNDPROC, LONG_PTR(Antiga));
    RemoveProp(Janela, PROP_FORM);
    RemoveProp(Janela, PROP_PROC);
  end;
end;

procedure pRegistrarPai(const Janela: HWND);
var
  Indice: Integer;
begin
  for Indice := 0 to High(GPais) do
    if GPais[Indice] = Janela then
      Exit;
  SetLength(GPais, Length(GPais) + 1);
  GPais[High(GPais)] := Janela;
end;

procedure pEsquecerPai(const Janela: HWND);
var
  Indice: Integer;
begin
  for Indice := 0 to High(GPais) do
    if GPais[Indice] = Janela then
    begin
      GPais[Indice] := GPais[High(GPais)];
      SetLength(GPais, Length(GPais) - 1);
      Exit;
    end;
end;

// So desfaz a subclasse se a WndProc atual ainda for fRespostaPai: se outro codigo subclassificou
// depois, devolver a antiga cortaria a cadeia dele. Nesse caso so o form sai (fRespostaPai segue
// repassando para a WndProc guardada).
procedure pSoltarPai(const Janela: HWND);
begin
  if not IsWindow(Janela) or (GetProp(Janela, PROP_PROC) = 0) then
    Exit;

  if GetWindowLongPtr(Janela, GWLP_WNDPROC) = LONG_PTR(@fRespostaPai) then
  begin
    SetWindowLongPtr(Janela, GWLP_WNDPROC, LONG_PTR(GetProp(Janela, PROP_PROC)));
    RemoveProp(Janela, PROP_PROC);
  end;
  RemoveProp(Janela, PROP_FORM);
end;

procedure pLiberarGanchos;
var
  Indice: Integer;
begin
  for Indice := 0 to High(GPais) do
    pSoltarPai(GPais[Indice]);
  SetLength(GPais, 0);

  if GGancho <> 0 then
  begin
    UnhookWindowsHookEx(GGancho);
    GGancho := 0;
  end;
  if GGanchoFoco <> 0 then
  begin
    UnhookWindowsHookEx(GGanchoFoco);
    GGanchoFoco := 0;
  end;
end;

constructor TformHospedeira.CriarNaJanela(const PaiHandle: NativeUInt);
begin
  FPaiHandle := PaiHandle;
  CreateNew(nil);
  // Pelo handle e nao pela contagem: pLiberarGanchos pode ter soltado com forms ainda vivos.
  if GGancho = 0 then
    GGancho := SetWindowsHookEx(WH_GETMESSAGE, @fGancho, 0, GetCurrentThreadId);
  if GGanchoFoco = 0 then
    GGanchoFoco := SetWindowsHookEx(WH_CALLWNDPROCRET, @fGanchoFoco, 0, GetCurrentThreadId);
  Inc(GFormsAtivos);
  BorderStyle := bsNone;
  // Mesma cor do frame das abas; os containers dos frames herdam por ParentColor.
  Color := $00FFE4D5;
  pAssinarPai;
  AcompanharPai;

end;

procedure TformHospedeira.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if FPaiHandle <> 0 then
  begin
    Params.Style := (Params.Style or WS_CHILD or WS_CLIPCHILDREN or WS_CLIPSIBLINGS) and not (WS_POPUP or WS_CAPTION);
    Params.ExStyle := Params.ExStyle and not WS_EX_APPWINDOW;
    Params.WndParent := FPaiHandle;
  end;
end;

procedure TformHospedeira.pAssinarPai;
begin
  SetProp(FPaiHandle, PROP_FORM, THandle(Self));
  // Janela ja subclassificada (outro form nela, ou subclasse que nao pode ser desfeita): so troca o form.
  // Guardar a WndProc atual como antiga faria fRespostaPai chamar a si mesma.
  if GetProp(FPaiHandle, PROP_PROC) <> 0 then
    Exit;

  SetProp(FPaiHandle, PROP_PROC, THandle(GetWindowLongPtr(FPaiHandle, GWLP_WNDPROC)));
  SetWindowLongPtr(FPaiHandle, GWLP_WNDPROC, LONG_PTR(@fRespostaPai));
  pRegistrarPai(FPaiHandle);
end;

procedure TformHospedeira.AcompanharPai;
var
  Area: TRect;
begin
  Winapi.Windows.GetClientRect(FPaiHandle, Area);
  SetBounds(0, 0, Area.Right - Area.Left, Area.Bottom - Area.Top);
end;

procedure TformHospedeira.ConfirmarEdicao;
var
  Controle: TWinControl;
  Foco: HWND;
begin
  if FConfirmando or not FPendente or not Assigned(ActiveControl) then
    Exit;

  FConfirmando := True;
  try
    FPendente := False;
    Controle := ActiveControl;
    Controle.Perform(CM_EXIT, 0, 0);
    // O VCL continua com o controle como focado: na volta do foco nao haveria CM_ENTER, e a saida
    // seguinte rodaria CM_EXIT sobre o texto ja formatado (TDBEditFocus.CMExit reprova "1.234,56" e
    // prende o campo). DefocusControl recua o controle focado para o pai; form WS_CHILD nunca fica
    // Active, entao ele nao mexe no foco do Windows.
    if not Active then
      DefocusControl(Controle, True);
    if Assigned(FAoConfirmar) then
      FAoConfirmar();

    // Confirmacao sem o foco sair do form (atalho de Gravar no campo): o controle volta a estar em
    // edicao, como numa nova entrada, e segue pendente.
    Foco := GetFocus;
    if (Foco <> 0) and ((Foco = Handle) or IsChild(Handle, Foco)) then
    begin
      Controle := FindControl(Foco);
      if Assigned(Controle) then
      begin
        SetFocusedControl(Controle);
        FPendente := True;
      end;
    end;
  finally
    FConfirmando := False;
  end;
end;

procedure TformHospedeira.FocoEntrou;
begin
  if HandleAllocated and not (csDestroying in ComponentState) then
    FPendente := True;
end;

procedure TformHospedeira.FocoSaiu(const Novo: HWND);
begin
  if not FPendente or FConfirmando or not HandleAllocated or (csDestroying in ComponentState) then
    Exit;
  // Alt+Tab ou outro programa: o VCL tambem nao dispara OnExit nesses casos.
  if (Novo = 0) or not IsWindow(Novo) then
    Exit;
  // Dentro do proprio form o VCL ja dispara OnExit.
  if (Novo = Handle) or IsChild(Handle, Novo) then
    Exit;
  // So conta o foco indo para outro controle da mesma tela do cadastro. Um dialogo (a mensagem que a propria
  // validacao abre, por exemplo) e outra janela de topo: ignorar evita validar de novo por causa dela.
  if GetAncestor(Novo, GA_ROOT) <> GetAncestor(Handle, GA_ROOT) then
    Exit;
  // Depois que o Windows terminar de trocar o foco: a validacao pode abrir mensagem.
  PostMessage(Handle, WM_REFORMA_CONFIRMAR, 0, 0);
end;

procedure TformHospedeira.WMReformaConfirmar(var Mensagem: TMessage);
begin
  ConfirmarEdicao;
end;

procedure TformHospedeira.Avancar(const Origem: TWinControl; const Adiante: Boolean);
begin
  SelectNext(Origem, Adiante, True);
end;

procedure TformHospedeira.DoDestroy;
begin
  // So a janela que ainda aponta para este form: se outro form assumiu o mesmo HWND, ele a solta.
  if (FPaiHandle <> 0) and IsWindow(FPaiHandle) and (GetProp(FPaiHandle, PROP_FORM) = THandle(Self)) then
  begin
    pSoltarPai(FPaiHandle);
    if GetProp(FPaiHandle, PROP_PROC) = 0 then
      pEsquecerPai(FPaiHandle);
  end;
  Dec(GFormsAtivos);
  if (GFormsAtivos = 0) and (GGancho <> 0) then
  begin
    UnhookWindowsHookEx(GGancho);
    GGancho := 0;
  end;
  if (GFormsAtivos = 0) and (GGanchoFoco <> 0) then
  begin
    UnhookWindowsHookEx(GGanchoFoco);
    GGanchoFoco := 0;
  end;
  inherited DoDestroy;
end;

initialization

finalization
  // FreeLibrary sem pReformaFinalizar (ou Finalizar que falhou): ganchos e WndProc nao podem ficar
  // apontando para codigo descarregado.
  pLiberarGanchos;

end.