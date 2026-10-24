{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemDuxone2;

interface

uses
  untGenericAuttinMenuItem, Vcl.Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoDuxone2Cores;

type
  TAuttinMenuItemDuxone2 = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesDuxone2 = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesDuxone2 = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaDuxone2 = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaDuxone2 = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasDuxone2 = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorDuxone2, untLibTintaFactory, untGravandoExecucaoDuxone2NovasFormulas, untCadastroBasesDuxone2,
  untGravandoExecucaoDuxone2Bases, untCadastroNovasFormulasDuxone2;

{ TAuttinMenuItemDuxone2 }

constructor TAuttinMenuItemDuxone2.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesDuxone2.Create());
  Self.Adicionar(TCadastroBasesDuxone2.Create());
  Self.Adicionar(TCadastroNovasFormulasDuxone2.Create());
  Self.Adicionar(TGeracaoTintaDuxone2.Create());
  Self.Adicionar(TConsultaDuxone2.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesDuxone2 }

constructor TConfiguracoesDuxone2.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesDuxone2');
end;

procedure TConfiguracoesDuxone2.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorDuxone2.Create(auttinWrapper));
end;

{ TCadastroBasesDuxone2 }

constructor TCadastroBasesDuxone2.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadDu2Base');
end;

procedure TCadastroBasesDuxone2.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesDuxone2.TCadastroBasesDuxone2.Create());
end;

{ TConsultaDuxone2 }

constructor TConsultaDuxone2.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaDuxone2');
end;

procedure TConsultaDuxone2.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaDuxone2 }

constructor TGeracaoTintaDuxone2.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadDu2GeraArquivo');
end;

procedure TGeracaoTintaDuxone2.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Duxone2', [
    TGravandoExecucaoDuxone2Bases.Create,
    TGravandoExecucaoDuxone2Cores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadDu2GeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Duxone2 Global', [
    TGravandoExecucaoDuxone2NovasFormulas.Create
  ]);
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasDuxone2.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadDu2NovasFormulas');
end;

procedure TCadastroNovasFormulasDuxone2.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasDuxone2.TCadastroNovasFormulasDuxone2.Create);
end;

end.
