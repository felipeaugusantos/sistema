{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemRennerPerformance;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper;

type
  TAuttinMenuItemRennerPerformance = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesRennerPerformance = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesRennerPerformance = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesRennerPerformance = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaRennerPerformance = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasRennerPerformance = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

   TGeracaoRennerPerformance = Class(TGenericAuttinMenuItem)
  Public
    constructor Create(); Reintroduce;
    procedure Executar(const AuttinWrapper: IAuttinWrapper); Override;
  End;

implementation

uses
  untConfiguradorRennerPerformance, untLibTintaFactory, untGravandoExecucaoRennerPerformanceNovasFormulas, untCadastroBasesRennerPerformance, 
  untCadastroColorantesRennerPerformance, untCadastroNovasFormulasRennerPerformance, untGravandoExecucaoRennerPerformanceBases,
  untGravandoExecucaoRennerPerformanceCores, untGravandoExecucaoRennerPerformanceColorantes;

{ TAuttinMenuItemRennerPerformance }

constructor TAuttinMenuItemRennerPerformance.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesRennerPerformance.Create());
  Self.Adicionar(TCadastroBasesRennerPerformance.Create());
  Self.Adicionar(TCadastroColorantesRennerPerformance.Create());
  Self.Adicionar(TCadastroNovasFormulasRennerPerformance.Create());
  Self.Adicionar(TConsultaRennerPerformance.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
  Self.Adicionar(TGeracaoRennerPerformance.Create());
end;

{ TConfiguracoesRennerPerformance }

constructor TConfiguracoesRennerPerformance.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesRennerPerformance');
end;

procedure TConfiguracoesRennerPerformance.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorRennerPerformance.Create(auttinWrapper));
end;

{ TCadastroBasesRennerPerformance }

constructor TCadastroBasesRennerPerformance.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadREPBase');
end;

procedure TCadastroBasesRennerPerformance.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesRennerPerformance.TCadastroBasesRennerPerformance.Create());
end;

{ TConsultaRennerPerformance }

constructor TConsultaRennerPerformance.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaRennerPerformance');
end;

procedure TConsultaRennerPerformance.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;


{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadREPGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('RennerPerformance', [
    TGravandoExecucaoRennerPerformanceNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesRennerPerformance }

constructor TCadastroColorantesRennerPerformance.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadREPColorantes');
end;

procedure TCadastroColorantesRennerPerformance.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesRennerPerformance.TCadastroColorantesRennerPerformance.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasRennerPerformance.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadREPNovasFormulas');
end;

procedure TCadastroNovasFormulasRennerPerformance.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasRennerPerformance.TCadastroNovasFormulasRennerPerformance.Create);
end;

{ TGeracaoRennerPerformance }

constructor TGeracaoRennerPerformance.Create;
begin
  Inherited Create('Gerar Cadastro de Tintas', 'frmCadREPGeraArquivo');
end;

procedure TGeracaoRennerPerformance.Executar(
  const AuttinWrapper: IAuttinWrapper);
begin
  AuttinWrapper.ProcessarArquivos('Renner Performance',
    [TGravandoExecucaoRennerPerformanceBases.Create,
     TGravandoExecucaoRennerPerformanceColorantes.Create,
     TGravandoExecucaoRennerPerformanceCores.Create]);
end;

end.
