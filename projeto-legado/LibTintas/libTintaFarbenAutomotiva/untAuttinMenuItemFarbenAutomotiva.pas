{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************PH*}
unit untAuttinMenuItemFarbenAutomotiva;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoFarbenAutomotivaCores,
  untGravandoExecucaoFarbenAutomotivaMontadora;

type
  TAuttinMenuItemFarbenAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesFarbenAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesFarbenAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaFarbenAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaFarbenAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasFarbenAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorFarbenAutomotiva, untLibTintaFactory, untGravandoExecucaoFarbenAutomotivaNovasFormulas, untCadastroBasesFarbenAutomotiva,
  untGravandoExecucaoFarbenAutomotivaBases, untCadastroNovasFormulasFarbenAutomotiva;

{ TAuttinMenuItemFarbenAutomotiva }

constructor TAuttinMenuItemFarbenAutomotiva.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesFarbenAutomotiva.Create());
  Self.Adicionar(TCadastroBasesFarbenAutomotiva.Create());
  Self.Adicionar(TCadastroNovasFormulasFarbenAutomotiva.Create());
  Self.Adicionar(TGeracaoTintaFarbenAutomotiva.Create());
  Self.Adicionar(TConsultaFarbenAutomotiva.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());

end;

{ TConfiguracoesFarbenAutomotiva }

constructor TConfiguracoesFarbenAutomotiva.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesFarbenAutomotiva');
end;

procedure TConfiguracoesFarbenAutomotiva.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorFarbenAutomotiva.Create(auttinWrapper));
end;

{ TCadastroBasesFarbenAutomotiva }

constructor TCadastroBasesFarbenAutomotiva.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadFARBase');
end;

procedure TCadastroBasesFarbenAutomotiva.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesFarbenAutomotiva.TCadastroBasesFarbenAutomotiva.Create());
end;

{ TConsultaFarbenAutomotiva }

constructor TConsultaFarbenAutomotiva.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaFarbenAutomotiva');
end;

procedure TConsultaFarbenAutomotiva.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaFarbenAutomotiva }

constructor TGeracaoTintaFarbenAutomotiva.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadFARGeraArquivo');
end;

procedure TGeracaoTintaFarbenAutomotiva.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Farben Automotiva', [
    TGravandoExecucaoFarbenAutomotivaBases.Create,
    TGravandoExecucaoFarbenAutomotivaCores.Create,
    TGravandoExecucaoFarbenAutomotivaMontadora.Create]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadFARGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('FarbenAutomotiva', [
    TGravandoExecucaoFarbenAutomotivaNovasFormulas.Create
  ]);
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasFarbenAutomotiva.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadFARNovasFormulas');
end;

procedure TCadastroNovasFormulasFarbenAutomotiva.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasFarbenAutomotiva.TCadastroNovasFormulasFarbenAutomotiva.Create);
end;

end.
