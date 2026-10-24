{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta RennerIndustrial *}
{**********************************************************************PH*}
unit untGravandoExecucaoRennerIndustrialCores;

interface

uses
  untAbstractGravandoExecucaoRennerIndustrial, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, untStrUtils, untStatusGravando, DB, StrUtils, ComObj,
  Variants, ADODB;

type
  TGravandoExecucaoRennerIndustrialCores = class(TAbstractGravandoExecucaoRennerIndustrial)
  private
    function fRetCodEmbalagem(strUnidade:String):String;
    procedure pDeletarMD5DuplicadoRenner(Gravando: IGravando);
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

Implementation

uses
  untFuncoesGenerica;

{ TGravandoExecucaoRennerIndustrialCores }

procedure TGravandoExecucaoRennerIndustrialCores.Executar(const gravando: IGravando);
Var
  qryAdoCadRen: TADOQuery;
  qryCadRen: IDataSet;
  intForm: Integer;
  intCodSeq: Integer;
  strCor,
  strBase,
  strCodigoPigmento: String;
  fltQtdPigmento:Double;
Const
  strUnid = 'GL';

  function fRetProximoCodSeq: Integer;
    Var
      qryGen: IDataSet;
  Begin
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := 'SELECT IFNULL(MAX(CONVERT(REN_CODSEQ,SIGNED)), 0) + 1 AS MAXIMO FROM REN_CADREN;';
    qryGen.Open;

    Result := qryGen.FieldByName('MAXIMO').AsInteger;
  End;

  function fQuantidadePigmento():Double;
  Begin
    Result := (qryAdoCadRen.FieldByName('Quant 01_1').AsFloat +
              ((qryAdoCadRen.FieldByName('Quant 01_2').AsFloat +
              (qryAdoCadRen.FieldByName('Quant 01_3').AsFloat * 0.5) +
              (qryAdoCadRen.FieldByName('Quant 01_4').AsFloat * 0.25) +
              (qryAdoCadRen.FieldByName('Quant 01_5').AsFloat * 0.125)) / 48)) * 29.57353;
  End;

