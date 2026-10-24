{**************************************************************************}
{* Classes responsável pelos botões da tela de consulta da tinta ColorPro *}
{***********************************************************************AC*}
unit untConsultaCompColorPro;

interface

uses
  untIConsultaCompTintaNovaConfigurador, Dialogs, untAbstractConsultaComp, untIAutcomTintaWrapper,
  untIDataSet, Math, SysUtils, untStrUtils;

type
  TConsultaCompColorPro = class(TAbstractConsultaComp)
  Private
    procedure DeletarRegistro(strIdePro: String; strCodOpe: String);
  public
    procedure pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador); override;
  end;

implementation

uses
  untAutcomTintaFactory;

{ TConsultaCompColorPro }

procedure TConsultaCompColorPro.DeletarRegistro(strIdePro, strCodOpe: String);
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := '   DELETE FROM AUXBAS WHERE BAS_IDEPRO = :IDEPRO AND BAS_CODOPE = :CODOPE    ';
  qryGen.ParamByName('IDEPRO').AsString := strIdePro;
  qryGen.ParamByName('CODOPE').AsString := strCodOpe;
  qryGen.ExecSQL;
end;

procedure TConsultaCompColorPro.pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador);
Var
  qryGen: IDataSet;
begin
  DeletarRegistro('WCP', TAutcomTintaFactory.Get.GetUsuarioLogado);

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := '';
  qryGen.SQL := qryGen.SQL + '  SELECT              ';
  qryGen.SQL := qryGen.SQL + '    *                 ';
  qryGen.SQL := qryGen.SQL + '  FROM                ';
  qryGen.SQL := qryGen.SQL + '    AUXBAS            ';
  qryGen.Open;

  If Not TStrUtils.fEmptyStr(configurador.DataSetConsulta.FieldByName('AUTOINCREM').AsString) Then
  Begin
    qryGen.Insert;
    qryGen.FieldByName('AUTOINCREM').AsString := configurador.DataSetConsulta.FieldByName('AUTOINCREM').AsString;
    qryGen.FieldByName('BAS_IDEPRO').AsString := 'WCP';
    qryGen.FieldByName('BAS_CODOPE').AsString := TAutcomTintaFactory.Get.GetUsuarioLogado;
    qryGen.Post;
  End;

  TAutcomTintaFactory.Get.CriarNovasFormulasDllsGeneric('mnuCadWcpNovasFormulas');
end;

end.
