{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta Dacar   *}
{***************************************************************************AC*}
unit untGravandoExecucaoDacarColorantes;

interface

uses
  untAbstractGravandoExecucaoDacar, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, untStatusGravando, DB, Classes, StrUtils,
  Variants;

type
  TGravandoExecucaoDacarColorantes = class(TAbstractGravandoExecucaoDacar)
  Public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses untStrUtils;

{ TGravandoExecucaoDacarCores }

procedure TGravandoExecucaoDacarColorantes.Executar(const gravando: IGravando);
Var
  qryCadCol    : IDataSet;
  strPath      : String;
  slArquivo    : TStringList;
  slQuebraLinha: TStringList;
  intCont      : integer;
  intProcesso  : Integer;
  strCodigo    : String;
begin
  Try
    Try
      strPath := fGetNomeArquivo;

      If Not FileExists(strPath) Then
      Begin
        gravando.Texto := 'O arquivo para geração não foi encontrado!';
        gravando.Cancelar;
      End;

      if (gravando.Status <> sgGravando) then
        Exit;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('DAC_CADCOL');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      gravando.Texto := 'Abrindo o cadastro de colorantes';

      qryCadCol := TAutcomTintaFactory.Get.fGetDataSet;

      slArquivo     := TStringList.Create;
      slQuebraLinha := TStringList.Create;

      slArquivo.LoadFromFile(strPath);
      intProcesso   := 0;

      qryCadCol.SQL := 'DELETE FROM DAC_CADCOL; ';
      qryCadCol.ExecSQL;

      For intCont := 0 to slArquivo.Count - 1 do
      Begin
        if gravando.Status <> sgGravando then
          Exit;

        slQuebraLinha.Delimiter := ';';
        slQuebraLinha.StrictDelimiter := True;
        slQuebraLinha.DelimitedText := slArquivo[intCont];

        If (intCont > 0) Then
        Begin
          strCodigo := UpperCase(slQuebraLinha[7]);

          qryCadCol.SQL := 'SELECT * '+
                           '  FROM DAC_CADCOL '+
                           ' WHERE COL_CODCOL =:CODIGO';
          qryCadCol.ParamByName('CODIGO').AsString :=  strCodigo;
          qryCadCol.Open;

          IF (qryCadCol.IsEmpty)Then
          Begin
            qryCadCol.Insert;
            qryCadCol.FieldByName('AUTOINCREM').AsString  := TAutcomTintaFactory.Get.fRetAutoIncrem('DAC_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
            qryCadCol.FieldByName('COL_CODEMP').AsString  := TAutcomTintaFactory.Get.GetCodEmp;
            qryCadCol.FieldByName('COL_CODCOL').AsString  := strCodigo;
            qryCadCol.FieldByName('DAC_EMBALA').AsFloat   := 946.00;
            qryCadCol.Post;
          End;

        End;

        Inc(intProcesso);
        gravando.RegistrarProgresso(0, intProcesso, slArquivo.Count);
      End;

    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        gravando.Cancelar;
      end;
    End;
  Finally
    If Assigned(slQuebraLinha) Then
      FreeAndNil(slQuebraLinha);

    If Assigned(slArquivo) Then
      FreeAndNil(slArquivo);
  End;
end;

function TGravandoExecucaoDacarColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;



end.

