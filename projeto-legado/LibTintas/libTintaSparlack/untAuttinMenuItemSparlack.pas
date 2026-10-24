{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************PH*}
unit untAuttinMenuItemSparlack;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoSparlackCores,
  untGravandoExecucaoSparlackColorantes;

type
  TAuttinMenuItemSparlack = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesSparlack = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesSparlack = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;


  TCadastroColorantesSparlack = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaSparlack = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaSparlack = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasSparlack = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorSparlack, untLibTintaFactory, untGravandoExecucaoSparlackNovasFormulas, untCadastroBasesSparlack,
  untCadastroColorantesSparlack, untGravandoExecucaoSparlackBases,
  untCadastroNovasFormulasSparlack;

{ TAuttinMenuItemSparlack }

constructor TAuttinMenuItemSparlack.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesSparlack.Create());
  Self.Adicionar(TCadastroBasesSparlack.Create());
  Self.Adicionar(TCadastroColorantesSparlack.Create());
  Self.Adicionar(TCadastroNovasFormulasSparlack.Create());
  Self.Adicionar(TGeracaoTintaSparlack.Create());
  Self.Adicionar(TConsultaSparlack.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesSparlack }

constructor TConfiguracoesSparlack.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesSparlack');
end;

procedure TConfiguracoesSparlack.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorSparlack.Create(auttinWrapper));
end;

{ TCadastroBasesSparlack }

constructor TCadastroBasesSparlack.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadSPABase');
end;

procedure TCadastroBasesSparlack.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesSparlack.TCadastroBasesSparlack.Create());
end;


{ TConsultaSparlack }

constructor TConsultaSparlack.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaSparlack');
end;

procedure TConsultaSparlack.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaSparlack }

constructor TGeracaoTintaSparlack.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadSPAGeraArquivo');
end;

procedure TGeracaoTintaSparlack.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Sparlack Industrial', [
    TGravandoExecucaoSparlackColorantes.Create,
    TGravandoExecucaoSparlackBases.Create,
    TGravandoExecucaoSparlackCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadSPAGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Sparlack Industrial', [
    TGravandoExecucaoSparlackNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesSparlack }

constructor TCadastroColorantesSparlack.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadSPAColorantes');
end;

procedure TCadastroColorantesSparlack.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesSparlack.TCadastroColorantesSparlack.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasSparlack.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadSPANovasFormulas');  
end;

procedure TCadastroNovasFormulasSparlack.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasSparlack.TCadastroNovasFormulasSparlack.Create);
end;

end.
