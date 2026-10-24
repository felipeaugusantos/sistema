unit untDbeCodBasKeyPressBrasimixAutomotiva;

interface

uses untAutcomTintaFactory, Classes, untIAutcomTintaWrapper, SysUtils, untIDataSet, untAbstractLibTintaControleVisualEvento,
  untILibTintaControleVisual, untAbstractCadastro, StrUtils;

type
  TDbeCodBasKeyPressBrasimixAutomotiva = class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  private
    strNomeCampo: string;
  published
    constructor Create(const cadastro: TAbstractCadastro; const strNomeCampo: string); reintroduce;
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

{ TDbeCodColKeyPress }

constructor TDbeCodBasKeyPressBrasimixAutomotiva.Create(const cadastro: TAbstractCadastro; const strNomeCampo: string);
begin
  inherited Create('OnKeyPress', cadastro);
  Self.strNomeCampo := strNomeCampo;
end;

procedure TDbeCodBasKeyPressBrasimixAutomotiva.OnKeyPress(Sender: TObject; var Key: Char);
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

        If (TAutcomTintaFactory.Get.fPesqGenericaTinta(qryConsulta, 'BZA_CADBAS', 'untDbeCodBasKeyPressBrasimixAutomotiva',  'Consulta Base - Brasimix Automotiva')) Then
        Begin
          GetFieldByControle(strNomeCampo).AsString := qryConsulta.FieldByName('BAS_CODBAS').AsString;
          If cadastro.fValidaCampos(tela, cadastro.GetNomeCampoItem + RightStr(strNomeCampo, 2), qryConsulta.FieldByName('BAS_CODBAS').AsString, strRetorno) Then
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
