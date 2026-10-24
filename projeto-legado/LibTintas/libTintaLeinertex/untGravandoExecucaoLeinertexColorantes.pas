{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta Leinertex *}
{***************************************************************************PH*}
unit untGravandoExecucaoLeinertexColorantes;

interface

uses
  untAbstractGravandoExecucaoLeinertex, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils, ComObj, Math;
type
  TGravandoExecucaoLeinertexColorantes = class(TAbstractGravandoExecucaoLeinertex)
  Private
    function IsRegistroExistente(Excel: Variant; qryDestino: IDataSet; RecNo: Integer): Boolean;
    procedure GravarRegistro(Excel: Variant; qryDestino: IDataSet; RecNo: Integer);
    procedure LimparTabelas;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses untStrUtils, untDefinicaoTxtCampoTipo, untADOTxtFactory, untGenericDefinicaoTxtCampo, untGenericDefinicaoTxt,
    untIDefinicaoTxtCampo, untIDefinicaoTxt, untDefinicaoTxtCharacterSet;


{ TGravandoExecucaoLeinertexCores }


procedure TGravandoExecucaoLeinertexColorantes.Executar(const gravando: IGravando);
var
  qryDestino: IDataSet;
  Excel: Variant;
  ExcelColorantes: Variant;
  RecordCount: Integer;
  RecNo: Integer;
begin
  Try
    Gravando.Texto := 'Verificando path dos arquivos...';

    If Not FileExists(AnsiReplaceStr(fGetNomeArquivo, '"', '')) Then
    Begin
      Gravando.Texto := Format('O arquivo [%s] não existe! Verificar configurações.', [AnsiReplaceStr(fGetNomeArquivo, '"', '')]);
      Gravando.Cancelar;
    End;

    If Gravando.Status <> sgGravando Then
      Exit;

    Gravando.Texto := 'Path verificado...';

    Gravando.Texto := 'Verificando PROCOD...';
    TAutcomTintaFactory.Get.fInsereProCod('LEI_CADCOL');
    Gravando.Texto := 'PROCOD verificado com sucesso!';

    Gravando.Texto := 'Limpando registros da tabela LEI_CADCOL...';
    LimparTabelas;
    Gravando.Texto := 'Registros limpos...';

    Gravando.Texto := 'Abrindo cadastro de Colorantes...';
    qryDestino := TAutcomTintaFactory.Get.fGetDataSet;
    qryDestino.Close;
    qryDestino.SQL := ' SELECT * FROM LEI_CADCOL    ';
    qryDestino.Open;

    ExcelColorantes := CreateOleObject('Excel.Application');
    ExcelColorantes.Visible := False;
    ExcelColorantes.WorkBooks.Open(fGetNomeArquivo);
    Excel := ExcelColorantes.WorkBooks[1].WorkSheets[1];
    RecordCount := Excel.Cells.SpecialCells(11).Row;

    Gravando.Texto := Format('Processando arquivo: [%s] - COLORANTES', [AnsiReplaceStr(fGetNomeArquivo, '"', '')]);
    Gravando.RegistrarProgresso(0, 0, 0);

    Try
      For RecNo := 2 To RecordCount Do
      Begin
        If (Gravando.Status <> sgGravando) Then
          Exit;

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
    If Not VarIsEmpty(ExcelColorantes) Then
    Begin
      ExcelColorantes.Quit;
      ExcelColorantes := Unassigned;
      Excel := Unassigned;
    End;
  End;
end;

function TGravandoExecucaoLeinertexColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;

procedure TGravandoExecucaoLeinertexColorantes.GravarRegistro(Excel: Variant;
  qryDestino: IDataSet; RecNo: Integer);
Var
  intContador,
  intColorante: Integer;
begin
  intColorante := 7;

  For intContador := 1 To 4 Do
  Begin
    If Not qryDestino.Locate('COL_CODCOL', VarArrayOf([Excel.Cells[RecNo, intColorante].Text]), []) Then
    Begin
      If TStrUtils.fEmptyStr(Excel.Cells[RecNo, intColorante].Text) Then
      Begin
        Inc(intColorante, 2);
        Continue;
      End;

      If Excel.Cells[RecNo, intColorante].Text = '0' Then
      Begin
        Inc(intColorante, 2);
        Continue;
      End;

      qryDestino.Insert;
      qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('LEI_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
      qryDestino.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
      qryDestino.FieldByName('COL_CODCOL').AsString := Excel.Cells[RecNo, intColorante].Text;
      qryDestino.FieldByName('COL_DESCRI').AsString := Excel.Cells[RecNo, intColorante].Text;
      qryDestino.FieldByName('COL_EMBALA').AsFloat  := 1000;
      qryDestino.Post; 
    End;
    Inc(intColorante, 2);
  End;
end;

function TGravandoExecucaoLeinertexColorantes.IsRegistroExistente(
  Excel: Variant; qryDestino: IDataSet; RecNo: Integer): Boolean;
begin
  Result := False;
end;

procedure TGravandoExecucaoLeinertexColorantes.LimparTabelas;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' DELETE FROM LEI_CADCOL  ';
  qryGen.ExecSQL;
end;


end.

