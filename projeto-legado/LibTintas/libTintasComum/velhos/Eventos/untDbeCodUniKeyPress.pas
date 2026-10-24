unit untDbeCodUniKeyPress;

interface

uses untAutcomTintaFactory, Classes, untIAutcomTintaWrapper, SysUtils, untIDataSet, untAbstractLibTintaControleVisualEvento,
  untILibTintaControleVisual;

type
  TDbeCodUniKeyPress = class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

procedure TDbeCodUniKeyPress.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryCadUni: IDataSet;

  stlCamIndCon: TStringList;
  stlDesIndCon: TStringList;
begin
  stlCamIndCon := nil;
  stlDesIndCon := nil;
  Try
    Try
      stlCamIndCon := TStringList.Create;
      stlDesIndCon := TStringList.Create;

      if TAutcomTintaFactory.Get.fEntraCons(Key) then
      begin
        Key := #0;


        stlCamIndCon.Add('UNI_DESUNI');
        stlCamIndCon.Add('UNI_SIGUNI');
        stlCamIndCon.Add('UNI_CODUNI');

        stlDesIndCon.Add('Descrição');
        stlDesIndCon.Add('Sigla');
        stlDesIndCon.Add('Código');


        If TAutcomTintaFactory.Get.pConsultaComp(qryCadUni,
          'CADUNI',
          ' SELECT                       ' +
          '   U.AUTOINCREM               ' +
          '   , U.UNI_CODUNI "Código"    ' +
          '   , U.UNI_DESUNI "Descrição" ' +
          '   , U.UNI_SIGUNI "Sigla"     ' +
          ' FROM                         ' +
          '   CADUNI U                   ',
          stlCamIndCon.Text,
          stlDesIndCon.Text) Then
        Begin
          GetFieldByControle('dbeCodUni').AsString := qryCadUni.FieldByName('UNI_CODUNI').AsString;
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
    if Assigned(stlCamIndCon) then FreeAndNil(stlCamIndCon);
    if Assigned(stlDesIndCon) then FreeAndNil(stlDesIndCon);
  End;
end;
end.
