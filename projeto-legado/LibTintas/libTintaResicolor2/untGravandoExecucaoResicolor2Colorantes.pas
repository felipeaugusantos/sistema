{******************************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta Resicolor  2        *}
{***************************************************************************************PH*}
unit untGravandoExecucaoResicolor2Colorantes;

interface

uses
  untAbstractGravandoExecucaoResicolor2, untIGravando, SysUtils, untIDataSet, Uni,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, dialogs,Classes,
  PostgreSQLUniProvider, StrUtils,System.Variants, Data.DB;

type
  TGravandoExecucaoResicolor2Colorantes = class(TAbstractGravandoExecucaoResicolor2)
  Private
    Procedure DeletarRegistros;
  Protected
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses untStrUtils;

{ TGravandoExecucaoResicolor2Cores }

procedure TGravandoExecucaoResicolor2Colorantes.DeletarRegistros;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' DELETE FROM RS2_CADCOL  ';
  qryGen.ExecSQL;
end;

procedure TGravandoExecucaoResicolor2Colorantes.Executar(const gravando: IGravando);
Var
  LQryDestino   : IDataSet;
  LPlanilha     : OleVariant;
  LSheet        : OleVariant;
  LRecordCount  : Integer;
  LLinha        : Integer;
begin
  Gravando.Texto := 'Validando Path de Arquivos ...';

  If Not FileExists(fGetPath) Then
  Begin
    Gravando.Texto := Format('O arquivo [%s] não foi encontrado! Verifique as Configurações.', [AnsiReplaceStr(fGetPath, '"', '')]);
    Exit;
  End;

  Gravando.Texto := 'Deletando registros da tabela RS2_CADCOL...';
  DeletarRegistros;
  Gravando.Texto := 'Registros deletados com sucesso...';

  Gravando.Texto := 'Path verificado com sucesso...';
  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('RS2_CADCOL');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  If (Gravando.Status <> sgGravando) Then
    Exit;

  Try
    Try
      LPlanilha := CreateOleObject('Excel.Application');
      LPlanilha.WorkBooks.open(fGetPath);
      LSheet:= LPlanilha.Workbooks[1].WorkSheets[1];
      gravando.Texto := 'Iniciando a importação do arquivo...';

      LRecordCount := LSheet.Cells.SpecialCells(11).Row;
      LLinha := 2;

      LQryDestino := TAutcomTintaFactory.Get.fGetDataSet;
      LQryDestino.Close;
      LQryDestino.SQL := '  SELECT * FROM RS2_CADCOL  ';
      LQryDestino.Open;

      While (LLinha <= LRecordCount) Do
      Begin
        If gravando.Status <> sgGravando Then
          Break;

        If Not LQryDestino.Locate('COL_CODCOL', LSheet.Cells[LLinha, 1].Text, []) Then
        Begin
          LQryDestino.Insert;
          LQryDestino.FieldByName('AUTOINCREM').AsString  := TAutcomTintaFactory.Get.fRetAutoIncrem('RS2_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
          LQryDestino.FieldByName('COL_CODEMP').AsString  := TAutcomTintaFactory.Get.GetCodEmp;
          LQryDestino.FieldByName('COL_CODCOL').AsString  := LSheet.Cells[LLinha, 1].Text;
          LQryDestino.FieldByName('COL_DESCRI').AsString := LSheet.Cells[LLinha, 2].Text;
          LQryDestino.FieldByName('COL_EMBALA').AsFloat   := 1000;
          LQryDestino.Post;
        End;

        Inc(LLinha);
        gravando.RegistrarProgresso(0, LLinha, LRecordCount);
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        Gravando.Cancelar;
      End;
    End;
  Finally
    LPlanilha.Quit;
    LPlanilha := Unassigned;
    LSheet := Unassigned;
  End;
end;

function TGravandoExecucaoResicolor2Colorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;

end.


