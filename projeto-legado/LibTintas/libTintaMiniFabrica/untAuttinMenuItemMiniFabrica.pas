{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************PH*}
unit untAuttinMenuItemMiniFabrica;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper;

type
  TAuttinMenuItemMiniFabrica = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesMiniFabrica = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesMiniFabrica = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaMiniFabrica = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasMiniFabrica = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroMontadoraMiniFabrica = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroLinhaMiniFabrica = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;


implementation

uses
  untConfiguradorMiniFabrica, untLibTintaFactory, untGravandoExecucaoMiniFabricaNovasFormulas, untCadastroBasesMiniFabrica,
  untCadastroNovasFormulasMiniFabrica, untCadastroMontadoraMiniFabrica, untCadastroLinhaMiniFabrica;

{ TAuttinMenuItemMiniFabrica }

constructor TAuttinMenuItemMiniFabrica.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesMiniFabrica.Create());
  Self.Adicionar(TCadastroBasesMiniFabrica.Create());
  Self.Adicionar(TCadastroLinhaMiniFabrica.Create());
  Self.Adicionar(TCadastroNovasFormulasMiniFabrica.Create());
  Self.Adicionar(TCadastroMontadoraMiniFabrica.Create());
  Self.Adicionar(TConsultaMiniFabrica.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesMiniFabrica }

constructor TConfiguracoesMiniFabrica.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesMiniFabrica');
end;

procedure TConfiguracoesMiniFabrica.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorMiniFabrica.Create(auttinWrapper));
end;

{ TCadastroBasesMiniFabrica }

constructor TCadastroBasesMiniFabrica.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadMIFBase');
end;

procedure TCadastroBasesMiniFabrica.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesMiniFabrica.TCadastroBasesMiniFabrica.Create());
end;

{ TConsultaMiniFabrica }

constructor TConsultaMiniFabrica.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaMiniFabrica');
end;

procedure TConsultaMiniFabrica.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadMIFGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('MiniFabrica', [
    TGravandoExecucaoMiniFabricaNovasFormulas.Create
  ]);
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasMiniFabrica.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadMIFNovasFormulas');
end;

procedure TCadastroNovasFormulasMiniFabrica.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasMiniFabrica.TCadastroNovasFormulasMiniFabrica.Create);
end;

{ TCadastroMontadoraMiniFabrica }

constructor TCadastroMontadoraMiniFabrica.Create;
begin
  inherited Create('Cadastro de Montadora', 'frmCadMIFMontadora');
end;

procedure TCadastroMontadoraMiniFabrica.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroMontadoraMiniFabrica.TCadastroMontadoraMiniFabrica.Create);
end;

{ TCadastroLinhaMiniFabrica }

constructor TCadastroLinhaMiniFabrica.Create;
begin
  inherited Create('Cadastro de Linhas', 'frmCadMIFLinha');
end;

procedure TCadastroLinhaMiniFabrica.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroLinhaMiniFabrica.TCadastroLinhaMiniFabrica.Create);
end;

end.
