{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************PH*}
unit untAuttinMenuItemGeneral;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoGeneralCores;

type
  TAuttinMenuItemGeneral = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesGeneral = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesGeneral = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaGeneral = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaGeneral = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasGeneral = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroMontadoraGeneral = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;


implementation

uses
  untConfiguradorGeneral, untLibTintaFactory, untGravandoExecucaoGeneralNovasFormulas, untCadastroBasesGeneral,
  untGravandoExecucaoGeneralBases,  untCadastroNovasFormulasGeneral,
  untCadastroMontadoraGeneral,
  untGravandoExecucaoGeneralMontadora;

{ TAuttinMenuItemGeneral }

constructor TAuttinMenuItemGeneral.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesGeneral.Create());
  Self.Adicionar(TCadastroBasesGeneral.Create());
  Self.Adicionar(TCadastroNovasFormulasGeneral.Create());
  Self.Adicionar(TCadastroMontadoraGeneral.Create());
  Self.Adicionar(TGeracaoTintaGeneral.Create());
  Self.Adicionar(TConsultaGeneral.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesGeneral }

constructor TConfiguracoesGeneral.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesGeneral');
end;

procedure TConfiguracoesGeneral.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorGeneral.Create(auttinWrapper));
end;

{ TCadastroBasesGeneral }

constructor TCadastroBasesGeneral.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadGENBase');
end;

procedure TCadastroBasesGeneral.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesGeneral.TCadastroBasesGeneral.Create());
end;

{ TConsultaGeneral }

constructor TConsultaGeneral.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaGeneral');
end;

procedure TConsultaGeneral.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaGeneral }

constructor TGeracaoTintaGeneral.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadGENGeraArquivo');
end;

procedure TGeracaoTintaGeneral.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('General', [
    TGravandoExecucaoGeneralMontadora.Create,
    TGravandoExecucaoGeneralBases.Create,
    TGravandoExecucaoGeneralCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadGENGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('General', [
    TGravandoExecucaoGeneralNovasFormulas.Create
  ]);
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasGeneral.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadGENNovasFormulas');
end;

procedure TCadastroNovasFormulasGeneral.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasGeneral.TCadastroNovasFormulasGeneral.Create);
end;

{ TCadastroMontadoraGeneral }

constructor TCadastroMontadoraGeneral.Create;
begin
  inherited Create('Cadastro de Montadora', 'frmCadGENMontadora');
end;

procedure TCadastroMontadoraGeneral.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroMontadoraGeneral.TCadastroMontadoraGeneral.Create);
end;

end.
