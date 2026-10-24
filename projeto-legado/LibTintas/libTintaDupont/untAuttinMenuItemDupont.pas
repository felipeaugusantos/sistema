{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemDupont;

interface

uses
  untGenericAuttinMenuItem, Vcl.Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoDupontCores;

type
  TAuttinMenuItemDupont = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesDupont = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesDupont = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaDupont = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaDupont = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasDupont = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorDupont, untLibTintaFactory, untGravandoExecucaoDupontNovasFormulas, untCadastroBasesDupont,
  untGravandoExecucaoDupontBases, untCadastroNovasFormulasDupont;

{ TAuttinMenuItemDupont }

constructor TAuttinMenuItemDupont.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesDupont.Create());
  Self.Adicionar(TCadastroBasesDupont.Create());
  Self.Adicionar(TCadastroNovasFormulasDupont.Create());
  Self.Adicionar(TGeracaoTintaDupont.Create());
  Self.Adicionar(TConsultaDupont.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesDupont }

constructor TConfiguracoesDupont.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesDupont');
end;

procedure TConfiguracoesDupont.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorDupont.Create(auttinWrapper));
end;

{ TCadastroBasesDupont }

constructor TCadastroBasesDupont.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadDupBase');
end;

procedure TCadastroBasesDupont.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesDupont.TCadastroBasesDupont.Create());
end;

{ TConsultaDupont }

constructor TConsultaDupont.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaDupont');
end;

procedure TConsultaDupont.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaDupont }

constructor TGeracaoTintaDupont.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadDupGeraArquivo');
end;

procedure TGeracaoTintaDupont.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Axalta', [
    TGravandoExecucaoDupontBases.Create,
    TGravandoExecucaoDupontCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadDupGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Axalta', [
    TGravandoExecucaoDupontNovasFormulas.Create
  ]);
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasDupont.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadDupNovasFormulas');
end;

procedure TCadastroNovasFormulasDupont.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasDupont.TCadastroNovasFormulasDupont.Create);
end;

end.
