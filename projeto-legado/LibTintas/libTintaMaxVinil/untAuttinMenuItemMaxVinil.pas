{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemMaxVinil;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoMaxVinilCores,
  untGravandoExecucaoMaxVinilColorantes;

type
  TAuttinMenuItemMaxVinil = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesMaxVinil = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesMaxVinil = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesMaxVinil = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaMaxVinil = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaMaxVinil = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasMaxVinil = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorMaxVinil, untLibTintaFactory, untGravandoExecucaoMaxVinilNovasFormulas, untCadastroBasesMaxVinil, 
  untCadastroColorantesMaxVinil, untGravandoExecucaoMaxVinilBases, 
  untCadastroNovasFormulasMaxVinil;

{ TAuttinMenuItemMaxVinil }

constructor TAuttinMenuItemMaxVinil.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesMaxVinil.Create());
  Self.Adicionar(TCadastroBasesMaxVinil.Create());
  Self.Adicionar(TCadastroColorantesMaxVinil.Create());
  Self.Adicionar(TCadastroNovasFormulasMaxVinil.Create());
  Self.Adicionar(TGeracaoTintaMaxVinil.Create());
  Self.Adicionar(TConsultaMaxVinil.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesMaxVinil }

constructor TConfiguracoesMaxVinil.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesMaxVinil');
end;

procedure TConfiguracoesMaxVinil.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorMaxVinil.Create(auttinWrapper));
end;

{ TCadastroBasesMaxVinil }

constructor TCadastroBasesMaxVinil.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadMAXBase');
end;

procedure TCadastroBasesMaxVinil.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesMaxVinil.TCadastroBasesMaxVinil.Create());
end;

{ TConsultaMaxVinil }

constructor TConsultaMaxVinil.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaMaxVinil');
end;

procedure TConsultaMaxVinil.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaMaxVinil }

constructor TGeracaoTintaMaxVinil.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadMAXGeraArquivo');
end;

procedure TGeracaoTintaMaxVinil.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('MaxVinil', [
    TGravandoExecucaoMaxVinilColorantes.Create,
    TGravandoExecucaoMaxVinilBases.Create,
    TGravandoExecucaoMaxVinilCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadMAXGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('MaxVinil', [
    TGravandoExecucaoMaxVinilNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesMaxVinil }

constructor TCadastroColorantesMaxVinil.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadMAXColorantes');
end;

procedure TCadastroColorantesMaxVinil.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesMaxVinil.TCadastroColorantesMaxVinil.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasMaxVinil.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadMAXNovasFormulas');  
end;

procedure TCadastroNovasFormulasMaxVinil.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasMaxVinil.TCadastroNovasFormulasMaxVinil.Create);
end;

end.
