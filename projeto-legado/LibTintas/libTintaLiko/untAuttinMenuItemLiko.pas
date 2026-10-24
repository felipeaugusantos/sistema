{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemLiko;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoLikoCores,
  untGravandoExecucaoLikoColorantes;

type
  TAuttinMenuItemLiko = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesLiko = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesLiko = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesLiko = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaLiko = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaLiko = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasLiko = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroEmbalagensLiko = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorLiko, untLibTintaFactory, untGravandoExecucaoLikoNovasFormulas, untCadastroBasesLiko, 
  untCadastroColorantesLiko, untGravandoExecucaoLikoBases, 
  untCadastroNovasFormulasLiko, untCadastroEmbalagensLiko;

{ TAuttinMenuItemLiko }

constructor TAuttinMenuItemLiko.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesLiko.Create());
  Self.Adicionar(TCadastroBasesLiko.Create());
  Self.Adicionar(TCadastroColorantesLiko.Create());
  Self.Adicionar(TCadastroEmbalagensLiko.Create());
  Self.Adicionar(TCadastroNovasFormulasLiko.Create());
  Self.Adicionar(TGeracaoTintaLiko.Create());
  Self.Adicionar(TConsultaLiko.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesLiko }

constructor TConfiguracoesLiko.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesLiko');
end;

procedure TConfiguracoesLiko.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorLiko.Create(auttinWrapper));
end;

{ TCadastroBasesLiko }

constructor TCadastroBasesLiko.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadLIKBase');
end;

procedure TCadastroBasesLiko.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesLiko.TCadastroBasesLiko.Create());
end;

{ TConsultaLiko }

constructor TConsultaLiko.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaLiko');
end;

procedure TConsultaLiko.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaLiko }

constructor TGeracaoTintaLiko.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadLIKGeraArquivo');
end;

procedure TGeracaoTintaLiko.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Liko Imobiliária', [
    TGravandoExecucaoLikoColorantes.Create,
    TGravandoExecucaoLikoBases.Create,
    TGravandoExecucaoLikoCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadLIKGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Liko Imobiliária', [
    TGravandoExecucaoLikoNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesLiko }

constructor TCadastroColorantesLiko.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadLIKColorantes');
end;

procedure TCadastroColorantesLiko.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesLiko.TCadastroColorantesLiko.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasLiko.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadLIKNovasFormulas');  
end;

procedure TCadastroNovasFormulasLiko.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasLiko.TCadastroNovasFormulasLiko.Create);
end;

{ TCadastroEmbalagensLiko }

constructor TCadastroEmbalagensLiko.Create;
begin
  inherited Create('Cadastro de Embalagens', 'frmCadLIKEmbalagens');
end;

procedure TCadastroEmbalagensLiko.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroEmbalagensLiko.TCadastroEmbalagensLiko.Create);
end;

end.
