{ ********************************************************************************** }
{ * Classe responsável pela geração do cadastro de novas fórmulas da tinta MaxVinil * }
{ *******************************************************************************PH* }
unit untGravandoExecucaoMaxVinilNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory,
  untStrUtils, Math, Variants, StrUtils;

type
  TGravandoExecucaoMaxVinilNovasFormulas = class(TInterfacedObject,
    IGravandoExecucaoNome)
  private
    strCodNfm: string;
    blnGerarUnidades: Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;
    function fGetUnidadesGeracaoCadNfm(strUnidade:String):String;
    function fRetFatorUnidade(fltConMen, fltConMai: Double): Double;
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

{ TGravandoExecucaoMaxVinilNovasFormulas }

constructor TGravandoExecucaoMaxVinilNovasFormulas.Create(const strCodNfm
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

procedure TGravandoExecucaoMaxVinilNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm,
  qryCadMax,
  qryBases: IDataSet;
  intContador: Integer;
  fltFator:Double;
begin
  Try
    Try
      Gravando.Texto := 'Excluindo Novas fórmulas...';

      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadMax := TAutcomTintaFactory.Get.fGetDataSet;

      qryCadNfm.Close;
      qryCadMax.Close;

      qryCadNfm.SQL := '  SELECT * FROM MAX_CADNFM      ';
      qryCadMax.SQL := '  DELETE FROM MAX_CADMAX        ';

      If Not TStrUtils.fEmptyStr(strCodNfm) Then
      Begin
        qryCadNfm.SQL := qryCadNfm.SQL + '    WHERE NFM_CODIGO = ' + QuotedStr(strCodNfm);
        qryCadMax.SQL := qryCadMax.SQL + '    WHERE MAX_CODIGO = ' + QuotedStr(strCodNfm);
      End
      Else
        qryCadMax.SQL := qryCadMax.SQL + '    WHERE MAX_CODIGO LIKE "%ESP%"     ';

      qryCadNfm.Open;
      qryCadMax.ExecSQL;

      qryCadMax.Close;
      qryCadMax.SQL := '  SELECT * FROM MAX_CADMAX WHERE FALSE    ';
      qryCadMax.Open;

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('MAX_CADMAX');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      Gravando.Texto := 'Abrindo Cadastro de Novas Fórmulas...';
      Gravando.Texto := 'Processando Novas Fórmulas...';
      Gravando.RegistrarProgresso(0, 0, 0);

      qryBases := TAutcomTintaFactory.Get.fGetDataSet;

      Try
        Try
          While Not qryCadNfm.Eof Do
          Begin

            If (Gravando.Status <> sgGravando) Then
              Break;

            qryBases.Close;
            qryBases.SQL := '';
            qryBases.SQL := qryBases.SQL + '  SELECT              ';
            qryBases.SQL := qryBases.SQL + '    *                 ';
            qryBases.SQL := qryBases.SQL + '  FROM                ';
            qryBases.SQL := qryBases.SQL + '    MAX_CADBAS        ';
            qryBases.SQL := qryBases.SQL + '  INNER JOIN CADITE ON        ';
            qryBases.SQL := qryBases.SQL + '    BAS_CODITE = ITE_CODITE         ';
            qryBases.SQL := qryBases.SQL + '  WHERE               ';
            qryBases.SQL := qryBases.SQL + '    BAS_CODBAS = :CODBAS AND        ';
            qryBases.SQL := qryBases.SQL + '    BAS_PRODUT = :PRODUT            ';

            If Not blnGerarUnidades Then
              qryBases.SQL := qryBases.SQL + '  AND BAS_UNIDAD = :UNIDAD        ';

            If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And (blnGerarUnidades) Then
              qryBases.SQL := qryBases.SQL + '  AND BAS_UNIDAD <> :UNIDAD       ';

            If TStrUtils.fEmptyStr(strCodNfm) Then
              qryBases.SQL := qryBases.SQL + fGetUnidadesGeracaoCadNfm(qryCadNfm.FieldByName('NFM_UNIDAD').AsString);

            qryBases.ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
            qryBases.ParamByName('PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;

            If Not blnGerarUnidades Then
              qryBases.ParamByName('UNIDAD').AsString := qryCadNfm.FieldByName('NFM_UNIDAD').AsString;

            If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And (blnGerarUnidades) Then
              qryBases.ParamByName('UNIDAD').AsString := strUnidadeMenor;

            qryBases.Open;
            qryBases.First;


            While Not QryBases.Eof Do
            Begin
              qryCadMax.Insert;
              qryCadMax.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('MAX_CADMAX', TAutcomTintaFactory.Get.GetCodEmp);
              qryCadMax.FieldByName('MAX_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
              qryCadMax.FieldByName('MAX_CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODIGO').AsString;
              qryCadMax.FieldByName('MAX_CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
              qryCadMax.FieldByName('MAX_PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;
              qryCadMax.FieldByName('MAX_COLECA').AsString := qryCadNfm.FieldByName('NFM_COLECA').AsString;
              qryCadMax.FieldByName('MAX_UNIDAD').AsString := qryBases.FieldByName('BAS_UNIDAD').AsString;
              qryCadMax.FieldByName('MAX_NOMCOR').AsString := qryCadNfm.FieldByName('NFM_NOMCOR').AsString;
              qryCadMax.FieldByName('MAX_DTACAD').AsDate   := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
              qryCadMax.FieldByName('MAX_ATIVO_').AsString := qryCadNfm.FieldByName('NFM_ATIVO_').AsString;
              qryCadMax.FieldByName('MAX_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;
              qryCadMax.FieldByName('MAX_EMBALA').AsFloat  := qryBases.FieldByName('BAS_CONTEU').AsFloat;

              fltFator := fRetFatorUnidade(qryCadNfm.FieldByName('NFM_CONTEU').AsFloat, qryBases.FieldByName('BAS_CONTEU').AsFloat);

              For intContador := 1 To 20 Do
              Begin

                If TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
                  Break;

                qryCadMax.FieldByName('MAX_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString :=
                  TrimRight(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString);

                qryCadMax.FieldByName('MAX_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat :=
                  qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat * fltFator;
              End;

              qryCadMax.FieldByName('MAX_MD5KEY').AsString := GetMD5(qryCadMax.FieldByName('MAX_CODIGO').AsString +
                                                                     qryCadMax.FieldByName('MAX_CODBAS').AsString +
                                                                     qryCadMax.FieldByName('MAX_PRODUT').AsString +
                                                                     qryCadMax.FieldByName('MAX_COLECA').AsString +
                                                                     qryCadMax.FieldByName('MAX_UNIDAD').AsString +
                                                                     qryCadMax.FieldByName('MAX_NOMCOR').AsString +
                                                                     qryCadMax.FieldByName('MAX_EMBALA').AsString);

              qryCadMax.Post;
              qryBases.Next;
            End;

            qryCadNfm.Next;
            Gravando.RegistrarProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);
          End;
        Except
          On E: Exception Do
          Begin
            Raise;
          End;
        End;
      Finally
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        Gravando.Cancelar;
      End;
    End;
  Finally
  End;
end;

function TGravandoExecucaoMaxVinilNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;


function TGravandoExecucaoMaxVinilNovasFormulas.fGetUnidadesGeracaoCadNfm(
  strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'GL' Then
    Result := ' AND BAS_UNIDAD IN ("GL","LA") '
  Else If strUnidade = 'LA' Then
    Result := ' AND BAS_UNIDAD = "LA" ';
end;

function TGravandoExecucaoMaxVinilNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoMaxVinilNovasFormulas.fRetFatorUnidade(fltConMen,
  fltConMai: Double): Double;
begin
  Result := fltConMai / fltConMen;
end;

end.
