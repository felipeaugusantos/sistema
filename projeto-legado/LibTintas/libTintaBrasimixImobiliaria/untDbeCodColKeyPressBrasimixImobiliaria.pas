unit untDbeCodColKeyPressBrasimixImobiliaria;

interface

uses untAutcomTintaFactory, Classes, untIAutcomTintaWrapper, SysUtils, untIDataSet, untAbstractLibTintaControleVisualEvento,
  untILibTintaControleVisual, untAbstractCadastro, StrUtils;

type
  TDbeCodColKeyPressBrasimixImobiliaria = class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  private
    strNomeCampo: string;
  published
    constructor Create(const cadastro: TAbstractCadastro; const strNomeCampo: string); reintroduce;
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

{ TDbeCodColKeyPress }

constructor TDbeCodColKeyPressBrasimixImobiliaria.Create(const cadastro: TAbstractCadastro; const strNomeCampo: string);
begin
  inherited Create('OnKeyPress', cadastro);
  Self.strNomeCampo := strNomeCampo;
end;

procedure TDbeCodColKeyPressBrasimixImobiliaria.OnKeyPress(Sender: TObject; var Key: Char);
var
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

        If TAutcomTintaFactory.Get.fPesqGenericaTinta(qryConsulta, 'BZI_CADCOL', 'untDbeCodColKeyPressBrasimixImobiliaria', 'Consulta Colorantes - Brasimix Imobiliária') Then
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
  End;
end;

end.
