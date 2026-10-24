unit Contabilidade.Classes.TGeradorContabilBase;

interface

uses System.Generics.Collections,
     Contabilidade.Model.TDadosImportacaoContabil,
     Contabilidade.Classes.TParametroContabil,
     Contabilidade.Classes.TDadosAbertura,
     SysUtils,
     cxProgressBar,
     Forms, Classes;

type
  TGeradorContabilBase = class
  private
    FListaDadosImportacaoContabil: TObjectList<TDadosImportacaoContabil>;
    FListaParametrosContabil: TObjectList<TParametroContabil>;
    FDadosAbertura: TDadosAbertura;
    FListaDadosImportacaoContabilWarning: TObjectList<TDadosImportacaoContabil>;
    FListaDadosImportacaoContabilError: TObjectList<TDadosImportacaoContabil>;
  protected
    FlstControleError: TStringList ;
    FstrContaEmprestimoAtivo : string;
    FstrContaEmprestimoPassivo : string;
  public
    procedure pRegistrarProgresso(progresso: TcxProgressBar; intInicio, intAtual, intFinal: Integer);

    constructor create(dadosAbertura: TDadosAbertura; listaDadosImportacaoContabil, listaDadosImportacaoContabilWarning, listaDadosImportacaoContabilError: TObjectList<TDadosImportacaoContabil>);
    destructor Destroy; override;

    property listaDadosImportacaoContabil: TObjectList<TDadosImportacaoContabil> read FListaDadosImportacaoContabil write FListaDadosImportacaoContabil;
    property parametrosContabil: TObjectList<TParametroContabil> read FListaParametrosContabil write FListaParametrosContabil;
    property listaParametrosContabil: TObjectList<TParametroContabil> read FListaParametrosContabil write FListaParametrosContabil;
    property dadosAbertura: TDadosAbertura read FDadosAbertura write FDadosAbertura;
    property ListaDadosImportacaoContabilWarning: TObjectList<TDadosImportacaoContabil> read FListaDadosImportacaoContabilWarning write FListaDadosImportacaoContabilWarning ;
    property ListaDadosImportacaoContabilError: TObjectList<TDadosImportacaoContabil> read FListaDadosImportacaoContabilError write FListaDadosImportacaoContabilError ;
  end;

implementation

uses Contabilidade.funcoes ;

{ TGeradorContabilBase }

constructor TGeradorContabilBase.create(dadosAbertura: TDadosAbertura; listaDadosImportacaoContabil, listaDadosImportacaoContabilWarning, listaDadosImportacaoContabilError: TObjectList<TDadosImportacaoContabil>);
begin
  FListaDadosImportacaoContabil := listaDadosImportacaoContabil;
  FDadosAbertura := dadosAbertura;
  FListaDadosImportacaoContabilWarning := listaDadosImportacaoContabilWarning;
  FListaDadosImportacaoContabilError := listaDadosImportacaoContabilError;
  FlstControleError := TStringList.Create ;
  FlstControleError.Sorted := True ;
  FstrContaEmprestimoAtivo := fPlanoContasEmprestimoEntreEmpresasAtivo ;
  FstrContaEmprestimoPassivo := fPlanoContasEmprestimoEntreEmpresasPassivo ;
end;

destructor TGeradorContabilBase.Destroy;
begin
  FreeAndNil(FlstControleError) ;
  inherited;
end;

procedure TGeradorContabilBase.pRegistrarProgresso(progresso: TcxProgressBar; intInicio, intAtual, intFinal: Integer);
begin
  progresso.Properties.Min := intInicio;
  progresso.Position := intAtual;
  progresso.Properties.Max := intFinal;
  Application.ProcessMessages;
end;

end.
