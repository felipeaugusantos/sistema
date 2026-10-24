{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta Liko *}
{***************************************************************************PH*}
unit untGravandoExecucaoLikoColorantes;

interface

uses
  untAbstractGravandoExecucaoLiko, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, Dialogs, StrUtils, untStrUtils, Variants;
type
  TGravandoExecucaoLikoColorantes = class(TAbstractGravandoExecucaoLiko)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

{ TGravandoExecucaoLikoCores }

procedure TGravandoExecucaoLikoColorantes.Executar(const gravando: IGravando);
var
  olePlanilha, oleSheet: OleVariant; //Colorantes
  olePlanilhaEmb, oleSheetEmb: OleVariant; //Embalagens
  intLinha, intUltimaLinha: Integer;
  intContador: Integer;
  qryCadCol,qryCadEmb: IDataSet;
  blnUltimaLinha: Boolean;
begin
  Try
    Try
      If Not FileExists(GetPath) Then
      Begin
        gravando.texto := Format('O arquivo %s não existe', [AnsiReplaceStr(GetPath, '"', '')]);
        gravando.Cancelar;
      End;

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Carregando Dados do Cadastro de Colorantes...';

      olePlanilha := CreateOleObject('Excel.Application');
      olePlanilha.Visible := False;
      olePlanilha.WorkBooks.Open(GetPath);
      oleSheet := olePlanilha.WorkSheets[3];

      intUltimaLinha := 6;
      blnUltimaLinha := False;
      While Not blnUltimaLinha Do
      Begin
        Inc(intUltimaLinha);
        If oleSheet.Cells[intUltimaLinha, 1].Text = '' Then
        Begin
          blnUltimaLinha := True;
          Dec(intUltimaLinha);
        End;
      End;

      qryCadCol := TAutcomTintaFactory.Get.fGetDataSet;
      Gravando.Texto := 'Deletando Cadastro de Colorantes...';
      qryCadCol.SQL := '    DELETE FROM LIK_CADCOL    ';
      qryCadCol.ExecSQL;
      qryCadCol.SQL.Empty;
      Gravando.Texto := 'Cadastro de Colorantes Deletado...';

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('LIK_CADCOL');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      Gravando.Texto := 'Abrindo Cadastro de Colorantes...';
      qryCadCol.SQL := '    SELECT * FROM LIK_CADCOL    ';
      qryCadCol.Open;

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.texto := Format('Processando arquivo [%s]', [AnsiReplaceStr(GetPath, '"', '')]);
      Gravando.RegistrarProgresso(0, 0, 0);

      Try
        For intLinha := 6 To intUltimaLinha Do
        Begin
          If Not qryCadCol.Locate('COL_CODCOL;COL_DESCRI;COL_PESESP', VarArrayOf([oleSheet.Cells[intLinha, 1].Text, oleSheet.Cells[intLinha, 2].Text,
                                  TAutcomTintaFactory.Get.fStrToFloat(oleSheet.Cells[intLinha, 3].Text)]) , []) Then
          Begin

            If (Gravando.Status <> sgGravando) Then
              Break;

            qryCadCol.Insert;
            qryCadCol.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('LIK_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
            qryCadCol.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
            qryCadCol.FieldByName('COL_CODCOL').AsString := AnsiUpperCase(oleSheet.Cells[intLinha, 2].Text);
            qryCadCol.FieldByName('COL_DESCRI').AsString := AnsiUpperCase(oleSheet.Cells[intLinha, 1].Text);
            qryCadCol.FieldByName('COL_PESESP').AsFloat := TAutcomTintaFactory.Get.fStrToFloat(oleSheet.Cells[intLinha, 3].Text);
            qryCadCol.Post;
          End;
          Gravando.RegistrarProgresso(0, intLinha -5, intUltimaLinha -5);
        End;
      Except
        On E: Exception Do
        Begin
          gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        End;
      End;

      If Not VarIsEmpty(olePlanilha) Then
      Begin
        olePlanilha.Quit;
        olePlanilha := Unassigned;
        oleSheet := Unassigned;
      End;

      Gravando.Texto := 'Cadastro de Colorantes foi processado...';

      Gravando.Texto := 'Carregando Dados do Cadastro de Embalagens...';
      olePlanilhaEmb := CreateOleObject('Excel.Application');
      olePlanilhaEmb.Visible := False;
      olePlanilhaEmb.WorkBooks.Open(GetPath);

      oleSheetEmb := olePlanilhaEmb.WorkSheets[2];

      intUltimaLinha := 6;
      blnUltimaLinha := False;
      While Not blnUltimaLinha Do
      Begin
        Inc(intUltimaLinha);
        If oleSheetEmb.Cells[intUltimaLinha, 1].Text = '' Then
        Begin
          blnUltimaLinha := True;
          Dec(intUltimaLinha);
        End;
      End;

      qryCadEmb := TAutcomTintaFactory.Get.fGetDataSet;
      Gravando.Texto := 'Deletando Cadastro de Embalagens...';
      qryCadEmb.SQL := '    DELETE FROM LIK_CADEMB    ';
      qryCadEmb.ExecSQL;
      qryCadEmb.SQL.Empty;
      Gravando.Texto := 'Cadastro de Embalagens Deletado...';

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('LIK_CADEMB');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      Gravando.Texto := 'Abrindo Cadastro de Embalagens...';
      qryCadEmb.SQL := '    SELECT * FROM LIK_CADEMB    ';
      qryCadEmb.Open;
      intContador := 1;

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.texto := Format('Processando arquivo [%s]', [AnsiReplaceStr(GetPath, '"', '')]);
      Gravando.RegistrarProgresso(0, 0, 0);
      Try
        For intLinha := 6 To intUltimaLinha Do
        Begin
          If Not qryCadEmb.Locate('EMB_CODEMB', VarArrayOf([intContador]), []) Then
          Begin

            If (Gravando.Status <> sgGravando) Then
              Break;

            qryCadEmb.Insert;
            qryCadEmb.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('LIK_CADEMB', TAutcomTintaFactory.Get.GetCodEmp);
            qryCadEmb.FieldByName('EMB_CODEMB').AsString := TAutcomTintaFactory.Get.GetCodEmp;
            qryCadEmb.FieldByName('EMB_CODEMB').AsInteger := intContador;
            qryCadEmb.FieldByName('EMB_QTDEMB').AsFloat := TAutcomTintaFactory.Get.fStrToFloat(oleSheetEmb.Cells[intLinha, 2].Text);
            If AnsiUpperCase(oleSheetEmb.Cells[intLinha, 1].Text) = 'QUARTO' Then
              qryCadEmb.FieldByName('EMB_UNIDAD').AsString := 'LT'
            Else if AnsiUpperCase(oleSheetEmb.Cells[intLinha, 1].Text) = 'GALÃO' Then
              qryCadEmb.FieldByName('EMB_UNIDAD').AsString := 'GL'
            Else
              qryCadEmb.FieldByName('EMB_UNIDAD').AsString := 'LA';

            qryCadEmb.Post;
          End;
          Inc(intContador);
          Gravando.RegistrarProgresso(0, intLinha -5, intUltimaLinha -5);
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
    If Not VarIsEmpty(olePlanilhaEmb) Then
    Begin
      olePlanilhaEmb.Quit;
      olePlanilhaEmb := Unassigned;
      oleSheetEmb := Unassigned;
    End;
    Gravando.Texto := 'Cadastro de Embalagem foi processado...';
  End;
end;

function TGravandoExecucaoLikoColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes/Embalagens';
end;


end.

