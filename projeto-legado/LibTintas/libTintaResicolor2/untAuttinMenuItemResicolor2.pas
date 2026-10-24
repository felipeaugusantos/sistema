{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemResicolor2;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoResicolor2Cores,
  untGravandoExecucaoResicolor2Colorantes;

type
  TAuttinMenuItemResicolor2 = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesResicolor2 = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesResicolor2 = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesResicolor2 = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaResicolor2 = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaResicolor2 = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasResicolor2 = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorResicolor2, untLibTintaFactory, untGravandoExecucaoResicolor2NovasFormulas, untCadastroBasesResicolor2, 
  untCadastroColorantesResicolor2, untGravandoExecucaoResicolor2Bases, 
  untCadastroNovasFormulasResicolor2;

{ TAuttinMenuItemResicolor2 }

constructor TAuttinMenuItemResicolor2.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesResicolor2.Create());
  Self.Adicionar(TCadastroBasesResicolor2.Create());
  Self.Adicionar(TCadastroColorantesResicolor2.Create());
  Self.Adicionar(TCadastroNovasFormulasResicolor2.Create());
  Self.Adicionar(TGeracaoTintaResicolor2.Create());
  Self.Adicionar(TConsultaResicolor2.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesResicolor2 }

constructor TConfiguracoesResicolor2.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesResicolor2');
end;

procedure TConfiguracoesResicolor2.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorResicolor2.Create(auttinWrapper));
end;

{ TCadastroBasesResicolor2 }

constructor TCadastroBasesResicolor2.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadRS2Base');
end;

procedure TCadastroBasesResicolor2.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesResicolor2.TCadastroBasesResicolor2.Create());
end;

{ TConsultaResicolor2 }

constructor TConsultaResicolor2.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaResicolor2');
end;

procedure TConsultaResicolor2.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaResicolor2 }

constructor TGeracaoTintaResicolor2.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadRS2GeraArquivo');
end;

procedure TGeracaoTintaResicolor2.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Resicolor2', [
    TGravandoExecucaoResicolor2Colorantes.Create,
    TGravandoExecucaoResicolor2Bases.Create,
    TGravandoExecucaoResicolor2Cores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadRS2GeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Resicolor2 Imobiliária', [
    TGravandoExecucaoResicolor2NovasFormulas.Create
  ]);
end;

{ TCadastroColorantesResicolor2 }

constructor TCadastroColorantesResicolor2.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadRS2Colorantes');
end;

procedure TCadastroColorantesResicolor2.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesResicolor2.TCadastroColorantesResicolor2.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasResicolor2.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadRS2NovasFormulas');
end;

procedure TCadastroNovasFormulasResicolor2.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasResicolor2.TCadastroNovasFormulasResicolor2.Create);
end;

end.
