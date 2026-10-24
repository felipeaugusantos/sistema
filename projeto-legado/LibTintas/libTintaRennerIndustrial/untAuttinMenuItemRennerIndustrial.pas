{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemRennerIndustrial;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoRennerIndustrialCores,
  untGravandoExecucaoRennerIndustrialColorantes;

type
  TAuttinMenuItemRennerIndustrial = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesRennerIndustrial = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesRennerIndustrial = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesRennerIndustrial = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaRennerIndustrial = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaRennerIndustrial = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasRennerIndustrial = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroEmbalagensRennerIndustrial = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorRennerIndustrial, untLibTintaFactory, untGravandoExecucaoRennerIndustrialNovasFormulas, untCadastroBasesRennerIndustrial, 
  untCadastroColorantesRennerIndustrial, untGravandoExecucaoRennerIndustrialBases, 
  untCadastroNovasFormulasRennerIndustrial, untCadastroEmbalagensRennerIndustrial;

{ TAuttinMenuItemRennerIndustrial }

constructor TAuttinMenuItemRennerIndustrial.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesRennerIndustrial.Create());
  Self.Adicionar(TCadastroBasesRennerIndustrial.Create());
  Self.Adicionar(TCadastroColorantesRennerIndustrial.Create());
  Self.Adicionar(TCadastroEmbalagensRennerIndustrial.Create());
  Self.Adicionar(TCadastroNovasFormulasRennerIndustrial.Create());
  Self.Adicionar(TGeracaoTintaRennerIndustrial.Create());
  Self.Adicionar(TConsultaRennerIndustrial.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesRennerIndustrial }

constructor TConfiguracoesRennerIndustrial.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesRennerIndustrial');
end;

procedure TConfiguracoesRennerIndustrial.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorRennerIndustrial.Create(auttinWrapper));
end;

{ TCadastroBasesRennerIndustrial }

constructor TCadastroBasesRennerIndustrial.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadRENBase');
end;

procedure TCadastroBasesRennerIndustrial.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesRennerIndustrial.TCadastroBasesRennerIndustrial.Create());
end;

{ TConsultaRennerIndustrial }

constructor TConsultaRennerIndustrial.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaRennerIndustrial');
end;

procedure TConsultaRennerIndustrial.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaRennerIndustrial }

constructor TGeracaoTintaRennerIndustrial.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadRENGeraArquivo');
end;

procedure TGeracaoTintaRennerIndustrial.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Renner Industrial', [
    TGravandoExecucaoRennerIndustrialColorantes.Create,
    TGravandoExecucaoRennerIndustrialBases.Create,
    TGravandoExecucaoRennerIndustrialCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadRENGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Renner Industrial', [
    TGravandoExecucaoRennerIndustrialNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesRennerIndustrial }

constructor TCadastroColorantesRennerIndustrial.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadRENColorantes');
end;

procedure TCadastroColorantesRennerIndustrial.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesRennerIndustrial.TCadastroColorantesRennerIndustrial.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasRennerIndustrial.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadRENNovasFormulas');  
end;

procedure TCadastroNovasFormulasRennerIndustrial.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasRennerIndustrial.TCadastroNovasFormulasRennerIndustrial.Create);
end;

{ TCadastroEmbalagensRennerIndustrial }

constructor TCadastroEmbalagensRennerIndustrial.Create;
begin
  inherited Create('Cadastro de Embalagens', 'frmCadRENEmbalagens');
end;

procedure TCadastroEmbalagensRennerIndustrial.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroEmbalagensRennerIndustrial.TCadastroEmbalagensRennerIndustrial.Create);
end;

end.
