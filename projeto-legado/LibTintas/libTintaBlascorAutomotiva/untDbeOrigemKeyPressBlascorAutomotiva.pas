unit untDbeOrigemKeyPressBlascorAutomotiva;

interface

uses untAutcomTintaFactory, Classes, untIAutcomTintaWrapper, SysUtils, untIDataSet, untAbstractLibTintaControleVisualEvento,
  untILibTintaControleVisual, untTipoTinta;

type
  TDbeOrigemKeyPressBlascorAutomotiva = class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  Private
    arrTitCol: Array of String;
    Procedure pAddNomeColuna(strNomCol: String);
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

procedure TDbeOrigemKeyPressBlascorAutomotiva.OnKeyPress(Sender: TObject; var Key: Char);
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
        strSQL := strSQL + ' SELECT NFM_CODIGO,    '; pAddNomeColuna('Código');
        strSQL := strSQL + '        NFM_DESCRI,    '; pAddNomeColuna('Descrição');
        strSQL := strSQL + '        NFM_ANOCOR,    '; pAddNomeColuna('Ano Cor');
        strSQL := strSQL + '        NFM_MONTAD,    '; pAddNomeColuna('Montadora');
        strSQL := strSQL + '        NFM_REFERE,    '; pAddNomeColuna('Referência');
        strSQL := strSQL + '        NFM_CLIENT,    '; pAddNomeColuna('Cliente');
        strSQL := strSQL + '        NFM_LINHA_,    '; pAddNomeColuna('Linha');
        strSQL := strSQL + '        NFM_PADREF,    '; pAddNomeColuna('Tipo da Fórmula');
        strSQL := strSQL + '        NFM_ORIGEM,    '; pAddNomeColuna('Origem');
        strSQL := strSQL + '        NFM_DTACAD,    '; pAddNomeColuna('Data Cadastro');
        strSQL := strSQL + '        NFM_CODEMP,    '; pAddNomeColuna('Código Empresa');
        strSQL := strSQL + '        AUTOINCREM     ';
        strSQL := strSQL + '   FROM BLA_CADNFM     ';
        strSQLWhere := '';
        strSQLGroup :=  '';

        If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere, strSQLGroup], arrTitCol, ['NFM_CODIGO'], 'AUTOINCREM',
         'BLA_CADNFM', 'untDbeOrigemKeyPressBlascorAutomotiva', 'Consulta de Origems - Blascor Automotiva', qryCadPro, [], []) Then
        Begin
          tela['dbeOrigem']['Text'].Value := qryCadPro.FieldByName('NFM_CODIGO').AsString;
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
procedure TDbeOrigemKeyPressBlascorAutomotiva.pAddNomeColuna(strNomCol: String);
begin
  SetLength(arrTitCol, Succ(Length(arrTitCol)));
  arrTitCol[High(arrTitCol)] := strNomCol;
end;

end.

