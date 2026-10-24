{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta Maestria *}
{**********************************************************************PH*}
unit untGravandoExecucaoMaestriaCores;

interface

uses
  untAbstractGravandoExecucaoMaestria, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils,
  System.Win.ComObj;

type
  TGravandoExecucaoMaestriaCores = class(TAbstractGravandoExecucaoMaestria)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function GetSqlDestino(): string; override;
    function GetSqlOrigem(const strNomeArquivo: string;
      const stlTabelas: TStrings): string; override;
  end;

Implementation

uses
  untFuncoesGenerica, untStrUtils, untDefinicaoTxtCampoTipo, untADOTxtFactory, untGenericDefinicaoTxtCampo, untGenericDefinicaoTxt,
    untIDefinicaoTxtCampo, untIDefinicaoTxt, untDefinicaoTxtCharacterSet;


{ TGravandoExecucaoMaestriaCores }

procedure TGravandoExecucaoMaestriaCores.Executar(const gravando: IGravando);
var
  slArquivo    : TStringList;
  qryCadCor    : IDataSet;
  intCont      : integer;
  intProcesso  : Integer;
  slQuebra     : TStringList;
  intArquivos  : Integer;
  strMd5       : String;
  intColorante,
  intQuantidade: Integer;
  intRegistro  : Integer;
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

      qryCadCor := TAutcomTintaFactory.Get.fGetDataSet;
      Gravando.Texto := 'Deletando Registros MAE_CADMAE...';
      qryCadCor.Close;
      qryCadCor.SQL := '  DELETE FROM MAE_CADMAE    ';
      qryCadCor.ExecSQL;
      Gravando.Texto := 'Registros deletados com sucesso...';


      gravando.Texto := 'Arquivo Validado com Sucesso ...';
      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('MAE_CADMAE');
      gravando.Texto := 'PROCOD verificado com sucesso!';
      gravando.Texto := 'Iniciando Geração do Cadastro de Cores...';

      qryCadCor.Close;
      qryCadCor.SQL := 'SELECT * '+
                       '  FROM MAE_CADMAE ';
      qryCadCor.Open;

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

          If intCont > 0 Then
          Begin
            Begin
              qryCadCor.Insert;
              qryCadCor.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('MAE_CADMAE', TAutcomTintaFactory.Get.GetCodEmp);
              qryCadCor.FieldByName('MAE_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
              qryCadCor.FieldByName('MAE_CODIGO').AsString := slQuebra[1];
              qryCadCor.FieldByName('MAE_CODBAS').AsString := slQuebra[3];
              qryCadCor.FieldByName('MAE_NOMCOR').AsString := slQuebra[23];
              qryCadCor.FieldByName('MAE_PRODUT').AsString := slQuebra[5];
              qryCadCor.FieldByName('MAE_UNIDAD').AsString := fRetCodUnidade(StrToFloat(slQuebra[4]));
              qryCadCor.FieldByName('MAE_COLECA').AsString := slQuebra[17];
              qryCadCor.FieldByName('MAE_DESCRI').AsString := slQuebra[16];
              qryCadCor.FieldByName('MAE_EMBALA').AsFloat  := StrToFloat(slQuebra[4]);
              qryCadCor.FieldByName('MAE_ATIVAD').AsString := 'S';

              strMd5 := qryCadCor.FieldByName('MAE_CODIGO').AsString +
                        qryCadCor.FieldByName('MAE_NOMCOR').AsString +
                        qryCadCor.FieldByName('MAE_CODBAS').AsString +
                        qryCadCor.FieldByName('MAE_PRODUT').AsString +
                        qryCadCor.FieldByName('MAE_UNIDAD').AsString +
                        qryCadCor.FieldByName('MAE_COLECA').AsString;

              intColorante  := 6;
              intQuantidade := 11;

              For intRegistro := 1 To 5 Do
              Begin
                If TStrUtils.fEmptyStr(slQuebra[intColorante]) Then
                  Break;

                qryCadCor.FieldByName('MAE_FORM' + TStrUtils.fStrZero(intRegistro, 2)).AsString := slQuebra[intColorante];
                qryCadCor.FieldByName('MAE_QTDC' + TStrUtils.fStrZero(intRegistro, 2)).AsFloat  := StrToFloat(slQuebra[intQuantidade]);

                strMd5 := strMd5 + qryCadCor.FieldByName('MAE_FORM' + TStrUtils.fStrZero(intRegistro, 2)).AsString;
                strMd5 := strMd5 + qryCadCor.FieldByName('MAE_QTDC' + TStrUtils.fStrZero(intRegistro, 2)).AsString;

                Inc(intColorante, 1);
                Inc(intQuantidade, 1);
              End;

              qryCadCor.FieldByName('MAE_MD5KEY').AsString := GetMD5(strMd5);
              qryCadCor.Post;
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

function TGravandoExecucaoMaestriaCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;


function TGravandoExecucaoMaestriaCores.GetSqlDestino: string;
begin
  Result := '';
end;

function TGravandoExecucaoMaestriaCores.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '';
end;

end.

