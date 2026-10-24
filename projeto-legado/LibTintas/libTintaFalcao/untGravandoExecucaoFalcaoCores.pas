{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta falcão*}
{***************************************************************************PH*}
unit untGravandoExecucaoFalcaoCores;

interface

uses
  untAbstractGravandoExecucaoFalcao, untIGravando, SysUtils, untIDataSet,System.Classes,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, Dialogs, StrUtils, untStrUtils,
  Variants;
type
  TGravandoExecucaoFalcaoCores = class(TAbstractGravandoExecucaoFalcao)
  private
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;

    function fRetCodigo(strValor : String) : String;
    function fRetLinha(strValor : String) : String;
    function fRetDescricaoLinha(strCodBas, strCodUni, strCodLin : String ) : String;

    function fRetFator(strUnidade : String) : Double;
    function fRetPesoEspecifico(strColorante : String ) : Double;

  end;

implementation

{ TGravandoExecucaoFalcaoCores}

uses untFuncoesGenerica;

procedure TGravandoExecucaoFalcaoCores.Executar(const gravando: IGravando);
Const
  arrCodUni: Array [0..2] Of String = ('LT','GL','BD');
var

  slArquivo     : TStringList;
  slQuebraLinha : TStringList;
  slColorantes  : TStringList;
  slQuantidades : TStringList;

  qryCadCor     : IDataSet;

  intCont       : integer;
  intProcesso   : Integer;
  intColorantes : Integer;
  intUnidade    : Integer;
  strCodBase    : String;
