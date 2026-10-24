{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemAnnetta;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoAnnettaCores,
  untGravandoExecucaoAnnettaColorantes;

type
  TAuttinMenuItemAnnetta = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesAnnetta = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesAnnetta = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesAnnetta = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaAnnetta = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaAnnetta = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasAnnetta = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroEmbalagensAnnetta = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorAnnetta, untLibTintaFactory, untGravandoExecucaoAnnettaNovasFormulas, untCadastroBasesAnnetta, 
  untCadastroColorantesAnnetta, untGravandoExecucaoAnnettaBases, 
  untCadastroNovasFormulasAnnetta, untCadastroEmbalagensAnnetta;

{ TAuttinMenuItemAnnetta }

constructor TAuttinMenuItemAnnetta.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesAnnetta.Create());
  Self.Adicionar(TCadastroBasesAnnetta.Create());
  Self.Adicionar(TCadastroColorantesAnnetta.Create());
  Self.Adicionar(TCadastroEmbalagensAnnetta.Create());
  Self.Adicionar(TCadastroNovasFormulasAnnetta.Create());
  Self.Adicionar(TGeracaoTintaAnnetta.Create());
  Self.Adicionar(TConsultaAnnetta.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesAnnetta }

constructor TConfiguracoesAnnetta.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesAnnetta');
end;

procedure TConfiguracoesAnnetta.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorAnnetta.Create(auttinWrapper));
end;

{ TCadastroBasesAnnetta }

constructor TCadastroBasesAnnetta.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadANNBase');
end;

procedure TCadastroBasesAnnetta.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesAnnetta.TCadastroBasesAnnetta.Create());
end;

{ TConsultaAnnetta }

constructor TConsultaAnnetta.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaAnnetta');
end;

procedure TConsultaAnnetta.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaAnnetta }

constructor TGeracaoTintaAnnetta.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadANNGeraArquivo');
end;

procedure TGeracaoTintaAnnetta.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Annetta Industrial', [
    TGravandoExecucaoAnnettaColorantes.Create,
    TGravandoExecucaoAnnettaBases.Create,
    TGravandoExecucaoAnnettaCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadANNGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Annetta Industrial', [
    TGravandoExecucaoAnnettaNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesAnnetta }

constructor TCadastroColorantesAnnetta.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadANNColorantes');
end;

procedure TCadastroColorantesAnnetta.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesAnnetta.TCadastroColorantesAnnetta.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasAnnetta.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadANNNovasFormulas');  
end;

procedure TCadastroNovasFormulasAnnetta.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasAnnetta.TCadastroNovasFormulasAnnetta.Create);
end;

{ TCadastroEmbalagensAnnetta }

constructor TCadastroEmbalagensAnnetta.Create;
begin
  inherited Create('Cadastro de Embalagens', 'frmCadANNEmbalagens');
end;

procedure TCadastroEmbalagensAnnetta.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroEmbalagensAnnetta.TCadastroEmbalagensAnnetta.Create);
end;

end.
