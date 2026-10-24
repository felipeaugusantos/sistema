{****************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta Starmix *}
{*************************************************************************AC*}
unit untGravandoExecucaoStarmixBases;

interface

uses
  untAbstractGravandoExecucaoStarmix, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, untTipoCadastro,
  Classes, StrUtils;

type
  TGravandoExecucaoStarmixBases = class(TAbstractGravandoExecucaoStarmix)
  Private
    function fQtdEmbalagemMl(strEmbalagem: String): String;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;

    function fGerarCadatroBase(const gravando: IGravando; strArquivo : String) : Boolean;

  end;

implementation

uses
  untIConfTinta;

{ TGravandoExecucaoStarmixBases }

procedure TGravandoExecucaoStarmixBases.Executar(const gravando: IGravando);
Var
  stlArquivos : TStringList;
  intContador : Integer;
begin
  Try
    Try
      gravando.Texto := 'Validando Path de Arquivos ...';

      If (Not fValidaPath) Then
      Begin
        gravando.Texto := 'Path para o geração do arquivo de bases não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      gravando.Texto := 'Path validado com sucesso ...';

      gravando.Texto := 'Carregando dados...';


      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Dados carregados com sucesso!';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('STA_CADBAS');
      gravando.Texto := 'PROCOD verificado com sucesso!';


      stlArquivos := TStringList.Create;
      stlArquivos.Add(GetPath);


      If (stlArquivos.Count <= 0) Then
      Begin
        gravando.Texto := 'Não encontrei nenhum arquivo para a geração!';
        Exit;
      End;

      For intContador := 0 To stlArquivos.Count -1 Do
      Begin
        Try
          If fGerarCadatroBase( gravando, stlArquivos[intContador]) Then
            gravando.Texto := 'Geração do arquivo de bases concluído com sucesso!'
          else
          gravando.Texto := 'Ocorreu erro ao processar o arquivo de bases!'
        Finally
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

function TGravandoExecucaoStarmixBases.fGerarCadatroBase(const gravando: IGravando; strArquivo: String): Boolean;
Var
  qryAux      : IDataSet;
  qryStaCadBas: IDataSet;
  qryTmpLin   : IDataSet;
  qryTmpBas   : IDataSet;
  qryTmpMon   : IDataSet;

  stlArqTxt   : TStringList;
  intLinhaTxt : Integer;

  strLinhaTxt : String;
  strTipReg   : String;

