{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemProfissionalTintas;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoProfissionalTintasCores,
  untGravandoExecucaoProfissionalTintasColorantes;

type
  TAuttinMenuItemProfissionalTintas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesProfissionalTintas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesProfissionalTintas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesProfissionalTintas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaProfissionalTintas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaProfissionalTintas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasProfissionalTintas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorProfissionalTintas, untLibTintaFactory, untGravandoExecucaoProfissionalTintasNovasFormulas, untCadastroBasesProfissionalTintas, 
  untCadastroColorantesProfissionalTintas, untGravandoExecucaoProfissionalTintasBases, 
  untCadastroNovasFormulasProfissionalTintas;

{ TAuttinMenuItemProfissionalTintas }

constructor TAuttinMenuItemProfissionalTintas.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesProfissionalTintas.Create());
  Self.Adicionar(TCadastroBasesProfissionalTintas.Create());
  Self.Adicionar(TCadastroColorantesProfissionalTintas.Create());
  Self.Adicionar(TCadastroNovasFormulasProfissionalTintas.Create());
  Self.Adicionar(TGeracaoTintaProfissionalTintas.Create());
  Self.Adicionar(TConsultaProfissionalTintas.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesProfissionalTintas }

constructor TConfiguracoesProfissionalTintas.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesProfissionalTintas');
end;

procedure TConfiguracoesProfissionalTintas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorProfissionalTintas.Create(auttinWrapper));
end;

{ TCadastroBasesProfissionalTintas }

constructor TCadastroBasesProfissionalTintas.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadPRTBase');
end;

procedure TCadastroBasesProfissionalTintas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesProfissionalTintas.TCadastroBasesProfissionalTintas.Create());
end;

{ TConsultaProfissionalTintas }

constructor TConsultaProfissionalTintas.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaProfissionalTintas');
end;

procedure TConsultaProfissionalTintas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaProfissionalTintas }

constructor TGeracaoTintaProfissionalTintas.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadPRTGeraArquivo');
end;

procedure TGeracaoTintaProfissionalTintas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('ProfissionalTintas', [
    TGravandoExecucaoProfissionalTintasColorantes.Create,
    TGravandoExecucaoProfissionalTintasBases.Create,
    TGravandoExecucaoProfissionalTintasCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadPRTGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('ProfissionalTintas Imobiliária', [
    TGravandoExecucaoProfissionalTintasNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesProfissionalTintas }

constructor TCadastroColorantesProfissionalTintas.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadPRTColorantes');
end;

procedure TCadastroColorantesProfissionalTintas.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesProfissionalTintas.TCadastroColorantesProfissionalTintas.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasProfissionalTintas.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadPRTNovasFormulas');
end;

procedure TCadastroNovasFormulasProfissionalTintas.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasProfissionalTintas.TCadastroNovasFormulasProfissionalTintas.Create);
end;

end.
