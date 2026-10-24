{**********************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta International *}
{*******************************************************************************AC*}
unit untGravandoExecucaoInternationalBases;

interface

uses
  untAbstractGravandoExecucaoInternational, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils,
  untFloatUtils;

type
  TGravandoExecucaoInternationalBases = class(TAbstractGravandoExecucaoInternational)
  private
    function fRetCodEmbalagem(strFator:String):String;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses untStrUtils;
{ TGravandoExecucaoInternationalBases }

procedure TGravandoExecucaoInternationalBases.Executar(const gravando: IGravando);
var
  qryAdoBases: TADOQuery;
  qryCadBas: IDataSet;
begin
  Try
    Try
      Gravando.Texto := 'Validando path do arquivo...';

      If Not fValidaPath Then
      Begin
        gravando.Texto := Format('O arquivo %s não existe',[AnsiReplaceStr(GetPath, '"', '')]);
        Gravando.Cancelar;
      End;

      Gravando.Texto := 'Path validado com sucesso...';

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Carregando dados do Cadastro de Bases...';
      qryAdoBases := TADOQuery.Create(Nil);
      qryAdoBases.Connection := fGetAcessInternational(GetPath);
      qryAdoBases.Close;
      qryAdoBases.SQL.Clear;
      qryAdoBases.SQL.Text := '   SELECT * FROM Production_History ORDER BY Base';
      qryAdoBases.Open;

      Gravando.Texto := 'Deletando Cadastro de Bases...';
      qryCadBas := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadBas.SQL := '    DELETE FROM INT_CADBAS    ';
      qryCadBas.ExecSQL;
      Gravando.Texto := 'Cadastro de Bases deletado...';
      qryCadBas.SQL.Empty;

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('INT_CADBAS');
      Gravando.Texto := 'PROCOD verificado com sucesso...';


      Gravando.Texto := 'Abrindo Cadastro de Bases...';
      qryCadBas.SQL := '    SELECT * FROM INT_CADBAS WHERE FALSE    ';
      qryCadBas.Open;

      Gravando.Texto := Format('Processando arquivo [%s]', [AnsiReplaceStr(GetPath, '"', '')]);
      Gravando.RegistrarProgresso(0, 0, 0);

      Try
        While Not qryAdoBases.Eof Do
        Begin
          If Not qryCadBas.Locate('BAS_CODBAS;BAS_CODEMB', VarArrayOf([qryAdoBases.FieldByName('Base').AsString,
            fRetCodEmbalagem(FloatToStr(TFloatUtils.fFormataFloat(qryAdoBases.FieldByName('Vasilhame').AsFloat, 2)))]), []) Then
          Begin

            If (Gravando.Status <> sgGravando) Then
              Break;

            qryCadBas.Insert;
            qryCadBas.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('INT_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
            qryCadBas.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
            qryCadBas.FieldByName('BAS_CODBAS').AsString := qryAdoBases.FieldByName('Base').AsString;
            qryCadBas.FieldByName('BAS_CODEMB').AsString := fRetCodEmbalagem(FloatToStr(TFloatUtils.fFormataFloat(qryAdoBases.FieldByName('Vasilhame').AsFloat, 2)));
            qryCadBas.FieldByName('BAS_PRECUS').AsFloat  := 0.0000;
            qryCadBas.FieldByName('BAS_PREVEN').AsFloat  := 0.0000;
            qryCadBas.FieldByName('BAS_MARGEM').AsFloat  := 0.0000;
            qryCadBas.Post;
          End;
          qryAdoBases.Next;
          Gravando.RegistrarProgresso(0, qryAdoBases.RecNo, qryAdoBases.RecordCount);
        End;
      Except
        On E: Exception Do
        Begin
          Gravando.Cancelar;
          Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        End;

      End;

    Except
      On E: Exception Do
      Begin
        Gravando.Cancelar;
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;

    End;
  Finally
    Gravando.Texto := 'Cadastro de Bases processado com sucesso!';
  End;
end;

function TGravandoExecucaoInternationalBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;


function TGravandoExecucaoInternationalBases.fRetCodEmbalagem(
  strFator: String): String;
begin
  If strFator = '3,6' Then
    Result := '1'
  Else if strFator = '20' Then
    Result := '2'
  Else
    Result := '3';
end;

end.
