{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemHydronorthImobiliaria;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoHydronorthImobiliariaCores,
  untGravandoExecucaoHydronorthImobiliariaColorantes,
  untGravandoExecucaoHydronorthImobiliariaEmbalagens;

type
  TAuttinMenuItemHydronorthImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesHydronorthImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesHydronorthImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesHydronorthImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaHydronorthImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaHydronorthImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasHydronorthImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroEmbalagensHydronorthImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorHydronorthImobiliaria, untLibTintaFactory, untGravandoExecucaoHydronorthImobiliariaNovasFormulas, untCadastroBasesHydronorthImobiliaria, 
  untCadastroColorantesHydronorthImobiliaria, untGravandoExecucaoHydronorthImobiliariaBases, 
  untCadastroNovasFormulasHydronorthImobiliaria, untCadastroEmbalagensHydronorthImobiliaria;

{ TAuttinMenuItemHydronorthImobiliaria }

constructor TAuttinMenuItemHydronorthImobiliaria.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesHydronorthImobiliaria.Create());
  Self.Adicionar(TCadastroBasesHydronorthImobiliaria.Create());
  Self.Adicionar(TCadastroColorantesHydronorthImobiliaria.Create());
  Self.Adicionar(TCadastroEmbalagensHydronorthImobiliaria.Create());
  Self.Adicionar(TCadastroNovasFormulasHydronorthImobiliaria.Create());
  Self.Adicionar(TGeracaoTintaHydronorthImobiliaria.Create());
  Self.Adicionar(TConsultaHydronorthImobiliaria.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesHydronorthImobiliaria }

constructor TConfiguracoesHydronorthImobiliaria.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesHydronorthImobiliaria');
end;

procedure TConfiguracoesHydronorthImobiliaria.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorHydronorthImobiliaria.Create(auttinWrapper));
end;

{ TCadastroBasesHydronorthImobiliaria }

constructor TCadastroBasesHydronorthImobiliaria.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadHYDBase');
end;

procedure TCadastroBasesHydronorthImobiliaria.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesHydronorthImobiliaria.TCadastroBasesHydronorthImobiliaria.Create());
end;

{ TConsultaHydronorthImobiliaria }

constructor TConsultaHydronorthImobiliaria.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaHydronorthImobiliaria');
end;

procedure TConsultaHydronorthImobiliaria.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaHydronorthImobiliaria }

constructor TGeracaoTintaHydronorthImobiliaria.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadHYDGeraArquivo');
end;

procedure TGeracaoTintaHydronorthImobiliaria.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Hydronorth Imobiliária', [
    TGravandoExecucaoHydronorthImobiliariaColorantes.Create,
    TGravandoExecucaoHydronorthImobiliariaBases.Create,
    TGravandoExecucaoHydronorthImobiliariaCores.Create,
    TGravandoExecucaoHydronorthImobiliariaEmbalagens.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadHYDGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Hydronorth Imobiliária', [
    TGravandoExecucaoHydronorthImobiliariaNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesHydronorthImobiliaria }

constructor TCadastroColorantesHydronorthImobiliaria.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadHYDColorantes');
end;

procedure TCadastroColorantesHydronorthImobiliaria.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesHydronorthImobiliaria.TCadastroColorantesHydronorthImobiliaria.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasHydronorthImobiliaria.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadHYDNovasFormulas');
end;

procedure TCadastroNovasFormulasHydronorthImobiliaria.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasHydronorthImobiliaria.TCadastroNovasFormulasHydronorthImobiliaria.Create);
end;

{ TCadastroEmbalagensHydronorthImobiliaria }

constructor TCadastroEmbalagensHydronorthImobiliaria.Create;
begin
  inherited Create('Cadastro de Embalagens', 'frmCadHYDEmbalagens');
end;

procedure TCadastroEmbalagensHydronorthImobiliaria.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroEmbalagensHydronorthImobiliaria.TCadastroEmbalagensHydronorthImobiliaria.Create);
end;

end.
