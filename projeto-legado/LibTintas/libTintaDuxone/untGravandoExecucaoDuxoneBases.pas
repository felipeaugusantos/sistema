{**************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta Duxone *}
{***********************************************************************AC*}
unit untGravandoExecucaoDuxoneBases;

interface

uses
  untAbstractGravandoExecucaoDuxone, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, untTipoCadastro,
  Classes, UniClientDataSet, DB, TypInfo, untStrUtils, System.StrUtils;

type
  TGravandoExecucaoDuxoneBases = class(TAbstractGravandoExecucaoDuxone)
  private
    function FBaseGerada(strCodBas: String): Boolean;
    function fQtdEmbalagemMl(strEmbalagem: String): String;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses
  untIConfTinta;

{ TGravandoExecucaoDuxoneBases }

procedure TGravandoExecucaoDuxoneBases.Executar(const gravando: IGravando);
Var
  stlFormulas: TStringList;
  txtArq     : TextFile;

  qryAux     : IDataSet;
  qryCadBas  : IDataSet;
  qryCadDel  : IDataSet;

  strPatDux  : String;
  strLinha   : String;
  strLin     : String;
  strCodBas  : String;
  intPosition: integer;

  intCont    : Integer;
  intLinha   : Integer;
  strDescri  : String;
begin

  Try

    Try
      if gravando.Status <> sgGravando then
        Exit;

      gravando.RegistrarProgresso(0, 0, 0);

      gravando.Texto := 'Validando Path de Arquivos ...';

      strPatDux := GetPath;

      If (Not FileExists(strPatDux)) Then
      Begin
        gravando.Texto := 'Path para o geração do arquivo de bases não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      gravando.Texto := 'Path validado com sucesso ...';

      gravando.Texto := 'Carregando dados...';


      gravando.Texto := 'Dados carregados com sucesso!';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('DUX_CADBAS');
      gravando.Texto := 'PROCOD verificado com sucesso!';


      stlFormulas := TStringList.Create;
      AssignFile(txtArq, strPatDux);
      Reset(txtArq);

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Excluindo os registros...';

      qryCadDel := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadDel.Close;
      qryCadDel.SQL  := 'DELETE FROM DUX_CADBAS; ';
      qryCadDel.ExecSQL;


      While not Eof (txtArq) do
      begin
        ReadLn(txtArq, strLin);
        stlFormulas.Add(strLin);
      end;

      CloseFile (txtArq);

      intLinha := 0;


      qryCadBas := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadBas.Close;
      qryCadBas.SQL  := 'SELECT * '+
                        '  FROM DUX_CADBAS '+
                        ' WHERE FALSE; ';
      qryCadBas.Open;


      qryAux := TAutcomTintaFactory.Get.fGetDataSet;

      While (intLinha < stlFormulas.Count) Do
      Begin
        if gravando.Status <> sgGravando then
          Exit;

        strLinha := stlFormulas[intLinha];

        Inc(intLinha);

        For intCont := 1 to 20 Do
        Begin
          strCodBas := fRetCampoBas('CODBAS', intCont, strLinha);

          if TStrUtils.fEmptyStr(strCodBas) Then
            Continue;

          If Not FBaseGerada(strCodBas) Then
            Continue;




          qryAux.Close;
          qryAux.SQL := 'SELECT * '+
                        '  FROM DUX_CADBAS '+
                        ' WHERE BAS_CODEMP = :CODEMP '+
                        '   AND BAS_CODBAS = :CODBAS ';
          qryAux.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryAux.ParamByName('CODBAS').AsString := strCodBas;

          qryAux.Open;

          If (qryAux.IsEmpty) Then
          Begin
            qryCadBas.Insert;
            qryCadBas.FieldByName('BAS_CODBAS').AsString := strCodBas;
            qryCadBas.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
            qryCadBas.FieldByName('BAS_PESESP').AsFloat  := TAutcomTintaFactory.Get.fStrToFloat(AnsiReplaceStr(fRetCampoBas('PESESP',intCont,strLinha),'.',','));

            intPosition := fRetornarStringPosition(fRetCampoBas('DESBAS',intCont,strLinha));

            qryCadBas.FieldByName('BAS_DESBAS').AsString := Copy(UpperCase(fRetCampoBas('DESBAS',intCont,strLinha)),0,intPosition - 1);
            strDescri := qryCadBas.FieldByName('BAS_DESBAS').AsString;

            If (Not TStrUtils.fEmptyStr(strCodBas)) And (TStrUtils.fEmptyStr(strDescri)) Then
              Gravando.Texto := 'Chegou';

            qryCadBas.FieldByName('BAS_EMBALA').AsFloat  := fRetEmbalagem(fRetCampoBas('EMBALA',intCont,strLinha));
            qryCadBas.FieldByName('BAS_QTDEMB').AsString := AnsiReplaceStr(fQtdEmbalagemMl(FloatToStrF(qryCadBas.FieldByName('BAS_EMBALA').AsFloat, ffNumber, 12, 0)), '.', '');
            qryCadBas.FieldByName('BAS_PESGRA').AsString := 'N';
            qryCadBas.FieldByName('BAS_TIPO__').AsString := UpperCase(fRetCampoBas('TIPO__',intCont,strLinha));
            qryCadBas.FieldByName('BAS_LINHA_').AsString := UpperCase(fRetCampoBas('LINHA_',intCont,strLinha));
            qryCadBas.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('DUX_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
            qryCadBas.Post;
          End;

        End;

        gravando.RegistrarProgresso(0, intLinha, stlFormulas.Count);
      End;

      //  Adiconado o diluente conforme solicitação do requisito 105992;

      qryCadBas.Insert;
      qryCadBas.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('DUX_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
      qryCadBas.FieldByName('BAS_CODBAS').AsString := 'DX32';
      qryCadBas.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
      qryCadBas.FieldByName('BAS_PESESP').AsFloat  := 0.880;
      qryCadBas.FieldByName('BAS_DESBAS').AsString := 'DX32-DUXONE THINNER';
      qryCadBas.FieldByName('BAS_EMBALA').AsFloat  := 1000;
      qryCadBas.FieldByName('BAS_QTDEMB').AsString  := '1000 ML';
      qryCadBas.FieldByName('BAS_PESGRA').AsString := 'N';
      qryCadBas.FieldByName('BAS_TIPO__').AsString := 'DILUENTE';
      qryCadBas.FieldByName('BAS_LINHA_').AsString := 'DUXONE';
      qryCadBas.Post;

    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;

  Finally
    If Assigned(stlFormulas) Then
      FreeAndNil(stlFormulas);
  End;

end;

function TGravandoExecucaoDuxoneBases.FBaseGerada(strCodBas: String): Boolean;
begin
  Result := True;

  If Pos(strCodBas, 'PP901_PP203_PP202_DX5131_PP204_PP701_PP201_PP402_PP503_PP504_PP601_' +
    'PP501_PP502_PP301_PP302_AXT100_AXT101_AXT102_AXT103_AXT104_AXT105_AXT107_') > 0 Then
    Result := False;
end;

function TGravandoExecucaoDuxoneBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;



function TGravandoExecucaoDuxoneBases.fQtdEmbalagemMl(
  strEmbalagem: String): String;
begin
  Result := Trim(strEmbalagem) + ' ML';
end;

end.
