{***********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta AnjoAutomotiva *}
{********************************************************************************AC*}
unit untGravandoExecucaoAnjoAutomotivaNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math;

type
  TGravandoExecucaoAnjoAutomotivaNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm: string;
    procedure RemoverNovasFormulas();
    procedure GerarMd5CadAJT(strCodNfm : String);
  public
    constructor Create(const strCodNfm: string = '');
    function fGetNomeGravacao: string;
    procedure Executar(const gravando: IGravando);
    function fHabilitaOpcao(): Boolean;

  end;

implementation

uses
  untStatusGravando, untFuncoesGenerica;

{ TGravandoExecucaoAnjoAutomotivaNovasFormulas }

constructor TGravandoExecucaoAnjoAutomotivaNovasFormulas.Create(
  const strCodNfm: string);
begin
  inherited Create();
  Self.strCodNfm := strCodNfm;
end;

procedure TGravandoExecucaoAnjoAutomotivaNovasFormulas.GerarMd5CadAJT(strCodNfm : String);
var
  qrySelect: IDataSet;
  strMd5: String;
  intContador: Integer;
begin

  qrySelect := TAutcomTintaFactory.Get.fGetDataSet;
  qrySelect.SQL := 'SELECT *            '+
                   '  FROM AJT_CADAJT   '+
                   ' WHERE AJT_CODIGO = ' + QuotedStr(strCodNfm);
  qrySelect.Open;

  qrySelect.First;

  While Not qrySelect.Eof Do
  Begin
    strMd5 := '';

    strMd5 := strMd5 + qrySelect.FieldByName('AJT_CODIGO').AsString ;
    strMd5 := strMd5 + qrySelect.FieldByName('AJT_DESCRI').AsString ;
    strMd5 := strMd5 + qrySelect.FieldByName('AJT_PRODUT').AsString ;
    strMd5 := strMd5 + qrySelect.FieldByName('AJT_ACABAM').AsString ;
    strMd5 := strMd5 + qrySelect.FieldByName('AJT_VARIAC').AsString ;
    strMd5 := strMd5 + qrySelect.FieldByName('AJT_CODMON').AsString ;
    strMd5 := strMd5 + qrySelect.FieldByName('AJT_CORMON').AsString ;
    strMd5 := strMd5 + qrySelect.FieldByName('AJT_ANOINI').AsString ;
    strMd5 := strMd5 + qrySelect.FieldByName('AJT_ANOFIM').AsString ;
    strMd5 := strMd5 + qrySelect.FieldByName('AJT_VOLUME').AsString ;
    strMd5 := strMd5 + qrySelect.FieldByName('AJT_GRAMA_').AsString ;


    for intContador := 1 to 20 do
    begin
      strMd5 := strMd5 + qrySelect.FieldByName('AJT_FORM' + TStrUtils.fStrZero(IntToStr(intContador), 2)).AsString;
      strMd5 := strMd5 + StringReplace(FormatFloat('0.0000', qrySelect.FieldByName('AJT_QTDC' + TStrUtils.fStrZero(IntToStr(intContador), 2)).AsFloat),
        ',', '.', [rfReplaceAll]);
    end;

    strMd5 := GetMD5(strMd5);

    qrySelect.Edit;
    qrySelect.FieldByName('AJT_MD5KEY').AsString := strMd5;
    qrySelect.Post;

    qrySelect.Next;
  End;
end;


