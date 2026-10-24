unit untDbeCodUniKillingKeyPress;

interface

uses untAutcomTintaFactory, Classes, untIAutcomTintaWrapper, SysUtils, untIDataSet, untAbstractLibTintaControleVisualEvento,
  untILibTintaControleVisual, untTipoTinta;

type
  TDbeCodUniKillingKeyPress = class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  private
    function fRetEmbalagem(strUnidade:String):Double;
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;


implementation

function TDbeCodUniKillingKeyPress.fRetEmbalagem(strUnidade: String): Double;
begin
  Result := 810;

  If strUnidade = 'M18' Then
    Result := 16200
  Else If strUnidade = 'L18.' Then
    Result := 14000
  Else If strUnidade = 'K18' Then
    Result := 14750
  Else If strUnidade = 'L18' Then
    Result := 16200
  Else If strUnidade = 'P18' Then
    Result := 16200
  Else If strUnidade = 'H18' Then
    Result := 16200
  Else If strUnidade = 'GP' Then
    Result := 2950
  Else If strUnidade = 'GM' Then
    Result := 3240
  Else If strUnidade = 'LT9' Then
    Result := 810
  Else If strUnidade = 'AMO' Then
    Result := 202
end;

procedure TDbeCodUniKillingKeyPress.OnKeyPress(Sender: TObject; var Key: Char);
const
  ArrayEmbalagens: Array[1..10] Of String = ('M18', 'L18.', 'L18', 'P18', 'H18', 'K18', 'GP', 'GM', 'LT9', 'AMO');
begin
  inherited;
  If TAutcomTintaFactory.Get.fEntraCons(Key) Then
  Begin
    Key := #0;
    tela['dbeEmbala']['Text'].Value := ArrayEmbalagens[TAutcomTintaFactory.Get.fGetMenu('Escolha uma Embalagem',ArrayEmbalagens, 1, False, False)];
    GetFieldByControle('dbeQtdEmbala').AsFloat := fRetEmbalagem(tela['dbeEmbala']['Text'].Value);
  End;
end;
end.
