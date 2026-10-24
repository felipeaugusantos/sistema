{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************PH*}
unit untAuttinMenuItemMazaImobiliaria;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoMazaImobiliariaCores,
  untGravandoExecucaoMazaImobiliariaColorantes;

type
  TAuttinMenuItemMazaImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesMazaImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesMazaImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroEmbalagensMazaImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesMazaImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaMazaImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaMazaImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasMazaImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorMazaImobiliaria, untLibTintaFactory, untGravandoExecucaoMazaImobiliariaNovasFormulas, untCadastroBasesMazaImobiliaria,
  untCadastroColorantesMazaImobiliaria, untGravandoExecucaoMazaImobiliariaBases,
  untCadastroNovasFormulasMazaImobiliaria, untCadastroEmbalagensMazaImobiliaria;

{ TAuttinMenuItemMazaImobiliaria }

constructor TAuttinMenuItemMazaImobiliaria.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesMazaImobiliaria.Create());
  Self.Adicionar(TCadastroBasesMazaImobiliaria.Create());
  Self.Adicionar(TCadastroEmbalagensMazaImobiliaria.Create());
  Self.Adicionar(TCadastroColorantesMazaImobiliaria.Create());
  Self.Adicionar(TCadastroNovasFormulasMazaImobiliaria.Create());
  Self.Adicionar(TGeracaoTintaMazaImobiliaria.Create());
  Self.Adicionar(TConsultaMazaImobiliaria.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesMazaImobiliaria }

constructor TConfiguracoesMazaImobiliaria.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesMazaImobiliaria');
end;

procedure TConfiguracoesMazaImobiliaria.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorMazaImobiliaria.Create(auttinWrapper));
end;

{ TCadastroBasesMazaImobiliaria }

constructor TCadastroBasesMazaImobiliaria.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadMZIBase');
end;

procedure TCadastroBasesMazaImobiliaria.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesMazaImobiliaria.TCadastroBasesMazaImobiliaria.Create());
end;

constructor TCadastroEmbalagensMazaImobiliaria.Create;
begin
  inherited Create('Cadastro de Embalagens', 'frmCadMZIEmbalagens');
end;

procedure TCadastroEmbalagensMazaImobiliaria.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroEmbalagensMazaImobiliaria.TCadastroEmbalagensMazaImobiliaria.Create());
end;

{ TConsultaMazaImobiliaria }

constructor TConsultaMazaImobiliaria.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaMazaImobiliaria');
end;

procedure TConsultaMazaImobiliaria.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaMazaImobiliaria }

constructor TGeracaoTintaMazaImobiliaria.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadMZIGeraArquivo');
end;

procedure TGeracaoTintaMazaImobiliaria.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('MazaImobiliaria', [
    TGravandoExecucaoMazaImobiliariaColorantes.Create,
    TGravandoExecucaoMazaImobiliariaBases.Create,
    TGravandoExecucaoMazaImobiliariaCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadMZIGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('MazaImobiliaria', [
    TGravandoExecucaoMazaImobiliariaNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesMazaImobiliaria }

constructor TCadastroColorantesMazaImobiliaria.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadMZIColorantes');
end;

procedure TCadastroColorantesMazaImobiliaria.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesMazaImobiliaria.TCadastroColorantesMazaImobiliaria.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasMazaImobiliaria.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadMZINovasFormulas');  
end;

procedure TCadastroNovasFormulasMazaImobiliaria.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasMazaImobiliaria.TCadastroNovasFormulasMazaImobiliaria.Create);
end;

end.
