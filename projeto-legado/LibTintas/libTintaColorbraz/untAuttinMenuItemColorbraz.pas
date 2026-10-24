{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************PH*}
unit untAuttinMenuItemColorbraz;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoColorbrazCores,
  untGravandoExecucaoColorbrazColorantes;

type
  TAuttinMenuItemColorbraz = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesColorbraz = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesColorbraz = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesColorbraz = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaColorbraz = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaColorbraz = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasColorbraz = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorColorbraz, untLibTintaFactory, untGravandoExecucaoColorbrazNovasFormulas, untCadastroBasesColorbraz,
  untCadastroColorantesColorbraz, untGravandoExecucaoColorbrazBases,
  untCadastroNovasFormulasColorbraz;

{ TAuttinMenuItemColorbraz }

constructor TAuttinMenuItemColorbraz.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesColorbraz.Create());
  Self.Adicionar(TCadastroBasesColorbraz.Create());
  Self.Adicionar(TCadastroColorantesColorbraz.Create());
  Self.Adicionar(TCadastroNovasFormulasColorbraz.Create());
  Self.Adicionar(TGeracaoTintaColorbraz.Create());
  Self.Adicionar(TConsultaColorbraz.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesColorbraz }

constructor TConfiguracoesColorbraz.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesColorbraz');
end;

procedure TConfiguracoesColorbraz.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorColorbraz.Create(auttinWrapper));
end;

{ TCadastroBasesColorbraz }

constructor TCadastroBasesColorbraz.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadCLBBase');
end;

procedure TCadastroBasesColorbraz.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesColorbraz.TCadastroBasesColorbraz.Create());
end;

{ TConsultaColorbraz }

constructor TConsultaColorbraz.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaColorbraz');
end;

procedure TConsultaColorbraz.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaColorbraz }

constructor TGeracaoTintaColorbraz.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadCLBGeraArquivo');
end;

procedure TGeracaoTintaColorbraz.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Colorbraz', [
    TGravandoExecucaoColorbrazColorantes.Create,
    TGravandoExecucaoColorbrazBases.Create,
    TGravandoExecucaoColorbrazCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadCLBGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Colorbraz', [
    TGravandoExecucaoColorbrazNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesColorbraz }

constructor TCadastroColorantesColorbraz.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadCLBColorantes');
end;

procedure TCadastroColorantesColorbraz.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesColorbraz.TCadastroColorantesColorbraz.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasColorbraz.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadCLBNovasFormulas');
end;

procedure TCadastroNovasFormulasColorbraz.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasColorbraz.TCadastroNovasFormulasColorbraz.Create);
end;


end.
