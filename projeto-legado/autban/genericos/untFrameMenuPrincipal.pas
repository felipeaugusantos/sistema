unit untFrameMenuPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls;

type
  TfrmFrameMenuPrincipal = class(TFrame)
    trvMenu: TTreeView;
  private
    { Private declarations }
  public
    procedure AdicionaMenuBancoDoBrasilPagForAPI;
    procedure AdicionaMenuItauAPIPix;
    procedure AdicionaMenuSicoobAPIPix;
    procedure AdicionaMenuSantanderAPIPix;
    procedure AdicionaMenuJpiFidc;
    procedure AdicionaMenuBradescoAPIPix;
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TfrmFrameMenuPrincipal }

procedure TfrmFrameMenuPrincipal.AdicionaMenuBancoDoBrasilPagForAPI;
  Var
    LMenuPagar,
    LMenuBanco: TTreeNode;
begin
  For LMenuPagar In trvMenu.Items Do
  Begin
    If LMenuPagar.Text = 'Contas a Pagar > mnuCtaPagar' Then
    Begin
      trvMenu.Items.AddChild(LMenuPagar, '001 - Banco do Brasil [Online] > mnuCtaBBApi');

      LMenuBanco := LMenuPagar.GetLastChild;

      trvMenu.Items.AddChild(LMenuBanco, 'Configuração > frmConfigBBCtaApi');
      trvMenu.Items.AddChild(LMenuBanco, 'Geração de Duplicatas > frmGerDupBBCtaApi');
      trvMenu.Items.AddChild(LMenuBanco, 'Relatório de Duplicatas para Remessa > frmRelDupRemBBCtaApi');
      trvMenu.Items.AddChild(LMenuBanco, 'Cancelamento de Duplicatas para Remessa > frmEstBBCtaApi');
      trvMenu.Items.AddChild(LMenuBanco, 'Envia Remessa para o Banco > frmEnviaRemBBCtaApi');
      trvMenu.Items.AddChild(LMenuBanco, 'Cancelamento de Duplicatas enviadas para o Banco > frmEstEnvBBCtaApi');
      trvMenu.Items.AddChild(LMenuBanco, 'Importar Pagamentos > frmArqRetBBCtaApi');
      trvMenu.Items.AddChild(LMenuBanco, 'Relatório Pagamentos Importados > frmRelArqRetBBCtaApi');
      trvMenu.Items.AddChild(LMenuBanco, 'Atualização/Baixa Automática de Duplicatas > frmBaiAutDupBBCtaApi');

      Break;
    End;
  End;
end;

procedure TfrmFrameMenuPrincipal.AdicionaMenuBradescoAPIPix;
  Var
    LMenuBanco: TTreeNode;
begin
  trvMenu.Items.AddChild(trvMenu.Items[0], '237 - Bradesco [Online] > mnuBradescoApi');

  LMenuBanco := trvMenu.Items[0].GetLastChild;

  trvMenu.Items.AddChild(LMenuBanco, 'Configuração > frmConfigBradescoApi');
  trvMenu.Items.AddChild(LMenuBanco, 'Cancelar Boletos > frmCancelarBradescoApi');
  trvMenu.Items.AddChild(LMenuBanco, 'Importar Boletos > frmArqRetBradescoApi');
  trvMenu.Items.AddChild(LMenuBanco, 'Relatório de Boletos > frmRelRetBradescoApi');
  trvMenu.Items.AddChild(LMenuBanco, 'Atualização/Baixa Automática de Duplicatas > frmBaiAutDupBradescoApi');
end;

procedure TfrmFrameMenuPrincipal.AdicionaMenuItauAPIPix;
  Var
    LMenuBanco: TTreeNode;
begin
  trvMenu.Items.AddChild(trvMenu.Items[0], '341 - Itaú [Online] > mnuItauApi');

  LMenuBanco := trvMenu.Items[0].GetLastChild;

  trvMenu.Items.AddChild(LMenuBanco, 'Configuração > frmConfigItauApi');
  trvMenu.Items.AddChild(LMenuBanco, 'Cancelar Boletos > frmCancelarItauApi');
  trvMenu.Items.AddChild(LMenuBanco, 'Importar Boletos > frmArqRetItauApi');
  trvMenu.Items.AddChild(LMenuBanco, 'Relatório de Boletos > frmRelRetItauApi');
  trvMenu.Items.AddChild(LMenuBanco, 'Atualização/Baixa Automática de Duplicatas > frmBaiAutDupItauApi');
