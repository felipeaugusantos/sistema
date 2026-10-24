{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************PH*}
unit untAuttinMenuItemFalcao;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoFalcaoCores,
  untGravandoExecucaoFalcaoColorantes;

type
  TAuttinMenuItemFalcao = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesFalcao = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesFalcao = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesFalcao = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaFalcao = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaFalcao = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasFalcao = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorFalcao, untLibTintaFactory, untGravandoExecucaoFalcaoNovasFormulas, untCadastroBasesFalcao, 
  untCadastroColorantesFalcao, untGravandoExecucaoFalcaoBases, 
  untCadastroNovasFormulasFalcao;

{ TAuttinMenuItemFalcao }

constructor TAuttinMenuItemFalcao.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesFalcao.Create());
  Self.Adicionar(TCadastroBasesFalcao.Create());
  Self.Adicionar(TCadastroColorantesFalcao.Create());
  Self.Adicionar(TCadastroNovasFormulasFalcao.Create());
  Self.Adicionar(TGeracaoTintaFalcao.Create());
  Self.Adicionar(TConsultaFalcao.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesFalcao }

constructor TConfiguracoesFalcao.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesFalcao');
end;

procedure TConfiguracoesFalcao.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorFalcao.Create(auttinWrapper));
end;

{ TCadastroBasesFalcao }

constructor TCadastroBasesFalcao.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadFALBase');
end;

procedure TCadastroBasesFalcao.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesFalcao.TCadastroBasesFalcao.Create());
end;

{ TConsultaFalcao }

constructor TConsultaFalcao.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaFalcao');
end;

procedure TConsultaFalcao.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaFalcao }

constructor TGeracaoTintaFalcao.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadFALGeraArquivo');
end;

procedure TGeracaoTintaFalcao.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Falcão', [
    TGravandoExecucaoFalcaoColorantes.Create,
    TGravandoExecucaoFalcaoBases.Create,
    TGravandoExecucaoFalcaoCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadFALGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Falcão', [
    TGravandoExecucaoFalcaoNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesFalcao }

constructor TCadastroColorantesFalcao.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadFALColorantes');
end;

procedure TCadastroColorantesFalcao.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesFalcao.TCadastroColorantesFalcao.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasFalcao.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadFALNovasFormulas');  
end;

procedure TCadastroNovasFormulasFalcao.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasFalcao.TCadastroNovasFormulasFalcao.Create);
end;

end.
