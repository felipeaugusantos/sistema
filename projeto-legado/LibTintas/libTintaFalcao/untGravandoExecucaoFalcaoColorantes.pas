{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta falcão*}
{***************************************************************************PH*}
unit untGravandoExecucaoFalcaoColorantes;

interface

uses
  untAbstractGravandoExecucaoFalcao, untIGravando, SysUtils, untIDataSet,System.Classes,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, Dialogs, StrUtils, untStrUtils,
  Variants;
type
  TGravandoExecucaoFalcaoColorantes = class(TAbstractGravandoExecucaoFalcao)
  private
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

{ TGravandoExecucaoFalcaoColorantes}

procedure TGravandoExecucaoFalcaoColorantes.Executar(const gravando: IGravando);
var
  slArquivo    : TStringList;
  slQuebraLinha: TStringList;
  qryCadCol    : IDataSet;
  intCont      : integer;
  intProcesso  : Integer;
begin
  Try
    Try
      gravando.Texto := 'Validando Arquivo de Geração...';

      If Not DirectoryExists(GetPath)  Then
      Begin
        gravando.Texto := 'Arquivo para a geração dos Colorantes não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      gravando.Texto := 'Arquivo Validado com Sucesso ...';

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('FAL_CADCOL');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Iniciando Geração do Cadastro de Colorantes...';

      slArquivo     := TStringList.Create;
      slQuebraLinha := TStringList.Create;

      slArquivo.LoadFromFile(GetPath + '\CORANTES.txt');

      intProcesso := 0;

      for intCont := 0 to slArquivo.Count - 1 do
      begin
        if gravando.Status <> sgGravando then
          Exit;

        slQuebraLinha.Delimiter := '|';
        slQuebraLinha.StrictDelimiter := True;
        slQuebraLinha.DelimitedText := slArquivo[intCont];

        qryCadCol := TAutcomTintaFactory.Get.fGetDataSet;
        qryCadCol.SQL := 'SELECT * '+
                         '  FROM FAL_CADCOL '+
                         ' WHERE COL_CODCOL = :CODCOL ';
        qryCadCol.ParamByName('CODCOL').AsString := slQuebraLinha[0];
        qryCadCol.Open;

        If (qryCadCol.IsEmpty) Then
        Begin
          qryCadCol.Insert;
          qryCadCol.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('FAL_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadCol.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadCol.FieldByName('COL_CODCOL').AsString := slQuebraLinha[0];
          qryCadCol.FieldByName('COL_PESESP').AsFloat  := strToFloatDef(AnsiReplaceStr(slQuebraLinha[1], '.', ','),0);
          qryCadCol.FieldByName('COL_EMBALA').AsFloat  := 900;
          qryCadCol.Post;
        End;

        Inc(intProcesso);
        gravando.RegistrarProgresso(0, intProcesso, slArquivo.Count);
      End;

    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally
  End;
end;

function TGravandoExecucaoFalcaoColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;

end.