begin
  Result := true;

  Try
    qryAux := TAutcomTintaFactory.Get.fGetDataSet;

    // CRIANDO A TEMPORÁRIA TMP_CADMON
    qryAux.SQL := 'CREATE TEMPORARY TABLE TMP_CADMON ( '+
                  '  MON_CODMON VARCHAR(03), '+
                  '  MON_DESMON VARCHAR(40) ) ';
    qryAux.ExecSQL;


    // CRIANDO A TEMPORÁRIA TMP_CADLIN
    qryAux.SQL := 'CREATE TEMPORARY TABLE TMP_CADLIN ( '+
                  '  LIN_CODSEQ VARCHAR(03), '+
                  '  LIN_DESLIN VARCHAR(40), '+
                  '  LIN_VOLUME NUMERIC(14, 4) ) ';
    qryAux.ExecSQL;

    // CRIANDO A TEMPORÁRIA TMP_CADBAS
    qryAux.SQL := 'CREATE TEMPORARY TABLE TMP_CADBAS ( '+
                  '  BAS_CODSEQ VARCHAR(03), '+
                  '  BAS_CODBAS VARCHAR(08), '+
                  '  BAS_DESBAS VARCHAR(45), '+
                  '  BAS_CODLIN VARCHAR(03), '+
                  '  BAS_PESESP NUMERIC(14, 4) ) ';
    qryAux.ExecSQL;

    Try
      stlArqTxt := TStringList.Create;
      stlArqTxt.LoadFromFile(strArquivo);


      For intLinhaTxt := 0 To stlArqTxt.Count -1 Do
      Begin
        strLinhaTxt := stlArqTxt[intLinhaTxt];
        strTipReg   := Copy(strLinhaTxt, 299, 02);

        {*******************************************}
        {* CADASTRO DE LINHAS                      *}
        {****************************************MV*}
        If (strTipReg = '20') Then
        Begin
          qryAux.SQL := ' INSERT '+
                        '   INTO TMP_CADLIN ( LIN_CODSEQ,  '+
                        '                     LIN_DESLIN,  '+
                        '                     LIN_VOLUME ) '+
                        ' VALUES ( :CODSEQ,  '+
                        '          :DESLIN,  '+
                        '          :VOLUME ) ';
          qryAux.ParambyName('CODSEQ').AsString := Copy(strLinhaTxt, 01, 03);
          qryAux.ParambyName('DESLIN').AsString := Copy(strLinhaTxt, 04, 30);
          qryAux.ParambyName('VOLUME').AsFloat  := TAutcomTintaFactory.Get.fStrToFloat(Copy(strLinhaTxt, 34, 6));
          qryAux.ExecSQL;
        End

        {*******************************************}
        {* CADASTRO DE BASES                       *}
        {****************************************MV*}
        Else If (strTipReg = '30') Then
        Begin
          qryAux.SQL := ' INSERT '+
                        '   INTO TMP_CADBAS ( BAS_CODSEQ, '+
                        '                     BAS_CODBAS, '+
                        '                     BAS_DESBAS, '+
                        '                     BAS_CODLIN, '+
                        '                     BAS_PESESP )'+
                        ' VALUES ( :CODSEQ,  '+
                        '          :CODBAS,  '+
                        '          :DESBAS,  '+
                        '          :CODLIN,  '+
                        '          :PESESP ) ';

          qryAux.ParamByName('CODSEQ').AsString := Copy(strLinhaTxt, 01, 03);
          qryAux.ParamByName('CODBAS').AsString := Copy(strLinhaTxt, 04, 08);
          qryAux.ParamByName('CODBAS').AsString := TrimRight(qryAux.ParamByName('CODBAS').AsString);
          qryAux.ParamByName('DESBAS').AsString := Copy(strLinhaTxt, 12, 45);
          qryAux.ParamByName('CODLIN').AsString := Copy(strLinhaTxt, 57, 03);
          qryAux.ParamByName('PESESP').AsFloat  := TAutcomTintaFactory.Get.fStrToFloat(Copy(strLinhaTxt, 60, 08)) / 10000;
          qryAux.ExecSQL;

        End
      End;

      qryTmpBas := TAutcomTintaFactory.Get.fGetDataSet;
      qryTmpBas.SQL := 'SELECT * FROM TMP_CADBAS';
      qryTmpBas.Open;

      qryTmpLin := TAutcomTintaFactory.Get.fGetDataSet;
      qryTmpLin.SQL := 'SELECT * FROM TMP_CADLIN';
      qryTmpLin.Open;

      qryTmpMon := TAutcomTintaFactory.Get.fGetDataSet;
      qryTmpMon.SQL := 'SELECT * FROM TMP_CADMON';
      qryTmpMon.Open;

      qryStaCadBas := TAutcomTintaFactory.Get.fGetDataSet;
      qryStaCadBas.SQL := 'SELECT * FROM STA_CADBAS';
      qryStaCadBas.Open;

      While (Not qryTmpBas.Eof) Do
      Begin
        If (Not qryTmpLin.Locate('LIN_CODSEQ', qryTmpBas.FieldByName('BAS_CODLIN').AsString, [])) Then
        Begin
          qryStaCadBas.Next;
          Continue;
        End;

        If qryStaCadBas.Locate('BAS_CODBAS', qryTmpBas.FieldByName('BAS_CODBAS').AsString, []) Then
        Begin
          qryStaCadBas.Edit;
        End
        Else
        Begin
          qryStaCadBas.Insert;
          qryStaCadBas.FieldByName('BAS_CODBAS').AsString := qryTmpBas.FieldByName('BAS_CODBAS').AsString;
          qryStaCadBas.FieldByName('BAS_CODSEQ').AsString := qryTmpBas.FieldByName('BAS_CODSEQ').AsString;
          qryStaCadBas.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('STA_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
          qryStaCadBas.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;;
        End;

        qryStaCadBas.FieldByName('BAS_VOLUME').AsFloat  := qryTmpLin.FieldByName('LIN_VOLUME').AsFloat;
        qryStaCadBas.FieldByName('BAS_QTDEMB').AsString := AnsiReplaceStr(fQtdEmbalagemMl(FloatToStrF(qryStaCadBas.FieldByName('BAS_VOLUME').AsFloat, ffNumber, 12, 0)), '.', '');
        qryStaCadBas.FieldByName('BAS_PESESP').AsFloat  := qryTmpBas.FieldByName('BAS_PESESP').AsFloat;
        qryStaCadBas.FieldByName('BAS_DESBAS').AsString := qryTmpBas.FieldByName('BAS_DESBAS').AsString;
        qryStaCadBas.Post;

        Gravando.RegistrarProgresso(0, qryTmpBas.RecNo, qryTmpBas.RecordCount);
        qryTmpBas.Next;

      End;
    Finally
      If Assigned(stlArqTxt) Then
        FreeAndNil(stlArqTxt);

      qryAux.SQL := 'DROP TABLE TMP_CADBAS';
      qryAux.ExecSQL;

      qryAux.SQL := 'DROP TABLE TMP_CADLIN';
      qryAux.ExecSQL;

      qryAux.SQL := 'DROP TABLE TMP_CADMON';
      qryAux.ExecSQL;
    End;

  except
    Result := false;
  End;
end;

function TGravandoExecucaoStarmixBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TGravandoExecucaoStarmixBases.fQtdEmbalagemMl(
  strEmbalagem: String): String;
begin
  Result := Trim(strEmbalagem) + ' ML';
end;

end.
