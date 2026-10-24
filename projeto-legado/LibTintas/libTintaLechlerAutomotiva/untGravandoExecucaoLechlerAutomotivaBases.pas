{*************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta LechlerAutomotiva *}
{**********************************************************************PH*}
unit untGravandoExecucaoLechlerAutomotivaBases;

interface

uses
  untAbstractGravandoExecucaoLechlerAutomotiva, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils,
  UniClientDataSet, Vcl.Graphics, ComObj;

type
  TGravandoExecucaoLechlerAutomotivaBases = class(TAbstractGravandoExecucaoLechlerAutomotiva)
  Private
    FQryGen: IDataSet;
    procedure LimparTabelas;
    function fQtdEmbalagemMl(strEmbalagem: String): String;
  public
    function GetAdoQuery(var strNomeArquivo:String):TADOQuery; override;
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; override;
    function GetSqlDestino(): string; override;
    function fGetPath(): String; override;
    function IsRegistroExistente(ACodBas: String): Boolean; reintroduce;
    procedure GravarRegistro(Excel: Variant; qryDestino: IDataSet; RecNo: Integer); Reintroduce;
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses untStrUtils, untIDefinicaoTxt, untGenericDefinicaoTxt, untDefinicaoTxtCharacterSet,
  untIDefinicaoTxtCampo, untGenericDefinicaoTxtCampo, untDefinicaoTxtCampoTipo, untADOTxtFactory;

{ TGravandoExecucaoLechlerAutomotivaBases }

procedure TGravandoExecucaoLechlerAutomotivaBases.Executar(const gravando: IGravando);
Var
  qryDestino: IDataSet;
  Excel: Variant;
  ExcelBases: Variant;
  RecordCount: Integer;
  RecNo: Integer;
begin
  Try
    Try

      Gravando.Texto := 'Verificando Path do arquivo...';

      If Not fValidarPath() Then
      Begin
        Gravando.Texto := Format('O arquivo [%s] não foi encontrado! Verifique as Configurações.', [AnsiReplaceStr(fGetPath(), '"', '')]);
        Exit;
      End;

      Gravando.Texto := 'Deletando Registros da tabela LCA_CADBAS...';
      LimparTabelas();

      Gravando.Texto := 'Path verificado com sucesso...';

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('LCA_CADBAS');
      Gravando.Texto := 'PROCOD verificado com sucesso...';


      Gravando.Texto := 'Carregando Dados...';
      qryDestino := GetDataSetDestino;
      FQryGen := TAutcomTintaFactory.Get.fGetDataSet;

      ExcelBases := CreateOleObject('Excel.Application');
      ExcelBases.Visible := False;
      ExcelBases.WorkBooks.Open(fGetPath);
      Excel := ExcelBases.WorkBooks[1].WorkSheets[1];
      RecordCount := Excel.Cells.SpecialCells(11).Row;


      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := Format('Processando Arquivo: [%s]', [AnsiReplaceStr(fGetPath(), '"', '')]);
      Gravando.RegistrarProgresso(0, 0, 0);

      For RecNo := 2 To RecordCount Do
      Begin
        If (Gravando.Status <> sgGravando) Then
          Break;

        If Not IsRegistroExistente(LimpaTexto(Excel.Cells[RecNo, 2].Text)) Then
          GravarRegistro(Excel, qryDestino, RecNo);

        Gravando.RegistrarProgresso(0, RecNo, RecordCount);
      End;
    Except
      On E: Exception Do
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
    End;
  Finally
    ExcelBases.Quit;
    ExcelBases := Unassigned;
    Excel     := Unassigned;
  End;
end;

function TGravandoExecucaoLechlerAutomotivaBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;


function TGravandoExecucaoLechlerAutomotivaBases.fGetPath(): String;
begin
  Result := Conf.fGet('PABLCA');
end;

function TGravandoExecucaoLechlerAutomotivaBases.fQtdEmbalagemMl(
  strEmbalagem: String): String;
begin
  Result := Trim(strEmbalagem) + ' ML';
end;

function TGravandoExecucaoLechlerAutomotivaBases.GetAdoQuery(
  var strNomeArquivo: String): TADOQuery;
begin
  Result := Nil;
end;

function TGravandoExecucaoLechlerAutomotivaBases.GetSqlDestino: string;
begin
  Result := ' SELECT * FROM LCA_CADBAS  ';
end;

function TGravandoExecucaoLechlerAutomotivaBases.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '';
end;

procedure TGravandoExecucaoLechlerAutomotivaBases.GravarRegistro(Excel: Variant; qryDestino: IDataSet; RecNo: Integer);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('LCA_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('BAS_CODBAS').AsString := LimpaTexto(Excel.Cells[RecNo, 2].Text);
  qryDestino.FieldByName('BAS_DESCRI').AsString := LimpaTexto(Excel.Cells[RecNo, 3].Text);
  qryDestino.FieldByName('BAS_EMBALA').AsFloat  := StrToFloat(Excel.Cells[RecNo, 4].Text) * 1000;
  qryDestino.FieldByName('BAS_PESESP').AsFloat  := StrToFloat(Excel.Cells[RecNo, 6].Text);
  qryDestino.FieldByName('BAS_QTDEMB').AsString := AnsiReplaceStr(fQtdEmbalagemMl(FloatToStrF(qryDestino.FieldByName('BAS_EMBALA').AsFloat, ffNumber, 12, 0)), '.', '');
  qryDestino.Post;
end;

function TGravandoExecucaoLechlerAutomotivaBases.IsRegistroExistente(ACodBas: String): Boolean;
begin
  FQryGen.Close;
  FQryGen.SQL := '  SELECT * FROM LCA_CADBAS WHERE BAS_CODBAS = :CODBAS ';
  FQryGen.ParamByName('CODBAS').AsString := ACodBas;
  FQryGen.Open;

  Result := Not FQryGen.IsEmpty;
end;

procedure TGravandoExecucaoLechlerAutomotivaBases.LimparTabelas;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'DELETE FROM LCA_CADBAS';
  qryGen.ExecSQL;
end;

end.
