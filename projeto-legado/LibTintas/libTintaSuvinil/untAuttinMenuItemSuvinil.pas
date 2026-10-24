{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************PH*}
unit untAuttinMenuItemSuvinil;

interface

uses
  untGenericAuttinMenuItem, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoSuvinilCores,
  untGravandoExecucaoSuvinilColorantes,
  untGravandoExecucaoSuvinilScriptAtualizacao,
  untGravandoExecucaoSuvinilVerificaAtualizacao;

type
  TAuttinMenuItemSuvinil = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesSuvinil = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesSuvinil = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesSuvinil = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaSuvinil = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaSuvinil = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasSuvinil = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorSuvinil, untLibTintaFactory, untGravandoExecucaoSuvinilNovasFormulas, untCadastroBasesSuvinil, 
  untCadastroColorantesSuvinil, untGravandoExecucaoSuvinilBases, 
  untCadastroNovasFormulasSuvinil;

{ TAuttinMenuItemSuvinil }

constructor TAuttinMenuItemSuvinil.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesSuvinil.Create());
  Self.Adicionar(TCadastroBasesSuvinil.Create());
  Self.Adicionar(TCadastroColorantesSuvinil.Create());
  Self.Adicionar(TCadastroNovasFormulasSuvinil.Create());
  Self.Adicionar(TGeracaoTintaSuvinil.Create());
  Self.Adicionar(TConsultaSuvinil.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesSuvinil }

constructor TConfiguracoesSuvinil.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesSuvinil');
end;

procedure TConfiguracoesSuvinil.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorSuvinil.Create(auttinWrapper));
end;

{ TCadastroBasesSuvinil }

constructor TCadastroBasesSuvinil.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadSuvBase');
end;

procedure TCadastroBasesSuvinil.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesSuvinil.TCadastroBasesSuvinil.Create());
end;

{ TConsultaSuvinil }

constructor TConsultaSuvinil.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaSuvinil');
end;

procedure TConsultaSuvinil.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaSuvinil }

constructor TGeracaoTintaSuvinil.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadSuvGeraArquivo');
end;

procedure TGeracaoTintaSuvinil.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Suvinil', [
    TGravandoExecucaoSuvinilColorantes.Create,
    TGravandoExecucaoSuvinilBases.Create,
    TGravandoExecucaoSuvinilCores.Create,
    TGravandoExecucaoSuvinilScriptAtualizacao.Create,
    TGravandoExecucaoSuvinilVerificaAtualizacao.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadSuvGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Suvinil', [
    TGravandoExecucaoSuvinilNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesSuvinil }

constructor TCadastroColorantesSuvinil.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadSuvColorantes');
end;

procedure TCadastroColorantesSuvinil.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesSuvinil.TCadastroColorantesSuvinil.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasSuvinil.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadSuvNovasFormulas');  
end;

procedure TCadastroNovasFormulasSuvinil.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasSuvinil.TCadastroNovasFormulasSuvinil.Create);
end;

end.
