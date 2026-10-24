{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta HydronorthImobiliaria *}
{*******************************************************************************PH*}
unit untGravandoExecucaoHydronorthImobiliariaNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math, Variants, StrUtils;

type
  TGravandoExecucaoHydronorthImobiliariaNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm        : string;
    blnGerarUnidades : Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;

    function fRetFator(fltMaior: Double; fltMenor: Double): Double;
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

{ TGravandoExecucaoHydronorthImobiliariaNovasFormulas }

constructor TGravandoExecucaoHydronorthImobiliariaNovasFormulas.Create(
  const strCodNfm: string; blnGerarUnidades: Boolean;
  const blnAtualizarUnidade: Boolean; const strUnidadeMenor: String);
begin
  inherited Create();
  Self.strCodNfm   := strCodNfm;
  Self.blnGerarUnidades := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor := strUnidadeMenor;
end;

procedure TGravandoExecucaoHydronorthImobiliariaNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm   : IDataSet;
  qryCadHyd   : IDataSet;
  qryCadEmb   : IDataSet;
  intCont     : Integer;
  fltEmbMenor : Double;
  fltFator    : Double;
begin
  Try

    Try
      gravando.Texto := 'Carregando dados...';

      qryCadHyd := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;

      qryCadHyd.SQL := '  DELETE FROM HYD_CADHYD    ';
      qryCadNfm.SQL := '  SELECT * FROM HYD_CADNFM  ';

      If Not TStrUtils.fEmptyStr(strCodNfm) Then
      Begin
        qryCadHyd.SQL := qryCadHyd.SQL + ' WHERE HYD_CODNFM = ' + QuotedStr(strCodNfm);
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);
      End
      Else
      Begin
        qryCadHyd.SQL := qryCadHyd.SQL + ' WHERE HYD_CODNFM LIKE "%ESP%"      ';
      End;

      qryCadHyd.ExecSQL;
      qryCadNfm.Open;

      While Not qryCadNfm.Eof Do
      Begin
        {EMBALAGENS}
        qryCadEmb := TAutcomTintaFactory.Get.fGetDataSet;
        qryCadEmb.SQL := 'SELECT * '+
                         '   FROM HYD_CADEMB '+
                         '  INNER JOIN HYD_CADBAS ON EMB_CODEMB = BAS_CODEMB '+
                         '  WHERE BAS_PRODUT = :PRODUT '+
                         '    AND BAS_BASE__ = :BASE__ '+
                         '    AND BAS_CODITE IS NOT NULL '+
                         '  ORDER BY EMB_TAMEMB ';
        qryCadEmb.ParamByName('PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;
        qryCadEmb.ParamByName('BASE__').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;
        qryCadEmb.Open;

        fltEmbMenor := qryCadEmb.FieldByName('EMB_TAMEMB').AsFloat;

        qryCadHyd.Close;
        qryCadHyd.SQL := '  SELECT * FROM HYD_CADHYD  ';
        qryCadHyd.Open;

        gravando.Texto := 'Dados carregados com sucesso...';

        gravando.Texto := 'Verificando PROCOD...';
        TAutcomTintaFactory.Get.fInsereProCod('HYD_CADHYD');
        gravando.Texto := 'PROCOD verificado com sucesso!';

        qryCadEmb.First;

        While Not qryCadEmb.Eof Do
        Begin
          Try
            qryCadHyd.Insert;
            qryCadHyd.FieldByName('HYD_CODEMP').AsString := qryCadNfm.FieldByName('NFM_CODEMP').AsString;
            qryCadHyd.FieldByName('HYD_COLECA').AsString := qryCadNfm.FieldByName('NFM_COLECA').AsString;
            qryCadHyd.FieldByName('HYD_PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;
            qryCadHyd.FieldByName('HYD_C_O_R_').AsString := qryCadNfm.FieldByName('NFM_C_O_R_').AsString;
            qryCadHyd.FieldByName('HYD_CORLON').AsString := qryCadNfm.FieldByName('NFM_CORLON').AsString;
            qryCadHyd.FieldByName('HYD_BASE__').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;
            qryCadHyd.FieldByName('HYD_CODEMB').AsString := qryCadEmb.FieldByName('EMB_CODEMB').AsString;
            qryCadHyd.FieldByName('HYD_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

            fltFator := fRetFator(qryCadEmb.FieldByName('EMB_TAMEMB').AsFloat, fltEmbMenor);

            For intCont := 1 To 20 Do
            Begin
              if qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat <= 0 then
                Break;

              if TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString) then
                Break;

              qryCadHyd.FieldByName('HYD_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString);
              qryCadHyd.FieldByName('HYD_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat := qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat * fltFator;
            End;

            qryCadHyd.FieldByName('HYD_CODNFM').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
            qryCadHyd.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('HYD_CADHYD', qryCadNfm.FieldByName('NFM_CODEMP').AsString);
            qryCadHyd.FieldByName('HYD_MD5KEY').AsString := GetMD5(qryCadHyd.FieldByName('HYD_CODNFM').AsString +
                                                                   qryCadHyd.FieldByName('HYD_COLECA').AsString +
                                                                   qryCadHyd.FieldByName('HYD_PRODUT').AsString +
                                                                   qryCadHyd.FieldByName('HYD_C_O_R_').AsString +
                                                                   qryCadHyd.FieldByName('HYD_CORLON').AsString +
                                                                   qryCadHyd.FieldByName('HYD_BASE__').AsString +
                                                                   qryCadHyd.FieldByName('HYD_CODEMB').AsString);

            qryCadHyd.Post;
          Except On
            E: Exception Do
            Begin
              gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
            End;

          End;

          qryCadEmb.Next;
        End;

        qryCadNfm.Next;
      End;

    Finally

    End;
  Finally
    gravando.RegistrarProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);
  End;
end;

function TGravandoExecucaoHydronorthImobiliariaNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoHydronorthImobiliariaNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoHydronorthImobiliariaNovasFormulas.fRetFator(fltMaior: Double; fltMenor: Double): Double;
begin
  Result := fltMaior / fltMenor;
end;

end.
