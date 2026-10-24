unit Reforma.View.CalculoConvert;

// Aba 4 "Calculo Convert" (usuario, 2026-10-06): a aba 3 somente leitura com os valores que o Convert gravaria para o
// produto em tela, e os dois radios da tela de conversao que mudam a conta (opcao de recalculo e origem dos impostos).
// So o operador 998 a ve, e so antes da conversao (Reforma.Simulacao.Convert.fAba4Disponivel). Os campos sao os do
// frame da aba 3 (classico no 72/74.111, grid vertical no 150.x) ligados a uma simulacao propria, so de leitura.
// Mudou a aba 3 (ouvinte da simulacao dela) ou um radio: o calculo e refeito na hora; com a aba fora da tela, ao
// entrar nela (Entrar sempre recalcula, porque a aba 1 pode ter mudado sem a aba 3 avisar).

interface

uses
  System.Classes,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Reforma.Contrato.Host,
  Reforma.Simulacao.Modelo,
  Reforma.View.Futura,
  Reforma.View.FuturaGrid;

type
  TpnlCalculoConvert = class(TPanel)
  strict private
    FHost: IReformaHost;
    FAba3: TSimulacaoReforma;
    FSimulacao: TSimulacaoReforma;
    FFutura: TframeFutura;
    FFuturaGrid: TframeFuturaGrid;
    FCalculando: Boolean;
    pnlOpcoes: TPanel;
    rdgOpcao: TRadioGroup;
    rdgOrigemImpostos: TRadioGroup;
    lblSituacao: TLabel;
    procedure pCriarOpcoes;
    procedure pOpcaoClick(Sender: TObject);
    procedure pAba3Mudou(Sender: TObject);
    procedure pRecalcular;
    function fNaTela: Boolean;
  public
    // Pai ja com janela: os radios (TRadioGroup) criam os botoes na hora e exigem a cadeia de janelas.
    constructor Criar(AOwner: TComponent; const Pai: TWinControl; const Host: IReformaHost;
      const Aba3: TSimulacaoReforma; const Grid: Boolean);
    destructor Destroy; override;
    procedure Entrar;
    procedure AplicarEstado;
  end;

implementation

uses
  Winapi.Windows,
  System.SysUtils,
  Vcl.Graphics,
  Reforma.Contrato.Convert,
  Reforma.Calculo.Modelo,
  Reforma.Convert.Processo,
  Reforma.Simulacao.Convert;

constructor TpnlCalculoConvert.Criar(AOwner: TComponent; const Pai: TWinControl; const Host: IReformaHost;
  const Aba3: TSimulacaoReforma; const Grid: Boolean);
begin
  inherited Create(AOwner);
  Parent := Pai;
  Align := alClient;
  FHost := Host;
  FAba3 := Aba3;
  BevelOuter := bvNone;
  ParentColor := True;
  ParentBackground := False;
  ShowCaption := False;

  FSimulacao := TSimulacaoReforma.CriarSomenteLeitura(Host);
  pCriarOpcoes;

  if Grid then
  begin
    FFuturaGrid := TframeFuturaGrid.Criar(Self, Host, FSimulacao);
    FFuturaGrid.Name := 'fraCalculoConvertGrid';
    FFuturaGrid.Parent := Self;
    FFuturaGrid.Align := alClient;
  end
  else
  begin
    FFutura := TframeFutura.Criar(Self, Host, FSimulacao);
    FFutura.Name := 'fraCalculoConvert';
    FFutura.Parent := Self;
    FFutura.Align := alClient;
  end;

  FAba3.AdicionarOuvinte(pAba3Mudou);
end;

destructor TpnlCalculoConvert.Destroy;
begin
  if Assigned(FAba3) then
    FAba3.RemoverOuvinte(pAba3Mudou);
  // Os frames assinam a simulacao desta aba: saem antes dela.
  FreeAndNil(FFutura);
  FreeAndNil(FFuturaGrid);
  FreeAndNil(FSimulacao);
  inherited Destroy;
end;

