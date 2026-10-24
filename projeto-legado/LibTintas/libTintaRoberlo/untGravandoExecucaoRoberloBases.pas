unit untGravandoExecucaoRoberloBases;

interface

uses
  untAbstractGravandoExecucaoRoberlo, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils,
  untStrUtils, System.Win.ComObj;

type
  TGravandoExecucaoRoberloBases = class(TAbstractGravandoExecucaoRoberlo)
  private
    function fRetEmbalagem(strEmb: String): Double;
    function fQtdEmbalagemMl(strEmbalagem: String): String;

  protected
    function GetSqlDestino(): String; Override;
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): String; Override;
    function IsRegistroExistente(qryDestino: IDataSet; Excel: Variant; Linha: Integer): Boolean; Reintroduce;
    procedure GravarRegistro(qryDestino: IDataSet; Excel: Variant; Linha: Integer); Reintroduce;

  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses
  untIConfTinta;

{ TGravandoExecucaoRoberloBases }

procedure TGravandoExecucaoRoberloBases.Executar(const gravando: IGravando);
Var
  qryDestino: IDataSet;
  OleExcel, OleSheet: OleVariant;
  intContador, intTamExcel: Integer;
begin
  Try
    Try
      Gravando.Texto := 'Verificando Path...';

      If Not VerificaPath Then
      Begin
        Gravando.Texto := Format('o arquivo %s não foi encontrado! Rever Configurações.', [AnsiReplaceStr(GetPath, '"', '')]);
        Exit;
      End;

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('ROB_CADBAS');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      Gravando.Texto := 'Carregando Dados...';
      OleExcel := CreateOleObject('Excel.Application');
      OleExcel.Visible := False;
      OleExcel.WorkBooks.Open(GetPath);
      OleSheet := OleExcel.WorkBooks[1].WorkSheets['Hoja nº1'];
      intTamExcel := OleSheet.Cells.SpecialCells(11).Row;
      qryDestino := GetDataSetDestino;


      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Processando Dados...';
      Gravando.RegistrarProgresso(0, 0, 0);

      Try
        Try
          For intContador := 2 To intTamExcel Do
          Begin

            If (Gravando.Status <> sgGravando) Then
              Break;

            If Not IsRegistroExistente(qryDestino, OleSheet, intContador) Then
              GravarRegistro(qryDestino, OleSheet, intContador);

            Gravando.RegistrarProgresso(0, intContador, intTamExcel);
          End;
        Except
          On E: Exception Do
          Begin
            Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
            Gravando.Cancelar;
          End;
        End;
      Finally
        If Not VarIsEmpty(OleExcel) Then
        Begin
          OleExcel.Quit;
          OleExcel := Unassigned;
          OleSheet := Unassigned;
        End;
      End;

    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        Gravando.Cancelar;
      End;
    End;
  Finally
  End;
end;

function TGravandoExecucaoRoberloBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TGravandoExecucaoRoberloBases.fQtdEmbalagemMl(
  strEmbalagem: String): String;
begin
  Result := Trim(strEmbalagem) + ' ML';
end;

function TGravandoExecucaoRoberloBases.fRetEmbalagem(strEmb: String): Double;
begin
  Result := 0;

  If strEmb = '1L' Then
    Result := 1000
  Else If strEmb = '3,5L' Then
    Result := 3500
  Else If strEmb = '3,5L o 1L' Then
    Result := 3500
  Else If strEmb = '0,5L' Then
    Result := 500
  Else If strEmb = '1L o 5L' Then
    Result := 1000;
end;

function TGravandoExecucaoRoberloBases.GetSqlDestino: String;
begin
  Result := '   SELECT * FROM ROB_CADBAS      ';
end;

function TGravandoExecucaoRoberloBases.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): String;
begin
  Result := '';
  Result := Result + '  SELECT                    ';
  Result := Result + '    [CODI] AS [BASE],       ';
  Result := Result + '    [NOM]  AS [NOME],       ';
  Result := Result + '    [SUBTIPUS] AS [TIPO],   ';
  Result := Result + '    [DENSITAT] AS [PESO],   ';
  Result := Result + '    [ENVÀS PREDEFINIT] AS [EMBALAGEM]    ';
  Result := Result + '  FROM                      ';
  Result := Result + '    [Hoja nº1$]              ';
end;

procedure TGravandoExecucaoRoberloBases.GravarRegistro(qryDestino: IDataSet; Excel: Variant; Linha: Integer);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ROB_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('BAS_CODBAS').AsString := Excel.Cells[Linha, 3].Text;
  qryDestino.FieldByName('BAS_DESCRI').AsString := Excel.Cells[Linha, 4].Text;
  qryDestino.FieldByName('BAS_PESESP').AsFloat  := Excel.Cells[Linha, 6].Text;
  qryDestino.FieldByName('BAS_TIPBAS').AsString := Excel.Cells[Linha, 5].Text;
  qryDestino.FieldByName('BAS_EMBALA').AsFloat  := fRetEmbalagem(Excel.Cells[Linha, 10].Text);
  qryDestino.FieldByName('BAS_QTDEMB').AsString := AnsiReplaceStr(fQtdEmbalagemMl(FloatToStrF(qryDestino.FieldByName('BAS_EMBALA').AsFloat, ffNumber, 12, 0)), '.', '');
  qryDestino.Post;
end;

function TGravandoExecucaoRoberloBases.IsRegistroExistente(qryDestino: IDataSet; Excel: Variant; Linha: Integer): Boolean;
begin
  Result := qryDestino.Locate('BAS_CODBAS', VarArrayOf([Excel.Cells[Linha, 3].Text]), []);
end;

end.
