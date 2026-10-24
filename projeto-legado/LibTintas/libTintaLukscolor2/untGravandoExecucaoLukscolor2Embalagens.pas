{******************************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta AlessiImobiliaria   *}
{***************************************************************************************AC*}
unit untGravandoExecucaoLukscolor2Embalagens;

interface

uses
  untAbstractGravandoExecucaoLukscolor2, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, untStatusGravando, DB, Classes,
  StrUtils, Variants, ComObj;

type
  TGravandoExecucaoLukscolor2Embalagens = class(TAbstractGravandoExecucaoLukscolor2)
  private
    function fRetPatDBF : String;
    function fRetUnidade(strQtdEmb : String) : String;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function GetSqlDestino(): string; override;
    function GetSqlOrigem(const strNomeArquivo: string;
      const stlTabelas: TStrings): string; override;
  end;

implementation

uses untStrUtils;

{ TGravandoExecucaoLukscolor2Cores }

procedure TGravandoExecucaoLukscolor2Embalagens.Executar(const gravando: IGravando);
var
  qryDestino  : IDataSet;
  Planilha    : OleVariant;
  Sheet       : OleVariant;
  intUltLinha : Integer;
  intLinha    : Integer;
  intLinhaProg: Integer;
begin
  Try
    Try
      gravando.Texto := 'Validando Path de Arquivos ...';

      If (Not DirectoryExists(fRetPatDBF)) Then
      Begin
        gravando.Texto := 'Path para o geração do arquivo de bases não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      gravando.Texto := 'Path validado com sucesso ...';

      gravando.Texto := 'Carregando dados...';

      Planilha := CreateOleObject('Excel.Application');
      Planilha.WorkBooks.open(fRetPatDBF + '\CANS.DBF');

      gravando.Texto := 'Dados carregados com sucesso!';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('LKC_CADEMB');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      Sheet := Planilha.Workbooks[1].WorkSheets['CANS'];

      intUltLinha := Sheet.Cells.SpecialCells(11).Row;

      intLinha     := 2;
      intLinhaProg := 1;

      gravando.RegistrarProgresso(0, intLinhaProg, intUltLinha);

      While (intLinha <= intUltLinha) Do
      begin
        Try
          Try
            if gravando.Status <> sgGravando then
              Exit;

            qryDestino := TAutcomTintaFactory.Get.fGetDataSet;

            qryDestino.SQL := 'SELECT * '+
                              '  FROM LKC_CADEMB '+
                              ' WHERE EMB_CODEMB  = :CODEMB '+
                              '   AND EMB_CODEMP  = :CODEMP '+
                              '   AND EMB_UNIDAD  = :UNIDAD ';

            qryDestino.ParamByName('CODEMB').AsString := Sheet.cells[intLinha, 1].Text;
            qryDestino.ParamByName('UNIDAD').AsString := fRetUnidade(Sheet.cells[intLinha, 6].Text);
            qryDestino.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
            qryDestino.Open;

            If (qryDestino.IsEmpty)and (qryDestino.ParamByName('CODEMB').AsString <> '' )Then
            Begin
              qryDestino.Insert;

              qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('LKC_CADEMB', TAutcomTintaFactory.Get.GetCodEmp);
              qryDestino.FieldByName('EMB_CODEMB').AsString := Sheet.cells[intLinha, 1].Text;
              qryDestino.FieldByName('EMB_QTDEMB').AsString := Sheet.cells[intLinha, 6].Text;
              qryDestino.FieldByName('EMB_UNIDAD').AsString := fRetUnidade(Sheet.cells[intLinha, 6].Text);
              qryDestino.FieldByName('EMB_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
              qryDestino.Post;

            end;

            Inc(intLinha);
            Inc(intLinhaProg);
          Except
            on E: Exception do
            begin
              gravando.Cancelar;
              gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
            end;
          End;
        Finally
          gravando.RegistrarProgresso(0, intLinhaProg, intUltLinha);
        End;
      end;
    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally
    Planilha.WorkBooks.Close;
  End;
end;

function TGravandoExecucaoLukscolor2Embalagens.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Embalagens';
end;

function TGravandoExecucaoLukscolor2Embalagens.fRetPatDBF: String;
begin
  Result := conf.fGet('PATLKC'); //LKCO1
end;

function TGravandoExecucaoLukscolor2Embalagens.fRetUnidade( strQtdEmb: String): String;
begin
  If strQtdEmb = '810,000' Then
    Result := 'LT'
  Else
  If strQtdEmb = '3240,000' Then
    Result := 'GL'
  Else
  If strQtdEmb = '16200,000' Then
    Result := 'LA';
end;

function TGravandoExecucaoLukscolor2Embalagens.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM LKC_CADEMB';
end;

function TGravandoExecucaoLukscolor2Embalagens.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result :=
    ' SELECT DISTINCT  ' +
    '   [NOME]         ' +
    '   , [LT]         ' +
    ' FROM             ' +
    '   [EMBALAGENS$]  ' +
    ' WHERE NOME <> "" ';
end;

end.

