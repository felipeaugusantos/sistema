unit Reforma.View.Estilo;

// Skin (VCL Styles) do cadastro. A DLL tem o proprio Vcl.Themes, entao o estilo precisa existir nela
// (recurso VCLStyles.res, o mesmo do exe) e ser ativado pelo nome que o host informa em EstiloVisual;
// sem isso as abas ficam no visual classico dentro de um cadastro com skin. O padrao e o das outras DLLs
// do sistema (TrySetStyle e UnRegisterSysStyleHook). pAjustarTema repete o que TfrmPai.pAjustarTema faz
// nas telas do cadastro.

interface

uses
  System.Classes, System.UITypes, Vcl.Controls, Vcl.StdCtrls,
  Reforma.Contrato.Host;

// Ativa o estilo na DLL (Vcl.Styles registra o estilo que veio no recurso VCLStyles.res). Nome vazio (modo classico) ou estilo inexistente deixam tudo como esta.
procedure pAtivarEstilo(const Nome: string);

function fEstiloAtivo: Boolean;

// Repete em Raiz e em tudo que ela contem o ajuste de cores que o cadastro faz com skin. Sem skin nao faz nada.
procedure pAjustarTema(const Raiz: TWinControl);

// Cor de fonte de um rotulo que vem do host. So preto e branco seguem a cor do estilo; as demais ficam como o
// host pintou (mesma regra de pAjustarTema).
procedure pDefinirCorRotulo(const Rotulo: TLabel; const Cor: TColor);

// A aba 1 pinta alguns titulos conforme a matriz de margem do grupo (PROMAT: preto, vermelho, azul ou verde).
// As abas da DLL mostram os mesmos titulos com a cor que o rotulo do cadastro tem naquele momento. O rotulo da
// DLL tem o nome do rotulo do host mais o sufixo da aba (Fut, Atual, Novo); so a cor muda, nenhuma posicao.
procedure pAcompanharCoresAba1(const Host: IReformaHost; const Raiz: TComponent; const Sufixos: array of string);

implementation

uses
  System.SysUtils, System.TypInfo, Vcl.Graphics, Vcl.Themes, Vcl.Styles, Vcl.SysStyles, Vcl.ExtCtrls,
  Vcl.Forms, cxControls, cxContainer, cxGroupBox, cxLookAndFeels, cxStyles;

const
  // Cor de fundo dos containers no modo classico; com skin vira a cor de painel do estilo.
  COR_CONTAINER_CLASSICO = $00FFE4D5;

type
  // LookAndFeel e Style do DevExpress sao protegidos; o cadastro usa o mesmo truque em pSetCxControlsScrollbarModeClassic.
  TcxControlAcesso = class(TcxControl);
  TcxContainerAcesso = class(TcxContainer);

var
  GEstiloAtivo: Boolean;

// A DLL so pinta o que e dela: menu, dialogos e barras do sistema ja sao tratados pelo Vcl.Themes do exe.
procedure pSoltarHooksDeSistema;
begin
  TCustomStyleEngine.UnRegisterSysStyleHook('#32768', TSysPopupStyleHook);
  TCustomStyleEngine.UnRegisterSysStyleHook('#32770', TSysDialogStyleHook);
  TCustomStyleEngine.UnRegisterSysStyleHook('ScrollBar', TSysScrollBarStyleHook);
  TCustomStyleEngine.UnRegisterSysStyleHook('Button', TSysButtonStyleHook);
  TCustomStyleEngine.UnRegisterSysStyleHook('Edit', TSysEditStyleHook);
  TCustomStyleEngine.UnRegisterSysStyleHook('ComboBox', TSysComboBoxStyleHook);
  TCustomStyleEngine.UnRegisterSysStyleHook('ListBox', TSysListBoxStyleHook);
  TCustomStyleEngine.UnRegisterSysStyleHook('ComboLBox', TSysListBoxStyleHook);
  TCustomStyleEngine.UnRegisterSysStyleHook('Static', TSysStaticStyleHook);
  TCustomStyleEngine.UnRegisterSysStyleHook('ToolbarWindow32', TSysToolbarStyleHook);
  TCustomStyleEngine.UnRegisterSysStyleHook('SysListView32', TSysListViewStyleHook);
  TCustomStyleEngine.UnRegisterSysStyleHook('SysTabControl32', TSysTabControlStyleHook);
  TCustomStyleEngine.UnRegisterSysStyleHook('SysTreeView32', TSysTreeViewStyleHook);
  TCustomStyleEngine.UnRegisterSysStyleHook('msctls_progress32', TSysProgressBarStyleHook);
  TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit20A', TSysRichEditStyleHook);
  TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit20W', TSysRichEditStyleHook);
  TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit30A', TSysRichEditStyleHook);
  TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit30W', TSysRichEditStyleHook);
  TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit41A', TSysRichEditStyleHook);
  TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit41W', TSysRichEditStyleHook);
  TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit50A', TSysRichEditStyleHook);
  TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit50W', TSysRichEditStyleHook);
  TCustomStyleEngine.UnRegisterSysStyleHook('RebarWindow32', TSysReBarStyleHook);
  TCustomStyleEngine.UnRegisterSysStyleHook('msctls_statusbar32', TSysStatusBarStyleHook);
  TCustomStyleEngine.UnRegisterSysStyleHook('msctls_trackbar32', TSysTrackBarStyleHook);
  TCustomStyleEngine.UnRegisterSysStyleHook('msctls_updown32', TSysUpDownStyleHook);
  TCustomStyleEngine.UnRegisterSysStyleHook('tooltips_class32', TSysTooltipsStyleHook);
