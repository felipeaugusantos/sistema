{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemTexturaCia;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoTexturaCiaCores,
  untGravandoExecucaoTexturaCiaColorantes;

type
  TAuttinMenuItemTexturaCia = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesTexturaCia = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesTexturaCia = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesTexturaCia = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaTexturaCia = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaTexturaCia = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasTexturaCia = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorTexturaCia, untLibTintaFactory, untGravandoExecucaoTexturaCiaNovasFormulas, untCadastroBasesTexturaCia, 
  untCadastroColorantesTexturaCia, untGravandoExecucaoTexturaCiaBases, 
  untCadastroNovasFormulasTexturaCia;

{ TAuttinMenuItemTexturaCia }

constructor TAuttinMenuItemTexturaCia.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesTexturaCia.Create());
  Self.Adicionar(TCadastroBasesTexturaCia.Create());
  Self.Adicionar(TCadastroColorantesTexturaCia.Create());
  Self.Adicionar(TCadastroNovasFormulasTexturaCia.Create());
  Self.Adicionar(TGeracaoTintaTexturaCia.Create());
  Self.Adicionar(TConsultaTexturaCia.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesTexturaCia }

constructor TConfiguracoesTexturaCia.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesTexturaCia');
end;

procedure TConfiguracoesTexturaCia.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorTexturaCia.Create(auttinWrapper));
end;

{ TCadastroBasesTexturaCia }

constructor TCadastroBasesTexturaCia.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadTEXBase');
end;

procedure TCadastroBasesTexturaCia.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesTexturaCia.TCadastroBasesTexturaCia.Create());
end;

{ TConsultaTexturaCia }

constructor TConsultaTexturaCia.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaTexturaCia');
end;

procedure TConsultaTexturaCia.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaTexturaCia }

constructor TGeracaoTintaTexturaCia.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadTEXGeraArquivo');
end;

procedure TGeracaoTintaTexturaCia.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('TexturaCia', [
    TGravandoExecucaoTexturaCiaColorantes.Create,
    TGravandoExecucaoTexturaCiaBases.Create,
    TGravandoExecucaoTexturaCiaCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadTEXGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('TexturaCia Imobiliária', [
    TGravandoExecucaoTexturaCiaNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesTexturaCia }

constructor TCadastroColorantesTexturaCia.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadTEXColorantes');
end;

procedure TCadastroColorantesTexturaCia.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesTexturaCia.TCadastroColorantesTexturaCia.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasTexturaCia.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadTEXNovasFormulas');  
end;

procedure TCadastroNovasFormulasTexturaCia.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasTexturaCia.TCadastroNovasFormulasTexturaCia.Create);
end;


end.
