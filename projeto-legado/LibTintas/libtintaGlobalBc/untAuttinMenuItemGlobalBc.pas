{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemGlobalBc;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoGlobalBcCores,
  untGravandoExecucaoGlobalBcColorantes;

type
  TAuttinMenuItemGlobalBc = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesGlobalBc = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesGlobalBc = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesGlobalBc = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaGlobalBc = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaGlobalBc = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasGlobalBc = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorGlobalBc, untLibTintaFactory, untGravandoExecucaoGlobalBcNovasFormulas, untCadastroBasesGlobalBc, 
  untCadastroColorantesGlobalBc, untGravandoExecucaoGlobalBcBases, 
  untCadastroNovasFormulasGlobalBc;

{ TAuttinMenuItemGlobalBc }

constructor TAuttinMenuItemGlobalBc.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesGlobalBc.Create());
  Self.Adicionar(TCadastroBasesGlobalBc.Create());
  Self.Adicionar(TCadastroColorantesGlobalBc.Create());
  Self.Adicionar(TCadastroNovasFormulasGlobalBc.Create());
  Self.Adicionar(TGeracaoTintaGlobalBc.Create());
  Self.Adicionar(TConsultaGlobalBc.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesGlobalBc }

constructor TConfiguracoesGlobalBc.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesGlobalBc');
end;

procedure TConfiguracoesGlobalBc.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorGlobalBc.Create(auttinWrapper));
end;

{ TCadastroBasesGlobalBc }

constructor TCadastroBasesGlobalBc.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadGBCBase');
end;

procedure TCadastroBasesGlobalBc.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesGlobalBc.TCadastroBasesGlobalBc.Create());
end;

{ TConsultaGlobalBc }

constructor TConsultaGlobalBc.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaGlobalBc');
end;

procedure TConsultaGlobalBc.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaGlobalBc }

constructor TGeracaoTintaGlobalBc.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadGBCGeraArquivo');
end;

procedure TGeracaoTintaGlobalBc.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('GlobalBc', [
    TGravandoExecucaoGlobalBcColorantes.Create,
    TGravandoExecucaoGlobalBcBases.Create,
    TGravandoExecucaoGlobalBcCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadGBCGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('GlobalBc Imobiliária', [
    TGravandoExecucaoGlobalBcNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesGlobalBc }

constructor TCadastroColorantesGlobalBc.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadGBCColorantes');
end;

procedure TCadastroColorantesGlobalBc.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesGlobalBc.TCadastroColorantesGlobalBc.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasGlobalBc.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadGBCNovasFormulas');  
end;

procedure TCadastroNovasFormulasGlobalBc.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasGlobalBc.TCadastroNovasFormulasGlobalBc.Create);
end;


end.
