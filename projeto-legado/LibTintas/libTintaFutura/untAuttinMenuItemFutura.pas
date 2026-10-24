{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemFutura;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoFuturaCores,
  untGravandoExecucaoFuturaColorantes;

type
  TAuttinMenuItemFutura = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesFutura = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesFutura = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesFutura = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaFutura = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaFutura = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasFutura = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorFutura, untLibTintaFactory, untGravandoExecucaoFuturaNovasFormulas, untCadastroBasesFutura, 
  untCadastroColorantesFutura, untGravandoExecucaoFuturaBases, 
  untCadastroNovasFormulasFutura;

{ TAuttinMenuItemFutura }

constructor TAuttinMenuItemFutura.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesFutura.Create());
  Self.Adicionar(TCadastroBasesFutura.Create());
  Self.Adicionar(TCadastroColorantesFutura.Create());
  Self.Adicionar(TCadastroNovasFormulasFutura.Create());
  Self.Adicionar(TGeracaoTintaFutura.Create());
  Self.Adicionar(TConsultaFutura.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesFutura }

constructor TConfiguracoesFutura.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesFutura');
end;

procedure TConfiguracoesFutura.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorFutura.Create(auttinWrapper));
end;

{ TCadastroBasesFutura }

constructor TCadastroBasesFutura.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadFUTBase');
end;

procedure TCadastroBasesFutura.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesFutura.TCadastroBasesFutura.Create());
end;

{ TConsultaFutura }

constructor TConsultaFutura.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaFutura');
end;

procedure TConsultaFutura.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaFutura }

constructor TGeracaoTintaFutura.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadFUTGeraArquivo');
end;

procedure TGeracaoTintaFutura.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Futura', [
    TGravandoExecucaoFuturaColorantes.Create,
    TGravandoExecucaoFuturaBases.Create,
    TGravandoExecucaoFuturaCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadFUTGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Futura', [
    TGravandoExecucaoFuturaNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesFutura }

constructor TCadastroColorantesFutura.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadFUTColorantes');
end;

procedure TCadastroColorantesFutura.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesFutura.TCadastroColorantesFutura.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasFutura.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadFUTNovasFormulas');  
end;

procedure TCadastroNovasFormulasFutura.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasFutura.TCadastroNovasFormulasFutura.Create);
end;

end.
