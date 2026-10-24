{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************PH*}
unit untAuttinMenuItemMazaIndustrial;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoMazaIndustrialCores;

type
  TAuttinMenuItemMazaIndustrial = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesMazaIndustrial = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesMazaIndustrial = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaMazaIndustrial = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaMazaIndustrial = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasMazaIndustrial = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroMontadoraMazaIndustrial = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;


implementation

uses
  untConfiguradorMazaIndustrial, untLibTintaFactory, untGravandoExecucaoMazaIndustrialNovasFormulas, untCadastroBasesMazaIndustrial,
  untGravandoExecucaoMazaIndustrialBases, untCadastroNovasFormulasMazaIndustrial,
  untCadastroMontadoraMazaIndustrial,
  untGravandoExecucaoMazaIndustrialMontadora,
  untGravandoExecucaoMazaIndustrialLinhas;

{ TAuttinMenuItemMazaIndustrial }

constructor TAuttinMenuItemMazaIndustrial.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesMazaIndustrial.Create());
  Self.Adicionar(TCadastroBasesMazaIndustrial.Create());
  Self.Adicionar(TCadastroNovasFormulasMazaIndustrial.Create());
  Self.Adicionar(TCadastroMontadoraMazaIndustrial.Create());
  Self.Adicionar(TGeracaoTintaMazaIndustrial.Create());
  Self.Adicionar(TConsultaMazaIndustrial.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesMazaIndustrial }

constructor TConfiguracoesMazaIndustrial.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesMazaIndustrial');
end;

procedure TConfiguracoesMazaIndustrial.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorMazaIndustrial.Create(auttinWrapper));
end;

{ TCadastroBasesMazaIndustrial }

constructor TCadastroBasesMazaIndustrial.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadMZDBase');
end;

procedure TCadastroBasesMazaIndustrial.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesMazaIndustrial.TCadastroBasesMazaIndustrial.Create());
end;

{ TConsultaMazaIndustrial }

constructor TConsultaMazaIndustrial.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaMazaIndustrial');
end;

procedure TConsultaMazaIndustrial.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaMazaIndustrial }

constructor TGeracaoTintaMazaIndustrial.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadMZDGeraArquivo');
end;

procedure TGeracaoTintaMazaIndustrial.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Maza Industrial', [
    TGravandoExecucaoMazaIndustrialLinhas.Create,
    TGravandoExecucaoMazaIndustrialMontadora.Create,
    TGravandoExecucaoMazaIndustrialBases.Create,
    TGravandoExecucaoMazaIndustrialCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadMZDGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Maza Industrial', [
    TGravandoExecucaoMazaIndustrialNovasFormulas.Create
  ]);
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasMazaIndustrial.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadMZDNovasFormulas');
end;

procedure TCadastroNovasFormulasMazaIndustrial.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasMazaIndustrial.TCadastroNovasFormulasMazaIndustrial.Create);
end;

{ TCadastroMontadoraMazaIndustrial }

constructor TCadastroMontadoraMazaIndustrial.Create;
begin
  inherited Create('Cadastro de Montadora', 'frmCadMZDMontadora');
end;

procedure TCadastroMontadoraMazaIndustrial.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroMontadoraMazaIndustrial.TCadastroMontadoraMazaIndustrial.Create);
end;

end.
