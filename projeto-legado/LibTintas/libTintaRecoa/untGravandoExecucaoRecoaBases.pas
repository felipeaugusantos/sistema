{**********************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta Recoa *}
{*******************************************************************************AC*}
unit untGravandoExecucaoRecoaBases;

interface

uses
  untAbstractGravandoExecucaoRecoa, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, ComObj, Dialogs,
  StrUtils;

type
  TGravandoExecucaoRecoaBases = class(TAbstractGravandoExecucaoRecoa)
  var
    qryAdoBases: TADOQuery;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

{ TGravandoExecucaoRecoaBases }

procedure TGravandoExecucaoRecoaBases.Executar(const gravando: IGravando);
var
  qryCadBas: IDataSet;
  intUnidade: Integer;
const
  ArrayUnidade: Array[0..2] Of String = ('LT', 'GL', 'LA');
begin
  Try
    Try
      If Not FileExists(GetPath) Then
      Begin
        gravando.texto := Format('O arquivo %s não existe', [AnsiReplaceStr(GetPath, '"', '')]);
        gravando.Cancelar;
      End;

      If (gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Carregando Dados do Cadastro de Bases...';

      qryAdoBases := TADOQuery.Create(Nil);
      qryAdoBases.Connection := fConexaoRecoa;

      qryAdoBases.Close;
      qryAdoBases.SQL.Clear;
      qryAdoBases.SQL.Add('   SELECT    ');
      qryAdoBases.SQL.Add('     COD_BASE,    ');
      qryAdoBases.SQL.Add('     BASE,        ');
      qryAdoBases.SQL.Add('     PRODUTO      ');
      qryAdoBases.SQL.Add('   FROM BASES   ');
      qryAdoBases.SQL.Add('     ORDER BY COD_BASE     ');
      qryAdoBases.Open;

      qryCadBas := TAutcomTintaFactory.Get.fGetDataSet;
      Gravando.Texto := 'Deletando Cadastro de Bases...';
      qryCadBas.SQL := '    DELETE FROM REC_CADBAS    ';
      qryCadBas.ExecSQL;
      Gravando.Texto := 'Cadastro de Bases Deletado...';

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('REC_CADBAS');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      Gravando.Texto := 'Abrindo Cadastro de Bases...';
      qryCadBas.SQL.Empty;
      qryCadBas.SQL := '    SELECT * FROM REC_CADBAS    ';
      qryCadBas.Open;

      If (gravando.Status <> sgGravando) Then
        Exit;

      Gravando.texto := Format('Processando arquivo [%s]', [AnsiReplaceStr(GetPath, '"', '')]);
      Gravando.RegistrarProgresso(0, 0, 0);

      Try
        While Not qryAdoBases.Eof Do
        Begin
          For intUnidade := 0 To 2 Do
          Begin
            If (Gravando.Status <> sgGravando) Then
              Break;

            qryCadBas.Insert;
            qryCadBas.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('REC_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
            qryCadBas.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
            qryCadBas.FieldByName('BAS_BASE__').AsString := qryAdoBases.FieldByName('COD_BASE').AsString;
            qryCadBas.FieldByName('BAS_DESCRI').AsString := AnsiUpperCase(qryAdoBases.FieldByName('BASE').AsString);
            qryCadBas.FieldByName('BAS_PRODUT').AsString := qryAdoBases.FieldByName('PRODUTO').AsString;
            qryCadBas.FieldByName('BAS_UNIDAD').AsString := ArrayUnidade[intUnidade];
            qryCadBas.FieldByName('BAS_PRECUS').AsFloat := 0.00;
            qryCadBas.FieldByName('BAS_PREVEN').AsFloat := 0.00;
            qryCadBas.FieldByName('BAS_MARGEM').AsFloat := 0.00;
            qryCadBas.Post;
          End;
          qryAdoBases.Next;
          Gravando.RegistrarProgresso(0, qryAdoBases.RecNo, qryAdoBases.RecordCount);
        End;
      Except
        On E: Exception Do
        Begin
          gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        End;

      End;

    Except
      On  E: Exception Do
      Begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;

    End;
  Finally
    Gravando.Texto := 'Cadastro de Bases gerado com sucesso...';
  End;
end;

function TGravandoExecucaoRecoaBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;


end.
