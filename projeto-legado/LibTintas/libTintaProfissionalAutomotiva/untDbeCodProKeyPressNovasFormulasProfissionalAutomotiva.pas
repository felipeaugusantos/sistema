unit untDbeCodProKeyPressNovasFormulasProfissionalAutomotiva;

interface

uses
  untAbstractLibTintaControleVisualEvento, Classes, SysUtils, untStrUtils;

type
  TDbeCodProKeyPressNovasFormulasProfissionalAutomotiva = class(TAbstractLibTintaControleVisualEvento)
  Private
     arrTitCol: array of string;
     Procedure pAddNomeColuna(strNomCol: String);
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

uses
  untIDataSet, untAutcomTintaFactory;

{ TDeCodProKeyPress }

procedure TDbeCodProKeyPressNovasFormulasProfissionalAutomotiva.OnKeyPress(Sender: TObject; var Key: Char);
var
  strSQL: String;
  qryConsulta: IDataSet;
  strRetorno: String;
begin
  strRetorno:= '';
  Try
    Try
      If (TAutcomTintaFactory.Get.fEntraCons(Key)) Then
      Begin
        Key := #0;

        qryConsulta := TAutcomTintaFactory.Get.fGetDataSet;

        strSQL := '';
        strSQL := strSQL + 'SELECT ';
        strSQL := strSQL + '  BAS_CODBAS, '; paddNomeColuna('Código Base');
        strSQL := strSQL + '  BAS_DESCRI, '; paddNomeColuna('Descrição');
        strSQL := strSQL + '  BAS_CODITE, '; paddNomeColuna('Código Item');
        strSQL := strSQL + '  ITE_DESITE, '; paddNomeColuna('Descrição Item');
        strSQL := strSQL + '  BAS_CATALI, '; paddNomeColuna('Catálise');
        strSQL := strSQL + '  ITE_REFERE, '; paddNomeColuna('Referência');
        strSQL := strSQL + '  BAS_PESESP, '; paddNomeColuna('Peso Específico');
        strSQL := strSQL + '  BAS_PRECUS, '; paddNomeColuna('Preço Custo');
        strSQL := strSQL + '  BAS_PREVEN, '; paddNomeColuna('Preço Venda');
        strSQL := strSQL + '  BAS_MARGEM, '; paddNomeColuna('Margem');
        strSQL := strSQL + '  BAS_EMBALA, '; paddNomeColuna('Embalagem');
        strSQL := strSQL + '  PFA_CADBAS.AUTOINCREM ';
        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  PFA_CADBAS ';
        strSQL := strSQL + 'INNER JOIN CADITE ON ITE_CODITE = BAS_CODITE ';

        If (TAutcomTintaFactory.Get.pConsultaComp(
            [strSQL],
            arrTitCol,
            ['ITE_DESITE'],
            'AUTOINCREM',
            'PFA_CADBAS',
            'untDbeCodProKeyPressNovasFormulasProfissionalAutomotiva',
            'Consulta Base - Profissional Automotiva',
            qryConsulta, [], [])) Then
        Begin
          GetFieldByControle('dbeBase').AsString := qryConsulta.FieldByName('BAS_CODBAS').AsString;
          GetFieldByControle('dbeCatalise').AsString := qryConsulta.FieldByName('BAS_CATALI').AsString;
          tela.SelectNext;
        End;
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;
end;

procedure TDbeCodProKeyPressNovasFormulasProfissionalAutomotiva.pAddNomeColuna(
  strNomCol: String);
begin
  SetLength(arrTitCol, Succ(Length(arrTitCol)));
  arrTitCol[High(arrTitCol)] := strNomCol;
end;

end.
