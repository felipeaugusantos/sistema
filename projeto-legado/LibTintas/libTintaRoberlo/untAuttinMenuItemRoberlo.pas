{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemRoberlo;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoRoberloCores, untGravandoExecucaoRoberloBases;

type
  TAuttinMenuItemRoberlo = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesRoberlo = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesRoberlo = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaRoberlo = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasRoberlo = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoRoberlo = Class(TGenericAuttinMenuItem)
  Public
    constructor Create(); Reintroduce;
    procedure Executar(const AuttinWrapper: IAuttinWrapper); Override;
  End;

implementation

uses
  untConfiguradorRoberlo, untLibTintaFactory, untGravandoExecucaoRoberloNovasFormulas, untCadastroBasesRoberlo, 
  untCadastroNovasFormulasRoberlo;

{ TAuttinMenuItemRoberlo }

constructor TAuttinMenuItemRoberlo.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesRoberlo.Create());
  Self.Adicionar(TCadastroBasesRoberlo.Create());
  Self.Adicionar(TCadastroNovasFormulasRoberlo.Create());
  Self.Adicionar(TConsultaRoberlo.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
  Self.Adicionar(TGeracaoRoberlo.Create());
end;

{ TConfiguracoesRoberlo }

constructor TConfiguracoesRoberlo.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesRoberlo');
end;

procedure TConfiguracoesRoberlo.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorRoberlo.Create(auttinWrapper));
end;

{ TCadastroBasesRoberlo }

constructor TCadastroBasesRoberlo.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadROBBase');
end;

procedure TCadastroBasesRoberlo.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesRoberlo.TCadastroBasesRoberlo.Create());
end;

{ TConsultaRoberlo }

constructor TConsultaRoberlo.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaRoberlo');
end;

procedure TConsultaRoberlo.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;


{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadROBGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Roberlo', [
    TGravandoExecucaoRoberloNovasFormulas.Create
  ]);
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasRoberlo.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadROBNovasFormulas');
end;

procedure TCadastroNovasFormulasRoberlo.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasRoberlo.TCadastroNovasFormulasRoberlo.Create);
end;

{ TGeracaoRoberlo }

constructor TGeracaoRoberlo.Create;
begin
  Inherited Create('Gerar Cadastro de Tintas', 'frmCadROBGeraArquivo');
end;

procedure TGeracaoRoberlo.Executar(const AuttinWrapper: IAuttinWrapper);
begin
  AuttinWrapper.ProcessarArquivos('Roberlo',
    [TGravandoExecucaoRoberloBases.Create,
     TGravandoExecucaoRoberloCores.Create
    ]);
end;

end.
