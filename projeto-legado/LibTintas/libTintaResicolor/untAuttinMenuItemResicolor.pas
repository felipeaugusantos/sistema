{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemResicolor;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoResicolorCores,
  untGravandoExecucaoResicolorEmbalagem;

type
  TAuttinMenuItemResicolor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesResicolor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesResicolor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesResicolor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaResicolor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaResicolor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasResicolor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroEmbalagensResicolor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorResicolor, untLibTintaFactory, untGravandoExecucaoResicolorNovasFormulas, untCadastroBasesResicolor,
  untCadastroColorantesResicolor, untGravandoExecucaoResicolorBases,
  untCadastroNovasFormulasResicolor, untCadastroEmbalagensResicolor;

{ TAuttinMenuItemResicolor }

constructor TAuttinMenuItemResicolor.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesResicolor.Create());
  Self.Adicionar(TCadastroBasesResicolor.Create());
  Self.Adicionar(TCadastroColorantesResicolor.Create());
  Self.Adicionar(TCadastroEmbalagensResicolor.Create());
  Self.Adicionar(TCadastroNovasFormulasResicolor.Create());
  Self.Adicionar(TGeracaoTintaResicolor.Create());
  Self.Adicionar(TConsultaResicolor.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesResicolor }

constructor TConfiguracoesResicolor.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesResicolor');
end;

procedure TConfiguracoesResicolor.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorResicolor.Create(auttinWrapper));
end;

{ TCadastroBasesResicolor }

constructor TCadastroBasesResicolor.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadRSIBase');
end;

procedure TCadastroBasesResicolor.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesResicolor.TCadastroBasesResicolor.Create());
end;

{ TConsultaResicolor }

constructor TConsultaResicolor.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaResicolor');
end;

procedure TConsultaResicolor.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaResicolor }

constructor TGeracaoTintaResicolor.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadRSIGeraArquivo');
end;

procedure TGeracaoTintaResicolor.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Resicolor', [
    TGravandoExecucaoResicolorEmbalagem.Create,
    TGravandoExecucaoResicolorBases.Create,
    TGravandoExecucaoResicolorCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadRSIGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Resicolor Imobiliária', [
    TGravandoExecucaoResicolorNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesResicolor }

constructor TCadastroColorantesResicolor.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadRSIColorantes');
end;

procedure TCadastroColorantesResicolor.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesResicolor.TCadastroColorantesResicolor.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasResicolor.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadRSINovasFormulas');
end;

procedure TCadastroNovasFormulasResicolor.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasResicolor.TCadastroNovasFormulasResicolor.Create);
end;

{ TCadastroEmbalagensResicolor }

constructor TCadastroEmbalagensResicolor.Create;
begin
  inherited Create('Cadastro de Embalagens', 'frmCadRSIEmbalagens');
end;

procedure TCadastroEmbalagensResicolor.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroEmbalagensResicolor.TCadastroEmbalagensResicolor.Create);
end;

end.

