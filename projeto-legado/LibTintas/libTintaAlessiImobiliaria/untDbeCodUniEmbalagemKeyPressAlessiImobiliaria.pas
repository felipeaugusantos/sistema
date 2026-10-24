unit untDbeCodUniEmbalagemKeyPressAlessiImobiliaria;

interface

uses untAutcomTintaFactory, Classes, untIAutcomTintaWrapper, SysUtils, untIDataSet, untAbstractLibTintaControleVisualEvento,
  untILibTintaControleVisual, untAbstractCadastro, StrUtils;

type
  TDbeCodUniEmbalagemKeyPressAlessiImobiliaria = class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  private
    strNomeCampo: string;
    strEmbala: string;
  published
    constructor Create(const cadastro: TAbstractCadastro; const strNomeCampo: string;
      const strEmbala: string); reintroduce;
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

{ TDbeCodUniEmbalagemKeyPress }

constructor TDbeCodUniEmbalagemKeyPressAlessiImobiliaria.Create(
  const cadastro: TAbstractCadastro; const strNomeCampo: string; const strEmbala: string);
begin
  inherited Create('OnKeyPress', cadastro);
  Self.strNomeCampo := strNomeCampo;
  Self.strEmbala := strEmbala;
end;

procedure TDbeCodUniEmbalagemKeyPressAlessiImobiliaria.OnKeyPress(Sender: TObject; var Key: Char);
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

        If TAutcomTintaFactory.Get.fPesqGenericaTinta(qryConsulta, 'ALE_CADEMB',
          'untDbeCodUniEmbalagemKeyPressAlessiImobiliaria', 'Consulta de Embalagens - Alessi Imobiliária') Then
        Begin
          GetFieldByControle(strNomeCampo).AsString := qryConsulta.FieldByName('EMB_CODUNI').AsString;

          GetFieldByControle(strEmbala).AsString := qryConsulta.FieldByName('EMB_NOME__').AsString;

          If cadastro.fValidaCampos(tela, cadastro.GetNomeCampoItem + RightStr(strNomeCampo, 2), qryConsulta.FieldByName('EMB_CODUNI').AsString, strRetorno) Then
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
