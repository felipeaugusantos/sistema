{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemProfissionalAutomotiva;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoProfissionalAutomotivaBases,
  untGravandoExecucaoProfissionalAutomotivaCores;

type
  TAuttinMenuItemProfissionalAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesProfissionalAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesProfissionalAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaProfissionalAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaProfissionalAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasProfissionalAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorProfissionalAutomotiva, untLibTintaFactory, untGravandoExecucaoProfissionalAutomotivaNovasFormulas, untCadastroBasesProfissionalAutomotiva,
  untCadastroNovasFormulasProfissionalAutomotiva;

{ TAuttinMenuItemProfissionalAutomotiva }

constructor TAuttinMenuItemProfissionalAutomotiva.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesProfissionalAutomotiva.Create());
  Self.Adicionar(TCadastroBasesProfissionalAutomotiva.Create());
  Self.Adicionar(TGeracaoTintaProfissionalAutomotiva.Create());
  Self.Adicionar(TCadastroNovasFormulasProfissionalAutomotiva.Create());
  Self.Adicionar(TConsultaProfissionalAutomotiva.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesProfissionalAutomotiva }

constructor TConfiguracoesProfissionalAutomotiva.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesProfissionalAutomotiva');
end;

procedure TConfiguracoesProfissionalAutomotiva.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorProfissionalAutomotiva.Create(auttinWrapper));
end;

{ TCadastroBasesProfissionalAutomotiva }

constructor TCadastroBasesProfissionalAutomotiva.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadPFABase');
end;

procedure TCadastroBasesProfissionalAutomotiva.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesProfissionalAutomotiva.TCadastroBasesProfissionalAutomotiva.Create());
end;

{ TConsultaProfissionalAutomotiva }

constructor TConsultaProfissionalAutomotiva.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaProfissionalAutomotiva');
end;

procedure TConsultaProfissionalAutomotiva.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;


{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadPFAGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('ProfissionalAutomotiva', [
    TGravandoExecucaoProfissionalAutomotivaNovasFormulas.Create
  ]);
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasProfissionalAutomotiva.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadPFANovasFormulas');
end;

procedure TCadastroNovasFormulasProfissionalAutomotiva.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasProfissionalAutomotiva.TCadastroNovasFormulasProfissionalAutomotiva.Create);
end;

{ TGeracaoTintaProfissionalAutomotiva }

constructor TGeracaoTintaProfissionalAutomotiva.Create;
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadPFAGeraArquivo');
end;

procedure TGeracaoTintaProfissionalAutomotiva.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('ProfissionalAutomotiva', [
    TGravandoExecucaoProfissionalAutomotivaBases.Create,
    TGravandoExecucaoProfissionalAutomotivaCores.Create
  ]);
end;

end.


