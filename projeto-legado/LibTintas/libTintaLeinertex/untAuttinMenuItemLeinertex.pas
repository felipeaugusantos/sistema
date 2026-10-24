{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemLeinertex;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoLeinertexCores,
  untGravandoExecucaoLeinertexColorantes;

type
  TAuttinMenuItemLeinertex = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesLeinertex = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesLeinertex = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesLeinertex = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaLeinertex = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaLeinertex = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasLeinertex = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorLeinertex, untLibTintaFactory, untGravandoExecucaoLeinertexNovasFormulas, untCadastroBasesLeinertex, 
  untCadastroColorantesLeinertex, untGravandoExecucaoLeinertexBases, 
  untCadastroNovasFormulasLeinertex;

{ TAuttinMenuItemLeinertex }

constructor TAuttinMenuItemLeinertex.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesLeinertex.Create());
  Self.Adicionar(TCadastroBasesLeinertex.Create());
  Self.Adicionar(TCadastroColorantesLeinertex.Create());
  Self.Adicionar(TCadastroNovasFormulasLeinertex.Create());
  Self.Adicionar(TGeracaoTintaLeinertex.Create());
  Self.Adicionar(TConsultaLeinertex.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesLeinertex }

constructor TConfiguracoesLeinertex.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesLeinertex');
end;

procedure TConfiguracoesLeinertex.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorLeinertex.Create(auttinWrapper));
end;

{ TCadastroBasesLeinertex }

constructor TCadastroBasesLeinertex.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadLEIBase');
end;

procedure TCadastroBasesLeinertex.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesLeinertex.TCadastroBasesLeinertex.Create());
end;

{ TConsultaLeinertex }

constructor TConsultaLeinertex.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaLeinertex');
end;

procedure TConsultaLeinertex.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaLeinertex }

constructor TGeracaoTintaLeinertex.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadLEIGeraArquivo');
end;

procedure TGeracaoTintaLeinertex.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Leinertex', [
    TGravandoExecucaoLeinertexColorantes.Create,
    TGravandoExecucaoLeinertexBases.Create,
    TGravandoExecucaoLeinertexCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadLEIGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Leinertex Imobiliária', [
    TGravandoExecucaoLeinertexNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesLeinertex }

constructor TCadastroColorantesLeinertex.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadLEIColorantes');
end;

procedure TCadastroColorantesLeinertex.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesLeinertex.TCadastroColorantesLeinertex.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasLeinertex.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadLEINovasFormulas');  
end;

procedure TCadastroNovasFormulasLeinertex.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasLeinertex.TCadastroNovasFormulasLeinertex.Create);
end;

end.
