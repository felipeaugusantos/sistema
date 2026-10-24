{***********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta MazaAutomotiva *}
{********************************************************************************AC*}
unit untGravandoExecucaoMazaAutomotivaNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math;

type
  TGravandoExecucaoMazaAutomotivaNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm: string;
    procedure RemoverNovasFormulas();
    procedure GerarMd5CadMZA(strCodNfm : String);
  public
    constructor Create(const strCodNfm: string = '');
    function fGetNomeGravacao: string;
    procedure Executar(const gravando: IGravando);
    function fHabilitaOpcao(): Boolean;
  end;

implementation

uses
  untStatusGravando, untFuncoesGenerica;

{ TGravandoExecucaoMazaAutomotivaNovasFormulas }

constructor TGravandoExecucaoMazaAutomotivaNovasFormulas.Create(
  const strCodNfm: string);
begin
  inherited Create();
  Self.strCodNfm := strCodNfm;
end;

procedure TGravandoExecucaoMazaAutomotivaNovasFormulas.GerarMd5CadMZA(strCodNfm : String);
var
  qrySelect: IDataSet;
  strMd5: String;
  intContador: Integer;
begin

  qrySelect := TAutcomTintaFactory.Get.fGetDataSet;
  qrySelect.SQL := 'SELECT *            '+
                   '  FROM MZA_CADMZA   '+
                   ' WHERE MZA_CODNFM = ' + QuotedStr(strCodNfm);
  qrySelect.Open;

  qrySelect.First;

  While Not qrySelect.Eof Do
  Begin
    strMd5 := '';

    strMd5 := strMd5 + qrySelect.FieldByName('MZA_CODIGO').AsString;
    strMd5 := strMd5 + qrySelect.FieldByName('MZA_VARIAC').AsString;
    strMd5 := strMd5 + qrySelect.FieldByName('MZA_DESCRI').AsString;
    strMd5 := strMd5 + qrySelect.FieldByName('MZA_ANOCOR').AsString;
    strMd5 := strMd5 + qrySelect.FieldByName('MZA_DTAFOR').AsString;
    strMd5 := strMd5 + qrySelect.FieldByName('MZA_LINHA_').AsString;
    strMd5 := strMd5 + qrySelect.FieldByName('MZA_CODMON').AsString;
    strMd5 := strMd5 + qrySelect.FieldByName('MZA_CODNFM').AsString;
    strMd5 := strMd5 + qrySelect.FieldByName('MZA_UNIVER').AsString;

    for intContador := 1 to 20 do
    begin
      strMd5 := strMd5 + qrySelect.FieldByName('MZA_FORM' + TStrUtils.fStrZero(IntToStr(intContador), 2)).AsString;
      strMd5 := strMd5 + StringReplace(FormatFloat('0.0000', qrySelect.FieldByName('MZA_QTDC' + TStrUtils.fStrZero(IntToStr(intContador), 2)).AsFloat),
        ',', '.', [rfReplaceAll]);
    end;

    strMd5 := GetMD5(strMd5);

    qrySelect.Edit;
    qrySelect.FieldByName('MZA_MD5KEY').AsString := strMd5;
    qrySelect.Post;

    qrySelect.Next;
  End;
end;


