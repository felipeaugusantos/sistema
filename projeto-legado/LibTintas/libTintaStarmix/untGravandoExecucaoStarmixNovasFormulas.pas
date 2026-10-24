{*************************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta Starmix *}
{**********************************************************************************AC*}
unit untGravandoExecucaoStarmixNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math;

type
  TGravandoExecucaoStarmixNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm: string;
    procedure RemoverNovasFormulas();
  public
    constructor Create(const strCodNfm: string = '');
    function fGetNomeGravacao: string;
    procedure Executar(const gravando: IGravando);
    function fRetProCodSeq : Integer;
    function fHabilitaOpcao(): Boolean;
  end;

implementation

uses
  untStatusGravando, untFuncoesGenerica;

{ TGravandoExecucaoStarmixNovasFormulas }

constructor TGravandoExecucaoStarmixNovasFormulas.Create(
  const strCodNfm: string);
begin
  inherited Create();
  Self.strCodNfm := strCodNfm;
end;

procedure TGravandoExecucaoStarmixNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm: IDataSet;
  qryCadSTA: IDataSet;
  intCont  : Integer;
  fltPesFor: Double;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := 'SELECT * FROM STA_CADNFM';

      if not TStrUtils.fEmptyStr(strCodNfm) then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;

      If gravando.Status <> sgGravando Then
        Exit;

      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('STA_CADSTA', False);
      gravando.Texto := 'PROCOD verificado com sucesso!';

      qryCadSTA := TAutcomTintaFactory.Get.fGetDataSet;



      while (not qryCadNfm.Eof) and (gravando.Status = sgGravando) do
      begin
        If gravando.Status <> sgGravando Then
          Exit;

        fltPesFor := 0;

        qryCadSTA.SQL := TAutcomTintaFactory.Get.GetInsert('STA_CADSTA');

        qryCadSta.ParamByName('STA_CODSEQ').AsString   :=  TStrUtils.fStrZero(fRetProCodSeq,6);
        qryCadSta.ParamByName('STA_NOMCOR').AsString   := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
        qryCadSta.ParamByName('STA_ANOCOR').AsString   := qryCadNfm.FieldByName('NFM_A_N_O_').AsString;
        qryCadSta.ParamByName('STA_CODLIN').AsString   := qryCadNfm.FieldByName('NFM_CODLIN').AsString;
        qryCadSta.ParamByName('STA_MONTAD').AsString   := qryCadNfm.FieldByName('NFM_MONTAD').AsString;
        qryCadSta.ParamByName('STA_UNIVER').AsString   := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
        qryCadSta.ParamByName('STA_UNIDAD').AsString   := 'LT';
        qryCadSta.ParamByName('STA_DESLIN').AsString   := '';
        qryCadSta.ParamByName('AUTOINCREM').AsString   := TAutcomTintaFactory.Get.fRetAutoIncrem('STA_CADSTA', TAutcomTintaFactory.Get.GetCodEmp);
        qryCadSta.ParamByName('STA_ACRMOB').AsFloat    := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;
        qryCadSta.ParamByName('STA_DTACAD').AsDateTime := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;

        For intCont := 1 To 20 Do
        Begin
          If (TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intCont, 2)).AsString)) Then
          Begin
            Break;
          End;

          qryCadSTA.ParamByName('STA_CODB' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intCont, 2)).AsString);

          qryCadSTA.ParamByName('STA_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat  :=
            qryCadNfm.FieldByName('NFM_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat / 9;

          fltPesFor := fltPesFor + qryCadNfm.FieldByName('NFM_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat / 9;
        End;

        qryCadSTA.ParamByName('STA_PESCOR').AsFloat := fltPesFor / 100;
        qryCadSTA.ParamByName('STA_PESFOR').AsFloat := fltPesFor;

        qryCadSTA.ParamByName('STA_MD5KEY').AsString := GetMD5(qryCadSTA.ParamByName('STA_CODSEQ').AsString +
                                                               qryCadSTA.ParamByName('STA_NOMCOR').AsString +
                                                               qryCadSTA.ParamByName('STA_ANOCOR').AsString +
                                                               qryCadSTA.ParamByName('STA_CODLIN').AsString +
                                                               qryCadSTA.ParamByName('STA_MONTAD').AsString);

        qryCadSTA.ExecSQL;

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

function TGravandoExecucaoStarmixNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoStarmixNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoStarmixNovasFormulas.fRetProCodSeq: Integer;
  Var
    qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT IFNULL(MAX(STA_CODSEQ),0) + 1 PROX '+
                '  FROM STA_CADSTA;';
  qryGen.Open;

  Result := qryGen.FieldByName('PROX').AsInteger;
end;

procedure TGravandoExecucaoStarmixNovasFormulas.RemoverNovasFormulas;
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
          '   STA_CADSTA                  ' +
          ' WHERE STA_UNIVER IN           ' +
          '   (SELECT                     ' +
          '     NFM_CODNFM                ' +
          '   FROM                        ' +
          '     STA_CADNFM)               ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE                                 ' +
          ' FROM                                   ' +
          '   STA_CADSTA                           ' +
          ' WHERE STA_UNIVER IN                    ' +
          '   (SELECT                              ' +
          '     NFM_CODNFM                         ' +
          '   FROM                                 ' +
          '     STA_CADNFM                         ' +
          '   WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm) + ') ';
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
