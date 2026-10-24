{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************PH*}
unit untAuttinMenuItemCiacollor;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoCiacollorCores,
  untGravandoExecucaoCiacollorColorantes;

type
  TAuttinMenuItemCiacollor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesCiacollor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesCiacollor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesCiacollor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaCiacollor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaCiacollor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasCiacollor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorCiacollor, untLibTintaFactory, untGravandoExecucaoCiacollorNovasFormulas, untCadastroBasesCiacollor, 
  untCadastroColorantesCiacollor, untGravandoExecucaoCiacollorBases, 
  untCadastroNovasFormulasCiacollor;

{ TAuttinMenuItemCiacollor }

constructor TAuttinMenuItemCiacollor.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesCiacollor.Create());
  Self.Adicionar(TCadastroBasesCiacollor.Create());
  Self.Adicionar(TCadastroColorantesCiacollor.Create());
  Self.Adicionar(TCadastroNovasFormulasCiacollor.Create());
  Self.Adicionar(TGeracaoTintaCiacollor.Create());
  Self.Adicionar(TConsultaCiacollor.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesCiacollor }

constructor TConfiguracoesCiacollor.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesCiacollor');
end;

procedure TConfiguracoesCiacollor.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorCiacollor.Create(auttinWrapper));
end;

{ TCadastroBasesCiacollor }

constructor TCadastroBasesCiacollor.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadCIABase');
end;

procedure TCadastroBasesCiacollor.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesCiacollor.TCadastroBasesCiacollor.Create());
end;

{ TConsultaCiacollor }

constructor TConsultaCiacollor.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaCiacollor');
end;

procedure TConsultaCiacollor.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaCiacollor }

constructor TGeracaoTintaCiacollor.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadCIAGeraArquivo');
end;

procedure TGeracaoTintaCiacollor.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Ciacollor', [
    TGravandoExecucaoCiacollorColorantes.Create,
    TGravandoExecucaoCiacollorBases.Create,
    TGravandoExecucaoCiacollorCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadCIAGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Ciacollor', [
    TGravandoExecucaoCiacollorNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesCiacollor }

constructor TCadastroColorantesCiacollor.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadCIAColorantes');
end;

procedure TCadastroColorantesCiacollor.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesCiacollor.TCadastroColorantesCiacollor.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasCiacollor.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadCIANovasFormulas');  
end;

procedure TCadastroNovasFormulasCiacollor.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasCiacollor.TCadastroNovasFormulasCiacollor.Create);
end;

end.
