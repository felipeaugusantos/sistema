{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemStarmixWeb;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoStarmixWebCores;

type
  TAuttinMenuItemStarmixWeb = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesStarmixWeb = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesStarmixWeb = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaStarmixWeb = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaStarmixWeb = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasStarmixWeb = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorStarmixWeb, untLibTintaFactory,
  untGravandoExecucaoStarmixWebNovasFormulas, untCadastroBasesStarmixWeb,
  untGravandoExecucaoStarmixWebBases,  untCadastroNovasFormulasStarmixWeb;

{ TAuttinMenuItemStarmixWeb }

constructor TAuttinMenuItemStarmixWeb.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesStarmixWeb.Create());
  Self.Adicionar(TCadastroBasesStarmixWeb.Create());
  Self.Adicionar(TCadastroNovasFormulasStarmixWeb.Create());
  Self.Adicionar(TGeracaoTintaStarmixWeb.Create());
  Self.Adicionar(TConsultaStarmixWeb.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesStarmixWeb }

constructor TConfiguracoesStarmixWeb.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesStarmixWeb');
end;

procedure TConfiguracoesStarmixWeb.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorStarmixWeb.Create(auttinWrapper));
end;

{ TCadastroBasesStarmixWeb }

constructor TCadastroBasesStarmixWeb.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadStaWebBases');
end;

procedure TCadastroBasesStarmixWeb.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesStarmixWeb.TCadastroBasesStarmixWeb.Create());
end;

{ TConsultaStarmixWeb }

constructor TConsultaStarmixWeb.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaStarmixWeb');
end;

procedure TConsultaStarmixWeb.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaStarmixWeb }

constructor TGeracaoTintaStarmixWeb.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadStaWebGeraArquivo');
end;

procedure TGeracaoTintaStarmixWeb.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Starmix Web / W-Mix', [
    TGravandoExecucaoStarmixWebBases.Create,
    TGravandoExecucaoStarmixWebCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadStaWebGerNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Starmix Web / W-Mix', [
    TGravandoExecucaoStarmixWebNovasFormulas.Create
  ]);
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasStarmixWeb.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadStaWebNovasFormulas');
end;

procedure TCadastroNovasFormulasStarmixWeb.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasStarmixWeb.TCadastroNovasFormulasStarmixWeb.Create);
end;

end.
