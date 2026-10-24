{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta falcão*}
{***************************************************************************PH*}
unit untGravandoExecucaoAutoluksBases;

interface

uses
  untAbstractGravandoExecucaoAutoluks, untIGravando, SysUtils, untIDataSet,System.Classes,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, Dialogs, StrUtils, untStrUtils,
  Variants;
type
  TGravandoExecucaoAutoluksBases = class(TAbstractGravandoExecucaoAutoluks)
  private
    function fQtdEmbalagemMl(strEmbalagem: String): String;
    procedure AcrescentarBaseDiluente();
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;

  end;

implementation

{ TGravandoExecucaoAutoluksBases}

procedure TGravandoExecucaoAutoluksBases.AcrescentarBaseDiluente;
Var
  qryGen: IDataSet;
begin
  Try
    //Deleta Formulas com "Espaço vazio"
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.Close;
    qryGen.SQL := 'DELETE FROM ALK_CADBAS WHERE BAS_CODBAS = ""';
    qryGen.ExecSQL;

    //Acrescenta Base Diluente
    qryGen.Close;
    qryGen.SQL := ' SELECT * FROM ALK_CADBAS  ';
    qryGen.Open;

    If qryGen.Locate('BAS_CODBAS', 'ATL000', []) Then
      Exit;

    qryGen.Insert;
    qryGen.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ALK_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
    qryGen.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
    qryGen.FieldByName('BAS_CODBAS').AsString := 'ATL000';
    qryGen.FieldByName('BAS_DESCRI').AsString := 'ATL000';
    qryGen.FieldByName('BAS_EMBALA').AsFloat  := 900;
    qryGen.FieldByName('BAS_QTDEMB').AsString := '900 ML';
    qryGen.FieldByName('BAS_PESESP').AsFloat  := 0;
    qryGen.Post;
  Except
    Raise;
  End;
end;

procedure TGravandoExecucaoAutoluksBases.Executar(const gravando: IGravando);
var
  slArquivo    : TStringList;
  qryCadBas    : IDataSet;
  intCont      : integer;
  intProcesso  : Integer;
  intBase      : Integer;
  intIndex     : Integer;
  slQuebra     : TStringList;
  intArquivos  : Integer;
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

      qryCadBas := TAutcomTintaFactory.Get.fGetDataSet;
      Gravando.Texto := 'Deletando Registros ALK_CADBAS...';
      qryCadBas.Close;
      qryCadBas.SQL := '  DELETE FROM ALK_CADBAS    ';
      qryCadBas.ExecSQL;
      Gravando.Texto := 'Registros deletados com sucesso...';


      gravando.Texto := 'Arquivo Validado com Sucesso ...';
      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('ALK_CADBAS');
      gravando.Texto := 'PROCOD verificado com sucesso!';
      gravando.Texto := 'Iniciando Geração do Cadastro de Bases...';

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

          IntIndex := 15;

          For intBase := 1 To 15 Do
          Begin
            qryCadBas.Close;
            qryCadBas.SQL := 'SELECT * '+
                             '  FROM ALK_CADBAS '+
                             ' WHERE BAS_CODBAS = :CODBAS ';
            qryCadBas.ParamByName('CODBAS').AsString := Trim(slQuebra[intIndex]);
            qryCadBas.Open;

            If (qryCadBas.IsEmpty) Then
            Begin
              If intCont > 0 Then
              Begin
                qryCadBas.Insert;
                qryCadBas.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ALK_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
                qryCadBas.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
                qryCadBas.FieldByName('BAS_CODBAS').AsString := Trim(slQuebra[intIndex]);
                qryCadBas.FieldByName('BAS_DESCRI').AsString := Trim(slQuebra[intIndex]);
                qryCadBas.FieldByName('BAS_PESESP').AsFloat  := 0;
                qryCadBas.FieldByName('BAS_EMBALA').AsFloat  := 900;
                qryCadBas.FieldByName('BAS_QTDEMB').AsString := AnsiReplaceStr(fQtdEmbalagemMl(FloatToStrF(qryCadBas.FieldByName('BAS_EMBALA').AsFloat, ffNumber, 12, 0)), '.', '');
                qryCadBas.Post;
              End;
            End;
            Inc(intIndex);
          End;

          Inc(intProcesso);
          gravando.RegistrarProgresso(0, intProcesso, slArquivo.Count);
        End;

        FreeAndNil(slArquivo);
        FreeAndNil(slQuebra);

      End;

      AcrescentarBaseDiluente();

    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally
  End;
end;

function TGravandoExecucaoAutoluksBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TGravandoExecucaoAutoluksBases.fQtdEmbalagemMl(
  strEmbalagem: String): String;
begin
  Result := Trim(strEmbalagem) + ' ML';
end;

end.

