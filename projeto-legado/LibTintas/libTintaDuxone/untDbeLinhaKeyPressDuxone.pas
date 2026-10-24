unit untDbeLinhaKeyPressDuxone;

interface

uses untAutcomTintaFactory, Classes, untIAutcomTintaWrapper, SysUtils, untIDataSet, untAbstractLibTintaControleVisualEvento,
  untILibTintaControleVisual, untAbstractCadastro, StrUtils, untICadLibTintas;

type
  TDbeLinhaKeyPressDuxone = class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  private
    strNomeCampo: string;
  published
    constructor Create(const cadastro: TAbstractCadastro; const strNomeCampo: string); reintroduce;
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

{ TDbeCodColKeyPress }

constructor TDbeLinhaKeyPressDuxone.Create(const cadastro: TAbstractCadastro; const strNomeCampo: string);
begin
  inherited Create('OnKeyPress', cadastro);
  Self.strNomeCampo := strNomeCampo;
end;

procedure TDbeLinhaKeyPressDuxone.OnKeyPress(Sender: TObject; var Key: Char);
var
  strRetorno: String;
  arrLinha: TCadLibTintasStringArray;
begin
  strRetorno:= '';
  Try
    Try
      If (TAutcomTintaFactory.Get.fEntraCons(Key)) Then
      Begin
        Key := #0;

        arrLinha := cadastro.fGetArrayLinhas;
        GetFieldByControle(strNomeCampo).AsString := arrLinha[TAutcomTintaFactory.Get.fGetMenu('Escolha a Linha', arrLinha, 1) - 1];
        If cadastro.fValidaCampos(tela, strNomeCampo, GetFieldByControle(strNomeCampo).AsString, strRetorno) Then
          tela.SelectNext;
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
