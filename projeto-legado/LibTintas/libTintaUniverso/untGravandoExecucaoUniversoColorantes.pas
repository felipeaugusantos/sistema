{******************************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta Universo Imobiliaria *}
{***************************************************************************************PH*}
unit untGravandoExecucaoUniversoColorantes;

interface

uses
  untAbstractGravandoExecucaoUniverso, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, dialogs,Classes,StrUtils;

type
  TGravandoExecucaoUniversoColorantes = class(TAbstractGravandoExecucaoUniverso)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses untStrUtils, untExcelOfc, untFuncoesGenerica;

{ TGravandoExecucaoUniversoCores }

procedure TGravandoExecucaoUniversoColorantes.Executar(const gravando: IGravando);
var
  qryCadCol : IDataSet;
  intSheet, intMaxLines, intProgresso : Integer;
  intQtdFolhas, intRow, intCol: Integer;
  stlColorantes : TStringList;
  strCodCol : String;
  OlePlanilha, OleSheet : OleVariant;
Begin
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


      OlePlanilha :=  CreateOleObject('Excel.Application');
      OlePlanilha.Visible := False;
      OlePlanilha.WorkBooks.Open(GetPath);


      gravando.texto := 'Abrindo o cadastro de colorantes...';

      qryCadCol := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadCol.SQL := ' SELECT * FROM UNI_CADCOL ';
      qryCadCol.Open;

      intQtdFolhas := OlePlanilha.WorkSheets.Count;

      //Colunas Excel;
      stlColorantes := TStringList.Create;
      stlColorantes.CommaText := 'C,F,I,L,O';

      For intSheet := 1 To intQtdFolhas Do
      Begin
        oleSheet := olePlanilha.WorkSheets[intSheet];

        gravando.Texto := Format('Processando Arquivos [%s]', [AnsiReplaceStr(AnsiUpperCase(oleSheet.Name), '"', '')]);

        If (gravando.Status <> sgGravando) Then
          Exit;

        intMaxLines := fRetQuantidadeRegSheet(oleSheet);

        intProgresso := 0;

        gravando.RegistrarProgresso(0, 0, 0);

        For intRow := 3 To intMaxLines Do
        Begin
          For intCol := 0 To stlColorantes.Count - 1 Do
          Begin
            strCodCol := oleSheet.Range[stlColorantes[intCol] + IntToStr(intRow)].Text;
            If Not (qryCadCol.Locate('COL_CODCOL', strCodCol, [])) And (Not TStrUtils.fEmptyStr(strCodCol)) Then
            Begin
               If (gravando.Status <> sgGravando) Then
                    Break;

              qryCadCol.Insert;
              qryCadCol.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('UNI_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
              qryCadCol.FieldByName('COL_CODCOL').AsString := strCodCol;
              qryCadCol.FieldByName('COL_DESCRI').AsString := strCodCol;
              qryCadCol.FieldByName('COL_EMBALA').AsFloat  := 1000;
              qryCadCol.Post;
            End;
          End;

          Inc(intProgresso);
          Gravando.RegistrarProgresso(0, IntProgresso, intMaxLines);
        End;
      End;

    Except
      On E: Exception Do
      Begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;

    End;
  Finally
    olePlanilha.Quit;
  End;
end;


function TGravandoExecucaoUniversoColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;

end.
