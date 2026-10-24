{******************************************************************************}
{* Classe responsável pela geração do cadastro de Cores da tinta falcão*}
{***************************************************************************PH*}
unit untGravandoExecucaoAnjoAutomotivaCores;

interface

uses
  untAbstractGravandoExecucaoAnjoAutomotiva, untIGravando, SysUtils, untIDataSet,System.Classes,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, Dialogs, StrUtils, untStrUtils,
  Variants, Uni, PostgreSQLUniProvider, DB, untFloatUtils;

Type
  TFormulacao = Record
    FBaseFormula: String;
    FQtdeGFormula: Double;
    FQtdeMFormula: Double;
End;

type
  TGravandoExecucaoAnjoAutomotivaCores = class(TAbstractGravandoExecucaoAnjoAutomotiva)
  Private

    function fRetornaMontadora(qryCores: TUniQuery): String;

  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

{ TGravandoExecucaoAnjoAutomotivaCores}

uses untFuncoesGenerica;

procedure TGravandoExecucaoAnjoAutomotivaCores.Executar(const gravando: IGravando);
Var
  qryCadCor: IDataSet;
  qryCores: TUniQuery;
  qryMontadora: TUniQuery;
  qryFormulacao: TUniQuery;
  qryBases: TUniQuery;
  sSQL: String;
  AFormula: Array[01..20] Of TFormulacao;
  fltValorTotGramas: Double;
  fltDensidadeFormula: Double;
  fltIndiceVolume: Double;
  fltValTotMls: Double;
