{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemAlv;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoAlvCores,
  untGravandoExecucaoAlvColorantes;

type
  TAuttinMenuItemAlv = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesAlv = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesAlv = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesAlv = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaAlv = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaAlv = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasAlv = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorAlv, untLibTintaFactory, untGravandoExecucaoAlvNovasFormulas, untCadastroBasesAlv, 
  untCadastroColorantesAlv, untGravandoExecucaoAlvBases, 
  untCadastroNovasFormulasAlv;

{ TAuttinMenuItemAlv }

constructor TAuttinMenuItemAlv.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesAlv.Create());
  Self.Adicionar(TCadastroBasesAlv.Create());
  Self.Adicionar(TCadastroColorantesAlv.Create());
  Self.Adicionar(TCadastroNovasFormulasAlv.Create());
  Self.Adicionar(TGeracaoTintaAlv.Create());
  Self.Adicionar(TConsultaAlv.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesAlv }

constructor TConfiguracoesAlv.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesAlv');
end;

procedure TConfiguracoesAlv.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorAlv.Create(auttinWrapper));
end;

{ TCadastroBasesAlv }

constructor TCadastroBasesAlv.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadALVBase');
end;

procedure TCadastroBasesAlv.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesAlv.TCadastroBasesAlv.Create());
end;

{ TConsultaAlv }

constructor TConsultaAlv.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaAlv');
end;

procedure TConsultaAlv.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaAlv }

constructor TGeracaoTintaAlv.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadALVGeraArquivo');
end;

procedure TGeracaoTintaAlv.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('ALV Industrial', [
    TGravandoExecucaoAlvColorantes.Create,
    TGravandoExecucaoAlvBases.Create,
    TGravandoExecucaoAlvCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadALVGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('ALV Industrial', [
    TGravandoExecucaoAlvNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesAlv }

constructor TCadastroColorantesAlv.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadALVColorantes');
end;

procedure TCadastroColorantesAlv.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesAlv.TCadastroColorantesAlv.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasAlv.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadALVNovasFormulas');  
end;

procedure TCadastroNovasFormulasAlv.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasAlv.TCadastroNovasFormulasAlv.Create);
end;


end.
