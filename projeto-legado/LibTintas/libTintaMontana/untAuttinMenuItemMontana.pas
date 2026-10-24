{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemMontana;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoMontanaCores,
  untGravandoExecucaoMontanaColorantes;

type
  TAuttinMenuItemMontana = class(TGenericAuttinMenuItem)
  public
    constructor Create(); Reintroduce;
  end;

  TConfiguracoesMontana = class(TGenericAuttinMenuItem)
  public
    constructor Create(); Reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesMontana = class(TGenericAuttinMenuItem)
  public
    constructor Create(); Reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;



  TCadastroColorantesMontana = class(TGenericAuttinMenuItem)
  public
    constructor Create(); Reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaMontana = class(TGenericAuttinMenuItem)
  public
    constructor Create(); Reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaMontana = class(TGenericAuttinMenuItem)
  public
    constructor Create(); Reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); Reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasMontana = class(TGenericAuttinMenuItem)
  public
    constructor Create(); Reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorMontana, untLibTintaFactory, untGravandoExecucaoMontanaNovasFormulas, untCadastroBasesMontana,
  untCadastroColorantesMontana, untGravandoExecucaoMontanaBases,
  untCadastroNovasFormulasMontana;

{ TAuttinMenuItemMontana }

constructor TAuttinMenuItemMontana.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesMontana.Create());
  Self.Adicionar(TCadastroBasesMontana.Create());
  Self.Adicionar(TCadastroColorantesMontana.Create());
  Self.Adicionar(TCadastroNovasFormulasMontana.Create());
  Self.Adicionar(TGeracaoTintaMontana.Create());
  Self.Adicionar(TConsultaMontana.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesMontana }

constructor TConfiguracoesMontana.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesMontana');
end;

procedure TConfiguracoesMontana.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorMontana.Create(auttinWrapper));
end;

{ TCadastroBasesMontana }

constructor TCadastroBasesMontana.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadMONBase');
end;


procedure TCadastroBasesMontana.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesMontana.TCadastroBasesMontana.Create());
end;


{ TConsultaMontana }

constructor TConsultaMontana.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaMontana');
end;

procedure TConsultaMontana.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaMontana }

constructor TGeracaoTintaMontana.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadMONGeraArquivo');
end;

procedure TGeracaoTintaMontana.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Montana', [
    TGravandoExecucaoMontanaColorantes.Create,
    TGravandoExecucaoMontanaBases.Create,
    TGravandoExecucaoMontanaCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadMONGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Montana', [
    TGravandoExecucaoMontanaNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesMontana }

constructor TCadastroColorantesMontana.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadMONColorantes');
end;

procedure TCadastroColorantesMontana.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesMontana.TCadastroColorantesMontana.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasMontana.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadMONNovasFormulas');
end;

procedure TCadastroNovasFormulasMontana.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasMontana.TCadastroNovasFormulasMontana.Create);
end;

end.
