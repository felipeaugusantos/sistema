{******************************************************************************}
{* Classe responsável pela geração do cadastro de Cores da tinta falcão*}
{***************************************************************************PH*}
unit untGravandoExecucaoAutoluksCores;

interface

uses
  untAbstractGravandoExecucaoAutoluks, untIGravando, SysUtils, untIDataSet,System.Classes,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, Dialogs, StrUtils, untStrUtils,
  Variants;
type
  TGravandoExecucaoAutoluksCores = class(TAbstractGravandoExecucaoAutoluks)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function fRetCodMontadora(strDescricao : String) : String;
  end;

implementation

{ TGravandoExecucaoAutoluksCores}

uses untFuncoesGenerica;

procedure TGravandoExecucaoAutoluksCores.Executar(const gravando: IGravando);
var
  slArquivo    : TStringList;
  slQuebraLinha: TStringList;
  qryCadCor    : IDataSet;
  intCont      : integer;
  intProcesso  : Integer;
  intQtd: Integer;
  intQIndex    : Integer;
  fltQtdMl     : Double;
  intArquivos: Integer;
begin
  Try
    Try
      gravando.Texto := 'Validando Arquivo de Geração...';

      If Not DirectoryExists(GetPath)  Then
      Begin
        gravando.Texto := 'Arquivo para a geração dos Cores não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      gravando.Texto := 'Arquivo Validado com Sucesso ...';

      qryCadCor := TAutcomTintaFactory.Get.fGetDataSet;

      Gravando.Texto := 'Deletando Registros ALK_CADALK...';
      qryCadCor.Close;
      qryCadCor.SQL := '  DELETE FROM ALK_CADALK    ';
      qryCadCor.ExecSQL;
      Gravando.Texto := 'Registros deletado com sucesso...';

      qryCadCor.Close;
      qryCadCor.SQL := 'SELECT * FROM ALK_CADALK WHERE FALSE  ';
      qryCadCor.Open;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('ALK_CADALK');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      gravando.Texto := 'Iniciando Geração do Cadastro de Cores...';

      For intArquivos := 0 To stlPaths.Count - 1 Do
      Begin
        slArquivo     := TStringList.Create;
        slQuebraLinha := TStringList.Create;

        slArquivo.LoadFromFile(GetPath + '\' + stlPaths[intArquivos]);

        intProcesso := 0;

        For intCont := 0 to slArquivo.Count - 1 do
        Begin
          if gravando.Status <> sgGravando then
            Exit;

          slQuebraLinha.Delimiter := ';';
          slQuebraLinha.StrictDelimiter := True;
          slQuebraLinha.DelimitedText := slArquivo[intCont];

          If (intCont > 0) Then
          Begin
            qryCadCor.Insert;
            qryCadCor.FieldByName('AUTOINCREM').AsString  := TAutcomTintaFactory.Get.fRetAutoIncrem('ALK_CADALK', TAutcomTintaFactory.Get.GetCodEmp);
            qryCadCor.FieldByName('ALK_CODEMP').AsString  := TAutcomTintaFactory.Get.GetCodEmp;
            qryCadCor.FieldByName('ALK_DTACAD').AsDate    := Date;
            qryCadCor.FieldByName('ALK_CODIGO').AsString  := TrimRight(slQuebraLinha[1]);
            qryCadCor.FieldByName('ALK_DESCRI').AsString  := TrimRight(slQuebraLinha[2]);
            qryCadCor.FieldByName('ALK_PRODUT').AsString  := TrimRight(slQuebraLinha[4]);
            qryCadCor.FieldByName('ALK_ACABAM').AsString  := TrimRight(slQuebraLinha[5]);
            qryCadCor.FieldByName('ALK_VARIAN').AsString  := TrimRight(slQuebraLinha[6]);
            qryCadCor.FieldByName('ALK_CORMON').AsString  := slQuebraLinha[7];
            qryCadCor.FieldByName('ALK_CODMON').AsString  := fRetCodMontadora(TrimRight(slQuebraLinha[8]));
            qryCadCor.FieldByName('ALK_PAIS__').AsString  := TrimRight(slQuebraLinha[9]);

            qryCadCor.FieldByName('ALK_ANOINI').AsString  := slQuebraLinha[10];
            qryCadCor.FieldByName('ALK_ANOFIN').AsString  := slQuebraLinha[11];
            qryCadCor.FieldByName('ALK_VOLUME').AsFloat   := TAutcomTintaFactory.Get.fStrToFloat(slQuebraLinha[13]) * 1000;
            qryCadCor.FieldByName('ALK_GRAMA_').AsFloat   := TAutcomTintaFactory.Get.fStrToFloat(slQuebraLinha[14]);
            qryCadCor.FieldByName('ALK_ATIVAD').AsString  := 'S';
            // BASES
            qryCadCor.FieldByName('ALK_BASE01').AsString  := Trim(slQuebraLinha[15]);
            qryCadCor.FieldByName('ALK_BASE02').AsString  := Trim(slQuebraLinha[16]);
            qryCadCor.FieldByName('ALK_BASE03').AsString  := Trim(slQuebraLinha[17]);
            qryCadCor.FieldByName('ALK_BASE04').AsString  := Trim(slQuebraLinha[18]);
            qryCadCor.FieldByName('ALK_BASE05').AsString  := Trim(slQuebraLinha[19]);
            qryCadCor.FieldByName('ALK_BASE06').AsString  := Trim(slQuebraLinha[20]);
            qryCadCor.FieldByName('ALK_BASE07').AsString  := Trim(slQuebraLinha[21]);
            qryCadCor.FieldByName('ALK_BASE08').AsString  := Trim(slQuebraLinha[22]);
            qryCadCor.FieldByName('ALK_BASE09').AsString  := Trim(slQuebraLinha[23]);
            qryCadCor.FieldByName('ALK_BASE10').AsString  := Trim(slQuebraLinha[24]);
            qryCadCor.FieldByName('ALK_BASE11').AsString  := Trim(slQuebraLinha[25]);
            qryCadCor.FieldByName('ALK_BASE12').AsString  := Trim(slQuebraLinha[26]);
            qryCadCor.FieldByName('ALK_BASE13').AsString  := Trim(slQuebraLinha[27]);
            qryCadCor.FieldByName('ALK_BASE14').AsString  := Trim(slQuebraLinha[28]);
            qryCadCor.FieldByName('ALK_BASE15').AsString  := Trim(slQuebraLinha[29]);


            // QUANTIDADES

            intQIndex := 30;


            For intQtd := 1 To 15 Do
            Begin
              fltQtdMl :=  (TAutcomTintaFactory.Get.fStrToFloat(slQuebraLinha[intQIndex]));
              qryCadCor.FieldByName('ALK_QTDC' + TStrUtils.fStrZero(intQtd, 2)).AsFloat := fltQtdMl;

              Inc(intQIndex);
            End;

            qryCadCor.FieldByName('ALK_MD5KEY').AsString := GetMD5(qryCadCor.FieldByName('ALK_CODIGO').AsString +
                                                                   qryCadCor.FieldByName('ALK_DESCRI').AsString +
                                                                   qryCadCor.FieldByName('ALK_PRODUT').AsString +
                                                                   qryCadCor.FieldByName('ALK_ACABAM').AsString +
                                                                   qryCadCor.FieldByName('ALK_VARIAN').AsString +
                                                                   qryCadCor.FieldByName('ALK_CORMON').AsString +
                                                                   qryCadCor.FieldByName('ALK_ANOINI').AsString +
                                                                   qryCadCor.FieldByName('ALK_ANOFIN').AsString +
                                                                   qryCadCor.FieldByName('ALK_VOLUME').AsString +
                                                                   qryCadCor.FieldByName('ALK_GRAMA_').AsString);



            qryCadCor.Post;
          End;
          Inc(intProcesso);
          gravando.RegistrarProgresso(0, intProcesso, slArquivo.Count);
        End;

        FreeAndNil(slArquivo);
        FreeAndNil(slQuebraLinha);
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


function TGravandoExecucaoAutoluksCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoAutoluksCores.fRetCodMontadora(
  strDescricao: String): String;
Var
  qryCadMon : IDataSet;
begin
  qryCadMon := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadMon.SQL := 'SELECT MON_CODMON '+
                   '  FROM ALK_CADMON '+
                   ' WHERE MON_DESCRI = :DESCRI';
  qryCadMon.ParamByName('DESCRI').AsString := strDescricao;
  qryCadMon.Open;

  Result := qryCadMon.FieldByName('MON_CODMON').AsString;
end;

end.

