{***********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta General *}
{********************************************************************************AC*}
unit untGravandoExecucaoGeneralNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math;

type
  TGravandoExecucaoGeneralNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm: string;
    procedure RemoverNovasFormulas();
    procedure GerarMd5CadGEN(strCodNfm : String);
  public
    constructor Create(const strCodNfm: string = '');
    function fGetNomeGravacao: string;
    procedure Executar(const gravando: IGravando);
    function fHabilitaOpcao(): Boolean;

  end;

implementation

uses
  untStatusGravando, untFuncoesGenerica;

{ TGravandoExecucaoGeneralNovasFormulas }

constructor TGravandoExecucaoGeneralNovasFormulas.Create(
  const strCodNfm: string);
begin
  inherited Create();
  Self.strCodNfm := strCodNfm;
end;

procedure TGravandoExecucaoGeneralNovasFormulas.GerarMd5CadGEN(strCodNfm : String);
var
  qrySelect: IDataSet;
  strMd5: String;
  intContador: Integer;
begin

  qrySelect := TAutcomTintaFactory.Get.fGetDataSet;
  qrySelect.SQL := 'SELECT *            '+
                   '  FROM GEN_CADGEN   '+
                   ' WHERE GEN_CODNFM = ' + QuotedStr(strCodNfm);
  qrySelect.Open;

  qrySelect.First;

  While Not qrySelect.Eof Do
  Begin
    strMd5 := '';

    strMd5 := strMd5 + qrySelect.FieldByName('AUTOINCREM').AsString;
    strMd5 := strMd5 + qrySelect.FieldByName('GEN_CODIGO').AsString;
    strMd5 := strMd5 + qrySelect.FieldByName('GEN_VARIAC').AsString;
    strMd5 := strMd5 + qrySelect.FieldByName('GEN_DESCRI').AsString;
    strMd5 := strMd5 + qrySelect.FieldByName('GEN_CODMON').AsString;
    strMd5 := strMd5 + qrySelect.FieldByName('GEN_ANOINI').AsString;
    strMd5 := strMd5 + qrySelect.FieldByName('GEN_ANOFIM').AsString;

    for intContador := 1 to 20 do
    begin
      strMd5 := strMd5 + qrySelect.FieldByName('GEN_FORM' + TStrUtils.fStrZero(IntToStr(intContador), 2)).AsString;
      strMd5 := strMd5 + StringReplace(FormatFloat('0.0000', qrySelect.FieldByName('GEN_QTDC' + TStrUtils.fStrZero(IntToStr(intContador), 2)).AsFloat),
        ',', '.', [rfReplaceAll]);
    end;

    strMd5 := GetMD5(strMd5);

    qrySelect.Edit;
    qrySelect.FieldByName('GEN_MD5KEY').AsString := strMd5;
    qrySelect.Post;

    qrySelect.Next;
  End;
end;


procedure TGravandoExecucaoGeneralNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm: IDataSet;
  qryGEN: IDataSet;
  intCont: Integer;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := 'SELECT * FROM GEN_CADNFM';

      if strCodNfm <> '' then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODIGO = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;

      If gravando.Status <> sgGravando Then
        Exit;

      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('GEN_CADGEN', false);
      gravando.Texto := 'PROCOD verificado com sucesso!';

      qryGEN := TAutcomTintaFactory.Get.fGetDataSet;

      while (not qryCadNfm.Eof) and (gravando.Status = sgGravando) do
      begin
        If gravando.Status <> sgGravando Then
          Exit;

        qryGEN.SQL := TAutcomTintaFactory.Get.GetInsert('GEN_CADGEN');

        qryGEN.SQL := ' INSERT INTO GEN_CADGEN(AUTOINCREM, '+
                      '                        GEN_CODEMP, '+
                      '                        GEN_CODIGO, '+
                      '                        GEN_VARIAC, '+
                      '                        GEN_DESCRI, '+
                      '                        GEN_CODMON, '+
                      '                        GEN_OBSERV, '+
                      '                        GEN_CODNFM, '+
                      '                        GEN_ATIVAD, '+
                      '                        GEN_ANOINI, '+
                      '                        GEN_ANOFIM, '+
                      '                        GEN_DTACAD, ';

        For intCont := 1 To 20 Do
        Begin
          qryGEN.SQL := qryGEN.SQL + ' GEN_FORM' + TStrUtils.fStrZero(intCont, 2) + ', '+
                                     ' GEN_QTDC' + TStrUtils.fStrZero(intCont, 2) + ', ';
        End;

        qryGEN.SQL := qryGEN.SQL + ' GEN_ACRMOB) ';


        qryGEN.SQL := qryGEN.SQL + ' VALUES (:AUTOINCREM, '+
                                   '         :GEN_CODEMP, '+
                                   '         :GEN_CODIGO, '+
                                   '         :GEN_VARIAC, '+
                                   '         :GEN_DESCRI, '+
                                   '         :GEN_CODMON, '+
                                   '         :GEN_OBSERV, '+
                                   '         :GEN_CODNFM, '+
                                   '         :GEN_ATIVAD, '+
                                   '         :GEN_ANOINI, '+
                                   '         :GEN_ANOFIM, '+
                                   '         :GEN_DTACAD, ';


        For intCont := 1 To 20 Do
        Begin
          qryGEN.SQL := qryGEN.SQL + ' :GEN_FORM' + TStrUtils.fStrZero(intCont, 2) + ', ' +
                                     ' :GEN_QTDC' + TStrUtils.fStrZero(intCont, 2) + ', ';
        End;

        qryGEN.SQL := qryGEN.SQL + ' :GEN_ACRMOB) ';


        qryGEN.ParamByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('GEN_CADGEN', TAutcomTintaFactory.Get.GetCodEmp);
        qryGEN.ParamByName('GEN_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
        qryGEN.ParamByName('GEN_CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODIGO').AsString;
        qryGEN.ParamByName('GEN_VARIAC').AsString := qryCadNfm.FieldByName('NFM_VARIAC').AsString;
        qryGEN.ParamByName('GEN_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
        qryGEN.ParamByName('GEN_OBSERV').AsString := qryCadNfm.FieldByName('NFM_OBSERV').AsString;
        qryGEN.ParamByName('GEN_CODMON').AsString := qryCadNfm.FieldByName('NFM_CODMON').AsString;
        qryGEN.ParamByName('GEN_ATIVAD').AsString := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
        qryGEN.ParamByName('GEN_CODNFM').AsString := qryCadNfm.FieldByName('NFM_CODIGO').AsString;
        qryGEN.ParamByName('GEN_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;
        qryGEN.ParamByName('GEN_ANOINI').AsString := qryCadNfm.FieldByName('NFM_ANOINI').AsString;
        qryGEN.ParamByName('GEN_ANOFIM').AsString := qryCadNfm.FieldByName('NFM_ANOFIM').AsString;
        qryGEN.ParamByName('GEN_DTACAD').AsDateTime   := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;

        For intCont := 1 To 20 Do
        Begin
          If TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString) Then
            Break;

          qryGEN.ParamByName('GEN_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString);
          qryGEN.ParamByName('GEN_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat;
        End;


        qryGEN.ExecSQL;

        GerarMd5CadGEN(qryCadNfm.FieldByName('NFM_CODIGO').AsString);

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

function TGravandoExecucaoGeneralNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoGeneralNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

procedure TGravandoExecucaoGeneralNovasFormulas.RemoverNovasFormulas;
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
          '   GEN_CADGEN                  ' +
          ' WHERE GEN_CODIGO IN           ' +
          '   (SELECT                     ' +
          '     NFM_CODIGO                ' +
          '   FROM                        ' +
          '     GEN_CADNFM)               ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE                                 ' +
          ' FROM                                   ' +
          '   GEN_CADGEN                           ' +
          ' WHERE GEN_CODIGO IN                    ' +
          '   (SELECT                              ' +
          '     NFM_CODIGO                         ' +
          '   FROM                                 ' +
          '     GEN_CADNFM                         ' +
          '   WHERE NFM_CODIGO = ' + QuotedStr(strCodNfm) + ') ';
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