begin
  Try
    Try
      Gravando.Texto := 'Deletando Cadastro de Cores...';
      qryCadCor := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadCor.SQL := '  DELETE FROM AJT_CADAJT   ';
      qryCadCor.ExecSQL;
      Gravando.Texto := 'Cadastro de Cores deletado...';

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('AJT_CADAJT');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      Gravando.Texto := 'Abrindo Cadastro de Cores..';
      qryCadCor.SQL := '   SELECT * FROM AJT_CADAJT   ';
      qryCadCor.Open;

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Processando dados...';

      sSQL := '';
      sSQL := sSQL + ' SELECT                            ' +
                  '      for_id as ID_FORMULA,           ' +
                  '      for_codigo_anjo AS CODIGO,      ' +
                  '      for_descricao_cor as DESCRICAO, ' +
                  '      for_variante as VARIANTE,       ' +
                  '      aca_descricao as ACABAMENTO,    ' +
                  '      pro_descricao as PRODUTO,       ' +
                  '      for_ano_inicio as ANOINICIAL,   ' +
                  '      for_ano_fim as ANOFINAL,        ' +
                  '      for_montadora as MONTADORA,     ' +
                  '      for_codigo_oem  AS CORMON       ' +
                  '    FROM                              ' +
                  '      formula                         ' +
                  '    INNER JOIN produto ON             ' +
                  '      for_produto = pro_codigo        ' +
                  '    INNER JOIN acabamento ON          ' +
                  '      for_acabamento = aca_codigo     ';

      qryCores := TUniQuery.Create(Nil);
      qryCores.Connection := fConexaoPostgreSQL;
      qryCores.Close;
      qryCores.SQL.Clear;
      qryCores.SQL.Add(sSQL);
      qryCores.Open;
      qryCores.First;

      If qryCores.IsEmpty Then
      Begin
        Gravando.Texto := 'O cadastro de cores está vazio. Verificar!';
        Exit;
      End;


      sSQL := '';
      sSQL := ' SELECT mon_id, mon_codigo_reduzido, mon_descricao FROM montadora ';

      qryMontadora := TUniQuery.Create(Nil);
      qryMontadora.Connection := fConexaoPostgreSQL;
      qryMontadora.Close;
      qryMontadora.SQL.Clear;
      qryMontadora.SQL.Add(sSQL);
      qryMontadora.Open;
      qryMontadora.First;

      sSQL := '';
      sSQL := ' SELECT * FROM componente    ';

      qryBases := TUniQuery.Create(Nil);
      qryBases.Connection := fConexaoPostgreSQL;
      qryBases.Close;
      qryBases.SQL.Clear;
      qryBases.SQL.Add(sSQL);
      qryBases.Open;
      qryBases.First;


      qryFormulacao := TUniQuery.Create(Nil);
      qryFormulacao.Connection := fConexaoPostgreSQL;

      While Not qryCores.Eof Do
      Begin
        sSQL := '';
        sSQL := ' SELECT * FROM formula_composicao  WHERE frc_formula_id = :IDFORMULA ORDER BY frc_ordem ASC';

        qryFormulacao.Close;
        qryFormulacao.SQL.Clear;
        qryFormulacao.SQL.Add(sSQL);
        qryFormulacao.ParamByName('IDFORMULA').AsString := qryCores.FieldByName('ID_FORMULA').AsString;
        qryFormulacao.Open;
        qryFormulacao.First;

        fltValorTotGramas := 0;
        fltValTotMls := 0;

        While Not qryFormulacao.Eof Do
        Begin
          fltValorTotGramas := fltValorTotGramas + qryFormulacao.FieldByName('frc_gramas').AsFloat;
          qryFormulacao.Next;
        End;

        qryFormulacao.First;

        //Convertendo quantidades para 100mls e 100grms;
        While Not qryFormulacao.Eof Do
        Begin
          If Not qryBases.Locate('com_codigo', qryFormulacao.FieldByName('frc_componente').AsString, []) Then
          Begin
            Gravando.Texto := Format('Base não encontrada! Favor verificar [%s]', [qryFormulacao.FieldByName('frc_componente').AsString]);
            Break;
          End;

          AFormula[qryFormulacao.RecNo].FBaseFormula :=  qryFormulacao.FieldByName('frc_componente').AsString;
          AFormula[qryFormulacao.RecNo].FQtdeGFormula := TFloatUtils.fFormataFloat((qryFormulacao.FieldByName('frc_gramas').AsFloat / fltValorTotGramas) * 100, 2);   {100grms}
          AFormula[qryFormulacao.RecNo].FQtdeMFormula :=  TFloatUtils.fFormataFloat((AFormula[qryFormulacao.RecNo].FQtdeGFormula / qryBases.FieldByName('com_peso_especifico').AsFloat), 2); {100mls}
          fltValTotMls := fltValTotMls + AFormula[qryFormulacao.RecNo].FQtdeMFormula;

          qryFormulacao.Next;
        End;

        qryFormulacao.First;

        //Calculo Densidade da Fórmula
        fltDensidadeFormula := TFloatUtils.fFormataFloat(100 / fltValTotMls, 3);

        //Calculo Indice do Volume 1000 mls
        fltIndiceVolume := TFloatUtils.fFormataFloat(1000 * fltDensidadeFormula, 1);

        fltValorTotGramas := 0;


        //Convertendo formulas para 1000mls em gramas
        While Not qryFormulacao.Eof Do
        Begin
          AFormula[qryFormulacao.RecNo].FQtdeGFormula := TFloatUtils.fFormataFloat((AFormula[qryFormulacao.RecNo].FQtdeGFormula * fltIndiceVolume) / 100, 2);
          fltValorTotGramas := fltValorTotGramas +  AFormula[qryFormulacao.RecNo].FQtdeGFormula;
          qryFormulacao.Next;
        End;

        If Not qryMontadora.Locate('mon_descricao', fRetornaMontadora(qryCores), []) Then
        Begin
          Gravando.Texto := Format('montadora não encontrada! Favor verificar [%s]', [fRetornaMontadora(qryCores)]);
          Exit;
        End;

        qryCadCor.Insert;
        qryCadCor.FieldByName('AUTOINCREM').AsString  := TAutcomTintaFactory.Get.fRetAutoIncrem('AJT_CADAJT', TAutcomTintaFactory.Get.GetCodEmp);
        qryCadCor.FieldByName('AJT_CODEMP').AsString  := TAutcomTintaFactory.Get.GetCodEmp;
        qryCadCor.FieldByName('AJT_DTACAD').AsDate    := Date;
        qryCadCor.FieldByName('AJT_CODIGO').AsString  := Trim(qryCores.FieldByName('CODIGO').AsString);
        qryCadCor.FieldByName('AJT_DESCRI').AsString  := Trim(qryCores.FieldByName('DESCRICAO').AsString);
        qryCadCor.FieldByName('AJT_PRODUT').AsString  := Trim(qryCores.FieldByName('PRODUTO').AsString);
        qryCadCor.FieldByName('AJT_ACABAM').AsString  := Trim(qryCores.FieldByName('ACABAMENTO').AsString);
        qryCadCor.FieldByName('AJT_VARIAC').AsString  := Trim(qryCores.FieldByName('VARIANTE').AsString);
        qryCadCor.FieldByName('AJT_CODMON').AsString  := qryMontadora.FieldByName('mon_id').AsString;
        qryCadCor.FieldByName('AJT_CORMON').AsString  := qryCores.FieldByName('CORMON').AsString;
        qryCadCor.FieldByName('AJT_ANOINI').AsString  := qryCores.FieldByName('ANOINICIAL').AsString;
        qryCadCor.FieldByName('AJT_ANOFIM').AsString  := qryCores.FieldByName('ANOFINAL').AsString;
        qryCadCor.FieldByName('AJT_VOLUME').AsFloat   := 1000;
        qryCadCor.FieldByName('AJT_GRAMA_').AsFloat   := fltValorTotGramas;

        qryFormulacao.First;

        While Not qryFormulacao.Eof DO
        Begin
          qryCadCor.FieldByName('AJT_FORM' + TStrUtils.fStrZero(qryFormulacao.RecNo, 2)).AsString := AFormula[qryFormulacao.RecNo].FBaseFormula;
          qryCadCor.FieldByName('AJT_QTDC' + TStrUtils.fStrZero(qryFormulacao.RecNo, 2)).AsFloat := AFormula[qryFormulacao.RecNo].FQtdeGFormula;

          qryFormulacao.Next;
        End;

        qryCadCor.FieldByName('AJT_MD5KEY').AsString := GetMD5(qryCadCor.FieldByName('AJT_CODIGO').AsString +
                                                               qryCadCor.FieldByName('AJT_DESCRI').AsString +
                                                               qryCadCor.FieldByName('AJT_PRODUT').AsString +
                                                               qryCadCor.FieldByName('AJT_ACABAM').AsString +
                                                               qryCadCor.FieldByName('AJT_VARIAC').AsString +
                                                               qryCadCor.FieldByName('AJT_CODMON').AsString +
                                                               qryCadCor.FieldByName('AJT_CORMON').AsString +
                                                               qryCadCor.FieldByName('AJT_ANOINI').AsString +
                                                               qryCadCor.FieldByName('AJT_ANOFIM').AsString +
                                                               qryCadCor.FieldByName('AJT_VOLUME').AsString +
                                                               qryCadCor.FieldByName('AJT_GRAMA_').AsString);
        qryCadCor.Post;

        qryCores.Next;
        Gravando.RegistrarProgresso(0, qryCores.RecNo, qryCores.RecordCount);
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Cancelar;
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;
    End;
  Finally
    FreeAndNil(qryCores);
    FreeAndNil(qryMontadora);
    FreeAndNil(qryBases);
    FreeAndNil(qryFormulacao);
  End;
end;

function TGravandoExecucaoAnjoAutomotivaCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoAnjoAutomotivaCores.fRetornaMontadora(qryCores: TUniQuery): String;
begin
  Result := Trim(AnsiReplaceStr(qryCores.FieldByName('MONTADORA').AsString, '"', ''));

  If Trim(qryCores.FieldByName('MONTADORA').AsString) = 'GREAT WALL' Then
    Result := 'GREATWALL'
  Else If Trim(qryCores.FieldByName('MONTADORA').AsString) = 'DAF' Then
    Result := 'DAF CAMINHÕES';
end;

end.


