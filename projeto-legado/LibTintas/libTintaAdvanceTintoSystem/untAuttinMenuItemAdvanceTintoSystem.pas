{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemAdvanceTintoSystem;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoAdvanceTintoSystemCores,
  untGravandoExecucaoAdvanceTintoSystemColorantes, untGravandoExecucaoAdvanceTintoSystemEmbalagem;

type
  TAuttinMenuItemAdvanceTintoSystem = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesAdvanceTintoSystem = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesAdvanceTintoSystem = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesAdvanceTintoSystem = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaAdvanceTintoSystem = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaAdvanceTintoSystem = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasAdvanceTintoSystem = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroEmbalagensAdvanceTintoSystem = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorAdvanceTintoSystem, untLibTintaFactory, untGravandoExecucaoAdvanceTintoSystemNovasFormulas, untCadastroBasesAdvanceTintoSystem, 
  untCadastroColorantesAdvanceTintoSystem, untGravandoExecucaoAdvanceTintoSystemBases,
  untCadastroNovasFormulasAdvanceTintoSystem, untCadastroEmbalagensAdvanceTintoSystem;

{ TAuttinMenuItemAdvanceTintoSystem }

constructor TAuttinMenuItemAdvanceTintoSystem.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesAdvanceTintoSystem.Create());
  Self.Adicionar(TCadastroBasesAdvanceTintoSystem.Create());
  Self.Adicionar(TCadastroColorantesAdvanceTintoSystem.Create());
  Self.Adicionar(TCadastroEmbalagensAdvanceTintoSystem.Create());
  Self.Adicionar(TCadastroNovasFormulasAdvanceTintoSystem.Create());
  Self.Adicionar(TGeracaoTintaAdvanceTintoSystem.Create());
  Self.Adicionar(TConsultaAdvanceTintoSystem.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesAdvanceTintoSystem }

constructor TConfiguracoesAdvanceTintoSystem.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesAdvanceTintoSystem');
end;

procedure TConfiguracoesAdvanceTintoSystem.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorAdvanceTintoSystem.Create(auttinWrapper));
end;

{ TCadastroBasesAdvanceTintoSystem }

constructor TCadastroBasesAdvanceTintoSystem.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadADTBase');
end;

procedure TCadastroBasesAdvanceTintoSystem.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesAdvanceTintoSystem.TCadastroBasesAdvanceTintoSystem.Create());
end;

{ TConsultaAdvanceTintoSystem }

constructor TConsultaAdvanceTintoSystem.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaAdvanceTintoSystem');
end;

procedure TConsultaAdvanceTintoSystem.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaAdvanceTintoSystem }

constructor TGeracaoTintaAdvanceTintoSystem.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadADTGeraArquivo');
end;

procedure TGeracaoTintaAdvanceTintoSystem.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Advance TintoSystem Imobiliária', [
    TGravandoExecucaoAdvanceTintoSystemColorantes.Create,
    TGravandoExecucaoAdvanceTintoSystemBases.Create,
    TGravandoExecucaoAdvanceTintoSystemCores.Create,
    TGravandoExecucaoAdvanceTintoSystemEmbalagem.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadADTGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Advance TintoSystem Imobiliária', [
    TGravandoExecucaoAdvanceTintoSystemNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesAdvanceTintoSystem }

constructor TCadastroColorantesAdvanceTintoSystem.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadADTColorantes');
end;

procedure TCadastroColorantesAdvanceTintoSystem.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesAdvanceTintoSystem.TCadastroColorantesAdvanceTintoSystem.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasAdvanceTintoSystem.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadADTNovasFormulas');
end;

procedure TCadastroNovasFormulasAdvanceTintoSystem.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasAdvanceTintoSystem.TCadastroNovasFormulasAdvanceTintoSystem.Create);
end;

{ TCadastroEmbalagensAdvanceTintoSystem }

constructor TCadastroEmbalagensAdvanceTintoSystem.Create;
begin
  inherited Create('Cadastro de Embalagens', 'frmCadADTEmbalagens');
end;

procedure TCadastroEmbalagensAdvanceTintoSystem.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroEmbalagensAdvanceTintoSystem.TCadastroEmbalagensAdvanceTintoSystem.Create);
end;

end.
