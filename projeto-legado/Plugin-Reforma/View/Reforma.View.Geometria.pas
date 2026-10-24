unit Reforma.View.Geometria;

// Posiciona os controles de um frame da DLL (Left/Top/Width/Height) como os controles
// equivalentes da aba 1, lidos do host em tempo de execucao: se o layout da aba 1 mudar, a
// aba 3 acompanha sem recompilar a DLL. O host so responde pelo nome do controle, entao o controle
// da DLL tem o mesmo nome do controle da aba 1 (lblIcmEnt no host, lblIcmEntFut na DLL). Busca:
//   1. o mesmo nome (dbeCBS1Fut existe nos dois);
//   2. o nome sem o sufixo Fut;
//   3. campo com dados da DLL (dbe...) que no host e um edit comum (edt...): dbePreCl1Fut -> edtPreCl1.
// Controle sem par no host mantem a posicao do proprio DFM. Painel sem par (o 72 nao tem pnlCusReal nem
// pnlPrecosContainer) se ajusta ao que contem: pAjustarPaineisSemPar. A linha dos impostos federais, que as abas 3
// e 4 nao tem, e fechada em pFecharLacunasFederais.

interface

uses
  System.Classes,
  Reforma.Contrato.Host;

procedure pAlinharComHost(const Dono: TComponent; const Host: IReformaHost);

// Resumo do layout do host que interessa a aba 3: muda quando o alinhamento ja feito deixa de valer.
function fAssinaturaLayout(const Host: IReformaHost): string;

implementation

uses
  System.SysUtils, System.Types, System.Math, Vcl.Controls, Vcl.ExtCtrls, Vcl.StdCtrls;

const
  // Cadeia de paineis do host ate a area de precos da aba 1: a soma de Left/Top e a origem da aba 3.
  CADEIA_ORIGEM: array[0..2] of string = ('pnlPrecos', 'pnlPrecos1', 'pnlPrecosContainer');

// Procura no host o equivalente do controle da DLL (regras no topo da unit).
function fGeometria(const Host: IReformaHost; const Nome: string; out Esquerda, Topo, Largura, Altura: Integer): Boolean;
var
  Base: string;
begin
  Result := Host.GeometriaControle(Nome, Esquerda, Topo, Largura, Altura);
  if Result then
    Exit;

  if (Length(Nome) <= 3) or not SameText(Copy(Nome, Length(Nome) - 2, 3), 'Fut') then
    Exit;
  Base := Copy(Nome, 1, Length(Nome) - 3);
  Result := Host.GeometriaControle(Base, Esquerda, Topo, Largura, Altura);

  // Campo com dados na DLL (dbe...) que no host e um edit sem dados (edt...).
  if (not Result) and SameText(Copy(Base, 1, 3), 'dbe') then
    Result := Host.GeometriaControle('edt' + Copy(Base, 4, MaxInt), Esquerda, Topo, Largura, Altura);
end;

procedure pAplicar(const Controle: TControl; const Esquerda, Topo, Largura, Altura: Integer);
var
  NovoEsquerda, NovoTopo, NovaLargura, NovaAltura: Integer;
begin
  NovoEsquerda := Controle.Left;
  NovoTopo := Controle.Top;
  NovaLargura := Controle.Width;
  NovaAltura := Controle.Height;

  if Controle is TLabel then
  begin
    // O rotulo dimensiona-se pela fonte; o que vale e a mesma borda direita nos alinhados a direita.
    NovoTopo := Topo;
    if TLabel(Controle).Alignment = taRightJustify then
      NovoEsquerda := Esquerda + Largura - Controle.Width
    else
      NovoEsquerda := Esquerda;
  end
  else
  begin
    // Filho de FlowPanel e alinhado nao tem Left/Top proprios: o controle-pai decide.
    if (Controle.Align = alNone) and not (Controle.Parent is TFlowPanel) then
    begin
      NovoEsquerda := Esquerda;
      NovoTopo := Topo;
    end;
    if Controle.Align in [alNone, alLeft, alRight] then
      NovaLargura := Largura;
    if Controle.Align in [alNone, alTop, alBottom] then
      NovaAltura := Altura;
  end;
  Controle.SetBounds(NovoEsquerda, NovoTopo, NovaLargura, NovaAltura);
end;

// A aba 3 precisa comecar no mesmo pixel da area de precos da aba 1. No host a cadeia
// pnlPrecos > pnlPrecos1 > pnlPrecosContainer soma Left/Top (inclusive a faixa do NCM, quando ele
// aparece); o pnlConteudoFut recebe essa soma como margem e pnlPrecosContainerFut/FlwPnlTabelasFut herdam a mesma origem.
procedure pAlinharOrigem(const Dono: TComponent; const Host: IReformaHost);
var
  Painel: TPanel;
  Indice: Integer;
  Esquerda, Topo, Largura, Altura: Integer;
  SomaEsquerda, SomaTopo: Integer;
