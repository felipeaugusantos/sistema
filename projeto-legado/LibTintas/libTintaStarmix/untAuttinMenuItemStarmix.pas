{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemStarmix;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoStarmixCores;

type
  TAuttinMenuItemStarmix = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesStarmix = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesStarmix = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaStarmix = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaStarmix = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasStarmix = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorStarmix, untLibTintaFactory,
  untGravandoExecucaoStarmixNovasFormulas, untCadastroBasesStarmix,
  untGravandoExecucaoStarmixBases,  untCadastroNovasFormulasStarmix;

{ TAuttinMenuItemStarmix }

constructor TAuttinMenuItemStarmix.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesStarmix.Create());
  Self.Adicionar(TCadastroBasesStarmix.Create());
  Self.Adicionar(TCadastroNovasFormulasStarmix.Create());
  Self.Adicionar(TGeracaoTintaStarmix.Create());
  Self.Adicionar(TConsultaStarmix.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesStarmix }

constructor TConfiguracoesStarmix.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesStarmix');
end;

procedure TConfiguracoesStarmix.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorStarmix.Create(auttinWrapper));
end;

{ TCadastroBasesStarmix }

constructor TCadastroBasesStarmix.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadStaBases');
end;

procedure TCadastroBasesStarmix.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesStarmix.TCadastroBasesStarmix.Create());
end;

{ TConsultaStarmix }

constructor TConsultaStarmix.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaStarmix');
end;

procedure TConsultaStarmix.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaStarmix }

constructor TGeracaoTintaStarmix.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadStaGeraArquivo');
end;

procedure TGeracaoTintaStarmix.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Starmix', [
    TGravandoExecucaoStarmixBases.Create,
    TGravandoExecucaoStarmixCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadStaGerNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Starmix', [
    TGravandoExecucaoStarmixNovasFormulas.Create
  ]);
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasStarmix.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadStaNovasFormulas');
end;

procedure TCadastroNovasFormulasStarmix.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasStarmix.TCadastroNovasFormulasStarmix.Create);
end;

end.
