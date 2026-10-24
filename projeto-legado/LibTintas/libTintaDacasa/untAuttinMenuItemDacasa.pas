{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemDacasa;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoDacasaCores,
  untGravandoExecucaoDacasaColorantes;

type
  TAuttinMenuItemDacasa = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesDacasa = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesDacasa = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesDacasa = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaDacasa = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaDacasa = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasDacasa = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorDacasa, untLibTintaFactory, untGravandoExecucaoDacasaNovasFormulas, untCadastroBasesDacasa, 
  untCadastroColorantesDacasa, untGravandoExecucaoDacasaBases, 
  untCadastroNovasFormulasDacasa;

{ TAuttinMenuItemDacasa }

constructor TAuttinMenuItemDacasa.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesDacasa.Create());
  Self.Adicionar(TCadastroBasesDacasa.Create());
  Self.Adicionar(TCadastroColorantesDacasa.Create());
  Self.Adicionar(TCadastroNovasFormulasDacasa.Create());
  Self.Adicionar(TGeracaoTintaDacasa.Create());
  Self.Adicionar(TConsultaDacasa.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesDacasa }

constructor TConfiguracoesDacasa.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesDacasa');
end;

procedure TConfiguracoesDacasa.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorDacasa.Create(auttinWrapper));
end;

{ TCadastroBasesDacasa }

constructor TCadastroBasesDacasa.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadDCABase');
end;

procedure TCadastroBasesDacasa.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesDacasa.TCadastroBasesDacasa.Create());
end;

{ TConsultaDacasa }

constructor TConsultaDacasa.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaDacasa');
end;

procedure TConsultaDacasa.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaDacasa }

constructor TGeracaoTintaDacasa.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadDCAGeraArquivo');
end;

procedure TGeracaoTintaDacasa.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Dacasa', [
    TGravandoExecucaoDacasaColorantes.Create,
    TGravandoExecucaoDacasaBases.Create,
    TGravandoExecucaoDacasaCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadDCAGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Dacasa Imobiliária', [
    TGravandoExecucaoDacasaNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesDacasa }

constructor TCadastroColorantesDacasa.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadDCAColorantes');
end;

procedure TCadastroColorantesDacasa.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesDacasa.TCadastroColorantesDacasa.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasDacasa.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadDCANovasFormulas');  
end;

procedure TCadastroNovasFormulasDacasa.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasDacasa.TCadastroNovasFormulasDacasa.Create);
end;

end.
