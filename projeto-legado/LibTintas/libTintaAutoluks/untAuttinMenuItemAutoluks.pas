{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************PH*}
unit untAuttinMenuItemAutoluks;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoAutoluksCores;

type
  TAuttinMenuItemAutoluks = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesAutoluks = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesAutoluks = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaAutoluks = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaAutoluks = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasAutoluks = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroMontadoraAutoluks = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;


implementation

uses
  untConfiguradorAutoluks, untLibTintaFactory, untGravandoExecucaoAutoluksNovasFormulas, untCadastroBasesAutoluks,
  untGravandoExecucaoAutoluksBases, untCadastroNovasFormulasAutoluks, untCadastroMontadoraAutoluks,
  untGravandoExecucaoAutoluksMontadora;

{ TAuttinMenuItemAutoluks }

constructor TAuttinMenuItemAutoluks.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesAutoluks.Create());
  Self.Adicionar(TCadastroBasesAutoluks.Create());
  Self.Adicionar(TCadastroNovasFormulasAutoluks.Create());
  Self.Adicionar(TCadastroMontadoraAutoluks.Create());
  Self.Adicionar(TGeracaoTintaAutoluks.Create());
  Self.Adicionar(TConsultaAutoluks.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesAutoluks }

constructor TConfiguracoesAutoluks.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesAutoluks');
end;

procedure TConfiguracoesAutoluks.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorAutoluks.Create(auttinWrapper));
end;

{ TCadastroBasesAutoluks }

constructor TCadastroBasesAutoluks.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadALKBase');
end;

procedure TCadastroBasesAutoluks.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesAutoluks.TCadastroBasesAutoluks.Create());
end;

{ TConsultaAutoluks }

constructor TConsultaAutoluks.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaAutoluks');
end;

procedure TConsultaAutoluks.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaAutoluks }

constructor TGeracaoTintaAutoluks.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadALKGeraArquivo');
end;

procedure TGeracaoTintaAutoluks.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Autoluks', [
    TGravandoExecucaoAutoluksBases.Create,
    TGravandoExecucaoAutoluksCores.Create,
    TGravandoExecucaoAutoluksMontadora.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadALKGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Autoluks', [
    TGravandoExecucaoAutoluksNovasFormulas.Create
  ]);
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasAutoluks.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadALKNovasFormulas');
end;

procedure TCadastroNovasFormulasAutoluks.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasAutoluks.TCadastroNovasFormulasAutoluks.Create);
end;

{ TCadastroMontadoraAutoluks }

constructor TCadastroMontadoraAutoluks.Create;
begin
  inherited Create('Cadastro de Montadora', 'frmCadALKMontadora');
end;

procedure TCadastroMontadoraAutoluks.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroMontadoraAutoluks.TCadastroMontadoraAutoluks.Create);
end;

end.
