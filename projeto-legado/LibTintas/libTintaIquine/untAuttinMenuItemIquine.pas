{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemIquine;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoIquineCores,
  untGravandoExecucaoIquineColorantes, untGravandoExecucaoIquineEmbalagem;

type
  TAuttinMenuItemIquine = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesIquine = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesIquine = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesIquine = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaIquine = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaIquine = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasIquine = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroEmbalagensIquine = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorIquine, untLibTintaFactory, untGravandoExecucaoIquineNovasFormulas, untCadastroBasesIquine, 
  untCadastroColorantesIquine, untGravandoExecucaoIquineBases, 
  untCadastroNovasFormulasIquine, untCadastroEmbalagensIquine;

{ TAuttinMenuItemIquine }

constructor TAuttinMenuItemIquine.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesIquine.Create());
  Self.Adicionar(TCadastroBasesIquine.Create());
  Self.Adicionar(TCadastroColorantesIquine.Create());
  Self.Adicionar(TCadastroEmbalagensIquine.Create());
  Self.Adicionar(TCadastroNovasFormulasIquine.Create());
  Self.Adicionar(TGeracaoTintaIquine.Create());
  Self.Adicionar(TConsultaIquine.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesIquine }

constructor TConfiguracoesIquine.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesIquine');
end;

procedure TConfiguracoesIquine.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorIquine.Create(auttinWrapper));
end;

{ TCadastroBasesIquine }

constructor TCadastroBasesIquine.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadIQUBase');
end;

procedure TCadastroBasesIquine.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesIquine.TCadastroBasesIquine.Create());
end;

{ TConsultaIquine }

constructor TConsultaIquine.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaIquine');
end;

procedure TConsultaIquine.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaIquine }

constructor TGeracaoTintaIquine.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadIQUGeraArquivo');
end;

procedure TGeracaoTintaIquine.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Iquine Imobiliária', [
    TGravandoExecucaoIquineColorantes.Create,
    TGravandoExecucaoIquineBases.Create,
    TGravandoExecucaoIquineCores.Create,
    TGravandoExecucaoIquineEmbalagem.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadIQUGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Iquine Imobiliária', [
    TGravandoExecucaoIquineNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesIquine }

constructor TCadastroColorantesIquine.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadIQUColorantes');
end;

procedure TCadastroColorantesIquine.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesIquine.TCadastroColorantesIquine.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasIquine.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadIQUNovasFormulas');  
end;

procedure TCadastroNovasFormulasIquine.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasIquine.TCadastroNovasFormulasIquine.Create);
end;

{ TCadastroEmbalagensIquine }

constructor TCadastroEmbalagensIquine.Create;
begin
  inherited Create('Cadastro de Embalagens', 'frmCadIQUEmbalagens');
end;

procedure TCadastroEmbalagensIquine.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroEmbalagensIquine.TCadastroEmbalagensIquine.Create);
end;

end.