begin
  Painel := Dono.FindComponent('pnlConteudoFut') as TPanel;
  if Painel = nil then
    Exit;

  SomaEsquerda := 0;
  SomaTopo := 0;
  for Indice := Low(CADEIA_ORIGEM) to High(CADEIA_ORIGEM) do
    if Host.GeometriaControle(CADEIA_ORIGEM[Indice], Esquerda, Topo, Largura, Altura) then
    begin
      Inc(SomaEsquerda, Esquerda);
      Inc(SomaTopo, Topo);
    end;

  Painel.AlignWithMargins := True;
  Painel.Margins.Left := SomaEsquerda;
  Painel.Margins.Top := SomaTopo;
end;

// Painel da DLL que o host nao tem (no 72 os controles do custo real ficam soltos em pnlPrecos1, sem pnlCusReal):
// pAplicar ja deu aos filhos a posicao que eles tem no painel-pai do host, entao o painel passa a ocupar o
// retangulo que esses filhos formam e eles voltam a ser relativos a ele. Painel sem nenhum filho com par, ou
// dentro de FlowPanel (quem manda e o fluxo), fica como esta no DFM.
procedure pEncolherPainelSemPar(const Painel: TPanel; const Host: IReformaHost);
var
  Indice: Integer;
  Filho: TControl;
  Esquerda, Topo, Largura, Altura: Integer;
  Area: TRect;
  Achou: Boolean;
begin
  if (Painel.Align <> alNone) or (Painel.Parent is TFlowPanel) then
    Exit;
  if fGeometria(Host, Painel.Name, Esquerda, Topo, Largura, Altura) then
    Exit;

  Achou := False;
  Area := Rect(MaxInt, MaxInt, -MaxInt, -MaxInt);
  for Indice := 0 to Painel.ControlCount - 1 do
  begin
    Filho := Painel.Controls[Indice];
    if not fGeometria(Host, Filho.Name, Esquerda, Topo, Largura, Altura) then
      Continue;
    Achou := True;
    Area.Left := Min(Area.Left, Filho.Left);
    Area.Top := Min(Area.Top, Filho.Top);
    Area.Right := Max(Area.Right, Filho.Left + Filho.Width);
    Area.Bottom := Max(Area.Bottom, Filho.Top + Filho.Height);
  end;
  if not Achou then
    Exit;

  Painel.SetBounds(Area.Left, Area.Top, Area.Right - Area.Left, Area.Bottom - Area.Top);
  for Indice := 0 to Painel.ControlCount - 1 do
  begin
    Filho := Painel.Controls[Indice];
    if fGeometria(Host, Filho.Name, Esquerda, Topo, Largura, Altura) then
      Filho.SetBounds(Filho.Left - Area.Left, Filho.Top - Area.Top, Filho.Width, Filho.Height);
  end;
end;

// Container de largura total (alTop) que o host nao tem: a altura e a do que ele contem, mais o que fica
// colado embaixo (a faixa "TABELAS DE PRECO"). Com o container no host, pAplicar ja usou a altura dele.
procedure pAjustarAlturaContainerSemPar(const Painel: TPanel; const Host: IReformaHost);
var
  Indice: Integer;
  Filho: TControl;
  Esquerda, Topo, Largura, Altura: Integer;
  Conteudo, Rodape: Integer;
begin
  if Painel.Align <> alTop then
    Exit;
  if fGeometria(Host, Painel.Name, Esquerda, Topo, Largura, Altura) then
    Exit;

  Conteudo := 0;
  Rodape := 0;
  for Indice := 0 to Painel.ControlCount - 1 do
  begin
    Filho := Painel.Controls[Indice];
    if not Filho.Visible then
      Continue;
    if Filho.Align = alNone then
      Conteudo := Max(Conteudo, Filho.Top + Filho.Height)
    else if Filho.Align = alBottom then
      Inc(Rodape, Filho.Height);
  end;
  if Conteudo > 0 then
    Painel.Height := Conteudo + Rodape;
end;

procedure pAjustarPaineisSemPar(const Dono: TComponent; const Host: IReformaHost);
var
  I: Integer;
begin
  // Primeiro os paineis soltos (o custo real), depois o container, que soma o que ficou.
  for I := 0 to Dono.ComponentCount - 1 do
    if Dono.Components[I] is TPanel then
      pEncolherPainelSemPar(TPanel(Dono.Components[I]), Host);
  for I := 0 to Dono.ComponentCount - 1 do
    if Dono.Components[I] is TPanel then
      pAjustarAlturaContainerSemPar(TPanel(Dono.Components[I]), Host);
end;

// CFG_REFCIS desligado (antes da conversao): a aba 1 mostra os impostos federais de entrada (dbeSubFed, coluna do
// meio) e de saida (dbeImpFed, custo real), que a reforma extingue e por isso nao existem nas abas 3 e 4. A posicao
// copiada da aba 1 deixava a linha deles vazia; aqui o que fica abaixo dela sobe, como o host faz quando ele mesmo
// os esconde (pReformaOcultaImpostosFederais, com CFG_REFCIS): coluna do meio do Preco em Dolar ate os % dela, e o
// custo real inteiro. Com os federais ja escondidos pelo host a linha de baixo ocupa o lugar deles (distancia 0) e
// nada se move. So sobe controle com par no host: pAplicar acabou de o repor, entao refazer o alinhamento (nova
// assinatura) nao o sobe duas vezes; controle sem par (Suframa do 72) fica onde o DFM o pos.
procedure pSubirAbaixo(const Dono: TComponent; const Host: IReformaHost; const NomePainel, NomeFederal,
  NomeSeguinte: string; const Esquerda, Direita: Integer);
