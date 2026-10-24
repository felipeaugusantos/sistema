unit untDbeCodColKeyPressRennerPerformance;

interface

uses untAutcomTintaFactory, Classes, untIAutcomTintaWrapper, SysUtils, untIDataSet, untAbstractLibTintaControleVisualEvento,
  untILibTintaControleVisual, untAbstractCadastro, StrUtils;

type
  TDbeCodColKeyPressRennerPerformance = class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  private
    strNomeCampo: string;
    arrTitCol: array of string;
    Procedure pAddNomeColuna(strNomCol: String);
  published
    constructor Create(const cadastro: TAbstractCadastro; const strNomeCampo: string); reintroduce;
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

{ TDbeCodColKeyPress }

constructor TDbeCodColKeyPressRennerPerformance.Create(const cadastro: TAbstractCadastro; const strNomeCampo: string);
begin
  inherited Create('OnKeyPress', cadastro);
  Self.strNomeCampo := strNomeCampo;
end;

procedure TDbeCodColKeyPressRennerPerformance.OnKeyPress(Sender: TObject; var Key: Char);
var
  strSQL: String;
  stlCamInd: TStringList;
  stlDesInd: TStringList;
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
        strSQL := strSQL + '  COL_CODCOL, '; paddNomeColuna('Colorante');
        strSQL := strSQL + '  COL_CODITE, '; paddNomeColuna('Item');
        strSQL := strSQL + '  ITE_DESITE, '; paddNomeColuna('Descrição Item');
        strSQL := strSQL + '  ITE_REFERE, '; paddNomeColuna('Referência Item');
        strSQL := strSQL + '  REP_CADCOL.AUTOINCREM ';
        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  REP_CADCOL ';
        strSQL := strSQL + 'INNER JOIN CADITE ON ITE_CODITE = COL_CODITE ';

        If (TAutcomTintaFactory.Get.pConsultaComp(
            [strSQL],
            arrTitCol,
            ['ITE_DESITE'],
            'AUTOINCREM',
            'REP_CADCOL',
            'untDbeCodColKeyPressRennerPerformance',
            'Consulta Colorante - Renner Performance',
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

procedure TDbeCodColKeyPressRennerPerformance.pAddNomeColuna(strNomCol: String);
begin
  Begin
    SetLength(arrTitCol, Succ(Length(arrTitCol)));
    arrTitCol[High(arrTitCol)] := strNomCol;
  End;
end;

end.
