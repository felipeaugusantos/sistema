{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************PH*}
unit untAuttinMenuItemKilling;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoKillingCores,
  untGravandoExecucaoKillingColorantes;

type
  TAuttinMenuItemKilling = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesKilling = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesKilling = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;


  TCadastroColorantesKilling = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaKilling = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaKilling = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasKilling = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorKilling, untLibTintaFactory, untGravandoExecucaoKillingNovasFormulas, untCadastroBasesKilling,
  untCadastroColorantesKilling, untGravandoExecucaoKillingBases,
  untCadastroNovasFormulasKilling;

{ TAuttinMenuItemKilling }

constructor TAuttinMenuItemKilling.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesKilling.Create());
  Self.Adicionar(TCadastroBasesKilling.Create());
  Self.Adicionar(TCadastroColorantesKilling.Create());
  Self.Adicionar(TCadastroNovasFormulasKilling.Create());
  Self.Adicionar(TGeracaoTintaKilling.Create());
  Self.Adicionar(TConsultaKilling.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesKilling }

constructor TConfiguracoesKilling.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesKilling');
end;

procedure TConfiguracoesKilling.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorKilling.Create(auttinWrapper));
end;

{ TCadastroBasesKilling }

constructor TCadastroBasesKilling.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadKILDBase');
end;

procedure TCadastroBasesKilling.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesKilling.TCadastroBasesKilling.Create());
end;


{ TConsultaKilling }

constructor TConsultaKilling.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaKilling');
end;

procedure TConsultaKilling.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaKilling }

constructor TGeracaoTintaKilling.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadKILDGeraArquivo');
end;

procedure TGeracaoTintaKilling.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Killing', [
    TGravandoExecucaoKillingColorantes.Create,
    TGravandoExecucaoKillingBases.Create,
    TGravandoExecucaoKillingCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadKILDGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Killing', [
    TGravandoExecucaoKillingNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesKilling }

constructor TCadastroColorantesKilling.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadKILDColorantes');
end;

procedure TCadastroColorantesKilling.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesKilling.TCadastroColorantesKilling.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasKilling.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadKILDNovasFormulas');  
end;

procedure TCadastroNovasFormulasKilling.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasKilling.TCadastroNovasFormulasKilling.Create);
end;

end.
