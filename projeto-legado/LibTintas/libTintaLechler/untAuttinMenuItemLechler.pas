{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemLechler;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper;

type
  TAuttinMenuItemLechler = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesLechler = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesLechler = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesLechler = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaLechler = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasLechler = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorLechler, untLibTintaFactory, untGravandoExecucaoLechlerNovasFormulas, untCadastroBasesLechler, 
  untCadastroColorantesLechler, untCadastroNovasFormulasLechler;

{ TAuttinMenuItemLechler }

constructor TAuttinMenuItemLechler.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesLechler.Create());
  Self.Adicionar(TCadastroBasesLechler.Create());
  Self.Adicionar(TCadastroColorantesLechler.Create());
  Self.Adicionar(TCadastroNovasFormulasLechler.Create());
  Self.Adicionar(TConsultaLechler.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesLechler }

constructor TConfiguracoesLechler.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesLechler');
end;

procedure TConfiguracoesLechler.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorLechler.Create(auttinWrapper));
end;

{ TCadastroBasesLechler }

constructor TCadastroBasesLechler.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadLECBase');
end;

procedure TCadastroBasesLechler.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesLechler.TCadastroBasesLechler.Create());
end;

{ TConsultaLechler }

constructor TConsultaLechler.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaLechler');
end;

procedure TConsultaLechler.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;


{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadLECGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Lechler', [
    TGravandoExecucaoLechlerNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesLechler }

constructor TCadastroColorantesLechler.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadLECColorantes');
end;

procedure TCadastroColorantesLechler.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesLechler.TCadastroColorantesLechler.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasLechler.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadLECNovasFormulas');
end;

procedure TCadastroNovasFormulasLechler.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasLechler.TCadastroNovasFormulasLechler.Create);
end;

end.
