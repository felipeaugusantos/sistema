{**********************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta Liko *}
{*******************************************************************************AC*}
unit untGravandoExecucaoLikoBases;

interface

uses
  untAbstractGravandoExecucaoLiko, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, ComObj, Dialogs,
  StrUtils;

type
  TGravandoExecucaoLikoBases = class(TAbstractGravandoExecucaoLiko)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

{ TGravandoExecucaoLikoBases }

procedure TGravandoExecucaoLikoBases.Executar(const gravando: IGravando);
var
  OlePlanilha, OleSheet: OleVariant;
  intLinha, intUltimaLinha:Integer;
  blnFimPlanilha:Boolean;
  intUnidade:Integer;
  qryCadBas: IDataSet;
Const
  ArrUnidade: Array[1..3] Of String = ('LT', 'GL', 'LA');
begin
  Try
    Try
      If Not FileExists(GetPath) Then
      Begin
        gravando.texto := Format('O arquivo %s não existe', [AnsiReplaceStr(GetPath, '"', '')]);
        gravando.Cancelar;
      End;

      If (gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Carregando Dados do Cadastro de Bases...';

      OlePlanilha := CreateOleObject('Excel.Application');
      OlePlanilha.Visible := False;
      OlePlanilha.WorkBooks.Open(GetPath);
      OleSheet := OlePlanilha.WorkSheets[1];

      intUltimaLinha := 2;
      blnFimPlanilha := False;
      While Not blnFimPlanilha Do
      Begin
        Inc(intUltimaLinha);
        If OleSheet.Cells[intUltimaLinha, 1].Text = '' Then
        Begin
          blnFimPlanilha := True;
          Dec(intUltimaLinha);
        End;
      End;

      qryCadBas := TAutcomTintaFactory.Get.fGetDataSet;

      Gravando.Texto := 'Deletando Cadastro de Bases...';
      qryCadBas.SQL := '    DELETE FROM LIK_CADBAS    ';
      qryCadBas.ExecSQL;
      qryCadBas.SQL.Empty;
      Gravando.Texto := 'Cadastro de Bases Deletado...';

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('LIK_CADBAS');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      Gravando.Texto := 'Abrindo Cadastro de Bases...';
      qryCadBas.SQL := '    SELECT * FROM LIK_CADBAS    ';
      qryCadBas.Open;

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.texto := Format('Processando arquivo [%s]', [AnsiReplaceStr(GetPath, '"', '')]);
      Gravando.RegistrarProgresso(0, 0, 0);

      Try
        For intLinha := 2 To intUltimaLinha Do
        Begin
          For intUnidade := 1 To 3 Do
          Begin
            If Not qryCadBas.Locate('BAS_BASE__;BAS_UNIDAD;BAS_CODEMP', VarArrayOf([OleSheet.Cells[intLinha, 5].Text, ArrUnidade[intUnidade],
                                    TAutcomTintaFactory.Get.GetCodEmp]), []) Then
            Begin
              If (Gravando.Status <> sgGravando) Then
                Break;

              qryCadBas.Insert;
              qryCadBas.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('LIK_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
              qryCadBas.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
              qryCadBas.FieldByName('BAS_DESCRI').AsString := AnsiUpperCase(oleSheet.Cells[intLinha, 5].Text);
              qryCadBas.FieldByName('BAS_BASE__').AsString := AnsiUpperCase(oleSheet.Cells[intLinha, 5].Text);
              qryCadBas.FieldByName('BAS_UNIDAD').AsString := ArrUnidade[intUnidade];
              qryCadBas.FieldByName('BAS_PREVEN').AsFloat := 0.00;
              qryCadBas.FieldByName('BAS_PRECUS').AsFloat := 0.00;
              qryCadBas.FieldByName('BAS_MARGEM').AsFloat := 0.00;
              qryCadBas.FieldByName('BAS_CODITE').Value := Null;
              qryCadBas.Post;
            End;
          End;
         Gravando.RegistrarProgresso(0, intLinha -1, intUltimaLinha - 1);
        End;

      Except
        On E: Exception Do
        Begin
          gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        End;

      End;

    Except
      On E: Exception Do
      Begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;

    End;
  Finally
    If Not VarIsEmpty(olePlanilha) Then
    Begin
      olePlanilha.Quit;
      OlePlanilha := Unassigned;
      oleSheet := Unassigned;
    End;
    Gravando.Texto := 'Cadastro de Bases foi processado...';
  End;
end;

function TGravandoExecucaoLikoBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

end.