begin
  Gravando.Texto := 'Validando path do arquivo...';

  If Not fValidaPath Then
  Begin
    Gravando.Texto := Format('O path % não existe!', [AnsiReplaceStr(GetPath, '"', '')]);
    Exit;
  End;

  Gravando.Texto := 'Path validado com sucesso...';

  If (Gravando.Status <> sgGravando) Then
    Exit;

  Gravando.Texto := 'Carregando dados do Cadastro de Fórmulas...';

  strCodigoPigmento := '';

  Try
    Try
      qryAdoCadRen := TADOQuery.Create(Nil);
      qryAdoCadRen.Connection := fGetDataCores(GetPath);

      qryAdoCadRen.SQL.Add(' SELECT                              ');
      qryAdoCadRen.SQL.Add('   Fórmulas."Código da Cor",         ');
      qryAdoCadRen.SQL.Add('   Fórmulas."Código da Base",        ');
      qryAdoCadRen.SQL.Add('   Fórmulas."Código do Pigmento",    ');
      qryAdoCadRen.SQL.Add('   Fórmulas."Quant 01_1",            ');
      qryAdoCadRen.SQL.Add('   Fórmulas."Quant 01_2",            ');
      qryAdoCadRen.SQL.Add('   Fórmulas."Quant 01_3",            ');
      qryAdoCadRen.SQL.Add('   Fórmulas."Quant 01_4",            ');
      qryAdoCadRen.SQL.Add('   Fórmulas."Quant 01_5",            ');
      qryAdoCadRen.SQL.Add('   Tintas."Código do Identificador", ');
      qryAdoCadRen.SQL.Add('   Cores."Descrição"                 ');
      qryAdoCadRen.SQL.Add(' FROM Fórmulas,                      ');
      qryAdoCadRen.SQL.Add('   Tintas,                           ');
      qryAdoCadRen.SQL.Add('   Cores                             ');
      qryAdoCadRen.SQL.Add(' WHERE Fórmulas."Código da Cor" = Tintas."Código da Cor"  ');
      qryAdoCadRen.SQL.Add(' AND Fórmulas."Código da Base" = Tintas."Código da Base"  ');
      qryAdoCadRen.SQL.Add(' AND Fórmulas."Código da Cor" = Cores."Código da Cor"     ');
      qryAdoCadRen.SQL.Add(' ORDER BY Fórmulas."Código da Cor", Fórmulas."Código da Base", Fórmulas."Código do Pigmento"');
      qryAdoCadRen.Open;

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Deletando Cadastro de Fórmulas...';
      qryCadRen := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadRen.SQL :=  '   DELETE FROM REN_CADREN      ';
      qryCadRen.ExecSQL;
      Gravando.Texto := 'Cadastro de Fórmulas deletado...';



      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('REN_CADREN');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      Gravando.Texto := Format('Abrindo Cadastro de %s...', ['Fórmulas']);

      qryCadRen.SQL.Empty;
      qryCadRen.SQL := '  SELECT * FROM REN_CADREN  ';
      qryCadRen.Open;
      {qryCadRen.SQL := '    INSERT INTO REN_CADREN      ';
      qryCadRen.SQL := qryCadRen.SQL + '     (REN_CODSEQ,                 ';
      qryCadRen.SQL := qryCadRen.SQL + '      REN_CODEMP,                 ';
      qryCadRen.SQL := qryCadRen.SQL + '      REN_DESCRI,                 ';
      qryCadRen.SQL := qryCadRen.SQL + '      REN_CODIGO,                 ';
      qryCadRen.SQL := qryCadRen.SQL + '      REN_UNIDAD,                 ';
      qryCadRen.SQL := qryCadRen.SQL + '      REN_CODBAS,                 ';
      qryCadRen.SQL := qryCadRen.SQL + '      REN_CODEMB,                 ';
      qryCadRen.SQL := qryCadRen.SQL + '      REN_CODUNI,                 ';
      qryCadRen.SQL := qryCadRen.SQL + '      REN_MD5KEY,                 ';
      qryCadRen.SQL := qryCadRen.SQL + '      REN_IDENTI,                 ';

      For intForm := 1 To 10 Do
      Begin
        qryCadRen.SQL := qryCadRen.SQL + '        REN_FORM' + TStrUtils.fStrZero(intForm, 2) + ', ';
        qryCadRen.SQL := qryCadRen.SQL + '        REN_QTDC' + TStrUtils.fStrZero(intForm, 2) + ', ';
      End;

      qryCadRen.SQL := qryCadRen.SQL + '      AUTOINCREM)                 ';
      qryCadRen.SQL := qryCadRen.SQL + '    VALUES      ';
      qryCadRen.SQL := qryCadRen.SQL + '     (:REN_CODSEQ,                ';
      qryCadRen.SQL := qryCadRen.SQL + '      :REN_CODEMP,                ';
      qryCadRen.SQL := qryCadRen.SQL + '      :REN_DESCRI,                ';
      qryCadRen.SQL := qryCadRen.SQL + '      :REN_CODIGO,                ';
      qryCadRen.SQL := qryCadRen.SQL + '      :REN_UNIDAD,                ';
      qryCadRen.SQL := qryCadRen.SQL + '      :REN_CODBAS,                ';
      qryCadRen.SQL := qryCadRen.SQL + '      :REN_CODEMB,                ';
      qryCadRen.SQL := qryCadRen.SQL + '      :REN_CODUNI,                ';
      qryCadRen.SQL := qryCadRen.SQL + '      :REN_MD5KEY,                ';
      qryCadRen.SQL := qryCadRen.SQL + '      :REN_IDENTI,                ';

      For intForm := 1 To 10 Do
      Begin
        qryCadRen.SQL := qryCadRen.SQL + '      :REN_FORM' + TStrUtils.fStrZero(intForm, 2) + ',  ';
        qryCadRen.SQL := qryCadRen.SQL + '      :REN_QTDC' + TStrUtils.fStrZero(intForm, 2) + ',  ';
      End;

      qryCadRen.SQL := qryCadRen.SQL + '      :AUTOINCREM);               ';}

      Gravando.Texto := Format('Processando Arquivos [%s]', [AnsiReplaceStr(GetPath, '"', '')]);
      Gravando.RegistrarProgresso(0, 0, 0);

      intCodSeq := 0;

      If (Gravando.Status <> sgGravando) Then
        Exit;


      While (Not qryAdoCadRen.Eof) Do
      Begin
        Inc(intCodSeq);

        If (Gravando.Status <> sgGravando) Then
          Break;

        If Not qryCadRen.Locate('REN_CODIGO;REN_CODBAS;REN_DESCRI;REN_UNIDAD', VarArrayOf([qryAdoCadRen.FieldByName('Código da Cor').AsString,
          qryAdoCadRen.FieldByName('Código da Base').AsString, AnsiUpperCase(qryAdoCadRen.FieldByName('Descrição').AsString), strUnid]), []) Then
        Begin

          strCor  := qryAdoCadRen.FieldByName('Código da Cor').AsString;
          strBase := qryAdoCadRen.FieldByName('Código da Base').AsString;

          qryCadRen.Insert;
          qryCadRen.FieldByName('AUTOINCREM').AsString  := TAutcomTintaFactory.Get.fRetAutoIncrem('REN_CADREN', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadRen.FieldByName('REN_CODSEQ').AsString  := TStrUtils.fStrZero(intCodSeq, 6);
          qryCadRen.FieldByName('REN_CODEMP').AsString  := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadRen.FieldByName('REN_DESCRI').AsString  := AnsiUpperCase(qryAdoCadRen.FieldByName('Descrição').AsString);
          qryCadRen.FieldByName('REN_CODIGO').AsString  := qryAdoCadRen.FieldByName('Código da Cor').AsString;
          qryCadRen.FieldByName('REN_UNIDAD').AsString  := strUnid;
          qryCadRen.FieldByName('REN_CODUNI').AsString  := strUnid;
          qryCadRen.FieldByName('REN_CODBAS').AsString  := qryAdoCadRen.FieldByName('Código da Base').AsString;
          qryCadRen.FieldByName('REN_CODEMB').AsString  := fRetCodEmbalagem(strUnid);
          qryCadRen.FieldByName('REN_IDENTI').AsString  := qryAdoCadRen.FieldByName('Código do Identificador').AsString;
          qryCadRen.FieldByName('REN_MD5KEY').AsString  := GetMD5(qryCadRen.FieldByName('REN_DESCRI').AsString +
                                                             qryCadRen.FieldByName('REN_CODIGO').AsString +
                                                             qryCadRen.FieldByName('REN_UNIDAD').AsString +
                                                             qryCadRen.FieldByName('REN_CODBAS').AsString +
                                                             qryCadRen.FieldByName('REN_CODEMB').AsString +
                                                             qryCadRen.FieldByName('REN_CODUNI').AsString);

          intForm := 1;

          While ((strCor = qryAdoCadRen.FieldByName('Código da Cor').AsString) And
               (strBase = qryAdoCadRen.FieldByName('Código da Base').AsString)) And
              (Not qryAdoCadRen.Eof) Do
          Begin

            If strBase <> qryAdoCadRen.FieldByName('Código da Base').AsString  Then
              Break;

            strCodigoPigmento := qryAdoCadRen.FieldByName('Código do Pigmento').AsString;
            fltQtdPigmento    := fQuantidadePigmento;

            If strBase = qryAdoCadRen.FieldByName('Código da Base').AsString Then
            Begin
              qryCadRen.FieldByName('REN_FORM' + TStrUtils.fStrZero(intForm, 2)).AsString := strCodigoPigmento;
              qryCadRen.FieldByName('REN_QTDC' + TStrUtils.fStrZero(intForm, 2)).AsFloat := fltQtdPigmento;

              qryAdoCadRen.Next;
              intForm := intForm + 1;
              Gravando.RegistrarProgresso(0, qryAdoCadRen.RecNo, qryAdoCadRen.RecordCount);
            End;
          End;

          qryCadRen.Post;

        End;

        Gravando.RegistrarProgresso(0, qryAdoCadRen.RecNo, qryAdoCadRen.RecordCount);
      End;


    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        Exit;
      End;

    End;
  Finally
    Gravando.Texto := 'Verificando arquivos duplicados REN_MD5KEY...';
    pDeletarMD5DuplicadoRenner(Gravando);
    Gravando.Texto := Format('Cadastro de %s processado com sucesso!', ['Fórmulas']);
  End;
end;


function TGravandoExecucaoRennerIndustrialCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;


function TGravandoExecucaoRennerIndustrialCores.fRetCodEmbalagem(
  strUnidade: String): String;
Var
  qryGen: IDataSet;
begin
  Result := '1';

  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := '   SELECT EMB_CODEMB FROM REN_CADEMB WHERE EMB_UNIDAD = :UNIDADE     ';
    qryGen.ParamByName('UNIDADE').AsString := strUnidade;
    qryGen.Open;

    If Not qryGen.IsEmpty Then
      Result := qryGen.FieldByName('EMB_CODEMB').AsString;

  Except
    Raise;
  End;
end;


procedure TGravandoExecucaoRennerIndustrialCores.pDeletarMD5DuplicadoRenner(
  Gravando: IGravando);
Var
  qryGen,
  qryMd5: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := '   SELECT COUNT(*) AS QTD, REN_MD5KEY AS MD5KEY     ' +
                '     FROM REN_CADREN                   ' +
                '   GROUP BY REN_MD5KEY                     ' +
                '     HAVING COUNT(*) > 1               ';
  qryGen.Open;

  If Not qryGen.IsEmpty Then
  Begin
    Gravando.Texto := 'Excluindo arquivo duplicados REN_CADREN...';

    qryMd5 := TAutcomTintaFactory.Get.fGetDataSet;

    qryGen.First;

    While Not qryGen.Eof Do
    Begin
      qryMd5.SQL := '     DELETE FROM REN_CADREN          ' +
                    '       WHERE REN_MD5KEY  = :MD5      ' +
                    '     LIMIT ' + IntToStr(qryGen.FieldByName('QTD').AsInteger - 1);

      qryMD5.ParamByName('MD5').AsString := qryGen.FieldByName('MD5KEY').AsString;
      qryMD5.ExecSQL;

      Gravando.RegistrarProgresso(0, qryGen.RecNo, qryGen.RecordCount);
      qryGen.Next;
    End;
  End;
end;

end.
