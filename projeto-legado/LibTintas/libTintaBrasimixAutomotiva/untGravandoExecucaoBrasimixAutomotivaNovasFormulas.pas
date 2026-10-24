{***********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta BrasimixAutomotiva *}
{********************************************************************************AC*}
unit untGravandoExecucaoBrasimixAutomotivaNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math;

type
  TGravandoExecucaoBrasimixAutomotivaNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm: string;
    procedure RemoverNovasFormulas();
  public
    constructor Create(const strCodNfm: string = '');
    function fGetNomeGravacao: string;
    procedure Executar(const gravando: IGravando);
    function fHabilitaOpcao(): Boolean;

  end;

implementation

uses
  untStatusGravando, untFuncoesGenerica;

{ TGravandoExecucaoBrasimixAutomotivaNovasFormulas }

constructor TGravandoExecucaoBrasimixAutomotivaNovasFormulas.Create(
  const strCodNfm: string);
begin
  inherited Create();
  Self.strCodNfm := strCodNfm;
end;

procedure TGravandoExecucaoBrasimixAutomotivaNovasFormulas.Executar(const gravando: IGravando);
Var
  qryCadNfm: IDataSet;
  qryBZA   : IDataSet;
  qrySEQ   : IDataSet;
  intCont  : Integer;
  strMd5   : String;
  intCodSeq: Integer;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := 'SELECT * FROM BZA_CADNFM';

      if strCodNfm <> '' then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;

      If gravando.Status <> sgGravando Then
        Exit;

      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('BZA_CADBZA', false);
      gravando.Texto := 'PROCOD verificado com sucesso!';

      qrySEQ := TAutcomTintaFactory.Get.fGetDataSet;
      qrySEQ.SQL := 'SELECT MAX(CONVERT(BZA_CODSEQ, DECIMAL)) AS SEQUENCIA '+
                    '  FROM BZA_CADBZA ';
      qrySEQ.Open;

      intCodSeq := qrySEQ.FieldByName('SEQUENCIA').AsInteger;

      qryBZA := TAutcomTintaFactory.Get.fGetDataSet;

      while (not qryCadNfm.Eof) and (gravando.Status = sgGravando) do
      begin
        If gravando.Status <> sgGravando Then
          Exit;

        qryBZA.SQL := ' INSERT INTO BZA_CADBZA(AUTOINCREM, '+
                      '                        BZA_CODEMP, '+
                      '                        BZA_CODSEQ, '+
                      '                        BZA_MONTAD, '+
                      '                        BZA_A_N_O_, '+
                      '                        BZA_DESCRI, '+
                      '                        BZA_CODUNI, '+
                      '                        BZA_ARQTXT, '+
                      '                        BZA_CODNFM, '+
                      '                        BZA_MD5KEY, '+
                      '                        BZA_DTACAD, '+
                      '                        BZA_ATIVAD, ';

        For intCont := 1 To 20 Do
        Begin
          qryBZA.SQL := qryBZA.SQL + ' BZA_CODB' + TStrUtils.fStrZero(intCont, 2) + ', '+
                                     ' BZA_QTDB' + TStrUtils.fStrZero(intCont, 2) + ', ';
        End;

        qryBZA.SQL := qryBZA.SQL + ' BZA_ACRMOB) ';


        qryBZA.SQL := qryBZA.SQL + ' VALUES (:AUTOINCREM, '+
                                   '         :BZA_CODEMP, '+
                                   '         :BZA_CODSEQ, '+
                                   '         :BZA_MONTAD, '+
                                   '         :BZA_A_N_O_, '+
                                   '         :BZA_DESCRI, '+
                                   '         :BZA_CODUNI, '+
                                   '         :BZA_ARQTXT, '+
                                   '         :BZA_CODNFM, '+
                                   '         :BZA_MD5KEY, '+
                                   '         :BZA_DTACAD, '+
                                   '         :BZA_ATIVAD, ';


        For intCont := 1 To 20 Do
        Begin
          qryBZA.SQL := qryBZA.SQL + ' :BZA_CODB' + TStrUtils.fStrZero(intCont, 2) + ', ' +
                                     ' :BZA_QTDB' + TStrUtils.fStrZero(intCont, 2) + ', ';
        End;

        qryBZA.SQL := qryBZA.SQL + ' :BZA_ACRMOB) ';

        intCodSeq := (intCodSeq + 1);

        qryBZA.ParamByName('AUTOINCREM').AsString   := TAutcomTintaFactory.Get.fRetAutoIncrem('BZA_CADBZA', TAutcomTintaFactory.Get.GetCodEmp);
        qryBZA.ParamByName('BZA_CODEMP').AsString   := TAutcomTintaFactory.Get.GetCodEmp;
        qryBZA.ParamByName('BZA_CODSEQ').AsString   := IntToStr( intCodSeq );
        qryBZA.ParamByName('BZA_MONTAD').AsString   := qryCadNfm.FieldByName('NFM_MONTAD').AsString;
        qryBZA.ParamByName('BZA_A_N_O_').AsString   := qryCadNfm.FieldByName('NFM_A_N_O_').AsString;
        qryBZA.ParamByName('BZA_DESCRI').AsString   := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
        qryBZA.ParamByName('BZA_CODUNI').AsString   := qryCadNfm.FieldByName('NFM_CODUNI').AsString;
        qryBZA.ParamByName('BZA_ARQTXT').AsString   := qryCadNfm.FieldByName('NFM_TIPO__').AsString;
        qryBZA.ParamByName('BZA_CODNFM').AsString   := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
        qryBZA.ParamByName('BZA_ACRMOB').AsFloat    := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;
        qryBZA.ParamByName('BZA_ATIVAD').AsString   := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
        qryBZA.ParamByName('BZA_DTACAD').AsDateTime := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;

        For intCont := 1 To 20 Do
        Begin
          If TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intCont, 2)).AsString) Then
            Break;

          qryBZA.ParamByName('BZA_CODB' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intCont, 2)).AsString);
          qryBZA.ParamByName('BZA_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat;
        End;

        strMd5 := '';
        strMd5 := (qryBZA.ParamByName('BZA_CODNFM').AsString +
                   qryBZA.ParamByName('BZA_MONTAD').AsString +
                   qryBZA.ParamByName('BZA_A_N_O_').AsString +
                   qryBZA.ParamByName('BZA_DESCRI').AsString +
                   qryBZA.ParamByName('BZA_CODUNI').AsString +
                   qryBZA.ParamByName('BZA_ARQTXT').AsString);


        for intCont := 1 to 20 do
        begin
          If TStrUtils.fEmptyStr(qryBZA.ParamByName('BZA_CODB' + TStrUtils.fStrZero(intCont, 2)).AsString) Then
            Break;

          strMd5 := strMd5 + qryBZA.ParamByName('BZA_CODB' + TStrUtils.fStrZero(IntToStr(intCont), 2)).AsString;
          strMd5 := strMd5 + StringReplace(FormatFloat('0.0000', qryBZA.ParamByName('BZA_QTDB' + TStrUtils.fStrZero(IntToStr(intCont), 2)).AsFloat),
            ',', '.', [rfReplaceAll]);
        end;

        strMd5 := GetMD5(strMd5);

        qryBZA.ParamByName('BZA_MD5KEY').AsString := strMd5;
        qryBZA.ExecSQL;

        gravando.RegistrarProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);

        qryCadNfm.Next;
      end;
    Except
      on E: Exception do
      begin
        gravando.Cancelar;
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally

  End;
end;

function TGravandoExecucaoBrasimixAutomotivaNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoBrasimixAutomotivaNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

procedure TGravandoExecucaoBrasimixAutomotivaNovasFormulas.RemoverNovasFormulas;
var
  qryBZA: IDataSet;
begin
  Try
    Try
      qryBZA := TAutcomTintaFactory.Get.fGetDataSet;
      if TStrUtils.fEmptyStr(strCodNfm) then
      begin
        qryBZA.SQL :=
          ' DELETE                        ' +
          ' FROM                          ' +
          '   BZA_CADBZA                  ' +
          ' WHERE BZA_CODNFM IN           ' +
          '   (SELECT                     ' +
          '     NFM_CODNFM                ' +
          '   FROM                        ' +
          '     BZA_CADNFM)               ';
      end
      else
      begin
        qryBZA.SQL :=
          ' DELETE                                 ' +
          ' FROM                                   ' +
          '   BZA_CADBZA                           ' +
          ' WHERE BZA_CODNFM IN                    ' +
          '   (SELECT                              ' +
          '     NFM_CODNFM                         ' +
          '   FROM                                 ' +
          '     BZA_CADNFM                         ' +
          '   WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm) + ') ';
      end;

      qryBZA.ExecSQL;
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
