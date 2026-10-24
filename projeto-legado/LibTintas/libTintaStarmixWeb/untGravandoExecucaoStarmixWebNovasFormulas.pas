{*************************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta StarmixWeb *}
{**********************************************************************************AC*}
unit untGravandoExecucaoStarmixWebNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math;

type
  TGravandoExecucaoStarmixWebNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm: string;
    procedure RemoverNovasFormulas();
  public
    constructor Create(const strCodNfm: string = '');
    function fGetNomeGravacao: string;
    procedure Executar(const gravando: IGravando);
    function fRetCodLinha(strDesLin : String) : String;
    function fHabilitaOpcao(): Boolean;
  end;

implementation

uses
  untStatusGravando, untFuncoesGenerica;

{ TGravandoExecucaoStarmixWebNovasFormulas }

constructor TGravandoExecucaoStarmixWebNovasFormulas.Create(
  const strCodNfm: string);
begin
  inherited Create();
  Self.strCodNfm := strCodNfm;
end;

procedure TGravandoExecucaoStarmixWebNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm: IDataSet;
  qryCadStw: IDataSet;
  intCont: Integer;
  fltPesFor: Double;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := 'SELECT * FROM STW_CADNFM';

      if not TStrUtils.fEmptyStr(strCodNfm) then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;

      If gravando.Status <> sgGravando Then
        Exit;

      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('STW_CADSTW', False);
      gravando.Texto := 'PROCOD verificado com sucesso!';

      qryCadStw := TAutcomTintaFactory.Get.fGetDataSet;

      fltPesFor := 0;

      while (not qryCadNfm.Eof) and (gravando.Status = sgGravando) do
      begin
        If gravando.Status <> sgGravando Then
          Exit;

        qryCadStw.SQL := TAutcomTintaFactory.Get.GetInsert('STW_CADSTW');

        qryCadStw.ParamByName('STW_CODIGO').AsString   := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
        qryCadStw.ParamByName('STW_NOMCOR').AsString   := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
        qryCadStw.ParamByName('STW_ANOCOR').AsString   := qryCadNfm.FieldByName('NFM_ANOFOR').AsString;
        qryCadStw.ParamByName('STW_DTAFOR').AsDateTime := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
        qryCadStw.ParamByName('STW_CODLIN').AsString   := fRetCodLinha(qryCadNfm.FieldByName('NFM_DESLIN').AsString);
        qryCadStw.ParamByName('STW_DESLIN').AsString   := qryCadNfm.FieldByName('NFM_DESLIN').AsString;
        qryCadStw.ParamByName('STW_MONTAD').AsString   := qryCadNfm.FieldByName('NFM_MONTAD').AsString;
        qryCadStw.ParamByName('STW_UNIVER').AsString   := qryCadNfm.FieldByName('NFM_UNIVER').AsString;
        qryCadStw.ParamByName('STW_CODEMP').AsString   := TAutcomTintaFactory.Get.GetCodEmp;
        qryCadStw.ParamByName('AUTOINCREM').AsString   := TAutcomTintaFactory.Get.fRetAutoIncrem('STW_CADSTW', TAutcomTintaFactory.Get.GetCodEmp);
        qryCadStw.ParamByName('STW_ATIVAD').AsString   := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
        qryCadStw.ParamByName('STW_ACRMOB').AsFloat    := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

        For intCont := 1 To 20 Do
        Begin
          If (TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intCont, 2)).AsString)) Then
          Begin
            Break;
          End;

          qryCadStw.ParamByName('STW_CODB' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intCont, 2)).AsString);
          qryCadStw.ParamByName('STW_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat  :=
            qryCadNfm.FieldByName('NFM_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat / 9;

          fltPesFor := fltPesFor + qryCadNfm.FieldByName('NFM_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat / 9;
        End;

        qryCadStw.ParamByName('STW_PESCOR').AsFloat := fltPesFor / 100;
        qryCadStw.ParamByName('STW_PESFOR').AsFloat := fltPesFor;

        qryCadStw.ParamByName('STW_MD5KEY').AsString := GetMD5(qryCadStw.ParamByName('STW_CODIGO').AsString +
                                                               qryCadStw.ParamByName('STW_NOMCOR').AsString +
                                                               qryCadStw.ParamByName('STW_ANOCOR').AsString +
                                                               qryCadStw.ParamByName('STW_CODLIN').AsString +
                                                               qryCadStw.ParamByName('STW_MONTAD').AsString);

        qryCadStw.ExecSQL;

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

function TGravandoExecucaoStarmixWebNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoStarmixWebNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoStarmixWebNovasFormulas.fRetCodLinha(strDesLin: String): String;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT LIN_CODLIN '+
                '  FROM STW_CADLIN '+
                ' WHERE LIN_DESLIN = :DESLIN ';
  qryGen.ParamByName('DESLIN').AsString := strDesLin;
  qryGen.Open;

  Result := qryGen.fieldByName('LIN_CODLIN').AsString;
end;

procedure TGravandoExecucaoStarmixWebNovasFormulas.RemoverNovasFormulas;
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
          '   STW_CADSTW                  ' +
          ' WHERE STW_CODIGO IN           ' +
          '   (SELECT                     ' +
          '     NFM_CODNFM                ' +
          '   FROM                        ' +
          '     STW_CADNFM)               ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE                                 ' +
          ' FROM                                   ' +
          '   STW_CADSTW                           ' +
          ' WHERE STW_CODIGO IN                    ' +
          '   (SELECT                              ' +
          '     NFM_CODNFM                         ' +
          '   FROM                                 ' +
          '     STW_CADNFM                         ' +
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
