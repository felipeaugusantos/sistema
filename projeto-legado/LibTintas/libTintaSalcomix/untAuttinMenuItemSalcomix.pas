{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************PH*}
unit untAuttinMenuItemSalcomix;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoSalcomixCores;

type
  TAuttinMenuItemSalcomix = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesSalcomix = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesSalcomix = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaSalcomix = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaSalcomix = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasSalcomix = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorSalcomix, untLibTintaFactory, untGravandoExecucaoSalcomixNovasFormulas, untCadastroBasesSalcomix,
  untGravandoExecucaoSalcomixBases, untCadastroNovasFormulasSalcomix;

{ TAuttinMenuItemSalcomix }

constructor TAuttinMenuItemSalcomix.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesSalcomix.Create());
  Self.Adicionar(TCadastroBasesSalcomix.Create());
  Self.Adicionar(TCadastroNovasFormulasSalcomix.Create());
  Self.Adicionar(TGeracaoTintaSalcomix.Create());
  Self.Adicionar(TConsultaSalcomix.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());

end;

{ TConfiguracoesSalcomix }

constructor TConfiguracoesSalcomix.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesSalcomix');
end;

procedure TConfiguracoesSalcomix.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorSalcomix.Create(auttinWrapper));
end;

{ TCadastroBasesSalcomix }

constructor TCadastroBasesSalcomix.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadSALBase');
end;

procedure TCadastroBasesSalcomix.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesSalcomix.TCadastroBasesSalcomix.Create());
end;

{ TConsultaSalcomix }

constructor TConsultaSalcomix.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaSalcomix');
end;

procedure TConsultaSalcomix.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaSalcomix }

constructor TGeracaoTintaSalcomix.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadSALGeraArquivo');
end;

procedure TGeracaoTintaSalcomix.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Salcomix', [
    TGravandoExecucaoSalcomixBases.Create,
    TGravandoExecucaoSalcomixCores.Create]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadSALGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Salcomix', [
    TGravandoExecucaoSalcomixNovasFormulas.Create
  ]);
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasSalcomix.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadSALNovasFormulas');
end;

procedure TCadastroNovasFormulasSalcomix.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasSalcomix.TCadastroNovasFormulasSalcomix.Create);
end;

end.
