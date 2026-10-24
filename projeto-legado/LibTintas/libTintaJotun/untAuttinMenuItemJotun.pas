{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************PH*}
unit untAuttinMenuItemJotun;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoJotunCores,
  untGravandoExecucaoJotunColorantes;

type
  TAuttinMenuItemJotun = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesJotun = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesJotun = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesJotun = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaJotun = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaJotun = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasJotun = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorJotun, untLibTintaFactory, untGravandoExecucaoJotunNovasFormulas, untCadastroBasesJotun, 
  untCadastroColorantesJotun, untGravandoExecucaoJotunBases, 
  untCadastroNovasFormulasJotun;

{ TAuttinMenuItemJotun }

constructor TAuttinMenuItemJotun.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesJotun.Create());
  Self.Adicionar(TCadastroBasesJotun.Create());
  Self.Adicionar(TCadastroColorantesJotun.Create());
  Self.Adicionar(TCadastroNovasFormulasJotun.Create());
  Self.Adicionar(TGeracaoTintaJotun.Create());
  Self.Adicionar(TConsultaJotun.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesJotun }

constructor TConfiguracoesJotun.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesJotun');
end;

procedure TConfiguracoesJotun.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorJotun.Create(auttinWrapper));
end;

{ TCadastroBasesJotun }

constructor TCadastroBasesJotun.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadJOTBase');
end;

procedure TCadastroBasesJotun.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesJotun.TCadastroBasesJotun.Create());
end;

{ TConsultaJotun }

constructor TConsultaJotun.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaJotun');
end;

procedure TConsultaJotun.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaJotun }

constructor TGeracaoTintaJotun.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadJOTGeraArquivo');
end;

procedure TGeracaoTintaJotun.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Jotun', [
    TGravandoExecucaoJotunColorantes.Create,
    TGravandoExecucaoJotunBases.Create,
    TGravandoExecucaoJotunCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadJOTGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Jotun', [
    TGravandoExecucaoJotunNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesJotun }

constructor TCadastroColorantesJotun.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadJOTColorantes');
end;

procedure TCadastroColorantesJotun.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesJotun.TCadastroColorantesJotun.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasJotun.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadJOTNovasFormulas');  
end;

procedure TCadastroNovasFormulasJotun.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasJotun.TCadastroNovasFormulasJotun.Create);
end;

end.
