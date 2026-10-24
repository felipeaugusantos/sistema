unit untDbeSubGrupoKeyPressSkyMixAutomotiva;

interface

uses untAutcomTintaFactory, Classes, untIAutcomTintaWrapper, SysUtils, untIDataSet, untAbstractLibTintaControleVisualEvento,
  untILibTintaControleVisual, untAbstractCadastro, StrUtils;

type
  TDbeSubGrupoKeyPressSkyMixAutomotiva = class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

{ TDbeCodColKeyPress }

procedure TDbeSubGrupoKeyPressSkyMixAutomotiva.OnKeyPress(Sender: TObject; var Key: Char);
var
  qrySubGrupo: IDataSet;
  strSQL,
  strSQLWhere,
  strSQLGroup:String;

  strSQLOrder:String;

  arrTitSub:Array Of String;

  procedure pAddNomeColuna(strColuna:String);
  Begin
    SetLength(arrTitSub, Succ(Length(arrTitSub)));
    arrTitSub[High(arrTitSub)] := strColuna;
  End;

begin
  Try
    Try
      qrySubGrupo := TAutcomTintaFactory.Get.fGetDataSet;

      If TAutcomTintaFactory.Get.fEntraCons(Key) Then
      Begin
        Key := #0;
        strSQL := strSQL + '    SELECT          ';
        strSQL := strSQL + '      SGR_CODSGR,   '; pAddNomeColuna('Código');
        strSQL := strSQL + '      SGR_ASPECT,   '; pAddNomeColuna('Aspecto');
        strSQL := strSQL + '      AUTOINCREM    ';
        strSQL := strSQL + '    FROM            ';
        strSQL := strSQL + '      SKY_CADSGR    ';

        strSQLWhere := '  ';
        strSQLGroup := '  ';

        strSQLOrder := 'GRU_CODGRU';

        If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere, strSQLGroup], arrTitSub, [strSQLOrder], 'AUTOINCREM',
          'SKY_CADSGR', 'untDbeSubGrupoKeyPressSkyMixAutomotiva', 'Consulta de Sub Grupos - SkyMix Automotiva', qrySubGrupo, [], []) Then
        Begin
          GetFieldByControle('dbeSubGrupo').AsString := qrySubGrupo.FieldByName('SGR_CODSGR').AsString;
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
