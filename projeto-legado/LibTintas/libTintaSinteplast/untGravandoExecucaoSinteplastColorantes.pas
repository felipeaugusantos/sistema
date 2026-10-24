{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta Sinteplast *}
{***************************************************************************PH*}
unit untGravandoExecucaoSinteplastColorantes;

interface

uses
  untAbstractGravandoExecucaoSinteplast, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils, ComObj, Math;
type
  TGravandoExecucaoSinteplastColorantes = class(TAbstractGravandoExecucaoSinteplast)
  Private
    function fDescricaoColorante(strColorante: String): String;
    procedure GravarRegistro(Excel: Variant; qryDestino: IDataSet; RecNo: Integer);
    procedure LimparTabelas;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function GetSqlDestino(): string; override;
    function GetSqlOrigem(const strNomeArquivo: string;
      const stlTabelas: TStrings): string; override;
  end;

implementation

uses untStrUtils, untDefinicaoTxtCampoTipo, untADOTxtFactory, untGenericDefinicaoTxtCampo, untGenericDefinicaoTxt,
    untIDefinicaoTxtCampo, untIDefinicaoTxt, untDefinicaoTxtCharacterSet;


{ TGravandoExecucaoSinteplastCores }


procedure TGravandoExecucaoSinteplastColorantes.Executar(const gravando: IGravando);
var
  qryDestino: IDataSet;
  Excel: Variant;
  ExcelBase: Variant;
  RecordCount: Integer;
  RecNo: Integer;
begin
  Try
    Try
      Gravando.Texto := 'Verificando path dos arquivos...';

      If Not FileExists(AnsiReplaceStr(fGetNomeArquivo, '"', '')) Then
      Begin
        Gravando.Texto := Format('O arquivo [%s] não existe, ou não foi encontrado!', [AnsiReplaceStr(fGetNomeArquivo, '"', '')]);
        Gravando.Cancelar;
      End;

      If Gravando.Status <> sgGravando Then
        Exit;

      Gravando.Texto := 'Path validado com sucesso...';

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('SIN_CADCOL');
      Gravando.Texto := 'PROCOD verificado com sucesso!';

      Gravando.Texto := 'Deletando registros da tabela SIN_CADCOL...';
      LimparTabelas;
      Gravando.Texto := 'Registros deletados com sucesso...';

      Gravando.Texto := 'Abrindo Cadastro de Colorantes...';

      qryDestino := TAutcomTintaFactory.Get.fGetDataSet;
      qryDestino.Close;
      qryDestino.SQL := '    SELECT * FROM SIN_CADCOL      ';
      qryDestino.Open;

      ExcelBase := CreateOleObject('Excel.Application');
      ExcelBase.Visible := False;
      ExcelBase.WorkBooks.Open(fGetNomeArquivo);
      Excel := ExcelBase.WorkBooks[1].WorkSheets[1];
      RecordCount := Excel.Cells.SpecialCells(11).Row;

      Gravando.Texto := Format('Processando arquivo: [%s] - COLORANTES', [AnsiReplaceStr(fGetNomeArquivo, '"', '')]);
      Gravando.RegistrarProgresso(0, 0, 0);

      For RecNo := 2 To RecordCount Do
      Begin
        If (Gravando.Status <> sgGravando) Then
          Break;

        GravarRegistro(Excel, qryDestino, RecNo);
        Gravando.RegistrarProgresso(0, RecNo, RecordCount);
      End;
    Except
      on E: Exception do
      begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally
    If Not VarIsEmpty(ExcelBase) Then
    Begin
      ExcelBase.Quit;
      ExcelBase := Unassigned;
      Excel     := Unassigned;
    End;
  End;
end;

function TGravandoExecucaoSinteplastColorantes.fDescricaoColorante(
  strColorante: String): String;
begin
  Result := 'COLORANTE UNIVERSAL AXX AMARILLO';

  If strColorante = 'B' Then
    Result := 'COLORANTE UNIVERSAL B NEGRO'
  Else If strColorante = 'C' Then
    Result := 'COLORANTE UNIVERSAL C OCRE'
  Else If strColorante = 'D' Then
    Result := 'COLORANTE UNIVERSAL D VERDE'
  Else If strColorante = 'E' Then
    Result := 'COLORANTE UNIVERSAL E AZUL'
  Else If strColorante = 'F' Then
    Result := 'COLORANTE UNIVERSAL F ROJO'
  Else If strColorante = 'I' Then
    Result := 'COLORANTE UNIVERSAL I MARRON'
  Else If strColorante = 'KX' Then
    Result := 'COLORANTE UNIVERSAL KX BLANCO'
  Else If strColorante = 'L' Then
    Result := 'COLORANTE UNIVERSAL L SIENA'
  Else If strColorante = 'R' Then
    Result := 'COLORANTE UNIVERSAL R ROJO'
  Else If strColorante = 'T' Then
    Result := 'COLORANTE UNIVERSAL T AMARILLO'
  Else If strColorante = 'V' Then
    Result := 'COLORANTE UNIVERSAL V MAGENTA';
end;

function TGravandoExecucaoSinteplastColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;

function TGravandoExecucaoSinteplastColorantes.GetSqlDestino: string;
begin
  Result := '';
end;

function TGravandoExecucaoSinteplastColorantes.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '';
end;

procedure TGravandoExecucaoSinteplastColorantes.GravarRegistro(Excel: Variant;
  qryDestino: IDataSet; RecNo: Integer);
begin
  Begin
    If Not qryDestino.Locate('COL_CODCOL', VarArrayOf([Trim(Excel.Cells[RecNo, 4].Text)]), []) Then
    Begin
      qryDestino.Insert;
      qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('SIN_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
      qryDestino.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
      qryDestino.FieldByName('COL_CODCOL').AsString := Trim(Excel.Cells[RecNo, 4].Text);
      qryDestino.FieldByName('COL_DESCRI').AsString := fDescricaoColorante(qryDestino.FieldByName('COL_CODCOL').AsString);
      qryDestino.FieldByName('COL_EMBALA').AsFloat  := 1000;
      qryDestino.Post;
    End;
  End;
end;

procedure TGravandoExecucaoSinteplastColorantes.LimparTabelas;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'DELETE FROM SIN_CADCOL';
  qryGen.ExecSQL;
end;

end.

