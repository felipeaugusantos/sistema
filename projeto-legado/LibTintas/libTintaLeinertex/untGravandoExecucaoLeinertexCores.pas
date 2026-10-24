{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta Leinertex *}
{**********************************************************************PH*}
unit untGravandoExecucaoLeinertexCores;

interface

uses
  untAbstractGravandoExecucaoLeinertex, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils,
  System.Win.ComObj;

type
  TGravandoExecucaoLeinertexCores = class(TAbstractGravandoExecucaoLeinertex)
  Private
    function fRetUnidade(fltEmbalagem: Double): String;
    function IsRegistroExistente(Excel: Variant; qryDestino: IDataSet; RecNo: Integer): Boolean;
    procedure GravarRegistro(Excel: Variant; qryDestino: IDataSet; RecNo: Integer);
    procedure LimparTabelas;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

Implementation

uses
  untFuncoesGenerica, untStrUtils, untDefinicaoTxtCampoTipo, untADOTxtFactory, untGenericDefinicaoTxtCampo, untGenericDefinicaoTxt,
    untIDefinicaoTxtCampo, untIDefinicaoTxt, untDefinicaoTxtCharacterSet;


{ TGravandoExecucaoLeinertexCores }

procedure TGravandoExecucaoLeinertexCores.Executar(const gravando: IGravando);
var
  qryDestino: IDataSet;
  Excel: Variant;
  ExcelCores: Variant;
  RecordCount: Integer;
  RecNo: Integer;
begin
  Try
    Gravando.Texto := 'Verificando path dos arquivos...';

    If Not FileExists(AnsiReplaceStr(fGetNomeArquivo, '"', '')) Then
    Begin
      Gravando.Texto := Format('O arquivo [%s] não existe! Verificar configurações.', [AnsiReplaceStr(fGetNomeGravacao, '"', '')]);
      Gravando.Cancelar;
    End;

    If Gravando.Status <> sgGravando Then
      Exit;

    Gravando.Texto := 'Path verificado...';

    Gravando.Texto := 'Verificando PROCOD...';
    TAutcomTintaFactory.Get.fInsereProCod('LEI_CADLEI');
    Gravando.Texto := 'PROCOD verificado com sucesso!';

    Gravando.Texto := 'Limpando registros da tabela LEI_CADLEI...';
    LimparTabelas;
    Gravando.Texto := 'Registros limpos...';

    Gravando.Texto := 'Abrindo cadastro de cores...';
    qryDestino := TAutcomTintaFactory.Get.fGetDataSet;
    qryDestino.Close;
    qryDestino.SQL := ' SELECT * FROM LEI_CADLEI    ';
    qryDestino.Open;

    ExcelCores := CreateOleObject('Excel.Application');
    ExcelCores.Visible := False;
    ExcelCores.WorkBooks.Open(fGetNomeArquivo);
    Excel := ExcelCores.WorkBooks[1].WorkSheets[1];
    RecordCount := Excel.Cells.SpecialCells(11).Row;

    Gravando.Texto := Format('Processando arquivo: [%s] - CORES', [AnsiReplaceStr(fGetNomeArquivo, '"', '')]);
    Gravando.RegistrarProgresso(0, 0, 0);

    Try
      For RecNo := 2 To RecordCount Do
      Begin
        If (Gravando.Status <> sgGravando) Then
            Break;

        If Not IsRegistroExistente(Excel, qryDestino, RecNo) Then
            GravarRegistro(Excel, qryDestino, RecNo);

        Gravando.RegistrarProgresso(0, RecNo, RecordCount);
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Cancelar;
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;
    End;
  Finally
    If Not VarIsEmpty(ExcelCores) Then
    Begin
      ExcelCores.Quit;
      ExcelCores := Unassigned;
      Excel := Unassigned;
    End;
  End;
end;

function TGravandoExecucaoLeinertexCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoLeinertexCores.fRetUnidade(
  fltEmbalagem: Double): String;
begin
  If fltEmbalagem < 1.500 Then
    Result := 'QT'
  Else If fltEmbalagem < 8.000 Then
    Result := 'GL'
  Else
    Result := 'LA';
end;

procedure TGravandoExecucaoLeinertexCores.GravarRegistro(Excel: Variant;
  qryDestino: IDataSet; RecNo: Integer);
Var
  intContador: Integer;
  intColorante: Integer;
  intQuantidade: Integer;
  strCodigo: String;
  strNomCor: String;
  strMd5: String;
  strQuantidade: String;
begin
  strCodigo := Copy(Excel.Cells[RecNo, 4].Text, 0, Pos('-', Excel.Cells[RecNo, 4].Text) - 1);
  strNomCor := Copy(Excel.Cells[RecNo, 4].Text, Pos('-', Excel.Cells[RecNo, 4].Text) + 1, Length(Excel.Cells[RecNo, 4].Text));

  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('LEI_CADLEI', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('LEI_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('LEI_CODIGO').AsString := strCodigo;
  qryDestino.FieldByName('LEI_CODBAS').AsString := Excel.Cells[RecNo, 5].Text;
  qryDestino.FieldByName('LEI_NOMCOR').AsString := strNomCor;
  qryDestino.FieldByName('LEI_PRODUT').AsString := Excel.Cells[RecNo, 1].Text;
  qryDestino.FieldByName('LEI_UNIDAD').AsString := fRetUnidade(StrToFloat(Excel.Cells[RecNo, 6].Text));
  qryDestino.FieldByName('LEI_COLECA').AsString := Excel.Cells[RecNo, 2].Text;
  qryDestino.FieldByName('LEI_DESCRI').AsString := Excel.Cells[RecNo, 2].Text;
  qryDestino.FieldByName('LEI_ATIVAD').AsString := 'S';

  strMd5 := qryDestino.FieldByName('LEI_CODIGO').AsString +
            qryDestino.FieldByName('LEI_NOMCOR').AsString +
            qryDestino.FieldByName('LEI_CODBAS').AsString +
            qryDestino.FieldByName('LEI_PRODUT').AsString +
            qryDestino.FieldByName('LEI_UNIDAD').AsString +
            qryDestino.FieldByName('LEI_COLECA').AsString;

  intColorante := 7;
  intQuantidade := 8;

  For intContador := 1 To 4 Do
  Begin
    If TStrUtils.fEmptyStr(Excel.Cells[RecNo, intColorante].Text) Then
      Break;

    If Excel.Cells[RecNo, intColorante].Text = '0' Then
      Break;

    strQuantidade := AnsiReplaceStr(Excel.Cells[RecNo, intQuantidade].Text, '.', '');

    qryDestino.FieldByName('LEI_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString := Excel.Cells[RecNo, intColorante].Text;
    qryDestino.FieldByName('LEI_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat  := StrToFloat(strQuantidade);

    strMd5 := strMd5 + qryDestino.FieldByName('LEI_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString;
    strMd5 := strMd5 + qryDestino.FieldByName('LEI_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsString;

    Inc(intColorante, 2);
    Inc(intQuantidade, 2);
  End;

  qryDestino.FieldByName('LEI_MD5KEY').AsString := GetMD5(strMd5);
  qryDestino.Post;
end;


function TGravandoExecucaoLeinertexCores.IsRegistroExistente(Excel: Variant;
  qryDestino: IDataSet; RecNo: Integer): Boolean;
begin
  Result := False;
end;

procedure TGravandoExecucaoLeinertexCores.LimparTabelas;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' DELETE FROM LEI_CADLEI    ';
  qryGen.ExecSQL;
end;

end.