procedure TGravandoExecucaoAnjoAutomotivaNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm: IDataSet;
  qryAJT: IDataSet;
  intCont: Integer;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := 'SELECT * FROM AJT_CADNFM';

      if strCodNfm <> '' then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODIGO = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;

      If gravando.Status <> sgGravando Then
        Exit;

      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('AJT_CADAJT');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      qryAJT := TAutcomTintaFactory.Get.fGetDataSet;

      while (not qryCadNfm.Eof) and (gravando.Status = sgGravando) do
      begin
        If gravando.Status <> sgGravando Then
          Exit;

        qryAJT.SQL := TAutcomTintaFactory.Get.GetInsert('AJT_CADAJT');

        qryAJT.SQL := ' INSERT INTO AJT_CADAJT (AUTOINCREM, '+
                      '                         AJT_CODEMP, '+
                      '                         AJT_ATIVAD, '+
                      '                         AJT_DTACAD, '+
                      '                         AJT_CODIGO, '+
                      '                         AJT_DESCRI, '+
                      '                         AJT_PRODUT, '+
                      '                         AJT_ACABAM, '+
                      '                         AJT_VARIAC, '+
                      '                         AJT_CORMON, '+
                      '                         AJT_CODMON, '+
                      '                         AJT_ANOINI, '+
                      '                         AJT_ANOFIM, '+
                      '                         AJT_MODELO, '+
                      '                         AJT_OBSERV, '+
                      '                         AJT_VOLUME, '+
                      '                         AJT_GRAMA_, ';

        For intCont := 1 To 20 Do
        Begin
          qryAJT.SQL := qryAJT.SQL + ' AJT_FORM' + TStrUtils.fStrZero(intCont, 2) + ', '+
                                     ' AJT_QTDC' + TStrUtils.fStrZero(intCont, 2) + ', ';
        End;

        qryAJT.SQL := qryAJT.SQL + '          AJT_ACRMOB) '+
                                   ' VALUES (:AUTOINCREM, '+
                      '                      :AJT_CODEMP, '+
                      '                      :AJT_ATIVAD, '+
                      '                      :AJT_DTACAD, '+
                      '                      :AJT_CODIGO, '+
                      '                      :AJT_DESCRI, '+
                      '                      :AJT_PRODUT, '+
                      '                      :AJT_ACABAM, '+
                      '                      :AJT_VARIAC, '+
                      '                      :AJT_CORMON, '+
                      '                      :AJT_CODMON, '+
                      '                      :AJT_ANOINI, '+
                      '                      :AJT_ANOFIM, '+
                      '                      :AJT_MODELO, '+
                      '                      :AJT_OBSERV, '+
                      '                      :AJT_VOLUME, '+
                      '                      :AJT_GRAMA_, ';

        For intCont := 1 To 20 Do
        Begin
          qryAJT.SQL := qryAJT.SQL + ' :AJT_FORM' + TStrUtils.fStrZero(intCont, 2) + ', ' +
                                     ' :AJT_QTDC' + TStrUtils.fStrZero(intCont, 2) + ', ';
        End;

        qryAJT.SQL := qryAJT.SQL + ' :AJT_ACRMOB);';

        qryAJT.ParamByName('AUTOINCREM').AsString   := TAutcomTintaFactory.Get.fRetAutoIncrem('AJT_CADAJT', TAutcomTintaFactory.Get.GetCodEmp);
        qryAJT.ParamByName('AJT_CODEMP').AsString   := TAutcomTintaFactory.Get.GetCodEmp;
        qryAJT.ParamByName('AJT_ATIVAD').AsString   := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
        qryAJT.ParamByName('AJT_DTACAD').AsDateTime := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
        qryAJT.ParamByName('AJT_CODIGO').AsString   := qryCadNfm.FieldByName('NFM_CODIGO').AsString;
        qryAJT.ParamByName('AJT_DESCRI').AsString   := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
        qryAJT.ParamByName('AJT_PRODUT').AsString   := qryCadNfm.FieldByName('NFM_PRODUT').AsString;
        qryAJT.ParamByName('AJT_ACABAM').AsString   := qryCadNfm.FieldByName('NFM_ACABAM').AsString;
        qryAJT.ParamByName('AJT_VARIAC').AsString   := qryCadNfm.FieldByName('NFM_VARIAC').AsString;
        qryAJT.ParamByName('AJT_CORMON').AsString   := qryCadNfm.FieldByName('NFM_CORMON').AsString;
        qryAJT.ParamByName('AJT_CODMON').AsString   := qryCadNfm.FieldByName('NFM_CODMON').AsString;
        qryAJT.ParamByName('AJT_ANOINI').AsString   := qryCadNfm.FieldByName('NFM_ANOINI').AsString;
        qryAJT.ParamByName('AJT_ANOFIM').AsString   := qryCadNfm.FieldByName('NFM_ANOFIM').AsString;
        qryAJT.ParamByName('AJT_MODELO').AsString   := qryCadNfm.FieldByName('NFM_MODELO').AsString;
        qryAJT.ParamByName('AJT_OBSERV').AsString   := qryCadNfm.FieldByName('NFM_OBSERV').AsString;
        qryAJT.ParamByName('AJT_VOLUME').AsFloat    := qryCadNfm.FieldByName('NFM_VOLUME').AsFloat;
        qryAJT.ParamByName('AJT_GRAMA_').AsFloat    := qryCadNfm.FieldByName('NFM_GRAMA_').AsFloat;

        For intCont := 1 To 20 Do
        Begin
          If TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString) Then
            Break;

          qryAJT.ParamByName('AJT_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString);
          qryAJT.ParamByName('AJT_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat;
        End;

        qryAJT.ParamByName('AJT_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

        qryAJT.ExecSQL;

        GerarMd5CadAJT(qryCadNfm.FieldByName('NFM_CODIGO').AsString);

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

function TGravandoExecucaoAnjoAutomotivaNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoAnjoAutomotivaNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

procedure TGravandoExecucaoAnjoAutomotivaNovasFormulas.RemoverNovasFormulas;
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
          '   AJT_CADAJT                  ' +
          ' WHERE AJT_CODIGO IN           ' +
          '   (SELECT                     ' +
          '     NFM_CODIGO                ' +
          '   FROM                        ' +
          '     AJT_CADNFM)               ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE                                 ' +
          ' FROM                                   ' +
          '   AJT_CADAJT                           ' +
          ' WHERE AJT_CODIGO IN                    ' +
          '   (SELECT                              ' +
          '     NFM_CODIGO                         ' +
          '   FROM                                 ' +
          '     AJT_CADNFM                         ' +
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
