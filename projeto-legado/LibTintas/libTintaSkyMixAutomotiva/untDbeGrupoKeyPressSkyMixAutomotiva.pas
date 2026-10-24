unit untDbeGrupoKeyPressSkyMixAutomotiva;

interface

uses untAutcomTintaFactory, Classes, untIAutcomTintaWrapper, SysUtils, untIDataSet, untAbstractLibTintaControleVisualEvento,
  untILibTintaControleVisual, untAbstractCadastro, StrUtils;

type
  TDbeGrupoKeyPressSkyMixAutomotiva = class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

{ TDbeCodColKeyPress }

procedure TDbeGrupoKeyPressSkyMixAutomotiva.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryCadGru: IDataSet;
  strSQL,
  strSQLWhere,
  strSQLGroup:String;

  strSQLOrder:String;

  arrTitGru: Array Of String;

  procedure pAddNomeColuna(strColuna:String);
  Begin
    SetLength(arrTitGru, Succ(Length(arrTitGru)));
    arrTitGru[High(arrTitGru)] := strColuna;
  End;

begin
  Try
    Try
      qryCadGru := TAutcomTintaFactory.Get.fGetDataSet;

      If TAutcomTintaFactory.Get.fEntraCons(Key) Then
      Begin
        Key := #0;
        strSQL := strSQL + '    SELECT GRU_CODGRU,  '; pAddNomeColuna('Código');
        strSQL := strSQL + '           GRU_VALIDA,  '; pAddNomeColuna('Validade');
        strSQL := strSQL + '           GRU_LINHA_,  '; pAddNomeColuna('Linha');
        strSQL := strSQL + '           GRU_MARCA_,  '; pAddNomeColuna('Marca');
        strSQL := strSQL + '           AUTOINCREM   ';
        strSQL := strSQL + '    FROM                ';
        strSQL := strSQL + '      SKY_CADGRU        ';

        strSQLWhere := '  ';
        strSQLGroup := '  ';
        strSQLOrder := 'GRU_CODGRU';

        If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere, strSQLGroup], arrTitGru, [strSQLOrder], 'AUTOINCREM',
          'SKY_CADGRU', 'untDbeGrupoKeyPressSkyMixAutomotiva', 'Consulta de Grupos - SkyMix Automotiva', qryCadGru, [], []) Then
        Begin

          GetFieldByControle('dbeGrupo').AsString := qryCadGru.FieldByName('GRU_CODGRU').AsString;
          tela.SelectNext;
        End;
      End;
    Except
      On E: Exception Do
      Begin
        Raise;
      End;
    End;
  Finally
  End;
end;

end.