end;

procedure pAtivarEstilo(const Nome: string);
begin
  if GEstiloAtivo or (Nome = '') then
    Exit;

  try
    GEstiloAtivo := TStyleManager.TrySetStyle(Nome, False);
    if GEstiloAtivo then
      pSoltarHooksDeSistema;
  except
    // Como nas outras DLLs: se o estilo nao puder ser aplicado a tela segue no modo classico.
    GEstiloAtivo := False;
  end;
end;

function fEstiloAtivo: Boolean;
begin
  Result := GEstiloAtivo;
end;

// O fundo e as celulas fixas dos grids vem de TcxStyle (cxsColunaFixa, cxsPreco, cxsMargem...) com o mesmo azul
// dos containers, e o estilo VCL nao alcanca TcxStyle. Com skin, todo estilo com esse azul passa para a cor de
// painel (mesma regra do cadastro em untPrecoProdutoFrame). Os estilos pertencem ao frame/form do .dfm.
procedure pAjustarEstilosAzuis(const Dono: TComponent);
var
  Indice: Integer;
begin
  for Indice := 0 to Dono.ComponentCount - 1 do
    if (Dono.Components[Indice] is TcxStyle) and (TcxStyle(Dono.Components[Indice]).Color = COR_CONTAINER_CLASSICO) then
      TcxStyle(Dono.Components[Indice]).Color := TStyleManager.ActiveStyle.GetStyleColor(scPanel);
end;

procedure pAjustarControle(const Controle: TControl);
begin
  if IsPublishedProp(Controle, 'ParentBackground') then
    SetPropValue(Controle, 'ParentBackground', False);

  if IsPublishedProp(Controle, 'Color') then
    if GetPropValue(Controle, 'Color') = COR_CONTAINER_CLASSICO then
      SetPropValue(Controle, 'Color', TStyleManager.ActiveStyle.GetStyleColor(scPanel));

  // Rotulo e edit com cor propria (azul, vermelho...) mantem a cor; so preto e branco seguem o estilo.
  if Controle is TLabel then
    if (TLabel(Controle).Font.Color <> clBlack) and (TLabel(Controle).Font.Color <> clWhite) then
      TLabel(Controle).StyleElements := TLabel(Controle).StyleElements - [seFont];

  if Controle is TEdit then
    if (TEdit(Controle).Font.Color <> clBlack) and (TEdit(Controle).Font.Color <> clWhite) then
      TEdit(Controle).StyleElements := TEdit(Controle).StyleElements - [seFont];

  if Controle is TcxControl then
    TcxControlAcesso(Controle).LookAndFeel.ScrollbarMode := sbmClassic;

  if Controle is TcxContainer then
    TcxContainerAcesso(Controle).Style.LookAndFeel.ScrollbarMode := sbmClassic;

  if Controle is TcxGroupBox then
  begin
    TcxGroupBox(Controle).Style.Color := TStyleManager.ActiveStyle.GetStyleColor(scPanel);
    TcxGroupBox(Controle).Transparent := True;
  end;

  if (Controle is TCustomFrame) or (Controle is TCustomForm) then
    pAjustarEstilosAzuis(Controle);
end;

procedure pAjustarFilhos(const Pai: TWinControl);
var
  Indice: Integer;
begin
  for Indice := 0 to Pai.ControlCount - 1 do
  begin
    pAjustarControle(Pai.Controls[Indice]);
    if Pai.Controls[Indice] is TWinControl then
      pAjustarFilhos(TWinControl(Pai.Controls[Indice]));
  end;
end;

procedure pAjustarTema(const Raiz: TWinControl);
begin
  if not GEstiloAtivo then
    Exit;

  pAjustarControle(Raiz);
  pAjustarFilhos(Raiz);
end;

procedure pDefinirCorRotulo(const Rotulo: TLabel; const Cor: TColor);
begin
  Rotulo.Font.Color := Cor;
  if not GEstiloAtivo then
    Exit;

  if (Cor = clBlack) or (Cor = clWhite) then
    Rotulo.StyleElements := Rotulo.StyleElements + [seFont]
  else
    Rotulo.StyleElements := Rotulo.StyleElements - [seFont];
end;

procedure pAcompanharCoresAba1(const Host: IReformaHost; const Raiz: TComponent; const Sufixos: array of string);
const
  ROTULOS: array[0..4] of string = ('lblTitMarBr1', 'lblTitComTb1', 'lblTitPreVe1', 'lblDolar1', 'lblMarIde1');
var
  Indice: Integer;
  Sufixo: Integer;
  Cor: Integer;
  Rotulo: TComponent;
begin
  for Indice := Low(ROTULOS) to High(ROTULOS) do
    for Sufixo := Low(Sufixos) to High(Sufixos) do
    begin
      Rotulo := Raiz.FindComponent(ROTULOS[Indice] + Sufixos[Sufixo]);
      if (Rotulo is TLabel) and Host.CorRotulo(ROTULOS[Indice], Cor) then
        pDefinirCorRotulo(TLabel(Rotulo), Cor);
    end;
end;

end.
