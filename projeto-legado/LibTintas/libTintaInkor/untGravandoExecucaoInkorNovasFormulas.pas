{ ********************************************************************************** }
{ * Classe responsável pela geração do cadastro de novas fórmulas da tinta Inkor * }
{ *******************************************************************************PH* }
unit untGravandoExecucaoInkorNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory,
  untStrUtils, Math, Variants, StrUtils;

type
  TGravandoExecucaoInkorNovasFormulas = class(TInterfacedObject,
    IGravandoExecucaoNome)
  private
    strCodNfm: string;
    blnGerarUnidades: Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;
    function fGetUnidadesGeracaoCadNfm(strUnidade:String):String;
    function fRetProximoCodSeq():Integer;
    function fRetFator(fltFatMen, fltFatMai: Double): Double;
  public
    constructor Create(const strCodNfm: string = '';
      blnGerarUnidades: Boolean = true;
      const blnAtualizarUnidade: Boolean = False;
      const strUnidadeMenor: String = '');
    function fGetNomeGravacao: string;
    procedure Executar(const gravando: IGravando);
    function fHabilitaOpcao(): Boolean;
  end;

implementation

uses
  untStatusGravando, untFuncoesGenerica;

{ TGravandoExecucaoInkorNovasFormulas }

constructor TGravandoExecucaoInkorNovasFormulas.Create(const strCodNfm
  : string = ''; blnGerarUnidades: Boolean = true;
  const blnAtualizarUnidade: Boolean = False;
  const strUnidadeMenor: String = '');
begin
  inherited Create();
  Self.strCodNfm := strCodNfm;
  Self.blnGerarUnidades := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor := strUnidadeMenor;
end;

procedure TGravandoExecucaoInkorNovasFormulas.Executar(const gravando: IGravando);
var
  qryBases, qryNovFor, qryInkor: IDataSet;
  fltFator: Double;
  intContador: Integer;
