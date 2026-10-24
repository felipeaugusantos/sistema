{****************************************************************************}
{* Classes responsável pelos botões da tela de consulta da tinta Starmix *}
{*************************************************************************AC*}
unit untConsultaCompStarmix;

interface

uses
  untIConsultaCompTintaNovaConfigurador, Dialogs, untAbstractConsultaComp, untIAutcomTintaWrapper,
  untIDataSet, Math, SysUtils, untStrUtils;

type
  TConsultaCompStarmix = class(TAbstractConsultaComp)
  Private
    procedure DeletarRegistro(strIdePro: String; strCodOpe: String);
  public
    procedure pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador); override;
  end;

implementation

uses
  untAutcomTintaFactory;

{ TConsultaCompStarmix }

procedure TConsultaCompStarmix.DeletarRegistro(strIdePro, strCodOpe: String);
Var
  qryGen: IDataSet;
Begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := '   DELETE FROM AUXBAS WHERE BAS_IDEPRO = :IDEPRO AND BAS_CODOPE = :CODOPE    ';
  qryGen.ParamByName('IDEPRO').AsString := strIdePro;
  qryGen.ParamByName('CODOPE').AsString := strCodOpe;
  qryGen.ExecSQL;
End;

procedure TConsultaCompStarmix.pTarefaVenda(const Sender: TObject; const configurador: IConsultaCompTintaNovaConfigurador);
Var
  qryGen: IDataSet;
begin
  DeletarRegistro('STA', TAutcomTintaFactory.Get.GetUsuarioLogado);

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
    qryGen.FieldByName('BAS_IDEPRO').AsString := 'STA';
    qryGen.FieldByName('BAS_CODOPE').AsString := TAutcomTintaFactory.Get.GetUsuarioLogado;
    qryGen.Post;
  End;
  TAutcomTintaFactory.Get.CriarNovasFormulasDllsGeneric('mnuCadStaNovasFormulas');
end;

end.
