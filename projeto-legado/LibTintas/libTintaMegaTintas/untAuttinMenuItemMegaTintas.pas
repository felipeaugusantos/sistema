{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************PH*}
unit untAuttinMenuItemMegaTintas;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoMegaTintasCores,
  untGravandoExecucaoMegaTintasColorantes;

type
  TAuttinMenuItemMegaTintas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesMegaTintas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesMegaTintas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesMegaTintas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaMegaTintas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaMegaTintas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasMegaTintas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorMegaTintas, untLibTintaFactory, untGravandoExecucaoMegaTintasNovasFormulas, untCadastroBasesMegaTintas, 
  untCadastroColorantesMegaTintas, untGravandoExecucaoMegaTintasBases, 
  untCadastroNovasFormulasMegaTintas;

{ TAuttinMenuItemMegaTintas }

constructor TAuttinMenuItemMegaTintas.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesMegaTintas.Create());
  Self.Adicionar(TCadastroBasesMegaTintas.Create());
  Self.Adicionar(TCadastroColorantesMegaTintas.Create());
  Self.Adicionar(TCadastroNovasFormulasMegaTintas.Create());
  Self.Adicionar(TGeracaoTintaMegaTintas.Create());
  Self.Adicionar(TConsultaMegaTintas.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesMegaTintas }

constructor TConfiguracoesMegaTintas.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesMegaTintas');
end;

procedure TConfiguracoesMegaTintas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorMegaTintas.Create(auttinWrapper));
end;

{ TCadastroBasesMegaTintas }

constructor TCadastroBasesMegaTintas.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadMEGBase');
end;

procedure TCadastroBasesMegaTintas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesMegaTintas.TCadastroBasesMegaTintas.Create());
end;

{ TConsultaMegaTintas }

constructor TConsultaMegaTintas.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaMegaTintas');
end;

procedure TConsultaMegaTintas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaMegaTintas }

constructor TGeracaoTintaMegaTintas.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadMEGGeraArquivo');
end;

procedure TGeracaoTintaMegaTintas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Mega Tintas', [
    TGravandoExecucaoMegaTintasColorantes.Create,
    TGravandoExecucaoMegaTintasBases.Create,
    TGravandoExecucaoMegaTintasCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadMEGGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Mega Tintas', [
    TGravandoExecucaoMegaTintasNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesMegaTintas }

constructor TCadastroColorantesMegaTintas.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadMEGColorantes');
end;

procedure TCadastroColorantesMegaTintas.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesMegaTintas.TCadastroColorantesMegaTintas.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasMegaTintas.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadMEGNovasFormulas');  
end;

procedure TCadastroNovasFormulasMegaTintas.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasMegaTintas.TCadastroNovasFormulasMegaTintas.Create);
end;

end.
