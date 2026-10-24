{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************PH*}
unit untAuttinMenuItemVelutexImobiliaria;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoVelutexImobiliariaCores,
  untGravandoExecucaoVelutexImobiliariaColorantes;

type
  TAuttinMenuItemVelutexImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesVelutexImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesVelutexImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesVelutexImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaVelutexImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaVelutexImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasVelutexImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorVelutexImobiliaria, untLibTintaFactory, untGravandoExecucaoVelutexImobiliariaNovasFormulas,
  untCadastroBasesVelutexImobiliaria, untCadastroColorantesVelutexImobiliaria, untGravandoExecucaoVelutexImobiliariaBases,
  untCadastroNovasFormulasVelutexImobiliaria;

{ TAuttinMenuItemVelutexImobiliaria }

constructor TAuttinMenuItemVelutexImobiliaria.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesVelutexImobiliaria.Create());
  Self.Adicionar(TCadastroBasesVelutexImobiliaria.Create());
  Self.Adicionar(TCadastroColorantesVelutexImobiliaria.Create());
  Self.Adicionar(TCadastroNovasFormulasVelutexImobiliaria.Create());
  Self.Adicionar(TGeracaoTintaVelutexImobiliaria.Create());
  Self.Adicionar(TConsultaVelutexImobiliaria.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesVelutexImobiliaria }

constructor TConfiguracoesVelutexImobiliaria.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesVelutexImobiliaria');
end;

procedure TConfiguracoesVelutexImobiliaria.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorVelutexImobiliaria.Create(auttinWrapper));
end;

{ TCadastroBasesVelutexImobiliaria }

constructor TCadastroBasesVelutexImobiliaria.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadVelBase');
end;

procedure TCadastroBasesVelutexImobiliaria.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesVelutexImobiliaria.TCadastroBasesVelutexImobiliaria.Create());
end;

{ TConsultaVelutexImobiliaria }

constructor TConsultaVelutexImobiliaria.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaVelutexImobiliaria');
end;

procedure TConsultaVelutexImobiliaria.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaVelutexImobiliaria }

constructor TGeracaoTintaVelutexImobiliaria.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadVelGerarArquivos');
end;

procedure TGeracaoTintaVelutexImobiliaria.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Velutex Imobiliaria', [
    TGravandoExecucaoVelutexImobiliariaColorantes.Create,
    TGravandoExecucaoVelutexImobiliariaBases.Create,
    TGravandoExecucaoVelutexImobiliariaCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadVelGeraNfm1')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Velutex Imobiliaria', [
    TGravandoExecucaoVelutexImobiliariaNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesVelutexImobiliaria }

constructor TCadastroColorantesVelutexImobiliaria.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadVelColorantes');
end;

procedure TCadastroColorantesVelutexImobiliaria.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesVelutexImobiliaria.TCadastroColorantesVelutexImobiliaria.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasVelutexImobiliaria.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadVelNovasFormulas');
end;

procedure TCadastroNovasFormulasVelutexImobiliaria.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasVelutexImobiliaria.TCadastroNovasFormulasVelutexImobiliaria.Create);
end;

end.
