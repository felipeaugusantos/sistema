{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************PH*}
unit untAuttinMenuItemAnjoImobiliaria;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoAnjoImobiliariaCores,
  untGravandoExecucaoAnjoImobiliariaColorantes;

type
  TAuttinMenuItemAnjoImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesAnjoImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesAnjoImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesAnjoImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaAnjoImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaAnjoImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasAnjoImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroEmbalagensAnjoImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorAnjoImobiliaria, untLibTintaFactory, untGravandoExecucaoAnjoImobiliariaNovasFormulas, untCadastroBasesAnjoImobiliaria, 
  untCadastroColorantesAnjoImobiliaria, untGravandoExecucaoAnjoImobiliariaBases, 
  untCadastroNovasFormulasAnjoImobiliaria, untCadastroEmbalagensAnjoImobiliaria,
  untGravandoExecucaoAnjoImobiliariaEmbalagens;

{ TAuttinMenuItemAnjoImobiliaria }

constructor TAuttinMenuItemAnjoImobiliaria.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesAnjoImobiliaria.Create());
  Self.Adicionar(TCadastroBasesAnjoImobiliaria.Create());
  Self.Adicionar(TCadastroColorantesAnjoImobiliaria.Create());
  Self.Adicionar(TCadastroNovasFormulasAnjoImobiliaria.Create());
  Self.Adicionar(TCadastroEmbalagensAnjoImobiliaria.Create());
  Self.Adicionar(TGeracaoTintaAnjoImobiliaria.Create());
  Self.Adicionar(TConsultaAnjoImobiliaria.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesAnjoImobiliaria }

constructor TConfiguracoesAnjoImobiliaria.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesAnjoImobiliaria');
end;

procedure TConfiguracoesAnjoImobiliaria.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorAnjoImobiliaria.Create(auttinWrapper));
end;

{ TCadastroBasesAnjoImobiliaria }

constructor TCadastroBasesAnjoImobiliaria.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadANJBase');
end;

procedure TCadastroBasesAnjoImobiliaria.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesAnjoImobiliaria.TCadastroBasesAnjoImobiliaria.Create());
end;

{ TConsultaAnjoImobiliaria }

constructor TConsultaAnjoImobiliaria.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaAnjoImobiliaria');
end;

procedure TConsultaAnjoImobiliaria.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaAnjoImobiliaria }

constructor TGeracaoTintaAnjoImobiliaria.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadANJGeraArquivo');
end;

procedure TGeracaoTintaAnjoImobiliaria.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Anjo Imobiliaria', [
    TGravandoExecucaoAnjoImobiliariaEmbalagens.Create,
    TGravandoExecucaoAnjoImobiliariaColorantes.Create,
    TGravandoExecucaoAnjoImobiliariaBases.Create,
    TGravandoExecucaoAnjoImobiliariaCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadANJGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Anjo Imobiliaria', [
    TGravandoExecucaoAnjoImobiliariaNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesAnjoImobiliaria }

constructor TCadastroColorantesAnjoImobiliaria.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadANJColorantes');
end;

procedure TCadastroColorantesAnjoImobiliaria.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesAnjoImobiliaria.TCadastroColorantesAnjoImobiliaria.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasAnjoImobiliaria.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadANJNovasFormulas');
end;

procedure TCadastroNovasFormulasAnjoImobiliaria.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasAnjoImobiliaria.TCadastroNovasFormulasAnjoImobiliaria.Create);
end;


{ TCadastroEmbalagensAnjoImobiliaria }

constructor TCadastroEmbalagensAnjoImobiliaria.Create;
begin
  inherited Create('Cadastro de Embalagens', 'frmCadastroEmbalagensAnjoImobiliaria');
end;

procedure TCadastroEmbalagensAnjoImobiliaria.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  inherited;
  auttinWrapper.Cadastrar(untCadastroEmbalagensAnjoImobiliaria.TCadastroEmbalagensAnjoImobiliaria.Create);

end;

end.
