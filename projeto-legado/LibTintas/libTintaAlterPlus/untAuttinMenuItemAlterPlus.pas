{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************PH*}
unit untAuttinMenuItemAlterPlus;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoAlterPlusCores,
  untGravandoExecucaoAlterPlusColorantes;

type
  TAuttinMenuItemAlterPlus = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesAlterPlus = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesAlterPlus = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesAlterPlus = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaAlterPlus = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaAlterPlus = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasAlterPlus = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorAlterPlus, untLibTintaFactory, untGravandoExecucaoAlterPlusNovasFormulas, untCadastroBasesAlterPlus, 
  untCadastroColorantesAlterPlus, untGravandoExecucaoAlterPlusBases, 
  untCadastroNovasFormulasAlterPlus;

{ TAuttinMenuItemAlterPlus }

constructor TAuttinMenuItemAlterPlus.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesAlterPlus.Create());
  Self.Adicionar(TCadastroBasesAlterPlus.Create());
  Self.Adicionar(TCadastroColorantesAlterPlus.Create());
  Self.Adicionar(TCadastroNovasFormulasAlterPlus.Create());
  Self.Adicionar(TGeracaoTintaAlterPlus.Create());
  Self.Adicionar(TConsultaAlterPlus.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesAlterPlus }

constructor TConfiguracoesAlterPlus.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesAlterPlus');
end;

procedure TConfiguracoesAlterPlus.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorAlterPlus.Create(auttinWrapper));
end;

{ TCadastroBasesAlterPlus }

constructor TCadastroBasesAlterPlus.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadALPBase');
end;

procedure TCadastroBasesAlterPlus.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesAlterPlus.TCadastroBasesAlterPlus.Create());
end;

{ TConsultaAlterPlus }

constructor TConsultaAlterPlus.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaAlterPlus');
end;

procedure TConsultaAlterPlus.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaAlterPlus }

constructor TGeracaoTintaAlterPlus.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadALPGeraArquivo');
end;

procedure TGeracaoTintaAlterPlus.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Alter Plus', [
    TGravandoExecucaoAlterPlusColorantes.Create,
    TGravandoExecucaoAlterPlusBases.Create,
    TGravandoExecucaoAlterPlusCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadALPGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Alter Plus', [
    TGravandoExecucaoAlterPlusNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesAlterPlus }

constructor TCadastroColorantesAlterPlus.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadALPColorantes');
end;

procedure TCadastroColorantesAlterPlus.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesAlterPlus.TCadastroColorantesAlterPlus.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasAlterPlus.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadALPNovasFormulas');  
end;

procedure TCadastroNovasFormulasAlterPlus.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasAlterPlus.TCadastroNovasFormulasAlterPlus.Create);
end;

end.
