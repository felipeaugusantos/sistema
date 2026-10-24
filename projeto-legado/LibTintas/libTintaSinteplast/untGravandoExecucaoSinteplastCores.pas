{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta Sinteplast *}
{**********************************************************************PH*}
unit untGravandoExecucaoSinteplastCores;

interface

uses
  untAbstractGravandoExecucaoSinteplast, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils,
  System.Win.ComObj;

type
  TGravandoExecucaoSinteplastCores = class(TAbstractGravandoExecucaoSinteplast)
  Private
    procedure GravarRegistro(Excel: Variant; qryDestino: IDataSet; RecNo: Integer; intQuantidade: Integer);
    procedure LimparTabelas;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function GetSqlDestino(): string; override;
    function GetSqlOrigem(const strNomeArquivo: string;
      const stlTabelas: TStrings): string; override;
  end;

Implementation

uses
  untFuncoesGenerica, untStrUtils, untDefinicaoTxtCampoTipo, untADOTxtFactory, untGenericDefinicaoTxtCampo, untGenericDefinicaoTxt,
    untIDefinicaoTxtCampo, untIDefinicaoTxt, untDefinicaoTxtCharacterSet;


{ TGravandoExecucaoSinteplastCores }

procedure TGravandoExecucaoSinteplastCores.Executar(const gravando: IGravando);
var
  qryDestino: IDataSet;
  Excel: Variant;
  ExcelBase: Variant;
  RecordCount: Integer;
  RecNo: Integer;
  intQuantidade: Integer;
  strCodAnterior: String;
begin
  Try
    Try
      intQuantidade := 1;

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
      TAutcomTintaFactory.Get.fInsereProCod('SIN_CADSIN');
      Gravando.Texto := 'PROCOD verificado com sucesso!';

      Gravando.Texto := 'Deletando registros da tabela SIN_CADSIN...';
      LimparTabelas;
      Gravando.Texto := 'Registros deletados com sucesso...';

      Gravando.Texto := 'Abrindo Cadastro de Cores...';

      qryDestino := TAutcomTintaFactory.Get.fGetDataSet;
      qryDestino.Close;
      qryDestino.SQL := '    SELECT * FROM SIN_CADSIN      ';
      qryDestino.Open;

      ExcelBase := CreateOleObject('Excel.Application');
      ExcelBase.Visible := False;
      ExcelBase.WorkBooks.Open(fGetNomeArquivo);
      Excel := ExcelBase.WorkBooks[1].WorkSheets[1];
      RecordCount := Excel.Cells.SpecialCells(11).Row;

      Gravando.Texto := Format('Processando arquivo: [%s] - CORES', [AnsiReplaceStr(fGetNomeArquivo, '"', '')]);
      Gravando.RegistrarProgresso(0, 0, 0);

      For RecNo := 2 To RecordCount Do
      Begin
        If (Gravando.Status <> sgGravando) Then
          Break;

        If strCodAnterior <> Trim(Excel.Cells[RecNo, 1].Text) Then
          intQuantidade := 1;

        strCodAnterior := Trim(Excel.Cells[RecNo, 1].Text);

        GravarRegistro(Excel, qryDestino, RecNo, intQuantidade);
        Inc(intQuantidade, 1);
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

function TGravandoExecucaoSinteplastCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;


function TGravandoExecucaoSinteplastCores.GetSqlDestino: string;
begin
  Result := '';
end;

function TGravandoExecucaoSinteplastCores.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '';
end;

procedure TGravandoExecucaoSinteplastCores.GravarRegistro(Excel: Variant;
  qryDestino: IDataSet; RecNo: Integer; intQuantidade: Integer);
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
      If Not qryDestino.Locate('SIN_CODIGO;SIN_UNIDAD;SIN_PRODUT', VarArrayOf([Trim(Excel.Cells[RecNo, 1].Text), fRetCodUnidade(intConUnidade),
        fRetProduto(intConProduto, strTipoFormula)]), []) Then
      Begin
        qryDestino.Insert;
        qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('SIN_CADSIN', TAutcomTintaFactory.Get.GetCodEmp);
        qryDestino.FieldByName('SIN_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
        qryDestino.FieldByName('SIN_CODIGO').AsString := Trim(Excel.Cells[RecNo, 1].Text);
        qryDestino.FieldByName('SIN_CODBAS').AsString := fRetCodBase(Trim(Excel.Cells[RecNo, 3].Text));
        qryDestino.FieldByName('SIN_NOMCOR').AsString := Trim(Excel.Cells[RecNo, 2].Text);
        qryDestino.FieldByName('SIN_PRODUT').AsString :=  fRetProduto(intConProduto, strTipoFormula);
        qryDestino.FieldByName('SIN_UNIDAD').AsString := fRetCodUnidade(intConUnidade);
        qryDestino.FieldByName('SIN_DESCRI').AsString := Trim(Excel.Cells[RecNo, 2].Text);
        qryDestino.FieldByName('SIN_ATIVAD').AsString := 'S';
        qryDestino.FieldByName('SIN_FORM01').AsString := Trim(Excel.Cells[RecNo, 4].Text);
        qryDestino.FieldByName('SIN_QTDC01').AsFloat  := StrToFloat(AnsiReplaceStr(Excel.Cells[RecNo, 5].Text, '.', ',')) * (fRetValorEmbalagemGramas(qryDestino.FieldByName('SIN_UNIDAD').AsString) / 800);
        qryDestino.FieldByName('SIN_MD5KEY').AsString := GetMD5(qryDestino.FieldByName('SIN_CODIGO').AsString +
                                                                qryDestino.FieldByName('SIN_CODBAS').AsString +
                                                                qryDestino.FieldByName('SIN_NOMCOR').AsString +
                                                                qryDestino.FieldByName('SIN_PRODUT').AsString +
                                                                qryDestino.FieldByName('SIN_UNIDAD').AsString);
        qryDestino.Post;
      End
      Else
      Begin
        qryDestino.Edit;
        qryDestino.FieldByName('SIN_FORM' + TStrUtils.fStrZero(intQuantidade, 2)).AsString := Trim(Excel.Cells[RecNo, 4].Text);
        qryDestino.FieldByName('SIN_QTDC' + TStrUtils.fStrZero(intQuantidade, 2)).AsFloat  := StrToFloat(AnsiReplaceStr(Excel.Cells[RecNo, 5].Text, '.', ',')) * (fRetValorEmbalagemGramas(qryDestino.FieldByName('SIN_UNIDAD').AsString) / 800);
        qryDestino.Post;
      End;
    End;
  End;
end;

procedure TGravandoExecucaoSinteplastCores.LimparTabelas;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'DELETE FROM SIN_CADSIN';
  qryGen.ExecSQL;
end;

end.

