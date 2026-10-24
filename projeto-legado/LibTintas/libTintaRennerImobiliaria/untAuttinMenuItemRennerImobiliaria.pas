{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemRennerImobiliaria;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoRennerImobiliariaCores,
  untGravandoExecucaoRennerImobiliariaColorantes;

type
  TAuttinMenuItemRennerImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesRennerImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesRennerImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesRennerImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaRennerImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaRennerImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasRennerImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorRennerImobiliaria, untLibTintaFactory, untGravandoExecucaoRennerImobiliariaNovasFormulas, untCadastroBasesRennerImobiliaria,
  untCadastroColorantesRennerImobiliaria, untGravandoExecucaoRennerImobiliariaBases,
  untCadastroNovasFormulasRennerImobiliaria;

{ TAuttinMenuItemRennerImobiliaria }

constructor TAuttinMenuItemRennerImobiliaria.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesRennerImobiliaria.Create());
  Self.Adicionar(TCadastroBasesRennerImobiliaria.Create());
  Self.Adicionar(TCadastroColorantesRennerImobiliaria.Create());
  Self.Adicionar(TCadastroNovasFormulasRennerImobiliaria.Create());
  Self.Adicionar(TGeracaoTintaRennerImobiliaria.Create());
  Self.Adicionar(TConsultaRennerImobiliaria.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesRennerImobiliaria }

constructor TConfiguracoesRennerImobiliaria.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesRennerImobiliaria');
end;

procedure TConfiguracoesRennerImobiliaria.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorRennerImobiliaria.Create(auttinWrapper));
end;

{ TCadastroBasesRennerImobiliaria }

constructor TCadastroBasesRennerImobiliaria.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadREIBase');
end;

procedure TCadastroBasesRennerImobiliaria.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesRennerImobiliaria.TCadastroBasesRennerImobiliaria.Create());
end;

{ TConsultaRennerImobiliaria }

constructor TConsultaRennerImobiliaria.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaRennerImobiliaria');
end;

procedure TConsultaRennerImobiliaria.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaRennerImobiliaria }

constructor TGeracaoTintaRennerImobiliaria.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadREIGeraArquivo');
end;

procedure TGeracaoTintaRennerImobiliaria.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Renner Imobiliária', [
    TGravandoExecucaoRennerImobiliariaColorantes.Create,
    TGravandoExecucaoRennerImobiliariaBases.Create,
    TGravandoExecucaoRennerImobiliariaCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadREIGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Renner Imobiliária', [
    TGravandoExecucaoRennerImobiliariaNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesRennerImobiliaria }

constructor TCadastroColorantesRennerImobiliaria.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadREIColorantes');
end;

procedure TCadastroColorantesRennerImobiliaria.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesRennerImobiliaria.TCadastroColorantesRennerImobiliaria.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasRennerImobiliaria.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadREINovasFormulas');
end;

procedure TCadastroNovasFormulasRennerImobiliaria.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasRennerImobiliaria.TCadastroNovasFormulasRennerImobiliaria.Create);
end;

end.
