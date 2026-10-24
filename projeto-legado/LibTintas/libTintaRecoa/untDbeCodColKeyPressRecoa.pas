unit untDbeCodColKeyPressRecoa;

interface

uses untAutcomTintaFactory, Classes, untIAutcomTintaWrapper, SysUtils, untIDataSet, untAbstractLibTintaControleVisualEvento,
  untILibTintaControleVisual, untAbstractCadastro, StrUtils;

type
  TDbeCodColKeyPressRecoa = class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  private
    strNomeCampo: string;
  published
    constructor Create(const cadastro: TAbstractCadastro; const strNomeCampo: string); reintroduce;
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

{ TDbeCodColKeyPress }

constructor TDbeCodColKeyPressRecoa.Create(const cadastro: TAbstractCadastro; const strNomeCampo: string);
begin
  inherited Create('OnKeyPress', cadastro);
  Self.strNomeCampo := strNomeCampo;
end;

procedure TDbeCodColKeyPressRecoa.OnKeyPress(Sender: TObject; var Key: Char);
var
  strSQL: String;
  stlCamInd: TStringList;
  stlDesInd: TStringList;
  qryConsulta: IDataSet;
  strRetorno: String;
  arrTitCol: array of string;

  Procedure pAddNomeColuna(strNomCol: String);
  Begin
    SetLength(arrTitCol, Succ(Length(arrTitCol)));
    arrTitCol[High(arrTitCol)] := strNomCol;
  End;

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
        strSQL := strSQL + '  COL_CODCOL, '; paddNomeColuna('Colorante');
        strSQL := strSQL + '  COL_CODITE, '; paddNomeColuna('Item');
        strSQL := strSQL + '  ITE_DESITE, '; paddNomeColuna('Descrição Item');
        strSQL := strSQL + '  ITE_REFERE, '; paddNomeColuna('Referência Item');
        strSQL := strSQL + '  REC_CADCOL.AUTOINCREM ';
        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  REC_CADCOL ';
        strSQL := strSQL + 'INNER JOIN CADITE ON ITE_CODITE = COL_CODITE ';

        If (TAutcomTintaFactory.Get.pConsultaComp(
            [strSQL],
            arrTitCol,
            ['ITE_DESITE'],
            'AUTOINCREM',
            'REC_CADCOL',
            'untDbeCodColKeyPressRecoa',
            'Consulta Colorante - Recoa Imobilíaria',
            qryConsulta, [], [])) Then
        Begin
          GetFieldByControle(strNomeCampo).AsString := qryConsulta.FieldByName('COL_CODCOL').AsString;
          If cadastro.fValidaCampos(tela, cadastro.GetNomeCampoItem + RightStr(strNomeCampo, 2), qryConsulta.FieldByName('COL_CODCOL').AsString, strRetorno) Then
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
    if Assigned(stlCamInd) then FreeAndNil(stlCamInd);
    if Assigned(stlDesInd) then FreeAndNil(stlDesInd);
  End;

end;

end.
