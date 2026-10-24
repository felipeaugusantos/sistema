{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta International *}
{*******************************************************************************PH*}
unit untGravandoExecucaoInternationalNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math, Variants, StrUtils;

type
  TGravandoExecucaoInternationalNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm        : string;
    blnGerarUnidades : Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;
  function fTamanhoEmbalagem(strCodEmb: String): Double;
  function fRetFatorUni(fltEmbalaOri: Double; fltEmbalaPro: Double): Double;
  public
    constructor Create(const strCodNfm: string = ''; blnGerarUnidades : Boolean = true;
      const blnAtualizarUnidade: Boolean = False; const strUnidadeMenor: String = '');
    function fGetNomeGravacao: string;
    procedure Executar(const gravando: IGravando);
    function fHabilitaOpcao(): Boolean;
  end;

implementation

uses
  untStatusGravando, untFuncoesGenerica;

{ TGravandoExecucaoInternationalNovasFormulas }

constructor TGravandoExecucaoInternationalNovasFormulas.Create(
  const strCodNfm: string; blnGerarUnidades: Boolean;
  const blnAtualizarUnidade: Boolean; const strUnidadeMenor: String);
begin
  inherited Create();
  Self.strCodNfm   := strCodNfm;
  Self.blnGerarUnidades := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor := strUnidadeMenor;
end;

procedure TGravandoExecucaoInternationalNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadInt,
  qryEmbalagens,
  qryCadNfm: IDataSet;
  fltFator: Double;
  intContador: Integer;
  strMD5:String;
begin
  Try
    Try
      Gravando.Texto := 'Carregando dados do Cadastro de Novas Fórmulas...';
      qryCadInt := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;

      Gravando.Texto := 'Deletando Novas Fórmulas cadastradas...';
      qryCadInt.SQL := '    DELETE FROM INT_CADINT    ';
      qryCadNfm.SQL := '    SELECT * FROM INT_CADNFM    ';

      If Not TStrUtils.fEmptyStr(strCodNfm) Then
      Begin
        qryCadNfm.SQL := qryCadNfm.SQL + '  WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);
        qryCadInt.SQL := qryCadInt.SQL + '  WHERE INT_CODNFM = ' + QuotedStr(strCodNfm);
      End
      Else
      Begin
        qryCadInt.SQL := qryCadInt.SQL + '  WHERE INT_CODNFM LIKE ''%ESP%'' ';
      End;

      qryCadInt.ExecSQL;
      qryCadInt.SQL.Empty;
      Gravando.Texto := 'Novas Fórmulas deletada...';

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('INT_CADINT');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      Gravando.Texto := 'Processando Cadastro de Novas Fórmulas...';
      qryCadInt.SQL := '    SELECT * FROM INT_CADINT WHERE FALSE    ';
      qryCadInt.Open;
      qryCadNfm.Open;


      Try
        While Not qryCadNfm.Eof Do
        Begin
          qryEmbalagens := TAutcomTintaFactory.Get.fGetDataSet;
          qryEmbalagens.SQL := ' SELECT                         ' +
                               '   EMB_CODUNI,                  ' +
                               '   EMB_CODEMB,                  ' +
                               '   EMB_TAMEMB                   ' +
                               ' FROM                           ' +
                               '   INT_CADBAS                   ' +
                               '  INNER JOIN CADITE             ' +
                               '     ON ITE_CODITE = BAS_CODITE ' +
                               '  INNER JOIN INT_CADEMB         ' +
                               '     ON EMB_CODEMB = BAS_CODEMB ' +
                               ' WHERE BAS_CODBAS = :DESBAS     ' +
                               ' ORDER BY EMB_TAMEMB            ' ;

          qryEmbalagens.ParamByName('DESBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
          qryEmbalagens.Open;

          While Not qryEmbalagens.Eof Do
          Begin
            qryCadInt.Insert;
            qryCadInt.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('INT_CADINT', TAutcomTintaFactory.Get.GetCodEmp);
            qryCadInt.FieldByName('INT_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
            qryCadInt.FieldByName('INT_DESCOR').AsString := qryCadNfm.FieldByName('NFM_DESCOR').AsString;
            qryCadInt.FieldByName('INT_CODEMB').AsString := qryEmbalagens.FieldByName('EMB_CODEMB').AsString;
            qryCadInt.FieldByName('INT_CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
            qryCadInt.FieldByName('INT_LINHA_').AsString := qryCadNfm.FieldByName('NFM_LINHA_').AsString;

            fltFator := fRetFatorUni(fTamanhoEmbalagem(qryCadNfm.FieldByName('NFM_CODEMB').AsString), qryEmbalagens.FieldByName('EMB_TAMEMB').AsFloat);
            strMd5 := '';

            For intContador := 1 To 20 Do
            Begin

              If TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
                Break;

              qryCadInt.FieldByName('INT_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString);

              qryCadInt.FieldByName('INT_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat :=
                qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat * fltFator;

              strMD5 := strMD5 + qryCadInt.FieldByName('INT_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString;
              strMD5 := strMD5 + FloatToStr(qryCadInt.FieldByName('INT_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat);
            End;

            qryCadInt.FieldByName('INT_DTACAD').AsDate   := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
            qryCadInt.FieldByName('INT_CODNFM').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
            qryCadInt.FieldByName('INT_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;
            qryCadInt.FieldByName('INT_CODINT').AsString := qryCadNfm.FieldByName('NFM_CODINT').AsString;
            qryCadInt.FieldByName('INT_MD5KEY').AsString := GetMD5(qryCadInt.FieldByName('INT_LINHA_').AsString +
                                                                   qryCadInt.FieldByName('INT_DESCOR').AsString +
                                                                   qryCadInt.FieldByName('INT_CODBAS').AsString +
                                                                   qryCadInt.FieldByName('INT_CODEMB').AsString +
                                                                   qryCadInt.FieldByName('INT_CODNFM').AsString +
                                                                   strMD5);
            qryCadInt.Post;
            qryEmbalagens.Next;

          End;
          qryCadNfm.Next;
          Gravando.RegistrarProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);
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

  End;
end;

function TGravandoExecucaoInternationalNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoInternationalNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoInternationalNovasFormulas.fRetFatorUni(fltEmbalaOri,
  fltEmbalaPro: Double): Double;
begin
  Result := fltEmbalaPro / fltEmbalaOri;
end;


function TGravandoExecucaoInternationalNovasFormulas.fTamanhoEmbalagem(
  strCodEmb: String): Double;
var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := ' SELECT EMB_TAMEMB FROM INT_CADEMB ' +
                  '   WHERE EMB_CODEMB = :EMBALAGEM ';

    qryGen.ParamByName('EMBALAGEM').AsString := strCodEmb;
    qryGen.Open;

    Result := qryGen.FieldByName('EMB_TAMEMB').AsFloat;
  Except
    Raise;
  End;
end;


end.
