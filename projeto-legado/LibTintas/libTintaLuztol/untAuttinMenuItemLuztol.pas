{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemLuztol;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoLuztolCores,
  untGravandoExecucaoLuztolColorantes;

type
  TAuttinMenuItemLuztol = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesLuztol = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesLuztol = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesLuztol = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaLuztol = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaLuztol = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasLuztol = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorLuztol, untLibTintaFactory, untGravandoExecucaoLuztolNovasFormulas, untCadastroBasesLuztol, 
  untCadastroColorantesLuztol, untGravandoExecucaoLuztolBases, 
  untCadastroNovasFormulasLuztol;

{ TAuttinMenuItemLuztol }

constructor TAuttinMenuItemLuztol.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesLuztol.Create());
  Self.Adicionar(TCadastroBasesLuztol.Create());
  Self.Adicionar(TCadastroColorantesLuztol.Create());
  Self.Adicionar(TCadastroNovasFormulasLuztol.Create());
  Self.Adicionar(TGeracaoTintaLuztol.Create());
  Self.Adicionar(TConsultaLuztol.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesLuztol }

constructor TConfiguracoesLuztol.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesLuztol');
end;

procedure TConfiguracoesLuztol.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorLuztol.Create(auttinWrapper));
end;

{ TCadastroBasesLuztol }

constructor TCadastroBasesLuztol.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadLUZBase');
end;

procedure TCadastroBasesLuztol.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesLuztol.TCadastroBasesLuztol.Create());
end;

{ TConsultaLuztol }

constructor TConsultaLuztol.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaLuztol');
end;

procedure TConsultaLuztol.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaLuztol }

constructor TGeracaoTintaLuztol.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadLUZGeraArquivo');
end;

procedure TGeracaoTintaLuztol.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Luztol', [
    TGravandoExecucaoLuztolColorantes.Create,
    TGravandoExecucaoLuztolBases.Create,
    TGravandoExecucaoLuztolCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadLUZGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Luztol Imobiliária', [
    TGravandoExecucaoLuztolNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesLuztol }

constructor TCadastroColorantesLuztol.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadLUZColorantes');
end;

procedure TCadastroColorantesLuztol.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesLuztol.TCadastroColorantesLuztol.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasLuztol.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadLUZNovasFormulas');  
end;

procedure TCadastroNovasFormulasLuztol.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasLuztol.TCadastroNovasFormulasLuztol.Create);
end;

end.
