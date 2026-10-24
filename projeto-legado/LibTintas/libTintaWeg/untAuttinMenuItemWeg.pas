{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemWeg;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoWegCores,
  untGravandoExecucaoWegEmbalagens;

type
  TAuttinMenuItemWeg = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesWeg = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesWeg = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesWeg = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaWeg = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaWeg = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasWeg = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroEmbalagensWeg = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorWeg, untLibTintaFactory, untGravandoExecucaoWegNovasFormulas, untCadastroBasesWeg, 
  untCadastroColorantesWeg, untGravandoExecucaoWegBases, 
  untCadastroNovasFormulasWeg, untCadastroEmbalagensWeg;

{ TAuttinMenuItemWeg }

constructor TAuttinMenuItemWeg.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesWeg.Create());
  Self.Adicionar(TCadastroBasesWeg.Create());
  Self.Adicionar(TCadastroColorantesWeg.Create());
  Self.Adicionar(TCadastroEmbalagensWeg.Create());
  Self.Adicionar(TCadastroNovasFormulasWeg.Create());
  Self.Adicionar(TGeracaoTintaWeg.Create());
  Self.Adicionar(TConsultaWeg.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesWeg }

constructor TConfiguracoesWeg.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesWeg');
end;

procedure TConfiguracoesWeg.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorWeg.Create(auttinWrapper));
end;

{ TCadastroBasesWeg }

constructor TCadastroBasesWeg.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadWEGBase');
end;

procedure TCadastroBasesWeg.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesWeg.TCadastroBasesWeg.Create());
end;

{ TConsultaWeg }

constructor TConsultaWeg.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaWeg');
end;

procedure TConsultaWeg.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaWeg }

constructor TGeracaoTintaWeg.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadWEGGeraArquivo');
end;

procedure TGeracaoTintaWeg.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Weg', [
    TGravandoExecucaoWegEmbalagens.Create,
    TGravandoExecucaoWegBases.Create,
    TGravandoExecucaoWegCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadWEGGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Weg Imobiliária', [
    TGravandoExecucaoWegNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesWeg }

constructor TCadastroColorantesWeg.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadWEGColorantes');
end;

procedure TCadastroColorantesWeg.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesWeg.TCadastroColorantesWeg.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasWeg.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadWEGNovasFormulas');  
end;

procedure TCadastroNovasFormulasWeg.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasWeg.TCadastroNovasFormulasWeg.Create);
end;

{ TCadastroEmbalagensWeg }

constructor TCadastroEmbalagensWeg.Create;
begin
  inherited Create('Cadastro de Embalagens', 'frmCadWEGEmbalagens');
end;

procedure TCadastroEmbalagensWeg.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroEmbalagensWeg.TCadastroEmbalagensWeg.Create);
end;

end.
