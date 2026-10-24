{**********************************************************************************************}
{* Classe especializada em mostrar as consultas das dlls da tinta, que implementa a interface *}
{* IConsultaCompTintaNovaConfigurador, assim é possivel as dlls terem acesso as informações   *}
{* da tela de consulta, sem saberem sua implementação                                         *}
{*******************************************************************************************PH*}
unit untConsultaCompWrapper;

interface

uses
  untIConsultaComp, untIConsultaCompTintaNovaConfigurador,
  untIDataSet, Classes, untIConsulta, untPnlBotoesAcoesNovaConsulta, untIDicionario,
  untTypesSistema;

type
  TConsultaCompWrapper = class(TfrmPnlBotoesAcoesNovaConsulta, IConsultaCompTintaNovaConfigurador)
  private
//    consultaComp: IConsultaComp;
  public
    constructor Create(AOwner: TComponent;
                tipoConsulta: TTipoConsultaTinta;
                strTabPre: String;
                tinta: IConsulta;
                const consultaComp: IConsultaComp;
                strIdePro: String; dicRetorno: IDicionario); reintroduce;

    procedure pTarefaFormulacao(Sender: TObject); override;
    procedure pTarefaPrecos(Sender: TObject); override;
    procedure pTarefaVenda(Sender: TObject); override;
    function GetDataSetConsulta: IDataSet;
  end;

  TConsultaCompWrapperClass = class of TConsultaCompWrapper;

implementation

uses
  untUniQueryDataSetWrapper;

{ TConsultaCompWrapper }

constructor TConsultaCompWrapper.Create(AOwner: TComponent;
  tipoConsulta: TTipoConsultaTinta; strTabPre: String; tinta: IConsulta; const consultaComp: IConsultaComp;
  strIdePro: String; dicRetorno: IDicionario);
begin
  inherited Create(tipoConsulta, strTabPre, tinta, consultaComp);
  Self.consultaComp := consultaComp;
  Self.dicRetorno := dicRetorno;
end;

function TConsultaCompWrapper.GetDataSetConsulta: IDataSet;
begin
  Result := TUniQueryDataSetWrapper.Create(qryConsulta);
end;

procedure TConsultaCompWrapper.pTarefaFormulacao(Sender: TObject);
begin
  if Assigned(consultaComp) then
    consultaComp.pTarefaFormulacao(Sender, Self, dicRetorno);
end;

procedure TConsultaCompWrapper.pTarefaPrecos(Sender: TObject);
begin
  if Assigned(consultaComp) then
    consultaComp.pTarefaPrecos(Sender, Self, dicRetorno);
end;

procedure TConsultaCompWrapper.pTarefaVenda(Sender: TObject);
begin
  if Assigned(consultaComp) then
    consultaComp.pTarefaVenda(Sender, Self);
end;

end.
