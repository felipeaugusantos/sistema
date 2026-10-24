{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemSinteplast;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoSinteplastCores,
  untGravandoExecucaoSinteplastColorantes;

type
  TAuttinMenuItemSinteplast = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesSinteplast = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesSinteplast = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesSinteplast = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaSinteplast = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaSinteplast = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasSinteplast = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorSinteplast, untLibTintaFactory, untGravandoExecucaoSinteplastNovasFormulas, untCadastroBasesSinteplast, 
  untCadastroColorantesSinteplast, untGravandoExecucaoSinteplastBases, 
  untCadastroNovasFormulasSinteplast;

{ TAuttinMenuItemSinteplast }

constructor TAuttinMenuItemSinteplast.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesSinteplast.Create());
  Self.Adicionar(TCadastroBasesSinteplast.Create());
  Self.Adicionar(TCadastroColorantesSinteplast.Create());
  Self.Adicionar(TCadastroNovasFormulasSinteplast.Create());
  Self.Adicionar(TGeracaoTintaSinteplast.Create());
  Self.Adicionar(TConsultaSinteplast.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesSinteplast }

constructor TConfiguracoesSinteplast.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesSinteplast');
end;

procedure TConfiguracoesSinteplast.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorSinteplast.Create(auttinWrapper));
end;

{ TCadastroBasesSinteplast }

constructor TCadastroBasesSinteplast.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadSINBase');
end;

procedure TCadastroBasesSinteplast.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesSinteplast.TCadastroBasesSinteplast.Create());
end;

{ TConsultaSinteplast }

constructor TConsultaSinteplast.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaSinteplast');
end;

procedure TConsultaSinteplast.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaSinteplast }

constructor TGeracaoTintaSinteplast.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadSINGeraArquivo');
end;

procedure TGeracaoTintaSinteplast.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Sinteplast', [
    TGravandoExecucaoSinteplastColorantes.Create,
    TGravandoExecucaoSinteplastBases.Create,
    TGravandoExecucaoSinteplastCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadSINGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Sinteplast Imobiliária', [
    TGravandoExecucaoSinteplastNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesSinteplast }

constructor TCadastroColorantesSinteplast.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadSINColorantes');
end;

procedure TCadastroColorantesSinteplast.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesSinteplast.TCadastroColorantesSinteplast.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasSinteplast.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadSINNovasFormulas');  
end;

procedure TCadastroNovasFormulasSinteplast.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasSinteplast.TCadastroNovasFormulasSinteplast.Create);
end;

end.
