{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************PH*}
unit untAuttinMenuItemMazaAutomotiva;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoMazaAutomotivaCores;

type
  TAuttinMenuItemMazaAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesMazaAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesMazaAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaMazaAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaMazaAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasMazaAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroMontadoraMazaAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;


implementation

uses
  untConfiguradorMazaAutomotiva, untLibTintaFactory, untGravandoExecucaoMazaAutomotivaNovasFormulas, untCadastroBasesMazaAutomotiva,
  untGravandoExecucaoMazaAutomotivaBases, untGravandoExecucaoMazaAutomotivaPersonalizadas, untCadastroNovasFormulasMazaAutomotiva,
  untCadastroMontadoraMazaAutomotiva,
  untGravandoExecucaoMazaAutomotivaMontadora,
  untGravandoExecucaoMazaAutomotivaLinhas;

{ TAuttinMenuItemMazaAutomotiva }

constructor TAuttinMenuItemMazaAutomotiva.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesMazaAutomotiva.Create());
  Self.Adicionar(TCadastroBasesMazaAutomotiva.Create());
  Self.Adicionar(TCadastroNovasFormulasMazaAutomotiva.Create());
  Self.Adicionar(TCadastroMontadoraMazaAutomotiva.Create());
  Self.Adicionar(TGeracaoTintaMazaAutomotiva.Create());
  Self.Adicionar(TConsultaMazaAutomotiva.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesMazaAutomotiva }

constructor TConfiguracoesMazaAutomotiva.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesMazaAutomotiva');
end;

procedure TConfiguracoesMazaAutomotiva.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorMazaAutomotiva.Create(auttinWrapper));
end;

{ TCadastroBasesMazaAutomotiva }

constructor TCadastroBasesMazaAutomotiva.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadMZABase');
end;

procedure TCadastroBasesMazaAutomotiva.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesMazaAutomotiva.TCadastroBasesMazaAutomotiva.Create());
end;

{ TConsultaMazaAutomotiva }

constructor TConsultaMazaAutomotiva.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaMazaAutomotiva');
end;

procedure TConsultaMazaAutomotiva.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaMazaAutomotiva }

constructor TGeracaoTintaMazaAutomotiva.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadMZAGeraArquivo');
end;

procedure TGeracaoTintaMazaAutomotiva.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Maza Automotiva', [
    TGravandoExecucaoMazaAutomotivaLinhas.Create,
    TGravandoExecucaoMazaAutomotivaMontadora.Create,
    TGravandoExecucaoMazaAutomotivaBases.Create,
    TGravandoExecucaoMazaAutomotivaCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadMZAGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Maza Automotiva', [
    TGravandoExecucaoMazaAutomotivaNovasFormulas.Create
  ]);
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasMazaAutomotiva.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadMZANovasFormulas');
end;

procedure TCadastroNovasFormulasMazaAutomotiva.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasMazaAutomotiva.TCadastroNovasFormulasMazaAutomotiva.Create);
end;

{ TCadastroMontadoraMazaAutomotiva }

constructor TCadastroMontadoraMazaAutomotiva.Create;
begin
  inherited Create('Cadastro de Montadora', 'frmCadMzaMontadora');
end;

procedure TCadastroMontadoraMazaAutomotiva.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroMontadoraMazaAutomotiva.TCadastroMontadoraMazaAutomotiva.Create);
end;

end.
