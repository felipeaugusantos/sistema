{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************PH*}
unit untAuttinMenuItemKillingIndustrial;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoKillingIndustrialCores;

type
  TAuttinMenuItemKillingIndustrial = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesKillingIndustrial = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesKillingIndustrial = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaKillingIndustrial = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaKillingIndustrial = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasKillingIndustrial = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroMontadoraKillingIndustrial = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;


implementation

uses
  untConfiguradorKillingIndustrial, untLibTintaFactory, untGravandoExecucaoKillingIndustrialNovasFormulas, untCadastroBasesKillingIndustrial,
  untGravandoExecucaoKillingIndustrialBases, untCadastroNovasFormulasKillingIndustrial,
  untCadastroMontadoraKillingIndustrial, untGravandoExecucaoKillingIndustrialLinha, untGravandoExecucaoKillingIndustrialOrigem,
  untGravandoExecucaoKillingIndustrialMontadora;

{ TAuttinMenuItemKillingIndustrial }

constructor TAuttinMenuItemKillingIndustrial.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesKillingIndustrial.Create());
  Self.Adicionar(TCadastroBasesKillingIndustrial.Create());
  Self.Adicionar(TCadastroNovasFormulasKillingIndustrial.Create());
  Self.Adicionar(TCadastroMontadoraKillingIndustrial.Create());
  Self.Adicionar(TGeracaoTintaKillingIndustrial.Create());
  Self.Adicionar(TConsultaKillingIndustrial.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesKillingIndustrial }

constructor TConfiguracoesKillingIndustrial.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesKillingIndustrial');
end;

procedure TConfiguracoesKillingIndustrial.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorKillingIndustrial.Create(auttinWrapper));
end;

{ TCadastroBasesKillingIndustrial }

constructor TCadastroBasesKillingIndustrial.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadKINBase');
end;

procedure TCadastroBasesKillingIndustrial.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesKillingIndustrial.TCadastroBasesKillingIndustrial.Create());
end;

{ TConsultaKillingIndustrial }

constructor TConsultaKillingIndustrial.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaKillingIndustrial');
end;

procedure TConsultaKillingIndustrial.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaKillingIndustrial }

constructor TGeracaoTintaKillingIndustrial.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadKINGeraArquivo');
end;

procedure TGeracaoTintaKillingIndustrial.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Killing Industrial', [
    TGravandoExecucaoKillingIndustrialMontadora.Create,
    TGravandoExecucaoKillingIndustrialBases.Create,
    TGravandoExecucaoKillingIndustrialLinha.Create,
    TGravandoExecucaoKillingIndustrialOrigem.Create,
    TGravandoExecucaoKillingIndustrialCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadKINGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Killing Industrial', [
    TGravandoExecucaoKillingIndustrialNovasFormulas.Create
  ]);
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasKillingIndustrial.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadKINNovasFormulas');
end;

procedure TCadastroNovasFormulasKillingIndustrial.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasKillingIndustrial.TCadastroNovasFormulasKillingIndustrial.Create);
end;

{ TCadastroMontadoraKillingIndustrial }

constructor TCadastroMontadoraKillingIndustrial.Create;
begin
  inherited Create('Cadastro de Montadora', 'frmCadKINMontadora');
end;

procedure TCadastroMontadoraKillingIndustrial.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroMontadoraKillingIndustrial.TCadastroMontadoraKillingIndustrial.Create);
end;

end.
