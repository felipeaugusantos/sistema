{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemAdvanceStr;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoAdvanceStrCores,
  untGravandoExecucaoAdvanceStrColorantes;

type
  TAuttinMenuItemAdvanceStr = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesAdvanceStr = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesAdvanceStr = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesAdvanceStr = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaAdvanceStr = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaAdvanceStr = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasAdvanceStr = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroLinhaAdvanceStr = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorAdvanceStr, untLibTintaFactory, untGravandoExecucaoAdvanceStrNovasFormulas, untCadastroBasesAdvanceStr, 
  untCadastroColorantesAdvanceStr, untGravandoExecucaoAdvanceStrBases, 
  untCadastroNovasFormulasAdvanceStr, untCadastroLinhaAdvanceStr;

{ TAuttinMenuItemAdvanceStr }

constructor TAuttinMenuItemAdvanceStr.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesAdvanceStr.Create());
  Self.Adicionar(TCadastroBasesAdvanceStr.Create());
  Self.Adicionar(TCadastroColorantesAdvanceStr.Create());
  Self.Adicionar(TCadastroLinhaAdvanceStr.Create());
  Self.Adicionar(TCadastroNovasFormulasAdvanceStr.Create());
  Self.Adicionar(TGeracaoTintaAdvanceStr.Create());
  Self.Adicionar(TConsultaAdvanceStr.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesAdvanceStr }

constructor TConfiguracoesAdvanceStr.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesAdvanceStr');
end;

procedure TConfiguracoesAdvanceStr.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorAdvanceStr.Create(auttinWrapper));
end;

{ TCadastroBasesAdvanceStr }

constructor TCadastroBasesAdvanceStr.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadADSBase');
end;

procedure TCadastroBasesAdvanceStr.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesAdvanceStr.TCadastroBasesAdvanceStr.Create());
end;

{ TConsultaAdvanceStr }

constructor TConsultaAdvanceStr.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaAdvanceStr');
end;

procedure TConsultaAdvanceStr.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaAdvanceStr }

constructor TGeracaoTintaAdvanceStr.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadADSGeraArquivo');
end;

procedure TGeracaoTintaAdvanceStr.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('AdvanceStr', [
    TGravandoExecucaoAdvanceStrColorantes.Create,
    TGravandoExecucaoAdvanceStrBases.Create,
    TGravandoExecucaoAdvanceStrCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadADSGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('AdvanceStr Imobiliária', [
    TGravandoExecucaoAdvanceStrNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesAdvanceStr }

constructor TCadastroColorantesAdvanceStr.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadADSColorantes');
end;

procedure TCadastroColorantesAdvanceStr.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesAdvanceStr.TCadastroColorantesAdvanceStr.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasAdvanceStr.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadADSNovasFormulas');  
end;

procedure TCadastroNovasFormulasAdvanceStr.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasAdvanceStr.TCadastroNovasFormulasAdvanceStr.Create);
end;


{ TCadastroLinhaAdvanceStr }

constructor TCadastroLinhaAdvanceStr.Create;
begin
  inherited Create('Cadastro de Linhas', 'frmCadADSLinha');
end;

procedure TCadastroLinhaAdvanceStr.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroLinhaAdvanceStr.TCadastroLinhaAdvanceStr.Create);
end;

end.
