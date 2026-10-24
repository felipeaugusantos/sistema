{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemBlascorAutomotiva;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoBlascorAutomotivaBases,
  untGravandoExecucaoBlascorAutomotivaCores,
  untGravandoExecucaoBlascorAutomotivaLinhas;

type
  TAuttinMenuItemBlascorAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesBlascorAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesBlascorAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaBlascorAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaBlascorAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasBlascorAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroMontadoraBlascorAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroLinhaBlascorAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorBlascorAutomotiva, untLibTintaFactory, untGravandoExecucaoBlascorAutomotivaNovasFormulas, untCadastroBasesBlascorAutomotiva,
  untCadastroNovasFormulasBlascorAutomotiva, untCadastroLinhaBlascorAutomotiva, untCadastroMontadoraBlascorAutomotiva,
  untGravandoExecucaoBlascorAutomotivaMontadoras;

{ TAuttinMenuItemBlascorAutomotiva }

constructor TAuttinMenuItemBlascorAutomotiva.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesBlascorAutomotiva.Create());
  Self.Adicionar(TCadastroBasesBlascorAutomotiva.Create());
  Self.Adicionar(TCadastroLinhaBlascorAutomotiva.Create());
  Self.Adicionar(TCadastroNovasFormulasBlascorAutomotiva.Create());
  Self.Adicionar(TCadastroMontadoraBlascorAutomotiva.Create());
  Self.Adicionar(TGeracaoTintaBlascorAutomotiva.Create());
  Self.Adicionar(TConsultaBlascorAutomotiva.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());

end;

{ TConfiguracoesBlascorAutomotiva }

constructor TConfiguracoesBlascorAutomotiva.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesBlascorAutomotiva');
end;

procedure TConfiguracoesBlascorAutomotiva.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorBlascorAutomotiva.Create(auttinWrapper));
end;

{ TCadastroBasesBlascorAutomotiva }

constructor TCadastroBasesBlascorAutomotiva.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadBLABase');
end;

procedure TCadastroBasesBlascorAutomotiva.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesBlascorAutomotiva.TCadastroBasesBlascorAutomotiva.Create());
end;

{ TConsultaBlascorAutomotiva }

constructor TConsultaBlascorAutomotiva.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaBlascorAutomotiva');
end;

procedure TConsultaBlascorAutomotiva.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;


{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadBLAGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Blascor Automotiva', [
    TGravandoExecucaoBlascorAutomotivaNovasFormulas.Create
  ]);
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasBlascorAutomotiva.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadBLANovasFormulas');
end;

procedure TCadastroNovasFormulasBlascorAutomotiva.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasBlascorAutomotiva.TCadastroNovasFormulasBlascorAutomotiva.Create);
end;

{ TGeracaoTintaBlascorAutomotiva }

constructor TGeracaoTintaBlascorAutomotiva.Create;
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadBLAGeraArquivo');
end;

procedure TGeracaoTintaBlascorAutomotiva.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Blascor Automotiva', [
    TGravandoExecucaoBlascorAutomotivaBases.Create,
    TGravandoExecucaoBlascorAutomotivaLinhas.Create,
    TGravandoExecucaoBlascorAutomotivaMontadoras.Create,
    TGravandoExecucaoBlascorAutomotivaCores.Create
  ]);
end;

{ TCadastroMontadoraBlascorAutomotiva }

constructor TCadastroMontadoraBlascorAutomotiva.Create;
begin
  inherited Create('Cadastro de Montadora', 'frmCadBLAMontadora');
end;

procedure TCadastroMontadoraBlascorAutomotiva.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroMontadoraBlascorAutomotiva.TCadastroMontadoraBlascorAutomotiva.Create);
end;

{ TCadastroLinhaBlascorAutomotiva }

constructor TCadastroLinhaBlascorAutomotiva.Create;
begin
  inherited Create('Cadastro de Linhas', 'frmCadBLALinha');
end;

procedure TCadastroLinhaBlascorAutomotiva.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroLinhaBlascorAutomotiva.TCadastroLinhaBlascorAutomotiva.Create);
end;

end.
