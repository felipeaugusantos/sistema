{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemCalamar;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoCalamarCores,
  untGravandoExecucaoCalamarColorantes;

type
  TAuttinMenuItemCalamar = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesCalamar = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesCalamar = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesCalamar = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaCalamar = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaCalamar = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasCalamar = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroEmbalagensCalamar = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorCalamar, untLibTintaFactory, untGravandoExecucaoCalamarNovasFormulas, untCadastroBasesCalamar, 
  untCadastroColorantesCalamar, untGravandoExecucaoCalamarBases, 
  untCadastroNovasFormulasCalamar, untCadastroEmbalagensCalamar;

{ TAuttinMenuItemCalamar }

constructor TAuttinMenuItemCalamar.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesCalamar.Create());
  Self.Adicionar(TCadastroBasesCalamar.Create());
  Self.Adicionar(TCadastroColorantesCalamar.Create());
  Self.Adicionar(TCadastroEmbalagensCalamar.Create());
  Self.Adicionar(TCadastroNovasFormulasCalamar.Create());
  Self.Adicionar(TGeracaoTintaCalamar.Create());
  Self.Adicionar(TConsultaCalamar.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesCalamar }

constructor TConfiguracoesCalamar.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesCalamar');
end;

procedure TConfiguracoesCalamar.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorCalamar.Create(auttinWrapper));
end;

{ TCadastroBasesCalamar }

constructor TCadastroBasesCalamar.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadCALBase');
end;

procedure TCadastroBasesCalamar.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesCalamar.TCadastroBasesCalamar.Create());
end;

{ TConsultaCalamar }

constructor TConsultaCalamar.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaCalamar');
end;

procedure TConsultaCalamar.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaCalamar }

constructor TGeracaoTintaCalamar.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadCALGeraArquivo');
end;

procedure TGeracaoTintaCalamar.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Calamar Imobiliária', [
    TGravandoExecucaoCalamarColorantes.Create,
    TGravandoExecucaoCalamarBases.Create,
    TGravandoExecucaoCalamarCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadCALGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Calamar Imobiliária', [
    TGravandoExecucaoCalamarNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesCalamar }

constructor TCadastroColorantesCalamar.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadCALColorantes');
end;

procedure TCadastroColorantesCalamar.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesCalamar.TCadastroColorantesCalamar.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasCalamar.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadCALNovasFormulas');
end;

procedure TCadastroNovasFormulasCalamar.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasCalamar.TCadastroNovasFormulasCalamar.Create);
end;

{ TCadastroEmbalagensCalamar }

constructor TCadastroEmbalagensCalamar.Create;
begin
  inherited Create('Cadastro de Embalagens', 'frmCadCALEmbalagens');
end;

procedure TCadastroEmbalagensCalamar.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroEmbalagensCalamar.TCadastroEmbalagensCalamar.Create);
end;

end.
