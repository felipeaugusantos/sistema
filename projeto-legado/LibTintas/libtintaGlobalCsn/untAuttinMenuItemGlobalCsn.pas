{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemGlobalCsn;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoGlobalCsnCores,
  untGravandoExecucaoGlobalCsnColorantes;

type
  TAuttinMenuItemGlobalCsn = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesGlobalCsn = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesGlobalCsn = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesGlobalCsn = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaGlobalCsn = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaGlobalCsn = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasGlobalCsn = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorGlobalCsn, untLibTintaFactory, untGravandoExecucaoGlobalCsnNovasFormulas, untCadastroBasesGlobalCsn, 
  untCadastroColorantesGlobalCsn, untGravandoExecucaoGlobalCsnBases, 
  untCadastroNovasFormulasGlobalCsn;

{ TAuttinMenuItemGlobalCsn }

constructor TAuttinMenuItemGlobalCsn.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesGlobalCsn.Create());
  Self.Adicionar(TCadastroBasesGlobalCsn.Create());
  Self.Adicionar(TCadastroColorantesGlobalCsn.Create());
  Self.Adicionar(TCadastroNovasFormulasGlobalCsn.Create());
  Self.Adicionar(TGeracaoTintaGlobalCsn.Create());
  Self.Adicionar(TConsultaGlobalCsn.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesGlobalCsn }

constructor TConfiguracoesGlobalCsn.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesGlobalCsn');
end;

procedure TConfiguracoesGlobalCsn.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorGlobalCsn.Create(auttinWrapper));
end;

{ TCadastroBasesGlobalCsn }

constructor TCadastroBasesGlobalCsn.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadCSNBase');
end;

procedure TCadastroBasesGlobalCsn.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesGlobalCsn.TCadastroBasesGlobalCsn.Create());
end;

{ TConsultaGlobalCsn }

constructor TConsultaGlobalCsn.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaGlobalCsn');
end;

procedure TConsultaGlobalCsn.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaGlobalCsn }

constructor TGeracaoTintaGlobalCsn.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadCSNGeraArquivo');
end;

procedure TGeracaoTintaGlobalCsn.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('GlobalCsn', [
    TGravandoExecucaoGlobalCsnColorantes.Create,
    TGravandoExecucaoGlobalCsnBases.Create,
    TGravandoExecucaoGlobalCsnCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadCSNGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('GlobalCsn Imobiliária', [
    TGravandoExecucaoGlobalCsnNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesGlobalCsn }

constructor TCadastroColorantesGlobalCsn.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadCSNColorantes');
end;

procedure TCadastroColorantesGlobalCsn.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesGlobalCsn.TCadastroColorantesGlobalCsn.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasGlobalCsn.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadCSNNovasFormulas');  
end;

procedure TCadastroNovasFormulasGlobalCsn.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasGlobalCsn.TCadastroNovasFormulasGlobalCsn.Create);
end;


end.
