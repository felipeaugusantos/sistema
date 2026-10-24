{******************************************************************************************}
{* Classe responsável pela geração do cadastro de Bases da tinta Resicolor 2              *}
{***************************************************************************************PH*}
unit untGravandoExecucaoResicolor2Bases;

interface

uses
  untAbstractGravandoExecucaoResicolor2, untIGravando, SysUtils, untIDataSet, Uni,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, dialogs,Classes,
  PostgreSQLUniProvider, StrUtils,System.Variants, Data.DB;

type
  TGravandoExecucaoResicolor2Bases = class(TAbstractGravandoExecucaoResicolor2)
  Private
    function fRetUnidade(AEmbalagem : Double): String;
    Procedure DeletarRegistros;
  Protected
  Public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses untStrUtils;

{ TGravandoExecucaoResicolor2Cores }

procedure TGravandoExecucaoResicolor2Bases.DeletarRegistros;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' DELETE FROM RS2_CADBAS  ';
  qryGen.ExecSQL;
end;

procedure TGravandoExecucaoResicolor2Bases.Executar(const gravando: IGravando);
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

  Gravando.Texto := 'Deletando registros da tabela RS2_CADBAS...';
  DeletarRegistros;
  Gravando.Texto := 'Registros deletados com sucesso...';

  Gravando.Texto := 'Path verificado com sucesso...';
  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('RS2_CADBAS');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  If (Gravando.Status <> sgGravando) Then
    Exit;

  Try
    Try
      LPlanilha := CreateOleObject('Excel.Application');
      LPlanilha.WorkBooks.open(fGetPath);
      LSheet:= LPlanilha.Workbooks[1].WorkSheets[2];
      gravando.Texto := 'Iniciando a importação do arquivo...';

      LRecordCount := LSheet.Cells.SpecialCells(11).Row;
      LLinha := 2;

      LQryDestino := TAutcomTintaFactory.Get.fGetDataSet;
      LQryDestino.Close;
      LQryDestino.SQL := '  SELECT * FROM RS2_CADBAS  ';
      LQryDestino.Open;

      While (LLinha <= LRecordCount) Do
      Begin
        If gravando.Status <> sgGravando Then
          Break;

        If Not LQryDestino.Locate('BAS_CODBAS;BAS_PRODUT;BAS_UNIDAD;BAS_EMBALA', VarArrayOf([
          LSheet.Cells[LLinha, 3].Text, LSheet.Cells[LLinha, 2].Text, fRetUnidade(StrToFloat(LSheet.Cells[LLinha, 7].Text)), StrToFloat(LSheet.Cells[LLinha, 7].Text)]), []) Then
        Begin
          LQryDestino.Insert;
          LQryDestino.FieldByName('AUTOINCREM').AsString  := TAutcomTintaFactory.Get.fRetAutoIncrem('RS2_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
          LQryDestino.FieldByName('BAS_CODEMP').AsString  := TAutcomTintaFactory.Get.GetCodEmp;
          LQryDestino.FieldByName('BAS_CODBAS').AsString  := LSheet.Cells[LLinha, 3].Text;
          LQryDestino.FieldByName('BAS_PRODUT').AsString  := LSheet.Cells[LLinha, 2].Text;
          LQryDestino.FieldByName('BAS_UNIDAD').AsString  := fRetUnidade(StrToFloat(LSheet.Cells[LLinha, 7].Text));
          LQryDestino.FieldByName('BAS_DESEMB').AsString  := LSheet.Cells[LLinha, 6].Text;
          LQryDestino.FieldByName('BAS_EMBALA').AsFloat   := StrToFloat(LSheet.Cells[LLinha, 7].Text);
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

function TGravandoExecucaoResicolor2Bases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TGravandoExecucaoResicolor2Bases.fRetUnidade(AEmbalagem : Double): String;
begin
  If AEmbalagem < 1500 Then
    Result := 'LT'
  Else If (AEmbalagem >= 1500) And (AEmbalagem <= 5000) Then
    Result := 'GL'
  Else If AEmbalagem > 5000 Then
    Result := 'LA';
end;



end.


