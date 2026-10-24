{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemGlobalColor;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoGlobalColorCores,
  untGravandoExecucaoGlobalColorColorantes;

type
  TAuttinMenuItemGlobalColor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesGlobalColor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesGlobalColor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesGlobalColor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaGlobalColor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaGlobalColor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasGlobalColor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroEmbalagensGlobalColor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorGlobalColor, untLibTintaFactory, untGravandoExecucaoGlobalColorNovasFormulas, untCadastroBasesGlobalColor, 
  untCadastroColorantesGlobalColor, untGravandoExecucaoGlobalColorBases, 
  untCadastroNovasFormulasGlobalColor, untCadastroEmbalagensGlobalColor;

{ TAuttinMenuItemGlobalColor }

constructor TAuttinMenuItemGlobalColor.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesGlobalColor.Create());
  Self.Adicionar(TCadastroBasesGlobalColor.Create());
  Self.Adicionar(TCadastroColorantesGlobalColor.Create());
  Self.Adicionar(TCadastroEmbalagensGlobalColor.Create());
  Self.Adicionar(TCadastroNovasFormulasGlobalColor.Create());
  Self.Adicionar(TGeracaoTintaGlobalColor.Create());
  Self.Adicionar(TConsultaGlobalColor.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesGlobalColor }

constructor TConfiguracoesGlobalColor.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesGlobalColor');
end;

procedure TConfiguracoesGlobalColor.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorGlobalColor.Create(auttinWrapper));
end;

{ TCadastroBasesGlobalColor }

constructor TCadastroBasesGlobalColor.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadGLOBase');
end;

procedure TCadastroBasesGlobalColor.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesGlobalColor.TCadastroBasesGlobalColor.Create());
end;

{ TConsultaGlobalColor }

constructor TConsultaGlobalColor.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaGlobalColor');
end;

procedure TConsultaGlobalColor.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaGlobalColor }

constructor TGeracaoTintaGlobalColor.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadGLOGeraArquivo');
end;

procedure TGeracaoTintaGlobalColor.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('GlobalColor', [
    TGravandoExecucaoGlobalColorColorantes.Create,
    TGravandoExecucaoGlobalColorBases.Create,
    TGravandoExecucaoGlobalColorCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadGLOGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('GlobalColor Imobiliária', [
    TGravandoExecucaoGlobalColorNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesGlobalColor }

constructor TCadastroColorantesGlobalColor.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadGLOColorantes');
end;

procedure TCadastroColorantesGlobalColor.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesGlobalColor.TCadastroColorantesGlobalColor.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasGlobalColor.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadGLONovasFormulas');  
end;

procedure TCadastroNovasFormulasGlobalColor.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasGlobalColor.TCadastroNovasFormulasGlobalColor.Create);
end;

{ TCadastroEmbalagensGlobalColor }

constructor TCadastroEmbalagensGlobalColor.Create;
begin
  inherited Create('Cadastro de Embalagens', 'frmCadGLOEmbalagens');
end;

procedure TCadastroEmbalagensGlobalColor.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroEmbalagensGlobalColor.TCadastroEmbalagensGlobalColor.Create);
end;

end.