var
  Componente: TComponent;
  Painel: TWinControl;
  Indice: Integer;
  Filho: TControl;
  TopoFederal, TopoSeguinte, Distancia: Integer;
  Esq, Topo, Largura, Altura: Integer;
begin
  Componente := Dono.FindComponent(NomePainel);
  if not (Componente is TWinControl) then
    Exit;
  Painel := TWinControl(Componente);

  if not Host.GeometriaControle(NomeFederal, Esq, TopoFederal, Largura, Altura) then
    Exit;
  if not Host.GeometriaControle(NomeSeguinte, Esq, TopoSeguinte, Largura, Altura) then
    Exit;
  Distancia := TopoSeguinte - TopoFederal;
  if Distancia <= 0 then
    Exit;

  for Indice := 0 to Painel.ControlCount - 1 do
  begin
    Filho := Painel.Controls[Indice];
    if (Filho.Top > TopoFederal + 2) and (Filho.Left >= Esquerda) and (Filho.Left < Direita) and
       fGeometria(Host, Filho.Name, Esq, Topo, Largura, Altura) then
      Filho.Top := Filho.Top - Distancia;
  end;
end;

procedure pFecharLacunasFederais(const Dono: TComponent; const Host: IReformaHost);
var
  Esquerda, Direita, Topo, Largura, Altura: Integer;
begin
  // Mesmos limites da coluna do meio que o host usa: a coluna da esquerda e o Suframa ficam.
  if Host.GeometriaControle('chkPreDol', Esquerda, Topo, Largura, Altura) and
     Host.GeometriaControle('lblSubFedPer', Direita, Topo, Largura, Altura) then
    pSubirAbaixo(Dono, Host, 'pnlPrecosContainerFut', 'dbeSubFed', 'dbeIpiEnt', Esquerda, Direita + Largura + 5);

  pSubirAbaixo(Dono, Host, 'pnlCusRealFut', 'dbeImpFed', 'dbeDesOpe', 0, MaxInt);
end;

procedure pAlinharComHost(const Dono: TComponent; const Host: IReformaHost);
var
  I: Integer;
  Controle: TControl;
  Esquerda, Topo, Largura, Altura: Integer;
begin
  for I := 0 to Dono.ComponentCount - 1 do
  begin
    if not (Dono.Components[I] is TControl) then
      Continue;
    Controle := TControl(Dono.Components[I]);
    if fGeometria(Host, Controle.Name, Esquerda, Topo, Largura, Altura) then
      pAplicar(Controle, Esquerda, Topo, Largura, Altura);
  end;

  pFecharLacunasFederais(Dono, Host);
  pAjustarPaineisSemPar(Dono, Host);
  pAlinharOrigem(Dono, Host);
end;

// Resumo do que decide onde a aba 3 fica: origem da area de precos, altura do grupo e o que o
// cadastro ajusta ao definir a visibilidade (largura do preco de venda, topo da linha US$). Serve so
// para saber se o alinhamento ja feito continua valendo; nao depende do tamanho da janela.
function fAssinaturaLayout(const Host: IReformaHost): string;
var
  Indice: Integer;
  Esquerda, Topo, Largura, Altura: Integer;
begin
  Result := '';
  for Indice := Low(CADEIA_ORIGEM) to High(CADEIA_ORIGEM) do
    if Host.GeometriaControle(CADEIA_ORIGEM[Indice], Esquerda, Topo, Largura, Altura) then
      Result := Result + IntToStr(Esquerda) + ',' + IntToStr(Topo) + ';'
    else
      Result := Result + '-;';

  if Host.GeometriaControle('gpbTabPre01', Esquerda, Topo, Largura, Altura) then
    Result := Result + IntToStr(Altura) + ';'
  else
    Result := Result + '-;';

  if Host.GeometriaControle('dbePreVe1', Esquerda, Topo, Largura, Altura) then
    Result := Result + IntToStr(Largura) + ';'
  else
    Result := Result + '-;';

  if Host.GeometriaControle('edtDolar1', Esquerda, Topo, Largura, Altura) then
    Result := Result + IntToStr(Topo) + ';'
  else
    Result := Result + '-;';

  // Federais visiveis ou ja escondidos pelo host (pFecharLacunasFederais).
  if Host.GeometriaControle('dbeIpiEnt', Esquerda, Topo, Largura, Altura) then
    Result := Result + IntToStr(Topo) + ';'
  else
    Result := Result + '-;';
  if Host.GeometriaControle('dbeDesOpe', Esquerda, Topo, Largura, Altura) then
    Result := Result + IntToStr(Topo) + ';'
  else
    Result := Result + '-;';
end;

end.
