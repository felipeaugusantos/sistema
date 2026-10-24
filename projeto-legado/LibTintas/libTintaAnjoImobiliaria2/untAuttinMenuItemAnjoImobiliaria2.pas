{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemAnjoImobiliaria2;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoAnjoImobiliaria2Cores,
  untGravandoExecucaoAnjoImobiliaria2Colorantes;

type
  TAuttinMenuItemAnjoImobiliaria2 = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesAnjoImobiliaria2 = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesAnjoImobiliaria2 = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesAnjoImobiliaria2 = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaAnjoImobiliaria2 = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaAnjoImobiliaria2 = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasAnjoImobiliaria2 = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorAnjoImobiliaria2, untLibTintaFactory, untGravandoExecucaoAnjoImobiliaria2NovasFormulas, untCadastroBasesAnjoImobiliaria2, 
  untCadastroColorantesAnjoImobiliaria2, untGravandoExecucaoAnjoImobiliaria2Bases, 
  untCadastroNovasFormulasAnjoImobiliaria2;

{ TAuttinMenuItemAnjoImobiliaria2 }

constructor TAuttinMenuItemAnjoImobiliaria2.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesAnjoImobiliaria2.Create());
  Self.Adicionar(TCadastroBasesAnjoImobiliaria2.Create());
  Self.Adicionar(TCadastroColorantesAnjoImobiliaria2.Create());
  Self.Adicionar(TCadastroNovasFormulasAnjoImobiliaria2.Create());
  Self.Adicionar(TGeracaoTintaAnjoImobiliaria2.Create());
  Self.Adicionar(TConsultaAnjoImobiliaria2.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesAnjoImobiliaria2 }

constructor TConfiguracoesAnjoImobiliaria2.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesAnjoImobiliaria2');
end;

procedure TConfiguracoesAnjoImobiliaria2.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorAnjoImobiliaria2.Create(auttinWrapper));
end;

{ TCadastroBasesAnjoImobiliaria2 }

constructor TCadastroBasesAnjoImobiliaria2.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadAN2Base');
end;

procedure TCadastroBasesAnjoImobiliaria2.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesAnjoImobiliaria2.TCadastroBasesAnjoImobiliaria2.Create());
end;

{ TConsultaAnjoImobiliaria2 }

constructor TConsultaAnjoImobiliaria2.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaAnjoImobiliaria2');
end;

procedure TConsultaAnjoImobiliaria2.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaAnjoImobiliaria2 }

constructor TGeracaoTintaAnjoImobiliaria2.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadAN2GeraArquivo');
end;

procedure TGeracaoTintaAnjoImobiliaria2.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('AnjoImobiliaria2', [
    TGravandoExecucaoAnjoImobiliaria2Colorantes.Create,
    TGravandoExecucaoAnjoImobiliaria2Bases.Create,
    TGravandoExecucaoAnjoImobiliaria2Cores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadAN2GeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('AnjoImobiliaria2 Imobiliária', [
    TGravandoExecucaoAnjoImobiliaria2NovasFormulas.Create
  ]);
end;

{ TCadastroColorantesAnjoImobiliaria2 }

constructor TCadastroColorantesAnjoImobiliaria2.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadAN2Colorantes');
end;

procedure TCadastroColorantesAnjoImobiliaria2.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesAnjoImobiliaria2.TCadastroColorantesAnjoImobiliaria2.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasAnjoImobiliaria2.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadAN2NovasFormulas');
end;

procedure TCadastroNovasFormulasAnjoImobiliaria2.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasAnjoImobiliaria2.TCadastroNovasFormulasAnjoImobiliaria2.Create);
end;

end.
