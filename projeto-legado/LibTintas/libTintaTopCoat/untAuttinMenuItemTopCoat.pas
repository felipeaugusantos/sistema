{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************PH*}
unit untAuttinMenuItemTopCoat;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper;

type
  TAuttinMenuItemTopCoat = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesTopCoat = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesTopCoat = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaTopCoat = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasTopCoat = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroMontadoraTopCoat = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroLinhaTopCoat = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;


implementation

uses
  untConfiguradorTopCoat, untLibTintaFactory, untGravandoExecucaoTopCoatNovasFormulas, untCadastroBasesTopCoat,
  untCadastroNovasFormulasTopCoat, untCadastroMontadoraTopCoat, untCadastroLinhaTopCoat;

{ TAuttinMenuItemTopCoat }

constructor TAuttinMenuItemTopCoat.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesTopCoat.Create());
  Self.Adicionar(TCadastroBasesTopCoat.Create());
  Self.Adicionar(TCadastroLinhaTopCoat.Create());
  Self.Adicionar(TCadastroNovasFormulasTopCoat.Create());
  Self.Adicionar(TCadastroMontadoraTopCoat.Create());
  Self.Adicionar(TConsultaTopCoat.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesTopCoat }

constructor TConfiguracoesTopCoat.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesTopCoat');
end;

procedure TConfiguracoesTopCoat.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorTopCoat.Create(auttinWrapper));
end;

{ TCadastroBasesTopCoat }

constructor TCadastroBasesTopCoat.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadCOABase');
end;

procedure TCadastroBasesTopCoat.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesTopCoat.TCadastroBasesTopCoat.Create());
end;

{ TConsultaTopCoat }

constructor TConsultaTopCoat.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaTopCoat');
end;

procedure TConsultaTopCoat.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadCOAGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('TopCoat', [
    TGravandoExecucaoTopCoatNovasFormulas.Create
  ]);
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasTopCoat.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadCOANovasFormulas');
end;

procedure TCadastroNovasFormulasTopCoat.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasTopCoat.TCadastroNovasFormulasTopCoat.Create);
end;

{ TCadastroMontadoraTopCoat }

constructor TCadastroMontadoraTopCoat.Create;
begin
  inherited Create('Cadastro de Montadora', 'frmCadCOAMontadora');
end;

procedure TCadastroMontadoraTopCoat.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroMontadoraTopCoat.TCadastroMontadoraTopCoat.Create);
end;

{ TCadastroLinhaTopCoat }

constructor TCadastroLinhaTopCoat.Create;
begin
  inherited Create('Cadastro de Linhas', 'frmCadCOALinha');
end;

procedure TCadastroLinhaTopCoat.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroLinhaTopCoat.TCadastroLinhaTopCoat.Create);
end;

end.
