{***********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta MazaIndustrial *}
{********************************************************************************AC*}
unit untGravandoExecucaoMazaIndustrialNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math;

type
  TGravandoExecucaoMazaIndustrialNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm: string;
    procedure RemoverNovasFormulas();
    procedure GerarMd5CadMZD(strCodNfm : String);
  public
    constructor Create(const strCodNfm: string = '');
    function fGetNomeGravacao: string;
    function fHabilitaOpcao(): Boolean;
    procedure Executar(const gravando: IGravando);

  end;

implementation

uses
  untStatusGravando, untFuncoesGenerica;

{ TGravandoExecucaoMazaIndustrialNovasFormulas }

constructor TGravandoExecucaoMazaIndustrialNovasFormulas.Create(
  const strCodNfm: string);
begin
  inherited Create();
  Self.strCodNfm := strCodNfm;
end;

procedure TGravandoExecucaoMazaIndustrialNovasFormulas.GerarMd5CadMZD(strCodNfm : String);
var
  qrySelect: IDataSet;
  strMd5: String;
  intContador: Integer;
begin

  qrySelect := TAutcomTintaFactory.Get.fGetDataSet;
  qrySelect.SQL := 'SELECT *            '+
                   '  FROM MZD_CADMZD   '+
                   ' WHERE MZD_CODNFM = ' + QuotedStr(strCodNfm);
  qrySelect.Open;

  qrySelect.First;

  While Not qrySelect.Eof Do
  Begin
    strMd5 := '';

    strMd5 := strMd5 + qrySelect.FieldByName('MZD_CODIGO').AsString;
    strMd5 := strMd5 + qrySelect.FieldByName('MZD_VARIAC').AsString;
    strMd5 := strMd5 + qrySelect.FieldByName('MZD_DESCRI').AsString;
    strMd5 := strMd5 + qrySelect.FieldByName('MZD_ANOCOR').AsString;
    strMd5 := strMd5 + qrySelect.FieldByName('MZD_DTAFOR').AsString;
    strMd5 := strMd5 + qrySelect.FieldByName('MZD_LINHA_').AsString;
    strMd5 := strMd5 + qrySelect.FieldByName('MZD_CODMON').AsString;
    strMd5 := strMd5 + qrySelect.FieldByName('MZD_CODNFM').AsString;
    strMd5 := strMd5 + qrySelect.FieldByName('MZD_UNIVER').AsString;


    for intContador := 1 to 20 do
    begin
      strMd5 := strMd5 + qrySelect.FieldByName('MZD_FORM' + TStrUtils.fStrZero(IntToStr(intContador), 2)).AsString;
      strMd5 := strMd5 + StringReplace(FormatFloat('0.0000', qrySelect.FieldByName('MZD_QTDC' + TStrUtils.fStrZero(IntToStr(intContador), 2)).AsFloat),
        ',', '.', [rfReplaceAll]);
    end;

    strMd5 := GetMD5(strMd5);

    qrySelect.Edit;
    qrySelect.FieldByName('MZD_MD5KEY').AsString := strMd5;
    qrySelect.Post;

    qrySelect.Next;
  End;
end;


