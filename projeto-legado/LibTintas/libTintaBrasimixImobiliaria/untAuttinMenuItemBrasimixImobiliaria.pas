{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************PH*}
unit untAuttinMenuItemBrasimixImobiliaria;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoBrasimixImobiliariaCores,
  untGravandoExecucaoBrasimixImobiliariaColorantes;

type
  TAuttinMenuItemBrasimixImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesBrasimixImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesBrasimixImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesBrasimixImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaBrasimixImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaBrasimixImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasBrasimixImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorBrasimixImobiliaria, untLibTintaFactory, untGravandoExecucaoBrasimixImobiliariaNovasFormulas, untCadastroBasesBrasimixImobiliaria, 
  untCadastroColorantesBrasimixImobiliaria, untGravandoExecucaoBrasimixImobiliariaBases, 
  untCadastroNovasFormulasBrasimixImobiliaria;

{ TAuttinMenuItemBrasimixImobiliaria }

constructor TAuttinMenuItemBrasimixImobiliaria.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesBrasimixImobiliaria.Create());
  Self.Adicionar(TCadastroBasesBrasimixImobiliaria.Create());
  Self.Adicionar(TCadastroColorantesBrasimixImobiliaria.Create());
  Self.Adicionar(TCadastroNovasFormulasBrasimixImobiliaria.Create());
  Self.Adicionar(TGeracaoTintaBrasimixImobiliaria.Create());
  Self.Adicionar(TConsultaBrasimixImobiliaria.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesBrasimixImobiliaria }

constructor TConfiguracoesBrasimixImobiliaria.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesBrasimixImobiliaria');
end;

procedure TConfiguracoesBrasimixImobiliaria.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorBrasimixImobiliaria.Create(auttinWrapper));
end;

{ TCadastroBasesBrasimixImobiliaria }

constructor TCadastroBasesBrasimixImobiliaria.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadBziBase');
end;

procedure TCadastroBasesBrasimixImobiliaria.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesBrasimixImobiliaria.TCadastroBasesBrasimixImobiliaria.Create());
end;

{ TConsultaBrasimixImobiliaria }

constructor TConsultaBrasimixImobiliaria.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaBrasimixImobiliaria');
end;

procedure TConsultaBrasimixImobiliaria.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaBrasimixImobiliaria }

constructor TGeracaoTintaBrasimixImobiliaria.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadBziGeraArquivo');
end;

procedure TGeracaoTintaBrasimixImobiliaria.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Brasimix Imobiliaria', [
    TGravandoExecucaoBrasimixImobiliariaColorantes.Create,
    TGravandoExecucaoBrasimixImobiliariaBases.Create,
    TGravandoExecucaoBrasimixImobiliariaCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadBziGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Brasimix Imobiliaria', [
    TGravandoExecucaoBrasimixImobiliariaNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesBrasimixImobiliaria }

constructor TCadastroColorantesBrasimixImobiliaria.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadBziColorantes');
end;

procedure TCadastroColorantesBrasimixImobiliaria.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesBrasimixImobiliaria.TCadastroColorantesBrasimixImobiliaria.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasBrasimixImobiliaria.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadBziNovasFormulas');
end;

procedure TCadastroNovasFormulasBrasimixImobiliaria.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasBrasimixImobiliaria.TCadastroNovasFormulasBrasimixImobiliaria.Create);
end;

end.
