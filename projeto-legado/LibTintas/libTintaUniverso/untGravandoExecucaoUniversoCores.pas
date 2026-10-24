{*************************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta Universo Imobiliaria *}
{**********************************************************************************PH*}
unit untGravandoExecucaoUniversoCores;

interface

uses
  untAbstractGravandoExecucaoUniverso, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, dialogs,Classes,StrUtils;

type
  TGravandoExecucaoUniversoCores = class(TAbstractGravandoExecucaoUniverso)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function fOncasParaMl(Oncas: String): Double;
    procedure pLimparRegistrosQtdZeradas;
  end;

implementation

uses
  untStrUtils, untExcelOfc, untFuncoesGenerica;

{ TGravandoExecucaoUniversoCores }





procedure TGravandoExecucaoUniversoCores.Executar(const gravando: IGravando);
Const
  arrUni: Array[0..3] Of String = ('TT', 'QT', 'GL', 'LA');
  arrMed: Array[0..3] Of Double = (0.0625, 0.25, 1, 5);
var
  stlColorantes, stlParteInt, stlPartFrac :TStringList;
  qryCadCor : IDataSet;
  OlePlanilha, oleSheet : OleVariant;
  intSheet, intRow, intQtdFolhas: Integer;
  intCol, intUni,
  intMaxLines, intProgresso: Integer;
begin
  Try
    Try
      If Not FileExists(GetPath) Then
      Begin
        gravando.texto := Format('O arquivo %s não existe', [AnsiReplaceStr(GetPath, '"', '')]);
        gravando.Cancelar;
      End;

      If (gravando.Status <> sgGravando) Then
          Exit;

      gravando.Texto := 'Limpando cadastro de cores...';

      //Limpar Cadastro de Cores
      qryCadCor := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadCor.SQL := ' DELETE FROM UNI_CADUNI ';
      qryCadCor.ExecSQL;

      gravando.Texto := 'Abrindo o arquivo de fórmulas...';

      OlePlanilha := CreateOleObject('Excel.Application');
      OlePlanilha.Visible := False;
      OlePlanilha.WorkBooks.Open(GetPath);


      gravando.texto := 'Abrindo o cadastro de Cores...';


      qryCadCor.SQL.Empty;
      qryCadCor.SQL := 'SELECT * FROM UNI_CADUNI';
      qryCadCor.Open;

      intQtdFolhas := olePlanilha.Worksheets.Count;


      stlColorantes := TStringList.Create;
      stlParteInt   := TStringList.Create;
      stlPartFrac   := TStringList.Create;

     //Colunas Excel;;
      stlColorantes.CommaText := 'C, F, I, L, O';
        stlParteInt.CommaText := 'D, G, J, M, P';
        stlPartFrac.CommaText := 'E, H, K, N, Q';

      For intSheet := 1 To intQtdFolhas Do
      Begin
        oleSheet := olePlanilha.Worksheets[intSheet];

        gravando.Texto := Format('Processando arquivo [%s]', [AnsiReplaceStr(AnsiUpperCase(oleSheet.Name), '"', '')]);

        If (gravando.Status <> sgGravando) Then
          Exit;

        IntMaxLines := fRetQuantidadeRegSheet(oleSheet);

        intProgresso := 0;

        Gravando.RegistrarProgresso(0, 0, 0);

        For IntRow := 3 To intMaxLines Do
        Begin
          For intUni := 0 To 3 Do
          Begin
            Try
              If (gravando.Status <> sgGravando) Then
                Break;

              
              qryCadCor.Insert;
              qryCadCor.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('UNI_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
              qryCadCor.FieldByName('UNI_CODTIN').AsString := AnsiUpperCase(oleSheet.Range['A' + IntToStr(intRow)].Text);
              qryCadCor.FieldByName('UNI_DESCOR').AsString := AnsiUpperCase(oleSheet.Range['A' + IntToStr(intRow)].Text);
              qryCadCor.FieldByName('UNI_PRODUT').AsString := AnsiUpperCase(oleSheet.Name);
              qryCadCor.FieldByName('UNI_CODBAS').AsString := AnsiUpperCase(oleSheet.Range['B' + IntToStr(intRow)].Text);
              qryCadCor.FieldByName('UNI_GRUPO_').AsString := 'UNICOLORS';
              qryCadCor.FieldByName('UNI_CODUNI').AsString := arrUni[intUni];

              For intCol := 0 To stlColorantes.Count - 1 Do
              Begin
                qryCadCor.FieldByName('UNI_CODC' + TStrUtils.fStrZero(intCol + 1, 2)).AsString := oleSheet.Range[stlColorantes[intCol] +IntToStr(intRow)].Text;
                qryCadCor.FieldByName('UNI_QTDC' + TStrUtils.fStrZero(intCol + 1, 2)).AsFloat :=
                  fOncasParaMl(oleSheet.Range[stlParteInt[intCol] + IntToStr(IntRow)].Text + 'Y' + oleSheet.Range[stlPartFrac[intCol] + IntToStr(IntRow)].Text ) * arrMed[intUni];
              End;

              qryCadCor.FieldByName('UNI_MD5KEY').AsString := GetMD5(qryCadCor.FieldByName('UNI_DESCOR').AsString + qryCadCor.FieldByName('UNI_CODBAS').AsString +
                                                                     qryCadCor.FieldByName('UNI_PRODUT').AsString + qryCadCor.FieldByName('UNI_CODUNI').AsString +
                                                                     qryCadCor.FieldByName('UNI_GRUPO_').AsString);


              qryCadCor.Post;

              qryCadCor.Next;   
            Except
              On E: Exception Do
                gravando.Texto := 'Erro ao gerar o cadastro de cores : ' + e.Message;
            End;
          End;

          Gravando.RegistrarProgresso(0, intProgresso, IntMaxLines);

        End;
      End;

      Gravando.Texto := 'Cadastro de Cores gerado com sucesso!';
    Except
      On E: Exception Do
      Begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;

    End;
  Finally
    olePlanilha.Quit;
    pLimparRegistrosQtdZeradas;
  End;




end;


function TGravandoExecucaoUniversoCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;




function TGravandoExecucaoUniversoCores.fOncasParaMl(Oncas: String): Double;
var
  strInteira, strFracao, strOncas : String;
begin
  strOncas := AnsiReplaceStr(Oncas,'.', ',');
  strInteira := Copy(strOncas, 0, Pos('Y', strOncas) - 1);
  strFracao := Copy(strOncas, Pos('Y',stroncas) + 1, Length(strOncas));
  Result := TAutcomTintaFactory.Get.fStrToFloat(FormatFloat('0.000000', TAutcomTintaFactory.Get.fStrToFloat(strInteira) * 29.5735295625 + 
            TAutcomTintaFactory.Get.fStrToFloat(strFracao) * 0.61611520 ));
end;

procedure TGravandoExecucaoUniversoCores.pLimparRegistrosQtdZeradas;
Var
  qryAux : IDataSet;
begin

  qryAux := TAutcomTintaFactory.Get.fGetDataSet;
  qryAux.SQL := 'DELETE FROM UNI_CADUNI ' +
                ' WHERE  UNI_QTDC01 = 0 ';
  qryAux.ExecSQL;              
  
end;

end.
