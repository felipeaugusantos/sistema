{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta Maestria *}
{***************************************************************************PH*}
unit untGravandoExecucaoMaestriaColorantes;

interface

uses
  untAbstractGravandoExecucaoMaestria, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils, ComObj, Math;
type
  TGravandoExecucaoMaestriaColorantes = class(TAbstractGravandoExecucaoMaestria)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function GetSqlDestino(): string; override;
    function GetSqlOrigem(const strNomeArquivo: string;
      const stlTabelas: TStrings): string; override;
  end;

implementation

uses untStrUtils, untDefinicaoTxtCampoTipo, untADOTxtFactory, untGenericDefinicaoTxtCampo, untGenericDefinicaoTxt,
    untIDefinicaoTxtCampo, untIDefinicaoTxt, untDefinicaoTxtCharacterSet;


{ TGravandoExecucaoMaestriaCores }


procedure TGravandoExecucaoMaestriaColorantes.Executar(const gravando: IGravando);
var
  slArquivo    : TStringList;
  qryCadCol    : IDataSet;
  intCont      : integer;
  intProcesso  : Integer;
  slQuebra     : TStringList;
  intArquivos  : Integer;
  intColorante : Integer;
  intIndex     : Integer;
begin
  Try
    Try
      gravando.Texto := 'Validando Arquivo de Geração...';

      If Not DirectoryExists(GetPath)  Then
      Begin
        gravando.Texto := 'Arquivo para a geração das bases não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      qryCadCol := TAutcomTintaFactory.Get.fGetDataSet;
      Gravando.Texto := 'Deletando Registros MAE_CADCOL...';
      qryCadCol.Close;
      qryCadCol.SQL := '  DELETE FROM MAE_CADCOL    ';
      qryCadCol.ExecSQL;
      Gravando.Texto := 'Registros deletados com sucesso...';


      gravando.Texto := 'Arquivo Validado com Sucesso ...';
      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('MAE_CADCOL');
      gravando.Texto := 'PROCOD verificado com sucesso!';
      gravando.Texto := 'Iniciando Geração do Cadastro de Colorantes...';

      qryCadCol.Close;
      qryCadCol.SQL := 'SELECT * '+
                       '  FROM MAE_CADCOL ';
      qryCadCol.Open;

      For intArquivos := 0 To stlPaths.Count - 1 Do
      Begin
        slArquivo     := TStringList.Create;
        slQuebra      := TStringList.Create;

        slArquivo.LoadFromFile(GetPath + '\' + stlPaths[intArquivos]);

        intProcesso := 0;



        for intCont := 0 to slArquivo.Count - 1 do
        begin
          if gravando.Status <> sgGravando then
            Exit;

          slQuebra.Delimiter := ';';
          slQuebra.StrictDelimiter := True;
          slQuebra.DelimitedText := slArquivo[intCont];

          intIndex := 6;

          If intCont > 0 Then
          Begin
            For intColorante := 1 To 5 Do
            Begin
              If Not qryCadCol.Locate('COL_CODCOL', VarArrayOf([slQuebra[intIndex]]), []) Then
              Begin
                If TStrUtils.fEmptyStr(slQuebra[intIndex]) Then
                  Break;

                qryCadCol.Insert;
                qryCadCol.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('MAE_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
                qryCadCol.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
                qryCadCol.FieldByName('COL_CODCOL').AsString := slQuebra[intIndex];
                qryCadCol.FieldByName('COL_DESCRI').AsString := slQuebra[intIndex];
                qryCadCol.FieldByName('COL_EMBALA').AsFloat  := 900;
                qryCadCol.Post;
              End;
              Inc(intIndex);
            End;
          End;
          Inc(intProcesso);
          gravando.RegistrarProgresso(0, intProcesso, slArquivo.Count);
        End;

        FreeAndNil(slArquivo);
        FreeAndNil(slQuebra);

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

function TGravandoExecucaoMaestriaColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;

function TGravandoExecucaoMaestriaColorantes.GetSqlDestino: string;
begin
  Result := '';
end;

function TGravandoExecucaoMaestriaColorantes.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '';
end;

end.

