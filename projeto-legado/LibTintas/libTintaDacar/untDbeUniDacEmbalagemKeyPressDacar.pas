unit untDbeUniDacEmbalagemKeyPressDacar;

interface

uses untAutcomTintaFactory, Classes, untIAutcomTintaWrapper, SysUtils, untIDataSet,
  untAbstractLibTintaControleVisualEvento, untILibTintaControleVisual,
  untAbstractCadastro, StrUtils;

type
  TDbeUniDacEmbalagemKeyPressDacar = class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  private

  published
    constructor Create(const cadastro: TAbstractCadastro); reintroduce;
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

{ TDbeUniDacEmbalagemKeyPress }

constructor TDbeUniDacEmbalagemKeyPressDacar.Create(
  const cadastro: TAbstractCadastro);
begin
  inherited Create('OnKeyPress', cadastro);
end;

procedure TDbeUniDacEmbalagemKeyPressDacar.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryCadUni: IDataSet;
  strRetorno, strSQL,
  strSQLWhere, strSQLGroup: String;

  arrTitCol: Array of String;

  Procedure pAddNomeColuna(strNomCol: String);
  Begin
    SetLength(arrTitCol, Succ(Length(arrTitCol)));
    arrTitCol[High(arrTitCol)] := strNomCol;
  End;

begin
  Try
    Try
      qryCadUni := TAutcomTintaFactory.Get.fGetDataSet;

      if TAutcomTintaFactory.Get.fEntraCons(Key) then
      begin
        Key := #0;
        strSQL := strSQL + ' SELECT       ';
        strSQL := strSQL + '   D.BAS_UNIDAD, '; pAddNomeColuna('Unidade');
        strSQL := strSQL + '   D.AUTOINCREM  ';
        strSQL := strSQL + ' FROM            ';
        strSQL := strSQL + '   DAC_CADBAS D  ';

        strSQLWhere := ' WHERE TRUE ';

        strSQLGroup := ' GROUP BY BAS_UNIDAD ';

        If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere, strSQLGroup], arrTitCol, ['BAS_UNIDAD'],
          'AUTOINCREM', 'DAC_CADBAS', 'untDbeUniDacEmbalagemKeyPressDacar', 'Consulta de Unidade - Tintas', qryCadUni, [], []) Then
        Begin
          GetFieldByControle('dbeUniDac').AsString := qryCadUni.FieldByName('BAS_UNIDAD').AsString;
          If cadastro.fValidaCampos(tela, cadastro.GetNomeCampo, tela['dbeUniDac']['Text'].Value, strRetorno) Then
            tela.SelectNext;
        End;
      end;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;

end;

end.
