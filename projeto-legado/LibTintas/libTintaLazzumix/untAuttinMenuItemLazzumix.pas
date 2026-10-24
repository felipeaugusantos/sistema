{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************PH*}
unit untAuttinMenuItemLazzumix;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoLazzumixCores;

type
  TAuttinMenuItemLazzumix = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesLazzumix = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesLazzumix = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaLazzumix = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaLazzumix = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasLazzumix = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorLazzumix, untLibTintaFactory, untGravandoExecucaoLazzumixNovasFormulas, untCadastroBasesLazzumix,
  untGravandoExecucaoLazzumixBases, untGravandoExecucaoLazzumixPersonalizadas, untCadastroNovasFormulasLazzumix;

{ TAuttinMenuItemLazzumix }

constructor TAuttinMenuItemLazzumix.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta + ' / HSMIX', 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesLazzumix.Create());
  Self.Adicionar(TCadastroBasesLazzumix.Create());
  Self.Adicionar(TCadastroNovasFormulasLazzumix.Create());
  Self.Adicionar(TGeracaoTintaLazzumix.Create());
  Self.Adicionar(TConsultaLazzumix.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesLazzumix }

constructor TConfiguracoesLazzumix.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesLazzumix');
end;

procedure TConfiguracoesLazzumix.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorLazzumix.Create(auttinWrapper));
end;

{ TCadastroBasesLazzumix }

constructor TCadastroBasesLazzumix.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadMixBase');
end;

procedure TCadastroBasesLazzumix.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesLazzumix.TCadastroBasesLazzumix.Create());
end;

{ TConsultaLazzumix }

constructor TConsultaLazzumix.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaLazzumix');
end;

procedure TConsultaLazzumix.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaLazzumix }

constructor TGeracaoTintaLazzumix.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadMixGeraArquivo');
end;

procedure TGeracaoTintaLazzumix.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Lazzumix', [
    TGravandoExecucaoLazzumixBases.Create,
    TGravandoExecucaoLazzumixCores.Create,
    TGravandoExecucaoLazzumixPersonalizadas.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadMixGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Lazzumix', [
    TGravandoExecucaoLazzumixNovasFormulas.Create
  ]);
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasLazzumix.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadMixNovasFormulas');
end;

procedure TCadastroNovasFormulasLazzumix.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasLazzumix.TCadastroNovasFormulasLazzumix.Create);
end;

end.
