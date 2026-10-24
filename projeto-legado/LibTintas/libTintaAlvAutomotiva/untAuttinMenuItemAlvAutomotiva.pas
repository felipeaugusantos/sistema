{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemAlvAutomotiva;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoAlvAutomotivaBases,
  untGravandoExecucaoAlvAutomotivaCores,
  untGravandoExecucaoAlvAutomotivaDiluentes;

type
  TAuttinMenuItemAlvAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesAlvAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesAlvAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaAlvAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaAlvAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasAlvAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorAlvAutomotiva, untLibTintaFactory, untGravandoExecucaoAlvAutomotivaNovasFormulas, untCadastroBasesAlvAutomotiva,
  untCadastroNovasFormulasAlvAutomotiva;

{ TAuttinMenuItemAlvAutomotiva }

constructor TAuttinMenuItemAlvAutomotiva.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesAlvAutomotiva.Create());
  Self.Adicionar(TCadastroBasesAlvAutomotiva.Create());
  Self.Adicionar(TGeracaoTintaAlvAutomotiva.Create());
  Self.Adicionar(TCadastroNovasFormulasAlvAutomotiva.Create());
  Self.Adicionar(TConsultaAlvAutomotiva.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesAlvAutomotiva }

constructor TConfiguracoesAlvAutomotiva.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesAlvAutomotiva');
end;

procedure TConfiguracoesAlvAutomotiva.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorAlvAutomotiva.Create(auttinWrapper));
end;

{ TCadastroBasesAlvAutomotiva }

constructor TCadastroBasesAlvAutomotiva.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadALABase');
end;

procedure TCadastroBasesAlvAutomotiva.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesAlvAutomotiva.TCadastroBasesAlvAutomotiva.Create());
end;

{ TConsultaAlvAutomotiva }

constructor TConsultaAlvAutomotiva.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaAlvAutomotiva');
end;

procedure TConsultaAlvAutomotiva.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;


{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadALAGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('AlvAutomotiva', [
    TGravandoExecucaoAlvAutomotivaNovasFormulas.Create
  ]);
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasAlvAutomotiva.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadALANovasFormulas');
end;

procedure TCadastroNovasFormulasAlvAutomotiva.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasAlvAutomotiva.TCadastroNovasFormulasAlvAutomotiva.Create);
end;

{ TGeracaoTintaAlvAutomotiva }

constructor TGeracaoTintaAlvAutomotiva.Create;
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadALAGeraArquivo');
end;

procedure TGeracaoTintaAlvAutomotiva.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('AlvAutomotiva', [
    TGravandoExecucaoAlvAutomotivaBases.Create,
    TGravandoExecucaoAlvAutomotivaDiluentes.Create,
    TGravandoExecucaoAlvAutomotivaCores.Create
  ]);
end;

end.
