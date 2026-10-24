{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************PH*}
unit untAuttinMenuItemPpgNexa;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoPpgNexaCores;

type
  TAuttinMenuItemPpgNexa = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesPpgNexa = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesPpgNexa = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaPpgNexa = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaPpgNexa = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasPpgNexa = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;


implementation

uses
  untConfiguradorPpgNexa, untLibTintaFactory, untGravandoExecucaoPpgNexaNovasFormulas,
  untGravandoExecucaoPpgNexaImportaNovasFormulas, untCadastroBasesPpgNexa,
  untGravandoExecucaoPpgNexaBases,  untCadastroNovasFormulasPpgNexa,
  untGravandoExecucaoPpgNexaMontadora,untGravandoExecucaoPpgNexaDiluente,
  untGravandoExecucaoPpgNexaBasesDiluente;

{ TAuttinMenuItemPpgNexa }

constructor TAuttinMenuItemPpgNexa.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesPpgNexa.Create());
  Self.Adicionar(TCadastroBasesPpgNexa.Create());
  Self.Adicionar(TCadastroNovasFormulasPpgNexa.Create());
  Self.Adicionar(TGeracaoTintaPpgNexa.Create());
  Self.Adicionar(TConsultaPpgNexa.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesPpgNexa }

constructor TConfiguracoesPpgNexa.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesPpgNexa');
end;

procedure TConfiguracoesPpgNexa.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorPpgNexa.Create(auttinWrapper));
end;

{ TCadastroBasesPpgNexa }

constructor TCadastroBasesPpgNexa.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadPpgNexaBase');
end;

procedure TCadastroBasesPpgNexa.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesPpgNexa.TCadastroBasesPpgNexa.Create());
end;

{ TConsultaPpgNexa }

constructor TConsultaPpgNexa.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaPpgNexa');
end;

procedure TConsultaPpgNexa.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaPpgNexa }

constructor TGeracaoTintaPpgNexa.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadPpgNexaGeraArquivo');
end;

procedure TGeracaoTintaPpgNexa.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('PPG/NEXA', [
    TGravandoExecucaoPpgNexaBases.Create,
    TGravandoExecucaoPpgNexaMontadora.Create,
    TGravandoExecucaoPpgNexaDiluente.Create,
    TGravandoExecucaoPpgNexaBasesDiluente.Create,
    TGravandoExecucaoPpgNexaCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadPpgNexaGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('PPG/NEXA', [
    TGravandoExecucaoPpgNexaImportaNovasFormulas.Create,
    TGravandoExecucaoPpgNexaNovasFormulas.Create]);
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasPpgNexa.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadPpgNexaNovasFormulas');
end;

procedure TCadastroNovasFormulasPpgNexa.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasPpgNexa.TCadastroNovasFormulasPpgNexa.Create);
end;

end.