begin
  Try
    Try
      gravando.Texto := 'Validando Arquivo de Geração...';

      If Not DirectoryExists(GetPath)  Then
      Begin
        gravando.Texto := 'Arquivo para a geração das Cores não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      gravando.Texto := 'Arquivo Validado com Sucesso ...';

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('FAL_CADFAL');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Iniciando Geração do Cadastro de Cores...';

      slArquivo     := TStringList.Create;
      slQuebraLinha := TStringList.Create;

      slColorantes  := TStringList.Create;
      slQuantidades := TStringList.Create;

      slArquivo.LoadFromFile(GetPath + '\FORMULAS.txt');

      intProcesso := 0;

      for intCont := 0 to slArquivo.Count - 1 do
      begin
        if gravando.Status <> sgGravando then
          Exit;

        qryCadCor := TAutcomTintaFactory.Get.fGetDataSet;

        slQuebraLinha.Delimiter := '|';
        slQuebraLinha.StrictDelimiter := True;
        slQuebraLinha.DelimitedText := slArquivo[intCont];

        strCodBase := Copy(slQuebraLinha[3], pos('-',slQuebraLinha[3])+1, length(slQuebraLinha[3]));

        For intUnidade := 0 To 2 Do
        Begin

          qryCadCor.Close;
          qryCadCor.SQL := 'SELECT * '+
                           '  FROM FAL_CADFAL '+
                           ' WHERE FAL_BASE__ = :BASE__ '+
                           '   AND FAL_CODUNI = :CODUNI '+
                           '   AND FAL_LINHA_ = :LINHA_ '+
                           '   AND FAL_CODIGO = :CODIGO ';
          qryCadCor.ParamByName('BASE__').AsString := strCodBase;
          qryCadCor.ParamByName('CODUNI').AsString := arrCodUni[intUnidade];
          qryCadCor.ParamByName('LINHA_').AsString := fRetLinha(slQuebraLinha[0]);
          qryCadCor.ParamByName('CODIGO').AsString := fRetCodigo(slQuebraLinha[0]);
          qryCadCor.Open;

          If (qryCadCor.IsEmpty) Then
          Begin
            qryCadCor.Insert;
            qryCadCor.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('FAL_CADFAL', TAutcomTintaFactory.Get.GetCodEmp);
            qryCadCor.FieldByName('FAL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
            qryCadCor.FieldByName('FAL_CODIGO').AsString := fRetCodigo(slQuebraLinha[0]);
            qryCadCor.FieldByName('FAL_CODUNI').AsString := arrCodUni[intUnidade];
            qryCadCor.FieldByName('FAL_DESCRI').AsString := fRetDescricaoLinha(strCodBase, arrCodUni[intUnidade], fRetLinha(slQuebraLinha[0])) + ' '+ slQuebraLinha[1];
            qryCadCor.FieldByName('FAL_DTACAD').AsDate   := date;
            qryCadCor.FieldByName('FAL_LINHA_').AsString := fRetLinha(slQuebraLinha[0]);
            qryCadCor.FieldByName('FAL_BASE__').AsString := strCodBase;

            slColorantes.Delimiter := ';';
            slColorantes.StrictDelimiter := True;
            slColorantes.DelimitedText := slQuebraLinha[4];

            For intColorantes := 0 To slColorantes.Count - 1 Do
            Begin
              qryCadCor.FieldByName('FAL_FORM'+ TStrUtils.fStrZero(intColorantes + 1, 2)).AsString := slColorantes[intColorantes];
            End;

            slQuantidades.Delimiter := ';';
            slQuantidades.StrictDelimiter := True;
            slQuantidades.DelimitedText := slQuebraLinha[5];

            For intColorantes := 0 To slQuantidades.Count - 1 Do
            Begin
              qryCadCor.FieldByName('FAL_QTDC'+ TStrUtils.fStrZero(intColorantes + 1, 2)).AsFloat :=
                TAutcomTintaFactory.Get.fStrToFloat(AnsiReplaceStr(slQuantidades[intColorantes], '.', ',')) * fRetFator(arrCodUni[intUnidade]) * fRetPesoEspecifico(slColorantes[intColorantes]);
            End;

            qryCadCor.FieldByName('FAL_MD5KEY').AsString := GetMD5(qryCadCor.FieldByName('FAL_CODIGO').AsString +
                                                                   qryCadCor.FieldByName('FAL_BASE__').AsString +
                                                                   qryCadCor.FieldByName('FAL_CODUNI').AsString +
                                                                   qryCadCor.FieldByName('FAL_LINHA_').AsString);
            qryCadCor.Post;
          End;
        End;

        Inc(intProcesso);
        gravando.RegistrarProgresso(0, intProcesso, slArquivo.Count);
      End;


    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally
    If Assigned(slArquivo) Then FreeAndNil(slArquivo);
    If Assigned(slQuebraLinha) Then FreeAndNil(slQuebraLinha);
    If Assigned(slColorantes) Then FreeAndNil(slColorantes);
    If Assigned(slQuantidades) Then FreeAndNil(slQuantidades);


  End;
end;

function TGravandoExecucaoFalcaoCores.fRetPesoEspecifico(strColorante: String): Double;
Var
  qryAux : IDataSet;
begin
  qryAux := TAutcomTintaFactory.Get.fGetDataSet;
  qryAux.SQL := 'SELECT COL_PESESP '+
                '  FROM FAL_CADCOL '+
                ' WHERE COL_CODCOL = :CODCOL ';
  qryAux.ParamByName('CODCOL').AsString := strColorante;
  qryAux.Open;

  Result := qryAux.FieldByName('COL_PESESP').AsFloat;

end;

function TGravandoExecucaoFalcaoCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;


function TGravandoExecucaoFalcaoCores.fRetCodigo(strValor: String): String;
begin
  Result := Copy(strValor, Pos('-',strValor) + 1 ,length(strValor));
end;

function TGravandoExecucaoFalcaoCores.fRetDescricaoLinha(strCodBas, strCodUni,strCodLin: String): String;
Var
  qryCadBas : IDataSet;
begin
  qryCadBas := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadBas.SQL := 'SELECT BAS_DESLIN '+
                   '  FROM FAL_CADBAS'+
                   ' WHERE BAS_DESCRI = :CODBAS'+
                   '   AND BAS_CODUNI = :CODUNI'+
                   '   AND BAS_LINHA_ = :LINHA_';
  qryCadBas.ParamByName('CODBAS').AsString := strCodBas;
  qryCadBas.ParamByName('CODUNI').AsString := strCodUni;
  qryCadBas.ParamByName('LINHA_').AsString := strCodLin;
  qryCadBas.Open;

  Result := qryCadBas.FieldByName('BAS_DESLIN').AsString;
end;

function TGravandoExecucaoFalcaoCores.fRetFator(strUnidade: String): Double;
begin
  Result := 1;

  If strUnidade =  'GL' Then
    Result := 4
  Else
  If strUnidade =  'BD' Then
    Result := 20;
end;

function TGravandoExecucaoFalcaoCores.fRetLinha(strValor: String): String;
begin
  Result := Trim(Copy(strValor, 0, pos('-', strValor) - 1));
end;

end.

