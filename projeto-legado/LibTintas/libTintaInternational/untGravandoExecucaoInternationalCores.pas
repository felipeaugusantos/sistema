{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta International *}
{**********************************************************************PH*}
unit untGravandoExecucaoInternationalCores;

interface

uses
  untAbstractGravandoExecucaoInternational, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils,
  untFloatUtils;

type
  TGravandoExecucaoInternationalCores = class(TAbstractGravandoExecucaoInternational)
  private
    function fRetCodEmbalagem(strFator:String):String;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

Implementation

uses
  untFuncoesGenerica, untStrUtils;

{ TGravandoExecucaoInternationalCores }

procedure TGravandoExecucaoInternationalCores.Executar(const gravando: IGravando);
var
  qryAdoCores: TADOQuery;
  qryCadInt: IDataSet;
  intContador:Integer;
  strSQL : String;
  strDesCor,
  strLinha:String;

begin
  Try
    Try
      Gravando.Texto := 'Validando path do arquivo...';

      If Not fValidaPath Then
      Begin
        Gravando.Texto := Format('O arquivo %s não existe',[AnsiReplaceStr(GetPath, '"', '')]);
        Gravando.Cancelar;
      End;

      Gravando.Texto := 'Path validado com sucesso...';

      strSQL := '';

      intContador := 1;

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Carregando dados do Cadastro de Cores...';
      qryAdoCores := TADOQuery.Create(Nil);
      qryAdoCores.Connection := fGetAcessInternational(GetPath);

      strSQL := strSQL + '  SELECT  ';
      strSQL := strSQL + '    A.Produto,    ';
      strSQL := strSQL + '    A.Base,       ';
      strSQL := strSQL + '    A.No_OB,    ';
      strSQL := strSQL + '    A.Vasilhame,    ';
      strSQL := strSQL + '    B.Corante,    ';
      strSQL := strSQL + '    B.Volume    ';
      strSQL := strSQL + '  FROM  ';
      strSQL := strSQL + '    Production_History A    ';
      strSQL := strSQL + '  INNER JOIN  ';
      strSQL := strSQL + '    Uso_Corante B ON    ';
      strSQL := strSQL + '  B.Produto = A.Produto  ';
      strSQL := strSQL + '    AND B.No_OB = A.No_OB   ';
      strSQL := strSQL + '  ORDER BY  A.Produto, A.No_OB    ';

      qryAdoCores.SQL.Text := strSQL;
      qryAdoCores.Open;

      Gravando.Texto := 'Deletando Cadastro de Cores...';
      qryCadInt := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadInt.SQL := '    DELETE FROM INT_CADINT    ';
      qryCadInt.ExecSQL;
      qryCadInt.SQL.Empty;
      Gravando.Texto := 'Cadastro de Cores deletado...';

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('INT_CADINT');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      Gravando.Texto := 'Abrindo Cadastro de Cores...';
      qryCadInt.SQL := '    SELECT * FROM INT_CADINT WHERE FALSE    ';
      qryCadInt.Open;

      Gravando.Texto := Format('Processando Arquivo [%s]', [AnsiReplaceStr(GetPath, '"', '')]);
      Gravando.RegistrarProgresso(0, 0, 0);


      Try
        While Not qryAdoCores.Eof Do
        Begin
          If ((strDesCor <> qryAdoCores.FieldByName('Produto').AsString) Or
            (strLinha <> qryAdoCores.FieldByName('No_OB').AsString)) Then
          Begin
            intContador := 1;

            strDesCor := qryAdoCores.FieldByName('Produto').AsString;
            strLinha  := qryAdoCores.FieldByName('No_OB').AsString;


            If (Gravando.Status <> sgGravando) Then
              Break;

            qryCadInt.Insert;
            qryCadInt.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('INT_CADINT', TAutcomTintaFactory.Get.GetCodEmp);
            qryCadInt.FieldByName('INT_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
            qryCadInt.FieldByName('INT_DESCOR').AsString := qryAdoCores.FieldByName('Produto').AsString;
            qryCadInt.FieldByName('INT_CODBAS').AsString := qryAdoCores.FieldByName('Base').AsString;
            qryCadInt.FieldByName('INT_CODEMB').AsString := fRetCodEmbalagem(FloatToStr(TFloatUtils.fFormataFloat(qryAdoCores.FieldByName('Vasilhame').AsFloat, 2)));
            qryCadInt.FieldByName('INT_LINHA_').AsString := qryAdoCores.FieldByName('No_OB').AsString;
            qryCadInt.FieldByName('INT_MD5KEY').AsString := GetMD5(qryCadInt.FieldByName('INT_DESCOR').AsString +
                                                                   qryCadInt.FieldByName('INT_CODBAS').AsString +
                                                                   qryCadInt.FieldByName('INT_CODEMB').AsString +
                                                                   qryCadInt.FieldByName('INT_LINHA_').AsString);
          End
          Else
          Begin
            If qryCadInt.Locate('INT_DESCOR;INT_LINHA_;INT_CODEMB', VarArrayOf([qryAdoCores.FieldByName('Produto').AsString,
              qryAdoCores.FieldByName('No_OB').AsString, fRetCodEmbalagem(FloatToStr(TFloatUtils.fFormataFloat(qryAdoCores.FieldByName('Vasilhame').AsFloat, 2)))]), []) Then
            qryCadInt.Edit
            Else
              Exit;
          End;


          If (TFloatUtils.fFormataFloat(qryAdoCores.FieldByName('Volume').AsFloat, 2) <= 0) Then
          Begin
            qryAdoCores.Cancel;
            qryAdoCores.Next;
            Continue;
          End;

          qryCadInt.FieldByName('INT_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString  :=
            qryAdoCores.FieldByName('Corante').AsString;
          qryCadInt.FieldByName('INT_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsString  :=
            FloatToStr(TFloatUtils.fFormataFloat(qryAdoCores.FieldByName('Volume').AsFloat, 2));

          Inc(intContador);
          qryCadInt.Post;
          qryAdoCores.Next;
          Gravando.RegistrarProgresso(0, qryAdoCores.RecNo, qryAdoCores.RecordCount);
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
  finally

  end;
end;

function TGravandoExecucaoInternationalCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;



function TGravandoExecucaoInternationalCores.fRetCodEmbalagem(
  strFator: String): String;
begin
  If strFator = '3,6' Then
    Result := '1'
  Else If strFator = '20' Then
    Result := '2'
  Else
    Result := '3';
end;

end.
