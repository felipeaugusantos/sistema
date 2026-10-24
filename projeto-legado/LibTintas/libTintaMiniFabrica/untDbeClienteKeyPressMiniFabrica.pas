unit untDbeClienteKeyPressMiniFabrica;

interface

uses untAutcomTintaFactory, Classes, untIAutcomTintaWrapper, SysUtils, untIDataSet, untAbstractLibTintaControleVisualEvento,
  untILibTintaControleVisual, untTipoTinta;

type
  TDbeClienteKeyPressMiniFabrica = class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  Private
    arrTitCol: Array of String;
    Procedure pAddNomeColuna(strNomCol: String);
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

procedure TDbeClienteKeyPressMiniFabrica.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryCadPro : IDataSet;
  strSQL,
  strSQLWhere,
  strSQLGroup : String;
begin
  Try
    Try
      qryCadPro := TAutcomTintaFactory.Get.fGetDataSet;

      if TAutcomTintaFactory.Get.fEntraCons(Key) then
      begin
        Key := #0;
        strSQL := strSQL + ' SELECT CLI_CODCLI,    '; pAddNomeColuna('Código');
        strSQL := strSQL + '        CLI_NOMCLI,    '; pAddNomeColuna('Nome Cliente');
        strSQL := strSQL + '        AUTOINCREM     ';
        strSQL := strSQL + '   FROM CADCLI         ';
        strSQLWhere := '';
        strSQLGroup :=  '';

        If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere, strSQLGroup], arrTitCol, ['CLI_CODCLI'], 'AUTOINCREM',
         'CADCLI', 'untDbeClienteKeyPressMiniFabrica', 'Consulta de Clientes - Mini Fábrica', qryCadPro, [], []) Then
        Begin
          tela['dbeCodCli']['Text'].Value := qryCadPro.FieldByName('CLI_CODCLI').AsString;
          tela['dbeClient']['Text'].Value := qryCadPro.FieldByName('CLI_NOMCLI').AsString;
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
  End;
end;
procedure TDbeClienteKeyPressMiniFabrica.pAddNomeColuna(strNomCol: String);
begin
  SetLength(arrTitCol, Succ(Length(arrTitCol)));
  arrTitCol[High(arrTitCol)] := strNomCol;
end;

end.

