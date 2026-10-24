unit untDbeCodCatKeyPressDuxone;

interface

uses untAutcomTintaFactory, Classes, untIAutcomTintaWrapper, SysUtils, untIDataSet, untAbstractLibTintaControleVisualEvento,
  untILibTintaControleVisual, untAbstractCadastro, StrUtils;

type
  TDbeCodCatKeyPressDuxone = class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  private
    strNomeCampo: string;
  published
    constructor Create(const cadastro: TAbstractCadastro; const strNomeCampo: string); reintroduce;
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

{ TDbeCodCatKeyPress }

constructor TDbeCodCatKeyPressDuxone.Create(const cadastro: TAbstractCadastro; const strNomeCampo: string);
begin
  inherited Create('OnKeyPress', cadastro);
  Self.strNomeCampo := strNomeCampo;
end;

procedure TDbeCodCatKeyPressDuxone.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryConsulta: IDataSet;
  strRetorno: String;
  strFiltro: String;
begin
  strRetorno:= '';
  Try
    Try
      If (TAutcomTintaFactory.Get.fEntraCons(Key)) Then
      Begin
        Key := #0;
        qryConsulta := TAutcomTintaFactory.Get.fGetDataSet;

        strFiltro := ' AND BAS_DESBAS LIKE "%CATALISADOR%" ';

        If (TAutcomTintaFactory.Get.fPesqGenericaTinta(qryConsulta, 'DUX_CADBAS', 'untDbeCodCatKeyPressDuxone',
          'Consulta Base - Duxone', '', strFiltro)) Then
        Begin
          GetFieldByControle(strNomeCampo).AsString := qryConsulta.FieldByName('BAS_CODBAS').AsString;
          If cadastro.fValidaCampos(tela, 'NFM_CODCAT', qryConsulta.FieldByName('BAS_CODBAS').AsString, strRetorno) Then
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

end.
