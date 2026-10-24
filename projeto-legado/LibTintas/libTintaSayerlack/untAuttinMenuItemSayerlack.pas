{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemSayerlack;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoSayerlackCores,
  untGravandoExecucaoSayerlackColorantes;

type
  TAuttinMenuItemSayerlack = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesSayerlack = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesSayerlack = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesSayerlack = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaSayerlack = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaSayerlack = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasSayerlack = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroEmbalagensSayerlack = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorSayerlack, untLibTintaFactory, untGravandoExecucaoSayerlackNovasFormulas, untCadastroBasesSayerlack, 
  untCadastroColorantesSayerlack, untGravandoExecucaoSayerlackBases, 
  untCadastroNovasFormulasSayerlack, untCadastroEmbalagensSayerlack;

{ TAuttinMenuItemSayerlack }

constructor TAuttinMenuItemSayerlack.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesSayerlack.Create());
  Self.Adicionar(TCadastroBasesSayerlack.Create());
  Self.Adicionar(TCadastroColorantesSayerlack.Create());
  Self.Adicionar(TCadastroEmbalagensSayerlack.Create());
  Self.Adicionar(TCadastroNovasFormulasSayerlack.Create());
  Self.Adicionar(TGeracaoTintaSayerlack.Create());
  Self.Adicionar(TConsultaSayerlack.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesSayerlack }

constructor TConfiguracoesSayerlack.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesSayerlack');
end;

procedure TConfiguracoesSayerlack.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorSayerlack.Create(auttinWrapper));
end;

{ TCadastroBasesSayerlack }

constructor TCadastroBasesSayerlack.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadSAYBase');
end;

procedure TCadastroBasesSayerlack.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesSayerlack.TCadastroBasesSayerlack.Create());
end;

{ TConsultaSayerlack }

constructor TConsultaSayerlack.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaSayerlack');
end;

procedure TConsultaSayerlack.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaSayerlack }

constructor TGeracaoTintaSayerlack.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadSAYGeraArquivo');
end;

procedure TGeracaoTintaSayerlack.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Sayerlack Imobiliária', [
    TGravandoExecucaoSayerlackColorantes.Create,
    TGravandoExecucaoSayerlackBases.Create,
    TGravandoExecucaoSayerlackCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadSAYGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Sayerlack Imobiliária', [
    TGravandoExecucaoSayerlackNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesSayerlack }

constructor TCadastroColorantesSayerlack.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadSAYColorantes');
end;

procedure TCadastroColorantesSayerlack.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesSayerlack.TCadastroColorantesSayerlack.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasSayerlack.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadSAYNovasFormulas');
end;

procedure TCadastroNovasFormulasSayerlack.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasSayerlack.TCadastroNovasFormulasSayerlack.Create);
end;

{ TCadastroEmbalagensSayerlack }

constructor TCadastroEmbalagensSayerlack.Create;
begin
  inherited Create('Cadastro de Embalagens', 'frmCadSAYEmbalagens');
end;

procedure TCadastroEmbalagensSayerlack.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroEmbalagensSayerlack.TCadastroEmbalagensSayerlack.Create);
end;

end.
