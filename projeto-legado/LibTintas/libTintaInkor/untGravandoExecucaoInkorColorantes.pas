{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta Inkor *}
{***************************************************************************PH*}
unit untGravandoExecucaoInkorColorantes;

interface

uses
  untAbstractGravandoExecucaoInkor, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, Dialogs, StrUtils, untStrUtils, Variants;
type
  TGravandoExecucaoInkorColorantes = class(TAbstractGravandoExecucaoInkor)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function GetSQLOrigem(): String;
    function IsRegistroExiste(qryColorantes: IDataSet; qryOrigem: TADODataSet): Boolean;
  end;

implementation

{ TGravandoExecucaoInkorCores }

procedure TGravandoExecucaoInkorColorantes.Executar(const gravando: IGravando);
Var
  intCont: Integer;
  qryCadCol: IDataSet;
begin
  For intCont := 0 To stlTables.Count - 1 Do
  Begin
    Try
      Try
        If (Gravando.Status <> sgGravando) Then
          Exit;

        Gravando.Texto := 'Verificando Path...';

        If Not fValidaPath(intCont) Then
        Begin
          Gravando.Texto := Format('O arquivo %s não foi encontrado! Rever Configurações.', [AnsiReplaceStr(fGetPath(intCont), '"', '')]);
          Exit;
        End;

        Gravando.Texto := 'Verificando PROCOD...';
        TAutcomTintaFactory.Get.fInsereProCod('INK_CADCOL');
        Gravando.Texto := 'PROCOD verificado com sucesso...';

        Gravando.Texto := 'Carregando Dados...';

        If intCont = 0 Then
        Begin
          Gravando.Texto := 'Deletando Registros da tabela INK_CADCOL...';
          qryCadCol := TAutcomTintaFactory.Get.fGetDataSet;
          qryCadCol.SQL := '    DELETE FROM INK_CADCOL      ';
          qryCadCol.ExecSQL;
        End;

        qryCadCol.Close;
        qryCadCol.SQL := '  SELECT * FROM INK_CADCOL        ';
        qryCadCol.Open;

        CreateConnection(intCont);

        tblArquivo.CommandText := GetSQLOrigem;
        tblArquivo.Open;
        tblArquivo.First;

        Gravando.Texto := Format('Processando Arquivo:[%s]', [AnsiReplaceStr(fGetPath(intCont), '"', '')]);
        Gravando.RegistrarProgresso(0, 0, 0);

        While Not tblArquivo.Eof Do
        Begin

          If (Gravando.Status <> sgGravando) Then
            Break;

          If Not IsRegistroExiste(qryCadCol, tblArquivo) Then
          Begin
            qryCadCol.Insert;
            qryCadCol.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('INK_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
            qryCadCol.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
            qryCadCol.FieldByName('COL_CODCOL').AsString := tblArquivo.FieldByName('Codigo').AsString;
            qryCadCol.FieldByName('COL_EMBALA').AsFloat  := tblArquivo.FieldByName('Volume').AsFloat;
            qryCadCol.FieldByName('COL_DESCRI').AsString := tblArquivo.FieldByName('Corante').AsString;
            qryCadCol.Post;
          End;

          tblArquivo.Next;
          Gravando.RegistrarProgresso(0, tblArquivo.RecNo, tblArquivo.RecordCount);
        End;
      Except
        On E: Exception Do
          Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;
    Finally
      DestroyConnection;
    End;
  End;
end;

function TGravandoExecucaoInkorColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;

function TGravandoExecucaoInkorColorantes.GetSQLOrigem: String;
begin
  Result := '';
  Result := Result + '  SELECT                ';
  Result := Result + '    *                   ';
  Result := Result + '  FROM                  ';
  Result := Result + '    TBLCORANTES         ';
  Result := Result + '  ORDER BY CODIGO       ';
end;

function TGravandoExecucaoInkorColorantes.IsRegistroExiste(
  qryColorantes: IDataSet; qryOrigem: TADODataSet): Boolean;
begin
  Result := qryColorantes.Locate('COL_CODCOL', VarArrayOf([qryOrigem.FieldByName('Codigo').AsString]), []);
end;

end.

