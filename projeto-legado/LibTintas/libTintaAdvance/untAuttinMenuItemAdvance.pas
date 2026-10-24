{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemAdvance;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoAdvanceCores,
  untGravandoExecucaoAdvanceEmbalagem;

type
  TAuttinMenuItemAdvance = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesAdvance = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesAdvanceCorob = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesAdvanceCorob = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaAdvance = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaAdvance = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasAdvanceCorob = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroEmbalagensAdvance = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorAdvance, untLibTintaFactory, untGravandoExecucaoAdvanceNovasFormulas, untCadastroBasesAdvanceCorob,
  untCadastroColorantesAdvanceCorob, untGravandoExecucaoAdvanceBases,
  untCadastroNovasFormulasAdvanceCorob, untCadastroEmbalagensAdvance;

{ TAuttinMenuItemAdvance }

constructor TAuttinMenuItemAdvance.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesAdvance.Create());
  Self.Adicionar(TCadastroBasesAdvanceCorob.Create());
  Self.Adicionar(TCadastroColorantesAdvanceCorob.Create());
  Self.Adicionar(TCadastroEmbalagensAdvance.Create());
  Self.Adicionar(TCadastroNovasFormulasAdvanceCorob.Create());
  Self.Adicionar(TGeracaoTintaAdvance.Create());
  Self.Adicionar(TConsultaAdvance.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesAdvance }

constructor TConfiguracoesAdvance.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesAdvance');
end;

procedure TConfiguracoesAdvance.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorAdvance.Create(auttinWrapper));
end;

{ TCadastroBasesAdvance }

constructor TCadastroBasesAdvanceCorob.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadADVBase');
end;

procedure TCadastroBasesAdvanceCorob.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesAdvanceCorob.TCadastroBasesAdvanceCorob.Create());
end;

{ TConsultaAdvance }

constructor TConsultaAdvance.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaAdvance');
end;

procedure TConsultaAdvance.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaAdvance }

constructor TGeracaoTintaAdvance.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadADVGeraArquivo');
end;

procedure TGeracaoTintaAdvance.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Advance', [
    TGravandoExecucaoAdvanceEmbalagem.Create,
    TGravandoExecucaoAdvanceBases.Create,
    TGravandoExecucaoAdvanceCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadADVGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Advance Imobiliária', [
    TGravandoExecucaoAdvanceNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesAdvance }

constructor TCadastroColorantesAdvanceCorob.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadADVColorantes');
end;

procedure TCadastroColorantesAdvanceCorob.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesAdvanceCorob.TCadastroColorantesAdvanceCorob.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasAdvanceCorob.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadADVNovasFormulas');  
end;

procedure TCadastroNovasFormulasAdvanceCorob.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasAdvanceCorob.TCadastroNovasFormulasAdvanceCorob.Create);
end;

{ TCadastroEmbalagensAdvance }

constructor TCadastroEmbalagensAdvance.Create;
begin
  inherited Create('Cadastro de Embalagens', 'frmCadADVEmbalagens');
end;

procedure TCadastroEmbalagensAdvance.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroEmbalagensAdvance.TCadastroEmbalagensAdvance.Create);
end;

end.
