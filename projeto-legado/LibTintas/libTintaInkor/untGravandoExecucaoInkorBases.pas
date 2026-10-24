{ ********************************************************************************** }
{ * Classe responsável pela geração do cadastro de bases da tinta Inkor * }
{ *******************************************************************************AC* }
unit untGravandoExecucaoInkorBases;

interface

uses
  untAbstractGravandoExecucaoInkor, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, ComObj, Dialogs,
  StrUtils, untStrUtils;

type
  TGravandoExecucaoInkorBases = class(TAbstractGravandoExecucaoInkor)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function GetSQLOrigem(): String;
    function fRetUnidade(fltVolume: Double): String;
    function IsRegistroExiste(qryBases: IDataSet; qryOrigem: TADODataSet): Boolean;
  end;

implementation

{ TGravandoExecucaoInkorBases }

procedure TGravandoExecucaoInkorBases.Executar(const gravando: IGravando);
Var
  intCont: Integer;
  qryCadBas: IDataSet;
begin
  For intCont := 0 To stlTables.Count - 1 Do
  Begin
    Try
      Try
        If (Gravando.Status <> sgGravando) Then
          Break;

        Gravando.Texto := 'Verificando Path...';

        If Not fValidaPath(intCont) Then
        Begin
          Gravando.Texto := Format('O arquivo %s não foi encontrado! Rever Configurações.', [AnsiReplaceStr(fGetPath(intCont), '"', '')]);
          Exit;
        End;

        Gravando.Texto := 'Verificando PROCOD...';
        TAutcomTintaFactory.Get.fInsereProCod('INK_CADBAS');
        Gravando.Texto := 'PROCOD verificado com sucesso...';

        Gravando.Texto := 'Carregando Dados...';

        If intCont = 0 Then
        Begin
          Gravando.Texto := 'Deletando Registros da tabela INK_CADBAS...';
          qryCadBas :=  TAutcomTintaFactory.Get.fGetDataSet;
          qryCadBas.SQL := '    DELETE FROM INK_CADBAS      ';
          qryCadBas.ExecSQL;
        End;

        qryCadBas.Close;
        qryCadBas.SQL := '    SELECT * FROM INK_CADBAS      ';
        qryCadBas.Open;

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


          If Not IsRegistroExiste(qryCadBas, tblArquivo) Then
          Begin
            qryCadBas.Insert;
            qryCadBas.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('INK_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
            qryCadBas.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
            qryCadBas.FieldByName('BAS_BASE__').AsString := tblArquivo.FieldByName('NomeBase').AsString;
            qryCadBas.FieldByName('BAS_DESCRI').AsString := tblArquivo.FieldByName('NomeGrupBase').AsString;
            qryCadBas.FieldByName('BAS_UNIDAD').AsString := fRetUnidade(tblArquivo.FieldByName('Volume').AsFloat);
            qryCadBas.FieldByName('BAS_CONTEU').AsFloat  := tblArquivo.FieldByName('Volume').AsFloat;
            qryCadBas.Post;
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

function TGravandoExecucaoInkorBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TGravandoExecucaoInkorBases.fRetUnidade(fltVolume: Double): String;
begin
  Result := '';

  If fltVolume <= 900 Then
    Result := 'LT'
  Else If fltVolume <= 3800 Then
    Result := 'GL'
  Else If fltVolume <= 20000 Then
    Result := 'LA';
end;

function TGravandoExecucaoInkorBases.GetSQLOrigem: String;
begin
  Result := '';
  Result := Result + '  SELECT                ';
  Result := Result + '    *                   ';
  Result := Result + '  FROM                        ';
  Result := Result + '    TBLBASES  B,              ';
  Result := Result + '    TBLNOMEBASE N,            ';
  Result := Result + '    TBLNOMEGRUPBASE G         ';
  Result := Result + '  WHERE                       ';
  Result := Result + '    B.IDNOMEBASE = N.IDNOMEBASE AND       ';
  Result := Result + '    B.IDNOMEGRUPBASE = G.IDNOMEGRUPBASE     ';
  Result := Result + '  ORDER BY IDBASE                         ';
end;

function TGravandoExecucaoInkorBases.IsRegistroExiste(qryBases: IDataSet;
  qryOrigem: TADODataSet): Boolean;
begin
  Result := qryBases.Locate('BAS_BASE__;BAS_DESCRI;BAS_UNIDAD', VarArrayOf([
    qryOrigem.FieldByName('NomeBase').AsString, qryOrigem.FieldByName('NomeGrupBase').AsString,
    fRetUnidade(qryOrigem.FieldByName('Volume').AsFloat)]), []);
end;

end.
