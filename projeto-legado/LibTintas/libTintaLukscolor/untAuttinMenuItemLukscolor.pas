{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemLukscolor;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoLukscolorCores,
  untGravandoExecucaoLukscolorColorantes;

type
  TAuttinMenuItemLukscolor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesLukscolor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesLukscolor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesLukscolor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaLukscolor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaLukscolor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasLukscolor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroEmbalagensLukscolor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorLukscolor, untLibTintaFactory, untGravandoExecucaoLukscolorNovasFormulas, untCadastroBasesLukscolor, 
  untCadastroColorantesLukscolor, untGravandoExecucaoLukscolorBases, 
  untCadastroNovasFormulasLukscolor, untCadastroEmbalagensLukscolor;

{ TAuttinMenuItemLukscolor }

constructor TAuttinMenuItemLukscolor.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesLukscolor.Create());
  Self.Adicionar(TCadastroBasesLukscolor.Create());
  Self.Adicionar(TCadastroColorantesLukscolor.Create());
  Self.Adicionar(TCadastroEmbalagensLukscolor.Create());
  Self.Adicionar(TCadastroNovasFormulasLukscolor.Create());
  Self.Adicionar(TGeracaoTintaLukscolor.Create());
  Self.Adicionar(TConsultaLukscolor.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesLukscolor }

constructor TConfiguracoesLukscolor.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesLukscolor');
end;

procedure TConfiguracoesLukscolor.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorLukscolor.Create(auttinWrapper));
end;

{ TCadastroBasesLukscolor }

constructor TCadastroBasesLukscolor.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadLKSBase');
end;

procedure TCadastroBasesLukscolor.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesLukscolor.TCadastroBasesLukscolor.Create());
end;

{ TConsultaLukscolor }

constructor TConsultaLukscolor.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaLukscolor');
end;

procedure TConsultaLukscolor.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaLukscolor }

constructor TGeracaoTintaLukscolor.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadLKSGeraArquivo');
end;

procedure TGeracaoTintaLukscolor.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Lukscolor', [
    TGravandoExecucaoLukscolorColorantes.Create,
    TGravandoExecucaoLukscolorBases.Create,
    TGravandoExecucaoLukscolorCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadLKSGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Lukscolor Imobiliária', [
    TGravandoExecucaoLukscolorNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesLukscolor }

constructor TCadastroColorantesLukscolor.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadLKSColorantes');
end;

procedure TCadastroColorantesLukscolor.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesLukscolor.TCadastroColorantesLukscolor.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasLukscolor.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadLKSNovasFormulas');  
end;

procedure TCadastroNovasFormulasLukscolor.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasLukscolor.TCadastroNovasFormulasLukscolor.Create);
end;

{ TCadastroEmbalagensLukscolor }

constructor TCadastroEmbalagensLukscolor.Create;
begin
  inherited Create('Cadastro de Embalagens', 'frmCadLKSEmbalagens');
end;

procedure TCadastroEmbalagensLukscolor.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroEmbalagensLukscolor.TCadastroEmbalagensLukscolor.Create);
end;

end.
