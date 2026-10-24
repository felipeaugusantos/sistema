{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemGlobalBsn;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoGlobalBsnCores,
  untGravandoExecucaoGlobalBsnColorantes;

type
  TAuttinMenuItemGlobalBsn = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesGlobalBsn = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesGlobalBsn = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesGlobalBsn = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaGlobalBsn = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaGlobalBsn = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasGlobalBsn = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorGlobalBsn, untLibTintaFactory, untGravandoExecucaoGlobalBsnNovasFormulas, untCadastroBasesGlobalBsn, 
  untCadastroColorantesGlobalBsn, untGravandoExecucaoGlobalBsnBases, 
  untCadastroNovasFormulasGlobalBsn;

{ TAuttinMenuItemGlobalBsn }

constructor TAuttinMenuItemGlobalBsn.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesGlobalBsn.Create());
  Self.Adicionar(TCadastroBasesGlobalBsn.Create());
  Self.Adicionar(TCadastroColorantesGlobalBsn.Create());
  Self.Adicionar(TCadastroNovasFormulasGlobalBsn.Create());
  Self.Adicionar(TGeracaoTintaGlobalBsn.Create());
  Self.Adicionar(TConsultaGlobalBsn.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesGlobalBsn }

constructor TConfiguracoesGlobalBsn.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesGlobalBsn');
end;

procedure TConfiguracoesGlobalBsn.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorGlobalBsn.Create(auttinWrapper));
end;

{ TCadastroBasesGlobalBsn }

constructor TCadastroBasesGlobalBsn.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadBSNBase');
end;

procedure TCadastroBasesGlobalBsn.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesGlobalBsn.TCadastroBasesGlobalBsn.Create());
end;

{ TConsultaGlobalBsn }

constructor TConsultaGlobalBsn.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaGlobalBsn');
end;

procedure TConsultaGlobalBsn.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaGlobalBsn }

constructor TGeracaoTintaGlobalBsn.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadBSNGeraArquivo');
end;

procedure TGeracaoTintaGlobalBsn.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('GlobalBsn', [
    TGravandoExecucaoGlobalBsnColorantes.Create,
    TGravandoExecucaoGlobalBsnBases.Create,
    TGravandoExecucaoGlobalBsnCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadBSNGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('GlobalBsn Imobiliária', [
    TGravandoExecucaoGlobalBsnNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesGlobalBsn }

constructor TCadastroColorantesGlobalBsn.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadBSNColorantes');
end;

procedure TCadastroColorantesGlobalBsn.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesGlobalBsn.TCadastroColorantesGlobalBsn.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasGlobalBsn.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadBSNNovasFormulas');  
end;

procedure TCadastroNovasFormulasGlobalBsn.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasGlobalBsn.TCadastroNovasFormulasGlobalBsn.Create);
end;


end.
