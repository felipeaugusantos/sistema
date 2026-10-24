{**********************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta Leinertex *}
{*******************************************************************************AC*}
unit untGravandoExecucaoLeinertexBases;

interface

uses
  untAbstractGravandoExecucaoLeinertex, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils, ComObj, Math;
type
  TGravandoExecucaoLeinertexBases = class(TAbstractGravandoExecucaoLeinertex)
  Private
    function fRetUnidade(fltEmbalagem: Double): String;
    function IsRegistroExistente(Excel: Variant; qryDestino: IDataSet; RecNo: Integer): Boolean;
    procedure GravarRegistro(Excel: Variant; qryDestino: IDataSet; RecNo: Integer);
    procedure LimparTabelas;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses untStrUtils, untIDefinicaoTxt, untGenericDefinicaoTxt, untDefinicaoTxtCharacterSet,
  untIDefinicaoTxtCampo, untGenericDefinicaoTxtCampo, untDefinicaoTxtCampoTipo, untADOTxtFactory;

{ TGravandoExecucaoLeinertexBases }

procedure TGravandoExecucaoLeinertexBases.Executar(const gravando: IGravando);
var
  qryDestino: IDataSet;
  Excel: Variant;
  ExcelBase: Variant;
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
    TAutcomTintaFactory.Get.fInsereProCod('LEI_CADBAS');
    Gravando.Texto := 'PROCOD verificado com sucesso!';

    Gravando.Texto := 'Limpando registros da tabela LEI_CADBAS...';
    LimparTabelas;
    Gravando.Texto := 'Registros limpos...';

    Gravando.Texto := 'Abrindo cadastro de bases...';
    qryDestino := TAutcomTintaFactory.Get.fGetDataSet;
    qryDestino.Close;
    qryDestino.SQL := ' SELECT * FROM LEI_CADBAS    ';
    qryDestino.Open;

    ExcelBase := CreateOleObject('Excel.Application');
    ExcelBase.Visible := False;
    ExcelBase.WorkBooks.Open(fGetNomeArquivo);
    Excel := ExcelBase.WorkBooks[1].WorkSheets[1];
    RecordCount := Excel.Cells.SpecialCells(11).Row;

    Gravando.Texto := Format('Processando arquivo: [%s] - BASES', [AnsiReplaceStr(fGetNomeArquivo, '"', '')]);
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
    If Not VarIsEmpty(ExcelBase) Then
    Begin
      ExcelBase.Quit;
      ExcelBase := Unassigned;
      Excel := Unassigned;
    End;
  End;
end;

function TGravandoExecucaoLeinertexBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TGravandoExecucaoLeinertexBases.fRetUnidade(
  fltEmbalagem: Double): String;
begin
  If fltEmbalagem < 1.500 Then
    Result := 'QT'
  Else If fltEmbalagem < 8.000 Then
    Result := 'GL'
  Else
    Result := 'LA';
end;

procedure TGravandoExecucaoLeinertexBases.GravarRegistro(Excel: Variant;
  qryDestino: IDataSet; RecNo: Integer);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('LEI_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('BAS_PRODUT').AsString := Excel.Cells[RecNo, 1].Text;
  qryDestino.FieldByName('BAS_CODBAS').AsString := Excel.Cells[RecNo, 5].Text;
  qryDestino.FieldByName('BAS_UNIDAD').AsString := fRetUnidade(StrToFloat(Excel.Cells[RecNo, 6].Text));
  qryDestino.FieldByName('BAS_EMBALA').AsFloat  := StrToFloat(Excel.Cells[RecNo, 6].Text) * 1000;
  qryDestino.Post;
end;

function TGravandoExecucaoLeinertexBases.IsRegistroExistente(Excel: Variant;
  qryDestino: IDataSet; RecNo: Integer): Boolean;
begin
  Result := qryDestino.Locate('BAS_CODBAS;BAS_PRODUT;BAS_UNIDAD', VarArrayOf([Excel.Cells[RecNo, 5].Text, Excel.Cells[RecNo, 1].Text,
    fRetUnidade(StrToFloat(Excel.Cells[RecNo, 6].Text))]), []);
end;

procedure TGravandoExecucaoLeinertexBases.LimparTabelas;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' DELETE FROM LEI_CADBAS    ';
  qryGen.ExecSQL;
end;

end.
