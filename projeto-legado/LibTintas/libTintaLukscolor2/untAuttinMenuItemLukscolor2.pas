{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************PH*}
unit untAuttinMenuItemLukscolor2;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoLukscolor2Cores,
  untGravandoExecucaoLukscolor2Colorantes;

type
  TAuttinMenuItemLukscolor2 = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesLukscolor2 = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesLukscolor2 = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesLukscolor2 = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaLukscolor2 = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaLukscolor2 = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasLukscolor2 = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorLukscolor2, untLibTintaFactory, untGravandoExecucaoLukscolor2NovasFormulas, untCadastroBasesLukscolor2, 
  untCadastroColorantesLukscolor2, untGravandoExecucaoLukscolor2Bases,
  untCadastroNovasFormulasLukscolor2;

{ TAuttinMenuItemLukscolor2 }

constructor TAuttinMenuItemLukscolor2.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesLukscolor2.Create());
  Self.Adicionar(TCadastroBasesLukscolor2.Create());
  Self.Adicionar(TCadastroColorantesLukscolor2.Create());
  Self.Adicionar(TCadastroNovasFormulasLukscolor2.Create());
  Self.Adicionar(TGeracaoTintaLukscolor2.Create());
  Self.Adicionar(TConsultaLukscolor2.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesLukscolor2 }

constructor TConfiguracoesLukscolor2.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesLukscolor2');
end;

procedure TConfiguracoesLukscolor2.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorLukscolor2.Create(auttinWrapper));
end;

{ TCadastroBasesLukscolor2 }

constructor TCadastroBasesLukscolor2.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadLKCBase');
end;

procedure TCadastroBasesLukscolor2.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesLukscolor2.TCadastroBasesLukscolor2.Create());
end;

{ TConsultaLukscolor2 }

constructor TConsultaLukscolor2.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaLukscolor2');
end;

procedure TConsultaLukscolor2.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaLukscolor2 }

constructor TGeracaoTintaLukscolor2.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadLKCGeraArquivo');
end;

procedure TGeracaoTintaLukscolor2.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Lukscolor 2', [
    TGravandoExecucaoLukscolor2Colorantes.Create,
    TGravandoExecucaoLukscolor2Bases.Create,
    TGravandoExecucaoLukscolor2Cores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadLKCGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Lukscolor 2', [
    TGravandoExecucaoLukscolor2NovasFormulas.Create
  ]);
end;

{ TCadastroColorantesLukscolor2 }

constructor TCadastroColorantesLukscolor2.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadLKCColorantes');
end;

procedure TCadastroColorantesLukscolor2.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesLukscolor2.TCadastroColorantesLukscolor2.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasLukscolor2.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadLKCNovasFormulas');
end;

procedure TCadastroNovasFormulasLukscolor2.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasLukscolor2.TCadastroNovasFormulasLukscolor2.Create);
end;


end.