end;

procedure TfrmFrameMenuPrincipal.AdicionaMenuJpiFidc;
var
    LMenuReceber,
    LMenuBanco: TTreeNode;
begin
  For LMenuReceber In trvMenu.Items Do
  Begin
    If LMenuReceber.Text = 'Contas a Receber > mnuCtaReceber' Then
    Begin
      trvMenu.Items.AddChild(LMenuReceber, '906 - Banco FIDC > mnuCtaJpiFidc');

      LMenuBanco := LMenuReceber.GetLastChild;

      trvMenu.Items.AddChild(LMenuBanco, 'Configuração > frmConfigBancoJpiFidc');
      trvMenu.Items.AddChild(LMenuBanco, 'Geração de Duplicatas > frmGerDupBancoJpiFidc');
      trvMenu.Items.AddChild(LMenuBanco, 'Relatório de Duplicatas para Remessa > frmRelDupRemBancoJpiFidc');
      trvMenu.Items.AddChild(LMenuBanco, 'Cancelamento de Duplicatas para Remessa > frmEstBancoJpiFidc');
      trvMenu.Items.AddChild(LMenuBanco, 'Exporta Arquivo Remessa > frmExpArqRemBancoJpiFidc');
      trvMenu.Items.AddChild(LMenuBanco, 'Cancelamento de Duplicatas enviadas para o Banco > frmEstEnvBancoJpiFidc');
      trvMenu.Items.AddChild(LMenuBanco, 'Importa Arquivo Retorno > frmArqRetBancoJpiFidc');
      trvMenu.Items.AddChild(LMenuBanco, 'Relatório Arquivo Retorno > frmRelArqRetBancoJpiFidc');
      trvMenu.Items.AddChild(LMenuBanco, 'Atualização/Baixa Automática de Duplicatas > frmBaiAutDupBancoJpiFidc');

      Break;
    End;
  End;
end;

procedure TfrmFrameMenuPrincipal.AdicionaMenuSantanderAPIPix;
  Var
    LMenuBanco: TTreeNode;
begin
  trvMenu.Items.AddChild(trvMenu.Items[0], '033 - Santander [Online] > mnuSantanderApi');

  LMenuBanco := trvMenu.Items[0].GetLastChild;

  trvMenu.Items.AddChild(LMenuBanco, 'Configuração > frmConfigSantanderApi');
  trvMenu.Items.AddChild(LMenuBanco, 'Cancelar Boletos > frmCancelarSantanderApi');
  trvMenu.Items.AddChild(LMenuBanco, 'Importar Boletos > frmArqRetSantanderApi');
  trvMenu.Items.AddChild(LMenuBanco, 'Relatório de Boletos > frmRelRetSantanderApi');
  trvMenu.Items.AddChild(LMenuBanco, 'Atualização/Baixa Automática de Duplicatas > frmBaiAutDupSantanderApi');
end;

procedure TfrmFrameMenuPrincipal.AdicionaMenuSicoobAPIPix;
  Var
    LMenuBanco: TTreeNode;
begin
  trvMenu.Items.AddChild(trvMenu.Items[0], '756 - Sicoob [Online] > mnuSicoobApi');

  LMenuBanco := trvMenu.Items[0].GetLastChild;

  trvMenu.Items.AddChild(LMenuBanco, 'Configuração > frmConfigSicoobApi');
  trvMenu.Items.AddChild(LMenuBanco, 'Cancelar Boletos > frmCancelarSicoobApi');
  trvMenu.Items.AddChild(LMenuBanco, 'Importar Boletos > frmArqRetSicoobApi');
  trvMenu.Items.AddChild(LMenuBanco, 'Relatório de Boletos > frmRelRetSicoobApi');
  trvMenu.Items.AddChild(LMenuBanco, 'Atualização/Baixa Automática de Duplicatas > frmBaiAutDupSicoobApi');
end;

end.
