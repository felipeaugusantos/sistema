{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************PH*}
unit untAuttinMenuItemStandox;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoStandoxCores,
  untGravandoExecucaoStandoxDiluente;

type
  TAuttinMenuItemStandox = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesStandox = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesStandox = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaStandox = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaStandox = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasStandox = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorStandox, untLibTintaFactory, untGravandoExecucaoStandoxNovasFormulas, untCadastroBasesStandox,
  untGravandoExecucaoStandoxBases, untCadastroNovasFormulasStandox;

{ TAuttinMenuItemStandox }

constructor TAuttinMenuItemStandox.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesStandox.Create());
  Self.Adicionar(TCadastroBasesStandox.Create());
  Self.Adicionar(TCadastroNovasFormulasStandox.Create());
  Self.Adicionar(TGeracaoTintaStandox.Create());
  Self.Adicionar(TConsultaStandox.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());

end;

{ TConfiguracoesStandox }

constructor TConfiguracoesStandox.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesStandox');
end;

procedure TConfiguracoesStandox.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorStandox.Create(auttinWrapper));
end;

{ TCadastroBasesStandox }

constructor TCadastroBasesStandox.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadDOXBase');
end;

procedure TCadastroBasesStandox.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesStandox.TCadastroBasesStandox.Create());
end;

{ TConsultaStandox }

constructor TConsultaStandox.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaStandox');
end;

procedure TConsultaStandox.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaStandox }

constructor TGeracaoTintaStandox.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadDOXGeraArquivo');
end;

procedure TGeracaoTintaStandox.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Standox', [
    TGravandoExecucaoStandoxBases.Create,
    TGravandoExecucaoStandoxDiluente.Create,
    TGravandoExecucaoStandoxCores.Create]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadDOXGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Standox', [
    TGravandoExecucaoStandoxNovasFormulas.Create
  ]);
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasStandox.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadDOXNovasFormulas');
end;

procedure TCadastroNovasFormulasStandox.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasStandox.TCadastroNovasFormulasStandox.Create);
end;

end.
