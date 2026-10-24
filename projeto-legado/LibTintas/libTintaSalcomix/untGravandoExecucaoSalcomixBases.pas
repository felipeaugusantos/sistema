{**************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta Salcomix *}
{***********************************************************************AC*}
unit untGravandoExecucaoSalcomixBases;

interface

uses
  untAbstractGravandoExecucaoSalcomix, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, untTipoCadastro,
  Classes, StrUtils, Uni, InterBaseUniProvider,UniDataSetProvider, untSalcomixSQLServer;

type
  TGravandoExecucaoSalcomixBases = class(TAbstractGravandoExecucaoSalcomix)
  private
    procedure pImportarBases(qryBases: IDataSet; Gravando: IGravando);
    procedure pImportarBasesSQLServer(qryBases: IDataSet; Gravando: IGravando);
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses
  untIConfTinta, untStrUtils;

{ TGravandoExecucaoSalcomixBases }

procedure TGravandoExecucaoSalcomixBases.Executar(const gravando: IGravando);
Var
  qryBases: IDataSet;
begin
  Gravando.Texto := 'Carregando dados do Cadastro de Bases...';

  If (Gravando.Status <> sgGravando) Then
    Exit;

  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('SAL_CADBAS');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  Gravando.Texto := 'Verificando Calculo da formulação...';

  If Conf.fGet('CALFOR') = '0' Then
    Gravando.Texto := 'Carregando dados dos arquivos txt...'
  Else
    Gravando.Texto := 'Carregando dados SQL Server...';



  qryBases := TAutcomTintaFactory.Get.fGetDataSet;
  qryBases.SQL := '   SELECT * FROM SAL_CADBAS    ';
  qryBases.Open;

  Gravando.Texto := 'Processando Cadastro de Bases...';

  If (Gravando.Status <> sgGravando) Then
    Exit;

  Try
    Try
      If Conf.fGet('CALFOR') = '0' Then
        pImportarBases(qryBases, Gravando)
      Else
        pImportarBasesSQLServer(qryBases, Gravando);
    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        Exit;
      End;
    End;
  Finally

  End;

end;

function TGravandoExecucaoSalcomixBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

procedure TGravandoExecucaoSalcomixBases.pImportarBases(qryBases: IDataSet; Gravando: IGravando);
Var
  stlArquivo: TStringList;
  intContador: Integer;
  strLinha: String;
  strCodBas: String;
  strDesBas: String;
  fltPesEsp: Double;

  function fTentarRetornarEmbalagem(strDescri:String): Double;
    Var
      strChar:String;
      intPosicao: Integer;
      strEmbalagem:String;
  Begin
    strEmbalagem := '';
    intPosicao := Length(strDescri)-1;

     If (AnsiEndsText('L', strDescri)) Then
     Begin
        Repeat
          strChar := Copy(strDescri, intPosicao, 1);
          strEmbalagem := strChar + strEmbalagem;
          Dec(intPosicao);
        Until (strChar = ' ') Or (intPosicao = 0);

        If (intPosicao = 0) Then
          Result := 900
        Else
          Result := TAutcomTintaFactory.Get.fStrToFloat(Trim(strEmbalagem)) * 1000;

     End
     Else
      Result := 900;
  End;
begin
  Gravando.Texto := 'Verificando path do arquivo BASES.TXT...';

  If Not FileExists(SalcomixPath + '\BASES.TXT') Then
  Begin
    Gravando.Texto := Format('O path %s não existe ou não está configurado corretamente!', [AnsiReplaceStr(SalcomixPath + '\BASES.TXT', '"', '')]);
    Exit;
  End;

  Gravando.Texto := 'Path verificado com sucesso...';

  If (Gravando.Status <> sgGravando) Then
    Exit;

  stlArquivo := TStringList.Create;

  stlArquivo.LoadFromFile(SalcomixPath + '\BASES.TXT');

  Try
    Try
      For intContador := 0 To stlArquivo.Count -1 Do
      Begin

        If (Gravando.Status <> sgGravando) Then
          Break;

        strLinha := stlArquivo[intContador];

        strCodBas := Trim(Copy(strLinha, 18, 08));
        strDesBas := Trim(Copy(strLinha, 26, 44));
        fltPesEsp := TAutcomTintaFactory.Get.fStrToFloat(AnsiReplaceStr(Copy(strLinha, 97, 05), '.', ','));

        If (fltPesEsp > 0)  And (Pos('EMBALAGEM', strDesBas) <= 0)  And
         (Not qryBases.Locate('BAS_CODBAS', strCodBas, [])) Then
        Begin
          qryBases.Insert;
          qryBases.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('SAL_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
          qryBases.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryBases.FieldByName('BAS_CODBAS').AsString := strCodBas;
          qryBases.FieldByName('BAS_DESBAS').AsString := strDesBas;
          qryBases.FieldByName('BAS_PESBAS').AsFloat  := fltPesEsp;
          qryBases.FieldByName('BAS_EMBALA').AsFloat  := fTentarRetornarEmbalagem(strDesBas);
          qryBases.FieldByName('BAS_VALBAS').AsFloat  := 0.0;
          qryBases.Post;
        End;

        Gravando.RegistrarProgresso(0, intContador, stlArquivo.Count - 1);

      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        Exit;
      End;
    End;
  Finally
    If Assigned(stlArquivo) Then
      FreeAndNil(stlArquivo);
  End;

end;

procedure TGravandoExecucaoSalcomixBases.pImportarBasesSQLServer(
  qryBases: IDataSet; Gravando: IGravando);
Var
  SalcomixBases: TBasesSalcoMixSQLServer;
begin
  SalcomixBases := TBasesSalcoMixSQLServer.Create(qryBases);
  SalcomixBases.pGerarBases(Gravando);
  FreeAndNil(SalcomixBases);
end;

end.
