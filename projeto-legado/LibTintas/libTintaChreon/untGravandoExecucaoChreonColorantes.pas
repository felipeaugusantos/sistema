{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta Chreon *}
{***************************************************************************PH*}
unit untGravandoExecucaoChreonColorantes;

interface

uses
  untAbstractGravandoExecucaoChreon, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils, ComObj, Math;
type
  TGravandoExecucaoChreonColorantes = class(TAbstractGravandoExecucaoChreon)
  Private
    procedure GravarColorantes(RegChreon: TRegistroChreon; qryColorantes: IDataSet);
    procedure DeletarColorantes(const Gravando: IGravando);
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses untStrUtils, untDefinicaoTxtCampoTipo, untADOTxtFactory, untGenericDefinicaoTxtCampo, untGenericDefinicaoTxt,
    untIDefinicaoTxtCampo, untIDefinicaoTxt, untDefinicaoTxtCharacterSet;

{ TGravandoExecucaoChreonCores }

procedure TGravandoExecucaoChreonColorantes.DeletarColorantes(
  const Gravando: IGravando);
Var
  qryGen: IDataSet;
begin
  Gravando.Texto := 'Deletando Registros CHR_CADCOL...';
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' DELETE FROM CHR_CADCOL  ';
  qryGen.ExecSQL;
  Gravando.Texto := 'Registros deletados com sucesso...';
end;

procedure TGravandoExecucaoChreonColorantes.Executar(const gravando: IGravando);
var
  intCont     : Integer;
  strNomArq   : String;
  intLinha,
  intLinhas   : Integer;
  strLinha    : String;
  qryDestino  : IDataSet;
begin
  Try
    Try
      Gravando.Texto := 'Validando Path de Arquivos ...';

      If (Not fValidaPath) Then
      Begin
        Gravando.Texto := 'Path para a geração do arquivo de colorantes não é válido...';
        Gravando.Cancelar;
        Exit;
      End;

      Gravando.Texto := 'Path validado com sucesso ...';

      If stlArquivos.Count <= 0 Then
      Begin
        Gravando.Texto := 'Path para o geração do arquivo de colorantes está vazio...';
        Gravando.Cancelar;
        Exit;
      End;

      If gravando.Status <> sgGravando Then
        Exit;

      DeletarColorantes(Gravando);

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('CHR_CADCOL');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      Gravando.Texto := 'Iniciando a Geração do Cadastro de Colorantes...';

      qryDestino := TAutcomTintaFactory.Get.fGetDataSet;
      qryDestino.SQL := ' SELECT * FROM CHR_CADCOL  ';
      qryDestino.Open;

      For intCont := 0 To stlArquivos.Count - 1 Do
      Begin
        If gravando.Status <> sgGravando Then
          Break;

        strNomArq := stlArquivos.Strings[intCont];
        intLinhas := fContaLinhas(strNomArq);
        AssignFile(arqChreon, strNomArq);
        Reset(arqChreon);
        intLinha := 1;

        While Not Eof(arqChreon) Do
        Begin
          Readln(arqChreon, strLinha);
          registroChreon := fGetRegistro(AnsiReplaceStr(strLinha, ';', ''));

          If Trim(registroChreon.RecordId) = 'RecordId' Then
            Continue;

          If gravando.Status <> sgGravando Then
            Exit;

          GravarColorantes(registroChreon, qryDestino);

          Gravando.RegistrarProgresso(0, intLinha, intLinhas);
          intLinha := intLinha + 1;
        End;
      End;
    Except
      On E: Exception Do
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
    End;
  Finally
  End;
end;

function TGravandoExecucaoChreonColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;


procedure TGravandoExecucaoChreonColorantes.GravarColorantes(
  RegChreon: TRegistroChreon; qryColorantes: IDataSet);
Var
  intCont: Integer;
begin
  For intCont := 1 To 5 Do
  Begin
    If Not qryColorantes.Locate('COL_CODCOL', fGetString(RegChreon.Tinter[intCont]), []) Then
    Begin
      If TStrUtils.fEmptyStr(fGetString(RegChreon.Tinter[intCont])) Then
        Continue;

      qryColorantes.Insert;
      qryColorantes.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('CHR_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
      qryColorantes.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
      qryColorantes.FieldByName('COL_CODCOL').AsString := fGetString(RegChreon.Tinter[intCont]);
      qryColorantes.FieldByName('COL_DESCRI').AsString := fGetString(RegChreon.Tinter[intCont]);
      qryColorantes.FieldByName('COL_EMBALA').AsFloat  := 1000;
      qryColorantes.Post;
    End;
  End;
end;

end.