// Os mesmos radios e textos da tela de conversao; o padrao tambem e o dela (CFG_VENMAR e tabela estatica).
procedure TpnlCalculoConvert.pCriarOpcoes;
begin
  pnlOpcoes := TPanel.Create(Self);
  pnlOpcoes.Parent := Self;
  pnlOpcoes.Align := alTop;
  pnlOpcoes.Height := 54;
  pnlOpcoes.BevelOuter := bvNone;
  pnlOpcoes.ParentColor := True;
  pnlOpcoes.ParentBackground := False;
  pnlOpcoes.ShowCaption := False;

  rdgOpcao := TRadioGroup.Create(Self);
  rdgOpcao.Parent := pnlOpcoes;
  rdgOpcao.AlignWithMargins := True;
  rdgOpcao.Margins.Left := 6;
  rdgOpcao.Margins.Right := 6;
  rdgOpcao.Align := alLeft;
  rdgOpcao.Width := 179;
  rdgOpcao.Caption := ' Opção de recálculo ';
  rdgOpcao.Items.Add('Recalcular Preço de Venda');
  rdgOpcao.Items.Add('Recalcular Margem');
  if FHost.ConfiguracaoTexto('VENMAR') = '1' then
    rdgOpcao.ItemIndex := 0
  else
    rdgOpcao.ItemIndex := 1;
  rdgOpcao.OnClick := pOpcaoClick;

  rdgOrigemImpostos := TRadioGroup.Create(Self);
  rdgOrigemImpostos.Parent := pnlOpcoes;
  rdgOrigemImpostos.AlignWithMargins := True;
  rdgOrigemImpostos.Margins.Left := 6;
  rdgOrigemImpostos.Left := rdgOpcao.Left + rdgOpcao.Width + 10;
  rdgOrigemImpostos.Align := alLeft;
  rdgOrigemImpostos.Width := 204;
  rdgOrigemImpostos.Caption := ' Origem dos Impostos (CBS/IBS/IS) ';
  rdgOrigemImpostos.Items.Add('Tabela Estática');
  rdgOrigemImpostos.Items.Add('Abreviação do Item');
  rdgOrigemImpostos.ItemIndex := 0;
  rdgOrigemImpostos.OnClick := pOpcaoClick;

  lblSituacao := TLabel.Create(Self);
  lblSituacao.Parent := pnlOpcoes;
  lblSituacao.AlignWithMargins := True;
  lblSituacao.Margins.Left := 12;
  lblSituacao.Align := alClient;
  lblSituacao.Layout := tlCenter;
  lblSituacao.WordWrap := True;
  lblSituacao.Font.Style := [fsBold];
end;

function TpnlCalculoConvert.fNaTela: Boolean;
begin
  Result := HandleAllocated and IsWindowVisible(Handle);
end;

procedure TpnlCalculoConvert.pRecalcular;
var
  Formacao: TFormacaoCusto;
  Mensagem: string;
  Opcao: TOpcaoConversao;
  Origem: TOrigemImpostosConversao;
begin
  if FCalculando then
    Exit;

  FCalculando := True;
  try
    if rdgOpcao.ItemIndex = 1 then
      Opcao := ocvRecalcularMargem
    else
      Opcao := ocvRecalcularPrecoVenda;
    if rdgOrigemImpostos.ItemIndex = 1 then
      Origem := oicAbreviacaoItem
    else
      Origem := oicTabelaEstatica;

    if fCalcularConvertProduto(FHost, FAba3, Opcao, Origem, Formacao, Mensagem) then
    begin
      lblSituacao.Font.Color := clWindowText;
      lblSituacao.Caption := 'Valores que o Convert gravaria para este produto na empresa ' + FHost.CodigoEmpresa +
        ', com a aba 3 como está. Somente leitura.';
    end
    else
    begin
      // Sem calculo os campos ficam zerados: nada da tela anterior passa por valor do Convert.
      lblSituacao.Font.Color := clRed;
      lblSituacao.Caption := Mensagem;
    end;
    FSimulacao.MostrarConvert(Formacao);
  finally
    FCalculando := False;
  end;
end;

procedure TpnlCalculoConvert.pOpcaoClick(Sender: TObject);
begin
  pRecalcular;
end;

procedure TpnlCalculoConvert.pAba3Mudou(Sender: TObject);
begin
  if fNaTela then
    pRecalcular;
end;

// Sempre recalcula: a aba 1 pode ter mudado sem a aba 3 avisar.
procedure TpnlCalculoConvert.Entrar;
begin
  pRecalcular;
  if Assigned(FFuturaGrid) then
    FFuturaGrid.Entrar
  else if Assigned(FFutura) then
    FFutura.Entrar;
end;

procedure TpnlCalculoConvert.AplicarEstado;
begin
  if Assigned(FFuturaGrid) then
    FFuturaGrid.AplicarEstado
  else if Assigned(FFutura) then
    FFutura.AplicarEstado;
end;

end.
