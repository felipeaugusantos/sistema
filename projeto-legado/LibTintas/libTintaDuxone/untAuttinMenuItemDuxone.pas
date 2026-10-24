{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemDuxone;

interface

uses
  untGenericAuttinMenuItem, Vcl.Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoDuxoneCores;

type
  TAuttinMenuItemDuxone = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesDuxone = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesDuxone = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaDuxone = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaDuxone = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasDuxone = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorDuxone, untLibTintaFactory, untGravandoExecucaoDuxoneNovasFormulas, untCadastroBasesDuxone,
  untGravandoExecucaoDuxoneBases, untCadastroNovasFormulasDuxone;

{ TAuttinMenuItemDuxone }

constructor TAuttinMenuItemDuxone.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesDuxone.Create());
  Self.Adicionar(TCadastroBasesDuxone.Create());
  Self.Adicionar(TCadastroNovasFormulasDuxone.Create());
  Self.Adicionar(TGeracaoTintaDuxone.Create());
  Self.Adicionar(TConsultaDuxone.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesDuxone }

constructor TConfiguracoesDuxone.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesDuxone');
end;

procedure TConfiguracoesDuxone.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorDuxone.Create(auttinWrapper));
end;

{ TCadastroBasesDuxone }

constructor TCadastroBasesDuxone.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadDuxBase');
end;

procedure TCadastroBasesDuxone.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesDuxone.TCadastroBasesDuxone.Create());
end;

{ TConsultaDuxone }

constructor TConsultaDuxone.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaDuxone');
end;

procedure TConsultaDuxone.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaDuxone }

constructor TGeracaoTintaDuxone.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadDuxGeraArquivo');
end;

procedure TGeracaoTintaDuxone.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Duxone', [
    TGravandoExecucaoDuxoneBases.Create,
    TGravandoExecucaoDuxoneCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadDuxGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Duxone Global', [
    TGravandoExecucaoDuxoneNovasFormulas.Create
  ]);
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasDuxone.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadDuxNovasFormulas');
end;

procedure TCadastroNovasFormulasDuxone.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasDuxone.TCadastroNovasFormulasDuxone.Create);
end;

end.
