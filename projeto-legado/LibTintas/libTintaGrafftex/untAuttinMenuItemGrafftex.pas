{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************PH*}
unit untAuttinMenuItemGrafftex;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoGrafftexCores,
  untGravandoExecucaoGrafftexColorantes;

type
  TAuttinMenuItemGrafftex = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesGrafftex = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesGrafftex = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesGrafftex = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaGrafftex = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaGrafftex = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasGrafftex = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorGrafftex, untLibTintaFactory, untGravandoExecucaoGrafftexNovasFormulas, untCadastroBasesGrafftex, 
  untCadastroColorantesGrafftex, untGravandoExecucaoGrafftexBases, 
  untCadastroNovasFormulasGrafftex;

{ TAuttinMenuItemGrafftex }

constructor TAuttinMenuItemGrafftex.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesGrafftex.Create());
  Self.Adicionar(TCadastroBasesGrafftex.Create());
  Self.Adicionar(TCadastroColorantesGrafftex.Create());
  Self.Adicionar(TCadastroNovasFormulasGrafftex.Create());
  Self.Adicionar(TGeracaoTintaGrafftex.Create());
  Self.Adicionar(TConsultaGrafftex.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesGrafftex }

constructor TConfiguracoesGrafftex.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesGrafftex');
end;

procedure TConfiguracoesGrafftex.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorGrafftex.Create(auttinWrapper));
end;

{ TCadastroBasesGrafftex }

constructor TCadastroBasesGrafftex.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadGRABase');
end;

procedure TCadastroBasesGrafftex.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesGrafftex.TCadastroBasesGrafftex.Create());
end;

{ TConsultaGrafftex }

constructor TConsultaGrafftex.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaGrafftex');
end;

procedure TConsultaGrafftex.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaGrafftex }

constructor TGeracaoTintaGrafftex.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadGRAGeraArquivo');
end;

procedure TGeracaoTintaGrafftex.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Grafftex', [
    TGravandoExecucaoGrafftexColorantes.Create,
    TGravandoExecucaoGrafftexBases.Create,
    TGravandoExecucaoGrafftexCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadGRAGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Grafftex', [
    TGravandoExecucaoGrafftexNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesGrafftex }

constructor TCadastroColorantesGrafftex.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadGRAColorantes');
end;

procedure TCadastroColorantesGrafftex.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesGrafftex.TCadastroColorantesGrafftex.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasGrafftex.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadGRANovasFormulas');  
end;

procedure TCadastroNovasFormulasGrafftex.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasGrafftex.TCadastroNovasFormulasGrafftex.Create);
end;

end.
