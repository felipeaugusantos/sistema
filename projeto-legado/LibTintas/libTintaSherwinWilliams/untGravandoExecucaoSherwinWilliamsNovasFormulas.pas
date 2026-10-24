{******************************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta SherwinWilliams *}
{***************************************************************************************AC*}
unit untGravandoExecucaoSherwinWilliamsNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math, Variants;

type
  TGravandoExecucaoSherwinWilliamsNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm        : string;
    blnGerarUnidades : Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;
    procedure RemoverNovasFormulas();
    function fGetUnidadesGeracaoCadNfm(strUnidade: String): String;
    function fRetProximoCodSeq: Integer;

    function fConverteQtdEmb(fltQtd : Double; strUniOri, strUniNov: String): Double;
  public
    constructor Create(const strCodNfm: string = ''; blnGerarUnidades : Boolean = true;
      const blnAtualizarUnidade: Boolean = False; const strUnidadeMenor: String = ''    );
    function fGetNomeGravacao: string;
    function fHabilitaOpcao(): Boolean;
    procedure Executar(const gravando: IGravando);
  end;

implementation

uses
  untStatusGravando, untFuncoesGenerica;

{ TGravandoExecucaoSherwinWilliamsNovasFormulas }

constructor TGravandoExecucaoSherwinWilliamsNovasFormulas.Create(const strCodNfm: string = '';
  blnGerarUnidades : Boolean = true; const blnAtualizarUnidade: Boolean = False;
  const strUnidadeMenor: String = '');
begin
  inherited Create();
  Self.strCodNfm   := strCodNfm;
  Self.blnGerarUnidades := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor := strUnidadeMenor;
end;

