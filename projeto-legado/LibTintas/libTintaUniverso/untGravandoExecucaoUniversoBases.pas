{*************************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta Universo Imobiliaria *}
{**********************************************************************************PH*}
unit untGravandoExecucaoUniversoBases;

interface

uses
  untAbstractGravandoExecucaoUniverso, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, dialogs,Classes,StrUtils,
  System.Variants;

type
  TGravandoExecucaoUniversoBases = class(TAbstractGravandoExecucaoUniverso)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
end;

implementation

uses untStrUtils, untExcelOfc, untFuncoesGenerica;

{ TGravandoExecucaoUniversoBases }

procedure TGravandoExecucaoUniversoBases.Executar(const gravando: IGravando);
Const
arrUni: Array [0..3] Of String = ('TT', 'QT', 'GL', 'LA');
Var
  qryCadBas     : IDataSet;
  olePlanilha, OleSheet : OleVariant;
  intMaxLines, intProgresso, intSheet   : Integer;
  intRow, intQtdFolhas, intUni: Integer;
begin
  Try
    Try

      If Not FileExists(GetPath) Then
          Begin
            gravando.Texto := Format('O arquivo %s não existe', [AnsiReplaceStr(GetPath, '"', '')]);
            gravando.Cancelar;
          End;

      If (gravando.Status <> sgGravando) Then
        Exit;

      gravando.Texto := 'Abrindo o arquivo de fórmulas';

      OlePlanilha := CreateOleObject('Excel.Application');
      OlePlanilha.Visible := False;
      OlePlanilha.WorkBooks.Open(GetPath);


      gravando.texto := 'Abrindo o cadastro de Bases';

      If (gravando.Status <> sgGravando) Then
        Exit;

      qryCadBas := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadBas.SQL :=  ' SELECT * FROM UNI_CADBAS';
      qryCadBas.Open;

      intQtdFolhas := OlePlanilha.WorkSheets.Count;

      For intSheet := 1 To intQtdFolhas Do
      Begin
        oleSheet := OlePlanilha.WorkSheets[intSheet];

        gravando.Texto := Format('Processando Arquivos [%s]', [AnsiReplaceStr(AnsiUpperCase(oleSheet.Name), '"', '')]);

        If (gravando.Status <> sgGravando) Then
          Exit;

       intMaxLines := fRetQuantidadeRegSheet(oleSheet);

       intProgresso := 0;

       gravando.RegistrarProgresso(0, 0, 0);

        For intRow := 3 To intMaxLines Do
        Begin
          For intUni := 0 To 3 Do
          Begin
            If Not qryCadBas.Locate('BAS_CODBAS;BAS_PRODUT;BAS_UNIDAD',VarArrayOf([Trim(AnsiUpperCase(oleSheet.Range['B'+ IntToStr(intRow)].Text)), UpperCase(OleSheet.Name), arrUni[intUni]]), []) Then
            Begin
                If (gravando.Status <> sgGravando) Then
                    Break;

              qryCadBas.Insert;
              qryCadBas.FieldByName('AUTOINCREM').AsString :=  TAutcomTintaFactory.Get.fRetAutoIncrem('UNI_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
              qryCadBas.FieldByName('BAS_CODBAS').AsString := Trim(AnsiUpperCase(oleSheet.Range['B'+ IntToStr(intRow)].Text));
              qryCadBas.FieldByName('BAS_PRODUT').AsString := AnsiUpperCase(oleSheet.Name);
              qryCadBas.FieldByName('BAS_UNIDAD').AsString := arrUni[intUni];
              qryCadBas.Post;
            End;

            qryCadBas.Next;
          End;
        End;


        Inc(IntProgresso);
        Gravando.RegistrarProgresso(0, intProgresso, intMaxLines);
        gravando.Texto := 'Cadastro de bases gerado com sucesso!'
      End;

    Except
      On E: Exception Do
      Begin
       gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;
    End;

  Finally
    OlePlanilha.Quit;
  End;

end;

function TGravandoExecucaoUniversoBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

end.