begin
  Try
    Try
      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Iniciando Cadastro de Novas Fórmulas...';

      //**********************\\
      //   INICIANDO QUERYS   \\
      //********************RG\\

      qryBases  := TAutcomTintaFactory.Get.fGetDataSet;
      qryNovFor := TAutcomTintaFactory.Get.fGetDataSet;
      qryInkor  := TAutcomTintaFactory.Get.fGetDataSet;

      qryNovFor.Close;
      qryInkor.Close;

      Gravando.Texto := 'Deletando Registros de Novas Fórmulas da tabela INK_CADINK...';

      qryNovFor.SQL := '    SELECT * FROM INK_CADNFM      ';
      qryInkor.SQL  := '    DELETE FROM INK_CADINK        ';

      If Not TStrUtils.fEmptyStr(strCodNfm) Then
      Begin
        qryNovFor.SQL := qryNovFor.SQL + '    WHERE NFM_CODIGO = ' + QuotedStr(strCodNfm);
        qryInkor.SQL  := qryInkor.SQL + ' WHERE INK_CODIGO = ' + QuotedStr(strCodNfm);
      End
      Else
        qryInkor.SQL := qryInkor.SQL + '  WHERE INK_CODIGO LIKE ''%ESP%''   ';


      qryInkor.ExecSQL;
      qryInkor.SQL := '';
      qryInkor.SQL := qryInkor.SQL + '    SELECT * FROM INK_CADINK   WHERE FALSE    ';
      qryInkor.Open; //Abrindo cadastro de cores
      qryNovFor.Open; //Abrindo cadastro de novas formulas

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('INK_CADINK');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      Gravando.Texto := 'Processando Cadastro de Novas Fórmulas...';

      While Not qryNovFor.Eof Do
      Begin

        If (Gravando.Status <> sgGravando) Then
          Break;

        qryBases.Close;
        qryBases.SQL := '';
        qryBases.SQL := qryBases.SQL + '  SELECT                    ';
        qryBases.SQL := qryBases.SQL + '    BAS_CONTEU,             ';
        qryBases.SQL := qryBases.SQL + '    BAS_UNIDAD              ';
        qryBases.SQL := qryBases.SQL + '  FROM                      ';
        qryBases.SQL := qryBases.SQL + '    INK_CADBAS              ';
        qryBases.SQL := qryBases.SQL + '  INNER JOIN CADITE ON              ';
        qryBases.SQL := qryBases.SQL + '    BAS_CODITE = ITE_CODITE                 ';
        qryBases.SQL := qryBases.SQL + '  WHERE                     ';
        qryBases.SQL := qryBases.SQL + '    BAS_BASE__ = :BASE__ AND        ';
        qryBases.SQL := qryBases.SQL + '    BAS_DESCRI = :PRODUT            ';

        If Not blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + '    AND BAS_UNIDAD = :UNIDAD              ';

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And (blnGerarUnidades) Then
          qryBases.SQL := qryBases.SQL + '    AND BAS_UNIDAD <> :UNIDAD             ';

        If TStrUtils.fEmptyStr(strCodNfm) Then
          qryBases.SQL := qryBases.SQL + fGetUnidadesGeracaoCadNfm(qryNovFor.FieldByName('NFM_UNIDAD').AsString);

        qryBases.ParamByName('BASE__').AsString := qryNovFor.FieldByName('NFM_BASE__').AsString;
        qryBases.ParamByName('PRODUT').AsString := qryNovFor.FieldByName('NFM_PRODUT').AsString;

        If Not blnGerarUnidades Then
          qryBases.FieldByName('UNIDAD').AsString := qryNovFor.FieldByName('NFM_UNIDAD').AsString;

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And (blnGerarUnidades) Then
          qryBases.FieldByName('UNIDAD').AsString := strUnidadeMenor;

        qryBases.Open;
        qryBases.First;

        While Not qryBases.Eof Do
        Begin
          If (Gravando.Status <> sgGravando) Then
            Break;

          qryInkor.Insert;
          qryInkor.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('INK_CADINK', TAutcomTintaFactory.Get.GetCodEmp);
          qryInkor.FieldByName('INK_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryInkor.FieldByName('INK_CODSEQ').AsString := TStrUtils.fStrZero(fRetProximoCodSeq, 6);
          qryInkor.FieldByName('INK_CODIGO').AsString := qryNovFor.FieldByName('NFM_CODIGO').AsString;
          qryInkor.FieldByName('INK_BASE__').AsString := qryNovFor.FieldByName('NFM_BASE__').AsString;
          qryInkor.FieldByName('INK_PRODUT').AsString := qryNovFor.FieldByName('NFM_PRODUT').AsString;
          qryInkor.FieldByName('INK_UNIDAD').AsString := qryBases.FieldByName('BAS_UNIDAD').AsString;
          qryInkor.FieldByName('INK_DESCRI').AsString := qryNovFor.FieldByName('NFM_DESCRI').AsString;
          qryInkor.FieldByName('INK_ATIVO_').AsString := qryNovFor.FieldByName('NFM_ATIVO_').AsString;
          qryInkor.FieldByName('INK_DTACAD').AsDate   := qryNovFor.FieldByName('NFM_DTACAD').AsDate;
          qryInkor.FieldByName('INK_MD5KEY').AsString := GetMD5(qryInkor.FieldByName('INK_CODIGO').AsString +
                                                                qryInkor.FieldByName('INK_BASE__').AsString +
                                                                qryInkor.FieldByName('INK_PRODUT').AsString +
                                                                qryInkor.FieldByName('INK_UNIDAD').AsString +
                                                                qryInkor.FieldByName('INK_DESCRI').AsString);
          qryInkor.FieldByName('INK_ACRMOB').AsFloat  := qryNovFor.FieldByName('NFM_ACRMOB').AsFloat;

          fltFator := fRetFator(qryNovFor.FieldByName('NFM_CONTEU').AsFloat, qryBases.FieldByName('BAS_CONTEU').AsFloat);

          For intContador := 1 To 20 Do
          Begin

            If (TStrUtils.fEmptyStr(qryNovFor.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString)) Then
              Break;

            qryInkor.FieldByName('INK_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString := TrimRight(qryNovFor.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString);

            qryInkor.FieldByName('INK_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat  :=
              qryNovFOr.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat * fltFator;
          End;

          qryInkor.Post;
          qryBases.Next;
        End;

        qryNovFor.Next;
        Gravando.RegistrarProgresso(0, qryNovFor.RecNo, qryNovFor.RecordCount);
      End;
    Except
      On E: Exception Do
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
    End;
  Finally
    //
  End;
end;

function TGravandoExecucaoInkorNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;


function TGravandoExecucaoInkorNovasFormulas.fGetUnidadesGeracaoCadNfm(
  strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'GL' Then
    Result := ' AND BAS_UNIDAD IN ("GL","LA") '
  Else If strUnidade = 'LA' Then
    Result := ' AND BAS_UNIDAD = "LA" ';
end;


function TGravandoExecucaoInkorNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoInkorNovasFormulas.fRetFator(fltFatMen,
  fltFatMai: Double): Double;
begin
  Result := fltFatMai / fltFatMen;
end;

function TGravandoExecucaoInkorNovasFormulas.fRetProximoCodSeq: Integer;
var
  qryGen: IDataset;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := ' SELECT IFNULL(MAX(CONVERT(INK_CODSEQ, SIGNED)), 0) + 1 AS MAXIMO FROM INK_CADINK  ';
    qryGen.Open;

    Result := qryGen.FieldByName('MAXIMO').AsInteger;
  Except
    Raise;
  End;
end;

end.