procedure TGravandoExecucaoSherwinWilliamsNovasFormulas.Executar(const gravando: IGravando);
//const
//  arrUnidades: array[0..2] of string = ('LT', 'GL', 'LA');
//  arrPesos: array[0..2] of Double = (1, 4, 20);
var
  qryCadNfm          : IDataSet;
  qryCadSHE          : IDataSet;
  qryCadBas          : IDataSet;
  intCont            : Integer;

  intCodSeq          : Integer;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := ' SELECT *           ' +
                       '   FROM SHE_CADNFM  ';

      if strCodNfm <> '' then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODPRO = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;
      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      qryCadSHE := TAutcomTintaFactory.Get.fGetDataSet;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('SHE_CADSHE');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      intCodSeq := fRetProximoCodSeq;

      while (not qryCadNfm.Eof) and (gravando.Status = sgGravando) do
      begin
        Try
          Try
            qryCadBas := TAutcomTintaFactory.Get.fGetDataSet;
            qryCadBas.SQL := 'SELECT * FROM SHE_CADBAS WHERE BAS_BASE__ = :BASE AND BAS_PROKEY = :PROKEY AND BAS_SUBKEY = :SUBKEY';

            If Not blnGerarUnidades Then
              qryCadBas.SQL := qryCadBas.SQL + ' AND BAS_UNIDAD = :CODUNI ';

            If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
              qryCadBas.SQL := qryCadBas.SQL + ' AND BAS_UNIDAD <> :CODUNI ';

            //Geracao do cadastro de novas formulas
            If TStrUtils.fEmptyStr(strCodNfm) Then
              qryCadBas.SQL := qryCadBas.SQL + fGetUnidadesGeracaoCadNfm(qryCadNfm.FieldByName('NFM_UNIDAD').AsString);

            qryCadBas.ParamByName('BASE').AsString   := qryCadNfm.FieldByName('NFM_BASE__').AsString;
            qryCadBas.ParamByName('PROKEY').AsString := qryCadNfm.FieldByName('NFM_PROKEY').AsString;
            qryCadBas.ParamByName('SUBKEY').AsString := qryCadNfm.FieldByName('NFM_SUBKEY').AsString;

            If Not blnGerarUnidades Then
              qryCadBas.ParamByName('CODUNI').AsString := qryCadNfm.FieldByName('NFM_UNIDAD').AsString;

            If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
              qryCadBas.ParamByName('CODUNI').AsString := strUnidadeMenor;

            qryCadBas.Open;
            qryCadBas.First;

            While Not qryCadBas.Eof Do
            begin

              qryCadSHE.SQL := TAutcomTintaFactory.Get.GetInsert('SHE_CADSHE');

              qryCadSHE.ParamByName('SHE_CODSEQ').AsString := TStrUtils.fStrZero(intCodSeq, 6);
              qryCadSHE.ParamByName('SHE_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString + ' ' + qryCadNfm.FieldByName('NFM_CODPRO').AsString;
              qryCadSHE.ParamByName('SHE_COMMEN').AsString := qryCadNfm.FieldByName('NFM_COMMEN').AsString;
              qryCadSHE.ParamByName('SHE_CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODPRO').AsString;
              qryCadSHE.ParamByName('SHE_CODIG2').AsString := qryCadNfm.FieldByName('NFM_CODPRO').AsString;
              qryCadSHE.ParamByName('SHE_UNIDAD').AsString := qryCadBas.FieldByName('BAS_UNIDAD').AsString;
              qryCadSHE.ParamByName('SHE_DTACAD').AsDateTime := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
              qryCadSHE.ParamByName('SHE_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

              qryCadSHE.ParamByName('SHE_PREVEN').AsFloat  := 0.0;
              qryCadSHE.ParamByName('SHE_PRECUS').AsFloat  := 0.0;
              qryCadSHE.ParamByName('SHE_COLVEN').AsFloat  := 0.0;
              qryCadSHE.ParamByName('SHE_COLCUS').AsFloat  := 0.0;
              qryCadSHE.ParamByName('SHE_CODITE').Value    := Null;
              qryCadSHE.ParamByName('SHE_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;

              qryCadSHE.ParamByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('SHE_CADSHE', TAutcomTintaFactory.Get.GetCodEmp);

              for intCont := 1 to 20 do
              begin
                If TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_COL0' + TStrUtils.fStrZero(intCont, 2)).AsString) Then
                  Break;

                qryCadSHE.ParamByName('SHE_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_COL0' + TStrUtils.fStrZero(intCont, 2)).AsString);

                qryCadSHE.ParamByName('SHE_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat  :=
                  fConverteQtdEmb(qryCadNfm.FieldByName('NFM_QTD0' + TStrUtils.fStrZero(intCont, 2)).AsFloat,
                                    qryCadNfm.FieldByName('NFM_UNIDAD').AsString,
                                    qryCadBas.FieldByName('BAS_UNIDAD').AsString);
              end;

              qryCadSHE.ParamByName('SHE_BASE__').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;
              qryCadSHE.ParamByName('SHE_PROKEY').AsString := qryCadNfm.FieldByName('NFM_PROKEY').AsString;
              qryCadSHE.ParamByName('SHE_SUBKEY').AsString := qryCadNfm.FieldByName('NFM_SUBKEY').AsString;
//              qryCadSHE.ParamByName('SHE_COMMEN').AsString := '';

              qryCadSHE.ParamByName('SHE_ATIVAD').AsString := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
              qryCadSHE.ParamByName('SHE_MD5KEY').AsString := GetMD5(qryCadSHE.ParamByName('SHE_DESCRI').AsString + ' ' +
                                                                     qryCadSHE.ParamByName('SHE_CODIGO').AsString + ' ' +
                                                                     qryCadSHE.ParamByName('SHE_CODIG2').AsString + ' ' +
                                                                     qryCadSHE.ParamByName('SHE_UNIDAD').AsString);


              qryCadSHE.ExecSQL;

              if not (blnGerarUnidades) then
                Exit;

              Inc(intCodSeq);

              qryCadBas.Next;
            end;
          Except
            on E: Exception do
            begin
              gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
            end;
          End;
        Finally
          qryCadNfm.Next;
          gravando.RegistrarProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);
        End;
      end;

    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally

  End;
end;

function TGravandoExecucaoSherwinWilliamsNovasFormulas.fConverteQtdEmb(fltQtd : Double; strUniOri, strUniNov: String): Double;
  Var
    qryGen: IDataSet;
    fltUniOri: Double;
    fltUniNov: Double;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT * FROM SHE_CADEMB';
  qryGen.Open;

  qryGen.Locate('EMB_UNIDAD', strUniOri, []);
  fltUniOri := qryGen.FieldByName('EMB_QTDEMB').AsFloat;

  qryGen.Locate('EMB_UNIDAD', strUniNov, []);
  fltUniNov := qryGen.FieldByName('EMB_QTDEMB').AsFloat;

  Result := fltUniNov * fltQtd / fltUniOri;
end;

function TGravandoExecucaoSherwinWilliamsNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoSherwinWilliamsNovasFormulas.fGetUnidadesGeracaoCadNfm(
  strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'GL' Then
    Result := ' AND BAS_UNIDAD IN ("GL","LA") '
  Else If strUnidade = 'LA' Then
    Result := ' AND BAS_UNIDAD = "LA" ';
end;

function TGravandoExecucaoSherwinWilliamsNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoSherwinWilliamsNovasFormulas.fRetProximoCodSeq: Integer;
  Var
    qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := 'SELECT IFNULL(MAX(SHE_CODSEQ), 0) + 1 AS MAXIMO FROM SHE_CADSHE;';
    qryGen.Open;

    Result := qryGen.FieldByName('MAXIMO').AsInteger;
  Except
    Raise;
  End;
end;

procedure TGravandoExecucaoSherwinWilliamsNovasFormulas.RemoverNovasFormulas;
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      if TStrUtils.fEmptyStr(strCodNfm) then
      begin
        qryGen.SQL :=
          ' DELETE                        ' +
          ' FROM                          ' +
          '   SHE_CADSHE                  ' +
          ' WHERE SHE_CODIGO IN           ' +
          '   (SELECT                     ' +
          '     NFM_CODPRO                ' +
          '   FROM                        ' +
          '     SHE_CADNFM)               ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE                                 ' +
          ' FROM                                   ' +
          '   SHE_CADSHE                        ' +
          ' WHERE SHE_CODIGO IN                    ' +
          '   (SELECT                              ' +
          '     NFM_CODPRO                         ' +
          '   FROM                                 ' +
          '     SHE_CADNFM                         ' +
          '   WHERE NFM_CODPRO = ' + QuotedStr(strCodNfm) + ') ';
      end;

      qryGen.ExecSQL;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;
end;

end.

