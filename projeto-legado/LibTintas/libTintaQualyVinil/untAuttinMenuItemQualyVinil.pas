{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************PH*}
unit untAuttinMenuItemQualyVinil;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoQualyVinilCores,
  untGravandoExecucaoQualyVinilColorantes;

type
  TAuttinMenuItemQualyVinil = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesQualyVinil = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesQualyVinil = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesQualyVinil = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaQualyVinil = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaQualyVinil = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasQualyVinil = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorQualyVinil, untLibTintaFactory, untGravandoExecucaoQualyVinilNovasFormulas, untCadastroBasesQualyVinil, 
  untCadastroColorantesQualyVinil, untGravandoExecucaoQualyVinilBases, 
  untCadastroNovasFormulasQualyVinil;

{ TAuttinMenuItemQualyVinil }

constructor TAuttinMenuItemQualyVinil.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesQualyVinil.Create());
  Self.Adicionar(TCadastroBasesQualyVinil.Create());
  Self.Adicionar(TCadastroColorantesQualyVinil.Create());
  Self.Adicionar(TCadastroNovasFormulasQualyVinil.Create());
  Self.Adicionar(TGeracaoTintaQualyVinil.Create());
  Self.Adicionar(TConsultaQualyVinil.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesQualyVinil }

constructor TConfiguracoesQualyVinil.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesQualyVinil');
end;

procedure TConfiguracoesQualyVinil.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorQualyVinil.Create(auttinWrapper));
end;

{ TCadastroBasesQualyVinil }

constructor TCadastroBasesQualyVinil.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadQUABase');
end;

procedure TCadastroBasesQualyVinil.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesQualyVinil.TCadastroBasesQualyVinil.Create());
end;

{ TConsultaQualyVinil }

constructor TConsultaQualyVinil.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaQualyVinil');
end;

procedure TConsultaQualyVinil.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaQualyVinil }

constructor TGeracaoTintaQualyVinil.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadQUAGeraArquivo');
end;

procedure TGeracaoTintaQualyVinil.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('QualyVinil', [
    TGravandoExecucaoQualyVinilColorantes.Create,
    TGravandoExecucaoQualyVinilBases.Create,
    TGravandoExecucaoQualyVinilCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadQUAGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('QualyVinil', [
    TGravandoExecucaoQualyVinilNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesQualyVinil }

constructor TCadastroColorantesQualyVinil.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadQUAColorantes');
end;

procedure TCadastroColorantesQualyVinil.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesQualyVinil.TCadastroColorantesQualyVinil.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasQualyVinil.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadQUANovasFormulas');  
end;

procedure TCadastroNovasFormulasQualyVinil.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasQualyVinil.TCadastroNovasFormulasQualyVinil.Create);
end;

end.
