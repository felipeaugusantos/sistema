{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta RennerImobiliaria *}
{***************************************************************************PH*}
unit untGravandoExecucaoRennerImobiliariaColorantes;

interface

uses
  untAbstractGravandoExecucaoRennerImobiliaria, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, Dialogs, StrUtils, untStrUtils,
  Variants;
type
  TGravandoExecucaoRennerImobiliariaColorantes = class(TAbstractGravandoExecucaoRennerImobiliaria)
  private
    procedure pProcessarCadCol(registroRenner: TRegistroRennerImobiliaria);
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

{ TGravandoExecucaoRennerImobiliariaCores }

procedure TGravandoExecucaoRennerImobiliariaColorantes.Executar(const gravando: IGravando);
var
  strNomArq : String;
  intLinha,
  intLinhas : Integer;
  strLinha  : String;
  intCont: Integer;
begin
  Try
    Try
      gravando.Texto := 'Validando Path de Arquivos ...';

      If (Not fValidaPath) Then
      Begin
        gravando.Texto := 'Path para a geração do arquivo de colorantes não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      gravando.Texto := 'Path validado com sucesso ...';

      If stlArquivos.Count <= 0 Then
      Begin
        gravando.Texto := 'Path para o geração do arquivo de colorantes está vazio...';
        gravando.Cancelar;
        Exit;
      End;

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('REI_CADCOL');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      qryCadCol := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadCol.SQL := 'SELECT * FROM REI_CADCOL';
      qryCadCol.Open;

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Iniciando Geração do Cadastro de Colorantes ...';

      For intCont := 0 To stlArquivos.Count - 1 Do
      Begin
        Try
          Try
            if gravando.Status <> sgGravando then
              Exit;

            If (Pos('Tabela', stlArquivos.Strings[intCont]) > 0) Then
              Continue;

            strNomArq := stlArquivos.Strings[intCont];

            intLinhas := fContaLinhas(strNomArq);

            AssignFile(arqRenner, strNomArq);
            Reset(arqRenner);

            intLinha := 1;

            gravando.Texto := 'Iniciando processo de gravação do arquivo...' + strNomArq;

            While Not Eof(arqRenner) Do
            Begin
              Readln(arqRenner, strLinha);
              registroRenner := fGetRegistro(AnsiReplaceStr(strLinha, ';', ''));

              If Trim(registroRenner.IdSeq) = 'IdSeq' Then
                Continue;

              if gravando.Status <> sgGravando then
                Exit;

              pProcessarCadCol(registroRenner);

              gravando.RegistrarProgresso(0, intLinha, intLinhas);
              intLinha := intLinha + 1;
            End;
          Except
            on E: Exception do
            begin
              gravando.Cancelar;
              gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
            End;
          End;
        Finally
          gravando.Texto := 'Finalizado o processo de gravação do arquivo...' + strNomArq;
        End;
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

function TGravandoExecucaoRennerImobiliariaColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;

procedure TGravandoExecucaoRennerImobiliariaColorantes.pProcessarCadCol(
  registroRenner: TRegistroRennerImobiliaria);
  Var
    intCont: Integer;
begin
  For intCont := 1 To 5 Do
  Begin
    If (Not TStrUtils.fEmptyStr(fGetString(registroRenner.Corante[intCont])))
      And (Not qryCadCol.Locate('COL_CODCOL', fGetString(registroRenner.Corante[intCont]), [])) Then
    Begin
      qryCadCol.Insert;
      qryCadCol.FieldByName('COL_CODCOL').AsString := fGetString(registroRenner.Corante[intCont]);
      qryCadCol.FieldByName('COL_EMBALA').AsFloat  := 946;
      qryCadCol.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
      qryCadCol.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('REI_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
      qryCadCol.Post;
    End;
  End;
end;

end.

