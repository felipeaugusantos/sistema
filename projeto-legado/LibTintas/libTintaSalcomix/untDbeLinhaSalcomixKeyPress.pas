unit untDbeLinhaSalcomixKeyPress;

interface

uses untAutcomTintaFactory, Classes, untIAutcomTintaWrapper, SysUtils, untIDataSet, untAbstractLibTintaControleVisualEvento,
  untILibTintaControleVisual, untTipoTinta;

Type
  TDbeLinhaSalcomixKeyPress = class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

{ TDbeLinhaSalcomixKeyPress }

procedure TDbeLinhaSalcomixKeyPress.OnKeyPress(Sender: TObject; var Key: Char);
Const
  ArrayLinha: Array[1..9] Of String = ('Salcomix', 'S326', 'S850', 'S648', 'S327', 'S603', 'S325', '525', '729');
begin
  If TAutcomTintaFactory.Get.fEntraCons(Key) Then
  Begin
    Key := #0;
    tela['dbeLinha']['Text'].Value := ArrayLinha[TAutcomTintaFactory.Get.fGetMenu('Escolha uma linha', ArrayLinha, 1, False, False)];
    tela.SelectNext;
  End;
end;

end.