procedure TGravandoExecucaoMazaAutomotivaNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm: IDataSet;
  qryMza: IDataSet;
  intCont: Integer;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := 'SELECT * FROM MZA_CADNFM';

      if strCodNfm <> '' then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODIGO = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;

      If gravando.Status <> sgGravando Then
        Exit;

      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('MZA_CADMZA');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      qryMza := TAutcomTintaFactory.Get.fGetDataSet;

      while (not qryCadNfm.Eof) and (gravando.Status = sgGravando) do
      begin
        If gravando.Status <> sgGravando Then
          Exit;

        qryMza.SQL := TAutcomTintaFactory.Get.GetInsert('MZA_CADMZA');

        qryMza.SQL := ' INSERT INTO MZA_CADMZA   '+
                      '             (AUTOINCREM, '+
                      '              MZA_CODEMP, '+
                      '              MZA_CODIGO, '+
                      '              MZA_VARIAC, '+
                      '              MZA_DESCRI, '+
                      '              MZA_OBSERV, '+
                      '              MZA_ANOCOR, '+
                      '              MZA_PESCOR, '+
                      '              MZA_PESFOR, '+
                      '              MZA_DTAFOR, '+
                      '              MZA_LINHA_, '+
                      '              MZA_CODMON, '+
                      '              MZA_ATIVAD, '+
                      '              MZA_DTACAD, '+
                      '              MZA_CODNFM, '+
                      '              MZA_BAIQDI, ';

        For intCont := 1 To 20 Do
        Begin
          qryMza.SQL := qryMza.SQL + ' MZA_FORM' + TStrUtils.fStrZero(intCont, 2) + ', '+
                                     ' MZA_QTDC' + TStrUtils.fStrZero(intCont, 2) + ', ';
        End;

        qryMza.SQL := qryMza.SQL + '          MZA_UNIVER, '+
                                   '          MZA_ACRMOB) '+
                                   ' VALUES (:AUTOINCREM, '+
                                   '         :MZA_CODEMP, '+
                                   '         :MZA_CODIGO, '+
                                   '         :MZA_VARIAC, '+
                                   '         :MZA_DESCRI, '+
                                   '         :MZA_OBSERV, '+
                                   '         :MZA_ANOCOR, '+
                                   '         :MZA_PESCOR, '+
                                   '         :MZA_PESFOR, '+
                                   '         :MZA_DTAFOR, '+
                                   '         :MZA_LINHA_, '+
                                   '         :MZA_CODMON, '+
                                   '         :MZA_ATIVAD, '+
                                   '         :MZA_DTACAD, '+
                                   '         :MZA_CODNFM, '+
                                   '         :MZA_BAIQDI, ';

        For intCont := 1 To 20 Do
        Begin
          qryMza.SQL := qryMza.SQL + ' :MZA_FORM' + TStrUtils.fStrZero(intCont, 2) + ', ' +
                                     ' :MZA_QTDC' + TStrUtils.fStrZero(intCont, 2) + ', ';
        End;

        qryMza.SQL := qryMza.SQL + ' :MZA_UNIVER, '+
                                   ' :MZA_ACRMOB);';

        qryMza.ParamByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('MZA_CADMZA', TAutcomTintaFactory.Get.GetCodEmp);
        qryMza.ParamByName('MZA_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
        qryMza.ParamByName('MZA_CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODIGO').AsString;
        qryMza.ParamByName('MZA_VARIAC').AsString := qryCadNfm.FieldByName('NFM_VARIAC').AsString;
        qryMza.ParamByName('MZA_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
        qryMza.ParamByName('MZA_OBSERV').AsString := qryCadNfm.FieldByName('NFM_OBSERV').AsString;
        qryMza.ParamByName('MZA_PESCOR').AsFloat  := qryCadNfm.FieldByName('NFM_PESCOR').AsFloat;
        qryMza.ParamByName('MZA_PESFOR').AsFloat  := qryCadNfm.FieldByName('NFM_PESFOR').AsFloat;
        qryMza.ParamByName('MZA_LINHA_').AsString := qryCadNfm.FieldByName('NFM_LINHA_').AsString;
        qryMza.ParamByName('MZA_CODMON').AsString := qryCadNfm.FieldByName('NFM_CODMON').AsString;
        qryMza.ParamByName('MZA_ATIVAD').AsString := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
        qryMza.ParamByName('MZA_DTACAD').AsDateTime := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
        qryMza.ParamByName('MZA_CODNFM').AsString := qryCadNfm.FieldByName('NFM_CODIGO').AsString;
        qryMza.ParamByName('MZA_BAIQDI').AsString := qryCadNfm.FieldByName('NFM_BAIQDI').AsString;
        qryMza.ParamByName('MZA_ANOCOR').AsString := qryCadNfm.FieldByName('NFM_ANOCOR').AsString;

        For intCont := 1 To 20 Do
        Begin
          If TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString) Then
            Break;

          qryMza.ParamByName('MZA_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString);
          qryMza.ParamByName('MZA_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat;
        End;

        qryMza.ParamByName('MZA_UNIVER').AsString := qryCadNfm.FieldByName('NFM_UNIVER').AsString;
        qryMza.ParamByName('MZA_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

        qryMza.ExecSQL;

        GerarMd5CadMZA(qryCadNfm.FieldByName('NFM_CODIGO').AsString);

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

function TGravandoExecucaoMazaAutomotivaNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoMazaAutomotivaNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

procedure TGravandoExecucaoMazaAutomotivaNovasFormulas.RemoverNovasFormulas;
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
          '   MZA_CADMZA                  ' +
          ' WHERE MZA_CODIGO IN           ' +
          '   (SELECT                     ' +
          '     NFM_CODIGO                ' +
          '   FROM                        ' +
          '     MZA_CADNFM)               ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE                                 ' +
          ' FROM                                   ' +
          '   MZA_CADMZA                           ' +
          ' WHERE MZA_CODIGO IN                    ' +
          '   (SELECT                              ' +
          '     NFM_CODIGO                         ' +
          '   FROM                                 ' +
          '     MZA_CADNFM                         ' +
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
