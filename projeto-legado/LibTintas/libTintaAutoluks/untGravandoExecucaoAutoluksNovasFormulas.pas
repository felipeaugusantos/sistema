{***********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta Autoluks *}
{********************************************************************************AC*}
unit untGravandoExecucaoAutoluksNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math;

type
  TGravandoExecucaoAutoluksNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm: string;
    procedure RemoverNovasFormulas();
    procedure GerarMd5CadALK(strCodNfm : String);
  public
    constructor Create(const strCodNfm: string = '');
    function fGetNomeGravacao: string;
    procedure Executar(const gravando: IGravando);
    function fHabilitaOpcao(): Boolean;

  end;

implementation

uses
  untStatusGravando, untFuncoesGenerica;

{ TGravandoExecucaoAutoluksNovasFormulas }

constructor TGravandoExecucaoAutoluksNovasFormulas.Create(
  const strCodNfm: string);
begin
  inherited Create();
  Self.strCodNfm := strCodNfm;
end;

procedure TGravandoExecucaoAutoluksNovasFormulas.GerarMd5CadALK(strCodNfm : String);
var
  qrySelect: IDataSet;
  strMd5: String;
  intContador: Integer;
begin

  qrySelect := TAutcomTintaFactory.Get.fGetDataSet;
  qrySelect.SQL := 'SELECT *            '+
                   '  FROM ALK_CADALK   '+
                   ' WHERE ALK_CODIGO = ' + QuotedStr(strCodNfm);
  qrySelect.Open;

  qrySelect.First;

  While Not qrySelect.Eof Do
  Begin
    strMd5 := '';

    strMd5 := strMd5 + qrySelect.FieldByName('ALK_CODIGO').AsString ;
    strMd5 := strMd5 + qrySelect.FieldByName('ALK_DESCRI').AsString ;
    strMd5 := strMd5 + qrySelect.FieldByName('ALK_PRODUT').AsString ;
    strMd5 := strMd5 + qrySelect.FieldByName('ALK_ACABAM').AsString ;
    strMd5 := strMd5 + qrySelect.FieldByName('ALK_VARIAN').AsString ;
    strMd5 := strMd5 + qrySelect.FieldByName('ALK_CORMON').AsString ;
    strMd5 := strMd5 + qrySelect.FieldByName('ALK_ANOINI').AsString ;
    strMd5 := strMd5 + qrySelect.FieldByName('ALK_ANOFIN').AsString ;
    strMd5 := strMd5 + qrySelect.FieldByName('ALK_VOLUME').AsString ;
    strMd5 := strMd5 + qrySelect.FieldByName('ALK_GRAMA_').AsString ;


    for intContador := 1 to 20 do
    begin
      strMd5 := strMd5 + qrySelect.FieldByName('ALK_BASE' + TStrUtils.fStrZero(IntToStr(intContador), 2)).AsString;
      strMd5 := strMd5 + StringReplace(FormatFloat('0.0000', qrySelect.FieldByName('ALK_QTDC' + TStrUtils.fStrZero(IntToStr(intContador), 2)).AsFloat),
        ',', '.', [rfReplaceAll]);
    end;

    strMd5 := GetMD5(strMd5);

    qrySelect.Edit;
    qrySelect.FieldByName('ALK_MD5KEY').AsString := strMd5;
    qrySelect.Post;

    qrySelect.Next;
  End;
end;


procedure TGravandoExecucaoAutoluksNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm: IDataSet;
  qryALK: IDataSet;
  intCont: Integer;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := 'SELECT * FROM ALK_CADNFM';

      if strCodNfm <> '' then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODIGO = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;

      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('ALK_CADALK');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      qryALK := TAutcomTintaFactory.Get.fGetDataSet;

      While (Not qryCadNfm.Eof) do
      begin
        If gravando.Status <> sgGravando Then
          Break;

        qryALK.SQL := TAutcomTintaFactory.Get.GetInsert('ALK_CADALK');

        qryALK.SQL := ' INSERT INTO ALK_CADALK (AUTOINCREM, '+
                      '                         ALK_CODEMP, '+
                      '                         ALK_ATIVAD, '+
                      '                         ALK_DTACAD, '+
                      '                         ALK_CODIGO, '+
                      '                         ALK_DESCRI, '+
                      '                         ALK_PRODUT, '+
                      '                         ALK_ACABAM, '+
                      '                         ALK_VARIAN, '+
                      '                         ALK_CORMON, '+
                      '                         ALK_ANOINI, '+
                      '                         ALK_ANOFIN, '+
                      '                         ALK_VOLUME, '+
                      '                         ALK_GRAMA_, '+
                      '                         ALK_CODMON, ';

        For intCont := 1 To 20 Do
        Begin
          qryALK.SQL := qryALK.SQL + ' ALK_BASE' + TStrUtils.fStrZero(intCont, 2) + ', '+
                                     ' ALK_QTDC' + TStrUtils.fStrZero(intCont, 2) + ', ';
        End;

        qryALK.SQL := qryALK.SQL + '          ALK_ACRMOB) '+
                                   ' VALUES (:AUTOINCREM, '+
                      '                      :ALK_CODEMP, '+
                      '                      :ALK_ATIVAD, '+
                      '                      :ALK_DTACAD, '+
                      '                      :ALK_CODIGO, '+
                      '                      :ALK_DESCRI, '+
                      '                      :ALK_PRODUT, '+
                      '                      :ALK_ACABAM, '+
                      '                      :ALK_VARIAN, '+
                      '                      :ALK_CORMON, '+
                      '                      :ALK_ANOINI, '+
                      '                      :ALK_ANOFIN, '+
                      '                      :ALK_VOLUME, '+
                      '                      :ALK_GRAMA_, '+
                      '                      :ALK_CODMON, ';

        For intCont := 1 To 20 Do
        Begin
          qryALK.SQL := qryALK.SQL + ' :ALK_BASE' + TStrUtils.fStrZero(intCont, 2) + ', ' +
                                     ' :ALK_QTDC' + TStrUtils.fStrZero(intCont, 2) + ', ';
        End;

        qryALK.SQL := qryALK.SQL + ' :ALK_ACRMOB);';

        qryALK.ParamByName('AUTOINCREM').AsString   := TAutcomTintaFactory.Get.fRetAutoIncrem('ALK_CADALK', TAutcomTintaFactory.Get.GetCodEmp);
        qryALK.ParamByName('ALK_CODEMP').AsString   := TAutcomTintaFactory.Get.GetCodEmp;
        qryALK.ParamByName('ALK_ATIVAD').AsString   := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
        qryALK.ParamByName('ALK_DTACAD').AsDateTime := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
        qryALK.ParamByName('ALK_CODIGO').AsString   := qryCadNfm.FieldByName('NFM_CODIGO').AsString;
        qryALK.ParamByName('ALK_DESCRI').AsString   := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
        qryALK.ParamByName('ALK_PRODUT').AsString   := qryCadNfm.FieldByName('NFM_PRODUT').AsString;
        qryALK.ParamByName('ALK_ACABAM').AsString   := qryCadNfm.FieldByName('NFM_ACABAM').AsString;
        qryALK.ParamByName('ALK_VARIAN').AsString   := qryCadNfm.FieldByName('NFM_VARIAN').AsString;
        qryALK.ParamByName('ALK_CORMON').AsString   := qryCadNfm.FieldByName('NFM_CORMON').AsString;
        qryALK.ParamByName('ALK_ANOINI').AsString   := qryCadNfm.FieldByName('NFM_ANOINI').AsString;
        qryALK.ParamByName('ALK_ANOFIN').AsString   := qryCadNfm.FieldByName('NFM_ANOFIN').AsString;
        qryALK.ParamByName('ALK_CODMON').AsString   := qryCadNfm.FieldByName('NFM_CODMON').AsString;
        qryALK.ParamByName('ALK_VOLUME').AsFloat    := 1000;
        qryALK.ParamByName('ALK_GRAMA_').AsFloat    := qryCadNfm.FieldByName('NFM_GRAMA_').AsFloat;

        For intCont := 1 To 20 Do
        Begin
          qryALK.ParamByName('ALK_BASE' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_BASE' + TStrUtils.fStrZero(intCont, 2)).AsString);
          qryALK.ParamByName('ALK_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat;
        End;

        qryALK.ParamByName('ALK_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

        qryALK.ExecSQL;

        GerarMd5CadALK(qryCadNfm.FieldByName('NFM_CODIGO').AsString);

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

function TGravandoExecucaoAutoluksNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoAutoluksNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

procedure TGravandoExecucaoAutoluksNovasFormulas.RemoverNovasFormulas;
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
          '   ALK_CADALK                  ' +
          ' WHERE ALK_CODIGO IN           ' +
          '   (SELECT                     ' +
          '     NFM_CODIGO                ' +
          '   FROM                        ' +
          '     ALK_CADNFM)               ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE  ALK_CADALK                               ' +
          ' FROM                                             ' +
          ' ALK_CADALK JOIN ALK_CADNFM ON ALK_CADNFM.NFM_CODIGO = ALK_CADALK.ALK_CODIGO ' +
          '   WHERE NFM_CODIGO = ' + QuotedStr(strCodNfm);
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
