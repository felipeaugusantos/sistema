{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemInkor;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoInkorCores,
  untGravandoExecucaoInkorColorantes;

type
  TAuttinMenuItemInkor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesInkor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesInkor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesInkor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaInkor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaInkor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasInkor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorInkor, untLibTintaFactory, untGravandoExecucaoInkorNovasFormulas, untCadastroBasesInkor, 
  untCadastroColorantesInkor, untGravandoExecucaoInkorBases, 
  untCadastroNovasFormulasInkor;

{ TAuttinMenuItemInkor }

constructor TAuttinMenuItemInkor.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesInkor.Create());
  Self.Adicionar(TCadastroBasesInkor.Create());
  Self.Adicionar(TCadastroColorantesInkor.Create());
  Self.Adicionar(TCadastroNovasFormulasInkor.Create());
  Self.Adicionar(TGeracaoTintaInkor.Create());
  Self.Adicionar(TConsultaInkor.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesInkor }

constructor TConfiguracoesInkor.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesInkor');
end;

procedure TConfiguracoesInkor.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorInkor.Create(auttinWrapper));
end;

{ TCadastroBasesInkor }

constructor TCadastroBasesInkor.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadINKBase');
end;

procedure TCadastroBasesInkor.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesInkor.TCadastroBasesInkor.Create());
end;

{ TConsultaInkor }

constructor TConsultaInkor.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaInkor');
end;

procedure TConsultaInkor.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaInkor }

constructor TGeracaoTintaInkor.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadINKGeraArquivo');
end;

procedure TGeracaoTintaInkor.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Inkor Industrial', [
    TGravandoExecucaoInkorColorantes.Create,
    TGravandoExecucaoInkorBases.Create,
    TGravandoExecucaoInkorCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadINKGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Inkor Industrial', [
    TGravandoExecucaoInkorNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesInkor }

constructor TCadastroColorantesInkor.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadINKColorantes');
end;

procedure TCadastroColorantesInkor.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesInkor.TCadastroColorantesInkor.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasInkor.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadINKNovasFormulas');  
end;

procedure TCadastroNovasFormulasInkor.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasInkor.TCadastroNovasFormulasInkor.Create);
end;

end.