procedure TGravandoExecucaoMazaIndustrialNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm: IDataSet;
  qryMZD: IDataSet;
  intCont: Integer;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := 'SELECT * FROM MZD_CADNFM';

      if strCodNfm <> '' then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODIGO = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;

      If gravando.Status <> sgGravando Then
        Exit;

      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('MZD_CADMZD');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      qryMZD := TAutcomTintaFactory.Get.fGetDataSet;

      while (not qryCadNfm.Eof) and (gravando.Status = sgGravando) do
      begin
        If gravando.Status <> sgGravando Then
          Exit;

        qryMZD.SQL := TAutcomTintaFactory.Get.GetInsert('MZD_CADMZD');

        qryMZD.SQL := ' INSERT INTO MZD_CADMZD   '+
                      '             (AUTOINCREM, '+
                      '              MZD_CODEMP, '+
                      '              MZD_CODIGO, '+
                      '              MZD_VARIAC, '+
                      '              MZD_DESCRI, '+
                      '              MZD_OBSERV, '+
                      '              MZD_ANOCOR, '+
                      '              MZD_PESCOR, '+
                      '              MZD_PESFOR, '+
                      '              MZD_DTAFOR, '+
                      '              MZD_LINHA_, '+
                      '              MZD_CODMON, '+
                      '              MZD_CODNFM, '+
                      '              MZD_DTACAD, '+
                      '              MZD_ATIVAD, '+
                      '              MZD_BAIQDI, ';

        For intCont := 1 To 20 Do
        Begin
          qryMZD.SQL := qryMZD.SQL + ' MZD_FORM' + TStrUtils.fStrZero(intCont, 2) + ', '+
                                     ' MZD_QTDC' + TStrUtils.fStrZero(intCont, 2) + ', ';
        End;

        qryMZD.SQL := qryMZD.SQL + '          MZD_UNIVER, '+
                                   '          MZD_ACRMOB) '+
                                   ' VALUES (:AUTOINCREM, '+
                                   '         :MZD_CODEMP, '+
                                   '         :MZD_CODIGO, '+
                                   '         :MZD_VARIAC, '+
                                   '         :MZD_DESCRI, '+
                                   '         :MZD_OBSERV, '+
                                   '         :MZD_ANOCOR, '+
                                   '         :MZD_PESCOR, '+
                                   '         :MZD_PESFOR, '+
                                   '         :MZD_DTAFOR, '+
                                   '         :MZD_LINHA_, '+
                                   '         :MZD_CODMON, '+
                                   '         :MZD_CODNFM, '+
                                   '         :MZD_DTACAD, '+
                                   '         :MZD_ATIVAD, '+
                                   '         :MZD_BAIQDI, ';

        For intCont := 1 To 20 Do
        Begin
          qryMZD.SQL := qryMZD.SQL + ' :MZD_FORM' + TStrUtils.fStrZero(intCont, 2) + ', ' +
                                     ' :MZD_QTDC' + TStrUtils.fStrZero(intCont, 2) + ', ';
        End;

        qryMZD.SQL := qryMZD.SQL + ' :MZD_UNIVER, '+
                                   ' :MZD_ACRMOB);';

        qryMZD.ParamByName('AUTOINCREM').AsString   := TAutcomTintaFactory.Get.fRetAutoIncrem('MZD_CADMZD', TAutcomTintaFactory.Get.GetCodEmp);
        qryMZD.ParamByName('MZD_CODEMP').AsString   := TAutcomTintaFactory.Get.GetCodEmp;
        qryMZD.ParamByName('MZD_CODIGO').AsString   := qryCadNfm.FieldByName('NFM_CODIGO').AsString;
        qryMZD.ParamByName('MZD_VARIAC').AsString   := qryCadNfm.FieldByName('NFM_VARIAC').AsString;
        qryMZD.ParamByName('MZD_DESCRI').AsString   := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
        qryMZD.ParamByName('MZD_OBSERV').AsString   := qryCadNfm.FieldByName('NFM_OBSERV').AsString;
        qryMZD.ParamByName('MZD_PESCOR').AsFloat    := qryCadNfm.FieldByName('NFM_PESCOR').AsFloat;
        qryMZD.ParamByName('MZD_PESFOR').AsFloat    := qryCadNfm.FieldByName('NFM_PESFOR').AsFloat;
        qryMZD.ParamByName('MZD_LINHA_').AsString   := qryCadNfm.FieldByName('NFM_LINHA_').AsString;
        qryMZD.ParamByName('MZD_CODMON').AsString   := qryCadNfm.FieldByName('NFM_CODMON').AsString;
        qryMZD.ParamByName('MZD_DTACAD').AsDateTime := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
        qryMZD.ParamByName('MZD_CODNFM').AsString   := qryCadNfm.FieldByName('NFM_CODIGO').AsString;
        qryMZD.ParamByName('MZD_ATIVAD').AsString   := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
        qryMZD.ParamByName('MZD_BAIQDI').AsString   := qryCadNfm.FieldByName('NFM_BAIQDI').AsString;
        qryMZD.ParamByName('MZD_ANOCOR').AsString   := qryCadNfm.FieldByName('NFM_ANOCOR').AsString;

        For intCont := 1 To 20 Do
        Begin
          If TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString) Then
            Break;

          qryMZD.ParamByName('MZD_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString);
          qryMZD.ParamByName('MZD_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat;
        End;

        qryMZD.ParamByName('MZD_UNIVER').AsString := qryCadNfm.FieldByName('NFM_UNIVER').AsString;
        qryMZD.ParamByName('MZD_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

        qryMZD.ExecSQL;

        GerarMd5CadMZD(qryCadNfm.FieldByName('NFM_CODIGO').AsString);

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

function TGravandoExecucaoMazaIndustrialNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoMazaIndustrialNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

procedure TGravandoExecucaoMazaIndustrialNovasFormulas.RemoverNovasFormulas;
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
          '   MZD_CADMZD                  ' +
          ' WHERE MZD_CODIGO IN           ' +
          '   (SELECT                     ' +
          '     NFM_CODIGO                ' +
          '   FROM                        ' +
          '     MZD_CADNFM)               ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE                                 ' +
          ' FROM                                   ' +
          '   MZD_CADMZD                           ' +
          ' WHERE MZD_CODIGO IN                    ' +
          '   (SELECT                              ' +
          '     NFM_CODIGO                         ' +
          '   FROM                                 ' +
          '     MZD_CADNFM                         ' +
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
