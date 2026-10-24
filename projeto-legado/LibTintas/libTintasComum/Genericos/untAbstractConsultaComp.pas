{ **************************************************************************************** }
{ * Classe abstrata que implementa a interface IConsultaComp responsável pelos botões de * }
{ * ação da tela de consulta das tintas                                                  * }
{ *************************************************************************************PH* }
unit untAbstractConsultaComp;

interface

uses
  untIConsultaComp, untIConsultaCompTintaNovaConfigurador, untIDigDadosTintometricos,
  untITintadeMaquinaWrapper, untIDataSet, untAutcomTintaFactory, SysUtils, Data.db,
  untIDicionario;

type
  TAbstractConsultaComp = class abstract(TInterfacedObject, IConsultaComp)
  protected
    digDadosTintometricos: IDigDadosTintometricos;
    tintadeMaquinaWrapper: ITintadeMaquinaWrapper;
  public
    constructor Create(const digDadosTintometricos: IDigDadosTintometricos;
      const tintadeMaquinaWrapper: ITintadeMaquinaWrapper); virtual;
    procedure pTarefaFormulacao(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador; dicRetorno: IDicionario); virtual;
    procedure pTarefaPrecos(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador; dicRetorno: IDicionario); virtual;
    procedure pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador); virtual; abstract;
  end;

implementation

{ TAbstractConsultaComp }

constructor TAbstractConsultaComp.Create(const digDadosTintometricos: IDigDadosTintometricos; 
  const tintadeMaquinaWrapper: ITintadeMaquinaWrapper);
begin
  inherited Create();
  Self.digDadosTintometricos := digDadosTintometricos;
  Self.tintadeMaquinaWrapper := tintadeMaquinaWrapper;
end;

procedure TAbstractConsultaComp.pTarefaFormulacao(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador;  dicRetorno: IDicionario);
var
  qryGen: IDataSet;
begin
  Try
    if configurador.DataSetConsulta.IsEmpty then
      Exit;

    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := TAutcomTintaFactory.Get.GetIConsultaTinta(tintadeMaquinaWrapper).fGetSelectAutoIncrem(
	  configurador.DataSetConsulta.FieldByName('AUTOINCREM').AsString);
    qryGen.Open;

    {*********************************************}
    {**** IF ADICIONADO PARA NÃO OCORRER ERRO ****}
    {**** NA CONSULTA DO AUTTIN.EXE DAS TINTA ****}
    {******************************************RG*}
    If dicRetorno = Nil Then
      dicRetorno := TAutcomTintaFactory.Get.GetDicionario;

    dicRetorno['propre'] := TAutcomTintaFactory.Get.fCfgSis('PROPRE') = 2;

    digDadosTintometricos.fDigDadosTintometricos(
	  qryGen, 
	  dicRetorno);
  Except
    on E: Exception do
    begin
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', E.Message, ['OK']);
    end;
  End;

end;

procedure TAbstractConsultaComp.pTarefaPrecos(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador;  dicRetorno: IDicionario);
begin
  pTarefaFormulacao(Sender, configurador, dicRetorno);
end;

end.
