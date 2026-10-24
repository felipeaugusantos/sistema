{**********************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta Sinteplast *}
{*******************************************************************************AC*}
unit untGravandoExecucaoSinteplastBases;

interface

uses
  untAbstractGravandoExecucaoSinteplast, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils, ComObj, Math;
type
  TGravandoExecucaoSinteplastBases = class(TAbstractGravandoExecucaoSinteplast)
  Private
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

uses untStrUtils, untIDefinicaoTxt, untGenericDefinicaoTxt, untDefinicaoTxtCharacterSet,
  untIDefinicaoTxtCampo, untGenericDefinicaoTxtCampo, untDefinicaoTxtCampoTipo, untADOTxtFactory;

{ TGravandoExecucaoSinteplastBases }

procedure TGravandoExecucaoSinteplastBases.Executar(const gravando: IGravando);
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
      TAutcomTintaFactory.Get.fInsereProCod('SIN_CADBAS');
      Gravando.Texto := 'PROCOD verificado com sucesso!';

      Gravando.Texto := 'Deletando registros da tabela SIN_CADBAS...';
      LimparTabelas;
      Gravando.Texto := 'Registros deletados com sucesso...';

      Gravando.Texto := 'Abrindo Cadastro de Bases...';

      qryDestino := TAutcomTintaFactory.Get.fGetDataSet;
      qryDestino.Close;
      qryDestino.SQL := '    SELECT * FROM SIN_CADBAS      ';
      qryDestino.Open;

      ExcelBase := CreateOleObject('Excel.Application');
      ExcelBase.Visible := False;
      ExcelBase.WorkBooks.Open(fGetNomeArquivo);
      Excel := ExcelBase.WorkBooks[1].WorkSheets[1];
      RecordCount := Excel.Cells.SpecialCells(11).Row;

      Gravando.Texto := Format('Processando arquivo: [%s] - BASE', [AnsiReplaceStr(fGetNomeArquivo, '"', '')]);
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

function TGravandoExecucaoSinteplastBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;


function TGravandoExecucaoSinteplastBases.GetSqlDestino: string;
begin
  Result := '';
end;

function TGravandoExecucaoSinteplastBases.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '';
end;

procedure TGravandoExecucaoSinteplastBases.GravarRegistro(Excel: Variant;
  qryDestino: IDataSet; RecNo: Integer);
Var
  intConUnidade: Integer;
  strTipoFormula: String;
  intUnidade: Integer;
  intProduto: Integer;
  intConProduto: Integer;
begin
  strTipoFormula := fGetTipoFormula(Trim(Excel.Cells[RecNo, 1].Text), Trim(Excel.Cells[RecNo, 3].Text));
  intUnidade := fGetQtdUnidade(strTipoFormula);
  intProduto := fGetQtdProdutos(strTipoFormula);

  For intConUnidade := 1 To intUnidade Do
  Begin
    For intConProduto := 1 To intProduto Do
    Begin
      If Not qryDestino.Locate('BAS_CODBAS;BAS_PRODUT;BAS_UNIDAD', VarArrayOf([fRetCodBase(Trim(Excel.Cells[RecNo, 3].Text)), fRetProduto(intConProduto, strTipoFormula),
        fRetCodUnidade(intConUnidade)]), []) Then
      Begin
        qryDestino.Insert;
        qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('SIN_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
        qryDestino.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
        qryDestino.FieldByName('BAS_PRODUT').AsString := fRetProduto(intConProduto, strTipoFormula);
        qryDestino.FieldByName('BAS_CODBAS').AsString := fRetCodBase(Trim(Excel.Cells[RecNo, 3].Text));
        qryDestino.FieldByName('BAS_UNIDAD').AsString := fRetCodUnidade(intConUnidade);
        qryDestino.FieldByName('BAS_EMBALA').AsFloat :=  fRetValorEmbalagemGramas(qryDestino.FieldByName('BAS_UNIDAD').AsString);
        qryDestino.Post;
      End;
    End;
  End;
end;

procedure TGravandoExecucaoSinteplastBases.LimparTabelas;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'DELETE FROM SIN_CADBAS';
  qryGen.ExecSQL;
end;

end.
