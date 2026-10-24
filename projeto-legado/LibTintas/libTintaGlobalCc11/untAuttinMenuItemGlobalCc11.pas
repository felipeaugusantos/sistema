{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemGlobalCc11;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoGlobalCc11Cores,
  untGravandoExecucaoGlobalCc11Colorantes;

type
  TAuttinMenuItemGlobalCc11 = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesGlobalCc11 = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesGlobalCc11 = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesGlobalCc11 = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaGlobalCc11 = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaGlobalCc11 = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasGlobalCc11 = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorGlobalCc11, untLibTintaFactory, untGravandoExecucaoGlobalCc11NovasFormulas, untCadastroBasesGlobalCc11, 
  untCadastroColorantesGlobalCc11, untGravandoExecucaoGlobalCc11Bases, 
  untCadastroNovasFormulasGlobalCc11;

{ TAuttinMenuItemGlobalCc11 }

constructor TAuttinMenuItemGlobalCc11.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesGlobalCc11.Create());
  Self.Adicionar(TCadastroBasesGlobalCc11.Create());
  Self.Adicionar(TCadastroColorantesGlobalCc11.Create());
  Self.Adicionar(TCadastroNovasFormulasGlobalCc11.Create());
  Self.Adicionar(TGeracaoTintaGlobalCc11.Create());
  Self.Adicionar(TConsultaGlobalCc11.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesGlobalCc11 }

constructor TConfiguracoesGlobalCc11.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesGlobalCc11');
end;

procedure TConfiguracoesGlobalCc11.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorGlobalCc11.Create(auttinWrapper));
end;

{ TCadastroBasesGlobalCc11 }

constructor TCadastroBasesGlobalCc11.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadC11Base');
end;

procedure TCadastroBasesGlobalCc11.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesGlobalCc11.TCadastroBasesGlobalCc11.Create());
end;

{ TConsultaGlobalCc11 }

constructor TConsultaGlobalCc11.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaGlobalCc11');
end;

procedure TConsultaGlobalCc11.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaGlobalCc11 }

constructor TGeracaoTintaGlobalCc11.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadC11GeraArquivo');
end;

procedure TGeracaoTintaGlobalCc11.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('GlobalCc11', [
    TGravandoExecucaoGlobalCc11Colorantes.Create,
    TGravandoExecucaoGlobalCc11Bases.Create,
    TGravandoExecucaoGlobalCc11Cores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadC11GeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('GlobalCc11 Imobiliária', [
    TGravandoExecucaoGlobalCc11NovasFormulas.Create
  ]);
end;

{ TCadastroColorantesGlobalCc11 }

constructor TCadastroColorantesGlobalCc11.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadC11Colorantes');
end;

procedure TCadastroColorantesGlobalCc11.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesGlobalCc11.TCadastroColorantesGlobalCc11.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasGlobalCc11.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadC11NovasFormulas');  
end;

procedure TCadastroNovasFormulasGlobalCc11.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasGlobalCc11.TCadastroNovasFormulasGlobalCc11.Create);
end;


end.
